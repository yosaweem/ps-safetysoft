&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sicfn            PROGRESS
*/
&Scoped-define WINDOW-NAME wacq2001
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS wacq2001 
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

/* DEF VAR n_asdat     AS DATE. */
DEFINE INPUT PARAMETER n_asdat AS DATE.
DEFINE INPUT PARAMETER nv_reptyp AS CHAR.
DEF VAR nv_trntyp1  AS CHAR.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_Main
&Scoped-define BROWSE-NAME br_Qeury

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES agtprm_fil

/* Definitions for BROWSE br_Qeury                                      */
&Scoped-define FIELDS-IN-QUERY-br_Qeury agtprm_fil.asdat agtprm_fil.acno ~
agtprm_fil.trntyp agtprm_fil.poldes agtprm_fil.polbran agtprm_fil.endno ~
agtprm_fil.prem agtprm_fil.gross agtprm_fil.comm agtprm_fil.bal ~
agtprm_fil.odue agtprm_fil.trndat agtprm_fil.docno agtprm_fil.acno_clicod ~
agtprm_fil.opnpol agtprm_fil.prvpol agtprm_fil.addr1 agtprm_fil.addr2 ~
agtprm_fil.addr3 agtprm_fil.addr4 agtprm_fil.ac_name agtprm_fil.latdat ~
agtprm_fil.startdat agtprm_fil.duedat agtprm_fil.type agtprm_fil.comdat ~
agtprm_fil.poltyp 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_Qeury 
&Scoped-define QUERY-STRING-br_Qeury FOR EACH agtprm_fil NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br_Qeury OPEN QUERY br_Qeury FOR EACH agtprm_fil NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br_Qeury agtprm_fil
&Scoped-define FIRST-TABLE-IN-QUERY-br_Qeury agtprm_fil


/* Definitions for FRAME fr_Main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_AsDate fi_Type But_RUN but_Exit br_Qeury ~
RECT-412 RECT-413 RECT-414 
&Scoped-Define DISPLAYED-OBJECTS fi_AsDate fi_Type fi_trntyp1 fi_trntyp2 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wacq2001 AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON but_Exit 
     LABEL "EXIT" 
     SIZE 15 BY 1.14
     FONT 6.

DEFINE BUTTON But_RUN 
     LABEL "SEARCH" 
     SIZE 15 BY 1.14
     FONT 6.

DEFINE VARIABLE fi_AsDate AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_trntyp1 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 3 BY 1
     BGCOLOR 3 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_trntyp2 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 2.83 BY 1
     BGCOLOR 3 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_Type AS CHARACTER FORMAT "X(2)":U INITIAL "          0" 
     VIEW-AS FILL-IN 
     SIZE 5.5 BY 1
     FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-412
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 94 BY 4.05
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-413
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 17 BY 1.67
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-414
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 17 BY 1.67
     BGCOLOR 1 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_Qeury FOR 
      agtprm_fil SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_Qeury
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_Qeury wacq2001 _STRUCTURED
  QUERY br_Qeury NO-LOCK DISPLAY
      agtprm_fil.asdat FORMAT "99/99/9999":U WIDTH 10
      agtprm_fil.acno FORMAT "X(7)":U
      agtprm_fil.trntyp FORMAT "X(2)":U
      agtprm_fil.poldes FORMAT "x(35)":U
      agtprm_fil.polbran FORMAT "X(2)":U
      agtprm_fil.endno FORMAT "X(12)":U
      agtprm_fil.prem FORMAT "->>,>>>,>>>,>>9.99":U
      agtprm_fil.gross FORMAT "->>,>>>,>>>,>>9.99":U
      agtprm_fil.comm FORMAT "->>,>>>,>>9.99":U
      agtprm_fil.bal FORMAT "->>,>>>,>>>,>>9.99":U
      agtprm_fil.odue FORMAT "->>>,>>>,>>9.99":U
      agtprm_fil.trndat FORMAT "99/99/9999":U
      agtprm_fil.docno COLUMN-LABEL "   Doc No." FORMAT "X(10)":U
            WIDTH 13
      agtprm_fil.acno_clicod FORMAT "X(2)":U
      agtprm_fil.opnpol FORMAT "X(16)":U
      agtprm_fil.prvpol FORMAT "X(16)":U
      agtprm_fil.addr1 FORMAT "x(35)":U
      agtprm_fil.addr2 FORMAT "x(35)":U
      agtprm_fil.addr3 FORMAT "x(35)":U
      agtprm_fil.addr4 FORMAT "x(20)":U
      agtprm_fil.ac_name FORMAT "x(50)":U WIDTH 13.67
      agtprm_fil.latdat FORMAT "99/99/9999":U
      agtprm_fil.startdat FORMAT "99/99/9999":U
      agtprm_fil.duedat FORMAT "99/99/9999":U
      agtprm_fil.type FORMAT "X(2)":U
      agtprm_fil.comdat FORMAT "99/99/9999":U
      agtprm_fil.poltyp FORMAT "X(3)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 93.5 BY 17.1 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_Main
     fi_AsDate AT ROW 1.71 COL 17.67 COLON-ALIGNED NO-LABEL
     fi_Type AT ROW 2.91 COL 17.67 COLON-ALIGNED NO-LABEL
     But_RUN AT ROW 1.76 COL 79.17
     but_Exit AT ROW 3.48 COL 79.33
     fi_trntyp1 AT ROW 3.76 COL 8.5 COLON-ALIGNED NO-LABEL
     fi_trntyp2 AT ROW 3.76 COL 12.33 COLON-ALIGNED NO-LABEL
     br_Qeury AT ROW 5.33 COL 2.5
     "As of Date :" VIEW-AS TEXT
          SIZE 12 BY .95 AT ROW 1.62 COL 7.17
          BGCOLOR 3 FGCOLOR 15 FONT 6
     "Type :" VIEW-AS TEXT
          SIZE 7 BY .95 AT ROW 2.76 COL 12.17
          BGCOLOR 3 FGCOLOR 15 FONT 6
     "[ 07 = INWARD / 08 = OUTWARD ]" VIEW-AS TEXT
          SIZE 36 BY .95 AT ROW 2.95 COL 28.83
          BGCOLOR 3 FGCOLOR 15 FONT 6
     RECT-412 AT ROW 1.24 COL 2.5
     RECT-413 AT ROW 3.19 COL 78.17
     RECT-414 AT ROW 1.52 COL 78.17
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 96.83 BY 21.81.


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
  CREATE WINDOW wacq2001 ASSIGN
         HIDDEN             = YES
         TITLE              = "wacq2001 <insert window title>"
         HEIGHT             = 21.81
         WIDTH              = 96.83
         MAX-HEIGHT         = 32.48
         MAX-WIDTH          = 170.67
         VIRTUAL-HEIGHT     = 32.48
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
/* SETTINGS FOR WINDOW wacq2001
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fr_Main
   FRAME-NAME Custom                                                    */
/* BROWSE-TAB br_Qeury fi_trntyp2 fr_Main */
/* SETTINGS FOR FILL-IN fi_trntyp1 IN FRAME fr_Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_trntyp2 IN FRAME fr_Main
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wacq2001)
THEN wacq2001:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_Qeury
/* Query rebuild information for BROWSE br_Qeury
     _TblList          = "sicfn.agtprm_fil"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   > sicfn.agtprm_fil.asdat
"agtprm_fil.asdat" ? ? "date" ? ? ? ? ? ? no ? no no "10" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   = sicfn.agtprm_fil.acno
     _FldNameList[3]   = sicfn.agtprm_fil.trntyp
     _FldNameList[4]   = sicfn.agtprm_fil.poldes
     _FldNameList[5]   = sicfn.agtprm_fil.polbran
     _FldNameList[6]   = sicfn.agtprm_fil.endno
     _FldNameList[7]   = sicfn.agtprm_fil.prem
     _FldNameList[8]   = sicfn.agtprm_fil.gross
     _FldNameList[9]   = sicfn.agtprm_fil.comm
     _FldNameList[10]   = sicfn.agtprm_fil.bal
     _FldNameList[11]   = sicfn.agtprm_fil.odue
     _FldNameList[12]   = sicfn.agtprm_fil.trndat
     _FldNameList[13]   > sicfn.agtprm_fil.docno
"agtprm_fil.docno" "   Doc No." "X(10)" "character" ? ? ? ? ? ? no ? no no "13" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[14]   = sicfn.agtprm_fil.acno_clicod
     _FldNameList[15]   = sicfn.agtprm_fil.opnpol
     _FldNameList[16]   = sicfn.agtprm_fil.prvpol
     _FldNameList[17]   = sicfn.agtprm_fil.addr1
     _FldNameList[18]   = sicfn.agtprm_fil.addr2
     _FldNameList[19]   = sicfn.agtprm_fil.addr3
     _FldNameList[20]   = sicfn.agtprm_fil.addr4
     _FldNameList[21]   > sicfn.agtprm_fil.ac_name
"agtprm_fil.ac_name" ? ? "character" ? ? ? ? ? ? no ? no no "13.67" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[22]   = sicfn.agtprm_fil.latdat
     _FldNameList[23]   = sicfn.agtprm_fil.startdat
     _FldNameList[24]   = sicfn.agtprm_fil.duedat
     _FldNameList[25]   = sicfn.agtprm_fil.type
     _FldNameList[26]   = sicfn.agtprm_fil.comdat
     _FldNameList[27]   = sicfn.agtprm_fil.poltyp
     _Query            is NOT OPENED
*/  /* BROWSE br_Qeury */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME wacq2001
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wacq2001 wacq2001
ON END-ERROR OF wacq2001 /* wacq2001 <insert window title> */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wacq2001 wacq2001
ON WINDOW-CLOSE OF wacq2001 /* wacq2001 <insert window title> */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME but_Exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL but_Exit wacq2001
ON CHOOSE OF but_Exit IN FRAME fr_Main /* EXIT */
DO:
     APPLY "CLOSE" TO THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME But_RUN
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL But_RUN wacq2001
ON CHOOSE OF But_RUN IN FRAME fr_Main /* SEARCH */
DO:
OPEN QUERY br_Qeury
     FOR EACH agtprm_fil USE-INDEX by_acno WHERE
              agtprm_fil.asdat   =  n_asdat AND
   (LOOKUP(SUBSTR(agtprm_fil.trntyp,1,1) , nv_trntyp1) <> 0 )
    NO-LOCK  BY agtprm_fil.acno
             BY agtprm_fil.trndat
             BY SUBSTR(agtprm_fil.policy,3,2)
             BY agtprm_fil.policy
             BY agtprm_fil.endno.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_AsDate
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_AsDate wacq2001
ON LEAVE OF fi_AsDate IN FRAME fr_Main
DO:
  fi_asDate = INPUT fi_asdate.
  n_asdat = fi_asDate.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_Type
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_Type wacq2001
ON LEAVE OF fi_Type IN FRAME fr_Main
DO:
  fi_Type = INPUT fi_type.
  
  IF (fi_type = "07" OR fi_type = "08") THEN DO:
      IF fi_type = "07" THEN DO:
         ASSIGN
           nv_trntyp1 = "O,T"
           fi_trntyp1   = "O"
           fi_trntyp2   = "T".
      END.
      IF fi_type = "08" THEN DO:
         ASSIGN
           nv_trntyp1 = "U,P"
           fi_trntyp1   = "U"
           fi_trntyp2   = "P".
      END.
      DISP fi_trntyp1 fi_trntyp2 WITH FRAME fr_main.
   END.
   ELSE DO:

     MESSAGE "Query Trnsection Type = 07 / 08 Only..!"
     VIEW-AS ALERT-BOX ERROR.
     RETURN NO-APPLY.

   END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_Qeury
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK wacq2001 


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
  DEF  VAR  gv_prgid   AS   CHAR.
  DEF  VAR  gv_prog    AS   CHAR.
  
  gv_prgid = "wacq2001".
  gv_prog  = "Query For Inward & Outward".
  
  RUN  WUT\WUTHEAD (wacq2001:handle,gv_prgid,gv_prog).
/*********************************************************************/  
  RUN  WUT\WUTWICEN (wacq2001:handle). 
  
  SESSION:DATA-ENTRY-RETURN = YES.
  ASSIGN
  fi_asDate = n_asdat
  fi_Type   =nv_reptyp.
  DISP fi_asDate fi_type WITH FRAME fr_main.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI wacq2001  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wacq2001)
  THEN DELETE WIDGET wacq2001.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI wacq2001  _DEFAULT-ENABLE
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
  DISPLAY fi_AsDate fi_Type fi_trntyp1 fi_trntyp2 
      WITH FRAME fr_Main IN WINDOW wacq2001.
  ENABLE fi_AsDate fi_Type But_RUN but_Exit br_Qeury RECT-412 RECT-413 RECT-414 
      WITH FRAME fr_Main IN WINDOW wacq2001.
  {&OPEN-BROWSERS-IN-QUERY-fr_Main}
  VIEW wacq2001.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

