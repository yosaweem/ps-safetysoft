&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic_test         PROGRESS
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

  Created: 

  Modify By : TANTAWAN C.   26/01/2008   [A500178]
               ปรับ FORMAT branch เพื่อรองรับการขยายสาขา
  ขยาย FORMAT ของ acno จากเดิม "X(7)" เป็น "X(10)"             
------------------------------------------------------------------------*/
/*          This .W file was created with the Progress UIB.             */
/*----------------------------------------------------------------------*/

/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */

CREATE WIDGET-POOL.

/************   Program   **************
/* CREATE BY :  Patcharaporn Y.        y:\develop\sic_test\pat   */
Wac
        -Wactis1.w 
Whp
        -WhpBran.w

/* Modify By : Kanchana C.             A46-0463    27/11/2003 */

/*dot i สำหรับ v70   */
    {wac\wactis02.i}   /* head excel*/
    {wac\wactis03.i}   /* detail excel*/
    {wac\wactis06.i}   /* detail text file*/


/*dot i สำหรับ v72   */
    {wac\wactis04.i}   /* 03,04  head excel*/
    {wac\wactis05.i}   /* detail excel*/
    {wac\wactis07.i}   /* detail text file*/


************************************/

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

DEF  VAR n_acno     AS CHAR.
DEF  VAR n_name     AS CHAR.
DEF  VAR n_chkname  AS CHAR FORMAT "x(1)".
DEF NEW SHARED  VAR n_agent1  LIKE xmm600.acno FORMAT "X(10)".
DEF NEW SHARED  VAR n_agent2  LIKE xmm600.acno FORMAT "X(10)".

DEF TEMP-TABLE wacno
        FIELD acno  AS CHAR  FORMAT "x(10)"
        FIELD name  AS CHAR  FORMAT "x(50)"
INDEX  wacno IS UNIQUE PRIMARY acno.

DEF  VAR  n_status AS CHAR.
DEF  VAR  nv_line  AS INT.
DEF  VAR  nv_Row   AS RECID.
DEF  VAR  i        AS INTE.

DEF NEW SHARED VAR n_check AS DECI.


DEF                 VAR nv_acno AS CHAR FORMAT 'X(10)' EXTENT 30. /*--- A500178 --- ขยาย FORMAT จาก  "X(7)" เป็น "X(10)" ---*/

/*--- A500178 --- ขยาย FORMAT ของ nv_ac1 - nv_ac30 จากเดิม "X(7)" เป็น "X(10)" */
DEF SHARED VAR nv_ac1   AS CHAR FORMAT 'X(10)'.
DEF SHARED VAR nv_ac2   AS CHAR FORMAT 'X(10)'.
DEF SHARED VAR nv_ac3   AS CHAR FORMAT 'X(10)'.
DEF SHARED VAR nv_ac4   AS CHAR FORMAT 'X(10)'.
DEF SHARED VAR nv_ac5   AS CHAR FORMAT 'X(10)'.
DEF SHARED VAR nv_ac6   AS CHAR FORMAT 'X(10)'.
DEF SHARED VAR nv_ac7   AS CHAR FORMAT 'X(10)'.
DEF SHARED VAR nv_ac8   AS CHAR FORMAT 'X(10)'.
DEF SHARED VAR nv_ac9   AS CHAR FORMAT 'X(10)'.
DEF SHARED VAR nv_ac10  AS CHAR FORMAT 'X(10)'.
DEF SHARED VAR nv_ac11  AS CHAR FORMAT 'X(10)'.
DEF SHARED VAR nv_ac12  AS CHAR FORMAT 'X(10)'.
DEF SHARED VAR nv_ac13  AS CHAR FORMAT 'X(10)'.
DEF SHARED VAR nv_ac14  AS CHAR FORMAT 'X(10)'.
DEF SHARED VAR nv_ac15  AS CHAR FORMAT 'X(10)'.
DEF SHARED VAR nv_ac16  AS CHAR FORMAT 'X(10)'.
DEF SHARED VAR nv_ac17  AS CHAR FORMAT 'X(10)'.
DEF SHARED VAR nv_ac18  AS CHAR FORMAT 'X(10)'.
DEF SHARED VAR nv_ac19  AS CHAR FORMAT 'X(10)'.
DEF SHARED VAR nv_ac20  AS CHAR FORMAT 'X(10)'.
DEF SHARED VAR nv_ac21  AS CHAR FORMAT 'X(10)'.
DEF SHARED VAR nv_ac22  AS CHAR FORMAT 'X(10)'.
DEF SHARED VAR nv_ac23  AS CHAR FORMAT 'X(10)'.
DEF SHARED VAR nv_ac24  AS CHAR FORMAT 'X(10)'.
DEF SHARED VAR nv_ac25  AS CHAR FORMAT 'X(10)'.
DEF SHARED VAR nv_ac26  AS CHAR FORMAT 'X(10)'.
DEF SHARED VAR nv_ac27  AS CHAR FORMAT 'X(10)'.
DEF SHARED VAR nv_ac28  AS CHAR FORMAT 'X(10)'.
DEF SHARED VAR nv_ac29  AS CHAR FORMAT 'X(10)'.
DEF SHARED VAR nv_ac30  AS CHAR FORMAT 'X(10)'.

DEF SHARED VAR nv_acnoAll AS CHAR.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME brAcno

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES wacno

/* Definitions for BROWSE brAcno                                        */
&Scoped-define FIELDS-IN-QUERY-brAcno wacno.acno wacno.name   
&Scoped-define ENABLED-FIELDS-IN-QUERY-brAcno   
&Scoped-define SELF-NAME brAcno
&Scoped-define QUERY-STRING-brAcno FOR EACH wacno BY  acno
&Scoped-define OPEN-QUERY-brAcno OPEN QUERY brAcno FOR EACH wacno BY  acno.
&Scoped-define TABLES-IN-QUERY-brAcno wacno
&Scoped-define FIRST-TABLE-IN-QUERY-brAcno wacno


/* Definitions for FRAME DEFAULT-FRAME                                  */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-12 RECT-2 RECT-11 RECT-1 RECT-3 fi_acno ~
bu_help brAcno bu_save bu_del bu_exit fi_name 
&Scoped-Define DISPLAYED-OBJECTS fi_acno fi_name 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_del 
     LABEL "Delete" 
     SIZE 10 BY 1.14.

DEFINE BUTTON bu_exit 
     LABEL "Exit" 
     SIZE 9.5 BY 1.14.

DEFINE BUTTON bu_help 
     LABEL "..." 
     SIZE 3 BY 1.

DEFINE BUTTON bu_save 
     LABEL "Save" 
     SIZE 10 BY 1.14.

DEFINE VARIABLE fi_acno AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_name AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 51.5 BY 1
     BGCOLOR 19 FGCOLOR 0  NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 13 BY 1.57
     BGCOLOR 32 .

DEFINE RECTANGLE RECT-11
     EDGE-PIXELS 4 GRAPHIC-EDGE  
     SIZE 78.5 BY 12
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-12
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 66 BY 2.1.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 13 BY 1.57
     BGCOLOR 32 .

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 12.5 BY 1.57
     BGCOLOR 32 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brAcno FOR 
      wacno SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brAcno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brAcno C-Win _FREEFORM
  QUERY brAcno DISPLAY
      wacno.acno  FORMAT "X(10)"
      wacno.name
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 68 BY 9.14
         BGCOLOR 15 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     fi_acno AT ROW 2.81 COL 12.5 COLON-ALIGNED NO-LABEL
     bu_help AT ROW 2.81 COL 26.67
     brAcno AT ROW 4.38 COL 14.5
     bu_save AT ROW 14.81 COL 28
     bu_del AT ROW 14.81 COL 45
     bu_exit AT ROW 14.81 COL 61.5
     fi_name AT ROW 2.81 COL 29 COLON-ALIGNED NO-LABEL
     RECT-12 AT ROW 3.33 COL 14.5
     RECT-2 AT ROW 14.57 COL 43.5
     RECT-11 AT ROW 2.05 COL 9
     RECT-1 AT ROW 14.57 COL 26.5
     RECT-3 AT ROW 14.57 COL 60
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 93.17 BY 16
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
         TITLE              = "wactis2 - เลือกรหัสตัวแทน"
         HEIGHT             = 15.95
         WIDTH              = 93
         MAX-HEIGHT         = 24.05
         MAX-WIDTH          = 133.33
         VIRTUAL-HEIGHT     = 24.05
         VIRTUAL-WIDTH      = 133.33
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
IF NOT C-Win:LOAD-ICON("wimage/safety.ico":U) THEN
    MESSAGE "Unable to load icon: wimage/safety.ico"
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
/* BROWSE-TAB brAcno bu_help DEFAULT-FRAME */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brAcno
/* Query rebuild information for BROWSE brAcno
     _START_FREEFORM
OPEN QUERY brAcno FOR EACH wacno BY  acno.
     _END_FREEFORM
     _Query            is NOT OPENED
*/  /* BROWSE brAcno */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* wactis2 - เลือกรหัสตัวแทน */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* wactis2 - เลือกรหัสตัวแทน */
DO:
  /* This event will close the window and terminate the procedure.  */
  /*
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
  */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_del
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_del C-Win
ON CHOOSE OF bu_del IN FRAME DEFAULT-FRAME /* Delete */
DO:
    n_status     =     "DELETE".    
  
    GET CURRENT brAcno EXCLUSIVE-LOCK NO-WAIT. 
     nv_row  = RECID(wacno).  
 
    FIND  wacno  where recid(wacno) = nv_row  NO-LOCK
                                   NO-ERROR NO-WAIT.

     IF Avail wacno THEN DO:                                    
         Assign
             fi_acno    = wacno.acno  
             fi_name    = wacno.name.
     END.            
     
      Disp  fi_acno  fi_name With Frame {&frame-name}.
    Apply "Choose" to bu_save.
    Return no-apply.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit C-Win
ON CHOOSE OF bu_exit IN FRAME DEFAULT-FRAME /* Exit */
DO:
assign 
 i = 0
 nv_acno = ""

 nv_ac1   = "" nv_ac2   = "" nv_ac3   = "" nv_ac4   = ""  nv_ac5   = ""
 nv_ac6   = "" nv_ac7   = "" nv_ac8   = "" nv_ac9   = ""  nv_ac10 = ""
 nv_ac11 = "" nv_ac12 = "" nv_ac13 = "" nv_ac14 = ""  nv_ac15 = ""
 nv_ac16 = "" nv_ac17 = "" nv_ac18 = "" nv_ac19 = ""  nv_ac20 = ""
 nv_ac21 = "" nv_ac22 = "" nv_ac23 = "" nv_ac24 = ""  nv_ac25 = ""
 nv_ac26 = "" nv_ac27 = "" nv_ac28 = "" nv_ac29 = ""  nv_ac30 = "".

 
find first wacno no-lock no-error no-wait.
if avail wacno then do:
   nv_acno[1]  = wacno.acno.
   nv_ac1         = nv_acno[1].
   loop1:
   repeat i = 2 to 30:

     find next wacno no-lock no-error no-wait.
     if avail wacno then  do:
            nv_acno[i] = wacno.acno.
     end. 
     else 
           leave loop1.

        IF i = 2   THEN nv_ac2   = nv_acno[2].
        IF i = 3   THEN nv_ac3   = nv_acno[3].
        IF i = 4   THEN nv_ac4   = nv_acno[4].        
        IF i = 5   THEN nv_ac5   = nv_acno[5].
        IF i = 6   THEN nv_ac6   = nv_acno[6].
        IF i = 7   THEN nv_ac7   = nv_acno[7].
        IF i = 8   THEN nv_ac8   = nv_acno[8].  
        IF i = 9   THEN nv_ac9   = nv_acno[9].
        IF i = 10 THEN nv_ac10 = nv_acno[10].
        IF i = 11 THEN nv_ac11 = nv_acno[11].
        IF i = 12  THEN nv_ac12 = nv_acno[12].
        IF i = 13  THEN nv_ac13 = nv_acno[13].
        IF i = 14  THEN nv_ac14 = nv_acno[14].        
        IF i = 15  THEN nv_ac15 = nv_acno[15].
        IF i = 16  THEN nv_ac16 = nv_acno[16].
        IF i = 17  THEN nv_ac17 = nv_acno[17].
        IF i = 18  THEN nv_ac18 = nv_acno[18].  
        IF i = 19  THEN nv_ac19 = nv_acno[19].
        IF i = 20 THEN nv_ac20 = nv_acno[20].
        IF i = 21  THEN nv_ac21 = nv_acno[21].
        IF i = 22  THEN nv_ac22 = nv_acno[22].
        IF i = 23  THEN nv_ac23 = nv_acno[23].
        IF i = 24  THEN nv_ac24 = nv_acno[24].        
        IF i = 25  THEN nv_ac25 = nv_acno[25].
        IF i = 26  THEN nv_ac26 = nv_acno[26].
        IF i = 27  THEN nv_ac27 = nv_acno[27].
        IF i = 28  THEN nv_ac28 = nv_acno[28].  
        IF i = 29  THEN nv_ac29 = nv_acno[29].
        IF i = 30  THEN nv_ac30 = nv_acno[30].                
     
   end. /*repeat*/
   
end.     





  APPLY "CLOSE" TO THIS-PROCEDURE.  
  Return no-apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_help
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_help C-Win
ON CHOOSE OF bu_help IN FRAME DEFAULT-FRAME /* ... */
DO:
    n_chkname = "1".
   RUN whp\whpacno (input-output  n_name,input-output n_chkname).
     
   Assign    
        fi_acno = n_agent1
        fi_name = n_name.
        
   disp fi_acno fi_name with frame {&frame-name}.
           

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_save
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_save C-Win
ON CHOOSE OF bu_save IN FRAME DEFAULT-FRAME /* Save */
DO: 
/*
   DISABLE fi_acno fi_name WITH FRAME {&FRAME-NAME}. 
   */   
  
      IF    n_status =  "ADD" THEN  DO:        
            RUN  pd_add.  
      END.
      ELSE IF n_status = "DELETE" THEN DO:
            RUN  pd_del.
      END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_save C-Win
ON RETURN OF bu_save IN FRAME DEFAULT-FRAME /* Save */
DO:
      IF    n_status =  "ADD" THEN  DO:        
             RUN  pd_add.  
      END.
      ELSE IF n_status = "DELETE" THEN DO:
                RUN pd_del.
      END.
      
 
                Apply "Entry" to fi_acno IN FRAME {&FRAME-NAME}.
                Return no-apply.                       
            
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_acno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_acno C-Win
ON LEAVE OF fi_acno IN FRAME DEFAULT-FRAME
DO:
        n_status     =     "ADD".

        fi_acno = CAPS(INPUT fi_acno).
  
        IF fi_acno <> "" THEN DO:
            FIND FIRST xmm600 WHERE xmm600.acno = fi_acno NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL xmm600 THEN
                fi_name = xmm600.ntitle + xmm600.fname + xmm600.name.                
            ELSE  DO:
                Message "ไม่พบ้อมูล " fi_acno "นี้" view-as alert-box Error.
                Apply "Entry" to fi_acno.
                Return no-apply.                       
            END.             
            DISP fi_acno fi_name WITH FRAME {&FRAME-NAME}.          
            
        END.   /*fi_acno*/

        
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_acno C-Win
ON RETURN OF fi_acno IN FRAME DEFAULT-FRAME
DO:
        n_status     =     "ADD".

        fi_acno = INPUT fi_acno.
  
        IF fi_acno <> "" THEN DO:
            FIND FIRST xmm600 WHERE xmm600.acno = fi_acno NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL xmm600 THEN
                fi_name = xmm600.ntitle + xmm600.fname + xmm600.name.                
            ELSE  DO:
                Message "ไม่พบ้อมูล " fi_acno "นี้" view-as alert-box Error.
                Apply "Entry" to fi_acno.
                Return no-apply.                       
            END.             
            DISP fi_acno fi_name WITH FRAME {&FRAME-NAME}.          
            
        END.   /*fi_acno*/

    APPLY "ENTRY" TO bu_save IN FRAME {&FRAME-NAME}.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brAcno
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

    RUN Wut\Wutwicen (C-Win:HANDLE).

/*
  ASSIGN
      nv_ac1   = ""   nv_ac2   = ""     nv_ac3   = ""  nv_ac4   = "" nv_ac5   = ""
      nv_ac6   = ""   nv_ac7   = ""     nv_ac8   = ""  nv_ac9   = "" nv_ac10 = ""
      nv_ac11 = ""   nv_ac12 = ""     nv_ac13 = ""  nv_ac14 = "" nv_ac15 = ""
      nv_ac16 = ""   nv_ac17 = ""     nv_ac18 = ""  nv_ac19 = "" nv_ac20 = ""
      nv_ac21 = ""   nv_ac22 = ""     nv_ac23 = ""  nv_ac24 = "" nv_ac25 = ""
      nv_ac26 = ""   nv_ac27 = ""     nv_ac28 = ""  nv_ac29 = "" nv_ac30 = "".
*/

  /**********************/    
/*Open Query brAcno  For Each wacno  Where
 *                                                          wacno.acno     = fi_acno   NO-LOCK.*/
  
   SESSION:DATA-ENTRY-RETURN   =   YES.
   APPLY "ENTRY" TO fi_acno.  

    RUN pdAddAcno.

    RUN pdUpdateQ.
  
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
  DISPLAY fi_acno fi_name 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE RECT-12 RECT-2 RECT-11 RECT-1 RECT-3 fi_acno bu_help brAcno bu_save 
         bu_del bu_exit fi_name 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdAddAcno C-Win 
PROCEDURE pdAddAcno :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR i AS INT.
DEF VAR found AS INT.
DEF VAR start AS INT.

    i = 1 .

    start = 1.
    found = INDEX(nv_acnoAll,",",start).

    DO WHILE found > 0:

        FIND FIRST wacno WHERE wacno.acno = ENTRY( i , nv_acnoAll) NO-ERROR.
        IF NOT AVAIL  wacno THEN DO:

            FIND FIRST xmm600 WHERE xmm600.acno = ENTRY( i , nv_acnoAll) 
                                                 NO-LOCK NO-ERROR.
            IF AVAIL xmm600 THEN DO:
                CREATE wacno.
                ASSIGN
                    wacno.acno = xmm600.acno
                    wacno.name = xmm600.name.
                    
           END.

        END.
        ELSE NEXT.

        start = found + 1.
        found = INDEX(nv_acnoAll,",",start).
        i = i + 1.

    END.  /* DO WHILE */ 



END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdUpdateQ C-Win 
PROCEDURE pdUpdateQ :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    OPEN QUERY brAcno FOR EACH wacno BY  acno.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_add C-Win 
PROCEDURE pd_add :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO With Frame {&frame-name}.      

      FIND FIRST wacno   Where  wacno.acno  = fi_acno    NO-ERROR NO-WAIT.
             IF NOT AVAIL wacno THEN DO:
                 CREATE  wacno.   
                 
                  nv_row   =  RECID(wacno).  
                 ASSIGN  
                     wacno.acno    = INPUT fi_acno  
                     wacno.name    = INPUT fi_name.

                RUN pdUpdateQ.
/*p*/                                                                   
                  IF CAN-FIND (wacno) THEN DO:   
                      brAcno:SET-REPOSITIONED-ROW (5).     
                      REPOSITION brAcno TO Recid  Recid(wacno).     
                      brAcno:SELECT-FOCUSED-ROW ().   
      
                 END.                                                                       
/*p*/                                                                   
                                          
     END.   /*not avail wacno*/
     ELSE DO:
           MESSAGE "This Account No. is exist" VIEW-AS ALERT-BOX ERROR.

           ASSIGN
                fi_acno     = ""
                fi_name      = "".
                  
           DISP   fi_acno fi_name   WITH FRAME {&FRAME-NAME}.
 
           APPLY "ENTRY" To fi_acno IN FRAME {&FRAME-NAME}.
           RETURN NO-APPLY.   
      END.      /*avail wacno*/      
END.       /*do*/ 
     

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_del C-Win 
PROCEDURE pd_del :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    
   IF  fi_acno <> "" THEN DO:
        FIND FIRST wacno   Where  wacno.acno   = fi_acno    NO-ERROR NO-WAIT.
                                                     
        IF Avail wacno THEN DO:                      
            Message "Do you want to delete this Account No."  VIEW-AS ALERT-BOX QUESTION 
            BUTTONS Yes-No Title "Confirm Delete" UPDATE choice AS LOGICAL.    
            Case Choice :
                WHEN true THEN DO:
                    IF n_status = "DELETE" THEN DO:
          
                        DELETE wacno.
                    END.    /*del*/

                    RUN pdUpdateQ.
           
               END. /*true*/          
         
               WHEN FALSE THEN  DO: /*NO*/                
                    Apply "Entry" to brAcno IN FRAME {&FRAME-NAME}.
                    Return no-apply.    
           
               END. /*false*/
            END. /*case choice*/
        END. /*avail wacno*/
   END. /*fi_acno <> ""*/

    Assign
        fi_acno     = ""
        fi_name     = "".

    Disp fi_acno  fi_name WITH FRAME {&FRAME-NAME}.
    
    Apply "Choose" to fi_acno.
    Return no-apply.
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

