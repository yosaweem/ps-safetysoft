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

  Created By: Lukkana M.  Date : 20/10/2010
  Assign  No: A53-0335  
/*----------------------------------------------------------------------*/  
/*  Modify By: Suppamas D. Date 03/06/2013 [A56-0194]                   */
/*             เพิ่ม cloumn Retention                                   */
------------------------------------------------------------------------*/
/* Modify By : Benjaporn J. A60-0267 date 27/06/2017           
             : เปลี่ยน format docno จาก 7 หลักเป็น 10 หลัก              */
/*----------------------------------------------------------------------*/             
/*          This .W file was created with the Progress AppBuilder.      */
/*----------------------------------------------------------------------*/
/* Modify By : kirtsadang P. (A61-0277) 14/06/2018
                 เพิ่ม coloum  Product Code และ Campaign */


/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */

CREATE WIDGET-POOL.

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */


DEF VAR     nv_select       AS  INTE.
DEF VAR     nv_acno_fr      AS  CHAR.
DEF VAR     nv_acnoname_fr  AS  CHAR.
DEF VAR     nv_acno_to      AS  CHAR.
DEF VAR     nv_acnoname_to  AS  CHAR.
DEF VAR     nv_output       AS  CHAR.
DEF BUFFER  bacm001         FOR acm001.
    
DEF VAR     nv_gpstmt       AS  CHAR.
DEF VAR     nv_instot       AS  INTE.
DEF VAR     nv_co_per       AS  INTE.
DEF VAR     nv_coins        AS  LOG.
DEF VAR     nv_contra_fr    AS  DATE.
DEF VAR     nv_contra_to    AS  DATE.
DEF VAR     nv_branch_fr    AS  CHAR.
DEF VAR     nv_branch_to    AS  CHAR.
DEF VAR     nv_poltyp_fr    AS  CHAR.
DEF VAR     nv_poltyp_to    AS  CHAR.
DEF VAR     nv_new_ren      AS  CHAR.
DEF VAR     nv_rencnt       AS  INTE.
DEF VAR     nv_endcnt       AS  INTE.
DEF VAR     nv_name         AS  CHAR.
DEF VAR     nv_crper        AS  INTE.
DEF VAR     nv_crper1       AS  INTE.
DEF VAR     nv_duedat       AS  DATE.
DEF VAR     nv_settamt      AS  DECI.
DEF VAR     nv_tsettamt     AS  DECI.
DEF VAR     nv_comdat       AS  DATE.
DEF VAR     nv_effdat       AS  DATE.
DEF VAR     nv_insref       AS  CHAR.
DEF VAR     nv_dueday       AS  CHAR.
DEF VAR     nv_duedate      AS  INTE.
DEF VAR     nv_duedate1     AS  CHAR FORMAT "99/99/9999".
DEF VAR     nv_duedate2     AS  INTE.
DEF VAR     dc_duedate      AS  DATE FORMAT "99/99/9999".
DEF VAR     nv_gpstmt_name  AS  CHAR.
DEF VAR     nv_acno_name    AS  CHAR.
DEF VAR     nv_agent_name   AS  CHAR.
DEF VAR     nv_ret          AS  DECI.  /*---A56-0194  date 03/06/2013---*/
DEF VAR     nv_prod         AS  CHAR.  /* A61-0277  date 14/06/2018 */
DEF VAR     nv_camp         AS  CHAR.  /* A61-0277  date 14/06/2018 */

DEF STREAM  ns1.

DEF WORKFILE wacm001
    FIELD entdat      AS  DATE
    FIELD acno        AS  CHAR
    FIELD acno_name   AS  CHAR
    FIELD gpstmt      AS  CHAR
    FIELD gpstmt_name AS  CHAR
    FIELD agent       AS  CHAR
    FIELD agent_name  AS  CHAR 
    FIELD trndat      AS  DATE
    FIELD new_ren     AS  CHAR
    FIELD rencnt      AS  INTE  
    FIELD branch      AS  CHAR
    FIELD poltyp      AS  CHAR
    FIELD policy      AS  CHAR
    FIELD instot      AS  INTE  
    FIELD endcnt      AS  INTE
    FIELD trnty1      AS  CHAR  
    FIELD trnty2      AS  CHAR  
    FIELD docno       AS  CHAR  FORMAT "x(10)" /* A60-0267 */
    FIELD coins       AS  LOG
    FIELD co_per      AS  INTE  
    FIELD name        AS  CHAR  
    FIELD duedat      AS  DATE  
    FIELD cjodat      AS  DATE
    FIELD prem        AS  DECI
    FIELD nprem       AS  DECI
    FIELD commision   AS  DECI
    FIELD sett_amt    AS  DECI
    FIELD bal         AS  DECI
    FIELD retention   AS  DECI  /*---A56-0194  date 03/06/2013---*/
    FIELD product     AS  CHAR  /* A61-0277  date 14/06/2018 */
    FIELD campaign    AS  CHAR. /* A61-0277  date 14/06/2018 */
 
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-1 RECT-2 RECT-3 fi_contra_fr ~
fi_contra_to fi_branch_fr fi_branch_to fi_acno_fr fi_acno_to fi_poltyp_fr ~
fi_poltyp_to to_duedate rs_select fi_output bu_ok bu_exit fi_brndes_fr ~
fi_brndes_to fi_acnodes_fr fi_acnodes_to fi_poldes_fr fi_poldes_to fi_dir 
&Scoped-Define DISPLAYED-OBJECTS fi_contra_fr fi_contra_to fi_branch_fr ~
fi_branch_to fi_acno_fr fi_acno_to fi_poltyp_fr fi_poltyp_to to_duedate ~
rs_select fi_output fi_brndes_fr fi_brndes_to fi_acnodes_fr fi_acnodes_to ~
fi_poldes_fr fi_poldes_to fi_dir 

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
     SIZE 13 BY 1.52
     FONT 2.

DEFINE BUTTON bu_ok 
     LABEL "OK" 
     SIZE 13 BY 1.52
     FONT 2.

DEFINE VARIABLE fi_acnodes_fr AS CHARACTER FORMAT "X(40)":U 
      VIEW-AS TEXT 
     SIZE 39 BY .62
     BGCOLOR 3 FGCOLOR 7 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_acnodes_to AS CHARACTER FORMAT "X(40)":U 
      VIEW-AS TEXT 
     SIZE 39 BY .62
     BGCOLOR 3 FGCOLOR 7 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_acno_fr AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.

DEFINE VARIABLE fi_acno_to AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.

DEFINE VARIABLE fi_branch_fr AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY 1 NO-UNDO.

DEFINE VARIABLE fi_branch_to AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY 1 NO-UNDO.

DEFINE VARIABLE fi_brndes_fr AS CHARACTER FORMAT "X(30)":U 
      VIEW-AS TEXT 
     SIZE 37.33 BY .62
     BGCOLOR 3 FGCOLOR 7 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_brndes_to AS CHARACTER FORMAT "X(30)":U 
      VIEW-AS TEXT 
     SIZE 37.33 BY .62
     BGCOLOR 3 FGCOLOR 7 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_contra_fr AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.

DEFINE VARIABLE fi_contra_to AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.

DEFINE VARIABLE fi_dir AS CHARACTER FORMAT "X(3)":U 
      VIEW-AS TEXT 
     SIZE 7.5 BY .81
     BGCOLOR 3 FGCOLOR 7 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_output AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 33 BY 1 NO-UNDO.

DEFINE VARIABLE fi_poldes_fr AS CHARACTER FORMAT "X(40)":U 
      VIEW-AS TEXT 
     SIZE 45 BY .62
     BGCOLOR 3 FGCOLOR 7 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_poldes_to AS CHARACTER FORMAT "X(40)":U 
      VIEW-AS TEXT 
     SIZE 45 BY .62
     BGCOLOR 3 FGCOLOR 7 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_poltyp_fr AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 7.5 BY 1 NO-UNDO.

DEFINE VARIABLE fi_poltyp_to AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 7.5 BY 1 NO-UNDO.

DEFINE VARIABLE rs_select AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "1. With Credit Term", 1,
"2. Over Due", 2,
"3. No Credit Term", 3
     SIZE 39.83 BY 3
     BGCOLOR 3 FGCOLOR 7 FONT 2 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 95 BY 2.38
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 95 BY 21.33
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 3 GRAPHIC-EDGE  NO-FILL 
     SIZE 36 BY 2.29.

DEFINE VARIABLE to_duedate AS LOGICAL INITIAL no 
     LABEL "Due Date Start End Month" 
     VIEW-AS TOGGLE-BOX
     SIZE 37.83 BY .81
     BGCOLOR 3 FGCOLOR 7 FONT 2 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     fi_contra_fr AT ROW 5.38 COL 37.83 COLON-ALIGNED NO-LABEL
     fi_contra_to AT ROW 6.67 COL 37.83 COLON-ALIGNED NO-LABEL
     fi_branch_fr AT ROW 7.95 COL 37.83 COLON-ALIGNED NO-LABEL
     fi_branch_to AT ROW 9.29 COL 37.83 COLON-ALIGNED NO-LABEL
     fi_acno_fr AT ROW 10.62 COL 37.83 COLON-ALIGNED NO-LABEL
     fi_acno_to AT ROW 11.95 COL 37.83 COLON-ALIGNED NO-LABEL
     fi_poltyp_fr AT ROW 13.29 COL 37.83 COLON-ALIGNED NO-LABEL
     fi_poltyp_to AT ROW 14.57 COL 37.83 COLON-ALIGNED NO-LABEL
     to_duedate AT ROW 16.05 COL 39.67
     rs_select AT ROW 17.33 COL 39.67 NO-LABEL
     fi_output AT ROW 21.67 COL 37.83 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 23.62 COL 37.5
     bu_exit AT ROW 23.62 COL 52.17
     fi_brndes_fr AT ROW 8.1 COL 50.17 COLON-ALIGNED NO-LABEL
     fi_brndes_to AT ROW 9.43 COL 50.17 COLON-ALIGNED NO-LABEL
     fi_acnodes_fr AT ROW 10.76 COL 54 COLON-ALIGNED NO-LABEL
     fi_acnodes_to AT ROW 12.1 COL 54 COLON-ALIGNED NO-LABEL
     fi_poldes_fr AT ROW 13.52 COL 50.17 COLON-ALIGNED NO-LABEL
     fi_poldes_to AT ROW 14.76 COL 50.17 COLON-ALIGNED NO-LABEL
     fi_dir AT ROW 20.48 COL 37.83 COLON-ALIGNED NO-LABEL
     "To :" VIEW-AS TEXT
          SIZE 6 BY .91 AT ROW 14.76 COL 31
          BGCOLOR 3 FONT 2
     "To :" VIEW-AS TEXT
          SIZE 5.67 BY .91 AT ROW 9.57 COL 31.17
          BGCOLOR 3 FONT 2
     "Contra Date From :" VIEW-AS TEXT
          SIZE 24.5 BY .91 AT ROW 5.67 COL 12.67
          BGCOLOR 3 FONT 2
     "To :" VIEW-AS TEXT
          SIZE 6.17 BY .91 AT ROW 7.05 COL 31.17
          BGCOLOR 3 FONT 2
     "Branch From :" VIEW-AS TEXT
          SIZE 18 BY .91 AT ROW 8.29 COL 19.33
          BGCOLOR 3 FONT 2
     "Direct / Inward :" VIEW-AS TEXT
          SIZE 23.5 BY .91 AT ROW 20.38 COL 13.5
          BGCOLOR 3 FONT 2
     "To :" VIEW-AS TEXT
          SIZE 5.83 BY .91 AT ROW 12.24 COL 31
          BGCOLOR 3 FONT 2
     "Output To :" VIEW-AS TEXT
          SIZE 14.83 BY .91 AT ROW 21.91 COL 21.67
          BGCOLOR 3 FONT 2
     "Report Type :" VIEW-AS TEXT
          SIZE 18 BY .91 AT ROW 17.29 COL 19
          BGCOLOR 3 FONT 2
     "Account No. From :" VIEW-AS TEXT
          SIZE 24.83 BY .91 AT ROW 10.91 COL 12.5
          BGCOLOR 3 FONT 2
     "Policy Type From :" VIEW-AS TEXT
          SIZE 24.5 BY .91 AT ROW 13.52 COL 12.5
          BGCOLOR 3 FONT 2
     "Premium Settlement Report" VIEW-AS TEXT
          SIZE 37 BY 1.67 AT ROW 2.19 COL 32.83
          BGCOLOR 3 FGCOLOR 7 FONT 2
     RECT-1 AT ROW 1.71 COL 3
     RECT-2 AT ROW 4.67 COL 3
     RECT-3 AT ROW 23.19 COL 33.33
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 99.17 BY 25.67.


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
         HEIGHT             = 25.67
         WIDTH              = 99.17
         MAX-HEIGHT         = 32.48
         MAX-WIDTH          = 170.67
         VIRTUAL-HEIGHT     = 32.48
         VIRTUAL-WIDTH      = 170.67
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
IF NOT C-Win:LOAD-ICON("I:/Safety/Walp9/WIMAGE/safety.ico":U) THEN
    MESSAGE "Unable to load icon: I:/Safety/Walp9/WIMAGE/safety.ico"
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
  APPLY "CLOSE" TO THIS-PROCEDURE.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok C-Win
ON CHOOSE OF bu_ok IN FRAME DEFAULT-FRAME /* OK */
DO:

    ASSIGN
        nv_contra_fr  =  INPUT fi_contra_fr
        nv_contra_to  =  INPUT fi_contra_to
        nv_branch_fr  =  INPUT fi_branch_fr
        nv_branch_to  =  INPUT fi_branch_to
        nv_poltyp_fr  =  INPUT fi_poltyp_fr
        nv_poltyp_to  =  INPUT fi_poltyp_to
        nv_acno_fr    =  INPUT fi_acno_fr
        nv_acno_to    =  INPUT fi_acno_to.

    IF INPUT fi_branch_to = "" THEN DO:
        MESSAGE "Branch is not found ! " VIEW-AS  ALERT-BOX  
        WARNING TITLE "Confirm".
        APPLY "ENTRY" TO fi_branch_to.
        RETURN NO-APPLY.
    END.

    IF INPUT fi_acno_to = "" THEN DO:
        MESSAGE "From account no. can not empty." VIEW-AS ALERT-BOX
        WARNING TITLE "Confirm".
        APPLY "ENTRY" TO fi_acno_to.
        RETURN NO-APPLY.
    END.

    IF INPUT fi_poltyp_to = "" THEN DO:
        MESSAGE "Policy Type is not found ! " VIEW-AS  ALERT-BOX  
        WARNING TITLE "Confirm".
        APPLY "ENTRY" TO fi_poltyp_to.
        RETURN NO-APPLY.
    END.

    IF INPUT fi_output = "" THEN DO:
        MESSAGE 'Output To file Name' VIEW-AS ALERT-BOX
        WARNING TITLE "Confirm".
        APPLY "ENTRY" TO fi_output.
        RETURN NO-APPLY.
    END.

    FOR EACH wacm001.
        DELETE wacm001.
    END.

    IF TO_duedate = YES THEN DO: /*คิด duedate ตามในระบบ premium*/
        RUN pdprocess1.
    END.
    ELSE DO:
        RUN pdprocess.
    END.              
    
    RUN pdPutdata.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_acno_fr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_acno_fr C-Win
ON LEAVE OF fi_acno_fr IN FRAME DEFAULT-FRAME
DO:
  fi_acno_fr = CAPS (INPUT fi_acno_fr).

  IF fi_Acno_fr <> "" THEN DO:
      IF fi_acno_fr <> "A000000000" THEN DO:

          FIND FIRST xmm600 USE-INDEX xmm60001 WHERE xmm600.acno =  fi_Acno_fr NO-LOCK NO-ERROR.
          IF AVAIL xmm600 THEN
              ASSIGN
                 nv_acno_fr        = TRIM(fi_Acno_fr)
                 nv_acnoname_fr    = TRIM(xmm600.name)
                 fi_acnodes_fr     = TRIM(xmm600.ntitle) + " " + TRIM(xmm600.name).
          ELSE DO:
              ASSIGN 
                  fi_Acno_fr      = ""
                  fi_acnodes_fr   = ""
                  nv_acno_fr      = "" 
                  nv_acnoname_fr  = "".
              MESSAGE "Not on Name & Address Master File xmm600" VIEW-AS ALERT-BOX
              WARNING TITLE "Confirm".
          END.

      END.
      DISP fi_acno_fr fi_acnodes_fr WITH FRAME DEFAULT-FRAME.
  END.
  ELSE DO:
      MESSAGE "From account no. can not empty." VIEW-AS ALERT-BOX
      WARNING TITLE "Confirm".
      fi_acno_fr     =  "".
      fi_acnodes_fr  =  "".
      DISPLAY  fi_acno_fr  fi_acnodes_fr  WITH FRAME DEFAULT-FRAME.
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_acno_to
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_acno_to C-Win
ON LEAVE OF fi_acno_to IN FRAME DEFAULT-FRAME
DO:
  fi_acno_to = CAPS(INPUT fi_acno_to).

  IF fi_Acno_to <> "" THEN DO:

      IF fi_acno_to < fi_acno_fr THEN DO:
          MESSAGE 'Last Account No. must >= First Account No.' VIEW-AS ALERT-BOX
          WARNING TITLE "Confirm".
          APPLY "ENTRY" TO fi_acno_to.
          RETURN NO-APPLY.
      END.  

      IF fi_acno_to <> "B999999999" THEN DO:

          FIND FIRST xmm600 USE-INDEX xmm60001 WHERE xmm600.acno =  fi_Acno_to NO-LOCK NO-ERROR.
          IF AVAIL xmm600 THEN
              ASSIGN
                 nv_acno_to        = TRIM(fi_Acno_to)
                 nv_acnoname_to    = TRIM(xmm600.name)
                 fi_acnodes_to     = TRIM(xmm600.ntitle) + " " + TRIM(xmm600.name).
          ELSE DO:
              ASSIGN 
                  fi_Acno_to      = ""
                  fi_acnodes_to   = ""
                  nv_acno_to      = "" 
                  nv_acnoname_to  = "".
              MESSAGE "Not on Name & Address Master File xmm600" VIEW-AS ALERT-BOX
              WARNING TITLE "Confirm".
          END.
      END.

      DISP fi_acno_to fi_acnodes_to WITH FRAME DEFAULT-FRAME.
  END.
  ELSE DO:
      MESSAGE "From account no. can not empty." VIEW-AS ALERT-BOX
      WARNING TITLE "Confirm".
      fi_acno_to  =  "".
      fi_acnodes_to  =  "".
      DISPLAY  fi_acno_to  fi_acnodes_to  WITH FRAME DEFAULT-FRAME.
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_branch_fr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_branch_fr C-Win
ON LEAVE OF fi_branch_fr IN FRAME DEFAULT-FRAME
DO:
  fi_branch_fr = CAPS(INPUT fi_branch_fr).

  IF fi_branch_fr <> "" THEN DO:
      FIND FIRST xmm023 WHERE xmm023.branch = INPUT fi_branch_fr NO-LOCK  NO-ERROR.
      IF AVAIL xmm023 THEN DO :
          fi_brndes_fr = CAPS(xmm023.bdes).
          DISPLAY  fi_branch_fr  fi_brndes_fr WITH FRAME DEFAULT-FRAME. 
      END.
      ELSE DO:
          MESSAGE "Branch is not found ! " VIEW-AS  ALERT-BOX  
          WARNING TITLE "Confirm".
          fi_branch_fr  =  "".
          fi_brndes_fr  =  "".
          DISPLAY  fi_branch_fr  fi_brndes_fr  WITH FRAME DEFAULT-FRAME.
      END.
  END.
  ELSE DO:
      MESSAGE "Branch is not found ! " VIEW-AS  ALERT-BOX  
      WARNING TITLE "Confirm".
      fi_branch_fr  =  "".
      fi_brndes_fr  =  "".
      DISPLAY  fi_branch_fr  fi_brndes_fr  WITH FRAME DEFAULT-FRAME.

  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_branch_to
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_branch_to C-Win
ON LEAVE OF fi_branch_to IN FRAME DEFAULT-FRAME
DO:
  fi_branch_to = CAPS(INPUT fi_branch_to).

  IF fi_branch_to <> "" THEN DO:
  
      IF fi_branch_to < fi_branch_fr THEN DO:
          MESSAGE 'Last Branch must >= First Branch.' VIEW-AS ALERT-BOX
          WARNING TITLE "Confirm".
          APPLY "ENTRY" TO fi_branch_to.
          RETURN NO-APPLY.
      END.
    
      FIND FIRST xmm023 WHERE xmm023.branch = INPUT fi_branch_to NO-LOCK  NO-ERROR.
      IF AVAIL xmm023 THEN DO :
          fi_brndes_to = CAPS(xmm023.bdes).
          DISPLAY  fi_branch_to  fi_brndes_to WITH FRAME DEFAULT-FRAME. 
      END.
      ELSE DO:
          MESSAGE "Branch is not found ! " VIEW-AS  ALERT-BOX  
          WARNING TITLE "Confirm".
          fi_branch_to  =  "".
          fi_brndes_to  =  "".
          DISPLAY  fi_branch_to  fi_brndes_to  WITH FRAME DEFAULT-FRAME.
      END.
  END.
  ELSE DO:
      MESSAGE "Branch is not found ! " VIEW-AS  ALERT-BOX  
      WARNING TITLE "Confirm".
      fi_branch_to  =  "".
      fi_brndes_to  =  "".
      DISPLAY  fi_branch_to  fi_brndes_to  WITH FRAME DEFAULT-FRAME.
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_contra_fr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_contra_fr C-Win
ON LEAVE OF fi_contra_fr IN FRAME DEFAULT-FRAME
DO:
    fi_contra_fr = INPUT fi_contra_fr.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_contra_to
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_contra_to C-Win
ON LEAVE OF fi_contra_to IN FRAME DEFAULT-FRAME
DO:
    fi_contra_to = INPUT fi_contra_to.
    IF fi_contra_to < fi_contra_fr THEN DO:
        MESSAGE 'Last Date must >= First Date.' VIEW-AS ALERT-BOX
        WARNING TITLE "Confirm".
        APPLY "ENTRY" TO fi_contra_to.
        RETURN NO-APPLY.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dir C-Win
ON LEAVE OF fi_dir IN FRAME DEFAULT-FRAME
DO:
  fi_poltyp_to = CAPS(INPUT fi_poltyp_to).

  IF fi_poltyp_to <> "" THEN DO:

      IF fi_poltyp_to < fi_poltyp_fr THEN DO:
          MESSAGE "Last Policy Type must >= First Policy Type" VIEW-AS ALERT-BOX
          WARNING TITLE "Confirm".
          APPLY "ENTRY" TO fi_poltyp_to.
          RETURN NO-APPLY.
      END.

      FIND FIRST xmm031 USE-INDEX xmm03101     WHERE 
                 xmm031.poltyp = fi_poltyp_to  NO-LOCK NO-ERROR.
      IF AVAIL xmm031 THEN DO:
          fi_poldes_to = CAPS(xmm031.poldes).
          DISPLAY  fi_poltyp_to  fi_poldes_to WITH FRAME DEFAULT-FRAME. 
      END.
      ELSE DO:
          MESSAGE "Policy Type is not found ! " VIEW-AS  ALERT-BOX  
          WARNING TITLE "Confirm".
          fi_poltyp_to  =  "".
          fi_poldes_to  =  "".
          DISPLAY  fi_poltyp_to  fi_poldes_to  WITH FRAME DEFAULT-FRAME.
      END.                                                              

  END.
  ELSE DO:
      MESSAGE "Policy Type is not found ! " VIEW-AS  ALERT-BOX  
      WARNING TITLE "Confirm".
      fi_poltyp_to  =  "".
      fi_poldes_to  =  "".
      DISPLAY  fi_poltyp_to  fi_poldes_to  WITH FRAME DEFAULT-FRAME.
  END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_output
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_output C-Win
ON LEAVE OF fi_output IN FRAME DEFAULT-FRAME
DO:
  fi_output = INPUT fi_output.
  IF fi_output = "" THEN DO:
      MESSAGE 'Output To file Name' VIEW-AS ALERT-BOX
      WARNING TITLE "Confirm".
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_poltyp_fr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_poltyp_fr C-Win
ON LEAVE OF fi_poltyp_fr IN FRAME DEFAULT-FRAME
DO:
  fi_poltyp_fr = CAPS(INPUT fi_poltyp_fr).

  IF fi_poltyp_fr <> "" THEN DO:
      FIND FIRST xmm031 USE-INDEX xmm03101     WHERE 
                 xmm031.poltyp = fi_poltyp_fr  NO-LOCK NO-ERROR.
      IF AVAIL xmm031 THEN DO:
          fi_poldes_fr = CAPS(xmm031.poldes).
          DISPLAY  fi_poltyp_fr  fi_poldes_fr WITH FRAME DEFAULT-FRAME. 
      END.
      ELSE DO:
          MESSAGE "Policy Type is not found ! " VIEW-AS  ALERT-BOX  
          WARNING TITLE "Confirm".
          fi_poltyp_fr  =  "".
          fi_poldes_fr  =  "".
          DISPLAY  fi_poltyp_fr  fi_poldes_fr  WITH FRAME DEFAULT-FRAME.
      END.                                                              

  END.
  ELSE DO:
      MESSAGE "Policy Type is not found ! " VIEW-AS  ALERT-BOX  
      WARNING TITLE "Confirm".
      fi_poltyp_fr  =  "".
      fi_poldes_fr  =  "".
      DISPLAY  fi_poltyp_fr  fi_poldes_fr  WITH FRAME DEFAULT-FRAME.
  END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_poltyp_to
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_poltyp_to C-Win
ON LEAVE OF fi_poltyp_to IN FRAME DEFAULT-FRAME
DO:
  fi_poltyp_to = CAPS(INPUT fi_poltyp_to).

  IF fi_poltyp_to <> "" THEN DO:

      IF fi_poltyp_to < fi_poltyp_fr THEN DO:
          MESSAGE "Last Policy Type must >= First Policy Type" VIEW-AS ALERT-BOX
          WARNING TITLE "Confirm".
          APPLY "ENTRY" TO fi_poltyp_to.
          RETURN NO-APPLY.
      END.

      FIND FIRST xmm031 USE-INDEX xmm03101     WHERE 
                 xmm031.poltyp = fi_poltyp_to  NO-LOCK NO-ERROR.
      IF AVAIL xmm031 THEN DO:
          fi_poldes_to = CAPS(xmm031.poldes).
          DISPLAY  fi_poltyp_to  fi_poldes_to WITH FRAME DEFAULT-FRAME. 
      END.
      ELSE DO:
          MESSAGE "Policy Type is not found ! " VIEW-AS  ALERT-BOX  
          WARNING TITLE "Confirm".
          fi_poltyp_to  =  "".
          fi_poldes_to  =  "".
          DISPLAY  fi_poltyp_to  fi_poldes_to  WITH FRAME DEFAULT-FRAME.
      END.                                                              

  END.
  ELSE DO:
      MESSAGE "Policy Type is not found ! " VIEW-AS  ALERT-BOX  
      WARNING TITLE "Confirm".
      fi_poltyp_to  =  "".
      fi_poldes_to  =  "".
      DISPLAY  fi_poltyp_to  fi_poldes_to  WITH FRAME DEFAULT-FRAME.
  END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rs_select
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rs_select C-Win
ON Return OF rs_select IN FRAME DEFAULT-FRAME
DO:
  APPLY "ENTRY" TO fi_output.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rs_select C-Win
ON VALUE-CHANGED OF rs_select IN FRAME DEFAULT-FRAME
DO:
  rs_select = INPUT rs_select.

  IF INPUT rs_select = 1 THEN nv_select = 1.
  ELSE IF INPUT rs_select = 2  THEN nv_select = 2.
  ELSE IF INPUT rs_select = 3  THEN nv_select = 3.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME to_duedate
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL to_duedate C-Win
ON return OF to_duedate IN FRAME DEFAULT-FRAME /* Due Date Start End Month */
DO:
  APPLY "ENTRY" TO rs_select.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL to_duedate C-Win
ON VALUE-CHANGED OF to_duedate IN FRAME DEFAULT-FRAME /* Due Date Start End Month */
DO:
    TO_duedate = INPUT TO_duedate.
    
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
  
  gv_prgid = "WACR40".
  gv_prog  = "Premium Settlement Report".
  RUN  WUT\WUTHEAD (c-win:HANDLE,gv_prgid,gv_prog).

/*********************************************************************/  

  RUN  WUT\WUTWICEN (c-win:HANDLE).  
  SESSION:DATA-ENTRY-RETURN = YES.   

  ASSIGN
      fi_contra_fr = TODAY
      fi_contra_to = TODAY
      fi_branch_fr = '0'
      fi_branch_to = 'Z'
      fi_acno_fr   = 'a000000000'
      fi_acno_to   = 'b999999999'
      nv_select    = 1
      fi_dir       = "D"
      fi_poltyp_fr = "C90"
      fi_poltyp_to = "Z85".

  DISP fi_contra_fr fi_contra_to fi_branch_fr fi_branch_to fi_acno_fr 
       fi_acno_to fi_dir fi_poltyp_fr fi_poltyp_to WITH FRAME DEFAULT-FRAME.

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
  DISPLAY fi_contra_fr fi_contra_to fi_branch_fr fi_branch_to fi_acno_fr 
          fi_acno_to fi_poltyp_fr fi_poltyp_to to_duedate rs_select fi_output 
          fi_brndes_fr fi_brndes_to fi_acnodes_fr fi_acnodes_to fi_poldes_fr 
          fi_poldes_to fi_dir 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE RECT-1 RECT-2 RECT-3 fi_contra_fr fi_contra_to fi_branch_fr 
         fi_branch_to fi_acno_fr fi_acno_to fi_poltyp_fr fi_poltyp_to 
         to_duedate rs_select fi_output bu_ok bu_exit fi_brndes_fr fi_brndes_to 
         fi_acnodes_fr fi_acnodes_to fi_poldes_fr fi_poldes_to fi_dir 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdDuedate_C C-Win 
PROCEDURE pdDuedate_C :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF DAY(nv_effdat) >= 1 AND DAY(nv_effdat) <= 15  THEN DO:
   IF MONTH(nv_effdat) = 12 THEN DO:
      nv_duedate  =  YEAR(nv_effdat) + 1.
      nv_duedate1 = "15" + "01" +  STRING(nv_duedate,"9999").
   END.
   ELSE DO:
      nv_duedate   =  MONTH(nv_effdat) + 1.
      nv_duedate1  = "15"  +  STRING(nv_duedate,"99") + STRING(YEAR(nv_effdat),"9999").
   END.
END.
ELSE IF DAY(nv_effdat) >= 16  THEN DO:
     IF MONTH(nv_effdat)  = 12 THEN DO:
        nv_duedate  =  YEAR(nv_comdat) + 1.
        nv_duedate1 = "31" + "01" +  STRING(nv_duedate,"9999").
     END.
     ELSE DO:
        nv_duedate2 =  MONTH(nv_effdat) + 1.
        IF nv_duedate2 = 2  THEN DO:
           nv_duedate = DAY(DATE(2 + 1, 1, YEAR(nv_effdat)) - 1).
           nv_duedate1  = STRING(nv_duedate)  +  STRING(nv_duedate2,"99") + STRING(YEAR(nv_effdat),"9999").
        END.
        ELSE DO:
            IF nv_duedate2 = 1 OR nv_duedate2 = 3 OR
               nv_duedate2 = 5 OR nv_duedate2 = 7 OR
               nv_duedate2 = 8 OR nv_duedate2 = 10 OR
               nv_duedate2 = 12  THEN DO:
               ASSIGN nv_dueday = "31".
            END.
            ELSE DO:
                  IF nv_duedate2 <> 2 THEN ASSIGN nv_dueday = "30".
            END.
                
            nv_duedate1  = nv_dueday +  STRING(nv_duedate2,"99") + STRING(YEAR(nv_effdat),"9999").
        END.
     END.   /*else*/
END. 

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdDuedate_P C-Win 
PROCEDURE pdDuedate_P :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF DAY(nv_effdat) >= 1 AND DAY(nv_effdat) <= 15  THEN DO:
    IF MONTH(nv_effdat) = 2  THEN DO:    /*เดือน 2*/
         nv_duedate = DAY(DATE(2 + 1, 1, YEAR(nv_effdat)) - 1).
         nv_duedate1  = STRING(nv_duedate)  +  STRING(MONTH(nv_effdat),"99") + STRING(YEAR(nv_effdat),"9999").
    END.
    ELSE DO:    
       IF MONTH(nv_effdat) = 1 OR MONTH(nv_effdat) = 3 OR
          MONTH(nv_effdat) = 5 OR MONTH(nv_effdat) = 7 OR
          MONTH(nv_effdat) = 8 OR MONTH(nv_effdat) = 10 OR
          MONTH(nv_effdat) = 12  THEN DO:
          ASSIGN nv_dueday = "31".
       END.
       ELSE DO:
          IF MONTH(nv_effdat) <> 2 THEN ASSIGN nv_dueday = "30".
       END.
       nv_duedate1  = nv_dueday  +  STRING(MONTH(nv_effdat),"99") + STRING(YEAR(nv_effdat),"9999").
    END.
END.
ELSE IF DAY(nv_effdat) >= 16  THEN DO:
     IF MONTH(nv_effdat)  = 12 THEN DO:
         nv_duedate  =  YEAR(nv_effdat) + 1.
         nv_duedate1 = "15" + "01" +  STRING(nv_duedate,"9999").
     END.
     ELSE DO:
         nv_duedate   =  MONTH(nv_effdat) + 1.
         nv_duedate1  = "15"  +  STRING(nv_duedate,"99") + STRING(YEAR(nv_effdat),"9999").
     END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdProcess C-Win 
PROCEDURE pdProcess :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

loop_acd001:
FOR EACH acd001 USE-INDEX acd00192  NO-LOCK WHERE
         acd001.cjodat  >=  nv_contra_fr  AND
         acd001.cjodat  <=  nv_contra_to  AND
       ( acd001.ctrty1   =  "Y"           OR
         acd001.ctrty1   =  "Z"           OR
         acd001.ctrty1   =  "C"           OR
         acd001.ctrty1   =  "B" )         ,
    FIRST acm001 USE-INDEX acm00101  NO-LOCK WHERE
          acm001.trnty1   =  acd001.ctrty1  AND
          acm001.docno    =  acd001.cdocno  AND
          acm001.branch  >=  nv_branch_fr   AND
          acm001.branch  <=  nv_branch_to   AND
          acm001.trnty2   =  "P"            /*ดึงเฉพาะเบี้ยอย่างเดียว*/
        /*( acm001.trnty2   =  "P"            OR
          acm001.trnty2   =  "C"            OR
          acm001.trnty2   =  "S"            OR
          acm001.trnty2   =  "X"            OR
          acm001.trnty2   =  " "            OR
          acm001.trnty2   =  "W" )*/

    BREAK BY acm001.branch BY acd001.cjodat
          BY acm001.policy BY acm001.usrid :
    
    DISP acm001.policy WITH NO-LABEL TITLE "Process Report..."
        FRAME a1 VIEW-AS DIALOG-BOX.

    IF acd001.trnty1 = acd001.ctrty1  AND
       acd001.docno  = acd001.cdocno  THEN NEXT.
    
    IF acm001.acno   < nv_acno_fr   OR
       acm001.acno   > nv_acno_to   THEN NEXT.

    FIND bacm001 USE-INDEX acm00101     WHERE
         bacm001.trnty1  = acd001.trnty1  AND
         bacm001.docno   = acd001.docno   NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAIL bacm001 THEN NEXT.
     
    ASSIGN
        nv_gpstmt       =  ""
        nv_instot       =  0
        nv_co_per       =  0
        nv_new_ren      =  ""
        nv_rencnt       =  0
        nv_endcnt       =  0
        nv_name         =  ""
        nv_crper        =  0
        nv_duedat       =  ?
        nv_settamt      =  0
        nv_dueday       =  ""
        nv_duedate      =  0 
        nv_duedate1     =  ? 
        nv_duedate2     =  0 
        dc_duedate      =  ? 
        nv_effdat       =  ?
        nv_insref       = ""
        nv_gpstmt_name  = ""
        nv_acno_name    = ""
        nv_agent_name   = ""  
        nv_prod         = ""  /*(A61-0277) 14/06/2018*/
        nv_camp         = "". /*(A61-0277) 14/06/2018*/
      
    IF bacm001.poltyp < nv_poltyp_fr OR
       bacm001.poltyp > nv_poltyp_to THEN NEXT.

    FIND FIRST xmm600 USE-INDEX xmm60001    WHERE 
               xmm600.acno = bacm001.acno   NO-LOCK NO-ERROR.
    IF AVAIL xmm600 THEN 
        ASSIGN
           nv_gpstmt      = xmm600.gpstmt
           nv_acno_name   = TRIM(xmm600.ntitle) + TRIM(xmm600.NAME)
           nv_crper1      = xmm600.crper.

    FIND FIRST xmm600 USE-INDEX xmm60001      WHERE 
               xmm600.acno  =  bacm001.agent  NO-LOCK NO-ERROR.
    IF AVAIL xmm600 THEN DO:
        nv_agent_name  =  TRIM(xmm600.ntitle) + TRIM(xmm600.NAME).
    END.
    ELSE DO:
        FIND FIRST xtm600 USE-INDEX xtm60001    WHERE 
                   xtm600.acno = bacm001.agent  NO-LOCK NO-ERROR.
        IF AVAIL xtm600 THEN 
            ASSIGN
               nv_agent_name   = TRIM(xtm600.ntitle) + TRIM(xtm600.NAME).
    END.

    FIND FIRST xmm600 USE-INDEX xmm60001   WHERE 
               xmm600.acno  =  nv_gpstmt   NO-LOCK NO-ERROR.
    IF AVAIL xmm600 THEN DO:
        nv_gpstmt_name  =  TRIM(xmm600.ntitle) + TRIM(xmm600.NAME).
    END.
    ELSE DO:
        FIND FIRST xtm600 USE-INDEX xtm60001  WHERE 
                   xtm600.acno = nv_gpstmt    NO-LOCK NO-ERROR.
        IF AVAIL xtm600 THEN 
            ASSIGN
               nv_gpstmt_name  = TRIM(xtm600.ntitle) + TRIM(xtm600.NAME).
    END.

    nv_duedat  =  bacm001.trndat + nv_crper1. 

    IF nv_select = 1 THEN DO:
        IF acd001.cjodat > nv_duedat  THEN NEXT. /*วันที่ settle เกิน due date*/
    END.
    ELSE IF nv_select = 2 THEN DO:
        IF acd001.cjodat  <=  nv_duedat  THEN NEXT . /*วันที่ settle น้อยกว่า due date*/
    END.
    
    IF bacm001.instot = 1 THEN DO:
        
        FIND FIRST uwm100 USE-INDEX uwm10001  WHERE 
             uwm100.policy = bacm001.policy   AND 
             uwm100.docno1 = bacm001.docno    NO-LOCK NO-ERROR.
        IF AVAIL uwm100 THEN DO:
            
            ASSIGN
                nv_coins   =  uwm100.coins
                nv_new_ren =  IF uwm100.rencnt = 0 THEN "N" ELSE "R" 
                nv_rencnt  =  uwm100.rencnt 
                nv_co_per  =  100 - uwm100.co_per 
                nv_endcnt  =  uwm100.endcnt
                nv_comdat  =  uwm100.comdat
                nv_prod    =  uwm100.cr_1 /*(A61-0277) 14/06/2018*/
                nv_camp    =  uwm100.opnpol. /*(A61-0277) 14/06/2018*/


            FIND FIRST xtm600 USE-INDEX xtm60001      WHERE 
                       xtm600.acno  =  uwm100.insref  NO-LOCK NO-ERROR.
            IF AVAIL xtm600 THEN DO:
                nv_name  =  TRIM(xtm600.ntitle) + TRIM(xtm600.NAME).
            END.
            ELSE DO:
                FIND FIRST xmm600 USE-INDEX xmm60001     WHERE 
                           xmm600.acno  = uwm100.insref  NO-LOCK NO-ERROR.
                IF AVAIL xmm600 THEN DO:
                    nv_name  =  TRIM(xmm600.ntitle) + TRIM(xmm600.NAME).
                END.
            END.

            /*--- คิด due date แยก ตาม cbc comment ไว้ก่อน
            IF  uwm100.poltyp = "V70" OR                                 
                uwm100.poltyp = "V72" OR                                 
                uwm100.poltyp = "V73" OR                                 
                uwm100.poltyp = "V74" THEN DO: /*motor ทั้งหมดคิด due date ตามเงื่อนไข CBC*/
    
               IF uwm100.endcnt > 000 THEN nv_effdat = uwm100.enddat.
               ELSE nv_effdat = uwm100.comdat.
               
               IF SUBSTR((uwm100.insref),2,1) = "C" OR 
                  SUBSTR((uwm100.insref),3,1) = "C" THEN
                  nv_insref = "C". /*Customer Type */
               ELSE nv_insref = "P". 
    
               nv_duedate1  =  "".

               FIND FIRST xmm600 WHERE xmm600.acno = uwm100.agent NO-LOCK NO-ERROR NO-WAIT .
               IF AVAIL xmm600 THEN DO:
                   
                  IF xmm600.autoap = YES THEN DO:     /*-- Direct --*/
                    IF nv_insref = "P" THEN    /* CBC- บุคคลธรรมดา*/
                       ASSIGN nv_duedate1 = STRING(DAY(nv_effdat),"99")  +  STRING(MONTH(nv_effdat),"99") + STRING(YEAR(nv_effdat),"9999")
                              nv_crper    = 0.
                    ELSE DO:   
                        ASSIGN                    /* นิติบุคคล*/
                        dc_duedate = nv_effdat + 15
                        nv_duedate1  = STRING(DAY(dc_duedate),"99")  +  STRING(MONTH(dc_duedate),"99") + STRING(YEAR(dc_duedate),"9999")
                        nv_crper = 15.
                    END.
                  END.
                  ELSE DO:              /* -- Broker */
                     IF nv_insref = "P" THEN DO: 
                         nv_crper = 15.
                         RUN pdDuedate_P.     /* บุคคลธรรมดา*/
                     END.
                     ELSE DO: 
                         nv_crper = 30.        
                         RUN pdDuedate_C.     /* นิติบุคคล*/ 
                     END.
                  END.
               END.
            END.   /*Motor*/
            ELSE DO: /*Non Motor*/
                nv_duedat  =  bacm001.trndat + nv_crper1. /*non motor ทั้งหมด คิด due date จาก trandate*/
            END.
            ----*/
        END.
    END.
    ELSE IF bacm001.instot > 1 THEN DO:
        
        FIND FIRST uwm101 USE-INDEX uwm10101        WHERE 
                   uwm101.policy = bacm001.policy   AND
                   uwm101.trty1i = bacm001.trnty1   AND 
                   uwm101.docnoi = bacm001.docno    NO-LOCK NO-ERROR.
        IF AVAIL uwm101 THEN DO:
            
            FIND FIRST uwm100 USE-INDEX uwm10001        WHERE
                       uwm100.policy = uwm101.policy    AND
                       uwm100.rencnt = uwm101.rencnt    AND
                       uwm100.endcnt = uwm101.endcnt    NO-LOCK NO-ERROR.
            IF AVAIL uwm100 THEN DO:
                 
                ASSIGN
                    nv_coins   =  uwm100.coins
                    nv_new_ren =  IF uwm100.rencnt = 0 THEN "N" ELSE "R" 
                    nv_rencnt  =  uwm100.rencnt 
                    nv_co_per  =  100 - uwm100.co_per 
                    nv_endcnt  =  uwm100.endcnt
                    nv_comdat  =  uwm100.comdat 
                    nv_prod    =  uwm100.cr_1 /*(A61-0277) 14/06/2018*/
                    nv_camp    =  uwm100.opnpol. /*(A61-0277) 14/06/2018*/

        
                FIND FIRST xtm600 USE-INDEX xtm60001      WHERE 
                           xtm600.acno  =  uwm100.insref  NO-LOCK NO-ERROR.
                IF AVAIL xtm600 THEN DO:
                    ASSIGN
                        nv_name  =  TRIM(xtm600.ntitle) + TRIM(xtm600.NAME).
                END.
                ELSE DO:
                    FIND FIRST xmm600 USE-INDEX xmm60001     WHERE 
                               xmm600.acno  = uwm100.insref  NO-LOCK NO-ERROR.
                    IF AVAIL xmm600 THEN DO:
                        nv_name  =  TRIM(xmm600.ntitle) + TRIM(xmm600.NAME).
                    END.
                END.
                   
                /*--- คิด due date แยก ตาม cbc comment ไว้ก่อน
                IF  uwm100.poltyp = "V70" OR                                 
                    uwm100.poltyp = "V72" OR                                 
                    uwm100.poltyp = "V73" OR                                 
                    uwm100.poltyp = "V74" THEN DO: /*motor ทั้งหมดคิด due date ตามเงื่อนไข CBC*/
                   
                   IF uwm100.endcnt > 000 THEN nv_effdat = uwm100.enddat.
                   ELSE nv_effdat = uwm100.comdat.
        
                   IF SUBSTR((uwm100.insref),2,1) = "C" OR 
                      SUBSTR((uwm100.insref),3,1) = "C" THEN
                      nv_insref = "C". /*Customer Type */
                   ELSE nv_insref = "P". 
        
                   nv_duedate1  =  "".
        
                   FIND FIRST xmm600 WHERE xmm600.acno = uwm100.agent NO-LOCK NO-ERROR NO-WAIT .
                   IF AVAIL xmm600 THEN DO:
                      IF xmm600.autoap = YES THEN DO:     /*-- Direct --*/
                        IF nv_insref = "P" THEN    /* CBC- บุคคลธรรมดา*/
                           ASSIGN nv_duedate1 = STRING(DAY(nv_effdat),"99")  +  STRING(MONTH(nv_effdat),"99") + STRING(YEAR(nv_effdat),"9999")
                                  nv_crper    = 0.
                        ELSE DO:   
                            ASSIGN                    /* นิติบุคคล*/
                            dc_duedate = nv_effdat + 15
                            nv_duedate1  = STRING(DAY(dc_duedate),"99")  +  STRING(MONTH(dc_duedate),"99") + STRING(YEAR(dc_duedate),"9999")
                            nv_crper = 15.
                        END.
                      END.
                      ELSE DO:              /* -- Broker */
                         IF nv_insref = "P" THEN DO: 
                             nv_crper = 15.
                             RUN pdDuedate_P.     /* บุคคลธรรมดา*/
                         END.
                         ELSE DO: 
                             nv_crper = 30.
                             RUN pdDuedate_C.    /* นิติบุคคล*/ 
                         END.
                      END.
                   END.
                END.   /*Motor*/
                ELSE DO: /*Non Motor*/
                    nv_duedat  =  bacm001.trndat + nv_crper1. /*non motor ทั้งหมด คิด due date จาก trandate*/
                END.
                ----*/
            END.
        END.
    END.

    /*--- comment ไว้ก่อนเนื่องจากเป็น due date ตาม cbc
    IF nv_select = 1 THEN DO:
        IF bacm001.poltyp = "V70"  OR 
           bacm001.poltyp = "V72"  OR
           bacm001.poltyp = "V73"  OR
           bacm001.poltyp = "V74"  THEN DO:
            IF acd001.cjodat > DATE(nv_duedate1)  THEN NEXT. /*วันที่ settle เกิน due date*/
        END.
        ELSE DO:
            IF acd001.cjodat > nv_duedat  THEN NEXT. /*วันที่ settle เกิน due date*/
        END.
    END.
    ELSE IF nv_select = 2 THEN DO:
        IF bacm001.poltyp = "V70"  OR 
           bacm001.poltyp = "V72"  OR
           bacm001.poltyp = "V73"  OR
           bacm001.poltyp = "V74"  THEN DO:
            IF acd001.cjodat  <=  DATE(nv_duedate1)  THEN NEXT . /*วันที่ settle น้อยกว่า due date*/
        END.
        ELSE DO:
            IF acd001.cjodat  <=  nv_duedat  THEN NEXT . /*วันที่ settle น้อยกว่า due date*/
        END.
    END.
    ----*/
    
    nv_settamt  =  acd001.netamt * (-1).

    /*--- Check Retention --- By: Suppamas D. A56-0194 Date 03/06/2013---*/
    nv_ret = 0.
  
    FOR EACH uwm200 NO-LOCK USE-INDEX uwm20001 WHERE
         uwm200.policy = bacm001.policy     AND
         uwm200.rencnt = nv_rencnt         AND
         uwm200.endcnt = nv_endcnt         AND
         uwm200.csftq <> "C" AND
         uwm200.rico = "0ret".
        
       FOR each uwd200 USE-INDEX uwd20001 WHERE
                   uwd200.policy = bacm001.policy AND
                   uwd200.rencnt = nv_rencnt      AND
                   uwd200.endcnt = nv_endcnt      AND
                   uwd200.csftq <> "c"           AND
                   uwd200.rico   = uwm200.rico.
        
            ASSIGN nv_ret = nv_ret + uwd200.ripr.
            
        END.
    END.
   
    /*----End check Retention-----*/
     
    FIND FIRST wacm001 WHERE wacm001.policy  =  bacm001.policy AND                
                             wacm001.rencnt  =  nv_rencnt      AND
                             wacm001.endcnt  =  nv_endcnt      AND 
                             wacm001.trnty1  =  bacm001.trnty1 AND 
                             wacm001.docno   =  bacm001.docno  NO-LOCK NO-ERROR.
    IF NOT AVAIL wacm001 THEN DO:
                                                                                                        
        CREATE wacm001.
        ASSIGN
            wacm001.entdat      =    bacm001.entdat 
            wacm001.acno        =    bacm001.acno   
            wacm001.gpstmt      =    nv_gpstmt  
            wacm001.gpstmt_name =    nv_gpstmt_name
            wacm001.acno_name   =    nv_acno_name
            wacm001.agent_name  =    nv_agent_name
            wacm001.agent       =    bacm001.agent  
            wacm001.trndat      =    bacm001.trndat 
            wacm001.NEW_ren     =    nv_new_ren
            wacm001.rencnt      =    nv_rencnt
            wacm001.trnty1      =    bacm001.trnty1
            wacm001.trnty2      =    bacm001.trnty2
            wacm001.docno       =    bacm001.docno
            wacm001.branch      =    bacm001.branch 
            wacm001.poltyp      =    bacm001.poltyp 
            wacm001.policy      =    bacm001.policy 
            wacm001.endcnt      =    nv_endcnt      
            wacm001.instot      =    bacm001.insno      
            wacm001.coins       =    nv_coins       
            wacm001.co_per      =    nv_co_per      
            wacm001.name        =    nv_name        
            wacm001.cjodat      =    acd001.cjodat  
            wacm001.duedat      =    nv_duedat
            wacm001.prem        =    bacm001.prem
            wacm001.nprem       =    bacm001.prem + bacm001.tax + bacm001.stamp + bacm001.fee
            wacm001.commision   =    bacm001.comm
            wacm001.bal         =    bacm001.bal.
            wacm001.retention   =    IF nv_ret = 0 THEN bacm001.prem  /*--[A56-0194] date 03/06/2013--*/
                                     ELSE nv_ret.
            wacm001.product     =    nv_prod.  /* A61-0277  date 14/06/2018 */
            wacm001.campaign    =    nv_camp.  /* A61-0277  date 14/06/2018 */
            
        /*--- comment ไว้ก่อนเป็นเงื่อนไข cbc
        IF bacm001.poltyp = "V70"  OR 
           bacm001.poltyp = "V72"  OR
           bacm001.poltyp = "V73"  OR
           bacm001.poltyp = "V74"  THEN DO:
            wacm001.duedat   =  DATE(nv_duedate1).
        END.
        ELSE DO:
            wacm001.duedat  =  nv_duedat.
        END.
        ---*/

    END.
    ASSIGN
        wacm001.sett_amt =  wacm001.sett_amt + nv_settamt /*บวกยอด settle จากทุก record */
        wacm001.cjodat   =  acd001.cjodat.  /*ใช้ contra date ใน record สุดท้าย*/
         
                         
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdProcess1 C-Win 
PROCEDURE pdProcess1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF  VAR  nv_inc_date    AS  DATE .
DEF  VAR  nv_inc_mon     AS  INT .
DEF  VAR  nv_inc_yar     AS  INT .

loop_acd001:
FOR EACH acd001 USE-INDEX acd00192  NO-LOCK WHERE
         acd001.cjodat  >=  nv_contra_fr  AND
         acd001.cjodat  <=  nv_contra_to  AND
       ( acd001.ctrty1   =  "Y"           OR
         acd001.ctrty1   =  "Z"           OR
         acd001.ctrty1   =  "C"           OR
         acd001.ctrty1   =  "B" )         ,
    FIRST acm001 USE-INDEX acm00101  NO-LOCK WHERE
          acm001.trnty1   =  acd001.ctrty1  AND
          acm001.docno    =  acd001.cdocno  AND
          acm001.branch  >=  nv_branch_fr   AND
          acm001.branch  <=  nv_branch_to   AND
          acm001.trnty2   =  "P"            /*ดึงเฉพาะเบี้ยอย่างเดียว*/
        /*( acm001.trnty2   =  "P"            OR
          acm001.trnty2   =  "C"            OR
          acm001.trnty2   =  "S"            OR
          acm001.trnty2   =  "X"            OR
          acm001.trnty2   =  " "            OR
          acm001.trnty2   =  "W" )*/

    BREAK BY acm001.branch BY acd001.cjodat
          BY acm001.policy BY acm001.usrid :
    
    DISP acm001.policy WITH NO-LABEL TITLE "Process Report..."
        FRAME a1 VIEW-AS DIALOG-BOX.

    IF acd001.trnty1 = acd001.ctrty1  AND
       acd001.docno  = acd001.cdocno  THEN NEXT.
    
    IF acm001.acno   < nv_acno_fr   OR
       acm001.acno   > nv_acno_to   THEN NEXT.

    FIND bacm001 USE-INDEX acm00101     WHERE
         bacm001.trnty1  = acd001.trnty1  AND
         bacm001.docno   = acd001.docno   NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAIL bacm001 THEN NEXT.
     
    ASSIGN
        nv_gpstmt       =  ""
        nv_instot       =  0
        nv_co_per       =  0
        nv_new_ren      =  ""
        nv_rencnt       =  0
        nv_endcnt       =  0
        nv_name         =  ""
        nv_crper        =  0
        nv_duedat       =  ?
        nv_settamt      =  0
        nv_dueday       =  ""
        nv_duedate      =  0 
        nv_duedate1     =  ? 
        nv_duedate2     =  0 
        dc_duedate      =  ? 
        nv_effdat       =  ?
        nv_insref       = ""
        nv_gpstmt_name  = ""
        nv_acno_name    = ""
        nv_agent_name   = ""
        nv_inc_date     = ?
        nv_inc_mon      = 0
        nv_inc_yar      = 0
        nv_prod         = ""  /*(A61-0277) 14/06/2018*/
        nv_camp         = "".  /*(A61-0277) 14/06/2018*/

    IF bacm001.poltyp < nv_poltyp_fr OR
       bacm001.poltyp > nv_poltyp_to THEN NEXT.

    FIND FIRST xmm600 USE-INDEX xmm60001    WHERE 
               xmm600.acno = bacm001.acno   NO-LOCK NO-ERROR.
    IF AVAIL xmm600 THEN 
        ASSIGN
           nv_gpstmt      = xmm600.gpstmt
           nv_acno_name   = TRIM(xmm600.ntitle) + TRIM(xmm600.NAME)
           nv_crper1      = xmm600.crper.

    FIND FIRST xmm600 USE-INDEX xmm60001      WHERE 
               xmm600.acno  =  bacm001.agent  NO-LOCK NO-ERROR.
    IF AVAIL xmm600 THEN DO:
        nv_agent_name  =  TRIM(xmm600.ntitle) + TRIM(xmm600.NAME).
    END.
    ELSE DO:
        FIND FIRST xtm600 USE-INDEX xtm60001    WHERE 
                   xtm600.acno = bacm001.agent  NO-LOCK NO-ERROR.
        IF AVAIL xtm600 THEN 
            ASSIGN
               nv_agent_name   = TRIM(xtm600.ntitle) + TRIM(xtm600.NAME).
    END.

    FIND FIRST xmm600 USE-INDEX xmm60001   WHERE 
               xmm600.acno  =  nv_gpstmt   NO-LOCK NO-ERROR.
    IF AVAIL xmm600 THEN DO:
        nv_gpstmt_name  =  TRIM(xmm600.ntitle) + TRIM(xmm600.NAME).
    END.
    ELSE DO:
        FIND FIRST xtm600 USE-INDEX xtm60001  WHERE 
                   xtm600.acno = nv_gpstmt    NO-LOCK NO-ERROR.
        IF AVAIL xtm600 THEN 
            ASSIGN
               nv_gpstmt_name  = TRIM(xtm600.ntitle) + TRIM(xtm600.NAME).
    END.

    IF MONTH(bacm001.trndat) =  12 THEN DO:
        nv_inc_mon    =  01.
        nv_inc_yar    =  YEAR(bacm001.trndat) + 1.
    END.
    ELSE DO:
        nv_inc_mon    =  MONTH(bacm001.trndat) + 1.
        nv_inc_yar    =  YEAR(bacm001.trndat).
    END.

    nv_inc_date  =  DATE(nv_inc_mon,01,nv_inc_yar).

    nv_duedat    =  nv_inc_date + nv_crper1. 

    IF nv_select = 1 THEN DO:
        IF acd001.cjodat > nv_duedat  THEN NEXT. /*วันที่ settle เกิน due date*/
    END.
    ELSE IF nv_select = 2 THEN DO:
        IF acd001.cjodat  <=  nv_duedat  THEN NEXT . /*วันที่ settle น้อยกว่า due date*/
    END.
    
    IF bacm001.instot = 1 THEN DO:
        
        FIND FIRST uwm100 USE-INDEX uwm10001  WHERE 
             uwm100.policy = bacm001.policy   AND 
             uwm100.docno1 = bacm001.docno    NO-LOCK NO-ERROR.
        IF AVAIL uwm100 THEN DO:
            
            ASSIGN
                nv_coins   =  uwm100.coins
                nv_new_ren =  IF uwm100.rencnt = 0 THEN "N" ELSE "R" 
                nv_rencnt  =  uwm100.rencnt 
                nv_co_per  =  100 - uwm100.co_per 
                nv_endcnt  =  uwm100.endcnt
                nv_comdat  =  uwm100.comdat    
                nv_prod    =  uwm100.cr_1  /*(A61-0277) 14/06/2018*/ 
                nv_camp    =  uwm100.opnpol.  /*(A61-0277) 14/06/2018*/

            FIND FIRST xtm600 USE-INDEX xtm60001      WHERE 
                       xtm600.acno  =  uwm100.insref  NO-LOCK NO-ERROR.
            IF AVAIL xtm600 THEN DO:
                nv_name  =  TRIM(xtm600.ntitle) + TRIM(xtm600.NAME).
            END.
            ELSE DO:
                FIND FIRST xmm600 USE-INDEX xmm60001     WHERE 
                           xmm600.acno  = uwm100.insref  NO-LOCK NO-ERROR.
                IF AVAIL xmm600 THEN DO:
                    nv_name  =  TRIM(xmm600.ntitle) + TRIM(xmm600.NAME).
                END.
            END.
        END.
    END.
    ELSE IF bacm001.instot > 1 THEN DO:
        
        FIND FIRST uwm101 USE-INDEX uwm10101        WHERE 
                   uwm101.policy = bacm001.policy   AND
                   uwm101.trty1i = bacm001.trnty1   AND 
                   uwm101.docnoi = bacm001.docno    NO-LOCK NO-ERROR.
        IF AVAIL uwm101 THEN DO:
            
            FIND FIRST uwm100 USE-INDEX uwm10001        WHERE
                       uwm100.policy = uwm101.policy    AND
                       uwm100.rencnt = uwm101.rencnt    AND
                       uwm100.endcnt = uwm101.endcnt    NO-LOCK NO-ERROR.
            IF AVAIL uwm100 THEN DO:
                 
                ASSIGN
                    nv_coins   =  uwm100.coins
                    nv_new_ren =  IF uwm100.rencnt = 0 THEN "N" ELSE "R" 
                    nv_rencnt  =  uwm100.rencnt 
                    nv_co_per  =  100 - uwm100.co_per 
                    nv_endcnt  =  uwm100.endcnt
                    nv_comdat  =  uwm100.comdat    
                    nv_prod    =  uwm100.cr_1  /*(A61-0277) 14/06/2018*/ 
                    nv_camp    =  uwm100.opnpol. /*(A61-0277) 14/06/2018*/

                    
                FIND FIRST xtm600 USE-INDEX xtm60001      WHERE 
                           xtm600.acno  =  uwm100.insref  NO-LOCK NO-ERROR.
                IF AVAIL xtm600 THEN DO:
                    ASSIGN
                        nv_name  =  TRIM(xtm600.ntitle) + TRIM(xtm600.NAME).
                END.
                ELSE DO:
                    FIND FIRST xmm600 USE-INDEX xmm60001     WHERE 
                               xmm600.acno  = uwm100.insref  NO-LOCK NO-ERROR.
                    IF AVAIL xmm600 THEN DO:
                        nv_name  =  TRIM(xmm600.ntitle) + TRIM(xmm600.NAME).
                    END.
                END.
            END.
        END.
    END.

    nv_settamt  =  acd001.netamt * (-1).

     /*--- Check Retention --- By:Suppamas D. A56-0194 Date 03/06/2013---*/
    nv_ret = 0.
    FOR EACH uwm200 NO-LOCK USE-INDEX uwm20001 WHERE
         uwm200.policy = uwm100.policy     AND
         uwm200.rencnt = uwm100.rencnt     AND
         uwm200.endcnt = uwm100.endcnt     AND
         uwm200.csftq <> "C" AND
         uwm200.rico = "0ret".

        FOR each uwd200 USE-INDEX uwd20001 WHERE
                   uwd200.policy = bacm001.policy AND
                   uwd200.rencnt = nv_rencnt      AND
                   uwd200.endcnt = nv_endcnt      AND
                   uwd200.csftq <> "c"            AND
                   uwd200.rico   = uwm200.rico.
        
            ASSIGN nv_ret = nv_ret + uwd200.ripr.
            
        END.
    END.
   
    /*----End check Retention-----*/
     
    FIND FIRST wacm001 WHERE wacm001.policy  =  bacm001.policy AND                
                             wacm001.rencnt  =  nv_rencnt      AND
                             wacm001.endcnt  =  nv_endcnt      AND 
                             wacm001.trnty1  =  bacm001.trnty1 AND 
                             wacm001.docno   =  bacm001.docno  NO-LOCK NO-ERROR.
    IF NOT AVAIL wacm001 THEN DO:
                                                                                                        
        CREATE wacm001.
        ASSIGN
            wacm001.entdat      =    bacm001.entdat 
            wacm001.acno        =    bacm001.acno   
            wacm001.gpstmt      =    nv_gpstmt  
            wacm001.gpstmt_name =    nv_gpstmt_name
            wacm001.acno_name   =    nv_acno_name
            wacm001.agent_name  =    nv_agent_name
            wacm001.agent       =    bacm001.agent  
            wacm001.trndat      =    bacm001.trndat 
            wacm001.NEW_ren     =    nv_new_ren
            wacm001.rencnt      =    nv_rencnt
            wacm001.trnty1      =    bacm001.trnty1
            wacm001.trnty2      =    bacm001.trnty2
            wacm001.docno       =    bacm001.docno
            wacm001.branch      =    bacm001.branch 
            wacm001.poltyp      =    bacm001.poltyp 
            wacm001.policy      =    bacm001.policy 
            wacm001.endcnt      =    nv_endcnt      
            wacm001.instot      =    bacm001.insno      
            wacm001.coins       =    nv_coins       
            wacm001.co_per      =    nv_co_per      
            wacm001.name        =    nv_name        
            wacm001.cjodat      =    acd001.cjodat  
            wacm001.duedat      =    nv_duedat
            wacm001.prem        =    bacm001.prem
            wacm001.nprem       =    bacm001.prem + bacm001.tax + bacm001.stamp + bacm001.fee
            wacm001.commision   =    bacm001.comm
            wacm001.bal         =    bacm001.bal
            wacm001.retention   =    IF nv_ret = 0 THEN bacm001.prem  /*--[A56-0194] date 03/06/2013--*/ 
                                     ELSE nv_ret                                                       
            wacm001.product     =    nv_prod.  /* A61-0277  date 14/06/2018 */
            wacm001.campaign    =    nv_camp.  /* A61-0277  date 14/06/2018 */
    END.
    ASSIGN
        wacm001.sett_amt =  wacm001.sett_amt + nv_settamt /*บวกยอด settle จากทุก record */
        wacm001.cjodat   =  acd001.cjodat . /*ใช้ contra date ใน record สุดท้าย*/
                         
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdPutdata C-Win 
PROCEDURE pdPutdata :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME DEFAULT-FRAME.

    DEF VAR n_select  AS CHAR .
    DEF VAR nv_time   AS CHAR .
    DEF VAR nv_today  AS DATE FORMAT "99/99/9999".
    DEF VAR nv_balos  AS DECI .

    nv_output = INPUT fi_output + ".txt".
    ASSIGN
        n_select = ""
        nv_time  = STRING(TIME,"HH:MM:SS")
        nv_today = TODAY.

    IF nv_select = 1 THEN n_select = "With Credit Term".
    ELSE IF nv_select = 2 THEN n_select = "Over Due".
    ELSE IF nv_select = 3 THEN n_select = "No Credit Term".

    
    OUTPUT STREAM ns1 TO VALUE(nv_output).
    PUT STREAM ns1
        "Premium Settlement Report" SKIP
        "Report Date:  " nv_today  "  "  nv_time "  [WACR40]"  SKIP
        "Report Type:  " n_select FORMAT "X(20)" "Contra Date:  " fi_contra_fr " - " fi_contra_to SKIP
    .
    PUT STREAM ns1
        "Entry Date"       ";"
        "Account Code"     ";"
        "Account Name"     ";"
        "Group Statement"  ";"
        "Group Statement Name" ";"
        "Agent Code"       ";"
        "Agent Name"       ";"
        "Transaction Date" ";"
        "New/Renew"        ";"
        "Branch"           ";"
        "Main Class"       ";"
        "Policy no."       ";"
        "Ren. Count"       ";"
        "End. Count"       ";"
        "Tran. Type"       ";"
        "Doc. No"          ";"
        "Installment no."  ";"
        "Coinsurance"      ";"
        "Percent of Co insurance" ";"
        "Insured Name"     ";"
        "Due date"         ";"
        "Settlement date"  ";"
        "Gross premium"    ";"
        "Net premium"      ";"
        "Commission"       ";"
        "Settlement amt."  ";"
        "Balance O/S"      ";"
        /*----"Balance O/S (System)"  SKIP.---- [A56-0194] Date 03/06/2013---*/
        /*---[A56-0194] Date 03/06/2013---*/
        "Balance O/S (System)" ";"
        "Retention"  ";"
        "Product"    ";"    /* A61-0277  date 14/06/2018 */
        "Campaign"   SKIP . /* A61-0277  date 14/06/2018 */
     
       /*---[A56-0194] Date 03/06/2013---*/
    
    FOR EACH wacm001 BREAK BY wacm001.acno   BY wacm001.branch 
                           BY wacm001.poltyp BY wacm001.policy 
                           BY wacm001.rencnt BY wacm001.endcnt.

        nv_balos = 0.
        nv_balos = wacm001.nprem - wacm001.sett_amt.
        
        PUT STREAM ns1
            /*1*/  wacm001.entdat      FORMAT "99/99/9999" ";" 
            /*2*/  wacm001.acno        FORMAT "X(10)" ";"
            /*3*/  wacm001.acno_name   FORMAT "X(70)" ";" 
            /*4*/  wacm001.gpstmt      FORMAT "X(10)" ";"
            /*5*/  wacm001.gpstmt_name FORMAT "X(70)" ";"
            /*6*/  wacm001.agent       FORMAT "X(10)" ";"
            /*7*/  wacm001.agent_name  FORMAT "X(70)" ";"
            /*8*/  wacm001.trndat      FORMAT "99/99/9999" ";"
            /*9*/  wacm001.new_ren     FORMAT "X"     ";"
            /*10*/ wacm001.branch      FORMAT "X(2)"  ";"
            /*11*/ wacm001.poltyp      FORMAT "X(3)"  ";"
            /*12*/ wacm001.policy      FORMAT "X(12)" ";"
            /*13*/ wacm001.rencnt      FORMAT "999"   ";"
            /*14*/ wacm001.endcnt      FORMAT "999"   ";"
            /*15*/ wacm001.trnty1 + wacm001.trnty2    ";"
            /*16*/ wacm001.docno       FORMAT /*"X(8)"*/ "x(10)" /*A60-0267*/ ";"
            /*17*/ wacm001.instot      FORMAT ">>9"   ";"
            /*18*/ wacm001.coins  ";"
            /*19*/ wacm001.co_per ";"
            /*20*/ wacm001.NAME        FORMAT "X(70)" ";"
            /*21*/ wacm001.duedat      FORMAT "99/99/9999" ";"
            /*22*/ wacm001.cjodat      FORMAT "99/99/9999" ";"
            /*23*/ wacm001.prem        FORMAT "->>,>>>,>>>,>>9.99" ";"
            /*24*/ wacm001.nprem       FORMAT "->>,>>>,>>>,>>9.99" ";"
            /*25*/ wacm001.commision   FORMAT "->>,>>>,>>>,>>9.99" ";"
            /*26*/ wacm001.sett_amt    FORMAT "->>,>>>,>>>,>>9.99" ";"
            /*27*/ nv_balos            FORMAT "->>,>>>,>>>,>>9.99" ";"
            /*---/*28*/ wacm001.bal FORMAT "->>,>>>,>>>,>>9.99" SKIP---[A56-0194] Date 03/06/2013--*/
            /*28*/ wacm001.bal         FORMAT "->>,>>>,>>>,>>9.99" ";" /*[A56-0194] Date 03/06/2013*/
            /*29*/ wacm001.retention   FORMAT "->>,>>>,>>>,>>9.99" ";" /*[A56-0194] Date 03/06/2013*/
            /*30*/ wacm001.product     FORMAT "X(10)" ";" /* A61-0277  date 14/06/2018 */
            /*31*/ wacm001.campaign    FORMAT "X(10)" SKIP. /* A61-0277  date 14/06/2018 */
    END.
    OUTPUT  STREAM  ns1  CLOSE.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

