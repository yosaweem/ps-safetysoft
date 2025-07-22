/* program ID : wgwtibexc.p  
 Description : Export File Excel data TIB
 Create by : Ranu I. A67-0222   
 ******************************************************/
DEF SHARED STREAM ns1.
DEF SHARED VAR nv_output     AS CHAR FORMAT "X(50)" INIT "".
DEF VAR n_length  AS INT INIT 0.
DEF VAR nv_length AS CHAR  INIT "" .
DEF VAR nv_row        AS INT INIT 0.
DEF VAR nv_column     AS INT INIT 0.
DEF VAR nv_count    AS INTE INIT 0.

DEFINE SHARED TEMP-TABLE wdetail2 NO-UNDO
        FIELD head          AS CHAR FORMAT "x(1)"   INIT ""      
        FIELD comcode       AS CHAR FORMAT "x(4)"   INIT ""      
        FIELD senddat       AS CHAR FORMAT "x(8)"   INIT ""      
        FIELD contractno    AS CHAR FORMAT "x(10)"  INIT ""     
        FIELD lotno         AS CHAR FORMAT "x(9)"   INIT ""      
        FIELD seqno         AS CHAR FORMAT "x(6)"   INIT ""      
        FIELD recact        AS CHAR FORMAT "x(1)"   INIT ""     
        FIELD STATUSno      AS CHAR FORMAT "x(1)"   INIT ""     
        FIELD flag          AS CHAR FORMAT "x(1)"   INIT ""  
        FIELD ntitle        AS CHAR FORMAT "x(20)"  INIT ""  
        FIELD insname       AS CHAR FORMAT "x(100)" INIT "" 
        FIELD lastname       AS CHAR FORMAT "x(100)" INIT ""               
        FIELD add1          AS CHAR FORMAT "x(50)"  INIT ""    
        FIELD add2          AS CHAR FORMAT "x(50)"  INIT ""    
        FIELD add3          AS CHAR FORMAT "x(50)"  INIT ""    
        FIELD add4          AS CHAR FORMAT "x(50)"  INIT ""     
        FIELD add5          AS CHAR FORMAT "x(5)"   INIT ""      
        FIELD engno         AS CHAR FORMAT "x(20)"  INIT ""     
        FIELD chasno        AS CHAR FORMAT "x(20)"  INIT ""     
        FIELD brand         AS CHAR FORMAT "x(3)"   INIT ""      
        FIELD model         AS CHAR FORMAT "x(40)"  INIT ""     
        FIELD cc            AS CHAR FORMAT "x(5)"   INIT ""      
        FIELD COLORno       AS CHAR FORMAT "x(4)"   INIT ""   
        FIELD reg1          AS CHAR FORMAT "x(5)"   INIT ""     
        FIELD reg2          AS CHAR FORMAT "x(5)"   INIT ""     
        FIELD provinco      AS CHAR FORMAT "x(2)"   INIT ""       
        FIELD subinsco      AS CHAR FORMAT "x(50)"  INIT ""       
        FIELD covamount     AS CHAR FORMAT "x(20)"  INIT ""       
        FIELD grpssprem     AS CHAR FORMAT "x(20)"  INIT ""       
        FIELD effecdat      AS CHAR FORMAT "x(10)"  INIT ""       
        FIELD notifyno      AS CHAR FORMAT "x(100)" INIT ""       
        FIELD noticode      AS CHAR FORMAT "x(50)"  INIT ""       
        FIELD noticodesty   AS CHAR FORMAT "x(25)"  INIT ""       
        FIELD notiname      AS CHAR FORMAT "x(50)"  INIT ""       
        FIELD substyname    AS CHAR FORMAT "x(50)"  INIT ""       
        FIELD comamount     AS CHAR FORMAT "x(20)"  INIT ""      
        FIELD comprem       AS CHAR FORMAT "x(20)"  INIT ""       
        FIELD comeffecdat   AS CHAR FORMAT "x(10)"  INIT ""       
        FIELD compno        AS CHAR FORMAT "x(25)"  INIT ""      
        FIELD recivno       AS CHAR FORMAT "x(100)" INIT ""      
        FIELD recivcode     AS CHAR FORMAT "x(4)"   INIT ""       
        FIELD recivcosty    AS CHAR FORMAT "x(25)"  INIT ""      
        FIELD recivstynam   AS CHAR FORMAT "x(50)"  INIT ""      
        FIELD comppol       AS CHAR FORMAT "x(25)"  INIT ""      
        FIELD recivstydat   AS CHAR FORMAT "x(8)"   INIT ""      
        FIELD drivnam1      AS CHAR FORMAT "x(30)"  INIT ""      
        FIELD drivnam2      AS CHAR FORMAT "x(30)"  INIT ""    
        FIELD drino1        AS CHAR FORMAT "x(13)"  INIT ""     
        FIELD drino2        AS CHAR FORMAT "x(13)"  INIT ""     
        FIELD oldeng        AS CHAR FORMAT "x(20)"  INIT ""      
        FIELD oldchass      AS CHAR FORMAT "x(20)"  INIT ""      
        FIELD NAMEpay       AS CHAR FORMAT "x(100)" INIT ""      
        FIELD addpay1       AS CHAR FORMAT "X(50)"  INIT ""     
        FIELD addpay2       AS CHAR FORMAT "X(50)"  INIT ""      
        FIELD addpay3       AS CHAR FORMAT "X(50)"  INIT ""      
        FIELD addpay4       AS CHAR FORMAT "x(50)"  INIT ""      
        FIELD postpay       AS CHAR FORMAT "x(5)"   INIT ""       
        FIELD Reserved1     AS CHAR FORMAT "X(13)"  INIT ""      
        FIELD Reserved2     AS CHAR FORMAT "x(13)"  INIT ""      
        FIELD norcovdat     AS CHAR FORMAT "x(10)"  INIT ""       
        FIELD norcovenddat  AS CHAR FORMAT "x(10)"  INIT ""       
        FIELD showroom      AS CHAR FORMAT "X(40)"  INIT ""       
        FIELD caryear       AS CHAR FORMAT "x(4)"   INIT ""       
        FIELD renewtyp      AS CHAR FORMAT "x(1)"   INIT ""       
        FIELD Reserved5     AS CHAR FORMAT "x(59)"  INIT ""      
        FIELD idno          AS CHAR FORMAT "x(21)"  INIT ""  
        FIELD access        AS CHAR FORMAT "x(1000)" INIT "" 
        FIELD InsType       as char format "X(2)"   INIT "" 
        FIELD Garage        as char format "X(2)"   INIT "" 
        FIELD Drivnam       as char format "X(1)"   INIT "" 
        FIELD Driver1       as char format "X(100)" INIT "" 
        FIELD DrivDate1     as char format "X(8)"   INIT "" 
        FIELD DrivLicense1  as char format "X(20)"  INIT "" 
        FIELD Driver2       as char format "X(100)" INIT "" 
        FIELD DrivDate2     as char format "X(8)"   INIT "" 
        FIELD DrivLicense2  as char format "X(20)"  INIT "" 
        FIELD sclass        as char format "X(3)"   INIT "" 
        FIELD Deduct        as char format "X(6)"   INIT "" 
        FIELD EndorseSI     as char format "X(7)"   INIT "" 
        FIELD EndorsePrm    as char format "X(5)"   INIT "" 
        FIELD DealerCode    as char format "X(4)"   INIT "" 
        /* add var */
         FIELD titlenamepay  as char format "X(60)"  INIT ""
         FIELD lastnamepay   as char format "X(60)"  INIT ""
         FIELD Drivern1      as char format "X(60)"  INIT "" 
         FIELD Driverl1      as char format "X(60)"  INIT "" 
         FIELD Drivern2      as char format "X(60)"  INIT "" 
         FIELD Driverl2      as char format "X(60)"  INIT "" 
         FIELD branch        AS CHAR FORMAT "x(2)"   INIT ""    
         FIELD producer      AS CHAR FORMAT "x(10)"  INIT ""    
         FIELD agent         AS CHAR FORMAT "x(10)"  INIT ""    
         FIELD prvpol        AS CHAR FORMAT "x(15)"  INIT ""  
         FIELD covcod        AS CHAR FORMAT "x(3)"   INIT ""  
         FIELD Vehuse        AS CHAR FORMAT "x(5)"   INIT "" 
         FIELD loss          AS CHAR FORMAT "x(10)"  INIT ""
         FIELD prepol        AS CHAR FORMAT "x(12)"  INIT ""  
         FIELD dateloss      AS CHAR FORMAT "x(15)"  INIT "" 
         FIELD expirydat     AS CHAR FORMAT "x(15)"  INIT "" 
         FIELD premt         AS CHAR FORMAT "x(15)"  INIT "" .
DO:
  nv_row    =  0.
  nv_column =  0.
  nv_count = 0.
  OUTPUT STREAM ns1 TO VALUE(nv_output) .
       PUT STREAM ns1 "ID;PND" SKIP.        
       ASSIGN nv_row    = nv_row + 1.
       nv_column = nv_column + 1.

       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "No  "                             '"' SKIP.     nv_column = nv_column + 1.
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "Record type  "                    '"' SKIP.     nv_column = nv_column + 1.      /*1 */                               
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "Company code "                    '"' SKIP.     nv_column = nv_column + 1.      /*2 */                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "Date sent    "                    '"' SKIP.     nv_column = nv_column + 1.      /*3 */                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "Application No./ Contract No. "   '"' SKIP.     nv_column = nv_column + 1.      /*4 */                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "Lot no. "                         '"' SKIP.     nv_column = nv_column + 1.      /*5 */                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "Seq.no  "                         '"' SKIP.     nv_column = nv_column + 1.      /*6 */                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "Record Active "                   '"' SKIP.     nv_column = nv_column + 1.      /*7 */                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "Status  "                         '"' SKIP.     nv_column = nv_column + 1.      /*8 */                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "Flag    "                         '"' SKIP.     nv_column = nv_column + 1.      /*9 */                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "ชื่อผู้เอาประกัน    "             '"' SKIP.     nv_column = nv_column + 1.      /*10*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "ที่อยู่ผู้เอาประกัน 1"            '"' SKIP.     nv_column = nv_column + 1.      /*11*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "ที่อยู่ผู้เอาประกัน 2"            '"' SKIP.     nv_column = nv_column + 1.      /*12*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "ที่อยู่ผู้เอาประกัน 3"            '"' SKIP.     nv_column = nv_column + 1.      /*13*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "ที่อยู่ผู้เอาประกัน 4"            '"' SKIP.     nv_column = nv_column + 1.      /*14*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "ที่อยู่ผู้เอาประกัน 5"            '"' SKIP.     nv_column = nv_column + 1.      /*15*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "Engine no.    "                   '"' SKIP.     nv_column = nv_column + 1.      /*16*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "Chasis no.    "                   '"' SKIP.     nv_column = nv_column + 1.      /*17*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "Car brand code"                   '"' SKIP.     nv_column = nv_column + 1.      /*18*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "Model   "                         '"' SKIP.     nv_column = nv_column + 1.      /*19*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "CC./Weight    "                   '"' SKIP.     nv_column = nv_column + 1.      /*20*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "Color code    "                   '"' SKIP.     nv_column = nv_column + 1.      /*21*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "ทะเบียนรถ 1   "                   '"' SKIP.     nv_column = nv_column + 1.      /*22*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "ทะเบียนรถ 2   "                   '"' SKIP.     nv_column = nv_column + 1.      /*23*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "Province code "                   '"' SKIP.     nv_column = nv_column + 1.      /*24*/                                
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "Sub insurance code   "            '"' SKIP.     nv_column = nv_column + 1.      /*25*/                                
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "Normal Coverage amount   "        '"' SKIP.     nv_column = nv_column + 1.      /*26*/                                
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "Normal Gross premium "            '"' SKIP.     nv_column = nv_column + 1.      /*27*/                                    
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "Effective date       "            '"' SKIP.     nv_column = nv_column + 1.      /*28*/                                    
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "Remark for Comprehensive "        '"' SKIP.     nv_column = nv_column + 1.      /*29*/                                
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "รหัสผู้รับแจ้งฯ TLT "             '"' SKIP.     nv_column = nv_column + 1.      /*30*/                                
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "เลขรับแจ้งฯ จากบ.ประกันภัย    "   '"' SKIP.     nv_column = nv_column + 1.      /*31*/                                
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "ชื่อผู้รับแจ้งฯของบ.ประกันภัย "   '"' SKIP.     nv_column = nv_column + 1.      /*32*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "Compl. Sub insurance code "       '"' SKIP.     nv_column = nv_column + 1.      /*33*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "Compl. Coverage amount"           '"' SKIP.     nv_column = nv_column + 1.      /*34*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "Compl. Gross premium  "           '"' SKIP.     nv_column = nv_column + 1.      /*35*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "Compl. Effective date "           '"' SKIP.     nv_column = nv_column + 1.      /*36*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "เครื่องหมาย (พรบ.)    "           '"' SKIP.     nv_column = nv_column + 1.      /*37*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "Remark for Complusory "           '"' SKIP.     nv_column = nv_column + 1.      /*38*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "รหัสผู้รับแจ้งฯ TLT   "           '"' SKIP.     nv_column = nv_column + 1.      /*39*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "เลขรับแจ้งฯจากบ.ประกันภัย "       '"' SKIP.     nv_column = nv_column + 1.      /*40*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "ชื่อผู้รับแจ้งฯของบ.ประกันภัย "   '"' SKIP.     nv_column = nv_column + 1.      /*41*/                               
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "เลขกรมธรรม์ พรบ.     "            '"' SKIP.     nv_column = nv_column + 1.      /*42*/                                  
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "วันที่บ.ประกันภัย รับแจ้งฯ"       '"' SKIP.     nv_column = nv_column + 1.      /*43*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "สาขาที่ของนิติบุคคล  "            '"' SKIP.     nv_column = nv_column + 1.      /*44*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "ชื่อผู้ขับขี่ คนที่ 2"            '"' SKIP.     nv_column = nv_column + 1.      /*45*/                               
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "เลขที่ผู้เสียภาษีอากร"            '"' SKIP.     nv_column = nv_column + 1.      /*46*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "เลขที่ใบขับขี่ คนที่ 2"           '"' SKIP.     nv_column = nv_column + 1.      /*47*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "Old Engine    "                   '"' SKIP.     nv_column = nv_column + 1.      /*48*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "Old Chasis    "                   '"' SKIP.     nv_column = nv_column + 1.      /*49*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "ชื่อ-สกุล     "                   '"' SKIP.     nv_column = nv_column + 1.      /*50*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "ที่อยู่ บรรทัดที่ 1   "           '"' SKIP.     nv_column = nv_column + 1.      /*51*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "ที่อยู่ บรรทัดที่ 2   "           '"' SKIP.     nv_column = nv_column + 1.      /*52*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "ที่อยู่ บรรทัดที่ 3   "           '"' SKIP.     nv_column = nv_column + 1.      /*53*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "ที่อยู่ บรรทัดที่ 4   "           '"' SKIP.     nv_column = nv_column + 1.      /*54*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "รหัสไปรษณีย์  "                   '"' SKIP.     nv_column = nv_column + 1.      /*55*/                               
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "Reserved 1    "                   '"' SKIP.     nv_column = nv_column + 1.      /*56*/                               
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "Reserved 2    "                   '"' SKIP.     nv_column = nv_column + 1.      /*57*/                               
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "Normal End coverage date      "   '"' SKIP.     nv_column = nv_column + 1.      /*58*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "Compulsory Endcoverage date  "    '"' SKIP.     nv_column = nv_column + 1.      /*59*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "Showroom Code "                   '"' SKIP.     nv_column = nv_column + 1.      /*60*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "Car year      "                   '"' SKIP.     nv_column = nv_column + 1.      /*61*/                                     
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "Renewal type  "                   '"' SKIP.     nv_column = nv_column + 1.      /*62*/                               
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "Reserved 5    "                   '"' SKIP.     nv_column = nv_column + 1.      /*63*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "ID card no./Registration no.  "   '"' SKIP.     nv_column = nv_column + 1.      /*64*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "Car Accessory "                   '"' SKIP.     nv_column = nv_column + 1.      /*65*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "Insurance Type"                   '"' SKIP.     nv_column = nv_column + 1.      /*66*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "Garage Type   "                   '"' SKIP.     nv_column = nv_column + 1.      /*67*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "ระบุผู้ขับขี่ "                   '"' SKIP.     nv_column = nv_column + 1.      /*68*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "ชื่อผู้ขับขี่ 1     "             '"' SKIP.     nv_column = nv_column + 1.      /*69*/                               
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "วันเดือนปีเกิด ผู้ขับขี่ 1    "   '"' SKIP.     nv_column = nv_column + 1.      /*70*/                                                       
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "เลขใบขับขี่ ผู้ขับขี่ 1       "   '"' SKIP.     nv_column = nv_column + 1.      /*71*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "ชื่อผู้ขับขี่ 2       "           '"' SKIP.     nv_column = nv_column + 1.      /*72*/                               
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "วันเดือนปีเกิด ผู้ขับขี่ 2    "   '"' SKIP.     nv_column = nv_column + 1.      /*73*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "เลขใบขับขี่ ผู้ขับขี่ 2 "         '"' SKIP.     nv_column = nv_column + 1.      /*74*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "รหัสลักษณะการใช้รถ  "             '"' SKIP.     nv_column = nv_column + 1.      /*75*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "ติด Deduct          "             '"' SKIP.     nv_column = nv_column + 1.      /*76*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "ทุนสลักหลังเพิ่ม    "             '"' SKIP.     nv_column = nv_column + 1.      /*77*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "เบี้ยสลักหลังเพิ่ม  "             '"' SKIP.     nv_column = nv_column + 1.      /*78*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "Dealer Code         "             '"' SKIP.     nv_column = nv_column + 1.      /*79*/                             
      /* PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  '"' SKIP.        nv_column = nv_column + 1.      /*80*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  '"' SKIP.        nv_column = nv_column + 1.      /*81*/                                                                   
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  '"' SKIP.        nv_column = nv_column + 1.      /*82*/                                                                   
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  '"' SKIP.        nv_column = nv_column + 1.      /*83*/                                                                   
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  '"' SKIP.        nv_column = nv_column + 1.      /*84*/                                                                   
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  '"' SKIP.        nv_column = nv_column + 1.      /*85*/                                                                   
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  '"' SKIP.        nv_column = nv_column + 1.      /*86*/                                                                   
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  '"' SKIP.        nv_column = nv_column + 1.      /*87*/                              
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  '"' SKIP.        nv_column = nv_column + 1.      /*88*/                                                                   
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  '"' SKIP.        nv_column = nv_column + 1.      /*89*/                                                                   
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  '"' SKIP.        nv_column = nv_column + 1.      /*90*/                                                                   
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  '"' SKIP.        nv_column = nv_column + 1.      /*91*/                                                                   
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  '"' SKIP.        nv_column = nv_column + 1.      /*92*/                                                                                                                                       
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  '"' SKIP.        nv_column = nv_column + 1.      /*93*/                                                                                                                                        
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  '"' SKIP.        nv_column = nv_column + 1.      /*94*/                                                                     
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  '"' SKIP.        nv_column = nv_column + 1.      /*95*/                                                                     
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  '"' SKIP.        nv_column = nv_column + 1.      /*96*/                                                                     
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  '"' SKIP.        nv_column = nv_column + 1.      /*97*/                                                                     
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  '"' SKIP.        nv_column = nv_column + 1.      /*98*/                                                                     
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  '"' SKIP.     */                                   /*99*/ 
       
       FOR EACH wdetail2 WHERE wdetail2.head = "D" NO-LOCK .   
            ASSIGN nv_column = 0
                   nv_column = nv_column + 1 
                   nv_row    = nv_row  + 1
                   nv_count  = nv_count + 1
                   n_length  = 0    
                   nv_length = "" .

            PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' string(nv_count) '"' SKIP. nv_column = nv_column + 1.
            
            IF trim(head) <> "" THEN n_length  = LENGTH(head). ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(head) FORMAT "x(" + string(n_length) + ")"  '"' SKIP.   /*1 */ 
            nv_column = nv_column + 1. 
            
            IF trim(comcode) <> "" THEN n_length  = LENGTH(comcode) . ELSE n_length = 0.    
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(comcode) FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  /*2 */
            nv_column = nv_column + 1. 
            
            IF trim(senddat) <> "" THEN n_length  = LENGTH(senddat) . ELSE n_length = 0.      
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(senddat)      FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  /*3 */
            nv_column = nv_column + 1.                                                                   
                                                                                                         
            IF trim(contractno) <> "" THEN n_length  = LENGTH(contractno) . ELSE n_length = 0.        
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(contractno)        FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  
            nv_column = nv_column + 1.   /*4 */                                                          
                                                                                                         
            IF trim(lotno) <> "" THEN n_length  = LENGTH(lotno) . ELSE n_length = 0.   
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(lotno)     FORMAT "x(" + STRING(n_length) + ")"     '"' SKIP.  
            nv_column = nv_column + 1.   /*5 */                                                          
                                                                                                         
            IF trim(seqno) <> "" THEN n_length  = LENGTH(seqno) . ELSE n_length = 0.  
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(seqno)     FORMAT "x(" + STRING(n_length) + ")"      '"' SKIP.  
            nv_column = nv_column + 1.   /*6 */                                                          
                                                                                                         
            IF trim(recact) <> "" THEN n_length  = LENGTH(recact) . ELSE n_length = 0. 
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(recact)     FORMAT "x(" + STRING(n_length) + ")"     '"' SKIP.  
            nv_column = nv_column + 1.   /*7 */                                                          
                                                                                                         
            IF trim(STATUSno) <> "" THEN n_length  = LENGTH(STATUSno) . ELSE n_length = 0.   
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(STATUSno)      FORMAT "x(" + STRING(n_length) + ")"      '"' SKIP.  
            nv_column = nv_column + 1.   /*8 */                                                          
                                                                                                         
            IF trim(flag) <> "" THEN n_length  = LENGTH(flag) . ELSE n_length = 0.    
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(flag)      FORMAT "x(" + STRING(n_length) + ")"      '"' SKIP.  
            nv_column = nv_column + 1.   /*9 */ 
            
            /*IF trim(ntitle) <> "" THEN n_length  = LENGTH(ntitle) . ELSE n_length = 0.                                                   
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(ntitle)         FORMAT "x(" + STRING(n_length) + ")"      '"' SKIP.  
            nv_column = nv_column + 1. */  /*10*/                                                                                                  
                                                                                                                                                 
            IF trim(insname) <> "" THEN n_length  = LENGTH(insname) . ELSE n_length = 0.                                                 
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(insname)      FORMAT "x(" + STRING(n_length) + ")"      '"' SKIP. 
            nv_column = nv_column + 1.   /*11*/                                                                                              
                                                                                                                                             
            IF trim(add1) <> "" THEN n_length  = LENGTH(add1) . ELSE n_length = 0.                                        
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(add1)  FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  
            nv_column = nv_column + 1.   /*12*/                                                                                              
                                                                                                                                             
            IF trim(add2) <> "" THEN n_length  = LENGTH(add2) . ELSE n_length = 0.                                   
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(add2) FORMAT "x(" + STRING(n_length) + ")"   '"' SKIP.  
            nv_column = nv_column + 1.   /*13*/                                                                                              
                                                                                                                                             
            IF trim(add3) <> "" THEN n_length  = LENGTH(add3) . ELSE n_length = 0.                                     
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(add3) FORMAT "x(" + STRING(n_length) + ")"   '"' SKIP.  
            nv_column = nv_column + 1.   /*14*/  
            
            IF trim(add4) <> "" THEN n_length  = LENGTH(add4) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(add4)  FORMAT "x(" + STRING(n_length) + ")"     '"' SKIP.  
            nv_column = nv_column + 1.   /*15*/  

            IF trim(add5) <> "" THEN n_length  = LENGTH(add5) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(add5)  FORMAT "x(" + STRING(n_length) + ")"       '"' SKIP.  
            nv_column = nv_column + 1.   /*16*/  

            IF trim(engno) <> "" THEN n_length  = LENGTH(engno) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(engno)   FORMAT "x(" + STRING(n_length) + ")"     '"' SKIP.  
            nv_column = nv_column + 1.   /*17*/  

            IF trim(chasno) <> "" THEN n_length  = LENGTH(chasno) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(chasno)   FORMAT "x(" + STRING(n_length) + ")"  '"' SKIP.  
            nv_column = nv_column + 1.   /*18*/  

            IF trim(brand) <> "" THEN n_length  = LENGTH(brand) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(brand)   FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  
            nv_column = nv_column + 1.   /*19*/ 
            
            IF trim(model) <> "" THEN n_length  = LENGTH(model) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(model) FORMAT "x(" + STRING(n_length) + ")"         '"' SKIP.  
            nv_column = nv_column + 1.   /*20*/

            IF trim(cc) <> "" THEN n_length  = LENGTH(cc) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(cc) FORMAT "x(" + STRING(n_length) + ")"              '"' SKIP.  
            nv_column = nv_column + 1.   /*21*/ 
            
            IF trim(COLORno) <> "" THEN n_length  = LENGTH(COLORno) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(COLORno)  FORMAT "x(" + STRING(n_length) + ")"          '"' SKIP.  
            nv_column = nv_column + 1.   /*22*/
            
            IF trim(reg1) <> "" THEN n_length  = LENGTH(reg1) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(reg1)  FORMAT "x(" + STRING(n_length) + ")"        '"' SKIP.  
            nv_column = nv_column + 1.   /*23*/ 

            IF trim(reg2) <> "" THEN n_length  = LENGTH(reg2) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(reg2) FORMAT "x(" + STRING(n_length) + ")"       '"' SKIP.  
            nv_column = nv_column + 1.   /*24*/

            IF trim(provinco) <> "" THEN n_length  = LENGTH(provinco) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(provinco) FORMAT "x(" + STRING(n_length) + ")"     '"' SKIP.  
            nv_column = nv_column + 1.   /*25*/
            
            IF trim(subinsco) <> "" THEN n_length  = LENGTH(subinsco) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(subinsco) FORMAT "x(" + STRING(n_length) + ")"          '"' SKIP.  
            nv_column = nv_column + 1.   /*26*/
    
            IF trim(covamount) <> "" THEN n_length  = LENGTH(covamount) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(covamount) FORMAT "x(" + STRING(n_length) + ")"  '"' SKIP.  
            nv_column = nv_column + 1.   /*27*/ 

            IF trim(grpssprem) <> "" THEN n_length  = LENGTH(grpssprem) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(grpssprem) FORMAT "x(" + STRING(n_length) + ")" '"' SKIP.  
            nv_column = nv_column + 1.   /*28*/

            IF trim(effecdat) <> "" THEN n_length  = LENGTH(effecdat) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(effecdat)   FORMAT "x(" + STRING(n_length) + ")"      '"' SKIP.  
            nv_column = nv_column + 1.   /*29*/

            IF trim(notifyno) <> "" THEN n_length  = LENGTH(notifyno) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(notifyno)   FORMAT "x(" + STRING(n_length) + ")"            '"' SKIP.  
            nv_column = nv_column + 1.   /*30*/

            IF trim(noticode) <> "" THEN n_length  = LENGTH(noticode) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(noticode) FORMAT "x(" + STRING(n_length) + ")"  '"' SKIP.  
            nv_column = nv_column + 1.   /*31*/

            IF trim(noticodesty) <> "" THEN n_length  = LENGTH(noticodesty) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(noticodesty)   FORMAT "x(" + STRING(n_length) + ")"   '"' SKIP.  
            nv_column = nv_column + 1.   /*32*/

            IF trim(notiname) <> "" THEN n_length  = LENGTH(notiname) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(notiname) FORMAT "x(" + STRING(n_length) + ")" '"' SKIP.  
            nv_column = nv_column + 1.   /*33*/ 
    
            IF trim(substyname) <> "" THEN n_length  = LENGTH(substyname) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(substyname)  FORMAT "x(" + STRING(n_length) + ")"   '"' SKIP.  
            nv_column = nv_column + 1.   /*34*/  
            
            IF trim(comamount) <> "" THEN n_length  = LENGTH(comamount) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(comamount)  FORMAT "x(" + STRING(n_length) + ")"          '"' SKIP.  
            nv_column = nv_column + 1.   /*35*/ 

            IF trim(comprem) <> "" THEN n_length  = LENGTH(comprem) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(comprem) FORMAT "x(" + STRING(n_length) + ")"      '"' SKIP.  
            nv_column = nv_column + 1.   /*36*/  

            IF trim(comeffecdat) <> "" THEN n_length  = LENGTH(comeffecdat) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(comeffecdat)  FORMAT "x(" + STRING(n_length) + ")"        '"' SKIP.  
            nv_column = nv_column + 1.   /*37*/  

            IF trim(compno) <> "" THEN n_length  = LENGTH(compno) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(compno)  FORMAT "x(" + STRING(n_length) + ")"        '"' SKIP.  
            nv_column = nv_column + 1.   /*38*/

            IF trim(recivno) <> "" THEN n_length  = LENGTH(recivno) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(recivno)  FORMAT "x(" + STRING(n_length) + ")"         '"' SKIP.  
            nv_column = nv_column + 1.   /*39*/ 

            IF trim(recivcode) <> "" THEN n_length  = LENGTH(recivcode) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(recivcode)  FORMAT "x(" + STRING(n_length) + ")"         '"' SKIP.  
            nv_column = nv_column + 1.   /*40*/

            IF trim(recivcosty) <> "" THEN n_length  = LENGTH(recivcosty) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(recivcosty) FORMAT "x(" + STRING(n_length) + ")"              '"' SKIP.  
            nv_column = nv_column + 1.   /*41*/ 

            IF trim(recivstynam) <> "" THEN n_length  = LENGTH(recivstynam) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(recivstynam)  FORMAT "x(" + STRING(n_length) + ")"     '"' SKIP.  
            nv_column = nv_column + 1.   /*42*/ 

            IF trim(comppol) <> "" THEN n_length  = LENGTH(comppol) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(comppol)  FORMAT "x(" + STRING(n_length) + ")"  '"' SKIP.  
            nv_column = nv_column + 1.   /*43*/ 

            IF trim(recivstydat) <> "" THEN n_length  = LENGTH(recivstydat) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(recivstydat)   FORMAT "x(" + STRING(n_length) + ")" '"' SKIP.  
            nv_column = nv_column + 1.   /*44*/                                                                                                                

            IF trim(drivnam1) <> "" THEN n_length  = LENGTH(drivnam1) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(drivnam1)   FORMAT "x(" + STRING(n_length) + ")"       '"' SKIP.  
            nv_column = nv_column + 1.   /*45*/                                                                                                                

            IF trim(drivnam2) <> "" THEN n_length  = LENGTH(drivnam2) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(drivnam2)   FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  
            nv_column = nv_column + 1.   /*46*/ 

            IF trim(drino1) <> "" THEN n_length  = LENGTH(drino1) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(drino1)  FORMAT "x(" + STRING(n_length) + ")"   '"' SKIP.  
            nv_column = nv_column + 1.   /*47*/                                                                                                             

            IF trim(drino2) <> "" THEN n_length  = LENGTH(drino2) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(drino2)  FORMAT "x(" + STRING(n_length) + ")" '"' SKIP.  
            nv_column = nv_column + 1.   /*48*/                                                                                                                

            IF trim(oldeng) <> "" THEN n_length  = LENGTH(oldeng) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(oldeng)  FORMAT "x(" + STRING(n_length) + ")"        '"' SKIP.  
            nv_column = nv_column + 1.   /*49*/                                                                                                                

            IF trim(oldchass) <> "" THEN n_length  = LENGTH(oldchass) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(oldchass)   FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  
            nv_column = nv_column + 1.   /*50*/ 

            IF trim(NAMEpay) <> "" THEN n_length  = LENGTH(NAMEpay) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(NAMEpay)  FORMAT "x(" + STRING(n_length) + ")"          '"' SKIP.  
            nv_column = nv_column + 1.   /*51*/

            IF trim(addpay1) <> "" THEN n_length  = LENGTH(addpay1) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(addpay1)  FORMAT "x(" + STRING(n_length) + ")"            '"' SKIP.  
            nv_column = nv_column + 1.   /*52*/ 

            IF trim(addpay2) <> "" THEN n_length  = LENGTH(addpay2) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(addpay2)  FORMAT "x(" + STRING(n_length) + ")"            '"' SKIP.  
            nv_column = nv_column + 1.   /*53*/ 

            IF trim(addpay3) <> "" THEN n_length  = LENGTH(addpay3) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(addpay3)  FORMAT "x(" + STRING(n_length) + ")"             '"' SKIP.  
            nv_column = nv_column + 1.   /*54*/ 

            IF trim(addpay4) <> "" THEN n_length  = LENGTH(addpay4) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(addpay4)  FORMAT "x(" + STRING(n_length) + ")"             '"' SKIP.  
            nv_column = nv_column + 1.   /*55*/ 
            
            IF trim(postpay) <> "" THEN n_length  = LENGTH(postpay) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(postpay)  FORMAT "x(" + STRING(n_length) + ")"     '"' SKIP.
            nv_column = nv_column + 1.   /*56*/

            IF trim(Reserved1) <> "" THEN n_length  = LENGTH(Reserved1) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(Reserved1)  FORMAT "x(" + STRING(n_length) + ")"        '"' SKIP.  
            nv_column = nv_column + 1.   /*57*/ 

            IF trim(Reserved2) <> "" THEN n_length  = LENGTH(Reserved2) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(Reserved2) FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  
            nv_column = nv_column + 1.   /*58*/

            IF trim(norcovdat) <> "" THEN n_length  = LENGTH(norcovdat) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(norcovdat)  FORMAT "x(" + STRING(n_length) + ")"             '"' SKIP.  
            nv_column = nv_column + 1.   /*59*/ 

            IF trim(norcovenddat) <> "" THEN n_length  = LENGTH(norcovenddat) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(norcovenddat)  FORMAT "x(" + STRING(n_length) + ")"  '"' SKIP.
            nv_column = nv_column + 1.   /*60*/ 

            IF trim(showroom) <> "" THEN n_length  = LENGTH(showroom) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(showroom)  FORMAT "x(" + STRING(n_length) + ")"  '"' SKIP.
            nv_column = nv_column + 1.   /*61*/  

            IF trim(caryear) <> "" THEN n_length  = LENGTH(caryear) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(caryear)   FORMAT "x(" + STRING(n_length) + ")"  '"' SKIP.  
            nv_column = nv_column + 1.   /*62*/ 

            IF trim(renewtyp) <> "" THEN n_length  = LENGTH(renewtyp) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(renewtyp)  FORMAT "x(" + STRING(n_length) + ")"   '"' SKIP.  
            nv_column = nv_column + 1.   /*63*/ 

            IF trim(Reserved5) <> "" THEN n_length  = LENGTH(Reserved5) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(Reserved5)   FORMAT "x(" + STRING(n_length) + ")"  '"' SKIP.  
            nv_column = nv_column + 1.   /*64*/ 

            IF trim(idno) <> "" THEN n_length  = LENGTH(idno) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(idno)   FORMAT "x(" + STRING(n_length) + ")"  '"' SKIP.  
            nv_column = nv_column + 1.   /*65*/ 

            IF trim(access) <> "" THEN n_length  = LENGTH(access) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(access)    FORMAT "x(" + STRING(n_length) + ")"  '"' SKIP.  
            nv_column = nv_column + 1.   /*66*/

            IF trim(covcod) <> "" THEN n_length  = LENGTH(covcod) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(covcod)    FORMAT "x(" + STRING(n_length) + ")"  '"' SKIP.  
            nv_column = nv_column + 1.   /*67*/

            IF trim(Garage) <> "" THEN n_length  = LENGTH(Garage) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(Garage)   FORMAT "x(" + STRING(n_length) + ")"   '"' SKIP.  
            nv_column = nv_column + 1.   /*68*/ 

            IF trim(Drivnam) <> "" THEN n_length  = LENGTH(Drivnam) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(Drivnam)   FORMAT "x(" + STRING(n_length) + ")"  '"' SKIP.  
            nv_column = nv_column + 1.   /*69*/ 

            IF trim(Driver1) <> "" THEN n_length  = LENGTH(Driver1) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(STRING(Driver1))   FORMAT "x(" + STRING(n_length) + ")"  '"' SKIP.  
            nv_column = nv_column + 1.   /*70*/

            IF trim(DrivDate1) <> "" THEN n_length  = LENGTH(DrivDate1) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(string(DrivDate1)) FORMAT "x(" + STRING(n_length) + ")"  '"' SKIP.  
            nv_column = nv_column + 1.   /*71*/ 

            IF trim(DrivLicense1) <> "" THEN n_length  = LENGTH(DrivLicense1) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(string(DrivLicense1))    FORMAT "x(" + STRING(n_length) + ")"  '"' SKIP.  
            nv_column = nv_column + 1.   /*72*/

            IF trim(Driver2) <> "" THEN n_length  = LENGTH(Driver2) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(string(Driver2))    FORMAT "x(" + STRING(n_length) + ")"   '"' SKIP.  
            nv_column = nv_column + 1.   /*73*/ 

            IF trim(DrivDate2) <> "" THEN n_length  = LENGTH(DrivDate2) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(string(DrivDate2))    FORMAT "x(" + STRING(n_length) + ")"  '"' SKIP.  
            nv_column = nv_column + 1.   /*74*/ 

            IF trim(DrivLicense2) <> "" THEN n_length  = LENGTH(DrivLicense2) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(string(DrivLicense2))   FORMAT "x(" + STRING(n_length) + ")" '"' SKIP.  
            nv_column = nv_column + 1.   /*75*/ 

            IF trim(sclass) <> "" THEN n_length  = LENGTH(sclass) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(string(sclass))   FORMAT "x(" + STRING(n_length) + ")" '"' SKIP.  
            nv_column = nv_column + 1.   /*76*/

            IF trim(Deduct) <> "" THEN n_length  = LENGTH(Deduct) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(string(Deduct))   FORMAT "x(" + STRING(n_length) + ")"  '"' SKIP.  
            nv_column = nv_column + 1.   /*77*/ 

            IF trim(EndorseSI) <> "" THEN n_length  = LENGTH(EndorseSI) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(string(EndorseSI))  FORMAT "x(" + STRING(n_length) + ")"  '"' SKIP.  
            nv_column = nv_column + 1.   /*78*/ 

            IF trim(EndorsePrm) <> "" THEN n_length  = LENGTH(EndorsePrm) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(string(EndorsePrm))  FORMAT "x(" + STRING(n_length) + ")"   '"' SKIP.  
            nv_column = nv_column + 1.   /*79*/ 

            IF trim(DealerCode) <> "" THEN n_length  = LENGTH(DealerCode) . ELSE n_length = 0.
            IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(string(DealerCode))  FORMAT "x(" + STRING(n_length) + ")" '"' SKIP.  
            nv_column = nv_column + 1.   /*80*/ 

            /*IF trim(string(OVFix)) <> "" THEN n_length  = LENGTH(string(OVFix)) . ELSE n_length = 0.
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
            nv_column = nv_column + 1.   /*99*/ */
        END.
    PUT STREAM ns1 "E" SKIP.
    OUTPUT STREAM ns1 CLOSE.
END.





