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

/* ***************************  Definitions  **************************     */  
    
/* Parameters Definitions ---                                               */  
    
/* Local Variable Definitions ---                                           */  
/*Program name : Import Text File RK BROKER to Excel                        */  
/*Program id   : wgwtexss.w                                                 */
/*create by    : Kridtiya i. A58-0103                                       */  
/*               แปลงเทคเป็นไฟล์excel                                       */  

/*DataBase connect : GW_STAT -LD BRSTAT */                                  

/*--------------------------สำหรับข้อมูลกรมธรรม์  --------------------------*/   

DEF  VAR nv_inputfile  AS CHAR      FORMAT "x(150)"      INIT "" .
DEF  VAR nv_outputfile AS CHAR      FORMAT "x(150)"      INIT "" .
DEFINE VARIABLE nv_makeyr       AS INTEGER   NO-UNDO.
DEFINE VARIABLE nv_MinYear      AS INTEGER   NO-UNDO.
DEFINE VARIABLE nv_MaxYear      AS INTEGER   NO-UNDO.
DEFINE VARIABLE nv_Fmakesi      AS INTEGER   NO-UNDO.
DEFINE VARIABLE nv_Tmakesi      AS INTEGER   NO-UNDO.
DEFINE VARIABLE nv_Fcst         AS INTEGER   NO-UNDO.
DEFINE VARIABLE nv_Tcst         AS INTEGER   NO-UNDO.

DEFINE VARIABLE nv_Dedod        AS INTEGER   NO-UNDO.
DEFINE VARIABLE nv_AdDod        AS INTEGER   NO-UNDO.
DEFINE VARIABLE nv_DedPD        AS INTEGER   NO-UNDO.

DEFINE VARIABLE nv_fleet_per    AS DECIMAL   NO-UNDO.
DEFINE VARIABLE nv_ncbyrs       AS INTEGER   NO-UNDO.
DEFINE VARIABLE nv_ncb_per      AS DECIMAL   NO-UNDO.
DEFINE VARIABLE nv_loadclm_per  AS DECIMAL   NO-UNDO.
DEFINE VARIABLE nv_dspc_per     AS DECIMAL   NO-UNDO.

DEFINE VARIABLE nv_CST_C        AS CHARACTER NO-UNDO.

DEFINE VARIABLE nv_DriverName   AS LOGICAL   NO-UNDO.

DEFINE VARIABLE nv_Remark       AS CHARACTER NO-UNDO.

DEFINE VARIABLE nv_char         AS CHARACTER NO-UNDO.

DEFINE VARIABLE nv_count        AS INTEGER   NO-UNDO.

DEFINE STREAM nfile.
/* ----------------------------------------------------------------------- */
/************************************************************************************/
DEFINE NEW SHARED TEMP-TABLE  TEMPFile   NO-UNDO
/* */
FIELD CompanyCode             AS CHARACTER FORMAT "x(5)"       INITIAL ""
FIELD CampaignCode            AS CHARACTER FORMAT "x(15)"      INITIAL ""
FIELD PrmCode                 AS CHARACTER FORMAT "x(15)"      INITIAL ""
FIELD PromotionNumber         AS CHARACTER FORMAT "x(15)"      INITIAL ""
/**/
FIELD covcod                  AS CHARACTER FORMAT "x(5)"       INITIAL ""
FIELD Class                   AS CHARACTER FORMAT "x(5)"       INITIAL ""
FIELD SClass                  AS CHARACTER FORMAT "x(5)"       INITIAL ""
FIELD GarageCd                AS CHARACTER FORMAT "x(5)"       INITIAL ""
FIELD Vehgrp                  AS CHARACTER FORMAT "x(5)"       INITIAL ""
/**/
FIELD Make                    AS CHARACTER FORMAT "x(20)"      INITIAL ""
FIELD Model                   AS CHARACTER FORMAT "x(30)"      INITIAL ""
/**/
FIELD minyrs                  AS INTEGER   FORMAT ">9"         INITIAL 0
FIELD maxyrs                  AS INTEGER   FORMAT ">9"         INITIAL 0
FIELD Yrar_C                  AS CHARACTER FORMAT "x(10)"      INITIAL ""
/**/
FIELD MinCST                  AS INTEGER   FORMAT ">>>>9"      INITIAL 0
FIELD MaxCST                  AS INTEGER   FORMAT ">>>>9"      INITIAL 0
FIELD CST_C                   AS CHARACTER FORMAT "x(10)"      INITIAL ""
/**/
FIELD MinSI                   AS INTEGER   FORMAT ">>,>>>,>>9" INITIAL 0
FIELD MaxSI                   AS INTEGER   FORMAT ">>,>>>,>>9" INITIAL 0
FIELD SI_C                    AS CHARACTER FORMAT "x(10)"      INITIAL ""
/**/
/*ระบุชื่อ Y,N*/
FIELD DriverName              AS CHARACTER FORMAT "x"
/*อุปกรณ์เสริมพิเศษ*/
FIELD uom6_u                  AS CHARACTER FORMAT "x"          INITIAL ""
/*ชุด deduct*/
FIELD Dedod                   AS CHARACTER FORMAT "x(10)"      INITIAL ""
FIELD AdDod                   AS CHARACTER FORMAT "x(10)"      INITIAL ""
FIELD DedPD                   AS CHARACTER FORMAT "x(10)"      INITIAL ""
/**/
FIELD fleet                   AS CHARACTER FORMAT "x(10)"      INITIAL ""
FIELD ncb                     AS CHARACTER FORMAT "x(10)"      INITIAL ""
FIELD dspc                    AS CHARACTER FORMAT "x(10)"      INITIAL ""
FIELD loadclaim               AS CHARACTER FORMAT "x(10)"      INITIAL ""
/**/
FIELD baseprm1                AS DECIMAL   FORMAT ">>>,>>9.99-" INITIAL 0 
FIELD baseprm3                AS DECIMAL   FORMAT ">>>,>>9.99-" INITIAL 0 
FIELD prm_t                   AS DECIMAL   FORMAT ">>>,>>9.99-" INITIAL 0
FIELD prm_gap                 AS DECIMAL   FORMAT ">>>,>>9.99-" INITIAL 0
FIELD CMIprm_t                AS DECIMAL   FORMAT ">>>,>>9.99-" INITIAL 0
FIELD CMIprm_gap              AS DECIMAL   FORMAT ">>>,>>9.99-" INITIAL 0
FIELD Remark                  AS CHARACTER FORMAT "x(20)"       INITIAL ""

FIELD vehuse                  AS CHARACTER FORMAT "x(2)"        INITIAL ""
.
/************************************************************************************/
/* 
INDEX LoadFile01  IS PRIMARY  ProcessDate      ASCENDING 
                              ProcessTime      ASCENDING
INDEX LoadFile02              PolicyNumber     ASCENDING
INDEX LoadFile03              Registration     ASCENDING
INDEX LoadFile04              PolicyTypeCd     ASCENDING
                              RateGroup        ASCENDING
                              PolicyNumber     ASCENDING
INDEX LoadFile05              ConfirmBy        ASCENDING
                              PolicyNumber     ASCENDING
.
*/
/*DESCENDING.*/
DEFINE NEW SHARED TEMP-TABLE  TLoadFile   NO-UNDO
/* */
FIELD CompanyCode             AS CHARACTER FORMAT "x(5)"       INITIAL ""
FIELD CampaignCode            AS CHARACTER FORMAT "x(15)"      INITIAL ""
FIELD PrmCode                 AS CHARACTER FORMAT "x(15)"      INITIAL ""
FIELD PromotionNumber         AS CHARACTER FORMAT "x(15)"      INITIAL ""
/**/
FIELD covcod                  AS CHARACTER FORMAT "x(5)"       INITIAL ""
FIELD Class                   AS CHARACTER FORMAT "x(5)"       INITIAL ""
FIELD SClass                  AS CHARACTER FORMAT "x(5)"       INITIAL ""
FIELD GarageCd                AS CHARACTER FORMAT "x(5)"       INITIAL ""
FIELD Vehgrp                  AS CHARACTER FORMAT "x(5)"       INITIAL ""
/**/
FIELD Make                    AS CHARACTER FORMAT "x(20)"      INITIAL ""
FIELD Model                   AS CHARACTER FORMAT "x(30)"      INITIAL ""
/**/
FIELD minyrs                  AS INTEGER   FORMAT ">9"         INITIAL 0
FIELD maxyrs                  AS INTEGER   FORMAT ">9"         INITIAL 0
FIELD Yrar_C                  AS CHARACTER FORMAT "x(10)"      INITIAL ""
/**/
FIELD MinCST                  AS INTEGER   FORMAT ">>>>9"      INITIAL 0
FIELD MaxCST                  AS INTEGER   FORMAT ">>>>9"      INITIAL 0
FIELD CST_C                   AS CHARACTER FORMAT "x(10)"      INITIAL ""
/**/
FIELD MinSI                   AS INTEGER   FORMAT ">>,>>>,>>9"  INITIAL 0
FIELD MaxSI                   AS INTEGER   FORMAT ">>>,>>>,>>9" INITIAL 0
FIELD SI_C                    AS CHARACTER FORMAT "x(10)"       INITIAL ""
/**/
/*ระบุชื่อ Y,N*/
FIELD DriverName              AS LOGICAL   INITIAL NO
/*อุปกรณ์เสริมพิเศษ*/
FIELD uom6_u                  AS CHARACTER FORMAT "x"          INITIAL ""
/*ชุด deduct*/
FIELD Dedod                   AS DECIMAL   FORMAT ">>,>>9.99"  INITIAL 0
FIELD AdDod                   AS DECIMAL   FORMAT ">>,>>9.99"  INITIAL 0
FIELD DedPD                   AS DECIMAL   FORMAT ">>,>>9.99"  INITIAL 0
/**/
FIELD fleet_per               AS DECIMAL   FORMAT ">>9.99"     INITIAL 0
FIELD ncbyrs                  AS INTEGER   FORMAT "9"          INITIAL 0
FIELD ncb_per                 AS DECIMAL   FORMAT ">>9.99"     INITIAL 0
FIELD Dspc_per                AS DECIMAL   FORMAT ">>9.99"     INITIAL 0
FIELD loadclm_per             AS DECIMAL   FORMAT ">>>9.99"    INITIAL 0
/**/
FIELD fleet_c                 AS CHARACTER FORMAT "x(10)"      INITIAL ""
FIELD ncb_c                   AS CHARACTER FORMAT "x(10)"      INITIAL ""
FIELD Dspc_c                  AS CHARACTER FORMAT "x(10)"      INITIAL ""
FIELD loadclaim_c             AS CHARACTER FORMAT "x(10)"      INITIAL ""
/**/
FIELD baseprm1                AS INTEGER   FORMAT ">>>,>>9"    INITIAL 0
FIELD baseprm3                AS INTEGER   FORMAT ">>>,>>9"    INITIAL 0
FIELD MatchBase1              AS LOGICAL   
/**/
FIELD prm_t                   AS DECIMAL   FORMAT ">>>,>>9.99-" INITIAL 0
FIELD prm_gap                 AS DECIMAL   FORMAT ">>>,>>9.99-" INITIAL 0
FIELD CMIprm_t                AS DECIMAL   FORMAT ">>>,>>9.99-" INITIAL 0
FIELD CMIprm_gap              AS DECIMAL   FORMAT ">>>,>>9.99-" INITIAL 0
FIELD MatchPrm_t              AS LOGICAL   INITIAL NO
FIELD MatchPrm_gp             AS LOGICAL   INITIAL NO
FIELD HasCalculateStep        AS LOGICAL   INITIAL NO
/**/
FIELD Remark                  AS CHARACTER FORMAT "x(20)"       INITIAL ""
FIELD vehuse                  AS CHARACTER FORMAT "x(2)"        INITIAL ""
.


DEFINE NEW SHARED TEMP-TABLE  LTestFile   NO-UNDO
/* */
FIELD TestText1  AS CHARACTER FORMAT "x(50)"       INITIAL ""
FIELD TestText2  AS CHARACTER FORMAT "x(50)"       INITIAL ""
FIELD TestText3  AS CHARACTER FORMAT "x(50)"       INITIAL ""
FIELD TestText4  AS CHARACTER FORMAT "x(50)"       INITIAL ""
FIELD TestText5  AS CHARACTER FORMAT "x(50)"       INITIAL ""
.
/* ----------------------------------------------------------------------- */
/*    workf_out      */
DEFINE NEW SHARED TEMP-TABLE  workf_out   NO-UNDO
    FIELD QNONumber     AS CHARACTER FORMAT "x(20)"    INITIAL ""  
    FIELD company       AS CHARACTER FORMAT "x(100)"   INITIAL ""  
    FIELD company2      AS CHARACTER FORMAT "x(100)"   INITIAL ""  
    FIELD company3      AS CHARACTER FORMAT "x(100)"   INITIAL ""  
    FIELD ntitle        AS CHARACTER FORMAT "x(30)"    INITIAL ""  
    FIELD insname       AS CHARACTER FORMAT "x(100)"   INITIAL ""
    FIELD icno          AS CHARACTER FORMAT "x(15)"    INITIAL ""
    FIELD addr1         AS CHARACTER FORMAT "x(50)"    INITIAL ""
    FIELD addr2         AS CHARACTER FORMAT "x(40)"    INITIAL ""
    FIELD addr3         AS CHARACTER FORMAT "x(40)"    INITIAL ""
    FIELD addr4         AS CHARACTER FORMAT "x(40)"    INITIAL ""
    FIELD subclass      AS CHARACTER FORMAT "x(5)"     INITIAL ""
    FIELD brand         AS CHARACTER FORMAT "x(30)"    INITIAL "" 
    FIELD model         AS CHARACTER FORMAT "x(50)"    INITIAL ""
    FIELD eng_cc        AS CHARACTER FORMAT "x(5)"     INITIAL ""
    FIELD tons          AS CHARACTER FORMAT "x(5)"     INITIAL ""
    FIELD Seat          AS CHARACTER FORMAT "x(5)"     INITIAL "" 
    FIELD body          AS CHARACTER FORMAT "x(20)"    INITIAL ""
    FIELD vehreg        AS CHARACTER FORMAT "x(35)"    INITIAL ""
    FIELD engno         AS CHARACTER FORMAT "x(35)"    INITIAL ""
    FIELD cha_no        AS CHARACTER FORMAT "x(35)"    INITIAL ""
    FIELD caryear       AS CHARACTER FORMAT "x(5)"     INITIAL ""
    FIELD vehuse        AS CHARACTER FORMAT "x(35)"    INITIAL ""
    FIELD garage        AS CHARACTER FORMAT "x(1)"    INITIAL ""
    FIELD covcod        AS CHARACTER FORMAT "x(5)"     INITIAL ""
    FIELD sumins        AS CHARACTER FORMAT "x(30)"    INITIAL ""
    FIELD volprem       AS CHARACTER FORMAT "x(35)"    INITIAL ""
    FIELD netprem       AS CHARACTER FORMAT "x(35)"    INITIAL ""
    FIELD comprem       AS CHARACTER FORMAT "x(35)"    INITIAL ""
    FIELD bennames      AS CHARACTER FORMAT "x(60)"    INITIAL ""
    FIELD drino         AS CHARACTER FORMAT "x(15)"    INITIAL ""
    FIELD driver1       AS CHARACTER FORMAT "x(80)"    INITIAL ""
    FIELD dribirth1     AS CHARACTER FORMAT "x(10)"    INITIAL ""
    FIELD driver2       AS CHARACTER FORMAT "x(80)"    INITIAL ""
    FIELD dribirth2     AS CHARACTER FORMAT "x(10)"    INITIAL ""
    FIELD comdat        AS CHARACTER FORMAT "x(10)"    INITIAL ""
    FIELD expdat        AS CHARACTER FORMAT "x(10)"    INITIAL ""
    FIELD companyold    AS CHARACTER FORMAT "x(60)"    INITIAL ""
    FIELD prevpol       AS CHARACTER FORMAT "x(20)"    INITIAL ""
    FIELD comdat72      AS CHARACTER FORMAT "x(10)"    INITIAL ""
    FIELD expdat72      AS CHARACTER FORMAT "x(10)"    INITIAL ""
    FIELD InspNm        AS CHARACTER FORMAT "x(60)"    INITIAL "" 
    FIELD Inspmobile    AS CHARACTER FORMAT "x(60)"    INITIAL "" 
    FIELD remark        AS CHARACTER FORMAT "x(100)"    INITIAL ""  
    FIELD AgentReq      AS CHARACTER FORMAT "x(50)"    INITIAL ""  /*ผู้แจ้ง*/      
    FIELD AgentCd       AS CHARACTER FORMAT "x(10)"    INITIAL ""  /*รหัส*/         
    FIELD ReqDate       AS CHARACTER FORMAT "x(10)"    INITIAL ""  /*วันที่แจ้ง*/   
    FIELD Memoby        AS CHARACTER FORMAT "x(30)"    INITIAL ""  /*ผู้ตรวจ*/ 
    FIELD addr_rep      AS CHARACTER FORMAT "x(150)"   INITIAL ""
    .

nv_Remark = "".

/*
INPUT STREAM nfile FROM "D:\WebBU\RATCHANEE_SaeLoo\ANC_PDFTEXT.TXT".

INPUT STREAM nfile FROM "D:\WebBU\RATCHANEE_SaeLoo\FILEExcel_TextTab.TXT".*/
/*INPUT STREAM nfile FROM "u:\FILEExcel_25022015_test3.TXT".*/

/* ************************************************************************************************ */
/* ************************************************************************************************ */

DEFINE VAR nv_daily       AS CHARACTER FORMAT "X(770)"      INITIAL ""  NO-UNDO.
DEFINE VAR nv_chr         AS CHARACTER FORMAT "X(01)"       INITIAL ""  NO-UNDO.
DEFINE VARIABLE nv_L11Cur AS LOGICAL INITIAL NO  NO-UNDO.
DEFINE VARIABLE nv_column AS INTEGER   NO-UNDO.
DEFINE VARIABLE nv_datst  AS LOGICAL INITIAL NO  NO-UNDO.
DEFINE VARIABLE nv_addrst AS LOGICAL INITIAL NO  NO-UNDO.
DEFINE VARIABLE nv_daily2 AS CHAR INIT "" .
DEFINE STREAM  ns2.
DEF VAR  nv_output AS CHAR FORMAT "x(60)".

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_filename fi_outfile bu_ok bu_exit bu_file ~
RECT-76 RECT-77 
&Scoped-Define DISPLAYED-OBJECTS fi_filename fi_outfile 

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
     SIZE 3.5 BY 1.

DEFINE BUTTON bu_ok 
     LABEL "Ok" 
     SIZE 7.5 BY 1.05
     FONT 6.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 64 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_outfile AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 68 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-76
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 86 BY 9.29
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-77
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 19.5 BY 1.57
     BGCOLOR 1 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_filename AT ROW 3.86 COL 14 COLON-ALIGNED NO-LABEL
     fi_outfile AT ROW 5.33 COL 14 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 7.19 COL 61.33
     bu_exit AT ROW 7.19 COL 70
     bu_file AT ROW 3.86 COL 80.83
     " INPUT File :" VIEW-AS TEXT
          SIZE 13 BY 1 AT ROW 3.86 COL 2.5
          BGCOLOR 18 FGCOLOR 1 FONT 6
     " Output File :" VIEW-AS TEXT
          SIZE 13 BY 1.05 AT ROW 5.33 COL 2.5
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Import Text File RK BROKER to Excel" VIEW-AS TEXT
          SIZE 82 BY 1.67 AT ROW 1.48 COL 2.5
          BGCOLOR 18 FGCOLOR 4 FONT 2
     RECT-76 AT ROW 1 COL 1
     RECT-77 AT ROW 6.91 COL 59.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 87 BY 9.67
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
         TITLE              = "Import Text File RK BROKER to Excel"
         HEIGHT             = 9.38
         WIDTH              = 86.33
         MAX-HEIGHT         = 18.76
         MAX-WIDTH          = 103.83
         VIRTUAL-HEIGHT     = 18.76
         VIRTUAL-WIDTH      = 103.83
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
   Custom                                                               */
ASSIGN 
       bu_file:AUTO-RESIZE IN FRAME fr_main      = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Import Text File RK BROKER to Excel */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Import Text File RK BROKER to Excel */
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
    DEF VAR no_add AS CHAR FORMAT "x(8)" .  

   SYSTEM-DIALOG GET-FILE cvData
        TITLE      "Choose Data File to Import ..."
        FILTERS    "Text Documents" "*.txt",
                    /* "Text Documents" "*.csv",*/
                            "Data Files (*.*)"     "*.*"
                            
        MUST-EXIST
        USE-FILENAME
        UPDATE OKpressed.
      
    IF OKpressed = TRUE THEN DO:
        ASSIGN 
            no_add        = STRING(MONTH(TODAY),"99")    + 
                            STRING(DAY(TODAY),"99")      + 
                            SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                            SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2)  
            fi_filename   = cvData
            nv_inputfile  = cvData
            fi_outfile    = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))   + no_add + ".csv"   
            nv_outputfile = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))   + no_add + ".csv" .

         DISP fi_filename fi_outfile WITH FRAME fr_main.     
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok C-Win
ON CHOOSE OF bu_ok IN FRAME fr_main /* Ok */
DO:
    IF fi_outfile = "" THEN DO:
        MESSAGE "File name output not Empty..!!!" SKIP
                "Insert file name Output file...!!!"      VIEW-AS ALERT-BOX.
        APPLY "Entry" TO fi_outfile.
        RETURN NO-APPLY.
    END.
    RUN proc_process.
    RUN proc_outputfile.
    
    /*RUN wgw\wgwtexs1.p (INPUT     nv_inputfile  ,     /* DATE  */
                        INPUT     nv_outputfile).*/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_filename
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_filename C-Win
ON LEAVE OF fi_filename IN FRAME fr_main
DO:
    fi_filename  =  Input  fi_filename.
    nv_inputfile = fi_filename .
    Disp  fi_filename  with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_outfile
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outfile C-Win
ON LEAVE OF fi_outfile IN FRAME fr_main
DO:
  fi_outfile  =  Input  fi_outfile.
  nv_outputfile = fi_outfile.
  Disp  fi_outfile with frame  fr_main.
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
  
  gv_prgid = "wgwtexrk".
  gv_prog  = "Import Text File RK BROKER to Excel".
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
  DISPLAY fi_filename fi_outfile 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_filename fi_outfile bu_ok bu_exit bu_file RECT-76 RECT-77 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_address C-Win 
PROCEDURE proc_address :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_addressum AS CHAR FORMAT "x(250)".
DEF VAR nv_soy       AS CHAR FORMAT "x(50)".
DEF VAR nv_road      AS CHAR FORMAT "x(50)".
DEF VAR ns_addr1     AS CHAR FORMAT "x(150)".
DEF VAR ns_addr2     AS CHAR FORMAT "x(50)".
DEF VAR ns_addr3     AS CHAR FORMAT "x(50)".
DEF VAR ns_addr4     AS CHAR FORMAT "x(50)".
DEF VAR ns_vehreg    AS CHAR FORMAT "x(30)".
DEF VAR ns_vehreg2   AS CHAR FORMAT "x(30)".
ASSIGN 
    nv_addressum = ""   
    nv_soy       = ""   
    nv_road      = ""   
    ns_addr1     = ""   
    ns_addr2     = ""   
    ns_addr3     = ""   
    ns_addr4     = ""   
    ns_vehreg    = ""   
    ns_vehreg2   = ""  
    ns_addr1     = trim(workf_out.addr1) 
    ns_addr2     = ""  
    ns_addr3     = ""     
    ns_addr4     = "".
              /* จังหวัด /จ./กทม/กรุงเทพ */
              IF r-index(ns_addr1,"จ.") <> 0 THEN
                  ASSIGN 
                  ns_addr4        = trim(SUBSTR(ns_addr1,r-index(ns_addr1,"จ.")))                 /*จ. */
                  ns_addr1        = trim(SUBSTR(ns_addr1,1, r-index(ns_addr1,"จ.") - 1 )).        /*จ.*/
              ELSE IF r-index(ns_addr1,"จังหวัด") <> 0 THEN                                       
                  ASSIGN                                                                          
                  ns_addr4        = trim(SUBSTR(ns_addr1,r-index(ns_addr1,"จังหวัด")))            /*จ. */
                  ns_addr1        = trim(SUBSTR(ns_addr1,1, r-index(ns_addr1,"จังหวัด") - 1 )).   /*จ.*/
              ELSE IF r-index(ns_addr1,"กรุง") <> 0 THEN                                          
                  ASSIGN                                                                          
                  ns_addr4        = trim(SUBSTR(ns_addr1,r-index(ns_addr1,"กรุง")))               /*กรุง */
                  ns_addr1        = trim(SUBSTR(ns_addr1,1, r-index(ns_addr1,"กรุง") - 1 )).      /*กรุง*/
              ELSE IF r-index(ns_addr1,"กทม") <> 0 THEN                                           
                  ASSIGN                                                                          
                  ns_addr4        = trim(SUBSTR(ns_addr1,r-index(ns_addr1,"กทม")))                /*กทม */
                  ns_addr1        = trim(SUBSTR(ns_addr1,1, r-index(ns_addr1,"กทม") - 1 )).       /*กทม*/
              IF r-index(ns_addr4,"จ.") <> 0 THEN ASSIGN  ns_addr4 = "จังหวัด" + trim(SUBSTR(ns_addr4,INDEX(ns_addr4,"จ.") + 2)) .
              /* อำเภอ /อ./เขต */
              IF r-index(ns_addr1,"เขต/อำเภอ") <> 0 THEN
                  ASSIGN 
                  ns_addr3        = trim(SUBSTR(ns_addr1,r-index(ns_addr1,"เขต/อำเภอ")))            /*อำเภอ /อ./เขต */
                  ns_addr3        = "อำเภอ" + trim(REPLACE(ns_addr3,"เขต/อำเภอ"," "))
                  ns_addr1        = trim(SUBSTR(ns_addr1,1, r-index(ns_addr1,"เขต/อำเภอ") - 1 )).   /*ตำบล  /ต. /แขวง*/
              ELSE IF r-index(ns_addr1,"เขต") <> 0 THEN
                  ASSIGN 
                  ns_addr3        = trim(SUBSTR(ns_addr1,r-index(ns_addr1,"เขต")))            /*อำเภอ /อ./เขต */
                  ns_addr1        = trim(SUBSTR(ns_addr1,1, r-index(ns_addr1,"เขต") - 1 )).   /*ตำบล  /ต. /แขวง*/
              ELSE IF r-index(ns_addr1,"อำเภอ") <> 0 THEN                                     
                  ASSIGN                                                                      
                  ns_addr3        = trim(SUBSTR(ns_addr1,r-index(ns_addr1,"อำเภอ")))          /*อำเภอ /อ./เขต */
                  ns_addr1        = trim(SUBSTR(ns_addr1,1, r-index(ns_addr1,"อำเภอ") - 1 )). /*ตำบล  /ต. /แขวง*/
              ELSE IF r-index(ns_addr1,"อ.") <> 0 THEN                                        
                  ASSIGN                                                                      
                  ns_addr3        = trim(SUBSTR(ns_addr1,r-index(ns_addr1,"อ.")))             /*อำเภอ /อ./เขต */
                  ns_addr1        = trim(SUBSTR(ns_addr1,1, r-index(ns_addr1,"อ.") - 1 )).    /*ตำบล  /ต. /แขวง*/
              /* แขวง/ตำบล/ต./แขวง */
              IF r-index(ns_addr1,"แขวง/ตำบล") <> 0 THEN
                  ASSIGN 
                  ns_addr2        = trim(SUBSTR(ns_addr1,r-index(ns_addr1,"แขวง/ตำบล")))            /*อำเภอ /อ./เขต */
                  ns_addr2        = "ตำบล" + trim(REPLACE(ns_addr2,"แขวง/ตำบล"," "))
                  ns_addr1        = trim(SUBSTR(ns_addr1,1, r-index(ns_addr1,"แขวง/ตำบล") - 1 )).   /*ตำบล  /ต. /แขวง*/
              ELSE IF r-index(ns_addr1,"แขวง") <> 0 THEN
                  ASSIGN 
                  ns_addr2        = trim(SUBSTR(ns_addr1,r-index(ns_addr1,"แขวง")))            /*อำเภอ /อ./เขต */
                  ns_addr1        = trim(SUBSTR(ns_addr1,1, r-index(ns_addr1,"แขวง") - 1 )).   /*ตำบล  /ต. /แขวง*/
              ELSE IF r-index(ns_addr1,"ตำบล") <> 0 THEN                                     
                  ASSIGN                                                                      
                  ns_addr2        = trim(SUBSTR(ns_addr1,r-index(ns_addr1,"ตำบล")))          /*อำเภอ /อ./เขต */
                  ns_addr1        = trim(SUBSTR(ns_addr1,1, r-index(ns_addr1,"ตำบล") - 1 )). /*ตำบล  /ต. /แขวง*/
              ELSE IF r-index(ns_addr1,"ต.") <> 0 THEN                                        
                  ASSIGN                                                                      
                  ns_addr2        = trim(SUBSTR(ns_addr1,r-index(ns_addr1,"ต.")))             /*อำเภอ /อ./เขต */
                  ns_addr1        = trim(SUBSTR(ns_addr1,1, r-index(ns_addr1,"ต.") - 1 )).    /*ตำบล  /ต. /แขวง*/
              DO WHILE INDEX(ns_addr1,"  ") <> 0 :
                  ASSIGN ns_addr1 = REPLACE(ns_addr1,"  "," ").
              END.
              IF LENGTH(ns_addr1) > 35 THEN DO:
                  loop_add01:
                  DO WHILE LENGTH(ns_addr1) > 35 :
                      IF R-INDEX(ns_addr1," ") <> 0 THEN DO:
                          ASSIGN 
                              ns_addr2  = trim(SUBSTR(ns_addr1,r-INDEX(ns_addr1," "))) + " " + ns_addr2
                              ns_addr1  = trim(SUBSTR(ns_addr1,1,r-INDEX(ns_addr1," "))).
                      END.
                      ELSE LEAVE loop_add01.
                  END.
                  IF LENGTH(ns_addr2) > 35 THEN DO:
                      loop_add02:
                      DO WHILE LENGTH(ns_addr2) > 35 :
                          IF R-INDEX(ns_addr2," ") <> 0 THEN DO:
                              ASSIGN 
                                  ns_addr3   = trim(SUBSTR(ns_addr2,r-INDEX(ns_addr2," "))) + " " + ns_addr3
                                  ns_addr2   = trim(SUBSTR(ns_addr2,1,r-INDEX(ns_addr2," "))).
                          END.
                          ELSE LEAVE loop_add02.
                      END.
                  END.
                  IF LENGTH(ns_addr2 + " " + ns_addr3) <= 35 THEN
                      ASSIGN 
                      ns_addr2  = ns_addr2 + " " + ns_addr3
                      ns_addr3  = ns_addr4 
                      ns_addr4  = "".
                  ELSE IF LENGTH(ns_addr3 + " " + ns_addr4 ) <= 35 THEN
                      ASSIGN 
                      ns_addr3  = ns_addr3 + " " + ns_addr4
                      ns_addr4  = "".
              END.
              ELSE DO:
                  IF LENGTH(ns_addr2 + " " + ns_addr3) <= 35 THEN
                      ASSIGN 
                      ns_addr2  = ns_addr2 + " " + ns_addr3
                      ns_addr3  = ns_addr4 
                      ns_addr4  = "".
                  ELSE IF LENGTH(ns_addr3 + " " + ns_addr4 ) <= 35 THEN
                      ASSIGN 
                      ns_addr3  = ns_addr3 + " " + ns_addr4 
                      ns_addr4  = "".
              
              END.

              ASSIGN 
                  ns_addr2  = trim(trim(ns_addr2) + " " + trim(ns_addr3)) 
                  ns_addr3  = trim(ns_addr4)
                  ns_addr2  = trim(trim(ns_addr2) + " " + trim(ns_addr3)) 
                  ns_addr3  = ""
                  ns_addr4  = "".
              IF ( INDEX(ns_addr2,"เขต") <> 0 ) OR (INDEX(ns_addr2,"อำเภอ") <> 0 ) THEN DO:
                  IF INDEX(ns_addr2,"เขต") <> 0  THEN DO:
                      ASSIGN 
                          ns_addr3  = trim(SUBSTR(ns_addr2,INDEX(ns_addr2,"เขต")))
                          ns_addr2  = trim(SUBSTR(ns_addr2,1,INDEX(ns_addr2,"เขต") - 1 )).
                      IF INDEX(ns_addr3," ") <> 0 THEN  /*อำเภอองครักษ์ นครนายก 26120 */
                          ASSIGN 
                          ns_addr2  = ns_addr2 + " " + trim(SUBSTR(ns_addr3,1,INDEX(ns_addr3," ")))
                          ns_addr3  = trim(SUBSTR(ns_addr3,INDEX(ns_addr3," "))).
                  END.
                  ELSE IF INDEX(ns_addr2,"อำเภอ") <> 0  THEN DO:
                      ASSIGN 
                      ns_addr3  = trim(SUBSTR(ns_addr2,INDEX(ns_addr2,"อำเภอ")))
                      ns_addr2  = trim(SUBSTR(ns_addr2,1,INDEX(ns_addr2,"อำเภอ") - 1 )).
                      IF INDEX(ns_addr3," ") <> 0 THEN 
                          ASSIGN 
                          ns_addr2  = ns_addr2 + " " + trim(SUBSTR(ns_addr3,1,INDEX(ns_addr3," ")))
                          ns_addr3  = trim(SUBSTR(ns_addr3,INDEX(ns_addr3," "))).
                  END.
              END.
              ASSIGN  
                  workf_out.addr1 = ns_addr1
                  workf_out.addr2 = ns_addr2 
                  workf_out.addr3 = ns_addr3 
                  workf_out.addr4 =  "" .
              /**end. of address */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cutcha_no C-Win 
PROCEDURE proc_cutcha_no :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_i AS INT.
DEF VAR nv_c AS CHAR.
DEF VAR nv_l AS INT.
DEF VAR nv_p AS CHAR.
DEF VAR ind AS INT.
nv_c = workf_out.cha_no.
nv_i = 0.
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

    ind = INDEX(nv_c," ").
    IF ind <> 0 THEN DO:
        nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
    END.
    ind = INDEX(nv_c,".").
    IF ind <> 0 THEN DO:
        nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
    END.
    nv_i = nv_i + 1.
END.
ASSIGN
    workf_out.cha_no = nv_c .
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cutengno C-Win 
PROCEDURE proc_cutengno :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_i AS INT.
DEF VAR nv_c AS CHAR.
DEF VAR nv_l AS INT.
DEF VAR nv_p AS CHAR.
DEF VAR ind AS INT.
nv_c = workf_out.engno.
nv_i = 0.
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

    ind = INDEX(nv_c," ").
    IF ind <> 0 THEN DO:
        nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
    END.
    ind = INDEX(nv_c,".").
    IF ind <> 0 THEN DO:
        nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
    END.
    nv_i = nv_i + 1.
END.
ASSIGN
    workf_out.engno = nv_c .
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_outputfile C-Win 
PROCEDURE proc_outputfile :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

ASSIGN 
nv_output = fi_outfile.
OUTPUT TO VALUE(nv_output).   /*out put file full policy */
EXPORT DELIMITER "|"  
    "Entry date "
    "Entry time "
    "Trans Date "
    "Trans Time "
    "Policy Type        "
    "Policy     "
    "Renew Policy       "
    "Comm Date  "
    "Expiry date        "
    "Compulsory "
    "Title name "
    "Insured name       "
    "Ins addr1  "
    "Ins addr2  "
    "Ins addr3  "
    "Ins addr4  "
    "Premium Package    "
    "Sub Class  "
    "Brand      "
    "Mode       "
    "Cc "
    "Weight     "
    "Seat       "
    "Body       "
    "Vehicle registration       "
    "Engine no  "
    "Chassis no "
    "Car Year   "
    "Car Province       "
    "Vehicle Use        "
    "Garage     "
    "Sticker no "
    "Accessories        "
    "Cover Type "
    "Sum Insured        "
    "Voluntory Premium  "
    "Compulsory Prem    "
    "Fleet %    "
    "NCB %      "
    "Load Claim "
    "Deduct DA  "
    "Deduct PD  "
    "Benificiary        "
    "User id    "
    "Import     "
    "Export     "
    "Drive name "
    "Driver name1       "
    "Driver name2       "
    "Driver Birthdate1  "
    "Driver Birthdate2  "
    "Driver age1        "
    "Driver age2        "
    "Cancel     "
    "Producer   "
    "Agent      "
    "Code Red Book      "
    "Note       "
    "ATTACH_NOTE        "
    "IDENT_CARD "
    "BUSINESS REGISTRATION      "
    "base       "
    "campaign   "
    "QNONumber"
    "Address_rep        "
    "Company_Old        "
    "Insp_name  "
    "Insp_Tel   "
    "remark"
    "AgentReq/ผู้แจ้ง   "
    "AgentCd_รหัส       "
    "ReqDate_วันที่แจ้ง "
    "Memoby_ผู้ตรวจ     " . 

FOR EACH workf_out NO-LOCK 
    WHERE workf_out.insname  <> "" .
     /*BREAK BY  workf_out.QNONumber .*/
    EXPORT DELIMITER "|" 
        
        ""
        ""
        ""
        ""
        "70"
        ""
        workf_out.prevpol
        workf_out.comdat 
        workf_out.expdat 
        "n"
        workf_out.ntitle  
        workf_out.insname 
        workf_out.addr1   
        workf_out.addr2   
        workf_out.addr3   
        workf_out.addr4   
        ""
        workf_out.subclass
        workf_out.brand   
        workf_out.model   
        workf_out.eng_cc  
        workf_out.tons    
        workf_out.Seat    
        workf_out.body    
        workf_out.vehreg  
        workf_out.engno
        workf_out.cha_no 
        workf_out.caryear
        ""
        workf_out.vehuse 
        workf_out.garage 
        ""
        ""
        workf_out.covcod 
        workf_out.sumins 
        workf_out.netprem
        workf_out.comprem
        ""
        ""
        ""
        ""
        ""
        workf_out.bennames
        ""
        ""
        ""
        workf_out.drino     
        workf_out.driver1   
        workf_out.dribirth1 
        workf_out.driver2   
        workf_out.dribirth2 
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        workf_out.icno
        ""
        ""
        ""
        workf_out.QNONumber
        workf_out.addr_rep  
        workf_out.companyold
        workf_out.InspNm    
        workf_out.Inspmobile
        workf_out.remark  
        workf_out.AgentReq
        workf_out.AgentCd 
        workf_out.ReqDate 
        workf_out.Memoby  . 
END.
MESSAGE "Export data complete " VIEW-AS ALERT-BOX.    

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_process C-Win 
PROCEDURE proc_process :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN 
    nv_column = 0
    nv_daily = "".
FOR EACH workf_out.
    DELETE workf_out.
END.
INPUT STREAM nfile FROM  VALUE(fi_filename) .

    loop_source:

    DO WHILE LASTKEY <> -2:

      READKEY STREAM nfile.

      nv_chr = chr(LASTKEY).

      IF LASTKEY = 13 THEN DO:
        /*
        IF SUBSTR(nv_daily,  1,  2) = "01" OR /*1  RECORID "02"*/
           SUBSTR(nv_daily,  1,  2) = "09"
        THEN DO:
          nv_daily = "".
          NEXT loop_source.
        END.
        -*/
        /*DISPLAY nv_daily FORMAT "X(76)".
        PAUSE .*/
        /*assign */
          nv_daily2 = "".
          IF nv_L11Cur = YES THEN DO:
              nv_column = nv_column + 1.
          END.
          ELSE DO: 
              CREATE workf_out.
              nv_column = nv_column + 1.
              nv_L11Cur = YES.
          END.
          IF nv_column = 1 THEN DO: 
              IF INDEX(nv_daily,"RK  Broker")         <> 0 THEN workf_out.company       = STRING(nv_column) + TRIM(nv_daily).
          END.
          ELSE IF nv_column = 2 THEN DO: 
              IF INDEX(nv_daily," T.")                <> 0 THEN workf_out.company2      = STRING(nv_column) + TRIM(nv_daily).
          END.
          /*ELSE IF nv_column = 3 THEN DO: 
              IF INDEX(nv_daily,"ใบแจ้งงาน")          <> 0 THEN workf_out.notify        = STRING(nv_column) + TRIM(nv_daily).
          END. 
          ELSE IF nv_column = 5 THEN DO: 
              IF INDEX(nv_daily,"Date:")              <> 0 THEN workf_out.senddat       = STRING(nv_column) + TRIM(nv_daily). 
          END.*/
          /*ELSE IF nv_column = 6 THEN DO: 
              IF INDEX(nv_daily,"Attn:")              <> 0 THEN workf_out.Attn          = STRING(nv_column) + TRIM(nv_daily).    
          END.*/
          /*ELSE IF nv_column = 7 THEN DO: 
              IF INDEX(nv_daily,"Fax.")               <> 0 THEN workf_out.fax           = STRING(nv_column) + TRIM(nv_daily).    
          END.*/
          ELSE IF nv_column = 8 THEN DO: 
              IF INDEX(nv_daily,"From:")              <> 0 THEN DO:
                  IF r-INDEX(TRIM(nv_daily),"Fax.") <> 0 THEN 
                      ASSIGN 
                      nv_daily2 = trim(SUBSTR(nv_daily,r-INDEX(TRIM(nv_daily),"Fax."))) 
                      nv_daily  = trim(SUBSTR(nv_daily,1, r-INDEX(TRIM(nv_daily),"Fax.") - 1 )) + " " + nv_daily2 .
                  IF r-INDEX(TRIM(nv_daily),"Tel.") <> 0 THEN 
                      ASSIGN 
                      nv_daily2 = trim(SUBSTR(nv_daily,r-INDEX(TRIM(nv_daily),"Tel."))) 
                      nv_daily  = trim(SUBSTR(nv_daily,1, r-INDEX(TRIM(nv_daily),"Tel.") - 1 )) + " " + nv_daily2 .
                  IF INDEX(TRIM(nv_daily),"From:") <> 0 THEN 
                      ASSIGN 
                      nv_daily2 = trim(SUBSTR(nv_daily,INDEX(TRIM(nv_daily),"From:") + 5 )) 
                      nv_daily  = trim(SUBSTR(nv_daily,1,5)) + " " + nv_daily2 .
                  IF r-INDEX(TRIM(nv_daily),"/ ผู้พิมพ์") <> 0 THEN 
                      ASSIGN 
                      nv_daily2 = trim(SUBSTR(nv_daily,INDEX(TRIM(nv_daily),"/ ผู้พิมพ์") + 10 )) 
                      nv_daily  = trim(SUBSTR(nv_daily,1,INDEX(TRIM(nv_daily),"/ ผู้พิมพ์") - 10 )) + " " + nv_daily2 .
                  /*ASSIGN workf_out.Fromkey       = STRING(nv_column) + TRIM(nv_daily).*/
              END.
          END.
          ELSE IF nv_column = 9 THEN DO: 
              IF INDEX(nv_daily,"บริษัท")             <> 0 THEN DO:
                  IF R-INDEX(nv_daily,"จำกัด") <> 0 THEN  
                      ASSIGN 
                      nv_daily2 = trim(SUBSTR(nv_daily,R-INDEX(nv_daily,"จำกัด")))
                      nv_daily  = trim(SUBSTR(nv_daily,1,R-INDEX(nv_daily,"จำกัด") - 1)) .

                  ASSIGN workf_out.company3      = STRING(nv_column) + TRIM(nv_daily)  + " " + TRIM(nv_daily2).
              END.
          END.
          ELSE IF nv_column = 11 THEN DO: 
              IF INDEX(nv_daily,"ทำประกันภัยประเภท")  <> 0 THEN DO:
                  ASSIGN 
                      nv_daily2        = trim(REPLACE(nv_daily,"ทำประกันภัยประเภท",""))  
                      workf_out.remark = TRIM(nv_daily2)
                      workf_out.covcod = trim(replace(nv_daily2,"+พรบ","")).
              END.
          END.
          ELSE IF nv_column = 13 THEN DO: 
              IF INDEX(nv_daily,"ชื่อลูกค้า")     <> 0 THEN DO: 
                  ASSIGN 
                      nv_daily2 = trim(REPLACE(nv_daily,"ชื่อลูกค้า","")) .
                  FIND FIRST brstat.msgcode WHERE brstat.msgcode.compno = "999" AND
                      index(trim(nv_daily2),brstat.msgcode.MsgDesc) > 0    NO-LOCK NO-ERROR NO-WAIT.
                  IF AVAIL brstat.msgcode THEN  
                      ASSIGN  
                      workf_out.insname  = trim(SUBSTR(nv_daily2,LENGTH(brstat.msgcode.MsgDesc) + 1)) 
                      workf_out.ntitle   = trim(brstat.msgcode.branch)  .
                  ELSE ASSIGN 
                      workf_out.insname  = nv_daily2
                      workf_out.ntitle   = "คุณ"  .
              END.
          END.
          ELSE IF nv_column = 16 THEN DO: 
              IF nv_addrst = YES THEN 
                  ASSIGN workf_out.addr1  = trim(workf_out.addr1 + " " +   TRIM(nv_daily))  
                  nv_addrst = NO.
          END.
          ELSE IF nv_column = 15 THEN DO: 
              IF INDEX(nv_daily,"ที่อยู่")            <> 0 THEN 
                  ASSIGN 
                  nv_daily2       = trim(REPLACE(nv_daily,"ที่อยู่",""))  
                  workf_out.addr1 = nv_daily2  
                  nv_addrst = YES.
          END.
          ELSE IF nv_column = 17 THEN DO:
              RUN proc_address.
          END.
          ELSE IF nv_column = 18 THEN DO: 
              IF INDEX(nv_daily,"ยี่ห้อ/รุ่น/ปี")     <> 0 THEN DO: 
                  ASSIGN 
                      nv_daily2 = REPLACE(nv_daily,"ยี่ห้อ/รุ่น/ปี","").
                  IF r-INDEX(nv_daily2,"ขนาด") <> 0 THEN
                      ASSIGN 
                      workf_out.eng_cc  = trim(SUBSTR(nv_daily2,INDEX(nv_daily2,"ขนาด")))
                      workf_out.eng_cc  = TRIM(REPLACE(workf_out.eng_cc,"ขนาด",""))
                      workf_out.eng_cc  = TRIM(REPLACE(workf_out.eng_cc,"ซีซี",""))
                      nv_daily2         = trim(SUBSTR(nv_daily2,1,INDEX(nv_daily2,"ขนาด") - 1 )).
                  IF r-INDEX(nv_daily2,"ปี") <> 0 THEN
                      ASSIGN 
                      workf_out.caryear = trim(SUBSTR(nv_daily2,INDEX(nv_daily2,"ปี") + 2 ))
                      nv_daily2         = trim(SUBSTR(nv_daily2,1,INDEX(nv_daily2,"ปี") - 1 )).
                  IF INDEX(nv_daily2," ") <> 0 THEN
                      ASSIGN 
                      workf_out.model   = trim(SUBSTR(nv_daily2,INDEX(nv_daily2," ")))
                      workf_out.brand   = trim(SUBSTR(nv_daily2,1,INDEX(nv_daily2," "))).
                  ELSE workf_out.brand   = trim(nv_daily2).
              END.
          END.
          ELSE IF nv_column = 20 THEN DO: 
              IF INDEX(nv_daily,"ทะเบียน")            <> 0 THEN workf_out.vehreg = trim(replace(nv_daily,"ทะเบียน","")).
          END.
          ELSE IF nv_column = 22 THEN DO: 
              IF INDEX(nv_daily,"เลขตัวถัง")          <> 0 THEN workf_out.cha_no = TRIM(replace(nv_daily,"เลขตัวถัง","")).
              RUN proc_cutcha_no.
          END.
          ELSE IF nv_column = 24 THEN DO: 
              IF INDEX(nv_daily,"เลขเครื่อง")         <> 0 THEN workf_out.engno =  TRIM(replace(nv_daily,"เลขเครื่อง","")).
              RUN proc_cutengno.
          END.
          ELSE IF nv_column = 26 THEN DO: 
              IF INDEX(nv_daily,"ทุน")                <> 0 THEN DO:
                  ASSIGN  nv_daily2 = REPLACE(nv_daily,"ทุน","").
                  IF r-INDEX(nv_daily2,"Q") <> 0 THEN 
                      ASSIGN 
                      workf_out.QNONumber = trim(SUBSTR(nv_daily2,INDEX(nv_daily2,"Q")))
                      nv_daily2           = trim(SUBSTR(nv_daily2,1,INDEX(nv_daily2,"Q") - 1 )).
                  IF r-INDEX(nv_daily2,"เบี้ยรวมอากร") <> 0 THEN 
                      ASSIGN 
                      workf_out.netprem   = trim(SUBSTR(nv_daily2,INDEX(nv_daily2,"เบี้ยรวมอากร")))
                      workf_out.netprem   = TRIM(REPLACE(workf_out.netprem,"เบี้ยรวมอากร",""))
                      workf_out.netprem   = TRIM(REPLACE(workf_out.netprem,"บาท",""))
                      nv_daily2           = trim(SUBSTR(nv_daily2,1,INDEX(nv_daily2,"เบี้ยรวมอากร") - 1 )).
                  ASSIGN 
                      nv_daily2         = trim(replace(nv_daily2,"บาท",""))
                      workf_out.sumins  = nv_daily2.
              END.
          END.
          ELSE IF nv_column = 27 THEN DO: 
              IF INDEX(nv_daily,"เบี้ยรวมพรบ.")       <> 0 THEN 
                  ASSIGN 
                  nv_daily2          = trim(REPLACE(nv_daily,"เบี้ยรวมพรบ.",""))
                  workf_out.comprem  = trim(REPLACE(nv_daily2,"บาท","")) .
          END.
          /*ELSE IF nv_column = 28 THEN DO: 
              IF INDEX(nv_daily,"พรบ")                <> 0 THEN 
                  workf_out.remark  = workf_out.remark + " " + TRIM(nv_daily).
                  /*workf_out.compul        = STRING(nv_column) +  TRIM(nv_daily).*/
          END.*/
          ELSE IF nv_column = 30 THEN DO: 
              IF INDEX(nv_daily,"สิ้นสุด")      <> 0 THEN 
                  ASSIGN 
                  nv_daily2             = TRIM(substr(nv_daily,INDEX(nv_daily,"สิ้นสุด")))
                  nv_daily              = TRIM(substr(nv_daily,1,INDEX(nv_daily,"สิ้นสุด") - 1 ))
                  workf_out.expdat      = TRIM(REPLACE(nv_daily2,"สิ้นสุด",""))
                  workf_out.expdat      = STRING(day(date(workf_out.expdat)),"99") + "/" +
                                          STRING(MONTH(date(workf_out.expdat)),"99") + "/" +
                                          STRING(YEAR(date(workf_out.expdat)) - 543 ,"9999") .

              IF INDEX(nv_daily,"เริ่มคุ้มครอง")      <> 0 THEN 
                  ASSIGN 
                  workf_out.comdat      = TRIM(replace(nv_daily,"เริ่มคุ้มครอง",""))
                  workf_out.comdat      = STRING(day(date(workf_out.comdat)),"99") + "/" +
                                          STRING(MONTH(date(workf_out.comdat)),"99") + "/" +
                                          STRING(YEAR(date(workf_out.comdat)) - 543 ,"9999") .
                  . 
          END.
          ELSE IF nv_column = 32 THEN DO: 
              IF INDEX(nv_daily,"เบอร์ตรวจรถ คุณ")    <> 0 THEN 
                  workf_out.InspNm        = TRIM(replace(nv_daily,"เบอร์ตรวจรถ คุณ","")).
          END.
          ELSE IF nv_column = 34 THEN DO: 
              IF INDEX(nv_daily,"ผู้รับผลประโยชน์")   <> 0 THEN 
                  workf_out.bennames       =  TRIM(replace(nv_daily,"ผู้รับผลประโยชน์","")).
          END. 
          ELSE IF (nv_column >= 36) AND (nv_column <= 40) THEN DO: 
              IF INDEX(nv_daily,"หมายเหตุ :")         <> 0 THEN workf_out.remark   = trim(workf_out.remark  + " " + TRIM(nv_daily)).
          END.
          ELSE IF (nv_column = 41) THEN DO: 
              IF INDEX(nv_daily,"เลขกรมธรรม์เดิม")    <> 0 THEN workf_out.prevpol  =   TRIM(replace(nv_daily,"เลขกรมธรรม์เดิม","")).
          END.
          ELSE IF (nv_column = 43)  THEN DO: 
              IF INDEX(nv_daily,"งานของ")             <> 0 THEN 
                  ASSIGN workf_out.AgentReq       = TRIM(replace(nv_daily,"งานของ",""))
                  nv_column = 0
                  nv_L11Cur = NO.           
          END.
        nv_daily = "".
        NEXT loop_source.
      END.
      nv_daily = nv_daily + nv_chr.
    END.
    INPUT STREAM nfile CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

