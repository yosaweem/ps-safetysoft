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
  program id    :  wgwtseds.w
  program name :  Export Text file Endorsement    
  create by    :  Kridtiya i. A57-0417 17/11/2014  */
/************************************************************************/
CREATE WIDGET-POOL.
/* ***************************  Definitions  ************************** */
/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

def  stream  ns2.                                                                 
DEFINE NEW SHARED TEMP-TABLE wdetail
    FIELD ID                 AS CHAR FORMAT "x(10)"   INIT ""     /*  ID              */
    FIELD TAS_RCV_DAY        AS CHAR FORMAT "x(10)"   INIT ""     /*  TAS_RCV_DAY     */
    FIELD TAS_RCV_MONTH      AS CHAR FORMAT "x(10)"   INIT ""     /*  TAS_RCV_MONTH   */
    FIELD TAS_RCV_YEAR       AS CHAR FORMAT "x(10)"   INIT ""     /*  TAS_RCV_YEAR    */
    FIELD TAS_RUN_NO         AS CHAR FORMAT "x(10)"   INIT ""     /*  TAS_RUN_NO      */
    FIELD TAS_RCV_BY         AS CHAR FORMAT "x(25)"   INIT ""     /*  TAS_RCV_BY      */
    FIELD INSURACE_COM1      AS CHAR FORMAT "x(20)"   INIT ""     /*  INSURACE_COM1   */
    FIELD INS_REF_NO         AS CHAR FORMAT "x(20)"   INIT ""     /*  INS_REF_NO      */
    FIELD INF_INS_DAY        AS CHAR FORMAT "x(10)"   INIT ""     /*  INF_INS_DAY     */
    FIELD INF_INS_MONTH      AS CHAR FORMAT "x(10)"   INIT ""     /*  INF_INS_MONTH   */
    FIELD INF_INS_YEAR       AS CHAR FORMAT "x(10)"   INIT ""     /*  INF_INS_YEAR    */  
    FIELD CUST_FNM           AS CHAR FORMAT "x(50)"   INIT ""     /*  CUST_FNM        */
    FIELD CUST_LNM           AS CHAR FORMAT "x(50)"   INIT ""     /*  CUST_LNM        */
    FIELD ID_NUM             AS CHAR FORMAT "x(20)"   INIT ""     /*  ID_NUM          */
    FIELD ADDRESS1           AS CHAR FORMAT "x(35)"   INIT ""     /*  ADDRESS1        */
    FIELD ADDRESS2           AS CHAR FORMAT "x(35)"   INIT ""     /*  ADDRESS2        */
    FIELD SOI                AS CHAR FORMAT "x(35)"   INIT ""     /*  SOI             */
    FIELD ROAD               AS CHAR FORMAT "x(35)"   INIT ""     /*  ROAD            */  
    FIELD SUB_DISTRICT       AS CHAR FORMAT "x(30)"   INIT ""     /*  SUB_DISTRICT    */
    FIELD DISTRICT           AS CHAR FORMAT "x(30)"   INIT ""     /*  DISTRICT        */
    FIELD PROVINCE           AS CHAR FORMAT "x(30)"   INIT ""     /*  PROVINCE        */
    FIELD ZIP_CD             AS CHAR FORMAT "x(10)"   INIT ""     /*  ZIP_CD          */
    FIELD TELEPHONE          AS CHAR FORMAT "x(20)"   INIT ""     /*  TELEPHONE       */
    FIELD SALES_MODEL        AS CHAR FORMAT "x(50)"   INIT ""     /*  SALES_MODEL     */
    FIELD USAGE_TYPE         AS CHAR FORMAT "x(30)"   INIT ""     /*  USAGE_TYPE      */
    FIELD COLOR_THAI         AS CHAR FORMAT "x(30)"   INIT ""     /*  COLOR_THAI      */
    FIELD CC                 AS CHAR FORMAT "x(10)"   INIT ""     /*  CC              */
    FIELD EGN_NO             AS CHAR FORMAT "x(30)"   INIT ""     /*  EGN_NO          */
    FIELD CHASSIS_NO         AS CHAR FORMAT "x(30)"   INIT ""     /*  CHASSIS_NO      */
    FIELD INSURANCE_COM2     AS CHAR FORMAT "x(10)"   INIT ""     /*  INSURANCE_COM2  */
    FIELD COVER_INS_DAY      AS CHAR FORMAT "x(10)"   INIT ""     /*  COVER_INS_DAY   */
    FIELD COVER_INS_MONTH    AS CHAR FORMAT "x(10)"   INIT ""     /*  COVER_INS_MONTH */
    FIELD COVER_INS_YEAR     AS CHAR FORMAT "x(10)"   INIT ""     /*  COVER_INS_YEAR  */
    FIELD INS_FUND           AS CHAR FORMAT "x(20)"   INIT ""     /*  INS_FUND        */
    FIELD INS_FEE            AS CHAR FORMAT "x(20)"   INIT ""     /*  INS_FEE         */
    FIELD INS_NO             AS CHAR FORMAT "x(20)"   INIT ""     /*  INS_NO          */
    FIELD TIS_DEALER         AS CHAR FORMAT "x(80)"   INIT ""     /*  TIS_DEALER      */
    FIELD SHOWROOM           AS CHAR FORMAT "x(30)"   INIT ""     /*  SHOWROOM        */
    FIELD PURCHASE_TYPE      AS CHAR FORMAT "x(20)"   INIT ""     /*  PURCHASE_TYPE   */
    FIELD FINANCE_COMP       AS CHAR FORMAT "x(20)"   INIT ""     /*  FINANCE_COMP    */
    FIELD INF_FNM            AS CHAR FORMAT "x(50)"   INIT ""     /*  INF_FNM         */
    FIELD INF_LNM            AS CHAR FORMAT "x(50)"   INIT ""     /*  INF_LNM         */
    FIELD INF_PHONE          AS CHAR FORMAT "x(20)"   INIT ""     /*  INF_PHONE       */
    FIELD INF_POSITION       AS CHAR FORMAT "x(30)"   INIT ""     /*  INF_POSITION    */
    FIELD INF_REMARK         AS CHAR FORMAT "x(100)"  INIT ""     /*  INF_REMARK      */
    FIELD CHECK_ENG          AS CHAR FORMAT "x(10)"   INIT ""     /*  CHECK_ENG       */
    FIELD REC_STATUS         AS CHAR FORMAT "x(20)"   INIT ""     /*  REC_STATUS      */
    FIELD MDF_DTE            AS CHAR FORMAT "x(10)"   INIT ""     /*  MDF_DTE         */  
    FIELD MDF_RCV_DTE        AS CHAR FORMAT "x(10)"   INIT ""     /*  MDF_RCV_DTE     */
    FIELD MDF_RCV_RMK        AS CHAR FORMAT "x(80)"   INIT ""     /*  MDF_RCV_RMK     */
    FIELD IN_pol70           AS CHAR FORMAT "x(16)"   INIT ""     
    FIELD IN_pol72           AS CHAR FORMAT "x(16)"   INIT ""     
    FIELD MDF_RCV_RMK_thai   AS CHAR FORMAT "x(80)"   INIT ""     /*  MDF_RCV_RMK_thai     */
    FIELD MDF_updata         AS CHAR FORMAT "x(100)"  INIT "".    /*  MDF_RCV_RMK_thai     */
def var nv_row   as  int  init 0.

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
     SIZE 63 BY 1.05
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_outfile AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 67 BY 1.05
     BGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-76
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 94 BY 8.33
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-77
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 19.5 BY 1.57
     BGCOLOR 1 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_filename AT ROW 3.76 COL 22.83 COLON-ALIGNED NO-LABEL
     fi_outfile AT ROW 5.29 COL 22.83 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 6.95 COL 73
     bu_file AT ROW 3.76 COL 88.5
     bu_exit AT ROW 6.95 COL 83
     "               Input File :":30 VIEW-AS TEXT
          SIZE 21.67 BY 1.05 AT ROW 3.76 COL 3
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Output to excel(.slk)  :" VIEW-AS TEXT
          SIZE 21.67 BY 1.05 AT ROW 5.29 COL 3
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "                                          Export Text file Endorsement" VIEW-AS TEXT
          SIZE 89.17 BY 1.43 AT ROW 2 COL 3
          BGCOLOR 18 FGCOLOR 1 FONT 6
     RECT-76 AT ROW 1 COL 1
     RECT-77 AT ROW 6.71 COL 72
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 94.5 BY 8.48
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
         TITLE              = "Export FILE Endorsement [ตรีเพชรอีซูซุ] to Excel file"
         HEIGHT             = 8.48
         WIDTH              = 94.5
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
ON END-ERROR OF C-Win /* Export FILE Endorsement [ตรีเพชรอีซูซุ] to Excel file */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Export FILE Endorsement [ตรีเพชรอีซูซุ] to Excel file */
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
    IF fi_filename = ""  THEN DO:
        MESSAGE "File in put name is Mandatory" VIEW-AS ALERT-BOX .
        APPLY "entry" TO fi_filename.
        RETURN NO-APPLY.
    END.
    IF fi_outfile = ""  THEN DO:
        MESSAGE "File out put name is Mandatory" VIEW-AS ALERT-BOX .
        APPLY "entry" TO fi_outfile.
        RETURN NO-APPLY.
    END.
    For each  wdetail :
        DELETE  wdetail.
    END.
    INPUT FROM VALUE(fi_FileName).
    REPEAT:
        CREATE wdetail.
        IMPORT DELIMITER "|"     
            wdetail.ID             
            wdetail.TAS_RCV_DAY    
            wdetail.TAS_RCV_MONTH  
            wdetail.TAS_RCV_YEAR   
            wdetail.TAS_RUN_NO     
            wdetail.TAS_RCV_BY     
            wdetail.INSURACE_COM1  
            wdetail.INS_REF_NO     
            wdetail.INF_INS_DAY    
            wdetail.INF_INS_MONTH  
            wdetail.INF_INS_YEAR   
            wdetail.CUST_FNM       
            wdetail.CUST_LNM       
            wdetail.ID_NUM         
            wdetail.ADDRESS1       
            wdetail.ADDRESS2       
            wdetail.SOI            
            wdetail.ROAD           
            wdetail.SUB_DISTRICT   
            wdetail.DISTRICT       
            wdetail.PROVINCE       
            wdetail.ZIP_CD         
            wdetail.TELEPHONE      
            wdetail.SALES_MODEL    
            wdetail.USAGE_TYPE     
            wdetail.COLOR_THAI     
            wdetail.CC             
            wdetail.EGN_NO         
            wdetail.CHASSIS_NO     
            wdetail.INSURANCE_COM2 
            wdetail.COVER_INS_DAY  
            wdetail.COVER_INS_MONTH
            wdetail.COVER_INS_YEAR 
            wdetail.INS_FUND       
            wdetail.INS_FEE        
            wdetail.INS_NO         
            wdetail.TIS_DEALER     
            wdetail.SHOWROOM       
            wdetail.PURCHASE_TYPE  
            wdetail.FINANCE_COMP   
            wdetail.INF_FNM        
            wdetail.INF_LNM        
            wdetail.INF_PHONE      
            wdetail.INF_POSITION   
            wdetail.INF_REMARK     
            wdetail.CHECK_ENG      
            wdetail.REC_STATUS     
            wdetail.MDF_DTE        
            wdetail.MDF_RCV_DTE    
            wdetail.MDF_RCV_RMK  .
    END.   /* repeat  */
    RUN  Pro_assign.
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
  
  gv_prgid = "wgwtseds".
  gv_prog  = "Export Text file Endorsement ".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).

/*********************************************************************/ 
   RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE).  
  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.
  /*ASSIGN 
      ra_fileout   = 1.
  DISP ra_reptyp ra_fileout WITH FRAM fr_main.*/

  
  
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_assign C-Win 
PROCEDURE Pro_assign :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_name2 AS CHAR FORMAT "x(60)" INIT "".
FOR EACH wdetail.
    ASSIGN nv_name2 = "".
    IF      (trim(wdetail.id)   = "id" ) THEN DELETE wdetail.
    ELSE IF (wdetail.INS_REF_NO = ""   ) THEN DELETE wdetail.
    ELSE DO:
        /*1.find policy by cedpol = wditail.INS_REF_NO */
        FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE 
            sicuw.uwm100.cedpol = trim(wdetail.INS_REF_NO)  AND
            sicuw.uwm100.poltyp = "V70"                     NO-LOCK NO-ERROR.
        IF AVAIL sicuw.uwm100  THEN 
            ASSIGN wdetail.IN_pol70 = sicuw.uwm100.policy 
                   nv_name2         = sicuw.uwm100.name2.
        ELSE ASSIGN wdetail.IN_pol70 = "".

        FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE 
            sicuw.uwm100.cedpol = trim(wdetail.INS_REF_NO) AND
            sicuw.uwm100.poltyp = "V72" NO-LOCK NO-ERROR.
        IF AVAIL sicuw.uwm100  THEN ASSIGN wdetail.IN_pol72 = sicuw.uwm100.policy .
        ELSE ASSIGN wdetail.IN_pol72 = "".
        
        FIND FIRST stat.company USE-INDEX Company01 WHERE 
            stat.company.compno = trim(wdetail.FINANCE_COMP)    NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL  stat.company THEN ASSIGN  wdetail.FINANCE_COMP  =  trim(stat.company.name2).

        IF      trim(wdetail.MDF_RCV_RMK) = "Change insured amount"            THEN 
            ASSIGN 
            wdetail.MDF_RCV_RMK_thai = "แก้ไขทุนประกัน"  
            wdetail.MDF_updata       = wdetail.INS_FUND .
        ELSE IF trim(wdetail.MDF_RCV_RMK) = "Change customer name"             THEN
            ASSIGN 
            wdetail.MDF_RCV_RMK_thai = "แก้ไขชื่อผู้เอาประกัน" 
            wdetail.MDF_updata       = trim(wdetail.CUST_FNM)  + " " + trim(wdetail.CUST_LNM) + " " + nv_name2 .

        ELSE IF trim(wdetail.MDF_RCV_RMK) = "Change insurance effective date"  THEN
            ASSIGN 
            wdetail.MDF_RCV_RMK_thai = "แก้ไขวันคุ้มครอง" 
            wdetail.MDF_updata       = 
            trim(wdetail.TAS_RCV_DAY) + "/" + trim(wdetail.TAS_RCV_MONTH) + "/" + trim(wdetail.TAS_RCV_YEAR) + " - " +
            trim(wdetail.TAS_RCV_DAY) + "/" + trim(wdetail.TAS_RCV_MONTH) + "/" + trim(string(deci(wdetail.TAS_RCV_YEAR) + 1 )) .
        ELSE IF trim(wdetail.MDF_RCV_RMK) = "Change prefix to"                 THEN 
            ASSIGN 
            wdetail.MDF_RCV_RMK_thai = "เปลี่ยนคำนำหน้า"
            wdetail.MDF_updata       = trim(wdetail.CUST_FNM)  + " " + trim(wdetail.CUST_LNM) .
        ELSE IF trim(wdetail.MDF_RCV_RMK) = "Add director name"                THEN 
            ASSIGN 
            wdetail.MDF_RCV_RMK_thai = "เพิ่มชื่อกรรมการ" 
            wdetail.MDF_updata       = trim(wdetail.CUST_FNM)  + " " + trim(wdetail.CUST_LNM) + " " + nv_name2 .

        ELSE IF trim(wdetail.MDF_RCV_RMK) = "Change Engine and Chassis"        THEN 
            ASSIGN 
            wdetail.MDF_RCV_RMK_thai = "แก้ไขเลขเครื่อง / เลขถัง"
            wdetail.MDF_updata       = "เลขถัง : " + trim(wdetail.CHASSIS_NO)  + " /เลขเครื่อง : " + trim(wdetail.EGN_NO) .
        ELSE IF trim(wdetail.MDF_RCV_RMK) = "Change Engine"        THEN 
            ASSIGN 
            wdetail.MDF_RCV_RMK_thai = "แก้ไขเลขเครื่อง"
            wdetail.MDF_updata       = "เลขเครื่อง : " + trim(wdetail.EGN_NO) .

        ELSE IF trim(wdetail.MDF_RCV_RMK) = "Change Chassis"        THEN 
            ASSIGN 
            wdetail.MDF_RCV_RMK_thai = "แก้ไขเลขเลขถัง"
            wdetail.MDF_updata       = "เลขถัง : " + trim(wdetail.CHASSIS_NO)   .

        ELSE IF trim(wdetail.MDF_RCV_RMK) = "Change finance"                   THEN 
            ASSIGN 
            wdetail.MDF_RCV_RMK_thai = "แก้ไขผู้รับผลประโยชน์"
            wdetail.MDF_updata       = trim(wdetail.FINANCE_COMP).
        ELSE IF trim(wdetail.MDF_RCV_RMK) = "Change customer name and surname" THEN 
            ASSIGN 
            wdetail.MDF_RCV_RMK_thai = "แก้ไขชื่อและนามสกุล"
            wdetail.MDF_updata       = trim(wdetail.CUST_FNM)  + " " + trim(wdetail.CUST_LNM) + " " + nv_name2 .
        ELSE IF trim(wdetail.MDF_RCV_RMK) = "Change customer surname" THEN 
            ASSIGN 
            wdetail.MDF_RCV_RMK_thai = "แก้ไขชื่อและนามสกุล"
            wdetail.MDF_updata       = trim(wdetail.CUST_FNM)  + " " + trim(wdetail.CUST_LNM) + " " + nv_name2 .
        ELSE IF trim(wdetail.MDF_RCV_RMK) = "Change customer name" THEN 
            ASSIGN
            wdetail.MDF_RCV_RMK_thai = "แก้ไขชื่อและนามสกุล"
            wdetail.MDF_updata       = trim(wdetail.CUST_FNM)  + " " + trim(wdetail.CUST_LNM) + " " + nv_name2 .
        ELSE IF trim(wdetail.MDF_RCV_RMK) = "Change customer address"          THEN 
            ASSIGN 
            wdetail.MDF_RCV_RMK_thai = "เปลี่ยนที่อยู่ในการจัดส่งกรมธรรม์"
            wdetail.MDF_updata   = wdetail.MDF_updata + (IF trim(wdetail.ADDRESS1)     <> "" THEN (trim(wdetail.ADDRESS1)     + " " ) ELSE "" )
            wdetail.MDF_updata   = wdetail.MDF_updata + (IF trim(wdetail.ADDRESS2)     <> "" THEN (trim(wdetail.ADDRESS2)     + " " ) ELSE "" ) 
            wdetail.MDF_updata   = wdetail.MDF_updata + (IF trim(wdetail.SOI)          <> "" THEN (trim(wdetail.SOI)          + " " ) ELSE "" ) 
            wdetail.MDF_updata   = wdetail.MDF_updata + (IF trim(wdetail.ROAD)         <> "" THEN (trim(wdetail.ROAD)         + " " ) ELSE "" )           
            wdetail.MDF_updata   = wdetail.MDF_updata + (IF trim(wdetail.SUB_DISTRICT) <> "" THEN (trim(wdetail.SUB_DISTRICT) + " " ) ELSE "" ) 
            wdetail.MDF_updata   = wdetail.MDF_updata + (IF trim(wdetail.DISTRICT)     <> "" THEN (trim(wdetail.DISTRICT)     + " " ) ELSE "" ) 
            wdetail.MDF_updata   = wdetail.MDF_updata + (IF trim(wdetail.PROVINCE)     <> "" THEN (trim(wdetail.PROVINCE)     + " " ) ELSE "" ) 
            wdetail.MDF_updata   = wdetail.MDF_updata + (IF trim(wdetail.ZIP_CD)       <> "" THEN trim(wdetail.ZIP_CD) ELSE "" ) .
        
        ELSE IF trim(wdetail.MDF_RCV_RMK) = "Cancelles due to Ins.Company"     THEN 
            ASSIGN 
            wdetail.MDF_RCV_RMK_thai = "ยกเลิกเนื่องจากเปลี่ยนบริษัท" 
            wdetail.MDF_updata       = "".
        ELSE IF trim(wdetail.MDF_RCV_RMK) = "Cancelled by dealer"              THEN
            ASSIGN 
            wdetail.MDF_RCV_RMK_thai = "ยกเลิก"
            wdetail.MDF_updata       = "".
        ELSE IF trim(wdetail.MDF_RCV_RMK) = "Change PRB.no."                   THEN 
            ASSIGN 
            wdetail.MDF_RCV_RMK_thai = "แก้ไขเลขสติ๊กเกอร์"
            wdetail.MDF_updata       = trim(wdetail.INS_NO).
        ELSE ASSIGN 
            wdetail.MDF_RCV_RMK_thai = "อื่น ๆ "
            wdetail.MDF_updata       = "".
    END.
END.
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
If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".slk"  Then
    fi_outfile  =  Trim(fi_outfile) + ".slk"  .
ASSIGN nv_row   =  1 .
OUTPUT STREAM ns2 TO VALUE(fi_outfile).
PUT STREAM ns2 "ID;PND" SKIP.
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"'    "ID"                '"' SKIP. /*  ID              */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"'    "TAS_RCV_DAY"       '"' SKIP. /*  TAS_RCV_DAY     */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"'    "TAS_RCV_MONTH"     '"' SKIP. /*  TAS_RCV_MONTH   */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"'    "TAS_RCV_YEAR"      '"' SKIP. /*  TAS_RCV_YEAR    */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'    "TAS_RUN_NO"        '"' SKIP. /*  TAS_RUN_NO      */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"'    "TAS_RCV_BY"        '"' SKIP. /*  TAS_RCV_BY      */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"'    "INSURACE_COM1"     '"' SKIP. /*  INSURACE_COM1   */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"'    "INS_REF_NO"        '"' SKIP. /*  INS_REF_NO      */  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"'    "INF_INS_DAY"       '"' SKIP. /*  INF_INS_DAY     */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"'    "INF_INS_MONTH"     '"' SKIP. /*  INF_INS_MONTH   */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"'    "INF_INS_YEAR"      '"' SKIP. /*  INF_INS_YEAR    */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"'    "CUST_FNM"          '"' SKIP. /*  CUST_FNM        */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"'    "CUST_LNM"          '"' SKIP. /*  CUST_LNM        */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"'    "ID_NUM"            '"' SKIP. /*  ID_NUM          */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"'    "ADDRESS1"          '"' SKIP. /*  ADDRESS1        */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"'    "ADDRESS2"          '"' SKIP. /*  ADDRESS2        */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"'    "SOI            "   '"' SKIP. /*  SOI             */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"'    "ROAD        "      '"' SKIP. /*  ROAD            */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"'    "SUB_DISTRICT"      '"' SKIP. /*  SUB_DISTRICT    */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"'    "DISTRICT    "      '"' SKIP. /*  DISTRICT        */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"'    "PROVINCE    "      '"' SKIP. /*  PROVINCE        */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"'    "ZIP_CD        "    '"' SKIP. /*  ZIP_CD          */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"'    "TELEPHONE    "     '"' SKIP. /*  TELEPHONE       */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"'    "SALES_MODEL    "   '"' SKIP. /*  SALES_MODEL     */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"'    "USAGE_TYPE    "    '"' SKIP. /*  USAGE_TYPE      */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"'    "COLOR_THAI    "    '"' SKIP. /*  COLOR_THAI      */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"'    "CC            "    '"' SKIP. /*  CC              */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"'    "EGN_NO        "    '"' SKIP. /*  EGN_NO          */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"'    "CHASSIS_NO    "    '"' SKIP. /*  CHASSIS_NO      */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"'    "INSURANCE_COM2"    '"' SKIP. /*  INSURANCE_COM2  */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"'    "COVER_INS_DAY"     '"' SKIP. /*  COVER_INS_DAY   */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"'    "COVER_INS_MONTH"   '"' SKIP. /*  COVER_INS_MONTH */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"'    "COVER_INS_YEAR"    '"' SKIP. /*  COVER_INS_YEAR  */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"'    "INS_FUND    "      '"' SKIP. /*  INS_FUND        */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"'    "INS_FEE        "   '"' SKIP. /*  INS_FEE         */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K" '"'    "INS_NO        "    '"' SKIP. /*  INS_NO          */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K" '"'    "TIS_DEALER    "    '"' SKIP. /*  TIS_DEALER      */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K" '"'    "SHOWROOM    "      '"' SKIP. /*  SHOWROOM        */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K" '"'    "PURCHASE_TYPE"     '"' SKIP. /*  PURCHASE_TYPE   */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K" '"'    "FINANCE_COMP"      '"' SKIP. /*  FINANCE_COMP    */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K" '"'    "INF_FNM        "   '"' SKIP. /*  INF_FNM         */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K" '"'    "INF_LNM        "   '"' SKIP. /*  INF_LNM         */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K" '"'    "INF_PHONE    "     '"' SKIP. /*  INF_PHONE       */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K" '"'    "INF_POSITION"      '"' SKIP. /*  INF_POSITION    */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K" '"'    "INF_REMARK"        '"' SKIP. /*  INF_REMARK      */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K" '"'    "CHECK_ENG "        '"' SKIP. /*  CHECK_ENG       */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K" '"'    "REC_STATUS"        '"' SKIP. /*  REC_STATUS      */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K" '"'    "MDF_DTE   "        '"' SKIP. /*  MDF_DTE         */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K" '"'    "MDF_RCV_DTE"       '"' SKIP. /*  MDF_RCV_DTE     */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K" '"'    "MDF_RCV_RMK"       '"' SKIP. /*  MDF_RCV_RMK     */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K" '"'    "Policy No. (70)"         '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K" '"'    "Policy No. (72)"         '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K" '"'    "MDF_RCV_RMK (Thail)"     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K" '"'    "แก้ไขข้อมูลจากเดิมเป็น"  '"' SKIP.
RUN Pro_createfile22.
PUT STREAM ns2 "E".
OUTPUT STREAM ns2 CLOSE.
message "Export File  Complete"  view-as alert-box.
/*---------------------------------------------------------------------*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_createfile22 C-Win 
PROCEDURE Pro_createfile22 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wdetail NO-LOCK .  
    ASSIGN nv_row  =  nv_row + 1.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"'  wdetail.ID                  '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"'  wdetail.TAS_RCV_DAY         '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"'  wdetail.TAS_RCV_MONTH       '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"'  wdetail.TAS_RCV_YEAR        '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'  wdetail.TAS_RUN_NO          '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"'  wdetail.TAS_RCV_BY          '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"'  wdetail.INSURACE_COM1       '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"'  wdetail.INS_REF_NO          '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"'  wdetail.INF_INS_DAY         '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"' wdetail.INF_INS_MONTH       '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"' wdetail.INF_INS_YEAR        '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"' wdetail.CUST_FNM            '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"' wdetail.CUST_LNM            '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"' wdetail.ID_NUM              '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"' wdetail.ADDRESS1            '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"' wdetail.ADDRESS2            '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"' wdetail.SOI                 '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"' wdetail.ROAD                '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"' wdetail.SUB_DISTRICT        '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"' wdetail.DISTRICT            '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"' wdetail.PROVINCE            '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"' wdetail.ZIP_CD              '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"' wdetail.TELEPHONE           '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"' wdetail.SALES_MODEL         '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"' wdetail.USAGE_TYPE          '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"' wdetail.COLOR_THAI          '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"' wdetail.CC                  '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"' wdetail.EGN_NO              '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"' wdetail.CHASSIS_NO          '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"'  wdetail.INSURANCE_COM2      '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"'  wdetail.COVER_INS_DAY       '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"'  wdetail.COVER_INS_MONTH     '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"'  wdetail.COVER_INS_YEAR      '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"'  wdetail.INS_FUND            '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"'  wdetail.INS_FEE             '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K" '"'  wdetail.INS_NO              '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K" '"'  wdetail.TIS_DEALER          '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K" '"'  wdetail.SHOWROOM            '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K" '"'  wdetail.PURCHASE_TYPE       '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K" '"'  wdetail.FINANCE_COMP        '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K" '"'  wdetail.INF_FNM             '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K" '"'  wdetail.INF_LNM             '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K" '"'  wdetail.INF_PHONE           '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K" '"'  wdetail.INF_POSITION        '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K" '"'  wdetail.INF_REMARK          '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K" '"'  wdetail.CHECK_ENG           '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K" '"'  wdetail.REC_STATUS          '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K" '"'  wdetail.MDF_DTE             '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K" '"'  wdetail.MDF_RCV_DTE         '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K" '"'  wdetail.MDF_RCV_RMK         '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K" '"'  wdetail.IN_pol70            '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K" '"'  wdetail.IN_pol72            '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K" '"'  wdetail.MDF_RCV_RMK_thai    '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K" '"'  wdetail.MDF_updata          '"' SKIP.
END.    /*  end  wdetail  */  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

