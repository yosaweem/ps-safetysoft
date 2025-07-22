&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME wgwdel02
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS wgwdel02 
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

/*{wmc\wmcm0001.i}.*//*A52-0140*/

DEFINE SHARED VAR nv_Compno AS CHAR FORMAT "X(3)" NO-UNDO.
DEFINE SHARED VAR nv_Branch AS CHAR FORMAT "X(2)" NO-UNDO.
DEFINE SHARED VAR n_User    AS CHAR.
DEFINE SHARED VAR nv_Modno  AS CHAR.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME frDel

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-455 RECT-456 RECT-457 RECT-453 RECT-454 ~
raDel fiModNo fiModNoT btnDel fiBrand btnExit 
&Scoped-Define DISPLAYED-OBJECTS raDel fiModNo fiModNoT fiBrand 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wgwdel02 AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btnDel 
     LABEL "OK" 
     SIZE 13.5 BY 1.14
     FONT 6.

DEFINE BUTTON btnExit 
     LABEL "EXIT" 
     SIZE 13.5 BY 1.14
     FONT 6.

DEFINE VARIABLE fiBrand AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 17.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiModNo AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiModNoT AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE raDel AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Model No.", 1,
"Model Brand", 2,
"ALL", 3
     SIZE 17 BY 3.33
     BGCOLOR 8  NO-UNDO.

DEFINE RECTANGLE RECT-453
     EDGE-PIXELS 0  
     SIZE 78 BY 1.19
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-454
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 40 BY 4.29
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
     SIZE 20 BY 4.29
     BGCOLOR 8 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME frDel
     raDel AT ROW 2.67 COL 3 NO-LABEL
     fiModNo AT ROW 2.67 COL 20.67 COLON-ALIGNED NO-LABEL
     fiModNoT AT ROW 2.67 COL 41.33 COLON-ALIGNED NO-LABEL
     btnDel AT ROW 2.67 COL 63.5
     fiBrand AT ROW 3.86 COL 20.5 COLON-ALIGNED NO-LABEL
     btnExit AT ROW 4.81 COL 63.5
     "To :" VIEW-AS TEXT
          SIZE 3.67 BY .76 AT ROW 2.86 COL 39
          BGCOLOR 8 FONT 1
     "~{ ลบข้อมูล Model  ทั้งหมด }":200 VIEW-AS TEXT
          SIZE 24 BY .76 AT ROW 5.29 COL 22
          BGCOLOR 8 FGCOLOR 2 FONT 1
     "  ลบข้อมูล MODEL" VIEW-AS TEXT
          SIZE 18.5 BY .95 AT ROW 1 COL 32.5
          BGCOLOR 3 FGCOLOR 7 FONT 13
     RECT-455 AT ROW 4.33 COL 61
     RECT-456 AT ROW 2.19 COL 61
     RECT-457 AT ROW 2.19 COL 1
     RECT-453 AT ROW 1 COL 1
     RECT-454 AT ROW 2.19 COL 21
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 78 BY 5.86
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
  CREATE WINDOW wgwdel02 ASSIGN
         HIDDEN             = YES
         TITLE              = "wgwdel02 - Delete Model"
         HEIGHT             = 5.81
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
IF NOT wgwdel02:LOAD-ICON("wimage/safety.ico":U) THEN
    MESSAGE "Unable to load icon: wimage/safety.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW wgwdel02
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME frDel
                                                                        */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wgwdel02)
THEN wgwdel02:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME wgwdel02
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wgwdel02 wgwdel02
ON END-ERROR OF wgwdel02 /* wgwdel02 - Delete Model */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wgwdel02 wgwdel02
ON WINDOW-CLOSE OF wgwdel02 /* wgwdel02 - Delete Model */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnDel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnDel wgwdel02
ON CHOOSE OF btnDel IN FRAME frDel /* OK */
DO:
 DEF VAR logAns AS LOGI INIT No.  
 IF raDel = 1 THEN DO:
     IF fiModno = " " THEN DO:
        MESSAGE "กรุณาระบุ รหัสรุ่นรถที่ต้องการลบข้อมูล" VIEW-AS ALERT-BOX INFORMATION.
        APPLY "ENTRY" TO fiModno.
        RETURN NO-APPLY.
     END.
     ELSE DO:
        logAns = No.
        MESSAGE "ต้องการลบข้อมูลรุ่นรถ " + fiModNo  + " To " + fiModnoT + " ?" UPDATE logAns
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
        TITLE "ยืนยันการลบข้อมูล".
        IF logAns THEN DO:
            FOR EACH brstat.Model WHERE brstat.Model.compno = nv_Compno AND
                                        brstat.Model.Modno  >= fiModno  AND
                                        brstat.Model.Modno  <= fiModnoT EXCLUSIVE-LOCK.
                DELETE brstat.Model.
            END.
            RELEASE brStat.Model.
            MESSAGE "ลบข้อมูลเรียบร้อย ..." VIEW-AS ALERT-BOX INFORMATION.
        END. 
     END.       
 END.
 IF raDel = 2 THEN DO:
    IF fiBrand = " " THEN DO:
       MESSAGE "กรุณาระบุ รหัสเบี้ย เริ่มต้นที่ต้องการลบข้อมูล" VIEW-AS ALERT-BOX INFORMATION.
       APPLY "ENTRY" TO fiBrand.
       RETURN NO-APPLY.
    END.
    ELSE DO:
       logAns = No.
       MESSAGE "ต้องการลบข้อมูลรุ่นรถยี่ห้อ  " + fiBrand + " ?" UPDATE logAns
       VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
       TITLE "ยืนยันการลบข้อมูล".
       IF logAns THEN DO:  
          FOR EACH brstat.Model WHERE brstat.Model.compno = nv_Compno /*gComp*/ AND
                                      brstat.Model.Brand  = fiBrand EXCLUSIVE-LOCK.
              DELETE brstat.Model.
          END.
          RELEASE brStat.Model.
          MESSAGE "ลบข้อมูลเรียบร้อย ..." VIEW-AS ALERT-BOX INFORMATION.  
       END. 
     END.       
 END.
 IF raDel = 3 THEN DO:
    logAns = No.
    MESSAGE " คำเตือน ! ข้อมูลรุ่นรถจะถูกลบทั้งหมด"  SKIP
            " คุณต้องการที่จะลบข้อข้อมูลทั้งหมด  ใช่หรือไม่ ?" UPDATE logAns 
    VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
    TITLE "ยืนยันการลบข้อมูล".   
          
    IF logAns THEN DO:  
       FOR EACH brstat.Model WHERE brstat.Model.compno = nv_Compno /*gComp*/  EXCLUSIVE-LOCK.
           DELETE brstat.Model.
       END.
       RELEASE brStat.Model.
       MESSAGE "ลบข้อมูลเรียบร้อย ..." VIEW-AS ALERT-BOX INFORMATION. 
    END.      
 END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnExit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnExit wgwdel02
ON CHOOSE OF btnExit IN FRAME frDel /* EXIT */
DO:
    APPLY "CLOSE" TO THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiBrand
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBrand wgwdel02
ON LEAVE OF fiBrand IN FRAME frDel
DO:
  fiBrand = INPUT fiBrand.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiModNo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiModNo wgwdel02
ON LEAVE OF fiModNo IN FRAME frDel
DO:
  fiModno = INPUT fiModno.
  fiModnoT = fiModno.
  DISP fiModnoT WITH FRAME frDel.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiModNoT
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiModNoT wgwdel02
ON LEAVE OF fiModNoT IN FRAME frDel
DO:
  fiModnoT = INPUT fiModnoT.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME raDel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL raDel wgwdel02
ON VALUE-CHANGED OF raDel IN FRAME frDel
DO:
  raDel = INPUT raDel.
  
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK wgwdel02 


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
  RUN wut\WUTDICEN (wgwdel02:HANDLE).
  ASSIGN
      raDel  = 1
      fiModno = nv_Modno.
  
  DISP raDel  WITH FRAME frDel. 
  DISP fimodno WITH FRAME frdel.
  APPLY "ENTRY" TO fiModno IN FRAME frDel.
  RELEASE brStat.Model.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI wgwdel02  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wgwdel02)
  THEN DELETE WIDGET wgwdel02.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI wgwdel02  _DEFAULT-ENABLE
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
  DISPLAY raDel fiModNo fiModNoT fiBrand 
      WITH FRAME frDel IN WINDOW wgwdel02.
  ENABLE RECT-455 RECT-456 RECT-457 RECT-453 RECT-454 raDel fiModNo fiModNoT 
         btnDel fiBrand btnExit 
      WITH FRAME frDel IN WINDOW wgwdel02.
  {&OPEN-BROWSERS-IN-QUERY-frDel}
  VIEW wgwdel02.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

