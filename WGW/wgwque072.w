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
/*  wgwque072.w - Set class to D\R                                      */
/* Copyright    : Tokio Marine Safety Insurance (Thailand) PCL.          */
/*                        บริษัท คุ้มภัยโตเกียวมารีนประกันภัย (ประเทศไทย)*/
/* CREATE BY    : Chaiyong W.   ASSIGN A65-0329  DATE 09/11/2022         */  
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
DEF TEMP-TABLE tsym
    FIELD itrecid   AS RECID    INIT ?
    FIELD itmcod    AS CHAR     INIT ""
    FIELD itmdes    AS CHAR     INIT "".
DEF BUFFER bsym100 FOR sym100.
DEF VAR nv_st AS CHAR INIT "".
DEF INPUT PARAMETER nv_tabcod   AS CHAR INIT "".
DEF INPUT PARAMETER s_prog      AS CHAR INIT "".
DEF INPUT PARAMETER gv_prog     AS CHAR INIT "".
DEF VAR   n_status              AS CHAR INIT "".
DEF VAR   nv_click              AS RECID INIT ?.
DEF VAR   nv_getrec             AS RECID INIT ?.
DEF VAR   nv_err                AS CHAR INIT "".
/*DEF VAR nv_tabcod AS CHAR INIT "U086". */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME br_q

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES tsym

/* Definitions for BROWSE br_q                                          */
&Scoped-define FIELDS-IN-QUERY-br_q tsym.itmcod tsym.itmdes   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_q   
&Scoped-define SELF-NAME br_q
&Scoped-define QUERY-STRING-br_q FOR EACH tsym NO-LOCK
&Scoped-define OPEN-QUERY-br_q OPEN QUERY br_q FOR EACH tsym NO-LOCK.
&Scoped-define TABLES-IN-QUERY-br_q tsym
&Scoped-define FIRST-TABLE-IN-QUERY-br_q tsym


/* Definitions for FRAME fr_q                                           */
&Scoped-define OPEN-BROWSERS-IN-QUERY-fr_q ~
    ~{&OPEN-QUERY-br_q}

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_add 
     LABEL "Add" 
     SIZE 14.17 BY 1.52.

DEFINE BUTTON bu_delete 
     LABEL "Delete" 
     SIZE 14.17 BY 1.52.

DEFINE BUTTON bu_exit AUTO-END-KEY 
     LABEL "Exit" 
     SIZE 15 BY 1.52.

DEFINE BUTTON bu_update 
     LABEL "Update" 
     SIZE 14.17 BY 1.52.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 77.67 BY 1.91
     BGCOLOR 32 .

DEFINE VARIABLE fi_head AS CHARACTER FORMAT "X(80)":U 
     VIEW-AS FILL-IN 
     SIZE 60.5 BY 1.19
     BGCOLOR 32 FONT 27 NO-UNDO.

DEFINE RECTANGLE RECT-01
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 78.17 BY 2.52
     BGCOLOR 32 .

DEFINE BUTTON bu_cancel 
     LABEL "Cancel" 
     SIZE 15 BY 1.14.

DEFINE BUTTON bu_ok 
     LABEL "OK" 
     SIZE 15 BY 1.14.

DEFINE VARIABLE fi_code AS CHARACTER FORMAT "X(250)":U 
     VIEW-AS FILL-IN 
     SIZE 22.5 BY 1
     BGCOLOR 15 FONT 32 NO-UNDO.

DEFINE VARIABLE fi_desc AS CHARACTER FORMAT "X(250)":U 
     VIEW-AS FILL-IN 
     SIZE 44.5 BY 1
     BGCOLOR 15 FONT 32 NO-UNDO.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 78.17 BY 3
     BGCOLOR 32 .

DEFINE VARIABLE fi_search AS CHARACTER FORMAT "X(80)":U 
     VIEW-AS FILL-IN 
     SIZE 35.5 BY 1
     BGCOLOR 15 FONT 32 NO-UNDO.

DEFINE VARIABLE ra_s AS INTEGER INITIAL 1 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Code", 1,
"Desc", 2
     SIZE 10.5 BY 1.33
     BGCOLOR 32  NO-UNDO.

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 78.17 BY 12.71
     BGCOLOR 32 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_q FOR 
      tsym SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_q
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_q C-Win _FREEFORM
  QUERY br_q DISPLAY
      tsym.itmcod   format "X(20)"       column-label "Code"
      tsym.itmdes   format "X(50)"       column-label "Description"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 76.5 BY 10.71 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 79.33 BY 21.67
         BGCOLOR 3  WIDGET-ID 100.

DEFINE FRAME fr_add
     bu_add AT ROW 1.24 COL 19.33 WIDGET-ID 24
     bu_update AT ROW 1.24 COL 33.83 WIDGET-ID 4
     bu_delete AT ROW 1.24 COL 48.33 WIDGET-ID 22
     bu_exit AT ROW 1.24 COL 62.83 WIDGET-ID 10
     RECT-2 AT ROW 1 COL 1 WIDGET-ID 66
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.67 ROW 20.48
         SIZE 78 BY 2 WIDGET-ID 600.

DEFINE FRAME fr_head
     fi_head AT ROW 1.24 COL 1.5 NO-LABEL WIDGET-ID 6
     RECT-01 AT ROW 1 COL 1 WIDGET-ID 66
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.5 ROW 1.24
         SIZE 78.5 BY 2.62 WIDGET-ID 200.

DEFINE FRAME fr_q
     br_q AT ROW 1.24 COL 2 WIDGET-ID 500
     ra_s AT ROW 12.14 COL 15 NO-LABEL WIDGET-ID 2
     fi_search AT ROW 12.33 COL 24 COLON-ALIGNED NO-LABEL WIDGET-ID 6
     RECT-4 AT ROW 1 COL 1 WIDGET-ID 112
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.5 ROW 4.05
         SIZE 78.5 BY 12.91 WIDGET-ID 300.

DEFINE FRAME fr_input
     fi_code AT ROW 1.24 COL 10.5 COLON-ALIGNED NO-LABEL WIDGET-ID 6
     fi_desc AT ROW 2.48 COL 10.5 COLON-ALIGNED NO-LABEL WIDGET-ID 8
     bu_ok AT ROW 1.38 COL 62.67 WIDGET-ID 114
     bu_cancel AT ROW 2.62 COL 62.67 WIDGET-ID 116
     "Code" VIEW-AS TEXT
          SIZE 8 BY 1 AT ROW 1.24 COL 3 WIDGET-ID 18
          BGCOLOR 32 FONT 32
     "Desc." VIEW-AS TEXT
          SIZE 8 BY 1 AT ROW 2.48 COL 3 WIDGET-ID 20
          BGCOLOR 32 FONT 32
     RECT-3 AT ROW 1 COL 1 WIDGET-ID 112
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.5 ROW 17.14
         SIZE 78.5 BY 3.14 WIDGET-ID 400.


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
         HEIGHT             = 21.67
         WIDTH              = 79.33
         MAX-HEIGHT         = 25.81
         MAX-WIDTH          = 80
         VIRTUAL-HEIGHT     = 25.81
         VIRTUAL-WIDTH      = 80
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
IF NOT C-Win:LOAD-ICON("WIMAGE/safety.ico":U) THEN
    MESSAGE "Unable to load icon: WIMAGE/safety.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* REPARENT FRAME */
ASSIGN FRAME fr_add:FRAME = FRAME DEFAULT-FRAME:HANDLE
       FRAME fr_head:FRAME = FRAME DEFAULT-FRAME:HANDLE
       FRAME fr_input:FRAME = FRAME DEFAULT-FRAME:HANDLE
       FRAME fr_q:FRAME = FRAME DEFAULT-FRAME:HANDLE.

/* SETTINGS FOR FRAME DEFAULT-FRAME
   FRAME-NAME                                                           */

DEFINE VARIABLE XXTABVALXX AS LOGICAL NO-UNDO.

ASSIGN XXTABVALXX = FRAME fr_input:MOVE-BEFORE-TAB-ITEM (FRAME fr_add:HANDLE)
       XXTABVALXX = FRAME fr_q:MOVE-BEFORE-TAB-ITEM (FRAME fr_input:HANDLE)
       XXTABVALXX = FRAME fr_head:MOVE-BEFORE-TAB-ITEM (FRAME fr_q:HANDLE)
/* END-ASSIGN-TABS */.

/* SETTINGS FOR FRAME fr_add
                                                                        */
/* SETTINGS FOR FRAME fr_head
                                                                        */
/* SETTINGS FOR FILL-IN fi_head IN FRAME fr_head
   NO-ENABLE ALIGN-L                                                    */
/* SETTINGS FOR FRAME fr_input
   Custom                                                               */
/* SETTINGS FOR FRAME fr_q
                                                                        */
/* BROWSE-TAB br_q RECT-4 fr_q */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_q
/* Query rebuild information for BROWSE br_q
     _START_FREEFORM
OPEN QUERY br_q FOR EACH tsym NO-LOCK.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE br_q */
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


&Scoped-define BROWSE-NAME br_q
&Scoped-define FRAME-NAME fr_q
&Scoped-define SELF-NAME br_q
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_q C-Win
ON MOUSE-SELECT-CLICK OF br_q IN FRAME fr_q
DO:
  nv_click = tsym.itrecid.
  nv_getrec = tsym.itrecid.
  RUN pd_q.
  RUN pd_dis.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_q C-Win
ON VALUE-CHANGED OF br_q IN FRAME fr_q
DO:
    RUN pd_dis.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_add
&Scoped-define SELF-NAME bu_add
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_add C-Win
ON CHOOSE OF bu_add IN FRAME fr_add /* Add */
DO:
    n_status = "ADD".
    DISABLE ALL  WITH FRAME fr_q.
    DISABLE ALL  WITH FRAME fr_add.
    ENABLE  ALL  WITH FRAME fr_input.
    ASSIGN
        fi_code =  ""
        fi_desc =  "".
    DISP fi_code fi_desc WITH FRAME fr_input.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_input
&Scoped-define SELF-NAME bu_cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_cancel C-Win
ON CHOOSE OF bu_cancel IN FRAME fr_input /* Cancel */
DO:
   DISABLE ALL  WITH FRAME fr_input.
   ENABLE ALL  WITH FRAME fr_add.
   ENABLE  ALL  WITH FRAME fr_q.
   ASSIGN
        fi_code =  ""
        fi_desc =  "".
    DISP fi_code fi_desc WITH FRAME fr_input.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_add
&Scoped-define SELF-NAME bu_delete
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_delete C-Win
ON CHOOSE OF bu_delete IN FRAME fr_add /* Delete */
DO:
    ASSIGN
        fi_code = INPUT FRAME fr_input fi_code
        fi_desc = INPUT FRAME fr_input fi_desc.
    IF fi_code = "" THEN DO:
        MESSAGE "Code is Mandatory" VIEW-AS ALERT-BOX INFORMATION.
        APPLY "entry"  TO fi_code.
        RETURN NO-APPLY.
    END.
    MESSAGE "Confrim Delete Parameter ?" VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO-CANCEL    
            TITLE "Delete Parameter" UPDATE lChoice AS LOGICAL.  
    CASE lChoice:    
            WHEN TRUE THEN DO:
                 FIND FIRST sym100 USE-INDEX sym10001 WHERE sym100.tabcod = nv_tabcod AND
                                                            sym100.itmcod = fi_code   EXCLUSIVE-LOCK NO-ERROR NO-WAIT.
                 IF NOT AVAIL sym100 THEN DO:
                     IF LOCKED(sym100) THEN DO:
                         MESSAGE "Record is Locked" VIEW-AS ALERT-BOX INFORMATION.
                         APPLY "entry"  TO fi_code.
                         RETURN NO-APPLY.
                     END.
                     ELSE DO:
                         MESSAGE "Not found data to delete" VIEW-AS ALERT-BOX INFORMATION.
                         RUN pd_q.
                         APPLY "entry"  TO fi_code.
                         RETURN NO-APPLY.
                     END.
                 END.
                 ELSE DO:
                     DELETE sym100.
                     RELEASE sym100 NO-ERROR.
                     MESSAGE "Delete Complete" VIEW-AS ALERT-BOX INFORMATION.
                     RUN pd_q.
                 END.
            END.  
            WHEN FALSE THEN DO:    
            END.
    END CASE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit C-Win
ON CHOOSE OF bu_exit IN FRAME fr_add /* Exit */
DO:
    APPLY "CLOSE":U TO THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_input
&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok C-Win
ON CHOOSE OF bu_ok IN FRAME fr_input /* OK */
DO:
    ASSIGN
        fi_code = INPUT fi_code
        fi_desc = INPUT fi_desc.
    IF fi_code = "" THEN DO:
        MESSAGE "Code is Mandatory" VIEW-AS ALERT-BOX INFORMATION.
        APPLY "entry"  TO fi_code.
        RETURN NO-APPLY.
    END.
  
  IF n_status =  "ADD" THEN DO:
      MESSAGE "Add Parameter Confirm ?" VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO-CANCEL    
          TITLE "Add Parameter" UPDATE lADD AS LOGICAL.  
      CASE lADD:    
              WHEN TRUE THEN DO: 
                  FIND FIRST sym100 USE-INDEX sym10001 WHERE sym100.tabcod = nv_tabcod AND
                                                             sym100.itmcod = fi_code   EXCLUSIVE-LOCK NO-ERROR NO-WAIT.
                  IF NOT AVAIL sym100 THEN DO:
                      IF LOCKED(sym100) THEN DO:
                          MESSAGE "Record is Locked" VIEW-AS ALERT-BOX INFORMATION.
                          APPLY "entry"  TO fi_code.
                          RETURN NO-APPLY.
                      END.
                      ELSE DO:
                          CREATE sym100.
                          ASSIGN
                              sym100.tabcod = nv_tabcod
                              sym100.itmcod = fi_code  
                              sym100.itmdes = fi_desc.
                          RELEASE sym100 NO-ERROR.
                          MESSAGE "Create Complete" VIEW-AS ALERT-BOX INFORMATION.
                          RUN pd_q.
                      END.
                  END.
                  ELSE DO:
                      MESSAGE "Code Dupilcate" VIEW-AS ALERT-BOX INFORMATION.
                      RELEASE sym100 NO-ERROR.
                      LEAVE.
                  END.
              END.  
              WHEN FALSE THEN DO:    
              END.
      END CASE.
   END.
   ELSE IF n_status = "UPDATE" THEN DO:
       MESSAGE "Update Parameter Confirm ?" VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO-CANCEL    
           TITLE "Update Parameter" UPDATE lUpdate AS LOGICAL.  
       CASE lUpdate:    
               WHEN TRUE THEN DO: 
                  nv_err = "".
                  FIND FIRST sym100 USE-INDEX sym10001 WHERE RECID(sym100) = nv_getrec EXCLUSIVE-LOCK NO-ERROR NO-WAIT.
                  IF AVAIL sym100 THEN DO:
                      FIND FIRST bsym100 USE-INDEX sym10001 WHERE bsym100.tabcod = nv_tabcod AND
                                                                  bsym100.itmcod = fi_code   EXCLUSIVE-LOCK NO-ERROR NO-WAIT.
                        IF AVAIL bsym100 AND RECID(bsym100) <> RECID(sym100) THEN DO:
                            MESSAGE "Code Duplicate" VIEW-AS ALERT-BOX INFORMATION.
                            RELEASE sym100 NO-ERROR.
                            LEAVE.
                        END.
                        ELSE DO:
                           IF nv_err = "" THEN  DO:
                             ASSIGN
                                 sym100.itmcod = fi_code
                                 sym100.itmdes = fi_desc.
                             RELEASE sym100 NO-ERROR.
                             MESSAGE "Update Complete" VIEW-AS ALERT-BOX INFORMATION.
                             RUN pd_q.
                           END.
                           ELSE DO:
                               MESSAGE nv_err VIEW-AS ALERT-BOX.
                               LEAVE.
                           END.
                        END.
                  END.
                  ELSE DO:
                      MESSAGE "Code is Mandatory" VIEW-AS ALERT-BOX INFORMATION.
                      RELEASE sym100 NO-ERROR.
                      LEAVE.
                  END.
               END.
               WHEN FALSE THEN DO:    
               END.
       END CASE.
   END.
   DISABLE ALL  WITH FRAME fr_input.
   ENABLE ALL  WITH FRAME fr_add.
   ENABLE  ALL  WITH FRAME fr_q.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_add
&Scoped-define SELF-NAME bu_update
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_update C-Win
ON CHOOSE OF bu_update IN FRAME fr_add /* Update */
DO:
   IF nv_getrec <> ? THEN DO:
       IF nv_getrec = tsym.itrecid THEN DO:
           n_status = "UPDATE".
           DISABLE ALL  WITH FRAME fr_q.
           DISABLE ALL  WITH FRAME fr_add.
           ENABLE  ALL  WITH FRAME fr_input.
       END.
       ELSE DO:
           MESSAGE "Code Don't Macth Please Refresh !!" VIEW-AS ALERT-BOX.
           LEAVE.
       END.
   END.
   ELSE DO:
        MESSAGE "Code is Mandatory !!" VIEW-AS ALERT-BOX.
        LEAVE.
   END.
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_input
&Scoped-define SELF-NAME fi_code
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_code C-Win
ON LEAVE OF fi_code IN FRAME fr_input
DO:
    fi_code = INPUT fi_code.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_desc
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_desc C-Win
ON LEAVE OF fi_desc IN FRAME fr_input
DO:
    fi_desc = INPUT fi_desc.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_q
&Scoped-define SELF-NAME fi_search
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_search C-Win
ON RETURN OF fi_search IN FRAME fr_q
DO:
    fi_search = INPUT fi_search.
    nv_st = "search".
    RUN pd_q.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_s
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_s C-Win
ON VALUE-CHANGED OF ra_s IN FRAME fr_q
DO:
    ra_s = INPUT ra_s.
    RUN pd_q.
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

   /* DEF  VAR  gv_prog    AS   CHAR  FORMAT "X(50)" NO-UNDO.
    DEF VAR   s_prog   AS CHAR INIT "".  */

    SESSION:DATA-ENTRY-RETURN = YES.

  /*s_prog = "wuwque07.w" .
  gv_prog  = "Programe Set SYM100".   */
  RUN  WUT\WUTHEAD (c-win:handle,s_prog,gv_prog).
  RUN  WUT\WUTWICEN (c-win:handle). 
  RUN enable_UI.
  DISABLE ALL WITH FRAME fr_input.
  RUN pd_head.
  RUN pd_q.
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
  DISPLAY fi_head 
      WITH FRAME fr_head IN WINDOW C-Win.
  ENABLE RECT-01 
      WITH FRAME fr_head IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_head}
  DISPLAY ra_s fi_search 
      WITH FRAME fr_q IN WINDOW C-Win.
  ENABLE RECT-4 br_q ra_s fi_search 
      WITH FRAME fr_q IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_q}
  DISPLAY fi_code fi_desc 
      WITH FRAME fr_input IN WINDOW C-Win.
  ENABLE fi_code fi_desc bu_ok bu_cancel RECT-3 
      WITH FRAME fr_input IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_input}
  ENABLE RECT-2 bu_add bu_update bu_delete bu_exit 
      WITH FRAME fr_add IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_add}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_dis C-Win 
PROCEDURE pd_dis :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
        fi_code  =  tsym.itmcod 
        fi_desc  =  tsym.itmdes .
    DISP fi_code fi_desc WITH FRAME fr_input.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_head C-Win 
PROCEDURE pd_head :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND FIRST sym100 WHERE sym100.tabcod = "S001" AND
                        sym100.itmcod = nv_tabcod NO-LOCK NO-ERROR.
IF AVAIL sym100 THEN DO:
    fi_head = sym100.itmdes.
END.
ELSE DO:
    IF nv_tabcod = "U120" THEN fi_head = "Parameter Check Class to D\R Risk".
    ELSE fi_head = "Set Up Parameter".
END.



DISP fi_head WITH FRAME fr_head.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_q C-Win 
PROCEDURE pd_q :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH tsym:
    DELETE tsym.
END.
FOR EACH sym100 WHERE sym100.tabcod = nv_tabcod NO-LOCK:
    CREATE tsym.
    ASSIGN
        tsym.itrecid = RECID(sym100)
        tsym.itmcod  = sym100.itmcod 
        tsym.itmdes  = sym100.itmdes .

END.
FIND FIRST tsym NO-LOCK NO-ERROR.
IF NOT AVAIL tsym THEN DO:
    DISABLE br_q WITH FRAME fr_q.
    OPEN QUERY br_q FOR EACH tsym NO-LOCK.
END.
ELSE DO:
    ENABLE br_q WITH FRAME fr_q.
    IF nv_st = "search" THEN DO:
        IF ra_s = 1 THEN DO:
            OPEN QUERY br_q FOR EACH tsym NO-LOCK BY  tsym.itmcod .
            FIND FIRST tsym WHERE tsym.itmcod BEGINS fi_search NO-LOCK NO-ERROR.
            IF AVAIL tsym THEN DO:
                 REPOSITION br_q TO RECID RECID(tsym).
            END.
        END.
        ELSE DO:
            OPEN QUERY br_q FOR EACH tsym NO-LOCK BY  tsym.itmdes.
            FIND FIRST tsym WHERE tsym.itmdes BEGINS fi_search NO-LOCK NO-ERROR.
            IF AVAIL tsym THEN DO:
                 REPOSITION br_q TO RECID RECID(tsym).
            END.
        END.

    END.
    ELSE IF nv_st = "update" THEN DO:
        IF ra_s = 1 THEN DO:
            OPEN QUERY br_q FOR EACH tsym NO-LOCK BY  tsym.itmcod .
            FIND FIRST tsym WHERE tsym.itmcod = fi_code NO-LOCK NO-ERROR.
            IF AVAIL tsym THEN DO:
                 REPOSITION br_q TO RECID RECID(tsym).
            END.
        END.
        ELSE DO:
            OPEN QUERY br_q FOR EACH tsym NO-LOCK BY  tsym.itmdes.
            FIND FIRST tsym WHERE tsym.itmdes = fi_code NO-LOCK NO-ERROR.
            IF AVAIL tsym THEN DO:
                 REPOSITION br_q TO RECID RECID(tsym).
            END.
        END.
    END.
    ELSE DO:
        IF ra_s = 1 THEN OPEN QUERY br_q FOR EACH tsym NO-LOCK BY  tsym.itmcod .
        ELSE OPEN QUERY br_q FOR EACH tsym NO-LOCK BY  tsym.itmdes.

    END.
    nv_st = "".

    IF nv_click <> ? THEN DO:
        OPEN QUERY br_q FOR EACH tsym NO-LOCK BY tsym.itmcod .
        FIND FIRST tsym WHERE tsym.itrecid = nv_click NO-LOCK NO-ERROR.
        IF AVAIL tsym THEN DO:
             REPOSITION br_q TO RECID RECID(tsym).
             nv_click = ?.
    END.
END.
END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

