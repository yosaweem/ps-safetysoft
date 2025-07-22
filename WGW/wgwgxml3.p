/*************************************************************************
 Program id   : wgwgxml3.p
 copy program : UFTMGet04S1_Pol.P  : SAVE Data Response to ResponseResult return TYPE SOAP
                D:\WebBU\UTIL\UFTMGet04S1_Pol.P
 Copyright    : Safety Insurance Public Company Limited
                บริษัท ประกันคุ้มภัย จำกัด (มหาชน)
 ------------------------------------------------------------------------
 Database     : BUInt 
                ปรับแก้ไขโปรแกรม UFTMGet04S1_Pol.P จากเดิม สร้างไฟล์ xml ปรับเป็น 
                create data to DB BUExt table ExtPolLT70
 create by    : Kridtiya i. A60-0495 Date. 11/12/2017             
 ------------------------------------------------------------------------
 Modify by    : Kridtiya i. A63-0432 Date.23/09/2020 Add Policy renew
*************************************************************************/
DEFINE INPUT  PARAMETER nv_URL             AS CHARACTER NO-UNDO. /*1 Parameter URL & Database Name*/
DEFINE INPUT  PARAMETER nv_node-nameHeader AS CHARACTER NO-UNDO.
DEFINE INPUT  PARAMETER nv_policyno        AS CHARACTER NO-UNDO.
DEFINE OUTPUT PARAMETER ResponseResult     AS LONGCHAR  NO-UNDO.
DEFINE OUTPUT PARAMETER nv_SavetoFile      AS CHARACTER NO-UNDO.
DEFINE STREAM   xmlstream.
DEFINE VARIABLE nv_ErrorCd        AS CHARACTER NO-UNDO.
DEFINE VARIABLE EnvelopeNS        AS CHARACTER initial "" NO-UNDO.
/* */
DEFINE VARIABLE hHeader           AS HANDLE NO-UNDO.
DEFINE VARIABLE hHeaderEntryref   AS HANDLE NO-UNDO.
DEFINE VARIABLE hDoc              AS HANDLE  NO-UNDO.
DEFINE VARIABLE hRoot             AS HANDLE  NO-UNDO.
DEFINE VARIABLE hRow              AS HANDLE  NO-UNDO.
DEFINE VARIABLE hField            AS HANDLE  NO-UNDO.
DEFINE VARIABLE hSubField         AS HANDLE  NO-UNDO.
DEFINE VARIABLE hField2           AS HANDLE  NO-UNDO.
DEFINE VARIABLE hLeaf             AS HANDLE  NO-UNDO.
DEFINE VARIABLE hSubLeaf          AS HANDLE  NO-UNDO.
DEFINE VARIABLE hLeaf2            AS HANDLE  NO-UNDO.
DEFINE VARIABLE hText             AS HANDLE  NO-UNDO.
DEFINE VARIABLE hBuf              AS HANDLE  NO-UNDO.
DEFINE VARIABLE hDBFld            AS HANDLE  NO-UNDO.
DEFINE VARIABLE ix                AS INTEGER NO-UNDO.
DEFINE SHARED TEMP-TABLE wdetail
    FIELD Username                  AS CHAR FORMAT "x(20)"  INIT ""       
    FIELD Password                  AS CHAR FORMAT "x(20)"  INIT ""       
    FIELD CompanyCode               AS CHAR FORMAT "x(10)"  INIT ""       
    FIELD BranchCd                  AS CHAR FORMAT "x(10)"  INIT ""       
    FIELD InsurerId                 AS CHAR FORMAT "x(10)"  INIT ""       
    FIELD PolicyStatus              AS CHAR FORMAT "x(10)"  INIT ""       
    FIELD PreviousPolicyNumber      AS CHAR FORMAT "x(20)"  INIT ""       
    FIELD Renewyr                   AS CHAR FORMAT "x(2)"   INIT ""       
    FIELD ContractNumber            AS CHAR FORMAT "x(32)"  INIT ""       
    FIELD ContractDt                AS CHAR FORMAT "x(10)"  INIT ""       
    FIELD ContractTime              AS CHAR FORMAT "x(10)"  INIT ""       
    FIELD CampaignNumber            AS CHAR FORMAT "x(20)"  INIT ""       
    FIELD QNumPremium               AS CHAR FORMAT "x(20)"  INIT ""       
    FIELD CMVApplicationNumber      AS CHAR FORMAT "x(32)"  INIT ""       
    FIELD InsuredType               AS CHAR FORMAT "x(2)"   INIT ""       
    FIELD InsuredBranch             AS CHAR FORMAT "x(10)"  INIT ""       
    FIELD InsuredCd                 AS CHAR FORMAT "x(10)"  INIT ""       
    FIELD InsuredUniqueID           AS CHAR FORMAT "x(15)"  INIT ""       
    FIELD InsuredUniqueIDExpDt      AS CHAR FORMAT "x(8)"   INIT ""       
    FIELD License                   AS CHAR FORMAT "x(15)"  INIT ""       
    FIELD BirthDt                   AS CHAR FORMAT "x(8)"   INIT ""       
    FIELD InsuredTitle              AS CHAR FORMAT "x(30)"  INIT ""       
    FIELD InsuredName               AS CHAR FORMAT "x(80)"  INIT ""       
    FIELD InsuredSurname            AS CHAR FORMAT "x(60)"  INIT ""       
    FIELD Addr                      AS CHAR FORMAT "x(80)"  INIT ""       
    FIELD SubDistrict               AS CHAR FORMAT "x(60)"  INIT ""       
    FIELD District                  AS CHAR FORMAT "x(50)"  INIT ""       
    FIELD Province                  AS CHAR FORMAT "x(50)"  INIT ""       
    FIELD PostalCode                AS CHAR FORMAT "x(5)"   INIT ""       
    FIELD OccupationDesc            AS CHAR FORMAT "x(50)"  INIT ""       
    FIELD MobilePhoneNumber         AS CHAR FORMAT "x(25)"  INIT ""       
    FIELD PhoneNumber               AS CHAR FORMAT "x(25)"  INIT ""       
    FIELD OfficePhoneNumber         AS CHAR FORMAT "x(25)"  INIT ""       
    FIELD EmailAddr                 AS CHAR FORMAT "x(50)"  INIT ""       
    FIELD ReceiptName               AS CHAR FORMAT "x(100)" INIT ""       
    FIELD ReceiptAddr               AS CHAR FORMAT "x(150)" INIT ""       
    FIELD VehGroup                  AS CHAR FORMAT "x(2)"   INIT ""       
    FIELD Manufacturer              AS CHAR FORMAT "x(20)"  INIT ""       
    FIELD Model                     AS CHAR FORMAT "x(40)"  INIT "" 
    FIELD ModelYear                 AS CHAR FORMAT "x(4)"   INIT ""   
    FIELD VehBodyTypeDesc           AS CHAR FORMAT "x(40)"  INIT ""   
    FIELD SeatingCapacity           AS CHAR FORMAT "x(2)"   INIT ""   
    FIELD Displacement              AS CHAR FORMAT "x(5)"   INIT ""   
    FIELD GrossVehOrCombinedWeight  AS CHAR FORMAT "x(5)"   INIT ""   
    FIELD Colour                    AS CHAR FORMAT "x(40)"  INIT ""   
    FIELD ChassisSerialNumber       AS CHAR FORMAT "x(30)"  INIT ""   
    FIELD EngineSerialNumber        AS CHAR FORMAT "x(30)"  INIT ""   
    FIELD Registration              AS CHAR FORMAT "x(10)"  INIT ""   
    FIELD RegisteredProvCd          AS CHAR FORMAT "x(30)"  INIT ""   
    FIELD RegisteredYear            AS CHAR FORMAT "x(4)"   INIT ""   
    FIELD PolicyTypeCd              AS CHAR FORMAT "x(4)"   INIT ""   
    FIELD RateGroup                 AS CHAR FORMAT "x(4)"   INIT ""   
    FIELD EffectiveDt               AS CHAR FORMAT "x(8)"   INIT ""   
    FIELD ExpirationDt              AS CHAR FORMAT "x(8)"   INIT ""   
    FIELD DocumentUID               AS CHAR FORMAT "x(20)"  INIT ""   
    FIELD SumInsureAmt              AS CHAR FORMAT "x(14)"  INIT ""   
    FIELD COLLAmtAccident           AS CHAR FORMAT "x(14)"  INIT ""   
    FIELD DeductibleCOLLAmtAccident AS CHAR FORMAT "x(14)"  INIT ""   
    FIELD FTAmt                     AS CHAR FORMAT "x(14)"  INIT ""   
    FIELD OptionValueDesc           AS CHAR FORMAT "x(250)" INIT ""   
    FIELD GarageTypeCd              AS CHAR FORMAT "x(20)"  INIT ""   
    FIELD InsuredTitle1             AS CHAR FORMAT "x(20)"  INIT ""   
    FIELD InsuredName1              AS CHAR FORMAT "x(80)"  INIT ""   
    FIELD InsuredSurname1           AS CHAR FORMAT "x(60)"  INIT ""   
    FIELD BirthDt1                  AS CHAR FORMAT "x(8)"   INIT ""   
    FIELD InsuredUniqueID1          AS CHAR FORMAT "x(15)"  INIT ""   
    FIELD InsuredTitle2             AS CHAR FORMAT "x(20)"  INIT ""   
    FIELD InsuredName2              AS CHAR FORMAT "x(80)"  INIT ""   
    FIELD InsuredSurname2           AS CHAR FORMAT "x(60)"  INIT ""   
    FIELD BirthDt2                  AS CHAR FORMAT "x(8)"   INIT ""    
    FIELD InsuredUniqueID2          AS CHAR FORMAT "x(15)"  INIT ""   
    FIELD WrittenAmt                AS CHAR FORMAT "x(14)"  INIT ""    
    FIELD RevenueStampAmt           AS CHAR FORMAT "x(14)"  INIT ""   
    FIELD VatAmt                    AS CHAR FORMAT "x(14)"  INIT ""   
    FIELD CurrentTermAmt            AS CHAR FORMAT "x(14)"  INIT ""   
    FIELD Beneficiaries             AS CHAR FORMAT "x(100)" INIT ""  
    FIELD VehicleUse                AS CHAR FORMAT "x(100)" INIT "" 
    FIELD CMIPolicyTypeCd           AS CHAR FORMAT "x(5)"   INIT ""     
    FIELD CMIVehTypeCd              AS CHAR FORMAT "x(4)"   INIT ""     
    FIELD CMIApplicationNumber      AS CHAR FORMAT "x(32)"  INIT ""    
    FIELD CMIEffectiveDt            AS CHAR FORMAT "x(8)"   INIT ""     
    FIELD CMIExpirationDt           AS CHAR FORMAT "x(8)"   INIT ""     
    FIELD CMIDocumentUID            AS CHAR FORMAT "x(20)"  INIT ""    
    FIELD CMIBarCodeNumber          AS CHAR FORMAT "x(13)"  INIT ""    
    FIELD CMIAmtPerson              AS CHAR FORMAT "x(14)"  INIT ""    
    FIELD CMIAmtAccident            AS CHAR FORMAT "x(14)"  INIT ""    
    FIELD CMIWrittenAmt             AS CHAR FORMAT "x(14)"  INIT ""    
    FIELD CMIRevenueStampAmt        AS CHAR FORMAT "x(14)"  INIT ""    
    FIELD CMIVatAmt                 AS CHAR FORMAT "x(14)"  INIT ""    
    FIELD CMICurrentTermAmt         AS CHAR FORMAT "x(14)"  INIT ""    
    FIELD PromptText                AS CHAR FORMAT "x(250)" INIT ""   
    FIELD MsgStatusCd               AS CHAR FORMAT "x(10)"  INIT ""    
    FIELD AgencyEmployee            AS CHAR FORMAT "x(50)"  INIT ""    
    FIELD RemarkText                AS CHAR FORMAT "x(100)" INIT ""
    FIELD poltyp                    AS CHAR FORMAT "x(3)"   INIT ""  .

{ wgw\wgwgxml3.i } 
DEF VAR CampaignNames AS CHAR .
DEF VAR nUsername     AS CHAR .
DEF VAR nPassword     AS CHAR .
/* Create SOAP header and server objects */
CREATE SOAP-HEADER hHeader.
CREATE SOAP-HEADER-ENTRYREF hHeaderEntryref.

CREATE X-DOCUMENT hDoc.
CREATE X-NODEREF  hRoot.       /*hXnoderef1*/
CREATE X-NODEREF  hRow.        /*hXnoderef2*/
CREATE X-NODEREF  hField.      /*hXnoderef3*/
CREATE X-NODEREF  hLeaf.       /*hXnoderef4*/
CREATE X-NODEREF  hSubField.   /*hXnoderef5*/
CREATE X-NODEREF  hSubLeaf.    /*hXnoderef6*/
CREATE X-NODEREF  hText.


FIND LAST wdetail WHERE wdetail.ContractNumber = nv_policyno NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL wdetail  THEN DO:
    FIND FIRST CACompany WHERE CACompany.InsurerCode = wdetail.CompanyCode NO-LOCK NO-ERROR NO-WAIT.
    IF AVAILABLE CACompany THEN 
        ASSIGN 
        nUsername =  CACompany.UserName   
        nPassword =  CACompany.Password   .
    ELSE 
        ASSIGN 
            nUsername =  ""  
            nPassword =  ""  .
    FIND LAST ExtPolLT70 WHERE ExtPolLT70.PolicyNumber = trim(nv_policyno) NO-ERROR NO-WAIT.
    IF NOT AVAIL ExtPolLT70 THEN DO:
        create ExtPolLT70.
        ASSIGN 
            ExtPolLT70.SystemRq                  = "LOCKTON"
            ExtPolLT70.ProcessStatus             = ""      
            ExtPolLT70.ProcessByUser             = "LOCKTON"
            ExtPolLT70.Policy                    = ""
            ExtPolLT70.ProcessDate               = STRING(TODAY,"99/99/9999")  
            ExtPolLT70.ProcessTime               = STRING(TIME,"HH:MM:SS") 
            ExtPolLT70.Releas                    = NO  
            /*Data to XML File */                
            ExtPolLT70.Username	                 = trim(nUsername)
            ExtPolLT70.Password	                 = trim(nPassword)
            ExtPolLT70.CompanyCode	             = wdetail.CompanyCode           /*Company Lockton */
            ExtPolLT70.BranchCd                  = wdetail.BranchCd              /*รหัสสาขา Dealer */
            ExtPolLT70.InsurerId	             = "STY"                         
            /*ExtPolLT70.PolicyStatus              = "N"                         /*A63-0432*/                        
            ExtPolLT70.PreviousPolicyNumber      = ""   */                       /*A63-0432*/ 
            ExtPolLT70.PolicyStatus              = wdetail.PolicyStatus          /*A63-0432*/                           
            ExtPolLT70.PreviousPolicyNumber      = wdetail.PreviousPolicyNumber  /*A63-0432*/ 
            ExtPolLT70.Renewyr                   = ""                            
            ExtPolLT70.ContractNumber	         = wdetail.ContractNumber        /*"QNOG322000-001"*/
            ExtPolLT70.ContractDt	             = STRING(YEAR(TODAY),"9999") + STRING(MONTH(TODAY),"99") + STRING(DAY(TODAY),"99")       
            ExtPolLT70.ContractTime	             = STRING(TIME,"HH:MM:SS")
            ExtPolLT70.CampaignNumber            = wdetail.CampaignNumber        
            ExtPolLT70.PolicyNumber              = ""                            /*D07057SK9999*/
            ExtPolLT70.InsuredType               = wdetail.InsuredType	       
            ExtPolLT70.InsuredBranch	         = wdetail.InsuredBranch        
            ExtPolLT70.InsuredCd	             = wdetail.InsuredCd            
            ExtPolLT70.InsuredUniqueID           = wdetail.InsuredUniqueID      
            ExtPolLT70.InsuredUniqueIDExpDt      = wdetail.InsuredUniqueIDExpDt 
            ExtPolLT70.License	                 = wdetail.License              
            ExtPolLT70.BirthDt	                 = wdetail.BirthDt              
            ExtPolLT70.InsuredTitle              = wdetail.InsuredTitle         
            ExtPolLT70.InsuredName	             = wdetail.InsuredName          
            ExtPolLT70.InsuredSurname            = wdetail.InsuredSurname       
            ExtPolLT70.Addr	                     = wdetail.Addr                 
            ExtPolLT70.SubDistrict               = wdetail.SubDistrict          
            ExtPolLT70.District                  = wdetail.District             
            ExtPolLT70.Province                  = wdetail.Province             
            ExtPolLT70.PostalCode	             = wdetail.PostalCode           
            ExtPolLT70.OccupationDesc            = wdetail.OccupationDesc       
            ExtPolLT70.MobilePhoneNumber         = wdetail.MobilePhoneNumber    
            ExtPolLT70.PhoneNumber	             = wdetail.PhoneNumber          
            ExtPolLT70.OfficePhoneNumber         = wdetail.OfficePhoneNumber    
            ExtPolLT70.EmailAddr	             = wdetail.EmailAddr 
            ExtPolLT70.ReceiptName               = wdetail.ReceiptName     
            ExtPolLT70.ReceiptAddr               = wdetail.ReceiptAddr 
            ExtPolLT70.VehGroup	                 = wdetail.VehGroup                
            ExtPolLT70.Manufacturer	             = wdetail.Manufacturer            
            ExtPolLT70.Model	                 = wdetail.Model                   
            ExtPolLT70.ModelYear	             = wdetail.ModelYear               
            ExtPolLT70.VehBodyTypeDesc	         = wdetail.VehBodyTypeDesc         
            ExtPolLT70.SeatingCapacity	         = wdetail.SeatingCapacity         
            ExtPolLT70.Displacement	             = wdetail.Displacement            
            ExtPolLT70.GrossVehOrCombinedWeight  = wdetail.GrossVehOrCombinedWeight
            ExtPolLT70.Colour	                 = wdetail.Colour                  
            ExtPolLT70.ChassisVINNumber 	     = wdetail.ChassisSerialNumber     
            ExtPolLT70.EngineSerialNumber	     = wdetail.EngineSerialNumber      
            ExtPolLT70.Registration	             = wdetail.Registration            
            ExtPolLT70.RegisteredProvCd          = wdetail.RegisteredProvCd        
            ExtPolLT70.RegisteredYear	         = wdetail.RegisteredYear 
            ExtPolLT70.PolicyTypeCd              = wdetail.PolicyTypeCd                                                    
            ExtPolLT70.RateGroup	             = wdetail.RateGroup                 
            ExtPolLT70.EffectiveDt               = wdetail.EffectiveDt                 
            ExtPolLT70.ExpirationDt              = wdetail.ExpirationDt               
            ExtPolLT70.DocumentUID               = wdetail.DocumentUID               
            ExtPolLT70.SumInsureAmt              = wdetail.SumInsureAmt 
            ExtPolLT70.COLLAmtAccident           = wdetail.COLLAmtAccident           
            ExtPolLT70.DeductibleCOLLAmtAccident = wdetail.DeductibleCOLLAmtAccident 
            ExtPolLT70.FTAmt                     = wdetail.FTAmt                     
            ExtPolLT70.OptionValueDesc           = wdetail.OptionValueDesc           
            ExtPolLT70.GarageTypeCd              = wdetail.GarageTypeCd    
            ExtPolLT70.InsuredTitle1             = wdetail.InsuredTitle1             
            ExtPolLT70.InsuredName1              = wdetail.InsuredName1              
            ExtPolLT70.InsuredSurname1           = wdetail.InsuredSurname1           
            ExtPolLT70.BirthDt1                  = wdetail.BirthDt1                  
            ExtPolLT70.InsuredUniqueID1          = wdetail.InsuredUniqueID1          
            ExtPolLT70.InsuredTitle2             = wdetail.InsuredTitle2             
            ExtPolLT70.InsuredName2              = wdetail.InsuredName2              
            ExtPolLT70.InsuredSurname2           = wdetail.InsuredSurname2           
            ExtPolLT70.BirthDt2                  = wdetail.BirthDt2                  
            ExtPolLT70.InsuredUniqueID2          = wdetail.InsuredUniqueID2          
            ExtPolLT70.WrittenAmt                = wdetail.WrittenAmt                
            ExtPolLT70.RevenueStampAmt           = wdetail.RevenueStampAmt           
            ExtPolLT70.VatAmt                    = wdetail.VatAmt                    
            ExtPolLT70.CurrentTermAmt            = wdetail.CurrentTermAmt            
            ExtPolLT70.Beneficiaries	         = wdetail.Beneficiaries             
            ExtPolLT70.VehicleUse                = wdetail.VehicleUse   
            ExtPolLT70.CMIPolicyTypeCd	         = wdetail.CMIPolicyTypeCd        
            ExtPolLT70.CMIVehTypeCd	             = wdetail.CMIVehTypeCd    
            ExtPolLT70.CMIApplicationNumber      = wdetail.CMIApplicationNumber 
            ExtPolLT70.CMIEffectiveDt	         = wdetail.CMIEffectiveDt             
            ExtPolLT70.CMIExpirationDt	         = wdetail.CMIExpirationDt   
            ExtPolLT70.CMIDocumentUID	         = wdetail.CMIDocumentUID       
            ExtPolLT70.CMIBarCodeNumber          = wdetail.CMIBarCodeNumber 
            ExtPolLT70.CMIAmtPerson	             = wdetail.CMIAmtPerson              
            ExtPolLT70.CMIAmtAccident	         = wdetail.CMIAmtAccident            
            ExtPolLT70.CMIWrittenAmt	         = wdetail.CMIWrittenAmt             
            ExtPolLT70.CMIRevenueStampAmt        = wdetail.CMIRevenueStampAmt        
            ExtPolLT70.CMIVatAmt	             = wdetail.CMIVatAmt                 
            ExtPolLT70.CMICurrentTermAmt         = wdetail.CMICurrentTermAmt    
            ExtPolLT70.PromptText                = wdetail.PromptText      
            ExtPolLT70.MsgStatusCd	             = wdetail.MsgStatusCd          
            ExtPolLT70.AgencyEmployee	         = wdetail.AgencyEmployee       
            ExtPolLT70.RemarkText	             = wdetail.RemarkText  .
    END.   /* ExtPolLT70 */
END.   /*wdetail */
/*- --------------------------------------------------------------------------- -*/
DEFINE VARIABLE nv_octets AS CHARACTER NO-UNDO.
/*RUN D:\WebWSKFK\WRS\WRSDigit.p (output nv_octets).*//*krid A58-0356*/
RUN    WGW\WGWDigit.p (output nv_octets).   /*krid  A58-0356 */

CREATE TB-RESPonse.
ASSIGN
TB-RESPonse.InsurerId               = ExtPolLT70.InsurerId
TB-RESPonse.CompanyCode             = ExtPolLT70.CompanyCode
TB-RESPonse.ContractNumber          = ExtPolLT70.ContractNumber
TB-RESPonse.CMVApplicationNumber    = ExtPolLT70.CMVApplicationNumber
TB-RESPonse.CMIPolicyNumber         = ExtPolLT70.CMIApplicationNumber
/**/
TB-RESPonse.PolicyNumber            = "Q07057999999" 
                                    /*
                                    + SUBSTR(STRING(TIME,"HH:MM:SS"),4,2)
                                    + SUBSTR(STRING(TIME,"HH:MM:SS"),7,2) */
TB-RESPonse.DocumentUID             = "" /*STRING(MTIME MODULO 999,"999") + STRING(MTIME,"99999999")*/
TB-RESPonse.CMIPolicyNumber         = "D07257999999"
TB-RESPonse.CMIDocumentUID          = "9999123" 
TB-RESPonse.CMIBarCodeNumber        = "0215254485821" 
TB-RESPonse.RecordGUIDRs            = "09f3a163-1329-4726-e8ca-d54945479f66"  /*nv_octets*/
TB-RESPonse.TransactionResponseDt   = "20140208" /*STRING(YEAR(TODAY),"9999")
                                    + STRING(MONTH(TODAY),"99") 
                                    + STRING(DAY(TODAY),"99")*/
TB-RESPonse.TransactionResponseTime = "11:19:33"   /*STRING(TIME,"HH:MM:SS")*/
TB-RESPonse.MsgStatusCd             = "SUCCESS".
TB-RESPonse.LinkPolicy              = "http://localhost/LINKTest/D07257999999.PDF".
/* **********************************************************************/
/* END OF FILE FTMGet01.I */
IF nv_URL = "" THEN nv_URL = "http://localhost:8080/wsa/wsa1/wsdl?targetURI=urn:SPSTYInsurance:SendReqPolicy".
EnvelopeNS = nv_URL .
/*1*/
/* Create the header entry */
hHeader:ADD-HEADER-ENTRY(hHeaderEntryref).

hDoc:CREATE-NODE-NAMESPACE(hRoot, EnvelopeNS, 
                           nv_node-nameHeader, "ELEMENT").
hDoc:CREATE-NODE-NAMESPACE(hRow, "http://www.w3.org/2000/xmlns/", 
                           "xmlns", "ATTRIBUTE").
hRow:NODE-VALUE = EnvelopeNS.  
hRoot:SET-ATTRIBUTE-NODE(hRow).
/* -- */
hDoc:CREATE-NODE-NAMESPACE(hField, "http://www.w3.org/2000/xmlns/", 
                           "xmlns:soap", "ATTRIBUTE").
hField:NODE-VALUE = "http://schemas.xmlsoap.org/soap/envelope/".
hRoot:SET-ATTRIBUTE-NODE(hField).    
/* -- */
hDoc:CREATE-NODE-NAMESPACE(hLeaf, "http://www.w3.org/2000/xmlns/", 
                           "xmlns:xsd", "ATTRIBUTE"). 
hLeaf:NODE-VALUE = "http://www.w3.org/2001/XMLSchema".
hRoot:SET-ATTRIBUTE-NODE(hLeaf).
/* -- */
hDoc:CREATE-NODE-NAMESPACE(hSubField, "http://www.w3.org/2000/xmlns/", 
                           "xmlns:xsi", "ATTRIBUTE"). 
hSubField:NODE-VALUE = "http://www.w3.org/2001/XMLSchema-instance".
hRoot:SET-ATTRIBUTE-NODE(hSubField).
/* -- */
hDoc:INSERT-BEFORE(hRoot, ?).
FOR EACH ExtPolLT70 NO-LOCK:
    RUN Proc_PutRow (EnvelopeNS, "Username",                ExtPolLT70.Username      ).
    RUN Proc_PutRow (EnvelopeNS, "Password",                ExtPolLT70.Password      ).
    RUN Proc_PutRow (EnvelopeNS, "CompanyCode",             ExtPolLT70.CompanyCode   ).
    RUN Proc_PutRow (EnvelopeNS, "BranchCd",                ExtPolLT70.BranchCd      ).
    RUN Proc_PutRow (EnvelopeNS, "InsurerId",               ExtPolLT70.InsurerId     ).
    RUN Proc_PutRow (EnvelopeNS, "PolicyStatus",            ExtPolLT70.PolicyStatus  ).
    RUN Proc_PutRow (EnvelopeNS, "PolicyStatus",            ExtPolLT70.PreviousPolicyNumber  ).
    RUN Proc_PutRow (EnvelopeNS, "PreviousPolicyNumber",    ExtPolLT70.CampaignNumber).
    RUN Proc_PutRow (EnvelopeNS, "QNumPremium",             ExtPolLT70.QNumPremium   ).
    RUN Proc_PutRow (EnvelopeNS, "ContractNumber",          ExtPolLT70.ContractNumber). 
    RUN Proc_PutRow (EnvelopeNS, "ContractDt",              ExtPolLT70.ContractDt    ). 
    RUN Proc_PutRow (EnvelopeNS, "ContractTime",            ExtPolLT70.ContractTime  ).
    RUN Proc_PutRow (EnvelopeNS, "CMIApplicationNumber",    ExtPolLT70.CMIApplicationNumber).
    RUN Proc_PutRow (EnvelopeNS, "InsuredType",             ExtPolLT70.InsuredType    ).
    RUN Proc_PutRow (EnvelopeNS, "InsuredBranch",           ExtPolLT70.InsuredBranch  ).
    RUN Proc_PutRow (EnvelopeNS, "InsuredCd",               ExtPolLT70.InsuredCd      ).
    RUN Proc_PutRow (EnvelopeNS, "InsuredUniqueID",         ExtPolLT70.InsuredUniqueID).
    RUN Proc_PutRow (EnvelopeNS, "InsuredUniqueIDExpDt",    ExtPolLT70.InsuredUniqueIDExpDt).
    RUN Proc_PutRow (EnvelopeNS, "License",                 ExtPolLT70.License       ).
    RUN Proc_PutRow (EnvelopeNS, "BirthDt",                 ExtPolLT70.BirthDt       ).
    RUN Proc_PutRow (EnvelopeNS, "InsuredTitle",            ExtPolLT70.InsuredTitle  ).
    RUN Proc_PutRow (EnvelopeNS, "InsuredName",             ExtPolLT70.InsuredName   ).
    RUN Proc_PutRow (EnvelopeNS, "InsuredSurname",          ExtPolLT70.InsuredSurname).
    RUN Proc_PutRow (EnvelopeNS, "Addr",                    ExtPolLT70.Addr             ).
    RUN Proc_PutRow (EnvelopeNS, "SubDistrict",             ExtPolLT70.SubDistrict      ).
    RUN Proc_PutRow (EnvelopeNS, "District",                ExtPolLT70.District         ).
    RUN Proc_PutRow (EnvelopeNS, "Province",                ExtPolLT70.Province         ).
    RUN Proc_PutRow (EnvelopeNS, "PostalCode",              ExtPolLT70.PostalCode       ).
    RUN Proc_PutRow (EnvelopeNS, "OccupationDesc",          ExtPolLT70.OccupationDesc   ).
    RUN Proc_PutRow (EnvelopeNS, "MobilePhoneNumber",       ExtPolLT70.MobilePhoneNumber).
    RUN Proc_PutRow (EnvelopeNS, "PhoneNumber",             ExtPolLT70.PhoneNumber      ).
    RUN Proc_PutRow (EnvelopeNS, "OfficePhoneNumber",       ExtPolLT70.OfficePhoneNumber).
    RUN Proc_PutRow (EnvelopeNS, "EmailAddr",               ExtPolLT70.EmailAddr        ).
    RUN Proc_PutRow (EnvelopeNS, "ReceiptName",             ExtPolLT70.ReceiptName).
    RUN Proc_PutRow (EnvelopeNS, "ReceiptAddr",             ExtPolLT70.ReceiptAddr).
    RUN Proc_PutRow (EnvelopeNS, "VehGroup",                ExtPolLT70.VehGroup).
    RUN Proc_PutRow (EnvelopeNS, "Manufacturer",            ExtPolLT70.Manufacturer   ).
    RUN Proc_PutRow (EnvelopeNS, "Model",                   ExtPolLT70.Model          ).
    RUN Proc_PutRow (EnvelopeNS, "ModelYear",               ExtPolLT70.ModelYear      ).
    RUN Proc_PutRow (EnvelopeNS, "VehBodyTypeDesc",         ExtPolLT70.VehBodyTypeDesc).
    RUN Proc_PutRow (EnvelopeNS, "SeatingCapacity",         ExtPolLT70.SeatingCapacity).
    RUN Proc_PutRow (EnvelopeNS, "Displacement",            ExtPolLT70.Displacement   ).
    RUN Proc_PutRow (EnvelopeNS, "GrossVehOrCombinedWeight",ExtPolLT70.GrossVehOrCombinedWeight).
    RUN Proc_PutRow (EnvelopeNS, "Colour",                  ExtPolLT70.Colour             ).
    RUN Proc_PutRow (EnvelopeNS, "ChassisSerialNumber",     ExtPolLT70.ChassisVINNumber).
    RUN Proc_PutRow (EnvelopeNS, "EngineSerialNumber",      ExtPolLT70.EngineSerialNumber ).
    RUN Proc_PutRow (EnvelopeNS, "Registration",            ExtPolLT70.Registration    ).
    RUN Proc_PutRow (EnvelopeNS, "RegisteredProvCd",        ExtPolLT70.RegisteredProvCd).
    RUN Proc_PutRow (EnvelopeNS, "RegisteredYear",          ExtPolLT70.RegisteredYear  ).
    /**/
    RUN Proc_RowHead (EnvelopeNS, "PolicyType").   /*HNodeRef2*/
    RUN Proc_PutField (EnvelopeNS, "PolicyTypeCd",  ExtPolLT70.PolicyTypeCd).
    RUN Proc_PutField (EnvelopeNS, "RateGroup",     ExtPolLT70.RateGroup).
    /* ---
    RUN Proc_PutField (EnvelopeNS, "PolicyNumber",  ExtPolLT70.PolicyNumber).
    --- */
    RUN Proc_PutField (EnvelopeNS, "EffectiveDt",   ExtPolLT70.EffectiveDt ).
    RUN Proc_PutField (EnvelopeNS, "ExpirationDt",  ExtPolLT70.ExpirationDt).
    /**/
    RUN Proc_PutField (EnvelopeNS, "DocumentUID",              ExtPolLT70.DocumentUID).
    RUN Proc_PutField (EnvelopeNS, "SumInsureAmt",             ExtPolLT70.SumInsureAmt).
    RUN Proc_PutField (EnvelopeNS, "COLLAmtAccident",          ExtPolLT70.COLLAmtAccident          ).
    RUN Proc_PutField (EnvelopeNS, "DeductibleCOLLAmtAccident",ExtPolLT70.DeductibleCOLLAmtAccident).
    RUN Proc_PutField (EnvelopeNS, "FTAmt",                    ExtPolLT70.FTAmt       ).
    RUN Proc_PutField (EnvelopeNS, "OptionValueDesc",          ExtPolLT70.OptionValueDesc).
    RUN Proc_PutField (EnvelopeNS, "GarageTypeCd",             ExtPolLT70.GarageTypeCd).
    /*
    /*Driver Name 1,2*/
    RUN Proc_PutField (EnvelopeNS, "InsuredTitle1",            ExtPolLT70.InsuredTitle1).
    RUN Proc_PutField (EnvelopeNS, "InsuredName1",             ExtPolLT70.InsuredName1).
    RUN Proc_PutField (EnvelopeNS, "InsuredSurname1",          ExtPolLT70.InsuredSurname1).
    RUN Proc_PutField (EnvelopeNS, "BirthDt1",                 ExtPolLT70.BirthDt1).
    RUN Proc_PutField (EnvelopeNS, "InsuredUniqueID1",         ExtPolLT70.InsuredUniqueID1).
    RUN Proc_PutField (EnvelopeNS, "InsuredTitle2",            ExtPolLT70.InsuredTitle2).
    RUN Proc_PutField (EnvelopeNS, "InsuredName2",             ExtPolLT70.InsuredName2).
    RUN Proc_PutField (EnvelopeNS, "InsuredSurname2",          ExtPolLT70.InsuredSurname2).
    RUN Proc_PutField (EnvelopeNS, "BirthDt2",                 ExtPolLT70.BirthDt2).
    RUN Proc_PutField (EnvelopeNS, "InsuredUniqueID2",         ExtPolLT70.InsuredUniqueID2).
    kridtiya i...*/
    /****************
    RUN Proc_PutField (EnvelopeNS, "TPBIAmtPerson",      ExtPolLT70.TPBIAmtPerson  ).
    RUN Proc_PutField (EnvelopeNS, "TPBIAmtAccident",    ExtPolLT70.TPBIAmtAccident).
    RUN Proc_PutField (EnvelopeNS, "PDAmtAccident",      ExtPolLT70.PDAmtAccident  ).
    RUN Proc_PutField (EnvelopeNS, "DeductiblePDAmtAccident",  ExtPolLT70.DeductiblePDAmtAccident  ).
    RUN Proc_PutField (EnvelopeNS, "COLLAmtAccident",          ExtPolLT70.COLLAmtAccident          ).
    RUN Proc_PutField (EnvelopeNS, "DeductibleCOLLAmtAccident",ExtPolLT70.DeductibleCOLLAmtAccident).
    RUN Proc_PutField (EnvelopeNS, "FTAmt",                    ExtPolLT70.FTAmt                    ).

    RUN Proc_PutField (EnvelopeNS, "PerilsPADriverAmt",             ExtPolLT70.PerilsPADriverAmt             ).
    RUN Proc_PutField (EnvelopeNS, "PerilsPANumPassengers",         ExtPolLT70.PerilsPANumPassengers         ).
    RUN Proc_PutField (EnvelopeNS, "PerilsPAPassengerAmt",          ExtPolLT70.PerilsPAPassengerAmt          ).
    RUN Proc_PutField (EnvelopeNS, "PerilsPATemporaryDriverAmt",    ExtPolLT70.PerilsPATemporaryDriverAmt    ).
    RUN Proc_PutField (EnvelopeNS, "PerilsPANumTemporaryPassengers",ExtPolLT70.PerilsPANumTemporaryPassengers).
    RUN Proc_PutField (EnvelopeNS, "PerilsPATemporaryPassengerAmt", ExtPolLT70.PerilsPATemporaryPassengerAmt ).
    RUN Proc_PutField (EnvelopeNS, "PerilsMedicalTreatmentAmt",     ExtPolLT70.PerilsMedicalTreatmentAmt     ).
    RUN Proc_PutField (EnvelopeNS, "PerilsBailBondInsuranceAmt",    ExtPolLT70.PerilsBailBondInsuranceAmt    ).
    ****************/
    RUN Proc_PutField (EnvelopeNS, "WrittenAmt",     ExtPolLT70.WrittenAmt     ).
    RUN Proc_PutField (EnvelopeNS, "RevenueStampAmt",ExtPolLT70.RevenueStampAmt).
    RUN Proc_PutField (EnvelopeNS, "VatAmt",         ExtPolLT70.VatAmt         ).
    RUN Proc_PutField (EnvelopeNS, "CurrentTermAmt", ExtPolLT70.CurrentTermAmt ).
    RUN Proc_PutField (EnvelopeNS, "Beneficiaries",  ExtPolLT70.Beneficiaries).
    RUN Proc_PutField (EnvelopeNS, "VehicleUse",     ExtPolLT70.VehicleUse     ).
  /**/
    RUN Proc_PutField (EnvelopeNS, "ReceiptName",    ExtPolLT70.ReceiptName).    /*Kridtiya i */
    /*RUN Proc_PutField (EnvelopeNS, "FinintUID",      ExtPolLT70.FinintUID).    /*Kridtiya i. */*/
  
  RUN Proc_RowHead (EnvelopeNS, "CMIPolicyType").   /*HNodeRef2*/

    RUN Proc_PutField (EnvelopeNS, "CMIPolicyTypeCd",     ExtPolLT70.CMIPolicyTypeCd   ).
    RUN Proc_PutField (EnvelopeNS, "CMIVehTypeCd",        ExtPolLT70.CMIVehTypeCd).
    RUN Proc_PutField (EnvelopeNS, "CMIApplicationNumber",ExtPolLT70.CMIApplicationNumber).
    /*
    RUN Proc_PutField (EnvelopeNS, "CMIPolicyNumber",     ExtPolLT70.CMIPolicyNumber   ).
    RUN Proc_PutField (EnvelopeNS, "CMIBarCodeNumber",    ExtPolLT70.CMIBarCodeNumber  ).
    */
    RUN Proc_PutField (EnvelopeNS, "CMIEffectiveDt",      ExtPolLT70.CMIEffectiveDt    ).
    RUN Proc_PutField (EnvelopeNS, "CMIExpirationDt",     ExtPolLT70.CMIExpirationDt   ).

    RUN Proc_PutField (EnvelopeNS, "CMIDocumentUID",      ExtPolLT70.CMIDocumentUID  ).
    RUN Proc_PutField (EnvelopeNS, "CMIBarCodeNumber",    ExtPolLT70.CMIBarCodeNumber).

    RUN Proc_PutField (EnvelopeNS, "CMIAmtPerson",        ExtPolLT70.CMIAmtPerson      ).
    RUN Proc_PutField (EnvelopeNS, "CMIAmtAccident",      ExtPolLT70.CMIAmtAccident    ).

    /* ---
    RUN Proc_PutField (EnvelopeNS, "CMIAmtPerson",        ExtPolLT70.CMIAmtPerson      ).
    RUN Proc_PutField (EnvelopeNS, "CMIAmtAccident",      ExtPolLT70.CMIAmtAccident    ).
    --- */

    RUN Proc_PutField (EnvelopeNS, "CMIWrittenAmt",       ExtPolLT70.CMIWrittenAmt     ).
    RUN Proc_PutField (EnvelopeNS, "CMIRevenueStampAmt",  ExtPolLT70.CMIRevenueStampAmt).
    RUN Proc_PutField (EnvelopeNS, "CMIVatAmt",           ExtPolLT70.CMIVatAmt         ).
    RUN Proc_PutField (EnvelopeNS, "CMICurrentTermAmt",   ExtPolLT70.CMICurrentTermAmt ).
  /**/
  
  /**/
  RUN Proc_PutRow (EnvelopeNS, "PromptText",        ExtPolLT70.PromptText    ).
  RUN Proc_PutRow (EnvelopeNS, "MsgStatusCd",       ExtPolLT70.MsgStatusCd   ).
  RUN Proc_PutRow (EnvelopeNS, "AgencyEmployee",    ExtPolLT70.AgencyEmployee).
  RUN Proc_PutRow (EnvelopeNS, "RemarkText",        ExtPolLT70.RemarkText    ).

END.

RELEASE ExtPolLT70.


/* ------------
FOR EACH TB-RESPonse NO-LOCK:

  RUN Proc_PutRow (EnvelopeNS, "CompanyCode",     TB-RESPonse.CompanyCode).
  RUN Proc_PutRow (EnvelopeNS, "PolicyNumber",    TB-RESPonse.PolicyNumber).
  RUN Proc_PutRow (EnvelopeNS, "ReferenceNumber", TB-RESPonse.ReferenceNumber).
  RUN Proc_PutRow (EnvelopeNS, "Result",          TB-RESPonse.ResultStatus).
  /*-
  RUN Proc_PutRow (EnvelopeNS, "ErrorMessage",    TB-RESPonse.ErrorMessage).
  -*/
END.
------------ */

/* *********************************************
   *********************************************
FOR EACH TB-RESPonse NO-LOCK:

  RUN Proc_PutRow (EnvelopeNS, "InsurerId",             TB-RESPonse.InsurerId).
  RUN Proc_PutRow (EnvelopeNS, "BatchNumberRq",         TB-RESPonse.BatchNumberRq).
  RUN Proc_PutRow (EnvelopeNS, "SequenceNumberRq",      TB-RESPonse.SequenceNumberRq).

  RUN Proc_PutRow (EnvelopeNS, "PaymentNumberRq",       TB-RESPonse.PaymentNumberRq).

  RUN Proc_PutRow (EnvelopeNS, "ClaimsOccurrence",      TB-RESPonse.ClaimsOccurrence).
  RUN Proc_PutRow (EnvelopeNS, "PolicyNumber",          TB-RESPonse.PolicyNumber).
  RUN Proc_PutRow (EnvelopeNS, "RecordGUIDRs",          TB-RESPonse.RecordGUIDRs).
  RUN Proc_PutRow (EnvelopeNS, "TransactionResponseDt", TB-RESPonse.TransactionResponseDt).
  RUN Proc_PutRow (EnvelopeNS, "MsgStatusCd",           TB-RESPonse.MsgStatusCd).

END.

FIND FIRST TB-ErrorCd NO-LOCK NO-ERROR NO-WAIT.
IF AVAILABLE TB-ErrorCd THEN DO:

  /*
  RUN Proc_RowHead   ("Errors"). */
  RUN Proc_RowHead (EnvelopeNS, "Errors").   /*HNodeRef2*/

  nv_ErrorCd = "".

  FOR EACH TB-ErrorCd NO-LOCK:

    IF nv_ErrorCd <> TB-ErrorCd.ErrorCode THEN DO:

      nv_ErrorCd = TB-ErrorCd.ErrorCode.
      /*
      RUN Proc_FieldHead ("Error"). */
      RUN Proc_FieldHead (EnvelopeNS, "Error").  /*HNodeRef3*/
    END.
    /*
    RUN Proc_PutLeaf ("ErrorCode",    TB-ErrorCd.ErrorCode).
    RUN Proc_PutLeaf ("ErrorMessage", TB-ErrorCd.ErrorMessage).
    */
    RUN Proc_PutLeaf(EnvelopeNS, "ErrorCode",    TB-ErrorCd.ErrorCode).     /*HNodeRef4*/
    RUN Proc_PutLeaf(EnvelopeNS, "ErrorMessage", TB-ErrorCd.ErrorMessage).  /*HNodeRef4*/

  END.
END.
*********************************************
********************************************* */

/* Fill the header entry using a deep copy */

hHeaderEntryref:SET-NODE(hRoot).
/* */
hDoc:SAVE("LONGCHAR",ResponseResult).
/* -------------------------------------- */
/* Write the XML node tree to an xml file */
/*nv_SavetoFile = "D:\xmlfile\" + TRIM(nv_node-nameHeader) + ".XML".   /*kridtiya i. Test */*/
nv_SavetoFile = TRIM(nv_node-nameHeader) + ".XML".   /*kridtiya i. Test start in */
hDoc:SAVE("file", nv_SavetoFile).

/* ----
hDoc:SAVE("file", "FTMGet04S.xml").

  <?xml version="1.0" ?> 
- <SendmotorResponseResult>
    <CompanyCode>2002</CompanyCode> 
    <PolicyNumber>DM7056123456</PolicyNumber> 
    <ReceiveNumber>20130615123456</ReceiveNumber> 
    <ResultStatus>SUCCESS</ResultStatus> 
    <ErrorMessage />
  </SendmotorResponseResult>

  -------------------------------

  <?xml version="1.0" ?> 
- <SendmotorResponseResult>
    <CompanyCode>2002</CompanyCode> 
    <PolicyNumber>DM7056123456</PolicyNumber> 
    <ReceiveNumber>20130615123456</ReceiveNumber> 
    <ResultStatus>FAIL</ResultStatus> 
    <ErrorMessage>ไม่พบ เลขตัวถังรถ/เลขรถ</ErrorMessage> 
  </SendmotorResponseResult>

---- */

/* -------------------------------------- */
/* -------------------------------
/*--------- อีกรูปแบบที่เลือกใช้ --------*/
DEFINE VARIABLE longstring AS LONGCHAR NO-UNDO.
DEFINE STREAM xmlstream.

hDoc:SAVE("LONGCHAR",longstring).

OUTPUT STREAM xmlstream TO WRQTES2.xml.

hDoc:SAVE("stream","xmlstream").

OUTPUT STREAM xmlstream CLOSE.
------------------------------- */

DELETE OBJECT hDoc.
DELETE OBJECT hRoot.
DELETE OBJECT hRow.
DELETE OBJECT hField.
DELETE OBJECT hText.

/* ******************************************************************** */
/* END OF MAIN PROGRAM */



/* ------------------------- P R O C E D U R E ------------------------ */


PROCEDURE Proc_RowHead:     /*Parant2*/
/**/
    DEFINE INPUT  PARAMETER CentityNS     AS CHARACTER.  /*node*/
    DEFINE INPUT  PARAMETER CNameElement  AS CHARACTER.  /*"PolicyNumber"*/

    hDoc:CREATE-NODE-NAMESPACE(hRow,CentityNS,
                                CNameElement, "ELEMENT").
    hRoot:APPEND-CHILD(hRow).
/**/
END PROCEDURE.

PROCEDURE Proc_PutRow:

    DEFINE INPUT  PARAMETER CentityNS     AS CHARACTER.  /*node*/
    DEFINE INPUT  PARAMETER CNameElement  AS CHARACTER.  /*"PolicyNumber"*/
    DEFINE INPUT  PARAMETER CNode_Value   AS CHARACTER.  /*"DM7469002393"*/
    /* */

    /* Create a tag with the field name */

    hDoc:CREATE-NODE-NAMESPACE(hRow,CentityNS,
                                CNameElement, "ELEMENT").
    hRoot:APPEND-CHILD(hRow).

    hDoc:CREATE-NODE(hText, "", "text"). /* Add a node to hold field value */
    hRow:APPEND-CHILD(hText).            /* Attach the text to the field */
    hText:NODE-VALUE = CNode_Value.

/**/
END PROCEDURE.
/* ------------------------------------- */

PROCEDURE Proc_FieldHead:     /*Parant3*/
/**/
    DEFINE INPUT  PARAMETER CentityNS     AS CHARACTER.  /*node*/
    DEFINE INPUT  PARAMETER CNameElement  AS CHARACTER.  /*"PolicyNumber"*/

    hDoc:CREATE-NODE-NAMESPACE(hField,CentityNS,
                                CNameElement, "ELEMENT").
    hRow:APPEND-CHILD(hField).
/**/
END PROCEDURE.

PROCEDURE Proc_PutField:
/**/
    DEFINE INPUT  PARAMETER CentityNS     AS CHARACTER.  /*node*/
    DEFINE INPUT  PARAMETER CNameElement  AS CHARACTER.  /*"PolicyNumber"*/
    DEFINE INPUT  PARAMETER CNode_Value   AS CHARACTER.  /*"DM7469002393"*/

    hDoc:CREATE-NODE-NAMESPACE(hField,CentityNS,
                                CNameElement, "ELEMENT").
    hRow:APPEND-CHILD(hField).

    hDoc:CREATE-NODE(hText, "", "TEXT").
    hField:APPEND-CHILD(hText).
    hText:NODE-VALUE = CNode_Value.

/**/
END PROCEDURE.
/* ------------------------------------- */

PROCEDURE Proc_LeafHead:     /*Parant4*/
/**/
    DEFINE INPUT  PARAMETER CentityNS     AS CHARACTER.  /*node*/
    DEFINE INPUT  PARAMETER CNameElement  AS CHARACTER.  /*"PolicyNumber"*/

    hDoc:CREATE-NODE-NAMESPACE(hLeaf,CentityNS,
                                CNameElement, "ELEMENT").
    hField:APPEND-CHILD(hLeaf).
/**/
END PROCEDURE.

PROCEDURE Proc_PutLeaf:
/**/
    DEFINE INPUT  PARAMETER CentityNS     AS CHARACTER.  /*node*/
    DEFINE INPUT  PARAMETER CNameElement  AS CHARACTER.  /*"PolicyNumber"*/
    DEFINE INPUT  PARAMETER CNode_Value   AS CHARACTER.  /*"DM7469002393"*/

    hDoc:CREATE-NODE-NAMESPACE(hLeaf,CentityNS,
                                CNameElement, "ELEMENT").
    hField:APPEND-CHILD(hLeaf).

    hDoc:CREATE-NODE(hText, "", "TEXT").
    hLeaf:APPEND-CHILD(hText).
    hText:NODE-VALUE = CNode_Value.

/**/
END PROCEDURE.
/* ------------------------------------- */

PROCEDURE Proc_SubFieldHead:     /*Parant5*/
/**/
    DEFINE INPUT  PARAMETER CentityNS     AS CHARACTER.  /*node*/
    DEFINE INPUT  PARAMETER CNameElement  AS CHARACTER.  /*"PolicyNumber"*/

    hDoc:CREATE-NODE-NAMESPACE(hSubField,CentityNS,
                                CNameElement, "ELEMENT").
    hLeaf:APPEND-CHILD(hSubField).
/**/
END PROCEDURE.

PROCEDURE Proc_PutSubField:
/**/
    DEFINE INPUT  PARAMETER CentityNS     AS CHARACTER.  /*node*/
    DEFINE INPUT  PARAMETER CNameElement  AS CHARACTER.  /*"PolicyNumber"*/
    DEFINE INPUT  PARAMETER CNode_Value   AS CHARACTER.  /*"DM7469002393"*/

    hDoc:CREATE-NODE-NAMESPACE(hSubField,CentityNS,
                                CNameElement, "ELEMENT").
    hLeaf:APPEND-CHILD(hSubField).

    hDoc:CREATE-NODE(hText, "", "TEXT").
    hSubField:APPEND-CHILD(hText).
    hText:NODE-VALUE = CNode_Value.
/**/
END PROCEDURE.
/* ------------------------------------- */
PROCEDURE Proc_PutSubLeaf:
/**/
    DEFINE INPUT  PARAMETER CentityNS     AS CHARACTER.  /*node*/
    DEFINE INPUT  PARAMETER CNameElement  AS CHARACTER.  /*"PolicyNumber"*/
    DEFINE INPUT  PARAMETER CNode_Value   AS CHARACTER.  /*"DM7469002393"*/

    /* Create a tag with the field name */

    hDoc:CREATE-NODE-NAMESPACE(hSubLeaf,CentityNS,
                                CNameElement, "ELEMENT").
    hSubField:APPEND-CHILD(hSubLeaf).

    hDoc:CREATE-NODE(hText, "", "TEXT"). /* Add a node to hold field value */
    hSubLeaf:APPEND-CHILD(hText).            /* Attach the text to the field */
    hText:NODE-VALUE = CNode_Value.
/**/
END PROCEDURE.
/* ---------------------------------------------------- */
/* END OF : FTMGet04S.P */
