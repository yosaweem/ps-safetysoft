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
  program id   : wgwklmat.w
  program name : IMPORT TEXT FILE K-Lising Send To KL[ลิสซิ่งกสิกรไทย] 
  create by    : Kridtiya i. A57-0244 date. 15/08/2014
  copy write   : wuwtstex.w                                            */
/*-------------------------------------------------------------------*/

/*Modify by : Ranu I. A59-0298 Date: 30/06/2016 แก้ไขรูปแบบรายงาน      */
/*Modify by : Ranu I. A59-0605 Date: 13/12/2016 เพิ่มตัวเลือกการ Match file จาก KK   */
/************************************************************************/
CREATE WIDGET-POOL.
/* ***************************  Definitions  ************************** */
/* Parameters Definitions ---                                           */
/* Local Variable Definitions ---                                       */

/* def  stream ns1.                                                                    */
/* DEF VAR num AS DECI INIT 1.                                                         */
/* DEF VAR expyear AS DECI FORMAT "9999" .                                             */
/* /*DEFINE VAR nv_daily     AS CHARACTER FORMAT "X(2465)"     INITIAL ""  NO-UNDO.*/  */
/* DEFINE VAR nv_daily     AS CHARACTER FORMAT "X"     INITIAL ","  NO-UNDO.           */
/* DEFINE VAR nv_reccnt   AS  INT  INIT  0.                                            */
/* DEFINE VAR nv_completecnt    AS   INT   INIT  0.                                    */
/* DEFINE VAR nv_enttim   AS  CHAR          INIT  "".                                  */
/* def    var  nv_export    as  char  init  ""  format "X(8)".                         */


def  stream  ns2.  
def var nv_row   as  int  init 0.                                        
def var nv_cnt   as  int  init  0.                                         
/*------------ comment by A59-0298 -----------------------------
DEFINE NEW SHARED TEMP-TABLE wdetail
    FIELD number                    AS CHAR FORMAT "x(10)"  INIT ""
    FIELD APPLICATION_ID            AS CHAR FORMAT "x(20)" INIT ""
    FIELD TH_NAME                   AS CHAR FORMAT "x(60)" INIT ""
    FIELD PERSON_IN_CHARGE          AS CHAR FORMAT "x(60)" INIT ""
    FIELD nmonth                    AS CHAR FORMAT "x(20)" INIT ""
    FIELD ALO_CONTRACT_NUMBER       AS CHAR FORMAT "x(20)"  INIT "" 
    FIELD CUSNAME                   AS CHAR FORMAT "x(100)" INIT ""     
    FIELD VMI                       AS CHAR FORMAT "x(10)"  INIT ""     
    FIELD CMI                       AS CHAR FORMAT "x(10)"  INIT ""     
    FIELD CHASSIS                   AS CHAR FORMAT "x(30)"  INIT ""     
    FIELD REGISTER_ID               AS CHAR FORMAT "x(20)"  INIT ""     
    FIELD EFFECTIVE_DATE            AS CHAR FORMAT "x(16)"  INIT ""     
    FIELD EXPIRED_DATE              AS CHAR FORMAT "x(16)"  INIT ""     
    FIELD APPLICATION_SIGN_DATE     AS CHAR FORMAT "x(16)"  INIT ""     
    FIELD policy70                  AS CHAR FORMAT "x(12)"  INIT ""     
    FIELD policy72                  AS CHAR FORMAT "x(12)"  INIT ""     
    FIELD memo                      AS CHAR FORMAT "x(150)" INIT "" 
    FIELD remark                    AS CHAR FORMAT "x(150)" INIT "" .
 --------------------- end A59-0298----------------------------*/  
/*------------- Create by  A59-0298-----------------------------*/
DEFINE NEW SHARED TEMP-TABLE wdetail
    FIELD n_no                AS CHAR FORMAT "x(10)"  INIT ""           /*No                              */   
    FIELD n_thname            AS CHAR FORMAT "x(50)" INIT ""            /*TH_NAME                         */   
    FIELD n_applino           AS CHAR FORMAT "x(30)" INIT ""            /*APPLICATION_ID                  */   
    FIELD n_contractno        AS CHAR FORMAT "x(30)" INIT ""            /*ALO_CONTRACT_NUMBER             */   
    FIELD n_effecdat          AS CHAR FORMAT "x(20)" INIT ""            /*EFFECTIVE_DATE                  */   
    FIELD n_expirdat          AS CHAR FORMAT "x(20)"  INIT ""           /*EXPIRED_DATE                    */   
    FIELD n_cusname           AS CHAR FORMAT "x(100)" INIT ""           /*CUSNAME                         */   
    FIELD n_garage            AS CHAR FORMAT "x(20)"  INIT ""           /*GARAGE_TYPE                     */   
    FIELD n_cvmi              AS CHAR FORMAT "x(10)"  INIT ""           /*TYPE_INSURANCE                  */   
    FIELD n_make              AS CHAR FORMAT "x(30)"  INIT ""           /*MAKE_DESCRIPTION1               */   
    FIELD n_model             AS CHAR FORMAT "x(50)"  INIT ""           /*MODEL_DESCRIPTION               */   
    FIELD n_chass             AS CHAR FORMAT "x(20)"  INIT ""           /*CHASSIS                         */   
    FIELD n_engno             AS CHAR FORMAT "x(20)"  INIT ""           /*ENGINE                          */   
    FIELD n_licen             AS CHAR FORMAT "x(10)"  INIT ""           /*REGISTER_ID                     */   
    FIELD n_regis             AS CHAR FORMAT "x(20)"  INIT ""           /*PROVINCE_ID                     */   
    FIELD n_year              AS CHAR FORMAT "x(10)" INIT ""            /*YEAR                            */   
    FIELD n_charge            AS CHAR FORMAT "x(60)" INIT ""            /*PERSON_IN_CHARGE                */   
    FIELD n_cperson           AS CHAR FORMAT "x(60)" INIT ""            /*CREATE_PERSON                   */   
    FIELD n_workdate          AS CHAR FORMAT "x(20)" INIT ""            /*WORK_QUEUE_DATE                 */   
    FIELD n_payment           AS CHAR FORMAT "x(20)"  INIT ""           /*PAYMENT                         */   
    FIELD n_track             AS CHAR FORMAT "x(100)" INIT ""           /*TRACKING                        */   
    FIELD n_post_no           AS CHAR FORMAT "x(15)"  INIT ""           /*POST_NO                         */   
    FIELD policy70            AS CHAR FORMAT "x(12)"  INIT ""           /*POLICY_VOLUNTARY_NO             */   
    FIELD policy72            AS CHAR FORMAT "x(12)"  INIT ""           /*POLICY_COMPULSURY_NO            */   
    FIELD memo                AS CHAR FORMAT "x(150)" INIT ""           /*หมายเหตุ//กธ.ไม่ออก(ประกันแจ้ง) */   
    FIELD remark              AS CHAR FORMAT "x(150)" INIT ""           /*งานติดปัญหาที่ PMIB             */
    FIELD n_si                AS CHAR FORMAT "x(20)" INIT "" 
    FIELD n_prem              AS CHAR FORMAT "x(20)" INIT "". 
DEF VAR n_policy70 AS CHAR FORMAT "x(20)" INIT "".
DEF VAR n_policy72 AS CHAR FORMAT "x(20)" INIT "".
DEF VAR n_pol           AS CHAR FORMAT "x(13)".
DEF VAR n_recnt    AS INT .
DEF VAR n_encnt    AS INT.


/*------------- End : A59-0298-----------------------------*/

/* DEF VAR nv_accdat   AS DATE      FORMAT "99/99/9999"              NO-UNDO. */
/* DEF VAR nv_comdat   AS DATE      FORMAT "99/99/9999"              NO-UNDO. */
/* DEF VAR nv_expdat   AS DATE      FORMAT "99/99/9999"              NO-UNDO. */
/* DEF VAR nv_comchr   AS  CHAR .                                             */
/* DEF VAR nv_dd       AS  INT          FORMAT "99".                          */
/* DEF VAR nv_mm       AS  INT          FORMAT "99".                          */
/* DEF VAR nv_yy       AS  INT          FORMAT "9999".                        */
/* DEF VAR nv_cpamt1   AS DECI        INIT 0.                                 */
/* DEF VAR nv_cpamt2   AS DECI        INIT  0.                                */
/* DEF VAR nv_cpamt3   AS DECI        INIT  0.                                */
/* DEF VAR nv_insamt1  AS DECI        INIT 0.                                 */
/* DEF VAR nv_insamt2  AS DECI        INIT  0.                                */
/* DEF VAR nv_insamt3  AS DECI        INIT  0.                                */
/* DEF VAR nv_premt1   AS DECI        INIT 0.                                 */
/* DEF VAR nv_premt2   AS DECI        INIT  0.                                */
/* DEF VAR nv_premt3   AS DECI        INIT  0.                                */
/* DEF VAR nv_name1    AS  CHAR      INIT  ""   Format "X(30)".               */
/* DEF VAR nv_ntitle   AS  CHAR      INIT  ""   Format  "X(10)".              */
/* DEF VAR nv_titleno    AS  INT          INIT  0    .                        */
/* DEF VAR nv_policy    AS  CHAR      INIT ""  Format  "X(12)".               */
/* def var nv_source as  char  format  "X(35)".                               */
/* def var nv_indexno  as   int    init  0.                                   */
/* def var nv_indexno1  as   int    init  0.                                  */
/* def var nv_addr  as  char  extent 4  format "X(35)".                       */
/* def var nv_prem  as  char   init  "".                                      */
/* def VAR nv_file  as  char   init  "d:\fileload\return.txt".                */
/* DEF VAR number AS INT INIT 1.                                              */
/*                                                                            */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS rs_type fi_filename fi_outfile bu_ok bu_file ~
bu_exit RECT-76 RECT-77 
&Scoped-Define DISPLAYED-OBJECTS rs_type fi_filename fi_outfile 

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
     SIZE 65 BY 1.05
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_outfile AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 70 BY 1.05
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE rs_type AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Match Policy From File Load", 1,
"Match Policy From File Chassic(KL)", 2
     SIZE 80 BY 1.19
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-76
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 93.5 BY 8.57
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-77
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 19.5 BY 1.57
     BGCOLOR 1 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     rs_type AT ROW 3.29 COL 8.5 NO-LABEL
     fi_filename AT ROW 4.95 COL 16.5 COLON-ALIGNED NO-LABEL
     fi_outfile AT ROW 6.24 COL 16.5 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 7.76 COL 70.33
     bu_file AT ROW 4.95 COL 85
     bu_exit AT ROW 7.76 COL 79
     "     Input File :":30 VIEW-AS TEXT
          SIZE 15 BY 1.05 AT ROW 4.95 COL 3
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "   Output File :" VIEW-AS TEXT
          SIZE 15 BY 1.05 AT ROW 6.24 COL 3
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "                          IMPORT TEXT FILE K-Lising Send To KL[ลิสซิ่งกสิกรไทย]" VIEW-AS TEXT
          SIZE 86 BY 1.43 AT ROW 1.48 COL 3
          BGCOLOR 2 FGCOLOR 7 FONT 6
     RECT-76 AT ROW 1.1 COL 1
     RECT-77 AT ROW 7.48 COL 68.67
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 93.83 BY 8.81
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
         TITLE              = "IMPORT TEXT FILE K-Lising"
         HEIGHT             = 8.81
         WIDTH              = 93.67
         MAX-HEIGHT         = 45.76
         MAX-WIDTH          = 213.33
         VIRTUAL-HEIGHT     = 45.76
         VIRTUAL-WIDTH      = 213.33
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
ON END-ERROR OF C-Win /* IMPORT TEXT FILE K-Lising */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* IMPORT TEXT FILE K-Lising */
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
        ASSIGN 
            fi_filename  = cvData .
            /*fi_outfile   = IF INDEX(cvData,".csv") <> 0 THEN SUBSTR(cvData,1,INDEX(cvData,".csv") - 1 ) + "_mat.slk" ELSE "". --A59-0604--*/
        IF rs_type = 1 THEN 
            ASSIGN fi_outfile   = IF INDEX(cvData,".csv") <> 0 THEN SUBSTR(cvData,1,INDEX(cvData,".csv") - 1 ) + "_mat.slk" ELSE "".
        ELSE 
            ASSIGN fi_outfile   = IF INDEX(cvData,".csv") <> 0 THEN SUBSTR(cvData,1,INDEX(cvData,".csv") - 1 ) + "_matchs.csv" ELSE "".
        DISP fi_filename fi_outfile  WITH FRAME fr_main.     
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok C-Win
ON CHOOSE OF bu_ok IN FRAME fr_main /* Ok */
DO:
    IF fi_filename = ""  THEN DO:
        MESSAGE "Please insert file Input !!!" VIEW-AS ALERT-BOX.
        APPLY "entry" TO fi_filename.
        RETURN NO-APPLY.
    END.
    IF fi_outfile = ""  THEN DO:
        MESSAGE "Please insert file Output !!!" VIEW-AS ALERT-BOX.
        APPLY "entry" TO fi_outfile.
        RETURN NO-APPLY.
    END.
    For each  wdetail :
        DELETE  wdetail.
    END.
    IF rs_type = 1 THEN DO:
        INPUT FROM VALUE(fi_FileName).
        REPEAT:
            CREATE wdetail.
            IMPORT DELIMITER "|" 
                /* add by A62-04353 */
                wdetail.n_thname     
                wdetail.n_contractno    
                wdetail.n_effecdat   
                wdetail.n_expirdat   
                wdetail.n_cusname    
                wdetail.n_cvmi       
                wdetail.n_chass      
                wdetail.n_licen      
                wdetail.n_cperson    
                wdetail.n_workdate   
                wdetail.n_payment 
                wdetail.n_post_no 
                wdetail.n_track
                wdetail.policy70     
                wdetail.policy72     
                wdetail.memo         
                wdetail.remark . 
                /* end A62-0435 */
              /* comment by A62-0435 ..  
                wdetail.n_no           
                wdetail.n_thname     
                wdetail.n_applino    
                wdetail.n_contractno 
                wdetail.n_effecdat   
                wdetail.n_expirdat   
                wdetail.n_cusname    
                wdetail.n_garage     
                wdetail.n_cvmi       
                wdetail.n_make       
                wdetail.n_model      
                wdetail.n_chass      
                wdetail.n_engno      
                wdetail.n_licen      
                wdetail.n_regis      
                wdetail.n_year       
                wdetail.n_charge     
                wdetail.n_cperson    
                wdetail.n_workdate   
                wdetail.n_payment    
                wdetail.n_track      
                wdetail.n_post_no    
                wdetail.policy70     
                wdetail.policy72     
                wdetail.memo         
                wdetail.remark .  
                ... end A62-0435..*/
            /*---comment by A59-0298---
            IMPORT DELIMITER "|" 
                wdetail.number               
                wdetail.APPLICATION_ID       
                wdetail.CUSNAME              
                wdetail.ALO_CONTRACT_NUMBER  
                wdetail.TH_NAME              
                wdetail.VMI                         
                wdetail.CMI                    
                wdetail.EFFECTIVE_DATE       
                wdetail.EXPIRED_DATE         
                wdetail.PERSON_IN_CHARGE     
                wdetail.APPLICATION_SIGN_DATE                         
                wdetail.CHASSIS                                
                wdetail.REGISTER_ID         
                wdetail.policy70              
                wdetail.policy72              
                wdetail.memo                  
                wdetail.nmonth  . 
           ------ end : A59-0289-----*/ 
            IF index(wdetail.n_thname,"name") <> 0   THEN DELETE wdetail.
            ELSE IF wdetail.n_thname = " "  THEN DELETE wdetail.
        END.  /* repeat  */
        Run  Pro_createfile.
    END.
    /*-- Create by: A59-0605 ---*/
    ELSE DO:
        INPUT FROM VALUE(fi_FileName).
        REPEAT:
            CREATE wdetail.
            IMPORT DELIMITER "|" 
                wdetail.n_no 
                wdetail.n_chass
                wdetail.n_cvmi
                wdetail.n_thname     
                wdetail.n_applino 
                wdetail.policy70 
                wdetail.n_effecdat   
                wdetail.n_expirdat    
                wdetail.n_si    
                wdetail.n_prem.  
                
        END.  /* repeat  */
        Run  Pro_createfileKK.
    END.
    /*--- End A59-0605 ---*/
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


&Scoped-define SELF-NAME rs_type
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rs_type C-Win
ON VALUE-CHANGED OF rs_type IN FRAME fr_main
DO:
    rs_type = INPUT rs_type .
    DISP rs_type WITH FRAME fr_main.
  
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
  
  gv_prgid = "wgwklmat".
  gv_prog  = "IMPORT TEXT FILE K-Lising Send To KL[ลิสซิ่งกสิกรไทย]".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).

/*********************************************************************/ 
   RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE).  
  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.

  ASSIGN rs_type = 1.
  DISP rs_type WITH FRAME fr_main.
  
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
  DISPLAY rs_type fi_filename fi_outfile 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE rs_type fi_filename fi_outfile bu_ok bu_file bu_exit RECT-76 RECT-77 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chassis C-Win 
PROCEDURE proc_chassis :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR nv_chanew       AS CHAR.
DEFINE VAR nv_len          AS INTE INIT 0.
DEFINE VAR nv_uwm301trareg AS CHAR INIT "" FORMAT "x(30)".

/*ASSIGN nv_uwm301trareg = trim(wdetail.CHASSIS) .*/  /*A59-0298*/
ASSIGN nv_uwm301trareg = trim(wdetail.n_chass) .      /*A59-0298*/
    loop_chk1:
    REPEAT:
        IF INDEX(nv_uwm301trareg,"-") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"-") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"-") + 1, nv_len ) .
        END.
        ELSE LEAVE loop_chk1.
    END.
    loop_chk2:
    REPEAT:
        IF INDEX(nv_uwm301trareg,"/") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"/") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"/") + 1, nv_len ) .
        END.
        ELSE LEAVE loop_chk2.
    END.
    loop_chk3:
    REPEAT:
        IF INDEX(nv_uwm301trareg,";") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,";") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,";") + 1, nv_len ) .
        END.
        ELSE LEAVE loop_chk3.
    END.
    loop_chk4:
    REPEAT:
        IF INDEX(nv_uwm301trareg,".") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,".") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,".") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk4.
    END.
    loop_chk5:
    REPEAT:
        IF INDEX(nv_uwm301trareg,",") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,",") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,",") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk5.
    END.
    loop_chk6:
    REPEAT:
        IF INDEX(nv_uwm301trareg," ") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg," ") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg," ") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk6.
    END.
    loop_chk7:
    REPEAT:
        IF INDEX(nv_uwm301trareg,"\") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"\") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"\") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk7.
    END.
    loop_chk8:
    REPEAT:
        IF INDEX(nv_uwm301trareg,":") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,":") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,":") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk8.
    END.
    loop_chk9:
    REPEAT:
        IF INDEX(nv_uwm301trareg,"|") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"|") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"|") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk9.
    END.
    loop_chk10:
    REPEAT:
        IF INDEX(nv_uwm301trareg,"+") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"+") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"+") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk10.
    END.
    loop_chk11:
    REPEAT:
        IF INDEX(nv_uwm301trareg,"#") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"#") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"#") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk11.
    END.
    loop_chk12:
    REPEAT:
        IF INDEX(nv_uwm301trareg,"[") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"[") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"[") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk12.
    END.
    loop_chk13:
    REPEAT:
        IF INDEX(nv_uwm301trareg,"]") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"]") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"]") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk13.
    END.
    loop_chk14:
    REPEAT:
        IF INDEX(nv_uwm301trareg,"'") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"'") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"+") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk14.
    END.
    loop_chk15:
    REPEAT:
        IF INDEX(nv_uwm301trareg,"(") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"(") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"(") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk15.
    END.
    loop_chk16:
    REPEAT:
        IF INDEX(nv_uwm301trareg,"_") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"_") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"_") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk16.
    END.
    loop_chk17:
    REPEAT:
        IF INDEX(nv_uwm301trareg,"*") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"*") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"*") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk17.
    END.
     loop_chk18:
    REPEAT:
        IF INDEX(nv_uwm301trareg,")") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,")") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,")") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk18.
    END.
    loop_chk19:
    REPEAT:
        IF INDEX(nv_uwm301trareg,"=") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"=") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"=") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk19.
    END.
    /*ASSIGN  wdetail.CHASSIS   =  trim(nv_uwm301trareg).*/  /*A59-0298*/
    ASSIGN wdetail.n_chass =   trim(nv_uwm301trareg).     /*A59-0298*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_createfile C-Win 
PROCEDURE pro_createfile :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  Create by A59-0298     
------------------------------------------------------------------------------*/
If  substr(fi_outfile,length(fi_outfile) - 3,4)  <>  ".slk"  Then
    fi_outfile  =  Trim(fi_outfile) + ".slk"  .
ASSIGN 
    nv_cnt   =  0
    nv_row   =  1 .

OUTPUT STREAM ns2 TO VALUE(fi_outfile).
PUT STREAM ns2 "ID;PND" SKIP.
/* Add by A62-0435 */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"'  "TH_NAME                 "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"'  "APPLICATION_ID          "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"'  "EFFECTIVE_DATE          "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"'  "EXPIRED_DATE            "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"'  "CUSNAME                 "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"'  "TYPE_INSURANCE          "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"'  "CHASSIS                 "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"'  "REGISTER_ID             "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"'  "CREATE_PERSON           "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"'  "WORK_QUEUE_DATE         "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"'  "วันที่ชำระเบี้ย         "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"'  "เลขลงทะเบียน            "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"'  "วันที่ส่งออก            "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"'  "POLICY_VOLUNTARY_NO     "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"'  "POLICY_COMPULSURY_NO    "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"'  "เลข กธ. + พรบ.      "    '"' SKIP. 
/*PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"'  "กธ. + พรบ. ตรวจจ่าย "    '"' SKIP. */
/* end A62-0435 */ 
/* comment by A62-0435 ...
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"'  "No                             "       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"'  "TH_NAME                        "       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"'  "APPLICATION_ID                 "       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"'  "ALO_CONTRACT_NUMBER            "       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"'  "EFFECTIVE_DATE                 "       '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"'  "EXPIRED_DATE                   "       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"'  "CUSNAME                        "       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"'  "GARAGE_TYPE                    "       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"'  "TYPE_INSURANCE                 "       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"'  "MAKE_DESCRIPTION1              "       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"'  "MODEL_DESCRIPTION              "       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"'  "CHASSIS                        "       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"'  "ENGINE                         "       '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"'  "REGISTER_ID                    "       '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"'  "PROVINCE_ID                    "       '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"'  "YEAR                           "       '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"'  "PERSON_IN_CHARGE               "       '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"'  "CREATE_PERSON                  "       '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"'  "WORK_QUEUE_DATE                "       '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"'  "PAYMENT                        "       '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"'  "TRACKING                       "       '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"'  "POST_NO                        "       '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"'  "POLICY_VOLUNTARY_NO            "       '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"'  "POLICY_COMPULSURY_NO           "       '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"'  "หมายเหตุ//กธ.ไม่ออก(ประกันแจ้ง)"       '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"'  "งานติดปัญหาที่ PMIB            "       '"' SKIP.
... end A62-0435...*/ 

RUN Pro_createfile2.                                                        

PUT STREAM ns2 "E".
OUTPUT STREAM ns2 CLOSE.

message "Export File  Complete"  view-as alert-box.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_createfile-old C-Win 
PROCEDURE Pro_createfile-old :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*If  substr(fi_outfile,length(fi_outfile) - 3,4)  <>  ".slk"  Then
    fi_outfile  =  Trim(fi_outfile) + ".slk"  .
ASSIGN 
    nv_cnt   =  0
    nv_row   =  1 .

OUTPUT STREAM ns2 TO VALUE(fi_outfile).
PUT STREAM ns2 "ID;PND" SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"'  "No."                     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"'  "APPLICATION_ID"          '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"'  "CUSNAME"                 '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"'  "ALO_CONTRACT_NUMBER"     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"'  "TH_NAME    "             '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"'  "VMI"                     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"'  "CMI"                     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"'  "EFFECTIVE_DATE"          '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"'  "EXPIRED_DATE"            '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"'  "PERSON_IN_CHARGE"        '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"'  "APPLICATION_SIGN_DATE"   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"'  "CHASSIS"                 '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"'  "REGISTER_ID"             '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"'  "VMI NO."                 '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"'  "CMI NO."                 '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"'  "หมายเหตุ"                '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"'  "เดือน "                  '"' SKIP. 
RUN Pro_createfile2.                                                        

PUT STREAM ns2 "E".
OUTPUT STREAM ns2 CLOSE.

message "Export File  Complete"  view-as alert-box.*/

/*---------------------------------------------------------------------*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_createfile2 C-Win 
PROCEDURE pro_createfile2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR each wdetail  .  
    IF (TRIM(wdetail.n_contractno) = "") AND (trim(wdetail.n_CHASS) = "") THEN NEXT.
    ELSE IF INDEX(TRIM(wdetail.n_contractno),"application") <> 0 THEN NEXT.
    ELSE DO:
        ASSIGN 
            n_policy70 = ""   
            n_policy72 = "" 
            n_pol      = ""
            nv_cnt  =  nv_cnt  + 1                      
            nv_row  =  nv_row + 1. 

        IF wdetail.n_chass <> "" THEN RUN proc_chassis.
        IF TRIM(wdetail.n_contractno) <> "" THEN DO: 
            FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE 
                      sicuw.uwm100.cedpol  = TRIM(wdetail.n_contractno) AND 
                      sicuw.uwm100.poltyp  = "V70"   NO-LOCK NO-ERROR.
                IF AVAIL sicuw.uwm100 THEN ASSIGN n_policy70  = sicuw.uwm100.policy .
                ELSE n_policy70  = "" .
            FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE 
                    sicuw.uwm100.cedpol    = TRIM(wdetail.n_contractno) AND 
                    ((sicuw.uwm100.poltyp  = "V72")    OR 
                     (sicuw.uwm100.poltyp  = "V74" ))  NO-LOCK NO-ERROR.
                IF AVAIL sicuw.uwm100 THEN n_policy72  = sicuw.uwm100.policy .
                ELSE n_policy72  = "" .
        END.
        
        IF n_policy70 = ""  THEN DO:
            FIND LAST sicuw.uwm301 USE-INDEX uwm30103  WHERE
                sicuw.uwm301.trareg = trim(wdetail.n_chass)  AND 
                substr(sicuw.uwm301.policy,3,2) = "70"         NO-LOCK   NO-ERROR .
            IF AVAIL sicuw.uwm301  THEN n_policy70  = sicuw.uwm301.policy .
            ELSE n_policy70 = ""   .
        END.
        IF n_policy72  = "" THEN DO:
            FIND LAST sicuw.uwm301 USE-INDEX uwm30103  WHERE
                sicuw.uwm301.trareg = trim(wdetail.n_chass) AND
                ((substr(sicuw.uwm301.policy,3,2) = "72")    OR 
                (substr(sicuw.uwm301.policy,3,2)  = "74"))   NO-LOCK   NO-ERROR .
            IF AVAIL sicuw.uwm301 THEN n_policy72  = sicuw.uwm301.policy .
            ELSE DO: 
                 FIND LAST sicuw.uwm301  WHERE
                     sicuw.uwm301.cha_no = trim(wdetail.n_chass) AND
                     ((substr(sicuw.uwm301.policy,3,2) = "72")    OR 
                     (substr(sicuw.uwm301.policy,3,2)  = "74"))   NO-LOCK   NO-ERROR .
                    IF AVAIL sicuw.uwm301 THEN n_policy72  = sicuw.uwm301.policy .
                    ELSE n_policy72 = ""   .
            END.
        END.

        IF n_policy70 <> "" THEN DO:
            FIND LAST sicuw.uwm100 WHERE sicuw.uwm100.policy = n_policy70 NO-LOCK NO-ERROR.
            IF AVAIL sicuw.uwm100 THEN DO:
                IF sicuw.uwm100.comdat <> DATE(wdetail.n_effecdat) THEN
                    ASSIGN wdetail.remark = "วันที่ คุ้มครองไม่ตรง : " + string(sicuw.uwm100.comdat).
                IF sicuw.uwm100.expdat <> DATE(wdetail.n_expirdat) THEN
                    ASSIGN wdetail.remark = trim(wdetail.remark + " " + "วันที่สิ้นสุอความคุ้มครองไม่ตรง : " + string(sicuw.uwm100.expdat)).
            END.
        END.

        IF n_policy70 <> "" THEN DO: 
            ASSIGN n_pol = ""
                   n_pol = n_policy70.
            RUN pro_expnote.
        END.
        IF n_policy72 <> "" THEN DO:  
             ASSIGN n_pol = ""
                    n_pol = n_policy72.
            RUN pro_expnote.
        END.
        
        /* add by A62-0435*/
        IF wdetail.policy70 <> "" THEN ASSIGN wdetail.memo = TRIM(n_policy70) .
        ELSE IF wdetail.policy72 <> "" THEN   ASSIGN wdetail.memo = TRIM(n_policy72) .
        ELSE ASSIGN wdetail.memo = "" .

        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"'  wdetail.n_thname     '"' SKIP.    /*TH_NAME             */     
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"'  wdetail.n_contractno '"' SKIP.    /*APPLICATION_ID      */   
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"'  wdetail.n_effecdat  '"' SKIP.    /*EFFECTIVE_DATE      */   
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"'  wdetail.n_expirdat  '"' SKIP.    /*EXPIRED_DATE        */   
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"'  wdetail.n_cusname   '"' SKIP.    /*CUSNAME             */   
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"'  wdetail.n_cvmi      '"' SKIP.    /*TYPE_INSURANCE      */   
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"'  wdetail.n_chass     '"' SKIP.    /*เลขตัวถังรถ         */   
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"'  wdetail.n_licen     '"' SKIP.    /*REGISTER_ID         */   
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"'  wdetail.n_cperson   '"' SKIP.    /*CREATE_PERSON       */   
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"'  wdetail.n_workdate  '"' SKIP.    /*WORK_QUEUE_DATE     */   
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"'  wdetail.n_payment   '"' SKIP.    /*วันที่ชำระเบี้ย     */   
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"'  wdetail.n_post_no   '"' SKIP.    /*เลขลงทะเบียน        */   
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"'  wdetail.n_track     '"' SKIP.    /*วันที่ส่งออก        */   
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"'  wdetail.policy70    '"' SKIP.     /*POLICY_VOLUNTARY_NO */  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"'  wdetail.policy72    '"' SKIP.     /*POLICY_COMPULSURY_NO*/  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"'  wdetail.memo  FORMAT "x(20)"      '"' SKIP.        /*เลข กธ.+ พรบ.       */  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"'  wdetail.remark       '"' SKIP.                                     /*กธ+พรบ.ตรวจจ่าย     */  
        /*end A62-0435..*/
        /* comment by A62-0435 ...
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"'  wdetail.n_no                 '"' SKIP.      /* No                             */
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"'  wdetail.n_thname             '"' SKIP.      /* TH_NAME                        */
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"'  wdetail.n_applino            '"' SKIP.      /* APPLICATION_ID                 */
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"'  wdetail.n_contractno         '"' SKIP.      /* ALO_CONTRACT_NUMBER            */
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"'  wdetail.n_effecdat           '"' SKIP.      /* EFFECTIVE_DATE                 */
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"'  wdetail.n_expirdat           '"' SKIP.      /* EXPIRED_DATE                   */
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"'  wdetail.n_cusname            '"' SKIP.      /* CUSNAME                        */
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"'  wdetail.n_garage             '"' SKIP.      /* GARAGE_TYPE                    */
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"'  wdetail.n_cvmi               '"' SKIP.      /* TYPE_INSURANCE                 */
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"'  wdetail.n_make               '"' SKIP.      /* MAKE_DESCRIPTION1              */
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"'  wdetail.n_model              '"' SKIP.      /* MODEL_DESCRIPTION              */
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"'  wdetail.n_chass              '"' SKIP.      /* CHASSIS                        */
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"'  wdetail.n_engno              '"' SKIP.      /* ENGINE                         */
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"'  wdetail.n_licen              '"' SKIP.      /* REGISTER_ID                    */
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"'  wdetail.n_regis              '"' SKIP.      /* PROVINCE_ID                    */
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"'  wdetail.n_year               '"' SKIP.      /* YEAR                           */
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"'  wdetail.n_charge             '"' SKIP.      /* PERSON_IN_CHARGE               */
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"'  wdetail.n_cperson            '"' SKIP.      /* CREATE_PERSON                  */
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"'  wdetail.n_workdate           '"' SKIP.      /* WORK_QUEUE_DATE                */
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"'  wdetail.n_payment            '"' SKIP.      /* PAYMENT                        */
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"'  wdetail.n_track              '"' SKIP.      /* TRACKING                       */
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"'  wdetail.n_post_no            '"' SKIP.      /* POST_NO                        */
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"'  n_policy70                   '"' SKIP.      /* POLICY_VOLUNTARY_NO            */
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"'  n_policy72                   '"' SKIP.      /* POLICY_COMPULSURY_NO           */
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"'  wdetail.memo                 '"' SKIP.      /* หมายเหตุ//กธ.ไม่ออก(ประกันแจ้ง)*/
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"'  wdetail.remark               '"' SKIP.      /* งานติดปัญหาที่ PMIB            */
        end A62-0435..*/

     END.                                                                                      
END.  /*  end  wdetail  */                                                       
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_createfile2-old C-Win 
PROCEDURE Pro_createfile2-old :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*DEF VAR n_policy70 AS CHAR FORMAT "x(20)" INIT "".
DEF VAR n_policy72 AS CHAR FORMAT "x(20)" INIT "".
FOR each wdetail  .  
    IF (TRIM(wdetail.ALO_CONTRACT_NUMBER) = "") AND (trim(wdetail.CHASSIS) = "") THEN NEXT.
    ELSE IF INDEX(TRIM(wdetail.ALO_CONTRACT_NUMBER),"ALO_CONTRACT") <> 0 THEN NEXT.
    ELSE DO:
        ASSIGN 
            n_policy70 = ""   
            n_policy72 = ""   
            nv_cnt  =  nv_cnt  + 1                      
            nv_row  =  nv_row + 1. 
        IF TRIM(wdetail.APPLICATION_ID) <> "" THEN DO: 
            FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE 
                sicuw.uwm100.cedpol  = TRIM(wdetail.APPLICATION_ID) AND 
                sicuw.uwm100.poltyp  = "V70"   NO-LOCK NO-ERROR.
            IF AVAIL sicuw.uwm100 THEN n_policy70  = sicuw.uwm100.policy .
            ELSE n_policy70  = "" .
            FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE 
                sicuw.uwm100.cedpol    = TRIM(wdetail.APPLICATION_ID) AND 
                ((sicuw.uwm100.poltyp  = "V72")    OR 
                 (sicuw.uwm100.poltyp  = "V74" ))  NO-LOCK NO-ERROR.
            IF AVAIL sicuw.uwm100 THEN n_policy72  = sicuw.uwm100.policy .
            ELSE n_policy72  = "" .
        END.
        IF wdetail.CHASSIS <> "" THEN RUN proc_chassis.
        IF n_policy70 = ""  THEN DO:
            FIND LAST sicuw.uwm301 USE-INDEX uwm30103  WHERE
                sicuw.uwm301.trareg = trim(wdetail.CHASSIS)  AND 
                substr(sicuw.uwm301.policy,3,2) = "70"         NO-LOCK   NO-ERROR .
            IF AVAIL sicuw.uwm301  THEN n_policy70  = sicuw.uwm301.policy .
            ELSE n_policy70 = ""   .
        END.
        IF n_policy72  = "" THEN DO:
            FIND LAST sicuw.uwm301 USE-INDEX uwm30103  WHERE
                sicuw.uwm301.trareg = trim(wdetail.CHASSIS)  AND
                ((substr(sicuw.uwm301.policy,3,2) = "72")    OR
                (substr(sicuw.uwm301.policy,3,2)  = "74"))   NO-LOCK   NO-ERROR .
            IF AVAIL sicuw.uwm301 THEN n_policy72  = sicuw.uwm301.policy .
            ELSE n_policy72 = ""   .
        END.
        IF n_policy70 <> "" THEN DO:
            FIND LAST sicuw.uwm100 WHERE sicuw.uwm100.policy = n_policy70 NO-LOCK NO-ERROR.
            IF AVAIL sicuw.uwm100 THEN DO:
                IF sicuw.uwm100.comdat <> DATE(wdetail.EFFECTIVE_DATE) THEN
                    ASSIGN wdetail.remark = "วันที่ คุ้มครองไม่ตรง : " + string(sicuw.uwm100.comdat).
                IF sicuw.uwm100.expdat <> DATE(wdetail.EXPIRED_DATE) THEN
                    ASSIGN wdetail.remark = trim(wdetail.remark + " " + "วันที่สิ้นสุอความคุ้มครองไม่ตรง : " + string(sicuw.uwm100.expdat)).
            END.
        END.
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"'   wdetail.number                     '"' SKIP.     
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"'   wdetail.APPLICATION_ID             '"' SKIP. 
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"'   wdetail.CUSNAME                    '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"'   wdetail.ALO_CONTRACT_NUMBER        '"' SKIP.    
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'   wdetail.TH_NAME                    '"' SKIP.     
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"'   wdetail.VMI                        '"' SKIP.     
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"'   wdetail.CMI                        '"' SKIP.     
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"'   wdetail.EFFECTIVE_DATE             '"' SKIP.     
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"'   wdetail.EXPIRED_DATE               '"' SKIP.     
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"'   wdetail.PERSON_IN_CHARGE           '"' SKIP.     
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"'   wdetail.APPLICATION_SIGN_DATE      '"' SKIP.     
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"'   wdetail.CHASSIS                    '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"'   wdetail.REGISTER_ID                '"' SKIP.
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"'   n_policy70                         '"' SKIP. 
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"'   n_policy72                         '"' SKIP. 
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"'   wdetail.memo                       '"' SKIP. 
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"'   wdetail.nmonth                     '"' SKIP. 
     END.                                                                                      
END.  /*  end  wdetail  */   */                                                    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_createfileKK C-Win 
PROCEDURE pro_createfileKK :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

If  substr(fi_outfile,length(fi_outfile) - 3,4)  <>  ".CSV"  Then
    fi_outfile  =  Trim(fi_outfile) + ".CSV"  .
ASSIGN 
    nv_cnt   =  0
    nv_row   =  1 .

OUTPUT TO VALUE(fi_outfile).
EXPORT DELIMITER "|"
"No. "                    
"CHASNO "                 
"INSURANCE_TYPE "         
"INSURANCE_COMP_CODE"     
"NOTIFICATION_NO "        
"POLICY_NO  "             
"EFFECTIVE_DATE"          
"EXPIRY_DATE  "           
"COVERAGE_AMT "           
"GROSS_PREM_AMT"   .

RUN Pro_createfileKK2.  
OUTPUT CLOSE.

/*PUT STREAM ns2 "E".
OUTPUT STREAM ns2 CLOSE.*/

message "Export File  Complete"  view-as alert-box.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_createfileKK2 C-Win 
PROCEDURE pro_createfileKK2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR each wdetail  .  
    IF trim(wdetail.n_no) = "" AND trim(wdetail.n_CHASS) = "" THEN NEXT.   
    ELSE IF INDEX(TRIM(wdetail.n_no),"No") <> 0 OR INDEX(TRIM(wdetail.n_no),"no") <> 0 THEN NEXT.
    ELSE DO:
        ASSIGN 
            n_pol   = ""    n_recnt = 0     n_encnt = 0
            nv_cnt  =  nv_cnt  + 1 . 
        IF trim(wdetail.n_CHASS) <> "" THEN DO: 
             ASSIGN wdetail.n_thname = "200" .
             FIND LAST sicuw.uwm301 USE-INDEX uwm30121  WHERE sicuw.uwm301.cha_no = trim(wdetail.n_CHASS) AND 
                                                              sicuw.uwm301.tariff = "X" NO-LOCK NO-ERROR NO-WAIT.
             IF AVAIL sicuw.uwm301 THEN DO:
                 ASSIGN wdetail.policy70 = sicuw.uwm301.policy
                        wdetail.n_cvmi   = sicuw.uwm301.covcod.

                 FIND LAST sicuw.uwm130 USE-INDEX uwm13002         WHERE                      
                     sicuw.uwm130.policy = sicuw.uwm301.policy   AND                        
                     sicuw.uwm130.rencnt = sicuw.uwm301.rencnt   AND                        
                     sicuw.uwm130.endcnt = sicuw.uwm301.endcnt   AND                        
                     sicuw.uwm130.riskno = sicuw.uwm301.riskno   AND                        
                     sicuw.uwm130.itemno = sicuw.uwm301.itemno   NO-LOCK NO-ERROR NO-WAIT.  
                    IF AVAIL sicuw.uwm130 THEN
                        ASSIGN wdetail.n_si = string(sicuw.uwm130.uom6_v,"->>>>>>>>>9.99").
                    ELSE ASSIGN wdetail.n_si = "".

                FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE uwm100.policy = sicuw.uwm301.policy AND
                                                                uwm100.rencnt = sicuw.uwm301.rencnt AND
                                                                uwm100.endcnt = sicuw.uwm301.endcnt NO-LOCK NO-ERROR.
                    IF AVAIL sicuw.uwm100 THEN 
                        ASSIGN wdetail.n_applino  = sicuw.uwm100.cedpol 
                               wdetail.n_effecdat = STRING(YEAR(sicuw.uwm100.comdat),"9999") + STRING(MONTH(sicuw.uwm100.comdat),"99") + STRING(DAY(sicuw.uwm100.comdat),"99")                    
                               wdetail.n_expirdat = STRING(YEAR(sicuw.uwm100.expdat),"9999") + STRING(MONTH(sicuw.uwm100.expdat),"99") + STRING(DAY(sicuw.uwm100.expdat),"99")
                               wdetail.n_prem     = STRING(sicuw.uwm100.prem_t,"->>>>>>>>>9.99") .
                    ELSE ASSIGN wdetail.n_applino = ""
                               wdetail.n_effecdat = ""                    
                               wdetail.n_expirdat = ""
                               wdetail.n_prem     = "" .
             END.
        END.
        nv_row  =  nv_row + 1 .
        EXPORT DELIMITER "|"
            wdetail.n_no      
            wdetail.n_chass     
            wdetail.n_cvmi      
            wdetail.n_thname    
            wdetail.n_applino   
            wdetail.policy70    
            wdetail.n_effecdat  
            wdetail.n_expirdat  
            wdetail.n_si        
            wdetail.n_prem  .
        /*PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"'  wdetail.n_no               '"' SKIP.     
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"'  wdetail.n_chass            '"' SKIP.     
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"'  wdetail.n_cvmi             '"' SKIP.     
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"'  wdetail.n_thname           '"' SKIP.     
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"'  wdetail.n_applino          '"' SKIP.     
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"'  wdetail.policy70           '"' SKIP.     
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"'  wdetail.n_effecdat         '"' SKIP.     
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"'  wdetail.n_expirdat         '"' SKIP.     
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"'  wdetail.n_si               '"' SKIP.     
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"'  wdetail.n_prem             '"' SKIP.   */   
        
     END.                                                                                      
END.  /*  end  wdetail  */                                                       
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_expnote C-Win 
PROCEDURE pro_expnote :
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
DEF VAR nv_name         AS CHAR FORMAT "x(25)".
DEF VAR n_ems           AS CHAR FORMAT "x(14)".
DEF VAR nt_name         AS CHAR FORMAT "x(25)".
DEF VAR nt_policyno     AS CHAR FORMAT "x(12)".    
DEF VAR nt_date         AS DATE FORMAT "99/99/9999".     
DEF VAR nt_ems          AS CHAR FORMAT "x(14)".
DEF VAR n_snote         AS CHAR FORMAT "X(25)".

ASSIGN n_day       = STRING(TODAY,"99/99/9999")
       n_year      = SUBSTR(n_day,9,2)
       n_snote     = "postdocument" + n_year + ".nsf"
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
       nv_tmp    = "U:\Lotus\Notes\Data\" + n_snote.
       chNotesDatabase = chNotesSession:GetDatabase ("",nv_tmp).
       -------------------------------*/
       IF chNotesDatabase:IsOpen() = NO  THEN  DO:
          MESSAGE "Can not open database" SKIP  
                  "Please Check database and serve" VIEW-AS  ALERT-BOX ERROR.
       END.
       chNotesView      = chNotesDatabase:GetView("ByPol").
       chnotecollection = chNotesView:GetallDocumentsByKey(n_pol).
       chDocument       = chnotecollection:GetlastDocument.
       IF VALID-HANDLE(chDocument) = YES THEN DO:
            chitem       = chDocument:Getfirstitem("PolicyNo"). 
            nt_policyno  = chitem:TEXT.                      
            chitem       = chDocument:Getfirstitem("EmsNo").     
            nt_ems       = chitem:TEXT.
            chitem       = chDocument:Getfirstitem("Date").     
            nt_date      = chitem:TEXT.                
           
        IF nt_ems <> "" THEN DO:
            ASSIGN wdetail.n_post_no   = TRIM(nt_ems)
                   wdetail.n_track     = STRING(nt_date,"99/99/9999"). /*A62-0435*/
        END.
        ELSE DO: 
            ASSIGN wdetail.n_post_no   = "-" 
                   wdetail.n_track     = "-".  /*A62-0435*/
        END.
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

