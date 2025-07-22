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
/*++++++++++++++++++++++++++++++++++++++++++++++
program id       :  wuwstkb2.w 
program name     :  detail and Update data sticker bu3.
Create  by       :  Ranu I. A59-0527 03/11/2016
Database Connect :  gw_stat ld brstat , gw_safe ld sic_bran ,sicuw ,sicsyac

+++++++++++++++++++++++++++++++++++++++++++++++*/
DEF  Input  parameter  nv_recidtlt  as  recid  . 
DEF  VAR    nv_recidtlt2          as  recid  . 
DEFINE VAR vAcProc_fil      AS CHAR.

&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_despro fi_notno72 fi_cmrsty fi_stk ~
fi_companycomp fi_remark1 ra_status bu_save bu_exit RECT-488 RECT-490 ~
RECT-491 RECT-492 
&Scoped-Define DISPLAYED-OBJECTS fi_despro fi_notno72 fi_cmrsty fi_stk ~
fi_companycomp fi_remark1 ra_status fi_userid fi_notdat fi_producer 

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
     SIZE 7.5 BY 1
     FONT 6.

DEFINE BUTTON bu_save 
     LABEL "Save" 
     SIZE 7.5 BY 1
     FONT 6.

DEFINE VARIABLE fi_cmrsty AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_companycomp AS CHARACTER FORMAT "X(7)":U 
     VIEW-AS FILL-IN 
     SIZE 11 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_despro AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 24.83 BY 1
     BGCOLOR 8  NO-UNDO.

DEFINE VARIABLE fi_notdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 8 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_notno72 AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 8 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_remark1 AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 73 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_stk AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_userid AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 7.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE ra_status AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "YES", 1,
"NO", 2
     SIZE 28 BY 1
     FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-488
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 109 BY 10.48
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-490
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 11.5 BY 2
     BGCOLOR 2 FGCOLOR 0 .

DEFINE RECTANGLE RECT-491
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10 BY 2
     BGCOLOR 12 .

DEFINE RECTANGLE RECT-492
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10 BY 2
     BGCOLOR 3 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_despro AT ROW 2.67 COL 81.5 COLON-ALIGNED NO-LABEL 
     fi_notno72 AT ROW 3.86 COL 32.5 COLON-ALIGNED NO-LABEL
     fi_cmrsty AT ROW 3.86 COL 61.83 COLON-ALIGNED NO-LABEL
     fi_stk AT ROW 5.05 COL 32.5 COLON-ALIGNED NO-LABEL
     fi_companycomp AT ROW 5.05 COL 66.83 COLON-ALIGNED NO-LABEL
     fi_remark1 AT ROW 6.24 COL 32.5 COLON-ALIGNED NO-LABEL
     ra_status AT ROW 7.43 COL 34.5 NO-LABEL
     fi_userid AT ROW 8.95 COL 34 COLON-ALIGNED NO-LABEL
     bu_save AT ROW 8.95 COL 82.5
     bu_exit AT ROW 8.95 COL 92.5
     fi_notdat AT ROW 2.67 COL 32.5 COLON-ALIGNED NO-LABEL
     fi_producer AT ROW 2.67 COL 66 COLON-ALIGNED NO-LABEL
     " Policy 72 :":35 VIEW-AS TEXT
          SIZE 13 BY 1 AT ROW 3.86 COL 20.83
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "   User by :" VIEW-AS TEXT
          SIZE 13 BY 1 AT ROW 8.95 COL 20.83
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "UPDATE DATA  Sticker BU3" VIEW-AS TEXT
          SIZE 105 BY 1 AT ROW 1.19 COL 3
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "เลขที่ใบเสร็จ :":30 VIEW-AS TEXT
          SIZE 13 BY 1 AT ROW 5.05 COL 55.17
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Notify Date :":30 VIEW-AS TEXT
          SIZE 13 BY 1 AT ROW 2.67 COL 20.83
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " หมายเหตุ :":30 VIEW-AS TEXT
          SIZE 13 BY 1 AT ROW 6.24 COL 20.83
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Producer code :":30 VIEW-AS TEXT
          SIZE 15.5 BY 1 AT ROW 2.67 COL 51.33 
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " NOTIFY  ENTRY" VIEW-AS TEXT
          SIZE 17 BY 1 AT ROW 2.67 COL 3
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "Branch:":35 VIEW-AS TEXT
          SIZE 8 BY 1 AT ROW 3.86 COL 55.33
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "เลขสติ๊กเกอร์ :":30 VIEW-AS TEXT
          SIZE 13 BY 1 AT ROW 5.05 COL 20.83
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "     Status :":30 VIEW-AS TEXT
          SIZE 13 BY 1 AT ROW 7.43 COL 20.83
          BGCOLOR 18 FGCOLOR 0 FONT 6
     RECT-488 AT ROW 1 COL 1
     RECT-490 AT ROW 8.48 COL 34.5
     RECT-491 AT ROW 8.48 COL 91.33
     RECT-492 AT ROW 8.48 COL 81
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 109.67 BY 10.67
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
         TITLE              = "UPDATE  DATA STK BU3"
         HEIGHT             = 10.76
         WIDTH              = 109.5
         MAX-HEIGHT         = 33.91
         MAX-WIDTH          = 174.67
         VIRTUAL-HEIGHT     = 33.91
         VIRTUAL-WIDTH      = 174.67
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
/* SETTINGS FOR FRAME fr_main
   FRAME-NAME Custom                                                    */
/* SETTINGS FOR FILL-IN fi_notdat IN FRAME fr_main
   NO-ENABLE                                                            */
ASSIGN 
       fi_notdat:HIDDEN IN FRAME fr_main           = TRUE.

/* SETTINGS FOR FILL-IN fi_producer IN FRAME fr_main
   NO-ENABLE                                                            */
ASSIGN 
       fi_producer:HIDDEN IN FRAME fr_main           = TRUE.

/* SETTINGS FOR FILL-IN fi_userid IN FRAME fr_main
   NO-ENABLE                                                            */
ASSIGN 
       fi_userid:HIDDEN IN FRAME fr_main           = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* UPDATE  DATA STK BU3 */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* UPDATE  DATA STK BU3 */
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
    MESSAGE "Do you want EXIT now...  !!!!"         SKIP
        "Are you sure SAVE Complete...  !!!!"   SKIP
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO     /*-CANCEL */    
        TITLE "" UPDATE choice AS LOGICAL.
    CASE choice:  
        WHEN TRUE THEN  /* Yes */ 
            DO: 
            RELEASE brstat.tlt.
            Apply "Close"  To this-procedure.
            Return no-apply.
        END.
        END CASE. 
        APPLY "entry" TO bu_save.
        RETURN NO-APPLY.
        /*Apply "Close"  To this-procedure.
        Return no-apply.*/
 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_save
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_save C-Win
ON CHOOSE OF bu_save IN FRAME fr_main /* Save */
DO: 
    ASSIGN nv_recidtlt2 =  0.
    IF fi_notno72 <> "" THEN DO:
        FIND FIRST brstat.tlt    WHERE 
            brstat.tlt.nor_noti_tlt   = trim(fi_notno72)   AND 
            /*brstat.tlt.cha_no         = trim(fi_cmrsty)    AND */
            brstat.tlt.genusr         =  fi_producer          NO-LOCK NO-ERROR NO-WAIT .
        IF AVAIL brstat.tlt THEN DO:  
            ASSIGN nv_recidtlt2 =  Recid(brstat.tlt) .
            IF nv_recidtlt2 <> nv_recidtlt THEN DO:
                MESSAGE "Found policy on tlt..Please check again !!! " VIEW-AS ALERT-BOX.
                APPLY "ENTRY" TO fi_notno72 .
                RETURN NO-APPLY.
            END.
        END.
        IF fi_cmrsty <> "" THEN DO:
            IF LENGTH(trim(fi_cmrsty)) = 2 THEN DO:
                IF SUBSTR(trim(fi_notno72),1,2) <> trim(fi_cmrsty) THEN DO:
                    MESSAGE "Please check branch again  !!! " VIEW-AS ALERT-BOX.
                    APPLY "ENTRY" TO fi_cmrsty .
                    RETURN NO-APPLY.
                END.
            END.
            ELSE DO:
                IF SUBSTR(trim(fi_notno72),2,1) <> trim(fi_cmrsty) THEN DO:
                    MESSAGE "Please check branch again  !!! " VIEW-AS ALERT-BOX.
                    APPLY "ENTRY" TO fi_cmrsty .
                    RETURN NO-APPLY.
                END.
            END.
        END.
    END.
    Find  brstat.tlt  Where   Recid(brstat.tlt)  =  nv_recidtlt   NO-ERROR NO-WAIT .
    If  avail  brstat.tlt  Then do:
        ASSIGN 
            brstat.tlt.nor_noti_tlt  = caps(TRIM(fi_notno72))
            brstat.tlt.comp_usr_tlt  = caps(trim(fi_cmrsty))  
            brstat.tlt.cha_no        = trim(fi_stk)   
            brstat.tlt.safe2         = TRIM(fi_companycomp)
            brstat.tlt.filler2       = trim(fi_remark1) 
            brstat.tlt.releas        = IF ra_status   =  2 THEN  "No" ELSE "Yes"  . 
    END.                          
    ELSE DO: 
        MESSAGE "Not found policy no Update..tlt" VIEW-AS ALERT-BOX.
    END.
    MESSAGE "SAVE COMPLETE   "  VIEW-AS ALERT-BOX.
    Apply "Close"  To this-procedure.
    Return no-apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_cmrsty
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_cmrsty C-Win
ON LEAVE OF fi_cmrsty IN FRAME fr_main
DO:
    fi_cmrsty = caps(INPUT fi_cmrsty)  .
    DISP fi_cmrsty WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_companycomp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_companycomp C-Win
ON LEAVE OF fi_companycomp IN FRAME fr_main
DO:  
    fi_companycomp = caps(INPUT fi_companycomp).
    DISP  fi_companycomp  WITH FRAM fr_main.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_notno72
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_notno72 C-Win
ON LEAVE OF fi_notno72 IN FRAME fr_main
DO:
    fi_notno72 = INPUT fi_notno72 .
    DISP fi_notno72 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_remark1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_remark1 C-Win
ON LEAVE OF fi_remark1 IN FRAME fr_main
DO:
  fi_remark1 = trim(INPUT fi_remark1).
  DISP fi_remark1 with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_stk
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_stk C-Win
ON LEAVE OF fi_stk IN FRAME fr_main
DO:
  fi_stk  = INPUT fi_stk.
  
  DISP fi_stk WITH FRAM fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_status
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_status C-Win
ON VALUE-CHANGED OF ra_status IN FRAME fr_main
DO:
    ra_status = INPUT ra_status .
    DISP ra_status WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */
/* Set CURRENT-WINDOW: this will parent dialog-boxes and frames.        */
ASSIGN CURRENT-WINDOW             = {&WINDOW-NAME} 
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
    gv_prgid = "wgwqutp2".
    gv_prog  = "UPDATE  DATA BY TIL Compulsory".
    RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).
    /*********************************************************************/ 
    /*  RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE). */ 
    /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
    SESSION:DATA-ENTRY-RETURN = YES.
    Find  brstat.tlt  Where   Recid(brstat.tlt)  =  nv_recidtlt NO-LOCK NO-ERROR NO-WAIT .
    If  avail  brstat.tlt  Then do:
        Assign
            fi_notdat      = brstat.tlt.trndat 
            fi_notno72     = brstat.tlt.nor_noti_tlt 
            fi_cmrsty      = brstat.tlt.comp_usr_tlt 
            fi_stk         = brstat.tlt.cha_no
            fi_companycomp = brstat.tlt.safe2     
            fi_remark1     = brstat.tlt.filler2   
            ra_status      = IF index(brstat.tlt.releas,"No") <> 0 THEN 2 ELSE 1 
            fi_userid      = brstat.tlt.endno 
            fi_producer    = brstat.tlt.genusr
            /*ra_complete    =  IF trim(tlt.OLD_eng) =  "complete" THEN 1 ELSE 2*/  .
         FIND sicsyac.xmm600 USE-INDEX xmm60001   WHERE
            xmm600.acno  =  fi_producer    NO-LOCK NO-ERROR NO-WAIT.
            IF NOT AVAIL sicsyac.xmm600 THEN DO:
                ASSIGN fi_despro = "".
            END.
            ELSE 
                ASSIGN fi_despro =  TRIM(xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name) .
    END.
    RUN   proc_dispable.
    Disp  fi_notdat     
          fi_notno72    
          fi_cmrsty     
          fi_stk        
          fi_companycomp
          fi_remark1    
          ra_status     
          fi_userid
          fi_producer 
          fi_despro
          /*ra_complete*/   With frame   fr_main.
    /* End.*/
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
  DISPLAY fi_despro fi_notno72 fi_cmrsty fi_stk fi_companycomp fi_remark1 
          ra_status fi_userid fi_notdat fi_producer 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_despro fi_notno72 fi_cmrsty fi_stk fi_companycomp fi_remark1 
         ra_status bu_save bu_exit RECT-488 RECT-490 RECT-491 RECT-492 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_dispable C-Win 
PROCEDURE proc_dispable :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
Find  brstat.tlt  Where   Recid(brstat.tlt)  =  nv_recidtlt AND 
    index(brstat.tlt.releas,"yes") <> 0    NO-LOCK NO-ERROR NO-WAIT .
If  avail  brstat.tlt  Then 
    DISABLE             
    fi_notdat     
    fi_notno72    
    fi_cmrsty     
    fi_stk        
    fi_companycomp
    fi_remark1    
    ra_status     
    fi_userid 
    fi_producer
    fi_despro
    /*ra_complete*/     WITH FRAM fr_main.
 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

