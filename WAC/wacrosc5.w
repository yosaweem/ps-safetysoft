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


DEF VAR nv_jvdat  AS DATE FORMAT "99/99/9999".
DEF VAR nv_source AS CHAR FORMAT "x(2)".

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME frmain

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS recOutput-5 recOutput-6 RecOK-3 RecOK-4 ~
fi_jvdat fi_source bu_delete bu_cancel 
&Scoped-Define DISPLAYED-OBJECTS fi_jvdat fi_source 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_cancel 
     LABEL "CANCEL" 
     SIZE 15 BY 1.52
     FONT 2.

DEFINE BUTTON bu_delete 
     LABEL "DELETE" 
     SIZE 15 BY 1.52
     FONT 2.

DEFINE VARIABLE fi_jvdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_source AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE RECTANGLE RecOK-3
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 16.5 BY 1.91
     BGCOLOR 1 .

DEFINE RECTANGLE RecOK-4
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 16.5 BY 1.91
     BGCOLOR 1 .

DEFINE RECTANGLE recOutput-5
     EDGE-PIXELS 4 GRAPHIC-EDGE    
     SIZE 40 BY 1.81
     BGCOLOR 8 .

DEFINE RECTANGLE recOutput-6
     EDGE-PIXELS 4 GRAPHIC-EDGE    
     SIZE 40 BY 2.81
     BGCOLOR 8 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME frmain
     fi_jvdat AT ROW 4.67 COL 29.5 COLON-ALIGNED NO-LABEL 
     fi_source AT ROW 6.62 COL 29.5 COLON-ALIGNED NO-LABEL 
     bu_delete AT ROW 9.81 COL 12.33 
     bu_cancel AT ROW 9.81 COL 35.67 
     "C6 = direct , C7 = RI" VIEW-AS TEXT
          SIZE 29.5 BY .62 AT ROW 7.81 COL 17.33 
          BGCOLOR 8 FGCOLOR 1 FONT 2
     "SOURCE   :" VIEW-AS TEXT
          SIZE 13.5 BY .62 AT ROW 6.76 COL 14.5 
          BGCOLOR 8 FONT 2
     "             DELETE JV O/S CLAIM" VIEW-AS TEXT
          SIZE 60 BY 1.52 AT ROW 1.71 COL 1 
          BGCOLOR 1 FGCOLOR 7 FONT 2
     "JV DATE  :" VIEW-AS TEXT
          SIZE 15 BY .62 AT ROW 4.86 COL 14.5 
          BGCOLOR 8 FONT 2
     recOutput-5 AT ROW 4.24 COL 11.33 
     recOutput-6 AT ROW 6.05 COL 11.33 
     RecOK-3 AT ROW 9.62 COL 11.5 
     RecOK-4 AT ROW 9.62 COL 34.83 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 60.33 BY 11.24
         BGCOLOR 3  .


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
         HEIGHT             = 11.24
         WIDTH              = 60.33
         MAX-HEIGHT         = 16
         MAX-WIDTH          = 92.17
         VIRTUAL-HEIGHT     = 16
         VIRTUAL-WIDTH      = 92.17
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
/* SETTINGS FOR FRAME frmain
                                                                        */
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


&Scoped-define SELF-NAME bu_cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_cancel C-Win
ON CHOOSE OF bu_cancel IN FRAME frmain /* CANCEL */
DO:

  APPLY "CLOSE" TO THIS-PROCEDURE.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_delete
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_delete C-Win
ON CHOOSE OF bu_delete IN FRAME frmain /* DELETE */
DO:

    IF nv_jvdat = ? THEN DO:
       MESSAGE "** Please Enter JV Date ** " VIEW-AS ALERT-BOX.
       APPLY "ENTRY" TO fi_jvdat IN FRAM frmain.
       RETURN NO-APPLY.
    END.
    
    IF nv_source  = ""  THEN DO:
       MESSAGE "** Please Enter Source ** " VIEW-AS ALERT-BOX.
       APPLY "ENTRY" TO fi_source IN FRAM frmain.
       RETURN NO-APPLY.
    END. 

    IF nv_source <> "C6"  AND
       nv_source <> "C7"  THEN DO:
       MESSAGE "** Please Check Source **" VIEW-AS ALERT-BOX.
       APPLY "ENTRY" TO fi_source IN FRAM frmain.
       RETURN NO-APPLY.
    END.
    
  /* --------- end check data ----------- */ 
    
    FOR EACH azr516 USE-INDEX azr51601  WHERE 
             azr516.gldat   = nv_jvdat  AND
             azr516.source  = nv_source.       
              
          DELETE azr516.
    END.

    MESSAGE " .. Delete Complete .. " VIEW-AS ALERT-BOX.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_jvdat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_jvdat C-Win
ON LEAVE OF fi_jvdat IN FRAME frmain
DO:

    ASSIGN
  fi_jvdat = INPUT fi_jvdat
  nv_jvdat = fi_jvdat.

  DISP fi_jvdat WITH FRAM frmain.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_source
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_source C-Win
ON LEAVE OF fi_source IN FRAME frmain
DO:
    ASSIGN

  fi_source = CAPS(INPUT fi_source)
  nv_source = CAPS(fi_source).

  DISP fi_source WITH FRAM frmain .


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
  

  DEF VAR gv_prog AS CHAR FORMAT "x(30)".
  DEF VAR gv_prgid AS CHAR FORMAT "x(15)".

  gv_prgid = "WACROSC5".
  gv_prog  = "Delete JV O/S Claim".
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).


    SESSION:DATA-ENTRY-RETURN = YES.


  RUN enable_UI.
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
  DISPLAY fi_jvdat fi_source 
      WITH FRAME frmain IN WINDOW C-Win.
  ENABLE recOutput-5 recOutput-6 RecOK-3 RecOK-4 fi_jvdat fi_source bu_delete 
         bu_cancel 
      WITH FRAME frmain IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frmain}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

