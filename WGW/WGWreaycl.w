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
/*Program ID   : wgwmtscb3.w                                                */
/*Program name : Match File Load and Update Data TLT                        */
/*create by    : Ranu i. A61-0573  date. 10/02/2019
                โปรแกรม match file สำหรับโหลดเข้า GW และ Match Policy no on TLT */
/*              Match file Load , match policy no                            */
/*DataBase connect : GW_SAFE -LD SIC_BRAN, GW_STAT -LD BRSTAT,SICSYAC,SICUW */
/*Modify by   : Kridtiya i. A63-0472 Date. 09/11/2020  เพิ่ม Group Producer = B3MLAY0100 */
/*---------------------------------------------------------------------------*/
DEF VAR gv_id  AS CHAR FORMAT "X(12)" NO-UNDO.      
DEF VAR n_user  AS CHAR FORMAT "X(12)" NO-UNDO.
DEF VAR nv_pwd AS CHAR FORMAT "x(15)" NO-UNDO. 
DEF  stream ns1.
DEFINE VAR  nv_daily       AS CHARACTER FORMAT "X(1024)"     INITIAL ""  NO-UNDO.
DEFINE VAR  nv_reccnt      AS  INT  INIT  0.
DEFINE VAR  nv_completecnt AS   INT   INIT  0.
DEFINE VAR  nv_enttim      AS  CHAR          INIT  "".
DEFINE VAR  nv_export      as  date  init  ""  format "99/99/9999".
DEF stream  ns2.
DEFINE VAR nv_file1        AS CHARACTER FORMAT "X(100)"     INITIAL ""  NO-UNDO.
DEFINE VAR nv_file2        AS CHARACTER FORMAT "X(100)"     INITIAL ""  NO-UNDO.
{wgw/wgwmtaycl.i}
/*--------------------------สำหรับข้อมูลกรมธรรม์  -------------------------*/
DEF NEW SHARED TEMP-TABLE wdetail NO-UNDO
    FIELD   Codecompany  AS CHAR FORMAT "X(10)"   INIT ""   /*INSURANCE   */                                  
    FIELD   renew        AS CHAR FORMAT "X(10)"   INIT ""   /*YEAR        */                                                      
    FIELD   Branch       AS CHAR FORMAT "X(10)"   INIT ""   /*BRANCH      */                                   
    FIELD   Contract     AS CHAR FORMAT "X(10)"   INIT ""   /*CONTRACT    */                                
    FIELD   name1        AS CHAR FORMAT "X(10)"   INIT ""   /*NAME        */                            
    FIELD   notify       AS CHAR FORMAT "x(20)"   INIT ""   /*เลขรับแจ้ง  */                                
    FIELD   vehreg       AS CHAR FORMAT "X(10)"   INIT ""   /*ทะเบียน     */                                
    FIELD   provin       AS CHAR FORMAT "X(10)"   INIT ""   /*จังหวัด     */                                
    FIELD   chassis      AS CHAR FORMAT "X(10)"   INIT ""   /*BODY        */                                                  
    FIELD   engno        AS CHAR FORMAT "X(10)"   INIT ""   /*ENGINE      */                                                      
    FIELD   comdat70     AS CHAR FORMAT "X(10)"   INIT ""   /*วันคุ้มครอง */                                                      
    FIELD   premtnet     AS CHAR FORMAT "X(10)"   INIT ""   /*เบี้ยรวม    */                  
    FIELD   recivedat    AS CHAR FORMAT "x(10)"   INIT ""   /*ชำระล่าสุด  */                  
    FIELD   policy       AS CHAR FORMAT "X(10)"   INIT ""   /*เลขกรมธรรม์ */                  
    field   sumins       AS CHAR FORMAT "x(20)"   INIT ""   /*ทุนประกัน   */                  
    field   comdate      AS CHAR FORMAT "x(15)"   INIT ""   /*วันคุ้มครอง */                  
    field   EXPdate      AS CHAR FORMAT "x(15)"   INIT ""   /*วันสิ้นสุด  */                  
    field   netprem      AS CHAR FORMAT "x(15)"   INIT ""   /*เบี้ยสุทธิ  */                  
    field   totalprem    AS CHAR FORMAT "x(20)"   INIT ""   /*เบี้ยรวม    */                  
    FIELD   remark       AS CHAR FORMAT "X(250)"  INIT ""   /*เหตุผลที่ยังไม่ออกกรมธรรม์*/
    FIELD   ERROR        AS CHAR FORMAT "X(250)"  INIT "" . /*เหตุผลที่ยังไม่ออกกรมธรรม์*/ 

DEF VAR n_char AS CHAR FORMAT "x(500)" INIT "" .
DEF VAR nv_cnt  as int init 0.
DEF VAR nv_row  as int init 0.
/*DEF VAR nv_oldpol  AS CHAR FORMAT "x(15)" INIT "".
DEF VAR nv_output   AS CHAR FORMAT "x(60)" INIT "".
DEF VAR nv_policy AS CHAR FORMAT "X(13)" INIT "" .
DEF VAR np_title     AS CHAR FORMAT "x(30)"     INIT "" .
DEF VAR np_name      AS CHAR FORMAT "x(40)"     INIT "" .
DEF VAR np_name2     AS CHAR FORMAT "x(40)"     INIT "" .
DEF VAR nv_isp      AS CHAR FORMAT "x(20)" INIT "" .*/
DEF VAR n_record   AS INT INIT 0.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_loadname fi_outload bu_file-3 bu_ok ~
bu_exit-2 RECT-381 RECT-382 RECT-383 
&Scoped-Define DISPLAYED-OBJECTS fi_loadname fi_outload 

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
     SIZE 60 BY 1.19
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_outload AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY 1.19
     BGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-381
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 105 BY 6.91
     BGCOLOR 19 FGCOLOR 2 .

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
     fi_loadname AT ROW 3.76 COL 26 COLON-ALIGNED NO-LABEL
     fi_outload AT ROW 5.05 COL 26 COLON-ALIGNED NO-LABEL
     bu_file-3 AT ROW 3.81 COL 89
     bu_ok AT ROW 7.33 COL 86.33
     bu_exit-2 AT ROW 7.33 COL 96.5
     "OUTPUT FILE:" VIEW-AS TEXT
          SIZE 15 BY 1 AT ROW 5 COL 11.83
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "IMPORT FILE :" VIEW-AS TEXT
          SIZE 15 BY 1 AT ROW 3.76 COL 11.83
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "   Match Report File Excel Send AY" VIEW-AS TEXT
          SIZE 105 BY 1.57 AT ROW 1.1 COL 1.17
          BGCOLOR 10 FGCOLOR 1 FONT 2
     "Day:03/02/2021" VIEW-AS TEXT
          SIZE 22 BY 1.19 AT ROW 7.67 COL 55.5 WIDGET-ID 2
          BGCOLOR 19 
     RECT-381 AT ROW 2.67 COL 1.33
     RECT-382 AT ROW 6.91 COL 95.17
     RECT-383 AT ROW 6.91 COL 85.17
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 105.5 BY 8.71
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
         TITLE              = "Match text  File AYCAL (New Format)"
         HEIGHT             = 8.76
         WIDTH              = 105.67
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
       bu_file-3:AUTO-RESIZE IN FRAME fr_main      = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Match text  File AYCAL (New Format) */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Match text  File AYCAL (New Format) */
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
          no_add = STRING(MONTH(TODAY),"99")    + 
                   STRING(DAY(TODAY),"99")      + 
                   SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                   SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) .
        fi_loadname  = cvData.
        fi_outload   = SUBSTR(fi_loadname,1,R-INDEX(fi_loadname,".") - 1 ) + "_polmatch_" + NO_add.
        DISP fi_loadname fi_outload   WITH FRAME fr_main .     
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
    RUN proc_match70.    
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
      gv_prgid          = "WGWREAYCL".
      
  gv_prog  = "Match File Policy Send To AYCL".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).
  /*RUN proc_createpack.*/
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
  DISPLAY fi_loadname fi_outload 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_loadname fi_outload bu_file-3 bu_ok bu_exit-2 RECT-381 RECT-382 
         RECT-383 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_match70 C-Win 
PROCEDURE proc_match70 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR np_commfile AS CHAR FORMAT "x(15)".
DEF VAR np_comdate AS CHAR FORMAT "x(15)".
DEF VAR np_year AS INT INIT 0.

FOR EACH  wdetail :
    DELETE  wdetail.
END.
INPUT FROM VALUE(fi_loadname).
REPEAT:
    CREATE wdetail.
    IMPORT DELIMITER "|" 
        wdetail.Codecompany   /*  INSURANCE   */
        wdetail.renew         /*  YEAR        */
        wdetail.Branch        /*  BRANCH      */
        wdetail.Contract      /*  CONTRACT    */
        wdetail.name1         /*  NAME        */
        wdetail.notify        /*  เลขรับแจ้ง  */
        wdetail.vehreg        /*  ทะเบียน     */      
        wdetail.provin        /*  จังหวัด     */   
        wdetail.chassis       /*  BODY        */      
        wdetail.engno         /*  ENGINE      */
        wdetail.comdat70      /*  วันคุ้มครอง */
        wdetail.premtnet      /*  เบี้ยรวม    */
        wdetail.recivedat.    /*  ชำระล่าสุด  */
END.

FOR EACH wdetail .
   IF wdetail.chassis  = "" THEN DELETE wdetail.
   ELSE IF wdetail.chassis = "BODY" THEN DELETE wdetail.
   ELSE DO:
       ASSIGN np_year          = INT(SUBSTR(wdetail.comdat70,1,2)) + 2500
              np_commfile      = SUBSTR(wdetail.comdat70,5,2) + "/" + SUBSTR(wdetail.comdat70,3,2) + "/" + STRING(np_year - 543)
              np_commfile      = string(DATE(np_commfile),"99/99/9999") .

         FOR EACH sicuw.uwm301 USE-INDEX uwm30103  WHERE
             sicuw.uwm301.trareg  = trim(wdetail.chassis) AND
             sicuw.uwm301.eng_no  = TRIM(wdetail.engno)   AND
             substr(sicuw.uwm301.policy,3,2) = "70"       NO-LOCK .

             /*FOR EACH sicsyac.xmm600 USE-INDEX xmm60009 WHERE sicsyac.xmm600.gpstmt = "A0M0061" NO-LOCK.  */ /*A63-0472*/
             FOR EACH sicsyac.xmm600 USE-INDEX xmm60009 WHERE sicsyac.xmm600.gpstmt = "B3MLAY0100" NO-LOCK.    /*A63-0472*/
              FIND sicuw.uwm100 USE-INDEX uwm10001 WHERE 
                   sicuw.uwm100.policy  = sicuw.uwm301.policy  AND
                   sicuw.uwm100.rencnt  = sicuw.uwm301.rencnt  AND 
                   sicuw.uwm100.endcnt  = sicuw.uwm301.endcnt  NO-LOCK NO-ERROR. 
                IF AVAIL uwm100 THEN DO:
                    ASSIGN np_comdate = ""
                           np_comdate = STRING(sicuw.uwm100.comdat,"99/99/9999").

                    IF sicuw.uwm100.acno1  <>  sicsyac.xmm600.acno THEN NEXT.
                    IF YEAR(DATE(np_comdate)) < YEAR(DATE(np_commfile)) THEN NEXT.

                    IF DATE(np_comdate) = DATE(np_commfile) THEN DO:
                     ASSIGN  wdetail.policy    = sicuw.uwm100.policy
                             wdetail.comdate   = STRING(sicuw.uwm100.comdat,"99/99/9999")
                             wdetail.expdate   = STRING(sicuw.uwm100.expdat,"99/99/9999")
                             wdetail.sumins    = STRING(sicuw.uwm100.sigr_p,"->>>>>>>>>>>9.99")
                             wdetail.netprem   = STRING(sicuw.uwm100.gap_p,"->>>>>>>>>9.99")
                             wdetail.totalprem = STRING((sicuw.uwm100.gap_p + uwm100.rstp_t + uwm100.rtax_t),"->>>>>>>>>>9.99")
                             wdetail.ERROR     = string(sicuw.uwm100.releas)+ "/" + sicuw.uwm100.acno1 .
                    END.
                    ELSE wdetail.ERROR = "เช็ควันที่คุ้มครองในไฟล์กับระบบพรีเมียม " .
                END.
             END.
         END.
         IF wdetail.ERROR = ""  THEN DO:
             FOR EACH sicuw.uwm301 USE-INDEX uwm30121 WHERE
                      sicuw.uwm301.cha_no  = TRIM(wdetail.chassis) AND 
                      sicuw.uwm301.eng_no  = TRIM(wdetail.engno)   AND
                      substr(sicuw.uwm301.policy,3,2) = "70"       NO-LOCK  .

                 /*FOR EACH sicsyac.xmm600 USE-INDEX xmm60009 WHERE sicsyac.xmm600.gpstmt = "A0M0061" NO-LOCK.*/  /*A63-0472*/
                 FOR EACH sicsyac.xmm600 USE-INDEX xmm60009 WHERE sicsyac.xmm600.gpstmt = "B3MLAY0100" NO-LOCK.   /*A63-0472*/
                    FIND sicuw.uwm100 USE-INDEX uwm10001 WHERE 
                          sicuw.uwm100.policy  = sicuw.uwm301.policy  AND
                          sicuw.uwm100.rencnt  = sicuw.uwm301.rencnt  AND 
                          sicuw.uwm100.endcnt  = sicuw.uwm301.endcnt  AND
                          sicuw.uwm100.acno1   = sicsyac.xmm600.acno  NO-LOCK NO-ERROR. 
                       IF AVAIL uwm100 THEN DO:
                           ASSIGN np_comdate = ""
                                  np_comdate = STRING(sicuw.uwm100.comdat,"99/99/9999").

                           IF sicuw.uwm100.acno1  <>  sicsyac.xmm600.acno THEN NEXT.
                           IF YEAR(DATE(np_comdate)) < YEAR(DATE(np_commfile)) THEN NEXT.

                           IF DATE(np_comdate) = DATE(np_commfile) THEN DO:
                               ASSIGN  wdetail.policy    = sicuw.uwm100.policy
                                       wdetail.comdate   = STRING(sicuw.uwm100.comdat,"99/99/9999")
                                       wdetail.expdate   = STRING(sicuw.uwm100.expdat,"99/99/9999")
                                       wdetail.sumins    = STRING(sicuw.uwm100.sigr_p,"->>>>>>>>>>>9.99")
                                       wdetail.netprem   = STRING(sicuw.uwm100.gap_p,"->>>>>>>>>9.99")
                                       wdetail.totalprem = STRING((sicuw.uwm100.gap_p + uwm100.rstp_t + uwm100.rtax_t),"->>>>>>>>>>9.99")
                                       wdetail.ERROR     = string(sicuw.uwm100.releas)+ "/" + sicuw.uwm100.acno1 .
                           END.
                           ELSE wdetail.ERROR = "เช็ควันที่คุ้มครองในไฟล์กับระบบพรีเมียม " .
                       END.
                 END.
             END.

         END.
                  
       RELEASE sicuw.uwm100.
       RELEASE sicuw.uwm301.
   END. /* else do */
END. /*wdetail */
RUN proc_report70.
Message "Export data Complete"  View-as alert-box.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_match72 C-Win 
PROCEDURE proc_match72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*DEF VAR np_expdat AS CHAR FORMAT "x(15)".
DEF VAR np_year AS INT INIT 0.
DEF BUFFER bftlt FOR brstat.tlt.

FOR EACH  wdetail :
    DELETE  wdetail.
END.
INPUT FROM VALUE(fi_loadname).
REPEAT:
    CREATE wdetail.
    IMPORT DELIMITER "|"
        wdetail.renew         /* seq */
        wdetail.Codecompany   /*  INSURANCE   */
        wdetail.Contract      /*  CONTRACT    */
        wdetail.Branch        /*  BRANCH      */
        wdetail.chassis       /*  BODY        */      
        wdetail.engno         /*  ENGINE      */
        wdetail.comdat70      /*  Startdate */
        wdetail.recivedat .    /* Enddate  */
END.
FOR EACH wdetail .
   IF wdetail.chassis  = "" THEN DELETE wdetail.
   ELSE IF wdetail.chassis = "BODY" THEN DELETE wdetail.
   ELSE DO:
       ASSIGN np_year          = INT(SUBSTR(wdetail.comdat70,1,2)) + 2500
              wdetail.comdat70 = SUBSTR(wdetail.comdat70,5,2) + "/" + SUBSTR(wdetail.comdat70,3,2) + "/" + STRING(np_year - 543)
              wdetail.comdat70 = string(DATE(wdetail.comdat70),"99/99/9999")

              np_year          = INT(SUBSTR(wdetail.recivedat,1,2)) + 2500
              wdetail.recivedat = SUBSTR(wdetail.recivedat,5,2) + "/" + SUBSTR(wdetail.recivedat,3,2) + "/" + STRING(np_year - 543)
              wdetail.recivedat = STRING(DATE(wdetail.recivedat),"99/99/9999").

      
       FOR EACH sicuw.uwm100 USE-INDEX uwm10002 WHERE sicuw.uwm100.cedpol = trim(wdetail.contract) NO-LOCK BREAK BY sicuw.uwm100.expdat DESCENDING. 
             IF sicuw.uwm100.poltyp <> "V72" THEN NEXT.
             ELSE IF YEAR(sicuw.uwm100.expdat) <= YEAR(TODAY)  THEN NEXT.
             ELSE DO:
                 ASSIGN np_expdat = ""
                        np_expdat = STRING(sicuw.uwm100.expdat,"99/99/9999").
                
                 IF DATE(np_expdat) = DATE(wdetail.recivedat) THEN DO:
                     ASSIGN  wdetail.policy  = sicuw.uwm100.policy.
                     FIND LAST brstat.tlt USE-INDEX tlt05  WHERE   
                         brstat.tlt.cha_no  =  trim(wdetail.chassis) AND              
                         brstat.tlt.genusr  =  "AYCAL"             AND
                         brstat.tlt.flag    =  "V72"      NO-ERROR NO-WAIT. 
                         IF AVAIL brstat.tlt THEN DO:
                             ASSIGN brstat.tlt.releas = "YES".
                             IF brstat.tlt.policy     = ""  THEN 
                                 ASSIGN brstat.tlt.policy  = wdetail.policy
                                        wdetail.remark     = brstat.tlt.releas.

                            FIND LAST bftlt WHERE 
                                bftlt.cha_no       = tlt.cha_no   AND             /* เลขถัง */         
                                bftlt.eng_no       = tlt.eng_no   AND             /* เลขเครื่อง */     
                                bftlt.nor_noti_ins = tlt.nor_noti_ins  and        /* เลขที่อ้างอิง*/   
                                bftlt.nor_usr_ins  = tlt.nor_usr_ins   and        /* เลขที่ลูกค้า */   
                                bftlt.flag         = tlt.flag   AND               /* ประเภท 70 ,72 */  
                                bftlt.genusr       = tlt.genusr     NO-ERROR NO-WAIT  . 
                            IF AVAIL bftlt THEN DO:
                                ASSIGN brstat.tlt.colorcod  = "CON:" + trim(wdetail.Contract) + " " +
                                                              "BR:" + TRIM(wdetail.branch) .
                            END.
                            RELEASE bftlt.
                         END.
                         RELEASE brstat.tlt.
                 END.
                 ELSE ASSIGN wdetail.policy = ""  wdetail.remark  = "กรุณาตรวจสอบข้อมูลอีกครั้ง ".
             END.
       END.
       RELEASE sicuw.uwm100.
   END. /* else do */
END. /*wdetail */
RUN proc_report72.
Message "Export data Complete"  View-as alert-box.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_report70 C-Win 
PROCEDURE proc_report70 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    If  substr(fi_outload,length(fi_outload) - 3,4) <>  ".CSV"  THEN 
        fi_outload  =  Trim(fi_outload) + ".CSV"  .
    ASSIGN nv_cnt =  0
           nv_row  =  1.
    OUTPUT TO VALUE(fi_outload).
        EXPORT DELIMITER "|" 
             "INSURANCE   "
             "YEAR        "
             "BRANCH      "
             "CONTRACT    "
             "NAME        "
             "เลขรับแจ้ง  "
             "ทะเบียน     "
             "จังหวัด     "
             "BODY        "
             "ENGINE      "
             "วันคุ้มครอง "
             "เบี้ยรวม    "
             "ชำระล่าสุด  "
             "เลขกรมธรรม์ "
             "ทุนประกัน   "
             "วันคุ้มครอง "
             "วันสิ้นสุด  "
             "เบี้ยสุทธิ  "
             "เบี้ยรวม    "
             "เหตุผลที่ยังไม่ออกกรมธรรม์" .

        FOR EACH wdetail NO-LOCK.
            nv_row = nv_row + 1 .
            EXPORT DELIMITER "|"
                wdetail.Codecompany 
                wdetail.renew       
                wdetail.Branch      
                wdetail.Contract    
                wdetail.name1       
                wdetail.notify      
                wdetail.vehreg      
                wdetail.provin      
                wdetail.chassis     
                wdetail.engno       
                wdetail.comdat70    
                wdetail.premtnet    
                wdetail.recivedat
                wdetail.policy    
                wdetail.sumins    
                wdetail.comdate   
                wdetail.EXPdate   
                wdetail.netprem   
                wdetail.totalprem 
                wdetail.remark
                wdetail.ERROR SKIP .
        END.
    OUTPUT CLOSE.
END.
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_report72 C-Win 
PROCEDURE proc_report72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*DO:
    If  substr(fi_outload,length(fi_outload) - 3,4) <>  ".CSV"  THEN 
        fi_outload  =  Trim(fi_outload) + ".CSV"  .
    OUTPUT TO VALUE(fi_outload).
    EXPORT DELIMITER "|" 
        " seq         "             
        " INSURANCE   "    
        " CONTRACT    "    
        " BRANCH      "    
        " BODY        "    
        " ENGINE      "    
        " Startdate   "      
        " Enddate     " 
        " policy      " .

    nv_row = 0.
    FOR EACH wdetail NO-LOCK.
        nv_row = nv_row + 1 .
        EXPORT DELIMITER "|"
            wdetail.renew  
            wdetail.Codecompany 
            wdetail.Contract
            wdetail.Branch
            wdetail.chassis
            wdetail.engno 
            wdetail.comdat70  
            wdetail.recivedat
            wdetail.policy
            wdetail.remark SKIP .
    END.
    OUTPUT CLOSE.
END.*/
    

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

