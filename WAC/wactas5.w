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
program id   :  wuwtstex.w
  program name :  Load text file HCT to excel file     
  create by    :  Kridtiya i. A52-0172  21/07/2009    
  copy write   : wuwnotex.w                                             */
/*Modify by    : Kridtiya i. A53-0027  15/01/2010
                 ปรับโปรแกรมให้เช็คค่า field branch ที่table insure จากเดิม
                 เป็นการให้ค่าแบบตรงจาก โปรแกรม-------------------------*/
/*modify by   : Kridtiya i. A53-0156 date . 19/04/2010  
             เปลี่ยนชื่อบริษัทจากและ / หรือ บริษัท ไทยออโต้เซลส์ จำกัด 
             เป็น และ/ หรือ บริษัท ตรีเพชรอีซูซุลิสซิ่ง จำกัด เปลี่ยน TAS เห็น TIL */
/*Modify by :Kridtiya i. A59-0362 date. 10/11/2016 เพิ่มส่วนการแปลงไฟล์แยกตาม รุ่นรถ*/
/*Modify by :Kridtiya i. A59-0597 date. 10/12/2016 ปรับ format ddmmyyyy เป็น dd/nn/yyyy*/
/************************************************************************/
CREATE WIDGET-POOL.
/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

def  stream ns1.

DEF VAR num AS DECI INIT 0.
DEF VAR expyear AS DECI FORMAT "9999" .

/*DEFINE VAR nv_daily     AS CHARACTER FORMAT "X(2465)"     INITIAL ""  NO-UNDO.*/

DEFINE VAR nv_daily     AS CHARACTER FORMAT "X"     INITIAL ","  NO-UNDO.
DEFINE VAR nv_reccnt   AS  INT  INIT  0.
DEFINE VAR nv_completecnt    AS   INT   INIT  0.
DEFINE VAR nv_enttim   AS  CHAR          INIT  "".
def    var  nv_export    as  char  init  ""  format "X(8)".
def  stream  ns2.

DEFINE NEW SHARED WORKFILE wdetail NO-UNDO
    FIELD head            AS CHAR FORMAT "X(30)"      INIT ""  /*เลขที่ใบคำขอ*/
    FIELD insure          AS CHAR FORMAT "X(60)"      INIT ""  /*วันที่ใบคำขอ*/
    FIELD policymain      AS CHAR FORMAT "X(26)"      INIT ""  /*เลขที่รับแจ้ง*/
    FIELD policy          AS CHAR FORMAT "X(26)"      INIT ""  /*เลขที่รับแจ้ง*/
    FIELD polcomp         AS CHAR FORMAT "X(26)"      INIT ""  /*วันที่เริ่มคุ้มครอง*/
    FIELD engine          AS CHAR FORMAT 'x(26)'      INIT ""  /*วันที่สิ้นสุด*/
    FIELD chass           AS CHAR FORMAT 'x(26)'      INIT ""  /*รหัสบริษัทประกันภัย*/  
    FIELD contract        AS CHAR FORMAT "X(20)"      INIT ""  /*ประเภทรถ*/ 
    FIELD engc            AS CHAR FORMAT 'x(12)'      INIT ""  /*ประเภทการขาย*/
    FIELD comdat          AS CHAR FORMAT "99999999"   INIT ""  /*ประเภทแคมเปญ*/
    FIELD grossprem       AS CHAR FORMAT "9999999999" INIT ""       /*จำนวนเงินให้ฟรี*/
    FIELD CompGrossPrem   AS CHAR FORMAT "9999999999"  INIT ""      /*ประเภทความคุ้มครอง*/
    FIELD NetPrem         AS CHAR FORMAT "9999999999"  INIT ""      /*ประเภทประกัน*/
    FIELD CompNetPrem     AS CHAR FORMAT "9999999999"  INIT ""      /*ประเภทการซ่อม*/
    FIELD tax             AS CHAR FORMAT "9999999999" INIT ""       /*ผู้บันทึก*/
    FIELD NetPayment      AS CHAR FORMAT "9999999999" INIT ""      /*คำนำหน้า*/
    FIELD nSTATUS         AS CHAR FORMAT "x(20)"      INIT "" 
    FIELD Name2           AS CHAR FORMAT "x(60)"      INIT "" 
    FIELD VatCode         AS CHAR FORMAT "9999999999" INIT "" 
    FIELD Producer        AS CHAR FORMAT "x(10)"      INIT "" 
    FIELD Brand_Model     AS CHAR FORMAT "x(60)"      INIT "" 
    .

DEF VAR n_type AS INTE FORMAT "9" . /*---add by sarinya c. A59-0362----*/
    
DEF VAR nv_accdat   AS DATE FORMAT "99/99/9999"              NO-UNDO.
DEF VAR nv_comdat   AS DATE FORMAT "99/99/9999"              NO-UNDO.
DEF VAR nv_expdat   AS DATE FORMAT "99/99/9999"              NO-UNDO.
DEF VAR nv_comchr   AS CHAR .   
DEF VAR nv_dd       AS INT  FORMAT "99".
DEF VAR nv_mm       AS INT  FORMAT "99".
DEF VAR nv_yy       AS INT  FORMAT "9999".
DEF VAR nv_cpamt1   AS DECI INIT 0. 
DEF VAR nv_cpamt2   AS DECI INIT 0.
DEF VAR nv_cpamt3   AS DECI INIT 0.
DEF VAR nv_insamt1  AS DECI INIT 0. 
DEF VAR nv_insamt2  AS DECI INIT 0.
DEF VAR nv_insamt3  AS DECI INIT 0.
DEF VAR nv_premt1   AS DECI INIT 0. 
DEF VAR nv_premt2   AS DECI INIT 0.
DEF VAR nv_premt3   AS DECI INIT 0.
DEF VAR nv_name1    AS CHAR INIT ""   Format "X(30)".
DEF VAR nv_ntitle   AS CHAR INIT ""   Format  "X(10)". 
DEF VAR nv_titleno  AS INT  INIT 0    .
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

  /*------- sarinya c. A59-0362 --------*/ 
                  
DEF VAR np_policy   AS CHAR FORMAT "x(26)" INIT "" .                     
DEF VAR head           AS CHAR  FORMAT "X(30)"        INIT "" .           
DEF VAR insure         AS CHAR  FORMAT "X(60)"        INIT "" .           
DEF VAR policymain     AS CHAR  FORMAT "X(26)"        INIT "" .           
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
DEF VAR numberline1   AS CHAR FORMAT "9999999999"  INIT "" .
DEF VAR numberline    AS INTE INIT 0.
DEF VAR np_Name2      AS CHAR INIT "" FORMAT "x(80)" . /* add sarinya c. A59-0362 */
DEF VAR np_VatCode    AS CHAR INIT "" FORMAT "x(10)" . /* add sarinya c. A59-0362 */
DEF VAR np_cedpol     AS CHAR FORMAT "x(20)" INIT "" .
DEF VAR np_stmpall    AS DECI INIT 0.
DEF VAR nv_netPremAll AS DECI INIT 0.
DEF VAR n_wh1         AS DECI INIT 0.
DEF VAR n_nettotel    AS DECI INIT 0.
DEF VAR nstmp70       AS DECI INIT 0.
DEF VAR nstmp72       AS DECI INIT 0.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_filename fi_outfile bu_ok fi_model ~
fi_producer ra_tax ra_type bu_file bu_exit fi_outfiletil fi_outfilemux ~
fi_outfileallnew fi_producertil fi_outfileoth RECT-76 RECT-77 RECT-79 
&Scoped-Define DISPLAYED-OBJECTS fi_filename fi_outfile fi_model ~
fi_producer ra_tax ra_type fi_outfiletil fi_outfilemux fi_outfileallnew ~
fi_producertil fi_outfileoth 

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

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(110)":U 
     VIEW-AS FILL-IN 
     SIZE 75 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_model AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_outfile AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 75 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_outfileallnew AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 75 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_outfilemux AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 75 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_outfileoth AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 75 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_outfiletil AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 75 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 17.5 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_producertil AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 17.5 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_tax AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "W/H TAX 1%(Oth)", 1,
"No W/H TAX 1%", 2,
"W/H TAX 1%(TIL ALL)", 3
     SIZE 57 BY 1
     BGCOLOR 18  NO-UNDO.

DEFINE VARIABLE ra_type AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "NEW", 1,
"OLD", 2,
"Match", 3,
"Oth", 4
     SIZE 47 BY 1
     BGCOLOR 18 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-76
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 111.5 BY 18.48
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-77
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 19.5 BY 1.95
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-79
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 108.5 BY 3.1.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_filename AT ROW 8.38 COL 30 COLON-ALIGNED NO-LABEL
     fi_outfile AT ROW 9.57 COL 30 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 17.33 COL 48
     fi_model AT ROW 5.52 COL 48 COLON-ALIGNED NO-LABEL
     fi_producer AT ROW 5.52 COL 30 COLON-ALIGNED NO-LABEL
     ra_tax AT ROW 4.43 COL 5 NO-LABEL
     ra_type AT ROW 3.19 COL 5 NO-LABEL
     bu_file AT ROW 8.38 COL 107.5
     bu_exit AT ROW 17.33 COL 57
     fi_outfiletil AT ROW 13.81 COL 30 COLON-ALIGNED NO-LABEL
     fi_outfilemux AT ROW 11.43 COL 30 COLON-ALIGNED NO-LABEL
     fi_outfileallnew AT ROW 12.62 COL 30 COLON-ALIGNED NO-LABEL
     fi_producertil AT ROW 6.76 COL 30 COLON-ALIGNED NO-LABEL
     fi_outfileoth AT ROW 14.95 COL 30 COLON-ALIGNED NO-LABEL
     "                   INPUT FILE :":30 VIEW-AS TEXT
          SIZE 26 BY 1 AT ROW 8.38 COL 5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     ": คำนวณ W/H TAX 1%  By Oth ,TILL คำนวณทุกรายการ" VIEW-AS TEXT
          SIZE 44.5 BY 1 AT ROW 4.43 COL 63
     "  CONVERT EXCEL FILE TO TEXT FILE":30 VIEW-AS TEXT
          SIZE 70.5 BY 1.05 AT ROW 1.62 COL 5.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "      OUT PUT FILE MU-X :" VIEW-AS TEXT
          SIZE 26 BY 1 AT ROW 11.43 COL 5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     ": New วันที่ 01/07/2559  :Old วันที่น้อยกว่า 01/07/2559" VIEW-AS TEXT
          SIZE 54.5 BY 1 AT ROW 3.19 COL 53.17
     "OUT PUT FILE ALL NEW :" VIEW-AS TEXT
          SIZE 26 BY 1 AT ROW 12.62 COL 5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "         OUT PUT FILE TIL :" VIEW-AS TEXT
          SIZE 26 BY 1 AT ROW 13.81 COL 5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "     OUT PUT FILE OTH.. :" VIEW-AS TEXT
          SIZE 26 BY 1 AT ROW 14.95 COL 5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "              OUT PUT FILE :" VIEW-AS TEXT
          SIZE 26 BY 1 AT ROW 9.57 COL 5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Producer && Model :" VIEW-AS TEXT
          SIZE 20 BY 1 AT ROW 5.52 COL 11.67
          BGCOLOR 8 FONT 6
     ": เงื่อนไขไฟล์ MU-X และ ALL-NEW" VIEW-AS TEXT
          SIZE 39.17 BY .95 AT ROW 5.52 COL 68.5
     "Producer && TIL :" VIEW-AS TEXT
          SIZE 20 BY 1 AT ROW 6.76 COL 11.67
          BGCOLOR 8 FONT 6
     ": เงื่อนไขไฟล์ TIL" VIEW-AS TEXT
          SIZE 39.17 BY .95 AT ROW 6.76 COL 68.5
     RECT-76 AT ROW 1.33 COL 2
     RECT-77 AT ROW 16.91 COL 46.5
     RECT-79 AT ROW 7.91 COL 4
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 112.83 BY 19.19
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
         HEIGHT             = 18.81
         WIDTH              = 112.83
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
        FILTERS   "Text .csv" "*.csv",
       "Text .slk" "*.slk" ,
       "Text file" "*"
                   
        MUST-EXIST
        USE-FILENAME
        UPDATE OKpressed.
      
    IF OKpressed = TRUE THEN DO:
         fi_filename  = cvData.
         IF ra_type = 3  THEN DO:
             IF r-INDEX(cvData,"/") <> 0 THEN DO:
                 ASSIGN 
                     fi_outfile       = ""
                     fi_outfilemux    = SUBSTRING(cvData,1,((r-INDEX(cvData,"/"))))  + "INS_STATEMENT_MU-X"    + ".csv" 
                     fi_outfileallnew = SUBSTRING(cvData,1,((r-INDEX(cvData,"/"))))  + "INS_STATEMENT_ALL-NEW" + ".csv" 
                     fi_outfiletil    = SUBSTRING(cvData,1,((r-INDEX(cvData,"/"))))  + "INS_STATEMENT_TIL"     + ".csv"  
                     fi_outfileoth    = SUBSTRING(cvData,1,((r-INDEX(cvData,"/"))))  + "INS_STATEMENT_OTHER"   + ".csv"  .
             END.
             ELSE IF r-INDEX(cvData,"\") <> 0 THEN DO:
                 ASSIGN 
                     fi_outfile       = ""
                     fi_outfilemux    = SUBSTRING(cvData,1,((r-INDEX(cvData,"\"))))  + "INS_STATEMENT_MU-X"    + ".csv"    
                     fi_outfileallnew = SUBSTRING(cvData,1,((r-INDEX(cvData,"\"))))  + "INS_STATEMENT_ALL-NEW" + ".csv"    
                     fi_outfiletil    = SUBSTRING(cvData,1,((r-INDEX(cvData,"\"))))  + "INS_STATEMENT_TIL"     + ".csv"    
                     fi_outfileoth    = SUBSTRING(cvData,1,((r-INDEX(cvData,"\"))))  + "INS_STATEMENT_OTHER"   + ".csv"  . 
             END.
         END.
         ELSE DO:
             ASSIGN
                 fi_outfile       = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))    +  "_Send.csv" /*.csv*/
                 fi_outfilemux    = ""
                 fi_outfileallnew = ""  
                 fi_outfiletil    = ""  
                 fi_outfileoth    = "".
         END.
         DISP fi_filename fi_outfile  fi_outfilemux   fi_outfileallnew fi_outfiletil    fi_outfileoth   WITH FRAME fr_main.     
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok C-Win
ON CHOOSE OF bu_ok IN FRAME fr_main /* Ok */
DO:
    /*
    For each  wdetail :
        DELETE  wdetail.
    END.
    INPUT FROM VALUE(fi_filename).
    REPEAT:
        CREATE wdetail.
        IMPORT DELIMITER "|" 
            /*wdetail.head   */       
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
            wdetail.NetPayment .    
    END.  /* repeat */
    */


IF      n_type = 1 THEN  Run Pro_createfile.     /* Match file new */    
ELSE IF n_type = 2 THEN  RUN Pro_createfile_old. /* Match file Old */  /*---add by Sarinya c. A59-0362----*/
ELSE IF n_type = 3 THEN  RUN Pro_createfile_Mat. /* Match file 4 file */  /*---add by Sarinya c. A59-0362----*/
                   ELSE  RUN Pro_createfile_oth.   /*---add by Sarinya c. A59-0362----*/

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


&Scoped-define SELF-NAME fi_model
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_model C-Win
ON LEAVE OF fi_model IN FRAME fr_main
DO:
    fi_model = INPUT fi_model.
    DISP fi_model WITH FRAM fr_main.
  
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


&Scoped-define SELF-NAME fi_outfileallnew
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outfileallnew C-Win
ON LEAVE OF fi_outfileallnew IN FRAME fr_main
DO:
  fi_outfile  =  Input  fi_outfile.
  Disp  fi_outfile with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_outfilemux
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outfilemux C-Win
ON LEAVE OF fi_outfilemux IN FRAME fr_main
DO:
  fi_outfile  =  Input  fi_outfile.
  Disp  fi_outfile with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_outfileoth
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outfileoth C-Win
ON LEAVE OF fi_outfileoth IN FRAME fr_main
DO:
  fi_outfile  =  Input  fi_outfile.
  Disp  fi_outfile with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_outfiletil
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outfiletil C-Win
ON LEAVE OF fi_outfiletil IN FRAME fr_main
DO:
  fi_outfile  =  Input  fi_outfile.
  Disp  fi_outfile with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer C-Win
ON LEAVE OF fi_producer IN FRAME fr_main
DO:
    fi_producer = INPUT fi_producer.
    DISP fi_producer WITH FRAM fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producertil
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producertil C-Win
ON LEAVE OF fi_producertil IN FRAME fr_main
DO:
    fi_producertil = INPUT fi_producertil.
    DISP fi_producertil WITH FRAM fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_tax
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_tax C-Win
ON VALUE-CHANGED OF ra_tax IN FRAME fr_main
DO:
  ra_tax = INPUT ra_tax.
  DISP ra_tax WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_type
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_type C-Win
ON VALUE-CHANGED OF ra_type IN FRAME fr_main
DO:
    /*---add A59-0362----*/
    ASSIGN 
        ra_type = INPUT ra_type
        n_type = ra_type.
    DISP ra_type WITH FRAME {&FRAME-NAME}. 
    /*---end A59-0362----*/
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
  
  gv_prgid = "wactas5".
  gv_prog  = "Convert Excel File TIL to Text file TAS".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).
  /*---add A59-0362----*/
  ASSIGN 
      ra_type        = 3
      ra_tax         = 1
      fi_producer    = "B3M0031"
      fi_producertil = "B3M0018"
      fi_model       = "MU-X"
      n_type         = ra_type.
  DISP ra_type ra_tax fi_producer fi_model fi_producertil  WITH FRAM fr_main.

  /*---end A59-0362----*/


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
  DISPLAY fi_filename fi_outfile fi_model fi_producer ra_tax ra_type 
          fi_outfiletil fi_outfilemux fi_outfileallnew fi_producertil 
          fi_outfileoth 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_filename fi_outfile bu_ok fi_model fi_producer ra_tax ra_type 
         bu_file bu_exit fi_outfiletil fi_outfilemux fi_outfileallnew 
         fi_producertil fi_outfileoth RECT-76 RECT-77 RECT-79 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
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
DEF VAR numberline1 AS CHAR FORMAT "9999999999"  INIT "" .
DEF VAR numberline  AS INTE INIT 0.
DEF VAR np_cedpol   AS CHAR FORMAT "x(20)" INIT "" .

For each  wdetail :
    DELETE  wdetail.
END.

INPUT FROM VALUE(fi_filename).
REPEAT:
    /*CREATE wdetail.*/
    IMPORT DELIMITER "|" 
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
        VatCode  .

    IF (head = "head") OR (head = "H") OR (head = "T") THEN 
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

    ELSE DO:
        FIND LAST wdetail WHERE wdetail.engc =  engc NO-ERROR NO-WAIT.
        IF NOT AVAIL wdetail THEN DO:
            CREATE wdetail.
            ASSIGN 
                wdetail.head            = head                                         
                wdetail.insure          = insure                                  
                wdetail.policy          = policy                                          
                wdetail.polcomp         = polcomp               
                wdetail.engine          = engine                                          
                wdetail.chass           = chass                        
                wdetail.contract        = contract                                        
                wdetail.engc            = engc                                   
                /*wdetail.comdat          = comdat  */                /*comment by kridtiya i. A59-0597*/                        
                wdetail.comdat          = substr(comdat,1,2) + "/" +  /*Add by kridtiya i. A59-0597*/  
                                          substr(comdat,3,2) + "/" +  /*Add by kridtiya i. A59-0597*/  
                                          substr(comdat,5)            /*Add by kridtiya i. A59-0597*/  
                wdetail.grossprem       = grossprem                             
                wdetail.CompGrossPrem   = CompGrossPrem                         
                wdetail.NetPrem         = NetPrem                               
                wdetail.CompNetPrem     = CompNetPrem                           
                wdetail.tax             = tax                                   
                wdetail.NetPayment      = NetPayment    
                wdetail.nSTATUS         = nSTATUS      
                wdetail.Name2           = Name2        
                wdetail.VatCode         = VatCode    .    
  /*      END.
        ELSE DO:
            ASSIGN 
                wdetail.head            = head                                         
                wdetail.insure          = insure                 
                        
                wdetail.engine          = engine                                          
                wdetail.chass           = chass                        
                wdetail.contract        = contract                                        
                wdetail.engc            = engc                                   
                wdetail.comdat          = comdat   

                wdetail.grossprem       = string(deci(wdetail.grossprem) + deci(grossprem))                             
                wdetail.CompGrossPrem   = string(deci(wdetail.CompGrossPrem) + deci(CompGrossPrem))                         
                wdetail.NetPrem         = string(deci(wdetail.NetPrem) + deci(NetPrem))                               
                wdetail.CompNetPrem     = string(deci(wdetail.CompNetPrem) + deci(CompNetPrem))                           
                wdetail.tax             = string(deci(wdetail.tax) + deci(tax))                                   
                wdetail.NetPayment      = string(deci(wdetail.NetPayment) + deci(NetPayment))    
                wdetail.nSTATUS         = nSTATUS      
                wdetail.Name2           = Name2        
                wdetail.VatCode         = VatCode    .
            IF SUBSTR(trim(wdetail.policymain),3,2)  = "70"   THEN 
                ASSIGN wdetail.polcomp         = polcomp .
            ELSE ASSIGN wdetail.policy  = policy .  */



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



If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".csv"  Then
    fi_outfile  =  Trim(fi_outfile) + ".csv"  . 
/*ASSIGN
    numberline1 = ""
    numberline = 0
nv_cnt   =   0
nv_row  =  1.*/

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
                                                                                                      
                                                         
/*FOR EACH wdetail WHERE wdetail.head = "D" NO-LOCK.*/   
FOR EACH wdetail WHERE wdetail.insure <> "" NO-LOCK.     

    IF  (index(wdetail.insure,"Customer") <> 0) THEN NEXT.
    ELSE DO:
    ASSIGN np_cedpol = ""
        np_policy  = "" 
        np_cedpol = wdetail.contract .


    /*IF np_cedpol = ""  THEN DO:
        IF (wdetail.policy <> "") AND (wdetail.contract = "") THEN DO:

            ASSIGN np_policy = substr(TRIM(wdetail.policy),1,12).

            FIND LAST uwm100 USE-INDEX uwm10001 WHERE 
                uwm100.policy = np_policy NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL uwm100 THEN  np_cedpol = uwm100.cedpol.
        END.
        ELSE DO: /* wdetail.polcomp */
            IF  (wdetail.contract = "") THEN DO:
                 ASSIGN np_policy = substr(TRIM(wdetail.polcomp),1,12).
                FIND LAST uwm100 USE-INDEX uwm10001 WHERE 
                    uwm100.policy = np_policy NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL uwm100 THEN  np_cedpol = uwm100.cedpol.
            END.
        END.
    END. */

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
              /*  deci(wdetail.comdat)              
                deci(wdetail.grossprem)
                deci(wdetail.CompGrossPrem)  
                deci(wdetail.NetPrem) 
                deci(wdetail.CompNetPrem) 
                deci(wdetail.tax)         
                deci(wdetail.NetPayment)            
                END.*/                            
    END.
END.

message "Export File  Complete"  view-as alert-box.

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


For each  wdetail :
    DELETE  wdetail.
END.

INPUT FROM VALUE(fi_filename).
REPEAT:
    /*CREATE wdetail.*/
    IMPORT DELIMITER "|" 
        head                                         
        insure                                
        policymain                            
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
        END.
        ELSE DO:
            ASSIGN 
                wdetail.head            = head                                         
                wdetail.insure          = insure                
                        
                wdetail.engine          = engine                                          
                wdetail.chass           = chass                        
                wdetail.contract        = contract                                        
                wdetail.engc            = engc                                   
                wdetail.comdat          = comdat 
                wdetail.grossprem       = string(deci(wdetail.grossprem) + deci(grossprem))                             
                wdetail.CompGrossPrem   = string(deci(wdetail.CompGrossPrem) + deci(CompGrossPrem))                         
                wdetail.NetPrem         = string(deci(wdetail.NetPrem) + deci(NetPrem))                               
                wdetail.CompNetPrem     = string(deci(wdetail.CompNetPrem) + deci(CompNetPrem))                           
                wdetail.tax             = string(deci(wdetail.tax) + deci(tax))                                   
                wdetail.NetPayment      = string(deci(wdetail.NetPayment) + deci(NetPayment))    
                wdetail.nSTATUS         = nSTATUS      
                wdetail.Name2           = Name2        
                wdetail.VatCode         = VatCode    .
            IF SUBSTR(trim(wdetail.policymain),3,2)  = "70"   THEN 
                ASSIGN wdetail.polcomp         = polcomp .
            ELSE ASSIGN wdetail.policy  = policy .
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


/*
If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".csv"  Then
    fi_outfile  =  Trim(fi_outfile) + ".csv"  . 
ASSIGN
    numberline1 = ""
    numberline = 0
nv_cnt   =   0
nv_row  =  1.

OUTPUT  TO VALUE(fi_outfile). 

EXPORT DELIMITER ","  
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
        "Status" .                                                        
                                                                                                      
                                                         
/*FOR EACH wdetail WHERE wdetail.head = "D" NO-LOCK.*/   
FOR EACH wdetail WHERE wdetail.insure <> "" NO-LOCK.     

    IF  (index(wdetail.insure,"Customer") <> 0) THEN NEXT.
    ELSE DO:
    ASSIGN np_cedpol = ""
        np_policy  = "" 
        np_cedpol = wdetail.contract .


    /*IF np_cedpol = ""  THEN DO:
        IF (wdetail.policy <> "") AND (wdetail.contract = "") THEN DO:

            ASSIGN np_policy = substr(TRIM(wdetail.policy),1,12).

            FIND LAST uwm100 USE-INDEX uwm10001 WHERE 
                uwm100.policy = np_policy NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL uwm100 THEN  np_cedpol = uwm100.cedpol.
        END.
        ELSE DO: /* wdetail.polcomp */
            IF  (wdetail.contract = "") THEN DO:
                 ASSIGN np_policy = substr(TRIM(wdetail.polcomp),1,12).
                FIND LAST uwm100 USE-INDEX uwm10001 WHERE 
                    uwm100.policy = np_policy NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL uwm100 THEN  np_cedpol = uwm100.cedpol.
            END.
        END.
    END. */

        EXPORT DELIMITER "," 
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
            wdetail.VatCode.   

              /*  deci(wdetail.comdat)              
                deci(wdetail.grossprem)
                deci(wdetail.CompGrossPrem)  
                deci(wdetail.NetPrem) 
                deci(wdetail.CompNetPrem) 
                deci(wdetail.tax)         
                deci(wdetail.NetPayment)            
                END.*/                            
    END.
END.
*/

message "Export File  Complete"  view-as alert-box.

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
If  substr(fi_outfilemux,length(fi_outfilemux) - 3,4) <>  ".csv"  Then
    fi_outfilemux  =  Trim(fi_outfilemux) + ".csv"  . 
ASSIGN
    numberline1 = ""
    numberline  = 0 
    nv_cnt      = 0
    nv_row      = 1
    nstmp70     = 0
    nstmp72     = 0 .

OUTPUT  TO VALUE(fi_outfilemux). 
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

FOR EACH wdetail WHERE 
    wdetail.head     = "D" AND 
    wdetail.Producer = fi_producer  NO-LOCK.   
    IF INDEX(wdetail.Brand_Model,fi_model) = 0   THEN NEXT.

    ASSIGN 
        np_cedpol   = ""
        np_policy   = "" 
        np_cedpol   = wdetail.contract  
        nstmp70     = 0
        nstmp72     = 0
        n_nettotel  = 0
        n_wh1       = 0
        n_nettotel  = deci(wdetail.grossprem) + deci(wdetail.CompGrossPrem) .

    IF wdetail.Name2 <> "" THEN DO:
        ASSIGN 
            nstmp70       = IF (deci(wdetail.NetPrem) * 0.004 ) - TRUNCATE( (deci(wdetail.NetPrem) * 0.004 ),0) > 0
                            THEN TRUNCATE( (deci(wdetail.NetPrem) * 0.004 ),0) + 1 /* มีทศนิยม  ปัดเศษ + 1 */
                            ELSE TRUNCATE( (deci(wdetail.NetPrem) * 0.004 ),0)    /* ไม่มีทศนิยม */
            nstmp72       = IF (deci(wdetail.CompNetPrem)  * 0.004 ) - TRUNCATE( (deci(wdetail.CompNetPrem)  * 0.004 ),0) > 0
                            THEN TRUNCATE( (deci(wdetail.CompNetPrem)  * 0.004 ),0) + 1 /* มีทศนิยม  ปัดเศษ + 1 */
                            ELSE TRUNCATE( (deci(wdetail.CompNetPrem)  * 0.004 ),0)    /* ไม่มีทศนิยม */ 
            n_wh1         =  (  ((nstmp70 + deci(wdetail.NetPrem)) + (nstmp72 + deci(wdetail.CompNetPrem))) * 1 ) / 100
            n_nettotel    =  n_nettotel -  n_wh1  . 
    END.
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
        n_wh1  
        n_nettotel  
        wdetail.nSTATUS      
        wdetail.Name2            
        wdetail.VatCode    
        wdetail.Producer    
        wdetail.Brand_Model .      
     
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

If  substr(fi_outfileallnew,length(fi_outfileallnew) - 3,4) <>  ".csv"  Then
    fi_outfileallnew  =  Trim(fi_outfileallnew) + ".csv"  . 
ASSIGN
    numberline1 = ""
    numberline  = 0 
    nv_cnt      = 0
    nv_row      = 1
    nstmp70     = 0
    nstmp72     = 0 .

OUTPUT  TO VALUE(fi_outfileallnew). 
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

FOR EACH wdetail WHERE 
    wdetail.head     = "D" AND 
    wdetail.Producer = fi_producer  NO-LOCK.   
    IF INDEX(wdetail.Brand_Model,fi_model) <> 0   THEN NEXT.

    ASSIGN 
        np_cedpol   = ""
        np_policy   = "" 
        np_cedpol   = wdetail.contract  
        nstmp70     = 0
        nstmp72     = 0
        n_nettotel  = 0
        n_wh1       = 0
       n_nettotel  = deci(wdetail.grossprem) + deci(wdetail.CompGrossPrem) .
    IF wdetail.Name2 <> "" THEN DO:
        ASSIGN 
             nstmp70       = IF (deci(wdetail.NetPrem) * 0.004 ) - TRUNCATE( (deci(wdetail.NetPrem) * 0.004 ),0) > 0
                            THEN TRUNCATE( (deci(wdetail.NetPrem) * 0.004 ),0) + 1 /* มีทศนิยม  ปัดเศษ + 1 */
                            ELSE TRUNCATE( (deci(wdetail.NetPrem) * 0.004 ),0)    /* ไม่มีทศนิยม */
            nstmp72       = IF (deci(wdetail.CompNetPrem)  * 0.004 ) - TRUNCATE( (deci(wdetail.CompNetPrem)  * 0.004 ),0) > 0
                            THEN TRUNCATE( (deci(wdetail.CompNetPrem)  * 0.004 ),0) + 1 /* มีทศนิยม  ปัดเศษ + 1 */
                            ELSE TRUNCATE( (deci(wdetail.CompNetPrem)  * 0.004 ),0)    /* ไม่มีทศนิยม */ 
            n_wh1         =  (  ((nstmp70 + deci(wdetail.NetPrem)) + (nstmp72 + deci(wdetail.CompNetPrem))) * 1 ) / 100
            n_nettotel    = n_nettotel -  n_wh1  . 
    END.
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
        n_wh1  
        n_nettotel  
        wdetail.nSTATUS      
        wdetail.Name2            
        wdetail.VatCode    
        wdetail.Producer    
        wdetail.Brand_Model .  
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

If  substr(fi_outfiletil,length(fi_outfiletil) - 3,4) <>  ".csv"  Then
    fi_outfiletil  =  Trim(fi_outfiletil) + ".csv"  . 
ASSIGN
    numberline1 = ""
    numberline  = 0 
    nv_cnt      = 0
    nv_row      = 1
    nstmp70     = 0
    nstmp72     = 0 .

OUTPUT  TO VALUE(fi_outfiletil). 
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

FOR EACH wdetail WHERE 
    wdetail.head     = "D" AND 
    wdetail.Producer = fi_producertil  NO-LOCK.  
    
    ASSIGN 
        np_cedpol   = ""
        np_policy   = "" 
        np_cedpol   = wdetail.contract  
        nstmp70     = 0
        nstmp72     = 0
        n_nettotel  = 0
        n_wh1       = 0
        n_nettotel  = deci(wdetail.grossprem) + deci(wdetail.CompGrossPrem) .
    ASSIGN 
        nstmp70       = IF (deci(wdetail.NetPrem) * 0.004 ) - TRUNCATE( (deci(wdetail.NetPrem) * 0.004 ),0) > 0
                        THEN TRUNCATE( (deci(wdetail.NetPrem) * 0.004 ),0) + 1 /* มีทศนิยม  ปัดเศษ + 1 */
                        ELSE TRUNCATE( (deci(wdetail.NetPrem) * 0.004 ),0)    /* ไม่มีทศนิยม */
        nstmp72       = IF (deci(wdetail.CompNetPrem)  * 0.004 ) - TRUNCATE( (deci(wdetail.CompNetPrem)  * 0.004 ),0) > 0
                        THEN TRUNCATE( (deci(wdetail.CompNetPrem)  * 0.004 ),0) + 1 /* มีทศนิยม  ปัดเศษ + 1 */
                        ELSE TRUNCATE( (deci(wdetail.CompNetPrem)  * 0.004 ),0)    /* ไม่มีทศนิยม */ 
        n_wh1         =  (  ((nstmp70 + deci(wdetail.NetPrem)) + (nstmp72 + deci(wdetail.CompNetPrem))) * 1 ) / 100
        n_nettotel    = n_nettotel -  n_wh1  . 
     
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
        n_wh1  
        n_nettotel  
        wdetail.nSTATUS      
        wdetail.Name2            
        wdetail.VatCode    
        wdetail.Producer    
        wdetail.Brand_Model .  
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
If  substr(fi_outfileoth,length(fi_outfileoth) - 3,4) <>  ".csv"  Then
    fi_outfileoth  =  Trim(fi_outfileoth) + ".csv"  . 
ASSIGN
    numberline1 = ""
    numberline  = 0 
    nv_cnt      = 0
    nv_row      = 1
    nstmp70     = 0
    nstmp72     = 0 .

OUTPUT  TO VALUE(fi_outfileoth). 
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

FOR EACH wdetail WHERE 
    wdetail.head     = "D" NO-LOCK.
    IF      wdetail.Producer = fi_producertil  THEN NEXT.
    ELSE IF wdetail.Producer = fi_producer     THEN NEXT.

    /*ASSIGN 
        np_cedpol   = ""
        np_policy   = "" 
        np_cedpol   = wdetail.contract  
        nstmp70     = 0
        nstmp72     = 0
        n_nettotel  = 0
        n_wh1       = 0
        n_nettotel  = deci(wdetail.NetPrem) + deci(wdetail.CompNetPrem) .*/
    /*ASSIGN 
        nstmp70       = IF (deci(wdetail.NetPrem) * 0.004 ) - TRUNCATE( (deci(wdetail.NetPrem) * 0.004 ),0) > 0
                        THEN TRUNCATE( (deci(wdetail.NetPrem) * 0.004 ),0) + 1 /* มีทศนิยม  ปัดเศษ + 1 */
                        ELSE TRUNCATE( (deci(wdetail.NetPrem) * 0.004 ),0)    /* ไม่มีทศนิยม */
        nstmp72       = IF (deci(wdetail.CompNetPrem)  * 0.004 ) - TRUNCATE( (deci(wdetail.CompNetPrem)  * 0.004 ),0) > 0
                        THEN TRUNCATE( (deci(wdetail.CompNetPrem)  * 0.004 ),0) + 1 /* มีทศนิยม  ปัดเศษ + 1 */
                        ELSE TRUNCATE( (deci(wdetail.CompNetPrem)  * 0.004 ),0)    /* ไม่มีทศนิยม */ 
        n_wh1         =  (( nstmp70   + nstmp72) * 1 ) / 100
        n_nettotel    = n_nettotel -  n_wh1  . */
     
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_createfile_old C-Win 
PROCEDURE Pro_createfile_old :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*---add Sarinya c.   A59-0362 05/08/2016 ----*/
DEF VAR numberline AS INTE INIT 0.      
DEF VAR np_cedpol   AS CHAR INIT "" FORMAT "x(20)" .

FOR EACH wdetail :
    DELETE wdetail.
END.
                                                                                                                                                 
INPUT FROM VALUE(fi_filename).
REPEAT:
    /*CREATE wdetail.*/
    /*---add by Sarinya c. A59-0362----*/
    IMPORT DELIMITER "|"                        
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
         VatCode  .
                        
                                            
    IF (head = "head") OR (head = "H") OR (head = "T") THEN DO: 
    
        IF head = "H"  THEN DO:
            CREATE wdetail.
            ASSIGN                          
                wdetail.head           = "H"                                              
                wdetail.insure         = "Safety Insurance Public Company Limited"                                               
                wdetail.policy         = polcomp   
                wdetail.polcomp        = engine  .  
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
    ELSE DO:
        FIND LAST wdetail WHERE wdetail.engc =  engc NO-ERROR NO-WAIT.
        IF NOT AVAIL wdetail THEN DO:
            CREATE wdetail.
            ASSIGN                          
                wdetail.head           = head                                               
                wdetail.insure         = insure                                                
                wdetail.policy         = policy                                         
                wdetail.polcomp        = polcomp                     
                wdetail.engine         = engine                                         
                wdetail.chass          = chass                                 
                wdetail.contract       = contract                         
                wdetail.engc           = engc                                 
                wdetail.comdat         = comdat                               
                wdetail.grossprem      = grossprem                            
                wdetail.CompGrossPrem  = CompGrossPrem                        
                wdetail.NetPrem        = NetPrem                              
                wdetail.CompNetPrem    = CompNetPrem    
                wdetail.tax            = tax            
                wdetail.NetPayment     = NetPayment .    
                                              


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
/*---end by Sarinya c. A59-0362----*/ 



If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".txt"  Then                                                                                 
    fi_outfile  =  Trim(fi_outfile) + ".txt"  .                                                                                                  
ASSIGN                                                                                                                                           
    numberline = 0                                                                                                                               
nv_cnt   =   0                                                                                                                                   
nv_row  =  1.                                                                                                                                    
OUTPUT STREAM ns2 TO VALUE(fi_outfile).  

FIND LAST  wdetail WHERE wdetail.head           = "H"  NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL wdetail  THEN DO:
    PUT STREAM ns2                                                                                                                       
        "H" FORMAT "X"                                              /* 1 - 1 */                                                                                                
        "Safety Insurance Public Company Limited"  FORMAT "X(40)"   /* 2 - 41 */                                                             
        STRING(TODAY,"99999999")                   FORMAT "X(8)"    /* 42 - 49 */                                                                                              
        STRING(wdetail.polcomp,"99999999")         FORMAT "X(12)"   /* 50 - 61 */                                                                                          
        SKIP.  
END.
/*
FOR EACH wdetail WHERE wdetail.head = "H" OR                                                                                                     
                       wdetail.head = "D" NO-LOCK.     

    IF (wdetail.head = "") OR (index(wdetail.head,"head") <> 0) THEN NEXT.                                                                       
    ELSE DO:                                                                                                                                     
        IF wdetail.head = "H" THEN                                                                                                               
            PUT STREAM ns2                                                                                                                       
            "H" FORMAT "X"                                              /* 1 - 1 */                                                              
            "Safety Insurance Public Company Limited"  FORMAT "X(40)"   /* 2 - 41 */                                                             
            STRING(TODAY,"99999999")                   FORMAT "X(8)"    /* 42 - 49 */                                                            
            STRING(wdetail.polcomp,"99999999")         FORMAT "X(12)"   /* 50 - 61 */                                                            
            SKIP.                                                                                                                                
        ELSE DO:  */


FOR EACH wdetail WHERE 
    wdetail.insure     <>  ""   AND 
    wdetail.head       <>  "H"  NO-LOCK.
    IF  (index(wdetail.insure,"Customer") <> 0) THEN NEXT.
    ELSE DO:
            ASSIGN np_cedpol = "" .
            IF (wdetail.policy <> "") AND (wdetail.contract = "") THEN DO:
                FIND LAST uwm100 USE-INDEX uwm10001 WHERE 
                    uwm100.policy = trim(wdetail.policy)  NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL uwm100 THEN  np_cedpol = uwm100.cedpol.
            END.
            ELSE DO: /* wdetail.polcomp */
                IF  (wdetail.contract = "") THEN DO:
                    FIND LAST uwm100 USE-INDEX uwm10001 WHERE 
                        uwm100.policy = trim(wdetail.polcomp) NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAIL uwm100 THEN  np_cedpol = uwm100.cedpol.
                END.
            END.   


                                                                                                                                                 
            PUT STREAM  ns2                                                                                                                      
                "D"                 FORMAT "X"            /* 1.  1 -   1 */                                                                      
                wdetail.insure      FORMAT "X(60)"    /* 2.  2 - 61 */                                                                       
                wdetail.policy      FORMAT "X(26)"    /* 3. 62 - 87 */                                                                       
                wdetail.polcomp     FORMAT "X(26)"    /* 4. 88 - 113 */                                                                      
                wdetail.engine      FORMAT "X(26)"                    
                wdetail.chass       FORMAT "X(26)"                    
                wdetail.contract    FORMAT "X(10)"   /* 7. 166 - 175   opnpol*/                                                            
                wdetail.engc        FORMAT "X(12)"                
                string(deci(wdetail.comdat),"99999999")                 FORMAT "99999999"   /* 9. 188 - 195 comdat*/                                        
                string(deci(wdetail.grossprem) * 100 ,"9999999999")     FORMAT "9999999999"                               
                string(deci(wdetail.CompGrossPrem) * 100 ,"9999999999") FORMAT "9999999999" /* 10. 196 - 205  "9999999999" GP*/                 
                string(deci(wdetail.NetPrem)  * 100 ,"9999999999")      FORMAT "9999999999" /* 11. 206 - 215  compGP*/                          
                string(deci(wdetail.CompNetPrem) * 100 ,"9999999999")   FORMAT "9999999999" /* 12. 216 - 225  NP*/                               
                string(deci(wdetail.tax)         * 100 ,"9999999999")   FORMAT "9999999999" /* 13. 226 - 235  compNP*/                         
                string(deci(wdetail.NetPayment)  * 100 ,"9999999999")   FORMAT "9999999999" /* 14. 236 - 245  12+13+stamp * 1% */              
                SKIP.                                                                                                                            
            numberline = numberline + 1.                                                                                                         
                                                                                                                                        
    END.                                                                                                                                         
END.                                                                                                                                            
PUT STREAM ns2                                                                                                                                   
            "T" FORMAT "X"                                                                                                                       
            STRING(numberline,"999999")  FORMAT "999999"                                                                                         
            SKIP.        

OUTPUT STREAM ns2 CLOSE.                                                                                                                         
message "Export File  Complete"  view-as alert-box.                                                                                              
/*---end Sarinya c.   A59-0362 05/08/2016 ----*/                                                                                                                                                 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_createfile_oth C-Win 
PROCEDURE Pro_createfile_oth :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/



FOR EACH wdetail :
    DELETE wdetail.
END.

/* sarinya c. A59-0362 */
INPUT FROM VALUE(fi_filename).
REPEAT:
    IMPORT DELIMITER "|"
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
         VatCode  .    


    IF (head = "head") OR (head = "H") OR (head = "T")   THEN
        ASSIGN 
         head            =  ""   
         insure          =  ""    
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
         VatCode         =  ""  .
    ELSE DO:
        FIND LAST wdetail WHERE wdetail.engc = engc NO-ERROR NO-WAIT.
        IF NOT AVAIL wdetail THEN DO :
            CREATE wdetail.
            ASSIGN 
                wdetail.head            = head                  
                wdetail.insure          = insure                           
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
                wdetail.VatCode         = VatCode   .     

        END.
        ASSIGN 
         head            =  ""   
         insure          =  ""    
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
         VatCode         =  ""  .
    END.
END. /* repeat */
/* end sarinya c. A59-0362 */

If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".csv"  Then
    fi_outfile  =  Trim(fi_outfile) + ".csv"  . 
ASSIGN
    numberline1 = ""
    numberline = 0
nv_cnt   =   0
nv_row  =  1.

/*OUTPUT STREAM ns2 TO VALUE(fi_outfile).*/  

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

/*FOR EACH wdetail WHERE wdetail.head = "D" NO-LOCK.*/
FOR EACH wdetail WHERE wdetail.insure <> "" NO-LOCK.
    IF  (index(wdetail.insure,"Customer") <> 0) THEN NEXT.
    ELSE DO:
        
    /* IF (wdetail.head = "") OR (index(wdetail.head,"head") <> 0) THEN NEXT.
    ELSE DO:
        ASSIGN numberline = numberline + 1.*/ /* A59-0362 */

    ASSIGN np_cedpol = ""
        np_policy    = ""
        np_Name2     = ""
        np_VatCode   = "" /* "MC21364"    */
        np_stmpall    = 0
        nv_netPremAll = 0
        n_wh1         = 0
        np_cedpol     = wdetail.contract . 


    IF np_cedpol = ""  THEN DO:
        IF (wdetail.policy <> "") AND (wdetail.contract = "") THEN DO:

            ASSIGN np_policy = substr(TRIM(wdetail.policy),1,12).

            FIND LAST uwm100 USE-INDEX uwm10001 WHERE 
                uwm100.policy = np_policy NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL uwm100 THEN  np_cedpol = uwm100.cedpol.
        END.
        ELSE DO: /* wdetail.polcomp */
            IF  (wdetail.contract = "") THEN DO:
                 ASSIGN np_policy = substr(TRIM(wdetail.polcomp),1,12).
                FIND LAST uwm100 USE-INDEX uwm10001 WHERE 
                    uwm100.policy = np_policy NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL uwm100 THEN  np_cedpol = uwm100.cedpol.
            END.
        END.
    END.
    ASSIGN np_policy = IF substr(TRIM(wdetail.policy),1,12) = "" THEN substr(TRIM(wdetail.polcomp),1,12)
                       ELSE substr(TRIM(wdetail.policy),1,12).  
    IF np_policy <> ""  THEN DO:
        FIND LAST uwm100 USE-INDEX uwm10001 WHERE                            
             uwm100.policy = np_policy NO-LOCK NO-ERROR NO-WAIT.  
        IF AVAIL uwm100 THEN
            ASSIGN  
            np_Name2     = uwm100.name2
            np_VatCode   = uwm100.bs_cd. 
        IF ( ra_tax = 1 )  AND (np_VatCode <> "" ) THEN DO:
            ASSIGN 
                nv_netPremAll =  deci(wdetail.NetPrem) + deci(wdetail.CompNetPrem) 
                np_stmpall    = IF (nv_netPremAll * 0.004 ) - TRUNCATE( (nv_netPremAll * 0.004 ),0) > 0
                                THEN TRUNCATE( (nv_netPremAll * 0.004 ),0) + 1 /* มีทศนิยม  ปัดเศษ + 1 */
                                ELSE TRUNCATE( (nv_netPremAll * 0.004 ),0)    /* ไม่มีทศนิยม */
                n_wh1         =  ((nv_netPremAll  + np_stmpall) * 1 ) / 100 .
        END.
        ELSE IF ra_tax = 3 THEN DO:
            ASSIGN 
                nv_netPremAll =  deci(wdetail.NetPrem) + deci(wdetail.CompNetPrem) 
                np_stmpall    = IF (nv_netPremAll * 0.004 ) - TRUNCATE( (nv_netPremAll * 0.004 ),0) > 0
                                THEN TRUNCATE( (nv_netPremAll * 0.004 ),0) + 1 /* มีทศนิยม  ปัดเศษ + 1 */
                                ELSE TRUNCATE( (nv_netPremAll * 0.004 ),0)    /* ไม่มีทศนิยม */
                n_wh1         =  ((nv_netPremAll  + np_stmpall) * 1 ) / 100 .

        END.
    END.  
      
        EXPORT DELIMITER ","
         
                /* wdetail.head          FORMAT "X"  */   /* A59-0362 */   
            /* wdetail.insure        FORMAT "X(60)"     
             wdetail.policy        FORMAT "X(26)"     
             wdetail.polcomp       FORMAT "X(26)"     
             wdetail.engine        FORMAT 'x(26)'
             wdetail.chass         FORMAT 'x(26)'
             wdetail.contract      FORMAT "X(10)"     
             wdetail.engc          FORMAT 'x(12)'*/       /* end  A59-0362 */
             wdetail.insure         
             wdetail.policy         
             wdetail.polcomp        
             wdetail.engine       
             wdetail.chass        
             np_cedpol     
             wdetail.engc         
             wdetail.comdat
             wdetail.grossprem
             wdetail.CompGrossPrem
             wdetail.NetPrem
             wdetail.CompNetPrem
             n_wh1       
             wdetail.NetPayment
             ""
             np_Name2  
             np_VatCode.




              /*  deci(wdetail.comdat)          
                deci(wdetail.grossprem)
                deci(wdetail.CompGrossPrem)  
                deci(wdetail.NetPrem) 
                deci(wdetail.CompNetPrem) 
                deci(wdetail.tax)         
                deci(wdetail.NetPayment)  */   
                
           
    /*END.*/  
    END.
END.

/* ASSIGN numberline1 = STRING(numberline).  

EXPORT DELIMITER ","
    "T"                              
    numberline1
           .
/* OUTPUT STREAM ns2 CLOSE. */
OUTPUT   CLOSE. */  

message "Export File  Complete"  view-as alert-box.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

