&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          brstat           PROGRESS
*/
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

  Created: By Narin A57-0263
          -  Copy Write จาก WHPPOLMA.W เป็น WGWHMPOL.W

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


  Def  Input  parameter       nv_type     as  char.
  Def  Input-output  parameter  nv_policy1 as  char.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME frame_a
&Scoped-define BROWSE-NAME br_policy

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES polmst_fil

/* Definitions for BROWSE br_policy                                     */
&Scoped-define FIELDS-IN-QUERY-br_policy polmst_fil.policy polmst_fil.name1 ~
string(polmst_fil.rencnt,"999") + "/" + string(polmst_fil.endcnt,"999") ~
polmst_fil.polsta polmst_fil.trndat polmst_fil.releas 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_policy 
&Scoped-define QUERY-STRING-br_policy FOR EACH polmst_fil NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br_policy OPEN QUERY br_policy FOR EACH polmst_fil NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br_policy polmst_fil
&Scoped-define FIRST-TABLE-IN-QUERY-br_policy polmst_fil


/* Definitions for FRAME frame_a                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS ra_search fi_search br_policy bu_exit RECT-6 ~
RECT-8 RECT-97 
&Scoped-Define DISPLAYED-OBJECTS ra_search fi_search 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_exit 
     LABEL "Exit" 
     SIZE 9 BY 1.29
     FONT 6.

DEFINE VARIABLE fi_search AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 30.5 BY 1.05
     BGCOLOR 15 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE ra_search AS INTEGER INITIAL 1 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Policy", 1,
"Name", 2
     SIZE 14 BY 2.1
     BGCOLOR 8 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 126 BY 22.95
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-8
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 105.5 BY 4.71
     BGCOLOR 8 FGCOLOR 1 .

DEFINE RECTANGLE RECT-97
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 11 BY 1.81
     BGCOLOR 1 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_policy FOR 
      polmst_fil SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_policy
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_policy C-Win _STRUCTURED
  QUERY br_policy NO-LOCK DISPLAY
      polmst_fil.policy FORMAT "x(16)":U
      polmst_fil.name1 COLUMN-LABEL "Name of Insured" FORMAT "x(50)":U
      string(polmst_fil.rencnt,"999") + "/" + string(polmst_fil.endcnt,"999") COLUMN-LABEL "R/E"
      polmst_fil.polsta COLUMN-LABEL "Pol. Status" FORMAT "x(2)":U
            WIDTH 10
      polmst_fil.trndat COLUMN-LABEL "Trn. Date" FORMAT "99/99/9999":U
      polmst_fil.releas COLUMN-LABEL "Rel." FORMAT "yes/no":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 120 BY 15.91
         BGCOLOR 15 FONT 6
         TITLE BGCOLOR 15 "Policy  Detail".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME frame_a
     ra_search AT ROW 3.62 COL 45.5 NO-LABEL
     fi_search AT ROW 4.14 COL 61.5 COLON-ALIGNED NO-LABEL
     br_policy AT ROW 7.67 COL 7.5
     bu_exit AT ROW 3.86 COL 108.5
     "Search  By  :" VIEW-AS TEXT
          SIZE 15.5 BY 1.05 AT ROW 3.62 COL 26
          BGCOLOR 8 FGCOLOR 1 FONT 2
     RECT-6 AT ROW 1.52 COL 4.5
     RECT-8 AT ROW 2.29 COL 14.5
     RECT-97 AT ROW 3.62 COL 107.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133.33 BY 24.04
         BGCOLOR 8 .


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
         TITLE              = ""
         HEIGHT             = 24.05
         WIDTH              = 133.33
         MAX-HEIGHT         = 31.33
         MAX-WIDTH          = 170.67
         VIRTUAL-HEIGHT     = 31.33
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

&IF '{&WINDOW-SYSTEM}' NE 'TTY' &THEN
IF NOT C-Win:LOAD-ICON("Wimage\safety":U) THEN
    MESSAGE "Unable to load icon: Wimage\safety"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME frame_a
   FRAME-NAME Custom                                                    */
/* BROWSE-TAB br_policy fi_search frame_a */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_policy
/* Query rebuild information for BROWSE br_policy
     _TblList          = "brstat.polmst_fil"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   = brstat.polmst_fil.policy
     _FldNameList[2]   > brstat.polmst_fil.name1
"polmst_fil.name1" "Name of Insured" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > "_<CALC>"
"string(polmst_fil.rencnt,""999"") + ""/"" + string(polmst_fil.endcnt,""999"")" "R/E" ? ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > brstat.polmst_fil.polsta
"polmst_fil.polsta" "Pol. Status" ? "character" ? ? ? ? ? ? no ? no no "10" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > brstat.polmst_fil.trndat
"polmst_fil.trndat" "Trn. Date" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > brstat.polmst_fil.releas
"polmst_fil.releas" "Rel." ? "logical" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE br_policy */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_policy
&Scoped-define SELF-NAME br_policy
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_policy C-Win
ON ENTER OF br_policy IN FRAME frame_a /* Policy  Detail */
DO:
   Get  current  br_policy.
   nv_policy1  =  polmst_fil.policy.
 
   Apply  "choose" to   bu_exit.
   Return no-apply.    
 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_policy C-Win
ON MOUSE-SELECT-DBLCLICK OF br_policy IN FRAME frame_a /* Policy  Detail */
DO:
  /*
  Get  first  br_policy.
      nv_policy1  =  polmst_fil.policy.
  
  Apply  "choose" to   bu_exit.
  Return no-apply.    
  */
  Apply "Enter"  to  br_policy.
      
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit C-Win
ON CHOOSE OF bu_exit IN FRAME frame_a /* Exit */
DO:
  Apply  "close"  to this-procedure.
  Return no-apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_search
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_search C-Win
ON LEAVE OF fi_search IN FRAME frame_a
DO:

 Do  with frame  frame_a.
        fi_search  =  input  fi_search.
        Disp  fi_search  with frame frame_a.

        If  ra_search  =  1  Then do:
            Open Query  br_policy For Each  polmst_fil  Use-index  polmst01  Where
                  polmst_fil.policy  >=   fi_search  and
                  polmst_fil.poltyp  =     nv_type    No-Lock.  
        End. 
        
        Else  do:
             Open Query  br_policy  For Each  polmst_Fil  Use-index polmst05 Where
                  polmst_fil.name1  >= fi_search  and
                  polmst_fil.poltyp   =   nv_type    No-Lock.  
        End.
   End.     

   Apply  "Entry"  to  br_policy.
   Return no-apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_search
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_search C-Win
ON VALUE-CHANGED OF ra_search IN FRAME frame_a
DO:
    ra_search  =  Input  ra_search.
    Disp  ra_search  with frame  frame_a.
    
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
  
  RECT-8:MOVE-TO-TOP().
  RECT-97:MOVE-TO-TOP().
  
  DEF  VAR  gv_prgid   AS   CHAR.
  DEF  VAR  gv_prog    AS   CHAR.
  
  gv_prgid = "WGWHMPOL".
  gv_prog  = "Help  Search policy marine".
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).

  
  SESSION:DATA-ENTRY-RETURN = YES.


  Open Query  br_policy For Each  polmst_fil  Use-index  polmst01   where
                        polmst_fil.poltyp  =   nv_type and
                        polmst_fil.policy  begins "D"  no-lock.



  
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
  DISPLAY ra_search fi_search 
      WITH FRAME frame_a IN WINDOW C-Win.
  ENABLE ra_search fi_search br_policy bu_exit RECT-6 RECT-8 RECT-97 
      WITH FRAME frame_a IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frame_a}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

