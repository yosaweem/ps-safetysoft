&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
*/
&Scoped-define WINDOW-NAME c-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS c-Win 
/*------------------------------------------------------------------------
/* Connected Databases sic_test         PROGRESS                        */
  File: 
  Description: 
  Input Parameters:<none>
  Output Parameters:<none>
  Author: 
  Created: 
------------------------------------------------------------------------*/
/*          This .W file was created with the Progress AppBuilder.      */
/*----------------------------------------------------------------------*/
/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */
CREATE WIDGET-POOL.
/****************************  Definitions  **************************    */
/*Parameters Definitions ---                                              */
/*Local Variable Definitions ---                                          */  
/*******************************/                                      
/*programid   : wgwnsge2.w                                                    */ 
/*programname : Load Text File NISSAN COMPULSARY 72  [LOCTON ON WEB SERVICES ]*/ 
/*Copyright   : Safety Insurance Public Company Limited                                   */ 
/*                          บริษัท ประกันคุ้มภัย จำกัด (มหาชน)                                        */ 
/*Database    : brstat                                                        */
/*create by   : Kridtiya i. A61-0229 Date. 23/05/2018 Add change GW system to Web service     */ 
/*Modify By   : Porntiwa T.  A62-0105  10/09/2019 Change Host => tmsth */
/*Modify By : Sarinya C. A64-0217  20/05/2021 : Change host => TMPMWSDBIP01  */
DEFINE NEW SHARED TEMP-TABLE wdetail
    FIELD policy       AS CHAR FORMAT "x(20)"   INIT ""  /* notify number*/  
    FIELD poltyp       AS CHAR FORMAT "x(5)"    INIT ""  /* policy       */                
    FIELD cedpol       AS CHAR FORMAT "x(20)"   INIT ""  /* account no.        */     
    FIELD tiname       AS CHAR FORMAT "x(20)"   INIT ""  /* title name         */     
    FIELD insnam       AS CHAR FORMAT "x(35)"   INIT ""  /* first name         */     
    FIELD insnam2      AS CHAR FORMAT "x(40)"   INIT ""  /* first name         */     
    FIELD insnam3      AS CHAR FORMAT "x(35)"   INIT ""  
    FIELD addr1        AS CHAR FORMAT "x(50)"   INIT ""  /* address1           */     
    FIELD addr2        AS CHAR FORMAT "x(50)"   INIT ""  /* address1           */     
    FIELD addr3        AS CHAR FORMAT "x(50)"   INIT ""  /* address1           */     
    FIELD addr4        AS CHAR FORMAT "x(50)"   INIT ""  /* address1           */     
    FIELD addr5        AS CHAR FORMAT "x(10)"   INIT ""  /* address1           */     
    FIELD tambon       AS CHAR FORMAT "x(35)"   INIT ""  
    FIELD amper        AS CHAR FORMAT "x(35)"   INIT ""  
    FIELD country      AS CHAR FORMAT "x(35)"   INIT ""  
    FIELD caryear      AS CHAR FORMAT "x(4)"    INIT ""  /* year         */  
    FIELD eng          AS CHAR FORMAT "x(25)"   INIT ""  /* engine       */  
    FIELD chasno       AS CHAR FORMAT "x(25)"   INIT ""  /* chassis      */  
    FIELD engcc        AS CHAR FORMAT "x(5)"    INIT ""  /* weight       */  
    FIELD vehreg       AS CHAR FORMAT "x(20)"   INIT ""  /* licence no   */      /*A54-0112*/
    FIELD provin       AS CHAR FORMAT "x(10)"   INIT ""  /* licence no   */      /*A54-0112*/
    FIELD garage       AS CHAR FORMAT "x(1)"    INIT ""  /* garage       */  
    FIELD vehuse       AS CHAR FORMAT "x(1)"    INIT ""  /* vehuse       */  
    FIELD comdat       AS CHAR FORMAT "x(10)"   INIT ""  /* comdat       */  
    FIELD expdat       AS CHAR FORMAT "x(10)"   INIT ""  /* expiry date        */   
    FIELD si           AS CHAR FORMAT "x(15)"   INIT ""  /* sum si       */  
    FIELD fire         AS CHAR FORMAT "x(15)"   INIT ""  
    FIELD premt        AS CHAR FORMAT "x(15)"   INIT ""  /*  prem.1            */  
    FIELD premtnet     AS CHAR FORMAT "x(15)"   INIT ""  /*  prem.1            */ 
    FIELD stk          AS CHAR FORMAT "x(25)"   INIT ""  /* sticker            */  
    FIELD brand        AS CHAR FORMAT "x(20)"   INIT ""  /* brand              */     
    FIELD benname      AS CHAR FORMAT "x(65)"   INIT ""  /* beneficiary        */ 
    FIELD accesstxt    AS CHAR FORMAT "x(100)"  INIT ""  
    FIELD receipt_name AS CHAR FORMAT "x(60)"   INIT ""  /* receipt name       */  
    FIELD receipt_addr AS CHAR FORMAT "x(250)"   INIT ""  /* receipt name       */  
    FIELD prepol       AS CHAR FORMAT "x(25)"    INIT ""  /* old policy         */     
    FIELD ncb          AS CHAR FORMAT "X(10)"    INIT ""  /* deduct disc.       */     
    FIELD dspc         AS CHAR FORMAT "X(10)"    INIT ""  /* deduct disc.       */     
    FIELD tp1          AS CHAR FORMAT "X(14)"    INIT ""  /* TPBI/Person       */     
    FIELD tp2          AS CHAR FORMAT "X(14)"    INIT ""  /* TPBI/Per Acciden  */     
    FIELD tp3          AS CHAR FORMAT "X(14)"    INIT ""  /* TPPD/Per Acciden  */     
    FIELD covcod       AS CHAR FORMAT "x(1)"     INIT ""  /* covcod            */     
    FIELD cndat        AS CHAR FORMAT "x(10)"    INIT ""  
    FIELD compul       AS CHAR FORMAT "x"        INIT "" 
    FIELD model        AS CHAR FORMAT "x(50)"    INIT ""   
    FIELD seat         AS CHAR FORMAT "x(2)"     INIT ""    
    FIELD remark       AS CHAR FORMAT "x(150)"   INIT ""    
    FIELD comper       AS CHAR FORMAT "x(14)"    INIT ""    
    FIELD comacc       AS CHAR FORMAT "x(14)"    INIT ""    
    FIELD deductpd     AS CHAR FORMAT "X(14)"    INIT ""     
    FIELD deductpd2    AS CHAR FORMAT "X(14)"    INIT ""  
    FIELD cargrp       AS CHAR FORMAT "x"        INIT ""     
    FIELD body         AS CHAR FORMAT "x(40)"    INIT ""     
    FIELD NO_41        AS CHAR FORMAT "x(14)"    INIT ""  
    FIELD NO_42        AS CHAR FORMAT "x(14)"    INIT ""  
    FIELD NO_43        AS CHAR FORMAT "x(14)"    INIT ""  
    FIELD comment      AS CHAR FORMAT "x(512)"   INIT ""
    FIELD agent        AS CHAR FORMAT "x(10)"    INIT ""   
    FIELD producer     AS CHAR FORMAT "x(10)"    INIT ""  
    FIELD vatcode      AS CHAR FORMAT "x(10)"    INIT ""
    FIELD entdat       AS CHAR FORMAT "x(10)"    INIT ""      
    FIELD enttim       AS CHAR FORMAT "x(8)"     INIT ""       
    FIELD trandat      AS CHAR FORMAT "x(10)"    INIT "" 
    FIELD firstdat     AS CHAR FORMAT "x(10)"    INIT ""  
    FIELD trantim      AS CHAR FORMAT "x(8)"     INIT ""       
    FIELD n_IMPORT     AS CHAR FORMAT "x(2)"     INIT ""       
    FIELD n_EXPORT     AS CHAR FORMAT "x(2)"      INIT "" 
    FIELD pass         AS CHAR FORMAT "x"         INIT "n"
    FIELD OK_GEN       AS CHAR FORMAT "X"         INIT "Y" 
    FIELD renpol       AS CHAR FORMAT "x(32)"     INIT ""     
    FIELD cr_2         AS CHAR FORMAT "x(32)"     INIT ""  
    FIELD delerno      AS CHAR FORMAT "x(20)"     INIT "" 
    FIELD delerno1     AS CHAR FORMAT "x(20)"     INIT "" 
    FIELD delerno2     AS CHAR FORMAT "x(20)"     INIT "" 
    FIELD delername    AS CHAR FORMAT "x(60)"     INIT ""  
    FIELD docno        AS CHAR INIT "" FORMAT "x(10)" 
    FIELD redbook      AS CHAR INIT "" FORMAT "X(8)"
    FIELD drivnam      AS CHAR FORMAT "x"        INIT "n" 
    FIELD tariff       AS CHAR FORMAT "x(2)"     INIT "9"
    FIELD tons         AS DECI FORMAT "9999.99"  INIT ""
    FIELD cancel       AS CHAR FORMAT "x(2)"     INIT ""    
    FIELD accdat       AS CHAR INIT "" FORMAT "x(10)"   
    FIELD prempa       AS CHAR FORMAT "x"        INIT ""       
    FIELD subclass     AS CHAR FORMAT "x(5)"     INIT ""    
    FIELD fleet        AS CHAR FORMAT "x(10)"    INIT ""   
    FIELD WARNING      AS CHAR FORMAT "X(30)"    INIT ""
    FIELD seat41       AS INTE FORMAT "99"       INIT 0
    FIELD volprem      AS CHAR FORMAT "x(20)"    INIT "" 
    FIELD icno         AS CHAR FORMAT "x(13)"    INIT ""
    FIELD n_branch     AS CHAR FORMAT "x(5)"     INIT "" 
    FIELD n_campaigns  AS CHAR FORMAT "x(40)"    INIT ""    
    FIELD n_Promotion  AS CHAR FORMAT "x(16)"    INIT "".
DEFINE VAR  nv_reccnt      AS  INT  INIT  0.           /*all load record*/    
DEFINE VAR  nv_netprm_t    AS DECI         FORMAT "->,>>>,>>9.99" INIT 0.   
DEFINE VAR  nv_completecnt AS   INT   INIT  0.   /*complete record */ 
DEFINE VAR  nv_netprm_s    AS DECI         FORMAT "->,>>>,>>9.99" INIT 0. 
DEFINE VAR  nv_rectot      AS INT          FORMAT ">>,>>9"        INIT 0.                       
DEFINE VAR  nv_recsuc      AS INT          FORMAT ">>,>>9"        INIT 0.  
DEFINE VAR  nv_batflg      AS LOG          INIT NO. 
DEFINE VAR  np_no          AS CHAR FORMAT "x(10)"  INIT "".   /* 1   No. */   
DEFINE VAR  np_addr2       AS CHAR.
DEFINE VAR  np_addr3       AS CHAR.
DEFINE VAR  np_addr4       AS CHAR.
DEFINE VAR  np_addr5       AS CHAR.
DEFINE VAR  np_expdate     AS CHAR. 
DEFINE VAR  nv_company     AS CHAR. 
DEFINE VAR  np_chkErr      AS LOGICAL   INIT NO .
DEFINE VAR  np_insurcename AS CHAR FORMAT "x(50)"  INIT "".   /* 4   ชื่อผู้เอาประกันภัย */                                                                 
DEFINE VAR  np_icno        AS CHAR FORMAT "x(20)"  INIT "".   /* 42  icno    */  
DEFINE VAR  np_addr1       AS CHAR FORMAT "x(100)" INIT "".   /* 6   ที่อยู่ผู้เอาประกันภัย  */                                                             
DEFINE VAR  np_model       AS CHAR FORMAT "x(60)"  INIT "".   /* 7   ยี่ห้อ/รุ่น */                                                                         
DEFINE VAR  np_vehreg      AS CHAR FORMAT "x(30)"  INIT "".   /* 8   ทะเบียนรถ   */  /*A54-0112*/
DEFINE VAR  np_cedpol      AS CHAR FORMAT "x(20)"  INIT "".   /* 2   TN# เลขที่สัญญา*/                                                                                 
DEFINE VAR  np_premt       AS CHAR FORMAT "x(20)"  INIT "".   /* 21  เบี้ยประกันภัยภาคสมัครใจ    */                                                         
DEFINE VAR  np_cha_no      AS CHAR FORMAT "x(30)"  INIT "".   /* 10  เลขตัวถัง   */                                                                         
DEFINE VAR  np_engno       AS CHAR FORMAT "x(30)"  INIT "".   /* 11  เลขเครื่องยนต์  */                                                                     
DEFINE VAR  np_engCC       AS CHAR FORMAT "x(4)"   INIT "".   /* 12  ขนาดเครื่องยนต์ */                                                                     
DEFINE VAR  n_rencnt       AS  INT  INIT  0.               
DEFINE VAR  n_endcnt       AS  INT  INIT  0. 
DEFINE VAR  np_comdate     AS CHAR FORMAT "x(10)"  INIT "".   /* 19  วันที่เริ่มคุ้มครอง */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main
&Scoped-define BROWSE-NAME br_wdetail

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES wdetail

/* Definitions for BROWSE br_wdetail                                    */
&Scoped-define FIELDS-IN-QUERY-br_wdetail wdetail.poltyp wdetail.policy wdetail.brand wdetail.icno wdetail.tiname wdetail.insnam wdetail.insnam2 wdetail.addr1 wdetail.addr2 wdetail.addr3 wdetail.addr4 wdetail.addr5 wdetail.model wdetail.vehreg wdetail.provin wdetail.chasno wdetail.eng wdetail.engcc wdetail.tons wdetail.cedpol wdetail.premtnet wdetail.comdat wdetail.expdat wdetail.subclass wdetail.comment   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_wdetail   
&Scoped-define SELF-NAME br_wdetail
&Scoped-define QUERY-STRING-br_wdetail FOR EACH wdetail
&Scoped-define OPEN-QUERY-br_wdetail OPEN QUERY br_wdetail FOR EACH wdetail.
&Scoped-define TABLES-IN-QUERY-br_wdetail wdetail
&Scoped-define FIRST-TABLE-IN-QUERY-br_wdetail wdetail


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_loaddat fi_company fi_filename bu_file ~
fi_process buok bu_exit br_wdetail RECT-370 RECT-372 RECT-373 RECT-379 ~
RECT-380 
&Scoped-Define DISPLAYED-OBJECTS fi_loaddat fi_company fi_filename ~
fi_process 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR c-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON buok 
     LABEL "OK" 
     SIZE 10.5 BY 1.14
     FONT 6.

DEFINE BUTTON bu_exit 
     LABEL "EXIT" 
     SIZE 10.67 BY 1.14
     FONT 6.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 5 BY 1.

DEFINE VARIABLE fi_company AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_loaddat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_process AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 65 BY .95
     FGCOLOR 7  NO-UNDO.

DEFINE RECTANGLE RECT-370
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 130 BY 1.52
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-372
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 130 BY 4.62
     BGCOLOR 8 FGCOLOR 1 .

DEFINE RECTANGLE RECT-373
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 130 BY 10.67
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-379
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 16 BY 1.91
     BGCOLOR 2 .

DEFINE RECTANGLE RECT-380
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 16 BY 1.91
     BGCOLOR 6 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_wdetail FOR 
      wdetail SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_wdetail
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_wdetail c-Win _FREEFORM
  QUERY br_wdetail DISPLAY
      wdetail.poltyp      COLUMN-LABEL "poltyp  " 
      wdetail.policy      COLUMN-LABEL "policy  " 
      wdetail.brand       COLUMN-LABEL "brand   " 
      wdetail.icno        COLUMN-LABEL "icno    " 
      wdetail.tiname      COLUMN-LABEL "tiname  " 
      wdetail.insnam      COLUMN-LABEL "insnam  " 
      wdetail.insnam2     COLUMN-LABEL "insnam2 " 
      wdetail.addr1       COLUMN-LABEL "addr1   " 
      wdetail.addr2       COLUMN-LABEL "addr2   " 
      wdetail.addr3       COLUMN-LABEL "addr3   " 
      wdetail.addr4       COLUMN-LABEL "addr4   " 
      wdetail.addr5       COLUMN-LABEL "addr5   " 
      wdetail.model       COLUMN-LABEL "model   " 
      wdetail.vehreg      COLUMN-LABEL "vehreg  " 
      wdetail.provin      COLUMN-LABEL "provin  " 
      wdetail.chasno      COLUMN-LABEL "chasno  " 
      wdetail.eng         COLUMN-LABEL "eng     " 
      wdetail.engcc       COLUMN-LABEL "engcc   " 
      wdetail.tons        COLUMN-LABEL "tons    " 
      wdetail.cedpol      COLUMN-LABEL "cedpol  " 
      wdetail.premtnet    COLUMN-LABEL "premtnet" 
      wdetail.comdat      COLUMN-LABEL "comdat  " 
      wdetail.expdat      COLUMN-LABEL "expdat  " 
      wdetail.subclass    COLUMN-LABEL "subclass" 
      wdetail.comment     COLUMN-LABEL "comment "
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 129 BY 10.19
         BGCOLOR 15 FONT 6 ROW-HEIGHT-CHARS .95.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_loaddat AT ROW 2.71 COL 25 COLON-ALIGNED NO-LABEL
     fi_company AT ROW 3.76 COL 25 COLON-ALIGNED NO-LABEL WIDGET-ID 4
     fi_filename AT ROW 4.81 COL 25 COLON-ALIGNED NO-LABEL
     bu_file AT ROW 4.81 COL 88.5
     fi_process AT ROW 5.95 COL 25 COLON-ALIGNED NO-LABEL
     buok AT ROW 4.38 COL 97.17
     bu_exit AT ROW 4.38 COL 114.17
     br_wdetail AT ROW 7.48 COL 1.5
     "LOCKTON ON WEB SERVICE..." VIEW-AS TEXT
          SIZE 30 BY .95 AT ROW 6.05 COL 97.33 WIDGET-ID 2
          BGCOLOR 8 FGCOLOR 4 FONT 6
     "                  Company :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 3.76 COL 3 WIDGET-ID 6
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Input File Name Load :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 4.81 COL 3
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "    Load Text File NISSAN COMPULSARY 72  [LOCTON ON WEB SERVICES ]" VIEW-AS TEXT
          SIZE 128 BY .95 AT ROW 1.29 COL 2
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "                Load Date :":35 VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 2.71 COL 3
          BGCOLOR 8 FGCOLOR 1 FONT 6
     RECT-370 AT ROW 1 COL 1
     RECT-372 AT ROW 2.57 COL 1
     RECT-373 AT ROW 7.24 COL 1
     RECT-379 AT ROW 4 COL 94.33
     RECT-380 AT ROW 4 COL 111.67
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 131 BY 17.24
         BGCOLOR 8 FONT 6.


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
  CREATE WINDOW c-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "Load Text file NISSAN [wgwnsge1.w]"
         HEIGHT             = 17.1
         WIDTH              = 131.17
         MAX-HEIGHT         = 35.33
         MAX-WIDTH          = 170.67
         VIRTUAL-HEIGHT     = 35.33
         VIRTUAL-WIDTH      = 170.67
         RESIZE             = yes
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = 139
         FGCOLOR            = 133
         KEEP-FRAME-Z-ORDER = yes
         THREE-D            = yes
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.

&IF '{&WINDOW-SYSTEM}' NE 'TTY' &THEN
IF NOT c-Win:LOAD-ICON("wimage/safety.ico":U) THEN
    MESSAGE "Unable to load icon: wimage/safety.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW c-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fr_main
   FRAME-NAME Custom                                                    */
/* BROWSE-TAB br_wdetail bu_exit fr_main */
ASSIGN 
       br_wdetail:COLUMN-RESIZABLE IN FRAME fr_main       = TRUE.

ASSIGN 
       bu_file:AUTO-RESIZE IN FRAME fr_main      = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(c-Win)
THEN c-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_wdetail
/* Query rebuild information for BROWSE br_wdetail
     _START_FREEFORM
OPEN QUERY br_wdetail FOR EACH wdetail.
     _END_FREEFORM
     _Query            is NOT OPENED
*/  /* BROWSE br_wdetail */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME c-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-Win c-Win
ON END-ERROR OF c-Win /* Load Text file NISSAN [wgwnsge1.w] */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-Win c-Win
ON WINDOW-CLOSE OF c-Win /* Load Text file NISSAN [wgwnsge1.w] */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_wdetail
&Scoped-define SELF-NAME br_wdetail
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_wdetail c-Win
ON ROW-DISPLAY OF br_wdetail IN FRAME fr_main
DO:
    DEF VAR z AS INTE  INIT 0.
    DEF VAR s AS INTE  INIT 0.
    s = 1.
    z = 26.
    IF WDETAIL.WARNING <> "" THEN DO:
        wdetail.poltyp  :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.
        wdetail.policy  :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.brand   :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.icno    :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.tiname  :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.insnam  :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.insnam2 :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.addr1   :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.addr2   :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.addr3   :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
        wdetail.addr4   :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.addr5   :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
        wdetail.model   :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
        wdetail.vehreg  :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.      
        wdetail.provin  :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.chasno  :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.    
        wdetail.eng     :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.    
        wdetail.engcc   :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.tons    :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
        wdetail.cedpol  :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.premtnet:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
        wdetail.comdat  :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
        wdetail.expdat  :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.subclass:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
        wdetail.comment :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 





        wdetail.poltyp  :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.policy  :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.brand   :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.icno    :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.tiname  :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.insnam  :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.insnam2 :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.addr1   :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.    
        wdetail.addr2   :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.addr3   :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.addr4   :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.addr5   :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.model   :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.vehreg  :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.provin  :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.chasno  :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.eng     :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.engcc   :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.tons    :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.cedpol  :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.premtnet:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.comdat  :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.expdat  :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.subclass:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.comment :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  

        
          
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buok c-Win
ON CHOOSE OF buok IN FRAME fr_main /* OK */
DO:
    ASSIGN
        fi_process   = "Load Text file NISSAN " 
        fi_loaddat   = INPUT fi_loaddat  .

    DISP    fi_process WITH FRAME fr_main.

    IF fi_loaddat = ? THEN DO:
        MESSAGE "Load Date Is Mandatory" VIEW-AS ALERT-BOX .
        APPLY "entry" to fi_loaddat.
        RETURN NO-APPLY.
    END.
    IF fi_filename = "" THEN DO:
        MESSAGE "Plese Input File Data Load...!!!" VIEW-AS ALERT-BOX ERROR.
        APPLY "Entry" TO fi_filename.
        RETURN NO-APPLY.
    END.
    For each  wdetail :
        DELETE  wdetail.
    END.

    RUN proc_assign. 

    FOR EACH wdetail:
        IF WDETAIL.POLTYP = "v70" OR WDETAIL.POLTYP = "v72" THEN DO:
            ASSIGN
                nv_reccnt      =  nv_reccnt   + 1
                nv_netprm_t    =  nv_netprm_t + decimal(wdetail.premt)
                wdetail.pass   = "Y". 
        END.
        ELSE DO :  
            DELETE WDETAIL.
        END.
    END. 
    IF  nv_reccnt = 0 THEN DO: 
        MESSAGE "No Record Can Gen " VIEW-AS ALERT-BOX.       
        RETURN NO-APPLY.
    END.

    RUN proc_chktest1. 

    FOR EACH wdetail  WHERE wdetail .pass = "y"  NO-LOCK:
        ASSIGN
            nv_completecnt = nv_completecnt + 1
            nv_netprm_s    = nv_netprm_s    + decimal(wdetail.premt). 
    END.
    nv_rectot = nv_reccnt.      
    nv_recsuc = nv_completecnt. 
    IF nv_rectot <> nv_recsuc   THEN DO:
        nv_batflg = NO.
        /*MESSAGE "Policy import record is not match to Total record !!!" VIEW-AS ALERT-BOX.*/
    END.
    ELSE 
    IF nv_netprm_t <> nv_netprm_s THEN DO:
        ASSIGN nv_netprm_t  = nv_netprm_s
        nv_batflg = YES.
    /*MESSAGE "Total net premium is not match to Total net premium !!!" VIEW-AS ALERT-BOX.*/
    END.
    ELSE 
        nv_batflg = YES.

    IF CONNECTED("BUInt") THEN DISCONNECT BUInt.
    MESSAGE "Process Complete" VIEW-AS ALERT-BOX INFORMATION TITLE "INFORMATION".
   
    /*FOR EACH wdetail:
        ASSIGN wdetail.pass = wdetail.pass.
    END.*/
RUN proc_open. 

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit c-Win
ON CHOOSE OF bu_exit IN FRAME fr_main /* EXIT */
DO:
  APPLY "close" TO THIS-PROCEDURE.
      RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_file
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_file c-Win
ON CHOOSE OF bu_file IN FRAME fr_main /* ... */
DO:
    DEFINE VARIABLE cvData        AS CHARACTER NO-UNDO.
    DEFINE VARIABLE OKpressed     AS LOGICAL INITIAL TRUE.
    DEF VAR no_add AS CHAR FORMAT "x(8)" .  
    SYSTEM-DIALOG GET-FILE cvData
        TITLE      "Choose Data File to Import ..."
        FILTERS    /* "Text Documents" "*.csv"*/
        "CSV (Comma Delimited)"   "*.csv"   /*,
        "Data Files (*.dat)"     "*.dat",
        "Text Files (*.txt)" "*.txt"*/
        MUST-EXIST
        USE-FILENAME
        UPDATE OKpressed.
    IF OKpressed = TRUE THEN DO:

        ASSIGN 
         no_add = STRING(MONTH(TODAY),"99")    + 
                 STRING(DAY(TODAY),"99")      + 
                 SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                 SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2)  
            fi_filename  = cvData . 
        DISP fi_filename  WITH FRAME {&FRAME-NAME}. 
        APPLY "Entry" TO fi_filename .
        RETURN NO-APPLY.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_company
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_company c-Win
ON LEAVE OF fi_company IN FRAME fr_main
DO:
  fi_company = INPUT fi_company.
  ASSIGN nv_company = fi_company.
  DISP fi_company WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_filename
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_filename c-Win
ON LEAVE OF fi_filename IN FRAME fr_main
DO:
  fi_filename = INPUT fi_filename.
  DISP fi_filename WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_loaddat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_loaddat c-Win
ON LEAVE OF fi_loaddat IN FRAME fr_main
DO:
  fi_loaddat  =  Input  fi_loaddat.
  Disp  fi_loaddat  with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK c-Win 


/* ***************************  Main Block  *************************** */
/* Set CURRENT-WINDOW: this will parent dialog-boxes and frames.        */
ASSIGN CURRENT-WINDOW                = {&WINDOW-NAME} 
       THIS-PROCEDURE:CURRENT-WINDOW = {&WINDOW-NAME}.

/* The CLOSE event can be used from inside or outside the procedure to  */
/* terminate it.                                                        */
ON CLOSE OF THIS-PROCEDURE 
   RUN disable_UI.
  
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.


/********************  T I T L E   F O R  C - W I N  ****************/
  DEF  VAR  gv_prgid   AS   CHAR  FORMAT "X(8)"   NO-UNDO.
  DEF  VAR  gv_prog    AS   CHAR  FORMAT "X(40)" NO-UNDO.
  
  gv_prgid = "Wgwnsge1".
  gv_prog  = "Load Text & Generate NISSAN On Web Service".
  fi_loaddat = TODAY.
  DISP fi_loaddat WITH FRAME fr_main.
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).  /*28/11/2006*/
   
  ASSIGN 
      fi_loaddat = TODAY
      fi_company = "1395"
      nv_company = fi_company.
   
  DISP 
      fi_loaddat  
      fi_company
      WITH FRAME fr_main. 
/*********************************************************************/  
  RUN  WUT\WUTWICEN (c-win:handle).  
  Session:data-Entry-Return = Yes.

  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI c-Win  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(c-Win)
  THEN DELETE WIDGET c-Win.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI c-Win  _DEFAULT-ENABLE
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
  DISPLAY fi_loaddat fi_company fi_filename fi_process 
      WITH FRAME fr_main IN WINDOW c-Win.
  ENABLE fi_loaddat fi_company fi_filename bu_file fi_process buok bu_exit 
         br_wdetail RECT-370 RECT-372 RECT-373 RECT-379 RECT-380 
      WITH FRAME fr_main IN WINDOW c-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW c-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign c-Win 
PROCEDURE proc_assign :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    For each  wdetail :
        DELETE  wdetail.
    END.
    ASSIGN 
        np_no           = ""    /*  No. */                    
        np_icno         = ""    /*  เลขที่บัตรประชาชน   */    
        np_insurcename  = ""    /*  ชื่อผู้เอาประกันภัย */    
        np_addr1        = ""    /*  ที่อยู่ผู้เอาประกันภัย  */
        np_addr2        = ""    /*  ที่อยู่ผู้เอาประกันภัย  */
        np_addr3        = ""    /*  ที่อยู่ผู้เอาประกันภัย  */
        np_addr4        = ""    /*  ที่อยู่ผู้เอาประกันภัย  */
        np_addr5        = ""    /*  ที่อยู่ผู้เอาประกันภัย  */
        np_model        = ""    /*  ยี่ห้อ/รุ่นรถ   */        
        np_vehreg       = ""    /*  ทะเบียนรถ   */            
        np_cha_no       = ""    /*  เลขตัวถัง   */            
        np_engno        = ""    /*  เลขเครื่องยนต์  */        
        np_engCC        = ""    /*  ขนาดเครื่องยนต์ */        
        np_cedpol       = ""    /*  เลขที่สัญญา */            
        np_premt        = ""    /*  ค่าเบี้ยพรบ */            
        np_comdate      = ""    /*  วันที่คุ้มครอง  */        
        np_expdate      = ""  . /*  วันที่สิ้นสุด   */  
    INPUT FROM VALUE(fi_FileName).
    REPEAT:
        /*CREATE wdetail2.*/ /*comment by Kridtiya i. A56-0037...*/
        
        IMPORT DELIMITER "|" 
            np_no           /*  No. */                    
            np_icno         /*  เลขที่บัตรประชาชน   */    
            np_insurcename  /*  ชื่อผู้เอาประกันภัย */    
            np_addr1        /*  ที่อยู่ผู้เอาประกันภัย  */
            np_addr2        /*  ที่อยู่ผู้เอาประกันภัย  */
            np_addr3        /*  ที่อยู่ผู้เอาประกันภัย  */
            np_addr4        /*  ที่อยู่ผู้เอาประกันภัย  */
            np_addr5        /*  ที่อยู่ผู้เอาประกันภัย  */
            np_model        /*  ยี่ห้อ/รุ่นรถ   */        
            np_vehreg       /*  ทะเบียนรถ   */            
            np_cha_no       /*  เลขตัวถัง   */            
            np_engno        /*  เลขเครื่องยนต์  */        
            np_engCC        /*  ขนาดเครื่องยนต์ */        
            np_cedpol       /*  เลขที่สัญญา */            
            np_premt        /*  ค่าเบี้ยพรบ */            
            np_comdate      /*  วันที่คุ้มครอง  */        
            np_expdate .     /*  วันที่สิ้นสุด   */  
        IF                   np_cedpol = "" THEN NEXT.   
        ELSE IF index(np_no,"ลำดับ") <> 0   THEN NEXT.   
        ELSE IF index(np_no,"No.")   <> 0   THEN NEXT.    
        ELSE IF ( deci(np_premt)  > 0 )     THEN DO:
            RUN proc_assignwdetail. 
        END.
        ASSIGN 
            np_no           = ""    /*  No. */                    
            np_icno         = ""    /*  เลขที่บัตรประชาชน   */    
            np_insurcename  = ""    /*  ชื่อผู้เอาประกันภัย */    
            np_addr1        = ""    /*  ที่อยู่ผู้เอาประกันภัย  */
            np_addr2        = ""    /*  ที่อยู่ผู้เอาประกันภัย  */
            np_addr3        = ""    /*  ที่อยู่ผู้เอาประกันภัย  */
            np_addr4        = ""    /*  ที่อยู่ผู้เอาประกันภัย  */
            np_addr5        = ""    /*  ที่อยู่ผู้เอาประกันภัย  */
            np_model        = ""    /*  ยี่ห้อ/รุ่นรถ   */        
            np_vehreg       = ""    /*  ทะเบียนรถ   */            
            np_cha_no       = ""    /*  เลขตัวถัง   */            
            np_engno        = ""    /*  เลขเครื่องยนต์  */        
            np_engCC        = ""    /*  ขนาดเครื่องยนต์ */        
            np_cedpol       = ""    /*  เลขที่สัญญา */            
            np_premt        = ""    /*  ค่าเบี้ยพรบ */            
            np_comdate      = ""    /*  วันที่คุ้มครอง  */        
            np_expdate      = ""  . /*  วันที่สิ้นสุด   */   
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assignwdetail c-Win 
PROCEDURE proc_assignwdetail :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND FIRST wdetail WHERE wdetail.policy  = trim(np_cedpol)   NO-ERROR NO-WAIT.
IF NOT AVAIL wdetail  THEN DO:
    CREATE wdetail .
    ASSIGN 
        wdetail.poltyp     = "V72"       
        wdetail.policy     = trim(np_cedpol)       /*  เลขที่สัญญา */   
        wdetail.brand      = "NISSAN"              
        wdetail.icno       = TRIM(np_icno)         /*  เลขที่บัตรประชาชน   */       
        wdetail.insnam     = trim(np_insurcename)  /*  ชื่อผู้เอาประกันภัย */  
        wdetail.addr1      = trim(np_addr1)       /*  ที่อยู่ผู้เอาประกันภัย  */  
        wdetail.addr2      = trim(np_addr2)       /*  ที่อยู่ผู้เอาประกันภัย  */  
        wdetail.addr3      = trim(np_addr3)       /*  ที่อยู่ผู้เอาประกันภัย  */  
        wdetail.addr4      = trim(np_addr4)       /*  ที่อยู่ผู้เอาประกันภัย  */  
        wdetail.addr5      = trim(np_addr5)       /*  ที่อยู่ผู้เอาประกันภัย  */  
        wdetail.model      = TRIM(np_model)        /*  ยี่ห้อ/รุ่นรถ   */                      
        wdetail.vehreg     = trim(np_vehreg)       /*  ทะเบียนรถ   */    
        wdetail.chasno     = trim(np_cha_no)       /*  เลขตัวถัง   */                      
        wdetail.eng        = trim(np_engno)        /*  เลขเครื่องยนต์  */                
        wdetail.engcc      = TRIM(np_engCC)        /*  ขนาดเครื่องยนต์ */                
        wdetail.tons       = DECI(TRIM(np_engCC)) / 1000
        wdetail.cedpol     = trim(np_cedpol)       
        wdetail.premtnet   = TRIM(np_premt)        /*  ค่าเบี้ยพรบ */ 
        wdetail.comdat     = trim(np_comdate)      /*  วันที่คุ้มครอง  */  
        wdetail.expdat     = trim(np_expdate)      /*  วันที่สิ้นสุด   */ 
        wdetail.subclass   = IF      DECI(TRIM(np_premt)) =  645.21  THEN "110"  
                             ELSE IF DECI(TRIM(np_premt)) = 1182.35  THEN "120A" 
                             ELSE IF DECI(TRIM(np_premt)) =  967.28  THEN "140A" 
                             ELSE IF DECI(TRIM(np_premt)) = 2041.56  THEN "210"  
                             ELSE IF DECI(TRIM(np_premt)) = 2493.10  THEN "220A" 
                             ELSE IF DECI(TRIM(np_premt)) = 3738.58  THEN "220B" 
                             ELSE "" 


        
        .  
END.
 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest1 c-Win 
PROCEDURE proc_chktest1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
-----------------------------------------------------------------------------*/
DEF VAR nv_count1   AS DECI INIT 0. 
DEF VAR nvtiname    AS CHAR . 
DEF VAR nvinsnam1   AS CHAR.
DEF VAR nvinsnam2   AS CHAR.
DEF VAR nv_vehreg   AS CHAR .
DEF VAR nv_vehreg2  AS CHAR .
DEF VAR number_sic  AS INTE INIT 0.

ASSIGN np_chkErr  = NO. 
LOOP_WDETAIL:
FOR EACH wdetail :
    IF  wdetail.policy = ""  THEN NEXT.
    ASSIGN 
        nvtiname   = ""
        nvinsnam1  = ""
        nvinsnam2  = ""
        nvtiname   = wdetail.insnam  
        nv_vehreg  = wdetail.vehreg
        n_rencnt   = 0
        n_endcnt   = 0
        fi_process = "Check data to create " +  wdetail.policy .
    DISP fi_process WITH FRAM fr_main.

    FIND LAST brstat.msgcode WHERE 
        brstat.msgcode.compno       = "999" AND
        index(nvtiname,brstat.msgcode.MsgDesc) > 0  
        NO-LOCK NO-WAIT NO-ERROR.
    IF AVAIL brstat.msgcode THEN DO:
        IF R-INDEX(nvtiname," ") <> INDEX(nvtiname," ") THEN DO:
            ASSIGN 
                nvinsnam2 = trim(SUBSTR(nvtiname,R-INDEX(nvtiname," ")))
                nvtiname  = trim(SUBSTR(nvtiname,1,R-INDEX(nvtiname," ")))
                nvinsnam1 = trim(SUBSTR(nvtiname,LENGTH(brstat.msgcode.MsgDesc) + 1 )) 
                nvtiname  = trim(brstat.msgcode.branch) .
        END.
        ELSE DO:
            ASSIGN 
                nvinsnam1 = trim(SUBSTR(nvtiname,LENGTH(brstat.msgcode.MsgDesc) + 1 )) 
                nvtiname  = trim(brstat.msgcode.branch) .
            IF INDEX(nvinsnam1," ") <> 0  THEN DO:
                ASSIGN 
                    nvinsnam2 = trim(SUBSTR(nvinsnam1,INDEX(nvinsnam1," ")))
                    nvinsnam1 = trim(SUBSTR(nvinsnam1,1,INDEX(nvtiname," "))).
            END.
            ELSE DO: 
                ASSIGN 
                    nvinsnam2 = "".
            END.
        END.
        ASSIGN 
            wdetail.tiname   = nvtiname  
            wdetail.insnam   = nvinsnam1  
            wdetail.insnam2  = nvinsnam2 .
    END.
    ELSE  ASSIGN wdetail.tiname   = "คุณ" . 

    FIND FIRST brstat.insure USE-INDEX Insure05   WHERE    /*use-index fname */
        brstat.insure.compno = "999"   AND
        index(nv_vehreg,brstat.insure.FName) <> 0    NO-LOCK NO-WAIT NO-ERROR.
    IF AVAIL brstat.insure THEN DO:
        ASSIGN 
            nv_vehreg = trim(SUBSTR(nv_vehreg,1,index(nv_vehreg,brstat.insure.FName) - 1))
            nv_vehreg2 = Insure.LName.
        DISP Insure.LName brstat.insure.FName .
    END.
    ELSE DO:
        FIND FIRST brstat.insure USE-INDEX Insure05   WHERE    /*use-index fname */
            brstat.insure.compno = "999"   AND
            index(nv_vehreg,brstat.Insure.LName) <> 0    NO-LOCK NO-WAIT NO-ERROR.
        IF AVAIL brstat.insure THEN DO:
            ASSIGN 
                nv_vehreg  = trim(SUBSTR(nv_vehreg,1,index(nv_vehreg,brstat.Insure.LName) - 1 ))
                nv_vehreg2 = Insure.LName.
            /*DISP Insure.LName brstat.insure.FName .*/
        END.
    END.
    ASSIGN 
        wdetail.vehreg  =  nv_vehreg 
        wdetail.provin  =  nv_vehreg2.
    IF wdetail.tiname = " " THEN  
        ASSIGN wdetail.comment = wdetail.comment + "| Title Name is mandatory field. "
        wdetail.pass           = "N"   
        wdetail.OK_GEN         = "N"
        np_chkErr              = YES . 
    IF wdetail.vehreg = " " THEN  
        ASSIGN wdetail.comment = wdetail.comment + "| Vehicle Register is mandatory field. "
        wdetail.pass           = "N"   
        wdetail.OK_GEN         = "N"
        np_chkErr              = YES . 

END.      /*for each*/
IF np_chkErr        = NO  THEN DO:
    IF NOT CONNECTED("BUInt") THEN DO:
        /***
        loop_sic:
        REPEAT:
            number_sic = number_sic + 1 .
            RUN proc_conBUInt.
            IF  CONNECTED("BUInt") THEN LEAVE loop_sic.
            ELSE IF number_sic > 3 THEN DO:
                MESSAGE "User not connect system BUInt !!! >>>" number_sic  VIEW-AS ALERT-BOX.
                LEAVE loop_sic.
            END.
        END.*/
        /*connect BUInt -H 16.90.20.216 -S 5502 -N TCP -U pdmgr0 -P 95mJbWF. /*Test Internet*/*/
        /*CONNECT -db BUInt -H wsbuint -S buint -N TCP NO-ERROR.                /*Real Product */ *//*Comment A62-0105*/
        /*CONNECT -db BUInt -H tmsth -S buint -N TCP NO-ERROR.                /*Real Product */*/ /*Comment A64-0217*/   
          CONNECT -db BUInt -H TMPMWSDBIP01 -S buint -N TCP NO-ERROR.                /*Real Product */   /*add A64-0217*/       
    END.
    IF  CONNECTED("BUInt") THEN DO:
        DEFINE  VARIABLE  nv_URL             AS CHARACTER NO-UNDO.  /*1 Parameter URL & Database Name*/
        DEFINE  VARIABLE  nv_node-nameHeader AS CHARACTER NO-UNDO.
        DEFINE  VARIABLE  ResponseResult     AS LONGCHAR  NO-UNDO.
        DEFINE  VARIABLE  nv_policyno        AS CHAR INIT "".
        DEFINE  VARIABLE  nv_SavetoFile      AS CHARACTER NO-UNDO.
        FOR EACH wdetail   /*NO-LOCK */
            BREAK BY wdetail.n_branch 
            BY wdetail.cedpol .  
            ASSIGN 
                nv_node-nameHeader = "SendReqPolicy"
                nv_policyno        = wdetail.policy .
            ASSIGN nv_count1 = nv_count1 + 1.
            RUN  wgw\wgwgxml4   (INPUT nv_URL,               
                                 INPUT nv_node-nameHeader,  
                                 INPUT nv_company,
                                 INPUT nv_policyno,     
                                 OUTPUT ResponseResult,    
                                 OUTPUT nv_SavetoFile).
            PAUSE 15 NO-MESSAGE.  /*Add kridtiya i. A59-0170*/
        END.
        /*MESSAGE  "export complete" VIEW-AS ALERT-BOX. */
    END. 
END.
ELSE MESSAGE "พบไฟล์ข้อมูล ERROR กรุณาตรวจสอบไฟล์ก่อนนำเข้าระบบ !!!" VIEW-AS ALERT-BOX. 

/*end...Add Kridtiya i. A58-0356       */
/*MESSAGE nv_count1 VIEW-AS ALERT-BOX. */
/*
DEF VAR  nv_output AS CHAR FORMAT "x(60)".
    nv_output = "U:\nissan_1.slk".
OUTPUT TO VALUE(nv_output).   /*out put file full policy */

    
FOR EACH wdetail   NO-LOCK 
    BREAK BY wdetail.n_branch 
          BY wdetail.cedpol .       
    
    EXPORT DELIMITER "|" 
        wdetail.n_branch       /* 1  ลำดับที่                */   
        wdetail.cedpol   .      /* 2  เลขรับแจ้ง, เลขที่สัญญา */      
                                                                            
           
END.
*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_conBUInt c-Win 
PROCEDURE proc_conBUInt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
FORM
    gv_id  LABEL " User Id " colon 35 SKIP
    nv_pwd LABEL " Password" colon 35 BLANK
    WITH FRAME nf00 CENTERED ROW 10 SIDE-LABELS OVERLAY width 80
    TITLE   " Connect DB BUInt System"  . 
/*HIDE ALL NO-PAUSE.*//*note block*/
STATUS INPUT OFF.
/*
{s0/s0sf1.i}
*/
gv_prgid = "GWNEXP02".

REPEAT:
  pause 0.
  STATUS DEFAULT "F4=EXIT".
  ASSIGN
  gv_id     = ""
  n_user    = "".
  UPDATE gv_id nv_pwd GO-ON(F1 F4) WITH FRAME nf00
  EDITING:
    READKEY.
    IF FRAME-FIELD = "gv_id" AND 
       LASTKEY = KEYCODE("ENTER") OR 
       LASTKEY = KEYCODE("f1") THEN DO:
       
       IF INPUT gv_id = "" THEN DO:
          MESSAGE "User ID. IS NOT BLANK".
          NEXT-PROMPT gv_id WITH FRAME nf00.
          NEXT.
       END.
       gv_id = INPUT gv_id.

    END.
    IF FRAME-FIELD = "nv_pwd" AND 
       LASTKEY = KEYCODE("ENTER") OR 
       LASTKEY = KEYCODE("f1") THEN DO:
       
       nv_pwd = INPUT nv_pwd.
    END.      
    APPLY LASTKEY.
  END.
  ASSIGN n_user = gv_id.

  IF LASTKEY = KEYCODE("F1") OR LASTKEY = KEYCODE("ENTER") THEN DO:
      
      
      /*connect BUInt  -H 16.90.20.203 -S 61760  -N TCP -U value(gv_id) -P value(nv_pwd) NO-ERROR. /*HO STY*/ */

      /*connect BUInt  -H 16.90.20.201  -S 5022  -N TCP -U value(gv_id) -P value(nv_pwd) NO-ERROR.  /*TEST 1 PC        */ */
      /*connect BUInt  -H 16.90.20.216  -S 5502 -N TCP -U value(gv_id) -P value(nv_pwd) NO-ERROR.   /*TEST 2 Internet  */ */
      connect BUInt -H 16.90.20.216 -S 5502 -N TCP -U pdmgr0 -P 95mJbWF. 
      /*CONNECT  -db BUINT -H WSBUINT -S BUINT -N TCP -U value(gv_id) -P value(nv_pwd) .*/


      CLEAR FRAME nf00.
      HIDE FRAME nf00.

      RETURN. 
    
   END.

END.
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_open c-Win 
PROCEDURE proc_open :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
OPEN QUERY br_wdetail FOR EACH wdetail.   /*WHERE wdetail.pass = "y".    */



END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

