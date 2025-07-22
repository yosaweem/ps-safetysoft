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
/* ***************************  Definitions  **************************     */
/* Parameters Definitions ---                                               */  
/*Local Variable Definitions ---                                            */   
/*Program name     : Match Text file Phone to excel file                       */  
/*create by        : Kridtiya il. A56-0024  03/02/2013                     */  
/*                   Match file confirm to file Load Text เป็นไฟล์excel     */  
/*DataBase connect : GW_SAFE -LD SIC_BRAN, GW_STAT -LD BRSTAT,SICSYAC,SICUW */ 
DEF  stream  ns1.
DEFINE VAR   nv_daily        AS CHARACTER FORMAT "X(1024)"     INITIAL ""  NO-UNDO.
DEFINE VAR   nv_reccnt       AS  INT  INIT  0.
DEFINE VAR   nv_completecnt  AS   INT   INIT  0.
DEFINE VAR   nv_enttim       AS  CHAR          INIT  "".
def    var   nv_export       as  date  init  ""  format "99/99/9999".
def  stream  ns2.
DEFINE VAR   nv_file1        AS CHARACTER FORMAT "X(100)"     INITIAL ""  NO-UNDO.
DEFINE VAR   nv_file2        AS CHARACTER FORMAT "X(100)"     INITIAL ""  NO-UNDO.
/*--------------------------สำหรับข้อมูลกรมธรรม์  -------------------------*/
DEFINE NEW SHARED TEMP-TABLE wdetail
    FIELD recno          AS CHAR FORMAT "X(10)"  INIT ""  /*1  ลำดับที่            */
    FIELD Notify_dat     AS CHAR FORMAT "X(10)"  INIT ""  /*2  วันที่รับแจ้ง       */
    FIELD time_notify    AS CHAR FORMAT "X(10)"  INIT ""  /*3  เวลารับแจ้ง         */
    FIELD notifyno       AS CHAR FORMAT "X(50)"  INIT ""  /*4  เลขรับแจ้งงาน       */
    FIELD comp_code      AS CHAR FORMAT "X(20)"  INIT ""  /*5  รหัสบรษัท           */
    FIELD NAME_mkt       AS CHAR FORMAT "X(60)"  INIT ""  /*6  ชื่อเจ้าหน้าที่ MKT */
    FIELD cmbr_no        AS CHAR FORMAT "X(100)"   INIT ""  /*7  รหัสสาขา            */
    FIELD cmbr_code      AS CHAR FORMAT "X(45)"  INIT ""  /*8  Code:               */
    FIELD branch         AS CHAR FORMAT "X(10)"  INIT ""  /*9  รหัสสาขา_STY        */
    FIELD producer       AS CHAR FORMAT "X(15)"  INIT ""  /*10 Producer.           */
    FIELD agent          AS CHAR FORMAT "X(15)"  INIT ""  /*11 Agent.              */
    FIELD deler          AS CHAR FORMAT "X(10)"  INIT ""  /*   deler               */
    FIELD campaigno      AS CHAR FORMAT "X(30)"  INIT ""  /*12 Campaign no.        */
    FIELD cov_car        AS CHAR FORMAT "X(20)"  INIT ""  /*13 ประเภทประกัน        */
    FIELD cov_new        AS CHAR FORMAT "X(40)"  INIT ""  /*14 ประเภทรถ            */
    FIELD covcod         AS CHAR FORMAT "X(10)"  INIT ""  /*15 ประเภทความคุ้มครอง  */
    FIELD product        AS CHAR FORMAT "X(30)"  INIT ""  /*16 Product Type        */
    FIELD freeprem       AS CHAR FORMAT "X(20)"  INIT "" /*17 ประกัน แถม/ไม่แถม   */
    FIELD freecomp       AS CHAR FORMAT "X(20)"  INIT ""  /*18 พรบ.   แถม/ไม่แถม   */
    FIELD comdat         AS CHAR FORMAT "X(10)"  INIT ""  /*19 วันเริ่มคุ้มครอง    */
    FIELD expdat         AS CHAR FORMAT "X(10)"  INIT ""  /*20 วันสิ้นสุดความคุ้มครอง */
    FIELD ispno          AS CHAR FORMAT "X(45)"  INIT ""  /*21 เลขตรวจสภาพ            */
    FIELD pol70          AS CHAR FORMAT "X(20)"  INIT ""  /*22 เลขกรมธรรม์70          */
    FIELD pol72          AS CHAR FORMAT "X(20)"  INIT ""  /*  23  เลขกรมธรรม์72          */
    FIELD n_TITLE        AS CHAR FORMAT "X(20)"  INIT ""  /*  24  คำนำหน้าชื่อ           */
    FIELD n_name1        AS CHAR FORMAT "X(80)"  INIT ""  /*  25  ชื่อผู้เอาประกัน       */
    FIELD idno           AS CHAR FORMAT "X(20)"  INIT ""  /*A55-0257*/
    FIELD birthday       AS CHAR FORMAT "X(10)"  INIT ""  /*A55-0257*/
    FIELD birthdayexp    AS CHAR FORMAT "X(10)"  INIT ""  /*A55-0257*/
    FIELD occup          AS CHAR FORMAT "X(50)"  INIT ""  /*A55-0257*/
    FIELD namedirect     AS CHAR FORMAT "X(80)"  INIT ""  /*A55-0257*/
    FIELD ADD_1          AS CHAR FORMAT "X(80)"  INIT ""  /*  26  บ้านเลขที่             */
    FIELD ADD_2          AS CHAR FORMAT "X(50)"  INIT ""  /*  27  ตำบล/แขวง              */
    FIELD ADD_3          AS CHAR FORMAT "X(30)"  INIT ""  /*  28  อำเภอ/เขต              */
    FIELD ADD_4          AS CHAR FORMAT "X(30)"  INIT ""  /*  29  จังหวัด                */
    FIELD ADD_5          AS CHAR FORMAT "X(10)"  INIT ""  /*  30  รหัสไปรษณีย์           */
    FIELD tel            AS CHAR FORMAT "X(35)"  INIT ""  /*  31  เบอร์โทรศัพท์          */
    FIELD typ_driv       AS CHAR FORMAT "X(35)"  INIT ""        
    FIELD drivname1      AS CHAR FORMAT "X(60)"  INIT ""
    FIELD sex1           AS CHAR FORMAT "X(10)"  INIT ""   
    FIELD birthdriv1     AS CHAR FORMAT "X(10)"  INIT "" 
    FIELD occup1         AS CHAR FORMAT "X(50)"  INIT ""
    FIELD drivno1        AS CHAR FORMAT "X(30)"  INIT "" 
    FIELD drivname2      AS CHAR FORMAT "X(60)"  INIT "" 
    FIELD sex2           AS CHAR FORMAT "X(10)"  INIT "" 
    FIELD birthdriv2     AS CHAR FORMAT "X(10)"  INIT "" 
    FIELD occup2         AS CHAR FORMAT "X(50)"  INIT "" 
    FIELD drivno2        AS CHAR FORMAT "X(30)"  INIT "" 
    FIELD brand          AS CHAR FORMAT "X(30)"  INIT ""  /*  32  ชื่อยี่ห้อรถ           */
    FIELD model          AS CHAR FORMAT "X(50)"  INIT ""  /*  33  รุ่นรถ                 */
    FIELD engine         AS CHAR FORMAT "X(30)"  INIT ""  /*  34  เลขเครื่องยนต์         */
    FIELD chassis        AS CHAR FORMAT "X(30)"  INIT ""  /*  35  เลขตัวถัง              */
    FIELD power          AS CHAR FORMAT "X(10)"  INIT ""  /*  36  ซีซี                   */
    FIELD cyear          AS CHAR FORMAT "X(10)"  INIT ""  /*  37  ปีรถยนต์               */
    FIELD licence        AS CHAR FORMAT "X(20)"  INIT ""  /*  38  เลขทะเบียน             */
    FIELD provin         AS CHAR FORMAT "X(40)"  INIT ""  /*  39  จังหวัดที่จดทะเบียน    */
    FIELD subclass       AS CHAR FORMAT "X(10)"  INIT ""  /*  40  แพคเกจ                 */
    FIELD garage         AS CHAR FORMAT "X(10)"  INIT ""  /*  41  การซ่อม                */
    FIELD ins_amt1       AS CHAR FORMAT "X(30)"  INIT ""  /*  42  ทุนประกัน              */
    FIELD prem1          AS CHAR FORMAT "X(30)"  INIT ""  /*  43  เบี้ยสุทธิ             */
    FIELD prem2          AS CHAR FORMAT "X(30)"  INIT ""  /*  44  เบี้ยประกัน            */
    FIELD comprem        AS CHAR FORMAT "X(30)"  INIT ""  /*  45  เบี้ยพรบ.              */
    FIELD prem3          AS CHAR FORMAT "X(30)"  INIT ""  /*  46  เบี้ยรวม               */
    FIELD sck            AS CHAR FORMAT "X(30)"  INIT ""  /*  47  เลขสติ๊กเกอร์          */
    FIELD ref            AS CHAR FORMAT "X(30)"  INIT ""  /*  48  เลขReferance no.       */
    FIELD recivename     AS CHAR FORMAT "X(60)"  INIT ""  /*  49  ออกใบเสร็จในนาม        */
    FIELD vatcode        AS CHAR FORMAT "X(15)"  INIT ""  /*  50  Vatcode                */
    FIELD notiuser       AS CHAR FORMAT "X(60)"  INIT ""  /*  51  ผู้รับแจ้ง             */
    FIELD bennam         AS CHAR FORMAT "X(80)"  INIT ""  /*  52  ผู้รับผลประโยชน์       */
    FIELD remak1         AS CHAR FORMAT "X(100)"  INIT ""  /*  53  หมายเหตุ               */
    FIELD statusco       AS CHAR FORMAT "X(30)"  INIT ""  /*  54  complete/not complete  */
    FIELD releas         AS CHAR FORMAT "X(10)"  INIT "" . /* 55  Yes/No                 */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_filename fi_outfile bu_ok bu_exit bu_file ~
RECT-76 RECT-77 
&Scoped-Define DISPLAYED-OBJECTS fi_filename fi_outfile 

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
     SIZE 7.5 BY 1.05
     FONT 6.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 3.5 BY 1.05.

DEFINE BUTTON bu_ok 
     LABEL "Ok" 
     SIZE 7.5 BY 1.05
     FONT 6.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 61 BY 1.05
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_outfile AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 65 BY 1.05
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-76
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 81 BY 7.62
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-77
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 19.5 BY 1.57
     BGCOLOR 1 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_filename AT ROW 3.52 COL 12.83 COLON-ALIGNED NO-LABEL
     fi_outfile AT ROW 4.81 COL 12.83 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 6.43 COL 61.83
     bu_exit AT ROW 6.43 COL 71.5
     bu_file AT ROW 3.52 COL 76
     "Input File :" VIEW-AS TEXT
          SIZE 12 BY 1.05 AT ROW 3.52 COL 2.5
          BGCOLOR 29 FGCOLOR 2 FONT 6
     "Output File :" VIEW-AS TEXT
          SIZE 12 BY 1.05 AT ROW 4.81 COL 2.5
          BGCOLOR 29 FGCOLOR 2 FONT 6
     "  Match Text File Policy (FAX) to GW and Premium" VIEW-AS TEXT
          SIZE 77 BY 1.67 AT ROW 1.48 COL 2.5
          BGCOLOR 18 FGCOLOR 2 FONT 2
     RECT-76 AT ROW 1 COL 1
     RECT-77 AT ROW 6.19 COL 60.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 81.67 BY 7.86
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
         TITLE              = "Match Text File Policy on Premium"
         HEIGHT             = 7.81
         WIDTH              = 81.17
         MAX-HEIGHT         = 18.76
         MAX-WIDTH          = 103.83
         VIRTUAL-HEIGHT     = 18.76
         VIRTUAL-WIDTH      = 103.83
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
ON END-ERROR OF C-Win /* Match Text File Policy on Premium */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Match Text File Policy on Premium */
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
        FILTERS    /*"Text Documents" "*.txt",*/
                    "Text Documents" "*.csv",
                            "Data Files (*.*)"     "*.*"
                            
        MUST-EXIST
        USE-FILENAME
        UPDATE OKpressed.
      
    IF OKpressed = TRUE THEN DO:
         fi_filename  = cvData.
         DISP fi_filename WITH FRAME fr_main.     
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok C-Win
ON CHOOSE OF bu_ok IN FRAME fr_main /* Ok */
DO:
    nv_reccnt  =  0.
    For each  wdetail:
        DELETE  wdetail.
    END.
    INPUT FROM VALUE (fi_filename) .   /*create in TEMP-TABLE wImport*/
    REPEAT:    
        CREATE wdetail.
        IMPORT DELIMITER "|" 
        wdetail.recno           /* 0   "ลำดับที่"     */
        wdetail.Notify_dat      /* 1   "วันที่รับแจ้ง"*/  
        wdetail.time_notify     /* 3   "เวลารับแจ้ง"  */ 
        wdetail.notifyno        /* 4   เลขรับเเจ้ง */ 
        wdetail.comp_code       /* 5   รายชื่อบริษัทประกันภัย  */ 
        wdetail.NAME_mkt        /* 6   ชื่อเจ้าหน้าที่ MKT */
        wdetail.cmbr_no         /* 7   "รหัสสาขา"    */                                           
        wdetail.cmbr_code       /* 8   "Code: "  */ 
        wdetail.branch          /* 9  "รหัสสาขา_STY "*/  
        wdetail.producer
        wdetail.agent
        wdetail.deler
        wdetail.campaigno       /* 9   Campaign            */ 
        wdetail.cov_car         /*10   "ประเภทประกัน"      */        
        wdetail.cov_new         /*     "ประเภทรถ"          */            
        wdetail.covcod          /*     "ประเภทความคุ้มครอง"*/  
        wdetail.product
        wdetail.freeprem        /*     "ประกัน แถม/ไม่แถม" */  
        wdetail.freecomp        /*     "พรบ.   แถม/ไม่แถม" */
        wdetail.comdat          /*     "วันเริ่มคุ้มครอง"       */  
        wdetail.expdat          /*     "วันสิ้นสุดความคุ้มครอง" */  
        wdetail.ispno           /*  add  A55-0046          */
        wdetail.pol70           /*    "เลขกรมธรรม์70"*/            
        wdetail.pol72           /*    "เลขกรมธรรม์72"*/            
        wdetail.n_TITLE         /* 12  คำนำหน้าชื่อ    */                                       
        wdetail.n_name1         /* 13  ชื่อผู้เอาประกัน    */ 
        wdetail.idno
        wdetail.birthday
        wdetail.birthdayexp
        wdetail.occup
        wdetail.namedirect
        wdetail.ADD_1           /* 15  บ้านเลขที่  */                                           
        wdetail.ADD_2           /* 21  ตำบล/แขวง   */                                           
        wdetail.ADD_3           /* 22  อำเภอ/เขต   */                                           
        wdetail.ADD_4           /* 23  จังหวัด */                                               
        wdetail.ADD_5           /* 24  รหัสไปรษณีย์    */ 
        wdetail.tel             /* 24  telephone    */ 
        wdetail.typ_driv   
        wdetail.drivname1  
        wdetail.sex1
        wdetail.birthdriv1
        wdetail.occup1     
        wdetail.drivno1    
        wdetail.drivname2  
        wdetail.sex2 
        wdetail.birthdriv2
        wdetail.occup2     
        wdetail.drivno2    
        wdetail.brand           /* 31  ชื่อยี่ห้อรถ    */                                       
        wdetail.model           /* 32  รุ่นรถ  */                                               
        wdetail.engine          /* 36  เลขเครื่องยนต์  */   
        wdetail.chassis         /* 35  เลขตัวถัง   */ 
        wdetail.power           /* 38  ซีซี    */ 
        wdetail.cyear           /* 37  ปีรถยนต์    */
        wdetail.licence         /* 34  เลขทะเบียน  */ 
        wdetail.provin          /* 34  จังหวัดเลขทะเบียน  */
        wdetail.subclass        /* 29  รหัสรถ  */   
        wdetail.garage          /* 26  ประเภทการซ่อม   */
        wdetail.ins_amt1        /*"ทุนประกัน"*/                                            
        wdetail.prem1           /*"เบี้ยประกัน" */ 
        wdetail.prem2  
        wdetail.comprem         /*"เบี้ยพรบ." */                                           
        wdetail.prem3        /*"เบี้ยรวม"*/                   
        wdetail.sck             /*"เลขสติ๊กเกอร์" */             
        wdetail.ref             /*"เลขReferance no."*/           
        wdetail.recivename      /*"ออกใบเสร็จในนาม"*/            
        wdetail.vatcode         /*"Vatcode " */                  
        wdetail.notiuser        /*"ผู้รับแจ้ง"             */    
        wdetail.bennam          /*"ผู้รับผลประโยชน์"       */                                
        wdetail.remak1          /*"หมายเหตุ"               */ 
        wdetail.statusco .      /*"complete/not complete"  */
        
    END.    /* repeat  */
    FOR EACH wdetail.
        IF index(wdetail.recno,"ข้อมูล") <> 0 THEN DELETE wdetail.
        ELSE IF index(wdetail.recno,"ลำดับ") <> 0 THEN DELETE wdetail.
        ELSE IF  wdetail.recno  = "" THEN DELETE wdetail.
    END.
    RUN  Pro_matchfile_prem.
    Run  Pro_createfile.
    Message "Export data Complete"  View-as alert-box.
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
  
      gv_prgid = "WGWMATFX.W".
  gv_prog  = "Mat Text file Policy on Premium by FAX".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).

/*********************************************************************/ 
   RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE).  
  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.
  /*ASSIGN ra_report =  1.*/
  /*DISP ra_report WITH FRAM fr_main.*/

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
  DISPLAY fi_filename fi_outfile 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_filename fi_outfile bu_ok bu_exit bu_file RECT-76 RECT-77 
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
DEF VAR   nv_cnt   as  int  init   1.
DEF VAR   nv_row   as  int  init   0.
DEF VAR   n_record AS  INTE INIT   0.

If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".slk"  THEN 
    fi_outfile  =  Trim(fi_outfile) + ".slk"  .

ASSIGN 
    n_record = 0
    nv_cnt   =  0
    nv_row   =  1 .

OUTPUT STREAM ns2 TO VALUE(fi_outfile).
PUT STREAM ns2 "ID;PND" SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "Export data by FAX ."  '"' SKIP.
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"' "ลำดับที่"                        '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"' "วันที่รับแจ้ง"                   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"' "เวลารับแจ้ง"                     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"' "เลขรับแจ้งงาน"                   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"' "รหัสบรษัท"                       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"' "ชื่อเจ้าหน้าที่ MKT"             '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"' "รหัสสาขา"                        '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"' "Code: "                          '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"' "รหัสสาขา_STY "                   '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"' "Producer."                       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"' "Agent."                          '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"' "Deler"                           '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"' "Campaign no."                    '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"' "ประเภทประกัน"                    '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"' "ประเภทรถ"                        '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"' "ประเภทความคุ้มครอง"              '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"' "Product Type"                    '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"' "ประกัน แถม/ไม่แถม"               '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"' "พรบ.   แถม/ไม่แถม"               '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"' "วันเริ่มคุ้มครอง"                '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"' "วันสิ้นสุดความคุ้มครอง"          '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"' "เลขตรวจสภาพ"                     '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"' "เลขกรมธรรม์70"                   '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"' "เลขกรมธรรม์72"                   '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"' "คำนำหน้าชื่อ"                    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"' "ชื่อผู้เอาประกัน"                '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"' "เลขที่บัตรประชาชน"               '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"' "วันเกิด"                         '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"' "วันที่บัตรหมดอายุ"               '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"' "อาชีพ"                           '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"' "ชื่อกรรมการ"                     '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"' "บ้านเลขที่"                      '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"' "ตำบล/แขวง"                       '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"' "อำเภอ/เขต"                       '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K"  '"' "จังหวัด"                         '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K"  '"' "รหัสไปรษณีย์"                    '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K"  '"' "เบอร์โทรศัพท์"                   '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K"  '"' "ระบุผู้ขับขี่/ไม่ระบุผู้ขับขี่"  '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K"  '"' "ผู้ขับขี่คนที่1"                 '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K"  '"' "เพศ"                             '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K"  '"' "วันเกิด"                         '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K"  '"' "อาชัพ"                           '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K"  '"' "เลขที่ใบขับขี่"                  '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K"  '"' "ผู้ขับขี่คนที่2"                 '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K"  '"' "เพศ "                            '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K"  '"' "วันเกิด"                         '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K"  '"' "อาชัพ   "                        '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K"  '"' "เลขที่ใบขับขี่"                  '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K"  '"'  "ชื่อยี่ห้อรถ"                   '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K"  '"'  "รุ่นรถ"                         '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K"  '"'  "เลขเครื่องยนต์"                 '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K"  '"'  "เลขตัวถัง"                      '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K"  '"'  "ซีซี"                           '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K"  '"'  "ปีรถยนต์"                       '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K"  '"'  "เลขทะเบียน"                     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K"  '"'  "จังหวัดที่จดทะเบียน"            '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K"  '"'  "แพคเกจ"                         '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K"  '"'  "การซ่อม"                        '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K"  '"'  "ทุนประกัน"                      '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K"  '"'  "เบี้ยสุทธิ"                     '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K"  '"'  "เบี้ยประกัน"                    '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K"  '"'  "เบี้ยพรบ."                      '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K"  '"'  "เบี้ยรวม"                       '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K"  '"'  "เลขสติ๊กเกอร์"                  '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K"  '"'  "เลขReferance no."               '"' SKIP.                 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K"  '"'  "ออกใบเสร็จในนาม"                '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K"  '"'  "Vatcode "                       '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K"  '"'  "ผู้รับแจ้ง"                     '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K"  '"'  "ผู้รับผลประโยชน์"               '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K"  '"'  "หมายเหตุ"                       '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K"  '"'  "complete/not complete"          '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K"  '"'  "Yes/No"                         '"' SKIP. 

FOR EACH wdetail  NO-LOCK  .
    ASSIGN 
        n_record =  n_record + 1
        nv_cnt   =  nv_cnt  + 1 
        nv_row   =  nv_row  + 1.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"'   n_record             '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"'   wdetail.Notify_dat   '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"'   wdetail.time_notify  '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"'   wdetail.notifyno     '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'   wdetail.comp_code    '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"'   wdetail.NAME_mkt     '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"'   wdetail.cmbr_no      '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"'   wdetail.cmbr_code    '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"'   wdetail.branch       '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"'  wdetail.producer     '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"'  wdetail.agent        '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"'  wdetail.deler        '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"'  wdetail.campaigno    '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"'  wdetail.cov_car      '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"'  wdetail.cov_new      '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"'  wdetail.covcod       '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"'  wdetail.product      '"' SKIP.          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"'  wdetail.freeprem     '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"'  wdetail.freecomp     '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"'  wdetail.comdat       '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"'  wdetail.expdat       '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"'  wdetail.ispno        '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"'  wdetail.pol70        '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"'  wdetail.pol72        '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"'  wdetail.n_TITLE      '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"'  wdetail.n_name1      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"'  wdetail.idno         '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"'  wdetail.birthday     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"'  wdetail.birthdayexp  '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"'  wdetail.occup        '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"'  wdetail.namedirect   '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"'  wdetail.ADD_1        '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"'  wdetail.ADD_2        '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"'  wdetail.ADD_3        '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K"  '"'  wdetail.ADD_4        '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K"  '"'  wdetail.ADD_5        '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K"  '"'  wdetail.tel          '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K"  '"'  wdetail.typ_driv     '"' SKIP.               
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K"  '"'  wdetail.drivname1    '"' SKIP.                           
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K"  '"'  wdetail.sex1         '"' SKIP.                         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K"  '"'  wdetail.birthdriv1   '"' SKIP.                     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K"  '"'  wdetail.occup1       '"' SKIP.          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K"  '"'  wdetail.drivno1      '"' SKIP.               
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K"  '"'  wdetail.drivname2    '"' SKIP.             
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K"  '"'  wdetail.sex2         '"' SKIP.             
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K"  '"'  wdetail.birthdriv2   '"' SKIP.                               
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K"  '"'  wdetail.occup2       '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K"  '"'  wdetail.drivno2      '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K"  '"'  wdetail.brand        '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K"  '"'  wdetail.model        '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K"  '"'  wdetail.engine       '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K"  '"'  wdetail.chassis      '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K"  '"'  wdetail.power        '"' SKIP.          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K"  '"'  wdetail.cyear        '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K"  '"'  wdetail.licence      '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K"  '"'  wdetail.provin       '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K"  '"'  wdetail.subclass     '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K"  '"'  wdetail.garage       '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K"  '"'  wdetail.ins_amt1     '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K"  '"'  wdetail.prem1        '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K"  '"'  wdetail.prem2        '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K"  '"'  wdetail.comprem      '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K"  '"'  wdetail.prem3        '"' SKIP.          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K"  '"'  wdetail.sck          '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K"  '"'  wdetail.ref          '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K"  '"'  wdetail.recivename   '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K"  '"'  wdetail.vatcode      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K"  '"'  wdetail.notiuser     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K"  '"'  wdetail.bennam       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K"  '"'  wdetail.remak1       '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K"  '"'  wdetail.statusco     '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K"  '"'  wdetail.releas       '"' SKIP.  
END.    /*  end  wdetail  */
nv_row  =  nv_row  + 1. 
PUT STREAM ns2 "E".
OUTPUT STREAM ns2 CLOSE.  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_matchfile_prem C-Win 
PROCEDURE Pro_matchfile_prem :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wdetail .
    FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE  
        sicuw.uwm100.policy =  wdetail.pol70  NO-LOCK NO-ERROR.
    IF AVAIL sicuw.uwm100 THEN DO: 
        IF ((sicuw.uwm100.name1 = "") OR (sicuw.uwm100.comdat = ?)) THEN ASSIGN wdetail.releas = "No" .
        ELSE DO:
            FIND LAST brstat.tlt USE-INDEX tlt06 WHERE 
                tlt.cha_no        =  wdetail.chassis     AND 
                tlt.nor_noti_tlt  =  wdetail.notifyno    AND 
                tlt.policy        =  wdetail.pol70       AND
                tlt.genusr        =  "FAX"               NO-ERROR NO-WAIT.
            IF AVAIL brstat.tlt THEN 
                ASSIGN 
                tlt.releas =  "yes"
                wdetail.releas = "YES" .
            ELSE ASSIGN wdetail.releas = "No" .
        END.
    END.
    ELSE ASSIGN wdetail.releas = "No" .   /*not found ....*/
END.      /* wdetail*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

