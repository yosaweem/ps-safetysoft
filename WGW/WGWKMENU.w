&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME wgwkmenu
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS wgwkmenu 
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
/* WGWKMENU.W   Connect GW                                                */ 
/* Copyright    : Safety Insurance Public Company Limited                 */ 
/*                        บริษัท ประกันคุ้มภัย จำกัด (มหาชน)              */ 
/* CREATE BY    :Suthida T.   ASSIGN A54-0010   DATE 20/04/2010           */ 
/**************************************************************************/
--------------------------------------------------------------------------*/
/*          This .W file was created with the Progress AppBuilder.        */
/*------------------------------------------------------------------------*/
/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure.                          */
/*modify by  : Kridtiya i. A55-0128 ปรับการ connect test เป็น connect ระบบจริง */
/*modify by  : Kridtiya i. A57-0244 ปรับโปรแกรมหน้าจอเมนูใหม่                  */
/*Modify By : Ranu I. A61-0269 Date.12/06/2018 เพิ่มเมนู Export Data Inspection */
/*Modify By : Kridtiya i. A66-0108 Date. 31/05/2023 Import file excel to table tlt.*/

CREATE WIDGET-POOL.

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */
DEF VAR    n_user      AS CHAR .
DEF VAR    n_passwd    AS CHAR .
DEFINE VAR gv_id       AS CHAR FORMAT "X(8)" NO-UNDO.    
DEFINE VAR nv_pwd      AS CHAR NO-UNDO.
DEF    VAR gv_prgid    AS CHAR FORMAT "X(8)"  NO-UNDO.
DEF    VAR gv_prog     AS CHAR FORMAT "X(40)" NO-UNDO.

/* Local Variable Definitions ---                                       */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME frMain

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS bu_exptxt bu_exit bu_exptxt-2 bu_exptxt-3 ~
bu_exptxt-4 bu_exptxt-5 bu_exptxt-6 bu_exptxt-7 RECT-386 RECT-387 RECT-388 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wgwkmenu AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_exit 
     LABEL "EXIT" 
     SIZE 15 BY 1.33
     FONT 6.

DEFINE BUTTON bu_exptxt 
     LABEL "Import and Export to Excel File [K-Leasing ]" 
     SIZE 58 BY 1.52
     FGCOLOR 2 FONT 6.

DEFINE BUTTON bu_exptxt-2 
     LABEL "Load Text file K-Leasing [บริษัท ลิสซิ่งกสิกรไทย จำกัด]" 
     SIZE 58 BY 1.52
     FGCOLOR 2 FONT 6.

DEFINE BUTTON bu_exptxt-3 
     LABEL "Match File K-Leasing by Policy New" 
     SIZE 58 BY 1.52
     FGCOLOR 2 FONT 6.

DEFINE BUTTON bu_exptxt-4 
     LABEL "Match File Confirm Send to K-Leasing" 
     SIZE 58 BY 1.52
     FGCOLOR 2 FONT 6.

DEFINE BUTTON bu_exptxt-5 
     LABEL "Export Data Inspection K-Leasing" 
     SIZE 58 BY 1.52
     FGCOLOR 2 FONT 6.

DEFINE BUTTON bu_exptxt-6 
     LABEL "Query && Update  Detail  (K-LEASING)" 
     SIZE 58 BY 1.52
     FGCOLOR 2 FONT 6.

DEFINE BUTTON bu_exptxt-7 
     LABEL "Import  to Excel File [K-Leasing ]" 
     SIZE 58 BY 1.52
     FGCOLOR 2 FONT 6.

DEFINE RECTANGLE RECT-386
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 62 BY 15.19
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-387
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 20 BY 2.14
     BGCOLOR 6 .

DEFINE RECTANGLE RECT-388
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 62 BY 1.91
     BGCOLOR 8 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME frMain
     bu_exptxt AT ROW 6.91 COL 5
     bu_exit AT ROW 16 COL 45
     bu_exptxt-2 AT ROW 8.62 COL 5
     bu_exptxt-3 AT ROW 10.38 COL 5
     bu_exptxt-4 AT ROW 12.1 COL 5
     bu_exptxt-5 AT ROW 13.86 COL 5 WIDGET-ID 2
     bu_exptxt-6 AT ROW 5.24 COL 5 WIDGET-ID 4
     bu_exptxt-7 AT ROW 3.52 COL 5 WIDGET-ID 6
     "                              MENU K- LEASING" VIEW-AS TEXT
          SIZE 58 BY 1.43 AT ROW 1.48 COL 5
          BGCOLOR 2 FGCOLOR 7 FONT 6
     RECT-386 AT ROW 3.19 COL 3
     RECT-387 AT ROW 15.62 COL 42.5
     RECT-388 AT ROW 1.24 COL 3
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 66 BY 17.67
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
  CREATE WINDOW wgwkmenu ASSIGN
         HIDDEN             = YES
         TITLE              = "wgwkmenu.w"
         HEIGHT             = 17.67
         WIDTH              = 66.17
         MAX-HEIGHT         = 21.43
         MAX-WIDTH          = 80
         VIRTUAL-HEIGHT     = 21.43
         VIRTUAL-WIDTH      = 80
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
IF NOT wgwkmenu:LOAD-ICON("WIMAGE/iconhead.ico":U) THEN
    MESSAGE "Unable to load icon: WIMAGE/iconhead.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW wgwkmenu
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME frMain
   FRAME-NAME Custom                                                    */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wgwkmenu)
THEN wgwkmenu:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME wgwkmenu
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wgwkmenu wgwkmenu
ON END-ERROR OF wgwkmenu /* wgwkmenu.w */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wgwkmenu wgwkmenu
ON WINDOW-CLOSE OF wgwkmenu /* wgwkmenu.w */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit wgwkmenu
ON CHOOSE OF bu_exit IN FRAME frMain /* EXIT */
DO:
  APPLY "close" TO THIS-PROCEDURE.
      RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exptxt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exptxt wgwkmenu
ON CHOOSE OF bu_exptxt IN FRAME frMain /* Import and Export to Excel File [K-Leasing ] */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    RUN WGW\WGWRKLEX.
    {&WINDOW-NAME} :Hidden = No.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exptxt-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exptxt-2 wgwkmenu
ON CHOOSE OF bu_exptxt-2 IN FRAME frMain /* Load Text file K-Leasing [บริษัท ลิสซิ่งกสิกรไทย จำกัด] */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    RUN WGW\Wgwklgen. 
    {&WINDOW-NAME} :Hidden = No.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exptxt-3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exptxt-3 wgwkmenu
ON CHOOSE OF bu_exptxt-3 IN FRAME frMain /* Match File K-Leasing by Policy New */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    RUN WGW\Wgwklpo1. 
    {&WINDOW-NAME} :Hidden = No. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exptxt-4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exptxt-4 wgwkmenu
ON CHOOSE OF bu_exptxt-4 IN FRAME frMain /* Match File Confirm Send to K-Leasing */
DO:
   {&WINDOW-NAME} :Hidden = Yes.
    RUN WGW\Wgwklmat. 
    {&WINDOW-NAME} :Hidden = No.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exptxt-5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exptxt-5 wgwkmenu
ON CHOOSE OF bu_exptxt-5 IN FRAME frMain /* Export Data Inspection K-Leasing */
DO:
   {&WINDOW-NAME} :Hidden = Yes.
    RUN WGW\Wgwklins. 
    {&WINDOW-NAME} :Hidden = No.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exptxt-6
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exptxt-6 wgwkmenu
ON CHOOSE OF bu_exptxt-6 IN FRAME frMain /* Query  Update  Detail  (K-LEASING) */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    RUN WGW\wgwqkls0.
    {&WINDOW-NAME} :Hidden = No.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exptxt-7
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exptxt-7 wgwkmenu
ON CHOOSE OF bu_exptxt-7 IN FRAME frMain /* Import  to Excel File [K-Leasing ] */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    RUN WGW\WGWIMKLS.
    {&WINDOW-NAME} :Hidden = No.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK wgwkmenu 


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
  gv_prgid = "WGWKMENU".
  gv_prog  = "MENU K-LEASING TO GW".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:HANDLE,gv_prgid,gv_prog).
  RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE).  
  SESSION:DATA-ENTRY-RETURN = YES.
/*********************************************************************/ 
 /*ASSIGN rs_type = 1.*/
 /*fi_name:BGCOLOR=3.
 fi_pass:BGCOLOR=3.
 DISABLE fi_name fi_pass WITH FRAME frMain.*/

  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI wgwkmenu  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wgwkmenu)
  THEN DELETE WIDGET wgwkmenu.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI wgwkmenu  _DEFAULT-ENABLE
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
  ENABLE bu_exptxt bu_exit bu_exptxt-2 bu_exptxt-3 bu_exptxt-4 bu_exptxt-5 
         bu_exptxt-6 bu_exptxt-7 RECT-386 RECT-387 RECT-388 
      WITH FRAME frMain IN WINDOW wgwkmenu.
  {&OPEN-BROWSERS-IN-QUERY-frMain}
  VIEW wgwkmenu.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

