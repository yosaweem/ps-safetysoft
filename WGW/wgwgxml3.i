/*************************************************************************
 FTMGet01.I     : Include Program Use in File FTMGet01.p
                  SendCMIEr1.p  SendCMIEr2.p  SendCMIGet.P  SendCMIP2.P 
                  SendCMIP3.P   SendCMIP4.P   SendCMIP4S.P
 Copyright      : Safety Insurance Public Company Limited
                  บริษัท ประกันคุ้มภัย จำกัด (มหาชน)
 Database       : -
 ------------------------------------------------------------------------
 CREATE BY      : Kridtiya i.   ASSIGN: A60-0495  DATE: 28/12/2017
*************************************************************************/

DEFINE  TEMP-TABLE  TB-GetRq   NO-UNDO  /* get data from field SendCMIPolicy*/
/* */
FIELD SystemRq                    AS CHARACTER FORMAT "x(10)"      /*1"SPFTM"*/
FIELD RqUID                       AS CHARACTER FORMAT "x(40)"      /*2*/
FIELD keyRequestIndRq             AS CHARACTER FORMAT "x(30)"      /*3*/
FIELD TransactionRequestDtRq      AS CHARACTER FORMAT "x(10)"      /*4*/
FIELD TransactionDateRq           AS DATE      FORMAT "99/99/9999" /*5*/
FIELD BatchNumberRq               AS CHARACTER FORMAT "x(10)"      /*6*/
FIELD SequenceNumberRq            AS CHARACTER FORMAT "x(10)"      /*7*/
/* ----------------------- */
FIELD Username                    AS CHARACTER FORMAT "x(20)"  /*Username */
FIELD Password                    AS CHARACTER FORMAT "x(20)"  /*Password */
FIELD CompanyCode                 AS CHARACTER FORMAT "x(10)"  /*รหัส  Broker/Finance */
FIELD BranchCd                    AS CHARACTER FORMAT "x(10)"  /*รหัส  BRANCH Broker/Finance */
FIELD InsurerId                   AS CHARACTER FORMAT "x(10)"  /*รหัสบริษัทประกันภัย  l*/
/**/
FIELD PolicyStatus                AS CHARACTER FORMAT "x(10)"  /*PolicyStatus*/
FIELD ContractNumber              AS CHARACTER FORMAT "x(20)"  /*เลขที่สัญญา l*/
FIELD ContractDt                  AS CHARACTER FORMAT "x(10)"  /*วันที่ทำสัญญา l*/
FIELD ContractTime                AS CHARACTER FORMAT "x(10)"  /*เวลาที่ทำสัญญา l*/
FIELD CMVApplicationNumber        AS CHARACTER FORMAT "x(30)"  /*หมายเลขอ้างอิง รถยนต์ ของ BROKER*/
/**/
FIELD ApplicationNumber           AS CHARACTER FORMAT "x(20)"  /*เลขที่สัญญา l*/
FIELD ApplicationDt               AS CHARACTER FORMAT "x(10)"  /*วันที่ทำสัญญา l*/
FIELD ApplicationTime             AS CHARACTER FORMAT "x(10)"  /*เวลาที่ทำสัญญา l*/
/* ----------------------- */
FIELD InsuredType                 AS CHARACTER FORMAT "x(04)"  /*ประเภทผู้เอาประกันภัย l*/
FIELD InsuredBranch               AS CHARACTER FORMAT "x(05)"  /*ลำดับที่สาขาผู้เอาประกันภัยกรณีนิติบุคคล l*/
FIELD InsuredCd                   AS CHARACTER FORMAT "x(10)"  /*รหัสผู้เอาประกันภัย l*/
FIELD InsuredUniqueID             AS CHARACTER FORMAT "x(20)"  /*หมายเลขยืนยันบุคคลผู้เอาประกันภัย l*/
FIELD InsuredUniqueIDExpDt        AS CHARACTER FORMAT "x(08)"  /*วันหมดอายุของหมายเลขยืนยันบุคคลผู้เอาประกันภัยl*/
FIELD License                     AS CHARACTER FORMAT "x(20)"  /*เลขที่ใบขับขี่ l*/
FIELD BirthDt                     AS CHARACTER FORMAT "x(08)"  /*วันเกิด */
FIELD InsuredTitle                AS CHARACTER FORMAT "x(30)"  /*คำนำหน้าชื่อผู้เอาประกันภัย l*/
FIELD InsuredName                 AS CHARACTER FORMAT "x(60)"  /*ชื่อผู้เอาประกันภัย l*/
FIELD InsuredSurname              AS CHARACTER FORMAT "x(60)"  /*ชื่อสกุลผู้เอาประกันภัย l*/
FIELD Addr                        AS CHARACTER FORMAT "x(150)" /*ที่อยู่ผู้เอาประกันภัย     l*/
FIELD SubDistrict                 AS CHARACTER FORMAT "x(45)"  /*ตำบล/แขวง l*/
FIELD District                    AS CHARACTER FORMAT "x(45)"  /*กิ่งอำเภอ/อำเภอ/เขต l*/
FIELD Province                    AS CHARACTER FORMAT "x(30)"  /*จังหวัด l*/
FIELD PostalCode                  AS CHARACTER FORMAT "x(05)"  /*รหัสไปรษณีย์ l*/
FIELD OccupationDesc              AS CHARACTER FORMAT "x(50)"  /*อาชีพ l*/
/**/
FIELD MobilePhoneNumber           AS CHARACTER FORMAT "x(25)"  /*เบอร์มือถือลูกค้า l*/
FIELD PhoneNumber                 AS CHARACTER FORMAT "x(25)"  /*เบอร์โทรศัพท์พื้นฐานลูกค้า l*/
FIELD OfficePhoneNumber           AS CHARACTER FORMAT "x(25)"  /*เบอร์โทรศัพท์ที่ทำงาน l*/
FIELD EmailAddr                   AS CHARACTER FORMAT "x(50)"  /*e-mail l*/
/**/
FIELD ReceiptName                 AS CHARACTER FORMAT "x(120)" /*ชื่อที่ระบุที่ใบกำกับภาษี*/
FIELD ReceiptAddr                 AS CHARACTER FORMAT "x(200)" /*ที่อยู่ ที่ระบุใบกำกับภาษี*/
/* ----------------------- */
FIELD DriverNameCd                AS CHARACTER FORMAT "x(04)"  /*ระบุชื่อผู้ขับขี่ หรือไม่ระบุชื่อผู้ขับขี่  l*/
FIELD InsuredTitle1               AS CHARACTER FORMAT "x(20)"  /*คำนำหน้าชื่อผู้เอาประกันภัย l*/
FIELD InsuredName1                AS CHARACTER FORMAT "x(60)"  /*ชื่อผู้เอาประกันภัย l*/
FIELD InsuredSurname1             AS CHARACTER FORMAT "x(50)"  /*ชื่อสกุลผู้เอาประกันภัย l*/
FIELD OccupationDesc1             AS CHARACTER FORMAT "x(50)"  /*อาชีพ l*/
FIELD BirthDt1                    AS CHARACTER FORMAT "x(08)"  /*วันเกิด */
FIELD InsuredUniqueID1            AS CHARACTER FORMAT "x(20)"  /*หมายเลขยืนยันบุคคลผู้เอาประกันภัย l*/
FIELD License1                    AS CHARACTER FORMAT "x(20)"  /*เลขที่ใบขับขี่ l*/
/**/
FIELD InsuredTitle2               AS CHARACTER FORMAT "x(20)"  /*คำนำหน้าชื่อผู้เอาประกันภัย l*/
FIELD InsuredName2                AS CHARACTER FORMAT "x(60)"  /*ชื่อผู้เอาประกันภัย l*/
FIELD InsuredSurname2             AS CHARACTER FORMAT "x(50)"  /*ชื่อสกุลผู้เอาประกันภัย l*/
FIELD OccupationDesc2             AS CHARACTER FORMAT "x(50)"  /*อาชีพ l*/
FIELD BirthDt2                    AS CHARACTER FORMAT "x(08)"  /*วันเกิด */
FIELD InsuredUniqueID2            AS CHARACTER FORMAT "x(20)"  /*หมายเลขยืนยันบุคคลผู้เอาประกันภัย l*/
FIELD License2                    AS CHARACTER FORMAT "x(20)"  /*เลขที่ใบขับขี่ l*/
/* ----------------------- */
FIELD Beneficiaries               AS CHARACTER FORMAT "x(80)"  /*ผู้รับผลประโยชน์ l*/
FIELD PolicyAttachment            AS CHARACTER FORMAT "x(100)" /*รายการเอกสารแนบท้าย l*/
FIELD VehicleUse                  AS CHARACTER FORMAT "x(100)" /*รหัสลักษณะการใช้งาน l*/
FIELD PromptText                  AS CHARACTER FORMAT "x(200)" /*ข้อความระบุ แนบท้าย*/
/* ----------------------- */
FIELD VehGroup                    AS CHARACTER FORMAT "x(2)"   /*กลุ่มรถยนต์*/
FIELD VehTypeCd                   AS CHARACTER FORMAT "x(4)"   /*รหัสประเภทรถ l*/
FIELD Manufacturer                AS CHARACTER FORMAT "x(30)"  /*ยี่ห้อรถ  l*/
FIELD Model                       AS CHARACTER FORMAT "x(50)"  /*รุ่นรถ    l*/
FIELD ModelTypeName               AS CHARACTER FORMAT "x(50)"  /*ชื่อประเภทรถ l*/
FIELD ModelYear                   AS CHARACTER FORMAT "x(04)"  /*ปีรถ l*/
FIELD VehBodyTypeDesc             AS CHARACTER FORMAT "x(05)"  /*แบบตัวถัง l*/
FIELD SeatingCapacity             AS CHARACTER FORMAT "x(03)"  /*จำนวนที่นั่ง l*/
FIELD Displacement                AS CHARACTER FORMAT "x(04)"  /*ขนาดเครื่องยนต์ l*/
FIELD GrossVehOrCombinedWeight    AS CHARACTER FORMAT "x(04)"  /*น้ำหนักบรรทุก l*/
FIELD Colour                      AS CHARACTER FORMAT "x(15)"  /*สีรถ  l*/
FIELD ChassisVINNumber            AS CHARACTER FORMAT "x(35)"  /*เลขตัวรถ/เลขตัวถัง l*/
FIELD EngineSerialNumber          AS CHARACTER FORMAT "x(35)"  /*เลขที่เครื่องยนต์ l*/
/**/
FIELD Registration                AS CHARACTER FORMAT "x(10)"  /*รหัสจังหวัดทะเบียนรถ l*/
FIELD RegisteredProvCd            AS CHARACTER FORMAT "x(02)"  /*รหัสจังหวัดทะเบียนรถ l*/
FIELD RegisteredYear              AS CHARACTER FORMAT "x(04)"  /*ปีที่จดทะเบียน l*/
/**/
FIELD SumInsureAmt                AS CHARACTER FORMAT "x(14)"
/* ----------------------- */
FIELD PolicyTypeCd                AS CHARACTER FORMAT "x(04)"  /*ประเภทความคุ้มครอง l*/
FIELD RateGroup                   AS CHARACTER FORMAT "x(4)"   /*รหัสอัตราเบี้ยประกันภัย l*/
FIELD PolicyNumber                AS CHARACTER FORMAT "x(25)"  /*เลขที่กรมธรรม์ประกันภัย l*/
FIELD PreviousPolicyNumber        AS CHARACTER FORMAT "x(25)"  /*เลขที่กรมธรรมเดิม l*/
FIELD Renewyr                     AS CHARACTER FORMAT "x(2)"
FIELD CampaignNumber              AS CHARACTER FORMAT "x(25)"
FIELD QNumPremium                 AS CHARACTER FORMAT "x(25)"
FIELD DocumentUID                 AS CHARACTER FORMAT "x(25)"  /*เลขที่เอกสารสิ่งพิมพ์กรมธรรม์ l*/
FIELD EffectiveDt                 AS CHARACTER FORMAT "x(08)"  /*วันที่เริ่มต้นระยะเวลาประกันภัย */
FIELD ExpirationDt                AS CHARACTER FORMAT "x(08)"  /*วันที่สิ้นสุดระยะเวลาประกันภัย  */
/**/
FIELD TPBIAmtPerson               AS CHARACTER FORMAT "x(14)"  /*ความรับผิดต่อบุคคลภายนอก ความเสียหายต่อชีวิต (บาท/คน) l*/
FIELD TPBIAmtAccident             AS CHARACTER FORMAT "x(14)"  /*ความรับผิดต่อบุคคลภายนอก ความเสียหายต่อชีวิต (บาท/ครั้ง) l*/
/**/
FIELD PDAmtAccident               AS CHARACTER FORMAT "x(14)"  /*ความเสียหายต่อทรัพย์สิน l*/
FIELD DeductiblePDAmtAccident     AS CHARACTER FORMAT "x(14)"  /*ความเสียหายส่วนแรกบุคคล l*/
FIELD COLLAmtAccident             AS CHARACTER FORMAT "x(14)"  /*ความเสียหายต่อรถยนต์ l*/
FIELD DeductibleCOLLAmtAccident   AS CHARACTER FORMAT "x(14)"  /*ความเสียหายส่วนแรกรถยนต์ l*/
/**/
FIELD FTAmt                       AS CHARACTER FORMAT "x(14)"  /*รถยนต์สูญหาย/ไฟไหม้ l*/
/**/
FIELD PerilsPADriverAmt               AS CHARACTER FORMAT "x(14)"  /*อุบัติเหตุส่วนบุคคลเสียชีวิตผู้ขับขี่ l*/
FIELD PerilsPANumPassengers           AS CHARACTER FORMAT "x(14)"  /*อุบัติเหตุส่วนบุคคลเสียชีวิตจน.ผู้โดยสาร l*/
FIELD PerilsPAPassengerAmt            AS CHARACTER FORMAT "x(14)"  /*อุบัติเหตุส่วนบุคคลเสียชีวิตผู้โดยสาร/คน l*/
/**/
FIELD PerilsPATemporaryDriverAmt      AS CHARACTER FORMAT "x(14)"  /*อุบัติเหตุส่วนบุคคลทุพพลภาพชั่วคราว ผู้ขับขี่ l*/
FIELD PerilsPANumTemporaryPassengers  AS CHARACTER FORMAT "x(14)"  /*อุบัติเหตุส่วนบุคคลทุพพลภาพชั่วคราว จน.ผู้โดยสาร l*/
FIELD PerilsPATemporaryPassengerAmt   AS CHARACTER FORMAT "x(14)"  /*อุบัติเหตุส่วนบุคคลทุพพลภาพชั่วคราวผู้โดยสาร/คน l*/
/**/
FIELD PerilsMedicalTreatmentAmt       AS CHARACTER FORMAT "x(14)"  /*ค่ารักษาพยาบาล l*/
FIELD PerilsBailBondInsuranceAmt      AS CHARACTER FORMAT "x(14)"  /*การประกันตัวผู้ขับขี่ l*/
/**/
FIELD DeductibleAmt               AS CHARACTER FORMAT "x(14)"  /*ความเสียหายส่วนแรก l*/
FIELD FleetAmt                    AS CHARACTER FORMAT "x(14)"  /*ส่วนลดกลุ่ม l*/
FIELD GoodDriverIndPct            AS CHARACTER FORMAT "x(05)"  /*อัตราส่วนลดประวัติดี l*/
FIELD GoodDriverIndAmt            AS CHARACTER FORMAT "x(14)"  /*ส่วนลดประวัติดี l*/
FIELD OtherDiscountAmt            AS CHARACTER FORMAT "x(14)"  /*ส่วยลดอื่นๆ l*/
FIELD SurchargeFactor             AS CHARACTER FORMAT "x(14)"  /*ประวัติเพิ่ม l*/
FIELD PremiumCoverage13           AS CHARACTER FORMAT "x(14)"  /*เบี้ยประกันภัยตามความคุ้มครอง 1, 3 l*/
FIELD PremiumCoverage2            AS CHARACTER FORMAT "x(14)"  /*เบี้ยประกันภัยตามความคุ้มครอง 2 l*/
/**/
FIELD ReceiptNumber               AS CHARACTER FORMAT "x(10)"  /*เลขที่ใบแจ้งหนี้ l*/
FIELD WrittenAmt                  AS CHARACTER FORMAT "x(14)"  /*เบี้ยสุทธิ l*/
FIELD RevenueStampAmt             AS CHARACTER FORMAT "x(14)"  /*แสตมป์ l*/
FIELD VatAmt                      AS CHARACTER FORMAT "x(14)"  /*อากร l*/
FIELD CurrentTermAmt              AS CHARACTER FORMAT "x(14)"  /*เบี้ยรวม l*/
/**/
FIELD GarageTypeCd                AS CHARACTER FORMAT "x(10)"  /*รหัสซ่อมอู่*/
FIELD GarageDesc                  AS CHARACTER FORMAT "x(20)"  /*ชื่อซ่อมอู่*/
FIELD OptionValueDesc             AS CHARACTER FORMAT "x(200)" /*อุปกรณ์พิเศษ*/
/* ----------------------- */
FIELD CMIPolicyTypeCd             AS CHARACTER FORMAT "x(04)"  /*ส่วนพรบ. ประเภทความคุ้มครอง l*/
FIELD CMIVehTypeCd                AS CHARACTER FORMAT "x(4)"   /*รหัสประเภทรถ l*/
FIELD CMIPolicyNumber             AS CHARACTER FORMAT "x(25)"  /*ส่วนพรบ. เลขที่กรมธรรม์ประกันภัย l*/
FIELD CMIApplicationNumber        AS CHARACTER FORMAT "x(30)"  /*หมายเลขอ้างอิง พ.ร.บ. */
FIELD CMIBarCodeNumber            AS CHARACTER FORMAT "x(15)"  /*ส่วนพรบ. เลขที่สติ๊กเกอร์พ.ร.บ.l*/
FIELD CMIDocumentUID              AS CHARACTER FORMAT "x(15)"  /*เลขที่เอกสารสิ่งพิมพ์กรมธรรม์ พรบ.l*/
FIELD CMIEffectiveDt              AS CHARACTER FORMAT "x(08)"  /*ส่วนพรบ. วันที่เริ่มต้นระยะเวลาประกันภัย */
FIELD CMIExpirationDt             AS CHARACTER FORMAT "x(08)"  /*ส่วนพรบ. วันที่สิ้นสุดระยะเวลาประกันภัย  */
FIELD CMIAmtPerson                AS CHARACTER FORMAT "x(14)"  /*ส่วนพรบ. ทุนประกัน พ.ร.บ. (บาท/คน) l*/
FIELD CMIAmtAccident              AS CHARACTER FORMAT "x(14)"  /*ส่วนพรบ. ทุนประกัน พ.ร.บ. (บาท/ครั้ง) l*/
FIELD CMIWrittenAmt               AS CHARACTER FORMAT "x(14)"  /*ส่วนพรบ. เบี้ยสุทธิ l*/
FIELD CMIRevenueStampAmt          AS CHARACTER FORMAT "x(14)"  /*ส่วนพรบ. แสตมป์ l*/
FIELD CMIVatAmt                   AS CHARACTER FORMAT "x(14)"  /*ส่วนพรบ. อากร l*/
FIELD CMICurrentTermAmt           AS CHARACTER FORMAT "x(14)"  /*ส่วนพรบ. เบี้ยรวม l*/
/* ----------------------- */

FIELD MsgStatusCd                 AS CHARACTER FORMAT "x(14)"  /*สถานะข้อมูล l*/
FIELD AgencyEmployee              AS CHARACTER FORMAT "x(60)"  /*ผู้แจ้งงาน */
FIELD RemarkText                  AS CHARACTER FORMAT "x(50)"  /*หมายเหตุ */
.
/* */
/* --------------------------------------------------------- */


DEFINE  TEMP-TABLE TB-RESPonse NO-UNDO
  /* */
  FIELD SystemRq                AS CHARACTER FORMAT "x(10)" /*"SPFTM"*/
  FIELD RqUID                   AS CHARACTER FORMAT "x(40)"
  FIELD keyRequestIndRq         AS CHARACTER FORMAT "x(30)"
  FIELD InsurerId               AS CHARACTER FORMAT "x(10)"
  FIELD BatchNumberRq           AS CHARACTER FORMAT "x(20)"
  FIELD SequenceNumberRq        AS CHARACTER FORMAT "x(20)"
  FIELD PaymentNumberRq         AS CHARACTER FORMAT "x(15)"
  /* */
  FIELD CompanyCode             AS CHARACTER FORMAT "x(10)"
  FIELD BranchCd                AS CHARACTER FORMAT "x(10)"  /*รหัส  BRANCH Broker/Finance */
  FIELD ContractNumber          AS CHARACTER FORMAT "x(20)"  /*เลขที่สัญญา l*/
  FIELD CMVApplicationNumber    AS CHARACTER FORMAT "x(30)"  /*หมายเลขอ้างอิง รถยนต์ ของ BROKER*/
  FIELD CMIApplicationNumber    AS CHARACTER FORMAT "x(30)"  /*หมายเลขอ้างอิง พ.ร.บ. */
  FIELD ClaimsOccurrence        AS CHARACTER FORMAT "x(20)"
  /* */
  FIELD PolicyNumber            AS CHARACTER FORMAT "x(20)"
  FIELD DocumentUID             AS CHARACTER FORMAT "x(25)"  /*เลขที่เอกสารสิ่งพิมพ์กรมธรรม์ l*/
  /* */
  FIELD CMIPolicyNumber         AS CHARACTER FORMAT "x(25)"  /*ส่วนพรบ. เลขที่กรมธรรม์ประกันภัย l*/
  FIELD CMIBarCodeNumber        AS CHARACTER FORMAT "x(15)"  /*ส่วนพรบ. เลขที่สติ๊กเกอร์พ.ร.บ.l*/
  FIELD CMIDocumentUID          AS CHARACTER FORMAT "x(15)"  /*เลขที่เอกสารสิ่งพิมพ์กรมธรรม์ พรบ.l*/
  /* */
  FIELD ReceiptNumber           AS CHARACTER FORMAT "x(10)"  /*เลขที่ใบแจ้งหนี้ l*/
  FIELD RecordGUIDRs            AS CHARACTER FORMAT "x(40)"
  FIELD TransactionResponseDt   AS CHARACTER FORMAT "x(40)"
  FIELD TransactionResponseTime AS CHARACTER FORMAT "x(40)"
  /* */
  FIELD ReferenceNumber         AS CHARACTER FORMAT "x(30)"
  FIELD ReceiveNumber           AS CHARACTER FORMAT "x(30)"
  FIELD ResultStatus            AS CHARACTER FORMAT "x(15)"
  FIELD MsgStatusCd             AS CHARACTER FORMAT "x(20)"
  /* */
  FIELD ErrorCode               AS CHARACTER FORMAT "x(15)"
  FIELD ErrorMessage            AS CHARACTER FORMAT "x(100)"
  FIELD LinkPolicy              AS CHARACTER FORMAT "x(100)"
.
/* --------------------------------------------------------- */


DEFINE  TEMP-TABLE TB-ErrorCd NO-UNDO
  FIELD keyRequestIndRq      AS CHARACTER FORMAT "x(30)"
  FIELD ErrorCode            AS CHARACTER FORMAT "x(15)"
  FIELD ErrorMessage         AS CHARACTER FORMAT "x(150)"
.
  /*
/* --------------------------------------------------------- */

create TB-GetRq.
assign
TB-GetRq.Username	     = "TESTSYSTEMS"
TB-GetRq.Password	     = "TESTSYSTEMS"
TB-GetRq.CompanyCode	 = "99999"
TB-GetRq.BranchCd        = ""
TB-GetRq.InsurerId	     = "STY"
TB-GetRq.PolicyStatus    = "N"
TB-GetRq.PreviousPolicyNumber = "D07056018129"
TB-GetRq.Renewyr         = "3"
TB-GetRq.ContractNumber	 = "TEST5704003741"
TB-GetRq.ContractDt	     = "20140208" /* STRING(YEAR(TODAY),"9999") + 
                               STRING(MONTH(TODAY),"99")  + STRING(DAY(TODAY),"99") */
TB-GetRq.ContractTime	 = "11:19:26" /*STRING(TIME,"HH:MM:SS")*/
TB-GetRq.CampaignNumber  = ""
TB-GetRq.QNumPremium     = ""

TB-GetRq.PolicyNumber    = ""          /*D07057SK9999*/

TB-GetRq.DocumentUID     = "" /*STRING(MTIME MODULO 999,"999") + STRING((MTIME - 1111111),"99999999")*/

TB-GetRq.EffectiveDt	 = "20140301"
TB-GetRq.ExpirationDt    = "20150301"
/**/
TB-GetRq.InsuredType          = "1"
TB-GetRq.InsuredBranch	      = ""
TB-GetRq.InsuredCd	          = ""
TB-GetRq.InsuredUniqueID      = "1234567890123"
TB-GetRq.InsuredUniqueIDExpDt = ""
TB-GetRq.License	          = ""
TB-GetRq.BirthDt	          = "25151231"
TB-GetRq.InsuredTitle         = "คุณ"
TB-GetRq.InsuredName	      = "ทดสอบ"
TB-GetRq.InsuredSurname       = "ผ่านwebservice"
TB-GetRq.Addr	              = "123 หมู่ที่ 4 ซอยเจริงสุข ถ.เจริญกรุง"
TB-GetRq.SubDistrict          = "แขวงยานนาวา"
TB-GetRq.District             = "เขตยานนาวา"
TB-GetRq.Province             = "กรุงเทพมหานคร"
TB-GetRq.PostalCode	          = "10100"
TB-GetRq.OccupationDesc       = "ค้าขาย"
TB-GetRq.MobilePhoneNumber    = ""
TB-GetRq.PhoneNumber	      = ""
TB-GetRq.OfficePhoneNumber    = ""
TB-GetRq.EmailAddr	          = ""
/**/
TB-GetRq.Beneficiaries	      = "คุณ ทดสอบ ผ่านwebservice"
/**/
TB-GetRq.VehTypeCd	          = "110"
TB-GetRq.VehGroup	          = "5"
/**/
TB-GetRq.Manufacturer	      = "NISSAN"
TB-GetRq.Model	              = "SYLPHY"
TB-GetRq.ModelYear	          = "2013"
TB-GetRq.VehBodyTypeDesc	  = "เก๋ง"
TB-GetRq.SeatingCapacity	  = "7"
TB-GetRq.Displacement	           = "2000"
TB-GetRq.GrossVehOrCombinedWeight  = "2.79"
TB-GetRq.Colour	                   = "ขาว"
TB-GetRq.ChassisVINNumber 	       = "Chassis-NISSAN"  /*ChassisSerialNumber*/
TB-GetRq.EngineSerialNumber	       = "Engine-NISSAN"
/**/
TB-GetRq.Registration	           = "1กข 1234"
TB-GetRq.RegisteredProvCd          = "กท"
TB-GetRq.RegisteredYear	           = "2014"
/**/
TB-GetRq.PolicyTypeCd    = "1"
TB-GetRq.RateGroup	     = "110"
TB-GetRq.TPBIAmtPerson	           = "500000"
TB-GetRq.TPBIAmtAccident	       = "10000000"
TB-GetRq.PDAmtAccident	           = "1000000"
TB-GetRq.DeductiblePDAmtAccident   = "0"
TB-GetRq.COLLAmtAccident	       = "690000"
TB-GetRq.DeductibleCOLLAmtAccident = ""
TB-GetRq.FTAmt                     = "690000"
/**/
TB-GetRq.PerilsPADriverAmt	            = "100000"
TB-GetRq.PerilsPANumPassengers          = "6"
TB-GetRq.PerilsPAPassengerAmt           = "100000"
TB-GetRq.PerilsPATemporaryDriverAmt	    = "ไม่คุ้มครอง"
TB-GetRq.PerilsPANumTemporaryPassengers	= "0"
TB-GetRq.PerilsPATemporaryPassengerAmt	= "ไม่คุ้มครอง"
TB-GetRq.PerilsMedicalTreatmentAmt	    = "100000"
TB-GetRq.PerilsBailBondInsuranceAmt	    = "200000"
/**/
TB-GetRq.WrittenAmt	        = "18000"
TB-GetRq.RevenueStampAmt    = ""
TB-GetRq.VatAmt	            = ""
TB-GetRq.CurrentTermAmt	    = "19337.04"
TB-GetRq.VehicleUse	        = "ใช้ส่วนบุคคล ไม่ใช้รับจ้างหรือให้เช่า"
/**/
TB-GetRq.CMIPolicyTypeCd	= "พรบ"
TB-GetRq.CMIVehTypeCd	    = "110"
TB-GetRq.CMIApplicationNumber  = "COMPULSORYTEST01"
TB-GetRq.CMIPolicyNumber	= ""
TB-GetRq.CMIBarCodeNumber   = ""

TB-GetRq.CMIPolicyNumber	= "" /* "D07257SK9999" */
TB-GetRq.CMIBarCodeNumber   = "0215254485821"  /* "1234567890123450"*/

TB-GetRq.CMIDocumentUID	    = "9999123"


TB-GetRq.CMIEffectiveDt	    = "20140301"
TB-GetRq.CMIExpirationDt	= "20150301"
TB-GetRq.CMIAmtPerson	    = "50000"
TB-GetRq.CMIAmtAccident	    = "5000000"
TB-GetRq.CMIWrittenAmt	    = "600"
TB-GetRq.CMIRevenueStampAmt	= "3"
TB-GetRq.CMIVatAmt	        = "42.21"
TB-GetRq.CMICurrentTermAmt	= "645.21"
TB-GetRq.MsgStatusCd	    = "NEW"
TB-GetRq.AgencyEmployee	    = "คุณทดสอบ ส่งงาน"
TB-GetRq.RemarkText	        = ""

TB-GetRq.InsuredTitle1      = "Title1 คนขับที่1"
TB-GetRq.InsuredName1       = "Name1 คนขับที่1" 
TB-GetRq.InsuredSurname1    = "Surname1 คนขับที่1" 
TB-GetRq.OccupationDesc1    = ""
TB-GetRq.BirthDt1           = "25200430"
TB-GetRq.InsuredUniqueID1   = "1234567890123"
TB-GetRq.License1           = ""

TB-GetRq.InsuredTitle2      = "Title2 คนขับที่2"  
TB-GetRq.InsuredName2       = "Name2 คนขับที่2"
TB-GetRq.InsuredSurname2    = "Surname2 คนขับที่2" 
TB-GetRq.OccupationDesc2    = ""
TB-GetRq.BirthDt2           = "25200430" 
TB-GetRq.InsuredUniqueID2   = "1234567890123"
TB-GetRq.License2           = ""

TB-GetRq.ReceiptName        = "ชื่อผู้ที่ออกใบกำกับภาษี"  
TB-GetRq.ReceiptAddr        = "ที่อยู่สำหรับ ออกที่หน้าใบกำกับภาษี"
TB-GetRq.SumInsureAmt       = TB-GetRq.FTAmt
TB-GetRq.OptionValueDesc    = "อุปกรณ์พิเศษ ทดสอบการส่งข้อมูล."

TB-GetRq.GarageTypeCd       = "ห้าง"  
 
TB-GetRq.PromptText         = "".

TB-GetRq.CMVApplicationNumber  = "VOLUNTARYTEST01". /* "MM" + SUBSTR(STRING(YEAR(TODAY) + 543,"9999"),3,2)
                                      + STRING(MONTH(TODAY),"99")
                                      + STRING(DAY(TODAY),"99")  
                                        /*
                                      + SUBSTR(STRING(TIME,"HH:MM:SS"),1,2)
                                      + SUBSTR(STRING(TIME,"HH:MM:SS"),4,2)
                                      + SUBSTR(STRING(TIME,"HH:MM:SS"),7,2)
                                        */
                                      + SUBSTR(STRING(MTIME,">>>>99999999"),10,3) .*/
/*
TB-GetRq.CMVApplicationNumber = TB-GetRq.ContractNumber.
*/
/*- --------------------------------------------------------------------------- -*/
DEFINE VARIABLE nv_octets AS CHARACTER NO-UNDO.

RUN D:\WebWSKFK\WRS\WRSDigit.p (output nv_octets).

CREATE TB-RESPonse.
  
ASSIGN
TB-RESPonse.InsurerId               = TB-GetRq.InsurerId
TB-RESPonse.CompanyCode             = TB-GetRq.CompanyCode
TB-RESPonse.ContractNumber          = TB-GetRq.ContractNumber
TB-RESPonse.CMVApplicationNumber    = TB-GetRq.CMVApplicationNumber
TB-RESPonse.CMIPolicyNumber         = TB-GetRq.CMIApplicationNumber
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
*/
