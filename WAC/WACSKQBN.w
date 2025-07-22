&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          tid              PROGRESS
*/
&Scoped-define WINDOW-NAME WUWSKQBN
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS WUWSKQBN 
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
DEF INPUT PARAMETER nv_stknofr LIKE sckyear.sckno .
DEF INPUT PARAMETER nv_stknoto LIKE sckyear.sckno .
DEF INPUT PARAMETER nv_UserID  AS   CHARACTER FORMAT "X(30)" .
DEF INPUT PARAMETER nv_Branch  AS   CHARACTER FORMAT "X(150)" .

/* Local Variable Definitions ---                                       */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main
&Scoped-define BROWSE-NAME br_Disp

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES sckyear

/* Definitions for BROWSE br_Disp                                       */
&Scoped-define FIELDS-IN-QUERY-br_Disp sckyear.policy sckyear.sckno ~
sckyear.stat sckyear.trandat sckyear.flag sckyear.usrid 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_Disp 
&Scoped-define QUERY-STRING-br_Disp FOR EACH sckyear NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br_Disp OPEN QUERY br_Disp FOR EACH sckyear NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br_Disp sckyear
&Scoped-define FIRST-TABLE-IN-QUERY-br_Disp sckyear


/* Definitions for FRAME fr_main                                        */
&Scoped-define OPEN-BROWSERS-IN-QUERY-fr_main ~
    ~{&OPEN-QUERY-br_Disp}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-1 RECT-2 RECT-6 RECT-7 br_Disp ~
but_Search bu_Check cb_Search fi_Search fi_Branch fi_User 
&Scoped-Define DISPLAYED-OBJECTS cb_Search fi_Search fi_Branch fi_User 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR WUWSKQBN AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON but_Search 
     LABEL "SEARCH" 
     SIZE 15 BY 1.29
     FONT 6.

DEFINE BUTTON bu_Check 
     LABEL "===>" 
     SIZE 15 BY 1.29.

DEFINE VARIABLE cb_Search AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 6
     LIST-ITEMS "Policy No.","Sticker No." 
     DROP-DOWN-LIST
     SIZE 20.17 BY 1
     BGCOLOR 15 FONT 5 NO-UNDO.

DEFINE VARIABLE fi_Branch AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 32 BY 1
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_Search AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 31 BY 1.14
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_User AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 14 BY 1
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 122.5 BY 1.52
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 122.5 BY 1.57
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 122.5 BY 19.05
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 122.5 BY 2.14
     BGCOLOR 3 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_Disp FOR 
      sckyear SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_Disp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_Disp WUWSKQBN _STRUCTURED
  QUERY br_Disp NO-LOCK DISPLAY
      sckyear.policy FORMAT "x(16)":U
      sckyear.sckno FORMAT "x(15)":U
      sckyear.stat COLUMN-LABEL "Document No." FORMAT "x(10)":U
      sckyear.trandat FORMAT "99/99/9999":U WIDTH 15
      sckyear.flag COLUMN-LABEL "Document Type" FORMAT "x(2)":U
      sckyear.usrid FORMAT "x(8)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 119.5 BY 18.24
         BGCOLOR 15  ROW-HEIGHT-CHARS .81 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     br_Disp AT ROW 4.81 COL 3.5 
     but_Search AT ROW 23.67 COL 76.83
     bu_Check AT ROW 23.67 COL 103.83 
     cb_Search AT ROW 23.71 COL 16.17 COLON-ALIGNED NO-LABEL 
     fi_Search AT ROW 23.71 COL 40 COLON-ALIGNED NO-LABEL
     fi_Branch AT ROW 3.1 COL 7.5 COLON-ALIGNED NO-LABEL 
     fi_User AT ROW 3.1 COL 105.5 COLON-ALIGNED NO-LABEL 
     "ค้นหาข้อมูล" VIEW-AS TEXT
          SIZE 11.5 BY 1.1 AT ROW 23.71 COL 6.17 
          BGCOLOR 8 FGCOLOR 1 FONT 13
     "แสดงข้อมูลเอกสาร คีย์เบิก / จ่าย" VIEW-AS TEXT
          SIZE 34 BY 1.19 AT ROW 1.48 COL 49 
          BGCOLOR 3 FGCOLOR 7 FONT 17
     "สาขา :" VIEW-AS TEXT
          SIZE 5.67 BY .95 AT ROW 3.14 COL 3 
          BGCOLOR 19 FGCOLOR 1 FONT 6
     RECT-1 AT ROW 1.29 COL 1.67 
     RECT-2 AT ROW 2.81 COL 1.67 
     RECT-6 AT ROW 4.33 COL 1.67 
     RECT-7 AT ROW 23.29 COL 1.67
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 124.33 BY 24.81
         BGCOLOR 1  .


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
  CREATE WINDOW WUWSKQBN ASSIGN
         HIDDEN             = YES
         TITLE              = "แสดงข้อมูลเอกสาร คีย์เบิก / จ่าย WUWSKQBN.W"
         HEIGHT             = 24.81
         WIDTH              = 124.5
         MAX-HEIGHT         = 26.43
         MAX-WIDTH          = 132.67
         VIRTUAL-HEIGHT     = 26.43
         VIRTUAL-WIDTH      = 132.67
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
/* SETTINGS FOR WINDOW WUWSKQBN
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fr_main
   FRAME-NAME                                                           */
/* BROWSE-TAB br_Disp RECT-7 fr_main */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(WUWSKQBN)
THEN WUWSKQBN:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_Disp
/* Query rebuild information for BROWSE br_Disp
     _TblList          = "tid.sckyear"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   = tid.sckyear.policy
     _FldNameList[2]   > tid.sckyear.sckno
"sckyear.sckno" ? "x(15)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > tid.sckyear.stat
"sckyear.stat" "Document No." "x(10)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > tid.sckyear.trandat
"sckyear.trandat" ? ? "date" ? ? ? ? ? ? no ? no no "15" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > tid.sckyear.flag
"sckyear.flag" "Document Type" "x(2)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   = tid.sckyear.usrid
     _Query            is OPENED
*/  /* BROWSE br_Disp */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME WUWSKQBN
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL WUWSKQBN WUWSKQBN
ON END-ERROR OF WUWSKQBN /* แสดงข้อมูลเอกสาร คีย์เบิก / จ่าย WUWSKQBN.W */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL WUWSKQBN WUWSKQBN
ON WINDOW-CLOSE OF WUWSKQBN /* แสดงข้อมูลเอกสาร คีย์เบิก / จ่าย WUWSKQBN.W */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME but_Search
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL but_Search WUWSKQBN
ON CHOOSE OF but_Search IN FRAME fr_main /* SEARCH */
DO:
   
    
    IF cb_Search = "Policy No." THEN DO:

        
        OPEN QUERY br_Disp
        FOR EACH sckyear 
            WHERE sckyear.policy = TRIM(fi_Search) NO-LOCK.

    END.
    ELSE DO:
        OPEN QUERY br_Disp                                         
        FOR EACH  sckyear USE-INDEX sckyear
            WHERE sckyear.sckno  = TRIM(fi_Search) NO-LOCK.
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_Check
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_Check WUWSKQBN
ON CHOOSE OF bu_Check IN FRAME fr_main /* ===> */
DO:
  APPLY  "CLOSE" TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cb_Search
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cb_Search WUWSKQBN
ON VALUE-CHANGED OF cb_Search IN FRAME fr_main
DO:
   cb_Search = INPUT cb_Search.
   DISP cb_Search WITH FRAM fr_main.


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_Search
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_Search WUWSKQBN
ON LEAVE OF fi_Search IN FRAME fr_main
DO:
  fi_Search = INPUT fi_Search.
  DISP fi_Search WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_Disp
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK WUWSKQBN 


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
  SESSION:DATA-ENTRY-RETURN = YES.
  ASSIGN
    fi_Branch = nv_UserID
    fi_User   = nv_Branch
    cb_Search = "Policy No." .
  OPEN QUERY br_Disp                                         
  FOR EACH  sckyear 
      WHERE sckyear.sckno >= nv_stknofr
      AND   sckyear.sckno <= nv_stknoto NO-LOCK.


   DISP fi_Branch fi_User  cb_Search WITH FRAME fr_main.
  

  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI WUWSKQBN  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(WUWSKQBN)
  THEN DELETE WIDGET WUWSKQBN.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI WUWSKQBN  _DEFAULT-ENABLE
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
  DISPLAY cb_Search fi_Search fi_Branch fi_User 
      WITH FRAME fr_main IN WINDOW WUWSKQBN.
  ENABLE RECT-1 RECT-2 RECT-6 RECT-7 br_Disp but_Search bu_Check cb_Search 
         fi_Search fi_Branch fi_User 
      WITH FRAME fr_main IN WINDOW WUWSKQBN.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW WUWSKQBN.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

