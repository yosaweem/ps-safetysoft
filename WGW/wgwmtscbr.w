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

/* ***************************  Definitions  **************************        */

/*Program ID    :  wgwmtscbr.w                                                 */
/*Program name :  Export file policy Send to SCBRE                            */
/*create by    : Ranu I. A63-0161 Date: 15/08/2020  Match ไฟล์แจ้งงานหาเบอร์กรมธรรม์ส่งกลับ SCB*/
/*DataBase connect : GW_SAFE -LD SIC_BRAN, GW_STAT -LD BRSTAT,SICSYAC,SICUW */  
/*---------------------------------------------------------------------------*/ 
/* Parameters Definitions ---                                                  */
/* Local Variable Definitions ---                                              */

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
DEFINE NEW SHARED WORKFILE wdetail NO-UNDO
    FIELD num             AS INT                    INIT 0     /*No            */                     
    FIELD account         AS CHAR FORMAT "X(50)"    INIT ""    /*Account           */                  
    FIELD InsuredName     AS CHAR FORMAT "X(225)"   INIT ""    /*ชื่อผู้เอาประกัน  */         
    FIELD stk             AS CHAR FORMAT "X(20)"    INIT ""    /*เลขตารางพรบ./เลขสติกเกอร์*/  
    FIELD PolicyNo        AS CHAR FORMAT "X(20)"    INIT ""    /*POLICY NO      */            
    FIELD EffectiveDate   AS CHAR FORMAT "X(15)"    INIT ""    /*Effective Date */                     
    FIELD ExpireDate      AS CHAR FORMAT "X(15)"    INIT ""    /*Expire Date    */             
    FIELD GrossPremium    AS CHAR FORMAT "X(20)"    INIT ""    /*Gross Premium  */                     
    FIELD PremiumRecord   AS CHAR FORMAT "X(20)"    INIT ""    /*Premium Record */            
    FIELD NetPremium      AS CHAR FORMAT "X(20)"    INIT ""    /*Net Premium    */            
    FIELD senddate        AS CHAR FORMAT "X(20)"    INIT ""    /*วันที่จัดส่ง พรบ*/           
    FIELD emsno           AS CHAR FORMAT "X(20)"    INIT ""    /*เลขลงทะเบียน    */           
    FIELD remark          AS CHAR FORMAT "x(350)"   INIT ""   /*Remark          */    
    FIELD poltyp          AS CHAR FORMAT "x(3)"     INIT ""  . /*poltype         */    

def var np_dano         AS CHAR FORMAT "x(20)"  INIT "". 
def var np_datenoti     AS CHAR FORMAT "X(20)"  INIT "". 
def var np_namenoti     AS CHAR FORMAT "X(60)"  INIT "".  
def var np_company      AS CHAR FORMAT "X(40)"  INIT "".    /*  11 บุคคล/นิติบุคคล */                        
def var np_insname      AS CHAR FORMAT "x(60)"  INIT "".    /*name*/
def var np_prepol       AS CHAR FORMAT "x(20)"  INIT "".    
DEF VAR np_brsty        AS CHAR FORMAT "x(2)"   INIT "". 
def var np_cartyp       AS CHAR FORMAT "x(30)"  INIT "".    
def var np_brandmodel   AS CHAR FORMAT "x(50)"  INIT "".    
def var np_caryear      AS CHAR FORMAT "x(4)"   INIT "".    
def var np_vehreg       AS CHAR FORMAT "x(11)"  INIT "".    /*vehicl registration*//*A54-0112*/
def var np_provin       AS CHAR FORMAT "x(20)"  INIT "".    /*vehicl registration*//*A54-0112*/
def var np_engcc        AS CHAR FORMAT "x(10)"  INIT "".    
def var np_tons         AS CHAR FORMAT "x(10)"  INIT "".    
def var np_chassis      AS CHAR FORMAT "x(25)"  INIT "".    /*chasis no*/
def var np_engno        AS CHAR FORMAT "x(25)"  INIT "".    /*engine no*/
def var np_covcod       AS CHAR FORMAT "x(20)"  INIT "".    /*cover type*/
def var np_comdate      AS CHAR FORMAT "x(10)"  INIT "".    /*comm date*/
def var np_premium      AS CHAR FORMAT "x(20)"  INIT "".    /*voluntory premium*/
def var np_sumins       AS CHAR FORMAT "x(10)"  INIT "".    
def var np_garage       AS CHAR FORMAT "x(25)"  INIT "".    /*sum insure*/
def var np_sendfile     AS CHAR FORMAT "x(25)"  INIT "".    
def var np_cedpol       AS CHAR INIT "" FORMAT "x(255)". 
def var np_comdatecomp  AS CHAR FORMAT "x(25)"  INIT "".    
def var np_compprem     AS CHAR FORMAT "x(10)"  INIT "".    /*expiry date*/
def var np_addr1        AS CHAR FORMAT "x(20)"  INIT "".    /*expiry date*/
def var np_addr2        AS CHAR FORMAT "x(150)" INIT "".    
def var np_addr3        AS CHAR FORMAT "x(45)"  INIT "".    
def var np_addr4        AS CHAR FORMAT "x(45)"  INIT "".    
def var np_addr5        AS CHAR FORMAT "x(45)"  INIT "".    
def var np_recipeaddr1  AS CHAR FORMAT "x(45)"  INIT "".    
def var np_recipeaddr2  AS CHAR FORMAT "x(150)" INIT "".    
def var np_recipeaddr3  AS CHAR FORMAT "x(45)"  INIT "".    
def var np_recipeaddr4  AS CHAR FORMAT "x(45)"  INIT "".    
def var np_recipeaddr5  AS CHAR FORMAT "x(45)"  INIT "".    
def var np_stkno        AS CHAR FORMAT "x(45)"  INIT "".    
def var np_memo         AS CHAR FORMAT "x(15)"  INIT "".    
def var np_idno         AS CHAR FORMAT "x(100)" INIT "".
def var np_covcod1      AS CHAR FORMAT "x(20)"  INIT "".    /*A58-0183 cover type*/
def var np_ncb          AS CHAR FORMAT "x(20)"  INIT "".    /*A58-0183 NCB*/
def var np_deduct       AS CHAR FORMAT "x(20)"  INIT "".    /*A58-0183 */
def var np_drino        AS CHAR FORMAT "x(20)"  INIT "".    /*A58-0183 */
def var np_driverid     AS CHAR FORMAT "x(20)"  INIT "".    /*A58-0183 */
def var np_accessory    AS CHAR FORMAT "x(150)" INIT "".    /*A58-0183 */
def var np_status       AS CHAR FORMAT "x(30)" INIT "".    /*A58-0183 */

DEF VAR nv_agent  AS CHAR FORMAT "x(15)" INIT "".
DEF var ut_net    as deci  init 0.
def var ut_stamp  as deci  init 0.
def var ut_vat    as deci  init 0.
def var ut_tax    as deci  init 0.
DEF var n_taxp    as deci  init 0.
def var ut_total  as deci  init 0.
DEF Var nv_fptr   As RECID   Initial    0.
DEF Var nv_bptr   As RECID   Initial    0.
DEF VAR nv_txt5   AS CHAR FORMAT "x(250)".

DEF VAR nv_oldpol  AS CHAR FORMAT "x(15)" INIT "".
DEF VAR nv_output   AS CHAR FORMAT "x(60)" INIT "".

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_loadname bu_file-3 fi_outload bu_ok ~
bu_exit-2 fi_year RECT-381 RECT-382 RECT-383 
&Scoped-Define DISPLAYED-OBJECTS fi_loadname fi_outload fi_year 

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
     SIZE 60 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_outload AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_year AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 11 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE RECTANGLE RECT-381
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 105 BY 7.38
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
     fi_loadname AT ROW 5.1 COL 23.17 COLON-ALIGNED NO-LABEL
     bu_file-3 AT ROW 5.14 COL 86.17
     fi_outload AT ROW 6.24 COL 23.17 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 8.57 COL 85.33
     bu_exit-2 AT ROW 8.57 COL 95.5
     fi_year AT ROW 3.91 COL 35 COLON-ALIGNED NO-LABEL WIDGET-ID 2
     "OUTPUT FILE :" VIEW-AS TEXT
          SIZE 15.17 BY 1 AT ROW 6.19 COL 9.17
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "IMPORT FILE :" VIEW-AS TEXT
          SIZE 15 BY 1 AT ROW 5.1 COL 9.33
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "   CHECK DATA POST DOCUMENT ON LOTUS NOTE" VIEW-AS TEXT
          SIZE 105 BY 2.14 AT ROW 1.1 COL 1.17
          BGCOLOR 1 FGCOLOR 7 FONT 2
     "** ใช้ไฟล์ Load  ในการ Match หาเลข ปณ. ในกล่อง Post Document **" VIEW-AS TEXT
          SIZE 64.17 BY 1 AT ROW 7.67 COL 19.33
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "POST DOCUMENT YEAR :" VIEW-AS TEXT
          SIZE 26.5 BY 1 AT ROW 3.91 COL 9.5 WIDGET-ID 4
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "** ปีของกล่อง Post Document **" VIEW-AS TEXT
          SIZE 29 BY 1 AT ROW 3.86 COL 56.5 WIDGET-ID 6
          BGCOLOR 19 FGCOLOR 6 
     RECT-381 AT ROW 3.33 COL 1.17
     RECT-382 AT ROW 8.14 COL 94.17
     RECT-383 AT ROW 8.14 COL 84.17
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
         TITLE              = "Match text  File Policy (SCB RENEW)"
         HEIGHT             = 9.95
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
       bu_file-3:AUTO-RESIZE IN FRAME fr_main      = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Match text  File Policy (SCB RENEW) */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Match text  File Policy (SCB RENEW) */
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
       ASSIGN fi_outload   = SUBSTR(fi_loadname,1,R-INDEX(fi_loadname,".") - 1 ) + "_Document" + NO_add.
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
        

    For each  wdetail:
        DELETE  wdetail.
    END.
    IF fi_outload = "" THEN DO:
        MESSAGE "File name output not Empty..!!!" SKIP
            "Insert file name Output file...!!!"      VIEW-AS ALERT-BOX.
        APPLY "Entry" TO fi_outload.
        RETURN NO-APPLY.
    END.
    RUN proc_matpol.   /* กรมธรรม์ */
    MESSAGE "Export File Complete " VIEW-AS ALERT-BOX.
   
   
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


&Scoped-define SELF-NAME fi_year
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_year C-Win
ON LEAVE OF fi_year IN FRAME fr_main
DO:
    fi_year = INPUT fi_year .
    DISP fi_year WITH FRAME fr_main.
  
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
  ASSIGN fi_year = string(YEAR(TODAY),"9999") 
     gv_prgid = "WGWMTSCBR"
     gv_prog  = "Match Text File Policy Send To SCBRE".
  
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).
  DISP fi_year WITH FRAME fr_main.
  
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
  DISPLAY fi_loadname fi_outload fi_year 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_loadname bu_file-3 fi_outload bu_ok bu_exit-2 fi_year RECT-381 
         RECT-382 RECT-383 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cleardata C-Win 
PROCEDURE proc_cleardata :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN  np_dano        = " "       
        np_datenoti    = " "       
        np_namenoti    = " "       
        np_company     = " "       
        np_insname     = " "       
        np_prepol      = " "       
        np_brsty       = " "       
        np_cartyp      = " "       
        np_brandmodel  = " "       
        np_caryear     = " "       
        np_vehreg      = " "       
        np_provin      = " "       
        np_engcc       = " "       
        np_tons        = " "       
        np_chassis     = " "       
        np_engno       = " "       
        np_covcod      = " "       
        np_covcod1     = " "       
        np_ncb         = " "       
        np_deduct      = " "       
        np_drino       = " "       
        np_driverid    = " "       
        np_accessory   = " "       
        np_comdate     = " "       
        np_premium     = " "       
        np_sumins      = " "       
        np_garage      = " "       
        np_comdatecomp = " "       
        np_compprem    = " "       
        np_stkno       = " "       
        np_status      = " "       
        np_idno        = " "       
        np_sendfile    = " "       
        np_cedpol      = " "       
        np_addr1       = " "       
        np_addr2       = " "       
        np_addr3       = " "       
        np_addr4       = " "       
        np_addr5       = " "       
        np_memo        = " "  .  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_exportnote C-Win 
PROCEDURE proc_exportnote :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR chNotesSession  As Com-Handle.
DEF VAR chNotesDataBase As Com-Handle.
DEF VAR chDocument      As Com-Handle.
DEF VAR chNotesView     As Com-Handle .
DEF VAR chDocument1     As Com-Handle.
DEF VAR chNotesView1    As Com-Handle .
DEF VAR chnotecollection    AS COM-HANDLE.
DEF VAR chItem          As Com-Handle .
DEF VAR chData          As Com-Handle .
DEF VAR nv_server       As Char.
DEF VAR nv_tmp          As char .
DEF VAR nv_extref       as char.
DEF VAR n_year          AS CHAR FORMAT "x(4)" .
DEF VAR n_day           AS CHAR FORMAT "x(15)" .
DEF VAR n_date          AS CHAR FORMAT "99/99/9999".
DEF VAR n_pol           AS CHAR FORMAT "x(13)".
DEF VAR n_ems           AS CHAR FORMAT "x(14)".
DEF VAR nt_name         AS CHAR FORMAT "x(25)".
DEF VAR nt_policyno     AS CHAR FORMAT "x(12)".    
DEF VAR nt_date         AS DATE FORMAT "99/99/9999".     
DEF VAR nt_ems          AS CHAR FORMAT "x(14)".
DEF VAR n_snote         AS CHAR FORMAT "X(25)".

ASSIGN n_day       = trim(fi_year) /*STRING(TODAY,"99/99/9999")*/
       n_year      = SUBSTR(n_day,3,2)
       n_snote     = "postdocument" + n_year + ".nsf"
       n_pol        = ""
       n_pol        = sicuw.uwm100.policy      
       nt_policyno  = ""                 
       nt_ems       = ""                 
       n_ems        = ""
       n_date       = ""
       nt_date      = ?.

       CREATE "Notes.NotesSession"  chNotesSession. 
       /*--------- Lotus Server Real ----------*/
       nv_tmp    = "safety\fi\" + n_snote.
       chNotesDatabase = chNotesSession:GetDatabase ("Safety_NotesServer/Safety",nv_tmp).
       /*-------------------------------------*/
       /*--------- Lotus Server test ----------
       nv_tmp    = "D:\Lotus\Notes\Data\" + n_snote.
       chNotesDatabase = chNotesSession:GetDatabase ("",nv_tmp).
       -------------------------------*/
       IF chNotesDatabase:IsOpen() = NO  THEN  DO:
          MESSAGE "Can not open database" SKIP  
                  "Please Check database and serve" VIEW-AS  ALERT-BOX ERROR.
       END.
       ELSE DO:
            chNotesView = chNotesDatabase:GetView("ByPol").
            chnotecollection = chNotesView:GetallDocumentsByKey(n_pol).
            chDocument  =  chnotecollection:GetlastDocument.
            IF VALID-HANDLE(chDocument) = YES THEN DO:
                 
                 chitem       = chDocument:Getfirstitem("PolicyNo"). 
                 nt_policyno  = chitem:TEXT.                      
                 chitem       = chDocument:Getfirstitem("EmsNo").     
                 nt_ems       = chitem:TEXT.
                 chitem       = chDocument:Getfirstitem("Date").     
                 nt_date      = chitem:TEXT.   
            END.
       END.
          
       IF nt_ems <> "" THEN DO:
           ASSIGN wdetail.emsno       = TRIM(nt_ems)
                  wdetail.senddate    = STRING(YEAR(nt_date),"9999") + "/" + 
                                        STRING(MONTH(nt_date),"99") + "/" +
                                        STRING(DAY(nt_date),"99") .
       END.
       ELSE DO: 
           ASSIGN wdetail.emsno    = "-" 
                  wdetail.senddate = "-"  .
       END.
      
      RELEASE  OBJECT chNotesSession NO-ERROR.  
      RELEASE  OBJECT chNotesDataBase NO-ERROR. 
      RELEASE  OBJECT chDocument NO-ERROR.      
      RELEASE  OBJECT chNotesView NO-ERROR.     
      RELEASE  OBJECT chDocument1 NO-ERROR.     
      RELEASE  OBJECT chNotesView1 NO-ERROR.    
      RELEASE  OBJECT chnotecollection NO-ERROR.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matpol C-Win 
PROCEDURE proc_matpol :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

FOR EACH  wdetail :
    DELETE wdetail.
END.
RUN Proc_Cleardata.
INPUT FROM VALUE(fi_loadName).
REPEAT:
    IMPORT DELIMITER "|"
        np_dano             /*ลำดับที่ */                              
        np_datenoti         /*วันที่   */                              
        np_namenoti         /*ชื่อเจ้าหน้าที่ผู้แจ้งประกันภัย*/        
        np_company          /*ชื่อบริษัท         */                    
        np_insname          /*ชื่อผู้เอาประกัน   */                    
        np_prepol           /*กรมธรรม์เดิม       */                    
        np_cartyp           /*ประเภทรถ           */                    
        np_brandmodel       /*ยี่ห้อรถ/รุ่น      */                    
        np_caryear          /*ปีรุ่น             */                    
        np_vehreg           /*ทะเบียนรถ          */                    
        np_provin           /*จังหวัด            */                    
        np_engcc            /*ขนาด               */                    
        np_tons             /*น้ำหนัก            */                    
        np_chassis          /*เลขตัวถัง          */                    
        np_engno            /*เลขเครื่องยนต์     */                    
        np_covcod           /*ประเภทการประกันภัย */                    
        np_comdate          /*วันที่คุ้มครอง     */                    
        np_premium          /*ค่าเบี้ยประกันภัย  */                    
        np_sumins           /*ทุนประกัน          */                    
        np_garage           /*สถานที่ซ่อม        */                    
        np_covcod1          /*ประเภท             */                    
        np_ncb              /*%NCB               */                    
        np_deduct           /*ค่าเสียหายส่วนแรก  */                    
        np_drino            /*ระบุผู้ขับขี่      */                    
        np_driverid         /*เลขบัตรใบขับขี่    */                    
        np_accessory        /*อุปกรณ์เพิ่มเติม   */                    
        np_comdatecomp      /*วันคุ้มครองพรบ.    */                    
        np_compprem         /*ค่าเบี้ยพรบ.       */                    
        np_status           /*Status             */                    
        np_idno             /*ID                 */                    
        np_sendfile         /*เวลาส่งงาน         */                    
        np_cedpol           /*เลขที่สัญญา        */                    
        np_addr1            /*ที่อยู่ในการส่งเอกสาร */                 
        np_addr2            /*ที่อยู่ในการส่งเอกสาร */                 
        np_addr3            /*ที่อยู่ในการส่งเอกสาร */                 
        np_addr4            /*ที่อยู่ในการส่งเอกสาร */                 
        np_addr5            /*ที่อยู่ในการส่งเอกสาร */                 
        np_memo   .         /*remark*/                                 
        
       IF np_dano  = "" THEN  NEXT.
       ELSE IF index(np_dano,"ลำดับ") <> 0 THEN NEXT.
       ELSE DO:
           IF DECI(np_premium) <> 0 THEN DO:
             CREATE wdetail.
             ASSIGN   wdetail.num           = 0
                      wdetail.account       = TRIM(np_cedpol) 
                      wdetail.InsuredName   = trim(np_insname)                
                      wdetail.stk           = ""  
                      wdetail.PolicyNo      = ""
                      wdetail.EffectiveDate = ""
                      wdetail.ExpireDate    = ""
                      wdetail.GrossPremium  = ""
                      wdetail.PremiumRecord = ""
                      wdetail.NetPremium    = ""
                      wdetail.senddate      = ""
                      wdetail.emsno         = ""
                      wdetail.remark        = ""
                      wdetail.poltyp        = "V70".
           END.
           IF DECI(np_compprem) <> 0 THEN DO:
               CREATE wdetail.
               ASSIGN   
                      wdetail.num           = 0
                      wdetail.account       = TRIM(np_cedpol) 
                      wdetail.InsuredName   = trim(np_insname)                
                      wdetail.stk           = ""  
                      wdetail.PolicyNo      = ""
                      wdetail.EffectiveDate = ""
                      wdetail.ExpireDate    = ""
                      wdetail.GrossPremium  = ""
                      wdetail.PremiumRecord = ""
                      wdetail.NetPremium    = ""
                      wdetail.senddate      = ""
                      wdetail.emsno         = ""
                      wdetail.remark        = ""
                      wdetail.poltyp        = "V72".
           END.

           RUN proc_cleardata.
       END.
END.  /* repeat  */ 
/* หากรมธรรม์จากไฟล์แจ้งงาน */
FOR EACH wdetail .
    IF TRIM(wdetail.account) = "" THEN DELETE wdetail.
    ELSE DO:
        ASSIGN n_taxp = 0       ut_net = 0      ut_stamp = 0        ut_vat = 0      ut_total = 0 .

        FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE sicuw.uwm100.cedpol = trim(wdetail.account) AND 
                  sicuw.uwm100.poltyp =  wdetail.poltyp  NO-LOCK NO-ERROR.
        IF AVAIL uwm100 THEN DO:
            /*IF uwm100.releas = NO THEN NEXT.*/
            ASSIGN  wdetail.policyno       = sicuw.uwm100.policy
                    wdetail.EffectiveDate  = STRING(YEAR(sicuw.uwm100.comdat),"9999") + "/" +
                                             STRING(MONTH(sicuw.uwm100.comdat),"99") + "/" +
                                             STRING(DAY(sicuw.uwm100.comdat),"99") 
                    wdetail.ExpireDate     = STRING(YEAR(sicuw.uwm100.expdat),"9999") + "/" +
                                             STRING(MONTH(sicuw.uwm100.expdat),"99") + "/" +
                                             STRING(DAY(sicuw.uwm100.expdat),"99") .
        
                FIND FIRST sicuw.uwm130 USE-INDEX uwm13001 WHERE
                    sicuw.uwm130.policy = uwm100.policy  AND
                    sicuw.uwm130.rencnt = uwm100.rencnt AND   
                    sicuw.uwm130.endcnt = uwm100.endcnt AND 
                    sicuw.uwm130.riskgp = 0             AND
                    sicuw.uwm130.riskno = 1             AND
                    sicuw.uwm130.itemno = 1             NO-LOCK NO-ERROR.
        
                IF AVAIL uwm130 THEN DO:
                    FOR EACH sicuw.uwd132 USE-INDEX uwd13290 WHERE 
                             sicuw.uwd132.policy = sicuw.uwm130.policy AND
                             sicuw.uwd132.rencnt = sicuw.uwm130.rencnt AND
                             sicuw.uwd132.endcnt = sicuw.uwm130.endcnt AND
                             sicuw.uwd132.riskgp = sicuw.uwm130.riskgp AND
                             sicuw.uwd132.riskno = sicuw.uwm130.riskno AND
                             sicuw.uwd132.itemno = sicuw.uwm130.itemno NO-LOCK .
                             
                              ASSIGN ut_net   = ut_net + uwd132.prem_c
                                     ut_stamp = (ut_net) * 0.4 / 100.
                             
                                     IF ut_stamp - TRUNCATE(ut_stamp,0) > 0 THEN ut_stamp = TRUNCATE(ut_stamp,0) + 1.
                                     ut_vat   = (ut_net + ut_stamp) * 7 / 100.
                                     ut_total = ut_net  + ut_stamp + ut_vat.
                    END.
                    ASSIGN wdetail.NetPremium   =  string(ut_net,">>>,>>>,>>9.99")
                           /*wdetail.VatTax       =  string(ut_vat,">>,>>9.99")
                           wdetail.Stamp        =  string(ut_stamp,">,>>9.99")*/
                           wdetail.GrossPremium =  string(ut_total,">>>,>>>,>>9.99") 
                           wdetail.PremiumRecord = string(ut_total,">>>,>>>,>>9.99") .

                    IF sicuw.uwm100.poltyp = "V72" THEN DO:
                        FIND FIRST stat.Detaitem USE-INDEX detaitem01 WHERE
                                   stat.Detaitem.Policy = sicuw.uwm130.Policy AND
                                   stat.Detaitem.RenCnt = sicuw.uwm130.RenCnt AND
                                   stat.Detaitem.EndCnt = sicuw.uwm130.Endcnt AND
                                   stat.Detaitem.RiskNo = sicuw.uwm130.RiskNo AND
                                   stat.Detaitem.ItemNo = sicuw.uwm130.ItemNo NO-LOCK NO-ERROR .
                        IF AVAIL Detaitem THEN DO:
                            ASSIGN wdetail.stk   = stat.Detaitem.serailno.
                             FIND LAST brstat.tlt  WHERE  
                               brstat.tlt.genusr    = "SCBRE"    AND
                               brstat.tlt.safe2     = TRIM(wdetail.account)   AND
                               brstat.tlt.comp_pol  = sicuw.uwm100.policy NO-ERROR NO-WAIT .
                               IF AVAIL tlt THEN  ASSIGN brstat.tlt.comp_sck  = stat.Detaitem.serailno.
                        END.
                    END.
               END. /* end uwm130*/
               RUN proc_exportnote.
        END. /* end uwm100*/
        ELSE DO:
            ASSIGN wdetail.num           = 0                 
                   wdetail.account       = ""
                   wdetail.InsuredName   = ""
                   wdetail.stk           = ""                
                   wdetail.PolicyNo      = ""                
                   wdetail.EffectiveDate = ""                
                   wdetail.ExpireDate    = ""                
                   wdetail.GrossPremium  = ""                
                   wdetail.PremiumRecord = ""                
                   wdetail.NetPremium    = ""                
                   wdetail.senddate      = ""                
                   wdetail.emsno         = ""                
                   wdetail.remark        = ""                
                   wdetail.poltyp        = "V72".   
        END.
        RELEASE uwm100.
        RELEASE uwm130.
        RELEASE uwd132.
    END.
END.
RELEASE wdetail.

RELEASE sicuw.uwm100.
RELEASE sicuw.uwm130.
RELEASE sicuw.uwd132.
RELEASE stat.Detaitem.

RUN pro_reportpolicy.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_reportpolicy C-Win 
PROCEDURE Pro_reportpolicy :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_count AS INT INIT 0.
DEF VAR pol72 AS CHAR FORMAT "x(12)" INIT "" .   /*A56-0323*/
If  substr(fi_outload,length(fi_outload) - 3,4) <>  ".slk"  THEN 
    fi_outload  =  Trim(fi_outload) + ".slk"  .
/*ASSIGN nv_cnt =  0
    nv_row  =  1.*/
OUTPUT TO VALUE(fi_outload).
EXPORT DELIMITER "|" 
     "No       "                 
     "Account  "                 
     "ชื่อผู้เอาประกัน "         
     "เลขตารางพรบ./เลขสติกเกอร์" 
     "POLICY NO      "           
     "Effective Date "           
     "Expire Date    "           
     "Gross Premium  "           
     "Premium Record "           
     "Net Premium    "           
     "วันที่จัดส่งเอกสาร"          
     "เลขลงทะเบียน    "          
     "Remark          " .

FOR EACH wdetail WHERE wdetail.policyno <> "" no-lock.
    n_count = n_count + 1.
  EXPORT DELIMITER "|" 
      n_count                
      wdetail.account                                                               
      wdetail.InsuredName                                                           
      wdetail.stk                                                                   
      wdetail.PolicyNo             
      wdetail.EffectiveDate
      wdetail.ExpireDate       
      wdetail.GrossPremium                                                                  
      wdetail.PremiumRecord                                                                 
      wdetail.NetPremium           
      wdetail.senddate                                                                      
      wdetail.emsno                                                                         
      wdetail.remark  .    
END.                                
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

