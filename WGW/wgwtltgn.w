&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          buint            PROGRESS
*/
&Scoped-define WINDOW-NAME wgwtltgn
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS wgwtltgn 
/*************************************************************************
 WTIJQINT.w : RUN Q PREMIUM TO OICINT
 Copyright  : Safety Insurance Public Company Limited
               บริษัท ประกันคุ้มภัย จำกัด (มหาชน)
 ------------------------------------------------------------------------                 
 Database   : OICINT SICUW SICSYAC STAT
 ------------------------------------------------------------------------   
 CREATE BY : Kridtiya i.  ASSIGN: A56-0299     DATE: 02/09/2013            
 CREATE BY : watsana k.   ASSIGN: A56-0299     DATE: 02/09/2013
 modify by : kridtiya i.  A57-0391 เพิ่มการเช็คกรมธรรม์ซ้ำในระบบ 
                          case : จองเบอร์กรมธรรม์ 
 modify by : Kridtiya i. A58-0210 เพิ่ม คลาส 140 เป็น 140A                          
 *************************************************************************/
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
DEFINE INPUT PARAMETER nv_User AS CHARACTER.  
/*DEFINE VAR nv_User AS CHARACTER.   /*test*/*/
 
{wgw\wgwtltgn.i}      /*ประกาศตัวแปร*/
/* Local Variable Definitions ---                                       */

DEFINE NEW SHARED VAR chr_sticker  AS CHAR FORMAT "9999999999999" INIT "".   
DEFINE NEW SHARED VAR nv_modulo    AS INT  FORMAT "9".
DEFINE NEW SHARED VAR nv_polday    AS INTE FORMAT ">>9".
DEFINE BUFFER bufintpolicy FOR intpolicy.
/*DEF NEW SHARED VAR nv_covcod    AS CHAR.*/
def    NEW SHARED VAR nv_message as   char.
def New shared   var  nv_makdes  as   char    .
def New shared   var  nv_moddes  as   char.
DEF New  shared  VAR  nv_prem    AS DECIMAL  FORMAT ">,>>>,>>9.99-"      INITIAL 0 NO-UNDO.
DEF NEW  SHARED  VAR  nv_key_b   AS DECIMAL FORMAT ">>>,>>>,>>>,>>9.99-" INITIAL 0 NO-UNDO.
DEFINE VAR nv_botton      AS INTEGER.
DEFINE VAR nv_policy      AS CHARACTER    FORMAT "x(20)".
DEFINE VAR nv_citizen     AS CHAR         FORMAT "X(13)".
DEFINE VAR nv_License     AS CHAR         FORMAT "X(30)".
DEFINE VAR n_class        AS CHAR FORMAT "X(5)". /* Usawin */
DEFINE VAR nv_vehreg      AS CHARACTER    FORMAT "X(10)" INITIAL "".
DEFINE VAR nv_vehreg2     AS CHARACTER    FORMAT "X(10)" INITIAL "". /* เลขทะเบียนจัดใหม่ */
DEFINE VAR nv_vehreg3     AS CHARACTER    FORMAT "X(10)" INITIAL "". 
DEFINE VAR nv_pvc         AS CHARACTER    FORMAT "X(03)" INITIAL "". /* จว. */
DEFINE VAR nv_licn        AS CHARACTER    FORMAT "X(03)" INITIAL "". /* กท. */
DEFINE VAR nv_veh         AS CHARACTER    FORMAT "X(10)" INITIAL "". /* เลขทะเบียน */
DEFINE VAR nv_l           AS INTEGER .
DEFINE VAR nv_length      AS INTEGER .
DEFINE VAR nv_length2     AS INTEGER .
DEFINE VAR nv_length3     AS INTEGER . 
DEFINE VAR nv_rlength     AS INTEGER .
DEFINE VAR nv_num         AS INTEGER . 
DEFINE VAR nv_riskno      AS INTEGER . 
DEFINE VAR nv_itemno      AS INTEGER . 
/*DEFINE BUFFER buwm301 FOR uwm301.*/
DEFINE VAR nv_Insuredcode AS CHAR      FORMAT "X" .
DEFINE VAR nv_class72     AS CHARACTER FORMAT "X(5)"    INITIAL ""  NO-UNDO.
DEFINE VAR nv_class70     AS CHARACTER FORMAT "X(5)"    INITIAL ""  NO-UNDO.
DEFINE VAR nv_var_amt     AS DECIMAL   FORMAT ">>>>>>9" INITIAL 0   NO-UNDO.
/* DEFINE VAR nv_covcod70    LIKE  uwm301.covcod  INIT "".  */
/* DEFINE VAR nv_vehuse70    LIKE  uwm301.vehuse  INIT "".  */
/*DEFINE VAR nv_garage70    LIKE  uwm301.garage  INIT "".*/
DEFINE VAR nv_unit70      AS CHAR.
DEFINE VAR nv_count       AS INTEGER INITIAL 1.
DEFINE VAR nv_jobq        AS CHARACTER FORMAT "X(10)" INITIAL "" NO-UNDO.
DEFINE VAR nv_prioty      AS INTEGER                  INITIAL 0  NO-UNDO.
DEFINE VAR nv_qdate       AS DATE                                NO-UNDO.
DEFINE VAR nv_qtime       AS CHARACTER                           NO-UNDO.
DEFINE VAR nv_fname       AS CHAR FORMAT "x(50)".
DEFINE VAR nv_sname       AS CHAR FORMAT "x(50)".
DEFINE VAR nv_pindex      AS INTE FORMAT ">>9".
DEFINE VAR nv_flagE       AS CHAR. 
DEFINE VAR nv_Remark      AS CHAR.
DEFINE VAR nv_procode     AS CHAR.
DEFINE VAR nv_error       AS CHAR.
DEFINE VAR nv_flagen      AS CHAR.
DEFINE VAR nv_chassis     AS CHAR FORMAT "X(35)". 
DEFINE VAR nv_name        AS CHAR.
/*--Check Date---*/
DEF VAR nv_todaydate  AS DATE.
DEF VAR nv_befordate  AS DATE.
DEF VAR nv_month      AS INTEGER.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main
&Scoped-define BROWSE-NAME br_intpolicy

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES IntPolicy

/* Definitions for BROWSE br_intpolicy                                  */
&Scoped-define FIELDS-IN-QUERY-br_intpolicy IntPolicy.CompanyCode ~
IntPolicy.ProcessStatus IntPolicy.TrnFromIntDate IntPolicy.TrnFromIntTime ~
IntPolicy.GenPolicy IntPolicy.PolicyNumber IntPolicy.StickerNumber ~
IntPolicy.ContractNumber IntPolicy.EffectiveDt IntPolicy.InsuredTitle ~
IntPolicy.InsuredName IntPolicy.InsuredSurname IntPolicy.ChassisVINNumber ~
IntPolicy.EngineSerialNumber IntPolicy.Model IntPolicy.VehicleTypeCode ~
IntPolicy.WrittenAmt IntPolicy.GenPolicyDt IntPolicy.GenPolicyTime ~
IntPolicy.GenPolicyText 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_intpolicy 
&Scoped-define QUERY-STRING-br_intpolicy FOR EACH IntPolicy NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br_intpolicy OPEN QUERY br_intpolicy FOR EACH IntPolicy NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br_intpolicy IntPolicy
&Scoped-define FIRST-TABLE-IN-QUERY-br_intpolicy IntPolicy


/* Definitions for FRAME fr_main                                        */
&Scoped-define OPEN-BROWSERS-IN-QUERY-fr_main ~
    ~{&OPEN-QUERY-br_intpolicy}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-1 RECT-2 RECT-3 fi_companycode ~
fi_branch fi_producer bu_REFRESH bu_runjob bu_CLOSE fi_Display fi_Display2 ~
br_intpolicy fi_batch 
&Scoped-Define DISPLAYED-OBJECTS fi_companycode fi_branch fi_producer ~
fi_Display fi_Display2 fi_batch 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wgwtltgn AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_CLOSE 
     LABEL "CLOSE" 
     SIZE 11 BY 1.24
     BGCOLOR 27 FONT 6.

DEFINE BUTTON bu_REFRESH 
     LABEL "REFRESH" 
     SIZE 11 BY 1.24
     BGCOLOR 27 FONT 6.

DEFINE BUTTON bu_runjob 
     LABEL "RUN JOB" 
     SIZE 11 BY 1.24
     BGCOLOR 27 FONT 6.

DEFINE VARIABLE fi_batch AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 25 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_branch AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_companycode AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_Display AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 129.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_Display2 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 129.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 133 BY 5.71
     BGCOLOR 28 .

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 132.5 BY 17.86
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 38 BY 2
     BGCOLOR 8 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_intpolicy FOR 
      IntPolicy SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_intpolicy
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_intpolicy wgwtltgn _STRUCTURED
  QUERY br_intpolicy NO-LOCK DISPLAY
      IntPolicy.CompanyCode FORMAT "x(10)":U WIDTH 14.33
      IntPolicy.ProcessStatus COLUMN-LABEL "Status" FORMAT "x(1)":U
            WIDTH 6
      IntPolicy.TrnFromIntDate FORMAT "99/99/9999":U WIDTH 15
      IntPolicy.TrnFromIntTime FORMAT "x(8)":U
      IntPolicy.GenPolicy FORMAT "yes/no":U WIDTH 10
      IntPolicy.PolicyNumber FORMAT "x(15)":U
      IntPolicy.StickerNumber FORMAT "x(15)":U WIDTH 16
      IntPolicy.ContractNumber FORMAT "x(20)":U WIDTH 16
      IntPolicy.EffectiveDt FORMAT "x(10)":U
      IntPolicy.InsuredTitle FORMAT "x(15)":U WIDTH 8
      IntPolicy.InsuredName FORMAT "x(30)":U
      IntPolicy.InsuredSurname FORMAT "x(30)":U
      IntPolicy.ChassisVINNumber COLUMN-LABEL "Chassis" FORMAT "x(25)":U
      IntPolicy.EngineSerialNumber COLUMN-LABEL "Engno" FORMAT "x(25)":U
            WIDTH 20
      IntPolicy.Model FORMAT "x(30)":U WIDTH 25
      IntPolicy.VehicleTypeCode FORMAT "x(10)":U
      IntPolicy.WrittenAmt FORMAT "x(10)":U
      IntPolicy.GenPolicyDt COLUMN-LABEL "GenDate" FORMAT "99/99/9999":U
            WIDTH 10
      IntPolicy.GenPolicyTime COLUMN-LABEL "GenTime" FORMAT "x(8)":U
            WIDTH 10
      IntPolicy.GenPolicyText FORMAT "x(70)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 128.5 BY 14.52
         BGCOLOR 15 FONT 6 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_companycode AT ROW 3.19 COL 20.5 COLON-ALIGNED NO-LABEL
     fi_branch AT ROW 3.19 COL 46.5 COLON-ALIGNED NO-LABEL
     fi_producer AT ROW 3.19 COL 65.33 COLON-ALIGNED NO-LABEL
     bu_REFRESH AT ROW 3.95 COL 89.83
     bu_runjob AT ROW 3.95 COL 101.83
     bu_CLOSE AT ROW 3.95 COL 113.67
     fi_Display AT ROW 7.14 COL 2.5 NO-LABEL
     fi_Display2 AT ROW 8.29 COL 2.5 NO-LABEL
     br_intpolicy AT ROW 9.62 COL 3
     fi_batch AT ROW 4.86 COL 20.5 COLON-ALIGNED NO-LABEL
     "Batch No :" VIEW-AS TEXT
          SIZE 11 BY 1 AT ROW 4.86 COL 10.17
          BGCOLOR 19 FONT 6
     "            JOB QUEUE  : LOCKTON BUINT ( SEND DATA TO GW )" VIEW-AS TEXT
          SIZE 86.5 BY 1.24 AT ROW 1.19 COL 23.33
          BGCOLOR 8 FONT 23
     "Company :" VIEW-AS TEXT
          SIZE 11 BY 1 AT ROW 3.19 COL 10.33
          BGCOLOR 19 FONT 6
     "Branch :" VIEW-AS TEXT
          SIZE 8 BY 1 AT ROW 3.19 COL 39.67
          BGCOLOR 19 FONT 6
     "Producer :" VIEW-AS TEXT
          SIZE 10 BY 1 AT ROW 3.19 COL 56.33
          BGCOLOR 19 FONT 6
     RECT-1 AT ROW 1 COL 1
     RECT-2 AT ROW 6.81 COL 1
     RECT-3 AT ROW 3.57 COL 88.17
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
         BGCOLOR 10 .


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
  CREATE WINDOW wgwtltgn ASSIGN
         HIDDEN             = YES
         TITLE              = "RUN JOB Q IMPORT LOCKTON TO GW"
         HEIGHT             = 22.76
         WIDTH              = 130.33
         MAX-HEIGHT         = 33.62
         MAX-WIDTH          = 170.67
         VIRTUAL-HEIGHT     = 33.62
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
IF NOT wgwtltgn:LOAD-ICON("adeicon/progress.ico":U) THEN
    MESSAGE "Unable to load icon: adeicon/progress.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW wgwtltgn
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fr_main
   FRAME-NAME                                                           */
/* BROWSE-TAB br_intpolicy fi_Display2 fr_main */
/* SETTINGS FOR FILL-IN fi_Display IN FRAME fr_main
   ALIGN-L                                                              */
ASSIGN 
       fi_Display:HIDDEN IN FRAME fr_main           = TRUE.

/* SETTINGS FOR FILL-IN fi_Display2 IN FRAME fr_main
   ALIGN-L                                                              */
ASSIGN 
       fi_Display2:HIDDEN IN FRAME fr_main           = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wgwtltgn)
THEN wgwtltgn:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_intpolicy
/* Query rebuild information for BROWSE br_intpolicy
     _TblList          = "buint.IntPolicy"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   > buint.IntPolicy.CompanyCode
"IntPolicy.CompanyCode" ? ? "character" ? ? ? ? ? ? no ? no no "14.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > buint.IntPolicy.ProcessStatus
"IntPolicy.ProcessStatus" "Status" "x(1)" "character" ? ? ? ? ? ? no ? no no "6" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > buint.IntPolicy.TrnFromIntDate
"IntPolicy.TrnFromIntDate" ? ? "date" ? ? ? ? ? ? no ? no no "15" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   = buint.IntPolicy.TrnFromIntTime
     _FldNameList[5]   > buint.IntPolicy.GenPolicy
"IntPolicy.GenPolicy" ? ? "logical" ? ? ? ? ? ? no ? no no "10" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > buint.IntPolicy.PolicyNumber
"IntPolicy.PolicyNumber" ? "x(15)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > buint.IntPolicy.StickerNumber
"IntPolicy.StickerNumber" ? "x(15)" "character" ? ? ? ? ? ? no ? no no "16" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > buint.IntPolicy.ContractNumber
"IntPolicy.ContractNumber" ? ? "character" ? ? ? ? ? ? no ? no no "16" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > buint.IntPolicy.EffectiveDt
"IntPolicy.EffectiveDt" ? "x(10)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   > buint.IntPolicy.InsuredTitle
"IntPolicy.InsuredTitle" ? ? "character" ? ? ? ? ? ? no ? no no "8" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[11]   > buint.IntPolicy.InsuredName
"IntPolicy.InsuredName" ? "x(30)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[12]   > buint.IntPolicy.InsuredSurname
"IntPolicy.InsuredSurname" ? "x(30)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[13]   > buint.IntPolicy.ChassisVINNumber
"IntPolicy.ChassisVINNumber" "Chassis" "x(25)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[14]   > buint.IntPolicy.EngineSerialNumber
"IntPolicy.EngineSerialNumber" "Engno" "x(25)" "character" ? ? ? ? ? ? no ? no no "20" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[15]   > buint.IntPolicy.Model
"IntPolicy.Model" ? "x(30)" "character" ? ? ? ? ? ? no ? no no "25" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[16]   = buint.IntPolicy.VehicleTypeCode
     _FldNameList[17]   = buint.IntPolicy.WrittenAmt
     _FldNameList[18]   > buint.IntPolicy.GenPolicyDt
"IntPolicy.GenPolicyDt" "GenDate" ? "date" ? ? ? ? ? ? no ? no no "10" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[19]   > buint.IntPolicy.GenPolicyTime
"IntPolicy.GenPolicyTime" "GenTime" ? "character" ? ? ? ? ? ? no ? no no "10" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[20]   > buint.IntPolicy.GenPolicyText
"IntPolicy.GenPolicyText" ? "x(70)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is OPENED
*/  /* BROWSE br_intpolicy */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME wgwtltgn
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wgwtltgn wgwtltgn
ON END-ERROR OF wgwtltgn /* RUN JOB Q IMPORT LOCKTON TO GW */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wgwtltgn wgwtltgn
ON WINDOW-CLOSE OF wgwtltgn /* RUN JOB Q IMPORT LOCKTON TO GW */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_CLOSE
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_CLOSE wgwtltgn
ON CHOOSE OF bu_CLOSE IN FRAME fr_main /* CLOSE */
DO:
    /*
    /*IF CONNECTED ("sicsyac")    THEN DISCONNECT sicsyac.
    IF CONNECTED ("sicuw")      THEN DISCONNECT sicuw.*/
    /*IF CONNECTED ("siccl")      THEN DISCONNECT siccl.
    IF CONNECTED ("gl")         THEN DISCONNECT gl.
    IF CONNECTED ("sicfn")      THEN DISCONNECT sicfn.
    IF CONNECTED ("stat")       THEN DISCONNECT stat.
    IF CONNECTED ("underwrt9")  THEN DISCONNECT underwrt9.*/
    IF CONNECTED ("sic_bran")   THEN DISCONNECT sic_bran. /*---Chutikarn A49-0165 Date 13/10/2006------*/
    IF CONNECTED ("brstat")     THEN DISCONNECT brstat.   /*---Chutikarn A49-0165 Date 13/10/2006------*/
    */
    APPLY "Close" TO THIS-PROCEDURE.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_REFRESH
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_REFRESH wgwtltgn
ON CHOOSE OF bu_REFRESH IN FRAME fr_main /* REFRESH */
DO:
    /* แสดงข้อมูล Request */
    RUN PDREFEST.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_runjob
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_runjob wgwtltgn
ON CHOOSE OF bu_runjob IN FRAME fr_main /* RUN JOB */
DO:
    DISABLE bu_REFRESH bu_runjob WITH FRAM fr_main.   /*A58-0210*/
    ASSIGN 
        nv_batchyr_old =  nv_batchyr
        nv_batcnt_old  =  nv_batcnt 
        nv_batchno_old =  nv_batchno.
    ASSIGN  fi_producer  = INPUT fi_producer
            fi_branch    = INPUT fi_branch 
            nv_befordate = TODAY
            nv_todaydate = TODAY
            nv_batchyr   = YEAR(TODAY) 
            nv_batchno   = "" 
            nv_batcnt    = 0 
            nv_batprev   = "" 
            nv_month     = MONTH(nv_befordate) .

    loop_job:
    REPEAT: 
        FOR EACH wdetail.
            DELETE wdetail. 
        END.
        ASSIGN
            fi_Display  = "" 
            fi_Display2 = "" .
        RUN proc_runbatch.       /* run batch no*/

        FIND FIRST  buint.IntPolicy WHERE
            buint.IntPolicy.CompanyCode      = "LOCKTON"        AND   
            buint.intPolicy.ProcessStatus    = "X"              AND
            buint.intpolicy.GenPolicyDt      = ?                AND
            buint.intpolicy.GenPolicyTime    = ""               AND 
            buint.IntPolicy.GenPolicy        = NO               NO-LOCK  NO-ERROR .    
        IF AVAIL buint.IntPolicy  THEN DO:
            CREATE wdetail.
            ASSIGN 
                wdetail.policy     = caps(trim(buint.IntPolicy.PolicyNumber))  
                wdetail.stk        = trim(buint.IntPolicy.StickerNumber) 
                wdetail.cedpol     = trim(buint.IntPolicy.ContractNumber)
                wdetail.subclass   = trim(buint.IntPolicy.VehicleTypeCode)
                wdetail.vehreg     = trim(buint.IntPolicy.PlateNumber)       
                wdetail.chasno     = trim(buint.IntPolicy.ChassisVINNumber)  
                wdetail.eng        = trim(buint.IntPolicy.EngineSerialNumber)
                wdetail.brand      = TRIM(buint.IntPolicy.Manufacturer) 
                wdetail.model      = IF index(trim(buint.IntPolicy.Model)," ") <> 0 THEN 
                                      trim(SUBSTR(trim(buint.IntPolicy.Model),1,index(trim(buint.IntPolicy.Model)," ") - 1 ))
                                     ELSE trim(buint.IntPolicy.Model) 
                wdetail.caryear    = trim(buint.IntPolicy.ModelYear)     
                wdetail.engcc      = trim(buint.IntPolicy.Displacement) 
                wdetail.seat       = trim(buint.IntPolicy.SeatingCapacity)
                wdetail.icno       = trim(buint.IntPolicy.InsuredUniqueID)
                wdetail.tiname     = trim(buint.IntPolicy.InsuredTitle)  
                wdetail.insnam     = trim(buint.IntPolicy.InsuredName)  + " " + 
                                     trim(buint.IntPolicy.InsuredSurname)
                wdetail.add1       = trim(buint.IntPolicy.Addr)
                wdetail.comdat     = buint.IntPolicy.comdat  
                wdetail.expdat     = IF buint.IntPolicy.expdat = ? THEN  
                                        DATE(string(day(buint.IntPolicy.comdat))    + "/"  +
                                             string(MONTH(buint.IntPolicy.comdat))  + "/"  +
                                             STRING(YEAR(buint.IntPolicy.comdat)    + 1 )) 
                                     ELSE buint.IntPolicy.expdat
                wdetail.branch     = caps(trim(fi_branch))
                wdetail.delerno    = trim(buint.IntPolicy.RemarkText)
                wdetail.delername  = trim(buint.IntPolicy.ShowroomName)              
                wdetail.vehuse     = "1" 
                wdetail.covcod     = "T"
                wdetail.compul     = "y" 
                wdetail.tariff     = "9" 
                wdetail.poltyp     = "V72"  
                fi_display         = caps(trim(buint.IntPolicy.PolicyNumber)) 
                fi_display2        = string(TODAY) + STRING(STRING(TIME,"HH:MM:SS")).

            RUN proc_assign .  
            DISP fi_display fi_display2 WITH FRAME fr_main.
           
            FIND FIRST buint.bufintpolicy WHERE 
                       buint.bufintpolicy.PolicyNumber =  wdetail.policy      NO-ERROR  .
            IF AVAIL bufintpolicy  THEN DO:
                ASSIGN 
                    fi_display         = "wdetail...." +  wdetail.policy 
                    fi_display2        = string(TODAY) + STRING(STRING(TIME,"HH:MM:SS")) 
                    buint.bufintpolicy.GenPolicy      = YES 
                    buint.bufintpolicy.GenPolicyText  = wdetail.comment
                    buint.bufintpolicy.GenPolicyDt    = TODAY
                    buint.bufintpolicy.GenPolicyTime  = STRING(STRING(TIME,"HH:MM:SS"))
                    buint.bufintpolicy.GenStatus      = wdetail.GenStatus.
                DISP fi_display fi_display2 WITH FRAME fr_main.
                
                PAUSE 2 NO-MESSAGE.    
                IF LASTKEY = KEYCODE("F4") THEN LEAVE loop_job.
            END.

            RELEASE buint.bufintpolicy.  
        END.
        ELSE DO:
            HIDE MESSAGE NO-PAUSE.
            BELL.       BELL.      BELL.
            fi_Display  = "Not Found Import Data Lockton to Job queue (BUintpolicy)".
            fi_Display2 = "Please press button" + " F4 " + "TO Exit. " + STRING(TODAY,"99/99/9999")
                           + " " + STRING(TIME,"HH:MM:SS").
            DISP fi_Display fi_Display2 FGCOLOR 6 FONT 6  WITH FRAME fr_main.
            PAUSE 2 NO-MESSAGE.
            /*IF LASTKEY = KEYCODE("F4") THEN LEAVE loop_job.*/   /*A58-0210*/
            IF LASTKEY = KEYCODE("F4") THEN DO:                   /*A58-0210*/
                ENABLE bu_REFRESH bu_runjob WITH FRAM fr_main.    /*A58-0210*/
                LEAVE loop_job.                                   /*A58-0210*/
            END.
            
        END.
       
        RUN PDREFEST.
       
    END.
    CLOSE QUERY br_intpolicy.
    RELEASE buint.intpolicy. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_branch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_branch wgwtltgn
ON LEAVE OF fi_branch IN FRAME fr_main
DO:
  fi_branch = INPUT fi_branch .
  DISP fi_branch WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_companycode
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_companycode wgwtltgn
ON LEAVE OF fi_companycode IN FRAME fr_main
DO:
  fi_companycode = INPUT fi_companycode.
  DISP fi_companycode WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_Display
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_Display wgwtltgn
ON LEAVE OF fi_Display IN FRAME fr_main
DO:
  fi_Display = INPUT fi_Display.

  DISP fi_Display WITH FRAME fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_Display2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_Display2 wgwtltgn
ON LEAVE OF fi_Display2 IN FRAME fr_main
DO:
  fi_Display = INPUT fi_Display.

  DISP fi_Display WITH FRAME fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer wgwtltgn
ON LEAVE OF fi_producer IN FRAME fr_main
DO:
  fi_producer = INPUT fi_producer .
  DISP fi_producer WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_intpolicy
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK wgwtltgn 


/* ***************************  Main Block  *************************** */
/* Set CURRENT-WINDOW: this will parent dialog-boxes and frames.        */
ASSIGN CURRENT-WINDOW                = {&WINDOW-NAME} 
    THIS-PROCEDURE:CURRENT-WINDOW    = {&WINDOW-NAME}.
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
    DEF  VAR  gv_prgid   AS   CHAR  FORMAT "X(8)"   NO-UNDO.
    DEF  VAR  gv_prog    AS   CHAR  FORMAT "X(40)" NO-UNDO.
    ASSIGN 
        gv_prgid        = "WGWTLTGN" 
        gv_prog         = "RUN JOB QUEUE LOCKTON TO GW" 
        fi_companycode  = "LOCKTON"
        fi_branch       = "W"
        fi_producer     = "B3W0019"   
        .
  
  DISP fi_companycode fi_producer  fi_branch    WITH FRAM fr_main.
   
  RUN  WGW\WGWHDLOC (WGWTLTGN:HANDLE,gv_prgid,gv_prog).
/*********************************************************************/  
  RUN  WUT\WUTWICEN (WGWTLTGN:HANDLE).   
  SESSION:DATA-ENTRY-RETURN = YES.
  
  RUN PDREFEST. 

  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI wgwtltgn  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wgwtltgn)
  THEN DELETE WIDGET wgwtltgn.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI wgwtltgn  _DEFAULT-ENABLE
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
  DISPLAY fi_companycode fi_branch fi_producer fi_Display fi_Display2 fi_batch 
      WITH FRAME fr_main IN WINDOW wgwtltgn.
  ENABLE RECT-1 RECT-2 RECT-3 fi_companycode fi_branch fi_producer bu_REFRESH 
         bu_runjob bu_CLOSE fi_Display fi_Display2 br_intpolicy fi_batch 
      WITH FRAME fr_main IN WINDOW wgwtltgn.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW wgwtltgn.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDREFEST wgwtltgn 
PROCEDURE PDREFEST :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* REFRESH OPEN QUERY  br_intpolicy.*/
CLOSE QUERY br_intpolicy.
OPEN QUERY  br_intpolicy
    FOR EACH  buint.IntPolicy NO-LOCK
    WHERE buint.IntPolicy.CompanyCode      = "LOCKTON"        AND   
          buint.intPolicy.ProcessStatus    = "X"              AND
          buint.intpolicy.GenPolicyDt      = ?                AND
          buint.intpolicy.GenPolicyTime    = ""               AND 
          buint.IntPolicy.GenPolicy        = NO 
    BY buint.intpolicy.TrnFromIntDate
    BY buint.IntPolicy.TrnFromIntTime
    BY buint.intpolicy.ReceiveNumber.
 
        

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_72 wgwtltgn 
PROCEDURE proc_72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*IF      wdetail.subclass = "110"  THEN wdetail.seat   = "7".    
ELSE IF wdetail.subclass = "140A" THEN wdetail.seat   = "3".    
ELSE IF wdetail.subclass = "120A" THEN wdetail.seat   = "12".  */ 
/*--------- modcod --------------*/
FIND LAST sicsyac.xmm102 WHERE 
    sicsyac.xmm102.moddes  = trim(wdetail.brand) + " " + trim(wdetail.model)  NO-LOCK NO-ERROR.
IF   AVAIL sicsyac.xmm102  THEN 
    ASSIGN 
    wdetail.redbook = sicsyac.xmm102.modcod  
    wdetail.vehgrp  = sicsyac.xmm102.vehgrp 
    wdetail.body    = sicsyac.xmm102.body .
IF wdetail.redbook = "" THEN DO:
    FIND LAST sicsyac.xmm102 WHERE 
        sicsyac.xmm102.modest  = trim(wdetail.brand)  NO-LOCK NO-ERROR.
    IF   AVAIL sicsyac.xmm102  THEN 
        ASSIGN 
        wdetail.redbook = sicsyac.xmm102.modcod 
        wdetail.vehgrp  =  sicsyac.xmm102.vehgrp  
        wdetail.body    = sicsyac.xmm102.body .
END.
ASSIGN
    nv_docno  = " "
    nv_accdat = TODAY
    nv_docno  = wdetail.docno . 
/*Add by kridtiya i. A57-0391.....*/
IF wdetail.docno <> " " THEN DO:
    FIND FIRST sicuw.uwm100 USE-INDEX uwm10090 WHERE
        sicuw.uwm100.trty11 = "M"                             AND
        sicuw.uwm100.docno1 = STRING(wdetail.docno,"9999999") NO-LOCK NO-ERROR .
    IF (AVAILABLE sicuw.uwm100) AND (sicuw.uwm100.policy <> wdetail.policy) THEN 
        ASSIGN     /*a490166*/  
        nv_docno        = " "
        wdetail.docno   = ""
        wdetail.pass    = "N"  
        wdetail.comment = "Receipt is Dup. on uwm100 :" + string(sicuw.uwm100.policy,"x(16)") +
        STRING(sicuw.uwm100.rencnt,"99")  + "/" +
        STRING(sicuw.uwm100.endcnt,"999") + sicuw.uwm100.renno + uwm100.endno
        wdetail.OK_GEN  = "N".
    ELSE 
        nv_docno = wdetail.docno.
END.
/*Add by kridtiya i. A57-0391.....*/
/***--- Account Date ---***/
IF wdetail.accdat <> " "  THEN nv_accdat = date(wdetail.accdat).
ELSE nv_accdat = TODAY.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_722 wgwtltgn 
PROCEDURE proc_722 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND sic_bran.uwm130 USE-INDEX uwm13001 WHERE
    sic_bran.uwm130.policy = sic_bran.uwm100.policy AND
    sic_bran.uwm130.rencnt = sic_bran.uwm100.rencnt AND
    sic_bran.uwm130.endcnt = sic_bran.uwm100.endcnt AND
    sic_bran.uwm130.riskgp = s_riskgp               AND   /*0*/
    sic_bran.uwm130.riskno = s_riskno               AND   /*1*/
    sic_bran.uwm130.itemno = s_itemno               AND   /*1*/
    sic_bran.uwm130.bchyr  = nv_batchyr             AND   
    sic_bran.uwm130.bchno  = nv_batchno             AND   
    sic_bran.uwm130.bchcnt = nv_batcnt              NO-WAIT NO-ERROR.
IF NOT AVAILABLE sic_bran.uwm130 THEN 
    DO TRANSACTION:
    CREATE sic_bran.uwm130.
    ASSIGN
        sic_bran.uwm130.policy   = sic_bran.uwm120.policy
        sic_bran.uwm130.rencnt   = sic_bran.uwm120.rencnt   
        sic_bran.uwm130.endcnt   = sic_bran.uwm120.endcnt
        sic_bran.uwm130.riskgp   = sic_bran.uwm120.riskgp   
        sic_bran.uwm130.riskno   = sic_bran.uwm120.riskno
        sic_bran.uwm130.itemno   = s_itemno 
        sic_bran.uwm130.bchyr    = nv_batchyr                         /* batch Year */
        sic_bran.uwm130.bchno    = nv_batchno                         /* bchno      */
        sic_bran.uwm130.bchcnt   = nv_batcnt                          /* bchcnt     */
        sic_bran.uwm130.uom6_v   = 0                                  
        sic_bran.uwm130.uom7_v   = 0                                  
        sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0   /*Item Upper text*/
        sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0   /*Item Lower Text*/
        sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0   /*Cover & Premium*/
        sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0   /*Item Endt. Text*/
        sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0.  /*Item Endt. Clause*/
    FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE  
        sicsyac.xmm016.class =   sic_bran.uwm120.CLASS   NO-LOCK NO-ERROR.
    IF AVAIL sicsyac.xmm016 THEN 
        ASSIGN  
            sic_bran.uwm130.uom8_c = sicsyac.xmm016.uom8
            sic_bran.uwm130.uom9_c = sicsyac.xmm016.uom9 
            nv_comper     = deci(sicsyac.xmm016.si_d_t[8]) 
            nv_comacc     = deci(sicsyac.xmm016.si_d_t[9])                                           
            sic_bran.uwm130.uom8_v   = nv_comper   
            sic_bran.uwm130.uom9_v   = nv_comacc  .   
    ASSIGN
        nv_riskno = 1
        nv_itemno = 1.
    END.    /*transaction*/
    s_recid3  = RECID(sic_bran.uwm130).
    /* ---------------------------------------------  U W M 3 0 1 --------------*/ 
    /*nv_covcod =   wdetail.covcod.*/
    ASSIGN 
        nv_makdes  =  wdetail.brand 
        nv_moddes  =  wdetail.model 
        nv_newsck = " " .
    IF (wdetail.vehreg  = "ป้ายแดง") AND (wdetail.chasno <> "")  THEN 
        wdetail.vehreg = "/" + SUBSTR(wdetail.chasno,LENGTH(wdetail.chasno) - 8).

    
    FIND sic_bran.uwm301 USE-INDEX uwm30101      WHERE
        sic_bran.uwm301.policy = sic_bran.uwm100.policy  AND
        sic_bran.uwm301.rencnt = sic_bran.uwm100.rencnt  AND
        sic_bran.uwm301.endcnt = sic_bran.uwm100.endcnt  AND
        sic_bran.uwm301.riskgp = s_riskgp                AND
        sic_bran.uwm301.riskno = s_riskno                AND
        sic_bran.uwm301.itemno = s_itemno                AND
        sic_bran.uwm301.bchyr  = nv_batchyr              AND 
        sic_bran.uwm301.bchno  = nv_batchno              AND 
        sic_bran.uwm301.bchcnt = nv_batcnt       NO-WAIT NO-ERROR.
    IF NOT AVAILABLE sic_bran.uwm301 THEN DO:
        DO TRANSACTION:
            CREATE sic_bran.uwm301.
        END. /*transaction*/
    END. 
    Assign            /*a490166 ใช้ร่วมกัน*/
        sic_bran.uwm301.policy   = sic_bran.uwm120.policy                   
        sic_bran.uwm301.rencnt   = sic_bran.uwm120.rencnt
        sic_bran.uwm301.endcnt   = sic_bran.uwm120.endcnt
        sic_bran.uwm301.riskgp   = sic_bran.uwm120.riskgp
        sic_bran.uwm301.riskno   = sic_bran.uwm120.riskno
        sic_bran.uwm301.itemno   = s_itemno
        sic_bran.uwm301.tariff   = wdetail.tariff
        sic_bran.uwm301.covcod   = "T"
        sic_bran.uwm301.cha_no   = wdetail.chasno
        sic_bran.uwm301.trareg   = nv_uwm301trareg
        sic_bran.uwm301.eng_no   = wdetail.eng
        sic_bran.uwm301.Tons     = INTEGER(wdetail.tons)
        sic_bran.uwm301.engine   = INTEGER(wdetail.engcc) 
        sic_bran.uwm301.yrmanu   = INTEGER(wdetail.caryear)
        sic_bran.uwm301.garage   = wdetail.garage
        sic_bran.uwm301.body     = trim(wdetail.body)
        sic_bran.uwm301.seats    = INTEGER(wdetail.seat)
        sic_bran.uwm301.vehgrp   = wdetail.vehgrp 
        sic_bran.uwm301.mv_ben83 = wdetail.benname
        sic_bran.uwm301.vehreg   = trim(wdetail.vehreg) 
        sic_bran.uwm301.yrmanu   = inte(wdetail.caryear)
        sic_bran.uwm301.vehuse   = wdetail.vehuse
        sic_bran.uwm301.moddes   = trim(wdetail.brand) + " " + trim(wdetail.model) 
        sic_bran.uwm301.modcod   = trim(wdetail.redbook) 
        sic_bran.uwm301.sckno    = 0              
        sic_bran.uwm301.itmdel   = NO
        sic_bran.uwm301.bchyr    = nv_batchyr        /* batch Year */      
        sic_bran.uwm301.bchno    = nv_batchno        /* bchno      */      
        sic_bran.uwm301.bchcnt   = nv_batcnt     .   /* bchcnt     */  
    /*-----compul-----*/
    sic_bran.uwm301.cert = "".
    IF LENGTH(wdetail.stk) = 11 THEN DO:    
        sic_bran.uwm301.drinam[9] = "STKNO:" + STRING(wdetail.stk,"99999999999"). 
    END.
    IF LENGTH(wdetail.stk) = 13  THEN DO:
        sic_bran.uwm301.drinam[9] = "STKNO:" + STRING(wdetail.stk,"9999999999999").
    END.
    IF wdetail.stk = ""  THEN DO:
        sic_bran.uwm301.drinam[9] = "".
    END.
    /*--create detaitem--*/
    FIND FIRST brStat.Detaitem USE-INDEX detaitem11    WHERE
        brStat.Detaitem.serailno   = wdetail.stk         AND 
         brstat.detaitem.yearReg   = nv_batchyr          AND 
        brstat.detaitem.seqno      = STRING(nv_batchno)  AND
        brstat.detaitem.seqno2     = STRING(nv_batcnt)   NO-ERROR NO-WAIT.
    IF NOT AVAIL brstat.Detaitem THEN DO:   
        CREATE brstat.Detaitem.
        /*--STR Amparat C. A51-0253---*/
        ASSIGN                                                            
            brstat.detaitem.policy   = sic_bran.uwm301.policy                 
            brstat.Detaitem.rencnt   = sic_bran.uwm301.rencnt                 
            brstat.Detaitem.endcnt   = sic_bran.uwm301.endcnt                 
            brstat.Detaitem.riskno   = sic_bran.uwm301.riskno                 
            brstat.Detaitem.itemno   = sic_bran.uwm301.itemno                 
            brstat.detaitem.serailno = wdetail.stk
            brstat.detaitem.yearReg  = sic_bran.uwm301.bchyr
            brstat.detaitem.seqno    = STRING(sic_bran.uwm301.bchno)     
            brstat.detaitem.seqno2   = STRING(sic_bran.uwm301.bchcnt).  
    END. 
    s_recid4  = RECID(sic_bran.uwm301).
    /*IF wdetail.redbook <> "" THEN DO:   /*กรณีที่มีการระบุ Code รถมา*/
        FIND sicsyac.xmm102 USE-INDEX xmm10201 WHERE
            sicsyac.xmm102.modcod = wdetail.redbook NO-LOCK NO-ERROR.
        IF AVAIL sicsyac.xmm102 THEN DO:
            ASSIGN
                sic_bran.uwm301.modcod         = sicsyac.xmm102.modcod
                sic_bran.uwm301.Tons           = sicsyac.xmm102.tons
                sic_bran.uwm301.body           = sicsyac.xmm102.body    /*A54-0126*/
                sic_bran.uwm301.vehgrp         = sicsyac.xmm102.vehgrp
                wdetail.redbook                = sicsyac.xmm102.modcod
                wdetail.brand                  = SUBSTRING(xmm102.modest, 1,18)  .  /*Thai*/
        END.
    END.
    ELSE DO:
        /*ASSIGN
        nv_simat = DECI(wdetail.si) - (DECI(wdetail.si) * 20 / 100 )
        nv_simat1 = DECI(wdetail.si) + (DECI(wdetail.si) * 20 / 100 )  .*/
        FIND LAST sicsyac.xmm102 WHERE 
            INDEX(sicsyac.xmm102.modest,wdetail.brand) <> 0 AND
            INDEX(sicsyac.xmm102.modest,wdetail.model) <> 0 AND
            sicsyac.xmm102.seats  >= INTE(wdetail.seat)  NO-LOCK NO-ERROR.
        IF AVAIL sicsyac.xmm102  THEN DO:
            ASSIGN
                sic_bran.uwm301.modcod   = sicsyac.xmm102.modcod
                sic_bran.uwm301.Tons     = sicsyac.xmm102.tons
                sic_bran.uwm301.body     = sicsyac.xmm102.body
                sic_bran.uwm301.vehgrp   = sicsyac.xmm102.vehgrp
                wdetail.tons             =  sicsyac.xmm102.tons   
                wdetail.engcc            = string(sicsyac.xmm102.engine) 
                wdetail.redbook          = sicsyac.xmm102.modcod
                wdetail.brand            = SUBSTRING(xmm102.modest, 1,18)  .  
        END. 
    END.*/
    FIND sic_bran.uwd132  USE-INDEX uwd13201 WHERE
         sic_bran.uwd132.policy = wdetail.policy   AND
         sic_bran.uwd132.rencnt = 0                AND
         sic_bran.uwd132.endcnt = 0                AND
         sic_bran.uwd132.riskgp = 0                AND
         sic_bran.uwd132.riskno = 1                AND
         sic_bran.uwd132.itemno = 1                AND
         sic_bran.uwd132.bchyr  = nv_batchyr       AND
         sic_bran.uwd132.bchno  = nv_batchno       AND
         sic_bran.uwd132.bchcnt = nv_batcnt        NO-ERROR NO-WAIT.
    IF NOT AVAILABLE sic_bran.uwd132 THEN DO:
      IF LOCKED sic_bran.uwd132 THEN DO:
        MESSAGE "พบกำลังใช้งาน Insured (UWD132)" wdetail.policy
                "ไม่สามารถ Generage ข้อมูลได้".
        NEXT.
      END.
      CREATE sic_bran.uwd132.
    END.
    ASSIGN
      sic_bran.uwd132.bencod  = "COMP"                   /*Benefit Code*/
      sic_bran.uwd132.benvar  = ""                       /*Benefit Variable*/
      sic_bran.uwd132.rate    = 0                        /*Premium Rate %*/
      sic_bran.uwd132.gap_ae  = NO                       /*GAP A/E Code*/
      sic_bran.uwd132.gap_c   = 0    /*deci(wdetail.premt)  kridtiya i.*/      /*GAP, per Benefit per Item*/
      sic_bran.uwd132.dl1_c   = 0                        /*Disc./Load 1,p. Benefit p.Item*/
      sic_bran.uwd132.dl2_c   = 0                        /*Disc./Load 2,p. Benefit p.Item*/
      sic_bran.uwd132.dl3_c   = 0                        /*Disc./Load 3,p. Benefit p.Item*/
      sic_bran.uwd132.pd_aep  = "E"                      /*Premium Due A/E/P Code*/
      sic_bran.uwd132.prem_c  = 0              /*kridtiya i. deci(wdetail.premt) */     /*PD, per Benefit per Item*/
      sic_bran.uwd132.fptr    = 0                        /*Forward Pointer*/
      sic_bran.uwd132.bptr    = 0                        /*Backward Pointer*/
      sic_bran.uwd132.policy  = caps(trim(wdetail.policy))         /*Policy No. - uwm130*/
      sic_bran.uwd132.rencnt  = 0                        /*Renewal Count - uwm130*/
      sic_bran.uwd132.endcnt  = 0                        /*Endorsement Count - uwm130*/
      sic_bran.uwd132.riskgp  = 0                        /*Risk Group - uwm130*/
      sic_bran.uwd132.riskno  = 1                        /*Risk No. - uwm130*/
      sic_bran.uwd132.itemno  = 1                        /*Insured Item No. - uwm130*/
      sic_bran.uwd132.rateae  = NO                       /*Premium Rate % A/E Code*/
      sic_bran.uwm130.fptr03  = RECID(sic_bran.uwd132)   /*First uwd132 Cover & Premium*/
      sic_bran.uwm130.bptr03  = RECID(sic_bran.uwd132)   /*Last  uwd132 Cover & Premium*/
      sic_bran.uwd132.bchyr   = nv_batchyr  
      sic_bran.uwd132.bchno   = nv_batchno  
      sic_bran.uwd132.bchcnt  = nv_batcnt     .
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_723 wgwtltgn 
PROCEDURE proc_723 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT        PARAMETER  s_recid1   AS   RECID     NO-UNDO.
DEFINE INPUT        PARAMETER  s_recid2   AS   RECID     NO-UNDO.
DEFINE INPUT        PARAMETER  s_recid3   AS   RECID     NO-UNDO.
DEFINE INPUT        PARAMETER  s_recid4   AS   RECID     NO-UNDO.
DEFINE INPUT-OUTPUT PARAMETER  nv_message AS   CHARACTER NO-UNDO.
ASSIGN 
    nv_rec100  = s_recid1
    nv_rec120  = s_recid2 
    nv_rec130  = s_recid3 
    nv_rec301  = s_recid4 
    nv_message = "" 
    nv_gap     = 0 
    nv_prem    = 0 .
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = nv_rec100 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = nv_rec120 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = nv_rec130 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = nv_rec301 NO-WAIT NO-ERROR.
IF sic_bran.uwm130.fptr03 = 0 OR sic_bran.uwm130.fptr03 = ? THEN DO:
    FIND sicsyac.xmm107 USE-INDEX xmm10701   WHERE
        sicsyac.xmm107.class  = wdetail.subclass  AND
        sicsyac.xmm107.tariff = wdetail.tariff    NO-LOCK NO-ERROR NO-WAIT.
    IF AVAILABLE sicsyac.xmm107 THEN DO:
        FIND sicsyac.xmd107  WHERE RECID(sicsyac.xmd107) = sicsyac.xmm107.fptr  NO-LOCK NO-ERROR NO-WAIT.
        IF AVAILABLE sicsyac.xmd107 THEN DO:
            CREATE sic_bran.uwd132.
            FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE
                sicsyac.xmm016.class = wdetail.subclass  NO-LOCK NO-ERROR NO-WAIT.
            IF  AVAIL sicsyac.xmm016 THEN 
                ASSIGN sic_bran.uwd132.gap_ae = NO
                sic_bran.uwd132.pd_aep = "E".
            ASSIGN sic_bran.uwd132.bencod = sicsyac.xmd107.bencod   sic_bran.uwd132.policy = wdetail.policy
                sic_bran.uwd132.rencnt = sic_bran.uwm130.rencnt     sic_bran.uwd132.endcnt = sic_bran.uwm130.endcnt
                sic_bran.uwd132.riskgp = sic_bran.uwm130.riskgp     sic_bran.uwd132.riskno = sic_bran.uwm130.riskno
                sic_bran.uwd132.itemno = sic_bran.uwm130.itemno
                sic_bran.uwd132.bptr   = 0
                sic_bran.uwd132.fptr   = 0          
                nvffptr     = xmd107.fptr
                s_130bp1    = RECID(sic_bran.uwd132)
                s_130fp1    = RECID(sic_bran.uwd132)
                n_rd132     = RECID(sic_bran.uwd132) 
                sic_bran.uwd132.bchyr   = nv_batchyr       /* batch Year */      
                sic_bran.uwd132.bchno   = nv_batchno       /* bchno      */      
                sic_bran.uwd132.bchcnt  = nv_batcnt .      /* bchcnt     */  
            FIND sicsyac.xmm105 USE-INDEX xmm10501       WHERE
                sicsyac.xmm105.tariff = wdetail.tariff    AND
                sicsyac.xmm105.bencod = sicsyac.xmd107.bencod NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicsyac.xmm105 THEN sic_bran.uwd132.benvar = sicsyac.xmm105.vardef.
            ELSE MESSAGE "ไม่พบ Tariff  " wdetail.tariff   VIEW-AS ALERT-BOX.
            IF wdetail.tariff = "Z" OR wdetail.tariff = "X" THEN DO:  /* Malaysia */
                IF           wdetail.subclass      = "110" THEN nv_key_a = inte(wdetail.engcc).
                ELSE IF SUBSTRING(wdetail.subclass,1,3) = "120" THEN nv_key_a = inte(wdetail.seat).
                ELSE IF SUBSTRING(wdetail.subclass,1,3) = "130" THEN nv_key_a = inte(wdetail.engcc).
                ELSE IF SUBSTRING(wdetail.subclass,1,3) = "140" THEN nv_key_a = inte(wdetail.tons).
                nv_key_b = (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat) + 1.
                FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601  WHERE
                    sicsyac.xmm106.tariff  = wdetail.tariff   AND
                    sicsyac.xmm106.bencod  = uwd132.bencod    AND
                    sicsyac.xmm106.class   = wdetail.subclass AND
                    sicsyac.xmm106.covcod  = wdetail.covcod   AND
                    sicsyac.xmm106.key_a  >= nv_key_a         AND
                    sicsyac.xmm106.key_b  >= nv_key_b         AND
                    sicsyac.xmm106.effdat <= uwm100.comdat    NO-LOCK NO-ERROR NO-WAIT.
                IF AVAILABLE sicsyac.xmm106 THEN 
                    ASSIGN sic_bran.uwd132.gap_c  = sicsyac.xmm106.baseap
                    sic_bran.uwd132.prem_c = sicsyac.xmm106.baseap
                    nv_gap                 = nv_gap  + sic_bran.uwd132.gap_c
                    nv_prem                = nv_prem + sic_bran.uwd132.prem_c.
                ELSE  nv_message = "NOTFOUND".
            END.
            ELSE DO:
                FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601  WHERE
                    sicsyac.xmm106.tariff  = wdetail.tariff   AND
                    sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod   AND
                    sicsyac.xmm106.class   = wdetail.subclass AND
                    sicsyac.xmm106.covcod  = wdetail.covcod   AND
                    sicsyac.xmm106.key_a  >= 0                AND
                    sicsyac.xmm106.key_b  >= 0                AND
                    sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat
                    NO-LOCK NO-ERROR NO-WAIT.
                FIND LAST  sicsyac.xmm106 USE-INDEX xmm10601  WHERE
                    sicsyac.xmm106.tariff  = wdetail.tariff   AND
                    sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod   AND
                    sicsyac.xmm106.class   = wdetail.subclass AND
                    sicsyac.xmm106.covcod  = wdetail.covcod   AND
                    sicsyac.xmm106.key_a   = 0                AND
                    sicsyac.xmm106.key_b   = 0                AND
                    sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat
                    NO-LOCK NO-ERROR NO-WAIT.
                IF AVAILABLE sicsyac.xmm106 THEN DO:
                    sic_bran.uwd132.gap_c     = sicsyac.xmm106.baseap.
                    RUN proc_wgw72013   (INPUT RECID(sic_bran.uwm100), 
                                        RECID(sic_bran.uwd132),
                                        sic_bran.uwm301.tariff).
                    nv_gap        = nv_gap  + sic_bran.uwd132.gap_c.
                    nv_prem       = nv_prem + sic_bran.uwd132.prem_c.
                END.
            END.
            loop_def:
            REPEAT:
                IF nvffptr EQ 0 THEN LEAVE loop_def.
                FIND sicsyac.xmd107 WHERE RECID(sicsyac.xmd107) EQ nvffptr
                    NO-LOCK NO-ERROR NO-WAIT.
                nvffptr   = sicsyac.xmd107.fptr.
                CREATE sic_bran.uwd132.
                ASSIGN sic_bran.uwd132.bencod = sicsyac.xmd107.bencod    sic_bran.uwd132.policy = wdetail.policy
                    sic_bran.uwd132.rencnt = sic_bran.uwm130.rencnt   sic_bran.uwd132.endcnt = sic_bran.uwm130.endcnt
                    sic_bran.uwd132.riskgp = sic_bran.uwm130.riskgp   sic_bran.uwd132.riskno = sic_bran.uwm130.riskno
                    sic_bran.uwd132.itemno = sic_bran.uwm130.itemno
                    sic_bran.uwd132.fptr   = 0
                    sic_bran.uwd132.bptr   = n_rd132
                    sic_bran.uwd132.bchyr  = nv_batchyr   /* batch Year */      
                    sic_bran.uwd132.bchno  = nv_batchno   /* bchno      */      
                    sic_bran.uwd132.bchcnt = nv_batcnt    /* bchcnt     */       
                    n_rd132                = RECID(sic_bran.uwd132).
                FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE
                    sicsyac.xmm016.class = wdetail.subclass
                    NO-LOCK NO-ERROR.
                IF AVAIL sicsyac.xmm016 THEN 
                    ASSIGN sic_bran.uwd132.gap_ae = NO
                    sic_bran.uwd132.pd_aep = "E".
                FIND sicsyac.xmm105 USE-INDEX xmm10501      WHERE
                    sicsyac.xmm105.tariff = wdetail.tariff  AND
                    sicsyac.xmm105.bencod = sicsyac.xmd107.bencod
                    NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL sicsyac.xmm105 THEN sic_bran.uwd132.benvar = sicsyac.xmm105.vardef.
                ELSE   MESSAGE "ไม่พบ Tariff นี้ในระบบ กรุณาใส่ Tariff ใหม่" 
                    "Tariff" wdetail.tariff "Bencod"  xmd107.bencod VIEW-AS ALERT-BOX.
                IF wdetail.tariff = "Z" OR wdetail.tariff = "X" THEN DO:
                    IF           wdetail.subclass      = "110" THEN nv_key_a = inte(wdetail.engcc).
                    ELSE IF SUBSTRING(wdetail.subclass,1,3) = "120" THEN nv_key_a = inte(wdetail.seat).
                    ELSE IF SUBSTRING(wdetail.subclass,1,3) = "130" THEN nv_key_a = inte(wdetail.engcc).
                    ELSE IF SUBSTRING(wdetail.subclass,1,3) = "140" THEN nv_key_a = inte(wdetail.tons).
                    nv_key_b = (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat) + 1.
                    FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601        WHERE
                        sicsyac.xmm106.tariff  = wdetail.tariff   AND
                        sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod   AND
                        sicsyac.xmm106.class   = wdetail.subclass    AND
                        sicsyac.xmm106.covcod  = wdetail.covcod   AND
                        sicsyac.xmm106.key_a  >= nv_key_a        AND
                        sicsyac.xmm106.key_b  >= nv_key_b        AND
                        sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat
                        NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAILABLE sicsyac.xmm106 THEN 
                        ASSIGN
                            sic_bran.uwd132.gap_c  = sicsyac.xmm106.baseap
                            sic_bran.uwd132.prem_c = sicsyac.xmm106.baseap
                            nv_gap                 = nv_gap  + sic_bran.uwd132.gap_c
                            nv_prem                = nv_prem + sic_bran.uwd132.prem_c.
                END.
                ELSE DO:
                    FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601                 WHERE
                        sicsyac.xmm106.tariff  = wdetail.tariff           AND
                        sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod   AND
                        sicsyac.xmm106.class   = wdetail.subclass         AND
                        sicsyac.xmm106.covcod  = wdetail.covcod           AND
                        sicsyac.xmm106.key_a  >= 0                        AND
                        sicsyac.xmm106.key_b  >= 0                        AND
                        sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat
                        NO-LOCK NO-ERROR NO-WAIT.
                    FIND LAST  sicsyac.xmm106 USE-INDEX xmm10601                  WHERE
                        sicsyac.xmm106.tariff  = wdetail.tariff            AND
                        sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod    AND
                        sicsyac.xmm106.class   = wdetail.subclass          AND
                        sicsyac.xmm106.covcod  = wdetail.covcod            AND
                        sicsyac.xmm106.key_a   = 0                         AND
                        sicsyac.xmm106.key_b   = 0                         AND
                        sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat
                        NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAILABLE xmm106 THEN DO:
                        sic_bran.uwd132.gap_c     = sicsyac.xmm106.baseap.
                        RUN proc_wgw72013   (INPUT RECID(sic_bran.uwm100), 
                                            RECID(sic_bran.uwd132),
                                            sic_bran.uwm301.tariff).
                        nv_gap        = nv_gap  + sic_bran.uwd132.gap_c.
                        nv_prem       = nv_prem + sic_bran.uwd132.prem_c.
                    END.
                END.
                FIND sic_bran.uwd132 WHERE RECID(sic_bran.uwd132) EQ s_130bp1 NO-WAIT NO-ERROR.
                sic_bran.uwd132.fptr   = n_rd132.
                FIND sic_bran.uwd132 WHERE RECID(sic_bran.uwd132) EQ n_rd132 NO-WAIT NO-ERROR.
                s_130bp1      = RECID(sic_bran.uwd132).
                NEXT loop_def.
            END.
        END.
    END.
    ELSE DO:   
        ASSIGN s_130fp1 = 0
        s_130bp1 = 0.
        MESSAGE "ไม่พบ Class " wdetail.subclass " ใน Tariff  " wdetail.tariff  skip
                        "กรุณาใส่ Class หรือ Tariff ใหม่อีกครั้ง" VIEW-AS ALERT-BOX.
    END.
    ASSIGN sic_bran.uwm130.fptr03 = s_130fp1
        sic_bran.uwm130.bptr03 = s_130bp1.
END.
ELSE DO:                              
    s_130fp1 = sic_bran.uwm130.fptr03.
    DO WHILE s_130fp1 <> ? AND s_130fp1 <> 0:
        FIND sic_bran.uwd132 WHERE RECID(sic_bran.uwd132) = s_130fp1 NO-ERROR NO-WAIT.
        IF AVAILABLE sic_bran.uwd132 THEN DO:
            s_130fp1 = sic_bran.uwd132.fptr.
            IF wdetail.tariff = "Z" OR wdetail.tariff = "X" THEN DO:
                IF           wdetail.subclass      = "110" THEN nv_key_a = inte(wdetail.engcc).
                ELSE IF SUBSTRING(wdetail.subclass,1,3) = "120" THEN nv_key_a = inte(wdetail.seat).
                ELSE IF SUBSTRING(wdetail.subclass,1,3) = "130" THEN nv_key_a = inte(wdetail.engcc).
                ELSE IF SUBSTRING(wdetail.subclass,1,3) = "140" THEN nv_key_a = inte(wdetail.tons).
                nv_key_b = (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat) + 1.
                FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601                WHERE
                    sicsyac.xmm106.tariff  = wdetail.tariff          AND
                    sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod  AND
                    sicsyac.xmm106.class   = wdetail.subclass        AND
                    sicsyac.xmm106.covcod  = wdetail.covcod          AND
                    sicsyac.xmm106.key_a  >= nv_key_a                AND 
                    sicsyac.xmm106.key_b  >= nv_key_b                AND 
                    sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat
                    NO-LOCK NO-ERROR NO-WAIT.
                IF AVAILABLE xmm106 THEN 
                    ASSIGN sic_bran.uwd132.gap_c  = sicsyac.xmm106.baseap
                    sic_bran.uwd132.prem_c = sicsyac.xmm106.baseap
                    nv_gap                 = nv_gap  + sic_bran.uwd132.gap_c
                    nv_prem                = nv_prem + sic_bran.uwd132.prem_c.
                ELSE  nv_message = "NOTFOUND".
            END.
            ELSE DO:
                FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601            WHERE
                    sicsyac.xmm106.tariff  = wdetail.tariff      AND 
                    sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod       AND 
                    sicsyac.xmm106.class   = wdetail.subclass    AND 
                    sicsyac.xmm106.covcod  = wdetail.covcod      AND 
                    sicsyac.xmm106.key_a  >= 0                   AND 
                    sicsyac.xmm106.key_b  >= 0                   AND 
                    sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat
                    NO-LOCK NO-ERROR NO-WAIT.
                FIND LAST  sicsyac.xmm106 USE-INDEX xmm10601        WHERE
                    sicsyac.xmm106.tariff  = wdetail.tariff   AND
                    sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod   AND
                    sicsyac.xmm106.class   = wdetail.subclass    AND
                    sicsyac.xmm106.covcod  = wdetail.covcod   AND
                    sicsyac.xmm106.key_a   = 0               AND
                    sicsyac.xmm106.key_b   = 0               AND
                    sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat
                    NO-LOCK NO-ERROR NO-WAIT.
                IF AVAILABLE sicsyac.xmm106 THEN DO:
                    sic_bran.uwd132.gap_c     = sicsyac.xmm106.baseap.
                    RUN proc_wgw72013   (INPUT RECID(sic_bran.uwm100), 
                                        RECID(sic_bran.uwd132),
                                        sic_bran.uwm301.tariff).
                    nv_gap        = nv_gap  + sic_bran.uwd132.gap_c.
                    nv_prem       = nv_prem + sic_bran.uwd132.prem_c.
                END.
            END.
        END.
    END.
END.
RUN proc_7231.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_7231 wgwtltgn 
PROCEDURE proc_7231 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN nv_stm_per = 0.4
    nv_tax_per    = 7.0.
FIND sicsyac.xmm020 USE-INDEX xmm02001     WHERE
    sicsyac.xmm020.branch = sic_bran.uwm100.branch AND
    sicsyac.xmm020.dir_ri = sic_bran.uwm100.dir_ri
    NO-LOCK NO-ERROR.
IF AVAIL sicsyac.xmm020 THEN ASSIGN nv_stm_per             = sicsyac.xmm020.rvstam
    nv_tax_per             = sicsyac.xmm020.rvtax
    sic_bran.uwm100.gstrat = sicsyac.xmm020.rvtax.
ELSE sic_bran.uwm100.gstrat = nv_tax_per.
ASSIGN  nv_gap2  = 0
    nv_prem2 = 0
    nv_rstp  = 0
    nv_rtax  = 0
    nv_com1_per = 0
    nv_com1_prm = 0.
FIND sicsyac.xmm031 WHERE sicsyac.xmm031.poltyp = sic_bran.uwm100.poltyp
    NO-LOCK NO-ERROR NO-WAIT.
IF AVAILABLE sicsyac.xmm031 THEN nv_com1_per = sicsyac.xmm031.comm1.
FOR EACH sic_bran.uwm120 WHERE
    sic_bran.uwm120.policy = wdetail.policy         AND
    sic_bran.uwm120.rencnt = sic_bran.uwm100.rencnt AND
    sic_bran.uwm120.endcnt = sic_bran.uwm100.endcnt AND
    sic_bran.uwm120.bchyr = nv_batchyr              AND 
    sic_bran.uwm120.bchno = nv_batchno              AND 
    sic_bran.uwm120.bchcnt  = nv_batcnt             :
    ASSIGN nv_gap  = 0
        nv_prem = 0.
    FOR EACH sic_bran.uwm130 WHERE
        sic_bran.uwm130.policy = wdetail.policy AND
        sic_bran.uwm130.rencnt = sic_bran.uwm100.rencnt  AND
        sic_bran.uwm130.endcnt = sic_bran.uwm100.endcnt  AND
        sic_bran.uwm130.riskgp = sic_bran.uwm120.riskgp  AND
        sic_bran.uwm130.riskno = sic_bran.uwm120.riskno  AND
        sic_bran.uwm130.bchyr  = nv_batchyr               AND 
        sic_bran.uwm130.bchno  = nv_batchno               AND 
        sic_bran.uwm130.bchcnt  = nv_batcnt              NO-LOCK:
        nv_fptr = sic_bran.uwm130.fptr03.
        DO WHILE nv_fptr <> 0 AND nv_fptr <> ? :
            FIND sic_bran.uwd132 WHERE RECID(sic_bran.uwd132) = nv_fptr
                NO-LOCK NO-ERROR NO-WAIT.
            IF NOT AVAILABLE sic_bran.uwd132 THEN LEAVE.
            nv_fptr = sic_bran.uwd132.fptr.
            nv_gap  = nv_gap  + sic_bran.uwd132.gap_c.
            nv_prem = nv_prem + sic_bran.uwd132.prem_c.
        END.
    END.
    sic_bran.uwm120.gap_r   =  nv_gap.
    sic_bran.uwm120.prem_r  =  nv_prem.
    sic_bran.uwm120.rstp_r  =  TRUNCATE(sic_bran.uwm120.prem_r * nv_stm_per / 100, 0) +
        (IF  TRUNCATE(sic_bran.uwm120.prem_r * nv_stm_per / 100, 2) -
         TRUNCATE(sic_bran.uwm120.prem_r * nv_stm_per / 100, 0) > 0  THEN 1 ELSE 0).
    sic_bran.uwm120.rtax_r = ROUND((sic_bran.uwm120.prem_r + sic_bran.uwm120.rstp_r)  * nv_tax_per  / 100 ,2).
    nv_gap2  = nv_gap2  + nv_gap.
    nv_prem2 = nv_prem2 + nv_prem.
    nv_rstp  = nv_rstp  + sic_bran.uwm120.rstp_r.
    nv_rtax  = nv_rtax  + sic_bran.uwm120.rtax_r.
    IF sic_bran.uwm120.com1ae = NO THEN
        nv_com1_per            = sic_bran.uwm120.com1p.
    IF nv_com1_per <> 0 THEN 
        ASSIGN sic_bran.uwm120.com1ae =  NO
        sic_bran.uwm120.com1p  =  nv_com1_per
        sic_bran.uwm120.com1_r =  (sic_bran.uwm120.prem_r * sic_bran.uwm120.com1p / 100) * 1-
        nv_com1_prm = nv_com1_prm + sic_bran.uwm120.com1_r.
    ELSE DO:
        IF nv_com1_per   = 0  AND sic_bran.uwm120.com1ae = NO THEN 
            ASSIGN
            sic_bran.uwm120.com1p  =  0
            sic_bran.uwm120.com1_r =  0
            sic_bran.uwm120.com1_r =  0
            nv_com1_prm            =  0.
    END.
END.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = nv_rec130 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = nv_rec120 NO-WAIT NO-ERROR.
ASSIGN
    sic_bran.uwm100.gap_p  =  nv_gap2
    sic_bran.uwm100.prem_t =  nv_prem2
    sic_bran.uwm100.rstp_t =  nv_rstp
    sic_bran.uwm100.rtax_t =  nv_rtax
    sic_bran.uwm100.com1_t =  nv_com1_prm.
RUN proc_chktest4.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_address wgwtltgn 
PROCEDURE proc_address :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*provinc...wdetail.add1  "x(100)"
tambon                    "x(35)" 
amper                     "x(35)" 
country                   "x(35)"  */

IF r-index(wdetail.add1,"จ.")      <> 0 THEN 
    ASSIGN wdetail.country = substr(wdetail.add1,r-index(wdetail.add1,"จ."))
    wdetail.add1        = substr(wdetail.add1,1,r-index(wdetail.add1,"จ.") - 1).   
ELSE IF      r-index(wdetail.add1,"จังหวัด") <> 0 THEN 
    ASSIGN wdetail.country = substr(wdetail.add1,r-index(wdetail.add1,"จังหวัด"))
    wdetail.add1        = substr(wdetail.add1,1,r-index(wdetail.add1,"จังหวัด") - 1).
ELSE IF r-index(wdetail.add1,"กรุงเทพ") <> 0 THEN 
    ASSIGN wdetail.country = substr(wdetail.add1,r-index(wdetail.add1,"กรุงเทพ"))
    wdetail.add1        = substr(wdetail.add1,1,r-index(wdetail.add1,"กรุงเทพ") - 1).          
ELSE IF r-index(wdetail.add1,"กทม")     <> 0 THEN 
    ASSIGN wdetail.country = substr(wdetail.add1,r-index(wdetail.add1,"กทม"))
    wdetail.add1        = substr(wdetail.add1,1,r-index(wdetail.add1,"กทม") - 1). 
/*Amper..*/
IF   r-index(wdetail.add1,"อ.")    <> 0 THEN 
    ASSIGN 
    wdetail.amper = substr(wdetail.add1,r-index(wdetail.add1,"อ.")) 
    wdetail.amper = REPLACE(wdetail.amper,"อำเภอ","")
    wdetail.add1  = substr(wdetail.add1,1,r-index(wdetail.add1,"อ.") - 1). 
ELSE IF      r-index(wdetail.add1,"อำเภอ") <> 0 THEN 
    ASSIGN wdetail.amper = substr(wdetail.add1,r-index(wdetail.add1,"อำเภอ"))
    wdetail.add1        = substr(wdetail.add1,1,r-index(wdetail.add1,"อำเภอ") - 1). 
ELSE IF r-index(wdetail.add1,"เขตเขต")   <> 0 THEN 
    ASSIGN 
    wdetail.amper = substr(wdetail.add1,r-index(wdetail.add1,"เขตเขต")) 
    wdetail.amper = "เขต" + TRIM(REPLACE(wdetail.amper,"เขต",""))
    wdetail.add1  = substr(wdetail.add1,1,r-index(wdetail.add1,"เขตเขต") - 1). 
ELSE IF r-index(wdetail.add1,"เขต")   <> 0 THEN 
    ASSIGN wdetail.amper = substr(wdetail.add1,r-index(wdetail.add1,"เขต")) 
    wdetail.add1        = substr(wdetail.add1,1,r-index(wdetail.add1,"เขต") - 1). 
/*tambon*/
IF r-index(wdetail.add1,"ต.")    <> 0 THEN 
    ASSIGN 
    wdetail.tambon = substr(wdetail.add1,r-index(wdetail.add1,"ต.")) 
    wdetail.tambon = REPLACE(wdetail.tambon,"ตำบล","")
    wdetail.add1   = substr(wdetail.add1,1,r-index(wdetail.add1,"ต.") - 1). 
ELSE IF  r-index(wdetail.add1,"ตำบล") <> 0 THEN 
    ASSIGN wdetail.tambon = substr(wdetail.add1,r-index(wdetail.add1,"ตำบล"))
    wdetail.add1        = substr(wdetail.add1,1,r-index(wdetail.add1,"ตำบล") - 1).
ELSE IF r-index(wdetail.add1,"แขวงแขวง")   <> 0 THEN 
    ASSIGN wdetail.tambon = substr(wdetail.add1,r-index(wdetail.add1,"แขวงแขวง")) 
    wdetail.tambon      = "แขวง" + trim(REPLACE(wdetail.tambon,"แขวง",""))
    wdetail.add1        = substr(wdetail.add1,1,r-index(wdetail.add1,"แขวงแขวง") - 1). 
ELSE IF r-index(wdetail.add1,"แขวง")   <> 0 THEN 
    ASSIGN wdetail.tambon = substr(wdetail.add1,r-index(wdetail.add1,"แขวง")) 
    wdetail.add1        = substr(wdetail.add1,1,r-index(wdetail.add1,"แขวง") - 1). 
ASSIGN wdetail.add1 = wdetail.add1 .
IF LENGTH(wdetail.add1) > 35  THEN DO:
    IF R-INDEX(wdetail.add1,"ถนน") <> 0 THEN DO: 
        IF LENGTH(SUBSTR(wdetail.add1,R-INDEX(wdetail.add1,"ถนน"))  + " " + wdetail.tambon) > 35 THEN
            ASSIGN 
            wdetail.amper  =  trim(wdetail.tambon) + " " + trim(wdetail.amper) 
            wdetail.tambon =  trim(SUBSTR(wdetail.add1,R-INDEX(wdetail.add1,"ถนน")))   
            wdetail.add1   =  trim(SUBSTR(wdetail.add1,1, (LENGTH(wdetail.add1) - length(SUBSTR(wdetail.add1,R-INDEX(wdetail.add1,"ถนน")))) - 1 )) .
        ELSE 
            ASSIGN 
                wdetail.tambon =  trim(SUBSTR(wdetail.add1,R-INDEX(wdetail.add1,"ถนน"))) + " " + trim(wdetail.tambon)  
                wdetail.add1   =  trim(SUBSTR(wdetail.add1,1, (LENGTH(wdetail.add1) - length(SUBSTR(wdetail.add1,R-INDEX(wdetail.add1,"ถนน")))) - 1 )) .
    END.
    ELSE IF  R-INDEX(wdetail.add1,"ถ.") <> 0 THEN DO:
        IF LENGTH(SUBSTR(wdetail.add1,R-INDEX(wdetail.add1,"ถ."))  + " " + wdetail.tambon) > 35 THEN
            ASSIGN 
            wdetail.amper  =  trim(wdetail.tambon) + " " + trim(wdetail.amper) 
            wdetail.tambon =  trim(SUBSTR(wdetail.add1,R-INDEX(wdetail.add1,"ถ.")))   
            wdetail.add1   =  trim(SUBSTR(wdetail.add1,1, (LENGTH(wdetail.add1) - length(SUBSTR(wdetail.add1,R-INDEX(wdetail.add1,"ถ.")))) - 1 )) .
        ELSE 
            ASSIGN 
                wdetail.tambon =  trim(SUBSTR(wdetail.add1,R-INDEX(wdetail.add1,"ถ."))) + " " + trim(wdetail.tambon)  
                wdetail.add1   =  trim(SUBSTR(wdetail.add1,1, (LENGTH(wdetail.add1) - length(SUBSTR(wdetail.add1,R-INDEX(wdetail.add1,"ถ.")))) - 1 )) .
    END.
    IF LENGTH(wdetail.add1) > 35  THEN DO:
        IF R-INDEX(wdetail.add1,"ซอย") <> 0 THEN DO: 
            IF LENGTH(SUBSTR(wdetail.add1,R-INDEX(wdetail.add1,"ซอย"))  + " " + wdetail.tambon) > 35 THEN
                ASSIGN 
                wdetail.amper  =  trim(wdetail.tambon) + " " + trim(wdetail.amper) 
                wdetail.tambon =  trim(SUBSTR(wdetail.add1,R-INDEX(wdetail.add1,"ซอย")))   
                wdetail.add1   =  trim(SUBSTR(wdetail.add1,1, (LENGTH(wdetail.add1) - length(SUBSTR(wdetail.add1,R-INDEX(wdetail.add1,"ซอย")))) - 1 )) .
            ELSE 
                ASSIGN 
                    wdetail.tambon =  trim(SUBSTR(wdetail.add1,R-INDEX(wdetail.add1,"ซอย"))) + " " + trim(wdetail.tambon)  
                    wdetail.add1   =  trim(SUBSTR(wdetail.add1,1, (LENGTH(wdetail.add1) - length(SUBSTR(wdetail.add1,R-INDEX(wdetail.add1,"ซอย")))) - 1 )) .
        END.
        ELSE IF  R-INDEX(wdetail.add1,"ซ.") <> 0 THEN DO: 
            IF LENGTH(SUBSTR(wdetail.add1,R-INDEX(wdetail.add1,"ซ."))  + " " + wdetail.tambon) > 35 THEN
                ASSIGN 
                wdetail.amper  =  trim(wdetail.tambon) + " " + trim(wdetail.amper) 
                wdetail.tambon =  trim(SUBSTR(wdetail.add1,R-INDEX(wdetail.add1,"ซ.")))   
                wdetail.add1   =  trim(SUBSTR(wdetail.add1,1, (LENGTH(wdetail.add1) - length(SUBSTR(wdetail.add1,R-INDEX(wdetail.add1,"ซ.")))) - 1 )) .
            ELSE 
                ASSIGN 
                    wdetail.tambon =  trim(SUBSTR(wdetail.add1,R-INDEX(wdetail.add1,"ซ."))) + " " + trim(wdetail.tambon)  
                    wdetail.add1   =  trim(SUBSTR(wdetail.add1,1, (LENGTH(wdetail.add1) - length(SUBSTR(wdetail.add1,R-INDEX(wdetail.add1,"ซ.")))) - 1 )) .
        END.
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign wgwtltgn 
PROCEDURE proc_assign :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR chk_sticker AS CHAR FORMAT "x(15)".
DEF VAR n_nameno AS INTE.

ASSIGN wdetail.GenStatus = "NO" .

LOOP_WDETAIL:
REPEAT:
    RUN proc_var.
    IF wdetail.policy = "" THEN LEAVE LOOP_WDETAIL.
    ELSE IF LENGTH(TRIM(wdetail.policy)) <> 12 THEN LEAVE LOOP_WDETAIL.
    FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE
        sicuw.uwm100.policy = wdetail.policy  NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uwm100 THEN DO: 
        /*comment by kridtiya i. A57-0391.........
        ASSIGN  wdetail.pass  = "N"
            wdetail.comment   =  wdetail.comment + "| หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "
            wdetail.warning   = "Program Running Policy No. ให้ชั่วคราว".
        LEAVE LOOP_WDETAIL.
        end..comment by kridtiya i. A57-0391........*/
        /*Add by kridtiya i. A57-0391.....*/
        IF sicuw.uwm100.releas = YES THEN DO:
            ASSIGN  wdetail.pass    = "N"
                wdetail.comment = wdetail.comment + "| หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว releas = YES "
                wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
            LEAVE LOOP_WDETAIL.
        END.
        ELSE IF (sicuw.uwm100.name1 <> "") AND (sicuw.uwm100.comdat <> ?) THEN DO:
            ASSIGN  wdetail.pass  = "N"
                wdetail.comment   =  wdetail.comment + "| หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "
                wdetail.warning   = "Program Running Policy No. ให้ชั่วคราว".
            LEAVE LOOP_WDETAIL.
        END.
        ASSIGN wdetail.docno = trim(sicuw.uwm100.docno1).
        /*Add by kridtiya i. A57-0391.....*/
    END.
    FIND LAST sicuw.uwm100  USE-INDEX uwm10002  WHERE
        sicuw.uwm100.cedpol =  wdetail.cedpol   AND
        sicuw.uwm100.poltyp =  "v72"            NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uwm100 THEN DO:
        IF (sicuw.uwm100.expdat > DATE(wdetail.comdat)) THEN 
            ASSIGN  wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| พบเลขที่สัญญานี้ยังไม่หมดอายุ" + wdetail.cedpol
            wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
        LEAVE LOOP_WDETAIL.
    END.
    IF wdetail.stk  <>  ""  THEN DO: 
        IF SUBSTRING(wdetail.stk,1,1) = "2"  THEN wdetail.stk = "0" + trim(wdetail.stk).
        IF LENGTH(wdetail.stk) < 9 OR LENGTH(wdetail.stk) > 13 THEN DO: 
            ASSIGN 
                wdetail.comment = wdetail.comment + "| เลข Sticker ต้องเป็น 11 หรือ 13 หลักเท่านั้น"
                wdetail.pass    = ""
                wdetail.OK_GEN  = "N".
            LEAVE LOOP_WDETAIL.
        END.
        ASSIGN 
            chr_sticker = wdetail.stk 
            chk_sticker = chr_sticker.
        RUN wuz\wuzchmod.
        IF chk_sticker  <>  chr_sticker  Then DO:
            ASSIGN wdetail.pass = "N"
                wdetail.comment = wdetail.comment + "| Sticker Number Module Error".
            LEAVE LOOP_WDETAIL.
        END.
        nv_newsck = " ".
        FIND FIRST stat.detaitem USE-INDEX detaitem11 WHERE
            stat.detaitem.serailno = wdetail.stk      NO-LOCK NO-ERROR.
        IF AVAIL stat.detaitem THEN DO: 
            IF stat.detaitem.policy <> wdetail.policy THEN DO:
                ASSIGN wdetail.pass = "N"
                    wdetail.comment = wdetail.comment + "| หมายเลขStickerเบอร์นี้ได้ถูกใช้ไปแล้วด้วยกรมธรรม์อื่น"
                    wdetail.warning = " ".
                LEAVE LOOP_WDETAIL.
            END.
        END.
    END.
    IF wdetail.subclass = "140" THEN wdetail.subclass = "140A"  .  /*A58-0210*/
    FIND  sicsyac.xmd031 USE-INDEX xmd03101 WHERE
        sicsyac.xmd031.poltyp = wdetail.poltyp    AND
        sicsyac.xmd031.class  = wdetail.subclass  NO-LOCK NO-ERROR.
    IF NOT AVAIL sicsyac.xmd031 THEN DO:
        ASSIGN  wdetail.pass = "N"
            wdetail.comment  = wdetail.comment + "| ไม่พบ Class ที่เป็นของ Policy Typeนี้"
            wdetail.OK_GEN   = "N".
        LEAVE LOOP_WDETAIL.
    END.
    ASSIGN 
        n_rencnt = 0
        n_endcnt = 0
        nv_uwm301trareg = "".
    RUN proc_address.
    RUN proc_cutcha_no.
    RUN proc_72.
    RUN proc_policy. 
    RUN proc_722.
    RUN proc_723 (INPUT  s_recid1,       
                  INPUT  s_recid2,
                  INPUT  s_recid3,
                  INPUT  s_recid4,
                  INPUT-OUTPUT nv_message). 
    /**--- Update status Gen.Status เข้า Data ที่เข้า Gw แล้ว ----**/

    ASSIGN wdetail.GenStatus = "YES" .

    LEAVE LOOP_WDETAIL.
END.


RELEASE sic_bran.uwm100.
RELEASE sic_bran.uwm120.
RELEASE sic_bran.uwm130.
RELEASE sic_bran.uwm301.
RELEASE sic_bran.uwd132.
    


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_batch wgwtltgn 
PROCEDURE proc_batch :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  running batch     
------------------------------------------------------------------------------*/

    RUN wgw\wgwbatch.p    (INPUT        TODAY ,     /* DATE  */       
                           INPUT        nv_batchyr ,     /* INT   */  
                           INPUT        fi_producer,     /* CHAR  */  
                           INPUT        fi_branch  ,     /* CHAR  */  
                           INPUT        nv_batprev ,/* CHAR  */ /*Previous Batch*/
                           INPUT        "WGWTLTGN" , /* CHAR  */
                           INPUT-OUTPUT nv_batchno , /* CHAR  */
                           INPUT-OUTPUT nv_batcnt  , /* INT   */
                           INPUT        nv_imppol  , /* INT   */
                           INPUT        nv_impprem).
    FIND LAST uzm701 USE-INDEX uzm70102  
      WHERE uzm701.bchyr  = nv_batchyr AND
            uzm701.bchno  = nv_batchno AND
            uzm701.bchcnt = nv_batcnt  NO-ERROR.
    IF AVAIL uzm701 THEN DO:
          ASSIGN
            uzm701.impflg      = YES    
            uzm701.cnfflg      = YES .   
    END.
                     
    fi_batch = nv_batchno + "." +  string(nv_batcnt,"99").
    DISP fi_batch WITH FRAME fr_main.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest4 wgwtltgn 
PROCEDURE proc_chktest4 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
Def  var   n_sigr_r     like sic_bran.uwm130.uom6_v.
Def  var   n_gap_r      Like sic_bran.uwd132.gap_c . 
Def  var   n_prem_r     Like sic_bran.uwd132.prem_c.
Def  var   nt_compprm   like sic_bran.uwd132.prem_c.  
Def  var   n_gap_t      Like sic_bran.uwm100.gap_p.
Def  var   n_prem_t     Like sic_bran.uwm100.prem_t.
Def   var  n_sigr_t     Like sic_bran.uwm100.sigr_p.
def  var   nv_policy    like sic_bran.uwm100.policy.
def  var   nv_rencnt    like sic_bran.uwm100.rencnt.
def  var   nv_endcnt    like sic_bran.uwm100.endcnt.
def  var   nv_com1_per  like sicsyac.xmm031.comm1.
def  var   nv_stamp_per like sicsyac.xmm020.rvstam.
/*-------  note add ------*/
DEF VAR nv_com2p        AS DECI INIT 0.00 .
DEF VAR nv_com1p        AS DECI INIT 0.00 .
DEF VAR nv_fi_netprm    AS DECI INIT 0.00.
DEF VAR NV_fi_dup_trip  AS CHAR FORMAT  "X" INIT "".
DEF VAR nv_fi_tax_per   AS DECI INIT 0.00.
DEF VAR nv_fi_stamp_per AS DECI INIT 0.00.
DEF VAR nv_fi_rstp_t    AS INTE INIT 0.
DEF VAR nv_fi_rtax_t    AS DECI INIT 0.00 .
DEF VAR nv_fi_com1_t    AS DECI INIT 0.00.
DEF VAR nv_fi_com2_t    AS DECI INIT 0.00.
/*------------------------*/
FIND sic_bran.uwm100   Where Recid(sic_bran.uwm100)  = s_recid1
  no-error no-wait.
  If  not avail sic_bran.uwm100  Then do:
      Message "not found (uwm100./wuwrep02.p)" View-as alert-box.
      Return.
  End.
  Else  do:
      Assign    
            
            nv_policy  =  CAPS(sic_bran.uwm100.policy)
            nv_rencnt  =  sic_bran.uwm100.rencnt
            nv_endcnt  =  sic_bran.uwm100.endcnt.
           
            FOR EACH sic_bran.uwm120 USE-INDEX uwm12001 WHERE
                     sic_bran.uwm120.policy  = sic_bran.uwm100.policy  AND
                     sic_bran.uwm120.rencnt  = sic_bran.uwm100.rencnt  AND
                     sic_bran.uwm120.endcnt  = sic_bran.uwm100.endcnt  AND
                     sic_bran.uwm120.bchyr   = nv_batchyr              AND 
                     sic_bran.uwm120.bchno   = nv_batchno              AND 
                     sic_bran.uwm120.bchcnt  = nv_batcnt               .

                     FOR EACH sic_bran.uwm130   USE-INDEX uwm13001 WHERE
                              sic_bran.uwm130.policy  = sic_bran.uwm120.policy  AND
                              sic_bran.uwm130.rencnt  = sic_bran.uwm120.rencnt  AND
                              sic_bran.uwm130.endcnt  = sic_bran.uwm120.endcnt  AND
                              sic_bran.uwm130.riskno  = sic_bran.uwm120.riskno  AND
                              sic_bran.uwm130.bchyr = nv_batchyr                AND 
                              sic_bran.uwm130.bchno = nv_batchno                AND 
                              sic_bran.uwm130.bchcnt  = nv_batcnt               NO-LOCK.
                         n_sigr_r                = n_sigr_r + uwm130.uom6_v.

                         FOR EACH sic_bran.uwd132  USE-INDEX uwd13201 WHERE  
                                       sic_bran.uwd132.policy  = sic_bran.uwm130.policy  AND
                                       sic_bran.uwd132.rencnt  = sic_bran.uwm130.rencnt  AND
                                       sic_bran.uwd132.endcnt  = sic_bran.uwm130.endcnt  AND
                                       sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno  AND
                                       sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno  AND
                                       sic_bran.uwd132.bchyr   = nv_batchyr              AND 
                                       sic_bran.uwd132.bchno   = nv_batchno              AND 
                                       sic_bran.uwd132.bchcnt  = nv_batcnt               NO-LOCK.
                             IF  sic_bran.uwd132.bencod  = "COMP"   THEN
                                 nt_compprm     = nt_compprm + sic_bran.uwd132.prem_c.
                             n_gap_r  = sic_bran.uwd132.gap_c  + n_gap_r.
                             n_prem_r = sic_bran.uwd132.prem_c + n_prem_r.
                         END.    /* uwd132 */
                     END.       /*uwm130 */
                          ASSIGN
                          n_gap_t      = n_gap_t   + n_gap_r
                          n_prem_t     = n_prem_t  + n_prem_r
                          n_sigr_t     = n_sigr_t  + n_sigr_r

                          n_gap_r      = 0 
                          n_prem_r     = 0  
                          n_sigr_r     = 0.
           END.    /* end uwm120 */
  End.  /*  avail  100   */

  /*-------------------- calprem ---------------------*/
  Find LAST  sic_bran.uwm120  Use-index uwm12001  WHERE          /***--- a490166 change first to last ---***/
             sic_bran.uwm120.policy  = sic_bran.uwm100.policy   And 
             sic_bran.uwm120.rencnt  = sic_bran.uwm100.rencnt   And 
             sic_bran.uwm120.endcnt  = sic_bran.uwm100.endcnt   AND 
             sic_bran.uwm120.bchyr   = nv_batchyr               AND 
             sic_bran.uwm120.bchno   = nv_batchno               AND 
             sic_bran.uwm120.bchcnt  = nv_batcnt                No-error.

  /***--- A50-0097 Shukiat T. 26/04/2007 ---***/
  /***--- เปลี่ยนรูปแบบการค้น Commission Rate ใหม่ ---***/
  /***--- A49-0206 Shukiat T. 15/01/2006 ---***/
  /***--- Commmission Rate Line 70 ---***/
  /***--- A50-0144 Shukiat T. 05/06/2007 ---***/
  /***--- เปลี่ยนเงื่อนไขการ Find เงื่อนไขใน Table Xmm018 ---***/
  FIND LAST  sicsyac.xmm018 USE-INDEX xmm01801 WHERE
             sicsyac.xmm018.agent              = sic_bran.uwm100.acno1          AND               /*แยกงานตาม Code Producer*/  
             substr(sicsyac.xmm018.poltyp,1,5) = "CR" + sic_bran.uwm100.poltyp  AND               /*Shukiat T. modi on 25/04/2007*/
             SUBSTR(xmm018.poltyp,7,1)         = sic_bran.uwm100.branch         AND               /*Shukiat T. add on 05/06/2007 A50-0144*/
             sicsyac.xmm018.datest            <= sic_bran.uwm100.comdat         NO-LOCK NO-ERROR. /*Shukiat T. add on 25/04/2007*/
  IF AVAIL   sicsyac.xmm018 THEN DO:
            Assign     nv_com1p = sicsyac.xmm018.commsp  
                       nv_com2p = 0.
  END. /* Avail Xmm018 */
  ELSE DO:
          Find sicsyac.xmm031  Use-index xmm03101  Where  
               sicsyac.xmm031.poltyp  = sic_bran.uwm100.poltyp
          No-lock no-error no-wait.
          IF not  avail sicsyac.xmm031 Then 
            Assign     nv_com1p = 0
                       nv_com2p = 0.
          Else  
            Assign     nv_com1p = sicsyac.xmm031.comm1
                       nv_com2p = 0 .
                     /*nv_com2p = sicsyac.xmm031.comm2.*//*A490206*/
  END. /* Not Avail Xmm018 */
  
  /***--- Commmission Rate Line 72 ---***/
  IF wdetail.compul = "y" THEN DO:
      FIND LAST  sicsyac.xmm018 USE-INDEX xmm01801 WHERE
                 sicsyac.xmm018.agent              = sic_bran.uwm100.acno1  AND               /*แยกงานตาม Code Producer*/   
                 substr(sicsyac.xmm018.poltyp,1,5) = "CRV72"                AND               /*Shukiat T. modi on 25/04/2007*/
                 SUBSTR(xmm018.poltyp,7,1)         = sic_bran.uwm100.branch AND               /*Shukiat T. add on 05/06/2007 A50-0144*/
                 sicsyac.xmm018.datest            <= sic_bran.uwm100.comdat NO-LOCK NO-ERROR. /*Shukiat T. add on 25/04/2007*/
      IF AVAIL   sicsyac.xmm018 THEN DO:
                 nv_com2p = sicsyac.xmm018.commsp.
      END.
      ELSE DO:
           Find  sicsyac.xmm031  Use-index xmm03101  Where  
                 sicsyac.xmm031.poltyp    = "v72"
           No-lock no-error no-wait.
                 /*nv_com2p = sicsyac.xmm018.commsp.*//***--- Shukiat T. 26/01/2007 ---***/
                   nv_com2p = sicsyac.xmm031.comm1.   /***--- Shukiat T. 26/01/2007 ---***/
      END.
  END. /* Wdetail.Compul = "Y"*/
  /***--- End a490206 15/01/2007 ---***/


  /*--------- tax -----------*/
  Find sicsyac.xmm020 Use-index xmm02001        Where
       sicsyac.xmm020.branch = sic_bran.uwm100.branch   And
       sicsyac.xmm020.dir_ri = sic_bran.uwm100.dir_ri   No-lock no-error.
  IF avail sicsyac.xmm020 Then do:
           nv_fi_stamp_per      = sicsyac.xmm020.rvstam.
       If    sic_bran.uwm100.gstrat  <>  0  Then  nv_fi_tax_per  =  sic_bran.uwm100.gstrat.
       Else  nv_fi_tax_per  =  sicsyac.xmm020.rvtax.
  End.
    
  /*----------- stamp ------------*/
  IF sic_bran.uwm120.stmpae  = Yes Then do:                        /* STAMP */
     nv_fi_rstp_t  = Truncate(sic_bran.uwm100.prem_t * nv_fi_stamp_per / 100,0) +
                     (IF  Truncate(sic_bran.uwm100.prem_t * nv_fi_stamp_per / 100,2)   -
                     Truncate(sic_bran.uwm100.prem_t * nv_fi_stamp_per / 100,0) > 0
                     Then 1 Else 0).
  End.
  /***--- a490166 Block on 28/09/2006 ---***//***---
  Else  do:
           /*nv_fi_stmpae    = NO. /*a / e*/*/
  End.
  ---***//***---End Note Block ---***/  
  
  sic_bran.uwm100.rstp_t = nv_fi_rstp_t.
     
  IF  sic_bran.uwm120.taxae   = Yes   Then do:                       /* TAX */
      nv_fi_rtax_t  = (sic_bran.uwm100.prem_t + nv_fi_rstp_t + sic_bran.uwm100.pstp)
                       * nv_fi_tax_per  / 100.
       /* fi_taxae       = Yes.*/
  End.
  /***--- a490166 Block on 28/09/2006 ---***//***---
  Else do:
        /*fi_taxae     = no.*/
  end.
  ---***//***---End Note Block ---***/  
    
  sic_bran.uwm100.rtax_t = nv_fi_rtax_t.

  /*-a490206-*/
  sic_bran.uwm120.com1ae = YES.
  sic_bran.uwm120.com2ae = YES.
  
  /*--------- motor commission -----------------*/
  IF sic_bran.uwm120.com1ae   = Yes  Then do:                   /* MOTOR COMMISION */
     If sic_bran.uwm120.com1p <> 0  Then nv_com1p  = sic_bran.uwm120.com1p.
         /*nv_fi_com1_t   =  - TRUNCATE ((sic_bran.uwm100.prem_t - nt_compprm) * nv_com1p / 100,0).*/ /*A490166 Shukiat T. Block on 24/10/2006*/
           nv_fi_com1_t   =  - (sic_bran.uwm100.prem_t - nt_compprm) * nv_com1p / 100.             /*A490166 Shukiat T. Modi on 24/10/2006*/
         /*fi_com1ae        =  YES.*/
  End.
  /***--- a490166 Block on 28/09/2006 ---***//***---
  Else do:
         /*fi_com1ae     = NO.*/
  End.
  ---***//***---End Note Block ---***/  

  /*----------- comp comission ------------*/
  IF sic_bran.uwm120.com2ae   = Yes  Then do:                   /* Comp.COMMISION */
      If sic_bran.uwm120.com2p <> 0  Then nv_com2p  = sic_bran.uwm120.com2p.
         /*nv_fi_com2_t   =  - TRUNCATE ( nt_compprm  *  nv_com2p / 100,0).*/   /*A490166 Shukiat T. Block on 24/10/2006*/
           nv_fi_com2_t   =  - nt_compprm  *  nv_com2p / 100.              /*A490166 Shukiat T. Modi on 24/10/2006*/
         /*nv_fi_com2ae        =  YES.*/
  End.
  /***--- a490166 Block on 28/09/2006 ---***//***---
  Else do:
       /*  fi_com2ae     = NO.*/
  End.
  ---***//***---End Note Block ---***/  

  IF sic_bran.uwm100.pstp <> 0 Then do:
     IF sic_bran.uwm100.no_sch  = 1 Then NV_fi_dup_trip = "D".
     Else If sic_bran.uwm100.no_sch  = 2 Then  NV_fi_dup_trip = "T".
  End.
  Else  NV_fi_dup_trip  =  "".

  nv_fi_netprm = sic_bran.uwm100.prem_t + sic_bran.uwm100.rtax_t
               + sic_bran.uwm100.rstp_t + sic_bran.uwm100.pstp.

  /*---------------------------*/
  
  Find     sic_bran.uwm100 Where  Recid(sic_bran.uwm100)  =  s_recid1.
  If avail sic_bran.uwm100 Then do:
      Assign 
           sic_bran.uwm100.gap_p   = n_gap_t
           sic_bran.uwm100.prem_t  = n_prem_t
           sic_bran.uwm100.sigr_p  = n_sigr_t
           sic_bran.uwm100.instot  = uwm100.instot
           sic_bran.uwm100.com1_t  =  nv_fi_com1_t
           sic_bran.uwm100.com2_t  =  nv_fi_com2_t
         /*sic_bran.uwm100.pstp    =  nv_fi_stamp_per /*note Block on 25/10/2006*/*/
           sic_bran.uwm100.pstp    =  0               /*note modified on 25/10/2006*/
           sic_bran.uwm100.rstp_t  =  nv_fi_rstp_t
           sic_bran.uwm100.rtax_t  =  nv_fi_rtax_t
           sic_bran.uwm100.gstrat  =  nv_fi_tax_per.
  End.
  IF wdetail.poltyp = "v72" THEN DO:
            ASSIGN  
           sic_bran.uwm100.com2_t  = 0 
           sic_bran.uwm100.com1_t  = nv_fi_com2_t.
  END.

  Find     sic_bran.uwm120 Where  Recid(sic_bran.uwm120)   =  s_recid2   .
  IF avail sic_bran.uwm120 Then do:
       Assign
           sic_bran.uwm120.gap_r    = n_gap_t   /*n_gap_r */
           sic_bran.uwm120.prem_r   = n_prem_t  /*n_prem_r */
           sic_bran.uwm120.sigr     = n_sigr_T  /* A490166 note modi from n_sigr_r to n_sigr_t 11/10/2006 */
           sic_bran.uwm120.rtax     = nv_fi_rtax_t
           sic_bran.uwm120.taxae    = YES
           sic_bran.uwm120.stmpae   = YES
           sic_bran.uwm120.rstp_r   = nv_fi_rstp_t
           sic_bran.uwm120.com1ae   = YES
           sic_bran.uwm120.com1p    = nv_com1p
           sic_bran.uwm120.com1_r   = nv_fi_com1_t
           sic_bran.uwm120.com2ae   = YES
           sic_bran.uwm120.com2p    = nv_com2p
           sic_bran.uwm120.com2_r   = nv_fi_com2_t.
       
        IF wdetail.poltyp = "v72" THEN DO:
           ASSIGN  
           sic_bran.uwm120.com2_r    = 0 
           sic_bran.uwm120.com1_r    = nv_fi_com2_t
           /*-a490206-*/
           sic_bran.uwm120.com1p     = nv_com2p
           sic_bran.uwm120.com2p     = 0.
        END.
  End.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create100 wgwtltgn 
PROCEDURE proc_create100 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

Create  sic_bran.uwm100.   /*Create ฝั่ง gateway*/    
ASSIGN                                              
sic_bran.uwm100.policy =  caps(trim(wdetail.policy))
sic_bran.uwm100.rencnt =  n_rencnt             
sic_bran.uwm100.renno  =  ""
sic_bran.uwm100.endcnt =  n_endcnt
sic_bran.uwm100.bchyr  =  nv_batchyr 
sic_bran.uwm100.bchno  =  nv_batchno 
sic_bran.uwm100.bchcnt =  nv_batcnt  .


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create120 wgwtltgn 
PROCEDURE proc_create120 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND sic_bran.uwm120 USE-INDEX uwm12001      WHERE
    sic_bran.uwm120.policy = caps(trim(wdetail.policy)) AND 
    sic_bran.uwm120.rencnt = n_rencnt                   AND
    sic_bran.uwm120.endcnt = n_endcnt                   AND 
    sic_bran.uwm120.riskgp = s_riskgp                   AND 
    sic_bran.uwm120.riskno = s_riskno                   AND 
    sic_bran.uwm120.bchyr  = nv_batchyr                 AND 
    sic_bran.uwm120.bchno  = nv_batchno                 AND
    sic_bran.uwm120.bchcnt = nv_batcnt      NO-WAIT NO-ERROR.
IF NOT AVAILABLE sic_bran.uwm120 THEN DO:
    CREATE sic_bran.uwm120.
    ASSIGN
        sic_bran.uwm120.policy = caps(trim(wdetail.policy))
        sic_bran.uwm120.rencnt = n_rencnt  
        sic_bran.uwm120.endcnt = n_endcnt                  
        sic_bran.uwm120.riskgp = s_riskgp
        sic_bran.uwm120.riskno = s_riskno
        sic_bran.uwm120.sicurr = "BHT"
        sic_bran.uwm120.siexch = 1
        sic_bran.uwm120.fptr01 = 0          sic_bran.uwm120.bptr01 = 0
        sic_bran.uwm120.fptr02 = 0          sic_bran.uwm120.bptr02 = 0
        sic_bran.uwm120.fptr03 = 0          sic_bran.uwm120.bptr03 = 0
        sic_bran.uwm120.fptr04 = 0          sic_bran.uwm120.bptr04 = 0
        sic_bran.uwm120.fptr08 = 0          sic_bran.uwm120.bptr08 = 0
        sic_bran.uwm120.fptr09 = 0          sic_bran.uwm120.bptr09 = 0
        sic_bran.uwm120.com1ae = YES
        sic_bran.uwm120.stmpae = YES
        sic_bran.uwm120.feeae  = YES
        sic_bran.uwm120.taxae  = YES
        s_recid2      = RECID(sic_bran.uwm120)
        sic_bran.uwm120.bchyr = nv_batchyr         /* batch Year */
        sic_bran.uwm120.bchno   = nv_batchno         /* batchno    */
        sic_bran.uwm120.bchcnt  = nv_batcnt     .     /* batcnt     */
    END.
/*---end program */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cutcha_no wgwtltgn 
PROCEDURE proc_cutcha_no :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR nv_chanew AS CHAR.
DEFINE VAR nv_len AS INTE INIT 0.
ASSIGN nv_uwm301trareg = wdetail.chasno .
    loop_chk1:
    REPEAT:
        IF INDEX(nv_uwm301trareg,"-") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"-") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"-") + 1, nv_len ) .
        END.
        ELSE LEAVE loop_chk1.
    END.
    loop_chk2:
    REPEAT:
        IF INDEX(nv_uwm301trareg,"/") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"/") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"/") + 1, nv_len ) .
        END.
        ELSE LEAVE loop_chk2.
    END.
    loop_chk3:
    REPEAT:
        IF INDEX(nv_uwm301trareg,";") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,";") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,";") + 1, nv_len ) .
        END.
        ELSE LEAVE loop_chk3.
    END.
    loop_chk4:
    REPEAT:
        IF INDEX(nv_uwm301trareg,".") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,".") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,".") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk4.
    END.
    loop_chk5:
    REPEAT:
        IF INDEX(nv_uwm301trareg,",") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,",") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,",") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk5.
    END.
    loop_chk6:
    REPEAT:
        IF INDEX(nv_uwm301trareg," ") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg," ") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg," ") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk6.
    END.
    loop_chk7:
    REPEAT:
        IF INDEX(nv_uwm301trareg,"\") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"\") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"\") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk7.
    END.
    loop_chk8:
    REPEAT:
        IF INDEX(nv_uwm301trareg,":") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,":") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,":") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk8.
    END.
    loop_chk9:
    REPEAT:
        IF INDEX(nv_uwm301trareg,"|") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"|") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"|") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk9.
    END.
    loop_chk10:
    REPEAT:
        IF INDEX(nv_uwm301trareg,"+") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"+") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"+") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk10.
    END.
    loop_chk11:
    REPEAT:
        IF INDEX(nv_uwm301trareg,"#") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"#") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"#") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk11.
    END.
    loop_chk12:
    REPEAT:
        IF INDEX(nv_uwm301trareg,"[") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"[") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"[") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk12.
    END.
    loop_chk13:
    REPEAT:
        IF INDEX(nv_uwm301trareg,"]") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"]") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"]") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk13.
    END.
    loop_chk14:
    REPEAT:
        IF INDEX(nv_uwm301trareg,"'") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"'") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"+") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk14.
    END.
    loop_chk15:
    REPEAT:
        IF INDEX(nv_uwm301trareg,"(") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"(") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"(") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk15.
    END.
    loop_chk16:
    REPEAT:
        IF INDEX(nv_uwm301trareg,"_") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"_") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"_") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk16.
    END.
    loop_chk17:
    REPEAT:
        IF INDEX(nv_uwm301trareg,"*") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"*") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"*") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk17.
    END.
     loop_chk18:
    REPEAT:
        IF INDEX(nv_uwm301trareg,")") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,")") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,")") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk18.
    END.
    loop_chk19:
    REPEAT:
        IF INDEX(nv_uwm301trareg,"=") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"=") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"=") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk19.
    END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_exrunjob wgwtltgn 
PROCEDURE proc_exrunjob :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
ASSIGN
        fi_Display  = "" 
        fi_Display2 = "".
    loop_job:
    REPEAT:
        ASSIGN                                                                                                          
            nv_pindex = 0     nv_vehreg2 = ""                                                                                                
            nv_fname  = ""    nv_pvc     = ""                                                                                                
            nv_sname  = ""    nv_licn    = ""    
            nv_flagen = ""    nv_veh     = ""  .  
        /* FIND FIRST sqm001 USE-INDEX sqm00101 
        WHERE sqm001.jobq# = "COMOICINT" NO-LOCK NO-ERROR NO-WAIT.  
        IF AVAILABLE sqm001 THEN DO:*/
        FIND FIRST  uwm100  USE-INDEX uwm10001                                                                              
            WHERE uwm100.policy  = sqm001.prmts[1]                                                                          
            AND   uwm100.rencnt  = INTEGER(SUBSTRING(sqm001.prmts[2],1,3))                                                  
            AND   uwm100.endcnt  = INTEGER(SUBSTRING(sqm001.prmts[3],1,3))
            AND   uwm100.RELEAS  = YES
            NO-LOCK NO-ERROR.                                
       IF AVAIL uwm100 THEN DO:
         
         RUN PDDATA. /* name agentcode */

         FOR EACH  uwm301 USE-INDEX uwm30101     
             WHERE uwm301.policy = uwm100.policy                                                                        
             AND   uwm301.rencnt = uwm100.rencnt                                                                      
             AND   uwm301.endcnt = uwm100.endcnt
         NO-LOCK: 

             IF SUBSTRING(uwm301.vehreg,1,1) = "/"       OR                                                        
                SUBSTRING(uwm301.vehreg,1,1) = "\"       OR                                                        
                SUBSTRING(uwm301.vehreg,1,1) = "."       OR                                                        
                TRIM(uwm301.vehreg)          = ""        OR                                                        
                TRIM(uwm301.vehreg)          = "-"       OR                                                        
                TRIM(uwm301.vehreg)          = "รถใหม่"  OR
                TRIM(uwm301.vehreg)          = "ป้ายแดง"
             THEN DO:                                                      
                ASSIGN                                                                                             
                  nv_vehreg2 = "ใหม่"                                                                              
                  nv_procode = "99"
                  nv_vehreg = ""                                                                                
                  nv_vehreg = uwm301.vehreg. /* --- Suthida T. A56-0186 19-06-13 --- */ 

             END.
             ELSE DO:                                                                                              
                 ASSIGN                                                                                          
                   nv_vehreg = ""                                                                                
                   nv_vehreg = uwm301.vehreg                                                                     
                                                                                                                 
                   nv_vehreg2 = "" /* เลขทะเบียนจัดใหม่ */                                                       
                   nv_pvc     = "" /* จว. */                                                                     
                   nv_licn    = "" /* กท. */                                                                     
                   nv_veh     = "" /* เลขทะเบียน */                                                              
                   nv_length  = 0                                                                                
                   nv_length2 = 0                                                                                
                   nv_length  = LENGTH(TRIM(nv_vehreg))                                                          
                   nv_length2 = LENGTH(TRIM(nv_vehreg)).                                                         
                                                                                                                  
                 RUN PDplatepov. /*หาทะเบียนรถและจังหวัดใหม่*/                                                    
             END.

             RUN PDCLASS.    /*รหัสประเภทรถ*/  

             ASSIGN 
               nv_riskno  = uwm301.riskno.
               nv_itemno  = uwm301.itemno.
               nv_chassis = uwm301.cha_no.

             FIND FIRST uwd132 USE-INDEX uwd13290     WHERE                                                              
                      uwd132.policy = uwm301.policy AND                                                                 
                      uwd132.rencnt = uwm301.rencnt AND                                                                 
                      uwd132.endcnt = uwm301.endcnt AND                                                                 
                      uwd132.riskgp = uwm301.riskgp AND                                                                 
                      uwd132.riskno = uwm301.riskno AND                                                                 
                      uwd132.itemno = uwm301.itemno AND
                      SUBSTR(uwd132.bencod,1,3) = "COM"
             NO-LOCK NO-WAIT NO-ERROR.                                       
             IF AVAILABLE uwd132 THEN DO:                                                                                
                nv_policy = TRIM(TRIM(uwm100.policy)    +                                                             
                            STRING(uwm301.riskno,"999") +                                                             
                            STRING(uwm301.itemno,"999")).                                                             
                                                                                                                      
                     IF uwd132.prem_c > 0  THEN nv_flagen = "P".                                                      
                ELSE IF uwd132.prem_c < 0  THEN nv_flagen = "R".                                                      
                ELSE IF uwd132.prem_c = 0  THEN nv_flagen = "N".                                                      
             END. /*Uwd132*/
         END. /*uwm301*/

         IF uwm100.polsta = "CA" THEN nv_flagen = "X".

         RUN PDCHECK.  /* Check  Error */

         IF nv_error <> "Error"  THEN DO: /*--- Suthida t. A56-0168 17-06-13 ---- */

            IF uwm100.endcnt = 0 THEN DO:  

                RUN PDPOLICY.                                                                                      
                RELEASE PolicyOIC.     

                fi_display = "Transfer  Data To OICINT" + uwm100.policy   + "Complate".                         
       
                DISP fi_display FGCOLOR 6 FONT 6 WITH FRAME fr_main.
                
            END.                                                                                                  
            ELSE DO:                                                                                              
                RUN PDENDORSE.                                                                                     
                RELEASE EndorseOIC.  

                fi_display = "Transfer  Data To OICINT" + uwm100.policy  + "Complate".                         
       
                DISP fi_display FGCOLOR 6 FONT 6 WITH FRAME fr_main.
               
            END.                                                                                                  
                                                                                                                 
            RUN PDJobQ.                                                                                           
            RELEASE JobQOIC. 

         END.

         nv_error = "".
         

       END. /*FIND FIRST  uwm100*/

       /*--- Suthida t. A56-0168 17-06-13 ----*/
       FIND FIRST bsqm001 USE-INDEX sqm00101                                                                                
            WHERE bsqm001.jobq#  = sqm001.jobq#                                                                             
            AND   bsqm001.prioty = sqm001.prioty                                                                            
            AND   bsqm001.qdate  = sqm001.qdate                                                                             
            AND   bsqm001.qtime  = sqm001.qtime NO-ERROR NO-WAIT.                                                           
       IF AVAIL bSQM001 THEN DO:                                                                                            
       
          fi_display = "Transfer  Data To OICINT" + bsqm001.jobq# + bsqm001.prmts[1]  + "Complate".                         
       
          DISP fi_display FGCOLOR 6 FONT 6 WITH FRAME fr_main.  
       
          DELETE bsqm001.       
       
          PAUSE 2 NO-MESSAGE.                                                                                               
          IF LASTKEY = KEYCODE("F4") THEN LEAVE loop_job.                                                                   
       END.                                                                                                                 
       RELEASE bsqm001.                                                                                                     
       /*--- Suthida t. A56-0168 17-06-13 ----*/

    END.
    ELSE DO:
        /* เช็คข้อมูล Q ที่ SQm001 ว่ามี Q COMPOICหรือไม่ และถ้าต้องการหยุดการ Run Q  ให้กด ปุ่ม F4 */
        HIDE MESSAGE NO-PAUSE.
        BELL.       BELL.      BELL.
        fi_Display = "Not found data on Job queue (sqm001)".
        fi_Display2 = "Please press button" + " F4 " + "TO Exit. " + STRING(TODAY,"99/99/9999")
                       + " " + STRING(TIME,"HH:MM:SS").
        DISP fi_Display fi_Display2 FGCOLOR 6 FONT 6  WITH FRAME fr_main.
        PAUSE 2 NO-MESSAGE.
        IF LASTKEY = KEYCODE("F4") THEN LEAVE loop_job.
       /* NEXT loop_job. */

    END.
     
     /* แสดงข้อมูล Request */
     RUN PDREFEST. /* Open Query */

  END. /*loop_job */

  CLOSE QUERY br_sqm001.
  ASSIGN 
    fi_display  = ""
    fi_display2 = "".
  DISP fi_display fi_display2 WITH FRAME fr_main.

  RELEASE sqm001.
  RELEASE uwm100.
  RELEASE uwm301.
  RELEASE uwd132.
  RELEASE JobQOIC.
  RELEASE EndorseOIC.
  RELEASE PolicyOIC.
  RELEASE Xmm600.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_policy wgwtltgn 
PROCEDURE proc_policy :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR chk_sticker AS CHAR FORMAT "x(15)".
DEF VAR n_nameno AS INTE.

RUN proc_create100.

ASSIGN s_recid1  =  Recid(sic_bran.uwm100).
FIND sicsyac.xmm031 WHERE sicsyac.xmm031.poltyp = wdetail.poltyp  NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL  sicsyac.xmm031 THEN  nv_dept = sicsyac.xmm031.dept.
ASSIGN 
    nv_docno  = "" 
    nv_docno  = wdetail.docno  /*Add by kridtiya i. A57-0391.....*/
    nv_accdat = TODAY.
FIND FIRST brstat.msgcode WHERE 
    brstat.msgcode.compno = "999"   AND
    brstat.msgcode.MsgDesc  = wdetail.tiname   NO-LOCK NO-WAIT NO-ERROR.
IF AVAIL brstat.msgcode THEN  
    ASSIGN wdetail.tiname  =  trim(brstat.msgcode.branch).
ELSE wdetail.tiname = "คุณ".
DO TRANSACTION:
   ASSIGN
      sic_bran.uwm100.renno  = ""
      sic_bran.uwm100.endno  = ""
      sic_bran.uwm100.poltyp = caps(trim(wdetail.poltyp))
      sic_bran.uwm100.insref = ""
      sic_bran.uwm100.opnpol = ""
      sic_bran.uwm100.anam2  = trim(wdetail.Icno)           
      sic_bran.uwm100.ntitle = trim(wdetail.tiname)         
      sic_bran.uwm100.name1  = trim(wdetail.insnam)   
      sic_bran.uwm100.name2  = IF wdetail.delerno = "DEALER" THEN "และ/หรือ" + trim(wdetail.delername) ELSE ""
      sic_bran.uwm100.name3  = ""                 
      sic_bran.uwm100.addr1  = trim(wdetail.add1)  
      sic_bran.uwm100.addr2  = trim(wdetail.tambon)    
      sic_bran.uwm100.addr3  = trim(wdetail.amper)     
      sic_bran.uwm100.addr4  = trim(wdetail.country) 
      sic_bran.uwm100.postcd =  "" 
      sic_bran.uwm100.undyr  = String(Year(today),"9999")   /*   nv_undyr  */
      sic_bran.uwm100.branch = caps(trim(wdetail.branch))   /* nv_branch  */                        
      sic_bran.uwm100.dept   = nv_dept                      
      sic_bran.uwm100.usrid  = USERID(LDBNAME(1))           
      sic_bran.uwm100.fstdat = DATE(wdetail.comdat)         /*TODAY */
      sic_bran.uwm100.comdat = DATE(wdetail.comdat)         
      sic_bran.uwm100.expdat = DATE(wdetail.expdat)         
      sic_bran.uwm100.accdat = nv_accdat                    
      sic_bran.uwm100.tranty = "N"                          /*Transaction Type (N/R/E/C/T)*/
      sic_bran.uwm100.langug = "T"
      sic_bran.uwm100.acctim = "00:00"
      sic_bran.uwm100.trty11 = "M"      
      sic_bran.uwm100.docno1 = STRING(nv_docno,"9999999")     
      sic_bran.uwm100.enttim = STRING(TIME,"HH:MM:SS")
      sic_bran.uwm100.entdat = TODAY
      sic_bran.uwm100.curbil = "BHT"
      sic_bran.uwm100.curate = 1
      sic_bran.uwm100.instot = 1
      sic_bran.uwm100.prog   = "wgwtltgn"
      sic_bran.uwm100.cntry  = "TH"        /*Country where risk is situated*/
      sic_bran.uwm100.insddr = YES         /*Print Insd. Name on DrN       */
      sic_bran.uwm100.no_sch = 0           /*No. to print, Schedule        */
      sic_bran.uwm100.no_dr  = 1           /*No. to print, Dr/Cr Note      */
      sic_bran.uwm100.no_ri  = 0           /*No. to print, RI Appln        */
      sic_bran.uwm100.no_cer = 0           /*No. to print, Certificate     */
      sic_bran.uwm100.li_sch = YES         /*Print Later/Imm., Schedule    */
      sic_bran.uwm100.li_dr  = YES         /*Print Later/Imm., Dr/Cr Note  */
      sic_bran.uwm100.li_ri  = YES         /*Print Later/Imm., RI Appln,   */
      sic_bran.uwm100.li_cer = YES         /*Print Later/Imm., Certificate */
      sic_bran.uwm100.apptax = YES         /*Apply risk level tax (Y/N)    */
      sic_bran.uwm100.recip  = "N"         /*Reciprocal (Y/N/C)            */
      sic_bran.uwm100.short  = NO
      sic_bran.uwm100.acno1  = caps(trim(fi_producer))  /*  nv_acno1 */
      sic_bran.uwm100.agent  = caps(trim(fi_producer))     /*nv_agent   */
      sic_bran.uwm100.insddr = NO
      sic_bran.uwm100.coins  = NO
      sic_bran.uwm100.billco = ""
      sic_bran.uwm100.fptr01 = 0        sic_bran.uwm100.bptr01 = 0
      sic_bran.uwm100.fptr02 = 0        sic_bran.uwm100.bptr02 = 0
      sic_bran.uwm100.fptr03 = 0        sic_bran.uwm100.bptr03 = 0
      sic_bran.uwm100.fptr04 = 0        sic_bran.uwm100.bptr04 = 0
      sic_bran.uwm100.fptr05 = 0        sic_bran.uwm100.bptr05 = 0
      sic_bran.uwm100.fptr06 = 0        sic_bran.uwm100.bptr06 = 0  
      sic_bran.uwm100.styp20 = "NORM"
      sic_bran.uwm100.dir_ri =   YES
      sic_bran.uwm100.drn_p  =  NO
      sic_bran.uwm100.sch_p  =  NO
      sic_bran.uwm100.cr_2   =  ""
      sic_bran.uwm100.bchyr  = nv_batchyr           /*Batch Year */  
      sic_bran.uwm100.bchno  = nv_batchno           /*Batch No.  */  
      sic_bran.uwm100.bchcnt = nv_batcnt            /*Batch Count*/  
      sic_bran.uwm100.prvpol = ""                   /*wdetail.renpol*/       
      sic_bran.uwm100.cedpol = trim(wdetail.cedpol)
      sic_bran.uwm100.bs_cd  = ""                   /*comment kridtiya i. A53-0097 01042010*/
      sic_bran.uwm100.prvpol = ""
      sic_bran.uwm100.polsta = "IF"
      sic_bran.uwm100.trndat = TODAY
      sic_bran.uwm100.issdat = sic_bran.uwm100.trndat. 
      IF wdetail.pass = "Y" THEN
        sic_bran.uwm100.impflg  = YES.
      ELSE 
        sic_bran.uwm100.impflg  = NO.
      IF sic_bran.uwm100.accdat > sic_bran.uwm100.comdat THEN sic_bran.uwm100.accdat = sic_bran.uwm100.comdat.   
      ASSIGN nv_polday  =  IF  (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 365)  OR
                               (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 366)  OR
                               (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 367)  THEN  365 
                           ELSE sic_bran.uwm100.expdat - sic_bran.uwm100.comdat.                    
END. /*transaction*/
/*RUN proc_uwd100. */
/*RUN proc_uwd102.*/
/***************************/
/* --------------------U W M 1 2 0 -------------- */
FIND sic_bran.uwm120 USE-INDEX uwm12001      WHERE
    sic_bran.uwm120.policy  = sic_bran.uwm100.policy AND 
    sic_bran.uwm120.rencnt  = sic_bran.uwm100.rencnt AND 
    sic_bran.uwm120.endcnt  = sic_bran.uwm100.endcnt AND 
    sic_bran.uwm120.riskgp  = s_riskgp               AND 
    sic_bran.uwm120.riskno  = s_riskno               AND       
    sic_bran.uwm120.bchyr   = nv_batchyr             AND 
    sic_bran.uwm120.bchno   = nv_batchno             AND
    sic_bran.uwm120.bchcnt  = nv_batcnt              NO-WAIT NO-ERROR.
IF NOT AVAILABLE sic_bran.uwm120 THEN DO:
    RUN proc_create120.
    /*RUN wgw/wgwad120 (INPUT sic_bran.uwm100.policy,   /***--- A490166 Note Modi ---***/
                      sic_bran.uwm100.rencnt,
                      sic_bran.uwm100.endcnt,
                      s_riskgp,
                      s_riskno,
                      OUTPUT  s_recid2).*/
    FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
END.    /* end not avail  uwm120 */
IF AVAILABLE sic_bran.uwm120 THEN DO:  
    ASSIGN
        sic_bran.uwm120.sicurr = "BHT"
        sic_bran.uwm120.siexch = 1  /*not sure*/
        sic_bran.uwm120.fptr01 = 0               
        sic_bran.uwm120.fptr02 = 0               
        sic_bran.uwm120.fptr03 = 0               
        sic_bran.uwm120.fptr04 = 0               
        sic_bran.uwm120.fptr08 = 0               
        sic_bran.uwm120.fptr09 = 0          
        sic_bran.uwm120.com1ae = YES
        sic_bran.uwm120.stmpae = YES
        sic_bran.uwm120.feeae  = YES
        sic_bran.uwm120.taxae  = YES
        sic_bran.uwm120.bptr01 = 0 
        sic_bran.uwm120.bptr02 = 0 
        sic_bran.uwm120.bptr03 = 0 
        sic_bran.uwm120.bptr04 = 0 
        sic_bran.uwm120.bptr08 = 0 
        sic_bran.uwm120.bptr09 = 0 
        sic_bran.uwm120.bchyr  = nv_batchyr       /* batch Year */
        sic_bran.uwm120.bchno  = nv_batchno       /* bchno      */
        sic_bran.uwm120.bchcnt = nv_batcnt        /* bchcnt     */
        sic_bran.uwm120.class  =  CAPS(wdetail.subclass)
        s_recid2               = RECID(sic_bran.uwm120).
    
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_runbatch wgwtltgn 
PROCEDURE proc_runbatch :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Running Batch  No.      
------------------------------------------------------------------------------*/
DO WITH FRAME fr_main:

      ASSIGN  
          nv_todaydate = TODAY 
          nv_month     = MONTH(nv_befordate)
          nv_batchyr   = YEAR(TODAY) . 

      IF MONTH(nv_todaydate) <> nv_month THEN DO: /* เดือน เปลื่ยน */

         FIND LAST uzm700 USE-INDEX uzm70001  WHERE
                      uzm700.bchyr   = nv_batchyr             AND
                      uzm700.branch  = TRIM(fi_branch)         AND
                      uzm700.acno    = CAPS(TRIM(fi_producer)) NO-LOCK NO-ERROR .
         IF AVAIL uzm700 THEN DO:                /*ได้ running 4 หลักหลัง Branch */
             nv_batrunno = uzm700.runno.  /* last running */
             nv_batchyr  = uzm700.bchyr.
      
             FIND LAST uzm701 USE-INDEX uzm70102     /*Shukiat T. chg Index btm10006 ---> uzm70102 31/10/2006*/
                 WHERE uzm701.bchyr = nv_batchyr         
                 AND   uzm701.bchno = TRIM(fi_producer) + TRIM(fi_branch) + STRING(nv_batrunno,"9999") NO-LOCK NO-ERROR. /* หาว่าเลข batล่าสุดทีคนใช้เป่า */
             IF AVAIL uzm701 THEN    /*ถ้ามีก้อรับค่าเลขเค้าใหม่*/     
                 ASSIGN nv_batcnt   = uzm701.bchcnt 
                        nv_batrunno = nv_batrunno + 1.
         END.
         ELSE DO:  /* ยังไม่เคยมีการนำเข้าข้อมูลสำหรับ Account No. และ Branch นี้ */
               ASSIGN nv_batcnt     = 1
                      nv_batrunno   = 1 .
         END.
      
         nv_batprev = "" .
         RUN proc_batch .

         nv_month = MONTH(nv_todaydate).
         nv_befordate = nv_todaydate.  
         DISP fi_batch  WITH FRAME fr_main.
      END. /* Month */

      ELSE DO: /* Day */

         IF nv_todaydate <> nv_befordate THEN  DO: /* เปลี่ยนวัน */
       
            FIND LAST uzm701 USE-INDEX uzm70102     /*Shukiat T. chg Index btm10006 ---> uzm70102 31/10/2006*/
                    WHERE uzm701.bchyr  = nv_batchyr         
                    AND   uzm701.bchno  = nv_batchno 
                    AND   uzm701.bchcnt = nv_batcnt  NO-LOCK NO-ERROR. /* หาว่าเลข batล่าสุดทีคนใช้เป่า */
            IF AVAIL uzm701 THEN  DO:
              nv_batprev = uzm701.bchno.
              nv_batcnt  = uzm701.bchcnt .
            END.
           
            RUN proc_batch .
            nv_befordate = nv_todaydate.
            DISP fi_batch WITH FRAME fr_main.
          
         END.
         ELSE DO:  /* today = today */

             FIND LAST uzm701 USE-INDEX uzm70102     /*Shukiat T. chg Index btm10006 ---> uzm70102 31/10/2006*/
                    WHERE uzm701.bchyr  = nv_batchyr         
                    AND   uzm701.bchno  = nv_batchno 
                    AND   uzm701.bchcnt = nv_batcnt  NO-LOCK NO-ERROR. /* หาว่าเลข batล่าสุดทีคนใช้เป่า */
             IF AVAIL uzm701 THEN  DO:
                 fi_batch = uzm701.bchno + "." + string(uzm701.bchcnt,"99").
             END.
             ELSE DO: /* first */

                 FIND LAST uzm700 USE-INDEX uzm70001  WHERE
                      uzm700.bchyr   = nv_batchyr              AND
                      uzm700.branch  = TRIM(fi_branch)         AND
                      uzm700.acno    = CAPS(TRIM(fi_producer)) NO-LOCK NO-ERROR .
                 IF AVAIL uzm700 THEN DO:                /*ได้ running 4 หลักหลัง Branch */
                     nv_batrunno = uzm700.runno.  /* last running */
                 
                     FIND LAST uzm701 USE-INDEX uzm70102     /*Shukiat T. chg Index btm10006 ---> uzm70102 31/10/2006*/
                         WHERE uzm701.bchyr = nv_batchyr         
                         AND   uzm701.bchno = TRIM(fi_producer) + TRIM(fi_branch) + STRING(nv_batrunno,"9999") NO-LOCK NO-ERROR. /* หาว่าเลข batล่าสุดทีคนใช้เป่า */                           IF AVAIL uzm701 THEN    /*ถ้ามีก้อรับค่าเลขเค้าใหม่*/     
                         ASSIGN nv_batcnt = uzm701.bchcnt 
                                nv_batrunno = nv_batrunno + 1.
                 END.
                 ELSE DO:  /* ยังไม่เคยมีการนำเข้าข้อมูลสำหรับ Account No. และ Branch นี้ */
                       ASSIGN nv_batcnt  = 1
                              nv_batrunno   = 1 .
                 END.
                 RUN proc_batch .

             END.
             DISP fi_batch WITH FRAME fr_main.
          END. /* today = today */
          
      END. /* Day */
      /*--------------- Run Batch ----------------*/
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_var wgwtltgn 
PROCEDURE proc_var :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
    /* nv_camptyp =  "NORM"*/
    s_riskgp   =   0                     s_riskno       =  1
    s_itemno   =   1                     nv_undyr       =    String(Year(today),"9999")   
    n_rencnt   =   0                     n_endcnt       =  0.
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_wgw72013 wgwtltgn 
PROCEDURE proc_wgw72013 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT        PARAMETER  nv_rec100  AS RECID     NO-UNDO.
DEFINE INPUT        PARAMETER  nv_red132  AS RECID     NO-UNDO.
DEFINE INPUT        PARAMETER  nvtariff   AS CHARACTER NO-UNDO.
DEF            VAR n_dcover   AS   INT FORMAT "99999" INITIAL[0].
DEF            VAR n_dyear    AS   INT FORMAT "99999" INITIAL[0].
DEF            VAR nvyear     AS   INT FORMAT "99999" INITIAL[0].
DEF            VAR n_day1     AS   INT FORMAT "99"    INITIAL[31].
DEF            VAR n_mon1     AS   INT FORMAT "99"    INITIAL[12].
DEF            VAR n_ddyr     AS   INT FORMAT "9999"  INITIAL[0].
DEF            VAR n_ddyr1    AS   INT FORMAT "9999"  INITIAL[0].
DEF            VAR n_dmonth   AS   INT FORMAT "99999" INITIAL[0].
DEF            VAR n_orgnap   LIKE sic_bran.uwd132.gap_c  NO-UNDO.
DEF            VAR s_curbil   LIKE sic_bran.uwm100.curbil NO-UNDO.
def              var  n_total   as deci  no-undo.
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) EQ nv_rec100 NO-WAIT NO-ERROR.
FIND sic_bran.uwd132 WHERE RECID(sic_bran.uwd132) EQ nv_red132 NO-WAIT NO-ERROR.
s_curbil = sic_bran.uwm100.curbil.
n_orgnap = sic_bran.uwd132.gap_c.
IF sic_bran.uwm100.expdat EQ ? OR  sic_bran.uwm100.comdat EQ ? THEN sic_bran.uwd132.prem_c = n_orgnap.
IF nvtariff = "Z" OR nvtariff = "X" THEN DO:
   sic_bran.uwd132.prem_c = n_orgnap.
END.
ELSE DO:
  IF sic_bran.uwm100.expdat NE ? AND sic_bran.uwm100.comdat NE ? THEN DO:
    ASSIGN n_dcover = 0
           n_dyear  = 0
           nvyear   = 0
           n_dmonth = 0.
                IF ( DAY(sic_bran.uwm100.comdat)     =   DAY(sic_bran.uwm100.expdat)    AND
                   MONTH(sic_bran.uwm100.comdat)     = MONTH(sic_bran.uwm100.expdat)    AND
                    YEAR(sic_bran.uwm100.comdat) + 1 =  YEAR(sic_bran.uwm100.expdat) )  OR
                   ( DAY(sic_bran.uwm100.comdat)     =   29                             AND
                   MONTH(sic_bran.uwm100.comdat)     =   02                             AND
                     DAY(sic_bran.uwm100.expdat)     =   01                             AND
                   MONTH(sic_bran.uwm100.expdat)     =   03                             AND
                    YEAR(sic_bran.uwm100.comdat) + 1 =  YEAR(sic_bran.uwm100.expdat) )
                THEN DO:
                  n_dcover = 365.
                END.
                ELSE DO:
                  n_dcover = (sic_bran.uwm100.expdat  - sic_bran.uwm100.comdat ) + 1 .     /*    =  366  วัน */
                END.
    FIND sicsyac.xmm031 USE-INDEX xmm03101 WHERE
         sicsyac.xmm031.poltyp EQ sic_bran.uwm100.poltyp
    NO-LOCK NO-ERROR.
    IF AVAILABLE sicsyac.xmm031 THEN DO:
       IF n_dcover = 365  THEN   
      n_ddyr   = YEAR(TODAY).
      n_ddyr1  = n_ddyr + 1.
      n_dyear  = 365.   
      FIND sicsyac.xmm105 USE-INDEX xmm10501      WHERE
           sicsyac.xmm105.tariff EQ nvtariff      AND
           sicsyac.xmm105.bencod EQ sic_bran.uwd132.bencod
      NO-LOCK NO-ERROR.
      IF  sic_bran.uwm100.short = NO OR sicsyac.xmm105.shorta = NO THEN DO:
          sic_bran.uwd132.prem_c = (n_orgnap * n_dcover) / n_dyear .  
      END.
      ELSE DO:
        FIND FIRST sicsyac.xmm127 USE-INDEX xmm12701     WHERE
                   sicsyac.xmm127.poltyp =  sic_bran.uwm100.poltyp AND
                   sicsyac.xmm127.daymth =  YES                    AND
                   sicsyac.xmm127.nodays GE n_dcover
        NO-LOCK NO-ERROR.
        IF AVAILABLE sicsyac.xmm127 THEN DO:
           sic_bran.uwd132.prem_c =  (n_orgnap * sicsyac.xmm127.short) / 100 .
        END.
        ELSE DO:
          IF YEAR(sic_bran.uwm100.expdat) <> YEAR(sic_bran.uwm100.comdat) THEN DO:
            nvyear = YEAR(sic_bran.uwm100.expdat) - YEAR(sic_bran.uwm100.comdat).
            IF nvyear > 1 THEN
               n_dmonth = (12 - MONTH(sic_bran.uwm100.comdat) +
                                MONTH(sic_bran.uwm100.expdat) + 1) + ((nvyear - 1) * 12).
            ELSE
               n_dmonth =  12 - MONTH(sic_bran.uwm100.comdat) +
                                MONTH(sic_bran.uwm100.expdat) + 1.
          END.
          ELSE n_dmonth = MONTH(sic_bran.uwm100.expdat) - MONTH(sic_bran.uwm100.comdat) + 1.
          FIND FIRST sicsyac.xmm127 USE-INDEX xmm12701      WHERE
                     sicsyac.xmm127.poltyp =  sic_bran.uwm100.poltyp AND
                     sicsyac.xmm127.daymth =  NO            AND
                     sicsyac.xmm127.nodays GE n_dmonth
          NO-LOCK NO-ERROR.
          IF AVAILABLE xmm127 THEN DO:
             sic_bran.uwd132.prem_c = (n_orgnap * sicsyac.xmm127.short) / 100.
             HIDE MESSAGE NO-PAUSE.
             
             PAUSE.
          END.
          ELSE DO:
             sic_bran.uwd132.prem_c =  (n_orgnap * n_dcover) / n_dyear.
          END.

        END.
      END.
      IF s_curbil = "BHT" THEN  sic_bran.uwd132.prem_c = sic_bran.uwd132.prem_c.
    END.
  END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

