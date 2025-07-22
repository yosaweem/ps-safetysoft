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
DEF  VAR  n_txbrusr   AS CHAR.
DEF  VAR  n_txbrpwd   AS CHAR.
/*---------------*/

DEF NEW GLOBAL SHARED VAR  n_status AS Logic INITIAL Yes.

DEF     SHARED VAR n_User               AS CHAR.
DEF     SHARED VAR n_Passwd         AS CHAR.

DEF VAR nv_Br AS CHAR FORMAT "X(2)".
DEF VAR n_Br AS CHAR FORMAT "X(2)".
DEF VAR n_brdesc AS CHAR FORMAT "X(30)".

DEF VAR nv_connects AS CHAR FORMAT "X(255)".
DEF VAR nv_logname AS CHAR FORMAT "X(255)".

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE DIALOG-BOX
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME Dialog-Frame

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-93 RECT-95 rect10 fi_br fi_user ~
fi_passwd Btn_OK Btn_Cancel fi_brdesc 
&Scoped-Define DISPLAYED-OBJECTS fi_br fi_user fi_passwd fi_brdesc 

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

DEFINE VARIABLE fi_br AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 7 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_brdesc AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 22 BY .81
     BGCOLOR 19  NO-UNDO.

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
     fi_br AT ROW 3.05 COL 19 COLON-ALIGNED NO-LABEL WIDGET-ID 4
     fi_user AT ROW 4.19 COL 19 COLON-ALIGNED NO-LABEL
     fi_passwd AT ROW 5.38 COL 19 COLON-ALIGNED NO-LABEL BLANK 
     Btn_OK AT ROW 7.24 COL 15
     Btn_Cancel AT ROW 7.24 COL 27.5
     fi_brdesc AT ROW 3.14 COL 27.5 COLON-ALIGNED NO-LABEL WIDGET-ID 2
     "Branch" VIEW-AS TEXT
          SIZE 7 BY .95 AT ROW 3.1 COL 12.17 WIDGET-ID 6
          BGCOLOR 19 FONT 6
     "User Name" VIEW-AS TEXT
          SIZE 11.5 BY .57 AT ROW 4.43 COL 8.5
          BGCOLOR 19 
     "Password" VIEW-AS TEXT
          SIZE 10.5 BY .57 AT ROW 5.67 COL 9.5
          BGCOLOR 19 
     " LOGIN >> TAX - BRANCH" VIEW-AS TEXT
          SIZE 28.83 BY .81 AT ROW 1.67 COL 1.67
          BGCOLOR 4 FGCOLOR 7 
     RECT-93 AT ROW 2.91 COL 1.5
     RECT-95 AT ROW 6.76 COL 1.5
     rect10 AT ROW 1.24 COL 1.5
     SPACE(0.00) SKIP(6.13)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         FONT 6
         TITLE "Login TAX -  BR System <wacconbr.w>".


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
   FRAME-NAME                                                           */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Login TAX -  BR System <wacconbr.w> */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Cancel Dialog-Frame
ON CHOOSE OF Btn_Cancel IN FRAME Dialog-Frame /* Cancel */
DO:
  ASSIGN  n_txbrusr  =  ""          
          n_txbrpwd  =  "" 
          n_status   =  No.

  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK Dialog-Frame
ON CHOOSE OF Btn_OK IN FRAME Dialog-Frame /* OK */
DO: 
   
     ASSIGN n_txbrusr = INPUT  fi_user
            n_txbrpwd = INPUT  fi_passwd
            n_status  = YES.

    /* IF CONNECTED ("transfer") THEN DISCONNECT transfer.*/
     
     IF n_txbrusr = "" AND n_txbrpwd = "" THEN MESSAGE "Database Transfer Not Connect" VIEW-AS ALERT-BOX.
     ELSE DO:
         
          /*--For Production ---
          CONNECT bran_off -H alpha4 -S transfer -N tcp /*-U value(n_glbrusr) -P value(n_glbrpwd)*/
                   -cpinternal 620-2533 -cpstream 620-2533 NO-ERROR. 
         ---------------*/

          /*--For TEST ---
         CONNECT bran_off -H 16.90.55.11 -S transfer -N tcp /*-U value(n_glbrusr) -P value(n_glbrpwd)*/
         -cpinternal 620-2533 -cpstream 620-2533 NO-ERROR. 
           ------*/
         
         IF CONNECTED ("brstat") THEN DO:
            DISCONNECT brstat.
         END.
          
         
         FIND FIRST db_bran WHERE db_bran.branch  = nv_br AND db_bran.phy_name = "Stat" NO-LOCK NO-ERROR.        
         IF NOT AVAIL db_bran THEN DO:
            IF LOCKED db_bran THEN DO:
               MESSAGE " Record is being used " VIEW-AS ALERT-BOX WARNING.
            END.
         END.
         ELSE DO:  
            
             
            /*----- For Production --------*/
            ASSIGN  nv_connects = " -db " + TRIM(db_bran.phy_name) + " " + TRIM(db_bran.oth_para) + " -ld " + TRIM(db_bran.log_name)
                    nv_logname  = TRIM(db_bran.phy_name).
                     
            CONNECT VALUE(nv_connects) -U value(n_txbrusr) -P value(n_txbrpwd) NO-ERROR. 
            /*--------------*/
             /*---For Test---
             CONNECT stat -ld brstat -H 16.90.55.1 -S stattest -N tcp /*-U value(n_glbrusr) -P value(n_glbrpwd)*/
            -cpinternal 620-2533 -cpstream 620-2533 NO-ERROR.
             ------------------*/
       END.

       IF CONNECTED ("brstat") THEN DO:
          MESSAGE "Connected Tax Branch: " n_brdesc VIEW-AS ALERT-BOX.
       END.
       ELSE DO:
          MESSAGE  "Not Connected Tax Branch: " n_brdesc  VIEW-AS ALERT-BOX.
       END.

     END.
     
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_br
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_br Dialog-Frame
ON LEAVE OF fi_br IN FRAME Dialog-Frame
DO:
  fi_br = INPUT fi_br.

  ASSIGN  nv_Br = fi_br + "s"
           n_br = fi_br.
               

  RUN pd_brndesc.

  DISP fi_br fi_brdesc  WITH FRAME {&FRAME-NAME}. 


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_user
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_user Dialog-Frame
ON LEAVE OF fi_user IN FRAME Dialog-Frame
DO:
  fi_user = INPUT fi_user.
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
  
  SESSION:DATA-ENTRY-RETURN = YES.

  fi_brdesc = "".
  
  IF LENGTH(n_user) = 6 THEN ASSIGN nv_Br = SUBSTR(n_user,6,1) + "s"
                                    n_br  = SUBSTR(n_user,6,1)
                                    fi_br = n_br.

  ELSE ASSIGN  nv_Br = SUBSTR(n_user,6,2) + "s"
               n_br = SUBSTR(n_user,6,2)
               fi_br = n_br.

  RUN pd_brndesc.

  DISP fi_br fi_brdesc  WITH FRAME {&FRAME-NAME}. 

 /* DISP fi_brdesc . */


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
  DISPLAY fi_br fi_user fi_passwd fi_brdesc 
      WITH FRAME Dialog-Frame.
  ENABLE RECT-93 RECT-95 rect10 fi_br fi_user fi_passwd Btn_OK Btn_Cancel 
         fi_brdesc 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_brndesc Dialog-Frame 
PROCEDURE pd_brndesc :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND FIRST xmm023 USE-INDEX  xmm02301 
     WHERE xmm023.branch = n_br  NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL xmm023 THEN  DO:
    ASSIGN fi_brdesc = xmm023.bdes
           n_brdesc  = xmm023.bdes.
    IF xmm023.branch = "0"  THEN ASSIGN fi_brdesc = "Head Office"
                                        n_brdesc = "Head Office".
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

