&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
*/
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
------------------------------------------------------------------------*/
/*          This .W file was created with the Progress AppBuilder.       */
/*----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */
Def TEMP-TABLE Wk_uwd132 
     Field    wk_bencod     As    Char
     Field    wk_bensht     As    Char
     Field    wk_nap        As    Deci     
     Field    wk_gapae      As    Char
     Field    wk_gap        As    Deci
     Field    wk_benvar     As    Char
     Field    wk_pdaep      As    Char
     Field    wk_prem_c     As    DECI.

DEFINE INPUT PARAMETER TABLE FOR Wk_uwd132 .
DEF VAR n_color AS INTE .

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Dialog-Box
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME Dialog-Frame
&Scoped-define BROWSE-NAME br_uwd132

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES wk_uwd132

/* Definitions for BROWSE br_uwd132                                     */
&Scoped-define FIELDS-IN-QUERY-br_uwd132 wk_bencod wk_bensht wk_nap wk_gapae wk_gap //wk_benvar //wk_pdaep //wk_prem_c   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_uwd132   
&Scoped-define SELF-NAME br_uwd132
&Scoped-define QUERY-STRING-br_uwd132 FOR EACH wk_uwd132 WHERE wk_uwd132.wk_benvar = "new" No-Lock
&Scoped-define OPEN-QUERY-br_uwd132 OPEN QUERY br_uwd132  FOR EACH wk_uwd132 WHERE wk_uwd132.wk_benvar = "new" No-Lock .
&Scoped-define TABLES-IN-QUERY-br_uwd132 wk_uwd132
&Scoped-define FIRST-TABLE-IN-QUERY-br_uwd132 wk_uwd132


/* Definitions for BROWSE br_uwd132old                                  */
&Scoped-define FIELDS-IN-QUERY-br_uwd132old wk_bencod wk_bensht wk_nap wk_gapae wk_gap //wk_benvar //wk_pdaep //wk_prem_c   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_uwd132old   
&Scoped-define SELF-NAME br_uwd132old
&Scoped-define QUERY-STRING-br_uwd132old FOR EACH wk_uwd132 WHERE wk_uwd132.wk_benvar = "old" No-Lock
&Scoped-define OPEN-QUERY-br_uwd132old OPEN QUERY br_uwd132  FOR EACH wk_uwd132 WHERE wk_uwd132.wk_benvar = "old" No-Lock .
&Scoped-define TABLES-IN-QUERY-br_uwd132old wk_uwd132
&Scoped-define FIRST-TABLE-IN-QUERY-br_uwd132old wk_uwd132


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-br_uwd132}~
    ~{&OPEN-QUERY-br_uwd132old}

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON BUTTON-20 AUTO-END-KEY 
     LABEL "Exit" 
     SIZE 15 BY 1.43
     FONT 6.

DEFINE RECTANGLE RECT-229
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 73.5 BY 16.71
     BGCOLOR 20 .

DEFINE RECTANGLE RECT-230
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 73.5 BY 16.71
     BGCOLOR 20 .

DEFINE RECTANGLE RECT-231
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 147 BY 2.14
     BGCOLOR 20 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_uwd132 FOR 
      wk_uwd132 SCROLLING.

DEFINE QUERY br_uwd132old FOR 
      wk_uwd132 SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_uwd132
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_uwd132 Dialog-Frame _FREEFORM
  QUERY br_uwd132 DISPLAY
      wk_bencod    Format  "x(5) "   LABEL "Bencod"
wk_bensht    Format  "x(33) "  LABEL ""
wk_nap       Format  ">,>>>,>>9.99-"   LABEL "NAP"
wk_gapae     Format  "x(1) "  LABEL ""
wk_gap       Format  ">,>>>,>>9.99-"   LABEL "GAP"
//wk_benvar     Format  "x(30) "  LABEL ""
//wk_pdaep     Format  "x(1) "  LABEL ""
//wk_prem_c    Format  ">,>>>,>>9.99-"   LABEL "PD"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 71 BY 14.33
         BGCOLOR 15 FGCOLOR 0  ROW-HEIGHT-CHARS .5.

DEFINE BROWSE br_uwd132old
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_uwd132old Dialog-Frame _FREEFORM
  QUERY br_uwd132old DISPLAY
      wk_bencod    Format  "x(5) "   LABEL "Bencod"
wk_bensht     Format  "x(33) "  LABEL ""
wk_nap          Format  ">,>>>,>>9.99-"   LABEL "NAP"
wk_gapae     Format  "x(1) "  LABEL ""
wk_gap          Format  ">,>>>,>>9.99-"   LABEL "GAP"
//wk_benvar     Format  "x(30) "  LABEL ""
//wk_pdaep     Format  "x(1) "  LABEL ""
//wk_prem_c    Format  ">,>>>,>>9.99-"   LABEL "PD"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 71 BY 14.33
         BGCOLOR 15 FGCOLOR 0  ROW-HEIGHT-CHARS .5.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     SPACE(148.53) SKIP(19.08)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Check Premium insurance" WIDGET-ID 100.

DEFINE FRAME DEFAULT-FRAME
     BUTTON-20 AT ROW 1.62 COL 131.5
     br_uwd132 AT ROW 5.05 COL 2.67
     br_uwd132old AT ROW 5.05 COL 76.5 WIDGET-ID 100
     "Check Premium Old-New" VIEW-AS TEXT
          SIZE 39 BY 1.19 AT ROW 1.71 COL 7 WIDGET-ID 12
          BGCOLOR 20 FGCOLOR 2 FONT 2
     "New Premium" VIEW-AS TEXT
          SIZE 15.67 BY 1.19 AT ROW 3.57 COL 28.33 WIDGET-ID 2
          BGCOLOR 20 FGCOLOR 2 FONT 2
     "Old Premium" VIEW-AS TEXT
          SIZE 15 BY 1.19 AT ROW 3.62 COL 101.5 WIDGET-ID 4
          BGCOLOR 20 FGCOLOR 2 FONT 2
     RECT-229 AT ROW 3.14 COL 1.5
     RECT-230 AT ROW 3.14 COL 75 WIDGET-ID 6
     RECT-231 AT ROW 1.24 COL 1.5 WIDGET-ID 8
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 148.5 BY 19.05
         BGCOLOR 53 FGCOLOR 15  WIDGET-ID 200.


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
/* REPARENT FRAME */
ASSIGN FRAME DEFAULT-FRAME:FRAME = FRAME Dialog-Frame:HANDLE.

/* SETTINGS FOR FRAME DEFAULT-FRAME
                                                                        */
/* BROWSE-TAB br_uwd132 BUTTON-20 DEFAULT-FRAME */
/* BROWSE-TAB br_uwd132old br_uwd132 DEFAULT-FRAME */
/* SETTINGS FOR DIALOG-BOX Dialog-Frame
   FRAME-NAME                                                           */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_uwd132
/* Query rebuild information for BROWSE br_uwd132
     _START_FREEFORM
OPEN QUERY br_uwd132  FOR EACH wk_uwd132 WHERE wk_uwd132.wk_benvar = "new" No-Lock .
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE br_uwd132 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_uwd132old
/* Query rebuild information for BROWSE br_uwd132old
     _START_FREEFORM
OPEN QUERY br_uwd132  FOR EACH wk_uwd132 WHERE wk_uwd132.wk_benvar = "old" No-Lock .
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE br_uwd132old */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Check Premium insurance */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_uwd132
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define SELF-NAME br_uwd132
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_uwd132 Dialog-Frame
ON ROW-DISPLAY OF br_uwd132 IN FRAME DEFAULT-FRAME
DO:
    IF wk_uwd132.wk_bencod = "" THEN n_color = 15.
    ELSE n_color = 10.

    wk_uwd132.wk_bencod:BGCOLOR IN BROWSE  br_uwd132   = n_color .
    wk_uwd132.wk_nap:BGCOLOR IN BROWSE     br_uwd132   = n_color.
    wk_uwd132.wk_gapae:BGCOLOR IN BROWSE   br_uwd132   = n_color.
    wk_uwd132.wk_gap:BGCOLOR IN BROWSE     br_uwd132   = n_color.
    IF wk_uwd132.wk_bensht BEGINS "Total" THEN DO: 
        wk_uwd132.wk_bencod:BGCOLOR IN BROWSE  br_uwd132   = 11.
        wk_uwd132.wk_nap:BGCOLOR IN BROWSE     br_uwd132   = 11. 
        wk_uwd132.wk_gapae:BGCOLOR IN BROWSE   br_uwd132   = 11. 
        wk_uwd132.wk_gap:BGCOLOR IN BROWSE     br_uwd132   = 11. 
        wk_uwd132.wk_bensht:BGCOLOR IN BROWSE  br_uwd132  = 11. 
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_uwd132old
&Scoped-define SELF-NAME br_uwd132old
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_uwd132old Dialog-Frame
ON ROW-DISPLAY OF br_uwd132old IN FRAME DEFAULT-FRAME
DO:
    IF wk_uwd132.wk_bencod = "" THEN n_color = 15.
    ELSE n_color = 10.

    wk_uwd132.wk_bencod:BGCOLOR IN BROWSE  br_uwd132old   = n_color .
    wk_uwd132.wk_nap:BGCOLOR IN BROWSE     br_uwd132old   = n_color.
    wk_uwd132.wk_gapae:BGCOLOR IN BROWSE   br_uwd132old   = n_color.
    wk_uwd132.wk_gap:BGCOLOR IN BROWSE     br_uwd132old   = n_color.
    IF wk_uwd132.wk_bensht BEGINS "Total" THEN DO: 
        wk_uwd132.wk_bencod:BGCOLOR IN BROWSE  br_uwd132old   = 11.
        wk_uwd132.wk_nap:BGCOLOR IN BROWSE     br_uwd132old   = 11. 
        wk_uwd132.wk_gapae:BGCOLOR IN BROWSE   br_uwd132old   = 11. 
        wk_uwd132.wk_gap:BGCOLOR IN BROWSE     br_uwd132old   = 11. 
        wk_uwd132.wk_bensht:BGCOLOR IN BROWSE     br_uwd132old   = 11.  
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-20
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-20 Dialog-Frame
ON CHOOSE OF BUTTON-20 IN FRAME DEFAULT-FRAME /* Exit */
DO:
      Apply "Close" To This-Procedure.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME Dialog-Frame
&Scoped-define BROWSE-NAME br_uwd132
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
    
  n_color = 10.
  Open Query br_uwd132  For Each wk_uwd132 WHERE wk_uwd132.wk_benvar = "new" No-Lock.
  wk_uwd132.wk_bencod:COLUMN-BGCOLOR IN BROWSE br_uwd132   = n_color .
  wk_uwd132.wk_nap:COLUMN-BGCOLOR    IN BROWSE br_uwd132   = n_color.
  wk_uwd132.wk_gapae:COLUMN-BGCOLOR  IN BROWSE br_uwd132   = n_color.
  wk_uwd132.wk_gap:COLUMN-BGCOLOR    IN BROWSE br_uwd132   = n_color.


  Open Query br_uwd132old  For Each wk_uwd132 WHERE wk_uwd132.wk_benvar = "old" No-Lock.
  wk_uwd132.wk_bencod:COLUMN-BGCOLOR IN BROWSE br_uwd132   = n_color .
  wk_uwd132.wk_nap:COLUMN-BGCOLOR    IN BROWSE br_uwd132   = n_color.
  wk_uwd132.wk_gapae:COLUMN-BGCOLOR  IN BROWSE br_uwd132   = n_color.
  wk_uwd132.wk_gap:COLUMN-BGCOLOR    IN BROWSE br_uwd132   = n_color.
  
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
  HIDE FRAME DEFAULT-FRAME.
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
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
  ENABLE RECT-229 RECT-230 RECT-231 BUTTON-20 br_uwd132 br_uwd132old 
      WITH FRAME DEFAULT-FRAME.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

