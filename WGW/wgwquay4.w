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
program id       :  wuwquay4.w 
program name     :  Update data Aycal to create  new policy  Add in table  tlt  
                    Quey & Update data before Gen.
Create  by       :  Kridtiya i. A57-0005  On   06/01/2014
Database Connect :  gw_stat ld brstat , gw_safe ld sic_bran ,sic_test ld sicuw sicsyac stat
Modify       : Jiraporn P. [A59-0342]   date 13/07/2016
             : แก้ไขการนำเข้า พรบ. ดึงข้อมูลลุกค้าจาก File พรบ.และโหลดเข้าระบบได้อย่างถูกต้องและครบถ้วน */
/*Modify by : Ranu I. A60-0542 Date 18/12/2017 เพิ่มช่อง Campaign CJ */
/*+++++++++++++++++++++++++++++++++++++++++++++++*/
DEF  INPUT  PARAMETER  nv_recidtlt  AS  RECID  . 
DEF    VAR    nv_recidtlt2          AS  RECID  . 
DEFINE VAR    vAcProc_fil           AS CHAR.
DEF    VAR  n_addr1  AS CHAR FORMAT "x(200)". /*Add Jiraporn A59-0342*/
DEF    VAR  n_soi    AS CHAR FORMAT "x(50)".
DEF    VAR  n_road   AS CHAR FORMAT "x(50)".

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_notno72 fi_branchcode fi_stk ~
fi_companycomp fi_remark1 ra_status bu_save bu_exit fi_name fi_lastname ~
fi_idno fi_add1no fi_branchno fi_comdat fi_expdat fi_class fi_brand ~
fi_model fi_cc fi_licence1 fi_licence2 fi_licence3 fi_body fi_engno ~
fi_coamt fi_grprm fi_lotno fi_contract fi_cmrsty fi_add2tam fi_add3amp ~
fi_add4cnt fi_add5post fi_camp RECT-488 RECT-490 RECT-491 RECT-492 
&Scoped-Define DISPLAYED-OBJECTS fi_notno72 fi_branchcode fi_stk ~
fi_companycomp fi_remark1 ra_status fi_userid fi_notdat fi_name fi_lastname ~
fi_idno fi_add1no fi_branchno fi_comdat fi_expdat fi_class fi_brand ~
fi_model fi_cc fi_licence1 fi_licence2 fi_licence3 fi_body fi_engno ~
fi_coamt fi_grprm fi_lotno fi_contract fi_cmrsty fi_add2tam fi_add3amp ~
fi_add4cnt fi_add5post fi_camp 

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
     SIZE 12.33 BY 1.19
     FONT 6.

DEFINE BUTTON bu_save 
     LABEL "Save" 
     SIZE 12.83 BY 1.19
     FONT 6.

DEFINE VARIABLE fi_add1no AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 61.83 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_add2tam AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 33 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_add3amp AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 33.83 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_add4cnt AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 26.5 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_add5post AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_body AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 24.67 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_branchcode AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 5.67 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_branchno AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 21.33 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_brand AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_camp AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5.67 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_cc AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 15.83 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_class AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_cmrsty AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 11 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_coamt AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 19.5 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_comdat AS DATE FORMAT "99/99/99":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_companycomp AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 22.17 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_contract AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 19 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_engno AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 19.5 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_expdat AS DATE FORMAT "99/99/99":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_grprm AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 20.33 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_idno AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 22.5 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_lastname AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 23.67 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_licence1 AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_licence2 AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 12.67 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_licence3 AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 18.17 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_lotno AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 9.5 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_model AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 36.33 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_name AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 23.67 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_notdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 8 FGCOLOR 1 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_notno72 AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_remark1 AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 73 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_stk AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 20.83 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_userid AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 7.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE ra_status AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "YES", 1,
"NO", 2,
"CANCEL", 3
     SIZE 40.5 BY 1
     BGCOLOR 7 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-488
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 23.57
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-490
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10.5 BY 2
     BGCOLOR 2 FGCOLOR 0 .

DEFINE RECTANGLE RECT-491
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 14.83 BY 2
     BGCOLOR 12 .

DEFINE RECTANGLE RECT-492
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 15.33 BY 2
     BGCOLOR 3 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_notno72 AT ROW 4.1 COL 46 COLON-ALIGNED NO-LABEL
     fi_branchcode AT ROW 6.38 COL 17 COLON-ALIGNED NO-LABEL
     fi_stk AT ROW 4.1 COL 80.17 COLON-ALIGNED NO-LABEL
     fi_companycomp AT ROW 5.24 COL 16.67 COLON-ALIGNED NO-LABEL
     fi_remark1 AT ROW 19.71 COL 16.67 COLON-ALIGNED NO-LABEL
     ra_status AT ROW 21 COL 54 NO-LABEL
     fi_userid AT ROW 22.57 COL 53.33 COLON-ALIGNED NO-LABEL
     bu_save AT ROW 22.48 COL 65.83
     bu_exit AT ROW 22.48 COL 81.17
     fi_notdat AT ROW 4.1 COL 16.83 COLON-ALIGNED NO-LABEL
     fi_name AT ROW 9.1 COL 8.67 COLON-ALIGNED NO-LABEL
     fi_lastname AT ROW 9.1 COL 43.5 COLON-ALIGNED NO-LABEL
     fi_idno AT ROW 9.1 COL 76 COLON-ALIGNED NO-LABEL
     fi_add1no AT ROW 10.29 COL 20.17 COLON-ALIGNED NO-LABEL
     fi_branchno AT ROW 6.38 COL 53.5 COLON-ALIGNED NO-LABEL
     fi_comdat AT ROW 14.91 COL 20.67 COLON-ALIGNED NO-LABEL
     fi_expdat AT ROW 14.95 COL 60.83 COLON-ALIGNED NO-LABEL
     fi_class AT ROW 16.14 COL 11.17 COLON-ALIGNED NO-LABEL
     fi_brand AT ROW 16.19 COL 31.67 COLON-ALIGNED NO-LABEL
     fi_model AT ROW 16.19 COL 60.67 COLON-ALIGNED NO-LABEL
     fi_cc AT ROW 16.19 COL 104.5 COLON-ALIGNED NO-LABEL
     fi_licence1 AT ROW 17.38 COL 14.83 COLON-ALIGNED NO-LABEL
     fi_licence2 AT ROW 17.38 COL 21.17 COLON-ALIGNED NO-LABEL
     fi_licence3 AT ROW 17.38 COL 34.17 COLON-ALIGNED NO-LABEL
     fi_body AT ROW 17.38 COL 68.33 COLON-ALIGNED NO-LABEL
     fi_engno AT ROW 17.33 COL 108.83 COLON-ALIGNED NO-LABEL
     fi_coamt AT ROW 18.52 COL 10 COLON-ALIGNED NO-LABEL
     fi_grprm AT ROW 18.62 COL 40.17 COLON-ALIGNED NO-LABEL
     fi_lotno AT ROW 5.24 COL 57.33 COLON-ALIGNED NO-LABEL
     fi_contract AT ROW 5.24 COL 82.17 COLON-ALIGNED NO-LABEL
     fi_cmrsty AT ROW 6.38 COL 29.17 COLON-ALIGNED NO-LABEL
     fi_add2tam AT ROW 10.24 COL 96 COLON-ALIGNED NO-LABEL
     fi_add3amp AT ROW 11.95 COL 14.67 COLON-ALIGNED NO-LABEL
     fi_add4cnt AT ROW 11.95 COL 57.5 COLON-ALIGNED NO-LABEL
     fi_add5post AT ROW 11.95 COL 98 COLON-ALIGNED NO-LABEL
     fi_camp AT ROW 9.1 COL 113.33 COLON-ALIGNED NO-LABEL WIDGET-ID 2
     " Policy 72 :":35 VIEW-AS TEXT
          SIZE 13 BY 1 AT ROW 4.1 COL 34.5
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "*กรุณาใส่ อ. หรือ เขต นำหน้า" VIEW-AS TEXT
          SIZE 21.67 BY .62 AT ROW 12.95 COL 17
          BGCOLOR 8 FGCOLOR 4 FONT 0
     " เลขสติ๊กเกอร์ :":30 VIEW-AS TEXT
          SIZE 13 BY 1 AT ROW 4.1 COL 68.5
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "*-..-**-..-*  UPDATE ...    DATA  AYCAL  Compulsory  *-..-**-..-*" VIEW-AS TEXT
          SIZE 130.5 BY 1.43 AT ROW 1.24 COL 2
          BGCOLOR 9 FGCOLOR 7 FONT 6
     " วันที่เริ่มคุ้มครอง :":30 VIEW-AS TEXT
          SIZE 17 BY 1 AT ROW 14.91 COL 5
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " Branch Code:":35 VIEW-AS TEXT
          SIZE 13.67 BY 1 AT ROW 6.38 COL 4.5
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " วันที่สิ้นสุดคุ้มครอง :":30 VIEW-AS TEXT
          SIZE 18.5 BY 1 AT ROW 14.95 COL 43.67
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "รหัสไปรษณีย์ :":30 VIEW-AS TEXT
          SIZE 13 BY 1 AT ROW 11.95 COL 86.5
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " NOTIFY  ENTRY" VIEW-AS TEXT
          SIZE 20 BY 1 AT ROW 2.76 COL 2
          BGCOLOR 2 FGCOLOR 7 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 132.5 BY 23.57
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     " ซี.ซี :":30 VIEW-AS TEXT
          SIZE 6.33 BY 1 AT ROW 16.19 COL 99.5
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " Insurance Code :":30 VIEW-AS TEXT
          SIZE 17 BY 1 AT ROW 5.24 COL 41.83
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " ชื่อ :":30 VIEW-AS TEXT
          SIZE 5.17 BY 1 AT ROW 9.1 COL 4.83
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " ทะเบียนรถ :":30 VIEW-AS TEXT
          SIZE 11.33 BY 1 AT ROW 17.33 COL 5
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " Branch No:":35 VIEW-AS TEXT
          SIZE 12 BY 1 AT ROW 6.38 COL 42.83
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " เลขตัวถังรถ :":30 VIEW-AS TEXT
          SIZE 14.83 BY 1 AT ROW 17.38 COL 55
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " เลขที่ใบเสร็จ :":30 VIEW-AS TEXT
          SIZE 13.5 BY 1 AT ROW 5.24 COL 4.5
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "ตำบล/แขวง :":30 VIEW-AS TEXT
          SIZE 12.5 BY 1 AT ROW 10.24 COL 85
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "อำเภอ/เขต :":30 VIEW-AS TEXT
          SIZE 11.5 BY 1 AT ROW 12 COL 4.5
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "เลขที่/ซอย/ถนน :":30 VIEW-AS TEXT
          SIZE 16.5 BY 1 AT ROW 10.29 COL 4.67
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Campaign CJ :":30 VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 9.1 COL 101 WIDGET-ID 4
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " เลขเครื่องยนต์ :":30 VIEW-AS TEXT
          SIZE 14.83 BY 1 AT ROW 17.33 COL 95.5
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "   User by :" VIEW-AS TEXT
          SIZE 13 BY 1.86 AT ROW 22.19 COL 40
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " นามสกุล :":30 VIEW-AS TEXT
          SIZE 9.5 BY 1 AT ROW 9.1 COL 35.33
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " หมายเหตุ :":30 VIEW-AS TEXT
          SIZE 13 BY 1 AT ROW 19.71 COL 5
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " Class :":30 VIEW-AS TEXT
          SIZE 7.5 BY 1 AT ROW 16.14 COL 5
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " ข้อมูลลูกค้า" VIEW-AS TEXT
          SIZE 20 BY 1 AT ROW 7.91 COL 2
          BGCOLOR 2 FGCOLOR 7 FONT 6
     " ยี่ห้อรถ :":30 VIEW-AS TEXT
          SIZE 9 BY 1 AT ROW 16.19 COL 24
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " เบี้ย :":30 VIEW-AS TEXT
          SIZE 6.33 BY 1 AT ROW 18.52 COL 5
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " สาขา :":30 VIEW-AS TEXT
          SIZE 5.17 BY 1 AT ROW 6.38 COL 25.33
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " เบี้ยสุทธิ :":30 VIEW-AS TEXT
          SIZE 9.5 BY 1 AT ROW 18.57 COL 32
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "     Status :":30 VIEW-AS TEXT
          SIZE 13 BY 1 AT ROW 21 COL 40
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " รุ่นรถ :":30 VIEW-AS TEXT
          SIZE 7.5 BY 1 AT ROW 16.19 COL 54.5
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "จังหวัด :":30 VIEW-AS TEXT
          SIZE 8 BY 1 AT ROW 11.95 COL 51
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " ข้อมูลประกันภัย" VIEW-AS TEXT
          SIZE 20 BY 1 AT ROW 13.62 COL 2.5
          BGCOLOR 2 FGCOLOR 7 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 132.5 BY 23.57
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     " Notify Date :":30 VIEW-AS TEXT
          SIZE 13.33 BY 1 AT ROW 4.1 COL 4.5
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " IDno :":30 VIEW-AS TEXT
          SIZE 7.33 BY 1 AT ROW 9.1 COL 70
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " Contract No :":30 VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 5.24 COL 69.5
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "*กรุณาใส่ ต. หรือ แขวง นำหน้า" VIEW-AS TEXT
          SIZE 22.17 BY .62 AT ROW 11.29 COL 98.5
          BGCOLOR 8 FGCOLOR 4 FONT 0
     RECT-488 AT ROW 1 COL 1
     RECT-490 AT ROW 22.1 COL 53.83
     RECT-491 AT ROW 22.05 COL 79.83
     RECT-492 AT ROW 22.05 COL 64.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 132.5 BY 23.57
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
         TITLE              = "UPDATE  DATA BY AYCL Compulsory"
         HEIGHT             = 23.57
         WIDTH              = 132.5
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
/* SETTINGS FOR FILL-IN fi_notdat IN FRAME fr_main
   NO-ENABLE                                                            */
ASSIGN 
       fi_notdat:HIDDEN IN FRAME fr_main           = TRUE.

/* SETTINGS FOR FILL-IN fi_userid IN FRAME fr_main
   NO-ENABLE                                                            */
ASSIGN 
       fi_userid:HIDDEN IN FRAME fr_main           = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* UPDATE  DATA BY AYCL Compulsory */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* UPDATE  DATA BY AYCL Compulsory */
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
    /*
    MESSAGE "Do you want EXIT now...  !!!!"         SKIP
        "Are you sure SAVE Complete...  !!!!"   SKIP
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO     /*-CANCEL */    
        TITLE "" UPDATE choice AS LOGICAL.
    CASE choice:  
        WHEN TRUE THEN  /* Yes */ 
            DO: 
            RELEASE brstat.tlt.
            Apply "Close"  To this-procedure.
            Return no-apply.
        END.
        END CASE. 
        APPLY "entry" TO bu_save.
        RETURN NO-APPLY.
        */
        Apply "Close"  To this-procedure.
        Return no-apply.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_save
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_save C-Win
ON CHOOSE OF bu_save IN FRAME fr_main /* Save */
DO:
    ASSIGN nv_recidtlt2 =  0.
    IF fi_notno72 <> "" THEN DO:
        FIND FIRST brstat.tlt    WHERE 
            brstat.tlt.nor_noti_tlt   = trim(fi_notno72)   AND 
            brstat.tlt.cha_no         = trim(fi_cmrsty)    AND 
            brstat.tlt.genusr         = "aycal72"          NO-LOCK NO-ERROR NO-WAIT .
        IF AVAIL brstat.tlt THEN DO:  
            ASSIGN nv_recidtlt2 =  Recid(brstat.tlt) .
            IF nv_recidtlt2 <> nv_recidtlt THEN DO:
                MESSAGE "Found policy on tlt..Please check again !!! " VIEW-AS ALERT-BOX.
                APPLY "ENTRY" TO fi_notno72 .
                RETURN NO-APPLY.
            END.
        END.
        IF fi_cmrsty <> "" THEN DO:
            IF LENGTH(trim(fi_cmrsty)) = 2 THEN DO:
                IF SUBSTR(trim(fi_notno72),1,2) <> trim(fi_cmrsty) THEN DO:
                    MESSAGE "Please check branch again  !!! " VIEW-AS ALERT-BOX.
                    APPLY "ENTRY" TO fi_cmrsty .
                    RETURN NO-APPLY.
                END.
            END.
            ELSE DO:
                IF SUBSTR(trim(fi_notno72),2,1) <> trim(fi_cmrsty) THEN DO:
                    MESSAGE "Please check branch again  !!! " VIEW-AS ALERT-BOX.
                    APPLY "ENTRY" TO fi_cmrsty .
                    RETURN NO-APPLY.
                END.
            END.
        END.
    END.
    Find  brstat.tlt  Where   Recid(brstat.tlt)  =  nv_recidtlt   NO-ERROR NO-WAIT .
    If  avail  brstat.tlt  Then do:
        ASSIGN 
            brstat.tlt.nor_noti_tlt  = caps(TRIM(fi_notno72))
            brstat.tlt.comp_usr_tlt  = caps(trim(fi_cmrsty))  
            brstat.tlt.cha_no        = trim(fi_stk)   
            brstat.tlt.safe2         = TRIM(fi_companycomp)
            brstat.tlt.filler2       = trim(fi_remark1) 

            /*Add Jiraporn A59-0342*/
            brstat.tlt.lotno            =   fi_lotno     
            brstat.tlt.comp_noti_tlt    =   fi_contract  
            brstat.tlt.colorcod         =   fi_branchcode
            brstat.tlt.subins           =   fi_branchno  
            brstat.tlt.ins_name         =   fi_name + " " + fi_lastname  
            brstat.tlt.recac            =   fi_idno      
            brstat.tlt.ins_addr1        =   fi_add1no
            /**/
            brstat.tlt.ins_addr2        =   fi_add2tam
            brstat.tlt.ins_addr3        =   fi_add3amp
            brstat.tlt.ins_addr4        =   fi_add4cnt
            brstat.tlt.ins_addr5        =   fi_add5post
            /**/
            brstat.tlt.nor_effdat       =   fi_comdat    
            brstat.tlt.comp_effdat      =   fi_expdat    
            brstat.tlt.comp_sub         =   fi_class     
            brstat.tlt.brand            =   fi_brand     
            brstat.tlt.model            =   fi_model     
            brstat.tlt.cc_weight        =   fi_cc        
            brstat.tlt.lince1           =   fi_licence1 + " " + fi_licence2  
            brstat.tlt.lince2           =   fi_licence3  
            brstat.tlt.comp_sck         =   fi_body      
            brstat.tlt.eng_no           =   fi_engno     
            brstat.tlt.comp_coamt       =   fi_coamt     
            brstat.tlt.comp_grprm       =   fi_grprm
            brstat.tlt.EXP              =   fi_camp . /*A60-0542*/
            
            
            IF ra_status = 1 THEN brstat.tlt.releas  = "Yes".
            ELSE IF ra_status = 2 THEN brstat.tlt.releas  = "NO".
            ELSE IF ra_status = 3 THEN brstat.tlt.releas  = "CANCEL".
            
            /*End Add Jiraporn A59-0342*/
            /*brstat.tlt.releas        = IF ra_status   =  2 THEN  "No" ELSE "Yes"  . --Comment Jiraporn A59-0342*/
    END.                          
    ELSE DO: 
        MESSAGE "Not found policy no Update..tlt" VIEW-AS ALERT-BOX.
    END.
    MESSAGE "SAVE COMPLETE   "  VIEW-AS ALERT-BOX.
    Apply "Close"  To this-procedure.
    Return no-apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_add1no
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_add1no C-Win
ON LEAVE OF fi_add1no IN FRAME fr_main
DO:
  fi_add1no  = INPUT fi_add1no.
  DISP fi_add1no WITH FRAM fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_add2tam
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_add2tam C-Win
ON LEAVE OF fi_add2tam IN FRAME fr_main
DO:
  fi_add2tam  = INPUT fi_add2tam.
  DISP fi_add2tam WITH FRAM fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_add3amp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_add3amp C-Win
ON LEAVE OF fi_add3amp IN FRAME fr_main
DO:
   
  fi_add3amp  = INPUT fi_add3amp.
  DISP fi_add3amp WITH FRAM fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_add4cnt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_add4cnt C-Win
ON LEAVE OF fi_add4cnt IN FRAME fr_main
DO:
  fi_add4cnt  = INPUT fi_add4cnt.
  DISP fi_add4cnt WITH FRAM fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_add5post
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_add5post C-Win
ON LEAVE OF fi_add5post IN FRAME fr_main
DO:
  fi_add5post  = INPUT fi_add5post.
  DISP fi_add5post WITH FRAM fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_body
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_body C-Win
ON LEAVE OF fi_body IN FRAME fr_main
DO:
  fi_body  = INPUT fi_body.
  DISP fi_body WITH FRAM fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_branchcode
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_branchcode C-Win
ON LEAVE OF fi_branchcode IN FRAME fr_main
DO:
    fi_branchcode = INPUT fi_branchcode .
    DISP fi_branchcode WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_branchno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_branchno C-Win
ON LEAVE OF fi_branchno IN FRAME fr_main
DO:
    fi_branchno = INPUT fi_branchno.
    DISP fi_branchno WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_brand
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_brand C-Win
ON LEAVE OF fi_brand IN FRAME fr_main
DO:
  fi_brand  = INPUT fi_brand.
  DISP fi_brand WITH FRAM fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_camp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_camp C-Win
ON LEAVE OF fi_camp IN FRAME fr_main
DO:
  fi_camp  = INPUT fi_camp.
  DISP fi_camp WITH FRAM fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_cc
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_cc C-Win
ON LEAVE OF fi_cc IN FRAME fr_main
DO:
  fi_cc  = INPUT fi_cc.
  DISP fi_cc WITH FRAM fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_class
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_class C-Win
ON LEAVE OF fi_class IN FRAME fr_main
DO:
  fi_class  = INPUT fi_class.
  DISP fi_class WITH FRAM fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_cmrsty
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_cmrsty C-Win
ON LEAVE OF fi_cmrsty IN FRAME fr_main
DO:  
    fi_cmrsty = INPUT fi_cmrsty.
    DISP  fi_cmrsty  WITH FRAM fr_main.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_coamt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_coamt C-Win
ON LEAVE OF fi_coamt IN FRAME fr_main
DO:
  fi_coamt  = INPUT fi_coamt.
  DISP fi_coamt WITH FRAM fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_comdat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_comdat C-Win
ON LEAVE OF fi_comdat IN FRAME fr_main
DO:
  fi_comdat  = INPUT fi_comdat.
  DISP fi_comdat WITH FRAM fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_companycomp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_companycomp C-Win
ON LEAVE OF fi_companycomp IN FRAME fr_main
DO:  
    fi_companycomp = TRIM(INPUT fi_companycomp).
    DISP  fi_companycomp  WITH FRAM fr_main.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_contract
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_contract C-Win
ON LEAVE OF fi_contract IN FRAME fr_main
DO:
    fi_contract = INPUT fi_contract  .
    DISP fi_contract WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_engno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_engno C-Win
ON LEAVE OF fi_engno IN FRAME fr_main
DO:
  fi_engno  = INPUT fi_engno.
  DISP fi_engno WITH FRAM fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_expdat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_expdat C-Win
ON LEAVE OF fi_expdat IN FRAME fr_main
DO:
  fi_expdat  = INPUT fi_expdat.
  DISP fi_expdat WITH FRAM fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_grprm
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_grprm C-Win
ON LEAVE OF fi_grprm IN FRAME fr_main
DO:
  fi_grprm  = INPUT fi_grprm.
  DISP fi_grprm WITH FRAM fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_idno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_idno C-Win
ON LEAVE OF fi_idno IN FRAME fr_main
DO:
  fi_idno  = INPUT fi_idno.
  DISP fi_idno WITH FRAM fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_lastname
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_lastname C-Win
ON LEAVE OF fi_lastname IN FRAME fr_main
DO:
  fi_lastname  = INPUT fi_lastname.
  DISP fi_lastname WITH FRAM fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_licence1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_licence1 C-Win
ON LEAVE OF fi_licence1 IN FRAME fr_main
DO:
  fi_licence1  = INPUT fi_licence1.
  DISP fi_licence1 WITH FRAM fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_licence2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_licence2 C-Win
ON LEAVE OF fi_licence2 IN FRAME fr_main
DO:
  fi_licence2  = INPUT fi_licence2.
  DISP fi_licence2 WITH FRAM fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_licence3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_licence3 C-Win
ON LEAVE OF fi_licence3 IN FRAME fr_main
DO:
  fi_licence3  = INPUT fi_licence3.
  DISP fi_licence3 WITH FRAM fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_lotno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_lotno C-Win
ON LEAVE OF fi_lotno IN FRAME fr_main
DO:
    fi_lotno = INPUT fi_lotno.
    DISP fi_lotno WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_model
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_model C-Win
ON LEAVE OF fi_model IN FRAME fr_main
DO:
  fi_model  = INPUT fi_model.
  DISP fi_model WITH FRAM fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_name
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_name C-Win
ON LEAVE OF fi_name IN FRAME fr_main
DO:
  fi_name = INPUT fi_name.
  DISP fi_name WITH FRAM fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_notno72
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_notno72 C-Win
ON LEAVE OF fi_notno72 IN FRAME fr_main
DO:
    fi_notno72 = caps(trim( INPUT fi_notno72 )).
    DISP fi_notno72 WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_stk
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_stk C-Win
ON LEAVE OF fi_stk IN FRAME fr_main
DO:
  fi_stk  = INPUT fi_stk.
  DISP fi_stk WITH FRAM fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_status
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_status C-Win
ON VALUE-CHANGED OF ra_status IN FRAME fr_main
DO:
    ra_status = INPUT ra_status .
    DISP ra_status WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */
/* Set CURRENT-WINDOW: this will parent dialog-boxes and frames.        */
ASSIGN CURRENT-WINDOW             = {&WINDOW-NAME} 
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
    gv_prgid = "wgwquay4".
    gv_prog  = "UPDATE  DATA BY AYCAL Compulsory".
    RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).
    /*********************************************************************/ 
    /*  RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE). */ 
    /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
    SESSION:DATA-ENTRY-RETURN = YES.

    FIND  brstat.tlt  WHERE   RECID(brstat.tlt)  =  nv_recidtlt NO-LOCK NO-ERROR NO-WAIT .
    IF  AVAIL  brstat.tlt  THEN DO:
        Assign
            fi_notdat      = brstat.tlt.trndat 
            fi_notno72     = brstat.tlt.nor_noti_tlt 
            fi_cmrsty      = brstat.tlt.comp_usr_tlt 
            fi_stk         = brstat.tlt.cha_no
            fi_companycomp = brstat.tlt.safe2     
            fi_remark1     = brstat.tlt.filler2   
            /*ra_status      = IF brstat.tlt.releas = "No" THEN 2 ELSE 1  --Comment A59-0342*/
            fi_userid      = brstat.tlt.endno
            /*Add Jiraporn A59-0342*/
            fi_lotno       = brstat.tlt.lotno
            fi_contract    = brstat.tlt.comp_noti_tlt
            fi_branchcode  = brstat.tlt.colorcod
            fi_branchno    = brstat.tlt.subins
            fi_name        = substr(brstat.tlt.ins_name,1,INDEX(tlt.ins_name, " ")) 
            fi_lastname    = SUBSTR(brstat.tlt.ins_name,R-INDEX(tlt.ins_name, " ") + 1)
            fi_idno        = brstat.tlt.recac
            fi_add1no      = brstat.tlt.ins_addr1
            /**/
            fi_add2tam     = brstat.tlt.ins_addr2
            fi_add3amp     = brstat.tlt.ins_addr3
            fi_add4cnt     = brstat.tlt.ins_addr4
            fi_add5post    = brstat.tlt.ins_addr5
            /**/
            fi_comdat      = brstat.tlt.nor_effdat
            fi_expdat      = brstat.tlt.comp_effdat
            fi_class       = brstat.tlt.comp_sub
            fi_brand       = brstat.tlt.brand
            fi_model       = brstat.tlt.model
            fi_cc          = brstat.tlt.cc_weight
            fi_licence1    = substr(brstat.tlt.lince1,1,INDEX(brstat.tlt.lince1, " "))
            fi_licence2    = substr(brstat.tlt.lince1,R-INDEX(brstat.tlt.lince1, " ") + 1)
            fi_licence3    = brstat.tlt.lince2
            fi_body        = brstat.tlt.comp_sck
            fi_engno       = brstat.tlt.eng_no
            fi_coamt       = brstat.tlt.comp_coamt
            fi_grprm       = brstat.tlt.comp_grprm
            fi_camp        = brstat.tlt.EXP .  /*A60-0542*/

            IF brstat.tlt.releas      = "Yes"    THEN ra_status = 1.
            ELSE IF brstat.tlt.releas = "NO"     THEN ra_status = 2.
            ELSE IF brstat.tlt.releas = "CANCEL" THEN ra_status = 3.
    END.
    /*End Add Jiraporn A 59-0342*/
    RUN   proc_dispable.
    Disp  fi_notdat     
          fi_notno72    
          fi_cmrsty     
          fi_stk        
          fi_companycomp
          fi_remark1    
          ra_status     
          fi_userid
         /*Add Jiraporn A59-0342*/
          fi_lotno     
          fi_contract  
          fi_branchcode
          fi_branchno       
          fi_name      
          fi_lastname  
          fi_idno      
          fi_add1no 
          /**/       
          fi_add2tam 
          fi_add3amp 
          fi_add4cnt 
          fi_add5post
          /**/       
          fi_comdat    
          fi_expdat    
          fi_class     
          fi_brand     
          fi_model     
          fi_cc        
          fi_licence1  
          fi_licence2  
          fi_licence3  
          fi_body      
          fi_engno     
          fi_coamt     
          fi_grprm 
          fi_camp  /*A60-0542*/
          WITH FRAME fr_main.
         /*End Add Jiraporn A59-0342*/
        
    /* End.*/
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
  DISPLAY fi_notno72 fi_branchcode fi_stk fi_companycomp fi_remark1 ra_status 
          fi_userid fi_notdat fi_name fi_lastname fi_idno fi_add1no fi_branchno 
          fi_comdat fi_expdat fi_class fi_brand fi_model fi_cc fi_licence1 
          fi_licence2 fi_licence3 fi_body fi_engno fi_coamt fi_grprm fi_lotno 
          fi_contract fi_cmrsty fi_add2tam fi_add3amp fi_add4cnt fi_add5post 
          fi_camp 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_notno72 fi_branchcode fi_stk fi_companycomp fi_remark1 ra_status 
         bu_save bu_exit fi_name fi_lastname fi_idno fi_add1no fi_branchno 
         fi_comdat fi_expdat fi_class fi_brand fi_model fi_cc fi_licence1 
         fi_licence2 fi_licence3 fi_body fi_engno fi_coamt fi_grprm fi_lotno 
         fi_contract fi_cmrsty fi_add2tam fi_add3amp fi_add4cnt fi_add5post 
         fi_camp RECT-488 RECT-490 RECT-491 RECT-492 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_dispable C-Win 
PROCEDURE proc_dispable :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
Find  brstat.tlt  Where   Recid(brstat.tlt)  =  nv_recidtlt AND 
    brstat.tlt.releas        = "yes"   NO-LOCK NO-ERROR NO-WAIT . 
If  avail  brstat.tlt  Then 
    DISABLE             
          fi_notdat     
          fi_notno72    
          fi_cmrsty     
          fi_stk        
          fi_companycomp
          fi_remark1    
          ra_status     
          fi_userid
        /*Add Jiraporn A59-0342*/
          fi_lotno      
          fi_contract   
          fi_branchcode 
          fi_branchno    
          fi_name       
          fi_lastname   
          fi_idno       
          fi_add1no 
          /**/
          fi_add2tam
          fi_add3amp
          fi_add4cnt
          fi_add5post
          /**/
          fi_comdat     
          fi_expdat     
          fi_class      
          fi_brand      
          fi_model      
          fi_cc         
          fi_licence1   
          fi_licence2   
          fi_licence3   
          fi_body       
          fi_engno      
          fi_coamt      
          fi_grprm
          fi_camp  /*A60-0542*/
          WITH FRAM fr_main.     
        /*End Add Jiraporn A59-0342*/

/*Add Jiraphon A59-0451*/          
Find  brstat.tlt  Where   Recid(brstat.tlt)  =  nv_recidtlt AND 
    brstat.tlt.releas        = "cancel"   NO-LOCK NO-ERROR NO-WAIT . 
If  avail  brstat.tlt  Then 
    DISABLE             
          fi_notdat     
          fi_notno72    
          fi_cmrsty     
          fi_stk        
          fi_companycomp
          fi_remark1    
          ra_status     
          fi_userid
        /*Add Jiraporn A59-0342*/
          fi_lotno      
          fi_contract   
          fi_branchcode 
          fi_branchno    
          fi_name       
          fi_lastname   
          fi_idno       
          fi_add1no 
          /**/
          fi_add2tam
          fi_add3amp
          fi_add4cnt
          fi_add5post
          /**/
          fi_comdat     
          fi_expdat     
          fi_class      
          fi_brand      
          fi_model      
          fi_cc         
          fi_licence1   
          fi_licence2   
          fi_licence3   
          fi_body       
          fi_engno      
          fi_coamt      
          fi_grprm
          fi_camp  /*A60-0542*/
          WITH FRAM fr_main.     
        /*End Add Jiraporn A59-0342*/
/*End Jiraphon A59-0451*/ 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

