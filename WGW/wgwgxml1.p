/*************************************************************************
 Program id   : wgwgxml1.p
 copy program : UFTMGet04S1_Pol.P  : SAVE Data Response to ResponseResult return TYPE SOAP
                D:\WebBU\UTIL\UFTMGet04S1_Pol.P
 Copyright    : Safety Insurance Public Company Limited
                บริษัท ประกันคุ้มภัย จำกัด (มหาชน)
 ------------------------------------------------------------------------
 Database     : BUInt ....Kridtiya test create data to buext ....
                ปรับแก้ไขโปรแกรม UFTMGet04S1_Pol.P จากเดิม สร้างไฟล์ xml ปรับเป็น 
                create data to DB BUExt table ExtPolLT70
 modify by    : Kridtiya i. A59-0170  add docno.        
 modify by    : Kridtiya i. A61-0368  close field Campaign Code ...      
 ------------------------------------------------------------------------
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
    FIELD policy         AS CHAR FORMAT "x(25)"  INIT ""  /* notify number*/  
    FIELD poltyp         AS CHAR FORMAT "x(3)"   INIT ""  /* policy       */                
    FIELD cedpol         AS CHAR FORMAT "x(10)"  INIT ""  /* account no.*/     
    FIELD tiname         AS CHAR FORMAT "x(30)"  INIT ""  /* title name */     
    FIELD insnam         AS CHAR FORMAT "x(60)"  INIT ""  /* first name */     
    FIELD insnam2        AS CHAR FORMAT "x(60)"  INIT ""  /* first name */     
    FIELD insnam3        AS CHAR FORMAT "x(60)"  INIT ""                
    FIELD addr1          AS CHAR FORMAT "x(100)" INIT ""  /* address1   */     
    FIELD tambon         AS CHAR FORMAT "x(35)"  INIT ""                
    FIELD amper          AS CHAR FORMAT "x(35)"  INIT ""                
    FIELD country        AS CHAR FORMAT "x(35)"  INIT ""                
    FIELD caryear        AS CHAR FORMAT "x(4)"   INIT ""  /* year       */  
    FIELD eng            AS CHAR FORMAT "x(25)"  INIT ""  /* engine     */  
    FIELD chasno         AS CHAR FORMAT "x(25)"  INIT ""  /* chassis    */  
    FIELD engcc          AS CHAR FORMAT "x(5)"   INIT ""  /* weight     */  
    FIELD vehreg         AS CHAR FORMAT "x(11)"  INIT ""  /* licence no */     
    FIELD garage         AS CHAR FORMAT "x(1)"   INIT ""  /* garage     */  
    FIELD vehuse         AS CHAR FORMAT "x(1)"   INIT ""  /* vehuse     */  
    FIELD comdat         AS CHAR FORMAT "x(10)"  INIT ""  /* comdat     */  
    FIELD expdat         AS CHAR FORMAT "x(10)"  INIT ""  /* expiry date*/   
    FIELD si             AS CHAR FORMAT "x(15)"  INIT ""  /* sum si     */  
    FIELD fire           AS CHAR FORMAT "x(15)"  INIT ""  
    FIELD premt          AS CHAR FORMAT "x(15)"  INIT ""  /*  prem.1          */  
    FIELD premtnet       AS CHAR FORMAT "x(15)"  INIT ""  /*  prem.1          */ 
    FIELD stk            AS CHAR FORMAT "x(25)"  INIT ""  /* sticker          */  
    FIELD brand          AS CHAR FORMAT "x(50)"  INIT ""  /* brand            */     
    FIELD benname        AS CHAR FORMAT "x(65)"  INIT ""  /* beneficiary      */ 
    FIELD accesstxt      AS CHAR FORMAT "x(100)" INIT ""                      
    FIELD receipt_name   AS CHAR FORMAT "x(50)"  INIT ""  /* receipt name     */  
    FIELD receipt_addr   AS CHAR FORMAT "x(150)"  INIT ""  /* receipt name     */  
    FIELD prepol         AS CHAR FORMAT "x(25)"  INIT ""  /* old policy       */     
    FIELD ncb            AS CHAR FORMAT "X(10)"  INIT ""  /* deduct disc.     */     
    FIELD dspc           AS CHAR FORMAT "X(10)"  INIT ""  /* deduct disc.     */     
    FIELD tp1            AS CHAR FORMAT "X(14)"  INIT ""  /* TPBI/Person      */     
    FIELD tp2            AS CHAR FORMAT "X(14)"  INIT ""  /* TPBI/Per Acciden */     
    FIELD tp3            AS CHAR FORMAT "X(14)"  INIT ""  /* TPPD/Per Acciden */     
    FIELD covcod         AS CHAR FORMAT "x(1)"   INIT ""  /* covcod           */     
    FIELD cndat          AS CHAR FORMAT "x(10)"  INIT ""   
    FIELD compul         AS CHAR FORMAT "x"      INIT "" 
    FIELD model          AS CHAR FORMAT "x(50)"  INIT ""   
    FIELD seat           AS CHAR FORMAT "x(2)"   INIT ""    
    FIELD remark         AS CHAR FORMAT "x(100)" INIT ""    
    FIELD comper         AS CHAR FORMAT "x(14)"  INIT ""    
    FIELD comacc         AS CHAR FORMAT "x(14)"  INIT ""    
    FIELD deductpd       AS CHAR FORMAT "X(14)"   INIT ""     
    FIELD deductpd2      AS CHAR FORMAT "X(14)"  INIT ""  
    FIELD cargrp         AS CHAR FORMAT "x"       INIT ""     
    FIELD body           AS CHAR FORMAT "x(40)"   INIT ""     
    FIELD NO_41          AS CHAR FORMAT "x(14)"   INIT ""  
    FIELD NO_42          AS CHAR FORMAT "x(14)"   INIT ""  
    FIELD NO_43          AS CHAR FORMAT "x(14)"   INIT ""  
    FIELD comment        AS CHAR FORMAT "x(512)"  INIT ""
    FIELD agent          AS CHAR FORMAT "x(10)"   INIT ""   
    FIELD producer       AS CHAR FORMAT "x(10)"   INIT ""  
    FIELD vatcode        AS CHAR FORMAT "x(10)"   INIT ""
    FIELD entdat         AS CHAR FORMAT "x(10)"   INIT ""      
    FIELD enttim         AS CHAR FORMAT "x(8)"    INIT ""       
    FIELD trandat        AS CHAR FORMAT "x(10)"   INIT "" 
    FIELD firstdat       AS CHAR FORMAT "x(10)"   INIT ""  
    FIELD trantim        AS CHAR FORMAT "x(8)"    INIT ""       
    FIELD n_IMPORT       AS CHAR FORMAT "x(2)"    INIT ""       
    FIELD n_EXPORT       AS CHAR FORMAT "x(2)"    INIT "" 
    FIELD pass           AS CHAR FORMAT "x"       INIT "n"
    FIELD OK_GEN         AS CHAR FORMAT "X"       INIT "Y" 
    FIELD renpol         AS CHAR FORMAT "x(32)"   INIT ""     
    FIELD cr_2           AS CHAR FORMAT "x(32)"   INIT ""  
    FIELD delerno        AS CHAR FORMAT "x(20)"   INIT ""  
    FIELD delerno1       AS CHAR FORMAT "x(20)"   INIT "" 
    FIELD delerno2       AS CHAR FORMAT "x(20)"   INIT "" 
    FIELD delername      AS CHAR FORMAT "x(60)"   INIT "" 
    FIELD docno          AS CHAR INIT "" FORMAT "x(10)" 
    FIELD redbook        AS CHAR INIT "" FORMAT "X(8)"
    FIELD drivnam        AS CHAR FORMAT "x"       INIT "n" 
    FIELD tariff         AS CHAR FORMAT "x(2)"    INIT "9"
    FIELD tons           AS DECI FORMAT "9999.99" INIT ""
    FIELD cancel         AS CHAR FORMAT "x(2)"    INIT ""    
    FIELD accdat         AS CHAR INIT "" FORMAT "x(10)"   
    FIELD prempa         AS CHAR FORMAT "x"       INIT ""       
    FIELD subclass       AS CHAR FORMAT "x(5)"    INIT ""    
    FIELD fleet          AS CHAR FORMAT "x(10)"   INIT ""   
    FIELD WARNING        AS CHAR FORMAT "X(30)"   INIT ""
    FIELD seat41         AS INTE FORMAT "99"      INIT 0
    FIELD volprem        AS CHAR FORMAT "x(20)"   INIT "" 
    FIELD icno           AS CHAR FORMAT "x(13)"   INIT ""
    FIELD n_branch       AS CHAR FORMAT "x(5)"    INIT "" 
    FIELD n_campaigns    AS CHAR FORMAT "x(40)"   INIT ""    /*A57-0432*/
    FIELD n_Promotion    AS CHAR FORMAT "x(16)"   INIT "".

{ wgw\wgwgxml1.i } 
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


FIND LAST wdetail WHERE wdetail.policy = nv_policyno NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL wdetail  THEN DO:
    IF  (deci(wdetail.tp1) =  1000000 )  AND
        (deci(wdetail.tp2) = 10000000 )  AND
        (deci(wdetail.tp3) =  5000000 )  THEN 
        /*CampaignNames = "C5800127_NEW".*/
         CampaignNames = "C6000099".
    ELSE CampaignNames = "C5800127_OLD".
    FIND FIRST CACompany WHERE CACompany.InsurerCode = "469" NO-LOCK NO-ERROR NO-WAIT.
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
        IF wdetail.poltyp     = "V70" THEN DO:
        
        create ExtPolLT70.
        assign
            ExtPolLT70.SystemRq             = "LOCKTON"
            ExtPolLT70.ProcessStatus        = ""      
            ExtPolLT70.ProcessByUser        = "LOCKTON"
            ExtPolLT70.Policy               = ""
            /**/                            
            ExtPolLT70.ProcessDate          = STRING(TODAY,"99/99/9999")  
            ExtPolLT70.ProcessTime          = STRING(TIME,"HH:MM:SS") 
            ExtPolLT70.Releas               = NO   
            /*Data to XML File */           
            ExtPolLT70.Username	            = trim(nUsername)
            ExtPolLT70.Password	            = trim(nPassword)
            ExtPolLT70.CompanyCode	        = "469"                         /*Company Lockton */
            ExtPolLT70.BranchCd             = TRIM(wdetail.delerno2)        /*รหัสสาขา Dealer */
            ExtPolLT70.InsurerId	        = "STY"                         
            ExtPolLT70.PolicyStatus         = "N"                           
            ExtPolLT70.PreviousPolicyNumber = ""                            
            ExtPolLT70.Renewyr              = ""                            
            ExtPolLT70.ContractNumber	    = trim(wdetail.cedpol)          /*"QNOG322000-001"*/
            ExtPolLT70.ContractDt	        = STRING(YEAR(TODAY),"9999") +  
                                             STRING(MONTH(TODAY),"99")  +   
                                               STRING(DAY(TODAY),"99")      
            ExtPolLT70.ContractTime	        = STRING(TIME,"HH:MM:SS")       
            /*ExtPolLT70.CampaignNumber       = CampaignNames     */   /*comment by Kridtiya i. A61-0368*/         
            /*ExtPolLT70.QNumPremium        = wdetail.cedpol                /* "QNOG322000-001"  */*//*by kridtiya i. */
            ExtPolLT70.PolicyNumber         = trim(nv_policyno)             /*D07057SK9999*/
            ExtPolLT70.DocumentUID          = STRING(wdetail.docno,"99999999")   /*STRING(MTIME MODULO 999,"999") + STRING((MTIME - 1111111),"99999999")*/
            ExtPolLT70.EffectiveDt	        = string(year(DATE(wdetail.comdat)),"9999") +  
                                             string(MONTH(DATE(wdetail.comdat)),"99") +
                                               string(DAY(DATE(wdetail.comdat)),"99") 
            ExtPolLT70.ExpirationDt         = string(year(date(wdetail.expdat)),"9999") +  
                                             string(MONTH(date(wdetail.expdat)),"99") +
                                               string(DAY(date(wdetail.expdat)),"99")
            /**/                                      
            ExtPolLT70.InsuredType              = "1"
            ExtPolLT70.InsuredBranch	        = ""
            ExtPolLT70.InsuredCd	            = ""
            ExtPolLT70.InsuredUniqueID          = trim(wdetail.icno)
            ExtPolLT70.InsuredUniqueIDExpDt     = ""
            ExtPolLT70.License	                = ""
            ExtPolLT70.BirthDt	                = ""
            ExtPolLT70.InsuredTitle             = trim(wdetail.tiname)
            ExtPolLT70.InsuredName	            = trim(wdetail.insnam) 
            ExtPolLT70.InsuredSurname           = ""
            ExtPolLT70.Addr	                    = trim(wdetail.addr1)    
            ExtPolLT70.SubDistrict              = trim(wdetail.tambon)   
            ExtPolLT70.District                 = trim(wdetail.amper)    
            ExtPolLT70.Province                 = trim(wdetail.country)  
            ExtPolLT70.PostalCode	            = ""
            ExtPolLT70.OccupationDesc           = ""
            ExtPolLT70.MobilePhoneNumber        = ""
            ExtPolLT70.PhoneNumber	            = ""
            ExtPolLT70.OfficePhoneNumber        = ""
            ExtPolLT70.EmailAddr	            = ""
            /**/                                
            ExtPolLT70.Beneficiaries	        = trim(wdetail.benname)
            /**/                                
            ExtPolLT70.VehTypeCd	            = trim(wdetail.subclass)
            ExtPolLT70.VehGroup	                = ""
            /**/                                
            ExtPolLT70.Manufacturer	            = trim(wdetail.brand)
            ExtPolLT70.Model	                = trim(wdetail.model)  
            ExtPolLT70.ModelYear	            = trim(wdetail.caryear)
            ExtPolLT70.VehBodyTypeDesc	        = trim(wdetail.body) 
            ExtPolLT70.SeatingCapacity	        = trim(wdetail.seat)
            ExtPolLT70.Displacement	            = trim(wdetail.engcc)
            ExtPolLT70.GrossVehOrCombinedWeight = ""
            ExtPolLT70.Colour	                = ""
            ExtPolLT70.ChassisVINNumber 	    = trim(wdetail.chasno)  /*ChassisSerialNumber*/
            ExtPolLT70.EngineSerialNumber	    = trim(wdetail.eng)
            /**/                                
            ExtPolLT70.Registration	            = trim(wdetail.vehreg)
            ExtPolLT70.RegisteredProvCd         = "99"   /*"กท"*/
            ExtPolLT70.RegisteredYear	        = trim(wdetail.caryear)
            /**/                                
            ExtPolLT70.PolicyTypeCd             = "1"
            ExtPolLT70.RateGroup	                  = trim(wdetail.subclass)
            ExtPolLT70.TPBIAmtPerson	              = ""
            ExtPolLT70.TPBIAmtAccident	              = ""
            ExtPolLT70.PDAmtAccident	              = ""
            ExtPolLT70.DeductiblePDAmtAccident        = "0"
            ExtPolLT70.COLLAmtAccident	              = trim(wdetail.si)
            ExtPolLT70.DeductibleCOLLAmtAccident      = ""
            ExtPolLT70.FTAmt                          = trim(wdetail.si)
            /**/                                      
            ExtPolLT70.PerilsPADriverAmt	          = ""
            ExtPolLT70.PerilsPANumPassengers          = ""
            ExtPolLT70.PerilsPAPassengerAmt           = ""
            ExtPolLT70.PerilsPATemporaryDriverAmt	  = ""
            ExtPolLT70.PerilsPANumTemporaryPassengers = ""
            ExtPolLT70.PerilsPATemporaryPassengerAmt  = ""
            ExtPolLT70.PerilsMedicalTreatmentAmt	  = ""
            ExtPolLT70.PerilsBailBondInsuranceAmt	  = ""
            /**/ 
            ExtPolLT70.WrittenAmt	                  = ""        /*"19073"*/
            ExtPolLT70.RevenueStampAmt                = ""
            ExtPolLT70.VatAmt	                      = ""
            ExtPolLT70.CurrentTermAmt	              = wdetail.premtnet
            ExtPolLT70.VehicleUse	                  = "ใช้ส่วนบุคคล ไม่ใช้รับจ้างหรือให้เช่า"
            ExtPolLT70.ReceiptName                    = TRIM(wdetail.insnam2) + (IF wdetail.insnam3 = "" THEN "" ELSE ":" + trim(wdetail.insnam3))     /*kridtiya i.*/
            ExtPolLT70.QNumPremium                    = trim(wdetail.n_Promotion)  /*kridtiya i.*/
            ExtPolLT70.Finint                         = "DE:" + trim(wdetail.delerno)  + " VAT:" + trim(wdetail.vatcode)    /*Kridtiya i.*/
            ExtPolLT70.PromptText                     = trim(wdetail.remark)       /*Kridtiya i.*/
            ExtPolLT70.SumInsureAmt                   = ExtPolLT70.FTAmt           /*kridtiya i.*/ 
            ExtPolLT70.OptionValueDesc                = trim(wdetail.accesstxt)    /*Kridtiya i.*/ 
            ExtPolLT70.GarageTypeCd                   = "ห้าง"                     /*Kridtiya i.*/ 
            /**/
            ExtPolLT70.ShowroomID                     = TRIM(wdetail.delerno1)
            ExtPolLT70.ShowroomName                   = TRIM(wdetail.delername)
            /**/
            ExtPolLT70.CMIPolicyTypeCd	        = ""
            ExtPolLT70.CMIVehTypeCd	            = ""
            /*ExtPolLT70.CMIApplicationNumber   = "COMPULSORYTEST01"*/
            ExtPolLT70.CMIPolicyNumber	        = ""
            ExtPolLT70.CMIBarCodeNumber         = ""
            
            ExtPolLT70.CMIPolicyNumber	        = ""               /* "D07257SK9999" */
            ExtPolLT70.CMIBarCodeNumber         = ""  /* "1234567890123450"*/
            ExtPolLT70.CMIDocumentUID	        = ""
            ExtPolLT70.CMIEffectiveDt	        = ""
            ExtPolLT70.CMIExpirationDt	        = ""
            ExtPolLT70.CMIAmtPerson	            = ""
            ExtPolLT70.CMIAmtAccident	        = ""
            ExtPolLT70.CMIWrittenAmt	        = ""
            ExtPolLT70.CMIRevenueStampAmt       = ""
            ExtPolLT70.CMIVatAmt	            = ""
            ExtPolLT70.CMICurrentTermAmt        = ""
            ExtPolLT70.MsgStatusCd	            = "Test"
            ExtPolLT70.AgencyEmployee	        = ""   /*"คุณทดสอบ ส่งงาน"*/
            ExtPolLT70.RemarkText	            = ""
            
            ExtPolLT70.InsuredTitle1            = ""
            ExtPolLT70.InsuredName1             = "" 
            ExtPolLT70.InsuredSurname1          = "" 
            ExtPolLT70.OccupationDesc1          = ""
            ExtPolLT70.BirthDt1                 = ""
            ExtPolLT70.InsuredUniqueID1         = ""
            ExtPolLT70.License1                 = ""
            ExtPolLT70.InsuredTitle2            = ""  
            ExtPolLT70.InsuredName2             = ""
            ExtPolLT70.InsuredSurname2          = "" 
            ExtPolLT70.OccupationDesc2          = ""
            ExtPolLT70.BirthDt2                 = "" 
            ExtPolLT70.InsuredUniqueID2         = ""
            ExtPolLT70.License2                 = ""
            /*ExtPolLT70.ReceiptName            = "ชื่อผู้ที่ออกใบกำกับภาษี"  */ /*Kridtiya i.*/
            ExtPolLT70.ReceiptAddr              = TRIM(wdetail.receipt_addr)  /*"ที่อยู่สำหรับ ออกที่หน้าใบกำกับภาษี"*/
            ExtPolLT70.SumInsureAmt             = ExtPolLT70.FTAmt            
            ExtPolLT70.OptionValueDesc          = trim(wdetail.accesstxt)     /*"อุปกรณ์พิเศษ ทดสอบการส่งข้อมูล."    */
            ExtPolLT70.GarageTypeCd             = "ห้าง"                      
            ExtPolLT70.PromptText               = trim(wdetail.remark)    .   
            ExtPolLT70.CMVApplicationNumber     = "".                         /* "MM" + SUBSTR(STRING(YEAR(TODAY) + 543,"9999"),3,2)
                                            + STRING(MONTH(TODAY),"99")
                                            + STRING(DAY(TODAY),"99")  
                                              /*
                                            + SUBSTR(STRING(TIME,"HH:MM:SS"),1,2)
                                            + SUBSTR(STRING(TIME,"HH:MM:SS"),4,2)
                                            + SUBSTR(STRING(TIME,"HH:MM:SS"),7,2)
                                              */
                                            + SUBSTR(STRING(MTIME,">>>>99999999"),10,3) .*/
            /*
            ExtPolLT70.CMVApplicationNumber = ExtPolLT70.ContractNumber.
            */
        END.
        ELSE DO:  /*cmi */
            create ExtPolLT70.
        assign
            ExtPolLT70.SystemRq             = "LOCKTON"
            ExtPolLT70.ProcessStatus        = ""      
            ExtPolLT70.ProcessByUser        = "LOCKTON"
            ExtPolLT70.Policy               = ""
            /**/                            
            ExtPolLT70.ProcessDate          = STRING(TODAY,"99/99/9999")  
            ExtPolLT70.ProcessTime          = STRING(TIME,"HH:MM:SS") 
            ExtPolLT70.Releas               = NO   
            /*Data to XML File */           
            ExtPolLT70.Username	            = trim(nUsername)
            ExtPolLT70.Password	            = trim(nPassword)
            ExtPolLT70.CompanyCode	        = "469"                         /*Company Lockton */
            ExtPolLT70.BranchCd             = TRIM(wdetail.delerno2)       /*รหัสสาขา Dealer */
            ExtPolLT70.InsurerId	        = "STY"                         
            ExtPolLT70.PolicyStatus         = "N"                           
            ExtPolLT70.PreviousPolicyNumber = ""                            
            ExtPolLT70.Renewyr              = ""                            
            ExtPolLT70.ContractNumber	    = trim(wdetail.cedpol)          /*"QNOG322000-001"*/
            ExtPolLT70.ContractDt	        = STRING(YEAR(TODAY),"9999") +  
                                             STRING(MONTH(TODAY),"99")  +   
                                               STRING(DAY(TODAY),"99")      
            ExtPolLT70.ContractTime	        = STRING(TIME,"HH:MM:SS")       
            /*ExtPolLT70.CampaignNumber       = CampaignNames     */   /*comment by Kridtiya i. A61-0368*/         
            /*ExtPolLT70.QNumPremium        = wdetail.cedpol                /* "QNOG322000-001"  */*//*by kridtiya i. */
            ExtPolLT70.PolicyNumber         = trim(nv_policyno)            /*D07057SK9999*/
            ExtPolLT70.DocumentUID          = "" /*STRING(wdetail.docno,"99999999") */  /*STRING(MTIME MODULO 999,"999") + STRING((MTIME - 1111111),"99999999")*/
           /* ExtPolLT70.EffectiveDt	        = string(year(DATE(wdetail.comdat)),"9999") +  
                                             string(MONTH(DATE(wdetail.comdat)),"99") +
                                               string(DAY(DATE(wdetail.comdat)),"99") 
            ExtPolLT70.ExpirationDt         = string(year(date(wdetail.expdat)),"9999") +  
                                             string(MONTH(date(wdetail.expdat)),"99") +
                                               string(DAY(date(wdetail.expdat)),"99")*/
            /**/                                      
            ExtPolLT70.InsuredType              = "1" 
            ExtPolLT70.InsuredBranch	        = ""
            ExtPolLT70.InsuredCd	            = ""
            ExtPolLT70.InsuredUniqueID          = trim(wdetail.icno)
            ExtPolLT70.InsuredUniqueIDExpDt     = ""
            ExtPolLT70.License	                = ""
            ExtPolLT70.BirthDt	                = ""
            ExtPolLT70.InsuredTitle             = trim(wdetail.tiname)
            ExtPolLT70.InsuredName	            = trim(wdetail.insnam) 
            ExtPolLT70.InsuredSurname           = ""
            ExtPolLT70.Addr	                    = trim(wdetail.addr1)    
            ExtPolLT70.SubDistrict              = trim(wdetail.tambon)   
            ExtPolLT70.District                 = trim(wdetail.amper)    
            ExtPolLT70.Province                 = trim(wdetail.country)  
            ExtPolLT70.PostalCode	            = ""
            ExtPolLT70.OccupationDesc           = ""
            ExtPolLT70.MobilePhoneNumber        = ""
            ExtPolLT70.PhoneNumber	            = ""
            ExtPolLT70.OfficePhoneNumber        = ""
            ExtPolLT70.EmailAddr	            = ""
            /**/                                
            ExtPolLT70.Beneficiaries	        = trim(wdetail.benname)
            /**/                                
            ExtPolLT70.VehTypeCd	            = trim(wdetail.subclass)
            ExtPolLT70.VehGroup	                = ""
            /**/                                
            ExtPolLT70.Manufacturer	            = trim(wdetail.brand)
            ExtPolLT70.Model	                = trim(wdetail.model)  
            ExtPolLT70.ModelYear	            = trim(wdetail.caryear)
            ExtPolLT70.VehBodyTypeDesc	        = trim(wdetail.body) 
            ExtPolLT70.SeatingCapacity	        = trim(wdetail.seat)
            ExtPolLT70.Displacement	            = trim(wdetail.engcc)
            ExtPolLT70.GrossVehOrCombinedWeight = ""
            ExtPolLT70.Colour	                = ""
            ExtPolLT70.ChassisVINNumber 	    = trim(wdetail.chasno)  /*ChassisSerialNumber*/
            ExtPolLT70.EngineSerialNumber	    = trim(wdetail.eng)
            /**/                                
            ExtPolLT70.Registration	            = trim(wdetail.vehreg)
            ExtPolLT70.RegisteredProvCd         = "99"   /*"กท"*/
            ExtPolLT70.RegisteredYear	        = trim(wdetail.caryear)
            /**/                                
            /*ExtPolLT70.PolicyTypeCd             = "1"*/
            /*ExtPolLT70.RateGroup	                  = trim(wdetail.subclass)*/
            ExtPolLT70.TPBIAmtPerson	              = ""
            ExtPolLT70.TPBIAmtAccident	              = ""
            ExtPolLT70.PDAmtAccident	              = ""
            ExtPolLT70.DeductiblePDAmtAccident        = "0"
           /* ExtPolLT70.COLLAmtAccident	              = trim(wdetail.si)*/
            ExtPolLT70.DeductibleCOLLAmtAccident      = ""
           /* ExtPolLT70.FTAmt                          = trim(wdetail.si)*/
            /**/                                      
            ExtPolLT70.PerilsPADriverAmt	          = ""
            ExtPolLT70.PerilsPANumPassengers          = ""
            ExtPolLT70.PerilsPAPassengerAmt           = ""
            ExtPolLT70.PerilsPATemporaryDriverAmt	  = ""
            ExtPolLT70.PerilsPANumTemporaryPassengers = ""
            ExtPolLT70.PerilsPATemporaryPassengerAmt  = ""
            ExtPolLT70.PerilsMedicalTreatmentAmt	  = ""
            ExtPolLT70.PerilsBailBondInsuranceAmt	  = ""
            /**/ 
            ExtPolLT70.WrittenAmt	                  = ""        /*"19073"*/
            ExtPolLT70.RevenueStampAmt                = ""
            ExtPolLT70.VatAmt	                      = ""
            /*ExtPolLT70.CurrentTermAmt	              = wdetail.premtnet*/
            ExtPolLT70.VehicleUse	                  = "ใช้ส่วนบุคคล ไม่ใช้รับจ้างหรือให้เช่า"
            ExtPolLT70.ReceiptName                    = TRIM(wdetail.insnam2) + (IF wdetail.insnam3 = "" THEN "" ELSE ":" + trim(wdetail.insnam3))     /*kridtiya i.*/
            ExtPolLT70.QNumPremium                    = trim(wdetail.n_Promotion)  /*kridtiya i.*/
            ExtPolLT70.Finint                         = "DE:" + trim(wdetail.delerno)  + " VAT:" + trim(wdetail.vatcode)    /*Kridtiya i.*/
            ExtPolLT70.PromptText                     = trim(wdetail.remark)       /*Kridtiya i.*/
            ExtPolLT70.SumInsureAmt                   = "" /*ExtPolLT70.FTAmt  */         /*kridtiya i.*/ 
            ExtPolLT70.OptionValueDesc                = "" /*trim(wdetail.accesstxt) */   /*Kridtiya i.*/ 
            ExtPolLT70.GarageTypeCd                   = ""                     /*Kridtiya i.*/ 
            /**/
            ExtPolLT70.ShowroomID                     = TRIM(wdetail.delerno1)
            ExtPolLT70.ShowroomName                   = TRIM(wdetail.delername)
            /**/
            ExtPolLT70.CMIPolicyTypeCd	        = "พรบ"
            ExtPolLT70.CMIVehTypeCd	            = trim(wdetail.subclass)
            /*ExtPolLT70.CMIApplicationNumber   = "COMPULSORYTEST01"*/
            ExtPolLT70.CMIPolicyNumber	        = ""
            ExtPolLT70.CMIBarCodeNumber         = ""
            
            ExtPolLT70.CMIPolicyNumber	        = ""               /* "D07257SK9999" */
            ExtPolLT70.CMIBarCodeNumber         = ""  /* "1234567890123450"*/
            ExtPolLT70.CMIDocumentUID	        = ""

            ExtPolLT70.CMIEffectiveDt	        = string(year(DATE(wdetail.comdat)),"9999") +  
                                                  string(MONTH(DATE(wdetail.comdat)),"99") +        
                                                  string(DAY(DATE(wdetail.comdat)),"99")          
            ExtPolLT70.CMIExpirationDt	        = string(year(date(wdetail.expdat)),"9999") +      
                                                  string(MONTH(date(wdetail.expdat)),"99") +        
                                                  string(DAY(date(wdetail.expdat)),"99")        

            ExtPolLT70.CMIAmtPerson	            = ""
            ExtPolLT70.CMIAmtAccident	        = ""
            ExtPolLT70.CMIWrittenAmt	        = IF trim(wdetail.subclass) = "110" THEN "600"
                                                  ELSE IF trim(wdetail.subclass) = "120A" THEN "1100"
                                                  ELSE "900"
            ExtPolLT70.CMIRevenueStampAmt       = ""
            ExtPolLT70.CMIVatAmt	            = ""
            ExtPolLT70.CMICurrentTermAmt        = wdetail.premtnet
            ExtPolLT70.MsgStatusCd	            = "Test"
            ExtPolLT70.AgencyEmployee	        = ""   /*"คุณทดสอบ ส่งงาน"*/
            ExtPolLT70.RemarkText	            = ""
            
            ExtPolLT70.InsuredTitle1            = ""
            ExtPolLT70.InsuredName1             = "" 
            ExtPolLT70.InsuredSurname1          = "" 
            ExtPolLT70.OccupationDesc1          = ""
            ExtPolLT70.BirthDt1                 = ""
            ExtPolLT70.InsuredUniqueID1         = ""
            ExtPolLT70.License1                 = ""
            ExtPolLT70.InsuredTitle2            = ""  
            ExtPolLT70.InsuredName2             = ""
            ExtPolLT70.InsuredSurname2          = "" 
            ExtPolLT70.OccupationDesc2          = ""
            ExtPolLT70.BirthDt2                 = "" 
            ExtPolLT70.InsuredUniqueID2         = ""
            ExtPolLT70.License2                 = ""
            /*ExtPolLT70.ReceiptName            = "ชื่อผู้ที่ออกใบกำกับภาษี"  */ /*Kridtiya i.*/
            ExtPolLT70.ReceiptAddr              = TRIM(wdetail.receipt_addr)  /*"ที่อยู่สำหรับ ออกที่หน้าใบกำกับภาษี"*/
           /* ExtPolLT70.SumInsureAmt             = ExtPolLT70.FTAmt */           
           /* ExtPolLT70.OptionValueDesc          = trim(wdetail.accesstxt) */    /*"อุปกรณ์พิเศษ ทดสอบการส่งข้อมูล."    */
            ExtPolLT70.GarageTypeCd             = ""                      
            ExtPolLT70.PromptText               = "" /*trim(wdetail.remark)*/    .   
            ExtPolLT70.CMVApplicationNumber     = "".                         /* "MM" + SUBSTR(STRING(YEAR(TODAY) + 543,"9999"),3,2)
                                            + STRING(MONTH(TODAY),"99")
                                            + STRING(DAY(TODAY),"99")  
                                              /*
                                            + SUBSTR(STRING(TIME,"HH:MM:SS"),1,2)
                                            + SUBSTR(STRING(TIME,"HH:MM:SS"),4,2)
                                            + SUBSTR(STRING(TIME,"HH:MM:SS"),7,2)
                                              */
                                            + SUBSTR(STRING(MTIME,">>>>99999999"),10,3) .*/
            /*
            ExtPolLT70.CMVApplicationNumber = ExtPolLT70.ContractNumber.
            */

        END.
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
/*
TB-RESPonse.CMIDocumentUID          = "". /*STRING(MTIME,"99999999") + STRING(MTIME MODULO 999,"999").*/
*/

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

  RUN Proc_PutRow (EnvelopeNS, "Username",      ExtPolLT70.Username   ).
  RUN Proc_PutRow (EnvelopeNS, "Password",      ExtPolLT70.Password   ).
  RUN Proc_PutRow (EnvelopeNS, "CompanyCode",   ExtPolLT70.CompanyCode).
  RUN Proc_PutRow (EnvelopeNS, "BranchCd",      ExtPolLT70.BranchCd   ).

  RUN Proc_PutRow (EnvelopeNS, "InsurerId",     ExtPolLT70.InsurerId     ).
  RUN Proc_PutRow (EnvelopeNS, "PolicyStatus",  ExtPolLT70.PolicyStatus  ).
  /*
  RUN Proc_PutRow (EnvelopeNS, "PreviousPolicyNumber",     ExtPolLT70.PreviousPolicyNumber).
  RUN Proc_PutRow (EnvelopeNS, "Renewyr",  ExtPolLT70.Renewyr).*/

  RUN Proc_PutRow (EnvelopeNS, "CampaignNumber",    ExtPolLT70.CampaignNumber ).
  RUN Proc_PutRow (EnvelopeNS, "QNumPremium",       ExtPolLT70.QNumPremium  ).

  RUN Proc_PutRow (EnvelopeNS, "ContractNumber",ExtPolLT70.ContractNumber).
  RUN Proc_PutRow (EnvelopeNS, "ContractDt",    ExtPolLT70.ContractDt    ).
  RUN Proc_PutRow (EnvelopeNS, "ContractTime",  ExtPolLT70.ContractTime  ).
  
  
  /*
  RUN Proc_PutRow (EnvelopeNS, "CMVApplicationNumber",ExtPolLT70.CMVApplicationNumber). */
  RUN Proc_PutRow (EnvelopeNS, "CMIApplicationNumber",ExtPolLT70.CMIApplicationNumber).
  /**/

  RUN Proc_PutRow (EnvelopeNS, "InsuredType",         ExtPolLT70.InsuredType    ).
  RUN Proc_PutRow (EnvelopeNS, "InsuredBranch",       ExtPolLT70.InsuredBranch  ).
  RUN Proc_PutRow (EnvelopeNS, "InsuredCd",           ExtPolLT70.InsuredCd      ).
  RUN Proc_PutRow (EnvelopeNS, "InsuredUniqueID",     ExtPolLT70.InsuredUniqueID).
  RUN Proc_PutRow (EnvelopeNS, "InsuredUniqueIDExpDt",ExtPolLT70.InsuredUniqueIDExpDt).
  RUN Proc_PutRow (EnvelopeNS, "License",             ExtPolLT70.License       ).
  RUN Proc_PutRow (EnvelopeNS, "BirthDt",             ExtPolLT70.BirthDt       ).
  RUN Proc_PutRow (EnvelopeNS, "InsuredTitle",        ExtPolLT70.InsuredTitle  ).
  RUN Proc_PutRow (EnvelopeNS, "InsuredName",         ExtPolLT70.InsuredName   ).
  RUN Proc_PutRow (EnvelopeNS, "InsuredSurname",      ExtPolLT70.InsuredSurname).
  RUN Proc_PutRow (EnvelopeNS, "Addr",             ExtPolLT70.Addr             ).
  RUN Proc_PutRow (EnvelopeNS, "SubDistrict",      ExtPolLT70.SubDistrict      ).
  RUN Proc_PutRow (EnvelopeNS, "District",         ExtPolLT70.District         ).
  RUN Proc_PutRow (EnvelopeNS, "Province",         ExtPolLT70.Province         ).
  RUN Proc_PutRow (EnvelopeNS, "PostalCode",       ExtPolLT70.PostalCode       ).
  RUN Proc_PutRow (EnvelopeNS, "OccupationDesc",   ExtPolLT70.OccupationDesc   ).
  RUN Proc_PutRow (EnvelopeNS, "MobilePhoneNumber",ExtPolLT70.MobilePhoneNumber).
  RUN Proc_PutRow (EnvelopeNS, "PhoneNumber",      ExtPolLT70.PhoneNumber      ).
  RUN Proc_PutRow (EnvelopeNS, "OfficePhoneNumber",ExtPolLT70.OfficePhoneNumber).
  RUN Proc_PutRow (EnvelopeNS, "EmailAddr",        ExtPolLT70.EmailAddr        ).
  /**/
  RUN Proc_PutRow (EnvelopeNS, "ReceiptName",      ExtPolLT70.ReceiptName).
  RUN Proc_PutRow (EnvelopeNS, "ReceiptAddr",      ExtPolLT70.ReceiptAddr).
  /* ---
  RUN Proc_PutRow (EnvelopeNS, "VehTypeCd",        ExtPolLT70.VehTypeCd).
  -- -*/
  RUN Proc_PutRow (EnvelopeNS, "VehGroup",         ExtPolLT70.VehGroup).

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
  /**/
  RUN Proc_PutRow (EnvelopeNS, "Registration",       ExtPolLT70.Registration    ).
  RUN Proc_PutRow (EnvelopeNS, "RegisteredProvCd",   ExtPolLT70.RegisteredProvCd).
  RUN Proc_PutRow (EnvelopeNS, "RegisteredYear",     ExtPolLT70.RegisteredYear  ).
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

  /* ****************
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
  **************** */
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
