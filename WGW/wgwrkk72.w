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
program id   : wgwrkk72.w
program name : Export Text file KK72 excel file and Gen policy 72     
create by    : Kridtiya i. A56-0231  15/07/2013   
copy write   : wuwk72ex.w                                               */
/*Modify by Kridtiya i. A56-0309 ��������ŧ������� �������駧ҹ���� */
/*modity by  : Kridtiya i. A57-0274 �������������ʴ�����Ѻ��Сѹ��� �ú.*/
/*modity by  : Kridtiya i. A57-0434 ������Ҵ��ͧ�����˵بҡ��� 40�� 150 ����ѡ��*/
/*modity by  : Ranu i. A59-0590 �礢����� �ú.�ҡ��ͧ���¾ú.*/
/*modity by  : Ranu i. A60-0232 ��䢡�� matchfile Newfile , new form*/
/*modify by  : Ranu I. A61-0335 ������������Ѻ��Ҩҡ��� */
/*Modify By  : Porntiwa T. A62-0105 Change Head icon*/
/*Modify by  : Kridtiya i. A63-00472 ��Ѻ��ä鹢����Ŵ����Ţ����ѭ�� KeyApp */
/************************************************************************/
CREATE WIDGET-POOL.
/* ***************************  Definitions  ************************** */
/* Parameters Definitions ---                                           */
/* Local Variable Definitions ---                                       */
def  stream ns1.
DEF VAR    num            AS DECI INIT 0.
DEF VAR    expyear        AS DECI FORMAT "9999" .
DEFINE VAR nv_daily       AS CHARACTER FORMAT "X"     INITIAL ","  NO-UNDO.
DEFINE VAR nv_reccnt      AS INT   INIT  0.
DEFINE VAR nv_completecnt AS INT   INIT  0.
DEFINE VAR nv_enttim      AS CHAR  INIT  "".
def    var nv_export      as char  init  ""  format "X(8)".
DEF stream  ns2.
DEFINE NEW SHARED WORKFILE wdetail2 NO-UNDO  
    FIELD id               AS CHAR FORMAT "x(10)"  INIT "" 
    FIELD br_nam           AS CHAR FORMAT "x(30)"  INIT "" 
    FIELD number           AS CHAR FORMAT "x(20)"  INIT "" 
    FIELD polstk           AS CHAR FORMAT "x(20)"  INIT "" 
    FIELD idbranch         AS CHAR FORMAT "x(20)"  INIT "" 
    FIELD branchname       AS CHAR FORMAT "x(20)"  INIT "" 
    FIELD recivedat        AS CHAR FORMAT "x(15)"  INIT "" 
    FIELD cedpol           AS CHAR FORMAT "x(20)"  INIT "" 
    FIELD insurnam         AS CHAR FORMAT "x(60)"  INIT "" 
    FIELD idno             AS CHAR FORMAT "x(20)"  INIT "" 
    FIELD vehreg           AS CHAR FORMAT "x(40)"  INIT "" 
    FIELD brand            AS CHAR FORMAT "x(20)"  INIT "" 
    FIELD model            AS CHAR FORMAT "x(50)"  INIT "" 
    FIELD notifyno         AS CHAR FORMAT "x(30)"  INIT "" 
    FIELD namnotify        AS CHAR FORMAT "x(50)"  INIT "" 
    FIELD chassis          AS CHAR FORMAT "x(30)"  INIT "" 
    FIELD comp             AS CHAR FORMAT "x(20)"  INIT "" 
    FIELD premt            AS CHAR FORMAT "x(20)"  INIT "" 
    FIELD comdat           AS CHAR FORMAT "x(20)"  INIT "" 
    FIELD expdat           AS CHAR FORMAT "x(20)"  INIT "" 
    /*FIELD memmo            AS CHAR FORMAT "x(40)"  INIT ""*/ /*A57-0434*/
    FIELD memmo            AS CHAR FORMAT "x(200)"  INIT ""    /*A57-0434*/
    FIELD adr_no1          AS CHAR FORMAT "x(50)" INIT ""  /* add A56-0309 ��ҹ�Ţ���*/     
    FIELD adr_mu           AS CHAR FORMAT "x(50)" INIT ""  /* add A56-0309 ����     */         
    FIELD adr_muban        AS CHAR FORMAT "x(50)" INIT ""  /* add A56-0309 �����ҹ */     
    FIELD adr_build        AS CHAR FORMAT "x(50)" INIT ""  /* add A56-0309 �Ҥ��    */         
    FIELD adr_soy          AS CHAR FORMAT "x(50)" INIT ""  /* add A56-0309 ���      */             
    FIELD adr_road         AS CHAR FORMAT "x(50)" INIT ""  /* add A56-0309 ���      */             
    FIELD adr_tambon       AS CHAR FORMAT "x(50)" INIT ""  /* add A56-0309 �Ӻ�/�ǧ*/     
    FIELD adr_amper        AS CHAR FORMAT "x(50)" INIT ""  /* add A56-0309 �����/ࢵ*/     
    FIELD adr_country      AS CHAR FORMAT "x(50)" INIT ""  /* add A56-0309 �ѧ��Ѵ  */         
    FIELD adr_post         AS CHAR FORMAT "x(50)" INIT ""  /* add A56-0309 ������ɳ���*/ 
    FIELD ad11             AS CHAR FORMAT "x(150)" INIT "" 
    FIELD ad12             AS CHAR FORMAT "x(40)"  INIT "" 
    FIELD ad13             AS CHAR FORMAT "x(40)"  INIT "" 
    FIELD ad14             AS CHAR FORMAT "x(40)"  INIT "" 
    FIELD veh_country      AS CHAR FORMAT "x(20)"  INIT "" 
    FIELD branch           AS CHAR FORMAT "x(3)"   INIT "" 
    FIELD class            AS CHAR FORMAT "x(4)"   INIT "" 
    FIELD companame        AS CHAR FORMAT "x(50)"  INIT "" 
    FIELD titlenam         AS CHAR FORMAT "x(20)"  INIT "" 
    FIELD sername          AS CHAR FORMAT "x(40)"  INIT "" 
    FIELD telephone        AS CHAR FORMAT "x(20)"  INIT "" 
    FIELD birdthday        AS CHAR FORMAT "x(10)"  INIT "" 
    FIELD occoup           AS CHAR FORMAT "x(40)"  INIT "" 
    FIELD nstatus          AS CHAR FORMAT "x(20)"  INIT "" 
    FIELD idvatno          AS CHAR FORMAT "x(20)"  INIT "" 
    FIELD titlenam01       AS CHAR FORMAT "x(20)"  INIT "" 
    FIELD name01           AS CHAR FORMAT "x(35)"  INIT "" 
    FIELD sernam01         AS CHAR FORMAT "x(40)"  INIT "" 
    FIELD idnonam01        AS CHAR FORMAT "x(15)"  INIT "" 
    FIELD titlenam02       AS CHAR FORMAT "x(20)"  INIT ""  
    FIELD name02           AS CHAR FORMAT "x(35)"  INIT ""  
    FIELD sernam02         AS CHAR FORMAT "x(40)"  INIT ""  
    FIELD idnonam02        AS CHAR FORMAT "x(15)"  INIT "" 
    FIELD titlenam03       AS CHAR FORMAT "x(20)"  INIT ""  
    FIELD name03           AS CHAR FORMAT "x(35)"  INIT ""  
    FIELD sernam03         AS CHAR FORMAT "x(40)"  INIT ""  
    FIELD idnonam03        AS CHAR FORMAT "x(15)"  INIT "" 
    field nsend            as char format "x(50)" init ""  /*A61-0335*/
    field sendname         as char format "x(50)" init ""  /*A61-0335*/
    field kkapp            as char format "x(20)" init ""  /*A61-0335*/
    FIELD stk              AS CHAR FORMAT "x(15)"  INIT "" .   /*A60-0232*/
DEFINE NEW SHARED TEMP-TABLE wdetail
      FIELD number      AS CHAR FORMAT "x(25)" INIT ""  
      FIELD notifyno    AS CHAR FORMAT "x(30)" INIT ""  
      FIELD namnotify   AS CHAR FORMAT "x(50)" INIT ""  
      FIELD recivedat   AS CHAR FORMAT "x(15)" INIT "" 
      FIELD br_nam      AS CHAR FORMAT "x(30)" INIT "" 
      FIELD cedpol      AS CHAR FORMAT "x(20)" INIT ""  
      FIELD branch      AS CHAR FORMAT "x(5)"  INIT "" 
      FIELD entdat      AS CHAR FORMAT "x(10)" INIT ""    
      FIELD enttim      AS CHAR FORMAT "x(8)"  INIT ""    
      FIELD trandat     AS CHAR FORMAT "x(10)" INIT ""   
      FIELD trantim     AS CHAR FORMAT "x(8)"  INIT ""    
      FIELD poltyp      AS CHAR FORMAT "x(3)"  INIT ""    
      FIELD policy      AS CHAR FORMAT "x(20)" INIT ""   
      FIELD renpol      AS CHAR FORMAT "x(16)" INIT ""   
      FIELD comdat      AS CHAR FORMAT "x(10)" INIT ""   
      FIELD expdat      AS CHAR FORMAT "x(10)" INIT ""   
      FIELD compul      AS CHAR FORMAT "x"     INIT ""       
      FIELD tiname      AS CHAR FORMAT "x(15)" INIT ""   
      FIELD insnam      AS CHAR FORMAT "x(50)" INIT ""   
      FIELD idno        AS CHAR FORMAT "x(20)" INIT ""   
      FIELD iadd1       AS CHAR FORMAT "x(35)" INIT ""
      FIELD iadd2       AS CHAR FORMAT "x(35)" INIT ""
      FIELD iadd3       AS CHAR FORMAT "x(34)" INIT ""
      FIELD iadd4       AS CHAR FORMAT "x(20)" INIT ""
      FIELD prempa      AS CHAR FORMAT "x"     INIT ""      
      FIELD subclass    AS CHAR FORMAT "x(4)"  INIT ""     
      FIELD brand       AS CHAR FORMAT "x(30)" INIT ""
      FIELD model       AS CHAR FORMAT "x(50)" INIT ""
      FIELD cc          AS CHAR FORMAT "x(10)" INIT ""
      FIELD weight      AS CHAR FORMAT "x(10)" INIT ""
      FIELD seat        AS CHAR FORMAT "x(2)"  INIT ""
      FIELD body        AS CHAR FORMAT "x(20)" INIT ""
      FIELD vehreg      AS CHAR FORMAT "x(40)" INIT ""     
      FIELD engno       AS CHAR FORMAT "x(20)" INIT ""     
      FIELD chasno      AS CHAR FORMAT "x(20)" INIT ""     
      FIELD caryear     AS CHAR FORMAT "x(4)"  INIT ""      
      FIELD carprovi    AS CHAR FORMAT "x(2)"  INIT ""      
      FIELD vehuse      AS CHAR FORMAT "x"     INIT ""     
      FIELD garage      AS CHAR FORMAT "x"     INIT ""    
      FIELD stk         AS CHAR FORMAT "x(15)" INIT ""    
      FIELD access      AS CHAR FORMAT "x"     INIT ""    
      FIELD covcod      AS CHAR FORMAT "x"     INIT ""    
      FIELD si          AS CHAR FORMAT "x(25)" INIT ""    
      FIELD volprem     AS CHAR FORMAT "x(20)" INIT ""    
      FIELD Compprem    AS CHAR FORMAT "x(20)" INIT ""    
      FIELD fleet       AS CHAR FORMAT "x(10)" INIT ""    
      FIELD ncb         AS CHAR FORMAT "x(10)" INIT "" 
      FIELD loadclm     AS CHAR FORMAT "x(10)" INIT ""    
      FIELD deductda    AS CHAR FORMAT "x(10)" INIT ""    
      FIELD deductpd    AS CHAR FORMAT "x(10)" INIT ""    
      FIELD benname     AS CHAR FORMAT "x(50)" INIT ""    
      FIELD n_user      AS CHAR FORMAT "x(10)" INIT ""    
      FIELD n_IMPORT    AS CHAR FORMAT "x(2)"  INIT ""    
      FIELD n_export    AS CHAR FORMAT "x(2)"  INIT ""    
      FIELD drivnam     AS CHAR FORMAT "x"     INIT ""    
      FIELD drivnam1    AS CHAR FORMAT "x(50)" INIT ""    
      FIELD drivnam2    AS CHAR FORMAT "x(50)" INIT ""    
      FIELD drivbir1    AS CHAR FORMAT "X(10)" INIT ""    
      FIELD drivbir2    AS CHAR FORMAT "X(10)" INIT ""    
      FIELD drivage1    AS CHAR FORMAT "X(2)"  INIT ""    
      FIELD drivage2    AS CHAR FORMAT "x(2)"  INIT ""    
      FIELD cancel      AS CHAR FORMAT "x(2)"  INIT ""    
      FIELD WARNING     AS CHAR FORMAT "X(30)" INIT ""
      FIELD comment     AS CHAR FORMAT "x(35)" INIT ""   
      FIELD cargrp      AS CHAR FORMAT "x(2)"  INIT ""      
      FIELD producer    AS CHAR FORMAT "x(7)"  INIT ""      
      FIELD agent       AS CHAR FORMAT "x(7)"  INIT ""      
      FIELD inscod      AS CHAR INIT ""   
      FIELD premt1      AS CHAR FORMAT "x(20)" INIT ""
      FIELD redbook     AS CHAR INIT "" FORMAT "X(8)"       
      FIELD base        AS CHAR INIT "" FORMAT "x(8)"      
      FIELD accdat      AS CHAR INIT "" FORMAT "x(10)"     
      FIELD docno       AS CHAR INIT "" FORMAT "x(10)"     
      FIELD ICNO        AS CHAR INIT "" FORMAT "x(13)"     
      FIELD CoverNote   AS CHAR INIT "" FORMAT "x(13)"     
      /*FIELD nmember     AS CHAR INIT "" FORMAT "x(100)" */  /*A57-0434*/  
      FIELD nmember     AS CHAR INIT "" FORMAT "x(200)"       /*A57-0434*/ 
      FIELD deler       AS CHAR FORMAT "x(40)" INIT ""     
      FIELD showroom    AS CHAR FORMAT "x(30)" INIT ""     
      FIELD delerco     AS CHAR FORMAT "x(10)" INIT "" 
      FIELD telephone   AS CHAR FORMAT "x(20)"  INIT "" 
      FIELD titlenam01  AS CHAR FORMAT "x(20)"  INIT "" 
      FIELD name01      AS CHAR FORMAT "x(35)"  INIT "" 
      FIELD sernam01    AS CHAR FORMAT "x(40)"  INIT "" 
      FIELD idnonam01   AS CHAR FORMAT "x(15)"  INIT "" 
      FIELD titlenam02  AS CHAR FORMAT "x(20)"  INIT ""  
      FIELD name02      AS CHAR FORMAT "x(35)"  INIT ""  
      FIELD sernam02    AS CHAR FORMAT "x(40)"  INIT ""  
      FIELD idnonam02   AS CHAR FORMAT "x(15)"  INIT "" 
      FIELD titlenam03  AS CHAR FORMAT "x(20)"  INIT ""  
      FIELD name03      AS CHAR FORMAT "x(35)"  INIT ""  
      FIELD sernam03    AS CHAR FORMAT "x(40)"  INIT ""  
      FIELD idnonam03   AS CHAR FORMAT "x(15)"  INIT "" 
      field nsend       as char format "x(50)" init ""  /*A61-0335*/
      field sendname    as char format "x(50)" init ""  /*A61-0335*/
      field kkapp       as char format "x(20)" init ""  /*A61-0335*/.
DEF VAR nv_accdat   AS DATE  FORMAT "99/99/9999"  NO-UNDO.
DEF VAR nv_comdat   AS DATE  FORMAT "99/99/9999"  NO-UNDO.
DEF VAR nv_expdat   AS DATE  FORMAT "99/99/9999"  NO-UNDO.
DEF VAR nv_comchr   AS CHAR  .   
DEF VAR nv_dd       AS INT   FORMAT "99".
DEF VAR nv_mm       AS INT   FORMAT "99".
DEF VAR nv_yy       AS INT   FORMAT "9999".
DEF VAR nv_cpamt1   AS DECI INIT  0.
DEF VAR nv_cpamt2   AS DECI INIT  0.
DEF VAR nv_cpamt3   AS DECI INIT  0.
DEF VAR nv_insamt1  AS DECI INIT  0.
DEF VAR nv_insamt2  AS DECI INIT  0.
DEF VAR nv_insamt3  AS DECI INIT  0.
DEF VAR nv_premt1   AS DECI INIT  0.
DEF VAR nv_premt2   AS DECI INIT  0.
DEF VAR nv_premt3   AS DECI INIT  0.
DEF VAR nv_name1    AS CHAR INIT  ""   Format "X(30)".
DEF VAR nv_ntitle   AS CHAR INIT  ""   Format  "X(10)". 
DEF VAR nv_titleno  AS INT  INIT  0    .
DEF VAR nv_policy   AS CHAR INIT ""  Format  "X(12)".
def var nv_source   as char format  "X(35)".
def var nv_indexno  as int  init  0.
def var nv_indexno1 as int  init  0.
def var nv_cnt      as int  init  0.
def var nv_addr     as char extent 4  format "X(35)".
def var nv_prem     as char init  "".
def VAR nv_file     as char init  "d:\fileload\return.txt".
def var nv_row      as int  init 0.
DEF VAR number      AS INT  INIT 1.
DEFINE VAR  nv_dir_ri    AS LOGICAL                    INIT YES       NO-UNDO.
DEFINE VAR  nv_poltyp    AS CHARACTER   FORMAT "X(3)"  INIT "v72"     NO-UNDO.
DEFINE VAR  nv_branch    AS CHARACTER   FORMAT "X(2)"  INIT "YKK"     NO-UNDO.
DEFINE VAR  nv_undyr     AS CHARACTER   FORMAT "X(4)"  INIT "2013"    NO-UNDO.
DEFINE VAR  nv_acno1     AS CHARACTER   FORMAT "X(10)" INIT "A0M1005" NO-UNDO.
DEFINE VAR  n_policy     AS CHARACTER   FORMAT "X(12)" INIT ""        NO-UNDO.
DEFINE VAR  nv_message   AS CHARACTER   NO-UNDO.  
DEFINE VAR  nv_polno     AS INTEGER     INIT 0          NO-UNDO.
DEFINE VAR  nv_polno70   AS INTEGER     INIT 0          NO-UNDO.
DEFINE VAR  nv_polno72   AS INTEGER     INIT 0          NO-UNDO.
DEFINE VAR  nv_brnpol    AS CHARACTER   INITIAL "" NO-UNDO.
DEFINE VAR  nv_startno   AS CHARACTER   INITIAL "" NO-UNDO.
DEFINE VAR  nv_runsafuw  AS LOGICAL     INITIAL NO NO-UNDO.
DEFINE VAR  nv_undyr2543 AS CHARACTER   FORMAT "X(4)"  NO-UNDO.
DEFINE VAR  nv_polno2543 AS INTEGER     NO-UNDO.
DEFINE VAR  nv_poltyp2   AS CHAR        FORMAT "x(3)" INIT "".

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS rs_form fi_branch fi_underyare fi_poltyp ~
fi_run fi_producer bu_file fi_filename fi_outfile bu_ok bu_exit ~
ra_selectfile RECT-76 RECT-77 RECT-81 
&Scoped-Define DISPLAYED-OBJECTS rs_form fi_branch fi_underyare fi_poltyp ~
fi_run fi_producer fi_filename fi_outfile ra_selectfile 

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
     SIZE 7.5 BY 1
     FONT 6.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 4 BY 1.

DEFINE BUTTON bu_ok 
     LABEL "Ok" 
     SIZE 7.5 BY 1
     FONT 6.

DEFINE VARIABLE fi_branch AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(500)":U 
     VIEW-AS FILL-IN 
     SIZE 75 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_outfile AS CHARACTER FORMAT "X(500)":U 
     VIEW-AS FILL-IN 
     SIZE 80 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_poltyp AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_run AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_underyare AS CHARACTER FORMAT "X(4)":U 
     VIEW-AS FILL-IN 
     SIZE 9 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE ra_selectfile AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "File Old ", 1,
"File NEW ", 2,
"Match Sticker Load 72 ", 3
     SIZE 72 BY 1
     BGCOLOR 8 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE rs_form AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Old Form (KK)", 1,
"New Form (KK72)", 2
     SIZE 64.83 BY 1
     BGCOLOR 19 FGCOLOR 4 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-76
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 113.5 BY 10.48
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-77
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 21.17 BY 1.67
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-81
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 110.33 BY 5.81
     BGCOLOR 8 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     rs_form AT ROW 2.48 COL 19.67 NO-LABEL
     fi_branch AT ROW 5.19 COL 12.17 COLON-ALIGNED NO-LABEL
     fi_underyare AT ROW 5.19 COL 29 COLON-ALIGNED NO-LABEL
     fi_poltyp AT ROW 5.19 COL 46.83 COLON-ALIGNED NO-LABEL
     fi_run AT ROW 5.19 COL 62.17 COLON-ALIGNED NO-LABEL
     fi_producer AT ROW 5.19 COL 78.83 COLON-ALIGNED NO-LABEL
     bu_file AT ROW 6.62 COL 107.33
     fi_filename AT ROW 6.62 COL 29.33 COLON-ALIGNED NO-LABEL
     fi_outfile AT ROW 7.81 COL 29.33 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 9.91 COL 74.5
     bu_exit AT ROW 9.91 COL 83.17
     ra_selectfile AT ROW 3.86 COL 19.33 NO-LABEL
     "Text file name(KK_�ú.) :":30 VIEW-AS TEXT
          SIZE 25 BY 1 AT ROW 6.62 COL 5.83
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "U/W Year :" VIEW-AS TEXT
          SIZE 11 BY 1 AT ROW 5.19 COL 19.5
          BGCOLOR 3 FGCOLOR 0 FONT 6
     "Match Type :" VIEW-AS TEXT
          SIZE 13.33 BY .91 AT ROW 3.95 COL 4.83
          BGCOLOR 3 FGCOLOR 0 FONT 6
     "      Output to excel(.slk) :" VIEW-AS TEXT
          SIZE 25 BY 1 AT ROW 7.81 COL 5.83
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Select Form :" VIEW-AS TEXT
          SIZE 13.33 BY .91 AT ROW 2.52 COL 4.83
          BGCOLOR 19 FGCOLOR 6 FONT 6
     "Running :" VIEW-AS TEXT
          SIZE 9.5 BY 1 AT ROW 5.19 COL 54.33
          BGCOLOR 3 FGCOLOR 0 FONT 6
     "Producer :" VIEW-AS TEXT
          SIZE 11 BY 1 AT ROW 5.19 COL 69.5
          BGCOLOR 3 FGCOLOR 0 FONT 6
     "Export Text file KK-V72":30 VIEW-AS TEXT
          SIZE 95 BY 1.05 AT ROW 1.19 COL 2
          BGCOLOR 10 FGCOLOR 2 FONT 32
     "Pol.Typ:" VIEW-AS TEXT
          SIZE 8 BY 1 AT ROW 5.19 COL 40.5
          BGCOLOR 3 FGCOLOR 0 FONT 6
     "Branch :" VIEW-AS TEXT
          SIZE 9 BY 1 AT ROW 5.19 COL 4.83
          BGCOLOR 3 FGCOLOR 0 FONT 6
     RECT-76 AT ROW 1 COL 1.5
     RECT-77 AT ROW 9.57 COL 72.17
     RECT-81 AT ROW 3.62 COL 2.67
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 114.83 BY 10.62
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
         TITLE              = "Export Text file KK72[Gen policy 72]"
         HEIGHT             = 10.62
         WIDTH              = 114.5
         MAX-HEIGHT         = 12
         MAX-WIDTH          = 155.67
         VIRTUAL-HEIGHT     = 12
         VIRTUAL-WIDTH      = 155.67
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
ON END-ERROR OF C-Win /* Export Text file KK72[Gen policy 72] */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Export Text file KK72[Gen policy 72] */
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
         fi_filename  = cvData.
         ASSIGN 
              
             fi_filename  = cvData
             fi_outfile   = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_SUCCESS" */ + "_load" +
                            STRING(DAY(TODAY),"99")      + 
                            STRING(MONTH(TODAY),"99")    + 
                            STRING(YEAR(TODAY),"9999")      + 
                            SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                            SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + ".csv" .
         DISP fi_filename fi_outfile WITH FRAME fr_main.   
         APPLY "Entry" TO fi_outfile.
         RETURN NO-APPLY.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok C-Win
ON CHOOSE OF bu_ok IN FRAME fr_main /* Ok */
DO:
    IF fi_filename = ""  THEN DO:
        MESSAGE "File Input data is not Empty !!!" VIEW-AS ALERT-BOX.
        APPLY "Entry" TO fi_filename.
        RETURN NO-APPLY.
    END.
    IF fi_outfile = ""  THEN DO:
        MESSAGE "File output data is not Empty !!!" VIEW-AS ALERT-BOX.
        APPLY "Entry" TO fi_outfile.
        RETURN NO-APPLY.
    END.
    For each  wdetail2 :
        DELETE  wdetail2.
    END.
    For each  wdetail :
        DELETE  wdetail.
    END.
    IF ra_selectfile = 1  THEN DO:  /*file old*/
        RUN  pro_importfileold.    
        RUN  Pro_assign.
        RUN  Pro_assign1.
        RUN  Pro_createfile_rel1. /*A61-0355*/
        /*Run  Pro_createfile.*/ /*A61-0355*/
    END.
    ELSE IF ra_selectfile = 3  THEN DO:  /*add A57-0274 ...Match file Sticker load 72*/
        RUN  pro_importfilestk . 
        RUN  Pro_assignstk .    
        RUN  Pro_assignstk1.
        RUN  Pro_createfile_rel1. /*A61-0355*/
        /*Run  Pro_createfilestk. */         /*add A57-0274 ...Match file Sticker load 72*/ /*A61-0355*/
    END.
    ELSE DO:                        /*file new and gen policy 72 kk */
        ASSIGN 
            nv_brnpol  = fi_branch
            nv_undyr   = fi_underyare
            nv_poltyp  = fi_poltyp
            nv_branch  = trim(fi_branch) + TRIM(fi_run)
            nv_acno1   = fi_producer.
        RUN  pro_importfilenew .   
        RUN  Pro_assign_rel.
        RUN  Pro_assign1_rel.
        RUN  Pro_createfile_rel1. /*A60-0232*/
    END.    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_branch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_branch C-Win
ON LEAVE OF fi_branch IN FRAME fr_main
DO:
    fi_branch = INPUT fi_branch.
    DISP fi_branch WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_poltyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_poltyp C-Win
ON LEAVE OF fi_poltyp IN FRAME fr_main
DO:
  fi_poltyp = INPUT fi_poltyp .
  DISP fi_poltyp WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer C-Win
ON LEAVE OF fi_producer IN FRAME fr_main
DO:
    fi_producer = INPUT fi_producer .
    DISP fi_producer WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_run
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_run C-Win
ON LEAVE OF fi_run IN FRAME fr_main
DO:
  fi_run = INPUT fi_run .
  DISP fi_run WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_underyare
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_underyare C-Win
ON LEAVE OF fi_underyare IN FRAME fr_main
DO:
    fi_underyare = INPUT fi_underyare.
    DISP fi_underyare WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_selectfile
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_selectfile C-Win
ON VALUE-CHANGED OF ra_selectfile IN FRAME fr_main
DO:
    ra_selectfile = INPUT ra_selectfile.
    DISP ra_selectfile WITH FRAM fr_main.
    APPLY "entry" TO fi_branch.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rs_form
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rs_form C-Win
ON VALUE-CHANGED OF rs_form IN FRAME fr_main
DO:
    rs_form = INPUT rs_form.
    DISP rs_form WITH FRAME fr_main.
  
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
      rs_form       =  1 /*A59-0590*/
      fi_branch     = "Y"
      fi_underyare  = STRING(YEAR(TODAY))
      fi_poltyp     = "V72"
      fi_run        = "KK"
      fi_producer   = "A0M1005"
      nv_poltyp     = "V72"
      nv_branch     = trim(fi_branch) + TRIM(fi_run)
      nv_undyr      = fi_underyare
      nv_acno1      = fi_producer
      ra_selectfile = 1 
      gv_prgid = "wgwrkk72"
      gv_prog  = "Export File KK(�ú.) to Excel".
  DISP ra_selectfile fi_branch   fi_underyare  fi_poltyp fi_producer fi_branch fi_run rs_form WITH FRAM fr_main.
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).

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
  DISPLAY rs_form fi_branch fi_underyare fi_poltyp fi_run fi_producer 
          fi_filename fi_outfile ra_selectfile 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE rs_form fi_branch fi_underyare fi_poltyp fi_run fi_producer bu_file 
         fi_filename fi_outfile bu_ok bu_exit ra_selectfile RECT-76 RECT-77 
         RECT-81 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cutpolicy C-Win 
PROCEDURE proc_cutpolicy :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_i AS INT.
DEF VAR nv_c AS CHAR.
DEF VAR nv_l AS INT.
DEF VAR nv_p AS CHAR.
DEF VAR ind  AS INT.
ASSIGN 
    nv_c = trim(wdetail2.polstk)
    nv_i = 0 
    nv_l = LENGTH(nv_c).
DO WHILE nv_i <= nv_l:
    ind = 0.
    ind = INDEX(nv_c,"/").
    IF ind <> 0 THEN DO:
        nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
    END.
    ind = INDEX(nv_c,"\").
    IF ind <> 0 THEN DO:
        nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
    END.
    ind = INDEX(nv_c,"-").
    IF ind <> 0 THEN DO:
        nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
    END.
    ind = INDEX(nv_c," ").
    IF ind <> 0 THEN DO:
        nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
    END.
    ind = INDEX(nv_c,".").
    IF ind <> 0 THEN DO:
        nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
    END.
    nv_i = nv_i + 1.
END.
ASSIGN
    wdetail2.polstk = trim(nv_c) .
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cutvehreg C-Win 
PROCEDURE proc_cutvehreg :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_i AS CHAR.
DEF VAR nv_c AS CHAR FORMAT "x(50)".
DEF VAR nv_l AS INT.
DEF VAR nv_p AS CHAR.
DEF VAR ind AS INT.

ASSIGN nv_c = trim(wdetail2.insurnam)
    nv_i = ""
    nv_l = LENGTH(nv_c)
    ind = 0.
IF INDEX(nv_c,"�س") NE  0 THEN 
    ASSIGN  ind = 4 
    wdetail2.insurnam = TRIM(SUBSTR(nv_c,ind,nv_l)).
ELSE IF INDEX(nv_c,"���") NE  0 THEN 
    ASSIGN  ind = 4 
    nv_i = "���"
    wdetail2.insurnam = TRIM(SUBSTR(nv_c,ind,nv_l)).
ELSE IF INDEX(nv_c,"�.�.") NE  0 THEN 
    ASSIGN  ind = 5 
    wdetail2.insurnam = TRIM(SUBSTR(nv_c,ind,nv_l)).
ELSE IF INDEX(nv_c,"�ҧ��� ") NE 0  THEN 
    ASSIGN  ind = 7
    wdetail2.insurnam = TRIM(SUBSTR(nv_c,ind,nv_l)).
ELSE IF INDEX(nv_c,"�ҧ") NE 0  THEN 
    ASSIGN  ind = 4
    wdetail2.insurnam = TRIM(SUBSTR(nv_c,ind,nv_l)).      
nv_c = "".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_vehmat C-Win 
PROCEDURE proc_vehmat :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_vehnew AS CHAR FORMAT "x(40)".
IF SUBSTR(wdetail2.vehreg,1,1) = "/" OR SUBSTR(wdetail2.vehreg,1,1) = "\"  THEN NEXT.
ASSIGN 
    n_vehnew = ""
    n_vehnew = replace(trim(wdetail2.vehreg),"-","")
    n_vehnew = trim(substr(n_vehnew,8,30)).
FIND FIRST brstat.insure USE-INDEX Insure05   WHERE   /*licence  */
    brstat.insure.compno = "999" AND
    index(wdetail2.vehreg,brstat.Insure.fName) <> 0 NO-LOCK NO-WAIT NO-ERROR.
IF AVAIL brstat.insure THEN  
    ASSIGN wdetail2.vehreg = REPLACE(substr(wdetail2.vehreg,1,INDEX(wdetail2.vehreg,Insure.fName) - 1 ),"-","") + " " + TRIM(Insure.LName) .
ELSE DO:
    
        IF SUBSTR(n_vehnew,1,1) = "-"      THEN n_vehnew = SUBSTR(n_vehnew,2,30).
/*1*/   IF      n_vehnew = "��к��"          OR n_vehnew = "��."   THEN n_vehnew = "��".
/*2*/   ELSE IF n_vehnew = "��ا෾��ҹ��"   OR n_vehnew = "��ا෾"  OR n_vehnew = "���."   THEN n_vehnew = "��".
/*3*/   ELSE IF n_vehnew = "�ҭ������"       OR n_vehnew = "��."  THEN n_vehnew = "��".
/*4*/   ELSE IF n_vehnew = "����Թ���"       OR n_vehnew = "��."  THEN n_vehnew = "��".
/*5*/   ELSE IF (n_vehnew = "��ᾧྪ�") OR (n_vehnew = "��.")    THEN n_vehnew = "��".
/*6*/   ELSE IF n_vehnew = "�͹��"         OR n_vehnew = "��."  THEN n_vehnew = "��".
/*7*/   ELSE IF n_vehnew = "�ѹ�����"        OR n_vehnew = "��."  THEN n_vehnew = "��".
/*8*/   ELSE IF n_vehnew = "���ԧ���"      OR n_vehnew = "��."  THEN n_vehnew = "��".
/*9*/   ELSE IF n_vehnew = "�ź���"          OR n_vehnew = "��."  THEN n_vehnew = "��".
/*10*/  ELSE IF n_vehnew = "��¹ҷ"          OR n_vehnew = "��."  THEN n_vehnew = "��".
/*11*/  ELSE IF n_vehnew = "�������"         OR n_vehnew = "��."  THEN n_vehnew = "��".
/*12*/  ELSE IF n_vehnew = "�����"           OR n_vehnew = "��."  THEN n_vehnew = "��".
/*13*/  ELSE IF n_vehnew = "��§���"        OR n_vehnew = "��."  THEN n_vehnew = "��".
/*14*/  ELSE IF n_vehnew = "��§����"       OR n_vehnew = "��."  THEN n_vehnew = "��".
/*15*/  ELSE IF n_vehnew = "��ѧ"            OR n_vehnew = "��."  THEN n_vehnew = "��".
/*16*/  ELSE IF n_vehnew = "��Ҵ"            OR n_vehnew = "��."  THEN n_vehnew = "��".
/*17*/  ELSE IF n_vehnew = "�ҡ"             OR n_vehnew = "��."  THEN n_vehnew = "��".
/*18*/  ELSE IF n_vehnew = "��ù�¡"         OR n_vehnew = "��."  THEN n_vehnew = "��".
/*19*/  ELSE IF n_vehnew = "��û��"          OR n_vehnew = "��."  THEN n_vehnew = "��".
/*20*/  ELSE IF n_vehnew = "��þ��"          OR n_vehnew = "��."  THEN n_vehnew = "��".
/*21*/  ELSE IF n_vehnew = "����Ҫ����"      OR n_vehnew = "��."  THEN n_vehnew = "��".
/*22*/  ELSE IF n_vehnew = "�����ո����Ҫ"   OR n_vehnew = "�������"   OR n_vehnew = "��."  THEN n_vehnew = "��".
/*23*/  ELSE IF (n_vehnew = "������ä�" )    OR (n_vehnew = "��.")  THEN n_vehnew = "��".
/*24*/  ELSE IF n_vehnew = "�������"         OR n_vehnew = "��."  THEN n_vehnew = "��".
/*25*/  ELSE IF n_vehnew = "��Ҹ���"         OR n_vehnew = "��."  THEN n_vehnew = "��".
/*26*/  ELSE IF n_vehnew = "��ҹ"            OR n_vehnew = "��."  THEN n_vehnew = "��".
/*27*/  ELSE IF n_vehnew = "���������"       OR n_vehnew = "��."  THEN n_vehnew = "��".
/*28*/  ELSE IF n_vehnew = "�����ҹ�"        OR n_vehnew = "��."  THEN n_vehnew = "��".
/*29*/  ELSE IF n_vehnew = "��ШǺ���բѹ��" OR n_vehnew = "��."  THEN n_vehnew = "��".
/*30*/  ELSE IF n_vehnew = "��Ҩչ����"      OR n_vehnew = "��."  THEN n_vehnew = "��".
/*31*/  ELSE IF n_vehnew = "�ѵ�ҹ�"         OR n_vehnew = "��."  THEN n_vehnew = "��".
/*32*/  ELSE IF n_vehnew = "��й�������ظ��" OR n_vehnew = "��ظ��" THEN n_vehnew = "��".
/*33*/  ELSE IF n_vehnew = "�����"           OR n_vehnew = "��."   THEN n_vehnew = "��".
/*34*/  ELSE IF n_vehnew = "�ѧ��"           OR n_vehnew = "��."   THEN n_vehnew = "��".
/*35*/  ELSE IF n_vehnew = "�ѷ�ا"          OR n_vehnew = "��."   THEN n_vehnew = "��".
/*36*/  ELSE IF n_vehnew = "�ԨԵ�"          OR n_vehnew = "��."   THEN n_vehnew = "��".
/*37*/  ELSE IF n_vehnew = "��ɳ��š"        OR n_vehnew = "��."   THEN n_vehnew = "��".
/*38*/  ELSE IF n_vehnew = "ྪú���"        OR n_vehnew = "��."   THEN n_vehnew = "��".
/*39*/  ELSE IF n_vehnew = "ྪú�ó�"       OR n_vehnew = "��."   THEN n_vehnew = "��".
/*40*/  ELSE IF n_vehnew = "���"            OR n_vehnew = "��."   THEN n_vehnew = "��".
/*41*/  ELSE IF n_vehnew = "����"          OR n_vehnew = "��."   THEN n_vehnew = "��".
/*42*/  ELSE IF n_vehnew = "�����ä��"       OR n_vehnew = "��."   THEN n_vehnew = "��".
/*43*/  ELSE IF n_vehnew = "�ء�����"        OR  n_vehnew = "��."   THEN n_vehnew = "��".
/*44*/  ELSE IF n_vehnew = "�����ͧ�͹"      OR  n_vehnew = "��."   THEN n_vehnew = "��".
/*45*/  ELSE IF n_vehnew = "����"            OR  n_vehnew = "��."   THEN n_vehnew = "��".
/*46*/  ELSE IF n_vehnew = "�������"        OR  n_vehnew = "��."   THEN n_vehnew = "��".
/*47*/  ELSE IF n_vehnew = "�йͧ"           OR  n_vehnew = "ù."   THEN n_vehnew = "ù".
/*48*/  ELSE IF n_vehnew = "���ͧ"           OR  n_vehnew = "��."  THEN n_vehnew = "��".
/*49*/  ELSE IF n_vehnew = "�Ҫ����"         OR  n_vehnew = "ú."  THEN n_vehnew = "ú".
/*50*/  ELSE IF n_vehnew = "ž����"          OR  n_vehnew = "ź."  THEN n_vehnew = "ź".
/*51*/  ELSE IF n_vehnew = "�ӻҧ"           OR  n_vehnew = "Ż."  THEN n_vehnew = "Ż".
/*52*/  ELSE IF n_vehnew = "�Ӿٹ"           OR  n_vehnew = "ž."  THEN n_vehnew = "ž".
/*53*/  ELSE IF n_vehnew = "���"             OR  n_vehnew = "��."  THEN n_vehnew = "��".
/*54*/  ELSE IF n_vehnew = "�������"        OR  n_vehnew = "ȡ."  THEN n_vehnew = "ȡ".
/*55*/  ELSE IF n_vehnew = "ʡŹ��"          OR  n_vehnew = "ʹ."  THEN n_vehnew = "ʹ".
/*56*/  ELSE IF n_vehnew = "ʧ���"           OR  n_vehnew = "ʢ."  THEN n_vehnew = "ʢ".
/*57*/  ELSE IF n_vehnew = "������"         OR  n_vehnew = "ʡ."  THEN n_vehnew = "ʡ".
/*58*/  ELSE IF n_vehnew = "��к���"         OR  n_vehnew = "ʺ."  THEN n_vehnew = "ʺ".
/*59*/  ELSE IF n_vehnew = "�ԧ�����"       OR  n_vehnew = "��."  THEN n_vehnew = "��".
/*60*/  ELSE IF n_vehnew = "��⢷��"         OR  n_vehnew = "ʷ"  THEN n_vehnew = "ʷ".
/*61*/  ELSE IF n_vehnew = "�ؾ�ó����"      OR  n_vehnew = "ʾ."  THEN n_vehnew = "ʾ".
/*62*/  ELSE IF (n_vehnew = "����ɮ��ҹ�" ) OR (n_vehnew = "����ɯ��") OR
                (n_vehnew = "ʮ." )          OR (n_vehnew = "����ɯ��ҹ�") THEN n_vehnew = "ʮ".
/*63*/  ELSE IF n_vehnew = "���Թ���"        OR n_vehnew = "��."  THEN n_vehnew = "��".
/*64*/  ELSE IF n_vehnew = "˹ͧ���"         OR n_vehnew = "��."  THEN n_vehnew = "��".
/*65*/  ELSE IF n_vehnew = "˹ͧ�������"     OR n_vehnew = "��."  THEN n_vehnew = "��".
/*66*/  ELSE IF n_vehnew = "��ҧ�ͧ"         OR n_vehnew = "ͷ."  THEN n_vehnew = "ͷ".
/*67*/  ELSE IF n_vehnew = "�ӹҨ��ԭ"      OR n_vehnew = "ͨ."  THEN n_vehnew = "ͨ".
/*68*/  ELSE IF n_vehnew = "�شøҹ�"        OR n_vehnew = "ʹ."  THEN n_vehnew = "ʹ".
/*69*/  ELSE IF n_vehnew = "�صôԵ��"       OR n_vehnew = "͵."  THEN n_vehnew = "͵".
/*70*/  ELSE IF n_vehnew = "�ط�¸ҹ�"       OR n_vehnew = "͹."  THEN n_vehnew = "͹".
/*71*/  ELSE IF n_vehnew = "�غ��Ҫ�ҹ�"     OR n_vehnew = "ͺ."  THEN n_vehnew = "ͺ".
/*72*/  ELSE IF n_vehnew = "��ʸ�"           OR n_vehnew = "��."  THEN n_vehnew = "��".
/*73*/  ELSE IF n_vehnew = "ʵ��"            OR n_vehnew = "ʵ."  THEN n_vehnew = "ʵ".
/*74*/  ELSE IF n_vehnew = "����û�ҡ��"     OR n_vehnew = "ʻ."  THEN n_vehnew = "ʻ".
/*75*/  ELSE IF n_vehnew = "�����ʧ����"     OR n_vehnew = "��."  THEN n_vehnew = "��".
/*76*/  ELSE IF n_vehnew = "������Ҥ�"       OR n_vehnew = "ʤ."  THEN n_vehnew = "ʤ".
        IF R-INDEX(wdetail2.vehreg,"-") <> 0 THEN 
            ASSIGN wdetail2.vehreg = substr(wdetail2.vehreg,1,R-INDEX(wdetail2.vehreg,"-") - 1 ) + " " + n_vehnew .
        ASSIGN  wdetail2.vehreg = substr(wdetail2.vehreg,1,7) + " " + n_vehnew .
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_assign C-Win 
PROCEDURE Pro_assign :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_dayno AS DECI init 0 .
FOR EACH wdetail2.
    IF            wdetail2.id            = "" THEN DELETE wdetail2.
    ELSE IF INDEX(wdetail2.id,"�ӴѺ")  <> 0  THEN DELETE wdetail2.
    ELSE IF INDEX(wdetail2.id,"�Ţ���") <> 0  THEN DELETE wdetail2.
    ELSE DO:
        IF wdetail2.br_nam <> ""   THEN ASSIGN wdetail2.br_nam = trim(REPLACE(wdetail2.br_nam,"�Ң�","")).
        IF wdetail2.cedpol NE "" THEN DO:
            /*������ ��������� ����Ң� ��Ҥ�����õԹҤԹ */
            FIND FIRST stat.insure USE-INDEX insure03  WHERE 
                stat.insure.compno = "kk"              AND
                stat.insure.fname  = wdetail2.br_nam   NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL insure THEN
                ASSIGN 
                wdetail2.branch = stat.insure.branch 
                wdetail2.ad11   = insure.Addr1
                wdetail2.ad12   = insure.Addr2
                wdetail2.ad13   = insure.Addr3
                wdetail2.ad14   = insure.Addr4 .
            ELSE ASSIGN   wdetail2.branch = ""
                wdetail2.ad11 = ""
                wdetail2.ad12 = ""
                wdetail2.ad13 = ""
                wdetail2.ad14 = ""  .
        END.
        ASSIGN  n_dayno = date(wdetail2.expdat) - date(wdetail2.comdat) 
            n_dayno    = n_dayno / 365.
        IF n_dayno GE 1  THEN DO:  /* 1 �բ��� */
            IF deci(wdetail2.comp) LE 1099  THEN DO: 
                IF deci(wdetail2.comp) LE 899 THEN DO: 
                    IF deci(wdetail2.comp) LE 599 THEN ASSIGN wdetail2.class = "110".
                    ELSE ASSIGN wdetail2.class = "110".
                END.
                ELSE ASSIGN wdetail2.class = "140A".
            END.
            ELSE ASSIGN wdetail2.class = "120A". 
        END.
        ELSE DO:  /* ���֧ �� 1 */
            IF deci(wdetail2.comp) LE 1100  THEN DO: 
                IF deci(wdetail2.comp) LE 900 THEN DO: 
                    IF deci(wdetail2.comp) LE 600 THEN ASSIGN wdetail2.class = "110".
                    ELSE ASSIGN wdetail2.class = "140A".
                END.
                ELSE ASSIGN wdetail2.class = "120A".
            END.
            ELSE ASSIGN wdetail2.class = "120A". 
        END.
        /*RUN proc_cutvehreg.*/
        FIND FIRST brstat.msgcode WHERE 
            brstat.msgcode.compno  = "999" AND
            INDEX(wdetail2.insurnam,brstat.msgcode.MsgDesc) <> 0   NO-LOCK NO-WAIT NO-ERROR.
        IF AVAIL brstat.msgcode THEN  
            ASSIGN 
            wdetail2.titlenam   = trim(brstat.msgcode.branch)
            wdetail2.insurnam   = trim(substr(wdetail2.insurnam,LENGTH(brstat.msgcode.MsgDesc) + 1 )).
        ELSE 
            ASSIGN wdetail2.titlenam   = "�س".
        RUN proc_vehmat.
        RUN proc_cutpolicy.
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_assign1 C-Win 
PROCEDURE Pro_assign1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_length AS INT INIT 0 .
FOR EACH wdetail2 .
    IF wdetail2.id NE "" THEN DO:
        IF rs_form = 1 THEN DO: /*A59-0590*/
            FIND FIRST wdetail WHERE wdetail.policy = wdetail2.polstk NO-ERROR NO-WAIT.
            IF NOT AVAIL wdetail THEN DO:
                CREATE wdetail.
                ASSIGN
                    wdetail.brand       = trim(wdetail2.brand)
                    wdetail.poltyp      = "72" 
                    wdetail.policy      = wdetail2.polstk           
                    wdetail.comdat      = IF (deci(substr(wdetail2.comdat,1,1)) GE 0) AND (deci(substr(wdetail2.comdat,1,1)) LE 9) THEN wdetail2.comdat ELSE ""  
                    wdetail.expdat      = IF (deci(substr(wdetail2.expdat,1,1)) GE 0) AND (deci(substr(wdetail2.expdat,1,1)) LE 9) THEN wdetail2.expdat ELSE ""  
                    wdetail.tiname      = trim(wdetail2.titlenam)
                    wdetail.insnam      = trim(wdetail2.insurnam)
                    wdetail.idno        = TRIM(wdetail2.idno)   
                    wdetail.iadd1       = trim(wdetail2.ad11)
                    wdetail.iadd2       = trim(wdetail2.ad12)
                    wdetail.iadd3       = trim(wdetail2.ad13)
                    wdetail.iadd4       = trim(wdetail2.ad14)
                    wdetail.subclass    = trim(wdetail2.class)
                    wdetail.model       = trim(wdetail2.model) 
                    wdetail.cc          = ""                                                                   
                    wdetail.vehreg      = trim(wdetail2.vehreg)                                  
                    wdetail.engno       = ""                             
                    wdetail.chasno      = wdetail2.chassis                                    
                    wdetail.vehuse      = "1"                                                     
                    wdetail.garage      = ""                                                      
                    wdetail.stk         = IF substr(trim(wdetail2.number),1,1) = "0" THEN   trim(wdetail2.number) ELSE "0"  + TRIM(wdetail2.number)                                     
                    wdetail.covcod      = "T"                                                              
                    wdetail.si          = ""                                                                 
                    /*wdetail.branch      = wdetail2.branch *//*Kridtiya i. A54-0049 */
                    wdetail.branch      = "Y"                 /*Kridtiya i. A54-0049 */
                    wdetail.benname     = "��Ҥ�� ���õԹҤԹ �ӡѴ (��Ҫ�)"                         
                    wdetail.volprem     = wdetail2.comp                                                    
                    wdetail.premt1      = wdetail2.premt        /*�������*/    
                    wdetail.comment     = ""                                                            
                    wdetail.delerco     = ""   /*wdetail2.cc �纤�� vatcode*/                     
                    wdetail.entdat      = string(TODAY)             /*entry date*/                 
                    wdetail.enttim      = STRING(TIME, "HH:MM:SS")  /*entry time*/                 
                    wdetail.trandat     = STRING(TODAY)             /*tran date*/                  
                    wdetail.trantim     = STRING(TIME, "HH:MM:SS")  /*tran time*/                  
                    wdetail.n_IMPORT    = "IM"                                                     
                    wdetail.n_EXPORT    = ""                                                       
                    wdetail.number      = wdetail2.number                                          
                    wdetail.cedpol      = wdetail2.cedpol                                          
                    wdetail.recivedat   = wdetail2.recivedat        /*�ѹ��� �Ѻ���Ф�Ҿú. */     
                    wdetail.br_nam      = wdetail2.br_nam           /*�Ң�*/                       
                    wdetail.notifyno    = wdetail2.notifyno         /*�Ţ����Ѻ��*/              
                    wdetail.namnotify   = wdetail2.namnotify        /*����� (Mkt)*/              
                    wdetail.nmember     = wdetail2.memmo .          /*�����˵�/�ѹ����͡�ú.*/     
                END.  /*if avail*/
        END. /*A59-0590*/
        /*-- Create by A59-0590 -----*/
        ELSE DO:
            FIND FIRST wdetail WHERE wdetail.policy = "72" + trim(wdetail2.cedpol) NO-ERROR NO-WAIT.
            IF NOT AVAIL wdetail THEN DO:
                CREATE wdetail.
                ASSIGN
                    wdetail.brand       = trim(wdetail2.brand)
                    wdetail.poltyp      = "72" 
                    wdetail.policy      = "72" + trim(wdetail2.cedpol)         
                    wdetail.comdat      = IF (deci(substr(wdetail2.comdat,1,1)) GE 0) AND (deci(substr(wdetail2.comdat,1,1)) LE 9) THEN wdetail2.comdat ELSE ""  
                    wdetail.expdat      = IF (deci(substr(wdetail2.expdat,1,1)) GE 0) AND (deci(substr(wdetail2.expdat,1,1)) LE 9) THEN wdetail2.expdat ELSE ""  
                    wdetail.tiname      = trim(wdetail2.titlenam)
                    wdetail.insnam      = trim(wdetail2.insurnam)
                    wdetail.idno        = TRIM(wdetail2.idno)   
                    wdetail.iadd1       = trim(wdetail2.ad11)
                    wdetail.iadd2       = trim(wdetail2.ad12)
                    wdetail.iadd3       = trim(wdetail2.ad13)
                    wdetail.iadd4       = trim(wdetail2.ad14)
                    wdetail.subclass    = trim(wdetail2.class)
                    wdetail.model       = trim(wdetail2.model) 
                    wdetail.cc          = ""                                                                   
                    wdetail.vehreg      = trim(wdetail2.vehreg)                                  
                    wdetail.engno       = ""                             
                    wdetail.chasno      = wdetail2.chassis                                    
                    wdetail.vehuse      = "1"                                                     
                    wdetail.garage      = ""                                                      
                    wdetail.stk         = ""                                     
                    wdetail.covcod      = "T"                                                              
                    wdetail.si          = ""                                                                 
                    wdetail.branch      = wdetail2.branch 
                    wdetail.benname     = "��Ҥ�� ���õԹҤԹ �ӡѴ (��Ҫ�)"                         
                    wdetail.volprem     = wdetail2.comp                                                    
                    wdetail.premt1      = wdetail2.premt        /*�������*/    
                    wdetail.comment     = ""                                                            
                    wdetail.delerco     = ""   /*wdetail2.cc �纤�� vatcode*/                     
                    wdetail.entdat      = string(TODAY)             /*entry date*/                 
                    wdetail.enttim      = STRING(TIME, "HH:MM:SS")  /*entry time*/                 
                    wdetail.trandat     = STRING(TODAY)             /*tran date*/                  
                    wdetail.trantim     = STRING(TIME, "HH:MM:SS")  /*tran time*/                  
                    wdetail.n_IMPORT    = "IM"                                                     
                    wdetail.n_EXPORT    = ""                                                       
                    wdetail.number      = wdetail2.number                                          
                    wdetail.cedpol      = wdetail2.cedpol                                          
                    wdetail.recivedat   = wdetail2.recivedat        /*�ѹ��� �Ѻ���Ф�Ҿú. */     
                    wdetail.br_nam      = wdetail2.br_nam           /*�Ң�*/                       
                    wdetail.notifyno    = wdetail2.notifyno         /*�Ţ����Ѻ��*/              
                    wdetail.namnotify   = wdetail2.namnotify        /*����� (Mkt)*/              
                    wdetail.nmember     = wdetail2.memmo .          /*�����˵�/�ѹ����͡�ú.*/     
                END.  /*if avail*/

        END.
        /*--- end A59-0590 ----*/
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_assign1_rel C-Win 
PROCEDURE Pro_assign1_rel :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_length AS INT.
FOR EACH wdetail2 WHERE wdetail2.id NE ""    NO-LOCK .
    IF rs_form = 1 THEN DO: /*A59-0590*/
        FIND FIRST wdetail WHERE wdetail.policy = trim(wdetail2.polstk)    NO-ERROR NO-WAIT.
        IF NOT AVAIL wdetail THEN DO:
            CREATE wdetail.
            ASSIGN
                wdetail.policy      = trim(wdetail2.polstk)  
                wdetail.brand       = trim(wdetail2.brand)
                wdetail.poltyp      = "72" 
                wdetail.comdat      = IF (deci(substr(wdetail2.comdat,1,1)) GE 0) AND (deci(substr(wdetail2.comdat,1,1)) LE 9) THEN wdetail2.comdat ELSE ""  
                wdetail.expdat      = IF (deci(substr(wdetail2.expdat,1,1)) GE 0) AND (deci(substr(wdetail2.expdat,1,1)) LE 9) THEN wdetail2.expdat ELSE ""  
                wdetail.tiname      = trim(wdetail2.titlenam)
                wdetail.insnam      = trim(wdetail2.insurnam)  + " " +  trim(wdetail2.sername)  
                wdetail.idno        = TRIM(wdetail2.idno)  
                wdetail.iadd1       = trim(wdetail2.ad11)
                wdetail.iadd2       = trim(wdetail2.ad12)
                wdetail.iadd3       = TRIM(wdetail2.ad13)
                wdetail.iadd4       = trim(wdetail2.ad14)
                wdetail.subclass    = trim(wdetail2.class)
                wdetail.model       = TRIM(wdetail2.model) 
                wdetail.cc          = ""                                                                   
                wdetail.vehreg      = trim(wdetail2.vehreg)                                  
                wdetail.engno       = ""                             
                wdetail.chasno      = TRIM(wdetail2.chassis)                                    
                wdetail.vehuse      = "1"                                                     
                wdetail.garage      = ""                                                      
                wdetail.stk         = trim(wdetail2.stk)                                 
                wdetail.covcod      = "T"                                                             
                wdetail.si          = ""  
                wdetail.branch      = "Y"                 
                wdetail.benname     = ""                         
                wdetail.volprem     = wdetail2.comp                                                    
                wdetail.premt1      = wdetail2.premt          
                wdetail.comment     = ""                                                            
                wdetail.delerco     = ""                          
                wdetail.entdat      = string(TODAY)                /*entry date*/              
                wdetail.enttim      = STRING (TIME, "HH:MM:SS")    /*entry time*/              
                wdetail.trandat     = STRING (TODAY)               /*tran date*/          
                wdetail.trantim     = STRING (TIME, "HH:MM:SS")    /*tran time*/
                wdetail.n_IMPORT    = "IM"
                wdetail.n_EXPORT    = "" 
                wdetail.number      = trim(wdetail2.number)
                wdetail.cedpol      = trim(wdetail2.cedpol)
                wdetail.recivedat   = TRIM(wdetail2.recivedat)    /*�ѹ��� �Ѻ���Ф�Ҿú. */
                wdetail.br_nam      = trim(wdetail2.idbranch) + "-" +   
                                      trim(wdetail2.branchname) 
                                      /*trim(wdetail2.br_nam) */      /*�Ң�*/ 
                wdetail.notifyno    = trim(wdetail2.notifyno)     /*�Ţ����Ѻ��*/ 
                wdetail.namnotify   = TRIM(wdetail2.namnotify)    /*����� (Mkt)*/ 
                wdetail.nmember     = trim(wdetail2.memmo)       /*�����˵�/�ѹ����͡�ú.*/ 
                 /*A60-0232*/
                wdetail.telephone   = trim(wdetail2.telephone) 
                wdetail.titlenam01  = trim(wdetail2.titlenam01) 
                wdetail.name01      = trim(wdetail2.name01) 
                wdetail.sernam01    = trim(wdetail2.sernam01) 
                wdetail.idnonam01   = trim(wdetail2.idnonam01) 
                wdetail.titlenam02  = trim(wdetail2.titlenam02) 
                wdetail.name02      = trim(wdetail2.name02) 
                wdetail.sernam02    = trim(wdetail2.sernam02) 
                wdetail.idnonam02   = trim(wdetail2.idnonam02) 
                wdetail.titlenam03  = trim(wdetail2.titlenam03) 
                wdetail.name03      = trim(wdetail2.name03) 
                wdetail.sernam03    = trim(wdetail2.sernam03) 
                wdetail.idnonam03   = trim(wdetail2.idnonam03) 
                wdetail.nsend       = TRIM(wdetail2.nsend)         /* A61-0335*/  
                wdetail.sendname    = TRIM(wdetail2.sendname)      /* A61-0335*/  
                wdetail.kkapp       = TRIM(wdetail2.kkapp).        /*A61-0335*/
                /* End : A60-0232*/                                
        END.   /*if avail*/
    END. /* A59-0590 */
    /*-- Create by A59-0590 -----*/
    ELSE DO:
        FIND FIRST wdetail WHERE wdetail.policy = "72" + trim(wdetail2.cedpol) NO-ERROR NO-WAIT.
        IF NOT AVAIL wdetail THEN DO:
            CREATE wdetail.
            ASSIGN
                wdetail.brand       = trim(wdetail2.brand)
                wdetail.poltyp      = "72" 
                wdetail.policy      = "72" + trim(wdetail2.cedpol)         
                wdetail.comdat      = IF (deci(substr(wdetail2.comdat,1,1)) GE 0) AND (deci(substr(wdetail2.comdat,1,1)) LE 9) THEN wdetail2.comdat ELSE ""  
                wdetail.expdat      = IF (deci(substr(wdetail2.expdat,1,1)) GE 0) AND (deci(substr(wdetail2.expdat,1,1)) LE 9) THEN wdetail2.expdat ELSE ""  
                wdetail.tiname      = trim(wdetail2.titlenam)
                wdetail.insnam      = trim(wdetail2.insurnam) + " " +  trim(wdetail2.sername)
                wdetail.idno        = TRIM(wdetail2.idno)   
                wdetail.iadd1       = trim(wdetail2.ad11)
                wdetail.iadd2       = trim(wdetail2.ad12)
                wdetail.iadd3       = trim(wdetail2.ad13)
                wdetail.iadd4       = trim(wdetail2.ad14)
                wdetail.subclass    = trim(wdetail2.class)
                wdetail.model       = trim(wdetail2.model) 
                wdetail.cc          = ""                                                                   
                wdetail.vehreg      = trim(wdetail2.vehreg)                                  
                wdetail.engno       = ""                             
                wdetail.chasno      = wdetail2.chassis                                    
                wdetail.vehuse      = "1"                                                     
                wdetail.garage      = ""                                                      
                wdetail.stk         = ""                                   
                wdetail.covcod      = "T"                                                              
                wdetail.si          = ""                                                                 
                wdetail.branch      = wdetail2.branch 
                wdetail.benname     = ""                         
                wdetail.volprem     = wdetail2.comp                                                    
                wdetail.premt1      = wdetail2.premt        /*�������*/    
                wdetail.comment     = ""                                                            
                wdetail.delerco     = ""   /*wdetail2.cc �纤�� vatcode*/                     
                wdetail.entdat      = string(TODAY)             /*entry date*/                 
                wdetail.enttim      = STRING(TIME, "HH:MM:SS")  /*entry time*/                 
                wdetail.trandat     = STRING(TODAY)             /*tran date*/                  
                wdetail.trantim     = STRING(TIME, "HH:MM:SS")  /*tran time*/                  
                wdetail.n_IMPORT    = "IM"                                                     
                wdetail.n_EXPORT    = ""                                                       
                wdetail.number      = wdetail2.number                                          
                wdetail.cedpol      = wdetail2.cedpol                                          
                wdetail.recivedat   = wdetail2.recivedat        /*�ѹ��� �Ѻ���Ф�Ҿú. */     
                wdetail.br_nam      = trim(wdetail2.idbranch) + "-" +   
                                      trim(wdetail2.branchname)          /*�Ң�*/                       
                wdetail.notifyno    = wdetail2.notifyno         /*�Ţ����Ѻ��*/              
                wdetail.namnotify   = wdetail2.namnotify        /*����� (Mkt)*/              
                wdetail.nmember     = wdetail2.memmo          /*�����˵�/�ѹ����͡�ú.*/  
                /*A60-0232*/
                wdetail.telephone   = trim(wdetail2.telephone) 
                wdetail.titlenam01  = trim(wdetail2.titlenam01) 
                wdetail.name01      = trim(wdetail2.name01) 
                wdetail.sernam01    = trim(wdetail2.sernam01) 
                wdetail.idnonam01   = trim(wdetail2.idnonam01) 
                wdetail.titlenam02  = trim(wdetail2.titlenam02) 
                wdetail.name02      = trim(wdetail2.name02) 
                wdetail.sernam02    = trim(wdetail2.sernam02) 
                wdetail.idnonam02   = trim(wdetail2.idnonam02) 
                wdetail.titlenam03  = trim(wdetail2.titlenam03) 
                wdetail.name03      = trim(wdetail2.name03) 
                wdetail.sernam03    = trim(wdetail2.sernam03) 
                wdetail.idnonam03   = trim(wdetail2.idnonam03) 
                /* End : A60-0232*/
                wdetail.nsend       = TRIM(wdetail2.nsend)         /* A61-0335*/ 
                wdetail.sendname    = TRIM(wdetail2.sendname)      /* A61-0335*/ 
                wdetail.kkapp       = TRIM(wdetail2.kkapp).        /*A61-0335*/  

            END.  /*if avail*/
    END.
    /*--- end A59-0590 ----*/
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_assignstk C-Win 
PROCEDURE Pro_assignstk :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_dayno AS DECI init 0 .
FOR EACH wdetail2.
    IF            wdetail2.id            = "" THEN DELETE wdetail2.
    ELSE IF INDEX(wdetail2.id,"�ӴѺ")  <> 0  THEN DELETE wdetail2.
    ELSE IF INDEX(wdetail2.id,"�Ţ���") <> 0  THEN DELETE wdetail2.
    ELSE DO:
        /*-- create By A59-0590 --*/
        IF rs_form = 2 THEN DO:
            IF wdetail2.id <> "" THEN DO:
                IF LENGTH(wdetail2.id) = 2 THEN ASSIGN wdetail2.id = "00" + wdetail2.id .
                FIND FIRST stat.insure USE-INDEX insure03  WHERE 
                    stat.insure.compno = "KK"              AND
                    stat.insure.insno  = trim(wdetail2.id)   NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL insure THEN
                    ASSIGN wdetail2.branch = stat.insure.branch .
                ELSE ASSIGN   wdetail2.branch = "".
            END.
        END.
        ELSE ASSIGN   wdetail2.branch = "".
        /*--- end A59-0590---*/
        IF wdetail2.br_nam <> ""   THEN ASSIGN wdetail2.br_nam = trim(REPLACE(wdetail2.br_nam,"�Ң�","")).
        IF wdetail2.cedpol NE "" THEN DO:
            /*������ ��������� ����Ң� ��Ҥ�����õԹҤԹ */
            /*FIND FIRST stat.insure USE-INDEX insure03  WHERE 
                stat.insure.compno = "kk"              AND
                stat.insure.fname  = wdetail2.br_nam   NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL insure THEN
                ASSIGN 
                wdetail2.branch = stat.insure.branch 
                wdetail2.ad11   = insure.Addr1
                wdetail2.ad12   = insure.Addr2
                wdetail2.ad13   = insure.Addr3
                wdetail2.ad14   = insure.Addr4 .
            ELSE ASSIGN   wdetail2.branch = ""
                wdetail2.ad11 = ""
                wdetail2.ad12 = ""
                wdetail2.ad13 = ""
                wdetail2.ad14 = ""  .*/
        END.
        ASSIGN n_dayno = date(wdetail2.expdat) - date(wdetail2.comdat) 
               n_dayno = n_dayno / 365.
        IF wdetail2.premt <> ""  THEN DO:
            IF      deci(wdetail2.premt) = 97.37   THEN  ASSIGN wdetail2.class = "406"  wdetail2.comp = "90.00".
            ELSE IF deci(wdetail2.premt) = 161.57  THEN  ASSIGN wdetail2.class = "130A" wdetail2.comp = "150.00".  
            ELSE IF deci(wdetail2.premt) = 323.14  THEN  ASSIGN wdetail2.class = "130B" wdetail2.comp = "300.00".  
            ELSE IF deci(wdetail2.premt) = 430.14  THEN  ASSIGN wdetail2.class = "130C" wdetail2.comp = "400.00".  
            ELSE IF deci(wdetail2.premt) = 430.14  THEN  ASSIGN wdetail2.class = "170B" wdetail2.comp = "400.00".  
            ELSE IF deci(wdetail2.premt) = 430.14  THEN  ASSIGN wdetail2.class = "171"  wdetail2.comp = "400.00".  
            ELSE IF deci(wdetail2.premt) = 645.21  THEN  ASSIGN wdetail2.class = "110"  wdetail2.comp = "600.00".  
            ELSE IF deci(wdetail2.premt) = 773.61  THEN  ASSIGN wdetail2.class = "170A" wdetail2.comp = "720.00".  
            ELSE IF deci(wdetail2.premt) = 828.18  THEN  ASSIGN wdetail2.class = "407"  wdetail2.comp = "770.00".  
            ELSE IF deci(wdetail2.premt) = 967.28  THEN  ASSIGN wdetail2.class = "140A" wdetail2.comp = "900.00".  
            ELSE IF deci(wdetail2.premt) = 1182.35 THEN  ASSIGN wdetail2.class = "120A" wdetail2.comp = "1100.00".  
            ELSE IF deci(wdetail2.premt) = 1310.75 THEN  ASSIGN wdetail2.class = "140B" wdetail2.comp = "1220.00".  
            ELSE IF deci(wdetail2.premt) = 1408.12 THEN  ASSIGN wdetail2.class = "140C" wdetail2.comp = "1310.00".  
            ELSE IF deci(wdetail2.premt) = 1644.59 THEN  ASSIGN wdetail2.class = "401"  wdetail2.comp = "1530.00".  
            ELSE IF deci(wdetail2.premt) = 1805.09 THEN  ASSIGN wdetail2.class = "142A" wdetail2.comp = "1680.00".  
            ELSE IF deci(wdetail2.premt) = 1826.49 THEN  ASSIGN wdetail2.class = "140D" wdetail2.comp = "1700.00".  
            ELSE IF deci(wdetail2.premt) = 2203.13 THEN  ASSIGN wdetail2.class = "120B" wdetail2.comp = "2050.00".  
            ELSE IF deci(wdetail2.premt) = 2493.10 THEN  ASSIGN wdetail2.class = "142B" wdetail2.comp = "2320.00".  
            ELSE IF deci(wdetail2.premt) = 2546.60 THEN  ASSIGN wdetail2.class = "150"  wdetail2.comp = "2370.00".  
            ELSE IF deci(wdetail2.premt) = 3437.91 THEN  ASSIGN wdetail2.class = "120C" wdetail2.comp = "3200.00".  
            ELSE IF deci(wdetail2.premt) = 4017.85 THEN  ASSIGN wdetail2.class = "120D" wdetail2.comp = "3740.00". 
            ELSE IF deci(wdetail2.premt) = 97.37         THEN  ASSIGN wdetail2.class = "406"   wdetail2.comp = "90.00".   
            ELSE IF deci(wdetail2.premt) = 161.57        THEN  ASSIGN wdetail2.class = "230A"  wdetail2.comp = "150.00".   
            ELSE IF deci(wdetail2.premt) = 161.57        THEN  ASSIGN wdetail2.class = "330A"  wdetail2.comp = "150.00".   
            ELSE IF deci(wdetail2.premt) = 376.64        THEN  ASSIGN wdetail2.class = "230B"  wdetail2.comp = "350.00".   
            ELSE IF deci(wdetail2.premt) = 376.64        THEN  ASSIGN wdetail2.class = "330B"  wdetail2.comp = "350.00".   
            ELSE IF deci(wdetail2.premt) = 430.14        THEN  ASSIGN wdetail2.class = "230C"  wdetail2.comp = "400.00".   
            ELSE IF deci(wdetail2.premt) = 430.14        THEN  ASSIGN wdetail2.class = "270B"  wdetail2.comp = "400.00".   
            ELSE IF deci(wdetail2.premt) = 430.14        THEN  ASSIGN wdetail2.class = "271"   wdetail2.comp = "400.00".   
            ELSE IF deci(wdetail2.premt) = 430.14        THEN  ASSIGN wdetail2.class = "330C"  wdetail2.comp = "400.00".   
            ELSE IF deci(wdetail2.premt) = 430.14        THEN  ASSIGN wdetail2.class = "370B"  wdetail2.comp = "400.00".   
            ELSE IF deci(wdetail2.premt) = 430.14        THEN  ASSIGN wdetail2.class = "371"   wdetail2.comp = "400.00".   
            ELSE IF deci(wdetail2.premt) = 645.21        THEN  ASSIGN wdetail2.class = "230D"  wdetail2.comp = "600.00".   
            ELSE IF deci(wdetail2.premt) = 645.21        THEN  ASSIGN wdetail2.class = "260"   wdetail2.comp = "600.00".   
            ELSE IF deci(wdetail2.premt) = 645.21        THEN  ASSIGN wdetail2.class = "330D"  wdetail2.comp = "600.00".   
            ELSE IF deci(wdetail2.premt) = 645.21        THEN  ASSIGN wdetail2.class = "360"   wdetail2.comp = "600.00".   
            ELSE IF deci(wdetail2.premt) = 828.18        THEN  ASSIGN wdetail2.class = "407"   wdetail2.comp = "770.00".   
            ELSE IF deci(wdetail2.premt) = 1547.22       THEN  ASSIGN wdetail2.class = "270A"  wdetail2.comp = "1440.00".   
            ELSE IF deci(wdetail2.premt) = 1547.22       THEN  ASSIGN wdetail2.class = "370A"  wdetail2.comp = "1440.00".   
            ELSE IF deci(wdetail2.premt) = 1644.59       THEN  ASSIGN wdetail2.class = "401"   wdetail2.comp = "1530.00".   
            ELSE IF deci(wdetail2.premt) = 1891.76       THEN  ASSIGN wdetail2.class = "240A"  wdetail2.comp = "1760.00".   
            ELSE IF deci(wdetail2.premt) = 1891.76       THEN  ASSIGN wdetail2.class = "340A"  wdetail2.comp = "1760.00".   
            ELSE IF deci(wdetail2.premt) = 1966.66       THEN  ASSIGN wdetail2.class = "240B"  wdetail2.comp = "1830.00".   
            ELSE IF deci(wdetail2.premt) = 1966.66       THEN  ASSIGN wdetail2.class = "340B"  wdetail2.comp = "1830.00".   
            ELSE IF deci(wdetail2.premt) = 2041.56       THEN  ASSIGN wdetail2.class = "210"   wdetail2.comp = "1900.00".   
            ELSE IF deci(wdetail2.premt) = 2041.56       THEN  ASSIGN wdetail2.class = "310"   wdetail2.comp = "1900.00".   
            ELSE IF deci(wdetail2.premt) = 2127.16       THEN  ASSIGN wdetail2.class = "240C"  wdetail2.comp = "1980.00".   
            ELSE IF deci(wdetail2.premt) = 2127.16       THEN  ASSIGN wdetail2.class = "242A"  wdetail2.comp = "1980.00".   
            ELSE IF deci(wdetail2.premt) = 2127.16       THEN  ASSIGN wdetail2.class = "340C"  wdetail2.comp = "1980.00".   
            ELSE IF deci(wdetail2.premt) = 2127.16       THEN  ASSIGN wdetail2.class = "342A"  wdetail2.comp = "1980.00".   
            ELSE IF deci(wdetail2.premt) = 2493.10       THEN  ASSIGN wdetail2.class = "220A"  wdetail2.comp = "2320.00".   
            ELSE IF deci(wdetail2.premt) = 2493.10       THEN  ASSIGN wdetail2.class = "320A"  wdetail2.comp = "2320.00".   
            ELSE IF deci(wdetail2.premt) = 2718.87       THEN  ASSIGN wdetail2.class = "240D"  wdetail2.comp = "2530.00".   
            ELSE IF deci(wdetail2.premt) = 2718.87       THEN  ASSIGN wdetail2.class = "340D"  wdetail2.comp = "2530.00".   
            ELSE IF deci(wdetail2.premt) = 3288.11       THEN  ASSIGN wdetail2.class = "242B"  wdetail2.comp = "3060.00".   
            ELSE IF deci(wdetail2.premt) = 3288.11       THEN  ASSIGN wdetail2.class = "342B"  wdetail2.comp = "3060.00".   
            ELSE IF deci(wdetail2.premt) = 3395.11       THEN  ASSIGN wdetail2.class = "250"   wdetail2.comp = "3160.00".   
            ELSE IF deci(wdetail2.premt) = 3395.11       THEN  ASSIGN wdetail2.class = "350"   wdetail2.comp = "3160.00".   
            ELSE IF deci(wdetail2.premt) = 3738.58       THEN  ASSIGN wdetail2.class = "220B"  wdetail2.comp = "3480.00".   
            ELSE IF deci(wdetail2.premt) = 3738.58       THEN  ASSIGN wdetail2.class = "320B"  wdetail2.comp = "3480.00".   
            ELSE IF deci(wdetail2.premt) = 7155.09       THEN  ASSIGN wdetail2.class = "220C"  wdetail2.comp = "6660.00".   
            ELSE IF deci(wdetail2.premt) = 7155.09       THEN  ASSIGN wdetail2.class = "320C"  wdetail2.comp = "6660.00".   
            ELSE IF deci(wdetail2.premt) = 8079.57       THEN  ASSIGN wdetail2.class = "220D"  wdetail2.comp = "7520.00".   
            ELSE IF deci(wdetail2.premt) = 8079.57       THEN  ASSIGN wdetail2.class = "320D"  wdetail2.comp = "7520.00".
        END.
        /*RUN proc_cutvehreg.*/
        FIND FIRST brstat.msgcode WHERE 
            brstat.msgcode.compno  = "999" AND
            INDEX(wdetail2.insurnam,brstat.msgcode.MsgDesc) <> 0   NO-LOCK NO-WAIT NO-ERROR.
        IF AVAIL brstat.msgcode THEN  
            ASSIGN 
            wdetail2.titlenam   = trim(brstat.msgcode.branch)
            wdetail2.insurnam   = trim(substr(wdetail2.insurnam,LENGTH(brstat.msgcode.MsgDesc) + 1 )).
        /*-- create A59-0590 --*/
        ELSE DO:
             IF index(wdetail2.insurnam,"����ѷ") <> 0 THEN DO:  
                 ASSIGN wdetail2.titlenam   = "����ѷ"
                        wdetail2.insurnam   = trim(substr(wdetail2.insurnam,LENGTH(wdetail2.titlenam) + 1 )).
             END.
             ELSE IF index(wdetail2.insurnam,"�.") <> 0 THEN DO:   
                 ASSIGN wdetail2.titlenam   = "�."
                        wdetail2.insurnam   = trim(substr(wdetail2.insurnam,LENGTH(wdetail2.titlenam) + 1 )).
             END.
             ELSE IF index(wdetail2.insurnam,"���.") <> 0 THEN DO: 
                 ASSIGN wdetail2.titlenam   = "���."
                        wdetail2.insurnam   = trim(substr(wdetail2.insurnam,LENGTH(wdetail2.titlenam) + 1 )).
             END.
             ELSE IF index(wdetail2.insurnam,"˨�.") <> 0 THEN DO: 
                 ASSIGN wdetail2.titlenam   = "˨�."
                        wdetail2.insurnam   = trim(substr(wdetail2.insurnam,LENGTH(wdetail2.titlenam) + 1 )).
             END.
             ELSE IF index(wdetail2.insurnam,"�ʹ.") <> 0 THEN DO:   
                 ASSIGN wdetail2.titlenam   = "�ʹ."
                        wdetail2.insurnam   = trim(substr(wdetail2.insurnam,LENGTH(wdetail2.titlenam) + 1 )).
             END.
             ELSE IF index(wdetail2.insurnam,"����ѷ") <> 0 THEN DO:  
                 ASSIGN wdetail2.titlenam   = "����ѷ"
                        wdetail2.insurnam   = trim(substr(wdetail2.insurnam,LENGTH(wdetail2.titlenam) + 1 )).
             END.
             ELSE IF index(wdetail2.insurnam,"��ŹԸ�") <> 0 THEN DO:  
                 ASSIGN wdetail2.titlenam   = "��ŹԸ�"
                        wdetail2.insurnam   = trim(substr(wdetail2.insurnam,LENGTH(wdetail2.titlenam))).
             END.
             ELSE IF index(wdetail2.insurnam,"��ҧ�����ǹ�ӡѴ") <> 0 THEN DO:
                 ASSIGN wdetail2.titlenam   = "��ҧ�����ǹ�ӡѴ"
                        wdetail2.insurnam   = trim(substr(wdetail2.insurnam,LENGTH(wdetail2.titlenam) + 1 )).
             END.
             ELSE IF index(wdetail2.insurnam,"��ҧ�����ǹ�ӡ") <> 0  THEN DO:
                 ASSIGN wdetail2.titlenam   = "��ҧ�����ǹ�ӡѴ"
                        wdetail2.insurnam   = trim(substr(wdetail2.insurnam,LENGTH(wdetail2.titlenam) - 2 )).
             END.
             ELSE IF index(wdetail2.insurnam,"��ҧ�����ǹ") <> 0 THEN DO:  
                 ASSIGN wdetail2.titlenam   = "��ҧ�����ǹ"
                        wdetail2.insurnam   = trim(substr(wdetail2.insurnam,LENGTH(wdetail2.titlenam) + 1 )).
             END.
             ELSE IF index(wdetail2.insurnam,"��ҧ") <> 0 THEN DO: 
                 ASSIGN wdetail2.titlenam   = "��ҧ"
                        wdetail2.insurnam   = trim(substr(wdetail2.insurnam,LENGTH(wdetail2.titlenam) + 1 )).
             END.
             ELSE ASSIGN wdetail2.titlenam   = "�س".
        END.
        /*--- end A59-0590 ---*/
        RUN proc_vehmat.
        /*RUN proc_cutpolicy.*/  
        IF rs_form = 1 THEN DO: /*A59-0590 */
            FIND FIRST Stat.Detaitem USE-INDEX detaitem11 WHERE
                Stat.Detaitem.serailno   = wdetail2.number   NO-LOCK NO-ERROR NO-WAIT.
            IF   AVAIL  stat.Detaitem THEN  
                 ASSIGN wdetail2.polstk  = trim(stat.detaitem.policy) .  
            ELSE ASSIGN wdetail2.polstk  = "".
        END. /*A59-0590 */
        ELSE ASSIGN wdetail2.polstk  = "". /*A59-0590 */
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_assignstk1 C-Win 
PROCEDURE Pro_assignstk1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_length AS INT INIT 0 .
FOR EACH wdetail2 .
    IF wdetail2.id NE "" THEN DO:
        IF rs_form = 1  THEN DO:  /* A59-0590 */
            FIND FIRST wdetail WHERE wdetail.policy = wdetail2.polstk NO-ERROR NO-WAIT.
            IF NOT AVAIL wdetail THEN DO:
                CREATE wdetail.
                ASSIGN
                    wdetail.brand       = trim(wdetail2.brand)
                    wdetail.poltyp      = "72" 
                    wdetail.policy      = wdetail2.polstk           
                    /*wdetail.comdat      = IF (deci(substr(wdetail2.comdat,1,1)) GE 0) AND (deci(substr(wdetail2.comdat,1,1)) LE 9) THEN wdetail2.comdat ELSE ""  
                    wdetail.expdat      = IF (deci(substr(wdetail2.expdat,1,1)) GE 0) AND (deci(substr(wdetail2.expdat,1,1)) LE 9) THEN wdetail2.expdat ELSE ""  */
                    wdetail.comdat =  IF wdetail2.comdat = "" THEN "" ELSE 
                                               string(DAY(date(wdetail2.comdat)),"99") + "/" +
                                               string(MONTH(date(wdetail2.comdat)),"99") + "/" +
                                               string(deci(YEAR(date(wdetail2.comdat)) - 543 ),"9999") 
                    wdetail.expdat =  IF wdetail2.expdat = "" THEN "" ELSE string(DAY(date(wdetail2.expdat)),"99") + "/" +
                                            string(MONTH(date(wdetail2.expdat)),"99") + "/" +
                                            string(deci(YEAR(date(wdetail2.expdat)) - 543 ),"9999")
                    wdetail.tiname      = trim(wdetail2.titlenam)
                    wdetail.insnam      = trim(wdetail2.insurnam)
                    wdetail.idno        = TRIM(wdetail2.idno)   
                    wdetail.iadd1       = trim(wdetail2.ad11)
                    wdetail.iadd2       = trim(wdetail2.ad12)
                    wdetail.iadd3       = trim(wdetail2.ad13)
                    wdetail.iadd4       = trim(wdetail2.ad14)
                    wdetail.subclass    = trim(wdetail2.class)
                    wdetail.model       = trim(wdetail2.model) 
                    wdetail.cc          = ""                                                                   
                    wdetail.vehreg      = trim(wdetail2.vehreg)                                  
                    wdetail.engno       = ""                             
                    wdetail.chasno      = wdetail2.chassis                                    
                    wdetail.vehuse      = "1"                                                     
                    wdetail.garage      = ""                                                      
                    wdetail.stk         = IF substr(trim(wdetail2.number),1,1) = "0" THEN   trim(wdetail2.number) ELSE "0"  + TRIM(wdetail2.number)                                     
                    wdetail.covcod      = "T"                                                              
                    wdetail.si          = ""                                                                 
                    /*wdetail.branch      = wdetail2.branch *//*Kridtiya i. A54-0049 */
                    wdetail.branch      = "Y"                 /*Kridtiya i. A54-0049 */
                    wdetail.benname     = "��Ҥ�� ���õԹҤԹ �ӡѴ (��Ҫ�)"                         
                    wdetail.volprem     = wdetail2.comp                                                    
                    wdetail.premt1      = wdetail2.premt        /*�������*/    
                    wdetail.comment     = ""                                                            
                    wdetail.delerco     = ""   /*wdetail2.cc �纤�� vatcode*/                     
                    wdetail.entdat      = string(TODAY)             /*entry date*/                 
                    wdetail.enttim      = STRING(TIME, "HH:MM:SS")  /*entry time*/                 
                    wdetail.trandat     = STRING(TODAY)             /*tran date*/                  
                    wdetail.trantim     = STRING(TIME, "HH:MM:SS")  /*tran time*/                  
                    wdetail.n_IMPORT    = "IM"                                                     
                    wdetail.n_EXPORT    = ""                                                       
                    wdetail.number      = wdetail2.number                                          
                    wdetail.cedpol      = wdetail2.cedpol                                          
                    wdetail.recivedat   = wdetail2.recivedat        /*�ѹ��� �Ѻ���Ф�Ҿú. */     
                    wdetail.br_nam      = "�Ң�" + wdetail2.br_nam           /*�Ң�*/                       
                    wdetail.notifyno    = wdetail2.notifyno         /*�Ţ����Ѻ��*/              
                    wdetail.namnotify   = wdetail2.namnotify        /*����� (Mkt)*/              
                    wdetail.nmember     = wdetail2.memmo .          /*�����˵�/�ѹ����͡�ú.*/  
                END.  /*if avail*/
        END. /* A59-0590 */
        /*-- Create by A59-059 Ranu I.--*/
        ELSE DO:
            FIND FIRST wdetail WHERE wdetail.policy = "72" + trim(wdetail2.cedpol) NO-ERROR NO-WAIT.  
            IF NOT AVAIL wdetail THEN DO:
                CREATE wdetail.
                ASSIGN
                    wdetail.brand      = trim(wdetail2.brand)
                    wdetail.poltyp     = "72" 
                    wdetail.policy     = "72" + trim(wdetail2.cedpol) 
                    /* comment by A61-0335....
                    wdetail.comdat     =  IF wdetail2.comdat = "" THEN "" ELSE 
                                          string(DAY(date(wdetail2.comdat)),"99") + "/" +
                                          string(MONTH(date(wdetail2.comdat)),"99") + "/" +
                                          string(deci(YEAR(date(wdetail2.comdat)) - 543 ),"9999") 
                    wdetail.expdat     =  IF wdetail2.expdat = "" THEN "" ELSE string(DAY(date(wdetail2.expdat)),"99") + "/" +
                                          string(MONTH(date(wdetail2.expdat)),"99") + "/" +
                                          string(deci(YEAR(date(wdetail2.expdat)) - 543 ),"9999") 
                     ...end A61-0335......*/
                    wdetail.comdat      = trim(wdetail2.comdat)   /*A61-0335*/ 
                    wdetail.expdat       = trim(wdetail2.expdat)  /*A61-0335*/ 
                    wdetail.tiname     = trim(wdetail2.titlenam)
                    wdetail.insnam     = trim(wdetail2.insurnam)
                    wdetail.idno       = TRIM(wdetail2.idno)   
                    wdetail.iadd1      = trim(wdetail2.ad11)
                    wdetail.iadd2      = trim(wdetail2.ad12)
                    wdetail.iadd3      = trim(wdetail2.ad13)
                    wdetail.iadd4      = trim(wdetail2.ad14)
                    wdetail.subclass   = trim(wdetail2.class)
                    wdetail.model      = trim(wdetail2.model) 
                    wdetail.cc         = ""                                                                   
                    wdetail.vehreg     = trim(wdetail2.vehreg)                                  
                    wdetail.engno      = ""                             
                    wdetail.chasno     = wdetail2.chassis                                    
                    wdetail.vehuse     = "1"                                                     
                    wdetail.garage     = ""                                                      
                    wdetail.stk        = ""
                    wdetail.covcod     = "T"                                                              
                    wdetail.si         = ""                                                                 
                    wdetail.branch     = wdetail2.branch 
                    wdetail.benname    = "��Ҥ�� ���õԹҤԹ �ӡѴ (��Ҫ�)"                         
                    wdetail.volprem    = wdetail2.comp                                                    
                    wdetail.premt1     = wdetail2.premt        /*�������*/    
                    wdetail.comment    = ""                                                            
                    wdetail.delerco    = ""   /*wdetail2.cc �纤�� vatcode*/                     
                    wdetail.entdat     = string(TODAY)             /*entry date*/                 
                    wdetail.enttim     = STRING(TIME, "HH:MM:SS")  /*entry time*/                 
                    wdetail.trandat    = STRING(TODAY)             /*tran date*/                  
                    wdetail.trantim    = STRING(TIME, "HH:MM:SS")  /*tran time*/                  
                    wdetail.n_IMPORT   = "IM"                                                     
                    wdetail.n_EXPORT   = ""                                                       
                    wdetail.number     = wdetail2.number                                          
                    wdetail.cedpol     = wdetail2.cedpol                                          
                    wdetail.recivedat  = wdetail2.recivedat        /*�ѹ��� �Ѻ���Ф�Ҿú. */     
                    wdetail.br_nam     = "�Ң�" + wdetail2.br_nam           /*�Ң�*/                       
                    wdetail.notifyno   = wdetail2.notifyno         /*�Ţ����Ѻ��*/              
                    wdetail.namnotify  = wdetail2.namnotify        /*����� (Mkt)*/              
                    wdetail.nmember    = wdetail2.memmo .          /*�����˵�/�ѹ����͡�ú.*/  
                END.  /*if avail*/            
        END.
        /*---- end A59-0590 ---*/
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_assign_address C-Win 
PROCEDURE Pro_assign_address :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF (wdetail2.adr_no1    <> "")  THEN  wdetail2.ad11 = TRIM(wdetail2.adr_no1).                                  /*  19  ������� */    
IF (wdetail2.adr_mu     <> "")  THEN  wdetail2.ad11 = trim(wdetail2.ad11 + " ���� " + TRIM(wdetail2.adr_mu)).  /*  ����    */        
IF (wdetail2.adr_muban  <> "")  THEN  wdetail2.ad11 = trim(wdetail2.ad11 + " " + TRIM(wdetail2.adr_muban)).    /*  �����ҹ    */    
IF (wdetail2.adr_build  <> "")  THEN DO:
    IF LENGTH(wdetail2.ad11 + " " + TRIM(wdetail2.adr_build)) > 35  THEN 
        ASSIGN wdetail2.ad12 = trim(wdetail2.ad12 + " �Ҥ��" + TRIM(wdetail2.adr_build)).
    ELSE 
        ASSIGN wdetail2.ad11 = wdetail2.ad11 + " �Ҥ��" + TRIM(wdetail2.adr_build)
               wdetail2.ad12 =   " " .
END.
IF (wdetail2.adr_soy    <> "")  THEN DO:  
    IF LENGTH(wdetail2.ad11 + " ���" + TRIM(wdetail2.adr_soy)) > 35  THEN
        ASSIGN wdetail2.ad12 = wdetail2.ad12 + " ���" + TRIM(wdetail2.adr_soy).      /*  ��� */              
    ELSE 
        ASSIGN wdetail2.ad11 = wdetail2.ad11 + " ���" + TRIM(wdetail2.adr_soy)  
               wdetail2.ad12 =   " " .
END.
IF (wdetail2.adr_road   <> "")  THEN DO:  
    IF LENGTH(wdetail2.ad11 + " ��� " + TRIM(wdetail2.adr_road)) > 35  THEN
         ASSIGN wdetail2.ad12 = wdetail2.ad12 + " ���" + TRIM(wdetail2.adr_road).  /*  ��� */ 
    ELSE ASSIGN wdetail2.ad11 = wdetail2.ad11 + " ���" + TRIM(wdetail2.adr_road)   /*  ��� */ 
                wdetail2.ad12 =   " " .                                             
END.  
IF (INDEX(wdetail2.adr_country,"��ا") <> 0 ) OR (INDEX(wdetail2.adr_country,"���") <> 0 ) THEN DO:
    IF (wdetail2.adr_tambon <> "")  THEN DO: 
        IF LENGTH(wdetail2.ad12 + " " + TRIM(wdetail2.adr_tambon)) > 35 THEN            
             ASSIGN wdetail2.ad13 = wdetail2.ad13 + " �ǧ" + TRIM(wdetail2.adr_tambon).    /*  �Ӻ�/�ǧ   */      
        ELSE ASSIGN wdetail2.ad12 = wdetail2.ad12 + " �ǧ" + TRIM(wdetail2.adr_tambon)     /*  �Ӻ�/�ǧ   */ 
                    wdetail2.ad13 = " " .                                               
    END.                                                                                
    IF (wdetail2.adr_amper  <> "")  THEN DO:                                            
        IF LENGTH(wdetail2.ad12 + " " + TRIM(wdetail2.adr_amper)) > 35 THEN             
             ASSIGN wdetail2.ad13 = wdetail2.ad13 + " ࢵ" + TRIM(wdetail2.adr_amper).     /*  �����/ࢵ   */ 
        ELSE ASSIGN wdetail2.ad12 = wdetail2.ad12 + " ࢵ" + TRIM(wdetail2.adr_amper)      
                    wdetail2.ad13 = " " .                                               
    END.                                                                                
    IF (wdetail2.adr_country <> "")  THEN DO:                                            
        IF LENGTH(wdetail2.ad13 + " " + TRIM(wdetail2.adr_country)) > 35 THEN           
             ASSIGN wdetail2.ad14 = wdetail2.ad14 + " " + TRIM(wdetail2.adr_country).   /*  �ѧ��Ѵ */
        ELSE ASSIGN wdetail2.ad13 = wdetail2.ad13 + " " + TRIM(wdetail2.adr_country)    /*  �ѧ��Ѵ */
                    wdetail2.ad14 =   " " .                                             
    END.                                                                                
    IF (wdetail2.adr_post   <> "")  THEN DO:                                            
        IF LENGTH(wdetail2.ad14 + " " + TRIM(wdetail2.adr_post)) > 35 THEN              
             ASSIGN wdetail2.ad14 = wdetail2.ad14 + " " + TRIM(wdetail2.adr_post).      
        ELSE ASSIGN wdetail2.ad13 = wdetail2.ad13 + " " + TRIM(wdetail2.adr_post)       /*  ������ɳ���    */
                    wdetail2.ad14 = " " .
    END.
END.
ELSE DO:
    IF (wdetail2.adr_tambon <> "")  THEN DO: 
        IF LENGTH(wdetail2.ad12 + " " + TRIM(wdetail2.adr_tambon)) > 35 THEN            
             ASSIGN wdetail2.ad13 = wdetail2.ad13 + " �Ӻ�" + TRIM(wdetail2.adr_tambon).    /*  �Ӻ�/�ǧ   */      
        ELSE ASSIGN wdetail2.ad12 = wdetail2.ad12 + " �Ӻ�" + TRIM(wdetail2.adr_tambon)     /*  �Ӻ�/�ǧ   */ 
                    wdetail2.ad13 = " " .                                               
    END.                                                                                
    IF (wdetail2.adr_amper  <> "")  THEN DO:                                            
        IF LENGTH(wdetail2.ad12 + " " + TRIM(wdetail2.adr_amper)) > 35 THEN             
             ASSIGN wdetail2.ad13 = wdetail2.ad13 + " �����" + TRIM(wdetail2.adr_amper).     /*  �����/ࢵ   */ 
        ELSE ASSIGN wdetail2.ad12 = wdetail2.ad12 + " �����" + TRIM(wdetail2.adr_amper)      
                    wdetail2.ad13 = " " .                                               
    END.                                                                                
    IF (wdetail2.adr_country <> "")  THEN DO:                                            
        IF LENGTH(wdetail2.ad13 + " " + TRIM(wdetail2.adr_country)) > 35 THEN           
             ASSIGN wdetail2.ad14 = wdetail2.ad14 + " �ѧ��Ѵ" + TRIM(wdetail2.adr_country).   /*  �ѧ��Ѵ */
        ELSE ASSIGN wdetail2.ad13 = wdetail2.ad13 + " �ѧ��Ѵ" + TRIM(wdetail2.adr_country)    /*  �ѧ��Ѵ */
                    wdetail2.ad14 =   " " .                                             
    END.                                                                                
    IF (wdetail2.adr_post   <> "")  THEN DO:                                            
        IF LENGTH(wdetail2.ad14 + " " + TRIM(wdetail2.adr_post)) > 35 THEN              
             ASSIGN wdetail2.ad14 = wdetail2.ad14 + " " + TRIM(wdetail2.adr_post).      
        ELSE ASSIGN wdetail2.ad13 = wdetail2.ad13 + " " + TRIM(wdetail2.adr_post)       /*  ������ɳ���    */
                    wdetail2.ad14 = " " .
    END.
END.
END PROCEDURE.
/*      wdetail2.ad11
        wdetail2.ad12
        wdetail2.ad13
        wdetail2.ad14*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_assign_rel C-Win 
PROCEDURE Pro_assign_rel :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_dayno      AS DECI init 0 .
DEF VAR nv_stk       AS CHAR FORMAT "x(15)".
DEF VAR n_cutaddress AS CHAR FORMAT "x(256)" INIT "" .
FOR EACH wdetail2 WHERE  wdetail2.id NE "" .
    ASSIGN n_cutaddress = "" .
    IF index(wdetail2.id,"�ӴѺ") <> 0    THEN DELETE wdetail2.
    ELSE DO:
        IF TRIM(wdetail2.titlenam) <> " "  THEN DO: 
            IF  INDEX(TRIM(wdetail2.titlenam),"����ѷ")            <> 0  OR 
                INDEX(TRIM(wdetail2.titlenam),"�.")                <> 0  OR 
                INDEX(TRIM(wdetail2.titlenam),"���.")              <> 0  OR 
                INDEX(TRIM(wdetail2.titlenam),"˨�.")              <> 0  OR 
                INDEX(TRIM(wdetail2.titlenam),"�ʹ.")              <> 0  OR 
                INDEX(TRIM(wdetail2.titlenam),"����ѷ")            <> 0  OR 
                INDEX(TRIM(wdetail2.titlenam),"��ŹԸ�")           <> 0  OR 
                INDEX(TRIM(wdetail2.titlenam),"��ҧ")              <> 0  OR 
                INDEX(TRIM(wdetail2.titlenam),"��ҧ�����ǹ")      <> 0  OR 
                INDEX(TRIM(wdetail2.titlenam),"��ҧ�����ǹ�ӡѴ") <> 0  OR
                INDEX(TRIM(wdetail2.titlenam),"��ҧ�����ǹ�ӡ")   <> 0  OR  
                R-INDEX(TRIM(wdetail2.titlenam),"��.")             <> 0  OR  
                R-INDEX(TRIM(wdetail2.titlenam),"�ӡѴ")           <> 0  OR  
                R-INDEX(TRIM(wdetail2.titlenam),"(��Ҫ�)")         <> 0  OR  
                R-INDEX(TRIM(wdetail2.titlenam),"INC.")            <> 0  OR 
                R-INDEX(TRIM(wdetail2.titlenam),"CO.")             <> 0  OR 
                R-INDEX(TRIM(wdetail2.titlenam),"LTD.")            <> 0  OR 
                R-INDEX(TRIM(wdetail2.titlenam),"LIMITED")         <> 0  OR 
                INDEX(TRIM(wdetail2.titlenam),"���/����")          <> 0  THEN DO:  /*company */
                IF wdetail2.memmo <> "" THEN ASSIGN n_cutaddress = wdetail2.memmo.
                ELSE DO: 
                    /*ASSIGN n_cutaddress = wdetail2.ad11.*/
                    RUN Pro_assign_address.  /*A56-0309*/
                END.
            END.
            ELSE DO:  /* not company */
                /*ASSIGN n_cutaddress = wdetail2.ad11.*/
                RUN Pro_assign_address.  /*A56-0309*/
                FIND FIRST brstat.msgcode USE-INDEX MsgCode01 WHERE
                    brstat.msgcode.MsgDesc = TRIM(wdetail2.titlenam)  NO-LOCK NO-WAIT NO-ERROR.
                IF AVAIL brstat.msgcode  THEN DO:
                    ASSIGN wdetail2.titlenam = brstat.msgcode.branch.
                END.
            END.
        END.
        /*ELSE ASSIGN n_cutaddress = wdetail2.ad11.*/
        ELSE RUN Pro_assign_address.  /*A56-0309*/

        /*IF n_cutaddress = "" THEN
            ASSIGN 
            wdetail2.ad11 = ""
            wdetail2.ad12 = ""
            wdetail2.ad13 = ""
            wdetail2.ad14 = "".
        ELSE DO:
            /*provinc...*/
            IF      r-index(n_cutaddress,"�ѧ��Ѵ") <> 0 THEN 
                ASSIGN wdetail2.ad14 = substr(n_cutaddress,r-index(n_cutaddress,"�ѧ��Ѵ"))
                n_cutaddress        = substr(n_cutaddress,1,r-index(n_cutaddress,"�ѧ��Ѵ") - 1).
            ELSE IF r-index(n_cutaddress,"�.")      <> 0 THEN 
                ASSIGN wdetail2.ad14 = substr(n_cutaddress,r-index(n_cutaddress,"�."))
                n_cutaddress        = substr(n_cutaddress,1,r-index(n_cutaddress,"�.") - 1).   
            ELSE IF r-index(n_cutaddress,"��ا෾") <> 0 THEN 
                ASSIGN wdetail2.ad14 = substr(n_cutaddress,r-index(n_cutaddress,"��ا෾"))
                n_cutaddress        = substr(n_cutaddress,1,r-index(n_cutaddress,"��ا෾") - 1).          
            ELSE IF r-index(n_cutaddress,"���")     <> 0 THEN 
                ASSIGN wdetail2.ad14 = substr(n_cutaddress,r-index(n_cutaddress,"���"))
                n_cutaddress        = substr(n_cutaddress,1,r-index(n_cutaddress,"���") - 1). 
            /*Amper..*/
            IF      r-index(n_cutaddress,"�����") <> 0 THEN 
                ASSIGN wdetail2.ad13 = substr(n_cutaddress,r-index(n_cutaddress,"�����"))
                n_cutaddress        = substr(n_cutaddress,1,r-index(n_cutaddress,"�����") - 1). 
            ELSE IF r-index(n_cutaddress,"�.")    <> 0 THEN 
                ASSIGN wdetail2.ad13 = substr(n_cutaddress,r-index(n_cutaddress,"�.")) 
                n_cutaddress        = substr(n_cutaddress,1,r-index(n_cutaddress,"�.") - 1). 
            ELSE IF r-index(n_cutaddress,"ࢵ")   <> 0 THEN 
                ASSIGN wdetail2.ad13 = substr(n_cutaddress,r-index(n_cutaddress,"ࢵ")) 
                n_cutaddress        = substr(n_cutaddress,1,r-index(n_cutaddress,"ࢵ") - 1). 
            /*tambon*/
            IF      r-index(n_cutaddress,"�Ӻ�") <> 0 THEN 
                ASSIGN wdetail2.ad12 = substr(n_cutaddress,r-index(n_cutaddress,"�Ӻ�"))
                n_cutaddress        = substr(n_cutaddress,1,r-index(n_cutaddress,"�Ӻ�") - 1). 
            ELSE IF r-index(n_cutaddress,"�.")    <> 0 THEN 
                ASSIGN wdetail2.ad12 = substr(n_cutaddress,r-index(n_cutaddress,"�.")) 
                n_cutaddress        = substr(n_cutaddress,1,r-index(n_cutaddress,"�.") - 1). 
            ELSE IF r-index(n_cutaddress,"�ǧ")   <> 0 THEN 
                ASSIGN wdetail2.ad12 = substr(n_cutaddress,r-index(n_cutaddress,"�ǧ")) 
                n_cutaddress        = substr(n_cutaddress,1,r-index(n_cutaddress,"�ǧ") - 1). 
            ASSIGN wdetail2.ad11 = n_cutaddress .
            IF (index(wdetail2.ad14,"��ا෾") <> 0 ) OR (index(wdetail2.ad14,"���") <> 0 )    THEN
                ASSIGN 
                wdetail2.ad12 = IF INDEX(wdetail2.ad12,"�Ӻ�/�ǧ") <> 0 THEN "�ǧ" + trim(REPLACE(wdetail2.ad12,"�Ӻ�/�ǧ","")) 
                                ELSE IF INDEX(wdetail2.ad12,"�.")   <> 0 THEN "�ǧ" + trim(REPLACE(wdetail2.ad12,"�.","")) 
                                ELSE TRIM(wdetail2.ad12)                             
                wdetail2.ad13 = IF index(wdetail2.ad13,"�����/ࢵ") <> 0 THEN "ࢵ"  + trim(REPLACE(wdetail2.ad13,"�����/ࢵ","")) 
                                ELSE IF index(wdetail2.ad13,"�.")   <> 0 THEN "ࢵ"  + trim(REPLACE(wdetail2.ad13,"�.",""))
                                ELSE TRIM(wdetail2.ad13)                             
                wdetail2.ad14 = IF index(wdetail2.ad14,"�ѧ��Ѵ")   <> 0 THEN trim(REPLACE(wdetail2.ad14,"�ѧ��Ѵ","")) 
                                ELSE IF index(wdetail2.ad14,"�.")   <> 0 THEN trim(REPLACE(wdetail2.ad14,"�.","")) 
                                ELSE TRIM(wdetail2.ad14).                            
            ELSE ASSIGN                                                              
                wdetail2.ad12 = IF INDEX(wdetail2.ad12,"�Ӻ�/�ǧ") <> 0 THEN "�Ӻ�"  + trim(REPLACE(wdetail2.ad12,"�Ӻ�/�ǧ","")) 
                                ELSE IF INDEX(wdetail2.ad12,"�.")   <> 0 THEN "�Ӻ�"  + trim(REPLACE(wdetail2.ad12,"�.","")) 
                                ELSE TRIM(wdetail2.ad12)                             
                wdetail2.ad13 = IF index(wdetail2.ad13,"�����/ࢵ") <> 0 THEN "�����" + trim(REPLACE(wdetail2.ad13,"�����/ࢵ","")) 
                                ELSE IF index(wdetail2.ad13,"�.")   <> 0 THEN "�����" + trim(REPLACE(wdetail2.ad13,"�.",""))
                                ELSE TRIM(wdetail2.ad13)                             
                wdetail2.ad14 = IF index(wdetail2.ad14,"�ѧ��Ѵ")   <> 0 THEN "�ѧ��Ѵ" + trim(REPLACE(wdetail2.ad14,"�ѧ��Ѵ",""))  
                                ELSE IF index(wdetail2.ad14,"�.")   <> 0 THEN trim(REPLACE(wdetail2.ad14,"�.","")) 
                                ELSE TRIM(wdetail2.ad14).
        END.*/
        /* create by : A60-0232*/
        ASSIGN wdetail2.br_nam = trim(wdetail2.branchname) .
        FIND FIRST stat.insure USE-INDEX insure03  WHERE 
                stat.insure.compno = "kk"               AND
                index(wdetail2.idbranch,stat.insure.insno) <> 0  AND       
                index(wdetail2.br_nam,stat.insure.fname) <> 0 NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL insure THEN
                ASSIGN wdetail2.branch = stat.insure.branch .
            ELSE do: 
                 FIND FIRST stat.insure USE-INDEX insure03  WHERE 
                stat.insure.compno = "kk"               AND
                index(stat.insure.insno,wdetail2.idbranch) <> 0  NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL insure THEN
                    ASSIGN wdetail2.branch = stat.insure.branch .
                ELSE ASSIGN   wdetail2.branch = "".
            END.
        /* end : A60-0232*/

        ASSIGN 
            n_dayno    = date(wdetail2.expdat) - date(wdetail2.comdat) 
            n_dayno    = n_dayno / 365.
         IF n_dayno GE 1  THEN DO:  /* 1 �բ��� */
             IF deci(wdetail2.comp) LE 1099  THEN DO: 
                 IF deci(wdetail2.comp) LE 899 THEN DO: 
                     IF deci(wdetail2.comp) LE 599 THEN ASSIGN wdetail2.class = "110".
                     ELSE ASSIGN wdetail2.class = "110".
                 END.
                 ELSE ASSIGN wdetail2.class = "140A".
             END.
             ELSE ASSIGN wdetail2.class = "120A". 
        END.
        ELSE DO:  /* ���֧ �� 1 */
            IF deci(wdetail2.comp) LE 1100  THEN DO: 
                IF deci(wdetail2.comp) LE 900 THEN DO: 
                    IF deci(wdetail2.comp) LE 600 THEN ASSIGN wdetail2.class = "110".
                    ELSE ASSIGN wdetail2.class = "140A".
                END.
                ELSE ASSIGN wdetail2.class = "120A".
            END.
            ELSE ASSIGN wdetail2.class = "120A". 
        END.
        /*RUN proc_cutvehreg.*/
        FIND FIRST brstat.msgcode WHERE 
            brstat.msgcode.compno  = "999" AND
            brstat.msgcode.MsgDesc = TRIM(wdetail2.titlenam)  NO-LOCK NO-WAIT NO-ERROR.
        IF AVAIL brstat.msgcode THEN  
            ASSIGN 
            wdetail2.titlenam   = trim(brstat.msgcode.branch) .
        ELSE 
            ASSIGN wdetail2.titlenam   = "�س".

        ASSIGN  nv_stk = "" . /*A60-0232*/

        RUN proc_vehmat.
        IF rs_form = 1  THEN DO: /*--A59-0590 --*/
            IF wdetail2.polstk  = "" THEN RUN Pro_assign_runpol72.
            ELSE DO:
                 RUN proc_cutpolicy.
                /*A60-0232*/
                ASSIGN  nv_stk       = wdetail2.polstk 
                        wdetail2.stk = TRIM(nv_stk).

                FIND FIRST Stat.Detaitem USE-INDEX detaitem11 WHERE
                    Stat.Detaitem.serailno   = wdetail2.polstk   NO-LOCK NO-ERROR NO-WAIT.
                IF   AVAIL  stat.Detaitem THEN  
                     ASSIGN wdetail2.polstk  = trim(stat.detaitem.policy) .  
                ELSE ASSIGN wdetail2.polstk  = "".
                /* End A60-0232 */
            END.
        END. /*--A59-0590 --*/
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_assign_runpol72 C-Win 
PROCEDURE Pro_assign_runpol72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF nv_undyr <= "1999" THEN nv_undyr2543 = nv_undyr.
ELSE  
    ASSIGN nv_polno2543 = INTEGER(nv_undyr) + 543
        nv_undyr2543 = STRING(nv_polno2543,"9999").
FIND FIRST sicsyac.s0m003 WHERE                         /* not has index */
    TRIM(sicsyac.s0m003.fld11)  = TRIM(nv_branch) AND   
    TRIM(sicsyac.s0m003.fld22)  = TRIM(nv_acno1)  NO-LOCK NO-ERROR NO-WAIT.        /* producer */
IF AVAILABLE sicsyac.s0m003 THEN DO:                    
    ASSIGN 
        nv_brnpol  = sicsyac.s0m003.fld12            /* BRANCH POLICY */
        nv_startno = sicsyac.s0m003.fld21.           /* START NO */
    IF nv_brnpol = "" THEN nv_brnpol = nv_branch.       /* 20/06/1998 */
END.
ELSE DO:    
    ASSIGN nv_startno = ""
        n_policy      = "" .    
    MESSAGE "Place set data running !!!!" VIEW-AS ALERT-BOX.
END. 
IF nv_startno <> "" THEN DO:   /* Running Policy no. */
    running_polno6:                 /*--Running Line 72--*/
    REPEAT:
        FIND FIRST stat.polno_fil USE-INDEX polno01     WHERE
            stat.polno_fil.dir_ri   = nv_dir_ri     AND
            stat.polno_fil.poltyp   = nv_poltyp     AND
            stat.polno_fil.branch   = nv_branch     AND
            stat.polno_fil.undyr    = nv_undyr2543  AND
            stat.polno_fil.brn_pol  = nv_brnpol     AND     /*4M 4=Branch M=Malaysia*/
            stat.polno_fil.start_no = nv_startno    EXCLUSIVE-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAILABLE stat.polno_fil THEN DO:
            IF LOCKED stat.polno_fil THEN DO:
                nv_message = "LOCK".
                RETURN.
            END.
            CREATE stat.polno_fil.
            ASSIGN stat.polno_fil.dir_ri   = nv_dir_ri
                stat.polno_fil.poltyp   = nv_poltyp
                stat.polno_fil.branch   = nv_branch
                stat.polno_fil.brn_pol  = nv_brnpol     /*4M 4=Branch M=Malaysia*/
                stat.polno_fil.undyr    = nv_undyr2543
                stat.polno_fil.start_no = nv_startno    /*1=A 2=AB ""=""*/
                stat.polno_fil.nextno   = 2.
            nv_polno = 1.
        END.
        ELSE DO:   /* AVAILABLE stat.polno_fil */
            ASSIGN
                nv_polno   = stat.polno_fil.nextno  .  
            stat.polno_fil.nextno = nv_polno + 1.   
        END.
        ASSIGN 
            n_policy = "" 
            n_policy = "D".
        IF LENGTH(TRIM(nv_startno)) = 1 THEN 
            /* D M 72 52 H 0 0 0 0 1 */
            n_policy  = TRIM(n_policy) 
            + TRIM(nv_brnpol)
            + SUBSTRING(TRIM(nv_poltyp),2,2)
            + SUBSTRING(nv_undyr2543,3,2) 
            + TRIM(nv_startno) 
            + STRING(nv_polno,"99999").
        ELSE IF LENGTH(TRIM(nv_startno)) = 2 THEN 
            /* D27098VB1234 */
            n_policy  = TRIM(n_policy) 
            + TRIM(nv_brnpol)
            + SUBSTRING(TRIM(nv_poltyp),2,2)
            + SUBSTRING(nv_undyr2543,3,2)
            + TRIM(nv_startno)
            + STRING(nv_polno,"9999").
        ELSE   n_policy  = TRIM(n_policy)
            
            + TRIM(nv_brnpol)
            + SUBSTRING(nv_poltyp,2,2)
            + SUBSTRING(nv_undyr2543,3,2)
            + STRING(nv_polno,"999999").
        RELEASE stat.polno_fil.
        FIND FIRST sicuw.uwm100 USE-INDEX  uwm10001 WHERE
            sicuw.uwm100.policy  =  n_policy  NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicuw.uwm100 THEN LEAVE running_polno6.
         
    END.        /*  repeat  */
END.
RELEASE stat.polno_fil.
ASSIGN wdetail2.polstk = TRIM(n_policy).
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_createfile C-Win 
PROCEDURE Pro_createfile :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".csv"  Then
    fi_outfile  =  Trim(fi_outfile) + ".csv"  .
ASSIGN 
    nv_cnt  =  0
    nv_row  =  1.
OUTPUT  TO VALUE(fi_outfile).
EXPORT DELIMITER "|"
    "TEXT FILE FROM KK (V72)"    SKIP.
EXPORT DELIMITER "|"
    "�Ţ����������.�.�."                                                 
    "�Ţ����ѭ��"               
    "�����Ң�(�������)"                                    
    "�Ң�"                                                         
    "����ö"                                           
    "���¾ú."                                        
    "�������"                                         
    "�ѹ��� �Ѻ���Ф�Ҿú."     
    "�ѹ��������������ͧ"       
    "�ѹ�������ش����������ͧ" 
    "�ӹ��"                     
    "����"                      
    "�Ţ���ѵû�ЪҪ�"                              
    "�������1"                  
    "�������2"                                         
    "�������3"                                         
    "�������4"                                         
    "������ö"                                         
    "���ö"                                           
    "����¹ö"                                            
    "�Ţ��Ƕѧ"                                             
    "�Ţʵ������"                                    
    "����Ѻ�Ż���ª��"                                 
    "�Ţ����Ѻ��"                                    
    "����� (Mkt)"             
    "�����˵�/�ѹ����͡�ú."  
    "KK App "  SKIP.    /*A61-0335*/
RUN Pro_createfile1.                                 
OUTPUT  CLOSE.
message "Export File  Complete"  view-as alert-box.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_createfile1 C-Win 
PROCEDURE Pro_createfile1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
for each wdetail WHERE wdetail.policy NE "" no-lock.  
    EXPORT DELIMITER "|"   
        wdetail.policy                          
        wdetail.cedpol     
        wdetail.br_nam     
        wdetail.branch     
        wdetail.subclass   
        wdetail.volprem    
        wdetail.premt1     
        wdetail.recivedat  
        wdetail.comdat     
        wdetail.expdat     
        wdetail.tiname     
        wdetail.insnam     
        wdetail.idno                      
        wdetail.iadd1      
        wdetail.iadd2      
        wdetail.iadd3      
        wdetail.iadd4      
        wdetail.brand      
        wdetail.model      
        wdetail.vehreg     
        wdetail.chasno                              
        wdetail.stk                                 
        wdetail.benname                             
        wdetail.notifyno                            
        wdetail.namnotify       
        wdetail.nmember 
        wdetail.kkapp . /*a61-0335*/
END.   /*  end  wdetail  */                       
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
for each wdetail WHERE wdetail.policy NE "" no-lock.  
    EXPORT DELIMITER "|"   
        wdetail.policy                          
        wdetail.cedpol     
        wdetail.br_nam     
        wdetail.branch     
        wdetail.subclass   
        wdetail.volprem    
        wdetail.premt1     
        wdetail.recivedat  
        wdetail.comdat     
        wdetail.expdat     
        wdetail.tiname     
        wdetail.insnam     
        wdetail.idno                      
        wdetail.iadd1      
        wdetail.iadd2      
        wdetail.iadd3      
        wdetail.iadd4      
        wdetail.brand      
        wdetail.model      
        wdetail.vehreg     
        wdetail.chasno                              
        wdetail.stk                                 
        wdetail.benname                             
        wdetail.notifyno                            
        wdetail.namnotify       
        wdetail.nmember   
        wdetail.telephone  
        wdetail.titlenam01 
        wdetail.name01     
        wdetail.sernam01   
        wdetail.idnonam01  
        wdetail.titlenam02 
        wdetail.name02     
        wdetail.sernam02   
        wdetail.idnonam02  
        wdetail.titlenam03 
        wdetail.name03     
        wdetail.sernam03   
        wdetail.idnonam03  
        wdetail.nsend       /* A61-0335*/ 
        wdetail.sendname    /* A61-0335*/ 
        wdetail.kkapp  .     /*s61-0335*/ 
END.   /*  end  wdetail  */                       
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_createfilestk C-Win 
PROCEDURE Pro_createfilestk :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".csv"  Then
    fi_outfile  =  Trim(fi_outfile) + ".csv"  .
ASSIGN 
    nv_cnt  =  0
    nv_row  =  1.
OUTPUT  TO VALUE(fi_outfile).
EXPORT DELIMITER "|"
    "TEXT FILE FROM KK (V72)"    SKIP.
EXPORT DELIMITER "|"
    "�Ţ����������.�.�."                                                 
    "�Ţ����ѭ��"               
    "�����Ң�(�������)"                                    
    "�Ң�"                                                         
    "����ö"                                           
    "���¾ú."                                        
    "�������"                                         
    "�ѹ��� �Ѻ���Ф�Ҿú."     
    "�ѹ��������������ͧ"       
    "�ѹ�������ش����������ͧ" 
    "�ӹ��"                     
    "����"                      
    "�Ţ���ѵû�ЪҪ�"                              
    "�������1"                  
    "�������2"                                         
    "�������3"                                         
    "�������4"                                         
    "������ö"                                         
    "���ö"                                           
    "����¹ö"                                            
    "�Ţ��Ƕѧ"                                             
    "�Ţʵ������"                                    
    "����Ѻ�Ż���ª��"                                 
    "�Ţ����Ѻ��"                                    
    "����� (Mkt)"             
    "�����˵�/�ѹ����͡�ú."  
    "KK App "  SKIP.    /*a61-0335*/
RUN Pro_createfilestk1.                                 
OUTPUT  CLOSE.
message "Export File  Complete"  view-as alert-box.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_createfilestk1 C-Win 
PROCEDURE Pro_createfilestk1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
for each wdetail WHERE wdetail.policy NE "" no-lock.  
    EXPORT DELIMITER "|"   
        wdetail.policy                          
        wdetail.cedpol     
        wdetail.br_nam     
        wdetail.branch     
        wdetail.subclass   
        wdetail.volprem    
        wdetail.premt1     
        wdetail.recivedat  
        wdetail.comdat     
        wdetail.expdat     
        wdetail.tiname     
        wdetail.insnam     
        wdetail.idno                      
        wdetail.iadd1      
        wdetail.iadd2      
        wdetail.iadd3      
        wdetail.iadd4      
        wdetail.brand      
        wdetail.model      
        wdetail.vehreg     
        wdetail.chasno                              
        wdetail.stk                                 
        wdetail.benname                             
        wdetail.notifyno                            
        wdetail.namnotify       
        wdetail.nmember   
        wdetail.kkapp .         /*a61-0335*/
END.     /*  end  wdetail  */                       
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_createfile_rel C-Win 
PROCEDURE Pro_createfile_rel :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".csv"  Then
    fi_outfile  =  Trim(fi_outfile) + ".csv"  .
nv_cnt  =   0.
nv_row  =  1.
OUTPUT  TO VALUE(fi_outfile).
EXPORT DELIMITER "|"
    "TEXT FILE FROM KK (V72)"    SKIP.
EXPORT DELIMITER "|"
    "�Ţ����������.�.�."                            
    "�Ţ����ѭ��"               
    "�����Ң�(�������)"              
    "�Ң�"                                   
    "����ö"                     
    "���¾ú."                  
    "�������"                   
    "�ѹ��� �Ѻ���Ф�Ҿú."      
    "�ѹ��������������ͧ"        
    "�ѹ�������ش����������ͧ"  
    "�ӹ��"                      
    "����"                       
    "�Ţ���ѵû�ЪҪ�"                                 
    "�������1"                   
    "�������2"                   
    "�������3"                   
    "�������4"                   
    "������ö"                   
    "���ö"                     
    "����¹ö"                      
    "�Ţ��Ƕѧ"                       
    "�Ţʵ������"              
    "����Ѻ�Ż���ª��"           
    "�Ţ����Ѻ��"              
    "����� (Mkt)"             
    "�����˵�/�ѹ����͡�ú."  SKIP.
                                       
RUN Pro_createfile1.                                 

OUTPUT CLOSE.

message "Export File  Complete"  view-as alert-box.

/*---------------------------------------------------------------------*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_createfile_rel1 C-Win 
PROCEDURE Pro_createfile_rel1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".csv"  Then
    fi_outfile  =  Trim(fi_outfile) + ".csv"  .
nv_cnt  =   0.
nv_row  =  1.
OUTPUT  TO VALUE(fi_outfile).
EXPORT DELIMITER "|"
    "TEXT FILE FROM KK (V72)"    SKIP.
EXPORT DELIMITER "|"
    "�Ţ����������.�.�."                            
    "�Ţ����ѭ��"               
    "�����Ң�(�������)"              
    "�Ң�"                                   
    "����ö"                     
    "���¾ú."                  
    "�������"                   
    "�ѹ��� �Ѻ���Ф�Ҿú."      
    "�ѹ��������������ͧ"        
    "�ѹ�������ش����������ͧ"  
    "�ӹ��"                      
    "����"                       
    "�Ţ���ѵû�ЪҪ�"                                 
    "�������1"                   
    "�������2"                   
    "�������3"                   
    "�������4"                   
    "������ö"                   
    "���ö"                     
    "����¹ö"                      
    "�Ţ��Ƕѧ"                       
    "�Ţʵ������"              
    "����Ѻ�Ż���ª��"           
    "�Ţ����Ѻ��"              
    "����� (Mkt)"             
    "�����˵�/�ѹ����͡�ú." 
    "����Դ���      "  
    "�ӹ�˹�Ҫ��� 1   "  
    "���͡������ 1    "  
    "���ʡ�š������ 1 "  
    "�Ţ���ѵû�ЪҪ�������� 1"  
    "�ӹ�˹�Ҫ��� 2  "  
    "���͡������ 2   "  
    "���ʡ�š������ 2"  
    "�Ţ���ѵû�ЪҪ�������� 2"  
    "�ӹ�˹�Ҫ��� 3   "  
    "���͡������ 3    "  
    "���ʡ�š������ 3 "  
    "�Ţ���ѵû�ЪҪ�������� 3" 
    "�Ѵ���͡��÷���Ң�"            /*A61-0335*/
    "���ͼ���Ѻ�͡��� "              /*A61-0335*/
    "KK ApplicationNo. "     SKIP.   /*A61-0335*/
                                       
RUN Pro_createfile2.                                 

OUTPUT CLOSE.

message "Export File  Complete"  view-as alert-box.

/*---------------------------------------------------------------------*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_importfilenew C-Win 
PROCEDURE pro_importfilenew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
INPUT FROM VALUE(fi_FileName).
REPEAT:
    CREATE wdetail2.
    IMPORT DELIMITER "|" 
        wdetail2.id            /*  1   �ӴѺ���    */                                      
        wdetail2.companame     /*  2   ����ѷ��Сѹ    */                 
        wdetail2.polstk        /*  3   �Ţ����������.�.�.    */         
        wdetail2.idbranch      /*  4   �����Ң�    */                     
        wdetail2.branchname    /*  5   �Ң� KK */                         
        wdetail2.cedpol        /*  6   �Ţ����ѭ��     */                 
        wdetail2.titlenam      /*  7   �ӹ�˹�Ҫ���    */                 
        wdetail2.insurnam      /*  8   ���ͼ����һ�Сѹ    */             
        wdetail2.sername       /*  9   ���ʡ�ż����һ�Сѹ */             
        wdetail2.vehreg        /*  10  �Ţ����¹  */                     
        wdetail2.brand         /*  11  ������ö    */                     
        wdetail2.notifyno      /*  12  �Ţ����Ѻ��   */                 
        wdetail2.namnotify     /*  13  �������˹�ҷ�� MKT */             
        wdetail2.chassis       /*  14  �Ţ���ö    */                     
        wdetail2.comp          /*  15  �����ط��  */                     
        wdetail2.premt         /*  16  ���»�Сѹ��������ҡ�  */         
        wdetail2.comdat        /*  17  �ѹ������� �.�.�.  */             
        wdetail2.expdat        /*  18  �ѹ����ش �.�.�.   */             
        wdetail2.adr_no1       /*  19  ������� */                         
        wdetail2.adr_mu        /*  ����    */                             
        wdetail2.adr_muban     /*  �����ҹ    */                         
        wdetail2.adr_build     /*  �Ҥ��   */                             
        wdetail2.adr_soy       /*  ��� */                                 
        wdetail2.adr_road      /*  ��� */                                 
        wdetail2.adr_tambon    /*  �Ӻ�/�ǧ   */                         
        wdetail2.adr_amper     /*  �����/ࢵ   */                         
        wdetail2.adr_country   /*  �ѧ��Ѵ */                             
        wdetail2.adr_post      /*  ������ɳ���    */                     
        wdetail2.memmo         /*  20  �����˵�    */                     
        wdetail2.telephone     /*  21  ����Դ��� */                     
        wdetail2.idno          /*  22  �Ţ���ѵû�ЪҪ�   */             
        /*wdetail2.birdthday */    /*  23  �ѹ��͹���Դ  */                  /*A60-0232*/           
        /*wdetail2.occoup    */    /*  24  �Ҫվ   */                          /*A60-0232*/
        /*wdetail2.nstatus   */    /*  25  ʶҹ��Ҿ    */                      /*A60-0232*/
        /*wdetail2.idvatno   */    /*  26  �Ţ��Шӵ�Ǽ�����������ҡ�  */      /*A60-0232*/
        wdetail2.titlenam01    /*  27  �ӹ�˹�Ҫ���1   */                    
        wdetail2.name01        /*  28  ���͡������1    */                    
        wdetail2.sernam01      /*  29  ���ʡ�š������1 */                    
        wdetail2.idnonam01     /*  30  �Ţ���ѵû�ЪҪ��������1   */        
        wdetail2.titlenam02    /*  31  �ӹ�˹�Ҫ���2   */                    
        wdetail2.name02        /*  32  ���͡������2    */                    
        wdetail2.sernam02      /*  33  ���ʡ�š������2 */                    
        wdetail2.idnonam02     /*  34  �Ţ���ѵû�ЪҪ��������2   */        
        wdetail2.titlenam03    /*  35  �ӹ�˹�Ҫ���3   */                 
        wdetail2.name03        /*  36  ���ͼ��������3 */                          
        wdetail2.sernam03      /*  37  ���ʡ�š������3 */                       
        wdetail2.idnonam03     /*  38  �Ţ���ѵû�ЪҪ��������3   */ 
        wdetail2.nsend         /* A61-0335*/
        wdetail2.sendname      /* A61-0335*/
        wdetail2.kkapp .       /* A61-0335*/

END.    /* repeat  */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_importfileold C-Win 
PROCEDURE pro_importfileold :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
INPUT FROM VALUE(fi_FileName).
REPEAT:
    CREATE wdetail2.
    IMPORT DELIMITER "|" 
        wdetail2.id           /*1  �ӴѺ���    */                
        wdetail2.br_nam       /*2  �Ң�    */                    
        wdetail2.polstk       /*3  �Ţ����������.�.�.    */    
        wdetail2.number       /*4  �Ţ���ʵ������.�.�.  */    
        wdetail2.recivedat    /*5  �ѹ��� �Ѻ���Ф�Ҿú.   */    
        wdetail2.cedpol       /*6  �Ţ����ѭ�� */                
        wdetail2.insurnam     /*7  ���� - ���ʡ��  */            
        wdetail2.idno         /*8  �Ţ���ѵû�ЪҪ��١���     */
        wdetail2.vehreg       /*9  �Ţ����¹  */                
        wdetail2.brand        /*10 ������ö    */                
        wdetail2.model        /*11 ���ö  */                    
        wdetail2.notifyno     /*12 �Ţ����Ѻ��   */            
        wdetail2.namnotify    /*13 ����� (Mkt)   */            
        wdetail2.chassis      /*14 �Ţ��Ƕѧö */                
        wdetail2.comp         /*15 �����ط��  */                
        wdetail2.premt        /*16 �������    */                
        wdetail2.comdat       /*17 ��������ѹ���  */            
        wdetail2.expdat       /*18 �ѹ�������ش   */            
        wdetail2.memmo        /*19 ������� */ 
        wdetail2.kkapp .  /*a61-0335*/
END.    /* repeat  */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_importfilestk C-Win 
PROCEDURE pro_importfilestk :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
INPUT FROM VALUE(fi_FileName).
REPEAT:
    CREATE wdetail2.
    IMPORT DELIMITER "|" 
        wdetail2.id           /*1  �ӴѺ���    */                
        wdetail2.br_nam       /*2  �Ң�        */                    
        wdetail2.polstk       /*3  �Ţ����������.�.�.    */    
        wdetail2.number       /*4  �Ţ���ʵ������.�.�.  */    
        wdetail2.recivedat    /*5  �ѹ��� �Ѻ���Ф�Ҿú.   */    
        wdetail2.cedpol       /*6  �Ţ����ѭ��             */                
        wdetail2.insurnam     /*7  ���� - ���ʡ��          */            
        wdetail2.idno         /*8  �Ţ���ѵû�ЪҪ��١��� */
        wdetail2.vehreg       /*9  �Ţ����¹  */                
        wdetail2.brand        /*10 ������ö    */                
        wdetail2.model        /*11 ���ö  */                    
        wdetail2.notifyno     /*12 �Ţ����Ѻ��   */            
        wdetail2.namnotify    /*13 ����� (Mkt)   */            
        wdetail2.chassis      /*14 �Ţ��Ƕѧö */                
        wdetail2.comp         /*15 �����ط��  */                
        wdetail2.premt        /*16 �������    */                
        wdetail2.comdat       /*17 ��������ѹ���  */            
        wdetail2.expdat       /*18 �ѹ�������ش   */            
        wdetail2.ad11         /*19 ������� */   
        wdetail2.ad12
        wdetail2.ad13
        wdetail2.ad14 
        wdetail2.kkapp .     /*a61-0335*/

END.                          /* repeat    */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

