&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          buint            PROGRESS
*/
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*************************************************************************
 WRSBQGwLKT.W : Job Queue GW from DB BUExt to XML File Lockton
 Copyright    : Safety Insurance Public Company Limited
                บริษัท ประกันคุ้มภัย จำกัด (มหาชน)
-------------------------------------------------------------------------
 Database     : BUInt
-------------------------------------------------------------------------
 CREATE BY    :Kridtiya i. A58-0356 date . 02/11/2015
 modify by    :Kridtiya i. A60-0495 date . 28/12/2017
               เพิ่ม เงื่อนไขการค้นหา ด้วย รหัสบริษัท
*************************************************************************/
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
DEFINE VARIABLE nv_ConfirmBy  AS CHARACTER FORMAT "X(10)" INITIAL "" NO-UNDO.
DEFINE VARIABLE nv_rec_rq     AS RECID                               NO-UNDO. /* RECORD ID REQUEST */
DEFINE VARIABLE nv_rec_rs     AS RECID                               NO-UNDO. /* RECORD ID RESPONSE */
DEFINE VARIABLE nv_process    AS CHARACTER                           NO-UNDO.

DEFINE VARIABLE nv_InsurerCodeRq      AS CHARACTER FORMAT "X(10)" INITIAL "" NO-UNDO.
DEFINE VARIABLE nv_ConfirmByUserID    AS CHARACTER FORMAT "X(10)" INITIAL "" NO-UNDO.
DEFINE VARIABLE nv_UserIDLine         AS INTEGER                             NO-UNDO.
DEFINE VARIABLE nv_FindUcf            AS INT64                               NO-UNDO.
DEFINE VARIABLE nv_recUcf             AS INT64                               NO-UNDO.
DEFINE VARIABLE nv_SwtFind            AS CHARACTER FORMAT "X(10)" INITIAL "" NO-UNDO.
DEFINE VARIABLE my-datetime           AS CHARACTER FORMAT "X(23)"            NO-UNDO. 

/* 2555/09/01 Chek Number Limit Request / Companay*/
DEFINE VARIABLE nv_NumLimitRqPerDay   AS INTEGER   NO-UNDO.
DEFINE VARIABLE nv_NumLimitRqPerWeek  AS INTEGER   NO-UNDO.
DEFINE VARIABLE nv_NumLimitRqPerMonth AS INTEGER   NO-UNDO.
DEFINE VARIABLE nv_NumLimitRqPerYear  AS INTEGER   NO-UNDO.
DEFINE VARIABLE nv_NumRqPerDay        AS INTEGER   NO-UNDO.
DEFINE VARIABLE nv_NumRqPerWeek       AS INTEGER   NO-UNDO.
DEFINE VARIABLE nv_NumRqPerMonth      AS INTEGER   NO-UNDO.
DEFINE VARIABLE nv_NumRqPerYear       AS INTEGER   NO-UNDO.
DEFINE VARIABLE nv_ManageTo           AS LOGICAL   NO-UNDO.
DEFINE VARIABLE nv_SendTo             AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_ForDate            AS DATE      NO-UNDO.
DEFINE VARIABLE nv_Week               AS INTEGER   NO-UNDO.
DEFINE VARIABLE nv_Month              AS INTEGER   NO-UNDO.

DEFINE VARIABLE nv_count              AS INTEGER   NO-UNDO.

DEFINE VARIABLE nv_PolicyV70          AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_DocnoV70           AS CHARACTER NO-UNDO.

DEFINE VARIABLE nv_PolicyV72          AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_DocnoV72           AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_msgerror           AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_octets             AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_sendchkvehicle     AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_cvehtext           AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_resulttext         AS CHARACTER NO-UNDO.

DEFINE VARIABLE nv_RecIntPol7072      AS RECID     NO-UNDO.
DEFINE VARIABLE nv_msgerror7072       AS CHARACTER NO-UNDO.

DEFINE VARIABLE nv_exit               AS LOGICAL   NO-UNDO.

DEFINE VARIABLE nv_CallbyLink  AS CHARACTER FORMAT "X(250)" NO-UNDO.
DEFINE VARIABLE nv_LinkFile    AS CHARACTER FORMAT "X(250)" NO-UNDO.
DEFINE VARIABLE nv_listfile    AS CHARACTER FORMAT "X(50)"  NO-UNDO.
DEFINE VARIABLE nv_savedir     AS CHARACTER FORMAT "X(50)"  NO-UNDO.
DEFINE VARIABLE nv_saveTOdir   AS CHARACTER FORMAT "X(50)"  NO-UNDO.
DEFINE VARIABLE nv_SAVEFile    AS MEMPTR    NO-UNDO.
DEFINE VARIABLE nv_saveLink    AS LOGICAL   NO-UNDO.
DEFINE VARIABLE nv_msgstatus   AS CHARACTER NO-UNDO.

DEFINE STREAM xmlstream.
/* */

DEFINE TEMP-TABLE TFileAttach NO-UNDO
FIELD  FileNameAttach         AS CHARACTER
FIELD  FileBinary             AS BLOB.

DEFINE VAR nv_SavetoFile      AS CHARACTER NO-UNDO.

/************************************************************************/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME br_QueueRequest

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES ExtPDFLKT70

/* Definitions for BROWSE br_QueueRequest                               */
&Scoped-define FIELDS-IN-QUERY-br_QueueRequest /* */ ExtPDFLKT70.ProcessStatus ExtPDFLKT70.SystemRq ExtPDFLKT70.ContractNumber ExtPDFLKT70.PolicyNumber /**/ /* END. */   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_QueueRequest   
&Scoped-define SELF-NAME br_QueueRequest
&Scoped-define QUERY-STRING-br_QueueRequest FOR EACH ExtPDFLKT70 WHERE              ExtPDFLKT70.SystemRq   = fi_ResponseJob AND              ExtPDFLKT70.text1      = fi_company NO-LOCK
&Scoped-define OPEN-QUERY-br_QueueRequest OPEN QUERY {&SELF-NAME}     FOR EACH ExtPDFLKT70 WHERE              ExtPDFLKT70.SystemRq   = fi_ResponseJob AND              ExtPDFLKT70.text1      = fi_company NO-LOCK.
&Scoped-define TABLES-IN-QUERY-br_QueueRequest ExtPDFLKT70
&Scoped-define FIRST-TABLE-IN-QUERY-br_QueueRequest ExtPDFLKT70


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-br_QueueRequest}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_output fi_ResponseJob fi_waitcount buOK ~
buCANCEL br_QueueRequest fi_notfound fi_notfound2 fi_TextRemark fi_company ~
RECT-4 
&Scoped-Define DISPLAYED-OBJECTS fi_output fi_ResponseJob fi_waitcount ~
fi_notfound fi_notfound2 fi_TextRemark fi_company 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON buCANCEL 
     LABEL "Cancel" 
     SIZE 10 BY 1.14
     FONT 6.

DEFINE BUTTON buOK 
     LABEL "OK" 
     SIZE 10 BY 1.14
     FONT 6.

DEFINE VARIABLE fi_company AS CHARACTER FORMAT "X(15)":U 
     LABEL "Company:" 
     VIEW-AS FILL-IN 
     SIZE 15 BY .81
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_notfound AS CHARACTER FORMAT "X(70)":U 
      VIEW-AS TEXT 
     SIZE 72 BY .67
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_notfound2 AS CHARACTER FORMAT "X(65)":U 
      VIEW-AS TEXT 
     SIZE 72 BY .67
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_output AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 40 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_ResponseJob AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .81
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_TextRemark AS CHARACTER FORMAT "X(80)":U 
     VIEW-AS FILL-IN 
     SIZE 80 BY .71
     FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_waitcount AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     LABEL "Wait count" 
     VIEW-AS FILL-IN 
     SIZE 15 BY .71 NO-UNDO.

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 83.17 BY .19.

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 96.17 BY 1.1
     BGCOLOR 3 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_QueueRequest FOR 
      ExtPDFLKT70 SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_QueueRequest
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_QueueRequest C-Win _FREEFORM
  QUERY br_QueueRequest DISPLAY
      /* */
       ExtPDFLKT70.ProcessStatus     COLUMN-LABEL "PST"           FORMAT "xx"
       ExtPDFLKT70.SystemRq          COLUMN-LABEL "Company."      FORMAT "X(20)"
       ExtPDFLKT70.ContractNumber    COLUMN-LABEL "Ced Pol."      FORMAT "X(23)"
       ExtPDFLKT70.PolicyNumber      COLUMN-LABEL "Policy no."    FORMAT "X(23)"
/**/

/* END. */
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 96 BY 4.76
         FGCOLOR 1 
         TITLE FGCOLOR 1 "Queue รับข้อมูล PDF file Lockton" ROW-HEIGHT-CHARS .65.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     fi_output AT ROW 4.1 COL 23.33 COLON-ALIGNED NO-LABEL WIDGET-ID 182
     fi_ResponseJob AT ROW 2.43 COL 23.33 COLON-ALIGNED NO-LABEL WIDGET-ID 8
     fi_waitcount AT ROW 3.29 COL 23.33 COLON-ALIGNED WIDGET-ID 178
     buOK AT ROW 2.43 COL 86.5 WIDGET-ID 10
     buCANCEL AT ROW 3.76 COL 86.5 WIDGET-ID 12
     br_QueueRequest AT ROW 8.81 COL 1.5 WIDGET-ID 200
     fi_notfound AT ROW 7.19 COL 5.67 COLON-ALIGNED NO-LABEL WIDGET-ID 20
     fi_notfound2 AT ROW 7.95 COL 5.67 COLON-ALIGNED NO-LABEL WIDGET-ID 24
     fi_TextRemark AT ROW 6.05 COL 2.83 NO-LABEL WIDGET-ID 180
     fi_company AT ROW 2.43 COL 47.5 COLON-ALIGNED WIDGET-ID 188
     "                 Queue LOCKTON Transfer Data" VIEW-AS TEXT
          SIZE 60 BY .71 AT ROW 1.33 COL 36.33 WIDGET-ID 166
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "Queue Receive Name:" VIEW-AS TEXT
          SIZE 21.33 BY .71 AT ROW 2.43 COL 3 WIDGET-ID 6
          FONT 6
     "Process PDF File.." VIEW-AS TEXT
          SIZE 33 BY .71 AT ROW 1.33 COL 2.33 WIDGET-ID 164
          FGCOLOR 6 FONT 6
     "OutPut Path :" VIEW-AS TEXT
          SIZE 13 BY .91 AT ROW 4.14 COL 12 WIDGET-ID 184
          FONT 6
     "ตัวอย่าง :   D:~\WEBLOCKTON~\BYYYYMMDD" VIEW-AS TEXT
          SIZE 45 BY .81 AT ROW 5.14 COL 15.33 WIDGET-ID 186
          BGCOLOR 8 FGCOLOR 1 FONT 6
     RECT-6 AT ROW 1.14 COL 1.5 WIDGET-ID 162
     RECT-4 AT ROW 6.91 COL 3.17 WIDGET-ID 138
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 97.5 BY 12.86
         FGCOLOR 0  WIDGET-ID 100.


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
         HEIGHT             = 12.91
         WIDTH              = 97.33
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
/* SETTINGS FOR FRAME DEFAULT-FRAME
   FRAME-NAME Custom                                                    */
/* BROWSE-TAB br_QueueRequest buCANCEL DEFAULT-FRAME */
/* SETTINGS FOR FILL-IN fi_TextRemark IN FRAME DEFAULT-FRAME
   ALIGN-L                                                              */
/* SETTINGS FOR RECTANGLE RECT-6 IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_QueueRequest
/* Query rebuild information for BROWSE br_QueueRequest
     _START_FREEFORM
OPEN QUERY {&SELF-NAME}
    FOR EACH ExtPDFLKT70 WHERE
             ExtPDFLKT70.SystemRq   = fi_ResponseJob AND
             ExtPDFLKT70.text1      = fi_company
NO-LOCK.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE br_QueueRequest */
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
ON CHOOSE OF buCANCEL IN FRAME DEFAULT-FRAME /* Cancel */
DO:
  Apply "Close" To This-Procedure.  /* ปิดโปรแกรม */
  Return No-Apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buOK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buOK C-Win
ON CHOOSE OF buOK IN FRAME DEFAULT-FRAME /* OK */
DO:
    /* */
/*3*/ DEFINE VARIABLE SendReqFileName1     AS CHARACTER NO-UNDO.
/*3*/ DEFINE VARIABLE SendReqFileName2     AS CHARACTER NO-UNDO.
/*3*/ DEFINE VARIABLE SendReqFileName3     AS CHARACTER NO-UNDO.
/*3*/ DEFINE VARIABLE SendReqFileName4     AS CHARACTER NO-UNDO.
/*3*/ DEFINE VARIABLE SendReqFileName5     AS CHARACTER NO-UNDO.
/*3*/ DEFINE VARIABLE SendReqFileName6     AS CHARACTER NO-UNDO.
/*4*/ DEFINE VARIABLE SendReqBinData1      AS MEMPTR    NO-UNDO.
/*4*/ DEFINE VARIABLE SendReqBinData2      AS MEMPTR    NO-UNDO.
/*4*/ DEFINE VARIABLE SendReqBinData3      AS MEMPTR    NO-UNDO.
/*4*/ DEFINE VARIABLE SendReqBinData4      AS MEMPTR    NO-UNDO.
/*4*/ DEFINE VARIABLE SendReqBinData5      AS MEMPTR    NO-UNDO.
/*4*/ DEFINE VARIABLE SendReqBinData6      AS MEMPTR    NO-UNDO.
      DEFINE VARIABLE nv_outputfile        AS CHAR  INIT "" .



    ASSIGN
        nv_outputfile    = "" 
        fi_ResponseJob   = INPUT fi_ResponseJob
        fi_waitcount     = INPUT fi_waitcount.
    IF fi_output = ""  THEN DO:
        MESSAGE "กรุณา ระบุ พาท ที่ต้องการ บันทึกไฟล์ PDF !!!" VIEW-AS ALERT-BOX.
        APPLY "ENTRY" TO fi_output.
        RETURN NO-APPLY.
    END.
    IF fi_ResponseJob    = "" THEN DO:
        APPLY "ENTRY" TO fi_ResponseJob.
        RETURN NO-APPLY.
    END.
    /* */
    DISABLE buOK    buCANCEL WITH FRAME DEFAULT-FRAME.
    /* ****************************************************************************** */
    loop_job:
    REPEAT:
        /*
        RUN PD_ClearData.
        RUN PD_DispData. */
        RUN PD_DispMess ("").
        FIND FIRST ExtPDFLKT70 WHERE 
            ExtPDFLKT70.SystemRq       = fi_ResponseJob     /* "SGwCtx" , "Lockton"*/
        AND ExtPDFLKT70.text1          = fi_company        /*Add by Kridtiya i. A60-0495 */
        /*ExtPDFLKT70.Releas         = YES*/
        /*AND  ExtPDFLKT70.ProcessStatus  = "" */
            NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAILABLE ExtPDFLKT70 THEN DO:
            HIDE MESSAGE NO-PAUSE.
            nv_process = "".
            /*
            RUN Pc_CheckDataExt (INPUT nv_ConfirmBy, INPUT-OUTPUT nv_process).
            */
            RUN PD_DispMess ("Please wait check data transfer Lockton to GwCtx.").
            IF nv_process = "" THEN PAUSE 1 NO-MESSAGE.
            CLOSE QUERY br_QueueRequest.
            IF LASTKEY = KEYCODE("F4") THEN LEAVE loop_job.
            NEXT loop_job.
        END.
        /* --------------------------------------------------- */
        IF AVAILABLE ExtPDFLKT70 THEN nv_rec_rq = RECID(ExtPDFLKT70).
        ELSE DO:
            CLOSE QUERY br_QueueRequest.
            nv_rec_rq = 0.
            NEXT loop_job.
        END.
        CLOSE QUERY br_QueueRequest.
        {&OPEN-QUERY-br_QueueRequest}
            PAUSE 1 NO-MESSAGE.
        /* --------------------------------------------------- */
        

        FIND ExtPDFLKT70 WHERE RECID(ExtPDFLKT70) = nv_rec_rq NO-ERROR NO-WAIT.
        IF NOT AVAILABLE ExtPDFLKT70 THEN NEXT loop_job.
        IF     ExtPDFLKT70.ProcessStatus  = "X"
            OR ExtPDFLKT70.ProcessStatus  = "E" THEN DO:   /*clear delete */

           
            RUN PD_DELETE (INPUT nv_rec_rq).

            RELEASE ExtPDFLKT70. 
            NEXT loop_job.
            
        END.
        IF     ExtPDFLKT70.ProcessStatus  = ""
            OR ExtPDFLKT70.ProcessStatus  = "O"  THEN DO:
            /*create file pdf...*/
            ASSIGN 
                SendReqFileName1    =  ExtPDFLKT70.FileNameAttach1       
                SendReqFileName2    =  ExtPDFLKT70.FileNameAttach2       
                SendReqFileName3    =  ExtPDFLKT70.FileNameAttach3       
                SendReqFileName4    =  ExtPDFLKT70.FileNameAttach4       
                SendReqFileName5    =  ExtPDFLKT70.FileNameAttach5       
                SendReqFileName6    =  ExtPDFLKT70.FileNameAttach6       
                SendReqBinData1     =  ExtPDFLKT70.AttachFile1           
                SendReqBinData2     =  ExtPDFLKT70.AttachFile2           
                SendReqBinData3     =  ExtPDFLKT70.AttachFile3           
                SendReqBinData4     =  ExtPDFLKT70.AttachFile4           
                SendReqBinData5     =  ExtPDFLKT70.AttachFile5           
                SendReqBinData6     =  ExtPDFLKT70.AttachFile6  
                nv_outputfile       = "" .
            OUTPUT TO Tsend.txt.
            PUT SendReqFileName1 FORMAT "X(20)" SKIP.
            PUT SendReqFileName2 FORMAT "X(20)" SKIP.
            OUTPUT CLOSE.
            ASSIGN nv_outputfile = fi_output .
            IF SUBSTR(nv_outputfile,LENGTH(nv_outputfile)) <> "/" AND
               SUBSTR(nv_outputfile,LENGTH(nv_outputfile)) <> "\" THEN DO:
                IF R-INDEX(nv_outputfile,"/") <> 0 THEN
                     ASSIGN nv_outputfile = TRIM(fi_output) + "/" .
                ELSE ASSIGN nv_outputfile = TRIM(fi_output) + "\" .
            END.
            IF SendReqFileName1 <> "" THEN DO:
                /*OUTPUT TO VALUE("F" + SendReqFileName1).*/
                ASSIGN nv_outputfile = nv_outputfile +  SendReqFileName1 .
                /*OUTPUT TO VALUE(SendReqFileName1).*/
                OUTPUT TO VALUE(nv_outputfile).
                EXPORT SendReqBinData1.
                OUTPUT CLOSE.
            END.
            IF SendReqFileName2 <> "" THEN DO:
                ASSIGN nv_outputfile = fi_output .
                IF SUBSTR(nv_outputfile,LENGTH(nv_outputfile)) <> "/" AND
                    SUBSTR(nv_outputfile,LENGTH(nv_outputfile)) <> "\" THEN DO:
                    IF R-INDEX(nv_outputfile,"/") <> 0 THEN
                        ASSIGN nv_outputfile = TRIM(fi_output) + "/" .
                    ELSE ASSIGN nv_outputfile = TRIM(fi_output) + "\" .
                END.
                ASSIGN nv_outputfile = nv_outputfile +  SendReqFileName2 .
                /*OUTPUT TO VALUE("F" + SendReqFileName2).*/
                /*OUTPUT TO VALUE(SendReqFileName2).*/
                OUTPUT TO VALUE(nv_outputfile).
                EXPORT SendReqBinData2.
                OUTPUT CLOSE.
            END.
            ASSIGN     ExtPDFLKT70.ProcessStatus = "X".
            
        END. 
        IF LASTKEY = KEYCODE("F4") THEN LEAVE loop_job.

    /*
    CLOSE QUERY br_QueueRequest.
    {&OPEN-QUERY-br_QueueRequest}
    */
    /*
    RELEASE ExtPDFLKT70. */
    /* --------------------------------------------------- */
  END.   /* l o o p _ j o b : */
  /* ****************************************************************************** */

  RELEASE ExtPDFLKT70.

  CLOSE QUERY br_QueueRequest.
  fi_notfound  = "".
  fi_notfound2 = "".
  DISPLAY fi_notfound fi_notfound2 WITH FRAME DEFAULT-FRAME.

  ENABLE  buOK   buCANCEL  WITH FRAME DEFAULT-FRAME.

  APPLY "ENTRY" TO fi_ResponseJob.
  RETURN NO-APPLY.
END. /* DO: */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_company
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_company C-Win
ON LEAVE OF fi_company IN FRAME DEFAULT-FRAME /* Company: */
DO:

    fi_company = INPUT fi_company.
    DISP fi_company WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_output
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_output C-Win
ON LEAVE OF fi_output IN FRAME DEFAULT-FRAME
DO:

  fi_output = INPUT fi_output .
  DISP fi_output WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_QueueRequest
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
  gv_prgid = "WRSBQPDFLT".
  gv_prog  = "Queue Transfer PDF File Lockton ".
/*
  RUN  WSU\WSUHDExt ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).

  RUN  WUT\WUTWICEN (C-WIN:handle).  */
  /*********************************************************************/
  /* */
  SESSION:DATA-ENTRY-RETURN = YES.      /* รับค่าปุ่ม ENTER */
  
  /* ใส่ค่าตัวแปรและแสดงค่า */
  ASSIGN 
      fi_company     = "469"
      fi_ResponseJob = "LOCKTON".

  DISPLAY fi_ResponseJob WITH FRAME DEFAULT-FRAME.
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
  DISPLAY fi_output fi_ResponseJob fi_waitcount fi_notfound fi_notfound2 
          fi_TextRemark fi_company 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE fi_output fi_ResponseJob fi_waitcount buOK buCANCEL br_QueueRequest 
         fi_notfound fi_notfound2 fi_TextRemark fi_company RECT-4 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_CpLink C-Win 
PROCEDURE PD_CpLink :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
DEFINE INPUT PARAMETER nv_rec_rq AS RECID     NO-UNDO.

FIND ExtPDFLKT70 WHERE RECID(ExtPDFLKT70) = nv_rec_rq
NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAILABLE ExtPDFLKT70 THEN RETURN.
/**/
ASSIGN
nv_saveTOdir  = ""
nv_listfile   = ""
nv_savedir    = ""
/**/
nv_CallbyLink = ""
nv_LinkFile   = ""
nv_saveLink   = NO.

FIND FIRST ExtInsurerCd WHERE
           ExtInsurerCd.InsurerCd = ExtPDFLKT70.CompanyCode
NO-LOCK NO-ERROR NO-WAIT.
IF AVAILABLE ExtInsurerCd THEN DO:

  IF ExtInsurerCd.CallbyLink <> "" THEN DO:
    nv_saveTOdir  = ExtInsurerCd.SavetoDir.
    nv_listfile   = ExtInsurerCd.SavetoDir + "\test.dir".
    nv_savedir    = "MD " +  ExtInsurerCd.SavetoDir.
    /**/
    nv_CallbyLink = ExtInsurerCd.CallbyLink.
    /*
    nv_LinkFile   = ExtInsurerCd.CallbyLink.
    */
    nv_saveLink   = YES.
  END.
END.
/**/
IF nv_saveLink = YES THEN DO:

  IF SEARCH(nv_listfile) = ? THEN DO:
  
    DOS SILENT VALUE(nv_savedir).
  
    OUTPUT TO VALUE(nv_listfile).
    OUTPUT CLOSE.
    /*
    DISPLAY SEARCH("C:\inetpub\875\test.dir") <> ?.
    */
  END.
END.
/* --------------------------------------------------------- */
IF ExtPDFLKT70.LinkStatus <> "" THEN RETURN.

FIND ExtPDFLKT70 WHERE RECID(ExtPDFLKT70) = nv_rec_rq
NO-ERROR NO-WAIT.
IF AVAILABLE ExtPDFLKT70 THEN DO:

  IF ExtPDFLKT70.LinkStatus = "" AND nv_saveLink = YES THEN DO:

    IF ExtPDFLKT70.FileNameAttach1 <> "" THEN DO:

      nv_LinkFile = TRIM(nv_CallbyLink) + "/" + ExtPDFLKT70.FileNameAttach1.  /*FILE NAME PDF*/
      /*
      nv_listfile = "C:\inetpub\" + TRIM(prm_CompanyCode) + "\" + ExtPDFLKT70.FileNameAttach1.
      */
      nv_listfile = TRIM(nv_saveTOdir) + "\" + ExtPDFLKT70.FileNameAttach1.
      nv_SAVEFile = ExtPDFLKT70.AttachFile1.

      IF nv_SAVEFile <> ? THEN DO:
        /*
        OUTPUT STREAM xmlstream TO  VALUE(nv_ListFile) NO-CONVERT.
    
          EXPORT STREAM xmlstream  nv_SAVEFile.
    
        OUTPUT STREAM xmlstream CLOSE.
        */
        nv_msgstatus = "".
        RUN pd_EXPORT.
        /* --- 
        IF ERROR-STATUS:ERROR  THEN DO:
    
          nv_msgstatus = "ERROR".
          LEAVE loop_job.
        END.
        */
        IF nv_msgstatus = "" THEN
           ExtPDFLKT70.LinkPolicy = nv_LinkFile.   /*Link ที่ส่งกลับ*/
      END.
    END. /*IF ExtPDFLKT70.FileNameAttach1 <> "" THEN DO:*/
    /*2*/
    IF ExtPDFLKT70.FileNameAttach2 <> "" THEN DO:

      nv_LinkFile = TRIM(nv_CallbyLink) + "/" + ExtPDFLKT70.FileNameAttach2.  /*FILE NAME PDF*/
      nv_listfile = TRIM(nv_saveTOdir)  + "\" + ExtPDFLKT70.FileNameAttach2.
      nv_SAVEFile = ExtPDFLKT70.AttachFile2.

      IF nv_SAVEFile <> ? THEN DO:
    
        nv_msgstatus = "".
        RUN pd_EXPORT.

        IF nv_msgstatus = "" THEN
           ExtPDFLKT70.LinkFileAttach1 = nv_LinkFile.   /*Link ที่ส่งกลับ*/
      END.
    END. /*IF ExtPDFLKT70.FileNameAttach2 <> "" THEN DO:*/
    /*3*/
    IF ExtPDFLKT70.FileNameAttach3 <> "" THEN DO:

      nv_LinkFile = TRIM(nv_CallbyLink) + "/" + ExtPDFLKT70.FileNameAttach3.  /*FILE NAME PDF*/
      nv_listfile = TRIM(nv_saveTOdir)  + "\" + ExtPDFLKT70.FileNameAttach3.
      nv_SAVEFile = ExtPDFLKT70.AttachFile3.

      IF nv_SAVEFile <> ? THEN DO:
    
        nv_msgstatus = "".
        RUN pd_EXPORT.

        IF nv_msgstatus = "" THEN
           ExtPDFLKT70.LinkFileAttach2 = nv_LinkFile.   /*Link ที่ส่งกลับ*/
      END.
    END. /*IF ExtPDFLKT70.FileNameAttach3 <> "" THEN DO:*/
    /*4*/
    IF ExtPDFLKT70.FileNameAttach4 <> "" THEN DO:

      nv_LinkFile = TRIM(nv_CallbyLink) + "/" + ExtPDFLKT70.FileNameAttach4.  /*FILE NAME PDF*/
      nv_listfile = TRIM(nv_saveTOdir)  + "\" + ExtPDFLKT70.FileNameAttach4.
      nv_SAVEFile = ExtPDFLKT70.AttachFile4.

      IF nv_SAVEFile <> ? THEN DO:
    
        nv_msgstatus = "".
        RUN pd_EXPORT.

        IF nv_msgstatus = "" THEN
           ExtPDFLKT70.LinkFileAttach3 = nv_LinkFile.   /*Link ที่ส่งกลับ*/
      END.
    END. /*IF ExtPDFLKT70.FileNameAttach4 <> "" THEN DO:*/
    /*5*/
    IF ExtPDFLKT70.FileNameAttach5 <> "" THEN DO:

      nv_LinkFile = TRIM(nv_CallbyLink) + "/" + ExtPDFLKT70.FileNameAttach5.  /*FILE NAME PDF*/
      nv_listfile = TRIM(nv_saveTOdir)  + "\" + ExtPDFLKT70.FileNameAttach5.
      nv_SAVEFile = ExtPDFLKT70.AttachFile5.

      IF nv_SAVEFile <> ? THEN DO:
    
        nv_msgstatus = "".
        RUN pd_EXPORT.

        IF nv_msgstatus = "" THEN
           ExtPDFLKT70.LinkFileAttach4 = nv_LinkFile.   /*Link ที่ส่งกลับ*/
      END.
    END. /*IF ExtPDFLKT70.FileNameAttach5 <> "" THEN DO:*/
    /*6*/
    IF ExtPDFLKT70.FileNameAttach6 <> "" THEN DO:

      nv_LinkFile = TRIM(nv_CallbyLink) + "/" + ExtPDFLKT70.FileNameAttach6.  /*FILE NAME PDF*/
      nv_listfile = TRIM(nv_saveTOdir)  + "\" + ExtPDFLKT70.FileNameAttach6.
      nv_SAVEFile = ExtPDFLKT70.AttachFile6.

      IF nv_SAVEFile <> ? THEN DO:
    
        nv_msgstatus = "".
        RUN pd_EXPORT.

        IF nv_msgstatus = "" THEN
           ExtPDFLKT70.LinkFileAttach5 = nv_LinkFile.   /*Link ที่ส่งกลับ*/
      END.
    END. /*IF ExtPDFLKT70.FileNameAttach6 <> "" THEN DO:*/
    /*7*/
    IF ExtPDFLKT70.FileNameAttach7 <> "" THEN DO:

      nv_LinkFile = TRIM(nv_CallbyLink) + "/" + ExtPDFLKT70.FileNameAttach7.  /*FILE NAME PDF*/
      nv_listfile = TRIM(nv_saveTOdir)  + "\" + ExtPDFLKT70.FileNameAttach7.
      nv_SAVEFile = ExtPDFLKT70.AttachFile7.

      IF nv_SAVEFile <> ? THEN DO:
    
        nv_msgstatus = "".
        RUN pd_EXPORT.

        IF nv_msgstatus = "" THEN
           ExtPDFLKT70.LinkFileAttach6 = nv_LinkFile.   /*Link ที่ส่งกลับ*/
      END.
    END. /*IF ExtPDFLKT70.FileNameAttach7 <> "" THEN DO:*/
    /*8*/
    IF ExtPDFLKT70.FileNameAttach8 <> "" THEN DO:

      nv_LinkFile = TRIM(nv_CallbyLink) + "/" + ExtPDFLKT70.FileNameAttach8.  /*FILE NAME PDF*/
      nv_listfile = TRIM(nv_saveTOdir)  + "\" + ExtPDFLKT70.FileNameAttach8.
      nv_SAVEFile = ExtPDFLKT70.AttachFile8.

      IF nv_SAVEFile <> ? THEN DO:
    
        nv_msgstatus = "".
        RUN pd_EXPORT.

        IF nv_msgstatus = "" THEN
           ExtPDFLKT70.LinkFileAttach7 = nv_LinkFile.   /*Link ที่ส่งกลับ*/
      END.
    END. /*IF ExtPDFLKT70.FileNameAttach8 <> "" THEN DO:*/
    /*9*/
    IF ExtPDFLKT70.FileNameAttach9 <> "" THEN DO:

      nv_LinkFile = TRIM(nv_CallbyLink) + "/" + ExtPDFLKT70.FileNameAttach9.  /*FILE NAME PDF*/
      nv_listfile = TRIM(nv_saveTOdir)  + "\" + ExtPDFLKT70.FileNameAttach9.
      nv_SAVEFile = ExtPDFLKT70.AttachFile9.

      IF nv_SAVEFile <> ? THEN DO:
    
        nv_msgstatus = "".
        RUN pd_EXPORT.

        IF nv_msgstatus = "" THEN
           ExtPDFLKT70.LinkFileAttach8 = nv_LinkFile.   /*Link ที่ส่งกลับ*/
      END.
    END. /*IF ExtPDFLKT70.FileNameAttach9 <> "" THEN DO:*/
    /*10*/
    IF ExtPDFLKT70.FileNameAttach10 <> "" THEN DO:

      nv_LinkFile = TRIM(nv_CallbyLink) + "/" + ExtPDFLKT70.FileNameAttach10.  /*FILE NAME PDF*/
      nv_listfile = TRIM(nv_saveTOdir)  + "\" + ExtPDFLKT70.FileNameAttach10.
      nv_SAVEFile = ExtPDFLKT70.AttachFile10.

      IF nv_SAVEFile <> ? THEN DO:
    
        nv_msgstatus = "".
        RUN pd_EXPORT.

        IF nv_msgstatus = "" THEN
           ExtPDFLKT70.LinkFileAttach9 = nv_LinkFile.   /*Link ที่ส่งกลับ*/
      END.
    END. /*IF ExtPDFLKT70.FileNameAttach10 <> "" THEN DO:*/

    /* --------------------------------------------------------- */

  END. /*  IF ExtPDFLKT70.LinkStatus = "" AND nv_saveLink = YES THEN DO:*/

  ExtPDFLKT70.LinkStatus = "X".
END.

/* --------------------------------------------------------- */
RELEASE ExtPDFLKT70.
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_DELETE C-Win 
PROCEDURE PD_DELETE :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/**/
DEFINE INPUT PARAMETER nv_rec_rq AS RECID     NO-UNDO.

FIND ExtPDFLKT70 WHERE RECID(ExtPDFLKT70) = nv_rec_rq
NO-ERROR NO-WAIT.
IF AVAILABLE ExtPDFLKT70 THEN DO:

  DELETE ExtPDFLKT70.
END.

RELEASE ExtPDFLKT70.
/**/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_DispMess C-Win 
PROCEDURE PD_DispMess :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/**/
DEFINE INPUT PARAMETER nv_notfound AS CHARACTER NO-UNDO.
ASSIGN
    /*
    fi_notfound2 = "Please press button F4 = TO Exit. " 
                 + STRING(TODAY,"99/99/9999") + " " + STRING(TIME,"HH:MM:SS").
    my-datetime  = STRING(DATETIME(TODAY, MTIME)).                  
    */
    fi_notfound  = nv_notfound 
    my-datetime  = SUBSTR(STRING(DATETIME(TODAY, MTIME)),12,12) + " "
                 + SUBSTR(STRING(DATETIME(TODAY, MTIME)),1,10)
    fi_notfound2 = my-datetime + "    Please press button F4 = TO Exit.".

    DISPLAY  fi_notfound fi_notfound2 FGCOLOR 6 WITH FRAME DEFAULT-FRAME.

/**/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_EXPORT C-Win 
PROCEDURE pd_EXPORT :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/**
  OUTPUT STREAM xmlstream TO  VALUE(nv_ListFile) NO-CONVERT.

    EXPORT STREAM xmlstream  nv_SAVEFile.

  OUTPUT STREAM xmlstream CLOSE.

  IF ERROR-STATUS:ERROR  THEN DO:
  
    nv_msgstatus = "ERROR".
  END.
**/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_SAVEGWCTX C-Win 
PROCEDURE PD_SAVEGWCTX :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
/**/
/**/
DEFINE INPUT PARAMETER nv_rec_rq AS RECID     NO-UNDO.

FIND ExtPDFLKT70 WHERE RECID(ExtPDFLKT70) = nv_rec_rq
NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAILABLE ExtPDFLKT70 THEN RETURN.

IF ExtPDFLKT70.PolicyRec <> 0 AND ExtPDFLKT70.PolicyRec <> ? THEN DO:
  /*Genearate to Citrix*/

  RUN Wctx\WCtxGW100_1 (INPUT ExtPDFLKT70.PolicyRec        /*RECID(uwm100)*/
                       ,INPUT ExtPDFLKT70.ProcessByUser).  /*IntPol7072.CompanyCode*/
END.
ELSE DO:
  /*Genearate to Citrix*/

  RUN Wctx\WCtxGW100   (INPUT ExtPDFLKT70.Policy           /*IntPol7072.PolicyNumber*/
                       ,INPUT ExtPDFLKT70.ProcessByUser).  /*IntPol7072.CompanyCode*/
END.

FIND ExtPDFLKT70 WHERE RECID(ExtPDFLKT70) = nv_rec_rq
NO-ERROR NO-WAIT.
IF AVAILABLE ExtPDFLKT70 THEN DO:

  ExtPDFLKT70.ProcessStatus = "X".

  OUTPUT TO ExtPDFLKT70.txt APPEND.
  PUT TODAY FORMAT "99/99/9999"
  " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3)
  " " ExtPDFLKT70.Policy        FORMAT "X(14)" 
      ExtPDFLKT70.ProcessByUser FORMAT "X(5)" SKIP.
  OUTPUT CLOSE.
END.
/**/
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_SAVESICBRAN C-Win 
PROCEDURE PD_SAVESICBRAN :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
/**/
DEFINE INPUT PARAMETER nv_rec_rq  AS RECID     NO-UNDO.
/**/
DEFINE VARIABLE nv_RecIntPol7072  AS RECID     NO-UNDO.
DEFINE VARIABLE nv_msgerror7072   AS CHARACTER NO-UNDO.
/* ----------------------------------------------------- */

FIND ExtPDFLKT70 WHERE RECID(ExtPDFLKT70) = nv_rec_rq
NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAILABLE ExtPDFLKT70 THEN RETURN.

IF        ExtPDFLKT70.Policy       = ""  THEN RETURN.
IF SUBSTR(ExtPDFLKT70.Policy,1,1) <> "Q" THEN RETURN.
/**/

FIND FIRST sic_Bran.uwm100 USE-INDEX uwm10001 WHERE 
           sic_Bran.uwm100.policy = ExtPDFLKT70.Policy
     /*AND sic_Bran.uwm100.rencnt = 0 
       AND sic_Bran.uwm100.endcnt = 0 */
NO-LOCK NO-ERROR NO-WAIT.
IF AVAILABLE sic_bran.uwm100 THEN RETURN.
/**/

FIND FIRST IntPol7072 WHERE IntPol7072.PolicyNumber = ExtPDFLKT70.Policy
NO-LOCK NO-ERROR NO-WAIT.
IF AVAILABLE IntPol7072 THEN DO:

  IF IntPol7072.PolicyTypeCd <> "1" THEN RETURN.

  RUN PD_DispMess ("Please wait Generate data:" + ExtPDFLKT70.Policy ).

  nv_RecIntPol7072 = RECID(IntPol7072).
  nv_msgerror7072  = "".
  /**/

  OUTPUT TO savesicbran.txt.
  PUT ExtPDFLKT70.Policy FORMAT "X(20)" SKIP.
  OUTPUT CLOSE.

  RUN WRS/WRSGU100.P
      (INPUT        nv_RecIntPol7072
      ,INPUT-OUTPUT nv_msgerror7072).
END.
/**/
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

