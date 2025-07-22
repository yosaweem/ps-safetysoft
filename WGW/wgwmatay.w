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
  
  
  Program name     : Match Text file Aycal to excel file                     
  create by        : Kridtiya il. A56-0241  02/08/2013                       
                     Match file confirm to file Load Text เป็นไฟล์excel      
  DataBase connect : GW_SAFE -LD SIC_BRAN, GW_STAT -LD BRSTAT,SICSYAC,SICUW 

  Created: Tunyaporn K. A58-0384    20/10/58
  Duplicate Program : UWRENTIS.W
  
  Modify By : Porntiwa P.  Assign : A59-0059   Date : 15/02/2016
            : ปรับการค้นหาด้วยเลขตัวถังให้ Check Policy Type 70 ด้วย
  Modify by : Ranu I. A61-0573 date : 22/07/2019 ปรับเงื่อนไขการเช็คข้อมูลในถังพัก 
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
DEFINE WORKFILE wdetail
    FIELD np_recno       AS CHAR FORMAT "x(10)"  INIT ""    /* 1  ลำดับที่    */                        
    FIELD np_Notify_dat  AS CHAR FORMAT "X(10)"  INIT ""    /* 2  วันที่แจ้ง  */                        
    FIELD np_notifyno    AS CHAR FORMAT "X(10)"  INIT ""    /* 3  เลขรับแจ้ง  */                        
    FIELD np_branch      AS CHAR FORMAT "X(2)"   INIT ""    /* 4  Branch      */                        
    FIELD np_contract    AS CHAR FORMAT "X(20)"  INIT ""    /* 5  Contract    */  
    FIELD np_policy      AS CHAR FORMAT "X(20)"  INIT ""    /* 5  Contract    */  
    FIELD np_title       AS CHAR FORMAT "X(25)"  INIT ""    /* 6  คำนำหน้าชื่อ    */                    
    FIELD np_name        AS CHAR FORMAT "X(30)"  INIT ""    /* 7  ชื่อ        */                        
    FIELD np_name2       AS CHAR FORMAT "X(20)"  INIT ""    /* 8  นามสกุล     */                        
    FIELD np_addr1       AS CHAR FORMAT "X(60)"  INIT ""    /* 9  ที่อยู่ 1       */                    
    FIELD np_addr2       AS CHAR FORMAT "X(45)"  INIT ""    /* 10 ที่อยู่ 2       */                    
    FIELD np_addr3       AS CHAR FORMAT "X(45)"  INIT ""    /* 11 ที่อยู่ 3       */                    
    FIELD np_addr4       AS CHAR FORMAT "X(40)"  INIT ""    /* 12 ที่อยู่ 4       */                    
    FIELD np_brand       AS CHAR FORMAT "X(30)"  INIT ""    /* 13 ยี่ห้อรถ    */                        
    FIELD np_model       AS CHAR FORMAT "X(50)"  INIT ""    /* 14 รุ่นรถ      */                        
    FIELD np_vehreg      AS CHAR FORMAT "X(40)"  INIT ""    /* 15 เลขทะเบียน  */                        
    FIELD np_caryear     AS CHAR FORMAT "X(10)"  INIT ""    /* 16 ปีรถ        */                        
    FIELD np_ccweigth    AS CHAR FORMAT "X(10)"  INIT ""    /* 17 CC.         */                        
    FIELD np_cha_no      AS CHAR FORMAT "X(25)"  INIT ""    /* 18 เลขตัวถัง   */                        
    FIELD np_engno       AS CHAR FORMAT "X(25)"  INIT ""    /* 19 เลขเครื่อง  */                        
    FIELD np_codenotify  AS CHAR FORMAT "X(20)"  INIT ""    /* 20 Code ผู้แจ้ง      */                  
    FIELD np_cover       AS CHAR FORMAT "X(5)"   INIT ""    /* 21 ประเภท            */                  
    FIELD np_companycode AS CHAR FORMAT "X(20)"  INIT ""    /* 22 Code บ.ประกัน     */                  
    FIELD np_prepol      AS CHAR FORMAT "X(16)"  INIT ""    /* 23 เลขกรมธรรม์เดิม   */                  
    FIELD np_idno        AS CHAR FORMAT "X(15)"  INIT ""
    FIELD np_comdate     AS CHAR FORMAT "X(10)"  INIT ""    /* 24 วันคุ้มครองประกัน */                  
    FIELD np_expdate     AS CHAR FORMAT "X(10)"  INIT ""    /* 25 วันหมดประกัน      */                  
    FIELD np_sumins      AS CHAR FORMAT "X(20)"  INIT ""    /* 26 ทุนประกัน         */                  
    FIELD np_premium     AS CHAR FORMAT "X(35)"  INIT ""    /* 27 ค่าเบี้ยสุทธิ์    */                  
    FIELD np_premiumnet  AS CHAR FORMAT "X(35)"  INIT ""    /* 28 ค่าเบี้ยรวมภาษีอากร             */    
    FIELD np_deduct      AS CHAR FORMAT "X(35)"  INIT ""    /* 29 Deduct      */                        
    FIELD np_company72   AS CHAR FORMAT "X(20)"  INIT ""    /* 30 Code บ.ประกัน พรบ.  */                
    FIELD np_comdate72   AS CHAR FORMAT "X(30)"  INIT ""    /* 31 วันคุ้มครองพรบ.     */                
    FIELD np_expdate72   AS CHAR FORMAT "X(20)"  INIT ""    /* 32 วันหมดพรบ.  */                        
    FIELD np_prmcomp     AS CHAR FORMAT "X(50)"  INIT ""    /* 33 ค่าพรบ.     */                        
    FIELD np_drino       AS CHAR FORMAT "X(30)"  INIT ""    /* 34 ระบุผู้ขับขี่       */                
    FIELD np_garage      AS CHAR FORMAT "X(20)"  INIT ""    /* 35 ซ่อมห้าง    */                        
    FIELD np_access      AS CHAR FORMAT "X(150)" INIT ""    /* 36 คุ้มครองอุปกรณ์เพิ่มเติม */           
    FIELD np_editadd     AS CHAR FORMAT "X(150)" INIT ""    /* 37 แก้ไขที่อยู่         */               
    FIELD np_benname     AS CHAR FORMAT "X(100)" INIT ""    /* 38 ผู้รับผลประโยชน์     */               
    FIELD np_remak       AS CHAR FORMAT "X(100)" INIT ""    /* 39 หมายเหตุ             */               
    FIELD np_complete    AS CHAR FORMAT "X(20)"  INIT ""    /* 40 complete/not complete*/               
    FIELD np_release     AS CHAR FORMAT "X(10)"  INIT ""    /* 41    Yes/No .         */
    FIELD np_prekpi      AS CHAR FORMAT "X(20)"  INIT ""    /* 40 complete/not complete*/  
    FIELD np_payamount   AS CHAR FORMAT "X(20)"  INIT ""   /* 40 complete/not complete*/
    FIELD np_comment     AS CHAR FORMAT "x(100)" INIT ""
    FIELD np_producer    AS CHAR FORMAT "x(20)"  INIT ""
    FIELD np_agent       AS CHAR FORMAT "x(20)"  INIT ""
    FIELD np_product     AS CHAR FORMAT "x(10)"  INIT "".

DEFINE VAR nv_uw_prem  LIKE sicuw.uwm120.prem_r.
DEFINE VAR nv_exp_prem LIKE sic_exp.uwm120.prem_r.
DEFINE VAR nv_fptr AS RECID.
DEFINE VAR nv_bptr AS RECID.
DEFINE VAR nv_comp AS INTE.

/*Add Jiraphon A60-0078*/
DEF SHARED Var n_User    As CHAR .
DEF  VAR gv_id      AS CHAR FORMAT "X(8)" NO-UNDO. 
DEF VAR nv_pwd      AS CHAR NO-UNDO. 
DEF VAR number_sic  AS INTE INIT 0.
DEF VAR n_policy    AS CHAR FORMAT "x(15)".
DEF VAR n_veh       AS CHAR INIT "".
DEF VAR n_veh1      AS CHAR. /*INIT "".*/

DEFINE TEMP-TABLE vehreg NO-UNDO
    FIELD tprov_n LIKE sicuw.uwm500.prov_n
    FIELD tprov_d LIKE sicuw.uwm500.prov_d.

DEFINE VAR nv_vehreg AS CHAR FORMAT "X(30)" EXTENT 20 INIT [" "]. 
DEFINE VAR vehcnt AS INTEGER.
DEFINE VAR nv_chano AS CHAR FORMAT "X(30)" EXTENT 20 INIT [" "]. 
DEFINE VAR chacnt AS INTEGER.
DEFINE BUFFER buwm301 FOR sicuw.uwm301.
/*End Jiraphon A60-0078*/

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
fi_process RECT-76 RECT-77 RECT-78 
&Scoped-Define DISPLAYED-OBJECTS fi_filename fi_outfile fi_process 

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

DEFINE VARIABLE fi_process AS CHARACTER FORMAT "X(100)":U 
      VIEW-AS TEXT 
     SIZE 57 BY .95
     BGCOLOR 8 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-76
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 80.33 BY 8.81
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-77
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 19.5 BY 1.57
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-78
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 19.5 BY 1.57
     BGCOLOR 1 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_filename AT ROW 4.43 COL 13.5 COLON-ALIGNED NO-LABEL
     fi_outfile AT ROW 5.71 COL 13.5 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 8.05 COL 62.83
     bu_exit AT ROW 8.05 COL 71.67
     bu_file AT ROW 4.43 COL 76.67
     fi_process AT ROW 8.24 COL 1.5 COLON-ALIGNED NO-LABEL
     "Input File :" VIEW-AS TEXT
          SIZE 12 BY 1.05 AT ROW 4.43 COL 3.17
          BGCOLOR 29 FGCOLOR 2 FONT 6
     "Output File :" VIEW-AS TEXT
          SIZE 12 BY 1.05 AT ROW 5.71 COL 3.17
          BGCOLOR 29 FGCOLOR 2 FONT 6
     "     Match Text File Policy (AYCAL) to GW and Premium" VIEW-AS TEXT
          SIZE 77 BY 1.52 AT ROW 1.67 COL 3.17
          BGCOLOR 18 FGCOLOR 2 FONT 2
     RECT-76 AT ROW 1.19 COL 1.67
     RECT-77 AT ROW 7.81 COL 61.17
     RECT-78 AT ROW 7.81 COL 61.17 WIDGET-ID 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 81.83 BY 9.29
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
         TITLE              = "Match Text File Policy on Premium AYCL"
         HEIGHT             = 9.24
         WIDTH              = 81.67
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
ON END-ERROR OF C-Win /* Match Text File Policy on Premium AYCL */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Match Text File Policy on Premium AYCL */
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
  IF CONNECTED("sic_exp") THEN DISCONNECT  sic_exp.  /*Jiraphon A60-0078*/
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
    FOR EACH  wdetail:
        DELETE  wdetail.
    END.

    INPUT FROM VALUE (fi_filename) .   /*create in TEMP-TABLE wImport*/
    REPEAT:    
        CREATE wdetail.
        IMPORT DELIMITER "|" 
        wdetail.np_recno                /*  1   ลำดับที่    */                                                  
        wdetail.np_Notify_dat           /*  2   วันที่แจ้ง  */                              
        wdetail.np_notifyno             /*  3   เลขรับแจ้ง  */                              
        wdetail.np_branch               /*  4   Branch      */                              
        wdetail.np_contract             /*  5   Contract    */                              
        wdetail.np_title                /*  6   คำนำหน้าชื่อ    */                          
        wdetail.np_name                 /*  7   ชื่อ    */                                                  
        wdetail.np_name2                /*  8   นามสกุล     */                              
        wdetail.np_addr1                /*  9   ที่อยู่ 1       */                          
        wdetail.np_addr2                /*  10  ที่อยู่ 2       */                          
        wdetail.np_addr3                /*  11  ที่อยู่ 3       */                          
        wdetail.np_addr4                /*  12  ที่อยู่ 4       */                          
        wdetail.np_brand                /*  13  ยี่ห้อรถ    */                              
        wdetail.np_model                /*  14  รุ่นรถ      */                              
        wdetail.np_vehreg               /*  15  เลขทะเบียน  */                              
        wdetail.np_caryear              /*  16  ปีรถ        */                              
        wdetail.np_ccweigth             /*  17  CC.         */                              
        wdetail.np_cha_no               /*  18  เลขตัวถัง   */                              
        wdetail.np_engno                /*  19  เลขเครื่อง  */                              
        wdetail.np_codenotify           /*  20  Code ผู้แจ้ง        */                      
        wdetail.np_cover                /*  21  ประเภท      */                              
        wdetail.np_companycode          /*  22  Code บ.ประกัน       */                      
        wdetail.np_prepol               /*  23  เลขกรมธรรม์เดิม     */                      
        wdetail.np_idno                 /*                          */                                    
        wdetail.np_comdate              /*  24  วันคุ้มครองประกัน   */                      
        wdetail.np_expdate              /*  25  วันหมดประกัน        */                      
        wdetail.np_sumins               /*  26  ทุนประกัน   */                              
        wdetail.np_premium              /*  27  ค่าเบี้ยสุทธิ์      */                      
        wdetail.np_premiumnet           /*  28  ค่าเบี้ยรวมภาษีอากร             */          
        wdetail.np_deduct               /*  29  Deduct      */                              
        wdetail.np_company72            /*  30  Code บ.ประกัน พรบ.  */                                           
        wdetail.np_comdate72            /*  31  วันคุ้มครองพรบ.     */                                           
        wdetail.np_expdate72            /*  32  วันหมดพรบ.  */                                                   
        wdetail.np_prmcomp              /*  33  ค่าพรบ.     */                                                   
        wdetail.np_drino                /*  34  ระบุผู้ขับขี่       */                      
        wdetail.np_garage               /*  35  ซ่อมห้าง    */                              
        wdetail.np_access               /*  36  คุ้มครองอุปกรณ์เพิ่มเติม    */              
        wdetail.np_editadd              /*  37  แก้ไขที่อยู่        */                      
        wdetail.np_benname              /*  38  ผู้รับผลประโยชน์    */                      
        wdetail.np_remak                /*  39  หมายเหตุ                            */      
        wdetail.np_complete             /*  40  complete/not complete   */                  
        wdetail.np_release              /*  41  Yes/No .    */                                  
        wdetail.np_prekpi               
        wdetail.np_payamount
        wdetail.np_producer
        wdetail.np_agent
        wdetail.np_product  . 

    END.    /* repeat  */


    FOR EACH wdetail.
        IF      INDEX(wdetail.np_recno,"ข้อมูล") <> 0 THEN DELETE wdetail.
        ELSE IF INDEX(wdetail.np_recno,"ลำดับ")  <> 0 THEN DELETE wdetail.
        ELSE IF INDEX(wdetail.np_recno,"mat")    <> 0 THEN DELETE wdetail.
        ELSE IF INDEX(wdetail.np_recno,"Seq.")   <> 0 THEN DELETE wdetail.
        ELSE IF  wdetail.np_recno  = "" THEN DELETE wdetail.
    END.


    /*--Comment Jiraphon A60-0078
    IF ra_select = 1 THEN DO:
        RUN  Pro_matchfile_prem.
    END.
    ELSE IF ra_select = 2 THEN RUN  Pro_matchfile_prem1.
    */

    RUN  Pro_matchfile_prem_new.
    RUN  Pro_createfile.

    MESSAGE "Export data Complete"  VIEW-AS ALERT-BOX.

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
  ASSIGN fi_process = "Match file Policy and Update Status "
  
      gv_prgid = "WGWMATAY.W".
  gv_prog  = "Mat Text file Policy on Premium by AYCL".
  DISP fi_process WITH FRAM fr_main.
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).

/*********************************************************************/ 
   RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE).  
  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.
  /*ASSIGN ra_report =  1.*/
  /*DISP ra_report WITH FRAM fr_main.*/

  /*ASSIGN ra_select = 1. --Comment Jiraphon A60-0078 */

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
  DISPLAY fi_filename fi_outfile fi_process 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_filename fi_outfile bu_ok bu_exit bu_file fi_process RECT-76 
         RECT-77 RECT-78 
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
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "Export data by Aycl ."  '"' SKIP.
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"' "ลำดับที่  "   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"' "วันที่แจ้ง"   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"' "เลขรับแจ้ง"   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"' "Branch"       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"' "Policy "      '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"' "Contract"     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"' "คำนำหน้าชื่อ"    '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"' "ชื่อ"            '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"' "นามสกุล  "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"' "ที่อยู่ 1"       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"' "ที่อยู่ 2"       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"' "ที่อยู่ 3"       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"' "ที่อยู่ 4"       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"' "ยี่ห้อรถ "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"' "รุ่นรถ"          '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"' "เลขทะเบียน"      '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"' "ปีรถ"            '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"' "CC."      '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"' "เลขตัวถัง"      '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"' "เลขเครื่อง     "             '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"' "Code ผู้แจ้ง   "             '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"' "ประเภท         "             '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"' "Code บ.ประกัน  "             '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"' "เลขกรมธรรม์เดิม"             '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"' "วันคุ้มครองประกัน        "   '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"' "วันหมดประกัน             "   '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"' "ทุนประกัน                "   '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"' "ค่าเบี้ยสุทธิ์           "   '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"' "ค่าเบี้ยรวมภาษีอากร      "   '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"' "Deduct                   "   '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"' "Code บ.ประกัน พรบ.       "   '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"' "วันคุ้มครองพรบ.          "   '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"' "วันหมดพรบ.               "   '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"' "ค่าพรบ.                  "   '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K"  '"' "ระบุผู้ขับขี่            "   '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K"  '"' "ซ่อมห้าง                 "   '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K"  '"' "คุ้มครองอุปกรณ์เพิ่มเติม "   '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K"  '"' "แก้ไขที่อยู่             "   '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K"  '"' "ผู้รับผลประโยชน์         "   '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K"  '"' "หมายเหตุ                 "   '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K"  '"' "complete/not complete    "   '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K"  '"' "Yes/No .                "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K"  '"' "Comment Premium"    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K"  '"' "Producer"    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K"  '"' "Agent"    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K"  '"' "วันที่ชำระเงิน"    '"' SKIP. 

FOR EACH wdetail  NO-LOCK  .
    ASSIGN 
        n_record =  n_record + 1
        nv_cnt   =  nv_cnt  + 1 
        nv_row   =  nv_row  + 1.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"'   n_record                '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"'   wdetail.np_Notify_dat   '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"'   wdetail.np_notifyno     '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"'   wdetail.np_branch       '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'   wdetail.np_policy       '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"'   wdetail.np_contract     '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"'   wdetail.np_title        '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"'   wdetail.np_name         '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"'   wdetail.np_name2        '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"'  wdetail.np_addr1        '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"'  wdetail.np_addr2        '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"'  wdetail.np_addr3        '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"'  wdetail.np_addr4        '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"'  wdetail.np_brand        '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"'  wdetail.np_model        '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"'  wdetail.np_vehreg       '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"'  wdetail.np_caryear      '"' SKIP.          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"'  wdetail.np_ccweigth     '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"'  wdetail.np_cha_no       '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"'  wdetail.np_engno        '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"'  wdetail.np_codenotify   '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"'  wdetail.np_cover        '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"'  wdetail.np_companycode  '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"'  wdetail.np_prepol       '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"'  wdetail.np_comdate      '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"'  wdetail.np_expdate      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"'  wdetail.np_sumins       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"'  wdetail.np_premium      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"'  wdetail.np_premiumnet   '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"'  wdetail.np_deduct       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"'  wdetail.np_company72    '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"'  wdetail.np_comdate72    '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"'  wdetail.np_expdate72    '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"'  wdetail.np_prmcomp      '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K"  '"'  wdetail.np_drino        '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K"  '"'  wdetail.np_garage       '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K"  '"'  wdetail.np_access       '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K"  '"'  wdetail.np_editadd      '"' SKIP.               
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K"  '"'  wdetail.np_benname      '"' SKIP.                           
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K"  '"'  wdetail.np_remak        '"' SKIP.                         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K"  '"'  wdetail.np_complete     '"' SKIP.                     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K"  '"'  wdetail.np_release      '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K"  '"'  wdetail.np_comment      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K"  '"'  wdetail.np_producer     '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K"  '"'  wdetail.np_agent        '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K"  '"'  wdetail.np_product      '"' SKIP. 


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
FOR EACH wdetail.

    FIND LAST sicuw.uwm301 USE-INDEX uwm30103 WHERE sicuw.uwm301.trareg      = TRIM(wdetail.np_cha_no)  AND
                                             SUBSTR(sicuw.uwm301.policy,3,2) = "70"                     NO-LOCK NO-ERROR. 
    IF AVAIL sicuw.uwm301 THEN DO:
        
        FIND LAST sicuw.uwm100 USE-INDEX uwm10020 WHERE sicuw.uwm100.prvpol = TRIM(wdetail.np_prepol) NO-LOCK NO-ERROR.
        IF AVAIL sicuw.uwm100 THEN DO:
            wdetail.np_product = sicuw.uwm100.cr_1.
                                  
            FIND LAST sic_exp.uwm100  WHERE sic_exp.uwm100.policy = sicuw.uwm100.prvpol NO-LOCK NO-ERROR.
            IF AVAIL sic_exp.uwm100 THEN DO:
                ASSIGN 
                    wdetail.np_policy  = sic_exp.uwm100.renpol.            
            END.
            ELSE DO:
                ASSIGN
                    wdetail.np_policy  = ""
                    wdetail.np_comment = "".               
            END.
                ASSIGN fi_process = "Match file Policy and Update Status " + TRIM(wdetail.np_contract) .
                    DISP fi_process WITH FRAM fr_main.
            
                    FIND LAST brstat.tlt WHERE 
                        brstat.tlt.nor_noti_tlt = wdetail.np_notifyno AND 
                        brstat.tlt.genusr       = "Aycal"      NO-ERROR NO-WAIT.
                    IF AVAIL tlt THEN
                        ASSIGN 
                            brstat.tlt.releas   = "Yes"  
                            brstat.tlt.comp_pol =  sicuw.uwm100.policy.
                    
                    RELEASE tlt.
            
                    FIND LAST sicuw.uwm120 USE-INDEX uwm12001 WHERE
                             sicuw.uwm120.policy = sicuw.uwm301.policy AND
                             sicuw.uwm120.rencnt = sicuw.uwm301.rencnt AND
                             sicuw.uwm120.endcnt = sicuw.uwm301.endcnt AND
                             sicuw.uwm120.riskgp = sicuw.uwm301.riskgp AND
                             sicuw.uwm120.riskno = sicuw.uwm301.riskno NO-LOCK NO-WAIT.
                    IF AVAIL sicuw.uwm120 THEN DO:                      
                        IF  DECI(wdetail.np_premium) <> uwm120.prem_r THEN 
                            ASSIGN wdetail.np_comment = "เบี้ย Excel ไม่ตรง Premium : " + wdetail.np_premium + "/" + STRING(uwm120.prem_r).
                        ELSE ASSIGN wdetail.np_comment = "เบี้ยตรง".           
                    END.                   
        END.
        ELSE DO:
            ASSIGN
                wdetail.np_policy  = ""
                wdetail.np_comment = "".             
        END.
        

/*
FOR EACH wdetail.

    FIND LAST sicuw.uwm301 USE-INDEX uwm30103 WHERE                     
              sicuw.uwm301.trareg      = TRIM(wdetail.np_cha_no)  AND
       SUBSTR(sicuw.uwm301.policy,3,2) = "70"  /*Add A59-0059*/
    NO-LOCK NO-ERROR. 
    IF AVAIL sicuw.uwm301 THEN DO:
/*Add Jiraphon A59-0451*/
        FOR EACH  sicuw.uwm100 USE-INDEX uwm10001 WHERE
                  sicuw.uwm100.policy = sicuw.uwm301.policy AND
                  sicuw.uwm100.rencnt = sicuw.uwm301.rencnt AND
                  sicuw.uwm100.endcnt = sicuw.uwm301.endcnt.
                  
                 IF sicuw.uwm100.comdat <> DATE(wdetail.np_comdate)  AND
                    sicuw.uwm100.expdat <> DATE(wdetail.np_expdate)  THEN DO:
                    ASSIGN 
                        wdetail.np_policy  = ""
                        wdetail.np_comment = "".   
                 END.
                 ELSE DO:
                    ASSIGN 
                        wdetail.np_policy  = sicuw.uwm100.policy
                        wdetail.np_product = sicuw.uwm100.cr_1.

                    ASSIGN fi_process = "Match file Policy and Update Status " + TRIM(wdetail.np_contract) .
                    DISP fi_process WITH FRAM fr_main.
            
                    FIND LAST brstat.tlt WHERE 
                        brstat.tlt.nor_noti_tlt = wdetail.np_notifyno AND 
                        brstat.tlt.genusr       = "Aycal"      NO-ERROR NO-WAIT.
                    IF AVAIL tlt THEN
                        ASSIGN 
                            brstat.tlt.releas   = "Yes"  
                            brstat.tlt.comp_pol =  sicuw.uwm100.policy.
                    
                    RELEASE tlt.
            
                    FIND LAST sicuw.uwm120 USE-INDEX uwm12001 WHERE
                             sicuw.uwm120.policy = sicuw.uwm301.policy AND
                             sicuw.uwm120.rencnt = sicuw.uwm301.rencnt AND
                             sicuw.uwm120.endcnt = sicuw.uwm301.endcnt AND
                             sicuw.uwm120.riskgp = sicuw.uwm301.riskgp AND
                             sicuw.uwm120.riskno = sicuw.uwm301.riskno NO-LOCK NO-WAIT.
                    IF AVAIL sicuw.uwm120 THEN DO:
                        
                        IF  DECI(wdetail.np_premium) <> uwm120.prem_r THEN 
                            ASSIGN wdetail.np_comment = "เบี้ย Excel ไม่ตรง Premium : " + wdetail.np_premium + "/" + STRING(uwm120.prem_r).
                        ELSE ASSIGN wdetail.np_comment = "เบี้ยตรง".
            
                    END.

                 END.
        END. 
/*End Jiraphon A59-0451*/  --Comment*/
   

        /*--Comment Jiraphon A59-0451
        FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE
                  sicuw.uwm100.policy = sicuw.uwm301.policy AND
                  sicuw.uwm100.rencnt = sicuw.uwm301.rencnt AND
                  sicuw.uwm100.endcnt = sicuw.uwm301.endcnt NO-LOCK NO-ERROR.
        IF AVAIL sicuw.uwm100 THEN DO:
            ASSIGN 
                wdetail.np_policy  = sicuw.uwm100.policy
                wdetail.np_product = sicuw.uwm100.cr_1.
        END.

        ASSIGN fi_process = "Match file Policy and Update Status " + TRIM(wdetail.np_contract) .
        DISP fi_process WITH FRAM fr_main.

        FIND LAST brstat.tlt WHERE 
            brstat.tlt.nor_noti_tlt = wdetail.np_notifyno AND 
            brstat.tlt.genusr       = "Aycal"      NO-ERROR NO-WAIT.
        IF AVAIL tlt THEN
            ASSIGN 
                brstat.tlt.releas   = "Yes"  
                brstat.tlt.comp_pol =  sicuw.uwm100.policy.
        
        RELEASE tlt.

        FIND LAST sicuw.uwm120 USE-INDEX uwm12001 WHERE
                 sicuw.uwm120.policy = sicuw.uwm301.policy AND
                 sicuw.uwm120.rencnt = sicuw.uwm301.rencnt AND
                 sicuw.uwm120.endcnt = sicuw.uwm301.endcnt AND
                 sicuw.uwm120.riskgp = sicuw.uwm301.riskgp AND
                 sicuw.uwm120.riskno = sicuw.uwm301.riskno NO-LOCK NO-WAIT.
        IF AVAIL sicuw.uwm120 THEN DO:
            /*--
            IF  DECI(wdetail.np_prekpi) <> (uwm120.prem_r + uwm120.rstp_r + uwm120.rtax_r)  THEN 
                ASSIGN wdetail.np_comment = "เบี้ยไม่ตรง : " + wdetail.np_prekpi + "/" + STRING((uwm120.prem_r + uwm120.rstp_r + uwm120.rtax_r)).
            ELSE ASSIGN wdetail.np_comment = "เบี้ยตรง".
            --*/

            IF  DECI(wdetail.np_premium) <> uwm120.prem_r THEN 
                ASSIGN wdetail.np_comment = "เบี้ย Excel ไม่ตรง Premium : " + wdetail.np_premium + "/" + STRING(uwm120.prem_r).
            ELSE ASSIGN wdetail.np_comment = "เบี้ยตรง".

        END.
        --End Comment Jiraphon A59-0451*/
    END.
    ELSE ASSIGN 
        wdetail.np_policy  = ""
        wdetail.np_comment = "".

END.      /* wdetail*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_matchfile_prem1 C-Win 
PROCEDURE Pro_matchfile_prem1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

FOR EACH wdetail .
    FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE  
              sicuw.uwm100.cedpol =  TRIM(wdetail.np_contract)  NO-LOCK NO-ERROR.
    IF AVAIL sicuw.uwm100 THEN DO:
        
         FIND LAST sic_exp.uwm100 WHERE sic_exp.uwm100.cedpol = sicuw.uwm100.cedpol NO-LOCK NO-ERROR.
         IF AVAIL sic_exp.uwm100 THEN DO:
             
                ASSIGN 
                    wdetail.np_policy  = sic_exp.uwm100.renpol.    
         END.
         ELSE DO:
             
                ASSIGN 
                    wdetail.np_policy  = ""
                    wdetail.np_comment = "". 
         END.
         
         ASSIGN fi_process = "Match file Policy and Update Status " + TRIM(wdetail.np_contract) .
         DISP fi_process WITH FRAM fr_main.
        
         FIND LAST brstat.tlt WHERE 
             brstat.tlt.nor_noti_tlt = wdetail.np_notifyno AND 
             brstat.tlt.genusr       = "Aycal"      NO-ERROR NO-WAIT.
         IF AVAIL tlt THEN
             ASSIGN 
                 brstat.tlt.releas   = "Yes"  
                 brstat.tlt.comp_pol =  wdetail.np_policy.
         
         RELEASE tlt.
         
         FIND LAST sicuw.uwm120  WHERE sicuw.uwm120.policy = wdetail.np_policy NO-LOCK NO-ERROR.
         IF AVAIL sicuw.uwm120 THEN DO:
             FIND LAST sicuw.uwm100  USE-INDEX uwm10001 WHERE sicuw.uwm100.policy = sicuw.uwm120.policy AND
                                                              sicuw.uwm100.rencnt = sicuw.uwm120.rencnt AND
                                                              sicuw.uwm100.endcnt = sicuw.uwm120.endcnt NO-LOCK NO-ERROR.
             IF AVAIL sicuw.uwm100 THEN DO:       
                 wdetail.np_product = sicuw.uwm100.cr_1.
         
                 IF  DECI(wdetail.np_premium) <> uwm120.prem_r THEN 
                     ASSIGN wdetail.np_comment = "เบี้ย Excel ไม่ตรง Premium : " + wdetail.np_premium + "/" + STRING(uwm120.prem_r).
                 ELSE ASSIGN wdetail.np_comment = "เบี้ยตรง".
             END.
         END.                                    
    END.
    ELSE DO:
           ASSIGN 
               wdetail.np_policy  = ""
               wdetail.np_comment = "". 
    END.

END.      /* wdetail*/
END PROCEDURE.
/* Comment Jiraphon A60-0078
/*Add Jiraphon A59-0451*/
    FOR EACH sicuw.uwm100 USE-INDEX uwm10002 WHERE
             sicuw.uwm100.cedpol = TRIM(wdetail.np_contract)   AND
             sicuw.uwm100.poltyp = "V70".
        IF uwm100.comdat <> DATE(wdetail.np_comdate) AND
           uwm100.expdat <> DATE(wdetail.np_expdate) THEN DO:
           ASSIGN 
                wdetail.np_policy  = ""
                wdetail.np_comment = "".   
        END.
        ELSE DO:    
            ASSIGN wdetail.np_policy  = sicuw.uwm100.policy
                   wdetail.np_product = sicuw.uwm100.cr_1.
    
            ASSIGN fi_process = "Match file Policy and Update Status " + TRIM(wdetail.np_contract) .
            DISP fi_process WITH FRAM fr_main.
    
            FIND LAST sicuw.uwm120  USE-INDEX uwm12001 WHERE
                      sicuw.uwm120.policy = sicuw.uwm100.policy AND
                      sicuw.uwm120.rencnt = sicuw.uwm100.rencnt AND
                      sicuw.uwm120.endcnt = sicuw.uwm100.endcnt NO-LOCK NO-ERROR.
            IF AVAIL sicuw.uwm120 THEN DO:
    
                nv_uw_prem = sicuw.uwm120.prem_r.
    
                IF  DECI(wdetail.np_premium) <> uwm120.prem_r THEN 
                    ASSIGN wdetail.np_comment = "เบี้ย Excel ไม่ตรง Premium : " + wdetail.np_premium + "/" + STRING(uwm120.prem_r).
                ELSE ASSIGN wdetail.np_comment = "เบี้ยตรง".
    
            END.
      
            FIND LAST brstat.tlt   WHERE 
                      brstat.tlt.nor_noti_tlt = wdetail.np_notifyno AND 
                      brstat.tlt.genusr       =  "Aycal"           NO-ERROR NO-WAIT.
            IF AVAIL tlt THEN
                ASSIGN 
                    brstat.tlt.releas   = "Yes"  
                    brstat.tlt.comp_pol =  sicuw.uwm100.policy.          
            RELEASE tlt.    
            END.
    END.
/*End Jiraphon A59-0451*/  End Comment Jiraphon A60-0078*/
    /*--Comment Jiraphon A59-0451
    FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE  
              sicuw.uwm100.cedpol =  TRIM(wdetail.np_contract)  NO-LOCK NO-ERROR.
    IF AVAIL sicuw.uwm100 THEN DO:

        ASSIGN wdetail.np_policy  = sicuw.uwm100.policy
               wdetail.np_product = sicuw.uwm100.cr_1.

        ASSIGN fi_process = "Match file Policy and Update Status " + TRIM(wdetail.np_contract) .
        DISP fi_process WITH FRAM fr_main.

        FIND LAST sicuw.uwm120  USE-INDEX uwm12001 WHERE
                  sicuw.uwm120.policy = sicuw.uwm100.policy AND
                  sicuw.uwm120.rencnt = sicuw.uwm100.rencnt AND
                  sicuw.uwm120.endcnt = sicuw.uwm100.endcnt NO-LOCK NO-ERROR.
        IF AVAIL sicuw.uwm120 THEN DO:

            nv_uw_prem = sicuw.uwm120.prem_r.

            /*--
            IF  DECI(wdetail.np_prekpi) <> (uwm120.prem_r + uwm120.rstp_r + uwm120.rtax_r)  THEN 
                ASSIGN wdetail.np_comment = "เบี้ยไม่ตรง : " + wdetail.np_prekpi + "/" + STRING((uwm120.prem_r + uwm120.rstp_r + uwm120.rtax_r)).
            ELSE ASSIGN wdetail.np_comment = "เบี้ยตรง".
            ---*/

            IF  DECI(wdetail.np_premium) <> uwm120.prem_r THEN 
                ASSIGN wdetail.np_comment = "เบี้ย Excel ไม่ตรง Premium : " + wdetail.np_premium + "/" + STRING(uwm120.prem_r).
            ELSE ASSIGN wdetail.np_comment = "เบี้ยตรง".

        END.

        /*--- ไว้ปรับคราวหลัง --
        FIND LAST sic_exp.uwm120 USE-INDEX uwm12001 WHERE
                  sic_exp.uwm120.policy = sicuw.uwm100.policy AND
                  sic_exp.uwm120.rencnt = sicuw.uwm100.rencnt AND
                  sic_exp.uwm120.endcnt = sicuw.uwm100.endcnt NO-LOCK NO-ERROR.
        IF AVAIL sic_exp.uwm120 THEN DO:

            FIND LAST sic_exp.uwm130 USE-INDEX uwm13001 WHERE
                      sic_exp.uwm130.policy = sic_exp.uwm120.policy AND
                      sic_exp.uwm130.rencnt = sic_exp.uwm120.rencnt AND
                      sic_exp.uwm130.endcnt = sic_exp.uwm120.endcnt AND
                      sic_exp.uwm130.riskgp = sic_exp.uwm120.riskgp AND
                      sic_exp.uwm130.riskno = sic_exp.uwm120.riskno NO-LOCK NO-ERROR.
            IF AVAIL sic_exp.uwm130 THEN DO:
                nv_fptr = sic_exp.uwm130.fptr03.
                nv_bptr = 0.
                DO WHILE nv_fptr <> 0 AND sic_exp.uwm130.fptr03 <> ? :
                    FIND sic_exp.uwd132 WHERE RECID(sic_exp.uwd132) = nv_fptr NO-LOCK NO-ERROR.
                    IF AVAIL sic_exp.uwd132 THEN DO:
                        nv_fptr = sic_exp.uwd132.fptr.
        
                        IF sic_exp.uwd132.bencod = "COMP" THEN DO:
                            nv_comp = uwd132.gap_c.
                        END.
                    END.
                END.
            END.

            nv_exp_prem = sic_exp.uwm120.prem_r - nv_comp.
        END.

        IF DECI(wdetail.np_prekpi) <> nv_exp_prem THEN DO:
            ASSIGN
                wdetail.np_comment = "เบี้ย Expiry ไม่ตรงกับ Excel File : " + wdetail.np_prekpi + "/" + STRING(nv_exp_prem).
        END.
        ELSE IF nv_exp_prem <> nv_uw_prem THEN DO:
            ASSIGN
                wdetail.np_comment = "เบี้ย Expiry ไม่ตรงกับ Premium : " + STRING(nv_exp_prem) + "/" + STRING(nv_uw_prem).
        END.
        ELSE DO:
            ASSIGN
                wdetail.np_comment = "เบี้ยตรง".
        END.
        ---*/

        FIND LAST brstat.tlt   WHERE 
                  brstat.tlt.nor_noti_tlt = wdetail.np_notifyno AND 
                  brstat.tlt.genusr       =  "Aycal"           NO-ERROR NO-WAIT.
        IF AVAIL tlt THEN
            ASSIGN 
                brstat.tlt.releas   = "Yes"  
                brstat.tlt.comp_pol =  sicuw.uwm100.policy.
        
        RELEASE tlt.
    END.
    ELSE ASSIGN 
            wdetail.np_policy  = ""
            wdetail.np_comment = " ".
    --End Comment Jiraphon A59-0451*/




/*FOR EACH wdetail .

    FIND FIRST sicuw.uwm100 USE-INDEX uwm10002 WHERE                     
              sicuw.uwm100.cedpol =  TRIM(wdetail.np_notifyno)  NO-LOCK NO-ERROR. 

    IF AVAIL sicuw.uwm100 THEN DO:
        /*MESSAGE  wdetail.np_notifyno VIEW-AS ALERT-BOX.*/

        ASSIGN 
            wdetail.np_policy  = sicuw.uwm100.policy
            wdetail.np_product = sicuw.uwm100.cr_1.

        /*--
        FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE
                  sicuw.uwm100.policy = sicuw.uwm301.policy AND
                  sicuw.uwm100.rencnt = sicuw.uwm301.rencnt AND
                  sicuw.uwm100.endcnt = sicuw.uwm301.endcnt NO-LOCK NO-ERROR.
        IF AVAIL sicuw.uwm100 THEN DO:
            ASSIGN 
                wdetail.np_policy  = sicuw.uwm100.policy
                wdetail.np_product = sicuw.uwm100.cr_1.
        END.
        --*/

        ASSIGN fi_process = "Match file Policy and Update Status " + TRIM(wdetail.np_contract) .
        DISP fi_process WITH FRAM fr_main.

        FIND LAST brstat.tlt WHERE 
            brstat.tlt.nor_noti_tlt = wdetail.np_notifyno AND 
            brstat.tlt.genusr       = "Aycal"      NO-ERROR NO-WAIT.
        IF AVAIL tlt THEN
            ASSIGN 
                brstat.tlt.releas   = "Yes"  
                brstat.tlt.comp_pol =  sicuw.uwm100.policy.
        
        RELEASE tlt.

        FOR EACH sicuw.uwm120 USE-INDEX uwm12001 WHERE
                 sicuw.uwm120.policy = sicuw.uwm100.policy AND
                 sicuw.uwm120.rencnt = sicuw.uwm100.rencnt AND
                 sicuw.uwm120.endcnt = sicuw.uwm100.endcnt NO-LOCK:

            IF  DECI(wdetail.np_prekpi) <> (uwm120.prem_r + uwm120.rstp_r + uwm120.rtax_r)  THEN 
                ASSIGN wdetail.np_comment = "เบี้ยไม่ตรง : " + wdetail.np_prekpi + "/" + STRING((uwm120.prem_r + uwm120.rstp_r + uwm120.rtax_r)).
            ELSE ASSIGN wdetail.np_comment = "เบี้ยตรง".

        END.

    END.
    ELSE ASSIGN 
        wdetail.np_policy  = ""
        wdetail.np_comment = " ".

END.      /* wdetail*/
END PROCEDURE.*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_matchfile_prem_new C-Win 
PROCEDURE Pro_matchfile_prem_new :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH vehreg:
    DELETE vehreg.
END.
vehcnt  = 1.
chacnt  = 1.

FOR EACH wdetail.  
    IF TRIM(wdetail.np_prepol) <> ""  THEN DO:  /* A61-0573 */
        FIND LAST sicuw.uwm100 USE-INDEX uwm10020 WHERE sicuw.uwm100.prvpol = TRIM(wdetail.np_prepol) NO-LOCK NO-ERROR.
        IF AVAIL sicuw.uwm100 THEN DO:
            wdetail.np_product = sicuw.uwm100.cr_1.
                                  
            FIND LAST sic_exp.uwm100 USE-INDEX uwm10001 WHERE sic_exp.uwm100.policy = sicuw.uwm100.prvpol NO-LOCK NO-ERROR.
            IF AVAIL sic_exp.uwm100 THEN DO:
                ASSIGN 
                    wdetail.np_policy  = sic_exp.uwm100.renpol.            
            END.
            ELSE DO:
                ASSIGN
                    wdetail.np_policy  = ""
                    wdetail.np_comment = "".               
            END.

            ASSIGN fi_process = "Match file Policy and Update Status " + TRIM(wdetail.np_contract) .
                DISP fi_process WITH FRAM fr_main.
                /* comment by A61-0573 ...
                FIND LAST brstat.tlt WHERE 
                    brstat.tlt.nor_noti_tlt = wdetail.np_notifyno AND 
                    brstat.tlt.genusr       = "Aycal"      NO-ERROR NO-WAIT.
               ... end A61-0573....*/
                /* create by A61-0573 */
                FIND LAST brstat.tlt USE-INDEX tlt06 WHERE 
                    brstat.tlt.cha_no       = TRIM(wdetail.np_cha_no) AND
                    brstat.tlt.nor_effdat   = DATE(TRIM(wdetail.np_comdate)) AND 
                    brstat.tlt.expodat      = DATE(TRIM(wdetail.np_expdate)) AND 
                    brstat.tlt.genusr       = "Aycal"      NO-ERROR NO-WAIT.
                /* end A61-0573 */
                IF AVAIL tlt THEN
                    ASSIGN 
                        brstat.tlt.releas   = "Yes"  
                        brstat.tlt.comp_pol =  sicuw.uwm100.policy.
                
                RELEASE tlt.
        
                FIND LAST sicuw.uwm120 USE-INDEX uwm12001 WHERE
                         sicuw.uwm120.policy = sicuw.uwm100.policy AND
                         sicuw.uwm120.rencnt = sicuw.uwm100.rencnt AND
                         sicuw.uwm120.endcnt = sicuw.uwm100.endcnt NO-LOCK NO-WAIT.
                IF AVAIL sicuw.uwm120 THEN DO:                      
                    IF  DECI(wdetail.np_premium) <> uwm120.prem_r THEN 
                        ASSIGN wdetail.np_comment = "เบี้ย Excel ไม่ตรง Premium : " + wdetail.np_premium + "/" + STRING(uwm120.prem_r).
                    ELSE ASSIGN wdetail.np_comment = "เบี้ยตรง".           
                END.                   
        END.
    END.

    IF wdetail.np_policy = "" THEN DO: /*หาเลขทะเบียนรถ*/   /* A61-0573 */
                
                n_veh = IF R-INDEX(wdetail.np_vehreg," ") <> 0 THEN TRIM(SUBSTR(wdetail.np_vehreg,R-INDEX(wdetail.np_vehreg," "))) ELSE " ".
                FOR EACH sicuw.uwm500 USE-INDEX uwm50001 WHERE sicuw.uwm500.prov_n >= "กก"  NO-LOCK:                                                              
                    CREATE vehreg.
                    ASSIGN
                        tprov_n = sicuw.uwm500.prov_n 
                        tprov_d = SUBSTR(sicuw.uwm500.prov_d,3).
                END.
                
                
                FOR EACH vehreg WHERE tprov_d =  n_veh NO-LOCK :
                  IF AVAIL vehreg THEN DO:
                      n_veh1 = SUBSTR(TRIM(wdetail.np_vehreg),1,r-INDEX(wdetail.np_vehreg," ")) + tprov_n.
                      
                      FOR EACH sicuw.uwm301 USE-INDEX uwm30102 WHERE sicuw.uwm301.vehreg = n_veh1 NO-LOCK :
                          IF AVAIL sicuw.uwm301 THEN DO:
                              nv_vehreg[vehcnt] = uwm301.policy.
                              vehcnt = vehcnt + 1.    
                          END.
                      END.
                       
                      DO vehcnt = 1 TO 20 :                   
                          FIND sicuw.uwm100  WHERE sicuw.uwm100.policy = nv_vehreg[vehcnt] AND
                                                   sicuw.uwm100.comdat = DATE(TRIM(wdetail.np_comdate)) AND
                                                   sicuw.uwm100.expdat = DATE(TRIM(wdetail.np_expdate)) NO-LOCK NO-ERROR.
                          IF AVAIL sicuw.uwm100 THEN DO:
                              wdetail.np_policy = sicuw.uwm100.policy.  
    
                              ASSIGN fi_process = "Match file Policy and Update Status " + TRIM(wdetail.np_contract) .
                              DISP fi_process WITH FRAM fr_main.
                              
                           /* comment by A61-0573 ...
                           FIND LAST brstat.tlt WHERE 
                               brstat.tlt.nor_noti_tlt = wdetail.np_notifyno AND 
                               brstat.tlt.genusr       = "Aycal"      NO-ERROR NO-WAIT.
                          ... end A61-0573....*/
                           /* create by A61-0573 */
                           FIND LAST brstat.tlt USE-INDEX tlt06 WHERE 
                               brstat.tlt.cha_no       = TRIM(wdetail.np_cha_no) AND
                               brstat.tlt.nor_effdat   = DATE(TRIM(wdetail.np_comdate)) AND 
                               brstat.tlt.expodat      = DATE(TRIM(wdetail.np_expdate)) AND 
                               brstat.tlt.genusr       = "Aycal"      NO-ERROR NO-WAIT.
                           /* end A61-0573 */
                              IF AVAIL tlt THEN
                                  ASSIGN 
                                      brstat.tlt.releas   = "Yes"  
                                      brstat.tlt.comp_pol =  sicuw.uwm100.policy.
                              
                              RELEASE tlt.
                          
                              FIND LAST sicuw.uwm120 USE-INDEX uwm12001 WHERE
                                       sicuw.uwm120.policy = sicuw.uwm100.policy AND
                                       sicuw.uwm120.rencnt = sicuw.uwm100.rencnt AND
                                       sicuw.uwm120.endcnt = sicuw.uwm100.endcnt NO-LOCK NO-WAIT.
                              IF AVAIL sicuw.uwm120 THEN DO:                      
                                  IF  DECI(wdetail.np_premium) <> uwm120.prem_r THEN 
                                      ASSIGN wdetail.np_comment = "เบี้ย Excel ไม่ตรง Premium : " + wdetail.np_premium + "/" + STRING(uwm120.prem_r).
                                  ELSE ASSIGN wdetail.np_comment = "เบี้ยตรง".           
                              END.  
                          END.           
                      END.                    
                      nv_vehreg = "" .
                      vehcnt = 1.
                  END. 
                END.
                IF wdetail.np_policy = "" THEN DO:  /*ทะเบียนไม่เจอ  หาเลขถัง*/
                       
                       FOR EACH sicuw.uwm301 USE-INDEX uwm30103 WHERE sicuw.uwm301.trareg  = TRIM(wdetail.np_cha_no)  AND
                                                                      SUBSTR(sicuw.uwm301.policy,3,2) = "70"  NO-LOCK :
                           IF AVAIL sicuw.uwm301 THEN DO:                              
                               nv_chano[chacnt] = uwm301.policy.
                               chacnt = chacnt + 1.                               
                           END. 
                           ELSE wdetail.np_policy  = "".
                       END.

                       DO chacnt = 1 TO 20 :                   
                          FIND sicuw.uwm100  WHERE sicuw.uwm100.policy = trim(nv_chano[chacnt]) AND
                                                   sicuw.uwm100.comdat = DATE(TRIM(wdetail.np_comdate)) AND
                                                   sicuw.uwm100.expdat = DATE(TRIM(wdetail.np_expdate)) NO-LOCK NO-ERROR.
                          IF AVAIL sicuw.uwm100 THEN DO:
                              wdetail.np_policy = sicuw.uwm100.policy.  

                              ASSIGN fi_process = "Match file Policy and Update Status " + TRIM(wdetail.np_contract) .
                              DISP fi_process WITH FRAM fr_main.
                          
                            /* comment by A61-0573 ...
                            FIND LAST brstat.tlt WHERE 
                                brstat.tlt.nor_noti_tlt = wdetail.np_notifyno AND 
                                brstat.tlt.genusr       = "Aycal"      NO-ERROR NO-WAIT.
                           ... end A61-0573....*/
                            /* create by A61-0573 */
                            FIND LAST brstat.tlt USE-INDEX tlt06 WHERE 
                                brstat.tlt.cha_no       = TRIM(wdetail.np_cha_no) AND
                                brstat.tlt.nor_effdat   = DATE(TRIM(wdetail.np_comdate)) AND 
                                brstat.tlt.expodat      = DATE(TRIM(wdetail.np_expdate)) AND 
                                brstat.tlt.genusr       = "Aycal"      NO-ERROR NO-WAIT.
                            /* end A61-0573 */
                              IF AVAIL tlt THEN
                                  ASSIGN 
                                      brstat.tlt.releas   = "Yes"  
                                      brstat.tlt.comp_pol =  sicuw.uwm100.policy.
                              
                              RELEASE tlt.
                          
                              FIND LAST sicuw.uwm120 USE-INDEX uwm12001 WHERE
                                       sicuw.uwm120.policy = sicuw.uwm100.policy AND
                                       sicuw.uwm120.rencnt = sicuw.uwm100.rencnt AND
                                       sicuw.uwm120.endcnt = sicuw.uwm100.endcnt NO-LOCK NO-WAIT.
                              IF AVAIL sicuw.uwm120 THEN DO:                      
                                  IF  DECI(wdetail.np_premium) <> uwm120.prem_r THEN 
                                      ASSIGN wdetail.np_comment = "เบี้ย Excel ไม่ตรง Premium : " + wdetail.np_premium + "/" + STRING(uwm120.prem_r).
                                  ELSE ASSIGN wdetail.np_comment = "เบี้ยตรง".           
                              END.  
    
                          END.
                         
                       END.
                       nv_chano = "".
                       chacnt = 1.        
                END.               
        END.    
END.    /* wdetail*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

