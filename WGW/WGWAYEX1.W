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

  Created: Porntiwa P.  A58-0361  Date : 25/09/2015
         : โปรแกรมเรียกรายงานค้างชำระ AYCAL
         
  DB CONNECT : SICUW;SICSYAC;GW_SAFE -LD SIC_BRAN;GW_STAT -LD BRSTAT       

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
DEFINE VAR nv_print AS LOGICAL.
DEFINE VAR nv_total AS INTE.
DEFINE VAR nv_name  AS CHAR.
DEFINE VAR nv_surname AS CHAR.
DEFINE VAR nv_title AS CHAR.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME frmain

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-529 RECT-530 RECT-531 RECT-532 RECT-533 ~
fi_trndat1 fi_trndat2 fi_output buOK buexit fi_txt1 
&Scoped-Define DISPLAYED-OBJECTS fi_trndat1 fi_trndat2 fi_output fi_txt1 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON buexit 
     LABEL "Exit" 
     SIZE 7 BY 1
     FONT 6.

DEFINE BUTTON buOK 
     LABEL "OK" 
     SIZE 7 BY 1
     FONT 6.

DEFINE VARIABLE fi_output AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 55.5 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_trndat1 AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_trndat2 AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_txt1 AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 55.5 BY 1 NO-UNDO.

DEFINE RECTANGLE RECT-529
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 78.83 BY 1.33
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-530
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 8.83 BY 1.43
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-531
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 8.83 BY 1.43
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-532
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 76.5 BY 3.1
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-533
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 76.5 BY 2
     BGCOLOR 8 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME frmain
     fi_trndat1 AT ROW 4.1 COL 15.67 COLON-ALIGNED NO-LABEL
     fi_trndat2 AT ROW 4.1 COL 38.67 COLON-ALIGNED NO-LABEL
     fi_output AT ROW 6.19 COL 15.67 COLON-ALIGNED NO-LABEL
     buOK AT ROW 8.24 COL 61.17
     buexit AT ROW 8.24 COL 70.67
     fi_txt1 AT ROW 8.14 COL 2.5 NO-LABEL
     "วันที่รับแจ้ง :" VIEW-AS TEXT
          SIZE 13.5 BY .95 AT ROW 2.81 COL 3
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "To :" VIEW-AS TEXT
          SIZE 4 BY .91 AT ROW 4.14 COL 35.17
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "Form :" VIEW-AS TEXT
          SIZE 6.5 BY .91 AT ROW 4.14 COL 9.5
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "Export File Excel [AYCAL]" VIEW-AS TEXT
          SIZE 24.5 BY .91 AT ROW 1.29 COL 3
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "Output File :" VIEW-AS TEXT
          SIZE 13.5 BY .95 AT ROW 6.24 COL 3.5
          BGCOLOR 8 FGCOLOR 2 FONT 6
     RECT-529 AT ROW 1.1 COL 1.17
     RECT-530 AT ROW 8 COL 69.67
     RECT-531 AT ROW 8 COL 60.17
     RECT-532 AT ROW 2.71 COL 2.5
     RECT-533 AT ROW 5.71 COL 2.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 116.17 BY 23.29.


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
         TITLE              = "WGWAYEX1.W"
         HEIGHT             = 8.86
         WIDTH              = 79.33
         MAX-HEIGHT         = 23.29
         MAX-WIDTH          = 116.33
         VIRTUAL-HEIGHT     = 23.29
         VIRTUAL-WIDTH      = 116.33
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
/* SETTINGS FOR FRAME frmain
                                                                        */
/* SETTINGS FOR FILL-IN fi_txt1 IN FRAME frmain
   ALIGN-L                                                              */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* WGWAYEX1.W */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* WGWAYEX1.W */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buexit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buexit C-Win
ON CHOOSE OF buexit IN FRAME frmain /* Exit */
DO:
  APPLY "CLOSE" TO THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buOK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buOK C-Win
ON CHOOSE OF buOK IN FRAME frmain /* OK */
DO:
  OUTPUT TO VALUE(fi_output).
  EXPORT DELIMITER "|"
      "ลำดับ"
      "Company"
      "Product"
      "Brnach"
      "Contract"
      "Title"
      "ชื่อ"
      "นามสกุล"
      "ที่อยู่ 1"
      "ที่อยู่ 2"
      "ที่อยู่ 3"
      "ที่อยู่ 4"
      "ยี่ห้อรถ"
      "รุ่นรถ"
      "สี"
      "เลขทะเบียน"
      "จังหวัดที่จดทะเบียน"
      "ปีรถ"
      "CC."
      "เลขตัวถัง"
      "เลขเครื่อง"
      "Code ผู้แจ้ง"
      "เลขกรมธรรม์เดิม"
      "วันคุ้มครองประกัน"
      "วันหมดประกัน"
      "ทุนประกัน"
      "ค่าเบี้ยสุทธิ"
      "ค่าเบี้ยรวมภาษีอาการ"
      " "
      "ปีประกัน"
      "เลขรับแจ้ง"
      "เลขบัตรประชาชน"
      "หมายเหตุ"
      "วันที่แจ้ง"
      "Deduct"
      "Code บ.ประกัน พรบ."
      "วันคุ้มครอง พรบ."
      "วันหมดพรบ."
      "ค่าพรบ."
      "ระบุผู้ขับขี่"
      "ซ่อมห้าง"
      "คุ้มครองอุปกรณ์เพิ่มเติม"
      "แก้ไขที่อยู่"
      "Warning".

  nv_total = 0.

  FOR EACH brstat.tlt USE-INDEX tlt02 WHERE
           brstat.tlt.datesent >= fi_trndat1 AND
           brstat.tlt.datesent <= fi_trndat2 AND 
           brstat.tlt.genusr    = "aycal"    AND
           brstat.tlt.releas    = "NO"       NO-LOCK:

      /*nv_print = NO.*/    

      IF brstat.tlt.releas <> "CA" AND brstat.tlt.nor_noti_ins <> "" THEN DO:
          FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE
                    sicuw.uwm100.policy = brstat.tlt.nor_noti_ins NO-LOCK NO-ERROR.
          IF NOT AVAIL sicuw.uwm100 THEN DO:
              FIND LAST sicuw.uwm301 USE-INDEX uwm30103 WHERE
                        sicuw.uwm301.trareg = brstat.tlt.cha_no NO-LOCK NO-ERROR NO-WAIT.
              IF NOT AVAIL sicuw.uwm301 THEN DO:
                  RUN PDProcess.
              END.
          END.
          ELSE DO:
              IF sicuw.uwm100.renpol = "" THEN DO:
                  RUN PDProcess.
              END.
          END.

          /*---
          FIND LAST sic_exp.uwm100 USE-INDEX uwm10001 WHERE
                    sic_exp.uwm100.policy = brstat.tlt.nor_noti_ins NO-LOCK NO-ERROR.
          IF NOT AVAIL sic_exp.uwm100 THEN DO:
    
              FIND LAST sicuw.uwm301 USE-INDEX uwm30103 WHERE 
                        sicuw.uwm301.trareg = brstat.tlt.cha_no
              NO-LOCK NO-ERROR NO-WAIT.
              IF AVAIL sicuw.uwm301 THEN DO:
                  FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE
                            sicuw.uwm100.policy = sicuw.uwm301.policy AND
                            sicuw.uwm100.rencnt = sicuw.uwm301.rencnt AND
                            sicuw.uwm100.endcnt = sicuw.uwm301.endcnt NO-LOCK NO-ERROR.
                  IF AVAIL sicuw.uwm100 THEN DO:
                      IF sicuw.uwm100.comdat = brstat.tlt.nor_effdat THEN DO:
                          /*Not Process*/
                      END.
                      ELSE DO:
                          IF sicuw.uwm100.expdat <= brstat.tlt.nor_effdat THEN DO:
                              RUN PDProcess.
                          END.
                      END.
                  END.
              END.
              ELSE DO:
                  RUN PDProcess.
              END.
    
          END.
          ELSE DO:
              IF sic_exp.uwm100.renpol = "" AND sic_exp.uwm100.releas = NO THEN DO:
    
                  FIND LAST sicuw.uwm301 USE-INDEX uwm30103 WHERE
                            sicuw.uwm301.trareg = brstat.tlt.cha_no
                  NO-LOCK NO-ERROR NO-WAIT.
                  IF AVAIL sicuw.uwm301 THEN DO:
                      FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE
                                sicuw.uwm100.policy = sicuw.uwm301.policy AND
                                sicuw.uwm100.rencnt = sicuw.uwm301.rencnt NO-LOCK NO-ERROR NO-WAIT.
                      IF AVAIL sicuw.uwm100 THEN DO:
                          IF sicuw.uwm100.prvpol = brstat.tlt.nor_noti_ins THEN DO:
                              /*Not Process*/
                          END.
                          ELSE DO:
                              IF sicuw.uwm100.expdat <= brstat.tlt.nor_effdat THEN DO:
                                  RUN PDProcess.
                              END.
                          END.
                      END.
                  END.
                  ELSE DO:
                      RUN PDProcess.
                  END.
              END.
          END.
          --*/
      END.
  END.

  MESSAGE "Process Total : " nv_total " Records " SKIP
          "Output File : " fi_output
  VIEW-AS ALERT-BOX INFORMATION.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_output
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_output C-Win
ON LEAVE OF fi_output IN FRAME frmain
DO:
  fi_output = INPUT fi_output.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_trndat1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_trndat1 C-Win
ON LEAVE OF fi_trndat1 IN FRAME frmain
DO:
  fi_trndat1 = INPUT fi_trndat1.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_trndat2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_trndat2 C-Win
ON LEAVE OF fi_trndat2 IN FRAME frmain
DO:
  fi_trndat2 = INPUT fi_trndat2.
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

  fi_output = "U:\AYCL_Process_Cancel.CSV".
  DISPLAY fi_output WITH FRAME frmain.

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
  DISPLAY fi_trndat1 fi_trndat2 fi_output fi_txt1 
      WITH FRAME frmain IN WINDOW C-Win.
  ENABLE RECT-529 RECT-530 RECT-531 RECT-532 RECT-533 fi_trndat1 fi_trndat2 
         fi_output buOK buexit fi_txt1 
      WITH FRAME frmain IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frmain}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDProcess C-Win 
PROCEDURE PDProcess :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
nv_total = nv_total + 1.

EXPORT DELIMITER "|"
    nv_total                               /* ลำดับ */                      
    tlt.genusr                             /* Company */                    
    tlt.flag                               /* Product */                    
    tlt.comp_usr_tlt                       /* Brnach */                     
    tlt.recac                              /* Contract */                   
    ""                                     /* Title */                      
    tlt.ins_name                           /* ชื่อ */                       
    ""                                     /* นามสกุล */                    
    tlt.ins_addr1                          /* ที่อยู่ 1 */                  
    tlt.ins_addr2                          /* ที่อยู่ 2 */                  
    tlt.ins_addr3 + " " + tlt.ins_addr4    /* ที่อยู่ 3 */                  
    tlt.ins_addr5                          /* ที่อยู่ 4 */                  
    tlt.brand                              /* ยี่ห้อรถ */                   
    tlt.model                              /* รุ่นรถ */                     
    " "                                    /* สี */                         
    tlt.lince1                             /* เลขทะเบียน */                 
    tlt.lince1                             /* จังหวัดที่จดทะเบียน */        
    tlt.lince2                             /* ปีรถ */                       
    tlt.cc_weight                          /* CC. */                        
    tlt.cha_no                             /* เลขตัวถัง */                  
    tlt.eng_no                             /* เลขเครื่อง */                 
    tlt.comp_noti_tlt                      /* Code ผู้แจ้ง */               
    tlt.nor_noti_ins                       /* เลขกรมธรรม์เดิม */            
    tlt.nor_effdat                         /* วันคุ้มครองประกัน */          
    tlt.expodat                            /* วันหมดประกัน */               
    tlt.comp_coamt                         /* ทุนประกัน */                  
    tlt.dri_name2                          /* ค่าเบี้ยสุทธิ */              
    tlt.nor_grprm                          /* ค่าเบี้ยรวมภาษีอาการ */       
    " "                                    /*  */                           
    tlt.rencnt                             /* ปีประกัน */                   
    tlt.nor_noti_tlt                       /* เลขรับแจ้ง */                 
    tlt.safe2                              /* เลขบัตรประชาชน */             
    tlt.filler2                            /* หมายเหตุ */                   
    tlt.datesent                           /* วันที่แจ้ง */                 
    " "                                    /* Deduct */                     
    tlt.nor_usr_ins                        /* Code บ.ประกัน พรบ. */         
    tlt.comp_effdat                        /* วันคุ้มครอง พรบ. */           
    tlt.dat_ins_noti                       /* วันหมดพรบ. */                 
    tlt.dri_no1                            /* ค่าพรบ. */                    
    tlt.dri_name1                          /* ระบุผู้ขับขี่ */              
    tlt.stat                               /* ซ่อมห้าง */                   
    tlt.safe1                              /* คุ้มครองอุปกรณ์เพิ่มเติม */   
    tlt.filler1                            /* แก้ไขที่อยู่ */               
    "ตรวจสอบการแจ้งต่ออายุ: ไม่พบข้อมูลการชำระเบี้ย".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

