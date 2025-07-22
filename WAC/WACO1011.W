&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          stat             PROGRESS
*/
&Scoped-define WINDOW-NAME Win-waco1011
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS Win-waco1011 
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
/*          This .W file was created with the Progress UIB.             */
/*----------------------------------------------------------------------*/

/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */

CREATE WIDGET-POOL.

/* ***************************  Definitions  ************************** */

/* Local Variable Definitions ---                                       */

DEFINE INPUT PARAMETER s_fptr01   AS RECID NO-UNDO.

DEFINE WORKFILE Wacd001 NO-UNDO     
    FIELD ctype      LIKE acd001.ctype   
    FIELD ctrty1     LIKE acd001.ctrty1  
    FIELD cdocno     LIKE acd001.cdocno FORMAT "X(10)" /* Benjaporn J. A60-0267 date 27/06/2017 */  
    FIELD cjono      LIKE acd001.cjono   
    FIELD cjodat     LIKE acd001.cjodat    
    FIELD netamt     LIKE acd001.netamt  
    FIELD usrid      LIKE acd001.usrid  
    FIELD entdat     LIKE acd001.entdat     
    FIELD prog       LIKE acd001.prog.   
    
DEFINE  VAR n_fptr    AS RECID.
DEFINE  VAR n_match   LIKE acd001.netamt.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_ptext
&Scoped-define BROWSE-NAME br_macc

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Wacd001

/* Definitions for BROWSE br_macc                                       */
&Scoped-define FIELDS-IN-QUERY-br_macc Wacd001.ctype Wacd001.ctrty1 Wacd001.cdocno /* A60-0267 */ Wacd001.cjono /* A60-0267 */ Wacd001.cjodat Wacd001.netamt Wacd001.usrid Wacd001.entdat Wacd001.prog   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_macc   
&Scoped-define SELF-NAME br_macc
&Scoped-define QUERY-STRING-br_macc FOR EACH Wacd001
&Scoped-define OPEN-QUERY-br_macc OPEN QUERY {&SELF-NAME} FOR EACH Wacd001.
&Scoped-define TABLES-IN-QUERY-br_macc Wacd001
&Scoped-define FIRST-TABLE-IN-QUERY-br_macc Wacd001


/* Definitions for FRAME fr_ptext                                       */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS br_macc bu_exit fi_text RECT-15 RECT-16 ~
RECT-190 
&Scoped-Define DISPLAYED-OBJECTS fi_text 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR Win-waco1011 AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_exit 
     LABEL "<< Back" 
     SIZE 12.5 BY 1.14
     FGCOLOR 0 FONT 6.

DEFINE VARIABLE fi_text AS CHARACTER FORMAT "X(256)":U INITIAL "  MATCHED RECORDS DETAIL" 
      VIEW-AS TEXT 
     SIZE 112.5 BY 1.29
     BGCOLOR 3 FGCOLOR 15 FONT 2 NO-UNDO.

DEFINE RECTANGLE RECT-15
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 130.5 BY 23.48
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-16
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 115.5 BY 1.81
     BGCOLOR 1 FGCOLOR 1 .

DEFINE RECTANGLE RECT-190
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 14.5 BY 1.67
     BGCOLOR 1 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_macc FOR 
      Wacd001 SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_macc
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_macc Win-waco1011 _FREEFORM
  QUERY br_macc NO-LOCK DISPLAY
      Wacd001.ctype       COLUMN-LABEL "Type"
      Wacd001.ctrty1      COLUMN-LABEL "Trn.Typ"
      Wacd001.cdocno FORMAT "X(12)" /* A60-0267 */   COLUMN-LABEL "   Doc. No.  "
      Wacd001.cjono  FORMAT "X(12)" /* A60-0267 */   COLUMN-LABEL "  Journal No.  "
      Wacd001.cjodat      COLUMN-LABEL " Contra. Date "
      Wacd001.netamt      COLUMN-LABEL "Amt matched      "
      Wacd001.usrid       COLUMN-LABEL " User Id "
      Wacd001.entdat      COLUMN-LABEL " Enter Date "
      Wacd001.prog        COLUMN-LABEL "    Prog. "  Format "x(8)"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 115 BY 16.95
         BGCOLOR 15 FONT 6.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_ptext
     br_macc AT ROW 4.38 COL 9.5
     bu_exit AT ROW 22.38 COL 111.17
     fi_text AT ROW 2.05 COL 9 COLON-ALIGNED NO-LABEL
     RECT-15 AT ROW 1.24 COL 2
     RECT-16 AT ROW 1.76 COL 9.5
     RECT-190 AT ROW 22.14 COL 110
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 132.67 BY 24.04
         BGCOLOR 3 .


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
  CREATE WINDOW Win-waco1011 ASSIGN
         HIDDEN             = YES
         TITLE              = "Waco1011 : Matched Records Datail"
         HEIGHT             = 24.05
         WIDTH              = 133.33
         MAX-HEIGHT         = 24.05
         MAX-WIDTH          = 133.33
         VIRTUAL-HEIGHT     = 24.05
         VIRTUAL-WIDTH      = 133.33
         RESIZE             = no
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
IF NOT Win-waco1011:LOAD-ICON("WIMAGE\safety":U) THEN
    MESSAGE "Unable to load icon: WIMAGE\safety"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW Win-waco1011
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fr_ptext
   FRAME-NAME Custom                                                    */
/* BROWSE-TAB br_macc 1 fr_ptext */
ASSIGN 
       fi_text:RESIZABLE IN FRAME fr_ptext        = TRUE.

ASSIGN 
       RECT-16:HIDDEN IN FRAME fr_ptext           = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(Win-waco1011)
THEN Win-waco1011:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_macc
/* Query rebuild information for BROWSE br_macc
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH Wacd001.
     _END_FREEFORM
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Query            is NOT OPENED
*/  /* BROWSE br_macc */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Win-waco1011
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Win-waco1011 Win-waco1011
ON END-ERROR OF Win-waco1011 /* Waco1011 : Matched Records Datail */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Win-waco1011 Win-waco1011
ON WINDOW-CLOSE OF Win-waco1011 /* Waco1011 : Matched Records Datail */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit Win-waco1011
ON CHOOSE OF bu_exit IN FRAME fr_ptext /* << Back */
DO:
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_macc
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK Win-waco1011 


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
  DEF  VAR  gv_prgid   AS   CHAR  FORMAT "X(8)"   NO-UNDO.
  DEF  VAR  gv_prog    AS   CHAR  FORMAT "X(40)" NO-UNDO.
  
  gv_prgid = "waco1011".
  gv_prog  = "Matched Records Detail".
  RUN  WUT\WUTHEAD (Win-waco1011:handle,gv_prgid,gv_prog).
  RUN  WUT\WUTWICEN (Win-waco1011:handle). 

/*********************************************************************/     
RUN  Check_Acc.
                                  
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
       WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Check_Acc Win-waco1011 
PROCEDURE Check_Acc :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
n_fptr = s_fptr01.

      REPEAT WHILE n_fptr <> 0 .
         FIND  acd001 Where Recid(acd001) = n_fptr.
         IF NOT AVAIL acd001 Then Leave.
         n_match = - acd001.netamt.
         CREATE  Wacd001.
         ASSIGN 
                Wacd001.ctype  = acd001.ctype 
                Wacd001.ctrty1 = acd001.ctrty1 
                Wacd001.cdocno = acd001.cdocno
                Wacd001.cjono  = acd001.cjono
                Wacd001.cjodat = acd001.cjodat 
                Wacd001.netamt = n_match 
                Wacd001.usrid  = acd001.usrid 
                Wacd001.entdat = acd001.entdat 
                Wacd001.prog   = acd001.prog.
         n_fptr = acd001.fptr.
      END.

OPEN  QUERY   br_macc FOR EACH  Wacd001 NO-LOCK . 

DELETE  Wacd001.
       
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI Win-waco1011  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(Win-waco1011)
  THEN DELETE WIDGET Win-waco1011.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI Win-waco1011  _DEFAULT-ENABLE
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
  DISPLAY fi_text 
      WITH FRAME fr_ptext IN WINDOW Win-waco1011.
  ENABLE br_macc bu_exit fi_text RECT-15 RECT-16 RECT-190 
      WITH FRAME fr_ptext IN WINDOW Win-waco1011.
  {&OPEN-BROWSERS-IN-QUERY-fr_ptext}
  VIEW Win-waco1011.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

