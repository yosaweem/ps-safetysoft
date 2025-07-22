&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
&ANALYZE-RESUME
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
DEFINE NEW SHARED VARIABLE n_user      AS CHAR INIT "".
DEFINE NEW SHARED VARIABLE n_passwd    AS CHAR INIT "".

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS rect10 RECT-93 fi_user fi_passwd bu_login ~
Btn_Cancel 
&Scoped-Define DISPLAYED-OBJECTS fi_head fi_user fi_passwd 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Cancel" 
     SIZE 12 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON bu_login AUTO-GO 
     LABEL "LOGIN" 
     SIZE 12 BY 1.14
     BGCOLOR 8 .

DEFINE VARIABLE fi_head AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 50 BY 1 NO-UNDO.

DEFINE VARIABLE fi_passwd AS CHARACTER FORMAT "X(16)":U 
     VIEW-AS FILL-IN 
     SIZE 19.5 BY 1 NO-UNDO.

DEFINE VARIABLE fi_user AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 19.5 BY 1 NO-UNDO.

DEFINE RECTANGLE RECT-93
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 51.5 BY 6.24
     BGCOLOR 19 .

DEFINE RECTANGLE rect10
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 51.5 BY 1.43
     BGCOLOR 81 FGCOLOR 0 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     fi_head AT ROW 1.48 COL 2 NO-LABEL WIDGET-ID 24
     fi_user AT ROW 3.43 COL 20.5 COLON-ALIGNED NO-LABEL WIDGET-ID 8
     fi_passwd AT ROW 4.71 COL 20.5 COLON-ALIGNED NO-LABEL WIDGET-ID 6 BLANK 
     bu_login AT ROW 6.38 COL 15.83 WIDGET-ID 4
     Btn_Cancel AT ROW 6.38 COL 28.33 WIDGET-ID 2
     "User Name" VIEW-AS TEXT
          SIZE 11.5 BY .57 AT ROW 3.67 COL 10 WIDGET-ID 14
          BGCOLOR 8 FONT 6
     "Password" VIEW-AS TEXT
          SIZE 10.5 BY .57 AT ROW 5 COL 11 WIDGET-ID 10
          BGCOLOR 8 FONT 6
     rect10 AT ROW 1.24 COL 1 WIDGET-ID 16
     RECT-93 AT ROW 2.67 COL 1 WIDGET-ID 20
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 51.5 BY 7.95 WIDGET-ID 100.


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
         TITLE              = "waccndwh-Login for PremiumDWH"
         HEIGHT             = 7.95
         WIDTH              = 51.5
         MAX-HEIGHT         = 16
         MAX-WIDTH          = 80
         VIRTUAL-HEIGHT     = 16
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
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME DEFAULT-FRAME
   FRAME-NAME                                                           */
/* SETTINGS FOR FILL-IN fi_head IN FRAME DEFAULT-FRAME
   NO-ENABLE ALIGN-L                                                    */
ASSIGN 
       fi_head:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* waccndwh-Login for PremiumDWH */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* waccndwh-Login for PremiumDWH */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Cancel C-Win
ON CHOOSE OF Btn_Cancel IN FRAME DEFAULT-FRAME /* Cancel */
DO:
    ASSIGN
        n_user     =  ""          
        n_passwd   =  "".
    APPLY  "Close" TO THIS-PROCEDURE.
   RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_login
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_login C-Win
ON CHOOSE OF bu_login IN FRAME DEFAULT-FRAME /* LOGIN */
DO: 
       n_user = INPUT fi_user.
       n_passwd = INPUT fi_passwd.

       IF n_user = "" THEN DO:
           MESSAGE "Please Enter User" VIEW-AS ALERT-BOX.
           APPLY "ENTRY" TO fi_user.
           RETURN NO-APPLY.
       END.
       ELSE IF n_passwd = "" THEN DO:
           MESSAGE "Please Enter Password" VIEW-AS ALERT-BOX. 
           APPLY "ENTRY" TO fi_passwd.
           RETURN NO-APPLY.
       END.

       ELSE DO:
           /*---------Test----------
           CONNECT -db sicsyac -H 10.35.1.95 -S sicsyac -N TCP -U value(n_user) -P value(n_passwd) NO-ERROR. 
           CONNECT -db siccl   -H 10.35.1.95 -S siccl   -N TCP -U value(n_user) -P value(n_passwd) NO-ERROR. 
           CONNECT -db sicuw   -H 10.35.1.95 -S sicuw   -N TCP -U value(n_user) -P value(n_passwd) NO-ERROR. 
           CONNECT -db stat    -H 10.35.1.95 -S stat    -N TCP -U value(n_user) -P value(n_passwd) NO-ERROR. 
           CONNECT -db premiumdwh -H 10.35.1.95 -S 60460   -N TCP -U value(n_user) -P value(n_passwd) NO-ERROR. 
           -----------------------*/
           /*-------------------
           CONNECT -db sicsyac -H tmsth -S sicsyac -N TCP -U value(n_user) -P value(n_passwd) NO-ERROR. 
           CONNECT -db siccl   -H tmsth -S siccl   -N TCP -U value(n_user) -P value(n_passwd) NO-ERROR. 
           CONNECT -db sicuw   -H tmsth -S sicuw   -N TCP -U value(n_user) -P value(n_passwd) NO-ERROR. 
           CONNECT -db stat    -H tmsth -S stat    -N TCP -U value(n_user) -P value(n_passwd) NO-ERROR. 
           CONNECT -db gl      -H tmsth -S gl      -N TCP -U value(n_user) -P value(n_passwd) NO-ERROR. 
           --------------------------*/
           CONNECT -db premiumdwh     -H tmsth -S 60460  -N TCP -U value(n_user) -P value(n_passwd) NO-ERROR. 
           

           IF NOT CONNECTED ("sicsyac") THEN DO:
              MESSAGE "sicsyac Not Connect" VIEW-AS ALERT-BOX ERROR 
              BUTTONS OK TITLE "Invalid LOGON".
           END.
           ELSE IF NOT CONNECTED ("siccl") THEN DO:
              MESSAGE "siccl Not Connect" VIEW-AS ALERT-BOX ERROR 
              BUTTONS OK TITLE "Invalid LOGON".
           END.
           ELSE IF NOT CONNECTED ("sicuw") THEN DO:
              MESSAGE "sicuw Not Connect" VIEW-AS ALERT-BOX ERROR 
              BUTTONS OK TITLE "Invalid LOGON".
           END.
           ELSE IF NOT CONNECTED ("stat") THEN DO:
              MESSAGE "stat Not Connect" VIEW-AS ALERT-BOX ERROR 
              BUTTONS OK TITLE "Invalid LOGON".
           END.
           ELSE IF NOT CONNECTED ("premiumdwh") THEN DO:
               MESSAGE "premiumdwh Not Connect" VIEW-AS ALERT-BOX ERROR 
               BUTTONS OK TITLE "Invalid LOGON".
           END.
           

           IF /*CONNECTED ("sicsyac")  AND 
              CONNECTED ("siccl")    AND 
              CONNECTED ("sicuw")    AND 
              CONNECTED ("stat")     AND */
              CONNECTED ("premiumdwh")  THEN DO:
               MESSAGE "Connect premiumdwh!!!" VIEW-AS ALERT-BOX INFORMATION.
               APPLY  "Close" TO THIS-PROCEDURE.
               RUN wac\wacr60expd.   
               RETURN NO-APPLY.
           END.
       END.

     
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_passwd
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_passwd C-Win
ON LEAVE OF fi_passwd IN FRAME DEFAULT-FRAME
DO:
  n_passwd = INPUT fi_passwd.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_user
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_user C-Win
ON LEAVE OF fi_user IN FRAME DEFAULT-FRAME
DO:
  n_user = INPUT fi_user.
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
  Session:Data-Entry-Return = Yes.
  fi_head =  "PREMIUMDWH SYSTEM".
  DISP fi_head WITH FRAME DEFAULT-FRAME.

  


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
  DISPLAY fi_head fi_user fi_passwd 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE rect10 RECT-93 fi_user fi_passwd bu_login Btn_Cancel 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

