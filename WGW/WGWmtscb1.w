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
/* Local Variable Definitions ---                                           */
/*Program ID    : wgwmtscb1.w                                               */    
/*Program name : Export File Inspection Send to SCBPT                       */
/*create by    : Ranu i. A60-0488 date 16/10/2017                           */
/*              เรียกรายงานการตรวจสภาพส่ง SCBPT ตาม Format ที่กำหนด         */
/*DataBase connect : GW_SAFE -LD SIC_BRAN, GW_STAT -LD BRSTAT,SICSYAC,SICUW */
/*Modify by : Kridtiya i. Kridtiya i. A64-0295 DATE. 25/07/2021 ปรับแก้ไขรายงาน ตาม Layout new */
/*Modify BY : Kridtiya i. DATE.12/08/2022 A65-0174 ปรับตามรูปแบบใหม่*/
/*Modify By : Tontawan S. A66-0006 08/06/2023 
            : เพื่มเงื่อนไขการ Export ให้ Defult ภาษาเป็น UTF-8             */
/*-------------------------------------------------------------------------*/
DEF VAR gv_id  AS CHAR FORMAT "X(12)" NO-UNDO.  
DEF VAR n_user  AS CHAR FORMAT "X(12)" NO-UNDO. 
DEF VAR nv_pwd AS CHAR FORMAT "x(15)" NO-UNDO.  
DEF  stream ns1.

DEFINE NEW SHARED TEMP-TABLE winsp NO-UNDO
    /*FIELD RefNo           AS CHAR FORMAT "X(50)"  INIT ""  comment by Kridtiya i. A64-0295 DATE. 25/07/2021 ปิดตัวแปรเดิม เพิ่มตัวแปรใหม่ทั้งหมด
    FIELD CusCode         AS CHAR FORMAT "X(50)"  INIT ""  
    FIELD cusName         AS CHAR FORMAT "X(50)"  INIT ""  
    FIELD Surname         AS CHAR FORMAT "x(50)"  INIT ""                       
    FIELD Licence         AS CHAR FORMAT "X(50)"  INIT ""  
    FIELD Chassis         AS CHAR FORMAT "X(20)"  INIT ""  
    FIELD Insp_date       AS CHAR FORMAT "X(15)"  INIT ""  
    FIELD Insp_Code       AS CHAR FORMAT "X(10)"  INIT ""  
    FIELD Insp_Result     AS CHAR FORMAT "X(30)"  INIT ""  
    FIELD Insp_Detail     AS CHAR FORMAT "X(700)" INIT ""  
    FIELD Insp_Remark1    AS CHAR FORMAT "X(700)" INIT ""  
    FIELD Insp_Remark2    AS CHAR FORMAT "X(700)" INIT ""
    FIELD insp_status     AS CHAR FORMAT "x(10)"  INIT "" 
    FIELD insp_no         AS CHAR FORMAT "x(20)"  INIT ""
    FIELD insp_damage     as CHAR format "x(1000)" INIT ""
    FIELD insp_driver     as CHAR format "x(500)" INIT ""
    FIELD Insp_other      as CHAR format "x(500)" INIT "".   comment by Kridtiya i. A64-0295 DATE. 25/07/2021  */  
    field n_no        as  char  format "X(10)"    /*Add by Kridtiya i. A64-0295 DATE. 25/07/2021  เพิ่มตัวแปรใหม่*/
    field inscode     as  char  format "X(50)"    
    field campcode    as  char  format "X(50)"    
    field campname    as  char  format "X(50)"    
    field procode     as  char  format "X(50)"    
    field proname     as  char  format "X(50)"    
    field packcode    as  char  format "X(50)"    
    field packname    as  char  format "X(50)"    
    field Refno       as  char  format "X(50)"
    FIELD custcode    AS  CHAR  FORMAT "x(20)"
    field pol_fname   as  char  format "X(50)"    
    field pol_lname   as  char  format "X(50)"    
    field pol_tel     as  char  format "X(20)"
    field tmp1        as  char  format "X(50)"    
    field tmp2        as  char  format "X(50)"  
    field instype     as  char  format "X(50)"    
    field inspdate    as  CHAR  FORMAT "x(10)"                    
    field insptime    as  CHAR  FORMAT "x(10)"                   
    field inspcont    as  char  format "X(50)"    
    field insptel     as  char  format "X(20)"    
    field lineid      as  char  format "X(50)"    
    field mail        as  char  format "X(50)"    
    field inspaddr    as  CHAR  format "X(500)"   
    field brand       as  char  format "X(20)"    
    field Model       as  char  format "X(50)"    
    field class       as  char  format "X(5)"     
    field seatenew    as  char  format "x(10)"              
    field power       as  char  format "x(10)"              
    field weight      as  char  format "x(10)"              
    field province    as  char  format "x(100)"   
    field yrmanu      as  char  format "x(4)"     
    field licence     as  char  format "x(10)"    
    field chassis     as  char  format "x(50)"    
    field engine      as  char  format "x(50)"    
    field comdat      as  char  format "x(10)"                    
    field expdat      as  char  format "x(10)"                   
    field ins_amt     as  CHAR format "x(18)"     
    field premtotal   as  char format "x(10)"     
    field acc1        as  char format "x(50)"     
    field accdetail1  as  char format "x(100)"    
    field accprice1   as  CHAR format "x(18)"     
    field acc2        as  char format "x(50)"     
    field accdetail2  as  char format "x(100)"    
    field accprice2   as  CHAR format "x(18)"     
    field acc3        as  char format "x(50)"     
    field accdetail3  as  char format "x(100)"    
    field accprice3   as  CHAR format "x(18)"     
    field acc4        as  char format "x(50)"     
    field accdetail4  as  char format "x(100)"    
    field accprice4   as  CHAR format "x(18)"     
    field acc5        as  char format "x(50)"     
    field accdetail5  as  char format "x(100)"    
    field accprice5   as  CHAR format "x(18)"  
    FIELD pass        AS  CHAR FORMAT "x(3)" 
    FIELD Selling_Channel AS  CHAR FORMAT "x(30)"   
    FIELD insp_status     AS CHAR FORMAT "x(10)"  INIT "" 
    FIELD Insp_date       AS CHAR FORMAT "X(15)"  INIT "" 
    FIELD Insp_Code       AS CHAR FORMAT "X(10)"  INIT ""   
    FIELD Insp_Result     AS CHAR FORMAT "X(30)"  INIT "" 
    FIELD Insp_Detail     AS CHAR FORMAT "X(700)" INIT "" 
    FIELD Insp_Remark1    AS CHAR FORMAT "X(700)" INIT ""  
    FIELD Insp_Remark2    AS CHAR FORMAT "X(700)" INIT ""  
    FIELD insp_no         AS CHAR FORMAT "x(20)"  INIT "" 
    FIELD insp_damage     as CHAR format "x(1000)" INIT ""
    FIELD insp_driver     as CHAR format "x(500)" INIT ""
    FIELD Insp_other      as CHAR format "x(500)" INIT ""
    FIELD Car_Inspection_Result  as CHAR format "x(500)" INIT ""     
    FIELD Detial_Car_Inspection  as CHAR format "x(500)" INIT "" 
    . 
/*Kridtiya i. A64-0295 DATE. 25/07/2021*/ 

Def  Var chNotesSession  As Com-Handle.
Def  Var chNotesDataBase As Com-Handle.
Def  Var chDocument      As Com-Handle.
Def  Var chNotesView     As Com-Handle .
Def  Var chNavView       As Com-Handle .
Def  Var chViewEntry     As Com-Handle .
Def  Var chItem          As Com-Handle .
Def  Var chData          As Com-Handle .
Def  Var nv_server       As Char.
Def  Var nv_tmp          As char .
DEF VAR nv_year          AS CHAR FORMAT "x(5)" .
DEF VAR nv_docno         AS CHAR FORMAT "x(25)".
DEF VAR nv_survey        AS CHAR FORMAT "x(25)".
DEF VAR nv_detail        AS CHAR FORMAT "x(30)".
DEF VAR nv_remark1       AS CHAR FORMAT "x(250)".
DEF VAR nv_remark2       AS CHAR FORMAT "x(250)".
DEF VAR nv_damlist       AS CHAR FORMAT "x(150)" INIT "" .
DEF VAR nv_damage        AS CHAR FORMAT "x(250)" INIT "" .
DEF VAR nv_totaldam      AS CHAR FORMAT "X(150)" .
DEF VAR nv_attfile       AS CHAR FORMAT "x(100)" INIT "" .
DEF VAR nv_device        AS CHAR FORMAT "x(500)" INIT "".
Def var nv_acc1          as char format "x(50)".   
Def var nv_acc2          as char format "x(50)".   
Def var nv_acc3          as char format "x(50)".   
Def var nv_acc4          as char format "x(50)".   
Def var nv_acc5          as char format "x(50)".   
Def var nv_acc6          as char format "x(50)".   
Def var nv_acc7          as char format "x(50)".   
Def var nv_acc8          as char format "x(50)".   
Def var nv_acc9          as char format "x(50)".   
Def var nv_acc10         as char format "x(50)".   
Def var nv_acc11         as char format "x(50)".   
Def var nv_acc12         as char format "x(50)".   
Def var nv_acctotal      as char format "x(250)".   
DEF VAR nv_surdata       AS CHAR FORMAT "x(250)".
DEF VAR nv_date          AS CHAR FORMAT "x(15)".

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_outload bu_ok bu_exit-2 fi_year ~
fi_transform fi_transto RECT-381 RECT-382 RECT-383 
&Scoped-Define DISPLAYED-OBJECTS fi_outload fi_year fi_transform fi_transto 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_exit-2 
     LABEL "Exit" 
     SIZE 7.5 BY 1.05
     FONT 6.

DEFINE BUTTON bu_ok 
     LABEL "OK" 
     SIZE 7.5 BY 1.05
     FONT 6.

DEFINE VARIABLE fi_outload AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 68 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_transform AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15.5 BY 1
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_transto AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15.5 BY 1
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_year AS CHARACTER FORMAT "X(5)":U 
     VIEW-AS FILL-IN 
     SIZE 15.5 BY 1
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-381
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 88 BY 6.48
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-382
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10 BY 2
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-383
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10 BY 2
     BGCOLOR 2 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_outload AT ROW 5.86 COL 17 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 7.86 COL 38
     bu_exit-2 AT ROW 7.86 COL 47.83
     fi_year AT ROW 3.48 COL 25.67 COLON-ALIGNED NO-LABEL
     fi_transform AT ROW 4.67 COL 25.67 COLON-ALIGNED NO-LABEL WIDGET-ID 2
     fi_transto AT ROW 4.67 COL 46.33 COLON-ALIGNED NO-LABEL WIDGET-ID 6
     "OUTPUT FILE :" VIEW-AS TEXT
          SIZE 15.33 BY 1 AT ROW 5.86 COL 3.67
          BGCOLOR 8 FGCOLOR 2 FONT 6
     " Export Data Inspection Send to SCBPT" VIEW-AS TEXT
          SIZE 88 BY 2.14 AT ROW 1.1 COL 1.17
          BGCOLOR 30 FGCOLOR 7 FONT 2
     "INSPECTION YEAR :" VIEW-AS TEXT
          SIZE 20 BY 1 AT ROW 3.48 COL 6.33
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "** ปีของกล่องตรวจสภาพ**" VIEW-AS TEXT
          SIZE 21.17 BY 1 AT ROW 3.48 COL 44.67
          BGCOLOR 8 FGCOLOR 12 FONT 1
     "TRANSECTION DATE F:" VIEW-AS TEXT
          SIZE 24 BY 1 AT ROW 4.67 COL 3.17 WIDGET-ID 4
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "To :" VIEW-AS TEXT
          SIZE 4 BY 1 AT ROW 4.67 COL 43.67 WIDGET-ID 8
          BGCOLOR 8 FGCOLOR 2 FONT 6
     RECT-381 AT ROW 3.33 COL 1.17
     RECT-382 AT ROW 7.43 COL 46.5
     RECT-383 AT ROW 7.43 COL 36.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 88.67 BY 9
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
         TITLE              = "Match text  File Confirm Recepit (THANACHAT)"
         HEIGHT             = 8.91
         WIDTH              = 88.67
         MAX-HEIGHT         = 29.81
         MAX-WIDTH          = 123.67
         VIRTUAL-HEIGHT     = 29.81
         VIRTUAL-WIDTH      = 123.67
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
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Match text  File Confirm Recepit (THANACHAT) */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Match text  File Confirm Recepit (THANACHAT) */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit-2 C-Win
ON CHOOSE OF bu_exit-2 IN FRAME fr_main /* Exit */
DO:
  Apply "Close" to this-procedure.
  Return no-apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok C-Win
ON CHOOSE OF bu_ok IN FRAME fr_main /* OK */
DO:
    FOR EACH winsp :
        DELETE winsp.
    END.
    IF fi_outload = "" THEN DO:
        MESSAGE "File name output not Empty..!!!" SKIP
            "Insert file name Output file...!!!"      VIEW-AS ALERT-BOX.
        APPLY "Entry" TO fi_outload.
        RETURN NO-APPLY.
    END.
    /*RUN proc_chkdata. *//*Comment by Kridtiya i. A64-0295 DATE. 25/07/2021*/
    RUN proc_chkdata2.    /*Add     by Kridtiya i. A64-0295 DATE. 25/07/2021*/
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_outload
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outload C-Win
ON LEAVE OF fi_outload IN FRAME fr_main
DO:
  fi_outload = INPUT fi_outload.
  DISP fi_outload WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_transform
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_transform C-Win
ON LEAVE OF fi_transform IN FRAME fr_main
DO:
  fi_transform = INPUT fi_transform.
  DISP fi_transform WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_transto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_transto C-Win
ON LEAVE OF fi_transto IN FRAME fr_main
DO:
  fi_transto = INPUT fi_transto.
  DISP fi_transto WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_year
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_year C-Win
ON LEAVE OF fi_year IN FRAME fr_main
DO:
  fi_year = INPUT fi_year.
  DISP fi_year WITH FRAM fr_main.
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
      gv_prgid          = "WGWMTSCB1"
      fi_year           = STRING(YEAR(TODAY),"9999")
      fi_outload        = "D:\inspection-list_" +  
                           STRING(YEAR(TODAY),"9999") + 
                           STRING(MONTH(TODAY),"99")  + 
                           STRING(DAY(TODAY),"99")    + 
                           SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                           SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + ".csv"  
      fi_transform      = TODAY
      fi_transto        = TODAY.
    
  gv_prog  = "Export Data Inspection Send to SCBPT".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).
  
      DISP fi_year fi_outload fi_transform  fi_transto  WITH FRAM fr_main.
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
  DISPLAY fi_outload fi_year fi_transform fi_transto 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_outload bu_ok bu_exit-2 fi_year fi_transform fi_transto RECT-381 
         RECT-382 RECT-383 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkdata C-Win 
PROCEDURE proc_chkdata :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Create by A59-0471     
------------------------------------------------------------------------------*/
/*
DEF VAR nv_Code    as char format "x(2)" INIT "" .
DEF VAR nv_Result  as char format "x(25)" INIT "" .

FOR EACH brstat.tlt USE-INDEX tlt04         WHERE   
   brstat.tlt.genusr       = "SCBPT"        AND 
   brstat.tlt.flag         = "INSPEC"       AND 
   brstat.tlt.stat         = "NO"           NO-LOCK.
      IF brstat.tlt.releas = "NO" THEN DO:
          RUN proc_datainsp .
      END.
      ELSE DO:
          CREATE winsp.
          ASSIGN winsp.RefNo        = brstat.tlt.nor_noti_ins
                 winsp.CusCode      = brstat.tlt.nor_usr_ins 
                 winsp.Surname      = TRIM(SUBSTR(brstat.tlt.ins_name,R-INDEX(tlt.ins_name," ")))
                 winsp.cusName      = TRIM(SUBSTR(brstat.tlt.ins_name,1,LENGTH(tlt.ins_name) - LENGTH(winsp.surname)))
                 winsp.Licence      = trim(brstat.tlt.lince1)    
                 winsp.Chassis      = trim(brstat.tlt.cha_no)
                 winsp.Insp_date    = string(brstat.tlt.datesent,"99/99/9999")
                 winsp.Insp_Code    = ""
                 winsp.Insp_Result  = "" 
                 winsp.Insp_Detail  = TRIM(brstat.tlt.safe1)
                 winsp.Insp_Remark1 = TRIM(brstat.tlt.safe2)
                 winsp.Insp_Remark2 = IF TRIM(brstat.tlt.safe3) <> "" THEN "อุปกรณ์เสริม : " + TRIM(brstat.tlt.safe3) ELSE ""
                 winsp.insp_remark2 = IF trim(brstat.tlt.filler2) <> "" THEN winsp.insp_remark2 + " ข้อมูลอื่น ๆ : " + TRIM(brstat.tlt.filler2) ELSE
                                      winsp.insp_remark2
                 winsp.insp_status  = brstat.tlt.releas.

             IF INDEX(brstat.tlt.safe1,"ไม่มีความเสียหาย") <> 0 THEN DO:
                 ASSIGN winsp.Insp_Code   = "01"
                        winsp.Insp_Result = "AU-Approve".
              END.
              ELSE IF INDEX(brstat.tlt.safe1,"มีความเสียหาย") <> 0 THEN DO:
                  ASSIGN winsp.Insp_Code   = "03"
                         winsp.Insp_Result = "AC-Approved with Condition".  
              END.
              ELSE IF INDEX(brstat.tlt.safe1,"ติดปัญหา") <> 0 THEN DO:
                  ASSIGN winsp.Insp_Code   = "04"
                         winsp.Insp_Result = "RI-Request More Info".  
              END.
      END.
END.
RELEASE brstat.tlt.
RUN proc_updatetlt.
RUN proc_reportinsp.
Message "Export data Complete"  View-as alert-box.
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkdata2 C-Win 
PROCEDURE proc_chkdata2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_Code    as char format "x(2)"   INIT "" .
DEF VAR nv_Result  as char format "x(25)"  INIT "" .
DEF VAR filler1    AS CHAR FORMAT "x(500)" INIT "" .
DEF VAR ins_addr2  AS CHAR FORMAT "x(250)" INIT "" .
DEF VAR lotno      AS CHAR FORMAT "x(250)" INIT "" .
DEF VAR usrsent    AS CHAR FORMAT "x(250)" INIT "" .

FOR EACH brstat.tlt USE-INDEX  tlt01       WHERE 
    tlt.trndat            >= fi_transform AND 
    tlt.trndat            <= fi_transto   AND 

  brstat.tlt.genusr       = "SCBPT"        AND 
  brstat.tlt.flag         = "INSPEC"      /* AND 
  brstat.tlt.stat         = "NO"     */      NO-LOCK.
    ASSIGN 
        lotno     = ""
        usrsent   = ""
        ins_addr2 = ""
        filler1   = ""   .
    /*IF brstat.tlt.releas = "NO" THEN DO:
        RUN proc_datainsp .
    END.
    ELSE DO: */
        CREATE winsp.
        ASSIGN 
          winsp.inscode         = brstat.tlt.nor_usr_ins     
          lotno                 = brstat.tlt.lotno 
          usrsent               = brstat.tlt.usrsent 
          winsp.Refno           = brstat.tlt.nor_noti_ins  
          winsp.custcode        = brstat.tlt.rec_addr1 
          winsp.pol_fname       = IF index(brstat.tlt.ins_name," ") <> 0 THEN trim(SUBSTR(brstat.tlt.ins_name,1,index(brstat.tlt.ins_name," "))) ELSE trim(brstat.tlt.ins_name)        
          winsp.pol_lname       = IF index(brstat.tlt.ins_name," ") <> 0 THEN trim(SUBSTR(brstat.tlt.ins_name,index(brstat.tlt.ins_name," ")))   ELSE trim(brstat.tlt.ins_name) 
          winsp.pol_tel         = brstat.tlt.ins_addr5       
          winsp.tmp1            = brstat.tlt.rec_addr2            
          winsp.tmp2            = brstat.tlt.rec_addr3           
          winsp.instype         = brstat.tlt.imp             
          winsp.inspdate        = string(year(brstat.tlt.nor_effdat),"9999") + "-" + 
                                  string(MONTH(brstat.tlt.nor_effdat),"99")  + "-" +
                                  string(DAY(brstat.tlt.nor_effdat),"99") 
          winsp.insptime        = brstat.tlt.old_eng         
          winsp.inspcont        = brstat.tlt.ins_addr1 
          ins_addr2             = brstat.tlt.ins_addr2  
          winsp.inspaddr        = brstat.tlt.ins_addr3                
          winsp.brand           = brstat.tlt.brand                   
          winsp.Model           = brstat.tlt.model  
          winsp.class           = brstat.tlt.expotim               
          winsp.seatenew        = string(brstat.tlt.sentcnt)                
          winsp.power           = replace(string(brstat.tlt.rencnt),",","")                         
          winsp.weight          = string(brstat.tlt.cc_weight)              
          winsp.province        = brstat.tlt.lince2             
          winsp.yrmanu          = brstat.tlt.gentim                 
          winsp.licence         = brstat.tlt.lince1                 
          winsp.chassis         = brstat.tlt.cha_no          
          winsp.engine          = brstat.tlt.eng_no           
          winsp.comdat          = string(year(brstat.tlt.gendat),"9999") + "-" + 
                                  string(MONTH(brstat.tlt.gendat),"99")  + "-" + 
                                  string(DAY(brstat.tlt.gendat),"99")     
          winsp.expdat          = string(year(brstat.tlt.expodat),"9999") + "-" +  
                                  string(MONTH(brstat.tlt.expodat),"99") + "-" + 
                                  string(DAY(brstat.tlt.expodat),"99")   
          winsp.ins_amt         = replace(string(brstat.tlt.nor_coamt),",","")                
          winsp.premtotal       = replace(string(brstat.tlt.comp_coamt),",","")   
          filler1               = brstat.tlt.filler1
          winsp.Selling_Channel = brstat.tlt.note5 
          winsp.insp_status     = brstat.tlt.releas 
          winsp.Insp_Result     = brstat.tlt.note6
                
              .    
       
      IF INDEX(lotno,"CamName:")   <> 0 THEN ASSIGN winsp.campname = SUBSTR(lotno,index(lotno,"CamName:"))     lotno   = SUBSTR(lotno,1,index(lotno,"CamName:") - 1 ).  
      IF INDEX(lotno,"CamCode:")   <> 0 THEN ASSIGN winsp.campcode = SUBSTR(lotno,index(lotno,"CamCode:"))     lotno   = SUBSTR(lotno,1,index(lotno,"CamCode:") - 1 ).  
      /*
      IF INDEX(usrsent,"ProCode:") <> 0 THEN ASSIGN winsp.packnam  = SUBSTR(usrsent,index(usrsent,"ProCode:")) usrsent = SUBSTR(usrsent,1,index(usrsent,"ProCode:") - 1 ).  
      IF INDEX(usrsent,"ProName:") <> 0 THEN ASSIGN winsp.packcode = SUBSTR(usrsent,index(usrsent,"ProName:")) usrsent = SUBSTR(usrsent,1,index(usrsent,"ProName:") - 1 ).  
      IF INDEX(usrsent,"PlanCod:") <> 0 THEN ASSIGN winsp.proname  = SUBSTR(usrsent,index(usrsent,"PlanCod:")) usrsent = SUBSTR(usrsent,1,index(usrsent,"PlanCod:") - 1 ).  
      IF INDEX(usrsent,"PlanNam:") <> 0 THEN ASSIGN winsp.procode  = SUBSTR(usrsent,index(usrsent,"PlanNam:")) usrsent = SUBSTR(usrsent,1,index(usrsent,"PlanNam:") - 1 ).
      */
      IF INDEX(usrsent,"ProCode:") <> 0 THEN 
          ASSIGN winsp.packnam  = SUBSTR(usrsent,index(usrsent,"ProCode:")) .
      IF INDEX(usrsent,"ProName:") <> 0 THEN 
          ASSIGN winsp.packnam  = SUBSTR(usrsent,1,index(usrsent,"ProName:") - 1 )
                 winsp.packcode = SUBSTR(usrsent,index(usrsent,"ProName:")) 
                 usrsent  = SUBSTR(usrsent,index(usrsent,"ProName:") - 1 ).  
      
      IF INDEX(usrsent,"PlanCod:") <> 0 THEN 
          ASSIGN winsp.packcode = SUBSTR(usrsent,1,index(usrsent,"PlanCod:") - 1 ) 
                 winsp.proname  = SUBSTR(usrsent,index(usrsent,"PlanCod:")) 
                 usrsent  = SUBSTR(usrsent,index(usrsent,"PlanCod:") - 1 ).  
      IF INDEX(usrsent,"PlanNam:") <> 0 THEN 
          ASSIGN winsp.proname  = SUBSTR(usrsent,1,index(usrsent,"PlanNam:") - 1 ) 
                 winsp.procode  = SUBSTR(usrsent,index(usrsent,"PlanNam:")) 
                 usrsent  = SUBSTR(usrsent,index(usrsent,"PlanNam:") - 1 ).
      winsp.campname = trim(replace(winsp.campname,"CamName:",""))  .   
      winsp.campcode = trim(replace(winsp.campcode,"CamCode:","")) .   
      winsp.packnam  = trim(replace(winsp.packnam,"ProCode:",""))  .
      winsp.packcode = trim(replace(winsp.packcode,"ProName:","")) .
      winsp.proname  = trim(replace(winsp.proname,"PlanCod:",""))  .
      winsp.procode  = trim(replace(winsp.procode,"PlanNam:",""))  .

      IF INDEX(ins_addr2,"InspMal:") <> 0 THEN ASSIGN winsp.mail    = replace(SUBSTR(ins_addr2,index(ins_addr2,"InspMal:")),"InspMal:","")   ins_addr2 = SUBSTR(ins_addr2,1,index(ins_addr2,"InspMal:") - 1 ).  
      IF INDEX(ins_addr2,"InspLin:") <> 0 THEN ASSIGN winsp.lineid  = replace(SUBSTR(ins_addr2,index(ins_addr2,"InspLin:")),"InspLin:","")   ins_addr2 = SUBSTR(ins_addr2,1,index(ins_addr2,"InspLin:") - 1 ).  
      IF INDEX(ins_addr2,"InspTel:") <> 0 THEN ASSIGN winsp.insptel = replace(SUBSTR(ins_addr2,index(ins_addr2,"InspTel:")),"InspTel:","")   ins_addr2 = SUBSTR(ins_addr2,1,index(ins_addr2,"InspTel:") - 1 ).  
      IF index(filler1,"Acp5:") <> 0 THEN ASSIGN winsp.accprice5  = replace(SUBSTR(filler1,index(filler1,"Acp5:")),"Acp5:","")  filler1     = SUBSTR(filler1,1,index(filler1,"Acp5:") - 1 ).     
      IF index(filler1,"Acd5:") <> 0 THEN assign winsp.accdetail5 = replace(SUBSTR(filler1,index(filler1,"Acd5:")),"Acd5:","")  filler1     = SUBSTR(filler1,1,index(filler1,"Acd5:") - 1 ).                                          
      IF index(filler1,"Acc5:") <> 0 THEN assign winsp.acc5       = replace(SUBSTR(filler1,index(filler1,"Acc5:")),"Acc5:","")  filler1     = SUBSTR(filler1,1,index(filler1,"Acc5:") - 1 ).   
      IF index(filler1,"Acp4:") <> 0 THEN assign winsp.accprice4  = replace(SUBSTR(filler1,index(filler1,"Acp4:")),"Acp4:","")  filler1     = SUBSTR(filler1,1,index(filler1,"Acp4:") - 1 ).   
      IF index(filler1,"Acd4:") <> 0 THEN assign winsp.accdetail4 = replace(SUBSTR(filler1,index(filler1,"Acd4:")),"Acd4:","")  filler1     = SUBSTR(filler1,1,index(filler1,"Acd4:") - 1 ).   
      IF index(filler1,"Acc4:") <> 0 THEN assign winsp.acc4       = replace(SUBSTR(filler1,index(filler1,"Acc4:")),"Acc4:","")  filler1     = SUBSTR(filler1,1,index(filler1,"Acc4:") - 1 ).   
      IF index(filler1,"Acp3:") <> 0 THEN assign winsp.accprice3  = replace(SUBSTR(filler1,index(filler1,"Acp3:")),"Acp3:","")  filler1     = SUBSTR(filler1,1,index(filler1,"Acp3:") - 1 ).   
      IF index(filler1,"Acd3:") <> 0 THEN assign winsp.accdetail3 = replace(SUBSTR(filler1,index(filler1,"Acd3:")),"Acd3:","")  filler1     = SUBSTR(filler1,1,index(filler1,"Acd3:") - 1 ).   
      IF index(filler1,"Acc3:") <> 0 THEN assign winsp.acc3       = replace(SUBSTR(filler1,index(filler1,"Acc3:")),"Acc3:","")  filler1     = SUBSTR(filler1,1,index(filler1,"Acc3:") - 1 ).   
      IF index(filler1,"Acp2:") <> 0 THEN assign winsp.accprice2  = replace(SUBSTR(filler1,index(filler1,"Acp2:")),"Acp2:","")  filler1     = SUBSTR(filler1,1,index(filler1,"Acp2:") - 1 ).   
      IF index(filler1,"Acd2:") <> 0 THEN assign winsp.accdetail2 = replace(SUBSTR(filler1,index(filler1,"Acd2:")),"Acd2:","")  filler1     = SUBSTR(filler1,1,index(filler1,"Acd2:") - 1 ).   
      IF index(filler1,"Acc2:") <> 0 THEN assign winsp.acc2       = replace(SUBSTR(filler1,index(filler1,"Acc2:")),"Acc2:","")  filler1     = SUBSTR(filler1,1,index(filler1,"Acc2:") - 1 ).   
      IF index(filler1,"Acp1:") <> 0 THEN assign winsp.accprice1  = replace(SUBSTR(filler1,index(filler1,"Acp1:")),"Acp1:","")  filler1     = SUBSTR(filler1,1,index(filler1,"Acp1:") - 1 ).   
      IF index(filler1,"Acd1:") <> 0 THEN assign winsp.accdetail1 = replace(SUBSTR(filler1,index(filler1,"Acd1:")),"Acd1:","")  filler1     = SUBSTR(filler1,1,index(filler1,"Acd1:") - 1 ).   
      IF index(filler1,"Acc1:") <> 0 THEN assign winsp.acc1       = replace(SUBSTR(filler1,index(filler1,"Acc1:")),"Acc1:","")  filler1     = SUBSTR(filler1,1,index(filler1,"Acc1:") - 1 ).   
    /*END.*/
    RUN proc_datainsp .
    
END.
RELEASE brstat.tlt.
RUN proc_updatetlt.
RUN proc_reportinsp.
Message "Export data Complete"  View-as alert-box.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_datainsp C-Win 
PROCEDURE proc_datainsp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

 DO:   
    DEF VAR n_list      AS INT init 0.
    DEF VAR n_count     AS INT init 0.
    DEF VAR n_repair    AS CHAR FORMAT "x(10)" init "".
    DEF VAR n_dam       AS CHAR FORMAT "x(10)" init "".
    DEF VAR n_deatil    AS CHAR FORMAT "x(60)" init "".
    DEF VAR nv_damag    AS CHAR FORMAT "x(30)" init "".
    DEF VAR nv_repair   AS CHAR FORMAT "x(30)" init "".
    DEF VAR nv_damdetail AS LONGCHAR  INIT "". 
    DEF VAR n_agent      AS CHAR FORMAT "x(12)" INIT "".

     ASSIGN  nv_year     = ""     nv_docno  = ""      nv_survey   = ""    nv_detail  = ""     nv_remark1 = ""     nv_remark2  = ""
             nv_damlist  = ""     nv_damage = ""      nv_totaldam = ""    nv_attfile = ""     nv_device  = ""     nv_acc1     = ""
             nv_acc2     = ""     nv_acc3   = ""      nv_acc4     = ""    nv_acc5    = ""     nv_acc6    = ""     nv_acc7     = ""
             nv_acc8     = ""     nv_acc9   = ""      nv_acc10    = ""    nv_acc11   = ""     nv_acc12   = ""     nv_acctotal = ""
             nv_surdata  = ""     nv_tmp    = ""      nv_date     = ""    n_agent    = ""
             nv_year     = TRIM(fi_year).
             nv_tmp      = "Inspect" + SUBSTR(nv_year,3,2) + ".nsf".
    /*--------- Server Real ----------*/
    nv_server = "Safety_NotesServer/Safety".
    nv_tmp    = "safety\uw\" + nv_tmp .
     /*-------------------------------*/
    /*---------- Server test local ------- 
    nv_server = "".
    //nv_tmp    = "D:\Lotus\Notes\Data\" + nv_tmp . -- tontawan s.
      nv_tmp    = "D:\Lotus\inspect23.nsf".*/
   /*----   Server test local     -----*/
    CREATE "Notes.NotesSession"  chNotesSession.
    chNotesDatabase  = chNotesSession:GetDatabase (nv_server,nv_tmp).

      IF  chNotesDatabase:IsOpen()  = NO  THEN  DO:
         MESSAGE "Can not open database" SKIP  
                 "Please Check database and serve" VIEW-AS  ALERT-BOX ERROR.
      END.
      chNotesView    = chNotesDatabase:GetView("เลขตัวถัง").
     /* chNavView      = chNotesView:CreateViewNav.
      chDocument     = chNotesView:GetDocumentByKey(brstat.tlt.cha_no).*/
      
      chNavView      = chNotesView:CreateViewNavFromCategory (brstat.tlt.cha_no).
      chViewEntry    = chNavView:GetLastDocument.   
      chDocument     = chViewEntry:Document. 
      
      
      IF VALID-HANDLE(chDocument) = YES THEN DO:

          chitem       = chDocument:Getfirstitem("ConsiderDate").      /*วันที่ปิดเรื่อง*/
          IF chitem <> 0 THEN nv_date = chitem:TEXT. 
          ELSE nv_date = "".
          chitem       = chDocument:Getfirstitem("docno").           /*เลขตรวจสภาพ*/
          IF chitem <> 0 THEN nv_docno = chitem:TEXT. 
          ELSE nv_docno = "".
          
          chitem       = chDocument:Getfirstitem("SurveyClose").    /* สเตตัสปิดเรื่อง */
          IF chitem <> 0 THEN nv_survey  = chitem:TEXT. 
          ELSE nv_survey = "".
          
          chitem       = chDocument:Getfirstitem("SurveyResult").  /*ผลการตรวจ*/
          IF chitem <> 0 THEN  nv_detail = chitem:TEXT. 
          ELSE nv_detail = "".
          IF nv_detail = "ติดปัญหา" THEN DO:
              chitem       = chDocument:Getfirstitem("DamageC").    /*ข้อมูลการติดปัญหา */
              IF chitem <> 0 THEN nv_damage    = chitem:TEXT.
              ELSE nv_damage = "".
          END.
          
          IF nv_detail = "มีความเสียหาย"  THEN DO:
              chitem       = chDocument:Getfirstitem("DamageList").  /* รายการความเสียหาย */
              IF chitem <> 0 THEN nv_damlist  = chitem:TEXT.
              ELSE nv_damlist = "".
              chitem       = chDocument:Getfirstitem("TotalExpensive").  /* ราคาความเสียหาย */
              IF chitem <> 0 THEN nv_totaldam  = chitem:TEXT.
              ELSE nv_totaldam = "".
             
              IF nv_damlist <> "" THEN DO: 
                  ASSIGN n_list     = INT(nv_damlist)
                         nv_damlist = "จำนวนความเสียหาย " + nv_damlist + " รายการ " .
              END.
              IF nv_totaldam <> "" THEN ASSIGN nv_totaldam = "รวมความเสียหายทั้งสิ้น " + nv_totaldam + " บาท " .
              
              IF n_list > 0  THEN DO:
                ASSIGN  n_count = 1 .
                loop_damage:
                REPEAT:
                    IF n_count <= n_list THEN DO:
                        ASSIGN  n_dam    = "List"   + STRING(n_count) 
                                n_repair = "Repair" + STRING(n_count) .
                        
                        chitem       = chDocument:Getfirstitem(n_dam).
                        IF chitem <> 0 THEN  nv_damag  = chitem:TEXT. 
                        ELSE nv_damag = "".  
                        
                        chitem       = chDocument:Getfirstitem(n_repair).
                        IF chitem <> 0 THEN  nv_repair = chitem:TEXT. 
                        ELSE nv_repair = "".
                            
                        IF nv_damag <> "" THEN  
                            ASSIGN nv_damdetail = nv_damdetail + string(n_count) + "." + nv_damag + " " + nv_repair + " , " .
                            
                        n_count = n_count + 1.
                    END.
                    ELSE LEAVE loop_damage.
                END.
            END.

          END. /* end ความเสียหาย */
          /*-- ข้อมูลอื่น ๆ ---*/
          chitem       = chDocument:Getfirstitem("SurveyData").
          IF chitem <> 0 THEN  nv_surdata = chitem:TEXT. 
          ELSE nv_surdata = "".
          IF trim(nv_surdata) <> "" THEN  nv_surdata = "ข้อมูลอื่นๆ :"  +  nv_surdata.
          /*agentCode*/
          chitem       = chDocument:Getfirstitem("agentCode").      
          IF chitem <> 0 THEN n_agent = chitem:TEXT. 
          ELSE n_agent = "".
          IF TRIM(n_agent) <> "" THEN ASSIGN nv_surdata = nv_surdata + " โค้ดตัวแทน: " + n_agent.

          /*-- อุปกรณ์เสริม --*/  
          chitem       = chDocument:Getfirstitem("device1").
          IF chitem <> 0 THEN  nv_device = chitem:TEXT. 
          ELSE nv_device = "".

          IF nv_device <> "" THEN DO:
              chitem       = chDocument:Getfirstitem("pricesTotal").  /* ราคารวมอุปกรณ์เสริม */
              IF chitem <> 0 THEN  nv_acctotal = chitem:TEXT. 
              ELSE nv_acctotal = "".
              chitem       = chDocument:Getfirstitem("DType1").
              IF chitem <> 0 THEN  nv_acc1 = chitem:TEXT. 
              ELSE nv_acc1 = "".
              chitem       = chDocument:Getfirstitem("DType2").
              IF chitem <> 0 THEN  nv_acc2 = chitem:TEXT. 
              ELSE nv_acc2 = "".
              chitem       = chDocument:Getfirstitem("DType3").
              IF chitem <> 0 THEN  nv_acc3 = chitem:TEXT. 
              ELSE nv_acc3 = "".
              chitem       = chDocument:Getfirstitem("DType4").
              IF chitem <> 0 THEN  nv_acc4 = chitem:TEXT. 
              ELSE nv_acc4 = "".
              chitem       = chDocument:Getfirstitem("DType5").
              IF chitem <> 0 THEN  nv_acc5 = chitem:TEXT. 
              ELSE nv_acc5 = "".
              chitem       = chDocument:Getfirstitem("DType6").
              IF chitem <> 0 THEN  nv_acc6 = chitem:TEXT. 
              ELSE nv_acc6 = "".
              chitem       = chDocument:Getfirstitem("DType7").
              IF chitem <> 0 THEN  nv_acc7 = chitem:TEXT. 
              ELSE nv_acc7 = "".
              chitem       = chDocument:Getfirstitem("DType8").
              IF chitem <> 0 THEN  nv_acc8 = chitem:TEXT. 
              ELSE nv_acc8 = "".
              chitem       = chDocument:Getfirstitem("DType9").
              IF chitem <> 0 THEN  nv_acc9 = chitem:TEXT. 
              ELSE nv_acc9 = "".
              chitem       = chDocument:Getfirstitem("DType10").
              IF chitem <> 0 THEN  nv_acc10 = chitem:TEXT. 
              ELSE nv_acc10 = "".
              chitem       = chDocument:Getfirstitem("DType11").
              IF chitem <> 0 THEN  nv_acc11 = chitem:TEXT. 
              ELSE nv_acc11 = "".
              chitem       = chDocument:Getfirstitem("DType12").
              IF chitem <> 0 THEN  nv_acc12 = chitem:TEXT. 
              ELSE nv_acc12 = "".
              
              ASSIGN nv_device = "อุปกรณ์เสริม : " .
              IF TRIM(nv_acc1)  <> "" THEN nv_device = nv_device + TRIM(nv_acc1).
              IF TRIM(nv_acc2)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc2).
              IF TRIM(nv_acc3)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc3).
              IF TRIM(nv_acc4)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc4).
              IF TRIM(nv_acc5)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc5).
              IF TRIM(nv_acc6)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc6).
              IF TRIM(nv_acc7)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc7).
              IF TRIM(nv_acc8)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc8).
              IF TRIM(nv_acc9)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc9).
              IF TRIM(nv_acc10) <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc10).
              IF TRIM(nv_acc11) <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc11).
              IF TRIM(nv_acc12) <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc12) .
              nv_acctotal = " ราคารวมอุปกรณ์เสริม " + nv_acctotal + " บาท " .
          END.

          IF nv_docno <> ""  THEN DO:
              /*CREATE winsp.*/

              ASSIGN winsp.RefNo        = brstat.tlt.nor_noti_ins
                     /*winsp.CusCode      = brstat.tlt.nor_usr_ins */
                     winsp.inscode      = brstat.tlt.nor_usr_ins 
                     /*winsp.Surname      = TRIM(SUBSTR(brstat.tlt.ins_name,R-INDEX(tlt.ins_name," "))) 
                     winsp.cusName      = TRIM(SUBSTR(brstat.tlt.ins_name,1,LENGTH(tlt.ins_name) - LENGTH(winsp.surname))) 
                     winsp.Surname      = TRIM(SUBSTR(brstat.tlt.ins_name,R-INDEX(tlt.ins_name," ")))
                     winsp.cusName      = TRIM(SUBSTR(brstat.tlt.ins_name,1,LENGTH(tlt.ins_name) - LENGTH(winsp.surname)))*/
                     winsp.Licence      = trim(brstat.tlt.lince1)    
                     winsp.Chassis      = trim(brstat.tlt.cha_no) .

              IF nv_survey <> "" THEN DO:
                    IF nv_detail = "ติดปัญหา" THEN DO:
                        ASSIGN  winsp.Insp_date      = nv_date
                                winsp.Insp_Code      = "04"
                                /*winsp.Insp_Result    = "RI-Request More Info"*/
                                winsp.Insp_Detail    = nv_detail + " : " + nv_damage    /* ความเสียหาย */ 
                                winsp.Insp_Remark1   = nv_device + nv_acctotal
                                winsp.insp_remark2   = nv_surdata
                                winsp.insp_no        = nv_docno                      /*เลขที่ตรวจสภาพ */              
                                winsp.insp_damage    = nv_damdetail                  /*รายการความเสียหาย */           
                                winsp.insp_driver    = nv_device + nv_acctotal       /*รายละเอียดอุปกรณ์เสริม */      
                                winsp.Insp_other     = nv_surdata                    /*รายละเอียดอื่นๆ */
                                winsp.insp_status    = "YES".
                    END.
                    ELSE IF nv_detail = "มีความเสียหาย"  THEN DO:
                        ASSIGN  winsp.Insp_date     = nv_date
                                winsp.Insp_Code     = "03"
                                /*winsp.Insp_Result   = "AC-Approved with Condition"*/
                                winsp.Insp_Detail   = nv_detail + " : " + nv_damlist + nv_totaldam  /* ความเสียหาย */ 
                                winsp.Insp_Remark1  = nv_damdetail
                                winsp.insp_remark2  = nv_device + nv_acctotal + nv_surdata
                                winsp.insp_no       = nv_docno                      /*เลขที่ตรวจสภาพ */              
                                winsp.insp_damage   = nv_damdetail                  /*รายการความเสียหาย */           
                                winsp.insp_driver   = nv_device + nv_acctotal       /*รายละเอียดอุปกรณ์เสริม */      
                                winsp.Insp_other    = nv_surdata                    /*รายละเอียดอื่นๆ */
                                winsp.insp_status   = "YES" .
                                
                    END.
                    ELSE DO: 
                        ASSIGN  winsp.Insp_date     = nv_date
                                winsp.Insp_Code     = "01"
                                /*winsp.Insp_Result   = "AU-Approve"*/
                                winsp.Insp_Detail   = nv_detail
                                winsp.Insp_Remark1  = nv_device + nv_acctotal
                                winsp.insp_remark2  = nv_surdata
                                winsp.insp_no       = nv_docno                      /*เลขที่ตรวจสภาพ */              
                                winsp.insp_damage   = ""                            /*รายการความเสียหาย */           
                                winsp.insp_driver   = nv_device + nv_acctotal       /*รายละเอียดอุปกรณ์เสริม */      
                                winsp.Insp_other    = nv_surdata                    /*รายละเอียดอื่นๆ */
                                winsp.insp_status   = "YES" .
                    END.
              END.
              ELSE DO:
                  ASSIGN  winsp.insp_no      = nv_docno       
                          winsp.insp_status  = "NO"          
                          winsp.Insp_Detail  = ""
                          winsp.insp_damage  = ""                           /*รายการความเสียหาย */       
                          winsp.insp_driver  = nv_device + nv_acctotal      /*รายละเอียดอุปกรณ์เสริม */  
                          winsp.Insp_other   = nv_surdata .                 /*รายละเอียดอื่นๆ */   
              END.
          END.

          RELEASE  OBJECT chitem          NO-ERROR.
          RELEASE  OBJECT chDocument      NO-ERROR.          
          RELEASE  OBJECT chNotesDataBase NO-ERROR.     
          RELEASE  OBJECT chNotesSession  NO-ERROR.
      END.
 END.
      
 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportinsp C-Win 
PROCEDURE proc_reportinsp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
-----------------------------------------------------------------------------*/
If  substr(fi_outload,length(fi_outload) - 3,4) <>  ".csv"  THEN 
    fi_outload  =  Trim(fi_outload) + ".csv"  .
/*ASSIGN nv_cnt  =  0
nv_row  =  1.*/

OUTPUT TO VALUE(fi_outload)              
CONVERT SOURCE "620-2533" TARGET "UTF-8".   /*-- Add By Tontawan S. A66-0006 --*/
EXPORT DELIMITER ","  

    /*"X-Ref.No               " 
    "Customer Code          " 
    "HolderName             " 
    "HolderSurname          " 
    "LicencePlateNo         " 
    "ChassisNo              " 
    "Date of Car Inspection " 
    "Car Inspection Code    " 
    "Car Inspection Result  " 
    "Car Inspection Detail  " 
    "Car Inspection Remark 1" 
    "Car Inspection Remark 2" .*/

"ProspectID__c" 
"Campaign_Code__c"  
"Campaign_Name__c"  
"Product_ExternalId__c"
"Display_Name__c"  
"ExternalId__c"  
"Name"  
"Motor_X_Ref_No__c"
"First_Name__c"  
"Last_Name__c"  
"Phone__c"  
"Phone2__c"  
"Phone3__c"  
"Policy_Class__c"  
"DateAppointmentCarInspection__c"
"TimeAppointmentCarInspection__c"
"ContactNameCarInspection__c"
"ContactMobileCarInspection__c"
"LINE_ID__c"
"Personal_Email__c"
"AddressCarInspection__c"
"CarBrand__c"
"CarModel__c"
"Car_Motor_Type__c"
"Car_Seat__c"
"CarCC__c"
"Car_Weight__c"
"Car_PlateProvince__c"
"Car_Regist_Year__c"
"Car_PlateNo__c"
"Car_ChassisNo__c"
"Car_EngineNo__c"
"EffectiveDate__c"
"ExpiryDate__c"
"SI__c"
"Annual_Total_Premium__c"
"accessory01"
"accessoryDetail01"
"AccessorySuminsured01"
"accessory02"
"accessoryDetail02"
"AccessorySuminsured02"
"accessory03"
"accessoryDetail03"
"AccessorySuminsured03"
"accessory04"
"accessoryDetail04"
"AccessorySuminsured04"
"accessory05"
"accessoryDetail05"
"AccessorySuminsured05"
"ResultCarInspection__c"
"CarInspectionDetail__c"
"Selling_Channel__c"
"CarInspectionDate__c"
"CarInspectionApprovedDate__c".
    
          
/*
FOR EACH winsp WHERE winsp.insp_status = "YES" no-lock.*/
FOR EACH winsp   no-lock.
    EXPORT DELIMITER "," 
      /*winsp.RefNo         
        winsp.CusCode    
        winsp.cusName       
        winsp.Surname    
        winsp.Licence       
        winsp.Chassis       
        winsp.Insp_date            
        winsp.Insp_Code            
        winsp.Insp_Result          
        winsp.Insp_Detail          
        winsp.Insp_Remark1         
        winsp.Insp_Remark2 . */
        winsp.inscode
        winsp.campcode
        winsp.campname
        winsp.packnam  
        winsp.packcode 
        winsp.proname  
        winsp.procode  
        winsp.Refno
        /*winsp.custcode*/
        winsp.pol_fname
        winsp.pol_lname
        winsp.pol_tel
        winsp.tmp1
        winsp.tmp2
        winsp.packcode   /*winsp.instype  ***/
        winsp.inspdate
        winsp.insptime
        winsp.inspcont
        winsp.insptel
        winsp.lineid
        winsp.mail
        winsp.inspaddr
        winsp.brand
        winsp.Model
        winsp.class
        winsp.seatenew
        winsp.power
        winsp.weight
        winsp.province
        winsp.yrmanu
        winsp.licence
        winsp.chassis
        winsp.engine
        winsp.comdat
        winsp.expdat
        winsp.ins_amt
        winsp.premtotal
        winsp.acc1
        winsp.accdetail1
        winsp.accprice1
        winsp.acc2
        winsp.accdetail2
        winsp.accprice2
        winsp.acc3
        winsp.accdetail3
        winsp.accprice3
        winsp.acc4
        winsp.accdetail4
        winsp.accprice4
        winsp.acc5
        winsp.accdetail5
        winsp.accprice5
        winsp.Insp_Result   /*winsp.Car_Inspection_Result */
      /*(winsp.Insp_Detail + " " + winsp.insp_damage)  /*winsp.Detial_Car_Inspection */ -- Comment By Tontawan S. A66-0006 ---*/
        (winsp.insp_no + " " + winsp.Insp_Detail + " " + winsp.insp_damage)  /*--------------- Add By Tontawan S. A66-0006 ---*/
        "TSR"    /*         winsp.Selling_Channel. */
        winsp.Insp_date   
        winsp.Insp_date   
        .
END. 
OUTPUT CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_updatetlt C-Win 
PROCEDURE proc_updatetlt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH winsp NO-LOCK.
    FIND LAST  brstat.tlt USE-INDEX tlt04       WHERE 
        brstat.tlt.cha_no       = winsp.chassis  AND
        brstat.tlt.genusr       = "SCBPT"        AND 
        brstat.tlt.flag         = "INSPEC"       AND 
        brstat.tlt.stat         = "NO"           NO-ERROR  NO-WAIT.
    IF AVAIL brstat.tlt THEN DO:
        IF brstat.tlt.releas = "NO" THEN DO:
            ASSIGN 
                brstat.tlt.releas       = winsp.insp_status                                                           
                brstat.tlt.nor_noti_tlt = winsp.insp_no 
                brstat.tlt.safe1        = winsp.Insp_Detail 
                brstat.tlt.safe2        = winsp.insp_damage
                brstat.tlt.safe3        = winsp.insp_driver
                brstat.tlt.filler2      = winsp.Insp_other                          
                brstat.tlt.datesent     = DATE(winsp.Insp_date) 
                brstat.tlt.stat         = IF winsp.insp_status = "NO" THEN "NO" ELSE "YES"
                brstat.tlt.entdat       = IF winsp.insp_status = "NO" THEN ?    ELSE TODAY  .
        END.
        ELSE DO:
            ASSIGN brstat.tlt.stat         = IF winsp.insp_status = "NO" THEN "NO" ELSE "YES"
                brstat.tlt.entdat       = IF winsp.insp_status = "NO" THEN ?    ELSE TODAY  .
        END.
    END.
END.
RELEASE brstat.tlt.
 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

