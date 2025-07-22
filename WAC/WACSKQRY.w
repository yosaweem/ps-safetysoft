&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          tid              PROGRESS
*/
&Scoped-define WINDOW-NAME WACSKQRY
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS WACSKQRY 
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

/* Parameters Definitions ---                                           */


/* Local Variable Definitions ---                                       */
DEFINE VAR chr_sticker  AS CHAR     FORMAT "X(15)".
DEFINE VAR nvw_sticker AS INTEGER  FORMAT "9999999999" INIT 0 NO-UNDO.
DEFINE VAR nv_cnt1      AS INT. 
DEFINE VAR nv_cnt2      AS INT. 
DEFINE VAR Chk_mod1     AS DEC. 
DEFINE VAR Chk_mod2     AS DEC. 
DEFINE VAR nv_modulo    AS INTEGER  FORMAT "9".
DEFINE VAR nv_cnt01     AS INTEGER.  
DEFINE VAR nv_cnt02     AS INTEGER.
DEFINE VAR nv_count     AS INTEGER                      INIT 0. 
DEFINE VAR nv_sticker1  AS INTEGER  FORMAT "9999999999" INIT 0 NO-UNDO.
DEFINE VAR nv_sticker2  AS INTEGER  FORMAT "9999999999" INIT 0 NO-UNDO.
DEFINE VAR nv_sckno     AS INTEGER  FORMAT "99999999999".    
DEFINE VAR nv_crep      AS INTEGER  FORMAT "9999999"    INIT 0. 
DEFINE VAR nv_first     AS LOGICAL.
DEFINE VAR nvsck        AS CHAR     FORMAT "X(16)".
DEFINE VAR nv_sck_no    AS CHAR     FORMAT "X(15)"      INITIAL "" NO-UNDO. /*by amparat c. a51-0253--*/
DEFINE VAR nv_count01   AS INTEGER.
DEFINE VAR nv_count02   AS INTEGER.
DEFINE VAR nvrep        AS CHAR     FORMAT "9999999". /*-- A50-0185 --*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main
&Scoped-define BROWSE-NAME br_losstk

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES NOTSTK sckyear

/* Definitions for BROWSE br_losstk                                     */
&Scoped-define FIELDS-IN-QUERY-br_losstk NOTSTK.pol_mark NOTSTK.stk_year ~
NOTSTK.stk_sta NOTSTK.usrid 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_losstk 
&Scoped-define QUERY-STRING-br_losstk FOR EACH NOTSTK NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br_losstk OPEN QUERY br_losstk FOR EACH NOTSTK NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br_losstk NOTSTK
&Scoped-define FIRST-TABLE-IN-QUERY-br_losstk NOTSTK


/* Definitions for BROWSE br_stkno                                      */
&Scoped-define FIELDS-IN-QUERY-br_stkno sckyear.policy sckyear.sckno ~
sckyear.stat sckyear.trandat sckyear.flag sckyear.usrid 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_stkno 
&Scoped-define QUERY-STRING-br_stkno FOR EACH sckyear NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br_stkno OPEN QUERY br_stkno FOR EACH sckyear NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br_stkno sckyear
&Scoped-define FIRST-TABLE-IN-QUERY-br_stkno sckyear


/* Definitions for FRAME fr_main                                        */
&Scoped-define OPEN-BROWSERS-IN-QUERY-fr_main ~
    ~{&OPEN-QUERY-br_losstk}~
    ~{&OPEN-QUERY-br_stkno}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-2 RECT-6 RECT-7 bu_OK fi_sickerF ~
fi_sickerT br_stkno bu_OKLos rs_select fi_year fi_datefr fi_dateto ~
br_losstk bu_Check fi_tyear fi_tdatefr fi_tdateto 
&Scoped-Define DISPLAYED-OBJECTS fi_sickerF fi_sickerT rs_select fi_year ~
fi_datefr fi_dateto fi_tyear fi_tdatefr fi_tdateto 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR WACSKQRY AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_Check 
     LABEL "EXIT" 
     SIZE 14 BY 1.24
     FONT 6.

DEFINE BUTTON bu_OK 
     LABEL "OK" 
     SIZE 8 BY 1.19
     FONT 6.

DEFINE BUTTON bu_OKLos 
     LABEL "OK" 
     SIZE 8 BY 1.19
     FONT 6.

DEFINE VARIABLE fi_datefr AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_dateto AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_sickerF AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY .95
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_sickerT AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY .95
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_tdatefr AS CHARACTER FORMAT "X(50)":U 
      VIEW-AS TEXT 
     SIZE 12 BY 1
     BGCOLOR 8 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_tdateto AS CHARACTER FORMAT "X(50)":U 
      VIEW-AS TEXT 
     SIZE 5 BY 1
     BGCOLOR 8 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_tyear AS CHARACTER FORMAT "X(50)":U 
      VIEW-AS TEXT 
     SIZE 7 BY 1
     BGCOLOR 8 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_year AS CHARACTER FORMAT "X(4)":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE rs_select AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Year", 1,
"Date", 2
     SIZE 18.67 BY .95
     BGCOLOR 8 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 122.5 BY 11.43
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 122.5 BY 11.43
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 122.5 BY 1.67
     BGCOLOR 3 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_losstk FOR 
      NOTSTK SCROLLING.

DEFINE QUERY br_stkno FOR 
      sckyear SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_losstk
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_losstk WACSKQRY _STRUCTURED
  QUERY br_losstk NO-LOCK DISPLAY
      NOTSTK.pol_mark COLUMN-LABEL "Sticker No." FORMAT "x(15)":U
      NOTSTK.stk_year COLUMN-LABEL "Sticker year" FORMAT "x(4)":U
            WIDTH 10
      NOTSTK.stk_sta COLUMN-LABEL "Status" FORMAT "x(1)":U
      NOTSTK.usrid FORMAT "x(8)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 119.5 BY 8.52
         BGCOLOR 15  ROW-HEIGHT-CHARS .81 FIT-LAST-COLUMN.

DEFINE BROWSE br_stkno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_stkno WACSKQRY _STRUCTURED
  QUERY br_stkno NO-LOCK DISPLAY
      sckyear.policy FORMAT "x(16)":U
      sckyear.sckno FORMAT "x(15)":U
      sckyear.stat COLUMN-LABEL "Document No." FORMAT "x(10)":U
      sckyear.trandat FORMAT "99/99/9999":U WIDTH 15
      sckyear.flag COLUMN-LABEL "Document Type" FORMAT "x(2)":U
      sckyear.usrid FORMAT "x(8)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 119.5 BY 8.52
         BGCOLOR 15  ROW-HEIGHT-CHARS .71 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     bu_OK AT ROW 2.29 COL 110 
     fi_sickerF AT ROW 2.38 COL 31.33 COLON-ALIGNED NO-LABEL 
     fi_sickerT AT ROW 2.38 COL 61.17 COLON-ALIGNED NO-LABEL 
     br_stkno AT ROW 3.71 COL 3.17 
     bu_OKLos AT ROW 13.76 COL 111.5 
     rs_select AT ROW 13.86 COL 16.83 NO-LABEL 
     fi_year AT ROW 13.86 COL 44.33 COLON-ALIGNED NO-LABEL 
     fi_datefr AT ROW 13.86 COL 70 COLON-ALIGNED NO-LABEL 
     fi_dateto AT ROW 13.86 COL 92.5 COLON-ALIGNED NO-LABEL 
     br_losstk AT ROW 15.19 COL 3.5 
     bu_Check AT ROW 24.19 COL 108 
     fi_tyear AT ROW 13.86 COL 35.17 COLON-ALIGNED NO-LABEL 
     fi_tdatefr AT ROW 13.86 COL 57 COLON-ALIGNED NO-LABEL 
     fi_tdateto AT ROW 13.86 COL 86.67 COLON-ALIGNED NO-LABEL 
     "To :" VIEW-AS TEXT
          SIZE 4.5 BY 1 AT ROW 2.38 COL 56.5 
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Sticker From :" VIEW-AS TEXT
          SIZE 13.5 BY 1 AT ROW 2.38 COL 18 
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "      Query Sticker ชำรุด / สูญหาย" VIEW-AS TEXT
          SIZE 121.83 BY .91 AT ROW 12.67 COL 2 
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "ค้นหาข้อมูล :" VIEW-AS TEXT
          SIZE 11.5 BY 1.1 AT ROW 13.81 COL 4 
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "     Query Sticker ที่ใช้ไป/คงเหลือ" VIEW-AS TEXT
          SIZE 121.83 BY .91 AT ROW 1.19 COL 2 
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "ค้นหาข้อมูล :" VIEW-AS TEXT
          SIZE 11.5 BY 1 AT ROW 2.38 COL 4 
          BGCOLOR 8 FGCOLOR 1 FONT 6
     RECT-2 AT ROW 1.1 COL 1.67 
     RECT-6 AT ROW 12.52 COL 1.67 
     RECT-7 AT ROW 23.95 COL 1.67 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 124.33 BY 24.81
         BGCOLOR 1  .


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
  CREATE WINDOW WACSKQRY ASSIGN
         HIDDEN             = YES
         TITLE              = "Query Sticker -WACSKQRY.W"
         HEIGHT             = 24.81
         WIDTH              = 124.5
         MAX-HEIGHT         = 26.43
         MAX-WIDTH          = 132.67
         VIRTUAL-HEIGHT     = 26.43
         VIRTUAL-WIDTH      = 132.67
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
/* SETTINGS FOR WINDOW WACSKQRY
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fr_main
   FRAME-NAME                                                           */
/* BROWSE-TAB br_stkno fi_sickerT fr_main */
/* BROWSE-TAB br_losstk fi_dateto fr_main */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(WACSKQRY)
THEN WACSKQRY:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_losstk
/* Query rebuild information for BROWSE br_losstk
     _TblList          = "tid.NOTSTK"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   > tid.NOTSTK.pol_mark
"NOTSTK.pol_mark" "Sticker No." "x(15)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > tid.NOTSTK.stk_year
"NOTSTK.stk_year" "Sticker year" ? "character" ? ? ? ? ? ? no ? no no "10" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > tid.NOTSTK.stk_sta
"NOTSTK.stk_sta" "Status" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   = tid.NOTSTK.usrid
     _Query            is OPENED
*/  /* BROWSE br_losstk */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_stkno
/* Query rebuild information for BROWSE br_stkno
     _TblList          = "tid.sckyear"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   = tid.sckyear.policy
     _FldNameList[2]   > tid.sckyear.sckno
"sckyear.sckno" ? "x(15)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > tid.sckyear.stat
"sckyear.stat" "Document No." "x(10)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > tid.sckyear.trandat
"sckyear.trandat" ? ? "date" ? ? ? ? ? ? no ? no no "15" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > tid.sckyear.flag
"sckyear.flag" "Document Type" "x(2)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   = tid.sckyear.usrid
     _Query            is OPENED
*/  /* BROWSE br_stkno */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME WACSKQRY
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL WACSKQRY WACSKQRY
ON END-ERROR OF WACSKQRY /* Query Sticker -WACSKQRY.W */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL WACSKQRY WACSKQRY
ON WINDOW-CLOSE OF WACSKQRY /* Query Sticker -WACSKQRY.W */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_Check
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_Check WACSKQRY
ON CHOOSE OF bu_Check IN FRAME fr_main /* EXIT */
DO:
  APPLY  "CLOSE" TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_OK WACSKQRY
ON CHOOSE OF bu_OK IN FRAME fr_main /* OK */
DO:
    OPEN QUERY br_stkno
    FOR EACH sckyear USE-INDEX sckyear 
        WHERE sckyear.sckno >= fi_sickerF
        AND   sckyear.sckno <= fi_sickerT NO-LOCK
    BY sckyear.sckno.



END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_OKLos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_OKLos WACSKQRY
ON CHOOSE OF bu_OKLos IN FRAME fr_main /* OK */
DO:


    IF rs_select = 1 THEN DO:
        OPEN QUERY  br_losstk
        FOR EACH NOTSTK 
            WHERE notstk.stk_year = fi_year NO-LOCK
        BY notstk.stk_year DESC.

    END.
    ELSE  DO:
        OPEN QUERY  br_losstk
        FOR EACH NOTSTK 
            WHERE notstk.lost_dat <= fi_datefr
            AND   notstk.lost_dat >= fi_dateto NO-LOCK
        BY notstk.lost_dat DESC.

    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_sickerF
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_sickerF WACSKQRY
ON LEAVE OF fi_sickerF IN FRAME fr_main
DO:
  fi_sickerF = INPUT fi_sickerF.

     IF fi_sickerF = "" THEN DO:
         MESSAGE "Sticker No. Not Blank !" VIEW-AS ALERT-BOX.
         APPLY "ENTRY" TO fi_sickerF.
         RETURN NO-APPLY.
    
     END.
     
     IF  LENGTH(fi_sickerF) > 13 THEN DO:
         MESSAGE "LENGTH Sticker Mor than 13 Character".
         APPLY "ENTRY" TO fi_sickerF.
         RETURN NO-APPLY.
     END.

     chr_sticker = "". 
     chr_sticker = TRIM(fi_sickerF).

     RUN PD_chkmod.

     IF  fi_sickerF <> chr_sticker THEN DO:
         MESSAGE "ข้อมูลเบอร์ Sticker no.ไม่ถูกต้อง." fi_sickerF
                 "ที่ถูกต้อง->" chr_sticker.
         APPLY "ENTRY" TO fi_sickerF.
         RETURN NO-APPLY.
     END.
     fi_sickerT = fi_sickerF.
     DISP fi_sickerF fi_sickerT WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_sickerT
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_sickerT WACSKQRY
ON LEAVE OF fi_sickerT IN FRAME fr_main
DO:
   fi_sickerT = INPUT fi_sickerT.

     IF fi_sickerT = "" THEN DO:
         MESSAGE "Sticker No. Not Blank !" VIEW-AS ALERT-BOX.
         APPLY "ENTRY" TO fi_sickerT.
         RETURN NO-APPLY.
    
     END.
     
     IF  LENGTH(fi_sickerT) > 13 THEN DO:
         MESSAGE "LENGTH Sticker Mor than 13 Character".
         APPLY "ENTRY" TO fi_sickerT.
         RETURN NO-APPLY.
     END.

     IF  fi_sickerT < fi_sickerF THEN DO:
          MESSAGE "Sticker No. To Must Be Greater Or Equal".
          APPLY "ENTRY" TO fi_sickerT.
          RETURN NO-APPLY.
     END.

     chr_sticker = "". 
     chr_sticker = TRIM(fi_sickerT).

     RUN PD_chkmod.

     IF  fi_sickerT <> chr_sticker THEN DO:
         MESSAGE "ข้อมูลเบอร์ Sticker no.ไม่ถูกต้อง." fi_sickerT
                 "ที่ถูกต้อง->" chr_sticker.
         APPLY "ENTRY" TO fi_sickerT.
         RETURN NO-APPLY.
     END.
     nv_cnt01 = LENGTH(fi_sickerT) - 1.
     nv_cnt02 = LENGTH(fi_sickerF) - 1.
     nv_count = (DECIMAL(SUBSTRING(fi_sickerT,1,nv_cnt01)) - DECIMAL(SUBSTRING(fi_sickerF,1,nv_cnt02)) ) + 1. 
     /*fi_sumstk = nv_count. */
     
     DISP fi_sickerT  WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_year
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_year WACSKQRY
ON LEAVE OF fi_year IN FRAME fr_main
DO:
  fi_year = INPUT fi_year.
  DISP fi_year WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rs_select
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rs_select WACSKQRY
ON VALUE-CHANGED OF rs_select IN FRAME fr_main
DO:
  rs_select = INPUT rs_select.
  

  IF rs_select = 1 THEN DO: 
      fi_tyear = "Year : ".
      HIDE fi_tdatefr fi_tdateto fi_datefr fi_dateto .
      VIEW  fi_tyear fi_year .
       
      DISP fi_tyear WITH FRAME fr_main.
  END.
  ELSE DO:
      ASSIGN
        fi_tdatefr  = "Date From :"
        fi_tdateto  = "To :".

      HIDE  fi_tyear fi_year .
      VIEW  fi_tdatefr fi_tdateto fi_datefr fi_dateto .
      
      DISP fi_tdatefr fi_tdateto WITH FRAME fr_main.
  END.

     


  DISP rs_select WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_losstk
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK WACSKQRY 


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
  SESSION:DATA-ENTRY-RETURN = YES.
  
   
  rs_select = 1.

  IF rs_select = 1 THEN DO: 
      fi_tyear = "Year : ".
      HIDE fi_tdatefr fi_tdateto fi_datefr fi_dateto .
      VIEW  fi_tyear fi_year .
       
      DISP fi_tyear WITH FRAME fr_main.
  END.
  ELSE DO:
      ASSIGN
        fi_tdatefr  = "Date Frome :"
        fi_tdateto  = "To :".

      HIDE  fi_tyear fi_year .
      VIEW  fi_tdatefr fi_tdateto fi_datefr fi_dateto .
      
      DISP fi_tdatefr fi_tdateto WITH FRAME fr_main.
  END.


  DISP rs_select WITH FRAME fr_main.

 

  OPEN QUERY br_stkno
  FOR EACH sckyear USE-INDEX sckyear 
      WHERE sckyear.sckno >= fi_sickerF
      AND   sckyear.sckno <= fi_sickerT NO-LOCK
  BY sckyear.sckno DESC.

  OPEN QUERY  br_losstk
  FOR EACH NOTSTK 
      WHERE notstk.stk_year <= fi_year NO-LOCK
  BY notstk.stk_year DESC.





  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI WACSKQRY  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(WACSKQRY)
  THEN DELETE WIDGET WACSKQRY.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI WACSKQRY  _DEFAULT-ENABLE
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
  DISPLAY fi_sickerF fi_sickerT rs_select fi_year fi_datefr fi_dateto fi_tyear 
          fi_tdatefr fi_tdateto 
      WITH FRAME fr_main IN WINDOW WACSKQRY.
  ENABLE RECT-2 RECT-6 RECT-7 bu_OK fi_sickerF fi_sickerT br_stkno bu_OKLos 
         rs_select fi_year fi_datefr fi_dateto br_losstk bu_Check fi_tyear 
         fi_tdatefr fi_tdateto 
      WITH FRAME fr_main IN WINDOW WACSKQRY.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW WACSKQRY.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_chkmod WACSKQRY 
PROCEDURE PD_chkmod :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
nv_cnt1 = LENGTH(chr_sticker).
nv_cnt2 = nv_cnt1 - 1.

IF  nv_cnt1  = 0 THEN NEXT .
IF SUBSTRING (CHR_sticker,1,1) = "0"  THEN DO:
      ASSIGN  
      Chk_mod1 = DEC(SUBSTRING(chr_sticker,1,nv_cnt2)).            
      
      IF nv_cnt2 = 14 THEN DO:
         Chk_mod2 = DEC(SUBSTRING(STRING( Chk_mod1 / 7,"99999999999999.999"  ),1,nv_cnt2)) * 7.
      END.
      ELSE IF nv_cnt2 = 12 THEN DO:
         Chk_mod2 = DEC(SUBSTRING(STRING( Chk_mod1 / 7,"999999999999.999"  ),1,nv_cnt2)) * 7.
      END.
      ELSE IF nv_cnt2 = 10 THEN DO:
         Chk_mod2 = DEC(SUBSTRING(STRING( Chk_mod1 / 7,"9999999999.999"  ),1,nv_cnt2)) * 7.
      END.
      ELSE IF nv_cnt2 = 8 THEN DO:
         Chk_mod2 = DEC(SUBSTRING(STRING( Chk_mod1 / 7,"99999999.999"  ),1,nv_cnt2)) * 7.
      END.

      nv_modulo = Chk_mod1 - Chk_mod2.  
      chr_sticker = "0" + SUBSTRING(STRING(Chk_mod1),1,nv_cnt2) + STRING(nv_modulo).      
      
      
 END.
 ELSE DO: 
     ASSIGN  
     Chk_mod1 = DEC(SUBSTRING(chr_sticker,1,nv_cnt2)).      
     Chk_mod2 = DEC(SUBSTRING(STRING( Chk_mod1 / 7),1,nv_cnt2)) * 7.
     nv_modulo = Chk_mod1 - Chk_mod2.         
     chr_sticker = SUBSTRING(STRING(Chk_mod1),1,nv_cnt2) + STRING(nv_modulo).
 END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

