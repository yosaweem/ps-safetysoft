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
----------------------------------------------------------------------------------*/
/*          This .W file was created with the Progress UIB.                       */
/*--------------------------------------------------------------------------------*/
/* Create an unnamed pool to store all the widgets created 
    by this procedure. This is a good default which assures
    that this procedure's triggers and internal procedures 
    will execute in this procedure's storage, and that proper
    cleanup will occur on deletion of the procedure. */
CREATE WIDGET-POOL.
/* ***************************  Definitions  **************************           */
/* Parameters Definitions ---                                                     */
/* Local Variable Definitions ---                                                 */
/*++++++++++++++++++++++++++++++++++++++++++++++                                  
program id       :  wgwimfax.w                                                    
program name     :  create notify by FAX... create  new policy  Add in table  tlt 
Create  by       :  Kridtiya i. A56-0024  date. 31/01/2013                        
Database Connect :  gw_stat ld brstat , gw_safe ld sic_bran ,sicuw sicsyac  stat  
+++++++++++++++++++++++++++++++++++++++++++++++************************************/
DEFINE VAR  nv_polno     AS   INTEGER                  NO-UNDO.
DEFINE VAR  n_policy     AS   CHARACTER FORMAT "X(12)" NO-UNDO.
DEFINE VAR  nv_brnpol    AS   CHARACTER INITIAL ""     NO-UNDO.
DEFINE VAR  nv_poltyp    AS   CHARACTER FORMAT "X(3)"  INIT "".
DEFINE VAR  nv_undyr2543 AS   CHARACTER FORMAT "X(4)"  INIT "" NO-UNDO.
DEFINE VAR  nv_polno2543 AS   INTEGER                  NO-UNDO.
DEFINE VAR  nv_startno   AS   CHARACTER INITIAL ""     NO-UNDO.
DEFINE VAR  nv_message   AS   CHARACTER                NO-UNDO.
DEFINE VAR  nv_acno1     AS   CHARACTER FORMAT "X(10)" INIT ""  NO-UNDO.
DEFINE VAR  nv_branch    AS   CHARACTER FORMAT "X(2)"  INIT ""  NO-UNDO.
DEFINE VAR  nv_undyr     AS   CHARACTER FORMAT "X(4)"  INIT ""  NO-UNDO.
DEFINE VAR  nv_dir_ri    AS   LOGICAL         INIT   YES        NO-UNDO.
DEF SHARED VAR n_User    AS   CHAR.
DEFINE VAR  nv_br        AS   CHAR.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_company fi_producer bu_create bu_exit ~
RECT-483 RECT-484 RECT-487 
&Scoped-Define DISPLAYED-OBJECTS fi_company fi_producer fi_year fi_dept ~
fi_run fi_notdat fi_nottim fi_notino fi_user 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_create 
     LABEL "Create Notify" 
     SIZE 13.5 BY 1
     BGCOLOR 3 FGCOLOR 2 FONT 6.

DEFINE BUTTON bu_exit 
     LABEL "Exit" 
     SIZE 7 BY 1
     FONT 6.

DEFINE VARIABLE fi_company AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 DROP-TARGET NO-UNDO.

DEFINE VARIABLE fi_dept AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 5.5 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_notdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_notino AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 29 BY 1
     BGCOLOR 8 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_nottim AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_run AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_user AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1
     BGCOLOR 2 FGCOLOR 7 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_year AS CHARACTER FORMAT "X(4)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 DROP-TARGET NO-UNDO.

DEFINE RECTANGLE RECT-483
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 74.5 BY 9.52
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-484
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 12 BY 2
     BGCOLOR 6 .

DEFINE RECTANGLE RECT-487
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 17 BY 2
     BGCOLOR 3 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_company AT ROW 5.05 COL 20.5 COLON-ALIGNED NO-LABEL
     fi_producer AT ROW 5.05 COL 50.5 COLON-ALIGNED NO-LABEL
     bu_create AT ROW 7.91 COL 27
     bu_exit AT ROW 7.91 COL 45
     fi_year AT ROW 2.67 COL 20.5 COLON-ALIGNED NO-LABEL
     fi_dept AT ROW 2.67 COL 42.5 COLON-ALIGNED NO-LABEL
     fi_run AT ROW 5.05 COL 36 COLON-ALIGNED NO-LABEL
     fi_notdat AT ROW 3.86 COL 20.5 COLON-ALIGNED NO-LABEL
     fi_nottim AT ROW 3.86 COL 46.5 COLON-ALIGNED NO-LABEL
     fi_notino AT ROW 6.24 COL 20.5 COLON-ALIGNED NO-LABEL
     fi_user AT ROW 6.24 COL 50 COLON-ALIGNED NO-LABEL
     "BY :":35 VIEW-AS TEXT
          SIZE 4 BY 1 AT ROW 5.05 COL 33.5
          BGCOLOR 15 FGCOLOR 2 FONT 6
     "             IMPORT DATA BY FAX........RUNNUNG NOTIFYNUMBER" VIEW-AS TEXT
          SIZE 70 BY 1 AT ROW 1.33 COL 2.5
          BGCOLOR 15 FGCOLOR 1 FONT 6
     "             Notify no :" VIEW-AS TEXT
          SIZE 19 BY 1 AT ROW 6.24 COL 2.5
          BGCOLOR 15 FGCOLOR 2 FONT 6
     "IMPORTDATA BY :":35 VIEW-AS TEXT
          SIZE 19 BY 1 AT ROW 5.05 COL 2.5
          BGCOLOR 15 FGCOLOR 2 FONT 6
     "Producer :":35 VIEW-AS TEXT
          SIZE 9 BY 1 AT ROW 5.05 COL 42.5
          BGCOLOR 15 FGCOLOR 2 FONT 6
     "Dept :":35 VIEW-AS TEXT
          SIZE 6 BY 1 AT ROW 2.67 COL 38
          BGCOLOR 15 FGCOLOR 2 FONT 6
     "                   Year :":35 VIEW-AS TEXT
          SIZE 19 BY 1 AT ROW 2.67 COL 2.5
          BGCOLOR 15 FGCOLOR 2 FONT 6
     " No.Time :":30 VIEW-AS TEXT
          SIZE 10 BY 1 AT ROW 3.86 COL 38
          BGCOLOR 15 FGCOLOR 2 FONT 6
     "          Notify Date :":30 VIEW-AS TEXT
          SIZE 19 BY 1 AT ROW 3.86 COL 2.5
          BGCOLOR 15 FGCOLOR 2 FONT 6
     RECT-483 AT ROW 1 COL 1
     RECT-484 AT ROW 7.43 COL 42.5
     RECT-487 AT ROW 7.43 COL 25
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 75.17 BY 9.57
         BGCOLOR 3 FGCOLOR 1 .


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
         TITLE              = "CREATE NOTIFY BY FAX ..."
         HEIGHT             = 9.57
         WIDTH              = 75.17
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
IF NOT C-Win:LOAD-ICON("wimage\safety":U) THEN
    MESSAGE "Unable to load icon: wimage\safety"
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
/* SETTINGS FOR FILL-IN fi_dept IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_notdat IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_notino IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_nottim IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_run IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_user IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_year IN FRAME fr_main
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* CREATE NOTIFY BY FAX ... */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* CREATE NOTIFY BY FAX ... */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_create
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_create C-Win
ON CHOOSE OF bu_create IN FRAME fr_main /* Create Notify */
DO:
    ASSIGN 
        fi_notdat    = TODAY
        fi_nottim    = string(TIME,"HH:MM:SS")
        nv_undyr2543 = STRING(deci(fi_year) + 543,"9999") 
        nv_message   = "" .
    FIND FIRST sicsyac.s0m003 WHERE                     
        TRIM(sicsyac.s0m003.fld11)  = "M" + trim(fi_run)  AND
        TRIM(sicsyac.s0m003.fld22)  = trim(fi_producer)   NO-LOCK NO-ERROR NO-WAIT.
    IF AVAILABLE sicsyac.s0m003 THEN DO:
        ASSIGN  
            nv_brnpol     = sicsyac.s0m003.fld12         /* BRANCH POLICY */
            nv_startno    = sicsyac.s0m003.fld21         
            nv_br         = sicsyac.s0m003.fld11.        /* START NO */
        IF  nv_brnpol = "" THEN  nv_brnpol = nv_br.
    END.          /* sicsyac.s0m003 */
    ELSE DO:
        MESSAGE "Not found set parameter running...!!! "    SKIP
                "Company : " + fi_company                   SKIP
                "Branch : " + "M"                           SKIP
                "Running by(อักษรหลังปี) : " + trim(fi_run) SKIP
                "Producer Code : "           + fi_producer  VIEW-AS ALERT-BOX.
        ASSIGN nv_startno = "".
    END.
    IF nv_startno <> "" THEN DO:   /* Running Policy no. */
        loop_chk:
        REPEAT: 
            FIND FIRST stat.polno_fil USE-INDEX polno01  WHERE
                stat.polno_fil.dir_ri   = YES            AND
                stat.polno_fil.poltyp   = "v70"          AND
                stat.polno_fil.branch   = nv_br          AND
                stat.polno_fil.undyr    = nv_undyr2543   AND 
                stat.polno_fil.brn_pol  = nv_brnpol      AND                /*4M 4=Branch M=Malaysia*/
                stat.polno_fil.start_no = nv_startno     NO-ERROR NO-WAIT.  /*1=A 2=AB ""=""*/
            IF NOT AVAILABLE stat.polno_fil THEN DO:
                IF LOCKED stat.polno_fil THEN DO:
                    MESSAGE "LOCK".
                    NEXT loop_chk.
                END.
            END.
            ELSE DO:
                IF LENGTH(TRIM(nv_startno)) = 1 THEN DO:
                    IF stat.polno_fil.nextno >= 100000 THEN DO:
                        MESSAGE "อักษรหลังปี " nv_startno  "เบอร์กรมธรรม์ Running เกินกว่าที่กำหนด > 99999 !!!".
                        IF      nv_startno = "A" THEN  nv_startno = "B".
                        ELSE IF nv_startno = "B" THEN  nv_startno = "C".
                        ELSE IF nv_startno = "C" THEN  nv_startno = "D".
                        ELSE IF nv_startno = "D" THEN  nv_startno = "E".
                        ELSE IF nv_startno = "E" THEN  nv_startno = "F".
                        ELSE IF nv_startno = "F" THEN  nv_startno = "G".
                        ELSE IF nv_startno = "G" THEN  nv_startno = "H".
                        ELSE IF nv_startno = "H" THEN  nv_startno = "I".
                        ELSE IF nv_startno = "I" THEN  nv_startno = "J".
                        ELSE IF nv_startno = "J" THEN  nv_startno = "K".
                        ELSE IF nv_startno = "K" THEN  nv_startno = "L".
                        ELSE IF nv_startno = "L" THEN  nv_startno = "M".
                        ELSE IF nv_startno = "M" THEN  nv_startno = "N".
                        ELSE IF nv_startno = "N" THEN  nv_startno = "O".
                        ELSE IF nv_startno = "O" THEN  nv_startno = "P".
                        ELSE IF nv_startno = "P" THEN  nv_startno = "Q".
                        ELSE IF nv_startno = "Q" THEN  nv_startno = "R".
                        ELSE IF nv_startno = "R" THEN  nv_startno = "S".
                        ELSE IF nv_startno = "S" THEN  nv_startno = "T".
                        ELSE IF nv_startno = "T" THEN  nv_startno = "U".
                        ELSE IF nv_startno = "U" THEN  nv_startno = "V".
                        ELSE IF nv_startno = "V" THEN  nv_startno = "W".
                        ELSE IF nv_startno = "W" THEN  nv_startno = "X".
                        ELSE IF nv_startno = "X" THEN  nv_startno = "Y".
                        ELSE IF nv_startno = "Y" THEN  nv_startno = "Z".
                        ASSIGN nv_br  = SUBSTR(nv_br,1,1) +  nv_startno.
                        DISP nv_startno FORMAT "x(3)".
                        FIND FIRST stat.company WHERE stat.Company.Compno = fi_company  NO-ERROR.
                        IF AVAIL stat.company THEN 
                            ASSIGN stat.Company.Compno = caps(fi_company)
                            stat.Company.ABName = nv_startno.
                        RELEASE stat.company.
                        MESSAGE "กรุณาแจ้งเซตรันนิ่ง อักษรหลังปี ของรหัสบริษัท: " caps(fi_company) " อักษรหลังปี " nv_startno  VIEW-AS ALERT-BOX .
                        ASSIGN fi_notino = "".
                        DISP fi_notino WITH FRAM fr_main. 
                        LEAVE loop_chk.
                    END.                     /* stat.polno_fil.nextno >= 10000 */
                    ELSE                    /* IF polno_fil.nextno   < 10000  .....running ok   */
                        ASSIGN nv_polno           = stat.polno_fil.nextno 
                            stat.polno_fil.nextno = stat.polno_fil.nextno + 1.
                END.       /*nv_startno  = 2 */
                ELSE nv_startno = "".
            END.          /*else do  avail stat.polno_fil  */
            IF nv_startno = ""  THEN DO:
                MESSAGE "อักษรหลังปี " nv_startno  "ไม่ถูกต้อง !!!".
                APPLY "entry" TO fi_company.
                RETURN NO-APPLY.
            END.
            ELSE DO:
                IF LENGTH(TRIM(nv_startno)) = 1 THEN   /* D27098VB1234 */
                    n_policy  = "N"
                                + SUBSTR(nv_undyr2543,3,2)
                                + TRIM(fi_dept)
                                + TRIM(nv_startno)
                                + STRING(nv_polno,"99999").
                fi_notino = CAPS(trim(n_policy)).
                FIND LAST  brstat.tlt    WHERE 
                    brstat.tlt.nor_noti_tlt  = fi_notino  AND
                    brstat.tlt.genusr        = "FAX"      NO-LOCK NO-ERROR NO-WAIT .
                IF  AVAIL tlt THEN DO: 
                    MESSAGE "Notify no.. duplicate:  " fi_notino  VIEW-AS ALERT-BOX.
                    NEXT loop_chk.
                END.
                ELSE DO: 
                    CREATE brstat.tlt .
                    ASSIGN 
                        fi_notdat               = TODAY
                        fi_nottim               = string(TIME,"HH:MM:SS")
                        brstat.tlt.nor_noti_tlt = trim(fi_notino)             
                        brstat.tlt.trndat       = TODAY
                        brstat.tlt.trntime      = string(TIME,"HH:MM:SS")      
                        brstat.tlt.usrid        = fi_user 
                        brstat.tlt.genusr       = "FAX"   .
                    LEAVE loop_chk.
                END.
            END.
        END.     /*replete......*/
    END.
    ASSIGN n_policy   = "" 
           nv_startno = "" 
           nv_message = "" .
    RELEASE brstat.tlt.
    RELEASE stat.polno_fil.
    RELEASE sicsyac.s0m003.
    DISP fi_notino  fi_notdat fi_nottim  WITH FRAM fr_main. 
    IF fi_notino = "" THEN DO:
        APPLY "entry" TO fi_company.
        RETURN NO-APPLY.
    END.
    ELSE DO:  
        Run  wgw\wgwimfa1  (INPUT fi_notino) .
        Apply "Close"  To this-procedure.
        Return no-apply.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit C-Win
ON CHOOSE OF bu_exit IN FRAME fr_main /* Exit */
DO:
    Apply "Close"  To this-procedure.
    Return no-apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_company
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_company C-Win
ON LEAVE OF fi_company IN FRAME fr_main
DO:
    fi_company = INPUT fi_company.
    FIND FIRST stat.company WHERE stat.Company.Compno = fi_company NO-LOCK NO-ERROR.
    IF AVAIL stat.company THEN
        ASSIGN fi_run = stat.Company.ABName.
    ELSE fi_run = "".
    DISP fi_company fi_run WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer C-Win
ON LEAVE OF fi_producer IN FRAME fr_main
DO:
    fi_producer =  trim(CAPS( Input  fi_producer )) .
    Disp  fi_producer with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */
/* Set CURRENT-WINDOW: this will parent dialog-boxes and frames.        */
ASSIGN CURRENT-WINDOW                = {&WINDOW-NAME} 
    THIS-PROCEDURE:CURRENT-WINDOW    = {&WINDOW-NAME}.
/* The CLOSE event can be used from inside or outside the procedure to  */
/* terminate it.                                                        */
ON CLOSE OF THIS-PROCEDURE 
    RUN disable_UI.
/* Best default for GUI applications is...                              */
PAUSE 0 BEFORE-HIDE.
/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR    UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
    ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
    RUN enable_UI.
    /********************  T I T L E   F O R  C - W I N  ****************/
    DEF  VAR  gv_prgid   AS   CHAR.
    DEF  VAR  gv_prog    AS   CHAR.
    
    gv_prgid = "WGWIMFAX".
    gv_prog  = "CREATE NOTIFY NO. By FAX...".
    RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).
    
    /*********************************************************************/ 
    /*  RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE). */ 
    /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
    SESSION:DATA-ENTRY-RETURN = YES.
    ASSIGN 
        fi_year     = string(YEAR(TODAY),"9999")
        fi_dept     = "BU3"
        fi_user     = n_User    
        fi_notdat   = TODAY
        fi_nottim   = string(TIME,"HH:MM:SS")
        fi_company  = "FAX"
        fi_producer = "B3M0010"
        fi_notino   = "".
    FIND FIRST stat.company WHERE stat.Company.Compno = fi_company  NO-LOCK NO-ERROR.
    IF AVAIL stat.company THEN
        ASSIGN fi_run = stat.Company.ABName.
    ELSE fi_run = "".
    DISP fi_year  fi_user    fi_notdat   fi_nottim   fi_company  fi_run  fi_producer 
         fi_dept  fi_notino  With frame fr_main.    
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
  DISPLAY fi_company fi_producer fi_year fi_dept fi_run fi_notdat fi_nottim 
          fi_notino fi_user 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_company fi_producer bu_create bu_exit RECT-483 RECT-484 RECT-487 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_createnoti C-Win 
PROCEDURE proc_createnoti :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*fi_notino   = "PHONE" + STRING(TODAY,"99/99/9999") + string(TIME,"HH:MM:SS") *//*
FIND LAST  tlt  WHERE 
    tlt.nor_noti_tlt  = fi_notino  AND
    tlt.genusr        = "Phone"    NO-ERROR NO-WAIT .
IF NOT AVAIL tlt THEN DO: 
    CREATE tlt.
    ASSIGN tlt.nor_noti_tlt  = fi_notino
        tlt.genusr        = "Phone"  .
END.
ELSE ASSIGN fi_notino   = "PHONE" + STRING(TODAY,"99/99/9999") + string(TIME,"HH:MM:SS") + "_1".
FIND LAST  tlt  WHERE 
    tlt.nor_noti_tlt  = fi_notino  AND
    tlt.genusr        = "Phone"    NO-ERROR NO-WAIT .
IF NOT AVAIL tlt THEN DO: 
    CREATE tlt.
    ASSIGN tlt.nor_noti_tlt  = fi_notino
           tlt.genusr        = "Phone"  .
END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_save70 C-Win 
PROCEDURE proc_save70 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*//*
FIND LAST  tlt    WHERE 
    tlt.nor_noti_tlt  = fi_notino  AND
    tlt.genusr        = "Phone"    NO-ERROR NO-WAIT .
IF AVAIL tlt THEN 
    ASSIGN 
        tlt.policy        =   fi_notno70       
        /*tlt.comp_pol      = INPUT fi_notno72*/ .*/

            
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_save72 C-Win 
PROCEDURE proc_save72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*//*
FIND LAST  tlt    WHERE 
    tlt.nor_noti_tlt  = fi_notino  AND
    tlt.genusr        = "Phone"    NO-ERROR NO-WAIT .
IF AVAIL tlt THEN 
    ASSIGN 
        /*tlt.policy        =   fi_notno70 */      
        tlt.comp_pol      =  fi_notno72 .
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

