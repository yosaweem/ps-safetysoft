&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
*/
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*------------------------------------------------------------------------
File: 
Description: 
Input Parameters:<none>
Output Parameters:<none>
Author: 
Created: ------------------------------------------------------------------------*/
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
WGWIMKLS.w :  Import text file from  K-LEASING to create new policy Add in table tlt( brstat)  
Program Import Text File    -  K-LEASING
Create  by   : Kridtiya i.  [A66-0108,A66-0109]  date. 31/05/2023
Connect      : GW_SAFE -LD SIC_BRAN, GW_STAT -LD BRSTAT ,SICSYAC  ,SICUW (not connect dbstat) 
modify  by   : kridtiya i. A66-0142  date. 18/08/2023 แก้ไขวันที่ ให้ รับค่าตรง ไม่แปลงค่า
+++++++++++++++++++++++++++++++++++++++++++++++*/

/*--------------------------สำหรับข้อมูลกรมธรรม์  -------------------------*/
DEFINE NEW SHARED TEMP-TABLE wdetail NO-UNDO
    FIELD number              AS CHAR FORMAT "x(10)"           
    FIELD TH_NAME             AS CHAR FORMAT "x(250)"      
    FIELD APPLICATION_ID      AS CHAR FORMAT "x(100)"      
    FIELD ALO_CONTRACT_NUMBER AS CHAR FORMAT "x(100)"          
    FIELD EFFECTIVE_DATE      AS CHAR FORMAT "x(100)"      
    FIELD EXPIRED_DATE        AS CHAR FORMAT "x(100)"          
    FIELD CUSTOMER_NAME       AS CHAR FORMAT "x(100)"          
    FIELD CUS_TYPE            AS CHAR FORMAT "x(100)"      
    FIELD CUSTOMER_ID         AS CHAR FORMAT "x(100)"          
    FIELD MOOBARN             AS CHAR FORMAT "x(100)"     
    FIELD ROOM_NUMBER         AS CHAR FORMAT "x(100)"     
    FIELD HOME_NUMBER         AS CHAR FORMAT "x(100)"     
    FIELD MOO                 AS CHAR FORMAT "x(100)"     
    FIELD SOI                 AS CHAR FORMAT "x(100)"     
    FIELD ROAD                AS CHAR FORMAT "x(100)"     
    FIELD TUMBOL              AS CHAR FORMAT "x(100)"     
    FIELD AMPHUR              AS CHAR FORMAT "x(100)"     
    FIELD PROVINCE            AS CHAR FORMAT "x(100)"     
    FIELD POST_CODE           AS CHAR FORMAT "x(100)"     
    FIELD BENEFICIARY         AS CHAR FORMAT "x(250)"     
    FIELD DRIVERNAME1         AS CHAR FORMAT "x(100)"     
    FIELD D_BIRTH1            AS CHAR FORMAT "x(100)"     
    FIELD D_ID1               AS CHAR FORMAT "x(100)"     
    FIELD D_DRIVE_ID1         AS CHAR FORMAT "x(100)"     
    FIELD DRIVERNAME2         AS CHAR FORMAT "x(100)"     
    FIELD D_BIRTH2            AS CHAR FORMAT "x(100)"     
    FIELD D_ID2               AS CHAR FORMAT "x(100)"     
    FIELD D_DRIVE_ID2         AS CHAR FORMAT "x(100)"     
    FIELD GARAGE_TYPE         AS CHAR FORMAT "x(100)"     
    FIELD TYPE_INSURANCE      AS CHAR FORMAT "x(100)"     
    FIELD MAKE_DESCRIPTION1   AS CHAR FORMAT "x(100)"     
    FIELD MODEL_DESCRIPTION   AS CHAR FORMAT "x(100)"     
    FIELD CHASSIS             AS CHAR FORMAT "x(100)"     
    FIELD ENGINE              AS CHAR FORMAT "x(100)"     
    FIELD REGISTER_ID         AS CHAR FORMAT "x(100)"     
    FIELD PROVINCE_ID         AS CHAR FORMAT "x(100)"     
    FIELD nYEAR               AS CHAR FORMAT "x(100)"        
    FIELD nCOLOR              AS CHAR FORMAT "x(100)"        
    FIELD VMI_VEHICLE_CODE    AS CHAR FORMAT "x(100)"        
    FIELD SEAT                AS CHAR FORMAT "x(100)"        
    FIELD CC                  AS CHAR FORMAT "x(100)"   
    FIELD WEIGHT              AS CHAR FORMAT "x(100)"   
    FIELD SUMINSURED          AS CHAR FORMAT "x(100)"   
    FIELD ACCESSORIES           AS CHAR FORMAT "x(100)"   
    FIELD ACCESSORIES_DETAIL    AS CHAR FORMAT "x(100)"   
    FIELD V_NET_PREMIUM         AS CHAR FORMAT "x(100)"   
    FIELD V_STAMP               AS CHAR FORMAT "x(100)"   
    FIELD V_VAT                 AS CHAR FORMAT "x(100)"   
    FIELD V_TOTAL_PREMIUM       AS CHAR FORMAT "x(100)"   
    FIELD V_WHT1                AS CHAR FORMAT "x(100)"   
    FIELD C_NET_PREMIUM         AS CHAR FORMAT "x(100)"   
    FIELD C_STAMP               AS CHAR FORMAT "x(100)"   
    FIELD C_VAT                 AS CHAR FORMAT "x(100)"   
    FIELD C_TOTAL_PREMIUM       AS CHAR FORMAT "x(100)"   
    FIELD C_WHT1                AS CHAR FORMAT "x(100)"   
    FIELD REMARK                AS CHAR FORMAT "x(500)"   
    FIELD PERSON_IN_CHARGE      AS CHAR FORMAT "x(100)"   
    FIELD CREATE_PERSON         AS CHAR FORMAT "x(100)"   
    FIELD APPLICATION_SIGN_DATE AS CHAR FORMAT "x(100)"   
    FIELD SRT_POLICY_NO         AS CHAR FORMAT "x(100)"   
    FIELD PAYMENT               AS CHAR FORMAT "x(100)"   
    FIELD TRACKING              AS CHAR FORMAT "x(100)"   
    FIELD POST_NO               AS CHAR FORMAT "x(100)"   
    FIELD POLICY_VOLUNTARY_NO   AS CHAR FORMAT "x(100)"   
    FIELD POLICY_COMPULSURY_NO  AS CHAR FORMAT "x(100)"   
    FIELD JOB_STATUS            AS CHAR FORMAT "x(100)"   
    FIELD notifyno              AS CHAR FORMAT "x(100)"   
    FIELD ENDORSE_TYPE          AS CHAR FORMAT "x(100)"   
    FIELD ENDORSE_DETAIL        AS CHAR FORMAT "x(100)"   
    FIELD notifyKL              AS CHAR FORMAT "x(100)"   
    FIELD stickerno             AS CHAR FORMAT "x(100)"   
    FIELD DEALER                AS CHAR FORMAT "x(100)"   
    FIELD AI_CHECK              AS CHAR FORMAT "x(100)"   
    FIELD AI_CHECK_MOBILE       AS CHAR FORMAT "x(100)" 
    FIELD PACKAGE_NAME          AS CHAR FORMAT "x(100)"  .  

DEFINE VAR nv_daily       AS CHARACTER FORMAT "X(1024)"     INITIAL ""  NO-UNDO.
DEFINE VAR nv_reccnt      AS INT  INIT  0.
DEFINE VAR nv_completecnt AS INT  INIT  0.
DEF VAR comdat AS DATE.
DEF VAR expdat AS DATE.

/*
DEFINE VAR nv_dri_cnt     AS INT  INIT  0.

DEFINE VAR nv_dri_complet AS INT  INIT  0.
DEFINE VAR nv_enttim      AS CHAR INIT  "".
DEFINE VAR nv_Load        AS LOGIC  INIT   Yes.

    






DEF  STREAM nfile.  
DEF VAR nv_accdat   AS DATE   FORMAT "99/99/9999"   NO-UNDO.
DEF VAR nv_comdat   AS DATE   FORMAT "99/99/9999"   NO-UNDO.
DEF VAR nv_expdat   AS DATE   FORMAT "99/99/9999"   NO-UNDO.
DEF VAR nv_comdat72   AS DATE   FORMAT "99/99/9999"   NO-UNDO.
DEF VAR nv_expdat72   AS DATE   FORMAT "99/99/9999"   NO-UNDO.
DEF VAR nv_notdat   AS DATE   FORMAT "99/99/9999"   NO-UNDO.
DEF VAR nv_nottim   AS Char   Format "X(8)"         no-undo.
DEF VAR nv_comchr   AS CHAR   . 
DEF VAR nv_dd       AS INT    FORMAT "99".
DEF VAR nv_mm       AS INT    FORMAT "99".
DEF VAR nv_yy       AS INT    FORMAT "9999".
DEF VAR nv_cpamt1   AS DECI   INIT 0.
DEF VAR nv_cpamt2   AS DECI   INIT 0.
DEF VAR nv_cpamt3   AS DECI   INIT 0   format  ">,>>>,>>9.99".
DEF VAR nv_coamt1   AS DECI   INIT 0.  
DEF VAR nv_coamt2   AS DECI   INIT 0.  
DEF VAR nv_coamt3   AS DECI   INIT 0   format ">,>>>,>>9.99".
DEF VAR nv_insamt1  AS DECI   INIT 0.  
DEF VAR nv_insamt2  AS DECI   INIT 0.  
DEF VAR nv_insamt3  AS DECI   INIT 0   Format  ">>,>>>,>>9.99".
DEF VAR nv_premt1   AS DECI   INIT 0.  
DEF VAR nv_premt2   AS DECI   INIT 0.  
DEF VAR nv_premt3   AS DECI   INIT 0   Format ">,>>>,>>9.99".
DEF VAR nv_fleet1   AS DECI   INIT 0.  
DEF VAR nv_fleet2   AS DECI   INIT 0.  
DEF VAR nv_fleet3   AS DECI   INIT 0   Format ">>9.99".
DEF VAR nv_ncb1     AS DECI   INIT 0.  
DEF VAR nv_ncb2     AS DECI   INIT 0.  
DEF VAR nv_ncb3     AS DECI   INIT 0   Format ">>9.99".
DEF VAR nv_oth1     AS DECI   INIT 0.  
DEF VAR nv_oth2     AS DECI   INIT 0.  
DEF VAR nv_oth3     AS DECI   INIT 0   Format ">>9.99".
DEF VAR nv_deduct1  AS DECI   INIT 0.  
DEF VAR nv_deduct2  AS DECI   INIT 0.  
DEF VAR nv_deduct3  AS DECI   INIT 0   Format ">>9.99".
DEF VAR nv_power1   AS DECI   INIT 0.  
DEF VAR nv_power2   AS DECI   INIT 0.  
DEF VAR nv_power3   AS DECI   INIT 0   Format ">,>>9.99".
DEF VAR nv_name1    AS CHAR   INIT  ""  Format "X(50)".
DEF VAR nv_ntitle   AS CHAR   INIT  ""  Format  "X(10)". 
DEF VAR nv_titleno  AS INT    INIT  0   .  
DEF VAR nv_policy   AS CHAR   INIT  ""  Format  "X(12)".
DEF VAR nv_oldpol   AS CHAR   INIT  ""  .
def var nv_source   as char   FORMAT  "X(35)".
def var nv_indexno  as int    init  0.
def var nv_indexno1 as int    init  0.
def var nv_cnt      as int    init  1.
def var nv_addr     as char   extent 4  format "X(35)".
def var nv_pol      as char   init  "".
def var nv_newpol   as char   init  "".
DEF VAR nn_remark1  AS CHAR INIT "".   /*A56-0399*/
DEF VAR nn_remark2  AS CHAR INIT "".   /*A56-0399*/
DEF VAR nn_remark3  AS CHAR INIT "".   /*A56-0399*/
DEF VAR nv_len      AS INTE INIT 0.    /*A56-0399*/
/* A62-0219*/
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
def  var nv_extref       as char.
/* add by A62-0445  */
DEF VAR nv_ispstatus AS CHAR.
DEF VAR chSession       AS COM-HANDLE.
DEF VAR chWorkSpace     AS COM-HANDLE.
DEF VAR chName          AS COM-HANDLE.
DEF VAR chDatabase      AS COM-HANDLE.
DEF VAR chView          AS COM-HANDLE.
DEF VAR chViewNavigator AS COM-HANDLE.
DEF VAR chUIDocument    AS COM-HANDLE.
DEF VAR NotesServer  AS CHAR.
DEF VAR NotesApp     AS CHAR.
DEF VAR NotesView    AS CHAR.
DEF VAR nv_chknotes  AS CHAR.
DEF VAR nv_chkdoc    AS LOG.
DEF VAR nv_year      AS CHAR.
DEF VAR nv_msgbox    AS CHAR.   
DEF VAR nv_name      AS CHAR.
DEF VAR nv_datim     AS CHAR.
DEF VAR nv_branch    AS CHAR.
DEF VAR nv_brname    AS CHAR.
DEF VAR nv_pattern   AS CHAR.
DEF VAR nv_count     AS INT.
DEF VAR nv_text1     AS CHAR.
DEF VAR nv_text2     AS CHAR.
DEF VAR nv_chktext   AS INT.
DEF VAR nv_model     AS CHAR.
DEF VAR nv_modelcode AS CHAR.
DEF VAR nv_makdes    AS CHAR.
DEF VAR nv_licence1  AS CHAR.
DEF VAR nv_licence2  AS CHAR.
/**/
DEF VAR nv_cha_no  AS CHAR.
DEF VAR nv_doc_num AS INT.
DEF VAR nv_licen1  AS CHAR.
DEF VAR nv_licen2  AS CHAR.
DEF VAR nv_key1    AS CHAR.
DEF VAR nv_key2    AS CHAR.
DEF VAR nv_surcl   AS CHAR.
DEF VAR nv_docno   AS CHAR.

DEF VAR nv_brdesc AS CHAR FORMAT "x(50)" INIT "" .
DEF VAR nv_brcode AS CHAR FORMAT "x(3)" INIT "" .
DEF VAR nv_comco AS CHAR FORMAT "x(10)" INIT "" .
DEF VAR nv_producer AS CHAR FORMAT "x(10)" INIT "" .
DEF VAR nv_agent AS CHAR FORMAT "x(10)" INIT "" .
DEF VAR nv_char AS CHAR FORMAT "x(225)" INIT "" .
DEF VAR nv_length AS INT INIT 0.
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
Def var nv_acctotal      as char format "x(100)".   
DEF VAR nv_surdata       AS CHAR FORMAT "x(250)".  
DEF VAR nv_date          AS CHAR FORMAT "x(15)" .
DEF VAR nv_damdetail     AS LONGCHAR .
DEF VAR nv_sumsi         AS DECI INIT 0 .
DEF VAR n_day AS INT INIT 0.
DEF VAR nv_insi AS DECI INIT 0.
DEF VAR nv_provin AS CHAR FORMAT "x(10)" .
DEF VAR nv_key3 AS CHAR FORMAT "x(35)" .
DEF VAR nv_susupect AS CHAR FORMAT "x(255)" .
DEF VAR n_list      AS INT init 0.
DEF VAR n_count     AS INT init 0.*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main
&Scoped-define BROWSE-NAME br_imptxt

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES wdetail

/* Definitions for BROWSE br_imptxt                                     */
&Scoped-define FIELDS-IN-QUERY-br_imptxt wdetail.notifyKL wdetail.APPLICATION_ID wdetail.ALO_CONTRACT_NUMBER wdetail.EFFECTIVE_DATE wdetail.EXPIRED_DATE wdetail.CUSTOMER_NAME wdetail.CUSTOMER_ID wdetail.MOOBARN wdetail.ROOM_NUMBER wdetail.HOME_NUMBER wdetail.MOO wdetail.SOI wdetail.ROAD wdetail.TUMBOL wdetail.AMPHUR wdetail.PROVINCE wdetail.POST_CODE wdetail.GARAGE_TYPE wdetail.TYPE_INSURANCE wdetail.MAKE_DESCRIPTION1 wdetail.MODEL_DESCRIPTION wdetail.CHASSIS wdetail.ENGINE wdetail.REGISTER_ID wdetail.PROVINCE_ID wdetail.nYEAR wdetail.nCOLOR   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_imptxt   
&Scoped-define SELF-NAME br_imptxt
&Scoped-define QUERY-STRING-br_imptxt FOR EACH wdetail NO-LOCK
&Scoped-define OPEN-QUERY-br_imptxt OPEN QUERY br_imptxt FOR EACH wdetail NO-LOCK.
&Scoped-define TABLES-IN-QUERY-br_imptxt wdetail
&Scoped-define FIRST-TABLE-IN-QUERY-br_imptxt wdetail


/* Definitions for FRAME fr_main                                        */
&Scoped-define OPEN-BROWSERS-IN-QUERY-fr_main ~
    ~{&OPEN-QUERY-br_imptxt}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS br_imptxt ra_typefile fi_loaddat fi_compa ~
fi_filename bu_ok bu_exit bu_file RECT-1 RECT-79 RECT-80 RECT-380 
&Scoped-Define DISPLAYED-OBJECTS ra_typefile fi_loaddat fi_compa ~
fi_filename fi_impcnt fi_completecnt 

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
     SIZE 8.5 BY 1
     FONT 6.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 4 BY 1.

DEFINE BUTTON bu_ok 
     LABEL "Ok" 
     SIZE 8.5 BY 1
     FONT 6.

DEFINE VARIABLE fi_compa AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 16.5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_completecnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY 1
     BGCOLOR 1 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 76 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_impcnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11 BY 1
     BGCOLOR 1 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_loaddat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 16.5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE ra_typefile AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "NEW", 1,
"RENEW", 2
     SIZE 33 BY .91
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132 BY 23.81
     BGCOLOR 18 .

DEFINE RECTANGLE RECT-380
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 128.5 BY 6.71
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-79
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 11.5 BY 1.91
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-80
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10.5 BY 1.91
     BGCOLOR 4 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_imptxt FOR 
      wdetail SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_imptxt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_imptxt C-Win _FREEFORM
  QUERY br_imptxt NO-LOCK DISPLAY
      wdetail.notifyKL             COLUMN-LABEL "Notify_No"        FORMAT "x(20)"       
      wdetail.APPLICATION_ID       COLUMN-LABEL "APPLICATION_ID"   FORMAT "x(20)"
      wdetail.ALO_CONTRACT_NUMBER  COLUMN-LABEL "CONTRACT_NUMBER"  FORMAT "x(20)"
      wdetail.EFFECTIVE_DATE       COLUMN-LABEL "EFFECTIVE_DATE"   FORMAT "x(12)"   
      wdetail.EXPIRED_DATE         COLUMN-LABEL "EXPIRED_DATE"     FORMAT "x(12)"     
      wdetail.CUSTOMER_NAME        COLUMN-LABEL "CUSTOMER_NAME"    FORMAT "x(60)"  
      wdetail.CUSTOMER_ID          COLUMN-LABEL "CUSTOMER_ID"      FORMAT "x(15)"      
      wdetail.MOOBARN              COLUMN-LABEL "MOOBARN"          FORMAT "x(20)"               
      wdetail.ROOM_NUMBER          COLUMN-LABEL "ROOM"             FORMAT "x(20)"       
      wdetail.HOME_NUMBER          COLUMN-LABEL "HOME"             FORMAT "x(20)"      
      wdetail.MOO                  COLUMN-LABEL "MOO"              FORMAT "x(20)"                       
      wdetail.SOI                  COLUMN-LABEL "SOI"              FORMAT "x(20)"              
      wdetail.ROAD                 COLUMN-LABEL "ROAD"             FORMAT "x(20)"             
      wdetail.TUMBOL               COLUMN-LABEL "TUMBOL"           FORMAT "x(20)"           
      wdetail.AMPHUR               COLUMN-LABEL "AMPHUR"           FORMAT "x(20)"           
      wdetail.PROVINCE             COLUMN-LABEL "PROVINCE"         FORMAT "x(20)"         
      wdetail.POST_CODE            COLUMN-LABEL "POST_CODE"        FORMAT "x(20)" 
      wdetail.GARAGE_TYPE          COLUMN-LABEL "GARAGE"           FORMAT "x(20)"
      wdetail.TYPE_INSURANCE       COLUMN-LABEL "TYPE_INSURANCE"   FORMAT "x(20)"   
      wdetail.MAKE_DESCRIPTION1    COLUMN-LABEL "Brand"            FORMAT "x(20)"
      wdetail.MODEL_DESCRIPTION    COLUMN-LABEL "MODEL"            FORMAT "x(30)" 
      wdetail.CHASSIS              COLUMN-LABEL "CHASSIS"          FORMAT "x(30)"            
      wdetail.ENGINE               COLUMN-LABEL "ENGINE"           FORMAT "x(30)"           
      wdetail.REGISTER_ID          COLUMN-LABEL "REGISTER_ID"      FORMAT "x(20)"      
      wdetail.PROVINCE_ID          COLUMN-LABEL "PROVINCE_ID"      FORMAT "x(20)"      
      wdetail.nYEAR                COLUMN-LABEL "nYEAR"            FORMAT "x(20)"            
      wdetail.nCOLOR               COLUMN-LABEL "nCOLOR"           FORMAT "x(20)"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 128 BY 15.48
         BGCOLOR 19 FGCOLOR 2 FONT 4 ROW-HEIGHT-CHARS .71 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     br_imptxt AT ROW 9.1 COL 3.17
     ra_typefile AT ROW 2.57 COL 40.17 NO-LABEL WIDGET-ID 16
     fi_loaddat AT ROW 1.52 COL 38 COLON-ALIGNED NO-LABEL
     fi_compa AT ROW 1.52 COL 72 COLON-ALIGNED NO-LABEL
     fi_filename AT ROW 3.62 COL 38 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 4.86 COL 101.5
     bu_exit AT ROW 4.86 COL 110.83
     bu_file AT ROW 3.67 COL 116.33
     fi_impcnt AT ROW 4.86 COL 38.33 COLON-ALIGNED NO-LABEL
     fi_completecnt AT ROW 4.86 COL 75.17 COLON-ALIGNED NO-LABEL
     "รายการ" VIEW-AS TEXT
          SIZE 7 BY 1 AT ROW 4.86 COL 52.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     " ข้อมูลแจ้งประกันนำเข้าทั้งหมด  :":50 VIEW-AS TEXT
          SIZE 29 BY 1 AT ROW 4.76 COL 10.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "  รายละเอียดข้อมูล" VIEW-AS TEXT
          SIZE 128.5 BY .81 AT ROW 8.29 COL 2.83
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "                   วันที่ไฟล์แจ้งงาน :" VIEW-AS TEXT
          SIZE 29 BY .95 AT ROW 1.52 COL 10.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "                          ประเภทงาน :" VIEW-AS TEXT
          SIZE 29 BY 1 AT ROW 2.52 COL 10.5 WIDGET-ID 14
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Company code  :" VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 1.52 COL 57.33
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "รายการ" VIEW-AS TEXT
          SIZE 7 BY 1 AT ROW 4.86 COL 89.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "นำเข้าระบบได้  :":60 VIEW-AS TEXT
          SIZE 15 BY 1 AT ROW 4.86 COL 61.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Day : 18/08/2023" VIEW-AS TEXT
          SIZE 18.5 BY 1 AT ROW 1.48 COL 111 WIDGET-ID 12
     "           กรุณาป้อนชื่อไฟล์นำเข้า :" VIEW-AS TEXT
          SIZE 29 BY 1 AT ROW 3.57 COL 10.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     RECT-1 AT ROW 1 COL 1
     RECT-79 AT ROW 5 COL 98
     RECT-80 AT ROW 5 COL 109.83
     RECT-380 AT ROW 1.19 COL 2.83
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
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
         TITLE              = "Hold Data Text file K-leasing"
         HEIGHT             = 24
         WIDTH              = 132
         MAX-HEIGHT         = 33.91
         MAX-WIDTH          = 170.67
         VIRTUAL-HEIGHT     = 33.91
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
IF NOT C-Win:LOAD-ICON("WIMAGE/iconhead.ico":U) THEN
    MESSAGE "Unable to load icon: WIMAGE/iconhead.ico"
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
/* BROWSE-TAB br_imptxt 1 fr_main */
ASSIGN 
       bu_file:AUTO-RESIZE IN FRAME fr_main      = TRUE.

/* SETTINGS FOR FILL-IN fi_completecnt IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_impcnt IN FRAME fr_main
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_imptxt
/* Query rebuild information for BROWSE br_imptxt
     _START_FREEFORM
OPEN QUERY br_imptxt FOR EACH wdetail NO-LOCK.
     _END_FREEFORM
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Query            is OPENED
*/  /* BROWSE br_imptxt */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Hold Data Text file K-leasing */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Hold Data Text file K-leasing */
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
  Apply "Close" To  This-procedure.
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
        /*      FILTERS    "Text Documents" "*.txt"    */
        FILTERS    /* "Text Documents"   "*.txt",
        "Data Files (*.*)"     "*.*"*/
        "Text Documents" "*.csv"
        
        
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
    ASSIGN 
        nv_daily   =  ""
        nv_reccnt  =  0.
    For each  wdetail:
        DELETE  wdetail.
    END.
    IF ra_typefile = 1 THEN Run Import_file.
    ELSE Run Import_fileRe.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_compa
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_compa C-Win
ON LEAVE OF fi_compa IN FRAME fr_main
DO:
    fi_compa =  INPUT  fi_compa.
    Disp  fi_compa   WITH Frame  fr_main.                 

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_filename
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_filename C-Win
ON LEAVE OF fi_filename IN FRAME fr_main
DO:
  fi_filename  =  Input  fi_filename .
  Disp  fi_filename with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_loaddat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_loaddat C-Win
ON LEAVE OF fi_loaddat IN FRAME fr_main
DO:
    fi_loaddat  =  Input  fi_loaddat.
    Disp fi_loaddat  with frame  fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_typefile
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_typefile C-Win
ON VALUE-CHANGED OF ra_typefile IN FRAME fr_main
DO:
  ra_typefile = INPUT ra_typefile .
  DISP ra_typefile WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_imptxt
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
  
  gv_prgid = "WGWIMKLS".
  gv_prog  = "Hold Text File K-LEASING".
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).

/*********************************************************************/ 

  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.
  
  /*RECT-4:MOVE-TO-TOP().
  RECT-75:MOVE-TO-TOP().  */
 
  Hide Frame  fr_gen  .
  ASSIGN  
      fi_loaddat  =  today
      fi_compa    = "K-LEASING" 
      ra_typefile = 1.

       
      
  disp  fi_loaddat  fi_compa  ra_typefile  with  frame  fr_main.
  
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
  DISPLAY ra_typefile fi_loaddat fi_compa fi_filename fi_impcnt fi_completecnt 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE br_imptxt ra_typefile fi_loaddat fi_compa fi_filename bu_ok bu_exit 
         bu_file RECT-1 RECT-79 RECT-80 RECT-380 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Import_file C-Win 
PROCEDURE Import_file :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH  wdetail :
    DELETE  wdetail.
END.
INPUT FROM VALUE(fi_FileName).
REPEAT:
    CREATE wdetail.
    IMPORT DELIMITER "|"         
        wdetail.number                
        wdetail.TH_NAME               
        wdetail.APPLICATION_ID        
        wdetail.ALO_CONTRACT_NUMBER   
        wdetail.EFFECTIVE_DATE        
        wdetail.EXPIRED_DATE          
        wdetail.CUSTOMER_NAME         
        wdetail.CUS_TYPE              
        wdetail.CUSTOMER_ID           
        wdetail.MOOBARN               
        wdetail.ROOM_NUMBER           
        wdetail.HOME_NUMBER           
        wdetail.MOO                   
        wdetail.SOI                   
        wdetail.ROAD                  
        wdetail.TUMBOL                
        wdetail.AMPHUR                
        wdetail.PROVINCE              
        wdetail.POST_CODE             
        wdetail.BENEFICIARY           
        wdetail.DRIVERNAME1           
        wdetail.D_BIRTH1              
        wdetail.D_ID1                 
        wdetail.D_DRIVE_ID1           
        wdetail.DRIVERNAME2                       
        wdetail.D_BIRTH2              
        wdetail.D_ID2                 
        wdetail.D_DRIVE_ID2           
        wdetail.GARAGE_TYPE           
        wdetail.TYPE_INSURANCE        
        wdetail.MAKE_DESCRIPTION1     
        wdetail.MODEL_DESCRIPTION     
        wdetail.CHASSIS               
        wdetail.ENGINE                
        wdetail.REGISTER_ID           
        wdetail.PROVINCE_ID           
        wdetail.nYEAR                   
        wdetail.nCOLOR                
        wdetail.VMI_VEHICLE_CODE      
        wdetail.SEAT                  
        wdetail.CC                    
        wdetail.WEIGHT                
        wdetail.SUMINSURED            
        wdetail.ACCESSORIES           
        wdetail.ACCESSORIES_DETAIL    
        wdetail.V_NET_PREMIUM         
        wdetail.V_STAMP               
        wdetail.V_VAT                 
        wdetail.V_TOTAL_PREMIUM       
        wdetail.V_WHT1                
        wdetail.C_NET_PREMIUM         
        wdetail.C_STAMP               
        wdetail.C_VAT                 
        wdetail.C_TOTAL_PREMIUM       
        wdetail.C_WHT1                
        wdetail.REMARK                
        wdetail.PERSON_IN_CHARGE      
        wdetail.CREATE_PERSON         
        wdetail.APPLICATION_SIGN_DATE 
        wdetail.SRT_POLICY_NO         
        wdetail.PAYMENT               
        wdetail.TRACKING              
        wdetail.POST_NO               
        wdetail.POLICY_VOLUNTARY_NO   
        wdetail.POLICY_COMPULSURY_NO  
        wdetail.JOB_STATUS            
        wdetail.notifyno              
        wdetail.ENDORSE_TYPE          
        wdetail.ENDORSE_DETAIL        
        wdetail.notifyKL              
        wdetail.stickerno             
        wdetail.DEALER                
        wdetail.AI_CHECK              
        wdetail.AI_CHECK_MOBILE  . 
END.   /* repeat  */

FOR EACH wdetail WHERE 
      wdetail.number    = "" .
      DELETE wdetail.
END.

ASSIGN 
    nv_reccnt       = 0
    nv_completecnt  = 0 . 

Run proc_Create_tlt.

If  nv_completecnt  <>  0  Then do:
    Enable br_imptxt With frame fr_main.
END.
fi_completecnt  =  nv_completecnt.
fi_impcnt       =  nv_reccnt.
Disp fi_completecnt   fi_impcnt with frame  fr_main.

Message "Load  Data Complete"  View-as alert-box.  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Import_fileRe C-Win 
PROCEDURE Import_fileRe :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH  wdetail :
    DELETE  wdetail.
END.
INPUT FROM VALUE(fi_FileName).
REPEAT:
    CREATE wdetail.
    IMPORT DELIMITER "|"         
        wdetail.number                
        wdetail.TH_NAME               
        wdetail.APPLICATION_ID        
        wdetail.EFFECTIVE_DATE        
        wdetail.EXPIRED_DATE          
        wdetail.CUSTOMER_NAME         
        wdetail.CUS_TYPE              
        wdetail.CUSTOMER_ID           
        wdetail.MOOBARN               
        wdetail.ROOM_NUMBER           
        wdetail.HOME_NUMBER           
        wdetail.MOO                   
        wdetail.SOI                   
        wdetail.ROAD                  
        wdetail.TUMBOL                
        wdetail.AMPHUR                
        wdetail.PROVINCE              
        wdetail.POST_CODE             
        wdetail.BENEFICIARY           
        wdetail.DRIVERNAME1           
        wdetail.D_BIRTH1              
        wdetail.D_ID1                 
        wdetail.D_DRIVE_ID1           
        wdetail.DRIVERNAME2                       
        wdetail.D_BIRTH2              
        wdetail.D_ID2                 
        wdetail.D_DRIVE_ID2           
        wdetail.GARAGE_TYPE           
        wdetail.TYPE_INSURANCE        
        wdetail.MAKE_DESCRIPTION1     
        wdetail.MODEL_DESCRIPTION     
        wdetail.CHASSIS               
        wdetail.ENGINE                
        wdetail.REGISTER_ID           
        wdetail.PROVINCE_ID           
        wdetail.nYEAR                   
        wdetail.nCOLOR                
        wdetail.VMI_VEHICLE_CODE      
        wdetail.SEAT                  
        wdetail.CC                    
        wdetail.WEIGHT                
        wdetail.SUMINSURED            
        wdetail.ACCESSORIES           
        wdetail.ACCESSORIES_DETAIL    
        wdetail.V_NET_PREMIUM         
        wdetail.V_STAMP               
        wdetail.V_VAT                 
        wdetail.V_TOTAL_PREMIUM       
        wdetail.V_WHT1                
        wdetail.C_NET_PREMIUM         
        wdetail.C_STAMP               
        wdetail.C_VAT                 
        wdetail.C_TOTAL_PREMIUM       
        wdetail.C_WHT1                
        wdetail.REMARK 
        wdetail.PAYMENT               
        wdetail.TRACKING    
        wdetail.notifyno         
        wdetail.PACKAGE_NAME   . 
END.   /* repeat  */

FOR EACH wdetail WHERE 
      wdetail.APPLICATION_ID    = "" .
      DELETE wdetail.
END.

ASSIGN 
    nv_reccnt       = 0
    nv_completecnt  = 0 . 

Run proc_Create_tlt.

If  nv_completecnt  <>  0  Then do:
    Enable br_imptxt With frame fr_main.
END.
fi_completecnt  =  nv_completecnt.
fi_impcnt       =  nv_reccnt.
Disp fi_completecnt   fi_impcnt with frame  fr_main.

Message "Load  Data Complete"  View-as alert-box.  

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Import_New C-Win 
PROCEDURE Import_New :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*DEF VAR   nv_ncb  as  char  init  "" format "X(5)".*/
/*FOR EACH  wdetail :
    DELETE  wdetail.
END.
INPUT FROM VALUE(fi_FileName).
REPEAT:
    CREATE wdetail.
    IMPORT DELIMITER "|"         
            wdetail.n_no          /*No                   */  
            wdetail.Pro_off       /*InsComp              */  
            wdetail.branch        /*OffCde               */  
            wdetail.safe_no       /*InsuranceReceivedNo  */  
            wdetail.Account_no    /*ApplNo               */  
            wdetail.name_insur    /*CustName             */  
            wdetail.icno          /*IDNo                 */  
            wdetail.garage        /*RepairType           */  
            wdetail.CustAge       /*CustAge              */  
            wdetail.Category      /*Category             */  
            wdetail.CarType       /*CarType              */  
            wdetail.brand         /*Brand                */  
            wdetail.Brand_Model   /*Model                */  
            wdetail.CC            /*CC                   */  
            wdetail.yrmanu        /*CarYear              */  
            wdetail.RegisDate     /*RegisDate            */  
            wdetail.engine        /*EngineNo             */  
            wdetail.chassis       /*ChassisNo            */  
            wdetail.RegisNo       /*RegisNo              */  
            wdetail.RegisProv     /*RegisProv            */  
            wdetail.n_class       /*InsLicTyp            */  
            wdetail.InsTyp        /*InsTyp               */  
            wdetail.CovTyp        /*CovTyp               */  
            wdetail.SI            /*InsuranceAmt (crash) */  
            wdetail.FI            /*InsuranceAmt (loss)  */  
            wdetail.comdat        /*InsuranceStartDate   */  
            wdetail.expdat        /*InsuranceExpireDate  */  
            wdetail.netprem       /*InsuranceNetFee      */  
            wdetail.totalprem     /*InsuranceFee         */  
            wdetail.wht           /*InsuranceWHT         */  
            wdetail.ben_name      /*Beneficiary          */  
            wdetail.CMRName       /*CMRName              */  
            wdetail.sckno         /*InsurancePolicyNo    */  
            wdetail.comdat72      /*LawInsStartDate      */  
            wdetail.expdat72      /*LawInsEndDate        */  
            wdetail.comp_prm      /*LawInsFee            */  
            wdetail.Remark        /*Other                */  
            wdetail.DealerName    /*DealerName           */  
            wdetail.CustAddress   /*CustAddress          */  
            wdetail.CustTel       /*CustTel              */
            wdetail.Otherins      /* Otherins */ 
            wdetail.campaign .    /* campaign */  /*A60-0263*/

    IF INDEX(wdetail.n_no,"No")   <> 0 THEN  DELETE wdetail.
    ELSE IF  wdetail.n_no         = "" THEN  DELETE wdetail.
END.  /* repeat  */
ASSIGN nv_reccnt    = 0
    nv_completecnt  = 0 . 
Run proc_Create_tltnew.
If  nv_completecnt  <>  0  Then do:
    Enable br_imptxt With frame fr_main.
End. 
fi_completecnt  =  nv_completecnt.
fi_impcnt       =  nv_reccnt.
Disp fi_completecnt   fi_impcnt with frame  fr_main.
Message "Load  Data Complete"  View-as alert-box.  */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE import_Renew C-Win 
PROCEDURE import_Renew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*FOR EACH  wdetail :
    DELETE  wdetail.
END.
INPUT FROM VALUE(fi_FileName).
REPEAT:
    CREATE wdetail.
    IMPORT DELIMITER "|"        
            wdetail.Pro_off         /*ชื่อบริษัทประกัน*/ 
            wdetail.safe_no         /*เลขรับแจ้ง      */ 
            wdetail.Prevpol         /*เลขกธ.เดิม      */ 
            wdetail.Account_no      /*เลขสัญญา        */ 
            wdetail.name_insur      /*ชื่อลูกค้า      */ 
            wdetail.icno            /*ID              */ 
            wdetail.CarType         /*ประเภทรถยนต์    */ 
            wdetail.brand           /*ยี่ห้อ          */ 
            wdetail.Brand_Model     /*รุ่นรถ          */ 
            wdetail.CC              /*cc              */ 
            wdetail.yrmanu          /*ปีรถ            */ 
            wdetail.engine          /*เลขเครื่อง      */ 
            wdetail.chassis         /*เลขถัง          */ 
            wdetail.RegisNo         /*ทะเบียน         */ 
            wdetail.RegisProv       /*จังหวัด         */ 
            wdetail.n_class         /*ประเภทจดทะเบียน */ 
            wdetail.CovTyp          /*ความคุ้มครอง    */ 
            wdetail.SI              /*ทุนชน           */ 
            wdetail.FI              /*ทุนหาย          */ 
            wdetail.comdat          /*วันคุ้มครอง     */ 
            wdetail.expdat          /*วันหมดอายุ      */ 
            wdetail.netprem         /*เบี้ยสุทธิ      */ 
            wdetail.totalprem       /*เบี้ยรวม        */ 
            wdetail.CMRName         /*ผู้แจ้ง(ปีต่อ)  */ 
            wdetail.sckno           /*เลขบาร์โค๊ต     */ 
            wdetail.ben_name        /*ผู้รับผลประโยขน์*/ 
            wdetail.Remark.         /*หมายเหตุ        */ 
    IF      INDEX(wdetail.Pro_off,"งาน")    <> 0 THEN  DELETE wdetail.
    ELSE IF INDEX(wdetail.Pro_off,"ชื่อ")   <> 0 THEN  DELETE wdetail.
    ELSE IF  wdetail.Pro_off           = "" THEN  DELETE wdetail.
END.  /* repeat  */
ASSIGN nv_reccnt    = 0
    nv_completecnt  = 0 . 
Run proc_Create_tltrenew.
If  nv_completecnt  <>  0  Then do:
    Enable br_imptxt With frame fr_main.
End. 
fi_completecnt  =  nv_completecnt.
fi_impcnt       =  nv_reccnt.
Disp fi_completecnt   fi_impcnt with frame  fr_main.
Message "Load  Data Complete"  View-as alert-box.  */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create_tlt C-Win 
PROCEDURE proc_create_tlt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n AS INT INIT 0.

LOOP_wdetail:
FOR EACH wdetail . 
    IF         wdetail.APPLICATION_ID = "" THEN DELETE wdetail.   
    ELSE DO:
        nv_reccnt  = nv_reccnt  + 1.
        comdat = ?.
        expdat = ?.
        /*comment by Kridtiya i. A66-0142  */
        /*IF ra_typefile = 1 THEN ASSIGN 
             

        comdat          = date(substr(trim(wdetail.EFFECTIVE_DATE),4,2) + "/" +  /*09/06/2022*/ 
                                         substr(trim(wdetail.EFFECTIVE_DATE),1,2) + "/" +  
                                         substr(trim(wdetail.EFFECTIVE_DATE),7,4))           
            expdat         = date(substr(trim(wdetail.EXPIRED_DATE),4,2)   + "/" +  /*09/06/2023*/
                                         substr(trim(wdetail.EXPIRED_DATE),1,2)   + "/" +  
                                         substr(trim(wdetail.EXPIRED_DATE),7,4))  .
        ELSE*/ /*comment by Kridtiya i. A66-0142  */
             ASSIGN 
             comdat = date(wdetail.EFFECTIVE_DATE)
             expdat = date(wdetail.EXPIRED_DATE).
      FIND LAST brstat.tlt USE-INDEX tlt06  WHERE         
          /*brstat.tlt.nor_noti_tlt = trim(wdetail.notifyKL)  AND*/
          brstat.tlt.lotno        = trim(wdetail.APPLICATION_ID)  AND  
          brstat.tlt.cha_no       = trim(wdetail.CHASSIS)   AND
          brstat.tlt.eng_no       = trim(wdetail.ENGINE)    AND
          brstat.tlt.packnme      = trim(wdetail.TYPE_INSURANCE)  AND
          brstat.tlt.genusr       = fi_compa                NO-ERROR NO-WAIT .
      IF NOT AVAIL brstat.tlt THEN DO:
          nv_completecnt  =  nv_completecnt + 1.
          CREATE brstat.tlt.
          ASSIGN                                                 
            brstat.tlt.entdat          = TODAY                             /* วันที่โหลด */                          
            brstat.tlt.enttim          = STRING(TIME,"HH:MM:SS")           /* เวลาโหลด   */                          
            brstat.tlt.trndat          = fi_loaddat                        /* วันที่จากหน้าจอ*/
            brstat.tlt.genusr          = fi_compa                                                   
            brstat.tlt.usrid           = USERID(LDBNAME(1))                /*User Load Data */                      
            brstat.tlt.imp             = "IM"                              /*Import Data*/                          
            brstat.tlt.releas          = "No"                              
            brstat.tlt.safe1           = trim(wdetail.TH_NAME)               
            brstat.tlt.lotno           = trim(wdetail.APPLICATION_ID)      
            brstat.tlt.safe2           = trim(wdetail.ALO_CONTRACT_NUMBER)  
            brstat.tlt.gendat          = comdat        
            brstat.tlt.expodat         = expdat 
            brstat.tlt.ins_name        = trim(wdetail.CUSTOMER_NAME)   
            brstat.tlt.ins_brins       = trim(wdetail.CUS_TYPE)   
            brstat.tlt.ins_icno        = trim(wdetail.CUSTOMER_ID)   
            brstat.tlt.hrg_vill        = trim(wdetail.MOOBARN)     
            brstat.tlt.hrg_room        = trim(wdetail.ROOM_NUMBER)     
            brstat.tlt.hrg_no          = trim(wdetail.HOME_NUMBER)   
            brstat.tlt.hrg_moo         = trim(wdetail.MOO)     
            brstat.tlt.hrg_soi         = trim(wdetail.SOI)   
            brstat.tlt.hrg_street      = trim(wdetail.ROAD)   
            brstat.tlt.hrg_subdistrict = trim(wdetail.TUMBOL)   
            brstat.tlt.hrg_district    = trim(wdetail.AMPHUR)   
            brstat.tlt.hrg_prov        = trim(wdetail.PROVINCE)    
            brstat.tlt.hrg_postcd      = trim(wdetail.POST_CODE)   
            brstat.tlt.ben83           = trim(wdetail.BENEFICIARY)   
            brstat.tlt.dri_name1       = trim(wdetail.DRIVERNAME1)     
            brstat.tlt.dri_no1         = trim(wdetail.D_BIRTH1)   
            brstat.tlt.dri_ic1         = trim(wdetail.D_ID1)   
            brstat.tlt.dri_lic1        = trim(wdetail.D_DRIVE_ID1)   
            brstat.tlt.dri_name2       = trim(wdetail.DRIVERNAME2)   
            brstat.tlt.dri_no2         = trim(wdetail.D_BIRTH2)   
            brstat.tlt.dri_ic2         = trim(wdetail.D_ID2)   
            brstat.tlt.dri_lic2        = trim(wdetail.D_DRIVE_ID2)     
            brstat.tlt.pack            = trim(wdetail.GARAGE_TYPE)   
            brstat.tlt.packnme         = trim(wdetail.TYPE_INSURANCE)   
            brstat.tlt.brand           = trim(wdetail.MAKE_DESCRIPTION1)  
            brstat.tlt.model           = trim(wdetail.MODEL_DESCRIPTION)  
            brstat.tlt.cha_no          = trim(wdetail.CHASSIS)  
            brstat.tlt.eng_no          = trim(wdetail.ENGINE)  
            brstat.tlt.lince1          = trim(wdetail.REGISTER_ID)  
            brstat.tlt.lince2          = trim(wdetail.PROVINCE_ID)   
            brstat.tlt.lince3          = trim(wdetail.nYEAR)  
            brstat.tlt.colorcode       = trim(wdetail.nCOLOR)  
            brstat.tlt.vehuse          = trim(wdetail.VMI_VEHICLE_CODE)  
            brstat.tlt.note1           = trim(wdetail.SEAT)   
            brstat.tlt.cc_weight       = deci(trim(wdetail.CC))
            brstat.tlt.note2           = trim(wdetail.WEIGHT)   
            brstat.tlt.nor_coamt       = deci(trim(wdetail.SUMINSURED))
            brstat.tlt.note3           = trim(wdetail.ACCESSORIES)  
            brstat.tlt.note4           = trim(wdetail.ACCESSORIES_DETAIL)     
            brstat.tlt.note5           = trim(wdetail.V_NET_PREMIUM)  
            brstat.tlt.note6           = trim(wdetail.V_STAMP)  
            brstat.tlt.note7           = trim(wdetail.V_VAT)  
            brstat.tlt.note8           = trim(wdetail.V_TOTAL_PREMIUM) 
            brstat.tlt.note9           = trim(wdetail.V_WHT1)  
            brstat.tlt.note10          = trim(wdetail.C_NET_PREMIUM) 
            brstat.tlt.note11          = trim(wdetail.C_STAMP)  
            brstat.tlt.note12          = trim(wdetail.C_VAT)  
            brstat.tlt.note13          = trim(wdetail.C_TOTAL_PREMIUM) 
            brstat.tlt.note14          = trim(wdetail.C_WHT1)  
            brstat.tlt.note15          = trim(wdetail.REMARK)  
            brstat.tlt.note16          = trim(wdetail.PERSON_IN_CHARGE) 
            brstat.tlt.note17          = trim(wdetail.CREATE_PERSON) 
            brstat.tlt.note18          = trim(wdetail.APPLICATION_SIGN_DATE) 
            brstat.tlt.note19          = trim(wdetail.SRT_POLICY_NO) 
            brstat.tlt.note20          = trim(wdetail.PAYMENT)  
            brstat.tlt.note21          = trim(wdetail.TRACKING) 
            brstat.tlt.note22          = trim(wdetail.POST_NO)  
            brstat.tlt.note23          = trim(wdetail.POLICY_VOLUNTARY_NO) 
            brstat.tlt.note24          = trim(wdetail.POLICY_COMPULSURY_NO) 
            brstat.tlt.note25          = trim(wdetail.JOB_STATUS) 
            brstat.tlt.note26          = trim(wdetail.notifyno) 
            brstat.tlt.note27          = trim(wdetail.ENDORSE_TYPE) 
            brstat.tlt.note28          = trim(wdetail.ENDORSE_DETAIL) 
            brstat.tlt.nor_noti_tlt    = trim(wdetail.notifyKL) 
            brstat.tlt.comp_sck        = trim(wdetail.stickerno)  
            brstat.tlt.dealer          = trim(wdetail.DEALER)  
            brstat.tlt.note29          = trim(wdetail.AI_CHECK) 
            brstat.tlt.note30          = trim(wdetail.AI_CHECK_MOBILE)
            brstat.tlt.flag            = IF ra_typefile = 1 THEN "NEW" ELSE "RENEW"
            brstat.tlt.safe3           = trim(wdetail.PACKAGE_NAME)
            .
          

      END.
      ELSE DO:      
           
          nv_completecnt  =  nv_completecnt + 1.
          RUN proc_Create_tlt2.
      END.

      RELEASE brstat.tlt.
    END.
END.
Run proc_Open_tlt.                           
                            
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create_tlt2 C-Win 
PROCEDURE proc_create_tlt2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    ASSIGN                                                 
            brstat.tlt.entdat          = TODAY                             /* วันที่โหลด */                          
            brstat.tlt.enttim          = STRING(TIME,"HH:MM:SS")           /* เวลาโหลด   */                          
            brstat.tlt.trndat          = fi_loaddat                        /* วันที่จากหน้าจอ*/
            brstat.tlt.genusr          = fi_compa                                                   
            brstat.tlt.usrid           = USERID(LDBNAME(1))                /*User Load Data */                      
            brstat.tlt.imp             = "IM"                              /*Import Data*/                          
            brstat.tlt.releas          = "No"                              
            brstat.tlt.safe1           = trim(wdetail.TH_NAME)               
            brstat.tlt.lotno           = trim(wdetail.APPLICATION_ID)      
            brstat.tlt.safe2           = trim(wdetail.ALO_CONTRACT_NUMBER)  
            brstat.tlt.gendat          = comdat          
            brstat.tlt.expodat         = expdat  
            brstat.tlt.ins_name        = trim(wdetail.CUSTOMER_NAME)   
            brstat.tlt.ins_brins       = trim(wdetail.CUS_TYPE)   
            brstat.tlt.ins_icno        = trim(wdetail.CUSTOMER_ID)   
            brstat.tlt.hrg_vill        = trim(wdetail.MOOBARN)     
            brstat.tlt.hrg_room        = trim(wdetail.ROOM_NUMBER)     
            brstat.tlt.hrg_no          = trim(wdetail.HOME_NUMBER)   
            brstat.tlt.hrg_moo         = trim(wdetail.MOO)     
            brstat.tlt.hrg_soi         = trim(wdetail.SOI)   
            brstat.tlt.hrg_street      = trim(wdetail.ROAD)   
            brstat.tlt.hrg_subdistrict = trim(wdetail.TUMBOL)   
            brstat.tlt.hrg_district    = trim(wdetail.AMPHUR)   
            brstat.tlt.hrg_prov        = trim(wdetail.PROVINCE)    
            brstat.tlt.hrg_postcd      = trim(wdetail.POST_CODE)   
            brstat.tlt.ben83           = trim(wdetail.BENEFICIARY)   
            brstat.tlt.dri_name1       = trim(wdetail.DRIVERNAME1)     
            brstat.tlt.dri_no1         = trim(wdetail.D_BIRTH1)   
            brstat.tlt.dri_ic1         = trim(wdetail.D_ID1)   
            brstat.tlt.dri_lic1        = trim(wdetail.D_DRIVE_ID1)   
            brstat.tlt.dri_name2       = trim(wdetail.DRIVERNAME2)   
            brstat.tlt.dri_no2         = trim(wdetail.D_BIRTH2)   
            brstat.tlt.dri_ic2         = trim(wdetail.D_ID2)   
            brstat.tlt.dri_lic2        = trim(wdetail.D_DRIVE_ID2)     
            brstat.tlt.pack            = trim(wdetail.GARAGE_TYPE)   
            brstat.tlt.packnme         = trim(wdetail.TYPE_INSURANCE)   
            brstat.tlt.brand           = trim(wdetail.MAKE_DESCRIPTION1)  
            brstat.tlt.model           = trim(wdetail.MODEL_DESCRIPTION)  
            brstat.tlt.cha_no          = trim(wdetail.CHASSIS)  
            brstat.tlt.eng_no          = trim(wdetail.ENGINE)  
            brstat.tlt.lince1          = trim(wdetail.REGISTER_ID)  
            brstat.tlt.lince2          = trim(wdetail.PROVINCE_ID)   
            brstat.tlt.lince3          = trim(wdetail.nYEAR)  
            brstat.tlt.colorcode       = trim(wdetail.nCOLOR)  
            brstat.tlt.vehuse          = trim(wdetail.VMI_VEHICLE_CODE)  
            brstat.tlt.note1           = trim(wdetail.SEAT)   
            brstat.tlt.cc_weight       = deci(trim(wdetail.CC))
            brstat.tlt.note2           = trim(wdetail.WEIGHT)   
            brstat.tlt.nor_coamt       = deci(trim(wdetail.SUMINSURED))
            brstat.tlt.note3           = trim(wdetail.ACCESSORIES)  
            brstat.tlt.note4           = trim(wdetail.ACCESSORIES_DETAIL)     
            brstat.tlt.note5           = trim(wdetail.V_NET_PREMIUM)  
            brstat.tlt.note6           = trim(wdetail.V_STAMP)  
            brstat.tlt.note7           = trim(wdetail.V_VAT)  
            brstat.tlt.note8           = trim(wdetail.V_TOTAL_PREMIUM) 
            brstat.tlt.note9           = trim(wdetail.V_WHT1)  
            brstat.tlt.note10          = trim(wdetail.C_NET_PREMIUM) 
            brstat.tlt.note11          = trim(wdetail.C_STAMP)  
            brstat.tlt.note12          = trim(wdetail.C_VAT)  
            brstat.tlt.note13          = trim(wdetail.C_TOTAL_PREMIUM) 
            brstat.tlt.note14          = trim(wdetail.C_WHT1)  
            brstat.tlt.note15          = trim(wdetail.REMARK)  
            brstat.tlt.note16          = trim(wdetail.PERSON_IN_CHARGE) 
            brstat.tlt.note17          = trim(wdetail.CREATE_PERSON) 
            brstat.tlt.note18          = trim(wdetail.APPLICATION_SIGN_DATE) 
            brstat.tlt.note19          = trim(wdetail.SRT_POLICY_NO) 
            brstat.tlt.note20          = trim(wdetail.PAYMENT)  
            brstat.tlt.note21          = trim(wdetail.TRACKING) 
            brstat.tlt.note22          = trim(wdetail.POST_NO)  
            brstat.tlt.note23          = trim(wdetail.POLICY_VOLUNTARY_NO) 
            brstat.tlt.note24          = trim(wdetail.POLICY_COMPULSURY_NO) 
            brstat.tlt.note25          = trim(wdetail.JOB_STATUS) 
            brstat.tlt.note26          = trim(wdetail.notifyno) 
            brstat.tlt.note27          = trim(wdetail.ENDORSE_TYPE) 
            brstat.tlt.note28          = trim(wdetail.ENDORSE_DETAIL) 
            brstat.tlt.nor_noti_tlt    = trim(wdetail.notifyKL) 
            brstat.tlt.comp_sck        = trim(wdetail.stickerno)  
            brstat.tlt.dealer          = trim(wdetail.DEALER)  
            brstat.tlt.note29          = trim(wdetail.AI_CHECK) 
            brstat.tlt.note30          = trim(wdetail.AI_CHECK_MOBILE)
            brstat.tlt.flag            = IF ra_typefile = 1 THEN "NEW" ELSE "RENEW"
            brstat.tlt.safe3           = trim(wdetail.PACKAGE_NAME).
     
END.                      

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create_tltnew C-Win 
PROCEDURE proc_create_tltnew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*DEF VAR n AS INT INIT 0.
LOOP_wdetail:
FOR EACH wdetail .
    IF  wdetail.Pro_off    = "" THEN  DELETE wdetail.
    ELSE /*IF wdetail.comdat <> "" AND wdetail.expdat <> "" THEN*/ DO:
    ASSIGN   
            nv_policy    = ""   nv_oldpol    = ""
            nv_comdat    = ?    nv_expdat    = ?  
            nv_comdat72  = ?    nv_expdat72  = ?    nv_accdat  =  ?
            nv_comchr  = ""     nv_addr    = ""     nv_name1   =  ""     
            nv_ntitle  = ""     nv_titleno = 0      nv_policy  =  ""
            nv_dd      = 0      nv_mm      = 0      nv_yy      =  0
            nv_cpamt1  = 0      nv_cpamt2  = 0      nv_cpamt3  =  0
            nv_coamt1  = 0      nv_coamt2  = 0      nv_coamt3  =  0         
            nv_insamt1 = 0      nv_insamt2 = 0      nv_insamt3 =  0
            nv_premt1  = 0      nv_premt2  = 0      nv_premt3  =  0
            nv_newpol  = ""     nv_reccnt  = nv_reccnt + 1
            wdetail.engine = REPLACE(wdetail.engine,"*","").
        IF LENGTH(trim(wdetail.remark)) > 85  THEN RUN proc_cutremak.    /* A56-0399 */
        ELSE ASSIGN nn_remark1  = trim(wdetail.remark)
            nn_remark2  = ""
            nn_remark3 = "".
        
        IF ( wdetail.safe_no = "" ) THEN 
            MESSAGE "พบเลขรับแจ้งเป็นค่าว่าง..." VIEW-AS ALERT-BOX.
        ELSE DO:
            /* ------------------------check policy  Duplicate--------------------------------------*/ 
            IF (wdetail.comdat <>  "" ) THEN ASSIGN nv_comdat  = DATE(wdetail.comdat).
            ELSE ASSIGN nv_comdat = ?.

            IF (wdetail.expdat <>  "" ) THEN ASSIGN nv_expdat  = DATE(wdetail.expdat).
            ELSE ASSIGN nv_expdat  = ?.
        
           IF (wdetail.comdat72 <>  "" ) THEN ASSIGN nv_comdat72  = DATE(wdetail.comdat72). 
            ELSE ASSIGN nv_comdat72 = ?.

            IF (wdetail.expdat72 <>  "" ) THEN ASSIGN nv_expdat72  = DATE(wdetail.expdat72).
            ELSE ASSIGN nv_expdat72 = ?.
        
            /* --------------------------------------------- INS_AMT  CHR(11) ทุนประกันรถยนต์ --- */
            nv_insamt3 = DECIMAL(wdetail.si).   /* by: kridtiya i. A54-0061.. */
            /* -------------------------- PREM1 CHR(11)   เบี้ยภาคสมัครใจบวกภาษีบวกอากร --- */
            nv_premt1 = DECIMAL(SUBSTRING(wdetail.netprem,1,9)).
            IF nv_premt1 < 0 THEN
                nv_premt2 = (DECIMAL(SUBSTRING(wdetail.netprem,10,2)) * -1) / 100.
            ELSE
                nv_premt2 = DECIMAL(SUBSTRING(wdetail.netprem,10,2)) / 100.
            nv_premt3 = nv_premt1 + nv_premt2.
            /* --------------------------------------------- COMP_PEM CHR(09)  เบี้ยพรบ.รวม --- */
            nv_cpamt3 = DECIMAL(wdetail.comp_prm) .  
            /* -------------------------- GROSS_PRM CHR(11)   เบี้ยรวมภาคสมัครใจบวกเบี้ยรวม พรบ. --- */
            nv_coamt1 = DECIMAL(SUBSTRING(wdetail.totalprem,1,9)).
            IF nv_coamt1 < 0 THEN
                nv_coamt2 = (DECIMAL(SUBSTRING(wdetail.totalprem,10,2)) * -1) / 100.
            ELSE
                nv_coamt2 = DECIMAL(SUBSTRING(wdetail.totalprem,10,2)) / 100.
            nv_coamt3 = nv_coamt1 + nv_coamt2.
           /*---------------------------------------------------------------------------------------*/
            RUN proc_address.
            IF TRIM(wdetail.name_insur) <> " " THEN DO:
                ASSIGN n = 0
                       wdetail.name_insur = TRIM(wdetail.name_insur)
                       wdetail.pol_title  = SUBSTR(wdetail.name_insur,1,INDEX(wdetail.name_insur," "))
                       n = LENGTH(wdetail.name_insur) - LENGTH(wdetail.pol_title)                
                       wdetail.pol_fname  = SUBSTR(wdetail.name_insur,INDEX(wdetail.name_insur," "), n + 1 ).
            END.
            FIND LAST brstat.tlt USE-INDEX tlt06  WHERE         /*add A55-0267*/
                brstat.tlt.cha_no       = trim(wdetail.chassis)   AND
                brstat.tlt.eng_no       = TRIM(wdetail.engine)    AND
                brstat.tlt.genusr       = fi_compa                NO-ERROR NO-WAIT .
            IF NOT AVAIL brstat.tlt THEN DO:
               CREATE brstat.tlt.
                    nv_completecnt  =  nv_completecnt + 1.
                    ASSIGN                                                 
                        brstat.tlt.entdat       =   TODAY                              /* วันที่โหลด */                          
                        brstat.tlt.enttim       =   STRING(TIME,"HH:MM:SS")            /* เวลาโหลด   */                          
                        brstat.tlt.trndat       =   fi_loaddat                         /* วันที่ไฟล์แจ้งงาน */                   
                        brstat.tlt.rec_addr3    =   trim(wdetail.Pro_off)              /*เลขที่รับแจ้งและสาขา */           
                        brstat.tlt.exp          =   trim(wdetail.branch)               /*สาขา                 */           
                        brstat.tlt.nor_noti_tlt =   trim(wdetail.safe_no)              /*เลขที่รับแจ้ง        */           
                        brstat.tlt.safe2        =   trim(wdetail.Account_no)           /*เลขที่สัญญา          */           
                        brstat.tlt.rec_name     =   trim(wdetail.pol_title)            /*คำนำหน้าชื่อผู้เอาประกันภัย */          
                        brstat.tlt.ins_name     =   trim(wdetail.pol_fname)            /*ชื่อผู้เอาประกันภัย */           
                        brstat.tlt.ins_addr5    =   "ICNO " + trim(wdetail.icno)       /*IDCARD              */           
                        brstat.tlt.stat         =   IF trim(wdetail.garage) = "1" THEN "ซ่อมอู่" ELSE "ซ่อมห้าง"              /*สถานที่ซ่อม         */           
                        brstat.tlt.comp_usr_tlt =   trim(wdetail.custage)              /*ระบุผู้ขับขี่       */         
                        brstat.tlt.old_eng      =   trim(wdetail.Category)             /*ประเภทรถ            */           
                        brstat.tlt.flag         =   IF rs_type = 1 THEN "N" ELSE "R"   /* ประเภทงาน N = งานใหม่ R = ต่ออายุ */   
                        brstat.tlt.brand        =   trim(wdetail.brand)                /*ยี่ห้อ      */          
                        brstat.tlt.model        =   trim(wdetail.Brand_Model)          /*รุ่น        */          
                        brstat.tlt.cc_weight    =   INTEGER(wdetail.cc)                /*ขนาดเครื่อง */          
                        brstat.tlt.lince2       =   trim(wdetail.yrmanu)               /*ปี          */          
                        brstat.tlt.eng_no       =   trim(wdetail.engine)               /*เลขเครื่อง  */          
                        brstat.tlt.cha_no       =   trim(wdetail.chassis)              /*เลขถัง      */          
                        brstat.tlt.old_cha      =   trim(wdetail.regisdate)            /*วันที่จดทะเบียน */                     
                        brstat.tlt.lince1       =   trim(wdetail.RegisNo)              /*เลขทะเบียน */          
                        brstat.tlt.lince3       =   trim(wdetail.RegisProv)            /*จังหวัด    */          
                        brstat.tlt.safe3        =   "Class72 " + TRIM(wdetail.n_class)  +  /*class72 */
                                                  " Class70 " + TRIM(wdetail.n_class70)   /*class70 */  
                        brstat.tlt.expousr      = "inttyp " + trim(wdetail.instyp) +   /*ประเภทประกัน */          
                                                  " covtyp " +  TRIM(wdetail.covtyp)    /*ความคุ้มครอง */                        
                        brstat.tlt.nor_coamt    =   nv_insamt3                         /*ทุนประกัน   */          
                        brstat.tlt.nor_usr_tlt  =  "FI " + TRIM(wdetail.fi) +     /*ทุนชนหาย */ 
                                                   " wht70 " + TRIM(wdetail.wht) +     /* wht70 */
                                                   " wht72 " + "0"      /* wht72 */
                        brstat.tlt.gendat       =   nv_comdat                          /*วันที่เริ่มคุ้มครอง  */          
                        brstat.tlt.expodat      =   nv_expdat                          /*วันที่สิ้นสุดคุ้มครอง*/          
                        brstat.tlt.nor_grprm    =   DECI(wdetail.netprem)              /*เบี้ยสุทธิ*/              
                        brstat.tlt.comp_coamt   =   DECI(wdetail.totalprem)            /*เบี้ยรวม  */  
                        brstat.tlt.safe1        =   IF trim(wdetail.ben_name) = "ICBCTL" THEN "บริษัท ลีสซิ่งไอซีบีซี (ไทย) จำกัด" + " Delear " + trim(wdetail.dealer) /*ผู้รับผลประโยชน์  */          
                                                    ELSE TRIM(wdetail.ben_name) + " Delear " + trim(wdetail.dealer) /*ดีลเลอร์    */ 
                        brstat.tlt.nor_usr_ins  = trim(wdetail.CMRName)               /*ผู้แจ้ง           */          
                        brstat.tlt.comp_sck     = trim(wdetail.sckno)                 /*เลขที่สติ๊กเกอร์  */          
                        brstat.tlt.comp_effdat  = nv_comdat72                         /*วันทีเริ่มคุ้มครองพรบ */     
                        brstat.tlt.nor_effdat   = nv_expdat72                         /*วันที่สิ้นสุดคุ้มครองพรบ   */ 
                        brstat.tlt.rec_addr4    = "0"                                    /*เบี้ยสุทธิพรบ. */ 
                        brstat.tlt.comp_grprm   = DECI(wdetail.comp_prm)              /*เบี้ยรวมพรบ. */ 
                        brstat.tlt.filler2      = trim(wdetail.remark) + " " + trim(wdetail.Otherins)  /*หมายเหตุ    */        
                        brstat.tlt.ins_addr1    = trim(wdetail.addr1)                    /*ที่อยู่ลูกค้า */          
                        brstat.tlt.ins_addr2    = trim(wdetail.addr2)                                                            
                        brstat.tlt.ins_addr3    = trim(wdetail.addr3)                                                            
                        brstat.tlt.ins_addr4    = trim(wdetail.addr4) +                                                          
                                                " Tel:" + TRIM(wdetail.custtel)                                                 
                        brstat.tlt.genusr       = "ORICO"                                                                       
                        brstat.tlt.usrid        = USERID(LDBNAME(1))                    /*User Load Data */                      
                        brstat.tlt.imp          = "IM"                                  /*Import Data*/                          
                        brstat.tlt.releas       = "No"                                                                           
                        brstat.tlt.recac        = ""                                                                             
                        brstat.tlt.comp_sub     = trim(wdetail.producer)
                        brstat.tlt.comp_noti_ins = "B300303"
                        brstat.tlt.rec_addr1        = IF trim(wdetail.ben_name) = "ICBCTL" THEN "MC28982" ELSE ""   /* vat code */
                        brstat.tlt.rec_addr2    = ""        /* Recepit name */
                        brstat.tlt.rec_addr5    = ""        /* Recepit address */
                        brstat.tlt.dri_name1    = ""                             
                        brstat.tlt.dri_no1      = ""                             
                        brstat.tlt.dri_name2    = ""                            
                        brstat.tlt.dri_no2      = ""
                        brstat.tlt.filler1      = ""
                        brstat.tlt.nor_noti_ins = ""
                        brstat.tlt.comp_pol     = ""
                        brstat.tlt.dat_ins_noti = ?
                        brstat.tlt.lotno        = TRIM(wdetail.campaign). /*A60-0263*/
            END.                      
            ELSE DO:                  
                nv_completecnt  =  nv_completecnt + 1.
                RUN proc_Create_tltnew2.
            END.
        END.
    END.
END.
Run proc_Open_tlt.        */                   
                            
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create_tltnew2 C-Win 
PROCEDURE proc_create_tltnew2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*ASSIGN 
     brstat.tlt.entdat       = TODAY                              /* วันที่โหลด */                          
     brstat.tlt.enttim       = STRING(TIME,"HH:MM:SS")            /* เวลาโหลด   */                          
     brstat.tlt.trndat       = fi_loaddat                         /* วันที่ไฟล์แจ้งงาน */                   
     brstat.tlt.rec_addr3    = trim(wdetail.Pro_off)              /*เลขที่รับแจ้งและสาขา */           
     brstat.tlt.exp          = trim(wdetail.branch)               /*สาขา                 */           
     brstat.tlt.nor_noti_tlt = trim(wdetail.safe_no)              /*เลขที่รับแจ้ง        */           
     brstat.tlt.safe2        = trim(wdetail.Account_no)           /*เลขที่สัญญา          */           
     brstat.tlt.rec_name     = trim(wdetail.pol_title)            /*คำนำหน้าชื่อผู้เอาประกันภัย */          
     brstat.tlt.ins_name     = trim(wdetail.pol_fname)            /*ชื่อผู้เอาประกันภัย */           
     brstat.tlt.ins_addr5    = "ICNO " + trim(wdetail.icno)       /*IDCARD              */           
     brstat.tlt.stat         = IF trim(wdetail.garage) = "1" THEN "ซ่อมอู่" ELSE "ซ่อมห้าง"              /*สถานที่ซ่อม         */           
     brstat.tlt.comp_usr_tlt = trim(wdetail.custage)              /*ระบุผู้ขับขี่       */         
     brstat.tlt.old_eng      = trim(wdetail.Category)             /*ประเภทรถ            */           
     brstat.tlt.flag         = IF rs_type = 1 THEN "N" ELSE "R"   /* ประเภทงาน N = งานใหม่ R = ต่ออายุ */   
     brstat.tlt.brand        = trim(wdetail.brand)                /*ยี่ห้อ      */          
     brstat.tlt.model        = trim(wdetail.Brand_Model)          /*รุ่น        */          
     brstat.tlt.cc_weight    = INTEGER(wdetail.cc)                /*ขนาดเครื่อง */          
     brstat.tlt.lince2       = trim(wdetail.yrmanu)               /*ปี          */          
     brstat.tlt.eng_no       = trim(wdetail.engine)               /*เลขเครื่อง  */          
     brstat.tlt.cha_no       = trim(wdetail.chassis)              /*เลขถัง      */          
     brstat.tlt.old_cha      = trim(wdetail.regisdate)            /*วันที่จดทะเบียน */                     
     brstat.tlt.lince1       = trim(wdetail.RegisNo)              /*เลขทะเบียน */          
     brstat.tlt.lince3       = trim(wdetail.RegisProv)            /*จังหวัด    */          
     brstat.tlt.safe3        = "Class72 " + TRIM(wdetail.n_class)  +  /*class72 */
                               " Class70 " + TRIM(wdetail.n_class70)   /*class70 */  
     brstat.tlt.expousr      = "inttyp " + trim(wdetail.instyp) +   /*ประเภทประกัน */          
                               " covtyp " +  TRIM(wdetail.covtyp)    /*ความคุ้มครอง */                        
     brstat.tlt.nor_coamt    = nv_insamt3                         /*ทุนประกัน   */          
     brstat.tlt.nor_usr_tlt  = "FI " + TRIM(wdetail.fi) +     /*ทุนชนหาย */ 
                               " wht70 " + TRIM(wdetail.wht) +     /* wht70 */ 
                               " wht72 " + "0"      /* wht72 */
     brstat.tlt.gendat       = nv_comdat                          /*วันที่เริ่มคุ้มครอง  */          
     brstat.tlt.expodat      = nv_expdat                          /*วันที่สิ้นสุดคุ้มครอง*/          
     brstat.tlt.nor_grprm    = DECI(wdetail.netprem)              /*เบี้ยสุทธิ*/              
     brstat.tlt.comp_coamt   = DECI(wdetail.totalprem)            /*เบี้ยรวม  */  
     brstat.tlt.safe1        = IF trim(wdetail.ben_name) = "ICBCTL" THEN "บริษัท ลีสซิ่งไอซีบีซี (ไทย) จำกัด" + " Delear " + trim(wdetail.dealer) /*ผู้รับผลประโยชน์  */          
                               ELSE TRIM(wdetail.ben_name) + " Delear " + trim(wdetail.dealer) /*ดีลเลอร์    */ 
     brstat.tlt.nor_usr_ins  = trim(wdetail.CMRName)               /*ผู้แจ้ง           */          
     brstat.tlt.comp_sck     = trim(wdetail.sckno)                 /*เลขที่สติ๊กเกอร์  */          
     brstat.tlt.comp_effdat  = nv_comdat72                         /*วันทีเริ่มคุ้มครองพรบ */     
     brstat.tlt.nor_effdat   = nv_expdat72                         /*วันที่สิ้นสุดคุ้มครองพรบ   */ 
     brstat.tlt.rec_addr4    = "0"                                  /*เบี้ยสุทธิพรบ. */ 
     brstat.tlt.comp_grprm   = DECI(wdetail.comp_prm)              /*เบี้ยรวมพรบ. */ 
     brstat.tlt.filler2      = trim(wdetail.remark) + " " + trim(wdetail.Otherins)           /*หมายเหตุ    */        
     brstat.tlt.ins_addr1    = trim(wdetail.addr1)                    /*ที่อยู่ลูกค้า */          
     brstat.tlt.ins_addr2    = trim(wdetail.addr2)                                                            
     brstat.tlt.ins_addr3    = trim(wdetail.addr3)                                                            
     brstat.tlt.ins_addr4    = trim(wdetail.addr4) +                                                          
                               " Tel:" + TRIM(wdetail.custtel)                                                 
     brstat.tlt.genusr       = "ICBCTL"                                                                       
     brstat.tlt.usrid        = USERID(LDBNAME(1))                    /*User Load Data */                      
     brstat.tlt.imp          = "IM"                                  /*Import Data*/                          
     brstat.tlt.releas       = "No"                                                                           
     brstat.tlt.recac        = ""                                                                             
     brstat.tlt.comp_sub     = trim(wdetail.producer)
     brstat.tlt.comp_noti_ins = "B300303"
     brstat.tlt.rec_addr1    = IF trim(wdetail.ben_name) = "ICBCTL" THEN "MC28982" ELSE ""   /* vat code */
     brstat.tlt.rec_addr2    = ""        /* Recepit name */         
     brstat.tlt.rec_addr5    = ""        /* Recepit address */
     brstat.tlt.dri_name1    = ""                             
     brstat.tlt.dri_no1      = ""                             
     brstat.tlt.dri_name2    = ""                            
     brstat.tlt.dri_no2      = ""
     brstat.tlt.filler1      = "" 
     brstat.tlt.nor_noti_ins = "" 
     brstat.tlt.comp_pol     = "" 
     brstat.tlt.dat_ins_noti = ?
     brstat.tlt.lotno        = TRIM(wdetail.campaign). /*A60-0263*/*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create_tltrenew C-Win 
PROCEDURE proc_create_tltrenew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*DEF VAR n AS INT INIT 0.
LOOP_wdetail:
FOR EACH wdetail .
    IF  wdetail.Pro_off    = "" THEN  DELETE wdetail.
    ELSE  DO:
    ASSIGN   
            nv_policy    = ""   nv_oldpol    = ""
            nv_comdat    = ?    nv_expdat    = ?  
            nv_comdat72  = ?    nv_expdat72  = ?    nv_accdat  =  ?
            nv_comchr  = ""     nv_addr    = ""     nv_name1   =  ""     
            nv_ntitle  = ""     nv_titleno = 0      nv_policy  =  ""
            nv_dd      = 0      nv_mm      = 0      nv_yy      =  0
            nv_cpamt1  = 0      nv_cpamt2  = 0      nv_cpamt3  =  0
            nv_coamt1  = 0      nv_coamt2  = 0      nv_coamt3  =  0         
            nv_insamt1 = 0      nv_insamt2 = 0      nv_insamt3 =  0
            nv_premt1  = 0      nv_premt2  = 0      nv_premt3  =  0
            nv_newpol  = ""     nv_reccnt  = nv_reccnt + 1
            wdetail.engine = REPLACE(wdetail.engine,"*","").
        IF LENGTH(trim(wdetail.remark)) > 85  THEN RUN proc_cutremak.    /* A56-0399 */
        ELSE ASSIGN nn_remark1  = trim(wdetail.remark)
            nn_remark2  = ""
            nn_remark3 = "".
       /* IF ( wdetail.safe_no = "" ) THEN 
            MESSAGE "พบเลขรับแจ้งเป็นค่าว่าง..." VIEW-AS ALERT-BOX.
        ELSE DO:*/
            IF wdetail.prevpol <> "" THEN DO: 
                RUN pol_cutchar.
                nv_oldpol  =  wdetail.prevpol.
            END.
            /* ------------------------check policy  Duplicate--------------------------------------*/
            IF INDEX(wdetail.covtyp,"พรบ") = 0  THEN DO:
                IF (wdetail.comdat <>  "" ) THEN ASSIGN nv_comdat  = DATE(wdetail.comdat).
                ELSE ASSIGN nv_comdat = ?.
                IF (wdetail.expdat <>  "" ) THEN ASSIGN nv_expdat  = DATE(wdetail.expdat).
                ELSE ASSIGN nv_expdat  = ?.
            END.
            ELSE DO:
                ASSIGN wdetail.comdat72      = trim(wdetail.comdat)
                       wdetail.expdat72      = trim(wdetail.expdat)
                       wdetail.comp_prm      = trim(wdetail.netprem)       
                       wdetail.comp_prmtotal = trim(wdetail.totalprem).
                IF (wdetail.comdat72 <>  "" ) THEN ASSIGN nv_comdat72  = DATE(wdetail.comdat72). 
                ELSE ASSIGN nv_comdat72 = ?.
                IF (wdetail.expdat72 <>  "" ) THEN ASSIGN nv_expdat72  = DATE(wdetail.expdat72).
                ELSE ASSIGN nv_expdat72 = ?.
            END.
        
            /* --------------------------------------------- INS_AMT  CHR(11) ทุนประกันรถยนต์ --- */
            nv_insamt3 = DECIMAL(wdetail.si).   /* by: kridtiya i. A54-0061.. */
            /* -------------------------- PREM1 CHR(11)   เบี้ยภาคสมัครใจบวกภาษีบวกอากร --- */
            nv_premt1 = DECIMAL(SUBSTRING(wdetail.netprem,1,9)).
            IF nv_premt1 < 0 THEN
                nv_premt2 = (DECIMAL(SUBSTRING(wdetail.netprem,10,2)) * -1) / 100.
            ELSE
                nv_premt2 = DECIMAL(SUBSTRING(wdetail.netprem,10,2)) / 100.
            nv_premt3 = nv_premt1 + nv_premt2.
            /* --------------------------------------------- COMP_PEM CHR(09)  เบี้ยพรบ.รวม --- */
            nv_cpamt3 = DECIMAL(wdetail.comp_prm) .  
            /* -------------------------- GROSS_PRM CHR(11)   เบี้ยรวมภาคสมัครใจบวกเบี้ยรวม พรบ. --- */
            nv_coamt1 = DECIMAL(SUBSTRING(wdetail.totalprem,1,9)).
            IF nv_coamt1 < 0 THEN
                nv_coamt2 = (DECIMAL(SUBSTRING(wdetail.totalprem,10,2)) * -1) / 100.
            ELSE
                nv_coamt2 = DECIMAL(SUBSTRING(wdetail.totalprem,10,2)) / 100.
            nv_coamt3 = nv_coamt1 + nv_coamt2.
           /*---------------------------------------------------------------------------------------*/
          RUN proc_address.
          IF TRIM(wdetail.name_insur) <> " " THEN DO:
                ASSIGN n = 0
                       wdetail.name_insur = TRIM(wdetail.name_insur)
                       wdetail.pol_title  = SUBSTR(wdetail.name_insur,1,INDEX(wdetail.name_insur," "))
                       n = LENGTH(wdetail.name_insur) - LENGTH(wdetail.pol_title)                
                       wdetail.pol_fname  = SUBSTR(wdetail.name_insur,INDEX(wdetail.name_insur," "), n + 1 ).
            END.
            FIND LAST brstat.tlt USE-INDEX tlt06  WHERE         /*add A55-0267*/
                    brstat.tlt.cha_no       = trim(wdetail.chassis)   AND
                    brstat.tlt.eng_no       = TRIM(wdetail.engine)    AND
                    brstat.tlt.genusr       = fi_compa                NO-ERROR NO-WAIT .
                IF NOT AVAIL brstat.tlt THEN DO:
                   CREATE brstat.tlt.
                   IF wdetail.sck = "" THEN DO:
                        nv_completecnt  =  nv_completecnt + 1.
                        ASSIGN   
                             brstat.tlt.entdat       =   TODAY                              /* วันที่โหลด */                          
                             brstat.tlt.enttim       =   STRING(TIME,"HH:MM:SS")            /* เวลาโหลด   */                          
                             brstat.tlt.trndat       =   fi_loaddat                         /* วันที่ไฟล์แจ้งงาน */                   
                             brstat.tlt.rec_addr3    =   trim(wdetail.Pro_off)              /* ชื่อบริษัท */           
                             brstat.tlt.nor_noti_tlt =   trim(wdetail.safe_no)              /*เลขที่รับแจ้ง        */ 
                             brstat.tlt.filler1      =   nv_oldpol                          /*เลขที่กรมธรรม์เดิม   */
                             brstat.tlt.safe2        =   trim(wdetail.Account_no)           /*เลขที่สัญญา          */           
                             brstat.tlt.rec_name     =   trim(wdetail.pol_title)            /*คำนำหน้าชื่อผู้เอาประกันภัย */          
                             brstat.tlt.ins_name     =   trim(wdetail.pol_fname)            /*ชื่อผู้เอาประกันภัย */           
                             brstat.tlt.ins_addr5    =   "ICNO " + trim(wdetail.icno)                 /*IDCARD            */  
                             brstat.tlt.old_eng      =   trim(wdetail.CarType)               /*ประเภทรถ            */           
                             brstat.tlt.flag         =   IF rs_type = 1 THEN "N" ELSE "R"   /* ประเภทงาน N = งานใหม่ R = ต่ออายุ */   
                             brstat.tlt.brand        =   trim(wdetail.brand)                 /*ยี่ห้อ      */          
                             brstat.tlt.model        =   trim(wdetail.Brand_Model)           /*รุ่น        */          
                             brstat.tlt.cc_weight    =   INTEGER(wdetail.cc)             /*ขนาดเครื่อง */          
                             brstat.tlt.lince2       =   trim(wdetail.yrmanu)                /*ปี          */          
                             brstat.tlt.eng_no       =   trim(wdetail.engine)                /*เลขเครื่อง  */          
                             brstat.tlt.cha_no       =   trim(wdetail.chassis)               /*เลขถัง      */          
                             brstat.tlt.lince1       =   trim(wdetail.RegisNo)               /*เลขทะเบียน */          
                             brstat.tlt.lince3       =   trim(wdetail.RegisProv)             /*จังหวัด    */          
                             brstat.tlt.safe3        =   "Class72 " + TRIM(wdetail.n_class)  +              /*class */ 
                                                         " Class70 " + TRIM(wdetail.n_class70)   /*class70 */ 
                             brstat.tlt.expousr      =   " Covtyp " + TRIM(wdetail.covtyp)    /*ความคุ้มครอง */                     
                             brstat.tlt.nor_coamt    =   nv_insamt3                          /*ทุนประกัน   */          
                             brstat.tlt.nor_usr_tlt  =   "FI " + TRIM(wdetail.fi) +      /*ทุนชนหาย */ 
                                                         " wht70 " + "0" +    /* wht70 */ 
                                                         " wht72 " + "0"      /* wht72 */
                             brstat.tlt.gendat       =   nv_comdat                           /*วันที่เริ่มคุ้มครอง  */          
                             brstat.tlt.expodat      =   nv_expdat                           /*วันที่สิ้นสุดคุ้มครอง*/          
                             brstat.tlt.nor_grprm    =   DECI(wdetail.netprem)               /*เบี้ยสุทธิ*/              
                             brstat.tlt.comp_coamt   =   DECI(wdetail.totalprem)             /*เบี้ยรวม  */          
                             brstat.tlt.safe1        =  IF INDEX(wdetail.ben_name,"ติด8.3") <> 0 THEN "บริษัท ลีสซิ่งไอซีบีซี (ไทย) จำกัด " /*ผู้รับผลประโยชน์  */          
                                                        ELSE TRIM(wdetail.ben_name)
                             brstat.tlt.nor_usr_ins  = trim(wdetail.CMRName)               /*ผู้แจ้ง           */          
                             /*brstat.tlt.comp_sck     = trim(wdetail.sckno)                 /*เลขที่สติ๊กเกอร์  */          
                             brstat.tlt.comp_effdat  = nv_comdat72                         /*วันทีเริ่มคุ้มครองพรบ */     
                             brstat.tlt.nor_effdat   = nv_expdat72                         /*วันที่สิ้นสุดคุ้มครองพรบ   */
                             brstat.tlt.comp_grprm   = DECI(wdetail.comp_prm)              /*เบี้ยสุทธิพรบ */ 
                             brstat.tlt.rec_addr4    = trim(wdetail.comp_prmtotal)         /*เบี้ยรวมพรบ. */  */
                             brstat.tlt.filler2      = trim(wdetail.remark)                /*หมายเหตุ    */          
                             brstat.tlt.ins_addr1    = trim(wdetail.addr1)                    /*ที่อยู่ลูกค้า */          
                             brstat.tlt.ins_addr2    = trim(wdetail.addr2)                                                            
                             brstat.tlt.ins_addr3    = trim(wdetail.addr3)                                                            
                             brstat.tlt.ins_addr4    = trim(wdetail.addr4)                                                           
                             brstat.tlt.genusr       = "ICBCTL"                                                                       
                             brstat.tlt.usrid        = USERID(LDBNAME(1))                    /*User Load Data */                      
                             brstat.tlt.imp          = "IM"                                  /*Import Data*/                          
                             brstat.tlt.releas       = "No"                                                                           
                             brstat.tlt.recac        = ""                                                                             
                             brstat.tlt.comp_sub     = "A0M0097"
                             brstat.tlt.comp_noti_ins = "B300303"
                             brstat.tlt.rec_addr1    = ""   /* vat code */
                             brstat.tlt.rec_addr2    = ""   /* Recepit name */
                             brstat.tlt.rec_addr5    = ""   /* Recepit address */
                             brstat.tlt.dri_name1    = ""                             
                             brstat.tlt.dri_no1      = ""                             
                             brstat.tlt.dri_name2    = ""                            
                             brstat.tlt.dri_no2      = ""
                             brstat.tlt.nor_noti_ins = "" 
                             brstat.tlt.comp_pol     = "" 
                             brstat.tlt.stat         = ""    /*a60-0263*/          /*สถานที่ซ่อม ,inspacetion  */ 
                             brstat.tlt.dat_ins_noti = ?.
                        END.
                        ELSE DO:
                            ASSIGN 
                            brstat.tlt.comp_sck     = trim(wdetail.sckno)                 /*เลขที่สติ๊กเกอร์  */  
                            brstat.tlt.comp_effdat  = nv_comdat72                         /*วันทีเริ่มคุ้มครองพรบ */     
                            brstat.tlt.nor_effdat   = nv_expdat72                         /*วันที่สิ้นสุดคุ้มครองพรบ   */
                            brstat.tlt.comp_grprm   = DECI(wdetail.comp_prmtotal)         /*เบี้ยรวมพรบ. */      
                            brstat.tlt.rec_addr4    = TRIM(wdetail.comp_prm).              /*เบี้ยสุทธิพรบ */      
                        END.
                END.
                ELSE DO: 
                    nv_completecnt  =  nv_completecnt + 1.
                    RUN proc_Create_tltrenew2.
                END.
    END.
END.
Run proc_Open_tlt.  */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create_tltrenew2 C-Win 
PROCEDURE proc_create_tltrenew2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*IF wdetail.sckno = "" THEN DO:
    ASSIGN   
     brstat.tlt.entdat       =   TODAY                              /* วันที่โหลด */                          
     brstat.tlt.enttim       =   STRING(TIME,"HH:MM:SS")            /* เวลาโหลด   */                          
     brstat.tlt.trndat       =   fi_loaddat                         /* วันที่ไฟล์แจ้งงาน */                   
     brstat.tlt.rec_addr3    =   trim(wdetail.Pro_off)              /* ชื่อบริษัท */           
     brstat.tlt.nor_noti_tlt =   trim(wdetail.safe_no)              /*เลขที่รับแจ้ง        */ 
     brstat.tlt.filler1      =   nv_oldpol                          /*เลขที่กรมธรรม์เดิม   */
     brstat.tlt.safe2        =   trim(wdetail.Account_no)           /*เลขที่สัญญา          */           
     brstat.tlt.rec_name     =   trim(wdetail.pol_title)            /*คำนำหน้าชื่อผู้เอาประกันภัย */          
     brstat.tlt.ins_name     =   trim(wdetail.pol_fname)            /*ชื่อผู้เอาประกันภัย */           
     brstat.tlt.ins_addr5    =   "ICNO " + trim(wdetail.icno)                 /*IDCARD            */  
     brstat.tlt.old_eng      =   trim(wdetail.CarType)               /*ประเภทรถ            */           
     brstat.tlt.flag         =   IF rs_type = 1 THEN "N" ELSE "R"   /* ประเภทงาน N = งานใหม่ R = ต่ออายุ */   
     brstat.tlt.brand        =   trim(wdetail.brand)                 /*ยี่ห้อ      */          
     brstat.tlt.model        =   trim(wdetail.Brand_Model)           /*รุ่น        */          
     brstat.tlt.cc_weight    =   INTEGER(wdetail.cc)             /*ขนาดเครื่อง */          
     brstat.tlt.lince2       =   trim(wdetail.yrmanu)                /*ปี          */          
     brstat.tlt.eng_no       =   trim(wdetail.engine)                /*เลขเครื่อง  */          
     brstat.tlt.cha_no       =   trim(wdetail.chassis)               /*เลขถัง      */          
     brstat.tlt.lince1       =   trim(wdetail.RegisNo)               /*เลขทะเบียน */          
     brstat.tlt.lince3       =   trim(wdetail.RegisProv)             /*จังหวัด    */          
     brstat.tlt.safe3        =   "Class72 " + TRIM(wdetail.n_class)  +              /*class */ 
                                 " Class70 " + TRIM(wdetail.n_class70)   /*class70 */ 
     brstat.tlt.expousr      =   " Covtyp " + TRIM(wdetail.covtyp)    /*ความคุ้มครอง */                     
     brstat.tlt.nor_coamt    =   nv_insamt3                          /*ทุนประกัน   */          
     brstat.tlt.nor_usr_tlt  =   "FI " + TRIM(wdetail.fi) +       /*ทุนชนหาย */
                                 " wht70 " + "0" +    /* wht70 */ 
                                 " wht72 " + "0"      /* wht72 */
     brstat.tlt.gendat       =   nv_comdat                           /*วันที่เริ่มคุ้มครอง  */          
     brstat.tlt.expodat      =   nv_expdat                           /*วันที่สิ้นสุดคุ้มครอง*/          
     brstat.tlt.nor_grprm    =   DECI(wdetail.netprem)               /*เบี้ยสุทธิ*/              
     brstat.tlt.comp_coamt   =   DECI(wdetail.totalprem)             /*เบี้ยรวม  */          
     brstat.tlt.safe1        =  IF INDEX(wdetail.ben_name,"ติด8.3") <> 0 THEN "บริษัท ลีสซิ่งไอซีบีซี (ไทย) จำกัด " /*ผู้รับผลประโยชน์  */          
                                ELSE TRIM(wdetail.ben_name)
     brstat.tlt.nor_usr_ins  = trim(wdetail.CMRName)               /*ผู้แจ้ง           */          
     /*brstat.tlt.comp_sck     = trim(wdetail.sckno)                 /*เลขที่สติ๊กเกอร์  */          
     brstat.tlt.comp_effdat  = nv_comdat72                         /*วันทีเริ่มคุ้มครองพรบ */     
     brstat.tlt.nor_effdat   = nv_expdat72                         /*วันที่สิ้นสุดคุ้มครองพรบ   */
     brstat.tlt.comp_grprm   = DECI(wdetail.comp_prm)              /*เบี้ยสุทธิพรบ */ 
     brstat.tlt.rec_addr4    = trim(wdetail.comp_prmtotal)         /*เบี้ยรวมพรบ. */  */
     brstat.tlt.filler2      = trim(wdetail.remark)                /*หมายเหตุ    */          
     brstat.tlt.ins_addr1    = trim(wdetail.addr1)                    /*ที่อยู่ลูกค้า */          
     brstat.tlt.ins_addr2    = trim(wdetail.addr2)                                                            
     brstat.tlt.ins_addr3    = trim(wdetail.addr3)                                                            
     brstat.tlt.ins_addr4    = trim(wdetail.addr4)                                                           
     brstat.tlt.genusr       = "ICBCTL"                                                                       
     brstat.tlt.usrid        = USERID(LDBNAME(1))                    /*User Load Data */                      
     brstat.tlt.imp          = "IM"                                  /*Import Data*/                          
     brstat.tlt.releas       = "No"                                                                           
     brstat.tlt.recac        = ""                                                                             
     brstat.tlt.comp_sub     = "A0M0097"
     brstat.tlt.comp_noti_ins = "B300303"
     brstat.tlt.rec_addr1    = ""   /* vat code */
     brstat.tlt.rec_addr2    = ""   /* Recepit name */
     brstat.tlt.rec_addr5    = ""   /* Recepit address */
     brstat.tlt.dri_name1    = ""                             
     brstat.tlt.dri_no1      = ""                             
     brstat.tlt.dri_name2    = ""                            
     brstat.tlt.dri_no2      = ""
     brstat.tlt.nor_noti_ins = "" 
     brstat.tlt.comp_pol     = "" 
     brstat.tlt.stat         = ""    /*a60-0263*/          /*สถานที่ซ่อม ,inspacetion  */ 
     brstat.tlt.dat_ins_noti = ?.
END.
ELSE DO:
    ASSIGN 
    brstat.tlt.comp_sck     = trim(wdetail.sckno)                 /*เลขที่สติ๊กเกอร์  */  
    brstat.tlt.comp_effdat  = nv_comdat72                         /*วันทีเริ่มคุ้มครองพรบ */     
    brstat.tlt.nor_effdat   = nv_expdat72                         /*วันที่สิ้นสุดคุ้มครองพรบ   */
    brstat.tlt.comp_grprm   = DECI(wdetail.comp_prmtotal)         /*เบี้ยรวมพรบ. */      
    brstat.tlt.rec_addr4    = TRIM(wdetail.comp_prm).              /*เบี้ยสุทธิพรบ */      
END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_Open_tlt C-Win 
PROCEDURE proc_Open_tlt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* 
For each brstat.tlt  Use-index tlt01         where
         brstat.tlt.trndat   =  fi_loaddat   and
         brstat.tlt.genusr   =  fi_compa     NO-LOCK .
    CREATE wtlt.
    ASSIGN 
       wtlt.trndat      =   STRING(tlt.trndat,"99/99/9999")    
       wtlt.Notify_no   =   tlt.nor_noti_tlt
       wtlt.branch      =   tlt.exp     
       wtlt.Account_no  =   tlt.safe2   
       wtlt.prev_pol    =   tlt.filler1 
       wtlt.name_insur  =   tlt.rec_name + " " + tlt.ins_name
       wtlt.comdat      =   IF tlt.gendat       <> ? THEN string(tlt.gendat,"99/99/9999")       ELSE ""    
       wtlt.expdat      =   IF tlt.expodat      <> ? THEN string(tlt.expodat,"99/99/9999")      ELSE ""     
       wtlt.comdat72    =   IF tlt.comp_effdat  <> ? THEN string(tlt.comp_effdat,"99/99/9999")  ELSE ""
       wtlt.expdat72    =   IF tlt.nor_effdat   <> ? THEN string(Tlt.nor_effdat,"99/99/9999")   ELSE ""  
       wtlt.licence     =   tlt.lince1 
       wtlt.province    =   tlt.lince3 
       wtlt.ins_amt     =   string(tlt.nor_coamt) 
       wtlt.prem1       =   string(tlt.nor_grprm) 
       wtlt.comp_prm    =   string(tlt.comp_grprm)
       wtlt.gross_prm   =   STRING(tlt.comp_coamt)
       wtlt.compno      =   tlt.comp_pol  
       wtlt.not_date    =   STRING(tlt.datesent)   
       wtlt.not_office  =   tlt.nor_usr_tlt
       wtlt.not_name    =   tlt.nor_usr_ins
       wtlt.brand       =   tlt.brand      
       wtlt.Brand_Model =   tlt.model      
       wtlt.yrmanu      =   tlt.lince2   
       wtlt.weight      =   STRING(tlt.cc_weight)  
       wtlt.engine      =   tlt.eng_no    
       wtlt.chassis     =   tlt.cha_no 
       wtlt.camp        =   tlt.genusr.
END.*/
OPEN QUERY br_imptxt FOR EACH wdetail NO-LOCK.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

