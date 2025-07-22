&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
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
/*----------------------------------------------------------------------*/
  Modify By : Porntiwa P.  A56-0345  Date : 15/11/2013
            : Match ข้อมูล Policy ส่งห้องผลิต     
            : Duplicate Form WGWTTA01.W ---> WGWTMC01.W
-------------------------------------------------------------------------
 Modify By : Porntiwa P.  A54-0076   15/03/2011
           : ปรับการ Put File Excel เพื่อนำเข้า GW ให้ Put ออกทั้ง 70 + 72 
-------------------------------------------------------------------------
 Modify By : Porntiwa P.  A55-0235  20/08/2012
           : ปรับงาน new Thanachat เพิ่มคอลัมภ์ "ธนาครแถม"  
-------------------------------------------------------------------------
 Modify By : Porntiwa P. A54-0112  26/11/2012
           : ขยายทะเบียนรถจาก 10 เป็น 11 หลัก                   
-------------------------------------------------------------------------
 Modify By : Porntiwa P. A56-0250  14/10/2013
           : ปรับ Format การนำเข้าใหม่เนื่องจากมีการเพิ่มเติม IcNO.                       
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

{wgw\wgwmcgen.i}

DEFINE NEW SHARED WORKFILE wexport NO-UNDO
    FIELD seqno1        AS CHAR FORMAT ">>>>>9"                 INIT ""  
    FIELD policy        AS CHAR FORMAT "X(16)"                  INIT ""  
    FIELD cr_2          AS CHAR FORMAT "X(16)"                  INIT ""
    FIELD sticker       AS CHAR FORMAT "X(15)"                  INIT ""  
    FIELD comdat        AS CHAR FORMAT "99/99/9999"             INIT ""         
    FIELD expdat        AS CHAR FORMAT "99/99/9999"             INIT ""         
    FIELD comdatcomp    AS CHAR FORMAT "99/99/9999"             INIT ""         
    FIELD expdatcomp    AS CHAR FORMAT "99/99/9999"             INIT ""         
    FIELD tiname        AS CHAR FORMAT "X(15)"                  INIT ""  
    FIELD name1         AS CHAR FORMAT "X(50)"                  INIT ""  
    FIELD addr1         AS CHAR FORMAT "X(40)"                  INIT ""  
    FIELD addr2         AS CHAR FORMAT "X(40)"                  INIT ""  
    FIELD addr3         AS CHAR FORMAT "X(40)"                  INIT ""  
    FIELD addr4         AS CHAR FORMAT "X(40)"                  INIT ""  
    FIELD icno          AS CHAR FORMAT "X(14)"                  INIT ""
    FIELD vehreg        AS CHAR FORMAT "X(10)"                  INIT ""  
    FIELD provin        AS CHAR FORMAT "X(2)"                   INIT "" 
    FIELD garage        AS CHAR FORMAT "X(2)"                   INIT "" 
    FIELD yrmanuf       AS INTE FORMAT "9999"                   INIT ""  
    FIELD makdes        AS CHAR FORMAT "X(18)"                  INIT ""  
    FIELD class         AS CHAR FORMAT "X(30)"                  INIT ""  
    FIELD engine        AS CHAR FORMAT "X(05)"                  INIT ""  
    FIELD tons          AS CHAR FORMAT "X(05)"                  INIT "" 
    FIELD body          AS CHAR FORMAT "X(15)"                  INIT ""  
    FIELD access        AS CHAR FORMAT "X(30)"                  INIT ""  
    FIELD engno         AS CHAR FORMAT "X(20)"                  INIT ""  
    FIELD cha_no        AS CHAR FORMAT "X(20)"                  INIT ""  
    FIELD orderno       AS CHAR FORMAT "X(10)"                  INIT ""  
    FIELD finance       AS CHAR FORMAT "X(20)"                  INIT ""  
    FIELD dealer        AS CHAR FORMAT "X(30)"                  INIT ""  
    FIELD si            AS DECI FORMAT ">>>,>>>,>>>,>>>9.99"    INIT 0  
    FIELD class1        AS CHAR FORMAT "X(4)"                   INIT "" 
    FIELD remark        AS CHAR FORMAT "X(60)"                  INIT "" 
    FIELD prem70        AS DECI FORMAT ">,>>>,>99.99"           INIT 0  
    FIELD premtot70     AS DECI FORMAT ">,>>>,>99.99"           INIT 0  
    FIELD prem          AS CHAR FORMAT ">>>>>9.99"              INIT 0  
    FIELD stamp         AS CHAR FORMAT ">>>9.99"                INIT 0  
    FIELD tax           AS CHAR FORMAT ">>>>9.99"               INIT 0  
    FIELD sumtotal      AS CHAR FORMAT ">>>>>9.99"              INIT 0 
    FIELD prem72        AS CHAR FORMAT ">>>>>9.99"              INIT 0 
    FIELD total72       AS CHAR FORMAT ">>>>>9.99"              INIT 0
    FIELD covcod        AS CHAR FORMAT "X(1)"                   INIT "" 
    FIELD vehusg        AS CHAR FORMAT "X(01)"                  INIT "" 
    FIELD ncb           AS DECI FORMAT ">>9.99"                 INIT 0  
    FIELD fleet         AS DECI FORMAT ">>9.99"                 INIT 0  
    FIELD baseprm       AS DECI FORMAT ">,>>>,>>9.99"           INIT 0  
    FIELD bip           AS DECI FORMAT ">>>,>>>,>>9.99"         INIT 0  
    FIELD bia           AS DECI FORMAT ">>>,>>>,>>9.99"         INIT 0  
    FIELD pda           AS DECI FORMAT ">>>,>>>,>>9.99"         INIT 0   
    FIELD m411          AS DECI FORMAT ">>>,>>>,>>9.99"         INIT 0 
    FIELD m412          AS DECI FORMAT ">>>,>>>,>>9.99"         INIT 0 
    FIELD m42           AS DECI FORMAT ">>>,>>>,>>9.99"         INIT 0   
    FIELD m43           AS DECI FORMAT ">>>,>>>,>>9.99"         INIT 0   
    FIELD seats         AS CHAR FORMAT "X(2)"                   INIT ""
    FIELD modcod        AS CHAR FORMAT "X(8)"                   INIT ""
    FIELD tran72        AS CHAR FORMAT "X(2)"                   INIT ""
    FIELD rec_status    AS CHAR FORMAT "X(01)"                  INIT ""  
    FIELD rec_comment   AS CHAR FORMAT "X(100)"                 INIT ""
    .

DEFINE VAR nv_vehreg AS CHAR FORMAT "X(12)".

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON buexit 
     LABEL "EXIT" 
     SIZE 12.5 BY 1.43
     FONT 6.

DEFINE BUTTON buok 
     LABEL " OK" 
     SIZE 12.5 BY 1.43
     FONT 6.

DEFINE BUTTON butFile 
     LABEL " ..." 
     SIZE 3.5 BY 1.1.

DEFINE VARIABLE fiExpName AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 42 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiImpName AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 41.5 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE ra_data AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "NEW", 1,
"RENEW", 2
     SIZE 34.5 BY 1
     BGCOLOR 3 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-379
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 73 BY 5.95
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-380
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 91 BY 1.67
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-381
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 15.33 BY 2.29
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-382
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 15.33 BY 2.29
     BGCOLOR 4 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 92.67 BY 8.76.

DEFINE FRAME fr_main
     fiImpName AT ROW 4.05 COL 23 COLON-ALIGNED NO-LABEL
     ra_data AT ROW 5.48 COL 25.33 NO-LABEL
     fiExpName AT ROW 6.81 COL 23 COLON-ALIGNED NO-LABEL
     butFile AT ROW 4.05 COL 67
     buok AT ROW 4.29 COL 78
     buexit AT ROW 6.62 COL 78
     " Export File Name :" VIEW-AS TEXT
          SIZE 19.5 BY .62 AT ROW 7 COL 5
          BGCOLOR 3 FGCOLOR 15 FONT 6
     "Export Policy MC Motor" VIEW-AS TEXT
          SIZE 29.33 BY 1.19 AT ROW 1.48 COL 33.5
          BGCOLOR 1 FGCOLOR 7 FONT 23
     "(.CSV)" VIEW-AS TEXT
          SIZE 6 BY .62 AT ROW 7.76 COL 15.5
          BGCOLOR 3 FGCOLOR 15 FONT 6
     " Import File Name :" VIEW-AS TEXT
          SIZE 18 BY .62 AT ROW 4.24 COL 5
          BGCOLOR 3 FGCOLOR 15 FONT 6
     RECT-379 AT ROW 3.14 COL 2.17
     RECT-380 AT ROW 1.24 COL 1.67
     RECT-381 AT ROW 3.86 COL 76.5
     RECT-382 AT ROW 6.19 COL 76.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.17 ROW 1.05
         SIZE 92.33 BY 8.52.


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
         HEIGHT             = 8.62
         WIDTH              = 92.5
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
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* REPARENT FRAME */
ASSIGN FRAME fr_main:FRAME = FRAME DEFAULT-FRAME:HANDLE.

/* SETTINGS FOR FRAME DEFAULT-FRAME
   FRAME-NAME                                                           */
/* SETTINGS FOR FRAME fr_main
   Custom                                                               */
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


&Scoped-define FRAME-NAME fr_main
&Scoped-define SELF-NAME buexit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buexit C-Win
ON CHOOSE OF buexit IN FRAME fr_main /* EXIT */
DO:
  APPLY "CLOSE" TO THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buok C-Win
ON CHOOSE OF buok IN FRAME fr_main /*  OK */
DO:

    RUN proc_importmc.

    MESSAGE "Output File Name : " fiExpName " Complete..."
    VIEW-AS ALERT-BOX INFORMATION.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME butFile
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL butFile C-Win
ON CHOOSE OF butFile IN FRAME fr_main /*  ... */
DO:
   DEFINE VARIABLE cvData    AS CHARACTER NO-UNDO.
   DEFINE VARIABLE cvText    AS CHARACTER NO-UNDO.
   DEFINE VARIABLE OKpressed AS LOGICAL INITIAL TRUE.

   SYSTEM-DIALOG GET-FILE cvData
        TITLE     "Choose Data File to Import ..."
        FILTERS   "Text Files (*.*)" "*.*",
                  "Excel (*.csv)" "*.csv",
                  "Excel (*.slk)" "*.slk",
                  "Text Files (*.txt)" "*.txt"              
        MUST-EXIST
        USE-FILENAME
        UPDATE OKpressed.
      
    IF OKpressed = TRUE THEN DO:
         fiImpName = cvData. 
         /*fiExpName = "C:\Thanachat\".*//*Comment A53-0111*/
         /*-- Add Renew A53-0111 ---*/
         cvtext = TRIM(SUBSTRING(cvData,INDEX(cvdata,"\") + 1,LENGTH(cvdata))).
         fiExpName = SUBSTRING(cvData,1,INDEX(cvdata,"\")) +
                     SUBSTRING(cvtext,1,INDEX(cvtext,"\")).
         /*-- End Add ---*/
         DISP fiImpName fiExpName WITH FRAME {&FRAME-NAME}.   
         APPLY "ENTRY" TO ra_data IN FRAME {&FRAME-NAME}.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiExpName
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiExpName C-Win
ON LEAVE OF fiExpName IN FRAME fr_main
DO:
  fiExpName = INPUT fiExpName.
  fiExpName = CAPS(fiExpName + ".csv").
  DISP fiExpName WITH FRAME fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiImpName
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiImpName C-Win
ON LEAVE OF fiImpName IN FRAME fr_main
DO:
  fiImpName = CAPS(INPUT fiImpName).
  DISP fiImpName WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_data
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_data C-Win
ON VALUE-CHANGED OF ra_data IN FRAME fr_main
DO:
  ra_data = INPUT ra_data.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME DEFAULT-FRAME
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
  DEF  VAR  gv_prgid   AS   CHAR  FORMAT "X(8)"   NO-UNDO.
  DEF  VAR  gv_prog    AS   CHAR  FORMAT "X(40)" NO-UNDO.
  
  gv_prgid = "WGWTMC01".
  IF gv_prgid  = "WGWTMC01" THEN gv_prog  = "Export Policy MC Motor".
  ELSE gv_prog  = "Export Policy MC Motor".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).

/*********************************************************************/ 
  RUN  WUT\WUTWICEN (c-win:HANDLE).
  SESSION:DATA-ENTRY-RETURN = YES.

  APPLY "ENTRY" TO fiImpname IN FRAME fr_main.
  ra_data = 1.
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
  VIEW FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  DISPLAY fiImpName ra_data fiExpName 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fiImpName ra_data fiExpName butFile buok buexit RECT-379 RECT-380 
         RECT-381 RECT-382 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_checkmc C-Win 
PROCEDURE proc_checkmc :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wexcel :
    CREATE wexport.

    DO TRANSACTION:
        ASSIGN
            wexport.seqno1      = wexcel.seqno1   
            wexport.policy      = ""   
            wexport.cr_2        = ""    
            wexport.sticker     = "" /*wexcle.sticker*/   
            wexport.comdat      = wexcel.comdat    
            wexport.expdat      = wexcel.expdat    
            wexport.comdatcomp  = wexcel.comdatcomp
            wexport.expdatcomp  = wexcel.expdatcomp
            wexport.tiname      = wexcel.tiname    
            wexport.name1       = wexcel.name1     
            wexport.addr1       = wexcel.addr1     
            wexport.addr2       = wexcel.addr2     
            wexport.addr3       = wexcel.addr3     
            wexport.addr4       = wexcel.addr4     
            wexport.icno        = wexcel.icno      
            wexport.class1      = wexcel.class1    
            wexport.makdes      = wexcel.makdes    
            wexport.class       = wexcel.class   
            wexport.engine      = wexcel.engine  
            wexport.tons        = "" /*wexcle.tons*/    
            wexport.seats       = wexcel.seats   
            wexport.body        = wexcel.body    
            wexport.vehreg      = wexcel.vehreg  
            wexport.provin      = wexcel.provin  
            wexport.engno       = wexcel.engno   
            wexport.cha_no      = wexcel.cha_no  
            wexport.yrmanuf     = wexcel.yrmanuf 
            wexport.vehusg      = wexcel.vehusg  
            wexport.garage      = "" /*wexcel.garage*/  
            wexport.covcod      = wexcel.covcod  
            wexport.si          = wexcel.si     
            wexport.baseprm     = wexcel.baseprm 
            wexport.bip         = wexcel.bip     
            wexport.bia         = wexcel.bia     
            wexport.pda         = wexcel.pda     
            wexport.m411        = wexcel.m411    
            wexport.m412        = wexcel.m412    
            wexport.m42         = wexcel.m42     
            wexport.m43         = wexcel.m43     
            wexport.ncb         = wexcel.ncb     
            wexport.fleet       = wexcel.fleet   
            wexport.prem70      = wexcel.prem70    
            wexport.premtot70   = wexcel.premtot70 
            wexport.prem        = wexcel.prem      
            wexport.stamp       = wexcel.stamp     
            wexport.tax         = wexcel.tax       
            wexport.sumtotal    = wexcel.sumtotal  
            wexport.prem72      = "" /*wexcle.prem72*/    
            wexport.total72     = "" /*wexcle.total72*/ . 
    END.

    FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE
              sicuw.uwm100.cedpol  = "70" + TRIM(wexcel.orderno) AND
              sicuw.uwm100.poltyp  = "V70"          NO-LOCK NO-ERROR.
    IF AVAIL sicuw.uwm100 THEN DO:
        ASSIGN
            wexport.policy = sicuw.uwm100.policy
            wexport.cr_2   = sicuw.uwm100.cr_2.

        IF sicuw.uwm100.cr_2 = "" THEN DO:
            FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE
                      sicuw.uwm100.cedpol  =  "72" + TRIM(wexcel.orderno) AND
                      sicuw.uwm100.poltyp  =  "V72"  NO-LOCK NO-ERROR.
            IF AVAIL sicuw.uwm100 THEN DO:
                ASSIGN
                    wexport.cr_2 = sicuw.uwm100.policy.
            END.
            ELSE DO:
                wexport.cr_2 = "".
            END.
        END.
    END.
    ELSE DO:
        FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE
                  sicuw.uwm100.cedpol  = "72" + TRIM(wexcel.orderno) AND
                  sicuw.uwm100.poltyp  = "V72"  NO-LOCK NO-ERROR. 
        IF AVAIL sicuw.uwm100 THEN DO:
            ASSIGN
                wexport.cr_2 = sicuw.uwm100.policy.
        END.
    END.

    nv_vehreg = wexcel.vehreg.
    IF SUBSTR(wexcel.vehreg,1,1) >= "1" AND SUBSTR(wexcel.vehreg,1,1) <= "9"  THEN DO:
        wexcel.vehreg = TRIM(SUBSTR(nv_vehreg,1,3) + " " + SUBSTR(nv_vehreg,4,4)).
    END.
    ELSE DO:
        wexcel.vehreg = TRIM(SUBSTR(nv_vehreg,1,2) + " " + SUBSTR(nv_vehreg,3,4)).
    END.

    nv_vehreg = TRIM(wexcel.vehreg + " " + wexcel.provin).

    IF wexport.policy = " " OR wexport.cr_2 = " " THEN DO:
        FIND LAST sicuw.uwm301 USE-INDEX uwm30102 WHERE
                  sicuw.uwm301.vehreg = nv_vehreg NO-LOCK NO-ERROR.
        IF AVAIL uwm301 THEN DO:
            IF SUBSTR(sicuw.uwm301.policy,3,2) = "70" THEN DO:
                ASSIGN
                    wexport.policy = sicuw.uwm301.policy.
            END.
            ELSE IF SUBSTR(sicuw.uwm301.policy,3,2) = "72" THEN DO:
                ASSIGN
                    wexport.cr_2 = sicuw.uwm301.policy.
            END.
        END.
    END.

END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_exportmc C-Win 
PROCEDURE proc_exportmc :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
OUTPUT TO VALUE (fiExpName) NO-ECHO APPEND.
   EXPORT DELIMITER "|"
    /*1*/    "No."
    /*2*/    "Policy [V70]"
    /*3*/    "Policy [V72]"
    /*4*/    "Sticker No."
    /*5*/    "Com. Date"
    /*6*/    "Exp. Date"
    /*7*/    "Com. Date พรบ."
    /*8*/    "Exp. Date พรบ."
    /*9*/    "Title Name"
    /*10*/   "Insure name"
    /*11*/   "Address1"
    /*12*/   "Address2"
    /*13*/   "Address3"
    /*14*/   "Address4"
    /*15*/   "IC No."
    /*16*/   "Class"
    /*17*/   "Brand"
    /*18*/   "Model"
    /*19*/   "CC"
    /*20*/   "Weigth"
    /*21*/   "Seat" 
    /*22*/   "Body"
    /*23*/   "เลขทะเบียนรถ"
    /*24*/   "จังหวัด"
    /*25*/   "Engine No."
    /*26*/   "Chaiss No."
    /*27*/   "ปีจดทะเบียน"
    /*28*/   "Veh.Use"
    /*29*/   "Garage"
    /*30*/   "ประเภทความคุ้มครอง"
    /*31*/   "IS"
    /*32*/   "Base Premium"
    /*33*/   "ความเสียหายต่อชีวิต ฯลฯ (บาท/คน)"
    /*34*/   "ความเสียหายต่อชีวิต ฯลฯ (บาท/ครั้ง)"
    /*35*/   "ความเสียหายต่อทรัพย์สิน (บาท/ครั้ง)"
    /*36*/   "อุบัติเหตุส่วนบุคคล (บาท)"
    /*37*/   "อุบัติเหตุส่วนบุคคล (บาท/คน)"
    /*38*/   "ค่ารักษาพยาบาล (บาท/คน)"
    /*39*/   "การประกันตัวผู้ขับขี่ (บาท/ครั้ง)"
    /*40*/   "NCB %"
    /*41*/   "Fleet %"              
    /*42*/   "เบี้ย 70 สุทธิ"       
    /*43*/   "เบี้ย 70 รวม"         
    /*44*/   "เบี้ย 72 สุทธิ"       
    /*45*/   "Stamp 72"             
    /*46*/   "Tax 72"               
    /*47*/   "เบี้ย 72 รวม"         
    /*48*/   "พรบ. สุทธิ หัก 12%"   
    /*49*/   "พรบ. รวม หัก 12%".    

   FOR EACH wexport NO-LOCK:
       EXPORT DELIMITER "|"
    /*1*/    wexport.seqno1 
    /*2*/    wexport.policy
    /*3*/    wexport.cr_2
    /*4*/    wexport.sticker   
    /*5*/    wexport.comdat    
    /*6*/    wexport.expdat    
    /*7*/    wexport.comdatcomp
    /*8*/    wexport.expdatcomp
    /*9*/    wexport.tiname    
    /*10*/   wexport.name1     
    /*11*/   wexport.addr1     
    /*12*/   wexport.addr2     
    /*13*/   wexport.addr3     
    /*14*/   wexport.addr4     
    /*15*/   wexport.icno      
    /*16*/   wexport.class1    
    /*17*/   wexport.makdes    
    /*18*/   wexport.class     
    /*19*/   wexport.engine    
    /*20*/   wexport.tons      
    /*21*/   wexport.seats     
    /*22*/   wexport.body      
    /*23*/   wexport.vehreg    
    /*24*/   wexport.provin    
    /*25*/   wexport.engno     
    /*26*/   wexport.cha_no    
    /*27*/   wexport.yrmanuf   
    /*28*/   wexport.vehusg    
    /*29*/   wexport.garage    
    /*30*/   wexport.covcod    
    /*31*/   wexport.si        
    /*32*/   wexport.baseprm   
    /*33*/   wexport.bip       
    /*34*/   wexport.bia       
    /*35*/   wexport.pda       
    /*36*/   wexport.m411      
    /*37*/   wexport.m412      
    /*38*/   wexport.m42       
    /*39*/   wexport.m43       
    /*40*/   wexport.ncb       
    /*41*/   wexport.fleet     
    /*42*/   wexport.prem70    
    /*43*/   wexport.premtot70 
    /*44*/   wexport.prem      
    /*45*/   wexport.stamp     
    /*46*/   wexport.tax       
    /*47*/   wexport.sumtotal  
    /*48*/   wexport.prem72    
    /*49*/   wexport.total72 .  

   END.

OUTPUT CLOSE.
 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_importmc C-Win 
PROCEDURE proc_importmc :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
INPUT FROM VALUE (fiImpName).
    REPEAT:
        CREATE wexcel.
        IMPORT DELIMITER "|"
            /*1*/   wexcel.seqno1    
            /*2*/   wexcel.policy   
            /*3*/   wexcel.sticker  
            /*4*/   wexcel.comdat   
            /*5*/   wexcel.expdat   
            /*6*/   wexcel.comdatcomp 
            /*7*/   wexcel.expdatcomp 
            /*8*/   wexcel.tiname   
            /*9*/   wexcel.name1    
            /*10*/  wexcel.addr1    
            /*11*/  wexcel.addr2    
            /*12*/  wexcel.addr3    
            /*13*/  wexcel.addr4    
            /*14*/  wexcel.icno     
            /*15*/  wexcel.vehreg   
            /*16*/  wexcel.provin   
            /*17*/  wexcel.yrmanuf  
            /*18*/  wexcel.makdes   
            /*19*/  wexcel.class    
            /*20*/  wexcel.engine   
            /*21*/  wexcel.body     
            /*22*/  wexcel.access   
            /*23*/  wexcel.engno    
            /*24*/  wexcel.cha_no   
            /*25*/  wexcel.orderno  
            /*26*/  wexcel.finance  
            /*27*/  wexcel.dealer   
            /*28*/  wexcel.class1   
            /*29*/  wexcel.remark   
            /*30*/  wexcel.si       
            /*31*/  wexcel.bip      
            /*32*/  wexcel.bia      
            /*33*/  wexcel.pda      
            /*34*/  wexcel.m411      
            /*35*/  wexcel.m412
            /*36*/  wexcel.m42      
            /*37*/  wexcel.m43      
            /*38*/  wexcel.prem70   
            /*39*/  wexcel.premtot70
            /*40*/  wexcel.prem     
            /*41*/  wexcel.stamp    
            /*42*/  wexcel.tax      
            /*43*/  wexcel.sumtotal 
            /*44*/  wexcel.covcod   
            /*45*/  wexcel.vehusg   
            /*46*/  wexcel.ncb      
            /*47*/  wexcel.fleet    
            /*48*/  wexcel.baseprm  
            /*49*/  wexcel.seats    
            /*50*/  wexcel.modcod   
            /*51*/  wexcel.tran72   
            /*52*/  wexcel.tran70.  

    END.
INPUT CLOSE.

RUN proc_checkmc.
RUN proc_exportmc.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

