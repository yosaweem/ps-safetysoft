/*programid   : wgwrbgen.w                                                           */ 
/*programname : Load Text & Generate text file rabit                               */ 
/*Copyright   : Safety Insurance Public Company Limited 			                   */ 
/*			    บริษัท ประกันคุ้มภัย จำกัด (มหาชน)				                       */ 
/*create by   : Kridtiya i. A64-0325 date. 21/08/2021                              
                ปรับโปรแกรมให้สามารถนำเข้า Load Text & Generate data                    */  
/***************************************************************************************/
DEF VARIABLE nv_agentname                 AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_short_id                  AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_PolicyStatus              AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_PreviousPolicyNumber      AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_Renewyr                   AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_ContractNumber            AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_CampaignNumber            AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_InsuredType               AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_InsuredBranch             AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_InsuredCd                 AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_InsuredUniqueID           AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_InsuredUniqueIDExpDt      AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_License                   AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_BirthDt                   AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_InsuredTitle              AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_InsuredName               AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_InsuredSurname            AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_Addr                      AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_SubDistrict               AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_District                  AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_Province                  AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_PostalCode                AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_OccupationDesc            AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_MobilePhoneNumber         AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_PhoneNumber               AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_OfficePhoneNumber         AS CHAR FORMAT "x(300)".  
DEF VARIABLE nv_EmailAddr                 AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_ReceiptName               AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_ReceiptAddr               AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_VehGroup                  AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_Manufacturer              AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_Model                     AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_ModelYear                 AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_VehBodyTypeDesc           AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_SeatingCapacity           AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_Displacement              AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_GrossVehOrCombinedWeight  AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_Colour                    AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_ChassisSerialNumber       AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_EngineSerialNumber        AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_Registration              AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_RegisteredProvCd          AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_RegisteredYear            AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_PolicyTypeCd              AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_RateGroup                 AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_EffectiveDt               AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_ExpirationDt              AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_DocumentUID               AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_SumInsureAmt              AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_COLLAmtAccident           AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_DeductibleCOLLAmtAccident AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_FTAmt                     AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_OptionValueDesc           AS CHAR FORMAT "x(200)".  
DEF VARIABLE nv_GarageTypeCd              AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_InsuredTitle1             AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_InsuredName1              AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_InsuredSurname1           AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_BirthDt1                  AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_InsuredUniqueID1          AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_InsuredTitle2             AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_InsuredName2              AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_InsuredSurname2           AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_BirthDt2                  AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_InsuredUniqueID2          AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_WrittenAmt                AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_RevenueStampAmt           AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_VatAmt                    AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_CurrentTermAmt            AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_Beneficiaries             AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_VehicleUse                AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_CMIPolicyTypeCd           AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_CMIVehTypeCd              AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_CMIApplicationNumber      AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_CMIEffectiveDt            AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_CMIExpirationDt           AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_CMIAmtPerson              AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_CMIAmtAccident            AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_CMIWrittenAmt             AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_CMIRevenueStampAmt        AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_CMIVatAmt                 AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_CMICurrentTermAmt         AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_PromptText                AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_MsgStatusCd               AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_AgencyEmployee            AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_RemarkText                AS CHAR FORMAT "x(100)".  
DEF VARIABLE nv_loadtype                  AS CHAR FORMAT "x(100)". 
      

DEFINE NEW SHARED TEMP-TABLE wdetail 
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

DEFINE VAR             nv_batprev   AS CHARACTER FORMAT "X(20)"     INIT ""  NO-UNDO.
DEFINE NEW SHARED VAR  nv_batchyr   AS INT FORMAT "9999"            INIT 0.
DEFINE NEW SHARED VAR  nv_batcnt    AS INT FORMAT "99"              INIT 0.
DEFINE NEW SHARED VAR  nv_batchno   AS CHARACTER FORMAT "X(20)"     INIT ""  NO-UNDO.
DEFINE VAR  nv_batbrn    AS CHARACTER FORMAT "x(2)"      INIT ""  NO-UNDO. 
DEFINE VAR  nv_batrunno  AS INT  FORMAT ">,>>9"          INIT 0.     
DEFINE VAR  nv_imppol    AS INT  FORMAT ">>,>>9"         INIT 0.     
DEFINE VAR  nv_impprem   AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.     
DEFINE VAR  nv_tmppolrun AS INTEGER FORMAT "999"         INIT 0.     
DEFINE VAR  nv_netprm_t  AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.     
DEFINE VAR  nv_netprm_s  AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.     
DEFINE VAR  nv_batflg    AS LOG                          INIT NO.    
DEFINE VAR  nv_rectot    AS INT  FORMAT ">>,>>9"         INIT 0.     
DEFINE VAR  nv_recsuc    AS INT  FORMAT ">>,>>9"         INIT 0.     
DEFINE VAR  nv_txtmsg    AS CHAR FORMAT "x(50)"          INIT "".    
DEFINE NEW SHARED VAR  NO_basemsg AS CHAR  FORMAT "x(50)" .          
DEFINE VAR  nv_tmppol    AS CHARACTER FORMAT "x(16)"     INIT "".    
DEFINE VAR  nv_docno   AS CHAR  FORMAT "9999999"    INIT " ".        
DEFINE            VAR  nv_accdat  AS DATE  FORMAT "99/99/9999" INIT ?  .  
DEF    NEW SHARED VAR  nv_message AS char.  
DEFINE VAR n_insref     AS CHARACTER FORMAT "X(10)". 
DEFINE VAR nv_usrid     AS CHARACTER FORMAT "X(08)".
DEFINE VAR nv_transfer  AS LOGICAL   .
DEFINE VAR n_check      AS CHARACTER .
DEFINE VAR nv_insref    AS CHARACTER FORMAT "X(10)". 
DEFINE VAR nv_typ       AS CHAR FORMAT "X(2)".
DEFINE VAR nv_class72rd AS CHAR FORMAT "X(4)". 
DEFINE VAR nv_simat     AS DECI INIT 0.         
DEFINE VAR nv_simat1    AS DECI INIT 0. 
DEFINE VAR np_chkErr    AS LOGICAL INIT NO.
DEFINE VAR nv_add1      AS CHAR INIT "" FORMAT "x(100)".
DEFINE VAR nv_add2      AS CHAR INIT "" FORMAT "x(50)".
DEFINE VAR nv_add3      AS CHAR INIT "" FORMAT "x(50)".
DEFINE VAR nv_add4      AS CHAR INIT "" FORMAT "x(50)".
DEFINE VAR nv_phone     AS CHAR INIT "" FORMAT "x(100)".
