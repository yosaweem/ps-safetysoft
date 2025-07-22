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

  Modify By : TANTAWAN C.   26/01/2008   [A500178]
             ปรับ FORMAT branch เพื่อรองรับการขยายสาขา
ขยาย FORMAT fiacno1 จาก "X(7)" เป็น  Char "X(10)"             
            fiacno2 จาก "X(7)" เป็น  Char "X(10)"   
                      
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

DEF SHARED VAR n_user AS CHAR    .
DEF SHARED VAR n_passwd AS CHAR  .  

Def Var n_name     As Char Format "x(50)". /*acno*/
Def Var n_chkname  As Char format "x(1)".  /*Acno-- chk button 1-2 */
Def Var n_bdes     As Char Format "x(50)". /*branch name*/
Def Var n_chkBname As Char format "x(1)".  /*branch-- chk button 1-2 */
DEF VAR n_poldes   AS CHAR FORMAT "X(35)". /*policy des*/

DEF NEW SHARED VAR n_frdate   AS DATE FORMAT "99/99/9999" .
DEF NEW SHARED VAR n_todate   AS DATE FORMAT "99/99/9999" .
DEF NEW SHARED VAR n_dir_ri   AS logi FORMAT "D/I"  INIT YES .
DEF NEW SHARED VAR n_branch   AS CHAR FORMAT "x(2)".
DEF NEW SHARED VAR n_branch2  AS CHAR FORMAT "x(2)".
DEF NEW SHARED VAR n_poltypfr AS CHAR FORMAT "X(3)" . 
DEF NEW SHARED VAR n_poltypto AS CHAR FORMAT "X(3)" . 
DEF NEW SHARED VAR n_agent1   AS CHAR FORMAT "x(7)".
DEF NEW SHARED VAR n_agent2   AS CHAR FORMAT "x(7)".

DEF VAR chExcelApplication AS COM-HANDLE.
DEF VAR chWorkbook         AS COM-HANDLE.
DEF VAR CWS                AS COM-HANDLE. /* CWS = chWorksheet */
DEF VAR chChart            AS COM-HANDLE.
DEF VAR CWSRange           AS COM-HANDLE.
DEF VAR CR                 AS CHAR. /* CR = CellRange */
DEF VAR nv_row             AS INT. /* Num row */
DEF VAR nv_count           AS INT.
DEF VAR nv_tsum            AS DECI FORMAT ">>>,>>>,>>9.99" INIT "".
DEF VAR nv_tprm            AS DECI FORMAT ">>>,>>>,>>9.99" INIT "".
DEF VAR nv_ttax            AS DECI FORMAT ">>>,>>>,>>9.99" INIT "".
DEF VAR nv_tcom            AS DECI FORMAT ">>>,>>>,>>9.99" INIT "".


DEFINE NEW SHARED TEMP-TABLE wdetail
      FIELD rec_no       AS CHAR FORMAT "x(10)"  INIT ""   /*1*/
      FIELD wcomdat      AS CHAR FORMAT "x(10)"  INIT ""   /*2*/
      FIELD wexpdat      AS CHAR FORMAT "x(10)"  INIT ""   /*3*/
      FIELD wname        AS CHAR FORMAT "x(100)" INIT ""   /*4*/
      FIELD waddr        AS CHAR FORMAT "x(200)" INIT ""   /*5*/
      FIELD wpoltyp      AS CHAR FORMAT "x(50)"  INIT ""   /*7*/
      FIELD wsumin       AS DECI FORMAT ">>>,>>>,>>9.99" INIT ""   /*8*/
      FIELD wprem        AS DECI FORMAT ">>>,>>>,>>9.99" INIT ""   /*9*/
      FIELD wtax         AS DECI FORMAT ">>>,>>>,>>9.99" INIT ""   /*10*/
      FIELD wcomm        AS DECI FORMAT ">>>,>>>,>>9.99" INIT ""   /*13*/
      FIELD wpolsubtyp   AS CHAR FORMAT "x(50)"  INIT ""   /*15*/
      FIELD wremark      AS CHAR FORMAT "x(100)" INIT "".  /*17*/


/***--- data ที่ put ลง Excel ---***/
DEF VAR nv_runno  AS INTE FORMAT ">>9" INIT 0.
DEF VAR nv_poltyp  AS CHAR FORMAT "x(4)" .  /*Policy Type*/
DEF VAR nv_spoltyp AS CHAR FORMAT "x(4)" . /*Policy sub type*/
DEF VAR nv_sum    LIKE uwm120.sigr INIT 0.
DEF VAR n_an      LIKE UWM120.SIGR.
DEF VAR nvexch    LIKE uwm120.siexch.
DEF VAR nv_COM1P  LIKE UWM120.COM1P.
DEF VAR nv_COM2P  LIKE UWM120.COM2P.
DEF VAR nv_COMT   LIKE UWM120.COM2P.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_trnfrm fi_trnto dir_ri1 fiBranch ~
fiBranch2 fiPolTypFr fiPolTypTo fiacno1 fiacno2 bu_ok bu_cancel buBranch ~
buBranch2 buPoltypFr buPoltypTo buAcno1 buAcno2 fiPoldesFr fiPoldesTo ~
RECT-310 RECT-311 RECT-312 RECT-313 RECT-320 
&Scoped-Define DISPLAYED-OBJECTS fi_trnfrm fi_trnto dir_ri1 fiBranch ~
fiBranch2 fiPolTypFr fiPolTypTo fiacno1 fiacno2 fibdes fibdes2 fiPoldesFr ~
fiPoldesTo finame1 finame2 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON buAcno1 
     LABEL "..." 
     SIZE 3 BY .95 TOOLTIP "รหัส Producer"
     FONT 6.

DEFINE BUTTON buAcno2 
     LABEL "..." 
     SIZE 3 BY .95 TOOLTIP "รหัส Producer"
     FONT 6.

DEFINE BUTTON buBranch 
     LABEL "..." 
     SIZE 3 BY .95 TOOLTIP "รหัสสาขา"
     FONT 6.

DEFINE BUTTON buBranch2 
     LABEL "..." 
     SIZE 3 BY .95 TOOLTIP "รหัสสาขา"
     FONT 6.

DEFINE BUTTON buPoltypFr 
     LABEL "..." 
     SIZE 3 BY .95 TOOLTIP "ประเภทกรมธรรม์"
     FONT 6.

DEFINE BUTTON buPoltypTo 
     LABEL "..." 
     SIZE 3 BY .95 TOOLTIP "ประเภทกรมธรรม์"
     FONT 6.

DEFINE BUTTON bu_cancel 
     LABEL "Cancel" 
     SIZE 15 BY 1.14.

DEFINE BUTTON bu_ok 
     LABEL "OK" 
     SIZE 15 BY 1.14.

DEFINE VARIABLE dir_ri1 AS LOGICAL FORMAT "D/I":U INITIAL NO 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiacno1 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiacno2 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fibdes AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 25 BY .95
     BGCOLOR 21 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fibdes2 AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 25 BY .95
     BGCOLOR 21 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fiBranch AS CHARACTER FORMAT "X(2)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiBranch2 AS CHARACTER FORMAT "X(2)":U INITIAL "Z" 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE finame1 AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 45 BY .95
     BGCOLOR 21 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE finame2 AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 45 BY .95
     BGCOLOR 21 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fiPoldesFr AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 40 BY .95
     BGCOLOR 21 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fiPoldesTo AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 40 BY .95
     BGCOLOR 21 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fiPolTypFr AS CHARACTER FORMAT "X(4)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiPolTypTo AS CHARACTER FORMAT "X(4)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_trnfrm AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_trnto AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-310
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 87.5 BY 10.48
     BGCOLOR 15 .

DEFINE RECTANGLE RECT-311
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 84.5 BY 9.52
     BGCOLOR 21 .

DEFINE RECTANGLE RECT-312
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 17 BY 1.67
     BGCOLOR 21 .

DEFINE RECTANGLE RECT-313
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 17 BY 1.67
     BGCOLOR 21 .

DEFINE RECTANGLE RECT-320
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 41.5 BY 1.67
     BGCOLOR 21 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_trnfrm AT ROW 4.81 COL 24 COLON-ALIGNED NO-LABEL
     fi_trnto AT ROW 5.76 COL 24 COLON-ALIGNED NO-LABEL
     dir_ri1 AT ROW 6.71 COL 24 COLON-ALIGNED NO-LABEL
     fiBranch AT ROW 7.67 COL 24 COLON-ALIGNED NO-LABEL
     fiBranch2 AT ROW 8.62 COL 24 COLON-ALIGNED NO-LABEL
     fiPolTypFr AT ROW 9.57 COL 24 COLON-ALIGNED NO-LABEL
     fiPolTypTo AT ROW 10.57 COL 24 COLON-ALIGNED NO-LABEL
     fiacno1 AT ROW 11.52 COL 24 COLON-ALIGNED NO-LABEL
     fiacno2 AT ROW 12.52 COL 24 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 14.86 COL 53
     bu_cancel AT ROW 14.86 COL 70
     buBranch AT ROW 7.67 COL 32
     buBranch2 AT ROW 8.62 COL 32
     buPoltypFr AT ROW 9.57 COL 32
     buPoltypTo AT ROW 10.62 COL 32
     buAcno1 AT ROW 11.48 COL 38
     buAcno2 AT ROW 12.52 COL 38
     fibdes AT ROW 7.62 COL 34.5 COLON-ALIGNED NO-LABEL
     fibdes2 AT ROW 8.57 COL 34.5 COLON-ALIGNED NO-LABEL
     fiPoldesFr AT ROW 9.57 COL 34.5 COLON-ALIGNED NO-LABEL
     fiPoldesTo AT ROW 10.52 COL 34.5 COLON-ALIGNED NO-LABEL
     finame1 AT ROW 11.57 COL 39.5 COLON-ALIGNED NO-LABEL
     finame2 AT ROW 12.52 COL 39.5 COLON-ALIGNED NO-LABEL
     "Policy Type To       :":10 VIEW-AS TEXT
          SIZE 17 BY .95 TOOLTIP "ถึงสาขา" AT ROW 10.52 COL 6
          BGCOLOR 21 
     "Trans. Date To       :" VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 5.76 COL 6
          BGCOLOR 21 
     "Trans. Date From :" VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 4.81 COL 6
          BGCOLOR 21 
     "Branch From           :":30 VIEW-AS TEXT
          SIZE 17 BY .95 TOOLTIP "ตั้งแต่สาขา" AT ROW 7.67 COL 6
          BGCOLOR 21 
     "Branch To              :":10 VIEW-AS TEXT
          SIZE 17 BY .95 TOOLTIP "ถึงสาขา" AT ROW 8.62 COL 6
          BGCOLOR 21 
     "Direct/Inward(D/I)  :" VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 6.71 COL 6
          BGCOLOR 21 
     "Agent Code To      :":20 VIEW-AS TEXT
          SIZE 17 BY .95 TOOLTIP "รหัสตัวแทนถึง" AT ROW 12.43 COL 6
          BGCOLOR 21 
     "Pol. Type From       :":50 VIEW-AS TEXT
          SIZE 17 BY .95 TOOLTIP "ตั้งแต่สาขา" AT ROW 9.57 COL 6
          BGCOLOR 21 
     "    Report Statement for Kiatnakin Bank" VIEW-AS TEXT
          SIZE 39 BY .95 AT ROW 2.1 COL 30.67
          BGCOLOR 15 FGCOLOR 1 FONT 6
     "Agent Code From   :":100 VIEW-AS TEXT
          SIZE 17 BY .95 TOOLTIP "Account No. From" AT ROW 11.48 COL 6
          BGCOLOR 21 
     RECT-310 AT ROW 3.86 COL 3
     RECT-311 AT ROW 4.33 COL 4.5
     RECT-312 AT ROW 14.57 COL 52
     RECT-313 AT ROW 14.57 COL 69.17
     RECT-320 AT ROW 1.71 COL 29.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 91.67 BY 15.95.


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
         HEIGHT             = 15.95
         WIDTH              = 91.67
         MAX-HEIGHT         = 16
         MAX-WIDTH          = 91.67
         VIRTUAL-HEIGHT     = 16
         VIRTUAL-WIDTH      = 91.67
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
   Custom                                                               */
/* SETTINGS FOR FILL-IN fibdes IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fibdes2 IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN finame1 IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN finame2 IN FRAME fr_main
   NO-ENABLE                                                            */
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


&Scoped-define SELF-NAME buAcno1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buAcno1 C-Win
ON CHOOSE OF buAcno1 IN FRAME fr_main /* ... */
DO:
   n_chkname = "1". 
  RUN Whp\WhpAcno(input-output  n_name,input-output n_chkname).
  
  Assign    
        fiacno1 = n_agent1
        finame1 = n_name.
       
  Disp fiacno1 finame1  with Frame fr_main      .
 
 n_agent1 =  fiacno1 .

  Return NO-APPLY.
 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buAcno2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buAcno2 C-Win
ON CHOOSE OF buAcno2 IN FRAME fr_main /* ... */
DO:
  n_chkname = "2". 
  run Whp\WhpAcno(input-output  n_name,input-output n_chkname).
  
  Assign    
        fiacno2 = n_agent2
        finame2 = n_name.
       
  Disp fiacno2 finame2 with Frame fr_main      .
   
  n_agent2 =  fiacno2 .
  
  Return NO-APPLY.
 
 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buBranch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buBranch C-Win
ON CHOOSE OF buBranch IN FRAME fr_main /* ... */
DO:

   n_chkBName = "1". 
  RUN Whp\Whpbran(input-output  n_bdes,input-output n_chkBName).
  
  Assign    
        fibranch = n_branch
        fibdes   = n_bdes.
       
  Disp fibranch fibdes  with Frame fr_main      .
 
 n_branch =  fibranch .

  Return NO-APPLY.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buBranch2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buBranch2 C-Win
ON CHOOSE OF buBranch2 IN FRAME fr_main /* ... */
DO:
   n_chkBName = "2". 
  RUN Whp\Whpbran(input-output  n_bdes,input-output n_chkBName).
  
  Assign    
        fibranch2 = n_branch2
        fibdes2   = n_bdes.
       
  Disp fibranch2 fibdes2  with Frame fr_main      .
 
  n_branch2 =  fibranch2.

  Return NO-APPLY.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buPoltypFr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buPoltypFr C-Win
ON CHOOSE OF buPoltypFr IN FRAME fr_main /* ... */
DO:

  RUN Whp\WhpPolTy(INPUT-OUTPUT  n_poldes).
  
  ASSIGN    
        fipoltypFr = n_poltypfr
        fipoldesFr = n_poldes.
       
  DISP fiPoltypFr fipoldesFr WITH FRAME {&Frame-Name}      .
 
  RETURN NO-APPLY.


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buPoltypTo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buPoltypTo C-Win
ON CHOOSE OF buPoltypTo IN FRAME fr_main /* ... */
DO:

  RUN Whp\WhpPolTy(INPUT-OUTPUT  n_poldes).
  
  ASSIGN    
        fipoltypTo = n_poltypto
        fipoldesTo = n_poldes.
       
  DISP fiPoltypTo fipoldesTo WITH FRAME {&Frame-Name}      .
 
  RETURN NO-APPLY.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_cancel C-Win
ON CHOOSE OF bu_cancel IN FRAME fr_main /* Cancel */
DO:
    APPLY "close"  TO THIS-PROCEDURE.
    RETURN NO-APPLY.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok C-Win
ON CHOOSE OF bu_ok IN FRAME fr_main /* OK */
DO:
    ASSIGN
        n_frdate    = INPUT fi_trnfrm      n_todate    = INPUT fi_trnto
        n_dir_ri    = INPUT DIR_ri1        n_branch    = INPUT fibranch
        n_branch2   = INPUT fibranch2      n_poltypfr  = INPUT fiPolTypFr
        n_poltypto  = INPUT fiPolTypTo     n_agent1    = INPUT fiacno1
        n_agent2    = INPUT fiacno2        nv_runno    = 0
        nv_sum      = 0                    n_an        = 0
        nvexch      = 1                    nv_COM1P    = 0
        nv_COM2P    = 0                    nv_tsum     = 0 
        nv_tprm     = 0                    nv_ttax     = 0
        nv_tcom     = 0.

    FOR EACH wdetail:
        DELETE wdetail.
    END.

    /*RUN proc_check.*/
    RUN proc_head.

    
    FOR EACH uwm100 WHERE (uwm100.trndat >= n_frdate    AND
                           uwm100.trndat <= n_todate)   AND
                           uwm100.dir_ri  = n_dir_ri    AND
                          (uwm100.branch >= n_branch    AND
                           uwm100.branch <= n_branch2)  AND 
                          (uwm100.poltyp >= n_poltypfr  AND
                           uwm100.poltyp <= n_poltypto) AND
                          (uwm100.agent  >= n_agent1    AND
                           uwm100.agent  <= n_agent2)   NO-LOCK
    BREAK BY uwm100.policy
          BY uwm100.rencnt
          BY uwm100.endcnt :

        IF LAST-OF(UWM100.POLICY) AND 
           LAST-OF(UWM100.RENCNT) AND
           LAST-OF(UWM100.ENDCNT) THEN DO:

            /***--- Vaiable ---***/
            ASSIGN
            nvexch      = 1  n_an        = 0
            nv_COM1P    = 0  nv_COM2P    = 0
            nv_sum      = 0
            nv_poltyp   = "" nv_spoltyp  = "" .

            IF uwm100.comdat = ? OR uwm100.name1 = ""  THEN NEXT.
            /*
            IF uwm100.sch_p = NO OR drn_p = NO THEN NEXT.

            IF uwm100.releas = NO THEN NEXT.*/


            /***--- Policy Type ---***/
            IF uwm100.poltyp = "F10" THEN nv_poltyp = "001" . /*อัคคีภัย*/
            ELSE IF SUBSTR(uwm100.poltyp,1,2) = "c9" THEN nv_poltyp = "002" . /*Marine*/
            ELSE IF uwm100.poltyp = "v72" OR  uwm100.poltyp = "v73" OR
                    uwm100.poltyp = "v74" THEN nv_poltyp = "003" . /*Motor Compulsory*/
            ELSE IF uwm100.poltyp = "V70" THEN nv_poltyp = "004" . /*Motor Voluntory*/
            ELSE  nv_poltyp = "005".

            /***--- Policy Sub Type ---***/
                  /***--- Motor ---***/
                  IF nv_poltyp = "004" THEN DO:
                      FIND LAST uwm301 WHERE uwm301.policy = uwm100.policy NO-LOCK NO-ERROR NO-WAIT.
                      IF AVAIL uwm301 THEN DO:
                          IF uwm301.covcod = "1" THEN nv_spoltyp = "01".
                          ELSE IF uwm301.covcod = "2" THEN nv_spoltyp = "02".
                          ELSE IF uwm301.covcod = "3" THEN nv_spoltyp = "03".
                          ELSE IF uwm301.covcod = "4" THEN nv_spoltyp = "04".
                      END.
                  END.
                  /***--- เบ็ดเตล็ด ---***/
                  ELSE IF nv_poltyp = "005" THEN DO:
                      IF uwm100.poltyp = "M11" THEN nv_spoltyp = "01".      /*IAR*/
                      ELSE IF uwm100.poltyp = "M80" THEN nv_spoltyp = "02". /*CAR*/
                      ELSE IF uwm100.poltyp = "M81" THEN nv_spoltyp = "03". /*EAR*/
                      ELSE IF uwm100.poltyp = "M60" OR   uwm100.poltyp = "64"  THEN nv_spoltyp = "04". /*PA*/
                      ELSE IF uwm100.poltyp = "M68" THEN nv_spoltyp = "05". /*TA*/
                      ELSE DO:
                          nv_spoltyp = "06". /*orther*/
                      END.
                  END.
                  ELSE DO:
                        /***--- Policy Type อื่น ---***/
                        nv_spoltyp = "00".
                  END.



            /***---Sum insure for motor จากโปรแกรม Uzs001(01.05.10.01) ---***/
            /***--- Motor part ---***/
            IF uwm100.poltyp = "V70" OR uwm100.poltyp = "V72" OR
               uwm100.poltyp = "V73" OR uwm100.poltyp = "V74" THEN DO:

                                  FIND FIRST uwm130 USE-INDEX uwm13001   WHERE
                                             uwm130.policy = uwm100.policy AND
                                             uwm130.rencnt = uwm100.rencnt AND
                                             uwm130.endcnt = 000
                                  NO-LOCK NO-ERROR.
                                  REPEAT WHILE avail uwm130:
                                       IF    uwm100.poltyp  = "V70"  THEN
                                             nv_sum  = nv_sum + uwm130.uom6_v.
                                       ELSE  nv_sum  = nv_sum + uwm130.uom9_v.
                                       FIND NEXT uwm130 USE-INDEX uwm13001   WHERE
                                                 uwm130.policy = uwm100.policy AND
                                                 uwm130.rencnt = uwm100.rencnt AND
                                                 uwm130.endcnt = 000
                                       NO-LOCK NO-ERROR.
                                  END.      
            
                                  FIND FIRST uwm120 USE-INDEX uwm12002 WHERE 
                                             uwm120.policy = uwm100.policy and
                                             uwm120.rencnt = uwm100.rencnt and
                                             uwm120.endcnt = uwm100.endcnt
                                  NO-LOCK NO-ERROR.
                                  IF AVAIL uwm120 THEN DO:
                                     nvexch   = uwm120.siexch.
                                     nv_com1p = uwm120.com1_r.
                                     nv_com2p = uwm120.com2_r.
                                  END.

                                  n_an = nv_sum * nvexch.
                                  /*
                                  DISP nv_sum  n_an nvexch  nv_COM1P nv_COM2P. 
                                  */
            END. /***--- End Motor ---***/
            ELSE DO:
                /***--- Non-Motor ---***/
                if   uwm100.poltyp   = "M60" OR  uwm100.poltyp = "M61" OR
                     uwm100.poltyp   = "M62" OR  uwm100.poltyp = "M63" OR
                     uwm100.poltyp   = "M64" OR  uwm100.poltyp = "M67"
                
                then do:
                
                    FOR EACH uwm307 USE-INDEX uwm30701 WHERE uwm307.policy = uwm100.policy and
                                                           uwm307.rencnt = uwm100.rencnt and
                                                           uwm307.endcnt = uwm100.endcnt
                                                           NO-LOCK .
                        nv_sum  = nv_sum  + uwm307.mbsi[1].
                    END.
                
                end.
                else do:
                  FOR EACH uwm120 USE-INDEX uwm12001 WHERE uwm120.policy = uwm100.policy and
                                                           uwm120.rencnt = uwm100.rencnt and
                                                           uwm120.endcnt = uwm100.endcnt
                                                           NO-LOCK .
                
                     IF AVAIL uwm120 THEN  DO:
                        nv_sum  = nv_sum + (uwm120.sigr - uwm120.sico).
                     END.
                
                  END.
                end.
                
                FIND FIRST uwm120 USE-INDEX uwm12002 WHERE uwm120.policy = uwm100.policy and
                                                         uwm120.rencnt = uwm100.rencnt and
                                                         uwm120.endcnt = uwm100.endcnt
                                                         NO-LOCK NO-ERROR.
                IF AVAIL uwm120 THEN DO:
                 IF SUBSTRING(uwm120.policy,3,2) = "90" THEN nvexch = 1.
                 ELSE nvexch = uwm120.siexch.
                 nv_com1p = uwm120.com1_r.
                END.
                
                n_an =  nv_sum * nvexch.
                /***--- End Non-Motor ---***/
            END.

            nv_comt = nv_com1p + nv_com2p.
            

            IF uwm100.poltyp = "v72" or 
               uwm100.poltyp = "v73" or 
               uwm100.poltyp = "v74" THEN n_an = 0.

            

            /***---
            DISP   "Record : " nv_runno "  Policy : " STRING(uwm100.policy,"x-x-xx-xx/xxxxxx")   SKIP 
                   "Insure : " uwm100.name1 
            WITH COLOR white/green NO-LABEL FRAME frProcess VIEW-AS DIALOG-BOX
            TITLE  "  Processing ...".      
            PAUSE 0.
            ---***/
            ASSIGN
            nv_runno = nv_runno + 1
            nv_tsum  = nv_tsum + n_an                          
            nv_tprm  = nv_tprm + uwm100.prem_t                 
            nv_ttax  = nv_ttax + uwm100.rstp_t + uwm100.rtax_t 
            nv_tcom  = nv_tcom + nv_comt.
            
            CREATE WDETAIL.
            ASSIGN
                rec_no     = uwm100.policy
                wcomdat    = STRING(YEAR(uwm100.comdat),"9999") +
                             STRING(MONTH(uwm100.comdat),"99")  +
                             STRING(DAY(uwm100.comdat),"99")
                wexpdat    = STRING(YEAR(uwm100.expdat),"9999") +
                             STRING(MONTH(uwm100.expdat),"99")  +
                             STRING(DAY(uwm100.expdat),"99")      
                wname      = uwm100.ntitle + " " +
                             uwm100.name1  + " " +
                             uwm100.name2  
                waddr      = uwm100.addr1 + " " + uwm100.addr2 + " " +
                             uwm100.addr3 + " " + uwm100.addr4   
                wpoltyp    = nv_poltyp 
                wsumin     = n_an
                wprem      = uwm100.prem_t
                wtax       = uwm100.rstp_t + uwm100.rtax_t
                wcomm      = nv_comt
                wpolsubtyp = nv_spoltyp
                wremark    = "".

        END.

        


    END.

    RUN proc_detail.
    RUN proc_end.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME dir_ri1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL dir_ri1 C-Win
ON LEAVE OF dir_ri1 IN FRAME fr_main
DO:
    n_dir_ri = INPUT DIR_ri1.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL dir_ri1 C-Win
ON RETURN OF dir_ri1 IN FRAME fr_main
DO:
  dir_ri1 = INPUT DIR_ri1.
  APPLY "entry" TO fibranch.
  RETURN NO-APPLY.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiacno1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiacno1 C-Win
ON LEAVE OF fiacno1 IN FRAME fr_main
DO:
    Assign
        fiacno1 = input fiacno1
        n_agent1  = fiacno1.
    
    DISP CAPS(fiacno1) @ fiacno1 WITH FRAME fr_main.
    IF  fiacno1  = "0000000"  OR FIACNO1 = "A000000" THEN DO :
        finame1:Screen-value IN FRAME fr_main = "Default Value From". 
    END.
    ELSE DO: 
    
        IF Input  FiAcno1 <> "" Then Do :        
            FIND   xmm600 WHERE xmm600.acno = n_agent1  NO-ERROR.
            IF AVAILABLE xmm600 THEN DO:
                  finame1:Screen-value IN FRAME fr_main = xmm600.name.
                  DISP CAPS (fiAcno1) @ fiAcno2 WITH FRAME fr_main.
                  APPLY "entry" TO fiacno2.
                  RETURN NO-APPLY.         
            END.        
            ELSE DO:
                  fiAcno1 = "".
                  finame1:Screen-value IN FRAME fr_main = "Not Found !".
                  MESSAGE "ไม่พบข้อมูล" VIEW-AS ALERT-BOX  warning TITLE "Confirm" .
            END.
        End.    
    END.
    DISP CAPS (fiAcno1) @ fiAcno1 WITH FRAME fr_main.
    DISP CAPS (fiAcno1) @ fiAcno2 WITH FRAME fr_main.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiacno1 C-Win
ON RETURN OF fiacno1 IN FRAME fr_main
DO:
    Assign
        fiacno1 = input fiacno1
        n_agent1  = fiacno1.
    
    DISP CAPS(fiacno1) @ fiacno1 WITH FRAME fr_main.
    IF  fiacno1  = "0000000"  OR FIACNO1 = "A000000" THEN DO :
        finame1:Screen-value IN FRAME fr_main = "Default Value From". 
    END.
    ELSE DO: 
    
        IF Input  FiAcno1 <> "" Then Do :        
            FIND   xmm600 WHERE xmm600.acno = n_agent1  NO-ERROR.
            IF AVAILABLE xmm600 THEN DO:
                  finame1:Screen-value IN FRAME fr_main = xmm600.name.
                  DISP CAPS (fiAcno1) @ fiAcno2 WITH FRAME fr_main.
                  APPLY "entry" TO fiacno2.
                  RETURN NO-APPLY.         
            END.        
            ELSE DO:
                  fiAcno1 = "".
                  finame1:Screen-value IN FRAME fr_main = "Not Found !".
                  MESSAGE "ไม่พบข้อมูล" VIEW-AS ALERT-BOX  warning TITLE "Confirm" .
            END.
        End.    
    END.
    DISP CAPS (fiAcno1) @ fiAcno1 WITH FRAME fr_main.
    DISP CAPS (fiAcno1) @ fiAcno2 WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiacno2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiacno2 C-Win
ON LEAVE OF fiacno2 IN FRAME fr_main
DO:
    Assign
        fiacno2 = input fiacno2
        n_agent2  = fiacno2.

    DISP CAPS(fiacno2) @ fiacno2 WITH FRAME fr_main.        

    IF fiacno2 < fiacno1 THEN DO:
        MESSAGE "Agent Code To: Can't Less Than Agent Code From:" VIEW-AS ALERT-BOX.


    END.

    IF fiacno2 <> "B999999" THEN DO:
        IF Input  FiAcno2 <> "" Then Do :        
            FIND   xmm600 WHERE xmm600.acno = n_agent2  NO-ERROR.
            IF AVAILABLE xmm600 THEN DO:
                  finame2:Screen-value IN FRAME {&FRAME-NAME} = xmm600.name.
                  APPLY "entry" TO bu_ok .
                  RETURN NO-APPLY.
            END.        
            ELSE DO:
                  fiAcno2 = "".
                  finame2:Screen-value IN FRAME {&FRAME-NAME} = "Not Found !".
                  MESSAGE "ไม่พบข้อมูล" VIEW-AS ALERT-BOX  warning TITLE "Confirm" .
            END.
        END.
    END.
    ELSE finame2:Screen-value IN FRAME fr_main = "Default Value To". 

    

    DISP CAPS (fiAcno2) @ fiAcno2 WITH FRAME fr_main.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiacno2 C-Win
ON RETURN OF fiacno2 IN FRAME fr_main
DO:
    Assign
        fiacno2 = input fiacno2
        n_agent2  = fiacno2.

    DISP CAPS(fiacno2) @ fiacno2 WITH FRAME fr_main.        

    IF fiacno2 < fiacno1 THEN DO:
        MESSAGE "Agent Code To: Can't Less Than Agent Code From:" VIEW-AS ALERT-BOX.


    END.

    IF fiacno2 <> "B999999" THEN DO:
        IF Input  FiAcno2 <> "" Then Do :        
            FIND   xmm600 WHERE xmm600.acno = n_agent2  NO-ERROR.
            IF AVAILABLE xmm600 THEN DO:
                  finame2:Screen-value IN FRAME {&FRAME-NAME} = xmm600.name.
                  APPLY "entry" TO bu_ok .
                  RETURN NO-APPLY.
            END.        
            ELSE DO:
                  fiAcno2 = "".
                  finame2:Screen-value IN FRAME {&FRAME-NAME} = "Not Found !".
                  MESSAGE "ไม่พบข้อมูล" VIEW-AS ALERT-BOX  warning TITLE "Confirm" .
            END.
        END.
    END.
    ELSE finame2:Screen-value IN FRAME fr_main = "Default Value To". 

    

    DISP CAPS (fiAcno2) @ fiAcno2 WITH FRAME fr_main.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiBranch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBranch C-Win
ON LEAVE OF fiBranch IN FRAME fr_main
DO:
    IF INPUT fibranch = ""  THEN DO:
        MESSAGE "Branch from Can't be null".
        fibranch = "0".
        DISP fibranch WITH FRAME fr_main.
    END.
    ASSIGN
         fibranch = input fibranch
         n_branch = CAPS(fibranch)
         fibranch = n_branch.
    DISP n_branch @ fibranch WITH FRAME fr_main.
    Assign
    fibranch = input fibranch
    n_branch  = fibranch.
  
    FIND   xmm023 WHERE xmm023.branch = n_branch  NO-ERROR.
  IF AVAILABLE xmm023 THEN DO:
          fibdes:Screen-value IN FRAME {&FRAME-NAME} = xmm023.bdes.
          APPLY "entry" TO fiBranch2.
          RETURN NO-APPLY.         
  END.        
  ELSE DO:
          fibdes:Screen-value IN FRAME {&FRAME-NAME} = "Not Found !".
          MESSAGE "ไม่พบข้อมูล" VIEW-AS ALERT-BOX  warning TITLE "Confirm" .
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBranch C-Win
ON RETURN OF fiBranch IN FRAME fr_main
DO:
    IF INPUT fibranch = ""  THEN DO:
        MESSAGE "Branch from Can't be null".
        fibranch = "0".
        DISP fibranch WITH FRAME fr_main.
    END.
    ASSIGN
         fibranch = input fibranch
         n_branch = CAPS(fibranch)
         fibranch = n_branch.
    DISP n_branch @ fibranch WITH FRAME fr_main.
    Assign
    fibranch = input fibranch
    n_branch  = fibranch.
  
    FIND   xmm023 WHERE xmm023.branch = n_branch  NO-ERROR.
  IF AVAILABLE xmm023 THEN DO:
          fibdes:Screen-value IN FRAME {&FRAME-NAME} = xmm023.bdes.
          APPLY "entry" TO fiBranch2.
          RETURN NO-APPLY.         
  END.        
  ELSE DO:
          fibdes:Screen-value IN FRAME {&FRAME-NAME} = "Not Found !".
          MESSAGE "ไม่พบข้อมูล" VIEW-AS ALERT-BOX  warning TITLE "Confirm" .
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiBranch2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBranch2 C-Win
ON LEAVE OF fiBranch2 IN FRAME fr_main
DO:
     ASSIGN
         fibranch2 = input fibranch2
         n_branch2 = CAPS(fibranch2).
         
    DISP n_branch2 @ fibranch2 WITH FRAME fr_main.
    Assign
  fibranch2 = input fibranch2
  n_branch2 = fibranch2.
  
    FIND   xmm023 WHERE xmm023.branch = n_branch2  NO-ERROR.
  IF AVAILABLE xmm023 THEN DO:
          fibdes2:Screen-value IN FRAME {&FRAME-NAME} = xmm023.bdes.
          APPLY "entry" TO fipoltypFr.
          RETURN NO-APPLY.         
  END.        
  ELSE DO:
          fibdes2:Screen-value IN FRAME {&FRAME-NAME} = "Not Found !".
          MESSAGE "ไม่พบข้อมูล" VIEW-AS ALERT-BOX  warning TITLE "Confirm" .
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBranch2 C-Win
ON RETURN OF fiBranch2 IN FRAME fr_main
DO:
     ASSIGN
         fibranch2 = input fibranch2
         n_branch2 = CAPS(fibranch2).
         
    DISP n_branch2 @ fibranch2 WITH FRAME fr_main.
    Assign
  fibranch2 = input fibranch2
  n_branch2 = fibranch2.
  
    FIND   xmm023 WHERE xmm023.branch = n_branch2  NO-ERROR.
  IF AVAILABLE xmm023 THEN DO:
          fibdes2:Screen-value IN FRAME {&FRAME-NAME} = xmm023.bdes.
          APPLY "entry" TO fipoltypFr.
          RETURN NO-APPLY.         

  END.        
  ELSE DO:
          fibdes2:Screen-value IN FRAME {&FRAME-NAME} = "Not Found !".
          MESSAGE "ไม่พบข้อมูล" VIEW-AS ALERT-BOX  warning TITLE "Confirm" .
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiPolTypFr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiPolTypFr C-Win
ON LEAVE OF fiPolTypFr IN FRAME fr_main
DO:

    ASSIGN
        fiPolTypFr = INPUT fiPolTypFr
        n_poltypfr  = CAPS(fiPolTypFr).
        
    DISP 
        n_poltypfr @ fiPoltypFr
        n_poltypto @ fiPolTypTo WITH FRAME fr_main.
   
    IF n_PolTypfr <> ""  THEN DO :
        FIND   xmm031 WHERE xmm031.poltyp = n_poltypfr  NO-ERROR.
        IF AVAILABLE xmm031 THEN DO:
              fipoldesFr:Screen-value IN FRAME {&FRAME-NAME} = xmm031.poldes.
              n_poltypto = n_poltypfr.
              DISP n_poltypto @ fiPolTypTo WITH FRAME fr_main.
        END.        
        ELSE DO:
              fipoldesFr:Screen-value IN FRAME {&FRAME-NAME} = "Not Found !".
              MESSAGE "ไม่พบข้อมูล" VIEW-AS ALERT-BOX  warning TITLE "Confirm" .
        END.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiPolTypFr C-Win
ON RETURN OF fiPolTypFr IN FRAME fr_main
DO:
    ASSIGN
        fiPolTypFr = INPUT fiPolTypFr
        n_poltypfr  = CAPS(fiPolTypFr).
        
    DISP 
        n_poltypfr @ fiPoltypFr
        n_poltypto @ fiPolTypTo WITH FRAME fr_main.
   
    IF n_PolTypfr <> ""  THEN DO :
        FIND   xmm031 WHERE xmm031.poltyp = n_poltypfr  NO-ERROR.
        IF AVAILABLE xmm031 THEN DO:
              fipoldesFr:Screen-value IN FRAME {&FRAME-NAME} = xmm031.poldes.
              n_poltypto = n_poltypfr.
              DISP n_poltypto @ fiPolTypTo WITH FRAME fr_main.
              APPLY "entry" TO fipoltypto.
              RETURN NO-APPLY.
        END.        
        ELSE DO:
              fipoldesFr:Screen-value IN FRAME {&FRAME-NAME} = "Not Found !".
              MESSAGE "ไม่พบข้อมูล" VIEW-AS ALERT-BOX  warning TITLE "Confirm" .
        END.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiPolTypTo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiPolTypTo C-Win
ON LEAVE OF fiPolTypTo IN FRAME fr_main
DO:

    ASSIGN
        fiPolTypTo = INPUT fiPolTypTo
        n_poltypto   = CAPS(fiPolTypTo).
        
    DISP 
        n_poltypto @ fiPoltypTo  WITH FRAME fr_main. 
   
    IF n_PolTypto <> ""  THEN DO :
        IF n_PolTypto < n_PolTypfr THEN DO:
            MESSAGE "Polcy Type To: Can't Less Than Policy Type From" VIEW-AS ALERT-BOX.
            APPLY "entry" TO fiPoltypTo.
            RETURN NO-APPLY.
        END.

        FIND   xmm031 WHERE xmm031.poltyp = n_poltypto  NO-ERROR.
        IF AVAILABLE xmm031 THEN DO:
              fipoldesTo:Screen-value IN FRAME {&FRAME-NAME} = xmm031.poldes.
              APPLY "entry" TO fiacno1.
              RETURN NO-APPLY.              
        END.        
        ELSE DO:
              fipoldesTo:Screen-value IN FRAME {&FRAME-NAME} = "Not Found !".
              MESSAGE "ไม่พบข้อมูล" VIEW-AS ALERT-BOX  warning TITLE "Confirm" .
        END.
    END.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiPolTypTo C-Win
ON RETURN OF fiPolTypTo IN FRAME fr_main
DO:
    ASSIGN
        fiPolTypTo = INPUT fiPolTypTo
        n_poltypto   = CAPS(fiPolTypTo).
        
    DISP 
        n_poltypto @ fiPoltypTo  WITH FRAME fr_main. 
   
    IF n_PolTypto <> ""  THEN DO :
        IF n_PolTypto < n_PolTypfr THEN DO:
            MESSAGE "Polcy Type To: Can't Less Than Policy Type From" VIEW-AS ALERT-BOX.
            APPLY "entry" TO fiPoltypTo.
            RETURN NO-APPLY.
        END.

        FIND   xmm031 WHERE xmm031.poltyp = n_poltypto  NO-ERROR.
        IF AVAILABLE xmm031 THEN DO:
              fipoldesTo:Screen-value IN FRAME {&FRAME-NAME} = xmm031.poldes.
              APPLY "entry" TO fiacno1.
              RETURN NO-APPLY.         
        END.        
        ELSE DO:
              fipoldesTo:Screen-value IN FRAME {&FRAME-NAME} = "Not Found !".
              MESSAGE "ไม่พบข้อมูล" VIEW-AS ALERT-BOX  warning TITLE "Confirm" .
        END.
    END.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_trnfrm
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_trnfrm C-Win
ON LEAVE OF fi_trnfrm IN FRAME fr_main
DO:
  IF  INPUT fi_trnfrm  = ?  THEN DO:
             MESSAGE " From date can not empty. ".
             APPLY "entry" TO fi_trnfrm.
  END.
  ELSE DO:
        fi_trnto = INPUT fi_trnfrm.
        DISP fi_trnto WITH FRAME fr_main.
        APPLY "entry" TO fi_trnto.
        RETURN NO-APPLY.
  END.

  n_frdate  = INPUT fi_trnfrm.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_trnfrm C-Win
ON RETURN OF fi_trnfrm IN FRAME fr_main
DO:
  IF  INPUT fi_trnfrm  = ?  THEN DO:
             MESSAGE " From date can not empty. ".
             APPLY "entry" TO fi_trnfrm.
  END.
  ELSE DO:
        fi_trnto = INPUT fi_trnfrm.
        DISP fi_trnto WITH FRAME fr_main.
        APPLY "entry" TO fi_trnto.
        RETURN NO-APPLY.
  END.

  n_frdate  = INPUT fi_trnfrm.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_trnto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_trnto C-Win
ON LEAVE OF fi_trnto IN FRAME fr_main
DO:
  IF  INPUT fi_trnto  = ?  THEN DO:             
             MESSAGE " To date can not empty. ".             
              APPLY "entry" TO fi_trnto.
              RETURN NO-APPLY.
  END.

  
  n_todate  = INPUT fi_trnto.
  IF n_todate < n_frdate THEN DO:
             MESSAGE " To date must be greater than from date. ".             
             APPLY "entry" TO fi_trnto.
             RETURN NO-APPLY.
  END.
         
    APPLY "entry" TO DIR_ri1.
    RETURN NO-APPLY.
 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_trnto C-Win
ON RETURN OF fi_trnto IN FRAME fr_main
DO:
    IF  INPUT fi_trnto  = ?  THEN DO:             
               MESSAGE " To date can not empty. ".             
                APPLY "entry" TO fi_trnto.
                RETURN NO-APPLY.
    END.


    n_todate  = INPUT fi_trnto.
    IF n_todate < n_frdate THEN DO:
               MESSAGE " To date must be greater than from date. ".             
               APPLY "entry" TO fi_trnto.
               RETURN NO-APPLY.
    END.

    APPLY "entry" TO DIR_ri1.
    RETURN NO-APPLY.


  
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

  /***--- Shukiat T. 22/10/2007 ---***/

/********************  T I T L E   F O R  C - W I N  ****************/
  DEF  VAR  gv_prgid   AS   CHAR.
  DEF  VAR  gv_prog    AS   CHAR.
  
  gv_prgid = "Wackiat".
  gv_prog  = "Report Statement for Kiatnakon Bank".
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).

  Run Wut\WutDiCen(C-win:handle).
   Session:Data-Entry-Return  = Yes. 
  ASSIGN
  fi_trnfrm = TODAY
  fi_trnto  = TODAY
  DIR_ri1   = YES
  n_dir_ri  = YES    .
  DISP fi_trnfrm fi_trnto DIR_ri1 WITH FRAME fr_main.

  /***--- End Shukiat T. 22/10/2007 ---***/

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
  DISPLAY fi_trnfrm fi_trnto dir_ri1 fiBranch fiBranch2 fiPolTypFr fiPolTypTo 
          fiacno1 fiacno2 fibdes fibdes2 fiPoldesFr fiPoldesTo finame1 finame2 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_trnfrm fi_trnto dir_ri1 fiBranch fiBranch2 fiPolTypFr fiPolTypTo 
         fiacno1 fiacno2 bu_ok bu_cancel buBranch buBranch2 buPoltypFr 
         buPoltypTo buAcno1 buAcno2 fiPoldesFr fiPoldesTo RECT-310 RECT-311 
         RECT-312 RECT-313 RECT-320 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_Detail C-Win 
PROCEDURE Proc_Detail :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wdetail:

        nv_row = nv_row + 1. 
        
        CR = "A" + STRING(nv_row).
        CWS:Range(CR):Value = wdetail.rec_no.
        CWS:Range(CR):Borders:Item(7):Weight  = 2 .
        
        CR = "B" + STRING(nv_row).
        CWS:Range(CR):Value = wdetail.wcomdat.
        CWS:Range(CR):NumberFormat = "general".
        
        CR = "C" + STRING(nv_row).
        CWS:Range(CR):Value = wdetail.wexpdat.
        CWS:Range(CR):NumberFormat = "general".
        
        CR = "D" + STRING(nv_row).
        CWS:Range(CR):Value = wdetail.wname.
        
        
        CR = "E" + STRING(nv_row).
        CWS:Range(CR):Value = wdetail.waddr.
        
        
        CR = "F" + STRING(nv_row).
        CWS:Range(CR):Value = "002".  /*Company name (safety)*/
        CWS:Range(CR):NumberFormat = "000".

        CR = "G" + STRING(nv_row).
        CWS:Range(CR):Value = wdetail.wpoltyp.
        CWS:Range(CR):NumberFormat = "000".
        
        CR = "H" + STRING(nv_row).
        CWS:Range(CR):Value = wdetail.wsumin.
        CWS:Range(CR):NumberFormat = "###,###,###,##0.00 ; -###,###,###,##0.00".
        
        CR = "I" + STRING(nv_row).
        CWS:Range(CR):Value = wdetail.wprem.
        CWS:Range(CR):NumberFormat = "###,###,###,##0.00;-###,###,###,##0.00".
        
        CR = "J" + STRING(nv_row).
        CWS:Range(CR):Value = wdetail.wtax.
        CWS:Range(CR):NumberFormat = "###,###,###,##0.00;-###,###,###,##0.00".
        
        CR = "M" + STRING(nv_row).
        CWS:Range(CR):Value = wdetail.wcomm.
        CWS:Range(CR):NumberFormat = "###,###,###,##0.00;-###,###,###,##0.00".
        
        CR = "O" + STRING(nv_row).
        CWS:Range(CR):Value = wdetail.wpolsubtyp.
        CWS:Range(CR):HorizontalAlignment = 3.
        CWS:Range(CR):NumberFormat = "000".
        
        CR = "A" + STRING(nv_row) + ":S" + STRING(nv_row).
        CWS:Range(CR):Borders:Item(8):Weight = 2 .


END. /*wdetail*/
/*
CR = "G"+ STRING(nv_row) + ":G" + STRING(nv_row + 1).
CWS:Range(CR):MergeCells = TRUE. CWS:Range(CR):Value = "ประเภทของสัญญาประกันภัย".
CWS:Range(CR):HorizontalAlignment = 3.
CWS:Range(CR):Borders:Item(9):Weight = 2  .
CWS:Range(CR):Borders:Item(10):Weight = 2  .
*/

CR = "A" + STRING(nv_row) + ":S" + STRING(nv_row).
CWS:Range(CR):Borders:Item(9):Weight = 2 .

nv_row = nv_row + 1. 

CR = "A" + STRING(nv_row).
CWS:Range(CR):Value = "รวมจำนวนกรมธรรม์".
CWS:Range(CR):HorizontalAlignment = 3.
CWS:Range(CR):Borders:Item(7):Weight = 2 .

CR = "B" + STRING(nv_row).
CWS:Range(CR):Value = nv_runno.
CWS:Range(CR):HorizontalAlignment = 3.
CWS:Range(CR):Borders:Item(7):Weight = 2 .
CWS:Range(CR):Borders:Item(10):Weight = 2 .

CR = "C" + STRING(nv_row).
CWS:Range(CR):Value = "ฉบับ".
CWS:Range(CR):HorizontalAlignment = 3.
CWS:Range(CR):Borders:Item(10):Weight = 2 .

CR = "H" + STRING(nv_row). /*Grand SumInsure*/
CWS:Range(CR):Value = nv_tsum. 
CWS:Range(CR):HorizontalAlignment = 4.
CWS:Range(CR):NumberFormat = "###,###,###,##0.00;-###,###,###,##0.00".
CWS:Range(CR):Borders:Item(10):Weight = 2 .

CR = "I" + STRING(nv_row). /*Grand premium*/
CWS:Range(CR):Value = nv_tprm. 
CWS:Range(CR):HorizontalAlignment = 4.
CWS:Range(CR):NumberFormat = "###,###,###,##0.00;-###,###,###,##0.00".
CWS:Range(CR):Borders:Item(10):Weight = 2 .
 
CR = "J" + STRING(nv_row). /*Grand tax + Stamp*/
CWS:Range(CR):Value = nv_ttax. 
CWS:Range(CR):HorizontalAlignment = 4.
CWS:Range(CR):NumberFormat = "###,###,###,##0.00;-###,###,###,##0.00".
CWS:Range(CR):Borders:Item(10):Weight = 2 .

CR = "M" + STRING(nv_row). /*Grand Commission*/
CWS:Range(CR):Value = nv_tcom .
CWS:Range(CR):HorizontalAlignment = 4.
CWS:Range(CR):NumberFormat = "###,###,###,##0.00;-###,###,###,##0.00".
CWS:Range(CR):Borders:Item(10):Weight = 2 .


/***--- ตีเส้น ---***/
CR = "A" + STRING(8) + ":A" + STRING(nv_row).
CWS:Range(CR):Borders:Item(10):Weight = 2  .

CR = "B" + STRING(8) + ":B" + STRING(nv_row).
CWS:Range(CR):Borders:Item(10):Weight = 2  .

CR = "C" + STRING(8) + ":C" + STRING(nv_row).
CWS:Range(CR):Borders:Item(10):Weight = 2  .

CR = "D" + STRING(8) + ":D" + STRING(nv_row).
CWS:Range(CR):Borders:Item(10):Weight = 2  .

CR = "E" + STRING(8) + ":E" + STRING(nv_row).
CWS:Range(CR):Borders:Item(10):Weight = 2  .

CR = "F" + STRING(8) + ":F" + STRING(nv_row).
CWS:Range(CR):Borders:Item(10):Weight = 2  .

CR = "G" + STRING(8) + ":G" + STRING(nv_row).
CWS:Range(CR):Borders:Item(10):Weight = 2  .

CR = "H" + STRING(8) + ":H" + STRING(nv_row).
CWS:Range(CR):Borders:Item(10):Weight = 2  .

CR = "I" + STRING(8) + ":I" + STRING(nv_row).
CWS:Range(CR):Borders:Item(10):Weight = 2  .

CR = "J" + STRING(8) + ":J" + STRING(nv_row).
CWS:Range(CR):Borders:Item(10):Weight = 2  .

CR = "K" + STRING(8) + ":K" + STRING(nv_row).
CWS:Range(CR):Borders:Item(10):Weight = 2  .

CR = "L" + STRING(8) + ":L" + STRING(nv_row).
CWS:Range(CR):Borders:Item(10):Weight = 2  .

CR = "M" + STRING(8) + ":M" + STRING(nv_row).
CWS:Range(CR):Borders:Item(10):Weight = 2  .

CR = "N" + STRING(8) + ":N" + STRING(nv_row).
CWS:Range(CR):Borders:Item(10):Weight = 2  .

CR = "O" + STRING(8) + ":O" + STRING(nv_row).
CWS:Range(CR):Borders:Item(10):Weight = 2  .

CR = "P" + STRING(8) + ":P" + STRING(nv_row).
CWS:Range(CR):Borders:Item(10):Weight = 2  .

CR = "Q" + STRING(8) + ":Q" + STRING(nv_row).
CWS:Range(CR):Borders:Item(10):Weight = 2  .

CR = "R" + STRING(8) + ":R" + STRING(nv_row).
CWS:Range(CR):Borders:Item(10):Weight = 2  .

CR = "S" + STRING(8) + ":S" + STRING(nv_row).
CWS:Range(CR):Borders:Item(10):Weight = 2  .







END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_End C-Win 
PROCEDURE Proc_End :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

/*** Start ส่วนล่าง ---***/
/*
CR = "A1" + ":F" + STRING(nv_row).
CWS:Range(CR):VerticalAlignment = 1.
CWS:Range(CR):Font:Name = "CORDIAUPC".
CWS:Range(CR):FONT:SIZE = 16.
CR = "E3" + ":F" + STRING(nv_row).
CWS:Range(CR):NumberFormat = "#,##0.00".
*/

nv_row = nv_row + 1.
CR = "A" + STRING(nv_row) + ":S" + STRING(nv_row).
CWS:Range(CR):Borders:Item(8):Weight = 2 .

RELEASE OBJECT chExcelApplication.      
RELEASE OBJECT chWorkbook.
RELEASE OBJECT CWS.

MESSAGE "Mission Complete" VIEW-AS ALERT-BOX.



END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_Head C-Win 
PROCEDURE Proc_Head :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/***--- START HEAD ---***/
CREATE "Excel.Application" chExcelApplication.
chExcelApplication:Visible = TRUE.
chWorkbook = chExcelApplication:Workbooks:Add(). 
CWS = chExcelApplication:Sheets:Item(1).

CWS:PageSetup:LeftMargin = 30 .
CWS:PageSetup:RightMargin = 30 .
CWS:PageSetup:TopMargin = 50 .
CWS:PageSetup:BottomMargin = 50 .


CWS:Columns("A"):ColumnWidth = 16.   
CWS:Columns("B"):ColumnWidth = 10.
CWS:Columns("C"):ColumnWidth = 10.
CWS:Columns("D"):ColumnWidth = 21.
CWS:Columns("E"):ColumnWidth = 25.
CWS:Columns("F"):ColumnWidth = 25.
CWS:Columns("G"):ColumnWidth = 23.
CWS:Columns("H"):ColumnWidth = 23.
CWS:Columns("I"):ColumnWidth = 16.
CWS:Columns("J"):ColumnWidth = 16.
CWS:Columns("K"):ColumnWidth = 25.
CWS:Columns("L"):ColumnWidth = 25.
CWS:Columns("M"):ColumnWidth = 16.
CWS:Columns("N"):ColumnWidth = 16.
CWS:Columns("O"):ColumnWidth = 23.
CWS:Columns("P"):ColumnWidth = 23.
CWS:Columns("Q"):ColumnWidth = 16.
CWS:Columns("R"):ColumnWidth = 16.
CWS:Columns("S"):ColumnWidth = 16.


/***--- Title Part ---***/
nv_row = 1. /*Start Row */

CR = "F" + STRING(nv_row).
CWS:Range(CR):Value = "สมุดทะเบียนเกี่ยวกับธุรกิจของนายหน้าประกันวินาศภัย".
CWS:Range(CR):Font:Bold  = TRUE.  

nv_row = nv_row + 1. 
CR = "E" + STRING(nv_row).
CWS:Range(CR):Value = "                         ชื่อผู้ประกอบการ ธนาคารเกียรตินาคิน จำกัด (มหาชน) เลขที่ใบอนุญาต ๓๓/๒๕๔๙".


nv_row = nv_row + 1. 
CR = "F" + STRING(nv_row).
CWS:Range(CR):Value = "ประจำเดือน.........................พ.ศ..................".


/***--- Head Column ---***/
nv_row = nv_row + 2. 
CR = "A" + STRING(nv_row) + ":S" + STRING(nv_row).
CWS:Range(CR):Borders:Item(8):Weight = 2 .
CWS:Range(CR):Borders:Item(10):Weight = 2  .

CR = "A" + STRING(nv_row) + ":C" + STRING(nv_row).
CWS:Range(CR):MergeCells = TRUE. CWS:Range(CR):Value = "กรมธรรม์ประกันภัย".
CWS:Range(CR):HorizontalAlignment = 3.   /*จัด Cell อยู่ตรงกลาง*/
CWS:Range(CR):Borders:Item(7):Weight = 2  .
CWS:Range(CR):Borders:Item(9):Weight = 2  .
CWS:Range(CR):Borders:Item(10):Weight = 2 .

CR = "D" + STRING(nv_row) + ":D" + STRING(nv_row + 1).
CWS:Range(CR):MergeCells = TRUE. CWS:Range(CR):Value = "ชื่อ-สกุลผู้เอาประกันภัย".
CWS:Range(CR):HorizontalAlignment = 3.
CWS:Range(CR):Borders:Item(7):Weight = 2  .
CWS:Range(CR):Borders:Item(9):Weight = 2  .
CWS:Range(CR):Borders:Item(10):Weight = 2  .


CR = "E"+ STRING(nv_row) + ":E" + STRING(nv_row + 1).
CWS:Range(CR):MergeCells = TRUE. CWS:Range(CR):Value = "ที่อยู่ผู้เอาประกันภัย".
CWS:Range(CR):HorizontalAlignment = 3.
CWS:Range(CR):Borders:Item(9):Weight = 2  .
CWS:Range(CR):Borders:Item(10):Weight = 2  .

CR = "F"+ STRING(nv_row) + ":F" + STRING(nv_row + 1).
CWS:Range(CR):MergeCells = TRUE. CWS:Range(CR):Value = "ชื่อบริษัทประกันวินาศภัย".
CWS:Range(CR):HorizontalAlignment = 3.
CWS:Range(CR):Borders:Item(9):Weight = 2  .
CWS:Range(CR):Borders:Item(10):Weight = 2  .

CR = "G"+ STRING(nv_row) + ":G" + STRING(nv_row + 1).
CWS:Range(CR):MergeCells = TRUE. CWS:Range(CR):Value = "ประเภทของสัญญาประกันภัย".
CWS:Range(CR):HorizontalAlignment = 3.
CWS:Range(CR):Borders:Item(9):Weight = 2  .
CWS:Range(CR):Borders:Item(10):Weight = 2  .

CR = "H"+ STRING(nv_row) + ":H" + STRING(nv_row + 1).
CWS:Range(CR):MergeCells = TRUE. CWS:Range(CR):Value = "จำนวนเงินเอาประกันภัย".
CWS:Range(CR):HorizontalAlignment = 3.
CWS:Range(CR):Borders:Item(9):Weight = 2  .
CWS:Range(CR):Borders:Item(10):Weight = 2  .

CR = "I"+ STRING(nv_row) + ":I" + STRING(nv_row + 1).
CWS:Range(CR):MergeCells = TRUE. CWS:Range(CR):Value = "เบี้ยประกันภัย".
CWS:Range(CR):HorizontalAlignment = 3.
CWS:Range(CR):Borders:Item(9):Weight = 2  .
CWS:Range(CR):Borders:Item(10):Weight = 2  .

CR = "J"+ STRING(nv_row) + ":J" + STRING(nv_row + 1).
CWS:Range(CR):MergeCells = TRUE. CWS:Range(CR):Value = "ภาษีอากร".
CWS:Range(CR):HorizontalAlignment = 3.
CWS:Range(CR):Borders:Item(9):Weight = 2  .
CWS:Range(CR):Borders:Item(10):Weight = 2  .

CR = "K"+ STRING(nv_row) + ":K" + STRING(nv_row + 1).
CWS:Range(CR):MergeCells = TRUE. CWS:Range(CR):Value = "วัน เดือน ปี ที่รับเบี้ยประกันภัย".
CWS:Range(CR):HorizontalAlignment = 3.
CWS:Range(CR):Borders:Item(9):Weight = 2  .
CWS:Range(CR):Borders:Item(10):Weight = 2  .

CR = "L"+ STRING(nv_row) + ":L" + STRING(nv_row + 1).
CWS:Range(CR):MergeCells = TRUE. CWS:Range(CR):Value = "วัน เดือน ปีที่ นำส่งเบี้ยประกันภัย".
CWS:Range(CR):HorizontalAlignment = 3.
CWS:Range(CR):Borders:Item(9):Weight = 2  .
CWS:Range(CR):Borders:Item(10):Weight = 2  .

CR = "M"+ STRING(nv_row) + ":N" + STRING(nv_row).
CWS:Range(CR):MergeCells = TRUE. CWS:Range(CR):Value = "ค่าบำเหน็จ".
CWS:Range(CR):HorizontalAlignment = 3.
CWS:Range(CR):Borders:Item(9):Weight = 2  .
CWS:Range(CR):Borders:Item(10):Weight = 2  .



CR = "O"+ STRING(nv_row) + ":O" + STRING(nv_row + 1).
CWS:Range(CR):MergeCells = TRUE. CWS:Range(CR):Value = "ประเภทย่อยสัญญาประกันภัย".
CWS:Range(CR):HorizontalAlignment = 3.
CWS:Range(CR):Borders:Item(9):Weight = 2  .
CWS:Range(CR):Borders:Item(10):Weight = 2  .


CR = "P"+ STRING(nv_row) + ":P" + STRING(nv_row + 1).
CWS:Range(CR):MergeCells = TRUE. CWS:Range(CR):Value = "จำนวนเงินค่าบำเหน็จค้างรับ".
CWS:Range(CR):HorizontalAlignment = 3.
CWS:Range(CR):Borders:Item(9):Weight = 2  .
CWS:Range(CR):Borders:Item(10):Weight = 2  .

CR = "Q"+ STRING(nv_row) + ":Q" + STRING(nv_row + 1).
CWS:Range(CR):MergeCells = TRUE. CWS:Range(CR):Value = "หมายเหตุ".
CWS:Range(CR):HorizontalAlignment = 3.
CWS:Range(CR):Borders:Item(9):Weight = 2  .
CWS:Range(CR):Borders:Item(10):Weight = 2  .

CR = "R"+ STRING(nv_row) + ":R" + STRING(nv_row + 1).
CWS:Range(CR):MergeCells = TRUE. CWS:Range(CR):Value = "สาขาธนาคาร".
CWS:Range(CR):HorizontalAlignment = 3.
CWS:Range(CR):Borders:Item(9):Weight = 2  .
CWS:Range(CR):Borders:Item(10):Weight = 2  .

CR = "S"+ STRING(nv_row) + ":S" + STRING(nv_row + 1).
CWS:Range(CR):MergeCells = TRUE. CWS:Range(CR):Value = "".
CWS:Range(CR):HorizontalAlignment = 3.
CWS:Range(CR):Borders:Item(9):Weight = 2  .
CWS:Range(CR):Borders:Item(10):Weight = 2  .

/***--- Second Column line ---***/
nv_row = nv_row + 1. 

CR = "A"+ STRING(nv_row) + ":S" + STRING(nv_row).
CWS:Range(CR):Borders:Item(9):Weight = 2  .

CR = "A" + STRING(nv_row).
CWS:Range(CR):Value = "เลขที่".
CWS:Range(CR):Borders:Item(7):Weight = 2  .
CWS:Range(CR):Borders:Item(10):Weight = 2  .
CWS:Range(CR):HorizontalAlignment = 3.

CR = "B" + STRING(nv_row).
CWS:Range(CR):Value = "วันเริ่มต้น".
CWS:Range(CR):Borders:Item(10):Weight = 2  .
CWS:Range(CR):HorizontalAlignment = 3.

CR = "C" + STRING(nv_row).
CWS:Range(CR):Value = "วันสิ้นสุด".
CWS:Range(CR):HorizontalAlignment = 3.

CR = "M" + STRING(nv_row).
CWS:Range(CR):Value = "จำนวนเงินที่ได้รับ".
CWS:Range(CR):Borders:Item(10):Weight = 2  .

CR = "N" + STRING(nv_row).
CWS:Range(CR):Value = "วันเดือนปีที่ได้รับ".
CWS:Range(CR):Borders:Item(10):Weight = 2  .

/***--- Third Column ---***/
nv_row = nv_row + 1. 

CR = "A"+ STRING(nv_row) + ":S" + STRING(nv_row).
CWS:Range(CR):Borders:Item(9):Weight = 2  .

CR = "A" + STRING(nv_row).
CWS:Range(CR):Value = "1".
CWS:Range(CR):Borders:Item(7):Weight = 2  .
CWS:Range(CR):Borders:Item(10):Weight = 2  .
CWS:Range(CR):HorizontalAlignment = 3.

CR = "B" + STRING(nv_row).
CWS:Range(CR):Value = "2".
CWS:Range(CR):Borders:Item(10):Weight = 2  .
CWS:Range(CR):HorizontalAlignment = 3.

CR = "C" + STRING(nv_row).
CWS:Range(CR):Value = "3".
CWS:Range(CR):Borders:Item(10):Weight = 2  .
CWS:Range(CR):HorizontalAlignment = 3.

CR = "D" + STRING(nv_row).
CWS:Range(CR):Value = "4".
CWS:Range(CR):Borders:Item(10):Weight = 2  .
CWS:Range(CR):HorizontalAlignment = 3.

CR = "E" + STRING(nv_row).
CWS:Range(CR):Value = "5".
CWS:Range(CR):Borders:Item(10):Weight = 2  .
CWS:Range(CR):HorizontalAlignment = 3.

CR = "F" + STRING(nv_row).
CWS:Range(CR):Value = "6".
CWS:Range(CR):Borders:Item(10):Weight = 2  .
CWS:Range(CR):HorizontalAlignment = 3.

CR = "G" + STRING(nv_row).
CWS:Range(CR):Value = "7".
CWS:Range(CR):Borders:Item(10):Weight = 2  .
CWS:Range(CR):HorizontalAlignment = 3.

CR = "H" + STRING(nv_row).
CWS:Range(CR):Value = "8".
CWS:Range(CR):Borders:Item(10):Weight = 2  .
CWS:Range(CR):HorizontalAlignment = 3.

CR = "I" + STRING(nv_row).
CWS:Range(CR):Value = "9".
CWS:Range(CR):Borders:Item(10):Weight = 2  .
CWS:Range(CR):HorizontalAlignment = 3.

CR = "J" + STRING(nv_row).
CWS:Range(CR):Value = "10".
CWS:Range(CR):Borders:Item(10):Weight = 2  .
CWS:Range(CR):HorizontalAlignment = 3.

CR = "K" + STRING(nv_row).
CWS:Range(CR):Value = "11".
CWS:Range(CR):Borders:Item(10):Weight = 2  .
CWS:Range(CR):HorizontalAlignment = 3.

CR = "L" + STRING(nv_row).
CWS:Range(CR):Value = "12".
CWS:Range(CR):Borders:Item(10):Weight = 2  .
CWS:Range(CR):HorizontalAlignment = 3.

CR = "M" + STRING(nv_row).
CWS:Range(CR):Value = "13".
CWS:Range(CR):Borders:Item(10):Weight = 2  .
CWS:Range(CR):HorizontalAlignment = 3.

CR = "N" + STRING(nv_row).
CWS:Range(CR):Value = "14".
CWS:Range(CR):Borders:Item(10):Weight = 2  .
CWS:Range(CR):HorizontalAlignment = 3.

CR = "O" + STRING(nv_row).
CWS:Range(CR):Value = "15".
CWS:Range(CR):Borders:Item(10):Weight = 2  .
CWS:Range(CR):HorizontalAlignment = 3.

CR = "P" + STRING(nv_row).
CWS:Range(CR):Value = "16".
CWS:Range(CR):Borders:Item(10):Weight = 2  .
CWS:Range(CR):HorizontalAlignment = 3.

CR = "Q" + STRING(nv_row).
CWS:Range(CR):Value = "17".
CWS:Range(CR):Borders:Item(10):Weight = 2  .
CWS:Range(CR):HorizontalAlignment = 3.

CR = "R" + STRING(nv_row).
CWS:Range(CR):Value = "18".
CWS:Range(CR):Borders:Item(10):Weight = 2  .
CWS:Range(CR):HorizontalAlignment = 3.

CR = "S" + STRING(nv_row).
CWS:Range(CR):Value = "19".
CWS:Range(CR):Borders:Item(10):Weight = 2  .
CWS:Range(CR):HorizontalAlignment = 3.



END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

