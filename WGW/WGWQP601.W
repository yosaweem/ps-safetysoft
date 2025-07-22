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
/* ***************************  Definitions  ************************** */
/* Parameters Definitions ---                                           */
/* Local Variable Definitions ---                                       */
/*++++++++++++++++++++++++++++++++++++++++++++++
  wgwqtnc2.w :  Quey & Update , Add data in table  tlt (Thanachat)
  Create  by    :  Ranu i. A59-0316  On   08/07/2016
-------------------------------------------------------------------------*/
/*Modify by : Ranu I. A59-0471 ปรับเพิ่มเงื่อนไขการเช็ค Status policy    */
/*Modify by : Ranu I. A60-0383 Date. 01/09/2017 เพิ่มช่องหมายเหตุการแจ้งงาน 
             ช่อง แคมเปญ ,ช่อง Loss Ratio เช็คการแสดงข้อมูลเลขบัตร ปปช.*/
/*----------------------------------------------------------------------*/
Def  Input  parameter  nv_recidtlt  as  recid  .
Def  var nv_index  as int  init 0.
DEF  VAR nv_chaidrep AS CHAR . /*A57-0262*/
DEF VAR n_length    AS INT .
DEF VAR n_exp       AS CHAR FORMAT "x(15)".
DEF VAR n_IC        AS CHAR FORMAT "x(15)".
DEF VAR n_Com       AS CHAR FORMAT "x(15)".
DEF VAR n_addr5     AS CHAR FORMAT "x(50)".

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_polstatus fi_policy fi_producer fi_agent ~
fi_notno fi_userent fi_comdat fi_sumsi fi_prem1 fi_title fi_firstname ~
fi_lastname fi_icno fi_bdate fi_addr1 fi_addr2 fi_addr3 fi_addr4 fi_remark1 ~
fi_remark2 bu_save bu_exit fi_age fi_covcod fi_tel fi_phone fi_userca ~
RECT-335 RECT-381 RECT-382 RECT-383 RECT-384 
&Scoped-Define DISPLAYED-OBJECTS fi_polstatus fi_entdat fi_policy ~
fi_producer fi_agent fi_notno fi_userent fi_comdat fi_sumsi fi_prem1 ~
fi_title fi_firstname fi_lastname fi_icno fi_bdate fi_addr1 fi_addr2 ~
fi_addr3 fi_addr4 fi_remark1 fi_remark2 fi_userid fi_ldate fi_ltime ~
fi_notdat fi_age fi_covcod fi_tel fi_phone fi_cadat fi_userca 

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
     SIZE 8 BY 1
     FONT 6.

DEFINE BUTTON bu_save 
     LABEL "Save" 
     SIZE 8 BY 1
     FONT 6.

DEFINE VARIABLE fi_addr1 AS CHARACTER FORMAT "X(250)":U 
     VIEW-AS FILL-IN 
     SIZE 99.67 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_addr2 AS CHARACTER FORMAT "X(80)":U 
     VIEW-AS FILL-IN 
     SIZE 26.83 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_addr3 AS CHARACTER FORMAT "X(80)":U 
     VIEW-AS FILL-IN 
     SIZE 31.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_addr4 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 19.67 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_age AS CHARACTER FORMAT "X(4)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 7.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 14.17 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_bdate AS CHARACTER FORMAT "X(12)":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_cadat AS DATE FORMAT "99/99/9999":U 
      VIEW-AS TEXT 
     SIZE 16.5 BY 1
     BGCOLOR 8 FGCOLOR 6 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_comdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_covcod AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5.83 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_entdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 16.5 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_firstname AS CHARACTER FORMAT "X(75)":U 
     VIEW-AS FILL-IN 
     SIZE 28.17 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_icno AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 20.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_lastname AS CHARACTER FORMAT "X(45)":U 
     VIEW-AS FILL-IN 
     SIZE 32.17 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_ldate AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_ltime AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 11 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_notdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15.83 BY .95
     BGCOLOR 10 FGCOLOR 4 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_notno AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 22 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_phone AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 27 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_policy AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_polstatus AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 17.33 BY 1
     BGCOLOR 8 FGCOLOR 6 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_prem1 AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_remark1 AS CHARACTER FORMAT "X(120)":U 
     VIEW-AS FILL-IN 
     SIZE 107.83 BY .86
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_remark2 AS CHARACTER FORMAT "X(120)":U 
     VIEW-AS FILL-IN 
     SIZE 107.83 BY .86
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_sumsi AS INTEGER FORMAT ">>>,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_tel AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 27 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_title AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 11 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_userca AS CHARACTER FORMAT "X(10)":U 
      VIEW-AS TEXT 
     SIZE 18.67 BY 1
     BGCOLOR 8 FGCOLOR 6 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_userent AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 18.67 BY .95
     BGCOLOR 8 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_userid AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 9 BY 1
     BGCOLOR 7 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-335
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.67 BY 18.1
     BGCOLOR 20 FGCOLOR 2 .

DEFINE RECTANGLE RECT-381
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10.5 BY 1.52
     BGCOLOR 5 FGCOLOR 2 .

DEFINE RECTANGLE RECT-382
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10.5 BY 1.52
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-383
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 131 BY 3.14
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-384
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 131 BY 10.24
     BGCOLOR 19 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_polstatus AT ROW 18.29 COL 88.17 COLON-ALIGNED NO-LABEL
     fi_entdat AT ROW 18.24 COL 51.17 COLON-ALIGNED NO-LABEL
     fi_policy AT ROW 1.71 COL 98 COLON-ALIGNED NO-LABEL
     fi_producer AT ROW 3.81 COL 77.67 COLON-ALIGNED NO-LABEL
     fi_agent AT ROW 3.81 COL 106.33 COLON-ALIGNED NO-LABEL
     fi_notno AT ROW 4.91 COL 49 COLON-ALIGNED NO-LABEL
     fi_userent AT ROW 18.33 COL 15 COLON-ALIGNED NO-LABEL
     fi_comdat AT ROW 10.62 COL 102.33 COLON-ALIGNED NO-LABEL
     fi_sumsi AT ROW 10.67 COL 37.67 COLON-ALIGNED NO-LABEL
     fi_prem1 AT ROW 10.62 COL 71 COLON-ALIGNED NO-LABEL
     fi_title AT ROW 8.38 COL 18.33 COLON-ALIGNED NO-LABEL
     fi_firstname AT ROW 8.38 COL 36.33 COLON-ALIGNED NO-LABEL
     fi_lastname AT ROW 8.29 COL 74.83 COLON-ALIGNED NO-LABEL
     fi_icno AT ROW 9.48 COL 18.33 COLON-ALIGNED NO-LABEL
     fi_bdate AT ROW 9.52 COL 48.5 COLON-ALIGNED NO-LABEL
     fi_addr1 AT ROW 11.81 COL 17.83 COLON-ALIGNED NO-LABEL
     fi_addr2 AT ROW 12.86 COL 17.67 COLON-ALIGNED NO-LABEL
     fi_addr3 AT ROW 12.86 COL 54 COLON-ALIGNED NO-LABEL
     fi_addr4 AT ROW 12.91 COL 97.83 COLON-ALIGNED NO-LABEL
     fi_remark1 AT ROW 15.1 COL 19.17 NO-LABEL
     fi_remark2 AT ROW 16.05 COL 17.17 COLON-ALIGNED NO-LABEL
     bu_save AT ROW 19.67 COL 111.83
     bu_exit AT ROW 19.67 COL 122.5
     fi_userid AT ROW 1.71 COL 121.5 COLON-ALIGNED NO-LABEL
     fi_ldate AT ROW 3.81 COL 18.33 COLON-ALIGNED NO-LABEL
     fi_ltime AT ROW 3.81 COL 48.33 COLON-ALIGNED NO-LABEL
     fi_notdat AT ROW 4.86 COL 18.17 COLON-ALIGNED NO-LABEL
     fi_age AT ROW 9.48 COL 72.83 COLON-ALIGNED NO-LABEL 
     fi_covcod AT ROW 10.62 COL 18.17 COLON-ALIGNED NO-LABEL 
     fi_tel AT ROW 14 COL 17.33 COLON-ALIGNED NO-LABEL 
     fi_phone AT ROW 14 COL 58.67 COLON-ALIGNED NO-LABEL 
     fi_cadat AT ROW 19.52 COL 51.17 COLON-ALIGNED NO-LABEL 
     fi_userca AT ROW 19.62 COL 15 COLON-ALIGNED NO-LABEL 
     " ข้อมูลลูกค้า" VIEW-AS TEXT
          SIZE 11.5 BY 1 AT ROW 6.76 COL 2.17
          BGCOLOR 19 FGCOLOR 6 FONT 6
     " เบี้ยรวม กธ :":25 VIEW-AS TEXT
          SIZE 12.17 BY .95 AT ROW 10.62 COL 60
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " เลขที่สัญญา :":35 VIEW-AS TEXT
          SIZE 12.83 BY .95 AT ROW 4.91 COL 37.67
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "Status Policy :" VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 18.29 COL 75.33
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " วันที่ส่งข้อมูล :":30 VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 4.81 COL 6.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " คำนำหน้าชื่อ :":30 VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 8.43 COL 6.83
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "รหัสประชาชน :":30 VIEW-AS TEXT
          SIZE 13.67 BY .95 AT ROW 9.48 COL 5.67
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "อายุ :":35 VIEW-AS TEXT
          SIZE 5 BY .95 AT ROW 9.52 COL 68.67 
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "ผู้ยกเลิก:":30 VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 19.67 COL 4 
          BGCOLOR 20 FGCOLOR 6 FONT 6
     "วันที่ยกเลิก :" VIEW-AS TEXT
          SIZE 13 BY 1 AT ROW 19.57 COL 38 
          BGCOLOR 20 FGCOLOR 6 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.67 ROW 1.14
         SIZE 133 BY 20.38
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     " วันที่คุ้มครอง :":35 VIEW-AS TEXT
          SIZE 13.83 BY .95 AT ROW 10.62 COL 89.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "วันเกิด :":30 VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 9.57 COL 42.17
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "แผนประกัน :":30 VIEW-AS TEXT
          SIZE 12 BY .91 AT ROW 10.62 COL 7.67 
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "เบอร์โทรศัพท์ :":30 VIEW-AS TEXT
          SIZE 14 BY .91 AT ROW 14 COL 5 
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "เบอร์มือถือ :":30 VIEW-AS TEXT
          SIZE 11 BY .91 AT ROW 14 COL 48 
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "  ที่อยู่ 3 :":35 VIEW-AS TEXT
          SIZE 9 BY .95 AT ROW 12.91 COL 46.67
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "  ที่อยู่ 2 :":30 VIEW-AS TEXT
          SIZE 9.5 BY .95 AT ROW 12.91 COL 9.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " ข้อมูลการแจ้งงาน" VIEW-AS TEXT
          SIZE 17 BY .81 AT ROW 2.86 COL 2.33
          BGCOLOR 19 FGCOLOR 6 FONT 6
     "ผู้โหลดงาน :":30 VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 18.38 COL 4
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " ทุนประกัน :":35 VIEW-AS TEXT
          SIZE 11.17 BY .95 AT ROW 10.62 COL 27.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " Agent code :":30 VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 3.81 COL 95
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " วันที่โหลด  :":30 VIEW-AS TEXT
          SIZE 12 BY .95 AT ROW 3.91 COL 7.67
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "วันที่ออกงาน :" VIEW-AS TEXT
          SIZE 13 BY 1 AT ROW 18.29 COL 38
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "Producer code :":30 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 3.81 COL 63.67
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "  ที่อยู่ 1 :":30 VIEW-AS TEXT
          SIZE 9 BY .95 AT ROW 11.81 COL 10.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " นามสกุล :":30 VIEW-AS TEXT
          SIZE 9.67 BY .95 AT ROW 8.38 COL 67.17
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " เบอร์กรมธรรม์ใหม่  :":35 VIEW-AS TEXT
          SIZE 19.5 BY .95 AT ROW 1.71 COL 80
          BGCOLOR 1 FGCOLOR 7 FONT 6
     " Remark :":30 VIEW-AS TEXT
          SIZE 10 BY .86 AT ROW 15 COL 8.33
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " ชื่อ :":30 VIEW-AS TEXT
          SIZE 5.67 BY .95 AT ROW 8.43 COL 32.33
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " เวลาโหลด  :":30 VIEW-AS TEXT
          SIZE 12 BY .95 AT ROW 3.81 COL 37.33
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "  ที่อยู่ 4 :":30 VIEW-AS TEXT
          SIZE 9.5 BY .95 AT ROW 12.91 COL 89.67
          BGCOLOR 19 FGCOLOR 2 FONT 6
     RECT-335 AT ROW 3.14 COL 1.17
     RECT-381 AT ROW 19.43 COL 110.5
     RECT-382 AT ROW 19.43 COL 121.33
     RECT-383 AT ROW 3.29 COL 2
     RECT-384 AT ROW 7.43 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.67 ROW 1.14
         SIZE 133 BY 20.38
         BGCOLOR 3 FGCOLOR 1 .


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
         TITLE              = "Update Data THANACHAT"
         HEIGHT             = 20.38
         WIDTH              = 134
         MAX-HEIGHT         = 29.14
         MAX-WIDTH          = 135
         VIRTUAL-HEIGHT     = 29.14
         VIRTUAL-WIDTH      = 135
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
/* SETTINGS FOR FILL-IN fi_cadat IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_entdat IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_ldate IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_ltime IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_notdat IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_remark1 IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_userid IN FRAME fr_main
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Update Data THANACHAT */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Update Data THANACHAT */
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
  Apply "Close"  To this-procedure.
  Return no-apply.
 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_save
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_save C-Win
ON CHOOSE OF bu_save IN FRAME fr_main /* Save */
DO:
    MESSAGE "Do you want SAVE  !!!!"        
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO     /*-CANCEL */    
        TITLE "" UPDATE choice AS LOGICAL.
    CASE choice:         
        WHEN TRUE THEN /* Yes */ 
            DO: 
            Find  brstat.tlt Where  Recid(tlt)  =  nv_recidtlt.
            If  avail  brstat.tlt Then do:
                ASSIGN 
                    tlt.subins         = trim(fi_producer)   
                    tlt.recac          = trim(fi_agent)
                    tlt.policy         = trim(fi_policy)
                    tlt.nor_noti_ins   = trim(fi_notno)    
                    tlt.rec_name       = trim(fi_title)    
                    tlt.ins_name       = trim(fi_firstname)
                    tlt.rec_addr5      = trim(fi_lastname) 
                    tlt.rec_addr1      = trim(fi_icno)     
                    tlt.rec_addr2      = fi_bdate    
                    tlt.rec_addr3      = fi_age      
                    tlt.rec_addr4      = fi_covcod   
                    tlt.nor_coamt      = fi_sumsi    
                    tlt.comp_coamt     = fi_prem1
                    tlt.ins_addr1      = trim(fi_addr1)    
                    tlt.ins_addr2      = trim(fi_addr2)    
                    tlt.ins_addr3      = trim(fi_addr3)    
                    tlt.ins_addr4      = trim(fi_addr4)    
                    tlt.old_eng        = trim(fi_tel)      
                    tlt.old_cha        = trim(fi_phone)    
                    tlt.gendat         = fi_comdat   
                    tlt.filler2        = trim(fi_remark1)
                    tlt.filler1        = trim(fi_remark2).
            END.
            Apply "Close" to this-procedure.
            Return no-apply.
        END.
        WHEN FALSE THEN /* No */          
            DO:   
            APPLY "entry" TO fi_covcod.
            RETURN NO-APPLY.
        END.
        END CASE.
RELEASE brstat.tlt.
Disp  fi_covcod with  frame  fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_addr1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_addr1 C-Win
ON LEAVE OF fi_addr1 IN FRAME fr_main
DO:
  fi_addr1 = INPUT fi_addr1 .
  DISP fi_addr1 WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_addr2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_addr2 C-Win
ON LEAVE OF fi_addr2 IN FRAME fr_main
DO:
  fi_addr2 = INPUT fi_addr2 .
  DISP fi_addr2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_addr3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_addr3 C-Win
ON LEAVE OF fi_addr3 IN FRAME fr_main
DO:
  fi_addr3 = INPUT fi_addr3 .
  DISP fi_addr3 WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_addr4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_addr4 C-Win
ON LEAVE OF fi_addr4 IN FRAME fr_main
DO:
    fi_addr4 = INPUT fi_addr4.
    DISP fi_addr4 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_age
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_age C-Win
ON LEAVE OF fi_age IN FRAME fr_main
DO:
  fi_age = INPUT fi_age .
  DISP fi_age WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agent C-Win
ON LEAVE OF fi_agent IN FRAME fr_main
DO:
  fi_agent = INPUT fi_agent .
  DISP fi_agent WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_bdate
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_bdate C-Win
ON LEAVE OF fi_bdate IN FRAME fr_main
DO:
    fi_bdate = INPUT fi_bdate .
    DISP fi_bdate WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_comdat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_comdat C-Win
ON LEAVE OF fi_comdat IN FRAME fr_main
DO:
  fi_comdat = INPUT fi_comdat.
  DISP fi_comdat WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_covcod
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_covcod C-Win
ON LEAVE OF fi_covcod IN FRAME fr_main
DO:
    fi_covcod = INPUT fi_covcod .
    DISP fi_covcod WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_firstname
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_firstname C-Win
ON LEAVE OF fi_firstname IN FRAME fr_main
DO:
  fi_firstname = INPUT fi_firstname .
  DISP fi_firstname WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_icno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_icno C-Win
ON LEAVE OF fi_icno IN FRAME fr_main
DO:
    fi_icno = INPUT fi_icno .
    DISP fi_icno WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_lastname
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_lastname C-Win
ON LEAVE OF fi_lastname IN FRAME fr_main
DO:
    fi_lastname = INPUT fi_lastname .
    DISP fi_lastname WITH FRAM fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_notno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_notno C-Win
ON LEAVE OF fi_notno IN FRAME fr_main
DO:
  fi_notno = INPUT fi_notno .
  DISP fi_notno WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_phone
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_phone C-Win
ON LEAVE OF fi_phone IN FRAME fr_main
DO:
    fi_phone = INPUT fi_phone .
    DISP fi_phone WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_policy
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_policy C-Win
ON LEAVE OF fi_policy IN FRAME fr_main
DO:
  fi_policy  =  Input  fi_policy.
  Disp  fi_policy with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_prem1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_prem1 C-Win
ON LEAVE OF fi_prem1 IN FRAME fr_main
DO:
  fi_prem1 = INPUT fi_prem1 .
  DISP fi_prem1 WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_remark1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_remark1 C-Win
ON LEAVE OF fi_remark1 IN FRAME fr_main
DO:
    fi_remark1 = trim(INPUT fi_remark1).
    DISP fi_remark1 with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_remark2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_remark2 C-Win
ON LEAVE OF fi_remark2 IN FRAME fr_main
DO:
    fi_remark2 = trim(INPUT fi_remark2).
    DISP fi_remark2 with frame  fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_sumsi
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_sumsi C-Win
ON LEAVE OF fi_sumsi IN FRAME fr_main
DO:
    fi_sumsi = INPUT fi_sumsi.
    DISP fi_sumsi WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_tel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_tel C-Win
ON LEAVE OF fi_tel IN FRAME fr_main
DO:
    fi_tel = INPUT fi_tel .
    DISP fi_tel WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_title
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_title C-Win
ON LEAVE OF fi_title IN FRAME fr_main
DO:
  fi_title = INPUT fi_title.
  DISP fi_title WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_userent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_userent C-Win
ON LEAVE OF fi_userent IN FRAME fr_main
DO:
  fi_userent = INPUT fi_userent .
  DISP fi_userent WITH FRAM fr_main.
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
  
  gv_prgid = "wgwqtnc2".
  gv_prog  = "Query & Update Data  (THANACHAT) ".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).

/*********************************************************************/ 
 /*  RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE). */ 
  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.
  
 /* Rect-336:Move-to-top().*/
 /* Rect-337:Move-to-top().*/
  
  /*Hide    fi_difprm  in frame  {&FRAME-NAME}.*/
  Find  tlt  Where  Recid(tlt)  =  nv_recidtlt NO-LOCK NO-ERROR NO-WAIT .
  If  avail  tlt  Then do:
      Assign
          fi_ldate      = tlt.trndat           /* วันที่โหลด */  
          fi_ltime      = tlt.enttim           /* เวลาโหลด   */                 
          fi_policy     = tlt.policy           /* กรมธรรม์ใหม่  */
          fi_producer   = tlt.subins
          fi_agent      = tlt.recac
          fi_userid     = tlt.usrid

          fi_notdat     = tlt.datesent         /*วันที่ส่งข้อมูล */ 
          fi_notno      = tlt.nor_noti_ins     /*เลขที่รับแจ้ง */
          fi_title      = tlt.rec_name         /*คำนำหน้าชื่อ   */
          fi_firstname  = tlt.ins_name         /*ชื่อลูกค้า   */
          fi_lastname   = tlt.rec_addr5        /*นามสกุล   */                                           
          fi_icno       = tlt.rec_addr1        /*เลขบัตร   */
          fi_bdate      = tlt.rec_addr2        /*วันเกิด   */
          fi_age        = tlt.rec_addr3        /*อายุ   */
          fi_covcod     = tlt.rec_addr4        /*แผน   */
          fi_sumsi      = tlt.nor_coamt        /*ทุนประกัน             */                                                                                                  
          fi_prem1      = tlt.comp_coamt       /*เบี้ยรวม              */                                                                                                  
          fi_addr1      = tlt.ins_addr1        /*ที่อยู่ลูกค้า 1             */                                                                                                     
          fi_addr2      = tlt.ins_addr2        /*ที่อยู่ลูกค้า  2            */ 
          fi_addr3      = tlt.ins_addr3        /*ที่อยู่ลูกค้า3              */
          fi_addr4      = tlt.ins_addr4        /*ที่อยู่ลูกค้า4              */
          fi_tel        = tlt.old_eng          /*เบอร์โทรศัพท์ */
          fi_phone      = tlt.old_cha          /*เบอร์มือถือ */
          fi_comdat     = tlt.gendat           /*วันที่เริ่มคุ้มครอง        */ 
          fi_remark1    = TRIM(tlt.filler2)
          fi_remark2    = TRIM(tlt.filler1)
              
          fi_entdat     = tlt.entdat       /*วันที่ออกงาน  */
          fi_userent    = tlt.usrsent      /* userid ออกงาน */
          fi_polstatus  = tlt.releas       /* สถานะ */ 
          fi_userca     = tlt.stat         /* userid cacel */ 
          fi_cadat      = tlt.expodat.     /* cacel date */
         
     
     Disp fi_ldate    fi_ltime    fi_policy       fi_notdat    
          fi_notno    fi_title    fi_firstname    fi_lastname     fi_icno      
          fi_bdate    fi_age      fi_covcod       fi_sumsi        fi_prem1 
          fi_addr1    fi_addr2    fi_addr3        fi_addr4        fi_tel       
          fi_phone    fi_comdat   fi_remark1      fi_remark2      fi_entdat    
          fi_userent  fi_polstatus fi_producer    fi_agent        fi_userid 
          fi_userca   fi_cadat 
         WITH frame  fr_main. 

     IF LENGTH(fi_icno) < 13 THEN DO:
         fi_icno:BGCOLOR = 6 .
         DISP fi_icno WITH FRAME fr_main.
     END.
  End.
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
  DISPLAY fi_polstatus fi_entdat fi_policy fi_producer fi_agent fi_notno 
          fi_userent fi_comdat fi_sumsi fi_prem1 fi_title fi_firstname 
          fi_lastname fi_icno fi_bdate fi_addr1 fi_addr2 fi_addr3 fi_addr4 
          fi_remark1 fi_remark2 fi_userid fi_ldate fi_ltime fi_notdat fi_age 
          fi_covcod fi_tel fi_phone fi_cadat fi_userca 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_polstatus fi_policy fi_producer fi_agent fi_notno fi_userent 
         fi_comdat fi_sumsi fi_prem1 fi_title fi_firstname fi_lastname fi_icno 
         fi_bdate fi_addr1 fi_addr2 fi_addr3 fi_addr4 fi_remark1 fi_remark2 
         bu_save bu_exit fi_age fi_covcod fi_tel fi_phone fi_userca RECT-335 
         RECT-381 RECT-382 RECT-383 RECT-384 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

