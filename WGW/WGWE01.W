&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS Dialog-Frame 
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

/*----------- Create By Nipawadee R. [A53-0211] 18/07/2010--------------*/
/*-----------Program Output to Garuntee Report AYCL---------------------*/   

/* ***************************  Definitions  ************************** */

DEF  VAR RB-DB-CONNECTION AS CHAR INIT "".
DEF  VAR RB-INCLUDE-RECORDS AS CHAR INIT "".  /*Can Override Filter*/
DEF  VAR RB-FILTER AS CHAR INIT "".
DEF  VAR RB-MEMO-FILE AS CHAR INIT "".
DEF  VAR RB-PRINT-DESTINATION AS CHAR INIT "?". /*Direct to Screen*/
DEF  VAR RB-PRINTER-NAME AS CHAR INIT "".
DEF  VAR RB-PRINTER-PORT AS CHAR INIT "".
DEF  VAR RB-OUTPUT-FILE AS CHAR INIT "".
DEF  VAR RB-NUMBER-COPIES AS INTE INIT 1.
DEF  VAR RB-BEGIN-PAGE AS INTE INIT 0.
DEF  VAR RB-END-PAGE AS INTE INIT 0.
DEF  VAR RB-TEST-PATTERN AS LOG INIT no.
DEF  VAR RB-WINDOW-TITLE AS CHAR INIT "".
DEF  VAR RB-DISPLAY-ERRORS AS LOG INIT yes.
DEF  VAR RB-DISPLAY-STATUS AS LOG INIT yes.
DEF  VAR RB-NO-WAIT AS LOG INIT no.
DEF  VAR RB-OTHER-PARAMETERS AS CHAR INIT "".

/* Parameters Definitions ---                                           */
DEF INPUT-OUTPUT PARAMETER n_destination AS CHAR.
DEF INPUT-OUTPUT PARAMETER n_printer     AS CHAR.
DEF INPUT-OUTPUT PARAMETER n_filename    AS CHAR.
DEF INPUT-OUTPUT PARAMETER n_print       AS LOGIC.

/* Local Variable Definitions ---                                       */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE DIALOG-BOX
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME Dialog-Frame

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS IMAGE-24 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE IMAGE IMAGE-24
     FILENAME "WIMAGE\bgc01":U
     SIZE 79.5 BY 7.57.

DEFINE BUTTON Btn_Cancel AUTO-GO 
     LABEL "Cancel" 
     SIZE 12 BY 1.14
     BGCOLOR 8 FONT 6.

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "OK" 
     SIZE 12 BY 1.14
     BGCOLOR 8 FONT 6.

DEFINE RECTANGLE RECT2
     EDGE-PIXELS 3 GRAPHIC-EDGE  
     SIZE 14.5 BY 4.19
     BGCOLOR 1 .

DEFINE VARIABLE cbPrtList AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 10
     LIST-ITEMS "cbPrtList" 
     DROP-DOWN-LIST
     SIZE 28 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiFile-Name AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 21.5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE rsOutput AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Item 1", 1,
"Item 2", 2,
"Item 3", 3
     SIZE 12.5 BY 3
     BGCOLOR 3 FGCOLOR 15  NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     IMAGE-24 AT ROW 1 COL 1
     SPACE(0.16) SKIP(0.00)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "wgwe01 - Output To Guaruntee Report AYCL".

DEFINE FRAME frMain
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 3.5 ROW 1.26
         SIZE 74 BY 6.78
         BGCOLOR 1 .

DEFINE FRAME frOutput
     rsOutput AT ROW 2.29 COL 2.5 NO-LABEL
     cbPrtList AT ROW 3.33 COL 17.5 COLON-ALIGNED NO-LABEL
     fiFile-Name AT ROW 4.43 COL 17.5 COLON-ALIGNED NO-LABEL
     " Output To":40 VIEW-AS TEXT
          SIZE 49 BY .95 TOOLTIP "การแสดงผล" AT ROW 1 COL 1
          BGCOLOR 8 FGCOLOR 0 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE 
         AT COL 4 ROW 1.78
         SIZE 49 BY 4.96
         BGCOLOR 3 .

DEFINE FRAME frOK
     Btn_OK AT ROW 2.05 COL 4
     Btn_Cancel AT ROW 3.62 COL 4
     RECT2 AT ROW 1.24 COL 2.5
    WITH DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 54.5 ROW 1.78
         SIZE 17.5 BY 4.96
         BGCOLOR 3 .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: DIALOG-BOX
   Allow: Basic,Browse,DB-Fields,Query
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* REPARENT FRAME */
ASSIGN FRAME frMain:FRAME = FRAME Dialog-Frame:HANDLE
       FRAME frOK:FRAME = FRAME frMain:HANDLE
       FRAME frOutput:FRAME = FRAME frMain:HANDLE.

/* SETTINGS FOR DIALOG-BOX Dialog-Frame
                                                                        */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

/* SETTINGS FOR FRAME frMain
                                                                        */

DEFINE VARIABLE XXTABVALXX AS LOGICAL NO-UNDO.

ASSIGN XXTABVALXX = FRAME frOutput:MOVE-BEFORE-TAB-ITEM (FRAME frOK:HANDLE)
/* END-ASSIGN-TABS */.

/* SETTINGS FOR FRAME frOK
                                                                        */
ASSIGN 
       FRAME frOK:SCROLLABLE       = FALSE.

/* SETTINGS FOR FRAME frOutput
                                                                        */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* wgwe01 - Output To Guaruntee Report AYCL */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frOK
&Scoped-define SELF-NAME Btn_Cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Cancel Dialog-Frame
ON CHOOSE OF Btn_Cancel IN FRAME frOK /* Cancel */
DO:
        n_print            = NO .

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK Dialog-Frame
ON CHOOSE OF Btn_OK IN FRAME frOK /* OK */
DO:

   DO WITH FRAME {&FRAME-NAME} :
        ASSIGN  
            FRAME frOutput rsOutput rsOutput
            FRAME frOutput cbPrtList cbPrtList
            FRAME frOutput fiFile-Name fiFile-Name.
    END.
   

    IF rsOutput = 3 THEN DO: 
        IF fiFile-Name = "" THEN DO:
            MESSAGE "Please input File-Name" VIEW-AS ALERT-BOX ERROR.
            RETURN NO-APPLY.
        END.

    END.


    ASSIGN
        n_destination = SUBSTR ("D A", rsOutput, 1)
        n_printer     = IF rsOutput = 2 THEN cbPrtList ELSE " "
        n_filename    = IF rsOutput = 3 THEN fiFile-Name ELSE " "
        n_print       = YES .


    IF      rsOutput   = 1  THEN      n_destination  = SUBSTR ("D A", rsOutput, 1). /*SCREEN */                             
    ELSE IF rsOutput   = 2  THEN      n_printer      = cbPrtList.    /*PRINTER*/ 
    ELSE IF rsOutput   = 3  THEN      n_filename     = fiFile-Name.  /*FILE         */      


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frOutput
&Scoped-define SELF-NAME rsOutput
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rsOutput Dialog-Frame
ON VALUE-CHANGED OF rsOutput IN FRAME frOutput
DO:
  ASSIGN {&SELF-NAME}.
  
  CASE rsOutput:
        WHEN 1 THEN  /* Screen */
          ASSIGN
           cbPrtList:SENSITIVE   = No
           fiFile-Name:SENSITIVE = No.
        WHEN 2 THEN  /* Printer */
          ASSIGN
           cbPrtList:SENSITIVE   = Yes
           fiFile-Name:SENSITIVE = No.
        WHEN 3 THEN  /* File */ 
        DO:
          ASSIGN
            cbPrtList:SENSITIVE   = No
            fiFile-Name:SENSITIVE = Yes. 
          APPLY "ENTRY" TO fiFile-Name.
        END.
  END CASE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME Dialog-Frame
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK Dialog-Frame 


/* ***************************  Main Block  *************************** */

/* Parent the dialog-box to the ACTIVE-WINDOW, if there is no parent.   */
IF VALID-HANDLE(ACTIVE-WINDOW) AND FRAME {&FRAME-NAME}:PARENT eq ?
THEN FRAME {&FRAME-NAME}:PARENT = ACTIVE-WINDOW.


/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.
  
      RUN Wut\WutdiCen (FRAME Dialog-Frame:HANDLE).
  
  DO WITH FRAME frOutput:
    ASSIGN
        rsOutput:Radio-Buttons = "Screen, 1,Printer, 2, File, 3" /*"หน้าจอ, 1,เครื่องพิมพ์, 2, File, 3" */
        rsOutput = 2
        
        cbPrtList:SENSITIVE    = Yes
        fiFile-Name:SENSITIVE  = No.
    DISPLAY rsOutput .
    
    RUN pdGetPrtList.
  END.
  
  WAIT-FOR GO OF FRAME {&FRAME-NAME}.
END.
RUN disable_UI.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI Dialog-Frame  _DEFAULT-DISABLE
PROCEDURE disable_UI :
/*------------------------------------------------------------------------------
  Purpose:     DISABLE the User Interface
  Parameters:  <none>
  Notes:       Here we clean-up the user-interface by deleting
               dynamic widgets we have created and/or hide 
               frames.  This procedure is usually called when
               we are ready to "clean-up" after running.
------------------------------------------------------------------------------*/
  /* Hide all frames. */
  HIDE FRAME Dialog-Frame.
  HIDE FRAME frMain.
  HIDE FRAME frOK.
  HIDE FRAME frOutput.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI Dialog-Frame  _DEFAULT-ENABLE
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
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
  VIEW FRAME frMain.
  {&OPEN-BROWSERS-IN-QUERY-frMain}
  DISPLAY rsOutput cbPrtList fiFile-Name 
      WITH FRAME frOutput.
  ENABLE rsOutput cbPrtList fiFile-Name 
      WITH FRAME frOutput.
  {&OPEN-BROWSERS-IN-QUERY-frOutput}
  ENABLE RECT2 Btn_OK Btn_Cancel 
      WITH FRAME frOK.
  {&OPEN-BROWSERS-IN-QUERY-frOK}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdGetPrtList Dialog-Frame 
PROCEDURE pdGetPrtList :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  def var printer-list  as character no-undo.
  def var port-list     as character no-undo.
  def var printer-count as integer no-undo.
  def var printer       as character no-undo format "x(32)".
  def var port          as character no-undo format "x(20)".

  run aderb/_prlist.p (output printer-list, output port-list,
                 output printer-count).

  ASSIGN
    cbPrtList:List-Items IN FRAME frOutput = printer-list
    cbPrtList = ENTRY (1, printer-list).
    
  DISP cbPrtList WITH FRAME frOutput.
  RB-PRINTER-NAME = cbPrtList:SCREEN-VALUE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

