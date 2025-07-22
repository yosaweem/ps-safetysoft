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
  program id   :  wgwklpo1.w
  program name :  Match File Load Policy  KL[ลิสซิ่งกสิกรไทย] 
  create by    :  Kridtiya i. A57-0244  15/08/2014    
  copy write   : wuwtstex.w                                            */
  /*Modify by  : Ranu i. A59-0182 Date 10/06/2016 เพิ่มคอลัมน์ 
                Beneficiary ,Producer , Agent , Payment , Tracking , Promotion */
/*Modify by : Kridtiya i. A66-0108 Match Policy assign to table tlt */
/************************************************************************/
CREATE WIDGET-POOL.
/* ***************************  Definitions  ************************** */
/* Parameters Definitions ---                                           */
/* Local Variable Definitions ---                                       */
DEFINE NEW SHARED TEMP-TABLE wdetail
    FIELD   policyprm       AS CHAR FORMAT "x(20)"  INIT ""
    FIELD   poltyp          AS CHAR FORMAT "x(20)"  INIT ""
    field   branch          AS CHAR FORMAT "x(10)"  INIT "" 
    field   applino         AS CHAR FORMAT "x(20)"  INIT "" 
    field   cedpol          AS CHAR FORMAT "x(20)"  INIT "" 
    field   sticker         AS CHAR FORMAT "x(20)"  INIT "" 
    field   prepol          AS CHAR FORMAT "x(16)"  INIT "" 
    field   cover           AS CHAR FORMAT "x(3)"   INIT "" 
    field   notifytyp       AS CHAR FORMAT "x(10)"  INIT "" 
    field   titlnam         AS CHAR FORMAT "x(20)"  INIT "" 
    field   name1           AS CHAR FORMAT "x(100)" INIT "" 
    field   companynam      AS CHAR FORMAT "x(100)" INIT "" 
    field   occoup          AS CHAR FORMAT "x(100)" INIT "" 
    field   idno            AS CHAR FORMAT "x(15)"  INIT "" 
    field   EAddress1       AS CHAR FORMAT "x(60)"  INIT "" 
    field   EAddress2       AS CHAR FORMAT "x(50)"  INIT "" 
    field   EAddress3       AS CHAR FORMAT "x(50)"  INIT "" 
    field   EAddress4       AS CHAR FORMAT "x(50)"  INIT "" 
    field   telno           AS CHAR FORMAT "x(20)"  INIT "" 
    field   NAME_tax        AS CHAR FORMAT "x(100)" INIT "" 
    field   addr_txt        AS CHAR FORMAT "x(100)" INIT "" 
    field   drinam1         AS CHAR FORMAT "x(60)" INIT "" 
    field   dribht1         AS CHAR FORMAT "x(20)" INIT "" 
    field   driage1         AS CHAR FORMAT "x(10)" INIT "" 
    field   dricr1          AS CHAR FORMAT "x(20)" INIT "" 
    field   driid1          AS CHAR FORMAT "x(20)" INIT "" 
    field   drinam2         AS CHAR FORMAT "x(60)" INIT "" 
    field   dribht2         AS CHAR FORMAT "x(20)" INIT "" 
    field   driage2         AS CHAR FORMAT "x(10)" INIT "" 
    field   dricr2          AS CHAR FORMAT "x(20)" INIT "" 
    field   driid2          AS CHAR FORMAT "x(20)" INIT "" 
    field   effecdat        AS CHAR FORMAT "x(20)" INIT "" 
    field   expirdat        AS CHAR FORMAT "x(20)" INIT "" 
    field   brand           AS CHAR FORMAT "x(30)" INIT "" 
    field   model           AS CHAR FORMAT "x(60)" INIT "" 
    field   cYEAR           AS CHAR FORMAT "x(10)" INIT "" 
    field   lisen           AS CHAR FORMAT "x(11)" INIT "" 
    field   chassis         AS CHAR FORMAT "x(30)" INIT "" 
    field   engine          AS CHAR FORMAT "x(30)" INIT "" 
    field   engcc           AS CHAR FORMAT "x(20)" INIT "" 
    field   tonnage         AS CHAR FORMAT "x(10)" INIT "" 
    field   seat            AS CHAR FORMAT "x(10)" INIT "" 
    field   sumins          AS CHAR FORMAT "x(20)" INIT "" 
    field   netprm          AS CHAR FORMAT "x(20)" INIT "" 
    field   grossprm        AS CHAR FORMAT "x(20)" INIT "" 
    field   prmp            AS CHAR FORMAT "x(20)" INIT "" 
    field   totalp          AS CHAR FORMAT "x(20)" INIT "" 
    field   garage          AS CHAR FORMAT "x(10)" INIT "" 
    field   access          AS CHAR FORMAT "x(10)" INIT "" 
    field   aecsdes         AS CHAR FORMAT "x(60)" INIT "" 
    field   memo            AS CHAR FORMAT "x(100)" INIT "" 
    field   remark          AS CHAR FORMAT "x(100)" INIT "" 
    field   vehCVMI         AS CHAR FORMAT "x(10)" INIT "" 
    field   TPBI_Person     AS CHAR FORMAT "x(20)" INIT "" 
    field   TPBI_Accident   AS CHAR FORMAT "x(20)" INIT "" 
    field   TPPD_Accident   AS CHAR FORMAT "x(20)" INIT "" 
    field   no41            AS CHAR FORMAT "x(20)" INIT "" 
    field   no42            AS CHAR FORMAT "x(20)" INIT "" 
    field   no43            AS CHAR FORMAT "x(20)" INIT "" 
    field   VATCODE         AS CHAR FORMAT "x(10)" INIT "" 
    field   ISP_NO          AS CHAR FORMAT "x(20)" INIT "" 
    field   Campaign        AS CHAR FORMAT "x(30)" INIT ""
    FIELD   Benefic         AS CHAR FORMAT "x(50)" INIT ""     /*A59-0182*/ 
    FIELD   producer        AS CHAR FORMAT "x(10)" INIT ""     /*A59-0182*/ 
    FIELD   agent           AS CHAR FORMAT "x(10)" INIT ""     /*A59-0182*/ 
    FIELD   payment         AS CHAR FORMAT "X(20)" INIT ""    /*A59-0182*/
    FIELD   track           AS CHAR FORMAT "x(60)" INIT ""    /*A59-0182*/
    FIELD   promo           AS CHAR FORMAT "x(15)" INIT ""  .  /*A59-0182*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_filename fi_outfile bu_ok bu_file bu_exit ~
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
     SIZE 66 BY 1.05
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_outfile AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 70 BY 1.05
     BGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-76
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 95 BY 8.57
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-77
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 19.5 BY 1.57
     BGCOLOR 1 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_filename AT ROW 3.67 COL 16.5 COLON-ALIGNED NO-LABEL
     fi_outfile AT ROW 4.95 COL 16.5 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 7.05 COL 70.5
     bu_file AT ROW 3.67 COL 85
     bu_exit AT ROW 7.05 COL 79.17
     "      Input File :":30 VIEW-AS TEXT
          SIZE 15 BY 1.05 AT ROW 3.67 COL 3
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "   Output File :" VIEW-AS TEXT
          SIZE 15 BY 1.05 AT ROW 4.95 COL 3
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "                                  Match File Load Policy  KL[ลิสซิ่งกสิกรไทย]" VIEW-AS TEXT
          SIZE 89.17 BY 1.43 AT ROW 1.48 COL 3
          BGCOLOR 2 FGCOLOR 7 FONT 6
     RECT-76 AT ROW 1.14 COL 1.5
     RECT-77 AT ROW 6.76 COL 68.83
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 96.33 BY 8.91
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
         TITLE              = "IMPORT TEXT FILE K-Lising"
         HEIGHT             = 8.86
         WIDTH              = 95.83
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
ON END-ERROR OF C-Win /* IMPORT TEXT FILE K-Lising */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* IMPORT TEXT FILE K-Lising */
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
        ASSIGN fi_filename  = cvData
            fi_outfile      = IF index(cvdata,".csv") <> 0 THEN SUBSTR(cvdata,1,index(cvdata,".csv") - 1 ) + "_pol.csv" ELSE "".
        DISP fi_filename fi_outfile WITH FRAME fr_main.     
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok C-Win
ON CHOOSE OF bu_ok IN FRAME fr_main /* Ok */
DO:
    IF fi_filename = ""  THEN DO:
        MESSAGE "Please insert file Input !!!" VIEW-AS ALERT-BOX.
        APPLY "entry" TO fi_filename.
        RETURN NO-APPLY.
    END.
    IF fi_outfile = ""  THEN DO:
        MESSAGE "Please insert file Output !!!" VIEW-AS ALERT-BOX.
        APPLY "entry" TO fi_outfile.
        RETURN NO-APPLY.
    END.
    For each  wdetail :
        DELETE  wdetail.
    END.
    INPUT FROM VALUE(fi_FileName).
    REPEAT:
        CREATE wdetail.
        IMPORT DELIMITER "|"     
            wdetail.branch      
            wdetail.applino
            wdetail.cedpol
            wdetail.sticker                   
            wdetail.prepol                       
            wdetail.cover                       
            wdetail.notifytyp                   
            wdetail.titlnam                     
            wdetail.name1        
            wdetail.companynam                      
            wdetail.occoup                     
            wdetail.idno             
            wdetail.EAddress1                          
            wdetail.EAddress2                         
            wdetail.EAddress3                         
            wdetail.EAddress4                         
            wdetail.telno                
            wdetail.NAME_tax       
            wdetail.addr_txt      
            wdetail.drinam1       
            wdetail.dribht1       
            wdetail.driage1       
            wdetail.dricr1        
            wdetail.driid1        
            wdetail.drinam2       
            wdetail.dribht2       
            wdetail.driage2       
            wdetail.dricr2        
            wdetail.driid2        
            wdetail.effecdat      
            wdetail.expirdat      
            wdetail.brand         
            wdetail.model         
            wdetail.cYEAR         
            wdetail.lisen       
            wdetail.chassis    
            wdetail.engine     
            wdetail.engcc      
            wdetail.tonnage    
            wdetail.seat           
            wdetail.sumins     
            wdetail.netprm     
            wdetail.grossprm   
            wdetail.prmp       
            wdetail.totalp     
            wdetail.garage                           
            wdetail.access         
            wdetail.aecsdes       
            wdetail.memo
            wdetail.remark
            wdetail.vehCVMI  
            wdetail.poltyp
            wdetail.TPBI_Person     
            wdetail.TPBI_Accident  
            wdetail.TPPD_Accident  
            wdetail.no41           
            wdetail.no42           
            wdetail.no43           
            wdetail.VATCODE      
            wdetail.ISP_NO      
            wdetail.Campaign
            wdetail.Benefic     /*A59-0182*/
            wdetail.producer    /*A59-0182*/
            wdetail.agent       /*A59-0182*/
            wdetail.payment     /*A59-0182*/ 
            wdetail.track       /*A59-0182*/
            wdetail.promo.       /*A59-0182*/  
    END.  /* repeat  */
    Run  Pro_createfile.
    MESSAGE  "Export Data Complete " VIEW-AS ALERT-BOX.
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
  
  gv_prgid = "wgwklpo1".
  gv_prog  = "IMPORT TEXT FILE K-Lising Send To KL[ลิสซิ่งกสิกรไทย]".
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
  DISPLAY fi_filename fi_outfile 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_filename fi_outfile bu_ok bu_file bu_exit RECT-76 RECT-77 
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
IF INDEX(fi_outfile,".csv") = 0  THEN fi_outfile = fi_outfile + ".csv".
OUTPUT TO VALUE(fi_outfile). 
FOR EACH  wdetail NO-LOCK .
    IF INDEX(wdetail.branch,"text") <> 0 THEN DO:
        EXPORT DELIMITER "|"  
            wdetail.branch      
            wdetail.applino
            wdetail.cedpol
            wdetail.sticker .
    END.
END.
EXPORT DELIMITER "|" 
    "สาขา"   
    "เลขกรมธรรม์"
    "เลขที่ใบคำขอ"                       
    "เลขที่รับแจ้ง"                 
    "เลขที่สติ๊กเกอร์"              
    "เลขที่กรมธรรม์เดิม"            
    "ประเภทความคุ้มครอง "           
    "ประเภทที่แจ้งงาน"              
    "คำนำหน้าชื่อผู้เอาประกันภัย"   
    "ชื่อผู้เอาประกันภัย"           
    "ชื่อบริษัทรถประจำตำแหน่ง"   
    "Occup./อาชีพ"
    "ID/บัตรประชาชน"
    "ที่อยู่1"                      
    "ที่อยู่2"                      
    "ที่อยู่3"                      
    "ที่อยู่4"                      
    "เบอร์โทรศัพท์"                 
    "ชื่อที่ออกใบกำกับภาษี"         
    "ที่อยู่ออกใบกำกับภาษี"         
    "ชื่อ/นามสกุล1 "                
    "วัน/เดือน/ปีเกิด 1"           
    "อายุ1"                        
    "เลขที่บัตรประชาชน 1"          
    "เลขที่ใบขับขี่1"              
    "ชื่อ/นามสกุล 2"               
    "วัน/เดือน/ปีเกิด2 "           
    "อายุ2"                        
    "เลขที่บัตรประชาชน 2"          
    "เลขที่ใบขับขี่2"              
    "วันที่เริ่มคุ้มครอง"          
    "วันที่สิ้นสุด "               
    "ยี่ห้อ"                       
    "รุ่น"                         
    "ปีที่จดทะเบียน"               
    "ทะเบียนรถ"                    
    "เลขตัวถัง"                    
    "เลขเครื่องยนต์ "                     
    "ขนาดเครื่องยนต์"              
    "น้ำหนัก"                      
    "จำนวนที่นั่ง" 
    "ทุนประกัน "                   
    "เบี้ยสุทธิ "                  
    "เบี้ยรวมภาษีอากร"             
    "เบี้ยพรบ"                     
    "เบี้ยรวมพรบ"                        
    "ซ่อม(0:อู่ห้าง,1:อู่ในเครือ)"       
    "อุปกรณ์เสริม"                       
    "รายละเอียดอุปกรณ์เสริม"             
    "หมายเหตุ"
    "รหัสตัวแทน" 
    "ลักษณะการใช้งาน"  
    "ประเภทกรมธรรม์"
    "Per Person (BI)"   
    "Per Accident"      
    "Per Accident(PD)"  
    "4.1 SI."           
    "4.2 Sum"           
    "4.3 Sum"           
    "VATCODE"           
    "ISP_NO"            
    "Campaign"
    "ผู้รับผลประโยชน์"
    "Producer Code"
    "Agent Code"
    "Payment"
    "Tracking"
    "Promotion".        

FOR EACH  wdetail.
    IF wdetail.branch   = ""  THEN DELETE wdetail.
    ELSE IF INDEX(wdetail.branch,"text") <> 0 THEN DELETE wdetail.
    ELSE IF INDEX(wdetail.branch,"สาขา") <> 0 THEN DELETE wdetail.
END.
/*nv_cnt = 0.*/
FOR EACH wdetail .
    IF wdetail.cover = "T" THEN DO:
        FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE 
            sicuw.uwm100.cedpol  = wdetail.applino AND
            ((sicuw.uwm100.poltyp = "v72" ) OR
            (sicuw.uwm100.poltyp  = "v74" ) )         NO-LOCK NO-ERROR.
        IF AVAIL sicuw.uwm100 THEN
            ASSIGN wdetail.policyprm = sicuw.uwm100.policy.
    END.
    ELSE DO:
        FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE 
            sicuw.uwm100.cedpol = wdetail.applino AND
            sicuw.uwm100.poltyp   = "V70" NO-LOCK NO-ERROR.
        IF AVAIL sicuw.uwm100 THEN
            ASSIGN wdetail.policyprm = sicuw.uwm100.policy.
    END.

    IF wdetail.payment = "Unpaid" THEN DO:
        IF INDEX(wdetail.track,"PMIB") <> 0 THEN ASSIGN wdetail.track  = "ยังไม่ชำระเบี้ยประกัน/ส่งกธ.+พรบ.กลับมาที่ PMIB ".
        IF TRIM(wdetail.track) = "" THEN ASSIGN wdetail.track  = "ยังไม่ชำระเบี้ยประกัน/ส่งกธ.+พรบ.ลูกค้าตามที่อยู่". 
    END.
    IF wdetail.payment = "Paid" THEN DO:
        IF INDEX(wdetail.track,"PMIB") <> 0 THEN ASSIGN wdetail.track  = "ชำระเบี้ยประกันแล้ว/ส่งกธ.+พรบ.กลับมาที่ PMIB".
        IF INDEX(wdetail.track,"ลูกค้า") <> 0 THEN ASSIGN wdetail.track  = "ชำระเบี้ยประกันแล้ว/ส่งกธ.+พรบ.ลูกค้าตามที่อยู่".
        IF TRIM(wdetail.track) = "" THEN ASSIGN wdetail.track  = "ชำระเบี้ยประกันแล้ว/ส่งกธ.+พรบ.ลูกค้าตามที่อยู่". 
    END.
    /*A66-0108*/
    FIND LAST brstat.tlt WHERE
        tlt.genusr   =  "K-LEASING"       AND 
        tlt.lotno    =  TRIM(wdetail.applino) NO-ERROR NO-WAIT.
    IF AVAIL brstat.tlt THEN DO:
        IF wdetail.poltyp  = "V70"  THEN 
             ASSIGN tlt.nor_noti_ins  = wdetail.policyprm.
        ELSE ASSIGN tlt.comp_noti_tlt = wdetail.policyprm.
        ASSIGN tlt.nor_usr_tlt  = wdetail.prepol.
    END.
    /*A66-0108*/
    EXPORT DELIMITER "|" 
            wdetail.branch 
            wdetail.policyprm 
            wdetail.applino
            wdetail.cedpol
            wdetail.sticker                   
            wdetail.prepol                       
            wdetail.cover                       
            wdetail.notifytyp                   
            wdetail.titlnam                     
            wdetail.name1        
            wdetail.companynam                      
            wdetail.occoup                     
            wdetail.idno             
            wdetail.EAddress1                          
            wdetail.EAddress2                         
            wdetail.EAddress3                         
            wdetail.EAddress4                         
            wdetail.telno                
            wdetail.NAME_tax       
            wdetail.addr_txt      
            wdetail.drinam1       
            wdetail.dribht1       
            wdetail.driage1       
            wdetail.dricr1        
            wdetail.driid1        
            wdetail.drinam2       
            wdetail.dribht2       
            wdetail.driage2       
            wdetail.dricr2        
            wdetail.driid2        
            wdetail.effecdat      
            wdetail.expirdat      
            wdetail.brand         
            wdetail.model         
            wdetail.cYEAR         
            wdetail.lisen       
            wdetail.chassis    
            wdetail.engine     
            wdetail.engcc      
            wdetail.tonnage    
            wdetail.seat           
            wdetail.sumins     
            wdetail.netprm     
            wdetail.grossprm   
            wdetail.prmp       
            wdetail.totalp     
            wdetail.garage                           
            wdetail.access         
            wdetail.aecsdes       
            wdetail.memo
            wdetail.remark
            wdetail.vehCVMI  
            wdetail.poltyp  
            wdetail.TPBI_Person     
            wdetail.TPBI_Accident  
            wdetail.TPPD_Accident  
            wdetail.no41           
            wdetail.no42           
            wdetail.no43           
            wdetail.VATCODE      
            wdetail.ISP_NO      
            wdetail.Campaign
            wdetail.Benefic     /*A59-0182*/
            wdetail.producer    /*A59-0182*/
            wdetail.agent       /*A59-0182*/
            wdetail.payment     /*A59-0182*/
            wdetail.track       /*A59-0182*/
            wdetail.promo.      /*A59-0182*/
END.
OUTPUT CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

