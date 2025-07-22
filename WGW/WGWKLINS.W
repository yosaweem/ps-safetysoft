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

/* ***************************  Definitions  **************************      */
                                                                             
/* Parameters Definitions ---                                                */
/* Local Variable Definitions ---                                            */
/*Program ID    : wgwklins.w                                                 */    
/*Program name : Export Data Inspection K-Leasing                            */
/*create by    : Ranu i. A61-0269  date 12/06/2018                           */
/*              เรียกรายงานการตรวจสภาพของ K-leasign                          */
/*DataBase connect : GW_SAFE -LD SIC_BRAN, GW_STAT -LD BRSTAT,SICSYAC,SICUW */
/*-------------------------------------------------------------------------*/
DEF VAR gv_id  AS CHAR FORMAT "X(12)" NO-UNDO.  
DEF VAR n_user  AS CHAR FORMAT "X(12)" NO-UNDO. 
DEF VAR nv_pwd AS CHAR FORMAT "x(15)" NO-UNDO.  
DEF  stream ns1.

DEFINE NEW SHARED TEMP-TABLE winsp NO-UNDO
    FIELD Comdat          AS CHAR FORMAT "x(15)"    INIT ""
    FIELD expdat          AS CHAR FORMAT "x(15)"    INIT ""
    FIELD branch          AS CHAR FORMAT "x(40)"    INIT ""
    FIELD policy          AS CHAR FORMAT "X(13)"    INIT ""  
    FIELD Custitle        AS CHAR FORMAT "X(50)"    INIT ""  
    FIELD cusName         AS CHAR FORMAT "X(50)"    INIT ""  
    FIELD telno           AS CHAR FORMAT "x(50)"    INIT "" 
    FIELD agentcode       AS CHAR FORMAT "X(15)"    INIT ""
    FIELD Brand           AS CHAR FORMAT "x(50)"    INIT ""
    FIELD model           AS CHAR FORMAT "x(50)"    INIT ""
    FIELD caryear         AS CHAR FORMAT "x(5)"     INIT ""
    FIELD Licence         AS CHAR FORMAT "X(50)"    INIT ""  
    FIELD Chassis         AS CHAR FORMAT "X(20)"    INIT ""  
    FIELD Insp_date       AS CHAR FORMAT "X(15)"    INIT ""  
    FIELD Insp_close      AS CHAR FORMAT "X(15)"    INIT "" 
    FIELD insp_no         AS CHAR FORMAT "x(20)"    INIT ""
    FIELD Insp_Detail     AS CHAR FORMAT "X(700)"   INIT ""  
    FIELD Insp_Remark1    AS CHAR FORMAT "X(700)"   INIT ""  
    FIELD Insp_Remark2    AS CHAR FORMAT "X(700)"   INIT ""
    FIELD insp_status     AS CHAR FORMAT "x(10)"    INIT "" 
    FIELD insp_damage     as CHAR format "x(1000)"  INIT ""
    FIELD insp_driver     as CHAR format "x(500)"   INIT ""
    FIELD Insp_other      as CHAR format "x(500)"   INIT "".     

Def  Var chNotesSession  As Com-Handle.
Def  Var chNotesDataBase As Com-Handle.
Def  Var chDocument      As Com-Handle.
Def  Var chNotesView     As Com-Handle .
Def  Var chNavView       As Com-Handle .
Def  Var chViewEntry     As Com-Handle .
Def  Var chItem          As Com-Handle .
Def  Var chData          As Com-Handle .
Def  Var nv_server       As Char.
Def  Var nv_tmp          As char .
DEF VAR nv_year          AS CHAR FORMAT "x(5)" .
DEF VAR nv_docno         AS CHAR FORMAT "x(25)".
DEF VAR nv_survey        AS CHAR FORMAT "x(25)".
DEF VAR nv_detail        AS CHAR FORMAT "x(30)".
DEF VAR nv_remark1       AS CHAR FORMAT "x(250)".
DEF VAR nv_remark2       AS CHAR FORMAT "x(250)".
DEF VAR nv_damlist       AS CHAR FORMAT "x(150)" INIT "" .
DEF VAR nv_damage        AS CHAR FORMAT "x(250)" INIT "" .
DEF VAR nv_totaldam      AS CHAR FORMAT "X(150)" .
DEF VAR nv_attfile       AS CHAR FORMAT "x(100)" INIT "" .
DEF VAR nv_device        AS CHAR FORMAT "x(500)" INIT "".
Def var nv_acc1          as char format "x(50)".   
Def var nv_acc2          as char format "x(50)".   
Def var nv_acc3          as char format "x(50)".   
Def var nv_acc4          as char format "x(50)".   
Def var nv_acc5          as char format "x(50)".   
Def var nv_acc6          as char format "x(50)".   
Def var nv_acc7          as char format "x(50)".   
Def var nv_acc8          as char format "x(50)".   
Def var nv_acc9          as char format "x(50)".   
Def var nv_acc10         as char format "x(50)".   
Def var nv_acc11         as char format "x(50)".   
Def var nv_acc12         as char format "x(50)".   
Def var nv_acctotal      as char format "x(250)".   
DEF VAR nv_surdata       AS CHAR FORMAT "x(250)".
DEF VAR nv_date          AS CHAR FORMAT "x(15)".

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_outfile bu_ok bu_exit-2 fi_year ~
fi_filename bu_file RECT-381 RECT-382 RECT-383 
&Scoped-Define DISPLAYED-OBJECTS fi_outfile fi_year fi_filename 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_exit-2 
     LABEL "Exit" 
     SIZE 7.5 BY 1.05
     FONT 6.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 3.5 BY 1.

DEFINE BUTTON bu_ok 
     LABEL "OK" 
     SIZE 7.5 BY 1.05
     FONT 6.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_outfile AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_year AS CHARACTER FORMAT "X(5)":U 
     VIEW-AS FILL-IN 
     SIZE 15.5 BY 1
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-381
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 105 BY 7.24
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-382
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10 BY 2
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-383
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10 BY 2
     BGCOLOR 2 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_outfile AT ROW 6.19 COL 28.83 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 8.38 COL 82.5
     bu_exit-2 AT ROW 8.38 COL 92.67
     fi_year AT ROW 3.91 COL 29 COLON-ALIGNED NO-LABEL
     fi_filename AT ROW 5 COL 29 COLON-ALIGNED NO-LABEL WIDGET-ID 2
     bu_file AT ROW 5.05 COL 91.5 WIDGET-ID 6
     "OUTPUT FILE :" VIEW-AS TEXT
          SIZE 15.33 BY 1 AT ROW 6.14 COL 14.83
          BGCOLOR 8 FGCOLOR 2 FONT 6
     " Export Data Inspection K-Leasing" VIEW-AS TEXT
          SIZE 105 BY 2.14 AT ROW 1.1 COL 1.17
          FGCOLOR 7 FONT 2
     "**ใช้ไฟล์นำเข้าข้อมูลกล่องตรวจสภาพเป็นไฟล์แมทหาข้อมูล**" VIEW-AS TEXT
          SIZE 46.5 BY 1 AT ROW 7.43 COL 31.5 WIDGET-ID 8
          BGCOLOR 8 FGCOLOR 12 FONT 1
     "INPUT FILE :" VIEW-AS TEXT
          SIZE 15.33 BY 1 AT ROW 4.95 COL 15 WIDGET-ID 4
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "INSPECTION YEAR :" VIEW-AS TEXT
          SIZE 21 BY 1 AT ROW 3.86 COL 10
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "** ปีของกล่องตรวจสภาพ**" VIEW-AS TEXT
          SIZE 21.17 BY 1 AT ROW 3.86 COL 49.5
          BGCOLOR 8 FGCOLOR 12 FONT 1
     RECT-381 AT ROW 3.14 COL 1.5
     RECT-382 AT ROW 7.95 COL 91.33
     RECT-383 AT ROW 7.95 COL 81.33
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 105.5 BY 9.67
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
         TITLE              = "Export Data Inspection KL"
         HEIGHT             = 9.62
         WIDTH              = 105.67
         MAX-HEIGHT         = 29.81
         MAX-WIDTH          = 123.67
         VIRTUAL-HEIGHT     = 29.81
         VIRTUAL-WIDTH      = 123.67
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
ASSIGN 
       bu_file:AUTO-RESIZE IN FRAME fr_main      = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Export Data Inspection KL */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Export Data Inspection KL */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit-2 C-Win
ON CHOOSE OF bu_exit-2 IN FRAME fr_main /* Exit */
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
    DEF VAR nv_text AS CHAR FORMAT "x(50)".
    DEFINE VARIABLE cvData    AS CHARACTER NO-UNDO.
    DEFINE VARIABLE OKpressed AS LOGICAL INITIAL TRUE.

    SYSTEM-DIALOG GET-FILE cvData
        TITLE      "Choose Data File to Import ..."
        FILTERS    "File CSV" "*.CSV"

        MUST-EXIST
        USE-FILENAME
        UPDATE OKpressed.

   IF OKpressed = TRUE THEN DO:
       fi_filename  = cvData.
       /* start : A59-0029*/
    
        ASSIGN
        nv_text     = trim(REPLACE(fi_filename,".CSV",""))
       /* nv_text     = IF LENGTH(nv_text) > 35 THEN SUBSTR(nv_text,1,35) ELSE nv_text*/
        fi_outfile  = nv_text + "_inspec" +  
                      STRING(MONTH(TODAY),"99")    +     
                      STRING(DAY(TODAY),"99")      + 
                      SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                      SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + ".slk".
      

       DISP fi_filename fi_outfile WITH FRAME fr_main.    
      /* end : A59-0029*/
   END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok C-Win
ON CHOOSE OF bu_ok IN FRAME fr_main /* OK */
DO:
    FOR EACH winsp :
        DELETE winsp.
    END.

    IF fi_filename = "" THEN DO:
        MESSAGE "Input file not Empty..!!!" VIEW-AS ALERT-BOX.
        APPLY "Entry" TO fi_filename.
        RETURN NO-APPLY.
    END.
    IF fi_outfile = "" THEN DO:
        MESSAGE "Output file not Empty..!!!"  VIEW-AS ALERT-BOX.
        APPLY "Entry" TO fi_outfile.
        RETURN NO-APPLY.
    END.
    ELSE DO:
        INPUT FROM VALUE(fi_FileName).
        REPEAT:
         CREATE winsp .
         IMPORT DELIMITER "|"
            winsp.Comdat      
            winsp.expdat      
            winsp.branch      
            winsp.policy      
            winsp.Custitle    
            winsp.cusName     
            winsp.telno       
            winsp.agentcode   
            winsp.Brand       
            winsp.model       
            winsp.caryear     
            winsp.Licence     
            winsp.Chassis  .
        END.
        RUN proc_chkdata.
    END.
    RELEASE sicuw.uwm301.
    RELEASE sicuw.uwm100.
    
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_filename
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_filename C-Win
ON LEAVE OF fi_filename IN FRAME fr_main
DO:
  fi_filename = INPUT fi_filename.
  DISP fi_filename WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_outfile
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outfile C-Win
ON LEAVE OF fi_outfile IN FRAME fr_main
DO:
  fi_outfile = INPUT fi_outfile.
  DISP fi_outfile WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_year
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_year C-Win
ON LEAVE OF fi_year IN FRAME fr_main
DO:
  fi_year = INPUT fi_year.
  DISP fi_year WITH FRAM fr_main.
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
  ASSIGN 
      gv_prgid          = "WGWKLINS"
      gv_prog           = "Data Inspection K-Leasing "
      fi_year           = STRING(YEAR(TODAY),"9999")
      fi_filename       = ""
      fi_outfile        = "" .
    
  gv_prog  = "Export Data Inspection K-LEASING".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).
  
      DISP fi_year fi_filename fi_outfile WITH FRAM fr_main.
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
  DISPLAY fi_outfile fi_year fi_filename 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_outfile bu_ok bu_exit-2 fi_year fi_filename bu_file RECT-381 
         RECT-382 RECT-383 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkdata C-Win 
PROCEDURE proc_chkdata :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Create by A59-0471     
------------------------------------------------------------------------------*/
DEF VAR nv_Code    as char format "x(2)" INIT "" .
DEF VAR nv_Result  as char format "x(25)" INIT "" .
FOR EACH winsp .
    
    IF index(winsp.comdat,"วันที่") <> 0 THEN DELETE winsp.
    ELSE IF winsp.comdat = ""  THEN DELETE winsp.
    ELSE DO:
        IF winsp.Chassis <> "" THEN RUN proc_datainsp .
    END.
END.
RUN proc_reportinsp.

Message "Export data Complete"  View-as alert-box.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_datainsp C-Win 
PROCEDURE proc_datainsp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 DO:   
    DEF VAR n_list      AS INT init 0.
    DEF VAR n_count     AS INT init 0.
    DEF VAR n_repair    AS CHAR FORMAT "x(10)" init "".
    DEF VAR n_dam       AS CHAR FORMAT "x(10)" init "".
    DEF VAR n_deatil    AS CHAR FORMAT "x(60)" init "".
    DEF VAR nv_damag    AS CHAR FORMAT "x(30)" init "".
    DEF VAR nv_repair   AS CHAR FORMAT "x(30)" init "".
    DEF VAR nv_damdetail AS LONGCHAR  INIT "". 
    DEF VAR n_agent      AS CHAR FORMAT "x(12)" INIT "".
    DEF VAR nv_cretdate  AS CHAR FORMAT "x(15)" INIT "" .
    

     ASSIGN  nv_year     = ""     nv_docno  = ""      nv_survey   = ""    nv_detail  = ""     nv_remark1  = ""     nv_remark2  = ""
             nv_damlist  = ""     nv_damage = ""      nv_totaldam = ""    nv_attfile = ""     nv_device   = ""     nv_acc1     = ""
             nv_acc2     = ""     nv_acc3   = ""      nv_acc4     = ""    nv_acc5    = ""     nv_acc6     = ""     nv_acc7     = ""
             nv_acc8     = ""     nv_acc9   = ""      nv_acc10    = ""    nv_acc11   = ""     nv_acc12    = ""     nv_acctotal = ""
             nv_surdata  = ""     nv_tmp    = ""      nv_date     = ""    n_agent    = ""     nv_cretdate = ""
             nv_year     = TRIM(fi_year)
             nv_tmp      = "Inspect" + SUBSTR(nv_year,3,2) + ".nsf".
    /*--------- Server Real ----------*/
    nv_server = "Safety_NotesServer/Safety".
    nv_tmp   = "safety\uw\" + nv_tmp .
    /*-------------------------------*/
    /*---------- Server test local ------
    nv_server = "".
    nv_tmp    = "U:\Lotus\Notes\Data\ranu\" + nv_tmp .
    -----------------------------*/
    DISP "Check Data Inspection Chassis no." + winsp.chassis + " ......" 
                   WITH COLOR BLACK/WHITE NO-LABEL TITLE "Please Wait...." WIDTH 80 FRAME AA VIEW-AS DIALOG-BOX.

    CREATE "Notes.NotesSession"  chNotesSession.
    chNotesDatabase  = chNotesSession:GetDatabase (nv_server,nv_tmp).

      IF  chNotesDatabase:IsOpen()  = NO  THEN  DO:
         MESSAGE "Can not open database" SKIP  
                 "Please Check database and serve" VIEW-AS  ALERT-BOX ERROR.
      END.
      chNotesView    = chNotesDatabase:GetView("เลขตัวถัง").
      /*chNavView      = chNotesView:CreateViewNav.
      chDocument     = chNotesView:GetDocumentByKey(brstat.tlt.cha_no).*/
      chNavView      = chNotesView:CreateViewNavFromCategory(winsp.Chassis).
      chViewEntry    = chNavView:GetLastDocument.
      chDocument     = chViewEntry:Document. 
      IF VALID-HANDLE(chDocument) = YES THEN DO:

          chitem       = chDocument:Getfirstitem("createdOn").      /*วันที่ปิดเรื่อง*/
          IF chitem <> 0 THEN nv_cretdate = chitem:TEXT. 
          ELSE nv_cretdate = "".

          chitem       = chDocument:Getfirstitem("ConsiderDate").      /*วันที่ปิดเรื่อง*/
          IF chitem <> 0 THEN nv_date = chitem:TEXT. 
          ELSE nv_date = "".

          chitem       = chDocument:Getfirstitem("docno").      /*เลขตรวจสภาพ*/
          IF chitem <> 0 THEN nv_docno = chitem:TEXT. 
          ELSE nv_docno = "".
          
          chitem       = chDocument:Getfirstitem("SurveyClose").    /* สเตตัสปิดเรื่อง */
          IF chitem <> 0 THEN nv_survey  = chitem:TEXT. 
          ELSE nv_survey = "".
          
          chitem       = chDocument:Getfirstitem("SurveyResult").  /*ผลการตรวจ*/
          IF chitem <> 0 THEN  nv_detail = chitem:TEXT. 
          ELSE nv_detail = "".
          
          IF nv_detail = "ติดปัญหา" THEN DO:
              chitem       = chDocument:Getfirstitem("DamageC").    /*ข้อมูลการติดปัญหา */
              IF chitem <> 0 THEN nv_damage    = chitem:TEXT.
              ELSE nv_damage = "".
          END.
          IF nv_detail = "มีความเสียหาย"  THEN DO:
              chitem       = chDocument:Getfirstitem("DamageList").  /* รายการความเสียหาย */
              IF chitem <> 0 THEN nv_damlist  = chitem:TEXT.
              ELSE nv_damlist = "".
              chitem       = chDocument:Getfirstitem("TotalExpensive").  /* ราคาความเสียหาย */
              IF chitem <> 0 THEN nv_totaldam  = chitem:TEXT.
              ELSE nv_totaldam = "".
             
              IF nv_damlist <> "" THEN DO: 
                  ASSIGN n_list     = INT(nv_damlist)
                         nv_damlist = "ความเสียหาย " + nv_damlist + " รายการ " .
              END.
              IF nv_totaldam <> "" THEN ASSIGN nv_totaldam = "ความเสียหายรวม " + nv_totaldam + " บาท " .

              IF n_list > 0  THEN DO:
                ASSIGN  n_count = 1 .
                loop_damage:
                REPEAT:
                    IF n_count <= n_list THEN DO:
                        ASSIGN  n_dam    = "List"   + STRING(n_count) 
                                n_repair = "Repair" + STRING(n_count) .
                        
                        chitem       = chDocument:Getfirstitem(n_dam).
                        IF chitem <> 0 THEN  nv_damag  = chitem:TEXT. 
                        ELSE nv_damag = "".  
                        
                        chitem       = chDocument:Getfirstitem(n_repair).
                        IF chitem <> 0 THEN  nv_repair = chitem:TEXT. 
                        ELSE nv_repair = "".
                            
                        IF nv_damag <> "" THEN  
                            ASSIGN nv_damdetail = nv_damdetail + string(n_count) + "." + nv_damag + " " + nv_repair + " , " .
                            
                        n_count = n_count + 1.
                    END.
                    ELSE LEAVE loop_damage.
                END.
            END.

          END. /* end ความเสียหาย */
          /*-- ข้อมูลอื่น ๆ ---*/
         /* chitem       = chDocument:Getfirstitem("SurveyData").
          IF chitem <> 0 THEN  nv_surdata = chitem:TEXT. 
          ELSE nv_surdata = "".
          IF trim(nv_surdata) <> "" THEN  nv_surdata = "ข้อมูลอื่นๆ :"  +  nv_surdata.
          /*agentCode*/
          chitem       = chDocument:Getfirstitem("agentCode").      
          IF chitem <> 0 THEN n_agent = chitem:TEXT. 
          ELSE n_agent = "".
          IF TRIM(n_agent) <> "" THEN ASSIGN nv_surdata = nv_surdata + " โค้ดตัวแทน: " + n_agent.*/

          /*-- อุปกรณ์เสริม --*/  
          chitem       = chDocument:Getfirstitem("device1").
          IF chitem <> 0 THEN  nv_device = chitem:TEXT. 
          ELSE nv_device = "".

          IF nv_device <> "" THEN DO:
              chitem       = chDocument:Getfirstitem("pricesTotal").  /* ราคารวมอุปกรณ์เสริม */
              IF chitem <> 0 THEN  nv_acctotal = chitem:TEXT. 
              ELSE nv_acctotal = "".
              chitem       = chDocument:Getfirstitem("DType1").
              IF chitem <> 0 THEN  nv_acc1 = chitem:TEXT. 
              ELSE nv_acc1 = "".
              chitem       = chDocument:Getfirstitem("DType2").
              IF chitem <> 0 THEN  nv_acc2 = chitem:TEXT. 
              ELSE nv_acc2 = "".
              chitem       = chDocument:Getfirstitem("DType3").
              IF chitem <> 0 THEN  nv_acc3 = chitem:TEXT. 
              ELSE nv_acc3 = "".
              chitem       = chDocument:Getfirstitem("DType4").
              IF chitem <> 0 THEN  nv_acc4 = chitem:TEXT. 
              ELSE nv_acc4 = "".
              chitem       = chDocument:Getfirstitem("DType5").
              IF chitem <> 0 THEN  nv_acc5 = chitem:TEXT. 
              ELSE nv_acc5 = "".
              chitem       = chDocument:Getfirstitem("DType6").
              IF chitem <> 0 THEN  nv_acc6 = chitem:TEXT. 
              ELSE nv_acc6 = "".
              chitem       = chDocument:Getfirstitem("DType7").
              IF chitem <> 0 THEN  nv_acc7 = chitem:TEXT. 
              ELSE nv_acc7 = "".
              chitem       = chDocument:Getfirstitem("DType8").
              IF chitem <> 0 THEN  nv_acc8 = chitem:TEXT. 
              ELSE nv_acc8 = "".
              chitem       = chDocument:Getfirstitem("DType9").
              IF chitem <> 0 THEN  nv_acc9 = chitem:TEXT. 
              ELSE nv_acc9 = "".
              chitem       = chDocument:Getfirstitem("DType10").
              IF chitem <> 0 THEN  nv_acc10 = chitem:TEXT. 
              ELSE nv_acc10 = "".
              chitem       = chDocument:Getfirstitem("DType11").
              IF chitem <> 0 THEN  nv_acc11 = chitem:TEXT. 
              ELSE nv_acc11 = "".
              chitem       = chDocument:Getfirstitem("DType12").
              IF chitem <> 0 THEN  nv_acc12 = chitem:TEXT. 
              ELSE nv_acc12 = "".
              
              ASSIGN nv_device = "" .
              IF TRIM(nv_acc1)  <> "" THEN nv_device = nv_device + TRIM(nv_acc1).
              IF TRIM(nv_acc2)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc2).
              IF TRIM(nv_acc3)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc3).
              IF TRIM(nv_acc4)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc4).
              IF TRIM(nv_acc5)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc5).
              IF TRIM(nv_acc6)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc6).
              IF TRIM(nv_acc7)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc7).
              IF TRIM(nv_acc8)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc8).
              IF TRIM(nv_acc9)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc9).
              IF TRIM(nv_acc10) <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc10).
              IF TRIM(nv_acc11) <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc11).
              IF TRIM(nv_acc12) <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc12) .
              nv_acctotal = " ราคารวมอุปกรณ์ " + nv_acctotal + " บาท " .
          END.

          IF nv_docno <> ""  THEN DO:

              IF nv_survey <> "" THEN DO:
                    IF nv_detail = "ติดปัญหา" THEN DO:
                        ASSIGN  winsp.insp_close     = IF index(nv_date," ") <> 0 THEN SUBSTR(nv_date,1,INDEX(nv_date," ")) ELSE nv_date
                                winsp.Insp_date      = IF index(nv_cretdate," ") <> 0 THEN SUBSTR(nv_cretdate,1,INDEX(nv_cretdate," ")) ELSE nv_cretdate
                                winsp.Insp_Detail    = nv_detail    /* ผลตรวจสภาพ */ 
                                winsp.Insp_Remark1   = nv_damage   /* เหตุผล */  /*nv_device + nv_acctotal*/
                                winsp.insp_remark2   = "" /*nv_surdata*/
                                winsp.insp_no        = nv_docno                      /*เลขที่ตรวจสภาพ */              
                                /*winsp.insp_damage    = nv_damdetail  */                /*รายการความเสียหาย */           
                                winsp.insp_driver    = nv_device + nv_acctotal  .     /*รายละเอียดอุปกรณ์เสริม */      
                                /*winsp.Insp_other     = nv_surdata. */                   /*รายละเอียดอื่นๆ */
                    END.
                    ELSE IF nv_detail = "มีความเสียหาย"  THEN DO:
                        ASSIGN  winsp.insp_close    = IF index(nv_date," ") <> 0 THEN SUBSTR(nv_date,1,INDEX(nv_date," ")) ELSE nv_date                 
                                winsp.Insp_date     = IF index(nv_cretdate," ") <> 0 THEN SUBSTR(nv_cretdate,1,INDEX(nv_cretdate," ")) ELSE nv_cretdate 
                                winsp.Insp_Detail   = nv_detail  
                                winsp.Insp_Remark1  = nv_damlist + nv_totaldam  /* ความเสียหาย */
                                winsp.insp_remark2  = nv_damdetail          /*nv_device + nv_acctotal + nv_surdata*/
                                winsp.insp_no       = nv_docno                      /*เลขที่ตรวจสภาพ */              
                                /*winsp.insp_damage   = nv_damdetail  */                /*รายการความเสียหาย */           
                                winsp.insp_driver   = nv_device + nv_acctotal   .    /*รายละเอียดอุปกรณ์เสริม */      
                               /* winsp.Insp_other    = nv_surdata  .  */                /*รายละเอียดอื่นๆ */
                    END.
                    ELSE DO: 
                        ASSIGN  winsp.insp_close    = IF index(nv_date," ") <> 0 THEN SUBSTR(nv_date,1,INDEX(nv_date," ")) ELSE nv_date                 
                                winsp.Insp_date     = IF index(nv_cretdate," ") <> 0 THEN SUBSTR(nv_cretdate,1,INDEX(nv_cretdate," ")) ELSE nv_cretdate 
                                winsp.Insp_Detail   = nv_detail
                                winsp.Insp_Remark1  = "" /*nv_device + nv_acctotal*/
                                winsp.insp_remark2  = "" /*nv_surdata*/
                                winsp.insp_no       = nv_docno                      /*เลขที่ตรวจสภาพ */              
                                /*winsp.insp_damage   = ""    */                        /*รายการความเสียหาย */           
                                winsp.insp_driver   = nv_device + nv_acctotal  .     /*รายละเอียดอุปกรณ์เสริม */      
                                /*winsp.Insp_other    = nv_surdata  .  */                /*รายละเอียดอื่นๆ */
                    END.
              END.
              ELSE DO:
                  ASSIGN  winsp.Insp_date    = IF index(nv_cretdate," ") <> 0 THEN SUBSTR(nv_cretdate,1,INDEX(nv_cretdate," ")) ELSE nv_cretdate 
                          winsp.insp_no      = nv_docno
                          winsp.Insp_Detail  = ""
                          /*winsp.insp_damage  = ""   */                        /*รายการความเสียหาย */       
                          winsp.insp_driver  = nv_device + nv_acctotal .     /*รายละเอียดอุปกรณ์เสริม */  
                          /*winsp.Insp_other   = nv_surdata . */                /*รายละเอียดอื่นๆ */   
              END.
          END.

          RELEASE  OBJECT chitem          NO-ERROR.
          RELEASE  OBJECT chDocument      NO-ERROR.          
          RELEASE  OBJECT chNotesDataBase NO-ERROR.     
          RELEASE  OBJECT chNotesSession  NO-ERROR.
      END.
 END.
      

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportinsp C-Win 
PROCEDURE proc_reportinsp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
-----------------------------------------------------------------------------*/
DEF VAR n_pol AS CHAR FORMAT "x(15)" INIT "".
DEF VAR n_recnt AS INT INIT 0.
DEF VAR n_encnt AS INT INIT 0.
DEF VAR n_length1 AS INT INIT 0.
DEF VAR n_length2 AS INT INIT 0.

If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".slk"  THEN 
    fi_outfile  =  Trim(fi_outfile) + ".slk"  .
/*ASSIGN nv_cnt  =  0
       nv_row  =  1.*/
OUTPUT TO VALUE(fi_outfile).
EXPORT DELIMITER "|"  
     " วันที่เริ่มคุ้มครอง "
     " วันที่สิ้นสุด       "
     " สาขา                "
     " เลขกรมธรรม์         "
     " คำนำหน้าชื่อ        "
     " ชื่อผู้เอาประกันภัย "
     " เบอร์โทร            "
     " รหัสตัวแทน          "
     " ยี่ห้อ              "
     " รุ่น                "
     " ปีที่จดทะเบียน      "
     " ทะเบียนรถ           "
     " เลขตัวถัง           "
     " วันที่ส่งตรวจ       "
     " วันที่ปิดเรื่อง     "
     " เลขตรวจสภาพ         "
     " ผลตรวจสภาพ          "
     " เหตุผล              "
     " รายละเอียดความเสียหาย "
     " อุปกรณ์เสริม        " .

FOR EACH winsp  no-lock.
    ASSIGN  n_pol   = ""    n_recnt = 0     n_encnt = 0  n_length1  = 0 n_length2  = 0.
    FIND LAST sicuw.uwm301 USE-INDEX uwm30121 WHERE (sicuw.uwm301.cha_no = trim(winsp.Chassis)) AND sicuw.uwm301.tariff = "X" NO-LOCK  NO-ERROR.
       IF AVAIL sicuw.uwm301 THEN DO:
           ASSIGN  n_pol   = ""    n_recnt = 0     n_encnt = 0     
                   n_pol   = sicuw.uwm301.policy 
                   n_recnt = sicuw.uwm301.rencnt 
                   n_encnt = sicuw.uwm301.endcnt .
           FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE 
                     sicuw.uwm100.policy = n_pol   AND 
                     sicuw.uwm100.rencnt = n_recnt AND 
                     sicuw.uwm100.endcnt = n_encnt NO-LOCK NO-ERROR .
               IF AVAIL sicuw.uwm100 THEN DO:
                   IF DATE(sicuw.uwm100.comdat) = DATE(winsp.comdat)  THEN ASSIGN  winsp.policy  = sicuw.uwm100.policy. 
                   ELSE ASSIGN winsp.policy = "" .
               END. 
               ELSE ASSIGN winsp.policy  = "".
       END.
       ELSE ASSIGN winsp.policy = "".
       
    n_length1 = LENGTH(winsp.insp_driver).
    n_length2 = LENGTH(winsp.insp_remark2) .

    EXPORT DELIMITER "|" 
        winsp.Comdat                    /* วันที่เริ่มคุ้มครอง */
        winsp.expdat                    /* วันที่สิ้นสุด       */
        winsp.branch                    /* สาขา                */
        winsp.policy                    /* เลขกรมธรรม์         */
        winsp.Custitle                  /* คำนำหน้าชื่อ        */
        winsp.cusName                   /* ชื่อผู้เอาประกันภัย */
        winsp.telno                     /* เบอร์โทร            */
        winsp.agentcode                 /* รหัสตัวแทน          */
        winsp.Brand                     /* ยี่ห้อ              */
        winsp.model                     /* รุ่น                */
        winsp.caryear                   /* ปีที่จดทะเบียน      */
        winsp.Licence                   /* ทะเบียนรถ           */
        winsp.Chassis                   /* เลขตัวถัง           */
        winsp.Insp_date                 /* วันที่ส่งตรวจ       */
        winsp.Insp_close                /* วันที่ปิดเรื่อง     */
        winsp.insp_no                   /* เลขตรวจสภาพ         */
        winsp.Insp_Detail               /* ผลตรวจสภาพ          */
        winsp.Insp_Remark1              /* เหตุผล              */
        winsp.Insp_Remark2              /* รายการความเสียหาย */
        winsp.insp_driver               /* อุปกรณ์เสริม        */
        /*winsp.insp_damage */
       /* winsp.Insp_other */   .
END. 
OUTPUT CLOSE.
RELEASE sicuw.uwm100.
RELEASE sicuw.uwm301.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

