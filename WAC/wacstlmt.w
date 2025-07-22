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
/* Modify by : Ranu I. A61-0035 24/08/2018 
               แก้ไขหน้าจอและปรับเงื่อนไขให้อัพเดท Credit control Report เป็น YES หรือ No  */
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
DEF VAR nv_acstmt AS CHAR FORMAT "X(10)" .  /*a61-0035*/
DEF VAR nv_brf    AS CHAR FORMAT "X(3)" .   /*a61-0035*/
DEF VAR nv_brt    AS CHAR FORMAT "X(3)" .   /*a61-0035*/
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
xmm600.homebr xmm600.name xmm600.ltamt xmm600.crcon xmm600.iblack 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_xmm600 
&Scoped-define QUERY-STRING-br_xmm600 FOR EACH xmm600 SHARE-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br_xmm600 OPEN QUERY br_xmm600 FOR EACH xmm600 SHARE-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br_xmm600 xmm600
&Scoped-define FIRST-TABLE-IN-QUERY-br_xmm600 xmm600


/* Definitions for FRAME frmain                                         */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS ri_sort fi_acstm fi_acstmt fi_brt fi_br ~
bu_ok bu_exit br_xmm600 bu_yes bu_no fi_output bu_exp RecOK-4 bg bg-2 ~
RecOK-12 RecOK-13 RecOK-14 
&Scoped-Define DISPLAYED-OBJECTS ri_sort fi_acstm fi_acstmt fi_brt fi_br ~
fi_output 

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
     SIZE 15 BY 1.14
     FONT 2.

DEFINE BUTTON bu_exp 
     LABEL "Export" 
     SIZE 9.33 BY 1.14
     FONT 6.

DEFINE BUTTON bu_no 
     LABEL "Uncheck" 
     SIZE 15 BY 1.14
     BGCOLOR 4 FONT 2.

DEFINE BUTTON bu_ok 
     LABEL "OK" 
     SIZE 15 BY 1.14
     FONT 2.

DEFINE BUTTON bu_yes 
     LABEL "Check" 
     SIZE 15 BY 1.14
     BGCOLOR 10 FONT 2.

DEFINE VARIABLE fi_acstm AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 2 NO-UNDO.

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
     SIZE 16.17 BY 2.76
     BGCOLOR 8 FGCOLOR 15 FONT 2 NO-UNDO.

DEFINE RECTANGLE bg
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 105.5 BY 3.86
     BGCOLOR 3 .

DEFINE RECTANGLE bg-2
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 25.83 BY 3.86
     BGCOLOR 8 .

DEFINE RECTANGLE RecOK-12
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 16.5 BY 1.67
     BGCOLOR 6 .

DEFINE RECTANGLE RecOK-13
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 16.5 BY 1.67
     BGCOLOR 10 .

DEFINE RECTANGLE RecOK-14
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 16.5 BY 1.67
     BGCOLOR 4 .

DEFINE RECTANGLE RecOK-4
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 131.5 BY 17.38
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
            WIDTH 13.33
      xmm600.acno COLUMN-LABEL "      Producer" FORMAT "x(10)":U
            WIDTH 12.83
      xmm600.homebr COLUMN-LABEL "BR" FORMAT "x(3)":U WIDTH 3.83
      xmm600.name COLUMN-LABEL "      Name" FORMAT "x(30)":U WIDTH 35.67
      xmm600.ltamt FORMAT ">,>>>,>>>,>>>,>>9":U WIDTH 26 LABEL-FGCOLOR 1 LABEL-BGCOLOR 15 LABEL-FONT 1
      xmm600.crcon COLUMN-LABEL " Check Credit" FORMAT "yes/no":U
            WIDTH 13.83 COLUMN-BGCOLOR 10 COLUMN-FONT 6 LABEL-FGCOLOR 2 LABEL-BGCOLOR 10 LABEL-FONT 6
      xmm600.iblack COLUMN-LABEL "Black List Code" FORMAT "x(15)":U
            COLUMN-FGCOLOR 0 COLUMN-BGCOLOR 15 COLUMN-FONT 1 LABEL-FGCOLOR 6 LABEL-FONT 6
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 129.5 BY 14.52
         BGCOLOR 15  ROW-HEIGHT-CHARS .7 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME frmain
     ri_sort AT ROW 3.24 COL 7.17 NO-LABEL
     fi_acstm AT ROW 3.24 COL 51.67 COLON-ALIGNED NO-LABEL
     fi_acstmt AT ROW 3.29 COL 82.33 COLON-ALIGNED NO-LABEL WIDGET-ID 108
     fi_brt AT ROW 4.71 COL 82.33 COLON-ALIGNED NO-LABEL WIDGET-ID 112
     fi_br AT ROW 4.57 COL 51.5 COLON-ALIGNED NO-LABEL WIDGET-ID 110
     bu_ok AT ROW 4 COL 109.33
     bu_exit AT ROW 21.86 COL 115.17
     br_xmm600 AT ROW 6.71 COL 2.5
     bu_yes AT ROW 21.91 COL 3.67
     bu_no AT ROW 21.91 COL 22.83
     fi_output AT ROW 22.38 COL 47.5 COLON-ALIGNED NO-LABEL WIDGET-ID 120
     bu_exp AT ROW 22.29 COL 101.17 WIDGET-ID 122
     "SET CODE FOR CHECK CREDIT CONTROL" VIEW-AS TEXT
          SIZE 42.5 BY .95 AT ROW 1.43 COL 44.5 WIDGET-ID 2
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "อัพเดทข้อมูลช่อง Credit Control Report = YES/NO" VIEW-AS TEXT
          SIZE 42.17 BY .91 AT ROW 21.33 COL 48.83 WIDGET-ID 4
          BGCOLOR 1 FGCOLOR 15 FONT 1
     "Branch  From :" VIEW-AS TEXT
          SIZE 14.5 BY .95 AT ROW 4.57 COL 38 WIDGET-ID 114
          BGCOLOR 3 FGCOLOR 15 FONT 6
     "Exp file:" VIEW-AS TEXT
          SIZE 8.5 BY .95 AT ROW 22.38 COL 40.17 WIDGET-ID 106
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "To :" VIEW-AS TEXT
          SIZE 4.5 BY .95 AT ROW 4.71 COL 79 WIDGET-ID 116
          BGCOLOR 3 FGCOLOR 15 FONT 6
     "To :" VIEW-AS TEXT
          SIZE 5 BY .95 AT ROW 3.33 COL 79.17 WIDGET-ID 118
          BGCOLOR 3 FGCOLOR 15 FONT 6
     "Group / Producer  From :" VIEW-AS TEXT
          SIZE 24 BY .95 AT ROW 3.19 COL 28 WIDGET-ID 78
          BGCOLOR 3 FGCOLOR 15 FONT 6
     RecOK-4 AT ROW 6.48 COL 1
     bg AT ROW 2.62 COL 27
     bg-2 AT ROW 2.62 COL 1
     RecOK-12 AT ROW 21.62 COL 114.5
     RecOK-13 AT ROW 21.67 COL 2.83
     RecOK-14 AT ROW 21.67 COL 22
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 131.67 BY 23
         BGCOLOR 1 .


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
         TITLE              = ""
         HEIGHT             = 23
         WIDTH              = 132
         MAX-HEIGHT         = 24
         MAX-WIDTH          = 133
         VIRTUAL-HEIGHT     = 24
         VIRTUAL-WIDTH      = 133
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
"xmm600.gpstmt" "   Grp Statement" "x(10)" "character" ? ? ? ? ? ? no ? no no "13.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > sicsyac.xmm600.acno
"xmm600.acno" "      Producer" "x(10)" "character" ? ? ? ? ? ? no ? no no "12.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > sicsyac.xmm600.homebr
"xmm600.homebr" "BR" "x(3)" "character" ? ? ? ? ? ? no ? no no "3.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > sicsyac.xmm600.name
"xmm600.name" "      Name" "x(30)" "character" ? ? ? ? ? ? no ? no no "35.67" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > sicsyac.xmm600.ltamt
"xmm600.ltamt" ? ? "decimal" ? ? ? 15 1 1 no ? no no "26" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > sicsyac.xmm600.crcon
"xmm600.crcon" " Check Credit" ? "logical" 10 ? 6 10 2 6 no ? no no "13.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > sicsyac.xmm600.iblack
"xmm600.iblack" "Black List Code" "x(15)" "character" 15 0 1 ? 6 6 no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE br_xmm600 */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


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


        MESSAGE "ต้องการอัพเดทข้อมูลการเช็ค Over Credit Control" SKIP(1)
              "Group : " xmm600.gpstm  "Producer: " xmm600.acno  SKIP(1)
              " หรือไม่ ?"
        UPDATE logAns 
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
        TITLE "Confirm CHANGE ".
        IF logAns THEN DO: 

            IF  xmm600.crcon   = NO /*AND
                xmm600.iblack  = "OverCredit"*/ THEN DO:
                FOR EACH xmm600 USE-INDEX xmm60001 WHERE  
                       xmm600.acno    = n_acno  .
                   /* ASSIGN  xmm600.iblack  = "" .*/
                    ASSIGN  xmm600.crcon   = YES .
                END.

                RUN ProcUpdateQ.
                
            END.

            IF  xmm600.crcon   = YES AND
                xmm600.iblack  = "" THEN DO:
                FOR EACH xmm600 USE-INDEX xmm60001 WHERE  
                       xmm600.acno    = n_acno  .
                    /*ASSIGN  xmm600.iblack  = "OverCredit" .*/
                    ASSIGN  xmm600.crcon   = NO .
                END.
                RUN ProcUpdateQ.
            END.
        END.    

        MESSAGE "Change Complete..." VIEW-AS ALERT-BOX INFORMATION. 
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


&Scoped-define SELF-NAME bu_no
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_no C-Win
ON CHOOSE OF bu_no IN FRAME frmain /* Uncheck */
DO:
   /*
   IF ri_sort = 1 THEN DO:

      logAns = No.

      MESSAGE "Do you want to update Status ! " SKIP(1)
              "Group : " xmm600.gpstm       SKIP(1)
              "ทุก Producer ของ Group นี้"  SKIP(1)
              "Credit Control = NOT OVER"  
      UPDATE logAns 
      VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
      TITLE "Confirm DELETE ".
      IF logAns THEN DO:  

        FOR EACH xmm600 USE-INDEX xmm60009 WHERE 
                 xmm600.gpstmt  = fi_acstm  .  
                 
            ASSIGN  xmm600.iblack  = ""  .
        
        END.
      END.

      RUN ProcUpdateQ.
      MESSAGE "Update Complete..." VIEW-AS ALERT-BOX INFORMATION.  
      
   END.

   IF ri_sort = 2 THEN DO:

      logAns = No.

      MESSAGE "Do you want to update Status ! " SKIP(1)
              "Producer : " xmm600.acno     SKIP(1)
              "Credit Control = NOT OVER"  
              
      UPDATE logAns 
      VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
      TITLE "Confirm UPDATE ".
      IF logAns THEN DO:  

        FOR EACH xmm600 USE-INDEX xmm60009 WHERE 
                 xmm600.acno  = fi_acstm   .

            ASSIGN  xmm600.iblack  = ""  .
        
        END.
      END.

      RUN ProcUpdateQ.
      MESSAGE "Update Complete..." VIEW-AS ALERT-BOX INFORMATION.  
   END.*/

    IF ri_sort = 1 THEN DO:

      logAns = No.

      MESSAGE "ต้องการอัพเดทข้อมูล" SKIP(1)
              "Group : " fi_acstm " - " fi_acstmt      SKIP(1)
              "Branch: " fi_br  " - " fi_brt  SKIP(1)
              "ยกเลิกการเช็ค Over Credit Control หรือไม่ ?"  
      UPDATE logAns 
      VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
      TITLE "Confirm UPDATE ".
      IF logAns THEN DO:  

         FOR EACH xmm600 USE-INDEX xmm60009 WHERE 
                  /*xmm600.gpstmt  = fi_acstm AND */  /*A61-0035*/
                  xmm600.gpstmt  >= fi_acstm  AND  /*A61-0035*/
                  xmm600.gpstmt  <= fi_acstmt AND /*A61-0035*/
                  xmm600.homebr  >= fi_br     AND /*A61-0035*/
                  xmm600.homebr  <= fi_brt    AND /*A61-0035*/
                  xmm600.iblack  = "" .
             ASSIGN  xmm600.crcon   = NO .
         
         END.  
      END.

      RUN ProcUpdateQ.
      MESSAGE "Update Complete..." VIEW-AS ALERT-BOX INFORMATION.  
      
   END.

   IF ri_sort = 2 THEN DO:

      logAns = No.

      MESSAGE  "ต้องการอัพเดทข้อมูล" SKIP(1)
               "Producer : " fi_acstm  " - " fi_acstmt     SKIP(1)
               "Branch   : " fi_br " - " fi_brt     SKIP(1)
               "ยกเลิกเช็ค Over Credit Control หรือไม่? "  
      UPDATE logAns 
      VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
      TITLE "Confirm UPDATE ".
      IF logAns THEN DO:  

        FOR EACH xmm600 USE-INDEX xmm60001 WHERE 
                 /* xmm600.acno   = fi_acstm   AND */ /*A61-0035*/
                 xmm600.acno    >= fi_acstm   AND /*A61-0035*/
                 xmm600.acno    <= fi_acstmt  AND /*A61-0035*/
                 xmm600.homebr  >= fi_br      AND /*A61-0035*/
                 xmm600.homebr  <= fi_brt     AND /*A61-0035*/ 
                 xmm600.iblack  = "" .
            ASSIGN  xmm600.crcon   = NO  . 
        
        END.
      END.

      RUN ProcUpdateQ.
      MESSAGE "Update Complete..." VIEW-AS ALERT-BOX INFORMATION.  

      
   END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok C-Win
ON CHOOSE OF bu_ok IN FRAME frmain /* OK */
DO:
 
    IF ri_sort = 1 THEN DO :
        IF nv_acstm = "" THEN DO:
           MESSAGE " ** Please Enter Group ** " VIEW-AS ALERT-BOX.
           APPLY "ENTRY" TO fi_acstm IN FRAM frmain.
           RETURN NO-APPLY.
        END.

        ELSE DO:
           /*OPEN QUERY br_xmm600 FOR EACH xmm600 USE-INDEX xmm60009 WHERE xmm600.gpstmt = fi_acstm   NO-LOCK. */ /*A61-0035*/
           OPEN QUERY br_xmm600 FOR EACH xmm600 USE-INDEX xmm60009 WHERE  
                                 xmm600.gpstmt >= fi_acstm   AND 
                                 xmm600.gpstmt <= fi_acstmt  AND 
                                 xmm600.homebr >= fi_br      AND
                                 xmm600.homebr <= fi_brt     NO-LOCK.  /*A61-0035*/
           DISP br_xmm600 WITH FRAM frmain.
        END.

        IF fi_acstm <> xmm600.gpstmt  THEN DO :
           MESSAGE " ** Not Have This Group ** " VIEW-AS ALERT-BOX.
           APPLY "ENTRY" TO fi_acstm IN FRAM frmain.
        END.
    END.

    IF ri_sort = 2 THEN DO :
       /* DISABLE bu_delete . 
        DISP bu_delete WITH FRAM frmain.*/

        IF nv_acstm = "" THEN DO:
           MESSAGE " ** Please Enter Producer ** " VIEW-AS ALERT-BOX.
           APPLY "ENTRY" TO fi_acstm IN FRAM frmain.
           RETURN NO-APPLY.
        END.

        ELSE DO:
            /*OPEN QUERY br_xmm600 FOR EACH xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = fi_acstm    NO-LOCK. */ /*A61-0035*/
            OPEN QUERY br_xmm600 FOR EACH xmm600 USE-INDEX xmm60001 WHERE  
                                  xmm600.acno    >= fi_acstm   AND 
                                  xmm600.acno    <= fi_acstmt  AND 
                                  xmm600.homebr  >= fi_br      AND
                                  xmm600.homebr  <= fi_brt     NO-LOCK.  /*A61-0035*/
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


&Scoped-define SELF-NAME bu_yes
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_yes C-Win
ON CHOOSE OF bu_yes IN FRAME frmain /* Check */
DO:

  /* IF ri_sort = 1 THEN DO:

      logAns = No.

      MESSAGE "Do you want to update Status ! " SKIP(1)
              "Group : " xmm600.gpstm       SKIP(1)
              "ทุก Producer ของ Group นี้"  SKIP(1)
              "Credit Control = Over"  
      UPDATE logAns 
      VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
      TITLE "Confirm UPDATE ".
      IF logAns THEN DO:  

         FOR EACH xmm600 USE-INDEX xmm60009 WHERE 
                  xmm600.gpstmt  = fi_acstm   .
         
             ASSIGN  xmm600.iblack  = "OverCredit" .
         
         END.  
      END.

      RUN ProcUpdateQ.
      MESSAGE "Update Complete..." VIEW-AS ALERT-BOX INFORMATION.  

      
   END.

   IF ri_sort = 2 THEN DO:

      logAns = No.

      MESSAGE "Do you want to update Status ! " SKIP(1)
              "Producer : " xmm600.acno     SKIP(1)
              "Credit Control = Over "   
              
      UPDATE logAns 
      VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
      TITLE "Confirm UPDATE ".
      IF logAns THEN DO:  

        FOR EACH xmm600 USE-INDEX xmm60009 WHERE 
                 xmm600.acno  = fi_acstm   .

            ASSIGN  xmm600.iblack  = "OverCredit" .  
        
        END.
      END.

      RUN ProcUpdateQ.
      MESSAGE "Update Complete..." VIEW-AS ALERT-BOX INFORMATION.  */

    IF ri_sort = 1 THEN DO:

      logAns = No.

      MESSAGE "ต้องการอัพเดทข้อมูล" SKIP(1)
              "Group : " fi_acstm " - " fi_acstmt      SKIP(1)
              "Branch: " fi_br  " - " fi_brt  SKIP(1)
              "ให้มีการเช็ค Over Credit Control หรือไม่ ?"  
      UPDATE logAns 
      VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
      TITLE "Confirm UPDATE ".
      IF logAns THEN DO:  

         FOR EACH xmm600 USE-INDEX xmm60009 WHERE 
                  xmm600.gpstmt  >= fi_acstm  AND 
                  xmm600.gpstmt  <= fi_acstmt AND /*A61-0035*/
                  xmm600.homebr  >= fi_br     AND /*A61-0035*/
                  xmm600.homebr  <= fi_brt .      /*A61-0035*/
         
             ASSIGN  xmm600.crcon   = YES .
         
         END.  
      END.
      RUN ProcUpdateQ.
      MESSAGE "Update Complete..." VIEW-AS ALERT-BOX INFORMATION.  
      
   END.

   IF ri_sort = 2 THEN DO:

      logAns = No.

      MESSAGE  "ต้องการอัพเดทข้อมูล" SKIP(1)
               "Producer : " fi_acstm  " - " fi_acstmt     SKIP(1)
               "Branch   : " fi_br " - " fi_brt     SKIP(1)
               "ให้มีการเช็ค Over Credit Control หรือไม่? "  
      UPDATE logAns 
      VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
      TITLE "Confirm UPDATE ".
      IF logAns THEN DO:  

        /*FOR EACH xmm600 USE-INDEX xmm60001 WHERE xmm600.acno  = fi_acstm   .*/ /*A61-0035*/
          FOR EACH xmm600 USE-INDEX xmm60001    WHERE 
                   xmm600.acno    >= fi_acstm   AND 
                   xmm600.acno    <= fi_acstmt  AND 
                   xmm600.homebr  >= fi_br      AND
                   xmm600.homebr  <= fi_brt .      /*A61-0035*/

            ASSIGN  xmm600.crcon   = YES  .  
        END.
      END.

      RUN ProcUpdateQ.
      MESSAGE "Update Complete..." VIEW-AS ALERT-BOX INFORMATION.  
      
   END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_acstm
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_acstm C-Win
ON LEAVE OF fi_acstm IN FRAME frmain
DO:
    
    ASSIGN

     fi_acstm = CAPS(INPUT fi_acstm)
     fi_acstmt = fi_acstm
     nv_acstm = fi_acstm.

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
  
    ri_sort = INPUT ri_sort.
    
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
   DISP ri_sort fi_acstm fi_acstmt WITH FRAME frmain.

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

   DEF VAR gv_prog  AS CHAR FORMAT "x(30)".
   DEF VAR gv_prgid AS CHAR FORMAT "x(15)".
   
   gv_prgid = "WACSTLMT".
   gv_prog  = "SET CODE FOR CHECK CREDIT CONTROL".
   RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).
   /*RUN  WAC\WACCONFN.*/
   

   SESSION:DATA-ENTRY-RETURN = YES.

   IF NOT CAN-FIND (FIRST xmm600) THEN DO:
      RETURN NO-APPLY.
   END.
   ELSE DO:
   
       ASSIGN ri_sort = 1
              fi_br   = "0"  /*A61-0035*/
              fi_brt  = "Z". /*A61-0035*/
       DISP fi_br fi_brt WITH FRAME frmain.
   
     RUN ProcUpdateQ.
   
     IF CAN-FIND (xmm600) THEN DO:
           xmm600.ltamt:BGCOLOR IN BROWSE br_xmm600 = 10. 
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
  DISPLAY ri_sort fi_acstm fi_acstmt fi_brt fi_br fi_output 
      WITH FRAME frmain IN WINDOW C-Win.
  ENABLE ri_sort fi_acstm fi_acstmt fi_brt fi_br bu_ok bu_exit br_xmm600 bu_yes 
         bu_no fi_output bu_exp RecOK-4 bg bg-2 RecOK-12 RecOK-13 RecOK-14 
      WITH FRAME frmain IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frmain}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcDisp C-Win 
PROCEDURE ProcDisp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
     IF ri_sort = 1  THEN DO :
     
       FOR EACH  xmm600 NO-LOCK USE-INDEX xmm60009 WHERE xmm600.gpstm = fi_acstm .
           DISP xmm600.gpstm  xmm600.acno  WITH BROWSE br_xmm600.
       END.
     END.

     IF ri_sort = 2  THEN DO :

       FOR EACH  xmm600 NO-LOCK USE-INDEX xmm60001 WHERE xmm600.acno = fi_acstm .
           DISP  xmm600.gpstm   xmm600.acno  WITH BROWSE br_xmm600.
       END.
     END.
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcUpdateQ C-Win 
PROCEDURE ProcUpdateQ :
/*------------------------------------------------------------------------------
  Purpose:  Query Credit   
  Parameters:  <none>
  Notes:  Nattanicha , Benjaporn [A59-0153] 10/06/2016     
------------------------------------------------------------------------------*/

IF fi_acstm <> "" THEN DO:

  /*OPEN QUERY br_xmm600
        FOR EACH xmm600 USE-INDEX xmm60001 
           WHERE xmm600.acno =  fi_acstm   NO-LOCK.*/

    IF ri_sort = 1 THEN DO :

       /*OPEN QUERY br_xmm600 FOR EACH xmm600 USE-INDEX xmm60009 WHERE  xmm600.gpstmt = fi_acstm   NO-LOCK. */ /*A61-0035*/
        OPEN QUERY br_xmm600 FOR EACH xmm600 USE-INDEX xmm60009 WHERE  
                                      xmm600.gpstmt >= fi_acstm   AND 
                                      xmm600.gpstmt <= fi_acstmt  AND 
                                      xmm600.homebr >= fi_br      AND
                                      xmm600.homebr <= fi_brt     NO-LOCK.  /*A61-0035*/

       DISP br_xmm600 WITH FRAM frmain.
       IF fi_acstm <> xmm600.gpstmt  THEN DO :
           MESSAGE " ** Not Have This Group ** " VIEW-AS ALERT-BOX.
           APPLY "ENTRY" TO fi_acstm IN FRAM frmain.
       END.
    END.

    IF ri_sort = 2 THEN DO :
        
        /*OPEN QUERY br_xmm600 FOR EACH xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = fi_acstm    NO-LOCK. */ /*A61-0035*/
        OPEN QUERY br_xmm600 FOR EACH xmm600 USE-INDEX xmm60001 WHERE  
                                      xmm600.acno    >= fi_acstm   AND 
                                      xmm600.acno    <= fi_acstmt  AND 
                                      xmm600.homebr  >= fi_br      AND
                                      xmm600.homebr  <= fi_brt     NO-LOCK.  /*A61-0035*/
        DISP br_xmm600 WITH FRAM frmain.
        IF fi_acstm <> xmm600.acno  THEN DO:
             MESSAGE " ** Not Have This Producer ** " VIEW-AS ALERT-BOX.
             APPLY "ENTRY" TO fi_acstm IN FRAM frmain.
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
      " Report Set Code For Check Credit Control " .
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
      "CHECK CREDIT" .

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
                 xmm600.crcon .
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
                 xmm600.crcon .
          END.
      
  END.     

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

