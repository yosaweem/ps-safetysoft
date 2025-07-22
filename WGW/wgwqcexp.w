&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
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
/************************************************************************/
/* wgwqpexp.p   Connect  Expiry                                                                         */
/* Copyright    : Tokio Marine Safety Insurance (Thailand) PCL.           */
/*                        บริษัท คุ้มภัยโตเกียวมารีนประกันภัย (ประเทศไทย)                                                     */
/* CREATE  BY    : Chaiyong W. A64-0135 13/09/2021                               */
/* Modifly BY    : Songkran P. A64-0398 01/12/2021                               */
/************************************************************************/  
------------------------------------------------------------------------*/
/*          This .W file was created with the Progress AppBuilder.       */
/*----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */
DEFINE SHARED VAR n_user   AS CHAR.
DEFINE SHARED VAR n_passwd AS CHAR.
/* Local Variable Definitions ---                                       */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Dialog-Box
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME Dialog-Frame

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-3 fiUser fiPasswd buOK buCancel 
&Scoped-Define DISPLAYED-OBJECTS fiUser fiPasswd 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON buCancel AUTO-END-KEY 
     LABEL "Cancel" 
     SIZE 10.5 BY 1.29.

DEFINE BUTTON buOK 
     LABEL "OK" 
     SIZE 10.5 BY 1.29.

DEFINE VARIABLE fiPasswd AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95 NO-UNDO.

DEFINE VARIABLE fiUser AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     FONT 2 NO-UNDO.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 67.5 BY 2.33
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 65.5 BY 7.57
     BGCOLOR 8 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     fiUser AT ROW 5.19 COL 34.5 COLON-ALIGNED NO-LABEL WIDGET-ID 8 AUTO-RETURN 
     fiPasswd AT ROW 6.76 COL 34.5 COLON-ALIGNED NO-LABEL WIDGET-ID 6 BLANK  AUTO-RETURN 
     buOK AT ROW 9.1 COL 25.5 WIDGET-ID 4
     buCancel AT ROW 9.1 COL 38.5 WIDGET-ID 2
     "  Please enter a User Id and Password for Expiry System" VIEW-AS TEXT
          SIZE 65.5 BY 1.81 AT ROW 1.52 COL 2.5 WIDGET-ID 14
          FGCOLOR 1 FONT 2
     "User Id     :" VIEW-AS TEXT
          SIZE 14 BY 1.05 AT ROW 5.19 COL 21.5 WIDGET-ID 16
          FGCOLOR 1 FONT 36
     "Password :" VIEW-AS TEXT
          SIZE 12.5 BY 1.05 AT ROW 6.76 COL 21.5 WIDGET-ID 18
          FGCOLOR 1 FONT 36
     RECT-3 AT ROW 1.24 COL 1.5 WIDGET-ID 10
     RECT-6 AT ROW 3.86 COL 2.5 WIDGET-ID 12
     SPACE(2.49) SKIP(0.85)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "<insert dialog title>" WIDGET-ID 100.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Dialog-Box
   Allow: Basic,Browse,DB-Fields,Query
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX Dialog-Frame
   FRAME-NAME                                                           */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

/* SETTINGS FOR RECTANGLE RECT-6 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* <insert dialog title> */
DO:
    APPLY "CLOSE":U TO THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buCancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buCancel Dialog-Frame
ON CHOOSE OF buCancel IN FRAME Dialog-Frame /* Cancel */
DO:
       APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buOK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buOK Dialog-Frame
ON CHOOSE OF buOK IN FRAME Dialog-Frame /* OK */
DO:
       IF CONNECTED ("sic_exp") THEN DISCONNECT sic_exp. 
       
       /*CONNECT -db expiry -H brpy   -S expirytest -N TCP -ld sic_bran -U  value(fiUser) -P value(fiPasswd)  NO-ERROR.*/               
      
       /*CONNECT -db expiry -H alpha4   -S expiry -N TCP -ld sic_bran -U  value(fiUser) -P value(fiPasswd)  NO-ERROR.  *//*Comment A62-0105*/
       CONNECT -db expiry -H tmsth   -S expiry -N TCP -ld sic_exp -U  value(fiUser) -P value(fiPasswd)  NO-ERROR.

      /* CONNECT -db expiry -H devserver   -S expiry -N TCP -ld sic_exp -U  value(fiUser) -P value(fiPasswd)  NO-ERROR.
        */
       /*- IF NOT SETUSERID (fiUser,fiPasswd,"sic_bran") OR fiUser = "" THEN DO: --*/
       IF NOT SETUSERID (fiUser,fiPasswd,"sic_exp") OR fiUser = "" THEN DO:
              MESSAGE "Cannot connected Database Expiry " VIEW-AS ALERT-BOX ERROR BUTTONS OK 
              TITLE "Invalid LOGON".
              APPLY  "ENTRY" To fiUser.
              Return No-Apply.
       END.      
       APPLY "END-ERROR":U TO SELF.
 
     
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiPasswd
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiPasswd Dialog-Frame
ON LEAVE OF fiPasswd IN FRAME Dialog-Frame
DO:
  ASSIGN fiPasswd.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiPasswd Dialog-Frame
ON RETURN OF fiPasswd IN FRAME Dialog-Frame
DO:
  ASSIGN fiPasswd.
  APPLY "CHOOSE" TO buOK.
  Return No-Apply.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiUser
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiUser Dialog-Frame
ON LEAVE OF fiUser IN FRAME Dialog-Frame
DO:
  ASSIGN fiUser.
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
  ASSIGN
      fiUser   = n_user  
      fiPasswd = n_passwd.
  DISP fiUser   
       fiPasswd WITH FRAME dialog-frame.
  APPLY "entry" TO fiUser.
  APPLY "choose" TO buOK.

  WAIT-FOR CLOSE OF FRAME {&FRAME-NAME}.
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
  DISPLAY fiUser fiPasswd 
      WITH FRAME Dialog-Frame.
  ENABLE RECT-3 fiUser fiPasswd buOK buCancel 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

