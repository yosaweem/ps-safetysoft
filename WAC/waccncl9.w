&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
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
  
  Modify By : Porntiwa T. A62-0105 29/08/2019
            : Change Host safetynas1 => TMSTH

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

DEF NEW GLOBAL SHARED  VAR n_user       AS  CHAR .
DEF NEW GLOBAL SHARED  VAR n_passwd     AS  CHAR.

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
&Scoped-Define ENABLED-OBJECTS RECT-93 RECT-95 rect10 fiUser fiPasswd ~
Btn_OK Btn_Cancel 
&Scoped-Define DISPLAYED-OBJECTS fiUser fiPasswd fiUserLabel fiPasswdLabel 

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

DEFINE BUTTON Btn_OK AUTO-END-KEY 
     LABEL "OK" 
     SIZE 12 BY 1.14
     BGCOLOR 8 .

DEFINE VARIABLE fiPasswd AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 20.5 BY 1 NO-UNDO.

DEFINE VARIABLE fiPasswdLabel AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 11.5 BY .95
     BGCOLOR 2 FGCOLOR 10  NO-UNDO.

DEFINE VARIABLE fiUser AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 20.5 BY 1 NO-UNDO.

DEFINE VARIABLE fiUserLabel AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 11.5 BY .95
     BGCOLOR 2 FGCOLOR 10  NO-UNDO.

DEFINE RECTANGLE RECT-93
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 51 BY 5.48
     BGCOLOR 10 .

DEFINE RECTANGLE RECT-95
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 51 BY 2.1
     BGCOLOR 10 .

DEFINE RECTANGLE rect10
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 51 BY 1.57
     BGCOLOR 10 FGCOLOR 0 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     fiUser AT ROW 3.38 COL 22 COLON-ALIGNED NO-LABEL
     fiPasswd AT ROW 4.57 COL 22 COLON-ALIGNED NO-LABEL BLANK  DEBLANK 
     Btn_OK AT ROW 7.19 COL 14.5
     Btn_Cancel AT ROW 7.19 COL 27
     fiUserLabel AT ROW 3.38 COL 11.5 NO-LABEL DEBLANK 
     fiPasswdLabel AT ROW 4.57 COL 11.5 NO-LABEL DEBLANK 
     "           LOGIN TO DB-CLAIM9" VIEW-AS TEXT
          SIZE 34.5 BY .71 AT ROW 1.67 COL 11.5
          BGCOLOR 2 FGCOLOR 15 FONT 6
     RECT-93 AT ROW 1.24 COL 2.5
     RECT-95 AT ROW 6.76 COL 2.5
     rect10 AT ROW 1.24 COL 2.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 54.83 BY 8.33.


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
         HEIGHT             = 8.33
         WIDTH              = 54.83
         MAX-HEIGHT         = 35.33
         MAX-WIDTH          = 170.67
         VIRTUAL-HEIGHT     = 35.33
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
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME DEFAULT-FRAME
   FRAME-NAME                                                           */
/* SETTINGS FOR FILL-IN fiPasswdLabel IN FRAME DEFAULT-FRAME
   NO-ENABLE ALIGN-L                                                    */
/* SETTINGS FOR FILL-IN fiUserLabel IN FRAME DEFAULT-FRAME
   NO-ENABLE ALIGN-L                                                    */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
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


&Scoped-define SELF-NAME Btn_Cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Cancel C-Win
ON CHOOSE OF Btn_Cancel IN FRAME DEFAULT-FRAME /* Cancel */
DO:
  QUIT.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK C-Win
ON CHOOSE OF Btn_OK IN FRAME DEFAULT-FRAME /* OK */
DO:
  ASSIGN 
    fiUser   = INPUT fiUser
    fiPasswd = INPUT fiPasswd    

    n_user   = fiUser
    n_passwd = fiPasswd.
    
  /*-- Comment A62-0105 --
  CONNECT -db claim9 -H safetynas1 -S claim9 -N TCP -U VALUE(n_user) -P VALUE (n_passwd)
  /*CONNECT -db claim9 -H newapp -S cltest -N TCP -U VALUE(n_user) -P VALUE (n_passwd)*/
                      -cpinternal 620-2533 -cpstream 620-2533 NO-ERROR.
   -- End Comment A62-0105 --*/

  CONNECT -db claim9 -H TMSTH -S claim9 -N TCP -U VALUE(n_user) -P VALUE (n_passwd)
                      -cpinternal 620-2533 -cpstream 620-2533 NO-ERROR.
  IF NOT SETUSERID (n_user,n_passwd,"claim9") OR n_user = "" THEN DO:
  MESSAGE "Cannot connected Database Claim9 " VIEW-AS ALERT-BOX ERROR BUTTONS OK
            TITLE "Invalid LOGON".
            APPLY  "ENTRY" To fiUser.
            RETURN  NO-APPLY.
  END.
  

  IF CONNECTED("Claim9") THEN DO:
     MESSAGE "Connect Claim9" VIEW-AS ALERT-BOX.
      Apply "Close" TO THIS-PROCEDURE. 
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

  
  
  gv_prgid = "WLOGCL9".
  gv_prog  = "LOGIN TO DB-CLAIM9".
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).

  RUN Wut\WutwiCen (C-Win:HANDLE).
  SESSION:DATA-ENTRY-RETURN = YES.

  
    APPLY "ENTRY" TO fiUser IN FRAME {&FRAME-NAME}.

  
  DISP 
    "User"     @ fiUserLabel
    "Password" @ fiPasswdLabel

  WITH FRAME {&FRAME-NAME}.



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
  DISPLAY fiUser fiPasswd fiUserLabel fiPasswdLabel 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE RECT-93 RECT-95 rect10 fiUser fiPasswd Btn_OK Btn_Cancel 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

