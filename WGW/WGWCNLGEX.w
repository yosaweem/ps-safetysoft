&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME wexplog
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS wexplog 
/*------------------------------------------------------------------------

  File: 

  Description: 

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author: 

  Created: kridtiya i. A64-0137 Modify:Program Import Text File Motor SCB[Renew] 

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

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fiUser fiPasswd buOK buCancel RECT-3 RECT-4 
&Scoped-Define DISPLAYED-OBJECTS fiUser fiPasswd 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wexplog AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON buCancel 
     LABEL "Cancel" 
     SIZE 10.5 BY 1.24.

DEFINE BUTTON buOK 
     LABEL "OK" 
     SIZE 10.5 BY 1.24.

DEFINE VARIABLE fiPasswd AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1 NO-UNDO.

DEFINE VARIABLE fiUser AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     FONT 2 NO-UNDO.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 67.5 BY 1.76
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 67.5 BY 5.19
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 65.5 BY 4.71
     BGCOLOR 8 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     fiUser AT ROW 3.43 COL 34.5 COLON-ALIGNED NO-LABEL AUTO-RETURN 
     fiPasswd AT ROW 4.62 COL 34.5 COLON-ALIGNED NO-LABEL BLANK  AUTO-RETURN 
     buOK AT ROW 5.95 COL 25.5
     buCancel AT ROW 5.95 COL 36.83
     "              Please CONNECT EXPIRY" VIEW-AS TEXT
          SIZE 65.5 BY 1 AT ROW 1.52 COL 2.5
          FGCOLOR 1 FONT 2
     "User Id     :" VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 3.43 COL 21.5
          FGCOLOR 1 FONT 36
     "Password :" VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 4.62 COL 21.5
          FGCOLOR 1 FONT 36
     RECT-3 AT ROW 1.14 COL 1.5
     RECT-4 AT ROW 2.95 COL 1.5
     RECT-6 AT ROW 3.19 COL 2.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 69 BY 7.52.


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
  CREATE WINDOW wexplog ASSIGN
         HIDDEN             = YES
         TITLE              = "WGWCNLGEX.w Safety Insurance Public Company Limited"
         HEIGHT             = 7.05
         WIDTH              = 67.67
         MAX-HEIGHT         = 16
         MAX-WIDTH          = 97.83
         VIRTUAL-HEIGHT     = 16
         VIRTUAL-WIDTH      = 97.83
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
/* SETTINGS FOR WINDOW wexplog
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME DEFAULT-FRAME
   FRAME-NAME Custom                                                    */
/* SETTINGS FOR RECTANGLE RECT-6 IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wexplog)
THEN wexplog:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME wexplog
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wexplog wexplog
ON END-ERROR OF wexplog /* WGWCNLGEX.w Safety Insurance Public Company Limited */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wexplog wexplog
ON WINDOW-CLOSE OF wexplog /* WGWCNLGEX.w Safety Insurance Public Company Limited */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buCancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buCancel wexplog
ON CHOOSE OF buCancel IN FRAME DEFAULT-FRAME /* Cancel */
DO:
      APPLY "CLOSE" TO THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buOK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buOK wexplog
ON CHOOSE OF buOK IN FRAME DEFAULT-FRAME /* OK */
DO:
    IF CONNECTED("sic_exp")  THEN DISCONNECT sic_exp.

    CONNECT expiry  -H tmsth       -S expiry -ld sic_exp -N tcp -U VALUE(fiUser) -P VALUE(fiPasswd) NO-ERROR.     /* HO*/
    /*CONNECT expiry  -H 18.10.100.5 -S expiry -ld sic_exp -N tcp -U VALUE(fiUser) -P VALUE(fiPasswd) NO-ERROR.  /*Test*/*/ 
    IF NOT SETUSERID (fiUser,fiPasswd,"sic_exp") OR fiUser = "" THEN DO:
        MESSAGE "Cannot connected Database EXPIRY !!! " VIEW-AS ALERT-BOX ERROR BUTTONS OK 
            TITLE "Invalid LOGON".
        APPLY  "ENTRY" TO fiUser.
        RETURN NO-APPLY.
    END.
    APPLY "CLOSE" TO THIS-PROCEDURE.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiPasswd
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiPasswd wexplog
ON LEAVE OF fiPasswd IN FRAME DEFAULT-FRAME
DO:
  ASSIGN fiPasswd.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiPasswd wexplog
ON RETURN OF fiPasswd IN FRAME DEFAULT-FRAME
DO:
  ASSIGN fiPasswd.
  APPLY "CHOOSE" TO buOK.
  Return No-Apply.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiUser
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiUser wexplog
ON LEAVE OF fiUser IN FRAME DEFAULT-FRAME
DO:
  ASSIGN fiUser.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK wexplog 


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
   RUN wut\wutwicen(wexplog:Handle).
  RUN enable_UI.
  Session:Data-Entry-Return  = Yes.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI wexplog  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wexplog)
  THEN DELETE WIDGET wexplog.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI wexplog  _DEFAULT-ENABLE
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
  DISPLAY fiUser fiPasswd 
      WITH FRAME DEFAULT-FRAME IN WINDOW wexplog.
  ENABLE fiUser fiPasswd buOK buCancel RECT-3 RECT-4 
      WITH FRAME DEFAULT-FRAME IN WINDOW wexplog.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW wexplog.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

