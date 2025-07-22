&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          gloracle         PROGRESS
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

/*------- Create  : Nontamas H. [A63-0014] Date 02/02/2020 
          Add/Update/Delete ข้อมูลและแสดงข้อมูลตาม Parameter      -------*/

/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */

CREATE WIDGET-POOL.

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---         */
DEF SHARED VAR n_User   AS CHAR.
DEF SHARED VAR n_Passwd AS CHAR.
DEF VAR        nv_User  AS CHAR NO-UNDO.
DEF VAR        nv_pwd   AS CHAR NO-UNDO.
ASSIGN
    nv_User = n_user
    nv_pwd  = n_passwd.                 

DEF VAR n_poltyp  AS CHAR FORMAT "X(4)".
DEF VAR n_gpprod  AS CHAR FORMAT "X(6)".
DEF VAR n_codeac  AS CHAR FORMAT "X(4)".
DEF VAR n_acctyp  AS CHAR FORMAT "x(50)".   
DEF VAR n_gpoth1  AS CHAR FORMAT "x(10)".   
DEF VAR n_gpoth2  AS CHAR FORMAT "x(10)".   
DEF VAR n_gpoth3  AS CHAR FORMAT "x(10)".
DEF VAR n_type    AS INTE INIT 0.
DEF VAR nv_Row    AS RECID.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME br_cvm008

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES cvm008

/* Definitions for BROWSE br_cvm008                                     */
&Scoped-define FIELDS-IN-QUERY-br_cvm008 cvm008.poltyp cvm008.gpprod cvm008.codeac cvm008.acctyp cvm008.gpoth1 cvm008.gpoth2 cvm008.gpoth3   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_cvm008   
&Scoped-define SELF-NAME br_cvm008
&Scoped-define OPEN-QUERY-br_cvm008 /*--  Manop G, ~
       A58-0340   07/09/2015 ---*/ OPEN QUERY br_cvm008    FOR EACH  cvm008  NO-LOCK             BY cvm008.poltyp INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br_cvm008 cvm008
&Scoped-define FIRST-TABLE-IN-QUERY-br_cvm008 cvm008


/* Definitions for FRAME frShow                                         */
&Scoped-define OPEN-BROWSERS-IN-QUERY-frShow ~
    ~{&OPEN-QUERY-br_cvm008}

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_go 
     LABEL "GO" 
     SIZE 12.83 BY 1.19
     FONT 6.

DEFINE VARIABLE fi_searchpol AS CHARACTER FORMAT "X(10)":U 
     LABEL "Fill 1" 
     VIEW-AS FILL-IN 
     SIZE 19.5 BY 1.05
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE rsType AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Add", 1,
"Update", 2,
"Delete", 3
     SIZE 14.5 BY 3.71
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-318
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 97.5 BY 5.05
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-320
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 16.5 BY 4.29.

DEFINE RECTANGLE RECT-322
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 45.33 BY 1.43
     BGCOLOR 19 .

DEFINE BUTTON bu_cancel 
     LABEL "Cancel" 
     SIZE 10 BY 1.43
     FONT 6.

DEFINE BUTTON bu_exit 
     LABEL "Exit" 
     SIZE 13 BY 2
     FONT 6.

DEFINE BUTTON bu_OK 
     LABEL "OK" 
     SIZE 10 BY 1.43
     FONT 6.

DEFINE VARIABLE fi_acctyp AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 30 BY .81
     BGCOLOR 15 FGCOLOR 12 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_codeac AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .81
     BGCOLOR 15 FGCOLOR 12 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_gpoth1 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 30 BY .81
     BGCOLOR 15 FGCOLOR 12 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_gpoth2 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 30 BY .81
     BGCOLOR 15 FGCOLOR 6 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_gpoth3 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 30 BY .81
     BGCOLOR 15 FGCOLOR 12 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_gpprod AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .81
     BGCOLOR 15 FGCOLOR 6 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_poltyp AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .81
     BGCOLOR 15 FGCOLOR 6 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-319
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 52 BY 14.52
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-323
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 48 BY 14.52
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-324
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 52 BY 14.52
     BGCOLOR 1 .

DEFINE VARIABLE to_showall AS LOGICAL INITIAL no 
     LABEL "Show All" 
     VIEW-AS TOGGLE-BOX
     SIZE 11 BY .81 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_cvm008 FOR 
      cvm008 SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_cvm008
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_cvm008 C-Win _FREEFORM
  QUERY br_cvm008 NO-LOCK DISPLAY
      cvm008.poltyp  COLUMN-LABEL "PolType"       FORMAT "x(4)":U WIDTH 6
cvm008.gpprod  COLUMN-LABEL "Group Product" FORMAT "x(6)":U
cvm008.codeac  COLUMN-LABEL "Code Account"  FORMAT "x(4)":U
cvm008.acctyp  COLUMN-LABEL "Account Type"  FORMAT "x(50)":U WIDTH 6
cvm008.gpoth1  COLUMN-LABEL "Group Other1"  FORMAT "x(10)":U
cvm008.gpoth2  COLUMN-LABEL "Group Other2"  FORMAT "x(10)":U
cvm008.gpoth3  COLUMN-LABEL "Group Other3"  FORMAT "x(10)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ASSIGN NO-ROW-MARKERS SEPARATORS SIZE 45 BY 12.14
         BGCOLOR 15  ROW-HEIGHT-CHARS .57 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133.33 BY 24.05
         BGCOLOR 10 .

DEFINE FRAME frShow
     to_showall AT ROW 1.95 COL 92.5 WIDGET-ID 22
     fi_poltyp AT ROW 4.1 COL 21.17 COLON-ALIGNED NO-LABEL
     fi_codeac AT ROW 5.29 COL 21.17 COLON-ALIGNED NO-LABEL
     fi_gpprod AT ROW 6.48 COL 21.17 COLON-ALIGNED NO-LABEL WIDGET-ID 4
     fi_acctyp AT ROW 7.67 COL 21.17 COLON-ALIGNED NO-LABEL WIDGET-ID 2
     fi_gpoth1 AT ROW 8.86 COL 21.17 COLON-ALIGNED NO-LABEL WIDGET-ID 10
     fi_gpoth2 AT ROW 10.05 COL 21.17 COLON-ALIGNED NO-LABEL WIDGET-ID 14
     fi_gpoth3 AT ROW 11.24 COL 21.17 COLON-ALIGNED NO-LABEL WIDGET-ID 12
     br_cvm008 AT ROW 3.14 COL 58.5
     bu_OK AT ROW 12.91 COL 9.17
     bu_cancel AT ROW 12.91 COL 20
     bu_exit AT ROW 12.91 COL 40
     "Account Type" VIEW-AS TEXT
          SIZE 13 BY .76 AT ROW 7.67 COL 9.17 WIDGET-ID 6
          BGCOLOR 8 FGCOLOR 1 
     "Group Account" VIEW-AS TEXT
          SIZE 13 BY .81 AT ROW 6.48 COL 9.17 WIDGET-ID 8
          BGCOLOR 8 FGCOLOR 1 
     "Group Other1" VIEW-AS TEXT
          SIZE 13 BY .76 AT ROW 8.86 COL 9.17 WIDGET-ID 16
          BGCOLOR 8 FGCOLOR 1 
     "Group Other3" VIEW-AS TEXT
          SIZE 13 BY .76 AT ROW 11.24 COL 9.17 WIDGET-ID 18
          BGCOLOR 8 FGCOLOR 1 
     "Group Other2" VIEW-AS TEXT
          SIZE 13 BY .81 AT ROW 10.05 COL 9.17 WIDGET-ID 20
          BGCOLOR 8 FGCOLOR 1 
     "Code Account" VIEW-AS TEXT
          SIZE 13 BY .76 AT ROW 5.29 COL 9.17
          BGCOLOR 8 FGCOLOR 1 
     "Policy type" VIEW-AS TEXT
          SIZE 13 BY .81 AT ROW 4.1 COL 9.17
          BGCOLOR 8 FGCOLOR 1 
     " UPDATE/ADD/DELETE" VIEW-AS TEXT
          SIZE 28.83 BY .71 AT ROW 2.29 COL 9.17
          BGCOLOR 3 FGCOLOR 7 FONT 6
     RECT-319 AT ROW 1.48 COL 4.5
     RECT-323 AT ROW 1.48 COL 57
     RECT-324 AT ROW 1.48 COL 4.5
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         NO-LABELS SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 14 ROW 8.62
         SIZE 106.5 BY 15.71
         BGCOLOR 19 .

DEFINE FRAME frmain
     rsType AT ROW 3 COL 8.5 NO-LABEL
     fi_searchpol AT ROW 4.76 COL 51.17
     bu_go AT ROW 4.76 COL 83.33
     " Policy Type :" VIEW-AS TEXT
          SIZE 15.67 BY .86 AT ROW 4.86 COL 31.67
          BGCOLOR 1 FGCOLOR 15 FONT 6
     " SET GROUP PRODUCT" VIEW-AS TEXT
          SIZE 105.33 BY .95 AT ROW 1.24 COL 1
          BGCOLOR 1 FGCOLOR 15 FONT 6
     RECT-318 AT ROW 2.38 COL 5.33
     RECT-320 AT ROW 2.67 COL 7.5
     RECT-322 AT ROW 4.57 COL 29.5
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         NO-LABELS SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 14.33 ROW 1.48
         SIZE 105.67 BY 6.91.


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
         TITLE              = "Set Group Product : WAcvm008.W"
         HEIGHT             = 24.05
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
ASSIGN FRAME frmain:FRAME = FRAME DEFAULT-FRAME:HANDLE
       FRAME frShow:FRAME = FRAME DEFAULT-FRAME:HANDLE.

/* SETTINGS FOR FRAME DEFAULT-FRAME
   FRAME-NAME                                                           */

DEFINE VARIABLE XXTABVALXX AS LOGICAL NO-UNDO.

ASSIGN XXTABVALXX = FRAME frmain:MOVE-BEFORE-TAB-ITEM (FRAME frShow:HANDLE)
/* END-ASSIGN-TABS */.

/* SETTINGS FOR FRAME frmain
   Custom                                                               */
/* SETTINGS FOR BUTTON bu_go IN FRAME frmain
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_searchpol IN FRAME frmain
   NO-ENABLE ALIGN-L LABEL "Fill 1:"                                    */
/* SETTINGS FOR FRAME frShow
   Custom                                                               */
/* BROWSE-TAB br_cvm008 fi_gpoth3 frShow */
ASSIGN 
       br_cvm008:SEPARATOR-FGCOLOR IN FRAME frShow      = 3.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_cvm008
/* Query rebuild information for BROWSE br_cvm008
     _START_FREEFORM
/*--  Manop G, A58-0340   07/09/2015 ---*/
OPEN QUERY br_cvm008
   FOR EACH  cvm008  NO-LOCK
            BY cvm008.poltyp INDEXED-REPOSITION.
     _END_FREEFORM
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _OrdList          = "sic_test.cvm008.branch|yes,sic_test.cvm008.class|yes,sic_test.cvm008.tariff|yes"
     _Query            is OPENED
*/  /* BROWSE br_cvm008 */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Set Group Product : WAcvm008.W */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Set Group Product : WAcvm008.W */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_cvm008
&Scoped-define FRAME-NAME frShow
&Scoped-define SELF-NAME br_cvm008
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_cvm008 C-Win
ON MOUSE-SELECT-CLICK OF br_cvm008 IN FRAME frShow
DO:
    

nv_row  =  RECID(cvm008).
  FIND FIRST cvm008 WHERE RECID(cvm008) =  nv_row NO-LOCK NO-ERROR.
  IF AVAIL cvm008 THEN DO:
      RUN PdDisplay.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_cancel C-Win
ON CHOOSE OF bu_cancel IN FRAME frShow /* Cancel */
DO:

  RUN PdClear.

  RUN pdUpdateQ.

  rsType = 1.
  DISP rsType WITH FRAME frmain.


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit C-Win
ON CHOOSE OF bu_exit IN FRAME frShow /* Exit */
DO:
  APPLY "CLOSE" TO THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frmain
&Scoped-define SELF-NAME bu_go
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_go C-Win
ON CHOOSE OF bu_go IN FRAME frmain /* GO */
DO:
  DO WITH FRAME frmain:
        IF NOT CAN-FIND(FIRST cvm008 WHERE (cvm008.poltyp = n_poltyp)) THEN DO:
            MESSAGE "Not found policy type " + n_poltyp + " in cvm008" VIEW-AS ALERT-BOX.
            RUN PdClear.
            APPLY "Entry" TO fi_searchpol IN FRAME frmain.
        END.

        ELSE DO:
            OPEN QUERY br_cvm008 FOR EACH cvm008 WHERE cvm008.poltyp = n_poltyp NO-LOCK.
            RUN PdDisplay.
            TO_showall = NO.
            DISP TO_showall WITH FRAME frshow.
            APPLY "Entry" TO fi_poltyp IN FRAME frShow.

            
        END.
  END. 

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frShow
&Scoped-define SELF-NAME bu_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_OK C-Win
ON CHOOSE OF bu_OK IN FRAME frShow /* OK */
DO:
  ASSIGN n_poltyp = CAPS (INPUT fi_poltyp)
         n_gpprod = INPUT fi_gpprod
         n_codeac = INPUT fi_codeac
         n_acctyp = INPUT fi_acctyp
         n_gpoth1 = INPUT fi_gpoth1
         n_gpoth2 = INPUT fi_gpoth2
         n_gpoth3 = INPUT fi_gpoth3.

  IF n_poltyp <> "" THEN DO:

      IF n_type = 3 THEN DO:    /*---delete---*/
         RUN pdDelete.    
      END.
      ELSE DO: 
          FIND FIRST cvm008 USE-INDEX cvm00801 WHERE
              cvm008.poltyp = n_poltyp  NO-ERROR.
          IF NOT AVAIL cvm008 THEN DO:  /*---Add---*/
            IF n_type = 1 THEN DO:
                CREATE cvm008.
                    ASSIGN cvm008.poltyp = n_poltyp
                           cvm008.gpprod = n_gpprod
                           cvm008.codeac = n_codeac
                           cvm008.acctyp = n_acctyp
                           cvm008.gpoth1 = n_gpoth1
                           cvm008.gpoth2 = n_gpoth2
                           cvm008.gpoth3 = n_gpoth3.
                MESSAGE "Create Policy Type complete..." VIEW-AS ALERT-BOX INFORMATION.
                OPEN QUERY br_cvm008 FOR EACH cvm008 NO-LOCK BY INTE(cvm008.poltyp) DESC.
            END.
            ELSE MESSAGE "Not Found Policy Type" + " " + n_poltyp VIEW-AS ALERT-BOX.
          END.
          ELSE DO:   /*---Update ---*/
              IF n_type = 2 THEN DO:
                ASSIGN cvm008.poltyp = n_poltyp
                       cvm008.gpprod = n_gpprod
                       cvm008.codeac = n_codeac
                       cvm008.acctyp = n_acctyp
                       cvm008.gpoth1 = n_gpoth1
                       cvm008.gpoth2 = n_gpoth2
                       cvm008.gpoth3 = n_gpoth3.
                 MESSAGE "Update Policy Type complete..." VIEW-AS ALERT-BOX INFORMATION.
                 OPEN QUERY br_cvm008 FOR EACH cvm008 NO-LOCK BY INTE(cvm008.poltyp) DESC.
              END.
              ELSE MESSAGE "Dupplicate Policy Type" + " " + n_poltyp VIEW-AS ALERT-BOX.
          END.
      END.
  END.
          
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frmain
&Scoped-define SELF-NAME fi_searchpol
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_searchpol C-Win
ON LEAVE OF fi_searchpol IN FRAME frmain /* Fill 1 */
DO:
  n_poltyp = INPUT fi_searchpol.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rsType
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rsType C-Win
ON VALUE-CHANGED OF rsType IN FRAME frmain
DO:
   IF INPUT rsType = 1 THEN DO:        /*----Add----*/
       ASSIGN
           n_type = 1.
       DISABLE fi_searchpol bu_go WITH FRAME frmain.
       DISABLE br_cvm008 WITH FRAME frshow.
       APPLY "Entry" TO fi_poltyp IN FRAME frShow.
   END.
   ELSE IF INPUT rsType = 2 THEN DO:    /*----Update----*/
      n_type = 2.
      ENABLE fi_searchpol bu_go WITH FRAME frmain.
      ENABLE br_cvm008 WITH FRAME frshow.
      APPLY "Entry" TO fi_searchpol IN FRAME frmain.
   END.
   ELSE DO:   /*----Delete----*/
      n_type = 3.                    
      ENABLE fi_searchpol bu_go WITH FRAME frmain.
      ENABLE br_cvm008 WITH FRAME frshow.
      APPLY "Entry" TO fi_searchpol IN FRAME frmain.
   END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frShow
&Scoped-define SELF-NAME to_showall
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL to_showall C-Win
ON MOUSE-SELECT-CLICK OF to_showall IN FRAME frShow /* Show All */
DO:
    IF TO_showall = YES THEN TO_showall = NO.
    ELSE TO_showall = YES.
    IF TO_showall = YES THEN DO:
        OPEN QUERY br_cvm008 FOR EACH cvm008 NO-LOCK.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME DEFAULT-FRAME
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
  DEF  VAR  gv_prgid   AS   CHAR.
  DEF  VAR  gv_prog    AS   CHAR.

  Rect-319:move-to-top( ).
  
  gv_prgid = "Wacvm008".
  gv_prog  = "Set Group Product".
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).
/*********************************************************************/  
/*   RUN Wut\WutdiCen (C-Win:HANDLE).  */

  SESSION:DATA-ENTRY-RETURN = YES.
  SESSION:DATE-FORMAT = "dmy". 

  RUN pdUpdateQ.
  n_type = INPUT rsType.
  IF n_type = 1 THEN DISABLE br_cvm008 WITH FRAME frshow.
  ELSE ENABLE br_cvm008 WITH FRAME frshow.
  APPLY "Entry" TO fi_poltyp IN FRAME frShow.


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
  VIEW FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  DISPLAY rsType fi_searchpol 
      WITH FRAME frmain IN WINDOW C-Win.
  ENABLE rsType RECT-318 RECT-320 RECT-322 
      WITH FRAME frmain IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frmain}
  DISPLAY to_showall fi_poltyp fi_codeac fi_gpprod fi_acctyp fi_gpoth1 fi_gpoth2 
          fi_gpoth3 
      WITH FRAME frShow IN WINDOW C-Win.
  ENABLE to_showall fi_poltyp fi_codeac fi_gpprod fi_acctyp fi_gpoth1 fi_gpoth2 
         fi_gpoth3 br_cvm008 bu_OK bu_cancel bu_exit RECT-319 RECT-323 RECT-324 
      WITH FRAME frShow IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frShow}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDClear C-Win 
PROCEDURE PDClear :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN 
    n_poltyp = ""
    n_gpprod = ""   
    n_codeac = ""   
    n_acctyp = ""   
    n_gpoth1 = ""   
    n_gpoth2 = ""   
    n_gpoth3 = "".
DISP fi_poltyp
     fi_gpprod
     fi_codeac
     fi_acctyp
     fi_gpoth1
     fi_gpoth2
     fi_gpoth3 WITH FRAME frShow.
DISP fi_searchpol WITH FRAME frmain.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdDelete C-Win 
PROCEDURE pdDelete :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    FIND FIRST cvm008 WHERE cvm008.poltyp  = n_poltyp  NO-ERROR.
    IF NOT AVAIL cvm008 THEN DO:
        MESSAGE "Not found Policy Type " + n_poltyp + ", Code Account " + n_codeac VIEW-AS ALERT-BOX.
        APPLY "Entry" TO fi_poltyp IN FRAME frShow.
    END.
    ELSE DO:
       MESSAGE "Are You Sure?" VIEW-AS ALERT-BOX 
       QUESTION BUTTONS YES-NO TITLE "ยืนยันการยกเลิก" 
       UPDATE n_logAns AS LOGICAL.
       CASE n_logAns:
           WHEN TRUE THEN  DO:    /* Yes */
               FIND cvm008  WHERE cvm008.poltyp  = n_poltyp  AND
                                  cvm008.codeac  = n_codeac  NO-ERROR NO-WAIT.
               IF AVAIL cvm008 THEN DELETE cvm008.
                   OPEN QUERY br_cvm008 FOR EACH cvm008 NO-LOCK
                       BY INTE(cvm008.poltyp) DESC.
                   RUN PdClear.
               END.
           WHEN FALSE THEN  DO: 
               RUN PdClear.
           END.
       END CASE. 
       APPLY "Entry" TO fi_poltyp IN FRAME frShow.
    END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PdDisplay C-Win 
PROCEDURE PdDisplay :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
    fi_poltyp = cvm008.poltyp
    fi_gpprod = cvm008.gpprod
    fi_codeac = cvm008.codeac
    fi_acctyp = cvm008.acctyp
    fi_gpoth1 = cvm008.gpoth1
    fi_gpoth2 = cvm008.gpoth2
    fi_gpoth3 = cvm008.gpoth3.
DISP 
    fi_poltyp
    fi_gpprod
    fi_codeac
    fi_acctyp
    fi_gpoth1
    fi_gpoth2
    fi_gpoth3 WITH FRAME frshow.
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
OPEN QUERY br_cvm008 FOR EACH cvm008 NO-LOCK BY INTE(cvm008.poltyp) DESC.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

