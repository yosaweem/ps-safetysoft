&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
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
/*  wgwqbclsrd.w - Set Body to Class                                     */
/* Copyright    : Tokio Marine Safety Insurance (Thailand) PCL.          */
/*                        บริษัท คุ้มภัยโตเกียวมารีนประกันภัย (ประเทศไทย)*/
/* CREATE BY    : Chaiyong W.   ASSIGN A65-0329  DATE 09/11/2022         */   
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
DEF VAR nv_typg    AS CHAR  INIT "Bodyclass".
DEF VAR nv_err     AS CHAR  INIT "".
DEF VAR nv_search  AS CHAR  INIT "".
DEF VAR nv_st      AS CHAR  INIT "".
DEF VAR nv_recid   AS RECID INIT ?.
DEF VAR nv_srecid  AS RECID INIT ?.
DEF TEMP-TABLE tuzpbrn 
    field type              as                char
    field expdat            as                date
    field effdat            as                date
    field entdat            as                date
    field trndat            as                date
    field entid             as                char
    field revid             as                char
    field typpara           as                char
    field typname           as                char
    field typdes            as                char
    field note1             as                char
    field note2             as                char
    field notee             as                char
    field ndeci1            as                deci
    field ndeci2            as                deci
    field ndecie            as                deci
    field widthp            as                char
    field heightp           as                char
    field typeg             as                char
    field line              as                inte
    field typcode           as                char
    field branchname        as                char
    field addr1             as                char
    field addr2             as                char
    field addr3             as                char
    field addr4             as                char
    field postcod           as                char
    field mail              as                char
    field tel               as                char
    field mobile            as                char
    field fax               as                char
    field note3             as                char
    field note4             as                char
    field note5             as                char
    field note6             as                char
    field note7             as                char
    field note8             as                char
    field note9             as                char
    field note10            as                char
    field note11            as                char
    field note12            as                char
    field note13            as                char
    field note14            as                char
    field note15            as                char
    field note16            as                char
    field note17            as                char
    field note18            as                char
    field note19            as                char
    field note20            as                char
    field ndeci3            as                deci
    field ndeci4            as                deci
    field ndeci5            as                deci
    field ndeci6            as                deci
    field ndeci7            as                deci
    field ndeci8            as                deci
    field ndeci9            as                deci
    field ndeci10           as                deci
    field entime            as                char
    field revtime           as                char
    FIELD nrecid            AS                RECID INIT ?.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME br_Q

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES tuzpbrn

/* Definitions for BROWSE br_Q                                          */
&Scoped-define FIELDS-IN-QUERY-br_Q tuzpbrn.typcode "Code" tuzpbrn.TYPE "Body" tuzpbrn.typpara "Make Description" tuzpbrn.typnam "Family Description" tuzpbrn.note1 "Body Config" tuzpbrn.note2 "Not" tuzpbrn.addr1 "Class" tuzpbrn.addr2 "Unit"   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_Q   
&Scoped-define SELF-NAME br_Q
&Scoped-define QUERY-STRING-br_Q FOR EACH tuzpbrn NO-LOCK
&Scoped-define OPEN-QUERY-br_Q OPEN QUERY br_q FOR EACH tuzpbrn NO-LOCK.
&Scoped-define TABLES-IN-QUERY-br_Q tuzpbrn
&Scoped-define FIRST-TABLE-IN-QUERY-br_Q tuzpbrn


/* Definitions for FRAME fr_query                                       */

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_create 
     LABEL "Create" 
     SIZE 12 BY 1.52.

DEFINE BUTTON bu_del 
     LABEL "Delete" 
     SIZE 12 BY 1.52.

DEFINE BUTTON bu_exit AUTO-END-KEY 
     LABEL "Exit" 
     SIZE 12 BY 1.52.

DEFINE BUTTON bu_update 
     LABEL "Update" 
     SIZE 12 BY 1.52.

DEFINE BUTTON bu_refresh 
     LABEL "Refresh" 
     SIZE 15 BY 1.14.

DEFINE VARIABLE co_search AS CHARACTER FORMAT "X(256)":U INITIAL "1" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "Code","1",
                     "Body","2",
                     "Make Desc.","3",
                     "Family Desc.","4",
                     "Body Config","5",
                     "Class","6"
     DROP-DOWN-LIST
     SIZE 16 BY 1 NO-UNDO.

DEFINE VARIABLE fi_search AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 62 BY 1
     FONT 32 NO-UNDO.

DEFINE VARIABLE fi_log AS CHARACTER FORMAT "X(256)":U 
     LABEL "" 
     VIEW-AS FILL-IN 
     SIZE 41 BY 1
     FONT 32 NO-UNDO.

DEFINE BUTTON bu_can 
     LABEL "Cancel" 
     SIZE 15 BY 1.14.

DEFINE BUTTON bu_save 
     LABEL "Save" 
     SIZE 15 BY 1.14.

DEFINE VARIABLE fi_addr1 AS CHARACTER FORMAT "X(6)":U 
     VIEW-AS FILL-IN 
     SIZE 10.5 BY 1
     FONT 32 NO-UNDO.

DEFINE VARIABLE fi_addr2 AS CHARACTER FORMAT "X":U 
     VIEW-AS FILL-IN 
     SIZE 10.5 BY 1
     FONT 32 NO-UNDO.

DEFINE VARIABLE fi_deci1 AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 5.5 BY 1
     FONT 32 NO-UNDO.

DEFINE VARIABLE fi_deci2 AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 5.5 BY 1
     FONT 32 NO-UNDO.

DEFINE VARIABLE fi_note1 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 23.5 BY 1
     FONT 32 NO-UNDO.

DEFINE VARIABLE fi_typcode AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     FONT 32 NO-UNDO.

DEFINE VARIABLE fi_type AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 23.5 BY 1
     FONT 32 NO-UNDO.

DEFINE VARIABLE fi_typnam AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 23.5 BY 1
     FONT 32 NO-UNDO.

DEFINE VARIABLE fi_typpara AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 23.5 BY 1
     FONT 32 NO-UNDO.

DEFINE VARIABLE tg_note2 AS LOGICAL INITIAL no 
     LABEL "Not Body Config" 
     VIEW-AS TOGGLE-BOX
     SIZE 22 BY .81
     FONT 32 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_Q FOR 
      tuzpbrn SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_Q
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_Q C-Win _FREEFORM
  QUERY br_Q DISPLAY
      tuzpbrn.typcode    format "X(15)"    column-label   "Code"
 tuzpbrn.TYPE       format "X(15)"    column-label   "Body"
 tuzpbrn.typpara    format "X(15)"    column-label   "Make   Description"
 tuzpbrn.typnam     format "X(15)"    column-label   "Family Description"
 tuzpbrn.note1      format "X(15)"    column-label   "Body Config"
 tuzpbrn.note2      format "X(1)"     column-label   "Not"
 tuzpbrn.addr1      format "X(7)"    column-label   "Class"
 tuzpbrn.addr2      format "X(1)"     column-label   "Unit"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 98 BY 7.38 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 101.83 BY 23.19 WIDGET-ID 100.

DEFINE FRAME fr_status
     fi_log AT ROW 1.71 COL 1.5 WIDGET-ID 2
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 2 ROW 21.24
         SIZE 44.5 BY 2.71 WIDGET-ID 700.

DEFINE FRAME fr_bu
     bu_create AT ROW 1.48 COL 1.83 WIDGET-ID 46
     bu_update AT ROW 1.48 COL 15.33 WIDGET-ID 48
     bu_del AT ROW 1.48 COL 28.83 WIDGET-ID 50
     bu_exit AT ROW 1.48 COL 42.83 WIDGET-ID 10
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 47 ROW 21.24
         SIZE 55 BY 2.71 WIDGET-ID 600.

DEFINE FRAME fr_query
     br_Q AT ROW 1.24 COL 1.5 WIDGET-ID 400
     co_search AT ROW 8.86 COL 19 NO-LABEL WIDGET-ID 2
     fi_search AT ROW 8.86 COL 35.67 COLON-ALIGNED NO-LABEL WIDGET-ID 4
     "Search By" VIEW-AS TEXT
          SIZE 14.5 BY 1 AT ROW 8.86 COL 2 WIDGET-ID 18
          FONT 32
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 2 ROW 3.24
         SIZE 100 BY 9.29 WIDGET-ID 300.

DEFINE FRAME fr_update
     fi_typcode AT ROW 1.52 COL 21 COLON-ALIGNED NO-LABEL WIDGET-ID 2
     fi_type AT ROW 1.71 COL 67 COLON-ALIGNED NO-LABEL WIDGET-ID 6
     fi_typpara AT ROW 3 COL 21 COLON-ALIGNED NO-LABEL WIDGET-ID 8
     fi_typnam AT ROW 3 COL 67 COLON-ALIGNED NO-LABEL WIDGET-ID 10
     fi_note1 AT ROW 4.52 COL 21 COLON-ALIGNED NO-LABEL WIDGET-ID 34
     tg_note2 AT ROW 4.52 COL 48 WIDGET-ID 36
     fi_deci1 AT ROW 6 COL 21 COLON-ALIGNED NO-LABEL WIDGET-ID 20
     fi_deci2 AT ROW 6 COL 33.5 COLON-ALIGNED NO-LABEL WIDGET-ID 26
     fi_addr1 AT ROW 6 COL 55 COLON-ALIGNED NO-LABEL WIDGET-ID 38
     fi_addr2 AT ROW 6 COL 77 COLON-ALIGNED NO-LABEL WIDGET-ID 40
     bu_save AT ROW 7.43 COL 56.5 WIDGET-ID 42
     bu_can AT ROW 7.43 COL 73.5 WIDGET-ID 44
     "Unit" VIEW-AS TEXT
          SIZE 8.5 BY 1 AT ROW 6 COL 70 WIDGET-ID 32
          FONT 32
     "Code" VIEW-AS TEXT
          SIZE 19 BY 1 AT ROW 1.52 COL 2 WIDGET-ID 18
          FONT 32
     "Family Description" VIEW-AS TEXT
          SIZE 20 BY 1 AT ROW 3 COL 48 WIDGET-ID 16
          FONT 32
     "Make Description" VIEW-AS TEXT
          SIZE 19 BY 1 AT ROW 3 COL 2 WIDGET-ID 14
          FONT 32
     "Body" VIEW-AS TEXT
          SIZE 8 BY 1 AT ROW 1.52 COL 48 WIDGET-ID 12
          FONT 32
     "Body Config" VIEW-AS TEXT
          SIZE 20 BY 1 AT ROW 4.52 COL 2 WIDGET-ID 28
          FONT 32
     "Door From" VIEW-AS TEXT
          SIZE 20 BY 1 AT ROW 6 COL 2 WIDGET-ID 22
          FONT 32
     "To" VIEW-AS TEXT
          SIZE 5 BY 1 AT ROW 6 COL 30 WIDGET-ID 24
          FONT 32
     "Class" VIEW-AS TEXT
          SIZE 8.5 BY 1 AT ROW 6 COL 48 WIDGET-ID 30
          FONT 32
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 2 ROW 12.76
         SIZE 100 BY 8.33 WIDGET-ID 200.

DEFINE FRAME fr_head
     bu_refresh AT ROW 1.48 COL 82.5 WIDGET-ID 2
     "Check Body To Class Redbook" VIEW-AS TEXT
          SIZE 43.5 BY 1.19 AT ROW 1.48 COL 22 WIDGET-ID 4
          FGCOLOR 7 FONT 23
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 2 ROW 1
         SIZE 100 BY 2.14
         BGCOLOR 3  WIDGET-ID 500.


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
         HEIGHT             = 23.19
         WIDTH              = 101.83
         MAX-HEIGHT         = 23.62
         MAX-WIDTH          = 121.67
         VIRTUAL-HEIGHT     = 23.62
         VIRTUAL-WIDTH      = 121.67
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
IF NOT C-Win:LOAD-ICON("WIMAGE/safety.ico":U) THEN
    MESSAGE "Unable to load icon: WIMAGE/safety.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* REPARENT FRAME */
ASSIGN FRAME fr_bu:FRAME = FRAME DEFAULT-FRAME:HANDLE
       FRAME fr_head:FRAME = FRAME DEFAULT-FRAME:HANDLE
       FRAME fr_query:FRAME = FRAME DEFAULT-FRAME:HANDLE
       FRAME fr_status:FRAME = FRAME DEFAULT-FRAME:HANDLE
       FRAME fr_update:FRAME = FRAME DEFAULT-FRAME:HANDLE.

/* SETTINGS FOR FRAME DEFAULT-FRAME
   FRAME-NAME                                                           */

DEFINE VARIABLE XXTABVALXX AS LOGICAL NO-UNDO.

ASSIGN XXTABVALXX = FRAME fr_status:MOVE-BEFORE-TAB-ITEM (FRAME fr_bu:HANDLE)
       XXTABVALXX = FRAME fr_update:MOVE-BEFORE-TAB-ITEM (FRAME fr_status:HANDLE)
       XXTABVALXX = FRAME fr_query:MOVE-BEFORE-TAB-ITEM (FRAME fr_update:HANDLE)
       XXTABVALXX = FRAME fr_head:MOVE-BEFORE-TAB-ITEM (FRAME fr_query:HANDLE)
/* END-ASSIGN-TABS */.

/* SETTINGS FOR FRAME fr_bu
                                                                        */
/* SETTINGS FOR FRAME fr_head
                                                                        */
/* SETTINGS FOR FRAME fr_query
                                                                        */
/* BROWSE-TAB br_Q TEXT-11 fr_query */
/* SETTINGS FOR COMBO-BOX co_search IN FRAME fr_query
   ALIGN-L                                                              */
/* SETTINGS FOR FRAME fr_status
                                                                        */
/* SETTINGS FOR FILL-IN fi_log IN FRAME fr_status
   NO-ENABLE ALIGN-L                                                    */
/* SETTINGS FOR FRAME fr_update
   Custom                                                               */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_Q
/* Query rebuild information for BROWSE br_Q
     _START_FREEFORM
OPEN QUERY br_q FOR EACH tuzpbrn NO-LOCK.
     _END_FREEFORM
     _Query            is NOT OPENED
*/  /* BROWSE br_Q */
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


&Scoped-define BROWSE-NAME br_Q
&Scoped-define FRAME-NAME fr_query
&Scoped-define SELF-NAME br_Q
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_Q C-Win
ON MOUSE-SELECT-CLICK OF br_Q IN FRAME fr_query
DO:
    RUN pd_disp.
    RUN pd_but.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_Q C-Win
ON VALUE-CHANGED OF br_Q IN FRAME fr_query
DO:
    RUN pd_disp.
    RUN pd_but.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_update
&Scoped-define SELF-NAME bu_can
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_can C-Win
ON CHOOSE OF bu_can IN FRAME fr_update /* Cancel */
DO:

    DEF VAR nv_st2 AS CHAR INIT "".
    ENABLE  ALL WITH FRAME fr_head.
    ENABLE  ALL WITH FRAME fr_bu.
    DISABLE ALL WITH FRAME fr_update.
    IF  nv_st = "Save" THEN DO:
        ENABLE ALL WITH FRAME fr_query.
        
    END.
    ELSE IF nv_st =  "Create" OR nv_st = "Update" THEN DO:
        IF nv_st = "Create" THEN CLEAR FRAME fr_update.
        nv_st2 = nv_st.
        nv_st  = "refresh".
        RUN pd_refresh.    
        
        
        

        IF nv_srecid <> ?  THEN DO:
            nv_st  = "Save".
            RUN pd_search.
        END.   
        IF nv_st2 = "Create" THEN DO:
            RUN pd_search.
            nv_st  = "".
            ASSIGN
                nv_srecid = ?
                nv_Recid  = ?.
            CLEAR FRAME fr_update.
            CLEAR FRAME fr_status.
            DISABLE bu_del bu_update WITH FRAME fr_bu.
        end.
        IF nv_srecid = ? THEN DISABLE bu_update bu_del WITH FRAME fr_bu.

    END.
    ELSE DO:
        CLEAR FRAME fr_update.
        DISABLE   bu_update bu_del WITH FRAME fr_bu.
        DISABLE bu_update bu_del WITH FRAME fr_bu.
    END.
    nv_st = "".
    
    
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_bu
&Scoped-define SELF-NAME bu_create
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_create C-Win
ON CHOOSE OF bu_create IN FRAME fr_bu /* Create */
DO:
    nv_St = "Create".
    nv_recid = ?.
    CLEAR FRAME fr_update.
    CLEAR FRAME fr_status.
    ENABLE ALL WITH FRAME fr_update.
    DISABLE ALL WITH FRAME fr_bu.
    DISABLE ALL WITH FRAME fr_query.
    DISABLE ALL WITH FRAME fr_head.
    ENABLE bu_exit WITH FRAME fr_bu.


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_del
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_del C-Win
ON CHOOSE OF bu_del IN FRAME fr_bu /* Delete */
DO:
    DEF VAR nv_chkdel AS LOGICAL INIT NO.
    MESSAGE "Do you want to delete this " fi_typcode   " ?"
    UPDATE nv_chkdel VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO  TITLE "Comfirm".
    IF nv_chkdel THEN DO:
        nv_st    = "Delete".
        RUN pd_del.
        
        nv_st = "Refresh".
        RUN pd_refresh.

        nv_st = "Delete".
        nv_search = fi_typcode.
        RUN pd_search.



        ASSIGN
            nv_srecid = ?
            nv_Recid  = ?.
        CLEAR FRAME fr_update.
        CLEAR FRAME fr_status.
        DISABLE bu_del bu_update WITH FRAME fr_bu.

        nv_st = "".
    END.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit C-Win
ON CHOOSE OF bu_exit IN FRAME fr_bu /* Exit */
DO:
    APPLY "CLOSE" TO THIS-PROCEDURE.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_head
&Scoped-define SELF-NAME bu_refresh
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_refresh C-Win
ON CHOOSE OF bu_refresh IN FRAME fr_head /* Refresh */
DO:
    nv_st  = "refresh".
    RUN pd_refresh.
    RUN pd_search.
    nv_st  = "".
    ASSIGN
        nv_srecid = ?
        nv_Recid  = ?.
    CLEAR FRAME fr_update.
    CLEAR FRAME fr_status.
    DISABLE bu_del bu_update WITH FRAME fr_bu.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_update
&Scoped-define SELF-NAME bu_save
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_save C-Win
ON CHOOSE OF bu_save IN FRAME fr_update /* Save */
DO:
    ASSIGN
        fi_typcode  = caps(trim(input fi_typcode  ))
        fi_type     = caps(trim(input fi_type     ))
        fi_typpara  = caps(trim(input fi_typpara  ))
        fi_typnam   = caps(trim(input fi_typnam   ))
        fi_note1    = caps(trim(input fi_note1    ))
        tg_note2    = tg_note2                      
        fi_deci1    = input fi_deci1   
        fi_deci2    = input fi_deci2   
        fi_addr1    = caps(trim(input fi_addr1    ))
        fi_addr2    = caps(trim(input fi_addr2    )) .

    IF fi_typcode = "" THEN DO:
        MESSAGE "Code is Mandatory" VIEW-AS ALERT-BOX INFORMATION.
        APPLY "entry" TO fi_typcode.
        RETURN NO-APPLY.

    END.
    APPLY "leave" TO fi_deci2.
    IF fi_addr1  = "" THEN DO:
        MESSAGE "Class is Mandatory" VIEW-AS ALERT-BOX INFORMATION.
        APPLY "entry" TO fi_addr1.
        RETURN NO-APPLY.

    END.
    IF fi_addr2  = "" THEN DO:
        MESSAGE "Unit is Mandatory" VIEW-AS ALERT-BOX INFORMATION.
        APPLY "entry" TO fi_addr2.
        RETURN NO-APPLY.
    END.
    APPLY "leave" TO fi_addr2.

    IF tg_note2 AND fi_note1 = "" THEN DO:
        MESSAGE "Body Config is Mandatory" VIEW-AS ALERT-BOX INFORMATION.
        APPLY "entry" TO fi_note1.
        RETURN NO-APPLY.
    END.
    IF fi_type = "" AND fi_typpara = "" AND fi_typnam = "" THEN DO:
        MESSAGE "Body is Mandatory" VIEW-AS ALERT-BOX INFORMATION.
        APPLY "entry" TO fi_type.
        RETURN NO-APPLY.

    END.


    IF nv_St = "Create" THEN DO:
        FIND FIRST uzpbrn WHERE uzpbrn.typeg    = nv_typg    AND
                                uzpbrn.typcode  = fi_typcode NO-LOCK NO-ERROR.
        IF AVAIL uzpbrn THEN DO:
            MESSAGE "Found Code Please Change Code" VIEW-AS ALERT-BOX INFORMATION.
            APPLY "entry" TO fi_typcode.
            RETURN NO-APPLY.
        END.
    END.
    ELSE DO:
        FIND FIRST uzpbrn WHERE uzpbrn.typeg    = nv_typg    AND
                                uzpbrn.typcode  = fi_typcode AND
                                RECID(uzpbrn)   <> nv_recid   NO-LOCK NO-ERROR.
        IF AVAIL uzpbrn THEN DO:
            MESSAGE "Found Code Please Change Code" VIEW-AS ALERT-BOX INFORMATION.
            APPLY "entry" TO fi_typcode.
            RETURN NO-APPLY.
        END.                                      
    END.
    nv_err = "".
    RUN pd_save.
    IF nv_err <> "" THEN DO:
        MESSAGE nv_err VIEW-AS ALERT-BOX INFORMATION.
        nv_err = "".
        APPLY "entry" TO fi_typcode.
    END.
    nv_st  = "refresh".
    RUN pd_refresh.            
    nv_st  = "Save".
    RUN pd_search.
    APPLY "choose" TO bu_can.

    



END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_bu
&Scoped-define SELF-NAME bu_update
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_update C-Win
ON CHOOSE OF bu_update IN FRAME fr_bu /* Update */
DO:
    CLEAR FRAME fr_status.
    ENABLE ALL WITH FRAME fr_update.
    DISABLE ALL WITH FRAME fr_bu.
    DISABLE ALL WITH FRAME fr_query.
    DISABLE ALL WITH FRAME fr_head.
    ENABLE bu_exit WITH FRAME fr_bu.
    FIND uzpbrn WHERE RECID(uzpbrn) = nv_recid NO-LOCK NO-ERROR.
    IF AVAIL uzpbrn THEN DO:
        FIND tuzpbrn WHERE tuzpbrn.nrecid = nv_recid NO-ERROR NO-WAIT.
        IF AVAIL tuzpbrn THEN DO:
            RUN pd_crq.
            RUN pd_disp.
        END.
    END.
    nv_St = "Update".
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_query
&Scoped-define SELF-NAME co_search
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL co_search C-Win
ON VALUE-CHANGED OF co_search IN FRAME fr_query
DO:
    co_search = INPUT co_search.
    DO WITH FRAME fr_head:
        APPLY "choose" TO bu_refresh.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_update
&Scoped-define SELF-NAME fi_addr1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_addr1 C-Win
ON LEAVE OF fi_addr1 IN FRAME fr_update
DO:
    fi_addr1    = caps(trim(input fi_addr1    )) .  
    disp fi_addr1    with frame fr_update.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_addr2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_addr2 C-Win
ON LEAVE OF fi_addr2 IN FRAME fr_update
DO:
    fi_addr2    = caps(trim(input fi_addr2    )) .  
    disp fi_addr2    with frame fr_update.
    IF fi_addr2 <> "" THEN DO:
        IF fi_addr2  <> "C" AND fi_addr2 <> "S" AND fi_addr2 <> "T" THEN DO:
            MESSAGE "UNIT / C,S,T Only" VIEW-AS ALERT-BOX INFORMATION.
            APPLY "entry" TO fi_addr2.
            RETURN NO-APPLY.
        END.
    END.

  

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_deci2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_deci2 C-Win
ON LEAVE OF fi_deci2 IN FRAME fr_update
DO:
    ASSIGN
        fi_deci1 = INPUT fi_deci1
        fi_deci2 = INPUT fi_deci2.
    IF fi_deci1 <> 0 OR fi_deci2 <> 0 THEN DO:
        IF fi_deci2 < fi_deci1 THEN DO:
            MESSAGE "Door From <= Door To" VIEW-AS ALERT-BOX INFORMATION.
            APPLY "entry" TO fi_deci1.
            RETURN NO-APPLY.
        END.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_note1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_note1 C-Win
ON LEAVE OF fi_note1 IN FRAME fr_update
DO:
    fi_note1    = caps(trim(input fi_note1    )) .   
    disp fi_note1    with frame fr_update.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_query
&Scoped-define SELF-NAME fi_search
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_search C-Win
ON RETURN OF fi_search IN FRAME fr_query
DO:
    nv_st      = "Search".
    nv_search  = trim(INPUT fi_search).
    RUN pd_refresh.
    RUN pd_search.
    nv_st      = "".
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_update
&Scoped-define SELF-NAME fi_typcode
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_typcode C-Win
ON LEAVE OF fi_typcode IN FRAME fr_update
DO:
    fi_typcode  = caps(trim(input fi_typcode  )).
    DISP  fi_typcode  WITH FRAME fr_update.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_type
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_type C-Win
ON LEAVE OF fi_type IN FRAME fr_update
DO:
     fi_type     = caps(trim(input fi_type     )) .   
     disp fi_type     with frame fr_update.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_typnam
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_typnam C-Win
ON LEAVE OF fi_typnam IN FRAME fr_update
DO:
    fi_typnam   = caps(trim(input fi_typnam   )) .   
    disp fi_typnam   with frame fr_update.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_typpara
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_typpara C-Win
ON LEAVE OF fi_typpara IN FRAME fr_update
DO:
    fi_typpara  = caps(trim(input fi_typpara  )) .   
    disp fi_typpara  with frame fr_update.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME tg_note2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL tg_note2 C-Win
ON VALUE-CHANGED OF tg_note2 IN FRAME fr_update /* Not Body Config */
DO:
    tg_note2    = tg_note2                       . 
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
  DEF  VAR  gv_prog    AS   CHAR  FORMAT "X(50)" NO-UNDO.
  gv_prgid = "wgwqbclrd.W".
  gv_prog  = "Check Body To Class Redbook". 
    
    RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).
    RUN  WUT\WUTWICEN (c-win:handle).  
  SESSION:DATA-ENTRY-RETURN = YES.

  DISABLE ALL WITH FRAME fr_update.
  APPLY "choose" TO bu_refresh.
  APPLY "choose" TO bu_can.
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
  ENABLE bu_refresh 
      WITH FRAME fr_head IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_head}
  DISPLAY co_search fi_search 
      WITH FRAME fr_query IN WINDOW C-Win.
  ENABLE br_Q co_search fi_search 
      WITH FRAME fr_query IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_query}
  DISPLAY fi_typcode fi_type fi_typpara fi_typnam fi_note1 tg_note2 fi_deci1 
          fi_deci2 fi_addr1 fi_addr2 
      WITH FRAME fr_update IN WINDOW C-Win.
  ENABLE fi_typcode fi_type fi_typpara fi_typnam fi_note1 tg_note2 fi_deci1 
         fi_deci2 fi_addr1 fi_addr2 bu_save bu_can 
      WITH FRAME fr_update IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_update}
  DISPLAY fi_log 
      WITH FRAME fr_status IN WINDOW C-Win.
  VIEW FRAME fr_status IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_status}
  ENABLE bu_create bu_update bu_del bu_exit 
      WITH FRAME fr_bu IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_bu}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_but C-Win 
PROCEDURE pd_but :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ENABLE bu_update bu_del WITH FRAME fr_bu.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_crq C-Win 
PROCEDURE pd_crq :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  
    ASSIGN
        tuzpbrn.type           = uzpbrn.type     
        tuzpbrn.expdat         = uzpbrn.expdat   
        tuzpbrn.effdat         = uzpbrn.effdat   
        tuzpbrn.entdat         = uzpbrn.entdat   
        tuzpbrn.trndat         = uzpbrn.trndat   
        tuzpbrn.entid          = uzpbrn.entid    
        tuzpbrn.revid          = uzpbrn.revid    
        tuzpbrn.typpara        = uzpbrn.typpara  
        tuzpbrn.typname        = uzpbrn.typname  
        tuzpbrn.typdes         = uzpbrn.typdes   
        tuzpbrn.note1          = uzpbrn.note1    
        tuzpbrn.note2          = uzpbrn.note2    
    /*    tuzpbrn.notee          = uzpbrn.notee    */
        tuzpbrn.ndeci1         = uzpbrn.ndeci1   
        tuzpbrn.ndeci2         = uzpbrn.ndeci2   
     /*     tuzpbrn.ndecie         = uzpbrn.ndecie */  
        tuzpbrn.widthp         = uzpbrn.widthp   
        tuzpbrn.heightp        = uzpbrn.heightp  
        tuzpbrn.typeg          = uzpbrn.typeg    
        tuzpbrn.line           = uzpbrn.line     
        tuzpbrn.typcode        = uzpbrn.typcode  
        tuzpbrn.branchname     = uzpbrn.branchnam
        tuzpbrn.addr1          = uzpbrn.addr1    
        tuzpbrn.addr2          = uzpbrn.addr2    
        tuzpbrn.addr3          = uzpbrn.addr3    
        tuzpbrn.addr4          = uzpbrn.addr4    
        tuzpbrn.postcod        = uzpbrn.postcod  
        tuzpbrn.mail           = uzpbrn.mail     
        tuzpbrn.tel            = uzpbrn.tel      
        tuzpbrn.mobile         = uzpbrn.mobile   
        tuzpbrn.fax            = uzpbrn.fax      
        tuzpbrn.note3          = uzpbrn.note3    
        tuzpbrn.note4          = uzpbrn.note4    
        tuzpbrn.note5          = uzpbrn.note5    
        tuzpbrn.note6          = uzpbrn.note6    
        tuzpbrn.note7          = uzpbrn.note7    
        tuzpbrn.note8          = uzpbrn.note8    
        tuzpbrn.note9          = uzpbrn.note9    
        tuzpbrn.note10         = uzpbrn.note10   
        tuzpbrn.note11         = uzpbrn.note11   
        tuzpbrn.note12         = uzpbrn.note12   
        tuzpbrn.note13         = uzpbrn.note13   
        tuzpbrn.note14         = uzpbrn.note14   
        tuzpbrn.note15         = uzpbrn.note15   
        tuzpbrn.note16         = uzpbrn.note16   
        tuzpbrn.note17         = uzpbrn.note17   
        tuzpbrn.note18         = uzpbrn.note18   
        tuzpbrn.note19         = uzpbrn.note19   
        tuzpbrn.note20         = uzpbrn.note20   
        tuzpbrn.ndeci3         = uzpbrn.ndeci3   
        tuzpbrn.ndeci4         = uzpbrn.ndeci4   
        tuzpbrn.ndeci5         = uzpbrn.ndeci5   
        tuzpbrn.ndeci6         = uzpbrn.ndeci6   
        tuzpbrn.ndeci7         = uzpbrn.ndeci7   
        tuzpbrn.ndeci8         = uzpbrn.ndeci8   
        tuzpbrn.ndeci9         = uzpbrn.ndeci9   
        tuzpbrn.ndeci10        = uzpbrn.ndeci10  
        tuzpbrn.entime         = uzpbrn.entime   
        tuzpbrn.revtime        = uzpbrn.revtime  
        tuzpbrn.nrecid         = recid(uzpbrn) .
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_del C-Win 
PROCEDURE pd_del :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND uzpbrn WHERE RECID(uzpbrn) = nv_recid NO-ERROR NO-WAIT.
IF AVAIL uzpbrn THEN DO:
    DELETE uzpbrn.
END.
ELSE DO:
    MESSAGE "Not found Data" VIEW-AS ALERT-BOX INFORMATION.
END.
RELEASE uzpbrn NO-ERROR.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_disp C-Win 
PROCEDURE pd_disp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF AVAIL tuzpbrn THEN DO:
    ASSIGN
        nv_recid    = tuzpbrn.nrecid
        nv_srecid   = tuzpbrn.nrecid
        fi_typcode  = tuzpbrn.typcode  
        fi_type     = tuzpbrn.type     
        fi_typpara  = tuzpbrn.typpara  
        fi_typnam   = tuzpbrn.typnam   
        fi_note1    = tuzpbrn.note1    
        tg_note2    = IF tuzpbrn.note2 = "Y" THEN YES ELSE NO
        fi_deci1    = tuzpbrn.ndeci1    
        fi_deci2    = tuzpbrn.ndeci2    
        fi_addr1    = tuzpbrn.addr1    
        fi_addr2    = tuzpbrn.addr2.
    fi_log     = tuzpbrn.entid + FILL(" ",5) + string(tuzpbrn.entdat,"99/99/9999") + FILL(" ",5) + tuzpbrn.entime   .
    DISP fi_typcode  
         fi_type     
         fi_typpara  
         fi_typnam   
         fi_note1    
         tg_note2    
         fi_deci1    
         fi_deci2    
         fi_addr1    
         fi_addr2    WITH FRAME fr_update.
    DISP fi_log WITH FRAME fr_status.
END.














END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_refresh C-Win 
PROCEDURE pd_refresh :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_f AS LOGICAL INIT NO.
EMPTY TEMP-TABLE tuzpbrn NO-ERROR.
IF nv_St = "Search" THEN DO:
    IF co_Search = "1"  THEN DO:
        FOR EACH uzpbrn WHERE uzpbrn.typeg   = nv_typg AND
                              uzpbrn.typcode BEGINS nv_search NO-LOCK:
            CREATE tuzpbrn.
            RUN pd_crq.
            nv_f = YES.
        END.
    END.
    ELSE IF co_Search = "2"  THEN DO:
        FOR EACH uzpbrn WHERE uzpbrn.typeg   = nv_typg AND
                              uzpbrn.TYPE BEGINS nv_search NO-LOCK:
            CREATE tuzpbrn.
            RUN pd_crq.
            nv_f = YES.
        END.
    END.
    ELSE IF co_Search = "3"  THEN DO:
        FOR EACH uzpbrn WHERE uzpbrn.typeg   = nv_typg AND
                              uzpbrn.typpara  BEGINS nv_search NO-LOCK:
            CREATE tuzpbrn.
            RUN pd_crq.
            nv_f = YES.
        END.
    END.
    ELSE IF co_Search = "4"  THEN DO:
        FOR EACH uzpbrn WHERE uzpbrn.typeg   = nv_typg AND
                              uzpbrn.typnam  BEGINS nv_search NO-LOCK:
            CREATE tuzpbrn.
            RUN pd_crq.
            nv_f = YES.
        END.
    END.
    ELSE IF co_Search = "5"  THEN DO:
        FOR EACH uzpbrn WHERE uzpbrn.typeg   = nv_typg AND
                              uzpbrn.note1 BEGINS nv_search NO-LOCK:
            CREATE tuzpbrn.
            RUN pd_crq.
            nv_f = YES.
        END.
       
    END.
    ELSE IF co_Search = "6"  THEN DO:
        FOR EACH uzpbrn WHERE uzpbrn.typeg   = nv_typg AND
                              uzpbrn.addr1 BEGINS nv_search NO-LOCK:
            CREATE tuzpbrn.
            RUN pd_crq.
            nv_f = YES.
        END.
    END.
    IF nv_f = NO THEN DO:
        MESSAGE "Not Found Data" VIEW-AS ALERT-BOX INFORMATION.
        FOR EACH uzpbrn WHERE uzpbrn.typeg = nv_typg NO-LOCK:
            CREATE tuzpbrn.
            RUN pd_crq.
            nv_f = YES.
        END.
    END.

END.
IF nv_st = "Refresh" THEN DO:
    FOR EACH uzpbrn WHERE uzpbrn.typeg = nv_typg NO-LOCK:
        CREATE tuzpbrn.
        RUN pd_crq.
        nv_f = YES.
    END.
END.
IF nv_f THEN DO:
    ENABLE ALL WITH FRAME fr_query.
END.
ELSE DO:
    DISABLE ALL WITH FRAME fr_query.
    DISABLE bu_update bu_del WITH FRAME fr_bu.
END.



END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_save C-Win 
PROCEDURE pd_save :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF nv_st = "Update" THEN DO:
    FIND FIRST uzpbrn WHERE RECID(uzpbrn) = nv_recid NO-ERROR NO-WAIT.
    IF AVAIL uzpbrn THEN DO:
        
        RUN pd_update.
    END.
    ELSE DO:
        nv_err   = "Not Found Data!!!".
    END.
    
END.
IF nv_st = "Create" THEN DO:
    FIND FIRST uzpbrn WHERE uzpbrn.typeg    = nv_typg    AND
                            uzpbrn.typcode  = fi_typcode NO-ERROR NO-WAIT.
    IF NOT AVAIL uzpbrn THEN DO:
        CREATE uzpbrn.
        RUN pd_update.
        ASSIGN
            nv_recid  = RECID(uzpbrn)
            nv_srecid = RECID(uzpbrn).
        
    END.
    ELSE DO:
        nv_err   = "Record is Lock".
    END.
END.
RELEASE uzpbrn NO-ERROR.
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
IF nv_st = "Refresh" OR nv_st = "Search" THEN DO:
    IF co_Search = "1"  THEN DO:
        OPEN QUERY br_q FOR EACH tuzpbrn NO-LOCK BY tuzpbrn.typcode BY tuzpbrn.TYPE BY tuzpbrn.typpara BY tuzpbrn.typnam BY tuzpbrn.note1 BY tuzpbrn.addr1 BY tuzpbrn.typcode BY tuzpbrn.TYPE BY tuzpbrn.typpara BY tuzpbrn.typnam BY tuzpbrn.note1 .
    END.
    ELSE IF co_Search = "2"  THEN DO:
        OPEN QUERY br_q FOR EACH tuzpbrn NO-LOCK BY tuzpbrn.TYPE BY tuzpbrn.typpara BY tuzpbrn.typnam BY tuzpbrn.note1 BY tuzpbrn.addr1 BY tuzpbrn.typcode.
    END.
    ELSE IF co_Search = "3"  THEN DO:
        OPEN QUERY br_q FOR EACH tuzpbrn NO-LOCK BY tuzpbrn.typpara BY tuzpbrn.typnam BY tuzpbrn.note1 BY tuzpbrn.addr1 BY tuzpbrn.typcode BY tuzpbrn.TYPE.
    END.
    ELSE IF co_Search = "4"  THEN DO:
        OPEN QUERY br_q FOR EACH tuzpbrn NO-LOCK BY tuzpbrn.typnam BY tuzpbrn.note1 BY tuzpbrn.addr1 BY tuzpbrn.typcode BY tuzpbrn.TYPE BY tuzpbrn.typpara.
    END.
    ELSE IF co_Search = "5"  THEN DO:
        OPEN QUERY br_q FOR EACH tuzpbrn NO-LOCK BY tuzpbrn.note1 BY tuzpbrn.addr1 BY tuzpbrn.typcode BY tuzpbrn.TYPE BY tuzpbrn.typpara BY tuzpbrn.typnam .
    END.
    ELSE IF co_Search = "6"  THEN DO:
        OPEN QUERY br_q FOR EACH tuzpbrn NO-LOCK BY tuzpbrn.addr1 BY tuzpbrn.typcode BY tuzpbrn.TYPE BY tuzpbrn.typpara BY tuzpbrn.typnam BY tuzpbrn.note1 .
    END.
END.
IF nv_st = "Save" THEN DO:
    IF co_Search = "1"  THEN DO:
        OPEN QUERY br_q FOR EACH tuzpbrn NO-LOCK BY tuzpbrn.typcode BY tuzpbrn.TYPE BY tuzpbrn.typpara BY tuzpbrn.typnam BY tuzpbrn.note1 BY tuzpbrn.addr1 BY tuzpbrn.typcode BY tuzpbrn.TYPE BY tuzpbrn.typpara BY tuzpbrn.typnam BY tuzpbrn.note1 .
        FIND FIRST tuzpbrn WHERE tuzpbrn.nrecid = nv_srecid NO-LOCK NO-ERROR.
        IF AVAIL tuzpbrn THEN DO:
            REPOSITION br_q TO RECID RECID(tuzpbrn).
        END.
    END.
    ELSE IF co_Search = "2"  THEN DO:
        OPEN QUERY br_q FOR EACH tuzpbrn NO-LOCK BY tuzpbrn.TYPE BY tuzpbrn.typpara BY tuzpbrn.typnam BY tuzpbrn.note1 BY tuzpbrn.addr1 BY tuzpbrn.typcode BY tuzpbrn.TYPE BY tuzpbrn.typpara BY tuzpbrn.typnam BY tuzpbrn.note1 .
         FIND FIRST tuzpbrn WHERE tuzpbrn.nrecid = nv_srecid NO-LOCK NO-ERROR.
        IF AVAIL tuzpbrn THEN DO:
            REPOSITION br_q TO RECID RECID(tuzpbrn).
        END.
    END.
    ELSE IF co_Search = "3"  THEN DO:
        OPEN QUERY br_q FOR EACH tuzpbrn NO-LOCK BY tuzpbrn.typpara BY tuzpbrn.typnam BY tuzpbrn.note1 BY tuzpbrn.addr1 BY tuzpbrn.typcode BY tuzpbrn.TYPE.
        FIND FIRST tuzpbrn WHERE tuzpbrn.nrecid = nv_srecid NO-LOCK NO-ERROR.
        IF AVAIL tuzpbrn THEN DO:
            REPOSITION br_q TO RECID RECID(tuzpbrn).
        END.
    END.
    ELSE IF co_Search = "4"  THEN DO:
        OPEN QUERY br_q FOR EACH tuzpbrn NO-LOCK BY tuzpbrn.typnam BY tuzpbrn.note1 BY tuzpbrn.addr1 BY tuzpbrn.typcode BY tuzpbrn.TYPE BY tuzpbrn.typpara.
        FIND FIRST tuzpbrn WHERE tuzpbrn.nrecid = nv_srecid NO-LOCK NO-ERROR.
        IF AVAIL tuzpbrn THEN DO:
            REPOSITION br_q TO RECID RECID(tuzpbrn).
        END.
    END.
    ELSE IF co_Search = "5"  THEN DO:
        OPEN QUERY br_q FOR EACH tuzpbrn NO-LOCK BY tuzpbrn.note1 BY tuzpbrn.addr1 BY tuzpbrn.typcode BY tuzpbrn.TYPE BY tuzpbrn.typpara BY tuzpbrn.typnam .
        FIND FIRST tuzpbrn WHERE tuzpbrn.nrecid = nv_srecid NO-LOCK NO-ERROR.
        IF AVAIL tuzpbrn THEN DO:
            REPOSITION br_q TO RECID RECID(tuzpbrn).
        END.
    END.
    ELSE IF co_Search = "6"  THEN DO:
        OPEN QUERY br_q FOR EACH tuzpbrn NO-LOCK BY tuzpbrn.addr1 BY tuzpbrn.typcode BY tuzpbrn.TYPE BY tuzpbrn.typpara BY tuzpbrn.typnam BY tuzpbrn.note1 .
        FIND FIRST tuzpbrn WHERE tuzpbrn.nrecid = nv_srecid NO-LOCK NO-ERROR.
        IF AVAIL tuzpbrn THEN DO:
            REPOSITION br_q TO RECID RECID(tuzpbrn).
        END.
    END.
END.
IF nv_st = "Delete" THEN DO:
    IF co_Search = "1"  THEN DO:
        OPEN QUERY br_q FOR EACH tuzpbrn NO-LOCK BY tuzpbrn.typcode BY tuzpbrn.TYPE BY tuzpbrn.typpara BY tuzpbrn.typnam BY tuzpbrn.note1 BY tuzpbrn.addr1 BY tuzpbrn.typcode BY tuzpbrn.TYPE BY tuzpbrn.typpara BY tuzpbrn.typnam BY tuzpbrn.note1 .
        FIND FIRST tuzpbrn WHERE tuzpbrn.typcode >= nv_search NO-LOCK NO-ERROR.
        IF AVAIL tuzpbrn THEN DO:
            REPOSITION br_q TO RECID RECID(tuzpbrn).
        END.
    END.
    ELSE IF co_Search = "2"  THEN DO:
        OPEN QUERY br_q FOR EACH tuzpbrn NO-LOCK BY tuzpbrn.TYPE BY tuzpbrn.typpara BY tuzpbrn.typnam BY tuzpbrn.note1 BY tuzpbrn.addr1 BY tuzpbrn.typcode BY tuzpbrn.TYPE BY tuzpbrn.typpara BY tuzpbrn.typnam BY tuzpbrn.note1 .
         FIND FIRST tuzpbrn WHERE tuzpbrn.TYPE >= nv_search NO-LOCK NO-ERROR.
        IF AVAIL tuzpbrn THEN DO:
            REPOSITION br_q TO RECID RECID(tuzpbrn).
        END.
    END.
    ELSE IF co_Search = "3"  THEN DO:
        OPEN QUERY br_q FOR EACH tuzpbrn NO-LOCK BY tuzpbrn.typpara BY tuzpbrn.typnam BY tuzpbrn.note1 BY tuzpbrn.addr1 BY tuzpbrn.typcode BY tuzpbrn.TYPE.
        FIND FIRST tuzpbrn WHERE tuzpbrn.typpara >= nv_search NO-LOCK NO-ERROR.
        IF AVAIL tuzpbrn THEN DO:
            REPOSITION br_q TO RECID RECID(tuzpbrn).
        END.
    END.
    ELSE IF co_Search = "4"  THEN DO:
        OPEN QUERY br_q FOR EACH tuzpbrn NO-LOCK BY tuzpbrn.typnam BY tuzpbrn.note1 BY tuzpbrn.addr1 BY tuzpbrn.typcode BY tuzpbrn.TYPE BY tuzpbrn.typpara.
        FIND FIRST tuzpbrn WHERE tuzpbrn.TYPnam >= nv_search NO-LOCK NO-ERROR.
        IF AVAIL tuzpbrn THEN DO:
            REPOSITION br_q TO RECID RECID(tuzpbrn).
        END.
    END.
    ELSE IF co_Search = "5"  THEN DO:
        OPEN QUERY br_q FOR EACH tuzpbrn NO-LOCK BY tuzpbrn.note1 BY tuzpbrn.addr1 BY tuzpbrn.typcode BY tuzpbrn.TYPE BY tuzpbrn.typpara BY tuzpbrn.typnam .
        FIND FIRST tuzpbrn WHERE tuzpbrn.note1 >= nv_search NO-LOCK NO-ERROR.
        IF AVAIL tuzpbrn THEN DO:
            REPOSITION br_q TO RECID RECID(tuzpbrn).
        END.
    END.
    ELSE IF co_Search = "6"  THEN DO:
        OPEN QUERY br_q FOR EACH tuzpbrn NO-LOCK BY tuzpbrn.addr1 BY tuzpbrn.typcode BY tuzpbrn.TYPE BY tuzpbrn.typpara BY tuzpbrn.typnam BY tuzpbrn.note1 .
        FIND FIRST tuzpbrn WHERE tuzpbrn.addr1 >= nv_search NO-LOCK NO-ERROR.
        IF AVAIL tuzpbrn THEN DO:
            REPOSITION br_q TO RECID RECID(tuzpbrn).
        END.
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_update C-Win 
PROCEDURE pd_update :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
  uzpbrn.typeg                             = nv_typg 
  uzpbrn.typcode                           = fi_typcode 
  uzpbrn.type                              = fi_type    
  uzpbrn.typpara                           = fi_typpara 
  uzpbrn.typnam                            = fi_typnam  
  uzpbrn.note1                             = fi_note1   
  uzpbrn.note2                             = IF  tg_note2 = YES THEN "Y" ELSE "N"
  uzpbrn.ndeci1                            = fi_deci1   
  uzpbrn.ndeci2                            = fi_deci2   
  uzpbrn.addr1                             = fi_addr1   
  uzpbrn.addr2                             = fi_addr2   
  uzpbrn.entid                             = USERID(LDBNAME(1))
  uzpbrn.entdat                            = TODAY
  uzpbrn.entime                            = STRING(TIME,"HH:MM:SS").
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

