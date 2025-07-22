&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS Dialog-Frame 
/*------------------------------------------------------------------------

  File: 

  Description: 

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author: 

  Created: 
  Modify by A56-0127 Sayamol N. 10/05/2013
      - Change global Variable from n_user, n_passwd 
        to n_glbrusr, n_glbrpwd
------------------------------------------------------------------------*
  Modify By : Porntiwa T.  A62-0105  25/06/2019
            : Change Host => tmsth        
------------------------------------------------------------------------*/
/*          This .W file was created with the Progress UIB.             */
/*----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */
/*---A56-0127---
DEF NEW GLOBAL SHARED VAR  n_user   AS CHAR.
DEF NEW GLOBAL SHARED VAR  n_passwd AS CHAR.
------------*/
/*--- A56-0127---*/
DEF  VAR  n_glbrusr   AS CHAR.
DEF  VAR  n_glbrpwd   AS CHAR.
/*---------------*/

DEF NEW GLOBAL SHARED VAR  n_status AS Logic INITIAL Yes.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE DIALOG-BOX
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME Dialog-Frame

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-93 RECT-95 rect10 fi_user fi_passwd ~
Btn_OK Btn_Cancel 
&Scoped-Define DISPLAYED-OBJECTS fi_user fi_passwd 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Cancel" 
     SIZE 12 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "OK" 
     SIZE 12 BY 1.14
     BGCOLOR 8 .

DEFINE VARIABLE fi_passwd AS CHARACTER FORMAT "X(16)":U 
     VIEW-AS FILL-IN 
     SIZE 19.5 BY 1 NO-UNDO.

DEFINE VARIABLE fi_user AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 19.5 BY 1 NO-UNDO.

DEFINE RECTANGLE RECT-93
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 51 BY 3.81
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-95
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 51 BY 2.1
     BGCOLOR 10 .

DEFINE RECTANGLE rect10
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 51 BY 1.57
     BGCOLOR 10 FGCOLOR 0 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     fi_user AT ROW 3.62 COL 19 COLON-ALIGNED NO-LABEL
     fi_passwd AT ROW 4.91 COL 19 COLON-ALIGNED NO-LABEL BLANK 
     Btn_OK AT ROW 7.24 COL 15
     Btn_Cancel AT ROW 7.24 COL 27.5
     "Password" VIEW-AS TEXT
          SIZE 10.5 BY .57 AT ROW 5.19 COL 9.5
          BGCOLOR 19 
     "       LOGIN >> GL_BRAN <<  SYSTEM" VIEW-AS TEXT
          SIZE 42.5 BY .71 AT ROW 1.67 COL 6.5
          BGCOLOR 4 FGCOLOR 7 
     "User Name" VIEW-AS TEXT
          SIZE 11.5 BY .57 AT ROW 3.86 COL 8.5
          BGCOLOR 19 
     RECT-93 AT ROW 2.91 COL 1.5
     RECT-95 AT ROW 6.76 COL 1.5
     rect10 AT ROW 1.24 COL 1.5
     SPACE(0.00) SKIP(6.13)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         FONT 6
         TITLE "Login GLBRAN System <waccnglb.w>".


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: DIALOG-BOX
   Allow: Basic,Browse,DB-Fields,Query
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX Dialog-Frame
                                                                        */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Login GLBRAN System <waccnglb.w> */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Cancel Dialog-Frame
ON CHOOSE OF Btn_Cancel IN FRAME Dialog-Frame /* Cancel */
DO:
  ASSIGN  n_glbrusr  =  ""          
          n_glbrpwd  =  "" 
          n_status   =  No.

  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK Dialog-Frame
ON CHOOSE OF Btn_OK IN FRAME Dialog-Frame /* OK */
DO: 
    /*
     ASSIGN 
          n_user     =   INPUT  fi_user
          n_passwd   =   INPUT  fi_passwd
          n_status   =   YES.
     IF CONNECTED ("glbran") THEN DISCONNECT gl.
     IF n_user = "" AND n_passwd = "" THEN MESSAGE "GLBRAN Not Connect" VIEW-AS ALERT-BOX.
     ELSE DO:
          /* CONNECT -db gl -H alpha4 -S gl -N TCP -U value(n_user) -P value(n_passwd)
                   -cpinternal 620-2533 -cpstream 620-2533 NO-ERROR.*/
           CONNECT -db glbran -H newapp -S glbrantest -N TCP -U value(n_user) -P value(n_passwd)
                   -cpinternal 620-2533 -cpstream 620-2533 NO-ERROR. 
           IF NOT CONNECTED ("glbran") THEN DO:
              MESSAGE "GL not connect " VIEW-AS ALERT-BOX ERROR 
              BUTTONS OK TITLE "Invalid LOGON".
           END.
           IF CONNECTED ("glbran") THEN MESSAGE "Connect GLBRAN..!!!" VIEW-AS ALERT-BOX INFORMATION.
     END.
     */

     ASSIGN 
          /*---A56-0127---
          n_user     =   INPUT  fi_user
          n_passwd   =   INPUT  fi_passwd
          -------------*/
          /*---A56-0127---*/
          n_glbrusr   =   INPUT  fi_user
          n_glbrpwd   =   INPUT  fi_passwd
          /*---------------*/
          n_status   =   YES.
     IF CONNECTED ("gl_bran") THEN DISCONNECT gl_bran.
     /*---A56-0127---
     IF n_user = "" AND n_passwd = "" THEN MESSAGE "GL_BRAN Not Connect" VIEW-AS ALERT-BOX.
     -----------*/
     IF n_glbrusr = "" AND n_glbrpwd = "" THEN MESSAGE "GL_BRAN Not Connect" VIEW-AS ALERT-BOX.
     ELSE DO:
         
          /*--For Production ---*/
          /*CONNECT -db gl_bran -H alpha4 -S gl_bran -N TCP -U value(n_glbrusr) -P value(n_glbrpwd)
                   -cpinternal 620-2533 -cpstream 620-2533 NO-ERROR.*//*Comment A62-0105*/
         CONNECT -db gl_bran -H tmsth -S gl_bran -N TCP -U value(n_glbrusr) -P value(n_glbrpwd)
                   -cpinternal 620-2533 -cpstream 620-2533 NO-ERROR.  /*Add A62-0105*/
         /*---------------*/

          /*--For TEST ---*/
          /*----------
         CONNECT -db gl_bran -H newapp  -S gl_brantest -N TCP -U value(n_glbrusr) -P value(n_glbrpwd)
                   -cpinternal 620-2533 -cpstream 620-2533 NO-ERROR. 
           ------*/
              
           IF NOT CONNECTED ("gl_bran") THEN DO:
              MESSAGE "GL_BRAN not connect " VIEW-AS ALERT-BOX ERROR 
              BUTTONS OK TITLE "Invalid LOGON".
               RETURN No-Apply.
           END.
           IF CONNECTED ("gl_bran") THEN DO: 
               MESSAGE "Connect GL_BRAN!!!" VIEW-AS ALERT-BOX INFORMATION.
           END.
     END.
     
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK Dialog-Frame 


/* ***************************  Main Block  *************************** */

/* Parent the dialog-box to the ACTIVE-WINDOW, if there is no parent.   */
IF VALID-HANDLE(ACTIVE-WINDOW) AND FRAME {&FRAME-NAME}:PARENT eq ?
THEN FRAME {&FRAME-NAME}:PARENT = ACTIVE-WINDOW.


/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.
  
  Session:DATA-ENTRY-RETURN = YES.
  RUN Wut\WutDiCen(FRAME Dialog-frame:HANDLE).
  Rect10:MOVE-TO-TOP().
  WAIT-FOR GO OF FRAME {&FRAME-NAME}.
END.
RUN disable_UI.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI Dialog-Frame  _DEFAULT-DISABLE
PROCEDURE disable_UI :
/*------------------------------------------------------------------------------
  Purpose:     DISABLE the User Interface
  Parameters:  <none>
  Notes:       Here we clean-up the user-interface by deleting
               dynamic widgets we have created and/or hide 
               frames.  This procedure is usually called when
               we are ready to "clean-up" after running.
------------------------------------------------------------------------------*/
  /* Hide all frames. */
  HIDE FRAME Dialog-Frame.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI Dialog-Frame  _DEFAULT-ENABLE
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
  DISPLAY fi_user fi_passwd 
      WITH FRAME Dialog-Frame.
  ENABLE RECT-93 RECT-95 rect10 fi_user fi_passwd Btn_OK Btn_Cancel 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

