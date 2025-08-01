&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
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

  Created: 

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
/* INPUT FROM VALUE (fi_load). */
DEF TEMP-TABLE tperiodmot 
    FIELD tyr          AS INT FORMAT ">>>9"
    FIELD tasdat       AS DATE FORMAT "99/99/9999"
    FIELD tmottrndatfr AS DATE FORMAT "99/99/9999"
    FIELD tmottrndatto AS DATE FORMAT "99/99/9999"
    FIELD tstatus      AS CHAR FORMAT "X(6)"
    FIELD timport      AS CHAR FORMAT "X(6)".

DEF VAR n_yr          AS CHAR .   
DEF VAR n_asdat       AS CHAR .  
DEF VAR n_mottrndatfr AS CHAR .  
DEF VAR n_mottrndatto AS CHAR .
DEF VAR n_status      AS CHAR .
DEF VAR n_import      AS CHAR .


DEF VAR inmot_asdat AS DATE FORMAT "99/99/9999".
DEF VAR inmot_trndat AS DATE FORMAT "99/99/9999".
DEF VAR inmot_trndatto AS DATE FORMAT "99/99/9999".
DEF VAR oumot_sta AS CHAR FORMAT "X(6)".
DEF VAR immot_sta AS CHAR FORMAT "X(6)".

DEF BUFFER bftperiodmot FOR tperiodmot.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME br_motor

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES tperiodmot

/* Definitions for BROWSE br_motor                                      */
&Scoped-define FIELDS-IN-QUERY-br_motor tperiodmot.tyr tperiodmot.tasdat tperiodmot.tmottrndatfr tperiodmot.tmottrndatto tperiodmot.tstatus tperiodmot.timport   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_motor   
&Scoped-define SELF-NAME br_motor
&Scoped-define QUERY-STRING-br_motor FOR EACH tperiodmot NO-LOCK
&Scoped-define OPEN-QUERY-br_motor OPEN QUERY br_motor FOR EACH tperiodmot NO-LOCK.
&Scoped-define TABLES-IN-QUERY-br_motor tperiodmot
&Scoped-define FIRST-TABLE-IN-QUERY-br_motor tperiodmot


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-br_motor}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS bu_ok bu_exit br_motor 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_exit 
     LABEL "Exit" 
     SIZE 20 BY 1.67
     FONT 6.

DEFINE BUTTON bu_ok 
     LABEL "UPR - Motor" 
     SIZE 20 BY 1.67
     FONT 6.

DEFINE VARIABLE fi_asdat AS DATE FORMAT "99/99/9999":U 
      VIEW-AS TEXT 
     SIZE 13.5 BY 1.05
     BGCOLOR 15 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_status AS CHARACTER FORMAT "X(20)":U 
      VIEW-AS TEXT 
     SIZE 19.83 BY 1.05
     BGCOLOR 15 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_trndatfr AS DATE FORMAT "99/99/9999":U 
      VIEW-AS TEXT 
     SIZE 13 BY 1.05
     BGCOLOR 15 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_trndatto AS DATE FORMAT "99/99/9999":U 
      VIEW-AS TEXT 
     SIZE 13 BY 1.05
     BGCOLOR 15 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_yr AS INTEGER FORMAT ">>>9":U INITIAL 0 
      VIEW-AS TEXT 
     SIZE 8.67 BY 1.05
     BGCOLOR 15 FGCOLOR 2  NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_motor FOR 
      tperiodmot SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_motor
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_motor C-Win _FREEFORM
  QUERY br_motor DISPLAY
      tperiodmot.tyr          COLUMN-LABEL "Year"        FORMAT ">>>>>>9"        
tperiodmot.tasdat       COLUMN-LABEL "AsDate"      FORMAT "99/99/9999" 
tperiodmot.tmottrndatfr COLUMN-LABEL "Trndat From" FORMAT "99/99/9999" 
tperiodmot.tmottrndatto COLUMN-LABEL "Trndat To"   FORMAT "99/99/9999" 
tperiodmot.tstatus      COLUMN-LABEL "Status"      FORMAT "X(6)"
tperiodmot.timport      COLUMN-LABEL "Import"      FORMAT "X(6)"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 105 BY 12.38 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     bu_ok AT ROW 3.81 COL 16.33 WIDGET-ID 2
     bu_exit AT ROW 3.81 COL 96.67 WIDGET-ID 6
     br_motor AT ROW 10.57 COL 16 WIDGET-ID 200
     " Import Period File from D:~\temp~\uprexp~\perioduprmot.csv" VIEW-AS TEXT
          SIZE 55.5 BY 1.43 AT ROW 4 COL 36.83 WIDGET-ID 12
          FGCOLOR 4 FONT 6
     "        Process Unearned Premium Report (Only Expiry in that month) - Motor" VIEW-AS TEXT
          SIZE 79.67 BY 1.43 AT ROW 1.62 COL 26.33 WIDGET-ID 10
          BGCOLOR 1 FGCOLOR 7 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 131 BY 23.19 WIDGET-ID 100.

DEFINE FRAME fr_status
     fi_trndatto AT ROW 2.14 COL 62.67 COLON-ALIGNED NO-LABEL WIDGET-ID 8
     fi_yr AT ROW 2.19 COL 2.83 NO-LABEL WIDGET-ID 2
     fi_asdat AT ROW 2.19 COL 10.33 COLON-ALIGNED NO-LABEL WIDGET-ID 4
     fi_trndatfr AT ROW 2.19 COL 48.33 COLON-ALIGNED NO-LABEL WIDGET-ID 6
     fi_status AT ROW 2.19 COL 78.67 COLON-ALIGNED NO-LABEL WIDGET-ID 20
     "Year" VIEW-AS TEXT
          SIZE 7.5 BY .71 AT ROW 1.24 COL 2.83 WIDGET-ID 10
          FONT 6
     "As Date" VIEW-AS TEXT
          SIZE 7.5 BY .71 AT ROW 1.24 COL 14.83 WIDGET-ID 12
          FONT 6
     "From" VIEW-AS TEXT
          SIZE 7.17 BY .71 AT ROW 1.24 COL 52.83 WIDGET-ID 14
          FONT 6
     "To" VIEW-AS TEXT
          SIZE 7.5 BY .71 AT ROW 1.24 COL 70 WIDGET-ID 16
          FONT 6
     "Transaction Date" VIEW-AS TEXT
          SIZE 17.5 BY .71 AT ROW 2.38 COL 31.17 WIDGET-ID 18
          FONT 6
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 16 ROW 5.76
         SIZE 100.5 BY 4.29
         TITLE "Status" WIDGET-ID 300.


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
         TITLE              = "<insert window title>"
         HEIGHT             = 23.95
         WIDTH              = 133.33
         MAX-HEIGHT         = 24.05
         MAX-WIDTH          = 133.33
         VIRTUAL-HEIGHT     = 24.05
         VIRTUAL-WIDTH      = 133.33
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
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* REPARENT FRAME */
ASSIGN FRAME fr_status:FRAME = FRAME DEFAULT-FRAME:HANDLE.

/* SETTINGS FOR FRAME DEFAULT-FRAME
   FRAME-NAME                                                           */
/* BROWSE-TAB br_motor fr_status DEFAULT-FRAME */
/* SETTINGS FOR FRAME fr_status
                                                                        */
/* SETTINGS FOR FILL-IN fi_yr IN FRAME fr_status
   ALIGN-L                                                              */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_motor
/* Query rebuild information for BROWSE br_motor
     _START_FREEFORM
OPEN QUERY br_motor FOR EACH tperiodmot NO-LOCK.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE br_motor */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* <insert window title> */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* <insert window title> */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit C-Win
ON CHOOSE OF bu_exit IN FRAME DEFAULT-FRAME /* Exit */
DO:
  APPLY "CLOSE" TO THIS-PROCEDURE. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok C-Win
ON CHOOSE OF bu_ok IN FRAME DEFAULT-FRAME /* UPR - Motor */
DO:

  FOR EACH tperiodmot.
      DELETE tperiodmot.
  END.

  RUN pd_importmot.
  RUN pd_processmot.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_motor
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

  SESSION:DATA-ENTRY-RETURN = YES. 

  




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
  ENABLE bu_ok bu_exit br_motor 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  DISPLAY fi_trndatto fi_yr fi_asdat fi_trndatfr fi_status 
      WITH FRAME fr_status IN WINDOW C-Win.
  ENABLE fi_trndatto fi_yr fi_asdat fi_trndatfr fi_status 
      WITH FRAME fr_status IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_status}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_importmot C-Win 
PROCEDURE pd_importmot :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

INPUT FROM "D:\temp\uprexp\perioduprmot.csv".
REPEAT:

    IMPORT DELIMITER "," 
        n_yr         
        n_asdat      
        n_mottrndatfr
        n_mottrndatto.

    CREATE tperiodmot.
    ASSIGN tperiodmot.tyr            =  INT(n_yr)            
           tperiodmot.tasdat         =  DATE(n_asdat)        
           tperiodmot.tmottrndatfr   =  DATE(n_mottrndatfr)  
           tperiodmot.tmottrndatto   =  DATE(n_mottrndatto). 

    END.
INPUT CLOSE.

OPEN QUERY br_motor FOR EACH tperiodmot NO-LOCK.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_processmot C-Win 
PROCEDURE pd_processmot :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

FOR EACH tperiodmot NO-LOCK:

    ASSIGN fi_yr            = tperiodmot.tyr          
           fi_asdat         = tperiodmot.tasdat       
           fi_trndatfr      = tperiodmot.tmottrndatfr 
           fi_trndatto      = tperiodmot.tmottrndatto 
           fi_status        = "Processing".

    DISP fi_yr       
         fi_asdat    
         fi_trndatfr 
         fi_trndatto 
         fi_status   WITH FRAME fr_status .

    RUN wac\wacr60exp (INPUT fi_asdat,   
                       INPUT fi_trndatfr,
                       INPUT fi_trndatto,
                       OUTPUT oumot_sta).

    RUN wac\wacr601exp (INPUT fi_asdat,   
                       INPUT fi_trndatfr,
                       INPUT fi_trndatto,
                       OUTPUT immot_sta).

   FIND FIRST bftperiodmot WHERE bftperiodmot.tasdat = tperiodmot.tasdat NO-ERROR.
   IF AVAIL bftperiodmot THEN ASSIGN bftperiodmot.tstatus = oumot_sta
                                     bftperiodmot.timport = immot_sta.

END.

OPEN QUERY br_motor FOR EACH tperiodmot NO-LOCK.

ASSIGN fi_yr            = 0
       fi_asdat         = ?
       fi_trndatfr      = ?
       fi_trndatto      = ?
       fi_status        = "Complete".

DISP fi_yr       
     fi_asdat    
     fi_trndatfr 
     fi_trndatto 
     fi_status   WITH FRAME fr_status .

MESSAGE "Process Complete" VIEW-AS ALERT-BOX.



END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

