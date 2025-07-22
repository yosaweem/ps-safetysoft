&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
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



DEF INPUT PARAMETER  nv_prem  AS logic.
DEF INPUT PARAMETER  nv_claim AS logic.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_stdate fi_endate ra_poltyp ra_reptyp ~
bu_ok bu_exit RECT-324 
&Scoped-Define DISPLAYED-OBJECTS fi_stdate fi_endate ra_poltyp ra_reptyp ~
fi_outprem fi_outstate fi_osfrom fi_osto fi_outos 

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
     SIZE 6.5 BY 1.19
     FONT 6.

DEFINE BUTTON bu_ok 
     LABEL "Ok" 
     SIZE 6.5 BY 1.19
     FONT 6.

DEFINE VARIABLE fi_endate AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15.5 BY 1.05
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_osfrom AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15.5 BY 1.05
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_osto AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15.5 BY 1.05
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_outos AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 38 BY 1.05
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_outprem AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 38 BY 1.05
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_outstate AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 38 BY 1.05
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_stdate AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15.5 BY 1.05
     FONT 6 NO-UNDO.

DEFINE VARIABLE ra_poltyp AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Motor", 1,
"Non-Motor(not 30/01)", 2,
"30 / 01", 3
     SIZE 48.5 BY 1.05
     FONT 6 NO-UNDO.

DEFINE VARIABLE ra_reptyp AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Detail", 1,
"Summary", 2
     SIZE 23.5 BY 1.05
     FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-324
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 17.5 BY 1.67
     BGCOLOR 2 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     fi_stdate AT ROW 1.95 COL 33 COLON-ALIGNED NO-LABEL
     fi_endate AT ROW 3.52 COL 33 COLON-ALIGNED NO-LABEL
     ra_poltyp AT ROW 5.1 COL 35 NO-LABEL
     ra_reptyp AT ROW 6.67 COL 35 NO-LABEL
     fi_outprem AT ROW 8.19 COL 33 COLON-ALIGNED NO-LABEL
     fi_outstate AT ROW 9.48 COL 33 COLON-ALIGNED NO-LABEL
     fi_osfrom AT ROW 12.67 COL 33 COLON-ALIGNED NO-LABEL
     fi_osto AT ROW 12.67 COL 55.5 COLON-ALIGNED NO-LABEL
     fi_outos AT ROW 14.1 COL 33 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 16.48 COL 57.5
     bu_exit AT ROW 16.48 COL 65.5
     RECT-324 AT ROW 16.24 COL 56
     "Policy Type  :" VIEW-AS TEXT
          SIZE 14.5 BY 1.05 AT ROW 6.67 COL 19.5
          FONT 6
     "Process For O/S Claim  :" VIEW-AS TEXT
          SIZE 25.5 BY 1.05 AT ROW 11.24 COL 9
          FONT 6
     "Trndate From  :" VIEW-AS TEXT
          SIZE 15.5 BY 1.05 AT ROW 1.95 COL 18
          FONT 6
     "To  :" VIEW-AS TEXT
          SIZE 6 BY 1.05 AT ROW 3.52 COL 28
          FONT 6
     "Output File (premium) :" VIEW-AS TEXT
          SIZE 22.5 BY 1.05 AT ROW 8.19 COL 11.5
          FONT 6
     "Policy Type  :" VIEW-AS TEXT
          SIZE 14 BY 1.05 AT ROW 5.1 COL 19.5
          FONT 6
     "Output File (O/S)  :" VIEW-AS TEXT
          SIZE 19.5 BY 1.05 AT ROW 14.1 COL 14.5
          FONT 6
     "Output File (statement) :" VIEW-AS TEXT
          SIZE 23 BY 1.05 AT ROW 9.48 COL 9.5
          FONT 6
     "Trndate From  :" VIEW-AS TEXT
          SIZE 15.5 BY 1.05 AT ROW 12.67 COL 18
          FONT 6
     "To  :" VIEW-AS TEXT
          SIZE 4.5 BY 1.05 AT ROW 12.67 COL 52
          FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 92.33 BY 19.05.


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
         TITLE              = "<insert window title>"
         HEIGHT             = 19.05
         WIDTH              = 92.33
         MAX-HEIGHT         = 19.05
         MAX-WIDTH          = 92.33
         VIRTUAL-HEIGHT     = 19.05
         VIRTUAL-WIDTH      = 92.33
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
IF NOT C-Win:LOAD-ICON("wimage/safety.ico":U) THEN
    MESSAGE "Unable to load icon: wimage/safety.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME DEFAULT-FRAME
                                                                        */
/* SETTINGS FOR FILL-IN fi_osfrom IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_osto IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_outos IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_outprem IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_outstate IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* <insert window title> */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* <insert window title> */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit C-Win
ON CHOOSE OF bu_exit IN FRAME DEFAULT-FRAME /* Exit */
DO:
  APPLY "close" TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok C-Win
ON CHOOSE OF bu_ok IN FRAME DEFAULT-FRAME /* Ok */
DO:
  ASSIGN
    fi_stdate   =  INPUT fi_stdate
    fi_endate   =  INPUT fi_endate
    ra_poltyp   =  INPUT ra_poltyp
    ra_reptyp   =  INPUT ra_reptyp
    fi_osfrom   =  INPUT fi_osfrom
    fi_osto     =  INPUT fi_osto.

    fi_outprem  =  IF index(INPUT fi_outprem,".slk") <> 0 THEN INPUT fi_outprem ELSE INPUT fi_outprem + ".slk" .
    fi_outstate =  IF index(INPUT fi_outstate,".slk") <> 0 THEN INPUT fi_outstate ELSE INPUT fi_outstate + ".slk".
    fi_outos    =  IF index(INPUT fi_outos,".slk") <> 0 THEN INPUT fi_outos ELSE INPUT fi_outos + ".slk".

  DISP  fi_stdate fi_endate ra_poltyp  ra_reptyp fi_osfrom fi_osto  WITH FRAME   {&FRAME-NAME}.
  IF nv_prem = YES THEN DISP fi_outprem WITH FRAME   {&FRAME-NAME}.
  IF nv_claim = YES  THEN DISP fi_outos  fi_outstate WITH FRAME   {&FRAME-NAME}.

  IF nv_prem = YES THEN  DO:  /* process premium */
     IF ra_reptyp = 2 THEN  /* Summary*/
        RUN wac\wac00701(INPUT fi_stdate,
                        INPUT fi_endate,
                        INPUT fi_outprem,
                        INPUT ra_poltyp).
     ELSE 
        RUN wac\wac00702(INPUT fi_stdate,
                        INPUT fi_endate,
                        INPUT fi_outprem,
                        INPUT ra_poltyp).
  END.

  IF nv_claim = YES THEN DO:  /* process os claim/statement */
     IF fi_outos = ""  THEN  DO:
            MESSAGE "output file process o/s claim not blank" VIEW-AS ALERT-BOX.
            APPLY "entry" TO fi_outos.
            RETURN NO-APPLY.
         END.
         IF fi_outstate = ""  THEN DO:
            MESSAGE "output file process statement claim not blank" VIEW-AS ALERT-BOX.
            APPLY "entry" TO fi_outstate.
            RETURN NO-APPLY.
         END.
     IF ra_reptyp = 1 THEN DO:  /* detail */
        /*--o/s claim---*/
        RUN wac\wacoscm(INPUT fi_osfrom,
                        INPUT fi_osto,
                        INPUT fi_outos,
                        INPUT ra_poltyp).
        /*--statement----*/
        RUN wac\wacstate(INPUT fi_stdate,
                         INPUT fi_endate,
                         INPUT fi_outstate,
                         INPUT ra_poltyp).
     END.
     ELSE DO:   /* Summary */
        /*---o/s claim--*/
        RUN wac\wacoscm1(INPUT fi_osfrom,
                        INPUT fi_osto,
                        INPUT fi_outos,
                        INPUT ra_poltyp).
        /*--statement---*/
        RUN wac\wacstat1(INPUT fi_stdate,
                        INPUT fi_endate,
                        INPUT fi_outstate,
                        INPUT ra_poltyp).
     END.
  END.  /* nv_claim = yes */

  


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

     /********************  T I T L E   F O R  C - W I N  ****************/
  DEF  VAR  gv_prgid   AS   CHAR.
  DEF  VAR  gv_prog    AS   CHAR.
  
  gv_prgid = "wacpfit1.w".
  gv_prog  = "  Profit Center Report... ".
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).

/*********************************************************************/ 
   RUN Wut\WutwiCen (C-Win:HANDLE).  
  CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.
  SESSION:DATA-ENTRY-RETURN = YES.

  IF nv_prem = YES THEN do:  /* เฉพาะ premium */
      enable fi_outprem WITH FRAME {&FRAME-NAME}.
/*       DISABLE fi_outstate  fi_outos  WITH FRAME {&FRAME-NAME}. */
  END.
  ELSE DO: 
      DISABLE fi_outprem  WITH FRAME {&FRAME-NAME}.
/*       ENABLE  fi_outstate  fi_outos  WITH FRAME {&FRAME-NAME}. */
  END.

  IF nv_claim = YES THEN do:
      ENABLE  fi_osfrom  fi_osto  fi_outstate fi_outos  WITH FRAME {&FRAME-NAME}.
/*       DISABLE fi_outprem  WITH FRAME {&FRAME-NAME}. */
  END.
  ELSE do:
      DISABLE fi_osfrom  fi_osto fi_outstate fi_outos  WITH FRAME {&FRAME-NAME}.
/*       ENABLE  fi_outprem  WITH FRAME {&FRAME-NAME}. */
  END.
  
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
  DISPLAY fi_stdate fi_endate ra_poltyp ra_reptyp fi_outprem fi_outstate 
          fi_osfrom fi_osto fi_outos 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE fi_stdate fi_endate ra_poltyp ra_reptyp bu_ok bu_exit RECT-324 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

