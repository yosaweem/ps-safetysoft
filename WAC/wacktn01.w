&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
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


/* ******************************************************************** */
/* Dupplicate Form : Phaiboon.  [A58-0496] D. 20/01/2016                */

/* Program By  : Manop G.    [A59-0531]     26/10/2016                  */
/*              Export Report Tax  For Producer "A0M1050"               */

/* ***************************  Definitions  ************************** */
/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

DEF VAR nv_acno   AS CHAR INIT "".
DEF VAR nv_ityp   AS CHAR INIT "".
DEF VAR nv_fdat   AS DATE INIT ?.
DEF VAR nv_tdat   AS DATE INIT ?.
DEF VAR nv_polno  AS CHAR INIT "".
DEF VAR nv_prev   AS CHAR INIT "".
DEF VAR nv_fcedp  AS CHAR INIT "".
DEF VAR nv_cedp   AS CHAR INIT "".
DEF VAR nv_docty  AS CHAR INIT "".
DEF VAR nv_chano  AS CHAR INIT "".
DEF VAR nv_name   AS CHAR INIT "".
DEF VAR nv_fname  AS CHAR INIT "".
DEF VAR nv_lname  AS CHAR INIT "".
DEF VAR nv_lochk  AS LOGICAL INIT NO.

DEF VAR nv_net    AS DECI INIT 0 FORMAT ">,>>>,>>9.99".
DEF VAR nv_stp    AS DECI INIT 0 FORMAT ">,>>>,>>9.99".
DEF VAR nv_vat    AS DECI INIT 0 FORMAT ">,>>>,>>9.99".
DEF VAR nv_grand  AS DECI INIT 0.
DEF VAR nv_tname  AS CHAR INIT "".
DEF VAR nv_invo   AS CHAR INIT "".
DEF VAR nv_entdat AS DATE INIT ?.
DEF VAR nv_brins  AS CHAR INIT "".
DEF VAR nv_chk    AS CHAR INIT "".
DEF VAR nv_num    AS INT.
DEF VAR n_acno    AS CHAR.
DEF BUFFER buwm100 FOR uwm100.
DEF TEMP-TABLE tacno
    FIELD acno AS CHAR.

DEF VAR nv_cnet    AS CHAR.
DEF VAR nv_cstp    AS CHAR.
DEF VAR nv_cvat    AS CHAR.
DEF VAR nv_cgrand  AS CHAR.
DEF VAR nv_centdat AS CHAR.
DEF VAR nv_output  AS CHAR INIT "".
DEF VAR nv_output1 AS CHAR INIT "".
DEF VAR nv_output2 AS CHAR INIT "".
DEF STREAM ns1.
DEF STREAM ns2.

DEF VAR nv_comdat  AS CHAR INIT "".
DEF VAR nv_expdat  AS CHAR INIT "".
DEF VAR nv_agrdat  AS CHAR INIT "".
DEF VAR nv_agent   AS CHAR INIT "".
                            
def var nv_bookl       as char  init "".           
def var nv_branch      as char  init "".
def var nv_code        as char  init "".
def var nv_safety      as char  init "".
def var nv_adnum       as char  init "" .
def var nv_adbuil      as char  init "" .
def var nv_admoo       as char  init "" .
def var nv_adroad      as char  init "" .
def var nv_adtambon    as char  init "" .
def var nv_adamphur    as char  init "" .
def var nv_adCountry   as char  init "" .
def var nv_postcode    as char  init "" .
def var nv_covtype     as char  init "" .
DEF var nv_sumsi       as char  init "" .
def var nv_prem        as char  init "" .
def var nv_total       as char  init "" .
DEF VAR n_printbr       AS CHAR FORMAT "X(30)".
DEF VAR n_uom6          AS DECI INIT 0 FORMAT ">,>>>,>>9.99".  
DEF VAR n_uom7          AS DECI INIT 0 FORMAT ">,>>>,>>9.99".


def var nv_addv1        as char  init "" .
def var nv_addv2        as char  init "" .
DEF VAR nv_chek         AS CHAR  INIT "".
DEF VAR nv_chek2        AS INT  INIT 0.
DEF VAR nv_postcd       AS CHAR INIT "".
DEF VAR nv_prov         AS CHAR INIT "".

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS ra_acno fi_acno fi_from fi_to fi_output ~
bu_export bu_cancel RECT-2 RECT-3 
&Scoped-Define DISPLAYED-OBJECTS fi_acdes se_acno fi_acno fi_from fi_to ~
fi_output 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_cancel 
     LABEL "Cancel" 
     SIZE 15 BY 1.14.

DEFINE BUTTON bu_export 
     LABEL "Export" 
     SIZE 15 BY 1.14.

DEFINE VARIABLE fi_acdes AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 26 BY 1
     BGCOLOR 8 FGCOLOR 4 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_acno AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 34.83 BY 1
     BGCOLOR 15 FGCOLOR 4 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_from AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_group AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 17.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_output AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 37.67 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_to AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE ra_acno AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Default", 1,
"By Account", 2,
"By Group", 3
     SIZE 37.67 BY 1.24
     BGCOLOR 8  NO-UNDO.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 85 BY 14.29
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 85 BY 3.33
     BGCOLOR 8 .

DEFINE VARIABLE se_acno AS CHARACTER 
     VIEW-AS SELECTION-LIST MULTIPLE SCROLLBAR-VERTICAL 
     SIZE 26.5 BY 4.05
     BGCOLOR 8 FONT 2 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_acdes AT ROW 11.76 COL 56.67 COLON-ALIGNED NO-LABEL 
     ra_acno AT ROW 5.95 COL 23.67 NO-LABEL
     fi_group AT ROW 6 COL 61.17 COLON-ALIGNED NO-LABEL
     se_acno AT ROW 7.29 COL 23.33 NO-LABEL
     fi_acno AT ROW 11.81 COL 20.17 COLON-ALIGNED NO-LABEL
     fi_from AT ROW 13.52 COL 19.83 COLON-ALIGNED NO-LABEL
     fi_to AT ROW 13.48 COL 43.33 COLON-ALIGNED NO-LABEL
     fi_output AT ROW 15.24 COL 19.83 COLON-ALIGNED NO-LABEL
     bu_export AT ROW 16.67 COL 21.83
     bu_cancel AT ROW 16.67 COL 40.33
     "From :" VIEW-AS TEXT
          SIZE 6.33 BY .62 AT ROW 13.76 COL 13.83
          BGCOLOR 8 FONT 6
     "To :" VIEW-AS TEXT
          SIZE 4.83 BY .62 AT ROW 13.76 COL 39
          BGCOLOR 8 FONT 6
     "Output :" VIEW-AS TEXT
          SIZE 8.5 BY .62 AT ROW 15.33 COL 12
          BGCOLOR 8 FONT 6
     "Account No. :" VIEW-AS TEXT
          SIZE 14 BY .62 AT ROW 6.29 COL 8.17
          BGCOLOR 8 FONT 6
     "Export Kiatnakin Bank Public Company" VIEW-AS TEXT
          SIZE 37.5 BY 1.67 AT ROW 3 COL 27.17
          BGCOLOR 8 FGCOLOR 12 FONT 6
     RECT-2 AT ROW 5.52 COL 4.5
     RECT-3 AT ROW 2.19 COL 4.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 92.33 BY 19.81
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
         TITLE              = "<insert window title>"
         HEIGHT             = 19.81
         WIDTH              = 92.33
         MAX-HEIGHT         = 45.76
         MAX-WIDTH          = 213.33
         VIRTUAL-HEIGHT     = 45.76
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
IF NOT C-Win:LOAD-ICON("Wimage\safety":U) THEN
    MESSAGE "Unable to load icon: Wimage\safety"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fr_main
   FRAME-NAME Custom                                                    */
/* SETTINGS FOR FILL-IN fi_acdes IN FRAME fr_main
   NO-ENABLE                                                            */
ASSIGN 
       fi_acdes:READ-ONLY IN FRAME fr_main        = TRUE.

/* SETTINGS FOR FILL-IN fi_group IN FRAME fr_main
   NO-DISPLAY NO-ENABLE                                                 */
ASSIGN 
       fi_group:HIDDEN IN FRAME fr_main           = TRUE.

/* SETTINGS FOR RADIO-SET ra_acno IN FRAME fr_main
   NO-DISPLAY                                                           */
/* SETTINGS FOR SELECTION-LIST se_acno IN FRAME fr_main
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


&Scoped-define SELF-NAME bu_cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_cancel C-Win
ON CHOOSE OF bu_cancel IN FRAME fr_main /* Cancel */
DO:
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_export
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_export C-Win
ON CHOOSE OF bu_export IN FRAME fr_main /* Export */
DO:        
    ASSIGN
        nv_acno   = fi_acno
        nv_fdat   = fi_from
        nv_tdat   = fi_to
        nv_output = fi_output.

    IF nv_acno = "" THEN DO:
        MESSAGE "Account No Data !" VIEW-AS ALERT-BOX ERROR.
        RETURN NO-APPLY.
    END.


    MESSAGE "Account No.  : "           nv_acno SKIP(1)
            "From               : "     STRING(nv_fdat,"99/99/9999") SKIP(1)
            "To                    : "  STRING(nv_tdat,"99/99/9999") SKIP(1)
            "Output            : "      nv_output
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
        TITLE "Confirm" UPDATE choice AS LOGICAL.
    CASE choice:
        WHEN TRUE  THEN RUN pd_report.
        WHEN FALSE THEN RETURN NO-APPLY.
    END CASE.                                   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_acdes
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_acdes C-Win
ON LEAVE OF fi_acdes IN FRAME fr_main
DO:
  fi_acdes = INPUT fi_acdes .
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_acno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_acno C-Win
ON LEAVE OF fi_acno IN FRAME fr_main
DO:
    fi_acno = INPUT fi_acno.
    fi_acno = CAPS(fi_acno).
    IF fi_acno <> ""  THEN DO:
        FIND FIRST xmm600  WHERE 
                   xmm600.acno  =  fi_acno NO-LOCK NO-ERROR.
        IF AVAIL xmm600 THEN DO:
            ASSIGN fi_acdes  = xmm600.ntitle + xmm600.NAME.
        END.
    END.

    DISP fi_acno  fi_acdes  WITH FRAME fr_main.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_from
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_from C-Win
ON LEAVE OF fi_from IN FRAME fr_main
DO:
  fi_from = INPUT fi_from.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_from C-Win
ON RETURN OF fi_from IN FRAME fr_main
DO:
  fi_from = INPUT fi_from.
  fi_to   = INPUT fi_to.

  IF fi_from > fi_to THEN DO:
      MESSAGE "Mandatory to From Date" VIEW-AS ALERT-BOX.
      APPLY "Entry" TO fi_from.
      RETURN NO-APPLY.
  END.

  IF fi_from < fi_to THEN DO:
      fi_output = "C:\temp\TAX" + "KK" + "_" + STRING(DAY(fi_from),"99") + STRING(MONTH(fi_from), "99") + STRING(YEAR(fi_from), "9999") + "-" + 
                                                 STRING(DAY(fi_to),"99") + STRING(MONTH(fi_to), "99") + STRING(YEAR(fi_to), "9999").
      DISP fi_output WITH FRAME fr_main.
  END.
  ELSE DO:
      fi_output = "C:\temp\TAX" + "KK" + "_" + STRING(DAY(TODAY), "99") + STRING(MONTH(TODAY), "99") + STRING(YEAR(TODAY), "9999").
      DISP fi_output WITH FRAME fr_main.
  END.

  
  APPLY "Entry" TO fi_to.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_group
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_group C-Win
ON RETURN OF fi_group IN FRAME fr_main
DO:
    fi_group = INPUT fi_group.

    IF fi_group = "" THEN DO:
        MESSAGE "Account group no Data !" VIEW-AS ALERT-BOX ERROR.
        RETURN NO-APPLY.
    END.
    ELSE IF fi_group <> "" THEN DO:
        FIND FIRST xmm600 WHERE xmm600.gpstmt = fi_group NO-LOCK NO-ERROR.
        IF AVAIL xmm600 THEN DO:
            FOR EACH xmm600 WHERE xmm600.gpstmt = fi_group NO-LOCK.
                nv_acno = nv_acno + xmm600.acno + ",".
            END.
            se_acno:LIST-ITEMS = SUBSTR(nv_acno,1,LENGTH(nv_acno) - 1).
            nv_acno = "".
        END.
        ELSE DO:
            MESSAGE "Not found Account Group !" VIEW-AS ALERT-BOX ERROR.
        END.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_output
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_output C-Win
ON LEAVE OF fi_output IN FRAME fr_main
DO:
  fi_output = INPUT fi_output.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_output C-Win
ON RETURN OF fi_output IN FRAME fr_main
DO:
  fi_output = INPUT fi_output.
  APPLY "Entry" TO bu_export.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_to
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_to C-Win
ON LEAVE OF fi_to IN FRAME fr_main
DO:
  fi_to = INPUT fi_to.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_to C-Win
ON RETURN OF fi_to IN FRAME fr_main
DO:
  fi_from = INPUT fi_from.
  fi_to = INPUT fi_to.

  IF fi_to < fi_from THEN DO:
      MESSAGE "Mandatory to From Date" VIEW-AS ALERT-BOX.
      APPLY "Entry" TO fi_from.
      RETURN NO-APPLY.
  END.


  IF fi_from < fi_to THEN DO:
      fi_output = "C:\temp\TAX" + "KK" + "_" + STRING(DAY(fi_from),"99") + STRING(MONTH(fi_from), "99") + STRING(YEAR(fi_from), "9999") + "-" + 
                                                 STRING(DAY(fi_to),"99") + STRING(MONTH(fi_to), "99") + STRING(YEAR(fi_to), "9999").
      DISP fi_output WITH FRAME fr_main.
  END.
  ELSE DO:
      fi_output = "C:\temp\TAX" + "KK" + "_" + STRING(DAY(TODAY), "99") + STRING(MONTH(TODAY), "99") + STRING(YEAR(TODAY), "9999").
      DISP fi_output WITH FRAME fr_main.
  END.

  APPLY "Entry" TO fi_output.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_acno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_acno C-Win
ON RETURN OF ra_acno IN FRAME fr_main
DO:
    APPLY "Entry" TO fi_from.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_acno C-Win
ON VALUE-CHANGED OF ra_acno IN FRAME fr_main
DO:
    ra_acno = INPUT ra_acno.

    IF ra_acno = 1 THEN DO:
        fi_acno = "A0M1050".
        DISABLE se_acno fi_group WITH FRAME fr_main.
        DISP fi_acno WITH FRAME fr_main.
    END.
    ELSE IF ra_acno = 2 THEN DO:
        fi_acno = "".

        FOR EACH xmm600 WHERE xmm600.gpstmt = "A0M1050" NO-LOCK.
            nv_acno = nv_acno + xmm600.acno + ",".         
        END.

        se_acno:LIST-ITEMS = SUBSTR(nv_acno,1,LENGTH(nv_acno) - 1).
        nv_acno = "".

        ENABLE se_acno WITH FRAME fr_main.
        DISABLE fi_group WITH FRAME fr_main.
        DISP fi_acno WITH FRAME fr_main.
    END.
    ELSE IF ra_acno = 3 THEN DO:
        fi_acno = "".     
        se_acno:LIST-ITEMS = "".
        ENABLE fi_group se_acno WITH FRAME fr_main.
        DISP fi_acno fi_group se_acno WITH FRAME fr_main.
    
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME se_acno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL se_acno C-Win
ON VALUE-CHANGED OF se_acno IN FRAME fr_main
DO:    
    fi_acno = INPUT se_acno.
    DISP fi_acno WITH FRAME fr_main.
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
  DEF  VAR  gv_prgid   AS   CHAR  FORMAT "X(8)"   NO-UNDO.
  DEF  VAR  gv_prog    AS   CHAR  FORMAT "X(40)" NO-UNDO.
  
  gv_prgid = "wacktn01.w".
  gv_prog  = "Report Kiatnakin Bank".
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).

/*********************************************************************/  
RUN  WUT\WUTWICEN (c-win:handle).  
  Session:data-Entry-Return = Yes.

  ASSIGN     
      fi_acno   = "A0M1050"
      fi_from   = TODAY  
      fi_to     = TODAY  
      fi_output = "C:\temp\TAX" + "KK" + "_" + STRING(DAY(TODAY), "99") + STRING(MONTH(TODAY), "99") + STRING(YEAR(TODAY), "9999").
      
 /* co_acno:LIST-ITEMS = "B3M0003" + "," + "B3M0032" + "," + "B3M0029". */
     
 /* FIND FIRST xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = "B3M0003" NO-LOCK NO-ERROR.
  IF AVAIL xmm600 THEN fi_acdes = xmm600.NAME.*/

  DISP fi_acno fi_from fi_to fi_output  WITH FRAME fr_main.
 
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
  DISPLAY fi_acdes se_acno fi_acno fi_from fi_to fi_output 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE ra_acno fi_acno fi_from fi_to fi_output bu_export bu_cancel RECT-2 
         RECT-3 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_province C-Win 
PROCEDURE pd_province :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/


    IF INDEX(nv_chek,"อยุธยา") <> 0 THEN nv_prov = "พระนครศรีอยุธยา".
    ELSE IF INDEX(nv_chek,"กรุงเทพ") <> 0 THEN nv_prov = "กรุงเทพมหานคร".
    ELSE DO:
        FIND FIRST uwm500 USE-INDEX uwm50002 WHERE
           uwm500.prov_d = nv_chk NO-LOCK NO-ERROR.
        IF AVAIL uwm500 THEN DO:
                 nv_prov = uwm500.prov_d.
        END.
        /*ELSE nv_prov = nv_chek .*/
        /*-
        ELSE DO:
             IF INDEX(nv_chk,uwm500.prov_d) <> 0  THEN
                nv_prov = uwm500.prov_d.
        END.
        -*/

    END.
        
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_report C-Win 
PROCEDURE pd_report :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

IF R-INDEX(nv_output, ".") <> 0 THEN DO:
    nv_output1 = TRIM(SUBSTR(nv_output, 1, R-INDEX(nv_output, ".") - 1)) + ".txt".
    nv_output2 = TRIM(SUBSTR(nv_output, 1, R-INDEX(nv_output, ".") - 1)) + ".slk".
END.
ELSE DO:
    nv_output1 = nv_output + ".txt".
    nv_output2 = nv_output + ".slk".
END.

/* Begin by Phaiboon W. [A59-0161] 05/05/2016 */
REPEAT:
    nv_num = INDEX(nv_acno,",").
    IF nv_num <> 0 THEN DO:
        n_acno = SUBSTR(nv_acno,1,INDEX(nv_acno,",") - 1).
        FIND FIRST tacno WHERE tacno.acno = n_acno NO-LOCK NO-ERROR.
        IF NOT AVAIL tacno THEN DO:
            CREATE tacno.
            tacno.acno = n_acno.
        END.

        nv_acno = SUBSTR(nv_acno,INDEX(nv_acno,",") + 1,LENGTH(nv_acno)).
    END.
    ELSE DO:
        n_acno = SUBSTR(nv_acno,1,INDEX(nv_acno,",") - 1).
        FIND FIRST tacno WHERE tacno.acno = n_acno NO-LOCK NO-ERROR.
        IF NOT AVAIL tacno THEN DO:
            CREATE tacno.
            tacno.acno = n_acno.
        END.
        LEAVE.
    END.    /* Else Do */
END.        /* End Repeat */
/* End by Phaiboon W. [A59-0161] 05/05/2016 */

        
OUTPUT STREAM ns1 TO VALUE(nv_output1).
OUTPUT STREAM ns2 TO VALUE(nv_output2).

PUT STREAM ns2
    "วันBOOK LOAN|"
    "เลขที่สัญญา|"
    "สาขา|"
    "ชื่อ - สกุล(ลูกค้า)|"
    "CODE |"
    "บริษัทประกัน |"
    "รหัสบัญชีสาขา(ภ.พ.20)|"
    "ที่อยู่เลขที่ |"
    "อาคาร |" 
    "หมู่|"
    "ถนน |"
    "ตำบล|"
    "อำเภอ|"
    "จังหวัด|"
    "รหัสไปรษณีย์|"
    "ประเภทประกัน |"
    "เลขที่กรมธรรม์|"
    "วันเริ่มคุ้มครอง|"
    "วันหมดอายุ|"
    "ทุนประกัน |"
    "เบี้ยประกันภัยสุทธิ|"
    "อากร|"
    "ภาษี|"
    "เบี้ยรวม  |"
    "ภาษีหัก ณ ที่จ่าย|"
    "รับชำระขาด/เกิน  |"
    "เบี้ยประกันภัยรับ|"      SKIP.

loop_for100:
FOR EACH vat100 USE-INDEX vat10004 WHERE
                          vat100.entdat >= nv_fdat AND
                          vat100.entdat <= nv_tdat AND
                          /*-vat100.acno    = nv_acno AND  -*/
                          vat100.rencnt  = 0       AND
                          vat100.cancel  = NO NO-LOCK:
    
    DISP vat100.policy WITH COLOR BLACK/WHITE NO-LABEL TITLE "Process data......"
                       CENTERED FRAME fr_process VIEW-AS DIALOG-BOX.


    /* Begin by Phaiboon W. [A59-0161] 05/05/2016 */
    FIND FIRST tacno WHERE tacno.acno = vat100.acno NO-LOCK NO-ERROR.
    IF NOT AVAIL tacno THEN NEXT loop_for100.
    /* End by Phaiboon W. [A59-0161] 05/05/2016 */

    /*----
    IF  INDEX(vat100.NAME, "ธนาคารเกียรติ") = 0 AND
        INDEX(vat100.NAME, "ธนาคาร เกียรติ") = 0 AND 
        INDEX(vat100.NAME, "เกียรติ") = 0 THEN DO: 

               
            FIND LAST uwm100 USE-INDEX uwm10001 WHERE uwm100.policy = vat100.policy AND
                                                      uwm100.rencnt = vat100.rencnt NO-LOCK NO-ERROR.
            IF AVAIL uwm100 THEN DO:
                nv_chk = uwm100.name1 + " " + uwm100.name2 + " " + uwm100.name3.   

                IF ((INDEX(nv_chk,"และ") <> 0 OR INDEX(nv_chk,"หรือ") <> 0) AND 
                     INDEX(nv_chk,"เกียรตินาคิน") <> 0) OR INDEX(nv_chk,"ธนาคารเกียรตินาคิน") <> 0 OR 
                     INDEX(nv_chk,"ธนาคาร เกียรตินาคิน") <> 0 OR TRIM(uwm100.bs_cd,"x(10)") = "MC0K001"  THEN DO:                    
                END.
                ELSE NEXT. /*-loop_for100.-*/
            END. 
    END.
    ELSE DO:   ---*/

        FIND LAST uwm100 USE-INDEX uwm10001 WHERE uwm100.policy = vat100.policy AND
                                                  uwm100.rencnt = vat100.rencnt AND 
                                                  uwm100.endcnt = vat100.endcnt NO-LOCK NO-ERROR.        
    
        IF AVAIL uwm100 THEN DO:
                 ASSIGN
                    nv_polno  = ""
                    nv_prev   = ""
                    nv_fcedp  = ""
                    nv_cedp   = ""
                    nv_docty  = ""
                    nv_chano  = ""
                    nv_name   = ""
                    nv_fname  = ""
                    nv_lname  = ""
                    nv_comdat = ""
                    nv_expdat = ""
                    nv_agrdat = ""
                    nv_cnet   = ""
                    nv_cstp   = ""
                    nv_cvat   = ""
                    nv_cgrand = ""
                    nv_net    = 0
                    nv_stp    = 0
                    nv_vat    = 0
                    nv_grand  = 0
                    nv_tname  = ""
                    nv_invo   = ""
                    nv_entdat = ?
                    nv_brins  = ""
                    nv_prov   = ""
                    nv_postcd = ""
                    .    
                    
    

        FIND FIRST uwm120 USE-INDEX uwm12001 WHERE uwm120.policy = uwm100.policy AND
                                                   uwm120.rencnt = uwm100.rencnt AND
                                                   uwm120.endcnt = uwm100.endcnt NO-LOCK NO-ERROR.
        IF AVAIL uwm120 THEN DO:
            nv_net = uwm120.prem_r.
            nv_stp = uwm120.rstp_r.
            IF nv_net < 0 OR nv_stp < 0 THEN NEXT loop_for100.
        END.


        FIND FIRST Xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = vat100.acno NO-LOCK NO-ERROR .
        IF AVAIL xmm600 THEN DO:

            n_printbr = " ".
            FIND FIRST xmm023 USE-INDEX xmm02301
                 WHERE xmm023.branch = vat100.branch  NO-LOCK NO-ERROR.
            IF AVAIL xmm023 THEN DO:
               IF xmm023.branch = "0" OR
                  xmm023.branch = "L" OR
                  xmm023.branch = "M" OR
                  xmm023.branch = "V" OR
                  xmm023.branch = "W" OR 
                  xmm023.branch = "Y" OR 
                  xmm023.branch = "19"  THEN DO: n_printbr = "สำนักงานใหญ่" .
               END.
               ELSE DO:
                   IF LENGTH(xmm023.branch) = 1 THEN DO:
                      FIND LAST xmm600 USE-INDEX xmm60001
                           WHERE SUBSTRING(xmm600.acno,1,5) = "ZZZ" + "0" + xmm023.branch  NO-LOCK NO-ERROR.
                      IF AVAIL xmm600 THEN  n_printbr = xmm600.NAME.
                   END.
                   ELSE DO:
                       FIND LAST xmm600 USE-INDEX xmm60001
                         WHERE SUBSTRING(xmm600.acno,1,5) = "ZZZ" + xmm023.branch  NO-LOCK NO-ERROR.
                       IF AVAIL xmm600 THEN DO:  
                           n_printbr = xmm600.NAME.
                       END.
                       ELSE
                           n_printbr = "สาขาที่"  + " " + "00053". /* กรณีสาขาเพชรบุรีตัดใหม่ 91 - 98 (ZZZ9000053)*/
                   END.
               END.
            END.

            /*------------Province จังหวัด-----------*/
            nv_addv1 = trim(TRIM(vat100.add1) + " " + TRIM(vat100.add2)).
            IF INDEX(nv_addv1," ") <> 0 THEN DO:
            
                nv_chek = TRIM(SUBSTR(nv_addv1,R-INDEX(nv_addv1," ") + 1)).
                nv_chek2 = INT(nv_chek) NO-ERROR.
            
                
                IF LENGTH(nv_chek) = 5 AND nv_chek2 <> 0 THEN DO:
                    nv_postcd = nv_chek.
                END.
                ELSE DO:
                    RUN pd_province.  
                END.
                
                IF nv_postcd <> "" THEN DO:
                    nv_chek = trim(SUBSTR(nv_addv1,1,R-INDEX(nv_addv1," ") - 1)).
            
                    IF INDEX(nv_chek," ") <> 0 THEN DO:
                        nv_chek = TRIM(SUBSTR(nv_chek,R-INDEX(nv_chek," ") + 1)).
                        RUN pd_province.
                    END.
            
                END.
            END.
            /*------------Province จังหวัด-----------*/

        

     /*  IF uwm100.rencnt <> 0 THEN DO:
            nv_prev = uwm100.prvpol.
            loop_fpolicy:
            REPEAT:
                FIND FIRST buwm100 USE-INDEX uwm10001 WHERE buwm100.policy = nv_prev NO-LOCK NO-ERROR.
                IF AVAIL buwm100 THEN DO:
                    IF buwm100.rencnt > 0 THEN DO:
                        nv_prev = uwm100.prvpol.
                        NEXT loop_fpolicy.
                    END.
                    ELSE DO:
                        nv_fcedp = buwm100.cedpol.
                        LEAVE loop_fpolicy.
                    END.
                END.
                ELSE DO:
                    nv_fcedp = "".
                    LEAVE loop_fpolicy.
                END.
            END.
        END.  */
                
        FIND LAST buwm100 USE-INDEX uwm10001 WHERE buwm100.policy = uwm100.policy NO-LOCK NO-ERROR.
        IF AVAIL buwm100 THEN DO:
             FIND FIRST xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = buwm100.insref NO-LOCK NO-ERROR.
                IF AVAIL xmm600 THEN DO:
                    nv_name = TRIM(xmm600.name).
                    IF INDEX(nv_name," ") <> 0 THEN DO:
                        ASSIGN
                            nv_fname = SUBSTR(nv_name,1,R-INDEX(nv_name," "))
                            nv_lname = SUBSTR(nv_name,R-INDEX(nv_name," ")).
                    END.
                    ELSE nv_fname = nv_name.
                        ASSIGN 
                            nv_fname = TRIM(nv_fname)
                            nv_lname = TRIM(nv_lname).
                            
                    
                        IF      INDEX(nv_fname,"คุณ") = 1 THEN nv_fname = SUBSTR(nv_fname,4).
                        ELSE IF INDEX(nv_fname,"นาย") = 1 THEN nv_fname = SUBSTR(nv_fname,4).            
                        nv_fname = TRIM(nv_fname).
                    END.
                END.

        FIND FIRST uwm301 USE-INDEX uwm30101 WHERE uwm301.policy = uwm100.policy AND
                                                   uwm301.rencnt = uwm100.rencnt NO-LOCK NO-ERROR.
        IF AVAIL uwm301 THEN DO:    
           FIND LAST uwm130 USE-INDEX uwm13001 WHERE                                                 
                  uwm130.policy = uwm100.policy AND                                                      
                  uwm130.rencnt = uwm100.rencnt AND                                                  
                  uwm130.endcnt = uwm100.endcnt NO-LOCK NO-ERROR.                                    
           IF AVAIL uwm130 THEN DO:                                                                  
             ASSIGN n_uom6         = uwm130.uom6_v                                                   
                    n_uom7         = uwm130.uom7_v.                                                  
           END.                      
          
           FIND sym100 USE-INDEX sym10001 WHERE
            sym100.tabcod = "u013"    AND
            sym100.itmcod = uwm301.covcod  NO-LOCK NO-ERROR.
           IF NOT AVAIL sym100 THEN NEXT.

            ASSIGN
            nv_bookl          =      STRING(vat100.entdat,"99/99/9999")
            nv_cedp           =      uwm100.cedpol              
            nv_branch         =      n_printbr               
            nv_fname          =      nv_fname   /*vat100.NAME   /*-nv_fname-*/*/
            nv_code           =      "B02"            
            nv_brins          =      "'" + TRIM(SUBSTR(vat100.taxno,20,5))   /*- TRIM(SUBSTRING(xmm600.anlyc1,20,5)) -*/
            nv_adnum          =      vat100.add1           /*       TRIM(SUBSTR(xmm600.naddr1,1,(index(xmm600.naddr1," "))))    */          
            nv_adbuil         =      vat100.add2           /*       xmm600.naddr1                                               */         
            nv_admoo          =      ""                    /*       xmm600.naddr2    */ 
            nv_adroad         =      ""                    /*       xmm600.naddr3    */ 
            nv_adtambon       =      ""                    /*       xmm600.naddr4    */ 
            nv_adamphur       =      ""                    /*       xmm600.naddr1    */
            nv_adCountry      =      nv_prov               /*       xmm600.naddr1    */  
            nv_covtype        =      sym100.itmdes                                                              
            nv_polno          =      vat100.policy               
            nv_comdat         =      STRING(uwm100.comdat,"99/99/9999")                    
            nv_expdat         =      STRING(uwm100.expdat,"99/99/9999")                    
            nv_sumsi          =      STRING(n_uom6,">>>,>>>,>>9.99")                 
            nv_prem           =      STRING(uwm100.prem_t,">>>,>>>,>>9.99")                    
            nv_cstp           =      STRING(uwm100.rstp_t,">>>,>>>,>>9.99")                    
            nv_cvat           =      STRING(uwm100.rtax_t,">>>,>>>,>>9.99")   
            nv_postcode       =      nv_postcd                     
            nv_total          =      STRING(vat100.grandamt,">>>,>>>,>>9.99")     

            nv_chano   = uwm301.cha_no
            nv_lochk   = YES     .
           
            /*---
            nv_fcedp   = nv_fcedp
            /*-nv_cedp    = FILL("0", 10 - LENGTH(nv_cedp)) + nv_cedp
            nv_fcedp   = FILL("0", 10 - LENGTH(nv_fcedp)) + nv_fcedp     -*/
            nv_cnet    = TRIM(STRING(nv_net,">>,>>>,>>>,>>9.99"))
            nv_cstp    = TRIM(STRING(nv_stp,">>,>>>,>>>,>>9.99"))
            nv_cvat    = TRIM(STRING(nv_vat,">>,>>>,>>>,>>9.99"))
            nv_cgrand  = TRIM(STRING(nv_grand,">>,>>>,>>>,>>9.99"))
            /*-nv_cnet    = REPLACE(nv_cnet  ,".","")
            nv_cstp    = REPLACE(nv_cstp  ,".","")
            nv_cvat    = REPLACE(nv_cvat  ,".","")
            nv_cgrand  = REPLACE(nv_cgrand,".","")
            nv_cnet    = FILL("0",11 - LENGTH(nv_cnet)) + nv_cnet
            nv_cstp    = FILL("0",9  - LENGTH(nv_cstp)) + nv_cstp
            nv_cvat    = FILL("0",11 - LENGTH(nv_cvat)) + nv_cvat
            nv_cgrand  = FILL("0",11 - LENGTH(nv_cgrand)) + nv_cgrand--*/
            nv_centdat = STRING(nv_entdat,"99/99/9999")
            /*-nv_centdat = REPLACE(nv_centdat,"/","")-*/
            nv_cnet    = TRIM(nv_cnet)
            nv_cstp    = TRIM(nv_cstp)
            nv_cvat    = TRIM(nv_cvat)
            nv_cgrand  = TRIM(nv_cgrand)
            nv_centdat = TRIM(nv_centdat)
            .---*/
            
            IF nv_cedp      = "" THEN nv_cedp           = " ".      
            IF nv_fname     = "" THEN nv_fname          = " ".
            IF nv_lname     = "" THEN nv_lname          = " ".
            IF nv_brins     = "" THEN nv_brins          = " ".  
            IF nv_adnum     = "" THEN nv_adnum          = " ".  
            IF nv_adbuil    = "" THEN nv_adbuil         = " ".  
            IF nv_admoo     = "" THEN nv_admoo          = " ".  
            IF nv_adroad    = "" THEN nv_adroad         = " ".  
            IF nv_adtambon  = "" THEN nv_adtambon       = " ".  
            IF nv_adamphur  = "" THEN nv_adamphur       = " ".  
            IF nv_adCountry = "" THEN nv_adCountry      = " ".  
            IF nv_postcode  = "" THEN nv_postcode       = " ".  
            IF nv_covtype   = "" THEN nv_covtype        = " ".  
            IF nv_polno     = "" THEN nv_polno          = " ".  
            IF nv_comdat    = "" THEN nv_comdat         = " ".  
            IF nv_expdat    = "" THEN nv_expdat         = " ".  
            IF nv_sumsi     = "" THEN nv_sumsi          = " ".  
            IF nv_prem      = "" THEN nv_prem           = " ".  
            IF nv_cstp      = "" THEN nv_cstp           = " ".  
            IF nv_cvat      = "" THEN nv_cvat           = " ".  
            IF nv_total     = "" THEN nv_total          = " ".  
            IF nv_branch    = "" THEN nv_branch         = " ".
                       
        PUT STREAM ns1 

          nv_bookl          FORMAT "X(10)"     + "|"     
          nv_cedp           FORMAT "X(20)"     + "|"     
          nv_branch         FORMAT "X(20)"     + "|"     
          nv_fname          FORMAT "X(50)"     + "|"     
          nv_code           FORMAT "X(10)"     + "|"  
          "บริษัท ประกันคุ้มภัย จำกัด(มหาชน)" FORMAT "X(40)" + "|"
          nv_brins          FORMAT "X(8)"      + "|"     
          nv_adnum          FORMAT "X(50)"     + "|"     
          nv_adbuil         FORMAT "X(50)"     + "|"     
          nv_admoo          FORMAT "X(50)"     + "|"     
          nv_adroad         FORMAT "X(50)"     + "|"     
          nv_adtambon       FORMAT "X(50)"     + "|"     
          nv_adamphur       FORMAT "X(50)"     + "|"     
          nv_adCountry      FORMAT "X(50)"     + "|"     
          nv_postcode       FORMAT "X(30)"     + "|"     
          nv_covtype        FORMAT "X(30)"     + "|"     
          nv_polno          FORMAT "X(20)"     + "|"     
          nv_comdat         FORMAT "X(15)"     + "|"     
          nv_expdat         FORMAT "X(15)"     + "|"     
          nv_sumsi          FORMAT "X(15)"     + "|"     
          nv_prem           FORMAT "X(15)"     + "|"     
          nv_cstp           FORMAT "X(15)"     + "|"     
          nv_cvat           FORMAT "X(15)"     + "|"     
          nv_total          FORMAT "X(15)"     + "|"     
          SKIP.

        PUT STREAM ns2

          nv_bookl         FORMAT "X(10)"       + "|"      
          nv_cedp          FORMAT "X(20)"       + "|"      
          nv_branch        FORMAT "X(20)"       + "|"      
          nv_fname         FORMAT "X(50)"       + "|"      
          nv_code          FORMAT "X(10)"       + "|"   
          "บริษัท ประกันคุ้มภัย จำกัด(มหาชน)" FORMAT "X(40)"  + "|"
          nv_brins         FORMAT "X(8)"        + "|"      
          nv_adnum         FORMAT "X(50)"       + "|"      
          nv_adbuil        FORMAT "X(50)"       + "|"      
          nv_admoo         FORMAT "X(50)"       + "|"      
          nv_adroad        FORMAT "X(50)"       + "|"      
          nv_adtambon      FORMAT "X(50)"       + "|"      
          nv_adamphur      FORMAT "X(50)"       + "|"      
          nv_adCountry     FORMAT "X(50)"       + "|"      
          nv_postcode      FORMAT "X(30)"       + "|"      
          nv_covtype       FORMAT "X(30)"       + "|"      
          nv_polno         FORMAT "X(20)"       + "|"      
          nv_comdat        FORMAT "X(15)"       + "|"      
          nv_expdat        FORMAT "X(15)"       + "|"      
          nv_sumsi         FORMAT "X(15)"       + "|"      
          nv_prem          FORMAT "X(15)"       + "|"      
          nv_cstp          FORMAT "X(15)"       + "|"      
          nv_cvat          FORMAT "X(15)"       + "|"      
          nv_total         FORMAT "X(15)"       + "|"      
          SKIP.   
          .  
        /* END.   xmm023 */
        END. /*-xmm600-*/
        END.  /* uwm301 */
    END.
    /*-END. else DO: -*/
END.
OUTPUT STREAM ns1 CLOSE.
OUTPUT STREAM ns2 CLOSE.
IF nv_lochk = NO THEN MESSAGE "No Data" VIEW-AS ALERT-BOX INFORMATION.
ELSE MESSAGE "Complete" VIEW-AS ALERT-BOX.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

