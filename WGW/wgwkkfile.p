/* program ID : wgwkkfile.p  
 Description : Export File Issue send KK Endoresment
 Create by : Ranu I. A63-0299   
 ******************************************************/
DEF SHARED STREAM ns1.
DEF SHARED VAR nv_row        AS INT INIT 0.
DEF SHARED VAR nv_column     AS INT INIT 0.
DEF SHARED VAR nv_output     AS CHAR FORMAT "X(50)" INIT "".
DEF VAR n_length  AS INT INIT 0.
DEF VAR nv_length AS CHAR  INIT "" .

DEFINE SHARED TEMP-TABLE wdetail NO-UNDO
    field ReferenceNo                   as char format "x(15)" 
    field TransactionDateTime           as char format "x(20)" 
    field PayerCardType                 as char format "x(5)" 
    field PayerCardNo                   as char format "x(15)" 
    field PayerTypeGroup                as char format "x(2)" 
    field PayerTitleName                as char format "x(25)" 
    field PayerFirstName                as char format "x(100)" 
    field PayerLastName                 as char format "x(100)" 
    field PayerBirthday                 as char format "x(15)" 
    field PayerAge                      as char format "x(3)" 
    field PayerGender                   as char format "x(2)" 
    field PayerMobileNo                 as char format "x(10)" 
    field PayerOccupation               as char format "x(25)" 
    field InsuredCardType               as char format "x(5)" 
    field InsuredCardNo                 as char format "x(15)" 
    field InsuredType                   as char format "x(3)" 
    field InsuredTitleName              as char format "x(25)" 
    field InsuredFirstName              as char format "x(100)" 
    field InsuredLastName               as char format "x(100)" 
    field InsuredBirthday               as char format "x(15)" 
    field InsuredAge                    as char format "x(3)" 
    field InsuredGender                 as char format "x(2)" 
    field InsuredMobileNo               as char format "x(10)" 
    field InsuredOccupation             as char format "x(25)" 
    field InsuredMaritalStatus          as char format "x(25)" 
    field AddressContact                as char format "x(10)" 
    field AddressTemplateContact        as char format "x(2)" 
    field UnstructureAddressContact     as char format "x(150)" 
    field AddressNoContact              as char format "x(10)" 
    field MooContact                    as char format "x(10)" 
    field VillageBuildingContact        as char format "x(50)" 
    field FloorContact                  as char format "x(10)" 
    field RoomNumberContact             as char format "x(10)" 
    field SoiContact                    as char format "x(50)" 
    field StreetContact                 as char format "x(50)" 
    field SubDistrictContact            as char format "x(50)" 
    field DistrictContact               as char format "x(50)" 
    field ProvinceContact               as char format "x(50)" 
    field CountryContact                as char format "x(50)" 
    field ZipCodeContact                as char format "x(5)" 
    field AddressTax                    as char format "x(5)" 
    field AddressTemplateTax            as char format "x(2)" 
    field UnstructureAddressTax         as char format "x(150)" 
    field AddressNoTax                  as char format "x(10)" 
    field MooTax                        as char format "x(10)" 
    field VillageBuildingTax            as char format "x(50)" 
    field FloorTax                      as char format "x(10)" 
    field RoomNumberTax                 as char format "x(10)" 
    field SoiTax                        as char format "x(50)" 
    field StreetTax                     as char format "x(50)" 
    field SubDistrictTax                as char format "x(50)" 
    field DistrictTax                   as char format "x(50)" 
    field ProvinceTax                   as char format "x(50)" 
    field CountryTax                    as char format "x(50)" 
    field ZipCodeTax                    as char format "x(5)"  
    field KKInsApplicationNo            as char format "x(20)" 
    field TransactionType               as char format "x(2)" 
    field InsuranceCompanyCode          as char INIT ""
    field PolicyType                    as char INIT "P" 
    field MainAppNo                     as char format "x(20)" 
    field InsurerApplicationNo          as char format "x(20)" 
    field PolicyNo                      as char format "x(15)" 
    field ApproveDate                   as char format "x(15)" 
    field ApplicationDate               as char format "x(15)" 
    field EffectiveDate                 as char format "x(15)" 
    field ExpireDate                    as char format "x(15)" 
    field Packagecode                   as char format "x(15)" 
    field FreelookExpired               as char format "x(15)" 
    field MaturityAMT                   as char format "x(10)" 
    field SumInsure                     as deci format "->>>,>>>,>>9.99"  
    field PremiumAmount                 as deci format "->>,>>>,>>9.99" 
    field NetPremium                    as deci format "->>,>>>,>>9.99" 
    field CommRate                      as deci format "->>,>>>,>>9.99" 
    field CommNet                       as deci format "->>,>>>,>>9.99" 
    field CommFix                       as deci format "->>,>>>,>>9.99" 
    field CommVAT                       as deci format "->>,>>>,>>9.99" 
    field CommWHT                       as deci format "->>,>>>,>>9.99" 
    field CommAmt                       as deci format "->>,>>>,>>9.99" 
    field OVRate                        as deci format "->>,>>>,>>9.99" 
    field OVNet                         as deci format "->>,>>>,>>9.99" 
    field OVFix                         as deci format "->>,>>>,>>9.99" 
    field OVVAT                         as deci format "->>,>>>,>>9.99" 
    field OVWHT                         as deci format "->>,>>>,>>9.99" 
    field OVAmt                         as deci format "->>,>>>,>>9.99" 
    field BeneficiaryType               as char format "x(5)" 
    field BeneficiaryName               as char format "x(100)" 
    field Remark                        as char format "x(150)" 
    field CarType                       as char format "x(50)" 
    field CarBrand                      as char format "x(50)" 
    field CarLicenseNo                  as char format "x(50)" 
    field CarLicenseIssue               as char format "x(50)" 
    field ChassisNo                     as char format "x(50)" 
    field EngineNo                      as char format "x(50)" 
    field ModelYear                     as char format "x(50)" 
    field Maintenance                   as char format "x(50)" 
    field NotifiedNO                    as char format "x(50)"
    FIELD covcod                        AS CHAR FORMAT "x(3)"
    FIELD producer                      AS CHAR FORMAT "X(10)"
    FIELD poltyp                        AS CHAR FORMAT "x(5)" 
     /* a63-0299 */
    FIELD endcnt                        AS CHAR FORMAT "x(5)"  
    field SystemCode                    as char format "x(50)"
    field PaymentMode                   as char format "x(1)"
    field PaymentPeriod                 as char format "x(1)" 
    field VATPremium                    as DECI format "->>,>>>,>>9.99" 
    field StampPremium                  as DECI format "->>,>>>,>>9.99" 
    field GrossPremium                  as DECI format "->>,>>>,>>9.99" 
    field WHTPremium                    as DECI format "->>,>>>,>>9.99" 
    field yr                            as char format "->>,>>>,>>9.99"
    FIELD reasoncode                    AS CHAR FORMAT "x(2)" .
    /* end A63-0299 */

DO:
  nv_row    =  0.
  nv_column =  0.
  OUTPUT STREAM ns1 TO VALUE(nv_output) .
       PUT STREAM ns1 "ID;PND" SKIP.        
       ASSIGN nv_row    = nv_row + 1.
       nv_column = nv_column + 1.
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "ReferenceNo"          '"' SKIP.     nv_column = nv_column + 1.      /*1 */                               
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "TransactionDateTime"  '"' SKIP.     nv_column = nv_column + 1.      /*2 */                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "PayerCardType"        '"' SKIP.     nv_column = nv_column + 1.      /*3 */                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "PayerCardNo"          '"' SKIP.     nv_column = nv_column + 1.      /*4 */                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "PayerTypeGroup"       '"' SKIP.     nv_column = nv_column + 1.      /*5 */                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "PayerTitleName"       '"' SKIP.     nv_column = nv_column + 1.      /*6 */                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "PayerFirstName"       '"' SKIP.     nv_column = nv_column + 1.      /*7 */                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "PayerLastName"        '"' SKIP.     nv_column = nv_column + 1.      /*8 */                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "PayerBirthday"        '"' SKIP.     nv_column = nv_column + 1.      /*9 */                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "PayerAge"             '"' SKIP.     nv_column = nv_column + 1.      /*10*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "PayerGender"          '"' SKIP.     nv_column = nv_column + 1.      /*11*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "PayerMobileNo"        '"' SKIP.     nv_column = nv_column + 1.      /*12*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "PayerOccupation"      '"' SKIP.     nv_column = nv_column + 1.      /*13*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "InsuredCardType"      '"' SKIP.     nv_column = nv_column + 1.      /*14*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "InsuredCardNo"        '"' SKIP.     nv_column = nv_column + 1.      /*15*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "InsuredType"          '"' SKIP.     nv_column = nv_column + 1.      /*16*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "InsuredTitleName"     '"' SKIP.     nv_column = nv_column + 1.      /*17*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "InsuredFirstName"     '"' SKIP.     nv_column = nv_column + 1.      /*18*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "InsuredLastName"      '"' SKIP.     nv_column = nv_column + 1.      /*19*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "InsuredBirthday"      '"' SKIP.     nv_column = nv_column + 1.      /*20*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "InsuredAge"           '"' SKIP.     nv_column = nv_column + 1.      /*21*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "InsuredGender"        '"' SKIP.     nv_column = nv_column + 1.      /*22*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "InsuredMobileNo"      '"' SKIP.     nv_column = nv_column + 1.      /*23*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "InsuredOccupation"    '"' SKIP.     nv_column = nv_column + 1.      /*24*/                                
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "InsuredMaritalStatus" '"' SKIP.     nv_column = nv_column + 1.      /*25*/                                
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "AddressContact"       '"' SKIP.     nv_column = nv_column + 1.      /*26*/                                
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "AddressTemplateContact"   '"' SKIP. nv_column = nv_column + 1.      /*27*/                                    
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "UnstructureAddressContact"'"' SKIP. nv_column = nv_column + 1.      /*28*/                                    
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "AddressNoContact"  '"'  SKIP.       nv_column = nv_column + 1.      /*29*/                                
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "MooContact"        '"'  SKIP.       nv_column = nv_column + 1.      /*30*/                                
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "VillageBuildingContact" '"'SKIP.    nv_column = nv_column + 1.      /*31*/                                
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "FloorContact"       '"'  SKIP.      nv_column = nv_column + 1.      /*32*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "RoomNumberContact"  '"'  SKIP.      nv_column = nv_column + 1.      /*33*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "SoiContact"         '"'  SKIP.      nv_column = nv_column + 1.      /*34*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "StreetContact"      '"'  SKIP.      nv_column = nv_column + 1.      /*35*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "SubDistrictContact" '"'  SKIP.      nv_column = nv_column + 1.      /*36*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "DistrictContact"    '"'  SKIP.      nv_column = nv_column + 1.      /*37*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "ProvinceContact"    '"'  SKIP.      nv_column = nv_column + 1.      /*38*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "CountryContact"     '"'  SKIP.      nv_column = nv_column + 1.      /*39*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "ZipCodeContact"     '"'  SKIP.      nv_column = nv_column + 1.      /*40*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "AddressTax"         '"'  SKIP.      nv_column = nv_column + 1.      /*41*/                               
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "AddressTemplateTax"    '"' SKIP.    nv_column = nv_column + 1.      /*42*/                                  
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "UnstructureAddressTax" '"' SKIP.    nv_column = nv_column + 1.      /*43*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "AddressNoTax"       '"' SKIP.       nv_column = nv_column + 1.      /*44*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "MooTax"             '"' SKIP.       nv_column = nv_column + 1.      /*45*/                               
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "VillageBuildingTax" '"' SKIP.       nv_column = nv_column + 1.      /*46*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "FloorTax"           '"' SKIP.       nv_column = nv_column + 1.      /*47*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "RoomNumberTax"      '"' SKIP.       nv_column = nv_column + 1.      /*48*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "SoiTax"             '"' SKIP.       nv_column = nv_column + 1.      /*49*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "StreetTax"          '"' SKIP.       nv_column = nv_column + 1.      /*50*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "SubDistrictTax"     '"' SKIP.       nv_column = nv_column + 1.      /*51*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "DistrictTax"        '"' SKIP.       nv_column = nv_column + 1.      /*52*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "ProvinceTax"        '"' SKIP.       nv_column = nv_column + 1.      /*53*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "CountryTax"         '"' SKIP.       nv_column = nv_column + 1.      /*54*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "ZipCodeTax"         '"' SKIP.       nv_column = nv_column + 1.      /*55*/                               
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "KKInsApplicationNo" '"' SKIP.       nv_column = nv_column + 1.      /*56*/                               
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "TransactionType"    '"' SKIP.       nv_column = nv_column + 1.      /*57*/                               
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "InsuranceCompanyCode" '"' SKIP.     nv_column = nv_column + 1.      /*58*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "PolicyType"           '"' SKIP.     nv_column = nv_column + 1.      /*59*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "MainAppNo"            '"' SKIP.     nv_column = nv_column + 1.      /*60*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "InsurerApplicationNo" '"' SKIP.     nv_column = nv_column + 1.      /*61*/                                     
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "PolicyNo"          '"' SKIP.        nv_column = nv_column + 1.      /*62*/                               
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "ApproveDate"       '"' SKIP.        nv_column = nv_column + 1.      /*63*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "ApplicationDate"   '"' SKIP.        nv_column = nv_column + 1.      /*64*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "EffectiveDate"     '"' SKIP.        nv_column = nv_column + 1.      /*65*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "ExpireDate"        '"' SKIP.        nv_column = nv_column + 1.      /*66*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "Packagecode"       '"' SKIP.        nv_column = nv_column + 1.      /*67*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "FreelookExpired"   '"' SKIP.        nv_column = nv_column + 1.      /*68*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "MaturityAMT"       '"' SKIP.        nv_column = nv_column + 1.      /*69*/                               
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "SumInsure"         '"' SKIP.        nv_column = nv_column + 1.      /*70*/                                                       
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "PremiumAmount"     '"' SKIP.        nv_column = nv_column + 1.      /*71*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "NetPremium"        '"' SKIP.        nv_column = nv_column + 1.      /*72*/                               
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "CommRate"          '"' SKIP.        nv_column = nv_column + 1.      /*73*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "CommNet"           '"' SKIP.        nv_column = nv_column + 1.      /*74*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "CommFix"           '"' SKIP.        nv_column = nv_column + 1.      /*75*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "CommVAT"           '"' SKIP.        nv_column = nv_column + 1.      /*76*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "CommWHT"           '"' SKIP.        nv_column = nv_column + 1.      /*77*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "CommAmt"           '"' SKIP.        nv_column = nv_column + 1.      /*78*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "OVRate"            '"' SKIP.        nv_column = nv_column + 1.      /*79*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "OVNet"             '"' SKIP.        nv_column = nv_column + 1.      /*80*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "OVFix"             '"' SKIP.        nv_column = nv_column + 1.      /*81*/                                                                   
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "OVVAT"             '"' SKIP.        nv_column = nv_column + 1.      /*82*/                                                                   
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "OVWHT"             '"' SKIP.        nv_column = nv_column + 1.      /*83*/                                                                   
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "OVAmt"             '"' SKIP.        nv_column = nv_column + 1.      /*84*/                                                                   
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "BeneficiaryType"   '"' SKIP.        nv_column = nv_column + 1.      /*85*/                                                                   
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "BeneficiaryName"   '"' SKIP.        nv_column = nv_column + 1.      /*86*/                                                                   
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "Remark"            '"' SKIP.        nv_column = nv_column + 1.      /*87*/                              
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "CarType"           '"' SKIP.        nv_column = nv_column + 1.      /*88*/                                                                   
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "CarBrand"          '"' SKIP.        nv_column = nv_column + 1.      /*89*/                                                                   
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "CarLicenseNo"      '"' SKIP.        nv_column = nv_column + 1.      /*90*/                                                                   
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "CarLicenseIssue"   '"' SKIP.        nv_column = nv_column + 1.      /*91*/                                                                   
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "ChassisNo"         '"' SKIP.        nv_column = nv_column + 1.      /*92*/                                                                                                                                       
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "EngineNo"          '"' SKIP.        nv_column = nv_column + 1.      /*93*/                                                                                                                                        
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "ModelYear"         '"' SKIP.        nv_column = nv_column + 1.      /*94*/                                                                     
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "Maintenance"       '"' SKIP.        nv_column = nv_column + 1.      /*95*/                                                                     
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "NotifiedNO"        '"' SKIP.        nv_column = nv_column + 1.      /*96*/                                                                     
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "Poltyp"            '"' SKIP.        nv_column = nv_column + 1.      /*97*/                                                                     
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "Covcod"            '"' SKIP.        nv_column = nv_column + 1.      /*98*/                                                                     
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "Producer"          '"' SKIP.                                        /*99*/ 
       
       FOR EACH wdetail NO-LOCK .   
            ASSIGN nv_column = 0
            nv_column = nv_column + 1 
            nv_row = nv_row  + 1
            n_length  = 0    
            nv_length = "" .
            
            IF trim(ReferenceNo) <> "" THEN n_length  = LENGTH(ReferenceNo). ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(ReferenceNo) FORMAT "x(" + string(n_length) + ")"  '"' SKIP.   /*1 */ 
            nv_column = nv_column + 1. 
            
            IF trim(TransactionDateTime) <> "" THEN n_length  = LENGTH(TransactionDateTime) . ELSE n_length = 0.    
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(TransactionDateTime) FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  /*2 */
            nv_column = nv_column + 1. 
            
            IF trim(PayerCardType) <> "" THEN n_length  = LENGTH(PayerCardType) . ELSE n_length = 0.      
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(PayerCardType)      FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  /*3 */
            nv_column = nv_column + 1.                                                                   
                                                                                                         
            IF trim(PayerCardNo) <> "" THEN n_length  = LENGTH(PayerCardNo) . ELSE n_length = 0.        
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(PayerCardNo)        FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  
            nv_column = nv_column + 1.   /*4 */                                                          
                                                                                                         
            IF trim(PayerTypeGroup) <> "" THEN n_length  = LENGTH(PayerTypeGroup) . ELSE n_length = 0.   
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(PayerTypeGroup)     FORMAT "x(" + STRING(n_length) + ")"     '"' SKIP.  
            nv_column = nv_column + 1.   /*5 */                                                          
                                                                                                         
            IF trim(PayerTitleName) <> "" THEN n_length  = LENGTH(PayerTitleName) . ELSE n_length = 0.  
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(PayerTitleName)     FORMAT "x(" + STRING(n_length) + ")"      '"' SKIP.  
            nv_column = nv_column + 1.   /*6 */                                                          
                                                                                                         
            IF trim(PayerFirstName) <> "" THEN n_length  = LENGTH(PayerFirstName) . ELSE n_length = 0. 
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(PayerFirstName)     FORMAT "x(" + STRING(n_length) + ")"     '"' SKIP.  
            nv_column = nv_column + 1.   /*7 */                                                          
                                                                                                         
            IF trim(PayerLastName) <> "" THEN n_length  = LENGTH(PayerLastName) . ELSE n_length = 0.   
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(PayerLastName)      FORMAT "x(" + STRING(n_length) + ")"      '"' SKIP.  
            nv_column = nv_column + 1.   /*8 */                                                          
                                                                                                         
            IF trim(PayerBirthday) <> "" THEN n_length  = LENGTH(PayerBirthday) . ELSE n_length = 0.    
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(PayerBirthday)      FORMAT "x(" + STRING(n_length) + ")"      '"' SKIP.  
            nv_column = nv_column + 1.   /*9 */ 
            
            IF trim(PayerAge) <> "" THEN n_length  = LENGTH(PayerAge) . ELSE n_length = 0.                                                   
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(PayerAge)         FORMAT "x(" + STRING(n_length) + ")"      '"' SKIP.  
            nv_column = nv_column + 1.   /*10*/                                                                                                  
                                                                                                                                                 
            IF trim(PayerGender) <> "" THEN n_length  = LENGTH(PayerGender) . ELSE n_length = 0.                                                 
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(PayerGender)      FORMAT "x(" + STRING(n_length) + ")"      '"' SKIP. 
            nv_column = nv_column + 1.   /*11*/                                                                                              
                                                                                                                                             
            IF trim(PayerMobileNo) <> "" THEN n_length  = LENGTH(PayerMobileNo) . ELSE n_length = 0.                                        
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(PayerMobileNo)  FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  
            nv_column = nv_column + 1.   /*12*/                                                                                              
                                                                                                                                             
            IF trim(PayerOccupation) <> "" THEN n_length  = LENGTH(PayerOccupation) . ELSE n_length = 0.                                   
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(PayerOccupation) FORMAT "x(" + STRING(n_length) + ")"   '"' SKIP.  
            nv_column = nv_column + 1.   /*13*/                                                                                              
                                                                                                                                             
            IF trim(InsuredCardType) <> "" THEN n_length  = LENGTH(InsuredCardType) . ELSE n_length = 0.                                     
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(InsuredCardType) FORMAT "x(" + STRING(n_length) + ")"   '"' SKIP.  
            nv_column = nv_column + 1.   /*14*/  
            
            IF trim(InsuredCardNo) <> "" THEN n_length  = LENGTH(InsuredCardNo) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(InsuredCardNo)  FORMAT "x(" + STRING(n_length) + ")"     '"' SKIP.  
            nv_column = nv_column + 1.   /*15*/  

            IF trim(InsuredType) <> "" THEN n_length  = LENGTH(InsuredType) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(InsuredType)  FORMAT "x(" + STRING(n_length) + ")"       '"' SKIP.  
            nv_column = nv_column + 1.   /*16*/  

            IF trim(InsuredTitleName) <> "" THEN n_length  = LENGTH(InsuredTitleName) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(InsuredTitleName)   FORMAT "x(" + STRING(n_length) + ")"     '"' SKIP.  
            nv_column = nv_column + 1.   /*17*/  

            IF trim(InsuredFirstName) <> "" THEN n_length  = LENGTH(InsuredFirstName) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(InsuredFirstName)   FORMAT "x(" + STRING(n_length) + ")"  '"' SKIP.  
            nv_column = nv_column + 1.   /*18*/  

            IF trim(InsuredLastName) <> "" THEN n_length  = LENGTH(InsuredLastName) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(InsuredLastName)   FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  
            nv_column = nv_column + 1.   /*19*/ 
            
            IF trim(InsuredBirthday) <> "" THEN n_length  = LENGTH(InsuredBirthday) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(InsuredBirthday) FORMAT "x(" + STRING(n_length) + ")"         '"' SKIP.  
            nv_column = nv_column + 1.   /*20*/

            IF trim(InsuredAge) <> "" THEN n_length  = LENGTH(InsuredAge) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(InsuredAge) FORMAT "x(" + STRING(n_length) + ")"              '"' SKIP.  
            nv_column = nv_column + 1.   /*21*/ 
            
            IF trim(InsuredGender) <> "" THEN n_length  = LENGTH(InsuredGender) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(InsuredGender)  FORMAT "x(" + STRING(n_length) + ")"          '"' SKIP.  
            nv_column = nv_column + 1.   /*22*/
            
            IF trim(InsuredMobileNo) <> "" THEN n_length  = LENGTH(InsuredMobileNo) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(InsuredMobileNo)  FORMAT "x(" + STRING(n_length) + ")"        '"' SKIP.  
            nv_column = nv_column + 1.   /*23*/ 

            IF trim(InsuredOccupation) <> "" THEN n_length  = LENGTH(InsuredOccupation) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(InsuredOccupation) FORMAT "x(" + STRING(n_length) + ")"       '"' SKIP.  
            nv_column = nv_column + 1.   /*24*/

            IF trim(InsuredMaritalStatus) <> "" THEN n_length  = LENGTH(InsuredMaritalStatus) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(InsuredMaritalStatus) FORMAT "x(" + STRING(n_length) + ")"     '"' SKIP.  
            nv_column = nv_column + 1.   /*25*/
            
            IF trim(AddressContact) <> "" THEN n_length  = LENGTH(AddressContact) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(AddressContact) FORMAT "x(" + STRING(n_length) + ")"          '"' SKIP.  
            nv_column = nv_column + 1.   /*26*/
    
            IF trim(AddressTemplateContact) <> "" THEN n_length  = LENGTH(AddressTemplateContact) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(AddressTemplateContact) FORMAT "x(" + STRING(n_length) + ")"  '"' SKIP.  
            nv_column = nv_column + 1.   /*27*/ 

            IF trim(UnstructureAddressContact) <> "" THEN n_length  = LENGTH(UnstructureAddressContact) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(UnstructureAddressContact) FORMAT "x(" + STRING(n_length) + ")" '"' SKIP.  
            nv_column = nv_column + 1.   /*28*/

            IF trim(AddressNoContact) <> "" THEN n_length  = LENGTH(AddressNoContact) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(AddressNoContact)   FORMAT "x(" + STRING(n_length) + ")"      '"' SKIP.  
            nv_column = nv_column + 1.   /*29*/

            IF trim(MooContact) <> "" THEN n_length  = LENGTH(MooContact) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(MooContact)   FORMAT "x(" + STRING(n_length) + ")"            '"' SKIP.  
            nv_column = nv_column + 1.   /*30*/

            IF trim(VillageBuildingContact) <> "" THEN n_length  = LENGTH(VillageBuildingContact) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(VillageBuildingContact) FORMAT "x(" + STRING(n_length) + ")"  '"' SKIP.  
            nv_column = nv_column + 1.   /*31*/

            IF trim(FloorContact) <> "" THEN n_length  = LENGTH(FloorContact) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(FloorContact)   FORMAT "x(" + STRING(n_length) + ")"   '"' SKIP.  
            nv_column = nv_column + 1.   /*32*/

            IF trim(RoomNumberContact) <> "" THEN n_length  = LENGTH(RoomNumberContact) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(RoomNumberContact) FORMAT "x(" + STRING(n_length) + ")" '"' SKIP.  
            nv_column = nv_column + 1.   /*33*/ 
    
            IF trim(SoiContact) <> "" THEN n_length  = LENGTH(SoiContact) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(SoiContact)  FORMAT "x(" + STRING(n_length) + ")"   '"' SKIP.  
            nv_column = nv_column + 1.   /*34*/  
            
            IF trim(StreetContact) <> "" THEN n_length  = LENGTH(StreetContact) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(StreetContact)  FORMAT "x(" + STRING(n_length) + ")"          '"' SKIP.  
            nv_column = nv_column + 1.   /*35*/ 

            IF trim(SubDistrictContact) <> "" THEN n_length  = LENGTH(SubDistrictContact) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(SubDistrictContact) FORMAT "x(" + STRING(n_length) + ")"      '"' SKIP.  
            nv_column = nv_column + 1.   /*36*/  

            IF trim(DistrictContact) <> "" THEN n_length  = LENGTH(DistrictContact) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(DistrictContact)  FORMAT "x(" + STRING(n_length) + ")"        '"' SKIP.  
            nv_column = nv_column + 1.   /*37*/  

            IF trim(ProvinceContact) <> "" THEN n_length  = LENGTH(ProvinceContact) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(ProvinceContact)  FORMAT "x(" + STRING(n_length) + ")"        '"' SKIP.  
            nv_column = nv_column + 1.   /*38*/

            IF trim(CountryContact) <> "" THEN n_length  = LENGTH(CountryContact) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(CountryContact)  FORMAT "x(" + STRING(n_length) + ")"         '"' SKIP.  
            nv_column = nv_column + 1.   /*39*/ 

            IF trim(ZipCodeContact) <> "" THEN n_length  = LENGTH(ZipCodeContact) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(ZipCodeContact)  FORMAT "x(" + STRING(n_length) + ")"         '"' SKIP.  
            nv_column = nv_column + 1.   /*40*/

            IF trim(AddressTax) <> "" THEN n_length  = LENGTH(AddressTax) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(AddressTax) FORMAT "x(" + STRING(n_length) + ")"              '"' SKIP.  
            nv_column = nv_column + 1.   /*41*/ 

            IF trim(AddressTemplateTax) <> "" THEN n_length  = LENGTH(AddressTemplateTax) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(AddressTemplateTax)  FORMAT "x(" + STRING(n_length) + ")"     '"' SKIP.  
            nv_column = nv_column + 1.   /*42*/ 

            IF trim(UnstructureAddressTax) <> "" THEN n_length  = LENGTH(UnstructureAddressTax) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(UnstructureAddressTax)  FORMAT "x(" + STRING(n_length) + ")"  '"' SKIP.  
            nv_column = nv_column + 1.   /*43*/ 

            IF trim(AddressNoTax) <> "" THEN n_length  = LENGTH(AddressNoTax) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(AddressNoTax)   FORMAT "x(" + STRING(n_length) + ")" '"' SKIP.  
            nv_column = nv_column + 1.   /*44*/                                                                                                                

            IF trim(MooTax) <> "" THEN n_length  = LENGTH(MooTax) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(MooTax)   FORMAT "x(" + STRING(n_length) + ")"       '"' SKIP.  
            nv_column = nv_column + 1.   /*45*/                                                                                                                

            IF trim(VillageBuildingTax) <> "" THEN n_length  = LENGTH(VillageBuildingTax) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(VillageBuildingTax)   FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  
            nv_column = nv_column + 1.   /*46*/ 

            IF trim(FloorTax) <> "" THEN n_length  = LENGTH(FloorTax) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(FloorTax)  FORMAT "x(" + STRING(n_length) + ")"   '"' SKIP.  
            nv_column = nv_column + 1.   /*47*/                                                                                                             

            IF trim(RoomNumberTax) <> "" THEN n_length  = LENGTH(RoomNumberTax) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(RoomNumberTax)  FORMAT "x(" + STRING(n_length) + ")" '"' SKIP.  
            nv_column = nv_column + 1.   /*48*/                                                                                                                

            IF trim(SoiTax) <> "" THEN n_length  = LENGTH(SoiTax) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(SoiTax)  FORMAT "x(" + STRING(n_length) + ")"        '"' SKIP.  
            nv_column = nv_column + 1.   /*49*/                                                                                                                

            IF trim(StreetTax) <> "" THEN n_length  = LENGTH(StreetTax) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(StreetTax)   FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  
            nv_column = nv_column + 1.   /*50*/ 

            IF trim(SubDistrictTax) <> "" THEN n_length  = LENGTH(SubDistrictTax) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(SubDistrictTax)  FORMAT "x(" + STRING(n_length) + ")"          '"' SKIP.  
            nv_column = nv_column + 1.   /*51*/

            IF trim(DistrictTax) <> "" THEN n_length  = LENGTH(DistrictTax) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(DistrictTax)  FORMAT "x(" + STRING(n_length) + ")"            '"' SKIP.  
            nv_column = nv_column + 1.   /*52*/ 

            IF trim(ProvinceTax) <> "" THEN n_length  = LENGTH(ProvinceTax) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(ProvinceTax)  FORMAT "x(" + STRING(n_length) + ")"            '"' SKIP.  
            nv_column = nv_column + 1.   /*53*/ 

            IF trim(CountryTax) <> "" THEN n_length  = LENGTH(CountryTax) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(CountryTax)  FORMAT "x(" + STRING(n_length) + ")"             '"' SKIP.  
            nv_column = nv_column + 1.   /*54*/ 

            IF trim(ZipCodeTax) <> "" THEN n_length  = LENGTH(ZipCodeTax) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(ZipCodeTax)  FORMAT "x(" + STRING(n_length) + ")"             '"' SKIP.  
            nv_column = nv_column + 1.   /*55*/ 
            
            IF trim(KKInsApplicationNo) <> "" THEN n_length  = LENGTH(KKInsApplicationNo) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(KKInsApplicationNo)  FORMAT "x(" + STRING(n_length) + ")"     '"' SKIP.
            nv_column = nv_column + 1.   /*56*/

            IF trim(TransactionType) <> "" THEN n_length  = LENGTH(TransactionType) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(TransactionType)  FORMAT "x(" + STRING(n_length) + ")"        '"' SKIP.  
            nv_column = nv_column + 1.   /*57*/ 

            IF trim(InsuranceCompanyCode) <> "" THEN n_length  = LENGTH(InsuranceCompanyCode) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(InsuranceCompanyCode) FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  
            nv_column = nv_column + 1.   /*58*/

            IF trim(PolicyType) <> "" THEN n_length  = LENGTH(PolicyType) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(PolicyType)  FORMAT "x(" + STRING(n_length) + ")"             '"' SKIP.  
            nv_column = nv_column + 1.   /*59*/ 

            IF trim(MainAppNo) <> "" THEN n_length  = LENGTH(MainAppNo) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(MainAppNo)  FORMAT "x(" + STRING(n_length) + ")"  '"' SKIP.
            nv_column = nv_column + 1.   /*60*/ 

            IF trim(InsurerApplicationNo) <> "" THEN n_length  = LENGTH(InsurerApplicationNo) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(InsurerApplicationNo)  FORMAT "x(" + STRING(n_length) + ")"  '"' SKIP.
            nv_column = nv_column + 1.   /*61*/  

            IF trim(PolicyNo) <> "" THEN n_length  = LENGTH(PolicyNo) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(PolicyNo)   FORMAT "x(" + STRING(n_length) + ")"  '"' SKIP.  
            nv_column = nv_column + 1.   /*62*/ 

            IF trim(ApproveDate) <> "" THEN n_length  = LENGTH(ApproveDate) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(ApproveDate)  FORMAT "x(" + STRING(n_length) + ")"   '"' SKIP.  
            nv_column = nv_column + 1.   /*63*/ 

            IF trim(ApplicationDate) <> "" THEN n_length  = LENGTH(ApplicationDate) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(ApplicationDate)   FORMAT "x(" + STRING(n_length) + ")"  '"' SKIP.  
            nv_column = nv_column + 1.   /*64*/ 

            IF trim(EffectiveDate) <> "" THEN n_length  = LENGTH(EffectiveDate) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(EffectiveDate)   FORMAT "x(" + STRING(n_length) + ")"  '"' SKIP.  
            nv_column = nv_column + 1.   /*65*/ 

            IF trim(ExpireDate) <> "" THEN n_length  = LENGTH(ExpireDate) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(ExpireDate)    FORMAT "x(" + STRING(n_length) + ")"  '"' SKIP.  
            nv_column = nv_column + 1.   /*66*/

            IF trim(Packagecode) <> "" THEN n_length  = LENGTH(Packagecode) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(Packagecode)    FORMAT "x(" + STRING(n_length) + ")"  '"' SKIP.  
            nv_column = nv_column + 1.   /*67*/

            IF trim(FreelookExpired) <> "" THEN n_length  = LENGTH(FreelookExpired) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(FreelookExpired)   FORMAT "x(" + STRING(n_length) + ")"   '"' SKIP.  
            nv_column = nv_column + 1.   /*68*/ 

            IF trim(MaturityAMT) <> "" THEN n_length  = LENGTH(MaturityAMT) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(MaturityAMT)   FORMAT "x(" + STRING(n_length) + ")"  '"' SKIP.  
            nv_column = nv_column + 1.   /*69*/ 

            IF trim(STRING(SumInsure)) <> "" THEN n_length  = LENGTH(STRING(SumInsure)) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(STRING(SumInsure))   FORMAT "x(" + STRING(n_length) + ")"  '"' SKIP.  
            nv_column = nv_column + 1.   /*70*/

            IF trim(STRING(PremiumAmount)) <> "" THEN n_length  = LENGTH(string(PremiumAmount)) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(string(PremiumAmount)) FORMAT "x(" + STRING(n_length) + ")"  '"' SKIP.  
            nv_column = nv_column + 1.   /*71*/ 

            IF trim(string(NetPremium)) <> "" THEN n_length  = LENGTH(string(NetPremium)) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(string(NetPremium))    FORMAT "x(" + STRING(n_length) + ")"  '"' SKIP.  
            nv_column = nv_column + 1.   /*72*/

            IF trim(string(CommRate)) <> "" THEN n_length  = LENGTH(string(CommRate)) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(string(CommRate))    FORMAT "x(" + STRING(n_length) + ")"   '"' SKIP.  
            nv_column = nv_column + 1.   /*73*/ 

            IF trim(string(CommNet)) <> "" THEN n_length  = LENGTH(string(CommNet)) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(string(CommNet))    FORMAT "x(" + STRING(n_length) + ")"  '"' SKIP.  
            nv_column = nv_column + 1.   /*74*/ 

            IF trim(string(CommFix)) <> "" THEN n_length  = LENGTH(string(CommFix)) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(string(CommFix))   FORMAT "x(" + STRING(n_length) + ")" '"' SKIP.  
            nv_column = nv_column + 1.   /*75*/ 

            IF trim(string(CommVAT)) <> "" THEN n_length  = LENGTH(string(CommVAT)) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(string(CommVAT))   FORMAT "x(" + STRING(n_length) + ")" '"' SKIP.  
            nv_column = nv_column + 1.   /*76*/

            IF trim(string(CommWHT)) <> "" THEN n_length  = LENGTH(string(CommWHT)) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(string(CommWHT))   FORMAT "x(" + STRING(n_length) + ")"  '"' SKIP.  
            nv_column = nv_column + 1.   /*77*/ 

            IF trim(string(CommAmt)) <> "" THEN n_length  = LENGTH(string(CommAmt)) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(string(CommAmt))  FORMAT "x(" + STRING(n_length) + ")"  '"' SKIP.  
            nv_column = nv_column + 1.   /*78*/ 

            IF trim(string(OVRate)) <> "" THEN n_length  = LENGTH(string(OVRate)) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(string(OVRate))  FORMAT "x(" + STRING(n_length) + ")"   '"' SKIP.  
            nv_column = nv_column + 1.   /*79*/ 

            IF trim(STRING(OVNet)) <> "" THEN n_length  = LENGTH(string(OVNet)) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(string(OVNet))  FORMAT "x(" + STRING(n_length) + ")" '"' SKIP.  
            nv_column = nv_column + 1.   /*80*/ 

            IF trim(string(OVFix)) <> "" THEN n_length  = LENGTH(string(OVFix)) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(string(OVFix))  FORMAT "x(" + STRING(n_length) + ")"  '"' SKIP.  
            nv_column = nv_column + 1.   /*81*/ 

            IF trim(string(OVVAT)) <> "" THEN n_length  = LENGTH(string(OVVAT)) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(string(OVVAT))  FORMAT "x(" + STRING(n_length) + ")"  '"' SKIP.  
            nv_column = nv_column + 1.   /*82*/ 

            IF trim(string(OVWHT)) <> "" THEN n_length  = LENGTH(string(OVWHT)) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(string(OVWHT))  FORMAT "x(" + STRING(n_length) + ")" '"' SKIP.  
            nv_column = nv_column + 1.   /*83*/

            IF trim(string(OVAmt)) <> "" THEN n_length  = LENGTH(string(OVAmt)) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(string(OVAmt))   FORMAT "x(" + STRING(n_length) + ")" '"' SKIP.  
            nv_column = nv_column + 1.   /*84*/ 

            IF trim(BeneficiaryType) <> "" THEN n_length  = LENGTH(BeneficiaryType) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(BeneficiaryType) FORMAT "x(" + STRING(n_length) + ")"   '"' SKIP.  
            nv_column = nv_column + 1.   /*85*/

            IF trim(BeneficiaryName) <> "" THEN n_length  = LENGTH(BeneficiaryName) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(BeneficiaryName)  FORMAT "x(" + STRING(n_length) + ")"  '"' SKIP.  
            nv_column = nv_column + 1.   /*86*/

            IF trim(Remark) <> "" THEN n_length  = LENGTH(Remark) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(Remark)  FORMAT "x(" + STRING(n_length) + ")"  '"' SKIP.  
            nv_column = nv_column + 1.   /*87*/ 

            IF trim(CarType) <> "" THEN n_length  = LENGTH(CarType) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(CarType)  FORMAT "x(" + STRING(n_length) + ")"  '"' SKIP.  
            nv_column = nv_column + 1.   /*88*/

            IF trim(CarBrand) <> "" THEN n_length  = LENGTH(CarBrand) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(CarBrand)  FORMAT "x(" + STRING(n_length) + ")"   '"' SKIP.  
            nv_column = nv_column + 1.   /*89*/

            IF trim(CarLicenseNo) <> "" THEN n_length  = LENGTH(CarLicenseNo) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(CarLicenseNo)  FORMAT "x(" + STRING(n_length) + ")"   '"' SKIP.  
            nv_column = nv_column + 1.   /*90*/

            IF trim(CarLicenseIssue) <> "" THEN n_length  = LENGTH(CarLicenseIssue) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(CarLicenseIssue) FORMAT "x(" + STRING(n_length) + ")"   '"' SKIP.  
            nv_column = nv_column + 1.   /*91*/ 

            IF trim(ChassisNo) <> "" THEN n_length  = LENGTH(ChassisNo) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(ChassisNo)  FORMAT "x(" + STRING(n_length) + ")"  '"' SKIP.  
            nv_column = nv_column + 1.   /*92*/ 

            IF trim(EngineNo) <> "" THEN n_length  = LENGTH(EngineNo) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(EngineNo)   FORMAT "x(" + STRING(n_length) + ")"  '"' SKIP.  
            nv_column = nv_column + 1.   /*93*/ 

            IF trim(ModelYear) <> "" THEN n_length  = LENGTH(ModelYear) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(ModelYear)  FORMAT "x(" + STRING(n_length) + ")"  '"' SKIP.  
            nv_column = nv_column + 1.   /*94*/

            IF trim(Maintenance) <> "" THEN n_length  = LENGTH(Maintenance) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(Maintenance)  FORMAT "x(" + STRING(n_length) + ")"   '"' SKIP.  
            nv_column = nv_column + 1.   /*95*/

            IF trim(NotifiedNO) <> "" THEN n_length  = LENGTH(NotifiedNO) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(NotifiedNO)  FORMAT "x(" + STRING(n_length) + ")"  '"' SKIP.  
            nv_column = nv_column + 1.   /*96*/ 

            IF trim(poltyp) <> "" THEN n_length  = LENGTH(poltyp) . ELSE n_length = 0.                                                           
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(poltyp)  FORMAT "x(" + STRING(n_length) + ")"  '"' SKIP.  
            nv_column = nv_column + 1.   /*97*/                                                                                                          

            IF trim(covcod) <> "" THEN n_length  = LENGTH(covcod) . ELSE n_length = 0.                                                           
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(covcod)   FORMAT "x(" + STRING(n_length) + ")" '"' SKIP.  
            nv_column = nv_column + 1.   /*98*/                                                                                                          

            IF trim(producer) <> "" THEN n_length  = LENGTH(producer) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(producer)  FORMAT "x(" + STRING(n_length) + ")"  '"' SKIP.  
            nv_column = nv_column + 1.   /*99*/ 
        END.
    PUT STREAM ns1 "E" SKIP.
    OUTPUT STREAM ns1 CLOSE.
END.





