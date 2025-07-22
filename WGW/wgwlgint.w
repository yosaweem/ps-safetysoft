&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME wgwlgint
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS wgwlgint 
/*************************************************************************
 wgwlocre.w : LOQ IN เข้าเมนู Menu  ระบบงานนำเข้าข้อมูล พรบ. จาก Lockton ผ่าน Web Service
 Copyright  : Safety Insurance Public Company Limited
               บริษัท ประกันคุ้มภัย จำกัด (มหาชน)
 ------------------------------------------------------------------------                 
 Database   : BUINT
 ------------------------------------------------------------------------               
 CREATE BY  : Watsana K.   ASSIGN: A56-0299   DATE: 18/10/2013
 ------------------------------------------------------------------------
 Modify By  : Porntiwa T.  A62-0105  10/09/2019
            : ปรับแก้ไข Host เป็น TMSTH
 Modify By  : Sarinya C. A64-0217  20/05/2021
            : Change host => TMPMWSDBIP01            
 *************************************************************************/
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

DEF NEW SHARED VAR nv_user     AS CHARACTER.
DEF NEW SHARED VAR nv_error    AS CHARACTER.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-4 RECT-5 fi_username fi_password bu_OK ~
bu_cancel 
&Scoped-Define DISPLAYED-OBJECTS fi_username fi_password 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wgwlgint AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_cancel 
     LABEL "CANCEL" 
     SIZE 10.5 BY 1.43
     FONT 6.

DEFINE BUTTON bu_OK 
     LABEL "OK" 
     SIZE 10.5 BY 1.43
     FONT 6.

DEFINE VARIABLE fi_password AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 18.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_username AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 18.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 50 BY 5.29
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 50 BY 2.1
     BGCOLOR 18 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_username AT ROW 3.05 COL 19.17 COLON-ALIGNED NO-LABEL
     fi_password AT ROW 4.81 COL 19.17 COLON-ALIGNED NO-LABEL BLANK  DEBLANK 
     bu_OK AT ROW 6.81 COL 14.17
     bu_cancel AT ROW 6.81 COL 27.17
     "Password   :" VIEW-AS TEXT
          SIZE 12 BY 1 AT ROW 4.81 COL 7.17
          BGCOLOR 8 FONT 6
     "              LOGIN LOCKTON (BUInt)" VIEW-AS TEXT
          SIZE 45 BY .95 AT ROW 1.57 COL 4
          BGCOLOR 3 FGCOLOR 1 FONT 6
     "User name :" VIEW-AS TEXT
          SIZE 12 BY 1 AT ROW 3.05 COL 7
          BGCOLOR 8 FONT 6
     RECT-4 AT ROW 1.19 COL 1.67
     RECT-5 AT ROW 6.52 COL 1.67
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 52 BY 8.1
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
  CREATE WINDOW wgwlgint ASSIGN
         HIDDEN             = YES
         TITLE              = "LOGIN - <WGWLGINT>DATA BASE BUInt"
         HEIGHT             = 8.14
         WIDTH              = 52.33
         MAX-HEIGHT         = 16
         MAX-WIDTH          = 80
         VIRTUAL-HEIGHT     = 16
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
IF NOT wgwlgint:LOAD-ICON("adeicon/progress.ico":U) THEN
    MESSAGE "Unable to load icon: adeicon/progress.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW wgwlgint
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fr_main
   FRAME-NAME                                                           */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wgwlgint)
THEN wgwlgint:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME wgwlgint
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wgwlgint wgwlgint
ON END-ERROR OF wgwlgint /* LOGIN - <WGWLGINT>DATA BASE BUInt */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wgwlgint wgwlgint
ON WINDOW-CLOSE OF wgwlgint /* LOGIN - <WGWLGINT>DATA BASE BUInt */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_cancel wgwlgint
ON CHOOSE OF bu_cancel IN FRAME fr_main /* CANCEL */
DO:
  APPLY "Close" TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_OK wgwlgint
ON CHOOSE OF bu_OK IN FRAME fr_main /* OK */
DO:
    ASSIGN
        fi_password = INPUT fi_password
        fi_username = INPUT fi_username.
    IF NOT CONNECTED("BUInt") THEN DO:   
        /*CONNECT BUExt  -H 172.17.2.34  -S 61770    -N tcp -U VALUE(fi_username) -P VALUE(fi_password)  NO-ERROR.  /*Ho*/*/
        /*CONNECT BUExt  -H 16.90.20.201 -S 61770    -N tcp -U VALUE(fi_username) -P VALUE(fi_password)  NO-ERROR.  /*Test*/*/
        /*connect BUInt  -H 16.90.20.201 -S 5022     -N TCP -U VALUE(fi_username) -P VALUE(fi_password)  NO-ERROR.  /*Test*/*/
        /*CONNECT  -db BUINT -H WSBUINT -S BUINT -N TCP -U VALUE(fi_username) -P VALUE(fi_password).   /*Ho*/*//*Comment A62-0105*/
        /*CONNECT  -db BUINT -H tmsth -S BUINT -N TCP -U VALUE(fi_username) -P VALUE(fi_password).   /*Ho*/*/ /*Comment A64-0217*/
        CONNECT  -db BUINT -H TMPMWSDBIP01 -S BUINT -N TCP -U VALUE(fi_username) -P VALUE(fi_password).     /*Ho*/   /*add A64-0217*/    
               
    END.
    
    wgwlgint:HIDDEN = YES.
    
    IF CONNECTED ("BUInt") THEN DO:
        /*RUN RUN WRQ/WRQBQCpLnk.*/
        /*RUN  wgw/wgwBQCpLnk.  */
        RUN  wgw/WGWBQPDFLT. 
    END.
    ELSE DO:
        MESSAGE "Cannot connected Database buint Demilitarized zone."
            VIEW-AS ALERT-BOX ERROR BUTTONS OK TITLE "Invalid LOGON".
    END.
    IF CONNECTED ("BUInt")   THEN DISCONNECT BUInt .
    ASSIGN
        fi_password = ""
        fi_username = "".
    /*DISP fi_password fi_username  WITH FRAME fr_main.*/

    wgwlgint:HIDDEN = NO.
    APPLY "CLOSE" TO THIS-PROCEDURE.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_password
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_password wgwlgint
ON LEAVE OF fi_password IN FRAME fr_main
DO:
  fi_password = INPUT fi_password.
  DISP fi_password WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_username
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_username wgwlgint
ON LEAVE OF fi_username IN FRAME fr_main
DO:
  fi_username = INPUT fi_username.
  DISP fi_username WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK wgwlgint 


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

   RUN  WUT\WUTWICEN (wgwlgint:HANDLE).  
   SESSION:DATA-ENTRY-RETURN = YES.

  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI wgwlgint  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wgwlgint)
  THEN DELETE WIDGET wgwlgint.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI wgwlgint  _DEFAULT-ENABLE
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
  DISPLAY fi_username fi_password 
      WITH FRAME fr_main IN WINDOW wgwlgint.
  ENABLE RECT-4 RECT-5 fi_username fi_password bu_OK bu_cancel 
      WITH FRAME fr_main IN WINDOW wgwlgint.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW wgwlgint.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

