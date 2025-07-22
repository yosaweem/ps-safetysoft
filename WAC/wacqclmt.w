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

  Created: Nattanicha Benjaporn [A59-0153] 10/06/2016
  Modify : Nattanicha Benjaporn [A60-0358]  15/10/2017
 
------------------------------------------------------------------------*/
/*          This .W file was created with the Progress AppBuilder.      */
/*----------------------------------------------------------------------*/
/*Modify by : Ranu I. A61-0035 Date 30/08/2018
              เพิ่มเงื่อนไขการเช็ค branch และเพิ่ม index ในการค้นหาข้อมูล
              และแก้ไขการดึงข้อมูล  agtprm_fil.asdat = 1/11/2000
------------------------------------------------------------------------ */
/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */

CREATE WIDGET-POOL.

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

DEF SHARED VAR n_User    AS CHAR.
DEF SHARED VAR n_Passwd  AS CHAR.

DEF VAR nv_agenfr AS CHAR FORMAT "X(10)" .
DEF VAR nv_agento AS CHAR FORMAT "X(10)" .
DEF VAR nv_asdat  AS DATE FORMAT "99/99/9999" INIT ?.
DEF VAR nv_output AS CHAR FORMAT "X(20)" .
DEF VAR nv_sort   AS CHAR FORMAT "X(10)" .

DEFINE STREAM ns1. 

DEFINE TEMP-TABLE txmm600 NO-UNDO  
    FIELD   tgpstm     AS CHAR FORMAT "x(10)" 
    FIELD   tacno      AS CHAR FORMAT "x(10)"  
    FIELD   thomebr    AS CHAR FORMAT "x(2)" 
    FIELD   tname      AS CHAR FORMAT "x(30)"  
    FIELD   tcrlmt     AS DECI FORMAT ">,>>>,>>>,>>>,>>9"   
    FIELD   tcramt     AS DECI FORMAT ">,>>>,>>>,>>>,>>9"
    FIELD   tcrcon     AS LOGICAL 
    FIELD   tiblack    AS CHAR FORMAT "x(15)"  .

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME frmain
&Scoped-define BROWSE-NAME br_xmm600

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES txmm600

/* Definitions for BROWSE br_xmm600                                     */
&Scoped-define FIELDS-IN-QUERY-br_xmm600 txmm600.thomebr txmm600.tgpstm txmm600.tacno txmm600.tname txmm600.tcrlmt txmm600.tcramt txmm600.tcrcon txmm600.tiblack   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_xmm600   
&Scoped-define SELF-NAME br_xmm600
&Scoped-define QUERY-STRING-br_xmm600 FOR EACH txmm600  NO-LOCK      BY txmm600.thomebr
&Scoped-define OPEN-QUERY-br_xmm600 OPEN QUERY br_xmm600 FOR EACH txmm600  NO-LOCK      BY txmm600.thomebr  .
&Scoped-define TABLES-IN-QUERY-br_xmm600 txmm600
&Scoped-define FIRST-TABLE-IN-QUERY-br_xmm600 txmm600


/* Definitions for FRAME frmain                                         */
&Scoped-define OPEN-BROWSERS-IN-QUERY-frmain ~
    ~{&OPEN-QUERY-br_xmm600}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS ri_sort to_over fi_agenfr fi_agento ~
fi_branfr fi_branto bu_check br_xmm600 fi_output bu_ok nv_reset bu_exit ~
RecOK RecOK-4 bg bg-2 RecOK-5 bg-3 RecOK-6 RecOK-7 RecOK-8 bg-4 RecOK-9 
&Scoped-Define DISPLAYED-OBJECTS ri_sort to_over fi_agenfr fi_agento ~
fi_branfr fi_branto fi_output 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_check 
     LABEL "Check" 
     SIZE 15 BY 1.14
     FONT 2.

DEFINE BUTTON bu_exit 
     LABEL "Exit" 
     SIZE 15 BY 1.14
     FONT 2.

DEFINE BUTTON bu_ok 
     LABEL "OK" 
     SIZE 15 BY 1.14
     FONT 2.

DEFINE BUTTON nv_reset 
     LABEL "Reset" 
     SIZE 15 BY 1.14
     FONT 2.

DEFINE VARIABLE fi_agenfr AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     FONT 2 NO-UNDO.

DEFINE VARIABLE fi_agento AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     FONT 2 NO-UNDO.

DEFINE VARIABLE fi_branfr AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1
     FONT 2 NO-UNDO.

DEFINE VARIABLE fi_branto AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1
     FONT 2 NO-UNDO.

DEFINE VARIABLE fi_output AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 43.5 BY 1
     FONT 2 NO-UNDO.

DEFINE VARIABLE ri_sort AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Group", 1,
"Producer", 2
     SIZE 15 BY 3
     BGCOLOR 20 FGCOLOR 15 FONT 2 NO-UNDO.

DEFINE RECTANGLE bg
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 87.5 BY 3.86
     BGCOLOR 34 .

DEFINE RECTANGLE bg-2
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 33.33 BY 6.24
     BGCOLOR 20 .

DEFINE RECTANGLE bg-3
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 120.5 BY 2.86
     BGCOLOR 20 .

DEFINE RECTANGLE bg-4
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 59.5 BY 1.71
     BGCOLOR 18 .

DEFINE RECTANGLE RecOK
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 16.5 BY 1.67
     BGCOLOR 1 .

DEFINE RECTANGLE RecOK-4
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 120.5 BY 18.05
     BGCOLOR 1 .

DEFINE RECTANGLE RecOK-5
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 16.5 BY 1.71
     BGCOLOR 32 .

DEFINE RECTANGLE RecOK-6
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 16.5 BY 1.71
     BGCOLOR 33 .

DEFINE RECTANGLE RecOK-7
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 16.5 BY 1.71
     BGCOLOR 33 .

DEFINE RECTANGLE RecOK-8
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 16.5 BY 1.71
     BGCOLOR 32 .

DEFINE RECTANGLE RecOK-9
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE .67 BY 3.86
     BGCOLOR 1 .

DEFINE VARIABLE to_over AS LOGICAL INITIAL no 
     LABEL "Over" 
     VIEW-AS TOGGLE-BOX
     SIZE 9 BY .95
     BGCOLOR 20 FONT 2 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_xmm600 FOR 
      txmm600 SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_xmm600
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_xmm600 C-Win _FREEFORM
  QUERY br_xmm600 DISPLAY
      txmm600.thomebr COLUMN-LABEL  "Branch"       FORMAT "X(2)"
txmm600.tgpstm  COLUMN-LABEL  "Group"        FORMAT "X(12)"
txmm600.tacno   COLUMN-LABEL  "Producer"     FORMAT "X(12)"
txmm600.tname   COLUMN-LABEL  "Name"         FORMAT "X(30)"
txmm600.tcrlmt  COLUMN-LABEL  "Credit"       FORMAT "->>,>>>,>>>,>>9.99"
txmm600.tcramt  COLUMN-LABEL  "Amount"       FORMAT "->>,>>>,>>>,>>9.99"
txmm600.tcrcon  COLUMN-LABEL  "Check Cr."    
txmm600.tiblack COLUMN-LABEL  "Status"       FORMAT "X(15)"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 118.67 BY 15.48 ROW-HEIGHT-CHARS .62 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME frmain
     ri_sort AT ROW 3.91 COL 11.67 NO-LABEL
     to_over AT ROW 7.48 COL 24.33
     fi_agenfr AT ROW 3.29 COL 54.5 COLON-ALIGNED NO-LABEL
     fi_agento AT ROW 4.76 COL 54.5 COLON-ALIGNED NO-LABEL
     fi_branfr AT ROW 3.29 COL 100.67 COLON-ALIGNED NO-LABEL
     fi_branto AT ROW 4.76 COL 100.67 COLON-ALIGNED NO-LABEL
     bu_check AT ROW 7.14 COL 58.67
     br_xmm600 AT ROW 8.86 COL 1.83
     fi_output AT ROW 25.57 COL 20.17 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 25.48 COL 74.83
     nv_reset AT ROW 7.14 COL 77.33
     bu_exit AT ROW 25.48 COL 93.5
     "To :" VIEW-AS TEXT
          SIZE 5 BY .62 AT ROW 4.91 COL 48.83
          BGCOLOR 34 FGCOLOR 1 FONT 2
     "Show :" VIEW-AS TEXT
          SIZE 6.5 BY .95 AT ROW 7.43 COL 17.33
          BGCOLOR 20 
     "                                    QUERY  CREDIT LIMIT" VIEW-AS TEXT
          SIZE 120.5 BY 1.52 AT ROW 1.05 COL 1.33
          BGCOLOR 1 FGCOLOR 35 FONT 2
     "From :" VIEW-AS TEXT
          SIZE 9 BY .95 AT ROW 3.29 COL 46.17
          BGCOLOR 34 FGCOLOR 1 FONT 2
     " Output :" VIEW-AS TEXT
          SIZE 12.5 BY .95 AT ROW 25.62 COL 8.17
          BGCOLOR 18 FGCOLOR 15 FONT 2
     "  BY :" VIEW-AS TEXT
          SIZE 7.5 BY .76 AT ROW 3.1 COL 1
          BGCOLOR 34 FGCOLOR 1 FONT 6
     "  Branch :" VIEW-AS TEXT
          SIZE 11 BY .76 AT ROW 3.05 COL 78
          BGCOLOR 18 FGCOLOR 34 FONT 6
     "  Agent :" VIEW-AS TEXT
          SIZE 9.5 BY .76 AT ROW 3 COL 33.83
          BGCOLOR 18 FGCOLOR 34 FONT 6
     "To :" VIEW-AS TEXT
          SIZE 5 BY .62 AT ROW 4.91 COL 94.67
          BGCOLOR 34 FGCOLOR 1 FONT 2
     "From :" VIEW-AS TEXT
          SIZE 9 BY .95 AT ROW 3.33 COL 92
          BGCOLOR 34 FGCOLOR 1 FONT 2
     RecOK AT ROW 7.95 COL 41.17
     RecOK-4 AT ROW 6.48 COL 1
     bg AT ROW 2.62 COL 34
     bg-2 AT ROW 2.62 COL 1.17
     RecOK-5 AT ROW 6.86 COL 57.83
     bg-3 AT ROW 24.57 COL 1
     RecOK-6 AT ROW 25.19 COL 92.67
     RecOK-7 AT ROW 6.86 COL 76.5
     RecOK-8 AT ROW 25.19 COL 74
     bg-4 AT ROW 25.19 COL 7.5
     RecOK-9 AT ROW 2.62 COL 78
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 120.83 BY 26.48.


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
         HEIGHT             = 26.43
         WIDTH              = 120
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
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME frmain
   FRAME-NAME Custom                                                    */
/* BROWSE-TAB br_xmm600 bu_check frmain */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_xmm600
/* Query rebuild information for BROWSE br_xmm600
     _START_FREEFORM
OPEN QUERY br_xmm600 FOR EACH txmm600  NO-LOCK
     BY txmm600.thomebr  .
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE br_xmm600 */
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


&Scoped-define SELF-NAME bu_check
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_check C-Win
ON CHOOSE OF bu_check IN FRAME frmain /* Check */
DO:
 /* IF ri_sort   = 1  OR ri_sort   = 2 OR  fi_agenfr = "" THEN DO: 
       MESSAGE " ** Please Enter Producer From. ** " VIEW-AS ALERT-BOX.
       APPLY "ENTRY" TO fi_agenfr IN FRAM frmain.
       RETURN NO-APPLY.
  END.*/
/*
  IF SUBSTR(fi_agenfr,1,2) <> "A0" THEN DO:
     MESSAGE " ** Please check Producer From. ** " VIEW-AS ALERT-BOX.
     APPLY "ENTRY" TO fi_agenfr IN FRAM frmain.
     RETURN NO-APPLY.
  END.

  IF fi_agento = "" THEN DO: 
     MESSAGE " ** Please Enter Producer To. ** " VIEW-AS ALERT-BOX.
     APPLY "ENTRY" TO fi_agento IN FRAM frmain.
     RETURN NO-APPLY.
  END.

  IF SUBSTR(fi_agento,1,2) <> "Bz" THEN DO:
     MESSAGE " ** Please check Producer To. ** " VIEW-AS ALERT-BOX.
     APPLY "ENTRY" TO fi_agento IN FRAM frmain.
     RETURN NO-APPLY.
  END.*/

  IF SUBSTR(fi_agenfr,1,1) <> "A" AND
     SUBSTR(fi_agenfr,1,1) <> "B" THEN DO:
     MESSAGE " ** Please check Producer From. ** " VIEW-AS ALERT-BOX.
     APPLY "ENTRY" TO fi_agenfr IN FRAM frmain.
     RETURN NO-APPLY.
  END.
  IF SUBSTR(fi_agento,1,1) <> "A" AND
     SUBSTR(fi_agento,1,1) <> "B" THEN DO:
     MESSAGE " ** Please check Producer To. ** " VIEW-AS ALERT-BOX.
     APPLY "ENTRY" TO fi_agento IN FRAM frmain.
     RETURN NO-APPLY.
  END.

  
  /*IF  ri_sort = 4 THEN DO:*/ /*A61-0035*/
        
   /*  IF LENGTH(n_User)      = 6   AND 
        SUBSTR(n_User,6,1) <> "0" AND
        fi_branfr          <> SUBSTR(n_User,6,1) AND
        fi_branto          <> SUBSTR(n_User,6,1) THEN DO:
        MESSAGE " ** Please check Branch From. ** " VIEW-AS ALERT-BOX.
        APPLY "ENTRY" TO fi_branfr IN FRAM frmain.
        RETURN NO-APPLY.
     END.
     
     IF LENGTH(n_User) <> 6  AND
        fi_branfr      <> SUBSTR(n_User,6,2) AND   
        fi_branto      <> SUBSTR(n_User,6,2) THEN DO:
        MESSAGE " ** Please check Branch From. ** " VIEW-AS ALERT-BOX.
        APPLY "ENTRY" TO fi_branfr IN FRAM frmain.
        RETURN NO-APPLY.
     END. */ 

     IF fi_branfr = "" THEN DO: 
       MESSAGE " ** Please Enter Branch From. ** " VIEW-AS ALERT-BOX.
       APPLY "ENTRY" TO fi_branfr IN FRAM frmain.
       RETURN NO-APPLY.
     END.

     IF fi_branto = "" THEN DO: 
       MESSAGE " ** Please Enter Branch To. ** " VIEW-AS ALERT-BOX.
       APPLY "ENTRY" TO fi_branto IN FRAM frmain.
       RETURN NO-APPLY.
     END.

 /* END.  */ /*A61-0035*/

  FOR EACH txmm600 :
      DELETE  txmm600 .
  END.

/*  OPEN QUERY br_xmm600 FOR EACH txmm600 NO-LOCK .*/

 /* FIND LAST agtprm_fil USE-INDEX by_acno WHERE agtprm_fil.asdat = 1/10/2000 NO-LOCK NO-ERROR.*/   /*A61-0035*/
  FIND LAST agtprm_fil USE-INDEX by_acno WHERE agtprm_fil.asdat = 1/10/2000 NO-LOCK NO-ERROR.      /*A61-0035*/
  IF AVAIL agtprm_fil  THEN nv_asdat = agtprm_fil.startdat .

  RUN PD_qurey .
  
  OPEN QUERY br_xmm600 FOR EACH txmm600 NO-LOCK.
  /*BY txmm600.thomebr .*/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit C-Win
ON CHOOSE OF bu_exit IN FRAME frmain /* Exit */
DO:

  RUN  wac\wacdisfn .
  APPLY "CLOSE" TO THIS-PROCEDURE.
    RETURN NO-APPLY.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok C-Win
ON CHOOSE OF bu_ok IN FRAME frmain /* OK */
DO:
  IF fi_output = "" THEN DO: 
     MESSAGE " ** Please Enter Output. ** " VIEW-AS ALERT-BOX.
     APPLY "ENTRY" TO fi_output IN FRAM frmain.
     RETURN NO-APPLY.
  END.

    IF ri_sort = 1  THEN nv_sort = "Group" .
    IF ri_sort = 2  THEN nv_sort = "Producer" .
    IF ri_sort = 3  THEN nv_sort = "All"  .
    IF ri_sort = 4  THEN nv_sort = "Branch"  .

  MESSAGE "*-- QUERY CREDIT LIMIT --* "  SKIP(1)
          "เรียกข้อมูล BY : " nv_sort  
  VIEW-AS ALERT-BOX QUESTION  BUTTONS YES-NO

  UPDATE CHOICE AS LOGICAL.
  CASE CHOICE:
     WHEN TRUE THEN DO:

       RUN PD_export .

       MESSAGE ".. Complete .."  VIEW-AS ALERT-BOX.

     END.

     WHEN FALSE THEN DO:
     RETURN NO-APPLY.
     END.

  END CASE.
  
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agenfr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agenfr C-Win
ON RETURN OF fi_agenfr IN FRAME frmain
DO:
    ASSIGN  fi_agenfr = INPUT fi_agenfr
            nv_agenfr = fi_agenfr 
            fi_agento  = fi_agenfr.

  DISP fi_agenfr fi_agento WITH FRAM frmain.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agento
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agento C-Win
ON RETURN OF fi_agento IN FRAME frmain
DO:
  
  ASSIGN
  fi_agento = INPUT fi_agento
  nv_agento = fi_agento.

  DISP fi_agento WITH FRAM frmain.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_branfr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_branfr C-Win
ON RETURN OF fi_branfr IN FRAME frmain
DO:

  ASSIGN  fi_branfr = INPUT fi_branfr .
  DISP fi_branfr  WITH FRAM frmain.


/*  IF LENGTH(n_User) = 6 AND 
     SUBSTR(n_User,6,1) <> "0" THEN DO: 
      ASSIGN
      fi_branfr = SUBSTR(n_User,6,1) 
      fi_branto = SUBSTR(n_User,6,1) .
  END.

  IF LENGTH(n_User) <> 6  THEN DO: 
      ASSIGN
      fi_branfr = SUBSTR(n_User,6,2) 
      fi_branto = SUBSTR(n_User,6,2) .
  END.  */


 /* ELSE n_lbran = SUBSTR(n_User,6,2).*/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_branto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_branto C-Win
ON RETURN OF fi_branto IN FRAME frmain
DO:
  
  ASSIGN
  fi_branto = INPUT fi_branto .

  DISP fi_branto WITH FRAM frmain.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_output
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_output C-Win
ON LEAVE OF fi_output IN FRAME frmain
DO:
    
    ASSIGN
  fi_output = INPUT fi_output
  nv_output = fi_output .
  

  DISP fi_output WITH FRAM frmain.

      

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME nv_reset
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL nv_reset C-Win
ON CHOOSE OF nv_reset IN FRAME frmain /* Reset */
DO:

  ASSIGN 

      fi_agenfr = "A000000"
      fi_agento = "Bzzzzzz"
      ri_sort   = 1
      TO_over   = NO
      fi_branfr = "0"
      fi_branto = "0" .

 /* ENABLE  fi_agenfr  fi_agento   ri_sort  TO_over WITH FRAME frmain .
  DISABLE fi_branfr  fi_branto   WITH FRAME frmain .*/
  DISP    fi_agenfr  fi_agento   ri_sort  TO_over fi_branfr  fi_branto 
  WITH FRAM frmain.

  FOR EACH txmm600 :
     DELETE  txmm600 .
  END.

  OPEN QUERY br_xmm600 FOR EACH txmm600 NO-LOCK .


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ri_sort
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ri_sort C-Win
ON VALUE-CHANGED OF ri_sort IN FRAME frmain
DO:
  
    ri_sort = INPUT ri_sort.
    DISP ri_sort WITH FRAME frmain .

   /* comment by A61-0035......
   IF  ri_sort = 1 OR ri_sort = 2 THEN DO:

        ENABLE  fi_agenfr fi_agento  WITH FRAME frmain .
        DISABLE fi_branfr fi_branto  WITH FRAME frmain . 
        DISP fi_agenfr fi_agento fi_branfr fi_branto WITH FRAME frmain . 
    END.

    IF  ri_sort = 3 THEN DO:
       
        DISABLE fi_agenfr fi_agento fi_branfr fi_branto WITH FRAME frmain . 
        DISP fi_agenfr fi_agento fi_branfr fi_branto WITH FRAME frmain . 
    END.

    IF  ri_sort = 4 THEN DO:
        IF LENGTH(n_User) = 6 AND 
           SUBSTR(n_User,6,1) <> "0" THEN DO: 
            ASSIGN
            fi_branfr = SUBSTR(n_User,6,1) 
            fi_branto = SUBSTR(n_User,6,1) .
        END.
       
        IF LENGTH(n_User) <> 6  THEN DO: 
            ASSIGN
            fi_branfr = SUBSTR(n_User,6,2) 
            fi_branto = SUBSTR(n_User,6,2) .
        END.

        ENABLE fi_agenfr fi_agento fi_branfr fi_branto WITH FRAME frmain .
        DISP fi_agenfr fi_agento fi_branfr fi_branto WITH FRAME frmain . 
    END.
    end A61-0035......*/


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME to_over
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL to_over C-Win
ON VALUE-CHANGED OF to_over IN FRAME frmain /* Over */
DO:
  ASSIGN TO_over = INPUT TO_over.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_xmm600
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
ON END-KEY    UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:

    SESSION:DATA-ENTRY-RETURN = YES.

   DEF VAR gv_prog  AS CHAR FORMAT "x(30)".
   DEF VAR gv_prgid AS CHAR FORMAT "x(15)".
   
   gv_prgid = "WACQCLMT".
   gv_prog  = "QUERY CREDIT CONTROL".
   RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).
   RUN  wac\wacconfn .

   DISABLE  fi_branfr fi_branto WITH FRAME frmain . 
   DISP     fi_branfr fi_branto WITH FRAME frmain . 

   FOR EACH txmm600: 
      DELETE txmm600.
   END.


  IF NOT CAN-FIND (FIRST xmm600) THEN DO:
     RETURN NO-APPLY.
  END.
  ELSE DO:

      ASSIGN
      ri_sort   = 1
      fi_agenfr = "A000000"
      fi_agento = "Bzzzzzz"
      fi_branfr = "0"   /*A61-0035*/
      fi_branto = "Z".  /*A61-0035*/
  END.
  
  SESSION:DATA-ENTRY-RETURN = YES.

  RUN enable_UI.

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
  DISPLAY ri_sort to_over fi_agenfr fi_agento fi_branfr fi_branto fi_output 
      WITH FRAME frmain IN WINDOW C-Win.
  ENABLE ri_sort to_over fi_agenfr fi_agento fi_branfr fi_branto bu_check 
         br_xmm600 fi_output bu_ok nv_reset bu_exit RecOK RecOK-4 bg bg-2 
         RecOK-5 bg-3 RecOK-6 RecOK-7 RecOK-8 bg-4 RecOK-9 
      WITH FRAME frmain IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frmain}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_export C-Win 
PROCEDURE PD_export :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
nv_output = nv_output + ".slk".
OUTPUT TO VALUE(nv_output) .
EXPORT DELIMITER "|"
    "*-- QUERY CREDIT LIMIT --*" .
EXPORT DELIMITER "|"  .
EXPORT DELIMITER "|"
    "AS AT  " STRING (TODAY,"99/99/9999") FORMAT "X(10)" " "  
    STRING(TIME,"HH:MM:SS")    .
EXPORT DELIMITER "|"  .
EXPORT DELIMITER "|"

    "BRANCH"
    "GROUP"        
    "PRODUCER"     
    "NAME"
    "CREDIT"       
    "AMOUNT"       
    "CHECK CREDIT" 
    "STATUS"   . 

IF ri_sort = 1 THEN DO:  /* Group */
    IF TO_over = NO THEN DO:

        FOR EACH txmm600  WHERE 
                 txmm600.tgpstm  >= fi_agenfr AND      
                 txmm600.tgpstm  <= fi_agento AND 
                 txmm600.thomebr >= fi_branfr AND      /*a61-0035*/
                 txmm600.thomebr <= fi_branto NO-LOCK  /*a61-0035*/ 
        BREAK BY txmm600.thomebr
              BY txmm600.tgpstm 
              BY txmm600.tacno  .
        
        EXPORT DELIMITER "|"
               txmm600.thomebr  
               txmm600.tgpstm   
               txmm600.tacno    
               txmm600.tname
               txmm600.tcrlmt   
               txmm600.tcramt   
               txmm600.tcrcon   
               txmm600.tiblack   .
        END.
    END.
    ELSE DO:
         FOR EACH txmm600  WHERE 
                 txmm600.tgpstm  >= fi_agenfr AND      
                 txmm600.tgpstm  <= fi_agento AND 
                 txmm600.thomebr >= fi_branfr AND      /*a61-0035*/
                 txmm600.thomebr <= fi_branto NO-LOCK  /*a61-0035*/ 
        BREAK BY txmm600.thomebr
              BY txmm600.tgpstm 
              BY txmm600.tacno  .

         IF txmm600.tiblack <> "OverCredit" THEN NEXT.
        
        EXPORT DELIMITER "|"
               txmm600.thomebr  
               txmm600.tgpstm   
               txmm600.tacno    
               txmm600.tname
               txmm600.tcrlmt   
               txmm600.tcramt   
               txmm600.tcrcon   
               txmm600.tiblack   .
        END.
    END.
END.      

IF ri_sort = 2 THEN DO:  /* Producer */

    IF TO_over = NO THEN DO:

        FOR EACH txmm600  WHERE 
                 txmm600.tacno   >= fi_agenfr AND      
                 txmm600.tacno   <= fi_agento AND 
                 txmm600.thomebr >= fi_branfr AND      /*a61-0035*/
                 txmm600.thomebr <= fi_branto NO-LOCK  /*a61-0035*/
        BREAK BY txmm600.thomebr
              BY txmm600.tgpstm 
              BY txmm600.tacno  .
    
        EXPORT DELIMITER "|"
               txmm600.thomebr
               txmm600.tgpstm    
               txmm600.tacno     
               txmm600.tname
               txmm600.tcrlmt    
               txmm600.tcramt    
               txmm600.tcrcon    
               txmm600.tiblack   .
        END.
    END.
    ELSE DO:
        FOR EACH txmm600  WHERE 
                 txmm600.tacno   >= fi_agenfr AND      
                 txmm600.tacno   <= fi_agento AND 
                 txmm600.thomebr >= fi_branfr AND      /*a61-0035*/
                 txmm600.thomebr <= fi_branto NO-LOCK  /*a61-0035*/ 
        BREAK BY txmm600.thomebr
              BY txmm600.tgpstm 
              BY txmm600.tacno.

        IF txmm600.tiblack <> "OverCredit" THEN NEXT.
        
        EXPORT DELIMITER "|"
               txmm600.thomebr
               txmm600.tgpstm    
               txmm600.tacno     
               txmm600.tname
               txmm600.tcrlmt    
               txmm600.tcramt    
               txmm600.tcrcon    
               txmm600.tiblack   .
        END.
    END.
END.     
/* comment by A61-0035  30/08/2018 ............
IF ri_sort = 3 THEN DO:  /* All */

    IF TO_over = NO THEN DO:

        FOR EACH txmm600 NO-LOCK
        BREAK BY txmm600.thomebr
              BY txmm600.tacno .
       
        EXPORT DELIMITER "|"
               txmm600.thomebr
               txmm600.tgpstm    
               txmm600.tacno     
               txmm600.tname     
               txmm600.tcrlmt    
               txmm600.tcramt    
               txmm600.tcrcon    
               txmm600.tiblack   .
        END.
    END.
    ELSE DO:
         FOR EACH txmm600 NO-LOCK
         BREAK BY txmm600.thomebr
               BY txmm600.tacno .

         IF txmm600.tiblack <> "OverCredit"  THEN NEXT.
       
        EXPORT DELIMITER "|"
               txmm600.thomebr
               txmm600.tgpstm    
               txmm600.tacno     
               txmm600.tname     
               txmm600.tcrlmt    
               txmm600.tcramt    
               txmm600.tcrcon    
               txmm600.tiblack   .
        END.
    END.
END. 

IF ri_sort = 4 THEN DO: /* Branch */

    IF TO_over = NO THEN DO:

        FOR EACH txmm600  WHERE 
                 txmm600.tacno   >= fi_agenfr AND      
                 txmm600.tacno   <= fi_agento AND
                 txmm600.thomebr >= fi_branfr AND
                 txmm600.thomebr <= fi_branto NO-LOCK 
        BREAK BY txmm600.thomebr
              BY txmm600.tgpstm 
              BY txmm600.tacno  .
    
        EXPORT DELIMITER "|"
               txmm600.thomebr
               txmm600.tgpstm    
               txmm600.tacno     
               txmm600.tname
               txmm600.tcrlmt    
               txmm600.tcramt    
               txmm600.tcrcon    
               txmm600.tiblack   .
        END.
    END.
    ELSE DO:
        FOR EACH txmm600  WHERE 
                 txmm600.tacno   >= fi_agenfr AND      
                 txmm600.tacno   <= fi_agento AND
                 txmm600.thomebr >= fi_branfr AND
                 txmm600.thomebr <= fi_branto NO-LOCK 
        BREAK BY txmm600.thomebr
              BY txmm600.tgpstm 
              BY txmm600.tacno.

        IF txmm600.tiblack <> "OverCredit" THEN NEXT.
        
        EXPORT DELIMITER "|"
               txmm600.thomebr
               txmm600.tgpstm    
               txmm600.tacno     
               txmm600.tname
               txmm600.tcrlmt    
               txmm600.tcramt    
               txmm600.tcrcon    
               txmm600.tiblack   .
        END.
    END.
END.  
.... end A61-0035...*/   





END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_qurey C-Win 
PROCEDURE PD_qurey :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:     
------------------------------------------------------------------------------*/
 /*-- create by : A61-0035 --*/ 
IF ri_sort  = 1     AND
   fi_agenfr <> ""  AND 
   fi_agento <> ""  THEN DO:

    IF TO_over = NO THEN DO:

        FOR EACH xmm600 USE-INDEX xmm60009 WHERE 
                 xmm600.gpstmt >= fi_agenfr AND      
                 xmm600.gpstmt <= fi_agento AND
                 xmm600.homebr >= fi_branfr AND     
                 xmm600.homebr <= fi_branto NO-LOCK.

            DISP "Please wait! for Process Data.."
            WITH COLOR BLACK/WHITE NO-LABEL TITLE "Check Credit Limit..." FRAME frproc1 VIEW-AS DIALOG-BOX.
        
            CREATE   txmm600 .
            ASSIGN   tgpstm    = xmm600.gpstmt
                     tacno     = xmm600.acno
                     tname     = xmm600.NAME
                     thomebr   = xmm600.homebr
                     tcrlmt    = xmm600.ltamt
                     tcrcon    = xmm600.crcon
                     tiblack   = xmm600.iblack
                     tname     = xmm600.NAME .

            DISP "Check Data Amount : " xmm600.acno 
            WITH COLOR BLACK/WHITE NO-LABEL TITLE "Check Credit Limit..." FRAME frproc1 VIEW-AS DIALOG-BOX.
        
            FIND FIRST agtprm_fil USE-INDEX by_acno WHERE 
                       /*agtprm_fil.asdat    = 1/10/2000   AND*/ /*A61-0035 */
                       /*agtprm_fil.policy   = xmm600.acno AND*/ /*A61-0035*/
                       agtprm_fil.asdat    = 1/11/2000   AND  /*A61-0035 */
                       agtprm_fil.acno     = xmm600.acno AND  /*A61-0035*/
                       agtprm_fil.startdat = nv_asdat    NO-LOCK NO-ERROR.
            IF AVAIL agtprm_fil THEN DO:
                ASSIGN   tcramt = agtprm_fil.bal .
            END.
        END.
        
    END.
    ELSE DO:
        FOR EACH xmm600 USE-INDEX xmm60009 WHERE 
                 xmm600.gpstmt >= fi_agenfr AND      
                 xmm600.gpstmt <= fi_agento AND
                 xmm600.homebr >= fi_branfr AND     
                 xmm600.homebr <= fi_branto NO-LOCK.

                IF xmm600.homebr < fi_branfr AND xmm600.homebr > fi_branto THEN NEXT.
                IF xmm600.iblack <> "OverCredit" THEN NEXT.
            
                DISP "Please wait! for Process Data.."
                WITH COLOR BLACK/WHITE NO-LABEL TITLE "Check Credit Limit..." FRAME frproc2 VIEW-AS DIALOG-BOX.
            
            CREATE   txmm600 .
            ASSIGN   tgpstm    = xmm600.gpstmt
                     tacno     = xmm600.acno
                     tname     = xmm600.NAME
                     thomebr   = xmm600.homebr
                     tcrlmt    = xmm600.ltamt
                     tcrcon    = xmm600.crcon
                     tiblack   = xmm600.iblack
                     tname     = xmm600.NAME .
            
            DISP "Check Data Amount : " xmm600.acno 
            WITH COLOR BLACK/WHITE NO-LABEL TITLE "Check Credit Limit..." FRAME frproc2 VIEW-AS DIALOG-BOX.
        
            FIND FIRST agtprm_fil USE-INDEX by_acno WHERE 
                       /*agtprm_fil.asdat    = 1/10/2000   AND*/ 
                       /*agtprm_fil.policy   = xmm600.acno AND*/ /*A61-0035*/
                       agtprm_fil.asdat    = 1/11/2000   AND  /*A61-0035 */
                       agtprm_fil.acno     = xmm600.acno AND  /*A61-0035*/
                       agtprm_fil.startdat = nv_asdat    NO-LOCK NO-ERROR.
            IF AVAIL agtprm_fil THEN DO:
                ASSIGN   tcramt = agtprm_fil.bal .
            END.
        END.
    END.
END. 

IF ri_sort    = 2   AND
   fi_agenfr <> ""  AND 
   fi_agento <> ""  THEN DO :

    IF TO_over = NO THEN DO:

        FOR EACH xmm600 USE-INDEX xmm60001 WHERE 
                 xmm600.acno   >= fi_agenfr  AND      
                 xmm600.acno   <= fi_agento  AND
                 xmm600.homebr >= fi_branfr  AND     
                 xmm600.homebr <= fi_branto  NO-LOCK. 

            DISP "Please wait! for Process Data.."
            WITH COLOR BLACK/WHITE NO-LABEL TITLE "Check Credit Limit..." FRAME frproc3 VIEW-AS DIALOG-BOX.
                                           
            CREATE   txmm600 .
            ASSIGN   tgpstm    = xmm600.gpstmt
                     tacno     = xmm600.acno
                     thomebr   = xmm600.homebr
                     tcrlmt    = xmm600.ltamt
                     tcrcon    = xmm600.crcon
                     tiblack   = xmm600.iblack
                     tname     = xmm600.NAME .
        
            DISP "Check Data Amount : " xmm600.acno 
            WITH COLOR BLACK/WHITE NO-LABEL TITLE "Check Credit Limit..." FRAME frproc3 VIEW-AS DIALOG-BOX.
        
            FIND FIRST agtprm_fil USE-INDEX by_acno WHERE 
                       /*agtprm_fil.asdat    = 1/10/2000   AND*/ /*A61-0035 */
                       /*agtprm_fil.policy   = xmm600.acno AND */ /*a61-0035*/
                       agtprm_fil.asdat    = 1/11/2000   AND  /*A61-0035 */
                       agtprm_fil.acno     = xmm600.acno AND  /*A61-0035*/
                       agtprm_fil.startdat = nv_asdat    NO-LOCK NO-ERROR.
            IF AVAIL agtprm_fil THEN DO:
                ASSIGN   tcramt = agtprm_fil.bal .
            END.
        END.
    END.
    ELSE DO:

        FOR EACH xmm600 USE-INDEX xmm60001 WHERE 
                 xmm600.acno   >= fi_agenfr  AND      
                 xmm600.acno   <= fi_agento  AND
                 xmm600.homebr >= fi_branfr  AND     
                 xmm600.homebr <= fi_branto  NO-LOCK. 

            IF xmm600.iblack <> "OverCredit" THEN NEXT.

            DISP "Please wait! for Process Data.." xmm600.acno FORMAT "X(7)"
            WITH COLOR BLACK/WHITE NO-LABEL TITLE "Check Credit Limit..." FRAME frproc4 VIEW-AS DIALOG-BOX.
                                           
            CREATE   txmm600 .
            ASSIGN   tgpstm    = xmm600.gpstmt
                     tacno     = xmm600.acno
                     thomebr   = xmm600.homebr
                     tcrlmt    = xmm600.ltamt
                     tcrcon    = xmm600.crcon
                     tiblack   = xmm600.iblack
                     tname     = xmm600.NAME .
        
            DISP "Check Data Amount : " xmm600.acno 
            WITH COLOR BLACK/WHITE NO-LABEL TITLE "Check Credit Limit..." FRAME frproc4 VIEW-AS DIALOG-BOX.
        
            FIND FIRST agtprm_fil USE-INDEX by_acno WHERE 
                       /*agtprm_fil.asdat    = 1/10/2000   AND */ /*A61-0035*/
                       /*agtprm_fil.policy   = xmm600.acno AND */ /*a61-0035*/
                       agtprm_fil.asdat    = 1/11/2000   AND   /*A61-0035 */
                       agtprm_fil.acno     = xmm600.acno AND  /*A61-0035*/
                       agtprm_fil.startdat = nv_asdat    NO-LOCK NO-ERROR.
            IF AVAIL agtprm_fil THEN DO:
                ASSIGN   tcramt = agtprm_fil.bal .
            END.
        END.
    END.
END.

/*IF ri_sort = 3 THEN DO :

    FOR EACH agtprm_fil WHERE 
             agtprm_fil.asdat    = 1/10/2000  AND
             agtprm_fil.startdat = nv_asdat   NO-LOCK .

        IF TO_over = NO THEN DO:
            DISP "Please wait! for Process Data.."
            WITH COLOR BLACK/WHITE NO-LABEL TITLE "Check Credit Limit..." FRAME frproc5 VIEW-AS DIALOG-BOX.

            FIND FIRST xmm600 WHERE xmm600.acno = agtprm_fil.policy NO-LOCK NO-ERROR.
            IF AVAIL xmm600 THEN DO:
               CREATE txmm600 .
               ASSIGN tgpstm    = xmm600.gpstmt
                      tacno     = xmm600.acno
                      thomebr   = xmm600.homebr
                      tcrlmt    = xmm600.ltamt
                      tcrcon    = xmm600.crcon
                      tiblack   = xmm600.iblack 
                      tcramt    = agtprm_fil.bal 
                      tname     = xmm600.NAME.
             END.
        END. 
        ELSE DO:
            FIND FIRST xmm600 WHERE xmm600.acno = agtprm_fil.policy NO-LOCK NO-ERROR.
            IF AVAIL xmm600 THEN DO:

               IF xmm600.iblack <> "OverCredit"  THEN NEXT.

               DISP "Please wait! for Process Data.."
            WITH COLOR BLACK/WHITE NO-LABEL TITLE "Check Credit Limit..." FRAME frproc6 VIEW-AS DIALOG-BOX.

               CREATE txmm600 .
               ASSIGN tgpstm    = xmm600.gpstmt
                      tacno     = xmm600.acno
                      thomebr   = xmm600.homebr
                      tcrlmt    = xmm600.ltamt
                      tcrcon    = xmm600.crcon
                      tiblack   = xmm600.iblack 
                      tcramt    = agtprm_fil.bal 
                      tname     = xmm600.NAME.
            END.
        END.
    END.
END.

IF ri_sort    = 4   THEN DO :

    IF TO_over = NO THEN DO:

        FOR EACH xmm600 USE-INDEX xmm60001 WHERE 
                 xmm600.acno    >= fi_agenfr AND      
                 xmm600.acno    <= fi_agento AND
                 xmm600.homebr  >= fi_branfr AND 
                 xmm600.homebr  <= fi_branto NO-LOCK. 

            DISP "Please wait! for Process Data.."
            WITH COLOR BLACK/WHITE NO-LABEL TITLE "Check Credit Limit..." FRAME frproc7 VIEW-AS DIALOG-BOX. 
                                           
            CREATE   txmm600 .
            ASSIGN   tgpstm    = xmm600.gpstmt
                     tacno     = xmm600.acno
                     thomebr   = xmm600.homebr
                     tcrlmt    = xmm600.ltamt
                     tcrcon    = xmm600.crcon
                     tiblack   = xmm600.iblack
                     tname     = xmm600.NAME .
        
            FIND FIRST agtprm_fil WHERE 
                       agtprm_fil.asdat    = 1/10/2000  AND
                       agtprm_fil.startdat = nv_asdat   AND
                       agtprm_fil.policy   = xmm600.acno NO-LOCK NO-ERROR.
            IF AVAIL agtprm_fil THEN DO:
            ASSIGN   tcramt = agtprm_fil.bal .
            END.
        END.
    END.
    ELSE DO:

        FOR EACH xmm600 USE-INDEX xmm60001 WHERE 
                 xmm600.acno    >= fi_agenfr  AND      
                 xmm600.acno    <= fi_agento  AND
                 xmm600.homebr  >= fi_branfr  AND 
                 xmm600.homebr  <= fi_branto  NO-LOCK .

            IF xmm600.iblack <> "OverCredit" THEN NEXT.

            DISP "Please wait! for Process Data.."
            WITH COLOR BLACK/WHITE NO-LABEL TITLE "Check Credit Limit..." FRAME frproc8 VIEW-AS DIALOG-BOX.
                                           
            CREATE   txmm600 .
            ASSIGN   tgpstm    = xmm600.gpstmt
                     tacno     = xmm600.acno
                     thomebr   = xmm600.homebr
                     tcrlmt    = xmm600.ltamt
                     tcrcon    = xmm600.crcon
                     tiblack   = xmm600.iblack
                     tname     = xmm600.NAME .
        
            FIND FIRST agtprm_fil WHERE 
                       agtprm_fil.asdat    = 1/10/2000  AND
                       agtprm_fil.startdat = nv_asdat   AND
                       agtprm_fil.policy   = xmm600.acno NO-LOCK NO-ERROR.
            IF AVAIL agtprm_fil THEN DO:
            ASSIGN   tcramt = agtprm_fil.bal .
            END.
        END.
    END.
END.*/



   
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_qurey-01 C-Win 
PROCEDURE PD_qurey-01 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:      /*--A60-0358--- ปรับ Index ให้ถูกต้อง---*/ 
------------------------------------------------------------------------------*/
/*  comment a61-0035
IF ri_sort    = 1   AND
   fi_agenfr <> ""  AND 
   fi_agento <> ""  THEN DO : 
    IF TO_over = NO THEN DO:

        FOR EACH xmm600 USE-INDEX xmm60009 WHERE 
                 xmm600.gpstmt >= fi_agenfr AND      
                 xmm600.gpstmt <= fi_agento NO-LOCK. 

            DISP "Please wait! for Process Data.."
            WITH COLOR BLACK/WHITE NO-LABEL TITLE "Check Credit Limit..." FRAME frproc1 VIEW-AS DIALOG-BOX.
        
            CREATE   txmm600 .
            ASSIGN   tgpstm    = xmm600.gpstmt
                     tacno     = xmm600.acno
                     tname     = xmm600.NAME
                     thomebr   = xmm600.homebr
                     tcrlmt    = xmm600.ltamt
                     tcrcon    = xmm600.crcon
                     tiblack   = xmm600.iblack
                     tname     = xmm600.NAME .
        
            FIND FIRST agtprm_fil USE-INDEX by_acno WHERE 
                       agtprm_fil.asdat    = 1/10/2000  AND
                       agtprm_fil.startdat = nv_asdat   AND
                       agtprm_fil.policy   = xmm600.acno NO-LOCK NO-ERROR.
            IF AVAIL agtprm_fil THEN DO:
            ASSIGN   tcramt = agtprm_fil.bal .
            END.
        END.
    END.
    ELSE DO:
        FOR EACH xmm600 USE-INDEX xmm60009 WHERE 
                 xmm600.gpstmt >= fi_agenfr AND      
                 xmm600.gpstmt <= fi_agento NO-LOCK. 
            
                IF xmm600.iblack <> "OverCredit" THEN NEXT.
            
                DISP "Please wait! for Process Data.."
                WITH COLOR BLACK/WHITE NO-LABEL TITLE "Check Credit Limit..." FRAME frproc2 VIEW-AS DIALOG-BOX.
            
            CREATE   txmm600 .
            ASSIGN   tgpstm    = xmm600.gpstmt
                     tacno     = xmm600.acno
                     tname     = xmm600.NAME
                     thomebr   = xmm600.homebr
                     tcrlmt    = xmm600.ltamt
                     tcrcon    = xmm600.crcon
                     tiblack   = xmm600.iblack
                     tname     = xmm600.NAME .
            
            FIND FIRST agtprm_fil WHERE 
                       agtprm_fil.asdat    = 1/10/2000  AND
                       agtprm_fil.startdat = nv_asdat   AND
                       agtprm_fil.policy   = xmm600.acno NO-LOCK NO-ERROR.
            IF AVAIL agtprm_fil THEN DO:
            ASSIGN   tcramt = agtprm_fil.bal .
            END.
        END.
    END.
END. 

IF ri_sort    = 2   AND
   fi_agenfr <> ""  AND 
   fi_agento <> ""  THEN DO :

    IF TO_over = NO THEN DO:

        FOR EACH xmm600 USE-INDEX xmm60001 WHERE 
                 xmm600.acno >= fi_agenfr  AND      
                 xmm600.acno <= fi_agento  NO-LOCK. 

            DISP "Please wait! for Process Data.."
            WITH COLOR BLACK/WHITE NO-LABEL TITLE "Check Credit Limit..." FRAME frproc3 VIEW-AS DIALOG-BOX.
                                           
            CREATE   txmm600 .
            ASSIGN   tgpstm    = xmm600.gpstmt
                     tacno     = xmm600.acno
                     thomebr   = xmm600.homebr
                     tcrlmt    = xmm600.ltamt
                     tcrcon    = xmm600.crcon
                     tiblack   = xmm600.iblack
                     tname     = xmm600.NAME .
        
            FIND FIRST agtprm_fil WHERE 
                       agtprm_fil.asdat    = 1/10/2000  AND
                       agtprm_fil.startdat = nv_asdat   AND
                       agtprm_fil.policy   = xmm600.acno NO-LOCK NO-ERROR.
            IF AVAIL agtprm_fil THEN DO:
            ASSIGN   tcramt = agtprm_fil.bal .
            END.
        END.
    END.
    ELSE DO:

        FOR EACH xmm600 USE-INDEX xmm60001 WHERE 
                 xmm600.acno >= fi_agenfr  AND      
                 xmm600.acno <= fi_agento  NO-LOCK. 

            IF xmm600.iblack <> "OverCredit" THEN NEXT.

            DISP "Please wait! for Process Data.." xmm600.acno FORMAT "X(7)"
            WITH COLOR BLACK/WHITE NO-LABEL TITLE "Check Credit Limit..." FRAME frproc4 VIEW-AS DIALOG-BOX.
                                           
            CREATE   txmm600 .
            ASSIGN   tgpstm    = xmm600.gpstmt
                     tacno     = xmm600.acno
                     thomebr   = xmm600.homebr
                     tcrlmt    = xmm600.ltamt
                     tcrcon    = xmm600.crcon
                     tiblack   = xmm600.iblack
                     tname     = xmm600.NAME .
        
            FIND FIRST agtprm_fil WHERE 
                       agtprm_fil.asdat    = 1/10/2000  AND
                       agtprm_fil.startdat = nv_asdat   AND
                       agtprm_fil.policy   = xmm600.acno NO-LOCK NO-ERROR.
            IF AVAIL agtprm_fil THEN DO:
            ASSIGN   tcramt = agtprm_fil.bal .
            END.
        END.
    END.
END.

IF ri_sort = 3 THEN DO :

    FOR EACH agtprm_fil WHERE 
             agtprm_fil.asdat    = 1/10/2000  AND
             agtprm_fil.startdat = nv_asdat   NO-LOCK .

        IF TO_over = NO THEN DO:
            DISP "Please wait! for Process Data.."
            WITH COLOR BLACK/WHITE NO-LABEL TITLE "Check Credit Limit..." FRAME frproc5 VIEW-AS DIALOG-BOX.

            FIND FIRST xmm600 WHERE xmm600.acno = agtprm_fil.policy NO-LOCK NO-ERROR.
            IF AVAIL xmm600 THEN DO:
               CREATE txmm600 .
               ASSIGN tgpstm    = xmm600.gpstmt
                      tacno     = xmm600.acno
                      thomebr   = xmm600.homebr
                      tcrlmt    = xmm600.ltamt
                      tcrcon    = xmm600.crcon
                      tiblack   = xmm600.iblack 
                      tcramt    = agtprm_fil.bal 
                      tname     = xmm600.NAME.
             END.
        END. 
        ELSE DO:
            FIND FIRST xmm600 WHERE xmm600.acno = agtprm_fil.policy NO-LOCK NO-ERROR.
            IF AVAIL xmm600 THEN DO:

               IF xmm600.iblack <> "OverCredit"  THEN NEXT.

               DISP "Please wait! for Process Data.."
            WITH COLOR BLACK/WHITE NO-LABEL TITLE "Check Credit Limit..." FRAME frproc6 VIEW-AS DIALOG-BOX.

               CREATE txmm600 .
               ASSIGN tgpstm    = xmm600.gpstmt
                      tacno     = xmm600.acno
                      thomebr   = xmm600.homebr
                      tcrlmt    = xmm600.ltamt
                      tcrcon    = xmm600.crcon
                      tiblack   = xmm600.iblack 
                      tcramt    = agtprm_fil.bal 
                      tname     = xmm600.NAME.
            END.
        END.
    END.
END.

IF ri_sort    = 4   THEN DO :

    IF TO_over = NO THEN DO:

        FOR EACH xmm600 USE-INDEX xmm60001 WHERE 
                 xmm600.acno    >= fi_agenfr AND      
                 xmm600.acno    <= fi_agento AND
                 xmm600.homebr  >= fi_branfr AND 
                 xmm600.homebr  <= fi_branto NO-LOCK. 

            DISP "Please wait! for Process Data.."
            WITH COLOR BLACK/WHITE NO-LABEL TITLE "Check Credit Limit..." FRAME frproc7 VIEW-AS DIALOG-BOX. 
                                           
            CREATE   txmm600 .
            ASSIGN   tgpstm    = xmm600.gpstmt
                     tacno     = xmm600.acno
                     thomebr   = xmm600.homebr
                     tcrlmt    = xmm600.ltamt
                     tcrcon    = xmm600.crcon
                     tiblack   = xmm600.iblack
                     tname     = xmm600.NAME .
        
            FIND FIRST agtprm_fil WHERE 
                       agtprm_fil.asdat    = 1/10/2000  AND
                       agtprm_fil.startdat = nv_asdat   AND
                       agtprm_fil.policy   = xmm600.acno NO-LOCK NO-ERROR.
            IF AVAIL agtprm_fil THEN DO:
            ASSIGN   tcramt = agtprm_fil.bal .
            END.
        END.
    END.
    ELSE DO:

        FOR EACH xmm600 USE-INDEX xmm60001 WHERE 
                 xmm600.acno    >= fi_agenfr  AND      
                 xmm600.acno    <= fi_agento  AND
                 xmm600.homebr  >= fi_branfr  AND 
                 xmm600.homebr  <= fi_branto  NO-LOCK .

            IF xmm600.iblack <> "OverCredit" THEN NEXT.

            DISP "Please wait! for Process Data.."
            WITH COLOR BLACK/WHITE NO-LABEL TITLE "Check Credit Limit..." FRAME frproc8 VIEW-AS DIALOG-BOX.
                                           
            CREATE   txmm600 .
            ASSIGN   tgpstm    = xmm600.gpstmt
                     tacno     = xmm600.acno
                     thomebr   = xmm600.homebr
                     tcrlmt    = xmm600.ltamt
                     tcrcon    = xmm600.crcon
                     tiblack   = xmm600.iblack
                     tname     = xmm600.NAME .
        
            FIND FIRST agtprm_fil WHERE 
                       agtprm_fil.asdat    = 1/10/2000  AND
                       agtprm_fil.startdat = nv_asdat   AND
                       agtprm_fil.policy   = xmm600.acno NO-LOCK NO-ERROR.
            IF AVAIL agtprm_fil THEN DO:
            ASSIGN   tcramt = agtprm_fil.bal .
            END.
        END.
    END.
END.
*/


   
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

