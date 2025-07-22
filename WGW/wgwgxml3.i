/*************************************************************************
 FTMGet01.I     : Include Program Use in File FTMGet01.p
                  SendCMIEr1.p  SendCMIEr2.p  SendCMIGet.P  SendCMIP2.P 
                  SendCMIP3.P   SendCMIP4.P   SendCMIP4S.P
 Copyright      : Safety Insurance Public Company Limited
                  ����ѷ ��Сѹ������� �ӡѴ (��Ҫ�)
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
FIELD CompanyCode                 AS CHARACTER FORMAT "x(10)"  /*����  Broker/Finance */
FIELD BranchCd                    AS CHARACTER FORMAT "x(10)"  /*����  BRANCH Broker/Finance */
FIELD InsurerId                   AS CHARACTER FORMAT "x(10)"  /*���ʺ���ѷ��Сѹ���  l*/
/**/
FIELD PolicyStatus                AS CHARACTER FORMAT "x(10)"  /*PolicyStatus*/
FIELD ContractNumber              AS CHARACTER FORMAT "x(20)"  /*�Ţ����ѭ�� l*/
FIELD ContractDt                  AS CHARACTER FORMAT "x(10)"  /*�ѹ�����ѭ�� l*/
FIELD ContractTime                AS CHARACTER FORMAT "x(10)"  /*���ҷ����ѭ�� l*/
FIELD CMVApplicationNumber        AS CHARACTER FORMAT "x(30)"  /*�����Ţ��ҧ�ԧ ö¹�� �ͧ BROKER*/
/**/
FIELD ApplicationNumber           AS CHARACTER FORMAT "x(20)"  /*�Ţ����ѭ�� l*/
FIELD ApplicationDt               AS CHARACTER FORMAT "x(10)"  /*�ѹ�����ѭ�� l*/
FIELD ApplicationTime             AS CHARACTER FORMAT "x(10)"  /*���ҷ����ѭ�� l*/
/* ----------------------- */
FIELD InsuredType                 AS CHARACTER FORMAT "x(04)"  /*�����������һ�Сѹ��� l*/
FIELD InsuredBranch               AS CHARACTER FORMAT "x(05)"  /*�ӴѺ����ҢҼ����һ�Сѹ��¡óչԵԺؤ�� l*/
FIELD InsuredCd                   AS CHARACTER FORMAT "x(10)"  /*���ʼ����һ�Сѹ��� l*/
FIELD InsuredUniqueID             AS CHARACTER FORMAT "x(20)"  /*�����Ţ�׹�ѹ�ؤ�ż����һ�Сѹ��� l*/
FIELD InsuredUniqueIDExpDt        AS CHARACTER FORMAT "x(08)"  /*�ѹ������آͧ�����Ţ�׹�ѹ�ؤ�ż����һ�Сѹ���l*/
FIELD License                     AS CHARACTER FORMAT "x(20)"  /*�Ţ���㺢Ѻ��� l*/
FIELD BirthDt                     AS CHARACTER FORMAT "x(08)"  /*�ѹ�Դ */
FIELD InsuredTitle                AS CHARACTER FORMAT "x(30)"  /*�ӹ�˹�Ҫ��ͼ����һ�Сѹ��� l*/
FIELD InsuredName                 AS CHARACTER FORMAT "x(60)"  /*���ͼ����һ�Сѹ��� l*/
FIELD InsuredSurname              AS CHARACTER FORMAT "x(60)"  /*����ʡ�ż����һ�Сѹ��� l*/
FIELD Addr                        AS CHARACTER FORMAT "x(150)" /*�����������һ�Сѹ���     l*/
FIELD SubDistrict                 AS CHARACTER FORMAT "x(45)"  /*�Ӻ�/�ǧ l*/
FIELD District                    AS CHARACTER FORMAT "x(45)"  /*��������/�����/ࢵ l*/
FIELD Province                    AS CHARACTER FORMAT "x(30)"  /*�ѧ��Ѵ l*/
FIELD PostalCode                  AS CHARACTER FORMAT "x(05)"  /*������ɳ��� l*/
FIELD OccupationDesc              AS CHARACTER FORMAT "x(50)"  /*�Ҫվ l*/
/**/
FIELD MobilePhoneNumber           AS CHARACTER FORMAT "x(25)"  /*������Ͷ���١��� l*/
FIELD PhoneNumber                 AS CHARACTER FORMAT "x(25)"  /*�������Ѿ���鹰ҹ�١��� l*/
FIELD OfficePhoneNumber           AS CHARACTER FORMAT "x(25)"  /*�������Ѿ����ӧҹ l*/
FIELD EmailAddr                   AS CHARACTER FORMAT "x(50)"  /*e-mail l*/
/**/
FIELD ReceiptName                 AS CHARACTER FORMAT "x(120)" /*���ͷ���кط��㺡ӡѺ����*/
FIELD ReceiptAddr                 AS CHARACTER FORMAT "x(200)" /*������� ����к�㺡ӡѺ����*/
/* ----------------------- */
FIELD DriverNameCd                AS CHARACTER FORMAT "x(04)"  /*�кت��ͼ��Ѻ��� ��������кت��ͼ��Ѻ���  l*/
FIELD InsuredTitle1               AS CHARACTER FORMAT "x(20)"  /*�ӹ�˹�Ҫ��ͼ����һ�Сѹ��� l*/
FIELD InsuredName1                AS CHARACTER FORMAT "x(60)"  /*���ͼ����һ�Сѹ��� l*/
FIELD InsuredSurname1             AS CHARACTER FORMAT "x(50)"  /*����ʡ�ż����һ�Сѹ��� l*/
FIELD OccupationDesc1             AS CHARACTER FORMAT "x(50)"  /*�Ҫվ l*/
FIELD BirthDt1                    AS CHARACTER FORMAT "x(08)"  /*�ѹ�Դ */
FIELD InsuredUniqueID1            AS CHARACTER FORMAT "x(20)"  /*�����Ţ�׹�ѹ�ؤ�ż����һ�Сѹ��� l*/
FIELD License1                    AS CHARACTER FORMAT "x(20)"  /*�Ţ���㺢Ѻ��� l*/
/**/
FIELD InsuredTitle2               AS CHARACTER FORMAT "x(20)"  /*�ӹ�˹�Ҫ��ͼ����һ�Сѹ��� l*/
FIELD InsuredName2                AS CHARACTER FORMAT "x(60)"  /*���ͼ����һ�Сѹ��� l*/
FIELD InsuredSurname2             AS CHARACTER FORMAT "x(50)"  /*����ʡ�ż����һ�Сѹ��� l*/
FIELD OccupationDesc2             AS CHARACTER FORMAT "x(50)"  /*�Ҫվ l*/
FIELD BirthDt2                    AS CHARACTER FORMAT "x(08)"  /*�ѹ�Դ */
FIELD InsuredUniqueID2            AS CHARACTER FORMAT "x(20)"  /*�����Ţ�׹�ѹ�ؤ�ż����һ�Сѹ��� l*/
FIELD License2                    AS CHARACTER FORMAT "x(20)"  /*�Ţ���㺢Ѻ��� l*/
/* ----------------------- */
FIELD Beneficiaries               AS CHARACTER FORMAT "x(80)"  /*����Ѻ�Ż���ª�� l*/
FIELD PolicyAttachment            AS CHARACTER FORMAT "x(100)" /*��¡���͡���Ṻ���� l*/
FIELD VehicleUse                  AS CHARACTER FORMAT "x(100)" /*�����ѡɳС����ҹ l*/
FIELD PromptText                  AS CHARACTER FORMAT "x(200)" /*��ͤ����к� Ṻ����*/
/* ----------------------- */
FIELD VehGroup                    AS CHARACTER FORMAT "x(2)"   /*�����ö¹��*/
FIELD VehTypeCd                   AS CHARACTER FORMAT "x(4)"   /*���ʻ�����ö l*/
FIELD Manufacturer                AS CHARACTER FORMAT "x(30)"  /*������ö  l*/
FIELD Model                       AS CHARACTER FORMAT "x(50)"  /*���ö    l*/
FIELD ModelTypeName               AS CHARACTER FORMAT "x(50)"  /*���ͻ�����ö l*/
FIELD ModelYear                   AS CHARACTER FORMAT "x(04)"  /*��ö l*/
FIELD VehBodyTypeDesc             AS CHARACTER FORMAT "x(05)"  /*Ẻ��Ƕѧ l*/
FIELD SeatingCapacity             AS CHARACTER FORMAT "x(03)"  /*�ӹǹ����� l*/
FIELD Displacement                AS CHARACTER FORMAT "x(04)"  /*��Ҵ����ͧ¹�� l*/
FIELD GrossVehOrCombinedWeight    AS CHARACTER FORMAT "x(04)"  /*���˹ѡ��÷ء l*/
FIELD Colour                      AS CHARACTER FORMAT "x(15)"  /*��ö  l*/
FIELD ChassisVINNumber            AS CHARACTER FORMAT "x(35)"  /*�Ţ���ö/�Ţ��Ƕѧ l*/
FIELD EngineSerialNumber          AS CHARACTER FORMAT "x(35)"  /*�Ţ�������ͧ¹�� l*/
/**/
FIELD Registration                AS CHARACTER FORMAT "x(10)"  /*���ʨѧ��Ѵ����¹ö l*/
FIELD RegisteredProvCd            AS CHARACTER FORMAT "x(02)"  /*���ʨѧ��Ѵ����¹ö l*/
FIELD RegisteredYear              AS CHARACTER FORMAT "x(04)"  /*�շ�訴����¹ l*/
/**/
FIELD SumInsureAmt                AS CHARACTER FORMAT "x(14)"
/* ----------------------- */
FIELD PolicyTypeCd                AS CHARACTER FORMAT "x(04)"  /*����������������ͧ l*/
FIELD RateGroup                   AS CHARACTER FORMAT "x(4)"   /*�����ѵ�����»�Сѹ��� l*/
FIELD PolicyNumber                AS CHARACTER FORMAT "x(25)"  /*�Ţ�����������Сѹ��� l*/
FIELD PreviousPolicyNumber        AS CHARACTER FORMAT "x(25)"  /*�Ţ������������ l*/
FIELD Renewyr                     AS CHARACTER FORMAT "x(2)"
FIELD CampaignNumber              AS CHARACTER FORMAT "x(25)"
FIELD QNumPremium                 AS CHARACTER FORMAT "x(25)"
FIELD DocumentUID                 AS CHARACTER FORMAT "x(25)"  /*�Ţ����͡�����觾����������� l*/
FIELD EffectiveDt                 AS CHARACTER FORMAT "x(08)"  /*�ѹ�����������������һ�Сѹ��� */
FIELD ExpirationDt                AS CHARACTER FORMAT "x(08)"  /*�ѹ�������ش�������һ�Сѹ���  */
/**/
FIELD TPBIAmtPerson               AS CHARACTER FORMAT "x(14)"  /*�����Ѻ�Դ��ͺؤ����¹͡ ����������µ�ͪ��Ե (�ҷ/��) l*/
FIELD TPBIAmtAccident             AS CHARACTER FORMAT "x(14)"  /*�����Ѻ�Դ��ͺؤ����¹͡ ����������µ�ͪ��Ե (�ҷ/����) l*/
/**/
FIELD PDAmtAccident               AS CHARACTER FORMAT "x(14)"  /*����������µ�ͷ�Ѿ���Թ l*/
FIELD DeductiblePDAmtAccident     AS CHARACTER FORMAT "x(14)"  /*�������������ǹ�á�ؤ�� l*/
FIELD COLLAmtAccident             AS CHARACTER FORMAT "x(14)"  /*����������µ��ö¹�� l*/
FIELD DeductibleCOLLAmtAccident   AS CHARACTER FORMAT "x(14)"  /*�������������ǹ�áö¹�� l*/
/**/
FIELD FTAmt                       AS CHARACTER FORMAT "x(14)"  /*ö¹���٭���/����� l*/
/**/
FIELD PerilsPADriverAmt               AS CHARACTER FORMAT "x(14)"  /*�غѵ��˵���ǹ�ؤ�����ª��Ե���Ѻ��� l*/
FIELD PerilsPANumPassengers           AS CHARACTER FORMAT "x(14)"  /*�غѵ��˵���ǹ�ؤ�����ª��Ե��.�������� l*/
FIELD PerilsPAPassengerAmt            AS CHARACTER FORMAT "x(14)"  /*�غѵ��˵���ǹ�ؤ�����ª��Ե��������/�� l*/
/**/
FIELD PerilsPATemporaryDriverAmt      AS CHARACTER FORMAT "x(14)"  /*�غѵ��˵���ǹ�ؤ�ŷؾ���Ҿ���Ǥ��� ���Ѻ��� l*/
FIELD PerilsPANumTemporaryPassengers  AS CHARACTER FORMAT "x(14)"  /*�غѵ��˵���ǹ�ؤ�ŷؾ���Ҿ���Ǥ��� ��.�������� l*/
FIELD PerilsPATemporaryPassengerAmt   AS CHARACTER FORMAT "x(14)"  /*�غѵ��˵���ǹ�ؤ�ŷؾ���Ҿ���Ǥ��Ǽ�������/�� l*/
/**/
FIELD PerilsMedicalTreatmentAmt       AS CHARACTER FORMAT "x(14)"  /*����ѡ�Ҿ�Һ�� l*/
FIELD PerilsBailBondInsuranceAmt      AS CHARACTER FORMAT "x(14)"  /*��û�Сѹ��Ǽ��Ѻ��� l*/
/**/
FIELD DeductibleAmt               AS CHARACTER FORMAT "x(14)"  /*�������������ǹ�á l*/
FIELD FleetAmt                    AS CHARACTER FORMAT "x(14)"  /*��ǹŴ����� l*/
FIELD GoodDriverIndPct            AS CHARACTER FORMAT "x(05)"  /*�ѵ����ǹŴ����ѵԴ� l*/
FIELD GoodDriverIndAmt            AS CHARACTER FORMAT "x(14)"  /*��ǹŴ����ѵԴ� l*/
FIELD OtherDiscountAmt            AS CHARACTER FORMAT "x(14)"  /*����Ŵ���� l*/
FIELD SurchargeFactor             AS CHARACTER FORMAT "x(14)"  /*����ѵ����� l*/
FIELD PremiumCoverage13           AS CHARACTER FORMAT "x(14)"  /*���»�Сѹ��µ������������ͧ 1, 3 l*/
FIELD PremiumCoverage2            AS CHARACTER FORMAT "x(14)"  /*���»�Сѹ��µ������������ͧ 2 l*/
/**/
FIELD ReceiptNumber               AS CHARACTER FORMAT "x(10)"  /*�Ţ������˹�� l*/
FIELD WrittenAmt                  AS CHARACTER FORMAT "x(14)"  /*�����ط�� l*/
FIELD RevenueStampAmt             AS CHARACTER FORMAT "x(14)"  /*�ʵ��� l*/
FIELD VatAmt                      AS CHARACTER FORMAT "x(14)"  /*�ҡ� l*/
FIELD CurrentTermAmt              AS CHARACTER FORMAT "x(14)"  /*������� l*/
/**/
FIELD GarageTypeCd                AS CHARACTER FORMAT "x(10)"  /*���ʫ������*/
FIELD GarageDesc                  AS CHARACTER FORMAT "x(20)"  /*���ͫ������*/
FIELD OptionValueDesc             AS CHARACTER FORMAT "x(200)" /*�ػ�ó�����*/
/* ----------------------- */
FIELD CMIPolicyTypeCd             AS CHARACTER FORMAT "x(04)"  /*��ǹ�ú. ����������������ͧ l*/
FIELD CMIVehTypeCd                AS CHARACTER FORMAT "x(4)"   /*���ʻ�����ö l*/
FIELD CMIPolicyNumber             AS CHARACTER FORMAT "x(25)"  /*��ǹ�ú. �Ţ�����������Сѹ��� l*/
FIELD CMIApplicationNumber        AS CHARACTER FORMAT "x(30)"  /*�����Ţ��ҧ�ԧ �.�.�. */
FIELD CMIBarCodeNumber            AS CHARACTER FORMAT "x(15)"  /*��ǹ�ú. �Ţ���ʵ������.�.�.l*/
FIELD CMIDocumentUID              AS CHARACTER FORMAT "x(15)"  /*�Ţ����͡�����觾����������� �ú.l*/
FIELD CMIEffectiveDt              AS CHARACTER FORMAT "x(08)"  /*��ǹ�ú. �ѹ�����������������һ�Сѹ��� */
FIELD CMIExpirationDt             AS CHARACTER FORMAT "x(08)"  /*��ǹ�ú. �ѹ�������ش�������һ�Сѹ���  */
FIELD CMIAmtPerson                AS CHARACTER FORMAT "x(14)"  /*��ǹ�ú. �ع��Сѹ �.�.�. (�ҷ/��) l*/
FIELD CMIAmtAccident              AS CHARACTER FORMAT "x(14)"  /*��ǹ�ú. �ع��Сѹ �.�.�. (�ҷ/����) l*/
FIELD CMIWrittenAmt               AS CHARACTER FORMAT "x(14)"  /*��ǹ�ú. �����ط�� l*/
FIELD CMIRevenueStampAmt          AS CHARACTER FORMAT "x(14)"  /*��ǹ�ú. �ʵ��� l*/
FIELD CMIVatAmt                   AS CHARACTER FORMAT "x(14)"  /*��ǹ�ú. �ҡ� l*/
FIELD CMICurrentTermAmt           AS CHARACTER FORMAT "x(14)"  /*��ǹ�ú. ������� l*/
/* ----------------------- */

FIELD MsgStatusCd                 AS CHARACTER FORMAT "x(14)"  /*ʶҹТ����� l*/
FIELD AgencyEmployee              AS CHARACTER FORMAT "x(60)"  /*����駧ҹ */
FIELD RemarkText                  AS CHARACTER FORMAT "x(50)"  /*�����˵� */
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
  FIELD BranchCd                AS CHARACTER FORMAT "x(10)"  /*����  BRANCH Broker/Finance */
  FIELD ContractNumber          AS CHARACTER FORMAT "x(20)"  /*�Ţ����ѭ�� l*/
  FIELD CMVApplicationNumber    AS CHARACTER FORMAT "x(30)"  /*�����Ţ��ҧ�ԧ ö¹�� �ͧ BROKER*/
  FIELD CMIApplicationNumber    AS CHARACTER FORMAT "x(30)"  /*�����Ţ��ҧ�ԧ �.�.�. */
  FIELD ClaimsOccurrence        AS CHARACTER FORMAT "x(20)"
  /* */
  FIELD PolicyNumber            AS CHARACTER FORMAT "x(20)"
  FIELD DocumentUID             AS CHARACTER FORMAT "x(25)"  /*�Ţ����͡�����觾����������� l*/
  /* */
  FIELD CMIPolicyNumber         AS CHARACTER FORMAT "x(25)"  /*��ǹ�ú. �Ţ�����������Сѹ��� l*/
  FIELD CMIBarCodeNumber        AS CHARACTER FORMAT "x(15)"  /*��ǹ�ú. �Ţ���ʵ������.�.�.l*/
  FIELD CMIDocumentUID          AS CHARACTER FORMAT "x(15)"  /*�Ţ����͡�����觾����������� �ú.l*/
  /* */
  FIELD ReceiptNumber           AS CHARACTER FORMAT "x(10)"  /*�Ţ������˹�� l*/
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
TB-GetRq.InsuredTitle         = "�س"
TB-GetRq.InsuredName	      = "���ͺ"
TB-GetRq.InsuredSurname       = "��ҹwebservice"
TB-GetRq.Addr	              = "123 ������ 4 �����ԧ�آ �.��ԭ��ا"
TB-GetRq.SubDistrict          = "�ǧ�ҹ����"
TB-GetRq.District             = "ࢵ�ҹ����"
TB-GetRq.Province             = "��ا෾��ҹ��"
TB-GetRq.PostalCode	          = "10100"
TB-GetRq.OccupationDesc       = "��Ң��"
TB-GetRq.MobilePhoneNumber    = ""
TB-GetRq.PhoneNumber	      = ""
TB-GetRq.OfficePhoneNumber    = ""
TB-GetRq.EmailAddr	          = ""
/**/
TB-GetRq.Beneficiaries	      = "�س ���ͺ ��ҹwebservice"
/**/
TB-GetRq.VehTypeCd	          = "110"
TB-GetRq.VehGroup	          = "5"
/**/
TB-GetRq.Manufacturer	      = "NISSAN"
TB-GetRq.Model	              = "SYLPHY"
TB-GetRq.ModelYear	          = "2013"
TB-GetRq.VehBodyTypeDesc	  = "��"
TB-GetRq.SeatingCapacity	  = "7"
TB-GetRq.Displacement	           = "2000"
TB-GetRq.GrossVehOrCombinedWeight  = "2.79"
TB-GetRq.Colour	                   = "���"
TB-GetRq.ChassisVINNumber 	       = "Chassis-NISSAN"  /*ChassisSerialNumber*/
TB-GetRq.EngineSerialNumber	       = "Engine-NISSAN"
/**/
TB-GetRq.Registration	           = "1�� 1234"
TB-GetRq.RegisteredProvCd          = "��"
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
TB-GetRq.PerilsPATemporaryDriverAmt	    = "��������ͧ"
TB-GetRq.PerilsPANumTemporaryPassengers	= "0"
TB-GetRq.PerilsPATemporaryPassengerAmt	= "��������ͧ"
TB-GetRq.PerilsMedicalTreatmentAmt	    = "100000"
TB-GetRq.PerilsBailBondInsuranceAmt	    = "200000"
/**/
TB-GetRq.WrittenAmt	        = "18000"
TB-GetRq.RevenueStampAmt    = ""
TB-GetRq.VatAmt	            = ""
TB-GetRq.CurrentTermAmt	    = "19337.04"
TB-GetRq.VehicleUse	        = "����ǹ�ؤ�� ������Ѻ��ҧ����������"
/**/
TB-GetRq.CMIPolicyTypeCd	= "�ú"
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
TB-GetRq.AgencyEmployee	    = "�س���ͺ �觧ҹ"
TB-GetRq.RemarkText	        = ""

TB-GetRq.InsuredTitle1      = "Title1 ���Ѻ���1"
TB-GetRq.InsuredName1       = "Name1 ���Ѻ���1" 
TB-GetRq.InsuredSurname1    = "Surname1 ���Ѻ���1" 
TB-GetRq.OccupationDesc1    = ""
TB-GetRq.BirthDt1           = "25200430"
TB-GetRq.InsuredUniqueID1   = "1234567890123"
TB-GetRq.License1           = ""

TB-GetRq.InsuredTitle2      = "Title2 ���Ѻ���2"  
TB-GetRq.InsuredName2       = "Name2 ���Ѻ���2"
TB-GetRq.InsuredSurname2    = "Surname2 ���Ѻ���2" 
TB-GetRq.OccupationDesc2    = ""
TB-GetRq.BirthDt2           = "25200430" 
TB-GetRq.InsuredUniqueID2   = "1234567890123"
TB-GetRq.License2           = ""

TB-GetRq.ReceiptName        = "���ͼ�����͡㺡ӡѺ����"  
TB-GetRq.ReceiptAddr        = "�����������Ѻ �͡���˹��㺡ӡѺ����"
TB-GetRq.SumInsureAmt       = TB-GetRq.FTAmt
TB-GetRq.OptionValueDesc    = "�ػ�ó����� ���ͺ����觢�����."

TB-GetRq.GarageTypeCd       = "��ҧ"  
 
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
