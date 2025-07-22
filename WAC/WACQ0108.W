&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME Win-wacq0108
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS Win-wacq0108 
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

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-15 RECT-16 RECT-233 RECT-235 RECT-265 ~
bu_next bu_exit fi_text 
&Scoped-Define DISPLAYED-OBJECTS fi_ac_yr fi_daddr2 fi_daddr3 fi_daddr4 ~
fi_docaie fi_detal2 fi_recno fi_erldat fi_mlno fi_ac_mth fi_detal1 ~
fi_comdat fi_trangp fi_daddr1 fi_dname fi_mltyp1 fi_dpostc fi_policy ~
fi_text 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR Win-wacq0108 AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_exit 
     LABEL "<< Back" 
     SIZE 12.5 BY 1.13
     FONT 6.

DEFINE BUTTON bu_next 
     LABEL "Next >>" 
     SIZE 12.5 BY 1.13
     FONT 6.

DEFINE VARIABLE fi_ac_mth AS INTEGER FORMAT "99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 5 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_ac_yr AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 7 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_comdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_daddr1 AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 72 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_daddr2 AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 72 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_daddr3 AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 72 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_daddr4 AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 72 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_detal1 AS CHARACTER FORMAT "X(58)":U 
     VIEW-AS FILL-IN 
     SIZE 80.5 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_detal2 AS CHARACTER FORMAT "X(58)":U 
     VIEW-AS FILL-IN 
     SIZE 80.5 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_dname AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 75.5 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_docaie AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4.5 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_dpostc AS CHARACTER FORMAT "X(8)":U 
     VIEW-AS FILL-IN 
     SIZE 15.5 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_erldat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_mlno AS CHARACTER FORMAT "X(7)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_mltyp1 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_policy AS CHARACTER FORMAT "X(16)":U 
     VIEW-AS FILL-IN 
     SIZE 23.5 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_recno AS CHARACTER FORMAT "X(12)":U 
     VIEW-AS FILL-IN 
     SIZE 19 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_text AS CHARACTER FORMAT "X(256)":U INITIAL "     TRANSECTION DETAIL (2)" 
      VIEW-AS TEXT 
     SIZE 126 BY 1.04
     BGCOLOR 3 FGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_trangp AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
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
     SIZE 14.5 BY 1.65
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-235
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 14.5 BY 1.65
     BGCOLOR 1 FGCOLOR 1 .

DEFINE RECTANGLE RECT-265
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 128 BY 20.87.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_ac_yr AT ROW 20.57 COL 38.5 COLON-ALIGNED NO-LABEL
     fi_daddr2 AT ROW 9.09 COL 38.5 COLON-ALIGNED NO-LABEL
     fi_daddr3 AT ROW 10.13 COL 38.5 COLON-ALIGNED NO-LABEL
     fi_daddr4 AT ROW 11.17 COL 38.5 COLON-ALIGNED NO-LABEL
     bu_next AT ROW 19.78 COL 115.5
     bu_exit AT ROW 22.39 COL 115.5
     fi_docaie AT ROW 5.96 COL 38.5 COLON-ALIGNED NO-LABEL
     fi_detal2 AT ROW 14.3 COL 38.5 COLON-ALIGNED NO-LABEL
     fi_recno AT ROW 4.91 COL 38.5 COLON-ALIGNED NO-LABEL
     fi_erldat AT ROW 17.44 COL 38.5 COLON-ALIGNED NO-LABEL
     fi_mlno AT ROW 16.39 COL 38.5 COLON-ALIGNED NO-LABEL
     fi_ac_mth AT ROW 19.52 COL 38.5 COLON-ALIGNED NO-LABEL
     fi_detal1 AT ROW 13.26 COL 38.5 COLON-ALIGNED NO-LABEL
     fi_comdat AT ROW 3.87 COL 90.5 COLON-ALIGNED NO-LABEL
     fi_trangp AT ROW 18.48 COL 38.5 COLON-ALIGNED NO-LABEL
     fi_daddr1 AT ROW 8.04 COL 38.5 COLON-ALIGNED NO-LABEL
     fi_dname AT ROW 7 COL 38.5 COLON-ALIGNED NO-LABEL
     fi_mltyp1 AT ROW 15.35 COL 38.5 COLON-ALIGNED NO-LABEL
     fi_dpostc AT ROW 12.22 COL 38.5 COLON-ALIGNED NO-LABEL
     fi_policy AT ROW 3.87 COL 38.5 COLON-ALIGNED NO-LABEL
     fi_text AT ROW 2.04 COL 2.5 COLON-ALIGNED NO-LABEL
     RECT-15 AT ROW 1.26 COL 2
     RECT-16 AT ROW 1.78 COL 3.5
     RECT-233 AT ROW 22.13 COL 114.5
     RECT-235 AT ROW 19.52 COL 114.5
     RECT-265 AT ROW 3.35 COL 3.5
     "Policy No." VIEW-AS TEXT
          SIZE 11 BY .61 AT ROW 4.13 COL 28.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Name" VIEW-AS TEXT
          SIZE 6.5 BY .61 AT ROW 7.26 COL 32.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Address" VIEW-AS TEXT
          SIZE 8 BY .61 AT ROW 8.3 COL 30
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Pc" VIEW-AS TEXT
          SIZE 4 BY .61 AT ROW 12.48 COL 35
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Detail" VIEW-AS TEXT
          SIZE 6.5 BY .61 AT ROW 13.52 COL 32
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Match Later : Transaction Type" VIEW-AS TEXT
          SIZE 31 BY .61 AT ROW 15.61 COL 8
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Document No." VIEW-AS TEXT
          SIZE 14 BY .61 AT ROW 16.65 COL 25
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Earliest Tran. Date to match" VIEW-AS TEXT
          SIZE 27.5 BY .61 AT ROW 17.7 COL 11.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Transaction group." VIEW-AS TEXT
          SIZE 18.5 BY .61 AT ROW 18.74 COL 20.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Account period, mth." VIEW-AS TEXT
          SIZE 20.5 BY .61 AT ROW 19.78 COL 18.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Account period, yr." VIEW-AS TEXT
          SIZE 18.5 BY .61 AT ROW 20.83 COL 20.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Commencement Date" VIEW-AS TEXT
          SIZE 21 BY .61 AT ROW 4.13 COL 71
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Ren/End/Claim No." VIEW-AS TEXT
          SIZE 18.5 BY .61 AT ROW 5.17 COL 20
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Recpt-Agt/Ins/Enter" VIEW-AS TEXT
          SIZE 20.5 BY .61 AT ROW 6.22 COL 18.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
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
  CREATE WINDOW Win-wacq0108 ASSIGN
         HIDDEN             = YES
         TITLE              = "Wacq0108 : Transaction Detail (2)"
         HEIGHT             = 24.04
         WIDTH              = 133.33
         MAX-HEIGHT         = 24.04
         MAX-WIDTH          = 133.33
         VIRTUAL-HEIGHT     = 24.04
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

IF NOT Win-wacq0108:LOAD-ICON("WIMAGE\safety":U) THEN
    MESSAGE "Unable to load icon: WIMAGE\safety"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME


/* ***************  Runtime Attributes and UIB Settings  ************** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW Win-wacq0108
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fr_main
   Custom                                                               */
/* SETTINGS FOR FILL-IN fi_ac_mth IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_ac_yr IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_comdat IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_daddr1 IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_daddr2 IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_daddr3 IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_daddr4 IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_detal1 IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_detal2 IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_dname IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_docaie IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_dpostc IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_erldat IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_mlno IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_mltyp1 IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_policy IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_recno IN FRAME fr_main
   NO-ENABLE                                                            */
ASSIGN 
       fi_text:RESIZABLE IN FRAME fr_main        = TRUE.

/* SETTINGS FOR FILL-IN fi_trangp IN FRAME fr_main
   NO-ENABLE                                                            */
ASSIGN 
       RECT-16:HIDDEN IN FRAME fr_main           = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(Win-wacq0108)
THEN Win-wacq0108:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 




/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Win-wacq0108
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Win-wacq0108 Win-wacq0108
ON END-ERROR OF Win-wacq0108 /* Wacq0108 : Transaction Detail (2) */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Win-wacq0108 Win-wacq0108
ON WINDOW-CLOSE OF Win-wacq0108 /* Wacq0108 : Transaction Detail (2) */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit Win-wacq0108
ON CHOOSE OF bu_exit IN FRAME fr_main /* << Back */
DO:
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_next
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_next Win-wacq0108
ON CHOOSE OF bu_next IN FRAME fr_main /* Next >> */
DO:
  Win-wacq0108:Hidden = Yes.       
  Run wac/wacq0109 (Input n_recid).                              
  Win-wacq0108:Hidden = No.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK Win-wacq0108 


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
  
  gv_prgid = "wacq0108".
  gv_prog  = "Transaction Detail(2)".
  RUN  WUT\WUTHEAD (Win-wacq0108:handle,gv_prgid,gv_prog).
  RUN  WUT\WUTWICEN (Win-wacq0108:handle). 

/*********************************************************************/        
   Run Check_data.
                                  
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
       WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Check_data Win-wacq0108 
PROCEDURE Check_data :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
Find acm001 WHERE Recid(acm001) = n_recid.

Assign
        fi_policy = acm001.policy 
        fi_comdat = acm001.comdat 
        fi_recno = acm001.recno
        fi_docaie = acm001.docaie 
        fi_dname = acm001.dname 
        fi_daddr1 = acm001.daddr1
        fi_daddr2 = acm001.daddr2
        fi_daddr3 = acm001.daddr3
        fi_daddr4 = acm001.daddr4 
        fi_dpostc = acm001.dpostc
        fi_detal1 = acm001.detal1
        fi_detal2 = acm001.detal2
        fi_mltyp1 = acm001.mltyp1 
        fi_mlno = acm001.mlno
        fi_erldat = acm001.erldat
        fi_trangp = acm001.trangp
        fi_ac_mth = acm001.ac_mth
        fi_ac_yr = acm001.ac_yr.
    
Disp 
        fi_policy    fi_comdat   fi_recno      fi_docaie   fi_dname    fi_daddr1
        fi_daddr2  fi_daddr3    fi_daddr4   fi_dpostc   fi_detal1      fi_detal2 
        fi_mltyp1   fi_mlno        fi_erldat     fi_trangp    fi_ac_mth     fi_ac_yr 
        With Frame fr_main.
      
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI Win-wacq0108 _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(Win-wacq0108)
  THEN DELETE WIDGET Win-wacq0108.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI Win-wacq0108 _DEFAULT-ENABLE
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
  DISPLAY fi_ac_yr fi_daddr2 fi_daddr3 fi_daddr4 fi_docaie fi_detal2 fi_recno 
          fi_erldat fi_mlno fi_ac_mth fi_detal1 fi_comdat fi_trangp fi_daddr1 
          fi_dname fi_mltyp1 fi_dpostc fi_policy fi_text 
      WITH FRAME fr_main IN WINDOW Win-wacq0108.
  ENABLE RECT-15 RECT-16 RECT-233 RECT-235 RECT-265 bu_next bu_exit fi_text 
      WITH FRAME fr_main IN WINDOW Win-wacq0108.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW Win-wacq0108.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


