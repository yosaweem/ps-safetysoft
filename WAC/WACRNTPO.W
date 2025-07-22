&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
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

  Created: Porntiwa T.  Date 20/10/2016  A59-0406
         : โปรแกรมสำหรับเรียกรายงาน Tracking ส่ง NTL และ Create Tracking ลง Lotus note
         
  Modify By : Porntiwa T.  Date 09/11/2016  A59-0423
            : ปรับการ Assign ค่า to Lotus Note      
            
  Modify By : Porntiwa T. A62-0105  30/07/2019  
            : ปรับการ Assign ค่า name 
            
  Modify By : Porntiwa T.  Date 06/12/2019  A62-0510  
            : Add export field c.Pol.No.    
  Modify By : Kridtiya I. Date. 21/07/2020 A63-0349 เพิ่มคอลัมน์ Company_INS,Payment_Type,Branch_Code,Branch_Name_Thai              

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
DEFINE WORKFILE wPost 
    FIELD RecDat           AS CHAR FORMAT "X(10)"
    FIELD Policy           AS CHAR FORMAT "X(16)"
    FIELD NTitle           AS CHAR FORMAT "X(30)"
    FIELD Name1            AS CHAR
    FIELD Lname            AS CHAR
    FIELD Phone            AS CHAR
    FIELD Chassis          AS CHAR
    FIELD Regno            AS CHAR
    FIELD Addr1            AS CHAR
    FIELD Addr2            AS CHAR
    FIELD Addr3            AS CHAR
    FIELD Addr4            AS CHAR
    FIELD PostCod          AS CHAR
    FIELD ComDat           AS DATE
    FIELD ExpDat           AS DATE
    FIELD PostNam          AS CHAR
    FIELD RefEms           AS CHAR
    FIELD SendDat          AS CHAR
    FIELD cpolno           AS CHAR FORMAT "X(25)"   /*Add A62-0510*/
    FIELD Company_INS      AS CHAR                  /* Add A63-0349   Date.21/07/2020    */
    FIELD Payment_Type     AS CHAR                  /* Add A63-0349   Date.21/07/2020    */
    FIELD Branch_Code      AS CHAR                  /* Add A63-0349   Date.21/07/2020    */
    FIELD Branch_Name_Thai AS CHAR .                /* Add A63-0349   Date.21/07/2020    */

DEFINE WORKFILE wFile 
    FIELD RecNo  AS INTE
    FIELD Policy AS CHAR FORMAT "X(16)"
    FIELD ChaNo  AS CHAR
    FIELD DocNo  AS CHAR FORMAT "X(10)" /* Benjaporn J. A60-0267 date 27/06/2017 */
    FIELD Name1  AS CHAR 
    FIELD ComDat AS CHAR
    FIELD ExpDat AS CHAR
    FIELD Vehreg AS CHAR
    FIELD Provin AS CHAR
    FIELD Service AS DECI FORMAT ">>9.99"
    FIELD RecCnt AS INTE.

DEF VAR chNotesSession  AS Com-Handle.
DEF VAR mail-file       AS CHAR.  /*check id*/
DEF VAR mail-server     AS CHAR.  /*Check server*/
DEF VAR chNotesDataBase AS Com-Handle.
DEF VAR chnotesatttach  AS COM-HANDLE.  /*Attach file*/
DEF VAR chdocument      AS COM-HANDLE.
DEF VAR chItem          AS COM-HANDLE.
DEF VAR chNotesView     AS COM-HANDLE.
DEF VAR chNavView       AS  COM-HANDLE .
DEF VAR chViewEntry     AS  COM-HANDLE .

DEF VAR chassign        AS COM-HANDLE.
DEF VAR chreceive       AS COM-HANDLE.

DEF VAR file01 AS CHAR.
DEF VAR file02 AS CHAR.
DEF VAR file03 AS CHAR.
DEF VAR file04 AS CHAR.
DEF VAR file05 AS CHAR.

DEFINE VAR nv_filenam AS CHAR.
DEFINE STREAM ns1.
DEFINE VAR nt_name1 AS CHAR.
DEFINE VAR n_count  AS INTE.
DEFINE VAR n AS INTE.
DEFINE VAR NStatus AS CHAR.
DEFINE VAR cnt1 AS INTE.
DEFINE VAR i AS INTE.

DEFINE VAR nv_surname AS CHAR.

/*-- Add A61-0401 --*/
DEFINE VAR nv_address AS CHAR.
DEFINE VAR nv_addr1   AS CHAR.
DEFINE VAR nv_addr2   AS CHAR.
DEFINE VAR nv_addr3   AS CHAR.
DEFINE VAR nv_addr4   AS CHAR.
DEFINE VAR nv_postcd  AS CHAR.

DEFINE VAR nv_x AS CHAR.

DEFINE VAR nv_chk AS CHAR EXTENT 5.
DEFINE VAR nv_chk1 AS CHAR.
/*-- End Add A61-0401 --*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-379 RECT-380 RECT-382 fiFinance ~
fiSenddate cbtracking bu_file fiInputFile fiOutputFile buOk buExit toReport ~
fiDetail 
&Scoped-Define DISPLAYED-OBJECTS fiFinance fiSenddate cbtracking ~
fiInputFile fiOutputFile toReport fiDetail 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON buExit 
     LABEL "Exit" 
     SIZE 7 BY 1.1
     BGCOLOR 4 FONT 6.

DEFINE BUTTON buOk 
     LABEL "OK" 
     SIZE 7 BY 1.1
     BGCOLOR 1 FONT 6.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 3.5 BY 1.1.

DEFINE VARIABLE cbtracking AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "เช้า","บ่าย" 
     DROP-DOWN-LIST
     SIZE 9.67 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiDetail AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 62.5 BY 1
     BGCOLOR 14 FGCOLOR 2 FONT 2 NO-UNDO.

DEFINE VARIABLE fiFinance AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 43.33 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiInputFile AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 43.33 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiOutputFile AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 43.33 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiSenddate AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15.83 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE RECTANGLE RECT-379
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 66 BY 1.43
     BGCOLOR 5 FGCOLOR 8 .

DEFINE RECTANGLE RECT-380
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 66 BY 8.43
     BGCOLOR 14 .

DEFINE RECTANGLE RECT-382
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 65 BY 1.43.

DEFINE VARIABLE toReport AS LOGICAL INITIAL no 
     LABEL "Report" 
     VIEW-AS TOGGLE-BOX
     SIZE 10.67 BY .95
     BGCOLOR 14 FONT 6 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fiFinance AT ROW 2.95 COL 14.67 COLON-ALIGNED NO-LABEL
     fiSenddate AT ROW 4.14 COL 14.67 COLON-ALIGNED NO-LABEL
     cbtracking AT ROW 4.14 COL 41.67 COLON-ALIGNED NO-LABEL
     bu_file AT ROW 5.29 COL 60.17
     fiInputFile AT ROW 5.33 COL 14.67 COLON-ALIGNED NO-LABEL
     fiOutputFile AT ROW 6.52 COL 14.67 COLON-ALIGNED NO-LABEL
     buOk AT ROW 9.43 COL 50.67
     buExit AT ROW 9.43 COL 58.83
     toReport AT ROW 9.48 COL 35.33
     fiDetail AT ROW 8 COL 3.33 NO-LABEL
     "Process Tracking NTL" VIEW-AS TEXT
          SIZE 27 BY .95 AT ROW 1.38 COL 20.5
          BGCOLOR 5 FGCOLOR 7 FONT 2
     "File Output :" VIEW-AS TEXT
          SIZE 12.5 BY 1 AT ROW 6.52 COL 3.5
          BGCOLOR 14 FONT 6
     "รอบส่ง :" VIEW-AS TEXT
          SIZE 8 BY 1 AT ROW 4.14 COL 34.67
          BGCOLOR 14 FONT 6
     "วันที่ส่ง :" VIEW-AS TEXT
          SIZE 8 BY 1 AT ROW 4.14 COL 7.5
          BGCOLOR 14 FONT 6
     "File Input :" VIEW-AS TEXT
          SIZE 11 BY 1 AT ROW 5.33 COL 4.83
          BGCOLOR 14 FONT 6
     "Finance :" VIEW-AS TEXT
          SIZE 9.67 BY 1 AT ROW 2.95 COL 6
          BGCOLOR 14 FONT 6
     RECT-379 AT ROW 1.14 COL 1.5
     RECT-380 AT ROW 2.57 COL 1.5
     RECT-382 AT ROW 7.76 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 67 BY 10.14
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
         TITLE              = "WACRNTPO.W"
         HEIGHT             = 10.14
         WIDTH              = 67
         MAX-HEIGHT         = 47.71
         MAX-WIDTH          = 213.33
         VIRTUAL-HEIGHT     = 47.71
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
IF NOT C-Win:LOAD-ICON("wimage/iconhead.ico":U) THEN
    MESSAGE "Unable to load icon: wimage/iconhead.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fr_main
   FRAME-NAME                                                           */
ASSIGN 
       bu_file:AUTO-RESIZE IN FRAME fr_main      = TRUE.

/* SETTINGS FOR FILL-IN fiDetail IN FRAME fr_main
   ALIGN-L                                                              */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* WACRNTPO.W */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* WACRNTPO.W */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buExit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buExit C-Win
ON CHOOSE OF buExit IN FRAME fr_main /* Exit */
DO:
  APPLY "CLOSE" TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buOk
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buOk C-Win
ON CHOOSE OF buOk IN FRAME fr_main /* OK */
DO:
  IF fiInputFile = "" THEN DO:
      MESSAGE "File Input Not Found !!" VIEW-AS ALERT-BOX WARNING.
      APPLY "ENTRY" TO fiInputFile IN FRAME fr_main.
      RETURN NO-APPLY.
  END.

  IF fiOutputFile = "" THEN DO:
      MESSAGE "File Output Not Found !!" VIEW-AS ALERT-BOX WARNING.
      APPLY "ENTRY" TO fiOutputFile IN FRAME fr_main.
      RETURN NO-APPLY.
  END.

  RUN PDImport.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_file
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_file C-Win
ON CHOOSE OF bu_file IN FRAME fr_main /* ... */
DO:
    DEFINE VARIABLE cvData        AS CHARACTER NO-UNDO.
    DEFINE VARIABLE OKpressed AS LOGICAL INITIAL TRUE.

    DEF VAR no_add AS CHAR FORMAT "x(8)" . 

   SYSTEM-DIALOG GET-FILE cvData
        TITLE      "Choose Data File to Import ..."
       
       FILTERS     "CSV (Comma Delimited)"   "*.csv",
                            "Data Files (*.dat)"     "*.dat"
                            
        MUST-EXIST
        USE-FILENAME
        UPDATE OKpressed.
      
    IF OKpressed = TRUE THEN DO:

         no_add =           STRING(MONTH(TODAY),"99")    + 
                            STRING(DAY(TODAY),"99")      + 
                  SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                  SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) .

         ASSIGN
             fiInputFile  = cvData
             fiOutputFile = SUBSTRING(cvData,1,(LENGTH(fiInputFile) - 4)) + no_add + ".csv" .

         DISP fiInputFile fiOutputFile WITH FRAME fr_main.
         RETURN NO-APPLY.
    END.

    

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cbtracking
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cbtracking C-Win
ON VALUE-CHANGED OF cbtracking IN FRAME fr_main
DO:
  cbtracking = INPUT cbtracking.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiDetail
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiDetail C-Win
ON LEAVE OF fiDetail IN FRAME fr_main
DO:
  fiOutPutFile = INPUT fiOutputFile.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiFinance
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiFinance C-Win
ON LEAVE OF fiFinance IN FRAME fr_main
DO:
  fiFinance = INPUT fiFinance.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiInputFile
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiInputFile C-Win
ON LEAVE OF fiInputFile IN FRAME fr_main
DO:
  fiInputFile = INPUT fiInputFile.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiOutputFile
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiOutputFile C-Win
ON LEAVE OF fiOutputFile IN FRAME fr_main
DO:
  fiOutPutFile = INPUT fiOutputFile.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiSenddate
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiSenddate C-Win
ON LEAVE OF fiSenddate IN FRAME fr_main
DO:
  fiSendDate = INPUT fiSendDate.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME toReport
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL toReport C-Win
ON VALUE-CHANGED OF toReport IN FRAME fr_main /* Report */
DO:
  toReport = INPUT toReport.
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
  
  gv_prgid = "WACRNTPO.W".
  gv_prog  = "Process Tracking NTL (Real)".
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).

  Run Wut\WutDiCen(C-win:handle).
  /*********************************************************************/
  SESSION:DATA-ENTRY-RETURN = YES.

  ASSIGN
      fiSendDate = TODAY
      cbtracking = "เช้า"
      fiFinance  = "บ.เงินติดล้อ"
      toReport   = YES.

  DISP fiSendDate cbtracking fiFinance toReport WITH FRAME fr_main.

  APPLY "ENTRY" TO fiInputFile IN FRAME fr_Main.


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
  DISPLAY fiFinance fiSenddate cbtracking fiInputFile fiOutputFile toReport 
          fiDetail 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE RECT-379 RECT-380 RECT-382 fiFinance fiSenddate cbtracking bu_file 
         fiInputFile fiOutputFile buOk buExit toReport fiDetail 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDChkPostCd C-Win 
PROCEDURE PDChkPostCd :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO i = 1 TO 5:

    nv_x = SUBSTR(nv_postcd,i,1).
 
    nv_chk[i] = "N".

    CASE nv_x :
        WHEN "1" THEN DO:
            nv_chk[i] = "Y".
        END.
        WHEN "2" THEN DO:
            nv_chk[i] = "Y".
        END.
        WHEN "3" THEN DO:
            nv_chk[i] = "Y".
        END.
        WHEN "4" THEN DO:
            nv_chk[i] = "Y".
        END.
        WHEN "5" THEN DO:
            nv_chk[i] = "Y".
        END.
        WHEN "6" THEN DO:
            nv_chk[i] = "Y".
        END.
        WHEN "7" THEN DO:
            nv_chk[i] = "Y".
        END.
        WHEN "8" THEN DO:
            nv_chk[i] = "Y".
        END.
        WHEN "9" THEN DO:
            nv_chk[i] = "Y".
        END.
        WHEN "0" THEN DO:
            nv_chk[i] = "Y".
        END.
    END CASE.
END.

IF (nv_chk[1] + nv_chk[2] + nv_chk[3] +
   nv_chk[4] + nv_chk[5]) = "YYYYY" THEN DO:
    nv_chk1 = "Y".
END.
ELSE nv_chk1 = "N".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDCreNote C-Win 
PROCEDURE PDCreNote :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
nv_filenam = STRING(DAY(fiSendDate),"99") + "/" +
             STRING(MONTH(fiSendDate),"99") + "/" +
             STRING(YEAR(fiSendDate),"9999").

    DO i = 1 TO cnt1:

        n_count = 0.
        FOR EACH wFile WHERE wFile.RecCnt = i NO-LOCK:
            n_count = n_count + 1.
        END.

        /*-- Comment --
        ASSIGN
            mail-server = ""
            mail-file   = "D:\postdocument16.nsf".
        -- End Comment --*/ 
/*------------------------*/
        ASSIGN
            mail-server = "Safety_NotesServer/Safety"
            mail-file   = "safety\fi\postdocument" + SUBSTR(STRING(YEAR(TODAY)),3,2) + ".nsf".

    /*    ----------------------------*/
/*
        ASSIGN
            mail-server = ""
            mail-file   = "D:\postdocument20.nsf". 
        */
    
        CREATE "Notes.NotesSession"  chNotesSession.
        chNotesDatabase  = chNotesSession:GetDatabase (mail-server , mail-file).
    
        IF chNotesDatabase:IsOpen() = NO THEN DO:
            fiDetail = "Please Check Database..,Can not open..".
            DISPLAY fiDetail WITH FRAME fr_main.
        END.
        ELSE DO:
            chNotesView = chNotesDatabase:GetView("All Post2").
            chDocument  = chNotesView:GetDocumentByKey(nv_filenam).

            file01 = chNotesSession:Username.
            
            IF INDEX(file01,"CN=") <> 0 THEN DO:
                file01 = SUBSTR(file01,INDEX(file01,"CN=") + 3,LENGTH(file01)).
            END.
            
            IF INDEX(file01,"/") <> 0 THEN DO:
                file01 = SUBSTR(file01,1,INDEX(file01,"/") - 1).
            END.

            /*IF VALID-HANDLE(chDocument) = NO THEN  DO :*/
            chDocument  = chNotesDatabase:CreateDocument.
            chDocument:SAVE( TRUE, TRUE ).
        
            chItem  = chDocument:AppendItemValue("Form",   "PostDocument_input").
            chItem  = chDocument:AppendItemValue("Date",  fiSendDate).
            chItem  = chDocument:AppendItemValue("Round",  cbtracking).
            chItem  = chDocument:AppendItemValue("Finance", fiFinance).
            chItem  = chDocument:AppendItemValue("createBy", file01).
            chItem  = chDocument:AppendItemValue("createOn", TODAY).
            chItem  = chDocument:AppendItemValue("sum", STRING(n_count)).
    
            FOR EACH wFile WHERE wFile.RecCnt = i NO-LOCK:
                n = n + 1.
                chItem  = chDocument:AppendItemValue("Address_" + STRING(n), wFile.Name1).
                chItem  = chDocument:AppendItemValue("EmsNo_" + STRING(n), wFile.DocNo ).
                chItem  = chDocument:AppendItemValue("Service_" + STRING(n), wFile.Service).
                chItem  = chDocument:AppendItemValue("PolicyNo_" + STRING(n), wFile.Policy).
            END.
            n = 0.
        
            chDocument:SAVE( TRUE, TRUE ).
        
            RELEASE OBJECT  chItem. 
            RELEASE OBJECT  chDocument.
            RELEASE OBJECT  chNotesView.
        END.
    END.

    DEF VAR chWorkspace AS COM-HANDLE.
    CREATE "Notes.NotesUIWorkspace" chWorkspace.
    chWorkspace:ViewRefresh. 

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDCutAddr C-Win 
PROCEDURE PDCutAddr :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF nv_address <> "" THEN DO:

    nv_address = TRIM(nv_address).

    /*-- รหัสไปรษณีย์ --*/
    nv_postcd = TRIM(SUBSTR(nv_address,R-INDEX(nv_address," "))).

    RUN PDChkPostCd.

    IF nv_chk1 = "Y" THEN
        nv_address = TRIM(SUBSTR(nv_address,1,R-INDEX(nv_address," "))).
    ELSE nv_address = nv_address.

    /*-- จังหวัด --*/
    IF INDEX(nv_address,"จังหวัด") <> 0 OR INDEX(nv_address,"จ.") <> 0 THEN DO:
        IF INDEX(nv_address,"จังหวัด") <> 0 THEN DO:
            nv_addr4 = TRIM(SUBSTR(nv_address,(INDEX(nv_address,"จังหวัด")))).

            nv_address = TRIM(SUBSTR(nv_address,1,INDEX(nv_address,"จังหวัด") - 1)).
        END.
        ELSE IF INDEX(nv_address,"จ.") <> 0 THEN DO:
            nv_addr4 = TRIM(SUBSTR(nv_address,(INDEX(nv_address,"จ.")))).

            nv_address = TRIM(SUBSTR(nv_address,1,INDEX(nv_address,"จ.") - 1)).
        END.
    END.

    /*-- อำเภอ --*/
    IF INDEX(nv_address,"อำเภอ") <> 0 OR INDEX(nv_address,"อ.") <> 0 OR
       INDEX(nv_address,"เขต") <> 0 THEN DO:
        IF INDEX(nv_address,"อำเภอ") <> 0 THEN DO:
            nv_addr3 = TRIM(SUBSTR(nv_address,INDEX(nv_address,"อำเภอ"))).

            nv_address = TRIM(SUBSTR(nv_address,1,INDEX(nv_address,"อำเภอ") - 1)).
        END.
        ELSE IF INDEX(nv_address,"อ.") <> 0 THEN DO:
            nv_addr3 = TRIM(SUBSTR(nv_address,INDEX(nv_address,"อ."))).

            nv_address = TRIM(SUBSTR(nv_address,1,INDEX(nv_address,"อ.") - 1)).
        END.
        ELSE IF INDEX(nv_address,"เขต") <> 0 THEN DO:
            nv_addr3 = TRIM(SUBSTR(nv_address,INDEX(nv_address,"เขต"))).

            nv_address = TRIM(SUBSTR(nv_address,1,INDEX(nv_address,"เขต") - 1)).
        END.
    END.

    /*-- ตำบล --*/
    IF INDEX(nv_address,"ตำบล") <> 0 OR INDEX(nv_address,"ต.") <> 0 OR
       INDEX(nv_address,"แขวง") <> 0 THEN DO:
        IF INDEX(nv_address,"ตำบล") <> 0 THEN DO:
            nv_addr2 = TRIM(SUBSTR(nv_address,INDEX(nv_address,"ตำบล"))).

            nv_address = TRIM(SUBSTR(nv_address,1,INDEX(nv_address,"ตำบล") - 1)).
        END.
        ELSE IF INDEX(nv_address,"ต.") <> 0 THEN DO:
            nv_addr2 = TRIM(SUBSTR(nv_address,INDEX(nv_address,"ต."))).

            nv_address = TRIM(SUBSTR(nv_address,1,INDEX(nv_address,"ต.") - 1)).
        END.
        ELSE IF INDEX(nv_address,"แขวง") <> 0 THEN DO:
            nv_addr2 = TRIM(SUBSTR(nv_address,INDEX(nv_address,"แขวง"))).

            nv_address = TRIM(SUBSTR(nv_address,1,INDEX(nv_address,"แขวง") - 1)).
        END.
    END.

    /*-- อื่นๆ --*/
    nv_addr1 = nv_address.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDExport C-Win 
PROCEDURE PDExport :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
fiDetail = "Please wait..,Export Data...".
DISP fiDetail WITH FRAME fr_main.

OUTPUT TO VALUE(fiOutputFile) NO-ECHO APPEND.
/*A63-0349 
EXPORT DELIMITER ","
    "วันที่รับเรื่อง"
    "เลขอ้างอิง"             /*Add A62-0510*/
    "เลขกรมธรรม์"
    "คำนำหน้า"
    "ชื่อลูกค้า"
    "นามสกุล"
    "โทรศัพท์"
    "เลขตัวถัง"
    "ทะเบียน"
    "เลขที่ตั้ง"
    "ตำบล - อำเภอ"
    "จังหวัด"
    "รหัสไปรษณีย์"
    "วันเริ่มคุ้มครอง"
    "วันสิ้นสุดคุ้มครอง"
    "บริษัทที่ส่งกรมธรรม์"
    "Refer/EMS number"
    "วันที่ส่งกรมธรรม์".
 A63-0349*/
EXPORT DELIMITER ","
    "Transfer_Date" 
    "Company_INS" 
    "Reference_no" 
    "Payment_Type" 
    "Title"
    "Name"
    "Surname"
    "License_No"
    "Chassis_No"
    "Branch_Code"
    "Branch_Name_Thai"
    "เลขกรมธรรม์"
    "เลขนำส่ง"
    "วันที่จัดส่ง" 
    "เลขที่ตั้ง "
    "ตำบล -อำเภอ"
    "จังหวัด"
    "รหัสไปรษณีย์" 
    "วันเริ่มคุ้มครอง".
/*
FOR EACH wPost NO-LOCK:
    EXPORT DELIMITER ","
        wPost.RecDat 
        wPost.cpolno  /*Add A62-0510*/
        wPost.Policy  
        wPost.NTitle  
        wPost.Name1   
        wPost.Lname   
        wPost.Phone 
        wPost.Chassis
        wPost.Regno
        wPost.Addr1   
        wPost.Addr2   
        wPost.Addr3     
        wPost.PostCod 
        wPost.ComDat  
        wPost.ExpDat  
        wPost.PostNam 
        wPost.RefEms  
        wPost.SendDat. 
END.*/
FOR EACH wPost NO-LOCK:
    EXPORT DELIMITER ","
        wPost.RecDat 
        wPost.Company_INS 
        wPost.cpolno              
        wPost.Payment_Type        
        wPost.NTitle              
        wPost.Name1                              
        wPost.Lname                
        wPost.Regno               
        wPost.Chassis             
        wPost.Branch_Code                          
        wPost.Branch_Name_Thai
        wPost.Policy
        wPost.RefEms 
        wPost.SendDat
        wPost.Addr1   
        wPost.Addr2   
        wPost.Addr3     
        wPost.PostCod 
        wPost.ComDat  
        /*wPost.ExpDat  
        wPost.PostNam */
        /*wPost.Phone */
         
        . 
END.

OUTPUT CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDImport C-Win 
PROCEDURE PDImport :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wFile.
    DELETE wFile.
END.

FOR EACH wPost.
    DELETE wPost.
END.

n_count = 0.
cnt1    = 1.

INPUT FROM VALUE(fiInputFile) NO-ECHO.
REPEAT:
    CREATE wFile.
    IMPORT DELIMITER ","
        /*wFile.RecNo */ 
        wFile.Policy    /*Policy*/
        wFile.DocNo     /*EMS No.*/
        wFile.Service   /*ค่าบริการ*/.

    ASSIGN
        n_count      = n_count + 1
        wFile.RecNo  = n_count
        wFile.RecCnt = cnt1.

    IF n_count = 50 THEN DO: 
        n_count = 0.
        cnt1    = cnt1 + 1.
    END.

    fiDetail = "Please wait..,Import Data...".
    DISP fiDetail WITH FRAME fr_main.
  
END.

FIND FIRST wFile WHERE wFile.policy <> "" NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAIL wFile THEN DO:
    MESSAGE "Record Process Not Found !!" VIEW-AS ALERT-BOX WARNING.
    APPLY "ENTRY" TO fiInputFile IN FRAME fr_main.
    RETURN NO-APPLY.
END.

RUN PDProcess.

IF toReport = YES THEN RUN PDExport.

IF NStatus <> "N" THEN DO:
    fiDetail = "Process Data Complete..".
    DISP fiDetail WITH FRAME fr_main.
    
    MESSAGE "Process Complete" VIEW-AS ALERT-BOX INFORMATION.
END.
ELSE DO:
    fiDetail = "ยกเลิการ Process แล้ว..".
    DISP fiDetail WITH FRAME fr_main.
    
    MESSAGE "ยกเลิการ Process แล้ว" VIEW-AS ALERT-BOX INFORMATION.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDNote C-Win 
PROCEDURE PDNote :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*ASSIGN
    mail-server = ""
    mail-file   = "D:\postdocument16.nsf".*/
/* Production .....*/
ASSIGN
    mail-server = "Safety_NotesServer/Safety"
    mail-file   = "safety\fi\postdocument" + SUBSTR(STRING(YEAR(TODAY)),3,2) + ".nsf".  
/*Production .....*/

/*ASSIGN
    mail-server = ""
    mail-file   = "D:\postdocument18.nsf".*/
/*
    ASSIGN
    mail-server = ""
    mail-file   = "D:\postdocument20.nsf".*/

CREATE "Notes.NotesSession"  chNotesSession.
chNotesDatabase  = chNotesSession:GetDatabase (mail-server , mail-file).

IF chNotesDatabase:IsOpen() = NO THEN DO:
    fiDetail = "Please Check Database..,Can not open..".
    DISPLAY fiDetail WITH FRAME fr_main.
END.
ELSE DO:

    file01 = chNotesSession:Username.

    IF INDEX(file01,"CN=") <> 0 THEN DO:
        file01 = SUBSTR(file01,INDEX(file01,"CN=") + 3,LENGTH(file01)).
    END.

    IF INDEX(file01,"/") <> 0 THEN DO:
        file01 = SUBSTR(file01,1,INDEX(file01,"/") - 1).
    END.

    chNotesView = chNotesDatabase:GetView("By PolicyNo").
    chDocument  = chNotesView:GetDocumentByKey(nv_filenam).


    IF VALID-HANDLE(chDocument) = NO THEN  DO :
        chDocument  = chNotesDatabase:CreateDocument.
        chDocument:SAVE( TRUE, TRUE ).

        chItem  = chDocument:AppendItemValue("Form",   "PostDocument_output").
        chItem  = chDocument:AppendItemValue("Date",  wPost.SendDat).
        chItem  = chDocument:AppendItemValue("Round",  cbtracking).
        chItem  = chDocument:AppendItemValue("Finance", fiFinance).
        chItem  = chDocument:AppendItemValue("createBy", file01).
        chItem  = chDocument:AppendItemValue("createOn", TODAY).
        chItem  = chDocument:AppendItemValue("Address", nt_name1).
        chItem  = chDocument:AppendItemValue("EmsNo", wPost.RefEms).
        chItem  = chDocument:AppendItemValue("Service", wFile.Service).
        chItem  = chDocument:AppendItemValue("PolicyNo", nv_filenam).

        chDocument:SAVE( TRUE, TRUE ).

        RELEASE OBJECT  chItem. 
        RELEASE OBJECT  chDocument.
        RELEASE OBJECT  chNotesView.
    END.
    ELSE DO:
        chItem  = chDocument:replaceItemValue("Date",  wPost.SendDat).
        chItem  = chDocument:replaceItemValue("Round",  cbtracking).
        chItem  = chDocument:replaceItemValue("Finance", fiFinance).
        chItem  = chDocument:replaceItemValue("createBy", file01).
        chItem  = chDocument:replaceItemValue("createOn", TODAY).
        chItem  = chDocument:replaceItemValue("Address", nt_name1).
        chItem  = chDocument:replaceItemValue("EmsNo", wPost.RefEms).
        chItem  = chDocument:replaceItemValue("Service", wFile.Service).
        chItem  = chDocument:replaceItemValue("PolicyNo", nv_filenam).

        chDocument:SAVE( TRUE, TRUE ).

        RELEASE OBJECT  chItem. 
        RELEASE OBJECT  chDocument.
        RELEASE OBJECT  chNotesView.
    END.

END.

RELEASE OBJECT  chNotesDataBase.
RELEASE OBJECT  chNotesSession.

DEF VAR chWorkspace AS COM-HANDLE.
CREATE "Notes.NotesUIWorkspace" chWorkspace.
chWorkspace:ViewRefresh. 

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDProcess C-Win 
PROCEDURE PDProcess :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wFile :
    IF wFile.policy <> "" THEN DO:
        CREATE wPost.
        ASSIGN
            wPost.Policy  = wFile.Policy
            wPost.RefEms  = wFile.DocNo
            wPost.SendDat = STRING(DAY(fiSendDate),"99") + "/" +
                            STRING(MONTH(fiSendDate),"99") + "/" +
                            STRING(YEAR(fiSendDate),"9999")
            wPost.PostNam = "ไปรษณีย์ไทย".
    
        FIND LAST uwm100 USE-INDEX uwm10001 WHERE
                  uwm100.policy = wFile.policy NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL uwm100 THEN DO:
            IF uwm100.insref <> "" THEN DO:

                ASSIGN
                    wPost.Policy   = uwm100.policy
                    wPost.ComDat   = uwm100.comdat
                    wPost.ExpDat   = uwm100.ExpDat
                    wPost.RecDat   = TRIM(STRING(DAY(TODAY),"99") + "/" +
                                     STRING(MONTH(TODAY),"99") + "/" +
                                     STRING(YEAR(TODAY),"9999"))
                    wPost.cpolno   = uwm100.cedpol    /*Add A62-0510*/
                    wPost.Company_INS      = "SAF"    /*A63-0349*/
                    wPost.Branch_Name_Thai = "".      /*A63-0349*/
                /*A63-0349*/
                IF uwm100.opnpol <> "" THEN DO:
                    IF SUBSTR(trim(uwm100.opnpol),1,4) <> "" THEN wPost.Branch_Code  = SUBSTR(trim(uwm100.opnpol),1,4). 
                    IF SUBSTR(trim(uwm100.opnpol),5,3) <> "" THEN wPost.Payment_Type = replace(SUBSTR(trim(uwm100.opnpol),5,3),"/","") . 
                END.
                /*A63-0349*/

                FIND FIRST uwm301 USE-INDEX uwm30101 WHERE
                           uwm301.policy = uwm100.policy AND
                           uwm301.rencnt = uwm100.rencnt AND
                           uwm301.endcnt = uwm100.endcnt NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL uwm301 THEN DO:
                    ASSIGN
                        wPost.Chassis = uwm301.cha_no
                        wPost.RegNo   = uwm301.vehreg.
                END.
                ELSE DO:
                    ASSIGN
                        wPost.Chassis = ""
                        wPost.RegNo   = "".
                END.

                nv_surname = "".

                /*-- Add A61-0401 --*/
                ASSIGN
                    nv_address = ""
                    nv_addr1   = ""
                    nv_addr2   = ""
                    nv_addr3   = ""
                    nv_addr4   = ""
                    nv_postcd  = "".
                /*-- End Add A61-0401 --*/

                FIND FIRST xmm600 USE-INDEX xmm60001 WHERE
                           xmm600.acno = uwm100.insref NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL xmm600 THEN DO:
                    ASSIGN  
                        wPost.ntitle   = xmm600.ntitle
                        /*wPost.name1    = TRIM(SUBSTR(xmm600.NAME,1,INDEX(xmm600.NAME," ")))
                        wPost.Lname    = TRIM(SUBSTR(xmm600.NAME,INDEX(xmm600.NAME," "),LENGTH(xmm600.NAME)))*//*Comment A59-0423*/
                        wPost.name1    = xmm600.NAME
                        wPost.Lname    = ""
                        wPost.Phone    = xmm600.phone
                        wPost.Addr1    = xmm600.Addr1
                        wPost.Addr2    = xmm600.Addr2 + " " + xmm600.Addr3
                        wPost.Addr3    = xmm600.Addr4
                        wPost.PostCod  = xmm600.postcd.

                    /*wFile.name1 = TRIM(xmm600.ntitle) + " " + TRIM(xmm600.NAME).*//*Comment A59-0423*/
                END.
                ELSE DO: /*-- Add A59-0423 --*/
                    ASSIGN
                        wPost.ntitle   = uwm100.ntitle
                        wPost.name1    = uwm100.NAME1
                        wPost.Lname    = ""
                        wPost.Phone    = ""
                        wPost.Addr1    = uwm100.Addr1
                        wPost.Addr2    = uwm100.Addr2 + " " + uwm100.Addr3
                        wPost.Addr3    = uwm100.Addr4
                        wPost.PostCod  = uwm100.postcd.

                END.  /*-- End Add A59-0423 --*/

                nv_address = wPost.Addr1 + " " + wPost.Addr2 + " " +
                             wPost.Addr3 + " " + wPost.PostCod.

                RUN PDCutAddr.

                ASSIGN
                    wPost.Addr1    = nv_addr1
                    wPost.Addr2    = nv_addr2 + " " + nv_addr3
                    wPost.Addr3    = nv_addr4
                    wPost.PostCod  = nv_postcd.
            END.

            nv_surname     = TRIM(wPost.name1).
            /*-- Add A62-0105 --*/
            IF nv_surname <> "" THEN DO:
                wPost.name1 = TRIM(SUBSTR(nv_surname,1,INDEX(nv_surname," ") - 1)).
                wPost.Lname = TRIM(SUBSTR(nv_surname,LENGTH(wPost.name1) + 1)).
            END.
            /*-- End Add A62-0105 --*/
            /*-- Comment A62-0105 --
            wPost.Lname    = TRIM(SUBSTR(nv_surname,R-INDEX(nv_surname," "))).
            wPost.name1    = TRIM(SUBSTR(nv_surname,1,INDEX(nv_surname," ") - 1)).*/

            nv_filenam = uwm100.policy.
            nt_name1   = uwm100.ntitle + " " + uwm100.NAME1.
            wFile.name1 = nt_name1.

            RUN PDNote.

        END.
        ELSE DO:
            ASSIGN
                wPost.ComDat  = ?
                wPost.ExpDat  = ?
                wPost.RecDat  = "ไม่พบกรมธรรม์"
                wPost.ntitle  = "ไม่สามารถ Create Lotus Note ได้"
                wPost.name1   = wFile.DocNo
                wPost.Lname   = ""
                wPost.Phone   = ""
                wPost.Chassis = ""  /*P1*/
                wPost.RegNo   = ""  /*P1*/
                wPost.Addr1   = ""
                wPost.Addr2   = ""
                wPost.Addr3   = ""
                wPost.PostCod = ""
                wPost.RefEms  = "X"
                wPost.SendDat = ""
                wPost.cpolno  = "".

            n_count = n_count - 1. 

            DELETE wFile.
        END.
    END.
END.

n_count = 0.
cnt1 = 1.
FOR EACH wFile :

    ASSIGN
        n_count = n_count + 1.

    IF wFile.Policy <> "" THEN DO:
        ASSIGN
            wFile.RecNo  = n_count
            wFile.RecCnt = cnt1.
    
        IF n_count = 50 THEN DO:
            n_count = 0.
            cnt1    = cnt1 + 1.
        END.
    END.

END.
/*--*/
FIND FIRST wPost WHERE wPost.RefEms <> "X" NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL wPost THEN DO:
    RUN PDCreNote.
END.
/*--*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

