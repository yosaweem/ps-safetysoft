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
                                       /
  Author:                             /

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
/***************
/* CREATE BY : Nontamas H. [A62-0324] Date 20/07/2020*/
            : Report GL Batch Posted
***************/
/*----------------------------------------------------------------------*/

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */
DEF SHARED VAR n_User       AS CHAR.
DEF SHARED VAR n_Passwd     AS CHAR.
DEF        VAR nt_amountdr  AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0.  
DEF        VAR nt_amountcr  AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0. 
DEF        VAR ng_amountdr  AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0. 
DEF        VAR ng_amountcr  AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0. 
DEF        VAR n_countbt    AS INT INIT 0. 
DEF        VAR n_compy      AS CHAR FORMAT "X" INIT "".
DEF        VAR n_cnt        AS INT INIT 0.
DEF        VAR n_amountdr   AS DEC FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEF        VAR n_amountcr   AS DEC FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEF        VAR n_firyear    AS INT.
DEF        VAR n_endyear    AS INT.
DEF        VAR n_firmon     AS CHAR.
DEF        VAR n_endmon     AS CHAR.
DEF        VAR n_year       AS CHAR.
DEF        VAR n_month      AS CHAR.
DEF        VAR nv_year      AS CHAR FORMAT "x(4)".
DEF        VAR nv_month     AS CHAR FORMAT "x(2)".
DEF        VAR nv_datefr    AS CHAR.
DEF        VAR n_branchdes  AS CHAR.

DEF TEMP-TABLE tsum
    FIELD accod AS CHAR FORMAT "X(2)" INIT ""
    FIELD acdes AS CHAR FORMAT "X(70)" INIT ""
    FIELD cnt   AS INT FORMAT ">>>>>>>9" INIT 0
    FIELD dramt AS DEC FORMAT "->>>,>>>,>>>,>>9.99" INIT 0
    FIELD cramt AS DEC FORMAT "->>>,>>>,>>>,>>9.99" INIT 0
    FIELD netamt AS DEC FORMAT "->>>,>>>,>>>,>>9.99" INIT 0.

DEF VAR n_acdes    AS CHAR.
DEF VAR nde_dramt  AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEF VAR nde_cramt  AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEF VAR nt_dramt   AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEF VAR nt_cramt   AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEF VAR nt_netamt  AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0.           

/*-----------------*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME f-main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS co_year co_month fi_datefr fi_dateto ~
fi_output bu_ok bu_cancel to_zero RECT-89 
&Scoped-Define DISPLAYED-OBJECTS co_year co_month fi_datefr fi_dateto ~
fi_output to_zero 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_cancel 
     LABEL "CANCEL" 
     SIZE 14.5 BY 1.67
     FONT 6.

DEFINE BUTTON bu_ok 
     LABEL "OK" 
     SIZE 14.5 BY 1.67
     FONT 6.

DEFINE VARIABLE co_month AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     DROP-DOWN-LIST
     SIZE 7 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE co_year AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     DROP-DOWN-LIST
     SIZE 10 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_datefr AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FONT 32 NO-UNDO.

DEFINE VARIABLE fi_dateto AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FONT 32 NO-UNDO.

DEFINE VARIABLE fi_output AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 46.5 BY 1
     BGCOLOR 15 FONT 32 NO-UNDO.

DEFINE RECTANGLE RECT-89
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 76 BY 7.62
     BGCOLOR 8 .

DEFINE VARIABLE to_zero AS LOGICAL INITIAL yes 
     LABEL "exclude zero" 
     VIEW-AS TOGGLE-BOX
     SIZE 23 BY .81
     BGCOLOR 8 FONT 6 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME f-main
     co_year AT ROW 5.62 COL 36.67 COLON-ALIGNED NO-LABEL WIDGET-ID 572
     co_month AT ROW 5.62 COL 73.5 COLON-ALIGNED NO-LABEL WIDGET-ID 566
     fi_datefr AT ROW 7 COL 36.67 COLON-ALIGNED NO-LABEL WIDGET-ID 544
     fi_dateto AT ROW 7 COL 65.67 COLON-ALIGNED NO-LABEL WIDGET-ID 546
     fi_output AT ROW 11.14 COL 34.5 COLON-ALIGNED NO-LABEL WIDGET-ID 550
     bu_ok AT ROW 13.86 COL 33.67 WIDGET-ID 536
     bu_cancel AT ROW 13.86 COL 54.5 WIDGET-ID 522
     to_zero AT ROW 8.38 COL 38.67 WIDGET-ID 580
     "         GL BATCH POSTED REPORT" VIEW-AS TEXT
          SIZE 40 BY 1.52 AT ROW 2.43 COL 31 WIDGET-ID 530
          BGCOLOR 116 FONT 6
     "POSTED DATE FROM :" VIEW-AS TEXT
          SIZE 23.5 BY .62 AT ROW 7 COL 15 WIDGET-ID 538
          BGCOLOR 8 FONT 6
     "OUTPUT :" VIEW-AS TEXT
          SIZE 11.33 BY .62 AT ROW 11.14 COL 24.5 WIDGET-ID 548
          BGCOLOR 8 FONT 6
     "YEAR :" VIEW-AS TEXT
          SIZE 8.33 BY .62 AT ROW 5.62 COL 30.33 WIDGET-ID 574
          BGCOLOR 8 FONT 6
     "MONTH :" VIEW-AS TEXT
          SIZE 9.33 BY .62 AT ROW 5.62 COL 64.83 WIDGET-ID 570
          BGCOLOR 8 FONT 6
     " OUTPUT TO" VIEW-AS TEXT
          SIZE-PIXELS 453 BY 25 AT Y 181 X 74 WIDGET-ID 554
          BGCOLOR 1 FGCOLOR 7 
     "TO :" VIEW-AS TEXT
          SIZE 5.5 BY .62 AT ROW 7 COL 61.67 WIDGET-ID 556
          BGCOLOR 8 FONT 6
     RECT-89 AT ROW 5.05 COL 13 WIDGET-ID 552
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 100 BY 16.48
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
         TITLE              = "GL Batch Posted Report - WGLRBATPS.w"
         HEIGHT             = 16.48
         WIDTH              = 100
         MAX-HEIGHT         = 16.48
         MAX-WIDTH          = 100
         VIRTUAL-HEIGHT     = 16.48
         VIRTUAL-WIDTH      = 100
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
IF NOT C-Win:LOAD-ICON("Wimage\safety":U) THEN
    MESSAGE "Unable to load icon: Wimage\safety"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME f-main
   FRAME-NAME Custom                                                    */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* GL Batch Posted Report - WGLRBATPS.w */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* GL Batch Posted Report - WGLRBATPS.w */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_cancel C-Win
ON CHOOSE OF bu_cancel IN FRAME f-main /* CANCEL */
DO:
    APPLY  "Close" TO THIS-PROCEDURE.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok C-Win
ON CHOOSE OF bu_ok IN FRAME f-main /* OK */
DO:
    IF nv_year = "" THEN nv_year = INPUT co_year.
    IF nv_month = "" THEN nv_month = INPUT co_month.

    IF fi_datefr = ? THEN DO:
        MESSAGE "Please enter Posted Date From" VIEW-AS ALERT-BOX.
        APPLY "ENTRY" TO fi_datefr.
    END.

    ELSE IF fi_dateto = ? THEN DO:
        MESSAGE "Please enter Posted Date To" VIEW-AS ALERT-BOX.
        APPLY "ENTRY" TO fi_dateto.
    END.

    ELSE IF fi_output = "" THEN DO:
       MESSAGE "Please enter Output" VIEW-AS ALERT-BOX.
       APPLY "ENTRY" TO fi_output.
    END.

    ELSE DO: 
        OUTPUT TO VALUE (fi_output) NO-ECHO.
        EXPORT DELIMITER ";"
              "Form Name : " 
              "GL Batch Posted Report".
        EXPORT DELIMITER ";"  
              "User : "
               n_user.
       EXPORT DELIMITER ";"  
               "Export Date : "
               STRING(DAY(TODAY),"99") + "/" + STRING(MONTH(TODAY),"99")  + "/" + STRING(YEAR(TODAY),"9999") .
       EXPORT DELIMITER ";"  
               "Batch Year/Month : "
                nv_year + "/" + nv_month.
       EXPORT DELIMITER ";"  
               "POSTED DATE" 
               "FROM : " + STRING(fi_datefr) + " To : " + STRING(fi_dateto).
        EXPORT DELIMITER ";"                                                                                                         
              "ITEM"                                                                                                          
              "POSTED DATE" 
              "BATCH YEAR"
              "BATCH MONTH"
              "BRANCH"
              "BRANCH DESCRIPTION"
              "BATCH NO."                                                                                                               
              "BATCH TYPE."                                                                                                          
              "Dr."        
              "Cr."
              "STATUS".                                                                                                              
        OUTPUT CLOSE.  

        RUN pd_procbatch.
        
    END.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME co_month
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL co_month C-Win
ON VALUE-CHANGED OF co_month IN FRAME f-main
DO:
    nv_month = INPUT co_month .
    APPLY "ENTRY" TO fi_datefr.
    fi_datefr = DATE ("01" + "/" + nv_month + "/" + nv_year).
    DISP fi_datefr WITH FRAME f-main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME co_year
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL co_year C-Win
ON VALUE-CHANGED OF co_year IN FRAME f-main
DO:
    nv_year = INPUT co_year.
    IF nv_month = "" THEN nv_month = STRING(MONTH(TODAY)).
    fi_datefr = DATE ("01" + "/" + nv_month + "/" + nv_year).
    DISP fi_datefr WITH FRAME f-main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_datefr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_datefr C-Win
ON LEAVE OF fi_datefr IN FRAME f-main
DO:
    fi_datefr   =  INPUT fi_datefr.

    IF fi_datefr <> ? THEN DO:
        IF fi_dateto = ? THEN fi_dateto = TODAY.
        ELSE DO:
            IF fi_datefr > fi_dateto THEN DO:
                MESSAGE "Posted Date To less than Posted Date From" VIEW-AS ALERT-BOX.
                fi_datefr = ?.
                DISP  fi_datefr fi_dateto WITH FRAME f-main.
                RETURN NO-APPLY.
            END.
        END.
    END.
    DISP  fi_datefr fi_dateto WITH FRAME f-main.
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dateto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dateto C-Win
ON LEAVE OF fi_dateto IN FRAME f-main
DO:
   fi_dateto   =  INPUT fi_dateto.
    IF fi_datefr <> ? THEN DO:
        IF fi_dateto < fi_datefr THEN DO: 
            MESSAGE "Posted Date To less than Posted Dafe from " VIEW-AS ALERT-BOX.
            fi_dateto = ?.
            DISP  fi_datefr fi_dateto WITH FRAME f-main.
            RETURN NO-APPLY.
        END.
    END.
   DISP  fi_datefr fi_dateto WITH FRAME f-main.
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_output
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_output C-Win
ON LEAVE OF fi_output IN FRAME f-main
DO:
    fi_output = INPUT fi_output.
    IF fi_output <> "" THEN DO:
        IF INDEX(fi_output,".txt") <> 0 THEN fi_output = fi_output.
        ELSE fi_output = fi_output + ".txt".
        DISP fi_output WITH FRAME f-main.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME to_zero
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL to_zero C-Win
ON VALUE-CHANGED OF to_zero IN FRAME f-main /* exclude zero */
DO:
  to_zero = INPUT to_zero.
  DISP to_zero WITH FRAME f-main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */
/********************  T I T L E   F O R  C - W I N  ****************/
   DEF  VAR  gv_prgid   AS   CHAR  FORMAT "X(8)"   NO-UNDO.
   DEF  VAR  gv_prog    AS   CHAR  FORMAT "X(50)" NO-UNDO.
  
   gv_prgid = "WGLRBATPS".
   gv_prog  = "GL Batch Posted Report".
    
/*********************************************************************/

/* CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED. */

SESSION:DATA-ENTRY-RETURN = YES.


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

  DO WITH FRAME f-main:
        /*---YEAR-----*/
        n_firyear = YEAR(TODAY) - 10.
        n_endyear = YEAR(TODAY).
        Do While n_firyear <= n_endyear :
                IF n_year = "" THEN n_year = STRING(n_firyear).
                ELSE n_year = n_year + "," + STRING(n_firyear).
                n_firyear = n_firyear + 1.
             IF n_firyear >= n_endyear THEN NEXT.
         END.
        /*---END YEAR-----*/
         /*---MONTH-----*/
        n_firmon = "01".
        n_endmon = "12".
        Do While INT(n_firmon) <= INT(n_endmon) :
            IF LENGTH(n_firmon) = 1 THEN n_firmon = "0" + n_firmon.
            ELSE n_firmon = n_firmon.
        
                IF n_month = "" THEN n_month = n_firmon.
                ELSE n_month = n_month + "," + n_firmon.
                n_firmon  = STRING(INT(n_firmon)  + 1).
        
             IF INT(n_firmon)  >= INT(n_endmon) THEN NEXT.
         END.
        /*---END MONTH-----*/

        ASSIGN
            co_year:LIST-ITEMS = n_year
            co_year  = STRING(YEAR(TODAY))   /*ENTRY(1,n_year)*/
            co_month:LIST-ITEMS = n_month . 
        IF LENGTH(STRING(MONTH(TODAY))) = 1  THEN co_month  = "0" + STRING(MONTH(TODAY)).
        ELSE co_month  = STRING(MONTH(TODAY)).


        DISP co_year co_month WITH FRAM f-main.
    END.
  
  
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
  DISPLAY co_year co_month fi_datefr fi_dateto fi_output to_zero 
      WITH FRAME f-main IN WINDOW C-Win.
  ENABLE co_year co_month fi_datefr fi_dateto fi_output bu_ok bu_cancel to_zero 
         RECT-89 
      WITH FRAME f-main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-f-main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_procbatch C-Win 
PROCEDURE pd_procbatch :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN n_compy     = "0" 
       n_amountdr  = 0
       n_amountcr  = 0
       nt_amountdr = 0
       nt_amountcr = 0
       n_cnt       = 0
       nt_dramt    = 0
       nt_cramt    = 0
       nt_netamt   = 0 .

FOR EACH chm015 NO-LOCK WHERE chm015.cldat >= fi_datefr
                          AND chm015.cldat <= fi_dateto
    BY chm015.cldat
    BY chm015.bchno.
    
    FOR EACH glt003 NO-LOCK USE-INDEX glt00302 WHERE glt003.compy =  chm015.compy
                                                 AND glt003.accyr =  nv_year         /*STRING(chm015.accyr,"9999")*/
                                                 AND glt003.accmth = nv_month        /*STRING(chm015.accmth,"99")*/  
                                                 AND glt003.bchno  = chm015.bchno.

        DISP glt003.accyr  glt003.accmth glt003.bchno FORMAT "x(15)"
        WITH COLOR BLACK/WHITE NO-LABEL TITLE "Process GL Batch Posted ..." FRAME frProcess VIEW-AS DIALOG-BOX.

        PAUSE 0.

        IF glt003.drcr = YES THEN ASSIGN n_amountdr = n_amountdr + glt003.locamt
                                         nde_dramt = glt003.locamt.
        ELSE ASSIGN n_amountcr = n_amountcr + glt003.locamt
                    nde_cramt = glt003.locamt.

        ASSIGN n_acdes = "".

        IF SUBSTR(glt003.macc,1,1) = "1" THEN n_acdes = "Assets".
        ELSE IF SUBSTR(glt003.macc,1,1) = "2" THEN n_acdes = "Liabilities".
        ELSE IF SUBSTR(glt003.macc,1,1) = "3" THEN n_acdes = "Equity".
        ELSE IF SUBSTR(glt003.macc,1,1) = "4" THEN n_acdes = "Revenue".
        ELSE IF SUBSTR(glt003.macc,1,1) = "5" THEN n_acdes = "Commission".
        ELSE IF SUBSTR(glt003.macc,1,1) = "6" THEN n_acdes = "Claim Expense".
        ELSE IF SUBSTR(glt003.macc,1,1) = "7" THEN n_acdes = "Operating Expense".
        ELSE n_acdes = "Other".
        
         /*--- Grand total---*/       
        ASSIGN nt_dramt = nt_dramt + nde_dramt
               nt_cramt = nt_cramt + nde_cramt
               nt_netamt = nt_netamt + (nde_dramt - nde_cramt).
        
        /*--Grouping Account--*/
        FIND FIRST tsum WHERE tsum.accod = SUBSTR(glt003.macc,1,1) NO-ERROR.
        IF NOT AVAIL tsum THEN DO:
           CREATE tsum.
           ASSIGN tsum.accod = SUBSTR(glt003.macc,1,1)
                  tsum.acdes = n_acdes
                  tsum.cnt   = 1
                  tsum.dramt  = nde_dramt
                  tsum.cramt  = nde_cramt
                  tsum.netamt = nde_dramt - nde_cramt.
        END.
        ELSE DO:
            ASSIGN tsum.dramt  =  tsum.dramt  +  nde_dramt             
                   tsum.cramt  =  tsum.cramt  +  nde_cramt             
                   tsum.netamt =  tsum.netamt +  nde_dramt - nde_cramt.
                   tsum.cnt    =  tsum.cnt + 1.
        END.
        
        ASSIGN nde_dramt = 0
               nde_cramt = 0.

    END.  /*end glt003 */

    IF TO_zero = YES THEN DO: /*ไม่เอา 0*/
        IF n_amountdr = 0 OR n_amountcr = 0 THEN NEXT.
    END.

    n_cnt = n_cnt + 1.

    FIND FIRST chm993 WHERE SUBSTR(chm993.branch,2,3) = SUBSTR(chm015.bchno,1,2) NO-LOCK NO-ERROR.
    IF AVAIL chm993 THEN n_branchdes = chm993.descr.

    OUTPUT TO VALUE (fi_output) APPEND NO-ECHO.
    EXPORT DELIMITER ";"
        n_cnt 
        chm015.cldat
        nv_year
        nv_month
        SUBSTR(chm015.bchno,1,2)
        n_branchdes
        chm015.bchno
        chm015.bchtyp
        n_amountdr
        n_amountcr
        "P".
    OUTPUT CLOSE.
    
    ASSIGN nt_amountdr = nt_amountdr + n_amountdr
           nt_amountcr = nt_amountcr + n_amountcr. 

    n_amountdr  = 0.
    n_amountcr  = 0.

END.


OUTPUT TO VALUE (fi_output) APPEND NO-ECHO.
EXPORT DELIMITER ";".
EXPORT DELIMITER ";"
       "" "" "" "" "" "" "" 
       "Grand TOTAL :"
        nt_amountdr 
        nt_amountcr .
OUTPUT CLOSE.
/*----count batch----*/
OUTPUT TO VALUE (fi_output) APPEND NO-ECHO.
EXPORT DELIMITER ";".
EXPORT DELIMITER ";"
       "" "" "" "" "" "" ""
       "Count Batch :"
        n_cnt
        "".
OUTPUT CLOSE.

OUTPUT TO VALUE (fi_output) APPEND NO-ECHO.
EXPORT DELIMITER ";"
    "Group Account of "  + nv_year + "/" +  nv_month 
    "Description"
    "Debit"
    "Credit"
    "Net".
OUTPUT CLOSE.

FOR EACH tsum NO-LOCK BREAK BY tsum.accod.
    OUTPUT TO VALUE (fi_output) APPEND NO-ECHO.
    EXPORT DELIMITER ";"
        tsum.accod 
        tsum.acdes
        tsum.dramt
        tsum.cramt
        tsum.netamt.
    OUTPUT CLOSE.
END.


OUTPUT TO VALUE (fi_output) APPEND NO-ECHO.
    EXPORT DELIMITER ";"
        "Total" 
        ""
        nt_dramt
        nt_cramt
        nt_netamt.
    OUTPUT CLOSE.

MESSAGE "Export Complete" VIEW-AS ALERT-BOX. 

FOR EACH tsum.
    DELETE tsum.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

