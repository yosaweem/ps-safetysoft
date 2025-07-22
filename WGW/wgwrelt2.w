&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
*/
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*************************************************************************
 WRSQReqP11.W : Query Detail Policy
                SUB PROGRAM WRSQReqP.W
 Copyright    : Safety Insurance Public Company Limited
                บริษัท ประกันคุ้มภัย จำกัด (มหาชน)
 ------------------------------------------------------------------------                 
 Database     : BUInt
 ------------------------------------------------------------------------                
 CREATE BY  : kridtiya i. A61-0482 Date. 08/10/2018 โปรแกรม สำหรับ แสดงข้อมูลกรมธรรม์
 
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
DEFINE INPUT PARAMETER  nv_RecordID AS RECID     NO-UNDO. /* RECORD ID ExtPolicy, ExtEndorse */
DEFINE INPUT PARAMETER  nv_if       AS CHARACTER NO-UNDO. /* "POLICY","ENDORSE" */

/* Local Variable Definitions ---                                       */

DEFINE VARIABLE nv_dd         AS INTEGER   NO-UNDO. 
DEFINE VARIABLE nv_mm         AS INTEGER   NO-UNDO. 
DEFINE VARIABLE nv_yyyy       AS INTEGER   NO-UNDO. 
DEFINE VARIABLE nv_seqno      AS INTEGER   NO-UNDO. 
DEFINE VARIABLE nv_hasfile    AS LOGICAL   NO-UNDO. 
DEFINE VARIABLE nv_listfile   AS CHARACTER NO-UNDO. 
DEFINE VARIABLE nv_SAVEFile   AS MEMPTR    NO-UNDO.
DEFINE VARIABLE nv_CheckFile  AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_changedir  AS CHARACTER FORMAT "X(150)" NO-UNDO.
DEFINE VARIABLE nv_filename   AS CHARACTER FORMAT "X(50)"  NO-UNDO.
DEFINE VARIABLE nv_IChoice    AS LOGICAL NO-UNDO.

DEFINE STREAM xmlstream.

DEFINE NEW SHARED TEMP-TABLE  LFileAtt   NO-UNDO
FIELD Selectno    AS CHARACTER FORMAT "X(2)"  INITIAL ""
FIELD FileNam     AS CHARACTER FORMAT "X(15)" INITIAL ""
FIELD FileAtt     AS BLOB      INITIAL ?
INDEX LFileAtt01  IS PRIMARY  Selectno ASCENDING .
/* ---
DEFINE NEW SHARED TEMP-TABLE ctemp NO-UNDO
  FIELD dirtext         AS CHARACTER FORMAT "X(100)"  INITIAL ""
.
DEFINE NEW SHARED TEMP-TABLE cdir  NO-UNDO
  FIELD DirName         AS CHARACTER FORMAT "X(150)"  INITIAL ""
  FIELD FilNAME         AS CHARACTER FORMAT "X(50)"   INITIAL ""
  FIELD UseFileName     AS CHARACTER FORMAT "X(200)"  INITIAL ""
.
--- */
DEFINE  SHARED TEMP-TABLE ctemp NO-UNDO
  FIELD dirtext         AS CHARACTER FORMAT "X(100)"  INITIAL ""
.
DEFINE  SHARED TEMP-TABLE cdir  NO-UNDO
  FIELD DirName         AS CHARACTER FORMAT "X(150)"  INITIAL ""
  FIELD FilNAME         AS CHARACTER FORMAT "X(50)"   INITIAL ""
  FIELD UseFileName     AS CHARACTER FORMAT "X(200)"  INITIAL ""
.

DEFINE TEMP-TABLE TFileAttach NO-UNDO
FIELD  FileNAMEAttach         AS CHARACTER FORMAT "X(20)" INITIAL ""
FIELD  FileBinary             AS BLOB.
/* -------------------------------------------------------------------- */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME br_ExtResult

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES IntPol7072Result LFileAtt

/* Definitions for BROWSE br_ExtResult                                  */
&Scoped-define FIELDS-IN-QUERY-br_ExtResult /* */ IntPol7072Result.ResultStatus IntPol7072Result.ContractNumber IntPol7072Result.PolicyNumber IntPol7072Result.CMIPolicyNumber IntPol7072Result.Policy /* IntPol7072Result.ErrorCode */ IntPol7072Result.ErrorMessage IntPol7072Result.TransactionResponseDt IntPol7072Result.TransactionResponseTime /* */   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_ExtResult   
&Scoped-define SELF-NAME br_ExtResult
&Scoped-define OPEN-QUERY-br_ExtResult /**/ /* IF nv_if = "POLICY" THEN  DO: */   OPEN QUERY {&SELF-NAME}     FOR EACH IntPol7072Result WHERE              IntPol7072Result.CompanyCode    = IntPol7072.CompanyCode          AND IntPol7072Result.ContractNumber = IntPol7072.ContractNumber   NO-LOCK. /* BREAK BY IntPol7072Result.ErrorCode. */.
&Scoped-define TABLES-IN-QUERY-br_ExtResult IntPol7072Result
&Scoped-define FIRST-TABLE-IN-QUERY-br_ExtResult IntPol7072Result


/* Definitions for BROWSE br_FileAtt                                    */
&Scoped-define FIELDS-IN-QUERY-br_FileAtt /* */ LFileAtt.Selectno LFileAtt.FileNam /* LFileAtt.FileAtt */ /* */   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_FileAtt   
&Scoped-define SELF-NAME br_FileAtt
&Scoped-define OPEN-QUERY-br_FileAtt /**/ OPEN QUERY {&SELF-NAME} FOR EACH LFileAtt NO-LOCK.
&Scoped-define TABLES-IN-QUERY-br_FileAtt LFileAtt
&Scoped-define FIRST-TABLE-IN-QUERY-br_FileAtt LFileAtt


/* Definitions for FRAME DEFAULT-FRAME                                  */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS br_ExtResult buExit bu_file bu_Open ~
bu_LoadFile buCancel br_FileAtt 
&Scoped-Define DISPLAYED-OBJECTS fiMess fiBY 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON buCancel 
     LABEL "Cancel" 
     SIZE 10 BY 1
     BGCOLOR 4 FONT 6.

DEFINE BUTTON buExit 
     LABEL "Exit" 
     SIZE 10 BY 1.1
     FONT 6.

DEFINE BUTTON bu_file 
     LABEL "Save AS" 
     SIZE 13 BY 1
     BGCOLOR 3 FONT 6.

DEFINE BUTTON bu_LoadFile 
     LABEL "Load *.PDF" 
     SIZE 13 BY 1
     BGCOLOR 3 FONT 6.

DEFINE BUTTON bu_Open 
     LABEL "Opend File" 
     SIZE 13 BY 1
     BGCOLOR 3 FONT 6.

DEFINE VARIABLE fiBY AS CHARACTER FORMAT "X(50)":U 
      VIEW-AS TEXT 
     SIZE 44 BY .71
     BGCOLOR 3 FGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiMess AS CHARACTER FORMAT "X(50)":U 
      VIEW-AS TEXT 
     SIZE 50 BY .71
     FGCOLOR 6 FONT 7 NO-UNDO.

DEFINE RECTANGLE RECT-8
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 46 BY 1.1
     BGCOLOR 3 .

DEFINE BUTTON buDriverName 
     LABEL "DriverName" 
     SIZE 12 BY .91.

DEFINE BUTTON buMessage 
     LABEL "View Message" 
     SIZE 14 BY .71.

DEFINE BUTTON buViewOTHER 
     LABEL "View Other" 
     SIZE 12 BY .81.

DEFINE VARIABLE fi_Addr AS CHARACTER FORMAT "X(120)":U 
     LABEL "ที่อยู่" 
      VIEW-AS TEXT 
     SIZE 115 BY .81
     FGCOLOR 5 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_AgencyEmployee AS CHARACTER FORMAT "X(40)":U 
     LABEL "ผู้แจ้ง" 
      VIEW-AS TEXT 
     SIZE 20 BY .81
     FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_AgentBrokerLicenseNumber AS CHARACTER FORMAT "X(10)":U 
     LABEL "Ac/Br Code" 
      VIEW-AS TEXT 
     SIZE 12 BY .81 TOOLTIP "Agent / Broker License Number"
     FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_ApplicationNumber AS CHARACTER FORMAT "X(50)":U 
     LABEL "Q.ChkPrm" 
      VIEW-AS TEXT 
     SIZE 13 BY .71 TOOLTIP "เลขคิวเช็คเบี้ย ของทาง BU"
     FGCOLOR 4  NO-UNDO.

DEFINE VARIABLE fi_ApproveBy AS CHARACTER FORMAT "X(15)":U 
     LABEL "ชื่อผู้ Approve" 
      VIEW-AS TEXT 
     SIZE 15 BY .71
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_ApproveDt AS DATE FORMAT "99/99/9999":U 
      VIEW-AS TEXT 
     SIZE 10 BY .71
     FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_ApproveText AS CHARACTER FORMAT "X(150)":U 
     LABEL "Remark" 
      VIEW-AS TEXT 
     SIZE 42 BY .71
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_ApproveTime AS CHARACTER FORMAT "X(10)":U 
      VIEW-AS TEXT 
     SIZE 8 BY .71
     FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_BranchCd AS CHARACTER FORMAT "X(10)":U 
     LABEL "สาขา Broker/Finance" 
      VIEW-AS TEXT 
     SIZE 13 BY .81
     FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_ChassisVINNumber AS CHARACTER FORMAT "X(40)":U 
     LABEL "เลขตัวรถ/เลขตัวถัง" 
      VIEW-AS TEXT 
     SIZE 34 BY .81
     FGCOLOR 5  NO-UNDO.

DEFINE VARIABLE fi_ChkVehAssignDt AS DATE FORMAT "99/99/9999":U 
      VIEW-AS TEXT 
     SIZE 10 BY .71
     FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_ChkVehAssignTime AS CHARACTER FORMAT "X(10)":U 
      VIEW-AS TEXT 
     SIZE 8 BY .71
     FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_ChkVehBy AS CHARACTER FORMAT "X(50)":U 
     LABEL "ตรวจสภาพรถโดย" 
      VIEW-AS TEXT 
     SIZE 42 BY .71
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_ChkVehicle AS LOGICAL FORMAT "yes/no":U INITIAL NO 
     LABEL "ส่งตรวจสภาพรถ" 
      VIEW-AS TEXT 
     SIZE 5 BY .71
     BGCOLOR 15 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_CMIApplication AS CHARACTER FORMAT "X(40)":U 
     LABEL "CMIApp. no." 
      VIEW-AS TEXT 
     SIZE 30 BY .81
     FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_CMIDocumentUID AS CHARACTER FORMAT "X(10)":U 
     LABEL "CMIDocno." 
      VIEW-AS TEXT 
     SIZE 13 BY .81
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_CMIEffectiveDt AS DATE FORMAT "99/99/9999":U 
     LABEL "วันที่เริ่มต้น" 
      VIEW-AS TEXT 
     SIZE 13 BY .81
     FGCOLOR 5 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_CMIExpirationDt AS DATE FORMAT "99/99/9999":U 
     LABEL "วันที่สิ้นสุด" 
      VIEW-AS TEXT 
     SIZE 13 BY .81
     FGCOLOR 5 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_CMIPolicyNumber AS CHARACTER FORMAT "X(22)":U 
     LABEL "เลขกรมธรรม์ พรบ." 
     VIEW-AS FILL-IN 
     SIZE 20 BY .81
     FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_CMVApplication AS CHARACTER FORMAT "X(40)":U 
     LABEL "VMI App. no." 
      VIEW-AS TEXT 
     SIZE 20 BY .81
     FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_COLLAmtAccident AS INTEGER FORMAT "->>>,>>>,>>9":U INITIAL 0 
     LABEL "Own Damage" 
      VIEW-AS TEXT 
     SIZE 18 BY .81
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_CompanyCode AS CHARACTER FORMAT "X(15)":U 
     LABEL "รหัส Broker/Finance" 
      VIEW-AS TEXT 
     SIZE 15 BY .81
     FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_ConfirmBy AS CHARACTER FORMAT "X(15)":U 
     LABEL "ตรวจสอบข้อมูล โดย" 
      VIEW-AS TEXT 
     SIZE 15 BY .71
     BGCOLOR 15 FGCOLOR 5 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_ContractDt AS DATE FORMAT "99/99/9999":U 
     LABEL "วันทำสัญญา" 
      VIEW-AS TEXT 
     SIZE 11 BY .81
     FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_ContractNumber AS CHARACTER FORMAT "X(30)":U 
     LABEL "หมายเลขอ้างอิง" 
     VIEW-AS FILL-IN 
     SIZE 22 BY .81 TOOLTIP "เลขที่สัญญา หรือเลขที่รับแจ้ง"
     FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_Displacement AS CHARACTER FORMAT "X(6)":U 
     LABEL "ขนาดเครื่องยนต์" 
      VIEW-AS TEXT 
     SIZE 6 BY .81
     FGCOLOR 5 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_DocumentUID AS CHARACTER FORMAT "X(10)":U 
     LABEL "VMI Docno." 
      VIEW-AS TEXT 
     SIZE 13 BY .81
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_DriverNameCd AS LOGICAL FORMAT "Yes/No":U INITIAL NO 
     LABEL "ระบุชื่อ" 
      VIEW-AS TEXT 
     SIZE 5 BY .81
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_EffectiveDt AS DATE FORMAT "99/99/9999":U 
     LABEL "วันที่เริ่มต้น" 
      VIEW-AS TEXT 
     SIZE 13 BY .81
     FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_EndDt AS DATE FORMAT "99/99/9999":U 
     LABEL "วันที่สิ้นสุด" 
      VIEW-AS TEXT 
     SIZE 13 BY .81
     FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_EngineSerialNumber AS CHARACTER FORMAT "X(40)":U 
     LABEL "เลขเครื่องยนต์" 
      VIEW-AS TEXT 
     SIZE 35 BY .71
     FGCOLOR 5  NO-UNDO.

DEFINE VARIABLE fi_Finint AS CHARACTER FORMAT "X(10)":U 
     LABEL "Finint" 
      VIEW-AS TEXT 
     SIZE 12 BY .81 TOOLTIP "Agent / Broker License Number"
     FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_FTAmt AS INTEGER FORMAT "->>>,>>>,>>9":U INITIAL 0 
     LABEL "Fire&Theft" 
      VIEW-AS TEXT 
     SIZE 18 BY .81
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_GarageCd AS CHARACTER FORMAT "X(10)":U 
     LABEL "Garage" 
      VIEW-AS TEXT 
     SIZE 2 BY .81
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_GarageDesc AS CHARACTER FORMAT "X(15)":U 
      VIEW-AS TEXT 
     SIZE 15 BY .81
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_GenSicBran AS LOGICAL FORMAT "Yes/No":U INITIAL NO 
     LABEL "Create Policy no." 
      VIEW-AS TEXT 
     SIZE 4 BY .71
     FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_GenSicBranDt AS DATE FORMAT "99/99/9999":U 
      VIEW-AS TEXT 
     SIZE 10 BY .71
     FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_GenSicBranText AS CHARACTER FORMAT "X(60)":U 
     LABEL "Text" 
      VIEW-AS TEXT 
     SIZE 56 BY .71
     FGCOLOR 4  NO-UNDO.

DEFINE VARIABLE fi_GenSicBranTime AS CHARACTER FORMAT "X(10)":U 
      VIEW-AS TEXT 
     SIZE 8 BY .71
     FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_GrossVehOrCombinedWeight AS CHARACTER FORMAT "X(6)":U 
     LABEL "น้ำหนักบรรทุก" 
      VIEW-AS TEXT 
     SIZE 6 BY .81
     FGCOLOR 5 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_IDText AS CHARACTER FORMAT "X(20)":U 
      VIEW-AS TEXT 
     SIZE 13 BY .81 TOOLTIP "วันที่บัตรปชช หรือ Passport หมดอายุ / วันที่เริ่มต้นนิติบุคคล" NO-UNDO.

DEFINE VARIABLE fi_InsuranceBranchCd AS CHARACTER FORMAT "X(5)":U 
     LABEL "Branch" 
      VIEW-AS TEXT 
     SIZE 4 BY .81
     FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_InsuredBranch AS CHARACTER FORMAT "X(8)":U 
     LABEL "ลำดับที่สาขาลูกค้า" 
      VIEW-AS TEXT 
     SIZE 8 BY .81 TOOLTIP "รองรับตามประกาศอธิบดีกรมสรรพากร ฉบับที่ 194-197"
     FGCOLOR 5  NO-UNDO.

DEFINE VARIABLE fi_InsuredName AS CHARACTER FORMAT "X(80)":U 
     LABEL "ชื่อ-สกุล ลูกค้า" 
      VIEW-AS TEXT 
     SIZE 60 BY .81
     FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_InsuredType AS CHARACTER FORMAT "X(15)":U 
     LABEL "ประเภท UniqueID" 
      VIEW-AS TEXT 
     SIZE 15 BY .81
     FGCOLOR 5  NO-UNDO.

DEFINE VARIABLE fi_InsuredUniqueID AS CHARACTER FORMAT "X(15)":U 
     LABEL "UniqueID" 
      VIEW-AS TEXT 
     SIZE 16 BY .81 TOOLTIP "เลขที่บัตรปชช. เลขที่Passport เลขที่นิติบุคคคล"
     FGCOLOR 5  NO-UNDO.

DEFINE VARIABLE fi_InsuredUniqueIDExpirationDt AS DATE FORMAT "99/99/9999":U 
      VIEW-AS TEXT 
     SIZE 13 BY .81 TOOLTIP "วันที่บัตรปชช หรือ Passport หมดอายุ / วันที่เริ่มต้นนิติบุคคล"
     FGCOLOR 5  NO-UNDO.

DEFINE VARIABLE fi_Manufacturer AS CHARACTER FORMAT "X(40)":U 
     LABEL "ยี่ห้อรถ" 
      VIEW-AS TEXT 
     SIZE 35 BY .81
     FGCOLOR 5 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_member AS CHARACTER FORMAT "X(15)":U 
     LABEL "สมาชิก" 
      VIEW-AS TEXT 
     SIZE 13 BY .81
     FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_Model AS CHARACTER FORMAT "X(40)":U 
     LABEL "รุ่นรถ" 
      VIEW-AS TEXT 
     SIZE 40 BY .81
     FGCOLOR 5 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_ModelYear AS CHARACTER FORMAT "X(6)":U 
     LABEL "ปีรถ" 
      VIEW-AS TEXT 
     SIZE 6 BY .81
     FGCOLOR 5 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_PhoneNumber AS CHARACTER FORMAT "X(80)":U 
     LABEL "โทร." 
      VIEW-AS TEXT 
     SIZE 52 BY .81
     FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_PlateNumber AS CHARACTER FORMAT "X(15)":U 
     LABEL "เลขทะเบียนรถ" 
      VIEW-AS TEXT 
     SIZE 12 BY .81
     FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_policy AS CHARACTER FORMAT "X(40)":U 
     LABEL "Q.Pol" 
      VIEW-AS TEXT 
     SIZE 17 BY .71 TOOLTIP "Quotation Number"
     FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_PolicyNumber AS CHARACTER FORMAT "X(22)":U 
     LABEL "เลขกรมธรรม์" 
     VIEW-AS FILL-IN 
     SIZE 22 BY .81
     FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_PolicyStatus AS CHARACTER FORMAT "X(5)":U 
     LABEL "P.Status" 
      VIEW-AS TEXT 
     SIZE 5 BY .81 TOOLTIP "Policy Status"
     FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_PolicyTypeCd AS CHARACTER FORMAT "X(10)":U 
     LABEL "ี่กรมธรรม์ประเภท" 
      VIEW-AS TEXT 
     SIZE 6 BY .81
     FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_PreviousPolicyNumber AS CHARACTER FORMAT "X(40)":U 
     LABEL "Prev.Policy no." 
      VIEW-AS TEXT 
     SIZE 20 BY .81
     FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_RateGroup AS CHARACTER FORMAT "X(5)":U 
     LABEL "รหัสประเภทรถ" 
      VIEW-AS TEXT 
     SIZE 5 BY .81
     FGCOLOR 5 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_ReceiptNumber AS CHARACTER FORMAT "X(20)":U 
     LABEL "P./Campaign" 
      VIEW-AS TEXT 
     SIZE 23.33 BY .71 TOOLTIP "Promotion or Campaign for BU"
     FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_ReferenceNumber AS CHARACTER FORMAT "X(40)":U 
     LABEL "เลขที่ Unique ID" 
      VIEW-AS TEXT 
     SIZE 46 BY .71
     BGCOLOR 15 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_RegisteredProvinceCode AS CHARACTER FORMAT "X(15)":U 
     LABEL "รหัสจว.ทะเบียนรถ" 
      VIEW-AS TEXT 
     SIZE 15 BY .81
     FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_RemarkText AS CHARACTER FORMAT "X(150)":U 
     LABEL "หมายเหตุการส่ง" 
      VIEW-AS TEXT 
     SIZE 25 BY .71
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_Rencnt AS CHARACTER FORMAT "X(8)":U INITIAL "0" 
     LABEL "Ren/End" 
      VIEW-AS TEXT 
     SIZE 6 BY .81
     FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_ResultStatus AS CHARACTER FORMAT "X(15)":U 
     LABEL "การส่งข้อมูลเข้าระบบ" 
      VIEW-AS TEXT 
     SIZE 15 BY .71
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_RevenueStampAmt AS CHARACTER FORMAT "X(10)":U 
     LABEL "อากร" 
      VIEW-AS TEXT 
     SIZE 12 BY .81
     FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_RevenueStampAmt2 AS CHARACTER FORMAT "X(10)":U 
     LABEL "อากร แสตมป์" 
      VIEW-AS TEXT 
     SIZE 12 BY .81
     BGCOLOR 15 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_SeatingCapacity AS CHARACTER FORMAT "X(6)":U 
     LABEL "จำนวนที่นั่ง" 
      VIEW-AS TEXT 
     SIZE 6 BY .81
     FGCOLOR 5 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_SendDate AS DATE FORMAT "99/99/9999":U 
      VIEW-AS TEXT 
     SIZE 10 BY .71 TOOLTIP "วันที่ส่งผลตรวจสภาพรถกลับ"
     FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_SendTime AS CHARACTER FORMAT "X(10)":U 
      VIEW-AS TEXT 
     SIZE 8 BY .71 TOOLTIP "เวลาที่ส่งผลตรวจสภาพรถกลับ"
     FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_Status AS CHARACTER FORMAT "X(2)":U 
     LABEL "Status" 
      VIEW-AS TEXT 
     SIZE 4 BY .71
     BGCOLOR 15 FGCOLOR 3 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_Statusflag AS CHARACTER FORMAT "X(40)":U 
     LABEL "S.Flag" 
      VIEW-AS TEXT 
     SIZE 17 BY .71
     FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_StickerNumber AS CHARACTER FORMAT "X(22)":U 
     LABEL "StickerNumber" 
      VIEW-AS TEXT 
     SIZE 20 BY .81
     FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_SystemErrorStatus1 AS CHARACTER FORMAT "X(150)":U 
     LABEL "System Error Status" 
      VIEW-AS TEXT 
     SIZE 102 BY .71
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_test1 AS CHARACTER FORMAT "X(256)":U 
     LABEL "ผู้รับผลประโยชน์" 
     VIEW-AS FILL-IN 
     SIZE 117 BY .81
     FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_test2 AS CHARACTER FORMAT "X(256)":U 
     LABEL "ออกใบเสร็จในนาม1" 
     VIEW-AS FILL-IN 
     SIZE 117 BY .81
     FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_test3 AS CHARACTER FORMAT "X(256)":U 
     LABEL "ที่อยู่ในใบเสร็จ1" 
     VIEW-AS FILL-IN 
     SIZE 117 BY .81 NO-UNDO.

DEFINE VARIABLE fi_Total AS DECIMAL FORMAT "->>>,>>9.99":U INITIAL 0 
     LABEL "รวม" 
      VIEW-AS TEXT 
     SIZE 18 BY .81
     FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_Total2 AS DECIMAL FORMAT "->>>,>>9.99":U INITIAL 0 
     LABEL "รวม" 
      VIEW-AS TEXT 
     SIZE 15 BY .81
     BGCOLOR 15 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_TranDate AS DATE FORMAT "99/99/9999":U 
      VIEW-AS TEXT 
     SIZE 10 BY .71 TOOLTIP "Transaction Date"
     FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_TranTime AS CHARACTER FORMAT "X(10)":U 
      VIEW-AS TEXT 
     SIZE 8 BY .71 TOOLTIP "Transaction Time"
     FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_VatAmt AS CHARACTER FORMAT "X(10)":U 
     LABEL "ภาษี" 
      VIEW-AS TEXT 
     SIZE 12 BY .81
     FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_VatAmt2 AS CHARACTER FORMAT "X(10)":U 
     LABEL "ภาษี Vat" 
      VIEW-AS TEXT 
     SIZE 10 BY .81
     BGCOLOR 15 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_VehBodyTypeDesc AS CHARACTER FORMAT "X(20)":U 
     LABEL "ลักษณะตัวรถ" 
      VIEW-AS TEXT 
     SIZE 20 BY .81
     FGCOLOR 5 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_VehicleTypeCode AS CHARACTER FORMAT "X(5)":U 
     LABEL "รหัสประเภทรถ" 
      VIEW-AS TEXT 
     SIZE 8 BY .81
     FGCOLOR 5 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_vehreg AS CHARACTER FORMAT "X(15)":U 
     LABEL "Veh.Reg." 
     VIEW-AS FILL-IN 
     SIZE 15 BY .81
     BGCOLOR 15 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_WrittenAmt AS CHARACTER FORMAT "X(10)":U 
     LABEL "เบี้ยสุทธิ" 
      VIEW-AS TEXT 
     SIZE 13 BY .81
     FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_WrittenAmt2 AS CHARACTER FORMAT "X(12)":U 
     LABEL "เบี้ยสุทธิ" 
      VIEW-AS TEXT 
     SIZE 12 BY .81
     FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE rd_approve AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Approve", 1,
"Cancel", 2,
"none", 3
     SIZE 30 BY .71
     FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-10
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 133.67 BY .24
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 133.67 BY .24
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 116.67 BY .1
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 116.67 BY .1
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 116.67 BY .1
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-9
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 116.67 BY .1
     BGCOLOR 8 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_ExtResult FOR 
      IntPol7072Result SCROLLING.

DEFINE QUERY br_FileAtt FOR 
      LFileAtt SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_ExtResult
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_ExtResult C-Win _FREEFORM
  QUERY br_ExtResult DISPLAY
      /* */
IntPol7072Result.ResultStatus    COLUMN-LABEL "Result"            FORMAT "x(9)"
IntPol7072Result.ContractNumber  COLUMN-LABEL "Contract Number"   FORMAT "x(18)"
IntPol7072Result.PolicyNumber    COLUMN-LABEL "Policy Number"     FORMAT "x(14)"
IntPol7072Result.CMIPolicyNumber COLUMN-LABEL "CMI Policy no"     FORMAT "x(14)"
IntPol7072Result.Policy          COLUMN-LABEL "Policy no."        FORMAT "x(14)"
/*
IntPol7072Result.ErrorCode       COLUMN-LABEL "Error Code" */
IntPol7072Result.ErrorMessage    COLUMN-LABEL "Error Message"
IntPol7072Result.TransactionResponseDt   COLUMN-LABEL "TrnDtRs"
IntPol7072Result.TransactionResponseTime COLUMN-LABEL "TrnTimeRs"
/* */
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS NO-TAB-STOP SIZE 91 BY 3.38 ROW-HEIGHT-CHARS .62.

DEFINE BROWSE br_FileAtt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_FileAtt C-Win _FREEFORM
  QUERY br_FileAtt DISPLAY
      /* */
LFileAtt.Selectno  COLUMN-LABEL "no."
LFileAtt.FileNam   COLUMN-LABEL "File Name"   FORMAT "x(25)"
/*
LFileAtt.FileAtt   COLUMN-LABEL "File Attach" */
/* */
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS NO-TAB-STOP SIZE 30 BY 3.38 ROW-HEIGHT-CHARS .62.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     br_ExtResult AT ROW 26.57 COL 1.5 WIDGET-ID 400
     buExit AT ROW 1.1 COL 121 WIDGET-ID 90
     bu_file AT ROW 26.62 COL 123.5 WIDGET-ID 204
     fiMess AT ROW 1.24 COL 48.33 NO-LABEL WIDGET-ID 98
     fiBY AT ROW 1.29 COL 2.17 NO-LABEL WIDGET-ID 180
     bu_Open AT ROW 27.71 COL 123.5 WIDGET-ID 206
     bu_LoadFile AT ROW 28.91 COL 123.5 WIDGET-ID 208
     buCancel AT ROW 1.14 COL 105.83 WIDGET-ID 210
     br_FileAtt AT ROW 26.57 COL 92.83 WIDGET-ID 500
     RECT-8 AT ROW 1.1 COL 1.5 WIDGET-ID 178
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 136 BY 28.95 DROP-TARGET WIDGET-ID 100.

DEFINE FRAME frDisp
     fi_PolicyNumber AT ROW 3.14 COL 16.17 COLON-ALIGNED WIDGET-ID 248
     fi_vehreg AT ROW 10 COL 93 COLON-ALIGNED WIDGET-ID 194
     rd_approve AT ROW 22.29 COL 9 NO-LABEL WIDGET-ID 334
     fi_ConfirmBy AT ROW 21.48 COL 16.17 COLON-ALIGNED WIDGET-ID 322
     buMessage AT ROW 24.14 COL 121.17 WIDGET-ID 210
     fi_ChkVehicle AT ROW 21.48 COL 48.83 COLON-ALIGNED WIDGET-ID 324
     fi_ContractNumber AT ROW 4.05 COL 16.17 COLON-ALIGNED WIDGET-ID 30
     fi_ChkVehBy AT ROW 21.48 COL 71.83 COLON-ALIGNED WIDGET-ID 330
     fi_CMIPolicyNumber AT ROW 15.57 COL 16.17 COLON-ALIGNED WIDGET-ID 290
     fi_ApproveBy AT ROW 22.24 COL 48.83 COLON-ALIGNED WIDGET-ID 332
     buDriverName AT ROW 11.62 COL 123 WIDGET-ID 374
     fi_ApproveText AT ROW 22.24 COL 71.83 COLON-ALIGNED WIDGET-ID 340
     buViewOTHER AT ROW 5.76 COL 123.33 WIDGET-ID 378
     fi_test3 AT ROW 20.14 COL 16 COLON-ALIGNED WIDGET-ID 408
     fi_GenSicBranText AT ROW 1.19 COL 56 COLON-ALIGNED WIDGET-ID 282
     fi_Status AT ROW 1.19 COL 6 COLON-ALIGNED WIDGET-ID 214
     fi_test2 AT ROW 19.19 COL 16 COLON-ALIGNED WIDGET-ID 406
     fi_test1 AT ROW 18.14 COL 16 COLON-ALIGNED WIDGET-ID 404
     fi_GenSicBran AT ROW 1.19 COL 26.17 COLON-ALIGNED WIDGET-ID 280
     fi_GenSicBranDt AT ROW 1.19 COL 32 COLON-ALIGNED NO-LABEL WIDGET-ID 276
     fi_GenSicBranTime AT ROW 1.19 COL 42.17 COLON-ALIGNED NO-LABEL WIDGET-ID 278
     fi_CompanyCode AT ROW 2.29 COL 16.17 COLON-ALIGNED WIDGET-ID 250
     fi_BranchCd AT ROW 2.29 COL 51.5 COLON-ALIGNED WIDGET-ID 252
     fi_AgencyEmployee AT ROW 5.76 COL 99.83 COLON-ALIGNED WIDGET-ID 246
     fi_PolicyTypeCd AT ROW 4.91 COL 16.17 COLON-ALIGNED WIDGET-ID 286
     fi_RateGroup AT ROW 4.91 COL 51.5 COLON-ALIGNED WIDGET-ID 34
     fi_TranDate AT ROW 2.24 COL 114.83 COLON-ALIGNED NO-LABEL WIDGET-ID 196
     fi_EffectiveDt AT ROW 5.76 COL 16.17 COLON-ALIGNED WIDGET-ID 52
     fi_EndDt AT ROW 5.76 COL 39.83 COLON-ALIGNED WIDGET-ID 54
     fi_ContractDt AT ROW 5.76 COL 64.33 COLON-ALIGNED WIDGET-ID 106
     fi_TranTime AT ROW 2.24 COL 125.17 COLON-ALIGNED NO-LABEL WIDGET-ID 180
     fi_InsuredType AT ROW 7 COL 16.17 COLON-ALIGNED WIDGET-ID 262
     fi_InsuredUniqueID AT ROW 7 COL 51.5 COLON-ALIGNED WIDGET-ID 136
     fi_IDText AT ROW 7 COL 84.67 RIGHT-ALIGNED NO-LABEL WIDGET-ID 272
     fi_InsuredUniqueIDExpirationDt AT ROW 7 COL 84 COLON-ALIGNED NO-LABEL WIDGET-ID 266
     fi_InsuredBranch AT ROW 7 COL 121.67 COLON-ALIGNED WIDGET-ID 236
     fi_InsuredName AT ROW 7.86 COL 16.17 COLON-ALIGNED WIDGET-ID 46
     fi_Addr AT ROW 8.71 COL 16.17 COLON-ALIGNED WIDGET-ID 238
     fi_RegisteredProvinceCode AT ROW 10 COL 16.17 COLON-ALIGNED WIDGET-ID 102
     fi_PlateNumber AT ROW 10 COL 62 COLON-ALIGNED WIDGET-ID 140
     fi_Manufacturer AT ROW 10.86 COL 16.17 COLON-ALIGNED WIDGET-ID 98
     fi_Model AT ROW 10.86 COL 62 COLON-ALIGNED WIDGET-ID 220
     fi_Displacement AT ROW 12.57 COL 16.17 COLON-ALIGNED WIDGET-ID 230
     fi_GrossVehOrCombinedWeight AT ROW 12.57 COL 62 COLON-ALIGNED WIDGET-ID 232
     fi_SeatingCapacity AT ROW 12.57 COL 93 COLON-ALIGNED WIDGET-ID 234
     fi_ModelYear AT ROW 12.57 COL 114.83 COLON-ALIGNED WIDGET-ID 228
     fi_ChassisVINNumber AT ROW 13.43 COL 16.17 COLON-ALIGNED WIDGET-ID 224
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.5 ROW 2.24
         SIZE 135 BY 24.24
         BGCOLOR 15  WIDGET-ID 300.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME frDisp
     fi_EngineSerialNumber AT ROW 14.29 COL 16.17 COLON-ALIGNED WIDGET-ID 226
     fi_WrittenAmt AT ROW 14.29 COL 62 COLON-ALIGNED WIDGET-ID 240
     fi_RevenueStampAmt AT ROW 14.29 COL 80.67 COLON-ALIGNED WIDGET-ID 242
     fi_VatAmt AT ROW 14.29 COL 97.83 COLON-ALIGNED WIDGET-ID 244
     fi_Total AT ROW 14.29 COL 114.83 COLON-ALIGNED WIDGET-ID 292
     fi_VehicleTypeCode AT ROW 15.57 COL 62 COLON-ALIGNED WIDGET-ID 288
     fi_StickerNumber AT ROW 15.57 COL 93 COLON-ALIGNED WIDGET-ID 222
     fi_CMIEffectiveDt AT ROW 16.43 COL 16.17 COLON-ALIGNED WIDGET-ID 316
     fi_CMIExpirationDt AT ROW 16.43 COL 62 COLON-ALIGNED WIDGET-ID 318
     fi_WrittenAmt2 AT ROW 17.29 COL 16.17 COLON-ALIGNED WIDGET-ID 314
     fi_RevenueStampAmt2 AT ROW 17.29 COL 44 COLON-ALIGNED WIDGET-ID 308
     fi_VatAmt2 AT ROW 17.29 COL 68 COLON-ALIGNED WIDGET-ID 312
     fi_Total2 AT ROW 17.29 COL 93 COLON-ALIGNED WIDGET-ID 310
     fi_ChkVehAssignDt AT ROW 21.48 COL 115 COLON-ALIGNED NO-LABEL WIDGET-ID 326
     fi_ChkVehAssignTime AT ROW 21.48 COL 125.17 COLON-ALIGNED NO-LABEL WIDGET-ID 328
     fi_ApproveDt AT ROW 22.24 COL 115 COLON-ALIGNED NO-LABEL WIDGET-ID 342
     fi_ApproveTime AT ROW 22.24 COL 125.17 COLON-ALIGNED NO-LABEL WIDGET-ID 344
     fi_ResultStatus AT ROW 23.33 COL 16.17 COLON-ALIGNED WIDGET-ID 74
     fi_RemarkText AT ROW 23.33 COL 46 COLON-ALIGNED WIDGET-ID 256
     fi_ReferenceNumber AT ROW 23.33 COL 87 COLON-ALIGNED WIDGET-ID 146
     fi_SystemErrorStatus1 AT ROW 24.14 COL 16.17 COLON-ALIGNED WIDGET-ID 118
     fi_CMIDocumentUID AT ROW 17.29 COL 120 COLON-ALIGNED WIDGET-ID 352
     fi_DocumentUID AT ROW 10 COL 120 COLON-ALIGNED WIDGET-ID 354
     fi_CMVApplication AT ROW 4.05 COL 51.5 COLON-ALIGNED WIDGET-ID 356
     fi_CMIApplication AT ROW 16.43 COL 93 COLON-ALIGNED WIDGET-ID 358
     fi_ApplicationNumber AT ROW 4.91 COL 107 COLON-ALIGNED WIDGET-ID 360
     fi_COLLAmtAccident AT ROW 13.43 COL 62 COLON-ALIGNED WIDGET-ID 362
     fi_FTAmt AT ROW 13.43 COL 93 COLON-ALIGNED WIDGET-ID 364
     fi_GarageCd AT ROW 11.71 COL 62 COLON-ALIGNED WIDGET-ID 366
     fi_VehBodyTypeDesc AT ROW 11.71 COL 16.17 COLON-ALIGNED WIDGET-ID 368
     fi_DriverNameCd AT ROW 11.71 COL 114.83 COLON-ALIGNED WIDGET-ID 370
     fi_ReceiptNumber AT ROW 4.1 COL 107.5 COLON-ALIGNED WIDGET-ID 372
     fi_GarageDesc AT ROW 11.71 COL 64.33 COLON-ALIGNED NO-LABEL WIDGET-ID 376
     fi_PhoneNumber AT ROW 7.86 COL 81.33 COLON-ALIGNED WIDGET-ID 380
     fi_PolicyStatus AT ROW 2.19 COL 105.5 COLON-ALIGNED WIDGET-ID 382
     fi_PreviousPolicyNumber AT ROW 3.14 COL 51.5 COLON-ALIGNED WIDGET-ID 384
     fi_Rencnt AT ROW 3.14 COL 105.5 COLON-ALIGNED WIDGET-ID 386
     fi_InsuranceBranchCd AT ROW 3.14 COL 78 COLON-ALIGNED WIDGET-ID 388
     fi_policy AT ROW 4.1 COL 78 COLON-ALIGNED WIDGET-ID 390
     fi_AgentBrokerLicenseNumber AT ROW 2.24 COL 78 COLON-ALIGNED WIDGET-ID 392
     fi_SendDate AT ROW 1.14 COL 114.83 COLON-ALIGNED NO-LABEL WIDGET-ID 394
     fi_SendTime AT ROW 1.14 COL 125.17 COLON-ALIGNED NO-LABEL WIDGET-ID 396
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.5 ROW 2.24
         SIZE 135 BY 24.24
         BGCOLOR 15  WIDGET-ID 300.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME frDisp
     fi_Statusflag AT ROW 4.91 COL 78 COLON-ALIGNED WIDGET-ID 400
     fi_Finint AT ROW 3.14 COL 119.83 COLON-ALIGNED WIDGET-ID 402
     fi_member AT ROW 5.76 COL 81.67 COLON-ALIGNED WIDGET-ID 410
     "Status:" VIEW-AS TEXT
          SIZE 6.67 BY .71 AT ROW 22.29 COL 1.5 WIDGET-ID 338
          FONT 6
     RECT-3 AT ROW 2 COL 1.5 WIDGET-ID 90
     RECT-4 AT ROW 6.71 COL 18.33 WIDGET-ID 294
     RECT-5 AT ROW 9.71 COL 18.33 WIDGET-ID 296
     RECT-6 AT ROW 15.29 COL 18.33 WIDGET-ID 298
     RECT-9 AT ROW 23.1 COL 18.33 WIDGET-ID 346
     RECT-10 AT ROW 21.14 COL 1.5 WIDGET-ID 348
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.5 ROW 2.24
         SIZE 135 BY 24.24
         BGCOLOR 15  WIDGET-ID 300.


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
         HEIGHT             = 28.95
         WIDTH              = 136
         MAX-HEIGHT         = 45.81
         MAX-WIDTH          = 213.33
         VIRTUAL-HEIGHT     = 45.81
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
/* REPARENT FRAME */
ASSIGN FRAME frDisp:FRAME = FRAME DEFAULT-FRAME:HANDLE.

/* SETTINGS FOR FRAME DEFAULT-FRAME
   FRAME-NAME Custom                                                    */
/* BROWSE-TAB br_ExtResult 1 DEFAULT-FRAME */
/* BROWSE-TAB br_FileAtt RECT-8 DEFAULT-FRAME */
ASSIGN 
       bu_file:AUTO-RESIZE IN FRAME DEFAULT-FRAME      = TRUE.

ASSIGN 
       bu_LoadFile:AUTO-RESIZE IN FRAME DEFAULT-FRAME      = TRUE.

ASSIGN 
       bu_Open:AUTO-RESIZE IN FRAME DEFAULT-FRAME      = TRUE.

/* SETTINGS FOR FILL-IN fiBY IN FRAME DEFAULT-FRAME
   NO-ENABLE ALIGN-L                                                    */
/* SETTINGS FOR FILL-IN fiMess IN FRAME DEFAULT-FRAME
   NO-ENABLE ALIGN-L                                                    */
/* SETTINGS FOR RECTANGLE RECT-8 IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FRAME frDisp
   Custom                                                               */
/* SETTINGS FOR FILL-IN fi_ApproveBy IN FRAME frDisp
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_ApproveDt IN FRAME frDisp
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_ApproveText IN FRAME frDisp
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_ApproveTime IN FRAME frDisp
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_ChkVehAssignDt IN FRAME frDisp
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_ChkVehAssignTime IN FRAME frDisp
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_ChkVehBy IN FRAME frDisp
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_ChkVehicle IN FRAME frDisp
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_CMVApplication IN FRAME frDisp
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_ConfirmBy IN FRAME frDisp
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_IDText IN FRAME frDisp
   ALIGN-R                                                              */
/* SETTINGS FOR RECTANGLE RECT-10 IN FRAME frDisp
   NO-ENABLE                                                            */
/* SETTINGS FOR RECTANGLE RECT-3 IN FRAME frDisp
   NO-ENABLE                                                            */
/* SETTINGS FOR RECTANGLE RECT-4 IN FRAME frDisp
   NO-ENABLE                                                            */
/* SETTINGS FOR RECTANGLE RECT-5 IN FRAME frDisp
   NO-ENABLE                                                            */
/* SETTINGS FOR RECTANGLE RECT-6 IN FRAME frDisp
   NO-ENABLE                                                            */
/* SETTINGS FOR RECTANGLE RECT-9 IN FRAME frDisp
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_ExtResult
/* Query rebuild information for BROWSE br_ExtResult
     _START_FREEFORM
/**/
/*
IF nv_if = "POLICY" THEN  DO:
*/
  OPEN QUERY {&SELF-NAME}
    FOR EACH IntPol7072Result WHERE
             IntPol7072Result.CompanyCode    = IntPol7072.CompanyCode
         AND IntPol7072Result.ContractNumber = IntPol7072.ContractNumber
  NO-LOCK. /* BREAK BY IntPol7072Result.ErrorCode. */
     _END_FREEFORM
     _Query            is NOT OPENED
*/  /* BROWSE br_ExtResult */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_FileAtt
/* Query rebuild information for BROWSE br_FileAtt
     _START_FREEFORM
/**/
OPEN QUERY {&SELF-NAME} FOR EACH LFileAtt NO-LOCK.
     _END_FREEFORM
     _Query            is NOT OPENED
*/  /* BROWSE br_FileAtt */
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


&Scoped-define SELF-NAME buCancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buCancel C-Win
ON CHOOSE OF buCancel IN FRAME DEFAULT-FRAME /* Cancel */
DO:
  /* */
  nv_IChoice = NO.

  MESSAGE "ต้องการ ยกเลิก ข้อมูล"     SKIP(1)
          "โปรดยืนยันการดำเนินการ"    SKIP
  VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO 
  UPDATE nv_IChoice.

  IF nv_IChoice = NO THEN DO:

    APPLY "ENTRY" TO buExit.
    RETURN NO-APPLY.
  END.

  FIND IntPol7072 WHERE RECID(IntPol7072) = nv_RecordID
  NO-LOCK NO-ERROR NO-WAIT.
  IF NOT AVAILABLE IntPol7072 THEN DO:

    MESSAGE "Not found data." SKIP(1)
    VIEW-AS ALERT-BOX.
    RETURN.
  END.

  FIND IntPol7072 WHERE RECID(IntPol7072) = nv_RecordID
  NO-ERROR NO-WAIT.
  IF AVAILABLE IntPol7072 THEN DO:
    
        FOR EACH IntPol7072Result WHERE
            IntPol7072Result.CompanyCode    = IntPol7072.CompanyCode
            AND IntPol7072Result.ContractNumber = IntPol7072.ContractNumber
            :
            IntPol7072Result.ContractNumber = TRIM(IntPol7072Result.ContractNumber) + "CA".
        END.
   
     /**/

     ASSIGN
     fi_PolicyStatus   = "C"
     fi_ContractNumber = TRIM(fi_ContractNumber) + "CA"

     IntPol7072.PolicyStatus   = "C"
     IntPol7072.ContractNumber = TRIM(IntPol7072.ContractNumber) + "CA".

     IF IntPol7072.CompanyCode = "570" THEN  
        IntPol7072.ChassisSerialNumber  = TRIM(IntPol7072.ChassisSerialNumber) + "CA".

     IF IntPol7072.CMVApplicationNumber <> "" THEN
        IntPol7072.CMVApplicationNumber = TRIM(IntPol7072.CMVApplicationNumber) + "CA".

     IF IntPol7072.CMIApplicationNumber <> "" THEN
        IntPol7072.CMIApplicationNumber = TRIM(IntPol7072.CMIApplicationNumber) + "CA".
     /* จะ update sic_bran, gwctx หรือไม่
     */
  END.

  DISPLAY fi_PolicyStatus fi_ContractNumber WITH FRAME frDisp.

  CLOSE QUERY br_ExtResult .
  {&OPEN-QUERY-br_ExtResult}
  /* */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frDisp
&Scoped-define SELF-NAME buDriverName
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buDriverName C-Win
ON CHOOSE OF buDriverName IN FRAME frDisp /* DriverName */
DO:
/**/
  DEF VAR nv_char1 AS CHAR.
  DEF VAR nv_char2 AS CHAR.

  nv_char1 = TRIM(TRIM(IntPol7072.InsuredTitle1) + " " + 
             TRIM(IntPol7072.InsuredName1)       + " " + 
             TRIM(IntPol7072.InsuredSurname1)).
  nv_char2 = TRIM(TRIM(IntPol7072.InsuredTitle2) + " " + 
             TRIM(IntPol7072.InsuredName2)       + " " + 
             TRIM(IntPol7072.InsuredSurname2)).

  MESSAGE
    "     ผู้ขับขี่ท่านที่ 1: "  nv_char1                    SKIP
    "             วดป.เกิด: "    IntPol7072.BirthDt1         SKIP
    "เลขใบขับขี่:เลขบัตรปชช.: "  IntPol7072.InsuredUniqueID1 SKIP(1)
    "     ผู้ขับขี่ท่านที่ 2: "  nv_char2                    SKIP
    "             วดป.เกิด: "    IntPol7072.BirthDt2         SKIP
    "เลขใบขับขี่:เลขบัตรปชช.: "  IntPol7072.InsuredUniqueID2

  VIEW-AS ALERT-BOX.

/**/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define SELF-NAME buExit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buExit C-Win
ON CHOOSE OF buExit IN FRAME DEFAULT-FRAME /* Exit */
DO:
  /* */

  APPLY "CLOSE" TO THIS-PROCEDURE.  /* ปิดโปรแกรม */
  RETURN NO-APPLY.
  /* */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frDisp
&Scoped-define SELF-NAME buMessage
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buMessage C-Win
ON CHOOSE OF buMessage IN FRAME frDisp /* View Message */
DO:
/**/
  DEF VAR nv_char AS CHAR.
  nv_char = fi_SystemErrorStatus1.

  MESSAGE nv_char 
  VIEW-AS ALERT-BOX.

/**/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buViewOTHER
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buViewOTHER C-Win
ON CHOOSE OF buViewOTHER IN FRAME frDisp /* View Other */
DO:
/**/
  DEF VAR nv_char1 AS CHAR.
  DEF VAR nv_char2 AS CHAR.
  /*
  nv_char1 = TRIM(TRIM(IntPol7072.InsuredTitle1) + " " + 
             TRIM(IntPol7072.InsuredName1)       + " " + 
             TRIM(IntPol7072.InsuredSurname1)).
  nv_char2 = IntPol7072.PromptText.
  */

  nv_char1 = TRIM(IntPol7072.PhoneNumber)       + " " +  
             TRIM(IntPol7072.MobileNumber).
  nv_char2 = TRIM(IntPol7072.MobilePhoneNumber) + " " +
             TRIM(IntPol7072.OfficePhoneNumber).
  /*
  nv_char2 = "TEST". */

  MESSAGE
    "              ShowroomID"    IntPol7072.ShowroomID      SKIP
    "ชื่อผู้จำหน่ายรถยนต์นิสสัน " IntPol7072.ShowroomName    SKIP
    "ที่อยู่(ออกใบกำกับภาษี: "    IntPol7072.ReceiptAddr     SKIP
    "             อุปกรณ์พิเศษ: " IntPol7072.OptionValueDesc SKIP
    /*"        ผู้รับผลประโยชน์: "  IntPol7072.Beneficiaries   SKIP*/
    "       ข้อความหมายเหตุ: "    IntPol7072.PromptText      SKIP
    "                     โทรศัพท์: "        nv_char1        SKIP
    "                                     "  nv_char2
  VIEW-AS ALERT-BOX.

/**/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define SELF-NAME bu_file
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_file C-Win
ON CHOOSE OF bu_file IN FRAME DEFAULT-FRAME /* Save AS */
DO:
/* */

  DEFINE VARIABLE cvData    AS CHARACTER NO-UNDO.

  DEFINE VARIABLE OKpressed AS LOGICAL   INITIAL TRUE.

  cvData = LFileAtt.FileNam .

  SYSTEM-DIALOG GET-FILE cvData
        TITLE      "Choose Data File to Export ..."
        FILTERS    "Adobe PDF Files" "*.pdf"
        SAVE-AS
       /* MUST-EXIST*/
        USE-FILENAME
        UPDATE OKpressed.
      
  IF OKpressed = TRUE THEN DO:
    
    nv_ListFile  = cvData.
    /* ----
    MESSAGE "found data." nv_listfile SKIP(1)
    VIEW-AS ALERT-BOX.
    ---- */
    nv_SAVEFile = LFileAtt.FileAtt .

    IF nv_SAVEFile <> ? THEN DO:

      OUTPUT STREAM xmlstream TO  VALUE(nv_ListFile) NO-CONVERT.
  
        EXPORT STREAM xmlstream  nv_SAVEFile.
  
      OUTPUT STREAM xmlstream CLOSE.
  
      /* --- */
      IF ERROR-STATUS:ERROR  THEN DO:
  
        MESSAGE " ไม่สามารถทำการ Save File: " SKIP
                nv_ListFile                    SKIP(1)
                ERROR-STATUS:GET-MESSAGE(1)    SKIP(1)
                ERROR-STATUS:GET-MESSAGE(2)    SKIP(1)
        VIEW-AS ALERT-BOX.
  
        APPLY "ENTRY" TO bu_file.
        RETURN NO-APPLY.
      END.

      /* *************************************************************************
      IF nv_CheckFile = "AcroRd" THEN DO: /* found AcroRd32.exe*/

        FIND FIRST cdir NO-LOCK NO-ERROR.
        IF AVAILABLE cdir THEN DO:

          IF INDEX(cdir.FilNAME,nv_CheckFile) <> 0 THEN DO:

            ASSIGN
            nv_filename  = cdir.FilNAME
            nv_changedir = cdir.DirName
            nv_changedir = REPLACE(nv_changedir,"C:","CD").
            /*
            DISPLAY nv_changedir FORMAT "x(60)". */
            /* -------------------
            DOS SILENT VALUE("C:").
            DOS SILENT VALUE("CD\").
            DOS SILENT VALUE(nv_changedir).
            DOS SILENT VALUE("D:").
            DOS SILENT VALUE("C:" + nv_filename) VALUE("FDW7057PS0289.PDF").
            -------------------- */
          
          
            OUTPUT TO TESTCall.BAT.
            PUT "C:"   SKIP
                "CD\"  SKIP       
                nv_changedir SKIP
                "D:"   SKIP
                "C:" nv_filename " " nv_ListFile FORMAT "X(50)" /*nv_opendfile*/  SKIP.
            OUTPUT CLOSE.
            DOS SILENT VALUE("CALL TESTCall.BAT").

          END.
        END.
      END.
      ************************************************************************* */      
    END.

    APPLY "ENTRY" TO bu_file.
    RETURN NO-APPLY.
  END.

/* */  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_LoadFile
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_LoadFile C-Win
ON CHOOSE OF bu_LoadFile IN FRAME DEFAULT-FRAME /* Load *.PDF */
DO:
/* */

  DEFINE VARIABLE cvData    AS CHARACTER NO-UNDO.
  DEFINE VARIABLE OKpressed AS LOGICAL   INITIAL TRUE.

  FIND IntPol7072 WHERE RECID(IntPol7072) = nv_RecordID
  NO-LOCK NO-ERROR NO-WAIT.

  IF NOT AVAILABLE IntPol7072 THEN DO:

    MESSAGE "Not found data." SKIP(1)
    VIEW-AS ALERT-BOX.
    RETURN.
  END.

  SYSTEM-DIALOG GET-FILE cvData
        TITLE      "Choose Data File to Import ..."
        FILTERS    "Adobe PDF Files" "*.pdf"
      /*SAVE-AS*/
        MUST-EXIST
        USE-FILENAME
        UPDATE OKpressed.
      
  IF OKpressed = TRUE THEN DO:
    
    nv_ListFile = cvData.

    /* -- */
    
    FOR EACH TFileAttach: DELETE TFileAttach. END.
    
    CREATE TFileAttach.
    TFileAttach.FileNameAttach = TRIM(IntPol7072.CMIPolicyNumber) + ".PDF".

    COPY-LOB FROM FILE nv_ListFile TO TFileAttach.FileBinary NO-CONVERT NO-ERROR.
    
    /* --- */
    IF ERROR-STATUS:ERROR  THEN DO:
    
      MESSAGE " ไม่สามารถ Load File: " nv_FileName SKIP
              nv_ListFile                    SKIP(1)
              ERROR-STATUS:GET-MESSAGE(1)    SKIP(1)
              ERROR-STATUS:GET-MESSAGE(2)    SKIP(1)
      VIEW-AS ALERT-BOX.
    
      APPLY "ENTRY" TO bu_file.
      RETURN NO-APPLY.
    END.

    FIND IntPol7072 WHERE RECID(IntPol7072) = nv_RecordID
    NO-ERROR NO-WAIT.
    IF AVAILABLE IntPol7072 THEN DO:
      /*
      IF TFileAttach.FileBinary <> ? THEN */
      IntPol7072.FileNameAttach1 = "".
      IntPol7072.AttachFile1     = ?.

      IntPol7072.FileNameAttach1 = TFileAttach.FileNameAttach.
      IntPol7072.AttachFile1     = TFileAttach.FileBinary.
    END.

  END.

  FIND IntPol7072 WHERE RECID(IntPol7072) = nv_RecordID
  NO-LOCK NO-ERROR NO-WAIT.

  IF NOT AVAILABLE IntPol7072 THEN DO:

    MESSAGE "Not found data." SKIP(1)
    VIEW-AS ALERT-BOX.
    RETURN.
  END.

  IF IntPol7072.AttachFile1 <> ? AND IntPol7072.FileNameAttach1 <> "" THEN DO:
    nv_seqno = 0.
    nv_seqno = nv_seqno + 1.
    CREATE LFileAtt.
    ASSIGN LFileAtt.Selectno = TRIM(STRING(nv_seqno,">9"))
           LFileAtt.FileNam  = IntPol7072.FileNameAttach1
           LFileAtt.FileAtt  = IntPol7072.AttachFile1.

    ENABLE  bu_file bu_Open WITH FRAME DEFAULT-FRAME.
  END.

  CLOSE QUERY br_ExtResult .

  {&OPEN-QUERY-br_ExtResult}

  CLOSE QUERY br_FileAtt .

  {&OPEN-QUERY-br_FileAtt}
/* */  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_Open
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_Open C-Win
ON CHOOSE OF bu_Open IN FRAME DEFAULT-FRAME /* Opend File */
DO:
/* */

  nv_ListFile = LFileAtt.FileNam .
  nv_SAVEFile = LFileAtt.FileAtt .

  IF nv_SAVEFile <> ? THEN DO:

    OUTPUT STREAM xmlstream TO  VALUE(nv_ListFile) NO-CONVERT.

      EXPORT STREAM xmlstream  nv_SAVEFile.

    OUTPUT STREAM xmlstream CLOSE.

    /* --- */
    IF ERROR-STATUS:ERROR  THEN DO:

      MESSAGE " ไม่สามารถทำการ Save File: " SKIP
              nv_ListFile                    SKIP(1)
              ERROR-STATUS:GET-MESSAGE(1)    SKIP(1)
              ERROR-STATUS:GET-MESSAGE(2)    SKIP(1)
      VIEW-AS ALERT-BOX.

      APPLY "ENTRY" TO bu_file.
      RETURN NO-APPLY.
    END.

    /*
    IF nv_CheckFile = "AcroRd" THEN DO: /* found AcroRd32.exe*/
    */
      FIND FIRST cdir NO-LOCK NO-ERROR.
      IF AVAILABLE cdir THEN DO:

        IF INDEX(cdir.FilNAME,"AcroRd") <> 0 THEN DO:

          ASSIGN
          nv_filename  = cdir.FilNAME
          nv_changedir = cdir.DirName
          nv_changedir = REPLACE(nv_changedir,"C:","CD").
          /*
          DISPLAY nv_changedir FORMAT "x(60)". */
          /* -------------------
          DOS SILENT VALUE("C:").
          DOS SILENT VALUE("CD\").
          DOS SILENT VALUE(nv_changedir).
          DOS SILENT VALUE("D:").
          DOS SILENT VALUE("C:" + nv_filename) VALUE("FDW7057PS0289.PDF").
          -------------------- */
        
        
          OUTPUT TO TESTCall.BAT.
          PUT "C:"   SKIP
              "CD\"  SKIP       
              nv_changedir SKIP
              "D:"   SKIP
              "C:" nv_filename " " nv_ListFile FORMAT "X(50)" /*nv_opendfile*/  SKIP.
          OUTPUT CLOSE.
          /*
          CURRENT-WINDOW:WINDOW-STATE = WINDOW-MINIMIZED. /* เป็นการย่อหน้า */ */

          C-WIn:Hidden = Yes. /* ซ้อนโปรแกรมตัวเอง */

          DOS SILENT VALUE("CALL TESTCall.BAT").

          C-WIn:Hidden = NO.  /* กลับมาแสดงโปรแกรมตัวเองต่อ*/
          /*
          CURRENT-WINDOW:WINDOW-STATE = WINDOW-NORMAL.    /* เป็นการขยายหน้า */ */
        END.
      END.
    /*
    END.*/
  END.

  IF nv_ListFile <> "" THEN DO:

    IF SEARCH(nv_ListFile) <> ? THEN DOS SILENT DEL VALUE(nv_ListFile).

    DOS SILENT DEL VALUE("TESTCall.BAT").
  END.

  APPLY "ENTRY" TO bu_file.
  RETURN NO-APPLY.
/* */  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_ExtResult
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
/* ------------------------------------------------------------------ */

/* --- */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:

 
  /********************  T I T L E   F O R  C - W I N  ****************/
  
  DEF  VAR  gv_prgid   AS   CHAR  FORMAT "X(8)"  NO-UNDO.
  DEF  VAR  gv_prog    AS   CHAR  FORMAT "X(40)" NO-UNDO.
  gv_prgid = "wgwrelt2".
  gv_prog  = "Query Detail Policy".
  /*
  RUN  WSU\WSUHDExt ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).

  RUN  WUT\WUTWICEN (C-WIN:handle).  */
  /*********************************************************************/
  /* */
  SESSION:DATA-ENTRY-RETURN = YES.      /* รับค่าปุ่ม ENTER */

  RUN enable_UI.
  /*
  IF nv_if = "POLICY" THEN  RUN Proc_DispDELETE. /*DISPLAY DATA DELETE*/
                      ELSE  RUN Proc_Display.    /*DISPLAY DATA */
  */
  RUN Pd_Display.

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
  DISPLAY fiMess fiBY 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE br_ExtResult buExit bu_file bu_Open bu_LoadFile buCancel br_FileAtt 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  DISPLAY fi_PolicyNumber fi_vehreg rd_approve fi_ConfirmBy fi_ChkVehicle 
          fi_ContractNumber fi_ChkVehBy fi_CMIPolicyNumber fi_ApproveBy 
          fi_ApproveText fi_test3 fi_GenSicBranText fi_Status fi_test2 fi_test1 
          fi_GenSicBran fi_GenSicBranDt fi_GenSicBranTime fi_CompanyCode 
          fi_BranchCd fi_AgencyEmployee fi_PolicyTypeCd fi_RateGroup fi_TranDate 
          fi_EffectiveDt fi_EndDt fi_ContractDt fi_TranTime fi_InsuredType 
          fi_InsuredUniqueID fi_IDText fi_InsuredUniqueIDExpirationDt 
          fi_InsuredBranch fi_InsuredName fi_Addr fi_RegisteredProvinceCode 
          fi_PlateNumber fi_Manufacturer fi_Model fi_Displacement 
          fi_GrossVehOrCombinedWeight fi_SeatingCapacity fi_ModelYear 
          fi_ChassisVINNumber fi_EngineSerialNumber fi_WrittenAmt 
          fi_RevenueStampAmt fi_VatAmt fi_Total fi_VehicleTypeCode 
          fi_StickerNumber fi_CMIEffectiveDt fi_CMIExpirationDt fi_WrittenAmt2 
          fi_RevenueStampAmt2 fi_VatAmt2 fi_Total2 fi_ChkVehAssignDt 
          fi_ChkVehAssignTime fi_ApproveDt fi_ApproveTime fi_ResultStatus 
          fi_RemarkText fi_ReferenceNumber fi_SystemErrorStatus1 
          fi_CMIDocumentUID fi_DocumentUID fi_CMVApplication fi_CMIApplication 
          fi_ApplicationNumber fi_COLLAmtAccident fi_FTAmt fi_GarageCd 
          fi_VehBodyTypeDesc fi_DriverNameCd fi_ReceiptNumber fi_GarageDesc 
          fi_PhoneNumber fi_PolicyStatus fi_PreviousPolicyNumber fi_Rencnt 
          fi_InsuranceBranchCd fi_policy fi_AgentBrokerLicenseNumber fi_SendDate 
          fi_SendTime fi_Statusflag fi_Finint fi_member 
      WITH FRAME frDisp IN WINDOW C-Win.
  ENABLE fi_PolicyNumber fi_vehreg rd_approve buMessage fi_ContractNumber 
         fi_CMIPolicyNumber buDriverName buViewOTHER fi_test3 fi_GenSicBranText 
         fi_Status fi_test2 fi_test1 fi_GenSicBran fi_GenSicBranDt 
         fi_GenSicBranTime fi_CompanyCode fi_BranchCd fi_AgencyEmployee 
         fi_PolicyTypeCd fi_RateGroup fi_TranDate fi_EffectiveDt fi_EndDt 
         fi_ContractDt fi_TranTime fi_InsuredType fi_InsuredUniqueID fi_IDText 
         fi_InsuredUniqueIDExpirationDt fi_InsuredBranch fi_InsuredName fi_Addr 
         fi_RegisteredProvinceCode fi_PlateNumber fi_Manufacturer fi_Model 
         fi_Displacement fi_GrossVehOrCombinedWeight fi_SeatingCapacity 
         fi_ModelYear fi_ChassisVINNumber fi_EngineSerialNumber fi_WrittenAmt 
         fi_RevenueStampAmt fi_VatAmt fi_Total fi_VehicleTypeCode 
         fi_StickerNumber fi_CMIEffectiveDt fi_CMIExpirationDt fi_WrittenAmt2 
         fi_RevenueStampAmt2 fi_VatAmt2 fi_Total2 fi_ResultStatus fi_RemarkText 
         fi_ReferenceNumber fi_SystemErrorStatus1 fi_CMIDocumentUID 
         fi_DocumentUID fi_CMIApplication fi_ApplicationNumber 
         fi_COLLAmtAccident fi_FTAmt fi_GarageCd fi_VehBodyTypeDesc 
         fi_DriverNameCd fi_ReceiptNumber fi_GarageDesc fi_PhoneNumber 
         fi_PolicyStatus fi_PreviousPolicyNumber fi_Rencnt fi_InsuranceBranchCd 
         fi_policy fi_AgentBrokerLicenseNumber fi_SendDate fi_SendTime 
         fi_Statusflag fi_Finint fi_member 
      WITH FRAME frDisp IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frDisp}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pd_Clear C-Win 
PROCEDURE Pd_Clear :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/**/
  /* ------------------------------------------- */
  ASSIGN
  fi_SendDate      = ?             fi_SendTime = ""
  fi_ReceiptNumber = ""   fi_ApplicationNumber = ""
  fi_vehreg      = ""     fi_InsuranceBranchCd = ""
  fi_TranDate    = ?
  fi_TranTime    = ""     fi_policy = ""  fi_AgentBrokerLicenseNumber = ""
  /**/
  fi_Status      = "" fi_GenSicBran = NO fi_GenSicBranDt = ? fi_GenSicBranTime = "" fi_GenSicBranText = ""
  /**/
  fi_CompanyCode     = "" fi_BranchCd      = "" fi_AgencyEmployee = ""
  fi_PolicyNumber    = "" fi_StickerNumber = "" fi_ContractNumber = ""
  fi_EffectiveDt     = ?  fi_EndDt         = ?  fi_ContractDt     = ?
  /**/
  fi_InsuredType     = "" fi_InsuredUniqueID = "" fi_InsuredUniqueIDExpirationDt = ? fi_InsuredBranch = ""
  fi_InsuredName     = "" fi_PhoneNumber     = ""
  fi_Addr            = ""
  /**/
  fi_RegisteredProvinceCode = "" fi_PlateNumber              = "" fi_VehicleTypeCode = ""
  fi_Manufacturer           = "" fi_Model                    = "" 
  fi_ModelYear              = "" fi_VehBodyTypeDesc          = ""
  fi_Displacement           = "" fi_GrossVehOrCombinedWeight = "" fi_SeatingCapacity = ""
  fi_ChassisVINNumber       = "" fi_EngineSerialNumber       = ""
  /**/
  fi_WrittenAmt             = "" fi_RevenueStampAmt          = "" fi_VatAmt          = ""
  fi_Total  = 0
  fi_ReferenceNumber        = "" fi_ResultStatus    = ""
  fi_RemarkText             = "" 
  fi_SystemErrorStatus1     = ""
  /**/
  fi_PolicyTypeCd           = "" fi_RateGroup                = "" fi_CMIPolicyNumber = ""
  fi_CMIEffectiveDt         = ?  fi_CMIExpirationDt          = ?
  
  fi_WrittenAmt2            = "" fi_RevenueStampAmt2         = "" fi_VatAmt2         = ""
  fi_Total2 = 0
  fi_test1 = ""
  fi_test2 = ""
  fi_test3 = ""
  /**/
  fi_ConfirmBy        = ""
  fi_ChkVehicle       = NO
  fi_ChkVehBy         = ""
  fi_ChkVehAssignDt   = ?
  fi_ChkVehAssignTime = ""
  fi_ApproveBy        = ""
  fi_ApproveText      = ""
  fi_ApproveDt        = ?
  fi_ApproveTime      = ""  rd_approve = 3 /* none */
  fi_CMVApplication   = ""
  fi_CMIApplication   = ""
  fi_DocumentUID      = ""
  fi_CMIDocumentUID   = ""

  fi_COLLAmtAccident  = 0
  fi_FTAmt            = 0
  fi_GarageCd         = ""  fi_GarageDesc = ""
  fi_DriverNameCd         = NO
  fi_PolicyStatus         = ""
  fi_PreviousPolicyNumber = ""
  fi_Rencnt = "0/0"
  fi_Statusflag = ""   fi_Finint = ""
  .
  /* ------------------------------------------- */
/**/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pd_Display C-Win 
PROCEDURE Pd_Display :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/**/
  HIDE MESSAGE NO-PAUSE.
  IF nv_RecordID = 0 OR nv_RecordID = ? THEN RETURN.

  RUN Pd_Clear.

  /* --
  IF nv_CheckFile = "" THEN DO:

    RUN WRS/WRSAcroRd.P (INPUT-OUTPUT nv_CheckFile).
    /*
    nv_CheckFile = "NOT".    not found AcroRd32.exe
    nv_CheckFile = "AcroRd". found AcroRd32.exe
    */
  END.
  -- */

       IF nv_if = "POLICY"      THEN  RUN Pd_GetPolicy.
  ELSE RETURN.
  /*
  ELSE IF nv_if = "OLDPOLICY"   THEN  RUN Pd_GetOLDPOLICY.
  ELSE IF nv_if = "ENDORSE"     THEN  RUN Pd_GetEndorse.
  ELSE IF nv_if = "OLDENDORSE"  THEN  RUN Pd_GetOLDEndorse.
  */

       IF nv_if = "POLICY"     THEN  fiBY = " Query รายละเอียดข้อมูล Policy". 
  /*
  ELSE IF nv_if = "OLDPOLICY"  THEN  fiBY = " Query รายละเอียดข้อมูล OLD Policy". 
  ELSE IF nv_if = "ENDORSE"    THEN  fiBY = " Query รายละเอียดข้อมูล Endorse".
  ELSE IF nv_if = "OLDENDORSE" THEN  fiBY = " Query รายละเอียดข้อมูล OLD Endorse".
  */

  DISPLAY  fiBY  WITH FRAME DEFAULT-FRAME.  /*ตรงแถบสีเขียว*/

  DISPLAY
  /*
  fi_Policyno   fi_RenEnd fi_RiskItem fi_Adjustno */

  fi_InsuranceBranchCd     fi_vehreg fi_TranDate    fi_TranTime
  fi_SendDate              fi_SendTime
  /**/
  fi_Status          fi_GenSicBran  fi_GenSicBranDt  fi_GenSicBranTime fi_GenSicBranText
  /**/
  fi_CompanyCode     fi_BranchCd        fi_AgencyEmployee  fi_policy
  fi_PolicyNumber    fi_StickerNumber   fi_ContractNumber  fi_ReceiptNumber  fi_ApplicationNumber
  fi_EffectiveDt     fi_EndDt           fi_ContractDt      fi_AgentBrokerLicenseNumber
  /**/               fi_Statusflag
  fi_InsuredType     fi_InsuredUniqueID fi_IDText fi_InsuredUniqueIDExpirationDt fi_InsuredBranch
  fi_InsuredName     fi_PhoneNumber
  fi_Addr
  /**/
  fi_RegisteredProvinceCode fi_PlateNumber                  fi_VehicleTypeCode
  fi_Manufacturer           fi_Model                        fi_VehBodyTypeDesc
  fi_ModelYear     
  fi_Displacement           fi_GrossVehOrCombinedWeight     fi_SeatingCapacity
  fi_ChassisVINNumber       fi_EngineSerialNumber
  /**/
  fi_WrittenAmt             fi_RevenueStampAmt              fi_VatAmt  fi_Total
  /**/
  fi_ReferenceNumber        fi_ResultStatus
  fi_RemarkText
  fi_SystemErrorStatus1
  /**/
  fi_PolicyTypeCd           fi_RateGroup                    fi_CMIPolicyNumber
  fi_CMIEffectiveDt         fi_CMIExpirationDt
  fi_WrittenAmt2            fi_RevenueStampAmt2             fi_VatAmt2  fi_Total2

  fi_test1 
  fi_test2
  fi_test3 

  fi_ConfirmBy
  fi_ChkVehicle
  fi_ChkVehBy
  fi_ChkVehAssignDt
  fi_ChkVehAssignTime
  fi_ApproveBy
  fi_ApproveText
  fi_ApproveDt
  fi_ApproveTime
  rd_approve
  fi_CMVApplication         fi_CMIApplication
  fi_DocumentUID            fi_CMIDocumentUID

  fi_COLLAmtAccident
  fi_FTAmt
  fi_GarageCd               fi_GarageDesc     fi_DriverNameCd
  fi_PolicyStatus
  fi_PreviousPolicyNumber
  fi_Rencnt                 fi_Finint     fi_member
  WITH FRAME frDisp.

  IF TRIM(fi_SystemErrorStatus1) = "" THEN  DISABLE  buMessage     WITH FRAME frDisp.

  IF fi_DriverNameCd             = NO THEN  DISABLE  buDriverName  WITH FRAME frDisp.


  /* ----
  IF fi_ConfirmBy = "AUTO" THEN 
     DISABLE  fi_ConfirmBy fi_ChkVehicle fi_ChkVehBy fi_ApproveBy fi_ApproveText
              rd_approve 
     WITH FRAME frDisp.

  IF IntPol7072.ApproveStatus = "C" OR IntPol7072.ApproveStatus = "A" THEN
     DISABLE  fi_ConfirmBy fi_ChkVehicle fi_ChkVehBy fi_ApproveBy fi_ApproveText
              rd_approve
     WITH FRAME frDisp.
  ---- */
  DISABLE  fi_ConfirmBy fi_ChkVehicle fi_ChkVehBy fi_ApproveBy fi_ApproveText
           rd_approve 
  WITH FRAME frDisp.
  /* --------------------------------------------------- */

  FIND FIRST LFileAtt NO-LOCK NO-ERROR.
  IF NOT AVAILABLE LFileAtt THEN 
    DISABLE bu_file bu_Open WITH FRAME DEFAULT-FRAME.
  


  CLOSE QUERY br_ExtResult .

  {&OPEN-QUERY-br_ExtResult}

  CLOSE QUERY br_FileAtt .

  {&OPEN-QUERY-br_FileAtt}

/**/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pd_GetPolicy C-Win 
PROCEDURE Pd_GetPolicy :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/**/
  FIND IntPol7072 WHERE RECID(IntPol7072) = nv_RecordID
  NO-LOCK NO-ERROR NO-WAIT.

  IF NOT AVAILABLE IntPol7072 THEN DO:

    MESSAGE "Not found data." SKIP(1)
    VIEW-AS ALERT-BOX.
    RETURN.
  END.

  ASSIGN
  /*
  fi_Policyno  = IntPol7072.Policy
  fi_RiskItem  = STRING(IntPol7072.Riskno,"999") + "/" + STRING(IntPol7072.Itemno,"999")
  fi_Adjustno  = IntPol7072.Adjustno
  */
  fi_AgentBrokerLicenseNumber = IntPol7072.AgentBrokerLicenseNumber
  fi_policy    = IntPol7072.policy
  fi_vehreg    = IntPol7072.vehreg 
  fi_TranDate  = IntPol7072.ProcessDate
  fi_TranTime  = IntPol7072.ProcessTime
  fi_SendDate  = IntPol7072.SendDate
  fi_SendTime  = IntPol7072.SendTime
  /*
  fi_InsuranceCd    = IntPol7072.InsuranceCd */
  fi_Status         = IntPol7072.ProcessStatus
  fi_GenSicBran     = IntPol7072.GenSicBran
  fi_GenSicBranDt   = IntPol7072.GenSicBranDt
  fi_GenSicBranTime = IntPol7072.GenSicBranTime
  fi_GenSicBranText = IntPol7072.GenSicBranText

  /**/
  fi_InsuranceBranchCd = IntPol7072.InsuranceBranchCd
  fi_CompanyCode       = IntPol7072.CompanyCode
  fi_BranchCd          = IntPol7072.BranchCd
  fi_AgencyEmployee    = IntPol7072.AgencyEmployee

  fi_ContractNumber    = IntPol7072.ContractNumber
  fi_PolicyNumber      = IntPol7072.PolicyNumber
  fi_ReceiptNumber     = IntPol7072.ReceiptNumber     /*PromotionNumber / CampaignNumber*/
  fi_ApplicationNumber = IntPol7072.ApplicationNumber /*QNumPremium*/

  fi_PolicyTypeCd      = IntPol7072.PolicyTypeCd
  fi_RateGroup         = IntPol7072.RateGroup
  /*
  fi_ContractDt        = IntPol7072.ContractDt
  fi_EffectiveDt       = IntPol7072.EffectiveDt
  fi_EndDt             = IntPol7072.EndDt
  */
  /**/
  fi_InsuredType                 = IntPol7072.InsuredType 
  fi_InsuredUniqueID             = IntPol7072.InsuredUniqueID
  fi_InsuredUniqueIDExpirationDt = ?
  fi_InsuredBranch               = IntPol7072.InsuredBranch
  fi_InsuredName                 = TRIM(TRIM(IntPol7072.InsuredTitle) + " " +
                                   TRIM(TRIM(IntPol7072.InsuredName)  + " " +
                                             IntPol7072.InsuredSurname))
  fi_Addr                        = TRIM(IntPol7072.Addr)        + " " +
                                   TRIM(IntPol7072.SubDistrict) + " " +
                                   TRIM(IntPol7072.District)    + " " +
                                   TRIM(IntPol7072.Province)    + " " +
                                   TRIM(IntPol7072.PostalCode)
  fi_PhoneNumber               = TRIM(IntPol7072.PhoneNumber)       + " " +  
                                 TRIM(IntPol7072.MobileNumber)      + " " +
                                 TRIM(IntPol7072.MobilePhoneNumber) + " " +
                                 TRIM(IntPol7072.OfficePhoneNumber)
  /**/
  fi_RegisteredProvinceCode    = IntPol7072.RegisteredProvCd
  fi_PlateNumber               = IntPol7072.PlateNumber

  fi_Manufacturer              = IntPol7072.Manufacturer
  fi_Model                     = IntPol7072.Model
  fi_GarageCd                  = IntPol7072.GarageTypeCd
  fi_GarageDesc                = IntPol7072.GarageDesc
  /*
  fi_ModelTypeName             = IntPol7072.ModelTypeName*/
  fi_ModelYear                 = IntPol7072.ModelYear
  fi_Displacement              = IntPol7072.Displacement
  fi_GrossVehOrCombinedWeight  = IntPol7072.GrossVehOrCombinedWeight
  fi_SeatingCapacity           = IntPol7072.SeatingCapacity
  fi_ChassisVINNumber          = IntPol7072.ChassisVINNumber
  fi_EngineSerialNumber        = IntPol7072.EngineSerialNumber
  fi_VehBodyTypeDesc           = IntPol7072.VehBodyTypeDesc
  /**/
  fi_WrittenAmt                = IntPol7072.WrittenAmt
  fi_RevenueStampAmt           = IntPol7072.RevenueStampAmt
  fi_VatAmt                    = IntPol7072.VatAmt

  fi_CMIPolicyNumber           = IntPol7072.CMIPolicyNumber
  fi_VehicleTypeCode           = IntPol7072.CMIVehTypeCd      /*VehicleTypeCode*/
  fi_StickerNumber             = IntPol7072.CMIBarCodeNumber 
  /**/
  fi_ReferenceNumber           = IntPol7072.RqUID
  fi_ResultStatus              = IntPol7072.ResultStatus
  fi_RemarkText                = IntPol7072.RemarkText
  fi_PolicyStatus              = IntPol7072.PolicyStatus
  fi_PreviousPolicyNumber      = IntPol7072.PreviousPolicyNumber
  /*
  fi_Rencnt                    = IntPol7072.Rencnt */
  fi_Rencnt                    = TRIM(STRING(IntPol7072.Rencnt,">>9")) + "/" 
                               + TRIM(STRING(IntPol7072.Endcnt,">>9"))
  
  fi_Finint                    = IntPol7072.Finint   
  fi_member                    = IntPol7072.remark
  fi_SystemErrorStatus1        = "".

  fi_PhoneNumber = REPLACE(fi_PhoneNumber,"  "," ").

  ASSIGN
  fi_CMIEffectiveDt            = IntPol7072.CMIComDate  
  fi_CMIExpirationDt           = IntPol7072.CMIExpDate
  fi_WrittenAmt2               = IntPol7072.CMIWrittenAmt
  fi_RevenueStampAmt2          = IntPol7072.CMIRevenueStampAmt
  fi_VatAmt2                   = IntPol7072.CMIVatAmt

  fi_test1                     = IntPol7072.Beneficiaries 
  fi_test2                     = IntPol7072.ReceiptName
  fi_test3                     = IntPol7072.ReceiptAddr.

  /*
  fi_Total  = DECIMAL(fi_WrittenAmt)  + DECIMAL(fi_RevenueStampAmt)  + DECIMAL(fi_VatAmt).
  fi_Total2 = DECIMAL(fi_WrittenAmt2) + DECIMAL(fi_RevenueStampAmt2) + DECIMAL(fi_VatAmt2).
  */

  fi_Total  = DECIMAL(IntPol7072.CurrentTermAmt) NO-ERROR.
  fi_Total2 = DECIMAL(IntPol7072.CMICurrentTermAmt) NO-ERROR.

  fi_COLLAmtAccident  = INTEGER(IntPol7072.COLLAmtAccident) NO-ERROR.   
  fi_FTAmt            = INTEGER(IntPol7072.FTAmt) NO-ERROR.
  /**/
  ASSIGN
  fi_CMVApplication = IntPol7072.CMVApplicationNumber
  fi_CMIApplication = IntPol7072.CMIApplicationNumber
  fi_DocumentUID    = IntPol7072.DocumentUID 
  fi_CMIDocumentUID = IntPol7072.CMIDocumentUID.
  /**/
  fi_IDText = "".
  
       IF fi_InsuredType = "1" THEN ASSIGN fi_InsuredType = "บัตรประชาชน"   fi_IDText = "วันบัตรหมดอายุ:".
  ELSE IF fi_InsuredType = "2" THEN ASSIGN fi_InsuredType = "Passport"      fi_IDText = "วัน P.หมดอายุ:".
  ELSE IF fi_InsuredType = "3" THEN ASSIGN fi_InsuredType = "นิติบุคคล"     fi_IDText = "วันที่เริ่ม:".
  ELSE IF fi_InsuredType = "0" THEN ASSIGN fi_InsuredType = "องค์การอื่น ๆ" fi_IDText = "".

  IF TRIM(IntPol7072.SystemErrorStatus1) <> "" OR 
     TRIM(IntPol7072.SystemErrorStatus2) <> "" OR
     TRIM(IntPol7072.SystemErrorStatus3) <> "" 
  THEN   ASSIGN
         fi_SystemErrorStatus1 =       TRIM(IntPol7072.SystemErrorStatus1)
                               + " " + TRIM(IntPol7072.SystemErrorStatus2)
                               + " " + TRIM(IntPol7072.SystemErrorStatus3).

  IF IntPol7072.accdat <> ? THEN fi_ContractDt = IntPol7072.accdat.
  ELSE DO:
    /*yyyymmdd*/
    /*20110131*/
    /*12345678*/
    IF TRIM(IntPol7072.ContractDt) <> "" THEN
      fi_ContractDt                = DATE(INTEGER(SUBSTR(IntPol7072.ContractDt,5,2))
                                         ,INTEGER(SUBSTR(IntPol7072.ContractDt,7,2))
                                         ,INTEGER(SUBSTR(IntPol7072.ContractDt,1,4))) NO-ERROR.

    IF ERROR-STATUS:ERROR  THEN fi_ContractDt = ?.
  END.

  IF IntPol7072.comdat <> ? THEN fi_EffectiveDt = IntPol7072.comdat.
  ELSE DO:
    IF TRIM(IntPol7072.EffectiveDt) <> "" THEN
      fi_EffectiveDt                = DATE(INTEGER(SUBSTR(IntPol7072.EffectiveDt,5,2))
                                          ,INTEGER(SUBSTR(IntPol7072.EffectiveDt,7,2))
                                          ,INTEGER(SUBSTR(IntPol7072.EffectiveDt,1,4))) NO-ERROR.

    IF ERROR-STATUS:ERROR  THEN fi_EffectiveDt = ?.
  END.

  IF IntPol7072.expdat <> ? THEN fi_EndDt = IntPol7072.expdat.
  ELSE DO:
    IF TRIM(IntPol7072.EndDt) <> "" THEN
      fi_EndDt                = DATE(INTEGER(SUBSTR(IntPol7072.EndDt,5,2))
                                    ,INTEGER(SUBSTR(IntPol7072.EndDt,7,2))
                                    ,INTEGER(SUBSTR(IntPol7072.EndDt,1,4))) NO-ERROR.

    IF ERROR-STATUS:ERROR  THEN fi_EndDt = ?.
  END.

  IF TRIM(IntPol7072.InsuredUniqueIDExpirationDt) <> "" THEN DO:

    fi_InsuredUniqueIDExpirationDt = DATE(INTEGER(SUBSTR(IntPol7072.InsuredUniqueIDExpirationDt,5,2))
                                         ,INTEGER(SUBSTR(IntPol7072.InsuredUniqueIDExpirationDt,7,2))
                                         ,INTEGER(SUBSTR(IntPol7072.InsuredUniqueIDExpirationDt,1,4))) NO-ERROR.

    IF ERROR-STATUS:ERROR  THEN fi_InsuredUniqueIDExpirationDt = ?.
  END.
  /*
  IF TRIM(IntPol7072.ReceiptDt) <> "" THEN DO:

    fi_ReceiptDt            = DATE(INTEGER(SUBSTR(IntPol7072.ReceiptDt,5,2))
                                  ,INTEGER(SUBSTR(IntPol7072.ReceiptDt,7,2))
                                  ,INTEGER(SUBSTR(IntPol7072.ReceiptDt,1,4))) NO-ERROR.

    IF ERROR-STATUS:ERROR  THEN fi_ReceiptDt = ?.
  END.
  */
  fi_ConfirmBy = IntPol7072.ConfirmBy.

  IF fi_ConfirmBy <> "" THEN DO:

    IF fi_ConfirmBy <> "AUTO" THEN DO:

      IF IntPol7072.ChkVehAssignBy <> "" THEN DO:
        ASSIGN
        fi_ConfirmBy        = IntPol7072.ChkVehAssignBy
        fi_ChkVehicle       = IntPol7072.ChkVehicle
        fi_ChkVehBy         = IntPol7072.ChkVehBy
        fi_ChkVehAssignDt   = IntPol7072.ChkVehAssignDt
        fi_ChkVehAssignTime = IntPol7072.ChkVehAssignTime
        fi_ApproveBy        = IntPol7072.ApproveBy
        fi_ApproveText      = IntPol7072.ApproveText
        fi_ApproveDt        = IntPol7072.ApproveDt
        fi_ApproveTime      = IntPol7072.ApproveTime .
      END.
    END.
  END.

  IF IntPol7072.ApproveStatus = ""  THEN rd_approve = 3. /* none */
  IF IntPol7072.ApproveStatus = "C" THEN rd_approve = 2. /* Cancel*/
  IF IntPol7072.ApproveStatus = "A" THEN rd_approve = 1. /* Approve */
  /**/

  fi_DriverNameCd = NO.

  IF     IntPol7072.InsuredTitle1    <> ""
     AND IntPol7072.InsuredName1     <> ""
     AND IntPol7072.InsuredSurname1  <> ""
     AND IntPol7072.BirthDt1         <> ""
     AND IntPol7072.InsuredUniqueID1 <> ""
  THEN   fi_DriverNameCd = YES.
    
  IF     IntPol7072.InsuredTitle2    <> ""
     AND IntPol7072.InsuredName2     <> ""
     AND IntPol7072.InsuredSurname2  <> ""
     AND IntPol7072.BirthDt2         <> ""
     AND IntPol7072.InsuredUniqueID2 <> ""
  THEN   fi_DriverNameCd = YES. 


  /* ------------------------------------------- */

  FOR EACH LFileAtt: DELETE LFileAtt. END.
  nv_seqno   = 0.
  nv_hasfile = NO.

  IF IntPol7072.AttachFile1 <> ? AND IntPol7072.FileNameAttach1 <> "" THEN DO:
    nv_seqno = nv_seqno + 1.
    CREATE LFileAtt.
    ASSIGN LFileAtt.Selectno = TRIM(STRING(nv_seqno,">9"))
           LFileAtt.FileNam  = IntPol7072.FileNameAttach1
           LFileAtt.FileAtt  = IntPol7072.AttachFile1.
  END.
  IF IntPol7072.AttachFile2 <> ? AND IntPol7072.FileNameAttach2 <> "" THEN DO:
    nv_seqno = nv_seqno + 1.
    CREATE LFileAtt.
    ASSIGN LFileAtt.Selectno = TRIM(STRING(nv_seqno,">9"))
           LFileAtt.FileNam  = IntPol7072.FileNameAttach2
           LFileAtt.FileAtt  = IntPol7072.AttachFile2.
  END.
  IF IntPol7072.AttachFile3 <> ? AND IntPol7072.FileNameAttach3 <> "" THEN DO:
    nv_seqno = nv_seqno + 1.
    CREATE LFileAtt.
    ASSIGN LFileAtt.Selectno = TRIM(STRING(nv_seqno,">9"))
           LFileAtt.FileNam  = IntPol7072.FileNameAttach3
           LFileAtt.FileAtt  = IntPol7072.AttachFile3.
  END.
  IF IntPol7072.AttachFile4 <> ? AND IntPol7072.FileNameAttach4 <> "" THEN DO:
    nv_seqno = nv_seqno + 1.
    CREATE LFileAtt.
    ASSIGN LFileAtt.Selectno = TRIM(STRING(nv_seqno,">9"))
           LFileAtt.FileNam  = IntPol7072.FileNameAttach4
           LFileAtt.FileAtt  = IntPol7072.AttachFile4.
  END.
  IF IntPol7072.AttachFile5 <> ? AND IntPol7072.FileNameAttach5 <> "" THEN DO:
    nv_seqno = nv_seqno + 1.
    CREATE LFileAtt.
    ASSIGN LFileAtt.Selectno = TRIM(STRING(nv_seqno,">9"))
           LFileAtt.FileNam  = IntPol7072.FileNameAttach5
           LFileAtt.FileAtt  = IntPol7072.AttachFile5.
  END.
  IF IntPol7072.AttachFile6 <> ? AND IntPol7072.FileNameAttach6 <> "" THEN DO:
    nv_seqno = nv_seqno + 1.
    CREATE LFileAtt.
    ASSIGN LFileAtt.Selectno = TRIM(STRING(nv_seqno,">9"))
           LFileAtt.FileNam  = IntPol7072.FileNameAttach6
           LFileAtt.FileAtt  = IntPol7072.AttachFile6.
  END.
  IF IntPol7072.AttachFile7 <> ? AND IntPol7072.FileNameAttach7 <> "" THEN DO:
    nv_seqno = nv_seqno + 1.
    CREATE LFileAtt.
    ASSIGN LFileAtt.Selectno = TRIM(STRING(nv_seqno,">9"))
           LFileAtt.FileNam  = IntPol7072.FileNameAttach7
           LFileAtt.FileAtt  = IntPol7072.AttachFile7.
  END.
  IF IntPol7072.AttachFile8 <> ? AND IntPol7072.FileNameAttach8 <> "" THEN DO:
    nv_seqno = nv_seqno + 1.
    CREATE LFileAtt.
    ASSIGN LFileAtt.Selectno = TRIM(STRING(nv_seqno,">9"))
           LFileAtt.FileNam  = IntPol7072.FileNameAttach8
           LFileAtt.FileAtt  = IntPol7072.AttachFile8.
  END.
  IF IntPol7072.AttachFile9 <> ? AND IntPol7072.FileNameAttach9 <> "" THEN DO:
    nv_seqno = nv_seqno + 1.
    CREATE LFileAtt.
    ASSIGN LFileAtt.Selectno = TRIM(STRING(nv_seqno,">9"))
           LFileAtt.FileNam  = IntPol7072.FileNameAttach9
           LFileAtt.FileAtt  = IntPol7072.AttachFile9.
  END.
  IF IntPol7072.AttachFile10 <> ? AND IntPol7072.FileNameAttach10 <> "" THEN DO:
    nv_seqno = nv_seqno + 1.
    CREATE LFileAtt.
    ASSIGN LFileAtt.Selectno = TRIM(STRING(nv_seqno,">9"))
           LFileAtt.FileNam  = IntPol7072.FileNameAttach10
           LFileAtt.FileAtt  = IntPol7072.AttachFile10.
  END.

  IF nv_seqno <> 0 THEN nv_hasfile = YES.
  /* ------------------------------------------- */

  /* 30/09/2015 รับ ค่า เข้าตรวจสอบข้อมูลรถทันใจ ประเภท 1*/

  IF IntPol7072.Statusflag = "true" THEN fi_Statusflag = "7000001".
  ELSE fi_Statusflag = "".
/**/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

