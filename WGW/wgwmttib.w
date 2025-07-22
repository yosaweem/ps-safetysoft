&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*------------------------------------------------------------------------*/
/*          This .W file was created with the Progress UIB.             */
/*----------------------------------------------------------------------*/
/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */
/************************************************************************
program id   : wgwmttib.w
program name : Match file TIB To Standard Templet    
create by    : Ranu I. A67-0222 
               แปลงไฟล์ Text TIB เป็นไฟล์ Excel และ Format file Load Standard templet
************************************************************************/
CREATE WIDGET-POOL.
/* ***************************  Definitions  ************************** */
SESSION:MULTITASKING-INTERVAL = 1 .                                        
DEF VAR gv_id AS CHAR FORMAT "X(15)" NO-UNDO.     /*A53-0220*/
DEF VAR nv_pwd AS CHAR  FORMAT "x(15)" NO-UNDO.   /*A53-0220*/
DEF NEW SHARED STREAM ns1.
DEF  stream ns2.
DEF  stream ns3.
DEF NEW SHARED VAR nv_output   AS CHAR FORMAT "X(150)" INIT "".
DEFINE VAR nv_daily       AS CHARACTER FORMAT "X(3120)"     INITIAL ""  NO-UNDO.
DEFINE VAR nv_reccnt      AS INT   INIT  0.
DEFINE VAR nv_completecnt AS INT   INIT  0.
DEFINE VAR nv_enttim      AS CHAR  INIT  "".
DEFINE VAR nv_export      AS CHAR  init  ""  FORMAT "X(8)".
DEFINE NEW SHARED TEMP-TABLE wdetail2 NO-UNDO
    FIELD head          AS CHAR FORMAT "x(1)"   INIT ""      
    FIELD comcode       AS CHAR FORMAT "x(4)"   INIT ""      
    FIELD senddat       AS CHAR FORMAT "x(8)"   INIT ""      
    FIELD contractno    AS CHAR FORMAT "x(10)"  INIT ""     
    FIELD lotno         AS CHAR FORMAT "x(9)"   INIT ""      
    FIELD seqno         AS CHAR FORMAT "x(6)"   INIT ""      
    FIELD recact        AS CHAR FORMAT "x(1)"   INIT ""     
    FIELD STATUSno      AS CHAR FORMAT "x(1)"   INIT ""     
    FIELD flag          AS CHAR FORMAT "x(1)"   INIT ""  
    FIELD ntitle        AS CHAR FORMAT "x(20)"  INIT ""  
    FIELD insname       AS CHAR FORMAT "x(100)" INIT ""  
    FIELD lastname       AS CHAR FORMAT "x(100)" INIT ""
    FIELD add1          AS CHAR FORMAT "x(50)"  INIT ""    
    FIELD add2          AS CHAR FORMAT "x(50)"  INIT ""    
    FIELD add3          AS CHAR FORMAT "x(50)"  INIT ""    
    FIELD add4          AS CHAR FORMAT "x(50)"  INIT ""     
    FIELD add5          AS CHAR FORMAT "x(5)"   INIT ""      
    FIELD engno         AS CHAR FORMAT "x(20)"  INIT ""     
    FIELD chasno        AS CHAR FORMAT "x(20)"  INIT ""     
    FIELD brand         AS CHAR FORMAT "x(3)"   INIT ""      
    FIELD model         AS CHAR FORMAT "x(40)"  INIT ""     
    FIELD cc            AS CHAR FORMAT "x(5)"   INIT ""      
    FIELD COLORno       AS CHAR FORMAT "x(4)"   INIT ""   
    FIELD reg1          AS CHAR FORMAT "x(5)"   INIT ""     
    FIELD reg2          AS CHAR FORMAT "x(5)"   INIT ""     
    FIELD provinco      AS CHAR FORMAT "x(2)"   INIT ""       
    FIELD subinsco      AS CHAR FORMAT "x(50)"  INIT ""       
    FIELD covamount     AS CHAR FORMAT "x(20)"  INIT ""       
    FIELD grpssprem     AS CHAR FORMAT "x(20)"  INIT ""       
    FIELD effecdat      AS CHAR FORMAT "x(10)"  INIT ""       
    FIELD notifyno      AS CHAR FORMAT "x(100)" INIT ""       
    FIELD noticode      AS CHAR FORMAT "x(50)"  INIT ""       
    FIELD noticodesty   AS CHAR FORMAT "x(25)"  INIT ""       
    FIELD notiname      AS CHAR FORMAT "x(50)"  INIT ""       
    FIELD substyname    AS CHAR FORMAT "x(50)"  INIT ""       
    FIELD comamount     AS CHAR FORMAT "x(20)"  INIT ""      
    FIELD comprem       AS CHAR FORMAT "x(20)"  INIT ""       
    FIELD comeffecdat   AS CHAR FORMAT "x(10)"  INIT ""       
    FIELD compno        AS CHAR FORMAT "x(25)"  INIT ""      
    FIELD recivno       AS CHAR FORMAT "x(100)" INIT ""      
    FIELD recivcode     AS CHAR FORMAT "x(4)"   INIT ""       
    FIELD recivcosty    AS CHAR FORMAT "x(25)"  INIT ""      
    FIELD recivstynam   AS CHAR FORMAT "x(50)"  INIT ""      
    FIELD comppol       AS CHAR FORMAT "x(25)"  INIT ""      
    FIELD recivstydat   AS CHAR FORMAT "x(8)"   INIT ""      
    FIELD drivnam1      AS CHAR FORMAT "x(30)"  INIT ""      
    FIELD drivnam2      AS CHAR FORMAT "x(30)"  INIT ""    
    FIELD drino1        AS CHAR FORMAT "x(13)"  INIT ""     
    FIELD drino2        AS CHAR FORMAT "x(13)"  INIT ""     
    FIELD oldeng        AS CHAR FORMAT "x(20)"  INIT ""      
    FIELD oldchass      AS CHAR FORMAT "x(20)"  INIT ""      
    FIELD NAMEpay       AS CHAR FORMAT "x(100)" INIT ""      
    FIELD addpay1       AS CHAR FORMAT "X(50)"  INIT ""     
    FIELD addpay2       AS CHAR FORMAT "X(50)"  INIT ""      
    FIELD addpay3       AS CHAR FORMAT "X(50)"  INIT ""      
    FIELD addpay4       AS CHAR FORMAT "x(50)"  INIT ""      
    FIELD postpay       AS CHAR FORMAT "x(5)"   INIT ""       
    FIELD Reserved1     AS CHAR FORMAT "X(13)"  INIT ""      
    FIELD Reserved2     AS CHAR FORMAT "x(13)"  INIT ""      
    FIELD norcovdat     AS CHAR FORMAT "x(10)"  INIT ""       
    FIELD norcovenddat  AS CHAR FORMAT "x(10)"  INIT ""       
    FIELD showroom      AS CHAR FORMAT "X(40)"  INIT ""       
    FIELD caryear       AS CHAR FORMAT "x(4)"   INIT ""       
    FIELD renewtyp      AS CHAR FORMAT "x(1)"   INIT ""       
    FIELD Reserved5     AS CHAR FORMAT "x(59)"  INIT ""      
    FIELD idno          AS CHAR FORMAT "x(21)"  INIT ""  
    FIELD access        AS CHAR FORMAT "x(1000)" INIT "" 
    FIELD InsType       as char format "X(2)"   INIT "" 
    FIELD Garage        as char format "X(2)"   INIT "" 
    FIELD Drivnam       as char format "X(1)"   INIT "" 
    FIELD Driver1       as char format "X(100)" INIT "" 
    FIELD DrivDate1     as char format "X(8)"   INIT "" 
    FIELD DrivLicense1  as char format "X(20)"  INIT "" 
    FIELD Driver2       as char format "X(100)" INIT "" 
    FIELD DrivDate2     as char format "X(8)"   INIT "" 
    FIELD DrivLicense2  as char format "X(20)"  INIT "" 
    FIELD sclass        as char format "X(3)"   INIT "" 
    FIELD Deduct        as char format "X(6)"   INIT "" 
    FIELD EndorseSI     as char format "X(7)"   INIT "" 
    FIELD EndorsePrm    as char format "X(5)"   INIT "" 
    FIELD delercode    as char format "X(4)"    INIT "" 
    /* add var */
    FIELD titlenamepay  as char format "X(60)"  INIT ""
    FIELD lastnamepay   as char format "X(60)"  INIT ""
    FIELD Drivern1      as char format "X(60)"  INIT "" 
    FIELD Driverl1      as char format "X(60)"  INIT "" 
    FIELD Drivern2      as char format "X(60)"  INIT "" 
    FIELD Driverl2      as char format "X(60)"  INIT "" 
    FIELD branch        AS CHAR FORMAT "x(2)"   INIT ""    
    FIELD producer      AS CHAR FORMAT "x(10)"  INIT ""    
    FIELD agent         AS CHAR FORMAT "x(10)"  INIT ""    
    FIELD prvpol        AS CHAR FORMAT "x(15)"  INIT ""  
    FIELD covcod        AS CHAR FORMAT "x(3)"   INIT ""  
    FIELD Vehuse        AS CHAR FORMAT "x(5)"   INIT "" 
    FIELD loss          AS CHAR FORMAT "x(10)"  INIT ""
    FIELD prepol        AS CHAR FORMAT "x(12)"  INIT ""  
    FIELD dateloss      AS CHAR FORMAT "x(15)"  INIT "" 
    FIELD expirydat     AS CHAR FORMAT "x(15)"  INIT "" 
    FIELD premt         AS CHAR FORMAT "x(15)"  INIT "" .

DEFINE VAR nv_total     AS INTEGER   FORMAT "999999".
DEFINE WORKFILE wtailer   NO-UNDO
    FIELD Recordtype  AS CHAR FORMAT "X(01)"     INIT ""    /*1  Header Record "T"*/
    FIELD CompanyCode AS CHAR FORMAT "X(04)"     INIT ""    /*2  "SAFE"*/
    FIELD Datesent    AS CHAR FORMAT "X(8)"      INIT ""    /*3  yyyymmdd*/
    FIELD Usersent    AS CHAR FORMAT "X(10)"     INIT ""    /*4  TLT.'s User*/
    FIELD Lotno       AS CHAR FORMAT "X(09)"     INIT ""    /*5  Lot no.*/
    FIELD Seqno       AS CHAR FORMAT "X(06)"     INIT ""    /*6  000001*/
    FIELD Total_rec   AS CHAR FORMAT "X(6)"      INIT ""    /*7  999999*/
    FIELD Filler      AS CHAR FORMAT "X(980)"    INIT "" .  /*8  Blank.*/
DEFINE  WORKFILE wheader   NO-UNDO
    FIELD Recordtype  AS CHAR FORMAT "X(01)"     INIT ""    /*1  Header Record "H"*/
    FIELD CompanyCode AS CHAR FORMAT "X(04)"     INIT ""    /*2  "SAFE"*/
    FIELD Datesent    AS CHAR FORMAT "X(08)"     INIT ""    /*3  yyyymmdd*/
    FIELD Usersent    AS CHAR FORMAT "X(10)"     INIT ""    /*4  TLT.'s User*/
    FIELD Lotno       AS CHAR FORMAT "X(09)"     INIT ""    /*5  Lot no.*/
    FIELD Seqno       AS CHAR FORMAT "X(6)"      INIT ""    /*6  000001*/
    FIELD Filler      AS CHAR FORMAT "X(986)"    INIT "".   /*7  Blank.*/
DEF  shared  Var   n_User    As    Char.
DEF  Shared  Var   n_PassWd  As    Char.
DEFINE  WORKFILE wdetailcode NO-UNDO
    FIELD n_num         AS INTE INIT 0
    FIELD n_code        AS CHAR FORMAT "x(10)" INIT ""  
    FIELD n_branch      AS CHAR FORMAT "x(10)" INIT "" 
    FIELD n_delercode   AS CHAR FORMAT "x(15)" INIT "" .
DEF VAR nv_accdat   AS DATE     FORMAT "99/99/9999"              NO-UNDO.
DEF VAR nv_comdat   AS DATE     FORMAT "99/99/9999"              NO-UNDO.
DEF VAR nv_expdat   AS DATE     FORMAT "99/99/9999"              NO-UNDO.
DEF VAR nv_comchr   AS  CHAR .  
DEF VAR nv_dd       AS  INT     FORMAT "99".
DEF VAR nv_mm       AS  INT     FORMAT "99".
DEF VAR nv_yy       AS  INT     FORMAT "9999".
DEF VAR nv_cpamt1   AS DECI     INIT 0. 
DEF VAR nv_cpamt2   AS DECI     INIT 0. 
DEF VAR nv_cpamt3   AS DECI     INIT 0. 
DEF VAR nv_insamt1  AS DECI     INIT 0. 
DEF VAR nv_insamt2  AS DECI     INIT 0. 
DEF VAR nv_insamt3  AS DECI     INIT 0. 
DEF VAR nv_premt1   AS DECI     INIT 0. 
DEF VAR nv_premt2   AS DECI     INIT 0. 
DEF VAR nv_premt3   AS DECI     INIT 0. 
DEF VAR nv_name1    AS CHAR     INIT ""   Format "X(30)".
DEF VAR nv_ntitle   AS CHAR     INIT ""   Format  "X(10)". 
DEF VAR nv_titleno  AS INT      INIT 0    .
DEF VAR nv_policy   AS CHAR     INIT ""    Format  "X(12)".
def var nv_source   as char  format  "X(35)".
def var nv_indexno  as int   init  0.
def var nv_indexno1 as int   init  0.
def var nv_cnt      as int   init  0.
def var nv_addr     as char  extent 4  format "X(35)".
def var nv_prem     as char  init  "".
def VAR nv_file     as char  init  "d:\fileload\return.txt".
DEF VAR number      AS INT   INIT 1.
DEFINE VARIABLE cvData     AS CHARACTER NO-UNDO.
DEFINE VARIABLE OKpressed  AS LOGICAL INITIAL TRUE.
DEF VAR nv_FILLER AS CHAR FORMAT "x(42)".
DEF VAR n_seqno   AS INTE FORMAT "999999" INIT 0.
{wgw\wgwmttib.i}      /*ประกาศตัวแปร*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS tg_chk ra_typload fi_process fi_filename ~
fi_outfile bu_ok bu_file fi_outfile1 fi_outfileload bu_exit1 RECT-606 ~
RECT-607 RECT-616 RECT-617 
&Scoped-Define DISPLAYED-OBJECTS tg_chk ra_typload fi_process fi_filename ~
fi_outfile fi_outfile1 fi_outfileload 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_exit1 
     LABEL "EXIT" 
     SIZE 9.5 BY 1
     FONT 6.

DEFINE BUTTON bu_file 
     LABEL "IMP" 
     SIZE 6.83 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6.

DEFINE BUTTON bu_ok 
     LABEL "MATCH FILE" 
     SIZE 16 BY 1
     FONT 6.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 61 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_outfile AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 68.33 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_outfile1 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 68.17 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_outfileload AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 68.17 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_process AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 82 BY .91
     BGCOLOR 21 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE ra_typload AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          ".TXT", 1,
".CSV", 2
     SIZE 27.67 BY .95 NO-UNDO.

DEFINE RECTANGLE RECT-606
     EDGE-PIXELS 2 GRAPHIC-EDGE    ROUNDED 
     SIZE 106 BY 13.29
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-607
     EDGE-PIXELS 2 GRAPHIC-EDGE    ROUNDED 
     SIZE 104 BY 11.43
     BGCOLOR 52 .

DEFINE RECTANGLE RECT-616
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 18.5 BY 1.43
     BGCOLOR 2 .

DEFINE RECTANGLE RECT-617
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 11.5 BY 1.43
     BGCOLOR 4 .

DEFINE VARIABLE tg_chk AS LOGICAL INITIAL no 
     LABEL "ใช้ตัวคั่นข้อมูล  ~" | ~"" 
     VIEW-AS TOGGLE-BOX
     SIZE 18.5 BY .81
     BGCOLOR 8 FGCOLOR 2  NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     tg_chk AT ROW 4.62 COL 65.5 WIDGET-ID 26
     ra_typload AT ROW 4.57 COL 34.5 NO-LABEL WIDGET-ID 16
     fi_process AT ROW 10.95 COL 18 COLON-ALIGNED NO-LABEL WIDGET-ID 14
     fi_filename AT ROW 5.76 COL 32 COLON-ALIGNED NO-LABEL
     fi_outfile AT ROW 7.14 COL 32 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 12.38 COL 38.83
     bu_file AT ROW 5.71 COL 95.67
     fi_outfile1 AT ROW 9.67 COL 32 COLON-ALIGNED NO-LABEL
     fi_outfileload AT ROW 8.43 COL 32 COLON-ALIGNED NO-LABEL
     bu_exit1 AT ROW 12.38 COL 58.17
     "IMPORT TEXT FILE TIB :" VIEW-AS TEXT
          SIZE 25.17 BY 1 AT ROW 5.71 COL 7.5
          BGCOLOR 52 FGCOLOR 15 FONT 6
     "TYPE FILE MATCH :" VIEW-AS TEXT
          SIZE 20.17 BY 1 AT ROW 4.48 COL 12.33 WIDGET-ID 24
          BGCOLOR 52 FGCOLOR 15 FONT 6
     "OUTPUT FILE LOAD STD :" VIEW-AS TEXT
          SIZE 27 BY 1 AT ROW 8.48 COL 5.83
          BGCOLOR 52 FGCOLOR 23 FONT 6
     "==========================" VIEW-AS TEXT
          SIZE 22.83 BY .62 AT ROW 1.71 COL 2.17 WIDGET-ID 2
          BGCOLOR 19 FGCOLOR 2 FONT 2
     "==========================" VIEW-AS TEXT
          SIZE 20 BY .62 AT ROW 1.76 COL 85.5 WIDGET-ID 4
          BGCOLOR 19 FGCOLOR 2 FONT 2
     "OUTPUT FILE DATA ERROR :" VIEW-AS TEXT
          SIZE 29.67 BY 1 AT ROW 9.67 COL 3.33
          BGCOLOR 52 FGCOLOR 23 FONT 6
     " MATCH FILE TEXT TIB TO EXCEL / STANDARD TEMPLATE" VIEW-AS TEXT
          SIZE 59 BY 1 AT ROW 1.52 COL 25.33
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "OUTPUT TIB EXCEL FILE :" VIEW-AS TEXT
          SIZE 26.5 BY 1 AT ROW 7.29 COL 6.17
          BGCOLOR 52 FGCOLOR 17 FONT 6
     ".txt ไฟล์แจ้งงานจาก TIB" VIEW-AS TEXT
          SIZE 19.5 BY .71 AT ROW 3 COL 34.5 WIDGET-ID 20
          BGCOLOR 52 FGCOLOR 7 FONT 1
     ".csv ไฟล์ Excel ที่ได้จากการแปลง txt  Save as File .csv" VIEW-AS TEXT
          SIZE 47 BY .76 AT ROW 3.76 COL 34.5 WIDGET-ID 22
          BGCOLOR 52 FGCOLOR 7 FONT 1
     RECT-606 AT ROW 1.14 COL 1
     RECT-607 AT ROW 2.67 COL 2
     RECT-616 AT ROW 12.14 COL 37.5
     RECT-617 AT ROW 12.14 COL 57
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 106.33 BY 13.57
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
         TITLE              = "Import and Export text file TIB[TOYOTA]"
         HEIGHT             = 14.05
         WIDTH              = 106.83
         MAX-HEIGHT         = 33.71
         MAX-WIDTH          = 170.67
         VIRTUAL-HEIGHT     = 33.71
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

&IF '{&WINDOW-SYSTEM}' NE 'TTY' &THEN
IF NOT C-Win:LOAD-ICON("adeicon/addcomponents.ico":U) THEN
    MESSAGE "Unable to load icon: adeicon/addcomponents.ico"
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
ON END-ERROR OF C-Win /* Import and Export text file TIB[TOYOTA] */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Import and Export text file TIB[TOYOTA] */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit1 C-Win
ON CHOOSE OF bu_exit1 IN FRAME fr_main /* EXIT */
DO:
  Apply "Close" to this-procedure.
  Return no-apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_file
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_file C-Win
ON CHOOSE OF bu_file IN FRAME fr_main /* IMP */
DO:
    IF ra_typload = 1 THEN DO:
        SYSTEM-DIALOG GET-FILE cvData
            TITLE      "Choose Data File to Import ..."
            FILTERS    "Text Documents" "*.txt" 
            MUST-EXIST
            USE-FILENAME
            UPDATE OKpressed.
        IF OKpressed = TRUE THEN DO:
                ASSIGN
                    fi_filename    = cvData
                    fi_outfile     = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))   + ".XLS"  
                    fi_outfileload = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))   + "_Load.csv" 
                    fi_outfile1    = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))   + "_Error.csv" .
                DISP fi_filename   fi_outfileload fi_outfile  fi_outfile1 WITH FRAME fr_main. 
        END.
    END.
    ELSE DO:
            SYSTEM-DIALOG GET-FILE cvData
            TITLE      "Choose Data File to Import ..."
            FILTERS    "Text Documents" "*.csv"
            MUST-EXIST
            USE-FILENAME
            UPDATE OKpressed.
        IF OKpressed = TRUE THEN DO:  
          ASSIGN
                fi_filename    = cvData
                fi_outfile     = "" 
                fi_outfileload = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))   + "_Load.csv" 
                fi_outfile1    = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))   + "_Error.csv" .
            DISP fi_filename   fi_outfileload fi_outfile  fi_outfile1 WITH FRAME fr_main.    
        END.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok C-Win
ON CHOOSE OF bu_ok IN FRAME fr_main /* MATCH FILE */
DO:
     IF fi_filename = "" THEN DO:
        MESSAGE "Input Text file TIB !!! :" VIEW-AS ALERT-BOX .
        APPLY "entry" to fi_filename.
        RETURN NO-APPLY.
    END.

    IF fi_outfileload = "" THEN DO:
        MESSAGE "Output to excel file TIB is emty!!! :" VIEW-AS ALERT-BOX .
        APPLY "entry" to fi_outfileload.
        RETURN NO-APPLY.
    END.
    FOR EACH  wdetail2:
           DELETE  wdetail2.
    End.
    FOR EACH  wdetail:
           DELETE  wdetail.
    End.


    IF ra_typload = 1 THEN DO:
        ASSIGN fi_process = "Import Text to table wdetail2.....".
        DISP fi_process WITH FRAME fr_main.
        
        IF tg_chk = NO THEN DO:
            INPUT FROM VALUE(fi_filename) .   /*create in TEMP-TABLE wImport*/
            REPEAT:   
                IMPORT UNFORMATTED nv_daily.
                CREATE  wdetail2.
                ASSIGN
                    wdetail2.head         = TRIM(SUBSTRING(nv_daily,1,1      ))    /*1 D*/                      
                    wdetail2.comcode      = TRIM(SUBSTRING(nv_daily,2,4      ))    /*2 4 */        
                    wdetail2.senddat      = TRIM(SUBSTRING(nv_daily,6,8      ))    /*3 8 yyyymmdd*/   
                    wdetail2.contractno   = TRIM(SUBSTRING(nv_daily,14,10    ))    /*4 10*/      
                    wdetail2.lotno        = TRIM(SUBSTRING(nv_daily,24,9     ))    /*5 9*/       
                    wdetail2.seqno        = TRIM(SUBSTRING(nv_daily,33,6     ))    /*6 6 000002*/       
                    wdetail2.recact       = TRIM(SUBSTRING(nv_daily,39,1     ))    /*7 A*/      
                    wdetail2.STATUSno     = TRIM(SUBSTRING(nv_daily,40,1     ))    /*8 A,E,C*/      
                    wdetail2.flag         = TRIM(SUBSTRING(nv_daily,41,1     ))    /*9 Y */       
                    wdetail2.insname      = TRIM(SUBSTRING(nv_daily,42,100   ))    /*10  100 */     
                    wdetail2.add1         = TRIM(SUBSTRING(nv_daily,142,50   ))    /*11 50 */    
                    wdetail2.add2         = TRIM(SUBSTRING(nv_daily,192,50   ))    /*12 50 */    
                    wdetail2.add3         = TRIM(SUBSTRING(nv_daily,242,50   ))    /*13 50 */    
                    wdetail2.add4         = TRIM(SUBSTRING(nv_daily,292,50   ))    /*14 50 */     
                    wdetail2.add5         = TRIM(SUBSTRING(nv_daily,342,5    ))    /*15 5  */      
                    wdetail2.engno        = TRIM(SUBSTRING(nv_daily,347,100  ))    /*16 20 */     
                    wdetail2.chasno       = TRIM(SUBSTRING(nv_daily,447,100  ))    /*17 20 */     
                    wdetail2.brand        = TRIM(SUBSTRING(nv_daily,547,3    ))    /*18 3  */ 
                    wdetail2.model        = TRIM(SUBSTRING(nv_daily,550,40   ))    /*19 40 */     
                    wdetail2.cc           = TRIM(SUBSTRING(nv_daily,590,5    ))    /*20 5 */      
                    wdetail2.COLORno      = TRIM(SUBSTRING(nv_daily,595,4    ))    /*21 4 */      
                    wdetail2.reg1         = TRIM(SUBSTRING(nv_daily,599,5    ))    /*22 5 */      
                    wdetail2.reg2         = TRIM(SUBSTRING(nv_daily,604,5    ))    /*23 5*/      
                    wdetail2.provinco     = TRIM(SUBSTRING(nv_daily,609,2    ))    /*24 2*/     
                    wdetail2.subinsco     = TRIM(SUBSTRING(nv_daily,611,4    ))    /*25 4 */      
                    wdetail2.covamount    = TRIM(SUBSTRING(nv_daily,615,13   ))    /*26 13 */     
                    wdetail2.grpssprem    = TRIM(SUBSTRING(nv_daily,628,11   ))    /*27 11 */     
                    wdetail2.effecdat     = TRIM(SUBSTRING(nv_daily,639,8    ))    /*28 8  yyyymmdd*/      
                    wdetail2.notifyno     = TRIM(SUBSTRING(nv_daily,647,100  ))    /*29   100 */     
                    wdetail2.noticode     = TRIM(SUBSTRING(nv_daily,747,4    ))    /*30 4  */     
                    wdetail2.noticodesty  = TRIM(SUBSTRING(nv_daily,751,25   ))    /*31 25  */     
                    wdetail2.notiname     = TRIM(SUBSTRING(nv_daily,776,50   ))    /*32 50  */     
                    wdetail2.substyname   = TRIM(SUBSTRING(nv_daily,826,4    ))    /*33 4   */     
                    wdetail2.comamount    = TRIM(SUBSTRING(nv_daily,830,13   ))    /*34 13  */    
                    wdetail2.comprem      = TRIM(SUBSTRING(nv_daily,843,11   ))    /*35 11  */       
                    wdetail2.comeffecdat  = TRIM(SUBSTRING(nv_daily,854,8    ))    /*36 8 yyyymmdd */     
                    wdetail2.compno       = TRIM(SUBSTRING(nv_daily,862,25   ))    /*37 25 */    
                    wdetail2.recivno      = TRIM(SUBSTRING(nv_daily,887,100  ))    /*38 100 */    
                    wdetail2.recivcode    = TRIM(SUBSTRING(nv_daily,987,4    ))    /*39 4  */     
                    wdetail2.recivcosty   = TRIM(SUBSTRING(nv_daily,991,25   ))    /*40 25 */    
                    wdetail2.recivstynam  = TRIM(SUBSTRING(nv_daily,1016,50  ))    /*41 50 */      
                    wdetail2.comppol      = TRIM(SUBSTRING(nv_daily,1066,25  ))    /*42 25 */   
                    wdetail2.recivstydat  = TRIM(SUBSTRING(nv_daily,1091,8   ))    /*43 8  */  
                    wdetail2.drivnam1     = TRIM(SUBSTRING(nv_daily,1099,30  ))    /*44 30 */    
                    wdetail2.drivnam2     = TRIM(SUBSTRING(nv_daily,1129,30  ))    /*45 30 */      
                    wdetail2.drino1       = TRIM(SUBSTRING(nv_daily,1159,13  ))    /*46 13 */     
                    wdetail2.drino2       = TRIM(SUBSTRING(nv_daily,1172,13  ))    /*47 13 */     
                    wdetail2.oldeng       = TRIM(SUBSTRING(nv_daily,1185,100 ))    /*46 20 */    
                    wdetail2.oldchass     = TRIM(SUBSTRING(nv_daily,1285,100 ))    /*47 20 */    
                    wdetail2.NAMEpay      = TRIM(SUBSTRING(nv_daily,1385,100 ))    /*48 100 */    
                    wdetail2.addpay1      = TRIM(SUBSTRING(nv_daily,1485,50  ))    /*49 50 */    
                    wdetail2.addpay2      = TRIM(SUBSTRING(nv_daily,1535,50  ))    /*50 50 */    
                    wdetail2.addpay3      = TRIM(SUBSTRING(nv_daily,1585,50  ))    /*51 50 */    
                    wdetail2.addpay4      = TRIM(SUBSTRING(nv_daily,1635,50  ))    /*52 50 */    
                    wdetail2.postpay      = TRIM(SUBSTRING(nv_daily,1685,5   ))    /*53 5  */     
                    wdetail2.Reserved1    = TRIM(SUBSTRING(nv_daily,1690,13  ))    /*54 13 */    
                    wdetail2.Reserved2    = TRIM(SUBSTRING(nv_daily,1703,13  ))    /*55 13 */   
                    wdetail2.norcovdat    = TRIM(SUBSTRING(nv_daily,1716,8   ))    /*56 8 */    
                    wdetail2.norcovenddat = TRIM(SUBSTRING(nv_daily,1724,8   ))    /*57 8 */   
                    wdetail2.showroom     = TRIM(SUBSTRING(nv_daily,1732,4   ))    /*58 4 */     
                    wdetail2.caryear      = TRIM(SUBSTRING(nv_daily,1736,4   ))    /*59 4 */     
                    wdetail2.renewtyp     = TRIM(SUBSTRING(nv_daily,1740,1   ))    /*60 1 */     
                    wdetail2.Reserved5    = TRIM(SUBSTRING(nv_daily,1741,59  ))    /*61 59*/   
                    wdetail2.idno         = TRIM(SUBSTRING(nv_daily,1800,21  ))    /*62 21*/  
                    wdetail2.access       = TRIM(SUBSTRING(nv_daily,1821,1000))    /*63 100*/  
                    wdetail2.covcod       = TRIM(SUBSTRING(nv_daily,2821,2   ))  
                    wdetail2.Garage       = TRIM(SUBSTRING(nv_daily,2823,2   ))  
                    wdetail2.Drivnam      = TRIM(SUBSTRING(nv_daily,2825,1   ))  
                    wdetail2.Driver1      = TRIM(SUBSTRING(nv_daily,2826,100 ))  
                    wdetail2.DrivDate1    = TRIM(SUBSTRING(nv_daily,2926,8   ))  
                    wdetail2.DrivLicense1 = TRIM(SUBSTRING(nv_daily,2934,20  ))  
                    wdetail2.Driver2      = TRIM(SUBSTRING(nv_daily,2954,100 ))  
                    wdetail2.DrivDate2    = TRIM(SUBSTRING(nv_daily,3054,8   ))  
                    wdetail2.DrivLicense2 = TRIM(SUBSTRING(nv_daily,3062,20  ))  
                    wdetail2.sCLASS       = TRIM(SUBSTRING(nv_daily,3082,3   ))  
                    wdetail2.Deduct       = TRIM(SUBSTRING(nv_daily,3085,6   ))  
                    wdetail2.EndorseSI    = TRIM(SUBSTRING(nv_daily,3091,7   ))  
                    wdetail2.EndorsePrm   = TRIM(SUBSTRING(nv_daily,3098,5   ))  
                    wdetail2.Delercode   = TRIM(SUBSTRING(nv_daily,3103,4   ))  .

                 ASSIGN fi_process = "Import Text to table wdetail2: " + wdetail2.chasno + "...." .
                 DISP fi_process WITH FRAME fr_main.
            END.   /* repeat  */    
        END.
        ELSE DO:
            INPUT FROM VALUE(fi_filename) .   /*create in TEMP-TABLE wImport*/
            REPEAT:
                CREATE  wdetail2.
                IMPORT DELIMITER "|"
                wdetail2.head         
                wdetail2.comcode      
                wdetail2.senddat      
                wdetail2.contractno   
                wdetail2.lotno        
                wdetail2.seqno        
                wdetail2.recact       
                wdetail2.STATUSno     
                wdetail2.flag         
                wdetail2.insname      
                wdetail2.add1         
                wdetail2.add2         
                wdetail2.add3         
                wdetail2.add4         
                wdetail2.add5         
                wdetail2.engno        
                wdetail2.chasno       
                wdetail2.brand        
                wdetail2.model        
                wdetail2.cc           
                wdetail2.COLORno      
                wdetail2.reg1         
                wdetail2.reg2         
                wdetail2.provinco     
                wdetail2.subinsco     
                wdetail2.covamount    
                wdetail2.grpssprem    
                wdetail2.effecdat     
                wdetail2.notifyno     
                wdetail2.noticode     
                wdetail2.noticodesty  
                wdetail2.notiname     
                wdetail2.substyname   
                wdetail2.comamount    
                wdetail2.comprem      
                wdetail2.comeffecdat  
                wdetail2.compno       
                wdetail2.recivno      
                wdetail2.recivcode    
                wdetail2.recivcosty   
                wdetail2.recivstynam  
                wdetail2.comppol      
                wdetail2.recivstydat  
                wdetail2.drivnam1     
                wdetail2.drivnam2     
                wdetail2.drino1       
                wdetail2.drino2       
                wdetail2.oldeng       
                wdetail2.oldchass     
                wdetail2.NAMEpay      
                wdetail2.addpay1      
                wdetail2.addpay2      
                wdetail2.addpay3      
                wdetail2.addpay4      
                wdetail2.postpay      
                wdetail2.Reserved1    
                wdetail2.Reserved2    
                wdetail2.norcovdat    
                wdetail2.norcovenddat 
                wdetail2.showroom     
                wdetail2.caryear      
                wdetail2.renewtyp     
                wdetail2.Reserved5    
                wdetail2.idno         
                wdetail2.access       
                wdetail2.covcod       
                wdetail2.Garage       
                wdetail2.Drivnam      
                wdetail2.Driver1      
                wdetail2.DrivDate1    
                wdetail2.DrivLicense1 
                wdetail2.Driver2      
                wdetail2.DrivDate2    
                wdetail2.DrivLicense2 
                wdetail2.sCLASS       
                wdetail2.Deduct       
                wdetail2.EndorseSI    
                wdetail2.EndorsePrm   
                wdetail2.Delercode   .
                
                ASSIGN fi_process = "Import Text to table wdetail2: " + wdetail2.chasno + "...." .
                DISP fi_process WITH FRAME fr_main.
            END.
            RELEASE wdetail2.
        END.
        RUN  Pro_ExportXLS.
    END.
    ELSE DO:
        INPUT FROM VALUE(fi_filename).
        REPEAT:
            CREATE  wdetail2.
            IMPORT DELIMITER "|"
                wdetail2.loss 
                wdetail2.head        
                wdetail2.comcode     
                wdetail2.senddat     
                wdetail2.contractno  
                wdetail2.lotno       
                wdetail2.seqno       
                wdetail2.recact      
                wdetail2.STATUSno    
                wdetail2.flag        
                wdetail2.insname     
                wdetail2.add1        
                wdetail2.add2        
                wdetail2.add3        
                wdetail2.add4        
                wdetail2.add5        
                wdetail2.engno       
                wdetail2.chasno      
                wdetail2.brand       
                wdetail2.model       
                wdetail2.cc          
                wdetail2.COLORno     
                wdetail2.reg1        
                wdetail2.reg2        
                wdetail2.provinco    
                wdetail2.subinsco    
                wdetail2.covamount   
                wdetail2.grpssprem   
                wdetail2.effecdat    
                wdetail2.notifyno    
                wdetail2.noticode    
                wdetail2.noticodesty 
                wdetail2.notiname    
                wdetail2.substyname  
                wdetail2.comamount   
                wdetail2.comprem     
                wdetail2.comeffecdat 
                wdetail2.compno      
                wdetail2.recivno     
                wdetail2.recivcode   
                wdetail2.recivcosty  
                wdetail2.recivstynam 
                wdetail2.comppol     
                wdetail2.recivstydat 
                wdetail2.drivnam1    
                wdetail2.drivnam2    
                wdetail2.drino1      
                wdetail2.drino2      
                wdetail2.oldeng      
                wdetail2.oldchass    
                wdetail2.NAMEpay     
                wdetail2.addpay1     
                wdetail2.addpay2     
                wdetail2.addpay3     
                wdetail2.addpay4     
                wdetail2.postpay     
                wdetail2.Reserved1   
                wdetail2.Reserved2   
                wdetail2.norcovdat   
                wdetail2.norcovenddat
                wdetail2.showroom    
                wdetail2.caryear     
                wdetail2.renewtyp    
                wdetail2.Reserved5   
                wdetail2.idno        
                wdetail2.access      
                wdetail2.covcod     
                wdetail2.Garage      
                wdetail2.Drivnam     
                wdetail2.Driver1     
                wdetail2.DrivDate1   
                wdetail2.DrivLicense1
                wdetail2.Driver2     
                wdetail2.DrivDate2   
                wdetail2.DrivLicense2
                wdetail2.sCLASS      
                wdetail2.Deduct      
                wdetail2.EndorseSI   
                wdetail2.EndorsePrm  
                wdetail2.Delercode   .
            ASSIGN fi_process = "Import Text to table wdetail2: " + wdetail2.chasno + "...." .
            DISP fi_process WITH FRAME fr_main.
        END.
        RELEASE wdetail2.
    END.
    RUN  proc_assignSTD.
    RUN  proc_chkpolpremium.
    RUN  proc_chkpolexp.
    RUN  proc_chkcomp .
    Run  Proc_fileload.
    RUN  proc_fileerr.
    IF CONNECTED("sic_exp") THEN DISCONNECT sic_exp .
    MESSAGE " Export File complete " VIEW-AS ALERT-BOX.
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


&Scoped-define SELF-NAME fi_outfile1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outfile1 C-Win
ON LEAVE OF fi_outfile1 IN FRAME fr_main
DO:
  fi_outfile1  =  Input  fi_outfile1.
  Disp  fi_outfile1 with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_outfileload
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outfileload C-Win
ON LEAVE OF fi_outfileload IN FRAME fr_main
DO:
  fi_outfileload  =  Input  fi_outfileload.
  Disp  fi_outfileload with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_typload
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_typload C-Win
ON VALUE-CHANGED OF ra_typload IN FRAME fr_main
DO:
    ra_typload = INPUT ra_typload.
    DISP ra_typload WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME tg_chk
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL tg_chk C-Win
ON VALUE-CHANGED OF tg_chk IN FRAME fr_main /* ใช้ตัวคั่นข้อมูล  " | " */
DO:
    tg_chk = INPUT tg_chk.
    DISP tg_chk WITH FRAME fr_main.
  
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
  
  gv_prgid = "wgwtbtex".
  gv_prog  = "ImportText File TIB  to Excel ".
  

  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).

/*********************************************************************/ 
   RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE).  
  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.
  ASSIGN 
      ra_typload  = 1  
      tg_chk      = YES.
     /* ra_typced   = 2  
      fi_campno   = "CAM_TOYOTA" 
      fi_tibpara  = "TIB_CODE"  .*/
 /* DISP ra_typload ra_typced fi_campno WITH FRAM fr_main.
  DISABLE  fi_outfile  fi_outfile1  fi_outfile2  WITH FRAME fr_main.
  ENABLE fi_outfileload WITH FRAME fr_main.*/
  DISP fi_outfile  fi_outfile1  fi_outfileload ra_typload  tg_chk /*fi_campno fi_tibpara*/ WITH FRAM fr_main.
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
  DISPLAY tg_chk ra_typload fi_process fi_filename fi_outfile fi_outfile1 
          fi_outfileload 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE tg_chk ra_typload fi_process fi_filename fi_outfile bu_ok bu_file 
         fi_outfile1 fi_outfileload bu_exit1 RECT-606 RECT-607 RECT-616 
         RECT-617 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assignSTD C-Win 
PROCEDURE proc_assignSTD :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wdetail2 WHERE wdetail2.head = "D" AND wdetail2.STATUSno = "A"  .
    RUN proc_assigntitle.
    RUN proc_chkprovince.
    RUN proc_chktxt.
    RUN proc_chkacces.
    RUN proc_chkbrand.
    ASSIGN fi_process = "Create Data Load wdetail: " + wdetail2.chasno + "...." .
    DISP fi_process WITH FRAME fr_main.
    CREATE wdetail.
    ASSIGN
        wdetail.riskno       = ""
        wdetail.itemno       = "1"
        wdetail.policyno     = ""
        wdetail.n_branch     = ""
        wdetail.agent        = ""
        wdetail.producer     = ""
        wdetail.n_delercode  = ""
        wdetail.fincode      = ""
        wdetail.appenno      = trim(wdetail2.contractno)   
        wdetail.salename     = trim(wdetail2.noticode)     
        wdetail.srate        = ""
        wdetail.comdat       = trim(wdetail2.effecdat)     
        wdetail.expdat       = trim(wdetail2.norcovdat)    
        wdetail.agreedat     = ""
        wdetail.firstdat     = ""
        wdetail.packcod      = ""
        wdetail.camp_no      = ""
        wdetail.campen       = ""
        wdetail.specon       = ""
        wdetail.product      = ""
        wdetail.promo        = ""
        wdetail.rencnt       = ""
        wdetail.prepol       = ""
        wdetail.txt1         = ""
        wdetail.txt2         = ""
        wdetail.txt3         = ""
        wdetail.txt4         = ""
        wdetail.txt5         = ""
        wdetail.txt6         = ""
        wdetail.txt7         = ""
        wdetail.txt8         = ""
        wdetail.txt9         = ""
        wdetail.txt10        = ""
        wdetail.memo1        = trim(nv_txt1)   
        wdetail.memo2        = trim(nv_txt2)   
        wdetail.memo3        = trim(nv_txt3)   
        wdetail.memo4        = trim(nv_txt4)   
        wdetail.memo5        = trim(nv_txt5)   
        wdetail.memo6        = trim(nv_txt6)   
        wdetail.memo7        = trim(nv_txt7)   
        wdetail.memo8        = trim(nv_txt8)   
        wdetail.memo9        = trim(nv_txt9)   
        wdetail.memo10       = trim(nv_txt10)  
        wdetail.accdata1     = trim(nv_acc1)   
        wdetail.accdata2     = trim(nv_acc2) 
        wdetail.accdata3     = trim(nv_acc3) 
        wdetail.accdata4     = trim(nv_acc4) 
        wdetail.accdata5     = trim(nv_acc5) 
        wdetail.accdata6     = trim(nv_acc6) 
        wdetail.accdata7     = trim(nv_acc7) 
        wdetail.accdata8     = trim(nv_acc8) 
        wdetail.accdata9     = trim(nv_acc9) 
        wdetail.accdata10    = trim(nv_acc10)
        wdetail.compul       = IF deci(wdetail2.comprem) <> 0 THEN "Y" ELSE "N"  
        wdetail.insref       = ""
        wdetail.instyp       = trim(wdetail2.instyp) 
        wdetail.inslang      = "T"  
        wdetail.tiname       = trim(wdetail2.ntitle)     
        wdetail.insnam       = trim(wdetail2.insname)  
        wdetail.lastname     = trim(wdetail2.lastname)
        wdetail.icno         = trim(wdetail2.idno)         
        wdetail.insbr        = ""
        wdetail.occup        = ""
        wdetail.addr         = trim(wdetail2.add1)         
        wdetail.tambon       = trim(wdetail2.add2)         
        wdetail.amper        = trim(wdetail2.add3)         
        wdetail.country      = trim(wdetail2.add4)         
        wdetail.post         = trim(wdetail2.add5)         
        wdetail.provcod      = ""
        wdetail.distcod      = ""
        wdetail.sdistcod     = ""
        wdetail.jpae         = ""
        wdetail.jpjtl        = ""
        wdetail.jpts         = ""
        wdetail.gender       = ""
        wdetail.tele1        = ""
        wdetail.tele2        = ""
        wdetail.mail1        = ""
        wdetail.mail2        = ""
        wdetail.mail3        = ""
        wdetail.mail4        = ""
        wdetail.mail5        = ""
        wdetail.mail6        = ""
        wdetail.mail7        = ""
        wdetail.mail8        = ""
        wdetail.mail9        = ""
        wdetail.mail10       = ""
        wdetail.fax          = ""
        wdetail.lineID       = ""
        wdetail.name2        = ""
        wdetail.name3        = "Null"
        wdetail.benname      = IF INDEX(wdetail2.notifyno,"ยกเลิก 8.3") <> 0 THEN "Null" ELSE IF INDEX(wdetail2.notifyno,"ยกเลิก8.3") <> 0 THEN "Null" ELSE ""  
        wdetail.payercod     = "FTIB"
        wdetail.vatcode      = ""
        wdetail.instcod1     = ""
        wdetail.insttyp1     = ""
        wdetail.insttitle1   = IF wdetail2.instyp = "PR" THEN "" ELSE trim(wdetail2.titleNAMEpay)      
        wdetail.instname1    = IF wdetail2.instyp = "PR" THEN "Null" ELSE trim(wdetail2.NAMEpay) 
        wdetail.instlname1   = IF wdetail2.instyp = "PR" THEN "" ELSE trim(wdetail2.lastNAMEpay )     
        wdetail.instic1      = ""
        wdetail.instbr1      = ""
        wdetail.instaddr11   = IF wdetail2.instyp = "PR" THEN "" ELSE trim(wdetail2.addpay1)      
        wdetail.instaddr21   = IF wdetail2.instyp = "PR" THEN "" ELSE trim(wdetail2.addpay2)      
        wdetail.instaddr31   = IF wdetail2.instyp = "PR" THEN "" ELSE trim(wdetail2.addpay3)      
        wdetail.instaddr41   = IF wdetail2.instyp = "PR" THEN "" ELSE trim(wdetail2.addpay4)      
        wdetail.instpost1    = IF wdetail2.instyp = "PR" THEN "" ELSE trim(wdetail2.postpay)      
        wdetail.instprovcod1 = ""
        wdetail.instdistcod1 = ""
        wdetail.instsdistcod1= ""
        wdetail.instprm1     = ""
        wdetail.instrstp1    = ""
        wdetail.instrtax1    = ""
        wdetail.instcomm01   = ""
        wdetail.instcomm12   = ""
        wdetail.instcod2     = ""
        wdetail.insttyp2     = ""
        wdetail.insttitle2   = ""
        wdetail.instname2    = ""
        wdetail.instlname2   = ""
        wdetail.instic2      = ""
        wdetail.instbr2      = ""
        wdetail.instaddr12   = ""
        wdetail.instaddr22   = ""
        wdetail.instaddr32   = ""
        wdetail.instaddr42   = ""
        wdetail.instpost2    = ""
        wdetail.instprovcod2 = ""
        wdetail.instdistcod2 = ""
        wdetail.instsdistcod2= ""
        wdetail.instprm2     = ""
        wdetail.instrstp2    = ""
        wdetail.instrtax2    = ""
        wdetail.instcomm02   = ""
        wdetail.instcomm22   = ""
        wdetail.instcod3     = ""
        wdetail.insttyp3     = ""
        wdetail.insttitle3   = ""
        wdetail.instname3    = ""
        wdetail.instlname3   = ""
        wdetail.instic3      = ""
        wdetail.instbr3      = ""
        wdetail.instaddr13   = ""
        wdetail.instaddr23   = ""
        wdetail.instaddr33   = ""
        wdetail.instaddr43   = ""
        wdetail.instpost3    = ""
        wdetail.instprovcod3 = ""
        wdetail.instdistcod3 = ""
        wdetail.instsdistcod3= ""
        wdetail.instprm3     = ""
        wdetail.instrstp3    = ""
        wdetail.instrtax3    = ""
        wdetail.instcomm03   = ""
        wdetail.instcomm23   = ""
        wdetail.covcod       = trim(wdetail2.covcod)      
        wdetail.garage       = trim(wdetail2.Garage)       
        wdetail.special      = ""
        wdetail.inspec       = ""
        wdetail.class70      = trim(wdetail2.sclass)      
        wdetail.vehuse       = ""
        wdetail.redbook      = ""
        wdetail.brand        = trim(wdetail2.brand)        
        wdetail.model        = trim(wdetail2.model)        
        wdetail.submodel     = ""
        wdetail.yrmanu       = trim(wdetail2.caryear)      
        wdetail.chasno       = trim(wdetail2.chasno)       
        wdetail.engno        = trim(wdetail2.engno)        
        wdetail.eng_no2      = ""
        wdetail.seat         = ""
        wdetail.engcc        = trim(wdetail2.cc)           
        wdetail.weight       = ""
        wdetail.watt         = ""
        wdetail.body         = ""
        wdetail.ntype        = IF trim(wdetail2.renewtyp) = "R" THEN "N" ELSE "Y"     
        wdetail.re_year      = ""
        wdetail.vehreg       = IF TRIM(wdetail2.reg2) = "" THEN trim(wdetail2.reg1)  ELSE trim(wdetail2.reg1) + " " + TRIM(wdetail2.reg2)         
        wdetail.re_country   = trim(wdetail2.provinco)     
        wdetail.cargrp       = ""
        wdetail.colorcar     = "" /*trim(wdetail2.COLORno) */     
        wdetail.fule         = ""
        wdetail.drivnam      = "" /*wdetail2.Drivnam*/      
        wdetail.ntitle1      = "" /*wdetail2.Driver1*/      
        wdetail.drivername1  = "" /*wdetail2.Driver1*/      
        wdetail.dname2       = "" /*wdetail2.Driver1*/      
        wdetail.dicno        = ""
        wdetail.dgender1     = ""
        wdetail.dbirth       = "" /*wdetail2.DrivDate1 */   
        wdetail.doccup       = ""
        wdetail.ddriveno     = "" /*wdetail2.DrivLicense1 */
        wdetail.drivexp1     = ""
        wdetail.dconsen1     = ""
        wdetail.dlevel1      = ""
        wdetail.ntitle2      = "" /*wdetail2.Driver2 */     
        wdetail.drivername2  = "" /*wdetail2.Driver2 */     
        wdetail.ddname1      = "" /*wdetail2.Driver2 */     
        wdetail.ddicno       = ""
        wdetail.dgender2     = ""
        wdetail.ddbirth      = "" /*wdetail2.DrivDate2*/    
        wdetail.ddoccup      = ""
        wdetail.dddriveno    = "" /*wdetail2.DrivLicense2 */
        wdetail.drivexp2     = ""
        wdetail.dconsen2     = ""
        wdetail.dlevel2      = ""
        wdetail.ntitle3      = ""
        wdetail.dname3       = ""
        wdetail.dlname3      = ""
        wdetail.dicno3       = ""
        wdetail.dgender3     = ""
        wdetail.dbirth3      = ""
        wdetail.doccup3      = ""
        wdetail.ddriveno3    = ""
        wdetail.drivexp3     = ""
        wdetail.dconsen3     = ""
        wdetail.dlevel3      = ""
        wdetail.ntitle4      = ""
        wdetail.dname4       = ""
        wdetail.dlname4      = ""
        wdetail.dicno4       = ""
        wdetail.dgender4     = ""
        wdetail.dbirth4      = ""
        wdetail.doccup4      = ""
        wdetail.ddriveno4    = ""
        wdetail.drivexp4     = ""
        wdetail.dconsen4     = ""
        wdetail.dlevel4      = ""
        wdetail.ntitle5      = ""
        wdetail.dname5       = ""
        wdetail.dlname5      = ""
        wdetail.dicno5       = ""
        wdetail.dgender5     = ""
        wdetail.dbirth5      = ""
        wdetail.doccup5      = ""
        wdetail.ddriveno5    = ""
        wdetail.drivexp5     = ""
        wdetail.dconsen5     = ""
        wdetail.dlevel5      = ""
        wdetail.baseplus     = ""
        wdetail.siplus       = ""
        wdetail.rs10         = ""
        wdetail.comper       = ""
        wdetail.comacc       = ""
        wdetail.deductpd     = ""
        wdetail.DOD          = "" /*wdetail2.Deduct */      
        wdetail.DOD1         = ""
        wdetail.DPD          = ""
        wdetail.maksi        = ""
        wdetail.tpfire       = trim(wdetail2.covamount)    
        wdetail.NO_41        = ""
        wdetail.ac2          = ""
        wdetail.ac4          = ""
        wdetail.ac5          = ""
        wdetail.ac6          = ""
        wdetail.ac7          = ""
        wdetail.NO_42        = ""
        wdetail.NO_43        = ""
        wdetail.base         = ""
        wdetail.unname       = ""
        wdetail.nname        = ""
        wdetail.tpbi         = ""
        wdetail.bi2          = ""
        wdetail.tppd         = ""
        wdetail.dodamt       = ""
        wdetail.dod1amt      = ""
        wdetail.dpdamt       = ""
        wdetail.ry01         = ""
        wdetail.ry412        = ""
        wdetail.ry413        = ""
        wdetail.ry414        = ""
        wdetail.ry02         = ""
        wdetail.ry03         = ""
        wdetail.fleet        = ""
        wdetail.ncb          = ""
        wdetail.claim        = ""
        wdetail.dspc         = ""
        wdetail.cctv         = ""
        wdetail.dstf         = ""
        wdetail.fleetprem    = ""
        wdetail.ncbprem      = ""
        wdetail.clprem       = ""
        wdetail.dspcprem     = ""
        wdetail.cctvprem     = ""
        wdetail.dstfprem     = ""
        wdetail.premt        = IF DECI(wdetail2.grpssprem) <> 0 THEN STRING(TRUNCATE(((deci(wdetail2.grpssprem) * 100 ) / 107.43 ),0 ) + (IF ((deci(wdetail2.grpssprem) * 100) / 107.43) - TRUNCATE(((deci(wdetail2.grpssprem) * 100 ) / 107.43 ),0 ) > 0 THEN 1 ELSE 0 )) 
                               ELSE "0" /*nv_netprem */
        wdetail.rstp_t       = ""
        wdetail.rtax_t       = ""
        wdetail.comper70     = ""
        wdetail.comprem70    = ""
        wdetail.agco70       = ""
        wdetail.comco_per70  = ""
        wdetail.comco_prem70 = ""
        wdetail.dgpackge     = ""
        wdetail.danger1      = ""
        wdetail.danger2      = ""
        wdetail.dgsi         = ""
        wdetail.dgrate       = ""
        wdetail.dgfeet       = ""
        wdetail.dgncb        = ""
        wdetail.dgdisc       = ""
        wdetail.dgwdisc      = ""
        wdetail.dgatt        = ""
        wdetail.dgfeetprm    = ""
        wdetail.dgncbprm     = ""
        wdetail.dgdiscprm    = ""
        wdetail.dgWdiscprm   = ""
        wdetail.dgprem       = ""
        wdetail.dgrstp_t     = ""
        wdetail.dgrtax_t     = ""
        wdetail.dgcomper     = ""
        wdetail.dgcomprem    = ""
        wdetail.cltxt        = ""
        wdetail.clamount     = ""
        wdetail.faultno      = ""
        wdetail.faultprm     = ""
        wdetail.goodno       = ""
        wdetail.goodprm      = ""
        wdetail.loss         = ""
        wdetail.compolusory  = ""      
        wdetail.comdat72     = IF deci(wdetail2.comprem) > 0 THEN trim(wdetail2.comeffecdat)  ELSE ""  
        wdetail.expdat72     = IF deci(wdetail2.comprem) > 0 then trim(wdetail2.norcovenddat) else ""
        wdetail.barcode      = IF deci(wdetail2.comprem) > 0 then trim(wdetail2.compno)       else ""
        wdetail.class72      = ""
        wdetail.dstf72       = ""
        wdetail.dstfprem72   = ""
        wdetail.premt72      = IF deci(wdetail2.comprem) > 0 THEN TRIM(wdetail2.comprem) ELSE "0"      
        wdetail.rstp_t72     = ""
        wdetail.rtax_t72     = ""
        wdetail.comper72     = ""
        wdetail.comprem72    = ""
        wdetail.battno       = ""
        wdetail.battyr       = ""
        wdetail.battprice    = ""
        wdetail.battsi       = ""
        wdetail.battrate     = ""
        wdetail.battprm      = ""
        wdetail.chargno      = ""
        wdetail.chargsi      = ""
        wdetail.chargrate    = ""
        wdetail.chargprm     = "" 
        wdetail.pass         = "Y"
        wdetail.senddate     = TRIM(wdetail2.senddat) .    
END.
RELEASE wdetail.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assigntitle C-Win 
PROCEDURE proc_assigntitle :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN fi_process = "Check title : " + wdetail2.chasno + "...." .
DISP fi_process WITH FRAME fr_main.

IF TRIM(wdetail2.insname) <> " " THEN DO: 
    IF  R-INDEX(TRIM(wdetail2.insname),"จก.")             <> 0  OR              
        R-INDEX(TRIM(wdetail2.insname),"จำกัด")           <> 0  OR  
        R-INDEX(TRIM(wdetail2.insname),"(มหาชน)")         <> 0  OR  
        R-INDEX(TRIM(wdetail2.insname),"INC.")            <> 0  OR 
        R-INDEX(TRIM(wdetail2.insname),"CO.")             <> 0  OR 
        R-INDEX(TRIM(wdetail2.insname),"LTD.")            <> 0  OR 
        R-INDEX(TRIM(wdetail2.insname),"LIMITED")         <> 0  OR 
        INDEX(TRIM(wdetail2.insname),"บริษัท")            <> 0  OR 
        INDEX(TRIM(wdetail2.insname),"บ.")                <> 0  OR 
        INDEX(TRIM(wdetail2.insname),"บจก.")              <> 0  OR 
        INDEX(TRIM(wdetail2.insname),"หจก.")              <> 0  OR 
        INDEX(TRIM(wdetail2.insname),"หสน.")              <> 0  OR 
        INDEX(TRIM(wdetail2.insname),"บรรษัท")            <> 0  OR 
        INDEX(TRIM(wdetail2.insname),"มูลนิธิ")           <> 0  OR 
        INDEX(TRIM(wdetail2.insname),"ห้าง")              <> 0  OR 
        INDEX(TRIM(wdetail2.insname),"ห้างหุ้นส่วน")      <> 0  OR 
        INDEX(TRIM(wdetail2.insname),"ห้างหุ้นส่วนจำกัด") <> 0  OR
        INDEX(TRIM(wdetail2.insname),"ห้างหุ้นส่วนจำก")   <> 0  OR  
        INDEX(TRIM(wdetail2.insname),"และ/หรือ")          <> 0  THEN DO: 

        ASSIGN  wdetail2.instyp = "CO".
        IF INDEX(wdetail2.insname," ") <> 0  THEN DO:
            ASSIGN wdetail2.ntitle   = trim(SUBSTR(wdetail2.insname,1,INDEX(wdetail2.insname," ")))
                   wdetail2.insname  = trim(substr(trim(wdetail2.insname),LENGTH(wdetail2.ntitle) + 1 ))
                   wdetail2.lastname = ""  .
        END.
    END.
    ELSE DO: 
        ASSIGN wdetail2.instyp   = "PR" 
               wdetail2.ntitle   = trim(substr(trim(wdetail2.insname),1,INDEX(wdetail2.insname," ") - 1)) 
               wdetail2.insname  = trim(substr(trim(wdetail2.insname),LENGTH(wdetail2.ntitle) + 1)) 
               wdetail2.lastname = trim(SUBSTR(wdetail2.insname,R-INDEX(wdetail2.insname," ")))
               wdetail2.insname  = trim(substr(trim(wdetail2.insname),1,LENGTH(wdetail2.insname) - LENGTH(wdetail2.lastname))) .
    END.
END. 

IF wdetail2.instyp  = "CO"  THEN DO:
    IF wdetail2.namepay <> ""  THEN DO:
        IF  R-INDEX(TRIM(wdetail2.namepay),"จก.")        <> 0  OR              
            R-INDEX(TRIM(wdetail2.namepay),"จำกัด")      <> 0  OR  
            R-INDEX(TRIM(wdetail2.namepay),"(มหาชน)")    <> 0  OR  
            R-INDEX(TRIM(wdetail2.namepay),"INC.")       <> 0  OR 
            R-INDEX(TRIM(wdetail2.namepay),"CO.")        <> 0  OR 
            R-INDEX(TRIM(wdetail2.namepay),"LTD.")       <> 0  OR 
            R-INDEX(TRIM(wdetail2.namepay),"LIMITED")    <> 0  OR 
            INDEX(TRIM(wdetail2.namepay),"บริษัท")       <> 0  OR 
            INDEX(TRIM(wdetail2.namepay),"บ.")           <> 0  OR 
            INDEX(TRIM(wdetail2.namepay),"บจก.")         <> 0  OR 
            INDEX(TRIM(wdetail2.namepay),"หจก.")         <> 0  OR 
            INDEX(TRIM(wdetail2.namepay),"หสน.")         <> 0  OR 
            INDEX(TRIM(wdetail2.namepay),"บรรษัท")       <> 0  OR 
            INDEX(TRIM(wdetail2.namepay),"มูลนิธิ")      <> 0  OR 
            INDEX(TRIM(wdetail2.namepay),"ห้าง")         <> 0  OR 
            INDEX(TRIM(wdetail2.namepay),"ห้างหุ้นส่วน") <> 0  OR 
            INDEX(TRIM(wdetail2.namepay),"ห้างหุ้นส่วนจำกัด") <> 0  OR
            INDEX(TRIM(wdetail2.namepay),"ห้างหุ้นส่วนจำก")   <> 0  OR  
            INDEX(TRIM(wdetail2.namepay),"และ/หรือ")          <> 0  THEN DO: 

            IF INDEX(wdetail2.namepay,"บจก.โตโยต้า ลีสซิ่ง") <> 0 THEN DO:
              ASSIGN wdetail2.titlenamepay  = "" 
                     wdetail2.namepay       = "Null" 
                     wdetail2.lastnamepay   = "" 
                     wdetail2.addpay1       = "" 
                     wdetail2.addpay2       = "" 
                     wdetail2.addpay3       = "" 
                     wdetail2.addpay4       = "" 
                     wdetail2.postpay       = "" .
            END.
            ELSE DO:
                ASSIGN wdetail2.titlenamepay = trim(SUBSTR(wdetail2.namepay,1,INDEX(wdetail2.namepay," ")))     
                       wdetail2.namepay      = trim(substr(trim(wdetail2.namepay),LENGTH(wdetail2.titlenamepay) + 1 ))   
                       wdetail2.lastnamepay  = ""  .
            END.
        END.
        ELSE DO: 
            ASSIGN wdetail2.titlenamepay  = trim(substr(trim(wdetail2.namepay),1,INDEX(wdetail2.namepay," ") - 1)) 
                   wdetail2.namepay       = trim(substr(trim(wdetail2.namepay),LENGTH(wdetail2.titlenamepay) + 1)) 
                   wdetail2.lastnamepay   = trim(SUBSTR(wdetail2.namepay,R-INDEX(wdetail2.namepay," ")))
                   wdetail2.namepay       = trim(substr(trim(wdetail2.namepay),1,LENGTH(wdetail2.namepay) - LENGTH(wdetail2.lastnamepay))) .
        END.
    END.
END.
ELSE DO:
    ASSIGN wdetail2.titlenamepay  = "" 
           wdetail2.namepay       = "Null" 
           wdetail2.lastnamepay   = "" 
           wdetail2.addpay1       = "" 
           wdetail2.addpay2       = "" 
           wdetail2.addpay3       = "" 
           wdetail2.addpay4       = "" 
           wdetail2.postpay       = "" .
END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkacces C-Win 
PROCEDURE proc_chkacces :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_acctxt AS CHAR FORMAT "x(70)" INIT "" .
DEF  VAR nv_count AS INTE INIT 0.

ASSIGN fi_process = "Check accessory : " + wdetail2.chasno + "...." .
DISP fi_process WITH FRAME fr_main.

ASSIGN 
   nv_acc  = ""   
   nv_acc1 = ""        nv_acc6 = ""        nv_acc11 = ""    nv_acc16 = ""      
   nv_acc2 = ""        nv_acc7 = ""        nv_acc12 = ""    nv_acc17 = ""      
   nv_acc3 = ""        nv_acc8 = ""        nv_acc13 = ""    nv_acc18 = ""      
   nv_acc4 = ""        nv_acc9 = ""        nv_acc14 = ""    nv_acc19 = ""      
   nv_acc5 = ""        nv_acc10 = ""       nv_acc15 = ""    nv_acc20 = "" .    

IF trim(wdetail2.access) <> ""  THEN DO:
    ASSIGN wdetail2.access = TRIM(wdetail2.access) .
    IF LENGTH(wdetail2.access) <= 60  THEN DO:
        ASSIGN nv_acc1 =  TRIM(wdetail2.access) .
    END.
    ELSE DO:
        ASSIGN nv_acc = TRIM(wdetail2.access) .
        nv_count = 1 .
        loop_chk1: 
        REPEAT:
            IF nv_count <= 20 THEN DO:
        
              IF (INDEX(nv_acc,",") <> 0 ) THEN 
                  ASSIGN  n_acctxt = TRIM(SUBSTR(nv_acc,1,INDEX(nv_acc,",")))
                  nv_acc = TRIM(SUBSTR(nv_acc,INDEX(nv_acc,",") + 1)).
              ELSE ASSIGN  n_acctxt = TRIM(nv_acc)
                  nv_acc = "".
        
              IF nv_count =  1  THEN assign  nv_acc1 =  trim(n_acctxt) .
              if nv_count =  2  THEN assign  nv_acc2 =  trim(n_acctxt) .
              if nv_count =  3  THEN assign  nv_acc3 =  trim(n_acctxt) .
              if nv_count =  4  THEN assign  nv_acc4 =  trim(n_acctxt) .
              if nv_count =  5  THEN assign  nv_acc5 =  trim(n_acctxt) .
              if nv_count =  6  THEN assign  nv_acc6 =  trim(n_acctxt) .
              if nv_count =  7  THEN assign  nv_acc7 =  trim(n_acctxt) .
              if nv_count =  8  THEN assign  nv_acc8 =  trim(n_acctxt) .
              if nv_count =  9  THEN assign  nv_acc9 =  trim(n_acctxt) .
              if nv_count =  10 THEN assign  nv_acc10 = trim(n_acctxt) .
              if nv_count =  11 THEN assign  nv_acc11 = trim(n_acctxt) .
              if nv_count =  12 THEN assign  nv_acc12 = trim(n_acctxt) .
              if nv_count =  13 THEN assign  nv_acc13 = trim(n_acctxt) .
              if nv_count =  14 THEN assign  nv_acc14 = trim(n_acctxt) .
              if nv_count =  15 THEN assign  nv_acc15 = trim(n_acctxt) .
              if nv_count =  16 THEN assign  nv_acc16 = trim(n_acctxt) .
              if nv_count =  17 THEN assign  nv_acc17 = trim(n_acctxt) .
              if nv_count =  18 THEN assign  nv_acc18 = trim(n_acctxt) .
              if nv_count =  19 THEN assign  nv_acc19 = trim(n_acctxt) .
              if nv_count =  20 THEN assign  nv_acc20 = trim(n_acctxt) .
        
              nv_count = nv_count + 1.
              IF nv_count > 20 THEN LEAVE loop_chk1.
            END.
        END.
        
        nv_count = 1.
        loop_chk2: 
        REPEAT:
            IF nv_count <= 20 THEN DO:
               IF (length(nv_acc1 + nv_acc2) <= 60 ) THEN DO:
                   ASSIGN  nv_acc1 = nv_acc1  +  nv_acc2
                           nv_acc2 = "" .
               END.
               ELSE IF (nv_acc1 = "") THEN DO:
                   ASSIGN nv_acc1 = nv_acc2 
                          nv_acc2 = "" .
               END.
            
               IF (length(nv_acc2 +  nv_acc3 ) <= 60 ) THEN DO:
                ASSIGN nv_acc2 = nv_acc2  +  nv_acc3
                       nv_acc3 = "" .
               END.
               ELSE IF (nv_acc2 = "") THEN DO:
                   ASSIGN nv_acc2 = nv_acc3 
                          nv_acc3 = "" .
               END.
            
               IF (length(nv_acc3 +  nv_acc4 ) <= 60 ) THEN DO:
                   ASSIGN nv_acc3 = nv_acc3  +  nv_acc4
                          nv_acc4 = "" .
               END.
               ELSE IF (nv_acc3 = "") THEN DO:
                   ASSIGN nv_acc3 = nv_acc4 
                         nv_acc4 = "" .
               END.
            
               IF (length(nv_acc4 +  nv_acc5 ) <= 60 ) THEN DO:
                   ASSIGN nv_acc4 = nv_acc4  +  nv_acc5 
                          nv_acc5 = "" .
               END.
               ELSE IF (nv_acc4 = "") THEN DO:
                   ASSIGN nv_acc4 = nv_acc5 
                          nv_acc5 = "" .
               END.
            
               IF (length(nv_acc5 +  nv_acc6 ) <= 60 ) THEN DO:
                   ASSIGN nv_acc5 = nv_acc5  +  nv_acc6
                          nv_acc6 = "" .
               END.
               ELSE IF (nv_acc5 = "") THEN  DO:
                   ASSIGN nv_acc5 = nv_acc6 
                          nv_acc6 = ""  .
               END.
            
               IF (length(nv_acc6 +  nv_acc7 ) <= 60 ) THEN DO:
                   ASSIGN nv_acc6 = nv_acc6  +  nv_acc7
                          nv_acc7 = "" .
               END.
               ELSE IF (nv_acc6 = "") THEN  DO:
                   ASSIGN nv_acc6 = nv_acc7 
                          nv_acc7 = ""  .
               END.
            
                IF (length(nv_acc7 +  nv_acc8 ) <= 60 ) THEN DO:
                   ASSIGN nv_acc7 = nv_acc7  +  nv_acc8
                          nv_acc8 = "" .
               END.
               ELSE IF (nv_acc7 = "") THEN  DO:
                   ASSIGN nv_acc7 = nv_acc8 
                          nv_acc8 = ""  .
               END.
            
                IF (length(nv_acc8 +  nv_acc9 ) <= 60 ) THEN DO:
                   ASSIGN nv_acc8 = nv_acc8  +  nv_acc9
                          nv_acc9 = "" .
               END.
               ELSE IF (nv_acc8 = "") THEN  DO:
                   ASSIGN nv_acc8 = nv_acc9 
                          nv_acc9 = ""  .
               END.
            
                IF (length(nv_acc9 +  nv_acc10 ) <= 60 ) THEN DO:
                   ASSIGN nv_acc9 = nv_acc9  +  nv_acc10
                          nv_acc10 = "" .
               END.
               ELSE IF (nv_acc9 = "") THEN  DO:
                   ASSIGN nv_acc9 = nv_acc10
                          nv_acc10 = ""  .
               END.
            
                IF (length(nv_acc10 +  nv_acc11 ) <= 60 ) THEN DO:
                   ASSIGN nv_acc10 = nv_acc10  +  nv_acc11
                          nv_acc11 = "" .
               END.
               ELSE IF (nv_acc10 = "") THEN  DO:
                   ASSIGN nv_acc10 = nv_acc11 
                          nv_acc11 = ""  .
               END.
            
                IF (length(nv_acc11 +  nv_acc12 ) <= 60 ) THEN DO:
                   ASSIGN nv_acc11 = nv_acc11  +  nv_acc12
                          nv_acc12 = "" .
               END.
               ELSE IF (nv_acc11 = "") THEN  DO:
                   ASSIGN nv_acc11 = nv_acc12 
                          nv_acc12 = ""  .
               END.
            
                IF (length(nv_acc12 +  nv_acc13 ) <= 60 ) THEN DO:
                   ASSIGN nv_acc12 = nv_acc12  +  nv_acc13
                          nv_acc13 = "" .
               END.
               ELSE IF (nv_acc12 = "") THEN  DO:
                   ASSIGN nv_acc12 = nv_acc13 
                          nv_acc13 = ""  .
               END.
            
               IF (length(nv_acc13 +  nv_acc14 ) <= 60 ) THEN DO:
                   ASSIGN nv_acc13 = nv_acc13  +  nv_acc14
                          nv_acc14 = "" .
               END.
               ELSE IF (nv_acc13 = "") THEN  DO:
                   ASSIGN nv_acc13 = nv_acc14
                          nv_acc14 = ""  .
               END.
            
               IF (length(nv_acc14 +  nv_acc15 ) <= 60 ) THEN DO:
                   ASSIGN nv_acc14 = nv_acc14  +  nv_acc15
                          nv_acc15 = "" .
               END.
               ELSE IF (nv_acc14 = "") THEN  DO:
                   ASSIGN nv_acc14 = nv_acc15 
                          nv_acc15 = ""  .
               END.
            
                IF (length(nv_acc15 +  nv_acc16 ) <= 60 ) THEN DO:
                   ASSIGN nv_acc15 = nv_acc15  +  nv_acc16
                          nv_acc16 = "" .
               END.
               ELSE IF (nv_acc15 = "") THEN  DO:
                   ASSIGN nv_acc15 = nv_acc16 
                          nv_acc16 = ""  .
               END.
            
               IF (length(nv_acc16 +  nv_acc17 ) <= 60 ) THEN DO:
                   ASSIGN nv_acc16 = nv_acc16  +  nv_acc17
                          nv_acc17 = "" .
               END.
               ELSE IF (nv_acc16 = "") THEN  DO:
                   ASSIGN nv_acc16 = nv_acc17 
                          nv_acc17 = ""  .
               END.
            
               IF (length(nv_acc17 +  nv_acc18 ) <= 60 ) THEN DO:
                   ASSIGN nv_acc17 = nv_acc17  +  nv_acc18
                          nv_acc18 = "" .
               END.
               ELSE IF (nv_acc17 = "") THEN  DO:
                   ASSIGN nv_acc17 = nv_acc18 
                          nv_acc18 = ""  .
               END.
            
               IF (length(nv_acc18 +  nv_acc19 ) <= 60 ) THEN DO:
                   ASSIGN nv_acc18 = nv_acc18  +  nv_acc19
                          nv_acc19 = "" .
               END.
               ELSE IF (nv_acc18 = "") THEN  DO:
                   ASSIGN nv_acc18 = nv_acc19 
                          nv_acc19 = ""  .
               END.
            
               IF (length(nv_acc19 +  nv_acc20 ) <= 60 ) THEN DO:
                   ASSIGN nv_acc19 = nv_acc19  +  nv_acc20
                          nv_acc20 = "" .
               END.
               ELSE IF (nv_acc19 = "") THEN  DO:
                   ASSIGN nv_acc19 = nv_acc20 
                          nv_acc20 = ""  .
               END.
            
               IF (length(nv_acc20 +  nv_acc ) <= 60 ) THEN DO:
                   ASSIGN nv_acc20 = nv_acc20  +  nv_acc
                          nv_acc = "" .
               END.
               ELSE IF (nv_acc20 = "") THEN  DO:
                   ASSIGN nv_acc20 = nv_acc
                          nv_acc = ""  .
               END.
            
               IF nv_acc1 = ""   THEN assign  nv_acc1  =  trim(nv_acc2)    nv_acc2 = "" . 
               if nv_acc2 = ""   THEN assign  nv_acc2  =  trim(nv_acc3)    nv_acc3 = "" . 
               if nv_acc3 = ""   THEN assign  nv_acc3  =  trim(nv_acc4)    nv_acc4 = "" .
               if nv_acc4 = ""   THEN assign  nv_acc4  =  trim(nv_acc5)    nv_acc5 = "" . 
               if nv_acc5 = ""   THEN assign  nv_acc5  =  trim(nv_acc6)    nv_acc6 = "" .
               if nv_acc6 = ""   THEN assign  nv_acc6  =  trim(nv_acc7)    nv_acc7 = "" .
               if nv_acc7 = ""   THEN assign  nv_acc7  =  trim(nv_acc8)    nv_acc8 = "" .
               if nv_acc8 = ""   THEN assign  nv_acc8  =  trim(nv_acc9)    nv_acc9 = "" .
               if nv_acc9 = ""   THEN assign  nv_acc9  =  trim(nv_acc10)   nv_acc10 = "" .
               if nv_acc10 = ""  THEN assign  nv_acc10 =  trim(nv_acc11)   nv_acc11 = "" .
               if nv_acc11 = ""  THEN assign  nv_acc11 =  trim(nv_acc12)   nv_acc12 = "" .   
               if nv_acc12 = ""  THEN assign  nv_acc12 =  trim(nv_acc13)   nv_acc13 = "" .   
               if nv_acc13 = ""  THEN assign  nv_acc13 =  trim(nv_acc14)   nv_acc14 = "" .   
               if nv_acc14 = ""  THEN assign  nv_acc14 =  trim(nv_acc15)   nv_acc15 = "" .   
               if nv_acc15 = ""  THEN assign  nv_acc15 =  trim(nv_acc16)   nv_acc16 = "" . 
               if nv_acc16 = ""  THEN assign  nv_acc16 =  trim(nv_acc17)   nv_acc17 = "" . 
               if nv_acc17 = ""  THEN assign  nv_acc17 =  trim(nv_acc18)   nv_acc18 = "" . 
               if nv_acc18 = ""  THEN assign  nv_acc18 =  trim(nv_acc19)   nv_acc19 = "" . 
               if nv_acc19 = ""  THEN assign  nv_acc19 =  trim(nv_acc20)   nv_acc20 = "" . 
               if nv_acc20 = ""  THEN assign  nv_acc20 =  trim(nv_acc)     nv_acc  = "" . 
            
               nv_count = nv_count + 1 .
               IF nv_count > 20 THEN LEAVE loop_chk2.
            END.
        END. /* end repeat*/
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkbrand C-Win 
PROCEDURE proc_chkbrand :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN fi_process = "Check Brand and Garage : " + wdetail2.chasno + "...." .
DISP fi_process WITH FRAME fr_main.
DO:
    IF      trim(wdetail2.brand) = "001" THEN  wdetail2.brand = "TOYOTA"        .     /*โตโยต้า          */    
    ELSE IF trim(wdetail2.brand) = "002" THEN  wdetail2.brand = "HINO"          .     /*ฮีโน่                */
    ELSE IF trim(wdetail2.brand) = "003" THEN  wdetail2.brand = "CHEROKEE"      .     /*เชอโรกี          */    
    ELSE IF trim(wdetail2.brand) = "004" THEN  wdetail2.brand = "DAIHATSU"      .     /*ไดฮัทสุ          */    
    ELSE IF trim(wdetail2.brand) = "005" THEN  wdetail2.brand = "VOLVO"         .     /*วอลโว่           */    
    ELSE IF trim(wdetail2.brand) = "006" THEN  wdetail2.brand = "BMW"           .     /*บีเอ็มดับบลิว        */
    ELSE IF trim(wdetail2.brand) = "007" THEN  wdetail2.brand = "NISSAN"        .     /*นิสสัน           */    
    ELSE IF trim(wdetail2.brand) = "008" THEN  wdetail2.brand = "OPEL"          .     /*โอเปิล           */    
    ELSE IF trim(wdetail2.brand) = "009" THEN  wdetail2.brand = "SAAB"          .     /*ซาบ           */  
    ELSE IF trim(wdetail2.brand) = "010" THEN  wdetail2.brand = "PEUGEOT"       .     /*เปอร์โย          */    
    ELSE IF trim(wdetail2.brand) = "011" THEN  wdetail2.brand = "CHRYSLER"      .     /*ไคร์สเลอร์   */    
    ELSE IF trim(wdetail2.brand) = "012" THEN  wdetail2.brand = "VOLKSWAGEN"    .     /*โวสวาเกนต์   */    
    ELSE IF trim(wdetail2.brand) = "013" THEN  wdetail2.brand = "MITSUBISHI"    .     /*มิซูบิชิ         */
    ELSE IF trim(wdetail2.brand) = "014" THEN  wdetail2.brand = "ISUZU"         .     /*อีซูซุ           */    
    ELSE IF trim(wdetail2.brand) = "015" THEN  wdetail2.brand = "MAZDA"         .     /*มาสด้า           */    
    ELSE IF trim(wdetail2.brand) = "016" THEN  wdetail2.brand = "CITROEN"       .     /*ซีตรอง           */    
    ELSE IF trim(wdetail2.brand) = "017" THEN  wdetail2.brand = "HONDA"         .     /*ฮอนด้า           */    
    ELSE IF trim(wdetail2.brand) = "018" THEN  wdetail2.brand = "LEXUS"         .     /*เล็กซัส          */    
    ELSE IF trim(wdetail2.brand) = "999" THEN  wdetail2.brand = "Other"         .     /*อื่นๆ                */
    ELSE IF trim(wdetail2.brand) = "101" THEN  wdetail2.brand = "CITIA HARDWARE".     /*CITIA HARDWARE*/     
    ELSE IF trim(wdetail2.brand) = "031" THEN  wdetail2.brand = "HARRIER"       .     /*แฮริเออร์        */
    ELSE IF trim(wdetail2.brand) = "032" THEN  wdetail2.brand = "RANGE ROVER"   .     /*RANGE ROVER  */    
    ELSE IF trim(wdetail2.brand) = "030" THEN  wdetail2.brand = "Porsche"       .     /*ปอร์เช่          */    
    ELSE IF trim(wdetail2.brand) = "019" THEN  wdetail2.brand = "Benz"          .     /*เบนซ์                */
    ELSE IF trim(wdetail2.brand) = "020" THEN  wdetail2.brand = "Audi"          .     /*ออดี้                */
    ELSE IF trim(wdetail2.brand) = "021" THEN  wdetail2.brand = "Ford"          .     /*ฟอร์ด                */
    ELSE IF trim(wdetail2.brand) = "022" THEN  wdetail2.brand = "SUZUKI"        .     /*ซูซูกิ           */    
    ELSE IF trim(wdetail2.brand) = "023" THEN  wdetail2.brand = "Cheverolet"    .     /*เชฟโรเลต         */
    ELSE IF trim(wdetail2.brand) = "024" THEN  wdetail2.brand = "TATA"          .     /*ทาทา         */
    ELSE IF trim(wdetail2.brand) = "026" THEN  wdetail2.brand = "Kubota"        .     /*คูโบต้า          */    
    ELSE IF trim(wdetail2.brand) = "027" THEN  wdetail2.brand = "Tadano"        .     /*ทาดาโน่          */    
    ELSE IF trim(wdetail2.brand) = "028" THEN  wdetail2.brand = "Hino Trailer"  .     /*Hino Trailer  */  
    ELSE IF trim(wdetail2.brand) = "025" THEN  wdetail2.brand = "PROTON"        .     /*โปรตอน           */    
    ELSE IF trim(wdetail2.brand) = "029" THEN  wdetail2.brand = "Mini Cooper"   .     /*มินิคูเปอร์  */    
    
    IF      TRIM(wdetail2.garage) = "1"  THEN  ASSIGN wdetail2.garage = "G" .
    ELSE IF TRIM(wdetail2.garage) = "2"  THEN  ASSIGN wdetail2.garage = ""  .
    ELSE IF TRIM(wdetail2.garage) = "3"  THEN  ASSIGN wdetail2.garage = "G" .

    IF trim(wdetail2.covcod) = "4" THEN ASSIGN wdetail2.covcod = "2.2" .
    ELSE IF trim(wdetail2.covcod) = "5" THEN ASSIGN wdetail2.covcod = "3.2" .
    
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkclaim C-Win 
PROCEDURE proc_chkclaim :
DEF VAR nv_cl       AS DECI.
DEF VAR nv_res      AS DECI.
DEF VAR nv_paid     AS DECI.
DEF VAR nv_loss     AS DECI FORMAT "->,>>>,>>>,>>>,>>9.99".
DEF VAR nv_os       AS DECI.
DEF VAR nv_netprm   AS DECI.
DEF VAR nv_lr1      AS DECI.
DEF VAR nv_lr3      AS DECI.
DO:
    ASSIGN fi_process = "Check Data Chassic: " + wdetail.chasno + " on Claim... " .
    DISP fi_process WITH FRAME fr_main.

    ASSIGN nv_res    = 0    
           nv_paid   = 0 
           nv_loss   = 0 
           nv_os     = 0 
           nv_netprm = 0 
           nv_lr1    = 0 
           nv_lr3    = 0  .
      
        FOR EACH siccl.clm100 USE-INDEX clm10002  NO-LOCK  WHERE
                 siccl.clm100.policy  = sicuw.uwm100.policy .
           FOR EACH siccl.clm120  USE-INDEX clm12001 WHERE  siccl.clm120.claim = siccl.clm100.claim NO-LOCK:
            nv_loss   = 0 .
               FOR EACH siccl.clm131 USE-INDEX clm13101      WHERE
                        siccl.clm131.claim  = siccl.clm120.claim   AND
                        siccl.clm131.clmant = siccl.clm120.clmant  AND
                        siccl.clm131.clitem = siccl.clm120.clitem  AND  
                        siccl.clm131.cpc_cd = "EPD"                NO-LOCK:
                        
                  IF siccl.clm131.res <> ? THEN
                  nv_res = nv_res + siccl.clm131.res.
               END.
               
               FOR EACH siccl.clm130 USE-INDEX clm13002      WHERE
                        siccl.clm130.claim  = siccl.clm120.claim   AND
                        siccl.clm130.clmant = siccl.clm120.clmant  AND
                        siccl.clm130.clitem = siccl.clm120.clitem  AND
                        siccl.clm130.cpc_cd = "EPD"            NO-LOCK:
               
                  IF clm130.netl_d <> ? THEN
                  nv_paid  = nv_paid + siccl.clm130.netl_d.
               END.

               IF clm100.padsts = "X" OR clm100.padsts = "F" OR clm100.padsts = "R" THEN DO:
                    ASSIGN nv_os  = 0 
                           nv_res = nv_paid.
               END.
               ELSE DO: 
                   ASSIGN nv_os =  nv_res - nv_paid .
               END.
           END. /* end clm120*/
        
           IF siccl.clm100.defau <> "TP" THEN DO:
                IF nv_os <> 0 OR nv_paid <> 0 THEN nv_loss = nv_os + nv_paid  .
           END.
        END. /* end clm100 */
        
        FOR EACH sicuw.uwd132  USE-INDEX uwd13290  WHERE
                 sicuw.uwd132.policy  = sicuw.uwm301.policy   AND
                 sicuw.uwd132.riskno  = sicuw.uwm301.riskno   AND
                 sicuw.uwd132.itemno  = sicuw.uwm301.itemno   NO-LOCK.
                
                 ASSIGN  nv_netprm = nv_netprm + sicuw.uwd132.gap_c .
        END.
        ASSIGN  nv_LR1  = ( nv_loss / nv_netprm ) * 100 
                nv_LR3  = TRUNCATE(nv_LR1,0) .
           IF (nv_LR1 - nv_LR3) > 0 THEN nv_LR3 = nv_LR3 + 1 .

       ASSIGN wdetail.loss = string(nv_lr3).

END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkcomp C-Win 
PROCEDURE proc_chkcomp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
def var nv_pack     AS CHAR INIT "" .
def var nv_sclass   AS CHAR INIT "" .
DEF VAR n_comp72    AS CHAR INIT "" .
DEF VAR n_vehuse    AS CHAR INIT "" .
DEF VAR nv_chkerror AS CHAR INIT "" .
DEF VAR nv_compremt AS DECI INIT 0 .
FOR EACH wdetail  .
    ASSIGN fi_process = "Check Data Chassic: " + wdetail.chasno + " Class compulsory.." .
    DISP fi_process WITH FRAME fr_main.

    ASSIGN nv_pack     = "" 
           nv_sclass   = "" 
           n_comp72    = "" 
           n_vehuse    = "" 
           nv_chkerror = "" 
           n_comp72    = "" 
           nv_compremt = 0 .

    IF deci(wdetail.premt72) <> 0 THEN DO:
        IF wdetail.comdat72 <> "" AND trim(wdetail.comdat72) <> TRIM(wdetail.comdat) AND DATE(wdetail.comdat72) < TODAY THEN DO:
           ASSIGN  wdetail.comment  = wdetail.comment + "/วันที่คุ้มครองของ พรบ. ไม่ตรงกับ กธ. และน้อยกว่าวันที่ปัจจุบัน "   
                   wdetail.pass     = "N".
        END.
        IF LENGTH(wdetail.class70) > 3 THEN DO :
            ASSIGN nv_pack   =  trim(substr(wdetail.class70,1,1))
                   nv_sclass =  trim(substr(wdetail.class70,2,3)) 
                   n_vehuse  =  IF trim(wdetail.vehuse) <> "" THEN TRIM(wdetail.vehuse) ELSE "1"  .
        END.
        ELSE DO:
            ASSIGN nv_pack   =  "T"
                   nv_sclass =  trim(wdetail.class70) 
                   n_vehuse  =  IF trim(wdetail.vehuse) <> "" THEN TRIM(wdetail.vehuse) ELSE "1"  .
        END.

       /* IF nv_sclass <> ""  THEN DO:
            RUN wgw/wgwcomp(INPUT  wdetail.premt72,     
                            INPUT  n_vehuse, 
                            INPUT  nv_pack ,  
                            INPUT  nv_sclass , 
                            INPUT  "N"        , 
                            INPUT  wdetail.garage , 
                            OUTPUT n_comp72       , 
                            OUTPUT nv_chkerror ) .
            
            IF nv_chkerror <> ""  THEN DO:
                ASSIGN nv_chkerror     = IF INDEX(nv_chkerror,"|") <> 0 THEN REPLACE(nv_chkerror,"|","/") ELSE TRIM(nv_chkerror)
                       nv_chkerror     = IF INDEX(nv_chkerror,"|") <> 0 THEN REPLACE(nv_chkerror,"|","/") ELSE TRIM(nv_chkerror)
                       wdetail.class72 = TRIM(n_comp72) 
                       wdetail.premt72 = IF deci(wdetail.premt72) > 0 THEN STRING(TRUNCATE(((deci(wdetail.premt72)  * 100 ) / 107.43),0)) ELSE "" 
                       wdetail.comment  = wdetail.comment + "/" + nv_chkerror 
                       wdetail.pass     = "N".
            END.
            ELSE DO:
                ASSIGN wdetail.class72 = TRIM(n_comp72) 
                       wdetail.premt72 = IF deci(wdetail.premt72) > 0 THEN STRING(TRUNCATE(((deci(wdetail.premt72)  * 100 ) / 107.43),0)) ELSE "" .
            END.
        END.
        ELSE DO:*/
            nv_compremt = IF deci(wdetail.premt72) > 0 THEN TRUNCATE(((deci(wdetail.premt72)  * 100 ) / 107.43),0) ELSE 0 .

            FIND FIRST sicsyac.xmm106 WHERE 
            sicsyac.xmm106.tariff  = "9"      AND
            sicsyac.xmm106.bencod  = "comp"   AND
            index(sicsyac.xmm106.CLASS,"E") = 0 AND
            sicsyac.xmm106.covcod  = "t"      AND 
            sicsyac.xmm106.baseap  = nv_compremt AND 
            sicsyac.xmm106.KEY_b   = INTE(n_vehuse)     NO-LOCK NO-ERROR.
            IF AVAIL sicsyac.xmm106 THEN DO:  
                ASSIGN wdetail.class72 = sicsyac.xmm106.class
                       wdetail.premt72 = IF deci(wdetail.premt72) > 0 THEN STRING(TRUNCATE(((deci(wdetail.premt72)  * 100 ) / 107.43),0)) ELSE "" .
            END.
            ELSE DO:
                FIND FIRST sicsyac.xmm106 WHERE 
                sicsyac.xmm106.tariff  = "9"      AND
                sicsyac.xmm106.bencod  = "comp"   AND
                index(sicsyac.xmm106.CLASS,"E") = 0 AND 
                sicsyac.xmm106.covcod  = "t"      AND 
                sicsyac.xmm106.baseap  = nv_compremt   NO-LOCK NO-ERROR.
                IF AVAIL sicsyac.xmm106 THEN DO:  
                    ASSIGN wdetail.class72 = sicsyac.xmm106.class
                           wdetail.premt72 = IF deci(wdetail.premt72) > 0 THEN STRING(TRUNCATE(((deci(wdetail.premt72)  * 100 ) / 107.43),0)) ELSE "" .
                END.
                ELSE DO:
                     ASSIGN wdetail.comment  = wdetail.comment + "/ไม่พบ Class พรบ.เบี้ย :" + STRING(nv_compremt) + " และ Veh. Use" + n_vehuse + "ที่(sicsyac.xmm106)" . 
                            wdetail.pass     = "N".
                END.
            END.
        /*END.*/
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkpolexp C-Win 
PROCEDURE proc_chkpolexp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_caryr AS INTE.
DEF VAR n_premt  AS DECI.

IF NOT CONNECTED("sic_exp") THEN RUN proc_sic_exp2.

FOR EACH wdetail WHERE wdetail.chasno <> ""  AND wdetail.pass <> "N"   .
    ASSIGN fi_process = "Check Data Chassic: " + wdetail.chasno + " on Expiry..." .
    DISP fi_process WITH FRAME fr_main.
    
    IF CONNECTED("sic_exp") THEN DO:
        ASSIGN re_branch    = ""  
               re_agent     = ""
               re_producer  = ""
               re_delercode = ""
               re_fincode   = ""
               re_payercod  = ""
               re_vatcode   = ""
               re_name2     = ""
               re_name3     = ""
               re_firstdat  = ""
               re_comdat    = ""
               re_expdat    = ""  
               re_class     = ""  
               re_moddes    = ""  
               re_yrmanu    = ""  
               re_covcod    = ""  
               re_garage    = ""
               re_vehuse    = "" 
               re_vehreg    = ""  
               re_cha_no    = "" 
               re_eng_no    = ""
               re_colors    = ""
               re_insp      = ""
               re_si        = ""  
               re_premt     = 0  
               re_acctxt    = ""  
               re_adj       = ""  
               re_loss      = ""  
               re_promo     = ""  
               re_product   = ""  
               re_campno    = ""  
               re_comment   = "" 
               nv_caryr     = 0 
               n_premt      = 0 .
        
        ASSIGN fi_process = "Import data From Expiry " + wdetail.chasno + "...." .
        DISP fi_process WITH FRAM fr_main.
        
        RUN wgw\wgwchktib(INPUT-OUTPUT  wdetail.prepol,    
                         INPUT-OUTPUT  re_branch  ,     
                         INPUT-OUTPUT  re_agent      ,                      
                         INPUT-OUTPUT  re_producer   ,                      
                         INPUT-OUTPUT  re_delercode,                        
                         INPUT-OUTPUT  re_fincode    ,                      
                         INPUT-OUTPUT  re_payercod   ,                      
                         INPUT-OUTPUT  re_vatcode    ,   
                         INPUT-OUTPUT  re_name2,                            
                         INPUT-OUTPUT  re_name3,     
                         INPUT-OUTPUT  re_firstdat ,   
                         INPUT-OUTPUT  re_comdat,                           
                         INPUT-OUTPUT  re_expdat,                           
                         INPUT-OUTPUT  re_class,       
                         INPUT-OUTPUT  re_moddes,                           
                         INPUT-OUTPUT  re_yrmanu, 
                         INPUT-OUTPUT  re_covcod,                           
                         INPUT-OUTPUT  re_garage, 
                         INPUT-OUTPUT  re_vehuse,
                         INPUT-OUTPUT  re_vehreg,                           
                         INPUT-OUTPUT  wdetail.chasno, 
                         INPUT-OUTPUT  re_eng_no ,
                         INPUT-OUTPUT  re_insp   ,
                         INPUT-OUTPUT  re_colors ,
                         INPUT-OUTPUT  re_si,
                         INPUT-OUTPUT  re_premt,
                         INPUT-OUTPUT  re_acctxt,
                         INPUT-OUTPUT  re_adj,
                         INPUT-OUTPUT  re_loss,
                         input-output  re_promo , 
                         input-output  re_product,
                         INPUT-OUTPUT  re_campno , 
                         INPUT-OUTPUT  re_comment). 
        
            IF re_comment <> ""   THEN DO: 
                ASSIGN wdetail.pass    = "N"
                       wdetail.comment = wdetail.comment + "/" + re_comment .
            END. 
            ELSE DO:
                 ASSIGN fi_process = "Check Data Chassic: " + wdetail.chasno + " From File and Expiry....." .
                 DISP fi_process WITH FRAME fr_main.
                
                ASSIGN nv_caryr      = INTE((YEAR(date(re_comdat)) - INTE(re_yrmanu)) + 1 )
                       wdetail.polyr = IF INTE(nv_caryr) > 2 THEN "OTHER" ELSE "FIRST" .  
        
                IF re_adj   = "NO" THEN ASSIGN wdetail.comment = wdetail.comment + "/ยังไม่มีการปรับใบเตือน Adj = NO " .
                IF DATE(wdetail.senddate) > DATE(re_comdat) THEN DO:
                    ASSIGN  wdetail.pass    = "N"
                            wdetail.comment = wdetail.comment + "/กรมธรรม์ " + wdetail.prepol + " ขาดต่ออายุ(Exp.date : " + re_comdat + ")" .
                END.
                ELSE DO:
                    IF date(wdetail.comdat) <>  date(re_comdat)  THEN DO:
                        ASSIGN  wdetail.pass    = "N"
                                wdetail.comment = wdetail.comment + "/วันที่คุ้มครองในไฟล์ไม่ตรงกับใบเตือน (" + wdetail.comdat + " : " + re_comdat + ")" .
                    END.
                    IF DATE(wdetail.expdat) <>  DATE(re_expdat)  THEN DO: 
                        ASSIGN  wdetail.pass    = "N"
                                wdetail.comment = wdetail.comment + "/วันที่หมดอายุในไฟล์ไม่ตรงกับใบเตือน (" + wdetail.expdat + " : " + re_expdat  + ")" .
                    END.
                END.
               
                IF re_premt <> deci(wdetail.premt)  THEN DO:

                    ASSIGN n_premt = 0
                           n_premt = re_premt - DECI(wdetail.premt) .

                    IF n_premt = 1 OR n_premt = (-1)  THEN ASSIGN wdetail.premt = STRING(re_premt) .
                    ELSE DO:
                        ASSIGN  wdetail.pass    = "N"
                                wdetail.comment = wdetail.comment + "/เบี้ยใบเตือน " + string(re_premt,">>>>>>>9.99-") + " ไม่เท่ากับไฟล์ " + wdetail.premt.
                    END.
                END.
                IF deci(wdetail.si) <> 0 AND deci(wdetail.si) <> deci(re_si) THEN DO: 
                    ASSIGN wdetail.pass    = "N"
                           wdetail.comment = wdetail.comment + "/ทุนประกันในไฟล์และใบเตือนไม่เท่ากัน " .
                END.
                IF wdetail.covcod <> "" AND wdetail.covcod <> re_covcod THEN DO: 
                    ASSIGN wdetail.pass    = "N"
                           wdetail.comment = wdetail.comment + "/ความคุ้มครองในไฟล์และใบเตือนไม่เท่ากัน " .
                END.
        
                IF wdetail.polyr = "OTHER" THEN DO: /* chk claim */
                  IF deci(wdetail.loss) <> DECI(re_loss)   THEN DO: 
                      IF trim(re_covcod) = "1" THEN DO:
                          IF  DECI(wdetail.loss) > 65 THEN DO:
                            ASSIGN  wdetail.pass    = "N"
                                    wdetail.comment = wdetail.comment + "/" + " Loss ที่ใบเตือน :" + re_loss + " ไม่เท่ากับระบบเคลม : " + wdetail.loss .
                          END.
                      END.
                      ELSE DO:
                          ASSIGN  wdetail.pass    = "N"
                                  wdetail.comment = wdetail.comment + "/" + " Loss ที่ใบเตือน :" + re_loss + " ไม่เท่ากับระบบเคลม : " + wdetail.loss .
                      END.
                  END.
                END.
                ELSE DO:
                    IF  index(re_class,"320") <> 0  AND (DECI(wdetail.loss) <> DECI(re_loss))   THEN DO: 
                        IF trim(re_covcod) = "1" THEN DO:
                          IF  DECI(wdetail.loss) > 65 THEN DO:
                            ASSIGN  wdetail.pass    = "N"
                                    wdetail.comment = wdetail.comment + "/" + " Loss ที่ใบเตือน :" + re_loss + " ไม่เท่ากับระบบเคลม : " + wdetail.loss .
                          END.
                        END.
                        ELSE DO: 
                            ASSIGN  wdetail.pass    = "N"
                                    wdetail.comment = wdetail.comment + "/" + " Loss ที่ใบเตือน :" + re_loss + " ไม่เท่ากับระบบเคลม : " + wdetail.loss .
                        END.
                    END.
                    IF  index(re_class,"120") <> 0 AND (DECI(wdetail.loss) <> DECI(re_loss) )  THEN DO: 
                        IF trim(re_covcod) = "1" THEN DO:
                          IF  DECI(wdetail.loss) > 65 THEN DO:
                            ASSIGN  wdetail.pass    = "N"
                                    wdetail.comment = wdetail.comment + "/" + " Loss ที่ใบเตือน :" + re_loss + " ไม่เท่ากับระบบเคลม : " + wdetail.loss .
                          END.
                        END.
                        ELSE DO: 
                            ASSIGN  wdetail.pass    = "N"
                                    wdetail.comment = wdetail.comment + "/" + " Loss ที่ใบเตือน :" + re_loss + " ไม่เท่ากับระบบเคลม : " + wdetail.loss .
                        END.
                    END.
                END.
        
                IF wdetail.polyr = "FIRST" THEN DO:
                    ASSIGN wdetail.n_branch     =  trim(re_branch)            
                           wdetail.agent        =  "B3MF101860"
                           wdetail.producer     =  "B3MF101860"
                           wdetail.n_delercode  =  trim(re_delercode)         
                           wdetail.fincode      =  "FTIB"         
                           wdetail.comdat       =  trim(re_comdat)        
                           wdetail.expdat       =  trim(re_expdat)        
                           wdetail.packcod      =  ""               
                           wdetail.product      =  ""
                           wdetail.brand        =  IF INDEX(re_moddes," ") <> 0 THEN trim(SUBSTR(re_moddes,1,INDEX(re_moddes," "))) ELSE trim(re_moddes)                                         
                           wdetail.model        =  IF INDEX(re_moddes," ") <> 0 THEN trim(SUBSTR(re_moddes,INDEX(re_moddes," "))) ELSE ""                                                  
                           wdetail.yrmanu       =  trim(re_yrmanu)
                           wdetail.colorcar     =  trim(re_colors)
                           wdetail.engno        =  trim(re_eng_no)
                           wdetail.class70      =  TRIM(re_class)
                           wdetail.vehuse       =  trim(re_vehuse)
                           wdetail.promo        =  IF index(re_promo,"NON PHYD") <> 0 THEN "" ELSE re_promo .
                           
                    IF index(wdetail.brand,"TOYOTA") <> 0 THEN DO:
                        IF      wdetail.instyp = "PR" AND index(re_promo,"NON PHYD") <> 0  THEN ASSIGN wdetail.camp_no = "Z1ID" .
                        ELSE IF wdetail.instyp = "CO" AND index(re_promo,"NON PHYD") <> 0  THEN ASSIGN wdetail.camp_no = "Z2ID" . 
                        ELSE IF wdetail.instyp = "PR" AND index(re_promo,"PHYD")     <> 0  THEN ASSIGN wdetail.camp_no = "Z1IDP" .
                        ELSE IF wdetail.instyp = "CO" AND index(re_promo,"PHYD")     <> 0  THEN ASSIGN wdetail.camp_no = "Z2IDP" .
                        ELSE IF wdetail.instyp = "PR" AND trim(re_promo) = ""              THEN ASSIGN wdetail.camp_no = "Z1ID" . 
                        ELSE IF wdetail.instyp = "CO" AND trim(re_promo) = ""              THEN ASSIGN wdetail.camp_no = "Z2ID" . 
                    END.
                    ELSE DO:
                        ASSIGN wdetail.camp_no = "RNSR01" .
                    END.
        
                    IF re_garage = ""  THEN ASSIGN wdetail.campen = "" .
                    ELSE DO:
                        IF      index(re_promo,"NON PHYD") <> 0 AND index(wdetail.brand,"TOYOTA") <> 0 THEN ASSIGN wdetail.campen = "TCARE" .
                        ELSE IF index(re_promo,"NON PHYD") <> 0 AND index(wdetail.brand,"TOYOTA") = 0  THEN ASSIGN wdetail.campen = "" .
                        ELSE IF index(re_promo,"PHYD")     <> 0 THEN ASSIGN wdetail.campen = "TCARE PHYD" .
                        ELSE IF re_promo = "" AND index(wdetail.brand,"TOYOTA") <> 0  THEN  ASSIGN wdetail.campen = "TCARE" .
                        ELSE IF re_promo = "" AND index(wdetail.brand,"TOYOTA") = 0   THEN  ASSIGN wdetail.campen = "" .
                    END.
                END. /* end First */
                ELSE DO:
                  ASSIGN wdetail.n_branch     =  re_branch                
                         wdetail.agent        =  re_agent           
                         wdetail.producer     =  re_producer        
                         wdetail.n_delercode  =  re_delercode             
                         wdetail.fincode      =  "FTIB"     
                         wdetail.comdat       =  re_comdat        
                         wdetail.expdat       =  re_expdat        
                         wdetail.packcod      =  ""               
                         wdetail.product      =  "" 
                         wdetail.brand        =  IF INDEX(re_moddes," ") <> 0 THEN trim(SUBSTR(re_moddes,1,INDEX(re_moddes," "))) ELSE trim(re_moddes)                                         
                         wdetail.model        =  IF INDEX(re_moddes," ") <> 0 THEN trim(SUBSTR(re_moddes,INDEX(re_moddes," "))) ELSE ""                                                  
                         wdetail.yrmanu       =  trim(re_yrmanu)
                         wdetail.colorcar     =  trim(re_colors)
                         wdetail.engno        =  trim(re_eng_no)
                         wdetail.class70      =  TRIM(re_class)
                         wdetail.vehuse       =  trim(re_vehuse)
                         wdetail.promo        =  IF index(re_promo,"NON PHYD") <> 0 THEN "" 
                                                 ELSE IF nv_caryr > 8 THEN "" ELSE  re_promo .
                    IF wdetail.brand = "TOYOTA" THEN DO:
                        ASSIGN wdetail.camp_no = re_campno . 
                    END.
                    ELSE DO:
                        ASSIGN wdetail.camp_no = "RENEW" .
                    END.
        
                    IF re_garage = ""  THEN ASSIGN wdetail.campen = "" .
                    ELSE DO:
                        IF      index(re_promo,"NON PHYD") <> 0 AND wdetail.brand  = "TOYOTA" AND nv_caryr <= 8  THEN ASSIGN wdetail.campen = "TCARE" .
                        ELSE IF index(re_promo,"NON PHYD") <> 0 AND wdetail.brand <> "TOYOTA" AND nv_caryr <= 8  THEN ASSIGN wdetail.campen = "" .
                        ELSE IF index(re_promo,"PHYD") <> 0 AND nv_caryr <= 8  THEN ASSIGN wdetail.campen = "TCARE PHYD" .
                        ELSE IF re_promo = "" AND index(wdetail.brand,"TOYOTA") <> 0  AND nv_caryr <= 8 THEN  ASSIGN wdetail.campen = "TCARE" .
                        ELSE ASSIGN wdetail.campen = "" .
                    END.
                END. /* end other */
            END. /* comment = "" */
    END. /* connect sic_exp */
    IF wdetail.memo1 <> "" AND INDEX(wdetail.memo1,"คุณวันวิสา") <> 0 THEN DO:
      IF TRIM(wdetail.n_delercode) = "TT11CC1" THEN DO:
           ASSIGN wdetail2.titlenamepay  = "บริษัท" 
                   wdetail2.namepay       = "โตโยต้าฉะเชิงเทราผู้จำหน่ายโตโยต้า จำกัด " 
                   wdetail2.lastnamepay   = "" 
                   wdetail2.addpay1       = "98 ถนนศุขประยูร" 
                   wdetail2.addpay2       = "ต.หน้าเมือง " 
                   wdetail2.addpay3       = "อ.เมือง" 
                   wdetail2.addpay4       = "จ.ฉะเชิงเทรา" 
                   wdetail2.postpay       = "24000" .
      END.
      IF TRIM(wdetail.n_delercode) = "TT11ONE1" THEN DO:
           ASSIGN wdetail2.titlenamepay  = "บริษัท" 
                   wdetail2.namepay       = "โตโยต้าวัน จำกัด" 
                   wdetail2.lastnamepay   = "" 
                   wdetail2.addpay1       = "176 หมู่ที่ 13 ถนนบางนา-ตราด" 
                   wdetail2.addpay2       = "ต.บางปะกง" 
                   wdetail2.addpay3       = "อ.บางปะกง" 
                   wdetail2.addpay4       = "จ.ฉะเชิงเทรา" 
                   wdetail2.postpay       = "24130" .
      END.
    END.
END.
RELEASE wdetail.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkpolpremium C-Win 
PROCEDURE proc_chkpolpremium :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:   add by : A67-0185    
------------------------------------------------------------------------------*/
def var nv_chasno  as char  format "x(50)" init "" .
def var nv_poltyp  as char  format "x(50)" init "" .
def var nv_vehreg  as char  format "x(50)" init "" .
def var nv_chassic as char  format "x(50)" init "" .
def var nv_typpol  as char  format "x(50)" init "" .
def var nv_comdat  as date   init "" .
def var nv_expdat  as date   init "" .
def var nv_comdat72  as date   init "" .
def var nv_expdat72  as date   init "" .

FOR EACH wdetail .
    ASSIGN fi_process = "Check Data Chassic: " + wdetail.chasno + " on Premium..." .
    DISP fi_process WITH FRAME fr_main.
 ASSIGN nv_chasno   = ""
        nv_comdat   = ?
        nv_expdat   = ?
        nv_comdat72 = ?
        nv_expdat72 = ?
        nv_vehreg   = "" /*A65-0079*/
        nv_chasno   = trim(wdetail.chasno)
        nv_comdat   = DATE(wdetail.comdat)
        nv_expdat   = DATE(wdetail.expdat)
        nv_comdat72 = DATE(wdetail.comdat72) 
        nv_expdat72 = DATE(wdetail.expdat72) 
        /*nv_vehreg   = IF INDEX(wdetail.vehreg,"-") <> 0 THEN REPLACE(wdetail.vehreg,"-"," ") + " " + trim(wdetail.re_country)  
                      ELSE trim(wdetail.vehreg) + " " + trim(wdetail.re_country) /*A65-0079*/*/ .
    
  IF deci(wdetail.premt) <> 0 AND (nv_comdat = ? OR nv_expdat = ? ) THEN DO:
      ASSIGN wdetail.comment = wdetail.comment + "/วันที่คุ้มครองหรือวันที่หมดอายุของ กธ.ในไฟล์เป็นค่าว่าง " .   
                               wdetail.pass    = "N". 
  END.
  IF DECI(wdetail.premt72) <> 0 AND (nv_comdat72 = ? OR nv_expdat72 = ? ) THEN DO:  
     ASSIGN wdetail.comment = wdetail.comment + "/วันที่คุ้มครองหรือวันที่หมดอายุของ พรบ.ในไฟล์เป็นค่าว่าง " .   
                              wdetail.pass    = "N".                                  
  END.
  IF nv_chasno <> ""   THEN DO:
     FIND LAST sicuw.uwm301 Where sicuw.uwm301.cha_no = trim(nv_chasno) No-lock no-error no-wait.
     If avail sicuw.uwm301 Then DO:
         FOR EACH  sicuw.uwm301 Where sicuw.uwm301.cha_no = trim(nv_chasno) NO-LOCK:
           /* chk 70 */
           IF deci(wdetail.premt) <> 0  THEN DO:
             Find LAST sicuw.uwm100 Use-index uwm10001       Where
                 sicuw.uwm100.policy = sicuw.uwm301.policy   and
                 sicuw.uwm100.rencnt = sicuw.uwm301.rencnt   and
                 /*sicuw.uwm100.endcnt = sicuw.uwm301.endcnt   AND*/
                 sicuw.uwm100.poltyp  = "V70"    AND 
                 sicuw.uwm100.polsta  = "IF"     No-lock no-error no-wait.
             If avail sicuw.uwm100 Then DO:
                 IF DATE(sicuw.uwm100.expdat) > date(nv_comdat) AND 
                    YEAR(sicuw.uwm100.expdat) = YEAR(nv_expdat) AND  
                    sicuw.uwm100.polsta    = "IF" THEN DO:
                    ASSIGN wdetail.comment = wdetail.comment + "/เลขตัวถังมีกรมธรรม์ในระบบแล้ว " + uwm100.policy      
                           wdetail.pass    = "N". 
                 END.
                 ELSE IF DATE(sicuw.uwm100.expdat) > date(nv_comdat)   AND 
                         YEAR(sicuw.uwm100.expdat) <> YEAR(nv_expdat)  AND 
                         MONTH(sicuw.uwm100.expdat) - MONTH(TODAY) > 0 AND
                         sicuw.uwm100.polsta    = "IF" THEN DO:
                     ASSIGN wdetail.comment = wdetail.comment + "/เลขตัวถังมีกรมธรรม์ในระบบแล้ว " + uwm100.policy      
                            wdetail.pass    = "N". 
                 END.
                 ELSE DO: 
                     RUN proc_chkclaim.
                     ASSIGN wdetail.prepol  = sicuw.uwm100.policy 
                            wdetail.comment = ""      
                            wdetail.pass    = "" .
                 END.
             END.
             /*ELSE DO:
                 ASSIGN wdetail.comment = wdetail.comment + "/ไม่พบข้อมูลเลขตัวถัง " + nv_chasno + " ในระบบพรีเมียม ." .      
                        wdetail.pass    = "N". 
             END.*/
           END.
           
           IF DECI(wdetail.premt72) <> 0  THEN DO:
                Find LAST sicuw.uwm100 Use-index uwm10001       Where
                    sicuw.uwm100.policy = sicuw.uwm301.policy   and
                    sicuw.uwm100.rencnt = sicuw.uwm301.rencnt   and 
                    /*sicuw.uwm100.endcnt = sicuw.uwm301.endcnt   AND*/
                    sicuw.uwm100.poltyp = "V72"  No-lock no-error no-wait.
                If avail sicuw.uwm100 Then DO:
                    IF DATE(sicuw.uwm100.expdat) > date(nv_comdat72) AND 
                       YEAR(sicuw.uwm100.expdat) = YEAR(nv_expdat72) AND  
                       sicuw.uwm100.polsta    = "IF" THEN DO:
                       ASSIGN wdetail.comment = wdetail.comment + "/เลขตัวถังมี พรบ.ในระบบแล้ว " + uwm100.policy  
                              wdetail.comdat72 = ""  
                              wdetail.expdat72 = ""  
                              wdetail.barcode  = "" 
                              wdetail.premt72  = ""  
                              wdetail.compul   = "N" .  
                    END.
                    ELSE IF DATE(sicuw.uwm100.expdat) > date(nv_comdat72)  AND 
                            YEAR(sicuw.uwm100.expdat) <> YEAR(nv_expdat72) AND 
                            MONTH(sicuw.uwm100.expdat) - MONTH(TODAY) > 0 AND
                            sicuw.uwm100.polsta    = "IF" THEN DO:
                        ASSIGN wdetail.comment = wdetail.comment + "/เลขตัวถังมี พรบ. ในระบบแล้ว " + uwm100.policy  
                               wdetail.comdat72 = ""  
                               wdetail.expdat72 = ""  
                               wdetail.barcode  = "" 
                               wdetail.premt72  = ""
                               wdetail.compul   = "N"   .
                    END.
                    ELSE DO:
                        IF  wdetail.pass  <>  "N"  AND wdetail.barcode <> ""  THEN DO:
                            FIND LAST brstat.tlt USE-INDEX tlt06   WHERE   
                                      brstat.tlt.safe2  = trim(wdetail.barcode)  NO-ERROR NO-WAIT .
                             IF AVAIL brstat.tlt THEN ASSIGN wdetail.barcode = TRIM(brstat.tlt.cha_no) .
                        END.
                    END.
                END.
                ELSE DO:
                    IF wdetail.pass  <>  "N" AND wdetail.barcode <> ""  THEN DO:
                        FIND LAST brstat.tlt USE-INDEX tlt06   WHERE   
                                  brstat.tlt.safe2  = trim(wdetail.barcode)  NO-ERROR NO-WAIT .
                         IF AVAIL brstat.tlt THEN ASSIGN wdetail.barcode = TRIM(brstat.tlt.cha_no) .
                    END.
                END.
           END. /* end 72*/
       END.  /*FOR EACH  sicuw.uwm301 */
     END.   /*avil 301*/
     ELSE DO:
        ASSIGN wdetail.comment = wdetail.comment + "/ไม่พบข้อมูลเลขตัวถัง " + nv_chasno + " ในระบบพรีเมียม ." .      
               wdetail.pass    = "N". 
     END.
     RELEASE sicuw.uwm301.
     RELEASE sicuw.uwm100.
  END.
END.
RELEASE wdetail.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkprovince C-Win 
PROCEDURE proc_chkprovince :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_yr AS INTE .
DO:
  ASSIGN fi_process = "Check Province : " + wdetail2.chasno + "...." .
  DISP fi_process WITH FRAME fr_main.  
  nv_yr = 0 .
  IF trim(wdetail2.reg1) = "" AND trim(wdetail2.reg2) = "" THEN DO:
     ASSIGN nv_yr =  YEAR(TODAY) - INTE(wdetail2.caryear) .
     IF nv_yr <= 1 THEN DO:
       IF LENGTH(wdetail2.chasno) < 9  THEN DO:
            ASSIGN wdetail2.reg1      = "/" + TRIM(wdetail2.chasno) 
                   wdetail2.provinco  = "" .
       END.
       ELSE ASSIGN wdetail2.reg1      = "/" + SUBSTRING(wdetail2.chasno,LENGTH(wdetail2.chasno) - 8)      
                   wdetail2.provinco  = "" .
     END.
  END.
  ELSE DO:
    if      wdetail2.provinco = "01" then wdetail2.provinco = "กรุงเทพมหานคร".
    else if wdetail2.provinco = "02" then wdetail2.provinco = "นนทบุรี " . 
    else if wdetail2.provinco = "03" then wdetail2.provinco = "สมุทรปราการ" . 
    else if wdetail2.provinco = "04" then wdetail2.provinco = "อุบลราชธานี" . 
    else if wdetail2.provinco = "05" then wdetail2.provinco = "ชลบุรี" . 
    else if wdetail2.provinco = "06" then wdetail2.provinco = "ปทุมธานี" . 
    else if wdetail2.provinco = "07" then wdetail2.provinco = "สมุทรสาคร". 
    else if wdetail2.provinco = "08" then wdetail2.provinco = "นครปฐม" .  
    else if wdetail2.provinco = "09" then wdetail2.provinco = "สงขลา " .  
    else if wdetail2.provinco = "10" then wdetail2.provinco = "ราชบุรี".  
    else if wdetail2.provinco = "11" then wdetail2.provinco = "ฉะเชิงเทรา". 
    else if wdetail2.provinco = "12" then wdetail2.provinco = "พัทลุง  "  . 
    else if wdetail2.provinco = "13" then wdetail2.provinco = "ปราจีนบุรี".   
    else if wdetail2.provinco = "14" then wdetail2.provinco = "ตรัง "  .   
    else if wdetail2.provinco = "15" then wdetail2.provinco = "ขอนแก่น ".   
    else if wdetail2.provinco = "16" then wdetail2.provinco = "ระยอง" .   
    else if wdetail2.provinco = "17" then wdetail2.provinco = "ยโสธร" .   
    else if wdetail2.provinco = "18" then wdetail2.provinco = "ศรีสะเกษ".   
    else if wdetail2.provinco = "19" then wdetail2.provinco = "นราธิวาส".   
    else if wdetail2.provinco = "20" then wdetail2.provinco = "ยะลา"   .   
    else if wdetail2.provinco = "21" then wdetail2.provinco = "ปัตตานี".   
    else if wdetail2.provinco = "22" then wdetail2.provinco = "สุพรรณบุรี".   
    else if wdetail2.provinco = "23" then wdetail2.provinco = "มุกดาหาร" .   
    else if wdetail2.provinco = "24" then wdetail2.provinco = "เพชรบุรี" .   
    else if wdetail2.provinco = "25" then wdetail2.provinco = "กาญจนบุรี".   
    else if wdetail2.provinco = "26" then wdetail2.provinco = "ประจวบคีรีขันธ์".
    else if wdetail2.provinco = "27" then wdetail2.provinco = "สตูล"    . 
    else if wdetail2.provinco = "28" then wdetail2.provinco = "อุดรธานี". 
    else if wdetail2.provinco = "29" then wdetail2.provinco = "สกลนคร"  . 
    else if wdetail2.provinco = "30" then wdetail2.provinco = "นครพนม"  . 
    else if wdetail2.provinco = "31" then wdetail2.provinco = "สมุทรสงคราม ". 
    else if wdetail2.provinco = "32" then wdetail2.provinco = "มหาสารคาม". 
    else if wdetail2.provinco = "33" then wdetail2.provinco = "สุราษฎร์ธานี". 
    else if wdetail2.provinco = "34" then wdetail2.provinco = "สุรินทร์" . 
    else if wdetail2.provinco = "35" then wdetail2.provinco = "ร้อยเอ็ด" . 
    else if wdetail2.provinco = "36" then wdetail2.provinco = "หนองคาย " . 
    else if wdetail2.provinco = "37" then wdetail2.provinco = "จันทบุรี" . 
    else if wdetail2.provinco = "38" then wdetail2.provinco = "นครศรีธรรมราช" .
    else if wdetail2.provinco = "39" then wdetail2.provinco = "หนองบัวลำภู". 
    else if wdetail2.provinco = "40" then wdetail2.provinco = "กาฬสินธุ์" .  
    else if wdetail2.provinco = "41" then wdetail2.provinco = "ลำพูน "    .  
    else if wdetail2.provinco = "42" then wdetail2.provinco = "นครราชสีมา".  
    else if wdetail2.provinco = "43" then wdetail2.provinco = "เลย"   . 
    else if wdetail2.provinco = "44" then wdetail2.provinco = "ชัยนาท". 
    else if wdetail2.provinco = "45" then wdetail2.provinco = "อุทัยธานี". 
    else if wdetail2.provinco = "46" then wdetail2.provinco = "ชัยภูมิ"  . 
    else if wdetail2.provinco = "47" then wdetail2.provinco = "บุรีรัมย์". 
    else if wdetail2.provinco = "48" then wdetail2.provinco = "สุโขทัย" . 
    else if wdetail2.provinco = "49" then wdetail2.provinco = "ตราด" . 
    else if wdetail2.provinco = "50" then wdetail2.provinco = "นครนายก" . 
    else if wdetail2.provinco = "51" then wdetail2.provinco = "สิงห์บุรี". 
    else if wdetail2.provinco = "52" then wdetail2.provinco = "สระบุรี"  . 
    else if wdetail2.provinco = "53" then wdetail2.provinco = "นครสวรรค์". 
    else if wdetail2.provinco = "54" then wdetail2.provinco = "พิษณุโลก ". 
    else if wdetail2.provinco = "55" then wdetail2.provinco = "พระนครศรีอยุธยา".
    else if wdetail2.provinco = "56" then wdetail2.provinco = "อ่างทอง".  
    else if wdetail2.provinco = "57" then wdetail2.provinco = "สระแก้ว".  
    else if wdetail2.provinco = "58" then wdetail2.provinco = "ลพบุรี" .  
    else if wdetail2.provinco = "59" then wdetail2.provinco = "อุตรดิตถ์" .  
    else if wdetail2.provinco = "60" then wdetail2.provinco = "พิจิตร" .  
    else if wdetail2.provinco = "61" then wdetail2.provinco = "ลำปาง".  
    else if wdetail2.provinco = "62" then wdetail2.provinco = "ตาก"  .  
    else if wdetail2.provinco = "63" then wdetail2.provinco = "พังงา".  
    else if wdetail2.provinco = "64" then wdetail2.provinco = "ชุมพร".  
    else if wdetail2.provinco = "65" then wdetail2.provinco = "กระบี่" .  
    else if wdetail2.provinco = "66" then wdetail2.provinco = "ภูเก็ต" .  
    else if wdetail2.provinco = "67" then wdetail2.provinco = "ระนอง"  .  
    else if wdetail2.provinco = "68" then wdetail2.provinco = "กำแพงเพชร" .  
    else if wdetail2.provinco = "69" then wdetail2.provinco = "อำนาจเจริญ".  
    else if wdetail2.provinco = "70" then wdetail2.provinco = "เพชรบูรณ์" .  
    else if wdetail2.provinco = "71" then wdetail2.provinco = "แพร่" .  
    else if wdetail2.provinco = "72" then wdetail2.provinco = "น่าน" .  
    else if wdetail2.provinco = "73" then wdetail2.provinco = "เชียงราย".  
    else if wdetail2.provinco = "74" then wdetail2.provinco = "พะเยา".  
    else if wdetail2.provinco = "75" then wdetail2.provinco = "เชียงใหม่" .  
    else if wdetail2.provinco = "76" then wdetail2.provinco = "แม่ฮ่องสอน".  
    else if wdetail2.provinco = "77" then wdetail2.provinco = "บึงกาฬ" .  
    else if wdetail2.provinco = "78" then wdetail2.provinco = "เบตง" .
    
    IF TRIM(wdetail2.provinco) <> "" THEN DO:
       FIND FIRST brstat.insure USE-INDEX Insure03   WHERE 
            brstat.insure.compno = "999"    AND 
            brstat.insure.fname  = trim(wdetail2.provinco)  NO-LOCK NO-WAIT NO-ERROR.
        IF AVAIL brstat.insure THEN DO:
            ASSIGN wdetail2.provinco = trim(Insure.LName).
        END.
    END.
  END.

END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktxt C-Win 
PROCEDURE proc_chktxt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_acctxt AS CHAR FORMAT "x(70)" INIT "" .
DEF VAR nv_count AS INTE INIT 0.
DEF VAR nv_acces AS CHAR FORMAT "x(250)" INIT "" .
DEF VAR nv_chkint AS CHAR FORMAT "x(10)" INIT "" .
DEF VAR nv_send  AS CHAR INIT "" .

ASSIGN fi_process = "Check Data Text :" + wdetail2.chasno + "...." .
DISP fi_process WITH FRAME fr_main.

ASSIGN 
   nv_txt  = ""   
   nv_txt1 = ""        nv_txt6 = ""        nv_txt11 = ""    nv_txt16 = ""      
   nv_txt2 = ""        nv_txt7 = ""        nv_txt12 = ""    nv_txt17 = ""      
   nv_txt3 = ""        nv_txt8 = ""        nv_txt13 = ""    nv_txt18 = ""      
   nv_txt4 = ""        nv_txt9 = ""        nv_txt14 = ""    nv_txt19 = ""      
   nv_txt5 = ""        nv_txt10 = ""       nv_txt15 = ""    nv_txt20 = ""
   nv_acces = ""       nv_chkint = ""      nv_send = "" .    

IF trim(wdetail2.notifyno) <> ""  THEN DO:
    ASSIGN wdetail2.notifyno = TRIM(wdetail2.notifyno) .
    IF LENGTH(wdetail2.notifyno) <= 100  THEN DO:
        ASSIGN nv_txt1 =  TRIM(wdetail2.notifyno) .
    END.
    ELSE DO:
        ASSIGN nv_txt = TRIM(wdetail2.notifyno) .
        nv_count = 1 .
        loop_chk1: 
        REPEAT:
            IF nv_count <= 20 THEN DO:
        
              IF (INDEX(nv_txt,"/") <> 0 ) THEN 
                  ASSIGN  n_acctxt = TRIM(SUBSTR(nv_txt,1,INDEX(nv_txt,"/")))
                  nv_txt = TRIM(SUBSTR(nv_txt,INDEX(nv_txt,"/") + 1)).
              ELSE ASSIGN  n_acctxt = TRIM(nv_txt)
                  nv_txt = "".
        
              IF nv_count =  1  THEN assign  nv_txt1 =  trim(n_acctxt) .
              if nv_count =  2  THEN assign  nv_txt2 =  trim(n_acctxt) .
              if nv_count =  3  THEN assign  nv_txt3 =  trim(n_acctxt) .
              if nv_count =  4  THEN assign  nv_txt4 =  trim(n_acctxt) .
              if nv_count =  5  THEN assign  nv_txt5 =  trim(n_acctxt) .
              if nv_count =  6  THEN assign  nv_txt6 =  trim(n_acctxt) .
              if nv_count =  7  THEN assign  nv_txt7 =  trim(n_acctxt) .
              if nv_count =  8  THEN assign  nv_txt8 =  trim(n_acctxt) .
              if nv_count =  9  THEN assign  nv_txt9 =  trim(n_acctxt) .
              if nv_count =  10 THEN assign  nv_txt10 = trim(n_acctxt) .
              if nv_count =  11 THEN assign  nv_txt11 = trim(n_acctxt) .
              if nv_count =  12 THEN assign  nv_txt12 = trim(n_acctxt) .
              if nv_count =  13 THEN assign  nv_txt13 = trim(n_acctxt) .
              if nv_count =  14 THEN assign  nv_txt14 = trim(n_acctxt) .
              if nv_count =  15 THEN assign  nv_txt15 = trim(n_acctxt) .
              if nv_count =  16 THEN assign  nv_txt16 = trim(n_acctxt) .
              if nv_count =  17 THEN assign  nv_txt17 = trim(n_acctxt) .
              if nv_count =  18 THEN assign  nv_txt18 = trim(n_acctxt) .
              if nv_count =  19 THEN assign  nv_txt19 = trim(n_acctxt) .
              if nv_count =  20 THEN assign  nv_txt20 = trim(n_acctxt) .
        
              nv_count = nv_count + 1.
              IF nv_count > 20 THEN LEAVE loop_chk1.
            END.
        END.
        
        nv_count = 1.
        loop_chk2: 
        REPEAT:
            IF nv_count <= 20 THEN DO:
               IF (length(nv_txt1 + nv_txt2) <= 100 ) THEN DO:
                   ASSIGN  nv_txt1 = nv_txt1  +  nv_txt2
                           nv_txt2 = "" .
               END.
               ELSE IF (nv_txt1 = "") THEN DO:
                   ASSIGN nv_txt1 = nv_txt2 
                          nv_txt2 = "" .
               END.
            
               IF (length(nv_txt2 +  nv_txt3 ) <= 100 ) THEN DO:
                ASSIGN nv_txt2 = nv_txt2  +  nv_txt3
                       nv_txt3 = "" .
               END.
               ELSE IF (nv_txt2 = "") THEN DO:
                   ASSIGN nv_txt2 = nv_txt3 
                          nv_txt3 = "" .
               END.
            
               IF (length(nv_txt3 +  nv_txt4 ) <= 100 ) THEN DO:
                   ASSIGN nv_txt3 = nv_txt3  +  nv_txt4
                          nv_txt4 = "" .
               END.
               ELSE IF (nv_txt3 = "") THEN DO:
                   ASSIGN nv_txt3 = nv_txt4 
                         nv_txt4 = "" .
               END.
            
               IF (length(nv_txt4 +  nv_txt5 ) <= 100 ) THEN DO:
                   ASSIGN nv_txt4 = nv_txt4  +  nv_txt5 
                          nv_txt5 = "" .
               END.
               ELSE IF (nv_txt4 = "") THEN DO:
                   ASSIGN nv_txt4 = nv_txt5 
                          nv_txt5 = "" .
               END.
            
               IF (length(nv_txt5 +  nv_txt6 ) <= 100 ) THEN DO:
                   ASSIGN nv_txt5 = nv_txt5  +  nv_txt6
                          nv_txt6 = "" .
               END.
               ELSE IF (nv_txt5 = "") THEN  DO:
                   ASSIGN nv_txt5 = nv_txt6 
                          nv_txt6 = ""  .
               END.
            
               IF (length(nv_txt6 +  nv_txt7 ) <= 100 ) THEN DO:
                   ASSIGN nv_txt6 = nv_txt6  +  nv_txt7
                          nv_txt7 = "" .
               END.
               ELSE IF (nv_txt6 = "") THEN  DO:
                   ASSIGN nv_txt6 = nv_txt7 
                          nv_txt7 = ""  .
               END.
            
                IF (length(nv_txt7 +  nv_txt8 ) <= 100 ) THEN DO:
                   ASSIGN nv_txt7 = nv_txt7  +  nv_txt8
                          nv_txt8 = "" .
               END.
               ELSE IF (nv_txt7 = "") THEN  DO:
                   ASSIGN nv_txt7 = nv_txt8 
                          nv_txt8 = ""  .
               END.
            
                IF (length(nv_txt8 +  nv_txt9 ) <= 100 ) THEN DO:
                   ASSIGN nv_txt8 = nv_txt8  +  nv_txt9
                          nv_txt9 = "" .
               END.
               ELSE IF (nv_txt8 = "") THEN  DO:
                   ASSIGN nv_txt8 = nv_txt9 
                          nv_txt9 = ""  .
               END.
            
                IF (length(nv_txt9 +  nv_txt10 ) <= 100 ) THEN DO:
                   ASSIGN nv_txt9 = nv_txt9  +  nv_txt10
                          nv_txt10 = "" .
               END.
               ELSE IF (nv_txt9 = "") THEN  DO:
                   ASSIGN nv_txt9 = nv_txt10
                          nv_txt10 = ""  .
               END.
            
                IF (length(nv_txt10 +  nv_txt11 ) <= 100 ) THEN DO:
                   ASSIGN nv_txt10 = nv_txt10  +  nv_txt11
                          nv_txt11 = "" .
               END.
               ELSE IF (nv_txt10 = "") THEN  DO:
                   ASSIGN nv_txt10 = nv_txt11 
                          nv_txt11 = ""  .
               END.
            
                IF (length(nv_txt11 +  nv_txt12 ) <= 100 ) THEN DO:
                   ASSIGN nv_txt11 = nv_txt11  +  nv_txt12
                          nv_txt12 = "" .
               END.
               ELSE IF (nv_txt11 = "") THEN  DO:
                   ASSIGN nv_txt11 = nv_txt12 
                          nv_txt12 = ""  .
               END.
            
                IF (length(nv_txt12 +  nv_txt13 ) <= 100 ) THEN DO:
                   ASSIGN nv_txt12 = nv_txt12  +  nv_txt13
                          nv_txt13 = "" .
               END.
               ELSE IF (nv_txt12 = "") THEN  DO:
                   ASSIGN nv_txt12 = nv_txt13 
                          nv_txt13 = ""  .
               END.
            
               IF (length(nv_txt13 +  nv_txt14 ) <= 100 ) THEN DO:
                   ASSIGN nv_txt13 = nv_txt13  +  nv_txt14
                          nv_txt14 = "" .
               END.
               ELSE IF (nv_txt13 = "") THEN  DO:
                   ASSIGN nv_txt13 = nv_txt14
                          nv_txt14 = ""  .
               END.
            
               IF (length(nv_txt14 +  nv_txt15 ) <= 100 ) THEN DO:
                   ASSIGN nv_txt14 = nv_txt14  +  nv_txt15
                          nv_txt15 = "" .
               END.
               ELSE IF (nv_txt14 = "") THEN  DO:
                   ASSIGN nv_txt14 = nv_txt15 
                          nv_txt15 = ""  .
               END.
            
                IF (length(nv_txt15 +  nv_txt16 ) <= 100 ) THEN DO:
                   ASSIGN nv_txt15 = nv_txt15  +  nv_txt16
                          nv_txt16 = "" .
               END.
               ELSE IF (nv_txt15 = "") THEN  DO:
                   ASSIGN nv_txt15 = nv_txt16 
                          nv_txt16 = ""  .
               END.
            
               IF (length(nv_txt16 +  nv_txt17 ) <= 100 ) THEN DO:
                   ASSIGN nv_txt16 = nv_txt16  +  nv_txt17
                          nv_txt17 = "" .
               END.
               ELSE IF (nv_txt16 = "") THEN  DO:
                   ASSIGN nv_txt16 = nv_txt17 
                          nv_txt17 = ""  .
               END.
            
               IF (length(nv_txt17 +  nv_txt18 ) <= 100 ) THEN DO:
                   ASSIGN nv_txt17 = nv_txt17  +  nv_txt18
                          nv_txt18 = "" .
               END.
               ELSE IF (nv_txt17 = "") THEN  DO:
                   ASSIGN nv_txt17 = nv_txt18 
                          nv_txt18 = ""  .
               END.
            
               IF (length(nv_txt18 +  nv_txt19 ) <= 100 ) THEN DO:
                   ASSIGN nv_txt18 = nv_txt18  +  nv_txt19
                          nv_txt19 = "" .
               END.
               ELSE IF (nv_txt18 = "") THEN  DO:
                   ASSIGN nv_txt18 = nv_txt19 
                          nv_txt19 = ""  .
               END.
            
               IF (length(nv_txt19 +  nv_txt20 ) <= 100 ) THEN DO:
                   ASSIGN nv_txt19 = nv_txt19  +  nv_txt20
                          nv_txt20 = "" .
               END.
               ELSE IF (nv_txt19 = "") THEN  DO:
                   ASSIGN nv_txt19 = nv_txt20 
                          nv_txt20 = ""  .
               END.
            
               IF (length(nv_txt20 +  nv_txt ) <= 100 ) THEN DO:
                   ASSIGN nv_txt20 = nv_txt20  +  nv_txt
                          nv_txt = "" .
               END.
               ELSE IF (nv_txt20 = "") THEN  DO:
                   ASSIGN nv_txt20 = nv_txt
                          nv_txt = ""  .
               END.
            
               IF nv_txt1 = ""   THEN assign  nv_txt1  =  trim(nv_txt2)    nv_txt2 = "" . 
               if nv_txt2 = ""   THEN assign  nv_txt2  =  trim(nv_txt3)    nv_txt3 = "" . 
               if nv_txt3 = ""   THEN assign  nv_txt3  =  trim(nv_txt4)    nv_txt4 = "" .
               if nv_txt4 = ""   THEN assign  nv_txt4  =  trim(nv_txt5)    nv_txt5 = "" . 
               if nv_txt5 = ""   THEN assign  nv_txt5  =  trim(nv_txt6)    nv_txt6 = "" .
               if nv_txt6 = ""   THEN assign  nv_txt6  =  trim(nv_txt7)    nv_txt7 = "" .
               if nv_txt7 = ""   THEN assign  nv_txt7  =  trim(nv_txt8)    nv_txt8 = "" .
               if nv_txt8 = ""   THEN assign  nv_txt8  =  trim(nv_txt9)    nv_txt9 = "" .
               if nv_txt9 = ""   THEN assign  nv_txt9  =  trim(nv_txt10)   nv_txt10 = "" .
               if nv_txt10 = ""  THEN assign  nv_txt10 =  trim(nv_txt11)   nv_txt11 = "" .
               if nv_txt11 = ""  THEN assign  nv_txt11 =  trim(nv_txt12)   nv_txt12 = "" .   
               if nv_txt12 = ""  THEN assign  nv_txt12 =  trim(nv_txt13)   nv_txt13 = "" .   
               if nv_txt13 = ""  THEN assign  nv_txt13 =  trim(nv_txt14)   nv_txt14 = "" .   
               if nv_txt14 = ""  THEN assign  nv_txt14 =  trim(nv_txt15)   nv_txt15 = "" .   
               if nv_txt15 = ""  THEN assign  nv_txt15 =  trim(nv_txt16)   nv_txt16 = "" . 
               if nv_txt16 = ""  THEN assign  nv_txt16 =  trim(nv_txt17)   nv_txt17 = "" . 
               if nv_txt17 = ""  THEN assign  nv_txt17 =  trim(nv_txt18)   nv_txt18 = "" . 
               if nv_txt18 = ""  THEN assign  nv_txt18 =  trim(nv_txt19)   nv_txt19 = "" . 
               if nv_txt19 = ""  THEN assign  nv_txt19 =  trim(nv_txt20)   nv_txt20 = "" . 
               if nv_txt20 = ""  THEN assign  nv_txt20 =  trim(nv_txt)     nv_txt  = "" . 
            
               nv_count = nv_count + 1 .
               IF nv_count > 20 THEN LEAVE loop_chk2.
            END.
        END. /* end repeat*/
    END.

    nv_send = "" .
    IF INDEX(wdetail2.notifyno,"#INS") <> 0 THEN ASSIGN nv_send = "กธ.+ พรบ.เก็บไว้ที่ประกัน".
    ELSE IF INDEX(wdetail2.notifyno,"#TIB") <> 0 THEN ASSIGN nv_send = "ส่งกรมธรรม์ภาคสมัครใจและ/หรือพรบ.ที่ TIB" .
    ELSE IF INDEX(wdetail2.notifyno,"#กรมธรรม์โตโยต้า") <>  0  THEN ASSIGN nv_send = "บริษัทประกันภัยส่งกรมธรรม์ภาคสมัครใจและ/หรือพรบ.ที่ Dealer" .
    ELSE IF INDEX(wdetail2.notifyno,"PP") <>  0  THEN ASSIGN nv_send = "ส่งเฉพาะ พรบ. กธ.เก็บไว้ที่ประกัน" .
    ELSE IF INDEX(wdetail2.notifyno,"คุณวันวิสา") <> 0 THEN ASSIGN nv_send = "ส่งคุณวันวิสา กินนร บจก.โตโยต้าฉะเชิงเทรา ผู้จำหน่ายโตโยต้า(สนญ.) 98 ถ.ศุขประยูร ต.หน้าเมือง อ.เมือง จ.ฉะเชิงเทรา 24000" .
    ELSE IF INDEX(wdetail2.notifyno,"ส่ง กธ.") <> 0  THEN ASSIGN nv_send = TRIM(SUBSTR(wdetail2.notifyno,R-INDEX(wdetail2.notifyno,"ส่ง กธ."))) .
    ELSE ASSIGN nv_send = "กธ.+ พรบ.ส่งลูกค้าตามที่อยู่".  

    IF      nv_txt1 = ""   THEN assign  nv_txt1  =  trim(nv_send).      
    ELSE if nv_txt2 = ""   THEN assign  nv_txt2  =  trim(nv_send).      
    ELSE if nv_txt3 = ""   THEN assign  nv_txt3  =  trim(nv_send).      
    ELSE if nv_txt4 = ""   THEN assign  nv_txt4  =  trim(nv_send).      
    ELSE if nv_txt5 = ""   THEN assign  nv_txt5  =  trim(nv_send).      
    ELSE if nv_txt6 = ""   THEN assign  nv_txt6  =  trim(nv_send).      
    ELSE if nv_txt7 = ""   THEN assign  nv_txt7  =  trim(nv_send).      
    ELSE if nv_txt8 = ""   THEN assign  nv_txt8  =  trim(nv_send).      
    ELSE if nv_txt9 = ""   THEN assign  nv_txt9  =  trim(nv_send).      
    ELSE if nv_txt10 = ""  THEN assign  nv_txt10 =  trim(nv_send).

    ASSIGN fi_process = "Check accessory From Remark : " + wdetail2.chasno + "...." .
    DISP fi_process WITH FRAME fr_main.

    IF INDEX(wdetail2.notifyno,"คค.") <> 0 THEN DO:
        nv_acces = trim(SUBSTR(wdetail2.notifyno,R-INDEX(wdetail2.notifyno,"คค."))) .
        IF index(nv_acces,"เช็ค") <> 0 THEN nv_acces = TRIM(SUBSTR(wdetail2.notifyno,INDEX(wdetail2.notifyno,"คค."),INDEX(wdetail2.notifyno,"เช็ค") - 4)).
        nv_chkint = IF nv_acces <> "" THEN  SUBSTR(nv_acces,4,1) ELSE ""  .
        IF nv_chkint = "" THEN nv_chkint =  SUBSTR(nv_acces,5,1) .
        IF nv_chkint <> "" AND INDEX("1234567890",nv_chkint) <> 0 THEN nv_acces = "" .
        IF trim(nv_acces) = "คค." THEN nv_acces = "" .
        IF INDEX(nv_acces,"คค.รพีพร") <> 0 THEN nv_acces = "" .
    END.
    ELSE IF INDEX(wdetail2.notifyno,"ค/ค") <> 0 THEN DO:
        nv_acces = trim(SUBSTR(wdetail2.notifyno,R-INDEX(wdetail2.notifyno,"ค/ค"))) .
        IF index(nv_acces,"เช็ค") <> 0 THEN nv_acces = TRIM(SUBSTR(wdetail2.notifyno,INDEX(wdetail2.notifyno,"ค/ค"),INDEX(wdetail2.notifyno,"เช็ค") - 4)).
        nv_chkint = IF nv_acces <> "" THEN SUBSTR(nv_acces,4,1) ELSE ""  .
        IF nv_chkint = "" THEN nv_chkint =  SUBSTR(nv_acces,5,1) .
        IF nv_chkint <> "" AND INDEX("1234567890",nv_chkint) <> 0 THEN nv_acces = "" .
        IF trim(nv_acces) = "ค/ค" THEN nv_acces = "" .
    END.
    IF nv_acces <> "" THEN ASSIGN wdetail2.access = IF wdetail2.access = "" THEN nv_acces ELSE wdetail2.access + "," + nv_acces .
END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_fileerr C-Win 
PROCEDURE proc_fileerr :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 ASSIGN fi_process = "Export Data file Error !!! "  .
   DISP fi_process WITH FRAME fr_main.
DO:
    If  substr(fi_outfile1,length(fi_outfile1) - 3,4) <>  ".csv"  THEN fi_outfile1  =  Trim(fi_outfile1) + ".csv"  .
    OUTPUT STREAM ns2 TO value(fi_outfile1).
    PUT STREAM ns2
        "Error " "|"
        "Risk No. "       "|"
        "Item No. "       "|"
        "Policy No (เลขที่กรมธรรม์ภาคสมัครใจ)"   "|"
        "Branch (สาขา) "                "|" 
        "Agent Code (รหัสตัวแทน)    "   "|" 
        "Producer Code "                "|" 
        "Dealer Code (รหัสดีเลอร์)  "   "|" 
        "Finance Code (รหัสไฟแนนซ์) "   "|" 
        "Notification Number (เลขที่รับแจ้ง) "   "|"
        "Notification Name (ชื่อผู้แจ้ง)     "   "|"
        "Short Rate    "                "|"
        "Effective Date(วันที่เริ่มความคุ้มครอง)"  "|"
        "Expiry Date (วันที่สิ้นสุดความคุ้มครอง) " "|"
        "Agree Date    "               "|"         
        "First Date    "               "|"
        "Package Code  "               "|"
        "Campaign Code (รหัสแคมเปญ) "  "|"
        "Campaign Text "               "|"
        "Spec Con      "               "|"
        "Product Type  "               "|"
        "Promotion Code"               "|"
        "Renew Count   "               "|"
        "Previous Policy (เลขทีกรมธรรม์ภาคสมัครใจเดิม)"   "|"
        "Policy Text 1 "        "|" 
        "Policy Text 2 "        "|" 
        "Policy Text 3 "        "|" 
        "Policy Text 4 "        "|" 
        "Policy Text 5 "        "|" 
        "Policy Text 6 "        "|" 
        "Policy Text 7 "        "|" 
        "Policy Text 8 "        "|" 
        "Policy Text 9 "        "|" 
        "Policy Text 10"        "|" 
        "Memo Text 1   "        "|" 
        "Memo Text 2   "        "|" 
        "Memo Text 3   "        "|" 
        "Memo Text 4   "        "|" 
        "Memo Text 5   "        "|" 
        "Memo Text 6   "        "|" 
        "Memo Text 7   "        "|" 
        "Memo Text 8   "        "|" 
        "Memo Text 9   "        "|" 
        "Memo Text 10  "        "|" 
        "Accessory Text 1 "     "|" 
        "Accessory Text 2 "     "|" 
        "Accessory Text 3 "     "|" 
        "Accessory Text 4 "     "|" 
        "Accessory Text 5 "     "|" 
        "Accessory Text 6 "     "|" 
        "Accessory Text 7 "     "|" 
        "Accessory Text 8 "     "|" 
        "Accessory Text 9 "     "|" 
        "Accessory Text 10"     "|" 
        "กรมธรรม์ซื้อควบ (Y/N)" "|" 
        "Insured Code         " "|" 
        "ประเภทบุคคล          " "|" 
        "ภาษาที่ใช้สร้าง Cilent Code"  "|"
        "คำนำหน้า"                     "|"
        "ชื่อ    "                     "|"
        "นามสกุล "                     "|"
        "เลขที่บัตรประชาชน / เลขที่นิติบุคคล "   "|"
        "ลำดับที่สาขา        "       "|"
        "อาชีพ               "       "|"
        "ที่อยู่บรรทัดที่ 1  "       "|"
        "ที่อยู่บรรทัดที่ 2  "       "|"
        "ที่อยู่บรรทัดที่ 3  "       "|"
        "ที่อยู่บรรทัดที่ 4  "       "|"
        "รหัสไปรษณีย์        "       "|"
        "province code       "       "|"
        "district code       "       "|"
        "sub district code   "       "|"
        "AE Code             "       "|"
        "Japanese Team       "       "|"
        "TS Code             "       "|" 
        "Gender (Male/Female/Other)  "  "|" 
        "Telephone 1   "       "|"      
        "Telephone 2   "       "|"      
        "E-Mail 1      "       "|"      
        "E-Mail 2      "       "|"      
        "E-Mail 3      "       "|"      
        "E-Mail 4      "       "|"      
        "E-Mail 5      "       "|"      
        "E-Mail 6      "       "|"      
        "E-Mail 7      "       "|"      
        "E-Mail 8      "       "|"      
        "E-Mail 9      "       "|"      
        "E-Mail 10     "       "|"      
        "Fax           "       "|"      
        "Line ID       "       "|"      
        "CareOf1       "       "|"      
        "CareOf2       "       "|"      
        "Benefit Name  "       "|"      
        "Payer Code    "       "|"      
        "VAT Code      "       "|"      
        "Client Code   "       "|"      
        "ประเภทบุคคล   "       "|"      
        "คำนำหน้า      "       "|"      
        "ชื่อ          "       "|"      
        "นามสกุล       "       "|"              
        "เลขที่บัตรประชาชน / เลขที่นิติบุคคล "  "|" 
        "ลำดับที่สาขา       "        "|"        
        "ที่อยู่บรรทัดที่ 1 "        "|"
        "ที่อยู่บรรทัดที่ 2 "        "|"
        "ที่อยู่บรรทัดที่ 3 "        "|"
        "ที่อยู่บรรทัดที่ 4 "        "|"
        "รหัสไปรษณีย์       "        "|"
        "province code      "        "|"
        "district code      "        "|"
        "sub district code  "        "|"
        "เบี้ยก่อนภาษีอากร  "        "|"
        "อากร               "        "|"
        "ภาษี               "        "|"
        "คอมมิชชั่น 1       "        "|"
        "คอมมิชชั่น 2 (co-broker)"   "|"
        "Client Code        "        "|"
        "ประเภทบุคคล        "        "|"
        "คำนำหน้า           "        "|"
        "ชื่อ               "        "|"
        "นามสกุล            "        "|"
        "เลขที่บัตรประชาชน / เลขที่นิติบุคคล "  "|"
        "ลำดับที่สาขา       "        "|"
        "ที่อยู่บรรทัดที่ 1 "        "|"
        "ที่อยู่บรรทัดที่ 2 "        "|"
        "ที่อยู่บรรทัดที่ 3 "        "|"
        "ที่อยู่บรรทัดที่ 4 "        "|"
        "รหัสไปรษณีย์       "        "|"
        "province code      "        "|"
        "district code      "        "|"
        "sub district code  "        "|"
        "เบี้ยก่อนภาษีอากร  "        "|"
        "อากร               "        "|"
        "ภาษี               "        "|"
        "คอมมิชชั่น 1       "        "|"
        "คอมมิชชั่น 2 (co-broker)  " "|"
        "Client Code        "        "|"
        "ประเภทบุคคล        "        "|"
        "คำนำหน้า           "        "|" 
        "ชื่อ               "        "|" 
        "นามสกุล            "        "|" 
        "เลขที่บัตรประชาชน/เลขที่นิติบุคคล   "  "|" 
        "ลำดับที่สาขา      "      "|"           
        "ที่อยู่บรรทัดที่ 1"      "|"           
        "ที่อยู่บรรทัดที่ 2"      "|"           
        "ที่อยู่บรรทัดที่ 3"      "|"           
        "ที่อยู่บรรทัดที่ 4"      "|"           
        "รหัสไปรษณีย์      "      "|"           
        "province code     "      "|"           
        "district code     "      "|"           
        "sub district code "      "|"           
        "เบี้ยก่อนภาษีอากร "      "|"           
        "อากร              "      "|"           
        "ภาษี              "      "|"           
        "คอมมิชชั่น 1      "      "|"           
        "คอมมิชชั่น 2 (co-broker)  "            "|" 
        "Cover Type (ประเภทความคุ้มครอง)     "  "|" 
        "Garage (ประเภทการซ่อม ซ่อมอู่/ซ่อมห้าง)"  "|"
        "Spacial Equipment Flag (A/Blank)  "       "|"
        "Inspection       "               "|"
        "รหัสรถภาคสมัครใจ (110/120/320)"  "|"
        "ลักษณะการใช้รถ        "   "|"
        "Redbook               "   "|"
        "ยี่ห้อรถ              "   "|"
        "ชื่อรุ่นรถ            "   "|"
        "ชื่อรุ่นย่อยรถ        "   "|"
        "ปีรุ่นรถ              "   "|"
        "หมายเลขตัวถัง         "   "|"
        "หมายเลขเครื่อง        "   "|"
        "หมายเลขเครื่อง2       "   "|"
        "จำนวนที่นั่ง (รวมผู้ขับขี่)   "  "|"
        "ปริมาตรกระบอกสูบ (CC) "   "|"
        "น้ำหนัก               "   "|"
        "Kilowatt              "   "|"
        "รหัสแบบตัวถัง         "   "|"
        "ป้ายแดง (Y/N)         "   "|"
        "ปีที่จดทะเบียน        "   "|"
        "เลขทะเบียนรถ          "   "|"
        "จังหวัดที่จดทะเบียน   "   "|"
        "Group Car (กลุ่มรถ)    "  "|"
        "Color (สี)             "  "|"
        "Fule (เชื้อเพลิง)      "  "|"
        "Driver Number          "  "|"
        "คำนำหน้า               "  "|"
        "ชื่อ                   "  "|"
        "นามสกุล                "  "|"
        "เลขที่บัตรประชาชน      "  "|"
        "เพศ                    "  "|"
        "วันเกิด                "  "|"
        "ชื่ออาชีพ              "  "|"
        "เลขที่ใบอนุญาตขับขี่   "  "|"
        "วันที่ใบอนุญาต หมดอายุ "  "|"
        "consent ผู้ขับขี่      "  "|"
        "ระดับพฤติกรรมการขับขี่ "  "|"
        "คำนำหน้า   "              "|"
        "ชื่อ       "              "|"
        "นามสกุล    "              "|"
        "เลขที่บัตรประชาชน      "  "|"
        "เพศ        "              "|"
        "วันเกิด    "              "|"
        "ชื่ออาชีพ  "              "|"
        "เลขที่ใบอนุญาตขับขี่   "  "|"
        "วันที่ใบอนุญาต หมดอายุ "  "|"
        "consent ผู้ขับขี่      "  "|"
        "ระดับพฤติกรรมการขับขี่ "  "|"
        "คำนำหน้า   "              "|"
        "ชื่อ       "              "|"
        "นามสกุล    "              "|"
        "เลขที่บัตรประชาชน      "  "|"
        "เพศ        "              "|"
        "วันเกิด    "              "|"
        "ชื่ออาชีพ  "              "|"
        "เลขที่ใบอนุญาตขับขี่   "  "|"
        "วันที่ใบอนุญาต หมดอายุ "  "|"
        "consent ผู้ขับขี่      "  "|"
        "ระดับพฤติกรรมการขับขี่ "  "|"
        "คำนำหน้า  "         "|"
        "ชื่อ      "         "|"
        "นามสกุล   "         "|"
        "เลขที่บัตรประชาชน " "|"
        "เพศ       "         "|"
        "วันเกิด   "         "|"
        "ชื่ออาชีพ "         "|"
        "เลขที่ใบอนุญาตขับขี่   " "|"
        "วันที่ใบอนุญาต หมดอายุ " "|"
        "consent ผู้ขับขี่      " "|"
        "ระดับพฤติกรรมการขับขี่ " "|"
        "คำนำหน้า   "             "|"
        "ชื่อ       "             "|"
        "นามสกุล    "             "|"
        "เลขที่บัตรประชาชน "      "|"
        "เพศ        "             "|"
        "วันเกิด    "             "|"
        "ชื่ออาชีพ  "             "|"
        "เลขที่ใบอนุญาตขับขี่   " "|"
        "วันที่ใบอนุญาต หมดอายุ " "|"
        "consent ผู้ขับขี่ "      "|"
        "ระดับพฤติกรรมการขับขี่ " "|"
        "Base Premium Plus "   "|"
        "Sum Insured Plus  "   "|"
        "RS10 Amount       "   "|"
        "TPBI / person     "   "|"
        "TPBI / occurrence "   "|"
        "TPPD              "   "|"
        "Deduct / OD       "   "|"
        "Deduct /Add OD    "   "|"
        "Deduct / PD       "   "|"
        "Market Value EV   "   "|"
        "วงเงินทุนประกัน   "   "|"
        "PA1.1 / driver    "   "|"
        "PA1.1 no.of passenger  " "|"
        "PA1.1 / passenger "      "|"
        "PA1.2 / driver    "      "|"
        "PA1.2 no.of passenger  " "|"
        "PA1.2 / passenger"       "|"
        "PA2    "         "|"
        "PA3    "         "|"
        "Base Premium "   "|"
        "Unname "         "|"
        "Name   "         "|"
        "TPBI / person Amount   " "|"
        "TPBI / Accident Amount " "|"
        "TPPD Amount   "         "|"
        "Deduct / OD Amount  "   "|"
        "Add / OD Amount     "   "|"
        "Deduct / PD Amount  "   "|"
        "RY01 Amount     "       "|"
        "RY01 Amount (412)   "   "|"
        "RY01 Amount (413)   "   "|"
        "RY01 Amount (414)   "   "|"
        "RY02 Amount   "         "|"
        "RY03 Amount   "         "|"
        "Fleet%        "         "|"
        "NCB%          "         "|"
        "Load Claim%   "         "|"
        "Other Disc.%  "         "|"
        "CCTV%         "         "|"
        "Walkin Disc.% "         "|"
        "Fleet Amount  "         "|"
        "NCB Amount    "         "|"
        "Load Claim Amount   "   "|"
        "Other Disc. Amount  "   "|"
        "CCTV Amount   "         "|"
        "Walk in Disc. Amount"   "|"
        "เบี้ยสุทธิ    "         "|"
        "Stamp Duty    "         "|"
        "VAT           "         "|"
        "Commission %  "         "|"
        "Commission Amount   "   "|"
        "Agent Code co-broker (รหัสตัวแทน) "  "|"
        "Commission % co-broker      "  "|" 
        "Commission Amount co-broker "  "|" 
        "Package (Attach Coverage)   "  "|" 
        "Dangerous Object 1  "          "|" 
        "Dangerous Object 2  "          "|" 
        "Sum Insured    "               "|" 
        "Rate%          "               "|" 
        "Fleet%         "               "|" 
        "NCB%           "               "|" 
        "Discount%      "               "|" 
        "Walkin Disc.%  "               "|" 
        "Premium Attach Coverage"       "|" 
        "Discount Fleet "               "|" 
        "Discount NCB   "               "|" 
        "Other Discount "               "|" 
        "Walk in Disc. Amount"          "|" 
        "Net Premium    "               "|" 
        "Stamp Duty     "               "|" 
        "VAT            "               "|" 
        "Commission Amount   "          "|" 
        "Commission Amount co-broker "  "|" 
        "Claim Text         "           "|" 
        "Claim Amount       "           "|" 
        "Claim Count Fault  "           "|" 
        "Claim Count Fault Amount"      "|" 
        "Claim Count Good        "      "|" 
        "Claim Count Good Amount "      "|" 
        "Loss Ratio % (Not TP)   "      "|" 
        "Compulsory Policy Number (เลขที่กรมธรรม์ พรบ.) " "|"
        "Effective Date (วันที่เริ่มความคุ้มครอง พรบ.)  " "|"
        "Expiry Date (วันที่สิ้นสุดความคุ้มครอง พรบ.)   " "|"
        "Barcode No.                       "        "|" 
        "Compulsory Class (รหัส พรบ.)      "        "|" 
        "Compulsory Walk In Discount %     "        "|" 
        "Compulsory Walk In Discount Amount"        "|" 
        "เบี้ยสุทธิ พ.ร.บ. กรณี กรมธรรม์ซื้อควบ  "  "|" 
        "Stamp Duty   "          "|"
        "VAT          "          "|"
        "Commission % "          "|"
        "Commission Amount  "    "|"
        "เลขที่แบตเตอรี่    "    "|"
        "ปีแบตฯ       "          "|"
        "ราคาแบตฯ     "          "|"
        "ทุนประกันแบตฯ"          "|"
        "Rate         "          "|"
        "Premium      "          "|"
        "เลขที่เครื่องชาร์จ "    "|"
        "ราคาเครื่องชาร์จ   "    "|"
        "Rate         "          "|"
        "Premium      "          SKIP .
      RUN proc_fileerr1.

      OUTPUT STREAM ns2 CLOSE.
    END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_fileerr1 C-Win 
PROCEDURE proc_fileerr1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_count AS INTE INIT 0.
FOR EACH wdetail WHERE wdetail.comment <> "" NO-LOCK .
   ASSIGN fi_process = "Export Data file Error : " + wdetail.chasno + ".... "  .
   DISP fi_process WITH FRAME fr_main.
   ASSIGN n_count = n_count + 1.
   PUT STREAM ns2 
        wdetail.comment  FORMAT "x(250)"  "|"
        n_count         "|"    /*A64-0355*/
        wdetail.itemno         "|"
        wdetail.policyno       FORMAT "x(12)"  "|"
        wdetail.n_branch       "|"
        wdetail.agent          "|"
        wdetail.producer       "|"
        wdetail.n_delercode    "|"
        wdetail.fincode        "|"
        wdetail.appenno        "|"
        wdetail.salename       "|"
        wdetail.srate          "|"
        wdetail.comdat         "|"
        wdetail.expdat         "|"
        wdetail.agreedat       "|"
        wdetail.firstdat       "|"
        wdetail.packcod        "|"
        wdetail.camp_no        "|"
        wdetail.campen         "|"
        wdetail.specon         "|"
        wdetail.product        "|"
        wdetail.promo          "|"
        wdetail.rencnt         "|"
        wdetail.prepol         "|"
        wdetail.txt1       FORMAT  "x(100)"   "|"
        wdetail.txt2       FORMAT  "x(100)"   "|"
        wdetail.txt3       FORMAT  "x(100)"   "|"
        wdetail.txt4       FORMAT  "x(100)"   "|"
        wdetail.txt5       FORMAT  "x(100)"   "|"
        wdetail.txt6       FORMAT  "x(100)"   "|"
        wdetail.txt7       FORMAT  "x(100)"   "|"
        wdetail.txt8       FORMAT  "x(100)"   "|"
        wdetail.txt9       FORMAT  "x(100)"   "|"
        wdetail.txt10      FORMAT  "x(100)"   "|"
        wdetail.memo1      FORMAT  "x(150)"   "|"
        wdetail.memo2      FORMAT  "x(150)"   "|"
        wdetail.memo3      FORMAT  "x(150)"   "|"
        wdetail.memo4      FORMAT  "x(150)"   "|"
        wdetail.memo5      FORMAT  "x(150)"   "|"
        wdetail.memo6      FORMAT  "x(150)"   "|"
        wdetail.memo7      FORMAT  "x(150)"   "|"
        wdetail.memo8      FORMAT  "x(150)"   "|"
        wdetail.memo9      FORMAT  "x(150)"   "|"
        wdetail.memo10     FORMAT  "x(150)"   "|"
        wdetail.accdata1   FORMAT  "x(100)"   "|"
        wdetail.accdata2   FORMAT  "x(100)"   "|"
        wdetail.accdata3   FORMAT  "x(100)"   "|"
        wdetail.accdata4   FORMAT  "x(100)"   "|"
        wdetail.accdata5   FORMAT  "x(100)"   "|"
        wdetail.accdata6   FORMAT  "x(100)"   "|"
        wdetail.accdata7   FORMAT  "x(100)"   "|"
        wdetail.accdata8   FORMAT  "x(100)"   "|"
        wdetail.accdata9   FORMAT  "x(100)"   "|"
        wdetail.accdata10  FORMAT  "x(100)"   "|"
        wdetail.compul     "|"
        wdetail.insref     "|" /* A64-0355*/
        wdetail.instyp     "|"
        wdetail.inslang    "|"
        wdetail.tiname     "|"
        wdetail.insnam    format "x(100)"   "|"
        wdetail.lastname  format "x(100)"   "|"
        wdetail.icno       "|"
        wdetail.insbr      "|"
        wdetail.occup      "|"
        wdetail.addr      format "x(60)"   "|"
        wdetail.tambon    format "x(60)"   "|"
        wdetail.amper     format "x(60)"   "|"
        wdetail.country   format "x(60)"   "|"
        wdetail.post       "|"
        wdetail.provcod    "|"
        wdetail.distcod    "|"
        wdetail.sdistcod   "|"
        wdetail.jpae       "|"  /*A64-0355*/      
        wdetail.jpjtl      "|"  /*A64-0355*/      
        wdetail.jpts       "|"  /*A64-0355*/      
        wdetail.gender     "|"
        wdetail.tele1      "|"
        wdetail.tele2      "|"
        wdetail.mail1     format "x(50)"    "|"
        wdetail.mail2     format "x(50)"    "|"
        wdetail.mail3     format "x(50)"    "|"
        wdetail.mail4     format "x(50)"    "|"
        wdetail.mail5     format "x(50)"    "|"
        wdetail.mail6     format "x(50)"    "|"
        wdetail.mail7     format "x(50)"    "|"
        wdetail.mail8     format "x(50)"    "|"
        wdetail.mail9     format "x(50)"    "|"
        wdetail.mail10    format "x(50)"    "|"
        wdetail.fax       "|"
        wdetail.lineID    FORMAT "x(50)"    "|"
        wdetail.name2     format "x(70)"   "|"
        wdetail.name3     format "x(70)"   "|"
        wdetail.benname   format "x(70)"   "|"
        wdetail.payercod     "|"
        wdetail.vatcode      "|"
        wdetail.instcod1     "|"
        wdetail.insttyp1     "|"
        wdetail.insttitle1   "|"
        wdetail.instname1   format "X(50)"  "|"
        wdetail.instlname1  format "X(50)"  "|"
        wdetail.instic1      "|"
        wdetail.instbr1      "|"
        wdetail.instaddr11 format "X(50)"   "|"
        wdetail.instaddr21 format "X(50)"   "|"
        wdetail.instaddr31 format "X(50)"  "|"
        wdetail.instaddr41 format "X(50)"   "|"
        wdetail.instpost1     "|"
        wdetail.instprovcod1  "|"
        wdetail.instdistcod1  "|"
        wdetail.instsdistcod1 "|"
        wdetail.instprm1      "|"
        wdetail.instrstp1     "|"
        wdetail.instrtax1     "|"
        wdetail.instcomm01    "|"
        wdetail.instcomm12    "|"
        wdetail.instcod2      "|"
        wdetail.insttyp2      "|"
        wdetail.insttitle2    "|"
        wdetail.instname2     format "X(50)"   "|"
        wdetail.instlname2    format "X(50)"   "|"
        wdetail.instic2       "|"
        wdetail.instbr2       "|"
        wdetail.instaddr12  format "X(50)"   "|"
        wdetail.instaddr22  format "X(50)"   "|"
        wdetail.instaddr32  format "X(50)"   "|"
        wdetail.instaddr42  format "X(50)"   "|"
        wdetail.instpost2     "|"
        wdetail.instprovcod2  "|"
        wdetail.instdistcod2  "|"
        wdetail.instsdistcod2 "|"
        wdetail.instprm2      "|"
        wdetail.instrstp2     "|"
        wdetail.instrtax2     "|"
        wdetail.instcomm02    "|"
        wdetail.instcomm22    "|"
        wdetail.instcod3      "|"
        wdetail.insttyp3      "|"
        wdetail.insttitle3    "|"
        wdetail.instname3     format "X(50)"   "|"
        wdetail.instlname3    format "X(50)"   "|"
        wdetail.instic3       "|"
        wdetail.instbr3       "|"
        wdetail.instaddr13    format "X(50)"   "|"
        wdetail.instaddr23    format "X(50)"   "|"
        wdetail.instaddr33    format "X(50)"   "|"
        wdetail.instaddr43    format "X(50)"   "|"
        wdetail.instpost3     "|"
        wdetail.instprovcod3  "|"
        wdetail.instdistcod3  "|"
        wdetail.instsdistcod3 "|"
        wdetail.instprm3     "|"
        wdetail.instrstp3    "|"
        wdetail.instrtax3    "|"
        wdetail.instcomm03   "|"
        wdetail.instcomm23   "|"
        wdetail.covcod       "|"
        wdetail.garage       "|"
        wdetail.special      "|"
        wdetail.inspec       "|"
        wdetail.class70      "|"
        wdetail.vehuse       "|"  /*A64-0355*/
        wdetail.redbook      "|"  /*A65-0079*/
        wdetail.brand     format "X(50)"     "|"
        wdetail.model     format "X(50)"     "|"
        wdetail.submodel  format "X(50)"     "|"
        wdetail.yrmanu      "|"
        wdetail.chasno      "|"
        wdetail.engno       "|"
        wdetail.eng_no2     "|" /*A67-0029*/
        wdetail.seat        "|"
        wdetail.engcc       "|"
        wdetail.weight      "|"
        wdetail.watt        "|"
        wdetail.body        "|"
        wdetail.ntype        "|"
        wdetail.re_year      "|"
        wdetail.vehreg       "|"
        wdetail.re_country   "|"
        wdetail.cargrp       "|"
        wdetail.colorcar     "|"
        wdetail.fule         "|"
        wdetail.drivnam      "|"
        wdetail.ntitle1      "|"
        wdetail.drivername1 format "X(50)"  "|"
        wdetail.dname2      format "X(50)"  "|"
        wdetail.dicno       "|" 
        wdetail.dgender1    "|" 
        wdetail.dbirth      "|" 
        wdetail.doccup      format "X(50)"  "|"
        wdetail.ddriveno    "|" 
        wdetail.drivexp1    "|" 
        wdetail.dconsen1    "|" 
        wdetail.dlevel1     "|" 
        wdetail.ntitle2     "|" 
        wdetail.drivername2 format "X(50)"  "|"
        wdetail.ddname1     format "X(50)"  "|"
        wdetail.ddicno       "|"
        wdetail.dgender2     "|"
        wdetail.ddbirth      "|"
        wdetail.ddoccup     format "X(50)"  "|"
        wdetail.dddriveno    "|"
        wdetail.drivexp2     "|"
        wdetail.dconsen2     "|"
        wdetail.dlevel2      "|"
        wdetail.ntitle3      "|"
        wdetail.dname3     format "X(50)"   "|"
        wdetail.dlname3    format "X(50)"   "|"
        wdetail.dicno3       "|"
        wdetail.dgender3     "|"
        wdetail.dbirth3      "|"
        wdetail.doccup3    format "X(50)"   "|"
        wdetail.ddriveno3    "|"
        wdetail.drivexp3     "|"
        wdetail.dconsen3     "|"
        wdetail.dlevel3      "|"
        wdetail.ntitle4      "|"
        wdetail.dname4     format "X(50)"   "|"
        wdetail.dlname4    format "X(50)"   "|"
        wdetail.dicno4       "|"
        wdetail.dgender4     "|"
        wdetail.dbirth4      "|"
        wdetail.doccup4    format "X(50)"   "|"
        wdetail.ddriveno4    "|"
        wdetail.drivexp4     "|"
        wdetail.dconsen4     "|"
        wdetail.dlevel4      "|"
        wdetail.ntitle5      "|"
        wdetail.dname5     format "X(50)"   "|"
        wdetail.dlname5    format "X(50)"   "|"
        wdetail.dicno5       "|"
        wdetail.dgender5     "|"
        wdetail.dbirth5      "|"
        wdetail.doccup5    format "X(50)"   "|"
        wdetail.ddriveno5    "|"
        wdetail.drivexp5     "|"
        wdetail.dconsen5     "|"
        wdetail.dlevel5      "|"
        wdetail.baseplus     "|"
        wdetail.siplus       "|"
        wdetail.rs10         "|"
        wdetail.comper       "|"
        wdetail.comacc       "|"
        wdetail.deductpd     "|"
        wdetail.DOD          "|"
        wdetail.DOD1         "|"
        wdetail.DPD          "|" 
        wdetail.maksi        "|"
        wdetail.tpfire       "|"
        wdetail.NO_41        "|"
        wdetail.ac2          "|"
        wdetail.ac4          "|"
        wdetail.ac5          "|"
        wdetail.ac6          "|"
        wdetail.ac7          "|"
        wdetail.NO_42        "|"
        wdetail.NO_43        "|"
        wdetail.base         "|"
        wdetail.unname       "|"
        wdetail.nname        "|"
        wdetail.tpbi         "|"
        wdetail.bi2          "|"
        wdetail.tppd         "|"
        wdetail.dodamt       "|"
        wdetail.dod1amt      "|"
        wdetail.dpdamt       "|"
        wdetail.ry01         "|"
        wdetail.ry412        "|"
        wdetail.ry413        "|"
        wdetail.ry414        "|"
        wdetail.ry02         "|"
        wdetail.ry03         "|"
        wdetail.fleet        "|"
        wdetail.ncb          "|"
        wdetail.claim        "|"
        wdetail.dspc         "|"
        wdetail.cctv         "|"
        wdetail.dstf         "|"
        wdetail.fleetprem    "|"   
        wdetail.ncbprem      "|"   
        wdetail.clprem       "|"
        wdetail.dspcprem     "|"
        wdetail.cctvprem     "|"
        wdetail.dstfprem     "|"
        wdetail.premt        "|"
        wdetail.rstp_t       "|"
        wdetail.rtax_t       "|"
        wdetail.comper70     "|"
        wdetail.comprem70    "|"
        wdetail.agco70       "|"
        wdetail.comco_per70  "|"
        wdetail.comco_prem70 "|"
        wdetail.dgpackge     "|"
        wdetail.danger1      "|"
        wdetail.danger2      "|"
        wdetail.dgsi         "|"
        wdetail.dgrate       "|"
        wdetail.dgfeet       "|"
        wdetail.dgncb        "|"
        wdetail.dgdisc       "|"
        wdetail.dgwdisc      "|"
        wdetail.dgatt        "|"
        wdetail.dgfeetprm    "|"
        wdetail.dgncbprm     "|"
        wdetail.dgdiscprm    "|"
        wdetail.dgWdiscprm   "|"
        wdetail.dgprem       "|"
        wdetail.dgrstp_t     "|"
        wdetail.dgrtax_t     "|"
        wdetail.dgcomper     "|"
        wdetail.dgcomprem    "|"
        wdetail.cltxt        "|"
        wdetail.clamount     "|" 
        wdetail.faultno      "|"
        wdetail.faultprm     "|" 
        wdetail.goodno       "|"
        wdetail.goodprm      "|"
        wdetail.loss         "|"
        wdetail.compolusory  "|"
        wdetail.comdat72     "|"
        wdetail.expdat72     "|"
        wdetail.barcode      "|"
        wdetail.class72      "|"
        wdetail.dstf72       "|"
        wdetail.dstfprem72   "|"
        wdetail.premt72      "|"
        wdetail.rstp_t72     "|"
        wdetail.rtax_t72     "|"
        wdetail.comper72     "|"
        wdetail.comprem72    "|"
        wdetail.battno       "|"
        wdetail.battyr       "|"
        wdetail.battprice    "|"
        wdetail.battsi       "|" 
        wdetail.battrate     "|" 
        wdetail.battprm      "|" 
        wdetail.chargno      "|" 
        wdetail.chargsi      "|" 
        wdetail.chargrate    "|" 
        wdetail.chargprm     SKIP.
    END.      
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_fileload C-Win 
PROCEDURE Proc_fileload :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN fi_process = "Export file Load ...." .
DISP fi_process WITH FRAME fr_main.
DO:
    If  substr(fi_outfileload,length(fi_outfileload) - 3,4) <>  ".csv"  THEN fi_outfileload  =  Trim(fi_outfileload) + ".csv"  .
    OUTPUT STREAM ns3 TO value(fi_outfileload).
    PUT STREAM ns3
        "Risk No. "       "|"
        "Item No. "       "|"
        "Policy No (เลขที่กรมธรรม์ภาคสมัครใจ)"   "|"
        "Branch (สาขา) "                "|" 
        "Agent Code (รหัสตัวแทน)    "   "|" 
        "Producer Code "                "|" 
        "Dealer Code (รหัสดีเลอร์)  "   "|" 
        "Finance Code (รหัสไฟแนนซ์) "   "|" 
        "Notification Number (เลขที่รับแจ้ง) "   "|"
        "Notification Name (ชื่อผู้แจ้ง)     "   "|"
        "Short Rate    "                "|"
        "Effective Date(วันที่เริ่มความคุ้มครอง)"  "|"
        "Expiry Date (วันที่สิ้นสุดความคุ้มครอง) " "|"
        "Agree Date    "               "|"         
        "First Date    "               "|"
        "Package Code  "               "|"
        "Campaign Code (รหัสแคมเปญ) "  "|"
        "Campaign Text "               "|"
        "Spec Con      "               "|"
        "Product Type  "               "|"
        "Promotion Code"               "|"
        "Renew Count   "               "|"
        "Previous Policy (เลขทีกรมธรรม์ภาคสมัครใจเดิม)"   "|"
        "Policy Text 1 "        "|" 
        "Policy Text 2 "        "|" 
        "Policy Text 3 "        "|" 
        "Policy Text 4 "        "|" 
        "Policy Text 5 "        "|" 
        "Policy Text 6 "        "|" 
        "Policy Text 7 "        "|" 
        "Policy Text 8 "        "|" 
        "Policy Text 9 "        "|" 
        "Policy Text 10"        "|" 
        "Memo Text 1   "        "|" 
        "Memo Text 2   "        "|" 
        "Memo Text 3   "        "|" 
        "Memo Text 4   "        "|" 
        "Memo Text 5   "        "|" 
        "Memo Text 6   "        "|" 
        "Memo Text 7   "        "|" 
        "Memo Text 8   "        "|" 
        "Memo Text 9   "        "|" 
        "Memo Text 10  "        "|" 
        "Accessory Text 1 "     "|" 
        "Accessory Text 2 "     "|" 
        "Accessory Text 3 "     "|" 
        "Accessory Text 4 "     "|" 
        "Accessory Text 5 "     "|" 
        "Accessory Text 6 "     "|" 
        "Accessory Text 7 "     "|" 
        "Accessory Text 8 "     "|" 
        "Accessory Text 9 "     "|" 
        "Accessory Text 10"     "|" 
        "กรมธรรม์ซื้อควบ (Y/N)" "|" 
        "Insured Code         " "|" 
        "ประเภทบุคคล          " "|" 
        "ภาษาที่ใช้สร้าง Cilent Code"  "|"
        "คำนำหน้า"                     "|"
        "ชื่อ    "                     "|"
        "นามสกุล "                     "|"
        "เลขที่บัตรประชาชน / เลขที่นิติบุคคล "   "|"
        "ลำดับที่สาขา        "       "|"
        "อาชีพ               "       "|"
        "ที่อยู่บรรทัดที่ 1  "       "|"
        "ที่อยู่บรรทัดที่ 2  "       "|"
        "ที่อยู่บรรทัดที่ 3  "       "|"
        "ที่อยู่บรรทัดที่ 4  "       "|"
        "รหัสไปรษณีย์        "       "|"
        "province code       "       "|"
        "district code       "       "|"
        "sub district code   "       "|"
        "AE Code             "       "|"
        "Japanese Team       "       "|"
        "TS Code             "       "|" 
        "Gender (Male/Female/Other)  "  "|" 
        "Telephone 1   "       "|"      
        "Telephone 2   "       "|"      
        "E-Mail 1      "       "|"      
        "E-Mail 2      "       "|"      
        "E-Mail 3      "       "|"      
        "E-Mail 4      "       "|"      
        "E-Mail 5      "       "|"      
        "E-Mail 6      "       "|"      
        "E-Mail 7      "       "|"      
        "E-Mail 8      "       "|"      
        "E-Mail 9      "       "|"      
        "E-Mail 10     "       "|"      
        "Fax           "       "|"      
        "Line ID       "       "|"      
        "CareOf1       "       "|"      
        "CareOf2       "       "|"      
        "Benefit Name  "       "|"      
        "Payer Code    "       "|"      
        "VAT Code      "       "|"      
        "Client Code   "       "|"      
        "ประเภทบุคคล   "       "|"      
        "คำนำหน้า      "       "|"      
        "ชื่อ          "       "|"      
        "นามสกุล       "       "|"              
        "เลขที่บัตรประชาชน / เลขที่นิติบุคคล "  "|" 
        "ลำดับที่สาขา       "        "|"        
        "ที่อยู่บรรทัดที่ 1 "        "|"
        "ที่อยู่บรรทัดที่ 2 "        "|"
        "ที่อยู่บรรทัดที่ 3 "        "|"
        "ที่อยู่บรรทัดที่ 4 "        "|"
        "รหัสไปรษณีย์       "        "|"
        "province code      "        "|"
        "district code      "        "|"
        "sub district code  "        "|"
        "เบี้ยก่อนภาษีอากร  "        "|"
        "อากร               "        "|"
        "ภาษี               "        "|"
        "คอมมิชชั่น 1       "        "|"
        "คอมมิชชั่น 2 (co-broker)"   "|"
        "Client Code        "        "|"
        "ประเภทบุคคล        "        "|"
        "คำนำหน้า           "        "|"
        "ชื่อ               "        "|"
        "นามสกุล            "        "|"
        "เลขที่บัตรประชาชน / เลขที่นิติบุคคล "  "|"
        "ลำดับที่สาขา       "        "|"
        "ที่อยู่บรรทัดที่ 1 "        "|"
        "ที่อยู่บรรทัดที่ 2 "        "|"
        "ที่อยู่บรรทัดที่ 3 "        "|"
        "ที่อยู่บรรทัดที่ 4 "        "|"
        "รหัสไปรษณีย์       "        "|"
        "province code      "        "|"
        "district code      "        "|"
        "sub district code  "        "|"
        "เบี้ยก่อนภาษีอากร  "        "|"
        "อากร               "        "|"
        "ภาษี               "        "|"
        "คอมมิชชั่น 1       "        "|"
        "คอมมิชชั่น 2 (co-broker)  " "|"
        "Client Code        "        "|"
        "ประเภทบุคคล        "        "|"
        "คำนำหน้า           "        "|" 
        "ชื่อ               "        "|" 
        "นามสกุล            "        "|" 
        "เลขที่บัตรประชาชน/เลขที่นิติบุคคล   "  "|" 
        "ลำดับที่สาขา      "      "|"           
        "ที่อยู่บรรทัดที่ 1"      "|"           
        "ที่อยู่บรรทัดที่ 2"      "|"           
        "ที่อยู่บรรทัดที่ 3"      "|"           
        "ที่อยู่บรรทัดที่ 4"      "|"           
        "รหัสไปรษณีย์      "      "|"           
        "province code     "      "|"           
        "district code     "      "|"           
        "sub district code "      "|"           
        "เบี้ยก่อนภาษีอากร "      "|"           
        "อากร              "      "|"           
        "ภาษี              "      "|"           
        "คอมมิชชั่น 1      "      "|"           
        "คอมมิชชั่น 2 (co-broker)  "            "|" 
        "Cover Type (ประเภทความคุ้มครอง)     "  "|" 
        "Garage (ประเภทการซ่อม ซ่อมอู่/ซ่อมห้าง)"  "|"
        "Spacial Equipment Flag (A/Blank)  "       "|"
        "Inspection       "               "|"
        "รหัสรถภาคสมัครใจ (110/120/320)"  "|"
        "ลักษณะการใช้รถ        "   "|"
        "Redbook               "   "|"
        "ยี่ห้อรถ              "   "|"
        "ชื่อรุ่นรถ            "   "|"
        "ชื่อรุ่นย่อยรถ        "   "|"
        "ปีรุ่นรถ              "   "|"
        "หมายเลขตัวถัง         "   "|"
        "หมายเลขเครื่อง        "   "|"
        "หมายเลขเครื่อง2       "   "|"
        "จำนวนที่นั่ง (รวมผู้ขับขี่)   "  "|"
        "ปริมาตรกระบอกสูบ (CC) "   "|"
        "น้ำหนัก               "   "|"
        "Kilowatt              "   "|"
        "รหัสแบบตัวถัง         "   "|"
        "ป้ายแดง (Y/N)         "   "|"
        "ปีที่จดทะเบียน        "   "|"
        "เลขทะเบียนรถ          "   "|"
        "จังหวัดที่จดทะเบียน   "   "|"
        "Group Car (กลุ่มรถ)    "  "|"
        "Color (สี)             "  "|"
        "Fule (เชื้อเพลิง)      "  "|"
        "Driver Number          "  "|"
        "คำนำหน้า               "  "|"
        "ชื่อ                   "  "|"
        "นามสกุล                "  "|"
        "เลขที่บัตรประชาชน      "  "|"
        "เพศ                    "  "|"
        "วันเกิด                "  "|"
        "ชื่ออาชีพ              "  "|"
        "เลขที่ใบอนุญาตขับขี่   "  "|"
        "วันที่ใบอนุญาต หมดอายุ "  "|"
        "consent ผู้ขับขี่      "  "|"
        "ระดับพฤติกรรมการขับขี่ "  "|"
        "คำนำหน้า   "              "|"
        "ชื่อ       "              "|"
        "นามสกุล    "              "|"
        "เลขที่บัตรประชาชน      "  "|"
        "เพศ        "              "|"
        "วันเกิด    "              "|"
        "ชื่ออาชีพ  "              "|"
        "เลขที่ใบอนุญาตขับขี่   "  "|"
        "วันที่ใบอนุญาต หมดอายุ "  "|"
        "consent ผู้ขับขี่      "  "|"
        "ระดับพฤติกรรมการขับขี่ "  "|"
        "คำนำหน้า   "              "|"
        "ชื่อ       "              "|"
        "นามสกุล    "              "|"
        "เลขที่บัตรประชาชน      "  "|"
        "เพศ        "              "|"
        "วันเกิด    "              "|"
        "ชื่ออาชีพ  "              "|"
        "เลขที่ใบอนุญาตขับขี่   "  "|"
        "วันที่ใบอนุญาต หมดอายุ "  "|"
        "consent ผู้ขับขี่      "  "|"
        "ระดับพฤติกรรมการขับขี่ "  "|"
        "คำนำหน้า  "         "|"
        "ชื่อ      "         "|"
        "นามสกุล   "         "|"
        "เลขที่บัตรประชาชน " "|"
        "เพศ       "         "|"
        "วันเกิด   "         "|"
        "ชื่ออาชีพ "         "|"
        "เลขที่ใบอนุญาตขับขี่   " "|"
        "วันที่ใบอนุญาต หมดอายุ " "|"
        "consent ผู้ขับขี่      " "|"
        "ระดับพฤติกรรมการขับขี่ " "|"
        "คำนำหน้า   "             "|"
        "ชื่อ       "             "|"
        "นามสกุล    "             "|"
        "เลขที่บัตรประชาชน "      "|"
        "เพศ        "             "|"
        "วันเกิด    "             "|"
        "ชื่ออาชีพ  "             "|"
        "เลขที่ใบอนุญาตขับขี่   " "|"
        "วันที่ใบอนุญาต หมดอายุ " "|"
        "consent ผู้ขับขี่ "      "|"
        "ระดับพฤติกรรมการขับขี่ " "|"
        "Base Premium Plus "   "|"
        "Sum Insured Plus  "   "|"
        "RS10 Amount       "   "|"
        "TPBI / person     "   "|"
        "TPBI / occurrence "   "|"
        "TPPD              "   "|"
        "Deduct / OD       "   "|"
        "Deduct /Add OD    "   "|"
        "Deduct / PD       "   "|"
        "Market Value EV   "   "|"
        "วงเงินทุนประกัน   "   "|"
        "PA1.1 / driver    "   "|"
        "PA1.1 no.of passenger  " "|"
        "PA1.1 / passenger "      "|"
        "PA1.2 / driver    "      "|"
        "PA1.2 no.of passenger  " "|"
        "PA1.2 / passenger"       "|"
        "PA2    "         "|"
        "PA3    "         "|"
        "Base Premium "   "|"
        "Unname "         "|"
        "Name   "         "|"
        "TPBI / person Amount   " "|"
        "TPBI / Accident Amount " "|"
        "TPPD Amount   "         "|"
        "Deduct / OD Amount  "   "|"
        "Add / OD Amount     "   "|"
        "Deduct / PD Amount  "   "|"
        "RY01 Amount     "       "|"
        "RY01 Amount (412)   "   "|"
        "RY01 Amount (413)   "   "|"
        "RY01 Amount (414)   "   "|"
        "RY02 Amount   "         "|"
        "RY03 Amount   "         "|"
        "Fleet%        "         "|"
        "NCB%          "         "|"
        "Load Claim%   "         "|"
        "Other Disc.%  "         "|"
        "CCTV%         "         "|"
        "Walkin Disc.% "         "|"
        "Fleet Amount  "         "|"
        "NCB Amount    "         "|"
        "Load Claim Amount   "   "|"
        "Other Disc. Amount  "   "|"
        "CCTV Amount   "         "|"
        "Walk in Disc. Amount"   "|"
        "เบี้ยสุทธิ    "         "|"
        "Stamp Duty    "         "|"
        "VAT           "         "|"
        "Commission %  "         "|"
        "Commission Amount   "   "|"
        "Agent Code co-broker (รหัสตัวแทน) "  "|"
        "Commission % co-broker      "  "|" 
        "Commission Amount co-broker "  "|" 
        "Package (Attach Coverage)   "  "|" 
        "Dangerous Object 1  "          "|" 
        "Dangerous Object 2  "          "|" 
        "Sum Insured    "               "|" 
        "Rate%          "               "|" 
        "Fleet%         "               "|" 
        "NCB%           "               "|" 
        "Discount%      "               "|" 
        "Walkin Disc.%  "               "|" 
        "Premium Attach Coverage"       "|" 
        "Discount Fleet "               "|" 
        "Discount NCB   "               "|" 
        "Other Discount "               "|" 
        "Walk in Disc. Amount"          "|" 
        "Net Premium    "               "|" 
        "Stamp Duty     "               "|" 
        "VAT            "               "|" 
        "Commission Amount   "          "|" 
        "Commission Amount co-broker "  "|" 
        "Claim Text         "           "|" 
        "Claim Amount       "           "|" 
        "Claim Count Fault  "           "|" 
        "Claim Count Fault Amount"      "|" 
        "Claim Count Good        "      "|" 
        "Claim Count Good Amount "      "|" 
        "Loss Ratio % (Not TP)   "      "|" 
        "Compulsory Policy Number (เลขที่กรมธรรม์ พรบ.) " "|"
        "Effective Date (วันที่เริ่มความคุ้มครอง พรบ.)  " "|"
        "Expiry Date (วันที่สิ้นสุดความคุ้มครอง พรบ.)   " "|"
        "Barcode No.                       "        "|" 
        "Compulsory Class (รหัส พรบ.)      "        "|" 
        "Compulsory Walk In Discount %     "        "|" 
        "Compulsory Walk In Discount Amount"        "|" 
        "เบี้ยสุทธิ พ.ร.บ. กรณี กรมธรรม์ซื้อควบ  "  "|" 
        "Stamp Duty   "          "|"
        "VAT          "          "|"
        "Commission % "          "|"
        "Commission Amount  "    "|"
        "เลขที่แบตเตอรี่    "    "|"
        "ปีแบตฯ       "          "|"
        "ราคาแบตฯ     "          "|"
        "ทุนประกันแบตฯ"          "|"
        "Rate         "          "|"
        "Premium      "          "|"
        "เลขที่เครื่องชาร์จ "    "|"
        "ราคาเครื่องชาร์จ   "    "|"
        "Rate         "          "|"
        "Premium      "          SKIP .
      RUN proc_fileload1.
      OUTPUT STREAM ns3 CLOSE.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_fileload1 C-Win 
PROCEDURE Proc_fileload1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_count AS INTE INIT 0.
FOR EACH wdetail WHERE wdetail.pass <> "N" NO-LOCK .
   ASSIGN fi_process = "Export Data file Load : " + wdetail.chasno + ".... "  .
   DISP fi_process WITH FRAME fr_main.

   ASSIGN n_count = n_count + 1.
   PUT STREAM ns3                    
        n_count                "|"    /*A64-0355*/
        wdetail.itemno         "|"
        wdetail.policyno       FORMAT "x(12)"  "|"
        wdetail.n_branch       "|"
        wdetail.agent          "|"
        wdetail.producer       "|"
        wdetail.n_delercode    "|"
        wdetail.fincode        "|"
        wdetail.appenno        "|"
        wdetail.salename       "|"
        wdetail.srate          "|"
        wdetail.comdat         "|"
        wdetail.expdat         "|"
        wdetail.agreedat       "|"
        wdetail.firstdat       "|"
        wdetail.packcod        "|"
        wdetail.camp_no        "|"
        wdetail.campen         "|"
        wdetail.specon         "|"
        wdetail.product        "|"
        wdetail.promo          "|"
        wdetail.rencnt         "|"
        wdetail.prepol         "|"
        wdetail.txt1       FORMAT  "x(100)"   "|"
        wdetail.txt2       FORMAT  "x(100)"   "|"
        wdetail.txt3       FORMAT  "x(100)"   "|"
        wdetail.txt4       FORMAT  "x(100)"   "|"
        wdetail.txt5       FORMAT  "x(100)"   "|"
        wdetail.txt6       FORMAT  "x(100)"   "|"
        wdetail.txt7       FORMAT  "x(100)"   "|"
        wdetail.txt8       FORMAT  "x(100)"   "|"
        wdetail.txt9       FORMAT  "x(100)"   "|"
        wdetail.txt10      FORMAT  "x(100)"   "|"
        wdetail.memo1      FORMAT  "x(150)"   "|"
        wdetail.memo2      FORMAT  "x(150)"   "|"
        wdetail.memo3      FORMAT  "x(150)"   "|"
        wdetail.memo4      FORMAT  "x(150)"   "|"
        wdetail.memo5      FORMAT  "x(150)"   "|"
        wdetail.memo6      FORMAT  "x(150)"   "|"
        wdetail.memo7      FORMAT  "x(150)"   "|"
        wdetail.memo8      FORMAT  "x(150)"   "|"
        wdetail.memo9      FORMAT  "x(150)"   "|"
        wdetail.memo10     FORMAT  "x(150)"   "|"
        wdetail.accdata1   FORMAT  "x(100)"   "|"
        wdetail.accdata2   FORMAT  "x(100)"   "|"
        wdetail.accdata3   FORMAT  "x(100)"   "|"
        wdetail.accdata4   FORMAT  "x(100)"   "|"
        wdetail.accdata5   FORMAT  "x(100)"   "|"
        wdetail.accdata6   FORMAT  "x(100)"   "|"
        wdetail.accdata7   FORMAT  "x(100)"   "|"
        wdetail.accdata8   FORMAT  "x(100)"   "|"
        wdetail.accdata9   FORMAT  "x(100)"   "|"
        wdetail.accdata10  FORMAT  "x(100)"   "|"
        wdetail.compul     "|"
        wdetail.insref     "|" /* A64-0355*/
        wdetail.instyp     "|"
        wdetail.inslang    "|"
        wdetail.tiname     "|"
        wdetail.insnam    format "x(100)"   "|"
        wdetail.lastname  format "x(100)"   "|"
        wdetail.icno         "|"
        wdetail.insbr        "|"
        wdetail.occup        "|"
        wdetail.addr      format "x(60)"   "|"
        wdetail.tambon    format "x(60)"   "|"
        wdetail.amper     format "x(60)"   "|"
        wdetail.country   format "x(60)"   "|"
        wdetail.post         "|"
        wdetail.provcod      "|"
        wdetail.distcod      "|"
        wdetail.sdistcod     "|"
        wdetail.jpae         "|"  /*A64-0355*/      
        wdetail.jpjtl        "|"  /*A64-0355*/      
        wdetail.jpts         "|"  /*A64-0355*/      
        wdetail.gender       "|"
        wdetail.tele1        "|"
        wdetail.tele2        "|"
        wdetail.mail1    format "x(50)"    "|"
        wdetail.mail2    format "x(50)"    "|"
        wdetail.mail3    format "x(50)"    "|"
        wdetail.mail4    format "x(50)"    "|"
        wdetail.mail5    format "x(50)"    "|"
        wdetail.mail6    format "x(50)"    "|"
        wdetail.mail7    format "x(50)"    "|"
        wdetail.mail8    format "x(50)"    "|"
        wdetail.mail9    format "x(50)"    "|"
        wdetail.mail10   format "x(50)"    "|"
        wdetail.fax       "|"
        wdetail.lineID   FORMAT "x(50)"    "|"
        wdetail.name2    format "x(70)"   "|"
        wdetail.name3    format "x(70)"   "|"
        wdetail.benname  format "x(70)"   "|"
        wdetail.payercod     "|"
        wdetail.vatcode      "|"
        wdetail.instcod1     "|"
        wdetail.insttyp1     "|"
        wdetail.insttitle1   "|"
        wdetail.instname1   format "X(50)"  "|"
        wdetail.instlname1  format "X(50)"  "|"
        wdetail.instic1      "|"
        wdetail.instbr1      "|"
        wdetail.instaddr11 format "X(50)"   "|"
        wdetail.instaddr21 format "X(50)"   "|"
        wdetail.instaddr31 format "X(50)"  "|"
        wdetail.instaddr41 format "X(50)"   "|"
        wdetail.instpost1     "|"
        wdetail.instprovcod1  "|"
        wdetail.instdistcod1  "|"
        wdetail.instsdistcod1 "|"
        wdetail.instprm1      "|"
        wdetail.instrstp1     "|"
        wdetail.instrtax1     "|"
        wdetail.instcomm01    "|"
        wdetail.instcomm12    "|"
        wdetail.instcod2      "|"
        wdetail.insttyp2      "|"
        wdetail.insttitle2    "|"
        wdetail.instname2     format "X(50)"   "|"
        wdetail.instlname2    format "X(50)"   "|"
        wdetail.instic2       "|"
        wdetail.instbr2       "|"
        wdetail.instaddr12  format "X(50)"   "|"
        wdetail.instaddr22  format "X(50)"   "|"
        wdetail.instaddr32  format "X(50)"   "|"
        wdetail.instaddr42  format "X(50)"   "|"
        wdetail.instpost2     "|"
        wdetail.instprovcod2  "|"
        wdetail.instdistcod2  "|"
        wdetail.instsdistcod2 "|"
        wdetail.instprm2      "|"
        wdetail.instrstp2     "|"
        wdetail.instrtax2     "|"
        wdetail.instcomm02    "|"
        wdetail.instcomm22    "|"
        wdetail.instcod3      "|"
        wdetail.insttyp3      "|"
        wdetail.insttitle3    "|"
        wdetail.instname3     format "X(50)"   "|"
        wdetail.instlname3    format "X(50)"   "|"
        wdetail.instic3       "|"
        wdetail.instbr3       "|"
        wdetail.instaddr13    format "X(50)"   "|"
        wdetail.instaddr23    format "X(50)"   "|"
        wdetail.instaddr33    format "X(50)"   "|"
        wdetail.instaddr43    format "X(50)"   "|"
        wdetail.instpost3     "|"
        wdetail.instprovcod3  "|"
        wdetail.instdistcod3  "|"
        wdetail.instsdistcod3 "|"
        wdetail.instprm3     "|"
        wdetail.instrstp3    "|"
        wdetail.instrtax3    "|"
        wdetail.instcomm03   "|"
        wdetail.instcomm23   "|"
        wdetail.covcod       "|"
        wdetail.garage       "|"
        wdetail.special      "|"
        wdetail.inspec       "|"
        wdetail.class70      "|"
        wdetail.vehuse       "|"  /*A64-0355*/
        wdetail.redbook      "|"  /*A65-0079*/
        wdetail.brand     format "X(50)"     "|"
        wdetail.model     format "X(50)"     "|"
        wdetail.submodel  format "X(50)"     "|"
        wdetail.yrmanu      "|"
        wdetail.chasno      "|"
        wdetail.engno         "|"
        wdetail.eng_no2     "|" /*A67-0029*/
        wdetail.seat        "|"
        wdetail.engcc       "|"
        wdetail.weight      "|"
        wdetail.watt        "|"
        wdetail.body        "|"
        wdetail.ntype        "|"
        wdetail.re_year      "|"
        wdetail.vehreg       "|"
        wdetail.re_country   "|"
        wdetail.cargrp       "|"
        wdetail.colorcar     "|"
        wdetail.fule         "|"
        wdetail.drivnam      "|"
        wdetail.ntitle1      "|"
        wdetail.drivername1 format "X(50)"  "|"
        wdetail.dname2      format "X(50)"  "|"
        wdetail.dicno       "|" 
        wdetail.dgender1    "|" 
        wdetail.dbirth      "|" 
        wdetail.doccup      format "X(50)"  "|"
        wdetail.ddriveno    "|" 
        wdetail.drivexp1    "|" 
        wdetail.dconsen1    "|" 
        wdetail.dlevel1     "|" 
        wdetail.ntitle2     "|" 
        wdetail.drivername2 format "X(50)"  "|"
        wdetail.ddname1     format "X(50)"  "|"
        wdetail.ddicno       "|"
        wdetail.dgender2     "|"
        wdetail.ddbirth      "|"
        wdetail.ddoccup     format "X(50)"  "|"
        wdetail.dddriveno    "|"
        wdetail.drivexp2     "|"
        wdetail.dconsen2     "|"
        wdetail.dlevel2      "|"
        wdetail.ntitle3      "|"
        wdetail.dname3     format "X(50)"   "|"
        wdetail.dlname3    format "X(50)"   "|"
        wdetail.dicno3       "|"
        wdetail.dgender3     "|"
        wdetail.dbirth3      "|"
        wdetail.doccup3    format "X(50)"   "|"
        wdetail.ddriveno3    "|"
        wdetail.drivexp3     "|"
        wdetail.dconsen3     "|"
        wdetail.dlevel3      "|"
        wdetail.ntitle4      "|"
        wdetail.dname4     format "X(50)"   "|"
        wdetail.dlname4    format "X(50)"   "|"
        wdetail.dicno4       "|"
        wdetail.dgender4     "|"
        wdetail.dbirth4      "|"
        wdetail.doccup4    format "X(50)"   "|"
        wdetail.ddriveno4    "|"
        wdetail.drivexp4     "|"
        wdetail.dconsen4     "|"
        wdetail.dlevel4      "|"
        wdetail.ntitle5      "|"
        wdetail.dname5     format "X(50)"   "|"
        wdetail.dlname5    format "X(50)"   "|"
        wdetail.dicno5       "|"
        wdetail.dgender5     "|"
        wdetail.dbirth5      "|"
        wdetail.doccup5    format "X(50)"   "|"
        wdetail.ddriveno5    "|"
        wdetail.drivexp5     "|"
        wdetail.dconsen5     "|"
        wdetail.dlevel5      "|"
        wdetail.baseplus     "|"
        wdetail.siplus       "|"
        wdetail.rs10         "|"
        wdetail.comper       "|"
        wdetail.comacc       "|"
        wdetail.deductpd     "|"
        wdetail.DOD          "|"
        wdetail.DOD1         "|"
        wdetail.DPD          "|" 
        wdetail.maksi        "|"
        wdetail.tpfire       "|"
        wdetail.NO_41        "|"
        wdetail.ac2          "|"
        wdetail.ac4          "|"
        wdetail.ac5          "|"
        wdetail.ac6          "|"
        wdetail.ac7          "|"
        wdetail.NO_42        "|"
        wdetail.NO_43        "|"
        wdetail.base         "|"
        wdetail.unname       "|"
        wdetail.nname        "|"
        wdetail.tpbi         "|"
        wdetail.bi2          "|"
        wdetail.tppd         "|"
        wdetail.dodamt       "|"
        wdetail.dod1amt      "|"
        wdetail.dpdamt       "|"
        wdetail.ry01         "|"
        wdetail.ry412        "|"
        wdetail.ry413        "|"
        wdetail.ry414        "|"
        wdetail.ry02         "|"
        wdetail.ry03         "|"
        wdetail.fleet        "|"
        wdetail.ncb          "|"
        wdetail.claim        "|"
        wdetail.dspc         "|"
        wdetail.cctv         "|"
        wdetail.dstf         "|"
        wdetail.fleetprem    "|"   
        wdetail.ncbprem      "|"   
        wdetail.clprem       "|"
        wdetail.dspcprem     "|"
        wdetail.cctvprem     "|"
        wdetail.dstfprem     "|"
        wdetail.premt        "|"
        wdetail.rstp_t       "|"
        wdetail.rtax_t       "|"
        wdetail.comper70     "|"
        wdetail.comprem70    "|"
        wdetail.agco70       "|"
        wdetail.comco_per70  "|"
        wdetail.comco_prem70 "|"
        wdetail.dgpackge     "|"
        wdetail.danger1      "|"
        wdetail.danger2      "|"
        wdetail.dgsi         "|"
        wdetail.dgrate       "|"
        wdetail.dgfeet       "|"
        wdetail.dgncb        "|"
        wdetail.dgdisc       "|"
        wdetail.dgwdisc      "|"
        wdetail.dgatt        "|"
        wdetail.dgfeetprm    "|"
        wdetail.dgncbprm     "|"
        wdetail.dgdiscprm    "|"
        wdetail.dgWdiscprm   "|"
        wdetail.dgprem       "|"
        wdetail.dgrstp_t     "|"
        wdetail.dgrtax_t     "|"
        wdetail.dgcomper     "|"
        wdetail.dgcomprem    "|"
        wdetail.cltxt        "|"
        wdetail.clamount     "|" 
        wdetail.faultno      "|"
        wdetail.faultprm     "|" 
        wdetail.goodno       "|"
        wdetail.goodprm      "|"
        wdetail.loss         "|"
        wdetail.compolusory  "|"
        wdetail.comdat72     "|"
        wdetail.expdat72     "|"
        wdetail.barcode      "|"
        wdetail.class72      "|"
        wdetail.dstf72       "|"
        wdetail.dstfprem72   "|"
        wdetail.premt72      "|"
        wdetail.rstp_t72     "|"
        wdetail.rtax_t72     "|"
        wdetail.comper72     "|"
        wdetail.comprem72    "|"
        wdetail.battno       "|"
        wdetail.battyr       "|"
        wdetail.battprice    "|"
        wdetail.battsi       "|" 
        wdetail.battrate     "|" 
        wdetail.battprm      "|" 
        wdetail.chargno      "|" 
        wdetail.chargsi      "|" 
        wdetail.chargrate    "|" 
        wdetail.chargprm      SKIP.
    END. 
                    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_sic_exp2 C-Win 
PROCEDURE proc_sic_exp2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
loop_conexp:
REPEAT:
    FORM
        gv_id  LABEL " User Id " colon 35 SKIP
        nv_pwd LABEL " Password" colon 35 BLANK
        WITH FRAME nf00 CENTERED ROW 10 SIDE-LABELS OVERLAY width 80
        TITLE   " Connect DB Expiry System"  . 
    
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
         CONNECT expiry -H TMSTH -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR.        /*HO*/
         /*CONNECT expiry -H devserver -S expiry  -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR. /*db test.*/  */
         
          CLEAR FRAME nf00.
          HIDE FRAME nf00.
          /*RETURN.*/ 
          IF NOT CONNECTED("sic_exp") THEN NEXT loop_conexp.
          ELSE DO:
               LEAVE loop_conexp.
               RETURN.
          END.
       END.
       IF FRAME-FIELD = "gv_id" OR FRAME-FIELD = "nv_pwd" AND LASTKEY = KEYCODE("F4") THEN DO:
            CLEAR FRAME nf00.
            HIDE FRAME nf00.
            LEAVE loop_conexp.
            RETURN.
       END.
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_ExportXLS C-Win 
PROCEDURE Pro_ExportXLS :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wdetail2   NO-LOCK WHERE wdetail2.head = "D"  .
    ASSIGN fi_process = "Convert Date wdetail2: " + wdetail2.chasno + "...." .
    DISP fi_process WITH FRAME fr_main.
    IF tg_chk = NO  THEN DO:
        ASSIGN 
        wdetail2.senddat      = IF trim(wdetail2.senddat) = "00000000" THEN ""  
                                ELSE SUBSTR(wdetail2.senddat,7,2 ) + "/" + SUBSTR(wdetail2.senddat,5,2 ) + "/" + SUBSTR(wdetail2.senddat,1,4 )
        wdetail2.effecdat     = IF trim(wdetail2.effecdat) = "00000000" THEN ""  
                                ELSE SUBSTR(wdetail2.effecdat,7,2 ) + "/" + SUBSTR(wdetail2.effecdat,5,2 ) + "/" + SUBSTR(wdetail2.effecdat,1,4 )
        wdetail2.comeffecdat  = IF trim(wdetail2.comeffecdat) = "00000000" THEN ""  
                                ELSE SUBSTR(wdetail2.comeffecdat,7,2 ) + "/" + SUBSTR(wdetail2.comeffecdat,5,2 ) + "/" + SUBSTR(wdetail2.comeffecdat,1,4 )
        wdetail2.norcovdat    = IF trim(wdetail2.norcovdat) = "00000000" THEN ""   
                                ELSE SUBSTR(wdetail2.norcovdat,7,2 ) + "/" + SUBSTR(wdetail2.norcovdat,5,2 ) + "/" + SUBSTR(wdetail2.norcovdat,1,4 )
        wdetail2.norcovenddat = IF trim(wdetail2.norcovenddat) = "00000000" THEN "" 
                                ELSE SUBSTR(wdetail2.norcovenddat,7,2 ) + "/" + SUBSTR(wdetail2.norcovenddat,5,2 ) + "/" + SUBSTR(wdetail2.norcovenddat,1,4 )  
        wdetail2.covamount    = string(inte(SUBSTR(wdetail2.covamount,1,11)),">>>,>>>,>>9") + "." + SUBSTR(wdetail2.covamount,12,2)
        wdetail2.grpssprem    = string(inte(SUBSTR(wdetail2.grpssprem,1,9)),">>>,>>>,>>9")  + "." + SUBSTR(wdetail2.grpssprem,10,2)
        wdetail2.comamount    = string(inte(substr(wdetail2.comamount,1,11)),">>>,>>>,>>9") + "." + substr(wdetail2.comamount,12,2)
        wdetail2.comprem      = string(inte(substr(wdetail2.comprem,1,9)),">>>,>>>,>>9") + "." + substr(wdetail2.comprem,10,2) .
    END.
   
END.

IF INDEX(fi_outfile,".XLS") = 0  THEN DO:
    nv_output = fi_outfile + ".XLS".
END.
ELSE DO:
    nv_output = substr(fi_outfile,1,INDEX(fi_outfile,".XLS") - 1 ) + ".XLS".
END.
ASSIGN fi_process = "Export File Excel..." .
DISP fi_process WITH FRAME fr_main.
RUN wgw/wgwtibexc.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

