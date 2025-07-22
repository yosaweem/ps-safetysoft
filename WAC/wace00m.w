&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
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
  Modify by A56-0127 Sayamol N. 10/05/2013
      - Change global Variable from n_user, n_passwd 
        to n_glbrusr, n_glbrpwd
      - Add Connect gl_bran
  Modify by A56-0193 Nattanicha N. 03/07/2013
   แก้ไข
         1. แก้ไขกรณีมีการบันทึก RV แล้ว ให้โปรแกรมดึงข้อมูล RV ที่ถูกต้องขึ้นมาแสดง
    2. กรณีมีการแก้ไข Subacc1 Subacc2 ให้โปรแกรมบันทึกข้อมูลลงระบบตามที่ User แก้ไข
 
 Modify by A56-0274 Nattanicha N. 21/08/2013 
 แก้ไข เมนู Query for RV    
 
 Modify By A57-0333 Nattanicha N. 19/09/2014
   - จัด Group Menu ใหม่
   - เพิ่มการ Connect DB GL


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
DEF     SHARED VAR n_User   AS CHAR.
DEF     SHARED VAR n_Passwd AS CHAR.
DEF     VAR   nv_User     AS CHAR NO-UNDO. 
DEF     VAR   nv_pwd    AS CHAR NO-UNDO.
nv_User = n_User.
nv_pwd = n_Passwd.

/* Parameters Definitions ---                                           */
DEF VAR nv_paid     AS CHAR.
DEF VAR nv_Type     AS CHAR.

/* Local Variable Definitions ---                                       */
DEF VAR nv_progname AS CHAR INIT "wace00m".

DEF VAR nv_ok AS HANDLE NO-UNDO.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS IMAGE-24 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE IMAGE IMAGE-24
     FILENAME "wimage\bgc01":U
     SIZE 132.5 BY 24.

DEFINE BUTTON buCancel 
     LABEL "Cancel RC" 
     SIZE 18.5 BY 2.52
     FONT 6.

DEFINE BUTTON buEntNew 
     LABEL "Post to GL" 
     SIZE 18.5 BY 2.52 TOOLTIP "บันทึก RV ลง G/L"
     FONT 6.

DEFINE BUTTON buEntry 
     LABEL "Settle and GL" 
     SIZE 18.5 BY 2.52 TOOLTIP "คีย์ และ พิมพ์"
     FONT 6.

DEFINE BUTTON buRCReport 
     LABEL "RC Report" 
     SIZE 18.5 BY 2.62
     FONT 6.

DEFINE BUTTON buReprint 
     LABEL "Auto RV No." 
     SIZE 18.5 BY 2.52 TOOLTIP "Auto Running เลข RV"
     FONT 6.

DEFINE BUTTON buSetPara 
     LABEL "Set Running RV" 
     SIZE 18.5 BY 2.52
     FONT 6.

DEFINE BUTTON buupdateRV 
     LABEL "Update RV" 
     SIZE 18.5 BY 2.52
     FONT 6.

DEFINE BUTTON bu_exit 
     LABEL "Exit" 
     SIZE 18.5 BY 2.52
     FONT 6.

DEFINE BUTTON bu_print 
     LABEL "Print RV" 
     SIZE 18.5 BY 2.52
     FONT 6.

DEFINE BUTTON bu_Query 
     LABEL "Query Document" 
     SIZE 18.5 BY 2.52
     FONT 6.

DEFINE RECTANGLE RECT-297
     EDGE-PIXELS 3 GRAPHIC-EDGE  
     SIZE 63.5 BY 2.57
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-300
     EDGE-PIXELS 3 GRAPHIC-EDGE  
     SIZE 55.5 BY 6.81
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-611
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 22 BY 3.33
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-612
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 55.5 BY 13.71
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-613
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 21.17 BY 3.19
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-614
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 21.17 BY 3.19
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-615
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 21.17 BY 3.19
     BGCOLOR 14 .

DEFINE RECTANGLE RECT-616
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 21.17 BY 3.19
     BGCOLOR 14 .

DEFINE RECTANGLE RECT-617
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 21.17 BY 3.19
     BGCOLOR 14 .

DEFINE RECTANGLE RECT-618
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 20.5 BY 3.1
     BGCOLOR 28 .

DEFINE RECTANGLE RECT-619
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 21.17 BY 3.19
     BGCOLOR 14 .

DEFINE RECTANGLE RECT-620
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 21.17 BY 3.19
     BGCOLOR 14 .

DEFINE RECTANGLE RECT-622
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 21.17 BY 3.19
     BGCOLOR 28 .

DEFINE RECTANGLE RECT-623
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 55.5 BY 6.38
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-624
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 21.17 BY 3.19
     BGCOLOR 28 .

DEFINE RECTANGLE RECT-625
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 21.17 BY 3.19
     BGCOLOR 28 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     IMAGE-24 AT ROW 1 COL 1.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24.

DEFINE FRAME frMenu
     bu_Query AT ROW 7.24 COL 69.33
     buCancel AT ROW 7.29 COL 95.83
     buEntry AT ROW 7.71 COL 11.33
     buEntNew AT ROW 7.71 COL 39.67
     buReprint AT ROW 11.29 COL 68.83
     buupdateRV AT ROW 11.29 COL 95.83
     bu_print AT ROW 14.86 COL 10.67
     buRCReport AT ROW 14.91 COL 39.33
     buSetPara AT ROW 15.38 COL 69.17
     bu_exit AT ROW 19.33 COL 99
     "  FOR SETTLE" VIEW-AS TEXT
          SIZE 53.17 BY .95 AT ROW 5.29 COL 7.17
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "  UTILITY" VIEW-AS TEXT
          SIZE 53.5 BY .95 AT ROW 5.33 COL 64.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "    Confirm Query for Settle - BR. AC.":50 VIEW-AS TEXT
          SIZE 49.5 BY 1.81 AT ROW 1.71 COL 37.5
          BGCOLOR 19 FGCOLOR 0 FONT 27
     "  REPORT" VIEW-AS TEXT
          SIZE 53.67 BY .95 AT ROW 12.62 COL 6.83
          BGCOLOR 19 FGCOLOR 1 FONT 6
     RECT-297 AT ROW 1.33 COL 30.5
     RECT-300 AT ROW 4.91 COL 6
     RECT-611 AT ROW 18.86 COL 97
     RECT-612 AT ROW 4.91 COL 63.5
     RECT-613 AT ROW 7.38 COL 9.83
     RECT-614 AT ROW 7.38 COL 38.33
     RECT-615 AT ROW 10.95 COL 94.5
     RECT-616 AT ROW 10.95 COL 67.5
     RECT-617 AT ROW 6.91 COL 68
     RECT-618 AT ROW 14.52 COL 9.67
     RECT-619 AT ROW 6.95 COL 94.5
     RECT-620 AT ROW 15.05 COL 67.67
     RECT-622 AT ROW 14.57 COL 38
     RECT-623 AT ROW 12.19 COL 6
     RECT-624 AT ROW 14.48 COL 9.5
     RECT-625 AT ROW 14.57 COL 38
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 8 ROW 2.3
         SIZE 120.5 BY 21.65
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
  CREATE WINDOW C-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "wace00m - MENU"
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
ASSIGN FRAME frMenu:FRAME = FRAME DEFAULT-FRAME:HANDLE.

/* SETTINGS FOR FRAME DEFAULT-FRAME
                                                                        */
/* SETTINGS FOR FRAME frMenu
                                                                        */
ASSIGN 
       buReprint:HIDDEN IN FRAME frMenu           = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* wace00m - MENU */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* wace00m - MENU */
DO:
  /* This event will close the window and terminate the procedure.  */
  IF CONNECTED ("gl_bran") THEN DISCONNECT gl_bran.
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frMenu
&Scoped-define SELF-NAME buCancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buCancel C-Win
ON CHOOSE OF buCancel IN FRAME frMenu /* Cancel RC */
DO:
    CURRENT-WINDOW:WINDOW-STATE = WINDOW-MINIMIZED. 
    /*---A57-0333--
    RUN war\waru01.
    ----------*/
    RUN war\waru012.
    CURRENT-WINDOW:WINDOW-STATE = WINDOW-NORMAL.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buEntNew
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buEntNew C-Win
ON CHOOSE OF buEntNew IN FRAME frMenu /* Post to GL */
DO:
  CURRENT-WINDOW:WINDOW-STATE = WINDOW-MINIMIZED. 
  /*RUN war\warec06.---A56-0127---*/
  RUN wac\wacconfn.
  IF NOT CONNECTED ("gl_bran") THEN RUN wac\waccnglb.
  RUN war\ware08.
  CURRENT-WINDOW:WINDOW-STATE = WINDOW-NORMAL.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buEntry
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buEntry C-Win
ON CHOOSE OF buEntry IN FRAME frMenu /* Settle and GL */
DO:
  CURRENT-WINDOW:WINDOW-STATE = WINDOW-MINIMIZED. 
  RUN war\warec07.
  CURRENT-WINDOW:WINDOW-STATE = WINDOW-NORMAL. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buRCReport
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buRCReport C-Win
ON CHOOSE OF buRCReport IN FRAME frMenu /* RC Report */
DO:
    CURRENT-WINDOW:WINDOW-STATE = WINDOW-MINIMIZED. 
    RUN war\warr0114.
    CURRENT-WINDOW:WINDOW-STATE = WINDOW-NORMAL.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buReprint
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buReprint C-Win
ON CHOOSE OF buReprint IN FRAME frMenu /* Auto RV No. */
DO:
  CURRENT-WINDOW:WINDOW-STATE = WINDOW-MINIMIZED. 
  /*RUN war\warec08.---A56-0127---*/
  RUN wac\wacconfn.
  RUN war\warrv03.
  CURRENT-WINDOW:WINDOW-STATE = WINDOW-NORMAL.   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buSetPara
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buSetPara C-Win
ON CHOOSE OF buSetPara IN FRAME frMenu /* Set Running RV */
DO:

    nv_Type = "RV". /* Receipt Voucher  Running  ระบบ A/R */

    CURRENT-WINDOW:WINDOW-STATE = WINDOW-MINIMIZED. 
    RUN war\ware0101(INPUT  nv_Type).
    CURRENT-WINDOW:WINDOW-STATE = WINDOW-NORMAL.
    
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buupdateRV
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buupdateRV C-Win
ON CHOOSE OF buupdateRV IN FRAME frMenu /* Update RV */
DO:
  CURRENT-WINDOW:WINDOW-STATE = WINDOW-MINIMIZED. 
  RUN war\warref.
  CURRENT-WINDOW:WINDOW-STATE = WINDOW-NORMAL. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit C-Win
ON CHOOSE OF bu_exit IN FRAME frMenu /* Exit */
DO:
    IF CONNECTED ("gl_bran") THEN DISCONNECT gl_bran.
    IF CONNECTED ("gl") THEN DISCONNECT gl.

   APPLY "END-ERROR":U TO SELF.
   APPLY "CLOSE" TO THIS-PROCEDURE.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_print
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_print C-Win
ON CHOOSE OF bu_print IN FRAME frMenu /* Print RV */
DO:
   CURRENT-WINDOW:WINDOW-STATE = WINDOW-MINIMIZED. 
    RUN wac\wacr041.
    CURRENT-WINDOW:WINDOW-STATE = WINDOW-NORMAL.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_Query
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_Query C-Win
ON CHOOSE OF bu_Query IN FRAME frMenu /* Query Document */
DO:
    CURRENT-WINDOW:WINDOW-STATE = WINDOW-MINIMIZED. 
    RUN war\warqrv01.
    CURRENT-WINDOW:WINDOW-STATE = WINDOW-NORMAL.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME DEFAULT-FRAME
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
  
  gv_prgid = "wace00m".
  gv_prog  = "Confirm Query for Settle G/N Menu - AC.Br.".
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).

/*********************************************************************/  
  
  CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.
  
    /*RUN Wut\WutwiCen (C-Win:HANDLE).*/
    SESSION:DATA-ENTRY-RETURN = YES.

    /*---A56-0127---*/
    IF NOT CONNECTED ("sicfn") THEN DO:
       RUN wac\wacconfn.
    END.
    ELSE DO:
    END.

    IF NOT CONNECTED ("gl_bran") THEN DO:
       RUN wac\waccnglb.
    END.
    ELSE DO:
    END.

    /*---A57-0333---*/
    IF NOT CONNECTED ("gl") THEN DO:
       RUN wac\waccongl.
       ASSIGN n_user = nv_user
              n_passwd = nv_pwd .
    END.
    ELSE DO:
       ASSIGN n_user = nv_user
              n_passwd = nv_pwd .
    END.
    /*--------------*/


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
  ENABLE IMAGE-24 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  ENABLE RECT-297 RECT-300 RECT-611 RECT-612 RECT-613 RECT-614 RECT-615 
         RECT-616 RECT-617 RECT-618 RECT-619 RECT-620 RECT-622 RECT-623 
         RECT-624 RECT-625 bu_Query buCancel buEntry buEntNew buReprint 
         buupdateRV bu_print buRCReport buSetPara bu_exit 
      WITH FRAME frMenu IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frMenu}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

