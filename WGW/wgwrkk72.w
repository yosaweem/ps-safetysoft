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
/*Modify by Kridtiya i. A56-0309 เพิ่มการแปลงที่อยู่ ตามไฟล์แจ้งงานใหม่ */
/*modity by  : Kridtiya i. A57-0274 เพิ่มไฟล์ข้อมูลแสดงการรับประกันภัย พรบ.*/
/*modity by  : Kridtiya i. A57-0434 เพิ่มขนาดช่องหมายเหตุจากเดิม 40เป็น 150 ตัวอักษร*/
/*modity by  : Ranu i. A59-0590 เช็คข้อมูล พรบ.จากช่องเบี้ยพรบ.*/
/*modity by  : Ranu i. A60-0232 แก้ไขการ matchfile Newfile , new form*/
/*modify by  : Ranu I. A61-0335 เพิ่มคอลัมน์รับค่าจากไฟล์ */
/*Modify By  : Porntiwa T. A62-0105 Change Head icon*/
/*Modify by  : Kridtiya i. A63-00472 ปรับการค้นข้อมูลด้วยเลขที่สัญญา KeyApp */
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
    FIELD adr_no1          AS CHAR FORMAT "x(50)" INIT ""  /* add A56-0309 บ้านเลขที่*/     
    FIELD adr_mu           AS CHAR FORMAT "x(50)" INIT ""  /* add A56-0309 หมู่     */         
    FIELD adr_muban        AS CHAR FORMAT "x(50)" INIT ""  /* add A56-0309 หมู่บ้าน */     
    FIELD adr_build        AS CHAR FORMAT "x(50)" INIT ""  /* add A56-0309 อาคาร    */         
    FIELD adr_soy          AS CHAR FORMAT "x(50)" INIT ""  /* add A56-0309 ซอย      */             
    FIELD adr_road         AS CHAR FORMAT "x(50)" INIT ""  /* add A56-0309 ถนน      */             
    FIELD adr_tambon       AS CHAR FORMAT "x(50)" INIT ""  /* add A56-0309 ตำบล/แขวง*/     
    FIELD adr_amper        AS CHAR FORMAT "x(50)" INIT ""  /* add A56-0309 อำเภอ/เขต*/     
    FIELD adr_country      AS CHAR FORMAT "x(50)" INIT ""  /* add A56-0309 จังหวัด  */         
    FIELD adr_post         AS CHAR FORMAT "x(50)" INIT ""  /* add A56-0309 รหัสไปรษณีย์*/ 
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
     "Text file name(KK_พรบ.) :":30 VIEW-AS TEXT
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
      gv_prog  = "Export File KK(พรบ.) to Excel".
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
IF INDEX(nv_c,"คุณ") NE  0 THEN 
    ASSIGN  ind = 4 
    wdetail2.insurnam = TRIM(SUBSTR(nv_c,ind,nv_l)).
ELSE IF INDEX(nv_c,"นาย") NE  0 THEN 
    ASSIGN  ind = 4 
    nv_i = "นาย"
    wdetail2.insurnam = TRIM(SUBSTR(nv_c,ind,nv_l)).
ELSE IF INDEX(nv_c,"น.ส.") NE  0 THEN 
    ASSIGN  ind = 5 
    wdetail2.insurnam = TRIM(SUBSTR(nv_c,ind,nv_l)).
ELSE IF INDEX(nv_c,"นางสาว ") NE 0  THEN 
    ASSIGN  ind = 7
    wdetail2.insurnam = TRIM(SUBSTR(nv_c,ind,nv_l)).
ELSE IF INDEX(nv_c,"นาง") NE 0  THEN 
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
/*1*/   IF      n_vehnew = "กระบี่"          OR n_vehnew = "กบ."   THEN n_vehnew = "กบ".
/*2*/   ELSE IF n_vehnew = "กรุงเทพมหานคร"   OR n_vehnew = "กรุงเทพ"  OR n_vehnew = "กทม."   THEN n_vehnew = "กท".
/*3*/   ELSE IF n_vehnew = "กาญจนบุรี"       OR n_vehnew = "กจ."  THEN n_vehnew = "กจ".
/*4*/   ELSE IF n_vehnew = "กาฬสินธุ์"       OR n_vehnew = "กส."  THEN n_vehnew = "กส".
/*5*/   ELSE IF (n_vehnew = "กำแพงเพชร") OR (n_vehnew = "กพ.")    THEN n_vehnew = "กพ".
/*6*/   ELSE IF n_vehnew = "ขอนแก่น"         OR n_vehnew = "ขก."  THEN n_vehnew = "ขก".
/*7*/   ELSE IF n_vehnew = "จันทบุรี"        OR n_vehnew = "จบ."  THEN n_vehnew = "จบ".
/*8*/   ELSE IF n_vehnew = "ฉะเชิงเทรา"      OR n_vehnew = "ฉช."  THEN n_vehnew = "ฉช".
/*9*/   ELSE IF n_vehnew = "ชลบุรี"          OR n_vehnew = "ชบ."  THEN n_vehnew = "ชบ".
/*10*/  ELSE IF n_vehnew = "ชัยนาท"          OR n_vehnew = "ชน."  THEN n_vehnew = "ชน".
/*11*/  ELSE IF n_vehnew = "ชัยภูมิ"         OR n_vehnew = "ชย."  THEN n_vehnew = "ชย".
/*12*/  ELSE IF n_vehnew = "ชุมพร"           OR n_vehnew = "ชพ."  THEN n_vehnew = "ชพ".
/*13*/  ELSE IF n_vehnew = "เชียงราย"        OR n_vehnew = "ชร."  THEN n_vehnew = "ชร".
/*14*/  ELSE IF n_vehnew = "เชียงใหม่"       OR n_vehnew = "ชม."  THEN n_vehnew = "ชม".
/*15*/  ELSE IF n_vehnew = "ตรัง"            OR n_vehnew = "ตง."  THEN n_vehnew = "ตง".
/*16*/  ELSE IF n_vehnew = "ตราด"            OR n_vehnew = "ตร."  THEN n_vehnew = "ตร".
/*17*/  ELSE IF n_vehnew = "ตาก"             OR n_vehnew = "ตก."  THEN n_vehnew = "ตก".
/*18*/  ELSE IF n_vehnew = "นครนายก"         OR n_vehnew = "นย."  THEN n_vehnew = "นย".
/*19*/  ELSE IF n_vehnew = "นครปฐม"          OR n_vehnew = "นฐ."  THEN n_vehnew = "นฐ".
/*20*/  ELSE IF n_vehnew = "นครพนม"          OR n_vehnew = "นพ."  THEN n_vehnew = "นพ".
/*21*/  ELSE IF n_vehnew = "นครราชสีมา"      OR n_vehnew = "นม."  THEN n_vehnew = "นม".
/*22*/  ELSE IF n_vehnew = "นครศรีธรรมราช"   OR n_vehnew = "นครศรีฯ"   OR n_vehnew = "นศ."  THEN n_vehnew = "นศ".
/*23*/  ELSE IF (n_vehnew = "นครสวรรค์" )    OR (n_vehnew = "นว.")  THEN n_vehnew = "นว".
/*24*/  ELSE IF n_vehnew = "นนทบุรี"         OR n_vehnew = "นบ."  THEN n_vehnew = "นบ".
/*25*/  ELSE IF n_vehnew = "นราธวาส"         OR n_vehnew = "นธ."  THEN n_vehnew = "นธ".
/*26*/  ELSE IF n_vehnew = "น่าน"            OR n_vehnew = "นน."  THEN n_vehnew = "นน".
/*27*/  ELSE IF n_vehnew = "บุรีรัมย์"       OR n_vehnew = "บร."  THEN n_vehnew = "บร".
/*28*/  ELSE IF n_vehnew = "ปทุมธานี"        OR n_vehnew = "ปท."  THEN n_vehnew = "ปท".
/*29*/  ELSE IF n_vehnew = "ประจวบคีรีขันธ์" OR n_vehnew = "ปข."  THEN n_vehnew = "ปข".
/*30*/  ELSE IF n_vehnew = "ปราจีนบุรี"      OR n_vehnew = "ปจ."  THEN n_vehnew = "ปจ".
/*31*/  ELSE IF n_vehnew = "ปัตตานี"         OR n_vehnew = "ปน."  THEN n_vehnew = "ปน".
/*32*/  ELSE IF n_vehnew = "พระนครศรีอยุธยา" OR n_vehnew = "อยุธยา" THEN n_vehnew = "อย".
/*33*/  ELSE IF n_vehnew = "พะเยา"           OR n_vehnew = "พย."   THEN n_vehnew = "พย".
/*34*/  ELSE IF n_vehnew = "พังงา"           OR n_vehnew = "พง."   THEN n_vehnew = "พง".
/*35*/  ELSE IF n_vehnew = "พัทลุง"          OR n_vehnew = "พท."   THEN n_vehnew = "พท".
/*36*/  ELSE IF n_vehnew = "พิจิตร"          OR n_vehnew = "พจ."   THEN n_vehnew = "พจ".
/*37*/  ELSE IF n_vehnew = "พิษณุโลก"        OR n_vehnew = "พล."   THEN n_vehnew = "พล".
/*38*/  ELSE IF n_vehnew = "เพชรบุรี"        OR n_vehnew = "พบ."   THEN n_vehnew = "พบ".
/*39*/  ELSE IF n_vehnew = "เพชรบูรณ์"       OR n_vehnew = "พช."   THEN n_vehnew = "พช".
/*40*/  ELSE IF n_vehnew = "แพร่"            OR n_vehnew = "พร."   THEN n_vehnew = "พร".
/*41*/  ELSE IF n_vehnew = "ภูเก็ต"          OR n_vehnew = "ภก."   THEN n_vehnew = "ภก".
/*42*/  ELSE IF n_vehnew = "มหาสารคาม"       OR n_vehnew = "มค."   THEN n_vehnew = "มค".
/*43*/  ELSE IF n_vehnew = "มุกดาหาร"        OR  n_vehnew = "มห."   THEN n_vehnew = "มห".
/*44*/  ELSE IF n_vehnew = "แม่ฮ่องสอน"      OR  n_vehnew = "มส."   THEN n_vehnew = "มส".
/*45*/  ELSE IF n_vehnew = "ยะลา"            OR  n_vehnew = "ยล."   THEN n_vehnew = "ยล".
/*46*/  ELSE IF n_vehnew = "ร้อยเอ็ด"        OR  n_vehnew = "รอ."   THEN n_vehnew = "รอ".
/*47*/  ELSE IF n_vehnew = "ระนอง"           OR  n_vehnew = "รน."   THEN n_vehnew = "รน".
/*48*/  ELSE IF n_vehnew = "ระยอง"           OR  n_vehnew = "รย."  THEN n_vehnew = "รย".
/*49*/  ELSE IF n_vehnew = "ราชบุรี"         OR  n_vehnew = "รบ."  THEN n_vehnew = "รบ".
/*50*/  ELSE IF n_vehnew = "ลพบุรี"          OR  n_vehnew = "ลบ."  THEN n_vehnew = "ลบ".
/*51*/  ELSE IF n_vehnew = "ลำปาง"           OR  n_vehnew = "ลป."  THEN n_vehnew = "ลป".
/*52*/  ELSE IF n_vehnew = "ลำพูน"           OR  n_vehnew = "ลพ."  THEN n_vehnew = "ลพ".
/*53*/  ELSE IF n_vehnew = "เลย"             OR  n_vehnew = "ลย."  THEN n_vehnew = "ลย".
/*54*/  ELSE IF n_vehnew = "ศรีสะเกษ"        OR  n_vehnew = "ศก."  THEN n_vehnew = "ศก".
/*55*/  ELSE IF n_vehnew = "สกลนคร"          OR  n_vehnew = "สน."  THEN n_vehnew = "สน".
/*56*/  ELSE IF n_vehnew = "สงขลา"           OR  n_vehnew = "สข."  THEN n_vehnew = "สข".
/*57*/  ELSE IF n_vehnew = "สระแก้ว"         OR  n_vehnew = "สก."  THEN n_vehnew = "สก".
/*58*/  ELSE IF n_vehnew = "สระบุรี"         OR  n_vehnew = "สบ."  THEN n_vehnew = "สบ".
/*59*/  ELSE IF n_vehnew = "สิงห์บุรี"       OR  n_vehnew = "สห."  THEN n_vehnew = "สห".
/*60*/  ELSE IF n_vehnew = "สุโขทัย"         OR  n_vehnew = "สท"  THEN n_vehnew = "สท".
/*61*/  ELSE IF n_vehnew = "สุพรรณบุรี"      OR  n_vehnew = "สพ."  THEN n_vehnew = "สพ".
/*62*/  ELSE IF (n_vehnew = "สุราษฎร์ธานี" ) OR (n_vehnew = "สุราษฏร์") OR
                (n_vehnew = "สฎ." )          OR (n_vehnew = "สุราษฏร์ธานี") THEN n_vehnew = "สฎ".
/*63*/  ELSE IF n_vehnew = "สุรินทร์"        OR n_vehnew = "สร."  THEN n_vehnew = "สร".
/*64*/  ELSE IF n_vehnew = "หนองคาย"         OR n_vehnew = "นค."  THEN n_vehnew = "นค".
/*65*/  ELSE IF n_vehnew = "หนองบัวลำภู"     OR n_vehnew = "นล."  THEN n_vehnew = "นล".
/*66*/  ELSE IF n_vehnew = "อ่างทอง"         OR n_vehnew = "อท."  THEN n_vehnew = "อท".
/*67*/  ELSE IF n_vehnew = "อำนาจเจริญ"      OR n_vehnew = "อจ."  THEN n_vehnew = "อจ".
/*68*/  ELSE IF n_vehnew = "อุดรธานี"        OR n_vehnew = "อด."  THEN n_vehnew = "อด".
/*69*/  ELSE IF n_vehnew = "อุตรดิตถ์"       OR n_vehnew = "อต."  THEN n_vehnew = "อต".
/*70*/  ELSE IF n_vehnew = "อุทัยธานี"       OR n_vehnew = "อน."  THEN n_vehnew = "อน".
/*71*/  ELSE IF n_vehnew = "อุบลราชธานี"     OR n_vehnew = "อบ."  THEN n_vehnew = "อบ".
/*72*/  ELSE IF n_vehnew = "ยโสธร"           OR n_vehnew = "ยส."  THEN n_vehnew = "ยส".
/*73*/  ELSE IF n_vehnew = "สตูล"            OR n_vehnew = "สต."  THEN n_vehnew = "สต".
/*74*/  ELSE IF n_vehnew = "สุมทรปราการ"     OR n_vehnew = "สป."  THEN n_vehnew = "สป".
/*75*/  ELSE IF n_vehnew = "สุมทรสงคราม"     OR n_vehnew = "สส."  THEN n_vehnew = "สส".
/*76*/  ELSE IF n_vehnew = "สุมทรสาคร"       OR n_vehnew = "สค."  THEN n_vehnew = "สค".
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
    ELSE IF INDEX(wdetail2.id,"ลำดับ")  <> 0  THEN DELETE wdetail2.
    ELSE IF INDEX(wdetail2.id,"เลขที่") <> 0  THEN DELETE wdetail2.
    ELSE DO:
        IF wdetail2.br_nam <> ""   THEN ASSIGN wdetail2.br_nam = trim(REPLACE(wdetail2.br_nam,"สาขา","")).
        IF wdetail2.cedpol NE "" THEN DO:
            /*ไฟล์เดิม ให้ที่อยู่ ตามสาขา ธนาคารเกียรตินาคิน */
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
        IF n_dayno GE 1  THEN DO:  /* 1 ปีขึ้นไป */
            IF deci(wdetail2.comp) LE 1099  THEN DO: 
                IF deci(wdetail2.comp) LE 899 THEN DO: 
                    IF deci(wdetail2.comp) LE 599 THEN ASSIGN wdetail2.class = "110".
                    ELSE ASSIGN wdetail2.class = "110".
                END.
                ELSE ASSIGN wdetail2.class = "140A".
            END.
            ELSE ASSIGN wdetail2.class = "120A". 
        END.
        ELSE DO:  /* ไม่ถึง ปี 1 */
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
            ASSIGN wdetail2.titlenam   = "คุณ".
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
                    wdetail.benname     = "ธนาคาร เกียรตินาคิน จำกัด (มหาชน)"                         
                    wdetail.volprem     = wdetail2.comp                                                    
                    wdetail.premt1      = wdetail2.premt        /*เบี้ยรวม*/    
                    wdetail.comment     = ""                                                            
                    wdetail.delerco     = ""   /*wdetail2.cc เก็บค่า vatcode*/                     
                    wdetail.entdat      = string(TODAY)             /*entry date*/                 
                    wdetail.enttim      = STRING(TIME, "HH:MM:SS")  /*entry time*/                 
                    wdetail.trandat     = STRING(TODAY)             /*tran date*/                  
                    wdetail.trantim     = STRING(TIME, "HH:MM:SS")  /*tran time*/                  
                    wdetail.n_IMPORT    = "IM"                                                     
                    wdetail.n_EXPORT    = ""                                                       
                    wdetail.number      = wdetail2.number                                          
                    wdetail.cedpol      = wdetail2.cedpol                                          
                    wdetail.recivedat   = wdetail2.recivedat        /*วันที่ รับชำระค่าพรบ. */     
                    wdetail.br_nam      = wdetail2.br_nam           /*สาขา*/                       
                    wdetail.notifyno    = wdetail2.notifyno         /*เลขที่รับแจ้ง*/              
                    wdetail.namnotify   = wdetail2.namnotify        /*ผู้แจ้ง (Mkt)*/              
                    wdetail.nmember     = wdetail2.memmo .          /*หมายเหตุ/วันที่ออกพรบ.*/     
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
                    wdetail.benname     = "ธนาคาร เกียรตินาคิน จำกัด (มหาชน)"                         
                    wdetail.volprem     = wdetail2.comp                                                    
                    wdetail.premt1      = wdetail2.premt        /*เบี้ยรวม*/    
                    wdetail.comment     = ""                                                            
                    wdetail.delerco     = ""   /*wdetail2.cc เก็บค่า vatcode*/                     
                    wdetail.entdat      = string(TODAY)             /*entry date*/                 
                    wdetail.enttim      = STRING(TIME, "HH:MM:SS")  /*entry time*/                 
                    wdetail.trandat     = STRING(TODAY)             /*tran date*/                  
                    wdetail.trantim     = STRING(TIME, "HH:MM:SS")  /*tran time*/                  
                    wdetail.n_IMPORT    = "IM"                                                     
                    wdetail.n_EXPORT    = ""                                                       
                    wdetail.number      = wdetail2.number                                          
                    wdetail.cedpol      = wdetail2.cedpol                                          
                    wdetail.recivedat   = wdetail2.recivedat        /*วันที่ รับชำระค่าพรบ. */     
                    wdetail.br_nam      = wdetail2.br_nam           /*สาขา*/                       
                    wdetail.notifyno    = wdetail2.notifyno         /*เลขที่รับแจ้ง*/              
                    wdetail.namnotify   = wdetail2.namnotify        /*ผู้แจ้ง (Mkt)*/              
                    wdetail.nmember     = wdetail2.memmo .          /*หมายเหตุ/วันที่ออกพรบ.*/     
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
                wdetail.recivedat   = TRIM(wdetail2.recivedat)    /*วันที่ รับชำระค่าพรบ. */
                wdetail.br_nam      = trim(wdetail2.idbranch) + "-" +   
                                      trim(wdetail2.branchname) 
                                      /*trim(wdetail2.br_nam) */      /*สาขา*/ 
                wdetail.notifyno    = trim(wdetail2.notifyno)     /*เลขที่รับแจ้ง*/ 
                wdetail.namnotify   = TRIM(wdetail2.namnotify)    /*ผู้แจ้ง (Mkt)*/ 
                wdetail.nmember     = trim(wdetail2.memmo)       /*หมายเหตุ/วันที่ออกพรบ.*/ 
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
                wdetail.premt1      = wdetail2.premt        /*เบี้ยรวม*/    
                wdetail.comment     = ""                                                            
                wdetail.delerco     = ""   /*wdetail2.cc เก็บค่า vatcode*/                     
                wdetail.entdat      = string(TODAY)             /*entry date*/                 
                wdetail.enttim      = STRING(TIME, "HH:MM:SS")  /*entry time*/                 
                wdetail.trandat     = STRING(TODAY)             /*tran date*/                  
                wdetail.trantim     = STRING(TIME, "HH:MM:SS")  /*tran time*/                  
                wdetail.n_IMPORT    = "IM"                                                     
                wdetail.n_EXPORT    = ""                                                       
                wdetail.number      = wdetail2.number                                          
                wdetail.cedpol      = wdetail2.cedpol                                          
                wdetail.recivedat   = wdetail2.recivedat        /*วันที่ รับชำระค่าพรบ. */     
                wdetail.br_nam      = trim(wdetail2.idbranch) + "-" +   
                                      trim(wdetail2.branchname)          /*สาขา*/                       
                wdetail.notifyno    = wdetail2.notifyno         /*เลขที่รับแจ้ง*/              
                wdetail.namnotify   = wdetail2.namnotify        /*ผู้แจ้ง (Mkt)*/              
                wdetail.nmember     = wdetail2.memmo          /*หมายเหตุ/วันที่ออกพรบ.*/  
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
    ELSE IF INDEX(wdetail2.id,"ลำดับ")  <> 0  THEN DELETE wdetail2.
    ELSE IF INDEX(wdetail2.id,"เลขที่") <> 0  THEN DELETE wdetail2.
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
        IF wdetail2.br_nam <> ""   THEN ASSIGN wdetail2.br_nam = trim(REPLACE(wdetail2.br_nam,"สาขา","")).
        IF wdetail2.cedpol NE "" THEN DO:
            /*ไฟล์เดิม ให้ที่อยู่ ตามสาขา ธนาคารเกียรตินาคิน */
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
             IF index(wdetail2.insurnam,"บริษัท") <> 0 THEN DO:  
                 ASSIGN wdetail2.titlenam   = "บริษัท"
                        wdetail2.insurnam   = trim(substr(wdetail2.insurnam,LENGTH(wdetail2.titlenam) + 1 )).
             END.
             ELSE IF index(wdetail2.insurnam,"บ.") <> 0 THEN DO:   
                 ASSIGN wdetail2.titlenam   = "บ."
                        wdetail2.insurnam   = trim(substr(wdetail2.insurnam,LENGTH(wdetail2.titlenam) + 1 )).
             END.
             ELSE IF index(wdetail2.insurnam,"บจก.") <> 0 THEN DO: 
                 ASSIGN wdetail2.titlenam   = "บจก."
                        wdetail2.insurnam   = trim(substr(wdetail2.insurnam,LENGTH(wdetail2.titlenam) + 1 )).
             END.
             ELSE IF index(wdetail2.insurnam,"หจก.") <> 0 THEN DO: 
                 ASSIGN wdetail2.titlenam   = "หจก."
                        wdetail2.insurnam   = trim(substr(wdetail2.insurnam,LENGTH(wdetail2.titlenam) + 1 )).
             END.
             ELSE IF index(wdetail2.insurnam,"หสน.") <> 0 THEN DO:   
                 ASSIGN wdetail2.titlenam   = "หสน."
                        wdetail2.insurnam   = trim(substr(wdetail2.insurnam,LENGTH(wdetail2.titlenam) + 1 )).
             END.
             ELSE IF index(wdetail2.insurnam,"บรรษัท") <> 0 THEN DO:  
                 ASSIGN wdetail2.titlenam   = "บรรษัท"
                        wdetail2.insurnam   = trim(substr(wdetail2.insurnam,LENGTH(wdetail2.titlenam) + 1 )).
             END.
             ELSE IF index(wdetail2.insurnam,"มูลนิธิ") <> 0 THEN DO:  
                 ASSIGN wdetail2.titlenam   = "มูลนิธิ"
                        wdetail2.insurnam   = trim(substr(wdetail2.insurnam,LENGTH(wdetail2.titlenam))).
             END.
             ELSE IF index(wdetail2.insurnam,"ห้างหุ้นส่วนจำกัด") <> 0 THEN DO:
                 ASSIGN wdetail2.titlenam   = "ห้างหุ้นส่วนจำกัด"
                        wdetail2.insurnam   = trim(substr(wdetail2.insurnam,LENGTH(wdetail2.titlenam) + 1 )).
             END.
             ELSE IF index(wdetail2.insurnam,"ห้างหุ้นส่วนจำก") <> 0  THEN DO:
                 ASSIGN wdetail2.titlenam   = "ห้างหุ้นส่วนจำกัด"
                        wdetail2.insurnam   = trim(substr(wdetail2.insurnam,LENGTH(wdetail2.titlenam) - 2 )).
             END.
             ELSE IF index(wdetail2.insurnam,"ห้างหุ้นส่วน") <> 0 THEN DO:  
                 ASSIGN wdetail2.titlenam   = "ห้างหุ้นส่วน"
                        wdetail2.insurnam   = trim(substr(wdetail2.insurnam,LENGTH(wdetail2.titlenam) + 1 )).
             END.
             ELSE IF index(wdetail2.insurnam,"ห้าง") <> 0 THEN DO: 
                 ASSIGN wdetail2.titlenam   = "ห้าง"
                        wdetail2.insurnam   = trim(substr(wdetail2.insurnam,LENGTH(wdetail2.titlenam) + 1 )).
             END.
             ELSE ASSIGN wdetail2.titlenam   = "คุณ".
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
                    wdetail.benname     = "ธนาคาร เกียรตินาคิน จำกัด (มหาชน)"                         
                    wdetail.volprem     = wdetail2.comp                                                    
                    wdetail.premt1      = wdetail2.premt        /*เบี้ยรวม*/    
                    wdetail.comment     = ""                                                            
                    wdetail.delerco     = ""   /*wdetail2.cc เก็บค่า vatcode*/                     
                    wdetail.entdat      = string(TODAY)             /*entry date*/                 
                    wdetail.enttim      = STRING(TIME, "HH:MM:SS")  /*entry time*/                 
                    wdetail.trandat     = STRING(TODAY)             /*tran date*/                  
                    wdetail.trantim     = STRING(TIME, "HH:MM:SS")  /*tran time*/                  
                    wdetail.n_IMPORT    = "IM"                                                     
                    wdetail.n_EXPORT    = ""                                                       
                    wdetail.number      = wdetail2.number                                          
                    wdetail.cedpol      = wdetail2.cedpol                                          
                    wdetail.recivedat   = wdetail2.recivedat        /*วันที่ รับชำระค่าพรบ. */     
                    wdetail.br_nam      = "สาขา" + wdetail2.br_nam           /*สาขา*/                       
                    wdetail.notifyno    = wdetail2.notifyno         /*เลขที่รับแจ้ง*/              
                    wdetail.namnotify   = wdetail2.namnotify        /*ผู้แจ้ง (Mkt)*/              
                    wdetail.nmember     = wdetail2.memmo .          /*หมายเหตุ/วันที่ออกพรบ.*/  
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
                    wdetail.benname    = "ธนาคาร เกียรตินาคิน จำกัด (มหาชน)"                         
                    wdetail.volprem    = wdetail2.comp                                                    
                    wdetail.premt1     = wdetail2.premt        /*เบี้ยรวม*/    
                    wdetail.comment    = ""                                                            
                    wdetail.delerco    = ""   /*wdetail2.cc เก็บค่า vatcode*/                     
                    wdetail.entdat     = string(TODAY)             /*entry date*/                 
                    wdetail.enttim     = STRING(TIME, "HH:MM:SS")  /*entry time*/                 
                    wdetail.trandat    = STRING(TODAY)             /*tran date*/                  
                    wdetail.trantim    = STRING(TIME, "HH:MM:SS")  /*tran time*/                  
                    wdetail.n_IMPORT   = "IM"                                                     
                    wdetail.n_EXPORT   = ""                                                       
                    wdetail.number     = wdetail2.number                                          
                    wdetail.cedpol     = wdetail2.cedpol                                          
                    wdetail.recivedat  = wdetail2.recivedat        /*วันที่ รับชำระค่าพรบ. */     
                    wdetail.br_nam     = "สาขา" + wdetail2.br_nam           /*สาขา*/                       
                    wdetail.notifyno   = wdetail2.notifyno         /*เลขที่รับแจ้ง*/              
                    wdetail.namnotify  = wdetail2.namnotify        /*ผู้แจ้ง (Mkt)*/              
                    wdetail.nmember    = wdetail2.memmo .          /*หมายเหตุ/วันที่ออกพรบ.*/  
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
IF (wdetail2.adr_no1    <> "")  THEN  wdetail2.ad11 = TRIM(wdetail2.adr_no1).                                  /*  19  ที่อยู่ */    
IF (wdetail2.adr_mu     <> "")  THEN  wdetail2.ad11 = trim(wdetail2.ad11 + " หมู่ " + TRIM(wdetail2.adr_mu)).  /*  หมู่    */        
IF (wdetail2.adr_muban  <> "")  THEN  wdetail2.ad11 = trim(wdetail2.ad11 + " " + TRIM(wdetail2.adr_muban)).    /*  หมู่บ้าน    */    
IF (wdetail2.adr_build  <> "")  THEN DO:
    IF LENGTH(wdetail2.ad11 + " " + TRIM(wdetail2.adr_build)) > 35  THEN 
        ASSIGN wdetail2.ad12 = trim(wdetail2.ad12 + " อาคาร" + TRIM(wdetail2.adr_build)).
    ELSE 
        ASSIGN wdetail2.ad11 = wdetail2.ad11 + " อาคาร" + TRIM(wdetail2.adr_build)
               wdetail2.ad12 =   " " .
END.
IF (wdetail2.adr_soy    <> "")  THEN DO:  
    IF LENGTH(wdetail2.ad11 + " ซอย" + TRIM(wdetail2.adr_soy)) > 35  THEN
        ASSIGN wdetail2.ad12 = wdetail2.ad12 + " ซอย" + TRIM(wdetail2.adr_soy).      /*  ซอย */              
    ELSE 
        ASSIGN wdetail2.ad11 = wdetail2.ad11 + " ซอย" + TRIM(wdetail2.adr_soy)  
               wdetail2.ad12 =   " " .
END.
IF (wdetail2.adr_road   <> "")  THEN DO:  
    IF LENGTH(wdetail2.ad11 + " ถนน " + TRIM(wdetail2.adr_road)) > 35  THEN
         ASSIGN wdetail2.ad12 = wdetail2.ad12 + " ถนน" + TRIM(wdetail2.adr_road).  /*  ถนน */ 
    ELSE ASSIGN wdetail2.ad11 = wdetail2.ad11 + " ถนน" + TRIM(wdetail2.adr_road)   /*  ถนน */ 
                wdetail2.ad12 =   " " .                                             
END.  
IF (INDEX(wdetail2.adr_country,"กรุง") <> 0 ) OR (INDEX(wdetail2.adr_country,"กทม") <> 0 ) THEN DO:
    IF (wdetail2.adr_tambon <> "")  THEN DO: 
        IF LENGTH(wdetail2.ad12 + " " + TRIM(wdetail2.adr_tambon)) > 35 THEN            
             ASSIGN wdetail2.ad13 = wdetail2.ad13 + " แขวง" + TRIM(wdetail2.adr_tambon).    /*  ตำบล/แขวง   */      
        ELSE ASSIGN wdetail2.ad12 = wdetail2.ad12 + " แขวง" + TRIM(wdetail2.adr_tambon)     /*  ตำบล/แขวง   */ 
                    wdetail2.ad13 = " " .                                               
    END.                                                                                
    IF (wdetail2.adr_amper  <> "")  THEN DO:                                            
        IF LENGTH(wdetail2.ad12 + " " + TRIM(wdetail2.adr_amper)) > 35 THEN             
             ASSIGN wdetail2.ad13 = wdetail2.ad13 + " เขต" + TRIM(wdetail2.adr_amper).     /*  อำเภอ/เขต   */ 
        ELSE ASSIGN wdetail2.ad12 = wdetail2.ad12 + " เขต" + TRIM(wdetail2.adr_amper)      
                    wdetail2.ad13 = " " .                                               
    END.                                                                                
    IF (wdetail2.adr_country <> "")  THEN DO:                                            
        IF LENGTH(wdetail2.ad13 + " " + TRIM(wdetail2.adr_country)) > 35 THEN           
             ASSIGN wdetail2.ad14 = wdetail2.ad14 + " " + TRIM(wdetail2.adr_country).   /*  จังหวัด */
        ELSE ASSIGN wdetail2.ad13 = wdetail2.ad13 + " " + TRIM(wdetail2.adr_country)    /*  จังหวัด */
                    wdetail2.ad14 =   " " .                                             
    END.                                                                                
    IF (wdetail2.adr_post   <> "")  THEN DO:                                            
        IF LENGTH(wdetail2.ad14 + " " + TRIM(wdetail2.adr_post)) > 35 THEN              
             ASSIGN wdetail2.ad14 = wdetail2.ad14 + " " + TRIM(wdetail2.adr_post).      
        ELSE ASSIGN wdetail2.ad13 = wdetail2.ad13 + " " + TRIM(wdetail2.adr_post)       /*  รหัสไปรษณีย์    */
                    wdetail2.ad14 = " " .
    END.
END.
ELSE DO:
    IF (wdetail2.adr_tambon <> "")  THEN DO: 
        IF LENGTH(wdetail2.ad12 + " " + TRIM(wdetail2.adr_tambon)) > 35 THEN            
             ASSIGN wdetail2.ad13 = wdetail2.ad13 + " ตำบล" + TRIM(wdetail2.adr_tambon).    /*  ตำบล/แขวง   */      
        ELSE ASSIGN wdetail2.ad12 = wdetail2.ad12 + " ตำบล" + TRIM(wdetail2.adr_tambon)     /*  ตำบล/แขวง   */ 
                    wdetail2.ad13 = " " .                                               
    END.                                                                                
    IF (wdetail2.adr_amper  <> "")  THEN DO:                                            
        IF LENGTH(wdetail2.ad12 + " " + TRIM(wdetail2.adr_amper)) > 35 THEN             
             ASSIGN wdetail2.ad13 = wdetail2.ad13 + " อำเภอ" + TRIM(wdetail2.adr_amper).     /*  อำเภอ/เขต   */ 
        ELSE ASSIGN wdetail2.ad12 = wdetail2.ad12 + " อำเภอ" + TRIM(wdetail2.adr_amper)      
                    wdetail2.ad13 = " " .                                               
    END.                                                                                
    IF (wdetail2.adr_country <> "")  THEN DO:                                            
        IF LENGTH(wdetail2.ad13 + " " + TRIM(wdetail2.adr_country)) > 35 THEN           
             ASSIGN wdetail2.ad14 = wdetail2.ad14 + " จังหวัด" + TRIM(wdetail2.adr_country).   /*  จังหวัด */
        ELSE ASSIGN wdetail2.ad13 = wdetail2.ad13 + " จังหวัด" + TRIM(wdetail2.adr_country)    /*  จังหวัด */
                    wdetail2.ad14 =   " " .                                             
    END.                                                                                
    IF (wdetail2.adr_post   <> "")  THEN DO:                                            
        IF LENGTH(wdetail2.ad14 + " " + TRIM(wdetail2.adr_post)) > 35 THEN              
             ASSIGN wdetail2.ad14 = wdetail2.ad14 + " " + TRIM(wdetail2.adr_post).      
        ELSE ASSIGN wdetail2.ad13 = wdetail2.ad13 + " " + TRIM(wdetail2.adr_post)       /*  รหัสไปรษณีย์    */
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
    IF index(wdetail2.id,"ลำดับ") <> 0    THEN DELETE wdetail2.
    ELSE DO:
        IF TRIM(wdetail2.titlenam) <> " "  THEN DO: 
            IF  INDEX(TRIM(wdetail2.titlenam),"บริษัท")            <> 0  OR 
                INDEX(TRIM(wdetail2.titlenam),"บ.")                <> 0  OR 
                INDEX(TRIM(wdetail2.titlenam),"บจก.")              <> 0  OR 
                INDEX(TRIM(wdetail2.titlenam),"หจก.")              <> 0  OR 
                INDEX(TRIM(wdetail2.titlenam),"หสน.")              <> 0  OR 
                INDEX(TRIM(wdetail2.titlenam),"บรรษัท")            <> 0  OR 
                INDEX(TRIM(wdetail2.titlenam),"มูลนิธิ")           <> 0  OR 
                INDEX(TRIM(wdetail2.titlenam),"ห้าง")              <> 0  OR 
                INDEX(TRIM(wdetail2.titlenam),"ห้างหุ้นส่วน")      <> 0  OR 
                INDEX(TRIM(wdetail2.titlenam),"ห้างหุ้นส่วนจำกัด") <> 0  OR
                INDEX(TRIM(wdetail2.titlenam),"ห้างหุ้นส่วนจำก")   <> 0  OR  
                R-INDEX(TRIM(wdetail2.titlenam),"จก.")             <> 0  OR  
                R-INDEX(TRIM(wdetail2.titlenam),"จำกัด")           <> 0  OR  
                R-INDEX(TRIM(wdetail2.titlenam),"(มหาชน)")         <> 0  OR  
                R-INDEX(TRIM(wdetail2.titlenam),"INC.")            <> 0  OR 
                R-INDEX(TRIM(wdetail2.titlenam),"CO.")             <> 0  OR 
                R-INDEX(TRIM(wdetail2.titlenam),"LTD.")            <> 0  OR 
                R-INDEX(TRIM(wdetail2.titlenam),"LIMITED")         <> 0  OR 
                INDEX(TRIM(wdetail2.titlenam),"และ/หรือ")          <> 0  THEN DO:  /*company */
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
            IF      r-index(n_cutaddress,"จังหวัด") <> 0 THEN 
                ASSIGN wdetail2.ad14 = substr(n_cutaddress,r-index(n_cutaddress,"จังหวัด"))
                n_cutaddress        = substr(n_cutaddress,1,r-index(n_cutaddress,"จังหวัด") - 1).
            ELSE IF r-index(n_cutaddress,"จ.")      <> 0 THEN 
                ASSIGN wdetail2.ad14 = substr(n_cutaddress,r-index(n_cutaddress,"จ."))
                n_cutaddress        = substr(n_cutaddress,1,r-index(n_cutaddress,"จ.") - 1).   
            ELSE IF r-index(n_cutaddress,"กรุงเทพ") <> 0 THEN 
                ASSIGN wdetail2.ad14 = substr(n_cutaddress,r-index(n_cutaddress,"กรุงเทพ"))
                n_cutaddress        = substr(n_cutaddress,1,r-index(n_cutaddress,"กรุงเทพ") - 1).          
            ELSE IF r-index(n_cutaddress,"กทม")     <> 0 THEN 
                ASSIGN wdetail2.ad14 = substr(n_cutaddress,r-index(n_cutaddress,"กทม"))
                n_cutaddress        = substr(n_cutaddress,1,r-index(n_cutaddress,"กทม") - 1). 
            /*Amper..*/
            IF      r-index(n_cutaddress,"อำเภอ") <> 0 THEN 
                ASSIGN wdetail2.ad13 = substr(n_cutaddress,r-index(n_cutaddress,"อำเภอ"))
                n_cutaddress        = substr(n_cutaddress,1,r-index(n_cutaddress,"อำเภอ") - 1). 
            ELSE IF r-index(n_cutaddress,"อ.")    <> 0 THEN 
                ASSIGN wdetail2.ad13 = substr(n_cutaddress,r-index(n_cutaddress,"อ.")) 
                n_cutaddress        = substr(n_cutaddress,1,r-index(n_cutaddress,"อ.") - 1). 
            ELSE IF r-index(n_cutaddress,"เขต")   <> 0 THEN 
                ASSIGN wdetail2.ad13 = substr(n_cutaddress,r-index(n_cutaddress,"เขต")) 
                n_cutaddress        = substr(n_cutaddress,1,r-index(n_cutaddress,"เขต") - 1). 
            /*tambon*/
            IF      r-index(n_cutaddress,"ตำบล") <> 0 THEN 
                ASSIGN wdetail2.ad12 = substr(n_cutaddress,r-index(n_cutaddress,"ตำบล"))
                n_cutaddress        = substr(n_cutaddress,1,r-index(n_cutaddress,"ตำบล") - 1). 
            ELSE IF r-index(n_cutaddress,"ต.")    <> 0 THEN 
                ASSIGN wdetail2.ad12 = substr(n_cutaddress,r-index(n_cutaddress,"ต.")) 
                n_cutaddress        = substr(n_cutaddress,1,r-index(n_cutaddress,"ต.") - 1). 
            ELSE IF r-index(n_cutaddress,"แขวง")   <> 0 THEN 
                ASSIGN wdetail2.ad12 = substr(n_cutaddress,r-index(n_cutaddress,"แขวง")) 
                n_cutaddress        = substr(n_cutaddress,1,r-index(n_cutaddress,"แขวง") - 1). 
            ASSIGN wdetail2.ad11 = n_cutaddress .
            IF (index(wdetail2.ad14,"กรุงเทพ") <> 0 ) OR (index(wdetail2.ad14,"กทม") <> 0 )    THEN
                ASSIGN 
                wdetail2.ad12 = IF INDEX(wdetail2.ad12,"ตำบล/แขวง") <> 0 THEN "แขวง" + trim(REPLACE(wdetail2.ad12,"ตำบล/แขวง","")) 
                                ELSE IF INDEX(wdetail2.ad12,"ต.")   <> 0 THEN "แขวง" + trim(REPLACE(wdetail2.ad12,"ต.","")) 
                                ELSE TRIM(wdetail2.ad12)                             
                wdetail2.ad13 = IF index(wdetail2.ad13,"อำเภอ/เขต") <> 0 THEN "เขต"  + trim(REPLACE(wdetail2.ad13,"อำเภอ/เขต","")) 
                                ELSE IF index(wdetail2.ad13,"อ.")   <> 0 THEN "เขต"  + trim(REPLACE(wdetail2.ad13,"อ.",""))
                                ELSE TRIM(wdetail2.ad13)                             
                wdetail2.ad14 = IF index(wdetail2.ad14,"จังหวัด")   <> 0 THEN trim(REPLACE(wdetail2.ad14,"จังหวัด","")) 
                                ELSE IF index(wdetail2.ad14,"จ.")   <> 0 THEN trim(REPLACE(wdetail2.ad14,"จ.","")) 
                                ELSE TRIM(wdetail2.ad14).                            
            ELSE ASSIGN                                                              
                wdetail2.ad12 = IF INDEX(wdetail2.ad12,"ตำบล/แขวง") <> 0 THEN "ตำบล"  + trim(REPLACE(wdetail2.ad12,"ตำบล/แขวง","")) 
                                ELSE IF INDEX(wdetail2.ad12,"ต.")   <> 0 THEN "ตำบล"  + trim(REPLACE(wdetail2.ad12,"ต.","")) 
                                ELSE TRIM(wdetail2.ad12)                             
                wdetail2.ad13 = IF index(wdetail2.ad13,"อำเภอ/เขต") <> 0 THEN "อำเภอ" + trim(REPLACE(wdetail2.ad13,"อำเภอ/เขต","")) 
                                ELSE IF index(wdetail2.ad13,"อ.")   <> 0 THEN "อำเภอ" + trim(REPLACE(wdetail2.ad13,"อ.",""))
                                ELSE TRIM(wdetail2.ad13)                             
                wdetail2.ad14 = IF index(wdetail2.ad14,"จังหวัด")   <> 0 THEN "จังหวัด" + trim(REPLACE(wdetail2.ad14,"จังหวัด",""))  
                                ELSE IF index(wdetail2.ad14,"จ.")   <> 0 THEN trim(REPLACE(wdetail2.ad14,"จ.","")) 
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
         IF n_dayno GE 1  THEN DO:  /* 1 ปีขึ้นไป */
             IF deci(wdetail2.comp) LE 1099  THEN DO: 
                 IF deci(wdetail2.comp) LE 899 THEN DO: 
                     IF deci(wdetail2.comp) LE 599 THEN ASSIGN wdetail2.class = "110".
                     ELSE ASSIGN wdetail2.class = "110".
                 END.
                 ELSE ASSIGN wdetail2.class = "140A".
             END.
             ELSE ASSIGN wdetail2.class = "120A". 
        END.
        ELSE DO:  /* ไม่ถึง ปี 1 */
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
            ASSIGN wdetail2.titlenam   = "คุณ".

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
    "เลขที่กรมธรรม์พ.ร.บ."                                                 
    "เลขที่สัญญา"               
    "ชื่อสาขา(ดีเลอร์)"                                    
    "สาขา"                                                         
    "คลาสรถ"                                           
    "เบี้ยพรบ."                                        
    "เบี้ยรวม"                                         
    "วันที่ รับชำระค่าพรบ."     
    "วันที่เริ่มคุ้มครอง"       
    "วันที่สิ้นสุดความคุ้มครอง" 
    "คำนาม"                     
    "ชื่อ"                      
    "เลขที่บัตรประชาชน"                              
    "ที่อยู่1"                  
    "ที่อยู่2"                                         
    "ที่อยู่3"                                         
    "ที่อยู่4"                                         
    "ยี่ห้อรถ"                                         
    "รุ่นรถ"                                           
    "ทะเบียนรถ"                                            
    "เลขตัวถัง"                                             
    "เลขสติ๊กเกอร์"                                    
    "ผู้รับผลประโยชน์"                                 
    "เลขที่รับแจ้ง"                                    
    "ผู้แจ้ง (Mkt)"             
    "หมายเหตุ/วันที่ออกพรบ."  
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
    "เลขที่กรมธรรม์พ.ร.บ."                                                 
    "เลขที่สัญญา"               
    "ชื่อสาขา(ดีเลอร์)"                                    
    "สาขา"                                                         
    "คลาสรถ"                                           
    "เบี้ยพรบ."                                        
    "เบี้ยรวม"                                         
    "วันที่ รับชำระค่าพรบ."     
    "วันที่เริ่มคุ้มครอง"       
    "วันที่สิ้นสุดความคุ้มครอง" 
    "คำนาม"                     
    "ชื่อ"                      
    "เลขที่บัตรประชาชน"                              
    "ที่อยู่1"                  
    "ที่อยู่2"                                         
    "ที่อยู่3"                                         
    "ที่อยู่4"                                         
    "ยี่ห้อรถ"                                         
    "รุ่นรถ"                                           
    "ทะเบียนรถ"                                            
    "เลขตัวถัง"                                             
    "เลขสติ๊กเกอร์"                                    
    "ผู้รับผลประโยชน์"                                 
    "เลขที่รับแจ้ง"                                    
    "ผู้แจ้ง (Mkt)"             
    "หมายเหตุ/วันที่ออกพรบ."  
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
    "เลขที่กรมธรรม์พ.ร.บ."                            
    "เลขที่สัญญา"               
    "ชื่อสาขา(ดีเลอร์)"              
    "สาขา"                                   
    "คลาสรถ"                     
    "เบี้ยพรบ."                  
    "เบี้ยรวม"                   
    "วันที่ รับชำระค่าพรบ."      
    "วันที่เริ่มคุ้มครอง"        
    "วันที่สิ้นสุดความคุ้มครอง"  
    "คำนาม"                      
    "ชื่อ"                       
    "เลขที่บัตรประชาชน"                                 
    "ที่อยู่1"                   
    "ที่อยู่2"                   
    "ที่อยู่3"                   
    "ที่อยู่4"                   
    "ยี่ห้อรถ"                   
    "รุ่นรถ"                     
    "ทะเบียนรถ"                      
    "เลขตัวถัง"                       
    "เลขสติ๊กเกอร์"              
    "ผู้รับผลประโยชน์"           
    "เลขที่รับแจ้ง"              
    "ผู้แจ้ง (Mkt)"             
    "หมายเหตุ/วันที่ออกพรบ."  SKIP.
                                       
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
    "เลขที่กรมธรรม์พ.ร.บ."                            
    "เลขที่สัญญา"               
    "ชื่อสาขา(ดีเลอร์)"              
    "สาขา"                                   
    "คลาสรถ"                     
    "เบี้ยพรบ."                  
    "เบี้ยรวม"                   
    "วันที่ รับชำระค่าพรบ."      
    "วันที่เริ่มคุ้มครอง"        
    "วันที่สิ้นสุดความคุ้มครอง"  
    "คำนาม"                      
    "ชื่อ"                       
    "เลขที่บัตรประชาชน"                                 
    "ที่อยู่1"                   
    "ที่อยู่2"                   
    "ที่อยู่3"                   
    "ที่อยู่4"                   
    "ยี่ห้อรถ"                   
    "รุ่นรถ"                     
    "ทะเบียนรถ"                      
    "เลขตัวถัง"                       
    "เลขสติ๊กเกอร์"              
    "ผู้รับผลประโยชน์"           
    "เลขที่รับแจ้ง"              
    "ผู้แจ้ง (Mkt)"             
    "หมายเหตุ/วันที่ออกพรบ." 
    "เบอร์ติดต่อ      "  
    "คำนำหน้าชื่อ 1   "  
    "ชื่อกรรมการ 1    "  
    "นามสกุลกรรมการ 1 "  
    "เลขที่บัตรประชาชนกรรมการ 1"  
    "คำนำหน้าชื่อ 2  "  
    "ชื่อกรรมการ 2   "  
    "นามสกุลกรรมการ 2"  
    "เลขที่บัตรประชาชนกรรมการ 2"  
    "คำนำหน้าชื่อ 3   "  
    "ชื่อกรรมการ 3    "  
    "นามสกุลกรรมการ 3 "  
    "เลขที่บัตรประชาชนกรรมการ 3" 
    "จัดส่งเอกสารที่สาขา"            /*A61-0335*/
    "ชื่อผู้รับเอกสาร "              /*A61-0335*/
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
        wdetail2.id            /*  1   ลำดับที่    */                                      
        wdetail2.companame     /*  2   บริษัทประกัน    */                 
        wdetail2.polstk        /*  3   เลขที่กรมธรรม์พ.ร.บ.    */         
        wdetail2.idbranch      /*  4   รหัสสาขา    */                     
        wdetail2.branchname    /*  5   สาขา KK */                         
        wdetail2.cedpol        /*  6   เลขที่สัญญา     */                 
        wdetail2.titlenam      /*  7   คำนำหน้าชื่อ    */                 
        wdetail2.insurnam      /*  8   ชื่อผู้เอาประกัน    */             
        wdetail2.sername       /*  9   นามสกุลผู้เอาประกัน */             
        wdetail2.vehreg        /*  10  เลขทะเบียน  */                     
        wdetail2.brand         /*  11  ยี่ห้อรถ    */                     
        wdetail2.notifyno      /*  12  เลขที่รับแจ้ง   */                 
        wdetail2.namnotify     /*  13  ชื่อเจ้าหน้าที่ MKT */             
        wdetail2.chassis       /*  14  เลขตัวรถ    */                     
        wdetail2.comp          /*  15  เบี้ยสุทธิ  */                     
        wdetail2.premt         /*  16  เบี้ยประกันรวมภาษีอากร  */         
        wdetail2.comdat        /*  17  วันเริ่มต้น พ.ร.บ.  */             
        wdetail2.expdat        /*  18  วันสิ้นสุด พ.ร.บ.   */             
        wdetail2.adr_no1       /*  19  ที่อยู่ */                         
        wdetail2.adr_mu        /*  หมู่    */                             
        wdetail2.adr_muban     /*  หมู่บ้าน    */                         
        wdetail2.adr_build     /*  อาคาร   */                             
        wdetail2.adr_soy       /*  ซอย */                                 
        wdetail2.adr_road      /*  ถนน */                                 
        wdetail2.adr_tambon    /*  ตำบล/แขวง   */                         
        wdetail2.adr_amper     /*  อำเภอ/เขต   */                         
        wdetail2.adr_country   /*  จังหวัด */                             
        wdetail2.adr_post      /*  รหัสไปรษณีย์    */                     
        wdetail2.memmo         /*  20  หมายเหตุ    */                     
        wdetail2.telephone     /*  21  เบอร์ติดต่อ */                     
        wdetail2.idno          /*  22  เลขที่บัตรประชาชน   */             
        /*wdetail2.birdthday */    /*  23  วันเดือนปีเกิด  */                  /*A60-0232*/           
        /*wdetail2.occoup    */    /*  24  อาชีพ   */                          /*A60-0232*/
        /*wdetail2.nstatus   */    /*  25  สถานะภาพ    */                      /*A60-0232*/
        /*wdetail2.idvatno   */    /*  26  เลขประจำตัวผู้เสียภาษีอากร  */      /*A60-0232*/
        wdetail2.titlenam01    /*  27  คำนำหน้าชื่อ1   */                    
        wdetail2.name01        /*  28  ชื่อกรรมการ1    */                    
        wdetail2.sernam01      /*  29  นามสกุลกรรมการ1 */                    
        wdetail2.idnonam01     /*  30  เลขที่บัตรประชาชนกรรมการ1   */        
        wdetail2.titlenam02    /*  31  คำนำหน้าชื่อ2   */                    
        wdetail2.name02        /*  32  ชื่อกรรมการ2    */                    
        wdetail2.sernam02      /*  33  นามสกุลกรรมการ2 */                    
        wdetail2.idnonam02     /*  34  เลขที่บัตรประชาชนกรรมการ2   */        
        wdetail2.titlenam03    /*  35  คำนำหน้าชื่อ3   */                 
        wdetail2.name03        /*  36  ชื่อผู้กรรมการ3 */                          
        wdetail2.sernam03      /*  37  นามสกุลกรรมการ3 */                       
        wdetail2.idnonam03     /*  38  เลขที่บัตรประชาชนกรรมการ3   */ 
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
        wdetail2.id           /*1  ลำดับที่    */                
        wdetail2.br_nam       /*2  สาขา    */                    
        wdetail2.polstk       /*3  เลขที่กรมธรรม์พ.ร.บ.    */    
        wdetail2.number       /*4  เลขที่สติ๊กเกอร์พ.ร.บ.  */    
        wdetail2.recivedat    /*5  วันที่ รับชำระค่าพรบ.   */    
        wdetail2.cedpol       /*6  เลขที่สัญญา */                
        wdetail2.insurnam     /*7  ชื่อ - นามสกุล  */            
        wdetail2.idno         /*8  เลขที่บัตรประชาชนลูกค้า     */
        wdetail2.vehreg       /*9  เลขทะเบียน  */                
        wdetail2.brand        /*10 ยี่ห้อรถ    */                
        wdetail2.model        /*11 รุ่นรถ  */                    
        wdetail2.notifyno     /*12 เลขที่รับแจ้ง   */            
        wdetail2.namnotify    /*13 ผู้แจ้ง (Mkt)   */            
        wdetail2.chassis      /*14 เลขตัวถังรถ */                
        wdetail2.comp         /*15 เบี้ยสุทธิ  */                
        wdetail2.premt        /*16 เบี้ยรวม    */                
        wdetail2.comdat       /*17 เริ่มต้นวันที่  */            
        wdetail2.expdat       /*18 วันที่สิ้นสุด   */            
        wdetail2.memmo        /*19 ที่อยู่ */ 
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
        wdetail2.id           /*1  ลำดับที่    */                
        wdetail2.br_nam       /*2  สาขา        */                    
        wdetail2.polstk       /*3  เลขที่กรมธรรม์พ.ร.บ.    */    
        wdetail2.number       /*4  เลขที่สติ๊กเกอร์พ.ร.บ.  */    
        wdetail2.recivedat    /*5  วันที่ รับชำระค่าพรบ.   */    
        wdetail2.cedpol       /*6  เลขที่สัญญา             */                
        wdetail2.insurnam     /*7  ชื่อ - นามสกุล          */            
        wdetail2.idno         /*8  เลขที่บัตรประชาชนลูกค้า */
        wdetail2.vehreg       /*9  เลขทะเบียน  */                
        wdetail2.brand        /*10 ยี่ห้อรถ    */                
        wdetail2.model        /*11 รุ่นรถ  */                    
        wdetail2.notifyno     /*12 เลขที่รับแจ้ง   */            
        wdetail2.namnotify    /*13 ผู้แจ้ง (Mkt)   */            
        wdetail2.chassis      /*14 เลขตัวถังรถ */                
        wdetail2.comp         /*15 เบี้ยสุทธิ  */                
        wdetail2.premt        /*16 เบี้ยรวม    */                
        wdetail2.comdat       /*17 เริ่มต้นวันที่  */            
        wdetail2.expdat       /*18 วันที่สิ้นสุด   */            
        wdetail2.ad11         /*19 ที่อยู่ */   
        wdetail2.ad12
        wdetail2.ad13
        wdetail2.ad14 
        wdetail2.kkapp .     /*a61-0335*/

END.                          /* repeat    */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

