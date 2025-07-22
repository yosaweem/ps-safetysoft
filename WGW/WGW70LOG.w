&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME WGW70LOG
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS WGW70LOG 
/*************************************************************************
 Copyright  : Safety Insurance Public Company Limited
               บริษัท ประกันคุ้มภัย จำกัด (มหาชน)           
 *************************************************************************/
/*------------------------------------------------------------------------

  File: 

  Description: LOQ IN เข้าเมนู Auto Transfer Gw to Premium

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author: 

  Created: Jiraphon P.   ASSIGN: A60-0464       DATE: 01-08-2018

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
DEF NEW SHARED VAR nv_user     AS CHARACTER.
DEF NEW SHARED VAR nv_error    AS CHARACTER.
DEF NEW SHARED VAR nv_tries    AS INT INIT 0.

DEFINE VAR ChkCon AS LOGICAL INIT YES.
DEFINE VAR ChkDb  AS CHAR EXTENT 6.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-4 RECT-5 RECT-140 fi_username ~
fi_password bu_OK bu_cancel 
&Scoped-Define DISPLAYED-OBJECTS fi_username fi_password 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR WGW70LOG AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_cancel 
     LABEL "CANCEL" 
     SIZE 10.5 BY 1.24
     FONT 6.

DEFINE BUTTON bu_OK 
     LABEL "OK" 
     SIZE 10.5 BY 1.24
     FONT 6.

DEFINE VARIABLE fi_password AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 18.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_username AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 18.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-140
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 46 BY 1.29
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 46.17 BY 4.43
     BGCOLOR 20 .

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 46.17 BY 2.1
     BGCOLOR 3 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_username AT ROW 2.91 COL 18.5 COLON-ALIGNED NO-LABEL
     fi_password AT ROW 4.1 COL 18.5 COLON-ALIGNED NO-LABEL BLANK  DEBLANK 
     bu_OK AT ROW 5.91 COL 12.17
     bu_cancel AT ROW 5.91 COL 26.83
     "LOGIN - GWCTX" VIEW-AS TEXT
          SIZE 18.33 BY 1 AT ROW 1.33 COL 16 WIDGET-ID 4
          BGCOLOR 3 FGCOLOR 14 FONT 6
     "User name:" VIEW-AS TEXT
          SIZE 12 BY 1 AT ROW 2.91 COL 6.83
          BGCOLOR 20 FGCOLOR 0 FONT 6
     "Password:" VIEW-AS TEXT
          SIZE 12 BY 1 AT ROW 4.1 COL 7.67
          BGCOLOR 20 FGCOLOR 0 FONT 6
     RECT-4 AT ROW 1.1 COL 1.33
     RECT-5 AT ROW 5.43 COL 1.33
     RECT-140 AT ROW 1.14 COL 1.33 WIDGET-ID 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 48.5 BY 8
         BGCOLOR 21 .


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
  CREATE WINDOW WGW70LOG ASSIGN
         HIDDEN             = YES
         TITLE              = "Login GW"
         HEIGHT             = 6.57
         WIDTH              = 46.83
         MAX-HEIGHT         = 47.86
         MAX-WIDTH          = 213.33
         VIRTUAL-HEIGHT     = 47.86
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
IF NOT WGW70LOG:LOAD-ICON("adeicon/progress.ico":U) THEN
    MESSAGE "Unable to load icon: adeicon/progress.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW WGW70LOG
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fr_main
   FRAME-NAME                                                           */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(WGW70LOG)
THEN WGW70LOG:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME WGW70LOG
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL WGW70LOG WGW70LOG
ON END-ERROR OF WGW70LOG /* Login GW */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL WGW70LOG WGW70LOG
ON WINDOW-CLOSE OF WGW70LOG /* Login GW */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_cancel WGW70LOG
ON CHOOSE OF bu_cancel IN FRAME fr_main /* CANCEL */
DO:
  APPLY "Close" TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_OK WGW70LOG
ON CHOOSE OF bu_OK IN FRAME fr_main /* OK */
DO:
  ASSIGN
    fi_password = INPUT fi_password
    fi_username = INPUT fi_username.



  IF CONNECTED ("CTXSTAT") THEN DISCONNECT CTXSTAT.     
  IF CONNECTED ("CTXBRAN") THEN DISCONNECT CTXBRAN.
  
  CONNECT -db sic_bran  -ld ctxbran -H ctxdb -S sic_bran1  -U  VALUE(fi_username) -P VALUE(fi_password) NO-ERROR. /*Real*/
  CONNECT -db stat  -ld ctxstat -H ctxdb -S stat1  -U  VALUE(fi_username) -P VALUE(fi_password) NO-ERROR. /*Real*/
  
  
  /*CONNECT sic_bran -ld ctxbran -H devserver -S 3092 -N TCP -U  VALUE(fi_username) -P VALUE(fi_password) NO-ERROR. */ /*Test*/
  /*CONNECT stat     -ld ctxstat -H devserver -S 9041 -N TCP -U  VALUE(fi_username) -P VALUE(fi_password) NO-ERROR.  /*Test*/*/
  

  IF NOT SETUSERID (fi_username,fi_password,"ctxbran") OR fi_username = "" THEN DO:
         MESSAGE "Cannot connected Database ctxbran " VIEW-AS ALERT-BOX ERROR BUTTONS OK 
         TITLE "Invalid LOGON".
         APPLY  "ENTRY" TO fi_username.
         RETURN NO-APPLY.
  END.      

  ASSIGN
    nv_user  = fi_username
    nv_Error = "".
 
  IF nv_Error = "Error" THEN DO:
      APPLY  "ENTRY" To fi_username.
      RETURN NO-APPLY.
  END.

  /*-- Check Connect DB --*/

  IF NOT CONNECTED("CTXSTAT") THEN DO:
      ChkCon   = NO.
      ChkDb[1] = "Not Complete".
  END.
  ELSE ChkDb[1] = "Complete".

  IF NOT CONNECTED("CTXBRAN") THEN DO:
      ChkCon   = NO.
      ChkDb[1] = "Not Complete".
  END.
  ELSE ChkDb[1] = "Complete".


  IF ChkCon = NO THEN DO:
      MESSAGE "====================" SKIP
              "|   Connect Database Detail     |" SKIP
              "====================" SKIP
              "DB: CTXSTAT ....." ChkDb[1] SKIP 
              "DB: CTXBRAN ....." ChkDb[1] SKIP
              "====================" SKIP
      VIEW-AS ALERT-BOX INFORMATION.
      RETURN NO-APPLY.
  END.
  ELSE DO:
      WGW70LOG:HIDDEN = YES.
      RUN WGW\WGWGEQ70.W.
  END.

  /*-- ctx --*/
  IF CONNECTED ("CTXSTAT") THEN DISCONNECT CTXSTAT.
  IF CONNECTED ("CTXBRAN")   THEN DISCONNECT CTXBRAN.

  ASSIGN
    fi_password = ""
    fi_username = "".

  DISP fi_password fi_username  WITH FRAME fr_main.

  WGW70LOG:HIDDEN = NO.
  APPLY "CLOSE" TO THIS-PROCEDURE.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_password
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_password WGW70LOG
ON LEAVE OF fi_password IN FRAME fr_main
DO:
  fi_password = INPUT fi_password.
  DISP fi_password WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_username
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_username WGW70LOG
ON LEAVE OF fi_username IN FRAME fr_main
DO:
  fi_username = INPUT fi_username.
  DISP fi_username WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK WGW70LOG 


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

  fi_username = "".
  fi_password = "".

  DISP fi_username WITH FRAME fr_main.
  DISP fi_password BLANK WITH FRAME fr_main.

 /*  RUN  WUT\WUTWICEN (WRSGTLOG:HANDLE).  */
  SESSION:DATA-ENTRY-RETURN = YES.

  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI WGW70LOG  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(WGW70LOG)
  THEN DELETE WIDGET WGW70LOG.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI WGW70LOG  _DEFAULT-ENABLE
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
  DISPLAY fi_username fi_password 
      WITH FRAME fr_main IN WINDOW WGW70LOG.
  ENABLE RECT-4 RECT-5 RECT-140 fi_username fi_password bu_OK bu_cancel 
      WITH FRAME fr_main IN WINDOW WGW70LOG.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW WGW70LOG.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

