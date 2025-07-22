&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
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
/*          This .W file was created with the Progress UIB.             */
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

 DEF TEMP-TABLE TImp
    FIELD Trow        AS CHAR 
    FIELD Ttext        AS CHAR
 INDEX Trow IS PRIMARY  Trow ASC.


 DEF TEMP-TABLE wImpTas
        FIELD wRecno    AS INT
        FIELD wName     AS CHAR  FORMAT "X(60)"
        FIELD wNorpol   AS CHAR  FORMAT "X(26)"
        FIELD wPol72     AS CHAR  FORMAT "X(26)"
        FIELD wEngine  AS CHAR  FORMAT "X(26)"
        FIELD wCha_no  AS CHAR  FORMAT "X(26)"
        FIELD wContractno  AS CHAR  FORMAT "X(10)"
        FIELD wVehreg  AS CHAR  FORMAT "X(12)"
        FIELD wComdat  AS CHAR FORMAT "99/99/9999"
/*        FIELD wComdat  AS DATE  /*FORMAT "99/99/9999"*/   */
        
        FIELD wGrossPrem            AS CHAR
        FIELD wCompGrossPrem  AS CHAR
        FIELD wNetPrem                AS CHAR
        FIELD wCompNetPrem      AS CHAR
        FIELD wTax                        AS CHAR
        FIELD wNetPayment         AS CHAR

/*        FIELD wGrossPrem            AS DECI  FORMAT "->>,>>>,>>9.99"
 *         FIELD wCompGrossPrem  AS DECI  FORMAT "->>,>>>,>>9.99"
 *         FIELD wNetPrem                AS DECI  FORMAT "->>,>>>,>>9.99"
 *         FIELD wCompNetPrem      AS DECI  FORMAT "->>,>>>,>>9.99"
 *         FIELD wTax                        AS DECI  FORMAT "->>9.99"
 *         FIELD wNetPayment         AS DECI  FORMAT "->>,>>>,>>9.99"*/

  INDEX  wImpTas01  IS UNIQUE PRIMARY wRecno ASCENDING.
  
  
    DEF VAR c   AS CHAR.
    DEF VAR  i AS INT.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS IMAGE-24 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE IMAGE IMAGE-24
     FILENAME "I:/SAFETY/WALP83/WIMAGE\bgc01":U
     SIZE 80.5 BY 8.1.

DEFINE BUTTON btnImOK 
     LABEL "OK" 
     SIZE 10 BY 1
     BGCOLOR 19 .

DEFINE BUTTON btn_file 
     LABEL "..." 
     SIZE 3.5 BY 1.05.

DEFINE BUTTON buCancel 
     LABEL "Cancel" 
     SIZE 10 BY 1.

DEFINE VARIABLE fiImport AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 29.5 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fiTextIm AS CHARACTER FORMAT "X(9)":U INITIAL " ชื่อไฟล์ :" 
      VIEW-AS TEXT 
     SIZE 7.5 BY 1
     BGCOLOR 8  NO-UNDO.

DEFINE VARIABLE raTo AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Thai Auto Sales", 1
     SIZE 19.5 BY 1
     BGCOLOR 32 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-70
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 67.5 BY 4.19
     BGCOLOR 8 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     IMAGE-24 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 80.67 BY 8.13
         BGCOLOR 8 .

DEFINE FRAME frImport
     raTo AT ROW 2.29 COL 6.5 NO-LABEL
     fiImport AT ROW 2.29 COL 35 COLON-ALIGNED NO-LABEL
     btn_file AT ROW 2.29 COL 66.5
     btnImOK AT ROW 4.14 COL 39
     buCancel AT ROW 4.14 COL 50.5
     fiTextIm AT ROW 2.29 COL 26 COLON-ALIGNED NO-LABEL
     RECT-70 AT ROW 1.52 COL 4.5
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE 
         AT COL 3.5 ROW 1.78
         SIZE 75 BY 6.52
         BGCOLOR 3 
         TITLE "        นำ Text file ที่ส่งออก แปลงเป็น Excel file".


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
         TITLE              = "wactas3.w - นำ Text file ที่ส่งออก แปลงเป็น Excel file"
         HEIGHT             = 8.14
         WIDTH              = 80.67
         MAX-HEIGHT         = 16
         MAX-WIDTH          = 80.67
         VIRTUAL-HEIGHT     = 16
         VIRTUAL-WIDTH      = 80.67
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
/* REPARENT FRAME */
ASSIGN FRAME frImport:FRAME = FRAME DEFAULT-FRAME:HANDLE.

/* SETTINGS FOR FRAME DEFAULT-FRAME
                                                                        */
/* SETTINGS FOR FRAME frImport
                                                                        */
ASSIGN 
       btn_file:AUTO-RESIZE IN FRAME frImport      = TRUE.

/* SETTINGS FOR FILL-IN fiTextIm IN FRAME frImport
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* wactas3.w - นำ Text file ที่ส่งออก แปลงเป็น Excel file */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* wactas3.w - นำ Text file ที่ส่งออก แปลงเป็น Excel file */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frImport
&Scoped-define SELF-NAME btnImOK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnImOK C-Win
ON CHOOSE OF btnImOK IN FRAME frImport /* OK */
DO: 
    DO WITH FRAME frImpot:
        ASSIGN
            fiImport = INPUT fiImport
            raTo      = INPUT raTo.
   ASSIGN 
        FRAME frImport fiImport fiImport.

        /*fiImport = SEARCH ("DATA\" + fiImport).*/

    IF INPUT fiImport = ? THEN DO:
        MESSAGE "ไม่พบไฟล์ข้อมูล : " fiImport VIEW-AS ALERT-BOX INFORMATION.
        APPLY "ENTRY" TO fiImport.
        RETURN NO-APPLY.
    END.
    ELSE MESSAGE "พบไฟล์ข้อมูล : " fiImport VIEW-AS ALERT-BOX INFORMATION.

    FOR EACH wImpTas :  DELETE wImpTas.  END.

    IF raTo = 1 THEN DO:
        RUN pdImpTas.
        RUN pdExpTas.
    END.
   
   END. /* do with frame frImport */
     
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_file
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_file C-Win
ON CHOOSE OF btn_file IN FRAME frImport /* ... */
DO:
    DEFINE VARIABLE cvData        AS CHARACTER NO-UNDO.
    DEFINE VARIABLE OKpressed AS LOGICAL INITIAL TRUE.

    DO WITH FRAME frImport:

    SYSTEM-DIALOG GET-FILE cvData
         TITLE       "Choose Data File to Import ..."
         /*FILTERS  "Text Files (*.txt)" "*.txt"*/
                    
         MUST-EXIST
         USE-FILENAME
         UPDATE OKpressed.
       
     IF OKpressed = TRUE THEN DO:
          fiImport = cvData. 
          DISP fiImport.
     END.
    
    END.


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buCancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buCancel C-Win
ON CHOOSE OF buCancel IN FRAME frImport /* Cancel */
DO:
  APPLY "CLOSE" TO THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiImport
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiImport C-Win
ON LEAVE OF fiImport IN FRAME frImport
DO:
  fiImport = INPUT fiImport.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME raTo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL raTo C-Win
ON VALUE-CHANGED OF raTo IN FRAME frImport
DO:
  raTo = INPUT raTo.
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
  
/*      RUN Wut\WutdiCen (FRAME Dialog-Frame:HANDLE).*/

  RUN Wut\WutwiCen (C-Win:HANDLE).
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
  ENABLE IMAGE-24 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  DISPLAY raTo fiImport fiTextIm 
      WITH FRAME frImport IN WINDOW C-Win.
  ENABLE RECT-70 raTo fiImport btn_file btnImOK buCancel 
      WITH FRAME frImport IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frImport}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdExpTas C-Win 
PROCEDURE pdExpTas :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR  vCount AS INT.

    DO WITH FRAME frImport:
        fiImport = INPUT fiImport.
    END.

    OUTPUT TO VALUE (STRING(fiImport + "EX" ) ) NO-ECHO.

        FOR EACH wImpTas BY wRecno .

        IF wRecno = 0 THEN DO:
            EXPORT DELIMITER ";"
                wRecno
                wName
                "Norpol"
                "Pol72"
                "Engine"
                "Cha_no"
                "Contractno"
                "Vehreg"
                "Comdat"
                
                "GrossPrem"
                "CompGrossPrem"
                "NetPrem"
                "CompNetPrem"
                "Tax"
                "NetPayment".
                
/*                IF wNorpol = "" THEN "Norpol" ELSE wNorpol
 *                 IF wPol72 = ""   THEN "Pol72" ELSE wPol72
 *                 IF wEngine = "" THEN "Engine" ELSE wEngine
 *                 IF wCha_no = "" THEN "Cha_no" ELSE wCha_no
 *                 IF wContractno = "" THEN "Contractno" ELSE wContractno
 *                 IF wVehreg = "" THEN "Vehreg" ELSE wVehreg
 *                 IF wComdat = "" THEN "Comdat" ELSE wComdat
 *                 
 *                 IF wGrossPrem           = "" THEN "GrossPrem" ELSE wGrossPrem
 *                 IF wCompGrossPrem = "" THEN "CompGrossPrem" ELSE wCompGrossPrem
 *                 IF wNetPrem               = "" THEN "NetPrem" ELSE wNetPrem
 *                 IF wCompNetPrem     = "" THEN "CompNetPrem" ELSE wCompNetPrem
 *                 IF wTax                       = "" THEN "Tax" ELSE wTax
 *                 IF wNetPayment        = "" THEN "NetPayment" ELSE wNetPayment.*/
        END.
        ELSE DO:
            EXPORT DELIMITER ";"
                wRecno
                wName
                wNorpol
                wPol72
                "'" + wEngine
                "'" + wCha_no
                "'" + wContractno
                "'" + wVehreg
                wComdat
                
                wGrossPrem
                wCompGrossPrem
                wNetPrem
                wCompNetPrem
                wTax
                wNetPayment.
        END.
                
            vCount = wRecno.

        END. /*each trnimp*/
    OUTPUT CLOSE.
    
    MESSAGE "ได้ข้อมูลทั้งสิ้น" SKIP(1)
                       "Output to file "  INT(vCount) - 1 " รายการ" SKIP
                       "File-Name :   " STRING(fiImport + "EX" ) VIEW-AS ALERT-BOX INFORMATION.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdImpTas C-Win 
PROCEDURE pdImpTas :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    i = 0.

    INPUT FROM VALUE (fiImport).   /*create in TEMP-TABLE wImpTas  */
        REPEAT:
            IMPORT UNFORMATTED c.
            CREATE wImpTas.
            ASSIGN
                wImpTas.wRecno         = i          /* 1 - 1 */
                wImpTas.wName          = SUBSTRING (c,2,60)        /* 2 - 61 */
                wImpTas.wNorpol        = SUBSTRING (c,62,26)      /* 62 - 87 */
                wImpTas.wPol72         = SUBSTRING (c,88,26)      /* 88 - 113 */
                wImpTas.wEngine        = SUBSTRING (c,114,26)    /* 114 - 139 */
                wImpTas.wCha_no        = SUBSTRING (c,140,26)    /* 140 - 265 */
                wImpTas.wContractno    = SUBSTRING (c,166,10)    /* 166 - 175 */
                wImpTas.wVehreg        = SUBSTRING (c,176,12)    /* 176 - 187 */
                wImpTas.wComDat        = SUBSTRING (c,188,2) + "/" + SUBSTRING (c,190,2) + "/" + SUBSTRING (c,192,4)

                wImpTas.wGrossPrem     = SUBSTRING (c,196,8) + "." +  SUBSTRING (c,204,2)    /* 196 - 205 */
                wImpTas.wCompGrossPrem = SUBSTRING (c,206,8) + "." +  SUBSTRING (c,214,2)    /* 206 - 215 */
                wImpTas.wNetPrem       = SUBSTRING (c,216,8) + "." +  SUBSTRING (c,224,2)    /* 216 - 225 */
                wImpTas.wCompNetPrem   = SUBSTRING (c,226,8) + "." +  SUBSTRING (c,234,2)    /* 226 - 235 */
                wImpTas.wTax           = SUBSTRING (c,236,8) + "." +  SUBSTRING (c,244,2)    /* 236 - 245 */
                wImpTas.wNetPayment    = SUBSTRING (c,246,8) + "." +  SUBSTRING (c,254,2) .  /* 246 - 255 */

                i = i + 1.

                DISP "data " fiImport "  "  i
                       WITH COLOR BLACK/WHITE NO-LABEL  FRAME frStat VIEW-AS DIALOG-BOX.

        END.  /*--- Repeat ---*/
    
    INPUT CLOSE.  /*close Import*/

    MESSAGE fiImport  SKIP
            "มีข้อมูล  " i  "รายการ"   VIEW-AS ALERT-BOX.

END PROCEDURE.


/***************************************************************************
 DISP "data " fiImport
        WITH COLOR BLACK/WHITE NO-LABEL  FRAME frStat VIEW-AS DIALOG-BOX.


    i = 0.

    INPUT FROM VALUE (fiImport).   /*create in TEMP-TABLE wImpTas  */
        REPEAT:
            IMPORT UNFORMATTED c.
            CREATE wImpTas.
            ASSIGN
                wImpTas.wRecno          = i          /* 1 - 1 */
                wImpTas.wName           = SUBSTRING (c,2,60)        /* 2 - 61 */
                wImpTas.wNorpol         = SUBSTRING (c,62,26)      /* 62 - 87 */
                wImpTas.wPol72           = SUBSTRING (c,88,26)      /* 88 - 113 */
                wImpTas.wEngine         = SUBSTRING (c,114,26)    /* 114 - 139 */
                wImpTas.wCha_no        = SUBSTRING (c,140,26)    /* 140 - 265 */
                wImpTas.wContractno  = SUBSTRING (c,166,10)    /* 166 - 175 */
                wImpTas.wVehreg        = SUBSTRING (c,176,12)    /* 176 - 187 */
                wImpTas.wComDat       = SUBSTRING (c,188,2) + "/" + SUBSTRING (c,190,2) + "/" + SUBSTRING (c,192,4)

/* SUBSTRING (c,188,8)      /* 188 - 195 */
*/

/*
                wImpTas.wComDat      = DATE (INTEGER (SUBSTRING (c,190,2)),  /* 188 - 195 */
                                                            INTEGER (SUBSTRING (c,188,2)),
                                                            INTEGER (SUBSTRING (c,192,4)) )
*/

                wImpTas.wGrossPrem            = SUBSTRING (c,196,8) + "." +  SUBSTRING (c,204,2)    /* 196 - 205 */

                wImpTas.wCompGrossPrem  = SUBSTRING (c,206,8) + "." +  SUBSTRING (c,214,2)    /* 206 - 215 */
                wImpTas.wNetPrem                = SUBSTRING (c,216,8) + "." +  SUBSTRING (c,224,2)    /* 216 - 225 */
                wImpTas.wCompNetPrem      = SUBSTRING (c,226,8) + "." +  SUBSTRING (c,234,2)    /* 226 - 235 */
                wImpTas.wTax                         = SUBSTRING (c,236,8) + "." +  SUBSTRING (c,244,2)    /* 236 - 245 */
                wImpTas.wNetPayment          = SUBSTRING (c,246,8) + "." +  SUBSTRING (c,254,2) .  /* 246 - 255 */

                i = i + 1.
                ACCUM  1 (COUNT).
        END.  /*--- Repeat ---*/
    
    INPUT CLOSE.  /*close Import*/

    MESSAGE fiImport
                        "มีข้อมูล  " (ACCUM  COUNT 1 )  "รายการ"   VIEW-AS ALERT-BOX.


*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

