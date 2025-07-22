/*programid   : wgwtltgb.i.i                                                             */ 
/*programname : Load Text & Generate text file Tesco lotus                                  */ 
/*Copyright   : Safety Insurance Public Company Limited 			                   */ 
/*			    บริษัท ประกันคุ้มภัย จำกัด (มหาชน)				                       */ 
/*create by   : Kridtiya i. A60-0495 date. 11/12/2017                                  
                ปรับโปรแกรมให้สามารถนำเข้า Load Text & Generate data                    */ 
/*Modify by   : Kridtiya i. A63-0432 Date. 23/09/2020 เพิ่ม เลขกรมธรรม์เดิม*/                
/***************************************************************************************/
DEF VARIABLE nv_applicationdat            AS CHAR FORMAT "x(10)".  /*  1	application date	*/
DEF VARIABLE nv_applicationsigndat        AS CHAR FORMAT "x(10)".  /*  2	application sign date	*/
DEF VARIABLE nv_applicationno             AS CHAR FORMAT "x(10)".  /*  3	application no	*/
DEF VARIABLE nv_dcchanel                  AS CHAR FORMAT "x(10)".  /*  4	dc chanel	*/
DEF VARIABLE nv_branchname                AS CHAR FORMAT "x(10)".  /*  5	branch name	*/
DEF VARIABLE nv_saleagent                 AS CHAR FORMAT "x(10)".  /*  6	sale agent	*/
DEF VARIABLE nv_applicationstatus         AS CHAR FORMAT "x(10)".  /*  7	application status	*/
DEF VARIABLE nv_temp_receipt_no           AS CHAR FORMAT "x(10)".  /*  8	temp_receipt_no	*/
DEF VARIABLE nv_producttype               AS CHAR FORMAT "x(10)".  /*  9	product type	*/
DEF VARIABLE nv_productsubtype            AS CHAR FORMAT "x(10)".  /* 10	product sub type	*/
DEF VARIABLE nv_plateno                   AS CHAR FORMAT "x(10)".  /*  11	plate no.	*/
DEF VARIABLE nv_oicprovince               AS CHAR FORMAT "x(10)".  /*  12	oic province	*/
DEF VARIABLE nv_thaiprovince              AS CHAR FORMAT "x(10)".  /*  13	thai province	*/
DEF VARIABLE nv_year                      AS CHAR FORMAT "x(10)".  /* 14	year	*/
DEF VARIABLE nv_makedescription1          AS CHAR FORMAT "x(10)".  /*  15	make description1	*/
DEF VARIABLE nv_modeldescription          AS CHAR FORMAT "x(10)".  /*  16	model description	*/
DEF VARIABLE nv_chassis                   AS CHAR FORMAT "x(10)".  /*  17	chassis	*/
DEF VARIABLE nv_engine                    AS CHAR FORMAT "x(10)".  /*  18	engine	*/
DEF VARIABLE nv_cc                        AS CHAR FORMAT "x(10)".  /*  19	cc	*/
DEF VARIABLE nv_seat                      AS CHAR FORMAT "x(10)".  /*  20	seat	*/
DEF VARIABLE nv_tonnage                   AS CHAR FORMAT "x(10)".  /*  21	tonnage	*/
DEF VARIABLE nv_usecode                   AS CHAR FORMAT "x(10)".  /*  22	use code	*/
DEF VARIABLE nv_vehiclegroup              AS CHAR FORMAT "x(10)".  /*  23	vehicle group	*/
DEF VARIABLE nv_queueno                   AS CHAR FORMAT "x(30)".  /*  23	vehicle group	*/
DEF VARIABLE nv_policyid                  AS CHAR FORMAT "x(10)".  /*  24	policy id	*/
DEF VARIABLE nv_barcodeno                 AS CHAR FORMAT "x(10)".  /*  25	barcode no	*/
DEF VARIABLE nv_beneficiary               AS CHAR FORMAT "x(10)".  /*  26	beneficiary	*/
DEF VARIABLE nv_packagecode               AS CHAR FORMAT "x(10)".  /*  27	package code	*/
DEF VARIABLE nv_packagename               AS CHAR FORMAT "x(10)".  /*  28	package name	*/
DEF VARIABLE nv_subpackagecode            AS CHAR FORMAT "x(10)".  /* 29	sub package code	*/
DEF VARIABLE nv_subpackagename            AS CHAR FORMAT "x(10)".  /* 30	sub package name	*/
DEF VARIABLE nv_suminsured                AS CHAR FORMAT "x(10)".  /*  31	sum insured	*/
DEF VARIABLE nv_effectivedate             AS CHAR FORMAT "x(10)".  /*  32	effective date	*/
DEF VARIABLE nv_expireddate               AS CHAR FORMAT "x(10)".  /*  33	expired date	*/
DEF VARIABLE nv_garagetype                AS CHAR FORMAT "x(10)".  /* 34	garage type	*/
DEF VARIABLE nv_garagetypedescription     AS CHAR FORMAT "x(10)".  /*  35	garage type description	*/
DEF VARIABLE nv_usetype                   AS CHAR FORMAT "x(10)".  /* 36	use type	*/
DEF VARIABLE nv_drivertype                AS CHAR FORMAT "x(10)".  /* 37	driver type	*/
DEF VARIABLE nv_namefirst                 AS CHAR FORMAT "x(10)".  /* 38	name first	*/
DEF VARIABLE nv_birthdatefirst            AS CHAR FORMAT "x(10)".  /*  39	birth date first	*/
DEF VARIABLE nv_occupationdescfirst       AS CHAR FORMAT "x(10)".  /*  40	occupation desc first	*/
DEF VARIABLE nv_drivernofirst             AS CHAR FORMAT "x(10)".  /*  41	driver no first	*/
DEF VARIABLE nv_identificationnofirst     AS CHAR FORMAT "x(10)".  /*  42	identification no first	*/
DEF VARIABLE nv_agefirst                  AS CHAR FORMAT "x(10)".  /*  43	age first	*/
DEF VARIABLE nv_namesecond                AS CHAR FORMAT "x(10)".  /*  44	name second	*/
DEF VARIABLE nv_birthdatesecond           AS CHAR FORMAT "x(10)".  /* 45	birth date second	*/
DEF VARIABLE nv_occupationdescsecond      AS CHAR FORMAT "x(10)".  /*  46	occupation desc second	*/
DEF VARIABLE nv_drivernosecond            AS CHAR FORMAT "x(10)".  /*  47	driver no second	*/
DEF VARIABLE nv_identificationnosecond    AS CHAR FORMAT "x(10)".  /*  48	identification no second	*/
DEF VARIABLE nv_agesecond                 AS CHAR FORMAT "x(10)".  /* 49	age second	*/
DEF VARIABLE nv_policycmi                 AS CHAR FORMAT "x(20)".  
DEF VARIABLE nv_policymanualno            AS CHAR FORMAT "x(10)".  /*  50	policy manual no	*/
DEF VARIABLE nv_applicationmanualno       AS CHAR FORMAT "x(10)".  /*  51	application manual no	*/
DEF VARIABLE nv_receivemanualno           AS CHAR FORMAT "x(10)".  /*  52	receive manual no	*/
DEF VARIABLE nv_promotionticketno         AS CHAR FORMAT "x(10)".  /*  53	promotion ticket no	*/
DEF VARIABLE nv_modeofpayment             AS CHAR FORMAT "x(10)".  /*  54	mode of payment	*/
DEF VARIABLE nv_netpremium                AS CHAR FORMAT "x(10)".  /* 55	net premium	*/
DEF VARIABLE nv_grosspremium              AS CHAR FORMAT "x(10)".  /* 56	gross premium	*/
DEF VARIABLE nv_vat                       AS CHAR FORMAT "x(10)".  /*  57	vat	*/
DEF VARIABLE nv_stamp                     AS CHAR FORMAT "x(10)".  /*  58	stamp	*/
DEF VARIABLE nv_discount_amount           AS CHAR FORMAT "x(10)".  /*  59	discount_amount	*/
DEF VARIABLE nv_paymentchannel            AS CHAR FORMAT "x(10)".  /* 60	payment channel	*/
DEF VARIABLE nv_creditcardno              AS CHAR FORMAT "x(10)".  /* 61	credit card no	*/
DEF VARIABLE nv_slipnoappovalcode         AS CHAR FORMAT "x(10)".  /* 62	slip no/appoval code	*/
DEF VARIABLE nv_purchasetype              AS CHAR FORMAT "x(10)".  /* 63	purchase type	*/
DEF VARIABLE nv_purchaseheadOfficebranch  AS CHAR FORMAT "x(10)".  /* 64	purchase headOffice branch	*/
DEF VARIABLE nv_purchasebranchcode        AS CHAR FORMAT "x(10)".  /* 65	purchase branch code	*/
DEF VARIABLE nv_purchasetitlename         AS CHAR FORMAT "x(10)".  /* 66	purchase title name	*/
DEF VARIABLE nv_purchasename              AS CHAR FORMAT "x(10)".  /*	67	purchase name	*/
DEF VARIABLE nv_purchasesurname           AS CHAR FORMAT "x(10)".  /*	68	purchase surname	*/
DEF VARIABLE nv_purchasehomephoneno       AS CHAR FORMAT "x(10)".  /*	69	purchase home phone no	*/
DEF VARIABLE nv_purchaseext               AS CHAR FORMAT "x(10)".  /*	70	purchase ext	*/
DEF VARIABLE nv_purchasemobile1           AS CHAR FORMAT "x(10)".  /*	71	purchase mobile1	*/
DEF VARIABLE nv_purchasemobile2           AS CHAR FORMAT "x(10)".  /*	72	purchase mobile2	*/
DEF VARIABLE nv_insuredtype               AS CHAR FORMAT "x(10)".  /*	73	insured type	*/
DEF VARIABLE nv_insuredheadOfficebranch   AS CHAR FORMAT "x(10)".  /* 74	insured headOffice branch	*/
DEF VARIABLE nv_insuredbranchcode         AS CHAR FORMAT "x(10)".  /* 75	insured branch code	*/
DEF VARIABLE nv_relation                  AS CHAR FORMAT "x(10)".  /*	76	relation	*/
DEF VARIABLE nv_sex                       AS CHAR FORMAT "x(10)".  /*	77	sex	*/
DEF VARIABLE nv_insuredtitlename          AS CHAR FORMAT "x(10)".  /* 78	insured title name	*/
DEF VARIABLE nv_insuredname               AS CHAR FORMAT "x(10)".  /*	79	insured name	*/
DEF VARIABLE nv_insuredlastname           AS CHAR FORMAT "x(10)".  /*	80	insured lastname	*/
DEF VARIABLE nv_insureddateofbirth        AS CHAR FORMAT "x(10)".  /*	81	insured date of birth	*/
DEF VARIABLE nv_insurednationality        AS CHAR FORMAT "x(10)".  /*	82	insured nationality	*/
DEF VARIABLE nv_insuredorigin             AS CHAR FORMAT "x(10)".  /*	83	insured origin	*/
DEF VARIABLE nv_insuredmoobarn            AS CHAR FORMAT "x(10)".  /*	84	insured moobarn	*/
DEF VARIABLE nv_insuredroomnumber         AS CHAR FORMAT "x(10)".  /*	85	insured room number	*/
DEF VARIABLE nv_insuredhomenumber         AS CHAR FORMAT "x(10)".  /*	86	insured home number	*/
DEF VARIABLE nv_insuredmoo                AS CHAR FORMAT "x(10)".  /*	87	insured moo	*/
DEF VARIABLE nv_insuredsoi                AS CHAR FORMAT "x(10)".  /*	88	insured soi	*/
DEF VARIABLE nv_insuredroad               AS CHAR FORMAT "x(10)".  /*	89	insured road	*/
DEF VARIABLE nv_insuredtumbolid           AS CHAR FORMAT "x(10)".  /*	90	insured tumbol id	*/
DEF VARIABLE nv_insuredtumbol             AS CHAR FORMAT "x(10)".  /*	91	insured tumbol	*/
DEF VARIABLE nv_insuredamphurid           AS CHAR FORMAT "x(10)".  /*	92	insured amphur id	*/
DEF VARIABLE nv_insuredamphur             AS CHAR FORMAT "x(10)".  /*	93	insured amphur	*/
DEF VARIABLE nv_insuredprovinceid         AS CHAR FORMAT "x(10)".  /*	94	insured province id	*/
DEF VARIABLE nv_insuredprovince           AS CHAR FORMAT "x(10)".  /*	95	insured province	*/
DEF VARIABLE nv_insuredpostcode           AS CHAR FORMAT "x(10)".  /*	96	insured post code	*/
DEF VARIABLE nv_insuredhomephoneno        AS CHAR FORMAT "x(10)".  /*	97	insured home phone no	*/
DEF VARIABLE nv_insuredext                AS CHAR FORMAT "x(10)".  /*	98	insured ext	*/
DEF VARIABLE nv_insuredmobile             AS CHAR FORMAT "x(10)".  /*	99	insured mobile	*/
DEF VARIABLE nv_insuredmobile2            AS CHAR FORMAT "x(10)".  /*	100	insured mobile2	*/
DEF VARIABLE nv_insuredfax                AS CHAR FORMAT "x(10)".  /*	101	insured fax	*/
DEF VARIABLE nv_insuredcardtype           AS CHAR FORMAT "x(10)".  /*	102	insured card type	*/
DEF VARIABLE nv_insuredidcardno           AS CHAR FORMAT "x(10)".  /*	103	insured id card no	*/
DEF VARIABLE nv_namesurnamebilling        AS CHAR FORMAT "x(10)".  /*	104	name surname billing	*/
DEF VARIABLE nv_billingmoobarn            AS CHAR FORMAT "x(10)".  /*	105	billing moobarn	*/
DEF VARIABLE nv_billingroomnumber         AS CHAR FORMAT "x(10)".  /*	106	billing room number	*/
DEF VARIABLE nv_billinghomenumber         AS CHAR FORMAT "x(10)".  /*	107	billing home number	*/
DEF VARIABLE nv_billingmoo                AS CHAR FORMAT "x(10)".  /*	108	billing moo	*/
DEF VARIABLE nv_billingsoi                AS CHAR FORMAT "x(10)".  /*	109	billing soi	*/
DEF VARIABLE nv_billingroad               AS CHAR FORMAT "x(10)".  /*	110	billing road	*/
DEF VARIABLE nv_billingtumbol             AS CHAR FORMAT "x(10)".  /*	111	billing tumbol	*/
DEF VARIABLE nv_billingamphur             AS CHAR FORMAT "x(10)".  /*	112	billing amphur	*/
DEF VARIABLE nv_billingprovince           AS CHAR FORMAT "x(10)".  /*	113	billing province	*/
DEF VARIABLE nv_billingpostcode           AS CHAR FORMAT "x(10)".   /*	114	billing post code	*/
DEF VARIABLE nv_remark                    AS CHAR FORMAT "x(100)".  /*	115	remark              */
DEF VARIABLE nv_ws_type                   AS CHAR FORMAT "x(10)".  /*	115	ws_type	*/
DEF VARIABLE nv_ws_status                 AS CHAR FORMAT "x(10)".  /*	116	ws_status	*/
DEF VARIABLE nv_ws_error_msg              AS CHAR FORMAT "x(10)".  /*	117	ws_error_msg	*/
DEF VARIABLE nv_ws_req_date               AS CHAR FORMAT "x(10)".  /*	118	ws_req_date	*/
DEF VARIABLE nv_ws_req_time               AS CHAR FORMAT "x(10)".  /*	119	ws_req_time	*/
DEF VARIABLE nv_ws_respone_date           AS CHAR FORMAT "x(10)".  /*	120	ws_respone_date	*/
DEF VARIABLE nv_ws_respone_time           AS CHAR FORMAT "x(10)".  /*	121	ws_respone_time	*/
DEF VARIABLE nv_status_print              AS CHAR FORMAT "x(10)".  /*	122	status_print	*/
DEF VARIABLE nv_print_date                AS CHAR FORMAT "x(10)".  /*	123	print_date	*/
DEF VARIABLE nv_print_time                AS CHAR FORMAT "x(10)".  /*	124	print_time	*/
DEF VARIABLE nv_prepol                    AS CHAR FORMAT "x(30)".  /*   Add by Kridtiya i. A63-0432 */

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
