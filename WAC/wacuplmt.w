&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sicsyac          PROGRESS
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
         : Update Credit Limit .

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

DEF VAR nv_acstm  AS CHAR FORMAT "X(10)" .
DEF VAR nv_acstmt AS CHAR FORMAT "X(10)" .
DEF VAR nv_brf    AS CHAR FORMAT "X(3)" .
DEF VAR nv_brt    AS CHAR FORMAT "X(3)" .
DEF VAR n_acno    AS CHAR FORMAT "X(10)" .
DEF VAR logAns    AS LOGI INIT NO.

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
&Scoped-define INTERNAL-TABLES xmm600

/* Definitions for BROWSE br_xmm600                                     */
&Scoped-define FIELDS-IN-QUERY-br_xmm600 xmm600.gpstmt xmm600.acno ~
xmm600.homebr xmm600.name xmm600.ltamt xmm600.iblack xmm600.crcon 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_xmm600 
&Scoped-define QUERY-STRING-br_xmm600 FOR EACH xmm600 SHARE-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br_xmm600 OPEN QUERY br_xmm600 FOR EACH xmm600 SHARE-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br_xmm600 xmm600
&Scoped-define FIRST-TABLE-IN-QUERY-br_xmm600 xmm600


/* Definitions for FRAME frmain                                         */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS ri_sort fi_acstm fi_acstmt fi_br fi_brt ~
bu_check bu_reset bu_exit br_xmm600 bu_delete RecOK-4 bg bg-2 RecOK-5 ~
RecOK-11 RecOK-12 RecOK-13 fi_output bu_exp 
&Scoped-Define DISPLAYED-OBJECTS ri_sort fi_acstm fi_acstmt fi_br fi_brt ~
fi_output 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_check 
     LABEL "OK" 
     SIZE 15 BY 1.14
     FONT 2.

DEFINE BUTTON bu_delete 
     LABEL "Unlock" 
     SIZE 15 BY 1.14
     FONT 2.

DEFINE BUTTON bu_exit 
     LABEL "Exit" 
     SIZE 15 BY 1.14
     FONT 2.

DEFINE BUTTON bu_exp 
     LABEL "Export" 
     SIZE 11.5 BY 1.14
     FONT 2.

DEFINE BUTTON bu_reset 
     LABEL "Clear" 
     SIZE 15 BY 1.14
     FONT 2.

DEFINE VARIABLE fi_acstm AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_acstmt AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_br AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_brt AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 4.5 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_output AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 51 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE ri_sort AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Group ", 1,
"Producer ", 2
     SIZE 16.17 BY 2.71
     BGCOLOR 8 FGCOLOR 15 FONT 2 NO-UNDO.

DEFINE RECTANGLE bg
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 107 BY 3.62
     BGCOLOR 3 .

DEFINE RECTANGLE bg-2
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 25.83 BY 3.62
     BGCOLOR 8 .

DEFINE RECTANGLE RecOK-11
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 16.5 BY 1.67
     BGCOLOR 7 .

DEFINE RECTANGLE RecOK-12
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 16.5 BY 1.67
     BGCOLOR 6 .

DEFINE RECTANGLE RecOK-13
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 16.5 BY 1.67
     BGCOLOR 2 .

DEFINE RECTANGLE RecOK-4
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 133 BY 14.05
     BGCOLOR 1 .

DEFINE RECTANGLE RecOK-5
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 16.5 BY 1.67
     BGCOLOR 1 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_xmm600 FOR 
      xmm600 SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_xmm600
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_xmm600 C-Win _STRUCTURED
  QUERY br_xmm600 SHARE-LOCK NO-WAIT DISPLAY
      xmm600.gpstmt COLUMN-LABEL "   Grp Statement" FORMAT "x(10)":U
            WIDTH 15.83
      xmm600.acno COLUMN-LABEL "      Producer" FORMAT "x(10)":U
            WIDTH 16.67
      xmm600.homebr COLUMN-LABEL "BR" FORMAT "x(3)":U
      xmm600.name COLUMN-LABEL "      Name" FORMAT "x(30)":U WIDTH 33.83
      xmm600.ltamt FORMAT ">,>>>,>>>,>>>,>>9":U WIDTH 23.33 LABEL-FGCOLOR 1 LABEL-BGCOLOR 15 LABEL-FONT 1
      xmm600.iblack COLUMN-LABEL "Black List Code" FORMAT "x(15)":U
            COLUMN-FGCOLOR 12 COLUMN-BGCOLOR 10 COLUMN-FONT 6 LABEL-FGCOLOR 6 LABEL-FONT 6
      xmm600.crcon COLUMN-LABEL " Check Credit" FORMAT "yes/no":U
            WIDTH 12.83 COLUMN-FGCOLOR 2 COLUMN-BGCOLOR 15 COLUMN-FONT 1
            LABEL-FGCOLOR 2 LABEL-BGCOLOR 10 LABEL-FONT 6
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 129.5 BY 13.33
         BGCOLOR 15  ROW-HEIGHT-CHARS .7 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME frmain
     ri_sort AT ROW 3.1 COL 7.17 NO-LABEL WIDGET-ID 58
     fi_acstm AT ROW 3.14 COL 51.67 COLON-ALIGNED NO-LABEL WIDGET-ID 76
     fi_acstmt AT ROW 3.14 COL 77.5 COLON-ALIGNED NO-LABEL WIDGET-ID 108
     fi_br AT ROW 4.57 COL 51.5 COLON-ALIGNED NO-LABEL WIDGET-ID 110
     fi_brt AT ROW 4.57 COL 77.5 COLON-ALIGNED NO-LABEL WIDGET-ID 112
     bu_check AT ROW 3.76 COL 110.5 WIDGET-ID 4
     bu_reset AT ROW 21.14 COL 99.83 WIDGET-ID 16
     bu_exit AT ROW 21.1 COL 117.83 WIDGET-ID 52
     br_xmm600 AT ROW 6.52 COL 2.5 WIDGET-ID 200
     bu_delete AT ROW 21.1 COL 82.17 WIDGET-ID 102
     fi_output AT ROW 20.86 COL 12.17 COLON-ALIGNED NO-LABEL WIDGET-ID 120
     bu_exp AT ROW 20.86 COL 65.5 WIDGET-ID 122
     "  UNLOCK CODE OVER CREDIT CONTROL" VIEW-AS TEXT
          SIZE 49 BY 1.52 AT ROW 1.1 COL 47 WIDGET-ID 42
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "Group / Producer  From :" VIEW-AS TEXT
          SIZE 24 BY .95 AT ROW 3.19 COL 28 WIDGET-ID 78
          BGCOLOR 3 FGCOLOR 15 FONT 6
     "Output file:" VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 20.76 COL 2 WIDGET-ID 106
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "*** ปลดล็อกข้อมูล Over Credit ***" VIEW-AS TEXT
          SIZE 34 BY .95 AT ROW 22.29 COL 27 WIDGET-ID 124
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "Branch  From :" VIEW-AS TEXT
          SIZE 14.5 BY .95 AT ROW 4.57 COL 38 WIDGET-ID 114
          BGCOLOR 3 FGCOLOR 15 FONT 6
     "To :" VIEW-AS TEXT
          SIZE 4.5 BY .95 AT ROW 4.57 COL 74.17 WIDGET-ID 116
          BGCOLOR 3 FGCOLOR 15 FONT 6
     "To :" VIEW-AS TEXT
          SIZE 5 BY .95 AT ROW 3.19 COL 74.33 WIDGET-ID 118
          BGCOLOR 3 FGCOLOR 15 FONT 6
     RecOK-4 AT ROW 6.24 COL 1 WIDGET-ID 56
     bg AT ROW 2.62 COL 27 WIDGET-ID 62
     bg-2 AT ROW 2.62 COL 1.17 WIDGET-ID 64
     RecOK-5 AT ROW 3.48 COL 109.67 WIDGET-ID 66
     RecOK-11 AT ROW 20.86 COL 99.17 WIDGET-ID 98
     RecOK-12 AT ROW 20.81 COL 117 WIDGET-ID 100
     RecOK-13 AT ROW 20.86 COL 81.5 WIDGET-ID 104
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133.33 BY 22.81
         BGCOLOR 1  WIDGET-ID 100.


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
         TITLE              = "wacuplmt - Unlock Code for Credit Control"
         HEIGHT             = 23
         WIDTH              = 133.5
         MAX-HEIGHT         = 24.05
         MAX-WIDTH          = 133.5
         VIRTUAL-HEIGHT     = 24.05
         VIRTUAL-WIDTH      = 133.5
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
/* BROWSE-TAB br_xmm600 bu_exit frmain */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_xmm600
/* Query rebuild information for BROWSE br_xmm600
     _TblList          = "sicsyac.xmm600"
     _Options          = "SHARE-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   > sicsyac.xmm600.gpstmt
"xmm600.gpstmt" "   Grp Statement" "x(10)" "character" ? ? ? ? ? ? no ? no no "15.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > sicsyac.xmm600.acno
"xmm600.acno" "      Producer" "x(10)" "character" ? ? ? ? ? ? no ? no no "16.67" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > sicsyac.xmm600.homebr
"xmm600.homebr" "BR" "x(3)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > sicsyac.xmm600.name
"xmm600.name" "      Name" "x(30)" "character" ? ? ? ? ? ? no ? no no "33.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > sicsyac.xmm600.ltamt
"xmm600.ltamt" ? ? "decimal" ? ? ? 15 1 1 no ? no no "23.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > sicsyac.xmm600.iblack
"xmm600.iblack" "Black List Code" "x(15)" "character" 10 12 6 ? 6 6 no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > sicsyac.xmm600.crcon
"xmm600.crcon" " Check Credit" ? "logical" 15 2 1 10 2 6 no ? no no "12.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE br_xmm600 */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define BROWSE-NAME br_xmm600
&Scoped-define SELF-NAME br_xmm600
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_xmm600 C-Win
ON MOUSE-SELECT-DBLCLICK OF br_xmm600 IN FRAME frmain
DO:
  
  IF NOT CAN-FIND (FIRST xmm600 )THEN DO:
        RETURN NO-APPLY.
  END.

  ELSE DO:
        logAns = No.

        GET  CURRENT br_xmm600.
        n_acno  =  xmm600.acno.

        MESSAGE "ต้องการอัพเดทข้อมูล" SKIP(1)
              "Producer : " xmm600.acno     SKIP(1)
              "ให้มี Over Credit เป็นค่าว่าง หรือไม่ ?"
        UPDATE logAns 
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
        TITLE "Confirm CHANGE ".
        IF logAns THEN DO: 

            IF  xmm600.iblack  = "OverCredit" THEN DO:
                FOR EACH xmm600 USE-INDEX xmm60001 WHERE  
                         xmm600.acno    = n_acno  .
                   ASSIGN  xmm600.iblack  = "" .
                END.
                RUN ProcUpdateQ.
            END.
        END.    

        MESSAGE "Change Complete..." VIEW-AS ALERT-BOX INFORMATION. 
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_check
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_check C-Win
ON CHOOSE OF bu_check IN FRAME frmain /* OK */
DO:
 
    IF ri_sort = 1 THEN DO :
        IF nv_acstm = "" THEN DO:
           MESSAGE " ** Please Enter Group ** " VIEW-AS ALERT-BOX.
           APPLY "ENTRY" TO fi_acstm IN FRAM frmain.
           RETURN NO-APPLY.
        END.
        ELSE DO:
           OPEN QUERY br_xmm600 FOR EACH xmm600 USE-INDEX xmm60009 WHERE 
                                         xmm600.gpstmt >= fi_acstm  AND
                                         xmm600.gpstmt <= fi_acstmt AND
                                         xmm600.homebr >= fi_br     AND
                                         xmm600.homebr <= fi_brt    NO-LOCK.
           DISP br_xmm600 WITH FRAM frmain.
        END.

        IF fi_acstm <> xmm600.gpstmt  THEN DO :
           MESSAGE " ** Not Have This Group ** " VIEW-AS ALERT-BOX.
           APPLY "ENTRY" TO fi_acstm IN FRAM frmain.
        END.
    END.

    IF ri_sort = 2 THEN DO :
        DISABLE bu_delete . 
        DISP bu_delete WITH FRAM frmain.

        IF nv_acstm = "" THEN DO:
           MESSAGE " ** Please Enter Producer ** " VIEW-AS ALERT-BOX.
           APPLY "ENTRY" TO fi_acstm IN FRAM frmain.
           RETURN NO-APPLY.
        END.

        ELSE DO:
            OPEN QUERY br_xmm600 FOR EACH xmm600 USE-INDEX xmm60001 WHERE 
                                          xmm600.acno   >= fi_acstm  AND
                                          xmm600.acno   <= fi_acstmt AND
                                          xmm600.homebr >= fi_br     AND       
                                          xmm600.homebr <= fi_brt    NO-LOCK.  
            DISP br_xmm600 WITH FRAM frmain.
        END.
        
        IF fi_acstm <> xmm600.acno  THEN DO:
             MESSAGE " ** Not Have This Producer ** " VIEW-AS ALERT-BOX.
             APPLY "ENTRY" TO fi_acstm IN FRAM frmain.
        END.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_delete
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_delete C-Win
ON CHOOSE OF bu_delete IN FRAME frmain /* Unlock */
DO:
     IF ri_sort = 1 THEN DO:

      logAns = No.

      MESSAGE "Do you want to update Status ! " SKIP(1)
              "Group : " fi_acstm " - " fi_acstmt SKIP(1)
              "Branch: " fi_br " - " fi_brt 
      UPDATE logAns 
      VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
      TITLE "Confirm Unlocked ".
      IF logAns THEN DO:  

        FOR EACH xmm600 USE-INDEX xmm60009 WHERE 
                 xmm600.gpstmt  >= fi_acstm      AND
                 xmm600.gpstmt  <= fi_acstmt    AND
                 xmm600.homebr  >= fi_br        AND
                 xmm600.homebr  <= fi_brt       AND
                 xmm600.iblack  = "OverCredit"  AND 
                 xmm600.crcon   = YES  .
        
            ASSIGN xmm600.iblack  = "".  
        
        END.

      MESSAGE "Update complete..." VIEW-AS ALERT-BOX INFORMATION.  
      END.
      RUN ProcUpdateQ.
      
   END.
   ELSE DO:
        logAns = No.

      MESSAGE "Do you want to Unlocked Status ! " SKIP(1)
              "Producer  : " fi_acstm " - " fi_acstmt SKIP(1)
              "Branch: " fi_br " - " fi_brt 
      UPDATE logAns 
      VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
      TITLE "Confirm Unlocked ".
      IF logAns THEN DO: 
        FOR EACH xmm600 USE-INDEX xmm60001 WHERE 
                 xmm600.acno   >= fi_acstm  AND        
                 xmm600.acno   <= fi_acstmt AND        
                 xmm600.homebr >= fi_br     AND        
                 xmm600.homebr <= fi_brt    AND
                 xmm600.iblack  = "OverCredit"  AND 
                 xmm600.crcon   = YES  .
        
            ASSIGN xmm600.iblack  = "".  
        
        END.

      MESSAGE "Update complete..." VIEW-AS ALERT-BOX INFORMATION.  
      END.
      RUN ProcUpdateQ.
   END. 
        
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit C-Win
ON CHOOSE OF bu_exit IN FRAME frmain /* Exit */
DO:
    RUN  WAC\WACDISFN .

    APPLY "CLOSE" TO THIS-PROCEDURE.
    RETURN NO-APPLY.

  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exp C-Win
ON CHOOSE OF bu_exp IN FRAME frmain /* Export */
DO:
    IF fi_output = ""  THEN DO:
        MESSAGE "กรุณาระบุชื่อไฟล์ " VIEW-AS ALERT-BOX.
        APPLY "ENTRY" TO fi_output .
    END.
    ELSE DO: 
        RUN proc_expfile .
        MESSAGE "Export file complete " VIEW-AS ALERT-BOX.
    END.
     
   DISP  fi_output WITH FRAM frmain.

  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_reset
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_reset C-Win
ON CHOOSE OF bu_reset IN FRAME frmain /* Clear */
DO:

  ASSIGN 
      fi_acstm  = ""
      ri_sort   = 1  .
     
  DISP  fi_acstm   ri_sort  WITH FRAM frmain.

  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_acstm
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_acstm C-Win
ON LEAVE OF fi_acstm IN FRAME frmain
DO:
    ASSIGN
     fi_acstm   = CAPS(INPUT fi_acstm)
     fi_acstmt  = fi_acstm
     nv_acstm   = fi_acstm.

     DISP fi_acstm fi_acstmt WITH FRAM frmain.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_acstmt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_acstmt C-Win
ON LEAVE OF fi_acstmt IN FRAME frmain
DO:
    ASSIGN

     fi_acstmt = CAPS(INPUT fi_acstmt)
     nv_acstmt = fi_acstmt.

     DISP fi_acstmt WITH FRAM frmain.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_br
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_br C-Win
ON LEAVE OF fi_br IN FRAME frmain
DO:
    ASSIGN 
    fi_br = CAPS(INPUT fi_br) 
    nv_brf = fi_br .
    DISP fi_br WITH FRAME frmain .
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_brt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_brt C-Win
ON LEAVE OF fi_brt IN FRAME frmain
DO:
  ASSIGN 
    fi_brt = CAPS(INPUT fi_brt) 
    nv_brt = fi_brt .
    DISP fi_brt WITH FRAME frmain .
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_output
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_output C-Win
ON LEAVE OF fi_output IN FRAME frmain
DO:
    ASSIGN

     fi_output = CAPS(INPUT fi_output)
     nv_acstmt = fi_output.

     DISP fi_output WITH FRAM frmain.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ri_sort
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ri_sort C-Win
ON VALUE-CHANGED OF ri_sort IN FRAME frmain
DO:
    ri_sort = INPUT ri_sort .
    
    IF fi_acstm <> ""  THEN DO:

       IF ri_sort = 1 THEN DO :
          IF nv_acstm = "" THEN DO:
             MESSAGE " ** Please Enter Group ** " VIEW-AS ALERT-BOX.
             APPLY "ENTRY" TO fi_acstm IN FRAM frmain.
             RETURN NO-APPLY.
          END.
          ELSE DO:
             OPEN QUERY br_xmm600 FOR EACH xmm600 USE-INDEX xmm60009 WHERE 
                  xmm600.gpstmt = fi_acstm   NO-LOCK.
             DISP br_xmm600 WITH FRAM frmain.
          END.
          IF fi_acstm <> xmm600.gpstmt  THEN DO :
             MESSAGE " ** Not Have This Group ** " VIEW-AS ALERT-BOX.
             APPLY "ENTRY" TO fi_acstm IN FRAM frmain.
          END.
      END.
      IF ri_sort = 2 THEN DO :
          IF nv_acstm = "" THEN DO:
             MESSAGE " ** Please Enter Producer ** " VIEW-AS ALERT-BOX.
             APPLY "ENTRY" TO fi_acstm IN FRAM frmain.
             RETURN NO-APPLY.
          END.
          ELSE DO:
              OPEN QUERY br_xmm600 FOR EACH xmm600 USE-INDEX xmm60001 WHERE 
                   xmm600.acno = fi_acstm    NO-LOCK. 
              DISP br_xmm600 WITH FRAM frmain.
          END.
          
          IF fi_acstm <> xmm600.acno  THEN DO:
               MESSAGE " ** Not Have This Producer ** " VIEW-AS ALERT-BOX.
               APPLY "ENTRY" TO fi_acstm IN FRAM frmain.
          END.
      END.
    END.


  
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
ON END-KEY    UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
    
   SESSION:DATA-ENTRY-RETURN = YES.

  IF NOT CAN-FIND (FIRST xmm600) THEN DO:
     RETURN NO-APPLY.
  END.
  ELSE DO:

      ASSIGN ri_sort = 1
             fi_acstm = ""
             fi_acstmt = "" 
             fi_br   = "0"
             fi_brt  = "Z".

    RUN ProcUpdateQ.
/*
    DISP ri_sort fi_acstm fi_acstmt fi_br fi_brt WITH FRAME frmain.*/
    IF CAN-FIND (xmm600) THEN DO:
          br_xmm600:SET-REPOSITIONED-ROW (5).
          REPOSITION br_xmm600  TO Recid  Recid(xmm600).
          br_xmm600:SELECT-FOCUSED-ROW ().
          APPLY "ENTRY" TO br_xmm600.
    END.
    APPLY "VALUE-CHANGED" TO br_xmm600 IN FRAME frmain.

 
  END.
  RUN enable_UI.

  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI C-Win 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI C-Win 
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
  DISPLAY ri_sort fi_acstm fi_acstmt fi_br fi_brt fi_output 
      WITH FRAME frmain IN WINDOW C-Win.
  ENABLE ri_sort fi_acstm fi_acstmt fi_br fi_brt fi_output bu_check bu_reset bu_exit br_xmm600 bu_delete RecOK-4 
         bg bg-2 RecOK-5  RecOK-11 RecOK-12 RecOK-13  bu_exp
      WITH FRAME frmain IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frmain}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE procdisp C-Win 
PROCEDURE procdisp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  /*  IF ri_sort = 1  THEN DO :
     
       FOR EACH  xmm600 NO-LOCK USE-INDEX xmm60009 WHERE xmm600.gpstm = fi_acstm .
           DISP xmm600.gpstm  xmm600.acno     
                xmm600.iblack xmm600.crcon WITH BROWSE br_xmm600.
       END.
     END.

     IF ri_sort = 2  THEN DO :

       FOR EACH  xmm600 NO-LOCK USE-INDEX xmm60001 WHERE xmm600.acno = fi_acstm .
           DISP  xmm600.gpstm    xmm600.acno     
                 xmm600.iblack   xmm600.crcon WITH BROWSE br_xmm600.
       END.
     END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcUpdateQ C-Win 
PROCEDURE ProcUpdateQ :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
do:
    IF fi_acstm <> "" THEN DO:
 /* OPEN QUERY br_xmm600
        FOR EACH xmm600 USE-INDEX xmm60001 
           WHERE xmm600.acno =  fi_acstm   NO-LOCK.*/
        IF ri_sort = 1 THEN DO :
       
           OPEN QUERY br_xmm600 FOR EACH xmm600 USE-INDEX xmm60009 WHERE
                                         xmm600.gpstmt >= fi_acstm  AND
                                         xmm600.gpstmt <= fi_acstmt AND
                                         xmm600.homebr >= fi_br     AND
                                         xmm600.homebr <= fi_brt    NO-LOCK.
           DISP br_xmm600 WITH FRAM frmain.
           IF fi_acstm <> xmm600.gpstmt  THEN DO :
               MESSAGE " ** Not Have This Group ** " VIEW-AS ALERT-BOX.
               APPLY "ENTRY" TO fi_acstm IN FRAM frmain.
           END.
        END.
       
        IF ri_sort = 2 THEN DO :
            
            OPEN QUERY br_xmm600 FOR EACH xmm600 USE-INDEX xmm60001 WHERE
                                          xmm600.acno   >= fi_acstm  AND 
                                          xmm600.acno   <= fi_acstmt AND 
                                          xmm600.homebr >= fi_br     AND 
                                          xmm600.homebr <= fi_brt    NO-LOCK.
            DISP br_xmm600 WITH FRAM frmain.
            IF fi_acstm <> xmm600.acno  THEN DO:
                 MESSAGE " ** Not Have This Producer ** " VIEW-AS ALERT-BOX.
                 APPLY "ENTRY" TO fi_acstm IN FRAM frmain.
            END.
        END.
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_expfile C-Win 
PROCEDURE proc_expfile :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_output AS CHAR FORMAT "x(100)" INIT "" .
ASSIGN nv_output = fi_output
       nv_output = nv_output + ".slk".
  OUTPUT TO VALUE(nv_output) .
  EXPORT DELIMITER "|"
      " Report Credit Control " .
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
      "CHECK CREDIT" 
      "STATUS"   . 

  IF ri_sort = 1 THEN DO:  /* Group */
       FOR EACH xmm600  USE-INDEX xmm60009 WHERE 
                   xmm600.gpstm  >= fi_acstm AND      
                   xmm600.gpstm  <= fi_acstmt AND 
                   xmm600.homebr >= fi_br AND      /*a61-0035*/
                   xmm600.homebr <= fi_brt NO-LOCK  /*a61-0035*/ 
          BREAK BY xmm600.homebr
                BY xmm600.gpstm 
                BY xmm600.acno  .

          EXPORT DELIMITER "|"
                 xmm600.homebr  
                 xmm600.gpstm   
                 xmm600.acno    
                 xmm600.name
                 xmm600.ltamt  
                 xmm600.crcon   
                 xmm600.iblack   .
          END.
  END.      

  IF ri_sort = 2 THEN DO:  /* Producer */
     
          FOR EACH xmm600  USE-INDEX xmm60001 WHERE 
                   xmm600.acno   >= fi_acstm  AND      
                   xmm600.acno   <= fi_acstmt AND 
                   xmm600.homebr >= fi_br     AND      
                   xmm600.homebr <= fi_brt    NO-LOCK  
          BREAK BY xmm600.homebr
                BY xmm600.acno  .

          EXPORT DELIMITER "|"
                 xmm600.homebr
                 xmm600.gpstm    
                 xmm600.acno     
                 xmm600.name
                 xmm600.ltamt 
                 xmm600.crcon    
                 xmm600.iblack   .
          END.
      
  END.     
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

