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
  
  /*Program name     : Match Text file PA60 PMIB to excel file and update TLT      */  
/*create by        : Ranu I. A61-0024  date.20/01/2018      */ 
/*DataBase connect : GW_SAFE -LD SIC_BRAN, GW_STAT -LD BRSTAT,SICSYAC,SICUW stat*/ 
/*------------------------------------------------------------------------*/
/*          This .W file was created with the Progress UIB.             */
/*----------------------------------------------------------------------*/

/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */
*/
CREATE WIDGET-POOL.
/* ***************************  Definitions  **************************         */
/* Parameters Definitions ---                                                   */  
/*Local Variable Definitions ---                                                */   

DEF  SHARED VAR n_User    AS CHAR.  /*A60-0118*/
DEF  SHARED VAR n_Passwd  AS CHAR.  /*A60-0118*/
DEF  stream  ns1.
DEFINE VAR   nv_daily        AS CHARACTER FORMAT "X(1024)"     INITIAL ""  NO-UNDO.
DEFINE VAR   nv_reccnt       AS  INT  INIT  0.
DEFINE VAR   nv_completecnt  AS   INT   INIT  0.
DEFINE VAR   nv_enttim       AS  CHAR          INIT  "".
def    var   nv_export       as  date  init  ""  format "99/99/9999".
def  stream  ns2.
DEFINE VAR   nv_file1        AS CHARACTER FORMAT "X(100)"     INITIAL ""  NO-UNDO.
DEFINE VAR   nv_file2        AS CHARACTER FORMAT "X(100)"     INITIAL ""  NO-UNDO.
/*--------------------------สำหรับข้อมูลกรมธรรม์  -------------------------*/
DEFINE  WORKFILE wdetail NO-UNDO
    FIELD branch      AS CHAR FORMAT "X(2)"   INIT ""                                    
    FIELD policy      AS CHAR FORMAT "X(12)"  INIT ""   
    FIELD SEQ         AS CHAR FORMAT "X(10)"  INIT "" /*No.                */       
    field not_date    as CHAR FORMAT "X(15)"   init ""   /*วันที่ส่งข้อมูล    */    
    field cedcode     as CHAR FORMAT "X(15)"   init ""   /*APPLICATION_ID     */    
    field pol_title   as CHAR FORMAT "X(25)"   init ""   /*TITLE_NAME         */    
    field pol_fname   as CHAR FORMAT "X(100)"  init ""   /*INSURED_NAME       */    
    field pol_lname   as CHAR FORMAT "X(100)"  init ""   /*INSURED_LASTNAME   */    
    field icno        as CHAR FORMAT "X(15)"   init ""   /*CUSTOMER_ID        */    
    field bdate       as CHAR FORMAT "X(15)"   init ""   /*BIRDTE             */    
    field age         as CHAR FORMAT "X(2)"    init ""   /*AGE                */    
    field covcod      as CHAR FORMAT "X(2)"    init ""   /*Plan               */    
    field ins_amt     as CHAR FORMAT "X(20)"   init ""   /*Sum Insurance      */    
    field premtotal   as CHAR FORMAT "X(15)"   init ""   /*ค่าเบี้ย PA        */    
    field addr1       as CHAR FORMAT "X(250)"  init ""   /*ADDR1              */    
    field addr2       as CHAR FORMAT "X(100)"  init ""   /*AMPHUR             */    
    field addr3       as CHAR FORMAT "X(100)"  init ""   /*PROVINCE_TH        */    
    field addr4       as CHAR FORMAT "X(100)"  init ""   /*POST_CODE          */    
    field tel         as CHAR FORMAT "X(15) "  init ""   /*MOBILE_NUMBER      */    
    field phone       as CHAR FORMAT "X(10)"   init ""   /*PHONE_NUMBER       */    
    field comdat      as CHAR FORMAT "X(15)"   init ""   /*Eff.Date */ 
    FIELD remark      AS CHAR FORMAT "x(250)"  INIT ""
    FIELD producer    AS CHAR FORMAT "x(10)"   INIT ""
    FIELD agent       AS CHAR FORMAT "x(10)"   INIT ""
    FIELD comment     AS CHAR FORMAT "x(250)"  INIT "".

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_filename fi_outfile bu_ok bu_exit bu_file ~
fi_process RECT-76 RECT-77 
&Scoped-Define DISPLAYED-OBJECTS fi_filename fi_outfile fi_process 

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
     BGCOLOR 6 FONT 6.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 3.5 BY 1.05.

DEFINE BUTTON bu_ok 
     LABEL "Ok" 
     SIZE 7.5 BY 1.05
     BGCOLOR 10 FONT 6.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 70 BY 1.05
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_outfile AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 70 BY 1.05
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_process AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 54 BY 1.05
     BGCOLOR 15 FONT 1 NO-UNDO.

DEFINE RECTANGLE RECT-76
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 89.5 BY 8.57
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-77
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 19.5 BY 1.57
     BGCOLOR 2 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_filename AT ROW 3.52 COL 12.83 COLON-ALIGNED NO-LABEL
     fi_outfile AT ROW 4.81 COL 12.83 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 6.43 COL 61.83
     bu_exit AT ROW 6.43 COL 71.5
     bu_file AT ROW 3.52 COL 85.33
     fi_process AT ROW 6.43 COL 6 NO-LABEL
     "Input File :" VIEW-AS TEXT
          SIZE 12 BY 1.05 AT ROW 3.52 COL 2.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "Output File :" VIEW-AS TEXT
          SIZE 12 BY 1.05 AT ROW 4.81 COL 2.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "                                             MATCH FILE PMIB PA60" VIEW-AS TEXT
          SIZE 86 BY 1.67 AT ROW 1.48 COL 2.5
          BGCOLOR 1 FGCOLOR 7 FONT 2
     RECT-76 AT ROW 1.05 COL 1.17
     RECT-77 AT ROW 6.19 COL 60.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 90.33 BY 8.76
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
         TITLE              = "Match Text File Policy M60"
         HEIGHT             = 8.71
         WIDTH              = 89.83
         MAX-HEIGHT         = 18.76
         MAX-WIDTH          = 117.67
         VIRTUAL-HEIGHT     = 18.76
         VIRTUAL-WIDTH      = 117.67
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
ASSIGN 
       bu_file:AUTO-RESIZE IN FRAME fr_main      = TRUE.

/* SETTINGS FOR FILL-IN fi_process IN FRAME fr_main
   ALIGN-L                                                              */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Match Text File Policy M60 */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Match Text File Policy M60 */
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
        FILTERS    /*"Text Documents" "*.txt",*/
                    "Text Documents" "*.csv",
                            "Data Files (*.*)"     "*.*"
                            
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
    ASSIGN nv_reccnt  =  0.
    FOR EACH  wdetail:
        DELETE  wdetail.
    END.
    INPUT FROM VALUE (fi_filename) .   /*create in TEMP-TABLE wImport*/
    REPEAT:    
        CREATE wdetail.
        IMPORT DELIMITER "|" 
            wdetail.SEQ   
            wdetail.not_date  
            wdetail.cedcode   
            wdetail.pol_title 
            wdetail.pol_fname 
            wdetail.pol_lname 
            wdetail.icno      
            wdetail.bdate     
            wdetail.age       
            wdetail.covcod    
            wdetail.ins_amt   
            wdetail.premtotal 
            wdetail.addr1     
            wdetail.addr2     
            wdetail.addr3     
            wdetail.addr4     
            wdetail.tel       
            wdetail.phone     
            wdetail.comdat.
    END.    /* repeat  */
    FOR EACH wdetail.
        IF      index(wdetail.SEQ,"No")   <> 0 THEN DELETE wdetail.
        ELSE IF index(wdetail.SEQ,"Mail") <> 0 THEN DELETE wdetail.
        ELSE IF       wdetail.SEQ         = "" THEN DELETE wdetail.
    END.
    RUN  Pro_matchfile_prem.
    Run  Pro_createfile.
    Message "Export data Complete"  View-as alert-box.
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
  ASSIGN fi_process = "Match file Policy PA60 and Update Status "
  
      gv_prgid = "WGWMAT60.W".
  gv_prog  = "Match Text File PMIB PA60".
  DISP fi_process WITH FRAM fr_main.
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).

/*********************************************************************/ 
   RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE).  
  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.
  /*ASSIGN ra_report =  1.*/
  /*DISP ra_report WITH FRAM fr_main.*/
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
  DISPLAY fi_filename fi_outfile fi_process 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_filename fi_outfile bu_ok bu_exit bu_file fi_process RECT-76 
         RECT-77 
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
DEF VAR   nv_cnt   as  int  init   1.
DEF VAR   nv_row   as  int  init   0.
DEF VAR   n_record AS  INTE INIT   0.
If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".slk"  THEN 
    fi_outfile  =  Trim(fi_outfile) + ".slk"  .
ASSIGN 
    n_record =  0
    nv_cnt   =  0
    nv_row   =  1 .
OUTPUT STREAM ns2 TO VALUE(fi_outfile).
PUT STREAM ns2 "ID;PND" SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "Export data by Policy PMIB PA60."  '"' SKIP.
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"' "No.             "   '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"' "Send Date       "   '"' SKIP.        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"' "APPLICATION_ID  "   '"' SKIP.        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"' "Policy          "   '"' SKIP.        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"' "TITLE_NAME      "   '"' SKIP.        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"' "INSURED_NAME    "   '"' SKIP.        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"' "INSURED_LASTNAME"   '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"' "CUSTOMER_ID     "   '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"' "BIRDTE          "   '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"' "AGE             "   '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"' "Plan            "   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"' "Sum Insurance   "   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"' "Premium total   "   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"' "ADDR1           "   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"' "AMPHUR          "   '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"' "PROVINCE_TH     "   '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"' "POST_CODE       "   '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"' "MOBILE_NUMBER   "   '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"' "PHONE_NUMBER    "   '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"' "comdate         "   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"' "Agent           "   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"' "Producer        "   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"' "comment         "   '"' SKIP.

FOR EACH wdetail  NO-LOCK  .
    ASSIGN 
        n_record =  n_record + 1
        nv_cnt   =  nv_cnt  + 1 
        nv_row   =  nv_row  + 1.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"'   wdetail.SEQ        '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"'   wdetail.not_date   '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"'   wdetail.cedcode    '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"'   wdetail.policy     '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'   wdetail.pol_title  '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"'   wdetail.pol_fname  '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"'   wdetail.pol_lname  '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"'   wdetail.icno       '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"'   wdetail.bdate      '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"'  wdetail.age        '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"'  wdetail.covcod     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"'  wdetail.ins_amt    '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"'  wdetail.premtotal  '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"'  wdetail.addr1      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"'  wdetail.addr2      '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"'  wdetail.addr3      '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"'  wdetail.addr4      '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"'  wdetail.tel        '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"'  wdetail.phone      '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"'  wdetail.comdat     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"'  wdetail.agent      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"'  wdetail.producer   '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"'  wdetail.comment    '"' SKIP.
END.    /*  end  wdetail  */
nv_row  =  nv_row  + 1. 
PUT STREAM ns2 "E".
OUTPUT STREAM ns2 CLOSE.  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_matchfile_prem C-Win 
PROCEDURE Pro_matchfile_prem :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wdetail .
    FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE  
        sicuw.uwm100.cedpol  =  TRIM(wdetail.cedcode) AND
        sicuw.uwm100.poltyp  =  "M60" NO-LOCK NO-ERROR.
    IF AVAIL sicuw.uwm100 THEN do:
            ASSIGN fi_process = "Match file Policy and Update Status " + TRIM(wdetail.cedcode) .
            DISP fi_process WITH FRAM fr_main.
            FIND LAST brstat.tlt WHERE brstat.tlt.rec_addr1     = trim(wdetail.icno)     AND
                                       brstat.tlt.nor_noti_ins  = trim(wdetail.cedcode)  AND
                                       brstat.tlt.genusr        = "PMIB"          NO-ERROR NO-WAIT .
               
                IF AVAIL brstat.tlt THEN DO:
                    IF brstat.tlt.policy = "" THEN DO:
                       ASSIGN  brstat.tlt.policy = sicuw.uwm100.policy
                               wdetail.policy    = sicuw.uwm100.policy
                               wdetail.agent     = sicuw.uwm100.agent
                               wdetail.producer  = sicuw.uwm100.acno1 . 
                    END.
                    ELSE DO:        
                        ASSIGN wdetail.comment   = "มีเบอร์กรมธรรม์แล้ว" + brstat.tlt.policy
                               brstat.tlt.policy = sicuw.uwm100.policy
                               wdetail.policy    = sicuw.uwm100.policy
                               wdetail.agent     = sicuw.uwm100.agent
                               wdetail.producer  = sicuw.uwm100.acno1.
                    END.

                    IF brstat.tlt.releas  = "NO" THEN DO:
                        ASSIGN  brstat.tlt.releas  =  "YES" .
                    END.
                    ELSE IF INDEX(brstat.tlt.releas,"CANCEL") <> 0 THEN DO:
                        ASSIGN  brstat.tlt.RELEAS = "CANCEL/YES"
                                wdetail.comment   =  wdetail.comment + "มีการยกเลิกข้อมูลในระบบ".
                    END.

                    IF brstat.tlt.entdat  = ?    THEN ASSIGN  brstat.tlt.entdat  =  sicuw.uwm100.trndat.
                    IF brstat.tlt.usrsent = ""   THEN ASSIGN  brstat.tlt.usrsent =  n_User .  /* user ที่ยกเลิก */
                END.
                ELSE DO:
                    ASSIGN wdetail.comment = "ไม่พบข้อมูลในถังพัก " .
                END.
    END.
    ELSE DO:
        ASSIGN wdetail.comment = "ไม่พบข้อมูลเลขรับแจ้งที่ UWM100" .
    END.
END.      /* wdetail*/
RELEASE brstat.tlt.
RELEASE sicuw.uwm100.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

