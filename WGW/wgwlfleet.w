&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic_bran         PROGRESS
*/
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*------------------------------------------------------------------------
/* Connected Databases : sic_test         PROGRESS                      */
  File:   Description: 
  Input Parameters:  <none>
  Output Parameters: <none>
  Author:  Created: 
  ------------------------------------------------------------------------*/
/*          This .W file was created with the Progress AppBuilder.      */
/*----------------------------------------------------------------------*/
/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */
CREATE WIDGET-POOL.
/* ***************************  Definitions  **************************    */  
/* Parameters Definitions ---                                              */  
/* Local Variable Definitions ---                                          */  
/*******************************/                                          
/*programid   : wgwlfleet.w                                               */  
/*programname : load text file Fleet                                      */  
/*Create by  : Ranu I. A64-0369  โหลดไฟล์ข้อมูลงาน Fleet เข้า GW          */ 
/*Modify by  : Ranu I. A65-0043  เพิ่มเงื่อนไขการเช็ค class รถหางพ่วง ไม่ต้องระบุที่นั่ง 
               เพิ่มเงื่อนไขเคลียร์ค่าหน้า Vat ชมพู ของ Insured code กรณีระบุ Null */
/* Modify by   : Ranu I. A67-0029 เพิ่มการเก็บข้อมูลของรถไฟฟ้า      */
/* Modify by : Ranu I. F68-0001 เพิ่มเงื่อนไขการ Adj PA = YES,NO     */
/* Modify by : Ranu I. A68-0044 เพิ่มเงื่อนไขการตรวจสอบข้อมูล ICE   */
/*-------------------------------------------------------------------------*/
SESSION:MULTITASKING-INTERVAL = 1 .                                        
DEF VAR gv_id AS CHAR FORMAT "X(15)" NO-UNDO.    
DEF VAR nv_pwd AS CHAR  FORMAT "x(15)" NO-UNDO.  
DEF VAR nv_total AS INT INIT 0.                   
DEF VAR n_chkvat AS LOGICAL INIT NO.
DEF VAR nv_instot AS INT INIT 0.
DEF VAR n_addr AS CHAR FORMAT "x(250)" .
DEF VAR n_yr AS INT INIT 0. 
DEF VAR re_base3 AS DECI.
DEF VAR dod0 AS INTEGER init 0.
DEF VAR dod1 AS INTEGER init 0.
DEF VAR dod2 AS INTEGER init 0.
DEF VAR dpd0 AS INTEGER init 0.
{wgw\wgwlfleet.i}      /*ประกาศตัวแปร*/

DEFINE VAR nv_mv411 AS DECIMAL.
DEFINE VAR nv_mv412 AS DECIMAL.
DEFINE VAR nv_mv42  AS DECIMAL.
DEFINE VAR nv_mv43  AS DECIMAL.
DEF VAR nv_411t   AS DECIMAL.    
DEF VAR nv_412t   AS DECIMAL.    
DEF VAR nv_42t    AS DECIMAL.    
DEF VAR nv_43t   AS DECIMAL.
DEF VAR nv_ry31  AS DECIMAL. /* A68-0044*/
DEF VAR nv_count AS INT INIT 0 .
DEF VAR nv_proid AS CHAR FORMAT "x(50)" .
DEF VAR nv_date AS CHAR FORMAT "x(8)" INIT "" .
DEF VAR nv_error AS CHAR FORMAT "x(100)" INIT "" .

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main
&Scoped-define BROWSE-NAME br_impdata_fil

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES impdata_fil

/* Definitions for BROWSE br_impdata_fil                                */
&Scoped-define FIELDS-IN-QUERY-br_impdata_fil impdata_fil.comment impdata_fil.riskno impdata_fil.itemno impdata_fil.redbook impdata_fil.policyno impdata_fil.poltyp impdata_fil.appenno impdata_fil.comdat impdata_fil.expdat impdata_fil.packcod impdata_fil.covcod impdata_fil.garage impdata_fil.insref impdata_fil.tiname impdata_fil.insnam impdata_fil.lastname impdata_fil.name2 impdata_fil.name3 impdata_fil.addr impdata_fil.tambon impdata_fil.amper impdata_fil.country impdata_fil.post   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_impdata_fil   
&Scoped-define SELF-NAME br_impdata_fil
&Scoped-define QUERY-STRING-br_impdata_fil FOR EACH impdata_fil
&Scoped-define OPEN-QUERY-br_impdata_fil OPEN QUERY br_impdata_fil FOR EACH impdata_fil.
&Scoped-define TABLES-IN-QUERY-br_impdata_fil impdata_fil
&Scoped-define FIRST-TABLE-IN-QUERY-br_impdata_fil impdata_fil


/* Definitions for FRAME fr_main                                        */
&Scoped-define OPEN-BROWSERS-IN-QUERY-fr_main ~
    ~{&OPEN-QUERY-br_impdata_fil}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS br_impdata_fil tg_format fi_loaddat fi_pack ~
fi_bchno fi_prevbat fi_bchyr fi_filename bu_file fi_output1 fi_output2 ~
fi_output3 buok bu_exit fi_outputpro ra_match ra_type tg_flag RECT-372 ~
RECT-374 RECT-376 RECT-377 RECT-378 RECT-380 
&Scoped-Define DISPLAYED-OBJECTS tg_format fi_loaddat fi_pack fi_bchno ~
fi_prevbat fi_bchyr fi_filename fi_output1 fi_output2 fi_output3 fi_process ~
fi_outputpro fi_impcnt fi_completecnt fi_premtot fi_premsuc ra_match ~
ra_type tg_flag 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON buok 
     LABEL "OK" 
     SIZE 12 BY 1.14
     FONT 6.

DEFINE BUTTON bu_exit 
     LABEL "EXIT" 
     SIZE 12 BY 1.14
     FONT 6.

DEFINE BUTTON bu_file 
     LABEL "...." 
     SIZE 5 BY .91.

DEFINE VARIABLE fi_bchno AS CHARACTER FORMAT "X(19)":U 
     VIEW-AS FILL-IN 
     SIZE 20.5 BY 1
     BGCOLOR 19 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_bchyr AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 10 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_completecnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY .91
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_impcnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY .91
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_loaddat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_output1 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY .91
     BGCOLOR 19  NO-UNDO.

DEFINE VARIABLE fi_output2 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY .91
     BGCOLOR 19  NO-UNDO.

DEFINE VARIABLE fi_output3 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY .91
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_outputpro AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY .91
     BGCOLOR 19  NO-UNDO.

DEFINE VARIABLE fi_pack AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 3.5 BY .91
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_premsuc AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY .91
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_premtot AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY .91
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_prevbat AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 18.5 BY .91
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_process AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 60.17 BY .95
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_match AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "1", 1,
"2", 2
     SIZE 2.5 BY 2.48
     BGCOLOR 29 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE ra_type AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "NEW", 1,
"RENEW", 2
     SIZE 37 BY 1.1
     BGCOLOR 21  NO-UNDO.

DEFINE RECTANGLE RECT-372
     EDGE-PIXELS 2 GRAPHIC-EDGE    ROUNDED 
     SIZE 130.5 BY 22.29
     BGCOLOR 19 FGCOLOR 1 .

DEFINE RECTANGLE RECT-374
     EDGE-PIXELS 2 GRAPHIC-EDGE    ROUNDED 
     SIZE 128.5 BY 11.52
     BGCOLOR 29 FGCOLOR 3 .

DEFINE RECTANGLE RECT-376
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 126 BY 2.33
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-377
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 15 BY 2
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-378
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 15 BY 2
     BGCOLOR 6 FGCOLOR 1 .

DEFINE RECTANGLE RECT-380
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 94.5 BY 6.43
     BGCOLOR 10 FGCOLOR 3 .

DEFINE VARIABLE tg_flag AS LOGICAL INITIAL no 
     LABEL "" 
     VIEW-AS TOGGLE-BOX
     SIZE 2.5 BY 1
     BGCOLOR 8 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE tg_format AS LOGICAL INITIAL no 
     LABEL "Export Header Format Load" 
     VIEW-AS TOGGLE-BOX
     SIZE 25.5 BY .81
     BGCOLOR 19 FONT 1 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_impdata_fil FOR 
      impdata_fil SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_impdata_fil
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_impdata_fil C-Win _FREEFORM
  QUERY br_impdata_fil DISPLAY
      impdata_fil.comment     COLUMN-LABEL "Comment "        format "x(75)"
impdata_fil.riskno      COLUMN-LABEL "Risk"  
impdata_fil.itemno      COLUMN-LABEL "Item" 
impdata_fil.redbook     COLUMN-LABEL "Redbook"   FORMAT "x(15)"
impdata_fil.policyno    column-label "Policy no"       format "x(15)"
impdata_fil.poltyp      column-label "Poltyp"          format "x(3)"
impdata_fil.appenno     column-label "Notification"    format "x(20)"
impdata_fil.comdat      column-label "Comm.date"       format "99/99/9999"
impdata_fil.expdat      column-label "Exp date"        format "99/99/9999"
impdata_fil.packcod     column-label "Package "        format "x(15)"
impdata_fil.covcod      column-label "Cover"           format "x(3)"
impdata_fil.garage      column-label "Garage"          format "x(10)"
impdata_fil.insref      column-label "Insured no."     format "x(12)"
impdata_fil.tiname      column-label "Title"           format "x(20)"
impdata_fil.insnam      column-label "Name"            format "x(50)"
impdata_fil.lastname    column-label "Last Name"       format "x(50)"
impdata_fil.name2       column-label "Name 2"          format "x(50)"
impdata_fil.name3       column-label "Name 3 "         format "x(50)"
impdata_fil.addr        column-label "Address1"        format "x(50)"
impdata_fil.tambon      column-label "Address2"        format "x(50)"
impdata_fil.amper       column-label "Address3"        format "x(50)"
impdata_fil.country     column-label "Address4"        format "x(50)"
impdata_fil.post        column-label "Post code"       format "x(50)"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 126 BY 8.33
         BGCOLOR 15 FGCOLOR 1 FONT 6 ROW-HEIGHT-CHARS .62.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     br_impdata_fil AT ROW 13.38 COL 4 WIDGET-ID 100
     tg_format AT ROW 11.71 COL 105.5 WIDGET-ID 54
     fi_loaddat AT ROW 4.29 COL 32.67 COLON-ALIGNED NO-LABEL
     fi_pack AT ROW 4.24 COL 65.83 COLON-ALIGNED NO-LABEL
     fi_bchno AT ROW 22.52 COL 16 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_prevbat AT ROW 5.38 COL 32.5 COLON-ALIGNED NO-LABEL
     fi_bchyr AT ROW 5.33 COL 65.67 COLON-ALIGNED NO-LABEL
     fi_filename AT ROW 6.81 COL 31.83 COLON-ALIGNED NO-LABEL
     bu_file AT ROW 6.81 COL 95
     fi_output1 AT ROW 7.81 COL 31.83 COLON-ALIGNED NO-LABEL
     fi_output2 AT ROW 8.76 COL 31.83 COLON-ALIGNED NO-LABEL
     fi_output3 AT ROW 10.67 COL 31.83 COLON-ALIGNED NO-LABEL
     buok AT ROW 7.62 COL 114.17
     bu_exit AT ROW 9.67 COL 114.17
     fi_process AT ROW 11.62 COL 31.83 COLON-ALIGNED NO-LABEL
     fi_outputpro AT ROW 9.71 COL 31.83 COLON-ALIGNED NO-LABEL
     fi_impcnt AT ROW 22.05 COL 60.33 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_completecnt AT ROW 22.95 COL 60.33 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_premtot AT ROW 22.05 COL 98.17 NO-LABEL NO-TAB-STOP 
     fi_premsuc AT ROW 22.95 COL 96.17 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     ra_match AT ROW 2.91 COL 103 NO-LABEL WIDGET-ID 26
     ra_type AT ROW 2.95 COL 34.5 NO-LABEL WIDGET-ID 18
     tg_flag AT ROW 5.52 COL 103.5 WIDGET-ID 40
     "     Total Record :":60 VIEW-AS TEXT
          SIZE 17.5 BY .91 AT ROW 22.05 COL 42.33
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "แพ็คเกจ :" VIEW-AS TEXT
          SIZE 9.17 BY .91 AT ROW 4.24 COL 58.33
          BGCOLOR 19 FGCOLOR 1 FONT 6
     " Load Text File" VIEW-AS TEXT
          SIZE 23.5 BY 1.24 AT ROW 2.91 COL 105.5 WIDGET-ID 34
          BGCOLOR 29 FGCOLOR 1 FONT 2
     "Output Check Producer :" VIEW-AS TEXT
          SIZE 24 BY .91 AT ROW 9.71 COL 9.67
          BGCOLOR 10 FGCOLOR 4 
     " วันที่โหลด :":35 VIEW-AS TEXT
          SIZE 11.83 BY .91 AT ROW 4.29 COL 22.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY .91 AT ROW 22.91 COL 117.17
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "นำเข้าข้อมูล (.CSV) :" VIEW-AS TEXT
          SIZE 18 BY .95 AT ROW 6.81 COL 15.67
          BGCOLOR 10 FGCOLOR 6 FONT 6
     "Success Net Premium :" VIEW-AS TEXT
          SIZE 22.33 BY .91 AT ROW 22.91 COL 74.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Output Data Error :" VIEW-AS TEXT
          SIZE 18.5 BY .91 AT ROW 8.76 COL 15.17
          BGCOLOR 10 FGCOLOR 4 
     "   Total Net Premium  :" VIEW-AS TEXT
          SIZE 21.5 BY .91 AT ROW 22.05 COL 75.33
          BGCOLOR 8 FGCOLOR 1 FONT 6
     " Match Policy No." VIEW-AS TEXT
          SIZE 23.67 BY 1.24 AT ROW 4.14 COL 105.33 WIDGET-ID 36
          BGCOLOR 29 FGCOLOR 1 FONT 2
     "Batch Year :" VIEW-AS TEXT
          SIZE 12.5 BY .91 AT ROW 5.33 COL 55
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "์New Tariff Calculate" VIEW-AS TEXT
          SIZE 21.67 BY 1 AT ROW 5.52 COL 106 WIDGET-ID 42
          BGCOLOR 8 FGCOLOR 6 
     "Output Data Load :" VIEW-AS TEXT
          SIZE 18.5 BY .91 AT ROW 7.81 COL 15.17
          BGCOLOR 10 FGCOLOR 4 
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY .91 AT ROW 22.05 COL 117.17
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "IMPORT TEXT FILE MOTOR FLEET NEW (V70)" VIEW-AS TEXT
          SIZE 61.5 BY .95 AT ROW 1.19 COL 3
          BGCOLOR 29 FGCOLOR 2 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
         BGCOLOR 29 FONT 6.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "Previous Batch No.  :" VIEW-AS TEXT
          SIZE 21.17 BY .91 AT ROW 5.38 COL 13.17
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Batch File Transfer :" VIEW-AS TEXT
          SIZE 19.83 BY .91 AT ROW 10.67 COL 13.83
          BGCOLOR 10 FGCOLOR 1 
     "Success Record :" VIEW-AS TEXT
          SIZE 17.5 BY .91 AT ROW 22.95 COL 42.33
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Batch No. :" VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 22.52 COL 6.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     RECT-372 AT ROW 2.38 COL 2
     RECT-374 AT ROW 12.91 COL 3
     RECT-376 AT ROW 21.76 COL 4
     RECT-377 AT ROW 7.19 COL 112.5
     RECT-378 AT ROW 9.29 COL 112.5
     RECT-380 AT ROW 6.38 COL 8 WIDGET-ID 52
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
         BGCOLOR 29 FONT 6.


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
         TITLE              = "Load Text file Format Empire"
         HEIGHT             = 24.14
         WIDTH              = 132.67
         MAX-HEIGHT         = 45.76
         MAX-WIDTH          = 213.33
         VIRTUAL-HEIGHT     = 45.76
         VIRTUAL-WIDTH      = 213.33
         RESIZE             = yes
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = 139
         FGCOLOR            = 133
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
/* SETTINGS FOR FRAME fr_main
   FRAME-NAME Custom                                                    */
/* BROWSE-TAB br_impdata_fil 1 fr_main */
ASSIGN 
       bu_file:AUTO-RESIZE IN FRAME fr_main      = TRUE.

ASSIGN 
       fi_bchno:READ-ONLY IN FRAME fr_main        = TRUE.

/* SETTINGS FOR FILL-IN fi_completecnt IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_impcnt IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_premsuc IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_premtot IN FRAME fr_main
   NO-ENABLE ALIGN-L                                                    */
/* SETTINGS FOR FILL-IN fi_process IN FRAME fr_main
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_impdata_fil
/* Query rebuild information for BROWSE br_impdata_fil
     _START_FREEFORM
OPEN QUERY br_impdata_fil FOR EACH impdata_fil.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE br_impdata_fil */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Load Text file Format Empire */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Load Text file Format Empire */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_impdata_fil
&Scoped-define SELF-NAME br_impdata_fil
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_impdata_fil C-Win
ON ROW-DISPLAY OF br_impdata_fil IN FRAME fr_main
DO:
    DEF VAR z AS INTE  INIT 0.
    DEF VAR s AS INTE  INIT 0.
    s = 1.
    z = 28.
    IF impdata_fil.comment <> "" THEN DO:

        impdata_fil.riskno      :BGCOLOR IN BROWSE BR_impdata_fil = z NO-ERROR.  
        impdata_fil.itemno      :BGCOLOR IN BROWSE BR_impdata_fil = z NO-ERROR.  
        impdata_fil.redbook     :BGCOLOR IN BROWSE BR_impdata_fil = z NO-ERROR.
        impdata_fil.policyno    :BGCOLOR IN BROWSE BR_impdata_fil = z NO-ERROR.  
        impdata_fil.poltyp      :BGCOLOR IN BROWSE BR_impdata_fil = z NO-ERROR.  
        impdata_fil.appenno     :BGCOLOR IN BROWSE BR_impdata_fil = z NO-ERROR.  
        impdata_fil.comdat      :BGCOLOR IN BROWSE BR_impdata_fil = z NO-ERROR.  
        impdata_fil.expdat      :BGCOLOR IN BROWSE BR_impdata_fil = z NO-ERROR.  
        impdata_fil.packcod     :BGCOLOR IN BROWSE BR_impdata_fil = z NO-ERROR. 
        impdata_fil.covcod      :BGCOLOR IN BROWSE BR_impdata_fil = z NO-ERROR.
        impdata_fil.garage      :BGCOLOR IN BROWSE BR_impdata_fil = z NO-ERROR. 
        impdata_fil.insref      :BGCOLOR IN BROWSE BR_impdata_fil = z NO-ERROR.   
        impdata_fil.tiname      :BGCOLOR IN BROWSE BR_impdata_fil = z NO-ERROR.   
        impdata_fil.insnam      :BGCOLOR IN BROWSE BR_impdata_fil = z NO-ERROR. 
        impdata_fil.lastname    :BGCOLOR IN BROWSE BR_impdata_fil = z NO-ERROR.
        impdata_fil.name2       :BGCOLOR IN BROWSE BR_impdata_fil = z NO-ERROR.      
        impdata_fil.name3       :BGCOLOR IN BROWSE BR_impdata_fil = z NO-ERROR.  
        impdata_fil.addr        :BGCOLOR IN BROWSE BR_impdata_fil = z NO-ERROR.
        impdata_fil.tambon      :BGCOLOR IN BROWSE BR_impdata_fil = z NO-ERROR.  
        impdata_fil.amper       :BGCOLOR IN BROWSE BR_impdata_fil = z NO-ERROR.   
        impdata_fil.country     :BGCOLOR IN BROWSE BR_impdata_fil = z NO-ERROR.  
        impdata_fil.post        :BGCOLOR IN BROWSE BR_impdata_fil = z NO-ERROR. 
        impdata_fil.comment     :BGCOLOR IN BROWSE BR_impdata_fil = z NO-ERROR.
        
        impdata_fil.riskno      :FGCOLOR IN BROWSE BR_impdata_fil = s NO-ERROR.     
        impdata_fil.itemno      :FGCOLOR IN BROWSE BR_impdata_fil = s NO-ERROR.     
        impdata_fil.redbook     :FGCOLOR IN BROWSE BR_impdata_fil = s NO-ERROR. 
        impdata_fil.policyno    :FGCOLOR IN BROWSE BR_impdata_fil = s NO-ERROR. 
        impdata_fil.poltyp      :FGCOLOR IN BROWSE BR_impdata_fil = s NO-ERROR. 
        impdata_fil.appenno     :FGCOLOR IN BROWSE BR_impdata_fil = s NO-ERROR. 
        impdata_fil.comdat      :FGCOLOR IN BROWSE BR_impdata_fil = s NO-ERROR. 
        impdata_fil.expdat      :FGCOLOR IN BROWSE BR_impdata_fil = s NO-ERROR. 
        impdata_fil.packcod     :FGCOLOR IN BROWSE BR_impdata_fil = s NO-ERROR. 
        impdata_fil.covcod      :FGCOLOR IN BROWSE BR_impdata_fil = s NO-ERROR. 
        impdata_fil.garage      :FGCOLOR IN BROWSE BR_impdata_fil = s NO-ERROR. 
        impdata_fil.insref      :FGCOLOR IN BROWSE BR_impdata_fil = s NO-ERROR. 
        impdata_fil.tiname      :FGCOLOR IN BROWSE BR_impdata_fil = s NO-ERROR. 
        impdata_fil.insnam      :FGCOLOR IN BROWSE BR_impdata_fil = s NO-ERROR. 
        impdata_fil.lastname    :FGCOLOR IN BROWSE BR_impdata_fil = s NO-ERROR. 
        impdata_fil.name2       :FGCOLOR IN BROWSE BR_impdata_fil = s NO-ERROR. 
        impdata_fil.name3       :FGCOLOR IN BROWSE BR_impdata_fil = s NO-ERROR. 
        impdata_fil.addr        :FGCOLOR IN BROWSE BR_impdata_fil = s NO-ERROR. 
        impdata_fil.tambon      :FGCOLOR IN BROWSE BR_impdata_fil = s NO-ERROR. 
        impdata_fil.amper       :FGCOLOR IN BROWSE BR_impdata_fil = s NO-ERROR. 
        impdata_fil.country     :FGCOLOR IN BROWSE BR_impdata_fil = s NO-ERROR.   
        impdata_fil.post        :FGCOLOR IN BROWSE BR_impdata_fil = s NO-ERROR. 
        impdata_fil.comment     :FGCOLOR IN BROWSE BR_impdata_fil = s NO-ERROR. 
         
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buok C-Win
ON CHOOSE OF buok IN FRAME fr_main /* OK */
DO:
    IF tg_format = YES THEN RUN proc_header .
    ELSE DO:
        IF ra_match = 2  THEN DO: 
            ASSIGN 
             nv_proid     = ""
             nv_proid     = "wgwlfleet" + trim(STRING(DAY(fi_loaddat),"99") + STRING(MONTH(fi_loaddat),"99") + STRING(YEAR(fi_loaddat),"9999")) .
            RUN proc_runningpol.
        END.
        ELSE DO:
            ASSIGN
                fi_completecnt:FGCOLOR = 2
                fi_premsuc:FGCOLOR     = 2 
                fi_bchno:FGCOLOR       = 2
                fi_completecnt         = 0
                fi_premsuc             = 0
                fi_bchno               = ""
                fi_premtot             = 0
                fi_impcnt              = 0.
            DISP  fi_impcnt fi_completecnt fi_premtot fi_premsuc fi_impcnt fi_premtot WITH FRAME fr_main.
            IF fi_filename = "" THEN DO:
                MESSAGE "ไฟล์ข้อมูลลูกค้าเป็นค่าว่าง !" VIEW-AS ALERT-BOX .
                APPLY "entry" to fi_filename.
                RETURN NO-APPLY.
            END.
          
            IF fi_loaddat = ? THEN DO:
                MESSAGE "Load Date Is Mandatory" VIEW-AS ALERT-BOX .
                APPLY "entry" to fi_loaddat.
                RETURN NO-APPLY.
            END.
            IF fi_bchyr <= 0 THEN DO:
                MESSAGE "Batch Year Can't be 0" VIEW-AS ALERT-BOX.
                APPLY "entry" to fi_bchyr.
                RETURN NO-APPLY.
            END.
            ASSIGN fi_output1 = INPUT fi_output1
                fi_output2    = INPUT fi_output2
                fi_output3    = INPUT fi_output3
                fi_outputpro  = INPUT fi_outputpro .  /*A55-0151*/
            IF fi_output1 = "" THEN DO:
                MESSAGE "Plese Input File Data Load...!!!" VIEW-AS ALERT-BOX ERROR.
                APPLY "Entry" TO fi_output1.
                RETURN NO-APPLY.
            END.
            IF fi_output2 = "" THEN DO:
                MESSAGE "Plese Input File Data Not Load...!!!" VIEW-AS ALERT-BOX ERROR.
                APPLY "Entry" TO fi_output2.
                RETURN NO-APPLY.
            END.
            IF fi_output3 = "" THEN DO:
                MESSAGE "Plese Input Batch File Name...!!!" VIEW-AS ALERT-BOX ERROR.
                APPLY "Entry" TO fi_output3.
                RETURN NO-APPLY.
            END.
            ASSIGN
                fi_loaddat   = INPUT fi_loaddat 
                fi_bchyr     = INPUT fi_bchyr       fi_prevbat      = INPUT fi_prevbat
                /*fi_usrcnt    = INPUT fi_usrcnt      fi_usrprem      = INPUT fi_usrprem*/
                nv_imppol    = 0                    nv_impprem      = 0 
                nv_tmppolrun = 0                    nv_daily        = ""
                nv_reccnt    = 0                    nv_completecnt  = 0
                nv_netprm_t  = 0                    nv_netprm_s     = 0 
                nv_total     = 0                    nv_proid        = ""
                nv_proid     = "wgwlfleet" + trim(STRING(DAY(fi_loaddat),"99") + STRING(MONTH(fi_loaddat),"99") + STRING(YEAR(fi_loaddat),"9999")) .
        
            RUN proc_assign_ex.
        
            FOR EACH impdata_fil WHERE .
              IF impdata_fil.POLTYP = "V70" THEN DO:
                  ASSIGN
                      nv_reccnt      = nv_reccnt   + 1
                      nv_netprm_t    = nv_netprm_t + decimal(impdata_fil.premt).
                 IF impdata_fil.comment = "" THEN DO: 
                     ASSIGN nv_total = nv_total + 1 
                            impdata_fil.pass   = "Y".
                 END.
                 ELSE impdata_fil.pass = "N" .
              END.
            END.
           
            IF  nv_reccnt = 0 THEN DO: 
                MESSAGE "No Record Can Gen " VIEW-AS ALERT-BOX.       
                RETURN NO-APPLY.
            END.
            IF nv_total <> nv_reccnt THEN DO:
                 MESSAGE "Has Record Error Not Gen Data " VIEW-AS ALERT-BOX. 
                 RUN proc_report1 .
                 RUN proc_deldata.
                 ASSIGN fi_output1    = ""
                        fi_output3    = ""
                        fi_outputpro  = "" . 
                 DISP fi_output1    fi_output3  fi_outputpro WITH FRAME fr_main.
                 RETURN NO-APPLY.
            END.
        
            nv_imppol   = nv_total    .
            nv_impprem  = nv_netprm_t .
             
            ASSIGN nv_batchyr = INPUT fi_bchyr.
            IF nv_batprev = "" THEN DO:  
                FIND LAST sic_bran.uzm700 USE-INDEX uzm70001 WHERE 
                    uzm700.bchyr   = nv_batchyr          AND
                    uzm700.branch  = "EM"     AND
                    uzm700.acno    = "FLE" + STRING(nv_batchyr,"9999") NO-LOCK NO-ERROR .
                IF AVAIL sic_bran.uzm700 THEN DO:   
                    nv_batrunno = uzm700.runno.
                    FIND LAST sic_bran.uzm701 USE-INDEX uzm70102      WHERE
                        uzm701.bchyr   = nv_batchyr          AND
                        uzm701.bchno   = "FLE" + STRING(nv_batchyr,"9999") + "EM" + string(nv_batrunno,"9999")  NO-LOCK NO-ERROR.
                    IF AVAIL sic_bran.uzm701 THEN DO:
                        nv_batcnt = uzm701.bchcnt .
                        nv_batrunno = nv_batrunno + 1.
                    END.
                END.
                ELSE DO:  
                    ASSIGN
                        nv_batcnt = 1
                        nv_batrunno = 1.
                END.
                nv_batchno = "FLE" + STRING(nv_batchyr,"9999") + "EM" + STRING(nv_batrunno,"9999").
            END.
            ELSE DO:  
                nv_batprev = INPUT fi_prevbat.
                FIND LAST sic_bran.uzm701 USE-INDEX uzm70102 
                    WHERE uzm701.bchyr   = nv_batchyr       AND 
                          uzm701.bchno = CAPS(nv_batprev)   NO-LOCK NO-ERROR NO-WAIT.
                IF NOT AVAIL sic_bran.uzm701 THEN DO:
                    MESSAGE "Not found Batch File Master : " + CAPS (nv_batprev)
                        + " on file uzm701" .
                    APPLY "entry" TO fi_prevbat.
                    RETURN NO-APPLY.
                END.
                IF AVAIL sic_bran.uzm701 THEN DO:
                    nv_batcnt  = uzm701.bchcnt + 1.
                    nv_batchno = CAPS(TRIM(nv_batprev)).
                END.
            END.
            RUN wgw\wgwbatch.p    (INPUT            fi_loaddat ,     /* DATE  */
                                   INPUT            nv_batchyr ,     /* INT   */
                                   INPUT            "FLE" + STRING(nv_batchyr,"9999") ,     /* CHAR  */ 
                                   INPUT            "EM"     ,     /* CHAR  */
                                   INPUT            fi_prevbat ,     /* CHAR  */ /*Previous Batch*/
                                   INPUT            "WGWloadem" ,     /* CHAR  */
                                   INPUT-OUTPUT     nv_batchno ,     /* CHAR  */
                                   INPUT-OUTPUT     nv_batcnt  ,     /* INT   */
                                   INPUT            nv_imppol  ,     /* INT   */
                                   INPUT            nv_impprem  ).      /* DECI  */
                                  
            ASSIGN fi_bchno = CAPS(nv_batchno + "." + STRING(nv_batcnt,"99")).
            DISP  fi_bchno   WITH FRAME fr_main.
        
            RUN proc_chktest1.  
            
            FOR EACH impdata_fil WHERE impdata_fil.pass = "y" : 
                ASSIGN
                nv_completecnt = nv_completecnt + 1
                nv_netprm_s    = nv_netprm_s    + decimal(impdata_fil.premt) + DECI(impdata_fil.premt72).
            END.
            nv_rectot = nv_reccnt.      
            nv_recsuc = nv_completecnt. 
            IF  nv_rectot <> nv_recsuc   THEN DO:
                nv_batflg = NO.
            END.
            ELSE 
            IF nv_netprm_t <> nv_netprm_s THEN DO:
                nv_batflg = NO.
            END.
            ELSE 
                nv_batflg = YES.
            FIND LAST sic_bran.uzm701 USE-INDEX uzm70102  
                WHERE uzm701.bchyr = nv_batchyr AND
                      uzm701.bchno = nv_batchno AND
                      uzm701.bchcnt  = nv_batcnt NO-ERROR.
            IF AVAIL sic_bran.uzm701 THEN DO:
                ASSIGN
                  uzm701.recsuc      = nv_recsuc     
                  uzm701.premsuc     = nv_netprm_s   
                  uzm701.rectot      = nv_rectot     
                  uzm701.premtot     = nv_netprm_t   
                  uzm701.impflg      = nv_batflg    
                  uzm701.cnfflg      = nv_batflg .   
            END.  
            ASSIGN
            fi_impcnt      = nv_rectot
            fi_premtot     = nv_netprm_t
            fi_completecnt = nv_recsuc
            fi_premsuc     = nv_netprm_s .
            IF nv_rectot <> nv_recsuc  THEN nv_txtmsg = " have record error..!! ".
            ELSE nv_txtmsg = "      have batch file error..!! ".
            RELEASE sic_bran.uzm700.
            RELEASE sic_bran.uzm701.
            RELEASE sic_bran.uwm100.
            RELEASE sic_bran.uwm120.
            RELEASE sic_bran.uwm130.
            RELEASE sic_bran.uwm301.
            RELEASE brstat.detaitem.
            RELEASE sicsyac.xzm056.
            RELEASE sicsyac.xmm600.
            RELEASE sicsyac.xtm600.
            IF CONNECTED("sic_exp") THEN DISCONNECT sic_exp.  
            RUN   proc_open.    
            IF nv_batflg = NO THEN DO:  
                ASSIGN
                    fi_completecnt:FGCOLOR = 6
                    fi_premsuc    :FGCOLOR = 6 
                    fi_bchno      :FGCOLOR = 6. 
            END.
            ELSE IF nv_batflg = YES THEN DO: 
                ASSIGN
                    fi_completecnt:FGCOLOR = 2
                    fi_premsuc:FGCOLOR     = 2 
                    fi_bchno:FGCOLOR       = 2.
            END.
            DISP  fi_impcnt fi_completecnt fi_premtot fi_premsuc WITH FRAME fr_main.
            RUN proc_report1 .   
            RUN PROC_REPORT2 .
            RUN PROC_REPORT3 .   /*add A55-0151 */
            RUN proc_screen  . 
            RUN proc_deldata.
           
            IF nv_batflg = YES THEN DO:
                MESSAGE "Process Complete" VIEW-AS ALERT-BOX INFORMATION TITLE "INFORMATION".
                ASSIGN fi_process = "Import Text file Process Complete."  .
                        DISP fi_process WITH FRAM fr_main.
            END.
            ELSE DO:
                ASSIGN fi_process = "Process data file....error !!!!"  .
                DISP fi_process fi_completecnt fi_premsuc WITH FRAME fr_main.
                MESSAGE "Batch Year  : " STRING(nv_batchyr)     SKIP
                        "Batch No.   : " nv_batchno             SKIP
                        "Batch Count : " STRING(nv_batcnt,"99") SKIP(1)
                        TRIM(nv_txtmsg)                         SKIP
                        "Please check Data again."      
                VIEW-AS ALERT-BOX ERROR TITLE "WARNING MESSAGE".  
            END.
        END.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit C-Win
ON CHOOSE OF bu_exit IN FRAME fr_main /* EXIT */
DO:
  IF CONNECTED("sic_exp") THEN DISCONNECT sic_exp. 
  RUN proc_deldata.
  APPLY "close" TO THIS-PROCEDURE.
      RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_file
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_file C-Win
ON CHOOSE OF bu_file IN FRAME fr_main /* .... */
DO:
    DEFINE VARIABLE cvData     AS CHARACTER NO-UNDO.
    DEFINE VARIABLE OKpressed  AS LOGICAL INITIAL TRUE.
    DEF VAR no_add AS CHAR FORMAT "x(8)" .    /*08/11/2006*/

 
   SYSTEM-DIALOG GET-FILE cvData
   TITLE      "Choose Data File to Import ..."
   FILTERS    "CSV (Comma Delimited)"   "*.csv",
              "Text Files (*.txt)" "*.txt"
                     /*  "Data Files (*.dat)"     "*.dat",*/
               /*"Text Files (*.txt)" "*.txt"*/             /*A58-0198*/
   MUST-EXIST
   USE-FILENAME
   UPDATE OKpressed.
    
   
    IF OKpressed = TRUE THEN DO:
         /***--- 08/11/2006 ---***/
         no_add =           STRING(MONTH(TODAY),"99")    + 
                            STRING(DAY(TODAY),"99")      + 
                  SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                  SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) .

         /***---a490166 ---***/
         IF ra_match = 1 THEN DO:
         ASSIGN
            fi_filename  = cvData
            fi_output1   = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_SUCCESS" */ + no_add + ".fuw"   /*.csv*/
            fi_output2   = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_ERROR"   */ + no_add + ".err"
            fi_output3   = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_SCREEN"  */ + no_add + ".sce"   /*txt*/
            fi_outputpro = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_SUCCESS" */ + no_add + ".slk" .  /*.csv*//*A55-0151*/
         END.
         ELSE DO: 
             ASSIGN
             fi_filename  = cvData
             fi_output1   = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4)) + "_Polno" + no_add + ".CSV"   /*.csv*/
             fi_output2   = "" 
             fi_output3   = "" 
             fi_outputpro = "" .
         END.
         DISP fi_filename fi_output1 fi_output2 fi_output3 fi_outputpro  WITH FRAME {&FRAME-NAME}. 
         APPLY "Entry" TO fi_output3.
         RETURN NO-APPLY.
    END.

    

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_bchyr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_bchyr C-Win
ON LEAVE OF fi_bchyr IN FRAME fr_main
DO:
        nv_batchyr = INPUT fi_bchyr.
        IF nv_batchyr <= 0 THEN DO:
           MESSAGE "Batch Year Error...!!!".
           APPLY "entry" TO fi_bchyr.
           RETURN NO-APPLY.
        END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_loaddat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_loaddat C-Win
ON LEAVE OF fi_loaddat IN FRAME fr_main
DO:
    fi_loaddat  =  Input  fi_loaddat.
    Disp  fi_loaddat  with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_pack
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_pack C-Win
ON LEAVE OF fi_pack IN FRAME fr_main
DO:
    fi_pack  =  Input  fi_pack.
    Disp  fi_pack  with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_prevbat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_prevbat C-Win
ON LEAVE OF fi_prevbat IN FRAME fr_main
DO:
    fi_prevbat = caps(INPUT fi_prevbat).
    nv_batprev = fi_prevbat.
    IF nv_batprev <> " "  THEN DO:
        IF LENGTH(nv_batprev) <> 13 THEN DO:
             MESSAGE "Length Of Batch no. Must Be 13 Character " SKIP
                     "Please Check Batch No. Again             " view-as alert-box.
             APPLY "entry" TO fi_prevbat.
             RETURN NO-APPLY.
        END.
    END. /*nv_batprev <> " "*/
    
    DISPLAY fi_prevbat WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_match
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_match C-Win
ON VALUE-CHANGED OF ra_match IN FRAME fr_main
DO:
    ra_match = INPUT ra_match .
    DISP ra_match WITH FRAME fr_main.
    IF ra_match = 2  THEN DO:
        DISABLE fi_loaddat fi_pack fi_bchyr WITH FRAME fr_main.
    END.
    ELSE DO:
        ENABLE fi_loaddat  fi_pack fi_bchyr WITH FRAME fr_main.
    END.
    DISP fi_loaddat fi_pack fi_process ra_type  fi_bchyr  WITH FRAME fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_type
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_type C-Win
ON VALUE-CHANGED OF ra_type IN FRAME fr_main
DO:
    ra_type = INPUT ra_type .
    DISP ra_type WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME tg_flag
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL tg_flag C-Win
ON VALUE-CHANGED OF tg_flag IN FRAME fr_main
DO:
    tg_flag = INPUT tg_flag .
    DISP tg_flag WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME tg_format
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL tg_format C-Win
ON VALUE-CHANGED OF tg_format IN FRAME fr_main /* Export Header Format Load */
DO:
    tg_format = INPUT tg_format .
    DISP tg_format WITH FRAME fr_main .

    IF tg_format = YES THEN DO:
        fi_filename = "D:\Temp\Format file Load.SLK" .
        DISABLE bu_file WITH FRAME fr_main.
        DISP fi_filename bu_file WITH FRAME fr_main.
    END.
    ELSE DO:
         fi_filename = "" .
         ENABLE bu_file WITH FRAME fr_main.
         DISP fi_filename bu_file WITH FRAME fr_main.
    END.
  
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
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
    ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
    RUN enable_UI.
/********************  T I T L E   F O R  C - W I N  ****************/
DEF  VAR  gv_prgid   AS   CHAR  FORMAT "X(8)"   NO-UNDO.
DEF  VAR  gv_prog    AS   CHAR  FORMAT "X(40)" NO-UNDO.
ASSIGN 
    gv_prgid    = "Wgwlfleet"
    gv_prog     = "Load Text & Generate Data Motor policy Fleet" .
    
RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).  /*28/11/2006*/
ASSIGN
    fi_pack     = "T" 
    fi_bchyr    = YEAR(TODAY)
    ra_match    = 1
    ra_type     = 1 
    tg_flag     = YES /*A68-0044*/
    fi_loaddat  = TODAY
    nv_date     = trim(STRING(DAY(fi_loaddat),"99") + STRING(MONTH(fi_loaddat),"99") + STRING(YEAR(fi_loaddat),"9999")) .
    fi_process  = "Load Text file ..." .
   
   DISABLE ra_type WITH FRAME fr_main .
   HIDE  ra_type  .

   DISP fi_loaddat fi_pack fi_process ra_type fi_bchyr tg_flag WITH FRAME fr_main.
   
   For each  impdata_fil USE-INDEX data_fil10 WHERE 
       impdata_fil.usrid  = USERID(LDBNAME(1)) AND 
       SUBSTR(impdata_fil.progid,10,8) <> nv_date :
       DELETE  impdata_fil.
   End.
   For each  imptxt_fil USE-INDEX txt_fil02 WHERE 
       imptxt_fil.usrid  = USERID(LDBNAME(1)) AND 
       SUBSTR(impdata_fil.progid,10,8) <> nv_date :
       DELETE  imptxt_fil.
   End.
   For each  impmemo_fil USE-INDEX memo_fil02 WHERE 
       impmemo_fil.usrid  = USERID(LDBNAME(1)) AND
       SUBSTR(impdata_fil.progid,10,8) <> nv_date :
       DELETE  impmemo_fil.
   End.
   For each  impacc_fil USE-INDEX acc_fil02 WHERE 
       impacc_fil.usrid  = USERID(LDBNAME(1)) AND 
       SUBSTR(impdata_fil.progid,10,8) <> nv_date :
       DELETE  impacc_fil.
   End.
   For each  impinst_fil USE-INDEX inst_fil02 WHERE 
       impinst_fil.usrid  = USERID(LDBNAME(1)) AND
       SUBSTR(impdata_fil.progid,10,8) <> nv_date :
       DELETE  impinst_fil.
   End.

/*********************************************************************/  
    RUN  WUT\WUTWICEN (c-win:handle).  
    Session:data-Entry-Return = Yes.
    IF NOT THIS-PROCEDURE:PERSISTENT THEN
        WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_assigndata C-Win 
PROCEDURE 00-proc_assigndata :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: comment by A67-0029      
------------------------------------------------------------------------------*/
/*DO:
    nv_error = "" .
    RUN proc_initdataex.
    INPUT FROM VALUE(fi_FileName).
    REPEAT:
        IMPORT DELIMITER "|"
            wf_riskno        /*Risk no */
            wf_num           /*ItemNo                     */                  
            wf_policyno      /*Policy No (เลขที่กรมธรรม์ภาคสมัครใจ)     */      
            wf_n_branch      /*Branch (สาขา)              */      
            wf_agent         /*Agent Code (รหัสตัวแทน)    */      
            wf_producer      /*Producer Code              */      
            wf_n_delercode   /*Dealer Code (รหัสดีเลอร์)  */      
            wf_fincode       /*Finance Code (รหัสไฟแนนซ์) */      
            wf_appenno       /*Notification Number (เลขที่รับแจ้ง)*/      
            wf_salename      /*Notification Name (ชื่อผู้แจ้ง)    */      
            wf_srate         /*Short Rate                 */      
            wf_comdat        /*Effective Date (วันที่เริ่มความคุ้มครอง) */      
            wf_expdat        /*Expiry Date (วันที่สิ้นสุดความคุ้มครอง)  */      
            wf_agreedat      /*Agree Date    */      
            wf_firstdat      /*First Date    */      
            wf_packcod       /*รหัส Package  */          
            wf_camp_no       /*Campaign Code (รหัสแคมเปญ) */      
            wf_campen        /*Campaign Text */      
            wf_specon        /*Spec Con      */      
            wf_product       /*Product Type  */      
            wf_promo         /*Promotion Code*/      
            wf_rencnt        /*Renew Count   */      
            wf_prepol        /*Previous Policy (เลขทีกรมธรรม์ภาคสมัครใจเดิม)*/  
            wf_txt1          /*Policy Text 1  */                                
            wf_txt2          /*Policy Text 2  */                                
            wf_txt3          /*Policy Text 3  */                                
            wf_txt4          /*Policy Text 4  */                                
            wf_txt5          /*Policy Text 5  */                                
            wf_txt6          /*Policy Text 6  */                                
            wf_txt7          /*Policy Text 7  */                                
            wf_txt8          /*Policy Text 8  */                                
            wf_txt9          /*Policy Text 9  */                                
            wf_txt10         /*Policy Text 10 */                                
            wf_memo1         /*Memo Text 1    */                                
            wf_memo2         /*Memo Text 2    */                                
            wf_memo3         /*Memo Text 3    */                                
            wf_memo4         /*Memo Text 4    */                                
            wf_memo5         /*Memo Text 5    */                                
            wf_memo6         /*Memo Text 6    */                                
            wf_memo7         /*Memo Text 7    */                                
            wf_memo8         /*Memo Text 8    */                                
            wf_memo9         /*Memo Text 9    */                                
            wf_memo10        /*Memo Text 10   */                                
            wf_accdata1      /*Accessory Text 1 */                              
            wf_accdata2      /*Accessory Text 2 */                              
            wf_accdata3      /*Accessory Text 3 */                              
            wf_accdata4      /*Accessory Text 4 */                                  
            wf_accdata5      /*Accessory Text 5 */                                  
            wf_accdata6      /*Accessory Text 6 */                                  
            wf_accdata7      /*Accessory Text 7 */                                  
            wf_accdata8      /*Accessory Text 8 */                                  
            wf_accdata9      /*Accessory Text 9 */                                  
            wf_accdata10     /*Accessory Text 10*/                                  
            wf_compul        /*กรมธรรม์ซื้อควบ (Y/N)  */ 
            wf_insref        /* new  Code insured  */
            wf_instyp        /*ประเภทบุคคล            */                            
            wf_inslang       /*ภาษาที่ใช้สร้าง Cilent Code */         
            wf_tiname        /*คำนำหน้า   */         
            wf_insnam        /*ชื่อ       */         
            wf_lastname      /*นามสกุล    */                            
            wf_icno          /*เลขที่บัตรประชาชน / เลขที่นิติบุคคล*/         
            wf_insbr         /*ลำดับที่สาขา      */                            
            wf_occup         /*อาชีพ             */                            
            wf_addr          /*ที่อยู่บรรทัดที่ 1*/                            
            wf_tambon        /*ที่อยู่บรรทัดที่ 2*/                            
            wf_amper         /*ที่อยู่บรรทัดที่ 3*/                            
            wf_country       /*ที่อยู่บรรทัดที่ 4*/                            
            wf_post          /*รหัสไปรษณีย์      */                            
            wf_provcod       /*province code     */                            
            wf_distcod       /*district code     */                            
            wf_sdistcod      /*sub district code */  
            wf_ae            /*  ae  new Xmm600 งาน Japanes */
            wf_jtl           /*  jtl new Xmm600 งาน Japanes */
            wf_ts            /*  ts  new Xmm600 งาน Japanes */
            wf_gender        /*Gender (Male/Female/Other) */         
            wf_tele1         /*Telephone 1*/                            
            wf_tele2         /*Telephone 2*/                            
            wf_mail1         /*E-Mail 1   */                            
            wf_mail2         /*E-Mail 2   */                            
            wf_mail3         /*E-Mail 3   */                            
            wf_mail4         /*E-Mail 4   */                            
            wf_mail5         /*E-Mail 5   */                            
            wf_mail6         /*E-Mail 6   */                            
            wf_mail7         /*E-Mail 7   */                            
            wf_mail8         /*E-Mail 8   */                            
            wf_mail9         /*E-Mail 9   */                            
            wf_mail10        /*E-Mail 10  */                            
            wf_fax           /*Fax      */                            
            wf_lineID        /*Line ID  */                            
            wf_name2         /*CareOf1  */                            
            wf_name3         /*CareOf2  */                            
            wf_benname       /*Benefit Name*/                            
            wf_payercod      /*Payer Code  */                            
            wf_vatcode       /*VAT Code    */                            
            wf_instcod1      /*Client Code */                            
            wf_insttyp1      /*ประเภทบุคคล */                            
            wf_insttitle1    /*คำนำหน้า    */                            
            wf_instname1     /*ชื่อ        */                            
            wf_instlname1    /*นามสกุล     */                            
            wf_instic1       /*เลขที่บัตรประชาชน / เลขที่นิติบุคคล       */         
            wf_instbr1       /*ลำดับที่สาขา       */                           
            wf_instaddr11    /*ที่อยู่บรรทัดที่ 1 */                 
            wf_instaddr21    /*ที่อยู่บรรทัดที่ 2 */                 
            wf_instaddr31    /*ที่อยู่บรรทัดที่ 3 */                 
            wf_instaddr41    /*ที่อยู่บรรทัดที่ 4 */                 
            wf_instpost1     /* รหัสไปรษณีย์      */                 
            wf_instprovcod1  /*province code      */                 
            wf_instdistcod1  /*district code      */                 
            wf_instsdistcod1 /*sub district code  */                 
            wf_instprm1      /*เบี้ยก่อนภาษีอากร  */                 
            wf_instrstp1     /*อากร         */                 
            wf_instrtax1     /*ภาษี         */                 
            wf_instcomm01    /*คอมมิชชั่น 1 */                 
            wf_instcomm12    /*คอมมิชชั่น 2 (co-broker) */           
            wf_instcod2      /*Client Code  */                 
            wf_insttyp2      /*ประเภทบุคคล  */                 
            wf_insttitle2    /*คำนำหน้า     */                 
            wf_instname2     /*ชื่อ         */                 
            wf_instlname2    /*นามสกุล      */                 
            wf_instic2       /*เลขที่บัตรประชาชน / เลขที่นิติบุคคล*/     
            wf_instbr2       /*ลำดับที่สาขา      */                 
            wf_instaddr12    /*ที่อยู่บรรทัดที่ 1*/                 
            wf_instaddr22    /*ที่อยู่บรรทัดที่ 2*/                 
            wf_instaddr32    /*ที่อยู่บรรทัดที่ 3*/                 
            wf_instaddr42    /*ที่อยู่บรรทัดที่ 4*/                 
            wf_instpost2     /*รหัสไปรษณีย์      */                 
            wf_instprovcod2  /*province code     */                 
            wf_instdistcod2  /*district code     */                 
            wf_instsdistcod2 /*sub district code */                 
            wf_instprm2      /*เบี้ยก่อนภาษีอากร */                 
            wf_instrstp2     /*อากร              */                 
            wf_instrtax2     /*ภาษี              */                 
            wf_instcomm02    /*คอมมิชชั่น 1      */                 
            wf_instcomm22    /*คอมมิชชั่น 2 (co-broker)     */           
            wf_instcod3      /*Client Code       */                 
            wf_insttyp3      /*ประเภทบุคคล       */                 
            wf_insttitle3    /*คำนำหน้า          */                 
            wf_instname3     /*ชื่อ              */                 
            wf_instlname3    /*นามสกุล           */                 
            wf_instic3       /*เลขที่บัตรประชาชน/เลขที่นิติบุคคล  */   
            wf_instbr3       /*ลำดับที่สาขา      */                
            wf_instaddr13    /*ที่อยู่บรรทัดที่ 1*/                
            wf_instaddr23    /*ที่อยู่บรรทัดที่ 2*/                
            wf_instaddr33    /*ที่อยู่บรรทัดที่ 3*/                
            wf_instaddr43    /*ที่อยู่บรรทัดที่ 4*/                
            wf_instpost3     /*รหัสไปรษณีย์      */                
            wf_instprovcod3  /*province code     */                
            wf_instdistcod3  /*district code     */                
            wf_instsdistcod3 /*sub district code */                
            wf_instprm3       /*เบี้ยก่อนภาษีอากร*/                
            wf_instrstp3      /*อากร             */                
            wf_instrtax3      /*ภาษี             */                
            wf_instcomm03     /*คอมมิชชั่น 1     */          
            wf_instcomm23     /*คอมมิชชั่น 2 (co-broker)          */
            wf_covcod         /*Cover Type (ประเภทความคุ้มครอง)   */
            wf_garage         /*Garage (ประเภทการซ่อม ซ่อมอู่/ซ่อมห้าง)  */
            wf_special        /*Spacial EquipmentFlag(A/Blank)*/       
            wf_inspec         /*Inspection       */                
            wf_class70        /*รหัสรถภาคสมัครใจ (110/120/…)   */
            wf_vehuse         /* ลักษณะการใช้รถ */   
            wf_redbook        /* redbook */                     /*A65-0079 */
            wf_brand          /*ยี่ห้อรถ         */                
            wf_model          /*ชื่อรุ่นรถ       */                
            wf_submodel       /*ชื่อรุ่นย่อยรถ   */                
            wf_caryear        /*ปีรุ่นรถ         */                
            wf_chasno         /*หมายเลขตัวถัง    */                
            wf_eng            /*หมายเลขเครื่อง   */
            wf_seat           /*จำนวนที่นั่ง (รวมผู้ขับขี่) */       
            wf_engcc          /*ปริมาตรกระบอกสูบ (CC) */                
            wf_weight         /*น้ำหนัก (ตัน)    */ 
            wf_watt           /*Kilowatt         */ 
            wf_body           /*รหัสแบบตัวถัง    */ 
            wf_type           /*ป้ายแดง (Y/N)    */ 
            wf_re_year        /*ปีที่จดทะเบียน   */ 
            wf_vehreg         /*เลขทะเบียนรถ     */ 
            wf_re_country     /*จังหวัดที่จดทะเบียน*/ 
            wf_cargrp         /*Group Car (กลุ่มรถ)*/ 
            wf_colorcar       /*Color (สี)        */ 
            wf_fule           /*Fule (เชื้อเพลิง) */ 
            wf_drivnam        /*Driver Number     */
            wf_ntitle1        /*คำนำหน้า          */ 
            wf_drivername1    /*ชื่อ              */ 
            wf_dname2         /*นามสกุล           */  
            wf_dicno          /*เลขที่บัตรประชาชน */  
            wf_dgender1       /*เพศ               */  
            wf_dbirth         /*วันเกิด           */  
            wf_docoup         /*ชื่ออาชีพ         */  
            wf_ddriveno       /*เลขที่ใบอนุญาตขับขี่  */  
            wf_ntitle2        /*คำนำหน้า          */  
            wf_drivername2    /*ชื่อ              */  
            wf_ddname1        /*นามสกุล           */  
            wf_ddicno         /*เลขที่บัตรประชาชน */  
            wf_dgender2       /*เพศ               */  
            wf_ddbirth        /*วันเกิด           */  
            wf_ddocoup        /*ชื่ออาชีพ         */  
            wf_dddriveno      /*เลขที่ใบอนุญาตขับขี่  */  
            wf_baseplus       /*Base Premium Plus */  
            wf_siplus         /*Sum Insured Plus  */  
            wf_rs10           /*RS10 Amount       */  
            wf_comper         /*TPBI / person     */  
            wf_comacc         /*TPBI / occurrence */  
            wf_deductpd       /*TPPD              */  
            wf_DOD            /*Deduct / OD       */
            wf_dod1           /* DOD1 */                /*A65-0079*/ 
            wf_DPD            /*Deduct / PD       */  
            wf_tpfire         /*Theft & Fire      */  
            wf_NO_411         /*PA1.1 / driver    */  
            wf_ac2            /*PA1.1 no.of passenger */  
            wf_NO_412         /*PA1.1 / passenger */  
            wf_NO_413         /*PA1.2 / driver    */  
            wf_ac6            /*PA1.2 no.of passenger */  
            wf_NO_414         /*PA1.2 / passenger*/  
            wf_NO_42          /*PA2          */  
            wf_NO_43          /*PA3          */  
            wf_base           /*Base Premium */  
            wf_unname         /*Unname       */  
            wf_nname          /*Name         */  
            wf_tpbi           /*TPBI1 Amount  */  
            wf_tpbiocc        /*TPBI2 Amount  */  /*A65-0079*/ 
            wf_tppd           /*TPPD Amount  */ 
            wf_dodamt         /*A65-0079*/
            wf_dod1amt        /*A65-0079*/
            wf_dpdamt         /*A65-0079*/
            wf_ry01           /*RY01 Amount  */ 
            wf_ry412         /*A65-0079*/
            wf_ry413         /*A65-0079*/
            wf_ry414         /*A65-0079*/
            wf_ry02           /*RY02 Amount  */  
            wf_ry03           /*RY03 Amount  */  
            wf_fleet          /*Fleet%       */  
            wf_ncb            /*NCB%         */  
            wf_claim          /*Load Claim%  */  
            wf_dspc           /*Other Disc.% */  
            wf_cctv           /*CCTV%        */  
            wf_dstf           /*Walkin Disc.%*/  
            wf_fleetprem      /*Fleet Amount */  
            wf_ncbprem        /*NCB Amount   */  
            wf_clprem         /*Load Claim Amount*/  
            wf_dspcprem       /*Other Disc. Amount */ 
            wf_cctvprem       /*CCTV Amount  */  
            wf_dstfprem       /*Walk in Disc.Amount */ 
            wf_premt          /*เบี้ยสุทธิ   */  
            wf_rstp_t         /*Stamp Duty   */  
            wf_rtax_t         /*VAT          */  
            wf_comper70       /*Commission % */  
            wf_comprem70      /*Commission Amount*/  
            wf_agco70          /*Agent Code co-broker (รหัสตัวแทน)*/      
            wf_comco_per70     /*Commission % co-broker*/              
            wf_comco_prem70    /*Commission Amount co-broker*/ 
            /* ไม่เก็บไปใช้ */
            wf_dgpackge        /*Package (Attach Coverage)  */         
            wf_danger1         /*Dangerous Object 1    */              
            wf_danger2         /*Dangerous Object 2    */              
            wf_dgsi            /*Sum Insured           */              
            wf_dgrate          /*Rate%                 */              
            wf_dgfeet          /*Fleet%                */              
            wf_dgncb           /*NCB%                  */              
            wf_dgdisc          /*Discount%             */            
            wf_dgwdisc         /*Walkin Discount%        */          
            wf_dgatt           /*Premium Attach Coverage */            
            wf_dgfeetprm       /*Discount Fleet        */              
            wf_dgncbprm        /*Discount NCB          */              
            wf_dgdiscprm       /*Other Discount        */ 
            wf_dgWdiscprm      /*walkin Discount        */ 
            wf_dgprem          /*Net Premium           */              
            wf_dgrstp_t        /*Stamp Duty            */              
            wf_dgrtax_t        /*VAT                   */              
            wf_dgcomper        /*Commission %          */              
            wf_dgcomprem       /*Commission Amount     */ 
            /* end :ไม่เก็บไปใช้ */
            wf_cltxt           /*Claim Text            */                           
            wf_clamount        /*Claim Amount          */                           
            wf_faultno         /*Claim Count Fault     */                           
            wf_faultprm        /*Claim Count Fault Amount   */                      
            wf_goodno          /*Claim Count Good           */                      
            wf_goodprm         /*Claim Count Good Amount    */                      
            wf_loss           /*Loss Ratio % (Not TP)      */                      
            /* ไม่เก็บไปใช้ */
            wf_compolusory     /*Compulsory Policy Number (เลขที่กรมธรรม์ พรบ.)*/   
            wf_barcode         /*Barcode No.                    */                  
            wf_class72         /*Compulsory Class (รหัส พรบ.)   */                  
            wf_dstf72          /*Compulsory Walk In Discount %  */                  
            wf_dstfprem72      /*Compulsory Walk In Discount Amount      */         
            wf_premt72         /*เบี้ยสุทธิ พ.ร.บ. กรณี "กรมธรรม์ซื้อควบ"*/       
            wf_rstp_t72        /*Stamp Duty            */                         
            wf_rtax_t72        /*VAT                   */                         
            wf_comper72        /*Commission %          */                         
            wf_comprem72.      /*Commission Amount     */
            /* End :ไม่เก็บไปใช้ */
        RUN proc_assigndata2 . /*A65-0079*/
    END.         /* repeat   */
END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_ass_cardetail C-Win 
PROCEDURE 00-proc_ass_cardetail :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  comment by : A67-0029     
------------------------------------------------------------------------------*/
/*DEF BUFFER bfimpdata_fil FOR impdata_fil.
DO:
    ASSIGN fi_process = "Create data Risk/Item ." + wf_riskno + "/" + wf_num + " " + wf_chasno + " to impdata_fil ....." .
    DISP fi_process WITH FRAM fr_main.

    FIND FIRST bfimpdata_fil WHERE bfimpdata_fil.policyno <> "" AND
                               bfimpdata_fil.comdat   <> ?  AND 
                               bfimpdata_fil.expdat   <> ?  and
                               bfimpdata_fil.riskno   = 0   AND
                               bfimpdata_fil.itemno   = 0   NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL bfimpdata_fil THEN DO:
        FIND LAST impdata_fil WHERE impdata_fil.policy = bfimpdata_fil.policyno AND 
                                impdata_fil.riskno = int(wf_riskno)  AND
                                impdata_fil.itemno = int(wf_num)     AND
                                impdata_fil.chasno = trim(wf_chasno) NO-LOCK NO-ERROR .
        IF NOT AVAIL impdata_fil THEN DO:
            CREATE impdata_fil.
            CREATE impacc_fil.
            CREATE impdriv_fil. /*A67-0029*/
            ASSIGN
                impdata_fil.policyno      =  bfimpdata_fil.policyno     
                impdata_fil.n_branch      =  bfimpdata_fil.n_branch      
                impdata_fil.agent         =  bfimpdata_fil.agent         
                impdata_fil.producer      =  bfimpdata_fil.producer      
                impdata_fil.n_delercode   =  bfimpdata_fil.n_delercode 
                impdata_fil.fincode       =  bfimpdata_fil.fincode    
                impdata_fil.appenno       =  bfimpdata_fil.appenno    
                impdata_fil.salename      =  bfimpdata_fil.salename   
                impdata_fil.srate         =  bfimpdata_fil.srate      
                impdata_fil.comdat        =  bfimpdata_fil.comdat                                      
                impdata_fil.expdat        =  bfimpdata_fil.expdat                                      
                impdata_fil.agreedat      =  bfimpdata_fil.agreedat  
                impdata_fil.firstdat      =  bfimpdata_fil.firstdat  
                impdata_fil.packcod       =  bfimpdata_fil.packcod   
                impdata_fil.camp_no       =  bfimpdata_fil.camp_no   
                impdata_fil.campen        =  bfimpdata_fil.campen    
                impdata_fil.specon        =  bfimpdata_fil.specon    
                impdata_fil.product       =  bfimpdata_fil.product   
                impdata_fil.promo         =  bfimpdata_fil.promo     
                impdata_fil.rencnt        =  bfimpdata_fil.rencnt    
                impdata_fil.prepol        =  bfimpdata_fil.prepol    
                impdata_fil.compul        =  bfimpdata_fil.compul    
                impdata_fil.insref        =  bfimpdata_fil.insref    
                impdata_fil.instyp        =  bfimpdata_fil.instyp    
                impdata_fil.inslang       =  bfimpdata_fil.inslang   
                impdata_fil.tiname        =  bfimpdata_fil.tiname    
                impdata_fil.insnam        =  bfimpdata_fil.insnam    
                impdata_fil.lastname      =  bfimpdata_fil.lastname  
                impdata_fil.icno          =  bfimpdata_fil.icno      
                impdata_fil.insbr         =  bfimpdata_fil.insbr     
                impdata_fil.occup         =  bfimpdata_fil.occup     
                impdata_fil.addr          =  bfimpdata_fil.addr      
                impdata_fil.tambon        =  bfimpdata_fil.tambon    
                impdata_fil.amper         =  bfimpdata_fil.amper     
                impdata_fil.country       =  bfimpdata_fil.country   
                impdata_fil.post          =  bfimpdata_fil.post      
                impdata_fil.provcod       =  bfimpdata_fil.provcod   
                impdata_fil.distcod       =  bfimpdata_fil.distcod   
                impdata_fil.sdistcod      =  bfimpdata_fil.sdistcod 
                impdata_fil.jpae          =  bfimpdata_fil.jpae 
                impdata_fil.jpjtl         =  bfimpdata_fil.jpjtl
                impdata_fil.jpts          =  bfimpdata_fil.jpts 
                impdata_fil.gender        =  bfimpdata_fil.gender    
                impdata_fil.tele1         =  bfimpdata_fil.tele1     
                impdata_fil.tele2         =  bfimpdata_fil.tele2     
                impdata_fil.mail1         =  bfimpdata_fil.mail1     
                impdata_fil.mail2         =  bfimpdata_fil.mail2     
                impdata_fil.mail3         =  bfimpdata_fil.mail3     
                impdata_fil.mail4         =  bfimpdata_fil.mail4     
                impdata_fil.mail5         =  bfimpdata_fil.mail5     
                impdata_fil.mail6         =  bfimpdata_fil.mail6     
                impdata_fil.mail7         =  bfimpdata_fil.mail7     
                impdata_fil.mail8         =  bfimpdata_fil.mail8     
                impdata_fil.mail9         =  bfimpdata_fil.mail9     
                impdata_fil.mail10        =  bfimpdata_fil.mail10    
                impdata_fil.fax           =  bfimpdata_fil.fax       
                impdata_fil.lineID        =  bfimpdata_fil.lineID    
                impdata_fil.name2         =  bfimpdata_fil.name2     
                impdata_fil.name3         =  bfimpdata_fil.name3     
                /*impdata_fil.benname       =  bfimpdata_fil.benname  */ /*A65-0043*/ 
                impdata_fil.payercod      =  bfimpdata_fil.payercod  
                impdata_fil.vatcode       =  bfimpdata_fil.vatcode   
                impdata_fil.poltyp        =  bfimpdata_fil.poltyp
                impdata_fil.instot        =  bfimpdata_fil.instot
                impdata_fil.usrid         =  bfimpdata_fil.usrid 
                impdata_fil.progid        =  bfimpdata_fil.progid
                impdata_fil.comment       =  ""
                impdata_fil.entdat        =  string(TODAY)               /*entry date*/
                impdata_fil.enttim        =  STRING(TIME, "HH:MM:SS")    /*entry time*/
                impdata_fil.trandat       =  STRING(fi_loaddat)          /*tran date*/
                impdata_fil.trantim       =  STRING(TIME, "HH:MM:SS") .  /*tran time*/
            ASSIGN 
                impdata_fil.riskno        =  INT(wf_riskno)
                impdata_fil.itemno        =  INT(wf_num)
                /*impdata_fil.policyno      =  trim(wf_policyno)       
                impdata_fil.n_branch      =  trim(wf_n_branch)        
                impdata_fil.agent         =  trim(wf_agent)
                impdata_fil.vatcode       =  trim(wf_vatcode )*/
                impdata_fil.benname       =  trim(wf_benname)  /*A65-0043*/
                impdata_fil.covcod        =  trim(wf_covcod )  
                impdata_fil.garage        =  trim(wf_garage )  
                impdata_fil.special       =  trim(wf_special)  
                impdata_fil.inspec        =  trim(wf_inspec )  
                impdata_fil.class70       =  trim(wf_class70)  
                impdata_fil.vehuse        =  trim(wf_vehuse)
                impdata_fil.redbook       =  TRIM(wf_redbook) /* Ranu : A65-0079*/
                impdata_fil.brand         =  trim(wf_brand)  
                impdata_fil.model         =  trim(wf_model)  
                impdata_fil.submodel      =  trim(wf_submodel)  
                impdata_fil.yrmanu        =  trim(wf_caryear)  
                impdata_fil.chasno        =  trim(wf_chasno)  
                impdata_fil.eng           =  trim(wf_eng)  
                impdata_fil.seat          =  INTE(wf_seat)  
                impdata_fil.engcc         =  INTE(wf_engcc)  
                impdata_fil.weight        =  DECI(wf_weight) 
                impdata_fil.watt          =  INTE(wf_watt)  
                impdata_fil.body          =  trim(wf_body )  
                impdata_fil.typ           =  trim(wf_type )  
                impdata_fil.re_year       =  trim(wf_re_year)  
                impdata_fil.vehreg        =  trim(wf_vehreg )  
                impdata_fil.re_country    =  trim(wf_re_country)
                impdata_fil.cargrp        =  trim(wf_cargrp )   
                impdata_fil.colorcar      =  trim(wf_colorcar )
                impdata_fil.fule          =  trim(wf_fule)   
                impdata_fil.drivnam       =  trim(wf_drivnam)   
               /* comment by : A67-0029 
                impdata_fil.ntitle1       =  if trim(wf_ntitle1)    = "-" then "" else trim(wf_ntitle1)   
                impdata_fil.drivername1   =  if trim(wf_drivername1)= "-" then "" else trim(wf_drivername1)
                impdata_fil.dname2        =  if trim(wf_dname2)     = "-" then "" else trim(wf_dname2)  
                impdata_fil.dicno         =  if trim(wf_dicno )     = "-" then "" else trim(wf_dicno )  
                impdata_fil.dgender1      =  if trim(wf_dgender1)   = "-" then "" else trim(wf_dgender1)  
                impdata_fil.dbirth        =  if trim(wf_dbirth)     = "-" then "" else trim(wf_dbirth)  
                impdata_fil.docoup        =  if trim(wf_docoup)     = "-" then "" else trim(wf_docoup)  
                impdata_fil.ddriveno      =  if trim(wf_ddriveno)   = "-" then "" else trim(wf_ddriveno)  
                impdata_fil.ntitle2       =  if trim(wf_ntitle2 )   = "-" then "" else trim(wf_ntitle2 )  
                impdata_fil.drivername2   =  if trim(wf_drivername2)= "-" then "" else trim(wf_drivername2)
                impdata_fil.ddname1       =  if trim(wf_ddname1)    = "-" then "" else trim(wf_ddname1)  
                impdata_fil.ddicno        =  if trim(wf_ddicno)     = "-" then "" else trim(wf_ddicno)  
                impdata_fil.dgender2      =  if trim(wf_dgender2)   = "-" then "" else trim(wf_dgender2)
                impdata_fil.ddbirth       =  if trim(wf_ddbirth)    = "-" then "" else trim(wf_ddbirth)
                impdata_fil.ddocoup       =  if trim(wf_ddocoup)    = "-" then "" else trim(wf_ddocoup)
                impdata_fil.dddriveno     =  if trim(wf_dddriveno)  = "-" then "" else trim(wf_dddriveno)*/
                impdata_fil.baseplus      =  DECI(wf_baseplus)  
                impdata_fil.siplus        =  DECI(wf_siplus)
                impdata_fil.rs10          =  DECI(wf_rs10)   
                impdata_fil.comper        =  if trim(wf_comper)   = "U"  then 999999999  else INT(wf_comper)  
                impdata_fil.comacc        =  if trim(wf_comacc)   = "U"  then 999999999  else INT(wf_comacc)  
                impdata_fil.deductpd      =  if trim(wf_deductpd) = "U"  then 999999999  else INT(wf_deductpd)  
                impdata_fil.DOD           =  DECI(wf_DOD)
                impdata_fil.dgatt         =  DECI(wf_dod1)  /*A65-0079*/
                impdata_fil.DPD           =  DECI(wf_DPD)   
                impdata_fil.si            =  DECI(wf_tpfire) 
                /*impdata_fil.NO_411        =  DECI(wf_NO_411 ) */ /* A65-0079*/
                impdata_fil.NO_411        =  IF trim(wf_no_411) = "" THEN (-1) ELSE DECI(wf_NO_411 )  /* A65-0079*/
                impdata_fil.seat41        =  IF INTE(wf_ac2) <> 0 THEN INTE(wf_ac2) + 1 ELSE INTE(wf_seat) 
                /*impdata_fil.NO_412        =  DECI(wf_NO_412)  */ /*A65-0079*/ 
                impdata_fil.NO_412        =  IF trim(wf_no_412) = "" THEN (-1) ELSE DECI(wf_NO_412)      /*A65-0079*/ 
                impdata_fil.NO_413        =  DECI(wf_NO_413)   
                impdata_fil.pass_no       =  DECI(wf_ac6)   
                impdata_fil.NO_414        =  DECI(wf_NO_414)
                /*impdata_fil.NO_42         =  DECI(wf_no_42) */  /*A65-0079*/
                /*impdata_fil.NO_43         =  DECI(wf_no_43) */  /*A65-0079*/
                impdata_fil.NO_42         =  if trim(wf_no_42) = "" then (-1) else  DECI(wf_NO_42) /*A65-0079*/ 
                impdata_fil.NO_43         =  if trim(wf_no_43) = "" then (-1) else  DECI(wf_NO_43) /*A65-0079*/ 
                impdata_fil.base          =  DECI(wf_base)
                impdata_fil.unname        =  deci(wf_unname) 
                impdata_fil.nname         =  deci(wf_nname) 
                impdata_fil.tpbi          =  deci(wf_tpbi) 
                impdata_fil.dgsi           = DECI(wf_tpbiocc) /*A65-0079*/
                impdata_fil.tppd          =  deci(wf_tppd) 
                impdata_fil.int1          =  int(wf_dodamt)   /*A65-0079*/
                impdata_fil.int2          =  int(wf_dod1amt)  /*A65-0079*/
                impdata_fil.int3          =  int(wf_dpdamt)   /*A65-0079*/
                impdata_fil.ry01          =  deci(wf_ry01)
                impdata_fil.deci1         =  deci(wf_ry412)   /*A65-0079*/
                impdata_fil.deci2         =  deci(wf_ry413)   /*A65-0079*/
                impdata_fil.deci3         =  deci(wf_ry414)   /*A65-0079*/
                impdata_fil.ry02          =  deci(wf_ry02)   
                impdata_fil.ry03          =  deci(wf_ry03)   
                impdata_fil.fleet         =  trim(wf_fleet)   
                impdata_fil.ncb           =  trim(wf_ncb)
                impdata_fil.claim         =  trim(wf_claim)   
                impdata_fil.dspc          =  trim(wf_dspc)   
                impdata_fil.cctv          =  trim(wf_cctv)   
                impdata_fil.dstf          =  trim(wf_dstf)   
                impdata_fil.fleetprem     =  deci(wf_fleetprem)
                impdata_fil.ncbprem       =  deci(wf_ncbprem)   
                impdata_fil.clprem        =  deci(wf_clprem )   
                impdata_fil.dspcprem      =  deci(wf_dspcprem) 
                impdata_fil.cctvprem      =  deci(wf_cctvprem) 
                impdata_fil.dstfprem      =  deci(wf_dstfprem) 
                impdata_fil.premt         =  deci(wf_premt )   
                impdata_fil.rstp_t        =  deci(wf_rstp_t)   
                impdata_fil.rtax_t        =  deci(wf_rtax_t)   
                impdata_fil.comper70      =  IF trim(wf_comper70)  =  " " THEN (-1) ELSE deci(wf_comper70)    /* ค่าว่างใส่ -1 ดึง comm ตามระบบ  ถ้าระบุ 0 ไม่มีค่าคอม */
                impdata_fil.comprem70     =  IF trim(wf_comprem70) =  " " THEN (-1) ELSE deci(wf_comprem70)  /* ค่าว่างใส่ -1 คำนวณ comm ตามระบบ ถ้าระบุ 0 ไม่มีค่าคอม */
                impdata_fil.agco70        =  trim(wf_agco70 )  
                impdata_fil.comco_per70   =  deci(wf_comco_per70) 
                impdata_fil.comco_prem70  =  deci(wf_comco_prem70)
                impdata_fil.cltxt         =  trim(wf_cltxt )
                impdata_fil.clamount      =  inte(wf_clamount)
                impdata_fil.faultno       =  inte(wf_faultno)  
                impdata_fil.faultprm      =  inte(wf_faultprm)  
                impdata_fil.goodno        =  inte(wf_goodno)  
                impdata_fil.goodprm       =  inte(wf_goodprm)  
                impdata_fil.loss          =  inte(wf_loss) 
                impdata_fil.prempa        =  IF LENGTH(impdata_fil.class70) = 5 THEN SUBSTR(impdata_fil.class70,1,1)                                                       
                                             ELSE IF LENGTH(impdata_fil.class70) = 4 AND SUBSTR(impdata_fil.class70,4,1) <> "E" THEN SUBSTR(impdata_fil.class70,1,1)                   
                                             ELSE TRIM(fi_pack)                                                                                            
                impdata_fil.subclass      =  IF LENGTH(impdata_fil.class70) = 5 THEN SUBSTR(impdata_fil.class70,2,4)                                                       
                                             ELSE IF LENGTH(impdata_fil.class70) = 4 AND SUBSTR(impdata_fil.class70,4,1) <> "E" THEN SUBSTR(impdata_fil.class70,2,3) 
                                             ELSE impdata_fil.class70     
                /*impdata_fil.dspc          = IF int(wf_cctv) <> 0 AND INT(wf_dspc) = 0  THEN "10" ELSE TRIM(wf_dspc) */ /* ranu 21/01/22*/
                impdata_fil.dspc          = IF DECI(wf_dspc) = 0 THEN wf_cctv ELSE string(DECI(wf_dspc) + DECI(wf_cctv))  /* ranu 21/01/22*/
                impdata_fil.dspcprem      = IF deci(wf_dspcprem) = 0 THEN deci(wf_cctvprem) ELSE DECI(wf_dspcprem) + DECI(wf_cctvprem) /*A65-0079*/
                impdata_fil.tariff        = "X"
                /*impdata_fil.vehuse        = IF trim(wf_class70) <> "" THEN SUBSTR(wf_class70,2,1) ELSE ""*/ /* ranu : 15/12/2021*/
                impdata_fil.n_IMPORT      = "CAR".
                ASSIGN 
                impacc_fil.policyno       =  TRIM(bfimpdata_fil.policyno)
                impacc_fil.riskno         =  int(wf_riskno)
                impacc_fil.itemno         =  int(wf_num)
                impacc_fil.accdata1       =  trim(wf_accdata1)   
                impacc_fil.accdata2       =  trim(wf_accdata2)   
                impacc_fil.accdata3       =  trim(wf_accdata3)   
                impacc_fil.accdata4       =  trim(wf_accdata4)   
                impacc_fil.accdata5       =  trim(wf_accdata5)   
                impacc_fil.accdata6       =  trim(wf_accdata6)   
                impacc_fil.accdata7       =  trim(wf_accdata7)   
                impacc_fil.accdata8       =  trim(wf_accdata8)  
                impacc_fil.accdata9       =  trim(wf_accdata9)  
                impacc_fil.accdata10      =  trim(wf_accdata10)
                impacc_fil.usrid          =  trim(bfimpdata_fil.usrid)    
                impacc_fil.progid         =  trim(bfimpdata_fil.progid) . 
                RUN proc_adddriver.

                IF int(wf_num) = 1 THEN DO:
                    RUN proc_ass_cardetail2.
                    RELEASE impinst_fil .
                END.
        END.
    END.
    RELEASE impdata_fil.
    RELEASE impacc_fil.
    RELEASE impdriv_fil.
   
END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_calpremt C-Win 
PROCEDURE 00-proc_calpremt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Add by A64-0138      
------------------------------------------------------------------------------*/
/* comment by  : A67-0029 ....
DEF VAR chk     AS LOGICAL.
DEF VAR n_prem  AS DECI.

FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.

IF impdata_fil.poltyp = "V70" THEN DO:
    ASSIGN fi_process = "Create data to base..." + impdata_fil.policy .
    DISP fi_process WITH FRAM fr_main.
    RUN proc_initcalprem.  /*A65-0079*/

    ASSIGN     
          /*nv_cstflg  = "C"  /*C=CC ; S=Seat ; T=Tons ; W=Watts*/ 
         nv_engcst  = 1900*/ /* ต้องใส่ค่าตาม nv_cstflg         
         nv_drivno  = 0   */
         /*nv_supe    = NO*/  
         nv_usrid    = USERID(LDBNAME(1))  /*A65-0079*/
         nv_campcd   = impdata_fil.packcod /*A65-0079*/
         nv_covcod   = impdata_fil.covcod                                              
         nv_class    = trim(impdata_fil.prempa) + trim(impdata_fil.subclass)     /* T110 */                                     
         nv_vehuse   = impdata_fil.vehuse   
         nv_driage1  = nv_drivage1                                 
         nv_driage2  = nv_drivage2                                    
         nv_yrmanu   = INT(impdata_fil.yrmanu)                         
         nv_totsi    = sic_bran.uwm130.uom6_v       
         nv_totfi    = sic_bran.uwm130.uom7_v
         nv_vehgrp   = impdata_fil.cargrp                                                     
         nv_access   = IF impdata_fil.special  <> "A" THEN "" ELSE TRIM(impdata_fil.special)                                                  
         nv_tpbi1si  = nv_uom1_v             
         nv_tpbi2si  = nv_uom2_v             
         nv_tppdsi   = nv_uom5_v             
         nv_411si    = impdata_fil.NO_411      
         nv_412si    = impdata_fil.NO_412      
         nv_413si    = impdata_fil.NO_413                      
         nv_414si    = impdata_fil.NO_414                    
         nv_42si     = impdata_fil.no_42               
         nv_43si     = impdata_fil.no_43  
         nv_411prmt  = impdata_fil.ry01
         nv_412prmt  = impdata_fil.deci1    /*A65-0079*/
         nv_413prmt  = impdata_fil.deci2    /*A65-0079*/
         nv_414prmt  = impdata_fil.deci3    /*A65-0079*/
         nv_42prmt   = impdata_fil.ry02
         nv_43prmt   = impdata_fil.ry03
         nv_seat41   = impdata_fil.seat41   
         nv_dedod    = dod1      
         nv_addod    = dod2                                
         nv_dedpd    = deci(impdata_fil.DPD)                                    
         nv_ncbp     = deci(impdata_fil.ncb)                                     
         nv_fletp    = deci(impdata_fil.fleet)                                  
         nv_dspcp    = deci(impdata_fil.dspc)                                      
         nv_dstfp    = deci(impdata_fil.dstf)                                                    
         nv_clmp     = deci(impdata_fil.claim)
         /* Add : A65-0079 */
         nv_mainprm  = IF INT(impdata_fil.unname) <> 0 THEN deci(impdata_fil.unname) 
                       ELSE deci(impdata_fil.nname) 
         nv_dodamt   = deci(impdata_fil.int1)
         nv_dadamt   = deci(impdata_fil.int2)
         nv_dpdamt   = deci(impdata_fil.int3)
         nv_ncbamt   = deci(impdata_fil.ncbprem)
         nv_fletamt  = deci(impdata_fil.fleetprem) 
         nv_dspcamt  = deci(impdata_fil.dspcprem)  
         nv_dstfamt  = deci(impdata_fil.dstfprem)  
         nv_clmamt   = deci(impdata_fil.clprem)
         /* end : A65-0079*/
         nv_baseprm  = deci(impdata_fil.base) 
         nv_baseprm3 = deci(impdata_fil.baseplus) 
         nv_pdprem   = 0
         nv_netprem  = DECI(impdata_fil.premt) /* เบี้ยสุทธิ */                                                
         nv_gapprm   = 0                                                       
         nv_flagprm  = "N"                 /* N = เบี้ยสุทธิ, G = เบี้ยรวม */                                    
         nv_effdat   = sic_bran.uwm100.comdat                             
         nv_ratatt   = 0                    
         nv_siatt    = 0                                                   
         nv_netatt   = 0 
         nv_fltatt   = 0 
         nv_ncbatt   = 0 
         nv_dscatt   = 0      
         nv_attgap   = 0 
         nv_atfltgap = 0 
         nv_atncbgap = 0 
         nv_atdscgap = 0 
         nv_packatt  = "" 
         /*nv_status  = "" */
         nv_flgsht  = IF impdata_fil.srate = "Y" THEN "S" ELSE "P" /*A65-0079*/
         nv_fcctv   = IF impdata_fil.cctv <> "" THEN YES ELSE NO . 

     FIND FIRST stat.clastab_fil USE-INDEX clastab01 WHERE
           clastab_fil.CLASS  = nv_class     AND
           clastab_fil.covcod = impdata_fil.covcod    NO-LOCK NO-ERROR.
        IF AVAIL stat.clastab_fil THEN DO:
            IF clastab_fil.unit = "C" THEN DO:
                ASSIGN
                    nv_cstflg = IF SUBSTR(nv_class,5,1) = "E" THEN "W" ELSE clastab_fil.unit
                    nv_engine = IF SUBSTR(nv_class,5,1) = "E" THEN DECI(impdata_fil.watt) ELSE INT(impdata_fil.engcc).
            END.
            ELSE IF clastab_fil.unit = "S" THEN DO:
                ASSIGN
                    nv_cstflg = clastab_fil.unit
                    nv_engine = INT(impdata_fil.seat).
            END.
            ELSE IF clastab_fil.unit = "T" THEN DO:
                ASSIGN
                    nv_cstflg = clastab_fil.unit
                    nv_engine = DECI(sic_bran.uwm301.Tons).
            END.
            nv_engcst = nv_engine .
        END.
    IF nv_cstflg = "W" THEN ASSIGN sic_bran.uwm301.watt = nv_engine . /* add  */
    IF impdata_fil.redbook = ""  THEN DO:
        IF nv_cstflg <> "T" THEN DO:
            /*RUN wgw/wgwredbook(input  impdata_fil.brand ,  */ /*A65-0079*/
              RUN wgw/wgwredbk1(input impdata_fil.brand ,   /*A65-0079*/
                               input  impdata_fil.model ,  
                               input  nv_totsi      ,  
                               INPUT  impdata_fil.tariff,  
                               input  SUBSTR(nv_class,2,5),   
                               input  impdata_fil.yrmanu, 
                               input  nv_engine  ,
                               input  0 , 
                               INPUT-OUTPUT impdata_fil.redbook) .
        END.
        ELSE DO:
            /*RUN wgw/wgwredbook(input  impdata_fil.brand ,  */ /*A65-0079*/
             RUN wgw/wgwredbk1(input  impdata_fil.brand ,   /*A65-0079*/  
                               input  impdata_fil.model ,  
                               input  INT(impdata_fil.si) ,  
                               INPUT  impdata_fil.tariff,  
                               input  SUBSTR(nv_class,2,5),   
                               input  impdata_fil.yrmanu, 
                               input  0  ,
                               input  nv_engine , 
                               INPUT-OUTPUT impdata_fil.redbook) .
        END.

        IF impdata_fil.redbook <> ""  THEN ASSIGN sic_bran.uwm301.modcod = impdata_fil.redbook .
        ELSE DO:
         ASSIGN
                impdata_fil.comment = impdata_fil.comment + "| " + "Redbook is Null !! "
                impdata_fil.WARNING = "Redbook เป็นค่าว่างไม่สามารถนำเข้ามูลเข้าได้ " .
                impdata_fil.pass  = "N".  /*A65-0079*/
        END.
    END.

    FIND LAST stat.maktab_fil WHERE maktab_fil.makdes   =  impdata_fil.brand AND 
                                    maktab_fil.sclass   =  trim(SUBSTR(nv_class,2,4)) NO-LOCK NO-ERROR.
        IF AVAIL stat.maktab_fil THEN nv_supe = maktab_fil.impchg.

    IF sic_bran.uwm100.expdat NE ? AND sic_bran.uwm100.comdat NE ? THEN DO:
        IF ( DAY(sic_bran.uwm100.comdat)     =  DAY(sic_bran.uwm100.expdat)     AND
           MONTH(sic_bran.uwm100.comdat)     =  MONTH(sic_bran.uwm100.expdat)   AND
            YEAR(sic_bran.uwm100.comdat) + 1 =  YEAR(sic_bran.uwm100.expdat) )  OR
           ( DAY(sic_bran.uwm100.comdat)     =   29                             AND
           MONTH(sic_bran.uwm100.comdat)     =   02                             AND
             DAY(sic_bran.uwm100.expdat)     =   01                             AND
           MONTH(sic_bran.uwm100.expdat)     =   03                             AND
            YEAR(sic_bran.uwm100.comdat) + 1 =  YEAR(sic_bran.uwm100.expdat) )
        THEN DO:
          nv_polday = 365.
        END.
        ELSE DO:
          nv_polday = (sic_bran.uwm100.expdat  - sic_bran.uwm100.comdat ) + 1 .     /*    =  366  วัน */
        END.
    END.
    IF nv_polday < 365 THEN DO:
        nv_polday  = (sic_bran.uwm100.expdat  - sic_bran.uwm100.comdat).
       
    END.
    /*                       
    MESSAGE "  nv_policy   "  sic_bran.uwm100.policy     
            "  nv_rencnt   "  sic_bran.uwm100.rencnt    skip
            "  nv_riskno   "  nv_riskno     
            "  nv_itemno   "  nv_itemno     skip
            "  nv_batchyr  "  nv_batchyr    
            "  nv_batchno  "  nv_batchno    
            "  nv_batcnt   "  nv_batcnt     skip
            "  nv_polday   "  nv_polday     skip
            "  nv_covcod   "  nv_covcod     skip
            "  nv_class    "  nv_class      skip
            "  nv_vehuse   "  nv_vehuse     skip
            "  nv_cstflg   "  nv_cstflg     skip
            "  nv_engcst   "  nv_engcst     skip
            "  nv_drivno   "  nv_drivno     
            "  nv_driage1  "  nv_driage1    
            "  nv_driage2  "  nv_driage2    skip
            "  nv_yrmanu   "  nv_yrmanu     skip
            "  nv_totsi    "  nv_totsi      skip
            "  nv_vehgrp   "  nv_vehgrp     skip
            "  nv_access   "  nv_access     skip
            "  nv_supe     "  nv_supe       skip
            "  nv_tpbi1si  "  nv_tpbi1si    skip
            "  nv_tpbi2si  "  nv_tpbi2si    skip
            "  nv_tppdsi   "  nv_tppdsi     skip
            "  nv_411si    "  nv_411si      skip
            "  nv_412si    "  nv_412si      skip
            "  nv_413si    "  nv_413si      skip
            "  nv_414si    "  nv_414si      skip
            "  nv_42si     "  nv_42si       skip
            "  nv_43si     "  nv_43si       skip
            "  nv_41prmt   "  nv_41prmt     skip
            "  nv_42prmt   "  nv_42prmt     skip
            "  nv_43prmt   "  nv_43prmt     skip
            "  nv_seat41   "  nv_seat41     skip
            "  nv_dedod    "  nv_dedod      skip
            "  nv_addod    "  nv_addod      skip
            "  nv_dedpd    "  nv_dedpd      skip
            "  nv_ncbp     "  nv_ncbp       skip
            "  nv_fletp    "  nv_fletp      skip
            "  nv_dspcp    "  nv_dspcp      skip
            "  nv_dstfp    "  nv_dstfp      skip
            "  nv_clmp     "  nv_clmp       skip
            "  nv_baseprm  "  nv_baseprm    skip
            "  nv_baseprm3 "  nv_baseprm3   skip
            "  nv_netprem  "  nv_netprem    skip
            "  nv_pdprem   "  nv_pdprem     skip
            "  nv_gapprem  "  nv_gapprem    skip
            "  nv_flagprm  "  nv_flagprm    skip
            "  nv_effdat   "  nv_effdat     skip
            "  nv_status   "  nv_status     skip
            "  nv_fcctv    "  nv_fcctv      skip
            "  nv_uom1_c   "  nv_uom1_c     skip
            "  nv_uom2_c   "  nv_uom2_c     skip
            "  nv_uom5_c   "  nv_uom5_c     skip
            "  nv_uom6_c   "  nv_uom6_c     skip
            "  nv_uom7_c   "  nv_uom7_c     skip
            "  nv_message  "  nv_message    skip
            "  nv_ratatt   "  nv_ratatt     skip
            "  nv_siatt    "  nv_siatt      skip
            "  nv_netatt   "  nv_netatt     skip
            "  nv_fltatt   "  nv_fltatt     skip
            "  nv_ncbatt   "  nv_ncbatt     skip
            "  nv_dscatt   "  nv_dscatt    VIEW-AS ALERT-BOX.*/
    
    RUN WUW\WUWPADP3.P(INPUT sic_bran.uwm100.policy,
                       INPUT nv_campcd , 
                       INPUT sic_bran.uwm100.rencnt,
                       INPUT sic_bran.uwm100.endcnt,
                       INPUT 0  ,
                       INPUT nv_riskno ,
                       INPUT nv_itemno ,  
                       INPUT nv_batchyr, 
                       INPUT nv_batchno,
                       INPUT nv_batcnt , 
                       INPUT nv_polday ,
                       INPUT nv_usrid  ,
                       INPUT "wgwlfeet"  ,
                       INPUT-OUTPUT nv_covcod ,
                       INPUT-OUTPUT nv_class  ,
                       INPUT-OUTPUT nv_vehuse ,
                       INPUT-OUTPUT nv_cstflg ,
                       INPUT-OUTPUT nv_engcst ,
                       INPUT-OUTPUT nv_drivno ,
                       INPUT-OUTPUT nv_driage1,
                       INPUT-OUTPUT nv_driage2,
                       INPUT-OUTPUT nv_pdprm0 , 
                       INPUT-OUTPUT nv_yrmanu ,
                       INPUT-OUTPUT nv_totsi  ,
                       INPUT-OUTPUT nv_totfi  ,
                       INPUT-OUTPUT nv_vehgrp,  
                       INPUT-OUTPUT nv_access,  
                       INPUT-OUTPUT nv_supe,                       
                       INPUT-OUTPUT nv_tpbi1si, 
                       INPUT-OUTPUT nv_tpbi2si, 
                       INPUT-OUTPUT nv_tppdsi,                 
                       INPUT-OUTPUT nv_411si,   
                       INPUT-OUTPUT nv_412si,   
                       INPUT-OUTPUT nv_413si,   
                       INPUT-OUTPUT nv_414si,   
                       INPUT-OUTPUT nv_42si,    
                       INPUT-OUTPUT nv_43si,
                       INPUT-OUTPUT nv_411prmt,   /* ระบุเบี้ย รย.*/
                       INPUT-OUTPUT nv_412prmt,   /* ระบุเบี้ย รย.*/
                       INPUT-OUTPUT nv_413prmt,   /* ระบุเบี้ย รย.*/
                       INPUT-OUTPUT nv_414prmt,   /* ระบุเบี้ย รย.*/
                       INput-output nv_42prmt,   /* ระบุเบี้ย รย.*/
                       INput-output nv_43prmt,   /* ระบุเบี้ย รย.*/
                       INPUT-OUTPUT nv_seat41,              
                       INPUT-OUTPUT nv_dedod,    
                       INPUT-OUTPUT nv_addod,    
                       INPUT-OUTPUT nv_dedpd,    
                       input-output nv_dodamt,   /* ระบุเบี้ย DOD */ 
                       input-output nv_dadamt,   /* ระบุเบี้ย DOD1 */ 
                       input-output nv_dpdamt,   /* ระบุเบี้ย DPD */ 
                       INPUT-OUTPUT nv_ncbp,     
                       INPUT-OUTPUT nv_fletp,    
                       INPUT-OUTPUT nv_dspcp,    
                       INPUT-OUTPUT nv_dstfp,    
                       INPUT-OUTPUT nv_clmp,     
                       input-output nv_ncbamt ,  /* ระบุเบี้ย  NCB PREMIUM */       
                       input-output nv_fletamt,  /* ระบุเบี้ย  FLEET PREMIUM */     
                       input-output nv_dspcamt,  /* ระบุเบี้ย  DSPC PREMIUM */      
                       input-output nv_dstfamt,  /* ระบุเบี้ย  DSTF PREMIUM */      
                       input-output nv_clmamt ,  /* ระบุเบี้ย  LOAD CLAIM PREMIUM */
                       INPUT-OUTPUT nv_baseprm,
                       INPUT-OUTPUT nv_baseprm3,
                       INPUT-OUTPUT nv_mainprm,  /* Main Premium หรือเบี้ยหลัก ช่อง Name/Unname Premium (HG) */
                       INPUT-OUTPUT nv_pdprem,
                       INPUT-OUTPUT nv_netprem, 
                       INPUT-OUTPUT nv_gapprem,  
                       INPUT-OUTPUT nv_flagprm,             
                       INPUT-OUTPUT nv_effdat,
                       INPUT-OUTPUT nv_ratatt, 
                       INPUT-OUTPUT nv_siatt ,
                       INPUT-OUTPUT nv_netatt,    
                       INPUT-OUTPUT nv_fltatt, 
                       INPUT-OUTPUT nv_ncbatt, 
                       INPUT-OUTPUT nv_dscatt,
                       input-output nv_attgap ,   /*a65-0079*/
                       input-output nv_atfltgap,  /*a65-0079*/
                       input-output nv_atncbgap,  /*a65-0079*/
                       input-output nv_atdscgap,  /*a65-0079*/
                       input-output nv_packatt ,  /*a65-0079*/
                       INPUT-OUTPUT nv_fcctv ,  /* cctv = yes/no */
                       INPUT-OUTPUT nv_flgsht , /* Short rate = "S" , Pro rate = "P" */
                       OUTPUT nv_uom1_c ,  
                       OUTPUT nv_uom2_c ,  
                       OUTPUT nv_uom5_c ,  
                       OUTPUT nv_uom6_c ,
                       OUTPUT nv_uom7_c ,
                       output nv_gapprm ,
                       output nv_pdprm  ,
                       OUTPUT nv_status ,
                       OUTPUT nv_message ).
    ASSIGN                        
        sic_bran.uwm130.uom1_c  = nv_uom1_c
        sic_bran.uwm130.uom2_c  = nv_uom2_c
        sic_bran.uwm130.uom5_c  = nv_uom5_c
        sic_bran.uwm130.uom6_c  = nv_uom6_c
        sic_bran.uwm130.uom7_c  = nv_uom7_c .
    
    IF nv_drivno <> 0  THEN ASSIGN sic_bran.uwm301.actprm = nv_pdprm0. 

    /*IF nv_status = "NO" THEN DO:*/
    IF nv_message <> "" THEN DO:   /*A65-0079*/
        IF INDEX(nv_message,"Not Found Benefit") <> 0 THEN ASSIGN impdata_fil.pass  = "N". /*A65-0043*/
        ASSIGN
                impdata_fil.comment = impdata_fil.comment + "|" + nv_message
                impdata_fil.WARNING = impdata_fil.WARNING + "|" + nv_message.
                /*impdata_fil.pass    = "N".*/
    END.
    
END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_calpremtV1 C-Win 
PROCEDURE 00-proc_calpremtV1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Add by A64-0138      
------------------------------------------------------------------------------*/
/*DEF VAR chk     AS LOGICAL.
DEF VAR n_prem  AS DECI.

FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.

IF impdata_fil.poltyp = "V70" THEN DO:
    ASSIGN fi_process = "Create data to base..." + impdata_fil.policy .
    DISP fi_process WITH FRAM fr_main.
    ASSIGN 
         nv_polday  = 0 
         nv_covcod  = ""  
         nv_class   = ""  
         nv_vehuse  = ""  
         nv_cstflg  = ""  /*C=CC ; S=Seat ; T=Tons ; W=Watts*/    
         nv_engcst  = 0   /* ต้องใส่ค่าตาม nv_cstflg  */         
         /*nv_drivno  = 0*/
         nv_driage1 = 0
         nv_driage2 = 0
         nv_pdprm0  = 0  /*เบี้ยส่วนลดผู้ขับขี่*/
         nv_yrmanu  = 0
         nv_totsi   = 0
         nv_totfi   = 0
         nv_vehgrp  = ""
         nv_access  = ""
         nv_supe    = NO
         nv_tpbi1si = 0
         nv_tpbi2si = 0
         nv_tppdsi  = 0   
         nv_411si   = 0
         nv_412si   = 0
         nv_413si   = 0
         nv_414si   = 0  
         nv_42si    = 0
         nv_43si    = 0
         nv_41prmt  = 0  
         nv_42prmt  = 0  
         nv_43prmt  = 0  
         nv_seat41  = 0          
         nv_dedod   = 0
         nv_addod   = 0
         nv_dedpd   = 0        
         nv_ncbp    = 0
         nv_fletp   = 0
         nv_dspcp   = 0
         nv_dstfp   = 0
         nv_clmp    = 0
         nv_baseprm  = 0
         nv_baseprm3 = 0
         nv_pdprem   = 0
         nv_netprem = 0     /*เบี้ยสุทธิ */
         nv_gapprm  = 0     /*เบี้ยรวม */
         nv_flagprm = "N"   /* N = เบี้ยสุทธิ, G = เบี้ยรวม */
         nv_effdat  = ?
         nv_ratatt  = 0 
         nv_siatt   = 0 
         nv_netatt  = 0 
         nv_fltatt  = 0 
         nv_ncbatt  = 0 
         nv_dscatt  = 0 
         nv_message = ""
         nv_status  = "" 
         nv_fcctv   = NO
         nv_uom1_c  = "" 
         nv_uom2_c  = "" 
         nv_uom5_c  = "" 
         nv_uom6_c  = "" 
         nv_uom7_c  = "" .

    ASSIGN     
          /*nv_cstflg  = "C"  /*C=CC ; S=Seat ; T=Tons ; W=Watts*/ 
         nv_engcst  = 1900*/ /* ต้องใส่ค่าตาม nv_cstflg         
         nv_drivno  = 0   */
         /*nv_supe    = NO*/      
         nv_covcod   = impdata_fil.covcod                                              
         nv_class    = trim(impdata_fil.prempa) + trim(impdata_fil.subclass)     /* T110 */                                     
         nv_vehuse   = impdata_fil.vehuse   
         nv_driage1  = nv_drivage1                                 
         nv_driage2  = nv_drivage2                                    
         nv_yrmanu   = INT(impdata_fil.yrmanu)                         
         nv_totsi    = sic_bran.uwm130.uom6_v       
         nv_totfi    = sic_bran.uwm130.uom7_v
         nv_vehgrp   = impdata_fil.cargrp                                                     
         nv_access   = IF impdata_fil.special  <> "A" THEN "" ELSE TRIM(impdata_fil.special)                                                  
         nv_tpbi1si  = nv_uom1_v             
         nv_tpbi2si  = nv_uom2_v             
         nv_tppdsi   = nv_uom5_v             
         nv_411si    = impdata_fil.NO_411      
         nv_412si    = impdata_fil.NO_412      
         nv_413si    = impdata_fil.NO_413                      
         nv_414si    = impdata_fil.NO_414                    
         nv_42si     = impdata_fil.no_42               
         nv_43si     = impdata_fil.no_43  
         nv_41prmt   = impdata_fil.ry01
         nv_42prmt   = impdata_fil.ry02
         nv_43prmt   = impdata_fil.ry03
         nv_seat41   = impdata_fil.seat41   
         nv_dedod    = dod1      
         nv_addod    = dod2                                
         nv_dedpd    = deci(impdata_fil.DPD)                                    
         nv_ncbp     = deci(impdata_fil.ncb)                                     
         nv_fletp    = deci(impdata_fil.fleet)                                  
         nv_dspcp    = deci(impdata_fil.dspc)                                      
         nv_dstfp    = deci(impdata_fil.dstf)                                                    
         nv_clmp     = deci(impdata_fil.claim)
         nv_baseprm  = deci(impdata_fil.base)
         nv_baseprm3 = deci(impdata_fil.baseplus) 
         nv_pdprem   = 0
         /*nv_netprem  = TRUNCATE(((deci(impdata_fil.premt) * 100 ) / 107.43 ),0 ) + 
                        (IF ((deci(impdata_fil.premt) * 100) / 107.43) - TRUNCATE(((deci(impdata_fil.premt) * 100 ) / 107.43 ),0 ) > 0 THEN 1 ELSE 0 )*/
         nv_netprem  = DECI(impdata_fil.premt) /* เบี้ยสุทธิ */                                                
         nv_gapprm  = 0                                                       
         nv_flagprm = "N"                 /* N = เบี้ยสุทธิ, G = เบี้ยรวม */                                    
         nv_effdat  = sic_bran.uwm100.comdat                             
         nv_ratatt  = 0                    
         nv_siatt   = 0                                                   
         nv_netatt  = 0 
         nv_fltatt  = 0 
         nv_ncbatt  = 0 
         nv_dscatt  = 0 
         /*nv_status  = "" */
         nv_fcctv   = IF impdata_fil.cctv <> "" THEN YES ELSE NO . 

     FIND FIRST stat.clastab_fil USE-INDEX clastab01 WHERE
           clastab_fil.CLASS  = nv_class     AND
           clastab_fil.covcod = impdata_fil.covcod    NO-LOCK NO-ERROR.
        IF AVAIL stat.clastab_fil THEN DO:
            IF clastab_fil.unit = "C" THEN DO:
                ASSIGN
                    nv_cstflg = IF SUBSTR(nv_class,5,1) = "E" THEN "W" ELSE clastab_fil.unit
                    nv_engine = IF SUBSTR(nv_class,5,1) = "E" THEN DECI(impdata_fil.watt) ELSE INT(impdata_fil.engcc).
            END.
            ELSE IF clastab_fil.unit = "S" THEN DO:
                ASSIGN
                    nv_cstflg = clastab_fil.unit
                    nv_engine = INT(impdata_fil.seat).
            END.
            ELSE IF clastab_fil.unit = "T" THEN DO:
                ASSIGN
                    nv_cstflg = clastab_fil.unit
                    nv_engine = DECI(sic_bran.uwm301.Tons).
            END.
            nv_engcst = nv_engine .
        END.
    IF nv_cstflg = "W" THEN ASSIGN sic_bran.uwm301.watt = nv_engine . /* add  */
    IF impdata_fil.redbook = ""  THEN DO:
        IF nv_cstflg <> "T" THEN DO:
            RUN wgw/wgwredbook(input  impdata_fil.brand ,  
                               input  impdata_fil.model ,  
                               input  nv_totsi      ,  
                               INPUT  impdata_fil.tariff,  
                               input  SUBSTR(nv_class,2,5),   
                               input  impdata_fil.yrmanu, 
                               input  nv_engine  ,
                               input  0 , 
                               INPUT-OUTPUT impdata_fil.redbook) .
        END.
        ELSE DO:
            RUN wgw/wgwredbook(input  impdata_fil.brand ,  
                               input  impdata_fil.model ,  
                               input  INT(impdata_fil.si) ,  
                               INPUT  impdata_fil.tariff,  
                               input  SUBSTR(nv_class,2,5),   
                               input  impdata_fil.yrmanu, 
                               input  0  ,
                               input  nv_engine , 
                               INPUT-OUTPUT impdata_fil.redbook) .
        END.

        IF impdata_fil.redbook <> ""  THEN ASSIGN sic_bran.uwm301.modcod = impdata_fil.redbook .
        ELSE DO:
         ASSIGN
                impdata_fil.comment = impdata_fil.comment + "| " + "Redbook is Null !! "
                impdata_fil.WARNING = "Redbook เป็นค่าว่างไม่สามารถนำเข้ามูลเข้าได้ " 
                impdata_fil.pass  = "N".

        END.
    END.

    FIND LAST stat.maktab_fil WHERE maktab_fil.makdes   =  impdata_fil.brand AND 
                                    maktab_fil.sclass   =  trim(SUBSTR(nv_class,2,4)) NO-LOCK NO-ERROR.
        IF AVAIL stat.maktab_fil THEN nv_supe = maktab_fil.impchg.

    IF sic_bran.uwm100.expdat NE ? AND sic_bran.uwm100.comdat NE ? THEN DO:
        IF ( DAY(sic_bran.uwm100.comdat)     =  DAY(sic_bran.uwm100.expdat)     AND
           MONTH(sic_bran.uwm100.comdat)     =  MONTH(sic_bran.uwm100.expdat)   AND
            YEAR(sic_bran.uwm100.comdat) + 1 =  YEAR(sic_bran.uwm100.expdat) )  OR
           ( DAY(sic_bran.uwm100.comdat)     =   29                             AND
           MONTH(sic_bran.uwm100.comdat)     =   02                             AND
             DAY(sic_bran.uwm100.expdat)     =   01                             AND
           MONTH(sic_bran.uwm100.expdat)     =   03                             AND
            YEAR(sic_bran.uwm100.comdat) + 1 =  YEAR(sic_bran.uwm100.expdat) )
        THEN DO:
          nv_polday = 365.
        END.
        ELSE DO:
          nv_polday = (sic_bran.uwm100.expdat  - sic_bran.uwm100.comdat ) + 1 .     /*    =  366  วัน */
        END.
    END.
    IF nv_polday < 365 THEN DO:
        nv_polday  = (sic_bran.uwm100.expdat  - sic_bran.uwm100.comdat).
        /*nv_netprem = TRUNCATE((nv_netprem / nv_polday ) * 365 ,0) +
                     (IF ((nv_netprem / nv_polday ) * 365 ) - Truncate((nv_netprem / nv_polday ) * 365,0) > 0 Then 1 
                      Else 0). */
    END.
    /*                       
    MESSAGE "  nv_policy   "  sic_bran.uwm100.policy     
            "  nv_rencnt   "  sic_bran.uwm100.rencnt    skip
            "  nv_riskno   "  nv_riskno     
            "  nv_itemno   "  nv_itemno     skip
            "  nv_batchyr  "  nv_batchyr    
            "  nv_batchno  "  nv_batchno    
            "  nv_batcnt   "  nv_batcnt     skip
            "  nv_polday   "  nv_polday     skip
            "  nv_covcod   "  nv_covcod     skip
            "  nv_class    "  nv_class      skip
            "  nv_vehuse   "  nv_vehuse     skip
            "  nv_cstflg   "  nv_cstflg     skip
            "  nv_engcst   "  nv_engcst     skip
            "  nv_drivno   "  nv_drivno     
            "  nv_driage1  "  nv_driage1    
            "  nv_driage2  "  nv_driage2    skip
            "  nv_yrmanu   "  nv_yrmanu     skip
            "  nv_totsi    "  nv_totsi      skip
            "  nv_vehgrp   "  nv_vehgrp     skip
            "  nv_access   "  nv_access     skip
            "  nv_supe     "  nv_supe       skip
            "  nv_tpbi1si  "  nv_tpbi1si    skip
            "  nv_tpbi2si  "  nv_tpbi2si    skip
            "  nv_tppdsi   "  nv_tppdsi     skip
            "  nv_411si    "  nv_411si      skip
            "  nv_412si    "  nv_412si      skip
            "  nv_413si    "  nv_413si      skip
            "  nv_414si    "  nv_414si      skip
            "  nv_42si     "  nv_42si       skip
            "  nv_43si     "  nv_43si       skip
            "  nv_41prmt   "  nv_41prmt     skip
            "  nv_42prmt   "  nv_42prmt     skip
            "  nv_43prmt   "  nv_43prmt     skip
            "  nv_seat41   "  nv_seat41     skip
            "  nv_dedod    "  nv_dedod      skip
            "  nv_addod    "  nv_addod      skip
            "  nv_dedpd    "  nv_dedpd      skip
            "  nv_ncbp     "  nv_ncbp       skip
            "  nv_fletp    "  nv_fletp      skip
            "  nv_dspcp    "  nv_dspcp      skip
            "  nv_dstfp    "  nv_dstfp      skip
            "  nv_clmp     "  nv_clmp       skip
            "  nv_baseprm  "  nv_baseprm    skip
            "  nv_baseprm3 "  nv_baseprm3   skip
            "  nv_netprem  "  nv_netprem    skip
            "  nv_pdprem   "  nv_pdprem     skip
            "  nv_gapprem  "  nv_gapprem    skip
            "  nv_flagprm  "  nv_flagprm    skip
            "  nv_effdat   "  nv_effdat     skip
            "  nv_status   "  nv_status     skip
            "  nv_fcctv    "  nv_fcctv      skip
            "  nv_uom1_c   "  nv_uom1_c     skip
            "  nv_uom2_c   "  nv_uom2_c     skip
            "  nv_uom5_c   "  nv_uom5_c     skip
            "  nv_uom6_c   "  nv_uom6_c     skip
            "  nv_uom7_c   "  nv_uom7_c     skip
            "  nv_message  "  nv_message    skip
            "  nv_ratatt   "  nv_ratatt     skip
            "  nv_siatt    "  nv_siatt      skip
            "  nv_netatt   "  nv_netatt     skip
            "  nv_fltatt   "  nv_fltatt     skip
            "  nv_ncbatt   "  nv_ncbatt     skip
            "  nv_dscatt   "  nv_dscatt    VIEW-AS ALERT-BOX.*/
    
    RUN WUW\WUWPADP2.P(INPUT sic_bran.uwm100.policy,
                       INPUT sic_bran.uwm100.rencnt,
                       INPUT nv_riskno, /* sic_bran.uwm100.endcnt */
                       INPUT nv_itemno,  
                       INPUT nv_batchyr, 
                       INPUT nv_batchno, 
                       INPUT nv_polday,
                       INPUT-OUTPUT nv_covcod ,
                       INPUT-OUTPUT nv_class  ,
                       INPUT-OUTPUT nv_vehuse ,
                       INPUT-OUTPUT nv_cstflg ,
                       INPUT-OUTPUT nv_engcst ,
                       INPUT-OUTPUT nv_drivno ,
                       INPUT-OUTPUT nv_driage1,
                       INPUT-OUTPUT nv_driage2,
                       INPUT-OUTPUT nv_pdprm0 , 
                       INPUT-OUTPUT nv_yrmanu ,
                       INPUT-OUTPUT nv_totsi  ,
                       /*INPUT-OUTPUT nv_totfi  ,*/
                       INPUT-OUTPUT nv_vehgrp,  
                       INPUT-OUTPUT nv_access,  
                       INPUT-OUTPUT nv_supe,                       
                       INPUT-OUTPUT nv_tpbi1si, 
                       INPUT-OUTPUT nv_tpbi2si, 
                       INPUT-OUTPUT nv_tppdsi,                 
                       INPUT-OUTPUT nv_411si,   
                       INPUT-OUTPUT nv_412si,   
                       INPUT-OUTPUT nv_413si,   
                       INPUT-OUTPUT nv_414si,   
                       INPUT-OUTPUT nv_42si,    
                       INPUT-OUTPUT nv_43si,
                       INput-output nv_41prmt,  /* ระบุเบี้ย รย.*/
                       INput-output nv_42prmt,  /* ระบุเบี้ย รย.*/
                       INput-output nv_43prmt,  /* ระบุเบี้ย รย.*/
                       INPUT-OUTPUT nv_seat41,                
                       INPUT-OUTPUT nv_dedod,   
                       INPUT-OUTPUT nv_addod,    
                       INPUT-OUTPUT nv_dedpd,                  
                       INPUT-OUTPUT nv_ncbp,      
                       INPUT-OUTPUT nv_fletp,   
                       INPUT-OUTPUT nv_dspcp,   
                       INPUT-OUTPUT nv_dstfp,   
                       INPUT-OUTPUT nv_clmp,
                       INPUT-OUTPUT nv_baseprm,
                       INPUT-OUTPUT nv_baseprm3,
                       INPUT-OUTPUT nv_pdprem,
                       INPUT-OUTPUT nv_netprem, 
                       INPUT-OUTPUT nv_gapprm,  
                       INPUT-OUTPUT nv_flagprm,             
                       INPUT-OUTPUT nv_effdat,
                       INPUT-OUTPUT nv_ratatt, 
                       INPUT-OUTPUT nv_siatt ,
                       INPUT-OUTPUT nv_netatt,    
                       INPUT-OUTPUT nv_fltatt, 
                       INPUT-OUTPUT nv_ncbatt, 
                       INPUT-OUTPUT nv_dscatt,
                       INPUT-OUTPUT nv_fcctv , /* cctv = yes/no */
                       OUTPUT nv_uom1_c ,  
                       OUTPUT nv_uom2_c ,  
                       OUTPUT nv_uom5_c ,  
                       OUTPUT nv_uom6_c ,
                       OUTPUT nv_uom7_c ,
                       OUTPUT nv_status ,
                       OUTPUT nv_message ).
    ASSIGN 
        sic_bran.uwm130.uom1_c  = nv_uom1_c
        sic_bran.uwm130.uom2_c  = nv_uom2_c
        sic_bran.uwm130.uom5_c  = nv_uom5_c
        sic_bran.uwm130.uom6_c  = nv_uom6_c
        sic_bran.uwm130.uom7_c  = nv_uom7_c .
    
    IF nv_drivno <> 0  THEN ASSIGN sic_bran.uwm301.actprm = nv_pdprm0. 

    IF nv_status = "NO" THEN DO:
        IF INDEX(nv_message,"Not Found Benefit") <> 0 THEN ASSIGN impdata_fil.pass  = "N". /*A65-0043*/
        ASSIGN
                impdata_fil.comment = impdata_fil.comment + "|" + nv_message
                impdata_fil.WARNING = impdata_fil.WARNING + "|" + nv_message.
                /*impdata_fil.pass    = "N".*/
    END.
    
END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_chktest0 C-Win 
PROCEDURE 00-proc_chktest0 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: comment by a65-0079 code เต็ม      
------------------------------------------------------------------------------*/
/*DEF VAR nv_seq         AS INTEGER  INIT  1.
DEF VAR nv_sum         AS INTEGER  INIT  0.
DEF VAR nv_checkdigit  AS INTEGER . 
DEFINE VAR chk_sticker AS CHAR FORMAT "x(15)".
DEF VAR nv_class AS CHAR INIT "" .
DEF VAR nv_comper AS DECI INIT 0 . /* A64-0355*/
DEF BUFFER bfimpdata_fil FOR impdata_fil.
ASSIGN fi_process = "check data Text file riskno/Itemno :" + string(impdata_fil.riskno,"999") + "/" + string(impdata_fil.itemno,"999") + " " + impdata_fil.policyno .
DISP fi_process WITH FRAM fr_main.
IF ra_type = 2  AND impdata_fil.vehreg = " " AND impdata_fil.prepol  = " " THEN DO: 
   ASSIGN
       impdata_fil.comment = impdata_fil.comment + "| Vehicle Register is mandatory field. "
       impdata_fil.pass    = "N"   
       impdata_fil.OK_GEN  = "N".
END.
/* เช็ค Agent , Producer */
 IF  impdata_fil.agent = "" THEN DO:
     ASSIGN impdata_fil.comment = impdata_fil.comment + "| Agent Code is Null "
            impdata_fil.pass    = "N"       impdata_fil.OK_GEN  = "N".
 END.
 ELSE IF impdata_fil.producer = "" THEN DO:
     ASSIGN impdata_fil.comment = impdata_fil.comment + "| Producer Code is Null "
            impdata_fil.pass    = "N"       impdata_fil.OK_GEN  = "N".
 END.
 ELSE DO:
     ASSIGN nv_agent    = TRIM(impdata_fil.agent)
            nv_producer = TRIM(impdata_fil.producer) 
            nv_chkerror = "" .
     RUN wgw/wgwchkagpd(INPUT nv_agent,INPUT nv_producer,INPUT-OUTPUT nv_chkerror) . 
     IF nv_chkerror <> ""  THEN DO:
         ASSIGN impdata_fil.comment = impdata_fil.comment + "|" + TRIM(nv_chkerror)
                impdata_fil.pass    = "N"       impdata_fil.OK_GEN  = "N".
     END.
 END.
 IF impdata_fil.n_delercode <> "" THEN DO:
     FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = TRIM(impdata_fil.n_delercode) NO-LOCK NO-ERROR.
     IF NOT AVAIL xmm600 THEN 
         ASSIGN impdata_fil.comment = impdata_fil.comment + "| Not found Code Dealer " + impdata_fil.n_delercode + "(xmm600)" 
            impdata_fil.pass    = "N"       impdata_fil.OK_GEN  = "N".
     ELSE DO:
         IF xmm600.closed <> ? AND xmm600.closed < TODAY THEN
         ASSIGN impdata_fil.comment = impdata_fil.comment + "| Code Dealer " + impdata_fil.n_delercode + " Closed Date: " + STRING(xmm600.closed,"99/99/9999") 
                impdata_fil.pass    = "N"       impdata_fil.OK_GEN  = "N".
     END.
 END.
 IF impdata_fil.fincode <> "" THEN DO:
     FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = TRIM(impdata_fil.fincode) NO-LOCK NO-ERROR.
     IF NOT AVAIL xmm600 THEN 
         ASSIGN impdata_fil.comment = impdata_fil.comment + "| Not found Code Finance " + impdata_fil.fincode + "(xmm600)" 
            impdata_fil.pass    = "N"       impdata_fil.OK_GEN  = "N".
     ELSE DO:
      IF xmm600.closed <> ? AND xmm600.closed < TODAY THEN
       ASSIGN impdata_fil.comment = impdata_fil.comment + "| Code Finance " + impdata_fil.fincode + " Closed Date: " + STRING(xmm600.closed,"99/99/9999") 
              impdata_fil.pass    = "N"         impdata_fil.OK_GEN  = "N".
     END.
 END.
 IF impdata_fil.payercod <> "" THEN DO:
     FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = TRIM(impdata_fil.payercod) NO-LOCK NO-ERROR.
     IF NOT AVAIL xmm600 THEN 
         ASSIGN impdata_fil.comment = impdata_fil.comment + "| Not found Code Payer " + impdata_fil.payercod + "(xmm600)" 
            impdata_fil.pass    = "N" 
            impdata_fil.OK_GEN  = "N".
 END.
 IF impdata_fil.vatcode <> "" THEN DO:
     FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = TRIM(impdata_fil.vatcode) NO-LOCK NO-ERROR.
     IF NOT AVAIL xmm600 THEN 
         ASSIGN impdata_fil.comment = impdata_fil.comment + "| Not found Code Vat " + impdata_fil.vatcode + "(xmm600)" 
            impdata_fil.pass    = "N" 
            impdata_fil.OK_GEN  = "N".
     ELSE DO:
         IF xmm600.closed <> ? AND xmm600.closed < TODAY THEN
         ASSIGN impdata_fil.comment = impdata_fil.comment + "| Code VAT " + impdata_fil.vatcode + " Closed Date: " + STRING(xmm600.closed,"99/99/9999") 
             impdata_fil.pass    = "N" 
             impdata_fil.OK_GEN  = "N".
    END.
 END.
 IF impdata_fil.agco70 <> "" THEN DO:
     FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = TRIM(impdata_fil.agco70) NO-LOCK NO-ERROR.
     IF NOT AVAIL xmm600 THEN 
         ASSIGN impdata_fil.comment = impdata_fil.comment + "| Agent code Co-Broker " + impdata_fil.agco70 + "(xmm600)" 
            impdata_fil.pass    = "N" 
            impdata_fil.OK_GEN  = "N".
     ELSE DO:
         IF xmm600.closed <> ? AND xmm600.closed < TODAY THEN
         ASSIGN impdata_fil.comment = impdata_fil.comment + "| Agent code Co-Broker " + impdata_fil.agco70 + " Closed Date: " + STRING(xmm600.closed,"99/99/9999") 
             impdata_fil.pass    = "N" 
             impdata_fil.OK_GEN  = "N".
    END.
 END.
 IF TRIM(impdata_fil.jpae) <> ""  THEN DO:
     FIND LAST sicsyac.xmm604 WHERE sicsyac.xmm604.stfcod = TRIM(impdata_fil.jpae) NO-LOCK NO-ERROR .
     IF NOT AVAIL xmm604 THEN
         ASSIGN impdata_fil.comment = impdata_fil.comment + "| Not found Code AE " + impdata_fil.jpae + "(xmm604)" 
            impdata_fil.pass    = "N" 
            impdata_fil.OK_GEN  = "N".
 END.
 IF TRIM(impdata_fil.jpjtl) <> "" THEN DO: 
     FIND LAST sicsyac.xmm604 WHERE sicsyac.xmm604.stfcod = TRIM(impdata_fil.jpjtl) NO-LOCK NO-ERROR .
     IF NOT AVAIL xmm604 THEN
         ASSIGN impdata_fil.comment = impdata_fil.comment + "| Not found Code Japanese Team Leader " + (impdata_fil.jpjtl) + "(xmm604)" 
            impdata_fil.pass    = "N" 
            impdata_fil.OK_GEN  = "N".
 END.
 IF TRIM(impdata_fil.jpts) <> "" THEN DO: 
    FIND LAST sicsyac.xmm604 WHERE sicsyac.xmm604.stfcod = TRIM(impdata_fil.jpts) NO-LOCK NO-ERROR .
     IF NOT AVAIL xmm604 THEN
         ASSIGN impdata_fil.comment = impdata_fil.comment + "| Not found Code TS " + (impdata_fil.jpts) + "(xmm604)"
                impdata_fil.pass    = "N" 
                impdata_fil.OK_GEN  = "N".
 END.
 /* comment by : A65-0043
 /* เช็ควันที่คุ้มครอง - หมดอายุ */
 IF impdata_fil.comDat = ? THEN 
     ASSIGN impdata_fil.comment = impdata_fil.comment + "| วันที่เริ่มคุ้มครองเป็นค่าว่าง "
            impdata_fil.pass    = "N" 
            impdata_fil.OK_GEN  = "N".
 IF impdata_fil.expDat = ? THEN 
     ASSIGN impdata_fil.comment = impdata_fil.comment + "| วันที่สิ้นสุดความคุ้มครองเป็นค่าว่าง "
            impdata_fil.pass    = "N" 
            impdata_fil.OK_GEN  = "N".
 IF impdata_fil.comdat <> ? AND (YEAR(impdata_fil.comdat) < (YEAR(TODAY) - 1) OR (YEAR(impdata_fil.comdat) > YEAR(TODAY) + 1)) THEN 
    ASSIGN impdata_fil.comment = impdata_fil.comment + "|" + STRING(YEAR(impdata_fil.comdat),"9999") + " ปีที่เริ่มคุ้มครองไม่ถูกต้อง ! "
            impdata_fil.pass    = "N" 
            impdata_fil.OK_GEN  = "N".
 IF impdata_fil.expDat <> ? AND (YEAR(impdata_fil.expDat) < (YEAR(TODAY)) OR (YEAR(impdata_fil.expDat) > YEAR(TODAY) + 2) ) THEN 
    ASSIGN impdata_fil.comment = impdata_fil.comment + "|" + STRING(YEAR(impdata_fil.expdat),"9999") + " ปีที่สิ้นสุดความคุ้มครองไม่ถูกต้อง ! "
            impdata_fil.pass    = "N" 
            impdata_fil.OK_GEN  = "N".
..end : A65-0043..*/
 IF impdata_fil.cancel = "ca"  THEN  
    ASSIGN  impdata_fil.pass = "N"  
    impdata_fil.comment = impdata_fil.comment + "| cancel"
    impdata_fil.OK_GEN  = "N".

 IF impdata_fil.insnam = ""  THEN 
     ASSIGN  impdata_fil.pass = "N"  
     impdata_fil.comment = impdata_fil.comment + "| ชื่อผู้เอาประกันเป็นค่าว่าง" 
     impdata_fil.OK_GEN  = "N".
 
 IF impdata_fil.n_branch = ""  THEN DO: 
     ASSIGN  impdata_fil.pass = "N"  
     impdata_fil.comment = impdata_fil.comment + "| พบสาขาเป็นค่าว่าง" 
     impdata_fil.OK_GEN  = "N".
 END.
 ELSE DO:
     FIND LAST sicsyac.xmm023 USE-INDEX xmm02301 WHERE sicsyac.xmm023.branch = TRIM(impdata_fil.n_bran) NO-LOCK NO-ERROR.
     IF NOT AVAIL sicsyac.xmm023 THEN DO:
         ASSIGN  impdata_fil.pass = "N"  
         impdata_fil.comment = impdata_fil.comment + "| ไม่พบสาขาในระบบ (XMM023)" 
         impdata_fil.OK_GEN  = "N".
     END.
 END.
 RELEASE sicsyac.xmm023 .

 IF impdata_fil.camp_no <> ""  AND impdata_fil.camp_no <> "NONCAM" THEN DO:
     FIND LAST stat.campaign_master USE-INDEX campmaster02 WHERE 
        date(campaign_master.effdat) <= date(impdata_fil.comdat) AND
        date(campaign_master.enddat) >= date(impdata_fil.comdat) AND
         campaign_master.campcode = impdata_fil.camp_no NO-LOCK NO-ERROR.
     IF NOT AVAIL campaign_master THEN DO:
         ASSIGN impdata_fil.comment = impdata_fil.comment + "| ไม่พบ Campaign Code " + impdata_fil.camp_no + " ในระบบ (Campaign_master) "
            impdata_fil.pass    = "N" 
            impdata_fil.OK_GEN  = "N".
     END.
     ELSE DO:
        RUN proc_chkcampaign.
     END.
 END.
 RELEASE stat.campaign_master .
/* เช็ค แพ็คเกจ ในพารามิเตอร์ */
 IF impdata_fil.packcod <> ""  THEN DO:
    FIND LAST stat.caccount USE-INDEX caccount05 WHERE caccount.camcod = TRIM(impdata_fil.packcod) NO-LOCK NO-ERROR.
    IF AVAIL stat.caccount THEN DO:
        FIND LAST stat.campaign_fil USE-INDEX campfil14  WHERE campaign_fil.camcod = caccount.camcod NO-LOCK NO-ERROR.
        IF NOT AVAIL stat.campaign_fil THEN DO:
            ASSIGN impdata_fil.comment = impdata_fil.comment + "|รหัสแพ็คเกจ " + impdata_fil.packcod + " ยังไม่โหลดวิธีคีย์เข้าระบบ" 
                   impdata_fil.pass    = "N" 
                   impdata_fil.OK_GEN  = "N".
        END.
        ELSE IF ra_type = 1 THEN RUN proc_policyname4 . /*A64-0044*/
    END.
    ELSE ASSIGN impdata_fil.comment = impdata_fil.comment + "|ไม่พบรหัสแพ็คเกจ" + impdata_fil.packcod + " ในระบบ"
                impdata_fil.pass    = "N" 
                impdata_fil.OK_GEN  = "N".
 END.

 IF impdata_fil.poltyp = "V70" AND  int(impdata_fil.premt) = 0  THEN 
     ASSIGN impdata_fil.comment = impdata_fil.comment + "| เบี้ยสุทธิเป็น 0 "
     impdata_fil.pass    = "N" 
     impdata_fil.OK_GEN  = "N".

  /* commission */
 IF (DECI(impdata_fil.comprem70) <> (-1)) AND DECI(impdata_fil.comper70) = (-1)  THEN 
  ASSIGN impdata_fil.comment = impdata_fil.comment + "|กรมธรรม์ระบุ 70 Commission Amount " + string(impdata_fil.comprem70) + " แต่ไม่ระบุ Commission% "
         impdata_fil.pass    = "N" 
         impdata_fil.OK_GEN  = "N".
 /* add by : ranu i. A64-0355 */
 IF impdata_fil.agco70 <> "" THEN DO:
     ASSIGN nv_comper = DECI(impdata_fil.comco_per70) + DECI(impdata_fil.comper70) .
     IF DECI(impdata_fil.comco_per70) = 0 THEN
       ASSIGN impdata_fil.comment = impdata_fil.comment + "|กรมธรรม์ Co-broker กรุณาระบุ Commission co-broker% "
             impdata_fil.pass    = "N" 
             impdata_fil.OK_GEN  = "N".
     IF nv_comper > 18 THEN 
       ASSIGN impdata_fil.comment = impdata_fil.comment + "|ยอดรวม (Commission%) + (Commission co-broker%) มากกกว่า 18% "
         impdata_fil.pass    = "N" 
         impdata_fil.OK_GEN  = "N".
 END.
 /* end : A64-0355 */
 IF impdata_fil.poltyp = "V70" AND impdata_fil.riskno <> 0 THEN DO:
     /* เช็คความคุ้มครอง */
     IF impdata_fil.covcod = "" THEN DO:
         ASSIGN impdata_fil.comment = impdata_fil.comment + "| ประเภทความคุ้มครองเป็นค่าว่าง "
                impdata_fil.pass    = "N" 
                impdata_fil.OK_GEN  = "N".
     END.
     /* เช็คน้ำหนักตัน , CC */
     IF impdata_fil.subclass = " " THEN DO: 
         ASSIGN  impdata_fil.comment = impdata_fil.comment + "| sub class เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
         impdata_fil.pass    = "N"  
         impdata_fil.OK_GEN  = "N".
     END.
     ELSE DO:
       nv_class = trim(SUBSTR(impdata_fil.subclass,1,1)) . 
       IF (nv_class = "3" OR nv_class = "4" OR nv_class = "5" OR TRIM(impdata_fil.subclass) = "803"  OR  
       TRIM(impdata_fil.subclass)  = "804"  OR TRIM(impdata_fil.subclass) = "805") AND int(impdata_fil.weight) = 0 THEN 
          ASSIGN impdata_fil.comment = impdata_fil.comment + "|รหัสรถ " + impdata_fil.subclass + " ต้องระบุน้ำหนักในช่อง น้ำหนัก(ตัน) " 
                 impdata_fil.pass    = "N" 
                 impdata_fil.OK_GEN  = "N".
       /* A64-0044 */
       ELSE IF SUBSTR(impdata_fil.subclass,LENGTH(impdata_fil.subclass),1) = "E" AND INT(impdata_fil.watt) = 0 THEN
           ASSIGN impdata_fil.comment = impdata_fil.comment +  "| " + impdata_fil.subclass + " เป็น Class รถไฟฟ้า ต้องระบุข้อมูล Kilowatt " 
                      impdata_fil.pass    = "N" 
                      impdata_fil.OK_GEN  = "N".
       /* end : A64-0044 */
       ELSE IF int(impdata_fil.engcc) = 0 AND int(impdata_fil.weight) = 0 AND INT(impdata_fil.watt) = 0  THEN DO:
               ASSIGN impdata_fil.comment = impdata_fil.comment +  "| " + impdata_fil.subclass + " น้ำหนักรถเป็นค่าว่าง ต้องระบุ CC หรือ Ton หรือ Kilowatt " 
                      impdata_fil.pass    = "N" 
                      impdata_fil.OK_GEN  = "N".
       END.
     END.
      /******* drivernam **********/
     nv_sclass = impdata_fil.subclass. 
     If  impdata_fil.drivnam = "y" AND substr(nv_sclass,2,1) = "2"   Then 
         ASSIGN impdata_fil.comment = impdata_fil.comment + "| CODE  nv_sclass Driver 's Name must be no. "
             impdata_fil.pass    = "N"    
             impdata_fil.OK_GEN  = "N".
     IF impdata_fil.drivnam  = "y" AND impdata_fil.drivername1 =  " "   THEN 
         ASSIGN  impdata_fil.comment = impdata_fil.comment + "| มีการระบุว่ามีคนขับแต่ไม่มีชื่อคนขับ"
         impdata_fil.pass    = "N" 
         impdata_fil.OK_GEN  = "N".
     IF impdata_fil.prempa = " " AND impdata_fil.poltyp = "V70" THEN 
         ASSIGN  impdata_fil.comment = impdata_fil.comment + "| prem pack เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
         impdata_fil.pass    = "N"     
         impdata_fil.OK_GEN  = "N".
     IF impdata_fil.brand = " " THEN 
         ASSIGN  impdata_fil.comment = impdata_fil.comment + "| Brand เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
         impdata_fil.pass    = "N"        
         impdata_fil.OK_GEN  = "N".
     /*IF impdata_fil.model = " " THEN 
         ASSIGN  impdata_fil.comment = impdata_fil.comment + "| model เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
         impdata_fil.pass    = "N"   
         impdata_fil.OK_GEN  = "N".*/
     /* comment by : Ranu I. A65-0043...
     IF impdata_fil.seat  = 0 THEN 
         ASSIGN  impdata_fil.comment = impdata_fil.comment + "| seat เป็น 0 มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
         impdata_fil.OK_GEN  = "N".
     .... end : A65-0043...*/
     IF impdata_fil.yrmanu = " " THEN 
         ASSIGN  impdata_fil.comment = impdata_fil.comment + "| year manufacture เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
         impdata_fil.pass    = "N"  
         impdata_fil.OK_GEN  = "N".
     /* comment by : A65-0079
     IF trim(impdata_fil.chasno) = ""  THEN DO: 
         ASSIGN  impdata_fil.comment = impdata_fil.comment + "| เลขตัวถัง เป็นค่าว่าง "
         impdata_fil.pass    = "N"    impdata_fil.OK_GEN  = "N".
     END.
     ELSE DO:
       FOR EACH bfimpdata_fil WHERE bfimpdata_fil.chasno = impdata_fil.chasno NO-LOCK.
           IF bfimpdata_fil.riskno <> impdata_fil.risk AND bfimpdata_fil.itemno <> impdata_fil.itemno THEN 
             ASSIGN  impdata_fil.comment = impdata_fil.comment + "| เลขตัวถังซ้ำในไฟล์โหลดที่ risk/item :" + string(bfimpdata_fil.riskno) + "/" + STRING(bfimpdata_fil.itemno)
                    impdata_fil.pass    = "N"   impdata_fil.OK_GEN  = "N".
       END.
     END. */
     ASSIGN
         nv_maxsi  = 0       nv_maxdes = ""  
         nv_minsi  = 0       nv_mindes = ""  
         nv_si     = 0       chkred    = NO. 
         /*end note add &  modi*/
     ASSIGN                  
       NO_CLASS  = impdata_fil.prempa + impdata_fil.subclass 
       nv_poltyp = impdata_fil.poltyp.
     
     If no_class  <>  " " Then do:
       FIND FIRST  sicsyac.xmd031 USE-INDEX xmd03101   WHERE
           sicsyac.xmd031.poltyp =   nv_poltyp AND
           sicsyac.xmd031.class  =   no_class  NO-LOCK NO-ERROR NO-WAIT.
       IF NOT AVAILABLE sicsyac.xmd031 THEN 
          ASSIGN
               impdata_fil.comment = impdata_fil.comment + "| Not On Business Class xmd031" 
               impdata_fil.pass    = "N"   
               impdata_fil.OK_GEN  = "N".
       
       FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE 
           sicsyac.xmm016.class =    no_class  NO-LOCK NO-ERROR.
       IF NOT AVAILABLE sicsyac.xmm016 THEN 
           ASSIGN
               impdata_fil.comment = impdata_fil.comment + "| Not on Business class on xmm016"
               impdata_fil.pass    = "N"    
               impdata_fil.OK_GEN  = "N".
       ELSE 
           ASSIGN    
               impdata_fil.tariff =   sicsyac.xmm016.tardef
               no_class       =   sicsyac.xmm016.class
               nv_sclass      =   Substr(no_class,2,3).
     END.
     release sicsyac.xmd031.
     release sicsyac.xmm016.
     
     FIND sicsyac.sym100 USE-INDEX sym10001 WHERE
       sicsyac.sym100.tabcod = "U014"    AND
       sicsyac.sym100.itmcod = impdata_fil.vehuse NO-LOCK NO-ERROR.
     IF NOT AVAIL sicsyac.sym100 THEN 
       ASSIGN     
           impdata_fil.pass    = "N"  
           impdata_fil.comment = impdata_fil.comment + "| ไม่พบ Veh.Usage ในระบบ "
           impdata_fil.OK_GEN  = "N".
     Find  sicsyac.sym100 Use-index sym10001  Where
        sicsyac.sym100.tabcod = "u013"         And
        sicsyac.sym100.itmcod = impdata_fil.covcod
        No-lock no-error no-wait.
     IF not avail sicsyac.sym100 Then 
        ASSIGN impdata_fil.comment = impdata_fil.comment + "| Not on Motor Cover Type Codes table sym100 u013"
            impdata_fil.pass    = "N"    
            impdata_fil.OK_GEN  = "N".
     RELEASE sicsyac.sym100 .
     /*---------- fleet -------------------*/
     IF inte(impdata_fil.fleet) <> 0 AND INTE(impdata_fil.fleet) <> 10 Then 
        ASSIGN impdata_fil.comment = impdata_fil.comment + "| Fleet Percent must be 0 or 10. "
            impdata_fil.pass    = "N"    
            impdata_fil.OK_GEN  = "N".
     /*----------  ncb -------------------*/
     IF (DECI(impdata_fil.ncb) = 0 )  OR (DECI(impdata_fil.ncb) = 20 ) OR
       (DECI(impdata_fil.ncb) = 30 ) OR (DECI(impdata_fil.ncb) = 40 ) OR
       (DECI(impdata_fil.ncb) = 50 )    THEN DO:
     END.
     ELSE ASSIGN impdata_fil.comment = impdata_fil.comment + "| not on NCB Rates file xmm104."
            impdata_fil.pass    = "N"   
            impdata_fil.OK_GEN  = "N".
     ASSIGN NV_NCBPER = 0
           NV_NCBPER = INTE(impdata_fil.NCB).
     If nv_ncbper  <> 0 Then do:
        Find first sicsyac.xmm104 Use-index xmm10401 Where
            sicsyac.xmm104.tariff = impdata_fil.tariff                      AND
            sicsyac.xmm104.class  = impdata_fil.prempa + impdata_fil.subclass   AND
            sicsyac.xmm104.covcod = impdata_fil.covcod           AND
            sicsyac.xmm104.ncbper = INTE(impdata_fil.ncb)
            No-lock no-error no-wait.
        IF not avail  sicsyac.xmm104  Then 
            ASSIGN impdata_fil.comment = impdata_fil.comment + "| This NCB Step not on NCB Rates file xmm104. "
                impdata_fil.pass    = "N"     
                impdata_fil.OK_GEN  = "N".
     END. /*ncb <> 0*/
     RELEASE sicsyac.xmm104 .
     RUN proc_chkpolpremium . /* เช็คการออกกรมธรรม์ในพรีเมียม */
 END.*/
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_chktest2 C-Win 
PROCEDURE 00-proc_chktest2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: comment by :A67-0029      
------------------------------------------------------------------------------*/
/*ASSIGN fi_process = "Create Data " + impdata_fil.policyno + " Risk/Item " + string(impdata_fil.riskno,"999") + "/" +
                    STRING(impdata_fil.itemno,"999") + " on uwm130,uwm301...."  .
DISP fi_process WITH FRAM fr_main.

FIND sic_bran.uwm130 USE-INDEX uwm13001 WHERE
           sic_bran.uwm130.policy  = sic_bran.uwm100.policy AND
           sic_bran.uwm130.rencnt  = sic_bran.uwm100.rencnt AND
           sic_bran.uwm130.endcnt  = sic_bran.uwm100.endcnt AND
           sic_bran.uwm130.riskgp  = s_riskgp               AND            /*0*/
           sic_bran.uwm130.riskno  = impdata_fil.riskno         AND            /*1*/
           sic_bran.uwm130.itemno  = impdata_fil.itemno         AND            /*1*/
           sic_bran.uwm130.bchyr   = nv_batchyr             AND 
           sic_bran.uwm130.bchno   = nv_batchno             AND 
           sic_bran.uwm130.bchcnt  = nv_batcnt             NO-WAIT NO-ERROR.
IF NOT AVAILABLE uwm130 THEN DO:
    DO TRANSACTION:
    CREATE sic_bran.uwm130.
    ASSIGN
        sic_bran.uwm130.policy = sic_bran.uwm120.policy
        sic_bran.uwm130.rencnt = sic_bran.uwm120.rencnt   sic_bran.uwm130.endcnt = sic_bran.uwm120.endcnt
        sic_bran.uwm130.riskgp = sic_bran.uwm120.riskgp   sic_bran.uwm130.riskno = sic_bran.uwm120.riskno
        sic_bran.uwm130.itemno = impdata_fil.itemno
        sic_bran.uwm130.bchyr  = nv_batchyr          /* batch Year */
        sic_bran.uwm130.bchno  = nv_batchno          /* bchno      */
        sic_bran.uwm130.bchcnt = nv_batcnt        /* bchcnt     */
        nv_sclass     = impdata_fil.subclass
        nv_uom6_u     = "" 
        nv_othcod     = ""
        nv_othvar1    = ""
        nv_othvar2    = ""
        nv_othvar     = "". 

    IF impdata_fil.special  =  "A"  THEN DO:
       nv_uom6_u  =  "A".
       /* IF  nv_sclass  =  "320"  Or  nv_sclass  =  "340"  Or
            nv_sclass  =  "520"  Or  nv_sclass  =  "540"  
            Then  nv_uom6_u  =  "A".         
        Else 
            ASSIGN
                impdata_fil.pass    = "N"
                impdata_fil.comment = impdata_fil.comment + "| Classนี้ ไม่รับอุปกรณ์เพิ่มพิเศษ". */
    END.     
    IF CAPS(nv_uom6_u) = "A"  Then
        Assign  nv_uom6_u                  = "A"
        nv_othcod                  = "OTH"
        nv_othvar1                 = "     Accessory  = "
        nv_othvar2                 =  STRING(nv_uom6_u)
        SUBSTRING(nv_othvar,1,30)  = nv_othvar1
        SUBSTRING(nv_othvar,31,30) = nv_othvar2.
    ELSE
        ASSIGN  nv_uom6_u              = ""
            nv_othcod                  = ""
            nv_othvar1                 = ""
            nv_othvar2                 = ""
            SUBSTRING(nv_othvar,1,30)  = nv_othvar1
            SUBSTRING(nv_othvar,31,30) = nv_othvar2.
    
    IF (impdata_fil.covcod = "1") OR (impdata_fil.covcod = "5") OR (impdata_fil.covcod = "2.1") OR (impdata_fil.covcod = "3.1") OR
       (impdata_fil.covcod = "2.2") OR (impdata_fil.covcod = "3.2")  THEN /*a62-0215*/
        ASSIGN
            sic_bran.uwm130.uom6_v   = IF      impdata_fil.covcod = "2.1" THEN inte(impdata_fil.siplus)
                                       ELSE IF impdata_fil.covcod = "2.2" THEN inte(impdata_fil.siplus) 
                                       ELSE IF impdata_fil.covcod = "3.1" THEN INTE(impdata_fil.siplus) 
                                       ELSE IF impdata_fil.covcod = "3.2" THEN INTE(impdata_fil.siplus) 
                                       ELSE inte(impdata_fil.si)
            sic_bran.uwm130.uom7_v   = IF      impdata_fil.covcod = "2.1" THEN inte(impdata_fil.siplus)
                                       ELSE IF impdata_fil.covcod = "2.2" THEN inte(impdata_fil.siplus) 
                                       ELSE IF impdata_fil.covcod = "3.1" THEN 0 
                                       ELSE IF impdata_fil.covcod = "3.2" THEN 0  
                                       ELSE inte(impdata_fil.si)

            sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
            sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
            sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
            sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
            sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
    IF impdata_fil.covcod = "2"  THEN 
        ASSIGN
            sic_bran.uwm130.uom6_v   = 0
            sic_bran.uwm130.uom7_v   = inte(impdata_fil.si)
            sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
            sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
            sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
            sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
            sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
    IF impdata_fil.covcod = "3"  THEN 
        ASSIGN
            sic_bran.uwm130.uom6_v   = 0
            sic_bran.uwm130.uom7_v   = 0
            sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
            sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
            sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
            sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
            sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/

    IF impdata_fil.poltyp = "v72" THEN  n_sclass72 = impdata_fil.subclass.
    ELSE n_sclass72 = impdata_fil.prempa + impdata_fil.subclass .

    FIND FIRST stat.clastab_fil Use-index clastab01 Where
        stat.clastab_fil.class   = n_sclass72       And
        stat.clastab_fil.covcod  = impdata_fil.covcod No-lock  No-error No-wait.
    IF avail stat.clastab_fil Then do: 
        Assign 
            sic_bran.uwm130.uom1_v     = if deci(impdata_fil.comper)   <> 0 then deci(impdata_fil.comper)   else stat.clastab_fil.uom1_si
            sic_bran.uwm130.uom2_v     = if deci(impdata_fil.comacc)   <> 0 then deci(impdata_fil.comacc)   else stat.clastab_fil.uom2_si
            sic_bran.uwm130.uom5_v     = if deci(impdata_fil.deductpd) <> 0 then deci(impdata_fil.deductpd) else stat.clastab_fil.uom5_si
            sic_bran.uwm130.uom1_u     = if sic_bran.uwm130.uom1_v = 999999999 then "U" else ""  
            sic_bran.uwm130.uom2_u     = if sic_bran.uwm130.uom2_v = 999999999 then "U" else ""  
            sic_bran.uwm130.uom5_u     = if sic_bran.uwm130.uom5_v = 999999999 then "U" else ""  
            sic_bran.uwm130.uom8_v     =  0 /*stat.clastab_fil.uom8_si*/ /*A64-0369*/                
            sic_bran.uwm130.uom9_v     =  0 /*stat.clastab_fil.uom9_si*/ /*A64-0369*/          
            sic_bran.uwm130.uom3_v     =  0
            sic_bran.uwm130.uom4_v     =  0
            sic_bran.uwm130.uom6_u     =  nv_uom6_u    /* อุปกรณ์เสริมพิเศษ */
            impdata_fil.comper             =  0  /*stat.clastab_fil.uom8_si*/ /*A64-0369*/                  
            impdata_fil.comacc             =  0  /*stat.clastab_fil.uom9_si*/ /*A64-0369*/  
            nv_uom1_v                  =  sic_bran.uwm130.uom1_v   
            nv_uom2_v                  =  sic_bran.uwm130.uom2_v
            nv_uom5_v                  =  sic_bran.uwm130.uom5_v        
            sic_bran.uwm130.uom1_c  = "D1"
            sic_bran.uwm130.uom2_c  = "D2"
            sic_bran.uwm130.uom5_c  = "D5"
            sic_bran.uwm130.uom6_c  = "D6"
            sic_bran.uwm130.uom7_c  = "D7".

        If  impdata_fil.garage  =  "G"  THEN DO:
            /* comment by :A65-0079...
            Assign 
            impdata_fil.no_411  =  if deci(impdata_fil.NO_411) <> 0 then impdata_fil.NO_411 else stat.clastab_fil.si_41pai
            impdata_fil.no_412  =  if deci(impdata_fil.NO_412) <> 0 then impdata_fil.NO_412 else stat.clastab_fil.si_41pai
            impdata_fil.no_42   =  if deci(impdata_fil.NO_42)  <> 0 then impdata_fil.NO_42  else stat.clastab_fil.si_42                         
            impdata_fil.no_43   =  if deci(impdata_fil.NO_43)  <> 0 then impdata_fil.NO_43  else stat.clastab_fil.impsi_43*/ 
            /* add by : A65-0079 */
            Assign 
             impdata_fil.no_411  =  if deci(impdata_fil.NO_411) <> -1 then impdata_fil.NO_411 else stat.clastab_fil.si_41pai
             impdata_fil.no_412  =  if deci(impdata_fil.NO_412) <> -1 then impdata_fil.NO_412 else stat.clastab_fil.si_41pai
             impdata_fil.no_42   =  if deci(impdata_fil.NO_42)  <> -1 then impdata_fil.NO_42  else stat.clastab_fil.si_42                         
             impdata_fil.no_43   =  if deci(impdata_fil.NO_43)  <> -1 then impdata_fil.NO_43  else stat.clastab_fil.impsi_43
            /* end : A65-0079*/
             impdata_fil.seat41  =  IF impdata_fil.seat41 <> 0 THEN impdata_fil.seat41 ELSE stat.clastab_fil.dri_41 + stat.clastab_fil.pass_41.  
        END.
        ELSE DO: 
            /* comment by :A65-0079...
            Assign 
                impdata_fil.no_411  =  if deci(impdata_fil.NO_411) <> 0 then impdata_fil.NO_411 else stat.clastab_fil.si_41unp
                impdata_fil.no_412  =  if deci(impdata_fil.NO_412) <> 0 then impdata_fil.NO_412 else stat.clastab_fil.si_41unp
                impdata_fil.no_42   =  if deci(impdata_fil.NO_42) <> 0  then impdata_fil.NO_42  else stat.clastab_fil.si_42
                impdata_fil.no_43   =  if deci(impdata_fil.NO_43) <> 0  then impdata_fil.NO_43  else stat.clastab_fil.si_43*/
            /* add by : A65-0079 */
            Assign 
                impdata_fil.no_411  =  if deci(impdata_fil.NO_411) <> -1 then impdata_fil.NO_411 else stat.clastab_fil.si_41unp
                impdata_fil.no_412  =  if deci(impdata_fil.NO_412) <> -1 then impdata_fil.NO_412 else stat.clastab_fil.si_41unp
                impdata_fil.no_42   =  if deci(impdata_fil.NO_42)  <> -1 then impdata_fil.NO_42  else stat.clastab_fil.si_42
                impdata_fil.no_43   =  if deci(impdata_fil.NO_43)  <> -1 then impdata_fil.NO_43  else stat.clastab_fil.si_43
            /* end : A65-0079*/
                impdata_fil.seat41  = IF impdata_fil.seat41 <> 0 THEN impdata_fil.seat41 ELSE stat.clastab_fil.dri_41 + stat.clastab_fil.pass_41.  
        END.
    END.
    ELSE DO:
        ASSIGN
                impdata_fil.pass    = "N"
                impdata_fil.comment = impdata_fil.comment + "| Class " + n_sclass72 + " Cover: " + impdata_fil.covcod + " Not on Paramter (clastab_fil) ". 
    END.
    ASSIGN
        nv_riskno = impdata_fil.riskno
        nv_itemno = impdata_fil.itemno.

    IF impdata_fil.covcod = "1" Then 
        RUN wgs/wgschsum(INPUT  impdata_fil.policy, 
                         nv_riskno,
                         nv_itemno).
    END.  /* end Do transaction*/
    s_recid3  = RECID(sic_bran.uwm130).
    nv_covcod =   impdata_fil.covcod.
    nv_makdes  =  impdata_fil.brand.
    nv_moddes  =  impdata_fil.model.
    nv_newsck = " ".
    RUN proc_chassic.

    IF SUBSTRING(impdata_fil.stk,1,1) = "2" THEN nv_newsck = "0" + impdata_fil.stk.
    ELSE nv_newsck =  impdata_fil.stk.
    FIND sic_bran.uwm301 USE-INDEX uwm30101      WHERE
         sic_bran.uwm301.policy = sic_bran.uwm100.policy    AND
         sic_bran.uwm301.rencnt = sic_bran.uwm100.rencnt    AND
         sic_bran.uwm301.endcnt = sic_bran.uwm100.endcnt    AND
         sic_bran.uwm301.riskgp = s_riskgp                  AND
         sic_bran.uwm301.riskno = impdata_fil.riskno                  AND
         sic_bran.uwm301.itemno = impdata_fil.itemno                  AND
         sic_bran.uwm301.bchyr  = nv_batchyr                AND 
         sic_bran.uwm301.bchno  = nv_batchno                AND 
         sic_bran.uwm301.bchcnt = nv_batcnt                     
         NO-WAIT NO-ERROR.
     IF NOT AVAILABLE sic_bran.uwm301 THEN DO:                  
         DO TRANSACTION:
             CREATE sic_bran.uwm301.
         END. 
     END. 
     ASSIGN
         sic_bran.uwm301.policy   = sic_bran.uwm120.policy                 
         sic_bran.uwm301.rencnt   = sic_bran.uwm120.rencnt
         sic_bran.uwm301.endcnt   = sic_bran.uwm120.endcnt
         sic_bran.uwm301.riskgp   = sic_bran.uwm120.riskgp
         sic_bran.uwm301.riskno   = sic_bran.uwm120.riskno
         sic_bran.uwm301.itemno   = impdata_fil.itemno
         sic_bran.uwm301.tariff   = impdata_fil.tariff    
         sic_bran.uwm301.covcod   = nv_covcod
         /*sic_bran.uwm301.cha_no   = impdata_fil.chasno*/ /*A65-0079*/
         sic_bran.uwm301.cha_no   = IF impdata_fil.chasno = "" THEN "-" ELSE impdata_fil.chasno  /*A65-0079*/
         sic_bran.uwm301.trareg   = nv_uwm301trareg    
         sic_bran.uwm301.eng_no   = impdata_fil.eng
         sic_bran.uwm301.Tons     = IF int(impdata_fil.weight) <> 0 AND DECI(impdata_fil.weight) < 100 THEN impdata_fil.weight * 1000 ELSE impdata_fil.weight  
         sic_bran.uwm301.engine   = INTEGER(impdata_fil.engcc)
         sic_bran.uwm301.watts    = INTEGER(impdata_fil.watt)
         sic_bran.uwm301.yrmanu   = INTEGER(impdata_fil.yrmanu)
         sic_bran.uwm301.garage   = impdata_fil.garage
         sic_bran.uwm301.body     = impdata_fil.body
         sic_bran.uwm301.seats    = INTEGER(impdata_fil.seat)
         sic_bran.uwm301.mv41seat = INTEGER(impdata_fil.seat41)
         sic_bran.uwm301.mv_ben83 = IF impdata_fil.poltyp = "V72" THEN "" ELSE IF trim(impdata_fil.benname) = "-" OR trim(impdata_fil.benname) = "Null" THEN ""  /*Null A64-0309*/
                                    ELSE trim(impdata_fil.benname)
         sic_bran.uwm301.vehreg   = impdata_fil.vehreg + " " + impdata_fil.re_country
         sic_bran.uwm301.vehuse   = impdata_fil.vehuse
         sic_bran.uwm301.modcod   = impdata_fil.redbook
         sic_bran.uwm301.moddes   = trim(impdata_fil.brand) + " " + trim(impdata_fil.model) + " " + trim(impdata_fil.submodel)    
         sic_bran.uwm301.sckno    = 0
         sic_bran.uwm301.itmdel   = NO
         sic_bran.uwm301.logbok   = IF TRIM(impdata_fil.inspec) = "N" OR TRIM(impdata_fil.inspec) = "No" THEN "N" 
                                    ELSE IF TRIM(impdata_fil.inspec) = "Y" OR TRIM(impdata_fil.inspec) = "Yes" THEN "Y" ELSE "" 
         sic_bran.uwm301.car_year = INT(impdata_fil.re_year)                                                                
         sic_bran.uwm301.province_reg  = trim(impdata_fil.re_country)                                                   
         sic_bran.uwm301.vehgrp    = trim(impdata_fil.cargrp)                                                   
         sic_bran.uwm301.car_color = trim(impdata_fil.colorcar)                                                  
         sic_bran.uwm301.fuel      = trim(impdata_fil.fule)
         sic_bran.uwm301.watt      = impdata_fil.watt      /* A64-0044-*/                                                   
         impdata_fil.tariff        = sic_bran.uwm301.tariff
         sic_bran.uwm130.i_text    = IF INT(impdata_fil.cctv)  <> 0 THEN "0001" ELSE "" .  /*CCTV */
         

   FOR EACH impacc_fil WHERE impacc_fil.policy = impdata_fil.policy AND impacc_fil.riskno = impdata_fil.riskno AND 
       impacc_fil.itemno = impdata_fil.itemno  NO-LOCK.
       RUN proc_prmtxt.
       IF nv_acc1  <> "" THEN ASSIGN SUBSTRING(sic_bran.uwm301.prmtxt,1,60)    =  nv_acc1.
       IF nv_acc2  <> "" THEN ASSIGN SUBSTRING(sic_bran.uwm301.prmtxt,61,60)   =  nv_acc2.
       IF nv_acc3  <> "" THEN ASSIGN SUBSTRING(sic_bran.uwm301.prmtxt,121,60)  =  nv_acc3.                  
       IF nv_acc4  <> "" THEN ASSIGN SUBSTRING(sic_bran.uwm301.prmtxt,181,60)  =  nv_acc4.                  
       IF nv_acc5  <> "" THEN ASSIGN SUBSTRING(sic_bran.uwm301.prmtxt,241,60)  =  nv_acc5.                  
       IF nv_acc6  <> "" THEN ASSIGN SUBSTRING(sic_bran.uwm301.prmtxt,301,60)  =  nv_acc6.                   
       IF nv_acc7  <> "" THEN ASSIGN SUBSTRING(sic_bran.uwm301.prmtxt,361,60)  =  nv_acc7.                  
       IF nv_acc8  <> "" THEN ASSIGN SUBSTRING(sic_bran.uwm301.prmtxt,421,60)  =  nv_acc8.                  
       IF nv_acc9  <> "" THEN ASSIGN SUBSTRING(sic_bran.uwm301.prmtxt,481,60)  =  nv_acc9.                  
       IF nv_acc10 <> "" THEN ASSIGN SUBSTRING(sic_bran.uwm301.prmtxt,541,60) =  nv_acc10.
   END.
   ASSIGN  sic_bran.uwm301.bchyr = nv_batchyr       /* batch Year */
           sic_bran.uwm301.bchno = nv_batchno       /* bchno      */
           sic_bran.uwm301.bchcnt= nv_batcnt  .    /* bchcnt     */
         /*  impdata_fil.drivername1 = impdata_fil.ntitle1 + " " + impdata_fil.drivername1 + " " + impdata_fil.dname2   */ /*A67-0029*/
         /*  impdata_fil.drivername2 = impdata_fil.ntitle2 + " " + impdata_fil.drivername2 + " " + impdata_fil.ddname1 .*/ /*A67-0029*/ 
   IF impdata_fil.prepol = "" THEN DO:
     IF INT(impdata_fil.drivnam) > 0 THEN DO:
         ASSIGN impdata_fil.drivnam = "Y" .
         /*RUN proc_mailtxt.  /*A55-0151*/*/ /*A67-0029*/
         RUN proc_chkdrive. /*A67-0029*/
     END.
     ELSE impdata_fil.drivnam = "N".
   END.
   ELSE DO:
         FOR EACH ws0m009 WHERE ws0m009.policy  = impdata_fil.driver NO-LOCK .
            CREATE brstat.mailtxt_fil.
            ASSIGN
                brstat.mailtxt_fil.policy  = TRIM(sic_bran.uwm301.policy) +
                             STRING(sic_bran.uwm301.rencnt,"99" ) +
                             STRING(sic_bran.uwm301.endcnt,"999")  +
                             STRING(sic_bran.uwm301.riskno,"999") +
                             STRING(sic_bran.uwm301.itemno,"999")    
                brstat.mailtxt_fil.lnumber = INTEGER(ws0m009.lnumber)
                brstat.mailtxt_fil.ltext   = ws0m009.ltext  
                brstat.mailtxt_fil.ltext2  = ws0m009.ltext2   
                brstat.mailtxt_fil.bchyr   = nv_batchyr 
                brstat.mailtxt_fil.bchno   = nv_batchno 
                brstat.mailtxt_fil.bchcnt  = nv_batcnt .
            ASSIGN nv_drivno = INTEGER(ws0m009.lnumber).
         END.
       IF nv_drivno <> 0 THEN DO:
           ASSIGN impdata_fil.drivnam = "Y" 
                  sic_bran.uwm301.actprm   = impdata_fil.nname .
       END.
   END.
   ASSIGN s_recid4    = RECID(sic_bran.uwm301).
   IF impdata_fil.redbook <> "" THEN DO:
       FIND FIRST stat.maktab_fil USE-INDEX maktab01   WHERE 
           stat.maktab_fil.sclass = impdata_fil.subclass  AND
           stat.maktab_fil.modcod = impdata_fil.redbook   No-lock no-error no-wait.
       If  avail  stat.maktab_fil  Then 
           ASSIGN
           sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod 
           sic_bran.uwm301.vehgrp  =  IF impdata_fil.cargrp = "" THEN stat.maktab_fil.prmpac ELSE impdata_fil.cargrp /*A65-0079*/
           impdata_fil.cargrp      =  IF impdata_fil.cargrp = "" THEN stat.maktab_fil.prmpac ELSE impdata_fil.cargrp /*A65-0079*/
           impdata_fil.seat41      =  IF impdata_fil.seat41 = 0 THEN stat.maktab_fil.seats ELSE impdata_fil.seat41 .
  END.
  ELSE RUN proc_maktab.
  IF TRIM(impdata_fil.redbook) = " " THEN ASSIGN impdata_fil.comment = impdata_fil.comment + "| Redbook เป็นค่าว่าง " .
END.*/
/*RELEASE brStat.Detaitem.
RELEASE brstat.mailtxt_fil .*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_mailtxt C-Win 
PROCEDURE 00-proc_mailtxt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A67-0029...
DEF VAR no_policy AS CHAR FORMAT "x(20)" .
DEF VAR no_rencnt AS CHAR FORMAT "99".
DEF VAR no_endcnt AS CHAR FORMAT "999".
DEF VAR no_riskno AS CHAR FORMAT "999".
DEF VAR no_itemno AS CHAR FORMAT "999".
DEF VAR nv_sex1   AS CHAR FORMAT "x(5)" init ""  .
DEF VAR nv_sex2   AS CHAR FORMAT "x(5)" init ""  .
DEF VAR nv_occup1 AS CHAR FORMAT "x(50)" init ""  .   
DEF VAR nv_occup2 AS CHAR FORMAT "x(50)" init ""  .  
DEF VAR nv_idno1  AS CHAR FORMAT "x(13)" init ""  .   
DEF VAR nv_idno2  AS CHAR FORMAT "x(13)" init ""  .   
DEF VAR nv_licen1 AS CHAR FORMAT "x(13)" init ""  .   
DEF VAR nv_licen2 AS CHAR FORMAT "x(13)" init ""  .   

IF  impdata_fil.drivnam = "Y" THEN DO :      /*note add 07/11/2005*/
  no_policy = sic_bran.uwm301.policy .
  no_rencnt = STRING(sic_bran.uwm301.rencnt,"99") .
  no_endcnt = STRING(sic_bran.uwm301.endcnt,"999") .

  no_riskno = STRING(impdata_fil.riskno,"999").
  no_itemno = STRING(impdata_fil.itemno,"999").
  ASSIGN nv_lnumber  = 0
         nv_drivage1 = 0
         nv_drivage2 = 0
         nv_drivbir1 = ""
         nv_drivbir2 = ""
         nv_sex1     = ""    nv_sex1     = if trim(impdata_fil.dgender1) = "M" then "MALE" else if trim(impdata_fil.dgender1) = "F" then "FEMALE" else ""
         nv_sex2     = ""    nv_sex2     = if trim(impdata_fil.dgender2) = "M" then "MALE" else if trim(impdata_fil.dgender2) = "F" then "FEMALE" else ""
         nv_occup1   = ""    nv_occup1   = trim(impdata_fil.docoup) 
         nv_occup2   = ""    nv_occup2   = trim(impdata_fil.ddocoup)
         nv_idno1    = ""    nv_idno1    = trim(impdata_fil.dicno) 
         nv_idno2    = ""    nv_idno2    = trim(impdata_fil.ddicno)
         nv_licen1   = ""    nv_licen1   = trim(impdata_fil.ddriveno)
         nv_licen2   = ""    nv_licen2   = trim(impdata_fil.dddriveno) 
         impdata_fil.dbirth    = STRING(DATE(impdata_fil.dbirth),"99/99/9999")
         impdata_fil.ddbirth   = STRING(DATE(impdata_fil.ddbirth),"99/99/9999") .

  nv_drivage1 = INT(SUBSTR(impdata_fil.dbirth,7,4)) .
  nv_drivage2 = INT(SUBSTR(impdata_fil.ddbirth,7,4)) .

  if nv_drivage1 < year(today) then do:
      nv_drivage1 =  YEAR(TODAY) - nv_drivage1  .
      IF impdata_fil.dbirth <> " "  AND impdata_fil.drivername1 <> " " THEN DO: /*note add & modified*/
        ASSIGN  nv_drivbir1    = STRING(INT(SUBSTR(impdata_fil.dbirth,7,4))  + 543 )
                impdata_fil.dbirth = SUBSTR(impdata_fil.dbirth,1,6) + nv_drivbir1
                impdata_fil.dbirth = STRING(DATE(impdata_fil.dbirth),"99/99/9999") .
      END.
  END.
  ELSE DO:
      nv_drivage1 =  YEAR(TODAY) - (nv_drivage1 - 543).
      IF impdata_fil.dbirth <> " "  AND impdata_fil.drivername1 <> " " THEN DO: /*note add & modified*/
          ASSIGN 
          nv_drivbir1    = STRING(INT(SUBSTR(impdata_fil.dbirth,7,4)))
          impdata_fil.dbirth = SUBSTR(impdata_fil.dbirth,1,6) + nv_drivbir1
          impdata_fil.dbirth = STRING(DATE(impdata_fil.dbirth),"99/99/9999") .
      END.
  END.
  if nv_drivage2 < year(today) then do:
       nv_drivage2 =  YEAR(TODAY) - nv_drivage2  .
       IF impdata_fil.ddbirth <>  " " AND impdata_fil.drivername2 <> " " THEN DO: /*note add & modified */
           ASSIGN 
            nv_drivbir2       = STRING(INT(SUBSTR(impdata_fil.ddbirth,7,4))  + 543 )
            impdata_fil.ddbirth   = SUBSTR(impdata_fil.ddbirth,1,6) + nv_drivbir2
            impdata_fil.ddbirth   = STRING(DATE(impdata_fil.ddbirth),"99/99/9999").
       END.
  END.
  ELSE DO:
       nv_drivage2 =  YEAR(TODAY) - (nv_drivage2 - 543) .
       IF impdata_fil.ddbirth <>  " " AND impdata_fil.drivername2 <> " " THEN DO: /*note add & modified */
           ASSIGN
              nv_drivbir2       = STRING(INT(SUBSTR(impdata_fil.ddbirth,7,4)) )
              impdata_fil.ddbirth   = SUBSTR(impdata_fil.ddbirth,1,6) + nv_drivbir2
              impdata_fil.ddbirth   = STRING(DATE(impdata_fil.ddbirth),"99/99/9999").
       END.
  END.
  
  FIND  LAST   brstat.mailtxt_fil  USE-INDEX  mailtxt01  WHERE
               brstat.mailtxt_fil.policy  = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno  AND
               brstat.mailtxt_fil.bchyr = nv_batchyr   AND                                               
               brstat.mailtxt_fil.bchno = nv_batchno   AND
               brstat.mailtxt_fil.bchcnt  = nv_batcnt    NO-LOCK  NO-ERROR  NO-WAIT.
        IF NOT AVAIL brstat.mailtxt_fil THEN  nv_lnumber =   1.                                                      


        FIND FIRST   brstat.mailtxt_fil  USE-INDEX  mailtxt01  WHERE
                     brstat.mailtxt_fil.policy  = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno     AND
                     brstat.mailtxt_fil.lnumber = nv_lnumber    AND
                     brstat.mailtxt_fil.bchyr = nv_batchyr    AND                                               
                     brstat.mailtxt_fil.bchno = nv_batchno    AND
                     brstat.mailtxt_fil.bchcnt  = nv_batcnt     NO-LOCK  NO-ERROR  NO-WAIT.
        IF NOT AVAIL brstat.mailtxt_fil   THEN DO:
              CREATE brstat.mailtxt_fil.
              ASSIGN                                           
                     brstat.mailtxt_fil.policy    = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno
                     brstat.mailtxt_fil.lnumber   = nv_lnumber.
                     brstat.mailtxt_fil.ltext     = impdata_fil.drivername1 + FILL(" ",50 - LENGTH(impdata_fil.drivername1)) + nv_sex1 . 
                     brstat.mailtxt_fil.ltext2    = impdata_fil.dbirth + "  " 
                                                  + string(nv_drivage1).
                     nv_drivno                    = 1 .
                     ASSIGN 
                     brstat.mailtxt_fil.bchyr = nv_batchyr 
                     brstat.mailtxt_fil.bchno = nv_batchno 
                     brstat.mailtxt_fil.bchcnt  = nv_batcnt 
                     SUBSTRING(brstat.mailtxt_fil.ltext2,16,40)   =  nv_occup1
                     SUBSTRING(brstat.mailtxt_fil.ltext2,101,50)  =  nv_idno1
                     SUBSTRING(brstat.mailtxt_fil.ltext2,151,50)  =  nv_licen1 
                     SUBSTRING(brstat.mailtxt_fil.ltext2,201,4)   =  "" . 
                     
              IF impdata_fil.drivername2 <> "" THEN DO:
                    CREATE brstat.mailtxt_fil. 
                    ASSIGN
                        brstat.mailtxt_fil.policy   = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno
                        brstat.mailtxt_fil.lnumber  = nv_lnumber + 1
                        brstat.mailtxt_fil.ltext    = impdata_fil.drivername2 + FILL(" ",50 - LENGTH(impdata_fil.drivername2)) + nv_sex2 
                        brstat.mailtxt_fil.ltext2   = impdata_fil.ddbirth + "  " + string(nv_drivage2) 
                        nv_drivno                   = 2.
                        ASSIGN /*a490166*/
                        brstat.mailtxt_fil.bchyr = nv_batchyr 
                        brstat.mailtxt_fil.bchno = nv_batchno 
                        brstat.mailtxt_fil.bchcnt  = nv_batcnt 
                        SUBSTRING(brstat.mailtxt_fil.ltext2,16,40)  =  nv_occup2
                        SUBSTRING(brstat.mailtxt_fil.ltext2,101,50) =  nv_idno2
                        SUBSTRING(brstat.mailtxt_fil.ltext2,151,50) =  nv_licen2
                        SUBSTRING(brstat.mailtxt_fil.ltext2,201,4)  =  "" . 
              END.  /*drivnam2 <> " " */
        END. /*End Avail Brstat*/
        ELSE  DO:
              CREATE  brstat.mailtxt_fil.
              ASSIGN  brstat.mailtxt_fil.policy     = impdata_fil.policy + string(sic_bran.uwm100.rencnt) + string(sic_bran.uwm100.endcnt) + string(sic_bran.uwm301.riskno)  + string(sic_bran.uwm301.itemno)
                      brstat.mailtxt_fil.lnumber    = nv_lnumber
                      brstat.mailtxt_fil.ltext      = impdata_fil.drivername1 + FILL(" ",50 - LENGTH(impdata_fil.drivername1)) + nv_sex1 
                      brstat.mailtxt_fil.ltext2     = impdata_fil.dbirth + "  " +  TRIM(string(nv_drivage1))
                      SUBSTRING(brstat.mailtxt_fil.ltext2,16,40)   =  nv_occup1
                      SUBSTRING(brstat.mailtxt_fil.ltext2,101,50)  =  nv_idno1
                      SUBSTRING(brstat.mailtxt_fil.ltext2,151,50)  =  nv_licen1 
                      SUBSTRING(brstat.mailtxt_fil.ltext2,201,4)   =  "" . 

                      IF impdata_fil.drivername2 <> "" THEN DO:
                            CREATE  brstat.mailtxt_fil.
                                ASSIGN
                                brstat.mailtxt_fil.policy   = impdata_fil.policy + string(uwm100.rencnt) + string(uwm100.endcnt) + string(uwm301.riskno)  + string(uwm301.itemno)
                                brstat.mailtxt_fil.lnumber  = nv_lnumber + 1
                                brstat.mailtxt_fil.ltext    = impdata_fil.drivername2 + FILL(" ",50 - LENGTH(impdata_fil.drivername2)) + nv_sex2
                                brstat.mailtxt_fil.ltext2   = impdata_fil.ddbirth + "  " + TRIM(string(nv_drivage2)).
                                ASSIGN /*a490166*/
                                brstat.mailtxt_fil.bchyr = nv_batchyr 
                                brstat.mailtxt_fil.bchno = nv_batchno 
                                brstat.mailtxt_fil.bchcnt  = nv_batcnt 
                                SUBSTRING(brstat.mailtxt_fil.ltext2,16,40)  =  nv_occup2
                                SUBSTRING(brstat.mailtxt_fil.ltext2,101,50) =  nv_idno2
                                SUBSTRING(brstat.mailtxt_fil.ltext2,151,50) =  nv_licen2
                                SUBSTRING(brstat.mailtxt_fil.ltext2,201,4)  =  "" . 
                      END. /*drivnam2 <> " " */                                     
        END. /*Else DO*/                                                            
 END. /*note add for mailtxt 07/11/2005*/
RELEASE brstat.mailtxt_fil .
...end A67-0029..*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_reportpolno_2 C-Win 
PROCEDURE 00-proc_reportpolno_2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A67-0029
DEF VAR n_count AS INT INIT 0.
DO:
    FOR EACH impdata_fil  USE-INDEX data_fil10       WHERE 
             impdata_fil.usrid  = USERID(LDBNAME(1)) AND 
             impdata_fil.progid = trim(nv_proid)     NO-LOCK BY riskno .
             n_count = n_count + 1.                 
    
      FIND FIRST impacc_fil  use-index acc_fil03  WHERE 
        impacc_fil.policyno = TRIM(impdata_fil.policyno) AND
        impacc_fil.riskno   = impdata_fil.riskno   AND
        impacc_fil.itemno   = impdata_fil.itemno   AND 
        impacc_fil.usrid    = impdata_fil.usrid    AND 
        impacc_fil.progid   = impdata_fil.progid   NO-LOCK NO-ERROR NO-WAIT .
          
      FIND FIRST impinst_fil USE-INDEX inst_fil02  WHERE
        impinst_fil.usrid    = impdata_fil.usrid   AND     
        impinst_fil.progid   = impdata_fil.progid  AND     
        impinst_fil.policyno = trim(impdata_fil.policyno) NO-LOCK NO-ERROR NO-WAIT.

      FIND FIRST impdriv_fil   WHERE  
       impdriv_fil.policy  = TRIM(impdata_fil.policyno) AND                
       impdriv_fil.riskno  = impdata_fil.riskno   AND                   
       impdriv_fil.itemno  = impdata_fil.itemno   AND
       impdriv_fil.usrid   = impdata_fil.usrid    and
       impdriv_fil.progid  = impdata_fil.progid   NO-LOCK NO-ERROR NO-WAIT.
                                                  
      PUT STREAM ns1 
                impdata_fil.riskno       "|"
                impdata_fil.itemno       "|"
                impdata_fil.policyno FORMAT "x(15)"  "|"
                impdata_fil.n_branch     "|"
                impdata_fil.agent        "|"
                impdata_fil.producer     "|"
                impdata_fil.n_delercode  "|"
                impdata_fil.fincode      "|"
                impdata_fil.appenno      "|"
                impdata_fil.salename     "|"
                impdata_fil.srate        "|"
                impdata_fil.comdat       "|"
                impdata_fil.expdat       "|"
                impdata_fil.agreedat     "|"
                impdata_fil.firstdat     "|"
                impdata_fil.packcod      "|"
                impdata_fil.camp_no      "|"
                impdata_fil.campen       "|"
                impdata_fil.specon       "|"
                impdata_fil.product      "|"
                impdata_fil.promo        "|"
                impdata_fil.rencnt       "|"
                impdata_fil.prepol       "|".

      FIND FIRST imptxt_fil  use-index txt_fil02    WHERE 
        imptxt_fil.usrid    = impdata_fil.usrid     AND 
        imptxt_fil.progid   = impdata_fil.progid    AND 
        imptxt_fil.policyno = trim(impdata_fil.policyno) NO-LOCK NO-ERROR NO-WAIT .
      IF AVAIL imptxt_fil THEN DO:
          PUT STREAM ns1
                imptxt_fil.txt1          "|"
                imptxt_fil.txt2          "|"
                imptxt_fil.txt3          "|"
                imptxt_fil.txt4          "|"
                imptxt_fil.txt5          "|"
                imptxt_fil.txt6          "|"
                imptxt_fil.txt7          "|"
                imptxt_fil.txt8          "|"
                imptxt_fil.txt9          "|"
                imptxt_fil.txt10         "|".
      END.
      ELSE DO:
          PUT STREAM ns1
               ""        "|"
               ""        "|"
               ""        "|"
               ""        "|"
               ""        "|"
               ""        "|"
               ""        "|"
               ""        "|"
               ""        "|"
               ""        "|".
      END.
      FIND FIRST impmemo_fil use-index memo_fil02   WHERE 
        impmemo_fil.usrid    = impdata_fil.usrid    AND 
        impmemo_fil.progid   = impdata_fil.progid   AND 
        impmemo_fil.policyno = trim(impdata_fil.policyno) NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL impmemo_fil THEN DO:
          PUT STREAM ns1
                impmemo_fil.memo1        "|"
                impmemo_fil.memo2        "|"
                impmemo_fil.memo3        "|"
                impmemo_fil.memo4        "|"
                impmemo_fil.memo5        "|"
                impmemo_fil.memo6        "|"
                impmemo_fil.memo7        "|"
                impmemo_fil.memo8        "|"
                impmemo_fil.memo9        "|"
                impmemo_fil.memo10       "|" .
      END.
      ELSE DO:
          PUT STREAM ns1
                ""    "|"
                ""    "|"
                ""    "|"
                ""    "|"
                ""    "|"
                ""    "|"
                ""    "|"
                ""    "|"
                ""    "|"
                ""    "|" .
      END.
      PUT STREAM ns1
                impacc_fil.accdata1       "|"
                impacc_fil.accdata2       "|"
                impacc_fil.accdata3       "|"
                impacc_fil.accdata4       "|"
                impacc_fil.accdata5       "|"
                impacc_fil.accdata6       "|"
                impacc_fil.accdata7       "|"
                impacc_fil.accdata8       "|"
                impacc_fil.accdata9       "|"
                impacc_fil.accdata10      "|"
                impdata_fil.compul        "|"
                impdata_fil.insref        "|"
                impdata_fil.instyp        "|"
                impdata_fil.inslang       "|"
                impdata_fil.tiname        "|"
                impdata_fil.insnam        "|"
                impdata_fil.lastname      "|"
                impdata_fil.icno          "|"
                impdata_fil.insbr         "|"
                impdata_fil.occup         "|"
                impdata_fil.addr          "|"
                impdata_fil.tambon        "|"
                impdata_fil.amper         "|"
                impdata_fil.country       "|"
                impdata_fil.post          "|"
                impdata_fil.provcod       "|"
                impdata_fil.distcod       "|"
                impdata_fil.sdistcod      "|"
                impdata_fil.jpae          "|"
                impdata_fil.jpjtl         "|"
                impdata_fil.jpts          "|"
                impdata_fil.gender        "|"
                impdata_fil.tele1         "|"
                impdata_fil.tele2         "|"
                impdata_fil.mail1         "|"
                impdata_fil.mail2         "|"
                impdata_fil.mail3         "|"
                impdata_fil.mail4         "|"
                impdata_fil.mail5         "|"
                impdata_fil.mail6         "|"
                impdata_fil.mail7         "|"
                impdata_fil.mail8         "|"
                impdata_fil.mail9         "|"
                impdata_fil.mail10        "|"
                impdata_fil.fax           "|"
                impdata_fil.lineID        "|"
                impdata_fil.name2         "|"
                impdata_fil.name3         "|"
                impdata_fil.benname       "|"
                impdata_fil.payercod      "|"
                impdata_fil.vatcode       "|"
                impinst_fil.instcod1        "|"
                impinst_fil.insttyp1        "|"
                impinst_fil.insttitle1      "|"
                impinst_fil.instname1       "|"
                impinst_fil.instlname1      "|"
                impinst_fil.instic1         "|"
                impinst_fil.instbr1         "|"
                impinst_fil.instaddr11      "|"
                impinst_fil.instaddr21      "|"
                impinst_fil.instaddr31      "|"
                impinst_fil.instaddr41      "|"
                impinst_fil.instpost1       "|"
                impinst_fil.instprovcod1    "|"
                impinst_fil.instdistcod1    "|"
                impinst_fil.instsdistcod1   "|"
                impinst_fil.instprm1        "|"
                impinst_fil.instrstp1       "|"
                impinst_fil.instrtax1       "|"
                impinst_fil.instcomm01      "|"
                impinst_fil.instcomm12      "|"
                impinst_fil.instcod2        "|"
                impinst_fil.insttyp2        "|"
                impinst_fil.insttitle2      "|"
                impinst_fil.instname2       "|"
                impinst_fil.instlname2      "|"
                impinst_fil.instic2         "|"
                impinst_fil.instbr2         "|"
                impinst_fil.instaddr12      "|"
                impinst_fil.instaddr22      "|"
                impinst_fil.instaddr32      "|"
                impinst_fil.instaddr42      "|"
                impinst_fil.instpost2       "|"
                impinst_fil.instprovcod2    "|"
                impinst_fil.instdistcod2    "|"
                impinst_fil.instsdistcod2   "|"
                impinst_fil.instprm2        "|"
                impinst_fil.instrstp2       "|"
                impinst_fil.instrtax2       "|"
                impinst_fil.instcomm02      "|"
                impinst_fil.instcomm22      "|"
                impinst_fil.instcod3        "|"
                impinst_fil.insttyp3        "|"
                impinst_fil.insttitle3      "|"
                impinst_fil.instname3       "|"
                impinst_fil.instlname3      "|"
                impinst_fil.instic3         "|"
                impinst_fil.instbr3         "|"
                impinst_fil.instaddr13      "|"
                impinst_fil.instaddr23      "|"
                impinst_fil.instaddr33      "|"
                impinst_fil.instaddr43      "|"
                impinst_fil.instpost3       "|"
                impinst_fil.instprovcod3    "|"
                impinst_fil.instdistcod3    "|"
                impinst_fil.instsdistcod3   "|"
                impinst_fil.instprm3        "|"
                impinst_fil.instrstp3       "|"
                impinst_fil.instrtax3       "|"
                impinst_fil.instcomm03      "|"
                impinst_fil.instcomm23      "|"
                impdata_fil.covcod        "|"
                impdata_fil.garage        "|"
                impdata_fil.special       "|"
                impdata_fil.inspec        "|"
                impdata_fil.class70       "|"
                impdata_fil.vehuse        "|"  /* ranu : 15/12/2021*/
                impdata_fil.redbook       "|"  /* A65-0079 Redbook */
                impdata_fil.brand         "|"
                impdata_fil.model         "|"
                impdata_fil.submodel      "|"
                impdata_fil.yrmanu        "|"
                impdata_fil.chasno        "|"
                impdata_fil.eng           "|"
                impdata_fil.seat41        "|"
                impdata_fil.engcc         "|"
                impdata_fil.weight        "|"
                impdata_fil.watt          "|"
                impdata_fil.body          "|"
                impdata_fil.typ           "|"
                impdata_fil.re_year       "|"
                impdata_fil.vehreg        "|"
                impdata_fil.re_country    "|"
                impdata_fil.cargrp        "|"
                impdata_fil.colorcar      "|"
                impdata_fil.fule          "|"
                impdata_fil.drivnam       "|"
                impdata_fil.ntitle1       "|"
                impdata_fil.drivername1   "|"
                impdata_fil.dname2        "|"
                impdata_fil.dicno         "|"
                impdata_fil.dgender1      "|"
                impdata_fil.dbirth        "|"
                impdata_fil.docoup        "|"
                impdata_fil.ddriveno      "|"
                impdata_fil.ntitle2       "|"
                impdata_fil.drivername2   "|"
                impdata_fil.ddname1       "|"
                impdata_fil.ddicno        "|"
                impdata_fil.dgender2      "|"
                impdata_fil.ddbirth       "|"
                impdata_fil.ddocoup       "|"
                impdata_fil.dddriveno     "|"
                impdata_fil.baseplus      "|"
                impdata_fil.siplus        "|"
                impdata_fil.rs10          "|"
                impdata_fil.comper        "|"
                impdata_fil.comacc        "|"
                impdata_fil.deductpd      "|"
                impdata_fil.DOD           "|"
                impdata_fil.dgatt         "|"  /*A65-0079 DOD1 */ 
                impdata_fil.DPD           "|"
                impdata_fil.si            "|"
                impdata_fil.NO_411        "|"
                impdata_fil.seat41        "|"
                impdata_fil.NO_412        "|"
                impdata_fil.NO_413        "|"
                impdata_fil.pass_no       "|"
                impdata_fil.NO_414        "|"
                impdata_fil.NO_42         "|"
                impdata_fil.NO_43         "|"
                impdata_fil.base          "|"
                impdata_fil.unname        "|"
                impdata_fil.nname         "|"
                impdata_fil.tpbi          "|"
                impdata_fil.dgsi          "|" /*A65-0079 BI2 prem */
                impdata_fil.tppd          "|"
                impdata_fil.int1          "|" /*A65-0079 dod  prem*/
                impdata_fil.int2          "|" /*A65-0079 dod1 prem */
                impdata_fil.int3          "|" /*A65-0079 dpd  prem*/
                impdata_fil.ry01          "|"
                impdata_fil.deci1         "|" /*A65-0079 412 prem */
                impdata_fil.deci2         "|" /*A65-0079 413 prem */
                impdata_fil.deci3         "|" /*A65-0079 414 prem */
                impdata_fil.ry02          "|"
                impdata_fil.ry03          "|"
                impdata_fil.fleet         "|"
                impdata_fil.ncb           "|"
                impdata_fil.claim         "|"
                impdata_fil.dspc          "|"
                impdata_fil.cctv          "|"
                impdata_fil.dstf          "|"
                impdata_fil.fleetprem     "|"
                impdata_fil.ncbprem       "|"
                impdata_fil.clprem        "|"
                impdata_fil.dspcprem      "|"
                impdata_fil.cctvprem      "|"
                impdata_fil.dstfprem      "|"
                impdata_fil.premt         "|"
                impdata_fil.rstp_t        "|"
                impdata_fil.rtax_t        "|"
                impdata_fil.comper70      "|"
                impdata_fil.comprem70     "|"
                impdata_fil.agco70        "|"
                impdata_fil.comco_per70   "|"
                impdata_fil.comco_prem70  "|"
                impdata_fil.dgpackge      "|"
                impdata_fil.danger1       "|"
                impdata_fil.danger2       "|"
                /*impdata_fil.dgsi          "|" */ /*A65-0079 : ย้ายไปเก็บ tpbi2 amount */ 
                " "                      "|"     /*A65-0079 : ย้ายไปเก็บ tpbi2 amount */ 
                impdata_fil.dgrate        "|"
                impdata_fil.dgfeet        "|"
                impdata_fil.dgncb         "|"
                impdata_fil.dgdisc        "|"
                impdata_fil.dgWdisc       "|"
                /*impdata_fil.dgatt         "|" */ /*A65-0079 : ย้ายไปเก็บ DOD1*/ 
                " "                       "|"    /*A65-0079 : ย้ายไปเก็บ DOD1*/
                impdata_fil.dgfeetprm     "|"
                impdata_fil.dgncbprm      "|"
                impdata_fil.dgdiscprm     "|"
                impdata_fil.dgWdiscprm    "|"
                impdata_fil.dgprem        "|"
                impdata_fil.dgrstp_t      "|"
                impdata_fil.dgrtax_t      "|"
                impdata_fil.dgcomper      "|"
                impdata_fil.dgcomprem     "|"
                impdata_fil.cltxt         "|"
                impdata_fil.clamount      "|"
                impdata_fil.faultno       "|"
                impdata_fil.faultprm      "|"
                impdata_fil.goodno        "|"
                impdata_fil.goodprm       "|"
                impdata_fil.loss          "|"
                impdata_fil.compolusory   "|"
                impdata_fil.stk           "|"
                impdata_fil.class72       "|"
                impdata_fil.dstf72        "|"
                impdata_fil.dstfprem72    "|"
                impdata_fil.premt72       "|"
                impdata_fil.rstp_t72      "|"
                impdata_fil.rtax_t72      "|"
                impdata_fil.comper72      "|"
                impdata_fil.comprem72     "|"
                impdata_fil.comment       SKIP .
    END.
END. */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

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
  DISPLAY tg_format fi_loaddat fi_pack fi_bchno fi_prevbat fi_bchyr fi_filename 
          fi_output1 fi_output2 fi_output3 fi_process fi_outputpro fi_impcnt 
          fi_completecnt fi_premtot fi_premsuc ra_match ra_type tg_flag 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE br_impdata_fil tg_format fi_loaddat fi_pack fi_bchno fi_prevbat 
         fi_bchyr fi_filename bu_file fi_output1 fi_output2 fi_output3 buok 
         bu_exit fi_outputpro ra_match ra_type tg_flag RECT-372 RECT-374 
         RECT-376 RECT-377 RECT-378 RECT-380 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_722 C-Win 
PROCEDURE proc_722 :
/* ---------------------------------------------  U W M 1 3 0 -------------- */
/*
ASSIGN fi_process = "Process data File Load....sic_bran.uwm130,sic_bran.uwm301"  .
        DISP fi_process WITH FRAM fr_main.
FIND sic_bran.uwm130 USE-INDEX uwm13001 WHERE
    sic_bran.uwm130.policy = sic_bran.uwm100.policy AND
    sic_bran.uwm130.rencnt = sic_bran.uwm100.rencnt AND
    sic_bran.uwm130.endcnt = sic_bran.uwm100.endcnt AND
    sic_bran.uwm130.riskgp = s_riskgp     AND            /*0*/
    sic_bran.uwm130.riskno = s_riskno     AND            /*1*/
    sic_bran.uwm130.itemno = s_itemno     AND            /*1*/
    sic_bran.uwm130.bchyr  = nv_batchyr   AND            /*26/10/2006 change field name */
    sic_bran.uwm130.bchno  = nv_batchno   AND            /*26/10/2006 change field name */ 
    sic_bran.uwm130.bchcnt = nv_batcnt                     /*26/10/2006 change field name */            
    NO-WAIT NO-ERROR.
IF NOT AVAILABLE sic_bran.uwm130 THEN 
    DO TRANSACTION:
    CREATE sic_bran.uwm130.
    ASSIGN sic_bran.uwm130.policy = sic_bran.uwm120.policy
        sic_bran.uwm130.rencnt = sic_bran.uwm120.rencnt   sic_bran.uwm130.endcnt = sic_bran.uwm120.endcnt
        sic_bran.uwm130.riskgp = sic_bran.uwm120.riskgp   sic_bran.uwm130.riskno = sic_bran.uwm120.riskno
        sic_bran.uwm130.itemno = s_itemno.
    ASSIGN  sic_bran.uwm130.bchyr = nv_batchyr     /* batch Year */
        sic_bran.uwm130.bchno = nv_batchno         /* bchno      */
        sic_bran.uwm130.bchcnt  = nv_batcnt .      /* bchcnt     */
    ASSIGN  sic_bran.uwm130.uom6_v   = 0
        sic_bran.uwm130.uom7_v   = 0
        sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0     /*Item Upper text*/
        sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0     /*Item Lower Text*/
        sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0     /*Cover & Premium*/
        sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0     /*Item Endt. Text*/
        sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0.    /*Item Endt. Clause*/
    FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE  sicsyac.xmm016.class =   sic_bran.uwm120.class
        NO-LOCK NO-ERROR.
    IF AVAIL sicsyac.xmm016 THEN 
        ASSIGN  sic_bran.uwm130.uom8_c = sicsyac.xmm016.uom8
        sic_bran.uwm130.uom9_c = sicsyac.xmm016.uom9 
        nv_comper     = deci(sicsyac.xmm016.si_d_t[8]) 
        nv_comacc     = deci(sicsyac.xmm016.si_d_t[9])                                           
        sic_bran.uwm130.uom8_v   = nv_comper   
        sic_bran.uwm130.uom9_v   = nv_comacc  .   
    ASSIGN  nv_riskno = 1
        nv_itemno = 1.
    IF impdata_fil.covcod = "1" Then 
        RUN wgs/wgschsum(INPUT  impdata_fil.policy,         /*a490166 Note modi*/
                         nv_riskno,
                         nv_itemno).
END.   /*transaction*/
s_recid3  = RECID(sic_bran.uwm130).
/* ---------------------------------------------  U W M 3 0 1 --------------*/ 
ASSIGN 
nv_covcod =   impdata_fil.covcod
nv_makdes  =  impdata_fil.brand
nv_moddes  =  impdata_fil.model.
/*--Str Amparat C. A51-0253--*/
nv_newsck = " ".
RUN proc_chassic .  /*A64-0044*/
IF SUBSTR(impdata_fil.stk,1,1) = "2" THEN nv_newsck = "0" + impdata_fil.stk.
ELSE nv_newsck = impdata_fil.stk.
     /*--End Amparat C. A51-0253--*/       
     FIND sic_bran.uwm301 USE-INDEX uwm30101      WHERE
         sic_bran.uwm301.policy = sic_bran.uwm100.policy  AND
         sic_bran.uwm301.rencnt = sic_bran.uwm100.rencnt  AND
         sic_bran.uwm301.endcnt = sic_bran.uwm100.endcnt  AND
         sic_bran.uwm301.riskgp = s_riskgp                AND
         sic_bran.uwm301.riskno = s_riskno                AND
         sic_bran.uwm301.itemno = s_itemno                AND
         sic_bran.uwm301.bchyr = nv_batchyr               AND 
         sic_bran.uwm301.bchno = nv_batchno               AND 
         sic_bran.uwm301.bchcnt  = nv_batcnt     NO-WAIT NO-ERROR.
    IF NOT AVAILABLE sic_bran.uwm301 THEN DO:
        DO TRANSACTION:
            CREATE sic_bran.uwm301.
        END. /*transaction*/
    END.                                                          
    Assign sic_bran.uwm301.policy  = sic_bran.uwm120.policy                   
        sic_bran.uwm301.rencnt  = sic_bran.uwm120.rencnt
        sic_bran.uwm301.endcnt  = sic_bran.uwm120.endcnt
        sic_bran.uwm301.riskgp  = sic_bran.uwm120.riskgp
        sic_bran.uwm301.riskno  = sic_bran.uwm120.riskno
        sic_bran.uwm301.itemno  = s_itemno
        sic_bran.uwm301.tariff  = impdata_fil.tariff
        sic_bran.uwm301.covcod  = nv_covcod
        sic_bran.uwm301.cha_no  = impdata_fil.chasno
        sic_bran.uwm301.trareg  = nv_uwm301trareg    /*A64-0044*/
        sic_bran.uwm301.eng_no  = impdata_fil.eng
        sic_bran.uwm301.Tons    = INTEGER(impdata_fil.weight)
        sic_bran.uwm301.engine  = INTEGER(impdata_fil.engcc)
        sic_bran.uwm301.yrmanu  = INTEGER(impdata_fil.yrmanu)
        sic_bran.uwm301.garage  = impdata_fil.garage
        sic_bran.uwm301.body    = impdata_fil.body
        sic_bran.uwm301.seats   = INTEGER(impdata_fil.seat)
        /*sic_bran.uwm301.mv_ben83 = impdata_fil.benname*/ /*A64-0309 */
        sic_bran.uwm301.mv_ben83 = IF impdata_fil.benname <> "-" AND impdata_fil.benname <> "Null" THEN impdata_fil.benname ELSE ""  /*A64-0309 */
        /*sic_bran.uwm301.vehreg   = impdata_fil.vehreg + nv_provi*/ /*A64-0309 */
        sic_bran.uwm301.vehreg   = trim(impdata_fil.vehreg) + " " + trim(impdata_fil.re_country)  /*A64-0309 */
        sic_bran.uwm301.vehuse   = impdata_fil.vehuse
        /*sic_bran.uwm301.moddes   = impdata_fil.model + " " +  */    
        sic_bran.uwm301.moddes    = trim(impdata_fil.brand) + " " + trim(impdata_fil.model) + " " + trim(impdata_fil.submodel)
        sic_bran.uwm301.modcod   = impdata_fil.redbook 
        sic_bran.uwm301.sckno    = 0              
        sic_bran.uwm301.itmdel   = NO
        sic_bran.uwm301.bchyr    = nv_batchyr         /* batch Year */      
        sic_bran.uwm301.bchno    = nv_batchno         /* bchno    */      
        sic_bran.uwm301.bchcnt   = nv_batcnt .        /* bchcnt     */  
    /*-----compul-----*/
    IF impdata_fil.compul = "y" THEN DO:
        sic_bran.uwm301.cert = "".
        IF LENGTH(impdata_fil.stk) = 11 THEN DO:    
            sic_bran.uwm301.drinam[9] = "STKNO:" + STRING(impdata_fil.stk,"99999999999"). 
        END.
        IF LENGTH(impdata_fil.stk) = 13  THEN DO:
            sic_bran.uwm301.drinam[9] = "STKNO:" + STRING(impdata_fil.stk,"9999999999999").
        END.  
        IF impdata_fil.stk = ""  THEN DO:
            sic_bran.uwm301.drinam[9] = "".
        END. 
        /*--create detaitem--*/
        FIND FIRST brStat.Detaitem USE-INDEX detaitem11 WHERE
            brStat.Detaitem.serailno   = impdata_fil.stk  AND 
            brstat.detaitem.yearReg    = nv_batchyr   AND
            brstat.detaitem.seqno      = STRING(nv_batchno)  AND
            brstat.detaitem.seqno2     = STRING(nv_batcnt)   NO-ERROR NO-WAIT.
        IF NOT AVAIL brstat.Detaitem THEN DO:   
            CREATE brstat.Detaitem.
            /*--STR Amparat C. A51-0253---*/
            ASSIGN                                                            
                brstat.detaitem.policy   = sic_bran.uwm301.policy                 
                brstat.Detaitem.rencnt   = sic_bran.uwm301.rencnt                 
                brstat.Detaitem.endcnt   = sic_bran.uwm301.endcnt                 
                brstat.Detaitem.riskno   = sic_bran.uwm301.riskno                 
                brstat.Detaitem.itemno   = sic_bran.uwm301.itemno                 
                brstat.detaitem.serailno = impdata_fil.stk
                brstat.detaitem.yearReg  = sic_bran.uwm301.bchyr
                brstat.detaitem.seqno    = STRING(sic_bran.uwm301.bchno)     
                brstat.detaitem.seqno2   = STRING(sic_bran.uwm301.bchcnt).  
            /*--END Amparat C. A51-0253---*/
        END.
    END.
    ELSE sic_bran.uwm301.drinam[9] = "".
    s_recid4  = RECID(sic_bran.uwm301).
    IF impdata_fil.redbook <> "" THEN DO:     /*กรณีที่มีการระบุ Code รถมา*/
        FIND FIRST stat.maktab_fil Use-index   maktab04   WHERE 
            stat.maktab_fil.sclass = impdata_fil.subclass    AND  /*kridtiya i. A53-0406*/
            stat.maktab_fil.modcod = impdata_fil.redbook     No-lock no-error no-wait.
        If  avail stat.maktab_fil  Then 
            ASSIGN impdata_fil.redbook =  stat.maktab_fil.modcod
            /*impdata_fil.model           =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes*/
            sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
            /*sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes*/
            impdata_fil.cargrp          =  stat.maktab_fil.prmpac
            sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac .
            /*sic_bran.uwm301.body    =  stat.maktab_fil.body*/
            /*sic_bran.uwm301.seats   =  stat.maktab_fil.seats
            sic_bran.uwm301.Tons    =  stat.maktab_fil.tons
            sic_bran.uwm301.engine  =  stat.maktab_fil.eng.*/
            /*sic_bran.uwm301.moddes  =  stat.maktab_fil.moddes.*//*comment by kridtiya i. A53-0100 01/04/2010*/
    END.
    IF impdata_fil.redbook = "" THEN  RUN proc_maktab.   /*kridtiya i. A53-0220  */
    FIND sic_bran.uwd132  USE-INDEX uwd13201 WHERE
         sic_bran.uwd132.policy = impdata_fil.policyno AND
         sic_bran.uwd132.rencnt = 0                AND
         sic_bran.uwd132.endcnt = 0                AND
         sic_bran.uwd132.riskgp = 0                AND
         sic_bran.uwd132.riskno = 1                AND
         sic_bran.uwd132.itemno = 1                AND
         sic_bran.uwd132.bchyr  = nv_batchyr       AND
         sic_bran.uwd132.bchno  = nv_batchno       AND
         sic_bran.uwd132.bchcnt = nv_batcnt   NO-ERROR NO-WAIT.
    IF NOT AVAILABLE sic_bran.uwd132 THEN DO:
      IF LOCKED sic_bran.uwd132 THEN DO:
        MESSAGE "พบกำลังใช้งาน Insured (UWD132)" impdata_fil.policyno
                "ไม่สามารถ Generage ข้อมูลได้".
        NEXT.
      END.
      CREATE sic_bran.uwd132.
    END.
    ASSIGN  sic_bran.uwd132.bencod  = "COMP"             /*Benefit Code*/
      sic_bran.uwd132.benvar  = ""                       /*Benefit Variable*/
      sic_bran.uwd132.rate    = 0                        /*Premium Rate %*/
      sic_bran.uwd132.gap_ae  = NO                       /*GAP A/E Code*/
      sic_bran.uwd132.gap_c   = deci(impdata_fil.premt72)    /*GAP, per Benefit per Item*/
      sic_bran.uwd132.dl1_c   = 0                        /*Disc./Load 1,p. Benefit p.Item*/
      sic_bran.uwd132.dl2_c   = 0                        /*Disc./Load 2,p. Benefit p.Item*/
      sic_bran.uwd132.dl3_c   = 0                        /*Disc./Load 3,p. Benefit p.Item*/
      sic_bran.uwd132.pd_aep  = "E"                      /*Premium Due A/E/P Code*/
      sic_bran.uwd132.prem_c  = deci(impdata_fil.premt72)    /*PD, per Benefit per Item*/
      sic_bran.uwd132.fptr    = 0                        /*Forward Pointer*/
      sic_bran.uwd132.bptr    = 0                        /*Backward Pointer*/
      sic_bran.uwd132.policy  = impdata_fil.policyno         /*Policy No. - uwm130*/
      sic_bran.uwd132.rencnt  = 0                        /*Renewal Count - uwm130*/
      sic_bran.uwd132.endcnt  = 0                        /*Endorsement Count - uwm130*/
      sic_bran.uwd132.riskgp  = 0                        /*Risk Group - uwm130*/
      sic_bran.uwd132.riskno  = 1                        /*Risk No. - uwm130*/
      sic_bran.uwd132.itemno  = 1                        /*Insured Item No. - uwm130*/
      sic_bran.uwd132.rateae  = NO                       /*Premium Rate % A/E Code*/
      sic_bran.uwm130.fptr03  = RECID(sic_bran.uwd132)   /*First uwd132 Cover & Premium*/
      sic_bran.uwm130.bptr03  = RECID(sic_bran.uwd132)   /*Last  uwd132 Cover & Premium*/
      sic_bran.uwd132.bchyr   = nv_batchyr  
      sic_bran.uwd132.bchno   = nv_batchno  
      sic_bran.uwd132.bchcnt  = nv_batcnt .*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_723 C-Win 
PROCEDURE proc_723 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*DEFINE INPUT        PARAMETER  s_recid1   AS   RECID     NO-UNDO.
DEFINE INPUT        PARAMETER  s_recid2   AS   RECID     NO-UNDO.
DEFINE INPUT        PARAMETER  s_recid3   AS   RECID     NO-UNDO.
DEFINE INPUT        PARAMETER  s_recid4   AS   RECID     NO-UNDO.
DEFINE INPUT-OUTPUT PARAMETER  nv_message AS   CHARACTER NO-UNDO.
nv_rec100 = s_recid1.
nv_rec120 = s_recid2.
nv_rec130 = s_recid3.
nv_rec301 = s_recid4.
nv_message = "".
nv_gap     = 0.
nv_prem    = 0.
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = nv_rec100 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = nv_rec120 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = nv_rec130 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = nv_rec301 NO-WAIT NO-ERROR.
IF sic_bran.uwm130.fptr03 = 0 OR sic_bran.uwm130.fptr03 = ? THEN DO:
    FIND sicsyac.xmm107 USE-INDEX xmm10701      WHERE
        sicsyac.xmm107.class  = impdata_fil.subclass   AND
        sicsyac.xmm107.tariff = impdata_fil.tariff
        NO-LOCK NO-ERROR NO-WAIT.
    IF AVAILABLE sicsyac.xmm107 THEN DO:
        FIND sicsyac.xmd107  WHERE RECID(sicsyac.xmd107) = sicsyac.xmm107.fptr
            NO-LOCK NO-ERROR NO-WAIT.
        IF AVAILABLE sicsyac.xmd107 THEN DO:
            CREATE sic_bran.uwd132.
            FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE
                sicsyac.xmm016.class = impdata_fil.subclass
                NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicsyac.xmm016 THEN 
                ASSIGN sic_bran.uwd132.gap_ae = NO
                sic_bran.uwd132.pd_aep = "E".
            ASSIGN sic_bran.uwd132.bencod = sicsyac.xmd107.bencod   sic_bran.uwd132.policy = impdata_fil.policy
                sic_bran.uwd132.rencnt = sic_bran.uwm130.rencnt  sic_bran.uwd132.endcnt = sic_bran.uwm130.endcnt
                sic_bran.uwd132.riskgp = sic_bran.uwm130.riskgp  sic_bran.uwd132.riskno = sic_bran.uwm130.riskno
                sic_bran.uwd132.itemno = sic_bran.uwm130.itemno
                sic_bran.uwd132.bptr   = 0
                sic_bran.uwd132.fptr   = 0          
                nvffptr     = xmd107.fptr
                s_130bp1    = RECID(sic_bran.uwd132)
                s_130fp1    = RECID(sic_bran.uwd132)
                n_rd132     = RECID(sic_bran.uwd132)
                sic_bran.uwd132.bchyr = nv_batchyr         /* batch Year */      
                sic_bran.uwd132.bchno = nv_batchno         /* bchno    */      
                sic_bran.uwd132.bchcnt  = nv_batcnt .        /* bchcnt     */ 
            FIND sicsyac.xmm105 USE-INDEX xmm10501      WHERE
                sicsyac.xmm105.tariff = impdata_fil.tariff  AND
                sicsyac.xmm105.bencod = sicsyac.xmd107.bencod
                NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicsyac.xmm105 THEN sic_bran.uwd132.benvar = sicsyac.xmm105.vardef.
            ELSE  MESSAGE "ไม่พบ Tariff  " impdata_fil.tariff   VIEW-AS ALERT-BOX.
            IF impdata_fil.tariff = "Z" OR impdata_fil.tariff = "X" THEN DO:  /* Malaysia */
                IF           impdata_fil.subclass      = "110" THEN nv_key_a = inte(impdata_fil.engcc).
                ELSE IF SUBSTRING(impdata_fil.subclass,1,3) = "120" THEN nv_key_a = inte(impdata_fil.seat).
                ELSE IF SUBSTRING(impdata_fil.subclass,1,3) = "130" THEN nv_key_a = inte(impdata_fil.engcc).
                ELSE IF SUBSTRING(impdata_fil.subclass,1,3) = "140" THEN nv_key_a = inte(impdata_fil.weight).
                nv_key_b = (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat) + 1.
                FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601  WHERE
                    sicsyac.xmm106.tariff  = impdata_fil.tariff   AND
                    sicsyac.xmm106.bencod  = uwd132.bencod    AND
                    sicsyac.xmm106.class   = impdata_fil.subclass AND
                    sicsyac.xmm106.covcod  = impdata_fil.covcod   AND
                    sicsyac.xmm106.key_a  >= nv_key_a         AND
                    sicsyac.xmm106.key_b  >= nv_key_b         AND
                    sicsyac.xmm106.effdat <= uwm100.comdat    NO-LOCK NO-ERROR NO-WAIT.
                IF AVAILABLE sicsyac.xmm106 THEN 
                    ASSIGN sic_bran.uwd132.gap_c  = sicsyac.xmm106.baseap
                    sic_bran.uwd132.prem_c = sicsyac.xmm106.baseap
                    nv_gap                 = nv_gap  + sic_bran.uwd132.gap_c
                    nv_prem                = nv_prem + sic_bran.uwd132.prem_c.
                ELSE  nv_message = "NOTFOUND".
            END.
            ELSE DO:
                FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601  WHERE
                    sicsyac.xmm106.tariff  = impdata_fil.tariff   AND
                    sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod   AND
                    sicsyac.xmm106.class   = impdata_fil.subclass AND
                    sicsyac.xmm106.covcod  = impdata_fil.covcod   AND
                    sicsyac.xmm106.key_a  >= 0                AND
                    sicsyac.xmm106.key_b  >= 0                AND
                    sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat
                    NO-LOCK NO-ERROR NO-WAIT.
                FIND LAST  sicsyac.xmm106 USE-INDEX xmm10601  WHERE
                    sicsyac.xmm106.tariff  = impdata_fil.tariff   AND
                    sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod   AND
                    sicsyac.xmm106.class   = impdata_fil.subclass AND
                    sicsyac.xmm106.covcod  = impdata_fil.covcod   AND
                    sicsyac.xmm106.key_a   = 0                AND
                    sicsyac.xmm106.key_b   = 0                AND
                    sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat
                    NO-LOCK NO-ERROR NO-WAIT.
                IF AVAILABLE sicsyac.xmm106 THEN DO:
                    sic_bran.uwd132.gap_c     = sicsyac.xmm106.baseap.
                    RUN proc_wgw72013   (INPUT RECID(sic_bran.uwm100), 
                                        RECID(sic_bran.uwd132),
                                        sic_bran.uwm301.tariff).
                    nv_gap        = nv_gap  + sic_bran.uwd132.gap_c.
                    nv_prem       = nv_prem + sic_bran.uwd132.prem_c.
                END.
            END.
            loop_def:
            REPEAT:
                IF nvffptr EQ 0 THEN LEAVE loop_def.
                FIND sicsyac.xmd107 WHERE RECID(sicsyac.xmd107) EQ nvffptr
                    NO-LOCK NO-ERROR NO-WAIT.
                nvffptr   = sicsyac.xmd107.fptr.
                CREATE sic_bran.uwd132.
                ASSIGN sic_bran.uwd132.bencod = sicsyac.xmd107.bencod    sic_bran.uwd132.policy = impdata_fil.policy
                    sic_bran.uwd132.rencnt = sic_bran.uwm130.rencnt   sic_bran.uwd132.endcnt = sic_bran.uwm130.endcnt
                    sic_bran.uwd132.riskgp = sic_bran.uwm130.riskgp   sic_bran.uwd132.riskno = sic_bran.uwm130.riskno
                    sic_bran.uwd132.itemno = sic_bran.uwm130.itemno
                    sic_bran.uwd132.fptr   = 0
                    sic_bran.uwd132.bptr   = n_rd132
                    sic_bran.uwd132.bchyr = nv_batchyr      /* batch Year */      
                    sic_bran.uwd132.bchno = nv_batchno      /* bchno    */      
                    sic_bran.uwd132.bchcnt  = nv_batcnt     /* bchcnt     */      
                    n_rd132                 = RECID(sic_bran.uwd132).
                FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE
                    sicsyac.xmm016.class = impdata_fil.subclass
                    NO-LOCK NO-ERROR.
                IF AVAIL sicsyac.xmm016 THEN 
                    ASSIGN sic_bran.uwd132.gap_ae = NO
                    sic_bran.uwd132.pd_aep = "E".
                FIND sicsyac.xmm105 USE-INDEX xmm10501      WHERE
                    sicsyac.xmm105.tariff = impdata_fil.tariff  AND
                    sicsyac.xmm105.bencod = sicsyac.xmd107.bencod
                    NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL sicsyac.xmm105 THEN sic_bran.uwd132.benvar = sicsyac.xmm105.vardef.
                ELSE   MESSAGE "ไม่พบ Tariff นี้ในระบบ กรุณาใส่ Tariff ใหม่" 
                    "Tariff" impdata_fil.tariff "Bencod"  xmd107.bencod VIEW-AS ALERT-BOX.
                IF impdata_fil.tariff = "Z" OR impdata_fil.tariff = "X" THEN DO:
                    IF           impdata_fil.subclass      = "110" THEN nv_key_a = inte(impdata_fil.engcc).
                    ELSE IF SUBSTRING(impdata_fil.subclass,1,3) = "120" THEN nv_key_a = inte(impdata_fil.seat).
                    ELSE IF SUBSTRING(impdata_fil.subclass,1,3) = "130" THEN nv_key_a = inte(impdata_fil.engcc).
                    ELSE IF SUBSTRING(impdata_fil.subclass,1,3) = "140" THEN nv_key_a = inte(impdata_fil.weight).
                    nv_key_b = (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat) + 1.
                    FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601        WHERE
                        sicsyac.xmm106.tariff  = impdata_fil.tariff   AND
                        sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod   AND
                        sicsyac.xmm106.class   = impdata_fil.subclass    AND
                        sicsyac.xmm106.covcod  = impdata_fil.covcod   AND
                        sicsyac.xmm106.key_a  >= nv_key_a        AND
                        sicsyac.xmm106.key_b  >= nv_key_b        AND
                        sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat
                        NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAILABLE sicsyac.xmm106 THEN 
                        ASSIGN
                            sic_bran.uwd132.gap_c  = sicsyac.xmm106.baseap
                            sic_bran.uwd132.prem_c = sicsyac.xmm106.baseap
                            nv_gap                 = nv_gap  + sic_bran.uwd132.gap_c
                            nv_prem                = nv_prem + sic_bran.uwd132.prem_c.
                END.
                ELSE DO:
                    FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601                 WHERE
                        sicsyac.xmm106.tariff  = impdata_fil.tariff           AND
                        sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod   AND
                        sicsyac.xmm106.class   = impdata_fil.subclass        AND
                        sicsyac.xmm106.covcod  = impdata_fil.covcod           AND
                        sicsyac.xmm106.key_a  >= 0                        AND
                        sicsyac.xmm106.key_b  >= 0                        AND
                        sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat
                        NO-LOCK NO-ERROR NO-WAIT.
                    FIND LAST  sicsyac.xmm106 USE-INDEX xmm10601                  WHERE
                        sicsyac.xmm106.tariff  = impdata_fil.tariff            AND
                        sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod    AND
                        sicsyac.xmm106.class   = impdata_fil.subclass          AND
                        sicsyac.xmm106.covcod  = impdata_fil.covcod            AND
                        sicsyac.xmm106.key_a   = 0                         AND
                        sicsyac.xmm106.key_b   = 0                         AND
                        sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat
                        NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAILABLE xmm106 THEN DO:
                        sic_bran.uwd132.gap_c     = sicsyac.xmm106.baseap.
                        RUN proc_wgw72013   (INPUT RECID(sic_bran.uwm100), 
                                            RECID(sic_bran.uwd132),
                                            sic_bran.uwm301.tariff).
                        nv_gap        = nv_gap  + sic_bran.uwd132.gap_c.
                        nv_prem       = nv_prem + sic_bran.uwd132.prem_c.
                    END.
                END.
                FIND sic_bran.uwd132 WHERE RECID(sic_bran.uwd132) EQ s_130bp1 NO-WAIT NO-ERROR.
                sic_bran.uwd132.fptr   = n_rd132.
                FIND sic_bran.uwd132 WHERE RECID(sic_bran.uwd132) EQ n_rd132 NO-WAIT NO-ERROR.
                s_130bp1      = RECID(sic_bran.uwd132).
                NEXT loop_def.
            END.
        END.
    END.
    ELSE DO:   
        ASSIGN s_130fp1 = 0
        s_130bp1 = 0.
        MESSAGE "ไม่พบ Class " impdata_fil.subclass " ใน Tariff  " impdata_fil.tariff  skip
                        "กรุณาใส่ Class หรือ Tariff ใหม่อีกครั้ง" VIEW-AS ALERT-BOX.
    END.
    ASSIGN sic_bran.uwm130.fptr03 = s_130fp1
        sic_bran.uwm130.bptr03 = s_130bp1.
END.
ELSE DO:                              
    s_130fp1 = sic_bran.uwm130.fptr03.
    DO WHILE s_130fp1 <> ? AND s_130fp1 <> 0:
        FIND sic_bran.uwd132 WHERE RECID(sic_bran.uwd132) = s_130fp1 NO-ERROR NO-WAIT.
        IF AVAILABLE sic_bran.uwd132 THEN DO:
            s_130fp1 = sic_bran.uwd132.fptr.
            IF impdata_fil.tariff = "Z" OR impdata_fil.tariff = "X" THEN DO:
                IF           impdata_fil.subclass      = "110" THEN nv_key_a = inte(impdata_fil.engcc).
                ELSE IF SUBSTRING(impdata_fil.subclass,1,3) = "120" THEN nv_key_a = inte(impdata_fil.seat).
                ELSE IF SUBSTRING(impdata_fil.subclass,1,3) = "130" THEN nv_key_a = inte(impdata_fil.engcc).
                ELSE IF SUBSTRING(impdata_fil.subclass,1,3) = "140" THEN nv_key_a = inte(impdata_fil.weight).
                nv_key_b = (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat) + 1.
                FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601                WHERE
                    sicsyac.xmm106.tariff  = impdata_fil.tariff          AND
                    sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod  AND
                    sicsyac.xmm106.class   = impdata_fil.subclass        AND
                    sicsyac.xmm106.covcod  = impdata_fil.covcod          AND
                    sicsyac.xmm106.key_a  >= nv_key_a                AND 
                    sicsyac.xmm106.key_b  >= nv_key_b                AND 
                    sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat
                    NO-LOCK NO-ERROR NO-WAIT.
                IF AVAILABLE xmm106 THEN 
                    ASSIGN sic_bran.uwd132.gap_c  = sicsyac.xmm106.baseap
                    sic_bran.uwd132.prem_c = sicsyac.xmm106.baseap
                    nv_gap                 = nv_gap  + sic_bran.uwd132.gap_c
                    nv_prem                = nv_prem + sic_bran.uwd132.prem_c.
                ELSE  nv_message = "NOTFOUND".
            END.
            ELSE DO:
                FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601            WHERE
                    sicsyac.xmm106.tariff  = impdata_fil.tariff      AND 
                    sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod       AND 
                    sicsyac.xmm106.class   = impdata_fil.subclass    AND 
                    sicsyac.xmm106.covcod  = impdata_fil.covcod      AND 
                    sicsyac.xmm106.key_a  >= 0                   AND 
                    sicsyac.xmm106.key_b  >= 0                   AND 
                    sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat
                    NO-LOCK NO-ERROR NO-WAIT.
                FIND LAST  sicsyac.xmm106 USE-INDEX xmm10601        WHERE
                    sicsyac.xmm106.tariff  = impdata_fil.tariff   AND
                    sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod   AND
                    sicsyac.xmm106.class   = impdata_fil.subclass    AND
                    sicsyac.xmm106.covcod  = impdata_fil.covcod   AND
                    sicsyac.xmm106.key_a   = 0               AND
                    sicsyac.xmm106.key_b   = 0               AND
                    sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat
                    NO-LOCK NO-ERROR NO-WAIT.
                IF AVAILABLE sicsyac.xmm106 THEN DO:
                    sic_bran.uwd132.gap_c     = sicsyac.xmm106.baseap.         
                    RUN proc_wgw72013   (INPUT RECID(sic_bran.uwm100),         
                                        RECID(sic_bran.uwd132),                
                                        sic_bran.uwm301.tariff).
                    nv_gap        = nv_gap  + sic_bran.uwd132.gap_c.
                    nv_prem       = nv_prem + sic_bran.uwd132.prem_c.
                END.
            END.
        END.
    END.
END.

IF deci(impdata_fil.dstf72) <> 0  THEN DO:
    nv_stf_per = 0.
    nv_stf_per = DECI(impdata_fil.dstf72) .
    nv_prem = 0.
    FIND FIRST sic_bran.uwd132 USE-INDEX uwd13201 WHERE
        sic_bran.uwd132.policy = uwm100.policy  AND
        sic_bran.uwd132.rencnt = uwm100.rencnt  AND 
        sic_bran.uwd132.endcnt = uwm100.endcnt  AND
        SUBSTRING(sic_bran.uwd132.bencod,1,3) = "COM"   AND
        sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno  AND
        sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno  AND
        sic_bran.uwd132.bchyr   = sic_bran.uwm130.bchyr   AND
        sic_bran.uwd132.bchno   = sic_bran.uwm130.bchno   AND
        sic_bran.uwd132.bchcnt  = sic_bran.uwm130.bchcnt  NO-LOCK NO-ERROR.
    IF AVAIL sic_bran.uwd132 THEN nv_prem = sic_bran.uwd132.prem_c.
    ASSIGN
        nv_stf_per    = - ROUND(nv_prem * nv_stf_per / 100,2)
        nv_stfvar     = ""
        nv_stfvar1    = ""
        nv_stfvar2    = "".
    
    IF nv_stf_per   <> 0  THEN DO:
        ASSIGN 
            nv_stfvar1   = "     Discount Staff = "            
            nv_stfvar2   =  STRING(impdata_fil.dstf72)              
            SUBSTRING(nv_stfvar,1,30)    = nv_stfvar1       
            SUBSTRING(nv_stfvar,31,30)   = nv_stfvar2.  
    END.
    RUN proc_dstf72.
END.
RUN proc_7231.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_7231 C-Win 
PROCEDURE proc_7231 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*ASSIGN nv_stm_per = 0.4
       nv_tax_per = 7.0.
FIND sicsyac.xmm020 USE-INDEX xmm02001     WHERE
    sicsyac.xmm020.branch = sic_bran.uwm100.branch AND
    sicsyac.xmm020.dir_ri = sic_bran.uwm100.dir_ri
    NO-LOCK NO-ERROR.
IF AVAIL sicsyac.xmm020 THEN 
    ASSIGN nv_stm_per             = sicsyac.xmm020.rvstam
           nv_tax_per             = sicsyac.xmm020.rvtax
           sic_bran.uwm100.gstrat = sicsyac.xmm020.rvtax.
ELSE sic_bran.uwm100.gstrat = nv_tax_per.
     ASSIGN  nv_gap2  = 0
         nv_prem2 = 0
         nv_rstp  = 0
         nv_rtax  = 0
         nv_com1_per = 0
         nv_com1_prm = 0.
     FIND sicsyac.xmm031 USE-INDEX xmm03101 WHERE sicsyac.xmm031.poltyp = sic_bran.uwm100.poltyp
         NO-LOCK NO-ERROR NO-WAIT.
     IF AVAILABLE sicsyac.xmm031 THEN nv_com1_per = sicsyac.xmm031.comm1.
     FOR EACH sic_bran.uwm120 USE-INDEX uwm12001 WHERE
         sic_bran.uwm120.policy = impdata_fil.policy         AND
         sic_bran.uwm120.rencnt = sic_bran.uwm100.rencnt AND
         sic_bran.uwm120.endcnt = sic_bran.uwm100.endcnt AND
         sic_bran.uwm120.riskgp = s_riskgp               AND
         sic_bran.uwm120.riskno = s_riskno               AND
         sic_bran.uwm120.bchyr  = nv_batchyr             AND 
         sic_bran.uwm120.bchno  = nv_batchno             AND 
         sic_bran.uwm120.bchcnt = nv_batcnt              :
         ASSIGN nv_gap  = 0
         nv_prem = 0.
         FOR EACH sic_bran.uwm130 USE-INDEX uwm13001 WHERE
             sic_bran.uwm130.policy = impdata_fil.policy AND
             sic_bran.uwm130.rencnt = sic_bran.uwm100.rencnt AND
             sic_bran.uwm130.endcnt = sic_bran.uwm100.endcnt AND
             sic_bran.uwm130.riskgp = sic_bran.uwm120.riskgp AND
             sic_bran.uwm130.riskno = sic_bran.uwm120.riskno AND
             sic_bran.uwm130.itemno = s_itemno               AND 
             sic_bran.uwm130.bchyr  = nv_batchyr             AND 
             sic_bran.uwm130.bchno  = nv_batchno             AND 
             sic_bran.uwm130.bchcnt  = nv_batcnt             NO-LOCK:
             nv_fptr = sic_bran.uwm130.fptr03.
             DO WHILE nv_fptr <> 0 AND nv_fptr <> ? :
                 FIND sic_bran.uwd132 WHERE RECID(sic_bran.uwd132) = nv_fptr
                     NO-LOCK NO-ERROR NO-WAIT.
                 IF NOT AVAILABLE sic_bran.uwd132 THEN LEAVE.
                 ASSIGN 
                 nv_fptr = sic_bran.uwd132.fptr
                 nv_gap  = nv_gap  + sic_bran.uwd132.gap_c
                 nv_prem = nv_prem + sic_bran.uwd132.prem_c.
             END.
         END.
         ASSIGN 
         sic_bran.uwm120.gap_r  =  nv_gap
         sic_bran.uwm120.prem_r =  nv_prem
         sic_bran.uwm120.rstp_r =  TRUNCATE(sic_bran.uwm120.prem_r * nv_stm_per / 100, 0) +
                                  (IF  TRUNCATE(sic_bran.uwm120.prem_r * nv_stm_per / 100, 2) -
                                  TRUNCATE(sic_bran.uwm120.prem_r * nv_stm_per / 100, 0) > 0  THEN 1 ELSE 0)
         sic_bran.uwm120.rtax_r = ROUND((sic_bran.uwm120.prem_r + sic_bran.uwm120.rstp_r)  * nv_tax_per  / 100 ,2)
         nv_gap2                = nv_gap2  + nv_gap
         nv_prem2               = nv_prem2 + nv_prem
         nv_rstp                = nv_rstp  + sic_bran.uwm120.rstp_r
         nv_rtax                = nv_rtax  + sic_bran.uwm120.rtax_r.
         IF sic_bran.uwm120.com1ae = NO THEN
             nv_com1_per            = sic_bran.uwm120.com1p.
         IF nv_com1_per <> 0 THEN 
             ASSIGN sic_bran.uwm120.com1ae =  NO
             sic_bran.uwm120.com1p  =  nv_com1_per
             sic_bran.uwm120.com1_r =  (sic_bran.uwm120.prem_r * sic_bran.uwm120.com1p / 100) * 1-
             nv_com1_prm = nv_com1_prm + sic_bran.uwm120.com1_r.
          ELSE DO:
              IF nv_com1_per   = 0  AND sic_bran.uwm120.com1ae = NO THEN 
                  ASSIGN
                      sic_bran.uwm120.com1p  =  0
                      sic_bran.uwm120.com1_r =  0
                      sic_bran.uwm120.com1_r =  0
                      nv_com1_prm            =  0.
          END.
     END.
     FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = nv_rec130 NO-WAIT NO-ERROR.
     FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = nv_rec120 NO-WAIT NO-ERROR.
     ASSIGN
         sic_bran.uwm100.gap_p  =  nv_gap2
         sic_bran.uwm100.prem_t =  nv_prem2
         sic_bran.uwm100.rstp_t =  nv_rstp
         sic_bran.uwm100.rtax_t =  nv_rtax
         sic_bran.uwm100.com1_t =  nv_com1_prm.
     RUN proc_chktest4.    */ 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_address C-Win 
PROCEDURE proc_address :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
def var n_address  as char format "x(50)".
def var n_build    as char format "x(50)".
def var n_tambon   as char format "x(50)".
def var n_amper    as char format "x(50)".
def var n_country  as char format "x(50)".
def var n_post     as char format "x(50)".
DEF VAR n_length   AS INT.
            
ASSIGN  n_address  = ""
        n_address  = trim(trim(impdata_fil.addr) + " " + trim(impdata_fil.tambon) + " " +
                     trim(impdata_fil.amper) + " " + TRIM(impdata_fil.country) + " " + TRIM(impdata_fil.post))
        n_build    = "" 
        n_tambon   = ""          
        n_amper    = ""          
        n_country  = ""          
        n_post     = "".

       IF n_address <> ""  THEN DO:
            IF INDEX(n_address,"จ." ) <> 0 THEN DO: 
                ASSIGN 
                n_country  =  TRIM(SUBSTR(n_address,INDEX(n_address,"จ."),LENGTH(n_address)))
                n_length   =  LENGTH(n_country)
                n_address  =  trim(SUBSTR(n_address,1,LENGTH(n_address) - n_length))
            
                n_country  =  IF index(n_country,"จ. ") <> 0 THEN  trim(REPLACE(n_country,"จ. ","จ.")) ELSE TRIM(n_country) 
                n_length   =  LENGTH(n_country)
                n_post     =  IF INDEX(n_country," ")  <> 0 THEN SUBSTR(n_country,INDEX(n_country," ") + 1,n_length) ELSE ""
                n_country  =  trim(SUBSTR(n_country,1,n_length - LENGTH(n_post))).
            END.
            ELSE IF INDEX(n_address,"จังหวัด" ) <> 0 THEN DO: 
                ASSIGN 
                n_country  =  trim(SUBSTR(n_address,INDEX(n_address,"จังหวัด"),LENGTH(n_address)))
                n_length   =  LENGTH(n_country)
                n_address  =  trim(SUBSTR(n_address,1,LENGTH(n_address) - n_length)) 
                n_post     =  IF INDEX(n_country," ") <> 0 THEN SUBSTR(n_country,INDEX(n_country," ") + 1,n_length)  ELSE ""
                n_country  =  trim(SUBSTR(n_country,1,n_length - LENGTH(n_post))).
            END.
            ELSE IF INDEX(n_address,"กทม" ) <> 0 THEN DO: 
                ASSIGN 
                n_country  =  trim(SUBSTR(n_address,INDEX(n_address,"กทม"),LENGTH(n_address)))
                n_length   =  LENGTH(n_country)
                n_address  =  trim(SUBSTR(n_address,1,LENGTH(n_address) - n_length))
                n_post     =  IF INDEX(n_country," ") <> 0 THEN SUBSTR(n_country,INDEX(n_country," ") + 1,n_length) ELSE ""
                n_country  =  trim(SUBSTR(n_country,1,n_length - LENGTH(n_post))).
            END.
            ELSE IF INDEX(n_address,"กรุงเทพ" ) <> 0 THEN DO: 
                ASSIGN 
                n_country  =  trim(SUBSTR(n_address,INDEX(n_address,"กรุงเทพ"),LENGTH(n_address)))
                n_length   =  LENGTH(n_country)
                n_address  =  trim(SUBSTR(n_address,1,LENGTH(n_address) - n_length)) 
                n_post     =  IF INDEX(n_country," ") <> 0 THEN SUBSTR(n_country,INDEX(n_country," ") + 1,n_length) ELSE ""
                n_country  =  trim(SUBSTR(n_country,1,n_length - LENGTH(n_post))).
            END.
            ELSE DO: 
                ASSIGN 
                n_post     =  trim(SUBSTR(n_address,R-INDEX(n_address," ")))
                n_length   =  LENGTH(n_post)
                n_address  =  trim(SUBSTR(n_address,1,LENGTH(n_address) - n_length))
                n_country  =  trim(SUBSTR(n_address,R-INDEX(n_address," ")))
                n_length   =  LENGTH(n_country)
                n_address  =  trim(SUBSTR(n_address,1,LENGTH(n_address) - n_length)).
            END.
            
            IF INDEX(n_address,"อ." ) <> 0 THEN DO: 
                ASSIGN 
                n_amper    =  trim(SUBSTR(n_address,INDEX(n_address,"อ."),LENGTH(n_address)))
                n_length   =  LENGTH(n_amper)
                n_address  =  trim(SUBSTR(n_address,1,LENGTH(n_address) - n_length)).
            END.
            ELSE IF INDEX(n_address,"อำเภอ" ) <> 0 THEN DO: 
                ASSIGN 
                n_amper    =  trim(SUBSTR(n_address,INDEX(n_address,"อำเภอ"),LENGTH(n_address)))
                n_length   =  LENGTH(n_amper)
                n_address  =  trim(SUBSTR(n_address,1,LENGTH(n_address) - n_length)).
            END.
            ELSE IF INDEX(n_address,"เขต" ) <> 0 THEN DO: 
                ASSIGN 
                n_amper    =  trim(SUBSTR(n_address,INDEX(n_address,"เขต"),LENGTH(n_address)))
                n_length   =  LENGTH(n_amper)
                n_address  =  trim(SUBSTR(n_address,1,LENGTH(n_address) - n_length)).
            END.
            IF INDEX(n_address,"ต." ) <> 0 THEN DO: 
                ASSIGN 
                n_tambon   =  trim(SUBSTR(n_address,INDEX(n_address,"ต."),LENGTH(n_address)))
                n_length   =  LENGTH(n_tambon)
                n_address  =  trim(SUBSTR(n_address,1,LENGTH(n_address) - n_length)).
            END.
            ELSE IF INDEX(n_address,"ตำบล" ) <> 0 THEN DO: 
                ASSIGN 
                n_tambon   =  trim(SUBSTR(n_address,INDEX(n_address,"ตำบล"),LENGTH(n_address)))
                n_length   =  LENGTH(n_tambon)
                n_address  =  trim(SUBSTR(n_address,1,LENGTH(n_address) - n_length)).
            END.
            ELSE IF INDEX(n_address,"แขวง" ) <> 0 THEN DO: 
                ASSIGN 
                n_tambon   =  trim(SUBSTR(n_address,INDEX(n_address,"แขวง"),LENGTH(n_address)))
                n_length   =  LENGTH(n_tambon)
                n_address  =  trim(SUBSTR(n_address,1,LENGTH(n_address) - n_length)).
            END.
            ELSE IF INDEX(n_address,"ขว." ) <> 0 THEN DO: 
                ASSIGN 
                n_tambon   =  trim(SUBSTR(n_address,INDEX(n_address,"ขว."),LENGTH(n_address)))
                n_length   =  LENGTH(n_tambon)
                n_address  =  trim(SUBSTR(n_address,1,LENGTH(n_address) - n_length)).
                
            END.
       
            ASSIGN  n_build  = trim(n_address).
            ASSIGN  impdata_fil.addr    = TRIM(n_build)  
                    impdata_fil.tambon  = trim(n_tambon) 
                    impdata_fil.amper   = trim(n_amper) 
                    impdata_fil.country = trim(n_country) 
                    impdata_fil.post    = TRIM(n_post) .
       END.
/* comment by : A64-0309
IF LENGTH(impdata_fil.addr) > 35 THEN DO:
    loop_add01:
    DO WHILE LENGTH(impdata_fil.addr) > 35 :
        IF R-INDEX(impdata_fil.addr," ") <> 0 THEN DO:
            ASSIGN 
                impdata_fil.tambon  = trim(SUBSTR(impdata_fil.addr,r-INDEX(impdata_fil.addr," "))) + " " + impdata_fil.tambon
                impdata_fil.addr    = trim(SUBSTR(impdata_fil.addr,1,r-INDEX(impdata_fil.addr," "))).
        END.
        ELSE LEAVE loop_add01.
    END.
    /*impdata_fil.tambon*/
    IF LENGTH(impdata_fil.tambon) > 35 THEN DO:
        loop_add02:
        DO WHILE LENGTH(impdata_fil.tambon) > 35 :
            IF R-INDEX(impdata_fil.tambon," ") <> 0 THEN DO:
                ASSIGN 
                    impdata_fil.amper    = trim(SUBSTR(impdata_fil.tambon,r-INDEX(impdata_fil.tambon," "))) + " " + impdata_fil.amper
                    impdata_fil.tambon   = trim(SUBSTR(impdata_fil.tambon,1,r-INDEX(impdata_fil.tambon," "))).
            END.
            ELSE LEAVE loop_add02.
        END.
    END.
    /*impdata_fil.amper*/
    IF LENGTH(impdata_fil.amper) > 35 THEN DO:
        loop_add03:
        DO WHILE LENGTH(impdata_fil.amper) > 35 :
            IF R-INDEX(impdata_fil.amper," ") <> 0 THEN DO:
                ASSIGN 
                    impdata_fil.country = trim(SUBSTR(impdata_fil.amper,r-INDEX(impdata_fil.amper," "))) + " " + impdata_fil.country
                    impdata_fil.amper   = trim(SUBSTR(impdata_fil.amper,1,r-INDEX(impdata_fil.amper," "))).
            END.
            ELSE LEAVE loop_add03.
        END.
    END.
END.
ELSE DO:
    /*impdata_fil.tambon*/
    IF LENGTH(impdata_fil.tambon + " " + impdata_fil.amper ) <= 35 THEN  
        ASSIGN 
        impdata_fil.tambon   = impdata_fil.tambon + " " + impdata_fil.amper 
        impdata_fil.amper    = impdata_fil.country
        impdata_fil.country  = "" .
    ELSE IF LENGTH(impdata_fil.amper + " " + impdata_fil.country) <= 35 THEN  
        ASSIGN 
        impdata_fil.amper    = impdata_fil.amper + " " + impdata_fil.country
        impdata_fil.country  = "" .
END.
..end A64-0309..*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_adduwd132 C-Win 
PROCEDURE proc_adduwd132 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*DEF VAR nv_campaign AS CHAR FORMAT "x(20)" INIT "" . /*A62-0493*/

DEF BUFFER wf_uwd132 FOR sic_bran.uwd132.
DO:
    FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
    FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
    
    ASSIGN nv_bptr = 0      nv_gapprm   = 0     nv_pdprm    = 0 
           /* A64-0309 */ 
           nv_411t = 0      nv_412t = 0
           nv_42t  = 0      nv_43t  = 0.
           /* end : A64-0309 */ 
                         
     FOR EACH stat.pmuwd132 USE-INDEX pmuwd13201 WHERE 
              stat.pmuwd132.campcd        = trim(impdata_fil.packcod)   AND 
              /*TRIM(stat.pmuwd132.policy)  = TRIM(nv_polmaster)  NO-LOCK.*/      /*A64-0044*/
              TRIM(stat.pmuwd132.policy)  = TRIM(impdata_fil.polmaster)  NO-LOCK.    /*A64-0044*/
        FIND sic_bran.uwd132  USE-INDEX uwd13201 WHERE
             sic_bran.uwd132.policy  = sic_bran.uwm100.policy AND
             sic_bran.uwd132.rencnt  = sic_bran.uwm100.rencnt AND
             sic_bran.uwd132.endcnt  = sic_bran.uwm100.endcnt AND
             sic_bran.uwd132.riskgp  = sic_bran.uwm130.riskgp AND
             sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno AND
             sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno AND
             sic_bran.uwd132.bchyr   = nv_batchyr             AND
             sic_bran.uwd132.bchno   = nv_batchno             AND
             sic_bran.uwd132.bchcnt  = nv_batcnt              AND 
             sic_bran.uwd132.bencod  = stat.pmuwd132.bencod      NO-ERROR NO-WAIT.
   
            IF NOT AVAILABLE sic_bran.uwd132 THEN DO:
                CREATE sic_bran.uwd132.

               ASSIGN fi_process = "Create data to sic_bran.uwd132  ..." + impdata_fil.policy .
               DISP fi_process WITH FRAM fr_main. 
               ASSIGN
                  sic_bran.uwd132.bencod  =  stat.pmuwd132.bencod 
                  sic_bran.uwd132.benvar  =  stat.pmuwd132.benvar 
                  sic_bran.uwd132.rate    =  stat.pmuwd132.rate                     
                  sic_bran.uwd132.gap_ae  =  NO /*stat.pmuwd132.gap_ae --A64-0355--*/                
                  sic_bran.uwd132.gap_c   =  stat.pmuwd132.gap_c                    
                  sic_bran.uwd132.dl1_c   =  stat.pmuwd132.dl1_c                    
                  sic_bran.uwd132.dl2_c   =  stat.pmuwd132.dl2_c                    
                  sic_bran.uwd132.dl3_c   =  stat.pmuwd132.dl3_c                    
                  sic_bran.uwd132.pd_aep  =  "E" /*stat.pmuwd132.pd_aep --A64-0355--*/                      
                  sic_bran.uwd132.prem_c  =  stat.pmuwd132.prem_c                   
                  sic_bran.uwd132.fptr    =  0                   
                  sic_bran.uwd132.bptr    =  nv_bptr                   
                  sic_bran.uwd132.policy  =  sic_bran.uwm100.policy 
                  sic_bran.uwd132.rencnt  =  sic_bran.uwm100.rencnt                    
                  sic_bran.uwd132.endcnt  =  sic_bran.uwm100.endcnt                    
                  sic_bran.uwd132.riskgp  =  sic_bran.uwm130.riskgp                 
                  sic_bran.uwd132.riskno  =  sic_bran.uwm130.riskno                 
                  sic_bran.uwd132.itemno  =  sic_bran.uwm130.itemno                 
                  sic_bran.uwd132.rateae  =  stat.pmuwd132.rateae                  
                  sic_bran.uwd132.bchyr   =  nv_batchyr                   
                  sic_bran.uwd132.bchno   =  nv_batchno 
                  sic_bran.uwd132.bchcnt  =  nv_batcnt.
               
                  nv_gapprm = nv_gapprm + stat.pmuwd132.gap_c .
                  nv_pdprm  = nv_pdprm + stat.pmuwd132.prem_C.

               IF sic_bran.uwd132.bencod = "SI"   THEN ASSIGN sic_bran.uwd132.benvar = nv_sivar .
               IF sic_bran.uwd132.bencod = "dspc" THEN ASSIGN nv_dss_per  = DECI(SUBSTRING(sic_bran.uwd132.benvar,31,30)).
               IF sic_bran.uwd132.bencod = "NCB"  THEN ASSIGN nv_ncbper   = DECI(SUBSTRING(sic_bran.uwd132.benvar,31,30)).

               IF sic_bran.uwd132.bencod = "BI1"  THEN ASSIGN impdata_fil.comper   = int(SUBSTRING(sic_bran.uwd132.benvar,31,30)) .
               IF sic_bran.uwd132.bencod = "BI2"  THEN ASSIGN impdata_fil.comacc   = int(SUBSTRING(sic_bran.uwd132.benvar,31,30)) .
               IF sic_bran.uwd132.bencod = "PD"   THEN ASSIGN impdata_fil.deductpd = int(SUBSTRING(sic_bran.uwd132.benvar,31,30)) .
               if sic_bran.uwm130.uom1_v <> int(impdata_fil.comper)   then assign sic_bran.uwm130.uom1_v = int(impdata_fil.comper)   .
               if sic_bran.uwm130.uom2_v <> int(impdata_fil.comacc)   then assign sic_bran.uwm130.uom2_v = int(impdata_fil.comacc)   .
               if sic_bran.uwm130.uom5_v <> int(impdata_fil.deductpd) then assign sic_bran.uwm130.uom5_v = int(impdata_fil.deductpd) .

               /* add by : Ranu I. A64-0309 05/08/2021 */
               IF sic_bran.uwd132.bencod = "411"  THEN ASSIGN  nv_411t = stat.pmuwd132.prem_C  impdata_fil.NO_411 = int(SUBSTRING(sic_bran.uwd132.benvar,31,30)).  
               IF sic_bran.uwd132.bencod = "412"  THEN ASSIGN  nv_412t = stat.pmuwd132.prem_C  impdata_fil.NO_412 = int(SUBSTRING(sic_bran.uwd132.benvar,31,30)).  
               IF sic_bran.uwd132.bencod = "42"   THEN ASSIGN  nv_42t  = stat.pmuwd132.prem_C  impdata_fil.NO_42  = int(SUBSTRING(sic_bran.uwd132.benvar,31,30)).  
               IF sic_bran.uwd132.bencod = "43"   THEN ASSIGN  nv_43t  = stat.pmuwd132.prem_C  impdata_fil.NO_43  = int(SUBSTRING(sic_bran.uwd132.benvar,31,30)).   
               
               IF sic_bran.uwd132.bencod = "FLET" AND TRIM(stat.pmuwd132.benvar) = "" THEN DO:
                   ASSIGN sic_bran.uwd132.benvar = "     Fleet Discount %  =      10 " .
               END.
               /* end A64-0309 */

               /* A64-0257 */
               IF SUBSTR(sic_bran.uwd132.bencod,1,3) = "GRP" AND impdata_fil.cargrp <> "" THEN DO:
                   ASSIGN   sic_bran.uwd132.bencod = nv_grpcod
                            sic_bran.uwd132.benvar = nv_grpvar .
               END.
               /* end A64-0257*/
              
               If nv_ncbper  <> 0 Then do:
                   Find LAST sicsyac.xmm104 Use-index xmm10401 Where
                       sicsyac.xmm104.tariff = nv_tariff           AND
                       sicsyac.xmm104.class  = nv_class            AND 
                       sicsyac.xmm104.covcod = nv_covcod           AND 
                       sicsyac.xmm104.ncbper   = INTE(nv_ncbper) No-lock no-error no-wait.
                   IF not avail  sicsyac.xmm104  Then do:
                       Message " This NCB Step not on NCB Rates file xmm104. " View-as alert-box.
                       ASSIGN impdata_fil.pass    = "N"
                           impdata_fil.comment = impdata_fil.comment + "| This NCB Step not on NCB Rates file xmm104. ".
                   END.
                   ELSE ASSIGN nv_ncbper = xmm104.ncbper   
                               nv_ncbyrs = xmm104.ncbyrs.
               END.
               Else do:  
                   ASSIGN nv_ncbyrs =   0
                       nv_ncbper    =   0
                       nv_ncb       =   0.
               END.
               ASSIGN   
                sic_bran.uwm301.ncbper   = nv_ncbper
                sic_bran.uwm301.ncbyrs   = nv_ncbyrs .

               IF nv_bptr <> 0 THEN DO:
                   FIND wf_uwd132 WHERE RECID(wf_uwd132) = nv_bptr.
                       wf_uwd132.fptr = RECID(sic_bran.uwd132).
               END.
               IF nv_bptr = 0 THEN sic_bran.uwm130.fptr03  =  RECID(sic_bran.uwd132).
               nv_bptr = RECID(sic_bran.uwd132).

            END.
        END.
    RUN proc_chkRY. /*A64-0309*/
    sic_bran.uwm130.bptr03  =  nv_bptr. 
    RELEASE stat.pmuwd132.
    RELEASE sic_bran.uwd132.
END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_adduwd132Plus C-Win 
PROCEDURE proc_adduwd132Plus :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*DEF BUFFER wf_uwd132 FOR sic_bran.uwd132.
DO:
    FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
    FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
   
    ASSIGN nv_bptr = 0      nv_gapprm   = 0     nv_pdprm    = 0
           /* A64-0309 */ 
           nv_411t = 0      nv_412t = 0
           nv_42t  = 0      nv_43t  = 0.
           /* end : A64-0309 */ 

     FOR EACH stat.pmuwd132 USE-INDEX pmuwd13201 WHERE 
              stat.pmuwd132.campcd        = trim(impdata_fil.packcod)  AND 
              TRIM(stat.pmuwd132.policy)  = TRIM(impdata_fil.polmaster)  NO-LOCK.  /*A64-0044*/
              /*TRIM(stat.pmuwd132.policy)  = TRIM(nv_polmaster)  NO-LOCK.*/ /*A64-0044*/
        FIND LAST sic_bran.uwd132  USE-INDEX uwd13201 WHERE
             sic_bran.uwd132.policy  = sic_bran.uwm100.policy AND
             sic_bran.uwd132.rencnt  = sic_bran.uwm100.rencnt AND
             sic_bran.uwd132.endcnt  = sic_bran.uwm100.endcnt AND
             sic_bran.uwd132.riskgp  = sic_bran.uwm130.riskgp AND
             sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno AND
             sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno AND
             sic_bran.uwd132.bchyr   = nv_batchyr             AND
             sic_bran.uwd132.bchno   = nv_batchno             AND
             sic_bran.uwd132.bchcnt  = nv_batcnt              AND 
             sic_bran.uwd132.bencod  = stat.pmuwd132.bencod      NO-ERROR NO-WAIT.
   
            IF NOT AVAILABLE sic_bran.uwd132 THEN DO:
                CREATE sic_bran.uwd132.

               ASSIGN fi_process = "Create data to sic_bran.uwd132  ..." + impdata_fil.policy .
               DISP fi_process WITH FRAM fr_main. 
               ASSIGN
                  sic_bran.uwd132.bencod  =  stat.pmuwd132.bencod 
                  sic_bran.uwd132.benvar  =  stat.pmuwd132.benvar 
                  sic_bran.uwd132.rate    =  stat.pmuwd132.rate                     
                  sic_bran.uwd132.gap_ae  =  NO /*stat.pmuwd132.gap_ae --a64-0355--*/                  
                  sic_bran.uwd132.gap_c   =  stat.pmuwd132.gap_c                    
                  sic_bran.uwd132.dl1_c   =  stat.pmuwd132.dl1_c                    
                  sic_bran.uwd132.dl2_c   =  stat.pmuwd132.dl2_c                    
                  sic_bran.uwd132.dl3_c   =  stat.pmuwd132.dl3_c                    
                  sic_bran.uwd132.pd_aep  =  "E"  /*stat.pmuwd132.pd_aep --a64-0355--*/                   
                  sic_bran.uwd132.prem_c  =  stat.pmuwd132.prem_c                   
                  sic_bran.uwd132.fptr    =  0                   
                  sic_bran.uwd132.bptr    =  nv_bptr                   
                  sic_bran.uwd132.policy  =  sic_bran.uwm100.policy 
                  sic_bran.uwd132.rencnt  =  sic_bran.uwm100.rencnt                    
                  sic_bran.uwd132.endcnt  =  sic_bran.uwm100.endcnt                    
                  sic_bran.uwd132.riskgp  =  sic_bran.uwm130.riskgp                 
                  sic_bran.uwd132.riskno  =  sic_bran.uwm130.riskno                 
                  sic_bran.uwd132.itemno  =  sic_bran.uwm130.itemno                 
                  sic_bran.uwd132.rateae  =  stat.pmuwd132.rateae                  
                  sic_bran.uwd132.bchyr   =  nv_batchyr                   
                  sic_bran.uwd132.bchno   =  nv_batchno 
                  sic_bran.uwd132.bchcnt  =  nv_batcnt.
               
                  nv_gapprm = nv_gapprm + stat.pmuwd132.gap_c .
                  nv_pdprm  = nv_pdprm  + stat.pmuwd132.prem_C.
              
               IF sic_bran.uwd132.bencod = "SI"           THEN ASSIGN sic_bran.uwd132.benvar = nv_sivar .
               
               IF sic_bran.uwd132.bencod = "dspc" THEN ASSIGN nv_dss_per  = DECI(SUBSTRING(sic_bran.uwd132.benvar,31,30)).
               IF sic_bran.uwd132.bencod = "NCB"  THEN ASSIGN nv_ncbper   = DECI(SUBSTRING(sic_bran.uwd132.benvar,31,30)).

               IF sic_bran.uwd132.bencod = "BI1"  THEN ASSIGN impdata_fil.comper   = int(SUBSTRING(sic_bran.uwd132.benvar,31,30)) .
               IF sic_bran.uwd132.bencod = "BI2"  THEN ASSIGN impdata_fil.comacc   = int(SUBSTRING(sic_bran.uwd132.benvar,31,30)) .
               IF sic_bran.uwd132.bencod = "PD"   THEN ASSIGN impdata_fil.deductpd = int(SUBSTRING(sic_bran.uwd132.benvar,31,30)) .
               if sic_bran.uwm130.uom1_v <> int(impdata_fil.comper)   then assign sic_bran.uwm130.uom1_v = int(impdata_fil.comper)   .
               if sic_bran.uwm130.uom2_v <> int(impdata_fil.comacc)   then assign sic_bran.uwm130.uom2_v = int(impdata_fil.comacc)   .
               if sic_bran.uwm130.uom5_v <> int(impdata_fil.deductpd) then assign sic_bran.uwm130.uom5_v = int(impdata_fil.deductpd) .

               /* add by : Ranu I. A64-0309 05/08/2021 */
               IF sic_bran.uwd132.bencod = "411"  THEN ASSIGN  nv_411t = stat.pmuwd132.prem_C  impdata_fil.NO_411 = int(SUBSTRING(sic_bran.uwd132.benvar,31,30)).  
               IF sic_bran.uwd132.bencod = "412"  THEN ASSIGN  nv_412t = stat.pmuwd132.prem_C  impdata_fil.NO_412 = int(SUBSTRING(sic_bran.uwd132.benvar,31,30)).  
               IF sic_bran.uwd132.bencod = "42"   THEN ASSIGN  nv_42t  = stat.pmuwd132.prem_C  impdata_fil.NO_42  = int(SUBSTRING(sic_bran.uwd132.benvar,31,30)).  
               IF sic_bran.uwd132.bencod = "43"   THEN ASSIGN  nv_43t  = stat.pmuwd132.prem_C  impdata_fil.NO_43  = int(SUBSTRING(sic_bran.uwd132.benvar,31,30)).   
               
               IF sic_bran.uwd132.bencod = "FLET" AND stat.pmuwd132.benvar = " "  THEN 
                   ASSIGN sic_bran.uwd132.benvar = "     Fleet Discount %  =      10" .
               /* end A64-0309 */

                /* A64-0257 */
               IF SUBSTR(sic_bran.uwd132.bencod,1,3) = "GRP" AND impdata_fil.cargrp <> "" THEN DO:
                   ASSIGN   sic_bran.uwd132.bencod = nv_grpcod
                            sic_bran.uwd132.benvar = nv_grpvar .
               END.
               /* end A64-0257 */
               
               If nv_ncbper  <> 0 Then do:
                   Find LAST sicsyac.xmm104 Use-index xmm10401 Where
                       sicsyac.xmm104.tariff = nv_tariff           AND
                       sicsyac.xmm104.class  = nv_class            AND 
                       sicsyac.xmm104.covcod = nv_covcod           AND 
                       sicsyac.xmm104.ncbper   = INTE(nv_ncbper) No-lock no-error no-wait.
                   IF not avail  sicsyac.xmm104  Then do:
                       Message " This NCB Step not on NCB Rates file xmm104. " View-as alert-box.
                       ASSIGN impdata_fil.pass    = "N"
                           impdata_fil.comment = impdata_fil.comment + "| This NCB Step not on NCB Rates file xmm104. ".
                   END.
                   ELSE ASSIGN nv_ncbper = xmm104.ncbper   
                               nv_ncbyrs = xmm104.ncbyrs.
               END.
               Else do:  
                   ASSIGN nv_ncbyrs =   0
                       nv_ncbper    =   0
                       nv_ncb       =   0.
               END.
               ASSIGN   
                sic_bran.uwm301.ncbper   = nv_ncbper
                sic_bran.uwm301.ncbyrs   = nv_ncbyrs .

               IF nv_bptr <> 0 THEN DO:
                   FIND wf_uwd132 WHERE RECID(wf_uwd132) = nv_bptr.
                       wf_uwd132.fptr = RECID(sic_bran.uwd132).
               END.
               IF nv_bptr = 0 THEN sic_bran.uwm130.fptr03  =  RECID(sic_bran.uwd132).
               nv_bptr = RECID(sic_bran.uwd132).

            END.
        END.
    RUN proc_chkRY . /* A64-0309 */

    sic_bran.uwm130.bptr03  =  nv_bptr. 
    RELEASE stat.pmuwd132.
    RELEASE sic_bran.uwd132.
END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_adduwd132prem C-Win 
PROCEDURE proc_adduwd132prem :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: add by A64-0138       
------------------------------------------------------------------------------*/
DEF BUFFER wf_uwd132 FOR sic_bran.uwd132.
DO:
    FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
    FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.

    ASSIGN nv_bptr = 0      nv_gapprm   = 0     nv_pdprm    = 0 
           nv_411t = 0      nv_412t     = 0     nv_42t      = 0      nv_43t  = 0    nv_ry31 = 0 . /*A68-0044*/

     FOR EACH stat.pmuwd132 USE-INDEX pmuwd13201 WHERE 
              /*stat.pmuwd132.campcd    = sic_bran.uwm100.policy AND*/ /*A68-0044*/
              stat.pmuwd132.policy    = sic_bran.uwm100.policy AND
              stat.pmuwd132.rencnt    = sic_bran.uwm100.rencnt AND
             /* stat.pmuwd132.endcnt    = sic_bran.uwm130.riskno AND /* risk no */  /*A65-0079*/
              stat.pmuwd132.riskno    = sic_bran.uwm130.itemno AND *//* item no */  /*A65-0079*/
              stat.pmuwd132.endcnt    = sic_bran.uwm130.endcnt  AND  /*A65-0079*/
              stat.pmuwd132.riskno    = sic_bran.uwm130.riskno  AND /* risk no */  /*A65-0079*/
              /*stat.pmuwd132.itemno    = sic_bran.uwm130.itemno  AND *//* item no */  /*A65-0079*/
              stat.pmuwd132.txt1      = STRING(nv_batchyr,"9999") AND
              stat.pmuwd132.txt2      = nv_batchno             .
        FIND sic_bran.uwd132  USE-INDEX uwd13201 WHERE
             sic_bran.uwd132.policy  = sic_bran.uwm100.policy AND
             sic_bran.uwd132.rencnt  = sic_bran.uwm100.rencnt AND
             sic_bran.uwd132.endcnt  = sic_bran.uwm100.endcnt AND
             sic_bran.uwd132.riskgp  = sic_bran.uwm130.riskgp AND
             sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno AND
             sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno AND
             sic_bran.uwd132.bchyr   = nv_batchyr             AND
             sic_bran.uwd132.bchno   = nv_batchno             AND
             sic_bran.uwd132.bchcnt  = nv_batcnt              AND 
             sic_bran.uwd132.bencod  = stat.pmuwd132.bencod    NO-ERROR NO-WAIT.

            IF NOT AVAILABLE sic_bran.uwd132 THEN DO:
                CREATE sic_bran.uwd132.

               ASSIGN fi_process = "Create data to sic_bran.uwd132  ..." + impdata_fil.policy .
               DISP fi_process WITH FRAM fr_main. 
               ASSIGN
                  sic_bran.uwd132.bencod  =  stat.pmuwd132.bencod 
                  sic_bran.uwd132.benvar  =  stat.pmuwd132.benvar 
                  sic_bran.uwd132.rate    =  stat.pmuwd132.rate                     
                  sic_bran.uwd132.gap_ae  =  NO /*stat.pmuwd132.gap_ae --A64-0355--*/                     
                  sic_bran.uwd132.gap_c   =  stat.pmuwd132.gap_c                    
                  sic_bran.uwd132.dl1_c   =  stat.pmuwd132.dl1_c                    
                  sic_bran.uwd132.dl2_c   =  stat.pmuwd132.dl2_c                    
                  sic_bran.uwd132.dl3_c   =  stat.pmuwd132.dl3_c                    
                  sic_bran.uwd132.pd_aep  =  "E" /*stat.pmuwd132.pd_aep --A64-0355--*/                   
                  sic_bran.uwd132.prem_c  =  stat.pmuwd132.prem_c                  
                  sic_bran.uwd132.fptr    =  0                   
                  sic_bran.uwd132.bptr    =  nv_bptr                   
                  sic_bran.uwd132.policy  =  sic_bran.uwm100.policy 
                  sic_bran.uwd132.rencnt  =  sic_bran.uwm100.rencnt                    
                  sic_bran.uwd132.endcnt  =  sic_bran.uwm100.endcnt                    
                  sic_bran.uwd132.riskgp  =  sic_bran.uwm130.riskgp                 
                  sic_bran.uwd132.riskno  =  sic_bran.uwm130.riskno                 
                  sic_bran.uwd132.itemno  =  sic_bran.uwm130.itemno                 
                  sic_bran.uwd132.rateae  =  stat.pmuwd132.rateae                  
                  sic_bran.uwd132.bchyr   =  nv_batchyr                   
                  sic_bran.uwd132.bchno   =  nv_batchno 
                  sic_bran.uwd132.bchcnt  =  nv_batcnt.

                  nv_gapprm = nv_gapprm + stat.pmuwd132.gap_c .
                  nv_pdprm  = nv_pdprm  + stat.pmuwd132.prem_C.
                 
               IF SUBSTR(sic_bran.uwd132.bencod,1,3) = "GRP" AND impdata_fil.cargrp <> "" THEN DO:
                   ASSIGN   sic_bran.uwd132.bencod = nv_grpcod
                            sic_bran.uwd132.benvar = nv_grpvar .
               END.
               IF sic_bran.uwd132.bencod = "NCB" THEN ASSIGN nv_ncbper   = DECI(SUBSTRING(sic_bran.uwd132.benvar,31,30)). 
               /* add by : Ranu I. A64-0309 05/08/2021 */
               IF sic_bran.uwd132.bencod = "411"  THEN ASSIGN  nv_411t = stat.pmuwd132.prem_C  impdata_fil.NO_411 = int(SUBSTRING(sic_bran.uwd132.benvar,31,30)).  
               IF sic_bran.uwd132.bencod = "412"  THEN ASSIGN  nv_412t = stat.pmuwd132.prem_C  impdata_fil.NO_412 = int(SUBSTRING(sic_bran.uwd132.benvar,31,30)).  
               IF sic_bran.uwd132.bencod = "42"   THEN ASSIGN  nv_42t  = stat.pmuwd132.prem_C  impdata_fil.NO_42  = int(SUBSTRING(sic_bran.uwd132.benvar,31,30)).  
               IF sic_bran.uwd132.bencod = "43"   THEN ASSIGN  nv_43t  = stat.pmuwd132.prem_C  impdata_fil.NO_43  = int(SUBSTRING(sic_bran.uwd132.benvar,31,30)). 
               IF sic_bran.uwd132.bencod = "31"   THEN ASSIGN  nv_ry31 = stat.pmuwd132.prem_c  . /*A68-0044*/
               
               IF sic_bran.uwd132.bencod = "FLET" AND stat.pmuwd132.benvar = " "  THEN 
                   ASSIGN sic_bran.uwd132.benvar = "     Fleet Discount %  =      10" .
               /* end A64-0309 */
               IF nv_bptr <> 0 THEN DO:
                   FIND wf_uwd132 WHERE RECID(wf_uwd132) = nv_bptr.
                       wf_uwd132.fptr = RECID(sic_bran.uwd132).
               END.
               IF nv_bptr = 0 THEN sic_bran.uwm130.fptr03  =  RECID(sic_bran.uwd132).
               nv_bptr = RECID(sic_bran.uwd132).

            END. /* end uwd132*/
            /* add : A64-0138*/
            If nv_ncbper  <> 0 Then do:
               Find LAST sicsyac.xmm104 Use-index xmm10401 Where
                   sicsyac.xmm104.tariff = nv_tariff           AND
                   sicsyac.xmm104.class  = nv_class            AND 
                   sicsyac.xmm104.covcod = nv_covcod           AND 
                   sicsyac.xmm104.ncbper   = INTE(nv_ncbper) No-lock no-error no-wait.
               IF not avail  sicsyac.xmm104  Then do:
                   Message " This NCB Step not on NCB Rates file xmm104. " View-as alert-box.
                   ASSIGN impdata_fil.pass    = "N"
                          impdata_fil.comment = impdata_fil.comment + "| This NCB Step not on NCB Rates file xmm104. ".
               END.
               ELSE ASSIGN nv_ncbper = xmm104.ncbper   
                           nv_ncbyrs = xmm104.ncbyrs.
            END.
            Else do:  
               ASSIGN nv_ncbyrs    =   0
                      nv_ncbper    =   0
                      nv_ncb       =   0.
            END.
            ASSIGN   
                sic_bran.uwm301.ncbper   = nv_ncbper
                sic_bran.uwm301.ncbyrs   = nv_ncbyrs .
            
           /* DELETE stat.pmuwd132 .   end A64-0138 */

    END. /* end pmuwd132 */
    /* Add by : A68-0044*/
    IF tg_flag = YES AND impdata_fil.garage = "G" AND nv_ry31 = 0 THEN DO:
        ASSIGN 
               impdata_fil.comment  = impdata_fil.comment + "| Class " + impdata_fil.subclass + " New Tariff Garage = G ต้องมีเบี้ย รย.31 " 
               impdata_fil.WARNING  = impdata_fil.subclass + " New Tariff Garage = G ต้องมีเบี้ย รย.31 "  .
    END.
    /* end : A68-0044*/
    sic_bran.uwm130.bptr03  =  nv_bptr. 
    RELEASE stat.pmuwd132.
    RELEASE sic_bran.uwd132.
    RELEASE sic_bran.uwm100.
    RELEASE sic_bran.uwm130.

END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign2 C-Win 
PROCEDURE proc_assign2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR  b_eng    AS DECI FORMAT  ">>>>9.99-".
DEF VAR  n_addr   AS CHAR FORMAT "x(500)" INIT "" .
DEF VAR  n_date   AS CHAR FORMAT  "x(10)".
DEF VAR  n_pol    AS CHAR FORMAT "x(12)" .
DEF VAR  n_BR     AS CHAR FORMAT "x(2)" .

FOR EACH impdata_fil WHERE impdata_fil.policyno NE " "  .
    ASSIGN fi_process = "Check data " + impdata_fil.policyno + " " + string(impdata_fil.riskno,"999") + "/" + string(impdata_fil.itemno,"999") + " " + 
                        impdata_fil.chasno + "....." .
    DISP fi_process WITH FRAM fr_main.

    ASSIGN 
    n_addr           = "" 
    nv_chkerror      = ""
    n_pol            = ""
    n_BR             = "" .
    IF ra_type  = 2 THEN DO:
        IF impdata_fil.prepol <> " " AND impdata_fil.poltyp = "V70" THEN RUN proc_assignrenew.                
    END.
    ELSE DO:
        impdata_fil.prepol = "" .
    END.
    RUN proc_cutchar.

    IF length(impdata_fil.policyno) < 12 THEN DO:
        ASSIGN impdata_fil.comment = impdata_fil.comment + "|" + "เบอร์กรมธรรม์ไม่ครบ 12 หลัก"
                   impdata_fil.pass    = "N"
                   impdata_fil.OK_GEN  = "N".
    END.
    /* add by : Ranu I. A65-0043 */
    IF trim(SUBSTR(impdata_fil.policyno,3,2)) <> trim(substr(impdata_fil.poltyp,2,2))  THEN DO:
        ASSIGN impdata_fil.comment = impdata_fil.comment + "|" + "เบอร์กรมธรรม์ไม่ตรงกับ Policy Type"
               impdata_fil.pass    = "N"
               impdata_fil.OK_GEN  = "N".
    END.
    /* end : A65-0043 */
    n_pol = SUBSTR(impdata_fil.policyno,1,1).
    IF n_pol = "D" THEN DO:
       n_br  = SUBSTR(impdata_fil.policyno,2,1). 
       IF n_br <> impdata_fil.n_branch THEN 
           ASSIGN impdata_fil.comment = impdata_fil.comment + "|" + "เบอร์กรมธรรม์ไม่ตรงกับสาขา"
               impdata_fil.pass    = "N"
               impdata_fil.OK_GEN  = "N".
    END.
    ELSE DO:
        n_br  = SUBSTR(impdata_fil.policyno,1,2). 
        IF n_br <> impdata_fil.n_branch THEN 
           ASSIGN impdata_fil.comment = impdata_fil.comment + "|" + "เบอร์กรมธรรม์ไม่ตรงกับสาขา"
               impdata_fil.pass    = "N"
               impdata_fil.OK_GEN  = "N".
    END.

    FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE sicuw.uwm100.policy = impdata_fil.policyno NO-LOCK NO-ERROR .
    IF AVAIL uwm100 THEN DO:
       ASSIGN impdata_fil.comment = impdata_fil.comment + "|" + "เบอร์กรมธรรม์มีข้อมูลในระบบพรีเมียมแล้ว"
               impdata_fil.pass    = "N"
               impdata_fil.OK_GEN  = "N".
    END.

    IF impdata_fil.riskno = 0 AND (impdata_fil.provcod  = ""  OR impdata_fil.distcod  = ""  OR impdata_fil.sdistcod = "" ) THEN DO:
        n_addr = trim(impdata_fil.addr  + " " + impdata_fil.tambon + " " + impdata_fil.amper + " " + impdata_fil.country)  .
        RUN wgw/wgwchkaddr(INPUT n_addr ,
                           OUTPUT impdata_fil.provcod , 
                           OUTPUT impdata_fil.distcod , 
                           OUTPUT impdata_fil.sdistcod,
                           OUTPUT nv_chkerror) .
        IF nv_chkerror <> ""  THEN 
            ASSIGN impdata_fil.comment = impdata_fil.comment + "|" + nv_chkerror 
                   impdata_fil.pass    = "N"
                   impdata_fil.OK_GEN  = "N".
    END.
    /* Add by : A65-0043  Check Date and Cover Day */
    nv_chkerror = "" .
    RUN wgw/wgwchkdate(input impdata_fil.comdat,
                       input impdata_fil.expdat,
                       input impdata_fil.poltyp,
                       OUTPUT nv_chkerror ) .
    IF nv_chkerror <> ""  THEN 
        ASSIGN impdata_fil.comment = impdata_fil.comment + "|" + nv_chkerror 
               impdata_fil.pass    = "N"
               impdata_fil.OK_GEN  = "N".
    /* end : A65-0043 */
    /*RUN proc_address. */ /*A64-0309*/
    /* เช็ควันที่คุ้มครองกับวันที่หมดอายุ */
    /* comment by : Ranu I. A65-0043 ..
    IF (impdata_fil.expDat < impdata_fil.comDat)  THEN DO:
       ASSIGN impdata_fil.comment = impdata_fil.comment + "|" + STRING(YEAR(impdata_fil.expdat),"9999") + " วันที่สิ้นสุดความคุ้มครองน้อยกว่าวันที่คุ้มครอง !" + 
                                STRING(YEAR(impdata_fil.comdat),"9999")
               impdata_fil.pass    = "N" 
               impdata_fil.OK_GEN  = "N".
    END.
    IF (impdata_fil.expDat = impdata_fil.comDat)  THEN DO:
       ASSIGN impdata_fil.comment = impdata_fil.comment + "|" + STRING(YEAR(impdata_fil.expdat),"9999") + " วันที่สิ้นสุดความคุ้มครองเท่ากับวันที่คุ้มครอง !"
              impdata_fil.pass    = "N" 
              impdata_fil.OK_GEN  = "N".
    END.
    ..end A65-0043....*/

    IF impdata_fil.riskno <> 0 THEN DO: /* Car Detail */
        IF impdata_fil.covcod <> "3"  AND impdata_fil.si = 0  AND impdata_fil.siplus = 0 THEN DO:
             ASSIGN impdata_fil.comment = impdata_fil.comment + "|" + "ความคุ้มครอง ป. " + impdata_fil.covcod + " กรุณาระบุ Sum Insured Plus หรือ Theft & Fire "
                   impdata_fil.pass    = "N"
                   impdata_fil.OK_GEN  = "N".
        END.
        /* CC ตามไฟล์
        IF impdata_fil.engcc <> 0  THEN DO:
            ASSIGN 
                b_eng            = round((DECI(impdata_fil.engcc) / 1000),1)     /*format engcc */
                b_eng            = b_eng * 1000
                impdata_fil.engcc    = b_eng.
        END.*/
        IF impdata_fil.vehreg = "" THEN DO:
            IF ra_type = 1 THEN DO:
                IF LENGTH(impdata_fil.chasno) < 9  THEN
                    ASSIGN impdata_fil.vehreg   = "/" + TRIM(impdata_fil.chasno) 
                       impdata_fil.re_country  = "" .
                /*ELSE ASSIGN impdata_fil.vehreg   = "/" + SUBSTRING(impdata_fil.chasno,LENGTH(impdata_fil.chasno) - 9) */ /*A65-0043*/
                ELSE ASSIGN impdata_fil.vehreg   = "/" + SUBSTRING(impdata_fil.chasno,LENGTH(impdata_fil.chasno) - 8)     /*A65-0043*/
                           impdata_fil.re_country  = "" .
            END.
        END.
        IF TRIM(impdata_fil.re_country) <> "" THEN DO: 
            FIND LAST brstat.insure USE-INDEX Insure05   WHERE   /*use-index fname */
                brstat.insure.FName = TRIM(impdata_fil.re_country) AND
                brstat.insure.compno = "999" NO-LOCK NO-WAIT NO-ERROR.
            IF AVAIL brstat.insure THEN 
                ASSIGN impdata_fil.re_country = trim(Insure.LName) .
        END.
        RELEASE brstat.insure.
         /* check Redbook */
        IF impdata_fil.redbook = ""  THEN DO:
            ASSIGN fi_process = "check Redbook " + string(impdata_fil.itemno,"999") + " " + impdata_fil.chasno + ".....".
            DISP fi_process WITH FRAM fr_main.
        
            IF index(impdata_fil.covcod,".") <> 0 THEN nv_si = INT(impdata_fil.siplus)  .
            ELSE nv_si = INT(impdata_fil.si).
            /*RUN wgw/wgwredbook(input  impdata_fil.brand ,  */  /*ranu : 02/03/2022*/
            /* add : A67-0029 */
            IF index(impdata_fil.subclass,"E") <> 0   THEN DO:
                RUN wgw/wgwredbev(input  impdata_fil.brand ,      
                                  input  impdata_fil.model ,  
                                  input  nv_si ,  
                                  INPUT  impdata_fil.tariff,  
                                  input  impdata_fil.subclass,   
                                  input  impdata_fil.yrmanu, 
                                  input  nv_engine , 
                                  input  0,
                                  INPUT-OUTPUT impdata_fil.maksi,
                                  INPUT-OUTPUT impdata_fil.redbook) .
            END.
            ELSE DO: /* end : A67-0029 */
                RUN wgw/wgwredbk1(input   impdata_fil.brand ,        /*ranu : 02/03/2022*/
                                   input  impdata_fil.model ,  
                                   input  nv_si         ,  
                                   INPUT  impdata_fil.tariff,  
                                   input  impdata_fil.subclass,   
                                   input  impdata_fil.yrmanu, 
                                   input  impdata_fil.engcc  ,
                                   input  impdata_fil.weight , 
                                   INPUT-OUTPUT impdata_fil.redbook) .
            END.
        END.
        /* add by : ranu A65-0079 */
        ELSE DO:
           Find First stat.maktab_fil USE-INDEX maktab04    Where
               stat.maktab_fil.modcod   = trim(impdata_fil.redbook)  AND 
               stat.maktab_fil.sclass   = impdata_fil.subclass       No-lock no-error no-wait.
              If NOT AVAIL stat.maktab_fil  THEN DO:
                  ASSIGN impdata_fil.comment = impdata_fil.comment + "|" + "ไม่พบ Redbook Code:" + impdata_fil.redbook + " ของ Class : " + 
                                               impdata_fil.subclass + " ในพารามิเตอร์ Redbook " 
                         impdata_fil.redbook = "" .
                     /*impdata_fil.pass    = "N".*/
              END.

           IF impdata_fil.redbook = ""  THEN DO:
             ASSIGN fi_process = "check Redbook " + string(impdata_fil.itemno,"999") + " " + impdata_fil.chasno + ".....".
             DISP fi_process WITH FRAM fr_main.
            
             IF index(impdata_fil.covcod,".") <> 0 THEN nv_si = INT(impdata_fil.siplus)  .
             ELSE nv_si = INT(impdata_fil.si).
             RUN wgw/wgwredbk1(input   impdata_fil.brand ,        /*ranu : 02/03/2022*/
                                input  impdata_fil.model ,  
                                input  nv_si         ,  
                                INPUT  impdata_fil.tariff,  
                                input  impdata_fil.subclass,   
                                input  impdata_fil.yrmanu, 
                                input  impdata_fil.engcc  ,
                                input  impdata_fil.weight , 
                                INPUT-OUTPUT impdata_fil.redbook) .
           END.
        END.
        /* end : ranu A65-0079 */
    END.
    RUN proc_chktest0.
    RUN proc_susspect. 
       
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assigndata C-Win 
PROCEDURE proc_assigndata :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO: nv_error = "" .
    RUN proc_initdataex.
    INPUT FROM VALUE(fi_FileName).
    REPEAT:
        IMPORT DELIMITER "|"
         wf_riskno   /*Risk no */
         wf_num      /*ItemNo */                  
         wf_policyno /*Policy No (เลขที่กรมธรรม์ภาคสมัครใจ) */      
         wf_n_branch /*Branch (สาขา) */      
         wf_agent    /*Agent Code (รหัสตัวแทน) */      
         wf_producer /*Producer Code */      
         wf_n_delercode   /*Dealer Code (รหัสดีเลอร์)  */      
         wf_fincode  /*Finance Code (รหัสไฟแนนซ์) */      
         wf_appenno  /*Notification Number (เลขที่รับแจ้ง)*/      
         wf_salename /*Notification Name (ชื่อผู้แจ้ง)    */      
         wf_srate    /*Short Rate  */      
         wf_comdat   /*Effective Date (วันที่เริ่มความคุ้มครอง) */      
         wf_expdat   /*Expiry Date (วันที่สิ้นสุดความคุ้มครอง)  */      
         wf_agreedat /*Agree Date  */      
         wf_firstdat /*First Date  */      
         wf_packcod  /*รหัส Package  */          
         wf_camp_no /*Campaign Code (รหัสแคมเปญ) */      
         wf_campen  /*Campaign Text */      
         wf_specon  /*Spec Con     */      
         wf_product /*Product Type */      
         wf_promo   /*Promotion Code*/      
         wf_rencnt  /*Renew Count   */      
         wf_prepol /*Previous Policy (เลขทีกรมธรรม์ภาคสมัครใจเดิม)*/  
         wf_txt1 /*Policy Text 1 */                                
         wf_txt2 /*Policy Text 2 */                                
         wf_txt3 /*Policy Text 3 */                                
         wf_txt4 /*Policy Text 4 */                                
         wf_txt5 /*Policy Text 5 */                                
         wf_txt6 /*Policy Text 6 */                                
         wf_txt7 /*Policy Text 7 */                                
         wf_txt8 /*Policy Text 8 */                                
         wf_txt9 /*Policy Text 9 */                                
         wf_txt10 /*Policy Text 10 */                                
         wf_memo1 /*Memo Text 1 */                                
         wf_memo2 /*Memo Text 2 */                                
         wf_memo3 /*Memo Text 3 */                                
         wf_memo4 /*Memo Text 4 */                                
         wf_memo5 /*Memo Text 5 */                                
         wf_memo6 /*Memo Text 6 */                                
         wf_memo7 /*Memo Text 7 */                                
         wf_memo8 /*Memo Text 8 */                                
         wf_memo9 /*Memo Text 9 */                                
         wf_memo10 /*Memo Text 10*/                                
         wf_accdata1 /*Accessory Text 1 */                              
         wf_accdata2 /*Accessory Text 2 */                              
         wf_accdata3 /*Accessory Text 3 */                              
         wf_accdata4 /*Accessory Text 4 */                                  
         wf_accdata5 /*Accessory Text 5 */                                  
         wf_accdata6 /*Accessory Text 6 */                                  
         wf_accdata7 /*Accessory Text 7 */                                  
         wf_accdata8 /*Accessory Text 8 */                                  
         wf_accdata9 /*Accessory Text 9 */                                  
         wf_accdata10 /*Accessory Text 10*/                                  
         wf_compul  /*กรมธรรม์ซื้อควบ (Y/N)  */ 
         wf_insref  /* new  Code insured  */
         wf_instyp  /*ประเภทบุคคล */                            
         wf_inslang /*ภาษาที่ใช้สร้าง Cilent Code */         
         wf_tiname  /*คำนำหน้า */         
         wf_insnam  /*ชื่อ     */         
         wf_lastname /*นามสกุล */                            
         wf_icno   /*เลขที่บัตรประชาชน / เลขที่นิติบุคคล*/         
         wf_insbr  /*ลำดับที่สาขา */                            
         wf_occup  /*อาชีพ  */                            
         wf_addr   /*ที่อยู่บรรทัดที่ 1*/                            
         wf_tambon /*ที่อยู่บรรทัดที่ 2*/                            
         wf_amper  /*ที่อยู่บรรทัดที่ 3*/                            
         wf_country /*ที่อยู่บรรทัดที่ 4*/                            
         wf_post   /*รหัสไปรษณีย์ */                            
         wf_provcod  /*province code */                            
         wf_distcod  /*district code */                            
         wf_sdistcod /*sub district code */  
         wf_ae   /*ae  new Xmm600 งาน Japanes */
         wf_jtl  /*jtl new Xmm600 งาน Japanes */
         wf_ts   /*ts  new Xmm600 งาน Japanes */
         wf_gender /*Gender (Male/Female/Other) */         
         wf_tele1  /*Telephone 1*/                            
         wf_tele2  /*Telephone 2*/                            
         wf_mail1  /*E-Mail 1 */                            
         wf_mail2  /*E-Mail 2 */                            
         wf_mail3  /*E-Mail 3 */                            
         wf_mail4  /*E-Mail 4 */                            
         wf_mail5  /*E-Mail 5 */                            
         wf_mail6  /*E-Mail 6 */                            
         wf_mail7  /*E-Mail 7 */                            
         wf_mail8  /*E-Mail 8 */                            
         wf_mail9  /*E-Mail 9 */                            
         wf_mail10 /*E-Mail 10*/                            
         wf_fax    /*Fax */                            
         wf_lineID /*Line ID*/                            
         wf_name2  /*CareOf1*/                            
         wf_name3  /*CareOf2*/                            
         wf_benname  /*Benefit Name*/                            
         wf_payercod /*Payer Code*/                            
         wf_vatcode  /*VAT Code  */                            
         wf_instcod1 /*Client Code */                            
         wf_insttyp1 /*ประเภทบุคคล */                            
         wf_insttitle1 /*คำนำหน้า*/                            
         wf_instname1  /*ชื่อ */                            
         wf_instlname1 /*นามสกุล */                            
         wf_instic1  /*เลขที่บัตรประชาชน / เลขที่นิติบุคคล */         
         wf_instbr1  /*ลำดับที่สาขา  */                           
         wf_instaddr11 /*ที่อยู่บรรทัดที่ 1 */                 
         wf_instaddr21 /*ที่อยู่บรรทัดที่ 2 */                 
         wf_instaddr31 /*ที่อยู่บรรทัดที่ 3 */                 
         wf_instaddr41 /*ที่อยู่บรรทัดที่ 4 */                 
         wf_instpost1  /* รหัสไปรษณีย์    */                 
         wf_instprovcod1  /*province code */                 
         wf_instdistcod1  /*district code */                 
         wf_instsdistcod1 /*sub district code  */                 
         wf_instprm1   /*เบี้ยก่อนภาษีอากร  */                 
         wf_instrstp1  /*อากร  */                 
         wf_instrtax1  /*ภาษี  */                 
         wf_instcomm01 /*คอมมิชชั่น 1 */                 
         wf_instcomm12 /*คอมมิชชั่น 2 (co-broker) */           
         wf_instcod2   /*Client Code*/                 
         wf_insttyp2   /*ประเภทบุคคล*/                 
         wf_insttitle2 /*คำนำหน้า*/                 
         wf_instname2  /*ชื่อ    */                 
         wf_instlname2 /*นามสกุล */                 
         wf_instic2    /*เลขที่บัตรประชาชน / เลขที่นิติบุคคล*/     
         wf_instbr2    /*ลำดับที่สาขา  */                 
         wf_instaddr12 /*ที่อยู่บรรทัดที่ 1*/                 
         wf_instaddr22 /*ที่อยู่บรรทัดที่ 2*/                 
         wf_instaddr32 /*ที่อยู่บรรทัดที่ 3*/                 
         wf_instaddr42 /*ที่อยู่บรรทัดที่ 4*/                 
         wf_instpost2  /*รหัสไปรษณีย์  */                 
         wf_instprovcod2  /*province code */                 
         wf_instdistcod2  /*district code */                 
         wf_instsdistcod2 /*sub district code */                 
         wf_instprm2   /*เบี้ยก่อนภาษีอากร */                 
         wf_instrstp2  /*อากร  */                 
         wf_instrtax2  /*ภาษี  */                 
         wf_instcomm02 /*คอมมิชชั่น 1  */                 
         wf_instcomm22 /*คอมมิชชั่น 2 (co-broker)*/           
         wf_instcod3   /*Client Code*/                 
         wf_insttyp3   /*ประเภทบุคคล*/                 
         wf_insttitle3 /*คำนำหน้า   */                 
         wf_instname3  /*ชื่อ       */                 
         wf_instlname3 /*นามสกุล    */                 
         wf_instic3    /*เลขที่บัตรประชาชน/เลขที่นิติบุคคล  */   
         wf_instbr3    /*ลำดับที่สาขา      */                
         wf_instaddr13 /*ที่อยู่บรรทัดที่ 1*/                
         wf_instaddr23 /*ที่อยู่บรรทัดที่ 2*/                
         wf_instaddr33 /*ที่อยู่บรรทัดที่ 3*/                
         wf_instaddr43 /*ที่อยู่บรรทัดที่ 4*/                
         wf_instpost3  /*รหัสไปรษณีย์  */                
         wf_instprovcod3  /*province code  */                
         wf_instdistcod3  /*district code  */                
         wf_instsdistcod3 /*sub district code */                
         wf_instprm3   /*เบี้ยก่อนภาษีอากร*/                
         wf_instrstp3  /*อากร */                
         wf_instrtax3  /*ภาษี */                
         wf_instcomm03 /*คอมมิชชั่น 1 */          
         wf_instcomm23 /*คอมมิชชั่น 2 (co-broker) */
         wf_covcod   /*Cover Type (ประเภทความคุ้มครอง)   */
         wf_garage   /*Garage (ประเภทการซ่อม ซ่อมอู่/ซ่อมห้าง)  */
         wf_special  /*Spacial EquipmentFlag(A/Blank)*/       
         wf_inspec   /*Inspection */                
         wf_class70  /*รหัสรถภาคสมัครใจ (110/120/…)   */
         wf_vehuse   /* ลักษณะการใช้รถ */   
         wf_redbook  /* redbook */                     /*A65-0079 */
         wf_brand    /*ยี่ห้อรถ   */                
         wf_model    /*ชื่อรุ่นรถ */                
         wf_submodel /*ชื่อรุ่นย่อยรถ*/                
         wf_caryear  /*ปีรุ่นรถ      */                
         wf_chasno   /*หมายเลขตัวถัง */                
         wf_eng     /*หมายเลขเครื่อง */
         wf_eng_no2 /*หมายเลขเครื่อง 2 */ /*A67-0029*/
         wf_seat    /*จำนวนที่นั่ง (รวมผู้ขับขี่) */       
         wf_engcc   /*ปริมาตรกระบอกสูบ (CC) */                
         wf_weight  /*น้ำหนัก (ตัน) */ 
         wf_watt    /*Kilowatt      */ 
         wf_body    /*รหัสแบบตัวถัง */ 
         wf_type    /*ป้ายแดง (Y/N) */ 
         wf_re_year /*ปีที่จดทะเบียน */ 
         wf_vehreg  /*เลขทะเบียนรถ   */ 
         wf_re_country  /*จังหวัดที่จดทะเบียน*/ 
         wf_cargrp   /*Group Car (กลุ่มรถ)*/ 
         wf_colorcar /*Color (สี) */ 
         wf_fule     /*Fule (เชื้อเพลิง) */ 
         wf_drivnam  /*Driver Number*/
         wf_ntitle1  /*คำนำหน้า     */ 
         wf_drivername1    /*ชื่อ   */ 
         wf_dname2   /*นามสกุล      */  
         wf_dicno    /*เลขที่บัตรประชาชน */  
         wf_dgender1 /*เพศ       */  
         wf_dbirth   /*วันเกิด   */  
         wf_doccup   /*ชื่ออาชีพ */  
         wf_ddriveno /*เลขที่ใบอนุญาตขับขี่  */ 
         wf_drivexp1 /*วันที่ใบอนุญาต หมดอายุ */  /*A67-0029*/
         wf_dconsen1 /*Consent 1 */  /*A67-0029*/
         wf_dlevel1  /*ระดับพฤติกรรมการขับขี่ */  /*A67-0029*/
         wf_ntitle2  /*คำนำหน้า   */  
         wf_drivername2    /*ชื่อ */  
         wf_ddname1   /*นามสกุล   */  
         wf_ddicno    /*เลขที่บัตรประชาชน */  
         wf_dgender2  /*เพศ       */  
         wf_ddbirth   /*วันเกิด   */  
         wf_ddoccup   /*ชื่ออาชีพ */  
         wf_dddriveno /*เลขที่ใบอนุญาตขับขี่ */ 
         /*Add by : A67-0029*/
        wf_drivexp2  /*วันที่ใบอนุญาต หมดอายุ */  
        wf_dconsen2 /*Consent 2 */  /*A67-0029*/
        wf_dlevel2   /*ระดับพฤติกรรมการขับขี่ */
        wf_ntitle3   /*คำนำหน้า              */ 
        wf_dname3    /*ชื่อ                  */ 
        wf_dlname3   /*นามสกุล               */ 
        wf_dicno3    /*เลขที่บัตรประชาชน     */ 
        wf_dgender3  /*เพศ                   */ 
        wf_dbirth3   /*วันเกิด               */ 
        wf_doccup3   /*ชื่ออาชีพ             */ 
        wf_ddriveno3 /*เลขที่ใบอนุญาตขับขี่  */ 
        wf_drivexp3  /*วันที่ใบอนุญาต หมดอายุ*/ 
        wf_dconsen3 /*Consent 3 */  /*A67-0029*/
        wf_dlevel3   /*ระดับพฤติกรรมการขับขี่*/ 
        wf_ntitle4   /*คำนำหน้า              */ 
        wf_dname4    /*ชื่อ                  */ 
        wf_dlname4   /*นามสกุล               */ 
        wf_dicno4    /*เลขที่บัตรประชาชน     */ 
        wf_dgender4  /*เพศ                   */ 
        wf_dbirth4   /*วันเกิด               */ 
        wf_doccup4   /*ชื่ออาชีพ             */ 
        wf_ddriveno4 /*เลขที่ใบอนุญาตขับขี่  */ 
        wf_drivexp4  /*วันที่ใบอนุญาต หมดอายุ*/
        wf_dconsen4 /*Consent 4 */  /*A67-0029*/
        wf_dlevel4   /*ระดับพฤติกรรมการขับขี่*/
        wf_ntitle5      /*คำนำหน้า              */ 
        wf_dname5       /*ชื่อ                  */ 
        wf_dlname5      /*นามสกุล               */ 
        wf_dicno5       /*เลขที่บัตรประชาชน     */ 
        wf_dgender5     /*เพศ                   */ 
        wf_dbirth5      /*วันเกิด               */ 
        wf_doccup5      /*ชื่ออาชีพ             */ 
        wf_ddriveno5    /*เลขที่ใบอนุญาตขับขี่  */ 
        wf_drivexp5     /*วันที่ใบอนุญาต หมดอายุ*/ 
        wf_dconsen5 /*Consent 5 */  /*A67-0029*/
        wf_dlevel5      /*ระดับพฤติกรรมการขับขี่*/ 
        /* end : A67-0029*/
        wf_baseplus  /*Base Premium Plus */  
        wf_siplus    /*Sum Insured Plus  */  
        wf_rs10      /*RS10 Amount   */  
        wf_comper    /*TPBI / person */  
        wf_comacc    /*TPBI / occurrence */  
        wf_deductpd  /*TPPD     */  
        wf_DOD    /*Deduct / OD */  
        wf_dod1   /* DOD1 */    /*A65-0079*/ 
        wf_DPD    /*Deduct / PD */
        wf_maksi  /* ทุนประกันรถ EV */ /*A67-0029*/
        wf_tpfire /*Theft & Fire*/  
        wf_NO_411 /*PA1.1 / driver    */  
        wf_ac2    /*PA1.1 no.of passenger */  
        wf_NO_412 /*PA1.1 / passenger */  
        wf_NO_413 /*PA1.2 / driver    */  
        wf_ac6    /*PA1.2 no.of passenger */  
        wf_NO_414 /*PA1.2 / passenger*/  
        wf_NO_42  /*PA2 */  
        wf_NO_43  /*PA3 */  
        wf_base   /*Base Premium */  
        wf_unname /*Unname */  
        wf_nname  /*Name   */  
        wf_tpbi   /*TPBI1 Amount  */  
        wf_tpbiocc /*TPBI2 Amount  */  /*A65-0079*/ 
        wf_tppd    /*TPPD Amount  */ 
        wf_dodamt  /*A65-0079*/
        wf_dod1amt /*A65-0079*/
        wf_dpdamt  /*A65-0079*/
        wf_ry01  /*RY01 Amount  */ 
        wf_ry412 /*A65-0079*/
        wf_ry413 /*A65-0079*/
        wf_ry414 /*A65-0079*/
        wf_ry02  /*RY02 Amount*/  
        wf_ry03  /*RY03 Amount*/  
        wf_fleet /*Fleet% */  
        wf_ncb   /*NCB%   */  
        wf_claim /*Load Claim%  */  
        wf_dspc  /*Other Disc.% */  
        wf_cctv  /*CCTV% */  
        wf_dstf  /*Walkin Disc.%*/  
        wf_fleetprem /*Fleet Amount */  
        wf_ncbprem   /*NCB Amount   */  
        wf_clprem    /*Load Claim Amount*/  
        wf_dspcprem  /*Other Disc. Amount */ 
        wf_cctvprem  /*CCTV Amount  */  
        wf_dstfprem  /*Walk in Disc.Amount */ 
        wf_premt     /*เบี้ยสุทธิ */  
        wf_rstp_t    /*Stamp Duty */  
        wf_rtax_t    /*VAT        */  
        wf_comper70  /*Commission % */  
        wf_comprem70 /*Commission Amount*/  
        wf_agco70    /*Agent Code co-broker (รหัสตัวแทน)*/      
        wf_comco_per70  /*Commission % co-broker*/              
        wf_comco_prem70 /*Commission Amount co-broker*/ 
        /* ไม่เก็บไปใช้ */
        wf_dgpackge  /*Package (Attach Coverage)  */         
        wf_danger1   /*Dangerous Object 1*/              
        wf_danger2   /*Dangerous Object 2*/              
        wf_dgsi      /*Sum Insured*/              
        wf_dgrate    /*Rate%    */              
        wf_dgfeet    /*Fleet%   */              
        wf_dgncb     /*NCB%     */              
        wf_dgdisc    /*Discount%  */            
        wf_dgwdisc   /*Walkin Discount%  */          
        wf_dgatt     /*Premium Attach Coverage */            
        wf_dgfeetprm /*Discount Fleet */              
        wf_dgncbprm  /*Discount NCB   */              
        wf_dgdiscprm /*Other Discount */ 
        wf_dgWdiscprm /*walkin Discount*/ 
        wf_dgprem     /*Net Premium */              
        wf_dgrstp_t   /*Stamp Duty  */              
        wf_dgrtax_t   /*VAT */              
        wf_dgcomper   /*Commission % */              
        wf_dgcomprem  /*Commission Amount */ 
        /* end :ไม่เก็บไปใช้ */   
        wf_cltxt    /*Claim Text  */                           
        wf_clamount /*Claim Amount*/                           
        wf_faultno  /*Claim Count Fault */                           
        wf_faultprm /*Claim Count Fault Amount  */                      
        wf_goodno   /*Claim Count Good   */                      
        wf_goodprm  /*Claim Count Good Amount*/                      
        wf_loss     /*Loss Ratio % (Not TP)  */                      
        /* ไม่เก็บไปใช้ */
        wf_compolusory /*Compulsory Policy Number (เลขที่กรมธรรม์ พรบ.)*/   
        wf_barcode     /*Barcode No. */                  
        wf_class72     /*Compulsory Class (รหัส พรบ.)   */                  
        wf_dstf72      /*Compulsory Walk In Discount %  */                  
        wf_dstfprem72  /*Compulsory Walk In Discount Amount      */         
        wf_premt72     /*เบี้ยสุทธิ พ.ร.บ. กรณี "กรมธรรม์ซื้อควบ"*/       
        wf_rstp_t72    /*Stamp Duty   */                         
        wf_rtax_t72    /*VAT  */                         
        wf_comper72    /*Commission % */                         
        wf_comprem72  /*Commission Amount*/
        /* End :ไม่เก็บไปใช้ */
        /*add by : A67-0029 รถ EV */
        wf_battno    /*เลขที่แบตเตอรี่ */  
        wf_battyr    /*ปีแบตฯ   */  
        wf_battprice /*ราคาแบตฯ */ 
        wf_battsi    /*ทุนแบตฯ */ 
        wf_battrate   /*Rate     */  
        wf_battprm   /*Premium  */  
        wf_chargno   /*เลขที่เครื่องชาร์จ*/  
        wf_chargsi   /*ราคาเครื่องชาร์จ  */  
        wf_chargrate  /*Rate     */  
        wf_chargprm  /*Premium */  
        /* end : A67-0029*/ 
        wf_31rate   /* Rate 31  --A68-0044-- */
        wf_31prmt . /* เบี้ย 31 --A68-0044-- */
        RUN proc_assigndata2 . /*A65-0079*/
    END.         /* repeat   */
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assigndata2 C-Win 
PROCEDURE proc_assigndata2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: A65-0079      
------------------------------------------------------------------------------*/
DO:
      IF TRIM(wf_riskno) = ""                      THEN RUN proc_initdataex.
      ELSE IF index(TRIM(wf_riskno),"Risk") <> 0   THEN RUN proc_initdataex.
      ELSE IF index(TRIM(wf_riskno),"no")   <> 0   THEN RUN proc_initdataex.
      ELSE IF index(TRIM(wf_riskno),"เลขที่") <> 0 THEN RUN proc_initdataex.
      ELSE DO:
          IF int(wf_riskno) = 0 AND int(wf_num) = 0 THEN DO: 
              IF wf_policyno = ""  THEN DO:
                  RUN proc_initdataex.
                  MESSAGE "Policy No. is not null " VIEW-AS ALERT-BOX .
                  RETURN NO-APPLY.
              END.
              ELSE RUN proc_ass_insdetail.
          END.
          ELSE DO: 
            FIND FIRST impdata_fil WHERE impdata_fil.policyno <> "" AND
                       impdata_fil.comdat   <> ?  AND 
                       impdata_fil.expdat   <> ?  AND 
                       impdata_fil.riskno   = 0   AND 
                       impdata_fil.itemno   = 0   NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL impdata_fil THEN RUN proc_ass_cardetail .
            ELSE DO:
                MESSAGE "ไม่พบข้อมูล Risk/item no 0/000 (ข้อมูลลูกค้า)" VIEW-AS ALERT-BOX.
                RETURN NO-APPLY.
                LEAVE.
            END.
          END.
          RUN proc_initdataex.
      END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assigninit72 C-Win 
PROCEDURE proc_assigninit72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*DO:
    ASSIGN fi_process = "Create data text file " + wf_chasno + " to impdata_fil ....." .
    DISP fi_process WITH FRAM fr_main.

    CREATE impdata_fil.
    CREATE imptxt_fil.
    CREATE impmemo_fil.
    CREATE impacc_fil.
    CREATE impinst_fil.
    ASSIGN
        impdata_fil.itemno        =  TRIM(wf_num)
        impdata_fil.policyno      =  " " /*trim(wf_policyno)*/        
        impdata_fil.n_branch      =  trim(wf_n_branch)        
        impdata_fil.agent         =  trim(wf_agent)           
        impdata_fil.producer      =  trim(wf_producer)        
        impdata_fil.n_delercode   =  trim(wf_n_delercode)   
        impdata_fil.fincode       =  trim(wf_fincode)   
        impdata_fil.appenno       =  trim(wf_appenno)   
        impdata_fil.salename      =  trim(wf_salename)   
        impdata_fil.srate         =  trim(wf_srate) 
        impdata_fil.comdat        =  date(wf_comdat)                                                        
        impdata_fil.expdat        =  date(wf_expdat)                                                        
        impdata_fil.agreedat      =  if trim(wf_agreedat) = "" and impdata_fil.prepol = "" then date(wf_comdat) 
                                 else if trim(wf_agreedat) <> "" then date(wf_agreedat)  ELSE ? 
        impdata_fil.firstdat      =  if trim(wf_firstdat) = "" and impdata_fil.prepol = "" then date(wf_comdat) 
                                 else if trim(wf_firstdat) <> "" then date(wf_firstdat)  ELSE ?  
        impdata_fil.packcod       =  trim(wf_packcod)   
        impdata_fil.camp_no       =  trim(wf_camp_no)   
        impdata_fil.campen        =  trim(wf_campen) 
        impdata_fil.specon        =  trim(wf_specon) 
        impdata_fil.product       =  trim(wf_product)   
        impdata_fil.promo         =  trim(wf_promo )   
        impdata_fil.rencnt        =  trim(wf_rencnt)   
        impdata_fil.prepol        =  trim(wf_prepol)
        impdata_fil.compul        =  trim(wf_compul) 
        impdata_fil.instyp        =  trim(wf_instyp) 
        impdata_fil.inslang       =  trim(wf_inslang )  
        impdata_fil.tiname        =  trim(wf_tiname) 
        impdata_fil.insnam        =  trim(wf_insnam) 
        impdata_fil.lastname      =  trim(wf_lastname)  
        impdata_fil.icno          =  trim(wf_icno ) 
        impdata_fil.insbr         =  trim(wf_insbr) 
        impdata_fil.occup         =  trim(wf_occup) 
        impdata_fil.addr          =  trim(wf_addr ) 
        impdata_fil.tambon        =  trim(wf_tambon) 
        impdata_fil.amper         =  trim(wf_amper) 
        impdata_fil.country       =  trim(wf_country )  
        impdata_fil.post          =  trim(wf_post ) 
        impdata_fil.provcod       =  trim(wf_provcod )  
        impdata_fil.distcod       =  trim(wf_distcod )  
        impdata_fil.sdistcod      =  IF trim(wf_sdistcod) <> "" AND LENGTH(wf_sdistcod) > 2 THEN SUBSTR(wf_sdistcod,1,2) ELSE TRIM(wf_sdistcod) 
        impdata_fil.gender        =  trim(wf_gender) 
        impdata_fil.tele1         =  trim(wf_tele1) 
        impdata_fil.tele2         =  trim(wf_tele2) 
        impdata_fil.mail1         =  trim(wf_mail1) 
        impdata_fil.mail2         =  trim(wf_mail2) 
        impdata_fil.mail3         =  trim(wf_mail3) 
        impdata_fil.mail4         =  trim(wf_mail4) 
        impdata_fil.mail5         =  trim(wf_mail5) 
        impdata_fil.mail6         =  trim(wf_mail6)  
        impdata_fil.mail7         =  trim(wf_mail7)  
        impdata_fil.mail8         =  trim(wf_mail8)  
        impdata_fil.mail9         =  trim(wf_mail9)  
        impdata_fil.mail10        =  trim(wf_mail10)  
        impdata_fil.fax           =  trim(wf_fax)  
        impdata_fil.lineID        =  trim(wf_lineID)  
        impdata_fil.name2         =  trim(wf_name2)  
        impdata_fil.name3         =  trim(wf_name3)  
        /*impdata_fil.benname       =  trim(wf_benname )  */
        impdata_fil.payercod      =  trim(wf_payercod)  
        impdata_fil.vatcode       =  trim(wf_vatcode )
        impdata_fil.covcod        =  trim(wf_covcod)  
        impdata_fil.garage        =  trim(wf_garage )  
        impdata_fil.special       =  trim(wf_special)  
        impdata_fil.inspec        =  trim(wf_inspec )  
        impdata_fil.class70       =  IF INDEX(wf_class70,".") <> 0 THEN trim(REPLACE(wf_class70,".","")) ELSE TRIM(wf_class70) 
        impdata_fil.brand         =  trim(wf_brand)  
        impdata_fil.model         =  trim(wf_model)  
        impdata_fil.submodel      =  trim(wf_submodel)  
        impdata_fil.yrmanu        =  trim(wf_caryear)  
        impdata_fil.chasno        =  trim(wf_chasno )  
        impdata_fil.eng           =  trim(wf_eng  )  
        impdata_fil.seat          =  if trim(wf_seat)  = "" then 0 else INTE(wf_seat)    
        impdata_fil.engcc         =  if trim(wf_engcc) = "" then 0 else INTE(wf_engcc)   
        impdata_fil.weight        =  if trim(wf_weight)= "" then 0 else DECI(wf_weight)    
        impdata_fil.watt          =  if trim(wf_watt)= ""   then 0 ELSE INTE(wf_watt)    
        impdata_fil.body          =  trim(wf_body )  
        impdata_fil.typ           =  trim(wf_type )  
        impdata_fil.re_year       =  trim(wf_re_year)  
        impdata_fil.vehreg        =  trim(wf_vehreg )  
        impdata_fil.re_country    =  trim(wf_re_country)
        impdata_fil.cargrp        =  trim(wf_cargrp )   
        impdata_fil.colorcar      =  trim(wf_colorcar )
        impdata_fil.fule          =  trim(wf_fule   )  
        impdata_fil.compolusory   =  trim(wf_compolusory)
        impdata_fil.stk           =  trim(wf_barcode)  
        impdata_fil.class72       =  IF INDEX(wf_class72,".") <> 0 THEN trim(REPLACE(wf_class72,".","")) ELSE TRIM(wf_class72)  
        impdata_fil.dstf72        =  trim(wf_dstf72 )  
        impdata_fil.dstfprem72    =  deci(wf_dstfprem72)   
        impdata_fil.premt72       =  deci(wf_premt72 )     
        impdata_fil.rstp_t72      =  deci(wf_rstp_t72)     
        impdata_fil.rtax_t72      =  deci(wf_rtax_t72)     
        impdata_fil.comper72      =  IF trim(wf_comper72)  =  " " THEN -1 ELSE deci(wf_comper72)          /* ค่าว่างใส่ -1 ดึง comm ตามระบบ  ถ้าระบุ 0 ไม่มีค่าคอม */                        
        impdata_fil.comprem72     =  IF trim(wf_comprem72) =  " " THEN -1 ELSE deci(wf_comprem72)   .    /* ค่าว่างใส่ -1 คำนวณ comm ตามระบบ ถ้าระบุ 0 ไม่มีค่าคอม */                      
    ASSIGN 
        impdata_fil.CLASS72       = IF LENGTH(impdata_fil.class72) < 3 THEN TRIM(impdata_fil.class72) + "0" ELSE TRIM(impdata_fil.class72)
        impdata_fil.poltyp        = "V72"
        impdata_fil.covcod        = "T" 
        impdata_fil.subclass      = IF trim(impdata_fil.class72) <> "" THEN TRIM(impdata_fil.class72) ELSE TRIM(impdata_fil.class70)
        impdata_fil.tariff        = "9"
        impdata_fil.vehuse        = IF trim(impdata_fil.subclass) <> "" THEN SUBSTR(impdata_fil.subclass,1,1) ELSE ""
        /*impdata_fil.seat41        = INTE(impdata_fil.seat) */ /*A64-0044*/
        impdata_fil.seat41        =  IF int(wf_ac2) <> 0 THEN int(wf_ac2) ELSE INTE(wf_seat) /*A64-0044*/
        impdata_fil.comment       = ""
        impdata_fil.entdat        = string(TODAY)                /*entry date*/
        impdata_fil.enttim        = STRING(TIME,"HH:MM:SS")    /*entry time*/
        impdata_fil.trandat       = STRING(fi_loaddat)          /*tran date*/
        impdata_fil.trantim       = STRING(TIME,"HH:MM:SS")    /*tran time*/
        impdata_fil.n_IMPORT      = "IM"
        /*impdata_fil.n_EXPORT      = "" */ . /*A64-0044*/
    
    /*IF impdata_fil.policyno = ""  THEN DO:
        IF ra_type = 1  THEN DO: 
            IF LENGTH(impdata_fil.chasno) > 10  THEN DO:
                IF impdata_fil.compolusory <> "" THEN ASSIGN impdata_fil.policyno = impdata_fil.compolusory. 
                ELSE ASSIGN impdata_fil.policyno = "N72" + STRING(int(impdata_fil.itemno),"999") + SUBSTRING(impdata_fil.chasno,10,LENGTH(impdata_fil.chasno)).
                /*IF impdata_fil.compul = "Y" THEN  */ /* A64-0309 */
                IF impdata_fil.compul = "Y" AND ra_poltyp = 3 THEN DO:  /* A64-0309 */ 
                     ASSIGN impdata_fil.cr_2 = "N70" + STRING(int(impdata_fil.itemno),"999") + SUBSTRING(impdata_fil.chasno,10,LENGTH(impdata_fil.chasno)).
                END. /* A64-0309 */ 
            END.
            ELSE DO:
                IF impdata_fil.compolusory <> "" THEN ASSIGN impdata_fil.policyno = impdata_fil.compolusory. 
                ELSE ASSIGN impdata_fil.policyno = "N72" + STRING(int(impdata_fil.itemno),"999") + TRIM(impdata_fil.chasno).
                /*IF impdata_fil.compul = "Y" THEN  */ /* A64-0309 */
                IF impdata_fil.compul = "Y" AND ra_poltyp = 3 THEN DO:  /* A64-0309 */ 
                    ASSIGN impdata_fil.cr_2 = "N70" + STRING(int(impdata_fil.itemno),"999") + TRIM(impdata_fil.chasno).
                END. /* A64-0309 */ 
            END.
        END.
        ELSE DO: 
            IF impdata_fil.chasno <> "" THEN DO: 
                IF LENGTH(impdata_fil.chasno) > 10 THEN DO:
                    IF impdata_fil.compolusory <> "" THEN ASSIGN impdata_fil.policyno = impdata_fil.compolusory. 
                    ELSE ASSIGN impdata_fil.policyno = "R72" + STRING(int(impdata_fil.itemno),"999") + SUBSTRING(impdata_fil.chasno,10,LENGTH(impdata_fil.chasno)). 

                    /*IF impdata_fil.compul = "Y" THEN  */ /* A64-0309 */
                    IF impdata_fil.compul = "Y" AND ra_poltyp = 3 THEN DO:  /* A64-0309 */  
                            ASSIGN impdata_fil.cr_2 = "R70" + STRING(int(impdata_fil.itemno),"999") + SUBSTRING(impdata_fil.chasno,10,LENGTH(impdata_fil.chasno)).
                    END.  /* A64-0309 */
                END.
                ELSE DO:
                    IF impdata_fil.compolusory <> "" THEN ASSIGN impdata_fil.policyno = impdata_fil.compolusory. 
                    ELSE ASSIGN impdata_fil.policyno = "R72" + STRING(int(impdata_fil.itemno),"999") + TRIM(impdata_fil.chasno). 

                    /*IF impdata_fil.compul = "Y" THEN  */ /* A64-0309 */
                    IF impdata_fil.compul = "Y" AND ra_poltyp = 3 THEN DO:  /* A64-0309 */
                        ASSIGN impdata_fil.cr_2 = "R70" + STRING(int(impdata_fil.itemno),"999") + TRIM(impdata_fil.chasno).
                    END.  /* A64-0309 */
                END.
            END.
            ELSE DO: 
                IF impdata_fil.compolusory <> "" THEN ASSIGN impdata_fil.policyno = impdata_fil.compolusory. 
                ELSE ASSIGN impdata_fil.policyno = "R72" + STRING(int(impdata_fil.itemno),"999") + TRIM(impdata_fil.prepol).

                /*IF impdata_fil.compul = "Y" THEN  */ /* A64-0309 */
                IF impdata_fil.compul = "Y" AND ra_poltyp = 3 THEN DO:  /* A64-0309 */ 
                    ASSIGN impdata_fil.cr_2 = "R70" + STRING(int(impdata_fil.itemno),"999") + TRIM(impdata_fil.prepol).
                END.  /* A64-0309 */
            END.
        END.
    END.*/
    RUN proc_assigninit70_2.

   RELEASE impdata_fil.
   RELEASE imptxt_fil.
   RELEASE impmemo_fil.
   RELEASE impacc_fil.
   RELEASE impinst_fil.
END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assignrenew C-Win 
PROCEDURE proc_assignrenew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN 
    n_policy72     = ""
    np_prepol      = ""
    n_brand1       = ""
    n_body         = ""
    nn_redbook     = ""
    n_Engine       = ""
    n_Tonn70       = "".

RUN proc_initrenew.

IF NOT CONNECTED("sic_exp") THEN RUN proc_sic_exp2.

IF CONNECTED("sic_exp") THEN DO:

    ASSIGN fi_process = "Import data From Expiry " + impdata_fil.policyno + "...." .
    DISP fi_process WITH FRAM fr_main.

    RUN wgw\wgwexemp(INPUT-OUTPUT  impdata_fil.prepol,                      
                     INPUT-OUTPUT  re_rencnt ,                          
                     INPUT-OUTPUT  re_branch /*impdata_fil.n_branch*/ ,     
                     INPUT-OUTPUT  re_agent      ,                      
                     INPUT-OUTPUT  re_producer   ,                      
                     INPUT-OUTPUT  re_delercode,                        
                     INPUT-OUTPUT  re_fincode    ,                      
                     INPUT-OUTPUT  re_payercod   ,                      
                     INPUT-OUTPUT  re_vatcode    ,                      
                     INPUT-OUTPUT  re_insref /*impdata_fil.nv_insref*/ ,    
                     INPUT-OUTPUT  re_tiname,                           
                     INPUT-OUTPUT  re_insnam,                           
                     INPUT-OUTPUT  re_lastname,                         
                     INPUT-OUTPUT  re_name2,                            
                     INPUT-OUTPUT  re_name3,                            
                     INPUT-OUTPUT  re_n_addr1,                          
                     INPUT-OUTPUT  re_n_addr2,                          
                     INPUT-OUTPUT  re_n_addr3,                          
                     INPUT-OUTPUT  re_n_addr4,                          
                     INPUT-OUTPUT  re_post    ,                         
                     INPUT-OUTPUT  re_provcod ,                         
                     INPUT-OUTPUT  re_distcod ,                         
                     INPUT-OUTPUT  re_sdistcod,                         
                     INPUT-OUTPUT  re_firstdat /*impdata_fil.firstdat*/ ,   
                     INPUT-OUTPUT  re_comdat,                           
                     INPUT-OUTPUT  re_expdat,                           
                     INPUT-OUTPUT  re_class,                            
                     INPUT-OUTPUT  nn_redbook,                          
                     INPUT-OUTPUT  re_moddes,                           
                     INPUT-OUTPUT  re_yrmanu,                           
                     INPUT-OUTPUT  re_cargrp /*impdata_fil.cargrp*/ ,       
                     INPUT-OUTPUT  n_body,                              
                     INPUT-OUTPUT  n_Engine,                            
                     INPUT-OUTPUT  n_Tonn70,                            
                     INPUT-OUTPUT  re_seats,                            
                     INPUT-OUTPUT  re_vehuse,                           
                     INPUT-OUTPUT  re_covcod,                           
                     INPUT-OUTPUT  re_garage,                           
                     INPUT-OUTPUT  re_vehreg,                           
                     INPUT-OUTPUT  re_cha_no,                           
                     INPUT-OUTPUT  re_eng_no,                           
                     INPUT-OUTPUT  re_uom1_v,                           
                     INPUT-OUTPUT  re_uom2_v,                           
                     INPUT-OUTPUT  re_uom5_v,                           
                     INPUT-OUTPUT  re_si,
                     INPUT-OUTPUT  re_baseprm, 
                     INPUT-OUTPUT  re_base3 , /*A64-0257*/
                     INPUT-OUTPUT  re_41,                               
                     INPUT-OUTPUT  re_42,                               
                     INPUT-OUTPUT  re_43,                               
                     INPUT-OUTPUT  re_seat41,                           
                     INPUT-OUTPUT  re_dedod,                            
                     INPUT-OUTPUT  re_addod,                            
                     INPUT-OUTPUT  re_dedpd,                            
                     INPUT-OUTPUT  re_flet_per,                         
                     INPUT-OUTPUT  re_ncbper,                           
                     INPUT-OUTPUT  re_dss_per,                          
                     INPUT-OUTPUT  re_stf_per,                          
                     INPUT-OUTPUT  re_cl_per,                           
                     INPUT-OUTPUT  re_bennam1,
                     INPUT-OUTPUT  re_premt,
                     INPUT-OUTPUT  re_comm ,
                     INPUT-OUTPUT  re_driver,
                     INPUT-OUTPUT  re_prmtdriv,
                     INPUT-OUTPUT  re_acctxt,
                     INPUT-OUTPUT  re_adj,
                     INPUT-OUTPUT  re_chkdriv ,
                     input-output  re_chkmemo,
                     input-output  re_chktxt, 
                     INPUT-OUTPUT  re_comment).  

    IF ra_match = 1 THEN DO:
        IF re_adj   = "NO"            THEN ASSIGN impdata_fil.comment = impdata_fil.comment + "| ยังไม่มีการปรับใบเตือน Adj = NO " .
        IF re_premt <> impdata_fil.premt  THEN ASSIGN impdata_fil.comment = impdata_fil.comment + "| เบี้ยใบเตือน " + string(re_premt,">>>>>>9.99") + 
                                                                    " ไม่เท่ากับไฟล์ " + STRING(impdata_fil.premt,">>>>>>9.99").
        IF deci(impdata_fil.si) <> 0      AND deci(impdata_fil.si)     <> deci(re_si) THEN impdata_fil.comment = impdata_fil.comment + "| ทุนประกันในไฟล์และใบเตือนไม่เท่ากัน " .
        IF deci(impdata_fil.siplus) <> 0  AND deci(impdata_fil.siplus) <> deci(re_si) THEN impdata_fil.comment = impdata_fil.comment + "| ทุนประกันในไฟล์และใบเตือนไม่เท่ากัน " .
        IF impdata_fil.covcod <> "" AND impdata_fil.covcod <> re_covcod THEN impdata_fil.comment = impdata_fil.comment + "| ความคุ้มครองในไฟล์และใบเตือนไม่เท่ากัน " .

        IF re_comment <> ""   THEN ASSIGN impdata_fil.comment = impdata_fil.comment + "| " + re_comment .
        ELSE DO:
            ASSIGN np_prepol = impdata_fil.prepol
                   n_policy  = impdata_fil.cr_2
                   n_brand1  = impdata_fil.brand.
            IF impdata_fil.cr_2 <> "" THEN DO: /* ใส่ข้อมูลให้ พรบ. */
               FIND LAST impdata_fil WHERE impdata_fil.policy = n_policy AND impdata_fil.covcod = "T" NO-LOCK no-error .
                IF AVAIL impdata_fil THEN DO:
                   RUN proc_updaterenew.
                IF impdata_fil.class72 = "" THEN RUN proc_chkclass72.
               END.
            END.
            FIND LAST impdata_fil WHERE impdata_fil.prepol = np_prepol AND impdata_fil.covcod <> "T" NO-LOCK NO-ERROR . /* ใส่ข้อมูลให้ กธ. */
            IF AVAIL impdata_fil THEN DO:
                     RUN proc_updaterenew.
            END.
        END.
    END.
    ELSE DO:
        IF      re_chkdriv <> ""  AND int(impdata_fil.drivnam) <> 0  THEN impdata_fil.comment = impdata_fil.comment + "| เช็คข้อมูลผู้ขับขี่ในระบบ กับไฟล์".
        ELSE IF re_chkdriv <> ""  AND int(impdata_fil.drivnam)  = 0  THEN impdata_fil.comment = impdata_fil.comment + "| เช็คข้อมูลผู้ขับขี่ในระบบ กับไฟล์".
        ELSE IF re_chkdriv = ""   AND int(impdata_fil.drivnam) <> 0  THEN impdata_fil.comment = impdata_fil.comment + "| เช็คข้อมูลผู้ขับขี่ในระบบ กับไฟล์".
        
        IF re_acctxt  <> "" THEN  impdata_fil.comment = impdata_fil.comment + "| เช็คข้อมูล Accessory Text ในระบบกับไฟล์".
        IF re_chkmemo <> "" then  impdata_fil.comment = impdata_fil.comment + "| เช็คข้อมูล Memo Text ในระบบกับไฟล์".
        IF re_chktxt  <> "" then  impdata_fil.comment = impdata_fil.comment + "| เช็คข้อมูล Policy Text ในระบบกับไฟล์".
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign_ex C-Win 
PROCEDURE proc_assign_ex :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN fi_process = "Create data text file ....".
DISP fi_process WITH FRAM fr_main.
For each  impdata_fil USE-INDEX data_fil10 WHERE 
    impdata_fil.usrid  = USERID(LDBNAME(1)) AND 
    impdata_fil.progid = nv_proid :
    DELETE  impdata_fil.
End.
For each  imptxt_fil USE-INDEX txt_fil02 WHERE 
    imptxt_fil.usrid  = USERID(LDBNAME(1)) AND 
    imptxt_fil.progid = nv_proid :
    DELETE  imptxt_fil.
End.
For each  impmemo_fil USE-INDEX memo_fil02 WHERE 
    impmemo_fil.usrid  = USERID(LDBNAME(1)) AND 
    impmemo_fil.progid = nv_proid :
    DELETE  impmemo_fil.
End.
For each  impacc_fil USE-INDEX acc_fil02 WHERE 
    impacc_fil.usrid  = USERID(LDBNAME(1)) AND 
    impacc_fil.progid = nv_proid :
    DELETE  impacc_fil.
End.
For each  impinst_fil USE-INDEX inst_fil02 WHERE 
    impinst_fil.usrid  = USERID(LDBNAME(1)) AND 
    impinst_fil.progid = nv_proid :
    DELETE  impinst_fil.
End.
/* A67-0029*/
For each  impdriv_fil USE-INDEX driv_fil05 WHERE 
    impdriv_fil.usrid  = USERID(LDBNAME(1)) AND 
    impdriv_fil.progid = nv_proid :
    DELETE  impdriv_fil.
End.
/* end : A67-0029*/
FOR EACH wuwd132:
    DELETE wuwd132.
END.
FOR EACH wuwd100:
    DELETE wuwd100.
END.
FOR EACH wuwd102:
    DELETE wuwd102.
END.
FOR EACH ws0m009:
    DELETE ws0m009.
END.

RUN proc_assigndata.  /* ลูกค้า */
/*RUN proc_assigndata2.*/ /* ความคุ้มครอง รถ */

RUN proc_assign2.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_ass_cardetail C-Win 
PROCEDURE proc_ass_cardetail :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF BUFFER bfimpdata_fil FOR impdata_fil.
DO:
 ASSIGN fi_process = "Create data Risk/Item ." + wf_riskno + "/" + wf_num + " " + wf_chasno + " to impdata_fil ....." .
 DISP fi_process WITH FRAM fr_main.

 FIND FIRST bfimpdata_fil WHERE bfimpdata_fil.policyno <> "" AND
            bfimpdata_fil.comdat   <> ?  AND 
            bfimpdata_fil.expdat   <> ?  and
            bfimpdata_fil.riskno   = 0   AND
            bfimpdata_fil.itemno   = 0   NO-LOCK NO-ERROR NO-WAIT.
 IF AVAIL bfimpdata_fil THEN DO:
     FIND LAST impdata_fil WHERE impdata_fil.policy = bfimpdata_fil.policyno AND 
                impdata_fil.riskno = int(wf_riskno)  AND
                impdata_fil.itemno = int(wf_num)     AND
                impdata_fil.chasno = trim(wf_chasno) NO-LOCK NO-ERROR .
     IF NOT AVAIL impdata_fil THEN DO:
         CREATE impdata_fil.
         CREATE impacc_fil.
         CREATE impdriv_fil. /*A67-0029*/
         ASSIGN
             impdata_fil.policyno  =  bfimpdata_fil.policyno     
             impdata_fil.n_branch  =  bfimpdata_fil.n_branch      
             impdata_fil.agent     =  bfimpdata_fil.agent         
             impdata_fil.producer  =  bfimpdata_fil.producer      
             impdata_fil.n_delercode   =  bfimpdata_fil.n_delercode 
             impdata_fil.fincode   =  bfimpdata_fil.fincode    
             impdata_fil.appenno   =  bfimpdata_fil.appenno    
             impdata_fil.salename  =  bfimpdata_fil.salename   
             impdata_fil.srate     =  bfimpdata_fil.srate      
             impdata_fil.comdat    =  bfimpdata_fil.comdat                                      
             impdata_fil.expdat    =  bfimpdata_fil.expdat                                      
             impdata_fil.agreedat  =  bfimpdata_fil.agreedat  
             impdata_fil.firstdat  =  bfimpdata_fil.firstdat  
             impdata_fil.packcod   =  bfimpdata_fil.packcod   
             impdata_fil.camp_no   =  bfimpdata_fil.camp_no   
             impdata_fil.campen    =  bfimpdata_fil.campen    
             impdata_fil.specon    =  bfimpdata_fil.specon    
             impdata_fil.product   =  bfimpdata_fil.product   
             impdata_fil.promo     =  bfimpdata_fil.promo     
             impdata_fil.rencnt    =  bfimpdata_fil.rencnt    
             impdata_fil.prepol    =  bfimpdata_fil.prepol    
             impdata_fil.compul    =  bfimpdata_fil.compul    
             impdata_fil.insref    =  bfimpdata_fil.insref    
             impdata_fil.instyp    =  bfimpdata_fil.instyp    
             impdata_fil.inslang   =  bfimpdata_fil.inslang   
             impdata_fil.tiname    =  bfimpdata_fil.tiname    
             impdata_fil.insnam    =  bfimpdata_fil.insnam    
             impdata_fil.lastname  =  bfimpdata_fil.lastname  
             impdata_fil.icno      =  bfimpdata_fil.icno      
             impdata_fil.insbr     =  bfimpdata_fil.insbr     
             impdata_fil.occup     =  bfimpdata_fil.occup     
             impdata_fil.addr      =  bfimpdata_fil.addr      
             impdata_fil.tambon    =  bfimpdata_fil.tambon    
             impdata_fil.amper     =  bfimpdata_fil.amper     
             impdata_fil.country   =  bfimpdata_fil.country   
             impdata_fil.post      =  bfimpdata_fil.post      
             impdata_fil.provcod   =  bfimpdata_fil.provcod   
             impdata_fil.distcod   =  bfimpdata_fil.distcod   
             impdata_fil.sdistcod  =  bfimpdata_fil.sdistcod 
             impdata_fil.jpae      =  bfimpdata_fil.jpae 
             impdata_fil.jpjtl     =  bfimpdata_fil.jpjtl
             impdata_fil.jpts      =  bfimpdata_fil.jpts 
             impdata_fil.gender    =  bfimpdata_fil.gender    
             impdata_fil.tele1     =  bfimpdata_fil.tele1     
             impdata_fil.tele2     =  bfimpdata_fil.tele2     
             impdata_fil.mail1     =  bfimpdata_fil.mail1     
             impdata_fil.mail2     =  bfimpdata_fil.mail2     
             impdata_fil.mail3     =  bfimpdata_fil.mail3     
             impdata_fil.mail4     =  bfimpdata_fil.mail4     
             impdata_fil.mail5     =  bfimpdata_fil.mail5     
             impdata_fil.mail6     =  bfimpdata_fil.mail6     
             impdata_fil.mail7     =  bfimpdata_fil.mail7     
             impdata_fil.mail8     =  bfimpdata_fil.mail8     
             impdata_fil.mail9     =  bfimpdata_fil.mail9     
             impdata_fil.mail10    =  bfimpdata_fil.mail10    
             impdata_fil.fax       =  bfimpdata_fil.fax       
             impdata_fil.lineID    =  bfimpdata_fil.lineID    
             impdata_fil.name2     =  bfimpdata_fil.name2     
             impdata_fil.name3     =  bfimpdata_fil.name3     
             impdata_fil.payercod  =  bfimpdata_fil.payercod  
             impdata_fil.vatcode   =  bfimpdata_fil.vatcode   
             impdata_fil.poltyp    =  bfimpdata_fil.poltyp
             impdata_fil.instot    =  bfimpdata_fil.instot
             impdata_fil.usrid     =  bfimpdata_fil.usrid 
             impdata_fil.progid    =  bfimpdata_fil.progid
             impdata_fil.comment   =  ""
             impdata_fil.entdat    =  string(TODAY)               /*entry date*/
             impdata_fil.enttim    =  STRING(TIME, "HH:MM:SS")    /*entry time*/
             impdata_fil.trandat   =  STRING(fi_loaddat)          /*tran date*/
             impdata_fil.trantim   =  STRING(TIME, "HH:MM:SS") .  /*tran time*/
         ASSIGN                    
             impdata_fil.riskno    =  INT(wf_riskno)
             impdata_fil.itemno    =  INT(wf_num)
             impdata_fil.benname   =  trim(wf_benname)  /*A65-0043*/
             impdata_fil.covcod    =  trim(wf_covcod )  
             impdata_fil.garage    =  trim(wf_garage )  
             impdata_fil.special   =  trim(wf_special)  
             impdata_fil.inspec    =  trim(wf_inspec )  
             impdata_fil.class70   =  trim(wf_class70)  
             impdata_fil.vehuse    =  trim(wf_vehuse)
             impdata_fil.redbook   =  TRIM(wf_redbook) /* Ranu : A65-0079*/
             impdata_fil.brand     =  trim(wf_brand)  
             impdata_fil.model     =  trim(wf_model)  
             impdata_fil.submodel  =  trim(wf_submodel)  
             impdata_fil.yrmanu    =  trim(wf_caryear)  
             impdata_fil.chasno    =  trim(wf_chasno)  
             impdata_fil.eng       =  trim(wf_eng)
             impdata_fil.eng_no2   =  trim(wf_eng_no2) /* A67-0029*/
             impdata_fil.seat      =  INTE(wf_seat)  
             impdata_fil.engcc     =  INTE(wf_engcc)  
             impdata_fil.weight    =  DECI(wf_weight) 
             impdata_fil.watt      =  INTE(wf_watt)  
             impdata_fil.body      =  trim(wf_body )  
             impdata_fil.typ       =  trim(wf_type )  
             impdata_fil.re_year   =  trim(wf_re_year)  
             impdata_fil.vehreg    =  trim(wf_vehreg )  
             impdata_fil.re_country =  trim(wf_re_country)
             impdata_fil.cargrp    =  trim(wf_cargrp )   
             impdata_fil.colorcar  =  trim(wf_colorcar )
             impdata_fil.fule      =  trim(wf_fule)   
             impdata_fil.drivnam   =  trim(wf_drivnam)   
             impdata_fil.baseplus  =  DECI(wf_baseplus)  
             impdata_fil.siplus    =  DECI(wf_siplus)
             impdata_fil.rs10      =  DECI(wf_rs10)   
             impdata_fil.comper    =  if trim(wf_comper)   = "U"  then 999999999  else INT(wf_comper)  
             impdata_fil.comacc    =  if trim(wf_comacc)   = "U"  then 999999999  else INT(wf_comacc)  
             impdata_fil.deductpd  =  if trim(wf_deductpd) = "U"  then 999999999  else INT(wf_deductpd)  
             impdata_fil.DOD       =  DECI(wf_DOD)
             impdata_fil.dgatt     =  DECI(wf_dod1)  /*A65-0079*/
             impdata_fil.DPD       =  DECI(wf_DPD)
             impdata_fil.maksi     =  DECI(wf_maksi) /*A67-0029*/
             impdata_fil.si        =  DECI(wf_tpfire) 
             impdata_fil.NO_411    =  IF trim(wf_no_411) = "" THEN (-1) ELSE DECI(wf_NO_411 )  /* A65-0079*/
             impdata_fil.seat41    =  IF INTE(wf_ac2) <> 0 THEN INTE(wf_ac2) + 1 ELSE INTE(wf_seat) 
             impdata_fil.NO_412    =  IF trim(wf_no_412) = "" THEN (-1) ELSE DECI(wf_NO_412)      /*A65-0079*/ 
             impdata_fil.NO_413    =  DECI(wf_NO_413)   
             impdata_fil.pass_no   =  DECI(wf_ac6)   
             impdata_fil.NO_414    =  DECI(wf_NO_414)
             impdata_fil.NO_42     =  if trim(wf_no_42) = "" then (-1) else  DECI(wf_NO_42) /*A65-0079*/ 
             impdata_fil.NO_43     =  if trim(wf_no_43) = "" then (-1) else  DECI(wf_NO_43) /*A65-0079*/ 
             impdata_fil.base      =  DECI(wf_base)
             impdata_fil.unname    =  deci(wf_unname) 
             impdata_fil.nname     =  deci(wf_nname) 
             impdata_fil.tpbi      =  deci(wf_tpbi) 
             impdata_fil.dgsi      =  DECI(wf_tpbiocc) /*A65-0079*/
             impdata_fil.tppd      =  deci(wf_tppd) 
             impdata_fil.int1      =  int(wf_dodamt)   /*A65-0079*/
             impdata_fil.int2      =  int(wf_dod1amt)  /*A65-0079*/
             impdata_fil.int3      =  int(wf_dpdamt)   /*A65-0079*/
             impdata_fil.ry01      =  deci(wf_ry01)
             impdata_fil.deci1     =  deci(wf_ry412)   /*A65-0079*/
             impdata_fil.deci2     =  deci(wf_ry413)   /*A65-0079*/
             impdata_fil.deci3     =  deci(wf_ry414)   /*A65-0079*/
             impdata_fil.ry02      =  deci(wf_ry02)   
             impdata_fil.ry03      =  deci(wf_ry03)   
             impdata_fil.fleet     =  trim(wf_fleet)   
             impdata_fil.ncb       =  trim(wf_ncb)
             impdata_fil.claim     =  trim(wf_claim)   
             impdata_fil.dspc      =  trim(wf_dspc)   
             impdata_fil.cctv      =  trim(wf_cctv)   
             impdata_fil.dstf      =  trim(wf_dstf)   
             impdata_fil.fleetprem =  deci(wf_fleetprem)
             impdata_fil.ncbprem   =  deci(wf_ncbprem)   
             impdata_fil.clprem    =  deci(wf_clprem )   
             impdata_fil.dspcprem  =  deci(wf_dspcprem) 
             impdata_fil.cctvprem  =  deci(wf_cctvprem) 
             impdata_fil.dstfprem  =  deci(wf_dstfprem) 
             impdata_fil.premt     =  deci(wf_premt )   
             impdata_fil.rstp_t    =  deci(wf_rstp_t)   
             impdata_fil.rtax_t    =  deci(wf_rtax_t)   
             impdata_fil.comper70  =  IF trim(wf_comper70)  =  " " THEN (-1) ELSE deci(wf_comper70)    /* ค่าว่างใส่ -1 ดึง comm ตามระบบ  ถ้าระบุ 0 ไม่มีค่าคอม */
             impdata_fil.comprem70 =  IF trim(wf_comprem70) =  " " THEN (-1) ELSE deci(wf_comprem70)  /* ค่าว่างใส่ -1 คำนวณ comm ตามระบบ ถ้าระบุ 0 ไม่มีค่าคอม */
             impdata_fil.agco70    =  trim(wf_agco70 )  
             impdata_fil.comco_per70   =  deci(wf_comco_per70) 
             impdata_fil.comco_prem70  =  deci(wf_comco_prem70)
             impdata_fil.cltxt     = trim(wf_cltxt )
             impdata_fil.clamount  = inte(wf_clamount)
             impdata_fil.faultno   = inte(wf_faultno)  
             impdata_fil.faultprm  = inte(wf_faultprm)  
             impdata_fil.goodno    = inte(wf_goodno)  
             impdata_fil.goodprm   = inte(wf_goodprm)  
             impdata_fil.loss      = inte(wf_loss) 
             impdata_fil.prempa    = IF LENGTH(impdata_fil.class70) = 5 THEN SUBSTR(impdata_fil.class70,1,1)                                                       
                                     ELSE IF LENGTH(impdata_fil.class70) = 4 AND SUBSTR(impdata_fil.class70,4,1) <> "E" THEN SUBSTR(impdata_fil.class70,1,1)                   
                                     ELSE TRIM(fi_pack)                                                                                            
             impdata_fil.subclass  = IF LENGTH(impdata_fil.class70) = 5 THEN SUBSTR(impdata_fil.class70,2,4)                                                       
                                     ELSE IF LENGTH(impdata_fil.class70) = 4 AND SUBSTR(impdata_fil.class70,4,1) <> "E" THEN SUBSTR(impdata_fil.class70,2,3) 
                                     ELSE impdata_fil.class70     
             impdata_fil.dspc      = IF DECI(wf_dspc) = 0 THEN wf_cctv ELSE string(DECI(wf_dspc) + DECI(wf_cctv))  /* ranu 21/01/22*/
             impdata_fil.dspcprem  = IF deci(wf_dspcprem) = 0 THEN deci(wf_cctvprem) ELSE DECI(wf_dspcprem) + DECI(wf_cctvprem) /*A65-0079*/
             /* a67-0029 */
             impdata_fil.battno    = trim(wf_battno)   
             /*impdata_fil.battyr    = INTE(wf_battyr)   */
             impdata_fil.battyr    = IF index(impdata_fil.subclass,"E") <> 0 AND TRIM(wf_battyr) = "" THEN INTE(impdata_fil.yrmanu) ELSE INTE(wf_battyr)  
             impdata_fil.battprice = DECI(wf_battprice)
             /*impdata_fil.battper   = INTE(wf_battper)*/
             impdata_fil.battrate  = DECI(wf_battrate)
             impdata_fil.battsi    = DECI(wf_battsi)
             impdata_fil.battprm   = DECI(wf_battprm) 
             impdata_fil.chargno   = trim(wf_chargno) 
             impdata_fil.chargsi   = DECI(wf_chargsi) 
             impdata_fil.chargrate = INTE(wf_chargrate) 
             impdata_fil.chargprm  = DECI(wf_chargprm) 
             /* end aa67-0029*/
             impdata_fil.txt1      = trim(wf_31rate) /*A68-0044*/
             impdata_fil.txt2      = trim(wf_31prmt) /*A68-0044*/
             impdata_fil.tariff    = "X"
             impdata_fil.n_IMPORT  = "CAR".
             ASSIGN                
             impacc_fil.policyno   =  TRIM(bfimpdata_fil.policyno)
             impacc_fil.riskno     =  int(wf_riskno)
             impacc_fil.itemno     =  int(wf_num)
             impacc_fil.accdata1   =  trim(wf_accdata1)   
             impacc_fil.accdata2   =  trim(wf_accdata2)   
             impacc_fil.accdata3   =  trim(wf_accdata3)   
             impacc_fil.accdata4   =  trim(wf_accdata4)   
             impacc_fil.accdata5   =  trim(wf_accdata5)   
             impacc_fil.accdata6   =  trim(wf_accdata6)   
             impacc_fil.accdata7   =  trim(wf_accdata7)   
             impacc_fil.accdata8   =  trim(wf_accdata8)  
             impacc_fil.accdata9   =  trim(wf_accdata9)  
             impacc_fil.accdata10  =  trim(wf_accdata10)
             impacc_fil.usrid      =  trim(bfimpdata_fil.usrid)    
             impacc_fil.progid     =  trim(bfimpdata_fil.progid) .
             ASSIGN 
             impdriv_fil.policy    = TRIM(bfimpdata_fil.policyno)              
             impdriv_fil.riskno    = int(wf_riskno)                         
             impdriv_fil.itemno    = int(wf_num)                   
             impdriv_fil.drivnam   = trim(wf_drivnam) .
             RUN proc_ass_driver.

             IF int(wf_num) = 1 THEN DO:
                 RUN proc_ass_cardetail2.
                 RELEASE impinst_fil .
             END.
     END.
 END.
 RELEASE impdata_fil.
 RELEASE impacc_fil.
 RELEASE impdriv_fil.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_ass_cardetail2 C-Win 
PROCEDURE proc_ass_cardetail2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF BUFFER bfimpinst_fil   FOR impinst_fil.

FIND FIRST bfimpinst_fil WHERE bfimpinst_fil.policy = impdata_fil.policyno NO-LOCK NO-ERROR .
    IF AVAIL bfimpinst_fil  THEN DO: 
        CREATE impinst_fil.
        ASSIGN 
        impinst_fil.policyno        =  TRIM(impdata_fil.policyno)
        impinst_fil.riskno          =  impdata_fil.riskno
        impinst_fil.itemno          =  impdata_fil.itemno
        impinst_fil.instot          =  bfimpinst_fil.instot
        impinst_fil.instcod1        =  trim(bfimpinst_fil.instcod1)  
        impinst_fil.insttyp1        =  trim(bfimpinst_fil.insttyp1)  
        impinst_fil.insttitle1      =  trim(bfimpinst_fil.insttitle1)
        impinst_fil.instname1       =  trim(bfimpinst_fil.instname1 )
        impinst_fil.instlname1      =  trim(bfimpinst_fil.instlname1)
        impinst_fil.instic1         =  trim(bfimpinst_fil.instic1)   
        impinst_fil.instbr1         =  trim(bfimpinst_fil.instbr1)   
        impinst_fil.instaddr11      =  trim(bfimpinst_fil.instaddr11)
        impinst_fil.instaddr21      =  trim(bfimpinst_fil.instaddr21)
        impinst_fil.instaddr31      =  trim(bfimpinst_fil.instaddr31)
        impinst_fil.instaddr41      =  trim(bfimpinst_fil.instaddr41)
        impinst_fil.instpost1       =  trim(bfimpinst_fil.instpost1 )
        impinst_fil.instprovcod1    =  trim(bfimpinst_fil.instprovcod1 ) 
        impinst_fil.instdistcod1    =  trim(bfimpinst_fil.instdistcod1 ) 
        impinst_fil.instsdistcod1   =  trim(bfimpinst_fil.instsdistcod1) 
        impinst_fil.instprm1        =  deci(bfimpinst_fil.instprm1)  
        impinst_fil.instrstp1       =  deci(bfimpinst_fil.instrstp1 )  
        impinst_fil.instrtax1       =  deci(bfimpinst_fil.instrtax1 )  
        impinst_fil.instcomm01      =  deci(bfimpinst_fil.instcomm01)  
        impinst_fil.instcomm12      =  deci(bfimpinst_fil.instcomm12)  
        impinst_fil.instcod2        =  trim(bfimpinst_fil.instcod2)  
        impinst_fil.insttyp2        =  trim(bfimpinst_fil.insttyp2)  
        impinst_fil.insttitle2      =  trim(bfimpinst_fil.insttitle2)  
        impinst_fil.instname2       =  trim(bfimpinst_fil.instname2 )  
        impinst_fil.instlname2      =  trim(bfimpinst_fil.instlname2)  
        impinst_fil.instic2         =  trim(bfimpinst_fil.instic2 )  
        impinst_fil.instbr2         =  trim(bfimpinst_fil.instbr2 )  
        impinst_fil.instaddr12      =  trim(bfimpinst_fil.instaddr12)  
        impinst_fil.instaddr22      =  trim(bfimpinst_fil.instaddr22)  
        impinst_fil.instaddr32      =  trim(bfimpinst_fil.instaddr32)  
        impinst_fil.instaddr42      =  trim(bfimpinst_fil.instaddr42)  
        impinst_fil.instpost2       =  trim(bfimpinst_fil.instpost2 )  
        impinst_fil.instprovcod2    =  trim(bfimpinst_fil.instprovcod2 ) 
        impinst_fil.instdistcod2    =  trim(bfimpinst_fil.instdistcod2 ) 
        impinst_fil.instsdistcod2   =  trim(bfimpinst_fil.instsdistcod2) 
        impinst_fil.instprm2        =  deci(bfimpinst_fil.instprm2 ) 
        impinst_fil.instrstp2       =  deci(bfimpinst_fil.instrstp2) 
        impinst_fil.instrtax2       =  deci(bfimpinst_fil.instrtax2) 
        impinst_fil.instcomm02      =  deci(bfimpinst_fil.instcomm02)
        impinst_fil.instcomm22      =  deci(bfimpinst_fil.instcomm22)
        impinst_fil.instcod3        =  trim(bfimpinst_fil.instcod3) 
        impinst_fil.insttyp3        =  trim(bfimpinst_fil.insttyp3) 
        impinst_fil.insttitle3      =  trim(bfimpinst_fil.insttitle3)
        impinst_fil.instname3       =  trim(bfimpinst_fil.instname3) 
        impinst_fil.instlname3      =  trim(bfimpinst_fil.instlname3)
        impinst_fil.instic3         =  trim(bfimpinst_fil.instic3)  
        impinst_fil.instbr3         =  trim(bfimpinst_fil.instbr3)  
        impinst_fil.instaddr13      =  trim(bfimpinst_fil.instaddr13)
        impinst_fil.instaddr23      =  trim(bfimpinst_fil.instaddr23)
        impinst_fil.instaddr33      =  trim(bfimpinst_fil.instaddr33)
        impinst_fil.instaddr43      =  trim(bfimpinst_fil.instaddr43)
        impinst_fil.instpost3       =  trim(bfimpinst_fil.instpost3 )  
        impinst_fil.instprovcod3    =  trim(bfimpinst_fil.instprovcod3) 
        impinst_fil.instdistcod3    =  trim(bfimpinst_fil.instdistcod3) 
        impinst_fil.instsdistcod3   =  trim(bfimpinst_fil.instsdistcod3) 
        impinst_fil.instprm3        =  deci(bfimpinst_fil.instprm3)  
        impinst_fil.instrstp3       =  deci(bfimpinst_fil.instrstp3 )
        impinst_fil.instrtax3       =  deci(bfimpinst_fil.instrtax3 )
        impinst_fil.instcomm03      =  deci(bfimpinst_fil.instcomm03)
        impinst_fil.instcomm23      =  deci(bfimpinst_fil.instcomm23)
        impinst_fil.usrid           =  trim(impdata_fil.usrid)  
        impinst_fil.progid          =  trim(impdata_fil.progid) .
    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_ass_driver C-Win 
PROCEDURE proc_ass_driver :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    ASSIGN 
     impdriv_fil.ntitle1   = if trim(wf_ntitle1)     = "-" then "" else trim(wf_ntitle1)       
     impdriv_fil.name1     = if trim(wf_drivername1) = "-" then "" else trim(wf_drivername1)   
     impdriv_fil.lname1    = if trim(wf_dname2)     = "-" then "" else trim(wf_dname2)                                                    
     impdriv_fil.dicno1    = if trim(wf_dicno )     = "-" then "" else trim(wf_dicno )                                                    
     impdriv_fil.dgender1  = if trim(wf_dgender1)   = "-" then "" else trim(wf_dgender1)                                                  
     impdriv_fil.dbirth1   = if trim(wf_dbirth)     = "-" then "" else trim(wf_dbirth)                                                    
     impdriv_fil.doccup1   = if trim(wf_doccup)     = "-" then "" else trim(wf_doccup)                                                    
     impdriv_fil.ddriveno1 = if trim(wf_ddriveno)   = "-" then "" else trim(wf_ddriveno)                                                  
     impdriv_fil.drivexp1  = if trim(wf_drivexp1)   = "-" then "" else trim(wf_drivexp1) 
     impdriv_fil.dconsen1  = if trim(wf_dconsen1)   = "-" then "" else trim(wf_dconsen1) 
     impdriv_fil.dlevel1   = if trim(wf_dlevel1)    = "-" then "" 
                             else IF trim(wf_dlevel1) = "" AND trim(wf_drivername1) <> ""  THEN "1" ELSE trim(wf_dlevel1) 

     impdriv_fil.ntitle2   = if trim(wf_ntitle2 )    = "-" then "" else trim(wf_ntitle2 )  
     impdriv_fil.name2     = if trim(wf_drivername2) = "-" then "" else trim(wf_drivername2)  
     impdriv_fil.lname2    = if trim(wf_ddname1)    = "-" then "" else trim(wf_ddname1)                                                    
     impdriv_fil.dicno2    = if trim(wf_ddicno)     = "-" then "" else trim(wf_ddicno)                                                    
     impdriv_fil.dgender2  = if trim(wf_dgender2)   = "-" then "" else trim(wf_dgender2)                                                  
     impdriv_fil.dbirth2   = if trim(wf_ddbirth)    = "-" then "" else trim(wf_ddbirth)                                                   
     impdriv_fil.doccup2   = if trim(wf_ddoccup)    = "-" then "" else trim(wf_ddoccup)                                                   
     impdriv_fil.ddriveno2 = if trim(wf_dddriveno)  = "-" then "" else trim(wf_dddriveno)                                                 
     impdriv_fil.drivexp2  = if trim(wf_drivexp2)   = "-" then "" else trim(wf_drivexp2)                                                  
     impdriv_fil.dconsen2  = if trim(wf_dconsen2)   = "-" then "" else trim(wf_dconsen2) 
     impdriv_fil.dlevel2   = if trim(wf_dlevel2)    = "-" then "" 
                             else IF trim(wf_dlevel2) = "" AND trim(wf_drivername2) <> ""  THEN "1" ELSE trim(wf_dlevel2)

     impdriv_fil.ntitle3   = if trim(wf_ntitle3)  = "-" then "" else trim(wf_ntitle3)   
     impdriv_fil.name3     = if trim(wf_dname3)   = "-" then "" else trim(wf_dname3 )   
     impdriv_fil.lname3    = if trim(wf_dlname3)  = "-" then "" else trim(wf_dlname3)                                                 
     impdriv_fil.dicno3    = if trim(wf_dicno3)   = "-" then "" else trim(wf_dicno3 )                                                 
     impdriv_fil.dgender3  = if trim(wf_dgender3) = "-" then "" else trim(wf_dgender3)                                                 
     impdriv_fil.dbirth3   = if trim(wf_dbirth3)  = "-" then "" else trim(wf_dbirth3)                                                 
     impdriv_fil.doccup3   = if trim(wf_doccup3)  = "-" then "" else trim(wf_doccup3)                                                 
     impdriv_fil.ddriveno3 = if trim(wf_ddriveno3) = "-" then "" else trim(wf_ddriveno3)                                                
     impdriv_fil.drivexp3  = if trim(wf_drivexp3)  = "-" then "" else trim(wf_drivexp3 )                                                 
     impdriv_fil.dconsen3  = if trim(wf_dconsen3)   = "-" then "" else trim(wf_dconsen3) 
     impdriv_fil.dlevel3   = if trim(wf_dlevel3)    = "-" then "" 
                             else IF trim(wf_dlevel3) = "" AND trim(wf_dname3) <> ""  THEN "1" ELSE trim(wf_dlevel3)

     impdriv_fil.ntitle4   = if trim(wf_ntitle4)  = "-" then "" else trim(wf_ntitle4)     
     impdriv_fil.name4     = if trim(wf_dname4 )  = "-" then "" else trim(wf_dname4 )   
     impdriv_fil.lname4    = if trim(wf_dlname4)  = "-" then "" else trim(wf_dlname4)                                                
     impdriv_fil.dicno4    = if trim(wf_dicno4 )  = "-" then "" else trim(wf_dicno4 )                                                
     impdriv_fil.dgender4  = if trim(wf_dgender4) = "-" then "" else trim(wf_dgender4)                                                
     impdriv_fil.dbirth4   = if trim(wf_dbirth4)  = "-" then "" else trim(wf_dbirth4)                                                
     impdriv_fil.doccup4   = if trim(wf_doccup4)  = "-" then "" else trim(wf_doccup4)                                                
     impdriv_fil.ddriveno4 = if trim(wf_ddriveno4) = "-" then "" else trim(wf_ddriveno4)                                                
     impdriv_fil.drivexp4  = if trim(wf_drivexp4) = "-" then "" else trim(wf_drivexp4 )                                                
     impdriv_fil.dconsen4  = if trim(wf_dconsen4)   = "-" then "" else trim(wf_dconsen4) 
     impdriv_fil.dlevel4   = if trim(wf_dlevel4)    = "-" then "" 
                             else IF trim(wf_dlevel4) = "" AND trim(wf_dname4) <> ""  THEN "1" ELSE trim(wf_dlevel4)

     impdriv_fil.ntitle5   = if trim(wf_ntitle5)  = "-" then "" else trim(wf_ntitle5)                                      
     impdriv_fil.name5     = if trim(wf_dname5 )  = "-" then "" else trim(wf_dname5 )                                      
     impdriv_fil.lname5    = if trim(wf_dlname5)  = "-" then "" else trim(wf_dlname5)                                                 
     impdriv_fil.dicno5    = if trim(wf_dicno5 )  = "-" then "" else trim(wf_dicno5 )                                                 
     impdriv_fil.dgender5  = if trim(wf_dgender5) = "-" then "" else trim(wf_dgender5)                                                 
     impdriv_fil.dbirth5   = if trim(wf_dbirth5)  = "-" then "" else trim(wf_dbirth5)                                                 
     impdriv_fil.doccup5   = if trim(wf_doccup5)  = "-" then "" else trim(wf_doccup5)                                                 
     impdriv_fil.ddriveno5 = if trim(wf_ddriveno5) = "-" then "" else trim(wf_ddriveno5)                                                
     impdriv_fil.drivexp5  = if trim(wf_drivexp5) = "-" then "" else trim(wf_drivexp5 )                                                 
     impdriv_fil.dconsen5  = if trim(wf_dconsen5)   = "-" then "" else trim(wf_dconsen5) 
     impdriv_fil.dlevel5   = if trim(wf_dlevel5)    = "-" then "" 
                             else IF trim(wf_dlevel5) = "" AND trim(wf_dname5) <> ""  THEN "1" ELSE trim(wf_dlevel5)

     impdriv_fil.usrid     = USERID(LDBNAME(1))
     impdriv_fil.progid    = trim(nv_proid)    .

    IF      impdriv_fil.name1 <> "" THEN ASSIGN impdriv_fil.drivno  = 1.
    ELSE IF impdriv_fil.name2 <> "" THEN ASSIGN impdriv_fil.drivno  = 2.
    ELSE IF impdriv_fil.name3 <> "" THEN ASSIGN impdriv_fil.drivno  = 3.
    ELSE IF impdriv_fil.name4 <> "" THEN ASSIGN impdriv_fil.drivno  = 4.
    ELSE IF impdriv_fil.name5 <> "" THEN ASSIGN impdriv_fil.drivno  = 5.
     /* end : A67-0029*/
    RELEASE impdriv_fil.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_ass_insdetail C-Win 
PROCEDURE proc_ass_insdetail :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    ASSIGN fi_process = "Create data text file " + wf_riskno + "/" + " " + wf_num + " " + trim(wf_policyno) + " to impdata_fil ....." .
    DISP fi_process WITH FRAM fr_main.               
    CREATE impdata_fil.
    ASSIGN
        impdata_fil.riskno       =   int(wf_riskno)
        impdata_fil.itemno        =  int(wf_num)
        impdata_fil.policyno      =  trim(wf_policyno)       
        impdata_fil.n_branch      =  trim(wf_n_branch)        
        impdata_fil.agent         =  trim(wf_agent)           
        impdata_fil.producer      =  trim(wf_producer)        
        impdata_fil.n_delercode   =  trim(wf_n_delercode)   
        impdata_fil.fincode       =  trim(wf_fincode)   
        impdata_fil.appenno       =  trim(wf_appenno)   
        impdata_fil.salename      =  trim(wf_salename)   
        impdata_fil.srate         =  trim(wf_srate ) 
        impdata_fil.comdat        =  date(wf_comdat)                                        
        impdata_fil.expdat        =  date(wf_expdat)                                        
        impdata_fil.agreedat      =  if trim(wf_agreedat) = "" and trim(wf_prepol) = "" then date(wf_comdat) 
                                     else if trim(wf_agreedat) <> "" then date(wf_agreedat)  ELSE ? 
        impdata_fil.firstdat      =  if trim(wf_firstdat) = "" and trim(wf_prepol) = "" then date(wf_comdat) 
                                     else if trim(wf_firstdat) <> "" then date(wf_firstdat)  ELSE ? 
        impdata_fil.packcod       =  trim(wf_packcod)   
        impdata_fil.camp_no       =  trim(wf_camp_no)   
        impdata_fil.campen        =  trim(wf_campen) 
        impdata_fil.specon        =  trim(wf_specon) 
        impdata_fil.product       =  trim(wf_product)   
        impdata_fil.promo         =  trim(wf_promo)   
        impdata_fil.rencnt        =  IF trim(wf_rencnt) = "" THEN 0 ELSE INT(wf_rencnt)   
        impdata_fil.prepol        =  trim(wf_prepol)
        impdata_fil.compul        =  trim(wf_compul) 
        impdata_fil.insref        =  TRIM(wf_insref)
        impdata_fil.instyp        =  trim(wf_instyp) 
        impdata_fil.inslang       =  trim(wf_inslang )  
        impdata_fil.tiname        =  trim(wf_tiname) 
        impdata_fil.insnam        =  trim(wf_insnam) 
        impdata_fil.lastname      =  trim(wf_lastname)  
        impdata_fil.icno          =  trim(wf_icno)  
        impdata_fil.insbr         =  trim(wf_insbr) 
        impdata_fil.occup         =  trim(wf_occup) 
        impdata_fil.addr          =  trim(wf_addr)
        impdata_fil.tambon        =  trim(wf_tambon) 
        impdata_fil.amper         =  trim(wf_amper) 
        impdata_fil.country       =  trim(wf_country )  
        impdata_fil.post          =  trim(wf_post ) 
        impdata_fil.provcod       =  trim(wf_provcod)  
        impdata_fil.distcod       =  trim(wf_distcod)  
        impdata_fil.sdistcod      =  IF trim(wf_sdistcod) <> "" AND LENGTH(wf_sdistcod) > 2 THEN SUBSTR(wf_sdistcod,1,2) ELSE TRIM(wf_sdistcod)
        impdata_fil.jpae          =  trim(wf_ae) 
        impdata_fil.jpjtl         =  trim(wf_jtl)
        impdata_fil.jpts          =  trim(wf_ts) 
        impdata_fil.gender        =  trim(wf_gender) 
        impdata_fil.tele1         =  trim(wf_tele1) 
        impdata_fil.tele2         =  trim(wf_tele2) 
        impdata_fil.mail1         =  trim(wf_mail1) 
        impdata_fil.mail2         =  trim(wf_mail2) 
        impdata_fil.mail3         =  trim(wf_mail3) 
        impdata_fil.mail4         =  trim(wf_mail4) 
        impdata_fil.mail5         =  trim(wf_mail5) 
        impdata_fil.mail6         =  trim(wf_mail6)  
        impdata_fil.mail7         =  trim(wf_mail7)  
        impdata_fil.mail8         =  trim(wf_mail8)  
        impdata_fil.mail9         =  trim(wf_mail9)  
        impdata_fil.mail10        =  trim(wf_mail10)  
        impdata_fil.fax           =  trim(wf_fax)  
        impdata_fil.lineID        =  trim(wf_lineID)  
        impdata_fil.name2         =  trim(wf_name2)  
        impdata_fil.name3         =  trim(wf_name3)  
        impdata_fil.benname       =  trim(wf_benname) 
        impdata_fil.payercod      =  trim(wf_payercod)  
        impdata_fil.vatcode       =  trim(wf_vatcode )
        impdata_fil.premt         =  IF Trim(wf_premt)  = "" then 0 else deci(wf_premt )   
        impdata_fil.rstp_t        =  if Trim(wf_rstp_t) = "" then 0 else deci(wf_rstp_t)   
        impdata_fil.rtax_t        =  if Trim(wf_rtax_t) = "" then 0 else deci(wf_rtax_t)   
        impdata_fil.comper70      =  IF trim(wf_comper70)  =  "" THEN (-1) ELSE deci(wf_comper70)    /* ค่าว่างใส่ -1 ดึง comm ตามระบบ  ถ้าระบุ 0 ไม่มีค่าคอม */
        impdata_fil.comprem70     =  IF trim(wf_comprem70) =  "" THEN (-1) ELSE deci(wf_comprem70)  /* ค่าว่างใส่ -1 คำนวณ comm ตามระบบ ถ้าระบุ 0 ไม่มีค่าคอม */
        impdata_fil.agco70        =  trim(wf_agco70 )  
        impdata_fil.comco_per70   =  if trim(wf_comco_per70)  = ""  then 0 else   deci(wf_comco_per70) 
        impdata_fil.comco_prem70  =  if trim(wf_comco_prem70) = ""  then 0 else   deci(wf_comco_prem70).
    ASSIGN 
        impdata_fil.poltyp        = "V70"
        impdata_fil.comment       = ""
        impdata_fil.entdat        = string(TODAY)                /*entry date*/
        impdata_fil.enttim        = STRING(TIME, "HH:MM:SS")    /*entry time*/
        impdata_fil.trandat       = STRING(fi_loaddat)          /*tran date*/
        impdata_fil.trantim       = STRING(TIME, "HH:MM:SS")    /*tran time*/
        impdata_fil.n_IMPORT      = "CUS"
        impdata_fil.usrid         = USERID(LDBNAME(1))
        impdata_fil.progid        = trim(nv_proid)    .

   /* IF impdata_fil.policyno = "" THEN DO: 
        ASSIGN impdata_fil.policyno = "F" + STRING(DAY(TODAY),"99") + STRING(MONTH(TODAY),"99") + STRING(YEAR(TODAY),"9999") + "01" .
    END.*/
   RUN proc_ass_insdetail2.
   IF impdata_fil.insref <> ""  THEN RUN proc_chkinscode.
   
   RELEASE impdata_fil.
   RELEASE imptxt_fil.
   RELEASE impacc_fil .
   RELEASE impmemo_fil.
   RELEASE impinst_fil.
   
   
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_ass_insdetail2 C-Win 
PROCEDURE proc_ass_insdetail2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO: 
    CREATE imptxt_fil.
    CREATE impmemo_fil.
    CREATE impinst_fil.
    CREATE impacc_fil .
    ASSIGN 
    imptxt_fil.policyno =  TRIM(impdata_fil.policyno)
    imptxt_fil.riskno =  impdata_fil.riskno
    imptxt_fil.itemno =  impdata_fil.itemno
    imptxt_fil.txt1   =  trim(wf_txt1)   
    imptxt_fil.txt2   =  trim(wf_txt2)   
    imptxt_fil.txt3   =  trim(wf_txt3)   
    imptxt_fil.txt4   =  trim(wf_txt4)   
    imptxt_fil.txt5   =  trim(wf_txt5)   
    imptxt_fil.txt6   =  trim(wf_txt6)   
    imptxt_fil.txt7   =  trim(wf_txt7)   
    imptxt_fil.txt8   =  trim(wf_txt8)   
    imptxt_fil.txt9   =  trim(wf_txt9)   
    imptxt_fil.txt10  =  trim(wf_txt10)
    imptxt_fil.usrid  = USERID(LDBNAME(1))
    imptxt_fil.progid = trim(nv_proid)   

    impmemo_fil.policyno  =  TRIM(impdata_fil.policyno)
    impmemo_fil.riskno =  impdata_fil.riskno
    impmemo_fil.itemno =  impdata_fil.itemno
    impmemo_fil.memo1  =  trim(wf_memo1)   
    impmemo_fil.memo2  =  trim(wf_memo2)   
    impmemo_fil.memo3  =  trim(wf_memo3)   
    impmemo_fil.memo4  =  trim(wf_memo4)   
    impmemo_fil.memo5  =  trim(wf_memo5)   
    impmemo_fil.memo6  =  trim(wf_memo6)   
    impmemo_fil.memo7  =  trim(wf_memo7)   
    impmemo_fil.memo8  =  trim(wf_memo8)   
    impmemo_fil.memo9  =  trim(wf_memo9)   
    impmemo_fil.memo10 =  trim(wf_memo10)
    impmemo_fil.usrid  =  USERID(LDBNAME(1))
    impmemo_fil.progid =  trim(nv_proid)    

    impacc_fil.policyno =  TRIM(impdata_fil.policyno)
    impacc_fil.riskno   =  impdata_fil.riskno
    impacc_fil.itemno   =  impdata_fil.itemno
    impacc_fil.accdata1 =  trim(wf_accdata1)   
    impacc_fil.accdata2 =  trim(wf_accdata2)   
    impacc_fil.accdata3 =  trim(wf_accdata3)   
    impacc_fil.accdata4 =  trim(wf_accdata4)   
    impacc_fil.accdata5 =  trim(wf_accdata5)   
    impacc_fil.accdata6 =  trim(wf_accdata6)   
    impacc_fil.accdata7 =  trim(wf_accdata7)   
    impacc_fil.accdata8 =  trim(wf_accdata8)  
    impacc_fil.accdata9 =  trim(wf_accdata9)  
    impacc_fil.accdata10 =  trim(wf_accdata10)
    impacc_fil.usrid    =  USERID(LDBNAME(1))
    impacc_fil.progid   =  trim(nv_proid)    

    impinst_fil.policyno   =  TRIM(impdata_fil.policyno)
    impinst_fil.riskno     =  impdata_fil.riskno
    impinst_fil.itemno     =  impdata_fil.itemno
    impinst_fil.instot     =  0 
    impinst_fil.instcod1   =  trim(wf_instcod1)  
    impinst_fil.insttyp1   =  trim(wf_insttyp1)  
    impinst_fil.insttitle1 =  trim(wf_insttitle1)
    impinst_fil.instname1  =  trim(wf_instname1 )
    impinst_fil.instlname1 =  trim(wf_instlname1)
    impinst_fil.instic1    =  trim(wf_instic1)   
    impinst_fil.instbr1    =  trim(wf_instbr1)   
    impinst_fil.instaddr11 =  trim(wf_instaddr11)
    impinst_fil.instaddr21 =  trim(wf_instaddr21)
    impinst_fil.instaddr31 =  trim(wf_instaddr31)
    impinst_fil.instaddr41 =  trim(wf_instaddr41)
    impinst_fil.instpost1  =  trim(wf_instpost1 )
    impinst_fil.instprovcod1  =  trim(wf_instprovcod1 ) 
    impinst_fil.instdistcod1  =  trim(wf_instdistcod1 ) 
    impinst_fil.instsdistcod1 =  trim(wf_instsdistcod1) 
    impinst_fil.instprm1      =  deci(wf_instprm1)  
    impinst_fil.instrstp1     =  deci(wf_instrstp1 )  
    impinst_fil.instrtax1     =  deci(wf_instrtax1 )  
    impinst_fil.instcomm01    =  deci(wf_instcomm01)  
    impinst_fil.instcomm12    =  deci(wf_instcomm12)  
    impinst_fil.instcod2      =  trim(wf_instcod2)  
    impinst_fil.insttyp2      =  trim(wf_insttyp2)  
    impinst_fil.insttitle2    =  trim(wf_insttitle2)  
    impinst_fil.instname2     =  trim(wf_instname2 )  
    impinst_fil.instlname2    =  trim(wf_instlname2)  
    impinst_fil.instic2       =  trim(wf_instic2 )  
    impinst_fil.instbr2       =  trim(wf_instbr2 )  
    impinst_fil.instaddr12    =  trim(wf_instaddr12)  
    impinst_fil.instaddr22    =  trim(wf_instaddr22)  
    impinst_fil.instaddr32    =  trim(wf_instaddr32)  
    impinst_fil.instaddr42    =  trim(wf_instaddr42)  
    impinst_fil.instpost2     =  trim(wf_instpost2 )  
    impinst_fil.instprovcod2  =  trim(wf_instprovcod2 ) 
    impinst_fil.instdistcod2  =  trim(wf_instdistcod2 ) 
    impinst_fil.instsdistcod2 =  trim(wf_instsdistcod2) 
    impinst_fil.instprm2      =  deci(wf_instprm2 ) 
    impinst_fil.instrstp2     =  deci(wf_instrstp2) 
    impinst_fil.instrtax2     =  deci(wf_instrtax2) 
    impinst_fil.instcomm02    =  deci(wf_instcomm02)
    impinst_fil.instcomm22    =  deci(wf_instcomm22)
    impinst_fil.instcod3      =  trim(wf_instcod3) 
    impinst_fil.insttyp3      =  trim(wf_insttyp3) 
    impinst_fil.insttitle3    =  trim(wf_insttitle3)
    impinst_fil.instname3     =  trim(wf_instname3) 
    impinst_fil.instlname3    =  trim(wf_instlname3)
    impinst_fil.instic3       =  trim(wf_instic3)  
    impinst_fil.instbr3       =  trim(wf_instbr3)  
    impinst_fil.instaddr13    =  trim(wf_instaddr13)
    impinst_fil.instaddr23    =  trim(wf_instaddr23)
    impinst_fil.instaddr33    =  trim(wf_instaddr33)
    impinst_fil.instaddr43    =  trim(wf_instaddr43)
    impinst_fil.instpost3     =  trim(wf_instpost3 )  
    impinst_fil.instprovcod3  =  trim(wf_instprovcod3) 
    impinst_fil.instdistcod3  =  trim(wf_instdistcod3) 
    impinst_fil.instsdistcod3 =  trim(wf_instsdistcod3) 
    impinst_fil.instprm3      =  deci(wf_instprm3)  
    impinst_fil.instrstp3     =  deci(wf_instrstp3 )
    impinst_fil.instrtax3     =  deci(wf_instrtax3 )
    impinst_fil.instcomm03    =  deci(wf_instcomm03)
    impinst_fil.instcomm23    =  deci(wf_instcomm23)
    impinst_fil.usrid         = USERID(LDBNAME(1))
    impinst_fil.progid        = trim(nv_proid)  .

    ASSIGN wf_instot = 0 .
    IF impdata_fil.poltyp = "V70" THEN DO:
        IF  wf_instname1 <> "" THEN ASSIGN wf_instot = wf_instot + 1.  /*  ชื่อบริษัทเต็มบนใบกำกับภาษี1 */
        ELSE IF impinst_fil.instcod1 <> ""  THEN DO:
             FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = trim(impinst_fil.instcod1) NO-LOCK NO-ERROR.
             IF NOT AVAIL sicsyac.xmm600  THEN DO: 
                  IF wf_instname1 = "" THEN ASSIGN impdata_fil.comment = "| Code " + impinst_fil.instcod1 + " ของใบเสร็จ/ใบกำกับภาษี 1 ไม่มีในระบบ และข้อมูลชื่อเป็นค่าว่าง" .
                  ELSE ASSIGN  wf_instot = wf_instot + 1. 
             END.
             ELSE DO: 
                wf_instot = wf_instot + 1.
                /* คำนำหน้า */
                IF   impinst_fil.insttitle1   = "" AND trim(sicsyac.xmm600.ntitle)    <> "" then impinst_fil.insttitle1 = trim(sicsyac.xmm600.ntitle).
                /* สกุล */
                IF   impinst_fil.instlname1   = "" AND trim(sicsyac.xmm600.lastname)  <> "" then impinst_fil.instlname1 = trim(sicsyac.xmm600.lastname).
                ELSE impinst_fil.instlname1   = IF index(sicsyac.xmm600.name," ") <> 0 THEN trim(SUBSTR(sicsyac.xmm600.name,R-INDEX(sicsyac.xmm600.name," ") + 1 )) ELSE "".
                /* ชื่อ*/
                IF   impinst_fil.instname1    = "" AND trim(sicsyac.xmm600.firstname) <> "" then impinst_fil.instname1  = trim(sicsyac.xmm600.firstname).
                ELSE impinst_fil.instname1    = trim(SUBSTR(sicsyac.xmm600.name,1,LENGTH(sicsyac.xmm600.name) - LENGTH(impinst_fil.instlname1))).
                /* แยกคำหน้าชื่อ กับ ชื่อ */
               /* IF impinst_fil.insttitle1 = "" AND index(impinst_fil.instname1," ") <> 0 THEN DO: 
                    ASSIGN 
                    impinst_fil.insttitle1 = trim(SUBSTR(impinst_fil.instname1,1,INDEX(impinst_fil.instname1," ") - 1 ))
                    impinst_fil.instname1  = trim(SUBSTR(impinst_fil.instname1,R-INDEX(impinst_fil.instname1," ") ))
                    impinst_fil.instname1  = trim(REPLACE(impinst_fil.instname1,impinst_fil.insttitle1,"")).
                END.*/
             END.
        END.
        
        IF  wf_instname2 <> "" THEN ASSIGN wf_instot = wf_instot + 1.  /*  ชื่อบริษัทเต็มบนใบกำกับภาษี2 */
        ELSE IF impinst_fil.instcod2 <> ""  THEN DO:
         FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = trim(impinst_fil.instcod2) NO-LOCK NO-ERROR.
             IF NOT AVAIL sicsyac.xmm600  THEN DO: 
                 IF wf_instname2 = "" THEN ASSIGN impdata_fil.comment = "| Code " + impinst_fil.instcod2 + " ของใบเสร็จ/ใบกำกับภาษี 2 ไม่มีในระบบ และข้อมูลชื่อเป็นค่าว่าง" .
                 ELSE ASSIGN wf_instot = wf_instot + 1 .
             END.
             ELSE DO: 
                 wf_instot = wf_instot + 1.
                 /* คำนำหน้า */
                 IF   impinst_fil.insttitle2   = "" AND trim(sicsyac.xmm600.ntitle)    <> "" then impinst_fil.insttitle2 = trim(sicsyac.xmm600.ntitle).
                /* สกุล */
                IF   impinst_fil.instlname2   = "" AND trim(sicsyac.xmm600.lastname)  <> "" then impinst_fil.instlname2 = trim(sicsyac.xmm600.lastname).
                ELSE impinst_fil.instlname2   = IF index(sicsyac.xmm600.name," ") <> 0 THEN trim(SUBSTR(sicsyac.xmm600.name,R-INDEX(sicsyac.xmm600.name," ") + 1 )) ELSE "".
                /* ชื่อ*/
                IF   impinst_fil.instname2    = "" AND trim(sicsyac.xmm600.firstname) <> "" then impinst_fil.instname2  = trim(sicsyac.xmm600.firstname).
                ELSE impinst_fil.instname2    = trim(SUBSTR(sicsyac.xmm600.name,1,LENGTH(sicsyac.xmm600.name) - LENGTH(impinst_fil.instlname2))).
                /* แยกคำหน้าชื่อ กับ ชื่อ */
                /*IF impinst_fil.insttitle2 = "" AND index(impinst_fil.instname2," ") <> 0 THEN DO: 
                    ASSIGN 
                    impinst_fil.insttitle2 = trim(SUBSTR(impinst_fil.instname2,1,INDEX(impinst_fil.instname2," ") - 1 ))
                    impinst_fil.instname2  = trim(SUBSTR(impinst_fil.instname2,R-INDEX(impinst_fil.instname2," ") ))
                    impinst_fil.instname2  = trim(REPLACE(impinst_fil.instname2,impinst_fil.insttitle2,"")).
                END.*/
             END.
        END.
        
        IF  wf_instname3 <> "" THEN ASSIGN wf_instot = wf_instot + 1.  /*  ชื่อบริษัทเต็มบนใบกำกับภาษี3 */
        ELSE IF impinst_fil.instcod3 <> ""   THEN DO:
         FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = trim(impinst_fil.instcod3) NO-LOCK NO-ERROR.
             IF NOT AVAIL sicsyac.xmm600  THEN DO: 
                 IF wf_instname3 = "" THEN ASSIGN impdata_fil.comment = "| Code " + impinst_fil.instcod3 + " ของใบเสร็จ/ใบกำกับภาษี 2 ไม่มีในระบบ และข้อมูลชื่อเป็นค่าว่าง" .
                 ELSE ASSIGN wf_instot = wf_instot + 1.
             END.
             ELSE DO: 
                 wf_instot = wf_instot + 1.
                 /* คำนำหน้า */
                 IF   impinst_fil.insttitle3   = "" AND trim(sicsyac.xmm600.ntitle)    <> "" then impinst_fil.insttitle3 = trim(sicsyac.xmm600.ntitle).
                 /* สกุล */
                 IF   impinst_fil.instlname3   = "" AND trim(sicsyac.xmm600.lastname)  <> "" then impinst_fil.instlname3 = trim(sicsyac.xmm600.lastname).
                 ELSE impinst_fil.instlname3   = IF index(sicsyac.xmm600.name," ") <> 0 THEN trim(SUBSTR(sicsyac.xmm600.name,R-INDEX(sicsyac.xmm600.name," ") + 1 )) ELSE "".
                 /* ชื่อ*/
                 IF   impinst_fil.instname3    = "" AND trim(sicsyac.xmm600.firstname) <> "" then impinst_fil.instname3  = trim(sicsyac.xmm600.firstname).
                 ELSE impinst_fil.instname3    = trim(SUBSTR(sicsyac.xmm600.name,1,LENGTH(sicsyac.xmm600.name) - LENGTH(impinst_fil.instlname3))).
                 /* แยกคำหน้าชื่อ กับ ชื่อ */
                 /*IF impinst_fil.insttitle3 = "" AND index(impinst_fil.instname3," ") <> 0 THEN DO: 
                     ASSIGN 
                     impinst_fil.insttitle3 = trim(SUBSTR(impinst_fil.instname3,1,INDEX(impinst_fil.instname3," ") - 1 ))
                     impinst_fil.instname3  = trim(SUBSTR(impinst_fil.instname3,R-INDEX(impinst_fil.instname3," ") ))
                     impinst_fil.instname3  = trim(REPLACE(impinst_fil.instname3,impinst_fil.insttitle3,"")). 
                 END.*/
             END.
        END.
    END.

    IF  wf_instot = 0 THEN impdata_fil.instot = 1.
    ELSE IF wf_instot = 1 THEN DO:
        ASSIGN 
            impdata_fil.instot = 1 
            impinst_fil.instot = 1.
    END.
    ELSE ASSIGN impinst_fil.instot = wf_instot
                impdata_fil.instot = wf_instot .
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_base2 C-Win 
PROCEDURE proc_base2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR i       AS INTE.
DEF VAR per     AS DECI.
DEF VAR f       AS DECI.
DEF VAR chk     AS LOGICAL.
DEF VAR model   AS CHAR FORMAT "x(30)".
DEF VAR aa      AS DECI.
ASSIGN fi_process = "Check Base data Load Text ...." + impdata_fil.policyno .
DISP fi_process WITH FRAM fr_main.
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.

IF impdata_fil.poltyp = "V70" THEN DO:
    IF impdata_fil.base = 0 THEN DO:
       RUN wgs\wgsfbas.
       ASSIGN aa = nv_baseprm.
    END.
    ELSE aa = impdata_fil.base .

    IF aa = 0 THEN DO:
       RUN wgs\wgsfbas.
       ASSIGN aa = nv_baseprm.
    END.
    ASSIGN
        chk = NO
        NO_basemsg = " "
        f = DECI(impdata_fil.premt)
        i = 1
        nv_baseprm = aa
        nv_dss_per = 0
        nv_dss_per = deci(impdata_fil.dspc).
        
  /*  DO i = 1 TO 10:*/
        /*-----nv_drivcod---------------------*/
    /* comment by :A67-0029....
     ASSIGN nv_drivvar = ""
            nv_drivvar1 = impdata_fil.drivername1.
            nv_drivvar2 = impdata_fil.drivername2.
        IF impdata_fil.drivnam = "N" THEN  nv_drivno = 0.
        ELSE DO:
            IF impdata_fil.prepol = ""  THEN DO:
                IF impdata_fil.drivername1 <> ""   THEN  impdata_fil.drivnam  = "y".
                ELSE impdata_fil.drivnam  = "N".
                IF impdata_fil.drivername2 <> ""   THEN  nv_drivno = 2. 
                ELSE IF impdata_fil.drivername1 <> "" AND impdata_fil.drivername2 = "" THEN  nv_drivno = 1.  
                ELSE IF impdata_fil.drivername1  = "" AND impdata_fil.drivername2 = "" THEN  nv_drivno = 0.   
            END.
        END.
        
        IF impdata_fil.prepol = ""  THEN DO:
            If impdata_fil.drivnam  = "N"  Then 
                Assign nv_drivvar   = " "
                nv_drivcod   = "A000"
                nv_drivvar1  =  "     Unname Driver"
                nv_drivvar2  = "0"
                Substr(nv_drivvar,1,30)   = nv_drivvar1
                Substr(nv_drivvar,31,30)  = nv_drivvar2.
            ELSE DO:
                IF  THEN
                IF  nv_drivno  > 2  Then do:
                    Message " Driver'S NO. must not over 2. "  View-as alert-box.
                    ASSIGN impdata_fil.pass    = "N"
                        impdata_fil.comment = impdata_fil.comment +  "| Driver'S NO. must not over 2. ".  
                END.
                RUN proc_usdcod.
                Assign  nv_drivvar  = ""
                nv_drivvar     = nv_drivcod
                nv_drivvar1    = "     Driver name person = "
                nv_drivvar2    = String(nv_drivno)
                Substr(nv_drivvar,1,30)  = nv_drivvar1
                Substr(nv_drivvar,31,30) = nv_drivvar2.
            END.
        END.
        ...end A67-0029 ...*/
        RUN proc_chkdrive.
        /*-------nv_baseprm----------*/
        IF NO_basemsg <> " " THEN  impdata_fil.WARNING = no_basemsg.
        IF nv_baseprm = 0  Then 
            ASSIGN  impdata_fil.pass    = "N"
            impdata_fil.comment = impdata_fil.comment + "| Base Premium is Mandatory field. ".  
        ASSIGN nv_basevar = " "
            nv_prem1 = nv_baseprm
            nv_basecod  = "BASE"
            nv_basevar1 = "     Base Premium = "
            nv_basevar2 = STRING(nv_baseprm)
            SUBSTRING(nv_basevar,1,30)   = nv_basevar1
            SUBSTRING(nv_basevar,31,30)  = nv_basevar2.
        /*-------nv_add perils----------*/
       Assign  nv_411var = ""   nv_412var = ""                                                  
            nv_41cod1   = "411"
            nv_411var1  = "     PA Driver = "
            nv_411var2  =  STRING(impdata_fil.no_411)
            SUBSTRING(nv_411var,1,30)    = nv_411var1
            SUBSTRING(nv_411var,31,30)   = nv_411var2

            nv_41cod2   = "412"
            nv_412var1  = "     PA Passengers = "
            nv_412var2  =  STRING(impdata_fil.NO_412)
            SUBSTRING(nv_412var,1,30)   = nv_412var1
            SUBSTRING(nv_412var,31,30)  = nv_412var2
            nv_411prm  = impdata_fil.no_411
            nv_412prm  = impdata_fil.no_412.
         /* -------fi_42---------*/
        ASSIGN nv_42var    = " "  
            nv_42cod   = "42".
            nv_42var1  = "     Medical Expense = ".
            nv_42var2  = STRING(impdata_fil.no_42).
            SUBSTRING(nv_42var,1,30)   = nv_42var1.
            SUBSTRING(nv_42var,31,30)  = nv_42var2.
          /*---------fi_43--------*/
        ASSIGN nv_43var    = " "
            nv_43prm = nv_43
            nv_43cod   = "43"
            nv_43var1  = "     Airfrieght = "
            nv_43var2  =  STRING(impdata_fil.no_43)
            SUBSTRING(nv_43var,1,30)   = nv_43var1
            SUBSTRING(nv_43var,31,30)  = nv_43var2.
        nv_413var = "" .
       IF impdata_fil.NO_413 <> 0 THEN DO:
           Assign  nv_413var = ""                                                  
            nv_41cod3   = "413"
            nv_413var1  = "     PA Temp. Driver = "
            nv_413var2  =  STRING(impdata_fil.no_413)
            SUBSTRING(nv_413var,1,30)    = nv_413var1
            SUBSTRING(nv_413var,31,30)   = nv_413var2.
       END.
       nv_414var = "" .
       IF impdata_fil.NO_414 <> 0 THEN DO:
           Assign  nv_414var = ""                                                  
            nv_41cod4   = "414"
            nv_414var1  = "     PA Temp. Driver = "
            nv_414var2  =  STRING(impdata_fil.no_414)
            SUBSTRING(nv_414var,1,30)    = nv_414var1
            SUBSTRING(nv_414var,31,30)   = nv_414var2.
       END.
        /*------nv_usecod------------*/
        ASSIGN nv_usevar = ""
            nv_usecod  = "USE" + TRIM(impdata_fil.vehuse)
            nv_usevar1 = "     Vehicle Use = "
            nv_usevar2 =  impdata_fil.vehuse
            Substring(nv_usevar,1,30)   = nv_usevar1
            Substring(nv_usevar,31,30) = nv_usevar2.
        /*-----nv_engcod-----------------*/
        ASSIGN nv_sclass =  impdata_fil.subclass.       
        RUN wgs\wgsoeng.   
        /*-----nv_yrcod----------------------------*/  
        ASSIGN nv_yrvar = ""
            nv_caryr   = (Year(nv_comdat)) - integer(impdata_fil.yrmanu) + 1
            nv_yrvar1  = "     Vehicle Year = "
            nv_yrvar2  =  impdata_fil.yrmanu
            nv_yrcod   = If nv_caryr <= 10 Then "YR" + String(nv_caryr) Else "YR99"
            Substr(nv_yrvar,1,30)    = nv_yrvar1
            Substr(nv_yrvar,31,30)   = nv_yrvar2.  
     /*-----nv_sicod----------------------------*/  
                                                                           
     Assign  nv_sivar   = "" 
             nv_totsi     = 0
             nv_sicod     = "SI"
             nv_sivar1    = "     Own Damage = "
             nv_sivar2    =  STRING(impdata_fil.si)
             SUBSTRING(nv_sivar,1,30)  = nv_sivar1
             SUBSTRING(nv_sivar,31,30) = string(deci(nv_sivar2))
             nv_totsi     =  DECI(impdata_fil.si).
     /*----------nv_grpcod--------------------*/
     ASSIGN nv_grpvar  = "" 
         nv_grpcod      = "GRP" + impdata_fil.cargrp
         nv_grpvar1     = "     Vehicle Group = "
         nv_grpvar2     = impdata_fil.cargrp
         Substr(nv_grpvar,1,30)  = nv_grpvar1
         Substr(nv_grpvar,31,30) = nv_grpvar2.
     /*-------------nv_bipcod--------------------*/
     ASSIGN nv_bipvar  = ""
         nv_bipcod      = "BI1"
         nv_bipvar1     = "     BI per Person = "
         nv_bipvar2     = STRING(sic_bran.uwm130.uom1_v)
         SUBSTRING(nv_bipvar,1,30)   = nv_bipvar1
         SUBSTRING(nv_bipvar,31,30)  = nv_bipvar2.
     /*-------------nv_biacod--------------------*/
     Assign nv_biavar  = ""
         nv_biacod      = "BI2"
         nv_biavar1     = "     BI per Accident = "
         nv_biavar2     = STRING(sic_bran.uwm130.uom2_v)
         SUBSTRING(nv_biavar,1,30)  = nv_biavar1
         SUBSTRING(nv_biavar,31,30) = nv_biavar2.
     /*-------------nv_pdacod--------------------*/
     ASSIGN nv_pdavar  = ""
         nv_pdacod      = "PD"
         nv_pdavar1     = "     PD per Accident = "
         nv_pdavar2     = string(deci(sic_bran.uwm130.uom5_v)) 
         SUBSTRING(nv_pdavar,1,30)  = nv_pdavar1
         SUBSTRING(nv_pdavar,31,30) = nv_pdavar2.
     /*--------------- deduct ----------------*/
     ASSIGN dod0 = 0
            dod1 = 0
            dod2 = 0
            dpd0 = 0 .
     IF impdata_fil.dod <> 0  THEN DO:
         IF impdata_fil.dgatt = 0 THEN DO: /*A65-0079*/
             dod0 = impdata_fil.dod.
             /* add by : A65-0043 */
             IF SUBSTR(impdata_fil.subclass,1,1) = "6"  THEN DO:    
                 IF dod0 > 1000 THEN DO:
                    dod1 = 1000.
                    dod2 = dod0 - dod1.
                END.
                ELSE dod1 = dod0.
             END.
             ELSE DO:
            /* end : A65-0043 */
                IF dod0 > 3000 THEN DO:
                    dod1 = 3000.
                    dod2 = dod0 - dod1.
                END.
                ELSE dod1 = dod0.
             END.
         END.
        /*add : A65-0079*/
         ELSE DO:
             dod1 = impdata_fil.dod.
             dod2 = impdata_fil.dgatt.
         END.
         /* end : A65-0079*/
         ASSIGN
             nv_odcod    = "DC01"
             nv_prem     =  dod1
             nv_sivar2   = "" .  
         RUN Wgs\Wgsmx024( nv_tariff,              
                           nv_odcod,
                           nv_class,
                           nv_key_b,
                           nv_comdat,
                           INPUT-OUTPUT nv_prem,
                           OUTPUT nv_chk ,
                           OUTPUT nv_baseap).
         IF NOT nv_chk THEN DO:
             MESSAGE  " DEDUCTIBLE EXCEED THE LIMIT " nv_baseap  View-as alert-box.
             ASSIGN
                 impdata_fil.pass    = "N"
                 impdata_fil.comment = impdata_fil.comment + "| DEDUCTIBLE EXCEED THE LIMIT ".
         END.
         ASSIGN nv_dedod1var  = ""
             nv_ded1prm        = nv_prem
             nv_dedod1_prm     = nv_prem
             nv_dedod1_cod     = "DOD"
             nv_dedod1var1     = "     Deduct OD = "
             nv_dedod1var2     = STRING(dod1)
             SUBSTRING(nv_dedod1var,1,30)  = nv_dedod1var1
             SUBSTRING(nv_dedod1var,31,30) = nv_dedod1var2.
         /*add od*/
         Assign  
             nv_dedod2var   = " "
             nv_cons  = "AD"
             nv_ded   = dod2.
         Assign
             /*nv_aded1prm     = nv_prem*/ /*A64-0138*/
             nv_dedod2_cod   = "DOD2"
             nv_dedod2var1   = "     Add Ded.OD = "
             nv_dedod2var2   =  STRING(dod2)
             SUBSTRING(nv_dedod2var,1,30)  = nv_dedod2var1
             SUBSTRING(nv_dedod2var,31,30) = nv_dedod2var2 .
             /*nv_dedod2_prm   = nv_prem.*/ /*A64-0138*/
     END.
     /***** pd *******/
     IF impdata_fil.DPD <> 0 THEN DO:
        Assign
            dpd0         = 0
            dpd0         = impdata_fil.dpd
            nv_dedpdvar  = " "
            nv_cons  = "PD"
            nv_ded   = dpd0.
        ASSIGN
            nv_dedpd_cod   = "DPD"
            nv_dedpdvar1   = "     Deduct PD = "
            nv_dedpdvar2   =  STRING(nv_ded)
            SUBSTRING(nv_dedpdvar,1,30)    = nv_dedpdvar1
            SUBSTRING(nv_dedpdvar,31,30)   = nv_dedpdvar2 .
            /*nv_dedpd_prm  = nv_prem.*/ /*A64-0138*/
     END.
     /*---------- fleet -------------------*/
     ASSIGN nv_flet_per = 0
            nv_flet_per = INTE(impdata_fil.fleet).
     IF nv_flet_per <> 0 AND  nv_flet_per <> 10 Then do:
         Message  " Fleet Percent must be 0 or 10. " View-as alert-box.
         ASSIGN
             impdata_fil.pass    = "N"
             impdata_fil.comment = impdata_fil.comment + "| Fleet Percent must be 0 or 10. ".
     End.
     IF nv_flet_per = 0 Then do:
         ASSIGN nv_flet     = 0
                nv_fletvar  = " ".
     End.
     ELSE DO:
        ASSIGN  nv_fletvar = " "      
             nv_fletvar1    = "     Fleet % = "
             nv_fletvar2    =  STRING(nv_flet_per)
             SUBSTRING(nv_fletvar,1,30)     = nv_fletvar1
             SUBSTRING(nv_fletvar,31,30)    = nv_fletvar2.
     END.
     IF nv_flet   = 0  THEN nv_fletvar  = " ".
     /*---------------- NCB -------------------*/
     ASSIGN NV_NCBPER = 0
            NV_NCBPER = INTE(impdata_fil.NCB).
     nv_ncbvar = " ".
     If nv_ncbper  <> 0 Then do:
         Find first sicsyac.xmm104 Use-index xmm10401 Where
             sicsyac.xmm104.tariff = nv_tariff           AND
             sicsyac.xmm104.class  = nv_class            AND 
             sicsyac.xmm104.covcod = nv_covcod           AND 
             sicsyac.xmm104.ncbper   = INTE(impdata_fil.ncb) No-lock no-error no-wait.
         IF not avail  sicsyac.xmm104  Then do:
             Message " This NCB Step not on NCB Rates file xmm104. " View-as alert-box.
             ASSIGN impdata_fil.pass    = "N"
                 impdata_fil.comment = impdata_fil.comment + "| This NCB Step not on NCB Rates file xmm104. ".
         END.
         ELSE ASSIGN nv_ncbper = xmm104.ncbper   
                     nv_ncbyrs = xmm104.ncbyrs.
     END.
     Else do:  
         ASSIGN nv_ncbyrs =   0
                nv_ncbper =   0
                nv_ncb    =   0.
     END.
    
     nv_ncbvar   = " ".
     IF  nv_ncb <> 0  THEN
         ASSIGN 
         nv_ncbvar1   = "     NCB % = "
         nv_ncbvar2   =  STRING(nv_ncbper)
         SUBSTRING(nv_ncbvar,1,30)    = nv_ncbvar1
         SUBSTRING(nv_ncbvar,31,30)   = nv_ncbvar2.
    
     nv_dsspcvar   = " ".
     IF  nv_dss_per   <> 0  THEN
       Assign
       nv_dsspcvar1   = "     Discount Special % = "
       nv_dsspcvar2   =  STRING(nv_dss_per)
       SUBSTRING(nv_dsspcvar,1,30)    = nv_dsspcvar1
       SUBSTRING(nv_dsspcvar,31,30)   = nv_dsspcvar2.
    /*----------- CL ------------*/
    nv_clmvar  = " ".                                    
    nv_cl_per  = DECI(impdata_fil.claim).       
    IF nv_cl_per  <> 0  THEN                             
        Assign                                           
        nv_clmvar1   = " Load Claim % = "                
        nv_clmvar2   =  STRING(nv_cl_per)                
        SUBSTRING(nv_clmvar,1,30)    = nv_clmvar1        
        SUBSTRING(nv_clmvar,31,30)   = nv_clmvar2.
    /* *------------------ stf ---------------*/         
    nv_stfvar   = " ".                                   
    nv_stf_per  = DECI(impdata_fil.dstf).     
    IF  nv_stf_per   <> 0  THEN                          
    Assign                                               
         nv_stfvar1   = "     Discount Staff"            
         nv_stfvar2   =  STRING(nv_stf_per)              
         SUBSTRING(nv_stfvar,1,30)    = nv_stfvar1       
         SUBSTRING(nv_stfvar,31,30)   = nv_stfvar2.  
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_base2plus C-Win 
PROCEDURE proc_base2plus :
DEF VAR chk     AS LOGICAL.
DEF VAR model   AS CHAR FORMAT "x(30)".
DEF VAR aa      AS DECI.
ASSIGN fi_process = "Check Base Plus Data Text 2+3+...." + impdata_fil.policyno .
DISP fi_process WITH FRAM fr_main.
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.
IF impdata_fil.poltyp = "v70" THEN DO:
    IF impdata_fil.base <> 0 THEN aa = impdata_fil.base .
    ELSE IF (impdata_fil.covcod = "2.1") OR (impdata_fil.covcod = "3.1") OR (impdata_fil.covcod = "2.2") OR (impdata_fil.covcod = "3.2") THEN DO: 
        RUN wgs\wgsfbas.
        ASSIGN aa = nv_baseprm.
    END.
    IF aa = 0 THEN DO:
        RUN wgs\wgsfbas.
        ASSIGN aa = nv_baseprm.
    END.
    ASSIGN
        chk = NO
        NO_basemsg  = " "
        nv_baseprm  = aa
        nv_dss_per  = 0 
        nv_dss_per  = deci(impdata_fil.dspc) .
       /* comment by : A67-0029...
        nv_drivvar1 = impdata_fil.drivername1   /*-----nv_drivcod---------------------*/
        nv_drivvar2 = impdata_fil.drivername2.
    IF impdata_fil.drivnam = "n" THEN  nv_drivno = 0.
    ELSE DO:
        IF      impdata_fil.drivername1 <> ""   THEN  impdata_fil.drivnam  = "y".
        ELSE    impdata_fil.drivnam     = "N".

        IF      impdata_fil.drivername2 <> ""   THEN  nv_drivno = 2. 
        ELSE IF impdata_fil.drivername1 <> "" AND impdata_fil.drivername2 = "" THEN  nv_drivno = 1.  
        ELSE IF impdata_fil.drivername1  = "" AND impdata_fil.drivername2 = "" THEN  nv_drivno = 0.   
    END.
    If impdata_fil.drivnam  = "N"  Then 
        Assign nv_drivvar   = " "
        nv_drivcod   = "A000"
        nv_drivvar1  =  "     Unname Driver"
        nv_drivvar2  = "0"
        Substr(nv_drivvar,1,30)   = nv_drivvar1
        Substr(nv_drivvar,31,30)  = nv_drivvar2.
    ELSE DO:
        IF  nv_drivno  > 2  Then do:
            Message " Driver'S NO. must not over 2. "  View-as alert-box.
            ASSIGN impdata_fil.pass    = "N"
                    impdata_fil.comment = impdata_fil.comment +  "| Driver'S NO. must not over 2. ".  
        END.
        RUN proc_usdcod.
        ASSIGN nv_drivvar  = " "
            nv_drivvar     = nv_drivcod
            nv_drivvar1    = "     Driver name person = "
            nv_drivvar2    = String(nv_drivno)
            Substr(nv_drivvar,1,30)  = nv_drivvar1
            Substr(nv_drivvar,31,30) = nv_drivvar2.
    END.
    ...end A67-0029...*/
    RUN proc_chkdrive. /* A67-0029*/
    /*-------nv_baseprm----------*/
    nv_basevar = "" .
    IF NO_basemsg <> " " THEN  impdata_fil.WARNING = no_basemsg.
    IF nv_baseprm = 0  Then 
        ASSIGN  impdata_fil.pass    = "N"
        impdata_fil.comment = impdata_fil.comment + "| Base Premium is Mandatory field. ".  
    ASSIGN nv_prem1 = nv_baseprm
        nv_basecod  = "BASE"
        nv_basevar1 = "     Base Premium = "
        nv_basevar2 = STRING(nv_baseprm)
        SUBSTRING(nv_basevar,1,30)   = nv_basevar1
        SUBSTRING(nv_basevar,31,30)  = nv_basevar2.
    ASSIGN  nv_seat41 = integer(impdata_fil.seat41).
    
    Assign nv_411var = ""   nv_412var = ""                                                  
        nv_41cod1   = "411"
        nv_411var1  = "     PA Driver = "
        nv_411var2  =  STRING(impdata_fil.NO_411)
        SUBSTRING(nv_411var,1,30)    = nv_411var1
        SUBSTRING(nv_411var,31,30)   = nv_411var2
        nv_41cod2   = "412"
        nv_412var1  = "     PA Passengers = "
        nv_412var2  =  STRING(impdata_fil.NO_412)
        SUBSTRING(nv_412var,1,30)   = nv_412var1
        SUBSTRING(nv_412var,31,30)  = nv_412var2
        nv_411prm  = nv_41 
        nv_412prm  = nv_41 .
    ASSIGN  nv_42var    = " "     /* -------fi_42---------*/
        nv_42cod   = "42"
        nv_42var1  = "     Medical Expense = "
        nv_42var2  = STRING(impdata_fil.no_42)
        SUBSTRING(nv_42var,1,30)   = nv_42var1
        SUBSTRING(nv_42var,31,30)  = nv_42var2 .
   ASSIGN  nv_43var    = " "     /*---------fi_43--------*/
        nv_43prm = nv_43
        nv_43cod   = "43"
        nv_43var1  = "     Airfrieght = "
        nv_43var2  =  STRING(impdata_fil.no_43)
        SUBSTRING(nv_43var,1,30)   = nv_43var1
        SUBSTRING(nv_43var,31,30)  = nv_43var2.
    
    /*------nv_usecod------------*/
    ASSIGN nv_usevar = ""
        nv_usecod  = "USE" + TRIM(impdata_fil.vehuse)
        nv_usevar1 = "     Vehicle Use = "
        nv_usevar2 =  impdata_fil.vehuse
        Substring(nv_usevar,1,30)   = nv_usevar1
        Substring(nv_usevar,31,30) = nv_usevar2.
    /*-----nv_engcod-----------------*/
    ASSIGN nv_sclass =  impdata_fil.subclass.       
    RUN wgs\wgsoeng.

    /*-----nv_yrcod---------- 1. ------------------*/  
    ASSIGN nv_yrvar = ""
        nv_caryr   = (Year(nv_comdat)) - integer(impdata_fil.yrmanu) + 1
        nv_yrvar1  = "     Vehicle Year = "
        nv_yrvar2  =  impdata_fil.yrmanu
        nv_yrcod   = If nv_caryr <= 10 Then "YR" + String(nv_caryr) Else "YR99"
        Substr(nv_yrvar,1,30)    = nv_yrvar1
        Substr(nv_yrvar,31,30)   = nv_yrvar2.  
    /*-----nv_sicod----------------------------*/  
    Assign nv_sivar = " " 
        nv_totsi = 0        nv_sicod     = "SI"
        nv_sivar1    = "     Own Damage = "
        nv_sivar2    =  STRING(impdata_fil.siplus)       
        impdata_fil.si   =  impdata_fil.siplus       
        SUBSTRING(nv_sivar,1,30)  = nv_sivar1
        SUBSTRING(nv_sivar,31,30) = string(deci(nv_sivar2))
        nv_totsi     = deci(impdata_fil.siplus) .  /*A62-0215*/
    /*----------nv_grpcod--------------------*/
    ASSIGN  nv_grpvar  = ""
        nv_grpcod      = "GRP" + impdata_fil.cargrp
        nv_grpvar1     = "     Vehicle Group = "
        nv_grpvar2     = impdata_fil.cargrp
        Substr(nv_grpvar,1,30)  = nv_grpvar1
        Substr(nv_grpvar,31,30) = nv_grpvar2.
    /*-------------nv_bipcod--------------------*/
    ASSIGN nv_bipvar   = ""
        nv_bipcod      = "BI1"
        nv_bipvar1     = "     BI per Person = "
        nv_bipvar2     = STRING(sic_bran.uwm130.uom1_v)
        SUBSTRING(nv_bipvar,1,30)   = nv_bipvar1
        SUBSTRING(nv_bipvar,31,30)  = nv_bipvar2.
    /*-------------nv_biacod--------------------*/
    Assign nv_biavar  = ""
        nv_biacod      = "BI2"
        nv_biavar1     = "     BI per Accident = "
        nv_biavar2     = STRING(sic_bran.uwm130.uom2_v)
        SUBSTRING(nv_biavar,1,30)  = nv_biavar1
        SUBSTRING(nv_biavar,31,30) = nv_biavar2.
    /*-------------nv_pdacod--------------------*/
    IF (impdata_fil.covcod = "2.1") THEN nv_usecod3 = "U" + TRIM(nv_vehuse) + "21" .
    ELSE IF (impdata_fil.covcod = "2.2") THEN nv_usecod3 = "U" + TRIM(nv_vehuse) + "22" .  /*a62-0215*/
    ELSE IF (impdata_fil.covcod = "3.2") THEN nv_usecod3 = "U" + TRIM(nv_vehuse) + "32" .  /*a62-0215*/
    ELSE nv_usecod3 = "U" + TRIM(nv_vehuse) + "31" .
    ASSIGN nv_usevar3  = ""  
        nv_usevar4 = "     Vehicle Use = "
        nv_usevar5 =  impdata_fil.vehuse
        Substring(nv_usevar3,1,30)   = nv_usevar4
        Substring(nv_usevar3,31,30)  = nv_usevar5.
    /*------------ base3 --------------*/
    ASSIGN  nv_basecod3 = IF (impdata_fil.covcod = "2.1") THEN "BA21" 
                          ELSE IF (impdata_fil.covcod = "2.2") THEN "BA22"
                          ELSE IF (impdata_fil.covcod = "3.1") THEN "BA31" ELSE "BA32". 
    IF impdata_fil.baseplus = 0 THEN DO:
     FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
         sicsyac.xmm106.tariff = nv_tariff   AND
         sicsyac.xmm106.bencod = nv_basecod3 AND
         sicsyac.xmm106.covcod = nv_covcod   AND
         sicsyac.xmm106.class  = nv_class    AND
         sicsyac.xmm106.key_b  GE nv_key_b   AND
         sicsyac.xmm106.effdat LE nv_comdat  NO-LOCK NO-ERROR NO-WAIT.
     IF AVAIL sicsyac.xmm106 THEN  nv_baseprm3 = xmm106.min_ap.
     ELSE  nv_baseprm3 = 0.
    END.
    ELSE nv_baseprm3 = impdata_fil.baseplus .
    ASSIGN nv_basevar3 = ""
        nv_basevar4 = "     Base Premium3 = "
        nv_basevar5 = STRING(nv_baseprm3)
        SUBSTRING(nv_basevar3,1,30)   = nv_basevar4
        SUBSTRING(nv_basevar3,31,30)  = nv_basevar5. 
    /*---------- SI plus -------------*/
     ASSIGN nv_sivar3 = ""
        nv_sicod3    = IF (impdata_fil.covcod = "2.1") THEN "SI21"
                       ELSE IF (impdata_fil.covcod = "2.2") THEN "SI22" 
                       ELSE IF (impdata_fil.covcod = "3.1") THEN "SI31"  ELSE "SI32" 
        nv_sivar4    = "     Own Damage = "                                                                                              
        nv_sivar5    =  string(INT(impdata_fil.siplus)) 
        impdata_fil.si   =  INT(impdata_fil.siplus) 
        SUBSTRING(nv_sivar3,1,30)  = nv_sivar4
        SUBSTRING(nv_sivar3,31,30) = nv_sivar5 .
        nv_siprm3    = DECI(impdata_fil.siplus) .
    /*----------- PD --------------*/
    ASSIGN nv_pdavar    = ""
         nv_pdacod      = "PD"
         nv_pdavar1     = "     PD per Accident = " 
         nv_pdavar2     = string(deci(sic_bran.uwm130.uom5_v))        
         SUBSTRING(nv_pdavar,1,30)  = nv_pdavar1
         SUBSTRING(nv_pdavar,31,30) = nv_pdavar2.
     
     /*--------------- deduct ----------------*/
     /* caculate deduct OD  */
     ASSIGN dod0 = 0
            dod1 = 0
            dod2 = 0
            dpd0 = 0 .
     /* add by : A65-0043 */
     IF impdata_fil.dod <> 0  THEN DO:
         dod0 = impdata_fil.dod.
         IF SUBSTR(impdata_fil.subclass,1,1) = "6"  THEN DO:    
             IF dod0 > 1000 THEN DO:
                dod1 = 1000.
                dod2 = dod0 - dod1.
            END.
            ELSE dod1 = dod0.
         END.
         ELSE DO:
            IF dod0 > 3000 THEN DO:
                dod1 = 3000.
                dod2 = dod0 - dod1.
            END.
            ELSE dod1 = dod0.
         END.
     END.
     /* end : A65-0043 */
     /* comment by : A65-0043...
     IF impdata_fil.dod <> 0  THEN DO: 
         dod0 = impdata_fil.dod .
         IF dod0 > 3000 THEN DO:
            dod1 = 3000.
            dod2 = dod0 - dod1.
         END.
         ELSE dod1 = dod0.
     END.
     ...end : A65-0043...*/
     nv_dedod1var = "" . 
     nv_dedod2var = "" .
     IF dod1 <> 0 THEN DO:
        ASSIGN DOD2        = 0
             nv_odcod    = "DC01"
             nv_prem     =  dod1 
             nv_sivar2   =  "" . 
         RUN Wgs\Wgsmx024( nv_tariff,              
                           nv_odcod,
                           nv_class,
                           nv_key_b,
                           nv_comdat,
                           INPUT-OUTPUT nv_prem,
                           OUTPUT nv_chk ,
                           OUTPUT nv_baseap). 
         IF NOT nv_chk THEN DO:
             MESSAGE  " DEDUCTIBLE EXCEED THE LIMIT " nv_baseap nv_prem   View-as alert-box.
             ASSIGN
                 impdata_fil.pass    = "N"
                 impdata_fil.comment = impdata_fil.comment + "| DEDUCTIBLE EXCEED THE LIMIT ".
         END.
         /*dod*/
    
      ASSIGN
          nv_dedod1var      = ""
          nv_dedod1_cod     = "DOD"
          nv_dedod1var1     = "     Deduct OD = "
          nv_dedod1var2     = STRING(dod1)
          SUBSTRING(nv_dedod1var,1,30)  = nv_dedod1var1
          SUBSTRING(nv_dedod1var,31,30) = nv_dedod1var2  .
     END.
      /*add od*/
      IF dod2 <> 0 THEN
         Assign  
             nv_dedod2var   = " "
             nv_cons  = "AD"
             nv_ded   = dod2.
         Assign
             nv_aded1prm     = nv_prem
             nv_dedod2_cod   = "DOD2"
             nv_dedod2var1   = "     Add Ded.OD = "
             nv_dedod2var2   =  STRING(dod2)
             SUBSTRING(nv_dedod2var,1,30)  = nv_dedod2var1
             SUBSTRING(nv_dedod2var,31,30) = nv_dedod2var2
             nv_dedod2_prm   = nv_prem.
  
     /***** pd *******/
     nv_dedpdvar = "" .
     IF impdata_fil.dpd <> 0  THEN DO:
         dpd0 = impdata_fil.dpd .
        Assign
            nv_dedpdvar  = " "
            nv_cons  = "PD"
            nv_ded   = dpd0.
        ASSIGN
            nv_dedpd_cod   = "DPD"
            nv_dedpdvar1   = "     Deduct PD = "
            nv_dedpdvar2   =  STRING(nv_ded)
            SUBSTRING(nv_dedpdvar,1,30)    = nv_dedpdvar1
            SUBSTRING(nv_dedpdvar,31,30)   = nv_dedpdvar2
            nv_dedpd_prm  = nv_prem  .    /*A57-0177*/
     END.
      /*---------- fleet -------------------*/
     nv_flet_per = INTE(impdata_fil.fleet).
     IF nv_flet_per <> 0 AND  nv_flet_per <> 10 Then do:
         Message  " Fleet Percent must be 0 or 10. " View-as alert-box.
         ASSIGN
             impdata_fil.pass    = "N"
             impdata_fil.comment = impdata_fil.comment + "| Fleet Percent must be 0 or 10. ".
     End.
     IF nv_flet_per = 0 Then do:
         ASSIGN nv_flet     = 0
             nv_fletvar  = " ".
     End.
     ELSE DO:
        ASSIGN  nv_fletvar     = " "
            nv_fletvar1    = "     Fleet % = "
            nv_fletvar2    =  STRING(nv_flet_per)
            SUBSTRING(nv_fletvar,1,30)     = nv_fletvar1
            SUBSTRING(nv_fletvar,31,30)    = nv_fletvar2.
     END.
     IF nv_flet   = 0  THEN nv_fletvar  = " ".
     /*---------------- NCB -------------------*/
     NV_NCBPER = INTE(impdata_fil.NCB).
     nv_ncbvar = " ".
     If nv_ncbper  <> 0 Then do:
         Find first sicsyac.xmm104 Use-index xmm10401 Where
             sicsyac.xmm104.tariff = nv_tariff           AND
             sicsyac.xmm104.class  = nv_class            AND 
             sicsyac.xmm104.covcod = nv_covcod           AND 
             sicsyac.xmm104.ncbper   = INTE(impdata_fil.ncb) No-lock no-error no-wait.
         IF not avail  sicsyac.xmm104  Then do:
             Message " This NCB Step not on NCB Rates file xmm104. " View-as alert-box.
             ASSIGN 
                 impdata_fil.pass    = "N"
                 impdata_fil.comment = impdata_fil.comment + "| This NCB Step not on NCB Rates file xmm104. ".
         END.
         ELSE ASSIGN nv_ncbper = sicsyac.xmm104.ncbper   
                     nv_ncbyrs = sicsyac.xmm104.ncbyrs.
     END.
     Else do:  
         ASSIGN nv_ncbyrs =   0
             nv_ncbper    =   0
             nv_ncb       =   0.
     END.
     
     nv_ncbvar   = " ".
     IF  nv_ncb <> 0  THEN
         ASSIGN 
         nv_ncbvar1   = "     NCB % = "
         nv_ncbvar2   =  STRING(nv_ncbper)
         SUBSTRING(nv_ncbvar,1,30)    = nv_ncbvar1
         SUBSTRING(nv_ncbvar,31,30)   = nv_ncbvar2.
     
     /*------------------ dsspc ---------------*/
      IF  nv_dss_per   <> 0  THEN 
          ASSIGN nv_dsspcvar = " "
          nv_dsspcvar1   = "     Discount Special % = "
          nv_dsspcvar2   =  STRING(nv_dss_per)
          SUBSTRING(nv_dsspcvar,1,30)    = nv_dsspcvar1
          SUBSTRING(nv_dsspcvar,31,30)   = nv_dsspcvar2.
      /*--------------------------*/
    /*----------- CL ------------*/
    nv_clmvar  = " ".                                    
    nv_cl_per  = DECI(impdata_fil.claim). /*A60-0150*/      
    IF nv_cl_per  <> 0  THEN                             
        Assign                                           
        nv_clmvar1   = " Load Claim % = "                
        nv_clmvar2   =  STRING(nv_cl_per)                
        SUBSTRING(nv_clmvar,1,30)    = nv_clmvar1        
        SUBSTRING(nv_clmvar,31,30)   = nv_clmvar2.       
              
                                                         
    /* *------------------ stf ---------------*/         
    nv_stfvar   = " ".                                   
    nv_stf_per  = DECI(impdata_fil.dstf). /*A60-0150*/    
    IF  nv_stf_per   <> 0  THEN                          
    Assign                                               
         nv_stfvar1   = "     Discount Staff"            
         nv_stfvar2   =  STRING(nv_stf_per)              
         SUBSTRING(nv_stfvar,1,30)    = nv_stfvar1       
         SUBSTRING(nv_stfvar,31,30)   = nv_stfvar2.  
   
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_baseplus C-Win 
PROCEDURE proc_baseplus :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN 
    nv_baseprm3 = 0 
    NO_basemsg = " " .  
    FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
           sicsyac.xmm106.tariff =  nv_tariff   AND
           sicsyac.xmm106.bencod =  nv_basecod3 AND
           sicsyac.xmm106.covcod =  nv_covcod   AND
           sicsyac.xmm106.class  =  nv_class    AND
           sicsyac.xmm106.key_b  GE nv_key_b    AND
           sicsyac.xmm106.effdat LE nv_comdat
        NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicsyac.xmm106 THEN DO:
       nv_baseprm3 = sicsyac.xmm106.min_ap.
    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_calpremt C-Win 
PROCEDURE proc_calpremt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: /* Add by  : A67-0029 */      
------------------------------------------------------------------------------*/
/*comment by : A68-0044...
DEF VAR chk     AS LOGICAL.
DEF VAR n_prem  AS DECI.

FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.

IF impdata_fil.poltyp = "V70" THEN DO:
    ASSIGN fi_process = "Create data to base..." + impdata_fil.policy .
    DISP fi_process WITH FRAM fr_main.
    RUN proc_initcalprem.  /*A65-0079*/
    ASSIGN     
          /*nv_cstflg  = "C"  /*C=CC ; S=Seat ; T=Tons ; W=Watts*/ 
         nv_engcst  = 1900*/ /* ต้องใส่ค่าตาม nv_cstflg         
         nv_drivno  = 0   */
         /*nv_supe    = NO*/  
         nv_usrid    = USERID(LDBNAME(1))  /*A65-0079*/
         nv_campcd   = impdata_fil.packcod /*A65-0079*/
         nv_covcod   = impdata_fil.covcod                                              
         nv_class    = trim(impdata_fil.prempa) + trim(impdata_fil.subclass)     /* T110 */                                     
         nv_vehuse   = impdata_fil.vehuse   
         nv_driage1  = nv_drivage1                                 
         nv_driage2  = nv_drivage2                                    
         nv_yrmanu   = INT(impdata_fil.yrmanu)                         
         nv_totsi    = sic_bran.uwm130.uom6_v       
         nv_totfi    = sic_bran.uwm130.uom7_v
         nv_vehgrp   = impdata_fil.cargrp                                                     
         nv_access   = IF impdata_fil.special  <> "A" THEN "" ELSE TRIM(impdata_fil.special)                                                  
         nv_tpbi1si  = nv_uom1_v             
         nv_tpbi2si  = nv_uom2_v             
         nv_tppdsi   = nv_uom5_v             
         nv_411si    = impdata_fil.NO_411      
         nv_412si    = impdata_fil.NO_412      
         nv_413si    = impdata_fil.NO_413                      
         nv_414si    = impdata_fil.NO_414                    
         nv_42si     = impdata_fil.no_42               
         nv_43si     = impdata_fil.no_43  
         nv_411prmt  = impdata_fil.ry01
         nv_412prmt  = impdata_fil.deci1    /*A65-0079*/
         nv_413prmt  = impdata_fil.deci2    /*A65-0079*/
         nv_414prmt  = impdata_fil.deci3    /*A65-0079*/
         nv_42prmt   = impdata_fil.ry02
         nv_43prmt   = impdata_fil.ry03
         nv_seat41   = impdata_fil.seat41   
         nv_dedod    = dod1      
         nv_addod    = dod2                                
         nv_dedpd    = deci(impdata_fil.DPD)                                    
         nv_ncbp     = deci(impdata_fil.ncb)                                     
         nv_fletp    = deci(impdata_fil.fleet)                                  
         nv_dspcp    = deci(impdata_fil.dspc)                                      
         nv_dstfp    = deci(impdata_fil.dstf)                                                    
         nv_clmp     = deci(impdata_fil.claim)
         /* Add : A65-0079 */
         nv_mainprm  = IF INT(impdata_fil.unname) <> 0 THEN deci(impdata_fil.unname) 
                       ELSE deci(impdata_fil.nname) 
         nv_dodamt   = deci(impdata_fil.int1)
         nv_dadamt   = deci(impdata_fil.int2)
         nv_dpdamt   = deci(impdata_fil.int3)
         nv_ncbamt   = deci(impdata_fil.ncbprem)
         nv_fletamt  = deci(impdata_fil.fleetprem) 
         nv_dspcamt  = deci(impdata_fil.dspcprem)  
         nv_dstfamt  = deci(impdata_fil.dstfprem)  
         nv_clmamt   = deci(impdata_fil.clprem)
         /* end : A65-0079*/
         nv_baseprm  = deci(impdata_fil.base) 
         nv_baseprm3 = deci(impdata_fil.baseplus) 
         nv_pdprem   = 0
         nv_netprem  = DECI(impdata_fil.premt) /* เบี้ยสุทธิ */                                                
         nv_gapprm   = 0                                                       
         nv_flagprm  = "N"                 /* N = เบี้ยสุทธิ, G = เบี้ยรวม */                                    
         nv_effdat   = sic_bran.uwm100.comdat  
         nv_level    = nv_drivlevel  /*A67-0029*/
         nv_ratatt   = 0                    
         nv_siatt    = 0                                                   
         nv_netatt   = 0 
         nv_fltatt   = 0 
         nv_ncbatt   = 0 
         nv_dscatt   = 0      
         nv_attgap   = 0 
         nv_atfltgap = 0 
         nv_atncbgap = 0 
         nv_atdscgap = 0 
         nv_packatt  = "" 
         /*nv_status  = "" */
         nv_flgsht  = IF impdata_fil.srate = "Y" THEN "S" ELSE "P" /*A65-0079*/
         nv_fcctv   = IF impdata_fil.cctv <> "" THEN YES ELSE NO . 

     ASSIGN  nv_adjpaprm = IF nv_411prmt <> 0 OR nv_412prmt <> 0 OR nv_413prmt <> 0 OR nv_414prmt <> 0 OR nv_42prmt <> 0 OR nv_43prmt <> 0 THEN YES ELSE NO. /*F68-0001*/

     FIND FIRST stat.clastab_fil USE-INDEX clastab01 WHERE
           clastab_fil.CLASS  = nv_class     AND
           clastab_fil.covcod = impdata_fil.covcod    NO-LOCK NO-ERROR.
        IF AVAIL stat.clastab_fil THEN DO:
            IF clastab_fil.unit = "C" THEN DO:
                ASSIGN
                    nv_cstflg = IF SUBSTR(nv_class,5,1) = "E" THEN "W" ELSE clastab_fil.unit
                    nv_engine = IF SUBSTR(nv_class,5,1) = "E" THEN DECI(impdata_fil.watt) ELSE INT(impdata_fil.engcc).
            END.
            ELSE IF clastab_fil.unit = "S" THEN DO:
                ASSIGN
                    nv_cstflg = clastab_fil.unit
                    nv_engine = INT(impdata_fil.seat).
            END.
            ELSE IF clastab_fil.unit = "T" THEN DO:
                ASSIGN
                    nv_cstflg = clastab_fil.unit
                    nv_engine = DECI(sic_bran.uwm301.Tons).
            END.
            nv_engcst = nv_engine .
        END.
    IF nv_cstflg = "W" THEN ASSIGN sic_bran.uwm301.watt = nv_engine . /* add  */
    IF impdata_fil.redbook = ""  THEN DO:
        IF nv_cstflg <> "T" THEN DO:
            /*RUN wgw/wgwredbook(input  impdata_fil.brand ,  */ /*A65-0079*/
              RUN wgw/wgwredbk1(input impdata_fil.brand ,   /*A65-0079*/
                               input  impdata_fil.model ,  
                               input  nv_totsi      ,  
                               INPUT  impdata_fil.tariff,  
                               input  SUBSTR(nv_class,2,5),   
                               input  impdata_fil.yrmanu, 
                               input  nv_engine  ,
                               input  0 , 
                               INPUT-OUTPUT impdata_fil.redbook) .
        END.
        ELSE DO:
            /*RUN wgw/wgwredbook(input  impdata_fil.brand ,  */ /*A65-0079*/
             RUN wgw/wgwredbk1(input  impdata_fil.brand ,   /*A65-0079*/  
                               input  impdata_fil.model ,  
                               input  INT(impdata_fil.si) ,  
                               INPUT  impdata_fil.tariff,  
                               input  SUBSTR(nv_class,2,5),   
                               input  impdata_fil.yrmanu, 
                               input  0  ,
                               input  nv_engine , 
                               INPUT-OUTPUT impdata_fil.redbook) .
        END.

        IF impdata_fil.redbook <> ""  THEN ASSIGN sic_bran.uwm301.modcod = impdata_fil.redbook .
        ELSE DO:
         ASSIGN
                impdata_fil.comment = impdata_fil.comment + "| " + "Redbook is Null !! "
                impdata_fil.WARNING = "Redbook เป็นค่าว่างไม่สามารถนำเข้ามูลเข้าได้ " .
                impdata_fil.pass  = "N".  /*A65-0079*/
        END.
    END.

    FIND LAST stat.maktab_fil WHERE maktab_fil.makdes   =  impdata_fil.brand AND 
                                    maktab_fil.sclass   =  trim(SUBSTR(nv_class,2,4)) NO-LOCK NO-ERROR.
        IF AVAIL stat.maktab_fil THEN nv_supe = maktab_fil.impchg.

    IF sic_bran.uwm100.expdat NE ? AND sic_bran.uwm100.comdat NE ? THEN DO:
        IF ( DAY(sic_bran.uwm100.comdat)     =  DAY(sic_bran.uwm100.expdat)     AND
           MONTH(sic_bran.uwm100.comdat)     =  MONTH(sic_bran.uwm100.expdat)   AND
            YEAR(sic_bran.uwm100.comdat) + 1 =  YEAR(sic_bran.uwm100.expdat) )  OR
           ( DAY(sic_bran.uwm100.comdat)     =   29                             AND
           MONTH(sic_bran.uwm100.comdat)     =   02                             AND
             DAY(sic_bran.uwm100.expdat)     =   01                             AND
           MONTH(sic_bran.uwm100.expdat)     =   03                             AND
            YEAR(sic_bran.uwm100.comdat) + 1 =  YEAR(sic_bran.uwm100.expdat) )
        THEN DO:
          nv_polday = 365.
        END.
        ELSE DO:
          nv_polday = (sic_bran.uwm100.expdat  - sic_bran.uwm100.comdat ) + 1 .     /* =  366  วัน */
        END.
    END.
    IF nv_polday < 365 THEN DO:
        nv_polday  = (sic_bran.uwm100.expdat  - sic_bran.uwm100.comdat) + 1.
    END.
    /*                      
    MESSAGE "  nv_policy   "  sic_bran.uwm100.policy     
            "  nv_rencnt   "  sic_bran.uwm100.rencnt    skip
            "  nv_riskno   "  nv_riskno     
            "  nv_itemno   "  nv_itemno     skip
            "  nv_batchyr  "  nv_batchyr    
            "  nv_batchno  "  nv_batchno    
            "  nv_batcnt   "  nv_batcnt     skip
            "  nv_polday   "  nv_polday     skip
            "  nv_covcod   "  nv_covcod     skip
            "  nv_class    "  nv_class      skip
            "  nv_vehuse   "  nv_vehuse     skip
            "  nv_cstflg   "  nv_cstflg     skip
            "  nv_engcst   "  nv_engcst     skip
            "  nv_drivno   "  nv_drivno     
            "  nv_driage1  "  nv_driage1    
            "  nv_driage2  "  nv_driage2    skip
            "  nv_yrmanu   "  nv_yrmanu     skip
            "  nv_totsi    "  nv_totsi      skip
            "  nv_vehgrp   "  nv_vehgrp     skip
            "  nv_access   "  nv_access     skip
            "  nv_supe     "  nv_supe       skip
            "  nv_tpbi1si  "  nv_tpbi1si    skip
            "  nv_tpbi2si  "  nv_tpbi2si    skip
            "  nv_tppdsi   "  nv_tppdsi     skip
            "  nv_411si    "  nv_411si      skip
            "  nv_412si    "  nv_412si      skip
            "  nv_413si    "  nv_413si      skip
            "  nv_414si    "  nv_414si      skip
            "  nv_42si     "  nv_42si       skip
            "  nv_43si     "  nv_43si       skip
            "  nv_41prmt   "  nv_41prmt     skip
            "  nv_42prmt   "  nv_42prmt     skip
            "  nv_43prmt   "  nv_43prmt     skip
            "  nv_seat41   "  nv_seat41     skip
            "  nv_dedod    "  nv_dedod      skip
            "  nv_addod    "  nv_addod      skip
            "  nv_dedpd    "  nv_dedpd      skip
            "  nv_ncbp     "  nv_ncbp       skip
            "  nv_fletp    "  nv_fletp      skip
            "  nv_dspcp    "  nv_dspcp      skip
            "  nv_dstfp    "  nv_dstfp      skip
            "  nv_clmp     "  nv_clmp       skip
            "  nv_baseprm  "  nv_baseprm    skip
            "  nv_baseprm3 "  nv_baseprm3   skip
            "  nv_netprem  "  nv_netprem    skip
            "  nv_pdprem   "  nv_pdprem     skip
            "  nv_gapprem  "  nv_gapprem    skip
            "  nv_flagprm  "  nv_flagprm    skip
            "  nv_effdat   "  nv_effdat     skip
            "  nv_status   "  nv_status     skip
            "  nv_fcctv    "  nv_fcctv      skip
            "  nv_uom1_c   "  nv_uom1_c     skip
            "  nv_uom2_c   "  nv_uom2_c     skip
            "  nv_uom5_c   "  nv_uom5_c     skip
            "  nv_uom6_c   "  nv_uom6_c     skip
            "  nv_uom7_c   "  nv_uom7_c     skip
            "  nv_message  "  nv_message    skip
            "  nv_ratatt   "  nv_ratatt     skip
            "  nv_siatt    "  nv_siatt      skip
            "  nv_netatt   "  nv_netatt     skip
            "  nv_fltatt   "  nv_fltatt     skip
            "  nv_ncbatt   "  nv_ncbatt     skip
            "  nv_dscatt   "  nv_dscatt    VIEW-AS ALERT-BOX.*/
    RUN WUW\WUWPADP3.P(INPUT sic_bran.uwm100.policy,
                       INPUT nv_campcd , 
                       INPUT sic_bran.uwm100.rencnt,
                       INPUT sic_bran.uwm100.endcnt,
                       INPUT 0  ,
                       INPUT nv_riskno ,
                       INPUT nv_itemno ,  
                       INPUT nv_batchyr, 
                       INPUT nv_batchno,
                       INPUT nv_batcnt , 
                       INPUT nv_polday ,
                       INPUT nv_usrid  ,
                       INPUT "wgwlfeet"  ,
                       INPUT-OUTPUT nv_covcod ,
                       INPUT-OUTPUT nv_class  ,
                       INPUT-OUTPUT nv_vehuse ,
                       INPUT-OUTPUT nv_cstflg ,
                       INPUT-OUTPUT nv_engcst ,
                       INPUT-OUTPUT nv_drivno ,
                       INPUT-OUTPUT nv_driage1,
                       INPUT-OUTPUT nv_driage2,
                       INPUT-OUTPUT nv_pdprm0 , 
                       INPUT-OUTPUT nv_yrmanu ,
                       INPUT-OUTPUT nv_totsi  ,
                       INPUT-OUTPUT nv_totfi  ,
                       INPUT-OUTPUT nv_vehgrp,  
                       INPUT-OUTPUT nv_access,  
                       INPUT-OUTPUT nv_supe,                       
                       INPUT-OUTPUT nv_tpbi1si, 
                       INPUT-OUTPUT nv_tpbi2si, 
                       INPUT-OUTPUT nv_tppdsi,                 
                       INPUT-OUTPUT nv_411si,   
                       INPUT-OUTPUT nv_412si,   
                       INPUT-OUTPUT nv_413si,   
                       INPUT-OUTPUT nv_414si,   
                       INPUT-OUTPUT nv_42si,    
                       INPUT-OUTPUT nv_43si,
                       INPUT-OUTPUT nv_411prmt,   /* ระบุเบี้ย รย.*/
                       INPUT-OUTPUT nv_412prmt,   /* ระบุเบี้ย รย.*/
                       INPUT-OUTPUT nv_413prmt,   /* ระบุเบี้ย รย.*/
                       INPUT-OUTPUT nv_414prmt,   /* ระบุเบี้ย รย.*/
                       INput-output nv_42prmt,   /* ระบุเบี้ย รย.*/
                       INput-output nv_43prmt,   /* ระบุเบี้ย รย.*/
                       INPUT-OUTPUT nv_seat41,              
                       INPUT-OUTPUT nv_dedod,    
                       INPUT-OUTPUT nv_addod,    
                       INPUT-OUTPUT nv_dedpd,    
                       input-output nv_dodamt,   /* ระบุเบี้ย DOD */ 
                       input-output nv_dadamt,   /* ระบุเบี้ย DOD1 */ 
                       input-output nv_dpdamt,   /* ระบุเบี้ย DPD */ 
                       INPUT-OUTPUT nv_ncbp,     
                       INPUT-OUTPUT nv_fletp,    
                       INPUT-OUTPUT nv_dspcp,    
                       INPUT-OUTPUT nv_dstfp,    
                       INPUT-OUTPUT nv_clmp,     
                       input-output nv_ncbamt ,  /* ระบุเบี้ย  NCB PREMIUM */       
                       input-output nv_fletamt,  /* ระบุเบี้ย  FLEET PREMIUM */     
                       input-output nv_dspcamt,  /* ระบุเบี้ย  DSPC PREMIUM */      
                       input-output nv_dstfamt,  /* ระบุเบี้ย  DSTF PREMIUM */      
                       input-output nv_clmamt ,  /* ระบุเบี้ย  LOAD CLAIM PREMIUM */
                       INPUT-OUTPUT nv_baseprm,
                       INPUT-OUTPUT nv_baseprm3,
                       INPUT-OUTPUT nv_mainprm,  /* Main Premium หรือเบี้ยหลัก ช่อง Name/Unname Premium (HG) */
                       INPUT-OUTPUT nv_pdprem,
                       INPUT-OUTPUT nv_netprem, 
                       INPUT-OUTPUT nv_gapprem,  
                       INPUT-OUTPUT nv_flagprm,             
                       INPUT-OUTPUT nv_effdat,
                       INPUT-OUTPUT nv_ratatt, 
                       INPUT-OUTPUT nv_siatt ,
                       INPUT-OUTPUT nv_netatt,    
                       INPUT-OUTPUT nv_fltatt, 
                       INPUT-OUTPUT nv_ncbatt, 
                       INPUT-OUTPUT nv_dscatt,
                       input-output nv_attgap ,   /*a65-0079*/
                       input-output nv_atfltgap,  /*a65-0079*/
                       input-output nv_atncbgap,  /*a65-0079*/
                       input-output nv_atdscgap,  /*a65-0079*/
                       input-output nv_packatt ,  /*a65-0079*/
                       INPUT-OUTPUT nv_fcctv ,  /* cctv = yes/no */
                       INPUT-OUTPUT nv_flgsht , /* Short rate = "S" , Pro rate = "P" */
                       INPUT-OUTPUT nv_level , /* A67-0029*/
                       OUTPUT nv_uom1_c ,  
                       OUTPUT nv_uom2_c ,  
                       OUTPUT nv_uom5_c ,  
                       OUTPUT nv_uom6_c ,
                       OUTPUT nv_uom7_c ,
                       output nv_gapprm ,
                       output nv_pdprm  ,
                       OUTPUT nv_status ,
                       OUTPUT nv_message ).
    ASSIGN                        
        sic_bran.uwm130.uom1_c  = nv_uom1_c
        sic_bran.uwm130.uom2_c  = nv_uom2_c
        sic_bran.uwm130.uom5_c  = nv_uom5_c
        sic_bran.uwm130.uom6_c  = nv_uom6_c
        sic_bran.uwm130.uom7_c  = nv_uom7_c .

    ASSIGN sic_bran.uwm130.chr3 = IF nv_adjpaprm = YES THEN "YES" ELSE "NO" .  /*F68-0001*/
    IF nv_drivno <> 0  THEN ASSIGN sic_bran.uwm301.actprm = nv_pdprm0. 
    /*IF nv_status = "NO" THEN DO:*/
    IF nv_message <> "" THEN DO:   /*A65-0079*/
        IF INDEX(nv_message,"Not Found Benefit") <> 0 THEN ASSIGN impdata_fil.pass  = "N". /*A65-0043*/
        ASSIGN
                impdata_fil.comment = impdata_fil.comment + "|" + nv_message
                impdata_fil.WARNING = impdata_fil.WARNING + "|" + nv_message.
                /*impdata_fil.pass    = "N".*/
    END.
    
END.
...end : A68-0044*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_calpremt_EV C-Win 
PROCEDURE proc_calpremt_EV :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR chk     AS LOGICAL.
DEF VAR n_prem  AS DECI.
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.
IF impdata_fil.poltyp = "V70" THEN DO:
        ASSIGN fi_process = "Create data to base..." + impdata_fil.policy .
        DISP fi_process WITH FRAM fr_main.
        RUN proc_initcalprem.  /*A65-0079*/
        ASSIGN   
            nv_usrid    = USERID(LDBNAME(1))  /*A65-0079*/
            nv_campcd   = impdata_fil.packcod /*A65-0079*/
            nv_covcod  = impdata_fil.covcod                                              
            nv_class   = trim(impdata_fil.prempa) + trim(impdata_fil.subclass)     /* T110 */                                     
            nv_vehuse  = impdata_fil.vehuse   
            nv_driage1 = nv_drivage1                                 
            nv_driage2 = nv_drivage2                                    
            nv_yrmanu  = INT(impdata_fil.yrmanu)         
            nv_totsi   = IF sic_bran.uwm130.uom6_v = 0 THEN sic_bran.uwm130.uom7_v ELSE sic_bran.uwm130.uom6_v /*A66-0202*/
            nv_totfi   = sic_bran.uwm130.uom7_v
            nv_vehgrp  = impdata_fil.cargrp                                                     
            nv_access  = IF impdata_fil.special <> "A" THEN "" ELSE TRIM(impdata_fil.special)                                          
            nv_tpbi1si = nv_uom1_v             
            nv_tpbi2si = nv_uom2_v             
            nv_tppdsi  = nv_uom5_v             
            nv_411si   = impdata_fil.NO_411       
            nv_412si   = impdata_fil.NO_412       
            nv_413si   = impdata_fil.NO_413                       
            nv_414si   = impdata_fil.NO_414                     
            nv_42si    = impdata_fil.no_42                
            nv_43si    = impdata_fil.no_43 
            nv_411prmt = impdata_fil.ry01                    
            nv_412prmt = impdata_fil.deci1    /*A65-0079*/  
            nv_413prmt = impdata_fil.deci2    /*A65-0079*/  
            nv_414prmt = impdata_fil.deci3    /*A65-0079*/  
            nv_42prmt  = impdata_fil.ry02
            nv_43prmt  = impdata_fil.ry03
            nv_seat41  = impdata_fil.seat41 
            nv_dedod   = dod1      
            nv_addod   = dod2                                
            nv_dedpd   = deci(impdata_fil.DPD)                                    
            nv_ncbp    = deci(impdata_fil.ncb)                                     
            nv_fletp   = deci(impdata_fil.fleet)                                  
            nv_dspcp   = deci(impdata_fil.dspc)                                      
            nv_dstfp   = deci(impdata_fil.dstf)                                                    
            nv_clmp    = deci(impdata_fil.claim)
            /* Add : A65-0079 */
            nv_mainprm  = IF INT(impdata_fil.unname) <> 0 THEN deci(impdata_fil.unname) ELSE deci(impdata_fil.nname) 
            nv_dodamt   = deci(impdata_fil.int1)
            nv_dadamt   = deci(impdata_fil.int2)
            nv_dpdamt   = deci(impdata_fil.int3)
            nv_ncbamt   = deci(impdata_fil.ncbprem)
            nv_fletamt  = deci(impdata_fil.fleetprem) 
            nv_dspcamt  = deci(impdata_fil.dspcprem)  
            nv_dstfamt  = deci(impdata_fil.dstfprem)  
            nv_clmamt   = deci(impdata_fil.clprem)
            /* end : A65-0079*/
            nv_baseprm  = deci(impdata_fil.base)
            nv_baseprm3 = deci(impdata_fil.baseplus) 
            nv_netprem  = DECI(impdata_fil.premt) /* เบี้ยสุทธิ เบี้ยเต็มปี */  
            nv_pdprem   = DECI(impdata_fil.premt) /* เบี้ยสุทธิ เบี้ยเต็มปี */
            nv_gapprem  = DECI(impdata_fil.premt)
            nv_gapprm   = 0                                                     
            nv_flagprm  = "N" /* N = เบี้ยสุทธิ, G = เบี้ยรวม */                                    
            nv_effdat   = sic_bran.uwm100.comdat
            nv_ratatt   = 0  /*dgrate)   */                     
            nv_siatt    = 0  /*dgsi)     */                                                   
            nv_netatt   = 0  /*dgprem)   */       
            nv_fltatt   = 0  /*dgfeet)   */      
            nv_ncbatt   = 0  /*dgncb)    */      
            nv_dscatt   = 0  /*dgdisc)   */
            nv_attgap   = 0  /*dgatt)    */
            nv_atfltgap = 0  /*dgfeetprm)*/
            nv_atncbgap = 0  /*dgncbprm) */
            nv_atdscgap = 0  /*dgdiscprm)*/ 
            nv_packatt  = ""  /*dgpackge) */
            nv_flgsht   = IF impdata_fil.srate = "Y" THEN "S" ELSE "P" /*A65-0079*/
            nv_fcctv    = IF impdata_fil.cctv <> "" THEN YES ELSE NO 
            /* A67-0029*/
            nv_level    = nv_drivlevel  
            nv_levper   = nv_dlevper   
            nv_tariff   = impdata_fil.tariff
            nv_adjpaprm = IF nv_411prmt <> 0 OR nv_412prmt <> 0 OR nv_413prmt <> 0 OR nv_414prmt <> 0 OR nv_42prmt <> 0 OR nv_43prmt <> 0 THEN YES ELSE NO
            nv_flgpol   = IF impdata_fil.prepol = "" THEN "NR" ELSE "RN" /*NR=New RedPlate, NU=New Used Car, RN=Renew*/                   
            nv_flgclm   = IF nv_clmp <> 0 THEN "WC" ELSE "NC"  /*NC=NO CLAIM , WC=With Claim*/  
            nv_chgflg   = IF DECI(impdata_fil.chargprm) <> 0 THEN YES ELSE NO    
            nv_chgrate  = DECI(impdata_fil.chargrate)                     
            nv_chgsi    = INTE(impdata_fil.chargsi)                                     
            nv_chgpdprm   = DECI(impdata_fil.chargprm)                                     
            nv_chggapprm  = 0                                     
            nv_battflg    = IF DECI(impdata_fil.battprm) <> 0 THEN YES ELSE NO
            nv_battsi     = INTE(impdata_fil.battsi)                                     
            nv_battprice  = INTE(impdata_fil.battprice)                     
            nv_battpdprm  = DECI(impdata_fil.battprm)                                     
            nv_battgapprm = 0                                                                                                                     
            nv_battyr     = INTE(impdata_fil.battyr)    
            nv_battper    = DECI(impdata_fil.battper)
            nv_battrate   = DECI(impdata_fil.battrate)
            nv_evflg      = IF index(impdata_fil.subclass,"E") <> 0 THEN YES ELSE NO  
            nv_compprm    = 0   nv_uom9_v     = 0 
            /* end A67-0029*/
            nv_flag     = IF index(impdata_fil.subclass,"E") <> 0 THEN NO ELSE tg_flag  /*A68-0044*/   
            nv_garage   = TRIM(impdata_fil.garage) /*A68-0044*/   
            nv_31prmt   = DECI(impdata_fil.txt2)   /*A68-0044*/    
            nv_31rate   = DECI(impdata_fil.txt1) . /*A68-0044*/               
         FIND FIRST stat.clastab_fil USE-INDEX clastab01 WHERE
               clastab_fil.CLASS  = nv_class     AND
               clastab_fil.covcod = impdata_fil.covcod    NO-LOCK NO-ERROR.
            IF AVAIL stat.clastab_fil THEN DO:
                IF clastab_fil.unit = "C" THEN DO:
                    ASSIGN nv_cstflg = IF SUBSTR(nv_class,5,1) = "E" OR SUBSTR(nv_class,2,1) = "E" THEN "H" ELSE clastab_fil.unit
                           nv_engine = IF SUBSTR(nv_class,5,1) = "E" OR SUBSTR(nv_class,2,1) = "E" THEN DECI(impdata_fil.watt) ELSE INT(impdata_fil.engcc).
                END.
                ELSE IF clastab_fil.unit = "S" THEN DO:
                    ASSIGN nv_cstflg = clastab_fil.unit     nv_engine = INT(impdata_fil.seat).
                END.
                ELSE IF clastab_fil.unit = "T" THEN DO:
                    ASSIGN nv_cstflg = clastab_fil.unit     nv_engine = DECI(sic_bran.uwm301.Tons).
                END.
                ELSE IF clastab_fil.unit = "H" THEN DO:
                    ASSIGN nv_cstflg = clastab_fil.unit     nv_engine = DECI(impdata_fil.watt). 
                END.
                nv_engcst = nv_engine .
            END.
        IF impdata_fil.redbook = ""  THEN DO:
            IF nv_cstflg = "H"  THEN DO:
                RUN wgw/wgwredbev(input  impdata_fil.brand ,      
                                       input  impdata_fil.model ,  
                                       input  INT(impdata_fil.si) ,  
                                       INPUT  impdata_fil.tariff,  
                                       input  SUBSTR(nv_class,2,5),   
                                       input  impdata_fil.yrmanu, 
                                       input  nv_engine , 
                                       input  0,
                                       INPUT-OUTPUT impdata_fil.maksi,
                                       INPUT-OUTPUT impdata_fil.redbook) .
            END.
            ELSE IF nv_cstflg <> "T" THEN DO:
               RUN wgw/wgwredbk1(input impdata_fil.brand ,   /*A65-0079*/
                                input  impdata_fil.model ,  
                                input  nv_totsi      ,  
                                INPUT  impdata_fil.tariff,  
                                input  SUBSTR(nv_class,2,5),   
                                input  impdata_fil.yrmanu, 
                                input  nv_engine  ,
                                input  0 , 
                                INPUT-OUTPUT impdata_fil.redbook) .
            END.
            ELSE DO:
              RUN wgw/wgwredbk1(input  impdata_fil.brand ,   /*A65-0079*/  
                                input  impdata_fil.model ,  
                                input  INT(impdata_fil.si) ,  
                                INPUT  impdata_fil.tariff,  
                                input  SUBSTR(nv_class,2,5),   
                                input  impdata_fil.yrmanu, 
                                input  0  ,
                                input  nv_engine , 
                                INPUT-OUTPUT impdata_fil.redbook) .
            END.
           IF impdata_fil.redbook <> "" THEN RUN proc_chkredbook. /*A68-0044*/
           ELSE DO:
            ASSIGN impdata_fil.comment = impdata_fil.comment + "| " + "Redbook is Null !! "
                   impdata_fil.WARNING = "Redbook เป็นค่าว่างไม่สามารถนำเข้ามูลเข้าได้ "  .
                   impdata_fil.pass    = "N". /*A65-0079*/
           END.
        END.
        FIND LAST stat.maktab_fil WHERE maktab_fil.makdes   =  impdata_fil.brand AND 
                                        maktab_fil.sclass   =  trim(SUBSTR(nv_class,2,4)) NO-LOCK NO-ERROR.
            IF AVAIL stat.maktab_fil THEN nv_supe = maktab_fil.impchg.
        IF sic_bran.uwm100.expdat NE ? AND sic_bran.uwm100.comdat NE ? THEN DO:
            IF ( DAY(sic_bran.uwm100.comdat)     =  DAY(sic_bran.uwm100.expdat)     AND
               MONTH(sic_bran.uwm100.comdat)     =  MONTH(sic_bran.uwm100.expdat)   AND
                YEAR(sic_bran.uwm100.comdat) + 1 =  YEAR(sic_bran.uwm100.expdat) )  OR
               ( DAY(sic_bran.uwm100.comdat)     =   29                             AND
               MONTH(sic_bran.uwm100.comdat)     =   02                             AND
                 DAY(sic_bran.uwm100.expdat)     =   01                             AND
               MONTH(sic_bran.uwm100.expdat)     =   03                             AND
                YEAR(sic_bran.uwm100.comdat) + 1 =  YEAR(sic_bran.uwm100.expdat) )
            THEN DO:
              nv_polday = 365.
            END.
            ELSE DO:
              nv_polday = (sic_bran.uwm100.expdat  - sic_bran.uwm100.comdat ) + 1 .     /*    =  366  วัน */
            END.
        END.
        IF nv_polday < 365 THEN DO:
            nv_polday  = (sic_bran.uwm100.expdat  - sic_bran.uwm100.comdat) + 1.
        END.
   /* RUN WUW\WUWMCP01.P(INPUT sic_bran.uwm100.policy,*/
     RUN WUW\WUWMCP02.P(INPUT sic_bran.uwm100.policy,
                     INPUT nv_campcd ,
                     INPUT sic_bran.uwm100.rencnt,
                     INPUT sic_bran.uwm100.endcnt,
                     INPUT 0  , /*nv_riskgp*/
                     INPUT nv_riskno ,
                     INPUT nv_itemno ,
                     INPUT nv_batchyr,
                     INPUT nv_batchno,
                     INPUT nv_batcnt ,
                     INPUT nv_polday ,
                     INPUT nv_usrid  ,
                     INPUT "wgwlfleet"  ,
                     INPUT 3, /*nv_diffprm*/
                     INPUT nv_tariff,
                     INPUT nv_covcod,
                     INPUT nv_class ,
                     INPUT nv_vehuse,
                     INPUT nv_cstflg,
                     INPUT nv_engcst,
                     INPUT nv_drivno,
                     INPUT nv_driage1,
                     INPUT nv_driage2,
                     INPUT nv_level ,
                     INPUT nv_levper ,
                     INPUT nv_yrmanu,
                     INPUT nv_totsi ,
                     INPUT nv_totfi ,
                     INPUT nv_vehgrp,
                     INPUT nv_access,
                     INPUT nv_supe,
                     INPUT nv_tpbi1si,
                     INPUT nv_tpbi2si,
                     INPUT nv_tppdsi,
                     INPUT nv_411si,
                     INPUT nv_412si,
                     INPUT nv_413si,
                     INPUT nv_414si,
                     INPUT nv_42si,
                     INPUT nv_43si,
                     INPUT nv_411prmt,   
                     INPUT nv_412prmt,   
                     INPUT nv_413prmt,  
                     INPUT nv_414prmt,   
                     INPUT nv_42prmt,  
                     INPUT nv_43prmt,   
                     INPUT nv_seat41,
                     INPUT nv_dedod,
                     INPUT nv_addod,
                     INPUT nv_dedpd,
                     INPUT nv_dodamt,   
                     INPUT nv_dadamt,   
                     INPUT nv_dpdamt,   
                     INPUT nv_pdprem,
                     INPUT nv_gapprem,
                     INPUT nv_flagprm,
                     INPUT nv_effdat,
                     INPUT nv_adjpaprm,  /* yes/ No*/
                     INPUT YES ,         /* nv_adjprem yes/ No*/
                     INPUT nv_flgpol ,  /*NR=New RedPlate, NU=New Used Car, RN=Renew*/                   
                     INPUT nv_flgclm ,  /*NC=NO CLAIM , WC=With Claim*/                                  
                     INPUT 10,    /*cv_lfletper  = Limit Fleet % 10%*/                                                                                                                          
                     INPUT cv_lncbper,    /*cv_lncbper  = Limit NCB %  50%*/                                                                                                                           
                     INPUT 35,    /*cv_ldssper  = Limit DSPC % กรณีป้ายแดง 110  ส่ง 45%  นอกนั้นส่ง 30% 35%*/                                                                                  
                     INPUT 0 ,    /*cv_lclmper  = Limit Claim % กรณีให้ Load Claim ได้ New 0% or 50% , Renew 0% or 20 - 50%  0%*/                                                              
                     INPUT 0 ,    /*cv_ldstfper = Limit DSTF % 0%*/                                                                                                                            
                     INPUT NO,   /*nv_reflag   = กรณีไม่ต้องการ Re-Calculate ใส่ Yes*/                                                                                                        
                     INPUT-OUTPUT nv_ncbyrs ,                                                                                                                                                                 
                     INPUT-OUTPUT nv_ncbp,
                     INPUT-OUTPUT nv_fletp,
                     INPUT-OUTPUT nv_dspcp,
                     INPUT-OUTPUT nv_dstfp,
                     INPUT-OUTPUT nv_clmp,
                     INPUT-OUTPUT nv_pdprm0,
                     INPUT-OUTPUT nv_ncbamt ,  
                     INPUT-OUTPUT nv_fletamt, 
                     INPUT-OUTPUT nv_dspcamt,  /*  DSPC PREMIUM */
                     INPUT-OUTPUT nv_dstfamt,  /*  DSTF PREMIUM */
                     INPUT-OUTPUT nv_clmamt ,  /*  LOAD CLAIM PREMIUM */
                     INPUT-OUTPUT nv_baseprm,
                     INPUT-OUTPUT nv_baseprm3,
                     INPUT-OUTPUT nv_mainprm,  /* Main Premium Name/Unname Premium (HG) */
                     INPUT-OUTPUT nv_ratatt,
                     INPUT-OUTPUT nv_siatt ,
                     INPUT-OUTPUT nv_netatt,
                     INPUT-OUTPUT nv_fltatt,
                     INPUT-OUTPUT nv_ncbatt,
                     INPUT-OUTPUT nv_dscatt,
                     INPUT-OUTPUT nv_attgap , 
                     INPUT-OUTPUT nv_atfltgap,
                     INPUT-OUTPUT nv_atncbgap,
                     INPUT-OUTPUT nv_atdscgap,
                     INPUT-OUTPUT nv_packatt ,
                     INPUT-OUTPUT nv_chgflg ,   
                     INPUT-OUTPUT nv_chgrate,   
                     INPUT-OUTPUT nv_chgsi  ,   
                     INPUT-OUTPUT nv_chgpdprm,  
                     INPUT-OUTPUT nv_chggapprm,
                     INPUT-OUTPUT nv_battflg ,
                     INPUT-OUTPUT nv_battrate,
                     INPUT-OUTPUT nv_battsi  ,
                     INPUT-OUTPUT nv_battprice,
                     INPUT-OUTPUT nv_battpdprm,
                     INPUT-OUTPUT nv_battgapprm ,
                     INPUT-OUTPUT nv_battyr ,   
                     INPUT-OUTPUT nv_battper, 
                     INPUT-OUTPUT nv_flag,    /* tariff flag = yes/no A68-0044*/
                     INPUT-OUTPUT nv_garage , /* A68-0044*/
                     INPUT-OUTPUT nv_31prmt , /* A68-0044*/
                     INPUT-OUTPUT nv_31rate ,  /*A68-0044*/ 
                     INPUT-OUTPUT nv_compprm,   
                     INPUT-OUTPUT nv_uom9_v ,   
                     INPUT-OUTPUT nv_fcctv , /* cctv = yes/no */
                     INPUT-OUTPUT nv_flgsht , /* Short rate = "S" , Pro rate = "P" */
                     INPUT-OUTPUT nv_evflg , /* EV = yes/no */
                     OUTPUT nv_uom1_c,
                     OUTPUT nv_uom2_c,
                     OUTPUT nv_uom5_c,
                     OUTPUT nv_uom6_c,
                     OUTPUT nv_uom7_c,
                     output nv_gapprm,
                     output nv_pdprm ,
                     OUTPUT nv_status,
                     OUTPUT nv_message).
    ASSIGN  sic_bran.uwm130.uom1_c  = nv_uom1_c     sic_bran.uwm130.uom2_c  = nv_uom2_c
            sic_bran.uwm130.uom5_c  = nv_uom5_c     sic_bran.uwm130.uom6_c  = nv_uom6_c
            sic_bran.uwm130.uom7_c  = nv_uom7_c .
    IF nv_drivno <> 0  THEN ASSIGN sic_bran.uwm301.actprm = nv_pdprm0. 
    ASSIGN sic_bran.uwm130.chr3 = IF nv_adjpaprm = YES THEN "YES" ELSE "NO" .  /*F68-0001*/
    IF nv_message <> "" THEN DO:   /*A65-0079*/
        IF INDEX(nv_message,"Not Found Benefit") <> 0 THEN ASSIGN impdata_fil.pass  = "N". /*A65-0043*/
        ASSIGN  impdata_fil.comment = impdata_fil.comment + "|" + nv_message
                impdata_fil.WARNING = impdata_fil.WARNING + "|" + nv_message.
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_campaign110 C-Win 
PROCEDURE proc_campaign110 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: create by a64-0044       
------------------------------------------------------------------------------*/
def var n_model    as char format "x(30)" init "" .
DO:
    IF impdata_fil.engcc <= 2000  THEN DO:  /* 2000 CC */
        IF impdata_fil.cargrp <> "" AND impdata_fil.vehuse <> ""  THEN DO:
         FIND LAST stat.campaign_fil USE-INDEX campfil04  WHERE 
             stat.campaign_fil.camcod = impdata_fil.packcod   AND /* campaign no */
             stat.campaign_fil.sclass = impdata_fil.subclass  AND /* class 110 210 320 */
             stat.campaign_fil.covcod = impdata_fil.covcod    AND /* cover 1 2 3 2.1 2.2 3.1 3.2 */
             stat.campaign_fil.vehgrp = impdata_fil.cargrp    AND /* group car */
             stat.campaign_fil.vehuse = impdata_fil.vehuse    AND /* ประเภทการใช้รถ */
             stat.campaign_fil.garage = impdata_fil.garage          AND /* การซ่อม */
             stat.campaign_fil.maxyea = n_yr                    AND /* อายุรถ */
             stat.campaign_fil.engine <= 2000             AND /* cc */  
             stat.campaign_fil.simax  = deci(impdata_fil.si)        AND  /* ทุน */
             stat.campaign_fil.makdes = impdata_fil.brand     AND 
             (index(impdata_fil.model,stat.campaign_fil.moddes) <> 0  OR   /* Model */
             index(stat.campaign_fil.moddes,impdata_fil.model) <> 0 ) AND   /* Model */ /*A64-0044*/
             stat.campaign_fil.netprm  = impdata_fil.premt         NO-LOCK NO-ERROR.   
        END.
        ELSE DO:
            FIND LAST stat.campaign_fil USE-INDEX campfil04  WHERE 
             stat.campaign_fil.camcod = impdata_fil.packcod   AND /* campaign no */
             stat.campaign_fil.sclass = impdata_fil.subclass  AND /* class 110 210 320 */
             stat.campaign_fil.covcod = impdata_fil.covcod    AND /* cover 1 2 3 2.1 2.2 3.1 3.2 */
             stat.campaign_fil.garage = impdata_fil.garage    AND /* การซ่อม */
             stat.campaign_fil.maxyea = n_yr              AND /* อายุรถ */
             stat.campaign_fil.engine <= 2000             AND /* cc */  
             stat.campaign_fil.simax  = deci(impdata_fil.si)  AND  /* ทุน */
             stat.campaign_fil.makdes = impdata_fil.brand     AND 
             (index(impdata_fil.model,stat.campaign_fil.moddes) <> 0  OR   /* Model */
             index(stat.campaign_fil.moddes,impdata_fil.model) <> 0 ) AND   /* Model */ /*A64-0044*/
             stat.campaign_fil.netprm  = impdata_fil.premt         NO-LOCK NO-ERROR. 
        END.
    END.
    ELSE DO:  /* > 2000 CC */
        IF impdata_fil.cargrp <> "" AND impdata_fil.vehuse <> ""  THEN DO:
            FIND LAST stat.campaign_fil USE-INDEX campfil04  WHERE 
                stat.campaign_fil.camcod = impdata_fil.packcod   AND /* campaign no */
                stat.campaign_fil.sclass = impdata_fil.subclass  AND /* class 110 210 320 */
                stat.campaign_fil.covcod = impdata_fil.covcod    AND /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                stat.campaign_fil.vehgrp = impdata_fil.cargrp    AND /* group car */
                stat.campaign_fil.vehuse = impdata_fil.vehuse    AND /* ประเภทการใช้รถ */
                stat.campaign_fil.garage = impdata_fil.garage          AND /* การซ่อม */
                stat.campaign_fil.maxyea = n_yr                    AND /* อายุรถ */
                stat.campaign_fil.engine > 2000             AND /* cc */  
                stat.campaign_fil.simax  = deci(impdata_fil.si)        AND  /* ทุน */
                stat.campaign_fil.makdes = impdata_fil.brand     AND 
                (index(impdata_fil.model,stat.campaign_fil.moddes) <> 0  OR   /* Model */
                index(stat.campaign_fil.moddes,impdata_fil.model) <> 0 ) AND   /* Model */ /*A64-0044*/
                stat.campaign_fil.netprm  = impdata_fil.premt         NO-LOCK NO-ERROR.   
       END.
       ELSE DO:
           FIND LAST stat.campaign_fil USE-INDEX campfil04  WHERE 
                stat.campaign_fil.camcod = impdata_fil.packcod   AND /* campaign no */
                stat.campaign_fil.sclass = impdata_fil.subclass  AND /* class 110 210 320 */
                stat.campaign_fil.covcod = impdata_fil.covcod    AND /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                stat.campaign_fil.garage = impdata_fil.garage    AND /* การซ่อม */
                stat.campaign_fil.maxyea = n_yr              AND /* อายุรถ */
                stat.campaign_fil.engine > 2000              AND /* cc */  
                stat.campaign_fil.simax  = deci(impdata_fil.si)  AND  /* ทุน */
                stat.campaign_fil.makdes = impdata_fil.brand     AND 
                (index(impdata_fil.model,stat.campaign_fil.moddes) <> 0  OR   /* Model */
                index(stat.campaign_fil.moddes,impdata_fil.model) <> 0 ) AND   /* Model */ /*A64-0044*/
                stat.campaign_fil.netprm  = impdata_fil.premt         NO-LOCK NO-ERROR. 
       END.
    END.
    IF AVAIL stat.campaign_fil THEN 
        ASSIGN   impdata_fil.polmaster = stat.campaign_fil.polmst
                 impdata_fil.seat41    = stat.campaign_fil.seat41. 
    ELSE DO: 
        IF deci(impdata_fil.si) > 1000000 THEN DO:
           ASSIGN nv_si = 0
                  nv_si = deci(impdata_fil.si) + 40000 .
           IF impdata_fil.engcc <= 2000  THEN DO:  /* 2000 CC */
             FIND LAST stat.campaign_fil USE-INDEX campfil04  WHERE 
              stat.campaign_fil.camcod = impdata_fil.packcod   AND /* campaign no */
              stat.campaign_fil.sclass = impdata_fil.subclass  AND /* class 110 210 320 */
              stat.campaign_fil.covcod = impdata_fil.covcod    AND /* cover 1 2 3 2.1 2.2 3.1 3.2 */
              stat.campaign_fil.garage = impdata_fil.garage    AND /* การซ่อม */
              stat.campaign_fil.maxyea = n_yr              AND /* อายุรถ */
              stat.campaign_fil.engine <= 2000             AND /* cc */  
              stat.campaign_fil.simax  >= deci(impdata_fil.si) AND
              stat.campaign_fil.simax  <= nv_si            AND
              stat.campaign_fil.makdes = impdata_fil.brand     AND 
              (index(impdata_fil.model,stat.campaign_fil.moddes) <> 0  OR   /* Model */
              index(stat.campaign_fil.moddes,impdata_fil.model) <> 0 ) AND   /* Model */ /*A64-0044*/
              stat.campaign_fil.netprm   = impdata_fil.premt           NO-LOCK NO-ERROR.   /* Model */
           END.
           ELSE DO:
              FIND LAST stat.campaign_fil USE-INDEX campfil04  WHERE 
                stat.campaign_fil.camcod = impdata_fil.packcod   AND /* campaign no */
                stat.campaign_fil.sclass = impdata_fil.subclass  AND /* class 110 210 320 */
                stat.campaign_fil.covcod = impdata_fil.covcod    AND /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                stat.campaign_fil.garage = impdata_fil.garage    AND /* การซ่อม */
                stat.campaign_fil.maxyea = n_yr              AND /* อายุรถ */
                stat.campaign_fil.engine > 2000             AND /* cc */  
                stat.campaign_fil.simax  >= deci(impdata_fil.si) AND
                stat.campaign_fil.simax  <= nv_si            AND
                stat.campaign_fil.makdes = impdata_fil.brand     AND 
                (index(impdata_fil.model,stat.campaign_fil.moddes) <> 0  OR   /* Model */
                index(stat.campaign_fil.moddes,impdata_fil.model) <> 0 ) AND   /* Model */ /*A64-0044*/
                stat.campaign_fil.netprm   = impdata_fil.premt           NO-LOCK NO-ERROR.   /* Model */
           END.
           IF AVAIL stat.campaign_fil THEN 
               ASSIGN   impdata_fil.polmaster = stat.campaign_fil.polmst
                        impdata_fil.seat41    = stat.campaign_fil.seat41. 
           ELSE ASSIGN impdata_fil.polmaster = "" . 
        END. /* end si > 1000000 */
    END.
    /* ไม่เช็คอายุรถ */
    IF impdata_fil.polmaster = "" THEN DO:  /*A64-0044*/
        n_model = "" .
        IF INDEX(impdata_fil.model," ") <> 0 THEN ASSIGN n_model = SUBSTR(impdata_fil.model,1,INDEX(impdata_fil.model," ") - 1).
        ELSE n_model = TRIM(impdata_fil.model) .
        IF impdata_fil.engcc <= 2000 THEN DO:
            FIND LAST stat.campaign_fil /*USE-INDEX campfil01*/  WHERE 
                stat.campaign_fil.camcod = impdata_fil.packcod     AND /* campaign no */
                stat.campaign_fil.sclass = impdata_fil.subclass    AND /* class 110 210 320 */
                stat.campaign_fil.covcod = impdata_fil.covcod      AND /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                stat.campaign_fil.garage = impdata_fil.garage      AND /* การซ่อม */
                stat.campaign_fil.maxyea = 1                   AND /* อายุรถ */
                stat.campaign_fil.engine <= 2000               AND /* cc */ 
                stat.campaign_fil.simax  = deci(impdata_fil.si)    AND  /* ทุน */
                stat.campaign_fil.makdes = impdata_fil.brand       AND 
                (index(n_model,stat.campaign_fil.moddes) <> 0  OR   /* Model */
                index(stat.campaign_fil.moddes,n_model) <> 0 ) AND   /* Model */ /*A64-0044*/
                stat.campaign_fil.netprm  = impdata_fil.premt         NO-LOCK NO-ERROR. 
        END.
        ELSE DO:
             FIND LAST stat.campaign_fil /*USE-INDEX campfil01*/  WHERE 
                stat.campaign_fil.camcod = impdata_fil.packcod     AND /* campaign no */
                stat.campaign_fil.sclass = impdata_fil.subclass    AND /* class 110 210 320 */
                stat.campaign_fil.covcod = impdata_fil.covcod      AND /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                stat.campaign_fil.garage = impdata_fil.garage      AND /* การซ่อม */
                stat.campaign_fil.maxyea = 1                   AND /* อายุรถ */
                stat.campaign_fil.engine > 2000                AND /* cc */ 
                stat.campaign_fil.simax  = deci(impdata_fil.si)    AND  /* ทุน */
                stat.campaign_fil.makdes = impdata_fil.brand       AND 
                (index(n_model,stat.campaign_fil.moddes) <> 0  OR   /* Model */
                index(stat.campaign_fil.moddes,n_model) <> 0 ) AND   /* Model */ /*A64-0044*/
                stat.campaign_fil.netprm  = impdata_fil.premt         NO-LOCK NO-ERROR. 
        END.
        IF AVAIL stat.campaign_fil THEN 
         ASSIGN   impdata_fil.polmaster = stat.campaign_fil.polmst
                  impdata_fil.seat41    = stat.campaign_fil.seat41. 
        ELSE DO:
            FIND LAST stat.campaign_fil /*USE-INDEX campfil01*/  WHERE 
                stat.campaign_fil.camcod = impdata_fil.packcod     AND /* campaign no */
                stat.campaign_fil.sclass = impdata_fil.subclass    AND /* class 110 210 320 */
                stat.campaign_fil.covcod = impdata_fil.covcod      AND /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                stat.campaign_fil.garage = impdata_fil.garage      AND /* การซ่อม */
                stat.campaign_fil.maxyea = 1                   AND /* อายุรถ */
                stat.campaign_fil.simax  = deci(impdata_fil.si)    AND  /* ทุน */
                stat.campaign_fil.makdes = impdata_fil.brand       AND 
                (index(n_model,stat.campaign_fil.moddes) <> 0  OR   /* Model */
                index(stat.campaign_fil.moddes,n_model) <> 0 ) AND   /* Model */ /*A64-0044*/
                stat.campaign_fil.netprm  = impdata_fil.premt         NO-LOCK NO-ERROR. 
             IF AVAIL stat.campaign_fil THEN 
               ASSIGN   impdata_fil.polmaster = stat.campaign_fil.polmst
                        impdata_fil.seat41    = stat.campaign_fil.seat41. 
        END.
    END.
END. 

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chassic C-Win 
PROCEDURE proc_chassic :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR nv_chanew AS CHAR.
DEFINE VAR nv_len AS INTE INIT 0.
ASSIGN nv_uwm301trareg = impdata_fil.chasno.
    loop_chk1:
    REPEAT:
        IF INDEX(nv_uwm301trareg,"-") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"-") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"-") + 1, nv_len ) .
        END.
        ELSE LEAVE loop_chk1.
    END.
    loop_chk2:
    REPEAT:
        IF INDEX(nv_uwm301trareg,"/") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"/") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"/") + 1, nv_len ) .
        END.
        ELSE LEAVE loop_chk2.
    END.
    loop_chk3:
    REPEAT:
        IF INDEX(nv_uwm301trareg,";") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,";") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,";") + 1, nv_len ) .
        END.
        ELSE LEAVE loop_chk3.
    END.
    loop_chk4:
    REPEAT:
        IF INDEX(nv_uwm301trareg,".") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,".") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,".") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk4.
    END.
    loop_chk5:
    REPEAT:
        IF INDEX(nv_uwm301trareg,",") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,",") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,",") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk5.
    END.
    loop_chk6:
    REPEAT:
        IF INDEX(nv_uwm301trareg," ") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg," ") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg," ") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk6.
    END.
    loop_chk7:
    REPEAT:
        IF INDEX(nv_uwm301trareg,"\") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"\") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"\") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk7.
    END.
    loop_chk8:
    REPEAT:
        IF INDEX(nv_uwm301trareg,":") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,":") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,":") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk8.
    END.
    loop_chk9:
    REPEAT:
        IF INDEX(nv_uwm301trareg,"|") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"|") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"|") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk9.
    END.
    loop_chk10:
    REPEAT:
        IF INDEX(nv_uwm301trareg,"+") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"+") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"+") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk10.
    END.
    loop_chk11:
    REPEAT:
        IF INDEX(nv_uwm301trareg,"#") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"#") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"#") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk11.
    END.
    loop_chk12:
    REPEAT:
        IF INDEX(nv_uwm301trareg,"[") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"[") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"[") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk12.
    END.
    loop_chk13:
    REPEAT:
        IF INDEX(nv_uwm301trareg,"]") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"]") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"]") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk13.
    END.
    loop_chk14:
    REPEAT:
        IF INDEX(nv_uwm301trareg,"'") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"'") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"+") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk14.
    END.
    loop_chk15:
    REPEAT:
        IF INDEX(nv_uwm301trareg,"(") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"(") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"(") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk15.
    END.
    loop_chk16:
    REPEAT:
        IF INDEX(nv_uwm301trareg,"_") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"_") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"_") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk16.
    END.
    loop_chk17:
    REPEAT:
        IF INDEX(nv_uwm301trareg,"*") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"*") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"*") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk17.
    END.
     loop_chk18:
    REPEAT:
        IF INDEX(nv_uwm301trareg,")") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,")") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,")") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk18.
    END.
    loop_chk19:
    REPEAT:
        IF INDEX(nv_uwm301trareg,"=") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"=") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"=") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk19.
    END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkcampaign C-Win 
PROCEDURE proc_chkcampaign :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    ASSIGN fi_process = "check Campiagn code..." + impdata_fil.camp_no + ".....".
    DISP fi_process WITH FRAM fr_main.

    FIND LAST stat.campaign_br USE-INDEX campbr01  WHERE campaign_br.campcode = campaign_master.campcode AND
         campaign_br.branch = impdata_fil.n_branch  NO-LOCK NO-ERROR .
    IF NOT AVAIL campaign_br THEN 
         ASSIGN impdata_fil.comment = impdata_fil.comment + "|ไม่พบข้อมูล Branch " + impdata_fil.n_branch + " ของแคมเปญ " + impdata_fil.camp_no + " ในระบบ (Campaign_br) "
                impdata_fil.pass    = "N" 
                impdata_fil.OK_GEN  = "N".

    FIND LAST stat.campaign_acno USE-INDEX campacno01  WHERE campaign_acno.campcode = campaign_master.campcode AND
         campaign_acno.acno = impdata_fil.producer  NO-LOCK NO-ERROR .
    IF NOT AVAIL campaign_acno THEN DO:
        FIND LAST campaign_acno USE-INDEX campacno01  WHERE campaign_acno.campcode = campaign_master.campcode AND
         campaign_acno.acno = "ALL" NO-LOCK NO-ERROR .
        IF NOT AVAIL campaign_acno THEN 
            ASSIGN impdata_fil.comment = impdata_fil.comment + "| ไม่พบข้อมูล Acno " + impdata_fil.producer + " ของแคมเปญ " + impdata_fil.camp_no + " ในระบบ (Campaign_acno) "
                   impdata_fil.pass    = "N" 
                   impdata_fil.OK_GEN  = "N".
    END.

    FIND LAST stat.campaign_poltyp USE-INDEX camppoltyp01  WHERE campaign_poltyp.campcode = campaign_master.campcode AND
         campaign_poltyp.poltyp = impdata_fil.poltyp  NO-LOCK NO-ERROR .
    IF NOT AVAIL campaign_poltyp THEN
        ASSIGN impdata_fil.comment = impdata_fil.comment + "| ไม่พบข้อมูล Poltyp " + impdata_fil.poltyp + " ของแคมเปญ " + impdata_fil.camp_no + " ในระบบ (Campaign_poltyp) "
               impdata_fil.pass    = "N" 
               impdata_fil.OK_GEN  = "N".

    release stat.campaign_br.
    release stat.campaign_acno.
    release stat.campaign_poltyp.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkclass72 C-Win 
PROCEDURE proc_chkclass72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*DEF VAR nv_class AS CHAR INIT "" .
DO:
 /* add by : Ranu I. A64-0044 */
 IF LENGTH(re_class) > 3 THEN ASSIGN nv_class = SUBSTR(re_class,2,3) .
 ELSE nv_class = TRIM(re_class) .
 /* end : A64-0044 */

 FIND FIRST sicsyac.xzmcom WHERE /*sicsyac.xzmcom.class    = re_class   AND */ /*A64-0044*/
                                 sicsyac.xzmcom.class    = nv_class   AND     /*A64-0044*/
                                 sicsyac.xzmcom.garage   = re_garage  AND
                                 sicsyac.xzmcom.var_amt >= deci(n_Tonn70)   AND
                                 sicsyac.xzmcom.vehuse   = re_vehuse NO-LOCK NO-ERROR NO-WAIT.
     IF AVAILABLE sicsyac.xzmcom THEN 
         ASSIGN impdata_fil.subCLASS = sicsyac.xzmcom.comp_cod.
     ELSE DO:
         FIND FIRST sicsyac.xzmcom WHERE
             /*sicsyac.xzmcom.class    = re_class     AND */ /*A64-0044*/
             sicsyac.xzmcom.class    = nv_class     AND     /*A64-0044*/
             sicsyac.xzmcom.garage   = re_garage    AND
             sicsyac.xzmcom.vehuse   = re_vehuse  NO-LOCK NO-ERROR NO-WAIT.
             IF AVAILABLE sicsyac.xzmcom THEN 
                 ASSIGN impdata_fil.subCLASS = sicsyac.xzmcom.comp_cod.
             ELSE DO:
                 FIND FIRST sicsyac.xzmcom WHERE 
                     /*sicsyac.xzmcom.class    = re_class   AND*/ /*A64-0044*/
                     sicsyac.xzmcom.class    = nv_class   AND    /*A64-0044*/
                     sicsyac.xzmcom.vehuse   = re_vehuse  NO-LOCK NO-ERROR NO-WAIT.
                     IF AVAILABLE sicsyac.xzmcom THEN 
                         ASSIGN impdata_fil.subCLASS = sicsyac.xzmcom.comp_cod.
             END.
     END.

 IF INDEX(impdata_fil.subCLASS,".") <> 0 THEN 
    ASSIGN impdata_fil.subCLASS = trim(REPLACE(impdata_fil.subCLASS,".","")).
 ELSE 
    ASSIGN impdata_fil.subCLASS = trim(impdata_fil.subCLASS).
END.
RELEASE sicsyac.xzmcom .
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkcomp C-Win 
PROCEDURE proc_chkcomp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*DEF VAR nv_premt72  AS DECI init 0 .
DEF VAR nv_stf_perm AS DECI init 0 .
DO:
    IF      INT(impdata_fil.dstfprem72) <> 0 THEN  nv_premt72 = impdata_fil.premt72 + impdata_fil.dstfprem72 . /* เบี้ยสุทธิ + เบี้ยส่วนลด */
    ELSE IF INT(impdata_fil.dstf72) <> 0 THEN  DO:
        FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601    WHERE
                   sicsyac.xmm106.tariff  = impdata_fil.tarif   AND 
                   sicsyac.xmm106.bencod  = "COMP"          AND    
                   sicsyac.xmm106.class   = impdata_fil.class72 AND 
                   sicsyac.xmm106.covcod  = impdata_fil.covcod  AND 
                   sicsyac.xmm106.effdat <= impdata_fil.comdat NO-LOCK NO-ERROR NO-WAIT.
        IF AVAILABLE sicsyac.xmm106 THEN nv_premt72 =  sicsyac.xmm106.baseap .
        IF nv_premt72 <> 0 THEN nv_stf_perm   = ROUND(nv_premt72 * int(impdata_fil.dstf72) / 100,2).

        nv_premt72 = impdata_fil.premt72 + nv_stf_perm . /* เบี้ยสุทธิ + เบี้ยส่วนลด */
    END.
    ELSE nv_premt72 = impdata_fil.premt72. 

    IF nv_premt72 <> 0 THEN DO:
        FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601    WHERE
                   sicsyac.xmm106.tariff  = impdata_fil.tariff   AND 
                   sicsyac.xmm106.bencod  = "COMP"          AND    
                   sicsyac.xmm106.class   = impdata_fil.class72 AND 
                   sicsyac.xmm106.covcod  = impdata_fil.covcod  AND 
                   sicsyac.xmm106.effdat <= impdata_fil.comdat NO-LOCK NO-ERROR NO-WAIT.
        IF AVAILABLE sicsyac.xmm106 THEN DO: 
            IF nv_premt72 <> sicsyac.xmm106.baseap THEN 
                ASSIGN impdata_fil.comment = impdata_fil.comment + "|ตรวจสอบ Class " + impdata_fil.CLASS72 + " กับเบี้ย พรบ." + STRING(impdata_fil.premt72) . 
        END.
    END.
    RELEASE sicsyac.xmm106 .

    /*----รถจักรยานยนต์------*/
    /* รถส่วนบุคคล */
   /*130A       150.00 
   130B       300.00 
   130C       400.00 
   130D       600.00 
  /* รถรับจ้างให้เช่า */
    2.30A     150.00
    2.30B       350.00
    2.30C       400.00
    2.30D       600.00
    /* สาธารณะ */
    3.30A   150.00
    3.30B   350.00
    3.30C   400.00
    3.30D   600.00
    /*-------------------------*/
    
    /*----รถสามล้อเครื่อง------*/
    /* รถส่วนบุคคล */
    1.70A       720.00
    1.70B       400.00
    1.71        400.00
    /* รถรับจ้างให้เช่า */
    2.70A       1,440.00
    2.70B       400.00
    2.71        400.00
    /* สาธาระณะ */
    3.70A       1,440.00
    3.70B       400.00
    3.71        400.00
    /*--------------------------*/
    
    /*--รถยนต์นั่งไม่เกิน 7 คน --*/
    /* รถส่วนบุคคล */
    1.10        600.00
    /* รถรับจ้างให้เช่า */
    2.10        1,900.00
    /* สาธารณะ */
    3.10        1,900.00
    /*-----------------------*/
    
    /*รถยนต์โดยสารเกิน 7 คน ขนาดที่นั่ง*/
    /* รถส่วนบุคคล */
    1.20A       1,100.00
    1.20B       2,050.00
    1.20C       3,200.00
    1.20D       3,740.00
    /* รับจ้างให้เช่า */
    2.20A       2,320.00
    2.20B       3,480.00
    2.20C       6,660.00
    2.20D       7,520.00
    /* สาธารณะ */
    3.20A       2,320.00
    3.20B       3,480.00
    3.20C       6,660.00
    3.20D       7,520.00
    /*------------------*/
    
    /*----รถโดยสาร รับจ้าง ----*/
    /* รับจ้างให้เช่า */
    2.20E       1,580.00
    2.20F       2,260.00
    2.20G       3,810.00
    2.20H       4,630.00
    /* สาธารณะ */
    3.20E       1,580.00
    3.20F       2,260.00
    3.20G       3,810.00
    3.20H       4,630.00
    /*----------------------*/
    
    /*----รถยนต์บรรทุก -----*/
    /* รถส่วนบุคคล */
    1.40A       900.00
    1.40B       1,220.00
    1.40C       1,310.00
    1.40D       1,700.00
    /* รับจ้างให้เช่า */
    2.40A       1,760.00
    2.40B       1,830.00
    2.40C       1,980.00
    2.40D       2,530.00
    /* สาธารณะ */
    3.40A       1,760.00
    3.40B       1,830.00
    3.40C       1,980.00
    3.40D       2,530.00
    /*------------------------*/
    
    /*---รถยนต์บรรทุกน้ำมันเชื้อเพลิง แก็ส หรือ กรด---*/
    /* รถส่วนบุคคล */
    1.42A       1,680.00
    1.42B       2,320.00
    /* รับจ้างให้เช่า */
    2.42A       1,980.00
    2.42B       3,060.00
    /* สาธารณะ */
    3.42A   1,980.00
    3.42B   3,060.00
    /*--------------------------*/
    
    /*------หัวรถลากจูง--------*/
    /* รถส่วนบุคคล */
    1.50        2,370.00
    /* รับจ้างให้เช่า */
    2.50        3,160.00
    /* สาธารณะ */
    3.50        3,160.00
    /*-------------------------*/
    
    /*------รถพ่วง-------------*/
    /* รถส่วนบุคคล */
    1.60        600.00
    /* รับจ้างให้เช่า */
    2.60        600.00
    /* สาธารณะ */
    3.60        600.00
    /*---------------------------*/
    
    /*รถยนต์ป้ายแดง (การค้ารถยนต์)*/
    /* ทุกประเภทการใช้รถ */
    4.01        1,530.00
    
    /*รถยนต์ที่ใช้ในการเกษตร*/
    /* ทุกประเภทการใช้รถ */
    4.06        90.00
    
    /*รถยนต์ประเภทอื่น ๆ*/
    /* ทุกประเภทการใช้รถ */
    4.07        770.00
    
    /*------ รถไฟฟ้า ------*/
    /* รถส่วนบุคคล */
    1.30E       300.00
    1.70E       500.00
    1.10E       600.00
    /* รับจ้างให้เช่า */
    2.30E       350.00
    2.70E       1,440.00
    2.10E       1,900.00
    /* สาธารณะ */
    3.30E       350.00
    3.70E       1,440.00
    3.10E       1,900.00*/
    /*--------------------*/

END.
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkdrive C-Win 
PROCEDURE proc_chkdrive :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  add by A67-0029     
------------------------------------------------------------------------------*/
IF  impdata_fil.drivnam = "Y" THEN DO :      
    ASSIGN no_policy    = ""            nv_drivage1  = 0        nv_drivbir1  = ""    
           no_rencnt    = ""            nv_drivage2  = 0        nv_drivbir2  = ""    
           no_endcnt    = ""            nv_drivage3  = 0        nv_drivbir3  = ""    
           no_riskno    = ""            nv_drivage4  = 0        nv_drivbir4  = ""    
           no_itemno    = ""            nv_drivage5  = 0        nv_drivbir5  = "" 
           nv_dribirth  = ""            nv_dlevel    = 0        nv_dlevper   = 0
           nv_drivlevel = 0             nv_dconsent  = "" 
           no_policy = sic_bran.uwm301.policy 
           no_rencnt = STRING(sic_bran.uwm301.rencnt,"99") 
           no_endcnt = STRING(sic_bran.uwm301.endcnt,"999") 
           no_riskno = STRING(impdata_fil.riskno,"999")
           no_itemno = STRING(impdata_fil.itemno,"999")
           n_count   = 0.
    

  FIND LAST impdriv_fil WHERE impdriv_fil.policy  = impdata_fil.policy AND 
                              impdriv_fil.riskno  = impdata_fil.riskno AND
                              impdriv_fil.itemno  = impdata_fil.itemno NO-ERROR NO-WAIT.
    IF AVAIL impdriv_fil THEN DO:
       ASSIGN impdriv_fil.dbirth1   = IF impdriv_fil.dbirth1 <> "" then STRING(DATE(impdriv_fil.dbirth1),"99/99/9999") else ""
              impdriv_fil.dbirth2   = IF impdriv_fil.dbirth2 <> "" then STRING(DATE(impdriv_fil.dbirth2),"99/99/9999") else ""
              impdriv_fil.dbirth3   = IF impdriv_fil.dbirth3 <> "" then STRING(DATE(impdriv_fil.dbirth3),"99/99/9999") else ""
              impdriv_fil.dbirth4   = IF impdriv_fil.dbirth4 <> "" then STRING(DATE(impdriv_fil.dbirth4),"99/99/9999") else ""
              impdriv_fil.dbirth5   = IF impdriv_fil.dbirth5 <> "" then STRING(DATE(impdriv_fil.dbirth5),"99/99/9999") else ""
              nv_drivage1       = IF TRIM(impdriv_fil.dbirth1) <> "" THEN  INT(SUBSTR(impdriv_fil.dbirth1,7,4)) ELSE 0
              nv_drivage2       = IF TRIM(impdriv_fil.dbirth2) <> "" THEN  INT(SUBSTR(impdriv_fil.dbirth2,7,4)) ELSE 0
              nv_drivage3       = IF TRIM(impdriv_fil.dbirth3) <> "" THEN  INT(SUBSTR(impdriv_fil.dbirth3,7,4)) ELSE 0
              nv_drivage4       = IF TRIM(impdriv_fil.dbirth4) <> "" THEN  INT(SUBSTR(impdriv_fil.dbirth4,7,4)) ELSE 0
              nv_drivage5       = IF TRIM(impdriv_fil.dbirth5) <> "" THEN  INT(SUBSTR(impdriv_fil.dbirth5,7,4)) ELSE 0 .
       
        IF impdriv_fil.name1 <> " " THEN DO: 
            RUN proc_clearmailtxt .
            IF nv_drivage1 > 0 THEN DO:
                if nv_drivage1 < year(today) then do:
                    nv_drivage1 =  YEAR(TODAY) - nv_drivage1  .
                    ASSIGN nv_dribirth    = STRING(DATE(impdriv_fil.dbirth1),"99/99/9999") /* ค.ศ. */
                           nv_drivbir1    = STRING(INT(SUBSTR(impdriv_fil.dbirth1,7,4))  + 543 )
                           impdriv_fil.dbirth1 = SUBSTR(impdriv_fil.dbirth1,1,6) + nv_drivbir1
                           impdriv_fil.dbirth1 = STRING(DATE(impdriv_fil.dbirth1),"99/99/9999") . /* พ.ศ. */
                END.
                ELSE DO:
                    nv_drivage1 =  YEAR(TODAY) - (nv_drivage1 - 543).
                    ASSIGN nv_drivbir1    = STRING(INT(SUBSTR(impdriv_fil.dbirth1,7,4))) 
                           nv_dribirth    = SUBSTR(impdriv_fil.dbirth1,1,6) + STRING((INTE(nv_drivbir1) - 543),"9999")  /* ค.ศ. */
                           impdriv_fil.dbirth1 = SUBSTR(impdriv_fil.dbirth1,1,6) + nv_drivbir1   
                           impdriv_fil.dbirth1 = STRING(DATE(impdriv_fil.dbirth1),"99/99/9999")  . /* พ.ศ. */
                END.
            END.
            ASSIGN  n_count        = 1
                    nv_ntitle   = trim(impdriv_fil.ntitle1)  
                    nv_name     = trim(impdriv_fil.name1 )  
                    nv_lname    = trim(impdriv_fil.lname1) 
                    nv_drinam   = nv_ntitle + " " + nv_name  + " " + nv_lname
                    nv_dicno    = trim(impdriv_fil.dicno1)  
                    nv_dgender  = IF trim(impdriv_fil.dgender1) = "M" THEN "MALE" ELSE "FEMALE"
                    nv_dbirth   = trim(impdriv_fil.dbirth1)
                    nv_dage     = nv_drivage1
                    nv_doccup   = trim(impdriv_fil.doccup1) 
                    nv_ddriveno = trim(impdriv_fil.ddriveno1) 
                    nv_drivexp  = trim(impdriv_fil.drivexp1) 
                    nv_dlevel   = INTE(impdriv_fil.dlevel1)
                    nv_dconsent = trim(impdriv_fil.dconsen1)
                    nv_drivlevel = INTE(nv_dlevel)
                    nv_dlevper   = IF      nv_dlevel = 1 THEN 100 ELSE IF nv_dlevel = 2 THEN 90 
                                   ELSE IF nv_dlevel = 3 THEN 80  ELSE IF nv_dlevel = 4 THEN 70 ELSE 60    .
            RUN proc_mailtxt.
        END.
        
        IF impdriv_fil.name2 <> " " THEN DO: 
            RUN proc_clearmailtxt .
            IF nv_drivage2 > 0 THEN DO:
                if nv_drivage2 < year(today) then do:
                    nv_drivage2 =  YEAR(TODAY) - nv_drivage2  .
                    ASSIGN nv_dribirth    = STRING(DATE(impdriv_fil.dbirth2),"99/99/9999") /* ค.ศ. */
                        nv_drivbir2    = STRING(INT(SUBSTR(impdriv_fil.dbirth2,7,4))  + 543 )
                        impdriv_fil.dbirth2 = SUBSTR(impdriv_fil.dbirth2,1,6) + nv_drivbir2
                        impdriv_fil.dbirth2 = STRING(DATE(impdriv_fil.dbirth2),"99/99/9999").
                END.
                ELSE DO:
                    nv_drivage2 =  YEAR(TODAY) - (nv_drivage2 - 543).
                    ASSIGN nv_drivbir2    = STRING(INT(SUBSTR(impdriv_fil.dbirth2,7,4)))
                           nv_dribirth    = SUBSTR(impdriv_fil.dbirth2,1,6) + STRING((INTE(nv_drivbir2) - 543),"9999")  /* ค.ศ. */
                           impdriv_fil.dbirth2 = SUBSTR(impdriv_fil.dbirth2,1,6) + nv_drivbir2   
                           impdriv_fil.dbirth2 = STRING(DATE(impdriv_fil.dbirth2),"99/99/9999")  .
                END.
            END.
            ASSIGN  n_count        = 2
                    nv_ntitle   = trim(impdriv_fil.ntitle2)  
                    nv_name     = trim(impdriv_fil.name2 )  
                    nv_lname    = trim(impdriv_fil.lname2)
                    nv_drinam   = nv_ntitle + " " + nv_name  + " " + nv_lname
                    nv_dicno    = trim(impdriv_fil.dicno2)  
                    nv_dgender  = IF trim(impdriv_fil.dgender2) = "M" THEN "MALE" ELSE "FEMALE"
                    nv_dbirth   = trim(impdriv_fil.dbirth2)
                    nv_dage     = nv_drivage2
                    nv_doccup   = trim(impdriv_fil.doccup2) 
                    nv_ddriveno = trim(impdriv_fil.ddriveno2) 
                    nv_drivexp  = trim(impdriv_fil.drivexp2) 
                    nv_dconsent = trim(impdriv_fil.dconsen2)
                    nv_dlevel   = INTE(impdriv_fil.dlevel2) 
                    nv_drivlevel = IF INTE(nv_dlevel) < INTE(nv_drivlevel) THEN nv_dlevel ELSE nv_drivlevel 
                    nv_dlevper   = IF      nv_dlevel = 1 THEN 100 ELSE IF nv_dlevel = 2 THEN 90 
                                   ELSE IF nv_dlevel = 3 THEN 80  ELSE IF nv_dlevel = 4 THEN 70 ELSE 60    .
            RUN proc_mailtxt.
        END.
        
        IF impdriv_fil.name3 <> " " THEN DO:
            RUN proc_clearmailtxt .
            IF nv_drivage3 > 0 THEN DO:
                if nv_drivage3 < year(today) then do:
                    nv_drivage3 =  YEAR(TODAY) - nv_drivage3  .
                    ASSIGN nv_dribirth    = STRING(DATE(impdriv_fil.dbirth3),"99/99/9999") /* ค.ศ. */
                        nv_drivbir3    = STRING(INT(SUBSTR(impdriv_fil.dbirth3,7,4))  + 543 )
                        impdriv_fil.dbirth3 = SUBSTR(impdriv_fil.dbirth3,1,6) + nv_drivbir3
                        impdriv_fil.dbirth3 = STRING(DATE(impdriv_fil.dbirth3),"99/99/9999").
                END.
                ELSE DO:
                    nv_drivage3 =  YEAR(TODAY) - (nv_drivage3 - 543).
                    ASSIGN nv_drivbir3    = STRING(INT(SUBSTR(impdriv_fil.dbirth3,7,4)))
                           nv_dribirth    = SUBSTR(impdriv_fil.dbirth3,1,6) + STRING((INTE(nv_drivbir3) - 543),"9999")  /* ค.ศ. */
                           impdriv_fil.dbirth3 = SUBSTR(impdriv_fil.dbirth3,1,6) + nv_drivbir3   
                           impdriv_fil.dbirth3 = STRING(DATE(impdriv_fil.dbirth3),"99/99/9999")  .
                END.
            END.
            ASSIGN  n_count        = 3
                    nv_ntitle   = trim(impdriv_fil.ntitle3)  
                    nv_name     = trim(impdriv_fil.name3 )  
                    nv_lname    = trim(impdriv_fil.lname3) 
                    nv_drinam   = nv_ntitle + " " + nv_name  + " " + nv_lname
                    nv_dicno    = trim(impdriv_fil.dicno3)  
                    nv_dgender  = IF trim(impdriv_fil.dgender3) = "M" THEN "MALE" ELSE "FEMALE" 
                    nv_dbirth   = trim(impdriv_fil.dbirth3)
                    nv_dage     = nv_drivage3
                    nv_doccup   = trim(impdriv_fil.doccup3) 
                    nv_ddriveno = trim(impdriv_fil.ddriveno3) 
                    nv_drivexp  = trim(impdriv_fil.drivexp3)
                    nv_dconsent = trim(impdriv_fil.dconsen3)
                    nv_dlevel   = INTE(impdriv_fil.dlevel3) 
                    nv_drivlevel = IF INTE(nv_dlevel) < INTE(nv_drivlevel) THEN nv_dlevel ELSE nv_drivlevel 
                    nv_dlevper   = IF      nv_dlevel = 1 THEN 100 ELSE IF nv_dlevel = 2 THEN 90 
                                   ELSE IF nv_dlevel = 3 THEN 80  ELSE IF nv_dlevel = 4 THEN 70 ELSE 60    .           .
            RUN proc_mailtxt.
        END.
        
        IF impdriv_fil.name4 <> " " THEN DO: 
            RUN proc_clearmailtxt .
            IF nv_drivage4 > 0 THEN DO:
                if nv_drivage4 < year(today) then do:
                    nv_drivage4 =  YEAR(TODAY) - nv_drivage4  .
                    ASSIGN nv_dribirth    = STRING(DATE(impdriv_fil.dbirth4),"99/99/9999") /* ค.ศ. */
                        nv_drivbir4    = STRING(INT(SUBSTR(impdriv_fil.dbirth4,7,4))  + 543 )
                        impdriv_fil.dbirth4 = SUBSTR(impdriv_fil.dbirth4,1,6) + nv_drivbir4
                        impdriv_fil.dbirth4 = STRING(DATE(impdriv_fil.dbirth4),"99/99/9999").
                END.
                ELSE DO:
                    nv_drivage4 =  YEAR(TODAY) - (nv_drivage4 - 543).
                    ASSIGN nv_drivbir4    = STRING(INT(SUBSTR(impdriv_fil.dbirth4,7,4))) 
                           nv_dribirth    = SUBSTR(impdriv_fil.dbirth4,1,6) + STRING((INTE(nv_drivbir4) - 543),"9999")  /* ค.ศ. */
                           impdriv_fil.dbirth4 = SUBSTR(impdriv_fil.dbirth4,1,6) + nv_drivbir4   
                           impdriv_fil.dbirth4 = STRING(DATE(impdriv_fil.dbirth4),"99/99/9999")  .
                END.
            END.
            ASSIGN  n_count        = 4
                    nv_ntitle   = trim(impdriv_fil.ntitle4)  
                    nv_name     = trim(impdriv_fil.name4 )  
                    nv_lname    = trim(impdriv_fil.lname4)
                    nv_drinam   = nv_ntitle + " " + nv_name  + " " + nv_lname
                    nv_dicno    = trim(impdriv_fil.dicno4)  
                    nv_dgender  = IF trim(impdriv_fil.dgender4) = "M" THEN "MALE" ELSE "FEMALE" 
                    nv_dbirth   = trim(impdriv_fil.dbirth4)
                    nv_dage     = nv_drivage4
                    nv_doccup   = trim(impdriv_fil.doccup4) 
                    nv_ddriveno = trim(impdriv_fil.ddriveno4) 
                    nv_drivexp  = trim(impdriv_fil.drivexp4) 
                    nv_dconsent = trim(impdriv_fil.dconsen4)
                    nv_dlevel   = INTE(impdriv_fil.dlevel4) 
                    nv_drivlevel = IF INTE(nv_dlevel) < INTE(nv_drivlevel) THEN nv_dlevel ELSE nv_drivlevel 
                    nv_dlevper   = IF      nv_dlevel = 1 THEN 100 ELSE IF nv_dlevel = 2 THEN 90 
                                   ELSE IF nv_dlevel = 3 THEN 80  ELSE IF nv_dlevel = 4 THEN 70 ELSE 60  .
            RUN proc_mailtxt.
        END.
        
        IF impdriv_fil.name5 <> " " THEN DO:
            RUN proc_clearmailtxt .
            IF nv_drivage5 > 0 THEN DO:
                if nv_drivage5 < year(today) then do:
                    nv_drivage5 =  YEAR(TODAY) - nv_drivage5  .
                    ASSIGN  nv_dribirth    = STRING(DATE(impdriv_fil.dbirth5),"99/99/9999") /* ค.ศ. */ 
                        nv_drivbir5    = STRING(INT(SUBSTR(impdriv_fil.dbirth5,7,4))  + 543 )
                        impdriv_fil.dbirth5 = SUBSTR(impdriv_fil.dbirth5,1,6) + nv_drivbir5
                        impdriv_fil.dbirth5 = STRING(DATE(impdriv_fil.dbirth5),"99/99/9999").
                END.
                ELSE DO:
                    nv_drivage5 =  YEAR(TODAY) - (nv_drivage5 - 543).
                    ASSIGN nv_drivbir5    = STRING(INT(SUBSTR(impdriv_fil.dbirth5,7,4))) 
                           nv_dribirth    = SUBSTR(impdriv_fil.dbirth5,1,6) + STRING((INTE(nv_drivbir5) - 543),"9999")  /* ค.ศ. */
                           impdriv_fil.dbirth5 = SUBSTR(impdriv_fil.dbirth5,1,6) + nv_drivbir5   
                           impdriv_fil.dbirth5 = STRING(DATE(impdriv_fil.dbirth5),"99/99/9999")  .
                END.
            END.
            ASSIGN  n_count        = 5
                    nv_ntitle   = trim(impdriv_fil.ntitle5)  
                    nv_name     = trim(impdriv_fil.name5 )  
                    nv_lname    = trim(impdriv_fil.lname5)
                    nv_drinam   = nv_ntitle + " " + nv_name  + " " + nv_lname
                    nv_dicno    = trim(impdriv_fil.dicno5)  
                    nv_dgender  = IF trim(impdriv_fil.dgender5) = "M" THEN "MALE" ELSE "FEMALE"
                    nv_dbirth   = trim(impdriv_fil.dbirth5)
                    nv_dage     = nv_drivage5
                    nv_doccup   = trim(impdriv_fil.doccup5) 
                    nv_ddriveno = trim(impdriv_fil.ddriveno5) 
                    nv_drivexp  = trim(impdriv_fil.drivexp5) 
                    nv_dconsent = trim(impdriv_fil.dconsen5)
                    nv_dlevel   = INTE(impdriv_fil.dlevel5) 
                    nv_drivlevel = IF INTE(nv_dlevel) < INTE(nv_drivlevel) THEN nv_dlevel ELSE nv_drivlevel 
                    nv_dlevper   = IF      nv_dlevel = 1 THEN 100 ELSE IF nv_dlevel = 2 THEN 90 
                                   ELSE IF nv_dlevel = 3 THEN 80  ELSE IF nv_dlevel = 4 THEN 70 ELSE 60    .
            RUN proc_mailtxt.
        END.
    END.
END. /*note add for mailtxt 07/11/2005*/
/*-----nv_drivcod---------------------*/
ASSIGN nv_drivvar = ""
       nv_drivvar1 = "".
       nv_drivvar2 = "".
IF impdata_fil.drivnam = "N" THEN ASSIGN  nv_drivno = 0.
ELSE ASSIGN  nv_drivno = n_count. 


IF impdata_fil.prepol = ""  THEN DO:
    If impdata_fil.drivnam  = "N"  THEN DO: 
        Assign nv_drivvar   = " "
        nv_drivcod   = "A000"
        nv_drivvar1  =  "     Unname Driver"
        nv_drivvar2  = "0"
        Substr(nv_drivvar,1,30)   = nv_drivvar1
        Substr(nv_drivvar,31,30)  = nv_drivvar2.
    END.
    ELSE DO:
        IF tg_flag = NO THEN DO:
            /*IF  nv_drivno  > 2 AND impdata_fil.subclass <> "E11" Then do:*/ /*A68-0044*/
            IF  nv_drivno  > 2 AND index(impdata_fil.subclass,"E") = 0 Then do: /*A68-0044*/
                Message " Driver'S NO. must not over 2. "  View-as alert-box.
                ASSIGN impdata_fil.pass    = "N"
                       impdata_fil.comment = impdata_fil.comment +  "| Driver'S NO. must not over 2. ".  
            END.
            /*IF SUBSTR(impdata_fil.subclass,1,1) <> "E" THEN DO: */ /*A68-0044*/
            IF index(impdata_fil.subclass,"E") = 0 THEN DO: /*A68-0044*/
                RUN proc_usdcod.
            END.
            ELSE DO:
                ASSIGN nv_drivcod = "AL0" + STRING(nv_drivlevel).
                FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
                           xmm106.tariff = impdata_fil.tariff  AND
                           xmm106.bencod = nv_drivcod   AND
                           xmm106.CLASS  = impdata_fil.subclass   AND
                           xmm106.covcod = impdata_fil.covcod  AND
                           xmm106.KEY_a  = 0          AND
                           xmm106.KEY_b  = 0          AND
                           xmm106.effdat <= impdata_fil.comdat NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL xmm106 THEN DO:
                    nv_dlevper = xmm106.appinc.
                END.
                ELSE ASSIGN nv_dlevper = 0.
            END.
        END.
        /* A68-0044 */
        ELSE DO:
            IF INDEX(impdata_fil.subclass,"11") = 0 AND INDEX(impdata_fil.subclass,"21") = 0 AND INDEX(impdata_fil.subclass,"61") = 0 AND 
               trim(impdata_fil.subclass) <> "E12" THEN DO:  
                RUN proc_usdcod.
            END.
            ELSE DO:
                ASSIGN nv_drivcod = "AL0" + STRING(nv_drivlevel).
                FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
                           xmm106.tariff = impdata_fil.tariff  AND
                           xmm106.bencod = nv_drivcod   AND
                           xmm106.CLASS  = impdata_fil.subclass   AND
                           xmm106.covcod = impdata_fil.covcod  AND
                           xmm106.KEY_a  = 0          AND
                           xmm106.KEY_b  = 0          AND
                           xmm106.effdat <= impdata_fil.comdat NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL xmm106 THEN DO:
                    nv_dlevper = xmm106.appinc.
                END.
                ELSE ASSIGN nv_dlevper = 0.
            END.
        END.
        /* end A68-0044 */
        Assign  nv_drivvar  = ""
        nv_drivvar     = nv_drivcod
        nv_drivvar1    = "     Driver name person = "
        nv_drivvar2    = String(nv_drivno)
        Substr(nv_drivvar,1,30)  = nv_drivvar1 
        Substr(nv_drivvar,31,30) = nv_drivvar2.
    END.
END.
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkdrivnam C-Win 
PROCEDURE proc_chkdrivnam :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    IF (INDEX(impdata_fil.subclass,"11") <> 0 OR INDEX(impdata_fil.subclass,"21") <> 0  OR INDEX(impdata_fil.subclass,"61") <> 0 OR 
        impdata_fil.subclass = "E12") THEN DO:
        IF trim(impdata_fil.drivnam) = "0" OR TRIM(impdata_fil.drivnam) = ""  THEN DO:
          ASSIGN impdata_fil.comment = impdata_fil.comment + "| " + "รหัสรถ " + impdata_fil.subclass + " กรุณาระบุผู้ขัขขี่ " 
                 impdata_fil.OK_GEN  = "N"     
                 impdata_fil.pass    = "N".
        END.
        ELSE DO:
            FIND LAST impdriv_fil WHERE impdriv_fil.policy = impdata_fil.policy NO-LOCK NO-ERROR.
            IF AVAIL impdriv_fil THEN DO:
                IF impdriv_fil.name1 = "" AND impdriv_fil.name2 = "" AND impdriv_fil.name3 = "" AND impdriv_fil.name4 = "" AND impdriv_fil.name5 = "" THEN DO:
                      ASSIGN impdata_fil.comment = impdata_fil.comment + "| " + "รหัสรถ " + impdata_fil.subclass + " กรุณาระบุชื่อผู้ขับขี่" 
                        impdata_fil.OK_GEN  = "N"     
                        impdata_fil.pass    = "N".
                END.
                IF impdriv_fil.name1 <> "" AND (impdriv_fil.ddriveno1 = ""  OR  impdriv_fil.dicno1 = "" ) THEN DO:
                  ASSIGN impdata_fil.comment = impdata_fil.comment + "| " + "รหัสรถ " + impdata_fil.subclass + " เลขที่บัตรประชาชน หรือเลขที่ใบอนุญาตขับขี่ผู้ขับขี่ 1 ต้องระบุข้อมูล" 
                        impdata_fil.OK_GEN  = "N"     
                        impdata_fil.pass    = "N".
                END.
                IF impdriv_fil.name2 <> "" AND (impdriv_fil.ddriveno2 = ""  OR  impdriv_fil.dicno2 = "" ) THEN DO:
                  ASSIGN impdata_fil.comment = impdata_fil.comment + "| " + "รหัสรถ " + impdata_fil.subclass + " เลขที่บัตรประชาชน หรือเลขที่ใบอนุญาตขับขี่ผู้ขับขี่ 2 ต้องระบุข้อมูล" 
                        impdata_fil.OK_GEN  = "N"     
                        impdata_fil.pass    = "N".
                END.
                IF impdriv_fil.name3 <> "" AND (impdriv_fil.ddriveno3 = ""  OR  impdriv_fil.dicno3 = "" ) THEN DO:
                  ASSIGN impdata_fil.comment = impdata_fil.comment + "| " + "รหัสรถ " + impdata_fil.subclass + " เลขที่บัตรประชาชน หรือเลขที่ใบอนุญาตขับขี่ผู้ขับขี่ 3 ต้องระบุข้อมูล" 
                        impdata_fil.OK_GEN  = "N"     
                        impdata_fil.pass    = "N".
                END.
                IF impdriv_fil.name4 <> "" AND (impdriv_fil.ddriveno4 = ""  OR  impdriv_fil.dicno4 = "" ) THEN DO:
                  ASSIGN impdata_fil.comment = impdata_fil.comment + "| " + "รหัสรถ " + impdata_fil.subclass + " เลขที่บัตรประชาชน หรือเลขที่ใบอนุญาตขับขี่ผู้ขับขี่ 4 ต้องระบุข้อมูล" 
                        impdata_fil.OK_GEN  = "N"     
                        impdata_fil.pass    = "N".
                END.
                IF impdriv_fil.name5 <> "" AND (impdriv_fil.ddriveno5 = ""  OR  impdriv_fil.dicno5 = "" ) THEN DO:
                  ASSIGN impdata_fil.comment = impdata_fil.comment + "| " + "รหัสรถ " + impdata_fil.subclass + " เลขที่บัตรประชาชน หรือเลขที่ใบอนุญาตขับขี่ผู้ขับขี่ 5 ต้องระบุข้อมูล" 
                        impdata_fil.OK_GEN  = "N"     
                        impdata_fil.pass    = "N".
                END.
            END.
            ELSE DO:
                ASSIGN impdata_fil.comment = impdata_fil.comment + "| " + "รหัสรถ " + impdata_fil.subclass + " ไม่พบข้อมูลผู้ขับขี่ " 
                 impdata_fil.OK_GEN  = "N"     
                 impdata_fil.pass    = "N".
    
            END.
        END.
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkinscode C-Win 
PROCEDURE proc_chkinscode :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = TRIM(impdata_fil.insref) NO-LOCK NO-ERROR.
    IF AVAIL xmm600 THEN DO:
       ASSIGN
            impdata_fil.instyp   =  trim(sicsyac.xmm600.acno_typ) 
            impdata_fil.tiname   =  trim(sicsyac.xmm600.ntitle)       
            impdata_fil.insnam   =  trim(sicsyac.xmm600.firstname)
            impdata_fil.lastname =  trim(sicsyac.xmm600.lastname) 
            impdata_fil.gender   =  trim(sicsyac.xmm600.sex)      
            impdata_fil.ICNO     =  trim(sicsyac.xmm600.icno)           
            impdata_fil.addr     =  trim(sicsyac.xmm600.addr1)          
            impdata_fil.tambon   =  trim(sicsyac.xmm600.addr2)          
            impdata_fil.amper    =  trim(sicsyac.xmm600.addr3)          
            impdata_fil.country  =  trim(sicsyac.xmm600.addr4)    
            impdata_fil.post     =  trim(sicsyac.xmm600.postcd)   
            impdata_fil.provcod  =  trim(sicsyac.xmm600.codeaddr1)
            impdata_fil.distcod  =  trim(sicsyac.xmm600.codeaddr2)
            impdata_fil.sdistcod =  trim(sicsyac.xmm600.codeaddr3)
            impdata_fil.jpae     =  trim(xmm600.coderef1) 
            impdata_fil.jpjtl    =  trim(xmm600.coderef2) 
            impdata_fil.jpts     =  trim(xmm600.coderef3) 
            impdata_fil.tele1    =  trim(sicsyac.xmm600.tel[1])   
            impdata_fil.tele2    =  trim(sicsyac.xmm600.tel[2])   
            impdata_fil.mail1    =  trim(sicsyac.xmm600.email[1]) 
            impdata_fil.mail2    =  trim(sicsyac.xmm600.email[2]) 
            impdata_fil.mail3    =  trim(sicsyac.xmm600.email[3]) 
            impdata_fil.mail4    =  trim(sicsyac.xmm600.email[4]) 
            impdata_fil.mail5    =  trim(sicsyac.xmm600.email[5]) 
            impdata_fil.mail6    =  trim(sicsyac.xmm600.email[6]) 
            impdata_fil.mail7    =  trim(sicsyac.xmm600.email[7]) 
            impdata_fil.mail8    =  trim(sicsyac.xmm600.email[8]) 
            impdata_fil.mail9    =  trim(sicsyac.xmm600.email[9]) 
            impdata_fil.mail10   =  trim(sicsyac.xmm600.email[10]).
    END.
    ELSE DO:
        ASSIGN impdata_fil.comment = "NOT FOUND INSURED CODE : " + impdata_fil.insref  + "(XMM600)"
               impdata_fil.pass    = "N"  .
    END.


END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkpolicy C-Win 
PROCEDURE proc_chkpolicy :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF BUFFER bfuwm100 FOR sicuw.uwm100.
DEF VAR n_count AS INT INIT 0.
DEF VAR nv_premt AS DECI INIT 0.
def var nv_commpol   as deci init 0.
def var nv_commpol_t as deci init 0.
def var nv_comm13_t  as deci init 0.

For each  impdata_fil USE-INDEX data_fil10 WHERE 
          impdata_fil.usrid  = USERID(LDBNAME(1)) AND 
          impdata_fil.progid = nv_proid           :

  FIND FIRST imptxt_fil  use-index txt_fil02  WHERE 
       imptxt_fil.usrid    = impdata_fil.usrid     and
       imptxt_fil.progid   = impdata_fil.progid    and
       imptxt_fil.policyno = trim(impdata_fil.policyno)  NO-ERROR .

   FIND FIRST impmemo_fil use-index memo_fil02 WHERE 
       impmemo_fil.usrid    = impdata_fil.usrid    and
       impmemo_fil.progid   = impdata_fil.progid   and
       impmemo_fil.policyno = trim(impdata_fil.policyno) NO-ERROR .

   FIND FIRST impacc_fil  use-index acc_fil03  WHERE 
       impacc_fil.policyno = TRIM(impdata_fil.policyno) AND
       impacc_fil.riskno   = impdata_fil.riskno   AND
       impacc_fil.itemno   = impdata_fil.itemno   AND 
       impacc_fil.usrid    = impdata_fil.usrid    and
       impacc_fil.progid   = impdata_fil.progid    NO-ERROR .

    IF impdata_fil.chasno  <> "" THEN DO:
         ASSIGN fi_process = "Check data Policy no " + impdata_fil.chasno + " " + impdata_fil.vehreg + "....." .
         DISP fi_process WITH FRAM fr_main.
         nv_premt = 0. 

         FOR EACH sicuw.uwm301 Use-index uwm30121 WHERE 
           sicuw.uwm301.cha_no = trim(impdata_fil.chasno) AND
           sicuw.uwm301.policy = TRIM(impdata_fil.policyno) AND
           sicuw.uwm301.riskno = impdata_fil.riskno AND
           sicuw.uwm301.itemno = impdata_fil.itemno No-lock .

           IF sicuw.uwm301.modcod = "" THEN  DO:
               ASSIGN impdata_fil.comment = IF impdata_fil.comment <> "" THEN impdata_fil.comment + "| Redbook เป็นค่าว่าง" 
                                            ELSE "Redbook เป็นค่าว่าง" .
           END.
           ELSE ASSIGN impdata_fil.redbook = sicuw.uwm301.modcod . /*A65-0079*/

           FIND sicuw.uwm130 USE-INDEX uwm13001 WHERE
            sicuw.uwm130.policy = sicuw.uwm301.policy AND
            sicuw.uwm130.rencnt = sicuw.uwm301.rencnt AND
            sicuw.uwm130.endcnt = sicuw.uwm301.endcnt AND
            sicuw.uwm130.riskgp = sicuw.uwm301.riskgp AND           
            sicuw.uwm130.riskno = sicuw.uwm301.riskno AND           
            sicuw.uwm130.itemno = sicuw.uwm301.itemno NO-LOCK NO-ERROR NO-WAIT.          
           IF AVAIL sicuw.uwm130  THEN
            IF impdata_fil.poltyp <> "V72" THEN DO:
              ASSIGN impdata_fil.comper       = sicuw.uwm130.uom1_v 
                     impdata_fil.comacc       = sicuw.uwm130.uom2_v 
                     impdata_fil.deductpd     = sicuw.uwm130.uom5_v .
              IF INDEX(impdata_fil.covcod,".") = 0  THEN  impdata_fil.si   = sicuw.uwm130.uom6_v .
              ELSE impdata_fil.siplus   = sicuw.uwm130.uom6_v .
              IF sicuw.uwm130.i_text = "0001" THEN impdata_fil.cctv = "0001" . /*A65-0079*/
            END.
           FOR EACH sicuw.uwd132 USE-INDEX uwd13290  WHERE
                   sicuw.uwd132.policy   = sicuw.uwm301.policy  AND
                   sicuw.uwd132.rencnt   = sicuw.uwm301.rencnt  AND
                   sicuw.uwd132.endcnt   = sicuw.uwm301.endcnt  AND
                   sicuw.uwd132.riskgp   = sicuw.uwm301.riskgp  AND
                   sicuw.uwd132.riskno   = sicuw.uwm301.riskno  AND
                   sicuw.uwd132.itemno   = sicuw.uwm301.itemno  NO-LOCK .
       
                IF impdata_fil.poltyp <> "V72" THEN DO:
                    nv_premt = nv_premt + sicuw.uwd132.prem_c .
                    IF      sicuw.uwd132.bencod = "base"    THEN ASSIGN impdata_fil.base     = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30)).
                    ELSE IF sicuw.uwd132.bencod = "411"     THEN ASSIGN impdata_fil.no_411   = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30))
                                                                        impdata_fil.ry01     = DECI(sicuw.uwd132.prem_c). /*A65-0079*/
                    ELSE IF sicuw.uwd132.bencod = "412"     THEN ASSIGN impdata_fil.no_412   = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30))
                                                                        impdata_fil.deci1    = DECI(sicuw.uwd132.prem_c). /*A65-0079*/
                    ELSE IF sicuw.uwd132.bencod = "413"     THEN ASSIGN impdata_fil.no_413   = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30))
                                                                        impdata_fil.deci2    = DECI(sicuw.uwd132.prem_c).  /*A65-0079*/
                    ELSE IF sicuw.uwd132.bencod = "414"     THEN ASSIGN impdata_fil.no_414   = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30))
                                                                        impdata_fil.deci3    = DECI(sicuw.uwd132.prem_c). /*A65-0079*/
                    ELSE IF sicuw.uwd132.bencod = "42"      THEN ASSIGN impdata_fil.no_42    = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30))
                                                                        impdata_fil.ry02     = DECI(sicuw.uwd132.prem_c). /*A65-0079*/
                    ELSE IF sicuw.uwd132.bencod = "43"      THEN ASSIGN impdata_fil.no_43    = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30))
                                                                        impdata_fil.ry03     = DECI(sicuw.uwd132.prem_c). /*A65-0079*/
                    ELSE IF sicuw.uwd132.bencod = "dod"     THEN ASSIGN impdata_fil.dod      = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30))
                                                                        impdata_fil.int1     = INT(sicuw.uwd132.prem_c). /*A65-0079*/
                    /*ELSE IF sicuw.uwd132.bencod = "dod2"    THEN ASSIGN impdata_fil.dod      = DECI(DECI(impdata_fil.dod)  +  DECI(SUBSTRING(sicuw.uwd132.benvar,31,30))).*/ /*A65-0079*/
                    ELSE IF sicuw.uwd132.bencod = "dod2"    THEN ASSIGN impdata_fil.dgatt    = INT(SUBSTRING(sicuw.uwd132.benvar,31,30))
                                                                        impdata_fil.int2     = INT(sicuw.uwd132.prem_c).  /*A65-0079*/
                    ELSE IF sicuw.uwd132.bencod = "dpd"     THEN ASSIGN impdata_fil.dpd      = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30))
                                                                        impdata_fil.int3     = INT(sicuw.uwd132.prem_c).  /*A65-0079*/
                    ELSE IF sicuw.uwd132.bencod = "flet"    THEN 
                        ASSIGN impdata_fil.fleet     = trim(SUBSTRING(sicuw.uwd132.benvar,31,30))
                               impdata_fil.fleetprem = DECI(sicuw.uwd132.prem_c) .
                    ELSE IF sicuw.uwd132.bencod = "ncb"     THEN 
                        ASSIGN impdata_fil.ncb      = trim(SUBSTRING(sicuw.uwd132.benvar,31,30))
                               impdata_fil.ncbprem  = DECI(sicuw.uwd132.prem_c) .
                    ELSE IF sicuw.uwd132.bencod = "dspc"    THEN DO:
                        ASSIGN impdata_fil.dspc     = trim(SUBSTRING(sicuw.uwd132.benvar,31,30))
                               impdata_fil.dspcprem = DECI(sicuw.uwd132.prem_c) .
                        /* add by : A65-079*/
                        IF impdata_fil.cctv = "0001" THEN DO:
                            IF  deci(impdata_fil.dspc) = 5 THEN 
                                ASSIGN impdata_fil.cctv     = trim(SUBSTRING(sicuw.uwd132.benvar,31,30))
                                       impdata_fil.cctvprem = DECI(sicuw.uwd132.prem_c) 
                                       impdata_fil.dspc     = "0" 
                                       impdata_fil.dspcprem = 0 .
                            ELSE ASSIGN impdata_fil.dspc   = STRING(DECI(impdata_fil.dspc) - 5 )
                                        impdata_fil.cctv   = "5"
                                        impdata_fil.dspcprem = DECI(sicuw.uwd132.prem_c).
                        END.
                        /* end a65-0079 */
                    END.
                    ELSE IF sicuw.uwd132.bencod = "dstf"    THEN 
                        ASSIGN impdata_fil.dstf     = trim(SUBSTRING(sicuw.uwd132.benvar,31,30))
                               impdata_fil.dstfprem  = DECI(sicuw.uwd132.prem_c)  .
                    ELSE IF index(sicuw.uwd132.bencod,"cl") <> 0 THEN 
                        ASSIGN impdata_fil.claim    = trim(SUBSTRING(sicuw.uwd132.benvar,31,30))
                               impdata_fil.clprem   = DECI(sicuw.uwd132.prem_c) .
                    
                    IF      impdata_fil.covcod = "2.1" AND sicuw.uwd132.bencod = "ba21" THEN ASSIGN impdata_fil.baseplus = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30)).
                    ELSE IF impdata_fil.covcod = "2.2" AND sicuw.uwd132.bencod = "ba22" THEN ASSIGN impdata_fil.baseplus = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30)).
                    ELSE IF impdata_fil.covcod = "2.3" AND sicuw.uwd132.bencod = "ba23" THEN ASSIGN impdata_fil.baseplus = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30)).
                    ELSE IF impdata_fil.covcod = "3.1" AND sicuw.uwd132.bencod = "ba31" THEN ASSIGN impdata_fil.baseplus = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30)).
                    ELSE IF impdata_fil.covcod = "3.2" AND sicuw.uwd132.bencod = "ba32" THEN ASSIGN impdata_fil.baseplus = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30)).
                    ELSE IF impdata_fil.covcod = "3.3" AND sicuw.uwd132.bencod = "ba33" THEN ASSIGN impdata_fil.baseplus = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30)).
                END.

                FIND FIRST impinst_fil USE-INDEX inst_fil02 WHERE
                           impinst_fil.policyno = trim(impdata_fil.policyno) AND 
                           impinst_fil.riskno   = impdata_fil.riskno   AND
                           impinst_fil.itemno   = impdata_fil.itemno   AND   
                           impinst_fil.usrid    = impdata_fil.usrid    and    
                           impinst_fil.progid   = impdata_fil.progid   NO-ERROR .
                IF AVAIL impinst_fil THEN impinst_fil.policyno  = sicuw.uwm301.policy .
                /*A67-0029*/
                 FIND FIRST impdriv_fil   WHERE  
                          impdriv_fil.policy  = TRIM(impdata_fil.policyno) AND                
                          impdriv_fil.riskno  = impdata_fil.riskno   AND                   
                          impdriv_fil.itemno  = impdata_fil.itemno   AND
                          impdriv_fil.usrid   = impdata_fil.usrid    and
                          impdriv_fil.progid  = impdata_fil.progid   NO-ERROR .
                 IF AVAIL impdriv_fil THEN impdriv_fil.policy    = sicuw.uwm301.policy . 
                /* end : A67-0029*/
                impdata_fil.policyno  = sicuw.uwm301.policy .
                impacc_fil.policyno   = sicuw.uwm301.policy .
                
           END. /* uwd132 */
           ASSIGN impdata_fil.comment = IF deci(impdata_fil.premt) <> deci(nv_premt) THEN impdata_fil.comment + "|เบี้ยในไฟล์ " + string(impdata_fil.premt) + " ไม่เท่ากับพรีเมียม " + STRING(nv_premt)
                                        ELSE impdata_fil.comment
                  impdata_fil.premt   = nv_premt .
           FIND FIRST sicuw.uwm120 USE-INDEX uwm12001 WHERE 
                sicuw.uwm120.policy    = sicuw.uwm130.policy  AND 
                sicuw.uwm120.rencnt    = sicuw.uwm130.rencnt  AND                          
                sicuw.uwm120.endcnt    = sicuw.uwm130.endcnt  AND 
                sicuw.uwm120.riskno    = sicuw.uwm130.riskno   NO-LOCK NO-ERROR.
                IF AVAIL sicuw.uwm120 THEN DO:
                    ASSIGN  impdata_fil.comper70     = uwm120.com1p 
                            impdata_fil.comco_per70  = uwm120.com3p 
                            impdata_fil.comprem70    = uwm120.com1_r 
                            impdata_fil.comco_prem70 = uwm120.com3_r.
                END.
         END.  /*sicuw.uwm301 */
     END.
     ELSE IF impdata_fil.vehreg <> "" THEN RUN proc_chkpolicy2. /*A65-0079*/
     ELSE DO:
         FOR EACH sicuw.uwm100 USE-INDEX uwm10001  WHERE 
             sicuw.uwm100.policy    = trim(impdata_fil.policyno)  NO-LOCK.  

             ASSIGN nv_commpol    = 0 
                    nv_commpol_t  = 0 
                    nv_comm13_t   = 0 .
             IF sicuw.uwm100.comdat  <> DATE(impdata_fil.comdat) AND 
                sicuw.uwm100.expdat  <> DATE(impdata_fil.expdat) THEN NEXT.
             IF sicuw.uwm100.poltyp <> "V70" THEN NEXT.
             /*IF impdata_fil.policyno = sicuw.uwm100.policy THEN NEXT.*/
            
             ASSIGN
                impdata_fil.comment   = IF deci(impdata_fil.premt) <> deci(sicuw.uwm100.prem_t) THEN impdata_fil.comment + "|เบี้ยในไฟล์ " + string(impdata_fil.premt) + " ไม่เท่ากับพรีเมียม " + STRING(sicuw.uwm100.prem_t)
                                        ELSE impdata_fil.comment
                impdata_fil.compolusory = ""
                impdata_fil.premt     = sicuw.uwm100.prem_t  
                impdata_fil.rstp_t    = sicuw.uwm100.rstp_t  
                impdata_fil.rtax_t    = sicuw.uwm100.rtax_t.
           
             FIND FIRST sicuw.uwm120 USE-INDEX uwm12001 WHERE 
                sicuw.uwm120.policy    = sicuw.uwm100.policy  AND 
                sicuw.uwm120.rencnt    = sicuw.uwm100.rencnt  AND                          
                sicuw.uwm120.endcnt    = sicuw.uwm100.endcnt  NO-LOCK NO-ERROR.
                IF AVAIL sicuw.uwm120 THEN DO:
                  IF sicuw.uwm100.poltyp = "V70" THEN DO:
                    ASSIGN  impdata_fil.comper70     = uwm120.com1p 
                            impdata_fil.comco_per70  = uwm120.com3p .

                    IF DECI(impdata_fil.comprem70) > 0 THEN DO: 
                        impdata_fil.comprem70 = DECI(impdata_fil.comprem70) * (-1) .
                        IF sicuw.uwm100.com1_t <> deci(impdata_fil.comprem70) THEN DO:
                             impdata_fil.comment = impdata_fil.comment + "|เบี้ยคอมมิชชั่นในไฟล์ " + string(impdata_fil.comprem70) + " ไม่เท่ากับพรีเมียม " + 
                                               STRING(sicuw.uwm100.com1_t)  . 
                         END.
                    END.
                    IF DECI(impdata_fil.comco_prem70) > 0 THEN DO: 
                        impdata_fil.comco_prem70 = DECI(impdata_fil.comco_prem70) * (-1) .
                        IF sicuw.uwm100.com3_t <> deci(impdata_fil.comco_prem70) THEN DO:
                             impdata_fil.comment = impdata_fil.comment + "|เบี้ยคอมมิชชั่นในไฟล์ " + string(impdata_fil.comco_prem70) + " ไม่เท่ากับพรีเมียม " + 
                                               STRING(sicuw.uwm100.com3_t)  . 
                         END.
                    END.
                    nv_commpol   = (sicuw.uwm120.com1p + sicuw.uwm120.com3p) .
                  END. /* poltyp 70*/
                END. /* end uwm120*/
                IF impdata_fil.agco <> "" THEN DO:
                    nv_commpol_t = - ROUND((sicuw.uwm100.prem_t) * nv_commpol / 100 ,2).  /* commission total */
                    nv_comm13_t  =  ROUND(sicuw.uwm100.com1_t + sicuw.uwm100.com3_t ,2) .
                    
                    IF nv_commpol_t <> nv_comm13_t THEN DO:
                     MESSAGE "ยอดรวม comm. + comm.co-broker " + string(nv_comm13_t) + 
                             " ไม่เท่ากับ comm.รวม กธ " + STRING(nv_commpol_t) VIEW-AS ALERT-BOX.
                     
                     ASSIGN impdata_fil.comment = impdata_fil.comment + "|" + "ยอดรวม comm. + comm.co-broker " + string(nv_comm13_t) + 
                                            " ไม่เท่ากับ comm.รวมของ กธ. " + STRING(nv_commpol_t) .
                    END.
                END.

                ASSIGN impdata_fil.comprem70    = sicuw.uwm100.com1_t
                       impdata_fil.comco_prem70 = sicuw.uwm100.com3_t .
               
             FIND FIRST impinst_fil USE-INDEX inst_fil02 WHERE
                           impinst_fil.policyno = trim(impdata_fil.policyno) AND 
                           impinst_fil.riskno   = impdata_fil.riskno   AND
                           impinst_fil.itemno   = impdata_fil.itemno   AND   
                           impinst_fil.usrid    = impdata_fil.usrid    and    
                           impinst_fil.progid   = impdata_fil.progid   NO-ERROR .
                IF AVAIL impinst_fil THEN impinst_fil.policyno  = sicuw.uwm100.policy .

             /*A67-0029*/
             FIND FIRST impdriv_fil   WHERE  
                    impdriv_fil.policy  = TRIM(impdata_fil.policyno) AND                
                    impdriv_fil.riskno  = impdata_fil.riskno   AND                   
                    impdriv_fil.itemno  = impdata_fil.itemno   AND
                    impdriv_fil.usrid   = impdata_fil.usrid    and
                    impdriv_fil.progid  = impdata_fil.progid   NO-ERROR .
             IF AVAIL impdriv_fil THEN impdriv_fil.policy    = sicuw.uwm301.policy . 
             /* end : A67-0029*/
             ASSIGN 
                impdata_fil.policyno  = sicuw.uwm100.policy
                imptxt_fil.policyno   = sicuw.uwm100.policy
                impmemo_fil.policyno  = sicuw.uwm100.policy
                impacc_fil.policyno   = sicuw.uwm100.policy .
         END. /* end uwm100 */
     END.  /* end chano = ""  */
   /*END.  end prepol <> ""  */
  
   RELEASE impdata_fil.
   RELEASE imptxt_fil.
   RELEASE impacc_fil .
   RELEASE impmemo_fil.
   RELEASE impinst_fil.
   RELEASE impdriv_fil. /* A67-0029*/
   RELEASE sicuw.uwm120.
   RELEASE sicuw.uwm301.
   RELEASE sicuw.uwm130.
   RELEASE sicuw.uwm100.
   RELEASE sicuw.uwd132 .

END. /* impdata_fil. */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkpolicy2 C-Win 
PROCEDURE proc_chkpolicy2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: add by a65-0079 สำหรับงาน 801      
------------------------------------------------------------------------------*/
DEF BUFFER bfuwm100 FOR sicuw.uwm100.
DEF VAR n_count AS INT INIT 0.
DEF VAR nv_premt AS DECI INIT 0.
def var nv_commpol   as deci init 0.
def var nv_commpol_t as deci init 0.
def var nv_comm13_t  as deci init 0.
DEF VAR nv_vehreg  AS CHAR INIT "" .

DO:
     ASSIGN nv_vehreg = ""
            nv_vehreg = IF INDEX(impdata_fil.vehreg,"-") <> 0 THEN REPLACE(impdata_fil.vehreg,"-"," ") + " " + trim(impdata_fil.re_country)  
                        ELSE trim(impdata_fil.vehreg) + " " + trim(impdata_fil.re_country) /*A65-0079*/ .

         ASSIGN fi_process = "Check data Policy no " + impdata_fil.vehreg + "....." .
         DISP fi_process WITH FRAM fr_main.
         nv_premt = 0. 

         FOR EACH sicuw.uwm301 Use-index uwm30102 WHERE 
           sicuw.uwm301.vehreg = trim(nv_vehreg) AND
           sicuw.uwm301.policy = TRIM(impdata_fil.policyno) AND
           sicuw.uwm301.riskno = impdata_fil.riskno AND
           sicuw.uwm301.itemno = impdata_fil.itemno No-lock .

           IF sicuw.uwm301.modcod = "" THEN  DO:
               ASSIGN impdata_fil.comment = IF impdata_fil.comment <> "" THEN impdata_fil.comment + "| Redbook เป็นค่าว่าง" 
                                            ELSE "Redbook เป็นค่าว่าง" .
           END.
           ELSE ASSIGN impdata_fil.redbook = sicuw.uwm301.modcod . /*A65-0079*/

           FIND sicuw.uwm130 USE-INDEX uwm13001 WHERE
            sicuw.uwm130.policy = sicuw.uwm301.policy AND
            sicuw.uwm130.rencnt = sicuw.uwm301.rencnt AND
            sicuw.uwm130.endcnt = sicuw.uwm301.endcnt AND
            sicuw.uwm130.riskgp = sicuw.uwm301.riskgp AND           
            sicuw.uwm130.riskno = sicuw.uwm301.riskno AND           
            sicuw.uwm130.itemno = sicuw.uwm301.itemno NO-LOCK NO-ERROR NO-WAIT.          
           IF AVAIL sicuw.uwm130  THEN
            IF impdata_fil.poltyp <> "V72" THEN DO:
              ASSIGN impdata_fil.comper       = sicuw.uwm130.uom1_v 
                     impdata_fil.comacc       = sicuw.uwm130.uom2_v 
                     impdata_fil.deductpd     = sicuw.uwm130.uom5_v .
              IF INDEX(impdata_fil.covcod,".") = 0  THEN  impdata_fil.si   = sicuw.uwm130.uom6_v .
              ELSE impdata_fil.siplus   = sicuw.uwm130.uom6_v .
              IF sicuw.uwm130.i_text = "0001" THEN impdata_fil.cctv = "0001" . /*A65-0079*/
            END.
           FOR EACH sicuw.uwd132 USE-INDEX uwd13290  WHERE
                   sicuw.uwd132.policy   = sicuw.uwm301.policy  AND
                   sicuw.uwd132.rencnt   = sicuw.uwm301.rencnt  AND
                   sicuw.uwd132.endcnt   = sicuw.uwm301.endcnt  AND
                   sicuw.uwd132.riskgp   = sicuw.uwm301.riskgp  AND
                   sicuw.uwd132.riskno   = sicuw.uwm301.riskno  AND
                   sicuw.uwd132.itemno   = sicuw.uwm301.itemno  NO-LOCK .
       
                IF impdata_fil.poltyp <> "V72" THEN DO:
                    nv_premt = nv_premt + sicuw.uwd132.prem_c .
                    IF      sicuw.uwd132.bencod = "base"    THEN ASSIGN impdata_fil.base     = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30)).
                    ELSE IF sicuw.uwd132.bencod = "411"     THEN ASSIGN impdata_fil.no_411   = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30))
                                                                        impdata_fil.ry01     = DECI(sicuw.uwd132.prem_c). /*A65-0079*/
                    ELSE IF sicuw.uwd132.bencod = "412"     THEN ASSIGN impdata_fil.no_412   = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30))
                                                                        impdata_fil.deci1    = DECI(sicuw.uwd132.prem_c). /*A65-0079*/
                    ELSE IF sicuw.uwd132.bencod = "413"     THEN ASSIGN impdata_fil.no_413   = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30))
                                                                        impdata_fil.deci2    = DECI(sicuw.uwd132.prem_c).  /*A65-0079*/
                    ELSE IF sicuw.uwd132.bencod = "414"     THEN ASSIGN impdata_fil.no_414   = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30))
                                                                        impdata_fil.deci3    = DECI(sicuw.uwd132.prem_c). /*A65-0079*/
                    ELSE IF sicuw.uwd132.bencod = "42"      THEN ASSIGN impdata_fil.no_42    = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30))
                                                                        impdata_fil.ry02     = DECI(sicuw.uwd132.prem_c). /*A65-0079*/
                    ELSE IF sicuw.uwd132.bencod = "43"      THEN ASSIGN impdata_fil.no_43    = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30))
                                                                        impdata_fil.ry03     = DECI(sicuw.uwd132.prem_c). /*A65-0079*/
                    ELSE IF sicuw.uwd132.bencod = "dod"     THEN ASSIGN impdata_fil.dod      = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30))
                                                                        impdata_fil.int1     = INT(sicuw.uwd132.prem_c). /*A65-0079*/
                    /*ELSE IF sicuw.uwd132.bencod = "dod2"    THEN ASSIGN impdata_fil.dod      = DECI(DECI(impdata_fil.dod)  +  DECI(SUBSTRING(sicuw.uwd132.benvar,31,30))).*/ /*A65-0079*/
                    ELSE IF sicuw.uwd132.bencod = "dod2"    THEN ASSIGN impdata_fil.dgatt    = INT(SUBSTRING(sicuw.uwd132.benvar,31,30))
                                                                        impdata_fil.int2     = INT(sicuw.uwd132.prem_c).  /*A65-0079*/
                    ELSE IF sicuw.uwd132.bencod = "dpd"     THEN ASSIGN impdata_fil.dpd      = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30))
                                                                        impdata_fil.int3     = INT(sicuw.uwd132.prem_c).  /*A65-0079*/
                    ELSE IF sicuw.uwd132.bencod = "flet"    THEN 
                        ASSIGN impdata_fil.fleet     = trim(SUBSTRING(sicuw.uwd132.benvar,31,30))
                               impdata_fil.fleetprem = DECI(sicuw.uwd132.prem_c) .
                    ELSE IF sicuw.uwd132.bencod = "ncb"     THEN 
                        ASSIGN impdata_fil.ncb      = trim(SUBSTRING(sicuw.uwd132.benvar,31,30))
                               impdata_fil.ncbprem  = DECI(sicuw.uwd132.prem_c) .
                    ELSE IF sicuw.uwd132.bencod = "dspc"    THEN DO:
                        ASSIGN impdata_fil.dspc     = trim(SUBSTRING(sicuw.uwd132.benvar,31,30))
                               impdata_fil.dspcprem = DECI(sicuw.uwd132.prem_c) .
                        /* add by : A65-079*/
                        IF impdata_fil.cctv = "0001" THEN DO:
                            IF  deci(impdata_fil.dspc) = 5 THEN 
                                ASSIGN impdata_fil.cctv     = trim(SUBSTRING(sicuw.uwd132.benvar,31,30))
                                       impdata_fil.cctvprem = DECI(sicuw.uwd132.prem_c) 
                                       impdata_fil.dspc     = "0" 
                                       impdata_fil.dspcprem = 0 .
                            ELSE ASSIGN impdata_fil.dspc   = STRING(DECI(impdata_fil.dspc) - 5 )
                                        impdata_fil.cctv   = "5"
                                        impdata_fil.dspcprem = DECI(sicuw.uwd132.prem_c).
                        END.
                        /* end a65-0079 */
                    END.
                    ELSE IF sicuw.uwd132.bencod = "dstf"    THEN 
                        ASSIGN impdata_fil.dstf     = trim(SUBSTRING(sicuw.uwd132.benvar,31,30))
                               impdata_fil.dstfprem  = DECI(sicuw.uwd132.prem_c)  .
                    ELSE IF index(sicuw.uwd132.bencod,"cl") <> 0 THEN 
                        ASSIGN impdata_fil.claim    = trim(SUBSTRING(sicuw.uwd132.benvar,31,30))
                               impdata_fil.clprem   = DECI(sicuw.uwd132.prem_c) .
                    
                    IF      impdata_fil.covcod = "2.1" AND sicuw.uwd132.bencod = "ba21" THEN ASSIGN impdata_fil.baseplus = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30)).
                    ELSE IF impdata_fil.covcod = "2.2" AND sicuw.uwd132.bencod = "ba22" THEN ASSIGN impdata_fil.baseplus = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30)).
                    ELSE IF impdata_fil.covcod = "2.3" AND sicuw.uwd132.bencod = "ba23" THEN ASSIGN impdata_fil.baseplus = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30)).
                    ELSE IF impdata_fil.covcod = "3.1" AND sicuw.uwd132.bencod = "ba31" THEN ASSIGN impdata_fil.baseplus = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30)).
                    ELSE IF impdata_fil.covcod = "3.2" AND sicuw.uwd132.bencod = "ba32" THEN ASSIGN impdata_fil.baseplus = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30)).
                    ELSE IF impdata_fil.covcod = "3.3" AND sicuw.uwd132.bencod = "ba33" THEN ASSIGN impdata_fil.baseplus = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30)).
                END.

                FIND FIRST impinst_fil USE-INDEX inst_fil02 WHERE
                           impinst_fil.policyno = trim(impdata_fil.policyno) AND 
                           impinst_fil.riskno   = impdata_fil.riskno   AND
                           impinst_fil.itemno   = impdata_fil.itemno   AND   
                           impinst_fil.usrid    = impdata_fil.usrid    and    
                           impinst_fil.progid   = impdata_fil.progid   NO-ERROR .
                IF AVAIL impinst_fil THEN impinst_fil.policyno  = sicuw.uwm301.policy .
                 /*A67-0029*/
                 FIND FIRST impdriv_fil   WHERE  
                          impdriv_fil.policy  = TRIM(impdata_fil.policyno) AND                
                          impdriv_fil.riskno  = impdata_fil.riskno   AND                   
                          impdriv_fil.itemno  = impdata_fil.itemno   AND
                          impdriv_fil.usrid   = impdata_fil.usrid    and
                          impdriv_fil.progid  = impdata_fil.progid   NO-ERROR .
                 IF AVAIL impdriv_fil THEN impdriv_fil.policy    = sicuw.uwm301.policy . 
                /* end : A67-0029*/
                impdata_fil.policyno  = sicuw.uwm301.policy .
                impacc_fil.policyno   = sicuw.uwm301.policy .
           END. /* uwd132 */
           ASSIGN impdata_fil.comment = IF deci(impdata_fil.premt) <> deci(nv_premt) THEN impdata_fil.comment + "|เบี้ยในไฟล์ " + string(impdata_fil.premt) + " ไม่เท่ากับพรีเมียม " + STRING(nv_premt)
                                        ELSE impdata_fil.comment
                  impdata_fil.premt   = nv_premt .
           FIND FIRST sicuw.uwm120 USE-INDEX uwm12001 WHERE 
                sicuw.uwm120.policy    = sicuw.uwm130.policy  AND 
                sicuw.uwm120.rencnt    = sicuw.uwm130.rencnt  AND                          
                sicuw.uwm120.endcnt    = sicuw.uwm130.endcnt  AND 
                sicuw.uwm120.riskno    = sicuw.uwm130.riskno   NO-LOCK NO-ERROR.
                IF AVAIL sicuw.uwm120 THEN DO:
                    ASSIGN  impdata_fil.comper70     = uwm120.com1p 
                            impdata_fil.comco_per70  = uwm120.com3p 
                            impdata_fil.comprem70    = uwm120.com1_r 
                            impdata_fil.comco_prem70 = uwm120.com3_r.
                END.
         END.  /*sicuw.uwm301 */
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkpolpremium C-Win 
PROCEDURE proc_chkpolpremium :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF BUFFER bfimpdata_fil FOR impdata_fil.
DEF BUFFER bfuwm301 FOR sicuw.uwm301.
DEF VAR stk   AS CHAR FORMAT "x(12)" INIT "" .
DEF VAR nv_chasno AS CHAR FORMAT "x(50)" .
DEF VAR nv_poltyp AS CHAR FORMAT "x(3)" .
DEF VAR nv_compol AS CHAR FORMAT "x(15)" .
DEF VAR nv_comdat AS DATE .
DEF VAR nv_expdat AS DATE .
DEF VAR nv_vehreg AS CHAR FORMAT "x(11)" INIT "" . /*A65-0079*/

DO:
    IF TRIM(impdata_fil.vehuse) = ""  THEN DO:
        ASSIGN impdata_fil.comment = impdata_fil.comment + "| ลักษณะการใช้รถ (Veh.usage) เป็นค่าว่างหรือระบุข้อมูลเป็นตัวเลขเท่านั้น "
            impdata_fil.pass    = "N" 
            impdata_fil.OK_GEN  = "N".
    END.
    /* add by : A65-0043 */
    IF impdata_fil.seat  = 0 AND impdata_fil.subclass <> "260" AND  impdata_fil.subclass <> "520" AND 
       impdata_fil.subclass <> "540"  AND impdata_fil.subclass <> "142B" AND impdata_fil.subclass <> "242B" AND
       impdata_fil.subclass <> "142A" AND impdata_fil.subclass <> "242A" THEN DO:
        ASSIGN  impdata_fil.comment = impdata_fil.comment + "| seat เป็น 0 มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
                impdata_fil.pass    = "N"    
                impdata_fil.OK_GEN  = "N".
    END.
     /* end  : A65-0043 */
    /* add by : A65-0079  */
     IF impdata_fil.model = " " AND (impdata_fil.covcod <> "3" AND impdata_fil.subclass <> "801") THEN 
         ASSIGN  impdata_fil.comment = impdata_fil.comment + "| model เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
         impdata_fil.pass    = "N"   
         impdata_fil.OK_GEN  = "N".
     
     IF trim(impdata_fil.chasno) = ""  THEN DO: 
         IF impdata_fil.subclass <> "801" THEN 
             ASSIGN  impdata_fil.comment = impdata_fil.comment + "| เลขตัวถัง เป็นค่าว่าง "
                     impdata_fil.pass    = "N"    
                     impdata_fil.OK_GEN  = "N".
     END.
     ELSE IF trim(impdata_fil.chasno) <> "-" THEN DO:
       FOR EACH bfimpdata_fil WHERE bfimpdata_fil.chasno = impdata_fil.chasno NO-LOCK.
           IF bfimpdata_fil.riskno <> impdata_fil.risk AND bfimpdata_fil.itemno <> impdata_fil.itemno THEN 
             ASSIGN impdata_fil.comment = impdata_fil.comment + "| เลขตัวถังซ้ำในไฟล์โหลดที่ risk/item :" + string(bfimpdata_fil.riskno) + "/" + STRING(bfimpdata_fil.itemno)
                    impdata_fil.pass    = "N"   
                    impdata_fil.OK_GEN  = "N".
       END.
     END. 
     /* end : ranu A65-0079 */
    ASSIGN fi_process = "check Policy on Premium " + string(impdata_fil.itemno,"999") + " " + impdata_fil.chasno + ".....".
    DISP fi_process WITH FRAM fr_main.
    
    ASSIGN nv_chasno  = ""
           nv_poltyp  = ""
           nv_compol  = ""
           nv_expdat  = ?
           nv_vehreg  = "" /*A65-0079*/
           nv_chasno  = trim(impdata_fil.chasno)
           nv_poltyp  = TRIM(impdata_fil.poltyp)
           /*nv_compol  = TRIM(impdata_fil.compolusory) */
           nv_comdat  = DATE(impdata_fil.comdat)
           nv_expdat  = DATE(impdata_fil.expdat)
           nv_vehreg  = IF INDEX(impdata_fil.vehreg,"-") <> 0 THEN REPLACE(impdata_fil.vehreg,"-"," ") + " " + trim(impdata_fil.re_country)  
                        ELSE trim(impdata_fil.vehreg) + " " + trim(impdata_fil.re_country) /*A65-0079*/ .
    
     IF nv_chasno <> ""   THEN DO:
        FIND FIRST sicuw.uwm301 Use-index uwm30121 Where sicuw.uwm301.cha_no = trim(nv_chasno) No-lock no-error no-wait.
        If avail sicuw.uwm301 Then DO:
    
          FOR EACH  sicuw.uwm301 Use-index uwm30121 Where sicuw.uwm301.cha_no = trim(nv_chasno) NO-LOCK:
    
              Find LAST sicuw.uwm100 Use-index uwm10001       Where
                  sicuw.uwm100.policy = sicuw.uwm301.policy   and
                  sicuw.uwm100.rencnt = sicuw.uwm301.rencnt   and                         
                  /*sicuw.uwm100.endcnt = sicuw.uwm301.endcnt   AND */ /*A64-0044*/
                  sicuw.uwm100.poltyp = nv_poltyp  No-lock no-error no-wait.
              If avail sicuw.uwm100 Then DO:
                  IF DATE(sicuw.uwm100.expdat) > date(nv_comdat) AND 
                     YEAR(sicuw.uwm100.expdat) = YEAR(nv_expdat) AND  
                     sicuw.uwm100.polsta    = "IF" THEN 
                  ASSIGN impdata_fil.comment = impdata_fil.comment + "| เลขตัวถังนี้มีกรมธรรม์ในระบบแล้ว" + uwm100.policy      
                         impdata_fil.OK_GEN  = "N"
                         impdata_fil.pass    = "N". 
              END.
          END. /*FOR EACH  sicuw.uwm301 */
    
        END.        /*avil 301*/
    
        RELEASE sicuw.uwm301.
        RELEASE sicuw.uwm100.
     END.
     /* Add by : a65-0079 */
    IF impdata_fil.subclass = "801" THEN DO:
        FIND FIRST sicuw.uwm301 Use-index uwm30102 Where sicuw.uwm301.vehreg = trim(nv_vehreg) No-lock no-error no-wait.
       If avail sicuw.uwm301 Then DO:
    
         FOR EACH  sicuw.uwm301 Use-index uwm30102 Where sicuw.uwm301.vehreg = trim(nv_vehreg) NO-LOCK:
             Find LAST sicuw.uwm100 Use-index uwm10001       Where
                 sicuw.uwm100.policy = sicuw.uwm301.policy   and
                 sicuw.uwm100.rencnt = sicuw.uwm301.rencnt   and                         
                 sicuw.uwm100.poltyp = nv_poltyp  No-lock no-error no-wait.
             If avail sicuw.uwm100 Then DO:
                 IF DATE(sicuw.uwm100.expdat) > date(nv_comdat) AND 
                    YEAR(sicuw.uwm100.expdat) = YEAR(nv_expdat) AND  
                    sicuw.uwm100.polsta    = "IF" THEN DO:
                    ASSIGN impdata_fil.comment = impdata_fil.comment + "| เลขทะเบียนนี้มีกรมธรรม์ในระบบแล้ว" + uwm100.policy      
                           impdata_fil.OK_GEN  = "N"
                           impdata_fil.pass    = "N". 
                 END.
             END.
         END. /*FOR EACH  sicuw.uwm301 */
       END.        /*avil 301*/
       RELEASE sicuw.uwm301.
       RELEASE sicuw.uwm100.
    END.
    /* end : a65-0079 */
  /* A67-0029 */
  IF tg_flag = NO THEN DO: /* A68-0044 */
    /*IF (impdata_fil.subclass = "E11" ) THEN DO:*/ /*A68-0044*/
    IF (impdata_fil.subclass = "E11" ) OR (impdata_fil.subclass = "E21" ) OR (impdata_fil.subclass = "E61" ) THEN DO: /*A68-0044*/
        IF trim(impdata_fil.drivnam) = "0" OR TRIM(impdata_fil.drivnam) = ""  THEN DO:
          ASSIGN impdata_fil.comment = impdata_fil.comment + "| " + "รหัสรถไฟฟ้า " + impdata_fil.subclass + " กรุณาระบุผู้ขัขขี่ " 
                 impdata_fil.OK_GEN  = "N"     
                 impdata_fil.pass    = "N".
        END.
        ELSE DO:
            FIND LAST impdriv_fil WHERE impdriv_fil.policy = impdata_fil.policy NO-LOCK NO-ERROR.
            IF AVAIL impdriv_fil THEN DO:
                IF impdriv_fil.name1 = "" AND impdriv_fil.name2 = "" AND impdriv_fil.name3 = "" AND impdriv_fil.name4 = "" AND impdriv_fil.name5 = "" THEN DO:
                      ASSIGN impdata_fil.comment = impdata_fil.comment + "| " + "รหัสรถไฟฟ้า " + impdata_fil.subclass + " กรุณาระบุชื่อผู้ขับขี่" 
                        impdata_fil.OK_GEN  = "N"     
                        impdata_fil.pass    = "N".
                END.
                IF impdriv_fil.name1 <> "" AND (impdriv_fil.ddriveno1 = ""  OR  impdriv_fil.dicno1 = "" ) THEN DO:
                  ASSIGN impdata_fil.comment = impdata_fil.comment + "| " + "รหัสรถไฟฟ้า " + impdata_fil.subclass + " เลขที่บัตรประชาชน หรือเลขที่ใบอนุญาตขับขี่ผู้ขับขี่ 1 ต้องระบุข้อมูล" 
                        impdata_fil.OK_GEN  = "N"     
                        impdata_fil.pass    = "N".
                END.
                IF impdriv_fil.name2 <> "" AND (impdriv_fil.ddriveno2 = ""  OR  impdriv_fil.dicno2 = "" ) THEN DO:
                  ASSIGN impdata_fil.comment = impdata_fil.comment + "| " + "รหัสรถไฟฟ้า " + impdata_fil.subclass + " เลขที่บัตรประชาชน หรือเลขที่ใบอนุญาตขับขี่ผู้ขับขี่ 2 ต้องระบุข้อมูล" 
                        impdata_fil.OK_GEN  = "N"     
                        impdata_fil.pass    = "N".
                END.
                IF impdriv_fil.name3 <> "" AND (impdriv_fil.ddriveno3 = ""  OR  impdriv_fil.dicno3 = "" ) THEN DO:
                  ASSIGN impdata_fil.comment = impdata_fil.comment + "| " + "รหัสรถไฟฟ้า " + impdata_fil.subclass + " เลขที่บัตรประชาชน หรือเลขที่ใบอนุญาตขับขี่ผู้ขับขี่ 3 ต้องระบุข้อมูล" 
                        impdata_fil.OK_GEN  = "N"     
                        impdata_fil.pass    = "N".
                END.
                IF impdriv_fil.name4 <> "" AND (impdriv_fil.ddriveno4 = ""  OR  impdriv_fil.dicno4 = "" ) THEN DO:
                  ASSIGN impdata_fil.comment = impdata_fil.comment + "| " + "รหัสรถไฟฟ้า " + impdata_fil.subclass + " เลขที่บัตรประชาชน หรือเลขที่ใบอนุญาตขับขี่ผู้ขับขี่ 4 ต้องระบุข้อมูล" 
                        impdata_fil.OK_GEN  = "N"     
                        impdata_fil.pass    = "N".
                END.
                IF impdriv_fil.name5 <> "" AND (impdriv_fil.ddriveno5 = ""  OR  impdriv_fil.dicno5 = "" ) THEN DO:
                  ASSIGN impdata_fil.comment = impdata_fil.comment + "| " + "รหัสรถไฟฟ้า " + impdata_fil.subclass + " เลขที่บัตรประชาชน หรือเลขที่ใบอนุญาตขับขี่ผู้ขับขี่ 5 ต้องระบุข้อมูล" 
                        impdata_fil.OK_GEN  = "N"     
                        impdata_fil.pass    = "N".
                END.
            END.
            ELSE DO:
                ASSIGN impdata_fil.comment = impdata_fil.comment + "| " + "รหัสรถไฟฟ้า " + impdata_fil.subclass + " ไม่พบข้อมูลผู้ขับขี่ " 
                 impdata_fil.OK_GEN  = "N"     
                 impdata_fil.pass    = "N".
    
            END.
        END.
    END. /* end : E11,E21,E61 */
  END. /* end flag no */
  ELSE RUN proc_chkdrivnam. /*A68-0044*/

  IF impdata_fil.battyr <> 0  THEN DO:
      RUN wgw/wgwbattper(INPUT INTE(impdata_fil.battyr),
                         INPUT DATE(impdata_fil.comdat),
                         INPUT-OUTPUT impdata_fil.battper ,
                         INPUT-OUTPUT nv_chkerror) . 
     IF nv_chkerror <> ""  THEN DO:
         ASSIGN impdata_fil.comment = impdata_fil.comment + "|" + TRIM(nv_chkerror)
                impdata_fil.pass    = "N" 
                impdata_fil.OK_GEN  = "N".
     END.
  END.

  IF impdata_fil.battno <> "" AND impdata_fil.battno <> "-" THEN DO:
      IF deci(impdata_fil.battsi) = 0 THEN DO:
        ASSIGN impdata_fil.comment = impdata_fil.comment + "| " + " กรุณาระบุ ทุนประกันแบตเตอรี่ !" 
               impdata_fil.OK_GEN  = "N"     
               impdata_fil.pass    = "N".        
      END.
      IF DECI(impdata_fil.battprm) = 0 THEN DO:  
          ASSIGN impdata_fil.comment = impdata_fil.comment + "| " + " กรุณาระบุ เบี้ยแบตเตอรี่ ! " 
               impdata_fil.OK_GEN  = "N"     
               impdata_fil.pass    = "N". 
      END.
  END.
  
  IF impdata_fil.chargno <> "" AND impdata_fil.chargno <> "-"  THEN DO:
      IF deci(impdata_fil.chargsi) = 0 THEN DO:
        ASSIGN impdata_fil.comment = impdata_fil.comment + "| " + " กรุณาระบุราคาเครื่องชาร์ท !" 
               impdata_fil.OK_GEN  = "N"     
               impdata_fil.pass    = "N".        
      END.
      IF DECI(impdata_fil.chargprm ) = 0 THEN DO:  
          ASSIGN impdata_fil.comment = impdata_fil.comment + "| " + " กรุณาระบุ เบี้ยเครื่องชาร์ท ! " 
               impdata_fil.OK_GEN  = "N"     
               impdata_fil.pass    = "N". 
      END.
  END.
  /* end : A67-0029*/
  
END.
RELEASE sicuw.uwm301.
RELEASE sicuw.uwm100.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkredbook C-Win 
PROCEDURE proc_chkredbook :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: add by : A68-0044     
------------------------------------------------------------------------------*/
DO:
    FIND FIRST stat.maktab_fil USE-INDEX maktab01   WHERE 
           stat.maktab_fil.sclass = impdata_fil.subclass  AND
           stat.maktab_fil.modcod = impdata_fil.redbook   No-lock no-error no-wait.
       If  avail  stat.maktab_fil  Then DO:
           ASSIGN
           sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod 
           sic_bran.uwm301.vehgrp  =  IF impdata_fil.cargrp = "" THEN stat.maktab_fil.prmpac ELSE impdata_fil.cargrp /*A65-0079*/
           impdata_fil.cargrp      =  IF impdata_fil.cargrp = "" THEN stat.maktab_fil.prmpac ELSE impdata_fil.cargrp /*A65-0079*/
           impdata_fil.seat41      =  IF impdata_fil.seat41 = 0  THEN stat.maktab_fil.seats ELSE impdata_fil.seat41 .
         IF sic_bran.uwm301.maksi = 0 AND TRIM(impdata_fil.covcod) <> "3" THEN sic_bran.uwm301.maksi = stat.maktab_fil.maksi. /*A68-0044*/
       END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkrenew C-Win 
PROCEDURE proc_chkrenew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    FIND LAST sicuw.uwm100 USE-INDEX uwm10001      WHERE 
             sicuw.uwm100.policy    = impdata_fil.policyno     AND 
             sicuw.uwm100.rencnt    = int(impdata_fil.rencnt)  AND                          
             sicuw.uwm100.endcnt    = 0                    AND
             sicuw.uwm100.poltyp    = "V70"   NO-LOCK NO-ERROR .
        IF AVAIL sicuw.uwm100 THEN DO:
             IF sicuw.uwm100.comdat    = DATE(impdata_fil.comdat)   AND 
                sicuw.uwm100.expdat    = DATE(impdata_fil.expdat)   AND
                sicuw.uwm100.firstname = TRIM(impdata_fil.insnam)   AND 
                sicuw.uwm100.lastname  = TRIM(impdata_fil.lastname) THEN DO:
                 ASSIGN
                  impdata_fil.comment = IF deci(impdata_fil.premt) <> deci(uwm100.prem_t) THEN "เบี้ยในไฟล์ " + string(impdata_fil.premt) + " ไม่เท่ากับพรีเมียม "  ELSE "" 
                  impdata_fil.policyno = uwm100.policy
                  impdata_fil.compolusory = IF impdata_fil.compul = "Y" THEN  uwm100.cr_2 ELSE "" 
                  impdata_fil.premt    = uwm100.prem_t  
                  impdata_fil.rstp_t   = uwm100.rstp_t  
                  impdata_fil.rtax_t   = uwm100.rtax_t 
                  imptxt_fil.policyno  = uwm100.policy
                  impmemo_fil.policyno = uwm100.policy
                  impacc_fil.policyno  = uwm100.policy
                  impinst_fil.policyno = uwm100.policy .
                
                FIND LAST sicuw.uwm301 USE-INDEX uwm30101 WHERE sicuw.uwm301.policy = sicuw.uwm100.policy AND
                                                                sicuw.uwm301.rencnt = sicuw.uwm100.rencnt and
                                                                sicuw.uwm301.endcnt = sicuw.uwm100.endcnt and
                                                                sicuw.uwm301.riskno = 1 AND
                                                                sicuw.uwm301.itemno = 1 NO-LOCK NO-ERROR .
                IF AVAIL sicuw.uwm301 THEN DO:
                    IF sicuw.uwm301.modcod = "" THEN ASSIGN impdata_fil.comment = IF impdata_fil.comment <> "" THEN impdata_fil.comment + "| Redbook เป็นค่าว่าง" ELSE "Redbook เป็นค่าว่าง " .
                END.
                
                FIND sicuw.uwm120 USE-INDEX uwm12001 WHERE 
                     sicuw.uwm120.policy    = sicuw.uwm100.policy   AND 
                     sicuw.uwm120.rencnt    = sicuw.uwm100.rencnt   AND                          
                     sicuw.uwm120.endcnt    = sicuw.uwm100.endcnt   NO-LOCK NO-ERROR.
                IF AVAIL sicuw.uwm120 THEN DO:
                    IF uwm100.poltyp = "V70" THEN DO:
                     ASSIGN  impdata_fil.comper70  =  uwm120.com1p 
                             impdata_fil.comprem70 =  uwm120.com1_r .
                    END.
                END.
                FIND sicuw.uwm130 USE-INDEX uwm13001 WHERE
                 sicuw.uwm130.policy = sicuw.uwm120.policy AND
                 sicuw.uwm130.rencnt = sicuw.uwm120.rencnt AND
                 sicuw.uwm130.endcnt = sicuw.uwm120.endcnt AND
                 sicuw.uwm130.riskgp = sicuw.uwm120.riskgp AND            /*0*/
                 sicuw.uwm130.riskno = sicuw.uwm120.riskno AND            /*1*/
                 sicuw.uwm130.itemno = 1  NO-LOCK NO-ERROR NO-WAIT.          
                IF AVAIL sicuw.uwm130  THEN
                   ASSIGN impdata_fil.comper       = sicuw.uwm130.uom1_v 
                          impdata_fil.comacc       = sicuw.uwm130.uom2_v 
                          impdata_fil.deductpd     = sicuw.uwm130.uom5_v .
                   IF INDEX(impdata_fil.covcod,".") = 0  THEN  impdata_fil.si   = sicuw.uwm130.uom6_v .
                   ELSE impdata_fil.siplus   = sicuw.uwm130.uom6_v .
                
                FOR EACH sicuw.uwd132 USE-INDEX uwd13290  WHERE
                        sicuw.uwd132.policy   = sicuw.uwm120.policy  AND
                        sicuw.uwd132.rencnt   = sicuw.uwm120.rencnt  AND
                        sicuw.uwd132.endcnt   = sicuw.uwm120.endcnt  AND
                        sicuw.uwd132.riskno   = sicuw.uwm120.riskno  AND
                        sicuw.uwd132.itemno   = 1  NO-LOCK .
                
                     IF      sicuw.uwd132.bencod = "base"    THEN ASSIGN impdata_fil.base     = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30)).
                     ELSE IF sicuw.uwd132.bencod = "411"     THEN ASSIGN impdata_fil.no_411   = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30)).
                     ELSE IF sicuw.uwd132.bencod = "412"     THEN ASSIGN impdata_fil.no_412   = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30)).
                     ELSE IF sicuw.uwd132.bencod = "42"      THEN ASSIGN impdata_fil.no_42    = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30)).
                     ELSE IF sicuw.uwd132.bencod = "43"      THEN ASSIGN impdata_fil.no_43    = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30)).
                     ELSE IF sicuw.uwd132.bencod = "dod"     THEN ASSIGN impdata_fil.dod      = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30)).
                     /*ELSE IF sicuw.uwd132.bencod = "dod2"  THEN ASSIGN impdata_fil.addod    = DECI(DECI(np_dedod)  +  DECI(SUBSTRING(sicuw.uwd132.benvar,31,30))).*/
                     ELSE IF sicuw.uwd132.bencod = "dpd"     THEN ASSIGN impdata_fil.dpd      = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30)).
                     ELSE IF sicuw.uwd132.bencod = "flet"    THEN 
                       ASSIGN impdata_fil.fleet     = trim(SUBSTRING(sicuw.uwd132.benvar,31,30))
                              impdata_fil.fleetprem = DECI(sicuw.uwd132.prem_c) .
                     ELSE IF sicuw.uwd132.bencod = "ncb"     THEN 
                       ASSIGN impdata_fil.ncb      = trim(SUBSTRING(sicuw.uwd132.benvar,31,30))
                              impdata_fil.ncbprem  = DECI(sicuw.uwd132.prem_c) .
                     ELSE IF sicuw.uwd132.bencod = "dspc"    THEN 
                       ASSIGN impdata_fil.dspc     = trim(SUBSTRING(sicuw.uwd132.benvar,31,30))
                              impdata_fil.dspcprem = DECI(sicuw.uwd132.prem_c) .
                     ELSE IF sicuw.uwd132.bencod = "dstf"    THEN 
                       ASSIGN impdata_fil.dstf     = trim(SUBSTRING(sicuw.uwd132.benvar,31,30))
                              impdata_fil.dstfprem  = DECI(sicuw.uwd132.prem_c)  .
                     ELSE IF index(sicuw.uwd132.bencod,"cl") <> 0 THEN 
                       ASSIGN impdata_fil.claim    = trim(SUBSTRING(sicuw.uwd132.benvar,31,30))
                              impdata_fil.clprem   = DECI(sicuw.uwd132.prem_c) .
                   
                     IF      impdata_fil.covcod = "2.1" AND sicuw.uwd132.bencod = "ba21" THEN ASSIGN impdata_fil.baseplus     = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30)).
                     ELSE IF impdata_fil.covcod = "2.2" AND sicuw.uwd132.bencod = "ba22" THEN ASSIGN impdata_fil.baseplus     = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30)).
                     ELSE IF impdata_fil.covcod = "2.3" AND sicuw.uwd132.bencod = "ba23" THEN ASSIGN impdata_fil.baseplus     = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30)).
                     ELSE IF impdata_fil.covcod = "3.1" AND sicuw.uwd132.bencod = "ba31" THEN ASSIGN impdata_fil.baseplus     = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30)).
                     ELSE IF impdata_fil.covcod = "3.2" AND sicuw.uwd132.bencod = "ba32" THEN ASSIGN impdata_fil.baseplus     = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30)).
                     ELSE IF impdata_fil.covcod = "3.3" AND sicuw.uwd132.bencod = "ba33" THEN ASSIGN impdata_fil.baseplus     = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30)).
                     
                 
                END. /* uwd132 */
            END.
         END. /* uwm100*/
         IF impdata_fil.compolusory <> "" THEN DO:
             FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE sicuw.uwm100.policy = TRIM(impdata_fil.compolusory) NO-LOCK NO-ERROR.
             IF AVAIL sicuw.uwm100  THEN DO:
                 ASSIGN impdata_fil.comment = IF deci(impdata_fil.premt72) <> deci(uwm100.prem_t) THEN "เบี้ยในไฟล์ " + string(impdata_fil.premt72) + " ไม่เท่ากับพรีเมียม "  ELSE "" 
                        impdata_fil.compolusory = uwm100.policy
                        impdata_fil.premt72     = uwm100.prem_t
                        impdata_fil.rstp_t72    = uwm100.rstp_t
                        impdata_fil.rtax_t72    = uwm100.rtax_t.

                 FIND sicuw.uwm120 USE-INDEX uwm12001 WHERE 
                      sicuw.uwm120.policy    = sicuw.uwm100.policy   AND 
                      sicuw.uwm120.rencnt    = sicuw.uwm100.rencnt   AND                          
                      sicuw.uwm120.endcnt    = sicuw.uwm100.endcnt   NO-LOCK NO-ERROR.
                    IF AVAIL sicuw.uwm120 THEN 
                    ASSIGN impdata_fil.comper72  =  uwm120.com1p    
                           impdata_fil.comprem72 =  uwm120.com1_r . 
             END.
         END.
         RUN proc_assignrenew .

END. 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkRY C-Win 
PROCEDURE proc_chkRY :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Create by Ranu I. A64-0309       
------------------------------------------------------------------------------*/
DEF VAR nv_prm4t AS DECI FORMAT ">>>>>>>>>9.99-" .
DEF VAR nv_mv4t  AS DECI FORMAT ">>>>>>>>>9.99-" .
DEF VAR nv_polday AS INT INIT 0.
DO:
    ASSIGN nv_mv411  = 0
           nv_mv412  = 0
           nv_mv42   = 0
           nv_mv43   = 0
           nv_prm4t  = 0
           nv_mv4t   = 0 
           nv_polday = 0
           nv_polday = (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat).

    RUN wus/wusppadd (INPUT impdata_fil.subclass ,
                      INPUT impdata_fil.NO_411 ,
                      INPUT impdata_fil.NO_412 ,
                      INPUT impdata_fil.NO_42  ,
                      INPUT impdata_fil.NO_43  ,
                      INPUT impdata_fil.seat41 ,
                      INPUT-OUTPUT  nv_mv411,
                      INPUT-OUTPUT  nv_mv412,
                      INPUT-OUTPUT  nv_mv42 ,
                      INPUT-OUTPUT  nv_mv43 ) .

    IF nv_polday < 365 THEN DO:
        ASSIGN nv_mv411  = IF nv_mv411 > 0 then (nv_mv411 / 365) * nv_polday  else nv_mv411
               nv_mv412  = IF nv_mv412 > 0 then (nv_mv412 / 365) * nv_polday  else nv_mv412
               nv_mv42   = IF nv_mv42  > 0 then (nv_mv42 / 365) * nv_polday   else nv_mv42 
               nv_mv43   = IF nv_mv43  > 0 then (nv_mv43 / 365) * nv_polday   else nv_mv43 .
    END.

    IF impdata_fil.NO_411 <> 0 THEN DO: 
        IF nv_411t < 0  THEN 
            ASSIGN
                impdata_fil.comment  = impdata_fil.comment + "| Package code/Polmaster : " + impdata_fil.packcod + "/" + impdata_fil.polmaster + " เบี้ย รย.411 = " + STRING(nv_411t,"->>>,>>9.99") + " ไม่ถูกต้อง "
                impdata_fil.WARNING  = impdata_fil.WARNING + "|เบี้ย รย.411 = " + STRING(nv_411t,"->>>,>>9.99") + " ไม่ถูกต้อง " 
                impdata_fil.pass     = "N"     
                impdata_fil.OK_GEN   = "N".
    END.
    IF impdata_fil.NO_412 <> 0 THEN DO: 
        IF nv_412t < 0  THEN 
            ASSIGN
                impdata_fil.comment  = impdata_fil.comment + "| Package code/Polmaster : " + impdata_fil.packcod + "/" + impdata_fil.polmaster + " เบี้ย รย.412 = " + STRING(nv_412t,"->>>,>>9.99") + " ไม่ถูกต้อง "
                impdata_fil.WARNING  = "เบี้ย รย.412 = " + STRING(nv_412t,"->>>,>>9.99") + " ไม่ถูกต้อง " 
                impdata_fil.pass     = "N"     
                impdata_fil.OK_GEN   = "N".
    END.
    IF impdata_fil.NO_42  <> 0 THEN DO: 
        IF nv_42t < 0  THEN 
            ASSIGN
                impdata_fil.comment  = impdata_fil.comment + "| Package code/Polmaster : " + impdata_fil.packcod + "/" + impdata_fil.polmaster + " เบี้ย รย.42 = " + STRING(nv_42t,"->>>,>>9.99") + " ไม่ถูกต้อง "
                impdata_fil.WARNING  = "เบี้ย รย.42 = " + STRING(nv_42t,"->>>,>>9.99") + " ไม่ถูกต้อง " 
                impdata_fil.pass     = "N"     
                impdata_fil.OK_GEN   = "N".
    END.
    IF impdata_fil.NO_43  <> 0 THEN DO: 
        IF nv_43t < 0  THEN 
            ASSIGN
                impdata_fil.comment  = impdata_fil.comment + "| Package code/Polmaster : " + impdata_fil.packcod + "/" + impdata_fil.polmaster + " เบี้ย รย.43 = " + STRING(nv_43t,"->>>,>>9.99") + " ไม่ถูกต้อง "
                impdata_fil.WARNING  = "เบี้ย รย.43  = " + STRING(nv_43t,"->>>,>>9.99") + " ไม่ถูกต้อง " 
                impdata_fil.pass     = "N"     
                impdata_fil.OK_GEN   = "N".
    END.

    ASSIGN nv_prm4t = nv_411t + nv_412t + nv_42t + nv_43t .
    IF nv_prm4t <= 0 THEN DO:
        ASSIGN
                impdata_fil.comment  = impdata_fil.comment + "| Package code/Polmaster : " + impdata_fil.packcod + "/" + impdata_fil.polmaster + " เบี้ยรวม รย. = " + STRING(nv_prm4t,"->>>,>>9.99") + " ไม่ถูกต้อง "
                impdata_fil.WARNING  = "เบี้ยรวม รย. = " + STRING(nv_prm4t,"->>>,>>9.99") + " ไม่ถูกต้อง " 
                impdata_fil.pass     = "N"     
                impdata_fil.OK_GEN   = "N".
    END.
    

END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest0 C-Win 
PROCEDURE proc_chktest0 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: comment by a65-0079 code เต็ม      
------------------------------------------------------------------------------*/
DEF VAR nv_seq         AS INTEGER  INIT  1.
DEF VAR nv_sum         AS INTEGER  INIT  0.
DEF VAR nv_checkdigit  AS INTEGER . 
DEFINE VAR chk_sticker AS CHAR FORMAT "x(15)".
DEF VAR nv_class AS CHAR INIT "" .
DEF VAR nv_comper AS DECI INIT 0 . /* A64-0355*/
DEF BUFFER bfimpdata_fil FOR impdata_fil.
ASSIGN fi_process = "check data Text file riskno/Itemno :" + string(impdata_fil.riskno,"999") + "/" + string(impdata_fil.itemno,"999") + " " + impdata_fil.policyno .
DISP fi_process WITH FRAM fr_main.
IF ra_type = 2  AND impdata_fil.vehreg = " " AND impdata_fil.prepol  = " " THEN DO: 
   ASSIGN
       impdata_fil.comment = impdata_fil.comment + "| Vehicle Register is mandatory field. "
       impdata_fil.pass    = "N"   
       impdata_fil.OK_GEN  = "N".
END.
/* เช็ค Agent , Producer */
 IF  impdata_fil.agent = "" THEN DO:
     ASSIGN impdata_fil.comment = impdata_fil.comment + "| Agent Code is Null "
            impdata_fil.pass    = "N"       
            impdata_fil.OK_GEN  = "N".
 END.
 ELSE IF impdata_fil.producer = "" THEN DO:
     ASSIGN impdata_fil.comment = impdata_fil.comment + "| Producer Code is Null "
            impdata_fil.pass    = "N"       
            impdata_fil.OK_GEN  = "N".
 END.
 ELSE DO:
     ASSIGN nv_agent    = TRIM(impdata_fil.agent)
            nv_producer = TRIM(impdata_fil.producer) 
            nv_chkerror = "" .
     RUN wgw/wgwchkagpd(INPUT nv_agent,INPUT nv_producer,INPUT-OUTPUT nv_chkerror) . 
     IF nv_chkerror <> ""  THEN DO:
         ASSIGN impdata_fil.comment = impdata_fil.comment + "|" + TRIM(nv_chkerror)
                impdata_fil.pass    = "N"       
                impdata_fil.OK_GEN  = "N".
     END.
 END.
 IF impdata_fil.n_delercode <> "" THEN DO:
     FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = TRIM(impdata_fil.n_delercode) NO-LOCK NO-ERROR.
     IF NOT AVAIL xmm600 THEN 
         ASSIGN impdata_fil.comment = impdata_fil.comment + "| Not found Code Dealer " + impdata_fil.n_delercode + "(xmm600)" 
            impdata_fil.pass    = "N"       
            impdata_fil.OK_GEN  = "N".
     ELSE DO:
         IF xmm600.closed <> ? AND xmm600.closed < TODAY THEN
         ASSIGN impdata_fil.comment = impdata_fil.comment + "| Code Dealer " + impdata_fil.n_delercode + " Closed Date: " + STRING(xmm600.closed,"99/99/9999") 
                impdata_fil.pass    = "N"       
                impdata_fil.OK_GEN  = "N".
     END.
 END.
 IF impdata_fil.fincode <> "" THEN DO:
     FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = TRIM(impdata_fil.fincode) NO-LOCK NO-ERROR.
     IF NOT AVAIL xmm600 THEN 
         ASSIGN impdata_fil.comment = impdata_fil.comment + "| Not found Code Finance " + impdata_fil.fincode + "(xmm600)" 
            impdata_fil.pass    = "N"       
            impdata_fil.OK_GEN  = "N".
     ELSE DO:
      IF xmm600.closed <> ? AND xmm600.closed < TODAY THEN
       ASSIGN impdata_fil.comment = impdata_fil.comment + "| Code Finance " + impdata_fil.fincode + " Closed Date: " + STRING(xmm600.closed,"99/99/9999") 
              impdata_fil.pass    = "N"         
              impdata_fil.OK_GEN  = "N".
     END.
 END.
 IF impdata_fil.payercod <> "" THEN DO:
     FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = TRIM(impdata_fil.payercod) NO-LOCK NO-ERROR.
     IF NOT AVAIL xmm600 THEN 
         ASSIGN impdata_fil.comment = impdata_fil.comment + "| Not found Code Payer " + impdata_fil.payercod + "(xmm600)" 
            impdata_fil.pass    = "N" 
            impdata_fil.OK_GEN  = "N".
 END.
 IF impdata_fil.vatcode <> "" THEN DO:
     FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = TRIM(impdata_fil.vatcode) NO-LOCK NO-ERROR.
     IF NOT AVAIL xmm600 THEN 
         ASSIGN impdata_fil.comment = impdata_fil.comment + "| Not found Code Vat " + impdata_fil.vatcode + "(xmm600)" 
            impdata_fil.pass    = "N" 
            impdata_fil.OK_GEN  = "N".
     ELSE DO:
         IF xmm600.closed <> ? AND xmm600.closed < TODAY THEN
         ASSIGN impdata_fil.comment = impdata_fil.comment + "| Code VAT " + impdata_fil.vatcode + " Closed Date: " + STRING(xmm600.closed,"99/99/9999") 
             impdata_fil.pass    = "N" 
             impdata_fil.OK_GEN  = "N".
    END.
 END.
 IF impdata_fil.agco70 <> "" THEN DO:
     FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = TRIM(impdata_fil.agco70) NO-LOCK NO-ERROR.
     IF NOT AVAIL xmm600 THEN 
         ASSIGN impdata_fil.comment = impdata_fil.comment + "| Agent code Co-Broker " + impdata_fil.agco70 + "(xmm600)" 
            impdata_fil.pass    = "N" 
            impdata_fil.OK_GEN  = "N".
     ELSE DO:
         IF xmm600.closed <> ? AND xmm600.closed < TODAY THEN
         ASSIGN impdata_fil.comment = impdata_fil.comment + "| Agent code Co-Broker " + impdata_fil.agco70 + " Closed Date: " + STRING(xmm600.closed,"99/99/9999") 
             impdata_fil.pass    = "N" 
             impdata_fil.OK_GEN  = "N".
    END.
 END.
 IF TRIM(impdata_fil.jpae) <> ""  THEN DO:
     FIND LAST sicsyac.xmm604 WHERE sicsyac.xmm604.stfcod = TRIM(impdata_fil.jpae) NO-LOCK NO-ERROR .
     IF NOT AVAIL xmm604 THEN
         ASSIGN impdata_fil.comment = impdata_fil.comment + "| Not found Code AE " + impdata_fil.jpae + "(xmm604)" 
            impdata_fil.pass    = "N" 
            impdata_fil.OK_GEN  = "N".
 END.
 IF TRIM(impdata_fil.jpjtl) <> "" THEN DO: 
     FIND LAST sicsyac.xmm604 WHERE sicsyac.xmm604.stfcod = TRIM(impdata_fil.jpjtl) NO-LOCK NO-ERROR .
     IF NOT AVAIL xmm604 THEN
         ASSIGN impdata_fil.comment = impdata_fil.comment + "| Not found Code Japanese Team Leader " + (impdata_fil.jpjtl) + "(xmm604)" 
            impdata_fil.pass    = "N" 
            impdata_fil.OK_GEN  = "N".
 END.
 IF TRIM(impdata_fil.jpts) <> "" THEN DO: 
    FIND LAST sicsyac.xmm604 WHERE sicsyac.xmm604.stfcod = TRIM(impdata_fil.jpts) NO-LOCK NO-ERROR .
     IF NOT AVAIL xmm604 THEN
         ASSIGN impdata_fil.comment = impdata_fil.comment + "| Not found Code TS " + (impdata_fil.jpts) + "(xmm604)"
                impdata_fil.pass    = "N" 
                impdata_fil.OK_GEN  = "N".
 END.
 
 IF impdata_fil.cancel = "ca"  THEN  
    ASSIGN  impdata_fil.pass = "N"  
    impdata_fil.comment = impdata_fil.comment + "| cancel"
    impdata_fil.OK_GEN  = "N".

 IF impdata_fil.insnam = ""  THEN 
     ASSIGN  impdata_fil.pass = "N"  
     impdata_fil.comment = impdata_fil.comment + "| ชื่อผู้เอาประกันเป็นค่าว่าง" 
     impdata_fil.OK_GEN  = "N".
 
 IF impdata_fil.n_branch = ""  THEN DO: 
     ASSIGN  impdata_fil.pass = "N"  
     impdata_fil.comment = impdata_fil.comment + "| พบสาขาเป็นค่าว่าง" 
     impdata_fil.OK_GEN  = "N".
 END.
 ELSE DO:
     FIND LAST sicsyac.xmm023 USE-INDEX xmm02301 WHERE sicsyac.xmm023.branch = TRIM(impdata_fil.n_bran) NO-LOCK NO-ERROR.
     IF NOT AVAIL sicsyac.xmm023 THEN DO:
         ASSIGN  impdata_fil.pass = "N"  
         impdata_fil.comment = impdata_fil.comment + "| ไม่พบสาขาในระบบ (XMM023)" 
         impdata_fil.OK_GEN  = "N".
     END.
 END.
 RELEASE sicsyac.xmm023 .

 IF impdata_fil.camp_no <> ""  AND impdata_fil.camp_no <> "NONCAM" THEN DO:
     FIND LAST stat.campaign_master USE-INDEX campmaster02 WHERE 
        date(campaign_master.effdat) <= date(impdata_fil.comdat) AND
        date(campaign_master.enddat) >= date(impdata_fil.comdat) AND
         campaign_master.campcode = impdata_fil.camp_no NO-LOCK NO-ERROR.
     IF NOT AVAIL campaign_master THEN DO:
         ASSIGN impdata_fil.comment = impdata_fil.comment + "| ไม่พบ Campaign Code " + impdata_fil.camp_no + " ในระบบ (Campaign_master) "
            impdata_fil.pass    = "N" 
            impdata_fil.OK_GEN  = "N".
     END.
     ELSE DO:
        RUN proc_chkcampaign.
     END.
 END.
 RELEASE stat.campaign_master .
/* เช็ค แพ็คเกจ ในพารามิเตอร์ */
 IF impdata_fil.packcod <> ""  THEN DO:
    FIND LAST stat.caccount USE-INDEX caccount05 WHERE caccount.camcod = TRIM(impdata_fil.packcod) NO-LOCK NO-ERROR.
    IF AVAIL stat.caccount THEN DO:
        FIND LAST stat.campaign_fil USE-INDEX campfil14  WHERE campaign_fil.camcod = caccount.camcod NO-LOCK NO-ERROR.
        IF NOT AVAIL stat.campaign_fil THEN DO:
            ASSIGN impdata_fil.comment = impdata_fil.comment + "|รหัสแพ็คเกจ " + impdata_fil.packcod + " ยังไม่โหลดวิธีคีย์เข้าระบบ" 
                   impdata_fil.pass    = "N" 
                   impdata_fil.OK_GEN  = "N".
        END.
        ELSE IF ra_type = 1 THEN RUN proc_policyname4 . /*A64-0044*/
    END.
    ELSE ASSIGN impdata_fil.comment = impdata_fil.comment + "|ไม่พบรหัสแพ็คเกจ" + impdata_fil.packcod + " ในระบบ"
                impdata_fil.pass    = "N" 
                impdata_fil.OK_GEN  = "N".
 END.

 IF impdata_fil.poltyp = "V70" AND  int(impdata_fil.premt) = 0  THEN 
     ASSIGN impdata_fil.comment = impdata_fil.comment + "| เบี้ยสุทธิเป็น 0 "
     impdata_fil.pass    = "N" 
     impdata_fil.OK_GEN  = "N".

  /* commission */
 IF (DECI(impdata_fil.comprem70) <> (-1)) AND DECI(impdata_fil.comper70) = (-1)  THEN 
  ASSIGN impdata_fil.comment = impdata_fil.comment + "|กรมธรรม์ระบุ 70 Commission Amount " + string(impdata_fil.comprem70) + " แต่ไม่ระบุ Commission% "
         impdata_fil.pass    = "N" 
         impdata_fil.OK_GEN  = "N".
 /* add by : ranu i. A64-0355 */
 IF impdata_fil.agco70 <> "" THEN DO:
     ASSIGN nv_comper = DECI(impdata_fil.comco_per70) + DECI(impdata_fil.comper70) .
     IF DECI(impdata_fil.comco_per70) = 0 THEN
       ASSIGN impdata_fil.comment = impdata_fil.comment + "|กรมธรรม์ Co-broker กรุณาระบุ Commission co-broker% "
             impdata_fil.pass    = "N" 
             impdata_fil.OK_GEN  = "N".
     IF nv_comper > 18 THEN 
       ASSIGN impdata_fil.comment = impdata_fil.comment + "|ยอดรวม (Commission%) + (Commission co-broker%) มากกกว่า 18% "
         impdata_fil.pass    = "N" 
         impdata_fil.OK_GEN  = "N".
 END.
 /* end : A64-0355 */
 IF impdata_fil.poltyp = "V70" AND impdata_fil.riskno <> 0 THEN DO:
     /* เช็คความคุ้มครอง */
     IF impdata_fil.covcod = "" THEN DO:
         ASSIGN impdata_fil.comment = impdata_fil.comment + "| ประเภทความคุ้มครองเป็นค่าว่าง "
                impdata_fil.pass    = "N" 
                impdata_fil.OK_GEN  = "N".
     END.
     /* เช็คน้ำหนักตัน , CC */
     IF impdata_fil.subclass = " " THEN DO: 
         ASSIGN  impdata_fil.comment = impdata_fil.comment + "| sub class เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
         impdata_fil.pass    = "N"  
         impdata_fil.OK_GEN  = "N".
     END.
     ELSE DO:
       nv_class = trim(SUBSTR(impdata_fil.subclass,1,1)) . 
       IF (nv_class = "3" OR nv_class = "4" OR nv_class = "5" OR TRIM(impdata_fil.subclass) = "803"  OR  
       TRIM(impdata_fil.subclass)  = "804"  OR TRIM(impdata_fil.subclass) = "805") AND int(impdata_fil.weight) = 0 THEN DO:
          ASSIGN impdata_fil.comment = impdata_fil.comment + "|รหัสรถ " + impdata_fil.subclass + " ต้องระบุน้ำหนักในช่อง น้ำหนัก(ตัน) " 
                 impdata_fil.pass    = "N" 
                 impdata_fil.OK_GEN  = "N".
       END.
       /* A64-0044 */
       /*ELSE IF SUBSTR(impdata_fil.subclass,LENGTH(impdata_fil.subclass),1) = "E" AND INT(impdata_fil.watt) = 0 THEN*/ /*A68-0044*/
       ELSE IF INDEX(impdata_fil.subclass,"E") <> 0 AND nv_class <> "3" AND nv_class <> "4" AND 
               nv_class <> "5" AND INT(impdata_fil.watt) = 0 THEN  DO: /*A68-0044*/
           ASSIGN impdata_fil.comment = impdata_fil.comment +  "| " + impdata_fil.subclass + " เป็น Class รถไฟฟ้า ต้องระบุข้อมูล Kilowatt " 
                      impdata_fil.pass    = "N" 
                      impdata_fil.OK_GEN  = "N".
       END.
       /* end : A64-0044 */
       ELSE IF int(impdata_fil.engcc) = 0 AND int(impdata_fil.weight)    = 0       AND 
               INT(impdata_fil.watt)  = 0 AND trim(impdata_fil.subclass) <> "801"  THEN DO:
               ASSIGN impdata_fil.comment = impdata_fil.comment +  "| " + impdata_fil.subclass + " น้ำหนักรถเป็นค่าว่าง ต้องระบุ CC หรือ Ton หรือ Kilowatt " 
                      impdata_fil.pass    = "N" 
                      impdata_fil.OK_GEN  = "N".
       END.
     END.
      /******* drivernam **********/
     nv_sclass = impdata_fil.subclass. 
     If  impdata_fil.drivnam = "y" AND substr(nv_sclass,2,1) = "2"   Then 
         ASSIGN impdata_fil.comment = impdata_fil.comment + "| CODE  nv_sclass Driver 's Name must be no. "
             impdata_fil.pass    = "N"    
             impdata_fil.OK_GEN  = "N".
    /* A67-0029
    IF impdata_fil.drivnam  = "y" AND impdata_fil.drivername1 =  " "   THEN 
         ASSIGN  impdata_fil.comment = impdata_fil.comment + "| มีการระบุว่ามีคนขับแต่ไม่มีชื่อคนขับ"
         impdata_fil.pass    = "N" 
         impdata_fil.OK_GEN  = "N".*/
     IF impdata_fil.prempa = " " AND impdata_fil.poltyp = "V70" THEN 
         ASSIGN  impdata_fil.comment = impdata_fil.comment + "| prem pack เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
         impdata_fil.pass    = "N"     
         impdata_fil.OK_GEN  = "N".
     IF impdata_fil.brand = " " THEN 
         ASSIGN  impdata_fil.comment = impdata_fil.comment + "| Brand เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
         impdata_fil.pass    = "N"        
         impdata_fil.OK_GEN  = "N".
     IF impdata_fil.yrmanu = " " THEN 
         ASSIGN  impdata_fil.comment = impdata_fil.comment + "| year manufacture เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
         impdata_fil.pass    = "N"  
         impdata_fil.OK_GEN  = "N".
     ASSIGN
         nv_maxsi  = 0       nv_maxdes = ""  
         nv_minsi  = 0       nv_mindes = ""  
         nv_si     = 0       chkred    = NO. 
         /*end note add &  modi*/
     ASSIGN                  
       NO_CLASS  = impdata_fil.prempa + impdata_fil.subclass 
       nv_poltyp = impdata_fil.poltyp.
     
     If no_class  <>  " " Then do:
       FIND FIRST  sicsyac.xmd031 USE-INDEX xmd03101   WHERE
           sicsyac.xmd031.poltyp =   nv_poltyp AND
           sicsyac.xmd031.class  =   no_class  NO-LOCK NO-ERROR NO-WAIT.
       IF NOT AVAILABLE sicsyac.xmd031 THEN 
          ASSIGN
               impdata_fil.comment = impdata_fil.comment + "| Not On Business Class xmd031" 
               impdata_fil.pass    = "N"   
               impdata_fil.OK_GEN  = "N".
       
       FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE 
           sicsyac.xmm016.class =    no_class  NO-LOCK NO-ERROR.
       IF NOT AVAILABLE sicsyac.xmm016 THEN 
           ASSIGN
               impdata_fil.comment = impdata_fil.comment + "| Not on Business class on xmm016"
               impdata_fil.pass    = "N"    
               impdata_fil.OK_GEN  = "N".
       ELSE 
           ASSIGN    
               impdata_fil.tariff =   sicsyac.xmm016.tardef
               no_class       =   sicsyac.xmm016.class
               nv_sclass      =   Substr(no_class,2,3).
     END.
     release sicsyac.xmd031.
     release sicsyac.xmm016.
     
     FIND sicsyac.sym100 USE-INDEX sym10001 WHERE
       sicsyac.sym100.tabcod = "U014"    AND
       sicsyac.sym100.itmcod = impdata_fil.vehuse NO-LOCK NO-ERROR.
     IF NOT AVAIL sicsyac.sym100 THEN 
       ASSIGN     
           impdata_fil.pass    = "N"  
           impdata_fil.comment = impdata_fil.comment + "| ไม่พบ Veh.Usage ในระบบ "
           impdata_fil.OK_GEN  = "N".
     Find  sicsyac.sym100 Use-index sym10001  Where
        sicsyac.sym100.tabcod = "u013"         And
        sicsyac.sym100.itmcod = impdata_fil.covcod
        No-lock no-error no-wait.
     IF not avail sicsyac.sym100 Then 
        ASSIGN impdata_fil.comment = impdata_fil.comment + "| Not on Motor Cover Type Codes table sym100 u013"
            impdata_fil.pass    = "N"    
            impdata_fil.OK_GEN  = "N".
     RELEASE sicsyac.sym100 .
     /*---------- fleet -------------------*/
     IF inte(impdata_fil.fleet) <> 0 AND INTE(impdata_fil.fleet) <> 10 Then 
        ASSIGN impdata_fil.comment = impdata_fil.comment + "| Fleet Percent must be 0 or 10. "
            impdata_fil.pass    = "N"    
            impdata_fil.OK_GEN  = "N".
     /*----------  ncb -------------------*/
     IF (DECI(impdata_fil.ncb) = 0 )  OR (DECI(impdata_fil.ncb) = 20 ) OR
       (DECI(impdata_fil.ncb) = 30 ) OR (DECI(impdata_fil.ncb) = 40 ) OR
       (DECI(impdata_fil.ncb) = 50 )    THEN DO:
     END.
     ELSE ASSIGN impdata_fil.comment = impdata_fil.comment + "| not on NCB Rates file xmm104."
            impdata_fil.pass    = "N"   
            impdata_fil.OK_GEN  = "N".
     ASSIGN NV_NCBPER = 0
           NV_NCBPER = INTE(impdata_fil.NCB).
     If nv_ncbper  <> 0 Then do:
        Find first sicsyac.xmm104 Use-index xmm10401 Where
            sicsyac.xmm104.tariff = impdata_fil.tariff                      AND
            sicsyac.xmm104.class  = impdata_fil.prempa + impdata_fil.subclass   AND
            sicsyac.xmm104.covcod = impdata_fil.covcod           AND
            sicsyac.xmm104.ncbper = INTE(impdata_fil.ncb)
            No-lock no-error no-wait.
        IF not avail  sicsyac.xmm104  Then 
            ASSIGN impdata_fil.comment = impdata_fil.comment + "| This NCB Step not on NCB Rates file xmm104. "
                impdata_fil.pass    = "N"     
                impdata_fil.OK_GEN  = "N".
     END. /*ncb <> 0*/
     RELEASE sicsyac.xmm104 .
     RUN proc_chkpolpremium . /* เช็คการออกกรมธรรม์ในพรีเมียม */
 END.
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest1 C-Win 
PROCEDURE proc_chktest1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
-----------------------------------------------------------------------------*/
DEF BUFFER bfimpdata_fil FOR impdata_fil.
DEF VAR n_risk AS INT.
DEF VAR n_item AS INT.
RUN proc_var.
LOOP_impdata_fil:

FOR EACH impdata_fil  NO-LOCK .
    ASSIGN n_risk = impdata_fil.riskno
           n_item = impdata_fil.itemno .
END.

FOR EACH impdata_fil  WHERE impdata_fil.policyno <> "" AND impdata_fil.riskno <> 0 AND impdata_fil.itemno <> 0 .
        /*------------------  renew ---------------------*/
        ASSIGN fi_process = "Process data Load Text...." + impdata_fil.policyno .
        DISP fi_process WITH FRAM fr_main.

        RUN proc_cr_2.
        ASSIGN 
            nv_dss_per   = 0   
            n_rencnt     = 0
            n_endcnt     = 0
            nv_dscom     = 0
            nv_drivno    = 0
            nv_drivlevel = 0  /*A67-0029*/
            nv_dlevper   = 0  /*A67-0029*/
            /*nv_polmaster = "" */ /*A64-0044*/
            n_rencnt     = IF ra_type = 1 THEN 0 ELSE INT(impdata_fil.rencnt).
        
        IF impdata_fil.poltyp = "V70" THEN impdata_fil.compul = "N"  .
        RUN proc_policy . 
        RUN proc_chktest2.      
        RUN proc_chktest3.
        RUN proc_chktest4. 

        IF impdata_fil.riskno = n_risk AND impdata_fil.itemno  = n_item  THEN RUN proc_chktest41.
        
    RELEASE sic_bran.uwm100 .
    RELEASE sic_bran.uwm120 .
    RELEASE sic_bran.uwm130 .
    RELEASE sic_bran.uwm301 .
END.     /*for each*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest2 C-Win 
PROCEDURE proc_chktest2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: add by A67-0029       
------------------------------------------------------------------------------*/
ASSIGN fi_process = "Create Data " + impdata_fil.policyno + " Risk/Item " + string(impdata_fil.riskno,"999") + "/" +
                    STRING(impdata_fil.itemno,"999") + " on uwm130,uwm301...."  .
DISP fi_process WITH FRAM fr_main.

FIND sic_bran.uwm130 USE-INDEX uwm13001 WHERE
           sic_bran.uwm130.policy  = sic_bran.uwm100.policy AND
           sic_bran.uwm130.rencnt  = sic_bran.uwm100.rencnt AND
           sic_bran.uwm130.endcnt  = sic_bran.uwm100.endcnt AND
           sic_bran.uwm130.riskgp  = s_riskgp               AND            /*0*/
           sic_bran.uwm130.riskno  = impdata_fil.riskno         AND            /*1*/
           sic_bran.uwm130.itemno  = impdata_fil.itemno         AND            /*1*/
           sic_bran.uwm130.bchyr   = nv_batchyr             AND 
           sic_bran.uwm130.bchno   = nv_batchno             AND 
           sic_bran.uwm130.bchcnt  = nv_batcnt             NO-WAIT NO-ERROR.
IF NOT AVAILABLE uwm130 THEN DO:
    DO TRANSACTION:
    CREATE sic_bran.uwm130.
    ASSIGN
        sic_bran.uwm130.policy = sic_bran.uwm120.policy
        sic_bran.uwm130.rencnt = sic_bran.uwm120.rencnt   sic_bran.uwm130.endcnt = sic_bran.uwm120.endcnt
        sic_bran.uwm130.riskgp = sic_bran.uwm120.riskgp   sic_bran.uwm130.riskno = sic_bran.uwm120.riskno
        sic_bran.uwm130.itemno = impdata_fil.itemno
        sic_bran.uwm130.bchyr  = nv_batchyr          /* batch Year */
        sic_bran.uwm130.bchno  = nv_batchno          /* bchno      */
        sic_bran.uwm130.bchcnt = nv_batcnt        /* bchcnt     */
        nv_sclass     = impdata_fil.subclass
        nv_uom6_u     = "" 
        nv_othcod     = ""
        nv_othvar1    = ""
        nv_othvar2    = ""
        nv_othvar     = "". 

    IF impdata_fil.special  =  "A"  THEN DO:
       nv_uom6_u  =  "A".
    END.     
    IF CAPS(nv_uom6_u) = "A"  Then
        Assign  nv_uom6_u                  = "A"
        nv_othcod                  = "OTH"
        nv_othvar1                 = "     Accessory  = "
        nv_othvar2                 =  STRING(nv_uom6_u)
        SUBSTRING(nv_othvar,1,30)  = nv_othvar1
        SUBSTRING(nv_othvar,31,30) = nv_othvar2.
    ELSE
        ASSIGN  nv_uom6_u              = ""
            nv_othcod                  = ""
            nv_othvar1                 = ""
            nv_othvar2                 = ""
            SUBSTRING(nv_othvar,1,30)  = nv_othvar1
            SUBSTRING(nv_othvar,31,30) = nv_othvar2.
    
    IF (impdata_fil.covcod = "1") OR (impdata_fil.covcod = "5") OR (impdata_fil.covcod = "2.1") OR (impdata_fil.covcod = "3.1") OR
       (impdata_fil.covcod = "2.2") OR (impdata_fil.covcod = "3.2")  THEN /*a62-0215*/
        ASSIGN
            sic_bran.uwm130.uom6_v   = IF      impdata_fil.covcod = "2.1" THEN inte(impdata_fil.siplus)
                                       ELSE IF impdata_fil.covcod = "2.2" THEN inte(impdata_fil.siplus) 
                                       ELSE IF impdata_fil.covcod = "3.1" THEN INTE(impdata_fil.siplus) 
                                       ELSE IF impdata_fil.covcod = "3.2" THEN INTE(impdata_fil.siplus) 
                                       ELSE inte(impdata_fil.si)
            sic_bran.uwm130.uom7_v   = IF      impdata_fil.covcod = "2.1" THEN inte(impdata_fil.siplus)
                                       ELSE IF impdata_fil.covcod = "2.2" THEN inte(impdata_fil.siplus) 
                                       ELSE IF impdata_fil.covcod = "3.1" THEN 0 
                                       ELSE IF impdata_fil.covcod = "3.2" THEN 0  
                                       ELSE inte(impdata_fil.si)

            sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
            sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
            sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
            sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
            sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
    IF impdata_fil.covcod = "2"  THEN 
        ASSIGN
            sic_bran.uwm130.uom6_v   = 0
            sic_bran.uwm130.uom7_v   = inte(impdata_fil.si)
            sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
            sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
            sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
            sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
            sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
    IF impdata_fil.covcod = "3"  THEN 
        ASSIGN
            sic_bran.uwm130.uom6_v   = 0
            sic_bran.uwm130.uom7_v   = 0
            sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
            sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
            sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
            sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
            sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/

    IF impdata_fil.poltyp = "v72" THEN  n_sclass72 = impdata_fil.subclass.
    ELSE n_sclass72 = impdata_fil.prempa + impdata_fil.subclass .

    FIND FIRST stat.clastab_fil Use-index clastab01 Where
        stat.clastab_fil.class   = n_sclass72       And
        stat.clastab_fil.covcod  = impdata_fil.covcod No-lock  No-error No-wait.
    IF avail stat.clastab_fil Then do: 
        Assign 
            sic_bran.uwm130.uom1_v     = if deci(impdata_fil.comper)   <> 0 then deci(impdata_fil.comper)   else stat.clastab_fil.uom1_si
            sic_bran.uwm130.uom2_v     = if deci(impdata_fil.comacc)   <> 0 then deci(impdata_fil.comacc)   else stat.clastab_fil.uom2_si
            sic_bran.uwm130.uom5_v     = if deci(impdata_fil.deductpd) <> 0 then deci(impdata_fil.deductpd) else stat.clastab_fil.uom5_si
            sic_bran.uwm130.uom1_u     = if sic_bran.uwm130.uom1_v = 999999999 then "U" else ""  
            sic_bran.uwm130.uom2_u     = if sic_bran.uwm130.uom2_v = 999999999 then "U" else ""  
            sic_bran.uwm130.uom5_u     = if sic_bran.uwm130.uom5_v = 999999999 then "U" else ""  
            sic_bran.uwm130.uom8_v     =  0 /*stat.clastab_fil.uom8_si*/ /*A64-0369*/                
            sic_bran.uwm130.uom9_v     =  0 /*stat.clastab_fil.uom9_si*/ /*A64-0369*/          
            sic_bran.uwm130.uom3_v     =  0
            sic_bran.uwm130.uom4_v     =  0
            sic_bran.uwm130.uom6_u     =  nv_uom6_u    /* อุปกรณ์เสริมพิเศษ */
            impdata_fil.comper             =  0  /*stat.clastab_fil.uom8_si*/ /*A64-0369*/                  
            impdata_fil.comacc             =  0  /*stat.clastab_fil.uom9_si*/ /*A64-0369*/  
            nv_uom1_v                  =  sic_bran.uwm130.uom1_v   
            nv_uom2_v                  =  sic_bran.uwm130.uom2_v
            nv_uom5_v                  =  sic_bran.uwm130.uom5_v        
            sic_bran.uwm130.uom1_c  = "D1"
            sic_bran.uwm130.uom2_c  = "D2"
            sic_bran.uwm130.uom5_c  = "D5"
            sic_bran.uwm130.uom6_c  = "D6"
            sic_bran.uwm130.uom7_c  = "D7".
        If  impdata_fil.garage  =  "G"  THEN DO:
            /* add by : A65-0079 */
            Assign 
             impdata_fil.no_411  =  if deci(impdata_fil.NO_411) <> -1 then impdata_fil.NO_411 else stat.clastab_fil.si_41pai
             impdata_fil.no_412  =  if deci(impdata_fil.NO_412) <> -1 then impdata_fil.NO_412 else stat.clastab_fil.si_41pai
             impdata_fil.no_42   =  if deci(impdata_fil.NO_42)  <> -1 then impdata_fil.NO_42  else stat.clastab_fil.si_42                         
             impdata_fil.no_43   =  if deci(impdata_fil.NO_43)  <> -1 then impdata_fil.NO_43  else stat.clastab_fil.impsi_43
            /* end : A65-0079*/
             impdata_fil.seat41  =  IF impdata_fil.seat41 <> 0 THEN impdata_fil.seat41 ELSE stat.clastab_fil.dri_41 + stat.clastab_fil.pass_41.  
        END.
        ELSE DO: 
            /* add by : A65-0079 */
            Assign impdata_fil.no_411  =  if deci(impdata_fil.NO_411) <> -1 then impdata_fil.NO_411 else stat.clastab_fil.si_41unp
                impdata_fil.no_412  =  if deci(impdata_fil.NO_412) <> -1 then impdata_fil.NO_412 else stat.clastab_fil.si_41unp
                impdata_fil.no_42   =  if deci(impdata_fil.NO_42)  <> -1 then impdata_fil.NO_42  else stat.clastab_fil.si_42
                impdata_fil.no_43   =  if deci(impdata_fil.NO_43)  <> -1 then impdata_fil.NO_43  else stat.clastab_fil.si_43
            /* end : A65-0079*/
                impdata_fil.seat41  = IF impdata_fil.seat41 <> 0 THEN impdata_fil.seat41 ELSE stat.clastab_fil.dri_41 + stat.clastab_fil.pass_41.  
        END.
    END.
    ELSE DO:
        ASSIGN  impdata_fil.pass    = "N"
                impdata_fil.comment = impdata_fil.comment + "| Class " + n_sclass72 + " Cover: " + impdata_fil.covcod + " Not on Paramter (clastab_fil) ". 
    END.
    ASSIGN  nv_riskno = impdata_fil.riskno
            nv_itemno = impdata_fil.itemno.
    IF impdata_fil.covcod = "1" Then 
        RUN wgs/wgschsum(INPUT  impdata_fil.policy, 
                         nv_riskno,
                         nv_itemno).
    END.  /* end Do transaction*/
    s_recid3  = RECID(sic_bran.uwm130).
    nv_covcod =   impdata_fil.covcod.
    nv_makdes  =  impdata_fil.brand.
    nv_moddes  =  impdata_fil.model.
    nv_newsck = " ".
    RUN proc_chassic.
    IF SUBSTRING(impdata_fil.stk,1,1) = "2" THEN nv_newsck = "0" + impdata_fil.stk.
    ELSE nv_newsck =  impdata_fil.stk.
    FIND sic_bran.uwm301 USE-INDEX uwm30101      WHERE
         sic_bran.uwm301.policy = sic_bran.uwm100.policy AND
         sic_bran.uwm301.rencnt = sic_bran.uwm100.rencnt AND
         sic_bran.uwm301.endcnt = sic_bran.uwm100.endcnt AND
         sic_bran.uwm301.riskgp = s_riskgp               AND
         sic_bran.uwm301.riskno = impdata_fil.riskno     AND
         sic_bran.uwm301.itemno = impdata_fil.itemno     AND
         sic_bran.uwm301.bchyr  = nv_batchyr             AND 
         sic_bran.uwm301.bchno  = nv_batchno             AND 
         sic_bran.uwm301.bchcnt = nv_batcnt    NO-WAIT NO-ERROR.
     IF NOT AVAILABLE sic_bran.uwm301 THEN DO:                  
         DO TRANSACTION:
             CREATE sic_bran.uwm301.
         END. 
     END. 
     ASSIGN
         sic_bran.uwm301.policy   = sic_bran.uwm120.policy                 
         sic_bran.uwm301.rencnt   = sic_bran.uwm120.rencnt
         sic_bran.uwm301.endcnt   = sic_bran.uwm120.endcnt
         sic_bran.uwm301.riskgp   = sic_bran.uwm120.riskgp
         sic_bran.uwm301.riskno   = sic_bran.uwm120.riskno
         sic_bran.uwm301.itemno   = impdata_fil.itemno
         sic_bran.uwm301.tariff   = impdata_fil.tariff    
         sic_bran.uwm301.covcod   = nv_covcod
         sic_bran.uwm301.cha_no   = IF impdata_fil.chasno = "" THEN "-" ELSE impdata_fil.chasno  /*A65-0079*/
         sic_bran.uwm301.trareg   = nv_uwm301trareg    
         sic_bran.uwm301.eng_no   = impdata_fil.eng
         sic_bran.uwm301.Tons     = IF int(impdata_fil.weight) <> 0 AND DECI(impdata_fil.weight) < 100 THEN impdata_fil.weight * 1000 ELSE impdata_fil.weight  
         sic_bran.uwm301.engine   = INTEGER(impdata_fil.engcc)
         sic_bran.uwm301.watts    = INTEGER(impdata_fil.watt)
         sic_bran.uwm301.yrmanu   = INTEGER(impdata_fil.yrmanu)
         sic_bran.uwm301.garage   = impdata_fil.garage
         sic_bran.uwm301.body     = impdata_fil.body
         sic_bran.uwm301.seats    = INTEGER(impdata_fil.seat)
         sic_bran.uwm301.mv41seat = INTEGER(impdata_fil.seat41)
         sic_bran.uwm301.mv_ben83 = IF impdata_fil.poltyp = "V72" THEN "" ELSE IF trim(impdata_fil.benname) = "-" OR trim(impdata_fil.benname) = "Null" THEN ""  /*Null A64-0309*/
                                    ELSE trim(impdata_fil.benname)
         sic_bran.uwm301.vehreg   = impdata_fil.vehreg + " " + impdata_fil.re_country
         sic_bran.uwm301.vehuse   = impdata_fil.vehuse
         sic_bran.uwm301.modcod   = impdata_fil.redbook
         sic_bran.uwm301.moddes   = trim(impdata_fil.brand) + " " + trim(impdata_fil.model) + " " + trim(impdata_fil.submodel)    
         sic_bran.uwm301.sckno    = 0
         sic_bran.uwm301.itmdel   = NO
         sic_bran.uwm301.logbok   = IF TRIM(impdata_fil.inspec) = "N" OR TRIM(impdata_fil.inspec) = "No" THEN "N" 
                                    ELSE IF TRIM(impdata_fil.inspec) = "Y" OR TRIM(impdata_fil.inspec) = "Yes" THEN "Y" ELSE "" 
         sic_bran.uwm301.car_year = INT(impdata_fil.re_year)                                                                
         sic_bran.uwm301.province_reg  = trim(impdata_fil.re_country)                                                   
         sic_bran.uwm301.vehgrp    = trim(impdata_fil.cargrp)                                                   
         sic_bran.uwm301.car_color = trim(impdata_fil.colorcar)                                                  
         sic_bran.uwm301.fuel      = trim(impdata_fil.fule)
         sic_bran.uwm301.watt      = impdata_fil.watt      /* A64-0044-*/                                                   
         impdata_fil.tariff        = sic_bran.uwm301.tariff
         sic_bran.uwm130.i_text    = IF INT(impdata_fil.cctv)  <> 0 THEN "0001" ELSE ""   /*CCTV */
         /* A67-0029 */
         sic_bran.uwm301.maksi     = INTE(impdata_fil.maksi)      
         sic_bran.uwm301.eng_no2   = impdata_fil.eng_no2  
         sic_bran.uwm301.battper   = INTE(impdata_fil.battper)
         /*sic_bran.uwm301.battrate  = INTE(impdata_fil.battrate)*/
         sic_bran.uwm301.battyr    = INTE(impdata_fil.battyr)  
         sic_bran.uwm301.battsi    = INTE(impdata_fil.battsi)
         sic_bran.uwm301.battprice = deci(impdata_fil.battprice)
         sic_bran.uwm301.battno    = impdata_fil.battno 
         sic_bran.uwm301.chargno   = impdata_fil.chargno 
         sic_bran.uwm301.chargsi   = deci(impdata_fil.chargsi)  
         sic_bran.uwm301.battflg   = IF DECI(impdata_fil.battprm) <> 0 THEN "Y" ELSE "N"  
         sic_bran.uwm301.chargflg  = IF DECI(impdata_fil.chargprm) <> 0 THEN "Y" ELSE "N". 

   FOR EACH impacc_fil WHERE impacc_fil.policy = impdata_fil.policy AND impacc_fil.riskno = impdata_fil.riskno AND 
       impacc_fil.itemno = impdata_fil.itemno  NO-LOCK.
       RUN proc_prmtxt.
       IF nv_acc1  <> "" THEN ASSIGN SUBSTRING(sic_bran.uwm301.prmtxt,1,60)    =  nv_acc1.
       IF nv_acc2  <> "" THEN ASSIGN SUBSTRING(sic_bran.uwm301.prmtxt,61,60)   =  nv_acc2.
       IF nv_acc3  <> "" THEN ASSIGN SUBSTRING(sic_bran.uwm301.prmtxt,121,60)  =  nv_acc3.                  
       IF nv_acc4  <> "" THEN ASSIGN SUBSTRING(sic_bran.uwm301.prmtxt,181,60)  =  nv_acc4.                  
       IF nv_acc5  <> "" THEN ASSIGN SUBSTRING(sic_bran.uwm301.prmtxt,241,60)  =  nv_acc5.                  
       IF nv_acc6  <> "" THEN ASSIGN SUBSTRING(sic_bran.uwm301.prmtxt,301,60)  =  nv_acc6.                   
       IF nv_acc7  <> "" THEN ASSIGN SUBSTRING(sic_bran.uwm301.prmtxt,361,60)  =  nv_acc7.                  
       IF nv_acc8  <> "" THEN ASSIGN SUBSTRING(sic_bran.uwm301.prmtxt,421,60)  =  nv_acc8.                  
       IF nv_acc9  <> "" THEN ASSIGN SUBSTRING(sic_bran.uwm301.prmtxt,481,60)  =  nv_acc9.                  
       IF nv_acc10 <> "" THEN ASSIGN SUBSTRING(sic_bran.uwm301.prmtxt,541,60) =  nv_acc10.
   END.
   ASSIGN  sic_bran.uwm301.bchyr = nv_batchyr       /* batch Year */
           sic_bran.uwm301.bchno = nv_batchno       /* bchno      */
           sic_bran.uwm301.bchcnt= nv_batcnt  .    /* bchcnt     */
   IF impdata_fil.prepol = "" THEN DO:
     IF INT(impdata_fil.drivnam) > 0 THEN DO:
         ASSIGN impdata_fil.drivnam = "Y" .
         /*RUN proc_mailtxt.  /*A55-0151*/*/ /*A67-0029*/
         RUN proc_chkdrive. /*A67-0029*/
     END.
     ELSE impdata_fil.drivnam = "N".
   END.
   ELSE DO:
         FOR EACH ws0m009 WHERE ws0m009.policy  = impdata_fil.driver NO-LOCK .
            CREATE brstat.mailtxt_fil.
            ASSIGN
                brstat.mailtxt_fil.policy  = TRIM(sic_bran.uwm301.policy) +
                             STRING(sic_bran.uwm301.rencnt,"99" ) +
                             STRING(sic_bran.uwm301.endcnt,"999")  +
                             STRING(sic_bran.uwm301.riskno,"999") +
                             STRING(sic_bran.uwm301.itemno,"999")    
                brstat.mailtxt_fil.lnumber = INTEGER(ws0m009.lnumber)
                brstat.mailtxt_fil.ltext   = ws0m009.ltext  
                brstat.mailtxt_fil.ltext2  = ws0m009.ltext2   
                brstat.mailtxt_fil.bchyr   = nv_batchyr 
                brstat.mailtxt_fil.bchno   = nv_batchno 
                brstat.mailtxt_fil.bchcnt  = nv_batcnt .
            ASSIGN nv_drivno = INTEGER(ws0m009.lnumber).
         END.
       IF nv_drivno <> 0 THEN DO:
           ASSIGN impdata_fil.drivnam = "Y" 
                  sic_bran.uwm301.actprm   = impdata_fil.nname .
       END.
   END.
   ASSIGN s_recid4    = RECID(sic_bran.uwm301).
   IF impdata_fil.redbook <> "" THEN DO:
       FIND FIRST stat.maktab_fil USE-INDEX maktab01   WHERE 
           stat.maktab_fil.sclass = impdata_fil.subclass  AND
           stat.maktab_fil.modcod = impdata_fil.redbook   No-lock no-error no-wait.
       If  avail  stat.maktab_fil  Then DO:
           ASSIGN
           sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod 
           sic_bran.uwm301.vehgrp  =  IF impdata_fil.cargrp = "" THEN stat.maktab_fil.prmpac ELSE impdata_fil.cargrp /*A65-0079*/
           impdata_fil.cargrp      =  IF impdata_fil.cargrp = "" THEN stat.maktab_fil.prmpac ELSE impdata_fil.cargrp /*A65-0079*/
           impdata_fil.seat41      =  IF impdata_fil.seat41 = 0 THEN stat.maktab_fil.seats ELSE impdata_fil.seat41 .
         /*IF sic_bran.uwm301.maksi = 0 AND SUBSTR(impdata_fil.subclass,1,1) = "E" THEN sic_bran.uwm301.maksi = stat.maktab_fil.maksi .A67-0029*/ /*A68-0044*/
           IF sic_bran.uwm301.maksi = 0 AND TRIM(impdata_fil.covcod) <> "3" THEN sic_bran.uwm301.maksi = stat.maktab_fil.maksi. /*A68-0044*/
       END.
  END.
  ELSE RUN proc_maktab.
  /*IF TRIM(impdata_fil.redbook) = " " THEN ASSIGN impdata_fil.comment = impdata_fil.comment + "| Redbook เป็นค่าว่าง " .*/
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest3 C-Win 
PROCEDURE proc_chktest3 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.
ASSIGN fi_process = "Create data " + impdata_fil.policyno  + " on uwm130 uwm120 ..."  .
DISP fi_process WITH FRAM fr_main.
ASSIGN 
    nv_tariff = sic_bran.uwm301.tariff
    nv_class  = IF impdata_fil.poltyp = "v72" THEN impdata_fil.subclass ELSE impdata_fil.prempa +  impdata_fil.subclass
    nv_comdat = sic_bran.uwm100.comdat
    nv_engine = DECI(impdata_fil.engcc)
    nv_covcod = impdata_fil.covcod
    nv_vehuse = impdata_fil.vehuse
    nv_COMPER = deci(impdata_fil.comper) 
    nv_comacc = deci(impdata_fil.comacc) 
    nv_seats  = INTE(impdata_fil.seat)
    nv_tons   = DECI(impdata_fil.weight)
    /*nv_dss_per = 0   */  
    nv_dsspcvar1 = ""           nv_cl_cod  = "" 
    nv_dsspcvar2 =  ""          nv_cl_per  = 0 
    nv_dsspcvar  = ""           nv_lodclm  = 0 
    nv_42cod     = ""           nv_lodclm1 = 0 
    nv_43cod     = ""           nv_clmvar1 = "" 
    nv_41cod1    = ""           nv_clmvar2 = "" 
    nv_41cod2    = ""           nv_clmvar  = "" 
    nv_basecod   = ""           nv_stf_cod = "" 
    nv_usecod    = ""           nv_stf_per = 0 
    nv_engcod    = ""           nv_stf_amt = 0 
    nv_drivcod   = ""           nv_stfvar1 = "" 
    nv_yrcod     = ""           nv_stfvar2 = "" 
    nv_sicod     = ""           nv_stfvar  = "" 
    nv_grpcod    = ""           nv_41cod3  = "" 
    nv_bipcod    = ""           nv_41cod4  = "" 
    nv_biacod    = ""                     
    nv_pdacod    = "" 
    nv_ncbyrs    =   0    
    nv_ncbper    =   0    
    nv_ncb       =   0
    nv_totsi     =   0.

IF (impdata_fil.covcod = "2.1" ) OR (impdata_fil.covcod = "3.1" ) OR (impdata_fil.covcod = "2.2" ) OR (impdata_fil.covcod = "3.2" ) THEN RUN proc_base2plus.  /*A62-0215*/
ELSE RUN proc_base2.
 
/*RUN proc_calpremt.*/ /*A67-0029*/
RUN proc_calpremt_EV. /*A67-0029*/
RUN proc_adduwd132prem.

FIND LAST sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_RECID1 NO-ERROR.
IF AVAIL  sic_bran.uwm100 THEN DO:
 ASSIGN 
     sic_bran.uwm100.prem_t =  sic_bran.uwm100.prem_t + nv_pdprm
     sic_bran.uwm100.sigr_p =  sic_bran.uwm100.sigr_p + inte(impdata_fil.si)
     sic_bran.uwm100.gap_p  =  sic_bran.uwm100.gap_p  + nv_gapprm.
 IF impdata_fil.pass <> "Y" THEN 
     ASSIGN
     sic_bran.uwm100.impflg = NO
     sic_bran.uwm100.imperr = impdata_fil.comment.    
END.

/*FIND LAST sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_RECID2  NO-ERROR.
IF AVAIL  sic_bran.uwm120 THEN 
  ASSIGN
  sic_bran.uwm120.gap_r  = nv_gapprm
  sic_bran.uwm120.prem_r = nv_pdprm
  sic_bran.uwm120.sigr   = inte(impdata_fil.si).*/


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest4 C-Win 
PROCEDURE proc_chktest4 :
/*------------------------------------------------------------------------------
   Purpose:     
   Parameters:  <none>
   Notes:       
 ------------------------------------------------------------------------------*/
 DEF VAR   n_sigr_r        like sic_bran.uwm130.uom6_v.
 DEF VAR   n_gap_r         Like sic_bran.uwd132.gap_c . 
 DEF VAR   n_prem_r        Like sic_bran.uwd132.prem_c.
 DEF VAR   nt_compprm      like sic_bran.uwd132.prem_c.  
 DEF VAR   n_gap_t         Like sic_bran.uwm100.gap_p.
 DEF VAR   n_prem_t        Like sic_bran.uwm100.prem_t.
 DEF VAR   n_sigr_t        Like sic_bran.uwm100.sigr_p.
 DEF VAR   nv_policy       like sic_bran.uwm100.policy.
 DEF VAR   nv_rencnt       like sic_bran.uwm100.rencnt.
 DEF VAR   nv_endcnt       like sic_bran.uwm100.endcnt.
 DEF VAR   nv_com1_per     like sicsyac.xmm031.comm1.
 DEF VAR   nv_stamp_per    like sicsyac.xmm020.rvstam.
 DEF VAR   nv_com3p        AS DECI INIT 0.00 . /* A64-0355*/
 DEF VAR   nv_com2p        AS DECI INIT 0.00 .
 DEF VAR   nv_com1p        AS DECI INIT 0.00 .
 DEF VAR   nv_fi_netprm    AS DECI INIT 0.00.
 DEF VAR   NV_fi_dup_trip  AS CHAR FORMAT  "X" INIT "".
 DEF VAR   nv_fi_tax_per   AS DECI INIT 0.00.
 DEF VAR   nv_fi_stamp_per AS DECI INIT 0.00.
 DEF VAR   nv_fi_rstp_t    AS INTE INIT 0.
 DEF VAR   nv_fi_rtax_t    AS DECI INIT 0.00 .
 DEF VAR   nv_fi_com1_t    AS DECI INIT 0.00.
 DEF VAR   nv_fi_com2_t    AS DECI INIT 0.00.
 DEF VAR   nv_fi_com3_t    AS DECI INIT 0.00. /* A64-0355*/
 DEF VAR   nv_commpol      AS DECI INIT 0.00 . /* A64-0355*/
 DEF VAR   nv_commpol_t    AS DECI INIT 0.00 . /* A64-0355*/
 DEF VAR   nv_comm13_t     AS DECI INIT 0.00 . /* A64-0355*/
 DEF BUFFER bfimpinst_fil FOR impinst_fil.

 ASSIGN fi_process = "Create data Stamp, Vat , Commisson to uwm120 ..." + impdata_fil.policyno .
 DISP fi_process WITH FRAM fr_main.

 FIND sic_bran.uwm100  Where Recid(sic_bran.uwm100)  = s_recid1 no-error no-wait.
   IF not avail sic_bran.uwm100  THEN DO:
       /*Message "not found (uwm100./wuwrep02.p)" View-as alert-box.*/
       Return.
   End.
   ELSE DO:
       Assign 
             nv_policy  =  CAPS(sic_bran.uwm100.policy)
             nv_rencnt  =  sic_bran.uwm100.rencnt
             nv_endcnt  =  sic_bran.uwm100.endcnt.
             FOR EACH sic_bran.uwm120 USE-INDEX uwm12001 WHERE
                      sic_bran.uwm120.policy  = sic_bran.uwm100.policy  AND
                      sic_bran.uwm120.rencnt  = sic_bran.uwm100.rencnt  AND
                      sic_bran.uwm120.endcnt  = sic_bran.uwm100.endcnt  AND
                      sic_bran.uwm120.riskno  = impdata_fil.riskno      AND 
                      sic_bran.uwm120.bchyr   = nv_batchyr              AND 
                      sic_bran.uwm120.bchno   = nv_batchno              AND 
                      sic_bran.uwm120.bchcnt  = nv_batcnt         .
                     FOR EACH sic_bran.uwm130   USE-INDEX uwm13001 WHERE
                       sic_bran.uwm130.policy  = sic_bran.uwm120.policy  AND
                       sic_bran.uwm130.rencnt  = sic_bran.uwm120.rencnt  AND
                       sic_bran.uwm130.endcnt  = sic_bran.uwm120.endcnt  AND
                       sic_bran.uwm130.riskno  = sic_bran.uwm120.riskno  AND
                       sic_bran.uwm130.bchyr   = nv_batchyr              AND 
                       sic_bran.uwm130.bchno   = nv_batchno              AND 
                       sic_bran.uwm130.bchcnt  = nv_batcnt               NO-LOCK.
                         n_sigr_r                = n_sigr_r + uwm130.uom6_v.
                         FOR EACH sic_bran.uwd132  USE-INDEX uwd13201 WHERE 
                              sic_bran.uwd132.policy  = sic_bran.uwm130.policy  AND
                              sic_bran.uwd132.rencnt  = sic_bran.uwm130.rencnt  AND
                              sic_bran.uwd132.endcnt  = sic_bran.uwm130.endcnt  AND
                              sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno  AND
                              sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno  AND
                              sic_bran.uwd132.bchyr   = nv_batchyr              AND 
                              sic_bran.uwd132.bchno   = nv_batchno              AND 
                              sic_bran.uwd132.bchcnt  = nv_batcnt               NO-LOCK.
                               IF  sic_bran.uwd132.bencod  = "COMP"   THEN DO:
                                    nt_compprm     = nt_compprm + sic_bran.uwd132.prem_c.
                               END.
                                n_gap_r  = sic_bran.uwd132.gap_c  + n_gap_r.
                                n_prem_r = sic_bran.uwd132.prem_c + n_prem_r.
                         END.  /* uwd132 */
                     END.  /*uwm130 */
                     ASSIGN
                     n_gap_t      = n_gap_t   + n_gap_r
                     n_prem_t     = n_prem_t  + n_prem_r
                     n_sigr_t     = n_sigr_t  + n_sigr_r
                     n_gap_r      = 0 
                     n_prem_r     = 0  
                     n_sigr_r     = 0.
            END.    /* end uwm120 */ 
   End.  /*  avail  100   */ 
 /*-------------------- calprem ---------------------*/
  Find FIRST sic_bran.uwm120  Use-index uwm12001  WHERE          
             sic_bran.uwm120.policy  = sic_bran.uwm100.policy   And
             sic_bran.uwm120.rencnt  = sic_bran.uwm100.rencnt   And
             sic_bran.uwm120.endcnt  = sic_bran.uwm100.endcnt   AND 
             sic_bran.uwm120.riskno  = impdata_fil.riskno       AND 
             sic_bran.uwm120.bchyr   = nv_batchyr               AND 
             sic_bran.uwm120.bchno   = nv_batchno               AND 
             sic_bran.uwm120.bchcnt  = nv_batcnt                No-error.
  IF AVAIL uwm120 THEN DO:
     Assign
             sic_bran.uwm120.gap_r    = n_gap_t   /*n_gap_r */
             sic_bran.uwm120.prem_r   = n_prem_t  /*n_prem_r */
             sic_bran.uwm120.sigr     = n_sigr_T.  /* A490166 note modi from n_sigr_r to n_sigr_t 11/10/2006 */

    FIND LAST  sicsyac.xmm018 USE-INDEX xmm01801 WHERE
               sicsyac.xmm018.agent              = sic_bran.uwm100.acno1          AND               /*แยกงานตาม Code Producer*/  
               substr(sicsyac.xmm018.poltyp,1,5) = "CR" + sic_bran.uwm100.poltyp  AND               /*Shukiat T. modi on 25/04/2007*/
               SUBSTR(xmm018.poltyp,7,1)         = sic_bran.uwm100.branch         AND               /*Shukiat T. add on 05/06/2007 A50-0144*/
               sicsyac.xmm018.datest            <= sic_bran.uwm100.comdat         NO-LOCK NO-ERROR. /*Shukiat T. add on 25/04/2007*/
      IF AVAIL   sicsyac.xmm018 THEN DO:
                Assign     nv_com1p = sicsyac.xmm018.commsp  
                           nv_com2p = 0
                           nv_commpol = sicsyac.xmm018.commsp  .
      END.
      ELSE DO:
              Find sicsyac.xmm031  Use-index xmm03101  Where  
                   sicsyac.xmm031.poltyp  = sic_bran.uwm100.poltyp
              No-lock no-error no-wait.
              IF not  avail sicsyac.xmm031 Then 
                Assign     nv_com1p = 0
                           nv_com2p = 0
                           nv_commpol = 0.
              Else  
                Assign     nv_com1p = sicsyac.xmm031.comm1
                           nv_com2p = 0
                           nv_commpol = sicsyac.xmm031.comm1 .
      END. /* Not Avail Xmm018 */
    
      if sic_bran.uwm100.poltyp = "V70" THEN DO: 
           IF impdata_fil.agco70 <> "" THEN DO:
               sic_bran.uwm120.com1ae = YES.
               sic_bran.uwm120.com3ae = YES. 
             IF impdata_fil.comper70  <> (-1) AND impdata_fil.comco_per70  = (-1) THEN DO:  /* ระบุ comm policy แต่ไม่ระบุ comm co-broker */
                 ASSIGN  nv_com3p  = nv_com1p - impdata_fil.comper70
                         nv_com1p  = impdata_fil.comper70 .
             END.
             ELSE IF impdata_fil.comper70  = (-1) AND impdata_fil.comco_per70  <> (-1) THEN DO: /* ไม่ระบุ comm policy แต่ระบุ comm co-broker */
                 ASSIGN  nv_com1p  = nv_com1p - impdata_fil.comco_per70
                         nv_com3p  = impdata_fil.comco_per70 .
             END.
             ELSE IF impdata_fil.comper70  <> (-1) AND impdata_fil.comco_per70  <> (-1) THEN DO: /* ระบุ comm policy และ ระบุ comm co-broker */
                 ASSIGN  nv_com1p  = impdata_fil.comper70
                         nv_com3p  = impdata_fil.comco_per70 .
             END.
             
             IF impdata_fil.comprem70 <> (-1)  THEN  /* ใส่เบี้ย comm policy มาในไฟล์ */
                 ASSIGN nv_fi_com1_t = (impdata_fil.comprem70) /* ระบุติดลบมาในไฟล์ */
                        sic_bran.uwm120.com1ae = NO.
      
             IF impdata_fil.comco_prem70 <> (-1)  THEN /* ใส่เบี้ย comm co-broker มาในไฟล์ */
                 ASSIGN nv_fi_com3_t = (impdata_fil.comco_prem70) /* ระบุติดลบมาในไฟล์ */
                        sic_bran.uwm120.com3ae = NO.
           END.
           /* end : A64-0355 */
           ELSE DO:
             sic_bran.uwm120.com1ae = YES. 
             IF impdata_fil.comper70  <> (-1)  THEN ASSIGN nv_com1p  = impdata_fil.comper70 .
             IF impdata_fil.comprem70 <> (-1)  THEN 
                 ASSIGN nv_fi_com1_t = (impdata_fil.comprem70) /* ระบุติดลบมาในไฟล์ */
                        sic_bran.uwm120.com1ae = NO.
           END.
      END. /* poltyp = 70 */
      /*--------- motor commission -----------------*/
      IF sic_bran.uwm120.com1ae   = Yes Then do:         /* MOTOR COMMISION */
         If sic_bran.uwm120.com1p <> 0  Then nv_com1p  = sic_bran.uwm120.com1p.
         nv_fi_com1_t   =  - ROUND((sic_bran.uwm120.prem_r - nt_compprm) * nv_com1p / 100,2) .            
             /*fi_com1ae        =  YES.*/
      End.
       /* add  co-broker */  
      IF impdata_fil.agco70 <> ""  THEN DO:
        IF sic_bran.uwm120.com3ae   = Yes  Then do:                   /* Comp.COMMISION */
          If sic_bran.uwm120.com3p <> 0  Then nv_com3p  = sic_bran.uwm120.com3p.
          nv_fi_com3_t   = - ROUND((sic_bran.uwm120.prem_r - nt_compprm) * nv_com3p / 100 ,2).    
        End.
      END.
    
      IF nv_fi_com1_t > 0 THEN nv_fi_com1_t = nv_fi_com1_t * (-1) .
      IF nv_fi_com3_t > 0 THEN nv_fi_com3_t = nv_fi_com3_t * (-1) .

      IF impdata_fil.poltyp = "V70" THEN DO: 
      nv_commpol   = (sic_bran.uwm120.com1p + sic_bran.uwm120.com3p) .
      nv_commpol_t = - ROUND((sic_bran.uwm120.prem_r - nt_compprm) * nv_commpol / 100 ,2).  /* commission total */
      nv_comm13_t  =  ROUND(sic_bran.uwm120.com1_r + sic_bran.uwm120.com3_r ,2) .
     
      IF nv_commpol_t <> nv_comm13_t THEN DO:
          ASSIGN impdata_fil.comment = IF  impdata_fil.agco70 <> ""  THEN impdata_fil.comment + "|" + "ยอดรวม comm. + comm.co-broker " + string(nv_comm13_t) + 
                                   " ไม่เท่ากับ comm.รวม กธ " + STRING(nv_commpol_t) 
                                  ELSE  impdata_fil.comment + "|ยอดรวม comm.ในไฟล์ " + string(nv_comm13_t) + " ไม่เท่ากับ comm.รวมจากระบบ " + STRING(nv_commpol_t).
      END.
    END.
    Find     sic_bran.uwm120 Where  Recid(sic_bran.uwm120)   =  s_recid2 .
    IF avail sic_bran.uwm120 Then do:
         Assign
             /*sic_bran.uwm120.gap_r    = n_gap_t   /*n_gap_r */
             sic_bran.uwm120.prem_r   = n_prem_t  /*n_prem_r */
             sic_bran.uwm120.sigr     = n_sigr_T  /* A490166 note modi from n_sigr_r to n_sigr_t 11/10/2006 */
             sic_bran.uwm120.rtax     = nv_fi_rtax_t
             sic_bran.uwm120.taxae    = YES
             sic_bran.uwm120.stmpae   = YES
             sic_bran.uwm120.rstp_r   = nv_fi_rstp_t */  
             /*sic_bran.uwm120.taxae    = NO  A65-0079*/
             /*sic_bran.uwm120.stmpae   = NO  A65-0079*/
             sic_bran.uwm120.com1p    = nv_com1p
             sic_bran.uwm120.com1_r   = nv_fi_com1_t
             sic_bran.uwm120.com2ae   = YES
             sic_bran.uwm120.com2p    = nv_com2p
             sic_bran.uwm120.com2_r   = nv_fi_com2_t
             sic_bran.uwm120.com3p    = nv_com3p         /*A64-0355*/
             sic_bran.uwm120.com3_r   = nv_fi_com3_t .   /*A64-0355*/
    End.
    
  END. /* if avail uwm120*/
  ELSE ASSIGN impdata_fil.comment = impdata_fil.comment + "Not fond Policy :" + impdata_fil.policyno + 
                                    " Risk/Item no." + string(impdata_fil.riskno,"999") + "/" + string(impdata_fil.itemno,"999") + " (UWM120)"
              impdata_fil.pass  = "N" .


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest4-bp C-Win 
PROCEDURE proc_chktest4-bp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR   n_sigr_r     like sic_bran.uwm130.uom6_v.
DEF VAR   n_gap_r      Like sic_bran.uwd132.gap_c . 
DEF VAR   n_prem_r     Like sic_bran.uwd132.prem_c.
DEF VAR   nt_compprm   like sic_bran.uwd132.prem_c.  
DEF VAR   n_gap_t      Like sic_bran.uwm100.gap_p.
DEF VAR   n_prem_t     Like sic_bran.uwm100.prem_t.
DEF VAR   n_sigr_t     Like sic_bran.uwm100.sigr_p.
DEF VAR   nv_policy    like sic_bran.uwm100.policy.
DEF VAR   nv_rencnt    like sic_bran.uwm100.rencnt.
DEF VAR   nv_endcnt    like sic_bran.uwm100.endcnt.
DEF VAR   nv_com1_per  like sicsyac.xmm031.comm1.
DEF VAR   nv_stamp_per like sicsyac.xmm020.rvstam.
DEF VAR nv_com3p        AS DECI INIT 0.00 . /* A64-0355*/
DEF VAR nv_com2p        AS DECI INIT 0.00 .
DEF VAR nv_com1p        AS DECI INIT 0.00 .
DEF VAR nv_fi_netprm    AS DECI INIT 0.00.
DEF VAR NV_fi_dup_trip  AS CHAR FORMAT  "X" INIT "".
DEF VAR nv_fi_tax_per   AS DECI INIT 0.00.
DEF VAR nv_fi_stamp_per AS DECI INIT 0.00.
DEF VAR nv_fi_rstp_t    AS INTE INIT 0.
DEF VAR nv_fi_rtax_t    AS DECI INIT 0.00 .
DEF VAR nv_fi_com1_t    AS DECI INIT 0.00.
DEF VAR nv_fi_com2_t    AS DECI INIT 0.00.
DEF VAR nv_fi_com3_t    AS DECI INIT 0.00. /* A64-0355*/
DEF BUFFER bfimpinst_fil FOR impinst_fil.

ASSIGN fi_process = "Create data Stamp, Vat , Commisson to uwm120 ..." + impdata_fil.policyno .
DISP fi_process WITH FRAM fr_main.

FIND sic_bran.uwm100   Where Recid(sic_bran.uwm100)  = s_recid1 no-error no-wait.
  If  not avail sic_bran.uwm100  Then do:
      /*Message "not found (uwm100./wuwrep02.p)" View-as alert-box.*/
      Return.
  End.
  Else  do:
      Assign 
            nv_policy  =  CAPS(sic_bran.uwm100.policy)
            nv_rencnt  =  sic_bran.uwm100.rencnt
            nv_endcnt  =  sic_bran.uwm100.endcnt.
            FOR EACH sic_bran.uwm120 USE-INDEX uwm12001 WHERE
                     sic_bran.uwm120.policy  = sic_bran.uwm100.policy  AND
                     sic_bran.uwm120.rencnt  = sic_bran.uwm100.rencnt  AND
                     sic_bran.uwm120.endcnt  = sic_bran.uwm100.endcnt  AND
                     sic_bran.uwm120.riskno  = impdata_fil.riskno      AND 
                     sic_bran.uwm120.bchyr   = nv_batchyr              AND 
                     sic_bran.uwm120.bchno   = nv_batchno              AND 
                     sic_bran.uwm120.bchcnt  = nv_batcnt         .
                    FOR EACH sic_bran.uwm130   USE-INDEX uwm13001 WHERE
                      sic_bran.uwm130.policy  = sic_bran.uwm120.policy  AND
                      sic_bran.uwm130.rencnt  = sic_bran.uwm120.rencnt  AND
                      sic_bran.uwm130.endcnt  = sic_bran.uwm120.endcnt  AND
                      sic_bran.uwm130.riskno  = sic_bran.uwm120.riskno  AND
                      sic_bran.uwm130.bchyr   = nv_batchyr              AND 
                      sic_bran.uwm130.bchno   = nv_batchno              AND 
                      sic_bran.uwm130.bchcnt  = nv_batcnt               NO-LOCK.
                        n_sigr_r                = n_sigr_r + uwm130.uom6_v.
                        FOR EACH sic_bran.uwd132  USE-INDEX uwd13201 WHERE 
                             sic_bran.uwd132.policy  = sic_bran.uwm130.policy  AND
                             sic_bran.uwd132.rencnt  = sic_bran.uwm130.rencnt  AND
                             sic_bran.uwd132.endcnt  = sic_bran.uwm130.endcnt  AND
                             sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno  AND
                             sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno  AND
                             sic_bran.uwd132.bchyr   = nv_batchyr              AND 
                             sic_bran.uwd132.bchno   = nv_batchno              AND 
                             sic_bran.uwd132.bchcnt  = nv_batcnt               NO-LOCK.
                              IF  sic_bran.uwd132.bencod  = "COMP"   THEN DO:
                                   nt_compprm     = nt_compprm + sic_bran.uwd132.prem_c.
                              END.
                               n_gap_r  = sic_bran.uwd132.gap_c  + n_gap_r.
                               n_prem_r = sic_bran.uwd132.prem_c + n_prem_r.
                        END.  /* uwd132 */
                    END.  /*uwm130 */
                    ASSIGN
                    n_gap_t      = n_gap_t   + n_gap_r
                    n_prem_t     = n_prem_t  + n_prem_r
                    n_sigr_t     = n_sigr_t  + n_sigr_r
                    n_gap_r      = 0 
                    n_prem_r     = 0  
                    n_sigr_r     = 0.
           END.    /* end uwm120 */ 
  End.  /*  avail  100   */ 
  /*-------------------- calprem ---------------------*/
  Find     sic_bran.uwm120 Where  Recid(sic_bran.uwm120)   =  s_recid2   .
  IF avail sic_bran.uwm120 Then do:
    Assign
        sic_bran.uwm120.gap_r    = n_gap_t   /*n_gap_r */
        sic_bran.uwm120.prem_r   = n_prem_t  /*n_prem_r */
        sic_bran.uwm120.sigr     = n_sigr_T.  
   
  End.
 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest41 C-Win 
PROCEDURE proc_chktest41 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR   n_gap_r      Like sic_bran.uwd132.gap_c . 
DEF VAR   n_prem_r     Like sic_bran.uwd132.prem_c.
DEF VAR   nt_compprm   like sic_bran.uwd132.prem_c.  
DEF VAR   n_gap_t      Like sic_bran.uwm100.gap_p.
DEF VAR   n_prem_t     Like sic_bran.uwm100.prem_t.
DEF VAR   n_sigr_t     Like sic_bran.uwm100.sigr_p.
DEF VAR   n_sigr_r     Like sic_bran.uwm130.uom6_v. /* a64-0369*/
DEF VAR   nv_policy    like sic_bran.uwm100.policy.
DEF VAR   nv_rencnt    like sic_bran.uwm100.rencnt.
DEF VAR   nv_endcnt    like sic_bran.uwm100.endcnt.
DEF VAR   nv_com1_per  like sicsyac.xmm031.comm1.
DEF VAR   nv_stamp_per like sicsyac.xmm020.rvstam.
DEF VAR nv_com3p        AS DECI INIT 0.00 . /* A64-0355*/
DEF VAR nv_com2p        AS DECI INIT 0.00 .
DEF VAR nv_com1p        AS DECI INIT 0.00 .
DEF VAR nv_fi_netprm    AS DECI INIT 0.00.
DEF VAR NV_fi_dup_trip  AS CHAR FORMAT  "X" INIT "".
DEF VAR nv_fi_tax_per   AS DECI INIT 0.00.
DEF VAR nv_fi_stamp_per AS DECI INIT 0.00.
DEF VAR nv_fi_rstp_t    AS INTE INIT 0.
DEF VAR nv_fi_rtax_t    AS DECI INIT 0.00 .
DEF VAR nv_fi_com1_t    AS DECI INIT 0.00.
DEF VAR nv_fi_com2_t    AS DECI INIT 0.00.
DEF VAR nv_fi_com3_t    AS DECI INIT 0.00.  /* A64-0355*/
DEF VAR nv_commpol      AS DECI INIT 0.00 . /* A64-0355*/
DEF VAR nv_commpol_t    AS DECI INIT 0.00 . /* A64-0355*/
DEF VAR nv_comm13_t     AS DECI INIT 0.00 . /* A64-0355*/
DEF BUFFER bfimpinst_fil FOR impinst_fil.


ASSIGN fi_process = "Create data Stamp, Vat , Commisson to uwm120 ..." + impdata_fil.policyno .
DISP fi_process WITH FRAM fr_main.

Find  sic_bran.uwm100 Where  Recid(sic_bran.uwm100)  =  s_recid1 no-error no-wait.
  If  not avail sic_bran.uwm100  Then do:
      Return.
  End.
  Else  do:
      Assign 
            nv_policy  =  CAPS(sic_bran.uwm100.policy)
            nv_rencnt  =  sic_bran.uwm100.rencnt
            nv_endcnt  =  sic_bran.uwm100.endcnt.
            FOR EACH sic_bran.uwm120 USE-INDEX uwm12001 WHERE
                     sic_bran.uwm120.policy  = sic_bran.uwm100.policy  AND
                     sic_bran.uwm120.rencnt  = sic_bran.uwm100.rencnt  AND
                     sic_bran.uwm120.endcnt  = sic_bran.uwm100.endcnt  AND
                     sic_bran.uwm120.bchyr   = nv_batchyr              AND 
                     sic_bran.uwm120.bchno   = nv_batchno              AND 
                     sic_bran.uwm120.bchcnt  = nv_batcnt         .
                    FOR EACH sic_bran.uwm130   USE-INDEX uwm13001 WHERE
                      sic_bran.uwm130.policy  = sic_bran.uwm120.policy  AND
                      sic_bran.uwm130.rencnt  = sic_bran.uwm120.rencnt  AND
                      sic_bran.uwm130.endcnt  = sic_bran.uwm120.endcnt  AND
                      sic_bran.uwm130.riskno  = sic_bran.uwm120.riskno  AND
                      sic_bran.uwm130.bchyr   = nv_batchyr              AND 
                      sic_bran.uwm130.bchno   = nv_batchno              AND 
                      sic_bran.uwm130.bchcnt  = nv_batcnt               NO-LOCK.
                      n_sigr_r                = n_sigr_r + uwm130.uom6_v.
                        FOR EACH sic_bran.uwd132  USE-INDEX uwd13201 WHERE 
                             sic_bran.uwd132.policy  = sic_bran.uwm130.policy  AND
                             sic_bran.uwd132.rencnt  = sic_bran.uwm130.rencnt  AND
                             sic_bran.uwd132.endcnt  = sic_bran.uwm130.endcnt  AND
                             sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno  AND
                             sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno  AND
                             sic_bran.uwd132.bchyr   = nv_batchyr              AND 
                             sic_bran.uwd132.bchno   = nv_batchno              AND 
                             sic_bran.uwd132.bchcnt  = nv_batcnt               NO-LOCK.
                              IF  sic_bran.uwd132.bencod  = "COMP"   THEN DO:
                                   nt_compprm     = nt_compprm + sic_bran.uwd132.prem_c.
                              END.
                               n_gap_r  = sic_bran.uwd132.gap_c  + n_gap_r.
                               n_prem_r = sic_bran.uwd132.prem_c + n_prem_r.
                        END.  /* uwd132 */
                    END.  /*uwm130 */
                    ASSIGN
                    n_gap_t      = n_gap_t   + n_gap_r
                    n_prem_t     = n_prem_t  + n_prem_r
                    n_sigr_t     = n_sigr_t  + n_sigr_r
                    n_gap_r      = 0 
                    n_prem_r     = 0  
                    n_sigr_r     = 0.
           END.    /* end uwm120 */     
  End.  /*  avail  100   */ 
  /*-------------------- calprem ---------------------*/
  Find FIRST sic_bran.uwm120  Use-index uwm12001  WHERE          
             sic_bran.uwm120.policy  = sic_bran.uwm100.policy   And
             sic_bran.uwm120.rencnt  = sic_bran.uwm100.rencnt   And
             sic_bran.uwm120.endcnt  = sic_bran.uwm100.endcnt   AND 
             /*sic_bran.uwm120.riskno  = impdata_fil.riskno       AND */
             sic_bran.uwm120.bchyr   = nv_batchyr               AND 
             sic_bran.uwm120.bchno   = nv_batchno               AND 
             sic_bran.uwm120.bchcnt  = nv_batcnt                No-error.
  FIND LAST  sicsyac.xmm018 USE-INDEX xmm01801 WHERE
             sicsyac.xmm018.agent              = sic_bran.uwm100.acno1          AND               /*แยกงานตาม Code Producer*/  
             substr(sicsyac.xmm018.poltyp,1,5) = "CR" + sic_bran.uwm100.poltyp  AND               /*Shukiat T. modi on 25/04/2007*/
             SUBSTR(xmm018.poltyp,7,1)         = sic_bran.uwm100.branch         AND               /*Shukiat T. add on 05/06/2007 A50-0144*/
             sicsyac.xmm018.datest            <= sic_bran.uwm100.comdat         NO-LOCK NO-ERROR. /*Shukiat T. add on 25/04/2007*/
    IF AVAIL   sicsyac.xmm018 THEN DO:
              Assign     nv_com1p = sicsyac.xmm018.commsp  
                         nv_com2p = 0
                         nv_commpol = sicsyac.xmm018.commsp  .
    END.
    ELSE DO:
            Find sicsyac.xmm031  Use-index xmm03101  Where  
                 sicsyac.xmm031.poltyp  = sic_bran.uwm100.poltyp
            No-lock no-error no-wait.
            IF not  avail sicsyac.xmm031 Then 
              Assign     nv_com1p = 0
                         nv_com2p = 0
                         nv_commpol = 0.
            Else  
              Assign     nv_com1p = sicsyac.xmm031.comm1
                         nv_com2p = 0
                         nv_commpol = sicsyac.xmm031.comm1 .
    END. /* Not Avail Xmm018 */
  /*--------- tax -----------*/
  Find sicsyac.xmm020 Use-index xmm02001        Where
       sicsyac.xmm020.branch = sic_bran.uwm100.branch   And
       sicsyac.xmm020.dir_ri = sic_bran.uwm100.dir_ri   No-lock no-error.
  IF avail sicsyac.xmm020 Then do:
           nv_fi_stamp_per      = sicsyac.xmm020.rvstam.
       If    sic_bran.uwm100.gstrat  <>  0  Then  nv_fi_tax_per  =  sic_bran.uwm100.gstrat.
       Else  nv_fi_tax_per  =  sicsyac.xmm020.rvtax.
  End.
  /*----------- stamp ------------*/
  IF sic_bran.uwm120.stmpae  = Yes Then do:                        /* STAMP */
     nv_fi_rstp_t  = Truncate(n_prem_t * nv_fi_stamp_per / 100,0) +
                     (IF     (n_prem_t * nv_fi_stamp_per / 100)   -
                     Truncate(n_prem_t * nv_fi_stamp_per / 100,0) > 0
                     Then 1 Else 0).
  End.
  sic_bran.uwm100.rstp_t =  nv_fi_rstp_t.
     
  IF  sic_bran.uwm120.taxae   = Yes   Then do:                       /* TAX */
      nv_fi_rtax_t  = (n_prem_t + nv_fi_rstp_t + sic_bran.uwm100.pstp)
                       * nv_fi_tax_per  / 100.
       /* fi_taxae       = Yes.*/
  End.
  sic_bran.uwm100.rtax_t = nv_fi_rtax_t.

  if sic_bran.uwm100.poltyp = "V70" THEN DO: 
      IF impdata_fil.agco70 <> "" THEN DO:
          sic_bran.uwm120.com1ae = YES.
          sic_bran.uwm120.com3ae = YES. 
        IF impdata_fil.comper70  <> (-1) AND impdata_fil.comco_per70  = (-1) THEN DO:  /* ระบุ comm policy แต่ไม่ระบุ comm co-broker */
            ASSIGN  nv_com3p  = nv_com1p - impdata_fil.comper70
                    nv_com1p  = impdata_fil.comper70 .
        END.
        ELSE IF impdata_fil.comper70  = (-1) AND impdata_fil.comco_per70  <> (-1) THEN DO: /* ไม่ระบุ comm policy แต่ระบุ comm co-broker */
            ASSIGN  nv_com1p  = nv_com1p - impdata_fil.comco_per70
                    nv_com3p  = impdata_fil.comco_per70 .
        END.
        ELSE IF impdata_fil.comper70  <> (-1) AND impdata_fil.comco_per70  <> (-1) THEN DO: /* ระบุ comm policy และ ระบุ comm co-broker */
            ASSIGN  nv_com1p  = impdata_fil.comper70
                    nv_com3p  = impdata_fil.comco_per70 .
        END.
        
        IF impdata_fil.comprem70 <> (-1)  THEN  /* ใส่เบี้ย comm policy มาในไฟล์ */
            ASSIGN nv_fi_com1_t = (impdata_fil.comprem70) /* ระบุติดลบมาในไฟล์ */
                   sic_bran.uwm120.com1ae = NO.

        IF impdata_fil.comco_prem70 <> (-1)  THEN /* ใส่เบี้ย comm co-broker มาในไฟล์ */
            ASSIGN nv_fi_com3_t = (impdata_fil.comco_prem70) /* ระบุติดลบมาในไฟล์ */
                   sic_bran.uwm120.com3ae = NO.
      END.
      /* end : A64-0355 */
      ELSE DO:
        sic_bran.uwm120.com1ae = YES. 
        IF impdata_fil.comper70  <> (-1)  THEN ASSIGN nv_com1p  = impdata_fil.comper70 .
        IF impdata_fil.comprem70 <> (-1)  THEN 
            ASSIGN nv_fi_com1_t = (impdata_fil.comprem70) /* ระบุติดลบมาในไฟล์ */
                   sic_bran.uwm120.com1ae = NO.
      END.
  END.
 /*--------- motor commission -----------------*/
  IF sic_bran.uwm120.com1ae   = Yes Then do:         /* MOTOR COMMISION */
     If sic_bran.uwm120.com1p <> 0  Then nv_com1p  = sic_bran.uwm120.com1p.
     nv_fi_com1_t   =  - ROUND((sic_bran.uwm100.prem_t - nt_compprm) * nv_com1p / 100,2) .            
         /*fi_com1ae        =  YES.*/
  End.
   /* add  co-broker */  
  IF impdata_fil.agco70 <> ""  THEN DO:
    IF sic_bran.uwm120.com3ae   = Yes  Then do:                   /* Comp.COMMISION */
      If sic_bran.uwm120.com3p <> 0  Then nv_com3p  = sic_bran.uwm120.com3p.
      nv_fi_com3_t   = - ROUND((sic_bran.uwm100.prem_t - nt_compprm) * nv_com3p / 100 ,2).    
    End.
  END.

  IF nv_fi_com1_t > 0 THEN nv_fi_com1_t = nv_fi_com1_t * (-1) .
  IF nv_fi_com3_t > 0 THEN nv_fi_com3_t = nv_fi_com3_t * (-1) .
  
  /*----------- comp comission V72 ------------
  IF sic_bran.uwm120.com2ae   = Yes  Then do:                   /* Comp.COMMISION */
      If sic_bran.uwm120.com2p <> 0  Then nv_com2p  = sic_bran.uwm120.com2p.
      nv_fi_com2_t   =  - ROUND(nt_compprm  *  nv_com2p / 100 ,2).              
         /*nv_fi_com2ae        =  YES.*/
  End.*/
  
  IF sic_bran.uwm100.pstp <> 0 Then do:
     IF sic_bran.uwm100.no_sch  = 1 Then NV_fi_dup_trip = "D".
     Else If sic_bran.uwm100.no_sch  = 2 Then  NV_fi_dup_trip = "T".
  End.
  Else  NV_fi_dup_trip  =  "".

  nv_fi_netprm = sic_bran.uwm100.prem_t + sic_bran.uwm100.rtax_t
               + sic_bran.uwm100.rstp_t + sic_bran.uwm100.pstp.

  /* add  co-broker */
   nv_commpol   = (nv_com1p + nv_com3p) .
   nv_commpol_t = - ROUND((sic_bran.uwm100.prem_t - nt_compprm) * nv_commpol / 100 ,2).  /* commission total */
   nv_comm13_t  =  ROUND(nv_fi_com1_t + nv_fi_com3_t ,2) .

  IF impdata_fil.agco70 <> ""  THEN DO: /*21/12/2021*/
    IF nv_commpol_t <> nv_comm13_t AND sic_bran.uwm120.com3ae = YES THEN DO:
        nv_fi_com3_t = (nv_commpol_t) - (nv_fi_com1_t) .
    END.
  END. /*21/12/2021*/
  
  /*Find     sic_bran.uwm100 Where  Recid(sic_bran.uwm100)  =  s_recid1.*/
  FIND FIRST sic_bran.uwm100 USE-INDEX uwm10001  WHERE 
      sic_bran.uwm100.policy  = nv_policy  AND
      sic_bran.uwm100.rencnt  = nv_rencnt  AND
      sic_bran.uwm100.endcnt  = nv_endcnt  AND
      sic_bran.uwm100.bchyr   = nv_batchyr AND 
      sic_bran.uwm100.bchno   = nv_batchno AND 
      sic_bran.uwm100.bchcnt  = nv_batcnt  .  
  If avail sic_bran.uwm100 Then DO:
      Assign 
           sic_bran.uwm100.gap_p   = n_gap_t
           sic_bran.uwm100.prem_t  = n_prem_t
           sic_bran.uwm100.sigr_p  = n_sigr_t
           sic_bran.uwm100.instot  = uwm100.instot
           sic_bran.uwm100.com1_t  = nv_fi_com1_t
           sic_bran.uwm100.com2_t  = nv_fi_com2_t
           sic_bran.uwm100.com3_t  = nv_fi_com3_t  /*A64-0355*/
           sic_bran.uwm100.pstp    = 0               /*note modified on 25/10/2006*/
           sic_bran.uwm100.rstp_t  = nv_fi_rstp_t
           sic_bran.uwm100.rtax_t  = nv_fi_rtax_t          
           sic_bran.uwm100.gstrat  = nv_fi_tax_per.
  END.
  
 /*Find     sic_bran.uwm120 Where  Recid(sic_bran.uwm120)   =  s_recid2   .*/
  FIND FIRST sic_bran.uwm120 USE-INDEX uwm12001 WHERE
      sic_bran.uwm120.policy  = nv_policy   AND
      sic_bran.uwm120.rencnt  = nv_rencnt  AND
      sic_bran.uwm120.endcnt  = nv_endcnt  AND
      sic_bran.uwm120.bchyr   = nv_batchyr AND 
      sic_bran.uwm120.bchno   = nv_batchno AND 
      sic_bran.uwm120.bchcnt  = nv_batcnt  .  
  IF avail sic_bran.uwm120 Then do:
       Assign
           sic_bran.uwm120.rtax     = nv_fi_rtax_t
           sic_bran.uwm120.taxae    = YES  
           sic_bran.uwm120.stmpae   = YES 
           sic_bran.uwm120.rstp_r   = nv_fi_rstp_t .  
  End.
  IF impdata_fil.poltyp = "V70" THEN DO: 
    nv_commpol   = (sic_bran.uwm120.com1p + sic_bran.uwm120.com3p) .
    nv_commpol_t = - ROUND((sic_bran.uwm100.prem_t - nt_compprm) * nv_commpol / 100 ,2).  /* commission total */
    nv_comm13_t  =  ROUND(sic_bran.uwm100.com1_t + sic_bran.uwm100.com3_t ,2) .
    
    IF nv_commpol_t <> nv_comm13_t THEN DO:
        ASSIGN impdata_fil.comment = IF  impdata_fil.agco70 <> ""  THEN impdata_fil.comment + "|" + "ยอดรวม comm. + comm.co-broker " + string(nv_comm13_t) + 
                                 " ไม่เท่ากับ comm.รวม กธ " + STRING(nv_commpol_t) 
                                ELSE  impdata_fil.comment + "|ยอดรวม comm.ในไฟล์ " + string(nv_comm13_t) + " ไม่เท่ากับ comm.รวมจากระบบ " + STRING(nv_commpol_t).
    END.
  END.
  IF impdata_fil.instot > 1 THEN DO:
      ASSIGN 
          nv_com1p_ins        = nv_com1p 
          nv_fi_tax_per_ins   = nv_fi_tax_per  
          nv_fi_stamp_per_ins = nv_fi_stamp_per    . 

      /* add by : A64-0355 co-broker */
      IF impdata_fil.agco70 <> "" THEN ASSIGN nv_com3p_ins = nv_com3p .
      ELSE ASSIGN nv_com3p_ins = 0 .
      /* end : A64-0355 co-broker */
      /*RUN proc_instot  .  */
      RUN proc_insnam_inst .
      FIND FIRST bfimpinst_fil WHERE bfimpinst_fil.policyno = impdata_fil.policyno NO-LOCK NO-ERROR.
        IF AVAIL bfimpinst_fil THEN DO:
            IF bfimpinst_fil.instcomm02 <> 0 AND impinst_fil.instrstp2 <> 0 THEN RUN proc_instot1. /*มีเบี้ย installment ในไฟล์ */
            ELSE RUN proc_instot2. /* ไม่มีเบี้ย */
        END.
  END.
  RELEASE sic_bran.uwd132 .
  RELEASE sic_bran.uwm120.
   /* Add by : A65-0079 */
  FOR EACH sic_bran.uwm120 USE-INDEX uwm12001 WHERE 
      sic_bran.uwm120.policy  = nv_policy  AND
      sic_bran.uwm120.rencnt  = nv_rencnt  AND
      sic_bran.uwm120.endcnt  = nv_endcnt  AND
      sic_bran.uwm120.bchyr   = nv_batchyr AND 
      sic_bran.uwm120.bchno   = nv_batchno AND 
      sic_bran.uwm120.bchcnt  = nv_batcnt  .
      ASSIGN 
       sic_bran.uwm120.taxae    = NO  
       sic_bran.uwm120.stmpae   = NO . 
  END.
  RELEASE sic_bran.uwm120.
  /* end : A65-0079 */
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest41-bp C-Win 
PROCEDURE proc_chktest41-bp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR   n_gap_r      Like sic_bran.uwd132.gap_c . 
DEF VAR   n_prem_r     Like sic_bran.uwd132.prem_c.
DEF VAR   nt_compprm   like sic_bran.uwd132.prem_c.  
DEF VAR   n_gap_t      Like sic_bran.uwm100.gap_p.
DEF VAR   n_prem_t     Like sic_bran.uwm100.prem_t.
DEF VAR   n_sigr_t     Like sic_bran.uwm100.sigr_p.
DEF VAR   n_sigr_r     Like sic_bran.uwm130.uom6_v. /* a64-0369*/
DEF VAR   nv_policy    like sic_bran.uwm100.policy.
DEF VAR   nv_rencnt    like sic_bran.uwm100.rencnt.
DEF VAR   nv_endcnt    like sic_bran.uwm100.endcnt.
DEF VAR   nv_com1_per  like sicsyac.xmm031.comm1.
DEF VAR   nv_stamp_per like sicsyac.xmm020.rvstam.
DEF VAR nv_com3p        AS DECI INIT 0.00 . /* A64-0355*/
DEF VAR nv_com2p        AS DECI INIT 0.00 .
DEF VAR nv_com1p        AS DECI INIT 0.00 .
DEF VAR nv_fi_netprm    AS DECI INIT 0.00.
DEF VAR NV_fi_dup_trip  AS CHAR FORMAT  "X" INIT "".
DEF VAR nv_fi_tax_per   AS DECI INIT 0.00.
DEF VAR nv_fi_stamp_per AS DECI INIT 0.00.
DEF VAR nv_fi_rstp_t    AS INTE INIT 0.
DEF VAR nv_fi_rtax_t    AS DECI INIT 0.00 .
DEF VAR nv_fi_com1_t    AS DECI INIT 0.00.
DEF VAR nv_fi_com2_t    AS DECI INIT 0.00.
DEF VAR nv_fi_com3_t    AS DECI INIT 0.00.  /* A64-0355*/
DEF VAR nv_commpol      AS DECI INIT 0.00 . /* A64-0355*/
DEF VAR nv_commpol_t    AS DECI INIT 0.00 . /* A64-0355*/
DEF VAR nv_comm13_t     AS DECI INIT 0.00 . /* A64-0355*/
DEF BUFFER bfimpinst_fil FOR impinst_fil.


ASSIGN fi_process = "Create data Stamp, Vat , Commisson to uwm120 ..." + impdata_fil.policyno .
DISP fi_process WITH FRAM fr_main.

Find  sic_bran.uwm100 Where  Recid(sic_bran.uwm100)  =  s_recid1 no-error no-wait.
  If  not avail sic_bran.uwm100  Then do:
      Return.
  End.
  Else  do:
      Assign 
            nv_policy  =  CAPS(sic_bran.uwm100.policy)
            nv_rencnt  =  sic_bran.uwm100.rencnt
            nv_endcnt  =  sic_bran.uwm100.endcnt.
            FOR EACH sic_bran.uwm120 USE-INDEX uwm12001 WHERE
                     sic_bran.uwm120.policy  = sic_bran.uwm100.policy  AND
                     sic_bran.uwm120.rencnt  = sic_bran.uwm100.rencnt  AND
                     sic_bran.uwm120.endcnt  = sic_bran.uwm100.endcnt  AND
                     sic_bran.uwm120.bchyr   = nv_batchyr               AND 
                     sic_bran.uwm120.bchno   = nv_batchno               AND 
                     sic_bran.uwm120.bchcnt  = nv_batcnt         .
                    FOR EACH sic_bran.uwm130   USE-INDEX uwm13001 WHERE
                      sic_bran.uwm130.policy  = sic_bran.uwm120.policy  AND
                      sic_bran.uwm130.rencnt  = sic_bran.uwm120.rencnt  AND
                      sic_bran.uwm130.endcnt  = sic_bran.uwm120.endcnt  AND
                      sic_bran.uwm130.riskno  = sic_bran.uwm120.riskno  AND
                      sic_bran.uwm130.bchyr   = nv_batchyr              AND 
                      sic_bran.uwm130.bchno   = nv_batchno              AND 
                      sic_bran.uwm130.bchcnt  = nv_batcnt               NO-LOCK.
                      n_sigr_r                = n_sigr_r + uwm130.uom6_v.
                        FOR EACH sic_bran.uwd132  USE-INDEX uwd13201 WHERE 
                             sic_bran.uwd132.policy  = sic_bran.uwm130.policy  AND
                             sic_bran.uwd132.rencnt  = sic_bran.uwm130.rencnt  AND
                             sic_bran.uwd132.endcnt  = sic_bran.uwm130.endcnt  AND
                             sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno  AND
                             sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno  AND
                             sic_bran.uwd132.bchyr   = nv_batchyr              AND 
                             sic_bran.uwd132.bchno   = nv_batchno              AND 
                             sic_bran.uwd132.bchcnt  = nv_batcnt               NO-LOCK.
                              IF  sic_bran.uwd132.bencod  = "COMP"   THEN DO:
                                   nt_compprm     = nt_compprm + sic_bran.uwd132.prem_c.
                              END.
                               n_gap_r  = sic_bran.uwd132.gap_c  + n_gap_r.
                               n_prem_r = sic_bran.uwd132.prem_c + n_prem_r.
                        END.  /* uwd132 */
                    END.  /*uwm130 */
                    ASSIGN
                    n_gap_t      = n_gap_t   + n_gap_r
                    n_prem_t     = n_prem_t  + n_prem_r
                    n_sigr_t     = n_sigr_t  + n_sigr_r
                    n_gap_r      = 0 
                    n_prem_r     = 0  
                    n_sigr_r     = 0.
           END.    /* end uwm120 */     
  End.  /*  avail  100   */ 
  /*-------------------- calprem ---------------------*/
  Find FIRST sic_bran.uwm120  Use-index uwm12001  WHERE          
             sic_bran.uwm120.policy  = sic_bran.uwm100.policy   And
             sic_bran.uwm120.rencnt  = sic_bran.uwm100.rencnt   And
             sic_bran.uwm120.endcnt  = sic_bran.uwm100.endcnt   AND 
             /*sic_bran.uwm120.riskno  = impdata_fil.riskno           AND *//* add a64-0369 */
             sic_bran.uwm120.bchyr   = nv_batchyr               AND 
             sic_bran.uwm120.bchno   = nv_batchno               AND 
             sic_bran.uwm120.bchcnt  = nv_batcnt                No-error.
  FIND LAST  sicsyac.xmm018 USE-INDEX xmm01801 WHERE
             sicsyac.xmm018.agent              = sic_bran.uwm100.acno1          AND               /*แยกงานตาม Code Producer*/  
             substr(sicsyac.xmm018.poltyp,1,5) = "CR" + sic_bran.uwm100.poltyp  AND               /*Shukiat T. modi on 25/04/2007*/
             SUBSTR(xmm018.poltyp,7,1)         = sic_bran.uwm100.branch         AND               /*Shukiat T. add on 05/06/2007 A50-0144*/
             sicsyac.xmm018.datest            <= sic_bran.uwm100.comdat         NO-LOCK NO-ERROR. /*Shukiat T. add on 25/04/2007*/
    IF AVAIL   sicsyac.xmm018 THEN DO:
              Assign     nv_com1p = sicsyac.xmm018.commsp  
                         nv_com2p = 0
                         nv_commpol = sicsyac.xmm018.commsp  .
    END.
    ELSE DO:
            Find sicsyac.xmm031  Use-index xmm03101  Where  
                 sicsyac.xmm031.poltyp  = sic_bran.uwm100.poltyp
            No-lock no-error no-wait.
            IF not  avail sicsyac.xmm031 Then 
              Assign     nv_com1p = 0
                         nv_com2p = 0
                         nv_commpol = 0.
            Else  
              Assign     nv_com1p = sicsyac.xmm031.comm1
                         nv_com2p = 0
                         nv_commpol = sicsyac.xmm031.comm1 .
    END. /* Not Avail Xmm018 */
  /*--------- tax -----------*/
  Find sicsyac.xmm020 Use-index xmm02001        Where
       sicsyac.xmm020.branch = sic_bran.uwm100.branch   And
       sicsyac.xmm020.dir_ri = sic_bran.uwm100.dir_ri   No-lock no-error.
  IF avail sicsyac.xmm020 Then do:
           nv_fi_stamp_per      = sicsyac.xmm020.rvstam.
       If    sic_bran.uwm100.gstrat  <>  0  Then  nv_fi_tax_per  =  sic_bran.uwm100.gstrat.
       Else  nv_fi_tax_per  =  sicsyac.xmm020.rvtax.
  End.
  /*----------- stamp ------------*/
  IF sic_bran.uwm120.stmpae  = Yes Then do:                        /* STAMP */
     nv_fi_rstp_t  = Truncate(n_prem_t * nv_fi_stamp_per / 100,0) +
                     (IF     (n_prem_t * nv_fi_stamp_per / 100)   -
                     Truncate(n_prem_t * nv_fi_stamp_per / 100,0) > 0
                     Then 1 Else 0).
  End.
  sic_bran.uwm100.rstp_t =  nv_fi_rstp_t.
     
  IF  sic_bran.uwm120.taxae   = Yes   Then do:                       /* TAX */
      nv_fi_rtax_t  = (n_prem_t + nv_fi_rstp_t + sic_bran.uwm100.pstp)
                       * nv_fi_tax_per  / 100.
       /* fi_taxae       = Yes.*/
  End.
  sic_bran.uwm100.rtax_t = nv_fi_rtax_t.

  if sic_bran.uwm100.poltyp = "V70" THEN DO: 
      IF impdata_fil.agco70 <> "" THEN DO:
          sic_bran.uwm120.com1ae = YES.
          sic_bran.uwm120.com3ae = YES. 
        IF impdata_fil.comper70  <> (-1) AND impdata_fil.comco_per70  = (-1) THEN DO:  /* ระบุ comm policy แต่ไม่ระบุ comm co-broker */
            ASSIGN  nv_com3p  = nv_com1p - impdata_fil.comper70
                    nv_com1p  = impdata_fil.comper70 .
        END.
        ELSE IF impdata_fil.comper70  = (-1) AND impdata_fil.comco_per70  <> (-1) THEN DO: /* ไม่ระบุ comm policy แต่ระบุ comm co-broker */
            ASSIGN  nv_com1p  = nv_com1p - impdata_fil.comco_per70
                    nv_com3p  = impdata_fil.comco_per70 .
        END.
        ELSE IF impdata_fil.comper70  <> (-1) AND impdata_fil.comco_per70  <> (-1) THEN DO: /* ระบุ comm policy และ ระบุ comm co-broker */
            ASSIGN  nv_com1p  = impdata_fil.comper70
                    nv_com3p  = impdata_fil.comco_per70 .
        END.
        
        IF impdata_fil.comprem70 <> (-1)  THEN  /* ใส่เบี้ย comm policy มาในไฟล์ */
            ASSIGN nv_fi_com1_t = (impdata_fil.comprem70) /* ระบุติดลบมาในไฟล์ */
                   sic_bran.uwm120.com1ae = NO.

        IF impdata_fil.comco_prem70 <> (-1)  THEN /* ใส่เบี้ย comm co-broker มาในไฟล์ */
            ASSIGN nv_fi_com3_t = (impdata_fil.comco_prem70) /* ระบุติดลบมาในไฟล์ */
                   sic_bran.uwm120.com3ae = NO.
      END.
      /* end : A64-0355 */
      ELSE DO:
        sic_bran.uwm120.com1ae = YES. 
        IF impdata_fil.comper70  <> (-1)  THEN ASSIGN nv_com1p  = impdata_fil.comper70 .
        IF impdata_fil.comprem70 <> (-1)  THEN 
            ASSIGN nv_fi_com1_t = (impdata_fil.comprem70) /* ระบุติดลบมาในไฟล์ */
                   sic_bran.uwm120.com1ae = NO.
      END.
  END.
 /*--------- motor commission -----------------*/
  IF sic_bran.uwm120.com1ae   = Yes Then do:         /* MOTOR COMMISION */
     If sic_bran.uwm120.com1p <> 0  Then nv_com1p  = sic_bran.uwm120.com1p.
     nv_fi_com1_t   =  - ROUND((sic_bran.uwm100.prem_t - nt_compprm) * nv_com1p / 100,2) .            
         /*fi_com1ae        =  YES.*/
  End.
   /* add  co-broker */  
  IF impdata_fil.agco70 <> ""  THEN DO:
    IF sic_bran.uwm120.com3ae   = Yes  Then do:                   /* Comp.COMMISION */
      If sic_bran.uwm120.com3p <> 0  Then nv_com3p  = sic_bran.uwm120.com3p.
      nv_fi_com3_t   = - ROUND((sic_bran.uwm100.prem_t - nt_compprm) * nv_com3p / 100 ,2).    
    End.
  END.

  IF nv_fi_com1_t > 0 THEN nv_fi_com1_t = nv_fi_com1_t * (-1) .
  IF nv_fi_com3_t > 0 THEN nv_fi_com3_t = nv_fi_com3_t * (-1) .
  
  /*----------- comp comission V72 ------------
  IF sic_bran.uwm120.com2ae   = Yes  Then do:                   /* Comp.COMMISION */
      If sic_bran.uwm120.com2p <> 0  Then nv_com2p  = sic_bran.uwm120.com2p.
      nv_fi_com2_t   =  - ROUND(nt_compprm  *  nv_com2p / 100 ,2).              
         /*nv_fi_com2ae        =  YES.*/
  End.*/
  
  IF sic_bran.uwm100.pstp <> 0 Then do:
     IF sic_bran.uwm100.no_sch  = 1 Then NV_fi_dup_trip = "D".
     Else If sic_bran.uwm100.no_sch  = 2 Then  NV_fi_dup_trip = "T".
  End.
  Else  NV_fi_dup_trip  =  "".

  nv_fi_netprm = sic_bran.uwm100.prem_t + sic_bran.uwm100.rtax_t
               + sic_bran.uwm100.rstp_t + sic_bran.uwm100.pstp.

  /* add  co-broker */
   nv_commpol   = (nv_com1p + nv_com3p) .
   nv_commpol_t = - ROUND((sic_bran.uwm100.prem_t - nt_compprm) * nv_commpol / 100 ,2).  /* commission total */
   nv_comm13_t  =  ROUND(nv_fi_com1_t + nv_fi_com3_t ,2) .

  IF impdata_fil.agco70 <> ""  THEN DO: /*21/12/2021*/
    IF nv_commpol_t <> nv_comm13_t AND sic_bran.uwm120.com3ae = YES THEN DO:
        nv_fi_com3_t = (nv_commpol_t) - (nv_fi_com1_t) .
    END.
  END. /*21/12/2021*/
  
  /*Find     sic_bran.uwm100 Where  Recid(sic_bran.uwm100)  =  s_recid1.*/
  FIND FIRST sic_bran.uwm100 WHERE 
      sic_bran.uwm100.policy  = nv_policy  AND
      sic_bran.uwm100.rencnt  = nv_rencnt  AND
      sic_bran.uwm100.endcnt  = nv_endcnt  AND
      sic_bran.uwm100.bchyr   = nv_batchyr AND 
      sic_bran.uwm100.bchno   = nv_batchno AND 
      sic_bran.uwm100.bchcnt  = nv_batcnt  .  
  If avail sic_bran.uwm100 Then DO:
      Assign 
           sic_bran.uwm100.gap_p   = n_gap_t
           sic_bran.uwm100.prem_t  = n_prem_t
           sic_bran.uwm100.sigr_p  = n_sigr_t
           sic_bran.uwm100.instot  = uwm100.instot
           sic_bran.uwm100.com1_t  = nv_fi_com1_t
           sic_bran.uwm100.com2_t  = nv_fi_com2_t
           sic_bran.uwm100.com3_t  = nv_fi_com3_t  /*A64-0355*/
           sic_bran.uwm100.pstp    = 0               /*note modified on 25/10/2006*/
           sic_bran.uwm100.rstp_t  = nv_fi_rstp_t
           sic_bran.uwm100.rtax_t  = nv_fi_rtax_t          
           sic_bran.uwm100.gstrat  = nv_fi_tax_per.
  END.
  
 /*Find     sic_bran.uwm120 Where  Recid(sic_bran.uwm120)   =  s_recid2   .*/
  FIND FIRST sic_bran.uwm120 WHERE
      sic_bran.uwm120.policy  = nv_policy   AND
      sic_bran.uwm120.rencnt  = nv_rencnt  AND
      sic_bran.uwm120.endcnt  = nv_endcnt  AND
      sic_bran.uwm120.bchyr   = nv_batchyr AND 
      sic_bran.uwm120.bchno   = nv_batchno AND 
      sic_bran.uwm120.bchcnt  = nv_batcnt  .  
  IF avail sic_bran.uwm120 Then do:
       Assign
           /*sic_bran.uwm120.gap_r    = n_gap_t   /*n_gap_r */
           sic_bran.uwm120.prem_r   = n_prem_t  /*n_prem_r */
           sic_bran.uwm120.sigr     = n_sigr_T */ /* A490166 note modi from n_sigr_r to n_sigr_t 11/10/2006 */
           sic_bran.uwm120.rtax     = nv_fi_rtax_t
           sic_bran.uwm120.taxae    = YES
           sic_bran.uwm120.stmpae   = YES
           sic_bran.uwm120.rstp_r   = nv_fi_rstp_t            

           /*sic_bran.uwm120.com1ae   = YES*/
           sic_bran.uwm120.com1p    = nv_com1p
           sic_bran.uwm120.com1_r   = nv_fi_com1_t
           sic_bran.uwm120.com2ae   = YES
           sic_bran.uwm120.com2p    = nv_com2p
           sic_bran.uwm120.com2_r   = nv_fi_com2_t
           sic_bran.uwm120.com3p    = nv_com3p         /*A64-0355*/
           sic_bran.uwm120.com3_r   = nv_fi_com3_t .   /*A64-0355*/
  End.

  IF impdata_fil.poltyp = "V70" THEN DO: 
    nv_commpol   = (sic_bran.uwm120.com1p + sic_bran.uwm120.com3p) .
    nv_commpol_t = - ROUND((sic_bran.uwm100.prem_t - nt_compprm) * nv_commpol / 100 ,2).  /* commission total */
    nv_comm13_t  =  ROUND(sic_bran.uwm100.com1_t + sic_bran.uwm100.com3_t ,2) .
    
    IF nv_commpol_t <> nv_comm13_t THEN DO:
        ASSIGN impdata_fil.comment = IF  impdata_fil.agco70 <> ""  THEN impdata_fil.comment + "|" + "ยอดรวม comm. + comm.co-broker " + string(nv_comm13_t) + 
                                 " ไม่เท่ากับ comm.รวม กธ " + STRING(nv_commpol_t) 
                                ELSE  impdata_fil.comment + "|ยอดรวม comm.ในไฟล์ " + string(nv_comm13_t) + " ไม่เท่ากับ comm.รวมจากระบบ " + STRING(nv_commpol_t).
    END.
  END.
  IF impdata_fil.instot > 1 THEN DO:
      ASSIGN 
          nv_com1p_ins        = nv_com1p 
          nv_fi_tax_per_ins   = nv_fi_tax_per  
          nv_fi_stamp_per_ins = nv_fi_stamp_per    . 

      /* add by : A64-0355 co-broker */
      IF impdata_fil.agco70 <> "" THEN ASSIGN nv_com3p_ins = nv_com3p .
      ELSE ASSIGN nv_com3p_ins = 0 .
      /* end : A64-0355 co-broker */

      /*RUN proc_instot  .  */
      RUN proc_insnam_inst .
      FIND FIRST bfimpinst_fil WHERE bfimpinst_fil.policyno = impdata_fil.policyno NO-LOCK NO-ERROR.
        IF AVAIL bfimpinst_fil THEN DO:
            IF bfimpinst_fil.instcomm02 <> 0 AND impinst_fil.instrstp2 <> 0 THEN RUN proc_instot1. /*มีเบี้ย installment ในไฟล์ */
            ELSE RUN proc_instot2. /* ไม่มีเบี้ย */
        END.
  END.
  RELEASE sic_bran.uwd132 .
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_clearmailtxt C-Win 
PROCEDURE proc_clearmailtxt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN nv_ntitle    = ""
       nv_name      = ""
       nv_lname     = ""
       nv_drinam    = ""
       nv_dicno     = ""
       nv_dgender   = ""
       nv_dbirth    = ""
       nv_dribirth  = ""
       nv_dage      = 0
       nv_doccup    = ""
       nv_ddriveno  = ""
       nv_drivexp   = ""
       nv_dconsent  = ""
       nv_dlevel    = 0 
       nv_dlevper   = 0 .

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create100 C-Win 
PROCEDURE proc_create100 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
Create  sic_bran.uwm100.   /*Create ฝั่ง gateway*/    
ASSIGN                                              
       sic_bran.uwm100.policy =  impdata_fil.policy
       sic_bran.uwm100.rencnt =  n_rencnt              
       sic_bran.uwm100.renno  =  ""
       sic_bran.uwm100.endcnt =  n_endcnt
       sic_bran.uwm100.bchyr  =  nv_batchyr 
       sic_bran.uwm100.bchno  =  nv_batchno 
       sic_bran.uwm100.bchcnt =  nv_batcnt     .


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cr_2 C-Win 
PROCEDURE proc_cr_2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*DEF VAR len AS INTE.
DEF BUFFER bfimpdata_fil FOR impdata_fil.
IF impdata_fil.cr_2 <> ""  THEN DO:
FIND LAST bfimpdata_fil WHERE trim(bfimpdata_fil.chasno) =  TRIM(impdata_fil.chasno) AND 
                          trim(bfimpdata_fil.poltyp) <> trim(impdata_fil.poltyp)  NO-LOCK NO-ERROR.
IF AVAIL bfimpdata_fil THEN DO: 
    ASSIGN impdata_fil.cr_2 = bfimpdata_fil.policyno .
    IF impdata_fil.poltyp = "V72" THEN impdata_fil.redbook =  bfimpdata_fil.redbook .
END.
    FIND LAST bfimpdata_fil WHERE trim(bfimpdata_fil.policy) =  TRIM(impdata_fil.cr_2)  NO-LOCK NO-ERROR.
    IF AVAIL bfimpdata_fil THEN DO: 
        IF bfimpdata_fil.poltyp = "V72" AND impdata_fil.redbook <> "" THEN bfimpdata_fil.redbook =  impdata_fil.redbook .
    END.

END.
*/    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cutchar C-Win 
PROCEDURE proc_cutchar :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_i AS INT.
DEF VAR nv_c AS CHAR.
DEF VAR nv_l AS INT.
DEF VAR nv_p AS CHAR.
DEF VAR ind AS INT.

ASSIGN nv_c = ""  .
IF impdata_fil.prepol <> ""  THEN DO:
    nv_c = impdata_fil.prepol.
    
    nv_i = 0.
    nv_l = LENGTH(nv_c).
    
    
    DO WHILE nv_i <= nv_l:
    
        ind = 0.
        ind = INDEX(nv_c,"/").
        IF ind <> 0 THEN DO:
            nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
        END.
        ind = INDEX(nv_c,"\").
        IF ind <> 0 THEN DO:
            nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
        END.
        ind = INDEX(nv_c,"-").
        IF ind <> 0 THEN DO:
            nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
        END.
    
        ind = INDEX(nv_c," ").
        IF ind <> 0 THEN DO:
            nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
        END.
    
        nv_i = nv_i + 1.
    END.
    ASSIGN
        impdata_fil.prepol = nv_c .
END.

ASSIGN nv_c = ""  .
IF impdata_fil.vehreg <> ""  THEN DO:
    nv_c = TRIM(impdata_fil.vehreg).
    
    nv_i = 0.
    nv_l = LENGTH(nv_c).
    
    DO WHILE nv_i <= nv_l:
    
        ind = 0.
    
        ind = INDEX(nv_c,"/").
        IF ind <> 0 THEN DO:
            nv_c = TRIM(REPLACE(nv_c,"/"," ")).
        END.
        ind = INDEX(nv_c,"\").
        IF ind <> 0 THEN DO:
            nv_c = TRIM(REPLACE(nv_c,"\"," ")).
        END.
        ind = INDEX(nv_c,"-").
        IF ind <> 0 THEN DO:
            nv_c = TRIM(REPLACE(nv_c,"-"," ")).
        END.
        nv_i = nv_i + 1.
    END.
    ASSIGN
        impdata_fil.vehreg = nv_c .
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_deldata C-Win 
PROCEDURE proc_deldata :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

For each  impdata_fil USE-INDEX data_fil10 WHERE 
    impdata_fil.usrid  = USERID(LDBNAME(1)) AND 
    impdata_fil.progid = nv_proid           :
    DELETE  impdata_fil.
End.
For each  imptxt_fil USE-INDEX txt_fil02 WHERE 
    imptxt_fil.usrid  = USERID(LDBNAME(1)) AND 
    imptxt_fil.progid = nv_proid            :
    DELETE  imptxt_fil.
End.
For each  impmemo_fil USE-INDEX memo_fil02 WHERE 
    impmemo_fil.usrid  = USERID(LDBNAME(1)) AND 
    impmemo_fil.progid = nv_proid           :
    DELETE  impmemo_fil.
End.
For each  impacc_fil USE-INDEX acc_fil02 WHERE 
    impacc_fil.usrid  = USERID(LDBNAME(1)) AND 
    impacc_fil.progid = nv_proid             :
    DELETE  impacc_fil.
End.
For each  impinst_fil USE-INDEX inst_fil02 WHERE 
    impinst_fil.usrid  = USERID(LDBNAME(1)) AND 
    impinst_fil.progid = nv_proid           :    
    DELETE  impinst_fil.
End.
/* A67-0029 */
For each  impdriv_fil USE-INDEX driv_fil05 WHERE 
    impdriv_fil.usrid  = USERID(LDBNAME(1)) AND 
    impdriv_fil.progid = nv_proid           :    
    DELETE  impdriv_fil.
End.
/* end : A67-0065*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_dstf72 C-Win 
PROCEDURE proc_dstf72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: add DSPC72    
------------------------------------------------------------------------------*/
/*DEF VAR nv_check AS LOGICAL INIT NO.
DEF VAR nv_recid AS RECID .
DEF BUFFER wf_uwd132 FOR sic_bran.uwd132.

DO:
    FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-ERROR NO-WAIT.
    FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-ERROR NO-WAIT.

    ASSIGN nv_bptr = 0.
    
    IF nv_stf_per  <> 0  THEN DO:
       nv_check = NO.
       FIND FIRST wf_uwd132 USE-INDEX uwd13201 WHERE 
                  wf_uwd132.policy = sic_bran.uwm100.policy AND
                  wf_uwd132.rencnt = sic_bran.uwm100.rencnt AND
                  wf_uwd132.endcnt = sic_bran.uwm100.endcnt AND 
                  wf_uwd132.riskno = sic_bran.uwm130.riskno AND
                  wf_uwd132.itemno = sic_bran.uwm130.itemno AND
                  wf_uwd132.bchyr  = nv_batchyr             AND
                  wf_uwd132.bchno  = nv_batchno             AND
                  wf_uwd132.bchcnt = nv_batcnt              AND
                  wf_uwd132.bptr   = 0             NO-LOCK NO-ERROR.


 FIND sic_bran.uwd132  USE-INDEX uwd13201 WHERE
         sic_bran.uwd132.policy = sic_bran.uwm100.policy AND
         sic_bran.uwd132.rencnt = sic_bran.uwm100.rencnt AND
         sic_bran.uwd132.endcnt = sic_bran.uwm100.endcnt AND
         sic_bran.uwd132.riskgp = s_riskgp               AND
         sic_bran.uwd132.riskno = s_riskno               AND
         sic_bran.uwd132.itemno = s_itemno               AND
         sic_bran.uwd132.bchyr  = nv_batchyr             AND
         sic_bran.uwd132.bchno  = nv_batchno             AND
         sic_bran.uwd132.bchcnt = nv_batcnt              NO-ERROR NO-WAIT.
       IF AVAIL wf_uwd132 THEN DO:
           nv_bptr  = RECID(wf_uwd132).
       END.
    
       FIND FIRST sic_bran.uwd132 USE-INDEX uwd13201 WHERE 
                  sic_bran.uwd132.policy = sic_bran.uwm100.policy AND
                  sic_bran.uwd132.rencnt = sic_bran.uwm100.rencnt AND
                  sic_bran.uwd132.endcnt = sic_bran.uwm100.endcnt AND 
                  sic_bran.uwd132.riskno = sic_bran.uwm130.riskno AND
                  sic_bran.uwd132.itemno = sic_bran.uwm130.itemno AND
                  sic_bran.uwd132.bchyr  = nv_batchyr             AND
                  sic_bran.uwd132.bchno  = nv_batchno             AND
                  sic_bran.uwd132.bchcnt = nv_batcnt              AND
                  sic_bran.uwd132.bencod = "DSTF" NO-ERROR.
       IF NOT AVAIL sic_bran.uwd132 THEN DO:
           CREATE sic_bran.uwd132.
           ASSIGN
               sic_bran.uwd132.gap_ae = NO
               sic_bran.uwd132.pd_aep = "E"
               sic_bran.uwd132.bencod = "DSTF"                   sic_bran.uwd132.policy = sic_bran.uwm130.policy
               sic_bran.uwd132.rencnt = sic_bran.uwm130.rencnt   sic_bran.uwd132.endcnt = sic_bran.uwm130.endcnt
               sic_bran.uwd132.riskgp = sic_bran.uwm130.riskgp   sic_bran.uwd132.riskno = sic_bran.uwm130.riskno
               sic_bran.uwd132.itemno = sic_bran.uwm130.itemno   sic_bran.uwd132.bchyr  = nv_batchyr  
               sic_bran.uwd132.bchno  = nv_batchno               sic_bran.uwd132.bchcnt = nv_batcnt   
               nv_check = YES.
    
       END.
    
       ASSIGN
           sic_bran.uwd132.gap_c  = nv_stf_per
           sic_bran.uwd132.prem_c = nv_stf_per
           sic_bran.uwd132.benvar = nv_stfvar
           nv_recid = RECID(sic_bran.uwd132).
    
       IF nv_check = YES THEN DO:
           FIND sic_bran.uwd132 WHERE RECID(sic_bran.uwd132) = nv_recid NO-ERROR.
           IF AVAIL sic_bran.uwd132 THEN DO: /*new*/
               FIND FIRST wf_uwd132 WHERE RECID(wf_uwd132) = nv_bptr  NO-ERROR.
               IF AVAIL wf_uwd132 THEN DO:
                   ASSIGN
                       wf_uwd132.bptr  = RECID(uwd132)
                       sic_bran.uwd132.fptr   = RECID(wf_uwd132)  /*new record*/
                       sic_bran.uwd132.bptr   = 0               /*new record*/
                       sic_bran.uwm130.fptr03 = RECID(sic_bran.uwd132).
    
                   FIND FIRST wf_uwd132 WHERE wf_uwd132.policy = sic_bran.uwm100.policy AND
                          wf_uwd132.rencnt = sic_bran.uwm100.rencnt AND
                          wf_uwd132.endcnt = sic_bran.uwm100.endcnt AND 
                          wf_uwd132.fptr   = 0             NO-LOCK NO-ERROR.
                   IF AVAIL wf_uwd132 THEN DO:
                        sic_bran.uwm130.bptr03 = RECID(wf_uwd132).
                   END.
               END.
           END.
    
       END.
    END.
    RELEASE sic_bran.uwd132.
END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_header C-Win 
PROCEDURE proc_header :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:    
------------------------------------------------------------------------------*/
DO:
OUTPUT TO VALUE(fi_filename).
    EXPORT DELIMITER "|"
        "Risk no. " 
        "ItemNo   " 
        "Policy No (เลขที่กรมธรรม์ภาคสมัครใจ)"  
        "Branch (สาขา) "         
        "Agent Code (รหัสตัวแทน)   "         
        "Producer Code "         
        "Dealer Code (รหัสดีเลอร์) "         
        "Finance Code (รหัสไฟแนนซ์)"         
        "Notification Number (เลขที่รับแจ้ง) "  
        "Notification Name (ชื่อผู้แจ้ง)     "  
        "Short Rate                "         
        "Effective Date (วันที่เริ่มความคุ้มครอง)"  
        "Expiry Date (วันที่สิ้นสุดความคุ้มครอง) "  
        "Agree Date    "             
        "First Date    "             
        "รหัสแพ็กเกจ   "
        "Campaign Code (รหัสแคมเปญ)"
        "Campaign Text "
        "Spec Con      "
        "Product Type  "
        "Promotion Code"
        "Renew Count   "
        "Previous Policy (เลขทีกรมธรรม์ภาคสมัครใจเดิม)"
        "Policy Text 1   "
        "Policy Text 2   "
        "Policy Text 3   "
        "Policy Text 4   "
        "Policy Text 5   "
        "Policy Text 6   "
        "Policy Text 7   "
        "Policy Text 8   "
        "Policy Text 9   "
        "Policy Text 10  "
        "Memo Text 1     "
        "Memo Text 2     "
        "Memo Text 3     "
        "Memo Text 4     "
        "Memo Text 5     "
        "Memo Text 6     "
        "Memo Text 7     "
        "Memo Text 8     "
        "Memo Text 9     "
        "Memo Text 10    "
        "Accessory Text 1"
        "Accessory Text 2"
        "Accessory Text 3"
        "Accessory Text 4"
        "Accessory Text 5"
        "Accessory Text 6"
        "Accessory Text 7"
        "Accessory Text 8"
        "Accessory Text 9"
        "Accessory Text 10"
        "กรมธรรม์ซื้อควบ (Y/N)"
        "Insured Code         "
        "ประเภทบุคคล          "
        "ภาษาที่ใช้สร้าง Cilent Code"
        "คำนำหน้า "
        "ชื่อ     "
        "นามสกุล  "
        "เลขที่บัตรประชาชน / เลขที่นิติบุคคล"
        "ลำดับที่สาขา       "
        "อาชีพ              "
        "ที่อยู่บรรทัดที่ 1 "
        "ที่อยู่บรรทัดที่ 2 "
        "ที่อยู่บรรทัดที่ 3 "
        "ที่อยู่บรรทัดที่ 4 "
        "รหัสไปรษณีย์       "
        "province code      "
        "district code      "
        "sub district code  "
        "AE Code            "
        "Japanese Team      "
        "TS Code            "
        "Gender (Male/Female/Other)"
        "Telephone 1  "
        "Telephone 2  "
        "E-Mail 1 " 
        "E-Mail 2 " 
        "E-Mail 3 " 
        "E-Mail 4 " 
        "E-Mail 5 " 
        "E-Mail 6 " 
        "E-Mail 7 " 
        "E-Mail 8 " 
        "E-Mail 9 " 
        "E-Mail 10" 
        "Fax      " 
        "Line ID  " 
        "CareOf1  " 
        "CareOf2  " 
        "Benefit Name "
        "Payer Code   "
        "VAT Code     "
        "Client Code  "
        "ประเภทบุคคล  "
        "คำนำหน้า     "
        "ชื่อ         "
        "นามสกุล      "
        "เลขที่บัตรประชาชน / เลขที่นิติบุคคล"
        "ลำดับที่สาขา       "   
        "ที่อยู่บรรทัดที่ 1 "   
        "ที่อยู่บรรทัดที่ 2 "   
        "ที่อยู่บรรทัดที่ 3 "   
        "ที่อยู่บรรทัดที่ 4 "   
        "รหัสไปรษณีย์  "   
        "province code "   
        "district code "   
        "sub district code  "   
        "เบี้ยก่อนภาษีอากร  "   
        "อากร  "   
        "ภาษี  "   
        "คอมมิชชั่น 1  "   
        "คอมมิชชั่น 2 (co-broker) "
        "Client Code  " 
        "ประเภทบุคคล  " 
        "คำนำหน้า     " 
        "ชื่อ         " 
        "นามสกุล      " 
        "เลขที่บัตรประชาชน / เลขที่นิติบุคคล"
        "ลำดับที่สาขา      "
        "ที่อยู่บรรทัดที่ 1"
        "ที่อยู่บรรทัดที่ 2"
        "ที่อยู่บรรทัดที่ 3"
        "ที่อยู่บรรทัดที่ 4"
        "รหัสไปรษณีย์      "
        "province code     "
        "district code     "
        "sub district code "
        "เบี้ยก่อนภาษีอากร "
        "อากร        "  
        "ภาษี        "  
        "คอมมิชชั่น 1"  
        "คอมมิชชั่น 2 (co-broker)"
        "Client Code  "
        "ประเภทบุคคล  "
        "คำนำหน้า "
        "ชื่อ     "
        "นามสกุล  "
        "เลขที่บัตรประชาชน/เลขที่นิติบุคคล"
        "ลำดับที่สาขา      "
        "ที่อยู่บรรทัดที่ 1"
        "ที่อยู่บรรทัดที่ 2"
        "ที่อยู่บรรทัดที่ 3"
        "ที่อยู่บรรทัดที่ 4"
        "รหัสไปรษณีย์      "
        "province code     "
        "district code     "
        "sub district code "
        "เบี้ยก่อนภาษีอากร "
        "อากร              "
        "ภาษี              "
        "คอมมิชชั่น 1      "
        "คอมมิชชั่น 2 (co-broker)"
        "Cover Type (ประเภทความคุ้มครอง)"
        "Garage (ประเภทการซ่อม ซ่อมอู่/ซ่อมห้าง)"
        "Spacial Equipment Flag (A/Blank)"  
        "Inspection    "  
        "รหัสรถภาคสมัครใจ (110/120/320)" 
        "ลักษณะการใช้รถ"
        "Redbook       "  /*A65-0079*/
        "ยี่ห้อรถ      "         
        "ชื่อรุ่นรถ    "         
        "ชื่อรุ่นย่อยรถ"         
        "ปีรุ่นรถ      "         
        "หมายเลขตัวถัง "         
        "หมายเลขเครื่อง"
        "หมายเลขเครื่อง 2 " /*A67-0029*/
        "จำนวนที่นั่ง (รวมผู้ขับขี่)   "  
        "ปริมาตรกระบอกสูบ (CC)"  
        "น้ำหนัก (ตัน)  "   
        "Kilowatt/HP      "   
        "รหัสแบบตัวถัง  "   
        "ป้ายแดง (Y/N)  "   
        "ปีที่จดทะเบียน "   
        "เลขทะเบียนรถ   "   
        "จังหวัดที่จดทะเบียน  "  
        "Group Car (กลุ่มรถ)  "  
        "Color (สี)           "  
        "Fule (เชื้อเพลิง)    "  
        "Driver Number"  
        "คำนำหน้า     "  
        "ชื่อ         "  
        "นามสกุล      "  
        "เลขที่บัตรประชาชน    "  
        "เพศ          "  
        "วันเกิด      "  
        "ชื่ออาชีพ    "  
        "เลขที่ใบอนุญาตขับขี่ "
        "วันที่ใบอนุญาต หมดอายุ " /*A67-0029*/
        "Consent ผู้ขับขี่ 1 "  /*A67-0029*/
        "ระดับพฤติกรรมการขับขี่ " /*A67-0029*/
        "คำนำหน้า     "  
        "ชื่อ         "  
        "นามสกุล      "  
        "เลขที่บัตรประชาชน    "  
        "เพศ          "  
        "วันเกิด      "  
        "ชื่ออาชีพ    "  
        "เลขที่ใบอนุญาตขับขี่ "  
        /*A67-0029*/
        "วันที่ใบอนุญาต หมดอายุ" 
        "Consent ผู้ขับขี่ 2 "  /*A67-0029*/
        "ระดับพฤติกรรมการขับขี่"
        "คำนำหน้า  "   
        "ชื่อ      "   
        "นามสกุล   "       
        "เลขที่บัตรประชาชน "   
        "เพศ       "       
        "วันเกิด   "       
        "ชื่ออาชีพ "       
        "เลขที่ใบอนุญาตขับขี่  "   
        "วันที่ใบอนุญาต หมดอายุ" 
        "Consent ผู้ขับขี่ 3 "  
        "ระดับพฤติกรรมการขับขี่"   
        "คำนำหน้า  "       
        "ชื่อ      "       
        "นามสกุล   "       
        "เลขที่บัตรประชาชน "   
        "เพศ       "       
        "วันเกิด   "       
        "ชื่ออาชีพ "       
        "เลขที่ใบอนุญาตขับขี่  "   
        "วันที่ใบอนุญาต หมดอายุ" 
        "Consent ผู้ขับขี่ 4 "  
        "ระดับพฤติกรรมการขับขี่"   
        "คำนำหน้า "   
        "ชื่อ     "   
        "นามสกุล  "   
        "เลขที่บัตรประชาชน  "   
        "เพศ      "         
        "วันเกิด  "   
        "ชื่ออาชีพ"   
        "เลขที่ใบอนุญาตขับขี่  "   
        "วันที่ใบอนุญาต หมดอายุ"
        "Consent ผู้ขับขี่ 5 "  /*A67-0029*/
        "ระดับพฤติกรรมการขับขี่"   
        /* end : A67-0029*/ 
        "Base Premium Plus" 
        "Sum Insured Plus "  
        "RS10 Amount  "  
        "TPBI / person"  
        "TPBI / occurrence"  
        "TPPD         "  
        "Deduct / OD  " 
        "Deduct / DOD1"  /*A65-0079*/
        "Deduct / PD  "  
        "ทุนประกันรถ EV" /*A67-0029*/
        "วงเงินทุนประกัน  "  
        "PA1.1 / driver   "  
        "PA1.1 no.of passenger "  
        "PA1.1 / passenger     "  
        "PA1.2 / driver        "  
        "PA1.2 no.of passenger "  
        "PA1.2 / passenger     "  
        "PA2   "  
        "PA3   "  
        "Base Premium "  
        "Unname"  
        "Name  "  
        "TPBI Amount  " 
        "TPBI2 Amount "  /*A65-0079*/
        "TPPD Amount  "  
        "DOD Amount   " /*A65-079*/  
        "DOD1 Amount  " /*A65-079*/ 
        "DPD Amount   " /*A65-079*/  
        "RY411 Amount " 
        "RY412 Amount " /*A65-0079*/
        "RY413 Amount " /*A65-0079*/
        "RY414 Amount " /*A65-0079*/
        "RY02 Amount  "  
        "RY03 Amount  "  
        "Fleet%       "  
        "NCB%         "  
        "Load Claim%  "  
        "Other Disc.% "  
        "CCTV%        "  
        "Walkin Disc.%"  
        "Fleet Amount "  
        "NCB Amount   "  
        "Load Claim Amount  "   
        "Other Disc. Amount "   
        "CCTV Amount  "     
        "Walk in Disc.Amount"   
        "เบี้ยสุทธิ   "  
        "Stamp Duty   "  
        "VAT          "  
        "Commission % "  
        "Commission Amount     "  
        "Agent Code co-broker (รหัสตัวแทน) "
        "Commission % co-broker     "   
        "Commission Amount co-broker"   
        "Package (Attach Coverage)  "   
        "Dangerous Object 1 "   
        "Dangerous Object 2 "   
        "Sum Insured  "   
        "Rate%        "   
        "Fleet%       "   
        "NCB%         "   
        "Discount%    "   
        "Walkin Disc.%"   
        "Premium Attach Coverage"   
        "Discount Fleet     "   
        "Discount NCB       "   
        "Other Discount     "   
        "Walk in Disc. Amount   "   
        "Net Premium        "   
        "Stamp Duty         "   
        "VAT                "   
        "Commission Amount  "   
        "Commission Amount co-broker"   
        "Claim Text         "   
        "Claim Amount       "   
        "Claim Count Fault  "   
        "Claim Count Fault Amount   "   
        "Claim Count Good   "   
        "Claim Count Good Amount    "   
        "Loss Ratio % (Not TP)      "   
        "Compulsory Policy Number (เลขที่กรมธรรม์ พรบ.)"
        "Barcode No.                        "
        "Compulsory Class (รหัส พรบ.)       "
        "Compulsory Walk In Discount %      "
        "Compulsory Walk In Discount Amount "
        "เบี้ยสุทธิ พ.ร.บ. กรณี กรมธรรม์ซื้อควบ "
        "Stamp Duty        "
        "VAT               "
        "Commission %      "
        "Commission Amount "
        /* A67-0029 */
        "เลขที่แบตเตอรี่"  
        "ปีแบตฯ         "   
        "ราคาแบตฯ       "
        "ทุนแบตฯ       "  
        "Rate           "   
        "Premium        "   
        "เลขที่เครื่องชาร์จ"
        "ราคาเครื่องชาร์จ  "
        "Rate    "        
        "Premium "  
        /* end : A67-0029 */
        "Rate_31"      /*A68-0044*/
        "Premium_31" . /*A68-0044*/

    OUTPUT CLOSE.  
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_initcalprem C-Win 
PROCEDURE proc_initcalprem :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    ASSIGN 
         nv_campcd  = "" /*A65-0079*/
         nv_polday  = 0 
         nv_covcod  = ""  
         nv_class   = ""  
         nv_vehuse  = ""  
         nv_cstflg  = ""  /*C=CC ; S=Seat ; T=Tons ; W=Watts*/    
         nv_engcst  = 0   /* ต้องใส่ค่าตาม nv_cstflg  */         
         /*nv_drivno  = 0*/
         nv_driage1 = 0
         nv_driage2 = 0
         nv_pdprm0  = 0  /*เบี้ยส่วนลดผู้ขับขี่*/
         nv_yrmanu  = 0
         nv_totsi   = 0
         nv_totfi   = 0
         nv_vehgrp  = ""
         nv_access  = ""
         nv_supe    = NO
         nv_tpbi1si = 0
         nv_tpbi2si = 0
         nv_tppdsi  = 0   
         nv_411si   = 0
         nv_412si   = 0
         nv_413si   = 0
         nv_414si   = 0  
         nv_42si    = 0
         nv_43si    = 0
         nv_411prmt = 0  /*A65-0079*/
         nv_412prmt = 0  /*A65-0079*/
         nv_413prmt = 0  /*A65-0079*/
         nv_414prmt = 0  /*A65-0079*/
         nv_42prmt  = 0  
         nv_43prmt  = 0  
         nv_seat41  = 0          
         nv_dedod   = 0
         nv_addod   = 0
         nv_dedpd   = 0 
         nv_dodamt  = 0 /*A65-0079*/
         nv_dadamt  = 0 /*A65-0079*/
         nv_dpdamt  = 0 /*A65-0079*/
         nv_ncbp    = 0
         nv_fletp   = 0
         nv_dspcp   = 0
         nv_dstfp   = 0
         nv_clmp    = 0
         nv_ncbamt  = 0 /*A65-0079*/
         nv_fletamt = 0 /*A65-0079*/
         nv_dspcamt = 0 /*A65-0079*/
         nv_dstfamt = 0 /*A65-0079*/
         nv_clmamt  = 0 /*A65-0079*/
         nv_baseprm  = 0
         nv_baseprm3 = 0
         nv_mainprm  = 0
         nv_pdprem   = 0
         nv_netprem  = 0     /*เบี้ยสุทธิ */
         nv_gapprem  = 0     /*เบี้ยรวม */
         nv_flagprm  = "N"   /* N = เบี้ยสุทธิ, G = เบี้ยรวม */
         nv_effdat   = ?
         nv_ratatt   = 0 
         nv_siatt    = 0 
         nv_netatt   = 0 
         nv_fltatt   = 0 
         nv_ncbatt   = 0 
         nv_dscatt   = 0
         nv_ratatt   = 0
         nv_siatt    = 0
         nv_netatt   = 0
         nv_fltatt   = 0
         nv_ncbatt   = 0
         nv_dscatt   = 0
         nv_attgap   = 0  /*A65-0079*/
         nv_atfltgap = 0  /*A65-0079*/
         nv_atncbgap = 0  /*A65-0079*/
         nv_atdscgap = 0  /*A65-0079*/
         nv_packatt  = "" /*A65-0079*/
         nv_fcctv    = NO 
         nv_flgsht   = ""  /*A65-0079*/
         nv_uom1_c   = "" 
         nv_uom2_c   = "" 
         nv_uom5_c   = "" 
         nv_uom6_c   = "" 
         nv_uom7_c   = "" 
         nv_gapprm   = 0   
         nv_pdprm    = 0   
         nv_message  = ""
         nv_status   = "" 
         /*A67-0029*/                                                       
         nv_level     = 0  
         nv_levper    = 0                                                          
         nv_tariff    = ""                                                     
         nv_adjpaprm  = NO 
         nv_flgpol    = ""
         nv_flgclm    = "NC"  /*NC=NO CLAIM */   
         nv_chgflg    = NO                    
         nv_chgrate   = 0                                           
         nv_chgsi     = 0                                             
         nv_chgpdprm  = 0                                            
         nv_chggapprm = 0                                                                      
         nv_battflg   = NO                     
         nv_battsi    = 0                                            
         nv_battprice = 0                                            
         nv_battpdprm = 0                                            
         nv_battgapprm = 0                                                                      
         nv_battyr     = 0                                              
         nv_battper    = 0                                              
         nv_battrate   = 0                                              
         nv_evflg      = NO               
         nv_compprm    = 0                                                                      
         nv_uom9_v     = 0 
        /* end : A67-0029*/
        nv_flag   = NO       /*A68-0044*/
        nv_31rate = 0      /*A68-0044*/
        nv_31prmt = 0      /*A68-0044*/
        nv_garage = "" .   /*A68-0044*/
    /* add by : A68-0044 */
 IF index(impdata_fil.subclass,"E") <> 0 THEN ASSIGN cv_lncbper = 40.
 ELSE IF impdata_fil.prepol <> ""  THEN ASSIGN cv_lncbper = 50.
 ELSE ASSIGN cv_lncbper = 40.
 /* end : A68-0044 */

END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_initdataex C-Win 
PROCEDURE proc_initdataex :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN                                         /*Add by : A67-0029*/                                                   
   wf_riskno          = ""                     wf_eng_no2   = ""     /*หมายเลขเครื่อง 2 */ /*A67-0029*/                                                            
   wf_num             = ""                     wf_maksi     = ""     /* ทุนประกันรถ EV */ /*A67-0029*/                                                         
   wf_policyno        = ""                     wf_drivexp1  = ""     /*วันที่ใบอนุญาต หมดอายุ */  /*A67-0029*/         
                                               wf_dlevel1   = ""     /*ระดับพฤติกรรมการขับขี่ */  /*A67-0029*/         
   wf_n_branch        = ""                     wf_drivexp2  = ""     /*วันที่ใบอนุญาต หมดอายุ */                                                               
   wf_agent           = ""                     wf_dlevel2   = ""     /*ระดับพฤติกรรมการขับขี่ */                                                               
   wf_producer        = ""                     wf_ntitle3   = ""     /*คำนำหน้า              */                                                                
   wf_n_delercode     = ""                     wf_dname3    = ""     /*ชื่อ                  */                                                                
   wf_fincode         = ""                     wf_dlname3   = ""     /*นามสกุล               */                                                                
   wf_appenno         = ""                     wf_dicno3    = ""     /*เลขที่บัตรประชาชน     */                                                                
   wf_salename        = ""                     wf_dgender3  = ""     /*เพศ                   */                                                                
   wf_srate           = ""                     wf_dbirth3   = ""     /*วันเกิด               */                                                                
   wf_comdat          = ""                     wf_doccup3   = ""     /*ชื่ออาชีพ             */                                                                
   wf_expdat          = ""                     wf_ddriveno3 = ""     /*เลขที่ใบอนุญาตขับขี่  */                                                                
   wf_agreedat        = ""                     wf_drivexp3  = ""     /*วันที่ใบอนุญาต หมดอายุ*/                                                                
   wf_firstdat        = ""                     wf_dlevel3   = ""     /*ระดับพฤติกรรมการขับขี่*/                                                                
   wf_packcod         = ""                     wf_ntitle4   = ""     /*คำนำหน้า              */                                                                
   wf_camp_no         = ""                     wf_dname4    = ""     /*ชื่อ                  */                                                                
   wf_campen          = ""                     wf_dlname4   = ""     /*นามสกุล               */                                                                
   wf_specon          = ""                     wf_dicno4    = ""     /*เลขที่บัตรประชาชน     */                                                                
   wf_product         = ""                     wf_dgender4  = ""     /*เพศ                   */                                                                
   wf_promo           = ""                     wf_dbirth4   = ""     /*วันเกิด               */                                                                
   wf_rencnt          = ""                     wf_doccup4   = ""     /*ชื่ออาชีพ             */                                                                
   wf_prepol          = ""                     wf_ddriveno4 = ""     /*เลขที่ใบอนุญาตขับขี่  */                                                                
   wf_txt1            = ""                     wf_drivexp4  = ""     /*วันที่ใบอนุญาต หมดอายุ*/                                                                
   wf_txt2            = ""                     wf_dlevel4   = ""     /*ระดับพฤติกรรมการขับขี่*/                                                                
   wf_txt3            = ""                     wf_ntitle5   = ""     /*คำนำหน้า              */                                                                
   wf_txt4            = ""                     wf_dname5    = ""     /*ชื่อ                  */                                                                
   wf_txt5            = ""                     wf_dlname5   = ""     /*นามสกุล               */                                                                
   wf_txt6            = ""                     wf_dicno5    = ""     /*เลขที่บัตรประชาชน     */                                                                
   wf_txt7            = ""                     wf_dgender5  = ""     /*เพศ                   */                                                                
   wf_txt8            = ""                     wf_dbirth5   = ""     /*วันเกิด               */                                                                
   wf_txt9            = ""                     wf_doccup5   = ""     /*ชื่ออาชีพ             */                                                                
   wf_txt10           = ""                     wf_ddriveno5 = ""     /*เลขที่ใบอนุญาตขับขี่  */                                                                
   wf_memo1           = ""                     wf_drivexp5  = ""     /*วันที่ใบอนุญาต หมดอายุ*/                                                                
   wf_memo2           = ""                     wf_dlevel5   = ""     /*ระดับพฤติกรรมการขับขี่*/                                                                
   wf_memo3           = ""                     wf_battno    = ""     /*เลขที่แบตเตอรี่ */                                                                      
   wf_memo4           = ""                     wf_battyr    = ""     /*ปีแบตฯ   */                                                                             
   wf_memo5           = ""                     wf_battprice = ""     /*ราคาแบตฯ */                                                                             
   wf_memo6           = ""                     wf_battsi    = ""      /* ทุนแบตฯ */ 
   wf_memo7           = ""                     wf_battrate   = ""     /*Rate     */                                                               
   wf_memo8           = ""                     wf_battprm   = ""     /*Premium  */                                                                             
   wf_memo9           = ""                     wf_chargno   = ""     /*เลขที่เครื่องชาร์จ*/                                                                    
   wf_memo10          = ""                     wf_chargsi   = ""     /*ราคาเครื่องชาร์จ  */                                                                    
   wf_accdata1        = ""                     wf_chargrate = ""     /*Rate     */                                                                             
   wf_accdata2        = ""                     wf_chargprm  = ""     /*Premium */                                                                              
   wf_accdata3        = ""                     wf_dconsen1 = ""                           
   wf_accdata4        = ""                     wf_dconsen2 = ""  
   wf_accdata5        = ""                     wf_dconsen3 = ""  
   wf_accdata6        = ""                     wf_dconsen4 = ""  
   wf_accdata7        = ""                     wf_dconsen5 = ""  
   wf_accdata8        = ""                     /* end : A67-0029*/ 
   wf_accdata9        = ""                      wf_31rate  = ""   /*A68-0044*/
   wf_accdata10       = ""                      wf_31prmt  = ""   /*A68-0044*/
   wf_compul          = ""
   wf_insref          = ""
   wf_instyp          = ""
   wf_inslang         = ""
   wf_tiname          = ""
   wf_insnam          = ""
   wf_lastname        = ""
   wf_icno            = ""
   wf_insbr           = ""
   wf_occup           = ""
   wf_addr            = ""
   wf_tambon          = ""
   wf_amper           = ""
   wf_country         = ""
   wf_post            = ""
   wf_provcod         = ""
   wf_distcod         = ""
   wf_sdistcod        = ""
   wf_ae              = ""
   wf_jtl             = ""
   wf_ts              = ""
   wf_gender          = ""
   wf_tele1           = ""
   wf_tele2           = ""
   wf_mail1           = ""
   wf_mail2           = ""
   wf_mail3           = ""
   wf_mail4           = ""
   wf_mail5           = ""
   wf_mail6           = ""
   wf_mail7           = ""
   wf_mail8           = ""
   wf_mail9           = ""
   wf_mail10          = ""
   wf_fax             = ""
   wf_lineID          = ""
   wf_name2           = ""
   wf_name3           = ""
   wf_benname         = ""
   wf_payercod        = ""
   wf_vatcode         = ""
   wf_instcod1        = ""
   wf_insttyp1        = ""
   wf_insttitle1      = ""
   wf_instname1       = ""
   wf_instlname1      = ""
   wf_instic1         = ""
   wf_instbr1         = ""
   wf_instaddr11      = ""
   wf_instaddr21      = ""
   wf_instaddr31      = ""
   wf_instaddr41      = ""
   wf_instpost1       = ""
   wf_instprovcod1    = ""
   wf_instdistcod1    = ""
   wf_instsdistcod1   = ""
   wf_instprm1        = ""
   wf_instrstp1       = ""
   wf_instrtax1       = ""
   wf_instcomm01      = ""
   wf_instcomm12      = ""
   wf_instcod2        = ""
   wf_insttyp2        = ""
   wf_insttitle2      = ""
   wf_instname2       = ""
   wf_instlname2      = ""
   wf_instic2         = ""
   wf_instbr2         = ""
   wf_instaddr12      = ""
   wf_instaddr22      = ""
   wf_instaddr32      = ""
   wf_instaddr42      = ""
   wf_instpost2       = ""
   wf_instprovcod2    = ""
   wf_instdistcod2    = ""
   wf_instsdistcod2   = ""
   wf_instprm2        = ""
   wf_instrstp2       = ""
   wf_instrtax2       = ""
   wf_instcomm02      = ""
   wf_instcomm22      = ""
   wf_instcod3        = ""
   wf_insttyp3        = ""
   wf_insttitle3      = ""
   wf_instname3       = ""
   wf_instlname3      = ""
   wf_instic3         = ""
   wf_instbr3         = ""
   wf_instaddr13      = ""
   wf_instaddr23      = ""
   wf_instaddr33      = ""
   wf_instaddr43      = ""
   wf_instpost3       = ""
   wf_instprovcod3    = ""
   wf_instdistcod3    = ""
   wf_instsdistcod3   = ""
   wf_instprm3        = ""
   wf_instrstp3       = ""
   wf_instrtax3       = ""
   wf_instcomm03      = ""
   wf_instcomm23      = ""
   wf_covcod          = ""
   wf_garage          = ""
   wf_special         = ""
   wf_inspec          = ""
   wf_class70         = ""
   wf_vehuse          = ""
   wf_redbook         = "" /*A65-0079*/
   wf_brand           = ""
   wf_model           = ""
   wf_submodel        = ""
   wf_caryear         = ""
   wf_chasno          = ""
   wf_eng             = ""
   wf_seat            = ""
   wf_engcc           = ""
   wf_weight          = ""
   wf_watt            = ""
   wf_body            = ""
   wf_type            = ""
   wf_re_year         = ""
   wf_vehreg          = ""
   wf_re_country      = ""
   wf_cargrp          = ""
   wf_colorcar        = ""
   wf_fule            = ""
   wf_drivnam         = ""
   wf_ntitle1         = ""
   wf_drivername1     = ""
   wf_dname2          = ""
   wf_dicno           = ""
   wf_dgender1        = ""
   wf_dbirth          = ""
   wf_doccup          = ""
   wf_ddriveno        = ""
   wf_ntitle2         = ""
   wf_drivername2     = ""
   wf_ddname1         = ""
   wf_ddicno          = ""
   wf_dgender2        = ""
   wf_ddbirth         = ""
   wf_ddoccup         = ""
   wf_dddriveno       = ""
   wf_baseplus        = ""
   wf_siplus          = ""
   wf_rs10            = ""
   wf_comper          = ""
   wf_comacc          = ""
   wf_deductpd        = ""
   wf_DOD             = ""
   wf_dod1            = ""  /*A65-0079*/
   wf_DPD             = ""
   wf_tpfire          = ""
   wf_NO_411          = ""
   wf_ac2             = ""
   wf_NO_412          = ""
   wf_NO_413          = ""
   wf_ac6             = ""
   wf_NO_414          = ""
   wf_NO_42           = ""
   wf_NO_43           = ""
   wf_base            = ""
   wf_unname          = ""
   wf_nname           = ""
   wf_tpbi            = ""
   wf_tpbiocc         = ""  /*A65-0079*/
   wf_tppd            = ""
   wf_dodamt          = "" /*A65-0079*/
   wf_dod1amt         = "" /*A65-0079*/
   wf_dpdamt          = "" /*A65-0079*/
   wf_ry412           = "" /*A65-0079*/
   wf_ry413           = "" /*A65-0079*/
   wf_ry414          = "" /*A65-0079*/
   wf_ry01            = ""
   wf_ry02            = ""
   wf_ry03            = ""
   wf_fleet           = ""
   wf_ncb             = ""
   wf_claim           = ""
   wf_dspc            = ""
   wf_cctv            = ""
   wf_dstf            = ""
   wf_fleetprem       = ""
   wf_ncbprem         = ""
   wf_clprem          = ""
   wf_dspcprem        = ""
   wf_cctvprem        = ""
   wf_dstfprem        = ""
   wf_premt           = ""
   wf_rstp_t          = ""
   wf_rtax_t          = ""
   wf_comper70        = ""
   wf_comprem70       = ""
   wf_agco70          = ""
   wf_comco_per70     = ""
   wf_comco_prem70    = ""
   /* ไม่เก็บไปใช้ */
   wf_dgpackge        = ""
   wf_danger1         = ""
   wf_danger2         = ""
   wf_dgsi            = ""
   wf_dgrate          = ""
   wf_dgfeet          = ""
   wf_dgncb           = ""
   wf_dgdisc          = ""
   wf_dgwdisc         = ""
   wf_dgatt           = ""
   wf_dgfeetprm       = ""
   wf_dgncbprm        = ""
   wf_dgdiscprm       = ""
   wf_dgWdiscprm      = ""
   wf_dgprem          = ""
   wf_dgrstp_t        = ""
   wf_dgrtax_t        = ""
   wf_dgcomper        = ""
   wf_dgcomprem       = ""
   /* end :ไม่เก็บไปใช้*/
   wf_cltxt           = ""
   wf_clamount        = ""
   wf_faultno         = ""
   wf_faultprm        = ""
   wf_goodno          = ""
   wf_goodprm         = ""
   wf_loss            = ""
   /* 72 ไม่เก็บไปใช้ */
   wf_compolusory     = ""
   wf_barcode         = ""
   wf_class72         = ""
   wf_dstf72          = ""
   wf_dstfprem72      = ""
   wf_premt72         = ""
   wf_rstp_t72        = ""
   wf_rtax_t72        = ""
   wf_comper72        = ""
   wf_comprem72       = ""
   /* end : 72 ไม่เก็บไปใช้ */
   wf_instot          = 0 .
   

ASSIGN nv_instcod       = ""     nv_instaddr1     = ""         
       nv_insttyp       = ""     nv_instaddr2     = "" 
       nv_insttitle     = ""     nv_instaddr3     = "" 
       nv_instname      = ""     nv_instaddr4     = "" 
       nv_instlname     = ""     nv_instpost      = "" 
       nv_instic        = ""     nv_instprovcod   = "" 
       nv_instbr        = ""     nv_instdistcod   = "" 
       n_insref      = ""        nv_instsdistcod  = "" 
       nv_messagein  = ""        n_check       = "" 
       nv_usrid      = ""        nv_insref     = "" 
       nv_transfer   = NO        putchr        = "" 
       nv_typ        = ""        putchr1       = "" 
       nv_usrid      = SUBSTRING(USERID(LDBNAME(1)),3,4) 
       nv_transfer   = YES.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_initrenew C-Win 
PROCEDURE proc_initrenew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

ASSIGN  
    re_comdat         = ""                                                     
    re_expdat         = "" 
    re_tiname         = ""
    re_insnam         = ""
    re_lastname       = ""
    re_name2          = ""
    re_name3          = ""
    re_n_addr1        = ""
    re_n_addr2        = ""
    re_n_addr3        = ""
    re_n_addr4        = ""
    re_post           = ""
    re_provcod        = ""
    re_distcod        = ""
    re_sdistcod       = ""
    re_firstdat       = ""
    re_class          = ""                           
    re_moddes         = ""                           
    re_yrmanu         = ""                           
    re_seats          = ""                           
    re_vehuse         = ""                           
    re_covcod         = ""                         
    re_garage         = ""                         
    re_vehreg         = ""                            
    re_cha_no         = ""                            
    re_eng_no         = ""                                      
    re_uom1_v         = ""                                         
    re_uom2_v         = ""                                                    
    re_uom5_v         = ""                                                    
    re_si             = ""                                                    
    re_baseprm        = 0                                                     
    re_41             = 0                                         
    re_42             = 0                           
    re_43             = 0                           
    re_seat41         = 0                                         
    re_dedod          = 0                             
    re_addod          = 0                             
    re_dedpd          = 0                             
    re_flet_per       = ""                            
    re_ncbper         = ""                            
    re_dss_per        = ""                            
    re_stf_per        = 0                             
    re_cl_per         = 0                             
    re_bennam1        = ""  
    re_branch         = ""
    re_insref         = ""
    re_agent          = ""
    re_producer       = ""
    re_delercode      = ""
    re_fincode        = ""
    re_payercod       = ""
    re_vatcode        = ""
    re_cargrp         = ""
    re_premt          = 0
    re_adj            = "" 
    re_rencnt         = 0
    re_comment        = "" 
    re_driver         = ""
    re_acctxt         = ""
    re_prmtdriv       = 0
    re_chkmemo        = ""
    re_chktxt         = ""
    re_chkdriv        = "" 
    re_comm           = 0    /*A64-0257*/
    re_base3          = 0 .  /*A64-0257*/                     
                                                      

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_insnam C-Win 
PROCEDURE proc_insnam :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/***********************/
ASSIGN  
    n_insref      = ""  
    nv_messagein  = ""
    nv_usrid      = ""
    nv_transfer   = NO
    n_check       = ""
    nv_insref     = ""
    putchr        = "" 
    putchr1       = ""
    nv_typ        = ""
    nv_usrid      = SUBSTRING(USERID(LDBNAME(1)),3,4) 
    nv_transfer   = YES.

FIND LAST sicsyac.xmm600 USE-INDEX  xmm60033 WHERE
   /* (sicsyac.xmm600.NAME      = TRIM(impdata_fil.insnam) + " " + trim(impdata_fil.lastname)) OR */ /*A64-0257*/
    (sicsyac.xmm600.firstname = TRIM(impdata_fil.insnam)    AND
    sicsyac.xmm600.lastname   = TRIM(impdata_fil.lastname)) AND 
    sicsyac.xmm600.homebr     = TRIM(impdata_fil.n_branch)  AND 
    sicsyac.xmm600.clicod     = "IN"  EXCLUSIVE-LOCK NO-ERROR NO-WAIT.    /* A56-0047 add check  sicsyac.xmm600.clicod   = "IN"*/
IF NOT AVAILABLE sicsyac.xmm600 THEN DO: 
    IF n_insref = "" THEN DO:
        ASSIGN  n_check   = ""      nv_insref = "".
        nv_typ = IF impdata_fil.instyp = "C" THEN "Cs" ELSE "0s"  .
        RUN proc_insno. 
        IF n_check <> "" THEN DO: 
            ASSIGN nv_transfer = NO
                nv_insref   = "".
            RETURN.
        END.
        IF nv_insref <> "" THEN DO:
            loop_runningins:                /*Check Insured  */
            REPEAT:
                FIND sicsyac.xmm600 USE-INDEX xmm60001 WHERE
                    sicsyac.xmm600.acno = CAPS(nv_insref)  NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL sicsyac.xmm600 THEN DO:
                    RUN proc_insno .
                    IF n_check <> "" THEN DO: 
                        ASSIGN nv_transfer = NO
                            nv_insref   = "".
                        RETURN.
                    END.
                END.
                ELSE LEAVE loop_runningins.
            END.
        END.
        IF nv_insref <> "" THEN CREATE sicsyac.xmm600.
        ELSE DO:
            ASSIGN impdata_fil.pass = "N"  
                impdata_fil.comment = impdata_fil.comment + "| รหัสลูกค้าเป็นค่าว่างไม่สามารถนำเข้าระบบได้ค่ะ" 
                impdata_fil.OK_GEN  = "N"
                nv_transfer = NO.
        END.    /**/
    END.
    n_insref = nv_insref.
END.
ELSE DO:
    IF sicsyac.xmm600.acno <> "" THEN DO:   /* กรณีพบ */
        ASSIGN
            nv_insref                = trim(sicsyac.xmm600.acno) 
            n_insref                 = caps(trim(nv_insref)) 
            nv_transfer              = NO 
            sicsyac.xmm600.acno_typ  = IF impdata_fil.instyp = "C" THEN "CO" ELSE "PR"  
            sicsyac.xmm600.ntitle    = TRIM(impdata_fil.tiname)      /*Title for Name Mr/Mrs/etc*/
            sicsyac.xmm600.fname     = ""                        /*First Name*/
            sicsyac.xmm600.firstname = TRIM(impdata_fil.insnam)
            sicsyac.xmm600.lastname  = TRIM(impdata_fil.lastname)
            sicsyac.xmm600.name      = TRIM(impdata_fil.insnam) + " " + trim(impdata_fil.lastname)      /*Name Line 1*/
            sicsyac.xmm600.abname    = TRIM(impdata_fil.insnam) + " " + trim(impdata_fil.lastname)      /*Abbreviated Name*/
            sicsyac.xmm600.sex       = TRIM(impdata_fil.gender)
            sicsyac.xmm600.icno      = TRIM(impdata_fil.ICNO)              /*IC No.*/           /*--Crate by Amparat C. A51-0071--*/
            sicsyac.xmm600.addr1     = TRIM(impdata_fil.addr)              /*Address line 1*/
            sicsyac.xmm600.addr2     = TRIM(impdata_fil.tambon)                                /*Address line 2*/
            sicsyac.xmm600.addr3     = TRIM(impdata_fil.amper)                                 /*Address line 3*/
            sicsyac.xmm600.addr4     = TRIM(impdata_fil.country)
            sicsyac.xmm600.postcd    = TRIM(impdata_fil.post)
            sicsyac.xmm600.codeaddr1 = trim(impdata_fil.provcod)
            sicsyac.xmm600.codeaddr2 = trim(impdata_fil.distcod)
            sicsyac.xmm600.codeaddr3 = trim(impdata_fil.sdistcod)
            sicsyac.xmm600.coderef1  = trim(impdata_fil.jpae)   /* งาน Japanes */
            sicsyac.xmm600.coderef2  = trim(impdata_fil.jpjtl)  /* งาน Japanes */
            sicsyac.xmm600.coderef3  = trim(impdata_fil.jpts)   /* งาน Japanes */
            sicsyac.xmm600.tel[1]    = trim(impdata_fil.tele1)   
            sicsyac.xmm600.tel[2]    = trim(impdata_fil.tele2)   
            sicsyac.xmm600.email[1]  = trim(impdata_fil.mail1)   
            sicsyac.xmm600.email[2]  = trim(impdata_fil.mail2)   
            sicsyac.xmm600.email[3]  = trim(impdata_fil.mail3)   
            sicsyac.xmm600.email[4]  = trim(impdata_fil.mail4)   
            sicsyac.xmm600.email[5]  = trim(impdata_fil.mail5)   
            sicsyac.xmm600.email[6]  = trim(impdata_fil.mail6)   
            sicsyac.xmm600.email[7]  = trim(impdata_fil.mail7)   
            sicsyac.xmm600.email[8]  = trim(impdata_fil.mail8)   
            sicsyac.xmm600.email[9]  = trim(impdata_fil.mail9)   
            sicsyac.xmm600.email[10] = trim(impdata_fil.mail10)  
            sicsyac.xmm600.fax       = trim(impdata_fil.fax)     
            sicsyac.xmm600.lineid    = trim(impdata_fil.lineID)  
            sicsyac.xmm600.homebr    = TRIM(impdata_fil.n_branch)      /*Home branch*/
            sicsyac.xmm600.anlyc5    = IF nv_typ = "Cs" THEN TRIM(impdata_fil.insbr) ELSE ""  
            sicsyac.xmm600.opened    = TODAY
            sicsyac.xmm600.chgpol    = YES                       /*Allow N & A change on pol.Y/N*/
            sicsyac.xmm600.entdat    = TODAY                     /*Entry date*/
            sicsyac.xmm600.enttim    = STRING(TIME,"HH:MM:SS")   /*Entry time*/
            sicsyac.xmm600.usrid     = nv_usrid 
            sicsyac.xmm600.dtyp20    = "" 
            sicsyac.xmm600.dval20    = "".
       IF n_chkvat = YES THEN DO:
            RUN proc_insnamvat . /*A65-0043*/
           /* comment by : A65-0043...
           FIND LAST impinst_fil WHERE impinst_fil.policyno = impdata_fil.policyno AND impinst_fil.instot = impdata_fil.instot AND 
                                 impinst_fil.instname1 <> "" NO-LOCK NO-ERROR .
           IF AVAIL impinst_fil THEN DO:
            ASSIGN /*sicsyac.xmm600.acno       =   instcod1*/
                   sicsyac.xmm600.nbr_insure =   impinst_fil.instbr1
                   sicsyac.xmm600.ntitle    =   impinst_fil.insttitle1
                   sicsyac.xmm600.nfirstName =   impinst_fil.instname1   
                   sicsyac.xmm600.nlastname  =   impinst_fil.instlname1     
                   sicsyac.xmm600.nphone     =   TRIM(impinst_fil.instname1) + " " +  TRIM(impinst_fil.instlname1) 
                   sicsyac.xmm600.nicno      =   impinst_fil.instic1   
                   sicsyac.xmm600.naddr1     =   impinst_fil.instaddr11        
                   sicsyac.xmm600.naddr2     =   impinst_fil.instaddr21        
                   sicsyac.xmm600.naddr3     =   impinst_fil.instaddr31    
                   sicsyac.xmm600.naddr4     =   impinst_fil.instaddr41    
                   sicsyac.xmm600.npostcd    =   impinst_fil.instpost1  .
           END.  ...end A65-0043 ....*/
       END.
    END.
END.

IF nv_transfer = YES AND nv_insref <>  ""  THEN DO:     
    ASSIGN  
        sicsyac.xmm600.acno_typ  = IF impdata_fil.instyp = "C" THEN "CO" ELSE "PR" 
        sicsyac.xmm600.acno      = nv_insref                 /*Account no*/
        sicsyac.xmm600.gpstcs    = nv_insref                 /*Group A/C for statistics*/
        sicsyac.xmm600.gpage     = ""                        /*Group A/C for ageing*/
        sicsyac.xmm600.gpstmt    = ""                        /*Group A/C for Statement*/
        sicsyac.xmm600.or1ref    = ""                        /*OR Agent 1 Ref. No.*/
        sicsyac.xmm600.or2ref    = ""                        /*OR Agent 2 Ref. No.*/
        sicsyac.xmm600.or1com    = 0                         /*OR Agent 1 Comm. %*/
        sicsyac.xmm600.or2com    = 0                         /*OR Agent 2 Comm. %*/
        sicsyac.xmm600.or1gn     = "G"                       /*OR Agent 1 Gross/Net*/
        sicsyac.xmm600.or2gn     = "G"                       /*OR Agent 2 Gross/Net*/
        sicsyac.xmm600.ntitle    = TRIM(impdata_fil.tiname)      /*Title for Name Mr/Mrs/etc*/
        sicsyac.xmm600.fname     = ""                        /*First Name*/
        sicsyac.xmm600.name      = TRIM(impdata_fil.insnam) + " " + trim(impdata_fil.lastname)     /*Name Line 1*/
        sicsyac.xmm600.abname    = TRIM(impdata_fil.insnam) + " " + trim(impdata_fil.lastname)      /*Abbreviated Name*/
        sicsyac.xmm600.firstname = TRIM(impdata_fil.insnam)
        sicsyac.xmm600.lastname  = TRIM(impdata_fil.lastname)
        sicsyac.xmm600.icno      = TRIM(impdata_fil.ICNO)        /*IC No.*/     
        sicsyac.xmm600.sex       = TRIM(impdata_fil.gender)
        sicsyac.xmm600.addr1     = TRIM(impdata_fil.addr )  /*Address line 1*/
        sicsyac.xmm600.addr2     = TRIM(impdata_fil.tambon)                     /*Address line 2*/
        sicsyac.xmm600.addr3     = TRIM(impdata_fil.amper)                      /*Address line 3*/
        sicsyac.xmm600.addr4     = TRIM(impdata_fil.country)                    /*Address line 4*/
        sicsyac.xmm600.postcd    = TRIM(impdata_fil.post)                        /*Postal Code*/
        sicsyac.xmm600.codeaddr1 = trim(impdata_fil.provcod)
        sicsyac.xmm600.codeaddr2 = trim(impdata_fil.distcod)
        sicsyac.xmm600.codeaddr3 = trim(impdata_fil.sdistcod)
        sicsyac.xmm600.coderef1  = trim(impdata_fil.jpae)   /* งาน Japanes */
        sicsyac.xmm600.coderef2  = trim(impdata_fil.jpjtl)  /* งาน Japanes */
        sicsyac.xmm600.coderef3  = trim(impdata_fil.jpts)   /* งาน Japanes */
        sicsyac.xmm600.tel[1]    = trim(impdata_fil.tele1)   
        sicsyac.xmm600.tel[2]    = trim(impdata_fil.tele2)   
        sicsyac.xmm600.email[1]  = trim(impdata_fil.mail1)   
        sicsyac.xmm600.email[2]  = trim(impdata_fil.mail2)   
        sicsyac.xmm600.email[3]  = trim(impdata_fil.mail3)   
        sicsyac.xmm600.email[4]  = trim(impdata_fil.mail4)   
        sicsyac.xmm600.email[5]  = trim(impdata_fil.mail5)   
        sicsyac.xmm600.email[6]  = trim(impdata_fil.mail6)   
        sicsyac.xmm600.email[7]  = trim(impdata_fil.mail7)   
        sicsyac.xmm600.email[8]  = trim(impdata_fil.mail8)   
        sicsyac.xmm600.email[9]  = trim(impdata_fil.mail9)   
        sicsyac.xmm600.email[10] = trim(impdata_fil.mail10)  
        sicsyac.xmm600.fax       = trim(impdata_fil.fax)     
        sicsyac.xmm600.lineid    = trim(impdata_fil.lineID)  
        sicsyac.xmm600.clicod   = "IN"                      /*Client Type Code*/
        sicsyac.xmm600.acccod   = "IN"                      /*Account type code*/
        sicsyac.xmm600.relate   = ""                        /*Related A/C for RI Claims*/
        sicsyac.xmm600.notes1   = ""                        /*Notes line 1*/
        sicsyac.xmm600.notes2   = ""                        /*Notes line 2*/
        sicsyac.xmm600.homebr   = TRIM(impdata_fil.n_branch)      /*Home branch*/
        sicsyac.xmm600.opened   = TODAY                     /*Date A/C opened*/
        sicsyac.xmm600.prindr   = 1                         /*No. to print Dr/Cr N., default*/
        sicsyac.xmm600.langug   = TRIM(impdata_fil.inslang)     /*Language Code*/
        sicsyac.xmm600.cshdat   = ?                         /*Cash terms wef date*/
        sicsyac.xmm600.legal    = ""                        /*Legal action pending/closed*/
        sicsyac.xmm600.stattp   = "I"                       /*Statement type I/B/N*/
        sicsyac.xmm600.autoap   = NO                        /*Automatic cash matching*/
        sicsyac.xmm600.ltcurr   = "BHT"                     /*Credit limit currency*/
        sicsyac.xmm600.ltamt    = 0                         /*Credit limit amount*/
        sicsyac.xmm600.exec     = ""                        /*Executive responsible*/
        sicsyac.xmm600.cntry    = "TH"                      /*Country code*/
        sicsyac.xmm600.phone    = ""                        /*Phone no.*/
        sicsyac.xmm600.closed   = ?                         /*Date A/C closed*/
        sicsyac.xmm600.crper    = 0                         /*Credit period*/
        sicsyac.xmm600.pvfeq    = 0                         /*PV frequency/Type code*/
        sicsyac.xmm600.comtab   = 1                         /*Commission table no*/
        sicsyac.xmm600.chgpol   = YES                       /*Allow N & A change on pol.Y/N*/
        sicsyac.xmm600.entdat   = TODAY                     /*Entry date*/
        sicsyac.xmm600.enttim   = STRING(TIME,"HH:MM:SS")   /*Entry time*/
        sicsyac.xmm600.usrid    = nv_usrid                 /*Userid*/
        sicsyac.xmm600.regagt   = ""                       /*Registered agent code*/
        sicsyac.xmm600.agtreg   = ""                       /*Agents Registration/Licence No*/
        sicsyac.xmm600.debtyn   = YES                      /*Permit debtor trans Y/N*/
        sicsyac.xmm600.crcon    = NO                       /*Credit Control Report*/
        sicsyac.xmm600.muldeb   = NO                       /*Multiple Debtors Acc.*/
        sicsyac.xmm600.styp20   = ""                       /*Statistic Type Codes (4 x 20)*/
        sicsyac.xmm600.sval20   = ""                       /*Statistic Value Codes (4 x 20)*/
        sicsyac.xmm600.dtyp20   = ""                       /*Type of Date Codes (2 X 20)*/
        sicsyac.xmm600.dval20   = ""                       /*Date Values (8 X 20)*/
        sicsyac.xmm600.iblack   = ""                       /*Insured Black List Code*/
        sicsyac.xmm600.oldic    = ""                       /*Old IC No.*/
        sicsyac.xmm600.cardno   = ""                       /*Credit Card Account No.*/
        sicsyac.xmm600.cshcrd   = ""                       /*Cash(C)/Credit(R) Agent*/
        sicsyac.xmm600.naddr1   = ""                       /*New address line 1*/
        sicsyac.xmm600.gstreg   = ""                       /*GST Registration No.*/
        sicsyac.xmm600.naddr2   = ""                       /*New address line 2*/
        sicsyac.xmm600.fax      = ""                       /*Fax No.*/
        sicsyac.xmm600.naddr3   = ""                       /*New address line 3*/
        sicsyac.xmm600.telex    = ""                       /*Telex No.*/
        sicsyac.xmm600.naddr4   = ""                       /*New address line 4*/
        sicsyac.xmm600.name2    = ""                       /*Name Line 2*/
        sicsyac.xmm600.npostcd  = ""                       /*New postal code*/
        sicsyac.xmm600.name3    = ""                       /*Name Line 3*/
        sicsyac.xmm600.nphone   = ""                       /*New phone no.*/    
        sicsyac.xmm600.nachg    = YES                      /*Change N&A on Renewal/Endt*/
        sicsyac.xmm600.regdate  = ?                        /*Agents registration Date*/
        sicsyac.xmm600.alevel   = 0                        /*Agency Level*/
        sicsyac.xmm600.taxno    = ""                       /*Agent tax no.*/
        sicsyac.xmm600.anlyc1   = ""                       /*Analysis Code 1*/
        sicsyac.xmm600.taxdate  = ?                        /*Agent tax date*/
        sicsyac.xmm600.anlyc5   = IF nv_typ = "Cs" THEN TRIM(impdata_fil.insbr) ELSE ""
        sicsyac.xmm600.dtyp20   = ""
        sicsyac.xmm600.dval20   = ""   
         /* vat ชมพู : A65-0043 */
        sicsyac.xmm600.nbr_insure = ""
        sicsyac.xmm600.nntitle    = ""
        sicsyac.xmm600.nfirstName = ""
        sicsyac.xmm600.nlastname  = ""
        sicsyac.xmm600.nicno      = "".
       /* end vat ชมพู : A65-0043 */
       IF n_chkvat = YES THEN DO:
           RUN proc_insnamvat . /*A65-0043 */
          /* comment by : A65-0043...
          FIND LAST impinst_fil WHERE impinst_fil.policyno = impdata_fil.policyno AND impinst_fil.instot = impdata_fil.instot AND 
                                impinst_fil.instname1 <> "" NO-LOCK NO-ERROR .
          IF AVAIL impinst_fil THEN DO:
           ASSIGN /*sicsyac.xmm600.acno       =   instcod1*/
                  sicsyac.xmm600.nbr_insure =   impinst_fil.instbr1
                  sicsyac.xmm600.ntitle     =   impinst_fil.insttitle1
                  sicsyac.xmm600.nfirstName =   impinst_fil.instname1   
                  sicsyac.xmm600.nlastname  =   impinst_fil.instlname1     
                  sicsyac.xmm600.nphone     =   TRIM(impinst_fil.instname1) + " " +  TRIM(impinst_fil.instlname1) 
                  sicsyac.xmm600.nicno      =   impinst_fil.instic1   
                  sicsyac.xmm600.naddr1     =   impinst_fil.instaddr11        
                  sicsyac.xmm600.naddr2     =   impinst_fil.instaddr21        
                  sicsyac.xmm600.naddr3     =   impinst_fil.instaddr31    
                  sicsyac.xmm600.naddr4     =   impinst_fil.instaddr41    
                  sicsyac.xmm600.npostcd    =   impinst_fil.instpost1  .
          END. ...end A65-0043...*/
       END.
END.
IF sicsyac.xmm600.acno <> "" THEN DO:              /*A55-0268 add chk nv_insref = "" */
    ASSIGN nv_insref = trim(sicsyac.xmm600.acno)
        nv_transfer  = YES.
    FIND sicsyac.xtm600 USE-INDEX xtm60001 WHERE sicsyac.xtm600.acno  = nv_insref  NO-ERROR NO-WAIT.
    IF NOT AVAILABLE sicsyac.xtm600 THEN DO:
        IF LOCKED sicsyac.xtm600 THEN DO:
            nv_transfer = NO.
            RETURN.
        END.
        ELSE DO:
            CREATE sicsyac.xtm600.
            nv_transfer  = YES.
        END.
    END.
    IF nv_transfer = YES THEN DO:
        ASSIGN
            sicsyac.xtm600.acno      = nv_insref                                          /*Account no.*/
            sicsyac.xtm600.ntitle    = TRIM(impdata_fil.tiname)                               /*Title*/
            sicsyac.xtm600.firstname = trim(impdata_fil.insnam)
            sicsyac.xtm600.lastname  = trim(impdata_fil.lastname)
            sicsyac.xtm600.name      = TRIM(impdata_fil.insnam) + " " + trim(impdata_fil.lastname)   /*Name of Insured Line 1*/
            sicsyac.xtm600.abname    = TRIM(impdata_fil.insnam) + " " + trim(impdata_fil.lastname)   /*Abbreviated Name*/
            sicsyac.xtm600.addr1     = TRIM(impdata_fil.addr)            /*address line 1*/
            sicsyac.xtm600.addr2     = TRIM(impdata_fil.tambon)                               /*address line 2*/
            sicsyac.xtm600.addr3     = TRIM(impdata_fil.amper)                                /*address line 3*/
            sicsyac.xtm600.addr4     = TRIM(impdata_fil.country)                              /*address line 4*/
            sicsyac.xtm600.post      = TRIM(impdata_fil.post)
            sicsyac.xtm600.name2     = ""                                                 /*Name of Insured Line 2*/ 
            sicsyac.xtm600.name3     = ""                                                 /*Name of Insured Line 3*/
            sicsyac.xtm600.fname     = "" .                                               /*First Name*/
    END.
END.
ASSIGN  impdata_fil.insref = nv_insref .

RELEASE sicsyac.xtm600.
RELEASE sicsyac.xmm600.
RELEASE sicsyac.xzm056.
/*
RETURN.
HIDE MESSAGE NO-PAUSE.*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_insnamvat C-Win 
PROCEDURE proc_insnamvat :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Add by A65-0043        
------------------------------------------------------------------------------*/
DO:
    FIND LAST impinst_fil WHERE impinst_fil.policyno = impdata_fil.policyno AND 
                          impinst_fil.instot   = impdata_fil.instot   AND 
                          impinst_fil.riskno   = impdata_fil.riskno AND /* A65-0043*/
                          impinst_fil.instname1 <> ""             AND 
                          impinst_fil.instname1 <> "Null" NO-LOCK NO-ERROR .
    IF AVAIL impinst_fil THEN DO:
    ASSIGN 
           sicsyac.xmm600.nbr_insure =  ""
           sicsyac.xmm600.nntitle    =  ""
           sicsyac.xmm600.nfirstName =  ""
           sicsyac.xmm600.nlastname  =  ""
           sicsyac.xmm600.nphone     =  ""
           sicsyac.xmm600.nicno      =  ""
           sicsyac.xmm600.naddr1     =  ""
           sicsyac.xmm600.naddr2     =  ""
           sicsyac.xmm600.naddr3     =  ""
           sicsyac.xmm600.naddr4     =  ""
           sicsyac.xmm600.npostcd    =  ""
           sicsyac.xmm600.anlyc1     =  "" 

           sicsyac.xmm600.nbr_insure =   impinst_fil.instbr1
           sicsyac.xmm600.nntitle    =   impinst_fil.insttitle1
           sicsyac.xmm600.nfirstName =   impinst_fil.instname1   
           sicsyac.xmm600.nlastname  =   impinst_fil.instlname1     
           sicsyac.xmm600.nphone     =   TRIM(impinst_fil.instname1) + " " +  TRIM(impinst_fil.instlname1) 
           sicsyac.xmm600.nicno      =   impinst_fil.instic1   
           sicsyac.xmm600.naddr1     =   impinst_fil.instaddr11        
           sicsyac.xmm600.naddr2     =   impinst_fil.instaddr21        
           sicsyac.xmm600.naddr3     =   impinst_fil.instaddr31    
           sicsyac.xmm600.naddr4     =   impinst_fil.instaddr41    
           sicsyac.xmm600.npostcd    =   impinst_fil.instpost1 
           SUBSTRING(sicsyac.xmm600.anlyc1,1,14) =  trim(impinst_fil.instic1)    /*A65-0043*/
           SUBSTRING(sicsyac.xmm600.anlyc1,20,5) =  TRIM(impinst_fil.instbr1).   /*A65-0043*/
    END.
    /* clear vat ชมพู: A65-0043 */
    FIND LAST impinst_fil WHERE impinst_fil.policyno  = impdata_fil.policyno AND 
                          impinst_fil.instot    = impdata_fil.instot   AND
                          impinst_fil.riskno    = impdata_fil.riskno  AND /* A65-0043*/
                          impinst_fil.instname1 = "Null" NO-LOCK NO-ERROR .
    IF AVAIL impinst_fil THEN DO:
        ASSIGN 
            sicsyac.xmm600.nbr_insure =  ""
            sicsyac.xmm600.nntitle    =  ""
            sicsyac.xmm600.nfirstName =  ""
            sicsyac.xmm600.nlastname  =  ""
            sicsyac.xmm600.nphone     =  ""
            sicsyac.xmm600.nicno      =  ""
            sicsyac.xmm600.naddr1     =  ""
            sicsyac.xmm600.naddr2     =  ""
            sicsyac.xmm600.naddr3     =  ""
            sicsyac.xmm600.naddr4     =  ""
            sicsyac.xmm600.npostcd    =  ""
            sicsyac.xmm600.anlyc1     =  "" .
    END.
    /* end : A65-0043 */ 

END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_insnam_inst C-Win 
PROCEDURE proc_insnam_inst :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    ASSIGN fi_process = "Check & Create data instament to XMM600..." + impdata_fil.policyno .
    DISP fi_process WITH FRAM fr_main.

    ASSIGN nv_instot = 0
           nv_instot = 1.
    DO WHILE nv_instot <= impdata_fil.instot :
        FIND LAST impinst_fil WHERE impinst_fil.policyno = impdata_fil.policyno AND 
             impinst_fil.riskno = impdata_fil.riskno AND /* A65-0043*/
             impinst_fil.instot = impdata_fil.instot NO-ERROR NO-WAIT  .
        IF AVAIL impinst_fil THEN DO:
           RUN proc_initdataex.
           RUN proc_insnam_inst2.
           IF nv_instcod <> "" THEN DO:
              FIND sicsyac.xmm600 USE-INDEX xmm60001 WHERE sicsyac.xmm600.acno = trim(nv_instcod) /*AND nv_instname = ""*/ /*A65-0043*/  NO-LOCK NO-ERROR .
              IF AVAIL xmm600 THEN DO: 
                  ASSIGN n_insref  = nv_instcod  
                         nv_insref = TRIM(nv_instcod)
                         nv_transfer = NO .
              END.
              ELSE nv_insref = "" .
           END.
           IF nv_insref = ""  THEN DO:
                FIND LAST sicsyac.xmm600 USE-INDEX  xmm60033 WHERE
                    /*(sicsyac.xmm600.NAME      = TRIM(nv_instname) + " " + trim(nv_instlname)) OR */ /*A65-0043*/
                    (sicsyac.xmm600.firstname = TRIM(nv_instname)    AND
                     sicsyac.xmm600.lastname  = TRIM(nv_instlname))  AND  
                     sicsyac.xmm600.homebr    = TRIM(impdata_fil.n_branch)  AND 
                     sicsyac.xmm600.clicod    = "IN"  EXCLUSIVE-LOCK NO-ERROR NO-WAIT.    /* A56-0047 add check  sicsyac.xmm600.clicod   = "IN"*/
                 IF NOT AVAILABLE sicsyac.xmm600 THEN DO: 
                     IF n_insref = "" THEN DO:
                         ASSIGN  n_check   = ""      nv_insref = "".
                         nv_typ = IF nv_insttyp = "C" THEN "Cs" ELSE "0s"  .
                         RUN proc_insno. 
                         IF n_check <> "" THEN DO: 
                             ASSIGN nv_transfer = NO
                                 nv_insref   = "".
                             RETURN.
                         END.
                         IF nv_insref <> "" THEN DO:
                             loop_runningins:                /*Check Insured  */
                             REPEAT:
                                 FIND sicsyac.xmm600 USE-INDEX xmm60001 WHERE
                                     sicsyac.xmm600.acno = CAPS(nv_insref)  NO-LOCK NO-ERROR NO-WAIT.
                                 IF AVAIL sicsyac.xmm600 THEN DO:
                                     RUN proc_insno .
                                     IF n_check <> "" THEN DO: 
                                         ASSIGN nv_transfer = NO
                                             nv_insref   = "".
                                         RETURN.
                                     END.
                                 END.
                                 ELSE LEAVE loop_runningins.
                             END.
                         END.
                         IF nv_insref <> "" THEN CREATE sicsyac.xmm600.
                         ELSE DO:
                             ASSIGN impdata_fil.pass = "N"  
                                 impdata_fil.comment = impdata_fil.comment + "| รหัสลูกค้าเป็นค่าว่างไม่สามารถนำเข้าระบบได้" 
                                 impdata_fil.OK_GEN  = "N"
                                 nv_transfer = NO.
                         END.    /**/
                     END.
                     n_insref = nv_insref.
                 END.
                 ELSE DO:
                     IF sicsyac.xmm600.acno <> "" THEN DO:   /* กรณีพบ */
                        IF nv_instot = 1 THEN ASSIGN impinst_fil.instcod1  = sicsyac.xmm600.acno .
                        IF nv_instot = 2 THEN ASSIGN impinst_fil.instcod2  = sicsyac.xmm600.acno .
                        IF nv_instot = 3 THEN ASSIGN impinst_fil.instcod3  = sicsyac.xmm600.acno .
                        nv_transfer = NO .
                     END.
                 END.
                 IF nv_transfer = YES AND nv_insref <>  "" THEN DO:     
                     ASSIGN  
                         sicsyac.xmm600.acno_typ  = IF nv_insttyp = "C" THEN "CO" ELSE "PR" 
                         sicsyac.xmm600.acno      = nv_insref                 /*Account no*/
                         sicsyac.xmm600.gpstcs    = nv_insref                 /*Group A/C for statistics*/
                         sicsyac.xmm600.gpage     = ""                        /*Group A/C for ageing*/
                         sicsyac.xmm600.gpstmt    = ""                        /*Group A/C for Statement*/
                         sicsyac.xmm600.or1ref    = ""                        /*OR Agent 1 Ref. No.*/
                         sicsyac.xmm600.or2ref    = ""                        /*OR Agent 2 Ref. No.*/
                         sicsyac.xmm600.or1com    = 0                         /*OR Agent 1 Comm. %*/
                         sicsyac.xmm600.or2com    = 0                         /*OR Agent 2 Comm. %*/
                         sicsyac.xmm600.or1gn     = "G"                       /*OR Agent 1 Gross/Net*/
                         sicsyac.xmm600.or2gn     = "G"                       /*OR Agent 2 Gross/Net*/
                         sicsyac.xmm600.ntitle    = TRIM(nv_insttitle)      /*Title for Name Mr/Mrs/etc*/
                         sicsyac.xmm600.fname     = ""                        /*First Name*/
                         sicsyac.xmm600.name      = TRIM(nv_instname) + " " + trim(nv_instlname)     /*Name Line 1*/
                         sicsyac.xmm600.abname    = ""                                /*Abbreviated Name*/
                         sicsyac.xmm600.firstname = TRIM(nv_instname)    
                         sicsyac.xmm600.lastname  = trim(nv_instlname)  
                         sicsyac.xmm600.icno      = TRIM(nv_instic)       /*IC No.*/     
                         sicsyac.xmm600.sex       = ""
                         sicsyac.xmm600.addr1     = TRIM(nv_instaddr1)   /*Address line 1*/
                         sicsyac.xmm600.addr2     = TRIM(nv_instaddr2)   /*Address line 2*/
                         sicsyac.xmm600.addr3     = TRIM(nv_instaddr3)   /*Address line 3*/
                         sicsyac.xmm600.addr4     = TRIM(nv_instaddr4)   /*Address line 4*/
                         sicsyac.xmm600.postcd    = TRIM(nv_instpost)    /*Postal Code*/
                         sicsyac.xmm600.codeaddr1 = trim(nv_instprovcod) 
                         sicsyac.xmm600.codeaddr2 = trim(nv_instdistcod) 
                         sicsyac.xmm600.codeaddr3 = trim(nv_instsdistcod)
                         sicsyac.xmm600.tel       = ""  
                         sicsyac.xmm600.email     = ""  
                         sicsyac.xmm600.fax       = ""  
                         sicsyac.xmm600.lineid    = ""  
                         sicsyac.xmm600.clicod   = "IN"                      /*Client Type Code*/
                         sicsyac.xmm600.acccod   = "IN"                      /*Account type code*/
                         sicsyac.xmm600.relate   = ""                        /*Related A/C for RI Claims*/
                         sicsyac.xmm600.notes1   = ""                        /*Notes line 1*/
                         sicsyac.xmm600.notes2   = ""                        /*Notes line 2*/
                         sicsyac.xmm600.homebr   = TRIM(impdata_fil.n_branch)    /*Home branch*/
                         sicsyac.xmm600.opened   = TODAY                     /*Date A/C opened*/
                         sicsyac.xmm600.prindr   = 1                         /*No. to print Dr/Cr N., default*/
                         sicsyac.xmm600.langug   =TRIM(impdata_fil.inslang)     /*Language Code*/
                         sicsyac.xmm600.cshdat   = ?                         /*Cash terms wef date*/
                         sicsyac.xmm600.legal    = ""                        /*Legal action pending/closed*/
                         sicsyac.xmm600.stattp   = "I"                       /*Statement type I/B/N*/
                         sicsyac.xmm600.autoap   = NO                        /*Automatic cash matching*/
                         sicsyac.xmm600.ltcurr   = "BHT"                     /*Credit limit currency*/
                         sicsyac.xmm600.ltamt    = 0                         /*Credit limit amount*/
                         sicsyac.xmm600.exec     = ""                        /*Executive responsible*/
                         sicsyac.xmm600.cntry    = "TH"                      /*Country code*/
                         sicsyac.xmm600.phone    = ""                        /*Phone no.*/
                         sicsyac.xmm600.closed   = ?                         /*Date A/C closed*/
                         sicsyac.xmm600.crper    = 0                         /*Credit period*/
                         sicsyac.xmm600.pvfeq    = 0                         /*PV frequency/Type code*/
                         sicsyac.xmm600.comtab   = 1                         /*Commission table no*/
                         sicsyac.xmm600.chgpol   = YES                       /*Allow N & A change on pol.Y/N*/
                         sicsyac.xmm600.entdat   = TODAY                     /*Entry date*/
                         sicsyac.xmm600.enttim   = STRING(TIME,"HH:MM:SS")   /*Entry time*/
                         sicsyac.xmm600.usrid    = nv_usrid                 /*Userid*/
                         sicsyac.xmm600.regagt   = ""                       /*Registered agent code*/
                         sicsyac.xmm600.agtreg   = ""                       /*Agents Registration/Licence No*/
                         sicsyac.xmm600.debtyn   = YES                      /*Permit debtor trans Y/N*/
                         sicsyac.xmm600.crcon    = NO                       /*Credit Control Report*/
                         sicsyac.xmm600.muldeb   = NO                       /*Multiple Debtors Acc.*/
                         sicsyac.xmm600.styp20   = ""                       /*Statistic Type Codes (4 x 20)*/
                         sicsyac.xmm600.sval20   = ""                       /*Statistic Value Codes (4 x 20)*/
                         sicsyac.xmm600.dtyp20   = ""                       /*Type of Date Codes (2 X 20)*/
                         sicsyac.xmm600.dval20   = ""                       /*Date Values (8 X 20)*/
                         sicsyac.xmm600.iblack   = ""                       /*Insured Black List Code*/
                         sicsyac.xmm600.oldic    = ""                       /*Old IC No.*/
                         sicsyac.xmm600.cardno   = ""                       /*Credit Card Account No.*/
                         sicsyac.xmm600.cshcrd   = ""                       /*Cash(C)/Credit(R) Agent*/
                         sicsyac.xmm600.naddr1   = ""                       /*New address line 1*/
                         sicsyac.xmm600.gstreg   = ""                       /*GST Registration No.*/
                         sicsyac.xmm600.naddr2   = ""                       /*New address line 2*/
                         sicsyac.xmm600.fax      = ""                       /*Fax No.*/
                         sicsyac.xmm600.naddr3   = ""                       /*New address line 3*/
                         sicsyac.xmm600.telex    = ""                       /*Telex No.*/
                         sicsyac.xmm600.naddr4   = ""                       /*New address line 4*/
                         sicsyac.xmm600.name2    = ""                       /*Name Line 2*/
                         sicsyac.xmm600.npostcd  = ""                       /*New postal code*/
                         sicsyac.xmm600.name3    = ""                       /*Name Line 3*/
                         sicsyac.xmm600.nphone   = ""                       /*New phone no.*/    
                         sicsyac.xmm600.nachg    = YES                      /*Change N&A on Renewal/Endt*/
                         sicsyac.xmm600.regdate  = ?                        /*Agents registration Date*/
                         sicsyac.xmm600.alevel   = 0                        /*Agency Level*/
                         sicsyac.xmm600.taxno    = ""                       /*Agent tax no.*/
                         sicsyac.xmm600.anlyc1   = ""                       /*Analysis Code 1*/
                         sicsyac.xmm600.taxdate  = ?                        /*Agent tax date*/
                         sicsyac.xmm600.anlyc5   = IF nv_typ = "Cs" THEN TRIM(nv_instbr) ELSE ""
                        /* sicsyac.xmm600.dtyp20   = IF impdata_fil.birthdat = "" THEN "" ELSE "DOB"
                         sicsyac.xmm600.dval20   = IF impdata_fil.birthdat = "" THEN ""
                                                   ELSE substr(TRIM(impdata_fil.birthdat),1,6) + 
                                                       STRING(deci(substr(TRIM(impdata_fil.birthdat),7,4)) + 543 ) */.    /*string(impdata_fil.brithday).*/
                 END.
                 IF sicsyac.xmm600.acno <> "" THEN DO:              /*A55-0268 add chk nv_insref = "" */
                     ASSIGN nv_insref    = trim(sicsyac.xmm600.acno)
                            nv_transfer  = YES.
                     FIND sicsyac.xtm600 USE-INDEX xtm60001 WHERE sicsyac.xtm600.acno  = nv_insref  NO-ERROR NO-WAIT.
                     IF NOT AVAILABLE sicsyac.xtm600 THEN DO:
                         IF LOCKED sicsyac.xtm600 THEN DO:
                             nv_transfer = NO.
                             RETURN.
                         END.
                         ELSE DO:
                             CREATE sicsyac.xtm600.
                             nv_transfer  = YES.
                         END.
                     END.
                     IF nv_transfer = YES THEN DO:
                         ASSIGN
                             sicsyac.xtm600.acno      = nv_insref                                     /*Account no.*/
                             sicsyac.xtm600.ntitle    = TRIM(nv_insttitle)                            /*Title*/
                             sicsyac.xtm600.firstname = TRIM(nv_instname)                             
                             sicsyac.xtm600.lastname  = trim(nv_instlname)                            
                             sicsyac.xtm600.name      = TRIM(nv_instname) + " " + trim(nv_instlname)  /*Name of Insured Line 1*/
                             sicsyac.xtm600.abname    = ""                                            /*Abbreviated Name*/
                             sicsyac.xtm600.addr1     = TRIM(nv_instaddr1)                            /*address line 1*/
                             sicsyac.xtm600.addr2     = TRIM(nv_instaddr2)                            /*address line 2*/
                             sicsyac.xtm600.addr3     = TRIM(nv_instaddr3)                            /*address line 3*/
                             sicsyac.xtm600.addr4     = TRIM(nv_instaddr4)                            /*address line 4*/
                             sicsyac.xtm600.post      = TRIM(nv_instpost)                             
                             sicsyac.xtm600.name2     = ""                                            /*Name of Insured Line 2*/ 
                             sicsyac.xtm600.name3     = ""                                            /*Name of Insured Line 3*/
                             sicsyac.xtm600.fname     = "" .                                          /*First Name*/
                     END.
                 END.
            IF nv_instot = 1 THEN ASSIGN impinst_fil.instcod1  = sicsyac.xmm600.acno.
            IF nv_instot = 2 THEN ASSIGN impinst_fil.instcod2  = sicsyac.xmm600.acno.
            IF nv_instot = 3 THEN ASSIGN impinst_fil.instcod3  = sicsyac.xmm600.acno.
           END. /* nv_insref = "" */
           /* add by : A65-0043  ระบุ instcode ในไฟล์ */
           ELSE DO:
               FIND sicsyac.xmm600 USE-INDEX xmm60001 WHERE sicsyac.xmm600.acno  = nv_insref  NO-ERROR NO-WAIT.
                IF AVAILABLE sicsyac.xmm600 THEN DO:
                 IF nv_instot = 1 AND nv_instaddr1 = "" AND nv_instaddr2 = "" THEN DO:
                   ASSIGN 
                     impinst_fil.instcod1     = sicsyac.xmm600.acno
                     impinst_fil.insttitle1   = sicsyac.xmm600.ntitle  
                     impinst_fil.instname1    = sicsyac.xmm600.firstname    
                     impinst_fil.instlname1   = sicsyac.xmm600.lastname     
                     impinst_fil.instaddr11   = sicsyac.xmm600.addr1    
                     impinst_fil.instaddr21   = sicsyac.xmm600.addr2    
                     impinst_fil.instaddr31   = sicsyac.xmm600.addr3    
                     impinst_fil.instaddr41   = sicsyac.xmm600.addr4    
                     impinst_fil.instpost1    = sicsyac.xmm600.postcd   
                     impinst_fil.instic1      = sicsyac.xmm600.icno       
                     impinst_fil.instbr1      = IF sicsyac.xmm600.br_insure <> "" THEN sicsyac.xmm600.br_insure ELSE xmm600.anlyc5.
                 END.
                 IF nv_instot = 2 AND nv_instaddr1 = "" AND nv_instaddr2 = "" THEN DO:
                   ASSIGN 
                     impinst_fil.instcod2     = sicsyac.xmm600.acno
                     impinst_fil.insttitle2   = sicsyac.xmm600.ntitle  
                     impinst_fil.instname2    = sicsyac.xmm600.firstname    
                     impinst_fil.instlname2   = sicsyac.xmm600.lastname     
                     impinst_fil.instaddr12   = sicsyac.xmm600.addr1    
                     impinst_fil.instaddr22   = sicsyac.xmm600.addr2    
                     impinst_fil.instaddr32   = sicsyac.xmm600.addr3    
                     impinst_fil.instaddr42   = sicsyac.xmm600.addr4    
                     impinst_fil.instpost2    = sicsyac.xmm600.postcd   
                     impinst_fil.instic2      = sicsyac.xmm600.icno       
                     impinst_fil.instbr2      = IF sicsyac.xmm600.br_insure <> "" THEN sicsyac.xmm600.br_insure ELSE xmm600.anlyc5.
                 END.
                 IF nv_instot = 3 AND nv_instaddr1 = "" AND nv_instaddr2 = "" THEN DO:
                   ASSIGN 
                     impinst_fil.instcod3     = sicsyac.xmm600.acno
                     impinst_fil.insttitle3   = sicsyac.xmm600.ntitle  
                     impinst_fil.instname3    = sicsyac.xmm600.firstname    
                     impinst_fil.instlname3   = sicsyac.xmm600.lastname     
                     impinst_fil.instaddr13   = sicsyac.xmm600.addr1    
                     impinst_fil.instaddr23   = sicsyac.xmm600.addr2    
                     impinst_fil.instaddr33   = sicsyac.xmm600.addr3    
                     impinst_fil.instaddr43   = sicsyac.xmm600.addr4    
                     impinst_fil.instpost3    = sicsyac.xmm600.postcd   
                     impinst_fil.instic3      = sicsyac.xmm600.icno       
                     impinst_fil.instbr3      = IF sicsyac.xmm600.br_insure <> "" THEN sicsyac.xmm600.br_insure ELSE xmm600.anlyc5.
                 END.
               END.
           END.
           /* end : A65-0043 */
        END. /* if avail */
        nv_instot = nv_instot + 1.
    END.
END.
RELEASE sicsyac.xtm600.
RELEASE sicsyac.xmm600.
RELEASE sicsyac.xzm056.
/*
RETURN.
HIDE MESSAGE NO-PAUSE.*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_insnam_inst2 C-Win 
PROCEDURE proc_insnam_inst2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    IF nv_instot = 1  THEN DO:
       ASSIGN n_addr = ""    nv_chkerror = "" .
       IF trim(impinst_fil.instprovcod1) = "" OR trim(impinst_fil.instdistcod1) = ""  OR trim(impinst_fil.instsdistcod1) = "" THEN DO:
           n_addr = trim(impinst_fil.instaddr11 + " " + impinst_fil.instaddr21 + " " + impinst_fil.instaddr31 + " " + impinst_fil.instaddr41) .
           IF n_addr <> "" THEN RUN wgw/wgwchkaddr(INPUT n_addr ,OUTPUT impinst_fil.instprovcod1 ,OUTPUT impinst_fil.instdistcod1 ,OUTPUT impinst_fil.instsdistcod1,OUTPUT nv_chkerror).
           IF nv_chkerror <> ""  THEN impdata_fil.comment = impdata_fil.comment + "| installment1 " + nv_chkerror .
       END.
       ASSIGN   nv_instcod       = impinst_fil.instcod1      nv_instaddr1     = impinst_fil.instaddr11          
                nv_insttyp       = impinst_fil.insttyp1      nv_instaddr2     = impinst_fil.instaddr21   
                nv_insttitle     = impinst_fil.insttitle1    nv_instaddr3     = impinst_fil.instaddr31   
                nv_instname      = impinst_fil.instname1     nv_instaddr4     = impinst_fil.instaddr41   
                nv_instlname     = impinst_fil.instlname1    nv_instpost      = impinst_fil.instpost1    
                nv_instic        = impinst_fil.instic1       nv_instprovcod   = impinst_fil.instprovcod1 
                nv_instbr        = impinst_fil.instbr1       nv_instdistcod   = impinst_fil.instdistcod1 
                nv_instsdistcod  = impinst_fil.instsdistcod1  .
    END.
    IF nv_instot = 2   THEN DO:
       ASSIGN n_addr = ""    nv_chkerror = "" .
       IF trim(impinst_fil.instprovcod2) = "" OR trim(impinst_fil.instdistcod2) = ""  OR trim(impinst_fil.instsdistcod2) = "" THEN DO:
           n_addr = trim(impinst_fil.instaddr12 + " " + impinst_fil.instaddr22 + " " + impinst_fil.instaddr32 + " " + impinst_fil.instaddr42) .
           IF n_addr <> "" THEN RUN wgw/wgwchkaddr(INPUT n_addr ,OUTPUT impinst_fil.instprovcod2 ,OUTPUT impinst_fil.instdistcod2 ,OUTPUT impinst_fil.instsdistcod2,OUTPUT nv_chkerror) .
           IF nv_chkerror <> ""  THEN impdata_fil.comment = impdata_fil.comment + "| installment2 " + nv_chkerror .
       END.
       ASSIGN   nv_instcod       = impinst_fil.instcod2      nv_instaddr1     = impinst_fil.instaddr12          
                nv_insttyp       = impinst_fil.insttyp2      nv_instaddr2     = impinst_fil.instaddr22   
                nv_insttitle     = impinst_fil.insttitle2    nv_instaddr3     = impinst_fil.instaddr32   
                nv_instname      = impinst_fil.instname2     nv_instaddr4     = impinst_fil.instaddr42   
                nv_instlname     = impinst_fil.instlname2    nv_instpost      = impinst_fil.instpost2    
                nv_instic        = impinst_fil.instic2       nv_instprovcod   = impinst_fil.instprovcod2 
                nv_instbr        = impinst_fil.instbr2       nv_instdistcod   = impinst_fil.instdistcod2 
                nv_instsdistcod  = impinst_fil.instsdistcod2  .
    END.
    IF nv_instot = 3  THEN DO:
        ASSIGN n_addr = ""    nv_chkerror = "" .
       IF trim(impinst_fil.instprovcod3) = "" OR trim(impinst_fil.instdistcod3) = ""  OR trim(impinst_fil.instsdistcod3) = "" THEN DO:
           n_addr = trim(impinst_fil.instaddr13 + " " + impinst_fil.instaddr23 + " " + impinst_fil.instaddr33 + " " + impinst_fil.instaddr43) .
           IF n_addr <> "" THEN RUN wgw/wgwchkaddr(INPUT n_addr ,OUTPUT impinst_fil.instprovcod3 ,OUTPUT impinst_fil.instdistcod3 ,OUTPUT impinst_fil.instsdistcod3,OUTPUT nv_chkerror) .
           IF nv_chkerror <> ""  THEN impdata_fil.comment = impdata_fil.comment + "| installment3 " + nv_chkerror .
       END.
       ASSIGN   nv_instcod       = impinst_fil.instcod3      nv_instaddr1     = impinst_fil.instaddr13          
                nv_insttyp       = impinst_fil.insttyp3      nv_instaddr2     = impinst_fil.instaddr23   
                nv_insttitle     = impinst_fil.insttitle3    nv_instaddr3     = impinst_fil.instaddr33   
                nv_instname      = impinst_fil.instname3     nv_instaddr4     = impinst_fil.instaddr43   
                nv_instlname     = impinst_fil.instlname3    nv_instpost      = impinst_fil.instpost3    
                nv_instic        = impinst_fil.instic3       nv_instprovcod   = impinst_fil.instprovcod3 
                nv_instbr        = impinst_fil.instbr3       nv_instdistcod   = impinst_fil.instdistcod3 
                nv_instsdistcod  = impinst_fil.instsdistcod3  .
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_insno C-Win 
PROCEDURE proc_insno :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_search   AS LOGICAL INIT YES .
DEF VAR nv_lastno  AS INT INIT 0. 
DEF VAR nv_seqno   AS INT INIT 0.  
ASSIGN  nv_insref = "" .

FIND LAST sicsyac.xzm056 USE-INDEX xzm05601 WHERE 
    sicsyac.xzm056.seqtyp   =  nv_typ        AND
    sicsyac.xzm056.branch   =  TRIM(impdata_fil.n_branch)    NO-LOCK NO-ERROR .
IF NOT AVAIL xzm056 THEN DO :
    IF n_search = YES THEN DO:
        CREATE xzm056.
        ASSIGN sicsyac.xzm056.seqtyp =  nv_typ
            sicsyac.xzm056.branch    =  TRIM(impdata_fil.n_branch)
            sicsyac.xzm056.des       =  "Personal/Start"
            sicsyac.xzm056.lastno    =  1.                   
    END.
    ELSE DO:
        ASSIGN
            nv_insref = TRIM(impdata_fil.n_branch)  + String(1,"999999")
            nv_lastno = 1.
        RETURN.
    END.
END.
ASSIGN 
    nv_lastno = sicsyac.xzm056.lastno
    nv_seqno  = sicsyac.xzm056.seqno. 
IF n_check = "YES" THEN DO:   
    IF nv_typ = "0s" THEN DO: 
        IF LENGTH(TRIM(impdata_fil.n_branch)) = 2 THEN
            nv_insref = TRIM(impdata_fil.n_branch) + String(sicsyac.xzm056.lastno + 1 ,"99999999").
        ELSE DO:
            /*A56-0318....
            IF sicsyac.xzm056.lastno > 99999 THEN
                   nv_insref = "0" + TRIM(impdata_fil.n_branch) + STRING(sicsyac.xzm056.lastno + 1 ,"99999999").
            ELSE   nv_insref =       TRIM(impdata_fil.n_branch) + STRING(sicsyac.xzm056.lastno + 1 ,"999999").   A56-0318*/
            /*Add ... A56-0318*/
            IF sicsyac.xzm056.lastno > 99999 THEN DO:
                IF (TRIM(impdata_fil.n_branch) = "A") OR (TRIM(impdata_fil.n_branch) = "B") THEN DO:
                    nv_insref = "7" + TRIM(impdata_fil.n_branch) + STRING(sicsyac.xzm056.lastno,"99999999").
                END.
                ELSE nv_insref = "0" + TRIM(impdata_fil.n_branch) + STRING(sicsyac.xzm056.lastno,"99999999").
            END.
            ELSE DO:
                IF (TRIM(impdata_fil.n_branch) = "A") OR (TRIM(impdata_fil.n_branch) = "B") THEN DO:
                    nv_insref = "7" + TRIM(impdata_fil.n_branch) + STRING(sicsyac.xzm056.lastno,"99999999").
                END.
                ELSE nv_insref =       TRIM(impdata_fil.n_branch) + STRING(sicsyac.xzm056.lastno,"999999").
            END.    /*add ...A56-0318*/
        END.
        CREATE sicsyac.xzm056.
        ASSIGN
            sicsyac.xzm056.seqtyp    =  nv_typ
            sicsyac.xzm056.branch    =  TRIM(impdata_fil.n_branch)
            sicsyac.xzm056.des       =  "Personal/Start"
            sicsyac.xzm056.lastno    =  nv_lastno + 1
            sicsyac.xzm056.seqno     =  nv_seqno.   
    END.
    ELSE IF nv_typ = "Cs" THEN DO:
        IF LENGTH(TRIM(impdata_fil.n_branch)) = 2 THEN
            nv_insref = TRIM(impdata_fil.n_branch) + "C" + String(sicsyac.xzm056.lastno + 1 ,"9999999").
        ELSE DO:  
            IF sicsyac.xzm056.lastno > 99999 THEN
                nv_insref = "0" + TRIM(impdata_fil.n_branch) + "C" + String(sicsyac.xzm056.lastno + 1 ,"9999999").
            ELSE   nv_insref =       TRIM(impdata_fil.n_branch) + "C" + String(sicsyac.xzm056.lastno + 1 ,"99999").
        END.   
        CREATE sicsyac.xzm056.
        ASSIGN
            sicsyac.xzm056.seqtyp    =  nv_typ
            sicsyac.xzm056.branch    =  TRIM(impdata_fil.n_branch)
            sicsyac.xzm056.des       =  "Company/Start"
            sicsyac.xzm056.lastno    =  nv_lastno + 1
            sicsyac.xzm056.seqno     =  nv_seqno. 
    END.
    n_check = "".
END.
ELSE DO:
    IF nv_typ = "0s" THEN DO:
        IF LENGTH(TRIM(impdata_fil.n_branch)) = 2 THEN
            nv_insref = TRIM(impdata_fil.n_branch) + STRING(sicsyac.xzm056.lastno,"99999999").
        ELSE DO: 
            /*IF sicsyac.xzm056.lastno > 99999 THEN
                nv_insref = "0" + TRIM(impdata_fil.n_branch) + STRING(sicsyac.xzm056.lastno,"99999999").
            ELSE nv_insref =       TRIM(impdata_fil.n_branch) + STRING(sicsyac.xzm056.lastno,"999999").*/
            /*Add ... A56-0318*/
            IF sicsyac.xzm056.lastno > 99999 THEN DO:
                IF (TRIM(impdata_fil.n_branch) = "A") OR (TRIM(impdata_fil.n_branch) = "B") THEN DO:
                    nv_insref = "7" + TRIM(impdata_fil.n_branch) + STRING(sicsyac.xzm056.lastno,"99999999").
                END.
                ELSE nv_insref = "0" + TRIM(impdata_fil.n_branch) + STRING(sicsyac.xzm056.lastno,"99999999").
            END.
            ELSE DO:
                IF (TRIM(impdata_fil.n_branch) = "A") OR (TRIM(impdata_fil.n_branch) = "B") THEN DO:
                    nv_insref = "7" + TRIM(impdata_fil.n_branch) + STRING(sicsyac.xzm056.lastno,"99999999").
                END.
                ELSE nv_insref =       TRIM(impdata_fil.n_branch) + STRING(sicsyac.xzm056.lastno,"999999").
            END.    /*add ...A56-0318*/
        END.
    END.
    ELSE DO:
        IF LENGTH(TRIM(impdata_fil.n_branch)) = 2 THEN
            nv_insref = TRIM(impdata_fil.n_branch) + "C" + String(sicsyac.xzm056.lastno,"9999999").
        ELSE DO:  
            IF sicsyac.xzm056.lastno > 99999 THEN
                nv_insref = "0" + TRIM(impdata_fil.n_branch) + "C" + String(sicsyac.xzm056.lastno,"9999999").
            ELSE
                nv_insref =       TRIM(impdata_fil.n_branch) + "C" + String(sicsyac.xzm056.lastno,"99999").
        END.
    END.   
END.
IF sicsyac.xzm056.lastno >  sicsyac.xzm056.seqno Then Do :
  /* MESSAGE  "Running Code = Last No. / Please, Update Insured Running Code." SKIP
        "รหัสลูกค้า ถึงหมายเลขสุดท้ายแล้ว / ยกเลิกการทำงานชั่วคราว"      SKIP
        "แล้วติดต่อผู้ตั้ง Code"  VIEW-AS ALERT-BOX. */
    n_check = "ERROR".
    RETURN. 
END.         /*lastno > seqno*/                       
ELSE DO :    /*lastno <= seqno */
    IF nv_typ = "0s" THEN DO:
        IF n_search = YES THEN DO:
            CREATE sicsyac.xzm056.
            ASSIGN
                sicsyac.xzm056.seqtyp    =  nv_typ
                sicsyac.xzm056.branch    =  TRIM(impdata_fil.n_branch)
                sicsyac.xzm056.des       =  "Personal/Start"
                sicsyac.xzm056.lastno    =  nv_lastno + 1
                sicsyac.xzm056.seqno     =  nv_seqno.   
        END.
    END.
    ELSE IF nv_typ = "Cs" THEN DO:
        IF n_search = YES THEN DO:
            CREATE sicsyac.xzm056.
            ASSIGN
                sicsyac.xzm056.seqtyp    =  nv_typ
                sicsyac.xzm056.branch    =  TRIM(impdata_fil.n_branch)
                sicsyac.xzm056.des       =  "Company/Start"
                sicsyac.xzm056.lastno    =  nv_lastno + 1
                sicsyac.xzm056.seqno     =  nv_seqno. 
        END.
    END.
END.        /*lastno <= seqno */  
RELEASE sicsyac.xzm056 .

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_instot C-Win 
PROCEDURE proc_instot :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*DEFINE        VAR s_recid1  AS RECID NO-UNDO.   /** uwm100 recid **/*/
/*DEFINE        VAR nv_cnt    AS INT.
DEFINE        VAR n_index   AS INTEGER.
DEFINE        VAR n_ttprem  LIKE sic_bran.uwm100.prem_t.
DEFINE        VAR n_ttcom1  LIKE sic_bran.uwm100.com1_t.
DEFINE        VAR n_ttcom2  LIKE sic_bran.uwm100.com2_t.
DEFINE        VAR n_ttrstp  LIKE sic_bran.uwm100.rstp_t.
DEFINE        VAR n_ttrfee  LIKE sic_bran.uwm100.rfee_t.
DEFINE        VAR n_ttrtax  LIKE sic_bran.uwm100.rtax_t.
DEFINE        VAR n_recid   AS RECID.
DEFINE        VAR nv_tmp_date AS DATE.
DEFINE        VAR nv_d0     AS INT.
DEFINE        VAR nv_y      AS INT.
DEFINE        VAR nv_m      AS INT.
DEFINE        VAR nv_d      AS INT.
DEFINE        VAR nv_dtable AS INT EXTENT 12
                INIT [31,28,31,30,31,30,31,31,30,31,30,31].
DEFINE        VAR n_ttpstp  LIKE sic_bran.uwm100.rstp_t.
DEFINE        VAR n_ttpfee  LIKE sic_bran.uwm100.rfee_t.
DEFINE        VAR n_ttptax  LIKE sic_bran.uwm100.rtax_t.

FIND sic_bran.uwm100   Where Recid(sic_bran.uwm100)  = s_recid1  no-error no-wait.
IF AVAILABLE sic_bran.uwm100  THEN DO:
  ASSIGN s_recid1               = RECID(sic_bran.uwm100)
    sic_bran.uwm100.instot = impdata_fil3.instot .
  FIND FIRST sic_bran.uwm101  USE-INDEX uwm10101 WHERE
    sic_bran.uwm101.policy = sic_bran.uwm100.policy  AND
    sic_bran.uwm101.rencnt = sic_bran.uwm100.rencnt  AND
    sic_bran.uwm101.endcnt = sic_bran.uwm100.endcnt  AND
    sic_bran.uwm101.bchyr  = nv_batchyr     AND
    sic_bran.uwm101.bchno  = nv_batchno     AND
    sic_bran.uwm101.bchcnt = nv_batcnt      NO-LOCK NO-ERROR NO-WAIT.
  IF AVAILABLE sic_bran.uwm101  THEN DO:
    FOR EACH sic_bran.uwm101  USE-INDEX uwm10101   WHERE
      sic_bran.uwm101.policy = sic_bran.uwm100.policy  AND
      sic_bran.uwm101.rencnt = sic_bran.uwm100.rencnt  AND
      sic_bran.uwm101.endcnt = sic_bran.uwm100.endcnt  AND
      sic_bran.uwm101.bchyr  = nv_batchyr     AND
      sic_bran.uwm101.bchno  = nv_batchno     AND
      sic_bran.uwm101.bchcnt = nv_batcnt:
        DELETE sic_bran.uwm101.
    END.    /* each uwm101 */
    RELEASE sic_bran.uwm101.
  END.     /* avail uwm101 */
  IF sic_bran.uwm100.instot > 1 THEN DO: 
    IF impdata_fil3.instot = 2 THEN DO:
        ASSIGN impdata_fil3.premt_re2 = STRING((TRUNCATE(((deci(impdata_fil3.premt_re2)  * 100 ) / 107.43),0)))
          impdata_fil3.premt_re1 = STRING(sic_bran.uwm100.prem_t - deci(impdata_fil3.premt_re2)).
    END.
    ELSE DO:
      ASSIGN 
          impdata_fil3.premt_re3 = STRING((TRUNCATE(((deci(impdata_fil3.premt_re3)  * 100 ) / 107.43),0)))
          impdata_fil3.premt_re2 = STRING((TRUNCATE(((deci(impdata_fil3.premt_re2)  * 100 ) / 107.43),0)))
          impdata_fil3.premt_re1 = STRING(sic_bran.uwm100.prem_t - deci(impdata_fil3.premt_re2) - deci(impdata_fil3.premt_re3)).
    END.
    DO transaction:
        FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 exclusive-lock NO-ERROR.
    END.
    FIND sicsyac.xmm031 USE-INDEX xmm03101 WHERE
        sicsyac.xmm031.poltyp = sic_bran.uwm100.poltyp NO-LOCK NO-ERROR.
    Do transaction:
        FIND sic_bran.uwm101 USE-INDEX uwm10101 WHERE 
          sic_bran.uwm101.policy = sic_bran.uwm100.policy AND
          sic_bran.uwm101.rencnt = sic_bran.uwm100.rencnt AND 
          sic_bran.uwm101.endcnt = sic_bran.uwm100.endcnt AND
          sic_bran.uwm101.bchyr  = nv_batchyr     AND
          sic_bran.uwm101.bchno  = nv_batchno     AND
          sic_bran.uwm101.bchcnt = nv_batcnt      AND
          sic_bran.uwm101.instno = 1 exclusive-lock NO-ERROR.
    END.
    IF AVAILABLE sic_bran.uwm101 THEN DO transaction:
        nv_cnt = 0.
        FOR EACH sic_bran.uwm101 USE-INDEX uwm10101 WHERE 
          sic_bran.uwm101.policy = sic_bran.uwm100.policy AND
          sic_bran.uwm101.rencnt = sic_bran.uwm100.rencnt AND 
          sic_bran.uwm101.endcnt = sic_bran.uwm100.endcnt AND 
          sic_bran.uwm101.bchyr  = nv_batchyr             AND
          sic_bran.uwm101.bchno  = nv_batchno             AND
          sic_bran.uwm101.bchcnt = nv_batcnt              no-lock:
          nv_cnt = nv_cnt + 1.
        END.
        IF nv_cnt = sic_bran.uwm100.instot THEN
          FIND sic_bran.uwm101 USE-INDEX uwm10101 WHERE 
            sic_bran.uwm101.policy = sic_bran.uwm100.policy AND
            sic_bran.uwm101.rencnt = sic_bran.uwm100.rencnt AND 
            sic_bran.uwm101.endcnt = sic_bran.uwm100.endcnt AND
            sic_bran.uwm101.bchyr  = nv_batchyr             AND
            sic_bran.uwm101.bchno  = nv_batchno             AND
            sic_bran.uwm101.bchcnt = nv_batcnt              AND
            sic_bran.uwm101.instno = 1 exclusive-lock NO-ERROR.
        ELSE DO:
            FOR EACH sic_bran.uwm101 USE-INDEX uwm10101 WHERE 
              sic_bran.uwm101.policy = sic_bran.uwm100.policy AND
              sic_bran.uwm101.rencnt = sic_bran.uwm100.rencnt AND 
              sic_bran.uwm101.endcnt = sic_bran.uwm100.endcnt AND
              sic_bran.uwm101.bchyr  = nv_batchyr             AND
              sic_bran.uwm101.bchno  = nv_batchno             AND
              sic_bran.uwm101.bchcnt = nv_batcnt    :
              DELETE sic_bran.uwm101.
              END.
              REPEAT n_index = 1 TO sic_bran.uwm100.instot:
                  CREATE sic_bran.uwm101.
                  ASSIGN sic_bran.uwm101.policy = sic_bran.uwm100.policy
                    sic_bran.uwm101.rencnt = sic_bran.uwm100.rencnt
                    sic_bran.uwm101.endcnt = sic_bran.uwm100.endcnt
                    sic_bran.uwm101.bchyr  = nv_batchyr           
                    sic_bran.uwm101.bchno  = nv_batchno            
                    sic_bran.uwm101.bchcnt = nv_batcnt 
                    sic_bran.uwm101.instno = n_index
                    /*sic_bran.uwm101.prem_i = sic_bran.uwm100.prem_t / sic_bran.uwm100.instot*/
                    sic_bran.uwm101.prem_i =  IF      n_index = 1 THEN deci(impdata_fil3.premt_re1)
                                              ELSE IF n_index = 2 THEN deci(impdata_fil3.premt_re2)
                                              ELSE deci(impdata_fil3.premt_re3)
                    sic_bran.uwm101.com1_i = sic_bran.uwm100.com1_t / sic_bran.uwm100.instot
                    sic_bran.uwm101.com2_i = sic_bran.uwm100.com2_t / sic_bran.uwm100.instot
                    sic_bran.uwm101.rstp_i = sic_bran.uwm100.rstp_t / sic_bran.uwm100.instot
                    sic_bran.uwm101.rfee_i = sic_bran.uwm100.rfee_t / sic_bran.uwm100.instot
                    sic_bran.uwm101.rtax_i = sic_bran.uwm100.rtax_t / sic_bran.uwm100.instot
                    n_ttprem = n_ttprem + sic_bran.uwm101.prem_i
                    n_ttcom1 = n_ttcom1 + sic_bran.uwm101.com1_i
                    n_ttcom2 = n_ttcom2 + sic_bran.uwm101.com2_i
                    n_ttrstp = n_ttrstp + sic_bran.uwm101.rstp_i
                    n_ttrfee = n_ttrfee + sic_bran.uwm101.rfee_i
                    n_ttrtax = n_ttrtax + sic_bran.uwm101.rtax_i
                    sic_bran.uwm101.desc_i = IF      n_index = 1 THEN impdata_fil3.companyre1
                                             ELSE IF n_index = 2 THEN impdata_fil3.companyre2
                                                                 ELSE impdata_fil3.companyre3
                    sic_bran.uwm101.trty1i = ""
                    sic_bran.uwm101.docnoi = "".
                  IF n_index = 1 THEN DO:
                      ASSIGN n_recid                = RECID(sic_bran.uwm101)
                          sic_bran.uwm101.pstp_i = sic_bran.uwm100.pstp
                          sic_bran.uwm101.pfee_i = sic_bran.uwm100.pfee
                          sic_bran.uwm101.ptax_i = sic_bran.uwm100.ptax.
                  END.
                  ELSE DO:
                      ASSIGN sic_bran.uwm101.pstp_i  = 0
                          sic_bran.uwm101.pfee_i  = 0
                          sic_bran.uwm101.ptax_i  = 0.
                  END.
                  IF sicsyac.xmm031.insdef = "C" OR sicsyac.xmm031.insdef = "T" THEN DO:
                      IF n_index = 1 THEN DO:
                          IF sicsyac.xmm031.insdef = "C" THEN 
                               sic_bran.uwm101.duedat = sic_bran.uwm100.comdat.
                          ELSE sic_bran.uwm101.duedat = sic_bran.uwm100.trndat.
                               nv_tmp_date = sic_bran.uwm101.duedat.
                               nv_d0 = DAY(nv_tmp_date).
                      END.
                      ELSE DO:
                          IF  sic_bran.uwm100.instot = 3 OR sic_bran.uwm100.instot = 4  OR
                              sic_bran.uwm100.instot = 6 OR sic_bran.uwm100.instot = 12 THEN DO:
                              nv_y = YEAR(nv_tmp_date).
                              nv_m = MONTH(nv_tmp_date).
                              nv_d = DAY(nv_tmp_date).
                              nv_m = nv_m + 12 / sic_bran.uwm100.instot.
                              IF nv_m > 12 THEN DO:
                                  nv_y = nv_y + 1.
                                  nv_m = nv_m - 12.
                              END.
                              IF nv_m <> 2 THEN nv_d = MIN(nv_d0,nv_dtable[nv_m]).
                              ELSE IF nv_y MOD 4 = 0 
                                  THEN  nv_d = MIN(nv_d0,29).
                              ELSE  nv_d = MIN(nv_d0,nv_dtable[nv_m]).
                                    nv_tmp_date = DATE(nv_m,nv_d,nv_y).
                                    sic_bran.uwm101.duedat = nv_tmp_date.
                          END.
                      END.
                  END.
              END.
              FIND FIRST sic_bran.uwm101 WHERE RECID(sic_bran.uwm101) = n_recid.
              IF AVAILABLE sic_bran.uwm101 THEN DO:
                  sic_bran.uwm101.prem_i = sic_bran.uwm101.prem_i + (sic_bran.uwm100.prem_t - n_ttprem).
                  sic_bran.uwm101.com1_i = sic_bran.uwm101.com1_i + (sic_bran.uwm100.com1_t - n_ttcom1).
                  sic_bran.uwm101.com2_i = sic_bran.uwm101.com2_i + (sic_bran.uwm100.com2_t - n_ttcom2).
                  sic_bran.uwm101.rstp_i = sic_bran.uwm101.rstp_i + (sic_bran.uwm100.rstp_t - n_ttrstp).
                  sic_bran.uwm101.rfee_i = sic_bran.uwm101.rfee_i + (sic_bran.uwm100.rfee_t - n_ttrfee).
                  sic_bran.uwm101.rtax_i = sic_bran.uwm101.rtax_i + (sic_bran.uwm100.rtax_t - n_ttrtax).
              END.
          END.
      END.
      ELSE DO transaction:
          REPEAT n_index = 1 TO sic_bran.uwm100.instot:
              CREATE sic_bran.uwm101.
              ASSIGN sic_bran.uwm101.policy = sic_bran.uwm100.policy
                sic_bran.uwm101.rencnt = sic_bran.uwm100.rencnt
                sic_bran.uwm101.endcnt = sic_bran.uwm100.endcnt
                sic_bran.uwm101.bchyr  = nv_batchyr         
                sic_bran.uwm101.bchno  = nv_batchno            
                sic_bran.uwm101.bchcnt = nv_batcnt 
                sic_bran.uwm101.instno = n_index.
              ASSIGN  sic_bran.uwm101.com1_i = IF      n_index = 1 THEN deci(impdata_fil3.premt_re1) * nv_com1p_ins / 100
                                               ELSE IF n_index = 2 THEN deci(impdata_fil3.premt_re2) * nv_com1p_ins / 100
                                                                   ELSE deci(impdata_fil3.premt_re3)
                  sic_bran.uwm101.com2_i = sic_bran.uwm100.com2_t / ( sic_bran.uwm100.instot - 1 ) 
                  sic_bran.uwm101.prem_i = IF      n_index = 1 THEN deci(impdata_fil3.premt_re1)
                                           ELSE IF n_index = 2 THEN deci(impdata_fil3.premt_re2)
                                                               ELSE deci(impdata_fil3.premt_re3)
                  /*sic_bran.uwm101.com1_i = 0
                  sic_bran.uwm101.com2_i = 0*/
                  /*sic_bran.uwm101.rstp_i = sic_bran.uwm100.rstp_t / ( sic_bran.uwm100.instot - 1 )*/
                  sic_bran.uwm101.rfee_i = sic_bran.uwm100.rfee_t / ( sic_bran.uwm100.instot - 1 )
                  /*sic_bran.uwm101.rtax_i = sic_bran.uwm100.rtax_t / ( sic_bran.uwm100.instot - 1 )*/  
                  n_ttprem = n_ttprem + sic_bran.uwm101.prem_i
                  n_ttcom1 = n_ttcom1 + sic_bran.uwm101.com1_i
                  n_ttcom2 = n_ttcom2 + sic_bran.uwm101.com2_i
                  n_ttrstp = n_ttrstp + sic_bran.uwm101.rstp_i
                  n_ttrfee = n_ttrfee + sic_bran.uwm101.rfee_i
                  n_ttrtax = n_ttrtax + sic_bran.uwm101.rtax_i
                  sic_bran.uwm101.desc_i = IF      n_index = 1 THEN impdata_fil3.companyre1
                                           ELSE IF n_index = 2 THEN impdata_fil3.companyre2
                                                               ELSE impdata_fil3.companyre3
                  sic_bran.uwm101.trty1i = "" 
                  sic_bran.uwm101.docnoi = ""
                  n_recid       = RECID(sic_bran.uwm101).
              IF     n_index = 1 THEN 
                  ASSIGN nv_fi_rstp_t1  = Truncate(deci(impdata_fil3.premt_re1) * nv_fi_stamp_per_ins / 100,0) + 
                                          (IF (deci(impdata_fil3.premt_re1) * nv_fi_stamp_per_ins  / 100) - 
                                          Truncate(deci(impdata_fil3.premt_re1) * nv_fi_stamp_per_ins  / 100,0) > 0
                                          Then 1 Else 0)
                  sic_bran.uwm101.pstp_i = nv_fi_rstp_t1.
              ELSE IF n_index = 2 THEN  
                  ASSIGN nv_fi_rstp_t2   = Truncate(deci(impdata_fil3.premt_re2)  * nv_fi_stamp_per_ins / 100,0) + 
                                           (IF (deci(impdata_fil3.premt_re2)  * nv_fi_stamp_per_ins  / 100) - 
                                            Truncate(deci(impdata_fil3.premt_re2)  * nv_fi_stamp_per_ins  / 100,0) > 0
                                            Then 1 Else 0)
                  sic_bran.uwm101.pstp_i = nv_fi_rstp_t2.
              ELSE  
                  ASSIGN nv_fi_rstp_t3  =  Truncate(deci(impdata_fil3.premt_re3)  * nv_fi_stamp_per_ins / 100,0) +
                                           (IF (deci(impdata_fil3.premt_re3)  * nv_fi_stamp_per_ins  / 100)   - 
                                            Truncate(deci(impdata_fil3.premt_re3)  * nv_fi_stamp_per_ins  / 100,0) > 0
                                            Then 1 Else 0)
                  sic_bran.uwm101.pstp_i = nv_fi_rstp_t2.
              IF      n_index = 1 THEN 
               ASSIGN sic_bran.uwm101.ptax_i  =  (deci(impdata_fil3.premt_re1) + nv_fi_rstp_t1) * nv_fi_tax_per_ins / 100  .
              ELSE IF n_index = 2 THEN                                     
               ASSIGN sic_bran.uwm101.ptax_i  =  (deci(impdata_fil3.premt_re2) + nv_fi_rstp_t2) * nv_fi_tax_per_ins / 100  .
              ELSE    sic_bran.uwm101.ptax_i  =  (deci(impdata_fil3.premt_re3) + nv_fi_rstp_t2) * nv_fi_tax_per_ins / 100  .
              IF sicsyac.xmm031.insdef = "C" OR sicsyac.xmm031.insdef = "T" THEN DO:
                  IF sicsyac.xmm031.insdef = "C" THEN sic_bran.uwm101.duedat = sic_bran.uwm100.comdat.
                  ELSE sic_bran.uwm101.duedat = sic_bran.uwm100.trndat.
                  nv_tmp_date = sic_bran.uwm101.duedat.
                  nv_d0 = DAY(nv_tmp_date).
              END.
          END.
          FIND FIRST sic_bran.uwm101 WHERE RECID(sic_bran.uwm101) = n_recid.
          IF AVAILABLE sic_bran.uwm101 THEN DO:
              sic_bran.uwm101.prem_i = sic_bran.uwm101.prem_i + (sic_bran.uwm100.prem_t - n_ttprem).
              /*sic_bran.uwm101.com1_i = sic_bran.uwm101.com1_i + (sic_bran.uwm100.com1_t - n_ttcom1).  */
              sic_bran.uwm101.com2_i = sic_bran.uwm101.com2_i + (sic_bran.uwm100.com2_t - n_ttcom2).
              /*sic_bran.uwm101.rstp_i = sic_bran.uwm101.rstp_i + (sic_bran.uwm100.rstp_t - n_ttrstp).*/
              sic_bran.uwm101.rfee_i = sic_bran.uwm101.rfee_i + (sic_bran.uwm100.rfee_t - n_ttrfee).
              /*sic_bran.uwm101.rtax_i = sic_bran.uwm101.rtax_i + (sic_bran.uwm100.rtax_t - n_ttrtax).*/
          END.
      END.
      ASSIGN
        n_index  = 1
        n_ttprem = 0
        n_ttcom1 = 0
        n_ttcom2 = 0
        n_ttrstp = 0
        n_ttrfee = 0
        n_ttrtax = 0
        n_ttpstp = 0
        n_ttpfee = 0
        n_ttptax = 0
        nv_com1p_ins        = 0     
        nv_fi_tax_per_ins   = 0      
        nv_fi_stamp_per_ins = 0   . 
  END.                            
END.
release sic_bran.uwm101.   
release sic_bran.uwm101.  */ 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_instot1 C-Win 
PROCEDURE proc_instot1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/**  uwo10085.p - NEW POLICY ENTRY - INSTALMENTS  **/
DEFINE        VAR n_recid   AS RECID.                                       
DEFINE        VAR n_ttprem  LIKE sic_bran.uwm100.prem_t.                   
DEFINE        VAR n_ttcom1  LIKE sic_bran.uwm100.com1_t.                    
DEFINE        VAR n_ttcom2  LIKE sic_bran.uwm100.com2_t.
DEFINE        VAR n_ttcom3  LIKE sic_bran.uwm100.com2_t. /*A64-0355*/
DEFINE        VAR n_ttrstp  LIKE sic_bran.uwm100.rstp_t.                    
DEFINE        VAR n_ttrfee  LIKE sic_bran.uwm100.rfee_t.                    
DEFINE        VAR n_ttrtax  LIKE sic_bran.uwm100.rtax_t.                    
DEFINE        VAR n_ttpstp  LIKE sic_bran.uwm100.rstp_t.                    
DEFINE        VAR n_ttpfee  LIKE sic_bran.uwm100.rfee_t.                    
DEFINE        VAR n_ttptax  LIKE sic_bran.uwm100.rtax_t.                    
DEFINE        VAR n_index   AS INTEGER.                                    
DEFINE        VAR nv_d0     AS INT.                                         
DEFINE        VAR nv_tmp_date AS DATE.                                      
/*DEFINE  VAR s_recid1      AS RECID NO-UNDO.        /** uwm100 recid **/
DEFINE  VAR  nv_batchyr   AS INT FORMAT "9999"            INIT 2015.
DEFINE  VAR  nv_batcnt    AS INT FORMAT "99"              INIT 1.
DEFINE  VAR  nv_batchno   AS CHARACTER FORMAT "X(18)"     INIT "B3M00170M0044"  NO-UNDO.*/
DEF VAR nv_fi_rstp_t1       AS DECI INIT 0.
DEF VAR nv_fi_rstp_t2       AS DECI INIT 0.
DEF VAR nv_fi_rstp_t3       AS DECI INIT 0.
DEF VAR nv_com1p_ins1       AS DECI INIT 0.
DEF VAR nv_com1p_ins2       AS DECI INIT 0.
DEF VAR nv_com1p_ins3       AS DECI INIT 0.
DEF VAR nv_prem01           AS DECI INIT 0.
DEF VAR nv_prem02           AS DECI INIT 0.
DEF VAR nv_prem03           AS DECI INIT 0.

ASSIGN fi_process = "Create data instament to uwm101 ..." + impdata_fil.policyno .
DISP fi_process WITH FRAM fr_main.

FIND sic_bran.uwm100   Where Recid(sic_bran.uwm100)  = s_recid1 no-error no-wait.
IF AVAILABLE sic_bran.uwm100  THEN DO:
    ASSIGN 
        s_recid1 = RECID(sic_bran.uwm100)
        sic_bran.uwm100.instot = impdata_fil.instot  
        nv_fi_rstp_t1 = 0
        nv_fi_rstp_t2 = 0
        nv_fi_rstp_t3 = 0
        nv_com1p_ins1 = 0
        nv_com1p_ins2 = 0
        nv_com1p_ins3 = 0
        nv_prem01     = 0  
        nv_prem02     = 0  
        nv_prem03     = 0  .

    FIND LAST impinst_fil WHERE impinst_fil.policyno = sic_bran.uwm100.policy AND impinst_fil.instot = impdata_fil.instot NO-LOCK NO-ERROR .
    
        IF impinst_fil.instot = 2 THEN DO:
            ASSIGN 
                nv_prem02 = impinst_fil.instprm2      
                nv_prem01 = impinst_fil.instprm1.                               
        END.
        ELSE DO:
            ASSIGN 
                nv_prem03 = impinst_fil.instprm3
                nv_prem02 = impinst_fil.instprm2
                nv_prem01 = impinst_fil.instprm1 .
        END.
        
        IF nv_prem01 > 0 THEN 
            ASSIGN 
            nv_com1p_ins1 = impinst_fil.instcomm01
            nv_fi_rstp_t1 = impinst_fil.instrstp1.
        IF nv_prem02 > 0 THEN 
            ASSIGN 
            nv_com1p_ins2 = impinst_fil.instcomm02
            nv_fi_rstp_t2 = impinst_fil.instrstp2 .
        IF nv_prem03 > 0 THEN   
            ASSIGN 
            nv_com1p_ins3 = impinst_fil.instcomm03
            nv_fi_rstp_t3 = impinst_fil.instrstp3.
       
        FIND FIRST sic_bran.uwm101  USE-INDEX uwm10101 WHERE
            sic_bran.uwm101.policy = sic_bran.uwm100.policy  AND
            sic_bran.uwm101.rencnt = sic_bran.uwm100.rencnt  AND
            sic_bran.uwm101.endcnt = sic_bran.uwm100.endcnt  AND
            sic_bran.uwm101.bchyr  = nv_batchyr     AND
            sic_bran.uwm101.bchno  = nv_batchno     AND
            sic_bran.uwm101.bchcnt = nv_batcnt      NO-LOCK NO-ERROR NO-WAIT.
        IF AVAILABLE sic_bran.uwm101  THEN DO:
            FOR EACH sic_bran.uwm101  USE-INDEX uwm10101   WHERE
                sic_bran.uwm101.policy = sic_bran.uwm100.policy  AND
                sic_bran.uwm101.rencnt = sic_bran.uwm100.rencnt  AND
                sic_bran.uwm101.endcnt = sic_bran.uwm100.endcnt  AND
                sic_bran.uwm101.bchyr  = nv_batchyr     AND
                sic_bran.uwm101.bchno  = nv_batchno     AND
                sic_bran.uwm101.bchcnt = nv_batcnt:
                DELETE sic_bran.uwm101.
            END.  /* each uwm101 */
            RELEASE sic_bran.uwm101.
        END.       /* avail uwm101 */
        IF sic_bran.uwm100.instot > 1 THEN DO: 
            ASSIGN 
                n_ttprem = 0
                n_ttcom1 = 0
                n_ttcom2 = 0
                n_ttcom3 = 0
                n_ttpstp = 0
                n_ttpfee = 0
                n_ttptax = 0
                n_ttrstp = 0
                n_ttrfee = 0
                n_ttrtax = 0.
            DO transaction:
                FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 exclusive-lock NO-ERROR.
            END.
            FIND sicsyac.xmm031 USE-INDEX xmm03101 WHERE xmm031.poltyp = sic_bran.uwm100.poltyp NO-LOCK NO-ERROR.
            Do transaction:
                FIND sic_bran.uwm101 USE-INDEX uwm10101 WHERE 
                    sic_bran.uwm101.policy = sic_bran.uwm100.policy AND
                    sic_bran.uwm101.rencnt = sic_bran.uwm100.rencnt AND 
                    sic_bran.uwm101.endcnt = sic_bran.uwm100.endcnt AND
                    sic_bran.uwm101.bchyr  = nv_batchyr             AND
                    sic_bran.uwm101.bchno  = nv_batchno             AND
                    sic_bran.uwm101.bchcnt = nv_batcnt              AND
                    sic_bran.uwm101.instno = 1 exclusive-lock NO-ERROR.
            END.
            IF NOT AVAILABLE sic_bran.uwm101 THEN DO transaction:
                REPEAT n_index = 1 TO sic_bran.uwm100.instot:
                    CREATE sic_bran.uwm101.
                    ASSIGN 
                        sic_bran.uwm101.policy = sic_bran.uwm100.policy 
                        sic_bran.uwm101.rencnt = sic_bran.uwm100.rencnt 
                        sic_bran.uwm101.endcnt = sic_bran.uwm100.endcnt
                        sic_bran.uwm101.bchyr  = nv_batchyr        
                        sic_bran.uwm101.bchno  = nv_batchno            
                        sic_bran.uwm101.bchcnt = nv_batcnt  
                        sic_bran.uwm101.instno = n_index
                        sic_bran.uwm101.prem_i = IF      n_index = 1 THEN nv_prem01
                                                 ELSE IF n_index = 2 THEN nv_prem02
                                                                     ELSE nv_prem03
                        sic_bran.uwm101.com1_i = IF      n_index = 1 THEN nv_com1p_ins1 * ( -1 )
                                                 ELSE IF n_index = 2 THEN nv_com1p_ins2 * ( -1 )
                                                                     ELSE nv_com1p_ins3 * ( -1 )
                        /*sic_bran.uwm101.com2_i = IF      n_index = 1 THEN impinst_fil.instcomm12 * ( -1 )
                                                 ELSE IF n_index = 2 THEN impinst_fil.instcomm22 * ( -1 )
                                                                     ELSE impinst_fil.instcomm23 * ( -1 )*/ /*A64-0355*/
                        sic_bran.uwm101.com3_i = IF      n_index = 1 THEN impinst_fil.instcomm12 * ( -1 )
                                                 ELSE IF n_index = 2 THEN impinst_fil.instcomm22 * ( -1 )
                                                                     ELSE impinst_fil.instcomm23 * ( -1 ) /*A64-0355 comm co-broker 70 */

                        sic_bran.uwm101.rstp_i = IF      n_index = 1 THEN nv_fi_rstp_t1
                                                 ELSE IF n_index = 2 THEN nv_fi_rstp_t2
                                                 ELSE                     nv_fi_rstp_t3   
                        sic_bran.uwm101.rfee_i = 0.00
                        sic_bran.uwm101.rtax_i = IF      n_index = 1 THEN instrtax1
                                                 ELSE IF n_index = 2 THEN instrtax2
                                                                     ELSE instrtax3

                        n_ttprem               = n_ttprem + sic_bran.uwm101.prem_i 
                        n_ttcom1               = n_ttcom1 + sic_bran.uwm101.com1_i
                        /*n_ttcom2               = n_ttcom2 + sic_bran.uwm101.com2_i*/ /*A64-0355*/
                        n_ttcom3               = n_ttcom3 + sic_bran.uwm101.com3_i    /*A64-0355 comm co-broker 70*/
                        n_ttrstp               = n_ttrstp + sic_bran.uwm101.rstp_i
                        n_ttrfee               = n_ttrfee + sic_bran.uwm101.rfee_i
                        n_ttrtax               = n_ttrtax + sic_bran.uwm101.rtax_i
                        sic_bran.uwm101.desc_i = IF      n_index = 1 THEN impinst_fil.instcod1 + " " + 
                                                                          impinst_fil.insttitle1 + " " + impinst_fil.instname1 + " " + impinst_fil.instlname1
                                                 ELSE IF n_index = 2 THEN impinst_fil.instcod2 + " " + 
                                                                          impinst_fil.insttitle2 + " " + impinst_fil.instname2 + " " + impinst_fil.instlname2
                                                                     ELSE impinst_fil.instcod3 + " " + 
                                                                          impinst_fil.insttitle3 + " " + impinst_fil.instname3 + " " + impinst_fil.instlname3
                        sic_bran.uwm101.trty1i = ""
                        sic_bran.uwm101.docnoi = "".
                    IF n_index = 1 THEN DO:
                        ASSIGN 
                        n_recid                = RECID(sic_bran.uwm101) 
                        sic_bran.uwm101.pstp_i = sic_bran.uwm100.pstp 
                        sic_bran.uwm101.pfee_i = sic_bran.uwm100.pfee
                        sic_bran.uwm101.ptax_i = sic_bran.uwm100.ptax.
                    END.
                    ELSE DO:
                        ASSIGN 
                            sic_bran.uwm101.pstp_i  = 0 
                            sic_bran.uwm101.pfee_i  = 0
                            sic_bran.uwm101.ptax_i  = 0.
                    END.
                    IF xmm031.insdef = "C" OR xmm031.insdef = "T" THEN DO:
                        
                        IF xmm031.insdef = "C" THEN sic_bran.uwm101.duedat = sic_bran.uwm100.comdat.
                                ELSE uwm101.duedat = uwm100.trndat.
                                nv_tmp_date = uwm101.duedat.
                                nv_d0       = DAY(nv_tmp_date).
                    END.
                END.
                FIND FIRST sic_bran.uwm101 WHERE RECID(sic_bran.uwm101) = n_recid.
                IF AVAILABLE sic_bran.uwm101 THEN DO:
                    sic_bran.uwm101.prem_i = sic_bran.uwm101.prem_i + (sic_bran.uwm100.prem_t - n_ttprem).
                    sic_bran.uwm101.com1_i = sic_bran.uwm101.com1_i + (sic_bran.uwm100.com1_t - n_ttcom1).
                    sic_bran.uwm101.com2_i = sic_bran.uwm101.com2_i + (sic_bran.uwm100.com2_t - n_ttcom2).
                    sic_bran.uwm101.com3_i = sic_bran.uwm101.com3_i + (sic_bran.uwm100.com3_t - n_ttcom3). /*A64-0355*/
                    sic_bran.uwm101.rstp_i = sic_bran.uwm101.rstp_i + (sic_bran.uwm100.rstp_t - n_ttrstp).
                    sic_bran.uwm101.rfee_i = sic_bran.uwm101.rfee_i + (sic_bran.uwm100.rfee_t - n_ttrfee).
                    sic_bran.uwm101.rtax_i = sic_bran.uwm101.rtax_i + (sic_bran.uwm100.rtax_t - n_ttrtax).
                END.
            END.  /*else do: */
            DO transaction:
                FIND sic_bran.uwm101 USE-INDEX uwm10101 WHERE 
                    sic_bran.uwm101.policy = sic_bran.uwm100.policy AND
                    sic_bran.uwm101.rencnt = sic_bran.uwm100.rencnt AND 
                    sic_bran.uwm101.endcnt = sic_bran.uwm100.endcnt AND
                    sic_bran.uwm101.instno = 1  exclusive-lock NO-ERROR.
            END.  /* Transaction */

            IF n_ttprem <> sic_bran.uwm100.prem_t THEN DO:
                ASSIGN impdata_fil.comment = impdata_fil.comment + "|เบี้ยรวม Instament : " + string(n_ttprem)  + 
                       " ไม่เท่ากับเบี้ยสุทธิของ กธ. : " + STRING(sic_bran.uwm100.prem_t) .
            END.
            IF n_ttrstp <>  uwm100.rstp_t then do:
                ASSIGN impdata_fil.comment = impdata_fil.comment + "|เบี้ยอากรรวม Instament : " + string(n_ttrstp)  + 
                       " ไม่เท่ากับเบี้ยอากรของ กธ. : " + STRING(uwm100.rstp_t) .
            END.
            
            if n_ttrtax <>  uwm100.rtax_t then do: 
                ASSIGN impdata_fil.comment = impdata_fil.comment + "|เบี้ย Tax รวม Instament : " + string(n_ttrtax)  + 
                       " ไม่เท่ากับเบี้ย Tax ของ กธ. : " + STRING(uwm100.rtax_t) .
            END.


            ASSIGN 
                n_index  = 1 
                n_ttprem = 0 
                n_ttcom1 = 0
                n_ttcom2 = 0
                n_ttcom3 = 0  /*A64-0355*/
                n_ttrstp = 0 
                n_ttrfee = 0
                n_ttrtax = 0
                n_ttpstp = 0
                n_ttpfee = 0
                n_ttptax = 0 
                nv_fi_rstp_t1 = 0
                nv_fi_rstp_t2 = 0
                nv_fi_rstp_t3 = 0
                nv_com1p_ins1 = 0
                nv_com1p_ins2 = 0
                nv_com1p_ins3 = 0.
        END.  /* if */
END. /*End 100 */
RELEASE sic_bran.uwm101.
RELEASE sic_bran.uwm100.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_instot1-01 C-Win 
PROCEDURE proc_instot1-01 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/**  uwo10085.p - NEW POLICY ENTRY - INSTALMENTS  **/
/*
DEFINE        VAR n_recid   AS RECID.                                       
DEFINE        VAR n_ttprem  LIKE sic_bran.uwm100.prem_t.                   
DEFINE        VAR n_ttcom1  LIKE sic_bran.uwm100.com1_t.                    
DEFINE        VAR n_ttcom2  LIKE sic_bran.uwm100.com2_t.                    
DEFINE        VAR n_ttrstp  LIKE sic_bran.uwm100.rstp_t.                    
DEFINE        VAR n_ttrfee  LIKE sic_bran.uwm100.rfee_t.                    
DEFINE        VAR n_ttrtax  LIKE sic_bran.uwm100.rtax_t.                    
DEFINE        VAR n_ttpstp  LIKE sic_bran.uwm100.rstp_t.                    
DEFINE        VAR n_ttpfee  LIKE sic_bran.uwm100.rfee_t.                    
DEFINE        VAR n_ttptax  LIKE sic_bran.uwm100.rtax_t.                    
DEFINE        VAR n_index   AS INTEGER.                                    
DEFINE        VAR nv_d0     AS INT.                                         
DEFINE        VAR nv_tmp_date AS DATE.                                      
/*DEFINE  VAR s_recid1      AS RECID NO-UNDO.        /** uwm100 recid **/
DEFINE  VAR  nv_batchyr   AS INT FORMAT "9999"            INIT 2015.
DEFINE  VAR  nv_batcnt    AS INT FORMAT "99"              INIT 1.
DEFINE  VAR  nv_batchno   AS CHARACTER FORMAT "X(18)"     INIT "B3M00170M0044"  NO-UNDO.*/
DEF VAR nv_fi_rstp_t1       AS DECI INIT 0.
DEF VAR nv_fi_rstp_t2       AS DECI INIT 0.
DEF VAR nv_fi_rstp_t3       AS DECI INIT 0.
DEF VAR nv_com1p_ins1       AS DECI INIT 0.
DEF VAR nv_com1p_ins2       AS DECI INIT 0.
DEF VAR nv_com1p_ins3       AS DECI INIT 0.
DEF VAR nv_prem01           AS DECI INIT 0.
DEF VAR nv_prem02           AS DECI INIT 0.
DEF VAR nv_prem03           AS DECI INIT 0.

/*
DEF VAR nv_fi_tax_per_ins   AS DECI .
DEF VAR nv_fi_stamp_per_ins AS DECI .*/
/*
nv_com1p_ins       
nv_fi_tax_per_ins  
nv_fi_stamp_per_ins*/
/*FIND uwm100 WHERE            RECID(uwm100)           = s_recid1 exclusive-lock NO-ERROR.*/
FIND sic_bran.uwm100   Where Recid(sic_bran.uwm100)  = s_recid1 no-error no-wait.
/*FIND LAST  sic_bran.uwm100   Where 
    sic_bran.uwm100.policy = impdata_fil.policyno AND 
    sic_bran.uwm100.bchyr  = nv_batchyr       AND 
    sic_bran.uwm100.bchno  = nv_batchno       AND 
    sic_bran.uwm100.bchcnt = nv_batcnt        no-error no-wait.*/
IF AVAILABLE sic_bran.uwm100  THEN DO:
    ASSIGN 
        s_recid1 = RECID(sic_bran.uwm100)
        sic_bran.uwm100.instot = impdata_fil.instot  
        nv_fi_rstp_t1 = 0
        nv_fi_rstp_t2 = 0
        nv_fi_rstp_t3 = 0
        nv_com1p_ins1 = 0
        nv_com1p_ins2 = 0
        nv_com1p_ins3 = 0
        nv_prem01     = 0  
        nv_prem02     = 0  
        nv_prem03     = 0  .

    FIND LAST impinst_fil WHERE impinst_fil.policyno = sic_bran.uwm100.policy NO-LOCK NO-ERROR .
    
    IF impdata_fil3.instot = 2 THEN DO:
        ASSIGN 
            nv_prem02 = (TRUNCATE(((deci(impdata_fil3.premt_re2)  * 100 ) / 107.43),0))       
            nv_prem01 = sic_bran.uwm100.prem_t - nv_prem02.                               
    END.
    ELSE DO:
        ASSIGN 
            nv_prem03 = (TRUNCATE(((deci(impdata_fil3.premt_re3)  * 100 ) / 107.43),0))
            nv_prem02 = (TRUNCATE(((deci(impdata_fil3.premt_re2)  * 100 ) / 107.43),0))
            nv_prem01 = sic_bran.uwm100.prem_t - nv_prem02 - nv_prem03.
    END.

    IF nv_prem01 > 0 THEN 
        ASSIGN 
        nv_com1p_ins1 = (nv_prem01 * nv_com1p_ins ) / 100
        nv_fi_rstp_t1 = Truncate(nv_prem01 * nv_fi_stamp_per_ins  / 100,0)  + 
                        IF      (nv_prem01 * nv_fi_stamp_per_ins  / 100) -
                        Truncate(nv_prem01 * nv_fi_stamp_per_ins  / 100,0) > 0 Then 1 Else 0.
    IF nv_prem02 > 0 THEN 
        ASSIGN 
        nv_com1p_ins2 = (nv_prem02 * nv_com1p_ins ) / 100
        nv_fi_rstp_t2 = Truncate(nv_prem02 * nv_fi_stamp_per_ins / 100,0) + 
                            (IF (nv_prem02 * nv_fi_stamp_per_ins / 100) - 
                        Truncate(nv_prem02 * nv_fi_stamp_per_ins / 100,0) > 0 Then 1 Else 0 ).
    IF nv_prem03 > 0 THEN   
        ASSIGN 
        nv_com1p_ins3 = (nv_prem03 * nv_com1p_ins ) / 100
        nv_fi_rstp_t3 = Truncate(nv_prem03 * nv_fi_stamp_per_ins / 100,0) + 
                            (IF (nv_prem03 * nv_fi_stamp_per_ins / 100) - 
                        Truncate(nv_prem03 * nv_fi_stamp_per_ins / 100,0) > 0 Then 1 Else 0 ).

    FIND FIRST sic_bran.uwm101  USE-INDEX uwm10101 WHERE
        sic_bran.uwm101.policy = sic_bran.uwm100.policy  AND
        sic_bran.uwm101.rencnt = sic_bran.uwm100.rencnt  AND
        sic_bran.uwm101.endcnt = sic_bran.uwm100.endcnt  AND
        sic_bran.uwm101.bchyr  = nv_batchyr     AND
        sic_bran.uwm101.bchno  = nv_batchno     AND
        sic_bran.uwm101.bchcnt = nv_batcnt      NO-LOCK NO-ERROR NO-WAIT.
    IF AVAILABLE sic_bran.uwm101  THEN DO:
        FOR EACH sic_bran.uwm101  USE-INDEX uwm10101   WHERE
            sic_bran.uwm101.policy = sic_bran.uwm100.policy  AND
            sic_bran.uwm101.rencnt = sic_bran.uwm100.rencnt  AND
            sic_bran.uwm101.endcnt = sic_bran.uwm100.endcnt  AND
            sic_bran.uwm101.bchyr  = nv_batchyr     AND
            sic_bran.uwm101.bchno  = nv_batchno     AND
            sic_bran.uwm101.bchcnt = nv_batcnt:
            DELETE sic_bran.uwm101.
        END.  /* each uwm101 */
        RELEASE sic_bran.uwm101.
    END.       /* avail uwm101 */
    IF sic_bran.uwm100.instot > 1 THEN DO: 
        ASSIGN 
            n_ttprem = 0
            n_ttcom1 = 0
            n_ttcom2 = 0
            n_ttpstp = 0
            n_ttpfee = 0
            n_ttptax = 0
            n_ttrstp = 0
            n_ttrfee = 0
            n_ttrtax = 0.
        DO transaction:
            FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 exclusive-lock NO-ERROR.
        END.
        FIND sicsyac.xmm031 USE-INDEX xmm03101 WHERE xmm031.poltyp = sic_bran.uwm100.poltyp NO-LOCK NO-ERROR.
        Do transaction:
            FIND sic_bran.uwm101 USE-INDEX uwm10101 WHERE 
                sic_bran.uwm101.policy = sic_bran.uwm100.policy AND
                sic_bran.uwm101.rencnt = sic_bran.uwm100.rencnt AND 
                sic_bran.uwm101.endcnt = sic_bran.uwm100.endcnt AND
                sic_bran.uwm101.bchyr  = nv_batchyr             AND
                sic_bran.uwm101.bchno  = nv_batchno             AND
                sic_bran.uwm101.bchcnt = nv_batcnt              AND
                sic_bran.uwm101.instno = 1 exclusive-lock NO-ERROR.
        END.
        IF NOT AVAILABLE sic_bran.uwm101 THEN DO transaction:
            REPEAT n_index = 1 TO sic_bran.uwm100.instot:
                CREATE sic_bran.uwm101.
                ASSIGN 
                    sic_bran.uwm101.policy = sic_bran.uwm100.policy 
                    sic_bran.uwm101.rencnt = sic_bran.uwm100.rencnt 
                    sic_bran.uwm101.endcnt = sic_bran.uwm100.endcnt
                    sic_bran.uwm101.bchyr  = nv_batchyr        
                    sic_bran.uwm101.bchno  = nv_batchno            
                    sic_bran.uwm101.bchcnt = nv_batcnt  
                    sic_bran.uwm101.instno = n_index
                    sic_bran.uwm101.prem_i = IF      n_index = 1 THEN nv_prem01
                                             ELSE IF n_index = 2 THEN nv_prem02
                                                                 ELSE nv_prem03
                    sic_bran.uwm101.com1_i = IF      n_index = 1 THEN nv_com1p_ins1 * ( -1 )
                                             ELSE IF n_index = 2 THEN nv_com1p_ins2 * ( -1 )
                                                                 ELSE nv_com1p_ins3 * ( -1 )
                    sic_bran.uwm101.com2_i = 0.00
                    sic_bran.uwm101.rstp_i = IF      n_index = 1 THEN nv_fi_rstp_t1
                                             ELSE IF n_index = 2 THEN nv_fi_rstp_t2
                                             ELSE                     nv_fi_rstp_t3   
                    sic_bran.uwm101.rfee_i = 0.00
                    sic_bran.uwm101.rtax_i = IF      n_index = 1 THEN (nv_prem01 + nv_fi_rstp_t1) * nv_fi_tax_per_ins / 100
                                             ELSE IF n_index = 2 THEN (nv_prem02 + nv_fi_rstp_t2) * nv_fi_tax_per_ins / 100
                                                                 ELSE (nv_prem03 + nv_fi_rstp_t3) * nv_fi_tax_per_ins / 100
                    n_ttprem               = n_ttprem + sic_bran.uwm101.prem_i 
                    n_ttcom1               = n_ttcom1 + sic_bran.uwm101.com1_i
                    n_ttcom2               = n_ttcom2 + sic_bran.uwm101.com2_i
                    n_ttrstp               = n_ttrstp + sic_bran.uwm101.rstp_i
                    n_ttrfee               = n_ttrfee + sic_bran.uwm101.rfee_i
                    n_ttrtax               = n_ttrtax + sic_bran.uwm101.rtax_i
                    sic_bran.uwm101.desc_i = IF      n_index = 1 THEN impdata_fil3.companyre1
                                             ELSE IF n_index = 2 THEN impdata_fil3.companyre2
                                                                 ELSE impdata_fil3.companyre3
                    sic_bran.uwm101.trty1i = ""
                    sic_bran.uwm101.docnoi = "".
                IF n_index = 1 THEN DO:
                    ASSIGN 
                    n_recid                = RECID(sic_bran.uwm101) 
                    sic_bran.uwm101.pstp_i = sic_bran.uwm100.pstp 
                    sic_bran.uwm101.pfee_i = sic_bran.uwm100.pfee
                    sic_bran.uwm101.ptax_i = sic_bran.uwm100.ptax.
                END.
                ELSE DO:
                    ASSIGN 
                        sic_bran.uwm101.pstp_i  = 0 
                        sic_bran.uwm101.pfee_i  = 0
                        sic_bran.uwm101.ptax_i  = 0.
                END.
                IF xmm031.insdef = "C" OR xmm031.insdef = "T" THEN DO:
                    
                    IF xmm031.insdef = "C" THEN sic_bran.uwm101.duedat = sic_bran.uwm100.comdat.
                            ELSE uwm101.duedat = uwm100.trndat.
                            nv_tmp_date = uwm101.duedat.
                            nv_d0       = DAY(nv_tmp_date).
                END.
            END.
            FIND FIRST sic_bran.uwm101 WHERE RECID(sic_bran.uwm101) = n_recid.
            IF AVAILABLE sic_bran.uwm101 THEN DO:
                sic_bran.uwm101.prem_i = sic_bran.uwm101.prem_i + (sic_bran.uwm100.prem_t - n_ttprem).
                /*sic_bran.uwm101.com1_i = sic_bran.uwm101.com1_i + (sic_bran.uwm100.com1_t - n_ttcom1).*/
                sic_bran.uwm101.com2_i = sic_bran.uwm101.com2_i + (sic_bran.uwm100.com2_t - n_ttcom2).
                sic_bran.uwm101.rstp_i = sic_bran.uwm101.rstp_i + (sic_bran.uwm100.rstp_t - n_ttrstp).
                sic_bran.uwm101.rfee_i = sic_bran.uwm101.rfee_i + (sic_bran.uwm100.rfee_t - n_ttrfee).
                sic_bran.uwm101.rtax_i = sic_bran.uwm101.rtax_i + (sic_bran.uwm100.rtax_t - n_ttrtax).
            END.
        END.  /*else do: */
        DO transaction:
            FIND sic_bran.uwm101 USE-INDEX uwm10101 WHERE 
                sic_bran.uwm101.policy = sic_bran.uwm100.policy AND
                sic_bran.uwm101.rencnt = sic_bran.uwm100.rencnt AND 
                sic_bran.uwm101.endcnt = sic_bran.uwm100.endcnt AND
                sic_bran.uwm101.instno = 1  exclusive-lock NO-ERROR.
        END.  /* Transaction */
        ASSIGN 
            n_index  = 1 
            n_ttprem = 0 
            n_ttcom1 = 0
            n_ttcom2 = 0
            n_ttrstp = 0 
            n_ttrfee = 0
            n_ttrtax = 0
            n_ttpstp = 0
            n_ttpfee = 0
            n_ttptax = 0 
            nv_fi_rstp_t1 = 0
            nv_fi_rstp_t2 = 0
            nv_fi_rstp_t3 = 0
            nv_com1p_ins1 = 0
            nv_com1p_ins2 = 0
            nv_com1p_ins3 = 0.
    END.  /* if */
END. /*End 100 */
RELEASE sic_bran.uwm101.
RELEASE sic_bran.uwm100.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_instot2 C-Win 
PROCEDURE proc_instot2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/**  uwo10085.p - NEW POLICY ENTRY - INSTALMENTS  **/

DEFINE        VAR n_recid   AS RECID.                                       
DEFINE        VAR n_ttprem  LIKE sic_bran.uwm100.prem_t.                   
DEFINE        VAR n_ttcom1  LIKE sic_bran.uwm100.com1_t.                    
DEFINE        VAR n_ttcom2  LIKE sic_bran.uwm100.com2_t.                    
DEFINE        VAR n_ttrstp  LIKE sic_bran.uwm100.rstp_t.                    
DEFINE        VAR n_ttrfee  LIKE sic_bran.uwm100.rfee_t.                    
DEFINE        VAR n_ttrtax  LIKE sic_bran.uwm100.rtax_t.                    
DEFINE        VAR n_ttpstp  LIKE sic_bran.uwm100.rstp_t.                    
DEFINE        VAR n_ttpfee  LIKE sic_bran.uwm100.rfee_t.                    
DEFINE        VAR n_ttptax  LIKE sic_bran.uwm100.rtax_t.                    
DEFINE        VAR n_index   AS INTEGER.                                    
DEFINE        VAR nv_d0     AS INT.                                         
DEFINE        VAR nv_tmp_date AS DATE.                                      
DEF VAR nv_fi_rstp_t1       AS DECI INIT 0.
DEF VAR nv_fi_rstp_t2       AS DECI INIT 0.
DEF VAR nv_fi_rstp_t3       AS DECI INIT 0.
DEF VAR nv_com1p_ins1       AS DECI INIT 0.
DEF VAR nv_com1p_ins2       AS DECI INIT 0.
DEF VAR nv_com1p_ins3       AS DECI INIT 0.
DEF VAR nv_prem01           AS DECI INIT 0.
DEF VAR nv_prem02           AS DECI INIT 0.
DEF VAR nv_prem03           AS DECI INIT 0.

FIND sic_bran.uwm100   Where Recid(sic_bran.uwm100)  = s_recid1 no-error no-wait.
IF AVAILABLE sic_bran.uwm100  THEN DO:
    ASSIGN 
        s_recid1 = RECID(sic_bran.uwm100)
        sic_bran.uwm100.instot = impdata_fil.instot  
        nv_fi_rstp_t1 = 0
        nv_fi_rstp_t2 = 0
        nv_fi_rstp_t3 = 0
        nv_com1p_ins1 = 0
        nv_com1p_ins2 = 0
        nv_com1p_ins3 = 0
        nv_prem01     = 0  
        nv_prem02     = 0  
        nv_prem03     = 0  .

    FIND LAST impinst_fil WHERE impinst_fil.policyno = sic_bran.uwm100.policy AND impinst_fil.instot = impdata_fil.instot NO-LOCK NO-ERROR .

    IF impinst_fil.instot = 2 THEN DO:
        ASSIGN 
            nv_prem02 = impinst_fil.instprm2       
            nv_prem01 = impinst_fil.instprm1.
    END.
    ELSE DO:
        ASSIGN 
            nv_prem03 = impinst_fil.instprm3
            nv_prem02 = impinst_fil.instprm2
            nv_prem01 = impinst_fil.instprm1.
    END.

    IF nv_prem01 > 0 THEN 
        ASSIGN 
        nv_com1p_ins1 = (nv_prem01 * nv_com1p_ins ) / 100
        nv_fi_rstp_t1 = Truncate(nv_prem01 * nv_fi_stamp_per_ins  / 100,0)  + 
                        IF      (nv_prem01 * nv_fi_stamp_per_ins  / 100) -
                        Truncate(nv_prem01 * nv_fi_stamp_per_ins  / 100,0) > 0 Then 1 Else 0.
    IF nv_prem02 > 0 THEN 
        ASSIGN 
        nv_com1p_ins2 = (nv_prem02 * nv_com1p_ins ) / 100
        nv_fi_rstp_t2 = Truncate(nv_prem02 * nv_fi_stamp_per_ins / 100,0) + 
                            (IF (nv_prem02 * nv_fi_stamp_per_ins / 100) - 
                        Truncate(nv_prem02 * nv_fi_stamp_per_ins / 100,0) > 0 Then 1 Else 0 ).
    IF nv_prem03 > 0 THEN   
        ASSIGN 
        nv_com1p_ins3 = (nv_prem03 * nv_com1p_ins ) / 100
        nv_fi_rstp_t3 = Truncate(nv_prem03 * nv_fi_stamp_per_ins / 100,0) + 
                            (IF (nv_prem03 * nv_fi_stamp_per_ins / 100) - 
                        Truncate(nv_prem03 * nv_fi_stamp_per_ins / 100,0) > 0 Then 1 Else 0 ).

    FIND FIRST sic_bran.uwm101  USE-INDEX uwm10101 WHERE
        sic_bran.uwm101.policy = sic_bran.uwm100.policy  AND
        sic_bran.uwm101.rencnt = sic_bran.uwm100.rencnt  AND
        sic_bran.uwm101.endcnt = sic_bran.uwm100.endcnt  AND
        sic_bran.uwm101.bchyr  = nv_batchyr     AND
        sic_bran.uwm101.bchno  = nv_batchno     AND
        sic_bran.uwm101.bchcnt = nv_batcnt      NO-LOCK NO-ERROR NO-WAIT.
    IF AVAILABLE sic_bran.uwm101  THEN DO:
        FOR EACH sic_bran.uwm101  USE-INDEX uwm10101   WHERE
            sic_bran.uwm101.policy = sic_bran.uwm100.policy  AND
            sic_bran.uwm101.rencnt = sic_bran.uwm100.rencnt  AND
            sic_bran.uwm101.endcnt = sic_bran.uwm100.endcnt  AND
            sic_bran.uwm101.bchyr  = nv_batchyr     AND
            sic_bran.uwm101.bchno  = nv_batchno     AND
            sic_bran.uwm101.bchcnt = nv_batcnt:
            DELETE sic_bran.uwm101.
        END.  /* each uwm101 */
        RELEASE sic_bran.uwm101.
    END.       /* avail uwm101 */
    IF sic_bran.uwm100.instot > 1 THEN DO: 
        ASSIGN 
            n_ttprem = 0
            n_ttcom1 = 0
            n_ttcom2 = 0
            n_ttpstp = 0
            n_ttpfee = 0
            n_ttptax = 0
            n_ttrstp = 0
            n_ttrfee = 0
            n_ttrtax = 0.
        DO transaction:
            FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 exclusive-lock NO-ERROR.
        END.
        FIND sicsyac.xmm031 USE-INDEX xmm03101 WHERE xmm031.poltyp = sic_bran.uwm100.poltyp NO-LOCK NO-ERROR.
        Do transaction:
            FIND sic_bran.uwm101 USE-INDEX uwm10101 WHERE 
                sic_bran.uwm101.policy = sic_bran.uwm100.policy AND
                sic_bran.uwm101.rencnt = sic_bran.uwm100.rencnt AND 
                sic_bran.uwm101.endcnt = sic_bran.uwm100.endcnt AND
                sic_bran.uwm101.bchyr  = nv_batchyr             AND
                sic_bran.uwm101.bchno  = nv_batchno             AND
                sic_bran.uwm101.bchcnt = nv_batcnt              AND
                sic_bran.uwm101.instno = 1 exclusive-lock NO-ERROR.
        END.
        IF NOT AVAILABLE sic_bran.uwm101 THEN DO transaction:
            REPEAT n_index = 1 TO sic_bran.uwm100.instot:
                CREATE sic_bran.uwm101.
                ASSIGN 
                    sic_bran.uwm101.policy = sic_bran.uwm100.policy 
                    sic_bran.uwm101.rencnt = sic_bran.uwm100.rencnt 
                    sic_bran.uwm101.endcnt = sic_bran.uwm100.endcnt
                    sic_bran.uwm101.bchyr  = nv_batchyr        
                    sic_bran.uwm101.bchno  = nv_batchno            
                    sic_bran.uwm101.bchcnt = nv_batcnt  
                    sic_bran.uwm101.instno = n_index
                    sic_bran.uwm101.prem_i = IF      n_index = 1 THEN nv_prem01
                                             ELSE IF n_index = 2 THEN nv_prem02
                                                                 ELSE nv_prem03
                    sic_bran.uwm101.com1_i = IF      n_index = 1 THEN nv_com1p_ins1 * ( -1 )
                                             ELSE IF n_index = 2 THEN nv_com1p_ins2 * ( -1 )
                                                                 ELSE nv_com1p_ins3 * ( -1 )
                    sic_bran.uwm101.com2_i = 0.00
                    sic_bran.uwm101.rstp_i = IF      n_index = 1 THEN nv_fi_rstp_t1
                                             ELSE IF n_index = 2 THEN nv_fi_rstp_t2
                                             ELSE                     nv_fi_rstp_t3   
                    sic_bran.uwm101.rfee_i = 0.00
                    sic_bran.uwm101.rtax_i = IF      n_index = 1 THEN (nv_prem01 + nv_fi_rstp_t1) * nv_fi_tax_per_ins / 100
                                             ELSE IF n_index = 2 THEN (nv_prem02 + nv_fi_rstp_t2) * nv_fi_tax_per_ins / 100
                                                                 ELSE (nv_prem03 + nv_fi_rstp_t3) * nv_fi_tax_per_ins / 100
                    n_ttprem               = n_ttprem + sic_bran.uwm101.prem_i 
                    n_ttcom1               = n_ttcom1 + sic_bran.uwm101.com1_i
                    n_ttcom2               = n_ttcom2 + sic_bran.uwm101.com2_i
                    n_ttrstp               = n_ttrstp + sic_bran.uwm101.rstp_i
                    n_ttrfee               = n_ttrfee + sic_bran.uwm101.rfee_i
                    n_ttrtax               = n_ttrtax + sic_bran.uwm101.rtax_i
                    sic_bran.uwm101.desc_i = IF      n_index = 1 THEN impinst_fil.instcod1 + " " + 
                                                                      impinst_fil.insttitle1 + " " + impinst_fil.instname1 + " " + impinst_fil.instlname1
                                             ELSE IF n_index = 2 THEN impinst_fil.instcod2 + " " + 
                                                                      impinst_fil.insttitle2 + " " + impinst_fil.instname2 + " " + impinst_fil.instlname2
                                             ELSE                     impinst_fil.instcod3 + " " + 
                                                                      impinst_fil.insttitle3 + " " + impinst_fil.instname3 + " " + impinst_fil.instlname3
                    sic_bran.uwm101.trty1i = ""
                    sic_bran.uwm101.docnoi = "".
                IF n_index = 1 THEN DO:
                    ASSIGN 
                    n_recid                = RECID(sic_bran.uwm101) 
                    sic_bran.uwm101.pstp_i = sic_bran.uwm100.pstp 
                    sic_bran.uwm101.pfee_i = sic_bran.uwm100.pfee
                    sic_bran.uwm101.ptax_i = sic_bran.uwm100.ptax.
                END.
                ELSE DO:
                    ASSIGN 
                        sic_bran.uwm101.pstp_i  = 0 
                        sic_bran.uwm101.pfee_i  = 0
                        sic_bran.uwm101.ptax_i  = 0.
                END.
                IF xmm031.insdef = "C" OR xmm031.insdef = "T" THEN DO:
                    
                    IF xmm031.insdef = "C" THEN sic_bran.uwm101.duedat = sic_bran.uwm100.comdat.
                            ELSE uwm101.duedat = uwm100.trndat.
                            nv_tmp_date = uwm101.duedat.
                            nv_d0       = DAY(nv_tmp_date).
                END.
            END.
            FIND FIRST sic_bran.uwm101 WHERE RECID(sic_bran.uwm101) = n_recid.
            IF AVAILABLE sic_bran.uwm101 THEN DO:
                sic_bran.uwm101.prem_i = sic_bran.uwm101.prem_i + (sic_bran.uwm100.prem_t - n_ttprem).
                /*sic_bran.uwm101.com1_i = sic_bran.uwm101.com1_i + (sic_bran.uwm100.com1_t - n_ttcom1).*/
                sic_bran.uwm101.com2_i = sic_bran.uwm101.com2_i + (sic_bran.uwm100.com2_t - n_ttcom2).
                sic_bran.uwm101.rstp_i = sic_bran.uwm101.rstp_i + (sic_bran.uwm100.rstp_t - n_ttrstp).
                sic_bran.uwm101.rfee_i = sic_bran.uwm101.rfee_i + (sic_bran.uwm100.rfee_t - n_ttrfee).
                sic_bran.uwm101.rtax_i = sic_bran.uwm101.rtax_i + (sic_bran.uwm100.rtax_t - n_ttrtax).
            END.
        END.  /*else do: */
        DO transaction:
            FIND sic_bran.uwm101 USE-INDEX uwm10101 WHERE 
                sic_bran.uwm101.policy = sic_bran.uwm100.policy AND
                sic_bran.uwm101.rencnt = sic_bran.uwm100.rencnt AND 
                sic_bran.uwm101.endcnt = sic_bran.uwm100.endcnt AND
                sic_bran.uwm101.instno = 1  exclusive-lock NO-ERROR.
        END.  /* Transaction */
        ASSIGN 
            n_index  = 1 
            n_ttprem = 0 
            n_ttcom1 = 0
            n_ttcom2 = 0
            n_ttrstp = 0 
            n_ttrfee = 0
            n_ttrtax = 0
            n_ttpstp = 0
            n_ttpfee = 0
            n_ttptax = 0 
            nv_fi_rstp_t1 = 0
            nv_fi_rstp_t2 = 0
            nv_fi_rstp_t3 = 0
            nv_com1p_ins1 = 0
            nv_com1p_ins2 = 0
            nv_com1p_ins3 = 0.
    END.  /* if */
END. /*End 100 */
RELEASE sic_bran.uwm101.
RELEASE sic_bran.uwm100.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_mailtxt C-Win 
PROCEDURE proc_mailtxt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND  LAST brstat.mailtxt_fil  USE-INDEX  mailtxt01  WHERE
           brstat.mailtxt_fil.policy  = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno  AND
           brstat.mailtxt_fil.bchyr   = nv_batchyr   AND                                               
           brstat.mailtxt_fil.bchno   = nv_batchno   AND
           brstat.mailtxt_fil.bchcnt  = nv_batcnt    AND 
           brstat.mailtxt_fil.lnumber = n_count     NO-ERROR  NO-WAIT.
    IF NOT AVAIL brstat.mailtxt_fil THEN DO:  
          nv_lnumber =  n_count.  
          CREATE brstat.mailtxt_fil.
          ASSIGN                                           
                 brstat.mailtxt_fil.policy  = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno
                 brstat.mailtxt_fil.bchyr   = nv_batchyr   
                 brstat.mailtxt_fil.bchno   = nv_batchno   
                 brstat.mailtxt_fil.bchcnt  = nv_batcnt 

                 brstat.mailtxt_fil.lnumber   = nv_lnumber
                 brstat.mailtxt_fil.ltext     = nv_drinam + FILL(" ",50 - LENGTH(nv_drinam)) + nv_dgender  
                 brstat.mailtxt_fil.ltext2    = nv_dbirth + "  " + string(nv_dage)  /* พ.ศ. */
                 SUBSTRING(brstat.mailtxt_fil.ltext2,16,40)   =  IF nv_doccup  = "" THEN "-" ELSE nv_doccup 
                 SUBSTRING(brstat.mailtxt_fil.ltext2,101,50)  =  nv_dicno
                 SUBSTRING(brstat.mailtxt_fil.ltext2,151,50)  =  nv_ddriveno 
                 SUBSTRING(brstat.mailtxt_fil.ltext2,201,4)   =  "" 
                 brstat.mailtxt_fil.titlenam   = nv_ntitle
                 brstat.mailtxt_fil.firstnam   = nv_name  
                 brstat.mailtxt_fil.lastnam    = nv_lname 
                 brstat.mailtxt_fil.drivbirth  = IF trim(nv_dribirth) <> "" THEN date(nv_dribirth) ELSE ? /* ค.ศ. */
                 brstat.mailtxt_fil.drivage    = nv_dage
                 brstat.mailtxt_fil.occupcod   = "-" 
                 brstat.mailtxt_fil.drividno   = nv_dicno
                 brstat.mailtxt_fil.licenno    = nv_ddriveno
                 brstat.mailtxt_fil.gender     = nv_dgender
                 brstat.mailtxt_fil.drivlevel  = nv_dlevel
                 brstat.mailtxt_fil.levelper   = deci(nv_dlevper)
                 brstat.mailtxt_fil.licenexp   = IF trim(nv_drivexp) <> "" THEN DATE(nv_drivexp) ELSE ?
                 brstat.mailtxt_fil.dconsen    = IF trim(nv_dconsent) = "N" THEN NO ELSE YES
                 brstat.mailtxt_fil.occupdes   = IF nv_doccup  = "" THEN "-" ELSE nv_doccup
                 brstat.mailtxt_fil.cardflg    = "" .
    END. /*End Avail Brstat*/
    ELSE DO:
        nv_lnumber =  n_count.  
        ASSIGN                                           
             brstat.mailtxt_fil.policy  = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno
             brstat.mailtxt_fil.bchyr   = nv_batchyr   
             brstat.mailtxt_fil.bchno   = nv_batchno   
             brstat.mailtxt_fil.bchcnt  = nv_batcnt 
        
             brstat.mailtxt_fil.lnumber   = nv_lnumber
             brstat.mailtxt_fil.ltext     = nv_drinam + FILL(" ",50 - LENGTH(nv_drinam)) + nv_dgender  
             brstat.mailtxt_fil.ltext2    = nv_dbirth + "  " + string(nv_dage)  /* พ.ศ. */
             SUBSTRING(brstat.mailtxt_fil.ltext2,16,40)   =  IF nv_doccup  = "" THEN "-" ELSE nv_doccup
             SUBSTRING(brstat.mailtxt_fil.ltext2,101,50)  =  nv_dicno
             SUBSTRING(brstat.mailtxt_fil.ltext2,151,50)  =  nv_ddriveno 
             SUBSTRING(brstat.mailtxt_fil.ltext2,201,4)   =  "" 
             brstat.mailtxt_fil.titlenam   = nv_ntitle
             brstat.mailtxt_fil.firstnam   = nv_name  
             brstat.mailtxt_fil.lastnam    = nv_lname 
             brstat.mailtxt_fil.drivbirth  = IF trim(nv_dribirth) <> "" THEN date(nv_dribirth) ELSE ?  /* ค.ศ. */
             brstat.mailtxt_fil.drivage    = nv_dage
             brstat.mailtxt_fil.occupcod   = "-" 
             brstat.mailtxt_fil.drividno   = nv_dicno
             brstat.mailtxt_fil.licenno    = nv_ddriveno
             brstat.mailtxt_fil.gender     = nv_dgender
             brstat.mailtxt_fil.drivlevel  = nv_dlevel
             brstat.mailtxt_fil.levelper   = deci(nv_dlevper)
             brstat.mailtxt_fil.licenexp   = IF trim(nv_drivexp) <> "" THEN DATE(nv_drivexp) ELSE ?
             brstat.mailtxt_fil.dconsen    = IF trim(nv_dconsent) = "N" THEN NO ELSE YES
             brstat.mailtxt_fil.occupdes   = IF nv_doccup  = "" THEN "-" ELSE nv_doccup
             brstat.mailtxt_fil.cardflg    = "" .
    END.
    RELEASE brstat.mailtxt_fil .
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_maktab C-Win 
PROCEDURE proc_maktab :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND FIRST stat.makdes31 USE-INDEX makdes31 WHERE 
    makdes31.moddes =  impdata_fil.prempa + impdata_fil.subclass NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL makdes31  THEN
    ASSIGN n_ratmin = makdes31.si_theft_p   
    n_ratmax = makdes31.load_p   .    
ELSE ASSIGN n_ratmin = 0
    n_ratmax = 0.

IF (impdata_fil.si = 0 ) THEN DO:
    Find First stat.maktab_fil USE-INDEX maktab04    Where
        stat.maktab_fil.makdes   =     impdata_fil.brand            And                  
        index(stat.maktab_fil.moddes,impdata_fil.model) <> 0        And
        stat.maktab_fil.makyea   =     Integer(impdata_fil.yrmanu) AND 
        stat.maktab_fil.sclass   =     impdata_fil.subclass        AND
        stat.maktab_fil.seats    =     INTEGER(impdata_fil.seat)    No-lock no-error no-wait.
    If  avail stat.maktab_fil  THEN DO: 
        ASSIGN  impdata_fil.redbook  =  stat.maktab_fil.modcod
        sic_bran.uwm301.modcod   =  stat.maktab_fil.modcod                                    
        impdata_fil.cargrp       =  stat.maktab_fil.prmpac
        sic_bran.uwm301.vehgrp   =  stat.maktab_fil.prmpac
        /*sic_bran.uwm301.body   =  stat.maktab_fil.body*/
        /*sic_bran.uwm301.engine =  stat.maktab_fil.eng*/
        nv_engine                =  stat.maktab_fil.engine
        impdata_fil.seat41       =  IF impdata_fil.seat41 = 0 THEN stat.maktab_fil.seats ELSE impdata_fil.seat41.  /*A64-0044*/
        IF sic_bran.uwm301.maksi = 0 AND SUBSTR(impdata_fil.subclass,1,1) = "E" THEN sic_bran.uwm301.maksi = stat.maktab_fil.maksi . /*A67-0029*/
    END.
END.
ELSE DO:
    Find First stat.maktab_fil USE-INDEX maktab04    Where
        stat.maktab_fil.makdes   =     impdata_fil.brand            And                  
        index(stat.maktab_fil.moddes,impdata_fil.model) <> 0        And
        stat.maktab_fil.makyea   =     Integer(impdata_fil.yrmanu) AND 
        stat.maktab_fil.engine   =     Integer(impdata_fil.engcc)   AND
        stat.maktab_fil.sclass   =     impdata_fil.subclass        AND
        (stat.maktab_fil.si - (stat.maktab_fil.si * n_ratmin / 100 ) LE  deci(impdata_fil.si)    AND
         stat.maktab_fil.si + (stat.maktab_fil.si * n_ratmax / 100 ) GE  deci(impdata_fil.si) )  AND  
        stat.maktab_fil.seats    =     INTEGER(impdata_fil.seat)     No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then DO:
        ASSIGN  impdata_fil.redbook =  stat.maktab_fil.modcod
        sic_bran.uwm301.modcod      =  stat.maktab_fil.modcod                                    
        impdata_fil.cargrp          =  stat.maktab_fil.prmpac
        sic_bran.uwm301.vehgrp      =  stat.maktab_fil.prmpac
        /*sic_bran.uwm301.engine    =  stat.maktab_fil.eng*/
        nv_engine                   =  stat.maktab_fil.engine
        impdata_fil.seat41          =  IF impdata_fil.seat41 = 0 THEN stat.maktab_fil.seats ELSE impdata_fil.seat41.  /*A64-0044*/
        IF sic_bran.uwm301.maksi = 0 AND SUBSTR(impdata_fil.subclass,1,1) = "E" THEN sic_bran.uwm301.maksi = stat.maktab_fil.maksi . /*A67-0029*/
    END.
END.
IF impdata_fil.redbook = "" THEN DO:
    Find First stat.maktab_fil USE-INDEX maktab04    Where
        stat.maktab_fil.makdes   =     impdata_fil.brand            And                  
        index(stat.maktab_fil.moddes,impdata_fil.model) <> 0        And
        stat.maktab_fil.makyea   =     Integer(impdata_fil.yrmanu) AND 
        stat.maktab_fil.sclass   =     impdata_fil.subclass        AND
        stat.maktab_fil.seats    =     INTEGER(impdata_fil.seat)    No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then DO:
        ASSIGN  impdata_fil.redbook   =  stat.maktab_fil.modcod
        sic_bran.uwm301.modcod        =  stat.maktab_fil.modcod                                    
        impdata_fil.cargrp            =  stat.maktab_fil.prmpac
        sic_bran.uwm301.vehgrp        =  stat.maktab_fil.prmpac
        /*sic_bran.uwm301.engine      =  stat.maktab_fil.eng*/
        nv_engine                     =  stat.maktab_fil.engine
        impdata_fil.seat41            =  IF impdata_fil.seat41 = 0 THEN stat.maktab_fil.seats ELSE impdata_fil.seat41.  /*A64-0044*/
        IF sic_bran.uwm301.maksi = 0 AND SUBSTR(impdata_fil.subclass,1,1) = "E" THEN sic_bran.uwm301.maksi = stat.maktab_fil.maksi . /*A67-0029*/
    END.
END.
RELEASE stat.maktab_fil .

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_open C-Win 
PROCEDURE proc_open :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*OPEN QUERY br_impdata_fil FOR EACH impdata_fil WHERE impdata_fil.pass = "y".   */
OPEN QUERY br_impdata_fil FOR EACH impdata_fil WHERE impdata_fil.pass <> "N" .

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_policy C-Win 
PROCEDURE proc_policy :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR chk_sticker AS CHAR FORMAT "x(15)".

ASSIGN fi_process = "Create data Text File to uwm100...." + impdata_fil.policyno .   
DISP fi_process WITH FRAM fr_main.

/*IF impdata_fil.poltyp = "v72" THEN n_rencnt = 0.  */
FIND LAST sic_bran.uwm100 WHERE sic_bran.uwm100.policy =  impdata_fil.policy  and      
                                sic_bran.uwm100.rencnt =  n_rencnt        and      /*Batch Year */ 
                                sic_bran.uwm100.endcnt =  n_endcnt        and      /*Batch Count*/  
                                sic_bran.uwm100.bchyr  =  nv_batchyr      and      
                                sic_bran.uwm100.bchno  =  nv_batchno      and      
                                sic_bran.uwm100.bchcnt =  nv_batcnt       NO-LOCK NO-ERROR .
IF NOT AVAIL sic_bran.uwm100 THEN DO:
    /* เช็ค Vat ชมพู */
    ASSIGN n_chkvat = NO.
    IF impdata_fil.instot = 1 THEN DO:
       FIND LAST impinst_fil WHERE 
                 impinst_fil.policyno = impdata_fil.policy AND 
                 impinst_fil.instot   = impdata_fil.instot AND
                 impinst_fil.riskno   = impdata_fil.riskno AND /* A65-0043*/
                 impinst_fil.instname1 <> "" NO-LOCK NO-ERROR.
       IF AVAIL impinst_fil THEN n_chkvat = YES.
       ELSE n_chkvat = NO.
    END.
    ELSE ASSIGN n_chkvat = YES.
    
    IF n_chkvat = YES THEN RUN proc_insnam_inst.
    
    nv_insref = "" .
    /*IF impdata_fil.nv_insref <> "" THEN nv_insref = trim(impdata_fil.nv_insref).*/ /*A65-0043*/
    /* Add by : A64-0043 */
    IF impdata_fil.insref <> "" THEN DO: 
        nv_insref = trim(impdata_fil.insref).
       IF impdata_fil.instot = 1 AND n_chkvat = YES THEN DO:
           FIND sicsyac.xmm600 USE-INDEX xmm60001 WHERE sicsyac.xmm600.acno = nv_insref NO-ERROR NO-WAIT .
             IF AVAIL xmm600 THEN RUN proc_insnamvat .
           RELEASE sicsyac.xmm600. 
       END.
    END.
    /* end : A65-0043*/
    ELSE RUN proc_insnam. 
    
    IF nv_insref = ""  THEN DO:
        ASSIGN impdata_fil.comment = impdata_fil.comment + "|รหัสลูกค้าเป็นค่าว่าง เช็ครันนิ่ง insured code (XZM056) สาขา " + impdata_fil.n_branch 
               impdata_fil.pass    = "N" 
               impdata_fil.OK_gen  = "N" .
        RETURN.
    END.
    ELSE DO:
        RUN proc_create100.
        s_recid1  =  Recid(sic_bran.uwm100).
        FIND sicsyac.xmm031 USE-INDEX xmm03101 WHERE sicsyac.xmm031.poltyp = impdata_fil.poltyp  NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL  sicsyac.xmm031 THEN DO:
            nv_dept = sicsyac.xmm031.dept.
        END.

        /* A65-0043 */
        IF (impdata_fil.icno <> "-" AND impdata_fil.icno <> "" ) THEN DO:
            IF LENGTH(impdata_fil.icno) < 13  THEN 
                ASSIGN impdata_fil.comment = impdata_fil.comment + "|เลขบัตรประชาชนไม่ครบ 13 หลัก "
                       impdata_fil.WARNING = impdata_fil.WARNING + "|เลขบัตรประชาชนไม่ครบ 13 หลัก ".
        END.
        /* end : A65-0043 */
        
        DO TRANSACTION:
           ASSIGN
              sic_bran.uwm100.renno      = ""
              sic_bran.uwm100.endno      = ""
              sic_bran.uwm100.poltyp     = CAPS(impdata_fil.poltyp)
              sic_bran.uwm100.acno_typ   = IF impdata_fil.instyp = "C" THEN "CO" ELSE "PR"
              sic_bran.uwm100.br_insured = impdata_fil.insbr
              sic_bran.uwm100.insref     = CAPS(trim(nv_insref))                         
              sic_bran.uwm100.opnpol     = CAPS(TRIM(impdata_fil.promo))
              sic_bran.uwm100.icno       = TRIM(impdata_fil.icno)
              sic_bran.uwm100.ntitle     = trim(impdata_fil.tiname)              
              sic_bran.uwm100.name1      = trim(impdata_fil.insnam) + " " + impdata_fil.lastname
              sic_bran.uwm100.firstname  = trim(impdata_fil.insnam)
              sic_bran.uwm100.lastname   = trim(impdata_fil.lastname)
              sic_bran.uwm100.sex        = trim(impdata_fil.gender)
              sic_bran.uwm100.name2      = if trim(impdata_fil.name2) <> "null" then trim(impdata_fil.name2) else ""       
              sic_bran.uwm100.name3      = if trim(impdata_fil.name3) <> "null" then trim(impdata_fil.name3) else ""       
              sic_bran.uwm100.addr1      = trim(impdata_fil.addr)               
              sic_bran.uwm100.addr2      = trim(impdata_fil.tambon)               
              sic_bran.uwm100.addr3      = trim(impdata_fil.amper)               
              sic_bran.uwm100.addr4      = trim(impdata_fil.country)
              sic_bran.uwm100.postcd     = trim(impdata_fil.post)  
              sic_bran.uwm100.codeaddr1  = trim(impdata_fil.provcod)
              sic_bran.uwm100.codeaddr2  = trim(impdata_fil.distcod)
              sic_bran.uwm100.codeaddr3  = trim(impdata_fil.sdistcod)
              sic_bran.uwm100.undyr      = String(Year(today),"9999")      
              sic_bran.uwm100.branch     = CAPS(impdata_fil.n_branch)                  
              sic_bran.uwm100.dept       = nv_dept
              sic_bran.uwm100.usrid      = USERID(LDBNAME(1))
              sic_bran.uwm100.fstdat     = date(impdata_fil.firstdat)          
              sic_bran.uwm100.comdat     = DATE(impdata_fil.comdat)
              sic_bran.uwm100.expdat     = date(impdata_fil.expdat)
              /*sic_bran.uwm100.accdat     = DATE(impdata_fil.agreedat) A67-0029 */
              sic_bran.uwm100.accdat     = IF DATE(impdata_fil.agreedat) <> ? THEN DATE(impdata_fil.agreedat)  ELSE DATE(impdata_fil.comdat)  /* A67-0029 */
              sic_bran.uwm100.tranty     = "N"                     /*Transaction Type (N/R/E/C/T)*/
              sic_bran.uwm100.langug     = impdata_fil.inslang
              sic_bran.uwm100.acctim     = "00:00"
              sic_bran.uwm100.trty11     = "M"   
              sic_bran.uwm100.docno1     = STRING(nv_docno,"9999999")     
              sic_bran.uwm100.enttim     = STRING(TIME,"HH:MM:SS")
              sic_bran.uwm100.entdat     = TODAY
              sic_bran.uwm100.curbil     = "BHT"
              sic_bran.uwm100.curate     = 1                            
              sic_bran.uwm100.instot     = impdata_fil.instot               
              sic_bran.uwm100.prog       = "wgwlfleet"
              sic_bran.uwm100.cntry      = "TH"                  /*Country where risk is situated*/
              sic_bran.uwm100.insddr     = YES                   /*Print Insd. Name on DrN       */
              sic_bran.uwm100.no_sch     = 0                     /*No. to print, Schedule        */
              sic_bran.uwm100.no_dr      = 1                     /*No. to print, Dr/Cr Note      */
              sic_bran.uwm100.no_ri      = 0                     /*No. to print, RI Appln        */
              sic_bran.uwm100.no_cer     = 0                     /*No. to print, Certificate     */
              sic_bran.uwm100.li_sch     = YES                   /*Print Later/Imm., Schedule    */
              sic_bran.uwm100.li_dr      = YES                   /*Print Later/Imm., Dr/Cr Note  */
              sic_bran.uwm100.li_ri      = YES                   /*Print Later/Imm., RI Appln,   */
              sic_bran.uwm100.li_cer     = YES                   /*Print Later/Imm., Certificate */
              sic_bran.uwm100.apptax     = YES                   /*Apply risk level tax (Y/N)    */
              sic_bran.uwm100.recip      = "N"                   /*Reciprocal (Y/N/C)            */
              sic_bran.uwm100.short      = IF trim(impdata_fil.srate) = "Y" THEN YES ELSE NO                    
              sic_bran.uwm100.acno1      = CAPS(impdata_fil.producer)               
              sic_bran.uwm100.agent      = CAPS(impdata_fil.agent)     /*nv_agent   */
              sic_bran.uwm100.insddr     = NO
              sic_bran.uwm100.coins      = NO
              sic_bran.uwm100.billco     = ""
              sic_bran.uwm100.fptr01     = 0        sic_bran.uwm100.bptr01 = 0
              sic_bran.uwm100.fptr02     = 0        sic_bran.uwm100.bptr02 = 0
              sic_bran.uwm100.fptr03     = 0        sic_bran.uwm100.bptr03 = 0
              sic_bran.uwm100.fptr04     = 0        sic_bran.uwm100.bptr04 = 0
              sic_bran.uwm100.fptr05     = 0        sic_bran.uwm100.bptr05 = 0
              sic_bran.uwm100.fptr06     = 0        sic_bran.uwm100.bptr06 = 0  
              sic_bran.uwm100.styp20     = "NORM"
              sic_bran.uwm100.dir_ri     =  YES
              sic_bran.uwm100.drn_p      =  NO
              sic_bran.uwm100.sch_p      =  NO
              sic_bran.uwm100.cr_1       = CAPS(trim(impdata_fil.pack))  /* Product */
              sic_bran.uwm100.cr_2       = impdata_fil.cr_2
              sic_bran.uwm100.bchyr      = nv_batchyr          /*Batch Year */  
              sic_bran.uwm100.bchno      = nv_batchno          /*Batch No.  */  
              sic_bran.uwm100.bchcnt     = nv_batcnt           /*Batch Count*/  
              sic_bran.uwm100.prvpol     = CAPS(impdata_fil.prepol)      
              sic_bran.uwm100.cedpol     = impdata_fil.appenno
              sic_bran.uwm100.finint     = CAPS(impdata_fil.n_delercode) 
              sic_bran.uwm100.bs_cd      = CAPS(impdata_fil.vatcode)  
              sic_bran.uwm100.codeocc    = trim(impdata_fil.occup)     /* code อาชีพ*/
              /*sic_bran.uwm100.occupn     = trim(impdata_fil.occup) */    /*  อาชีพ*/
              /*sic_bran.uwm100.endern     = TODAY    */          /* เพิ่มวันที่รับเงิน*/
              sic_bran.uwm100.dealer      = CAPS(TRIM(impdata_fil.fincode))
              sic_bran.uwm100.sname       = TRIM(impdata_fil.salename)
              sic_bran.uwm100.s_lastname  = CAPS(TRIM(impdata_fil.product))
              sic_bran.uwm100.payer       = CAPS(TRIM(impdata_fil.payercod))
              sic_bran.uwm100.campaign    = CAPS(TRIM(impdata_fil.camp_no))   
              sic_bran.uwm100.refer1      = impdata_fil.campen   
              sic_bran.uwm100.chr1        = impdata_fil.specon  
              sic_bran.uwm100.acno2       = CAPS(TRIM(impdata_fil.agco70))     /* co-broker */
              sic_bran.uwm100.s_tel[1]    = trim(impdata_fil.tele1)   
              sic_bran.uwm100.s_tel[2]    = trim(impdata_fil.tele2)
              sic_bran.uwm100.s_email[1]  = trim(impdata_fil.mail1) 
              sic_bran.uwm100.s_email[2]  = trim(impdata_fil.mail2) 
              sic_bran.uwm100.s_email[3]  = trim(impdata_fil.mail3) 
              sic_bran.uwm100.s_email[4]  = trim(impdata_fil.mail4) 
              sic_bran.uwm100.s_email[5]  = trim(impdata_fil.mail5)
              sic_bran.uwm100.fgtariff    = IF index(impdata_fil.subclass,"E") <> 0 THEN NO ELSE tg_flag  /*A68-0044*/
    
              sic_bran.uwm100.accdat      = IF sic_bran.uwm100.accdat > sic_bran.uwm100.comdat THEN sic_bran.uwm100.comdat ELSE sic_bran.uwm100.accdat 
              sic_bran.uwm100.trndat      = IF fi_loaddat <> ? THEN  fi_loaddat ELSE TODAY
              sic_bran.uwm100.issdat      = sic_bran.uwm100.trndat .
    
              IF impdata_fil.prepol <> " " THEN DO:
                  IF impdata_fil.poltyp = "v72"  THEN ASSIGN sic_bran.uwm100.prvpol  = ""  sic_bran.uwm100.tranty  = "R".  
                  ELSE 
                      ASSIGN sic_bran.uwm100.prvpol = impdata_fil.prepol     /*ถ้าเป็นงาน Renew  ต้องไม่เป็นค่าว่าง*/
                        sic_bran.uwm100.tranty      = "R".               /*Transaction Type (N/R/E/C/T)*/
              END.
              IF  impdata_fil.pass = "Y" THEN sic_bran.uwm100.impflg  = YES.
              ELSE sic_bran.uwm100.impflg  = NO.
    
              IF impdata_fil.cancel = "ca" THEN sic_bran.uwm100.polsta = "CA" .
              ELSE sic_bran.uwm100.polsta = "IF".
    
              nv_polday  =  IF  (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 365)  OR
                                (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 366)  OR
                                (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 367)  THEN  365 
                            ELSE sic_bran.uwm100.expdat - sic_bran.uwm100.comdat.  
              
        END. /*transaction*/
        RUN proc_uwd100.
        RUN proc_uwd102.
    END.
    FIND sic_bran.uwm120 USE-INDEX uwm12001      WHERE
          sic_bran.uwm120.policy  = sic_bran.uwm100.policy AND 
          sic_bran.uwm120.rencnt  = sic_bran.uwm100.rencnt AND 
          sic_bran.uwm120.endcnt  = sic_bran.uwm100.endcnt AND 
          sic_bran.uwm120.riskgp  = s_riskgp               AND 
          sic_bran.uwm120.riskno  = impdata_fil.riskno         AND       
          sic_bran.uwm120.bchyr   = nv_batchyr             AND 
          sic_bran.uwm120.bchno   = nv_batchno             AND 
          sic_bran.uwm120.bchcnt  = nv_batcnt              NO-WAIT NO-ERROR.
        IF NOT AVAILABLE sic_bran.uwm120 THEN DO:
           RUN wgw/wgwad120 (INPUT sic_bran.uwm100.policy,   /***--- A490166 Note Modi ---***/
                                   sic_bran.uwm100.rencnt,
                                   sic_bran.uwm100.endcnt,
                                   s_riskgp,
                                   impdata_fil.riskno,
                                   OUTPUT  s_recid2).
          FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
        END.   /* end not avail  uwm120 */
        IF AVAILABLE sic_bran.uwm120 THEN DO:  
            ASSIGN sic_bran.uwm120.sicurr = "BHT"
            sic_bran.uwm120.siexch = 1  /*not sure*/
            sic_bran.uwm120.fptr01 = 0               
            sic_bran.uwm120.fptr02 = 0               
            sic_bran.uwm120.fptr03 = 0               
            sic_bran.uwm120.fptr04 = 0               
            sic_bran.uwm120.fptr08 = 0               
            sic_bran.uwm120.fptr09 = 0          
            sic_bran.uwm120.com1ae = YES
            sic_bran.uwm120.stmpae = YES
            sic_bran.uwm120.feeae  = YES
            sic_bran.uwm120.taxae  = YES
            sic_bran.uwm120.bptr01 = 0 
            sic_bran.uwm120.bptr02 = 0 
            sic_bran.uwm120.bptr03 = 0 
            sic_bran.uwm120.bptr04 = 0 
            sic_bran.uwm120.bptr08 = 0 
            sic_bran.uwm120.bptr09 = 0 
            sic_bran.uwm120.bchyr  = nv_batchyr         /* batch Year */
            sic_bran.uwm120.bchno  = nv_batchno         /* bchno    */
            sic_bran.uwm120.bchcnt = nv_batcnt       /* bchcnt     */
            sic_bran.uwm120.class  = IF impdata_fil.poltyp = "V72" THEN impdata_fil.subclass ELSE impdata_fil.prempa + impdata_fil.subclass 
            s_recid2     = RECID(sic_bran.uwm120).
        END. 
END. /* end if avail */
ELSE DO:
     /* --------------------U W M 1 2 0 -------------- */
      FIND sic_bran.uwm120 USE-INDEX uwm12001      WHERE
           sic_bran.uwm120.policy  = sic_bran.uwm100.policy AND 
           sic_bran.uwm120.rencnt  = sic_bran.uwm100.rencnt AND 
           sic_bran.uwm120.endcnt  = sic_bran.uwm100.endcnt AND 
           sic_bran.uwm120.riskgp  = s_riskgp               AND 
           sic_bran.uwm120.riskno  = impdata_fil.riskno         AND       
           sic_bran.uwm120.bchyr   = nv_batchyr             AND 
           sic_bran.uwm120.bchno   = nv_batchno             AND 
           sic_bran.uwm120.bchcnt  = nv_batcnt              NO-WAIT NO-ERROR.
        IF NOT AVAILABLE sic_bran.uwm120 THEN DO:
           RUN wgw/wgwad120 (INPUT sic_bran.uwm100.policy,   /***--- A490166 Note Modi ---***/
                                   sic_bran.uwm100.rencnt,
                                   sic_bran.uwm100.endcnt,
                                   s_riskgp,
                                   impdata_fil.riskno,
                                   OUTPUT  s_recid2).
          FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
        END.   /* end not avail  uwm120 */
        IF AVAILABLE sic_bran.uwm120 THEN DO:  
            ASSIGN sic_bran.uwm120.sicurr = "BHT"
            sic_bran.uwm120.siexch = 1  /*not sure*/
            sic_bran.uwm120.fptr01 = 0               
            sic_bran.uwm120.fptr02 = 0               
            sic_bran.uwm120.fptr03 = 0               
            sic_bran.uwm120.fptr04 = 0               
            sic_bran.uwm120.fptr08 = 0               
            sic_bran.uwm120.fptr09 = 0          
            sic_bran.uwm120.com1ae = YES
            sic_bran.uwm120.stmpae = YES
            sic_bran.uwm120.feeae  = YES
            sic_bran.uwm120.taxae  = YES
            sic_bran.uwm120.bptr01 = 0 
            sic_bran.uwm120.bptr02 = 0 
            sic_bran.uwm120.bptr03 = 0 
            sic_bran.uwm120.bptr04 = 0 
            sic_bran.uwm120.bptr08 = 0 
            sic_bran.uwm120.bptr09 = 0 
            sic_bran.uwm120.bchyr  = nv_batchyr         /* batch Year */
            sic_bran.uwm120.bchno  = nv_batchno         /* bchno    */
            sic_bran.uwm120.bchcnt = nv_batcnt       /* bchcnt     */
            sic_bran.uwm120.class  = IF impdata_fil.poltyp = "v72" THEN impdata_fil.subclass ELSE impdata_fil.prempa + impdata_fil.subclass 
            s_recid2     = RECID(sic_bran.uwm120).
        END. 
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_policyname4 C-Win 
PROCEDURE proc_policyname4 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:     
------------------------------------------------------------------------------*/
DEF VAR nv_si AS INT INIT 0. 
DEF VAR nv_ModelYear   AS DECI INIT 0.
DEF VAR nv_campaignMS  AS CHAR INIT "".  
DEF VAR n_packcod  AS CHAR FORMAT "x(10)" INIT "" .
def var n_subclass as char format "x(4)" init "" .
def var n_covcod   as char format "x(3)" init "" .
def var n_cargrp   as char format "x(1)" init "" .
def var n_vehuse   as char format "x(1)" init "" .
def var n_garage   as char format "x(1)" init "" .
def var n_si       as DECI init 0 .
def var n_brand    as char format "x(25)" init "" .
def var n_model    as char format "x(30)" init "" .
def var n_premt    as DECI init 0 .

DO:
     ASSIGN fi_process = "Check Campaign (campaign_fil)..." + impdata_fil.policyno .
     DISP fi_process WITH FRAM fr_main.
     
     IF impdata_fil.packcod <> "" AND impdata_fil.poltyp = "V70"  THEN DO:
         ASSIGN n_yr = 0
                n_yr = (YEAR(TODAY) - DECI(impdata_fil.yrmanu)).

       IF ra_type = 1 THEN DO: 
           IF n_yr = 0 OR n_yr = 1 THEN n_yr = 1 . 
           ELSE n_yr = n_yr + 1.
       END.
       IF impdata_fil.covcod = "1"  THEN DO:
           IF impdata_fil.subclass <> "110" THEN DO:  /* 110E 210 320 */ /*A64-0044 */
             IF impdata_fil.cargrp <> "" AND impdata_fil.vehuse <> ""  THEN DO:
               FIND LAST stat.campaign_fil USE-INDEX campfil04  WHERE 
                   stat.campaign_fil.camcod = impdata_fil.packcod   AND /* campaign no */
                   stat.campaign_fil.sclass = impdata_fil.subclass  AND /* class 110 210 320 */
                   stat.campaign_fil.covcod = impdata_fil.covcod    AND /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                   stat.campaign_fil.vehgrp = impdata_fil.cargrp    AND /* group car */
                   stat.campaign_fil.vehuse = impdata_fil.vehuse    AND /* ประเภทการใช้รถ */
                   stat.campaign_fil.garage = impdata_fil.garage          AND /* การซ่อม */
                   stat.campaign_fil.maxyea = n_yr                    AND /* อายุรถ */
                   stat.campaign_fil.simax  = deci(impdata_fil.si)        AND  /* ทุน */
                   stat.campaign_fil.makdes = impdata_fil.brand     AND 
                   (index(impdata_fil.model,stat.campaign_fil.moddes) <> 0  OR   /* Model */
                   index(stat.campaign_fil.moddes,impdata_fil.model) <> 0 ) AND   /* Model */ /*A64-0044*/
                   stat.campaign_fil.netprm  = impdata_fil.premt         NO-LOCK NO-ERROR.   
             END.
             ELSE DO:
                  FIND LAST stat.campaign_fil USE-INDEX campfil04  WHERE 
                   stat.campaign_fil.camcod = impdata_fil.packcod   AND /* campaign no */
                   stat.campaign_fil.sclass = impdata_fil.subclass  AND /* class 110 210 320 */
                   stat.campaign_fil.covcod = impdata_fil.covcod    AND /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                   stat.campaign_fil.garage = impdata_fil.garage    AND /* การซ่อม */
                   stat.campaign_fil.maxyea = n_yr              AND /* อายุรถ */
                   stat.campaign_fil.simax  = deci(impdata_fil.si)  AND  /* ทุน */
                   stat.campaign_fil.makdes = impdata_fil.brand     AND 
                   (index(impdata_fil.model,stat.campaign_fil.moddes) <> 0  OR   /* Model */
                   index(stat.campaign_fil.moddes,impdata_fil.model) <> 0 ) AND   /* Model */ /*A64-0044*/
                   stat.campaign_fil.netprm  = impdata_fil.premt         NO-LOCK NO-ERROR. 
             END.
             /*IF AVAIL stat.campaign_fil THEN ASSIGN nv_polmaster = stat.campaign_fil.polmst.*/  /* A64-0044 */
             /* add by : A64-0044 */
             IF AVAIL stat.campaign_fil THEN 
                 ASSIGN   impdata_fil.polmaster = stat.campaign_fil.polmst
                          impdata_fil.seat41    = stat.campaign_fil.seat41. 
             /* end : A64-0044 */
             ELSE DO: 
                IF deci(impdata_fil.si) > 1000000 THEN DO:
                    ASSIGN nv_si = 0
                           nv_si = deci(impdata_fil.si) + 40000 .
                    FIND LAST stat.campaign_fil USE-INDEX campfil04  WHERE 
                     stat.campaign_fil.camcod = impdata_fil.packcod   AND /* campaign no */
                     stat.campaign_fil.sclass = impdata_fil.subclass  AND /* class 110 210 320 */
                     stat.campaign_fil.covcod = impdata_fil.covcod    AND /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                     stat.campaign_fil.garage = impdata_fil.garage          AND /* การซ่อม */
                     stat.campaign_fil.maxyea = n_yr                    AND /* อายุรถ */
                     stat.campaign_fil.simax  >= deci(impdata_fil.si)       AND
                     stat.campaign_fil.simax  <= nv_si                  AND
                     stat.campaign_fil.makdes = impdata_fil.brand     AND 
                     (index(impdata_fil.model,stat.campaign_fil.moddes) <> 0  OR   /* Model */
                   index(stat.campaign_fil.moddes,impdata_fil.model) <> 0 ) AND   /* Model */ /*A64-0044*/
                     stat.campaign_fil.netprm   = impdata_fil.premt           NO-LOCK NO-ERROR.   /* Model */
                    /*IF AVAIL stat.campaign_fil THEN ASSIGN nv_polmaster = stat.campaign_fil.polmst.
                    ELSE ASSIGN nv_polmaster = "" .*/ /*A64-0044*/
                    /* add by : A64-0044 */
                    IF AVAIL stat.campaign_fil THEN 
                        ASSIGN   impdata_fil.polmaster = stat.campaign_fil.polmst
                                 impdata_fil.seat41    = stat.campaign_fil.seat41. 
                    ELSE ASSIGN impdata_fil.polmaster = "" . 
                    /* end : A64-0044 */
                END. /* end si > 1000000 */
             END.
             /* ไม่เช็คอายุรถ */
             /*IF nv_polmaster = "" THEN DO: */ /*A64-0044*/
             IF impdata_fil.polmaster = "" THEN DO:  /*A64-0044*/
               /* A64-0044 */
               n_model = "" .
               IF INDEX(impdata_fil.model," ") <> 0 THEN ASSIGN n_model = SUBSTR(impdata_fil.model,1,INDEX(impdata_fil.model," ") - 1).
               ELSE n_model = TRIM(impdata_fil.model) .
               /* end : A64-0044 */
               FIND LAST stat.campaign_fil /*USE-INDEX campfil01*/  WHERE 
                    stat.campaign_fil.camcod = impdata_fil.packcod     AND /* campaign no */
                    stat.campaign_fil.sclass = impdata_fil.subclass    AND /* class 110 210 320 */
                    stat.campaign_fil.covcod = impdata_fil.covcod      AND /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                    stat.campaign_fil.garage = impdata_fil.garage      AND /* การซ่อม */
                    stat.campaign_fil.maxyea = 1                   AND /* อายุรถ */
                    stat.campaign_fil.simax  = deci(impdata_fil.si)    AND  /* ทุน */
                    stat.campaign_fil.makdes = impdata_fil.brand       AND 
                    (index(n_model,stat.campaign_fil.moddes) <> 0  OR   /* Model */
                    index(stat.campaign_fil.moddes,n_model) <> 0 ) AND   /* Model */ /*A64-0044*/
                    stat.campaign_fil.netprm  = impdata_fil.premt         NO-LOCK NO-ERROR. 
                /*IF AVAIL stat.campaign_fil THEN ASSIGN nv_polmaster = stat.campaign_fil.polmst.*/     /*A64-0044*/
                  /* add by : A64-0044 */
                     IF AVAIL stat.campaign_fil THEN 
                         ASSIGN   impdata_fil.polmaster = stat.campaign_fil.polmst
                                  impdata_fil.seat41    = stat.campaign_fil.seat41. 
                 /* end A64-0044 */
             END.
           END. /* end <> 110 */
           ELSE DO:  /* class 110 */
               RUN proc_campaign110.
           END.
       END. /* end ป.1 */
       ELSE IF (impdata_fil.covcod = "2.1") OR (impdata_fil.covcod = "3.1") OR 
               (impdata_fil.covcod = "2.2") OR (impdata_fil.covcod = "3.2") THEN DO:
           IF impdata_fil.subclass <> "110" THEN DO:  /*A64-0044*/
            FIND LAST stat.campaign_fil /*USE-INDEX campfil15*/  WHERE                
                stat.campaign_fil.camcod  =  impdata_fil.packcod         and       /*campaign */ /*A63-0443*/
                stat.campaign_fil.sclass  =  impdata_fil.subclass        and       /* class 110 210 320 */
                stat.campaign_fil.covcod  =  impdata_fil.covcod          and       /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                stat.campaign_fil.garage  =  impdata_fil.garage          and       /*   ประเภทการซ่อม   */
               (stat.campaign_fil.simin   <= deci(impdata_fil.siplus)    and       /*   วงเงินทุนประกันต่ำสุด */
                stat.campaign_fil.simax   >= deci(impdata_fil.siplus))   AND       /*   วงเงินทุนประกันสูงสุด */
                stat.campaign_fil.makdes   = impdata_fil.brand           AND 
                (index(impdata_fil.model,stat.campaign_fil.moddes) <> 0  OR   /* Model */
                 index(stat.campaign_fil.moddes,impdata_fil.model) <> 0 ) AND   /* Model */ /*A64-0044*/
                stat.campaign_fil.netprm   = impdata_fil.premt           NO-LOCK NO-ERROR.  /* เบี้ยจากไฟล์ */
                /*IF AVAIL stat.campaign_fil THEN ASSIGN nv_polmaster = stat.campaign_fil.polmst.
                ELSE ASSIGN nv_polmaster = "" .*/ /*A64-0044*/
              /* add by : A64-0044 */
              IF AVAIL stat.campaign_fil THEN 
                 ASSIGN   impdata_fil.polmaster = stat.campaign_fil.polmst
                          impdata_fil.seat41    = stat.campaign_fil.seat41. 
              ELSE ASSIGN impdata_fil.polmaster = "" . 
             /* end : A64-0044 */
           END.
           /* create by : A64-0044 */
           ELSE DO: /* class 110 */
               IF impdata_fil.engcc <= 2000 THEN DO:
                    FIND LAST stat.campaign_fil /*USE-INDEX campfil15*/  WHERE                
                     stat.campaign_fil.camcod  =  impdata_fil.packcod         and       /*campaign */ /*A63-0443*/
                     stat.campaign_fil.sclass  =  impdata_fil.subclass        and       /* class 110 210 320 */
                     stat.campaign_fil.covcod  =  impdata_fil.covcod          and       /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                     stat.campaign_fil.garage  =  impdata_fil.garage          and       /*   ประเภทการซ่อม   */
                     stat.campaign_fil.engine  <= 2000                    AND /* cc */   
                    (stat.campaign_fil.simin   <= deci(impdata_fil.siplus)    and       /*   วงเงินทุนประกันต่ำสุด */
                     stat.campaign_fil.simax   >= deci(impdata_fil.siplus))   AND       /*   วงเงินทุนประกันสูงสุด */
                     stat.campaign_fil.makdes   = impdata_fil.brand           AND 
                     (index(impdata_fil.model,stat.campaign_fil.moddes) <> 0  OR   /* Model */
                      index(stat.campaign_fil.moddes,impdata_fil.model) <> 0 ) AND   /* Model */ /*A64-0044*/
                     stat.campaign_fil.netprm   = impdata_fil.premt           NO-LOCK NO-ERROR.  /* เบี้ยจากไฟล์ */
               END.
               ELSE DO:
                    FIND LAST stat.campaign_fil /*USE-INDEX campfil15*/  WHERE                
                     stat.campaign_fil.camcod  =  impdata_fil.packcod         and       /*campaign */ /*A63-0443*/
                     stat.campaign_fil.sclass  =  impdata_fil.subclass        and       /* class 110 210 320 */
                     stat.campaign_fil.covcod  =  impdata_fil.covcod          and       /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                     stat.campaign_fil.garage  =  impdata_fil.garage          and       /*   ประเภทการซ่อม   */
                     stat.campaign_fil.engine  > 2000                     AND /* cc */  
                    (stat.campaign_fil.simin   <= deci(impdata_fil.siplus)    and       /*   วงเงินทุนประกันต่ำสุด */
                     stat.campaign_fil.simax   >= deci(impdata_fil.siplus))   AND       /*   วงเงินทุนประกันสูงสุด */
                     stat.campaign_fil.makdes   = impdata_fil.brand           AND 
                     (index(impdata_fil.model,stat.campaign_fil.moddes) <> 0  OR   /* Model */
                      index(stat.campaign_fil.moddes,impdata_fil.model) <> 0 ) AND   /* Model */ /*A64-0044*/
                     stat.campaign_fil.netprm   = impdata_fil.premt           NO-LOCK NO-ERROR.  /* เบี้ยจากไฟล์ */

               END.
              IF AVAIL stat.campaign_fil THEN 
                 ASSIGN   impdata_fil.polmaster = stat.campaign_fil.polmst
                          impdata_fil.seat41    = stat.campaign_fil.seat41. 
              ELSE ASSIGN impdata_fil.polmaster = "" . 
           END.
          /* end : A64-0044 */
       END. /* end ป.2+ ป.3+ */
       ELSE DO: /* ป2 ป3 */
           FIND LAST stat.campaign_fil /*USE-INDEX campfil15*/  WHERE                
               stat.campaign_fil.camcod  = impdata_fil.packcod  and       /*campaign */ /*A63-0443*/
               stat.campaign_fil.sclass  = impdata_fil.subclass and       /* class 110 210 320 */
               stat.campaign_fil.covcod  = impdata_fil.covcod   and       /* cover 1 2 3 2.1 2.2 3.1 3.2 */
               stat.campaign_fil.makdes  = impdata_fil.brand     AND 
               (index(impdata_fil.model,stat.campaign_fil.moddes) <> 0  OR   /* Model */
                 index(stat.campaign_fil.moddes,impdata_fil.model) <> 0 ) AND   /* Model */ /*A64-0044*/
               stat.campaign_fil.netprm  = impdata_fil.premt           NO-LOCK NO-ERROR.  /* เบี้ยจากไฟล์ */
            /*IF AVAIL stat.campaign_fil THEN ASSIGN nv_polmaster = stat.campaign_fil.polmst.
            ELSE ASSIGN nv_polmaster = "" . */ /*A64-0044*/
            /* add by : A64-0044 */
            IF AVAIL stat.campaign_fil THEN 
              ASSIGN   impdata_fil.polmaster = stat.campaign_fil.polmst
                       impdata_fil.seat41    = stat.campaign_fil.seat41. 
            ELSE ASSIGN impdata_fil.polmaster = "" . 
            /* end : A64-0044*/
       END.
       /*IF nv_polmaster = "" THEN impdata_fil.comment = "ไม่พบ Policy Master ตามรายละเอียดของไฟล์นำเข้าในแพ็คเกจ " + impdata_fil.packcod.*/  /*A64-0044*/
       /* A64-0044 */
       IF impdata_fil.polmaster = "" THEN 
          ASSIGN  impdata_fil.comment = "ไม่พบ Policy Master ตามรายละเอียดของไฟล์นำเข้าในแพ็คเกจ " + impdata_fil.packcod
                  impdata_fil.pass    = "N" 
                  impdata_fil.OK_GEN  = "N".
       /* end : A64-0044 */
     END.
     RELEASE stat.campaign_fil.
      
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_prmtxt C-Win 
PROCEDURE proc_prmtxt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

ASSIGN 
    /*nv_acc6 = IF TRIM(impdata_fil2.accdata) = "" THEN "" 
              ELSE TRIM(impdata_fil2.accdata) + " ราคารวมอุปกรณ์เสริม " +  trim(impdata_fil2.price_acc) + " บาท"*/
    nv_acc1 = ""
    nv_acc2 = ""
    nv_acc3 = ""
    nv_acc4 = ""
    nv_acc5 = ""
    nv_acc6 = "" 
    nv_acc7 = "" 
    nv_acc8 = "" 
    nv_acc9 = "" 
    nv_acc10 = "" 
    nv_acc1 = impacc_fil.accdata1  
    nv_acc2 = impacc_fil.accdata2  
    nv_acc3 = impacc_fil.accdata3  
    nv_acc4 = impacc_fil.accdata4  
    nv_acc5 = impacc_fil.accdata5  
    nv_acc6 = impacc_fil.accdata6  
    nv_acc7 = impacc_fil.accdata7  
    nv_acc8 = impacc_fil.accdata8  
    nv_acc9 = impacc_fil.accdata9  .

/*IFnv_acc10 =accdata10  impdata_fil3.brand_gals    <> "" THEN nv_acc6 = nv_acc6 + " ยี่ห้อเคลือบแก้ว " + TRIM(impdata_fil3.brand_gals).
/*IF (impdata_fil3.brand_galsprm <> "" ) THEN nv_acc6 = nv_acc6 + " ราคา " + TRIM(impdata_fil3.brand_galsprm).*/ /*A59-0118*/
IF (impdata_fil3.brand_galsprm <> "" ) AND (deci(impdata_fil3.brand_galsprm) <> 0 ) THEN nv_acc6 = nv_acc6 + " ราคา " + TRIM(impdata_fil3.brand_galsprm). /*A59-0118*/

loop_chk1:
REPEAT:
    IF (INDEX(nv_acc6," ") <> 0 ) AND LENGTH(nv_acc1 + TRIM(SUBSTR(nv_acc6,1,INDEX(nv_acc6," ")))) <= 60 THEN 
        ASSIGN  nv_acc1 = trim(nv_acc1 + " " + TRIM(SUBSTR(nv_acc6,1,INDEX(nv_acc6," "))))
        nv_acc6 = TRIM(SUBSTR(nv_acc6,INDEX(nv_acc6," "))).
    ELSE LEAVE loop_chk1.
END.
IF nv_acc6 <> "" THEN
loop_chk2:
REPEAT:
    IF (INDEX(nv_acc6," ") <> 0 ) AND LENGTH(nv_acc2 + TRIM(SUBSTR(nv_acc6,1,INDEX(nv_acc6," ")))) <= 60 THEN 
        ASSIGN  nv_acc2 = trim(nv_acc2  + " " + TRIM(SUBSTR(nv_acc6,1,INDEX(nv_acc6," "))))
        nv_acc6 = TRIM(SUBSTR(nv_acc6,INDEX(nv_acc6," "))).
    ELSE LEAVE loop_chk2.
END.
loop_chk3:
REPEAT:
    IF (INDEX(nv_acc6," ") <> 0 ) AND LENGTH(nv_acc3 + TRIM(SUBSTR(nv_acc6,1,INDEX(nv_acc6," ")))) <= 60 THEN 
        ASSIGN  nv_acc3 = trim(nv_acc3  + " " + TRIM(SUBSTR(nv_acc6,1,INDEX(nv_acc6," "))))
        nv_acc6 = TRIM(SUBSTR(nv_acc6,INDEX(nv_acc6," "))).
    ELSE LEAVE loop_chk3.
END.
loop_chk4:
REPEAT:
    IF (INDEX(nv_acc6," ") <> 0 ) AND LENGTH(nv_acc4 + TRIM(SUBSTR(nv_acc6,1,INDEX(nv_acc6," ")))) <= 60 THEN 
        ASSIGN  nv_acc4 = trim(nv_acc4  + " " + TRIM(SUBSTR(nv_acc6,1,INDEX(nv_acc6," "))))
        nv_acc6 = TRIM(SUBSTR(nv_acc6,INDEX(nv_acc6," "))).
    ELSE LEAVE loop_chk4.
END.
loop_chk5:
REPEAT:
    IF (INDEX(nv_acc6," ") <> 0 ) AND LENGTH(nv_acc5 + TRIM(SUBSTR(nv_acc6,1,INDEX(nv_acc6," ")))) <= 60 THEN 
        ASSIGN  nv_acc5 = trim(nv_acc5  + " " + TRIM(SUBSTR(nv_acc6,1,INDEX(nv_acc6," "))))
        nv_acc6 = TRIM(SUBSTR(nv_acc6,INDEX(nv_acc6," "))).
    ELSE LEAVE loop_chk5.
END.
IF      (nv_acc5 <> "") AND (length(nv_acc5 + " " + nv_acc6 ) <= 60 ) THEN 
    ASSIGN nv_acc5 = nv_acc5  + " " + nv_acc6
    nv_acc6 = "" .
ELSE IF (nv_acc4 <> "") AND (length(nv_acc4 + " " + nv_acc6 ) <= 60 ) THEN 
    ASSIGN nv_acc4 = nv_acc4  + " " + nv_acc6 
    nv_acc6 = "" .
ELSE IF (nv_acc3 <> "") AND (length(nv_acc3 + " " + nv_acc6 ) <= 60 ) THEN 
    ASSIGN nv_acc3 = nv_acc3  + " " + nv_acc6
    nv_acc6 = "" .
ELSE IF (nv_acc2 <> "") AND (length(nv_acc2 + " " + nv_acc6 ) <= 60 ) THEN 
    ASSIGN nv_acc2 = nv_acc2  + " " + nv_acc6
    nv_acc6 = "" .
ELSE IF (nv_acc1 <> "") AND (length(nv_acc1 + " " + nv_acc6 ) <= 60 ) THEN
    ASSIGN  nv_acc1 = nv_acc1  + " " + nv_acc6
    nv_acc6 = "" .*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_report1 C-Win 
PROCEDURE proc_report1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR NOT_pass AS INTE INIT 0.
nv_row  =  1.
DEF VAR a AS CHAR FORMAT "x(100)" INIT "".
DEF VAR b AS CHAR FORMAT "x(100)" INIT "".
DEF VAR c AS INTE INIT 0.

FOR EACH impdata_fil  USE-INDEX data_fil10 WHERE 
        impdata_fil.usrid  = USERID(LDBNAME(1))   and
        impdata_fil.progid = trim(nv_proid)       and
        impdata_fil.PASS   <> "Y" NO-LOCK .
       NOT_pass = NOT_pass + 1.
END.
IF NOT_pass > 0 THEN DO:
OUTPUT STREAM ns1 TO value(fi_output2).
PUT STREAM ns1
  " risk no      "      "|"             /*1  */  
  " itemno       "      "|"             /*2  */  
  " policyno     "     "|"              /*3  */  
  " n_branch     "     "|"              /*4  */  
  " agent        "     "|"              /*5  */  
  " producer     "     "|"              /*6  */  
  " n_delercode  "     "|"              /*7  */  
  " fincode      "     "|"              /*8  */  
  " appenno      "     "|"              /*9  */  
  " salename     "     "|"              /*10 */  
  " srate        "     "|"              /*11 */  
  " comdat       "     "|"              /*12 */  
  " expdat       "     "|"              /*13 */  
  " agreedat     "     "|"              /*14 */  
  " firstdat     "     "|"              /*15 */  
  " packcod      "     "|"              /*16 */  
  " camp_no      "     "|"              /*17 */  
  " campen       "     "|"              /*18 */  
  " specon       "     "|"              /*19 */  
  " product      "     "|"              /*20 */  
  " promo        "     "|"              /*21 */  
  " rencnt       "     "|"              /*22 */  
  " prepol       "     "|"              /*23 */  
  " txt1         "     "|"              /*24 */  
  " txt2         "     "|"              /*25 */  
  " txt3         "     "|"              /*26 */  
  " txt4         "     "|"              /*27 */  
  " txt5         "     "|"              /*28 */  
  " txt6         "     "|"              /*29 */  
  " txt7         "     "|"              /*30 */  
  " txt8         "     "|"              /*31 */  
  " txt9         "     "|"              /*32 */  
  " txt10        "     "|"              /*33 */  
  " memo1        "     "|"              /*34 */  
  " memo2        "     "|"              /*35 */  
  " memo3        "     "|"              /*36 */  
  " memo4        "     "|"              /*37 */  
  " memo5        "     "|"              /*38 */  
  " memo6        "     "|"              /*39 */  
  " memo7        "     "|"              /*40 */  
  " memo8        "     "|"              /*41 */  
  " memo9        "     "|"              /*42 */  
  " memo10       "     "|"              /*43 */  
  " accdata1     "     "|"              /*44 */  
  " accdata2     "     "|"              /*45 */  
  " accdata3     "     "|"              /*46 */  
  " accdata4     "     "|"              /*47 */  
  " accdata5     "     "|"              /*48 */  
  " accdata6     "     "|"              /*49 */  
  " accdata7     "     "|"              /*50 */  
  " accdata8     "     "|"              /*51 */  
  " accdata9     "     "|"              /*52 */  
  " accdata10    "     "|"              /*53 */  
  " compul       "     "|"              /*54 */  
  " insrefno     "     "|"              /*55 */  
  " instyp       "     "|"              /*56 */  
  " inslang      "     "|"              /*57 */  
  " tiname       "     "|"              /*58 */  
  " insnam       "     "|"              /*59 */  
  " lastname     "     "|"              /*60 */  
  " icno         "     "|"              /*61 */  
  " insbr        "     "|"              /*62 */  
  " occup        "     "|"              /*63 */  
  " addr         "     "|"              /*64 */  
  " tambon       "     "|"              /*65 */  
  " amper        "     "|"              /*66 */  
  " country      "     "|"              /*67 */  
  " post         "     "|"              /*68 */  
  " provcod      "     "|"              /*69 */  
  " distcod      "     "|"              /*70 */  
  " sdistcod     "     "|"              /*71 */  
  " jpAE code    "     "|"              /*72 */  
  " jpJT Code    "     "|"              /*73 */  
  " jpTS code    "     "|"              /*74 */  
  " gender       "     "|"              /*75 */  
  " tele1        "     "|"              /*76 */  
  " tele2        "     "|"              /*77 */  
  " mail1        "     "|"              /*78 */  
  " mail2        "     "|"              /*79 */  
  " mail3        "     "|"              /*80 */  
  " mail4        "     "|"              /*81 */  
  " mail5        "     "|"              /*82 */  
  " mail6        "     "|"              /*83 */  
  " mail7        "     "|"              /*84 */  
  " mail8        "     "|"              /*85 */  
  " mail9        "     "|"              /*86 */  
  " mail10       "     "|"              /*87 */  
  " fax          "     "|"              /*88 */  
  " lineID       "     "|"              /*89 */  
  " name2        "     "|"              /*90 */  
  " name3        "     "|"              /*91 */  
  " benname      "     "|"              /*92 */  
  " payercod     "     "|"              /*93 */  
  " vatcode      "     "|"              /*94 */  
  " instcod1     "     "|"              /*95 */  
  " insttyp1     "     "|"              /*96 */  
  " insttitle1   "     "|"              /*97 */  
  " instname1    "     "|"              /*98 */  
  " instlname1   "     "|"              /*99 */  
  " instic1      "     "|"              /*100*/  
  " instbr1      "     "|"              /*101*/  
  " instaddr11   "     "|"              /*102*/  
  " instaddr21   "     "|"              /*103*/  
  " instaddr31   "     "|"              /*104*/  
  " instaddr41   "     "|"              /*105*/  
  " instpost1    "     "|"              /*106*/  
  " instprovcod1 "     "|"              /*107*/  
  " instdistcod1 "     "|"              /*108*/  
  " instsdistcod1"     "|"              /*109*/  
  " instprm1     "     "|"              /*110*/  
  " instrstp1    "     "|"              /*111*/  
  " instrtax1    "     "|"              /*112*/  
  " instcomm01   "     "|"              /*113*/  
  " instcomm12   "     "|"              /*114*/  
  " instcod2     "     "|"              /*115*/  
  " insttyp2     "     "|"              /*116*/  
  " insttitle2   "     "|"              /*117*/  
  " instname2    "     "|"              /*118*/  
  " instlname2   "     "|"              /*119*/  
  " instic2      "     "|"              /*120*/  
  " instbr2      "     "|"              /*121*/  
  " instaddr12   "     "|"              /*122*/  
  " instaddr22   "     "|"              /*123*/  
  " instaddr32   "     "|"              /*124*/  
  " instaddr42   "     "|"              /*125*/  
  " instpost2    "     "|"              /*126*/  
  " instprovcod2 "     "|"              /*127*/  
  " instdistcod2 "     "|"              /*128*/  
  " instsdistcod2"     "|"              /*129*/  
  " instprm2     "     "|"              /*130*/  
  " instrstp2    "     "|"              /*131*/  
  " instrtax2    "     "|"              /*132*/  
  " instcomm02   "     "|"              /*133*/  
  " instcomm22   "     "|"              /*134*/  
  " instcod3     "     "|"              /*135*/  
  " insttyp3     "     "|"              /*136*/  
  " insttitle3   "     "|"              /*137*/  
  " instname3    "     "|"              /*138*/  
  " instlname3   "     "|"              /*139*/  
  " instic3      "     "|"              /*140*/  
  " instbr3      "     "|"              /*141*/  
  " instaddr13   "     "|"              /*142*/  
  " instaddr23   "     "|"              /*143*/  
  " instaddr33   "     "|"              /*144*/  
  " instaddr43   "     "|"              /*145*/  
  " instpost3    "     "|"              /*146*/  
  " instprovcod3 "     "|"              /*147*/  
  " instdistcod3 "     "|"              /*148*/  
  " instsdistcod3"     "|"              /*149*/  
  " instprm3     "     "|"              /*150*/  
  " instrstp3    "     "|"              /*151*/  
  " instrtax3    "     "|"              /*152*/  
  " instcomm03   "     "|"              /*153*/  
  " instcomm23   "     "|"              /*154*/  
  " covcod       "     "|"              /*155*/  
  " garage       "     "|"              /*156*/  
  " special      "     "|"              /*157*/  
  " inspec       "     "|"              /*158*/  
  " class70      "     "|"              /*159*/
  " Vehuse       "     "|"              /*A65-0079*/
  " redbook      "     "|"              /*A65-0079*/
  " brand        "     "|"              /*160*/  
  " model        "     "|"              /*161*/  
  " submodel     "     "|"              /*162*/  
  " caryear      "     "|"              /*163*/  
  " chasno       "     "|"              /*164*/  
  " eng          "     "|"              /*165*/  
  " seat         "     "|"              /*166*/  
  " engcc        "     "|"              /*167*/  
  " weight       "     "|"              /*168*/  
  " watt         "     "|"              /*169*/  
  " body         "     "|"              /*170*/  
  " type         "     "|"              /*171*/  
  " re_year      "     "|"              /*172*/  
  " vehreg       "     "|"              /*173*/  
  " re_country   "     "|"              /*174*/  
  " cargrp       "     "|"              /*175*/  
  " colorcar     "     "|"              /*176*/  
  " fule         "     "|"              /*177*/  
  " drivnam      "     "|"              /*178*/  
  " ntitle1      "     "|"              /*179*/  
  " drivername1  "     "|"              /*180*/  
  " dname2       "     "|"              /*181*/  
  " dicno        "     "|"              /*182*/  
  " dgender1     "     "|"              /*183*/  
  " dbirth       "     "|"              /*184*/  
  " docoup       "     "|"              /*185*/  
  " ddriveno     "     "|"              /*186*/  
  " ntitle2      "     "|"              /*187*/  
  " drivername2  "     "|"              /*188*/  
  " ddname1      "     "|"              /*189*/  
  " ddicno       "     "|"              /*190*/  
  " dgender2     "     "|"              /*191*/  
  " ddbirth      "     "|"              /*192*/  
  " ddocoup      "     "|"              /*193*/  
  " dddriveno    "     "|"              /*194*/  
  " baseplus     "     "|"              /*195*/  
  " siplus       "     "|"              /*196*/  
  " rs10         "     "|"              /*197*/  
  " comper       "     "|"              /*198*/  
  " comacc       "     "|"              /*199*/  
  " deductpd     "     "|"              /*200*/  
  " DOD          "     "|"              /*201*/ 
  " DOD1         "     "|"              /*A65-0079*/
  " DPD          "     "|"              /*202*/  
  " tpfire       "     "|"              /*203*/  
  " NO_41        "     "|"              /*204*/  
  " ac2          "     "|"              /*205*/  
  " ac4          "     "|"              /*206*/  
  " ac5          "     "|"              /*207*/  
  " ac6          "     "|"              /*208*/  
  " ac7          "     "|"              /*209*/  
  " NO_42        "     "|"              /*210*/  
  " NO_43        "     "|"              /*211*/  
  " base         "     "|"              /*212*/  
  " unname       "     "|"              /*213*/  
  " nname        "     "|"              /*214*/  
  " tpbi         "     "|"              /*215*/ 
  " tpbi2        "     "|"              /*A65-0079*/
  " tppd         "     "|"              /*216*/ 
  " DOD amt      "     "|"              /*A65-0079*/
  " DOD1 amt     "     "|"              /*A65-0079*/
  " DPD amt      "     "|"              /*A65-0079*/
  " ry411        "     "|"              /*217*/  
  " ry412        "     "|"              /*A65-0079*/
  " ry413        "     "|"              /*A65-0079*/
  " ry414        "     "|"              /*A65-0079*/
  " ry02         "     "|"              /*218*/  
  " ry03         "     "|"              /*219*/  
  " fleet        "     "|"              /*220*/  
  " ncb          "     "|"              /*221*/  
  " claim        "     "|"              /*222*/  
  " dspc         "     "|"              /*223*/  
  " cctv         "     "|"              /*224*/  
  " dstf         "     "|"              /*225*/  
  " fleetprem    "     "|"              /*226*/  
  " ncbprem      "     "|"              /*227*/  
  " clprem       "     "|"              /*228*/  
  " dspcprem     "     "|"              /*229*/  
  " cctvprem     "     "|"              /*230*/  
  " dstfprem     "     "|"              /*231*/  
  " premt        "     "|"              /*232*/  
  " rstp_t       "     "|"              /*233*/  
  " rtax_t       "     "|"              /*234*/  
  " comper70     "     "|"              /*235*/  
  " comprem70    "     "|"              /*236*/  
  " agco70       "     "|"              /*237*/  
  " comco_per70  "     "|"              /*238*/  
  " comco_prem70 "     "|"              /*239*/  
  " dgpackge     "     "|"              /*240*/  
  " danger1      "     "|"              /*241*/  
  " danger2      "     "|"              /*242*/  
  " dgsi         "     "|"              /*243*/  
  " dgrate       "     "|"              /*244*/  
  " dgfeet       "     "|"              /*245*/  
  " dgncb        "     "|"              /*246*/  
  " dgdisc       "     "|"              /*247*/  
  " dgWdisc      "     "|"              /*248*/  
  " dgatt        "     "|"              /*249*/  
  " dgfeetprm    "     "|"              /*250*/  
  " dgncbprm     "     "|"              /*251*/  
  " dgdiscprm    "     "|"              /*252*/
  " dgwdiscprm   "     "|"              /*253*/ 
  " dgprem       "     "|"              /*254*/  
  " dgrstp_t     "     "|"              /*255*/  
  " dgrtax_t     "     "|"              /*256*/  
  " dgcomper     "     "|"              /*257*/  
  " dgcomprem    "     "|"              /*258*/  
  " cltxt        "     "|"              /*259*/  
  " clamount     "     "|"              /*260*/  
  " faultno      "     "|"              /*261*/  
  " faultprm     "     "|"              /*262*/  
  " goodno       "     "|"              /*263*/  
  " goodprm      "     "|"              /*264*/  
  " loss         "     "|"              /*265*/  
  " compolusory  "     "|"              /*266*/  
  " barcode      "     "|"              /*267*/  
  " class72      "     "|"              /*268*/  
  " dstf72       "     "|"              /*269*/  
  " dstfprem72   "     "|"              /*270*/  
  " premt72      "     "|"              /*271*/  
  " rstp_t72     "     "|"              /*272*/  
  " rtax_t72     "     "|"              /*273*/  
  " comper72     "     "|"              /*274*/  
  " comprem72    "     "|"              /*275*/  
  " Comment      "     SKIP .            
    RUN proc_report1_detail.
END.                                                                                    
OUTPUT STREAM ns1 CLOSE.                                                      
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_report1_detail C-Win 
PROCEDURE proc_report1_detail :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:

    FOR EACH impdata_fil  USE-INDEX data_fil10 WHERE 
        impdata_fil.usrid  = USERID(LDBNAME(1))   and
        impdata_fil.progid = trim(nv_proid)       and
        impdata_fil.PASS   <> "Y" NO-LOCK  BY impdata_fil.riskno .

        FIND FIRST imptxt_fil  use-index txt_fil02  WHERE 
            imptxt_fil.usrid    = impdata_fil.usrid     and
            imptxt_fil.progid   = impdata_fil.progid    and
            imptxt_fil.policyno = trim(impdata_fil.policyno) NO-LOCK NO-ERROR .

        FIND FIRST impmemo_fil use-index memo_fil02 WHERE 
            impmemo_fil.usrid    = impdata_fil.usrid    and
            impmemo_fil.progid   = impdata_fil.progid   and
            impmemo_fil.policyno = trim(impdata_fil.policyno) NO-LOCK NO-ERROR .

        FIND FIRST impacc_fil  use-index acc_fil03  WHERE 
            impacc_fil.policyno = TRIM(impdata_fil.policyno) AND
            impacc_fil.riskno   = impdata_fil.riskno   AND
            impacc_fil.itemno   = impdata_fil.itemno   AND 
            impmemo_fil.usrid   = impdata_fil.usrid    and
            impmemo_fil.progid  = impdata_fil.progid   NO-LOCK NO-ERROR .

        FIND FIRST impinst_fil USE-INDEX inst_fil02 WHERE
            impinst_fil.usrid    = impdata_fil.usrid    and    
            impinst_fil.progid   = impdata_fil.progid   and    
            impinst_fil.policyno = trim(impdata_fil.policyno) NO-LOCK NO-ERROR .

        PUT STREAM ns1
            impdata_fil.riskno       "|"
            impdata_fil.itemno       "|"
            impdata_fil.policyno FORMAT "x(15)"    "|"
            impdata_fil.n_branch     "|"
            impdata_fil.agent        "|"
            impdata_fil.producer     "|"
            impdata_fil.n_delercode  "|"
            impdata_fil.fincode      "|"
            impdata_fil.appenno      "|"
            impdata_fil.salename     "|"
            impdata_fil.srate        "|"
            impdata_fil.comdat       "|"
            impdata_fil.expdat       "|"
            impdata_fil.agreedat     "|"
            impdata_fil.firstdat     "|"
            impdata_fil.packcod      "|"
            impdata_fil.camp_no      "|"
            impdata_fil.campen       "|"
            impdata_fil.specon       "|"
            impdata_fil.product      "|"
            impdata_fil.promo        "|"
            impdata_fil.rencnt       "|"
            impdata_fil.prepol       "|"
            imptxt_fil.txt1            "|"
            imptxt_fil.txt2            "|"
            imptxt_fil.txt3            "|"
            imptxt_fil.txt4            "|"
            imptxt_fil.txt5            "|"
            imptxt_fil.txt6            "|"
            imptxt_fil.txt7            "|"
            imptxt_fil.txt8            "|"
            imptxt_fil.txt9            "|"
            imptxt_fil.txt10           "|"
            impmemo_fil.memo1           "|"
            impmemo_fil.memo2           "|"
            impmemo_fil.memo3           "|"
            impmemo_fil.memo4           "|"
            impmemo_fil.memo5           "|"
            impmemo_fil.memo6           "|"
            impmemo_fil.memo7           "|"
            impmemo_fil.memo8           "|"
            impmemo_fil.memo9           "|"
            impmemo_fil.memo10          "|"
            impacc_fil.accdata1       "|"
            impacc_fil.accdata2       "|"
            impacc_fil.accdata3       "|"
            impacc_fil.accdata4       "|"
            impacc_fil.accdata5       "|"
            impacc_fil.accdata6       "|"
            impacc_fil.accdata7       "|"
            impacc_fil.accdata8       "|"
            impacc_fil.accdata9       "|"
            impacc_fil.accdata10      "|"
            impdata_fil.compul        "|"
            impdata_fil.insref        "|"
            impdata_fil.instyp        "|"
            impdata_fil.inslang       "|"
            impdata_fil.tiname        "|"
            impdata_fil.insnam        "|"
            impdata_fil.lastname      "|"
            impdata_fil.icno          "|"
            impdata_fil.insbr         "|"
            impdata_fil.occup         "|"
            impdata_fil.addr          "|"
            impdata_fil.tambon        "|"
            impdata_fil.amper         "|"
            impdata_fil.country       "|"
            impdata_fil.post          "|"
            impdata_fil.provcod       "|"
            impdata_fil.distcod       "|"
            impdata_fil.sdistcod      "|"
            impdata_fil.jpae          "|"
            impdata_fil.jpjtl         "|"
            impdata_fil.jpts          "|"
            impdata_fil.gender        "|"
            impdata_fil.tele1         "|"
            impdata_fil.tele2         "|"
            impdata_fil.mail1         "|"
            impdata_fil.mail2         "|"
            impdata_fil.mail3         "|"
            impdata_fil.mail4         "|"
            impdata_fil.mail5         "|"
            impdata_fil.mail6         "|"
            impdata_fil.mail7         "|"
            impdata_fil.mail8         "|"
            impdata_fil.mail9         "|"
            impdata_fil.mail10        "|"
            impdata_fil.fax           "|"
            impdata_fil.lineID        "|"
            impdata_fil.name2         "|"
            impdata_fil.name3         "|"
            impdata_fil.benname       "|"
            impdata_fil.payercod      "|"
            impdata_fil.vatcode       "|"
            impinst_fil.instcod1        "|"
            impinst_fil.insttyp1        "|"
            impinst_fil.insttitle1      "|"
            impinst_fil.instname1       "|"
            impinst_fil.instlname1      "|"
            impinst_fil.instic1         "|"
            impinst_fil.instbr1         "|"
            impinst_fil.instaddr11      "|"
            impinst_fil.instaddr21      "|"
            impinst_fil.instaddr31      "|"
            impinst_fil.instaddr41      "|"
            impinst_fil.instpost1       "|"
            impinst_fil.instprovcod1    "|"
            impinst_fil.instdistcod1    "|"
            impinst_fil.instsdistcod1   "|"
            impinst_fil.instprm1        "|"
            impinst_fil.instrstp1       "|"
            impinst_fil.instrtax1       "|"
            impinst_fil.instcomm01      "|"
            impinst_fil.instcomm12      "|"
            impinst_fil.instcod2        "|"
            impinst_fil.insttyp2        "|"
            impinst_fil.insttitle2      "|"
            impinst_fil.instname2       "|"
            impinst_fil.instlname2      "|"
            impinst_fil.instic2         "|"
            impinst_fil.instbr2         "|"
            impinst_fil.instaddr12      "|"
            impinst_fil.instaddr22      "|"
            impinst_fil.instaddr32      "|"
            impinst_fil.instaddr42      "|"
            impinst_fil.instpost2       "|"
            impinst_fil.instprovcod2    "|"
            impinst_fil.instdistcod2    "|"
            impinst_fil.instsdistcod2   "|"
            impinst_fil.instprm2        "|"
            impinst_fil.instrstp2       "|"
            impinst_fil.instrtax2       "|"
            impinst_fil.instcomm02      "|"
            impinst_fil.instcomm22      "|"
            impinst_fil.instcod3        "|"
            impinst_fil.insttyp3        "|"
            impinst_fil.insttitle3      "|"
            impinst_fil.instname3       "|"
            impinst_fil.instlname3      "|"
            impinst_fil.instic3         "|"
            impinst_fil.instbr3         "|"
            impinst_fil.instaddr13      "|"
            impinst_fil.instaddr23      "|"
            impinst_fil.instaddr33      "|"
            impinst_fil.instaddr43      "|"
            impinst_fil.instpost3       "|"
            impinst_fil.instprovcod3    "|"
            impinst_fil.instdistcod3    "|"
            impinst_fil.instsdistcod3   "|"
            impinst_fil.instprm3        "|"
            impinst_fil.instrstp3       "|"
            impinst_fil.instrtax3       "|"
            impinst_fil.instcomm03      "|"
            impinst_fil.instcomm23      "|"
            impdata_fil.covcod        "|"
            impdata_fil.garage        "|"
            impdata_fil.special       "|"
            impdata_fil.inspec        "|"
            impdata_fil.class70       "|"
            impdata_fil.vehuse        "|" 
            impdata_fil.redbook       "|" /*A65-0079*/
            impdata_fil.brand         "|"
            impdata_fil.model         "|"
            impdata_fil.submodel      "|"
            impdata_fil.yrmanu        "|"
            impdata_fil.chasno        "|"
            impdata_fil.eng           "|"
            impdata_fil.seat41        "|"
            impdata_fil.engcc         "|"
            impdata_fil.weight        "|"
            impdata_fil.watt          "|"
            impdata_fil.body          "|"
            impdata_fil.typ           "|"
            impdata_fil.re_year       "|"
            impdata_fil.vehreg        "|"
            impdata_fil.re_country    "|"
            impdata_fil.cargrp        "|"
            impdata_fil.colorcar      "|"
            impdata_fil.fule          "|"
            impdata_fil.drivnam       "|"
            impdata_fil.ntitle1       "|"
            impdata_fil.drivername1   "|"
            impdata_fil.dname2        "|"
            impdata_fil.dicno         "|"
            impdata_fil.dgender1      "|"
            impdata_fil.dbirth        "|"
            impdata_fil.docoup        "|"
            impdata_fil.ddriveno      "|"
            impdata_fil.ntitle2       "|"
            impdata_fil.drivername2   "|"
            impdata_fil.ddname1       "|"
            impdata_fil.ddicno        "|"
            impdata_fil.dgender2      "|"
            impdata_fil.ddbirth       "|"
            impdata_fil.ddocoup       "|"
            impdata_fil.dddriveno     "|"
            impdata_fil.baseplus      "|"
            impdata_fil.siplus        "|"
            impdata_fil.rs10          "|"
            impdata_fil.comper        "|"
            impdata_fil.comacc        "|"
            impdata_fil.deductpd      "|"
            impdata_fil.DOD           "|"
            impdata_fil.dgatt         "|" /*A65-0079*/
            impdata_fil.DPD           "|"
            impdata_fil.si            "|"
            impdata_fil.NO_411        "|"
            impdata_fil.seat41        "|"
            impdata_fil.NO_412        "|"
            impdata_fil.NO_413        "|"
            impdata_fil.pass_no       "|"
            impdata_fil.NO_414        "|"
            impdata_fil.NO_42         "|"
            impdata_fil.NO_43         "|"
            impdata_fil.base          "|"
            impdata_fil.unname        "|"
            impdata_fil.nname         "|"
            impdata_fil.tpbi          "|"
            impdata_fil.dgsi          "|" /*A65-0079*/
            impdata_fil.tppd          "|"
            impdata_fil.int1          "|" /*A65-0079*/
            impdata_fil.int2          "|" /*A65-0079*/
            impdata_fil.int3          "|" /*A65-0079*/
            impdata_fil.ry01          "|"
            impdata_fil.deci1         "|" /*A65-0079*/       
            impdata_fil.deci2         "|" /*A65-0079*/       
            impdata_fil.deci3         "|" /*A65-0079*/       
            impdata_fil.ry02          "|"
            impdata_fil.ry03          "|"
            impdata_fil.fleet         "|"
            impdata_fil.ncb           "|"
            impdata_fil.claim         "|"
            impdata_fil.dspc          "|"
            impdata_fil.cctv          "|"
            impdata_fil.dstf          "|"
            impdata_fil.fleetprem     "|"
            impdata_fil.ncbprem       "|"
            impdata_fil.clprem        "|"
            impdata_fil.dspcprem      "|"
            impdata_fil.cctvprem      "|"
            impdata_fil.dstfprem      "|"
            impdata_fil.premt         "|"
            impdata_fil.rstp_t        "|"
            impdata_fil.rtax_t        "|"
            impdata_fil.comper70      "|"
            impdata_fil.comprem70     "|"
            impdata_fil.agco70        "|"
            impdata_fil.comco_per70   "|"
            impdata_fil.comco_prem70  "|"
            impdata_fil.dgpackge      "|"
            impdata_fil.danger1       "|"
            impdata_fil.danger2       "|"
            " "   /*impdata_fil.dgsi A65-0079 */ "|"
            impdata_fil.dgrate        "|"        
            impdata_fil.dgfeet        "|"        
            impdata_fil.dgncb         "|"        
            impdata_fil.dgdisc        "|"        
            impdata_fil.dgWdisc       "|"        
            " " /*impdata_fil.dgatt A65-0079*/   "|"
            impdata_fil.dgfeetprm     "|"
            impdata_fil.dgncbprm      "|"
            impdata_fil.dgdiscprm     "|"
            impdata_fil.dgWdiscprm    "|"
            impdata_fil.dgprem        "|"
            impdata_fil.dgrstp_t      "|"
            impdata_fil.dgrtax_t      "|"
            impdata_fil.dgcomper      "|"
            impdata_fil.dgcomprem     "|"
            impdata_fil.cltxt         "|"
            impdata_fil.clamount      "|"
            impdata_fil.faultno       "|"
            impdata_fil.faultprm      "|"
            impdata_fil.goodno        "|"
            impdata_fil.goodprm       "|"
            impdata_fil.loss          "|"
            impdata_fil.compolusory   "|"
            impdata_fil.stk           "|"
            impdata_fil.class72       "|"
            impdata_fil.dstf72        "|"
            impdata_fil.dstfprem72    "|"
            impdata_fil.premt72       "|"
            impdata_fil.rstp_t72      "|"
            impdata_fil.rtax_t72      "|"
            impdata_fil.comper72      "|"
            impdata_fil.comprem72     "|"
            impdata_fil.comment       SKIP .
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PROC_REPORT2 C-Win 
PROCEDURE PROC_REPORT2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR HEAD AS CHAR INIT "Y".
nv_row  =  1.
DEF VAR a AS CHAR FORMAT "x(20)" INIT "".
DEF VAR b AS CHAR FORMAT "x(20)" INIT "".
DEF VAR c AS INTE INIT 0.
DEF VAR d AS INTE INIT 0.
DEF VAR f AS CHAR FORMAT "x(20)" INIT "".
DEF VAR pass AS INTE INIT 0.
FOR EACH impdata_fil  USE-INDEX data_fil10 WHERE 
        impdata_fil.usrid  = USERID(LDBNAME(1))   and
        impdata_fil.progid = trim(nv_proid)       and
        impdata_fil.PASS   = "Y" NO-LOCK .
        pass = pass + 1.
END.
IF pass > 0 THEN DO:
    OUTPUT STREAM ns2 TO value(fi_output1).
    PUT STREAM NS2
  " risk no      "    "|"               /*1  */  
  " itemno       "    "|"               /*2  */  
  " policyno     "     "|"              /*3  */  
  " n_branch     "     "|"              /*4  */  
  " agent        "     "|"              /*5  */  
  " producer     "     "|"              /*6  */  
  " n_delercode  "     "|"              /*7  */  
  " fincode      "     "|"              /*8  */  
  " appenno      "     "|"              /*9  */  
  " salename     "     "|"              /*10 */  
  " srate        "     "|"              /*11 */  
  " comdat       "     "|"              /*12 */  
  " expdat       "     "|"              /*13 */  
  " agreedat     "     "|"              /*14 */  
  " firstdat     "     "|"              /*15 */  
  " packcod      "     "|"              /*16 */  
  " camp_no      "     "|"              /*17 */  
  " campen       "     "|"              /*18 */  
  " specon       "     "|"              /*19 */  
  " product      "     "|"              /*20 */  
  " promo        "     "|"              /*21 */  
  " rencnt       "     "|"              /*22 */  
  " prepol       "     "|"              /*23 */  
  " txt1         "     "|"              /*24 */  
  " txt2         "     "|"              /*25 */  
  " txt3         "     "|"              /*26 */  
  " txt4         "     "|"              /*27 */  
  " txt5         "     "|"              /*28 */  
  " txt6         "     "|"              /*29 */  
  " txt7         "     "|"              /*30 */  
  " txt8         "     "|"              /*31 */  
  " txt9         "     "|"              /*32 */  
  " txt10        "     "|"              /*33 */  
  " memo1        "     "|"              /*34 */  
  " memo2        "     "|"              /*35 */  
  " memo3        "     "|"              /*36 */  
  " memo4        "     "|"              /*37 */  
  " memo5        "     "|"              /*38 */  
  " memo6        "     "|"              /*39 */  
  " memo7        "     "|"              /*40 */  
  " memo8        "     "|"              /*41 */  
  " memo9        "     "|"              /*42 */  
  " memo10       "     "|"              /*43 */  
  " accdata1     "     "|"              /*44 */  
  " accdata2     "     "|"              /*45 */  
  " accdata3     "     "|"              /*46 */  
  " accdata4     "     "|"              /*47 */  
  " accdata5     "     "|"              /*48 */  
  " accdata6     "     "|"              /*49 */  
  " accdata7     "     "|"              /*50 */  
  " accdata8     "     "|"              /*51 */  
  " accdata9     "     "|"              /*52 */  
  " accdata10    "     "|"              /*53 */  
  " compul       "     "|"              /*54 */  
  " insrefno     "     "|"              /*55 */  
  " instyp       "     "|"              /*56 */  
  " inslang      "     "|"              /*57 */  
  " tiname       "     "|"              /*58 */  
  " insnam       "     "|"              /*59 */  
  " lastname     "     "|"              /*60 */  
  " icno         "     "|"              /*61 */  
  " insbr        "     "|"              /*62 */  
  " occup        "     "|"              /*63 */  
  " addr         "     "|"              /*64 */  
  " tambon       "     "|"              /*65 */  
  " amper        "     "|"              /*66 */  
  " country      "     "|"              /*67 */  
  " post         "     "|"              /*68 */  
  " provcod      "     "|"              /*69 */  
  " distcod      "     "|"              /*70 */  
  " sdistcod     "     "|"              /*71 */  
  " jpAE code    "     "|"              /*72 */  
  " jpJT Code    "     "|"              /*73 */  
  " jpTS code    "     "|"              /*74 */  
  " gender       "     "|"              /*75 */  
  " tele1        "     "|"              /*76 */  
  " tele2        "     "|"              /*77 */  
  " mail1        "     "|"              /*78 */  
  " mail2        "     "|"              /*79 */  
  " mail3        "     "|"              /*80 */  
  " mail4        "     "|"              /*81 */  
  " mail5        "     "|"              /*82 */  
  " mail6        "     "|"              /*83 */  
  " mail7        "     "|"              /*84 */  
  " mail8        "     "|"              /*85 */  
  " mail9        "     "|"              /*86 */  
  " mail10       "     "|"              /*87 */  
  " fax          "     "|"              /*88 */  
  " lineID       "     "|"              /*89 */  
  " name2        "     "|"              /*90 */  
  " name3        "     "|"              /*91 */  
  " benname      "     "|"              /*92 */  
  " payercod     "     "|"              /*93 */  
  " vatcode      "     "|"              /*94 */  
  " instcod1     "     "|"              /*95 */  
  " insttyp1     "     "|"              /*96 */  
  " insttitle1   "     "|"              /*97 */  
  " instname1    "     "|"              /*98 */  
  " instlname1   "     "|"              /*99 */  
  " instic1      "     "|"              /*100*/  
  " instbr1      "     "|"              /*101*/  
  " instaddr11   "     "|"              /*102*/  
  " instaddr21   "     "|"              /*103*/  
  " instaddr31   "     "|"              /*104*/  
  " instaddr41   "     "|"              /*105*/  
  " instpost1    "     "|"              /*106*/  
  " instprovcod1 "     "|"              /*107*/  
  " instdistcod1 "     "|"              /*108*/  
  " instsdistcod1"     "|"              /*109*/  
  " instprm1     "     "|"              /*110*/  
  " instrstp1    "     "|"              /*111*/  
  " instrtax1    "     "|"              /*112*/  
  " instcomm01   "     "|"              /*113*/  
  " instcomm12   "     "|"              /*114*/  
  " instcod2     "     "|"              /*115*/  
  " insttyp2     "     "|"              /*116*/  
  " insttitle2   "     "|"              /*117*/  
  " instname2    "     "|"              /*118*/  
  " instlname2   "     "|"              /*119*/  
  " instic2      "     "|"              /*120*/  
  " instbr2      "     "|"              /*121*/  
  " instaddr12   "     "|"              /*122*/  
  " instaddr22   "     "|"              /*123*/  
  " instaddr32   "     "|"              /*124*/  
  " instaddr42   "     "|"              /*125*/  
  " instpost2    "     "|"              /*126*/  
  " instprovcod2 "     "|"              /*127*/  
  " instdistcod2 "     "|"              /*128*/  
  " instsdistcod2"     "|"              /*129*/  
  " instprm2     "     "|"              /*130*/  
  " instrstp2    "     "|"              /*131*/  
  " instrtax2    "     "|"              /*132*/  
  " instcomm02   "     "|"              /*133*/  
  " instcomm22   "     "|"              /*134*/  
  " instcod3     "     "|"              /*135*/  
  " insttyp3     "     "|"              /*136*/  
  " insttitle3   "     "|"              /*137*/  
  " instname3    "     "|"              /*138*/  
  " instlname3   "     "|"              /*139*/  
  " instic3      "     "|"              /*140*/  
  " instbr3      "     "|"              /*141*/  
  " instaddr13   "     "|"              /*142*/  
  " instaddr23   "     "|"              /*143*/  
  " instaddr33   "     "|"              /*144*/  
  " instaddr43   "     "|"              /*145*/  
  " instpost3    "     "|"              /*146*/  
  " instprovcod3 "     "|"              /*147*/  
  " instdistcod3 "     "|"              /*148*/  
  " instsdistcod3"     "|"              /*149*/  
  " instprm3     "     "|"              /*150*/  
  " instrstp3    "     "|"              /*151*/  
  " instrtax3    "     "|"              /*152*/  
  " instcomm03   "     "|"              /*153*/  
  " instcomm23   "     "|"              /*154*/  
  " covcod       "     "|"              /*155*/  
  " garage       "     "|"              /*156*/  
  " special      "     "|"              /*157*/  
  " inspec       "     "|"              /*158*/  
  " class70      "     "|"              /*159*/
  " Vehuse       "     "|"              /*160*/   /*ranu :15/12/2021 */ 
  " Redbook      "     "|"  
  " brand        "     "|"              /*161*/  
  " model        "     "|"              /*162*/  
  " submodel     "     "|"              /*163*/  
  " caryear      "     "|"              /*164*/  
  " chasno       "     "|"              /*165*/  
  " eng          "     "|"              /*166*/  
  " seat         "     "|"              /*167*/  
  " engcc        "     "|"              /*168*/  
  " weight       "     "|"              /*169*/  
  " watt         "     "|"              /*170*/  
  " body         "     "|"              /*171*/  
  " type         "     "|"              /*172*/  
  " re_year      "     "|"              /*173*/  
  " vehreg       "     "|"              /*174*/  
  " re_country   "     "|"              /*175*/  
  " cargrp       "     "|"              /*176*/  
  " colorcar     "     "|"              /*177*/  
  " fule         "     "|"              /*178*/  
  " drivnam      "     "|"              /*179*/  
  " ntitle1      "     "|"              /*180*/  
  " drivername1  "     "|"              /*181*/  
  " dname2       "     "|"              /*182*/  
  " dicno        "     "|"              /*183*/  
  " dgender1     "     "|"              /*184*/  
  " dbirth       "     "|"              /*185*/  
  " docoup       "     "|"              /*186*/  
  " ddriveno     "     "|"              /*187*/  
  " ntitle2      "     "|"              /*188*/  
  " drivername2  "     "|"              /*189*/  
  " ddname1      "     "|"              /*190*/  
  " ddicno       "     "|"              /*191*/  
  " dgender2     "     "|"              /*192*/  
  " ddbirth      "     "|"              /*193*/  
  " ddocoup      "     "|"              /*194*/  
  " dddriveno    "     "|"              /*195*/  
  " baseplus     "     "|"              /*196*/  
  " siplus       "     "|"              /*197*/  
  " rs10         "     "|"              /*198*/  
  " comper       "     "|"              /*199*/  
  " comacc       "     "|"              /*200*/  
  " deductpd     "     "|"              /*201*/  
  " DOD          "     "|"              /*202*/
  " DOD1         "     "|"              
  " DPD          "     "|"              /*203*/  
  " tpfire       "     "|"              /*204*/  
  " NO_41        "     "|"              /*205*/  
  " ac2          "     "|"              /*206*/  
  " ac4          "     "|"              /*207*/  
  " ac5          "     "|"              /*208*/  
  " ac6          "     "|"              /*209*/  
  " ac7          "     "|"              /*210*/  
  " NO_42        "     "|"              /*211*/  
  " NO_43        "     "|"              /*212*/  
  " base         "     "|"              /*213*/  
  " unname       "     "|"              /*214*/  
  " nname        "     "|"              /*215*/  
  " tpbi         "     "|"              /*216*/
  " tpbi2        "     "|"     
  " tppd         "     "|"              /*217*/ 
  " DOD amt"           "|"      
  " DOD1 amt "         "|"      
  " DPD amt"           "|"      
  " ry411  "           "|"              /*218*/ 
  " ry412  "           "|"   
  " ry413  "           "|"   
  " ry414  "           "|"   
  " ry02         "     "|"              /*219*/  
  " ry03         "     "|"              /*220*/  
  " fleet%       "     "|"              /*221*/  
  " ncb%         "     "|"              /*222*/  
  " claim%       "     "|"              /*223*/  
  " dspc%        "     "|"              /*224*/  
  " cctv%        "     "|"              /*225*/  
  " dstf%        "     "|"              /*226*/  
  " fleetprem    "     "|"              /*227*/  
  " ncbprem      "     "|"              /*228*/  
  " clprem       "     "|"              /*229*/  
  " dspcprem     "     "|"              /*230*/  
  " cctvprem     "     "|"              /*231*/  
  " dstfprem     "     "|"              /*232*/  
  " premt        "     "|"              /*233*/  
  " rstp_t       "     "|"              /*234*/  
  " rtax_t       "     "|"              /*235*/  
  " comper70     "     "|"              /*236*/  
  " comprem70    "     "|"              /*237*/  
  " agco70       "     "|"              /*238*/  
  " comco_per70  "     "|"              /*239*/  
  " comco_prem70 "     "|"              /*240*/  
  " dgpackge     "     "|"              /*241*/  
  " danger1      "     "|"              /*242*/  
  " danger2      "     "|"              /*243*/  
  " dgsi         "     "|"              /*244*/  
  " dgrate%       "     "|"             /*245*/  
  " dgfeet%       "     "|"             /*246*/  
  " dgncb%        "     "|"             /*247*/  
  " dgdisc%       "     "|"             /*248*/  
  " dgWdisc%      "     "|"             /*249*/  
  " dgatt        "     "|"              /*250*/  
  " dgfeetprm    "     "|"              /*251*/  
  " dgncbprm     "     "|"              /*252*/  
  " dgdiscprm    "     "|"              /*253*/  
  " dgwdiscprm   "     "|"              /*254*/  
  " dgprem       "     "|"              /*255*/  
  " dgrstp_t     "     "|"              /*256*/  
  " dgrtax_t     "     "|"              /*257*/  
  " dgcomper     "     "|"              /*258*/  
  " dgcomprem    "     "|"              /*259*/  
  " cltxt        "     "|"              /*260*/  
  " clamount     "     "|"              /*261*/  
  " faultno      "     "|"              /*262*/  
  " faultprm     "     "|"              /*263*/  
  " goodno       "     "|"              /*264*/  
  " goodprm      "     "|"              /*265*/  
  " loss         "     "|"              /*266*/  
  " compolusory  "     "|"              /*267*/  
  " barcode      "     "|"              /*268*/  
  " class72      "     "|"              /*269*/  
  " dstf72       "     "|"              /*270*/  
  " dstfprem72   "     "|"              /*271*/  
  " premt72      "     "|"              /*272*/  
  " rstp_t72     "     "|"              /*273*/  
  " rtax_t72     "     "|"              /*274*/  
  " comper72     "     "|"              /*275*/  
  " comprem72    "     "|"              /*276*/ 
  " Comment      "     SKIP .            
    RUN proc_report2_detail.
END.                                       

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_report2_Detail C-Win 
PROCEDURE Proc_report2_Detail :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    FOR EACH impdata_fil  USE-INDEX data_fil10 WHERE 
        impdata_fil.usrid  = USERID(LDBNAME(1))   and
        impdata_fil.progid = trim(nv_proid)       and
        impdata_fil.PASS   = "Y" NO-LOCK  BY impdata_fil.riskno .

        FIND FIRST imptxt_fil  use-index txt_fil02  WHERE 
            imptxt_fil.usrid    = impdata_fil.usrid     and
            imptxt_fil.progid   = impdata_fil.progid    and
            imptxt_fil.policyno = trim(impdata_fil.policyno) NO-LOCK NO-ERROR .

        FIND FIRST impmemo_fil use-index memo_fil02 WHERE 
            impmemo_fil.usrid    = impdata_fil.usrid    and
            impmemo_fil.progid   = impdata_fil.progid   and
            impmemo_fil.policyno = trim(impdata_fil.policyno) NO-LOCK NO-ERROR .

        FIND FIRST impacc_fil  use-index acc_fil03  WHERE 
            impacc_fil.policyno = TRIM(impdata_fil.policyno) AND
            impacc_fil.riskno   = impdata_fil.riskno   AND
            impacc_fil.itemno   = impdata_fil.itemno   AND 
            impmemo_fil.usrid   = impdata_fil.usrid    and
            impmemo_fil.progid  = impdata_fil.progid   NO-LOCK NO-ERROR .

        FIND FIRST impinst_fil USE-INDEX inst_fil02 WHERE
            impinst_fil.usrid    = impdata_fil.usrid    and    
            impinst_fil.progid   = impdata_fil.progid   and    
            impinst_fil.policyno = trim(impdata_fil.policyno) NO-LOCK NO-ERROR .

        PUT STREAM ns2
            impdata_fil.riskno       "|"             /*1  */               
            impdata_fil.itemno       "|"             /*2  */  
            impdata_fil.policyno FORMAT "x(15)" "|"  /*3  */  
            impdata_fil.n_branch     "|"             /*4  */  
            impdata_fil.agent        "|"             /*5  */  
            impdata_fil.producer     "|"             /*6  */  
            impdata_fil.n_delercode  "|"             /*7  */  
            impdata_fil.fincode      "|"             /*8  */  
            impdata_fil.appenno      "|"             /*9  */  
            impdata_fil.salename     "|"             /*10 */  
            impdata_fil.srate        "|"             /*11 */  
            impdata_fil.comdat       "|"             /*12 */  
            impdata_fil.expdat       "|"             /*13 */  
            impdata_fil.agreedat     "|"             /*14 */  
            impdata_fil.firstdat     "|"             /*15 */  
            impdata_fil.packcod      "|"             /*16 */  
            impdata_fil.camp_no      "|"             /*17 */  
            impdata_fil.campen       "|"             /*18 */  
            impdata_fil.specon       "|"             /*19 */  
            impdata_fil.product      "|"             /*20 */  
            impdata_fil.promo        "|"             /*21 */  
            impdata_fil.rencnt       "|"             /*22 */  
            impdata_fil.prepol       "|"             /*23 */  
            imptxt_fil.txt1           "|"            /*24 */  
            imptxt_fil.txt2           "|"            /*25 */  
            imptxt_fil.txt3           "|"            /*26 */  
            imptxt_fil.txt4           "|"            /*27 */  
            imptxt_fil.txt5           "|"            /*28 */  
            imptxt_fil.txt6           "|"            /*29 */  
            imptxt_fil.txt7           "|"            /*30 */  
            imptxt_fil.txt8           "|"            /*31 */  
            imptxt_fil.txt9           "|"            /*32 */  
            imptxt_fil.txt10          "|"            /*33 */  
            impmemo_fil.memo1         "|"            /*34 */  
            impmemo_fil.memo2         "|"            /*35 */  
            impmemo_fil.memo3         "|"            /*36 */  
            impmemo_fil.memo4         "|"            /*37 */  
            impmemo_fil.memo5         "|"            /*38 */  
            impmemo_fil.memo6         "|"            /*39 */  
            impmemo_fil.memo7         "|"            /*40 */  
            impmemo_fil.memo8         "|"            /*41 */  
            impmemo_fil.memo9         "|"            /*42 */  
            impmemo_fil.memo10        "|"            /*43 */  
            impacc_fil.accdata1       "|"            /*44 */  
            impacc_fil.accdata2       "|"            /*45 */  
            impacc_fil.accdata3       "|"            /*46 */  
            impacc_fil.accdata4       "|"            /*47 */  
            impacc_fil.accdata5       "|"            /*48 */  
            impacc_fil.accdata6       "|"            /*49 */  
            impacc_fil.accdata7       "|"            /*50 */  
            impacc_fil.accdata8       "|"            /*51 */  
            impacc_fil.accdata9       "|"            /*52 */  
            impacc_fil.accdata10      "|"            /*53 */  
            impdata_fil.compul        "|"            /*54 */  
            impdata_fil.insref        "|"            /*55 */  
            impdata_fil.instyp        "|"            /*56 */  
            impdata_fil.inslang       "|"            /*57 */  
            impdata_fil.tiname        "|"            /*58 */  
            impdata_fil.insnam        "|"            /*59 */  
            impdata_fil.lastname      "|"            /*60 */  
            impdata_fil.icno          "|"            /*61 */  
            impdata_fil.insbr         "|"            /*62 */  
            impdata_fil.occup         "|"            /*63 */  
            impdata_fil.addr          "|"            /*64 */  
            impdata_fil.tambon        "|"            /*65 */  
            impdata_fil.amper         "|"            /*66 */  
            impdata_fil.country       "|"            /*67 */  
            impdata_fil.post          "|"            /*68 */  
            impdata_fil.provcod       "|"            /*69 */  
            impdata_fil.distcod       "|"            /*70 */  
            impdata_fil.sdistcod      "|"            /*71 */  
            impdata_fil.jpae          "|"            /*72 */  
            impdata_fil.jpjtl         "|"            /*73 */  
            impdata_fil.jpts          "|"            /*74 */  
            impdata_fil.gender        "|"            /*75 */  
            impdata_fil.tele1         "|"            /*76 */  
            impdata_fil.tele2         "|"            /*77 */  
            impdata_fil.mail1         "|"            /*78 */  
            impdata_fil.mail2         "|"            /*79 */  
            impdata_fil.mail3         "|"            /*80 */  
            impdata_fil.mail4         "|"            /*81 */  
            impdata_fil.mail5         "|"            /*82 */  
            impdata_fil.mail6         "|"            /*83 */  
            impdata_fil.mail7         "|"            /*84 */  
            impdata_fil.mail8         "|"            /*85 */  
            impdata_fil.mail9         "|"            /*86 */  
            impdata_fil.mail10        "|"            /*87 */  
            impdata_fil.fax           "|"            /*88 */  
            impdata_fil.lineID        "|"            /*89 */  
            impdata_fil.name2         "|"            /*90 */  
            impdata_fil.name3         "|"            /*91 */  
            impdata_fil.benname       "|"            /*92 */  
            impdata_fil.payercod      "|"            /*93 */  
            impdata_fil.vatcode       "|"            /*94 */  
            impinst_fil.instcod1      "|"            /*95 */  
            impinst_fil.insttyp1      "|"            /*96 */  
            impinst_fil.insttitle1    "|"            /*97 */  
            impinst_fil.instname1     "|"            /*98 */  
            impinst_fil.instlname1    "|"            /*99 */  
            impinst_fil.instic1       "|"            /*100*/  
            impinst_fil.instbr1       "|"            /*101*/  
            impinst_fil.instaddr11    "|"            /*102*/  
            impinst_fil.instaddr21    "|"            /*103*/  
            impinst_fil.instaddr31    "|"            /*104*/  
            impinst_fil.instaddr41    "|"            /*105*/  
            impinst_fil.instpost1     "|"            /*106*/  
            impinst_fil.instprovcod1  "|"            /*107*/  
            impinst_fil.instdistcod1  "|"            /*108*/  
            impinst_fil.instsdistcod1 "|"            /*109*/  
            impinst_fil.instprm1      "|"            /*110*/  
            impinst_fil.instrstp1     "|"            /*111*/  
            impinst_fil.instrtax1     "|"            /*112*/  
            impinst_fil.instcomm01    "|"            /*113*/  
            impinst_fil.instcomm12    "|"            /*114*/  
            impinst_fil.instcod2      "|"            /*115*/  
            impinst_fil.insttyp2      "|"            /*116*/  
            impinst_fil.insttitle2    "|"            /*117*/  
            impinst_fil.instname2     "|"            /*118*/  
            impinst_fil.instlname2    "|"            /*119*/  
            impinst_fil.instic2       "|"            /*120*/  
            impinst_fil.instbr2       "|"            /*121*/  
            impinst_fil.instaddr12    "|"            /*122*/  
            impinst_fil.instaddr22    "|"            /*123*/  
            impinst_fil.instaddr32    "|"            /*124*/  
            impinst_fil.instaddr42    "|"            /*125*/  
            impinst_fil.instpost2     "|"            /*126*/  
            impinst_fil.instprovcod2  "|"            /*127*/  
            impinst_fil.instdistcod2  "|"            /*128*/  
            impinst_fil.instsdistcod2 "|"            /*129*/  
            impinst_fil.instprm2      "|"            /*130*/  
            impinst_fil.instrstp2     "|"            /*131*/  
            impinst_fil.instrtax2     "|"            /*132*/  
            impinst_fil.instcomm02    "|"            /*133*/  
            impinst_fil.instcomm22    "|"            /*134*/  
            impinst_fil.instcod3      "|"            /*135*/  
            impinst_fil.insttyp3      "|"            /*136*/  
            impinst_fil.insttitle3    "|"            /*137*/  
            impinst_fil.instname3     "|"            /*138*/  
            impinst_fil.instlname3    "|"            /*139*/  
            impinst_fil.instic3       "|"            /*140*/  
            impinst_fil.instbr3       "|"            /*141*/  
            impinst_fil.instaddr13    "|"            /*142*/  
            impinst_fil.instaddr23    "|"            /*143*/  
            impinst_fil.instaddr33    "|"            /*144*/  
            impinst_fil.instaddr43    "|"            /*145*/  
            impinst_fil.instpost3     "|"            /*146*/  
            impinst_fil.instprovcod3  "|"            /*147*/  
            impinst_fil.instdistcod3  "|"            /*148*/  
            impinst_fil.instsdistcod3 "|"            /*149*/  
            impinst_fil.instprm3      "|"            /*150*/  
            impinst_fil.instrstp3     "|"            /*151*/  
            impinst_fil.instrtax3     "|"            /*152*/  
            impinst_fil.instcomm03    "|"            /*153*/  
            impinst_fil.instcomm23    "|"            /*154*/  
            impdata_fil.covcod        "|"            /*155*/  
            impdata_fil.garage        "|"            /*156*/  
            impdata_fil.special       "|"            /*157*/  
            impdata_fil.inspec        "|"            /*158*/  
            impdata_fil.class70       "|"            /*159*/
            impdata_fil.vehuse        "|"             /*160*/   /* ranu : 15/12/2021 */          
            impdata_fil.brand         "|"             /*161*/ 
            impdata_fil.model         "|"             /*162*/ 
            impdata_fil.submodel      "|"             /*163*/ 
            impdata_fil.yrmanu        "|"             /*164*/ 
            impdata_fil.chasno        "|"             /*165*/ 
            impdata_fil.eng           "|"             /*166*/ 
            impdata_fil.seat41        "|"             /*167*/ 
            impdata_fil.engcc         "|"             /*168*/ 
            impdata_fil.weight        "|"             /*169*/ 
            impdata_fil.watt          "|"             /*170*/ 
            impdata_fil.body          "|"             /*171*/ 
            impdata_fil.typ           "|"             /*172*/ 
            impdata_fil.re_year       "|"             /*173*/ 
            impdata_fil.vehreg        "|"             /*174*/ 
            impdata_fil.re_country    "|"             /*175*/ 
            impdata_fil.cargrp        "|"             /*176*/ 
            impdata_fil.colorcar      "|"             /*177*/ 
            impdata_fil.fule          "|"             /*178*/ 
            impdata_fil.drivnam       "|"             /*179*/ 
            impdata_fil.ntitle1       "|"             /*180*/ 
            impdata_fil.drivername1   "|"             /*181*/ 
            impdata_fil.dname2        "|"             /*182*/ 
            impdata_fil.dicno         "|"             /*183*/ 
            impdata_fil.dgender1      "|"             /*184*/ 
            impdata_fil.dbirth        "|"             /*185*/ 
            impdata_fil.docoup        "|"             /*186*/ 
            impdata_fil.ddriveno      "|"             /*187*/ 
            impdata_fil.ntitle2       "|"             /*188*/ 
            impdata_fil.drivername2   "|"             /*189*/ 
            impdata_fil.ddname1       "|"             /*190*/ 
            impdata_fil.ddicno        "|"             /*191*/ 
            impdata_fil.dgender2      "|"             /*192*/ 
            impdata_fil.ddbirth       "|"             /*193*/ 
            impdata_fil.ddocoup       "|"             /*194*/ 
            impdata_fil.dddriveno     "|"             /*195*/ 
            impdata_fil.baseplus      "|"             /*196*/ 
            impdata_fil.siplus        "|"             /*197*/ 
            impdata_fil.rs10          "|"             /*198*/ 
            impdata_fil.comper        "|"             /*199*/ 
            impdata_fil.comacc        "|"             /*200*/ 
            impdata_fil.deductpd      "|"             /*201*/ 
            impdata_fil.DOD           "|"             /*202*/ 
            impdata_fil.DPD           "|"             /*203*/ 
            impdata_fil.si            "|"             /*204*/ 
            impdata_fil.NO_411        "|"             /*205*/ 
            impdata_fil.seat41        "|"             /*206*/ 
            impdata_fil.NO_412        "|"             /*207*/ 
            impdata_fil.NO_413        "|"             /*208*/ 
            impdata_fil.pass_no       "|"             /*209*/ 
            impdata_fil.NO_414        "|"             /*210*/ 
            impdata_fil.NO_42         "|"             /*211*/ 
            impdata_fil.NO_43         "|"             /*212*/ 
            impdata_fil.base          "|"             /*213*/ 
            impdata_fil.unname        "|"             /*214*/ 
            impdata_fil.nname         "|"             /*215*/ 
            impdata_fil.tpbi          "|"             /*216*/ 
            impdata_fil.tppd          "|"             /*217*/ 
            impdata_fil.ry01          "|"             /*218*/ 
            impdata_fil.ry02          "|"             /*219*/ 
            impdata_fil.ry03          "|"             /*220*/ 
            impdata_fil.fleet         "|"             /*221*/ 
            impdata_fil.ncb           "|"             /*222*/ 
            impdata_fil.claim         "|"             /*223*/ 
            impdata_fil.dspc          "|"             /*224*/ 
            impdata_fil.cctv          "|"             /*225*/ 
            impdata_fil.dstf          "|"             /*226*/ 
            impdata_fil.fleetprem     "|"             /*227*/ 
            impdata_fil.ncbprem       "|"             /*228*/ 
            impdata_fil.clprem        "|"             /*229*/ 
            impdata_fil.dspcprem      "|"             /*230*/ 
            impdata_fil.cctvprem      "|"             /*231*/ 
            impdata_fil.dstfprem      "|"             /*232*/ 
            impdata_fil.premt         "|"             /*233*/ 
            impdata_fil.rstp_t        "|"             /*234*/ 
            impdata_fil.rtax_t        "|"             /*235*/ 
            impdata_fil.comper70      "|"             /*236*/ 
            impdata_fil.comprem70     "|"             /*237*/ 
            impdata_fil.agco70        "|"             /*238*/ 
            impdata_fil.comco_per70   "|"             /*239*/ 
            impdata_fil.comco_prem70  "|"             /*240*/ 
            impdata_fil.dgpackge      "|"             /*241*/ 
            impdata_fil.danger1       "|"             /*242*/ 
            impdata_fil.danger2       "|"             /*243*/ 
            impdata_fil.dgsi          "|"             /*244*/ 
            impdata_fil.dgrate        "|"             /*245*/ 
            impdata_fil.dgfeet        "|"             /*246*/ 
            impdata_fil.dgncb         "|"             /*247*/ 
            impdata_fil.dgdisc        "|"             /*248*/ 
            impdata_fil.dgWdisc       "|"             /*249*/ 
            impdata_fil.dgatt         "|"             /*250*/ 
            impdata_fil.dgfeetprm     "|"             /*251*/ 
            impdata_fil.dgncbprm      "|"             /*252*/ 
            impdata_fil.dgdiscprm     "|"             /*253*/ 
            impdata_fil.dgWdiscprm    "|"             /*254*/ 
            impdata_fil.dgprem        "|"             /*255*/ 
            impdata_fil.dgrstp_t      "|"             /*256*/ 
            impdata_fil.dgrtax_t      "|"             /*257*/ 
            impdata_fil.dgcomper      "|"             /*258*/ 
            impdata_fil.dgcomprem     "|"             /*259*/ 
            impdata_fil.cltxt         "|"             /*260*/ 
            impdata_fil.clamount      "|"             /*261*/ 
            impdata_fil.faultno       "|"             /*262*/ 
            impdata_fil.faultprm      "|"             /*263*/ 
            impdata_fil.goodno        "|"             /*264*/ 
            impdata_fil.goodprm       "|"             /*265*/ 
            impdata_fil.loss          "|"             /*266*/ 
            impdata_fil.compolusory   "|"             /*267*/ 
            impdata_fil.stk           "|"             /*268*/ 
            impdata_fil.class72       "|"             /*269*/ 
            impdata_fil.dstf72        "|"             /*270*/ 
            impdata_fil.dstfprem72    "|"             /*271*/ 
            impdata_fil.premt72       "|"             /*272*/ 
            impdata_fil.rstp_t72      "|"             /*273*/ 
            impdata_fil.rtax_t72      "|"             /*274*/ 
            impdata_fil.comper72      "|"             /*275*/ 
            impdata_fil.comprem72     "|"             
            impdata_fil.comment       SKIP .
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PROC_REPORT3 C-Win 
PROCEDURE PROC_REPORT3 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR HEAD AS CHAR INIT "Y".
DEF VAR a AS CHAR FORMAT "x(20)" INIT "".
DEF VAR b AS CHAR FORMAT "x(20)" INIT "".
DEF VAR c AS INTE INIT 0.
DEF VAR d AS INTE INIT 0.
DEF VAR f AS CHAR FORMAT "x(20)" INIT "".
DEF VAR pass AS INTE INIT 0.
def var nv_cnt   as  int  init  0.
DEF VAR nw_icno AS CHAR FORMAT "x(15)" INIT "".

ASSIGN nv_row  =  1.
FOR EACH  impdata_fil USE-INDEX data_fil10 WHERE 
        impdata_fil.usrid  = USERID(LDBNAME(1))   and
        impdata_fil.progid = trim(nv_proid)       and
        impdata_fil.PASS   = "Y" NO-LOCK .
  pass = pass + 1.
END. 
IF pass > 0 THEN DO:
    ASSIGN 
        nv_cnt  = 0 
        nv_row  = 1.
    OUTPUT STREAM ns2 TO value(fi_outputpro).
    PUT STREAM ns2 "ID;PND" SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "itemno / เลขรับแจ้ง " '"' SKIP .                                                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' "กรมธรรม์"           '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"' "ประเภทกรมธรรม์"     '"' SKIP.          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"' "สาขา"               '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"' "Producer "          '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"' "Agent "             '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"' "Delaer Code"        '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"' "Finnace code"       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"' "Campaign no"        '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"' "เบี้ย "             '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"' "ทุน"                '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"' "ปีที่จดทะเบียน"     '"' SKIP.                  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"' "ปีรถ"               '"' SKIP.                  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"' "รุ่น"               '"' SKIP.                  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"' "ยี่ห้อ"             '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"' "Redbook "           '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"' "insured code  "     '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"' "tiname"             '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"' "insnam"             '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"' "Lastname"           '"' SKIP .
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"' "name2"              '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"' "name3"              '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"' "icno"               '"' SKIP. 

    FOR EACH  impdata_fil USE-INDEX data_fil10 WHERE 
        impdata_fil.usrid  = USERID(LDBNAME(1))   and
        impdata_fil.progid = trim(nv_proid)       and
        impdata_fil.PASS   = "Y" NO-LOCK .
        ASSIGN nv_cnt  =  nv_cnt  + 1                      
               nv_row  =  nv_row  + 1. 
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"'   string(impdata_fil.itemno,"999") + " / " + impdata_fil.appenno FORMAT "X(20)"       '"' SKIP.
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"'   impdata_fil.policyno FORMAT "x(15)"     '"' SKIP. 
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"'   impdata_fil.poltyp        '"' SKIP .
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"'   impdata_fil.n_branch      '"' SKIP. 
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'   impdata_fil.producer      '"' SKIP. 
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"'   impdata_fil.agent         '"' SKIP. 
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"'   impdata_fil.n_delercode   '"' SKIP. 
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"'   impdata_fil.fincode       '"' SKIP. 
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"'   impdata_fil.packcod       '"' SKIP. 
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"'   impdata_fil.premt         '"' SKIP. 
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"'  impdata_fil.si            '"' SKIP. 
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"'  impdata_fil.re_year       '"' SKIP. 
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"'  impdata_fil.yrmanu        '"' SKIP.                     
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"'  impdata_fil.model         '"' SKIP.                     
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"'  impdata_fil.brand         '"' SKIP.                     
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"'  impdata_fil.redbook       '"' SKIP.
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"'  impdata_fil.insref     '"' SKIP.
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"'  impdata_fil.tiname        '"' SKIP.
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"'  impdata_fil.insnam        '"' SKIP.
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"'  impdata_fil.lastname      '"' SKIP.
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"'  impdata_fil.name2         '"' SKIP.
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"'  impdata_fil.name3         '"' SKIP. 
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"'  impdata_fil.icno          '"' SKIP.                                                                        
    END.                                                                            
    PUT STREAM ns2 "E".
OUTPUT STREAM ns2 CLOSE.                                                        
END.   /*pass > 0*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportpolno C-Win 
PROCEDURE proc_reportpolno :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    OUTPUT STREAM ns1 TO value(fi_output1).
    PUT STREAM ns1
      "Risk No "                       "|"       /*1  */             
      "ItemNo  "                       "|"       /*2  */ 
      "Policy No (เลขที่กรมธรรม์ภาคสมัครใจ)" "|"  /*3  */ 
      "Branch (สาขา) "                 "|"       /*4  */ 
      "Agent Code (รหัสตัวแทน) "       "|"       /*5  */ 
      "Producer Code "                 "|"       /*6  */ 
      "Dealer Code (รหัสดีเลอร์) "     "|"       /*7  */ 
      "Finance Code (รหัสไฟแนนซ์)"     "|"       /*8  */ 
      "Notification Number (เลขที่รับแจ้ง)" "|"  /*9  */ 
      "Notification Name (ชื่อผู้แจ้ง)    " "|"  /*10 */ 
      "Short Rate  "                   "|"       /*11 */ 
      "Effective Date (วันที่เริ่มความคุ้มครอง)" "|"  /*12 */ 
      "Expiry Date (วันที่สิ้นสุดความคุ้มครอง) " "|"  /*13 */ 
      "Agree Date "                    "|"       /*14 */ 
      "First Date "                    "|"       /*15 */ 
      "รหัสแพ็กเกจ"                    "|"       /*16 */ 
      "Campaign Code (รหัสแคมเปญ)"     "|"       /*17 */ 
      "Campaign Text"                  "|"       /*18 */ 
      "Spec Con     "                  "|"       /*19 */ 
      "Product Type "                  "|"       /*20 */ 
      "Promotion Code"                 "|"       /*21 */ 
      "Renew Count   "                 "|"       /*22 */ 
      "Previous Policy (เลขทีกรมธรรม์ภาคสมัครใจเดิม)" "|"   /*23 */ 
      "Policy Text 1"         "|"               /*24 */ 
      "Policy Text 2"         "|"               /*25 */ 
      "Policy Text 3"         "|"               /*26 */ 
      "Policy Text 4"         "|"               /*27 */ 
      "Policy Text 5"         "|"               /*28 */ 
      "Policy Text 6"         "|"               /*29 */ 
      "Policy Text 7"         "|"               /*30 */ 
      "Policy Text 8"         "|"               /*31 */ 
      "Policy Text 9"         "|"               /*32 */ 
      "Policy Text 10"        "|"               /*33 */ 
      "Memo Text 1 "          "|"               /*34 */ 
      "Memo Text 2 "          "|"               /*35 */ 
      "Memo Text 3 "          "|"               /*36 */ 
      "Memo Text 4 "          "|"               /*37 */ 
      "Memo Text 5 "          "|"               /*38 */ 
      "Memo Text 6 "          "|"               /*39 */ 
      "Memo Text 7 "          "|"               /*40 */ 
      "Memo Text 8 "          "|"               /*41 */ 
      "Memo Text 9 "          "|"               /*42 */ 
      "Memo Text 10"          "|"               /*43 */ 
      "Accessory Text 1 "     "|"               /*44 */ 
      "Accessory Text 2 "     "|"               /*45 */ 
      "Accessory Text 3 "     "|"               /*46 */ 
      "Accessory Text 4 "     "|"               /*47 */ 
      "Accessory Text 5 "     "|"               /*48 */ 
      "Accessory Text 6 "     "|"               /*49 */ 
      "Accessory Text 7 "     "|"               /*50 */ 
      "Accessory Text 8 "     "|"               /*51 */ 
      "Accessory Text 9 "     "|"               /*52 */ 
      "Accessory Text 10"     "|"               /*53 */ 
      "กรมธรรม์ซื้อควบ (Y/N)" "|"               /*54 */ 
      "Insured Code"          "|"               /*55 */ 
      "ประเภทบุคคล"           "|"               /*56 */ 
      "ภาษาที่ใช้สร้าง Cilent Code" "|"         /*57 */ 
      "คำนำหน้า"             "|"               /*58 */ 
      "ชื่อ    "             "|"               /*59 */ 
      "นามสกุล  "            "|"               /*60 */ 
      "เลขที่บัตรประชาชน / เลขที่นิติบุคคล" "|"    /*61 */ 
      "ลำดับที่สาขา "        "|"         /*62 */ 
      "อาชีพ        "        "|"         /*63 */ 
      "ที่อยู่บรรทัดที่ 1 "  "|"         /*64 */ 
      "ที่อยู่บรรทัดที่ 2 "  "|"         /*65 */ 
      "ที่อยู่บรรทัดที่ 3 "  "|"         /*66 */ 
      "ที่อยู่บรรทัดที่ 4 "  "|"         /*67 */ 
      "รหัสไปรษณีย์ "        "|"         /*68 */ 
      "province code"        "|"         /*69 */ 
      "district code"        "|"         /*70 */ 
      "sub district code  "  "|"         /*71 */ 
      "AE Code "             "|"         /*72 */ 
      "Japanese Team "       "|"         /*73 */ 
      "TS Code "             "|"         /*74 */ 
      "Gender (Male/Female/Other)" "|"   /*75 */ 
      "Telephone 1"          "|"         /*76 */ 
      "Telephone 2"          "|"         /*77 */ 
      "E-Mail 1 "            "|"         /*78 */ 
      "E-Mail 2 "            "|"         /*79 */ 
      "E-Mail 3 "            "|"         /*80 */ 
      "E-Mail 4 "            "|"         /*81 */ 
      "E-Mail 5 "            "|"         /*82 */ 
      "E-Mail 6 "            "|"         /*83 */ 
      "E-Mail 7 "            "|"         /*84 */ 
      "E-Mail 8 "            "|"         /*85 */ 
      "E-Mail 9 "            "|"         /*86 */ 
      "E-Mail 10"            "|"         /*87 */ 
      "Fax      "            "|"         /*88 */ 
      "Line ID  "            "|"         /*89 */ 
      "CareOf1  "            "|"         /*90 */ 
      "CareOf2  "            "|"         /*91 */ 
      "Benefit Name"         "|"         /*92 */ 
      "Payer Code  "         "|"         /*93 */ 
      "VAT Code    "         "|"         /*94 */ 
      "Client Code "         "|"         /*95 */ 
      "ประเภทบุคคล "         "|"         /*96 */ 
      "คำนำหน้า"             "|"         /*97 */ 
      "ชื่อ    "             "|"         /*98 */ 
      "นามสกุล "             "|"         /*99 */ 
      "เลขที่บัตรประชาชน / เลขที่นิติบุคคล" "|"         /*100*/ 
      "ลำดับที่สาขา      "   "|"         /*101*/ 
      "ที่อยู่บรรทัดที่ 1"   "|"         /*102*/ 
      "ที่อยู่บรรทัดที่ 2"   "|"         /*103*/ 
      "ที่อยู่บรรทัดที่ 3"   "|"         /*104*/ 
      "ที่อยู่บรรทัดที่ 4"   "|"         /*105*/ 
      "รหัสไปรษณีย์      "   "|"         /*106*/ 
      "province code     "   "|"         /*107*/ 
      "district code     "   "|"         /*108*/ 
      "sub district code "   "|"         /*109*/ 
      "เบี้ยก่อนภาษีอากร "   "|"         /*110*/ 
      "อากร              "   "|"         /*111*/ 
      "ภาษี              "   "|"         /*112*/ 
      "คอมมิชชั่น 1      "   "|"         /*113*/ 
      "คอมมิชชั่น 2 (co-broker)"  "|"    /*114*/ 
      "Client Code "         "|"         /*115*/ 
      "ประเภทบุคคล "         "|"         /*116*/ 
      "คำนำหน้า    "         "|"         /*117*/ 
      "ชื่อ        "         "|"         /*118*/ 
      "นามสกุล     "         "|"         /*119*/ 
      "เลขที่บัตรประชาชน / เลขที่นิติบุคคล" "|"   /*120*/ 
      "ลำดับที่สาขา       "  "|"       /*121*/ 
      "ที่อยู่บรรทัดที่ 1 "  "|"       /*122*/ 
      "ที่อยู่บรรทัดที่ 2 "  "|"       /*123*/ 
      "ที่อยู่บรรทัดที่ 3 "  "|"       /*124*/ 
      "ที่อยู่บรรทัดที่ 4 "  "|"       /*125*/ 
      "รหัสไปรษณีย์       "  "|"       /*126*/ 
      "province code      "  "|"       /*127*/ 
      "district code      "  "|"       /*128*/ 
      "sub district code  "  "|"       /*129*/ 
      "เบี้ยก่อนภาษีอากร  "  "|"       /*130*/ 
      "อากร               "  "|"       /*131*/ 
      "ภาษี               "  "|"       /*132*/ 
      "คอมมิชชั่น 1       "  "|"       /*133*/ 
      "คอมมิชชั่น 2 (co-broker)"  "|"  /*134*/ 
      "Client Code "         "|"       /*135*/ 
      "ประเภทบุคคล "         "|"       /*136*/ 
      "คำนำหน้า    "         "|"       /*137*/ 
      "ชื่อ        "         "|"       /*138*/ 
      "นามสกุล     "         "|"       /*139*/ 
      "เลขที่บัตรประชาชน / เลขที่นิติบุคคล" "|"         /*140*/ 
      "ลำดับที่สาขา      "  "|"         /*141*/ 
      "ที่อยู่บรรทัดที่ 1"  "|"         /*142*/ 
      "ที่อยู่บรรทัดที่ 2"  "|"         /*143*/ 
      "ที่อยู่บรรทัดที่ 3"  "|"         /*144*/ 
      "ที่อยู่บรรทัดที่ 4"  "|"         /*145*/ 
      "รหัสไปรษณีย์      "  "|"         /*146*/ 
      "province code     "  "|"         /*147*/ 
      "district code     "  "|"         /*148*/ 
      "sub district code "  "|"         /*149*/ 
      "เบี้ยก่อนภาษีอากร "  "|"         /*150*/ 
      "อากร              "  "|"         /*151*/ 
      "ภาษี              "  "|"         /*152*/ 
      "คอมมิชชั่น 1      "  "|"         /*153*/ 
      "คอมมิชชั่น 2 (co-broker)" "|"    /*154*/ 
      "Cover Type (ประเภทความคุ้มครอง)" "|"  /*155*/ 
      "Garage (ประเภทการซ่อม ซ่อมอู่/ซ่อมห้าง)" "|" /*156*/ 
      "Spacial Equipment Flag (A/Blank)" "|"         /*157*/ 
      "Inspection"           "|"         /*158*/ 
      "รหัสรถภาคสมัครใจ (110/120/320)" "|"/*159*/ 
      "ลักษณะการใช้รถ   "    "|"         /*160*/  /* ranu : 15/12/2021*/
      "Redbook "             "|"         /*161*/  /*A65-0079*/
      "ยี่ห้อรถ"             "|"         /*162*/ 
      "ชื่อรุ่นรถ"           "|"         /*163*/ 
      "ชื่อรุ่นย่อยรถ"       "|"         /*164*/ 
      "ปีรุ่นรถ"             "|"         /*165*/ 
      "หมายเลขตัวถัง"        "|"         /*166*/ 
      "หมายเลขเครื่อง"       "|"         /*167*/
      "หมายเลขเครื่อง 2"     "|"         /*A67-0029*/
      "จำนวนที่นั่ง (รวมผู้ขับขี่)" "|"  /*168*/
      "ปริมาตรกระบอกสูบ (CC)" "|"        /*169*/ 
      "น้ำหนัก (ตัน)"         "|"        /*170*/ 
      "Kilowatt/HP"           "|"        /*171*/ 
      "รหัสแบบตัวถัง"         "|"        /*172*/ 
      "ป้ายแดง (Y/N)"         "|"        /*173*/ 
      "ปีที่จดทะเบียน"        "|"        /*174*/ 
      "เลขทะเบียนรถ"          "|"        /*175*/ 
      "จังหวัดที่จดทะเบียน"   "|"        /*176*/ 
      "Group Car (กลุ่มรถ)"   "|"        /*177*/ 
      "Color (สี)"            "|"        /*178*/ 
      "Fule (เชื้อเพลิง)"     "|"        /*179*/ 
      "Driver Number"         "|"        /*180*/ 
      "คำนำหน้า"              "|"        /*181*/ 
      "ชื่อ"                  "|"        /*182*/ 
      "นามสกุล"               "|"        /*183*/ 
      "เลขที่บัตรประชาชน"     "|"        /*184*/ 
      "เพศ"                   "|"        /*185*/ 
      "วันเกิด"               "|"        /*186*/ 
      "ชื่ออาชีพ"             "|"        /*187*/ 
      "เลขที่ใบอนุญาตขับขี่"  "|"        /*188*/
      "วันที่ใบอนุญาต หมดอายุ" "|"     /*A67-0029*/
      "Consent ผู้ขับขี่  "   "|"   /*A67-0029*/
      "ระดับพฤติกรรมการขับขี่" "|"     /*A67-0029*/  
      "คำนำหน้า"              "|"        /*189*/ 
      "ชื่อ"                  "|"        /*190*/ 
      "นามสกุล"               "|"        /*191*/ 
      "เลขที่บัตรประชาชน"     "|"        /*192*/ 
      "เพศ"                   "|"        /*193*/ 
      "วันเกิด"               "|"        /*194*/ 
      "ชื่ออาชีพ"             "|"        /*195*/ 
      "เลขที่ใบอนุญาตขับขี่"  "|"        /*196*/
      /*A67-0029*/
      "วันที่ใบอนุญาต หมดอายุ" "|"
      "Consent ผู้ขับขี่  "   "|"   
      "ระดับพฤติกรรมการขับขี่" "|"
      "คำนำหน้า  "             "|"
      "ชื่อ      "             "|"
      "นามสกุล   "             "|"
      "เลขที่บัตรประชาชน "     "|"
      "เพศ       "             "|"
      "วันเกิด   "             "|"
      "ชื่ออาชีพ "             "|"
      "เลขที่ใบอนุญาตขับขี่  " "|"  
      "วันที่ใบอนุญาต หมดอายุ" "|"  
      "Consent ผู้ขับขี่  "   "|"   /*A67-0029*/
      "ระดับพฤติกรรมการขับขี่" "|"  
      "คำนำหน้า  "             "|"
      "ชื่อ      "             "|"
      "นามสกุล   "             "|"
      "เลขที่บัตรประชาชน "     "|"
      "เพศ       "             "|"
      "วันเกิด   "             "|"
      "ชื่ออาชีพ "             "|"
      "เลขที่ใบอนุญาตขับขี่  " "|"  
      "วันที่ใบอนุญาต หมดอายุ" "|"
      "Consent ผู้ขับขี่  "   "|"   /*A67-0029*/
      "ระดับพฤติกรรมการขับขี่" "|"  
      "คำนำหน้า "              "|"
      "ชื่อ     "              "|"
      "นามสกุล  "              "|"
      "เลขที่บัตรประชาชน  "    "|"
      "เพศ      "              "|"
      "วันเกิด  "              "|"
      "ชื่ออาชีพ"              "|"
      "เลขที่ใบอนุญาตขับขี่  " "|"  
      "วันที่ใบอนุญาต หมดอายุ" "|" 
      "Consent ผู้ขับขี่  "   "|"   /*A67-0029*/
      "ระดับพฤติกรรมการขับขี่" "|"  
      /* end : A67-0029*/ 
      "Base Premium Plus"     "|"        /*197*/ 
      "Sum Insured Plus"      "|"        /*198*/ 
      "RS10 Amount"           "|"        /*199*/ 
      "TPBI / person"         "|"        /*200*/ 
      "TPBI / occurrence"     "|"        /*201*/ 
      "TPPD        "          "|"        /*202*/ 
      "Deduct / OD "          "|"        /*203*/
      "Deduct /DOD1 "         "|"        /*204*/   /*A65-0079*/ 
      "Deduct / PD "          "|"        /*205*/
      "ทุนประกันรถ EV"        "|"   /*A67-0029*/
      "วงเงินทุนประกัน "      "|"        /*206*/ 
      "PA1.1 / driver  "      "|"        /*207*/ 
      "PA1.1 no.of passenger" "|"        /*208*/ 
      "PA1.1 / passenger    " "|"        /*209*/ 
      "PA1.2 / driver       " "|"        /*210*/ 
      "PA1.2 no.of passenger" "|"        /*211*/ 
      "PA1.2 / passenger    " "|"        /*212*/ 
      "PA2         "          "|"        /*213*/ 
      "PA3         "          "|"        /*214*/ 
      "Base Premium"          "|"        /*215*/ 
      "Unname      "          "|"        /*216*/ 
      "Name        "          "|"        /*217*/ 
      "TPBI Amount "          "|"        /*218*/ 
      "TPBI2 Amount "         "|"        /*219*/  /*A65-0079*/
      "TPPD Amount "          "|"        /*220*/ 
      "DOD  Amount"           "|"        /*221*/  /*A65-0079*/
      "DOD1 Amount"           "|"        /*222*/  /*A65-0079*/
      "DPD  Amount"           "|"        /*223*/  /*A65-0079*/
      "RY411 Amount "         "|"        /*224*/
      "RY412 Amount "         "|"        /*225*/   /*A65-0079*/
      "RY413 Amount "         "|"        /*226*/   /*A65-0079*/
      "RY414 Amount "         "|"        /*227*/   /*A65-0079*/
      "RY02 Amount "          "|"        /*228*/
      "RY03 Amount "          "|"        /*229*/
      "Fleet%      "          "|"        /*230*/
      "NCB%        "          "|"        /*231*/
      "Load Claim% "          "|"        /*232*/
      "Other Disc.%"          "|"        /*233*/
      "CCTV%        "         "|"        /*234*/
      "Walkin Disc.%"         "|"        /*235*/
      "Fleet Amount "         "|"        /*236*/
      "NCB Amount   "         "|"        /*237*/
      "Load Claim Amount "    "|"        /*238*/
      "Other Disc. Amount"    "|"        /*239*/ 
      "CCTV Amount       "    "|"        /*240*/ 
      "Walk in Disc. Amount"  "|"        /*241*/ 
      "เบี้ยสุทธิ "           "|"        /*242*/ 
      "Stamp Duty "           "|"        /*243*/ 
      "VAT        "           "|"        /*244*/ 
      "Commission %"          "|"        /*245*/ 
      "Commission Amount"     "|"        /*246*/ 
      "Agent Code co-broker (รหัสตัวแทน)""|"/*247*/ 
      "Commission % co-broker"      "|"  /*248*/ 
      "Commission Amount co-broker" "|"   /*249*/ 
      "Package (Attach Coverage)"   "|"   /*250*/ 
      "Dangerous Object 1"     "|"        /*251*/ 
      "Dangerous Object 2"     "|"        /*252*/ 
      "Sum Insured"            "|"        /*253*/ 
      "Rate%      "            "|"        /*254*/ 
      "Fleet%     "            "|"        /*255*/ 
      "NCB%       "            "|"        /*256*/ 
      "Discount%  "            "|"        /*257*/ 
      "Walkin Disc.%"          "|"        /*258*/ 
      "Premium Attach Coverage""|"        /*259*/ 
      "Discount Fleet"         "|"        /*260*/ 
      "Discount NCB  "         "|"        /*261*/ 
      "Other Discount"         "|"        /*262*/ 
      "Walk in Disc. Amount"   "|"        /*263*/ 
      "Net Premium "           "|"        /*264*/ 
      "Stamp Duty  "           "|"        /*265*/ 
      "VAT         "           "|"        /*266*/ 
      "Commission Amount"      "|"        /*267*/
      "Commission Amount co-broker""|"    /*268*/
      "Claim Text  "            "|"       /*269*/
      "Claim Amount"            "|"       /*270*/
      "Claim Count Fault"       "|"       /*271*/
      "Claim Count Fault Amount""|"       /*272*/
      "Claim Count Good        ""|"       /*273*/
      "Claim Count Good Amount ""|"       /*274*/
      "Loss Ratio % (Not TP)   ""|"       /*275*/
      "Compulsory Policy Number (เลขที่กรมธรรม์ พรบ.)" "|"  /*276*/ 
      "Barcode No."                              "|"         /*277*/ 
      "Compulsory Class (รหัส พรบ.)  "           "|"         /*278*/ 
      "Compulsory Walk In Discount % "           "|"         /*279*/ 
      "Compulsory Walk In Discount Amount"       "|"         /*280*/ 
      "เบี้ยสุทธิ พ.ร.บ. กรณีกรมธรรม์ซื้อควบ"    "|"         /*281*/ 
      "Stamp Duty "                              "|"         /*282*/ 
      "VAT        "                              "|"         /*283*/ 
      "Commission %"                             "|"         /*284*/ 
      "Commission Amount"                        "|"         /*285*/
      /* A67-0029 */             
      "เลขที่แบตเตอรี่"     "|" 
      "ปีแบตฯ         "     "|" 
      "ราคาแบตฯ       "     "|" 
      "ทุนแบตฯ       "      "|" 
      "Rate           "     "|" 
      "Premium        "     "|" 
      "เลขที่เครื่องชาร์จ"  "|" 
      "ราคาเครื่องชาร์จ  "  "|" 
      "Rate    "            "|" 
      "Premium "            "|" 
      /* end : A67-0029 */    
      "Remark "                                  SKIP .      /*286*/
      RUN proc_reportpolno_2.
      OUTPUT STREAM ns1 CLOSE.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportpolno_2 C-Win 
PROCEDURE proc_reportpolno_2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_count AS INT INIT 0.
DO:
    FOR EACH impdata_fil  USE-INDEX data_fil10       WHERE 
             impdata_fil.usrid  = USERID(LDBNAME(1)) AND 
             impdata_fil.progid = trim(nv_proid)     NO-LOCK BY riskno .
             n_count = n_count + 1.            
      FIND FIRST impacc_fil  use-index acc_fil03  WHERE 
        impacc_fil.policyno = TRIM(impdata_fil.policyno) AND
        impacc_fil.riskno   = impdata_fil.riskno   AND
        impacc_fil.itemno   = impdata_fil.itemno   AND 
        impacc_fil.usrid    = impdata_fil.usrid    AND 
        impacc_fil.progid   = impdata_fil.progid   NO-LOCK NO-ERROR NO-WAIT .
      FIND FIRST impinst_fil USE-INDEX inst_fil02  WHERE
        impinst_fil.usrid    = impdata_fil.usrid   AND     
        impinst_fil.progid   = impdata_fil.progid  AND     
        impinst_fil.policyno = trim(impdata_fil.policyno) NO-LOCK NO-ERROR NO-WAIT.
      PUT STREAM ns1 
          impdata_fil.riskno   "|"
          impdata_fil.itemno   "|"
          impdata_fil.policyno FORMAT "x(15)"  "|"
          impdata_fil.n_branch "|"
          impdata_fil.agent    "|"
          impdata_fil.producer "|"
          impdata_fil.n_delercode  "|"
          impdata_fil.fincode  "|"
          impdata_fil.appenno  "|"
          impdata_fil.salename "|"
          impdata_fil.srate    "|"
          impdata_fil.comdat   "|"
          impdata_fil.expdat   "|"
          impdata_fil.agreedat "|"
          impdata_fil.firstdat "|"
          impdata_fil.packcod  "|"
          impdata_fil.camp_no  "|"
          impdata_fil.campen   "|"
          impdata_fil.specon   "|"
          impdata_fil.product  "|"
          impdata_fil.promo    "|"
          impdata_fil.rencnt   "|"
          impdata_fil.prepol   "|".
      FIND FIRST imptxt_fil  use-index txt_fil02    WHERE 
        imptxt_fil.usrid    = impdata_fil.usrid     AND 
        imptxt_fil.progid   = impdata_fil.progid    AND 
        imptxt_fil.policyno = trim(impdata_fil.policyno) NO-LOCK NO-ERROR NO-WAIT .
      IF AVAIL imptxt_fil THEN DO:
          PUT STREAM ns1
           imptxt_fil.txt1   "|"
           imptxt_fil.txt2   "|"
           imptxt_fil.txt3   "|"
           imptxt_fil.txt4   "|"
           imptxt_fil.txt5   "|"
           imptxt_fil.txt6   "|"
           imptxt_fil.txt7   "|"
           imptxt_fil.txt8   "|"
           imptxt_fil.txt9   "|"
           imptxt_fil.txt10  "|".
      END.
      ELSE DO:
          PUT STREAM ns1
            ""  "|"
            ""  "|"
            ""  "|"
            ""  "|"
            ""  "|"
            ""  "|"
            ""  "|"
            ""  "|"
            ""  "|"
            ""  "|".
      END.
      FIND FIRST impmemo_fil use-index memo_fil02   WHERE 
        impmemo_fil.usrid    = impdata_fil.usrid    AND 
        impmemo_fil.progid   = impdata_fil.progid   AND 
        impmemo_fil.policyno = trim(impdata_fil.policyno) NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL impmemo_fil THEN DO:
          PUT STREAM ns1
            impmemo_fil.memo1  "|"
            impmemo_fil.memo2  "|"
            impmemo_fil.memo3  "|"
            impmemo_fil.memo4  "|"
            impmemo_fil.memo5  "|"
            impmemo_fil.memo6  "|"
            impmemo_fil.memo7  "|"
            impmemo_fil.memo8  "|"
            impmemo_fil.memo9  "|"
            impmemo_fil.memo10 "|" .
      END.
      ELSE DO:
          PUT STREAM ns1
           ""    "|"
           ""    "|"
           ""    "|"
           ""    "|"
           ""    "|"
           ""    "|"
           ""    "|"
           ""    "|"
           ""    "|"
           ""    "|" .
      END.
      PUT STREAM ns1
          impacc_fil.accdata1     "|"
          impacc_fil.accdata2     "|"
          impacc_fil.accdata3     "|"
          impacc_fil.accdata4     "|"
          impacc_fil.accdata5     "|"
          impacc_fil.accdata6     "|"
          impacc_fil.accdata7     "|"
          impacc_fil.accdata8     "|"
          impacc_fil.accdata9     "|"
          impacc_fil.accdata10    "|"
          impdata_fil.compul      "|"
          impdata_fil.insref      "|"
          impdata_fil.instyp      "|"
          impdata_fil.inslang     "|"
          impdata_fil.tiname      "|"
          impdata_fil.insnam      "|"
          impdata_fil.lastname    "|"
          impdata_fil.icno        "|"
          impdata_fil.insbr       "|"
          impdata_fil.occup       "|"
          impdata_fil.addr        "|"
          impdata_fil.tambon      "|"
          impdata_fil.amper       "|"
          impdata_fil.country     "|"
          impdata_fil.post        "|"
          impdata_fil.provcod     "|"
          impdata_fil.distcod     "|"
          impdata_fil.sdistcod    "|"
          impdata_fil.jpae        "|"
          impdata_fil.jpjtl       "|"
          impdata_fil.jpts        "|"
          impdata_fil.gender      "|"
          impdata_fil.tele1       "|"
          impdata_fil.tele2       "|"
          impdata_fil.mail1       "|"
          impdata_fil.mail2       "|"
          impdata_fil.mail3       "|"
          impdata_fil.mail4       "|"
          impdata_fil.mail5       "|"
          impdata_fil.mail6       "|"
          impdata_fil.mail7       "|"
          impdata_fil.mail8       "|"
          impdata_fil.mail9       "|"
          impdata_fil.mail10      "|"
          impdata_fil.fax         "|"
          impdata_fil.lineID      "|"
          impdata_fil.name2       "|"
          impdata_fil.name3       "|"
          impdata_fil.benname     "|"
          impdata_fil.payercod    "|"
          impdata_fil.vatcode     "|"
          impinst_fil.instcod1    "|"
          impinst_fil.insttyp1    "|"
          impinst_fil.insttitle1  "|"
          impinst_fil.instname1   "|"
          impinst_fil.instlname1  "|"
          impinst_fil.instic1     "|"
          impinst_fil.instbr1     "|"
          impinst_fil.instaddr11  "|"
          impinst_fil.instaddr21  "|"
          impinst_fil.instaddr31  "|"
          impinst_fil.instaddr41  "|"
          impinst_fil.instpost1   "|"
          impinst_fil.instprovcod1  "|"
          impinst_fil.instdistcod1  "|"
          impinst_fil.instsdistcod1 "|"
          impinst_fil.instprm1      "|"
          impinst_fil.instrstp1     "|"
          impinst_fil.instrtax1     "|"
          impinst_fil.instcomm01    "|"
          impinst_fil.instcomm12    "|"
          impinst_fil.instcod2      "|"
          impinst_fil.insttyp2      "|"
          impinst_fil.insttitle2    "|"
          impinst_fil.instname2     "|"
          impinst_fil.instlname2    "|"
          impinst_fil.instic2       "|"
          impinst_fil.instbr2       "|"
          impinst_fil.instaddr12    "|"
          impinst_fil.instaddr22    "|"
          impinst_fil.instaddr32    "|"
          impinst_fil.instaddr42    "|"
          impinst_fil.instpost2     "|"
          impinst_fil.instprovcod2  "|"
          impinst_fil.instdistcod2  "|"
          impinst_fil.instsdistcod2 "|"
          impinst_fil.instprm2      "|"
          impinst_fil.instrstp2     "|"
          impinst_fil.instrtax2     "|"
          impinst_fil.instcomm02    "|"
          impinst_fil.instcomm22    "|"
          impinst_fil.instcod3      "|"
          impinst_fil.insttyp3      "|"
          impinst_fil.insttitle3    "|"
          impinst_fil.instname3     "|"
          impinst_fil.instlname3    "|"
          impinst_fil.instic3       "|"
          impinst_fil.instbr3       "|"
          impinst_fil.instaddr13    "|"
          impinst_fil.instaddr23    "|"
          impinst_fil.instaddr33    "|"
          impinst_fil.instaddr43    "|"
          impinst_fil.instpost3     "|"
          impinst_fil.instprovcod3  "|"
          impinst_fil.instdistcod3  "|"
          impinst_fil.instsdistcod3 "|"
          impinst_fil.instprm3      "|"
          impinst_fil.instrstp3     "|"
          impinst_fil.instrtax3     "|"
          impinst_fil.instcomm03    "|"
          impinst_fil.instcomm23    "|"
          impdata_fil.covcod        "|"
          impdata_fil.garage        "|"
          impdata_fil.special       "|"
          impdata_fil.inspec        "|"
          impdata_fil.class70       "|"
          impdata_fil.vehuse        "|"  /* ranu : 15/12/2021*/
          impdata_fil.redbook       "|"  /* A65-0079 Redbook */
          impdata_fil.brand         "|"
          impdata_fil.model         "|"
          impdata_fil.submodel      "|"
          impdata_fil.yrmanu        "|"
          impdata_fil.chasno        "|"
          impdata_fil.eng           "|"
          impdata_fil.eng_no2       "|" /*A67-0029*/
          impdata_fil.seat41        "|"
          impdata_fil.engcc         "|"
          impdata_fil.weight        "|"
          impdata_fil.watt          "|"
          impdata_fil.body          "|"
          impdata_fil.typ           "|"
          impdata_fil.re_year       "|"
          impdata_fil.vehreg        "|"
          impdata_fil.re_country    "|"
          impdata_fil.cargrp        "|"
          impdata_fil.colorcar      "|"
          impdata_fil.fule          "|"
          impdata_fil.drivnam       "|".
      FIND FIRST impdriv_fil WHERE  
       impdriv_fil.policy  = TRIM(impdata_fil.policyno) AND                
       impdriv_fil.riskno  = impdata_fil.riskno   AND                   
       impdriv_fil.itemno  = impdata_fil.itemno   AND
       impdriv_fil.usrid   = impdata_fil.usrid    and
       impdriv_fil.progid  = impdata_fil.progid   NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL impdriv_fil THEN DO:
        PUT STREAM ns1
          impdriv_fil.ntitle1    "|"
          impdriv_fil.name1      "|"
          impdriv_fil.lname1     "|"
          impdriv_fil.dicno1     "|"
          impdriv_fil.dgender1   "|"
          impdriv_fil.dbirth1    "|"
          impdriv_fil.doccup1    "|"
          impdriv_fil.ddriveno1  "|"
          impdriv_fil.drivexp1   "|"
          impdriv_fil.dconsen1   "|"
          impdriv_fil.dlevel1    "|"
          impdriv_fil.ntitle2    "|"
          impdriv_fil.name2      "|"
          impdriv_fil.lname2     "|"
          impdriv_fil.dicno2     "|"
          impdriv_fil.dgender2   "|"
          impdriv_fil.dbirth2    "|"
          impdriv_fil.doccup2    "|"
          impdriv_fil.ddriveno2  "|"
          impdriv_fil.drivexp2   "|"
          impdriv_fil.dconsen2   "|"
          impdriv_fil.dlevel2    "|"
          impdriv_fil.ntitle3    "|"
          impdriv_fil.name3      "|"
          impdriv_fil.lname3     "|"
          impdriv_fil.dicno3     "|"
          impdriv_fil.dgender3   "|"
          impdriv_fil.dbirth3    "|"
          impdriv_fil.doccup3    "|"
          impdriv_fil.ddriveno3  "|"
          impdriv_fil.drivexp3   "|"
          impdriv_fil.dconsen3   "|"
          impdriv_fil.dlevel3    "|"
          impdriv_fil.ntitle4    "|"
          impdriv_fil.name4      "|"
          impdriv_fil.lname4     "|"
          impdriv_fil.dicno4     "|"
          impdriv_fil.dgender4   "|"
          impdriv_fil.dbirth4    "|"
          impdriv_fil.doccup4    "|"
          impdriv_fil.ddriveno4  "|"
          impdriv_fil.drivexp4   "|"
          impdriv_fil.dconsen4   "|"
          impdriv_fil.dlevel4    "|"
          impdriv_fil.ntitle5    "|"
          impdriv_fil.name5      "|"
          impdriv_fil.lname5     "|"
          impdriv_fil.dicno5     "|"
          impdriv_fil.dgender5   "|"
          impdriv_fil.dbirth5    "|"
          impdriv_fil.doccup5    "|"
          impdriv_fil.ddriveno5  "|"
          impdriv_fil.drivexp5   "|"
          impdriv_fil.dconsen5   "|"
          impdriv_fil.dlevel5    "|".
      END.                             
      ELSE DO:                         
          PUT STREAM ns1 
            ""   "|"
            ""   "|"
            ""   "|"
            ""   "|"
            ""   "|"
            ""   "|"
            ""   "|"
            ""   "|"
            ""   "|"
            ""   "|"
            ""   "|"
            ""   "|"
            ""   "|"
            ""   "|"
            ""   "|"
            ""   "|"
            ""   "|"
            ""   "|"
            ""   "|"
            ""   "|"
            ""   "|"
            ""   "|"
            ""   "|"
            ""   "|"
            ""   "|"
            ""   "|"
            ""   "|"
            ""   "|"
            ""   "|"
            ""   "|"
            ""   "|"
            ""   "|"
            ""   "|"
            ""   "|"
            ""   "|"
            ""   "|"
            ""   "|"
            ""   "|"
            ""   "|"
            ""   "|"
            ""   "|"
            ""   "|"
            ""   "|"
            ""   "|"
            ""   "|"
            ""   "|"
            ""   "|"
            ""   "|"
            ""   "|"
            ""   "|"
            ""   "|"
            ""   "|"
            ""   "|"
            ""   "|"
            ""   "|".
      END.
      PUT STREAM ns1
         impdata_fil.baseplus      "|"
         impdata_fil.siplus        "|"
         impdata_fil.rs10          "|"
         impdata_fil.comper        "|"
         impdata_fil.comacc        "|"
         impdata_fil.deductpd      "|"
         impdata_fil.DOD           "|"
         impdata_fil.dgatt         "|"  /*A65-0079 DOD1 */ 
         impdata_fil.DPD           "|"
         impdata_fil.maksi         "|" /*A67-0029*/
         impdata_fil.si            "|"
         impdata_fil.NO_411        "|"
         impdata_fil.seat41        "|"
         impdata_fil.NO_412        "|"
         impdata_fil.NO_413        "|"
         impdata_fil.pass_no       "|"
         impdata_fil.NO_414        "|"
         impdata_fil.NO_42         "|"
         impdata_fil.NO_43         "|"
         impdata_fil.base          "|"
         impdata_fil.unname        "|"
         impdata_fil.nname         "|"
         impdata_fil.tpbi          "|"
         impdata_fil.dgsi          "|" /*A65-0079 BI2 prem */
         impdata_fil.tppd          "|"
         impdata_fil.int1          "|" /*A65-0079 dod  prem*/
         impdata_fil.int2          "|" /*A65-0079 dod1 prem */
         impdata_fil.int3          "|" /*A65-0079 dpd  prem*/
         impdata_fil.ry01          "|"
         impdata_fil.deci1         "|" /*A65-0079 412 prem */
         impdata_fil.deci2         "|" /*A65-0079 413 prem */
         impdata_fil.deci3         "|" /*A65-0079 414 prem */
         impdata_fil.ry02          "|"
         impdata_fil.ry03          "|"
         impdata_fil.fleet         "|"
         impdata_fil.ncb           "|"
         impdata_fil.claim         "|"
         impdata_fil.dspc          "|"
         impdata_fil.cctv          "|"
         impdata_fil.dstf          "|"
         impdata_fil.fleetprem     "|"
         impdata_fil.ncbprem       "|"
         impdata_fil.clprem        "|"
         impdata_fil.dspcprem      "|"
         impdata_fil.cctvprem      "|"
         impdata_fil.dstfprem      "|"
         impdata_fil.premt         "|"
         impdata_fil.rstp_t        "|"
         impdata_fil.rtax_t        "|"
         impdata_fil.comper70      "|"
         impdata_fil.comprem70     "|"
         impdata_fil.agco70        "|"
         impdata_fil.comco_per70   "|"
         impdata_fil.comco_prem70  "|"
         impdata_fil.dgpackge      "|"
         impdata_fil.danger1       "|"
         impdata_fil.danger2       "|"
         /*impdata_fil.dgsi          "|" */ /*A65-0079 : ย้ายไปเก็บ tpbi2 amount */ 
         " "                      "|"     /*A65-0079 : ย้ายไปเก็บ tpbi2 amount */ 
         impdata_fil.dgrate        "|"
         impdata_fil.dgfeet        "|"
         impdata_fil.dgncb         "|"
         impdata_fil.dgdisc        "|"
         impdata_fil.dgWdisc       "|"
         /*impdata_fil.dgatt         "|" */ /*A65-0079 : ย้ายไปเก็บ DOD1*/ 
         " "                       "|"    /*A65-0079 : ย้ายไปเก็บ DOD1*/
         impdata_fil.dgfeetprm     "|"
         impdata_fil.dgncbprm      "|"
         impdata_fil.dgdiscprm     "|"
         impdata_fil.dgWdiscprm    "|"
         impdata_fil.dgprem        "|"
         impdata_fil.dgrstp_t      "|"
         impdata_fil.dgrtax_t      "|"
         impdata_fil.dgcomper      "|"
         impdata_fil.dgcomprem     "|"
         impdata_fil.cltxt         "|"
         impdata_fil.clamount      "|"
         impdata_fil.faultno       "|"
         impdata_fil.faultprm      "|"
         impdata_fil.goodno        "|"
         impdata_fil.goodprm       "|"
         impdata_fil.loss          "|"
         impdata_fil.compolusory   "|"
         impdata_fil.stk           "|"
         impdata_fil.class72       "|"
         impdata_fil.dstf72        "|"
         impdata_fil.dstfprem72    "|"
         impdata_fil.premt72       "|"
         impdata_fil.rstp_t72      "|"
         impdata_fil.rtax_t72      "|"
         impdata_fil.comper72      "|"
         impdata_fil.comprem72     "|"
         impdata_fil.battno       "|"
         impdata_fil.battyr       "|"
         impdata_fil.battprice    "|"
         impdata_fil.battsi       "|"
         impdata_fil.battrate     "|"
         impdata_fil.battprm      "|"
         impdata_fil.chargno      "|"
         impdata_fil.chargsi      "|"
         impdata_fil.chargrate    "|"
         impdata_fil.chargprm     "|"
         impdata_fil.comment       SKIP .
    END. 
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportpolno_2-bp C-Win 
PROCEDURE proc_reportpolno_2-bp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_count AS INT INIT 0.
DO:
    FOR EACH impdata_fil  USE-INDEX data_fil10       WHERE 
             impdata_fil.usrid  = USERID(LDBNAME(1)) AND 
             impdata_fil.progid = trim(nv_proid)     NO-LOCK BY riskno .
             n_count = n_count + 1.                 
    
      FIND FIRST impacc_fil  use-index acc_fil03  WHERE 
        impacc_fil.policyno = TRIM(impdata_fil.policyno) AND
        impacc_fil.riskno   = impdata_fil.riskno   AND
        impacc_fil.itemno   = impdata_fil.itemno   AND 
        impacc_fil.usrid    = impdata_fil.usrid    AND 
        impacc_fil.progid   = impdata_fil.progid   NO-LOCK NO-ERROR NO-WAIT .
          
      FIND FIRST impinst_fil USE-INDEX inst_fil02  WHERE
        impinst_fil.usrid    = impdata_fil.usrid   AND     
        impinst_fil.progid   = impdata_fil.progid  AND     
        impinst_fil.policyno = trim(impdata_fil.policyno) NO-LOCK NO-ERROR NO-WAIT.

      FIND FIRST impdriv_fil   WHERE  
       impdriv_fil.policy  = TRIM(impdata_fil.policyno) AND                
       impdriv_fil.riskno  = impdata_fil.riskno   AND                   
       impdriv_fil.itemno  = impdata_fil.itemno   AND
       impdriv_fil.usrid   = impdata_fil.usrid    and
       impdriv_fil.progid  = impdata_fil.progid   NO-LOCK NO-ERROR NO-WAIT.
                                                  
      PUT STREAM ns1 
                impdata_fil.riskno       "|"
                impdata_fil.itemno       "|"
                impdata_fil.policyno FORMAT "x(15)"  "|"
                impdata_fil.n_branch     "|"
                impdata_fil.agent        "|"
                impdata_fil.producer     "|"
                impdata_fil.n_delercode  "|"
                impdata_fil.fincode      "|"
                impdata_fil.appenno      "|"
                impdata_fil.salename     "|"
                impdata_fil.srate        "|"
                impdata_fil.comdat       "|"
                impdata_fil.expdat       "|"
                impdata_fil.agreedat     "|"
                impdata_fil.firstdat     "|"
                impdata_fil.packcod      "|"
                impdata_fil.camp_no      "|"
                impdata_fil.campen       "|"
                impdata_fil.specon       "|"
                impdata_fil.product      "|"
                impdata_fil.promo        "|"
                impdata_fil.rencnt       "|"
                impdata_fil.prepol       "|".

      FIND FIRST imptxt_fil  use-index txt_fil02    WHERE 
        imptxt_fil.usrid    = impdata_fil.usrid     AND 
        imptxt_fil.progid   = impdata_fil.progid    AND 
        imptxt_fil.policyno = trim(impdata_fil.policyno) NO-LOCK NO-ERROR NO-WAIT .
      IF AVAIL imptxt_fil THEN DO:
          PUT STREAM ns1
                imptxt_fil.txt1          "|"
                imptxt_fil.txt2          "|"
                imptxt_fil.txt3          "|"
                imptxt_fil.txt4          "|"
                imptxt_fil.txt5          "|"
                imptxt_fil.txt6          "|"
                imptxt_fil.txt7          "|"
                imptxt_fil.txt8          "|"
                imptxt_fil.txt9          "|"
                imptxt_fil.txt10         "|".
      END.
      ELSE DO:
          PUT STREAM ns1
               ""        "|"
               ""        "|"
               ""        "|"
               ""        "|"
               ""        "|"
               ""        "|"
               ""        "|"
               ""        "|"
               ""        "|"
               ""        "|".
      END.
      FIND FIRST impmemo_fil use-index memo_fil02   WHERE 
        impmemo_fil.usrid    = impdata_fil.usrid    AND 
        impmemo_fil.progid   = impdata_fil.progid   AND 
        impmemo_fil.policyno = trim(impdata_fil.policyno) NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL impmemo_fil THEN DO:
          PUT STREAM ns1
                impmemo_fil.memo1        "|"
                impmemo_fil.memo2        "|"
                impmemo_fil.memo3        "|"
                impmemo_fil.memo4        "|"
                impmemo_fil.memo5        "|"
                impmemo_fil.memo6        "|"
                impmemo_fil.memo7        "|"
                impmemo_fil.memo8        "|"
                impmemo_fil.memo9        "|"
                impmemo_fil.memo10       "|" .
      END.
      ELSE DO:
          PUT STREAM ns1
                ""    "|"
                ""    "|"
                ""    "|"
                ""    "|"
                ""    "|"
                ""    "|"
                ""    "|"
                ""    "|"
                ""    "|"
                ""    "|" .
      END.
      PUT STREAM ns1
                impacc_fil.accdata1       "|"
                impacc_fil.accdata2       "|"
                impacc_fil.accdata3       "|"
                impacc_fil.accdata4       "|"
                impacc_fil.accdata5       "|"
                impacc_fil.accdata6       "|"
                impacc_fil.accdata7       "|"
                impacc_fil.accdata8       "|"
                impacc_fil.accdata9       "|"
                impacc_fil.accdata10      "|"
                impdata_fil.compul        "|"
                impdata_fil.insref        "|"
                impdata_fil.instyp        "|"
                impdata_fil.inslang       "|"
                impdata_fil.tiname        "|"
                impdata_fil.insnam        "|"
                impdata_fil.lastname      "|"
                impdata_fil.icno          "|"
                impdata_fil.insbr         "|"
                impdata_fil.occup         "|"
                impdata_fil.addr          "|"
                impdata_fil.tambon        "|"
                impdata_fil.amper         "|"
                impdata_fil.country       "|"
                impdata_fil.post          "|"
                impdata_fil.provcod       "|"
                impdata_fil.distcod       "|"
                impdata_fil.sdistcod      "|"
                impdata_fil.jpae          "|"
                impdata_fil.jpjtl         "|"
                impdata_fil.jpts          "|"
                impdata_fil.gender        "|"
                impdata_fil.tele1         "|"
                impdata_fil.tele2         "|"
                impdata_fil.mail1         "|"
                impdata_fil.mail2         "|"
                impdata_fil.mail3         "|"
                impdata_fil.mail4         "|"
                impdata_fil.mail5         "|"
                impdata_fil.mail6         "|"
                impdata_fil.mail7         "|"
                impdata_fil.mail8         "|"
                impdata_fil.mail9         "|"
                impdata_fil.mail10        "|"
                impdata_fil.fax           "|"
                impdata_fil.lineID        "|"
                impdata_fil.name2         "|"
                impdata_fil.name3         "|"
                impdata_fil.benname       "|"
                impdata_fil.payercod      "|"
                impdata_fil.vatcode       "|"
                impinst_fil.instcod1        "|"
                impinst_fil.insttyp1        "|"
                impinst_fil.insttitle1      "|"
                impinst_fil.instname1       "|"
                impinst_fil.instlname1      "|"
                impinst_fil.instic1         "|"
                impinst_fil.instbr1         "|"
                impinst_fil.instaddr11      "|"
                impinst_fil.instaddr21      "|"
                impinst_fil.instaddr31      "|"
                impinst_fil.instaddr41      "|"
                impinst_fil.instpost1       "|"
                impinst_fil.instprovcod1    "|"
                impinst_fil.instdistcod1    "|"
                impinst_fil.instsdistcod1   "|"
                impinst_fil.instprm1        "|"
                impinst_fil.instrstp1       "|"
                impinst_fil.instrtax1       "|"
                impinst_fil.instcomm01      "|"
                impinst_fil.instcomm12      "|"
                impinst_fil.instcod2        "|"
                impinst_fil.insttyp2        "|"
                impinst_fil.insttitle2      "|"
                impinst_fil.instname2       "|"
                impinst_fil.instlname2      "|"
                impinst_fil.instic2         "|"
                impinst_fil.instbr2         "|"
                impinst_fil.instaddr12      "|"
                impinst_fil.instaddr22      "|"
                impinst_fil.instaddr32      "|"
                impinst_fil.instaddr42      "|"
                impinst_fil.instpost2       "|"
                impinst_fil.instprovcod2    "|"
                impinst_fil.instdistcod2    "|"
                impinst_fil.instsdistcod2   "|"
                impinst_fil.instprm2        "|"
                impinst_fil.instrstp2       "|"
                impinst_fil.instrtax2       "|"
                impinst_fil.instcomm02      "|"
                impinst_fil.instcomm22      "|"
                impinst_fil.instcod3        "|"
                impinst_fil.insttyp3        "|"
                impinst_fil.insttitle3      "|"
                impinst_fil.instname3       "|"
                impinst_fil.instlname3      "|"
                impinst_fil.instic3         "|"
                impinst_fil.instbr3         "|"
                impinst_fil.instaddr13      "|"
                impinst_fil.instaddr23      "|"
                impinst_fil.instaddr33      "|"
                impinst_fil.instaddr43      "|"
                impinst_fil.instpost3       "|"
                impinst_fil.instprovcod3    "|"
                impinst_fil.instdistcod3    "|"
                impinst_fil.instsdistcod3   "|"
                impinst_fil.instprm3        "|"
                impinst_fil.instrstp3       "|"
                impinst_fil.instrtax3       "|"
                impinst_fil.instcomm03      "|"
                impinst_fil.instcomm23      "|"
                impdata_fil.covcod        "|"
                impdata_fil.garage        "|"
                impdata_fil.special       "|"
                impdata_fil.inspec        "|"
                impdata_fil.class70       "|"
                impdata_fil.vehuse        "|"  /* ranu : 15/12/2021*/
                impdata_fil.redbook       "|"  /* A65-0079 Redbook */
                impdata_fil.brand         "|"
                impdata_fil.model         "|"
                impdata_fil.submodel      "|"
                impdata_fil.yrmanu        "|"
                impdata_fil.chasno        "|"
                impdata_fil.eng           "|"
                impdata_fil.eng_no2       "|" /*A67-0029*/
                impdata_fil.seat41        "|"
                impdata_fil.engcc         "|"
                impdata_fil.weight        "|"
                impdata_fil.watt          "|"
                impdata_fil.body          "|"
                impdata_fil.typ           "|"
                impdata_fil.re_year       "|"
                impdata_fil.vehreg        "|"
                impdata_fil.re_country    "|"
                impdata_fil.cargrp        "|"
                impdata_fil.colorcar      "|"
                impdata_fil.fule          "|"
                impdata_fil.drivnam       "|"
                impdriv_fil.ntitle1       "|"
                impdriv_fil.name1         "|"
                impdriv_fil.lname1        "|"
                impdriv_fil.dicno1        "|"
                impdriv_fil.dgender1      "|"
                impdriv_fil.dbirth1       "|"
                impdriv_fil.doccup1       "|"
                impdriv_fil.ddriveno1     "|"
                impdriv_fil.drivexp1      "|"
                impdriv_fil.dconsen1      "|"
                impdriv_fil.dlevel1       "|"
                impdriv_fil.ntitle2       "|"
                impdriv_fil.name2         "|"
                impdriv_fil.lname2        "|"
                impdriv_fil.dicno2        "|"
                impdriv_fil.dgender2      "|"
                impdriv_fil.dbirth2       "|"
                impdriv_fil.doccup2       "|"
                impdriv_fil.ddriveno2     "|"
                impdriv_fil.drivexp2      "|"
                impdriv_fil.dconsen2      "|"
                impdriv_fil.dlevel2       "|"
                impdriv_fil.ntitle3       "|"
                impdriv_fil.name3         "|"
                impdriv_fil.lname3        "|"
                impdriv_fil.dicno3        "|"
                impdriv_fil.dgender3      "|"
                impdriv_fil.dbirth3       "|"
                impdriv_fil.doccup3       "|"
                impdriv_fil.ddriveno3     "|"
                impdriv_fil.drivexp3      "|"
                impdriv_fil.dconsen3      "|"
                impdriv_fil.dlevel3       "|"
                impdriv_fil.ntitle4       "|"
                impdriv_fil.name4         "|"
                impdriv_fil.lname4        "|"
                impdriv_fil.dicno4        "|"
                impdriv_fil.dgender4      "|"
                impdriv_fil.dbirth4       "|"
                impdriv_fil.doccup4       "|"
                impdriv_fil.ddriveno4     "|"
                impdriv_fil.drivexp4      "|"
                impdriv_fil.dconsen4      "|"
                impdriv_fil.dlevel4       "|"
                impdriv_fil.ntitle5       "|"
                impdriv_fil.name5         "|"
                impdriv_fil.lname5        "|"
                impdriv_fil.dicno5        "|"
                impdriv_fil.dgender5      "|"
                impdriv_fil.dbirth5       "|"
                impdriv_fil.doccup5       "|"
                impdriv_fil.ddriveno5     "|"
                impdriv_fil.drivexp5      "|"
                impdriv_fil.dconsen5      "|"
                impdriv_fil.dlevel5       "|"
                impdata_fil.baseplus      "|"
                impdata_fil.siplus        "|"
                impdata_fil.rs10          "|"
                impdata_fil.comper        "|"
                impdata_fil.comacc        "|"
                impdata_fil.deductpd      "|"
                impdata_fil.DOD           "|"
                impdata_fil.dgatt         "|"  /*A65-0079 DOD1 */ 
                impdata_fil.DPD           "|"
                impdata_fil.maksi         "|" /*A67-0029*/
                impdata_fil.si            "|"
                impdata_fil.NO_411        "|"
                impdata_fil.seat41        "|"
                impdata_fil.NO_412        "|"
                impdata_fil.NO_413        "|"
                impdata_fil.pass_no       "|"
                impdata_fil.NO_414        "|"
                impdata_fil.NO_42         "|"
                impdata_fil.NO_43         "|"
                impdata_fil.base          "|"
                impdata_fil.unname        "|"
                impdata_fil.nname         "|"
                impdata_fil.tpbi          "|"
                impdata_fil.dgsi          "|" /*A65-0079 BI2 prem */
                impdata_fil.tppd          "|"
                impdata_fil.int1          "|" /*A65-0079 dod  prem*/
                impdata_fil.int2          "|" /*A65-0079 dod1 prem */
                impdata_fil.int3          "|" /*A65-0079 dpd  prem*/
                impdata_fil.ry01          "|"
                impdata_fil.deci1         "|" /*A65-0079 412 prem */
                impdata_fil.deci2         "|" /*A65-0079 413 prem */
                impdata_fil.deci3         "|" /*A65-0079 414 prem */
                impdata_fil.ry02          "|"
                impdata_fil.ry03          "|"
                impdata_fil.fleet         "|"
                impdata_fil.ncb           "|"
                impdata_fil.claim         "|"
                impdata_fil.dspc          "|"
                impdata_fil.cctv          "|"
                impdata_fil.dstf          "|"
                impdata_fil.fleetprem     "|"
                impdata_fil.ncbprem       "|"
                impdata_fil.clprem        "|"
                impdata_fil.dspcprem      "|"
                impdata_fil.cctvprem      "|"
                impdata_fil.dstfprem      "|"
                impdata_fil.premt         "|"
                impdata_fil.rstp_t        "|"
                impdata_fil.rtax_t        "|"
                impdata_fil.comper70      "|"
                impdata_fil.comprem70     "|"
                impdata_fil.agco70        "|"
                impdata_fil.comco_per70   "|"
                impdata_fil.comco_prem70  "|"
                impdata_fil.dgpackge      "|"
                impdata_fil.danger1       "|"
                impdata_fil.danger2       "|"
                /*impdata_fil.dgsi          "|" */ /*A65-0079 : ย้ายไปเก็บ tpbi2 amount */ 
                " "                      "|"     /*A65-0079 : ย้ายไปเก็บ tpbi2 amount */ 
                impdata_fil.dgrate        "|"
                impdata_fil.dgfeet        "|"
                impdata_fil.dgncb         "|"
                impdata_fil.dgdisc        "|"
                impdata_fil.dgWdisc       "|"
                /*impdata_fil.dgatt         "|" */ /*A65-0079 : ย้ายไปเก็บ DOD1*/ 
                " "                       "|"    /*A65-0079 : ย้ายไปเก็บ DOD1*/
                impdata_fil.dgfeetprm     "|"
                impdata_fil.dgncbprm      "|"
                impdata_fil.dgdiscprm     "|"
                impdata_fil.dgWdiscprm    "|"
                impdata_fil.dgprem        "|"
                impdata_fil.dgrstp_t      "|"
                impdata_fil.dgrtax_t      "|"
                impdata_fil.dgcomper      "|"
                impdata_fil.dgcomprem     "|"
                impdata_fil.cltxt         "|"
                impdata_fil.clamount      "|"
                impdata_fil.faultno       "|"
                impdata_fil.faultprm      "|"
                impdata_fil.goodno        "|"
                impdata_fil.goodprm       "|"
                impdata_fil.loss          "|"
                impdata_fil.compolusory   "|"
                impdata_fil.stk           "|"
                impdata_fil.class72       "|"
                impdata_fil.dstf72        "|"
                impdata_fil.dstfprem72    "|"
                impdata_fil.premt72       "|"
                impdata_fil.rstp_t72      "|"
                impdata_fil.rtax_t72      "|"
                impdata_fil.comper72      "|"
                impdata_fil.comprem72     "|"
                impdata_fil.battno       "|"
                impdata_fil.battyr       "|"
                impdata_fil.battprice    "|"
                impdata_fil.battsi       "|"
                impdata_fil.battrate     "|"
                impdata_fil.battprm      "|"
                impdata_fil.chargno      "|"
                impdata_fil.chargsi      "|"
                impdata_fil.chargrate    "|"
                impdata_fil.chargprm     "|"
                impdata_fil.comment       SKIP .
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_runningpol C-Win 
PROCEDURE proc_runningpol :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    ASSIGN fi_process = "Create data file Load....".
    DISP fi_process WITH FRAM fr_main.
    RUN proc_deldata.
    RUN proc_assigndata.
    RUN proc_chkpolicy.
    RUN proc_reportpolno. 
    RUN proc_deldata.

    MESSAGE "Match data Complete " VIEW-AS ALERT-BOX.

END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_screen C-Win 
PROCEDURE proc_screen :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
OUTPUT STREAM ns3 TO value(fi_output3).
PUT STREAM NS3   
"IMPORT TEXT FILE FORMAT EMPIRE " SKIP
"             Loaddat : " fi_loaddat    SKIP
"              Branch : " "EM"          SKIP
"       Producer Code : " "EMP0001" SKIP
"          Agent Code : " "EMP0001" SKIP
"  Previous Batch No. : " fi_prevbat   " Batch Year : " fi_bchyr  SKIP
"Input File Name Load : " fi_filename   SKIP
"    Output Data Load : " fi_output1    SKIP
"Output Data Not Load : " fi_output1    SKIP
"     Batch File Name : " fi_output1    SKIP
" policy Import Total : " nv_imppol    "Total Net Premium Imp : " nv_netprm_t " BHT." SKIP
SKIP
SKIP
SKIP
"                             Total Record : " fi_impcnt      "   Total Net Premium : " fi_premtot " BHT." SKIP
"Batch No. : " fi_bchno SKIP
"                           Success Record : " fi_completecnt " Success Net Premium : " fi_premsuc " BHT." .


OUTPUT STREAM ns3 CLOSE.                                                          
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_sic_exp2 C-Win 
PROCEDURE proc_sic_exp2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
loop_conexp:
REPEAT:
    FORM
        gv_id  LABEL " User Id " colon 35 SKIP
        nv_pwd LABEL " Password" colon 35 BLANK
        WITH FRAME nf00 CENTERED ROW 10 SIDE-LABELS OVERLAY width 80
        TITLE   " Connect DB Expiry System"  . 
    
    /*HIDE ALL NO-PAUSE.*//*note block*/
    STATUS INPUT OFF.
    /*
    {s0/s0sf1.i}
    */
    gv_prgid = "GWNEXP02".
    
    REPEAT:
      pause 0.
      STATUS DEFAULT "F4=EXIT".
      ASSIGN
      gv_id     = ""
      n_user    = "".
      UPDATE gv_id nv_pwd GO-ON(F1 F4) WITH FRAME nf00
      EDITING:
        READKEY.
        IF FRAME-FIELD = "gv_id" AND 
           LASTKEY = KEYCODE("ENTER") OR 
           LASTKEY = KEYCODE("f1") THEN DO:
           
           IF INPUT gv_id = "" THEN DO:
              MESSAGE "User ID. IS NOT BLANK".
              NEXT-PROMPT gv_id WITH FRAME nf00.
              NEXT.
           END.
           gv_id = INPUT gv_id.
    
        END.
        IF FRAME-FIELD = "nv_pwd" AND 
           LASTKEY = KEYCODE("ENTER") OR 
           LASTKEY = KEYCODE("f1") THEN DO:
           
           nv_pwd = INPUT nv_pwd.
        END.      
        APPLY LASTKEY.
      END.
      ASSIGN n_user = gv_id.
    
      IF LASTKEY = KEYCODE("F1") OR LASTKEY = KEYCODE("ENTER") THEN DO:
          CONNECT expiry -H TMSTH -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR.   /*HO*/ /*เปลี้ยนHost DataBase เป็น TMSTH*/
         /*CONNECT expiry -H alpha4 -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR.      /*HO*/ */
         /*CONNECT expiry -H devserver -S expiry  -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR. */ /*db test.*/  
         
          CLEAR FRAME nf00.
          HIDE FRAME nf00.
          /*RETURN.*/ 
          IF NOT CONNECTED("sic_exp") THEN NEXT loop_conexp.
          ELSE DO:
               LEAVE loop_conexp.
               RETURN.
          END.
       END.
       IF FRAME-FIELD = "gv_id" OR FRAME-FIELD = "nv_pwd" AND LASTKEY = KEYCODE("F4") THEN DO:
            CLEAR FRAME nf00.
            HIDE FRAME nf00.
            LEAVE loop_conexp.
            RETURN.
       END.
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_susspect C-Win 
PROCEDURE proc_susspect :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    ASSIGN fi_process = "check supspect " + string(impdata_fil.itemno,"999") + " " + impdata_fil.chasno + ".....".
    DISP fi_process WITH FRAM fr_main.

    DEF VAR nv_msgstatus  as char.
    DEF VAR nn_vehreglist as char.
    DEF VAR nn_namelist   as char.
    DEF VAR nn_namelist2  as char.
    DEF VAR nv_chanolist  as char.
    DEF VAR nv_idnolist   as char.
    DEF VAR nv_CheckLog   as LOGICAL.   
    DEF VAR nv_idnolist2  AS CHAR.
    ASSIGN 
        nv_msgstatus   = ""
        nn_vehreglist  = ""
        nn_namelist    = ""
        nn_namelist2   = "" 
        nv_chanolist   = "" 
        nv_idnolist    = "" 
        nv_CheckLog    = YES
        nn_vehreglist  = trim(impdata_fil.vehreg)  
        nv_chanolist   = trim(impdata_fil.chasno)  
        nv_idnolist    = trim(impdata_fil.icno) .

   /* IF R-INDEX(impdata_fil.insnam," ") <> 0 THEN  */
        ASSIGN
        nn_namelist    = trim(impdata_fil.insnam)  
        nn_namelist2   = trim(impdata_fil.lastname).
   /* ELSE ASSIGN
        nn_namelist    = TRIM(impdata_fil.insnam) 
        nn_namelist2   = "".*/

  
    IF impdata_fil.vehreg <> "" THEN DO:
        FIND LAST sicuw.uzsusp USE-INDEX uzsusp01    WHERE 
            sicuw.uzsusp.vehreg = nn_vehreglist    NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uzsusp  THEN DO:
            ASSIGN nv_msgstatus    = "รถผู้เอาประกัน ติด suspect ทะเบียน " + nn_vehreglist + " กรุณาติดต่อฝ่ายรับประกัน"
                   impdata_fil.comment = impdata_fil.comment + "|" + nv_msgstatus  
                   impdata_fil.pass    = "N"     
                   impdata_fil.OK_GEN  = "N".
        END.
    END.
    IF (nv_msgstatus = "") AND (nn_namelist <> "") THEN DO:
        FIND LAST sicuw.uzsusp USE-INDEX uzsusp03   WHERE 
            sicuw.uzsusp.fname = nn_namelist           AND 
            sicuw.uzsusp.lname = nn_namelist2          NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uzsusp  THEN DO:
            ASSIGN nv_msgstatus    = "ชื่อผู้เอาประกัน ติด suspect คุณ" + nn_namelist + " " + nn_namelist2 + " กรุณาติดต่อฝ่ายรับประกัน" 
                impdata_fil.comment = impdata_fil.comment + "|" + nv_msgstatus  
                impdata_fil.pass    = "N"     
                impdata_fil.OK_GEN  = "N".
        END.
        ELSE DO:
            FIND LAST sicuw.uzsusp USE-INDEX uzsusp03   WHERE 
                sicuw.uzsusp.fname = nn_namelist  + " " + nn_namelist2        
                NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicuw.uzsusp  THEN DO:
                ASSIGN nv_msgstatus    = "ชื่อผู้เอาประกัน ติด suspect คุณ" + nn_namelist + " " + nn_namelist2 + " กรุณาติดต่อฝ่ายรับประกัน" 
                    impdata_fil.comment = impdata_fil.comment + "|" + nv_msgstatus  
                    impdata_fil.pass    = "N"     
                    impdata_fil.OK_GEN  = "N".
            END.
        END.
    END.
    IF (nv_msgstatus = "") AND (nv_chanolist <> "") THEN DO:
        FIND LAST sicuw.uzsusp USE-INDEX uzsusp05   WHERE 
            uzsusp.cha_no =  nv_chanolist         NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uzsusp  THEN DO:
            ASSIGN nv_msgstatus = "รถผู้เอาประกัน ติด suspect เลขตัวถัง " + nv_chanolist + " กรุณาติดต่อฝ่ายรับประกัน" 
                impdata_fil.comment = impdata_fil.comment + "|" + nv_msgstatus  
                impdata_fil.pass    = "N"     
                impdata_fil.OK_GEN  = "N".
        END.
    END.
    IF (nv_msgstatus = "") AND (nv_idnolist <> "") THEN DO:
        FIND LAST sicuw.uzsusp USE-INDEX uzsusp08    WHERE 
            sicuw.uzsusp.notes = nv_idnolist   NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uzsusp  THEN DO:
            ASSIGN nv_msgstatus = "IDผู้เอาประกัน ติด suspect ID: " + nv_idnolist2 + " กรุณาติดต่อฝ่ายรับประกัน" 
                impdata_fil.comment = impdata_fil.comment + "|" + nv_msgstatus  
                impdata_fil.pass    = "N"     
                impdata_fil.OK_GEN  = "N".
        END.
        IF nv_msgstatus = "" THEN DO:
            ASSIGN 
                nv_idnolist2 = ""
                nv_idnolist  = REPLACE(nv_idnolist,"-","")
                nv_idnolist  = REPLACE(nv_idnolist," ","")
                nv_idnolist2 = substr(nv_idnolist,1,1)  + "-" +
                               substr(nv_idnolist,2,4)  + "-" +
                               substr(nv_idnolist,6,5)  + "-" +
                               substr(nv_idnolist,11,2) + "-" +
                               substr(nv_idnolist,13)   .

            FIND LAST sicuw.uzsusp USE-INDEX uzsusp08  WHERE 
                sicuw.uzsusp.notes = nv_idnolist2         NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicuw.uzsusp  THEN DO:
                ASSIGN nv_msgstatus = "IDผู้เอาประกัน ติด suspect ID: " + nv_idnolist2 + " กรุณาติดต่อฝ่ายรับประกัน" 
                    impdata_fil.comment = impdata_fil.comment + "|" + nv_msgstatus  
                    impdata_fil.pass    = "N"     
                    impdata_fil.OK_GEN  = "N".
            END.
        END.
    END.
    RELEASE sicuw.uzsusp .

END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_TempPolicy C-Win 
PROCEDURE proc_TempPolicy :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
nv_tmppol    = ""
nv_tmppolrun = nv_tmppolrun + 1
nv_tmppol    = nv_batchno + string(nv_tmppolrun, "999") .
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_updaterenew C-Win 
PROCEDURE proc_updaterenew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*A64-0309*/
DEF VAR n_taddress AS CHAR FORMAT "x(150)" INIT "" .
DEF VAR n_name     AS CHAR FORMAT "x(150)" INIT "" .
ASSIGN n_taddress = trim(TRIM(impdata_fil.addr) + " " + TRIM(impdata_fil.tambon) + " " + 
                    TRIM(impdata_fil.amper) + " " + TRIM(impdata_fil.country) + " " + TRIM(impdata_fil.post)).
ASSIGN n_name = trim(trim(impdata_fil.tiname) + " " + TRIM(impdata_fil.insnam) + " " + TRIM(impdata_fil.lastname)).
/* end : A64-0309*/
IF  int(impdata_fil.rencnt)  <> re_rencnt  THEN ASSIGN impdata_fil.rencnt  = re_rencnt .
IF  impdata_fil.n_branch    = "" THEN  ASSIGN impdata_fil.n_branch    = trim(re_branch) .
IF  impdata_fil.insref      = "" THEN  ASSIGN impdata_fil.insref      = trim(re_insref).
if  impdata_fil.agent       = "" THEN  assign impdata_fil.agent       = trim(re_agent)   .
if  impdata_fil.producer    = "" THEN  assign impdata_fil.producer    = trim(re_producer) .
if  impdata_fil.n_delercode = "" THEN  assign impdata_fil.n_delercode = trim(re_delercode).
if  impdata_fil.fincode     = "" THEN  assign impdata_fil.fincode     = trim(re_fincode)  .
if  impdata_fil.payercod    = "" THEN  assign impdata_fil.payercod    = trim(re_payercod) .
if  impdata_fil.vatcode     = "" THEN  assign impdata_fil.vatcode     = trim(re_vatcode)  .
IF  impdata_fil.comdat      = ?  THEN  ASSIGN impdata_fil.comdat      = date(re_comdat) .     
IF  impdata_fil.expdat      = ?  THEN  ASSIGN impdata_fil.expdat      = date(re_expdat) . 
IF  impdata_fil.firstdat    = ?  THEN  ASSIGN impdata_fil.firstdat    = DATE(re_firstdat).
IF n_name = "" THEN DO: /* add : A64-0309*/
    IF  impdata_fil.tiname      = "" then  Assign impdata_fil.tiname      = trim(re_tiname) . 
    IF  impdata_fil.insnam      = "" then  Assign impdata_fil.insnam      = trim(re_insnam) .
    IF  impdata_fil.lastname    = "" THEN  ASSIGN impdata_fil.lastname    = trim(re_lastname) .
END.  /* end : A64-0309*/
IF  impdata_fil.name2       = "" then  Assign impdata_fil.name2       = trim(re_name2)  . 
IF  impdata_fil.name3       = "" then  Assign impdata_fil.name3       = trim(re_name3)  . 
IF  n_taddress = " " THEN DO: /*A64-0309*/
    IF  impdata_fil.addr        = "" then  Assign impdata_fil.addr        = trim(re_n_addr1). 
    IF  impdata_fil.tambon      = "" then  Assign impdata_fil.tambon      = trim(re_n_addr2). 
    IF  impdata_fil.amper       = "" then  Assign impdata_fil.amper       = trim(re_n_addr3). 
    IF  impdata_fil.country     = "" then  Assign impdata_fil.country     = trim(re_n_addr4).
    if  impdata_fil.post        = "" then  assign impdata_fil.post        = trim(re_post)    . 
END. /*A64-0309*/
if  impdata_fil.provcod     = "" then  assign impdata_fil.provcod     = trim(re_provcod) . 
if  impdata_fil.distcod     = "" then  assign impdata_fil.distcod     = trim(re_distcod) . 
if  impdata_fil.sdistcod    = "" then  assign impdata_fil.sdistcod    = trim(re_sdistcod).
IF  impdata_fil.covcod      = "T" AND impdata_fil.class72 = ""  THEN  ASSIGN impdata_fil.class72 = impdata_fil.subclass .
IF  impdata_fil.subclass    = "" THEN DO:
        ASSIGN  impdata_fil.prempa   = SUBSTR(re_class,1,1)
                impdata_fil.subclass = substr(re_class,2,LENGTH(re_class))  /*A64-0044*/.
                /*impdata_fil.subclass = substr(re_class,2,3) */ /*A64-0044*/
END.
IF  impdata_fil.body     = ""   THEN ASSIGN impdata_fil.body     =  n_body.
IF  impdata_fil.weight   = 0    THEN ASSIGN impdata_fil.weight   =  deci(n_Tonn70). 
IF  impdata_fil.engcc    = 0    THEN ASSIGN impdata_fil.engcc    =  int(n_engine). 
IF  impdata_fil.redbook  = ""   THEN ASSIGN impdata_fil.redbook  =  nn_redbook.
IF  impdata_fil.brand    = ""   THEN ASSIGN impdata_fil.brand    =  IF INDEX(re_moddes," ") <> 0 THEN SUBSTR(re_moddes,1,R-INDEX(re_moddes," ")) ELSE re_moddes.  
IF  impdata_fil.model    = ""   THEN ASSIGN impdata_fil.model    =  IF INDEX(re_moddes," ") <> 0 THEN SUBSTR(re_moddes,R-INDEX(re_moddes," ")) ELSE "". 
IF  impdata_fil.yrmanu   = ""   THEN ASSIGN impdata_fil.yrmanu   =  re_yrmanu .     
IF  impdata_fil.seat     = 0    THEN ASSIGN impdata_fil.seat     =  int(re_seats)  .         
IF  impdata_fil.vehuse   = ""   THEN ASSIGN impdata_fil.vehuse   =  re_vehuse .       
IF  impdata_fil.covcod   = ""   THEN ASSIGN impdata_fil.covcod   =  re_covcod .       
IF  impdata_fil.garage   = ""   THEN ASSIGN impdata_fil.garage   =  re_garage .       
IF  impdata_fil.vehreg   = ""   THEN ASSIGN impdata_fil.vehreg   =  re_vehreg .        
IF  impdata_fil.chasno   = ""   THEN ASSIGN impdata_fil.chasno   =  re_cha_no .     
IF  impdata_fil.eng      = ""   THEN ASSIGN impdata_fil.eng      =  re_eng_no . 
IF  impdata_fil.cargrp   = ""   THEN ASSIGN impdata_fil.cargrp   =  re_cargrp .

IF impdata_fil.poltyp = "V70" THEN DO:
   /* IF  impdata_fil.comper70 = 0    THEN*/ /* ASSIGN impdata_fil.comper70 =  re_comm .*/ /* comment by : A64-0257 */
    IF  impdata_fil.comper70 = 0    THEN ASSIGN impdata_fil.comper70 =  re_comm .     /* add by : A64-0257 */
    ASSIGN impdata_fil.baseplus = re_base3 .    /* add by : A64-0257 */
   /* IF  impdata_fil.base     = 0    THEN*/  ASSIGN impdata_fil.base     =  re_baseprm.
   /* IF  impdata_fil.comper   = 0    THEN*/  ASSIGN impdata_fil.comper   =  int(re_uom1_v) .      
   /* IF  impdata_fil.comacc   = 0    THEN*/  ASSIGN impdata_fil.comacc   =  int(re_uom2_v) .     
   /* IF  impdata_fil.deductpd = 0    THEN*/  ASSIGN impdata_fil.deductpd =  int(re_uom5_v) .     
   /* IF  impdata_fil.si       = 0    THEN*/  ASSIGN impdata_fil.si       =  IF index(impdata_fil.covcod,".") = 0 THEN INT(re_si) ELSE 0 .
   /* IF  impdata_fil.siplus   = 0    THEN*/  ASSIGN impdata_fil.siplus   =  IF index(impdata_fil.covcod,".") <> 0 THEN INT(re_si) ELSE 0 .
   /*IF  impdata_fil.fi       = ""   THEN ASSIGN impdata_fil.fi       =  impdata_fil.si.*/
   /* IF  impdata_fil.no_411   = 0    THEN*/  ASSIGN impdata_fil.no_411   =  re_41.      
   /* IF  impdata_fil.no_412   = 0    THEN*/  ASSIGN impdata_fil.no_412   =  re_41.     
   /* IF  impdata_fil.no_42    = 0    THEN*/  ASSIGN impdata_fil.no_42    =  re_42. 
   /* IF  impdata_fil.no_43    = 0    THEN*/  ASSIGN impdata_fil.no_43    =  re_43. 
   /* IF  impdata_fil.seat41   = 0    THEN*/  ASSIGN impdata_fil.seat41   =  re_seat41 .
   /* IF  impdata_fil.dod      = 0    THEN*/  ASSIGN impdata_fil.dod      =  re_dedod.     
   /*IF  impdata_fil.dod2      = ""   THEN ASSIGN impdata_fil.dod2     =  STRING(re_addod).  */   
   /* IF  impdata_fil.dpd      = 0    THEN*/  ASSIGN impdata_fil.dpd      =  re_dedpd.     
   /* IF  int(impdata_fil.fleet) = 0  THEN*/  ASSIGN impdata_fil.fleet    =  STRING(re_flet_per).      
   /* IF  int(impdata_fil.ncb)   = 0  THEN*/  ASSIGN impdata_fil.ncb      =  STRING(re_ncbper).      
   /* IF  int(impdata_fil.dspc)  = 0  THEN*/  ASSIGN impdata_fil.dspc     =  STRING(re_dss_per).      
   /* IF  int(impdata_fil.dstf)  = 0  THEN*/  ASSIGN impdata_fil.dstf     =  STRING(re_stf_per).      
   /* IF  int(impdata_fil.claim) = 0  THEN*/  ASSIGN impdata_fil.claim    =  STRING(re_cl_per).     
    IF  impdata_fil.benname  = ""   THEN ASSIGN impdata_fil.benname  =  re_bennam1.
    IF  re_driver <> "" AND (INT(impdata_fil.drivnam) = 0 OR trim(impdata_fil.drivnam) = "" ) THEN DO: 
        ASSIGN impdata_fil.driver = re_driver 
               impdata_fil.nname  = re_prmtdriv.
    END.
    IF  re_acctxt <> "" THEN DO: 
        CREATE impacc_fil.
        ASSIGN 
        impacc_fil.policyno  =  TRIM(impdata_fil.policyno)
        impacc_fil.accdata1  =  IF LENGTH(re_acctxt) >= 60  THEN SUBSTR(re_acctxt,1,60)    ELSE TRIM(re_acctxt)   
        impacc_fil.accdata2  =  IF LENGTH(re_acctxt) >= 61  THEN SUBSTR(re_acctxt,61,60)   ELSE ""  
        impacc_fil.accdata3  =  IF LENGTH(re_acctxt) >= 121 THEN SUBSTR(re_acctxt,121,60)  ELSE ""
        impacc_fil.accdata4  =  IF LENGTH(re_acctxt) >= 181 THEN SUBSTR(re_acctxt,181,60)  ELSE "" 
        impacc_fil.accdata5  =  IF LENGTH(re_acctxt) >= 241 THEN SUBSTR(re_acctxt,241,60)  ELSE "" 
        impacc_fil.accdata6  =  IF LENGTH(re_acctxt) >= 301 THEN SUBSTR(re_acctxt,301,60)  ELSE "" 
        impacc_fil.accdata7  =  "" 
        impacc_fil.accdata8  =  ""
        impacc_fil.accdata9  =  ""
        impacc_fil.accdata10 =  "".
    END.
   
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_usdcod C-Win 
PROCEDURE Proc_usdcod :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_age1 AS INT INIT 0.
DEF VAR nv_age2 AS INT INIT 0.
DEFINE  VAR   nv_drivcod1 AS CHARACTER FORMAT "X(4)".
DEFINE  VAR   nv_drivcod2 AS CHARACTER FORMAT "X(4)".
DEF VAR nv_age1rate  LIKE  sicsyac.xmm106.appinc.
DEF VAR nv_age2rate  LIKE  sicsyac.xmm106.appinc.
ASSIGN
  nv_age1  = INTEGER(nv_drivage1)
  nv_age2  = INTEGER(nv_drivage2).
nv_drivcod = "A" + STRING(nv_drivno,"9").
  IF nv_drivno = 1 THEN DO:
    IF nv_age1 LE 50 THEN DO:
      IF nv_age1 LE 35 THEN DO:
        IF nv_age1 LE 24 THEN DO:
          nv_drivcod = nv_drivcod + "24".
        END.
        ELSE nv_drivcod = nv_drivcod + "35".
      END.
      ELSE nv_drivcod = nv_drivcod + "50".
    END.
    ELSE nv_drivcod = nv_drivcod + "99".
  END.
  IF  nv_drivno  = 2  THEN DO:
    IF nv_age1 LE 50 THEN DO:
      IF nv_age1 LE 35 THEN DO:
        IF nv_age1 LE 24 THEN DO:
          nv_drivcod1 = nv_drivcod + "24".
        END.
        ELSE nv_drivcod1 = nv_drivcod + "35".
      END.
      ELSE nv_drivcod1 = nv_drivcod + "50".
    END.
    ELSE nv_drivcod1 = nv_drivcod + "99".
    FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
               sicsyac.xmm106.tariff = nv_tariff   AND
               sicsyac.xmm106.bencod = nv_drivcod1 AND
               sicsyac.xmm106.class  = nv_class    AND
               sicsyac.xmm106.covcod = nv_covcod   AND
               sicsyac.xmm106.key_b  GE nv_key_b   AND
               sicsyac.xmm106.effdat LE nv_comdat
    NO-LOCK NO-ERROR.
    IF AVAIL sicsyac.xmm106 THEN
       nv_age1rate = sicsyac.xmm106.appinc.
    IF nv_age2 LE 50 THEN DO:
      IF nv_age2 LE 35 THEN DO:
        IF nv_age2 LE 24 THEN DO:
          nv_drivcod2 = nv_drivcod + "24".
        END.
        ELSE nv_drivcod2 = nv_drivcod + "35".
      END.
      ELSE nv_drivcod2 = nv_drivcod + "50".
    END.
    ELSE nv_drivcod2 = nv_drivcod + "99".
         
    FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
           sicsyac.xmm106.tariff = nv_tariff   AND
           sicsyac.xmm106.bencod = nv_drivcod2 AND
           sicsyac.xmm106.class  = nv_class    AND
           sicsyac.xmm106.covcod = nv_covcod   AND
           sicsyac.xmm106.key_b  GE nv_key_b   AND
           sicsyac.xmm106.effdat LE nv_comdat
           NO-LOCK NO-ERROR.
    IF AVAIL sicsyac.xmm106 THEN
       nv_age2rate = sicsyac.xmm106.appinc.
    IF   nv_age2rate > nv_age1rate  THEN
         nv_drivcod  = nv_drivcod2.
    ELSE nv_drivcod  = nv_drivcod1.
  END.
  RELEASE sicsyac.xmm106 .
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwd100 C-Win 
PROCEDURE proc_uwd100 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*create  text (F17) for Query claim....*/
DEFINE VAR nvw_index1      AS INTEGER INIT 0.
DEF BUFFER wf_uwd100 FOR sic_bran.uwd100.
DEF VAR nv_bptr      AS RECID.
DEF VAR nv_fptr      AS RECID.
FOR EACH wuppertxt.
    DELETE wuppertxt.
END.
ASSIGN 
    nv_bptr  = 0
    nv_line1 = 1 
    nv_txt1  = ""
    nv_txt2  = ""
    nv_txt3  = ""  
    nv_txt4  = ""
    nv_txt5  = ""  
    nv_txt1  = IF impdata_fil.danger1 <> "" THEN "Dangerous Cargo:" + trim(impdata_fil.danger1) + " " + trim(impdata_fil.danger2) ELSE ""
    nv_txt2  = ""
    nv_txt3  = ""
    nv_txt4  = ""
    nv_txt5  = "" . 
IF nv_txt1 <> "" THEN DO:
    CREATE wuppertxt.
    ASSIGN 
        wuppertxt.line = nv_line1
        wuppertxt.txt  = nv_txt1.
    nv_line1 = nv_line1 + 1.
END.
FOR EACH imptxt_fil WHERE imptxt_fil.policyno = impdata_fil.policyno NO-LOCK.
    DO WHILE nv_line1 <= 11:
        CREATE wuppertxt.
        wuppertxt.line = nv_line1.
        IF nv_line1 = 2  THEN wuppertxt.txt  = imptxt_fil.txt1.
        IF nv_line1 = 3  THEN wuppertxt.txt  = imptxt_fil.txt2.
        IF nv_line1 = 4  THEN wuppertxt.txt  = imptxt_fil.txt3.
        IF nv_line1 = 5  THEN wuppertxt.txt  = imptxt_fil.txt4.
        IF nv_line1 = 6  THEN wuppertxt.txt  = imptxt_fil.txt5.
        IF nv_line1 = 7  THEN wuppertxt.txt  = imptxt_fil.txt6.
        IF nv_line1 = 8  THEN wuppertxt.txt  = imptxt_fil.txt7.
        IF nv_line1 = 9  THEN wuppertxt.txt  = imptxt_fil.txt8.
        IF nv_line1 = 10 THEN wuppertxt.txt  = imptxt_fil.txt9.
        IF nv_line1 = 11 THEN wuppertxt.txt  = imptxt_fil.txt10.
        nv_line1 = nv_line1 + 1.
    END.
END.

FIND sic_bran.uwm100 USE-INDEX uwm10001   WHERE 
     sic_bran.uwm100.policy  = impdata_fil.policyno  AND
     sic_bran.uwm100.rencnt  = n_rencnt      AND
     sic_bran.uwm100.endcnt  = n_endcnt      AND
     sic_bran.uwm100.bchyr   = nv_batchyr    AND
     sic_bran.uwm100.bchno   = nv_batchno    AND
     sic_bran.uwm100.bchcnt  = nv_batcnt     NO-ERROR NO-WAIT.
IF AVAILABLE uwm100 THEN DO:
    FOR EACH wuppertxt NO-LOCK BREAK BY wuppertxt.line:
        IF wuppertxt.txt <> "" THEN DO:  /*-- A58-0419 --*/
            CREATE sic_bran.uwd100.
            ASSIGN
                sic_bran.uwd100.bptr    = nv_bptr
                sic_bran.uwd100.fptr    = 0
                sic_bran.uwd100.policy  = impdata_fil.policyno
                sic_bran.uwd100.rencnt  = n_rencnt
                sic_bran.uwd100.endcnt  = n_endcnt
                sic_bran.uwd100.ltext   = wuppertxt.txt.
            IF nv_bptr <> 0 THEN DO:
                FIND wf_uwd100 WHERE RECID(wf_uwd100) = nv_bptr.
                wf_uwd100.fptr = RECID(uwd100).
            END.
            IF nv_bptr = 0 THEN  sic_bran.uwm100.fptr01 = RECID(uwd100).
            nv_bptr = RECID(uwd100).
        END.  /*-- A58-0419 --*/
    END.
    RELEASE sic_bran.uwd100.

    IF impdata_fil.prepol <> ""  THEN DO:
        FOR EACH wuwd100 WHERE wuwd100.policy = TRIM(impdata_fil.prepol) NO-LOCK BREAK BY wuwd100.lnumber:
            IF wuwd100.ltext <> "" THEN DO:  /*-- A58-0419 --*/
                CREATE sic_bran.uwd100.
                ASSIGN
                    sic_bran.uwd100.bptr    = nv_bptr
                    sic_bran.uwd100.fptr    = 0
                    sic_bran.uwd100.policy  = impdata_fil.policyno
                    sic_bran.uwd100.rencnt  = n_rencnt
                    sic_bran.uwd100.endcnt  = n_endcnt
                    sic_bran.uwd100.ltext   = wuwd100.ltext.
                IF nv_bptr <> 0 THEN DO:
                    FIND wf_uwd100 WHERE RECID(wf_uwd100) = nv_bptr.
                    wf_uwd100.fptr = RECID(uwd100).
                END.
                IF nv_bptr = 0 THEN  sic_bran.uwm100.fptr01 = RECID(uwd100).
                nv_bptr = RECID(uwd100).
            END.  /*-- A58-0419 --*/
        END.
    END.
    sic_bran.uwm100.bptr01 = nv_bptr.
END. /*uwm100*/
RELEASE sic_bran.uwd100.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwd102 C-Win 
PROCEDURE proc_uwd102 :
/*------------------------------------------------------------------------------
  Purpose: Create by A58-0419    
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF BUFFER wf_uwd102 FOR sic_bran.uwd102.
DEF VAR nv_bptr      AS RECID.
FOR EACH wuppertxt.
    DELETE wuppertxt.
END.

ASSIGN 
    nv_fptr  = 0
    nv_bptr  = 0
    nv_line1 = 1
    nv_fptr  = sic_bran.uwm100.fptr02
    nv_txt1  = ""  
    nv_txt2  = ""
    nv_txt3  = ""  
    nv_txt4  = ""
    nv_txt5  = "" . 

FOR EACH impmemo_fil WHERE impmemo_fil.policyno = impdata_fil.policyno NO-LOCK.
    DO WHILE nv_line1 <= 10:
        CREATE wuppertxt.
        wuppertxt.line = nv_line1.
        IF nv_line1 = 1  THEN wuppertxt.txt = impmemo_fil.memo1.
        IF nv_line1 = 2  THEN wuppertxt.txt = impmemo_fil.memo2.
        IF nv_line1 = 3  THEN wuppertxt.txt = impmemo_fil.memo3.
        IF nv_line1 = 4  THEN wuppertxt.txt = impmemo_fil.memo4.
        IF nv_line1 = 5  THEN wuppertxt.txt = impmemo_fil.memo5.
        IF nv_line1 = 6  THEN wuppertxt.txt = impmemo_fil.memo6.
        IF nv_line1 = 7  THEN wuppertxt.txt = impmemo_fil.memo7.
        IF nv_line1 = 8  THEN wuppertxt.txt = impmemo_fil.memo8.
        IF nv_line1 = 9  THEN wuppertxt.txt = impmemo_fil.memo9.
        IF nv_line1 = 10 THEN wuppertxt.txt = impmemo_fil.memo10.
        nv_line1 = nv_line1 + 1.
    END.
END.

IF impdata_fil.polmaster <> ""  THEN DO: 
    CREATE wuppertxt.
    ASSIGN wuppertxt.line = nv_line1
           wuppertxt.txt  = "Campaign Policy Master:" + impdata_fil.polmaster  . 
END.

FIND sic_bran.uwm100 USE-INDEX uwm10001   WHERE 
     sic_bran.uwm100.policy  = impdata_fil.policyno  AND
     sic_bran.uwm100.rencnt  = n_rencnt      AND
     sic_bran.uwm100.endcnt  = n_endcnt      AND
     sic_bran.uwm100.bchyr   = nv_batchyr    AND
     sic_bran.uwm100.bchno   = nv_batchno    AND
     sic_bran.uwm100.bchcnt  = nv_batcnt     NO-ERROR NO-WAIT.
IF AVAILABLE uwm100 THEN DO:
    FOR EACH wuppertxt NO-LOCK BREAK BY wuppertxt.line:
        IF wuppertxt.txt <> "" THEN DO:
            CREATE sic_bran.uwd102.
            ASSIGN
                sic_bran.uwd102.bptr    = nv_bptr
                sic_bran.uwd102.fptr    = 0
                sic_bran.uwd102.policy  = sic_bran.uwm100.policy  
                sic_bran.uwd102.rencnt  = sic_bran.uwm100.rencnt  
                sic_bran.uwd102.endcnt  = sic_bran.uwm100.endcnt  
                sic_bran.uwd102.ltext   = wuppertxt.txt.
            IF nv_bptr <> 0 THEN DO:
                FIND wf_uwd102 WHERE RECID(wf_uwd102) = nv_bptr.
                wf_uwd102.fptr = RECID(sic_bran.uwd102).
            END.
            IF nv_bptr = 0 THEN  sic_bran.uwm100.fptr02 = RECID(uwd102).
            nv_bptr = RECID(sic_bran.uwd102).
        END.
    END.
    RELEASE sic_bran.uwd102.
    IF impdata_fil.prepol <> "" THEN DO:                             
        FOR EACH wuwd102 WHERE wuwd102.policy = TRIM(impdata_fil.prepol) NO-LOCK BREAK BY wuwd102.lnumber: 
            IF wuwd102.ltext <> "" THEN DO:
                CREATE sic_bran.uwd102.
                ASSIGN
                    sic_bran.uwd102.bptr    = nv_bptr
                    sic_bran.uwd102.fptr    = 0
                    sic_bran.uwd102.policy  = sic_bran.uwm100.policy  
                    sic_bran.uwd102.rencnt  = sic_bran.uwm100.rencnt  
                    sic_bran.uwd102.endcnt  = sic_bran.uwm100.endcnt  
                    sic_bran.uwd102.ltext   = wuwd102.ltext.
                IF nv_bptr <> 0 THEN DO:
                    FIND wf_uwd102 WHERE RECID(wf_uwd102) = nv_bptr.
                    wf_uwd102.fptr = RECID(sic_bran.uwd102).
                END.
                IF nv_bptr = 0 THEN  sic_bran.uwm100.fptr02 = RECID(uwd102).
                nv_bptr = RECID(sic_bran.uwd102).
            END.
        END.
    END.
    sic_bran.uwm100.bptr02 = nv_bptr.
END. /*uwm100*/
RELEASE sic_bran.uwd102.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwd132_Renew C-Win 
PROCEDURE proc_uwd132_Renew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF BUFFER wf_uwd132 FOR sic_bran.uwd132.
DO:
    FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
    FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
   
    ASSIGN nv_bptr = 0      nv_gapprm   = 0     nv_pdprm    = 0
           nv_411t = 0      nv_412t = 0
           nv_42t  = 0      nv_43t  = 0.
           

     FOR EACH wuwd132  WHERE TRIM(wuwd132.prepol)  = TRIM(impdata_fil.prepol) NO-LOCK.
        FIND sic_bran.uwd132  USE-INDEX uwd13201 WHERE
             sic_bran.uwd132.policy  = sic_bran.uwm100.policy AND
             sic_bran.uwd132.rencnt  = sic_bran.uwm100.rencnt AND
             sic_bran.uwd132.endcnt  = sic_bran.uwm100.endcnt AND
             sic_bran.uwd132.riskgp  = sic_bran.uwm130.riskgp AND
             sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno AND
             sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno AND
             sic_bran.uwd132.bchyr   = nv_batchyr             AND
             sic_bran.uwd132.bchno   = nv_batchno             AND
             sic_bran.uwd132.bchcnt  = nv_batcnt              AND 
             sic_bran.uwd132.bencod  = wuwd132.bencod      NO-ERROR NO-WAIT.
   
            IF NOT AVAILABLE sic_bran.uwd132 THEN DO:
                CREATE sic_bran.uwd132.

               ASSIGN fi_process = "Create data to sic_bran.uwd132  ..." + impdata_fil.policy .
               DISP fi_process WITH FRAM fr_main. 
               ASSIGN
                  sic_bran.uwd132.bencod  =  wuwd132.bencod 
                  sic_bran.uwd132.benvar  =  wuwd132.benvar 
                  /*sic_bran.uwd132.rate    =  0.00 */                    
                  sic_bran.uwd132.gap_ae  =  NO                
                  sic_bran.uwd132.gap_c   =  wuwd132.gap_c                    
                  /*sic_bran.uwd132.dl1_c   =  0.00 */                   
                  /*sic_bran.uwd132.dl2_c   =  0.00 */                   
                  /*sic_bran.uwd132.dl3_c   =  0.00 */                   
                  sic_bran.uwd132.pd_aep  =  "E"                   
                  sic_bran.uwd132.prem_c  =  wuwd132.prem_c                   
                  sic_bran.uwd132.fptr    =  0                  
                  sic_bran.uwd132.bptr    =  nv_bptr                   
                  sic_bran.uwd132.policy  =  sic_bran.uwm100.policy 
                  sic_bran.uwd132.rencnt  =  sic_bran.uwm100.rencnt                    
                  sic_bran.uwd132.endcnt  =  sic_bran.uwm100.endcnt                    
                  sic_bran.uwd132.riskgp  =  sic_bran.uwm130.riskgp                 
                  sic_bran.uwd132.riskno  =  sic_bran.uwm130.riskno                 
                  sic_bran.uwd132.itemno  =  sic_bran.uwm130.itemno                 
                  /*sic_bran.uwd132.rateae  =  "A"   */              
                  sic_bran.uwd132.bchyr   =  nv_batchyr                   
                  sic_bran.uwd132.bchno   =  nv_batchno 
                  sic_bran.uwd132.bchcnt  =  nv_batcnt.
               
                  nv_gapprm = nv_gapprm + wuwd132.gap_c .
                  nv_pdprm  = nv_pdprm  + wuwd132.prem_C.
                /*
               IF sic_bran.uwd132.bencod = "SI"   THEN ASSIGN sic_bran.uwd132.benvar = nv_sivar .
               IF INDEX(sic_bran.uwd132.bencod,"SI2") <> 0  THEN ASSIGN sic_bran.uwd132.benvar = nv_sivar3 .
               IF INDEX(sic_bran.uwd132.bencod,"SI3") <> 0  THEN ASSIGN sic_bran.uwd132.benvar = nv_sivar3 .
               IF sic_bran.uwd132.bencod = "BI1"  THEN ASSIGN sic_bran.uwd132.benvar = nv_bipvar.
               IF sic_bran.uwd132.bencod = "BI2"  THEN ASSIGN sic_bran.uwd132.benvar = nv_biavar.
               IF sic_bran.uwd132.bencod = "PD"   THEN ASSIGN sic_bran.uwd132.benvar = nv_pdavar.*/
               /* add by : Ranu I. A64-0309 05/08/2021 */
               IF sic_bran.uwd132.bencod = "411"  THEN ASSIGN  nv_411t = wuwd132.prem_C  .
               IF sic_bran.uwd132.bencod = "412"  THEN ASSIGN  nv_412t = wuwd132.prem_C  .
               IF sic_bran.uwd132.bencod = "42"   THEN ASSIGN  nv_42t  = wuwd132.prem_C  .
               IF sic_bran.uwd132.bencod = "43"   THEN ASSIGN  nv_43t  = wuwd132.prem_C  .
               /* end A64-0309 */
               IF sic_bran.uwd132.bencod = "dspc" THEN ASSIGN nv_dss_per  = DECI(SUBSTRING(sic_bran.uwd132.benvar,31,30)).
               IF sic_bran.uwd132.bencod = "NCB"  THEN ASSIGN nv_ncbper   = DECI(SUBSTRING(sic_bran.uwd132.benvar,31,30)).
               
               If nv_ncbper  <> 0 Then do:
                   Find LAST sicsyac.xmm104 Use-index xmm10401 Where
                       sicsyac.xmm104.tariff = nv_tariff           AND
                       sicsyac.xmm104.class  = nv_class            AND 
                       sicsyac.xmm104.covcod = nv_covcod           AND 
                       sicsyac.xmm104.ncbper   = INTE(nv_ncbper) No-lock no-error no-wait.
                   IF not avail  sicsyac.xmm104  Then do:
                       Message " This NCB Step not on NCB Rates file xmm104. " View-as alert-box.
                       ASSIGN impdata_fil.pass    = "N"
                           impdata_fil.comment = impdata_fil.comment + "| This NCB Step not on NCB Rates file xmm104. ".
                   END.
                   ELSE ASSIGN nv_ncbper = xmm104.ncbper   
                               nv_ncbyrs = xmm104.ncbyrs.
               END.
               Else do:  
                   ASSIGN nv_ncbyrs =   0
                          nv_ncbper =   0
                          nv_ncb    =   0.
               END.

               ASSIGN   
                sic_bran.uwm301.ncbper   = nv_ncbper
                sic_bran.uwm301.ncbyrs   = nv_ncbyrs .

               IF nv_bptr <> 0 THEN DO:
                   FIND wf_uwd132 WHERE RECID(wf_uwd132) = nv_bptr.
                       wf_uwd132.fptr = RECID(sic_bran.uwd132).
               END.
               IF nv_bptr = 0 THEN sic_bran.uwm130.fptr03  =  RECID(sic_bran.uwd132).
               nv_bptr = RECID(sic_bran.uwd132).

            END.
        END.
        RUN proc_chkRY. /*A64-0309*/

    sic_bran.uwm130.bptr03  = nv_bptr. 
    RELEASE sic_bran.uwd132.

END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_var C-Win 
PROCEDURE proc_var :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
    /* nv_camptyp =  "NORM"*/
    s_riskgp   =   0                     s_riskno       =  1
    s_itemno   =   1                     nv_undyr       =  String(Year(today),"9999")   
    n_rencnt   =   0                     n_endcnt       =  0.
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_wgw72013 C-Win 
PROCEDURE proc_wgw72013 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*DEFINE INPUT        PARAMETER  nv_rec100  AS RECID     NO-UNDO.
DEFINE INPUT        PARAMETER  nv_red132  AS RECID     NO-UNDO.
DEFINE INPUT        PARAMETER  nvtariff   AS CHARACTER NO-UNDO.
DEF            VAR n_dcover   AS   INT FORMAT "99999" INITIAL[0].
DEF            VAR n_dyear    AS   INT FORMAT "99999" INITIAL[0].
DEF            VAR nvyear     AS   INT FORMAT "99999" INITIAL[0].
DEF            VAR n_day1     AS   INT FORMAT "99"    INITIAL[31].
DEF            VAR n_mon1     AS   INT FORMAT "99"    INITIAL[12].
DEF            VAR n_ddyr     AS   INT FORMAT "9999"  INITIAL[0].
DEF            VAR n_ddyr1    AS   INT FORMAT "9999"  INITIAL[0].
DEF            VAR n_dmonth   AS   INT FORMAT "99999" INITIAL[0].
DEF            VAR n_orgnap   LIKE sic_bran.uwd132.gap_c  NO-UNDO.
DEF            VAR s_curbil   LIKE sic_bran.uwm100.curbil NO-UNDO.
def              var  n_total   as deci  no-undo.
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) EQ nv_rec100 NO-WAIT NO-ERROR.
FIND sic_bran.uwd132 WHERE RECID(sic_bran.uwd132) EQ nv_red132 NO-WAIT NO-ERROR.
s_curbil = sic_bran.uwm100.curbil.
n_orgnap = sic_bran.uwd132.gap_c.
IF sic_bran.uwm100.expdat EQ ? OR  sic_bran.uwm100.comdat EQ ? THEN sic_bran.uwd132.prem_c = n_orgnap.
IF nvtariff = "Z" OR nvtariff = "X" THEN DO:
   sic_bran.uwd132.prem_c = n_orgnap.
END.
ELSE DO:
  IF sic_bran.uwm100.expdat NE ? AND sic_bran.uwm100.comdat NE ? THEN DO:
    ASSIGN n_dcover = 0
           n_dyear  = 0
           nvyear   = 0
           n_dmonth = 0.
                IF ( DAY(sic_bran.uwm100.comdat)     =   DAY(sic_bran.uwm100.expdat)    AND
                   MONTH(sic_bran.uwm100.comdat)     = MONTH(sic_bran.uwm100.expdat)    AND
                    YEAR(sic_bran.uwm100.comdat) + 1 =  YEAR(sic_bran.uwm100.expdat) )  OR
                   ( DAY(sic_bran.uwm100.comdat)     =   29                             AND
                   MONTH(sic_bran.uwm100.comdat)     =   02                             AND
                     DAY(sic_bran.uwm100.expdat)     =   01                             AND
                   MONTH(sic_bran.uwm100.expdat)     =   03                             AND
                    YEAR(sic_bran.uwm100.comdat) + 1 =  YEAR(sic_bran.uwm100.expdat) )
                THEN DO:
                  n_dcover = 365.
                END.
                ELSE DO:
                  n_dcover = (sic_bran.uwm100.expdat  - sic_bran.uwm100.comdat ) + 1 .     /*    =  366  วัน */
                END.
    FIND sicsyac.xmm031 USE-INDEX xmm03101 WHERE
         sicsyac.xmm031.poltyp EQ sic_bran.uwm100.poltyp
    NO-LOCK NO-ERROR.
    IF AVAILABLE sicsyac.xmm031 THEN DO:
       IF n_dcover = 365  THEN   
      n_ddyr   = YEAR(TODAY).
      n_ddyr1  = n_ddyr + 1.
      n_dyear  = 365.   
      FIND sicsyac.xmm105 USE-INDEX xmm10501      WHERE
           sicsyac.xmm105.tariff EQ nvtariff      AND
           sicsyac.xmm105.bencod EQ sic_bran.uwd132.bencod
      NO-LOCK NO-ERROR.
      IF  sic_bran.uwm100.short = NO OR sicsyac.xmm105.shorta = NO THEN DO:
          sic_bran.uwd132.prem_c = (n_orgnap * n_dcover) / n_dyear .  
      END.
      ELSE DO:
        FIND FIRST sicsyac.xmm127 USE-INDEX xmm12701     WHERE
                   sicsyac.xmm127.poltyp =  sic_bran.uwm100.poltyp AND
                   sicsyac.xmm127.daymth =  YES                    AND
                   sicsyac.xmm127.nodays GE n_dcover
        NO-LOCK NO-ERROR.
        IF AVAILABLE sicsyac.xmm127 THEN DO:
           sic_bran.uwd132.prem_c =  (n_orgnap * sicsyac.xmm127.short) / 100 .
        END.
        ELSE DO:
          IF YEAR(sic_bran.uwm100.expdat) <> YEAR(sic_bran.uwm100.comdat) THEN DO:
            nvyear = YEAR(sic_bran.uwm100.expdat) - YEAR(sic_bran.uwm100.comdat).
            IF nvyear > 1 THEN
               n_dmonth = (12 - MONTH(sic_bran.uwm100.comdat) +
                                MONTH(sic_bran.uwm100.expdat) + 1) + ((nvyear - 1) * 12).
            ELSE
               n_dmonth =  12 - MONTH(sic_bran.uwm100.comdat) +
                                MONTH(sic_bran.uwm100.expdat) + 1.
          END.
          ELSE n_dmonth = MONTH(sic_bran.uwm100.expdat) - MONTH(sic_bran.uwm100.comdat) + 1.
          FIND FIRST sicsyac.xmm127 USE-INDEX xmm12701      WHERE
                     sicsyac.xmm127.poltyp =  sic_bran.uwm100.poltyp AND
                     sicsyac.xmm127.daymth =  NO            AND
                     sicsyac.xmm127.nodays GE n_dmonth
          NO-LOCK NO-ERROR.
          IF AVAILABLE xmm127 THEN DO:
             sic_bran.uwd132.prem_c = (n_orgnap * sicsyac.xmm127.short) / 100.
             HIDE MESSAGE NO-PAUSE.
             PAUSE.
          END.
          ELSE DO:
             sic_bran.uwd132.prem_c =  (n_orgnap * n_dcover) / n_dyear.
          END.

        END.
      END.
      IF s_curbil = "BHT" THEN  sic_bran.uwd132.prem_c = sic_bran.uwd132.prem_c.
    END.
  END.
END.
RELEASE sicsyac.xmm127 .*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

