&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic_test         PROGRESS
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

  Created: 

------------------------------------------------------------------------*/
/*          This .W file was created with the Progress AppBuilder.      */
/*----------------------------------------------------------------------*/

/*-------     MoDiFy : MaNop G.   A58-0340  Date 07/09/2558          
            แก้ไขการ Add ช้อมูล และ แสดงข้อมูลตาม Parameter      -------*/

/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */

CREATE WIDGET-POOL.

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

DEF VAR nv_TypeList     AS CHAR INIT "BRANCH,SUBACC1,SUBACC2".
DEF VAR n_branch        AS CHAR FORMAT "X(2)".
DEF VAR n_sacc1        AS CHAR FORMAT "X(3)".
DEF VAR n_sacc2        AS CHAR FORMAT "X(3)".
DEF VAR n_type         AS INT INIT 0.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME br_cvm002

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES cvm002 xmm023

/* Definitions for BROWSE br_cvm002                                     */
&Scoped-define FIELDS-IN-QUERY-br_cvm002 cvm002.branch cvm002.class cvm002.tariff   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_cvm002   
&Scoped-define SELF-NAME br_cvm002
&Scoped-define OPEN-QUERY-br_cvm002 /*--  Manop G, ~
       A58-0340   07/09/2015 ---*/ OPEN QUERY br_cvm002    FOR EACH  cvm002  NO-LOCK, ~
              FIRST xmm023 WHERE cvm002.branch = xmm023.branch NO-LOCK             BY cvm002.branch              BY cvm002.class               BY cvm002.tariff INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br_cvm002 cvm002 xmm023
&Scoped-define FIRST-TABLE-IN-QUERY-br_cvm002 cvm002
&Scoped-define SECOND-TABLE-IN-QUERY-br_cvm002 xmm023


/* Definitions for FRAME frShow                                         */
&Scoped-define OPEN-BROWSERS-IN-QUERY-frShow ~
    ~{&OPEN-QUERY-br_cvm002}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS IMAGE-23 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE IMAGE IMAGE-23
     FILENAME "wimage/bgc01.bmp":U CONVERT-3D-COLORS
     SIZE 133.33 BY 24.05.

DEFINE BUTTON bu_go 
     LABEL "GO" 
     SIZE 12.83 BY 1.19
     FONT 6.

DEFINE VARIABLE cbTypeList AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     DROP-DOWN-LIST
     SIZE 19 BY 1 NO-UNDO.

DEFINE VARIABLE fi_Type AS CHARACTER FORMAT "X(5)":U 
     LABEL "Fill 1" 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1.05
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_TypeList AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 12 BY .95
     BGCOLOR 1 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE rsType AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Add", 1,
"Update", 2,
"Delete", 3
     SIZE 14.5 BY 3.71
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-318
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 97.5 BY 5.76
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-320
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 16.5 BY 4.29.

DEFINE RECTANGLE RECT-322
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 55.83 BY 1.43
     BGCOLOR 19 .

DEFINE BUTTON bu_cancel 
     LABEL "Cancel" 
     SIZE 10 BY 1.43
     FONT 6.

DEFINE BUTTON bu_exit 
     LABEL "Exit" 
     SIZE 15.5 BY 2.14
     FONT 6.

DEFINE BUTTON bu_OK 
     LABEL "OK" 
     SIZE 10 BY 1.43
     FONT 6.

DEFINE VARIABLE fi_branch AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 7.17 BY .86
     BGCOLOR 15 FGCOLOR 12 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_brname AS CHARACTER FORMAT "X(50)":U 
      VIEW-AS TEXT 
     SIZE 21 BY .62
     BGCOLOR 3 FGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_subacc1 AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 7.33 BY .81
     BGCOLOR 15 FGCOLOR 6 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_subacc2 AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 7.33 BY .81
     BGCOLOR 15 FGCOLOR 12 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-319
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 41.33 BY 8
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-323
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 35 BY 12.76
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-324
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 46.5 BY 12.62
     BGCOLOR 1 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_cvm002 FOR 
      cvm002, 
      xmm023 SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_cvm002
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_cvm002 C-Win _FREEFORM
  QUERY br_cvm002 NO-LOCK DISPLAY
      cvm002.branch  FORMAT "x(2)":U WIDTH 6
cvm002.class   COLUMN-LABEL "SUBACC1" FORMAT "x(6)":U
cvm002.tariff  COLUMN-LABEL "SUBACC2" FORMAT "x(6)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ASSIGN NO-ROW-MARKERS SEPARATORS SIZE 28.5 BY 11.67
         BGCOLOR 15  ROW-HEIGHT-CHARS .57 EXPANDABLE.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     IMAGE-23 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133.33 BY 24.05
         BGCOLOR 10 .

DEFINE FRAME frShow
     bu_cancel AT ROW 9.05 COL 31
     fi_brname AT ROW 5.05 COL 27 COLON-ALIGNED NO-LABEL
     fi_branch AT ROW 4.95 COL 18.67 COLON-ALIGNED NO-LABEL
     fi_subacc1 AT ROW 6.33 COL 18.67 COLON-ALIGNED NO-LABEL
     fi_subacc2 AT ROW 7.71 COL 18.67 COLON-ALIGNED NO-LABEL
     bu_OK AT ROW 9.05 COL 18.17
     bu_exit AT ROW 11.48 COL 23
     br_cvm002 AT ROW 2.91 COL 60.17
     " Subacc2:" VIEW-AS TEXT
          SIZE 9.5 BY .76 AT ROW 7.71 COL 10.67
          BGCOLOR 8 FGCOLOR 1 
     " Subacc1:" VIEW-AS TEXT
          SIZE 9.5 BY .81 AT ROW 6.33 COL 10.67
          BGCOLOR 8 FGCOLOR 1 
     " Branch:" VIEW-AS TEXT
          SIZE 8.5 BY .86 AT ROW 4.95 COL 11.67
          BGCOLOR 8 FGCOLOR 1 
     "             UPDATE/ADD/DELETE" VIEW-AS TEXT
          SIZE 38.5 BY .71 AT ROW 3.52 COL 10.5
          BGCOLOR 1 FGCOLOR 7 FONT 6
     RECT-319 AT ROW 2.95 COL 9
     RECT-323 AT ROW 2.19 COL 56.83
     RECT-324 AT ROW 2.29 COL 6.5
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         NO-LABELS SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 19.33 ROW 9.81
         SIZE 97 BY 14.52
         BGCOLOR 19 .

DEFINE FRAME frmain
     rsType AT ROW 3.48 COL 9.67 NO-LABEL
     cbTypeList AT ROW 4.76 COL 35.17 COLON-ALIGNED NO-LABEL
     fi_Type AT ROW 4.76 COL 69.5
     bu_go AT ROW 4.67 COL 86
     fi_TypeList AT ROW 4.81 COL 55 COLON-ALIGNED NO-LABEL
     "   By:" VIEW-AS TEXT
          SIZE 7.33 BY .86 AT ROW 4.86 COL 28.83
          BGCOLOR 1 FGCOLOR 15 FONT 6
     "   SUB ACCOUNT CODE MAINTENANCE" VIEW-AS TEXT
          SIZE 105.33 BY .95 AT ROW 1.24 COL 1
          BGCOLOR 1 FGCOLOR 15 FONT 6
     RECT-318 AT ROW 2.38 COL 5.33
     RECT-320 AT ROW 3.14 COL 8.67
     RECT-322 AT ROW 4.57 COL 26.67
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         NO-LABELS SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 14.33 ROW 1.48
         SIZE 105.67 BY 7.86.


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
         TITLE              = "Sub Account Code Maintenance : WACVM002.W"
         HEIGHT             = 24.05
         WIDTH              = 133.33
         MAX-HEIGHT         = 24.05
         MAX-WIDTH          = 133.33
         VIRTUAL-HEIGHT     = 24.05
         VIRTUAL-WIDTH      = 133.33
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
/* REPARENT FRAME */
ASSIGN FRAME frmain:FRAME = FRAME DEFAULT-FRAME:HANDLE
       FRAME frShow:FRAME = FRAME DEFAULT-FRAME:HANDLE.

/* SETTINGS FOR FRAME DEFAULT-FRAME
                                                                        */
/* SETTINGS FOR FRAME frmain
   Custom                                                               */
/* SETTINGS FOR BUTTON bu_go IN FRAME frmain
   NO-ENABLE                                                            */
/* SETTINGS FOR COMBO-BOX cbTypeList IN FRAME frmain
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_Type IN FRAME frmain
   NO-ENABLE ALIGN-L LABEL "Fill 1:"                                    */
/* SETTINGS FOR FRAME frShow
   Custom                                                               */
/* BROWSE-TAB br_cvm002 RECT-319 frShow */
ASSIGN 
       br_cvm002:SEPARATOR-FGCOLOR IN FRAME frShow      = 3.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_cvm002
/* Query rebuild information for BROWSE br_cvm002
     _START_FREEFORM
/*--  Manop G, A58-0340   07/09/2015 ---*/
OPEN QUERY br_cvm002
   FOR EACH  cvm002  NO-LOCK,
       FIRST xmm023 WHERE cvm002.branch = xmm023.branch NO-LOCK
            BY cvm002.branch
             BY cvm002.class
              BY cvm002.tariff INDEXED-REPOSITION.
     _END_FREEFORM
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _OrdList          = "sic_test.cvm002.branch|yes,sic_test.cvm002.class|yes,sic_test.cvm002.tariff|yes"
     _Query            is OPENED
*/  /* BROWSE br_cvm002 */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Sub Account Code Maintenance : WACVM002.W */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Sub Account Code Maintenance : WACVM002.W */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frShow
&Scoped-define SELF-NAME bu_cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_cancel C-Win
ON CHOOSE OF bu_cancel IN FRAME frShow /* Cancel */
DO:
  ASSIGN fi_branch = ""
         fi_subacc1 = ""
         fi_subacc2 = ""
         fi_brname  = ""
         fi_type    = "".
  DISP fi_branch fi_subacc1 fi_subacc2 fi_brname WITH FRAME frShow.
  DISP fi_type WITH FRAME frmain.

  RUN pdGetTypelist.
  RUN pdUpdateQ.

  rsType = 1.
  DISP rsType WITH FRAME frmain.


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit C-Win
ON CHOOSE OF bu_exit IN FRAME frShow /* Exit */
DO:
  APPLY "CLOSE" TO THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frmain
&Scoped-define SELF-NAME bu_go
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_go C-Win
ON CHOOSE OF bu_go IN FRAME frmain /* GO */
DO:
  DO WITH FRAME frmain:
        IF NOT CAN-FIND(FIRST cvm002 WHERE (cvm002.branch = n_branch)) THEN DO:
            MESSAGE "Not found Branch " + n_branch + " in cvm002" VIEW-AS ALERT-BOX.
            ASSIGN
                fi_branch     = ""
                fi_subacc1    = ""
                fi_subacc2    = ""
                fi_brname     = "".
                
            DISP fi_branch  fi_subacc1  fi_subacc2  fi_brname WITH FRAME frShow.
            APPLY "Entry" TO fi_type IN FRAME frmain.
        END.

        ELSE DO:
             OPEN QUERY br_cvm002 FOR EACH cvm002,
                 FIRST xmm023  WHERE cvm002.branch = n_branch .
            
            FIND FIRST xmm023 USE-INDEX xmm02301 WHERE
                              xmm023.branch = cvm002.branch.
            IF AVAIL xmm023 THEN fi_brname = xmm023.bdes.
            ELSE fi_brname = "".
 
            ASSIGN
                fi_branch     = cvm002.branch
                fi_subacc1    = cvm002.class
                fi_subacc2    = cvm002.tariff.
            DISP fi_branch  fi_subacc1  fi_subacc2  fi_brname WITH FRAME frShow.
            APPLY "Entry" TO fi_branch IN FRAME frShow.
            
        END.
  END. 

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frShow
&Scoped-define SELF-NAME bu_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_OK C-Win
ON CHOOSE OF bu_OK IN FRAME frShow /* OK */
DO:
  ASSIGN n_branch = CAPS (INPUT fi_branch)
         n_sacc1  = INPUT fi_subacc1
         n_sacc2  = INPUT fi_subacc2.

  IF n_branch <> "" THEN DO:

      IF n_type = 3 THEN DO:    /*---delete---*/
         RUN pdDelete.    
     
      END.
      ELSE DO:           /*---Add & Update ---*/
          /*---   Find  xmm023  ----*/
            FIND FIRST xmm023 USE-INDEX xmm02301 WHERE 
                       xmm023.branch = n_branch  NO-ERROR.
                IF NOT AVAIL xmm023 THEN DO:            /*- Find จาก Parameter  -*/
                   MESSAGE "Can Not Find Parameter Branch..." VIEW-AS ALERT-BOX.
                   NEXT.
                END.   
                ELSE      
                 /*--- Manop G. A58-0340  08/09/2015 ----*/
                
                    FIND FIRST cvm002 USE-INDEX cvm00201 WHERE 
                               cvm002.branch = n_branch  NO-ERROR.
                        IF NOT AVAIL cvm002 THEN DO:
                           CREATE cvm002.
                           ASSIGN cvm002.branch = n_branch
                                  cvm002.class  = n_sacc1
                                  cvm002.tariff = n_sacc2.
                           MESSAGE "Create Branch complete..." VIEW-AS ALERT-BOX INFORMATION.
                           OPEN QUERY br_cvm002
                           /*-FOR EACH cvm002 WHERE 
                                    cvm002.branch <> ""  BY cvm002.branch DESC. -*/          
                            FOR EACH  cvm002  NO-LOCK,
                                FIRST xmm023 WHERE cvm002.branch = xmm023.branch BY cvm002.branch DESC.
                
                           APPLY "Entry" TO fi_branch IN FRAME frShow.
                   
                        END.
                        ELSE DO:
                            IF n_Type = 1 THEN DO:
                               MESSAGE "This Branch is already exist in cvm002" VIEW-AS ALERT-BOX.
                               APPLY "Entry" TO fi_branch IN FRAME frShow.
                            END.
                            ELSE DO:
                                ASSIGN cvm002.branch = n_branch
                                       cvm002.class  = n_sacc1
                                       cvm002.tariff = n_sacc2.
                                MESSAGE "Update Complete..." VIEW-AS ALERT-BOX.
                                OPEN QUERY br_cvm002
                                /*-FOR EACH cvm002 WHERE 
                                         cvm002.branch <> ""  BY cvm002.branch DESC.-*/
                    
                                FOR EACH  cvm002  NO-LOCK,
                                    FIRST xmm023 WHERE cvm002.branch = xmm023.branch BY cvm002.branch DESC.
                    
                                APPLY "Entry" TO fi_branch IN FRAME frShow.
                            END.  /* n_type */
                        END.    /* Else */
      END.  /* n_type <> 3 */
   END.  /* if n_branch <> "" */
   
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frmain
&Scoped-define SELF-NAME cbTypeList
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cbTypeList C-Win
ON VALUE-CHANGED OF cbTypeList IN FRAME frmain
DO:
    cbTypeList = INPUT cbTypeList.

    IF cbTypeList = "BRANCH" THEN DO:
        DISP cbTypeList 
        "BRANCH" @ fi_TypeList
        WITH FRAME frmain.
        APPLY "Entry" TO fi_type IN FRAME frMain.
        
    END.
    ELSE IF cbTypeList = "SUBACC1" THEN DO:
         DISP cbTypeList 
         "SUBACC1" @ fi_TypeList
         WITH FRAME frmain.
         APPLY "Entry" TO fi_type IN FRAME frMain.
    END.
    ELSE IF cbTypeList = "SUBACC2" THEN DO:
         DISP "SUBACC2" @ fi_TypeList
         WITH FRAME frmain.
         APPLY "Entry" TO fi_type IN FRAME frMain.
    END.

   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frShow
&Scoped-define SELF-NAME fi_branch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_branch C-Win
ON LEAVE OF fi_branch IN FRAME frShow
DO:
  IF n_type = 1 OR n_type = 3 THEN DO:
     n_branch = CAPS (INPUT fi_branch).
     FIND FIRST xmm023 USE-INDEX xmm02301 WHERE
                xmm023.branch = n_branch NO-ERROR.
     IF AVAIL xmm023 THEN fi_brname = xmm023.bdes.
     ELSE fi_brname = "".
     
     DISP n_branch  @ fi_branch WITH FRAME frshow.
     DISP fi_brname WITH FRAME frShow.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frmain
&Scoped-define SELF-NAME fi_Type
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_Type C-Win
ON LEAVE OF fi_Type IN FRAME frmain /* Fill 1 */
DO:
  n_branch = INPUT fi_type.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rsType
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rsType C-Win
ON VALUE-CHANGED OF rsType IN FRAME frmain
DO:
   IF INPUT rsType = 1 THEN DO:        /*----Add----*/
      n_type = 1.
      DISABLE cbTypeList fi_type bu_go WITH FRAME frmain.
      APPLY "Entry" TO fi_branch IN FRAME frShow.
   END.
   ELSE IF INPUT rsType = 2 THEN DO:    /*----Update----*/
      n_type = 2.
      ENABLE cbTypeList fi_type bu_go WITH FRAME frmain.
      cbTypeList:LIST-ITEMS IN FRAME frmain = nv_TypeList.
      cbTypeList = ENTRY(1,nv_TypeList).
      DISP cbTypeList 
      "Branch" @ fi_TypeList WITH FRAME frmain.
      APPLY "Entry" TO fi_type IN FRAME frmain.
   END.
   ELSE DO:                         /*----Delete----*/
      n_type = 3.
      DISABLE cbTypeList fi_type bu_go WITH FRAME frmain.
      APPLY "Entry" TO fi_branch IN FRAME frShow.
   END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME br_cvm002
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

  /********************  T I T L E   F O R  C - W I N  ****************/
  DEF  VAR  gv_prgid   AS   CHAR.
  DEF  VAR  gv_prog    AS   CHAR.

  Rect-319:move-to-top( ).
  
  gv_prgid = "Wacvm002".
  gv_prog  = "Sub Account Code Maintenance".
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).
/*********************************************************************/  
/*   RUN Wut\WutdiCen (C-Win:HANDLE).  */

  SESSION:DATA-ENTRY-RETURN = YES.
  SESSION:DATE-FORMAT = "dmy".  /*A50-0061*/

  RUN pdGetTypeList   IN THIS-PROCEDURE. /*--combo ประเภทการหา--*/
  RUN pdUpdateQ.


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
  ENABLE IMAGE-23 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  DISPLAY rsType cbTypeList fi_Type fi_TypeList 
      WITH FRAME frmain IN WINDOW C-Win.
  ENABLE rsType fi_TypeList RECT-318 RECT-320 RECT-322 
      WITH FRAME frmain IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frmain}
  DISPLAY fi_brname fi_branch fi_subacc1 fi_subacc2 
      WITH FRAME frShow IN WINDOW C-Win.
  ENABLE bu_cancel fi_brname fi_branch fi_subacc1 fi_subacc2 bu_OK bu_exit 
         RECT-319 br_cvm002 RECT-323 RECT-324 
      WITH FRAME frShow IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frShow}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdDelete C-Win 
PROCEDURE pdDelete :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND FIRST cvm002 WHERE cvm002.branch = n_branch AND
                             cvm002.class  = n_sacc1  AND
                             cvm002.tariff = n_sacc2  NO-ERROR.
     IF NOT AVAIL cvm002 THEN DO:
        MESSAGE "Not found branch " + n_branch + ", Sub1 " + n_sacc1 + ", Sub2 " + n_sacc2
        VIEW-AS ALERT-BOX.
        APPLY "Entry" TO fi_branch IN FRAME frShow.
     END.
     ELSE DO:
        MESSAGE "Are You Sure?" VIEW-AS ALERT-BOX 
        QUESTION BUTTONS YES-NO TITLE "ยืนยันการยกเลิก" 
        UPDATE n_logAns AS LOGICAL.
        CASE n_logAns:
            WHEN TRUE THEN  DO:    /* Yes */
            
                FIND cvm002  WHERE cvm002.branch = n_branch AND          
                                   cvm002.class  = n_sacc1  AND       
                                   cvm002.tariff = n_sacc2  NO-ERROR NO-WAIT.
                IF AVAIL cvm002 THEN DELETE cvm002.
                    OPEN QUERY br_cvm002
                     /*-FOR EACH cvm002 WHERE 
                    cvm002.branch <> ""  BY cvm002.branch DESC .  -*/
                    
                    FOR EACH  cvm002  NO-LOCK,
                        FIRST xmm023 
                        WHERE cvm002.branch = xmm023.branch BY cvm002.branch DESC.

                    ASSIGN fi_branch = ""
                           fi_subacc1 = ""
                           fi_subacc2 = "".
                     DISP fi_branch fi_subacc1 fi_subacc2 WITH FRAME frShow.
                    APPLY "Entry" TO fi_branch IN FRAME frShow.
                END.   

            WHEN FALSE THEN  DO:   /* NO */
                ASSIGN fi_branch = ""
                       fi_subacc1 = ""
                       fi_subacc2 = ""
                       fi_brname = "".
                DISP fi_branch fi_subacc1 fi_subacc2 fi_brname WITH FRAME frShow.
                APPLY "Entry" TO fi_branch IN FRAME frShow.
            END.        
        END CASE. 
     END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdGetTypeList C-Win 
PROCEDURE pdGetTypeList :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 cbTypeList:LIST-ITEMS IN FRAME frmain = nv_TypeList.
 cbTypeList = ENTRY(1,nv_TypeList).

 n_type = 1.

  DISP cbTypeList 
      "Branch" @ fi_TypeList
  WITH FRAME frmain.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdUpdateQ C-Win 
PROCEDURE pdUpdateQ :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
OPEN QUERY br_cvm002
   /*-FOR EACH cvm002 WHERE 
             cvm002.branch <> ""  BY cvm002.branch DESC .  --*/
          FOR EACH  cvm002  NO-LOCK,
                        FIRST xmm023 WHERE cvm002.branch = xmm023.branch BY cvm002.branch DESC.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

