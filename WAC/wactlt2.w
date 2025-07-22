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
program id   :  wuwtstex.w
  program name :  Load text file HCT to excel file     
  create by    :  Kridtiya i. A52-0172  21/07/2009    
  copy write   : wuwnotex.w                                             */
/*Modify by    : Kridtiya i. A53-0027  15/01/2010
                 ปรับโปรแกรมให้เช็คค่า field branch ที่table insure จากเดิม
                 เป็นการให้ค่าแบบตรงจาก โปรแกรม-------------------------*/
/*modify by   : Kridtiya i. A53-0156 date . 19/04/2010  
             เปลี่ยนชื่อบริษัทจากและ / หรือ บริษัท ไทยออโต้เซลส์ จำกัด 
             เป็น และ/ หรือ บริษัท ตรีเพชรอีซูซุลิสซิ่ง จำกัด เปลี่ยน TAS เห็น TIL */
/************************************************************************/
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

DEFINE NEW SHARED WORKFILE wdetail NO-UNDO
    FIELD head              AS CHAR   FORMAT "X(4)"    
    FIELD n_binloop         AS CHAR   FORMAT "x(2)"    
    FIELD fi_bindate        AS CHAR   FORMAT "x(8)"    
    FIELD wRecordno         AS CHAR   FORMAT "x(6)"    
    FIELD wjob_nr           AS CHAR   FORMAT "X"       
    FIELD wnorpol           AS CHAR   FORMAT "X(25)"   
    FIELD wpol72            AS CHAR   FORMAT "X(25)"   
    FIELD winsure           AS CHAR   FORMAT "X(60)"   
    FIELD wcha_no           AS CHAR   FORMAT "X(20)"   
    FIELD wengine           AS CHAR   FORMAT "X(20)"   
    FIELD wnor_comdat       AS CHAR   FORMAT "x(8)"    
    FIELD wnor_expdat       AS CHAR   FORMAT "x(8)"    
    FIELD wnor_covamt       AS CHAR   FORMAT "X(10)"   
    FIELD wcomp_covamt      AS CHAR   FORMAT "X(10)"   
    FIELD wNetPrem          AS CHAR   FORMAT "X(10)"   
    FIELD wCompNetPrem      AS CHAR   FORMAT "X(10)"   
    FIELD wgrossprem        AS CHAR   FORMAT "X(10)"   
    FIELD wCompGrossPrem    AS CHAR   FORMAT "X(10)"   
    FIELD wtotal_prm        AS CHAR   FORMAT "X(10)"   
    FIELD wnor_comm         AS CHAR   FORMAT "X(10)"   
    FIELD wcomp_comm        AS CHAR   FORMAT "X(10)"   
    FIELD wnor_vat          AS CHAR   FORMAT "X(10)"   
    FIELD wcomp_vat         AS CHAR   FORMAT "X(10)"   
    FIELD wnor_tax3         AS CHAR   FORMAT "X(10)"  
    FIELD wcomp_tax3        AS CHAR   FORMAT "X(10)"   
    FIELD wNetPayment       AS CHAR   FORMAT "X(10)"  
    FIELD wsubins           AS CHAR   FORMAT "X(4)"    
    FIELD wcomp_sub         AS CHAR   FORMAT "X(4)"    
    FIELD wcomp_comdat      AS CHAR   FORMAT "x(8)"    
    FIELD wcomp_expdat      AS CHAR   FORMAT "x(8)"    
    FIELD wremark           AS CHAR   FORMAT "X(49)"  .
    
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

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_filename fi_outfile bu_ok bu_file bu_exit ~
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
     SIZE 3.5 BY 1.05.

DEFINE BUTTON bu_ok 
     LABEL "Ok" 
     SIZE 7.5 BY 1.05
     FONT 6.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 33 BY 1.05
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_outfile AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 36.5 BY 1.05
     BGCOLOR 15  NO-UNDO.

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
     fi_filename AT ROW 3.1 COL 26.5 COLON-ALIGNED NO-LABEL
     fi_outfile AT ROW 4.57 COL 26.5 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 6.43 COL 47.5
     bu_file AT ROW 3.1 COL 61.5
     bu_exit AT ROW 6.38 COL 55.5
     "Text file excel (TLT)  :":30 VIEW-AS TEXT
          SIZE 22 BY 1.05 AT ROW 3.1 COL 5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "  CONVERT EXCEL FILE TO TEXT FILE":30 VIEW-AS TEXT
          SIZE 42 BY 1.05 AT ROW 1.71 COL 15.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Output to Text file  :" VIEW-AS TEXT
          SIZE 23 BY 1.05 AT ROW 4.57 COL 5.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     RECT-76 AT ROW 1.52 COL 3
     RECT-77 AT ROW 6.14 COL 45
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 69.5 BY 7.76
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
         TITLE              = "<insert window title>"
         HEIGHT             = 7.76
         WIDTH              = 69.5
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
ON END-ERROR OF C-Win /* <insert window title> */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* <insert window title> */
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
        FILTERS    "Text .csv" "*.csv" ,
                   "Text .slk" "*.slk" ,
                   "Text file" "*"
                   
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
    For each  wdetail :
        DELETE  wdetail.
    End.
    INPUT FROM VALUE(fi_FileName).
    REPEAT:
        CREATE wdetail.
        IMPORT DELIMITER "," 
            wdetail.head                 
            wdetail.n_binloop 
            wdetail.fi_bindate              
            wdetail.wRecordno            
            wdetail.wjob_nr              
            wdetail.wnorpol              
            wdetail.wpol72               
            wdetail.winsure              
            wdetail.wcha_no              
            wdetail.wengine              
            wdetail.wnor_comdat          
            wdetail.wnor_expdat          
            wdetail.wnor_covamt          
            wdetail.wcomp_covamt    
            wdetail.wNetPrem        
            wdetail.wCompNetPrem    
            wdetail.wgrossprem      
            wdetail.wCompGrossPrem  
            wdetail.wtotal_prm      
            wdetail.wnor_comm       
            wdetail.wcomp_comm      
            wdetail.wnor_vat        
            wdetail.wcomp_vat       
            wdetail.wnor_tax3       
            wdetail.wcomp_tax3      
            wdetail.wNetPayment     
            wdetail.wsubins         
            wdetail.wcomp_sub       
            wdetail.wcomp_comdat    
            wdetail.wcomp_expdat    
            wdetail.wremark  .      
            
END.  /* repeat  */
Run  Pro_createfile.
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


&Scoped-define SELF-NAME fi_outfile
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outfile C-Win
ON LEAVE OF fi_outfile IN FRAME fr_main
DO:
  fi_outfile  =  Input  fi_outfile.
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
  
  gv_prgid = "wactlt2".
  gv_prog  = "Convert Excel File TLT to Text file ".
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
  ENABLE fi_filename fi_outfile bu_ok bu_file bu_exit RECT-76 RECT-77 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_createfile C-Win 
PROCEDURE Pro_createfile :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".txt"  Then
    fi_outfile  =  Trim(fi_outfile) + ".txt"  .
ASSIGN
   
nv_cnt   =   0
nv_row  =  1.
OUTPUT STREAM ns2 TO VALUE(fi_outfile).
FOR EACH wdetail WHERE wdetail.head <> "" NO-LOCK.
    IF (wdetail.head = "") OR (index(wdetail.head,"head") <> 0) THEN NEXT.
    PUT STREAM  ns2
        wdetail.head             FORMAT "X(4)"          
        string(deci(wdetail.n_binloop),"99")       FORMAT "x(2)"                       
        wdetail.fi_bindate       FORMAT "x(8)"           
        string(deci(wdetail.wRecordno),"999999")       FORMAT "999999"        
        wdetail.wjob_nr          FORMAT "X"           
        wdetail.wnorpol          FORMAT "X(25)"       
        wdetail.wpol72           FORMAT "X(25)"       
        wdetail.winsure          FORMAT "X(60)"       
        wdetail.wcha_no          FORMAT "X(20)"       
        wdetail.wengine          FORMAT "X(20)"       
        wdetail.wnor_comdat      FORMAT "x(8)"        
        wdetail.wnor_expdat      FORMAT "x(8)" 
        string(deci(wdetail.wnor_covamt) * 100 ,"9999999999")       FORMAT "9999999999" 
        string(deci(wdetail.wcomp_covamt) * 100 ,"9999999999")      FORMAT "9999999999" 
        string(deci(wdetail.wNetPrem) * 100 ,"9999999999")          FORMAT "9999999999" 
        string(deci(wdetail.wCompNetPrem) * 100 ,"9999999999")      FORMAT "9999999999" 
        string(deci(wdetail.wgrossprem) * 100 ,"9999999999")        FORMAT "9999999999" 
        string(deci(wdetail.wCompGrossPrem) * 100 ,"9999999999")    FORMAT "9999999999" 
        string(deci(wdetail.wtotal_prm) * 100 ,"9999999999")        FORMAT "9999999999" 
        string(deci(wdetail.wnor_comm) * 100 ,"9999999999")         FORMAT "9999999999" 
        string(deci(wdetail.wcomp_comm) * 100 ,"9999999999")        FORMAT "9999999999" 
        string(deci(wdetail.wnor_vat) * 100 ,"9999999999")          FORMAT "9999999999" 
        string(deci(wdetail.wcomp_vat) * 100 ,"9999999999")         FORMAT "9999999999" 
        string(deci(wdetail.wnor_tax3) * 100 ,"9999999999")         FORMAT "9999999999" 
        string(deci(wdetail.wcomp_tax3) * 100 ,"9999999999")        FORMAT "9999999999" 
        string(deci(wdetail.wNetPayment) * 100 ,"9999999999")       FORMAT "9999999999" 
        wdetail.wsubins          FORMAT "x(4)" 
        wdetail.wcomp_sub        FORMAT "x(4)" 
        wdetail.wcomp_comdat     FORMAT "x(8)"  
        wdetail.wcomp_expdat     FORMAT "x(8)"  
        wdetail.wremark          FORMAT "X(49)" 
                SKIP.
    
END.
OUTPUT STREAM ns2 CLOSE.
message "Export File  Complete"  view-as alert-box.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

