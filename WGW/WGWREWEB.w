&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*************************************************************************
 WRSBQCpL.W  : Queue send Inspection Motor to DB BUExt
 Copyright   : Safety Insurance Public Company Limited
               บริษัท ประกันคุ้มภัย จำกัด (มหาชน)
-------------------------------------------------------------------------
 Database    : 
 connect BUInt                  -H 18.10.100.5  -S 5502 -N TCP -U pdmgr0 -P 95mJbWF.
CONNECT SIC_BRAN -ld CTXBRAN   -H 18.10.100.5  -S 3092  -N TCP -U pdmgr0 -P pdmgr0.
CONNECT stat   - ld CTXSTAT                -H 18.10.100.5  -S 9041  -N TCP -U pdmgr0 -P pdmgr0.
CONNECT gwctx                  -H 18.10.100.5  -S 10011 -N TCP -U pdmgr0 -P pdmgr0.
CONNECT gw_safe  -ld sic_bran  -H 18.10.100.5  -S gw_safe -N tcp -U pdmgr0 -P pdmgr0.
CONNECT sicuw                  -H 18.10.100.5 -S sicuw   -N tcp -U pdmgr0 -P pdmgr0.
*************************************************************************/
/*
 Create by   : Kridtiya i. A64-0171  date. 19/07/2021
 program id  : WGWREWEB.w
 programname :   export data policy web to premium compare */
/*------------------------------------------------------------------------

  File: 

  Description: 

  Input Parameters:
      <none>
  Output Parameters:
      <none>
  Author: 
  Created: 
  
  Database: 
------------------------------------------------------------------------*/
/*          This .W file was created with the Progress AppBuilder.      */
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
DEF VAR nv_output AS CHAR FORMAT "x(150)". 
DEF TEMP-TABLE wdetail 
    FIELD PolicyWEB        AS CHAR FORMAT "x(20)"
    FIELD PolicyCTXBRAN    AS CHAR FORMAT "x(20)"
    FIELD Policygwctx      AS CHAR FORMAT "x(20)"
    FIELD PolicyGW         AS CHAR FORMAT "x(20)"
    FIELD PolicyUW         AS CHAR FORMAT "x(20)"
    FIELD docno            AS CHAR FORMAT "x(10)"
    FIELD contract         AS CHAR FORMAT "x(35)"
    FIELD company          AS CHAR FORMAT "x(20)" 
    FIELD programid        AS CHAR FORMAT "x(30)" 
    FIELD n_sch_p          AS LOGICAL 
    FIELD n_drn_p          AS LOGICAL 
    FIELD n_release        AS LOGICAL 
    FIELD n_releaseGW        AS LOGICAL.

/**********************************************/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_process fi_trandatef fi_trandatet ~
fi_output buOK buCANCEL RECT-7 
&Scoped-Define DISPLAYED-OBJECTS fi_process fi_trandatef fi_trandatet ~
fi_output 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON buCANCEL 
     LABEL "EXIT" 
     SIZE 10 BY 1.14
     FONT 6.

DEFINE BUTTON buOK 
     LABEL "OK" 
     SIZE 10 BY 1.14
     FONT 6.

DEFINE VARIABLE fi_output AS CHARACTER FORMAT "X(150)":U 
     LABEL "" 
     VIEW-AS FILL-IN 
     SIZE 60 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_process AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 44.5 BY 1
     FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_trandatef AS DATE FORMAT "99/99/9999":U 
     LABEL "Transdate Form" 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_trandatet AS DATE FORMAT "99/99/9999":U 
     LABEL "Transdate To" 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 77.83 BY 1.43
     BGCOLOR 8 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_process AT ROW 6.48 COL 2 NO-LABEL WIDGET-ID 204
     fi_trandatef AT ROW 2.91 COL 13.33 COLON-ALIGNED WIDGET-ID 184
     fi_trandatet AT ROW 2.91 COL 40.67 COLON-ALIGNED WIDGET-ID 202
     fi_output AT ROW 4.1 COL 17.83 COLON-ALIGNED WIDGET-ID 192
     buOK AT ROW 6.48 COL 48.5 WIDGET-ID 10
     buCANCEL AT ROW 6.48 COL 62 WIDGET-ID 12
     " OUT PUT FILE :" VIEW-AS TEXT
          SIZE 17 BY 1 AT ROW 4.1 COL 2 WIDGET-ID 194
          BGCOLOR 8 FONT 6
     "EXPORT DATA WEB NOT TRANSFER" VIEW-AS TEXT
          SIZE 70 BY .95 AT ROW 1.48 COL 3.17 WIDGET-ID 198
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "                          EXP....D:~\temp~\Docno_2017.csv" VIEW-AS TEXT
          SIZE 40 BY .81 AT ROW 5.29 COL 3.5 WIDGET-ID 200
     RECT-7 AT ROW 1.24 COL 2.17 WIDGET-ID 196
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 80.17 BY 7.19
         BGCOLOR 8  WIDGET-ID 100.


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
         TITLE              = "Safety Insurance Public Company Limited"
         HEIGHT             = 7.19
         WIDTH              = 80.33
         MAX-HEIGHT         = 24.76
         MAX-WIDTH          = 131.67
         VIRTUAL-HEIGHT     = 24.76
         VIRTUAL-WIDTH      = 131.67
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
IF NOT C-Win:LOAD-ICON("WIMAGE/safety.ico":U) THEN
    MESSAGE "Unable to load icon: WIMAGE/safety.ico"
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
/* SETTINGS FOR FILL-IN fi_process IN FRAME fr_main
   ALIGN-L                                                              */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Safety Insurance Public Company Limited */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Safety Insurance Public Company Limited */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buCANCEL
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buCANCEL C-Win
ON CHOOSE OF buCANCEL IN FRAME fr_main /* EXIT */
DO:
  Apply "Close" To This-Procedure.  /* ปิดโปรแกรม */
  Return No-Apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buOK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buOK C-Win
ON CHOOSE OF buOK IN FRAME fr_main /* OK */
DO:
    /*
connect BUInt                 -H 16.90.20.201 -S 5022 -N TCP -U pdmgr0 -P pdmgr0.
CONNECT CTXSTAT                  -H 18.10.100.5  -S 9041  -N TCP -U pdmgr0 -P pdmgr0.
CONNECT SIC_BRAN -ld CTXBRAN  -H 18.10.100.5  -S 3092 -N TCP -U pdmgr0 -P pdmgr0. 
CONNECT gwctx                 -H 18.10.100.5  -S 10011 -N TCP -U pdmgr0 -P pdmgr0.
CONNECT gw_safe  -ld sic_bran -H devserver    -S gw_safe -N tcp -U pdmgr0 -P pdmgr0.
CONNECT sicuw                 -H devserver    -S sicuw   -N tcp -U pdmgr0 -P pdmgr0.
    */
    FOR EACH wdetail.
        DELETE wdetail.
    END.
    ASSIGN 
        fi_trandatef = INPUT fi_trandatef 
        fi_trandatet = INPUT fi_trandatet 
        nv_output    = ""
        nv_output    = INPUT fi_output.
    IF fi_trandatet = ?  THEN DO:
        MESSAGE "Please input to Transdate to !!!!" VIEW-AS ALERT-BOX.
        APPLY "ENTRY" TO fi_trandatet.
        RETURN NO-APPLY.
    END.
    IF fi_trandatef = ?  THEN DO:
        MESSAGE "Please input to Transdate form !!!!" VIEW-AS ALERT-BOX.
        APPLY "ENTRY" TO fi_trandatef.
        RETURN NO-APPLY.
    END.
    IF fi_trandatet < fi_trandatef  THEN DO:
        MESSAGE "Please input to Transdate to not less Transdate form !!!!" VIEW-AS ALERT-BOX.
        APPLY "ENTRY" TO fi_trandatet.
        RETURN NO-APPLY.
    END.
    IF fi_output = ""  THEN DO:
        MESSAGE "Please input to File name !!!!" VIEW-AS ALERT-BOX.
        APPLY "ENTRY" TO fi_output.
        RETURN NO-APPLY.
    END.
    IF INDEX(nv_output,".csv") = 0  THEN nv_output = trim(nv_output) + ".csv".

    
        FOR EACH IntPol7072 USE-INDEX IntPol707203 WHERE
            IntPol7072.ProcessDate >= fi_trandatef  AND 
            IntPol7072.ProcessDate <= fi_trandatet  NO-LOCK.
            ASSIGN fi_process = "Policy Web Service:" + IntPol7072.PolicyNumber  + " " + IntPol7072.CMIPolicyNumber.
            DISP fi_process WITH FRAM fr_main.

            IF IntPol7072.PolicyNumber = "" AND IntPol7072.CMIPolicyNumber <> "" THEN DO:
                FIND LAST wdetail WHERE 
                    wdetail.PolicyWEB = IntPol7072.CMIPolicyNumber NO-LOCK NO-ERROR NO-WAIT.
                IF NOT AVAIL wdetail THEN DO:
                    CREATE wdetail.
                    ASSIGN 
                        wdetail.company   = IntPol7072.CompanyCode
                        wdetail.contract  = IntPol7072.ContractNumber
                        wdetail.docno     = IntPol7072.CMIDocumentUID
                        wdetail.PolicyWEB = IntPol7072.CMIPolicyNumber.
                END.
            END.
            ELSE IF IntPol7072.PolicyNumber <> "" THEN DO:
                FIND LAST wdetail WHERE 
                    wdetail.PolicyWEB = IntPol7072.PolicyNumber NO-LOCK NO-ERROR NO-WAIT.
                IF NOT AVAIL wdetail THEN DO:
                    CREATE wdetail.
                    ASSIGN 
                        wdetail.company   = IntPol7072.CompanyCode
                        wdetail.contract  = IntPol7072.ContractNumber
                        wdetail.docno     = IntPol7072.DocumentUID
                        wdetail.PolicyWEB = IntPol7072.PolicyNumber.
                END.
            END.
        END.  /* intpol7072*/
        FOR EACH   CTXSTAT.policy USE-INDEX Policy10 WHERE 
            CTXSTAT.policy.TrnDate >= fi_trandatef  AND            
            CTXSTAT.policy.TrnDate <= fi_trandatet  NO-LOCK.  
            ASSIGN fi_process = "Policy On Web:" + CTXSTAT.policy.PolNo.
            DISP fi_process WITH FRAM fr_main.

            FIND LAST wdetail WHERE 
                wdetail.PolicyWEB = CTXSTAT.policy.PolNo
                NO-LOCK NO-ERROR NO-WAIT.
            IF NOT AVAIL wdetail THEN DO:
                CREATE wdetail.
                ASSIGN 
                    wdetail.company   = CTXSTAT.policy.CompNo
                    wdetail.contract  = ""
                    wdetail.docno     = CTXSTAT.policy.DocNo1
                    wdetail.PolicyWEB = CTXSTAT.policy.PolNo.
            
            END.
        END.
        /*ctx bran */
        FOR EACH wdetail .
            FIND LAST CTXBRAN.uwm100 USE-INDEX uwm10001 WHERE 
                CTXBRAN.uwm100.policy = wdetail.PolicyWEB NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL CTXBRAN.uwm100 THEN 
                ASSIGN wdetail.PolicyCTXBRAN = trim(CTXBRAN.uwm100.policy)
                       wdetail.programid     = trim(CTXBRAN.uwm100.prog)  .

            FIND LAST gwctx.uwm100 USE-INDEX uwm10001 WHERE 
                gwctx.uwm100.policy = wdetail.PolicyWEB NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL gwctx.uwm100 THEN 
                ASSIGN wdetail.Policygwctx = trim(gwctx.uwm100.policy).
            /*GW */
            FIND LAST sic_bran.uwm100 USE-INDEX uwm10001 WHERE 
                sic_bran.uwm100.policy = wdetail.PolicyWEB NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sic_bran.uwm100 THEN
                ASSIGN 
                wdetail.PolicyGW        = trim(sic_bran.uwm100.policy) 
                wdetail.n_releaseGW     = sic_bran.uwm100.releas .  

            FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE 
                sicuw.uwm100.policy = wdetail.PolicyWEB NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicuw.uwm100 THEN
                ASSIGN 
                wdetail.PolicyUW  = trim(sicuw.uwm100.policy) 
                wdetail.n_sch_p   = sicuw.uwm100.sch_p   
                wdetail.n_drn_p   = sicuw.uwm100.drn_p   
                wdetail.n_release = sicuw.uwm100.releas .  

            ASSIGN fi_process = "Process Data:" + wdetail.PolicyWEB.
            DISP fi_process WITH FRAM fr_main.

        END.
        OUTPUT TO VALUE(nv_output).
        EXPORT DELIMITER "|" 
            "รหัสบริษัท"
            "เลขที่สัญญา"
            "เลขเอกสาร"
            "กรมธรรม์ WEB"
            "กรมธรรม์ CTXBRAN"
            "กรมธรรม์ GWCTX"
            "กรมธรรม์ GW"
            "กรมธรรม์ สถานะการโอนGW" 
            "กรมธรรม์ Premium"
            "การพิมพ์_sch_p "
            "การพิมพ์_drn_p "
            "สถานะการโอน_release " 
            "ชื่อโปรแกรม".

        FOR EACH wdetail NO-LOCK WHERE 
            wdetail.n_releaseGW  <>  YES .

            IF wdetail.PolicyCTXBRAN  = wdetail.Policygwctx AND
               wdetail.PolicyCTXBRAN  = wdetail.PolicyGW    AND 
               wdetail.PolicyCTXBRAN  = wdetail.PolicyUW    THEN NEXT.

            IF substr(wdetail.PolicyCTXBRAN,1,1)  = "Q"  THEN NEXT.
            IF substr(wdetail.PolicyCTXBRAN,1,1)  = "R"  THEN NEXT.
            IF wdetail.company  = "700"                  THEN NEXT.
            

            EXPORT DELIMITER "|" 
                wdetail.company
                wdetail.contract
                wdetail.docno
                wdetail.PolicyWEB
                wdetail.PolicyCTXBRAN
                wdetail.Policygwctx
                wdetail.PolicyGW
                wdetail.n_releaseGW
                wdetail.PolicyUW  
                wdetail.n_sch_p  
                wdetail.n_drn_p  
                wdetail.n_release
                wdetail.programid.
        END.
        OUTPUT CLOSE.
    
    MESSAGE "Export file complete " VIEW-AS ALERT-BOX.
END.   /* DO: */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_output
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_output C-Win
ON LEAVE OF fi_output IN FRAME fr_main
DO:
  fi_output = INPUT fi_output.
  DISP fi_output WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_trandatef
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_trandatef C-Win
ON LEAVE OF fi_trandatef IN FRAME fr_main /* Transdate Form */
DO:
  fi_trandatef = INPUT fi_trandatef.
  DISP fi_trandatef WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_trandatet
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_trandatet C-Win
ON LEAVE OF fi_trandatet IN FRAME fr_main /* Transdate To */
DO:
  fi_trandatet = INPUT fi_trandatet.
  DISP fi_trandatet WITH FRAM fr_main.
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
/* --- */
CLEAR  ALL     NO-PAUSE.
STATUS INPUT   OFF.
HIDE   MESSAGE NO-PAUSE.
/* ------------------------------------------------------------------ */

/* --- */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
 
  /********************  T I T L E   F O R  C - W I N  ****************/
  
  DEF  VAR  gv_prgid   AS   CHAR  FORMAT "X(8)"  NO-UNDO.
  DEF  VAR  gv_prog    AS   CHAR  FORMAT "X(40)" NO-UNDO.
  gv_prgid = "wgwreweb.w".
  gv_prog  = "EXPORT DATA WEB NOT TRANSFER".
/*
  RUN  WSU\WSUHDExt ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).

  RUN  WUT\WUTWICEN (C-WIN:handle).  */
  /*********************************************************************/
  /* */
  SESSION:DATA-ENTRY-RETURN = YES.    /* รับค่าปุ่ม ENTER */
  ASSIGN fi_trandatef = TODAY
      fi_trandatet = TODAY .
      
  DISP fi_trandatef fi_trandatet   WITH FRAM fr_main.
  

  /*IF NOT CONNECTED ("sic_bran") THEN DO:

    CONNECT sic_bran -H 16.104.11.11 -S 3002 -N TCP NO-ERROR.  
  END.

  IF NOT CONNECTED ("stat") THEN DO:

    CONNECT stat     -H 16.104.11.11 -S 9041 -N TCP NO-ERROR. 
  END.

  /* ใส่ค่าตัวแปรและแสดงค่า */
  fi_ResponseJob = "RqMotor".*/
  

  /* */

  RUN enable_UI.
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
  DISPLAY fi_process fi_trandatef fi_trandatet fi_output 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_process fi_trandatef fi_trandatet fi_output buOK buCANCEL RECT-7 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

