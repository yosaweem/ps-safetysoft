&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME c-wins
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS c-wins 
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
program id   : wgwchstk.w
program name : Update Data Sticker bu3
               Import text file match Data in tlt
Create  by   : Ranu I. [A59-0527]   On   03/11/2016
Connect      : GW_SAFE LD SIC_BRAN, GW_STAT LD BRSTAT ,SICSYAC,SICUW [Not connect : Stat]
+++++++++++++++++++++++++++++++++++++++++++++++*/
/* Modify by : Ranu I. A65-0170 เพิ่มตัวเลือกการ Match file cancel โดยใช้ไฟล์ csv*/
/*------------------------------------------------------------------------------------*/

DEFINE  VAR nv_rectlt    as recid init  0.  
DEFINE  VAR nv_recidtlt  as recid init  0.  
DEF  STREAM ns2.                        
DEFINE  VAR nv_cnt       as int   init  1. 
DEFINE  VAR nv_row       as int   init  0. 
DEFINE  VAR n_record     AS INTE  INIT  0. 
DEFINE  VAR n_comname    AS CHAR  INIT  "".
DEFINE  VAR n_asdat      AS CHAR.
DEFINE  VAR vAcProc_fil  AS CHAR.
DEFINE  VAR vAcProc_fil2 AS CHAR.
DEFINE  VAR n_asdat2     AS CHAR.
DEFINE  VAR n_producer   AS CHAR .
DEFINE  WORKFILE wdetail NO-UNDO
    FIELD notifydate      AS CHAR FORMAT "X(10)"  INIT ""                                                    
    FIELD branch          AS CHAR FORMAT "X(2)"   INIT ""                                    
    FIELD policy          AS CHAR FORMAT "X(12)"  INIT ""   
    FIELD stk             AS CHAR FORMAT "X(15)"  INIT ""                                       
    FIELD docno           AS CHAR FORMAT "X(10)"  INIT ""                                    
    FIELD remark          AS CHAR FORMAT "X(150)" INIT "".
    
DEFINE  TEMP-TABLE tdetail NO-UNDO
    FIELD releas             AS CHAR FORMAT "X(35)"  INIT ""                                                    
    FIELD trndat             AS DATE                                    
    FIELD nor_noti_tlt       AS CHAR FORMAT "X(13)"  INIT ""   
    FIELD comp_usr_tlt       AS CHAR FORMAT "X(4)"   INIT ""                                       
    FIELD cha_no             AS CHAR FORMAT "X(20)"  INIT ""                                    
    FIELD safe2              AS CHAR FORMAT "X(10)"  INIT ""
    FIELD genusr             AS CHAR FORMAT "X(10)"  INIT ""      
    FIELD usrid              AS CHAR FORMAT "X(10)"  INIT ""  
    FIELD filler2            AS CHAR FORMAT "X(150)" INIT "". 
DEF VAR nv_outfile   AS CHAR FORMAT "x(256)" INIT "" .

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS bu_exp cb_format ra_type fi_inputfile ~
bu_file bu_OK fi_output bu_exit RECT-332 RECT-501 RECT-504 RECT-505 
&Scoped-Define DISPLAYED-OBJECTS cb_format ra_type fi_inputfile fi_output 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR c-wins AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_exit 
     LABEL "EXIT" 
     SIZE 7 BY 1
     FONT 6.

DEFINE BUTTON bu_exp 
     LABEL "Export" 
     SIZE 10 BY 1
     BGCOLOR 15 FGCOLOR 1 .

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 3.5 BY 1.

DEFINE BUTTON bu_OK 
     LABEL "OK" 
     SIZE 7 BY 1
     FONT 6.

DEFINE VARIABLE cb_format AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "Format file Update Data","1",
                     "Format file Cancel Data","2"
     DROP-DOWN-LIST
     SIZE 25 BY 1
     BGCOLOR 8 FGCOLOR 0 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_inputfile AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 62.17 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_output AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 62.17 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE ra_type AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Update Policy and Status STK", 1,
"Cancel STK", 2
     SIZE 62 BY .95
     BGCOLOR 8 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-332
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 112 BY 10.48
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-501
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 9.5 BY 1.43
     BGCOLOR 2 FGCOLOR 2 .

DEFINE RECTANGLE RECT-504
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 111.67 BY 2.05
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-505
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 9.5 BY 1.43
     BGCOLOR 6 FGCOLOR 6 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     bu_exp AT ROW 8.29 COL 56.5 WIDGET-ID 8
     cb_format AT ROW 8.29 COL 28.5 COLON-ALIGNED NO-LABEL WIDGET-ID 6
     ra_type AT ROW 3.67 COL 30.67 NO-LABEL WIDGET-ID 2
     fi_inputfile AT ROW 5.1 COL 28.83 COLON-ALIGNED NO-LABEL
     bu_file AT ROW 5.1 COL 93.33
     bu_OK AT ROW 8.43 COL 84.83
     fi_output AT ROW 6.57 COL 28.83 COLON-ALIGNED NO-LABEL
     bu_exit AT ROW 8.43 COL 95.33
     "Update status Sticker BU3" VIEW-AS TEXT
          SIZE 35.5 BY 1.19 AT ROW 1.71 COL 42
          FGCOLOR 15 FONT 2
     "Output File STK :" VIEW-AS TEXT
          SIZE 17 BY 1 AT ROW 6.57 COL 13.5
          BGCOLOR 3 FGCOLOR 7 FONT 6
     " Import File STK :" VIEW-AS TEXT
          SIZE 17 BY 1 AT ROW 5.1 COL 13.5
          BGCOLOR 3 FGCOLOR 7 FONT 6
     RECT-332 AT ROW 1 COL 1
     RECT-501 AT ROW 8.24 COL 83.5
     RECT-504 AT ROW 1.1 COL 1.33
     RECT-505 AT ROW 8.24 COL 94
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 112.33 BY 10.52
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
  CREATE WINDOW c-wins ASSIGN
         HIDDEN             = YES
         TITLE              = "Check data STK on Premium"
         HEIGHT             = 10.24
         WIDTH              = 112
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
         FONT               = 6
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.

&IF '{&WINDOW-SYSTEM}' NE 'TTY' &THEN
IF NOT c-wins:LOAD-ICON("wimage/safety.ico":U) THEN
    MESSAGE "Unable to load icon: wimage/safety.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW c-wins
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fr_main
   FRAME-NAME Custom                                                    */
ASSIGN 
       bu_file:AUTO-RESIZE IN FRAME fr_main      = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(c-wins)
THEN c-wins:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME c-wins
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-wins c-wins
ON END-ERROR OF c-wins /* Check data STK on Premium */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-wins c-wins
ON WINDOW-CLOSE OF c-wins /* Check data STK on Premium */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit c-wins
ON CHOOSE OF bu_exit IN FRAME fr_main /* EXIT */
DO:
    Apply "Close" to This-procedure.
    Return no-apply.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exp c-wins
ON CHOOSE OF bu_exp IN FRAME fr_main /* Export */
DO:
    IF cb_format = "1" THEN DO:
        OUTPUT TO VALUE("D:\Temp\format_stk_update.csv"). 
        EXPORT DELIMITER "|"
            " ลำดับที่      "
            " เลขกรมธรรม์   "
            " เลขสติ๊กเกอร์ "
            " เลขที่ใบเสร็จ "
            " หมายเหตุ      " .
        MESSAGE "Export file : D:\Temp\format_stk_update.csv " VIEW-AS ALERT-BOX.
    END.
    ELSE DO:
      OUTPUT TO VALUE("D:\Temp\format_stk_cancel.csv"). 
        EXPORT DELIMITER "|"
            " No "
            " ระบุ Producer code " .
         EXPORT DELIMITER "|"
            " 1 "
            " ระบุเลขสติ๊กเกอร์ ". 
         MESSAGE "Export file : D:\Temp\format_stk_cancel.csv " VIEW-AS ALERT-BOX.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_file
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_file c-wins
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
        fi_inputfile  = cvData.
        DISP fi_inputfile WITH FRAME fr_main.     
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_OK c-wins
ON CHOOSE OF bu_OK IN FRAME fr_main /* OK */
DO:
    IF  fi_inputfile = "" THEN DO:
        MESSAGE "Please insert input file name !!!" VIEW-AS ALERT-BOX.
        Apply "Entry"  to fi_inputfile.
        Return no-apply.
    END.
    ELSE IF fi_output = ""  THEN DO:
        MESSAGE "Please insert output file name !!!" VIEW-AS ALERT-BOX.
        Apply "Entry"  to fi_output.
        Return no-apply.
    END.

    IF ra_type = 1  THEN RUN proc_matchstk.
    ELSE RUN proc_matchstk_CA.

    FOR EACH  wdetail :
        DELETE  wdetail.
    END.
    RELEASE brstat.tlt.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cb_format
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cb_format c-wins
ON VALUE-CHANGED OF cb_format IN FRAME fr_main
DO:
    cb_format = INPUT cb_format .
    DISP cb_format WITH FRAME fr_main .
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_inputfile
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_inputfile c-wins
ON LEAVE OF fi_inputfile IN FRAME fr_main
DO:
    fi_inputfile  =  Input  fi_inputfile .
    Disp  fi_inputfile with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_output
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_output c-wins
ON LEAVE OF fi_output IN FRAME fr_main
DO:
    fi_output  =  Input  fi_output .
    Disp  fi_output with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_type
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_type c-wins
ON VALUE-CHANGED OF ra_type IN FRAME fr_main
DO:
    ra_type = INPUT ra_type.
    DISP ra_type WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK c-wins 


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
    /* comment by : A65-0170..
    gv_prgid = "wgwstkb1".
    gv_prog  = "Query & Update DATA STK BU3".*/
    gv_prgid = "wgwstkb1".                          /*A65-0170*/
    gv_prog  = "Match file Update DATA STK BU3".    /*A65-0170*/
    RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).
    /* add by : A65-0170 */ 
    ASSIGN ra_type = 1              
           cb_format = "1" .
    DISP ra_type cb_format WITH FRAME fr_main. 
    /* end : A65-0170 */
    
    /**************************** *****************************************/ 
    /*  RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE). */ 
    /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
    SESSION:DATA-ENTRY-RETURN = YES.
    IF NOT THIS-PROCEDURE:PERSISTENT THEN
        WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI c-wins  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(c-wins)
  THEN DELETE WIDGET c-wins.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI c-wins  _DEFAULT-ENABLE
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
  DISPLAY cb_format ra_type fi_inputfile fi_output 
      WITH FRAME fr_main IN WINDOW c-wins.
  ENABLE bu_exp cb_format ra_type fi_inputfile bu_file bu_OK fi_output bu_exit 
         RECT-332 RECT-501 RECT-504 RECT-505 
      WITH FRAME fr_main IN WINDOW c-wins.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW c-wins.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Import_notification1 c-wins 
PROCEDURE Import_notification1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*FOR EACH  wdetail :
    DELETE  wdetail.
END.
INPUT FROM VALUE(fi_inputfile).
REPEAT:
    CREATE wdetail.
    IMPORT DELIMITER "|" 
        wdetail.notifydate   /*  1  ลำดับที่       */                                  
        wdetail.branch       /*  2  สาขา           */                          
        wdetail.policy       /*  3  เลขกรมธรรม์    */                                  
        wdetail.stk          /*  4  เลขสติ๊กเกอร์  */                                  
        wdetail.docno        /*  5  เลขที่ใบเสร็จ  */                   
        wdetail.remark    .  /*  6  หมายเหตุ       */
END.
ASSIGN 
    nv_countdata     = 0
    nv_countnotcomp  = 0.
    nv_countcomplete = 0.
FOR EACH wdetail .
    IF INDEX(wdetail.notifydate,"บริษัท") <> 0 THEN DELETE wdetail.
    ELSE IF INDEX(wdetail.notifydate,"ที่") <> 0 THEN DELETE wdetail.
    ELSE IF wdetail.notifydate   <> " "         THEN  DO:
        ASSIGN  nv_countdata = nv_countdata  + 1.
        RUN proc_cutpolicy.
        IF substr(trim(wdetail.stk),1,1) <> "0"  THEN ASSIGN wdetail.stk  = "0" + TRIM(wdetail.stk).
        FIND FIRST brstat.tlt    WHERE 
            brstat.tlt.nor_noti_tlt   = trim(wdetail.policy)   AND 
            brstat.tlt.cha_no         = trim(wdetail.stk)      AND 
            brstat.tlt.genusr         = trim(n_producer)       NO-ERROR NO-WAIT .
        IF NOT AVAIL brstat.tlt THEN DO: 
            ASSIGN nv_countcomplete = nv_countcomplete + 1.
            CREATE brstat.tlt.
            ASSIGN
                brstat.tlt.entdat         = TODAY
                brstat.tlt.enttim         = STRING(TIME,"HH:MM:SS")
                brstat.tlt.trntime        = STRING(TIME,"HH:MM:SS")
                brstat.tlt.trndat         = fi_loaddate
                brstat.tlt.genusr         = trim(n_producer)      /* wdetail.Company   */ 
                brstat.tlt.nor_noti_tlt   = trim(wdetail.policy)  /* 3  เลขกรมธรรม์    */  
                brstat.tlt.cha_no         = trim(wdetail.stk)     /* 4  เลขสติ๊กเกอร์  */                           
                brstat.tlt.comp_usr_tlt   = trim(wdetail.branch)  /* 2  สาขา           */  
                brstat.tlt.safe2          = TRIM(wdetail.docno)   /* 5  เลขที่ใบเสร็จ  */ 
                brstat.tlt.filler2        = trim(wdetail.remark)  /* 6  หมายเหตุ       */ 
                brstat.tlt.endno          = USERID(LDBNAME(1))    /* User Load Data    */
                brstat.tlt.imp            = "IM"                  /* Import Data       */
                brstat.tlt.releas         = "No"   .
            /*FIND FIRST sicuw.uwm301 WHERE uwm301.drinam[9] = "STKNO:" + tlt.cha_no NO-LOCK NO-ERROR .
            IF AVAIL sicuw.uwm301 THEN
                ASSIGN brstat.tlt.filler2 = brstat.tlt.filler2  + " " + sicuw.uwm301.policy + "ใช้งานเลขสติ๊กเกอร์" .*/
            DELETE wdetail.
        END.
        ELSE nv_countnotcomp = nv_countnotcomp + 1.
    END.
END.
Run Open_tlt.
Message "Load  Data Complete "  SKIP
    "จำนวนข้อมูลทั้งหมด:    "  nv_countdata      SKIP
    "จำนวนข้อมูลที่นำเข้า:  "  nv_countcomplete  SKIP
    "จำนวนข้อมูลที่ไม่สามารถนำเข้า:  "  nv_countnotcomp  View-as alert-box. */ 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cutpolicy c-wins 
PROCEDURE proc_cutpolicy :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_i AS INT .
DEF VAR nv_c AS CHAR.
DEF VAR nv_l AS INT.
DEF VAR nv_p AS CHAR.
DEF VAR ind  AS INT.
ASSIGN 
    nv_c = trim(wdetail.policy)
    nv_i = 0
    nv_l = LENGTH(nv_c).
DO WHILE nv_i <= nv_l:
    ind = 0.
    ind = INDEX(nv_c,"/").
    IF ind <> 0 THEN DO:
        nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
    END.
    ind = INDEX(nv_c,"\").
    IF ind <> 0 THEN DO:
        nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
    END.
    ind = INDEX(nv_c,"-").
    IF ind <> 0 THEN DO:
        nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
    END.
    ind = INDEX(nv_c,"_").
    IF ind <> 0 THEN DO:
        nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
    END.
    ind = INDEX(nv_c,".").
    IF ind <> 0 THEN DO:
        nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
    END.
    ind = INDEX(nv_c," ").
    IF ind <> 0 THEN DO:
        nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
    END.
    nv_i = nv_i + 1.
END.
ASSIGN
    wdetail.policy  = nv_c . 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matchstk c-wins 
PROCEDURE proc_matchstk :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH  wdetail :
    DELETE  wdetail.
END.
INPUT FROM VALUE(fi_inputfile).
REPEAT:
    CREATE wdetail.
    IMPORT DELIMITER "|" 
        wdetail.notifydate   /*  1  ลำดับที่       */   
        wdetail.policy       /*  3  เลขกรมธรรม์    */                                  
        wdetail.stk          /*  4  เลขสติ๊กเกอร์  */                                  
        wdetail.docno        /*  5  เลขที่ใบเสร็จ  */                   
        wdetail.remark    .  /*  6  หมายเหตุ       */
END.
FOR EACH wdetail .
    IF INDEX(wdetail.notifydate,"บริษัท") <> 0 THEN DELETE wdetail.
    ELSE IF INDEX(wdetail.notifydate,"ที่") <> 0 THEN DELETE wdetail.
    ELSE IF INDEX(wdetail.notifydate," ") <> 0 THEN DELETE wdetail.
    ELSE IF wdetail.notifydate   <> " "         THEN  DO:
        RUN proc_cutpolicy.
        IF substr(trim(wdetail.stk),1,1) <> "0"  THEN ASSIGN wdetail.stk  = "0" + TRIM(wdetail.stk).
        FIND FIRST brstat.tlt WHERE  brstat.tlt.cha_no = trim(wdetail.stk) NO-ERROR NO-WAIT .
        IF AVAIL brstat.tlt THEN DO: 

           FIND FIRST stat.Detaitem USE-INDEX detaitem11 WHERE
                stat.Detaitem.serailno = wdetail.stk NO-LOCK NO-ERROR .

            IF AVAIL stat.Detaitem THEN DO:

               FOR EACH brstat.tlt WHERE index(stat.Detaitem.serailno,brstat.tlt.cha_no) <> 0 . /*A64-0060*/
                    ASSIGN  brstat.tlt.nor_noti_tlt = stat.Detaitem.Policy.
                    IF INDEX(brstat.tlt.releas,"Cancel") <> 0  THEN 
                        ASSIGN brstat.tlt.releas  = "Yes/Cancel".
                    ELSE ASSIGN brstat.tlt.releas = "Yes".

                    IF brstat.tlt.nor_noti_tlt <> "" THEN DO:
                        IF SUBSTR(brstat.tlt.nor_noti_tlt,1,1) = "D" THEN ASSIGN  brstat.tlt.comp_usr_tlt = SUBSTR(brstat.tlt.nor_noti_tlt,2,1).
                        ELSE ASSIGN brstat.tlt.comp_usr_tlt = SUBSTR(brstat.tlt.nor_noti_tlt,1,2).

                        FIND FIRST sicuw.uwm100 USE-INDEX uwm10001 WHERE sicuw.uwm100.policy = brstat.tlt.nor_noti_tlt NO-LOCK NO-ERROR .
                            IF AVAIL sicuw.uwm100 THEN DO:
                                /*  comment by : A64-0060...
                                ASSIGN brstat.tlt.filler2 = IF brstat.tlt.filler2 <> "" THEN 
                                                            brstat.tlt.filler2 + " / Use by Code : " +  sicuw.uwm100.acno1
                                                            ELSE "Use by Code : " +  sicuw.uwm100.acno1.
                               ...A64-0060...*/
                                /* Add by : A64-0060 */
                               IF brstat.tlt.filler2 <> "" THEN DO:
                                IF index(brstat.tlt.filler2,"Use by Code") <> 0 THEN ASSIGN brstat.tlt.filler2 = brstat.tlt.filler2 .
                                ELSE IF index(brstat.tlt.filler2,"Release") <> 0 THEN 
                                    ASSIGN brstat.tlt.filler2 = brstat.tlt.filler2 + " / Use by Code : " +  sicuw.uwm100.acno1.
                               END.
                               ELSE ASSIGN brstat.tlt.filler2 = "Use by Code : " +  sicuw.uwm100.acno1.
                               /* end A64-0060 */
                            END.
                    END.
                END. /*A64-0060*/
            END.
        END.
        ELSE ASSIGN wdetail.remark = " Not Found Data (tlt) ".


    END.
END.
RELEASE brstat.tlt.
RELEASE sicuw.uwm100.
RELEASE stat.Detaitem.
If  substr(fi_output,length(fi_output) - 3,4) <>  ".csv"  THEN 
    fi_output  =  Trim(fi_output) + ".csv"  .
OUTPUT TO VALUE(fi_output). 
EXPORT DELIMITER "|" 
    "ที่"  
    "สาขา "
    "เลขกรมธรรม์"
    "เลขสติ๊กเกอร์"
    "เลขที่ใบเสร็จ"
    "Producer "
    "Status "
    "หมายเหตุ".
FOR EACH wdetail WHERE wdetail.stk <> "" .
    FIND FIRST brstat.tlt WHERE brstat.tlt.cha_no = trim(wdetail.stk) NO-LOCK NO-ERROR.  
     IF AVAIL brstat.tlt THEN DO:
         FOR EACH brstat.tlt WHERE brstat.tlt.cha_no = trim(wdetail.stk) NO-LOCK .  /*A64-0060*/
            EXPORT DELIMITER "|"
               brstat.tlt.trndat       
               brstat.tlt.comp_usr_tlt 
               brstat.tlt.nor_noti_tlt 
               brstat.tlt.cha_no       
               brstat.tlt.safe2 
               brstat.tlt.genusr
               brstat.tlt.releas 
               brstat.tlt.filler2 .  
         END. /*A64-0060*/
     END.
     ELSE DO:
         EXPORT DELIMITER "|"
             wdetail.notifydate 
             ""
             wdetail.policy     
             wdetail.stk        
             wdetail.docno 
             ""
             ""
             wdetail.remark .
     END.
END.
Message "Match Data Complete "  View-as alert-box. 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matchstk_CA c-wins 
PROCEDURE proc_matchstk_CA :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: create by A65-0170      
------------------------------------------------------------------------------*/
def var nv_no         as char .
def var nv_stkno      as char .
def var nv_producer   as char .
DEF VAR nv_count AS INTE .

FOR EACH  wdetail :
    DELETE  wdetail.
END.
INPUT FROM VALUE(fi_inputfile).
REPEAT:
    IMPORT DELIMITER "|" 
    nv_no 
    nv_stkno.

    IF index(nv_no,"No") <> 0 THEN DO:
        ASSIGN nv_producer = nv_stkno .
        NEXT.
    END.
    ELSE IF nv_no = "" THEN NEXT.
    ELSE DO:
        CREATE wdetail.
        ASSIGN wdetail.stk    =  trim(nv_stkno)          /*  4  เลขสติ๊กเกอร์  */   
               wdetail.docno  =  trim(nv_producer)      /*  6  producer code      */
               wdetail.remark =  "Match Cancel/" + USERID(LDBNAME(1)) + "/" + STRING(TODAY,"99/99/9999") + " " + STRING(TIME,"HH:MM:SS") .
    END.
END.
FOR EACH wdetail .
    IF trim(wdetail.stk)   <> " "  THEN  DO:
        IF substr(trim(wdetail.stk),1,1) <> "0"  THEN ASSIGN wdetail.stk  = "0" + TRIM(wdetail.stk).
        FIND FIRST brstat.tlt USE-INDEX tlt06 WHERE  
                   brstat.tlt.cha_no = trim(wdetail.stk) AND 
                   brstat.tlt.genusr = TRIM(wdetail.docno) NO-ERROR NO-WAIT .
        IF AVAIL brstat.tlt THEN DO: 
           IF INDEX(brstat.tlt.releas,"Cancel")   <> 0  THEN ASSIGN wdetail.remark = trim("ยกเลิกแล้ว/" + brstat.tlt.filler2).
           ELSE IF INDEX(brstat.tlt.releas,"Yes") <> 0  THEN DO:
               ASSIGN brstat.tlt.releas  = "Yes/Cancel"
                      brstat.tlt.filler2 = trim(wdetail.remark + "/" + brstat.tlt.filler2).
           END.
           ELSE DO: 
               ASSIGN brstat.tlt.releas  = "No/Cancel"
                      brstat.tlt.filler2 = trim(wdetail.remark + "/" + brstat.tlt.filler2).
           END.
        END.
        ELSE ASSIGN wdetail.remark = " Not Found Data (tlt) ".
    END.
END.
RELEASE brstat.tlt.
If  substr(fi_output,length(fi_output) - 3,4) <>  ".csv"  THEN 
    fi_output  =  Trim(fi_output) + ".csv"  .
OUTPUT TO VALUE(fi_output). 
EXPORT DELIMITER "|" 
    "No"  
    "เลขสติ๊กเกอร์"
    "Producer "
    "Status "
    "หมายเหตุ".

nv_count = 0.
FOR EACH wdetail WHERE wdetail.stk <> "" .
    ASSIGN nv_count  = nv_count + 1.
    FIND FIRST brstat.tlt USE-INDEX tlt06 WHERE  
               brstat.tlt.cha_no = trim(wdetail.stk) AND 
               brstat.tlt.genusr = TRIM(wdetail.docno) NO-LOCK NO-ERROR NO-WAIT .  
     IF AVAIL brstat.tlt THEN DO:
         FOR EACH brstat.tlt WHERE brstat.tlt.cha_no = trim(wdetail.stk) NO-LOCK .  /*A64-0060*/
            EXPORT DELIMITER "|"
               nv_count       
               brstat.tlt.cha_no       
               brstat.tlt.genusr
               brstat.tlt.releas 
               brstat.tlt.filler2 .  
         END. /*A64-0060*/
     END.
     ELSE DO:
         EXPORT DELIMITER "|"
             nv_count
             wdetail.stk        
             wdetail.docno 
             ""
             wdetail.remark .
     END.
END.
Message "Match Cancel Complete "  View-as alert-box. 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_report c-wins 
PROCEDURE proc_report :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*DEF VAR n_sck AS CHAR .
ASSIGN 
    n_producer = ""
    n_record = 0
    nv_cnt   = 0
    nv_row   = 1  .
If  substr(fi_filename,length(fi_filename) - 3,4) <>  ".csv"  THEN 
    fi_filename  =  Trim(fi_filename) + ".csv"  .

ASSIGN n_producer = fi_producer2
       nv_cnt  =  0
       nv_row  =  1.
OUTPUT TO VALUE(fi_filename). 
EXPORT DELIMITER "|" 
    "ข้อมูลกรมธรรม์/เลขสติ๊กเกอร์ : " + n_producer .
EXPORT DELIMITER "|" 
    "วันที่"  
    "สาขา "
    "เลขกรมธรรม์"
    "เลขสติ๊กเกอร์"
    "เลขที่ใบเสร็จ"
    "หมายเหตุ"
    "Status".
IF cb_report = "เลขกรมธรรม์"      THEN DO:
    FOR EACH brstat.tlt  NO-LOCK 
        WHERE brstat.tlt.nor_noti_tlt >=   fi_repolicyfr_key   And
        brstat.tlt.nor_noti_tlt       <=   fi_repolicyto_key   And
        brstat.tlt.genusr              =   TRIM(n_producer)   BREAK BY brstat.tlt.nor_noti_tlt  .
        EXPORT DELIMITER "|" 
            brstat.tlt.trndat         /*  1  วันที่         */  
            brstat.tlt.comp_usr_tlt   /*  2  สาขา           */  
            brstat.tlt.nor_noti_tlt   /*  3  เลขกรมธรรม์    */  
            brstat.tlt.cha_no         /*  4  เลขสติ๊กเกอร์  */  
            brstat.tlt.safe2          /*  5  เลขที่ใบเสร็จ  */  
            brstat.tlt.filler2        /*  6  หมายเหตุ       */  
            brstat.tlt.releas.
    END. 
END.
ELSE DO:
    FOR EACH brstat.tlt Use-index  tlt01  Where
        brstat.tlt.trndat        >=   fi_trndatfr   And
        brstat.tlt.trndat        <=   fi_trndatto   And
        brstat.tlt.genusr         =  TRIM(n_producer) NO-LOCK . 
        IF      (cb_report = "สาขา" ) AND (brstat.tlt.comp_usr_tlt <> trim(fi_reportdata))  THEN NEXT.
        ELSE IF (cb_report = "Release Yes") AND (index(brstat.tlt.releas,"yes") = 0 )       THEN NEXT.
        ELSE IF (cb_report = "Release No" ) AND (index(brstat.tlt.releas,"no")  = 0 )       THEN NEXT. 
        ELSE IF (cb_report = "Release Cancel") AND (index(brstat.tlt.releas,"Cancel") = 0 ) THEN NEXT. 
        EXPORT DELIMITER "|" 
            brstat.tlt.trndat         /*  1  วันที่         */  
            brstat.tlt.comp_usr_tlt   /*  2  สาขา           */  
            brstat.tlt.nor_noti_tlt   /*  3  เลขกรมธรรม์    */  
            brstat.tlt.cha_no         /*  4  เลขสติ๊กเกอร์  */  
            brstat.tlt.safe2          /*  5  เลขที่ใบเสร็จ  */  
            brstat.tlt.filler2        /*  6  หมายเหตุ       */  
            brstat.tlt.releas .
    END. 
END.
Message "Export data Complete"  View-as alert-box.
RELEASE brstat.tlt.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

