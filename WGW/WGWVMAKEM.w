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
/*Modify By Chaiyong W. A57-0365 03/11/2014 */
/*          Change format bchno  13 to 30   */
/*Modify By : Kridtiya i. A58-0017 ปิดส่วนการ lock uwm100 เพิ่มคำสั่ง no-lock */
/*Modify By : Nontawat P. A59-0019 14/01/2016 update make model ให้เปิดช่อง เลขทะเบียนรถ */
CREATE WIDGET-POOL.

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_exit AUTO-END-KEY 
     LABEL "Exit" 
     SIZE 14 BY 1.14
     FONT 2.

DEFINE BUTTON bu_search 
     LABEL "Search" 
     SIZE 25.5 BY 1.14
     FONT 2.

DEFINE BUTTON bu_update 
     LABEL "Update" 
     SIZE 14 BY 1.14
     FONT 2.

DEFINE VARIABLE fi_bchcnt AS INTEGER FORMAT "99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 5 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_bchno AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 27 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_bchyr AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 7 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_body AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 24 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_chano AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 27 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_class AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 8 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_cldes AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 61.67 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_covcod AS CHARACTER FORMAT "X(4)":U 
     VIEW-AS FILL-IN 
     SIZE 8 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_endcnt AS INTEGER FORMAT "999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 5 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_engine AS INTEGER FORMAT ">>>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 8 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_engno AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 27 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_garage AS CHARACTER FORMAT "X":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_itemno AS INTEGER FORMAT "999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 5 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_logbok AS CHARACTER FORMAT "X":U 
     VIEW-AS FILL-IN 
     SIZE 5.5 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_modcod AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 18.5 BY 1
     BGCOLOR 11 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_moddes AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 68 BY 1
     BGCOLOR 11 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_pol AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 32 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_rencnt AS INTEGER FORMAT "999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 5 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_riskno AS INTEGER FORMAT "999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 5 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_seats AS INTEGER FORMAT ">>>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 7 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_tariff AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 8 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_tons AS DECIMAL FORMAT ">>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 8 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_update AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 88.5 BY 1
     BGCOLOR 15 FGCOLOR 6 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_vehgrp AS CHARACTER FORMAT "X":U 
     VIEW-AS FILL-IN 
     SIZE 8 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_vehreg AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 17.67 BY 1
     BGCOLOR 11 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_vehuse AS CHARACTER FORMAT "X":U 
     VIEW-AS FILL-IN 
     SIZE 8 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_yrmanu AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 8 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 1 GRAPHIC-EDGE    
     SIZE 107.5 BY 9.95
     BGCOLOR 18 .

DEFINE RECTANGLE RECT-650
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 15.5 BY 1.67
     BGCOLOR 2 .

DEFINE RECTANGLE RECT-651
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 15.5 BY 1.67
     BGCOLOR 6 FGCOLOR 7 .

DEFINE RECTANGLE RECT-653
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 108 BY 4
     BGCOLOR 18 .

DEFINE RECTANGLE RECT-654
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 30 BY 1.76
     BGCOLOR 3 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 112.33 BY 21.05.

DEFINE FRAME fr_head
     "Update Make~\Model Motor Policy" VIEW-AS TEXT
          SIZE 39.33 BY 2.14 AT ROW 1.48 COL 33
          FGCOLOR 7 FONT 23
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 2.5 ROW 1.38
         SIZE 110 BY 2.86
         BGCOLOR 3 .

DEFINE FRAME fr_update
     bu_exit AT ROW 16.05 COL 67.33
     bu_search AT ROW 2.95 COL 78.17
     fi_pol AT ROW 1.52 COL 15 COLON-ALIGNED NO-LABEL
     fi_rencnt AT ROW 1.52 COL 54.67 COLON-ALIGNED NO-LABEL
     fi_endcnt AT ROW 1.52 COL 62.5 COLON-ALIGNED NO-LABEL
     fi_riskno AT ROW 1.52 COL 90.33 COLON-ALIGNED NO-LABEL
     fi_itemno AT ROW 1.52 COL 98.67 COLON-ALIGNED NO-LABEL
     fi_bchyr AT ROW 2.95 COL 15 COLON-ALIGNED NO-LABEL
     fi_bchno AT ROW 2.95 COL 27.67 COLON-ALIGNED NO-LABEL
     fi_bchcnt AT ROW 2.95 COL 62.67 COLON-ALIGNED NO-LABEL
     fi_modcod AT ROW 7 COL 15.67 COLON-ALIGNED NO-LABEL
     fi_moddes AT ROW 7 COL 36 COLON-ALIGNED NO-LABEL
     fi_vehreg AT ROW 12.24 COL 15.67 COLON-ALIGNED NO-LABEL
     bu_update AT ROW 16.05 COL 35.33
     fi_tariff AT ROW 5.67 COL 95.83 COLON-ALIGNED NO-LABEL
     fi_class AT ROW 5.67 COL 15.67 COLON-ALIGNED NO-LABEL
     fi_cldes AT ROW 5.67 COL 24.5 COLON-ALIGNED NO-LABEL
     fi_logbok AT ROW 8.38 COL 98.33 COLON-ALIGNED NO-LABEL
     fi_vehgrp AT ROW 8.38 COL 42.5 COLON-ALIGNED NO-LABEL
     fi_body AT ROW 8.38 COL 61 COLON-ALIGNED NO-LABEL
     fi_yrmanu AT ROW 8.38 COL 15.67 COLON-ALIGNED NO-LABEL
     fi_vehuse AT ROW 10.95 COL 15.67 COLON-ALIGNED NO-LABEL
     fi_covcod AT ROW 10.95 COL 42.5 COLON-ALIGNED NO-LABEL
     fi_garage AT ROW 10.95 COL 61 COLON-ALIGNED NO-LABEL
     fi_seats AT ROW 9.67 COL 61 COLON-ALIGNED NO-LABEL
     fi_engine AT ROW 9.67 COL 15.67 COLON-ALIGNED NO-LABEL
     fi_tons AT ROW 9.67 COL 42.5 COLON-ALIGNED NO-LABEL
     fi_engno AT ROW 12.24 COL 76.83 COLON-ALIGNED NO-LABEL
     fi_chano AT ROW 12.24 COL 42.5 COLON-ALIGNED NO-LABEL
     fi_update AT ROW 13.57 COL 15.33 COLON-ALIGNED NO-LABEL
     "Batch Year   :" VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 2.95 COL 2.5
          FGCOLOR 1 FONT 6
     "Veh Use" VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 10.95 COL 3
          FGCOLOR 1 FONT 6
     "  Garage" VIEW-AS TEXT
          SIZE 8.5 BY 1 AT ROW 10.95 COL 53.83
          FGCOLOR 1 FONT 6
     "R/E" VIEW-AS TEXT
          SIZE 5 BY 1 AT ROW 1.52 COL 51.33
          FGCOLOR 1 FONT 6
     "Count" VIEW-AS TEXT
          SIZE 7 BY 1 AT ROW 2.95 COL 57.17
          FGCOLOR 1 FONT 6
     "CC's" VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 9.67 COL 3
          FGCOLOR 1 FONT 6
     "  Coverage" VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 10.95 COL 32.67
          FGCOLOR 1 FONT 6
     "Class" VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 5.67 COL 3
          FGCOLOR 1 FONT 6
     "Make/Model" VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 7 COL 3
          FGCOLOR 1 FONT 6
     "  Seats" VIEW-AS TEXT
          SIZE 7 BY 1 AT ROW 9.67 COL 55.17
          FGCOLOR 1 FONT 6
     "  Inspection" VIEW-AS TEXT
          SIZE 12 BY 1 AT ROW 8.38 COL 87.67
          FGCOLOR 1 FONT 6
     "/" VIEW-AS TEXT
          SIZE 2.5 BY 1 AT ROW 1.52 COL 97.67
          FGCOLOR 1 FONT 2
     "Policy No     :" VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 1.52 COL 2.5
          FGCOLOR 1 FONT 6
     "  Chass" VIEW-AS TEXT
          SIZE 7.5 BY 1 AT ROW 12.24 COL 36.17
          FGCOLOR 1 FONT 6
     "  Ton." VIEW-AS TEXT
          SIZE 6 BY 1 AT ROW 9.67 COL 37.5
          FGCOLOR 1 FONT 6
     "Veh. Reg" VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 12.24 COL 3
          FGCOLOR 1 FONT 6
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 2.5 ROW 4.33
         SIZE 110 BY 17.38
         BGCOLOR 19 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_update
     "   Veh. Group" VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 8.38 COL 30.67
          FGCOLOR 1 FONT 6
     "     Risk / Item" VIEW-AS TEXT
          SIZE 15 BY 1 AT ROW 1.52 COL 77
          FGCOLOR 1 FONT 6
     "  Tariff" VIEW-AS TEXT
          SIZE 8 BY 1 AT ROW 5.67 COL 89.17
          FGCOLOR 1 FONT 6
     "No." VIEW-AS TEXT
          SIZE 4.5 BY 1 AT ROW 2.95 COL 24.5
          FGCOLOR 1 FONT 6
     "/" VIEW-AS TEXT
          SIZE 2 BY 1 AT ROW 1.52 COL 62
          FGCOLOR 1 FONT 2
     " Body" VIEW-AS TEXT
          SIZE 6.33 BY 1 AT ROW 8.38 COL 56
          FGCOLOR 1 FONT 6
     "Year" VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 8.38 COL 3
          FGCOLOR 1 FONT 6
     " Eng." VIEW-AS TEXT
          SIZE 5.83 BY 1 AT ROW 12.24 COL 72.33
          FGCOLOR 1 FONT 6
     RECT-1 AT ROW 5.33 COL 2
     RECT-650 AT ROW 15.76 COL 34.67
     RECT-651 AT ROW 15.76 COL 66.5
     RECT-653 AT ROW 1.14 COL 1.5
     RECT-654 AT ROW 2.67 COL 75.83
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 2.5 ROW 4.33
         SIZE 110 BY 17.38
         BGCOLOR 19 .


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
         TITLE              = "WGWVMAKEM : Update MakeModel Motor Policy"
         HEIGHT             = 21.14
         WIDTH              = 112.67
         MAX-HEIGHT         = 30.43
         MAX-WIDTH          = 135.33
         VIRTUAL-HEIGHT     = 30.43
         VIRTUAL-WIDTH      = 135.33
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
IF NOT C-Win:LOAD-ICON("WIMAGE\safety":U) THEN
    MESSAGE "Unable to load icon: WIMAGE\safety"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* REPARENT FRAME */
ASSIGN FRAME fr_head:FRAME = FRAME DEFAULT-FRAME:HANDLE
       FRAME fr_update:FRAME = FRAME DEFAULT-FRAME:HANDLE.

/* SETTINGS FOR FRAME DEFAULT-FRAME
   FRAME-NAME                                                           */

DEFINE VARIABLE XXTABVALXX AS LOGICAL NO-UNDO.

ASSIGN XXTABVALXX = FRAME fr_head:MOVE-BEFORE-TAB-ITEM (FRAME fr_update:HANDLE)
/* END-ASSIGN-TABS */.

/* SETTINGS FOR FRAME fr_head
                                                                        */
/* SETTINGS FOR FRAME fr_update
   Custom                                                               */
/* SETTINGS FOR FILL-IN fi_body IN FRAME fr_update
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_chano IN FRAME fr_update
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_class IN FRAME fr_update
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_cldes IN FRAME fr_update
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_covcod IN FRAME fr_update
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_endcnt IN FRAME fr_update
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_engine IN FRAME fr_update
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_engno IN FRAME fr_update
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_garage IN FRAME fr_update
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_logbok IN FRAME fr_update
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_rencnt IN FRAME fr_update
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_seats IN FRAME fr_update
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_tariff IN FRAME fr_update
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_tons IN FRAME fr_update
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_update IN FRAME fr_update
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_vehgrp IN FRAME fr_update
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_vehreg IN FRAME fr_update
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_vehuse IN FRAME fr_update
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_yrmanu IN FRAME fr_update
   NO-ENABLE                                                            */
/* SETTINGS FOR RECTANGLE RECT-1 IN FRAME fr_update
   NO-ENABLE                                                            */
/* SETTINGS FOR RECTANGLE RECT-650 IN FRAME fr_update
   NO-ENABLE                                                            */
/* SETTINGS FOR RECTANGLE RECT-651 IN FRAME fr_update
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* WGWVMAKEM : Update MakeModel Motor Policy */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* WGWVMAKEM : Update MakeModel Motor Policy */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_update
&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit C-Win
ON CHOOSE OF bu_exit IN FRAME fr_update /* Exit */
DO:
    APPLY "Close" TO THIS-PROCEDURE.
    RETURN No-Apply.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_search
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_search C-Win
ON CHOOSE OF bu_search IN FRAME fr_update /* Search */
DO:
    DEF VAR n_status AS CHAR INIT "".

    fi_pol = TRIM(CAPS(INPUT fi_pol)).
    fi_riskno = INPUT fi_riskno.
    fi_itemno = INPUT fi_itemno.
    fi_bchcnt = INPUT fi_bchcnt.
    fi_bchyr  = INPUT fi_bchyr.
    fi_bchno  = TRIM(INPUT fi_bchno).

    RUN pd_clear2.
    IF fi_pol = "" THEN DO:
        MESSAGE "Policy No is mandatory Field!!!" VIEW-AS ALERT-BOX INFORMATION.
        APPLY "entry" TO fi_pol.
        RETURN NO-APPLY.
    END.
    
    fi_update = "Search Policy No.".
    DISP fi_update WITH FRAME fr_update.
    DISP fi_pol WITH FRAME fr_update.



    FIND LAST sic_bran.uwm100 USE-INDEX uwm10001 WHERE uwm100.policy = fi_pol    AND
                                              uwm100.rencnt = fi_rencnt AND 
                                              uwm100.endcnt = fi_endcnt AND 
                                              uwm100.bchyr  = fi_bchyr  AND 
                                              uwm100.bchno  = fi_bchno  AND 
                                              uwm100.bchcnt = fi_bchcnt NO-LOCK NO-ERROR.
    IF AVAIL uwm100 THEN DO:
        IF uwm100.releas = NO THEN DO:
            ASSIGN
                fi_rencnt = uwm100.rencnt
                fi_endcnt = uwm100.endcnt
                fi_bchyr  = uwm100.bchyr 
                fi_bchno  = uwm100.bchno
                fi_bchcnt = uwm100.bchcnt.
    
            FIND FIRST sic_bran.uwm301 USE-INDEX uwm30101 WHERE uwm301.policy = uwm100.policy  AND 
                                               uwm301.rencnt = uwm100.rencnt  AND 
                                               uwm301.endcnt = uwm100.endcnt  AND
                                               uwm301.riskno = fi_riskno      AND
                                               uwm301.itemno = fi_itemno      AND
                                               uwm301.bchyr  = uwm100.bchyr   AND 
                                               uwm301.bchno  = uwm100.bchno   AND 
                                               uwm301.bchcnt = uwm100.bchcnt  NO-LOCK NO-ERROR.
            IF AVAIL uwm301 THEN DO:
                RUN pd_search.
                APPLY "entry" TO fi_modcod.
                RETURN NO-APPLY.
            END.
            ELSE DO:
                 MESSAGE "Not Found Policy in GW System Please Check Policy Again (uwm301)" VIEW-AS ALERT-BOX INFORMATION.
                fi_update = "Search Not Found Detail Vehicle".
                DISP fi_update WITH FRAME fr_update.
                APPLY "entry" TO fi_riskno.
                RETURN NO-APPLY. 
    
            END.
        END.
        ELSE DO:
            fi_update = "Policy No :" + uwm100.policy + " Transfer to Premium!!".
            DISP fi_update WITH FRAME fr_update.
            APPLY "entry" TO fi_riskno.
            RETURN NO-APPLY. 

        END.
    END.
    ELSE DO:        /*
        n_status = "Search Not Found riskno:" +  STRING(fi_riskno,"999") + " itmno:" + STRING(fi_itemno,"999") .
        RUN pd_clear.
        FIND LAST uwm301 WHERE uwm301.policy = fi_pol NO-LOCK NO-ERROR.
        IF AVAIL uwm301 THEN DO:
            ASSIGN
                fi_rencnt = uwm301.rencnt
                fi_endcnt = uwm301.endcnt
                fi_bchyr  = uwm301.bchyr 
                fi_bchno  = uwm301.bchno
                fi_bchcnt = uwm301.bchcnt.
            RUN pd_search.
           
            fi_update = n_status.
            DISP fi_update WITH FRAME fr_update.
            APPLY "entry" TO fi_modcod.
            RETURN NO-APPLY.
        END.
        ELSE DO:  */
            MESSAGE "Not Found Policy in GW System Please Check Policy Again (uwm100)" VIEW-AS ALERT-BOX INFORMATION.
            fi_update = "Search Not Found Name & Address Master".
            DISP fi_update WITH FRAME fr_update.
            APPLY "entry" TO fi_riskno.
            RETURN NO-APPLY. /*
        END.  */

    END.


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_update
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_update C-Win
ON CHOOSE OF bu_update IN FRAME fr_update /* Update */
DO:

    fi_pol    = TRIM(CAPS(INPUT fi_pol)).
    fi_rencnt = INPUT fi_rencnt.
    fi_endcnt = INPUT fi_endcnt.
    fi_bchyr  = INPUT fi_bchyr.
    fi_bchno  = TRIM(INPUT fi_bchno).
    fi_bchcnt = INPUT fi_bchcnt.
    fi_riskno = INPUT fi_riskno.
    fi_itemno = INPUT fi_itemno.
    fi_modcod = TRIM(INPUT fi_modcod).
    fi_moddes = TRIM(INPUT fi_moddes).
    fi_vehreg = TRIM(INPUT fi_vehreg). /*A59-0019 nontawat 14/01/2016*/


    IF fi_modcod = "" OR fi_moddes = "" THEN DO:
        MESSAGE "Make / Model is not madatory field!!" VIEW-AS ALERT-BOX INFORMATION.
        APPLY "Entry" TO fi_modcod.
        RETURN NO-APPLY.
    END.
    FIND LAST sic_bran.uwm100 USE-INDEX uwm10001 WHERE uwm100.policy = fi_pol    AND
                                              uwm100.rencnt = fi_rencnt AND 
                                              uwm100.endcnt = fi_endcnt AND 
                                              uwm100.bchyr  = fi_bchyr  AND 
                                              uwm100.bchno  = fi_bchno  AND 
                                              uwm100.bchcnt = fi_bchcnt 
        /*EXCLUSIVE-LOCK NO-WAIT NO-ERROR.*//*a58-0017*/
        NO-LOCK NO-ERROR NO-WAIT.  /*a58-0017*/
    /*/*a58-0017*/
    IF NOT AVAIL uwm100 THEN DO:
        IF LOCKED uwm100 THEN   
                MESSAGE "This Policy has been used by another user (uwm100)" VIEW-AS  ALERT-BOX  ERROR.  
        ELSE MESSAGE "Not Found Policy No!" VIEW-AS ALERT-BOX INFORMATION.
        fi_update = "Update Not Complete".
        DISP fi_update WITH FRAME fr_update.
        APPLY "Entry" TO fi_modcod.
        RETURN NO-APPLY.
    END.
    ELSE DO: /*a58-0017*/*/
    IF AVAIL sic_bran.uwm100 THEN DO:   /*a58-0017*/
        IF sic_bran.uwm100.releas = NO THEN DO:

            FIND FIRST sic_bran.uwm301 USE-INDEX uwm30101 WHERE 
                                    sic_bran.uwm301.policy = sic_bran.uwm100.policy AND 
                                    sic_bran.uwm301.rencnt = sic_bran.uwm100.rencnt AND
                                    sic_bran.uwm301.endcnt = sic_bran.uwm100.endcnt AND
                                    sic_bran.uwm301.riskno = fi_riskno              AND 
                                    sic_bran.uwm301.itemno = fi_itemno              AND 
                                    sic_bran.uwm301.bchyr  = sic_bran.uwm100.bchyr  AND 
                                    sic_bran.uwm301.bchno  = sic_bran.uwm100.bchno  AND 
                                    sic_bran.uwm301.bchcnt = sic_bran.uwm100.bchcnt EXCLUSIVE-LOCK  NO-ERROR. 
            IF NOT AVAIL sic_bran.uwm301 THEN DO:
                IF LOCKED sic_bran.uwm301 THEN   
                    MESSAGE "This Policy has been used by another user (uwm301)" VIEW-AS  ALERT-BOX  ERROR.  
                ELSE MESSAGE "Not Found Policy No!" VIEW-AS ALERT-BOX INFORMATION.
                fi_update = "Update Not Complete".
                DISP fi_update WITH FRAME fr_update.
                APPLY "Entry" TO fi_modcod.
                RETURN NO-APPLY.
            END.
            ELSE DO:
                ASSIGN
                    sic_bran.uwm301.modcod = fi_modcod
                    sic_bran.uwm301.moddes = fi_moddes
                    sic_bran.uwm301.vehreg = fi_vehreg. /*A59-0019 nontawat 14/01/2016*/
                fi_update = "Update Complete".
                DISP fi_update WITH FRAME fr_update.
                RUN pd_clear.
            END.
        END.
        ELSE DO:
            fi_update = "Policy No :" + sic_bran.uwm100.policy + " Transfer to Premium!!".
            DISP fi_update WITH FRAME fr_update.
        END.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_bchcnt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_bchcnt C-Win
ON LEAVE OF fi_bchcnt IN FRAME fr_update
DO:
    IF fi_bchcnt <> INPUT fi_bchcnt THEN 
        RUN pd_clear2.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_bchcnt C-Win
ON RETURN OF fi_bchcnt IN FRAME fr_update
DO:
    IF fi_bchcnt <> INPUT fi_bchcnt THEN 
        RUN pd_clear2.
    APPLY "entry" TO bu_search.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_bchno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_bchno C-Win
ON LEAVE OF fi_bchno IN FRAME fr_update
DO:
    IF fi_bchno <> INPUT fi_bchno THEN 
        RUN pd_clear2.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_bchno C-Win
ON RETURN OF fi_bchno IN FRAME fr_update
DO:
    IF fi_bchno <> INPUT fi_bchno THEN 
        RUN pd_clear2.
    APPLY "entry" TO fi_bchcnt.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_bchyr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_bchyr C-Win
ON LEAVE OF fi_bchyr IN FRAME fr_update
DO:
    IF fi_bchyr <> INPUT fi_bchyr THEN 
        RUN pd_clear2.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_bchyr C-Win
ON RETURN OF fi_bchyr IN FRAME fr_update
DO:

    IF fi_bchyr <> INPUT fi_bchyr THEN 
        RUN pd_clear2.
    APPLY "entry" TO fi_bchno.
    RETURN NO-APPLY.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_body
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_body C-Win
ON RETURN OF fi_body IN FRAME fr_update
DO:
    APPLY "entry" TO fi_moddes.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_covcod
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_covcod C-Win
ON RETURN OF fi_covcod IN FRAME fr_update
DO:
    APPLY "entry" TO fi_moddes.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_engine
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_engine C-Win
ON LEAVE OF fi_engine IN FRAME fr_update
DO:
    IF fi_bchyr <> INPUT fi_bchyr THEN 
        RUN pd_clear2.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_engine C-Win
ON RETURN OF fi_engine IN FRAME fr_update
DO:

    IF fi_bchyr <> INPUT fi_bchyr THEN 
        RUN pd_clear2.
    APPLY "entry" TO fi_bchno.
    RETURN NO-APPLY.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_garage
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_garage C-Win
ON RETURN OF fi_garage IN FRAME fr_update
DO:
    APPLY "entry" TO fi_moddes.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_itemno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_itemno C-Win
ON LEAVE OF fi_itemno IN FRAME fr_update
DO:
    IF fi_itemno <> INPUT fi_itemno THEN 
        RUN pd_clear2.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_itemno C-Win
ON RETURN OF fi_itemno IN FRAME fr_update
DO:
    IF fi_itemno <> INPUT fi_itemno THEN 
        RUN pd_clear2.
    APPLY "entry" TO fi_bchyr.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_logbok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_logbok C-Win
ON RETURN OF fi_logbok IN FRAME fr_update
DO:
    APPLY "entry" TO fi_moddes.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_modcod
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_modcod C-Win
ON RETURN OF fi_modcod IN FRAME fr_update
DO:
    APPLY "entry" TO fi_moddes.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_moddes
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_moddes C-Win
ON RETURN OF fi_moddes IN FRAME fr_update
DO:
    APPLY "entry" TO fi_vehreg. /*A59-0019 nontawat 14/01/2016*/
    RETURN NO-APPLY.

   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_pol
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_pol C-Win
ON LEAVE OF fi_pol IN FRAME fr_update
DO:
                         /*
    IF fi_pol <> INPUT fi_pol THEN
        RUN pd_clear.  */
    fi_pol = TRIM(CAPS(INPUT fi_pol)).
    fi_update = "".
    DISP fi_update WITH FRAME fr_update.

    IF fi_pol <> "" THEN DO:
        fi_update = "Search Policy No.".
        DISP fi_update WITH FRAME fr_update.
    
        DISP fi_pol WITH FRAME fr_update.
        FIND LAST sic_bran.uwm100 USE-INDEX uwm10001 WHERE uwm100.policy = fi_pol NO-LOCK NO-ERROR.
        IF AVAIL uwm100 THEN DO:
            IF uwm100.releas = NO THEN DO:
    
                ASSIGN
                    fi_rencnt = uwm100.rencnt
                    fi_endcnt = uwm100.endcnt
                    fi_bchyr  = uwm100.bchyr 
                    fi_bchno  = uwm100.bchno
                    fi_bchcnt = uwm100.bchcnt.
        
        
                FIND FIRST sic_bran.uwm301 USE-INDEX uwm30101 WHERE uwm301.policy = uwm100.policy  AND 
                                                   uwm301.rencnt = uwm100.rencnt  AND 
                                                   uwm301.endcnt = uwm100.endcnt  AND
                                                   uwm301.bchyr  = uwm100.bchyr   AND 
                                                   uwm301.bchno  = uwm100.bchno   AND 
                                                   uwm301.bchcnt = uwm100.bchcnt  NO-LOCK NO-ERROR.
                IF AVAIL uwm301 THEN DO:
        
                    RUN pd_search.
                END.
            END.
            ELSE DO:
                RUN pd_clear.
                fi_update = "Policy No :" + uwm100.policy + " Transfer to Premium!!".
                DISP fi_update WITH FRAME fr_update.

            END.
                
        END.
        ELSE DO:
            RUN pd_clear.
            fi_update = "Search Not Found".
            DISP fi_update WITH FRAME fr_update.
        END.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_pol C-Win
ON RETURN OF fi_pol IN FRAME fr_update
DO:
    fi_pol = TRIM(CAPS(INPUT fi_pol)).
    fi_update = "".
    DISP fi_update WITH FRAME fr_update.
    IF fi_pol <> "" THEN DO:
        fi_update = "Search Policy No.".
        DISP fi_update WITH FRAME fr_update.
    
        DISP fi_pol WITH FRAME fr_update.
        FIND LAST sic_bran.uwm100 USE-INDEX uwm10001 WHERE uwm100.policy = fi_pol NO-LOCK NO-ERROR.
        IF AVAIL uwm100 THEN DO:
    
            IF uwm100.releas = NO THEN DO:
    
                ASSIGN
                    fi_rencnt = uwm100.rencnt
                    fi_endcnt = uwm100.endcnt
                    fi_bchyr  = uwm100.bchyr 
                    fi_bchno  = uwm100.bchno
                    fi_bchcnt = uwm100.bchcnt.
        
        
                FIND FIRST sic_bran.uwm301 USE-INDEX uwm30101 WHERE uwm301.policy = uwm100.policy  AND 
                                                   uwm301.rencnt = uwm100.rencnt  AND 
                                                   uwm301.endcnt = uwm100.endcnt  AND
                                                   uwm301.bchyr  = uwm100.bchyr   AND 
                                                   uwm301.bchno  = uwm100.bchno   AND 
                                                   uwm301.bchcnt = uwm100.bchcnt  NO-LOCK NO-ERROR.
                IF AVAIL uwm301 THEN DO:
        
                    RUN pd_search.
                    APPLY "entry" TO fi_modcod.
                    RETURN NO-APPLY.
                
                END.
            END.
            ELSE DO:
                RUN pd_clear.
                fi_update = "Policy No :" + uwm100.policy + " Transfer to Premium!!".
                DISP fi_update WITH FRAME fr_update.

            END.
                
        END.
        ELSE DO:
            RUN pd_clear.
            fi_update = "Search Not Found".
            DISP fi_update WITH FRAME fr_update.
        END.
    END.



  
       
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_riskno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_riskno C-Win
ON LEAVE OF fi_riskno IN FRAME fr_update
DO:
    IF fi_riskno <> INPUT fi_riskno THEN 
        RUN pd_clear2.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_riskno C-Win
ON RETURN OF fi_riskno IN FRAME fr_update
DO:

    IF fi_riskno <> INPUT fi_riskno THEN 
        RUN pd_clear2.
    APPLY "entry" TO fi_itemno.
    RETURN NO-APPLY.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_seats
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_seats C-Win
ON LEAVE OF fi_seats IN FRAME fr_update
DO:
    IF fi_bchyr <> INPUT fi_bchyr THEN 
        RUN pd_clear2.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_seats C-Win
ON RETURN OF fi_seats IN FRAME fr_update
DO:

    IF fi_bchyr <> INPUT fi_bchyr THEN 
        RUN pd_clear2.
    APPLY "entry" TO fi_bchno.
    RETURN NO-APPLY.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_tons
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_tons C-Win
ON LEAVE OF fi_tons IN FRAME fr_update
DO:
    IF fi_bchyr <> INPUT fi_bchyr THEN 
        RUN pd_clear2.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_tons C-Win
ON RETURN OF fi_tons IN FRAME fr_update
DO:

    IF fi_bchyr <> INPUT fi_bchyr THEN 
        RUN pd_clear2.
    APPLY "entry" TO fi_bchno.
    RETURN NO-APPLY.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_vehgrp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_vehgrp C-Win
ON RETURN OF fi_vehgrp IN FRAME fr_update
DO:
    APPLY "entry" TO fi_moddes.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_vehreg
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_vehreg C-Win
ON LEAVE OF fi_vehreg IN FRAME fr_update
DO:
  APPLY "entry" TO bu_update. /*A59-0019 nontawat 14/01/2016*/
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_vehuse
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_vehuse C-Win
ON RETURN OF fi_vehuse IN FRAME fr_update
DO:
    APPLY "entry" TO fi_moddes.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_yrmanu
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_yrmanu C-Win
ON LEAVE OF fi_yrmanu IN FRAME fr_update
DO:
    IF fi_bchyr <> INPUT fi_bchyr THEN 
        RUN pd_clear2.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_yrmanu C-Win
ON RETURN OF fi_yrmanu IN FRAME fr_update
DO:

    IF fi_bchyr <> INPUT fi_bchyr THEN 
        RUN pd_clear2.
    APPLY "entry" TO fi_bchno.
    RETURN NO-APPLY.
  
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
  DEF  VAR  gv_prgid   AS   CHAR  FORMAT "X(8)"   NO-UNDO.
  DEF  VAR  gv_prog    AS   CHAR  FORMAT "X(40)" NO-UNDO.
    
  gv_prgid = "WGWXXXX".
  gv_prog  =  "Update Make Model Motor Policy".
  /*
  RUN  WUT\WUTHEAD (C-Win:handle,gv_prgid,gv_prog).
  RUN  WUT\WUTWICEN (C-Win:handle). */
  SESSION:DATA-ENTRY-RETURN = Yes. /*A59-0019 nontawat 14/01/2016*/

  RUN pd_clear.
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
  VIEW FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW FRAME fr_head IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_head}
  DISPLAY fi_pol fi_rencnt fi_endcnt fi_riskno fi_itemno fi_bchyr fi_bchno 
          fi_bchcnt fi_modcod fi_moddes fi_vehreg fi_tariff fi_class fi_cldes 
          fi_logbok fi_vehgrp fi_body fi_yrmanu fi_vehuse fi_covcod fi_garage 
          fi_seats fi_engine fi_tons fi_engno fi_chano fi_update 
      WITH FRAME fr_update IN WINDOW C-Win.
  ENABLE bu_exit bu_search fi_pol fi_riskno fi_itemno fi_bchyr fi_bchno 
         fi_bchcnt fi_modcod fi_moddes bu_update RECT-653 RECT-654 
      WITH FRAME fr_update IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_update}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_clear C-Win 
PROCEDURE pd_clear :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
    fi_rencnt = 0
    fi_endcnt = 0
    fi_riskno = 0
    fi_itemno = 0
    fi_class  = ""
    fi_cldes  = ""
    fi_tariff = ""
    fi_modcod = ""
    fi_moddes = ""
    fi_bchyr  = 0
    fi_bchno  = ""
    fi_bchcnt = 0
    fi_yrmanu = 0
    fi_vehgrp = ""
    fi_body   = ""
    fi_logbok = ""
    fi_engine = 0
    fi_tons   = 0
    fi_seats  = 0
    fi_vehuse = ""
    fi_covcod = ""
    fi_garage = ""
    fi_vehreg = ""
    fi_chano  = ""
    fi_engno  = "".

DISABLE fi_vehreg fi_modcod fi_moddes bu_update  WITH FRAME fr_update.
DISP fi_rencnt fi_endcnt fi_riskno fi_itemno fi_class fi_cldes fi_tariff fi_modcod fi_moddes fi_bchyr fi_bchno fi_bchcnt 
     fi_yrmanu fi_vehgrp fi_body fi_logbok fi_engine  fi_tons fi_seats fi_vehuse fi_covcod fi_garage fi_vehreg fi_chano fi_engno  WITH FRAME fr_update.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_clear2 C-Win 
PROCEDURE pd_clear2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
    fi_class  = ""
    fi_cldes  = ""
    fi_tariff = ""
    fi_modcod = ""
    fi_moddes = ""
    fi_yrmanu = 0
    fi_vehgrp = ""
    fi_body   = ""
    fi_logbok = ""
    fi_engine = 0
    fi_tons   = 0
    fi_seats  = 0
    fi_vehuse = ""
    fi_covcod = ""
    fi_garage = ""
    fi_vehreg = ""
    fi_chano  = ""
    fi_engno  = "".
DISABLE fi_vehreg fi_modcod fi_moddes bu_update WITH FRAME fr_update.
DISP fi_class fi_cldes fi_tariff fi_modcod fi_moddes 
     fi_yrmanu fi_vehgrp fi_body fi_logbok fi_engine  fi_tons fi_seats fi_vehuse fi_covcod fi_garage fi_vehreg fi_chano fi_engno 
    
    WITH FRAME fr_update.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_search C-Win 
PROCEDURE pd_search :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

ASSIGN
    fi_riskno = sic_bran.uwm301.riskno
    fi_itemno = sic_bran.uwm301.itemno
    fi_modcod = sic_bran.uwm301.modcod
    fi_moddes = sic_bran.uwm301.moddes
    fi_yrmanu = sic_bran.uwm301.yrmanu
    fi_vehgrp = sic_bran.uwm301.vehgrp
    fi_body   = sic_bran.uwm301.body
    fi_logbok = sic_bran.uwm301.logbok
    fi_engine = sic_bran.uwm301.engine
    fi_tons   = sic_bran.uwm301.tons
    fi_seats  = sic_bran.uwm301.seats
    fi_vehuse = sic_bran.uwm301.vehuse
    fi_covcod = sic_bran.uwm301.covcod
    fi_garage = sic_bran.uwm301.garage
    fi_vehreg = sic_bran.uwm301.vehreg
    fi_chano  = sic_bran.uwm301.cha_no
    fi_engno  = sic_bran.uwm301.eng_no
    fi_tariff = sic_bran.uwm301.tariff.

FIND FIRST sic_bran.uwm120 USE-INDEX uwm12001 WHERE uwm120.policy = sic_bran.uwm301.policy AND
                                                   uwm120.rencnt = sic_bran.uwm301.rencnt AND
                                                   uwm120.endcnt = sic_bran.uwm301.endcnt AND
                                                   uwm120.riskno = sic_bran.uwm301.riskno AND
                                                   uwm120.bchyr  = sic_bran.uwm301.bchyr AND 
                                                   uwm120.bchno  = sic_bran.uwm301.bchno AND
                                                   uwm120.bchcnt = sic_bran.uwm301.bchcnt NO-LOCK NO-ERROR.
IF AVAIL uwm120 THEN DO:
    fi_class = uwm120.class.

        
    FIND FIRST sicsyac.xmm016 USE-INDEX xmm01601 WHERE
         xmm016.class = uwm120.class NO-LOCK NO-ERROR.
         
    IF AVAIL xmm016 THEN
        ASSIGN
            fi_cldes  = xmm016.clsdes. 

    /*
    FIND FIRST maktab_fil USE-INDEX maktab01 WHERE
             maktab_fil.sclass = uwm120.class  AND
             maktab_fil.modcod = sic_bran.uwm301.modcod NO-LOCK NO-ERROR.
    IF AVAIL maktab_fil THEN DO:
        fi_moddes = TRIM(maktab_fil.makdes) + " " + TRIM(maktab_fil.moddes).

    END.*/
    



END.

fi_update = "".
DISP fi_update WITH FRAME fr_update.
ENABLE fi_vehreg fi_modcod fi_moddes bu_update fi_riskno fi_itemno fi_bchyr fi_bchno fi_bchcnt WITH FRAME fr_update.
DISP fi_rencnt fi_endcnt fi_riskno fi_itemno fi_class fi_cldes fi_tariff fi_modcod fi_moddes fi_bchyr fi_bchno fi_bchcnt 
     fi_yrmanu fi_vehgrp fi_body fi_logbok fi_engine  fi_tons fi_seats fi_vehuse fi_covcod fi_garage fi_vehreg fi_chano fi_engno WITH FRAME fr_update.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

