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

/* ***************************  Definitions  **************************      */
                                                                             
/* Parameters Definitions ---                                                */
/* Local Variable Definitions ---                                            */
/*Program ID    : wgwkkdoc.w                                                 */    
/*Program name : Check Data Document no.                            */
/*create by    : Ranu i. A61-0335 date 10/07/2018                           */
/*              ดึงข้อมูลเลขจัดส่งให้เกียรตินาคิน                           */
/*DataBase connect : GW_SAFE -LD SIC_BRAN, GW_STAT -LD BRSTAT,SICSYAC,SICUW */
/*Modify By   : Porntiwa T. A62-0105  30/07/2019 Change Head Safety         */
/*Modify by   : Ranu I. A65-0288 20/10/2022 แก้ไขฟอร์แมตไฟล์ issue ตามไฟล์ใหม่
                และแก้ไข output file ตามรูปแบบไฟล์ส่งกรมธรรม์ของ KK         */
/*-------------------------------------------------------------------------*/
DEF VAR gv_id  AS CHAR FORMAT "X(12)" NO-UNDO.  
DEF VAR n_user  AS CHAR FORMAT "X(12)" NO-UNDO. 
DEF VAR nv_pwd AS CHAR FORMAT "x(15)" NO-UNDO.  
DEF  stream ns1.

DEFINE NEW SHARED TEMP-TABLE wdoc NO-UNDO      
    /* commetn by : A65-0288...
    FIELD  id          AS CHAR FORMAT "x(2)"   INIT ""
    FIELD  comp        AS CHAR FORMAT "x(60)"  INIT ""
    FIELD  policy      AS CHAR FORMAT "x(15)"  INIT ""
    FIELD  brcode      AS CHAR FORMAT "X(5)"   INIT ""  
    FIELD  brname      AS CHAR FORMAT "X(45)"  INIT ""  
    FIELD  cedcod      AS CHAR FORMAT "X(20)"  INIT ""  
    FIELD  ntitle      AS CHAR FORMAT "x(30)"  INIT "" 
    FIELD  nname       AS CHAR FORMAT "X(50)"  INIT ""
    FIELD  nlname      AS CHAR FORMAT "x(50)"  INIT ""
    FIELD  notify      AS CHAR FORMAT "x(25)"  INIT ""
    FIELD  notdate     AS CHAR FORMAT "x(15)"  INIT ""
    FIELD  license     AS CHAR FORMAT "X(40)"  INIT ""  
    FIELD  brand       AS CHAR FORMAT "X(40)"  INIT ""  
    FIELD  chassis     AS CHAR FORMAT "X(25)"  INIT ""  
    FIELD  mkname      AS CHAR FORMAT "X(50)"  INIT "" 
    FIELD  reqname     AS CHAR FORMAT "x(50)"  INIT ""
    FIELD  covcod      AS CHAR FORMAT "X(50)"  INIT ""  
    FIELD  garage      AS CHAR FORMAT "X(20)"  INIT ""  
    FIELD  si          AS CHAR FORMAT "X(20)"  INIT ""
    FIELD  prem        AS CHAR FORMAT "x(15)"  INIT "" 
    FIELD  comdat      as CHAR format "x(15)"  INIT ""
    FIELD  expdat      as CHAR format "x(15)"  INIT ""
    FIELD  sendto      as CHAR format "x(100)" INIT "" 
    Field  addr1       as char format "x(50)"  init "" 
    Field  addr2       as char format "x(50)"  init "" 
    Field  addr3       as char format "x(50)"  init "" 
    Field  addr4       as char format "x(50)"  init "" 
    Field  addr5       as char format "x(50)"  init "" 
    Field  addr6       as char format "x(50)"  init "" 
    Field  addr7       as char format "x(50)"  init "" 
    Field  addr8       as char format "x(50)"  init "" 
    Field  addr9       as char format "x(50)"  init "" 
    Field  addr10      as char format "x(50)"  init "" 
    Field  remark      as char format "x(250)" init "" 
    Field  tel         as char format "x(25)"  init "" 
    Field  sendbr      as char format "x(100)"  init "" 
    Field  sendname    as char format "x(100)"  init "" 
    Field  kkapp       as char format "x(20)"  init "" 
    Field  postno      as char format "x(20)"  init "" 
    Field  postdate    as char format "x(15)"  init "" 
    Field  address     as char format "x(150)"  init "" 
    end A65-0288...*/
    /* add by : A65-0288 */
    field  refno      as char  init ""
    field  trndat     as char  init ""
    field  insctyp    as char  init ""
    field  inscno     as char  init ""
    field  kkapp      as char  init ""
    field  comp       as char  init ""
    field  policy     as char  init ""
    field  appdat     as char  init ""
    field  comdat     as char  init ""
    field  expdat     as char  init ""
    field  packcode   as char  init ""
    field  si         as char  init ""
    field  prem       as char  init ""
    field  gross      as char  init ""
    field  remark     as char  init ""
    field  postno     as char  init ""
    field  notify     as char  init ""
    field  chassis    as char  init "" 
    FIELD  doctyp     AS CHAR  INIT "" 
    FIELD  postdate    AS CHAR  INIT "" .
    /* end : A65-0288 */

Def  Var chNotesSession  As Com-Handle.
Def  Var chNotesDataBase As Com-Handle.
Def  Var chDocument      As Com-Handle.
Def  Var chNotesView     As Com-Handle .
Def  Var chNavView       As Com-Handle .
Def  Var chViewEntry     As Com-Handle .
Def  Var chItem          As Com-Handle .
Def  Var chData          As Com-Handle .
Def  Var nv_server       As Char.
Def  Var nv_tmp          As char .
DEF VAR nv_year          AS CHAR FORMAT "x(5)" .
DEF VAR nv_docno         AS CHAR FORMAT "x(25)".
DEF VAR nv_survey        AS CHAR FORMAT "x(25)".
DEF VAR nv_detail        AS CHAR FORMAT "x(30)".
DEF VAR nv_remark1       AS CHAR FORMAT "x(250)".
DEF VAR nv_remark2       AS CHAR FORMAT "x(250)".
DEF VAR nv_damlist       AS CHAR FORMAT "x(150)" INIT "" .
DEF VAR nv_damage        AS CHAR FORMAT "x(250)" INIT "" .
DEF VAR nv_totaldam      AS CHAR FORMAT "X(150)" .
DEF VAR nv_attfile       AS CHAR FORMAT "x(100)" INIT "" .
DEF VAR nv_device        AS CHAR FORMAT "x(500)" INIT "".
Def var nv_acc1          as char format "x(50)".   
Def var nv_acc2          as char format "x(50)".   
Def var nv_acc3          as char format "x(50)".   
Def var nv_acc4          as char format "x(50)".   
Def var nv_acc5          as char format "x(50)".   
Def var nv_acc6          as char format "x(50)".   
Def var nv_acc7          as char format "x(50)".   
Def var nv_acc8          as char format "x(50)".   
Def var nv_acc9          as char format "x(50)".   
Def var nv_acc10         as char format "x(50)".   
Def var nv_acc11         as char format "x(50)".   
Def var nv_acc12         as char format "x(50)".   
Def var nv_acctotal      as char format "x(250)".   
DEF VAR nv_surdata       AS CHAR FORMAT "x(250)".
DEF VAR nv_date          AS CHAR FORMAT "x(15)".

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_outfile bu_ok bu_exit-2 fi_year ~
fi_filename bu_file RECT-381 RECT-382 RECT-383 
&Scoped-Define DISPLAYED-OBJECTS fi_outfile fi_year fi_filename 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fn-month C-Win 
FUNCTION fn-month RETURNS CHARACTER
  (ip_month AS INTEGER)  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_exit-2 
     LABEL "Exit" 
     SIZE 7.5 BY 1.05
     FONT 6.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 3.5 BY 1.

DEFINE BUTTON bu_ok 
     LABEL "OK" 
     SIZE 7.5 BY 1.05
     FONT 6.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_outfile AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_year AS CHARACTER FORMAT "X(5)":U 
     VIEW-AS FILL-IN 
     SIZE 15.5 BY 1
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-381
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 105 BY 7.24
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
     fi_outfile AT ROW 6.19 COL 28.83 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 8.38 COL 82.5
     bu_exit-2 AT ROW 8.38 COL 92.67
     fi_year AT ROW 3.91 COL 29 COLON-ALIGNED NO-LABEL
     fi_filename AT ROW 5 COL 29 COLON-ALIGNED NO-LABEL WIDGET-ID 2
     bu_file AT ROW 5.05 COL 91.5 WIDGET-ID 6
     "OUTPUT FILE :" VIEW-AS TEXT
          SIZE 15.33 BY 1 AT ROW 6.14 COL 14.83
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " Check Post Document KK" VIEW-AS TEXT
          SIZE 105 BY 2.14 AT ROW 1.1 COL 1.17
          BGCOLOR 29 FGCOLOR 2 FONT 2
     "**ใช้ไฟล์นำส่งกรมธรรม์ KK เป็นไฟล์แมทหาข้อมูล**" VIEW-AS TEXT
          SIZE 46.5 BY 1 AT ROW 7.43 COL 31.5 WIDGET-ID 8
          BGCOLOR 19 FGCOLOR 12 FONT 1
     "INPUT FILE :" VIEW-AS TEXT
          SIZE 13.33 BY 1 AT ROW 4.95 COL 17 WIDGET-ID 4
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "POST DOCUMENT YEAR :" VIEW-AS TEXT
          SIZE 26.5 BY 1 AT ROW 3.86 COL 4.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "** ปีของกล่อง Post Document **" VIEW-AS TEXT
          SIZE 26.5 BY 1 AT ROW 3.86 COL 49.5
          BGCOLOR 19 FGCOLOR 12 FONT 1
     RECT-381 AT ROW 3.29 COL 1.33
     RECT-382 AT ROW 7.95 COL 91.33
     RECT-383 AT ROW 7.95 COL 81.33
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 105.5 BY 9.67
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
         TITLE              = "Check Post Document KK"
         HEIGHT             = 9.71
         WIDTH              = 105.67
         MAX-HEIGHT         = 10
         MAX-WIDTH          = 106
         VIRTUAL-HEIGHT     = 10
         VIRTUAL-WIDTH      = 106
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

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Check Post Document KK */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Check Post Document KK */
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


&Scoped-define SELF-NAME bu_file
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_file C-Win
ON CHOOSE OF bu_file IN FRAME fr_main /* ... */
DO:
    DEF VAR nv_text AS CHAR FORMAT "x(50)".
    DEFINE VARIABLE cvData    AS CHARACTER NO-UNDO.
    DEFINE VARIABLE OKpressed AS LOGICAL INITIAL TRUE.

    SYSTEM-DIALOG GET-FILE cvData
        TITLE      "Choose Data File to Import ..."
        FILTERS    "File CSV" "*.CSV"

        MUST-EXIST
        USE-FILENAME
        UPDATE OKpressed.

   IF OKpressed = TRUE THEN DO:
       fi_filename  = cvData.
       ASSIGN
        nv_text     = trim(REPLACE(fi_filename,".CSV",""))
       /* nv_text     = IF LENGTH(nv_text) > 35 THEN SUBSTR(nv_text,1,35) ELSE nv_text*/
        fi_outfile  = nv_text + "_postno" +  
                      STRING(MONTH(TODAY),"99")    +     
                      STRING(DAY(TODAY),"99")      + 
                      SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                      SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + ".XLS".
      

       DISP fi_filename fi_outfile WITH FRAME fr_main.    
      /* end : A59-0029*/
   END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok C-Win
ON CHOOSE OF bu_ok IN FRAME fr_main /* OK */
DO:
    FOR EACH wdoc :
        DELETE wdoc.
    END.

    IF fi_filename = "" THEN DO:
        MESSAGE "Input file not Empty..!!!" VIEW-AS ALERT-BOX.
        APPLY "Entry" TO fi_filename.
        RETURN NO-APPLY.
    END.
    IF fi_outfile = "" THEN DO:
        MESSAGE "Output file not Empty..!!!"  VIEW-AS ALERT-BOX.
        APPLY "Entry" TO fi_outfile.
        RETURN NO-APPLY.
    END.
    ELSE DO:
        INPUT FROM VALUE(fi_FileName).
        REPEAT:
         CREATE wdoc .
         IMPORT DELIMITER "|"
             /* create by : A65-0288 */
             wdoc.refno
             wdoc.trndat
             wdoc.insctyp
             wdoc.inscno
             wdoc.kkapp    
             wdoc.comp     
             wdoc.policy   
             wdoc.appdat
             wdoc.comdat   
             wdoc.expdat   
             wdoc.packcode
             wdoc.si       
             wdoc.prem     
             wdoc.gross
             wdoc.remark   
             wdoc.postno
             wdoc.notify   
             wdoc.chassis  .
            /* end A65-0288 */
           /* comment by : A65-0288...
            wdoc.id       
            wdoc.comp     
            wdoc.policy   
            wdoc.brcode   
            wdoc.brname   
            wdoc.cedcod   
            wdoc.ntitle   
            wdoc.nname    
            wdoc.nlname   
            wdoc.notify   
            wdoc.notdate  
            wdoc.license  
            wdoc.brand    
            wdoc.chassis  
            wdoc.mkname   
            wdoc.reqname  
            wdoc.covcod   
            wdoc.garage   
            wdoc.si       
            wdoc.prem     
            wdoc.comdat   
            wdoc.expdat   
            wdoc.sendto   
            wdoc.addr1    
            wdoc.addr2    
            wdoc.addr3    
            wdoc.addr4    
            wdoc.addr5    
            wdoc.addr6    
            wdoc.addr7    
            wdoc.addr8    
            wdoc.addr9    
            wdoc.addr10   
            wdoc.remark   
            wdoc.tel      
            wdoc.sendbr   
            wdoc.sendname 
            wdoc.kkapp    
            end A65-0288...*/
        END.
        RUN proc_chkdata.
    END.
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_filename
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_filename C-Win
ON LEAVE OF fi_filename IN FRAME fr_main
DO:
  fi_filename = INPUT fi_filename.
  DISP fi_filename WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_outfile
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outfile C-Win
ON LEAVE OF fi_outfile IN FRAME fr_main
DO:
  fi_outfile = INPUT fi_outfile.
  DISP fi_outfile WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_year
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_year C-Win
ON LEAVE OF fi_year IN FRAME fr_main
DO:
  fi_year = INPUT fi_year.
  DISP fi_year WITH FRAM fr_main.
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
      gv_prgid          = "WGWKKDOC"
      gv_prog           = "Check Post Document KK "
      fi_year           = STRING(YEAR(TODAY),"9999")
      fi_filename       = ""
      fi_outfile        = "" .
    
  gv_prog  = "Check Post Document KK".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).
  
      DISP fi_year fi_filename fi_outfile WITH FRAM fr_main.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_reportdoc C-Win 
PROCEDURE 00-proc_reportdoc :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
-----------------------------------------------------------------------------*/
/* comment by : A65-0288...
DEF VAR n_pol AS CHAR FORMAT "x(15)" INIT "".
DEF VAR n_recnt AS INT INIT 0.
DEF VAR n_encnt AS INT INIT 0.
DEF VAR n_length1 AS INT INIT 0.
DEF VAR n_length2 AS INT INIT 0.

If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".slk"  THEN 
    fi_outfile  =  Trim(fi_outfile) + ".slk"  .
/*ASSIGN nv_cnt  =  0
       nv_row  =  1.*/
OUTPUT TO VALUE(fi_outfile).
EXPORT DELIMITER "|"  
     " เลขที่สัญญา"                       
     " ทะเบียนรถ  "                       
     " ระบบธนาคาร วันสิ้นสุดกรมธรรม์ "    
     " ชื่อ-สกุล ลูกค้า"                  
     " บริษัทประกันภัย "                  
     " บริษัทนายหน้าประกันภัย "           
     " เลขกรมธรรม์"                       
     " Mkt.       "                       
     " หมายเหตุ   "                       
     " วันที่ จัดส่ง กธ."                 
     " เลขที่ ลงทะเบียน "                 
     " ที่อยู่ จัดส่ง   " .

FOR EACH wdoc  no-lock.
    EXPORT DELIMITER "|" 
        trim(wdoc.cedcod)
        trim(wdoc.license) FORMAT "x(30)"
        string(DATE(wdoc.Comdat),"99/99/9999") + " - " + string(date(wdoc.expdat),"99/99/9999")
        (trim(wdoc.Ntitle) + " " + trim(wdoc.nname) + " " + trim(wdoc.nlname)) FORMAT "x(100)"
        trim(wdoc.comp)
        "ธนาคารเกียรตินาคิน จำกัด (มหาชน) " 
        trim(wdoc.policy)
        trim(wdoc.mkname)
        trim(wdoc.remark) FORMAT "x(100)" 
        trim(wdoc.postdate)
        trim(wdoc.postno)
        trim(wdoc.address) FORMAT "x(100)" .
END. 
OUTPUT CLOSE.
...end A65-0288....*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

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
  DISPLAY fi_outfile fi_year fi_filename 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_outfile bu_ok bu_exit-2 fi_year fi_filename bu_file RECT-381 
         RECT-382 RECT-383 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_put C-Win 
PROCEDURE pd_put :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF INPUT PARAMETER nv_row    AS INT INIT 0.
DEF INPUT PARAMETER nv_col    AS INT INIT 0.
DEF INPUT PARAMETER nv_text   AS CHAR INIT "".
DEF VAR nv_length AS INT INIT 0.
nv_text  = TRIM(nv_text).
nv_length = LENGTH(nv_text) NO-ERROR.
IF nv_length <> 0 AND nv_text <> ? THEN DO:
     PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_col) ";K" '"' nv_text  FORMAT "x(" + STRING(nv_length) + ")"  '"' SKIP.  
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkdata C-Win 
PROCEDURE proc_chkdata :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:   
------------------------------------------------------------------------------*/
FOR EACH wdoc .
    /* 
    IF index(wdoc.id,"บริษัท") <> 0 THEN DELETE wdoc.
    ELSE IF index(wdoc.id,"ที่") <> 0 THEN DELETE wdoc.
    ELSE IF index(wdoc.id,"ลำดับ") <> 0 THEN DELETE wdoc.
    ELSE IF wdoc.id = ""  THEN DELETE wdoc.
    */
    IF index(wdoc.chassis,"Chassis") <> 0 THEN DELETE wdoc.
    ELSE IF wdoc.Chassis = ""  THEN DELETE wdoc.
    ELSE DO:
        IF wdoc.policy <> ""  AND wdoc.postno = "" THEN RUN proc_datadoc .
    END.
END.
RUN proc_reportdoc.

Message "Export data Complete"  View-as alert-box.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_datadoc C-Win 
PROCEDURE proc_datadoc :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 DO:   
    DEF VAR n_list      AS INT init 0.
    DEF VAR n_count     AS INT init 0.
    DEF VAR n_repair    AS CHAR FORMAT "x(10)" init "".
    DEF VAR n_dam       AS CHAR FORMAT "x(10)" init "".
    DEF VAR n_detail    AS CHAR FORMAT "x(60)" init "".
    DEF VAR nv_damag    AS CHAR FORMAT "x(30)" init "".
    DEF VAR nv_repair   AS CHAR FORMAT "x(30)" init "".
    DEF VAR nv_damdetail AS LONGCHAR  INIT "". 
    DEF VAR n_agent      AS CHAR FORMAT "x(12)" INIT "".
    DEF VAR nv_cretdate  AS CHAR FORMAT "x(15)" INIT "" .
    

     ASSIGN  nv_year     = ""    nv_docno  = ""     nv_remark1  = ""     nv_remark2  = ""
             nv_date     = ""    n_agent    = ""     nv_cretdate = ""    n_detail    = ""
             nv_year     = TRIM(fi_year)
             nv_tmp      = "postdocument" + SUBSTR(nv_year,3,2) + ".nsf".
    /*--------- Server Real ----------*/
    nv_server = "Safety_NotesServer/Safety".
    nv_tmp   = "safety\fi\" + nv_tmp .
    /*-------------------------------*/
    /*---------- Server test local ------
    nv_server = "".
    nv_tmp    = "U:\Lotus\Notes\Data\ranu\" + nv_tmp .
    -----------------------------*/
    DISP "Check Data Post document no." + wdoc.policy + " ......" 
    WITH COLOR BLACK/WHITE NO-LABEL TITLE "Please Wait...." WIDTH 80 FRAME AA VIEW-AS DIALOG-BOX.

    CREATE "Notes.NotesSession"  chNotesSession.
    chNotesDatabase  = chNotesSession:GetDatabase (nv_server,nv_tmp).

      IF  chNotesDatabase:IsOpen()  = NO  THEN  DO:
         MESSAGE "Can not open database" SKIP  
                 "Please Check database and serve" VIEW-AS  ALERT-BOX ERROR.
      END.
      ELSE DO:
        chNotesView    = chNotesDatabase:GetView("By PolicyNo").
        chNavView      = chNotesView:CreateViewNav.
        chDocument     = chNotesView:GetDocumentByKey(wdoc.policy).
        /*chNavView      = chNotesView:CreateViewNavFromCategory(wdoc.policy).
        chViewEntry    = chNavView:GetLastDocument.
        chDocument     = chViewEntry:Document. */
        IF VALID-HANDLE(chDocument) = YES THEN DO:
        
            chitem       = chDocument:Getfirstitem("Date").      /*วันที่จัดส่ง*/
            IF chitem <> 0 THEN nv_date = chitem:TEXT. 
            ELSE nv_date = "".
        
            chitem       = chDocument:Getfirstitem("Address").      /*วันที่ปิดเรื่อง*/
            IF chitem <> 0 THEN n_detail = chitem:TEXT. 
            ELSE n_detail = "".
        
            chitem       = chDocument:Getfirstitem("EmsNo").      /*เลข Ems */
            IF chitem <> 0 THEN nv_docno = chitem:TEXT. 
            ELSE nv_docno = "".
            
          
            IF nv_docno <> ""  THEN DO:
               ASSIGN wdoc.postno     = trim(nv_docno)
                      wdoc.postdate   = trim(nv_date) .
               /* comment by :A65-0288 ...
               IF INDEX(n_detail,wdoc.nname) <> 0 AND INDEX(n_detail,wdoc.nlname) <> 0 THEN DO:
                   ASSIGN wdoc.address = TRIM(TRIM(wdoc.addr1) + " " + TRIM(wdoc.addr2) + " " + TRIM(wdoc.addr3) + " " +
                                         TRIM(wdoc.addr4) + " " + TRIM(wdoc.addr5) + " " + TRIM(wdoc.addr6) + " " +
                                         TRIM(wdoc.addr7) + " " + TRIM(wdoc.addr8) + " " + TRIM(wdoc.addr9) + " " +
                                         TRIM(wdoc.addr10)) .
               END.
               ...end : A65-0288..*/
        
            END.
        END.
                                                   
        RELEASE  OBJECT chitem          NO-ERROR.   
        RELEASE  OBJECT chDocument      NO-ERROR.   
        RELEASE  OBJECT chNotesDataBase NO-ERROR.   
        RELEASE  OBJECT chNotesSession  NO-ERROR.   
      END.



 END.
      

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportdoc C-Win 
PROCEDURE proc_reportdoc :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
-----------------------------------------------------------------------------*/
DEF VAR nv_column AS INT INIT 0.
DEF VAR nv_count  AS INT INIT 0.
DEF VAR n_count  AS INT INIT 0.
DEF VAR nv_doctyp AS CHAR INIT "" .
DEF VAR nv_date AS DATE .
DEF VAR n_month    AS INT INIT 0 .
DEF VAR n_monthtxt AS CHAR .


    nv_count = nv_count + 1.
    IF nv_count = 1 THEN DO:
        OUTPUT STREAM ns1 TO VALUE(fi_outfile) .
        PUT STREAM ns1 "ID;PND" SKIP.        
        nv_column = nv_column + 1.
        run pd_put(input nv_count,nv_column,"KK_APP_NO             " ).   nv_column = nv_column + 1.  
        run pd_put(input nv_count,nv_column,"INSURANCE_COMPANY_CODE" ).   nv_column = nv_column + 1.
        run pd_put(input nv_count,nv_column,"DOCUMENTTYPE          " ).   nv_column = nv_column + 1.
        run pd_put(input nv_count,nv_column,"EMS                   " ).   nv_column = nv_column + 1.
        run pd_put(input nv_count,nv_column,"DELIVERYDATE          " ).   nv_column = nv_column + 1.
        OUTPUT STREAM ns1 CLOSE.
    END.
    
    OUTPUT STREAM ns1 TO VALUE(fi_outfile) APPEND . 
    ASSIGN  n_count = 1 
            nv_count   = nv_count + 1.
     FOR EACH wdoc WHERE wdoc.postdate <> ""  :
         ASSIGN 
             nv_date         = ?
             n_month         = 0
             n_monthtxt      = ""
             nv_date         = DATE(wdoc.postdate)
             n_month         = MONTH(nv_date)
             n_monthtxt      = TRIM(fn-month(n_month))
             wdoc.postdate   = TRIM(STRING(DAY(nv_date),"99") + "-" +  n_monthtxt + "-" + STRING(YEAR(nv_date),"9999"))

        n_count = 1 .
        nv_column  = 1 .
        loop_comment:
        REPEAT:
           IF n_count <= 3 THEN DO:
               nv_column  = 1 .
               IF n_count = 1  THEN nv_doctyp = "POLICY".
               ELSE IF n_count = 2  THEN nv_doctyp = "COPYPOLICY".
               ELSE IF n_count = 3  THEN nv_doctyp = "PAYMENT" .
                 
               run pd_put(input nv_count,nv_column,wdoc.kkapp)    no-error.   nv_column = nv_column + 1.     
               run pd_put(input nv_count,nv_column,wdoc.comp)     no-error.   nv_column = nv_column + 1.     
               run pd_put(input nv_count,nv_column,nv_doctyp)     no-error.   nv_column = nv_column + 1.     
               run pd_put(input nv_count,nv_column,wdoc.postno)   no-error.   nv_column = nv_column + 1.     
               run pd_put(input nv_count,nv_column,wdoc.postdate) no-error.   nv_column = nv_column + 1. 
               nv_count   = nv_count + 1.
           
               n_count = n_count + 1.
           END.
           ELSE LEAVE loop_comment.
        END.
     END.
    /*
    loop_comment:
    REPEAT:
       IF n_count <= 3 THEN DO:
           IF n_count = 1  THEN nv_doctyp = "POLICY".
           ELSE IF n_count = 2  THEN nv_doctyp = "COPYPOLICY".
           ELSE IF n_count = 3  THEN nv_doctyp = "PAYMEMT" .

           FOR EACH wdoc WHERE wdoc.postdate <> ""  NO-LOCK:
               nv_column  = 1 .
                run pd_put(input nv_count,nv_column,wdoc.kkapp)    no-error.   nv_column = nv_column + 1.     
                run pd_put(input nv_count,nv_column,wdoc.comp)     no-error.   nv_column = nv_column + 1.     
                run pd_put(input nv_count,nv_column,nv_doctyp)     no-error.   nv_column = nv_column + 1.     
                run pd_put(input nv_count,nv_column,wdoc.postno)   no-error.   nv_column = nv_column + 1.     
                run pd_put(input nv_count,nv_column,wdoc.postdate) no-error.   nv_column = nv_column + 1. 
               nv_count   = nv_count + 1.
           END.
           n_count = n_count + 1.
       END.
       ELSE LEAVE loop_comment.
    END.*/
    /*
    FOR EACH wdoc WHERE wdoc.postdate <> ""  NO-LOCK:
        ASSIGN
            nv_column  = 1
            nv_count   = nv_count + 1.
        run pd_put(input nv_count,nv_column,wdoc.kkapp)    no-error.   nv_column = nv_column + 1.     
        run pd_put(input nv_count,nv_column,wdoc.comp)     no-error.   nv_column = nv_column + 1.     
        run pd_put(input nv_count,nv_column,wdoc.doctyp)   no-error.   nv_column = nv_column + 1.     
        run pd_put(input nv_count,nv_column,wdoc.postno)   no-error.   nv_column = nv_column + 1.     
        run pd_put(input nv_count,nv_column,wdoc.postdate) no-error.   nv_column = nv_column + 1.           

    END.*/
    PUT STREAM ns1 "E" SKIP.
    OUTPUT STREAM ns1 CLOSE.                                                                                                           
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fn-month C-Win 
FUNCTION fn-month RETURNS CHARACTER
  (ip_month AS INTEGER) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
DEF VAR n_month AS CHAR NO-UNDO INIT "JAN,FEB,MAR,APR,MAY,JUN,JUL,AUG,SEP,OCT,NOV,DEC".
    IF ip_month LT 1 OR ip_month GT 12 THEN
        RETURN "".

   RETURN ENTRY(ip_month,n_month).

/*RETURN "". */ /* Function return value. */
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

