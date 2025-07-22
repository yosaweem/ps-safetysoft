&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*------------------------------------------------------------------------

  File:         WacTAS66.W

  Description:  โปรแกรมสำหรับ Split File ตามเงื่อนไขของ Thai Auto Sales ดังนี้
                1. Split file ออกเป็น 4 ไฟล์ ดังนี้
                  1. เรคคอร์ดที่ Producer Code = "B3M0031" , "B3M0018"
                  2. เรคคอร์ดที่ไม่เข้าเงื่อนไขข้อ 1 และ Contract no ขึ้นต้นด้วย "1"
                  3. เรคคอร์ดที่ไม่เข้าเงื่อนไขข้อ 1 และ Contract no ขึ้นต้นด้วย "2"
                  4. เรคคอร์ดที่ไม่เข้าเงื่อนไขข้อ 1 - 3
                  
                2. ใช้ไฟล์จาก 1 มา Convert เป็น Text file ตามรูปแบบของ Thai Auto Sales เป็นรูปแบบ .csv คือ คั่นด้วย  comma (,)   

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author:   Tantawan Ch.

  Created:  A60-0379   @25/09/2017
------------------------------------------------------------------------*
 Modify by  : Tantawan Ch.  
 ASSIGN     : A61-0001    Date : 4/1/2018
            : ขึ้นตอนๆ แปลงไฟล์ ให้รับค่าจาก .csv file  (คั่นด้วย , )
------------------------------------------------------------------------*/
/*          This .W file was created with the Progress UIB.             */
/*----------------------------------------------------------------------*/

/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */
/************************************************************************/
CREATE WIDGET-POOL.
/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */
DEFINE NEW SHARED WORKFILE wdetail NO-UNDO
    FIELD head            AS CHAR FORMAT "X(30)"      INIT "" 
    FIELD insure          AS CHAR FORMAT "X(60)"      INIT "" 
    FIELD trndat          AS CHAR FORMAT "99999999"   INIT ""    
    FIELD policymain      AS CHAR FORMAT "X(26)"      INIT "" 
    FIELD endno           AS CHAR FORMAT "X(15)"      INIT ""
    FIELD policy          AS CHAR FORMAT "X(26)"      INIT "" 
    FIELD polcomp         AS CHAR FORMAT "X(26)"      INIT "" 
    FIELD engine          AS CHAR FORMAT 'x(26)'      INIT "" 
    FIELD chass           AS CHAR FORMAT 'x(26)'      INIT "" 
    FIELD contract        AS CHAR FORMAT "X(20)"      INIT ""  
    FIELD engc            AS CHAR FORMAT 'x(12)'      INIT ""  
    FIELD comdat          AS CHAR FORMAT "99999999"   INIT ""  
    FIELD grossprem       AS CHAR FORMAT "9999999999" INIT ""    
    FIELD CompGrossPrem   AS CHAR FORMAT "9999999999"  INIT ""   
    FIELD NetPrem         AS CHAR FORMAT "9999999999"  INIT ""   
    FIELD CompNetPrem     AS CHAR FORMAT "9999999999"  INIT ""   
    FIELD tax             AS CHAR FORMAT "9999999999" INIT ""    
    FIELD NetPayment      AS CHAR FORMAT "9999999999" INIT ""    
    FIELD nSTATUS         AS CHAR FORMAT "x(20)"      INIT "" 
    FIELD Name2           AS CHAR FORMAT "x(60)"      INIT "" 
    FIELD VatCode         AS CHAR FORMAT "9999999999" INIT "" 
    FIELD Producer        AS CHAR FORMAT "x(10)"      INIT "" 
    FIELD Brand_Model     AS CHAR FORMAT "x(60)"      INIT "" 
    .

DEF VAR n_type AS INTE FORMAT "9" .
                  
DEF VAR np_policy   AS CHAR FORMAT "x(26)" INIT "" .                     
DEF VAR head           AS CHAR  FORMAT "X(30)"        INIT "" .           
DEF VAR insure         AS CHAR  FORMAT "X(60)"        INIT "" . 
DEF VAR trndat         AS CHAR  FORMAT "99999999"     INIT "".
DEF VAR policymain     AS CHAR  FORMAT "X(26)"        INIT "" .           
DEF VAR endno          AS CHAR  FORMAT "X(15)"        INIT "".
DEF VAR policy         AS CHAR  FORMAT "X(26)"        INIT "" .           
DEF VAR polcomp        AS CHAR  FORMAT "X(26)"        INIT "" .           
DEF VAR engine         AS CHAR  FORMAT 'x(26)'        INIT "" .           
DEF VAR chass          AS CHAR  FORMAT 'x(26)'        INIT "" .           
DEF VAR contract       AS CHAR  FORMAT "X(20)"        INIT "" .           
DEF VAR engc           AS CHAR  FORMAT 'x(12)'        INIT "" .           
DEF VAR comdat         AS CHAR  FORMAT "99999999"     INIT "" .           
DEF VAR grossprem      AS CHAR  FORMAT "9999999999"   INIT "" .           
DEF VAR CompGrossPrem  AS CHAR  FORMAT "9999999999"   INIT "" .           
DEF VAR NetPrem        AS CHAR  FORMAT "9999999999"   INIT "" .           
DEF VAR CompNetPrem    AS CHAR  FORMAT "9999999999"   INIT "" .           
DEF VAR tax            AS CHAR  FORMAT "9999999999"   INIT "" .           
DEF VAR NetPayment     AS CHAR  FORMAT "9999999999"   INIT "" .           
DEF VAR nSTATUS        AS CHAR  FORMAT "x(20)"        INIT "" .           
DEF VAR Name2          AS CHAR  FORMAT "x(60)"        INIT "" .           
DEF VAR VatCode        AS CHAR  FORMAT "9999999999"   INIT "" .   
DEF VAR Producer       AS CHAR  FORMAT "x(10)"        INIT "" .  
DEF VAR Brand_Model    AS CHAR  FORMAT "x(60)"        INIT "" .  
/* -------end sarinya c. A59-0362----------- */
DEF VAR n_wh1         AS DECI INIT 0.
DEF VAR n_nettotel    AS DECI INIT 0.
DEF VAR nstmp70       AS DECI INIT 0.
DEF VAR nstmp72       AS DECI INIT 0.

DEF VAR nv_cnt0       AS INT .
DEF VAR nv_cnt1       AS INT .
DEF VAR nv_cnt2       AS INT .
DEF VAR nv_cnt3       AS INT .
DEF VAR nv_cnt4       AS INT .

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_filename fi_outfile bu_ok fi_producer1 ~
ra_type bu_file bu_exit fi_outcontract2 fi_outproducer fi_outcontract1 ~
fi_producer2 fi_outother fi_producer3 RECT-76 RECT-77 RECT-79 RECT-78 ~
RECT-80 
&Scoped-Define DISPLAYED-OBJECTS fi_filename fi_outfile fi_producer1 ~
ra_type fi_outcontract2 fi_outproducer fi_outcontract1 fi_producer2 ~
fi_outother fi_producer3 

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
     SIZE 12 BY 1.38
     FONT 6.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 4 BY 1.

DEFINE BUTTON bu_ok 
     LABEL "Ok" 
     SIZE 12 BY 1.38
     FONT 6.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(110)":U 
     VIEW-AS FILL-IN 
     SIZE 66 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_outcontract1 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 66 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_outcontract2 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 66 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_outfile AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 66 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_outother AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 66 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_outproducer AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 66 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_producer1 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_producer2 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_producer3 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_type AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Split File", 1,
"Convert to Send", 2
     SIZE 18.67 BY 1.95
     BGCOLOR 18 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-76
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 111.5 BY 21.67
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-77
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 14.5 BY 2.19
     BGCOLOR 5 .

DEFINE RECTANGLE RECT-78
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 14.5 BY 2.19
     BGCOLOR 6 .

DEFINE RECTANGLE RECT-79
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 108.5 BY 4.62
     BGCOLOR 5 FGCOLOR 5 .

DEFINE RECTANGLE RECT-80
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 108.5 BY 4.95
     BGCOLOR 14 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_filename AT ROW 9.48 COL 38.67 COLON-ALIGNED NO-LABEL
     fi_outfile AT ROW 11.71 COL 38.67 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 20.71 COL 42.5
     fi_producer1 AT ROW 5.76 COL 28 COLON-ALIGNED NO-LABEL
     ra_type AT ROW 2.71 COL 25.83 NO-LABEL
     bu_file AT ROW 9.48 COL 107.5
     bu_exit AT ROW 20.81 COL 99.33
     fi_outcontract2 AT ROW 17.71 COL 39 COLON-ALIGNED NO-LABEL
     fi_outproducer AT ROW 15.43 COL 39 COLON-ALIGNED NO-LABEL
     fi_outcontract1 AT ROW 16.57 COL 39 COLON-ALIGNED NO-LABEL
     fi_producer2 AT ROW 6.91 COL 28 COLON-ALIGNED NO-LABEL
     fi_outother AT ROW 18.86 COL 39 COLON-ALIGNED NO-LABEL
     fi_producer3 AT ROW 8.14 COL 28 COLON-ALIGNED NO-LABEL
     "                   INPUT FILE :":30 VIEW-AS TEXT
          SIZE 26 BY 1 AT ROW 9.48 COL 14.33
          BGCOLOR 5 FGCOLOR 0 FONT 6
     "   SPLIT FILE and  CONVERT EXCEL FILE TO TEXT FILE":50 VIEW-AS TEXT
          SIZE 57 BY 1.05 AT ROW 1.43 COL 31
          FGCOLOR 1 FONT 6
     "OUTPUT FILE MU-X,TIL,ALL NEW :" VIEW-AS TEXT
          SIZE 34.83 BY 1 AT ROW 15.43 COL 5.67
          BGCOLOR 14 FGCOLOR 1 FONT 6
     "Split File to :" VIEW-AS TEXT
          SIZE 12.83 BY .95 AT ROW 14.14 COL 4.17
          BGCOLOR 14 FGCOLOR 1 FONT 6
     "** ระบุ Producer สำหรับเงื่อนไขไฟล์ MU-X , TIL และ ALL NEW" VIEW-AS TEXT
          SIZE 61.5 BY .76 AT ROW 4.91 COL 14.83
          BGCOLOR 19 FGCOLOR 1 
     "1." VIEW-AS TEXT
          SIZE 2.83 BY .95 AT ROW 5.86 COL 25.83
          BGCOLOR 8 FONT 6
     "2." VIEW-AS TEXT
          SIZE 2.83 BY .95 AT ROW 6.95 COL 25.83
          BGCOLOR 8 FONT 6
     "1. แยกข้อมูลตามเงื่อนไขเป็น 4 ไฟล์" VIEW-AS TEXT
          SIZE 44.5 BY .95 AT ROW 2.71 COL 45.5
          BGCOLOR 8 FGCOLOR 2 
     "3." VIEW-AS TEXT
          SIZE 2.83 BY .95 AT ROW 8.14 COL 25.83
          BGCOLOR 8 FONT 6
     "OUTPUT FILE CONTRACT BEGIN 1 :" VIEW-AS TEXT
          SIZE 35.5 BY 1 AT ROW 16.57 COL 4.67
          BGCOLOR 14 FGCOLOR 1 FONT 6
     "* เลือกไฟล์ที่ต้องการ Split (ใช้ไฟล์ที่ลงท้ายด้วย byContract) หรือ Convert file" VIEW-AS TEXT
          SIZE 61.5 BY .86 AT ROW 10.57 COL 40.83 WIDGET-ID 4
          BGCOLOR 5 FGCOLOR 7 
     "* กรณี Convert to Send ให้ระบุ Convert to Send OUTPUT FILE" VIEW-AS TEXT
          SIZE 61.5 BY .86 AT ROW 12.81 COL 40.83 WIDGET-ID 6
          BGCOLOR 5 FGCOLOR 7 
     "OUTPUT FILE OTHER :" VIEW-AS TEXT
          SIZE 23 BY 1 AT ROW 18.76 COL 16.83
          BGCOLOR 14 FGCOLOR 1 FONT 6
     "Convert to Send OUTPUT FILE :" VIEW-AS TEXT
          SIZE 31.33 BY 1 AT ROW 11.71 COL 8.67
          BGCOLOR 5 FGCOLOR 0 FONT 6
     "Producer :" VIEW-AS TEXT
          SIZE 10.5 BY .95 AT ROW 5.76 COL 14.67
          BGCOLOR 8 FONT 6
     "Convert Type :":30 VIEW-AS TEXT
          SIZE 14.33 BY 1 AT ROW 2.71 COL 10.83
          BGCOLOR 20 FONT 6
     "2. แปลงข้อมูลจากข้อ 1 ให้เป็น Text File ตามรูปแบบ TAS" VIEW-AS TEXT
          SIZE 44.5 BY 1 AT ROW 3.67 COL 45.5
          BGCOLOR 8 FGCOLOR 2 
     "OUTPUT FILE CONTRACT BEGIN 2 :" VIEW-AS TEXT
          SIZE 35.5 BY 1 AT ROW 17.67 COL 4.67
          BGCOLOR 14 FGCOLOR 1 FONT 6
     RECT-76 AT ROW 1.24 COL 2
     RECT-77 AT ROW 20.33 COL 41.33
     RECT-79 AT ROW 9.24 COL 4
     RECT-78 AT ROW 20.38 COL 98
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 112.83 BY 22.14
         BGCOLOR 3 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     RECT-80 AT ROW 15.1 COL 4
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 112.83 BY 22.14
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
         TITLE              = "  CONVERT EXCEL FILE TO TEXT FILE TAS"
         HEIGHT             = 22.19
         WIDTH              = 113.17
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
ON END-ERROR OF C-Win /*   CONVERT EXCEL FILE TO TEXT FILE TAS */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /*   CONVERT EXCEL FILE TO TEXT FILE TAS */
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
         FILTERS   "Text .CSV" "*.csv",
                   "Text file" "*.txt",
                   "All" "*.*"

         MUST-EXIST
         USE-FILENAME
         UPDATE OKpressed.
    
    IF OKpressed = TRUE THEN DO:
         fi_filename  = cvData.

         IF ra_type = 1  THEN DO:
             IF r-INDEX(cvData,"/") <> 0 THEN DO:
                 ASSIGN 
                     fi_outfile      = ""
                     fi_outproducer  = SUBSTRING(cvData,1,((r-INDEX(cvData,"/"))))  + "INS_STATEMENT_ป้ายแดง" + ".txt" 
                     fi_outcontract1 = SUBSTRING(cvData,1,((r-INDEX(cvData,"/"))))  + "INS_STATEMENT_RENEW"   + ".txt" 
                     fi_outcontract2 = SUBSTRING(cvData,1,((r-INDEX(cvData,"/"))))  + "INS_STATEMENT_NON-TIL" + ".txt"  
                     fi_outother     = SUBSTRING(cvData,1,((r-INDEX(cvData,"/"))))  + "INS_STATEMENT_OTHER"   + ".txt"  .
             END.
             ELSE IF r-INDEX(cvData,"\") <> 0 THEN DO:
                 ASSIGN 
                     fi_outfile      = ""
                     fi_outproducer  = SUBSTRING(cvData,1,((r-INDEX(cvData,"\"))))  + "INS_STATEMENT_ป้ายแดง" + ".txt"     
                     fi_outcontract1 = SUBSTRING(cvData,1,((r-INDEX(cvData,"\"))))  + "INS_STATEMENT_RENEW"   + ".txt"     
                     fi_outcontract2 = SUBSTRING(cvData,1,((r-INDEX(cvData,"\"))))  + "INS_STATEMENT_NON-TIL" + ".txt"     
                     fi_outother     = SUBSTRING(cvData,1,((r-INDEX(cvData,"\"))))  + "INS_STATEMENT_OTHER"   + ".txt"  .  
             END.
         END.
         ELSE DO:
             ASSIGN
                 fi_outfile      = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))    +  "_Send.csv" /*.csv*/
                 fi_outproducer  = ""
                 fi_outcontract1 = ""  
                 fi_outcontract2 = ""  
                 fi_outother     = "".
         END.

         DISP fi_filename fi_outfile  fi_outproducer  fi_outcontract1 fi_outcontract2 fi_outother WITH FRAME fr_main.     

    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok C-Win
ON CHOOSE OF bu_ok IN FRAME fr_main /* Ok */
DO:
    IF fi_filename <> "" THEN DO:

        IF      n_type = 1 THEN  Run Pro_createfile_Mat. /* Match file 4 file */ 
        ELSE IF n_type = 2 THEN  RUN Pro_createfile.
        ELSE DO : 
            MESSAGE "ไม่มีการเลือก Convert Type, กรุณาตรวจสอบข้อมูลใหม่" VIEW-AS ALERT-BOX WARNING.
            RETURN NO-APPLY.
        END.
    END.
    ELSE DO:
        MESSAGE "กรุณาเลือกไฟล์ที่ต้องการ Convert " VIEW-AS ALERT-BOX WARNING.
        RETURN NO-APPLY.
    END.
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


&Scoped-define SELF-NAME fi_outcontract1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outcontract1 C-Win
ON LEAVE OF fi_outcontract1 IN FRAME fr_main
DO:
  fi_outfile  =  Input  fi_outfile.
  Disp  fi_outfile with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_outcontract2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outcontract2 C-Win
ON LEAVE OF fi_outcontract2 IN FRAME fr_main
DO:
  fi_outfile  =  Input  fi_outfile.
  Disp  fi_outfile with frame  fr_main.
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


&Scoped-define SELF-NAME fi_outother
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outother C-Win
ON LEAVE OF fi_outother IN FRAME fr_main
DO:
  fi_outfile  =  Input  fi_outfile.
  Disp  fi_outfile with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_outproducer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outproducer C-Win
ON LEAVE OF fi_outproducer IN FRAME fr_main
DO:
  fi_outproducer  =  Input  fi_outproducer.
  Disp  fi_outproducer with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producer1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer1 C-Win
ON LEAVE OF fi_producer1 IN FRAME fr_main
DO:
    fi_producer1 = INPUT fi_producer1.

    DISP fi_producer1 WITH FRAM fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producer2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer2 C-Win
ON LEAVE OF fi_producer2 IN FRAME fr_main
DO:
    fi_producer2 = INPUT fi_producer2.

    DISP fi_producer2 WITH FRAM fr_main.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producer3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer3 C-Win
ON LEAVE OF fi_producer3 IN FRAME fr_main
DO:
    fi_producer3 = INPUT fi_producer3.

    DISP fi_producer3 WITH FRAM fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_type
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_type C-Win
ON VALUE-CHANGED OF ra_type IN FRAME fr_main
DO:
    
    ASSIGN 
        ra_type = INPUT ra_type
        n_type  = ra_type
        fi_filename     = ""
        fi_outfile      = ""
        fi_outproducer  = "" 
        fi_outcontract1 = ""
        fi_outcontract2 = ""
        fi_outother     = "".

    DISP ra_type fi_filename fi_outfile fi_outproducer fi_outcontract1 fi_outcontract2 fi_outother WITH FRAME {&FRAME-NAME}. 
    
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
  
  gv_prgid = "WacTAS66".
  gv_prog  = "Convert Excel File TIL to Text file TAS".
  /*RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).*/
  
  ASSIGN 
      ra_type       = 1 
      fi_producer1  = "B3M0031"
      fi_producer2  = "B3M0018"
      n_type        = ra_type.

  DISP ra_type fi_producer1 fi_producer2 WITH FRAM fr_main.

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
  DISPLAY fi_filename fi_outfile fi_producer1 ra_type fi_outcontract2 
          fi_outproducer fi_outcontract1 fi_producer2 fi_outother fi_producer3 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_filename fi_outfile bu_ok fi_producer1 ra_type bu_file bu_exit 
         fi_outcontract2 fi_outproducer fi_outcontract1 fi_producer2 
         fi_outother fi_producer3 RECT-76 RECT-77 RECT-79 RECT-78 RECT-80 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_ExpDetail C-Win 
PROCEDURE pd_ExpDetail :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
EXPORT DELIMITER "|" 
   wdetail.head
   wdetail.insure 
   wdetail.policy         
   wdetail.polcomp        
   wdetail.engine       
   wdetail.chass        
   wdetail.contract     
   wdetail.engc         
   wdetail.comdat
   wdetail.grossprem
   wdetail.CompGrossPrem
   wdetail.NetPrem
   wdetail.CompNetPrem
   wdetail.tax       
   wdetail.NetPayment
   wdetail.nSTATUS      
   wdetail.Name2            
   wdetail.VatCode    
   wdetail.Producer    
   wdetail.Brand_Model .  

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_ExpHead C-Win 
PROCEDURE pd_ExpHead :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
EXPORT DELIMITER "|"  
    "head"
    "Customer Name"  
    "Voluntary Policy Number"                                                      
    "Compulsory Policy Number"                                         
    "Engine"                                                           
    "Chassis"                                                          
    "TPIS Contract No."                                                
    "Licence"                                                          
    "Effective Date"                                                   
    "Voluntary Gross Premium"                                          
    "Compulsory Gross Premium"                                         
    "Voluntary Net Premium"                                            
    "Compulsory Net Premium"                                           
    "W/H TAX 1%"                                                       
    "Net Payment"                                                      
    "Status"    
    "Name2"          
    "VatCode"        
    "Producer"       
    "Brand_Model" .  

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_createfile C-Win 
PROCEDURE Pro_createfile :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  Convert file to Send TAS
------------------------------------------------------------------------------*/
DEF VAR numberline1 AS CHAR FORMAT "9999999999"  INIT "" .
DEF VAR numberline  AS INTE INIT 0.
DEF VAR np_cedpol   AS CHAR FORMAT "x(20)" INIT "" .

For each  wdetail :
    DELETE  wdetail.
END.

INPUT FROM VALUE(fi_filename).
REPEAT:
    
    /*IMPORT DELIMITER "|" */
    IMPORT DELIMITER ","
       head          
       insure        
       policy        
       polcomp       
       engine        
       chass         
       contract      
       engc          
       comdat        
       grossprem     
       CompGrossPrem 
       NetPrem       
       CompNetPrem   
       tax           
       NetPayment    
       nSTATUS       
       Name2         
       VatCode .     
                                                                            
    IF (head = "head")OR (head = "H") OR (head = "T") THEN                  
        ASSIGN                                                    
         head           = ""
         insure         = ""
         policy         = ""
         polcomp        = ""
         engine         = ""
         chass          = ""
         contract       = ""
         engc           = ""
         comdat         = ""
         grossprem      = ""
         CompGrossPrem  = ""
         NetPrem        = ""
         CompNetPrem    = ""
         tax            = ""
         NetPayment     = ""
         nSTATUS        = ""
         Name2          = ""
         VatCode        = "" . 

    ELSE DO:

        FIND LAST wdetail WHERE wdetail.engc =  engc NO-ERROR NO-WAIT.
        IF NOT AVAIL wdetail THEN DO:
            CREATE wdetail.
            ASSIGN 
                wdetail.head          = head                                         
                wdetail.insure        = insure 
                wdetail.policy        = policy                                          
                wdetail.polcomp       = polcomp               
                wdetail.engine        = engine                                          
                wdetail.chass         = chass                        
                wdetail.contract      = contract                                        
                wdetail.engc          = engc   
                wdetail.comdat        = comdat            /* 01/01/2017 */
                wdetail.grossprem     = grossprem                  
                wdetail.CompGrossPrem = CompGrossPrem                         
                wdetail.NetPrem       = NetPrem                               
                wdetail.CompNetPrem   = CompNetPrem                           
                wdetail.tax           = tax                                   
                wdetail.NetPayment    = NetPayment    
                wdetail.nSTATUS       = nSTATUS      
                wdetail.Name2         = Name2        
                wdetail.VatCode       = VatCode   . 
        END.

        ASSIGN                     
         head           =  ""                         
         insure         =  ""  
         policy         =  ""                                    
         polcomp        =  ""                
         engine         =  ""                                   
         chass          =  ""                          
         contract       =  ""                     
         engc           =  ""                       
         comdat         =  ""                       
         grossprem      =  ""                      
         CompGrossPrem  =  ""                      
         NetPrem        =  ""                     
         CompNetPrem    =  "" 
         tax            =  "" 
         NetPayment     =  "" 
         nSTATUS        =  ""   
         Name2          =  ""   
         VatCode        =  "" . 
    END.
END.   /* repeat */  

/*
If  SUBSTR(fi_outfile,length(fi_outfile) - 3,4) <>  ".csv"  THEN  fi_outfile  =  Trim(fi_outfile) + ".csv"  . 
*/


OUTPUT  TO VALUE(fi_outfile). 
EXPORT DELIMITER ","                   
        "Customer Name"
        "Voluntary Policy Number"                                                     
        "Compulsory Policy Number"                                        
        "Engine"                                                          
        "Chassis"                                                         
        "TPIS Contract No."                                               
        "Licence"                                                         
        "Effective Date"                                                  
        "Voluntary Gross Premium"                                         
        "Compulsory Gross Premium"                                        
        "Voluntary Net Premium"                                           
        "Compulsory Net Premium"                                          
        "W/H TAX 1%"                                                      
        "Net Payment"                                                     
        "Status" . 

FOR EACH wdetail WHERE wdetail.insure <> "" NO-LOCK.     

    IF  (index(wdetail.insure,"Customer") <> 0) THEN NEXT.
    ELSE DO:
        ASSIGN np_cedpol = ""
            np_policy  = "" 
            np_cedpol = wdetail.contract .

        EXPORT DELIMITER ","              
            wdetail.insure                      
            wdetail.policy          
            wdetail.polcomp         
            wdetail.engine          
            wdetail.chass           
            wdetail.contract        
            wdetail.engc            
            wdetail.comdat          
            wdetail.grossprem       
            wdetail.CompGrossPrem   
            wdetail.NetPrem         
            wdetail.CompNetPrem     
            wdetail.tax             
            wdetail.NetPayment. 
    END.
END.

MESSAGE   "Export File  Complete"  view-as alert-box.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_createfile_Mat C-Win 
PROCEDURE Pro_createfile_Mat :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wdetail : DELETE  wdetail. END.
nv_cnt0 = 0.

INPUT FROM VALUE(fi_filename).
REPEAT:
    
    /*IMPORT DELIMITER "|" */
    IMPORT DELIMITER ","

        head      
        insure
        PolicyMain
        Policy
        PolComp   
        Engine    
        Chass     
        Contract  
        Engc      
        ComDat    
        GrossPrem 
        CompGrossPrem
        NetPrem     
        CompNetPrem 
        Tax         
        NetPayment  
        nSTATUS     
        Name2       
        VatCode  
        Producer    
        Brand_Model  .

    IF (head = "head") OR (head = "H") OR (head = "T") THEN 
        ASSIGN 
        head            =  ""
        insure          =  ""
        policymain      =  ""
        policy          =  ""
        polcomp         =  ""
        engine          =  ""
        chass           =  ""
        contract        =  ""
        engc            =  ""
        comdat          =  ""
        grossprem       =  ""
        CompGrossPrem   =  ""
        NetPrem         =  ""
        CompNetPrem     =  ""
        tax             =  ""
        NetPayment      =  ""
        nSTATUS         =  ""
        Name2           =  ""
        VatCode         =  ""
        Producer        =  ""
        Brand_Model     =  "" .

    ELSE DO:

        FIND LAST wdetail WHERE 
            wdetail.chass           = chass     AND  
            wdetail.contract        = contract  AND
            wdetail.engc            = engc      NO-ERROR NO-WAIT.   /* Add by kridtiya i. A59-0597 เพิ่ม contract */
        IF NOT AVAIL wdetail THEN DO:
            
            CREATE wdetail.
            ASSIGN 
                wdetail.head            = head                                         
                wdetail.insure          = insure   
                wdetail.policymain      = policymain
                wdetail.policy          = policy
                wdetail.polcomp         = polcomp
                wdetail.engine          = engine
                wdetail.chass           = chass
                wdetail.contract        = contract
                wdetail.engc            = engc
                wdetail.comdat          = comdat
                wdetail.grossprem       = grossprem                             
                wdetail.CompGrossPrem   = CompGrossPrem 
                wdetail.NetPrem         = NetPrem
                wdetail.CompNetPrem     = CompNetPrem
                wdetail.tax             = tax
                wdetail.NetPayment      = NetPayment 
                wdetail.nSTATUS         = nSTATUS
                wdetail.Name2           = Name2
                wdetail.VatCode         = VatCode
                wdetail.Producer        = Producer
                wdetail.Brand_Model     = Brand_Model  .  

            nv_cnt0 = nv_cnt0 + 1.
            
        END.

        ASSIGN 
        head            =  ""                                    
        insure          =  ""
        policymain      =  ""
        policy          =  ""                                    
        polcomp         =  ""          
        engine          =  ""                                    
        chass           =  ""                
        contract        =  ""                                   
        engc            =  ""                          
        comdat          =  ""                     
        grossprem       =  ""                       
        CompGrossPrem   =  ""                       
        NetPrem         =  ""                      
        CompNetPrem     =  ""                      
        tax             =  ""                     
        NetPayment      =  ""
        nSTATUS         =  ""
        Name2           =  ""
        VatCode         =  ""   
        Producer        =  "" 
        Brand_Model     =  "" .
    END.
END.   /* repeat */  
RUN Pro_createfile_Mat1.
RUN Pro_createfile_Mat2.
RUN Pro_createfile_Mat3.
RUN Pro_createfile_Mat4.

message "Export File  Complete" SKIP
        "Import Data Total : " nv_cnt0 " เรคคอร์ด " SKIP
        "Export file 1     : " nv_cnt1 " เรคคอร์ด " SKIP 
        "Export file 2     : " nv_cnt2 " เรคคอร์ด " SKIP
        "Export file 3     : " nv_cnt3 " เรคคอร์ด " SKIP
        "Export file 4     : " nv_cnt4 " เรคคอร์ด "   SKIP
    
    view-as alert-box.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_createfile_Mat1 C-Win 
PROCEDURE Pro_createfile_Mat1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
nv_cnt1 = 0.

OUTPUT  TO VALUE(fi_outproducer). 

RUN pd_ExpHead.

FOR EACH wdetail WHERE 
    wdetail.head     = "D" AND 
    wdetail.Producer = fi_producer1 OR wdetail.Producer = fi_producer2 NO-LOCK.   
    
    nv_cnt1 = nv_cnt1 + 1.

    RUN pd_ExpDetail.   
     
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_createfile_Mat2 C-Win 
PROCEDURE Pro_createfile_Mat2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
nv_cnt2 = 0.

OUTPUT  TO VALUE(fi_outcontract1). 

RUN pd_ExpHead.

FOR EACH wdetail WHERE 
    wdetail.head     = "D" AND 
   (wdetail.Producer <> fi_producer1 AND wdetail.Producer <> fi_producer2) AND
    SUBSTRING(wdetail.contract,1,1) = "1" NO-LOCK.   

    nv_cnt2 = nv_cnt2 + 1.

    RUN pd_ExpDetail.
    
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_createfile_Mat3 C-Win 
PROCEDURE Pro_createfile_Mat3 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
nv_cnt3 = 0.

OUTPUT  TO VALUE(fi_outcontract2).

RUN pd_ExpHead.

FOR EACH wdetail WHERE 
    wdetail.head     = "D" AND 
   (wdetail.Producer <> fi_producer1 AND wdetail.Producer <> fi_producer2) AND
    SUBSTRING(wdetail.contract,1,1) = "2" NO-LOCK.  
    
    nv_cnt3 = nv_cnt3 + 1.

    RUN pd_ExpDetail.

END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_createfile_Mat4 C-Win 
PROCEDURE Pro_createfile_Mat4 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
nv_cnt4 = 0.

OUTPUT  TO VALUE(fi_outother). 

RUN pd_ExpHead.

FOR EACH wdetail WHERE 
    wdetail.head     = "D" NO-LOCK.

    IF wdetail.Producer = fi_producer1 OR wdetail.Producer = fi_producer2 THEN NEXT.
    IF SUBSTRING(wdetail.contract,1,1) = "1" OR SUBSTRING(wdetail.contract,1,1) = "2" THEN NEXT.

    nv_cnt4 = nv_cnt4 + 1.
     
    EXPORT DELIMITER "|" 
        wdetail.head
        wdetail.insure 
        wdetail.policy         
        wdetail.polcomp        
        wdetail.engine       
        wdetail.chass        
        wdetail.contract     
        wdetail.engc         
        wdetail.comdat
        wdetail.grossprem
        wdetail.CompGrossPrem
        wdetail.NetPrem
        wdetail.CompNetPrem
        wdetail.tax       
        wdetail.NetPayment
        wdetail.nSTATUS      
        wdetail.Name2            
        wdetail.VatCode    
        wdetail.Producer    
        wdetail.Brand_Model .  
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

