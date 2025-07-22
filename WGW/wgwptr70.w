&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          brstat           PROGRESS
*/
&Scoped-define WINDOW-NAME wgwptr70
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS wgwptr70 
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

/*Create by : Chaiyong W. A57-0096 28/07/2014*/

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */
DEF VAR nv_recid AS RECID INIT 0.
DEF VAR nv_field AS CHAR  INIT "".

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME br_query

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES usrsec_fil

/* Definitions for BROWSE br_query                                      */
&Scoped-define FIELDS-IN-QUERY-br_query usrsec_fil.usrid SUBSTR(usrsec_fil.CLASS,1,5) SUBSTR(usrsec_fil.CLASS,6,10)   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_query   
&Scoped-define SELF-NAME br_query
&Scoped-define QUERY-STRING-br_query FOR EACH usrsec_fil NO-LOCK
&Scoped-define OPEN-QUERY-br_query OPEN QUERY br_query FOR EACH usrsec_fil NO-LOCK.
&Scoped-define TABLES-IN-QUERY-br_query usrsec_fil
&Scoped-define FIRST-TABLE-IN-QUERY-br_query usrsec_fil


/* Definitions for FRAME fr_query                                       */

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wgwptr70 AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE VARIABLE fi_search AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 57 BY 1
     BGCOLOR 14  NO-UNDO.

DEFINE VARIABLE ra_select AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "By User ID", 1,
"By Branch", 2,
"By Producer Code", 3
     SIZE 19.5 BY 2.76 NO-UNDO.

DEFINE BUTTON bu_add 
     LABEL "Add" 
     SIZE 15 BY 1.14.

DEFINE BUTTON bu_del 
     LABEL "Delete" 
     SIZE 15 BY 1.14.

DEFINE BUTTON bu_exit AUTO-END-KEY 
     LABEL "Exit" 
     SIZE 15 BY 1.14.

DEFINE VARIABLE fi_acdes AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 24 BY 1
     BGCOLOR 34  NO-UNDO.

DEFINE VARIABLE fi_acno1 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 21 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_branch AS CHARACTER FORMAT "XX":U 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_brdes AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 23.83 BY 1
     BGCOLOR 34  NO-UNDO.

DEFINE VARIABLE fi_user AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 20.5 BY 1
     BGCOLOR 15  NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_query FOR 
      usrsec_fil SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_query
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_query wgwptr70 _FREEFORM
  QUERY br_query DISPLAY
      usrsec_fil.usrid              FORMAT "X(20)" COLUMN-LABEL "User ID"                                                  
 SUBSTR(usrsec_fil.CLASS,1,5)  FORMAT "x(15)"  COLUMN-LABEL "Branch"
 SUBSTR(usrsec_fil.CLASS,6,10) FORMAT "x(20)"  COLUMN-LABEL "Producer Code"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 92 BY 8.43
         FONT 2 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 96.83 BY 20.76
         BGCOLOR 19 .

DEFINE FRAME fr_query
     br_query AT ROW 1.14 COL 1.17
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 3 ROW 3.62
         SIZE 93 BY 8.76
         BGCOLOR 19 .

DEFINE FRAME fr_search
     ra_select AT ROW 1.24 COL 13 NO-LABEL
     fi_search AT ROW 1.95 COL 31 COLON-ALIGNED NO-LABEL
     "Search" VIEW-AS TEXT
          SIZE 8 BY .62 AT ROW 1.38 COL 2.5
          FONT 2
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 3 ROW 12.67
         SIZE 93 BY 3.1
         BGCOLOR 19 .

DEFINE FRAME fr_update
     fi_brdes AT ROW 3.14 COL 35.17 COLON-ALIGNED NO-LABEL
     fi_user AT ROW 1.48 COL 13.67 COLON-ALIGNED NO-LABEL
     fi_branch AT ROW 3.14 COL 13.67 COLON-ALIGNED NO-LABEL
     fi_acno1 AT ROW 4.57 COL 13.67 COLON-ALIGNED NO-LABEL
     bu_add AT ROW 1.57 COL 58.5
     bu_del AT ROW 1.57 COL 76
     bu_exit AT ROW 3.14 COL 76.17
     fi_acdes AT ROW 4.57 COL 35.17 COLON-ALIGNED NO-LABEL
     "User ID :" VIEW-AS TEXT
          SIZE 8 BY .62 AT ROW 1.71 COL 2
     "Branch :" VIEW-AS TEXT
          SIZE 8 BY .62 AT ROW 3.14 COL 2.5
     "Producer Code" VIEW-AS TEXT
          SIZE 12.5 BY .62 AT ROW 4.81 COL 2.5
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 3 ROW 16
         SIZE 93 BY 5.48
         BGCOLOR 19 .

DEFINE FRAME fr_head
     "User Security Transfer On Web" VIEW-AS TEXT
          SIZE 43 BY 1.33 AT ROW 1.24 COL 26.67
          BGCOLOR 3 FGCOLOR 7 FONT 27
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 3 ROW 1.48
         SIZE 93.5 BY 2
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
  CREATE WINDOW wgwptr70 ASSIGN
         HIDDEN             = YES
         TITLE              = "wgwptr70 : User Security Transfer On Web"
         HEIGHT             = 20.76
         WIDTH              = 96.83
         MAX-HEIGHT         = 45.81
         MAX-WIDTH          = 213.33
         VIRTUAL-HEIGHT     = 45.81
         VIRTUAL-WIDTH      = 213.33
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
IF NOT wgwptr70:LOAD-ICON("I:/Safety/Walp9/WIMAGE/safety.ico":U) THEN
    MESSAGE "Unable to load icon: I:/Safety/Walp9/WIMAGE/safety.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW wgwptr70
  VISIBLE,,RUN-PERSISTENT                                               */
/* REPARENT FRAME */
ASSIGN FRAME fr_head:FRAME = FRAME DEFAULT-FRAME:HANDLE
       FRAME fr_query:FRAME = FRAME DEFAULT-FRAME:HANDLE
       FRAME fr_search:FRAME = FRAME DEFAULT-FRAME:HANDLE
       FRAME fr_update:FRAME = FRAME DEFAULT-FRAME:HANDLE.

/* SETTINGS FOR FRAME DEFAULT-FRAME
   FRAME-NAME Custom                                                    */

DEFINE VARIABLE XXTABVALXX AS LOGICAL NO-UNDO.

ASSIGN XXTABVALXX = FRAME fr_query:MOVE-BEFORE-TAB-ITEM (FRAME fr_update:HANDLE)
       XXTABVALXX = FRAME fr_search:MOVE-BEFORE-TAB-ITEM (FRAME fr_query:HANDLE)
       XXTABVALXX = FRAME fr_head:MOVE-BEFORE-TAB-ITEM (FRAME fr_search:HANDLE)
/* END-ASSIGN-TABS */.

/* SETTINGS FOR FRAME fr_head
                                                                        */
/* SETTINGS FOR FRAME fr_query
                                                                        */
/* BROWSE-TAB br_query 1 fr_query */
/* SETTINGS FOR FRAME fr_search
                                                                        */
/* SETTINGS FOR FRAME fr_update
   Custom                                                               */
/* SETTINGS FOR FILL-IN fi_acdes IN FRAME fr_update
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_brdes IN FRAME fr_update
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wgwptr70)
THEN wgwptr70:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_query
/* Query rebuild information for BROWSE br_query
     _START_FREEFORM
OPEN QUERY br_query FOR EACH usrsec_fil NO-LOCK.
     _END_FREEFORM
     _Query            is NOT OPENED
*/  /* BROWSE br_query */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define BROWSE-NAME br_query
&Scoped-define FRAME-NAME fr_query
&Scoped-define SELF-NAME br_query
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_query wgwptr70
ON MOUSE-SELECT-DBLCLICK OF br_query IN FRAME fr_query
DO:


    IF AVAIL usrsec_fil THEN DO: /*
    IF usrsec_fil.usrid  <> "" THEN DO:*/

        ASSIGN
            fi_user = usrsec_fil.usrid      
            fi_branch = SUBSTR(usrsec_fil.CLASS,1,5)  
            fi_acno1 = SUBSTR(usrsec_fil.CLASS,6,10)
            fi_brdes = ""
            fi_acdes = "".


        FIND FIRST sicsyac.xmm023 USE-INDEX xmm02301 WHERE xmm023.branch = fi_branch NO-LOCK NO-ERROR.
        IF AVAIL xmm023 THEN fi_brdes = xmm023.bdes.
        
        
        FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = fi_acno1 NO-LOCK NO-ERROR.
        IF AVAIL xmm600 THEN fi_acdes = xmm600.name.

        DISP fi_user fi_branch fi_acno1 fi_brdes fi_acdes WITH FRAME fr_update.
        APPLY "ENTRY"  TO fi_user.
        RETURN NO-APPLY.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_update
&Scoped-define SELF-NAME bu_add
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_add wgwptr70
ON CHOOSE OF bu_add IN FRAME fr_update /* Add */
DO:
    ASSIGN
        fi_user   = TRIM(INPUT fi_user)
        fi_branch = TRIM(INPUT fi_branch)
        fi_acno1  = TRIM(INPUT fi_acno1).
    IF fi_user = "" THEN DO:
        MESSAGE "User Name is Mandatory Field !!!" VIEW-AS ALERT-BOX INFORMATION.
        APPLY "ENTRY"  TO fi_user.
        RETURN NO-APPLY.
    END.

    IF fi_branch = "" AND fi_acno1 = "" THEN DO:
        MESSAGE "Please insert Data Branch and Producer Code!!!" VIEW-AS ALERT-BOX INFORMATION.
        APPLY "ENTRY"  TO fi_branch.
        RETURN NO-APPLY.
    END.

    IF fi_branch = "" THEN DO:
        MESSAGE "Branch is Mandatory Field !!!" VIEW-AS ALERT-BOX INFORMATION.
        APPLY "ENTRY"  TO fi_branch.
        RETURN NO-APPLY.
    END.
    IF fi_acno1= "" THEN DO:
        MESSAGE "Producer Code is Mandatory Field !!!" VIEW-AS ALERT-BOX INFORMATION.
        APPLY "ENTRY"  TO fi_acno1.
        RETURN NO-APPLY.
    END.

    IF fi_branch <> "*" THEN DO:
        FIND FIRST sicsyac.xmm023 USE-INDEX xmm02301 WHERE xmm023.branch = fi_branch NO-LOCK NO-ERROR.
        IF NOT AVAIL xmm023 THEN DO:
            MESSAGE "Not Found Branch" VIEW-AS ALERT-BOX INFORMATION.
            fi_brdes = "".
            DISP fi_branch fi_brdes WITH FRAME fr_update.
            APPLY "ENTRY"  TO fi_branch.
            RETURN NO-APPLY.
        END.
    END.

    IF fi_acno1  <> "*" THEN DO:
        FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = fi_acno1 NO-LOCK NO-ERROR.
        IF NOT AVAIL xmm600 THEN DO:
            MESSAGE "Not Found Producer Code" VIEW-AS ALERT-BOX INFORMATION.
            fi_acdes = "".
            DISP fi_acno1 fi_acdes WITH FRAME fr_update.
            APPLY "ENTRY"  TO fi_acno1.
            RETURN NO-APPLY.
        END.
    END.



    nv_field    = fi_branch + FILL(" ",5 - LENGTH(fi_branch)) + fi_acno1.

    FIND FIRST usrsec_fil WHERE usrsec_fil.usrid = fi_user  AND
                                usrsec_fil.CLASS = nv_field NO-ERROR.
    IF NOT AVAIL usrsec_fil THEN DO: 
        CREATE usrsec_fil.
        ASSIGN
            usrsec_fil.usrid = fi_user
            usrsec_fil.CLASS = nv_field.
        MESSAGE "Update Complete" VIEW-AS ALERT-BOX INFORMATION.

    END. 
    ASSIGN
        fi_user   = ""
        fi_branch = ""
        fi_acno1  = ""
        fi_acdes  = ""
        fi_brdes  = "".

    DISP fi_user fi_branch fi_acno1 fi_acdes fi_brdes WITH FRAME fr_update.

    

    IF fi_search <> "" THEN DO:
        IF ra_select = 1 THEN
            OPEN QUERY br_query FOR EACH usrsec_fil WHERE usrsec_fil.usrid BEGINS fi_search NO-LOCK   BY usrsec_fil.CLASS.
        ELSE IF ra_select = 2 THEN
            OPEN QUERY br_query FOR EACH usrsec_fil WHERE SUBSTR(usrsec_fil.CLASS,1,5) BEGINS fi_search NO-LOCK  BY SUBSTR(usrsec_fil.CLASS,6,10).
        ELSE 
            OPEN QUERY br_query FOR EACH usrsec_fil WHERE SUBSTR(usrsec_fil.CLASS,6,10) BEGINS fi_search NO-LOCK  BY SUBSTR(usrsec_fil.CLASS,1,5).
    END.
    ELSE DO:
        IF ra_select = 1 THEN
            OPEN QUERY br_query FOR EACH usrsec_fil NO-LOCK  BY usrsec_fil.CLASS.
        ELSE IF ra_select = 2 THEN
            OPEN QUERY br_query FOR EACH usrsec_fil NO-LOCK  BY SUBSTR(usrsec_fil.CLASS,1,5).
        ELSE 
            OPEN QUERY br_query FOR EACH usrsec_fil NO-LOCK  BY SUBSTR(usrsec_fil.CLASS,6,10).
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_add wgwptr70
ON RETURN OF bu_add IN FRAME fr_update /* Add */
DO:
    APPLY "ENTRY"  TO fi_user.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_del
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_del wgwptr70
ON CHOOSE OF bu_del IN FRAME fr_update /* Delete */
DO:
    ASSIGN
        fi_user   = TRIM(INPUT fi_user)
        fi_branch = TRIM(INPUT fi_branch)
        fi_acno1  = TRIM(INPUT fi_acno1).
    IF fi_user = "" THEN DO:
        MESSAGE "User Name is Mandatory Field !!!" VIEW-AS ALERT-BOX INFORMATION.
        APPLY "ENTRY"  TO fi_user.
        RETURN NO-APPLY.
    END.

    IF fi_branch = "" AND fi_acno1 = "" THEN DO:
        MESSAGE "Please insert Data Branch and Producer Code!!!" VIEW-AS ALERT-BOX INFORMATION.
        APPLY "ENTRY"  TO fi_branch.
        RETURN NO-APPLY.
    END.

    IF fi_branch = "" THEN DO:
        MESSAGE "Branch is Mandatory Field !!!" VIEW-AS ALERT-BOX INFORMATION.
        APPLY "ENTRY"  TO fi_branch.
        RETURN NO-APPLY.
    END.

    IF fi_acno1= "" THEN DO:
        MESSAGE "Producer Code is Mandatory Field !!!" VIEW-AS ALERT-BOX INFORMATION.
        APPLY "ENTRY"  TO fi_acno1.
        RETURN NO-APPLY.
    END.


    IF fi_branch <> "*" THEN DO:
        FIND FIRST sicsyac.xmm023 USE-INDEX xmm02301 WHERE xmm023.branch = fi_branch NO-LOCK NO-ERROR.
        IF NOT AVAIL xmm023 THEN DO:
            MESSAGE "Not Found Branch" VIEW-AS ALERT-BOX INFORMATION.
            fi_brdes = "".
            DISP fi_branch fi_brdes WITH FRAME fr_update.
            APPLY "ENTRY"  TO fi_branch.
            RETURN NO-APPLY.
        END.
    END.

    IF fi_acno1  <> "*" THEN DO:
        FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = fi_acno1 NO-LOCK NO-ERROR.
        IF NOT AVAIL xmm600 THEN DO:
            MESSAGE "Not Found Producer Code" VIEW-AS ALERT-BOX INFORMATION.
            fi_acdes = "".
            DISP fi_acno1 fi_acdes WITH FRAME fr_update.
            APPLY "ENTRY"  TO fi_acno1.
            RETURN NO-APPLY.
        END.
    END.

    nv_field    = fi_branch + FILL(" ",5 - LENGTH(fi_branch)) + fi_acno1.

    FIND FIRST usrsec_fil WHERE usrsec_fil.usrid = fi_user  AND
                                usrsec_fil.CLASS = nv_field NO-ERROR.
    IF AVAIL usrsec_fil THEN DO: 
        DELETE usrsec_fil.
        MESSAGE "Deleted Complete" VIEW-AS ALERT-BOX INFORMATION.
        ASSIGN
            fi_user   = ""
            fi_branch = ""
            fi_acno1  = ""
            fi_acdes  = ""
            fi_brdes  = "".
        DISP fi_user fi_branch fi_acno1 fi_acdes fi_brdes WITH FRAME fr_update.
        IF fi_search <> "" THEN DO:
            IF ra_select = 1 THEN
                OPEN QUERY br_query FOR EACH usrsec_fil WHERE usrsec_fil.usrid BEGINS fi_search NO-LOCK   BY usrsec_fil.CLASS.
            ELSE IF ra_select = 2 THEN
                OPEN QUERY br_query FOR EACH usrsec_fil WHERE SUBSTR(usrsec_fil.CLASS,1,5) BEGINS fi_search NO-LOCK  BY SUBSTR(usrsec_fil.CLASS,6,10).
            ELSE 
                OPEN QUERY br_query FOR EACH usrsec_fil WHERE SUBSTR(usrsec_fil.CLASS,6,10) BEGINS fi_search NO-LOCK  BY SUBSTR(usrsec_fil.CLASS,1,5).
        END.
        ELSE DO:
            IF ra_select = 1 THEN
                OPEN QUERY br_query FOR EACH usrsec_fil NO-LOCK  BY usrsec_fil.CLASS.
            ELSE IF ra_select = 2 THEN
                OPEN QUERY br_query FOR EACH usrsec_fil NO-LOCK  BY SUBSTR(usrsec_fil.CLASS,1,5).
            ELSE 
                OPEN QUERY br_query FOR EACH usrsec_fil NO-LOCK  BY SUBSTR(usrsec_fil.CLASS,6,10).
        END.
    END.
    ELSE DO:
        MESSAGE "Not found data to delete" VIEW-AS ALERT-BOX INFORMATION.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit wgwptr70
ON CHOOSE OF bu_exit IN FRAME fr_update /* Exit */
DO:
    APPLY  "CLOSE"  TO THIS-PROCEDURE.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_acno1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_acno1 wgwptr70
ON LEAVE OF fi_acno1 IN FRAME fr_update
DO:

    fi_acno1 = CAPS(TRIM(INPUT fi_acno1)).
    ASSIGN
        fi_acdes = "".

    IF fi_acno1 <> "" THEN DO:
        IF fi_acno1 <> "*"  THEN DO:
            FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = fi_acno1 NO-LOCK NO-ERROR.
            IF AVAIL xmm600 THEN fi_acdes = xmm600.name.
            ELSE DO:
                MESSAGE "Not Found Producer Code" VIEW-AS ALERT-BOX INFORMATION.
                DISP fi_acno1 fi_acdes WITH FRAME fr_update.
                APPLY "ENTRY"  TO fi_acno1.
                RETURN NO-APPLY.
            END.
        END.
    END.
    DISP fi_acno1 fi_acdes WITH FRAME fr_update.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_acno1 wgwptr70
ON RETURN OF fi_acno1 IN FRAME fr_update
DO:
    fi_acno1 = CAPS(TRIM(INPUT fi_acno1)).
    ASSIGN
        fi_acdes = "".

    IF fi_acno1 <> "" THEN DO:
        IF fi_acno1 <> "*"  THEN DO:
            FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = fi_acno1 NO-LOCK NO-ERROR.
            IF AVAIL xmm600 THEN fi_acdes = xmm600.name.
            ELSE DO:
                MESSAGE "Not Found Producer Code" VIEW-AS ALERT-BOX INFORMATION.
                DISP fi_acno1 fi_acdes WITH FRAME fr_update.
                APPLY "ENTRY"  TO fi_acno1.
                RETURN NO-APPLY.
            END.
        END.
    END.
    ELSE DO:
        MESSAGE "Please Insert Data Producer Code" VIEW-AS ALERT-BOX INFORMATION.
        APPLY "ENTRY"  TO fi_acno1.
        RETURN NO-APPLY.
    END.
    DISP fi_acno1 fi_acdes WITH FRAME fr_update.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_branch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_branch wgwptr70
ON LEAVE OF fi_branch IN FRAME fr_update
DO:
    fi_branch = CAPS(TRIM(INPUT fi_branch)).
    ASSIGN
        fi_brdes = "".
    IF fi_branch <> "" THEN DO:
        IF fi_branch <> "*"  THEN DO:
            FIND FIRST sicsyac.xmm023 USE-INDEX xmm02301 WHERE xmm023.branch = fi_branch NO-LOCK NO-ERROR.
            IF AVAIL xmm023 THEN fi_brdes = xmm023.bdes.
            ELSE DO:
                MESSAGE "Not Found Branch" VIEW-AS ALERT-BOX INFORMATION.
                DISP fi_branch fi_brdes WITH FRAME fr_update.
                APPLY "ENTRY"  TO fi_branch.
                RETURN NO-APPLY.
            END.
        END.
    END.
    DISP fi_branch fi_brdes WITH FRAME fr_update.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_branch wgwptr70
ON RETURN OF fi_branch IN FRAME fr_update
DO:
    fi_branch = CAPS(TRIM(INPUT fi_branch)).
    ASSIGN
        fi_brdes = "".
    IF fi_branch <> "" THEN DO:
        IF fi_branch <> "*"  THEN DO:
            FIND FIRST sicsyac.xmm023 USE-INDEX xmm02301 WHERE xmm023.branch = fi_branch NO-LOCK NO-ERROR.
            IF AVAIL xmm023 THEN fi_brdes = xmm023.bdes.
            ELSE DO:
                MESSAGE "Not Found Branch" VIEW-AS ALERT-BOX INFORMATION.
                DISP fi_branch fi_brdes WITH FRAME fr_update.
                APPLY "ENTRY"  TO fi_branch.
                RETURN NO-APPLY.
            END.
        END.
    END.
    ELSE DO:
        MESSAGE "Please Insert Data Branch" VIEW-AS ALERT-BOX INFORMATION.
        APPLY "ENTRY"  TO fi_branch.
        RETURN NO-APPLY.
    END.
    DISP fi_branch fi_brdes WITH FRAME fr_update.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_search
&Scoped-define SELF-NAME fi_search
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_search wgwptr70
ON LEAVE OF fi_search IN FRAME fr_search
DO:
    ASSIGN
        ra_select = INPUT ra_select
        fi_search = TRIM(INPUT fi_search).
    IF fi_search = "" THEN DO:
        IF ra_select = 1 THEN
            OPEN QUERY br_query FOR EACH usrsec_fil NO-LOCK  BY usrsec_fil.CLASS.
        ELSE IF ra_select = 2 THEN
            OPEN QUERY br_query FOR EACH usrsec_fil NO-LOCK  BY SUBSTR(usrsec_fil.CLASS,1,5).
        ELSE 
            OPEN QUERY br_query FOR EACH usrsec_fil NO-LOCK  BY SUBSTR(usrsec_fil.CLASS,6,10).
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_search wgwptr70
ON RETURN OF fi_search IN FRAME fr_search
DO:
    ASSIGN
        ra_select = INPUT ra_select
        fi_search = TRIM(INPUT fi_search).

    IF fi_search <> "" THEN DO:
        IF ra_select = 1 THEN
            OPEN QUERY br_query FOR EACH usrsec_fil WHERE usrsec_fil.usrid BEGINS  fi_search NO-LOCK   BY usrsec_fil.CLASS.
        ELSE IF ra_select = 2 THEN
            OPEN QUERY br_query FOR EACH usrsec_fil WHERE SUBSTR(usrsec_fil.CLASS,1,5) BEGINS fi_search NO-LOCK  BY SUBSTR(usrsec_fil.CLASS,6,10).
        ELSE 
            OPEN QUERY br_query FOR EACH usrsec_fil WHERE SUBSTR(usrsec_fil.CLASS,6,10) BEGINS fi_search NO-LOCK  BY SUBSTR(usrsec_fil.CLASS,1,5).
    END.
    ELSE DO:
        IF ra_select = 1 THEN
            OPEN QUERY br_query FOR EACH usrsec_fil NO-LOCK  BY usrsec_fil.CLASS.
        ELSE IF ra_select = 2 THEN
            OPEN QUERY br_query FOR EACH usrsec_fil NO-LOCK  BY SUBSTR(usrsec_fil.CLASS,1,5).
        ELSE 
            OPEN QUERY br_query FOR EACH usrsec_fil NO-LOCK  BY SUBSTR(usrsec_fil.CLASS,6,10).
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_update
&Scoped-define SELF-NAME fi_user
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_user wgwptr70
ON LEAVE OF fi_user IN FRAME fr_update
DO:

    fi_user = TRIM(INPUT fi_user).

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_user wgwptr70
ON RETURN OF fi_user IN FRAME fr_update
DO:
    fi_user = TRIM(INPUT fi_user).
    IF fi_user = "" THEN DO:
        MESSAGE "Please Insert Data User ID" VIEW-AS ALERT-BOX INFORMATION.
        APPLY "ENTRY"  TO fi_user.
        RETURN NO-APPLY.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_search
&Scoped-define SELF-NAME ra_select
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_select wgwptr70
ON VALUE-CHANGED OF ra_select IN FRAME fr_search
DO:

    ra_select = INPUT ra_select.

    IF ra_select = 1 THEN
        OPEN QUERY br_query FOR EACH usrsec_fil NO-LOCK  BY usrsec_fil.CLASS.
    ELSE IF ra_select = 2 THEN
        OPEN QUERY br_query FOR EACH usrsec_fil NO-LOCK  BY SUBSTR(usrsec_fil.CLASS,1,5).
    ELSE 
        OPEN QUERY br_query FOR EACH usrsec_fil NO-LOCK  BY SUBSTR(usrsec_fil.CLASS,6,10).

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME DEFAULT-FRAME
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK wgwptr70 


/* ***************************  Main Block  *************************** */
  DEF   VAR  gv_prgid   AS   CHAR  FORMAT "X(8)"   NO-UNDO.
  DEF   VAR  gv_prog    AS   CHAR  FORMAT "X(40)" NO-UNDO.
  
  gv_prgid = "wgwptr70".
  gv_prog  = "User Security Transfer On Web".
  RUN  WUT\WUTWICEN ({&WINDOW-NAME}:HANDLE). 
  SESSION:DATA-ENTRY-RETURN = YES.

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
  OPEN QUERY br_query FOR EACH usrsec_fil NO-LOCK  BY usrsec_fil.CLASS.

  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI wgwptr70  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wgwptr70)
  THEN DELETE WIDGET wgwptr70.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI wgwptr70  _DEFAULT-ENABLE
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
  VIEW FRAME DEFAULT-FRAME IN WINDOW wgwptr70.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW FRAME fr_head IN WINDOW wgwptr70.
  {&OPEN-BROWSERS-IN-QUERY-fr_head}
  ENABLE br_query 
      WITH FRAME fr_query IN WINDOW wgwptr70.
  {&OPEN-BROWSERS-IN-QUERY-fr_query}
  DISPLAY ra_select fi_search 
      WITH FRAME fr_search IN WINDOW wgwptr70.
  ENABLE ra_select fi_search 
      WITH FRAME fr_search IN WINDOW wgwptr70.
  {&OPEN-BROWSERS-IN-QUERY-fr_search}
  DISPLAY fi_brdes fi_user fi_branch fi_acno1 fi_acdes 
      WITH FRAME fr_update IN WINDOW wgwptr70.
  ENABLE fi_user fi_branch fi_acno1 bu_add bu_del bu_exit 
      WITH FRAME fr_update IN WINDOW wgwptr70.
  {&OPEN-BROWSERS-IN-QUERY-fr_update}
  VIEW wgwptr70.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

