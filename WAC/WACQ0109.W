&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME Win-wacq0109
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS Win-wacq0109 
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

DEFINE INPUT PARAMETER n_recid   AS   RECID   NO-UNDO.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS bu_exit fi_text RECT-15 RECT-16 RECT-233 ~
RECT-266 
&Scoped-Define DISPLAYED-OBJECTS fi_amtl4 fi_amtl5 fi_amtl6 fi_enttim ~
fi_lattyp fi_thcess fi_cedno fi_cedref fi_cedco fi_comdat fi_cheqpr ~
fi_acccod fi_amtl3 fi_amtl2 fi_entdat fi_bankp fi_cedent fi_usrid fi_insref ~
fi_disput fi_amtl1 fi_latdat fi_clicod fi_text 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR Win-wacq0109 AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_exit 
     LABEL "<< Back" 
     SIZE 12.5 BY 1.14
     FONT 6.

DEFINE VARIABLE fi_acccod AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_amtl1 AS DECIMAL FORMAT ">>,>>>,>>>,>>9.99-":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 25.5 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_amtl2 AS DECIMAL FORMAT ">>,>>>,>>>,>>9.99-":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 25.5 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_amtl3 AS DECIMAL FORMAT ">>,>>>,>>>,>>9.99-":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 25.5 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_amtl4 AS DECIMAL FORMAT ">>,>>>,>>>,>>9.99-":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 25.5 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_amtl5 AS DECIMAL FORMAT ">>,>>>,>>>,>>9.99-":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 25.5 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_amtl6 AS DECIMAL FORMAT ">>,>>>,>>>,>>9.99-":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 25.5 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_bankp AS CHARACTER FORMAT "X(5)":U 
     VIEW-AS FILL-IN 
     SIZE 8.5 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_cedco AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 25.5 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_cedent AS CHARACTER FORMAT "X(9)":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_cedno AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 25.5 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_cedref AS CHARACTER FORMAT "X(16)":U 
     VIEW-AS FILL-IN 
     SIZE 25.5 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_cheqpr AS CHARACTER FORMAT "X(5)":U 
     VIEW-AS FILL-IN 
     SIZE 8.5 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_clicod AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_comdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_disput AS CHARACTER FORMAT "X(5)":U 
     VIEW-AS FILL-IN 
     SIZE 9.5 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_entdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_enttim AS CHARACTER FORMAT "X(8)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_insref AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 25.5 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_latdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 25.5 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_lattyp AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_text AS CHARACTER FORMAT "X(256)":U INITIAL "     TRANSECTION DETAIL (3)" 
      VIEW-AS TEXT 
     SIZE 126 BY 1.05
     BGCOLOR 3 FGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_thcess AS CHARACTER FORMAT "X(12)":U 
     VIEW-AS FILL-IN 
     SIZE 20.5 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_usrid AS CHARACTER FORMAT "X(8)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-15
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 131 BY 23.48
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-16
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 128 BY 1.57
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-233
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 14.5 BY 1.67
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-266
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 128 BY 20.86.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_amtl4 AT ROW 15.33 COL 83 COLON-ALIGNED NO-LABEL
     fi_amtl5 AT ROW 16.38 COL 83 COLON-ALIGNED NO-LABEL
     fi_amtl6 AT ROW 17.43 COL 83 COLON-ALIGNED NO-LABEL
     fi_enttim AT ROW 19.52 COL 83 COLON-ALIGNED NO-LABEL
     fi_lattyp AT ROW 12.24 COL 83 COLON-ALIGNED NO-LABEL
     fi_thcess AT ROW 10.14 COL 83 COLON-ALIGNED NO-LABEL
     fi_cedno AT ROW 9.1 COL 26 COLON-ALIGNED NO-LABEL
     fi_cedref AT ROW 10.14 COL 26 COLON-ALIGNED NO-LABEL
     fi_cedco AT ROW 11.19 COL 26 COLON-ALIGNED NO-LABEL
     bu_exit AT ROW 22.38 COL 115.5
     fi_comdat AT ROW 5.95 COL 26 COLON-ALIGNED NO-LABEL
     fi_cheqpr AT ROW 14.29 COL 26 COLON-ALIGNED NO-LABEL
     fi_acccod AT ROW 4.91 COL 26 COLON-ALIGNED NO-LABEL
     fi_amtl3 AT ROW 17.43 COL 26 COLON-ALIGNED NO-LABEL
     fi_amtl2 AT ROW 16.38 COL 26 COLON-ALIGNED NO-LABEL
     fi_entdat AT ROW 19.52 COL 26 COLON-ALIGNED NO-LABEL
     fi_bankp AT ROW 13.24 COL 26 COLON-ALIGNED NO-LABEL
     fi_cedent AT ROW 9.1 COL 83 COLON-ALIGNED NO-LABEL
     fi_usrid AT ROW 18.48 COL 26 COLON-ALIGNED NO-LABEL
     fi_insref AT ROW 8.05 COL 26 COLON-ALIGNED NO-LABEL
     fi_disput AT ROW 7 COL 26 COLON-ALIGNED NO-LABEL
     fi_amtl1 AT ROW 15.33 COL 26 COLON-ALIGNED NO-LABEL
     fi_latdat AT ROW 12.24 COL 26 COLON-ALIGNED NO-LABEL
     fi_clicod AT ROW 3.86 COL 26 COLON-ALIGNED NO-LABEL
     fi_text AT ROW 2.05 COL 2.5 COLON-ALIGNED NO-LABEL
     "Ceding co. no." VIEW-AS TEXT
          SIZE 14 BY .62 AT ROW 11.43 COL 12
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Print on bank list" VIEW-AS TEXT
          SIZE 17 BY .62 AT ROW 13.52 COL 9.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Their cession no." VIEW-AS TEXT
          SIZE 17 BY .62 AT ROW 10.38 COL 66.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Insured's no." VIEW-AS TEXT
          SIZE 12.5 BY .62 AT ROW 8.29 COL 14
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Latest contra type" VIEW-AS TEXT
          SIZE 18.5 BY .62 AT ROW 12.48 COL 66
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Entered time" VIEW-AS TEXT
          SIZE 13 BY .62 AT ROW 19.76 COL 70.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Latest contra date" VIEW-AS TEXT
          SIZE 18 BY .62 AT ROW 12.48 COL 8
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Print cheque" VIEW-AS TEXT
          SIZE 12.5 BY .62 AT ROW 14.57 COL 14
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Our cess end. no." VIEW-AS TEXT
          SIZE 18 BY .62 AT ROW 9.33 COL 66
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Their policy no." VIEW-AS TEXT
          SIZE 15 BY .62 AT ROW 10.38 COL 11.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "A/C type code" VIEW-AS TEXT
          SIZE 14.5 BY .62 AT ROW 5.19 COL 12
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "GL amount 6 (Local)" VIEW-AS TEXT
          SIZE 20.5 BY .62 AT ROW 17.71 COL 64
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Cover comm date" VIEW-AS TEXT
          SIZE 17.5 BY .62 AT ROW 6.24 COL 9
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Dispute code" VIEW-AS TEXT
          SIZE 13.5 BY .62 AT ROW 7.24 COL 13
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Our cession no." VIEW-AS TEXT
          SIZE 15.5 BY .62 AT ROW 9.33 COL 11.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "GL amount 1 (Local)" VIEW-AS TEXT
          SIZE 19.5 BY .62 AT ROW 15.62 COL 6.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133.33 BY 24.04
         BGCOLOR 3 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "GL amount 2 (Local)" VIEW-AS TEXT
          SIZE 19.5 BY .62 AT ROW 16.67 COL 6.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Client type code" VIEW-AS TEXT
          SIZE 17 BY .62 AT ROW 4.14 COL 10
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "GL amount 3 (Local)" VIEW-AS TEXT
          SIZE 20 BY .62 AT ROW 17.71 COL 6.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "GL amount 4 (Local)" VIEW-AS TEXT
          SIZE 20.5 BY .62 AT ROW 15.62 COL 64
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "GL amount 5 (Local)" VIEW-AS TEXT
          SIZE 20 BY .52 AT ROW 16.67 COL 64
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "User Id" VIEW-AS TEXT
          SIZE 8 BY .62 AT ROW 18.76 COL 18.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Entered date" VIEW-AS TEXT
          SIZE 12.5 BY .62 AT ROW 19.76 COL 13.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     RECT-15 AT ROW 1.24 COL 2
     RECT-16 AT ROW 1.76 COL 3.5
     RECT-233 AT ROW 22.14 COL 114.5
     RECT-266 AT ROW 3.33 COL 3.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133.33 BY 24.04
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
  CREATE WINDOW Win-wacq0109 ASSIGN
         HIDDEN             = YES
         TITLE              = "Wacq0109 : Transaction Detail (3)"
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
IF NOT Win-wacq0109:LOAD-ICON("WIMAGE\safety":U) THEN
    MESSAGE "Unable to load icon: WIMAGE\safety"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW Win-wacq0109
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fr_main
   Custom                                                               */
/* SETTINGS FOR FILL-IN fi_acccod IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_amtl1 IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_amtl2 IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_amtl3 IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_amtl4 IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_amtl5 IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_amtl6 IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_bankp IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_cedco IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_cedent IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_cedno IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_cedref IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_cheqpr IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_clicod IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_comdat IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_disput IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_entdat IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_enttim IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_insref IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_latdat IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_lattyp IN FRAME fr_main
   NO-ENABLE                                                            */
ASSIGN 
       fi_text:RESIZABLE IN FRAME fr_main        = TRUE.

/* SETTINGS FOR FILL-IN fi_thcess IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_usrid IN FRAME fr_main
   NO-ENABLE                                                            */
ASSIGN 
       RECT-16:HIDDEN IN FRAME fr_main           = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(Win-wacq0109)
THEN Win-wacq0109:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Win-wacq0109
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Win-wacq0109 Win-wacq0109
ON END-ERROR OF Win-wacq0109 /* Wacq0109 : Transaction Detail (3) */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Win-wacq0109 Win-wacq0109
ON WINDOW-CLOSE OF Win-wacq0109 /* Wacq0109 : Transaction Detail (3) */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit Win-wacq0109
ON CHOOSE OF bu_exit IN FRAME fr_main /* << Back */
DO:
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK Win-wacq0109 


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
  
  gv_prgid = "wacq0109".
  gv_prog  = "Transaction Detail(3)".
  RUN  WUT\WUTHEAD (Win-wacq0109:handle,gv_prgid,gv_prog).
  RUN  WUT\WUTWICEN (Win-wacq0109:handle). 

/*********************************************************************/       
   Run Check_data.
                                  
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
       WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Check_data Win-wacq0109 
PROCEDURE Check_data :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
Find acm001 WHERE Recid(acm001) = n_recid.

Assign
     fi_clicod = acm001.clicod 
     fi_acccod = acm001.acccod
     fi_comdat = acm001.comdat
     fi_disput = string(acm001.disput)
     fi_insref = acm001.insref
     fi_cedno  = acm001.cedno
     fi_cedent = acm001.cedent
     fi_cedref = acm001.cedref 
     fi_thcess = acm001.thcess
     fi_cedco  = acm001.cedco
     fi_latdat = acm001.latdat
     fi_lattyp = acm001.lattyp
     fi_bankp  = string(acm001.bankp)
     fi_usrid  =  acm001.usrid
     fi_entdat = acm001.entdat
     fi_enttim = acm001.enttim
     fi_amtl1  = acm001.amtl1 
     fi_amtl2  = acm001.amtl2
     fi_amtl3  = acm001.amtl3
     fi_amtl4  = acm001.amtl4
     fi_amtl5  = acm001.amtl5
     fi_amtl6  = acm001.amtl6.
     
Disp
     fi_clicod  fi_acccod  fi_comdat   fi_disput   fi_insref 
     fi_cedno   fi_cedent  fi_cedref   fi_thcess   fi_cedco 
     fi_latdat  fi_lattyp  fi_bankp    fi_usrid    fi_entdat 
     fi_enttim  fi_amtl1   fi_amtl2    fi_amtl3    fi_amtl4
     fi_amtl5   fi_amtl6   With  Frame fr_main.
      
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI Win-wacq0109  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(Win-wacq0109)
  THEN DELETE WIDGET Win-wacq0109.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI Win-wacq0109  _DEFAULT-ENABLE
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
  DISPLAY fi_amtl4 fi_amtl5 fi_amtl6 fi_enttim fi_lattyp fi_thcess fi_cedno 
          fi_cedref fi_cedco fi_comdat fi_cheqpr fi_acccod fi_amtl3 fi_amtl2 
          fi_entdat fi_bankp fi_cedent fi_usrid fi_insref fi_disput fi_amtl1 
          fi_latdat fi_clicod fi_text 
      WITH FRAME fr_main IN WINDOW Win-wacq0109.
  ENABLE bu_exit fi_text RECT-15 RECT-16 RECT-233 RECT-266 
      WITH FRAME fr_main IN WINDOW Win-wacq0109.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW Win-wacq0109.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

