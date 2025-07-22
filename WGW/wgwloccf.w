&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*------------------------------------------------------------------------*/
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
/*Program name : Import Text file Confirm Lockton , Export report Load to gw*/
/*create by    : Ranu i. A60-0139                                          */
/*DataBase connect : GW_SAFE -LD SIC_BRAN, GW_STAT -LD BRSTAT,SICSYAC,SICUW,STAT */
/*-----------------------------------------------------------------------------*/
/* Modify by : Ranu I. A60-0272 date:23/06/2017 เพิ่มข้อมูล ICNO  */
/* Modify by : Ranu I. A61-142 date:13/03/2018 แก้ไขข้อมูล รย.  */
/*-----------------------------------------------------------------------------*/
DEF  stream ns1.
DEFINE VAR  nv_daily       AS CHARACTER FORMAT "X(1024)"     INITIAL ""  NO-UNDO.
DEFINE VAR  nv_reccnt      AS  INT  INIT  0.
DEFINE VAR  nv_completecnt AS   INT   INIT  0.
DEFINE VAR  nv_enttim      AS  CHAR          INIT  "".
DEFINE VAR  nv_export      as  date  init  ""  format "99/99/9999".
DEF stream  ns2.
DEFINE VAR nv_file1        AS CHARACTER FORMAT "X(100)"     INITIAL ""  NO-UNDO.
DEFINE VAR nv_file2        AS CHARACTER FORMAT "X(100)"     INITIAL ""  NO-UNDO.
/*--------------------------สำหรับข้อมูลกรมธรรม์  -------------------------*/
DEFINE NEW SHARED TEMP-TABLE Texcel       /*A57-0107*/
    FIELD TRNO         AS CHAR FORMAT "X(10)"  init ""              /*"ประเภทของ Record"           */                            
    FIELD JV_TR        AS CHAR FORMAT "X(10)"  init ""              /*"เลขที่สัญญาในปีแรก"         */                           
    FIELD Purge_DATE   AS CHAR FORMAT "X(15)"  init ""              /*"เลขที่บัตรประชาชน"          */                           
    FIELD Paid_Date    AS CHAR FORMAT "X(10)"  init ""              /*""                           */                           
    FIELD Client_Code  AS CHAR FORMAT "X(8)"   init ""              /*"วันที่ทำสัญญา"              */                           
    FIELD Client_Name  AS CHAR FORMAT "X(8)"   init ""              /*"วันที่แจ้งประกัน"           */                           
    FIELD dncn_typ     AS CHAR FORMAT "X(5)"   init ""              /*"รหัสบริษัทประกันภัย"        */
    FIELD DNCN_no      AS CHAR FORMAT "X(2)"   init ""              /*"ประเภทประกันเดิม"           */                           
    FIELD Risk         AS CHAR FORMAT "X(2)"   init ""              /*"ประเภทความคุ้มครอง"         */                           
    FIELD Code         AS CHAR FORMAT "X(5)"   init ""              /*"Insurance License Type"     */                           
    FIELD Under        AS CHAR FORMAT "X(5)"   init ""              /*"ปีประกัน"                  */                           
    FIELD Pol_No       AS CHAR FORMAT "X(20)"  init ""              /*"เลขที่กรมธรรม์"             */                           
    FIELD comdat       AS CHAR FORMAT "X(20)"  init ""              /*"ทุนประกัน"                  */                           
    FIELD Expdat       AS CHAR FORMAT "X(20)"  init ""              /*"ทุนประกันรถหาย"             */                            
    FIELD Gross        AS CHAR FORMAT "X(20)"  init ""              /*"ค่าเบี้ยสุทธิ"                      */                            
    FIELD A_E          AS CHAR FORMAT "X(20)"  init ""              /*"ค่าเบี้ย"              */                            
    FIELD Lincen       AS CHAR FORMAT "X(20)"  init ""              /*"หัก ณ ที่จ่ายของค่าเบี้ย"   */                            
    FIELD Brief        AS CHAR FORMAT "X(20)"  init ""              /*"อากรเบี้ย"                  */                            
    FIELD cha_no       AS CHAR FORMAT "X(8)"   init ""              /*"วันที่ประกันภัยมีผล"        */                            
    FIELD Remark       AS CHAR FORMAT "X(8)"   init ""              /*"วันที่หมดอายุ"              */
    FIELD Paid_Type    AS CHAR FORMAT "X(35)"  init ""              /*"เลขที่ พรบ."                */ 
    FIELD comment      AS CHAR FORMAT "X(100)" init "".    

DEFINE NEW SHARED WORKFILE wdetail NO-UNDO
    FIELD n_row        AS INT  INIT 0
    FIELD Notify_no    AS CHAR FORMAT "X(25)"   INIT ""   
    FIELD Not_date     AS CHAR FORMAT "X(15)"   INIT ""   
    FIELD pol_title    AS CHAR FORMAT "X(30)"   INIT ""   
    FIELD pol_fname    AS CHAR FORMAT "X(75)"   INIT ""   
    FIELD Client_no    AS CHAR FORMAT "X(07)"   INIT ""   
    FIELD pol_addr1    AS CHAR FORMAT "X(100)"  INIT ""  
    FIELD pol_addr2    AS CHAR FORMAT "X(100)"  INIT ""  
    FIELD brand        AS CHAR FORMAT "X(20)"   INIT ""   
    FIELD model        AS CHAR FORMAT "X(50)"   INIT ""   
    FIELD licence      AS CHAR FORMAT "X(10)"   INIT ""   
    FIELD yrmanu       AS CHAR FORMAT "X(4)"    INIT ""   
    FIELD chassis      AS CHAR FORMAT "X(25)"   INIT ""   
    FIELD engine       AS CHAR FORMAT "X(25)"   INIT ""   
    FIELD Power        AS CHAR FORMAT "X(07)"   INIT ""   
    FIELD Ben_name     AS CHAR FORMAT "X(65)"   INIT ""   
    FIELD Prev_pol     AS CHAR FORMAT "X(25)"   INIT ""   
    FIELD sckno        AS CHAR FORMAT "X(25)"   INIT ""   
    field compol       as char format "x(15)"   init ""
    FIELD garage       AS CHAR FORMAT "X(01)"   INIT ""   
    FIELD covcod       AS CHAR FORMAT "X(5)"    INIT ""  
    FIELD drive1       AS CHAR FORMAT "x(70)"   INIT "" 
    FIELD bdate1       AS CHAR FORMAT "x(15)"   INIT ""
    FIELD driveid1     AS CHAR FORMAT "x(13)"   INIT ""
    FIELD drive2       AS CHAR FORMAT "x(70)"   INIT ""
    FIELD bdate2       AS CHAR FORMAT "x(15)"   INIT ""
    FIELD driveid2     AS CHAR FORMAT "x(13)"   INIT ""
    FIELD comdat       AS CHAR FORMAT "X(15)"   INIT ""   
    FIELD expdat       AS CHAR FORMAT "X(15)"   INIT ""   
    FIELD comp_comdat  AS CHAR FORMAT "X(15)"   INIT ""   
    FIELD comp_expdat  AS CHAR FORMAT "X(15)"   INIT ""   
    FIELD ins_amt      AS CHAR FORMAT "X(11)"   INIT ""   
    FIELD Prem1        AS CHAR FORMAT "X(15)"   INIT ""   
    FIELD comp_prm     AS CHAR FORMAT "X(09)"   INIT ""   
    FIELD Gross_prm    AS CHAR FORMAT "X(15)"   INIT ""   
    FIELD deduct       AS CHAR FORMAT "X(09)"   INIT ""   
    field deduct2      as char format "x(15)"   init ""
    FIELD tp1          AS CHAR FORMAT "X(20)"   INIT ""   
    FIELD tp2          AS CHAR FORMAT "X(20)"   INIT ""   
    FIELD tp3          AS CHAR FORMAT "X(20)"   INIT ""
    field si           as char format "x(15)"   init ""
    FIELD fi           AS CHAR FORMAT "X(11)"   INIT ""    
    field pd1          as CHAR FORMAT "X(20)"   init ""
    field pd2          as CHAR FORMAT "X(20)"   init ""
    field pd3          as CHAR FORMAT "X(20)"   init ""
    field dspc         as CHAR FORMAT "X(20)"   init ""
    FIELD fleetper     AS CHAR FORMAT "X(05)"   INIT ""   
    FIELD othper       AS CHAR FORMAT "X(05)"   INIT ""   
    FIELD seatenew     AS CHAR FORMAT "x(10)"   INIT ""   
    field remark1      as CHAR FORMAT "X(100)"  init ""  
    field remark2      as CHAR FORMAT "X(100)"  init ""  
    field remark3      as CHAR FORMAT "X(100)"  init ""  
    FIELD Account_no   AS CHAR FORMAT "X(10)"   INIT ""   
    FIELD name_insur   AS CHAR FORMAT "X(15)"   INIT ""   
    field polno        as char format "x(15)"   init ""  
    field temppol      as char format "x(15)"   init ""  
    FIELD camp         AS CHAR FORMAT "X(10)"   INIT ""    
    FIELD paiddat      AS CHAR FORMAT "X(10)"   INIT ""   
    FIELD typdoc       AS CHAR FORMAT "X(10)"   INIT "" 
    FIELD docno        AS CHAR FORMAT "x(10)"   INIT ""
    FIELD Remarkpaid   AS CHAR FORMAT "X(150)"   INIT ""
    FIELD paidtyp      AS CHAR FORMAT "x(10)"   INIT ""
    FIELD br           AS CHAR FORMAT "X(2)"    INIT ""
    FIELD class        AS CHAR FORMAT "X(3)"    INIT ""
    FIELD icno         AS CHAR FORMAT "x(15)"   INIT "" .  /*Ranui*/
   
DEFINE VAR nv_polsend AS CHAR FORMAT "x(20)" .   
DEFINE VAR nv_txtname AS CHAR FORMAT "x(100)".   
DEFINE VAR nv_comdat    AS CHAR INIT "".         
DEFINE VAR nv_expdat    AS CHAR INIT "".         
DEFINE VAR nv_policy72  AS CHAR INIT "".         
DEFINE VAR nv_comdat72  AS CHAR INIT "".         
DEFINE VAR nv_expdat72  AS CHAR INIT "".         
DEFINE     SHARED VAR nv_recid      AS RECID  NO-UNDO.
DEFINE STREAM ns1.
DEFINE STREAM ns2.
DEFINE VAR nv_row     AS INT  INIT 0.
DEFINE VAR nv_count   AS INT  INIT 0.
DEFINE VAR nv_output  AS CHAR FORMAT "X(45)".
DEFINE VAR nv_output2 AS CHAR FORMAT "X(45)".
DEF VAR   nv_cnt   as  int  init   1.
DEF VAR   ind_f1   AS  INTE INIT   0.
DEF VAR nv_messag  AS CHAR  INIT  "".
DEF VAR nv_oldpol  AS CHAR FORMAT "x(15)"  INIT "".
DEF VAR nv_length  AS INT INIT 0.
DEF VAR nv_poltyp  AS CHAR FORMAT "x(3)" INIT "".
DEF VAR nv_ry1     AS CHAR FORMAT "x(15)"  INIT "".
DEF VAR nv_ry2     AS CHAR FORMAT "x(15)"  INIT "".
DEF VAR nv_ry3     AS CHAR FORMAT "x(15)"  INIT "".
DEF VAR remark1    as char format "x(100)" init "".
DEF VAR remark2    as char format "x(100)" init "".
DEF VAR remark3    as char format "x(100)" init "".

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_process fi_loadname fi_outload bu_file-3 ~
bu_ok bu_exit-2 RECT-381 RECT-382 RECT-383 
&Scoped-Define DISPLAYED-OBJECTS fi_process fi_loadname fi_outload 

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

DEFINE BUTTON bu_file-3 
     LABEL "..." 
     SIZE 3.5 BY 1.

DEFINE BUTTON bu_ok 
     LABEL "OK" 
     SIZE 7.5 BY 1.05
     FONT 6.

DEFINE VARIABLE fi_loadname AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 63.67 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_outload AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 63.67 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_process AS CHARACTER FORMAT "X(80)":U 
      VIEW-AS TEXT 
     SIZE 56.83 BY .91
     BGCOLOR 8 FGCOLOR 1  NO-UNDO.

DEFINE RECTANGLE RECT-381
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 105 BY 6.67
     BGCOLOR 19 .

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
     fi_process AT ROW 7.19 COL 18.83 COLON-ALIGNED NO-LABEL
     fi_loadname AT ROW 4.62 COL 18.33 COLON-ALIGNED NO-LABEL
     fi_outload AT ROW 5.76 COL 18.33 COLON-ALIGNED NO-LABEL
     bu_file-3 AT ROW 4.62 COL 84.33
     bu_ok AT ROW 7.19 COL 85.83
     bu_exit-2 AT ROW 7.19 COL 96
     "OUTPUT FILE :" VIEW-AS TEXT
          SIZE 16 BY 1 AT ROW 5.71 COL 4.33
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "IMPORT FILE :" VIEW-AS TEXT
          SIZE 15 BY 1 AT ROW 4.62 COL 4.5
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "    MATCH FILE CONFIRM RENEW  (LOCKTON)" VIEW-AS TEXT
          SIZE 105 BY 2.14 AT ROW 1.1 COL 1.17
          BGCOLOR 31 FGCOLOR 7 FONT 6
     RECT-381 AT ROW 3.33 COL 1.17
     RECT-382 AT ROW 6.76 COL 94.67
     RECT-383 AT ROW 6.76 COL 84.67
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 105.5 BY 13
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
         TITLE              = "Match File Confirm Recepit Lockton Renew"
         HEIGHT             = 9.14
         WIDTH              = 105.67
         MAX-HEIGHT         = 45
         MAX-WIDTH          = 123.67
         VIRTUAL-HEIGHT     = 45
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
       bu_file-3:AUTO-RESIZE IN FRAME fr_main      = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Match File Confirm Recepit Lockton Renew */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Match File Confirm Recepit Lockton Renew */
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


&Scoped-define SELF-NAME bu_file-3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_file-3 C-Win
ON CHOOSE OF bu_file-3 IN FRAME fr_main /* ... */
DO:
    DEFINE VARIABLE no_add        AS CHARACTER NO-UNDO.
    DEFINE VARIABLE cvData        AS CHARACTER NO-UNDO.
    DEFINE VARIABLE OKpressed AS LOGICAL INITIAL TRUE.
    SYSTEM-DIALOG GET-FILE cvData
        TITLE      "Choose Data File to Import ..."
        FILTERS    /*"Text Documents" "*.txt",*/
        "Text Documents" "*.csv",
        "Data Files (*.*)"     "*.*"
        MUST-EXIST
        USE-FILENAME
        UPDATE OKpressed.
    IF OKpressed = TRUE THEN DO:
        no_add =           STRING(MONTH(TODAY),"99")    + 
                            STRING(DAY(TODAY),"99")      + 
                  SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                  SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) .
        fi_loadname  = cvData.
        nv_output = "".
        /*IF rs_type = 1 THEN ASSIGN fi_outload  = SUBSTR(fi_loadname,1,R-INDEX(fi_loadname,".") - 1 ) + "_Load" + NO_add.
        ELSE ASSIGN fi_outload  = SUBSTR(fi_loadname,1,R-INDEX(fi_loadname,".") - 1 ) + "_matpol" + NO_add.*/
       /* ELSE IF ra_matchpol = 3 THEN ASSIGN fi_outload   = SUBSTR(fi_loadname,1,R-INDEX(fi_loadname,".") - 1 ) + "_Cancel" + NO_add.*/
        ASSIGN fi_outload  = SUBSTR(fi_loadname,1,R-INDEX(fi_loadname,".") - 1 ) + "_Load" + NO_add
               nv_output = SUBSTR(fi_loadname,1,R-INDEX(fi_loadname,".") - 1 ) + "_confirm" + NO_add.
        DISP fi_loadname fi_outload WITH FRAME fr_main .     
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok C-Win
ON CHOOSE OF bu_ok IN FRAME fr_main /* OK */
DO:
    ASSIGN 
        nv_reccnt  =  0.
    IF fi_outload = "" THEN DO:
        MESSAGE "File name output not Empty..!!!" SKIP
            "Insert file name Output file...!!!"      VIEW-AS ALERT-BOX.
        APPLY "Entry" TO fi_outload.
        RETURN NO-APPLY.
    END.
    RUN proc_matchfile_lockton.
    RELEASE sicuw.uwm100.
    RELEASE sicuw.uwm301.
    RELEASE sicuw.uwm130.
    RELEASE sicuw.uwd132.
    RELEASE stat.mailtxt_fil.
    RELEASE brstat.tlt.
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_outload
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outload C-Win
ON LEAVE OF fi_outload IN FRAME fr_main
DO:
  fi_outload = INPUT fi_outload.
  DISP fi_outload WITH FRAM fr_main.
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
    /*  rs_type       = 1*/
      /*ra_matpoltyp      = 1*/
      gv_prgid          = "wgwloccf"
     /* fi_producernewf   = "B3M0032" 
      fi_agentnewfo     = "B3M0002" 
      fi_producernewtis = "B3M0003" 
      fi_agentnewtis    = "B3M0002" 
      fi_producerford   = "B3M0033"
      fi_producerno83   = "A0M2008"
      fi_producer83     = "A0M2012"
      fi_agentford      = "B3M0002"
      fi_agentno83      = "B3M0002"
      fi_agent83        = "B3M0002"  .*/
  gv_prog  = "Match Text File Confirm (Lockton)"
  fi_process = "Check data file Confirm Lockton ....." .
  
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).
  /*RUN proc_createpack.*/
 /* OPEN QUERY br_comp FOR EACH wcomp.*/
      DISP fi_process /* rs_type*/ /*ra_matchpol      fi_producerford   fi_producerno83  fi_producer83   
           fi_agentford     fi_agentno83      fi_agent83       fi_producernewf   
           fi_agentnewfo    fi_producernewtis fi_agentnewtis  ra_matpoltyp*/    WITH FRAM fr_main.
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
  DISPLAY fi_process fi_loadname fi_outload 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_process fi_loadname fi_outload bu_file-3 bu_ok bu_exit-2 RECT-381 
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
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH Texcel .
    IF INDEX(Texcel.TRNO,"Temporay") <> 0 THEN DELETE texcel.
    ELSE IF INDEX(Texcel.TRNO,"SAFETY") <> 0 THEN DELETE texcel.
    ELSE IF INDEX(Texcel.TRNO,"TR") <> 0 THEN DELETE texcel.
    ELSE IF INDEX(Texcel.TRNO,"No") <> 0 THEN DELETE texcel.
    ELSE IF  Texcel.TRNO = "" THEN DELETE texcel.
    ELSE DO:
        IF INDEX(Texcel.Lincen,"พรบ") <> 0 THEN DO:
            FIND LAST brstat.tlt WHERE index(texcel.cha_no,tlt.cha_no)    <> 0        AND               /*เลขตัวถัง */
                                   brstat.tlt.nor_noti_tlt = TRIM(texcel.Brief)       AND               /*เลขรับแจ้ง*/
                                  /* brstat.tlt.expousr      = "T"                      AND    */
                                   brstat.tlt.comp_grprm   = decI(trim(Texcel.Gross))  NO-ERROR NO-WAIT. /*เบี้ย พรบ.*/
            IF AVAIL brstat.tlt THEN DO:
               ASSIGN texcel.comment    = "COMPLETE" .
               IF brstat.tlt.releas   = "No" THEN DO:
                   ASSIGN brstat.tlt.releas        = "Confirm/No"
                          brstat.tlt.recac         = STRING(DAY(TODAY),"99") + "/" +
                                                     STRING(MONTH(TODAY),"99") + "/" +
                                                     STRING(YEAR(TODAY),"9999")     /* confirm date*/  
                          brstat.tlt.dat_ins_noti  = DATE(Texcel.Paid_Date).        /* paid date */ 
               END. 
               ELSE IF index(brstat.tlt.releas,"Cancel") <> 0 THEN DO:
                   ASSIGN  brstat.tlt.releas  = "Confirm/" + brstat.tlt.releas
                           brstat.tlt.recac   = STRING(DAY(TODAY),"99") + "/" +
                                                STRING(MONTH(TODAY),"99") + "/" +
                                                STRING(YEAR(TODAY),"9999")     /* confirm date*/  
                           brstat.tlt.dat_ins_noti  = DATE(Texcel.Paid_Date)        /* paid date */
                           texcel.comment           = "มีการ Cancel แล้ว " + " / " + "Confirm" .
               END.
               ELSE IF index(brstat.tlt.releas,"YES") <> 0 THEN DO: 
                   IF index(brstat.tlt.releas,"No Confirm") <> 0 THEN DO:
                    ASSIGN  brstat.tlt.releas  = "Confirm/YES"
                            brstat.tlt.recac   = STRING(DAY(TODAY),"99") + "/" +
                                                 STRING(MONTH(TODAY),"99") + "/" +
                                                 STRING(YEAR(TODAY),"9999")     /* confirm date*/  
                            brstat.tlt.dat_ins_noti  = DATE(Texcel.Paid_Date)   .      /* paid date */
                            texcel.comment = "มีการออกงานแล้ว " + brstat.tlt.rec_addr5 + " / " + "Confirm" .
                   END.
                   ELSE DO:
                    texcel.comment = "มีการออกงานแล้ว " + brstat.tlt.rec_addr5.
                   END.
               END.
            END.
            ELSE ASSIGN texcel.comment = "ไม่พบข้อมูลลูกค้า" .
        END.
        ELSE DO:
            FIND LAST brstat.tlt WHERE index(texcel.cha_no,tlt.cha_no)    <> 0    AND            /*เลขตัวถัง */
                                 brstat.tlt.nor_noti_tlt     = TRIM(texcel.Brief)     AND              /*เลขรับแจ้ง*/
                                 /*brstat.tlt.expousr         <> "T"                    AND   */
                                 brstat.tlt.nor_grprm        = decI(trim(Texcel.Gross))  NO-ERROR NO-WAIT. /*เบี้ย กธ.*/
            IF AVAIL brstat.tlt THEN DO:
                ASSIGN texcel.comment = "COMPLETE" .
                IF brstat.tlt.releas   = "No" THEN DO:
                    ASSIGN brstat.tlt.releas        = "Confirm/No"
                           brstat.tlt.recac         = STRING(DAY(TODAY),"99") + "/" +
                                                      STRING(MONTH(TODAY),"99") + "/" +
                                                      STRING(YEAR(TODAY),"9999")     /* confirm date*/  
                           brstat.tlt.dat_ins_noti  = DATE(Texcel.Paid_Date)   .      /* paid date */
                END. 
                ELSE IF index(brstat.tlt.releas,"Cancel") <> 0 THEN DO:
                    ASSIGN  brstat.tlt.releas  = "Confirm/" + brstat.tlt.releas
                            brstat.tlt.recac   = STRING(DAY(TODAY),"99") + "/" +
                                                 STRING(MONTH(TODAY),"99") + "/" +
                                                 STRING(YEAR(TODAY),"9999")     /* confirm date*/  
                            brstat.tlt.dat_ins_noti  = DATE(Texcel.Paid_Date)        /* paid date */
                            texcel.comment           = "มีการ Cancel แล้ว " + " / " + "Confirm" .
                END.
                ELSE IF index(brstat.tlt.releas,"YES") <> 0 THEN DO:
                    IF index(brstat.tlt.releas,"No Confirm") <> 0 THEN DO:
                        ASSIGN  brstat.tlt.releas  = "Confirm/YES"
                                brstat.tlt.recac   = STRING(DAY(TODAY),"99") + "/" +
                                                     STRING(MONTH(TODAY),"99") + "/" +
                                                     STRING(YEAR(TODAY),"9999")     /* confirm date*/  
                               brstat.tlt.dat_ins_noti  = DATE(Texcel.Paid_Date)   .      /* paid date */
                               texcel.comment = "มีการออกงานแล้ว " + brstat.tlt.policy + " / " + "Confirm" .
                    END.
                    ELSE DO:
                        texcel.comment = "มีการออกงานแล้ว " + brstat.tlt.policy.
                    END.
                END.
               
            END.
            ELSE ASSIGN texcel.comment = "ไม่พบข้อมูลลูกค้า" .
        END.
    END.
END.

RUN proc_reportmatch.
RUN proc_reportloadgw.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_detail C-Win 
PROCEDURE proc_detail :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 FIND LAST wdetail WHERE wdetail.notify_no = brstat.tlt.nor_noti_tlt NO-ERROR NO-WAIT.
    IF NOT AVAIL wdetail THEN DO:
        CREATE wdetail.
        ASSIGN 
          wdetail.Notify_no     = brstat.tlt.nor_noti_tlt                             /*RefNo           */ 
          wdetail.not_date      = string(brstat.tlt.datesent,"99/99/9999")            /*ClosingDate     */ 
          wdetail.pol_title     = brstat.tlt.rec_name                                 /*ClientTitle     */ 
          wdetail.pol_fname     = brstat.tlt.ins_name                                 /*ClientName      */ 
          wdetail.client_no     = brstat.tlt.safe3                                    /*ClientCode      */ 
          wdetail.pol_addr1     = brstat.tlt.ins_addr1                                /*ClientAddress1  */ 
          wdetail.pol_addr2     = brstat.tlt.ins_addr2                                /*ClientAddress2  */ 
          wdetail.brand         = brstat.tlt.brand                                    /*Brand           */ 
          wdetail.model         = brstat.tlt.model                                    /*Model           */ 
          wdetail.licence       = brstat.tlt.lince1                                   /*CarID           */ 
          wdetail.yrmanu        = brstat.tlt.lince2                                   /*RegisterYear    */ 
          wdetail.chassis       = brstat.tlt.cha_no                                   /*ChassisNo       */ 
          wdetail.engine        = brstat.tlt.eng_no                                   /*EngineNo        */ 
          wdetail.power         = string(brstat.tlt.cc_weight)                        /*CC              */ 
          wdetail.ben_name      = brstat.tlt.safe1                                    /*Beneficiary     */ 
          wdetail.prev_pol      = brstat.tlt.filler1                                  /*OldPolicyNo     */ 
          wdetail.sckno         = brstat.tlt.comp_sck                                 /*CMIStickerNo    */ 
          wdetail.compol        = brstat.tlt.rec_addr5                                /*CMIPolicyNo     */ 
          wdetail.garage        = brstat.tlt.stat                                     /*Garage          */ 
          wdetail.covcod        = brstat.tlt.expousr                                  /*InsureType      */ 
          wdetail.drive1        = IF index(brstat.tlt.dri_name1,"/") <> 0 THEN SUBSTR(brstat.tlt.dri_name1,1,index(brstat.tlt.dri_name1,"/") - 1)
                                  ELSE brstat.tlt.dri_name1                           /*Driver1         */ 
          wdetail.bdate1        = IF brstat.tlt.dri_no1 <> "" THEN 
                                  IF LENGTH(brstat.tlt.dri_no1) < 8 THEN  SUBSTR(brstat.tlt.dri_no1,1,1) + "/" + SUBSTR(brstat.tlt.dri_no1,2,2) + "/" + SUBSTR(brstat.tlt.dri_no1,4,4) 
                                  ELSE SUBSTR(brstat.tlt.dri_no1,1,2) + "/" + SUBSTR(brstat.tlt.dri_no1,3,2) + "/" + SUBSTR(brstat.tlt.dri_no1,5,4) ELSE "" 
          wdetail.driveid1      = IF index(brstat.tlt.dri_name1,"/") <> 0 THEN SUBSTR(brstat.tlt.dri_name1,R-INDEX(brstat.tlt.dri_name1,"/") + 1) ELSE ""
          wdetail.drive2        = IF index(brstat.tlt.dri_name2,"/") <> 0 THEN SUBSTR(brstat.tlt.dri_name2,1,index(brstat.tlt.dri_name2,"/") - 1)
                                  ELSE brstat.tlt.dri_name2                                       /*Driver2         */ 
          wdetail.bdate2        = IF brstat.tlt.dri_no2 <> "" THEN 
                                  IF LENGTH(brstat.tlt.dri_no2) < 8 THEN SUBSTR(brstat.tlt.dri_no2,1,1) + "/" + SUBSTR(brstat.tlt.dri_no2,2,2) + "/" + SUBSTR(brstat.tlt.dri_no2,4,4) 
                                  ELSE SUBSTR(brstat.tlt.dri_no2,1,2) + "/" + SUBSTR(brstat.tlt.dri_no2,3,2) + "/" + SUBSTR(brstat.tlt.dri_no2,5,4) ELSE ""
          wdetail.driveid2      = IF index(brstat.tlt.dri_name2,"/") <> 0 THEN SUBSTR(brstat.tlt.dri_name2,R-INDEX(brstat.tlt.dri_name2,"/") + 1) ELSE ""
          wdetail.comdat        = if brstat.tlt.gendat  <> ? THEN string(brstat.tlt.gendat,"99/99/9999") else ""            /*VMIStartDate    */ 
          wdetail.expdat        = if brstat.tlt.expodat <> ? THEN string(brstat.tlt.expodat,"99/99/9999") else ""           /*VMIEndDate      */ 
          wdetail.comp_comdat   = if brstat.tlt.nor_effdat  <> ? then string(brstat.tlt.nor_effdat,"99/99/9999")  ELSE ""   /*CMIStartDate    */ 
          wdetail.comp_expdat   = if brstat.tlt.comp_effdat <> ? then string(brstat.tlt.comp_effdat,"99/99/9999") ELSE ""   /*CMIEndDate      */ 
          wdetail.ins_amt       = string(brstat.tlt.nor_coamt )                       /*SumInsured      */ 
          wdetail.prem1         = string(brstat.tlt.nor_grprm )                       /*VMITotalPremium */ 
          wdetail.comp_prm      = string(brstat.tlt.comp_grprm)                       /*CMITotalPremium */ 
          wdetail.gross_prm     = string(brstat.tlt.comp_coamt)                       /*TotalPremium    */ 
          wdetail.deduct        = brstat.tlt.endno                                    /*FirstOD         */ 
          wdetail.deduct2       = brstat.tlt.lince3                                   /*FirstTPPD       */ 
          wdetail.tp1           = brstat.tlt.old_eng                                  /*TPBIPerson      */ 
          wdetail.tp2           = brstat.tlt.old_cha                                  /*TPBITime        */ 
          wdetail.tp3           = brstat.tlt.comp_pol                                 /*TPPD            */ 
          wdetail.si            = brstat.tlt.nor_usr_tlt                              /*OD              */ 
          wdetail.fi            = brstat.tlt.rec_addr1                                /*FT              */ 
          wdetail.pd1           = nv_ry1                                              /*  RY01  tlt.comp_usr_tlt  */ 
          wdetail.pd2           = nv_ry2                                              /*  RY02  tlt.comp_usr_tlt  */ 
          wdetail.pd3           = nv_ry3                                              /*  RY03  tlt.comp_usr_tlt  */ 
          wdetail.dspc          = brstat.tlt.rec_addr4                                /*DiscountGroup   */ 
          wdetail.fleetper      = brstat.tlt.lotno                                    /*DiscountHistory */ 
          wdetail.othper        = string(brstat.tlt.endcnt)                           /*DiscountOther   */ 
          wdetail.seatenew      = string(brstat.tlt.sentcnt)                          /*Seat            */ 
          wdetail.remark1       = remark1                                             /*RemarkInsurer1  tlt.filler2 */ 
          wdetail.remark2       = remark2                                             /*RemarkInsurer2  tlt.filler2*/ 
          wdetail.remark3       = remark2                                             /*RemarkInsurer3  tlt.filler2*/ 
          wdetail.Account_no    = brstat.tlt.safe2                                    /*ContractNo      */ 
          wdetail.name_insur    = brstat.tlt.nor_usr_ins                              /*UserClosing     */ 
          wdetail.polno         = brstat.tlt.policy                                   /*PolicyNo        */ 
          wdetail.temppol       = brstat.tlt.rec_addr3                                /*TempPolicyNo    */ 
          wdetail.camp          = brstat.tlt.colorcod                                 /*Campaign        */ 
          wdetail.paiddat       = Texcel.Paid_Date                                    /*Paid Date       */ 
          wdetail.typdoc        = Texcel.DNCN_typ                                     /*DN/CN           */ 
          wdetail.docno         = Texcel.DNCN_no                                      /*Ref # (DN/CN)   */ 
          wdetail.remarkpaid    = Texcel.Remark                                       /*Remark_paid     */ 
          wdetail.paidtyp       = Texcel.Paid_Type                                    /*Paid  Type      */
          wdetail.br            = brstat.tlt.EXP                                      
          wdetail.CLASS         = ""
          wdetail.icno          = brstat.tlt.subins.        /*A60-0272*/

    END.
    ELSE DO:
       ASSIGN 
       wdetail.Notify_no     = brstat.tlt.nor_noti_tlt                             /*RefNo           */ 
       wdetail.not_date      = string(brstat.tlt.datesent,"99/99/9999")            /*ClosingDate     */ 
       wdetail.pol_title     = brstat.tlt.rec_name                                 /*ClientTitle     */ 
       wdetail.pol_fname     = brstat.tlt.ins_name                                 /*ClientName      */ 
       wdetail.client_no     = brstat.tlt.safe3                                    /*ClientCode      */ 
       wdetail.pol_addr1     = brstat.tlt.ins_addr1                                /*ClientAddress1  */ 
       wdetail.pol_addr2     = brstat.tlt.ins_addr2                                /*ClientAddress2  */ 
       wdetail.brand         = brstat.tlt.brand                                    /*Brand           */ 
       wdetail.model         = brstat.tlt.model                                    /*Model           */ 
       wdetail.licence       = brstat.tlt.lince1                                   /*CarID           */ 
       wdetail.yrmanu        = brstat.tlt.lince2                                   /*RegisterYear    */ 
       wdetail.chassis       = brstat.tlt.cha_no                                   /*ChassisNo       */ 
       wdetail.engine        = brstat.tlt.eng_no                                   /*EngineNo        */ 
       wdetail.power         = string(brstat.tlt.cc_weight)                        /*CC              */ 
       wdetail.ben_name      = brstat.tlt.safe1                                    /*Beneficiary     */ 
       wdetail.prev_pol      = brstat.tlt.filler1                                  /*OldPolicyNo     */ 
       wdetail.sckno         = brstat.tlt.comp_sck                                 /*CMIStickerNo    */ 
       wdetail.compol        = brstat.tlt.rec_addr5                                /*CMIPolicyNo     */ 
       wdetail.garage        = brstat.tlt.stat                                     /*Garage          */ 
       wdetail.covcod        = brstat.tlt.expousr                                  /*InsureType      */ 
       wdetail.drive1        = IF index(brstat.tlt.dri_name1,"/") <> 0 THEN SUBSTR(brstat.tlt.dri_name1,1,index(brstat.tlt.dri_name1,"/") - 1)
                               ELSE brstat.tlt.dri_name1                           /*Driver1         */ 
       wdetail.bdate1        = IF brstat.tlt.dri_no1 <> "" THEN 
                               IF LENGTH(brstat.tlt.dri_no1) < 8 THEN  SUBSTR(brstat.tlt.dri_no1,1,1) + "/" + SUBSTR(brstat.tlt.dri_no1,2,2) + "/" + SUBSTR(brstat.tlt.dri_no1,4,4) 
                               ELSE SUBSTR(brstat.tlt.dri_no1,1,2) + "/" + SUBSTR(brstat.tlt.dri_no1,3,2) + "/" + SUBSTR(brstat.tlt.dri_no1,5,4) ELSE ""
       wdetail.driveid1      = IF index(brstat.tlt.dri_name1,"/") <> 0 THEN SUBSTR(brstat.tlt.dri_name1,R-INDEX(brstat.tlt.dri_name1,"/") + 1) ELSE ""
       wdetail.drive2        = IF index(brstat.tlt.dri_name2,"/") <> 0 THEN SUBSTR(brstat.tlt.dri_name2,1,index(brstat.tlt.dri_name2,"/") - 1)
                               ELSE brstat.tlt.dri_name2                                       /*Driver2         */ 
       wdetail.bdate2        = IF brstat.tlt.dri_no2 <> "" THEN 
                               IF LENGTH(brstat.tlt.dri_no2) < 8 THEN SUBSTR(brstat.tlt.dri_no2,1,1) + "/" + SUBSTR(brstat.tlt.dri_no2,2,2) + "/" + SUBSTR(brstat.tlt.dri_no2,4,4) 
                               ELSE SUBSTR(brstat.tlt.dri_no2,1,2) + "/" + SUBSTR(brstat.tlt.dri_no2,3,2) + "/" + SUBSTR(brstat.tlt.dri_no2,5,4) ELSE ""
       wdetail.driveid2      = IF index(brstat.tlt.dri_name2,"/") <> 0 THEN SUBSTR(brstat.tlt.dri_name2,R-INDEX(brstat.tlt.dri_name2,"/") + 1) ELSE ""
       wdetail.comdat        = if brstat.tlt.gendat  <> ? THEN string(brstat.tlt.gendat,"99/99/9999") else ""            /*VMIStartDate    */ 
       wdetail.expdat        = if brstat.tlt.expodat <> ? THEN string(brstat.tlt.expodat,"99/99/9999") else ""           /*VMIEndDate      */ 
       wdetail.comp_comdat   = if brstat.tlt.nor_effdat  <> ? then string(brstat.tlt.nor_effdat,"99/99/9999")  ELSE ""   /*CMIStartDate    */ 
       wdetail.comp_expdat   = if brstat.tlt.comp_effdat <> ? then string(brstat.tlt.comp_effdat,"99/99/9999") ELSE ""   /*CMIEndDate      */ 
       wdetail.ins_amt       = string(brstat.tlt.nor_coamt )                       /*SumInsured      */ 
       wdetail.prem1         = string(brstat.tlt.nor_grprm )                       /*VMITotalPremium */ 
       wdetail.comp_prm      = string(brstat.tlt.comp_grprm)                       /*CMITotalPremium */ 
       wdetail.gross_prm     = string(brstat.tlt.comp_coamt)                       /*TotalPremium    */ 
       wdetail.deduct        = brstat.tlt.endno                                    /*FirstOD         */ 
       wdetail.deduct2       = brstat.tlt.lince3                                   /*FirstTPPD       */ 
       wdetail.tp1           = brstat.tlt.old_eng                                  /*TPBIPerson      */ 
       wdetail.tp2           = brstat.tlt.old_cha                                  /*TPBITime        */ 
       wdetail.tp3           = brstat.tlt.comp_pol                                 /*TPPD            */ 
       wdetail.si            = brstat.tlt.nor_usr_tlt                              /*OD              */ 
       wdetail.fi            = brstat.tlt.rec_addr1                                /*FT              */ 
       wdetail.pd1           = nv_ry1                                              /*  RY01  tlt.comp_usr_tlt  */ 
       wdetail.pd2           = nv_ry2                                              /*  RY02  tlt.comp_usr_tlt  */ 
       wdetail.pd3           = nv_ry3                                              /*  RY03  tlt.comp_usr_tlt  */ 
       wdetail.dspc          = brstat.tlt.rec_addr4                                /*DiscountGroup   */ 
       wdetail.fleetper      = brstat.tlt.lotno                                    /*DiscountHistory */ 
       wdetail.othper        = string(brstat.tlt.endcnt)                           /*DiscountOther   */ 
       wdetail.seatenew      = string(brstat.tlt.sentcnt)                          /*Seat            */ 
       wdetail.remark1       = remark1                                             /*RemarkInsurer1  tlt.filler2 */ 
       wdetail.remark2       = remark2                                             /*RemarkInsurer2  tlt.filler2*/ 
       wdetail.remark3       = remark2                                             /*RemarkInsurer3  tlt.filler2*/ 
       wdetail.Account_no    = brstat.tlt.safe2                                    /*ContractNo      */ 
       wdetail.name_insur    = brstat.tlt.nor_usr_ins                              /*UserClosing     */ 
       wdetail.polno         = brstat.tlt.policy                                   /*PolicyNo        */ 
       wdetail.temppol       = brstat.tlt.rec_addr3                                /*TempPolicyNo    */ 
       wdetail.camp          = brstat.tlt.colorcod                                 /*Campaign        */ 
       wdetail.paiddat       = Texcel.Paid_Date                                    /*Paid Date       */ 
       wdetail.typdoc        = Texcel.DNCN_typ                                     /*DN/CN           */ 
       wdetail.docno         = Texcel.DNCN_no                                      /*Ref # (DN/CN)   */ 
       wdetail.remarkpaid    = Texcel.Remark                                       /*Remark_paid     */ 
       wdetail.paidtyp       = Texcel.Paid_Type                                    /*Paid  Type      */
       wdetail.br            = brstat.tlt.EXP                                      
       wdetail.CLASS         = ""
       wdetail.icno          = brstat.tlt.subins.        /*A60-0272*/
    END.
 END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matchfile_lockton C-Win 
PROCEDURE proc_matchfile_lockton :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    For each  Texcel :                             
        DELETE  Texcel.                            
    END.
    FOR EACH wdetail:
        DELETE wdetail.
    END.
    INPUT FROM VALUE (fi_loadname) .                                   
       REPEAT: 
           CREATE Texcel.          /*create Texcel....fi_filename2 file pov..... */
           IMPORT DELIMITER "|" 
               Texcel.TRNO           /*TR NO          */  
               Texcel.JV_TR          /*JV/TR          */  
               Texcel.Purge_DATE     /*Purge DATE     */  
               Texcel.Paid_Date      /*Client Paid    */  
               Texcel.Client_Code    /*Client Code    */  
               Texcel.Client_Name    /*Client Name    */                                              
               Texcel.DNCN_typ       /*DN/            */                   
               Texcel.DNCN_no        /*Ref # (DN/CN)  */                                 
               Texcel.Risk           /*Risk           */                                
               Texcel.Code           /*               */                                
               Texcel.Under          /*Underwriter    */                                
               Texcel.Pol_No         /*Policy No      */                                
               Texcel.comdat         /*Effective      */                                
               Texcel.Expdat         /*Expiry         */                                
               Texcel.Gross          /*Gross Total    */                                
               Texcel.A_E            /*A/E            */  
               Texcel.Lincen         /*Brief I        */  
               Texcel.Brief          /*Brief II       */                                
               Texcel.cha_no         /*Brief III      */                                
               Texcel.Remark         /*Remark         */                                
               Texcel.Paid_Type .     /*Paid  Type     */                               
                 
       END.  
       RUN proc_chkdata.       /* เช็คกรมธรรม์ file load */ 
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportloadgw C-Win 
PROCEDURE proc_reportloadgw :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
If  substr(fi_outload,length(fi_outload) - 3,4) <>  ".CSV"  THEN 
    fi_outload  =  Trim(fi_outload) + ".CSV"  .
ASSIGN nv_cnt =  0
       nv_row  =  1.
OUTPUT TO VALUE(fi_outload).
EXPORT DELIMITER "|" 
    "NO"
    "RefNo           "
    "ClosingDate     "
    "ClientTitle     "
    "ClientName      "
    "ClientCode      "
    "ClientAddress1  "
    "ClientAddress2  "
    "Brand           "
    "Model           "
    "CarID           "
    "RegisterYear    "
    "ChassisNo       "
    "EngineNo        "
    "CC              "
    "Beneficiary     "
    "OldPolicyNo     "
    "CMIStickerNo    "
    "CMIPolicyNo     "
    "Garage          "
    "InsureType      "
    "Driver1         "
    "Birth Date1     "
    "Driver Licen1   "
    "Driver2         "
    "Birth Date2     "
    "Driver Licen2   "
    "VMIStartDate    "
    "VMIEndDate      "
    "CMIStartDate    "
    "CMIEndDate      "
    "SumInsured      "
    "VMITotalPremium "
    "CMITotalPremium "
    "TotalPremium    "
    "FirstOD         "
    "FirstTPPD       "
    "TPBIPerson      "
    "TPBITime        "
    "TPPD            "
    "OD              "
    "FT              "
    "RY01            "
    "RY02            "
    "RY03            "
    "DiscountGroup   "
    "DiscountHistory "
    "DiscountOther   "
    "Seat            "
    "RemarkInsurer1  "
    "RemarkInsurer2  "
    "RemarkInsurer3  "
    "ContractNo      "
    "UserClosing     "
    "PolicyNo        "
    "TempPolicyNo    "
    "Campaign        "
    "ICNO            " /*A60-0272*/
    "Paid Date       "
    "DN/CN           "
    "Ref # (DN/CN)   "
    "Remark_paid     "
    "Paid  Type      "
    "BR              "
    "Class70        "  .
    FOR EACH Texcel WHERE Texcel.comment = "COMPLETE"  NO-LOCK.
            IF INDEX(Texcel.Lincen,"พรบ") <> 0 THEN DO:
                FIND LAST brstat.tlt WHERE index(texcel.cha_no,tlt.cha_no)    <> 0        AND               /*เลขตัวถัง */
                                       brstat.tlt.nor_noti_tlt = TRIM(texcel.Brief)       AND               /*เลขรับแจ้ง*/
                                       brstat.tlt.comp_grprm   = decI(trim(Texcel.Gross))  NO-ERROR NO-WAIT. /*เบี้ย พรบ.*/
                IF AVAIL brstat.tlt THEN DO:
                    ASSIGN  nv_poltyp = ""    nv_ry1  = ""     nv_ry2  = ""    nv_ry3  = ""
                            remark1   = ""    remark2 = ""     remark3 = ""
                            nv_poltyp = IF brstat.tlt.expousr = "T" THEN "72" ELSE "70"
                            remark1 = IF index(tlt.filler2,"r2:") <> 0 THEN   Substr(tlt.filler2,1,index(tlt.filler2,"r2:") - 1) ELSE TRIM(tlt.filler2)                                                                       
                            remark2 = IF index(tlt.filler2,"r2:") <> 0 THEN   Substr(tlt.filler2,index(tlt.filler2,"r2:") + 3 ) ELSE ""                                                                                       
                            remark2 = IF index(remark2,"r3:")  <> 0 THEN   Substr(remark2,1,index(remark2,"r3:") - 1) ELSE remark2                                                                                
                            remark3 = IF index(tlt.filler2,"r3:") <> 0 THEN   Substr(tlt.filler2,index(tlt.filler2,"r3:") + 3 ) ELSE "" 
                       
                            nv_length    =  LENGTH(brstat.tlt.comp_usr_tlt)
                            nv_ry3       =  TRIM(SUBSTR(brstat.tlt.comp_usr_tlt,R-INDEX(brstat.tlt.comp_usr_tlt,"PD3:") + 4,nv_length))   /*RY03     */
                            nv_length    =  LENGTH(nv_ry3)                                                                               
                            nv_ry2       =  TRIM(SUBSTR(brstat.tlt.comp_usr_tlt,R-INDEX(brstat.tlt.comp_usr_tlt,"PD2:") + 4,nv_length))   /*RY02     */
                            nv_length    =  LENGTH(nv_ry2)                                                                               
                            nv_ry1       =  TRIM(SUBSTR(brstat.tlt.comp_usr_tlt,r-index(brstat.tlt.comp_usr_tlt,"PD1:") + 4,nv_length))  . /*RY01    */ 
                            if index(nv_ry1,"P") <> 0 then nv_ry1 = trim(REPLACE(nv_ry1,"P","")).  /*A61-0142*/
                            if index(nv_ry2,"P") <> 0 then nv_ry2 = trim(REPLACE(nv_ry2,"P","")).  /*A61-0142*/
                            if index(nv_ry3,"P") <> 0 then nv_ry3 = trim(REPLACE(nv_ry3,"P","")).  /*A61-0142*/
                 END.          
                 RUN proc_detail.
            END.
            ELSE DO:
                FIND LAST brstat.tlt WHERE index(texcel.cha_no,tlt.cha_no) <> 0       AND               /*เลขตัวถัง */
                          brstat.tlt.nor_noti_tlt = TRIM(texcel.Brief)       AND               /*เลขรับแจ้ง*/
                          brstat.tlt.nor_grprm  = decI(trim(Texcel.Gross))  NO-ERROR NO-WAIT. /*เบี้ย พรบ.*/
                IF AVAIL brstat.tlt THEN DO:
                    ASSIGN  nv_poltyp = ""    nv_ry1  = ""     nv_ry2  = ""    nv_ry3  = ""
                            remark1   = ""    remark2 = ""     remark3 = ""
                           /* nv_poltyp = IF brstat.tlt.expousr = "T" THEN "72" ELSE "70"*/
                            remark1 = IF index(tlt.filler2,"r2:") <> 0 THEN   Substr(tlt.filler2,1,index(tlt.filler2,"r2:") - 1) ELSE TRIM(tlt.filler2)                                                                       
                            remark2 = IF index(tlt.filler2,"r2:") <> 0 THEN   Substr(tlt.filler2,index(tlt.filler2,"r2:") + 3 ) ELSE ""                                                                                       
                            remark2 = IF index(remark2,"r3:")  <> 0 THEN   Substr(remark2,1,index(remark2,"r3:") - 1) ELSE remark2                                                                                
                            remark3 = IF index(tlt.filler2,"r3:") <> 0 THEN   Substr(tlt.filler2,index(tlt.filler2,"r3:") + 3 ) ELSE ""
                            nv_length    =  LENGTH(brstat.tlt.comp_usr_tlt)
                            nv_ry3       =  TRIM(SUBSTR(brstat.tlt.comp_usr_tlt,R-INDEX(brstat.tlt.comp_usr_tlt,"PD3:") + 4,nv_length))   /*RY03     */
                            nv_length    =  LENGTH(nv_ry3)                                                                               
                            nv_ry2       =  TRIM(SUBSTR(brstat.tlt.comp_usr_tlt,R-INDEX(brstat.tlt.comp_usr_tlt,"PD2:") + 4,nv_length))   /*RY02     */
                            nv_length    =  LENGTH(nv_ry2)                                                                               
                            nv_ry1       =  TRIM(SUBSTR(brstat.tlt.comp_usr_tlt,r-index(brstat.tlt.comp_usr_tlt,"PD1:") + 4,nv_length))  . /*RY01    */ 
                            if index(nv_ry1,"P") <> 0 then nv_ry1 = trim(REPLACE(nv_ry1,"P","")).  /*A61-0142*/
                            if index(nv_ry2,"P") <> 0 then nv_ry2 = trim(REPLACE(nv_ry2,"P","")).  /*A61-0142*/
                            if index(nv_ry3,"P") <> 0 then nv_ry3 = trim(REPLACE(nv_ry3,"P","")).  /*A61-0142*/
                            
                    RUN proc_detail.
                END.
            END.
    END.
FOR EACH wdetail NO-LOCK.
    nv_cnt = nv_cnt + 1.
    EXPORT DELIMITER "|" 
        nv_cnt
        wdetail.Notify_no   
        wdetail.not_date    
        wdetail.pol_title   
        wdetail.pol_fname   
        wdetail.client_no   
        wdetail.pol_addr1   
        wdetail.pol_addr2   
        wdetail.brand       
        wdetail.model       
        wdetail.licence     
        wdetail.yrmanu      
        wdetail.chassis     
        wdetail.engine      
        wdetail.power       
        wdetail.ben_name    
        wdetail.prev_pol    
        wdetail.sckno       
        wdetail.compol      
        wdetail.garage      
        wdetail.covcod      
        wdetail.drive1
        wdetail.bdate1  
        wdetail.driveid1
        wdetail.drive2
        wdetail.bdate2  
        wdetail.driveid2
        wdetail.comdat      
        wdetail.expdat      
        wdetail.comp_comdat 
        wdetail.comp_expdat 
        wdetail.ins_amt     
        wdetail.prem1       
        wdetail.comp_prm    
        wdetail.gross_prm   
        int(wdetail.deduct)     
        int(wdetail.deduct2)     
        int(wdetail.tp1)     
        int(wdetail.tp2)     
        int(wdetail.tp3)     
        int(wdetail.si)     
        int(wdetail.fi)     
        int(wdetail.pd1)     
        int(wdetail.pd2)     
        int(wdetail.pd3)     
        int(wdetail.dspc)     
        int(wdetail.fleetper)    
        int(wdetail.othper)     
        wdetail.seatenew    
        wdetail.remark1     
        wdetail.remark2     
        wdetail.remark3     
        wdetail.Account_no  
        wdetail.name_insur  
        wdetail.polno       
        wdetail.temppol     
        wdetail.camp 
        wdetail.icno        /*A60-0272*/
        wdetail.paiddat     
        wdetail.typdoc      
        wdetail.docno       
        wdetail.remarkpaid  
        wdetail.paidtyp     
        wdetail.br          
        wdetail.CLASS .
END.
MESSAGE "Export data complete " VIEW-AS ALERT-BOX.
OUTPUT CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportmatch C-Win 
PROCEDURE proc_reportmatch :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
-----------------------------------------------------------------------------*/
If  substr(nv_output,length(nv_output) - 3,4) <>  ".slk"  THEN 
    nv_output  =  Trim(nv_output) + ".slk"  .
ASSIGN nv_cnt =  0
       nv_row  =  1.
OUTPUT TO VALUE(nv_output).
EXPORT DELIMITER "|" 
    "Report Match Recepit Lockton Date : " string(TODAY)   .
EXPORT DELIMITER "|" 
    "TR NO        "   
    "JV TR        "   
    "Purge DATE   "   
    "Client Paid  "   
    "Client Code  "   
    "Client Name  "   
    "DN/DC        "   
    "Ref#(DN/CN)"   
    "Risk        "   
    "Code        "   
    "Underwriter "   
    "Policy No   "   
    "Effective   "   
    "Expiry      "   
    "Gross Total "   
    "A/E         "   
    "Brief I     "   
    "Brief II    "   
    "Brief III   "   
    "Remark      "   
    "Paid Type   "  
    "Comment     " .
FOR EACH Texcel   no-lock.
    EXPORT DELIMITER "|" 
        Texcel.TRNO        
        Texcel.JV_TR       
        Texcel.Purge_DATE  
        Texcel.Paid_Date   
        Texcel.Client_Code 
        Texcel.Client_Name 
        Texcel.DNCN_typ    
        Texcel.DNCN_no     
        Texcel.Risk        
        Texcel.Code        
        Texcel.Under       
        Texcel.Pol_No      
        Texcel.comdat      
        Texcel.Expdat      
        Texcel.Gross       
        Texcel.A_E         
        Texcel.Lincen      
        Texcel.Brief       
        Texcel.cha_no      
        Texcel.Remark      
        Texcel.Paid_Type
        Texcel.comment.
END. 
OUTPUT CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

