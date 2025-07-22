&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME wgwdel01
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS wgwdel01 
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

/*{wmc\wmcm0001.i}.*/

DEFINE SHARED VAR nv_Compno AS CHAR FORMAT "X(3)" NO-UNDO.
DEFINE SHARED VAR nv_Branch AS CHAR FORMAT "X(2)" NO-UNDO.
DEFINE SHARED VAR n_User    AS CHAR.
DEFINE SHARED VAR nv_Tarno  AS CHAR.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME frDel

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-457 RECT-454 RECT-455 RECT-456 RECT-453 ~
raDel fiTarno fiTarnoT btnDel fiSTRTarNo btnExit 
&Scoped-Define DISPLAYED-OBJECTS raDel fiTarno fiTarnoT fiSTRTarNo 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wgwdel01 AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btnDel 
     LABEL "OK" 
     SIZE 13.5 BY 1.14
     FONT 6.

DEFINE BUTTON btnExit 
     LABEL "EXIT" 
     SIZE 13.5 BY 1.14
     FONT 6.

DEFINE VARIABLE fiSTRTarNo AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 3.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiTarno AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 9.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiTarnoT AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 9.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE raDel AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Tariff No.", 1,
"ALL Start by.", 2,
"ALL", 3
     SIZE 17 BY 3.33
     BGCOLOR 8  NO-UNDO.

DEFINE RECTANGLE RECT-453
     EDGE-PIXELS 0  
     SIZE 78 BY 1.19
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-454
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 40 BY 4.14
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-455
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 18 BY 2
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-456
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 18 BY 2.1
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-457
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 20 BY 4.14
     BGCOLOR 8 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME frDel
     raDel AT ROW 2.67 COL 3 NO-LABEL
     fiTarno AT ROW 2.67 COL 20.5 COLON-ALIGNED NO-LABEL
     fiTarnoT AT ROW 2.67 COL 36.33 COLON-ALIGNED NO-LABEL
     btnDel AT ROW 2.67 COL 63.5
     fiSTRTarNo AT ROW 3.86 COL 20.5 COLON-ALIGNED NO-LABEL
     btnExit AT ROW 4.81 COL 63.5
     "  ลบข้อมูล Tariff" VIEW-AS TEXT
          SIZE 18.5 BY .95 AT ROW 1 COL 32.5
          BGCOLOR 3 FGCOLOR 7 FONT 13
     "~{ ลบข้อมูล Tariff  ทั้งหมด }":200 VIEW-AS TEXT
          SIZE 24 BY .76 AT ROW 5.29 COL 22
          BGCOLOR 8 FGCOLOR 2 FONT 1
     "~{ N : รถใหม่ / O : รถเก่า / R : รถต่ออายุ }":200 VIEW-AS TEXT
          SIZE 33 BY .76 AT ROW 4.1 COL 27
          BGCOLOR 8 FGCOLOR 2 FONT 1
     "To :" VIEW-AS TEXT
          SIZE 4.5 BY .76 AT ROW 2.81 COL 33.5
          BGCOLOR 8 FONT 1
     RECT-457 AT ROW 2.19 COL 1
     RECT-454 AT ROW 2.19 COL 21
     RECT-455 AT ROW 4.33 COL 61
     RECT-456 AT ROW 2.19 COL 61
     RECT-453 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 78 BY 5.52
         BGCOLOR 3 FONT 5.


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
  CREATE WINDOW wgwdel01 ASSIGN
         HIDDEN             = YES
         TITLE              = "wgwdel01 - Delete Model"
         HEIGHT             = 5.52
         WIDTH              = 78
         MAX-HEIGHT         = 33.91
         MAX-WIDTH          = 170.67
         VIRTUAL-HEIGHT     = 33.91
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
IF NOT wgwdel01:LOAD-ICON("wimage/safety.ico":U) THEN
    MESSAGE "Unable to load icon: wimage/safety.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW wgwdel01
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME frDel
                                                                        */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wgwdel01)
THEN wgwdel01:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME wgwdel01
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wgwdel01 wgwdel01
ON END-ERROR OF wgwdel01 /* wgwdel01 - Delete Model */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wgwdel01 wgwdel01
ON WINDOW-CLOSE OF wgwdel01 /* wgwdel01 - Delete Model */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnDel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnDel wgwdel01
ON CHOOSE OF btnDel IN FRAME frDel /* OK */
DO:
 DEF VAR logAns AS LOGI INIT No.
 IF raDel = 1 THEN DO:
     IF fiTarno = " " THEN DO:
        MESSAGE "กรุณาระบุ รหัสเบี้ยที่ต้องการลบข้อมูล" VIEW-AS ALERT-BOX INFORMATION.
        APPLY "ENTRY" TO fiTarno.
        RETURN NO-APPLY.
     END.
     ELSE DO:
        logAns = NO.
        MESSAGE "ต้องการลบข้อมูลรายการ " + fiTarNo + " To " + fiTarnoT + " ?" UPDATE logAns
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
        TITLE "ยืนยันการลบข้อมูล".
         IF logAns THEN DO:
            FOR EACH brStat.Tariff WHERE brStat.Tariff.compno = nv_Compno AND
                     brStat.Tariff.Tarno >= fiTarno AND
                     brstat.Tariff.Tarno <= fiTarNoT EXCLUSIVE-LOCK.
                DELETE brStat.Tariff.
            END.
            RELEASE brStat.Tariff.
            MESSAGE "ลบข้อมูลเรียบร้อย ..." VIEW-AS ALERT-BOX INFORMATION.
         END.
     END.
 END.
 IF raDel = 2 THEN DO:
   IF fiSTRTarNo = " " THEN DO:
      MESSAGE "กรุณาระบุ รหัสเบี้ย เริ่มต้นที่ต้องการลบข้อมูล" VIEW-AS ALERT-BOX INFORMATION.
      APPLY "ENTRY" TO fiTarno.
      RETURN NO-APPLY.
   END.
   ELSE DO:
        logAns = No.
        MESSAGE "ต้องการลบข้อมูลรายการที่รหัสเบี้ยขึ้นต้นด้วย " + fiSTRTarNo  + " ?" UPDATE logAns 
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
        TITLE "ยืนยันการลบข้อมูล".
        IF logAns THEN DO:
           FOR EACH brStat.Tariff WHERE brStat.Tariff.compno = nv_Compno AND
               SUBSTRING(brStat.Tariff.Tarno,1,1) = fiSTRTarNo EXCLUSIVE-LOCK.
               DELETE brStat.Tariff.
           END.
           RELEASE brStat.Tariff.
           MESSAGE "ลบข้อมูลเรียบร้อย ..." VIEW-AS ALERT-BOX INFORMATION. 
        END. 
   END.       
 END.
 IF raDel = 3 THEN DO:
    logAns = No.
    MESSAGE " คำเตือน ! ข้อมูลเบี้ยประกันจะถูกลบทั้งหมด"  SKIP
            " คุณต้องการที่จะลบข้อข้อมูลทั้งหมด  ใช่หรือไม่ ?" UPDATE logAns
    VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
    TITLE "ยืนยันการลบข้อมูล".
    IF logAns THEN DO:  
       FOR EACH brStat.Tariff WHERE brStat.Tariff.compno = nv_Compno  EXCLUSIVE-LOCK.
           DELETE brStat.Tariff.
       END.
       RELEASE brStat.Tariff.
       MESSAGE "ลบข้อมูลเรียบร้อย ..." VIEW-AS ALERT-BOX INFORMATION. 
    END.      
 END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnExit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnExit wgwdel01
ON CHOOSE OF btnExit IN FRAME frDel /* EXIT */
DO:
    APPLY "CLOSE" TO THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiSTRTarNo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiSTRTarNo wgwdel01
ON LEAVE OF fiSTRTarNo IN FRAME frDel
DO:
  fiSTRTarNo = INPUT fiSTRTarNo.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTarno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTarno wgwdel01
ON LEAVE OF fiTarno IN FRAME frDel
DO:
  fiTarno = INPUT fiTarno.
  fiTarnoT = fiTarno.
  DISP fiTarnot WITH FRAME frDel.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTarnoT
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTarnoT wgwdel01
ON LEAVE OF fiTarnoT IN FRAME frDel
DO:
  fiTarno = INPUT fiTarno.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME raDel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL raDel wgwdel01
ON VALUE-CHANGED OF raDel IN FRAME frDel
DO:
  raDel = INPUT raDel.
  
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK wgwdel01 


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
  
  SESSION:DATA-ENTRY-RETURN = Yes.
  RUN wut\WUTDICEN (wgwdel01:HANDLE).
  ASSIGN
      raDel  = 1
      fiTarno = nv_Tarno.
  DISP raDel  WITH FRAME frDel.
  DISP fiTarno WITH FRAME frDel.
  APPLY "ENTRY" TO fiTarno IN FRAME frDel.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI wgwdel01  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wgwdel01)
  THEN DELETE WIDGET wgwdel01.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI wgwdel01  _DEFAULT-ENABLE
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
  DISPLAY raDel fiTarno fiTarnoT fiSTRTarNo 
      WITH FRAME frDel IN WINDOW wgwdel01.
  ENABLE RECT-457 RECT-454 RECT-455 RECT-456 RECT-453 raDel fiTarno fiTarnoT 
         btnDel fiSTRTarNo btnExit 
      WITH FRAME frDel IN WINDOW wgwdel01.
  {&OPEN-BROWSERS-IN-QUERY-frDel}
  VIEW wgwdel01.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

