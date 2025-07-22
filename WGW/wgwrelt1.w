&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
*/
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*************************************************************************
 WRSQReqP.W  : Query Policy Motor & CMI
 Copyright   : Safety Insurance Public Company Limited
              บริษัท ประกันคุ้มภัย จำกัด (มหาชน)
 CREATE BY   :  
  
 Database    : BUInt
 CREATE BY  : kridtiya i. A61-0482 Date. 08/10/2018 โปรแกรม สำหรับ เรียกรายงานกรมธรรม์
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

/* Local Variable Definitions ---                                       */
DEFINE VARIABLE nv_rec_rq          AS RECID     NO-UNDO.  /* RECORD ID REQUEST */
DEFINE VARIABLE nv_rec_rs          AS RECID     NO-UNDO.  /* RECORD ID RESPONSE */
DEFINE VARIABLE nv_InsurerCode     AS CHARACTER FORMAT "X(10)" INITIAL "" NO-UNDO.
DEFINE VARIABLE nv_FRequestorRs    AS CHARACTER INITIAL "" NO-UNDO.
DEFINE VARIABLE nv_TRequestorRs    AS CHARACTER INITIAL "" NO-UNDO.
DEFINE VARIABLE nv_FByUserID       AS CHARACTER INITIAL "" NO-UNDO.
DEFINE VARIABLE nv_TByUserID       AS CHARACTER INITIAL "" NO-UNDO.
DEFINE VARIABLE nv_FMsgStatus      AS CHARACTER INITIAL "" NO-UNDO.
DEFINE VARIABLE nv_TMsgStatus      AS CHARACTER INITIAL "" NO-UNDO.
DEFINE VARIABLE nv_SelectPrn       AS INTEGER   NO-UNDO.
DEFINE VARIABLE nv_printer         AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_CPrn            AS INTEGER   NO-UNDO.
DEFINE VARIABLE nv_Search          AS INTEGER   NO-UNDO.
DEFINE VARIABLE nv_Sort            AS INTEGER   NO-UNDO.
DEFINE VARIABLE nv_CheckFile       AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_SearchDrive     AS CHARACTER FORMAT "X(10)"  NO-UNDO.
DEFINE VARIABLE nv_SearchName      AS CHARACTER FORMAT "X(50)"  NO-UNDO.
DEFINE VARIABLE nv_color           AS INTEGER   NO-UNDO.
DEFINE STREAM xmlstream.
/* -------------------------------------------------------------------- */
/* ใช้ที่ File WRQHqKK.W, WRQHqK1e.P */

DEFINE NEW SHARED TEMP-TABLE  LoadFile   NO-UNDO
FIELD RecSelect               AS CHARACTER FORMAT "xx"         INITIAL "" /*Record Select*/
FIELD Seqno                   AS INTEGER   FORMAT "9999999"    INITIAL 0
FIELD MsgStatusCd             AS CHARACTER FORMAT "X(03)"      INITIAL "" /*"Msg"*/
FIELD GenSicBran              AS LOGICAL                       INITIAL NO
FIELD ConfirmBy               AS CHARACTER FORMAT "x(5)"       INITIAL ""
FIELD PolicyNumber            AS CHARACTER FORMAT "x(16)"      INITIAL ""
FIELD AppendNumber            AS CHARACTER FORMAT "x(16)"      INITIAL ""
FIELD ContractNumber          AS CHARACTER FORMAT "x(20)"      INITIAL ""
FIELD DocumentUID             AS CHARACTER FORMAT "X(10)"      INITIAL ""
FIELD EffectiveDt             AS DATE      FORMAT "99/99/9999" INITIAL ?
FIELD ExpirationDt            AS DATE      FORMAT "99/99/9999" INITIAL ?
FIELD PolicyTypeCd            AS CHARACTER FORMAT "x(5)"       INITIAL ""
FIELD RateGroup               AS CHARACTER FORMAT "x(4)"       INITIAL ""
FIELD Registration            AS CHARACTER FORMAT "x(20)"      INITIAL ""
FIELD vehregF                 AS CHARACTER FORMAT "x(15)"      INITIAL ""
FIELD Manufacturer            AS CHARACTER FORMAT "x(20)"      INITIAL ""
FIELD ChassisVINNumber        AS CHARACTER FORMAT "x(30)"      INITIAL ""
FIELD InsuredName             AS CHARACTER FORMAT "x(150)"      INITIAL ""
FIELD CMIPolicyTypeCd         AS CHARACTER FORMAT "X(4)"       INITIAL ""
FIELD CMIVehTypeCd            AS CHARACTER FORMAT "X(4)"       INITIAL "" 
FIELD CMIPolicyNumber         AS CHARACTER FORMAT "X(16)"      INITIAL ""
FIELD CMIDocumentUID          AS CHARACTER FORMAT "X(10)"      INITIAL ""
FIELD CMIBarCodeNumber        AS CHARACTER FORMAT "X(15)"      INITIAL ""
FIELD CMIComDate              AS DATE      FORMAT "99/99/9999" INITIAL ?
FIELD CMIExpDate              AS DATE      FORMAT "99/99/9999" INITIAL ?
FIELD ProcessDate             AS DATE      FORMAT "99/99/9999" INITIAL ?
FIELD ProcessTime             AS CHARACTER FORMAT "x(8)"       INITIAL ""
FIELD TEMPRecID               AS RECID
FIELD Sch_P                   AS LOGICAL
FIELD COUNT_no                AS INTEGER   FORMAT "9999999"     INITIAL 0   
FIELD ReceiptNumber           AS CHARACTER FORMAT "X(15)"       INITIAL ""  
FIELD COLLAmtAccident         AS INTEGER   FORMAT ">>>,>>>,>>9" INITIAL 0 
FIELD EndorseFlag             AS CHARACTER FORMAT "X(16)"       INITIAL ""
FIELD SCLASS                  AS CHARACTER FORMAT "X(5)"        INITIAL ""  
FIELD premt                   AS INTEGER   FORMAT ">>>,>>>,>>9" INITIAL 0 
FIELD BranchCd                AS CHARACTER FORMAT "X(16)"       INITIAL ""
FIELD InsuranceBranchCd       AS CHARACTER FORMAT "X(10)"       INITIAL ""
FIELD PreviousPolicyNumber    AS CHARACTER FORMAT "X(20)"       INITIAL ""
FIELD OptionValueDesc         AS CHARACTER FORMAT "X(150)"      INITIAL ""
FIELD Agentno                 AS CHARACTER FORMAT "X(15)"       INITIAL ""
FIELD FileNameAttach1         AS CHARACTER FORMAT "X(150)"      INITIAL ""
FIELD FileNameAttach2         AS CHARACTER FORMAT "X(150)"      INITIAL ""
FIELD FileNameAttach3         AS CHARACTER FORMAT "X(150)"      INITIAL ""
FIELD AttachFile1             AS BLOB 
FIELD AttachFile2             AS BLOB 
FIELD AttachFile3             AS BLOB 
INDEX LoadFile01  IS PRIMARY  ProcessDate      ASCENDING 
                              ProcessTime      ASCENDING
INDEX LoadFile02              PolicyNumber     ASCENDING
INDEX LoadFile03              Registration     ASCENDING
INDEX LoadFile04              PolicyTypeCd     ASCENDING
                              RateGroup        ASCENDING
                              PolicyNumber     ASCENDING
INDEX LoadFile05              ConfirmBy        ASCENDING
                              PolicyNumber     ASCENDING
.
/*DESCENDING.*/

DEFINE NEW SHARED TEMP-TABLE ctemp NO-UNDO
  FIELD dirtext         AS CHARACTER FORMAT "X(100)"  INITIAL ""
.
DEFINE NEW SHARED TEMP-TABLE cdir  NO-UNDO
  FIELD DirName         AS CHARACTER FORMAT "X(150)"  INITIAL ""
  FIELD FilNAME         AS CHARACTER FORMAT "X(50)"   INITIAL ""
  FIELD UseFileName     AS CHARACTER FORMAT "X(200)"  INITIAL ""
.
DEFINE VAR  nv_COUNT_no AS INTEGER   FORMAT "9999999"    INITIAL 0.   
DEFINE STREAM  ns2.
DEF VAR   nv_cnt   as  int  init   1.
DEF VAR   nv_row   as  int  init   0.
DEF VAR   n_record AS  INTE INIT   0.
/* -------------------------------------------------------------------- */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main
&Scoped-define BROWSE-NAME br_Query

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES LoadFile

/* Definitions for BROWSE br_Query                                      */
&Scoped-define FIELDS-IN-QUERY-br_Query /**/ LoadFile.Seqno LoadFile.ProcessDate LoadFile.ProcessTime LoadFile.ConfirmBy LoadFile.PolicyTypeCd LoadFile.RateGroup /* LoadFile.CMIPolicyTypeCd LoadFile.CMIVehTypeCd */ /**/ LoadFile.GenSicBran LoadFile.PolicyNumber LoadFile.ContractNumber LoadFile.EffectiveDt LoadFile.ExpirationDt LoadFile.Sch_P LoadFile.DocumentUID LoadFile.CMIBarcodeNumber /* LoadFile.AppendNumber */ LoadFile.Registration LoadFile.Manufacturer /**/ /**/ LoadFile.EndorseFlag LoadFile.ReceiptNumber LoadFile.COLLAmtAccident /**/ LoadFile.InsuredName /**/ LoadFile.AppendNumber LoadFile.CMIPolicyNumber /**/ /* LoadFile.CMIDocumentUID LoadFile.CMIComDate LoadFile.CMIExpDate */ /* ------------------------------------------------------------------------ */   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_Query   
&Scoped-define SELF-NAME br_Query
&Scoped-define OPEN-QUERY-br_Query /**/ /* --------------------------------------------------- */  RUN PD_Display. /* ******************************************************** CASE nv_Sort:    WHEN 1 THEN DO:  /*CLAIM*/     OPEN QUERY  {&SELF-NAME}     FOR EACH  LoadFile USE-INDEX LoadFile01     NO-LOCK.   END.   WHEN 2 THEN DO:   /*POLICY*/      OPEN QUERY {&SELF-NAME}     FOR EACH  LoadFile USE-INDEX LoadFile02     NO-LOCK.   END.    WHEN 3 THEN DO:  /*ตามวันที่*/      OPEN QUERY {&SELF-NAME}     FOR EACH  LoadFile USE-INDEX LoadFile03     NO-LOCK.   END.    WHEN 4 THEN DO:  /*Registration*/      OPEN QUERY {&SELF-NAME}     FOR EACH  LoadFile USE-INDEX LoadFile04     NO-LOCK.   END.  END CASE. ******************************************************** */ /* --------------------------------------------------- */.
&Scoped-define TABLES-IN-QUERY-br_Query LoadFile
&Scoped-define FIRST-TABLE-IN-QUERY-br_Query LoadFile


/* Definitions for FRAME fr_main                                        */
&Scoped-define OPEN-BROWSERS-IN-QUERY-fr_main ~
    ~{&OPEN-QUERY-br_Query}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS ra_type bu_exp fi_outputfile fi_RequestorRs ~
cb_Search fi_From fi_To fi_DateFrom fi_notfound fi_DateTo cb_Sort fi_AcroRd ~
buOK fi_Success buCANCEL br_Query RECT-9 
&Scoped-Define DISPLAYED-OBJECTS ra_type fi_outputfile fi_RequestorRs ~
cb_Search fi_From fi_To fi_DateFrom fi_notfound fi_DateTo cb_Sort fi_AcroRd ~
fi_Success 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON buCANCEL 
     LABEL "Cancel" 
     SIZE 10 BY 1.19
     FONT 6.

DEFINE BUTTON buOK 
     LABEL "OK" 
     SIZE 10 BY 1.19
     FONT 6.

DEFINE BUTTON bu_exp 
     LABEL "EXPORT" 
     SIZE 8.5 BY 1.

DEFINE VARIABLE cb_Search AS CHARACTER FORMAT "X(256)":U 
     LABEL "เลือกรายการค้นหา" 
     VIEW-AS COMBO-BOX INNER-LINES 10
     LIST-ITEMS "Process Date","Policy Number","Registration","Policy Type","Confirm By","ContractNumber","InsuredName","InsuredSurname","DocumentUID","StickerNo" 
     DROP-DOWN-LIST
     SIZE 30 BY 1 NO-UNDO.

DEFINE VARIABLE cb_Sort AS CHARACTER FORMAT "X(256)":U 
     LABEL "จัดเรียงรายการค้นหา ตาม" 
     VIEW-AS COMBO-BOX INNER-LINES 6
     LIST-ITEMS "Process Date","Policy Number","Registration","Policy Type","Confirm By","Registration_Dup" 
     DROP-DOWN-LIST
     SIZE 30 BY 1 NO-UNDO.

DEFINE VARIABLE fi_AcroRd AS LOGICAL FORMAT "yes/no":U INITIAL NO 
     LABEL "Create New file AcroRd temp" 
     VIEW-AS FILL-IN 
     SIZE 5 BY .81
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_DateFrom AS DATE FORMAT "99/99/9999":U 
     LABEL "วันที่ เริ่มต้นจาก" 
     VIEW-AS FILL-IN 
     SIZE 14 BY .81
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_DateTo AS DATE FORMAT "99/99/9999":U 
     LABEL "ถึงวันที่ สิ้นสุด" 
     VIEW-AS FILL-IN 
     SIZE 14 BY .81
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_From AS CHARACTER FORMAT "X(25)":U 
     LABEL "ระบุข้อมูล เริ่มต้นจาก" 
     VIEW-AS FILL-IN 
     SIZE 30 BY .81
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_notfound AS CHARACTER FORMAT "X(45)":U 
      VIEW-AS TEXT 
     SIZE 35 BY .71
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_outputfile AS CHARACTER FORMAT "X(256)":U 
     LABEL "Out Put File" 
     VIEW-AS FILL-IN 
     SIZE 65 BY .95 NO-UNDO.

DEFINE VARIABLE fi_RequestorRs AS CHARACTER FORMAT "X(15)":U 
     LABEL "รหัสบริษัท (Agent/Broker)" 
     VIEW-AS FILL-IN 
     SIZE 15 BY .81
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_Success AS INTEGER FORMAT ">>>>,>>9":U INITIAL 0 
     LABEL "Success" 
      VIEW-AS TEXT 
     SIZE 10 BY .71
     BGCOLOR 15 FGCOLOR 5 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_To AS CHARACTER FORMAT "X(25)":U 
     LABEL "ถึงข้อมูล สิ้นสุด" 
     VIEW-AS FILL-IN 
     SIZE 30 BY .81
     FONT 6 NO-UNDO.

DEFINE VARIABLE ra_type AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "ประเภท 1 2 3 2+ 3+", 1,
"พรบ.", 2
     SIZE 30 BY .95
     BGCOLOR 18 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-8
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 131 BY 1.05
     BGCOLOR 3 FGCOLOR 15 .

DEFINE RECTANGLE RECT-9
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE .83 BY 4
     BGCOLOR 3 FGCOLOR 3 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_Query FOR 
      LoadFile SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_Query
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_Query C-Win _FREEFORM
  QUERY br_Query DISPLAY
      /**/
LoadFile.Seqno             COLUMN-LABEL "Seqno"     FORMAT ">>>>>9"
LoadFile.ProcessDate       COLUMN-LABEL "ProcDate"  FORMAT "99/99/9999"
LoadFile.ProcessTime       COLUMN-LABEL "ProcTime"  FORMAT "X(8)"
LoadFile.ConfirmBy         COLUMN-LABEL "Appv"      FORMAT "x(5)"
LoadFile.PolicyTypeCd      COLUMN-LABEL "PolTyp"    FORMAT "x(4)"
LoadFile.RateGroup         COLUMN-LABEL "CovTyp"    FORMAT "x(4)"
/*
LoadFile.CMIPolicyTypeCd   COLUMN-LABEL "PTyp72"    FORMAT "X(4)"
LoadFile.CMIVehTypeCd      COLUMN-LABEL "CTyp72"    FORMAT "X(4)"
*/
/**/
LoadFile.GenSicBran        COLUMN-LABEL "Create"
LoadFile.PolicyNumber      COLUMN-LABEL "Policy Number"     FORMAT "x(14)"
LoadFile.ContractNumber    COLUMN-LABEL "Contract Number"   FORMAT "x(16)"
LoadFile.EffectiveDt       COLUMN-LABEL "ComDate"           FORMAT "99/99/9999"
LoadFile.ExpirationDt      COLUMN-LABEL "ExtDate"           FORMAT "99/99/9999"
LoadFile.Sch_P             COLUMN-LABEL "Prn"
LoadFile.DocumentUID       COLUMN-LABEL "Doc.No."           FORMAT "X(8)"
LoadFile.CMIBarcodeNumber  COLUMN-LABEL "Sticker พรบ."      FORMAT "X(14)"
/*
LoadFile.AppendNumber      COLUMN-LABEL "Append Number"     FORMAT "x(16)"
*/
LoadFile.Registration      COLUMN-LABEL "กท.รถ"  FORMAT "x(11)"
LoadFile.Manufacturer      COLUMN-LABEL "ยี่ห้อ" FORMAT "x(13)"
/**/
/**/
LoadFile.EndorseFlag       COLUMN-LABEL "Product."      FORMAT "x(10)"
LoadFile.ReceiptNumber     COLUMN-LABEL "Prom/Camp no." FORMAT "x(16)"
LoadFile.COLLAmtAccident   COLUMN-LABEL "COLL Amt.Acc."
/**/
LoadFile.InsuredName       COLUMN-LABEL "Insured Name" FORMAT "x(20)"
/**/
LoadFile.AppendNumber      COLUMN-LABEL "Append Number"     FORMAT "x(16)"
LoadFile.CMIPolicyNumber   COLUMN-LABEL "Policy Number 72"  FORMAT "X(16)"
/**/
/*
LoadFile.CMIDocumentUID    COLUMN-LABEL "Doc.Pol72"  FORMAT "X(10)"
LoadFile.CMIComDate        COLUMN-LABEL "ComDate72"  FORMAT "99/99/9999"
LoadFile.CMIExpDate        COLUMN-LABEL "ExtDate72"  FORMAT "99/99/9999"
*/
/* ------------------------------------------------------------------------ */
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 128.5 BY 13.33
         BGCOLOR 15 FGCOLOR 1 
         TITLE BGCOLOR 15 FGCOLOR 1 "Query Policy Motor, CMI" ROW-HEIGHT-CHARS .7.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     ra_type AT ROW 6.14 COL 24.5 NO-LABEL WIDGET-ID 144
     bu_exp AT ROW 8.29 COL 92.5 WIDGET-ID 136
     fi_outputfile AT ROW 8.38 COL 23 COLON-ALIGNED WIDGET-ID 134
     fi_RequestorRs AT ROW 2.19 COL 23 COLON-ALIGNED WIDGET-ID 28
     cb_Search AT ROW 3.1 COL 23 COLON-ALIGNED WIDGET-ID 116
     fi_From AT ROW 4.19 COL 23 COLON-ALIGNED WIDGET-ID 122
     fi_To AT ROW 4.19 COL 67.17 COLON-ALIGNED WIDGET-ID 124
     fi_DateFrom AT ROW 5.14 COL 23 COLON-ALIGNED WIDGET-ID 118
     fi_notfound AT ROW 7.24 COL 80.33 NO-LABEL WIDGET-ID 24
     fi_DateTo AT ROW 5.14 COL 67.17 COLON-ALIGNED WIDGET-ID 120
     cb_Sort AT ROW 7.24 COL 23 COLON-ALIGNED WIDGET-ID 126
     fi_AcroRd AT ROW 9.48 COL 23 COLON-ALIGNED WIDGET-ID 132
     buOK AT ROW 3.62 COL 118.67 WIDGET-ID 10
     fi_Success AT ROW 7.24 COL 67.17 COLON-ALIGNED WIDGET-ID 80
     buCANCEL AT ROW 5.19 COL 118.67 WIDGET-ID 12
     br_Query AT ROW 10.52 COL 1.67 WIDGET-ID 200
     "Query Policy Motor" VIEW-AS TEXT
          SIZE 19 BY .81 AT ROW 1.14 COL 110.67 WIDGET-ID 74
          BGCOLOR 3 FGCOLOR 15 FONT 6
     "ข้อมูล Database BUSINESS" VIEW-AS TEXT
          SIZE 31 BY .81 AT ROW 1.14 COL 2.17 WIDGET-ID 78
          BGCOLOR 3 FGCOLOR 15 FONT 6
     "" VIEW-AS TEXT
          SIZE 74 BY .81 AT ROW 9.48 COL 30.83 WIDGET-ID 128
          BGCOLOR 15 FGCOLOR 0 
     "date 11/10/2018" VIEW-AS TEXT
          SIZE 18.5 BY .81 AT ROW 9.48 COL 109.67 WIDGET-ID 138
     "ตัวอย่าง D:~\Temp~\Exp20181004" VIEW-AS TEXT
          SIZE 28.5 BY 1.19 AT ROW 8.14 COL 101.83 WIDGET-ID 148
          FGCOLOR 12 FONT 4
     RECT-8 AT ROW 1 COL 1 WIDGET-ID 76
     RECT-9 AT ROW 2.95 COL 116.33 WIDGET-ID 92
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 131.5 BY 23
         BGCOLOR 8  DROP-TARGET WIDGET-ID 100.


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
         TITLE              = "Safety Insurance Public Company Limited"
         HEIGHT             = 22.91
         WIDTH              = 131.5
         MAX-HEIGHT         = 44.48
         MAX-WIDTH          = 213.33
         VIRTUAL-HEIGHT     = 44.48
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
IF NOT C-Win:LOAD-ICON("WIMAGE/safety.ico":U) THEN
    MESSAGE "Unable to load icon: WIMAGE/safety.ico"
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
/* BROWSE-TAB br_Query buCANCEL fr_main */
/* SETTINGS FOR FILL-IN fi_notfound IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR RECTANGLE RECT-8 IN FRAME fr_main
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_Query
/* Query rebuild information for BROWSE br_Query
     _START_FREEFORM
/**/
/* --------------------------------------------------- */

RUN PD_Display.
/* ********************************************************
CASE nv_Sort:

  WHEN 1 THEN DO:  /*CLAIM*/
    OPEN QUERY  {&SELF-NAME}
    FOR EACH  LoadFile USE-INDEX LoadFile01
    NO-LOCK.
  END.
  WHEN 2 THEN DO:   /*POLICY*/

    OPEN QUERY {&SELF-NAME}
    FOR EACH  LoadFile USE-INDEX LoadFile02
    NO-LOCK.
  END.

  WHEN 3 THEN DO:  /*ตามวันที่*/

    OPEN QUERY {&SELF-NAME}
    FOR EACH  LoadFile USE-INDEX LoadFile03
    NO-LOCK.
  END.

  WHEN 4 THEN DO:  /*Registration*/

    OPEN QUERY {&SELF-NAME}
    FOR EACH  LoadFile USE-INDEX LoadFile04
    NO-LOCK.
  END.

END CASE.
******************************************************** */
/* --------------------------------------------------- */
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE br_Query */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Safety Insurance Public Company Limited */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Safety Insurance Public Company Limited */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_Query
&Scoped-define SELF-NAME br_Query
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_Query C-Win
ON MOUSE-SELECT-DBLCLICK OF br_Query IN FRAME fr_main /* Query Policy Motor, CMI */
DO:
/* */

  RUN PD_Select.

  APPLY "ENTRY" TO br_Query.
  RETURN NO-APPLY.
  /* ****************************************************************************
  DEFINE   Var     nv_line      As Int.
  DEFINE   Var     nv_Row       As Recid.
  DEFINE   Var     nv_LClaim    As CHARACTER.
  DEFINE   Var     nv_FClaim    As CHARACTER.

  IF NOT AVAILABLE LoadFile THEN RETURN.

  /* --------------------------------------------- */
  nv_rec_rq = 0.
  nv_rec_rq = LoadFile.RecIDRequest.
  /* */

  IF nv_rec_rq = 0 OR nv_rec_rq = ? THEN RETURN.

  FIND RCVRqH01 WHERE RECID(RCVRqH01) = nv_rec_rq
  NO-LOCK NO-ERROR NO-WAIT.
  IF AVAILABLE RCVRqH01 THEN DO:

    C-WIn:Hidden = Yes. /* ซ้อนโปรแกรมตัวเอง */

    RUN WRQ/WRQFTM11 (INPUT RECID(RCVRqH01), "ADD/UPDATE").   /* Update Data*/

    C-WIn:Hidden = NO.  /* กลับมาแสดงโปรแกรมตัวเองต่อ*/
  END.

  nv_LClaim = "".
  nv_FClaim = "".
  nv_LClaim = LoadFile.FTMClaim.
  /* */
  nv_row  = Recid(LoadFile).
  nv_line = br_Query:focused-row in frame {&FRAME-NAME}.
  /* */
  FIND FIRST FastTrack10 WHERE 
             FastTrack10.ClaimOccurrenceRq = RCVRqH01.ClaimOccurrenceRq 
  NO-LOCK NO-ERROR NO-WAIT.
  IF AVAILABLE FastTrack10 THEN nv_FClaim = FastTrack10.ClaimOccurrenceRq.

  IF nv_LClaim <> nv_FClaim THEN DO:

    FIND FIRST FastTrack10 WHERE 
               FastTrack10.ClaimOccurrenceRq = RCVRqH01.ClaimOccurrenceRq 
    NO-LOCK NO-ERROR NO-WAIT.
    IF AVAILABLE FastTrack10 THEN DO:

      FOR EACH LoadFile USE-INDEX LoadFile02 WHERE
               LoadFile.ClaimOccurrenceRq = RCVRqH01.ClaimOccurrenceRq
      :
        ASSIGN                  
        LoadFile.FTMEntryTime = FastTrack10.EntryTime
        LoadFile.FTMEntryDt   = FastTrack10.EntryDt
        LoadFile.FTMClaim     = FastTrack10.ClaimOccurrenceRq.
      END.
    END.
    ELSE DO:

      FOR EACH LoadFile USE-INDEX LoadFile02 WHERE
               LoadFile.ClaimOccurrenceRq = RCVRqH01.ClaimOccurrenceRq
      :
        ASSIGN                  
        LoadFile.FTMEntryTime = ""
        LoadFile.FTMEntryDt   = ?
        LoadFile.FTMClaim     = "".
      END.
    END.
    /* */
    br_Query:Set-Repositioned-row(nv_line,"always") In Frame {&FRAME-NAME}.

    {&OPEN-QUERY-br_Query}

    Reposition br_Query To  Recid(nv_row).
    /* */
  END.
  **************************************************************************** */
/* */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_Query C-Win
ON RETURN OF br_Query IN FRAME fr_main /* Query Policy Motor, CMI */
DO:
/**/

  RUN PD_Select.

  APPLY "ENTRY" TO br_Query.
  RETURN NO-APPLY.
/**/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_Query C-Win
ON ROW-DISPLAY OF br_Query IN FRAME fr_main /* Query Policy Motor, CMI */
DO:
IF LoadFile.GenSicBran = YES THEN DO:
    nv_color = 1.

    LoadFile.GenSicBran :FGCOLOR IN BROWSE br_Query = 5 NO-ERROR.
    /* ----
    LoadFile.Seqno          :FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    LoadFile.ProcessDate    :FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    LoadFile.ProcessTime    :FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    LoadFile.ConfirmBy      :FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    LoadFile.PolicyTypeCd   :FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    LoadFile.RateGroup      :FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    LoadFile.PolicyNumber   :FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    LoadFile.AppendNumber   :FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    LoadFile.ContractNumber :FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    LoadFile.DocumentUID    :FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    LoadFile.EffectiveDt    :FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    LoadFile.ExpirationDt   :FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    LoadFile.Registration   :FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    LoadFile.Manufacturer   :FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    LoadFile.InsuredName    :FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    LoadFile.CMIPolicyNumber:FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    LoadFile.CMIBarcodeNumber:FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    ------- */
    /*
    LoadFile.CMIPolicyTypeCd:FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    LoadFile.CMIVehTypeCd   :FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR. 
    LoadFile.CMIDocumentUID :FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    LoadFile.CMIComDate     :FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    LoadFile.CMIExpDate     :FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    */

END.
ELSE DO:
    nv_color = 4.

    LoadFile.GenSicBran :FGCOLOR IN BROWSE br_Query = 4 NO-ERROR.
END.

    LoadFile.Seqno          :FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    LoadFile.ProcessDate    :FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    LoadFile.ProcessTime    :FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    LoadFile.ConfirmBy      :FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    LoadFile.PolicyTypeCd   :FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    LoadFile.RateGroup      :FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    LoadFile.PolicyNumber   :FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    LoadFile.ContractNumber :FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    LoadFile.DocumentUID    :FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    LoadFile.EffectiveDt    :FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    LoadFile.ExpirationDt   :FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    LoadFile.Registration   :FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    LoadFile.Manufacturer   :FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    LoadFile.InsuredName    :FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    LoadFile.CMIPolicyNumber:FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    LoadFile.AppendNumber   :FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    LoadFile.CMIBarcodeNumber:FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    /*
    LoadFile.CMIPolicyTypeCd:FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    LoadFile.CMIVehTypeCd   :FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    LoadFile.CMIDocumentUID :FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    LoadFile.CMIComDate     :FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    LoadFile.CMIExpDate     :FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    */

IF  LoadFile.Sch_P = NO AND
   (LoadFile.DocumentUID <> "" OR CMIBarcodeNumber <> "")
THEN DO:
  nv_color = 6.

    LoadFile.Seqno          :FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    LoadFile.ProcessDate    :FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    LoadFile.ProcessTime    :FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    LoadFile.ConfirmBy      :FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    LoadFile.PolicyTypeCd   :FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    LoadFile.RateGroup      :FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    LoadFile.PolicyNumber   :FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    LoadFile.ContractNumber :FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    LoadFile.DocumentUID    :FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    LoadFile.EffectiveDt    :FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    LoadFile.ExpirationDt   :FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    LoadFile.Registration   :FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    LoadFile.Manufacturer   :FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    LoadFile.InsuredName    :FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    LoadFile.CMIPolicyNumber:FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    LoadFile.AppendNumber   :FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.
    LoadFile.CMIBarcodeNumber:FGCOLOR IN BROWSE br_Query = nv_color NO-ERROR.

    LoadFile.Sch_P:FGCOLOR IN BROWSE br_Query = 6 NO-ERROR.
    LoadFile.DocumentUID :FGCOLOR IN BROWSE br_Query = 6 NO-ERROR.
    LoadFile.CMIBarcodeNumber:FGCOLOR IN BROWSE br_Query = 6 NO-ERROR.
END.

/*
       IF cb_Sort = "Entry Date"               THEN nv_Sort = 1.
  ELSE IF cb_Sort = "Send Date"                THEN nv_Sort = 2.
  ELSE IF cb_Sort = "Claim Number"             THEN nv_Sort = 3.
  ELSE IF cb_Sort = "Policy Number"            THEN nv_Sort = 4.
  ELSE IF cb_Sort = "Registration"             THEN nv_Sort = 5.
  ELSE IF cb_Sort = "Claim Number ฝ่ายชดใช้"   THEN nv_Sort = 6.
  ELSE IF cb_Sort = "Policy Number ฝ่ายชดใช้"  THEN nv_Sort = 7.
  ELSE IF cb_Sort = "Registration ฝ่ายชดใช้"   THEN nv_Sort = 8.
*/
    /*
CASE nv_Sort:

  WHEN 1 THEN DO:  /*ตามวันที่KEY*/
    LoadFile.EntryTime:FGCOLOR IN BROWSE br_Query = 3 NO-ERROR.
    LoadFile.EntryDt  :FGCOLOR IN BROWSE br_Query = 3 NO-ERROR.
  END.
  WHEN 2 THEN DO:  /*Send Date*/
    LoadFile.SendTime:FGCOLOR IN BROWSE br_Query = 3 NO-ERROR.
    LoadFile.SendDt:FGCOLOR IN BROWSE br_Query = 3 NO-ERROR.
  END.
  WHEN 3 THEN DO:  /*CLAIM*/

    LoadFile.ClaimOccurrenceRq :FGCOLOR IN BROWSE br_Query = 3 NO-ERROR.
  END.
  WHEN 4 THEN DO:  /*POLICY*/

    LoadFile.PolicyNumberRq    :FGCOLOR IN BROWSE br_Query = 3 NO-ERROR.
  END.

  WHEN 5 THEN DO:  /*RegistrationRQ*/

    LoadFile.RegistrationRq    :FGCOLOR IN BROWSE br_Query = 3 NO-ERROR.
  END.
  WHEN 6 THEN DO:  /*CLAIM ผู้ชดใช้*/

    LoadFile.ItemIdInfo :FGCOLOR IN BROWSE br_Query = 3 NO-ERROR.
  END.
  WHEN 7 THEN DO:  /*POLICY ผู้ชดใช้*/

    LoadFile.PolicyNumber    :FGCOLOR IN BROWSE br_Query = 3 NO-ERROR.
  END.
  WHEN 8 THEN DO:  /*Registration ผู้ชดใช้*/

    LoadFile.Registration    :FGCOLOR IN BROWSE br_Query = 3 NO-ERROR.
  END.

END CASE.
*/
/* */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buCANCEL
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buCANCEL C-Win
ON CHOOSE OF buCANCEL IN FRAME fr_main /* Cancel */
DO:
  APPLY "CLOSE" TO THIS-PROCEDURE.  /* ปิดโปรแกรม */
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buOK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buOK C-Win
ON CHOOSE OF buOK IN FRAME fr_main /* OK */
DO:
    /* */
    ASSIGN
        fi_From     = INPUT fi_From
        fi_To       = INPUT fi_To
        fi_DateFrom = INPUT fi_DateFrom
        fi_DateTo   = INPUT fi_DateTo
        fi_AcroRd   = INPUT fi_AcroRd
        nv_FByUserID = ""
        nv_TByUserID = "".
    fi_Success = 0.
    DISPLAY fi_Success fi_From  fi_To  fi_DateFrom  fi_DateTo 
        WITH FRAME fr_main.
    CLOSE QUERY br_Query.
    /* ---------------------------------------- */
    /*IF nv_Search = 1 THEN DO:*//*kridtiya I.*/
    IF nv_Search = 1 OR nv_Search = 11 THEN DO:   /*kridtiya I.*/
        IF fi_DateFrom = ? THEN DO:
            MESSAGE " โปรดระบุ วันที่เริ่มต้นจาก" SKIP(1)
                VIEW-AS ALERT-BOX.
            APPLY "ENTRY" TO fi_DateFrom.
            RETURN NO-APPLY.
        END.
        IF fi_DateTo = ? THEN DO:
            MESSAGE " โปรดระบุ ถึงวันที่สิ้นสุด" SKIP(1)
                VIEW-AS ALERT-BOX.
            APPLY "ENTRY" TO fi_DateTo.
            RETURN NO-APPLY.
        END.
        IF fi_DateFrom > fi_DateTo THEN DO:
            MESSAGE " วันที่เริ่มต้น มากกว่า วันที่สิ้นสุด" SKIP(1)
                " โปรดระบุใหม่"
                VIEW-AS ALERT-BOX.
            APPLY "ENTRY" TO fi_DateFrom.
            RETURN NO-APPLY.
        END.
    END.
    ELSE DO:
        IF fi_From = "" AND fi_To = "" THEN DO:
            MESSAGE " โปรดระบุ ข้อมูลที่ใช้ค้นหา" SKIP(1)
                VIEW-AS ALERT-BOX.
            APPLY "ENTRY" TO fi_From.
            RETURN NO-APPLY.
        END.
        IF fi_To = "" THEN DO:
            MESSAGE " โปรดระบุ ข้อมูลที่ใช้ค้นหา" SKIP(1)
                VIEW-AS ALERT-BOX.
            APPLY "ENTRY" TO fi_From.
            RETURN NO-APPLY.
        END.
        IF fi_From > fi_To THEN DO:
            MESSAGE " ข้อมูลไม่ถูกต้อง โปรดระบุ ข้อมูลที่ใช้ค้นหาใหม่" SKIP(1)
                VIEW-AS ALERT-BOX.
            APPLY "ENTRY" TO fi_From.
            RETURN NO-APPLY.
        END.
    END.
    /* --------------------------------------------------- */
    IF fi_RequestorRs = "" THEN DO:
        MESSAGE " โปรดระบุ รหัส บริษัทฯประกันที่ต้องการค้นหา:" SKIP(1)
            VIEW-AS ALERT-BOX.
        APPLY "ENTRY" TO fi_RequestorRs.
        RETURN NO-APPLY.
    END.
  /* */

  /*IF fi_RequestorRs <> "ALL" THEN DO:      /* รหัสบริษัทประกันฝ่ายถูก */

    FIND FIRST InsurerCode WHERE InsurerCode.InsurerCd = fi_RequestorRs
    NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAILABLE InsurerCode THEN DO:

      MESSAGE "Not found Insurer Code:" fi_RequestorRs SKIP
              "on Table InsurerCode" SKIP (1) 
      VIEW-AS ALERT-BOX.

      APPLY "ENTRY" TO fi_RequestorRs.
      RETURN NO-APPLY.
    END.
    fi_RequestorName = InsurerCode.InsurerName.

    nv_FRequestorRs  = fi_RequestorRs.
    nv_TRequestorRs  = fi_RequestorRs.
  END.
  ELSE DO:

    MESSAGE "โปรดระบุ รหัสบริษัท:" fi_RequestorRs SKIP
            "สำหรับเรียกข้อมูล" SKIP (1) 
    VIEW-AS ALERT-BOX.
    APPLY "ENTRY" TO fi_RequestorRs.
    RETURN NO-APPLY.
  END. 
  
  DISPLAY fi_RequestorName WITH FRAME fr_main.*/
  /* */
  /* --------------------------------------------------- */
  fi_notfound  = "Please wait process data. " + STRING(TIME,"HH:MM:SS") .
  DISPLAY fi_notfound WITH FRAME fr_main.

  /*IF nv_CheckFile = "" THEN DO:

    nv_SearchDrive = "C:\".
    nv_SearchName  = "AcroRd32.exe".

    FIND FIRST FSearch WHERE FSearch.SearchType = "PDF"
    NO-LOCK NO-ERROR NO-WAIT.
    IF AVAILABLE FSearch THEN ASSIGN nv_SearchDrive = FSearch.SearchDrive
                                     nv_SearchName  = FSearch.SearchName.

    RUN WRS/WRSAcroRd.P (INPUT nv_SearchDrive
                        ,INPUT nv_SearchName
                        ,INPUT fi_AcroRd      /*YES/NO*/
                        ,INPUT-OUTPUT nv_CheckFile).
    /*
    nv_CheckFile = "NOT".    not found AcroRd32.exe
    nv_CheckFile = "AcroRd". found AcroRd32.exe
    */
  END.*/

  fi_notfound  = "Please wait process data. " + STRING(TIME,"HH:MM:SS") .
  DISPLAY fi_notfound WITH FRAME fr_main.
  FOR EACH LoadFile:  DELETE LoadFile.   END.
  RUN PD_CreateData.
  DISPLAY fi_Success  WITH FRAME fr_main.  
  fi_notfound  = "Please wait process data. " + STRING(TIME,"HH:MM:SS") .
  DISPLAY fi_notfound WITH FRAME fr_main.
  DISPLAY fi_Success  WITH FRAME fr_main.  
  CLOSE QUERY br_Query.
  IF fi_Success = 0 THEN DO:
      MESSAGE "Not found Data" SKIP
          VIEW-AS ALERT-BOX.
      fi_notfound  = "".
      DISPLAY fi_notfound WITH FRAME fr_main.
      APPLY "ENTRY" TO fi_RequestorRs.
      RETURN NO-APPLY.
  END.
  DISPLAY fi_Success  WITH FRAME fr_main.  
  RUN PD_Setseqno.
  RUN PD_Display.
  DISPLAY fi_Success  WITH FRAME fr_main.  
  fi_notfound  = "".
  DISPLAY fi_notfound WITH FRAME fr_main.
  RELEASE IntPol7072.
  APPLY "ENTRY" TO br_Query.
  RETURN NO-APPLY.
  /* */
END. /* DO: */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exp C-Win
ON CHOOSE OF bu_exp IN FRAME fr_main /* EXPORT */
DO:
    IF fi_outputfile = ""  THEN DO:
        MESSAGE " โปรดระบุ ไฟล์รายงานที่ต้องการ"   VIEW-AS ALERT-BOX.
        Apply "Entry"  to fi_outputfile.
        Return no-apply.
    END.
    /*FOR EACH LoadFile:  DELETE LoadFile.   END.*/
    /*RUN PD_CreateData.*/
    RUN PD_Exportdata.
    RUN PD_Setseqno.
    RUN PD_Display.
    
    


  fi_notfound  = "".
  DISPLAY fi_notfound WITH FRAME DEFAULT-FRAME.

  RELEASE IntPol7072.

  APPLY "ENTRY" TO br_Query.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cb_Search
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cb_Search C-Win
ON VALUE-CHANGED OF cb_Search IN FRAME fr_main /* เลือกรายการค้นหา */
DO:
  nv_Search = 0.
  cb_Search = INPUT cb_Search.
       IF cb_Search = "Process Date"      THEN nv_Search = 1.
  ELSE IF cb_Search = "Policy Number"     THEN nv_Search = 2.
  ELSE IF cb_Search = "Registration"      THEN nv_Search = 3.
  ELSE IF cb_Search = "Policy Type"       THEN nv_Search = 4.
  ELSE IF cb_Search = "Confirm By"        THEN nv_Search = 5.
  ELSE IF cb_Search = "ContractNumber"    THEN nv_Search = 6.
  ELSE IF cb_Search = "InsuredName"       THEN nv_Search = 7.
  ELSE IF cb_Search = "InsuredSurname"    THEN nv_Search = 8.
  ELSE IF cb_Search = "DocumentUID"       THEN nv_Search = 9.
  ELSE IF cb_Search = "StickerNo"         THEN nv_Search = 10.
  ELSE DO:
    cb_Search = "Process Date".
    nv_Search = 1.
  END.
  DISPLAY cb_Search WITH FRAME DEFAULT-FRAME.
  /* -- */

  IF nv_Search = 0 THEN DO:
    MESSAGE " Please Check error Search list (cb_Search)" SKIP(1)
            nv_Search cb_Search
    VIEW-AS ALERT-BOX.

    APPLY "ENTRY" TO cb_Search.
    RETURN NO-APPLY.
  END.

  IF nv_Search  = 1 THEN DO:
    fi_From     = "".
    fi_To       = "".
    fi_DateFrom = TODAY.
    fi_DateTo   = TODAY.

    DISPLAY fi_From fi_To fi_DateFrom fi_DateTo WITH FRAME DEFAULT-FRAME.
    DISABLE    fi_From        fi_To             WITH FRAME DEFAULT-FRAME.
    ENABLE     fi_DateFrom    fi_DateTo         WITH FRAME DEFAULT-FRAME.

    APPLY "ENTRY" TO fi_DateFrom.
    RETURN NO-APPLY.
  END.
  ELSE DO:

    fi_DateFrom = ?.
    fi_DateTo   = ?.

    DISPLAY fi_From fi_To fi_DateFrom fi_DateTo WITH FRAME DEFAULT-FRAME.
    DISABLE     fi_DateFrom      fi_DateTo      WITH FRAME DEFAULT-FRAME.
    ENABLE      fi_From          fi_To          WITH FRAME DEFAULT-FRAME.

    APPLY "ENTRY" TO fi_From.
    RETURN NO-APPLY.
  END.
/**/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cb_Sort
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cb_Sort C-Win
ON VALUE-CHANGED OF cb_Sort IN FRAME fr_main /* จัดเรียงรายการค้นหา ตาม */
DO:
  nv_Sort = 0.
  cb_Sort = INPUT cb_Sort.

    

       IF cb_Sort = "Process Date"     THEN nv_Sort = 1.
  ELSE IF cb_Sort = "Policy Number"    THEN nv_Sort = 2.
  ELSE IF cb_Sort = "Registration"     THEN nv_Sort = 3.
  ELSE IF cb_Sort = "Policy Type"      THEN nv_Sort = 4.
  ELSE IF cb_Sort = "Confirm By"       THEN nv_Sort = 5.
  ELSE IF cb_Sort = "Registration_Dup" THEN nv_Sort = 6.
  ELSE DO:
    cb_Sort = "Process Date".
    nv_Sort = 1.
  END.
  DISPLAY cb_Sort WITH FRAME DEFAULT-FRAME.

  RUN PD_Setseqno.
  RUN PD_Display.
  /* -- */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_outputfile
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outputfile C-Win
ON LEAVE OF fi_outputfile IN FRAME fr_main /* Out Put File */
DO:
  fi_outputfile = INPUT fi_outputfile .
  DISP fi_outputfile WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_RequestorRs
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_RequestorRs C-Win
ON LEAVE OF fi_RequestorRs IN FRAME fr_main /* รหัสบริษัท (Agent/Broker) */
DO:
  fi_RequestorRs = INPUT fi_RequestorRs.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_type
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_type C-Win
ON VALUE-CHANGED OF ra_type IN FRAME fr_main
DO:
  ra_type = INPUT ra_type.
  DISP ra_type WITH FRAM fr_main.
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
/* --- */

CLEAR  ALL     NO-PAUSE.
STATUS INPUT   OFF.
HIDE   MESSAGE NO-PAUSE.
/* --- */

MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:

 
  /********************  T I T L E   F O R  C - W I N  ****************/
  
  DEF  VAR  gv_prgid   AS   CHAR  FORMAT "X(8)"  NO-UNDO.
  DEF  VAR  gv_prog    AS   CHAR  FORMAT "X(40)" NO-UNDO.
  gv_prgid = "wgwrelt1".
  gv_prog  = "Report File and Export PDF".
  
/*   RUN  WSU\WSUHDExt ({&WINDOW-NAME}:handle,gv_prgid,gv_prog). */
/*                                                               */
/*   RUN  WUT\WUTWICEN (C-WIN:handle).                           */
  /*********************************************************************/
  /* */
  SESSION:DATA-ENTRY-RETURN = YES.      /* รับค่าปุ่ม ENTER */
  
  /* ใส่ค่าตัวแปรและแสดงค่า */
  ASSIGN
  fi_RequestorRs = "469"
  cb_Search      = "Process Date"
  nv_Search      = 1
  cb_Sort        = "Process Date"
  nv_Sort        = 1
  fi_DateFrom    = TODAY
  fi_DateTo      = TODAY
      ra_type = 2 .

  RUN enable_UI.

  ENABLE  fi_DateFrom  fi_DateTo        WITH FRAME DEFAULT-FRAME.
  DISABLE fi_From      fi_To  ra_type    WITH FRAME DEFAULT-FRAME.

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
  DISPLAY ra_type fi_outputfile fi_RequestorRs cb_Search fi_From fi_To 
          fi_DateFrom fi_notfound fi_DateTo cb_Sort fi_AcroRd fi_Success 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE ra_type bu_exp fi_outputfile fi_RequestorRs cb_Search fi_From fi_To 
         fi_DateFrom fi_notfound fi_DateTo cb_Sort fi_AcroRd buOK fi_Success 
         buCANCEL br_Query RECT-9 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_CreateData C-Win 
PROCEDURE PD_CreateData :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/**/
/* ****************
       IF cb_Search = "Process Date"      THEN nv_Search = 1.
  ELSE IF cb_Search = "Policy Number"     THEN nv_Search = 2.
  ELSE IF cb_Search = "Registration"      THEN nv_Search = 3.
  ELSE IF cb_Search = "Policy Type"       THEN nv_Search = 4.
  ELSE IF cb_Search = "Confirm By"        THEN nv_Search = 5.
**************** */

fi_Success = 0.

CASE nv_Search:

  WHEN 1 THEN DO:
      IF nv_Sort = 6 THEN DO:
          /*add by Kridtiya i. 05/03/2015*/   
          MESSAGE "PD_CreateData3" VIEW-AS ALERT-BOX.
          FOR EACH  IntPol7072  USE-INDEX IntPol707203
              WHERE
                   IntPol7072.ProcessDate  >= fi_DateFrom
              AND  IntPol7072.ProcessDate  <= fi_DateTo
              AND  IntPol7072.CompanyCode   = fi_RequestorRs
              NO-LOCK:
              RUN PD_CreateData3.
          END.   /*end.add by Kridtiya i. 05/03/2015*/
      END.
      ELSE DO:
          FOR EACH  IntPol7072 USE-INDEX IntPol707203
              WHERE  
                   IntPol7072.ProcessDate  >= fi_DateFrom
              AND  IntPol7072.ProcessDate  <= fi_DateTo
              AND  IntPol7072.CompanyCode   = fi_RequestorRs
              NO-LOCK:
              /*RUN PD_CreateData2.*/
              RUN PD_CreateData3.
          END.
      END.
  END.
  WHEN 2 THEN DO:

    FOR EACH  IntPol7072  USE-INDEX IntPol707201
       WHERE
            IntPol7072.PolicyNumber  >= fi_From
       AND  IntPol7072.PolicyNumber  <= fi_To
       AND  IntPol7072.CompanyCode    = fi_RequestorRs
    NO-LOCK:
        RUN PD_CreateData2.
    END.
    FOR EACH  IntPol7072  USE-INDEX IntPol707202
       WHERE
            IntPol7072.CMIPolicyNumber >= fi_From
       AND  IntPol7072.CMIPolicyNumber <= fi_To
       AND  IntPol7072.CompanyCode      = fi_RequestorRs
    NO-LOCK:
        RUN PD_CreateData2.
    END.
  END.
  WHEN 3 THEN DO:

    FOR EACH  IntPol7072  USE-INDEX IntPol707206
       WHERE
            IntPol7072.Registration  >= fi_From
       AND  IntPol7072.Registration  <= fi_To
       AND  IntPol7072.CompanyCode    = fi_RequestorRs
    NO-LOCK:
        RUN PD_CreateData2.
    END.
  END.
  WHEN 4 THEN DO:

    FOR EACH  IntPol7072 USE-INDEX IntPol707210
       WHERE 
            IntPol7072.CompanyCode    = fi_RequestorRs
       AND  IntPol7072.PolicyTypeCd  >= fi_From
       AND  IntPol7072.PolicyTypeCd  <= fi_To
        
    NO-LOCK:
        RUN PD_CreateData2.
    END.
  END.
  WHEN 5 THEN DO:

    FOR EACH  IntPol7072 
       WHERE
            IntPol7072.ConfirmBy    >= fi_From
       AND  IntPol7072.ConfirmBy    <= fi_To
       AND  IntPol7072.CompanyCode   = fi_RequestorRs
    NO-LOCK:
        RUN PD_CreateData2.
    END.
  END.
  WHEN 6 THEN DO:

    FOR EACH  IntPol7072  USE-INDEX IntPol707205
       WHERE
            IntPol7072.ContractNumber >= fi_From
       AND  IntPol7072.ContractNumber <= fi_To
       AND  IntPol7072.CompanyCode     = fi_RequestorRs
    NO-LOCK:
        RUN PD_CreateData2.
    END.
  END.
  WHEN 7 THEN DO:

    FOR EACH  IntPol7072  USE-INDEX IntPol707207
       WHERE
            IntPol7072.InsuredName >= fi_From
       AND  IntPol7072.InsuredName <= fi_To
       AND  IntPol7072.CompanyCode  = fi_RequestorRs
    NO-LOCK:
        RUN PD_CreateData2.
    END.
  END.
  WHEN 8 THEN DO:

    FOR EACH  IntPol7072 
       WHERE
            IntPol7072.InsuredSurname >= fi_From
       AND  IntPol7072.InsuredSurname <= fi_To
       AND  IntPol7072.CompanyCode     = fi_RequestorRs
    NO-LOCK:
        RUN PD_CreateData2.
    END.
  END.

  WHEN 9 THEN DO:

    FOR EACH  IntPol7072 USE-INDEX IntPol707208
       WHERE
            IntPol7072.DocumentUID >= fi_From
       AND  IntPol7072.DocumentUID <= fi_To
       AND  IntPol7072.CompanyCode     = fi_RequestorRs
    NO-LOCK:
        RUN PD_CreateData2.
    END.

    FOR EACH  IntPol7072  USE-INDEX IntPol707209
       WHERE
            IntPol7072.CMIDocumentUID >= fi_From
       AND  IntPol7072.CMIDocumentUID <= fi_To
       AND  IntPol7072.CompanyCode     = fi_RequestorRs
    NO-LOCK:
        RUN PD_CreateData2.
    END.
  END.

  WHEN 10 THEN DO:

    FOR EACH  IntPol7072 
       WHERE
            IntPol7072.CMIBarCodeNumber >= fi_From
       AND  IntPol7072.CMIBarCodeNumber <= fi_To
       AND  IntPol7072.CompanyCode       = fi_RequestorRs
    NO-LOCK:
        RUN PD_CreateData2.
    END.
  END.
END.

/**/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_CreateData2 C-Win 
PROCEDURE PD_CreateData2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/**/
  IF      ( ra_type = 2 ) AND ( IntPol7072.CMIPolicyTypeCd = "" ) THEN NEXT.
  ELSE IF ( ra_type = 1 ) AND ( IntPol7072.PolicyTypeCd    = "" ) THEN NEXT.

  fi_Success = fi_Success + 1.

  CREATE LoadFile.
  ASSIGN
  LoadFile.RecSelect        = ""
  LoadFile.Seqno            = fi_Success          
  LoadFile.MsgStatusCd      = ""
  /* */
  LoadFile.GenSicBran       = IntPol7072.GenSicBran
  LoadFile.ConfirmBy        = IntPol7072.ConfirmBy      
  LoadFile.PolicyNumber     = IntPol7072.PolicyNumber   
  LoadFile.ContractNumber   = IntPol7072.ContractNumber 
  LoadFile.DocumentUID      = IntPol7072.DocumentUID    
  LoadFile.EffectiveDt      = IntPol7072.comdat
  LoadFile.ExpirationDt     = IntPol7072.expdat   
  /**/
  LoadFile.PolicyTypeCd     = IntPol7072.PolicyTypeCd   
  LoadFile.RateGroup        = IntPol7072.RateGroup      
  /**/
  LoadFile.Registration     = IntPol7072.vehreg   
  LoadFile.Manufacturer     = IntPol7072.Manufacturer   
  LoadFile.ChassisVINNumber = IntPol7072.ChassisVINNumber   
  /**/
  LoadFile.InsuredName      = TRIM(TRIM(IntPol7072.InsuredTitle) + " " +
                                   TRIM(TRIM(IntPol7072.InsuredName)  + " " +
                                             IntPol7072.InsuredSurname)) 

  /**/
  LoadFile.CMIPolicyTypeCd  = IntPol7072.CMIPolicyTypeCd
  LoadFile.CMIVehTypeCd     = IntPol7072.CMIVehTypeCd   
  LoadFile.CMIPolicyNumber  = IntPol7072.CMIPolicyNumber
  /**/
  LoadFile.CMIDocumentUID   = IntPol7072.CMIDocumentUID
  LoadFile.CMIBarcodeNumber = IntPol7072.CMIBarcodeNumber
  LoadFile.CMIComDate       = IntPol7072.CMIComDate     
  LoadFile.CMIExpDate       = IntPol7072.CMIExpDate     
  /* */
  LoadFile.ProcessDate      = IntPol7072.ProcessDate    
  LoadFile.ProcessTime      = IntPol7072.ProcessTime    
  /* */
  LoadFile.EndorseFlag      = IntPol7072.EndorseFlag  /*Product*/
  LoadFile.TEMPRecID        = RECID(IntPol7072) 
  Loadfile.Agentno          = IntPol7072.AgentBrokerLicenseNumber
  LoadFile.AppendNumber     = ""
  LoadFile.BranchCd              = IntPol7072.BranchCd                      
  LoadFile.InsuranceBranchCd     = IntPol7072.InsuranceBranchCd     
  LoadFile.PreviousPolicyNumber  = IntPol7072.PreviousPolicyNumber
  LoadFile.OptionValueDesc       = IntPol7072.OptionValueDesc
  LoadFile.FileNameAttach1       = IntPol7072.FileNameAttach1
  LoadFile.FileNameAttach2       = IntPol7072.FileNameAttach2
  LoadFile.FileNameAttach3       = IntPol7072.FileNameAttach3
  LoadFile.AttachFile1           = IntPol7072.AttachFile1
  LoadFile.AttachFile2           = IntPol7072.AttachFile2
  LoadFile.AttachFile3           = IntPol7072.AttachFile3         .
  
  IF IntPol7072.PolicyNumber = "" OR IntPol7072.PolicyNumber = IntPol7072.CMIPolicyNumber 
  THEN DO:
    ASSIGN
    LoadFile.PolicyNumber  = IntPol7072.CMIPolicyNumber
    LoadFile.AppendNumber  = ""
    LoadFile.PolicyTypeCd  = IntPol7072.CMIPolicyTypeCd
    LoadFile.RateGroup     = IntPol7072.CMIVehTypeCd
    LoadFile.DocumentUID   = IntPol7072.CMIDocumentUID
    LoadFile.EffectiveDt   = IntPol7072.CMIComDate
    LoadFile.ExpirationDt  = IntPol7072.CMIExpDate .
  END.
  ELSE DO:

    LoadFile.AppendNumber  = IntPol7072.CMIPolicyNumber.
  END.

  LoadFile.Sch_P           = IF IntPol7072.AttachFile1 = ? THEN NO ELSE YES .


  LoadFile.ReceiptNumber   = IntPol7072.ReceiptNumber.    /*PromotionNumber / CampaignNumber*/
  LoadFile.COLLAmtAccident = INTEGER(IntPol7072.COLLAmtAccident) NO-ERROR.

/**/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_CreateData3 C-Win 
PROCEDURE PD_CreateData3 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/**/
  IF      ( ra_type = 2 ) AND ( IntPol7072.CMIPolicyTypeCd = "" ) THEN NEXT.
  ELSE IF ( ra_type = 1 ) AND ( IntPol7072.PolicyTypeCd    = "" ) THEN NEXT.

ASSIGN 
    nv_COUNT_no = 0 
    fi_Success = fi_Success + 1.

FOR EACH  LoadFile WHERE LoadFile.Registration = IntPol7072.Registration .
    ASSIGN nv_COUNT_no    = nv_COUNT_no +  1
        LoadFile.COUNT_no = nv_COUNT_no.
END.

  CREATE LoadFile.
  ASSIGN
  LoadFile.COUNT_no         = nv_COUNT_no
  LoadFile.RecSelect        = ""
  LoadFile.Seqno            = fi_Success          
  LoadFile.MsgStatusCd      = ""
  /* */
  LoadFile.GenSicBran       = IntPol7072.GenSicBran
  LoadFile.ConfirmBy        = IntPol7072.ConfirmBy      
  LoadFile.PolicyNumber     = IntPol7072.PolicyNumber   
  LoadFile.ContractNumber   = IntPol7072.ContractNumber 
  LoadFile.DocumentUID      = IntPol7072.DocumentUID    
  LoadFile.EffectiveDt      = IntPol7072.comdat
  LoadFile.ExpirationDt     = IntPol7072.expdat   
  /**/
  LoadFile.PolicyTypeCd     = IntPol7072.PolicyTypeCd   
  LoadFile.RateGroup        = IntPol7072.RateGroup      
  /**/
  LoadFile.Registration     = IntPol7072.Registration 
  LoadFile.vehregF          = IntPol7072.vehreg 
  LoadFile.ChassisVINNumber = IntPol7072.ChassisVINNumber   
  /**/
  LoadFile.InsuredName      = TRIM(TRIM(IntPol7072.InsuredTitle) + " " +
                                   TRIM(TRIM(IntPol7072.InsuredName)  + " " +
                                             IntPol7072.InsuredSurname))  
  /**/
  LoadFile.CMIPolicyTypeCd  = IntPol7072.CMIPolicyTypeCd
  LoadFile.CMIVehTypeCd     = IntPol7072.CMIVehTypeCd   
  LoadFile.CMIPolicyNumber  = IntPol7072.CMIPolicyNumber
  /**/
  LoadFile.CMIDocumentUID   = IntPol7072.CMIDocumentUID
  LoadFile.CMIBarcodeNumber = IntPol7072.CMIBarcodeNumber
  LoadFile.CMIComDate       = IntPol7072.CMIComDate     
  LoadFile.CMIExpDate       = IntPol7072.CMIExpDate     
  /* */
  LoadFile.ProcessDate      = IntPol7072.ProcessDate    
  LoadFile.ProcessTime      = IntPol7072.ProcessTime    
  /* */
  LoadFile.EndorseFlag      = IntPol7072.EndorseFlag  /*Product*/
  LoadFile.TEMPRecID        = RECID(IntPol7072) 
  LoadFile.SCLASS           = IntPol7072.CMIVehTypeCd 
  LoadFile.premt            = deci(IntPol7072.CMIWrittenAmt)
        LoadFile.BranchCd              = IntPol7072.BranchCd                      
      LoadFile.InsuranceBranchCd     = IntPol7072.InsuranceBranchCd     
      LoadFile.PreviousPolicyNumber  = IntPol7072.PreviousPolicyNumber 
      LoadFile.OptionValueDesc = IntPol7072.OptionValueDesc 
       Loadfile.Agentno          = IntPol7072.AgentBrokerLicenseNumber
      LoadFile.FileNameAttach1       = IntPol7072.FileNameAttach1
  LoadFile.FileNameAttach2       = IntPol7072.FileNameAttach2
  LoadFile.FileNameAttach3       = IntPol7072.FileNameAttach3
  LoadFile.AttachFile1           = IntPol7072.AttachFile1
  LoadFile.AttachFile2           = IntPol7072.AttachFile2
  LoadFile.AttachFile3           = IntPol7072.AttachFile3  


      .

  LoadFile.AppendNumber     = "".

  IF IntPol7072.PolicyNumber = "" OR IntPol7072.PolicyNumber = IntPol7072.CMIPolicyNumber 
  THEN DO:
    ASSIGN
    LoadFile.PolicyNumber  = IntPol7072.CMIPolicyNumber
    LoadFile.AppendNumber  = ""
    LoadFile.PolicyTypeCd  = IntPol7072.CMIPolicyTypeCd
    LoadFile.RateGroup     = IntPol7072.CMIVehTypeCd
    LoadFile.DocumentUID   = IntPol7072.CMIDocumentUID
    LoadFile.EffectiveDt   = IntPol7072.CMIComDate
    LoadFile.ExpirationDt  = IntPol7072.CMIExpDate .
  END.
  ELSE DO:

    LoadFile.AppendNumber  = IntPol7072.CMIPolicyNumber.
  END.

  LoadFile.Sch_P           = IF IntPol7072.AttachFile1 = ? THEN NO ELSE YES .

  LoadFile.ReceiptNumber   = IntPol7072.ReceiptNumber.    /*PromotionNumber / CampaignNumber*/
  LoadFile.COLLAmtAccident = INTEGER(IntPol7072.COLLAmtAccident) NO-ERROR.

/**/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_Display C-Win 
PROCEDURE PD_Display :
/*------------------------------------------------------------------------------
  Purpose: แสดงข้อมูล Query จาก File LoadFile and File KFKSPClmHis
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* 
       IF cb_Sort = "Process Date"     THEN nv_Sort = 1.
  ELSE IF cb_Sort = "Policy Number"    THEN nv_Sort = 2.
  ELSE IF cb_Sort = "Registration"     THEN nv_Sort = 3.
  ELSE IF cb_Sort = "Policy Type"      THEN nv_Sort = 4.
  ELSE IF cb_Sort = "Confirm By"       THEN nv_Sort = 5.
*/
  /* แสดงข้อมูล Request */

CLOSE QUERY br_Query.

/**/
CASE nv_Sort:

  WHEN 1 THEN DO:  /*ProcessDate*/

    OPEN QUERY br_Query
    FOR EACH  LoadFile USE-INDEX LoadFile01
    NO-LOCK.
  END.

  WHEN 2 THEN DO:  /*PolicyNumber*/

    OPEN QUERY br_Query
    FOR EACH  LoadFile USE-INDEX LoadFile02
    NO-LOCK.
  END.

  WHEN 3 THEN DO:  /*Registration*/

    OPEN QUERY br_Query
    FOR EACH  LoadFile USE-INDEX LoadFile03
    NO-LOCK.
  END.

  WHEN 4 THEN DO:  /*PolicyTypeCd*/

    OPEN QUERY br_Query
    FOR EACH  LoadFile USE-INDEX LoadFile04
    NO-LOCK.
  END.

  WHEN 5 THEN DO:  /*ConfirmBy*/

    OPEN QUERY br_Query
    FOR EACH  LoadFile USE-INDEX LoadFile05
    NO-LOCK.
  END.
  WHEN 6 THEN DO:  /*Registration_Dup*/

    OPEN QUERY br_Query
    FOR EACH  LoadFile USE-INDEX LoadFile03
        WHERE LoadFile.COUNT_no > 0
    NO-LOCK.
  END.


END CASE.
DISPLAY fi_Success  WITH FRAME DEFAULT-FRAME.  
/* */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_Exportdata C-Win 
PROCEDURE PD_Exportdata :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*4*/ DEFINE VARIABLE SendReqBinData1      AS MEMPTR    NO-UNDO.
/*4*/ DEFINE VARIABLE SendReqBinData2      AS MEMPTR    NO-UNDO.
/*4*/ DEFINE VARIABLE SendReqBinData3      AS MEMPTR    NO-UNDO.

ASSIGN 
    n_record = 0
    nv_cnt   = 0
    nv_row   = 1  .

If  substr(fi_outputfile,length(fi_outputfile) - 3,4) <>  ".slk"  THEN 
    fi_outputfile  =  Trim(fi_outputfile) + ".slk"  .

ASSIGN nv_cnt =  0
    nv_row    =  1 .

OUTPUT STREAM ns2 TO VALUE(fi_outputfile).
PUT STREAM ns2 "ID;PND" SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"' "Seqno"                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"' "ProcDate"             '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"' "ProcTime"             '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"' "Appv"                 '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"' "PolTyp"               '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"' "CovTyp"               '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"' "Create"               '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"' "Policy Number"        '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"' "Doc.No."              '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"' "Sticker พรบ."         '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"' "BranchCd"             '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"' "InsuranceBranchCd"    '"' SKIP.        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"' "PreviousPolicyNumber" '"' SKIP.        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"' "Contract Number"      '"' SKIP.        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"' "ComDate"              '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"' "ExtDate"              '"' SKIP.       
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"' "Insured Name"         '"' SKIP.        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"' "Chassis"              '"' SKIP.        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"' "กท.รถ"                '"' SKIP.        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"' "CLASS"                '"' SKIP.        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"' "premt"                '"' SKIP.        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"' "Prn"                  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"' "ยี่ห้อ"               '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"' "Product."             '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"' "Prom/Camp no."        '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"' "COLL Amt.Acc."        '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"' "Append Number"        '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"' "Policy Number 72"     '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"' "Desp"                 '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"' "Agent"                '"' SKIP.  

FOR EACH  LoadFile USE-INDEX LoadFile03
        /*WHERE LoadFile.COUNT_no > 0*/
    NO-LOCK 
    BREAK BY LoadFile.PolicyNumber.

    ASSIGN 
        n_record =  n_record + 1
        nv_cnt   =  nv_cnt  + 1 
        nv_row   =  nv_row  + 1.                                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"'  LoadFile.Seqno                '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"'  LoadFile.ProcessDate          '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"'  LoadFile.ProcessTime          '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"'  LoadFile.ConfirmBy            '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"'  LoadFile.PolicyTypeCd         '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"'  LoadFile.RateGroup            '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"'  LoadFile.GenSicBran           '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"'  LoadFile.PolicyNumber         '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"'  LoadFile.DocumentUID          '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"'  LoadFile.CMIBarcodeNumber     '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"'  LoadFile.BranchCd             '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"'  LoadFile.InsuranceBranchCd    '"' SKIP.          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"'  LoadFile.PreviousPolicyNumber '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"'  LoadFile.ContractNumber       '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"'  LoadFile.EffectiveDt          '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"'  LoadFile.ExpirationDt         '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"'  LoadFile.InsuredName          '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"'  LoadFile.ChassisVINNumber     '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"'  LoadFile.vehregF              '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"'  LoadFile.SCLASS               '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"'  LoadFile.premt                '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"'  LoadFile.Sch_P                '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"'  LoadFile.Manufacturer         '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"'  LoadFile.EndorseFlag          '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"'  LoadFile.ReceiptNumber        '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"'  LoadFile.COLLAmtAccident      '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"'  LoadFile.AppendNumber         '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"'  LoadFile.CMIPolicyNumber      '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"'  LoadFile.OptionValueDesc      '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"'  LoadFile.Agentno              '"' SKIP.   
END.  


/*

fi_Success = 0.

CASE nv_Search:

  WHEN 1 THEN DO:
      IF nv_Sort = 6 THEN DO:
          /*add by Kridtiya i. 05/03/2015*/   
          FOR EACH  IntPol7072 
              WHERE
                   IntPol7072.ProcessDate  >= fi_DateFrom
              AND  IntPol7072.ProcessDate  <= fi_DateTo
              AND  IntPol7072.CompanyCode   = fi_RequestorRs
              NO-LOCK:
              RUN PD_CreateData3.
              RUN PD_Exportdatadt.
              
          END.   /*end.add by Kridtiya i. 05/03/2015*/
      END.
      ELSE DO:
          FOR EACH  IntPol7072 
              WHERE
              IntPol7072.ProcessDate  >= fi_DateFrom
              AND  IntPol7072.ProcessDate  <= fi_DateTo
              AND  IntPol7072.CompanyCode   = fi_RequestorRs
              NO-LOCK:
              RUN PD_CreateData2.
              RUN PD_Exportdatadt.
          END.
      END.
  END.
  WHEN 2 THEN DO:

    FOR EACH  IntPol7072 
       WHERE
            IntPol7072.PolicyNumber  >= fi_From
       AND  IntPol7072.PolicyNumber  <= fi_To
       AND  IntPol7072.CompanyCode    = fi_RequestorRs
    NO-LOCK:
        RUN PD_CreateData2.
        RUN PD_Exportdatadt.
    END.
    FOR EACH  IntPol7072 
       WHERE
            IntPol7072.CMIPolicyNumber >= fi_From
       AND  IntPol7072.CMIPolicyNumber <= fi_To
       AND  IntPol7072.CompanyCode      = fi_RequestorRs
    NO-LOCK:
        RUN PD_CreateData2.
        RUN PD_Exportdatadt.
    END.
  END.
  WHEN 3 THEN DO:

    FOR EACH  IntPol7072 
       WHERE
            IntPol7072.Registration  >= fi_From
       AND  IntPol7072.Registration  <= fi_To
       AND  IntPol7072.CompanyCode    = fi_RequestorRs
    NO-LOCK:
        RUN PD_CreateData2.
        RUN PD_Exportdatadt.
    END.
  END.
  WHEN 4 THEN DO:

    FOR EACH  IntPol7072 
       WHERE
            IntPol7072.PolicyTypeCd  >= fi_From
       AND  IntPol7072.PolicyTypeCd  <= fi_To
       AND  IntPol7072.CompanyCode    = fi_RequestorRs
    NO-LOCK:
        RUN PD_CreateData2.
        RUN PD_Exportdatadt.
    END.
  END.
  WHEN 5 THEN DO:

    FOR EACH  IntPol7072 
       WHERE
            IntPol7072.ConfirmBy    >= fi_From
       AND  IntPol7072.ConfirmBy    <= fi_To
       AND  IntPol7072.CompanyCode   = fi_RequestorRs
    NO-LOCK:
        RUN PD_CreateData2.
        RUN PD_Exportdatadt.
    END.
  END.
  WHEN 6 THEN DO:

    FOR EACH  IntPol7072 
       WHERE
            IntPol7072.ContractNumber >= fi_From
       AND  IntPol7072.ContractNumber <= fi_To
       AND  IntPol7072.CompanyCode     = fi_RequestorRs
    NO-LOCK:
        RUN PD_CreateData2.
        RUN PD_Exportdatadt.
    END.
  END.
  WHEN 7 THEN DO:

    FOR EACH  IntPol7072 
       WHERE
            IntPol7072.InsuredName >= fi_From
       AND  IntPol7072.InsuredName <= fi_To
       AND  IntPol7072.CompanyCode  = fi_RequestorRs
    NO-LOCK:
        RUN PD_CreateData2.
        RUN PD_Exportdatadt.
    END.
  END.
  WHEN 8 THEN DO:

    FOR EACH  IntPol7072 
       WHERE
            IntPol7072.InsuredSurname >= fi_From
       AND  IntPol7072.InsuredSurname <= fi_To
       AND  IntPol7072.CompanyCode     = fi_RequestorRs
    NO-LOCK:
        RUN PD_CreateData2.
        RUN PD_Exportdatadt.
    END.
  END.

  WHEN 9 THEN DO:

    FOR EACH  IntPol7072 
       WHERE
            IntPol7072.DocumentUID >= fi_From
       AND  IntPol7072.DocumentUID <= fi_To
       AND  IntPol7072.CompanyCode     = fi_RequestorRs
    NO-LOCK:
        RUN PD_CreateData2.
        RUN PD_Exportdatadt.
    END.

    FOR EACH  IntPol7072 
       WHERE
            IntPol7072.CMIDocumentUID >= fi_From
       AND  IntPol7072.CMIDocumentUID <= fi_To
       AND  IntPol7072.CompanyCode     = fi_RequestorRs
    NO-LOCK:
        RUN PD_CreateData2.
        RUN PD_Exportdatadt.
    END.
  END.

  WHEN 10 THEN DO:

    FOR EACH  IntPol7072 
       WHERE
            IntPol7072.CMIBarCodeNumber >= fi_From
       AND  IntPol7072.CMIBarCodeNumber <= fi_To
       AND  IntPol7072.CompanyCode       = fi_RequestorRs
    NO-LOCK:
        RUN PD_CreateData2.
        RUN PD_Exportdatadt.
    END.
  END.
END CASE.
*/
    
PUT STREAM ns2 "E".
OUTPUT STREAM ns2 CLOSE.   
DEF VAR nv_outfile1 AS CHAR INIT "".
IF INDEX(fi_outputfile,"\") <> 0      THEN nv_outfile1 = SUBSTR(fi_outputfile,1,R-INDEX(fi_outputfile,"\") ) .
ELSE IF INDEX(fi_outputfile,"/") <> 0 THEN nv_outfile1 = SUBSTR(fi_outputfile,1,R-INDEX(fi_outputfile,"/") ) .

FOR EACH  LoadFile USE-INDEX LoadFile03 NO-LOCK.
    ASSIGN
        SendReqBinData1 = LoadFile.AttachFile1
        SendReqBinData2 = LoadFile.AttachFile2
        SendReqBinData3 = LoadFile.AttachFile3.


    IF LoadFile.FileNameAttach1 <> "" THEN DO:
        OUTPUT TO VALUE(nv_outfile1 + LoadFile.FileNameAttach1).
        EXPORT SendReqBinData1.
        OUTPUT CLOSE.
    END.

END.
MESSAGE "Export file Complete" VIEW-AS ALERT-BOX.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_Exportdatadt C-Win 
PROCEDURE PD_Exportdatadt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN 
        n_record =  n_record + 1
        nv_cnt   =  nv_cnt  + 1 
        nv_row   =  nv_row  + 1.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"'  LoadFile.Seqno             '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"'  LoadFile.ProcessDate       '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"'  LoadFile.ProcessTime       '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"'  LoadFile.ConfirmBy         '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"'  LoadFile.PolicyTypeCd      '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"'  LoadFile.RateGroup         '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"'  LoadFile.GenSicBran        '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"'  LoadFile.PolicyNumber      '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"'  LoadFile.ContractNumber    '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"'  LoadFile.EffectiveDt       '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"'  LoadFile.ExpirationDt      '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"'  LoadFile.InsuredName       '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"'  LoadFile.ChassisVINNumber  '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"'  LoadFile.vehregF           '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"'  LoadFile.Sch_P             '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"'  LoadFile.DocumentUID       '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"'  LoadFile.CMIBarcodeNumber  '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"'  LoadFile.Manufacturer      '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"'  LoadFile.EndorseFlag       '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"'  LoadFile.ReceiptNumber     '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"'  LoadFile.COLLAmtAccident   '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"'  LoadFile.AppendNumber      '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"'  LoadFile.Agentno   '"' SKIP.   
      
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_Select C-Win 
PROCEDURE PD_Select :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/**/
  DEFINE VARIABLE nv_line              AS INTEGER.
  DEFINE VARIABLE nv_Row               AS RECID.
  DEFINE VARIABLE nv_LClaim            AS CHARACTER.
  DEFINE VARIABLE nv_FClaim            AS CHARACTER.
  DEFINE VARIABLE nv_RecLoadFile       AS RECID.
  DEFINE VARIABLE nv_ClaimOccurrenceRq AS CHARACTER.
  DEFINE VARIABLE nv_NotFound          AS CHARACTER.

  IF NOT AVAILABLE LoadFile THEN RETURN.
  /* */
  ASSIGN
  nv_rec_rq      = 0
  nv_rec_rq      = LoadFile.TEMPRecID
  nv_RecLoadFile = RECID(LoadFile).
  /* */

  IF nv_rec_rq = 0 OR nv_rec_rq = ? THEN RETURN.

  FIND INTPol7072 WHERE RECID(INTPol7072) = nv_rec_rq
  NO-LOCK NO-ERROR NO-WAIT.
  IF AVAILABLE INTPol7072 THEN DO:

      C-WIn:Hidden = Yes. /* ซ้อนโปรแกรมตัวเอง */

      RUN wgw\wgwrelt2 (INPUT RECID(INTPol7072), "POLICY").   /*UPDATE*/

      C-WIn:Hidden = NO.  /* กลับมาแสดงโปรแกรมตัวเองต่อ*/

  END.

  /* --
  nv_LClaim = "".
  nv_FClaim = "".
  nv_LClaim = LoadFile.FTMClaim.
  nv_ClaimOccurrenceRq = LoadFile.ClaimOccurrenceRq.
  -- */

  nv_row  = Recid(LoadFile).
  nv_line = br_Query:focused-row in frame {&FRAME-NAME}.
  /* */

  FIND INTPol7072 WHERE RECID(INTPol7072) = nv_rec_rq
  NO-LOCK NO-ERROR NO-WAIT.
  IF AVAILABLE INTPol7072 THEN DO:

    FIND LoadFile WHERE RECID(LoadFile) = nv_RecLoadFile
    NO-LOCK NO-ERROR NO-WAIT.
    IF AVAILABLE LoadFile THEN DO:

      IF INTPol7072.ContractNumber <> LoadFile.ContractNumber THEN DO:

        FIND LoadFile WHERE RECID(LoadFile) = nv_RecLoadFile
        NO-ERROR NO-WAIT.
        IF AVAILABLE LoadFile THEN
          LoadFile.ContractNumber = INTPol7072.ContractNumber.
      END.

      DISPLAY LoadFile.ContractNumber WITH BROWSE br_Query.
    END.
  END.

  /* ***************************************************************************
  
  FIND INTPol7072 WHERE RECID(INTPol7072) = nv_rec_rq
  NO-LOCK NO-ERROR NO-WAIT.
  IF AVAILABLE INTPol7072 THEN DO:

    nv_FClaim = INTPol7072.ClaimOccurrenceRq.

    FIND LoadFile WHERE RECID(LoadFile) = nv_RecLoadFile
    NO-ERROR NO-WAIT.
    IF AVAILABLE LoadFile THEN 
      ASSIGN LoadFile.LoadFile       = INTPol7072.LoadFile
             LoadFile.StatusResponse = INTPol7072.ResponseStatus
             LoadFile.SendDt         = INTPol7072.SendDt
             LoadFile.SendTime       = INTPol7072.SendTime .

    DISPLAY LoadFile.LoadFile  LoadFile.StatusResponse
            LoadFile.SendDt    LoadFile.SendTime
    WITH BROWSE br_Query.
  END.
  ELSE DO:

    FOR EACH LoadFile USE-INDEX LoadFile02 WHERE
             LoadFile.ClaimOccurrenceRq = nv_ClaimOccurrenceRq
    :

      DELETE LoadFile.
    END.

    nv_NotFound = "".

    FIND FIRST LoadFile NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAILABLE LoadFile THEN nv_NotFound = "F".

    RUN PD_Setseqno.

    {&OPEN-QUERY-br_Query}

    IF nv_NotFound <> "" THEN DO:

      APPLY "ENTRY" TO buOK.
      RETURN NO-APPLY.
    END.
  END.
  *************************************************************************** */

  APPLY "ENTRY" TO br_Query.
  RETURN NO-APPLY.

/**/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_Setseqno C-Win 
PROCEDURE PD_Setseqno :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* -----------------------------------------
       IF cb_Sort = "Process Date"     THEN nv_Sort = 1.
  ELSE IF cb_Sort = "Policy Number"    THEN nv_Sort = 2.
  ELSE IF cb_Sort = "Registration"     THEN nv_Sort = 3.
  ELSE IF cb_Sort = "Policy Type"      THEN nv_Sort = 4.
  ELSE IF cb_Sort = "Confirm By"       THEN nv_Sort = 5.
----------------------------------------- */
fi_Success = 0.

CASE nv_Sort:

  WHEN 1 THEN DO:  /*ProcessDate*/

    FOR EACH  LoadFile USE-INDEX LoadFile01 :

      fi_Success     = fi_Success + 1.
      LoadFile.Seqno = fi_Success.
    END.
  END.
  WHEN 2 THEN DO:  /*PolicyNumber*/

    FOR EACH  LoadFile USE-INDEX LoadFile02 :

      fi_Success     = fi_Success + 1.
      LoadFile.Seqno = fi_Success.
    END.
  END.
  WHEN 3 THEN DO:  /*Registration*/

    FOR EACH  LoadFile USE-INDEX LoadFile03 :

      fi_Success     = fi_Success + 1.
      LoadFile.Seqno = fi_Success.
    END.
  END.
  WHEN 4 THEN DO:  /*PolicyTypeCd*/

    FOR EACH  LoadFile USE-INDEX LoadFile04 :

      fi_Success     = fi_Success + 1.
      LoadFile.Seqno = fi_Success.
    END.
  END.

  WHEN 5 THEN DO:  /*ConfirmBy*/

    FOR EACH  LoadFile USE-INDEX LoadFile05 :

      fi_Success     = fi_Success + 1.
      LoadFile.Seqno = fi_Success.
    END.
  END.
  WHEN 6 THEN DO:  /*Registration_Dup*/

    FOR EACH  LoadFile USE-INDEX LoadFile03 
        WHERE LoadFile.COUNT_no > 0  :

      fi_Success     = fi_Success + 1.
      LoadFile.Seqno = fi_Success.
    END.
  END.

END CASE.

/**/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

