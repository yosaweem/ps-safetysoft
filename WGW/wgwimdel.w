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
/************************************************************************
program id     :  wgwimdel.w
  program name :  Load text file deler code to excel file     
  create by    :  Kridtiya i. A52-0172  21/07/2009    
  copy write   : wuwnotex.w 
************************************************************************/
/*Modify by   : Kridtiya i.A53-0182  เพิ่มตัวเก็บ code producer,agent code to load text file*/
/*Modify By   : Porntiwa T. A59-0423 ปรับโปรแกรมรองรับการ Load สาขา NTL */


CREATE WIDGET-POOL.
/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

def  stream ns1.

DEF VAR num AS DECI INIT 0.
DEF VAR expyear AS DECI FORMAT "9999" .

/*DEFINE VAR nv_daily     AS CHARACTER FORMAT "X(2465)"     INITIAL ""  NO-UNDO.*/

DEFINE VAR nv_daily     AS CHARACTER FORMAT "X"     INITIAL ","  NO-UNDO.
DEFINE VAR nv_reccnt   AS  INT  INIT  0.
DEFINE VAR nv_completecnt    AS   INT   INIT  0.
DEFINE VAR nv_enttim   AS  CHAR          INIT  "".
def    var  nv_export    as  char  init  ""  format "X(8)".
def  stream  ns2.
DEFINE NEW SHARED WORKFILE wdetail2 NO-UNDO
    FIELD branch           AS CHAR FORMAT "x(5)" INIT ""   
    FIELD deler            AS CHAR FORMAT "x(50)" INIT ""    
    FIELD showroom         AS CHAR FORMAT "x(50)" INIT ""    
    FIELD id               AS CHAR FORMAT "x(10)" INIT ""    
    FIELD vatcode          AS CHAR FORMAT "x(10)" INIT ""  
    FIELD produno          AS CHAR FORMAT "x(10)" INIT ""   /*add Kridtiya i. A53-0182 21/06/2010  ..Producer code..*/
    FIELD agentno          AS CHAR FORMAT "x(10)" INIT "".  /*add Kridtiya i. A53-0182 21/06/2010  ..Agent    code..*/      
DEFINE NEW SHARED TEMP-TABLE wdetail
      FIELD branch      AS CHAR FORMAT "x(5)" INIT "" 
      FIELD entdat      AS CHAR FORMAT "x(10)" INIT ""     
      FIELD enttim      AS CHAR FORMAT "x(8)" INIT ""      
      FIELD trandat     AS CHAR FORMAT "x(10)" INIT ""     
      FIELD trantim     AS CHAR FORMAT "x(8)" INIT ""      
      FIELD poltyp      AS CHAR FORMAT "x(3)" INIT ""      
      FIELD policy      AS CHAR FORMAT "x(20)" INIT ""     
      FIELD renpol      AS CHAR FORMAT "x(16)" INIT ""     
      FIELD comdat      AS CHAR FORMAT "x(10)" INIT ""     
      FIELD expdat      AS CHAR FORMAT "x(10)" INIT ""     
      FIELD compul      AS CHAR FORMAT "x" INIT ""         
      FIELD tiname      AS CHAR FORMAT "x(15)" INIT ""     
      FIELD insnam      AS CHAR FORMAT "x(50)" INIT ""     
      FIELD iadd1       AS CHAR FORMAT "x(35)" INIT ""
      FIELD iadd2       AS CHAR FORMAT "x(35)" INIT ""
      FIELD iadd3       AS CHAR FORMAT "x(34)" INIT ""
      FIELD iadd4       AS CHAR FORMAT "x(20)" INIT ""
      FIELD prempa      AS CHAR FORMAT "x" INIT ""         
      FIELD subclass    AS CHAR FORMAT "x(3)" INIT ""      
      FIELD brand       AS CHAR FORMAT "x(30)" INIT ""
      FIELD model       AS CHAR FORMAT "x(50)" INIT ""
      FIELD cc          AS CHAR FORMAT "x(10)" INIT ""
      FIELD weight      AS CHAR FORMAT "x(10)" INIT ""
      FIELD seat        AS CHAR FORMAT "x(2)" INIT ""
      FIELD body        AS CHAR FORMAT "x(20)" INIT ""
      FIELD vehreg      AS CHAR FORMAT "x(10)" INIT ""     
      FIELD engno       AS CHAR FORMAT "x(20)" INIT ""     
      FIELD chasno      AS CHAR FORMAT "x(20)" INIT ""     
      FIELD caryear     AS CHAR FORMAT "x(4)" INIT ""      
      FIELD carprovi    AS CHAR FORMAT "x(2)" INIT ""      
      FIELD vehuse      AS CHAR FORMAT "x" INIT ""         
      FIELD garage      AS CHAR FORMAT "x" INIT ""         
      FIELD stk         AS CHAR FORMAT "x(15)" INIT ""     
      FIELD access      AS CHAR FORMAT "x" INIT ""         
      FIELD covcod      AS CHAR FORMAT "x" INIT ""         
      FIELD si          AS CHAR FORMAT "x(25)" INIT ""     
      FIELD volprem     AS CHAR FORMAT "x(20)" INIT ""     
      FIELD Compprem    AS CHAR FORMAT "x(20)" INIT ""     
      FIELD fleet       AS CHAR FORMAT "x(10)" INIT ""     
      FIELD ncb         AS CHAR FORMAT "x(10)" INIT "" 
      FIELD loadclm     AS CHAR FORMAT "x(10)" INIT ""     
      FIELD deductda    AS CHAR FORMAT "x(10)" INIT ""     
      FIELD deductpd    AS CHAR FORMAT "x(10)" INIT ""     
      FIELD benname     AS CHAR FORMAT "x(50)" INIT ""     
      FIELD n_user      AS CHAR FORMAT "x(10)" INIT ""     
      FIELD n_IMPORT    AS CHAR FORMAT "x(2)" INIT ""      
      FIELD n_export    AS CHAR FORMAT "x(2)" INIT ""      
      FIELD drivnam     AS CHAR FORMAT "x" INIT ""         
      FIELD drivnam1    AS CHAR FORMAT "x(50)" INIT ""    
      FIELD drivnam2    AS CHAR FORMAT "x(50)" INIT ""    
      FIELD drivbir1    AS CHAR FORMAT "X(10)" INIT ""    
      FIELD drivbir2    AS CHAR FORMAT "X(10)" INIT ""    
      FIELD drivage1    AS CHAR FORMAT "X(2)" INIT ""     
      FIELD drivage2    AS CHAR FORMAT "x(2)" INIT ""     
      FIELD cancel      AS CHAR FORMAT "x(2)" INIT ""     
      FIELD WARNING     AS CHAR FORMAT "X(30)" INIT ""
      FIELD comment     AS CHAR FORMAT "x(35)"  INIT ""   
      FIELD seat41      AS INTE FORMAT "99" INIT 0        
      FIELD pass        AS CHAR FORMAT "x"  INIT "n"      
      FIELD OK_GEN      AS CHAR FORMAT "X" INIT "Y"        
      FIELD comper      AS INTE INIT 0                     
      FIELD comacc      AS INTE INIT 0                     
      FIELD NO_41       AS INTE INIT 0                     
      FIELD NO_42       AS INTE INIT 0                     
      FIELD NO_43       AS INTE INIT 0                     
      FIELD tariff      AS CHAR FORMAT "x(2)" INIT ""      
      FIELD baseprem    AS DECI FORMAT ">,>>>,>>>,>>>,>>9" INIT  0
      FIELD cargrp      AS CHAR FORMAT "x(2)" INIT ""      
      FIELD producer    AS CHAR FORMAT "x(7)" INIT ""      
      FIELD agent       AS CHAR FORMAT "x(7)" INIT ""      
      FIELD inscod      AS CHAR INIT ""   
      FIELD premt       AS CHAR FORMAT "x(10)" INIT ""
      FIELD redbook     AS CHAR INIT "" FORMAT "X(8)"    
      FIELD base        AS CHAR INIT "" FORMAT "x(8)"    
      FIELD accdat      AS CHAR INIT "" FORMAT "x(10)"   
      FIELD docno       AS CHAR INIT "" FORMAT "x(10)"   
      FIELD ICNO        AS CHAR INIT "" FORMAT "x(13)"   
      FIELD CoverNote   AS CHAR INIT "" FORMAT "x(13)"   
      FIELD nmember     AS CHAR INIT "" FORMAT "x(13)"
      FIELD deler       AS CHAR FORMAT "x(40)" INIT ""   
      FIELD showroom    AS CHAR FORMAT "x(30)" INIT ""   
      FIELD delerco     AS CHAR FORMAT "x(10)" INIT "" .

DEF VAR nv_accdat   AS DATE      FORMAT "99/99/9999"              NO-UNDO.
DEF VAR nv_comdat   AS DATE      FORMAT "99/99/9999"              NO-UNDO.
DEF VAR nv_expdat    AS DATE      FORMAT "99/99/9999"              NO-UNDO.
DEF VAR nv_comchr   AS  CHAR .
DEF VAR nv_dd           AS  INT          FORMAT "99".
DEF VAR nv_mm          AS  INT          FORMAT "99".
DEF VAR nv_yy           AS  INT          FORMAT "9999".
DEF VAR nv_cpamt1   AS DECI        INIT 0.
DEF VAR nv_cpamt2   AS DECI        INIT  0.
DEF VAR nv_cpamt3   AS DECI        INIT  0.
DEF VAR nv_insamt1   AS DECI        INIT 0.
DEF VAR nv_insamt2   AS DECI        INIT  0.
DEF VAR nv_insamt3   AS DECI        INIT  0.
DEF VAR nv_premt1   AS DECI        INIT 0.
DEF VAR nv_premt2   AS DECI        INIT  0.
DEF VAR nv_premt3   AS DECI        INIT  0.
DEF VAR nv_name1     AS  CHAR      INIT  ""   Format "X(30)".
DEF VAR nv_ntitle      AS  CHAR      INIT  ""   Format  "X(10)". 
DEF VAR nv_titleno    AS  INT          INIT  0    .
DEF VAR nv_policy    AS  CHAR      INIT ""  Format  "X(12)".
def var nv_source as  char  format  "X(35)".
def var nv_indexno  as   int    init  0.
def var nv_indexno1  as   int    init  0.
def var nv_cnt   as  int  init  0.
def var nv_addr  as  char  extent 4  format "X(35)".
def var nv_prem  as  char   init  "".
def VAR nv_file  as  char   init  "d:\fileload\return.txt".
def var nv_row   as  int  init 0.
DEF VAR number AS INT INIT 1.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS ficompno ficompbranch fi_filename bu_ok ~
bu_file bu_exit RECT-76 RECT-77 
&Scoped-Define DISPLAYED-OBJECTS ficompno ficompbranch fi_filename 

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
     SIZE 7.5 BY 1.05
     FONT 6.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 3.5 BY 1.05.

DEFINE BUTTON bu_ok 
     LABEL "Ok" 
     SIZE 7.5 BY 1.05
     FONT 6.

DEFINE VARIABLE ficompbranch AS CHARACTER FORMAT "X(5)":U 
     VIEW-AS FILL-IN 
     SIZE 8.17 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE ficompno AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 54.5 BY 1.05
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-76
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 65 BY 6.52
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-77
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 19.5 BY 1.57
     BGCOLOR 1 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     ficompno AT ROW 2.14 COL 19.33 COLON-ALIGNED NO-LABEL
     ficompbranch AT ROW 2.14 COL 49.5 COLON-ALIGNED NO-LABEL
     fi_filename AT ROW 4.81 COL 3 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 6.43 COL 46.5
     bu_file AT ROW 4.81 COL 60.5
     bu_exit AT ROW 6.38 COL 55.5
     "Text file name(Set Deler code )  :":30 VIEW-AS TEXT
          SIZE 33.5 BY 1.05 AT ROW 3.38 COL 5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Company Code :" VIEW-AS TEXT
          SIZE 16 BY 1.05 AT ROW 2.24 COL 5
          BGCOLOR 19 FONT 6
     "Comp branch :" VIEW-AS TEXT
          SIZE 14 BY 1.52 AT ROW 1.95 COL 36.17
          BGCOLOR 19 FONT 6
     RECT-76 AT ROW 1.52 COL 3
     RECT-77 AT ROW 6.14 COL 45
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 69 BY 7.57
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
         TITLE              = "WGWIMDEL.W"
         HEIGHT             = 7.57
         WIDTH              = 69
         MAX-HEIGHT         = 33.71
         MAX-WIDTH          = 170.67
         VIRTUAL-HEIGHT     = 33.71
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
IF NOT C-Win:LOAD-ICON("wimage/iconhead.ico":U) THEN
    MESSAGE "Unable to load icon: wimage/iconhead.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fr_main
   FRAME-NAME Custom                                                    */
ASSIGN 
       bu_file:AUTO-RESIZE IN FRAME fr_main      = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* WGWIMDEL.W */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* WGWIMDEL.W */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit C-Win
ON CHOOSE OF bu_exit IN FRAME fr_main /* Exit */
DO:
  Apply "Close" to this-procedure.
  Return no-apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_file
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_file C-Win
ON CHOOSE OF bu_file IN FRAME fr_main /* ... */
DO:
    DEFINE VARIABLE cvData        AS CHARACTER NO-UNDO.
    DEFINE VARIABLE OKpressed AS LOGICAL INITIAL TRUE.

   SYSTEM-DIALOG GET-FILE cvData
        TITLE      "Choose Data File to Import ..."
        FILTERS    "Text Documents" "*.csv"
                   
        MUST-EXIST
        USE-FILENAME
        UPDATE OKpressed.
      
    IF OKpressed = TRUE THEN DO:
         fi_filename  = cvData.
         DISP fi_filename WITH FRAME fr_main.     
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok C-Win
ON CHOOSE OF bu_ok IN FRAME fr_main /* Ok */
DO:
    DEFIN VAR count1 AS INTE INIT 1.
    FOR EACH  wdetail2 :
        DELETE  wdetail2.
    END.
    FOR EACH  wdetail :
        DELETE  wdetail.
    END.
    INPUT FROM VALUE(fi_FileName).
    REPEAT:
        CREATE wdetail2.
        IMPORT DELIMITER "," 
                    wdetail2.id               
                    wdetail2.deler              
                    wdetail2.showroom           
                    wdetail2.branch  
                    wdetail2.vatcode  
                    wdetail2.produno
                    wdetail2.agentno . 

        count1 = count1 + 1.

    END.  /* repeat  */
    RUN  Pro_assign1.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ficompbranch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ficompbranch C-Win
ON LEAVE OF ficompbranch IN FRAME fr_main
DO:
  ficompbranch = INPUT ficompbranch.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ficompno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ficompno C-Win
ON LEAVE OF ficompno IN FRAME fr_main
DO:
  ficompno = INPUT ficompno.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_filename
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_filename C-Win
ON LEAVE OF fi_filename IN FRAME fr_main
DO:
  fi_filename  =  Input  fi_filename.
  Disp  fi_filename  with frame  fr_main.
  
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
  DEF  VAR  gv_prgid   AS   CHAR.
  DEF  VAR  gv_prog    AS   CHAR.
  
  gv_prgid = "wgwimdel".
  gv_prog  = "Load Text Company & Deler code ".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).

/*********************************************************************/ 
   RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE).  
  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.

  
  
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
  DISPLAY ficompno ficompbranch fi_filename 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE ficompno ficompbranch fi_filename bu_ok bu_file bu_exit RECT-76 
         RECT-77 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_assign1 C-Win 
PROCEDURE Pro_assign1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF ficompno <> "NTL" THEN DO:
    /* Add Kridtiya i. A53-0182 */
    FOR EACH wdetail2 .
        FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE 
            sicsyac.xmm600.acno = wdetail2.produno  NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN
            ASSIGN wdetail2.produno = "".
        FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE 
            sicsyac.xmm600.acno = wdetail2.agentno  NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN
            ASSIGN wdetail2.agentno = "".
    
    END.
    /*end add Kridtiya i. A53-0182 */
    FOR EACH wdetail2 .
        FIND FIRST stat.company USE-INDEX company03 WHERE
            stat.company.compno = ficompno      AND 
            stat.company.branch = ficompbranch     NO-ERROR NO-WAIT.
        IF AVAIL company THEN DO:
            FIND FIRST stat.insure USE-INDEX insure01  WHERE 
                stat.insure.compno = company.compno     AND 
                stat.insure.insno  = wdetail2.id        AND 
                stat.insure.fname  = wdetail2.deler     AND   
                stat.insure.lname  = wdetail2.showroom  AND   
                stat.insure.branch = wdetail2.branch  NO-ERROR NO-WAIT.
            IF  AVAIL stat.insure THEN 
                MESSAGE "Deler code :" wdetail2.id "can not create !!!"     VIEW-AS ALERT-BOX.
            ELSE DO:
                CREATE stat.insure.
                ASSIGN
                    /*stat.insure.compno     = caps(ficompno)*/         
                    stat.insure.insno      = wdetail2.id 
                    stat.insure.fname      = wdetail2.deler   
                    stat.insure.lname      = wdetail2.showroom
                    stat.insure.branch     = caps(wdetail2.branch)  
                    stat.insure.vatcode    = wdetail2.vatcode 
                    stat.insure.addr1      = wdetail2.produno   /* Add Kridtiya i. A53-0182 */
                    stat.insure.addr2      = wdetail2.agentno.  /* Add Kridtiya i. A53-0182 */
            END.
        END.
        ELSE MESSAGE "Not found Company code & branch :" ficompno ficompbranch    VIEW-AS ALERT-BOX.
            
    END.
END.
ELSE DO: /*Add A59-0423*/
    
    FOR EACH wdetail2.
        FIND FIRST stat.company WHERE
                   stat.company.compno = ficompno NO-ERROR NO-WAIT.
        IF AVAIL stat.company THEN DO:
            FIND LAST stat.insure WHERE
                      stat.insure.compno = stat.company.compno NO-ERROR NO-WAIT.

            CREATE insure.
            ASSIGN
                stat.insure.compno   = CAPS(ficompno)
                stat.insure.insno    = wdetail2.id        
                stat.insure.fname    = wdetail2.deler    
                stat.insure.lname    = wdetail2.showroom  
                stat.insure.branch   = CAPS(wdetail2.branch)      
                stat.insure.vatcode  = wdetail2.vatcode   
                stat.insure.addr1    = wdetail2.produno   
                stat.insure.addr2    = wdetail2.agentno
                .
        END.
    END.
END.  /*End Add A59-0423*/

MESSAGE "Load Data Deler Compleate "   VIEW-AS ALERT-BOX.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

