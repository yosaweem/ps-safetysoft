&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          brstat           PROGRESS
*/
&Scoped-define WINDOW-NAME WUWPHCAM
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS WUWPHCAM 
/*------------------------------------------------------------------------

  File: wgwphcam.w

  Description: Query and select Campaign Phone (brstat.insure)

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author: Ranu I. 

  Created: A62-0219 date 08/05/2019

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
                                          
DEF Input-Output Parameter    n_cover     As   Char    Format    "x(5)" .  
Def input-Output Parameter    n_campno    As   Char    Format    "x(15)".  
DEF input-Output Parameter    n_garage    As   Char    Format    "x(5)" .  
DEF input-Output Parameter    n_pack      As   Char    Format    "x(5)" .  
DEF input-Output Parameter    n_company   As   Char    Format    "x(10)" . 
DEF input-Output Parameter    n_tpp       As   Char    Format    "x(20)" . 
DEF input-Output Parameter    n_tpa       As   Char    Format    "x(20)" . 
DEF input-Output Parameter    n_tpd       As   Char    Format    "x(20)" . 
DEF input-Output Parameter    n_41        As   Char    Format    "x(20)" .         
DEF input-Output Parameter    n_42        As   Char    Format    "x(20)" . 
DEF input-Output Parameter    n_43        As   Char    Format    "x(20)" . 
DEF SHARED VAR n_User     AS CHAR.        
DEF SHARED VAR n_Passwd   AS CHAR.
DEF VAR    cUpdate AS CHAR.
DEF BUFFER bComp   FOR Company.
DEF VAR nv_progname AS CHAR.
DEF VAR nv_objname AS CHAR.
DEF VAR nv_StrEnd AS CHAR.
DEF VAR nv_Str AS CHAR.
DEF VAR nv_NextPolflg AS INT.
DEF VAR nv_RenewPolflg AS INT.
DEF VAR nv_PrePol  AS CHAR.
DEF VAR pComp AS CHAR.
DEF VAR pRowIns AS ROWID.
DEF NEW SHARED VAR gUser   AS CHAR.
DEF NEW SHARED VAR gPasswd AS CHAR.
DEF SHARED VAR gComp   AS CHAR.
DEF NEW SHARED VAR gRecMod   AS Recid.
DEF NEW SHARED VAR gRecBen   AS Recid.
DEF NEW SHARED VAR gRecIns     AS Recid.
DEF VAR n_InsNo         AS INT.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME frbrIns
&Scoped-define BROWSE-NAME brInsure

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Insure

/* Definitions for BROWSE brInsure                                      */
&Scoped-define FIELDS-IN-QUERY-brInsure Insure.Text4 Insure.ICNo ~
Insure.VatCode Insure.Text1 Insure.Text3 Insure.Text2 Insure.LName ~
Insure.Addr1 Insure.Addr2 Insure.Addr3 Insure.Addr4 Insure.TelNo 
&Scoped-define ENABLED-FIELDS-IN-QUERY-brInsure 
&Scoped-define QUERY-STRING-brInsure FOR EACH Insure NO-LOCK ~
    BY Insure.LName INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-brInsure OPEN QUERY brInsure FOR EACH Insure NO-LOCK ~
    BY Insure.LName INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-brInsure Insure
&Scoped-define FIRST-TABLE-IN-QUERY-brInsure Insure


/* Definitions for FRAME frbrIns                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS brInsure 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR WUWPHCAM AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btnReturn 
     LABEL "EXIT" 
     SIZE 8.5 BY 1
     FONT 6.

DEFINE RECTANGLE RECT-84
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 12.33 BY 1.38
     BGCOLOR 4 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brInsure FOR 
      Insure SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brInsure
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brInsure WUWPHCAM _STRUCTURED
  QUERY brInsure NO-LOCK DISPLAY
      Insure.Text4 COLUMN-LABEL "Campaign No." FORMAT "x(20)":U
            WIDTH 14.17
      Insure.ICNo COLUMN-LABEL "Camaping  name" FORMAT "x(25)":U
            WIDTH 15.83
      Insure.VatCode COLUMN-LABEL "Cover" FORMAT "X(3)":U
      Insure.Text1 COLUMN-LABEL "Garage" FORMAT "X(5)":U
      Insure.Text3 COLUMN-LABEL "Package" FORMAT "x(5)":U
      Insure.Text2 COLUMN-LABEL "Company" FORMAT "X(10)":U
      Insure.LName COLUMN-LABEL "TPBI/Person" FORMAT "X(20)":U
            WIDTH 11.5
      Insure.Addr1 COLUMN-LABEL "TPBI/Per Acciden" FORMAT "X(20)":U
      Insure.Addr2 COLUMN-LABEL "TPPD/Per Acciden" FORMAT "X(20)":U
      Insure.Addr3 COLUMN-LABEL "41" FORMAT "X(20)":U
      Insure.Addr4 COLUMN-LABEL "42" FORMAT "X(20)":U
      Insure.TelNo COLUMN-LABEL "43" FORMAT "X(20)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 105 BY 20.1
         BGCOLOR 15  ROW-HEIGHT-CHARS .57.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME frmain
     btnReturn AT ROW 22.86 COL 49.83
     "Campaign Phone" VIEW-AS TEXT
          SIZE 16.5 BY 1 AT ROW 1.05 COL 49.17 WIDGET-ID 2
          FGCOLOR 2 FONT 6
     RECT-84 AT ROW 22.67 COL 48
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 107.67 BY 23.25
         BGCOLOR 20 .

DEFINE FRAME frbrIns
     brInsure AT ROW 1.14 COL 1.67
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.83 ROW 2.14
         SIZE 106.5 BY 20.48
         BGCOLOR 5 .


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
  CREATE WINDOW WUWPHCAM ASSIGN
         HIDDEN             = YES
         TITLE              = "Select Campaign"
         HEIGHT             = 23.24
         WIDTH              = 107.67
         MAX-HEIGHT         = 33.71
         MAX-WIDTH          = 170.67
         VIRTUAL-HEIGHT     = 33.71
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
/* SETTINGS FOR WINDOW WUWPHCAM
  VISIBLE,,RUN-PERSISTENT                                               */
/* REPARENT FRAME */
ASSIGN FRAME frbrIns:FRAME = FRAME frmain:HANDLE.

/* SETTINGS FOR FRAME frbrIns
   FRAME-NAME                                                           */
/* BROWSE-TAB brInsure 1 frbrIns */
ASSIGN 
       Insure.LName:AUTO-RESIZE IN BROWSE brInsure = TRUE.

/* SETTINGS FOR FRAME frmain
   Custom                                                               */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(WUWPHCAM)
THEN WUWPHCAM:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brInsure
/* Query rebuild information for BROWSE brInsure
     _TblList          = "brstat.Insure"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _OrdList          = "brstat.Insure.LName|yes"
     _FldNameList[1]   > brstat.Insure.Text4
"Insure.Text4" "Campaign No." ? "character" ? ? ? ? ? ? no ? no no "14.17" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > brstat.Insure.ICNo
"Insure.ICNo" "Camaping  name" "x(25)" "character" ? ? ? ? ? ? no ? no no "15.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > brstat.Insure.VatCode
"Insure.VatCode" "Cover" "X(3)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > brstat.Insure.Text1
"Insure.Text1" "Garage" "X(5)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > brstat.Insure.Text3
"Insure.Text3" "Package" "x(5)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > brstat.Insure.Text2
"Insure.Text2" "Company" "X(10)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > brstat.Insure.LName
"Insure.LName" "TPBI/Person" "X(20)" "character" ? ? ? ? ? ? no ? no no "11.5" yes yes no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > brstat.Insure.Addr1
"Insure.Addr1" "TPBI/Per Acciden" "X(20)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > brstat.Insure.Addr2
"Insure.Addr2" "TPPD/Per Acciden" "X(20)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   > brstat.Insure.Addr3
"Insure.Addr3" "41" "X(20)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[11]   > brstat.Insure.Addr4
"Insure.Addr4" "42" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[12]   > brstat.Insure.TelNo
"Insure.TelNo" "43" "X(20)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE brInsure */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME WUWPHCAM
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL WUWPHCAM WUWPHCAM
ON END-ERROR OF WUWPHCAM /* Select Campaign */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL WUWPHCAM WUWPHCAM
ON WINDOW-CLOSE OF WUWPHCAM /* Select Campaign */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brInsure
&Scoped-define SELF-NAME brInsure
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brInsure WUWPHCAM
ON MOUSE-SELECT-CLICK OF brInsure IN FRAME frbrIns
DO:
    GET CURRENT brInsure.
    /*RUN PdDispIns IN THIS-PROCEDURE. */
    FIND CURRENT Insure NO-LOCK.
    ASSIGN
       n_campno    = brstat.insure.Text4 
       n_garage    = brstat.insure.Text1 
       n_pack      = brstat.insure.Text3 
       n_company   = brstat.insure.Text2 
       n_tpp       = brstat.Insure.LName 
       n_tpa       = brstat.Insure.Addr1 
       n_tpd       = brstat.Insure.Addr2 
       n_41        = brstat.Insure.Addr3 
       n_42        = brstat.Insure.Addr4 
       n_43        = brstat.Insure.TelNo .
   /* IF NOT AVAIL Insure THEN RETURN NO-APPLY.
    IF AVAIL Insure AND Insure.CompNo = gComp THEN DO:
        pRowIns = ROWID (Insure).
    END.*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brInsure WUWPHCAM
ON MOUSE-SELECT-DBLCLICK OF brInsure IN FRAME frbrIns
DO:
    APPLY "MOUSE-SELECT-CLICK" TO brInsure IN FRAME frbrins.    
    APPLY "CLOSE" TO THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brInsure WUWPHCAM
ON VALUE-CHANGED OF brInsure IN FRAME frbrIns
DO:
    FIND CURRENT brstat.Insure NO-LOCK.
    ASSIGN
       n_campno    = brstat.insure.Text4 
       n_garage    = brstat.insure.Text1 
       n_pack      = brstat.insure.Text3 
       n_company   = brstat.insure.Text2 
       n_tpp       = brstat.Insure.LName 
       n_tpa       = brstat.Insure.Addr1 
       n_tpd       = brstat.Insure.Addr2 
       n_41        = brstat.Insure.Addr3 
       n_42        = brstat.Insure.Addr4 
       n_43        = brstat.Insure.TelNo .


   /* RUN pdDispIns IN THIS-PROCEDURE. */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frmain
&Scoped-define SELF-NAME btnReturn
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnReturn WUWPHCAM
ON CHOOSE OF btnReturn IN FRAME frmain /* EXIT */
DO:
    ASSIGN 
       n_campno    = "" 
       n_garage    = "" 
       n_pack      = "" 
       n_company   = "" 
       n_tpp       = "0" 
       n_tpa       = "0" 
       n_tpd       = "0" 
       n_41        = "0" 
       n_42        = "0" 
       n_43        = "0" .

   APPLY "CLOSE" TO THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frbrIns
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK WUWPHCAM 


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
DEF  VAR  gv_prgid   AS   CHAR.
DEF  VAR  gv_prog    AS   CHAR.
ASSIGN 
    gv_prgid = "wgwphcam.w"
    gv_prog  = "Campaign Phone".
RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.
  RUN WUT\WUTDICEN (WUWPHCAM:HANDLE).
  SESSION:DATA-ENTRY-RETURN = Yes.

  OPEN QUERY brInsure FOR EACH brstat.insure USE-INDEX Insure03 WHERE 
           brstat.insure.compno = "Phone" AND 
           brstat.insure.insno  = "phone" AND
           brstat.insure.vatcode = n_cover  NO-LOCK.

  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI WUWPHCAM  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(WUWPHCAM)
  THEN DELETE WIDGET WUWPHCAM.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI WUWPHCAM  _DEFAULT-ENABLE
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
  ENABLE btnReturn RECT-84 
      WITH FRAME frmain IN WINDOW WUWPHCAM.
  {&OPEN-BROWSERS-IN-QUERY-frmain}
  ENABLE brInsure 
      WITH FRAME frbrIns IN WINDOW WUWPHCAM.
  {&OPEN-BROWSERS-IN-QUERY-frbrIns}
  VIEW WUWPHCAM.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

