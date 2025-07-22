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

/* ***************************  Definitions  ************************** */
/* Create By : Phaiboon. [A58-0496] D. 20/01/2016                       */
/* ******************************************************************** */
/* Modify By : Benjaporn J. A60-0228 date 17/05/2017                    */
/*           „ÀÈ “¡“√∂‡æ‘Ë¡ account no. ·≈–‡æ‘Ë¡ªÿË¡ search  account no.*/
/*----------------------------------------------------------------------*/
/* Modify By : Suthida T. A61-0243 date 25/05/2018                      */
/*           - add  Invoice Date in Program 
             - Change Endtry date to Invoice Date in Report             */
/*----------------------------------------------------------------------*/
/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

DEF VAR nv_acno     AS CHAR INIT "".
DEF VAR nv_ityp     AS CHAR INIT "".
DEF VAR nv_fdat     AS DATE INIT ?.
DEF VAR nv_tdat     AS DATE INIT ?.
DEF VAR nv_finvdat  AS DATE INIT ?. /* suthida t. A61-0243 */
DEF VAR nv_tinvdat  AS DATE INIT ?. /* suthida t. A61-0243 */
DEF VAR nv_polno    AS CHAR INIT "".
DEF VAR nv_prev     AS CHAR INIT "".
DEF VAR nv_fcedp    AS CHAR INIT "".
DEF VAR nv_cedp     AS CHAR INIT "".
DEF VAR nv_docty    AS CHAR INIT "".
DEF VAR nv_chano    AS CHAR INIT "".
DEF VAR nv_name     AS CHAR INIT "".
DEF VAR nv_fname    AS CHAR INIT "".
DEF VAR nv_lname    AS CHAR INIT "".
DEF VAR nv_lochk    AS LOGICAL INIT NO.

DEF VAR nv_net    AS DECI INIT 0.
DEF VAR nv_stp    AS DECI INIT 0.
DEF VAR nv_vat    AS DECI INIT 0.
DEF VAR nv_grand  AS DECI INIT 0.
DEF VAR nv_tname  AS CHAR INIT "".
DEF VAR nv_invo   AS CHAR INIT "".
DEF VAR nv_entdat AS DATE INIT ?.
DEF VAR nv_invdat AS DATE INIT ?. /* Suthida t. A61-0243 */
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

/*--- Benjaporn J. A60-0228 date 17/05/2017 ---*/
DEF VAR nv_import  AS CHAR  .
DEF VAR nv_fileac  AS CHAR  .

DEF VAR nv_millisecond AS INT NO-UNDO.
DEF VAR nv_second      AS INT NO-UNDO.
DEF VAR nv_ms          AS INT NO-UNDO.
DEF VAR nv_sec         AS INT NO-UNDO.
DEF VAR nv_min         AS INT NO-UNDO.
DEF VAR nv_hour        AS INT NO-UNDO.
DEF VAR nv_timeps      AS CHAR NO-UNDO.
/*----------- End A60-0228  ----------*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-2 RECT-3 RecOK-9 RECT-111 RECT-112 ~
ra_acno fi_import fi_input bu_hpacno1 fi_from fi_to fi_invfrom fi_invto ~
fi_output bu_export bu_cancel 
&Scoped-Define DISPLAYED-OBJECTS ra_acno fi_import fi_input fi_group ~
fi_acno fi_from fi_to fi_invfrom fi_invto fi_output 

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
     SIZE 15 BY 1.14
     FONT 2.

DEFINE BUTTON bu_export 
     LABEL "Export" 
     SIZE 15 BY 1.14
     FONT 2.

DEFINE BUTTON bu_hpacno1 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY 1.05.

DEFINE VARIABLE fi_acno AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 75.33 BY 1
     BGCOLOR 15 FGCOLOR 4 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_from AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_group AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 38 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_import AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 38 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_input AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 38 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_invfrom AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_invto AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
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

DEFINE RECTANGLE RecOK-9
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 89 BY .24
     BGCOLOR 15 FGCOLOR 15 .

DEFINE RECTANGLE RECT-111
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 17 BY 1.57
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-112
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 17 BY 1.57
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 89 BY 14.05
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 89 BY 2.38
     BGCOLOR 8 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     ra_acno AT ROW 5.05 COL 32 NO-LABEL
     fi_import AT ROW 6.71 COL 30 COLON-ALIGNED NO-LABEL
     fi_input AT ROW 7.95 COL 30 COLON-ALIGNED NO-LABEL
     bu_hpacno1 AT ROW 7.95 COL 70.83
     fi_group AT ROW 9.14 COL 30 COLON-ALIGNED NO-LABEL
     fi_acno AT ROW 10.52 COL 9.5 COLON-ALIGNED NO-LABEL
     fi_from AT ROW 12.76 COL 30.17 COLON-ALIGNED NO-LABEL
     fi_to AT ROW 12.76 COL 53.67 COLON-ALIGNED NO-LABEL
     fi_invfrom AT ROW 14 COL 30.17 COLON-ALIGNED NO-LABEL WIDGET-ID 2
     fi_invto AT ROW 14 COL 53.67 COLON-ALIGNED NO-LABEL WIDGET-ID 4
     fi_output AT ROW 15.24 COL 30.17 COLON-ALIGNED NO-LABEL
     bu_export AT ROW 16.86 COL 32.17
     bu_cancel AT ROW 16.86 COL 54.33
     "Inv.Date From :" VIEW-AS TEXT
          SIZE 16.5 BY .62 AT ROW 14.24 COL 14 WIDGET-ID 8
          BGCOLOR 8 FONT 6
     "Ent.Date From :" VIEW-AS TEXT
          SIZE 14.83 BY .62 AT ROW 13 COL 14
          BGCOLOR 8 FONT 6
     "Export Tisco Bank Public Company" VIEW-AS TEXT
          SIZE 34.33 BY 1.67 AT ROW 2.57 COL 33.33
          BGCOLOR 8 FGCOLOR 12 FONT 6
     "Search By :" VIEW-AS TEXT
          SIZE 11.33 BY .62 AT ROW 5.38 COL 18.83
          BGCOLOR 8 FONT 6
     "To :" VIEW-AS TEXT
          SIZE 4.83 BY .62 AT ROW 12.95 COL 50
          BGCOLOR 8 FONT 6
     "Import AC no. :" VIEW-AS TEXT
          SIZE 15 BY .62 AT ROW 6.95 COL 15.67
          BGCOLOR 8 FONT 6
     "Output :" VIEW-AS TEXT
          SIZE 8.5 BY .62 AT ROW 15.38 COL 21.17
          BGCOLOR 8 FONT 6
     "Account :" VIEW-AS TEXT
          SIZE 10 BY .62 AT ROW 8.1 COL 20.67
          BGCOLOR 8 FONT 6
     "Group :" VIEW-AS TEXT
          SIZE 7.5 BY .62 AT ROW 9.24 COL 22.83
          BGCOLOR 8 FONT 6
     "To :" VIEW-AS TEXT
          SIZE 4.83 BY .62 AT ROW 14.19 COL 50 WIDGET-ID 6
          BGCOLOR 8 FONT 6
     RECT-2 AT ROW 4.57 COL 4
     RECT-3 AT ROW 2.19 COL 4
     RecOK-9 AT ROW 12.1 COL 4
     RECT-111 AT ROW 16.67 COL 31.17
     RECT-112 AT ROW 16.67 COL 53.33
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 95.67 BY 18.52
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
         HEIGHT             = 18.52
         WIDTH              = 95.67
         MAX-HEIGHT         = 21.24
         MAX-WIDTH          = 112.83
         VIRTUAL-HEIGHT     = 21.24
         VIRTUAL-WIDTH      = 112.83
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
   FRAME-NAME                                                           */
/* SETTINGS FOR FILL-IN fi_acno IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_group IN FRAME fr_main
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
        nv_acno     = fi_acno
        nv_fdat     = fi_from
        nv_tdat     = fi_to
        nv_finvdat  = fi_invfrom  /* --- suthida t. A61-0243 ----*/
        nv_tinvdat  = fi_invto   /* --- suthida t. A61-0243 ----*/
        nv_output   = fi_output.

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


&Scoped-define SELF-NAME bu_hpacno1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpacno1 C-Win
ON CHOOSE OF bu_hpacno1 IN FRAME fr_main
DO:
   DEF VAR n_acno   AS CHAR.
   DEF VAR n_agent  AS CHAR.    
     
   Run whp\whpacno1(OUTPUT  n_acno,
                    OUTPUT  n_agent).
                                          
     If  n_acno  <>  ""  THEN fi_input =  n_acno.
     DISP fi_input  WITH FRAME fr_main.
     APPLY "Entry"  TO fi_input.
     RETURN  NO-APPLY.

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

  IF fi_from > fi_to THEN DO:
      MESSAGE "Mandatory to From Date" VIEW-AS ALERT-BOX.
      APPLY "Entry" TO fi_from.
      RETURN NO-APPLY.
  END.


  fi_from = INPUT fi_from.
  fi_to   = INPUT fi_to.

  
  IF LENGTH(STRING(fi_from)) >= 10 THEN DO:
  
  IF fi_from < fi_to THEN DO:
      fi_output = "C:\temp\TAX" + "STYS" + "_" + STRING(DAY(fi_from),"99") + STRING(MONTH(fi_from), "99") + STRING(YEAR(fi_from), "9999") + "-" + 
                                                 STRING(DAY(fi_to),"99") + STRING(MONTH(fi_to), "99") + STRING(YEAR(fi_to), "9999").
      DISP fi_output WITH FRAME fr_main.
  END.
  ELSE DO:
      fi_output = "C:\temp\TAX" + "STYS" + "_" + STRING(DAY(TODAY), "99") + STRING(MONTH(TODAY), "99") + STRING(YEAR(TODAY), "9999").
      DISP fi_output WITH FRAME fr_main.
  END.

  END.
  


  
  APPLY "Entry" TO fi_to.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_from C-Win
ON VALUE-CHANGED OF fi_from IN FRAME fr_main
DO:
  fi_from = INPUT fi_from NO-ERROR.
  fi_to   = INPUT fi_to   NO-ERROR.
  
  IF LENGTH(STRING(fi_from)) >= 8 THEN DO:
  
     IF fi_from < fi_to THEN DO:
         fi_output = "C:\temp\TAX" + "STYS" + "_" + STRING(DAY(fi_from),"99") + STRING(MONTH(fi_from), "99") + STRING(YEAR(fi_from), "9999") + "-" + 
                                                    STRING(DAY(fi_to),"99") + STRING(MONTH(fi_to), "99") + STRING(YEAR(fi_to), "9999").
         DISP fi_output WITH FRAME fr_main.
     END.
     ELSE DO:
         fi_output = "C:\temp\TAX" + "STYS" + "_" + STRING(DAY(TODAY), "99") + STRING(MONTH(TODAY), "99") + STRING(YEAR(TODAY), "9999").
         DISP fi_output WITH FRAME fr_main.
     END.
  END.
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
          /*  se_acno:LIST-ITEMS = SUBSTR(nv_acno,1,LENGTH(nv_acno) - 1). */  /* june */
            nv_acno = "".
        END.
        ELSE DO:
            MESSAGE "Not found Account Group !" VIEW-AS ALERT-BOX ERROR.
        END.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_import
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_import C-Win
ON LEAVE OF fi_import IN FRAME fr_main
DO:
  /*--- Benjaporn J. A60-0228 date 17/05/2017 ---*/
    fi_import = INPUT fi_import. 
    DISP fi_import WITH FRAME fr_main .

    IF ra_acno = 1 THEN DO:
    
       IF SEARCH(fi_import) <> ? THEN  DO:
           INPUT FROM VALUE (fi_import) .
           loop_1:
           REPEAT:
               IMPORT nv_import.
               fi_acno = fi_acno + "," + nv_import.         
               DISP fi_acno WITH FRAME fr_main.
           END.
       END. 
       ELSE DO:
           MESSAGE "‰¡Ëæ∫‰ø≈Ï∑’Ë√–∫ÿ" VIEW-AS ALERT-BOX. 
       END.  
    END.

    ELSE NEXT.
   /*----------- End A60-0228 -----------*/

  




END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_import C-Win
ON RETURN OF fi_import IN FRAME fr_main
DO:
  fi_output = INPUT fi_output.
  APPLY "Entry" TO bu_export.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_input
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_input C-Win
ON LEAVE OF fi_input IN FRAME fr_main
DO:
    /*--- Benjaporn J. A60-0228 date 17/05/2017 ---*/
    ENABLE fi_input WITH FRAME fr_main.
    ASSIGN
      fi_input = INPUT fi_input .

      IF fi_acno = "" THEN DO:
         fi_acno = fi_input . 
      END.

      ELSE DO:
         fi_acno  = fi_acno + "," + fi_input.
      END.

    DISP  fi_acno WITH FRAME fr_main.

    /*------------ End A60-0228 ------------*/


 




END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_input C-Win
ON RETURN OF fi_input IN FRAME fr_main
DO:
  fi_output = INPUT fi_output.
  APPLY "Entry" TO bu_export.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_invfrom
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_invfrom C-Win
ON LEAVE OF fi_invfrom IN FRAME fr_main
DO:
  fi_invfrom = INPUT fi_invfrom.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_invfrom C-Win
ON RETURN OF fi_invfrom IN FRAME fr_main
DO:
  fi_invfrom = INPUT fi_invfrom.

  IF fi_invfrom > fi_invto THEN DO:
      MESSAGE "Mandatory to From Date" VIEW-AS ALERT-BOX.
      APPLY "Entry" TO fi_invfrom.
      RETURN NO-APPLY.
  END.


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_invto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_invto C-Win
ON LEAVE OF fi_invto IN FRAME fr_main
DO:
  fi_invto = INPUT fi_invto.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_invto C-Win
ON RETURN OF fi_invto IN FRAME fr_main
DO:
  fi_invto = INPUT fi_invto.

  IF fi_invto < fi_from THEN DO:
      MESSAGE "Mandatory to From Date" VIEW-AS ALERT-BOX.
      APPLY "Entry" TO fi_from.
      RETURN NO-APPLY.
  END.

  APPLY "Entry" TO fi_output.
  RETURN NO-APPLY.
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
  fi_to = INPUT fi_to.

  IF fi_to < fi_from THEN DO:
      MESSAGE "Mandatory to From Date" VIEW-AS ALERT-BOX.
      APPLY "Entry" TO fi_from.
      RETURN NO-APPLY.
  END.

  APPLY "Entry" TO fi_invfrom.
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

    IF ra_acno  = 1 THEN DO:
         fi_acno   = "B3M0003,B3M0032,B3M0029".
         fi_input  = "" .
         fi_import = "C:\temp\accountno.txt" .  /* A60-0228 */
       ENABLE fi_import WITH FRAME fr_main.
       DISABLE /*se_acno*/ fi_group fi_input bu_hpacno1 WITH FRAME fr_main.
       DISP fi_import fi_acno fi_input bu_hpacno1 WITH FRAME fr_main.
    END.

    /*--- Comment By Benjaporn J. A60-0228 date 17/05/2017
    ELSE IF ra_acno = 2 THEN DO:
        fi_acno = "".

        FOR EACH xmm600 WHERE xmm600.gpstmt = "A0M1009" NO-LOCK.
            nv_acno = nv_acno + xmm600.acno + ",".         
        END.

        se_acno:LIST-ITEMS = SUBSTR(nv_acno,1,LENGTH(nv_acno) - 1).
        nv_acno = "".

        ENABLE se_acno WITH FRAME fr_main.
        DISABLE fi_group WITH FRAME fr_main.
        DISP fi_acno WITH FRAME fr_main.
    END.
    ELSE DO:
        fi_acno = "".     
        se_acno:LIST-ITEMS = "".
        ENABLE fi_group se_acno WITH FRAME fr_main.
        DISP fi_acno WITH FRAME fr_main.
    END.
       End Comment A60-0228  -----------------*/

    /*--- Benjaporn J. A60-0228 date 17/05/2017 ---*/
    IF ra_acno = 2 THEN DO:
       
       ASSIGN fi_input  = ""
              fi_acno   = ""
              fi_import = "" .
       
       ENABLE fi_input  bu_hpacno1 WITH FRAME fr_main.
       DISABLE fi_import fi_group WITH FRAME fr_main.
       DISP fi_input fi_import fi_group fi_acno bu_hpacno1 WITH FRAME fr_main.

    END.

    IF ra_acno = 3 THEN DO:
       
       ASSIGN fi_input  = ""
              fi_acno   = ""
              fi_import = "" .
       
       ENABLE fi_group WITH FRAME fr_main.
       DISABLE fi_import fi_input bu_hpacno1 WITH FRAME fr_main.
       DISP fi_input fi_import fi_group fi_acno bu_hpacno1 WITH FRAME fr_main.

    END.
        /*---------- End A60-0228 -----------*/


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
  
  gv_prgid = "wacttisc.w".
  gv_prog  = "Report Tisco".
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).

/*********************************************************************/  
RUN  WUT\WUTWICEN (c-win:handle).  
  Session:data-Entry-Return = Yes.

  ASSIGN     
      fi_acno      = "B3M0003,B3M0029,B3M0032"
      fi_from      = TODAY
      fi_to        = TODAY  
      fi_invfrom   = TODAY /* suthida t. A61-0243 */
      fi_invto     = TODAY /* suthida t. A61-0243 */ 
      fi_output    = "C:\temp\TAX" + "STYS" + "_" + STRING(DAY(TODAY), "99") + STRING(MONTH(TODAY), "99") + STRING(YEAR(TODAY), "9999")
      fi_import    = "C:\temp\accountno.txt" .  /* A60-0228 */

 /* co_acno:LIST-ITEMS = "B3M0003" + "," + "B3M0032" + "," + "B3M0029". */
     
 /* FIND FIRST xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = "B3M0003" NO-LOCK NO-ERROR.
  IF AVAIL xmm600 THEN fi_acdes = xmm600.NAME.*/

  DISABLE fi_input fi_group  bu_hpacno1 WITH FRAME fr_main.
  DISP fi_acno fi_from fi_to fi_output fi_import fi_input fi_group  bu_hpacno1 fi_invfrom  fi_invto WITH FRAME fr_main.


 /*--- Benjaporn J. A60-0228 date 17/05/2017 ---*/
  nv_fileac = "C:\temp\accountno.txt" .

  IF SEARCH(nv_fileac) <> ? THEN  DO:
      INPUT FROM VALUE (nv_fileac).
      loop_1:
      REPEAT:
          IMPORT nv_import.
          fi_acno = fi_acno + "," + nv_import.         
          DISP fi_acno WITH FRAME fr_main.
      END.
  END.
  
  ELSE DO:
      MESSAGE " ‰¡Ëæ∫‰ø≈Ï account no. " VIEW-AS ALERT-BOX. 
  END.  
 /*---------- End A60-0228 ----------*/

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
  DISPLAY ra_acno fi_import fi_input fi_group fi_acno fi_from fi_to fi_invfrom 
          fi_invto fi_output 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE RECT-2 RECT-3 RecOK-9 RECT-111 RECT-112 ra_acno fi_import fi_input 
         bu_hpacno1 fi_from fi_to fi_invfrom fi_invto fi_output bu_export 
         bu_cancel 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
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
ETIME(YES).

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
    END.
END.
/* End by Phaiboon W. [A59-0161] 05/05/2016 */


OUTPUT STREAM ns1 TO VALUE(nv_output1).
OUTPUT STREAM ns2 TO VALUE(nv_output2).

PUT STREAM ns2
            "Ceding PolNo."   + "|" +
            "Previous PolNo." + "|" +
            "Policy Type"     + "|" +
            "Policy No."      + "|" +
            "Chassis No."     + "|" +
            "Ac.First Name"   + "|" +
            "Ac.Last Name"    + "|" +
            "Premium Due"     + "|" +
            "Stamp"           + "|" +
            "Vat Amount"      + "|" +
            "Gross Amount"    + "|" +
            "TAX Name"        + "|" +
            "TAX No."         + "|" +
            "TAX Date"        + "|" +  
            "TAX Branch" FORMAT "X(200)" SKIP. 

loop_for100:
FOR EACH vat100 USE-INDEX vat10004 WHERE
                          vat100.entdat >= nv_fdat    AND
                          vat100.entdat <= nv_tdat    AND
                          vat100.invdat >= nv_finvdat AND /* -- suthida T. A61-0243 -- */
                          vat100.invdat <= nv_tinvdat AND /* -- suthida T. A61-0243 -- */
                        /*  vat100.acno    = nv_acno AND */
                          vat100.rencnt  = 0       AND                        
                          vat100.cancel  = NO NO-LOCK:
    
    DISP vat100.policy WITH COLOR BLACK/WHITE NO-LABEL TITLE "Process data......"
                       CENTERED FRAME fr_process VIEW-AS DIALOG-BOX.

    /* Begin by Phaiboon W. [A59-0161] 05/05/2016 */
    FIND FIRST tacno WHERE tacno.acno = vat100.acno NO-LOCK NO-ERROR.
    IF NOT AVAIL tacno THEN NEXT loop_for100.
    /* End by Phaiboon W. [A59-0161] 05/05/2016 */

        DISP vat100.policy vat100.acno WITH COLOR BLACK/WHITE NO-LABEL TITLE "Process data......"
                                       CENTERED FRAME fr_process VIEW-AS DIALOG-BOX. /*ann */
                        
     IF INDEX(vat100.NAME, "∏π“§“√∑‘ ‚°È")  = 0 AND
        INDEX(vat100.NAME, "∏π“§“√ ∑‘ ‚°È") = 0 AND 
        INDEX(vat100.NAME, "∑‘ ‚°È") = 0 THEN DO:
               
            FIND LAST uwm100 USE-INDEX uwm10001 WHERE 
                      uwm100.policy = vat100.policy AND
                      uwm100.rencnt = vat100.rencnt NO-LOCK NO-ERROR.
            IF AVAIL uwm100 THEN DO:
                nv_chk = uwm100.name1 + " " + uwm100.name2 + " " + uwm100.name3.   

                IF ((INDEX(nv_chk,"·≈–") <> 0 OR INDEX(nv_chk,"À√◊Õ") <> 0) AND 
                     INDEX(nv_chk,"∑‘ ‚°È") <> 0) OR INDEX(nv_chk,"∏π“§“√∑‘ ‚°È") <> 0 OR 
                     INDEX(nv_chk,"∏π“§“√ ∑‘ ‚°È") <> 0 OR TRIM(uwm100.bs_cd) = "MC11859" THEN DO:                    
                END.
                ELSE NEXT loop_for100.
            END. 
    END.
    ELSE DO:
        FIND LAST uwm100 USE-INDEX uwm10001 WHERE 
                  uwm100.policy = vat100.policy AND
                  uwm100.rencnt = vat100.rencnt NO-LOCK NO-ERROR.        
    END.
           
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
        nv_net    = 0
        nv_stp    = 0
        nv_vat    = 0
        nv_grand  = 0
        nv_tname  = ""
        nv_invo   = ""
        nv_entdat = ?
        nv_invdat = ?
        nv_brins  = ""
        nv_vat    = vat100.vatamt
        nv_grand  = vat100.grandamt 
        nv_tname  = vat100.NAME
        nv_invo   = vat100.invoice
        nv_entdat = vat100.entdat
        nv_invdat = vat100.invdat  /* suthida t. A61-0243 */
        nv_brins  = TRIM(SUBSTR(vat100.taxno,20,5))
        nv_cnet   = ""
        nv_cstp   = ""
        nv_cvat   = ""
        nv_cgrand = "".    
    
    IF AVAIL uwm100 THEN DO:
        /*IF TRIM(uwm100.bs_cd) <> "MC11859" THEN NEXT loop_for100. 
      
        nv_chk = uwm100.name1 + " " + uwm100.name2 + " " + uwm100.name3.        
        
        IF ((INDEX(nv_chk,"·≈–") <> 0 OR INDEX(nv_chk,"À√◊Õ") <> 0) AND 
            INDEX(nv_chk,"∑‘ ‚°È") <> 0) OR INDEX(nv_chk,"∏π“§“√∑‘ ‚°È") <> 0 OR 
            INDEX(nv_chk,"∏π“§“√ ∑‘ ‚°È") <> 0 OR TRIM(uwm100.bs_cd) = "MC11859" THEN DO:
        END.
        ELSE NEXT loop_for100.  */

        FIND FIRST uwm120 USE-INDEX uwm12001 WHERE uwm120.policy = uwm100.policy AND
                                                   uwm120.rencnt = uwm100.rencnt AND
                                                   uwm120.endcnt = uwm100.endcnt NO-LOCK NO-ERROR.
        IF AVAIL uwm120 THEN DO:
            nv_net = uwm120.prem_r.
            nv_stp = uwm120.rstp_r.
            IF nv_net < 0 OR nv_stp < 0 THEN NEXT loop_for100.
        END.
        
        IF uwm100.poltyp = "V72" OR uwm100.poltyp = "V73" OR uwm100.poltyp = "V74" THEN 
            nv_docty = "Compulsory".
        ELSE nv_docty = "Policy".

        IF uwm100.endcnt > 0 THEN nv_docty = nv_docty + "-endorsement".

        ASSIGN
            nv_polno = uwm100.policy
            nv_cedp  = uwm100.cedpol.
                   
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

                    IF      INDEX(nv_fname,"§ÿ≥") = 1 THEN nv_fname = SUBSTR(nv_fname,4).
                    ELSE IF INDEX(nv_fname,"π“¬") = 1 THEN nv_fname = SUBSTR(nv_fname,4).            
                    nv_fname = TRIM(nv_fname).
                END.
        END.

        FIND FIRST uwm301 USE-INDEX uwm30101 WHERE uwm301.policy = uwm100.policy AND
                                                   uwm301.rencnt = uwm100.rencnt NO-LOCK NO-ERROR.
        IF AVAIL uwm301 THEN nv_chano = uwm301.cha_no.
        ASSIGN
            nv_cedp    = TRIM(nv_cedp)
            nv_fcedp   = TRIM(nv_fcedp)
            nv_cedp    = FILL("0", 10 - LENGTH(nv_cedp)) + nv_cedp
            nv_fcedp   = FILL("0", 10 - LENGTH(nv_fcedp)) + nv_fcedp
            nv_cnet    = TRIM(STRING(nv_net  ,">>>>>>>>>>9.99"))
            nv_cstp    = TRIM(STRING(nv_stp  ,">>>>>>>>>>9.99"))
            nv_cvat    = TRIM(STRING(nv_vat  ,">>>>>>>>>>9.99"))
            nv_cgrand  = TRIM(STRING(nv_grand,">>>>>>>>>>9.99"))
            nv_cnet    = REPLACE(nv_cnet  ,".","")
            nv_cstp    = REPLACE(nv_cstp  ,".","")
            nv_cvat    = REPLACE(nv_cvat  ,".","")
            nv_cgrand  = REPLACE(nv_cgrand,".","")
            nv_cnet    = FILL("0",11 - LENGTH(nv_cnet)) + nv_cnet
            nv_cstp    = FILL("0",9  - LENGTH(nv_cstp)) + nv_cstp
            nv_cvat    = FILL("0",11 - LENGTH(nv_cvat)) + nv_cvat
            nv_cgrand  = FILL("0",11 - LENGTH(nv_cgrand)) + nv_cgrand
            /*nv_centdat = STRING(nv_entdat,"99/99/9999") -- Suthida T. A61-0243 --*/
            nv_centdat = STRING(nv_invdat,"99/99/9999") /*  -- Suthida T. A61-0243 -- */
            nv_centdat = REPLACE(nv_centdat,"/","")
            nv_cnet    = TRIM(nv_cnet)
            nv_cstp    = TRIM(nv_cstp)
            nv_cvat    = TRIM(nv_cvat)
            nv_cgrand  = TRIM(nv_cgrand)
            nv_centdat = TRIM(nv_centdat)
            nv_lochk   = YES.
               
        IF nv_fcedp = "0000000000" THEN nv_fcedp = " ".      
        IF nv_lname = "" THEN nv_lname = " ".
                   
        PUT STREAM ns1
            nv_cedp     FORMAT  "X(10)"
            nv_fcedp    FORMAT  "X(10)"
            nv_docty    FORMAT  "X(25)"
            nv_polno    FORMAT  "X(25)"
            nv_chano    FORMAT  "X(25)"
            nv_fname    FORMAT  "X(30)"
            nv_lname    FORMAT  "X(45)"
            nv_cnet     FORMAT  "X(11)"
            nv_cstp     FORMAT  "X(9)"
            nv_cvat     FORMAT  "X(11)"
            nv_cgrand   FORMAT  "X(11)"
            nv_tname    FORMAT  "X(50)"
            nv_invo     FORMAT  "X(50)"
            nv_centdat  FORMAT  "X(8)"
            nv_brins    FORMAT  "X(5)" SKIP.

        PUT STREAM ns2
            nv_cedp     FORMAT  "X(10)" + "|"
            nv_fcedp    FORMAT  "X(10)" + "|"
            nv_docty    FORMAT  "X(25)" + "|"
            nv_polno    FORMAT  "X(25)" + "|"
            nv_chano    FORMAT  "X(25)" + "|"
            nv_fname    FORMAT  "X(30)" + "|"
            nv_lname    FORMAT  "X(45)" + "|"
            nv_cnet     FORMAT  "X(11)" + "|"
            nv_cstp     FORMAT  "X(9)"  + "|"
            nv_cvat     FORMAT  "X(11)" + "|"
            nv_cgrand   FORMAT  "X(11)" + "|"
            nv_tname    FORMAT  "X(50)" + "|"
            nv_invo     FORMAT  "X(50)" + "|"
            nv_centdat  FORMAT  "X(8)"  + "|"
            nv_brins    FORMAT  "X(5)"  SKIP. 
   END.
END.

nv_millisecond = ETIME.
nv_second      = nv_millisecond / 1000.

nv_ms   = nv_millisecond MOD 1000.
nv_sec  = nv_second MOD 60.
nv_min  = TRUNC(nv_second / 60,0) MOD 60.
nv_hour = TRUNC(nv_second / 3600,0).

nv_timeps = STRING(nv_hour) + " hr "
          + STRING(nv_min)  + " min "
          + STRING(nv_sec)  + " sec "
          + STRING(nv_ms)   + " ms". 



OUTPUT STREAM ns1 CLOSE.
OUTPUT STREAM ns2 CLOSE.
IF nv_lochk = NO THEN MESSAGE "No Data" VIEW-AS ALERT-BOX INFORMATION.
ELSE MESSAGE "Complete" SKIP 
             nv_timeps VIEW-AS ALERT-BOX.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

