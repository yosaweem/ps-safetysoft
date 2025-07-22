/*----------------------------------------------------------------------------------*/
/*Program ID   : wgwmtscb3.i                                                        */
/*Program name : Match File Load and Update Data TLT                                */
/*create by    : Ranu i. A60-0488  date 16/10/2017 
                โปรแกรม match file สำหรับโหลดเข้า GW และ Match Policy no on TLT     */
/*Modify BY    : Kridtiya i. A64-0295 DATE. 25/07/2021  เพิ่มฟิล์                   */    
// Modify BY   : Tontawan S. A68-0059 27/03/2025        
//             : Add 35 FIELD for support EV     
/*----------------------------------------------------------------------------------*/       
/* ประกาศตัวแปร -*/
/*--------------------------สำหรับข้อมูลกรมธรรม์  -------------------------*/
DEFINE NEW SHARED WORKFILE wdetail NO-UNDO
    FIELD XRefNo1          AS CHAR FORMAT "X(50)"  INIT ""   /*เลขที่เอกสารอ้างอิง        */           
    FIELD Barcode          AS CHAR FORMAT "X(50)"  INIT ""   /*บาร์โค้ด                   */           
    FIELD InsuredName      AS CHAR FORMAT "X(225)" INIT ""   /*ชื่อบริษัทประกันภัย        */           
    FIELD PolicyNo         AS CHAR FORMAT "X(20)"  INIT ""   /*เลขที่กรมธรรม์             */           
    FIELD EndorseNo        AS CHAR FORMAT "X(20)"  INIT ""   /*เลขที่สลักหลัง             */           
    FIELD SumInsured       AS CHAR FORMAT "X(20)"  INIT ""   /*ทุนประกัน                  */
    FIELD sumfire          AS CHAR FORMAT "x(20)"  INIT ""   /* fire & theft */ /*A61-0228*/
    FIELD NetPremium       AS CHAR FORMAT "X(20)"  INIT ""   /*เบี้ยสุทธิ                 */           
    FIELD VatTax           AS CHAR FORMAT "X(10)"  INIT ""   /*ภาษีมูลค่าเพิ่ม            */           
    FIELD Stamp            AS CHAR FORMAT "X(10)"  INIT ""   /*อากร                       */           
    FIELD GrossPremium     AS CHAR FORMAT "X(20)"  INIT ""   /*เบี้ยรวม                   */           
    FIELD EffectiveDate    AS CHAR FORMAT "X(15)"  INIT ""   /*วันที่เริ่มคุ้มครอง        */           
    FIELD ExpireDate       AS CHAR FORMAT "X(15)"  INIT ""   /*วันที่สิ้นสุดความคุ้มครอง  */         
    FIELD EndorseReASon    AS CHAR FORMAT "X(350)" INIT ""   /*เหตุผลการสลักหลัง          */   
    FIELD trntyp           AS CHAR FORMAT "x(5)"   INIT ""   /* transtype */ /*a61-0228*/
    FIELD cmr_code         AS CHAR FORMAT "X(50)"  INIT ""   /*รหัสบริษัทประกันภัย */                                
    FIELD comp_code        AS CHAR FORMAT "X(50)"  INIT ""   /*ชื่อบริษัทประกันภัย */                             
    FIELD campcode         AS CHAR FORMAT "X(50)"  INIT ""   /*รหัสแคมเปญ          */                             
    FIELD campname         AS CHAR FORMAT "X(50)"  INIT ""   /*ชื่อแคมเปญ          */                             
    FIELD procode          AS CHAR FORMAT "X(50)"  INIT ""   /*รหัสผลิตภัณฑ์       */                             
    FIELD proname          AS CHAR FORMAT "X(50)"  INIT ""   /*ชื่อผลิตภัณฑ์ของประกันภัย*/                        
    FIELD packname         AS CHAR FORMAT "X(50)"  INIT ""   /*ชื่อแพคเกจ          */                             
    FIELD packcode         AS CHAR FORMAT "X(50)"  INIT ""   /*รหัสแพคเกจ          */                             
    FIELD instype          AS CHAR FORMAT "X(5)"   INIT ""   /*ประเภทผู้ถือกรมธรรม์*/                             
    FIELD pol_title        AS CHAR FORMAT "X(20)"  INIT ""   /*คำนำหน้าชื่อ ผู้ถือกรมธรรม์     */                 
    FIELD pol_fname        AS CHAR FORMAT "X(100)" INIT ""   /*ชื่อผู้เอาประกันผู้ถือกรมธรรม์  */                 
    FIELD pol_lname        AS CHAR FORMAT "X(100)" INIT ""   /*นามสกุลผู้เอาประกัน ผู้ถือกรมธรรม์   */            
    FIELD pol_title_eng    AS CHAR FORMAT "X(20)"  INIT ""   /*คำนำหน้าชื่อ ผู้ถือกรมธรรม์ ภาษาอังกฤษ */          
    FIELD pol_fname_eng    AS CHAR FORMAT "X(50)"  INIT ""   /*ชื่อภาษา อังกฤษ    */                              
    FIELD pol_lname_eng    AS CHAR FORMAT "X(50)"  INIT ""   /*นามสกุลภาษา อังกฤษ */                              
    FIELD icno             AS CHAR FORMAT "X(20)"  INIT ""   /*เลขที่บัตร         */                              
    FIELD sex              AS CHAR FORMAT "X(1) "  INIT ""   /*เพศ ผู้ถือกรมธรรม์ */                              
    FIELD bdate            AS CHAR FORMAT "X(10)"  INIT ""   /*วันเดือนปีเกิด ( DD/MM/YYYY) ผู้ถือกรมธรรม์ */     
    FIELD occup            AS CHAR FORMAT "X(50)"  INIT ""   /*อาชีพ ผู้ถือกรมธรรม์            */                 
    FIELD tel              AS CHAR FORMAT "X(20)"  INIT ""   /*โทรศัพท์-บ้าน-ผู้ถือกรมธรรม์    */                 
    FIELD phone            AS CHAR FORMAT "X(20)"  INIT ""   /*เบอร์ต่อโทรศัพท์-บ้าน-ผู้ถือกรมธรรม์ */            
    FIELD teloffic         AS CHAR FORMAT "X(20)"  INIT ""   /*โทรศัพท์-ที่ทำงาน ผู้ถือกรมธรรม์*/                 
    FIELD telext           AS CHAR FORMAT "X(20)"  INIT ""   /*เบอร์ต่อโทรศัพท์-ที่ทำงาน ผู้ถือกรมธรรม์   */      
    FIELD moblie           AS CHAR FORMAT "X(20)"  INIT ""   /*โทรศัพท์-มือถือ  ผู้ถือกรมธรรม์ */                 
    FIELD mobliech         AS CHAR FORMAT "X(20)"  INIT ""   /*โทรศัพท์-มือถือ  ในกรณีที่เปลี่ยนเบอร์มือถือ*/     
    FIELD mail             AS CHAR FORMAT "X(40)"  INIT ""   /*email-ผู้ถือกรมธรรม์ */                            
    FIELD lineid           AS CHAR FORMAT "X(100)" INIT ""   /*Line ID              */                            
    FIELD addr1_70         AS CHAR FORMAT "X(20)"  INIT ""   /*ที่อยู่ เลขที่บ้าน-ผู้ถือกรมธรรม์  */              
    FIELD addr2_70         AS CHAR FORMAT "X(100)" INIT ""   /*ที่อยู่ หมู่บ้าน - ผู้ถือกรมธรรม์  */              
    FIELD addr3_70         AS CHAR FORMAT "X(100)" INIT ""   /*ที่อยู่ หมู่-ผู้ถือกรมธรรม์     */                 
    FIELD addr4_70         AS CHAR FORMAT "X(100)" INIT ""   /*ที่อยู่ ตรอก ซอย-ผู้ถือกรมธรรม์ */                 
    FIELD addr5_70         AS CHAR FORMAT "X(40)"  INIT ""   /*ที่อยู่ ถนน-ผู้ถือกรมธรรม์      */                 
    FIELD nsub_dist70      AS CHAR FORMAT "X(20)"  INIT ""   /*ที่อยู่ รหัสแขวง-ผู้ถือกรมธรรม์ */                 
    FIELD ndirection70     AS CHAR FORMAT "X(20)"  INIT ""   /*ที่อยู่ เขต/อำเภอ-ผู้ถือกรมธรรม์*/                 
    FIELD nprovin70        AS CHAR FORMAT "X(20)"  INIT ""   /*ที่อยู่ จังหวัด-ผู้ถือกรมธรรม์  */                 
    FIELD zipcode70        AS CHAR FORMAT "X(10)"  INIT ""   /*ที่อยู่ รหัสไปรษณีย์-ผู้ถือกรมธรรม์        */      
    FIELD addr1_72         AS CHAR FORMAT "X(20)"  INIT ""   /*ที่อยู่ เลขที่บ้าน-ที่อยู่ในการจัดส่งเอกสาร*/      
    FIELD addr2_72         AS CHAR FORMAT "X(100)" INIT ""   /*ที่อยู่ หมู่บ้าน - ที่อยู่ในการจัดส่งเอกสาร*/      
    FIELD addr3_72         AS CHAR FORMAT "X(100)" INIT ""   /*ที่อยู่ หมู่-ที่อยู่ในการจัดส่งเอกสาร      */      
    FIELD addr4_72         AS CHAR FORMAT "X(100)" INIT ""   /*ที่อยู่ ตรอก ซอย-ที่อยู่ในการจัดส่งเอกสาร  */      
    FIELD addr5_72         AS CHAR FORMAT "X(40)"  INIT ""   /*ที่อยู่ ถนน-ที่อยู่ในการจัดส่งเอกสาร       */      
    FIELD nsub_dist72      AS CHAR FORMAT "X(20)"  INIT ""   /*ที่อยู่ รหัสแขวง-ที่อยู่ในการจัดส่งเอกสาร  */      
    FIELD ndirection72     AS CHAR FORMAT "X(20)"  INIT ""   /*ที่อยู่ เขต/อำเภอ-ที่อยู่ในการจัดส่งเอกสาร */      
    FIELD nprovin72        AS CHAR FORMAT "X(20)"  INIT ""   /*ที่อยู่ จังหวัด-ที่อยู่ในการจัดส่งเอกสาร   */      
    FIELD zipcode72        AS CHAR FORMAT "X(10)"  INIT ""   /*ที่อยู่ รหัสไปรษณีย์-ที่อยู่ในการจัดส่งเอกสาร */   
    FIELD paytype          AS CHAR FORMAT "X(1) "  INIT ""   /*ประเภท(บริษัท,บุคคล) ผู้จ่ายเงินกรมธรรม์*/         
    FIELD paytitle         AS CHAR FORMAT "X(20)"  INIT ""   /*คำนำหน้าชื่อเต็ม   ผู้จ่ายเงินกรมธรรม์  */         
    FIELD payname          AS CHAR FORMAT "X(100)" INIT ""   /*ชื่อผู้เอาประกัน   ผู้จ่ายเงินกรมธรรม์  */         
    FIELD paylname         AS CHAR FORMAT "X(100)" INIT ""   /*นามสกุลผู้เอาประกัน  ผู้จ่ายเงินกรมธรรม์*/         
    FIELD payicno          AS CHAR FORMAT "X(20)"  INIT ""   /*เลขที่บัตรประชาชนผู้เอาประกัน        */            
    FIELD payaddr1         AS CHAR FORMAT "X(10)"  INIT ""   /*ที่อยู่ เลขที่บ้าน-สำหรับออกใบเสร็จ  */            
    FIELD payaddr2         AS CHAR FORMAT "X(100)" INIT ""   /*ที่อยู่ หมู่บ้าน - สำหรับออกใบเสร็จ  */            
    FIELD payaddr3         AS CHAR FORMAT "X(100)" INIT ""   /*ที่อยู่ หมู่-สำหรับออกใบเสร็จ        */            
    FIELD payaddr4         AS CHAR FORMAT "X(100)" INIT ""   /*ที่อยู่ ตรอก ซอย-สำหรับออกใบเสร็จ    */            
    FIELD payaddr5         AS CHAR FORMAT "X(40)"  INIT ""   /*ที่อยู่ ถนน-สำหรับออกใบเสร็จ         */            
    FIELD payaddr6         AS CHAR FORMAT "X(20)"  INIT ""   /*ที่อยู่ แขวง-สำหรับออกใบเสร็จ        */            
    FIELD payaddr7         AS CHAR FORMAT "X(20)"  INIT ""   /*ที่อยู่ เขต/อำเภอ-สำหรับออกใบเสร็จ   */            
    FIELD payaddr8         AS CHAR FORMAT "X(20)"  INIT ""   /*ที่อยู่ จังหวัด-สำหรับออกใบเสร็จ     */            
    FIELD payaddr9         AS CHAR FORMAT "X(10)"  INIT ""   /*ที่อยู่ รหัสไปรษณีย์-สำหรับออกใบเสร็จ*/            
    FIELD branch           AS CHAR FORMAT "X(10)"  INIT ""   /*สำนักงานใหญ่หรือสาขา       */                      
    FIELD ben_title        AS CHAR FORMAT "X(10)"  INIT ""   /*คำนำหน้าชื่อ ผู้รับผลประโยชน์ */                   
    FIELD ben_name         AS CHAR FORMAT "X(50)"  INIT ""   /*ชื่อผู้รับผลประโยชน์          */                   
    FIELD ben_lname        AS CHAR FORMAT "X(50)"  INIT ""   /*นามสกุล ผู้รับผลประโยชน์      */    
    FIELD pmentcode        AS CHAR FORMAT "X(10)"  INIT ""   /*รหัสประเภทการชำระเบี้ยประกัน  */                   
    FIELD pmenttyp         AS CHAR FORMAT "X(20)"  INIT ""   /*ประเภทการชำระเบี้ยประกัน      */                   
    FIELD pmentcode1       AS CHAR FORMAT "X(20)"  INIT ""   /*รหัสช่องทางที่ชำระเบี้ย       */                   
    FIELD pmentcode2       AS CHAR FORMAT "X(50)"  INIT ""   /*ช่องทางที่ชำระค่าเบี้ย        */                   
    FIELD pmentbank        AS CHAR FORMAT "X(20)"  INIT ""   /*ธนาคารที่ชำระเบี้ย            */                   
    FIELD pmentdate        AS CHAR FORMAT "X(10)"  INIT ""   /*วันที่ชำระค่าเบี้ย            */                   
    FIELD pmentsts         AS CHAR FORMAT "X(10)"  INIT ""   /*สถานะการชำระเบี้ย             */                   
    FIELD driver           AS CHAR FORMAT "X(10)"  INIT ""   /*การระบุชื่อผู้ขับ             */                   
    FIELD drivetitle1      AS CHAR FORMAT "X(10)"  INIT ""   /*คำนำหน้าชื่อ ผู้ขับขี่ 1      */                   
    FIELD drivename1       AS CHAR FORMAT "X(50)"  INIT ""   /*ชื่อผู้ขับขี่ 1               */                   
    FIELD drivelname1      AS CHAR FORMAT "X(50)"  INIT ""   /*นามสกุล ผู้ขับขี่ 1           */                   
    FIELD driveno1         AS CHAR FORMAT "X(20)"  INIT ""   /*เลขที่บัตรประชาชนผู้ขับขี่ 1  */                   
    FIELD occupdriv1       AS CHAR FORMAT "X(30)"  INIT ""   /*Driver1Occupation             */                   
    FIELD sexdriv1         AS CHAR FORMAT "X(1) "  INIT ""   /*เพศ ผู้ขับขี่ 1               */                   
    FIELD bdatedriv1       AS CHAR FORMAT "X(10)"  INIT ""   /*วันเดือนปีเกิด ผู้ขับขี่ 1    */                   
    FIELD drivetitle2      AS CHAR FORMAT "X(10)"  INIT ""   /*คำนำหน้าชื่อ ผู้ขับขี่ 2      */                   
    FIELD drivename2       AS CHAR FORMAT "X(50)"  INIT ""   /*ชื่อผู้ขับขี่ 2               */                   
    FIELD drivelname2      AS CHAR FORMAT "X(50)"  INIT ""   /*นามสกุล ผู้ขับขี่ 2           */                   
    FIELD driveno2         AS CHAR FORMAT "X(20)"  INIT ""   /*เลขที่บัตรประชาชนผู้ขับขี่ 2  */                   
    FIELD occupdriv2       AS CHAR FORMAT "X(50)"  INIT ""   /*Driver2Occupation             */                   
    FIELD sexdriv2         AS CHAR FORMAT "X(1) "  INIT ""   /*เพศ ผู้ขับขี่ 2               */                   
    FIELD bdatedriv2       AS CHAR FORMAT "X(10)"  INIT ""   /*วันเดือนปีเกิด ผู้ขับขี่ 2    */                   
    FIELD chASsis          AS CHAR FORMAT "X(50)"  INIT ""  
    FIELD covcod           AS CHAR FORMAT "X(10)"  INIT "" 
    FIELD covtyp           AS CHAR FORMAT "X(20)"  INIT ""
    FIELD endorsedat       AS CHAR FORMAT "X(20)"  INIT ""
    /*-- Add By Tontawan S. A68-0059 27/03/2025 --*/
    FIELD drv3_salutation_M AS CHAR FORMAT "X(20)"  INIT ""  // คนขับ 3 : คำนำหน้า         
    FIELD drv3_fname        AS CHAR FORMAT "X(100)" INIT ""  // คนขับ 3 : ชื่อ             
    FIELD drv3_lname        AS CHAR FORMAT "X(100)" INIT ""  // คนขับ 3 : นามสกุล          
    FIELD drv3_nid          AS CHAR FORMAT "X(20)"  INIT ""  // คนขับ 3 : เลขบัตรประชาชน   
    FIELD drv3_occupation   AS CHAR FORMAT "X(50)"  INIT ""  // คนขับ 3 : อาชีพ            
    FIELD drv3_gender       AS CHAR FORMAT "X(10)"  INIT ""  // คนขับ 3 : เพศ              
    FIELD drv3_birthdate    AS CHAR FORMAT "X(10)"  INIT ""  // คนขับ 3 : วันเกิด          
    FIELD drv4_salutation_M AS CHAR FORMAT "X(20)"  INIT ""  // คนขับ 4 : คำนำหน้า         
    FIELD drv4_fname        AS CHAR FORMAT "X(100)" INIT ""  // คนขับ 4 : ชื่อ             
    FIELD drv4_lname        AS CHAR FORMAT "X(100)" INIT ""  // คนขับ 4 : นามสกุล          
    FIELD drv4_nid          AS CHAR FORMAT "X(20)"  INIT ""  // คนขับ 4 : เลขบัตรประชาชน   
    FIELD drv4_occupation   AS CHAR FORMAT "X(50)"  INIT ""  // คนขับ 4 : อาชีพ            
    FIELD drv4_gender       AS CHAR FORMAT "X(10)"  INIT ""  // คนขับ 4 : เพศ              
    FIELD drv4_birthdate    AS CHAR FORMAT "X(10)"  INIT ""  // คนขับ 4 : วันเกิด          
    FIELD drv5_salutation_M AS CHAR FORMAT "X(20)"  INIT ""  // คนขับ 5 : คำนำหน้า         
    FIELD drv5_fname        AS CHAR FORMAT "X(100)" INIT ""  // คนขับ 5 : ชื่อ             
    FIELD drv5_lname        AS CHAR FORMAT "X(100)" INIT ""  // คนขับ 5 : นามสกุล          
    FIELD drv5_nid          AS CHAR FORMAT "X(20)"  INIT ""  // คนขับ 5 : เลขบัตรประชาชน   
    FIELD drv5_occupation   AS CHAR FORMAT "X(50)"  INIT ""  // คนขับ 5 : อาชีพ            
    FIELD drv5_gender       AS CHAR FORMAT "X(10)"  INIT ""  // คนขับ 5 : เพศ              
    FIELD drv5_birthdate    AS CHAR FORMAT "X(10)"  INIT ""  // คนขับ 5 : วันเกิด          
    FIELD drv1_dlicense     AS CHAR FORMAT "X(50)"  INIT ""  // คนขับ 1 : ทะเบียนรถ        
    FIELD drv2_dlicense     AS CHAR FORMAT "X(50)"  INIT ""  // คนขับ 2 : ทะเบียนรถ        
    FIELD drv3_dlicense     AS CHAR FORMAT "X(50)"  INIT ""  // คนขับ 3 : ทะเบียนรถ        
    FIELD drv4_dlicense     AS CHAR FORMAT "X(50)"  INIT ""  // คนขับ 4 : ทะเบียนรถ        
    FIELD drv5_dlicense     AS CHAR FORMAT "X(50)"  INIT ""  // คนขับ 5 : ทะเบียนรถ        
    FIELD baty_snumber      AS CHAR FORMAT "X(20)"  INIT ""  // Battery : Serial Number    
    FIELD batydate          AS CHAR FORMAT "X(10)"  INIT ""  // Battery : Year             
    FIELD baty_rsi          AS CHAR FORMAT "X(20)"  INIT ""  // Battery : Replacement SI   
    FIELD baty_npremium     AS CHAR FORMAT "X(20)"  INIT ""  // Battery : Net Premium      
    FIELD baty_gpremium     AS CHAR FORMAT "X(20)"  INIT ""  // Battery : Gross_Premium    
    FIELD wcharge_snumber   AS CHAR FORMAT "X(20)"  INIT ""  // Wall Charge : Serial_Number
    FIELD wcharge_si        AS CHAR FORMAT "X(20)"  INIT ""  // Wall Charge : SI           
    FIELD wcharge_npremium  AS CHAR FORMAT "X(20)"  INIT ""  // Wall Charge : Net Premium  
    FIELD wcharge_gpremium  AS CHAR FORMAT "X(20)"  INIT "". // Wall Charge : Gross Premium
    /*-- End By Tontawan S. A68-0059 27/03/2025 --*/

DEFINE TEMP-TABLE wdetail2 NO-UNDO
    FIELD brand            AS CHAR FORMAT "X(50)"  INIT ""   /*ชื่อรถยนต์                    */      
    FIELD brand_cd         AS CHAR FORMAT "X(50)"  INIT ""   /*รหัสชื่อรถยนต์                */  
    FIELD Model            AS CHAR FORMAT "X(50)"  INIT ""   /*ชื่อรุ่นรถยนต์                */  
    FIELD Model_cd         AS CHAR FORMAT "X(50)"  INIT ""   /*รหัสชื่อรุ่นรถยนต์            */  
    FIELD body             AS CHAR FORMAT "X(50)"  INIT ""   /*แบบตัวถัง                     */  
    FIELD body_cd          AS CHAR FORMAT "X(50)"  INIT ""   /*รหัสแบบตัวถัง                 */  
    FIELD licence          AS CHAR FORMAT "X(50)"  INIT ""   /*ทะเบียนรถ                     */  
    FIELD province         AS CHAR FORMAT "X(50)"  INIT ""   /*จังหวัดที่จดทะเบียน           */  
    FIELD chASsis          AS CHAR FORMAT "X(50)"  INIT ""   /*เลขตัวถัง                     */  
    FIELD engine           AS CHAR FORMAT "X(50)"  INIT ""   /*เลขเครื่องยนต์                */  
    FIELD yrmanu           AS CHAR FORMAT "X(10)"  INIT ""   /*ปีจดทะเบียนรถ                 */  
    FIELD seatenew         AS CHAR FORMAT "X(10)"  INIT ""   /*จำนวนที่นั่ง                  */  
    FIELD power            AS CHAR FORMAT "X(10)"  INIT ""   /*ขนาดเครื่องยนต์               */  
    FIELD weight           AS CHAR FORMAT "X(10)"  INIT ""   /*น้ำหนัก                       */  
    FIELD clASs            AS CHAR FORMAT "X(10)"  INIT ""   /*รหัสการใช้รถยนต์              */  
    FIELD garage_cd        AS CHAR FORMAT "X(10)"  INIT ""   /*รหัสการซ่อม                   */  
    FIELD garage           AS CHAR FORMAT "X(10)"  INIT ""   /*ประเภทการซ่อม                 */  
    FIELD colorcode        AS CHAR FORMAT "X(20)"  INIT ""   /*สีรถยนต์                      */  
    FIELD covcod           AS CHAR FORMAT "X(10)"  INIT ""   /*รหัสประเภทของประกันภัย        */  
    FIELD covtyp           AS CHAR FORMAT "X(20)"  INIT ""   /*ประเภทของประกันภัย            */  
    FIELD covtyp1          AS CHAR FORMAT "X(50)"  INIT ""   /*ประเภทของความคุ้มครอง         */  
    FIELD covtyp2          AS CHAR FORMAT "X(50)"  INIT ""   /*ประเภทย่อยของความคุ้มครอง     */  
    FIELD covtyp3          AS CHAR FORMAT "X(50)"  INIT ""   /*รายละเอียดประเภทย่อยของความคุ้มครอง */ 
    FIELD comdat           AS CHAR FORMAT "X(20)"  INIT ""   /*วันเริ่มความคุ้มครอง          */       
    FIELD expdat           AS CHAR FORMAT "X(20)"  INIT ""   /*วันที่สิ้นสุดความคุ้มครอง     */       
    FIELD ins_amt          AS CHAR FORMAT "X(20)"  INIT ""   /*ทุนประกัน                     */       
    FIELD prem1            AS CHAR FORMAT "X(20)"  INIT ""   /*เบี้ยประกันตามความคุ้มครองหลัก*/       
    FIELD gross_prm        AS CHAR FORMAT "X(20)"  INIT ""   /*เบี้ยสุทธิหลังหักส่วนลด       */       
    FIELD stamp            AS CHAR FORMAT "X(20)"  INIT ""   /*จำนวนอากรสแตมป์               */       
    FIELD vat              AS CHAR FORMAT "X(20)"  INIT ""   /*จำนวนภาษี Vat                 */       
    FIELD premtotal        AS CHAR FORMAT "X(20)"  INIT ""   /*เบี้ยรวม ภาษี-อากร            */       
    FIELD deduct           AS CHAR FORMAT "X(20)"  INIT ""   /*ค่าความเสียหายส่วนแรก         */       
    FIELD fleetper         AS CHAR FORMAT "X(20)"  INIT ""   /*% ส่วนลดกลุ่ม                 */       
    FIELD fleet            AS CHAR FORMAT "X(20)"  INIT ""   /*จำนวนส่วนลดกลุ่ม              */       
    FIELD ncbper           AS CHAR FORMAT "X(20)"  INIT ""   /*% ส่วนลดประวัติดี             */       
    FIELD ncb              AS CHAR FORMAT "X(20)"  INIT ""   /*จำนวนส่วนลดประวัติดี          */       
    FIELD drivper          AS CHAR FORMAT "X(20)"  INIT ""   /*% ส่วนลดกรณีระบุชื่อผู้ขับขี่ */       
    FIELD drivdis          AS CHAR FORMAT "X(20)"  INIT ""   /*จำนวนส่วนลดกรณีระบุชื่อผู้ขับขี่ */    
    FIELD othper           AS CHAR FORMAT "X(20)"  INIT ""   /*%สวนลดอื่นๆ        */       
    FIELD oth              AS CHAR FORMAT "X(20)"  INIT ""   /*จำนวนส่วนลดอื่นๆ   */       
    FIELD cctvper          AS CHAR FORMAT "X(20)"  INIT ""   /*%สวนลดกล้อง        */       
    FIELD cctv             AS CHAR FORMAT "X(20)"  INIT ""   /*จำนวนส่วนลดกล้อง   */       
    FIELD Surcharper       AS CHAR FORMAT "X(20)"  INIT ""   /*%ส่วนลดเพิ่ม       */       
    FIELD Surchar          AS CHAR FORMAT "X(20)"  INIT ""   /*จำนวนส่วนลดเพิ่ม   */       
    FIELD Surchardetail    AS CHAR FORMAT "X(20)"  INIT ""   /*รายละเอียดส่วนเพิ่ม*/       
    FIELD acc1             AS CHAR FORMAT "X(50)"  INIT ""   /*รหัส อุปกรณ์ เพิ่มเติม 1 */       
    FIELD accdetail1       AS CHAR FORMAT "X(500)" INIT ""   /*รายละเอียดเพิ่มเติม 1    */       
    FIELD accprice1        AS CHAR FORMAT "X(10)"  INIT ""   /*ราคาอุปกรณ์ เพิ่มเติม 1*/
    FIELD acc2             AS CHAR FORMAT "X(50)"  INIT ""   /*รหัส อุปกรณ์ เพิ่มเติม 2 */       
    FIELD accdetail2       AS CHAR FORMAT "X(500)" INIT ""   /*รายละเอียดเพิ่มเติม 2    */       
    FIELD accprice2        AS CHAR FORMAT "X(10)"  INIT ""   /*ราคาอุปกรณ์ เพิ่มเติม 2*/
    FIELD acc3             AS CHAR FORMAT "X(50)"  INIT ""   /*รหัส อุปกรณ์ เพิ่มเติม 3 */       
    FIELD accdetail3       AS CHAR FORMAT "X(500)" INIT ""   /*รายละเอียดเพิ่มเติม 3    */       
    FIELD accprice3        AS CHAR FORMAT "X(10)"  INIT ""   /*ราคาอุปกรณ์ เพิ่มเติม 3*/
    FIELD acc4             AS CHAR FORMAT "X(50)"  INIT ""   /*รหัส อุปกรณ์ เพิ่มเติม 4 */       
    FIELD accdetail4       AS CHAR FORMAT "X(500)" INIT ""   /*รายละเอียดเพิ่มเติม 4    */       
    FIELD accprice4        AS CHAR FORMAT "X(10)"  INIT ""   /*ราคาอุปกรณ์ เพิ่มเติม 4*/
    FIELD acc5             AS CHAR FORMAT "X(50)"  INIT ""   /*รหัส อุปกรณ์ เพิ่มเติม 5 */          
    FIELD accdetail5       AS CHAR FORMAT "X(500)" INIT ""   /*รายละเอียดเพิ่มเติม 5    */          
    FIELD accprice5        AS CHAR FORMAT "X(10)"  INIT ""   /*ราคาอุปกรณ์ เพิ่มเติม 5*/
    FIELD inspdate         AS CHAR FORMAT "X(10)"  INIT ""   /*วันที่ตรวจสภาพรถ         */          
    FIELD inspdate_app     AS CHAR FORMAT "X(10)"  INIT ""   /*วันที่อนุมัติผลการตรวจสภาพรถ  */          
    FIELD inspsts          AS CHAR FORMAT "X(10)"  INIT ""   /*ผลการตรวจสภาพรถ        */          
    FIELD inspdetail       AS CHAR FORMAT "X(500)" INIT ""   /*รายละเอียดการตรวจสภาพรถ*/          
    FIELD not_date         AS CHAR FORMAT "X(10)"  INIT ""   /*วันที่ขาย              */          
    FIELD paydate          AS CHAR FORMAT "X(10)"  INIT ""   /*วันที่รับชำระเงิน      */          
    FIELD paysts           AS CHAR FORMAT "X(10)"  INIT ""   /*สถานะการจ่ายเงิน       */          
    FIELD licenBroker      AS CHAR FORMAT "X(20)"  INIT ""   /*เลขที่ใบอนุญาตนายหน้า (SCBPT) */          
    FIELD brokname         AS CHAR FORMAT "X(20)"  INIT ""   /*ชื่อบริษัทนายหน้า (SCBPT) */          
    FIELD brokcode         AS CHAR FORMAT "X(10)"  INIT ""   /*รหัสโบรคเกอร์ */          
    FIELD lang             AS CHAR FORMAT "X(20)"  INIT ""   /*ภาษา*/                    
    FIELD deli             AS CHAR FORMAT "X(50)"  INIT ""   /*ช่องทางการจัดส่ง     */   
    FIELD delidetail       AS CHAR FORMAT "X(100)" INIT ""   /*รายละเอียดการจัดส่ง  */   
    FIELD gift             AS CHAR FORMAT "X(100)" INIT ""   /*ของแถม  */                
    FIELD cedcode          AS CHAR FORMAT "X(20)"  INIT ""   /*เลขที่อ้างอิง  */         
    FIELD inscode          AS CHAR FORMAT "X(20)"  INIT ""   /*รหัสลูกค้า */             
    FIELD remark           AS CHAR FORMAT "X(500)" INIT ""   /*หมายเหตุ   */
    FIELD pASs             AS CHAR FORMAT "x(2)"   INIT ""   /* update */ 
    FIELD ben_2title       AS CHAR FORMAT "X(10)"  INIT ""   /*คำนำหน้าชื่อ ผู้รับผลประโยชน์ */                   
    FIELD ben_2name        AS CHAR FORMAT "X(50)"  INIT ""   /*ชื่อผู้รับผลประโยชน์          */                   
    FIELD ben_2lname       AS CHAR FORMAT "X(50)"  INIT ""   /*นามสกุล ผู้รับผลประโยชน์      */   
    FIELD ben_3title       AS CHAR FORMAT "X(10)"  INIT ""   /*คำนำหน้าชื่อ ผู้รับผลประโยชน์ */                   
    FIELD ben_3name        AS CHAR FORMAT "X(50)"  INIT ""   /*ชื่อผู้รับผลประโยชน์          */                   
    FIELD ben_3lname       AS CHAR FORMAT "X(50)"  INIT ""   /*นามสกุล ผู้รับผลประโยชน์      */
    FIELD Agent_Code       AS CHAR FORMAT "X(100)" INIT ""   /*Kridtiya i. A64-0295 DATE. 25/07/2021*/    
    FIELD Agent_Name_TH    AS CHAR FORMAT "X(255)" INIT ""   /*Kridtiya i. A64-0295 DATE. 25/07/2021*/    
    FIELD Agent_Name_Eng   AS CHAR FORMAT "X(255)" INIT ""   /*Kridtiya i. A64-0295 DATE. 25/07/2021*/    
    FIELD Selling_Channel  AS CHAR FORMAT "X(50)"  INIT ""    /*Kridtiya i. A64-0295 DATE. 25/07/2021*/
    FIELD Send_Policy_Date AS CHAR FORMAT "X(255)" INIT ""  
    FIELD Tracking_Number  AS CHAR FORMAT "X(255)" INIT ""  
    FIELD Yes_File_Date    AS CHAR FORMAT "X(255)" INIT ""  
    FIELD Policy_Status    AS CHAR FORMAT "X(255)" INIT ""  
    FIELD Policy_Year      AS CHAR FORMAT "X(255)" INIT "" 
    FIELD comdat_old       AS CHAR FORMAT "X(20)"  INIT ""   /*วันเริ่มความคุ้มครอง          */       
    FIELD expdat_old       AS CHAR FORMAT "X(20)"  INIT ""   /*วันที่สิ้นสุดความคุ้มครอง     */       
    FIELD ins_amt_old      AS CHAR FORMAT "X(20)"  INIT ""   /*ทุนประกัน                     */       
    FIELD prem1_old        AS CHAR FORMAT "X(20)"  INIT ""   /*เบี้ยประกันตามความคุ้มครองหลัก*/       
    FIELD gross_prm_old    AS CHAR FORMAT "X(20)"  INIT ""   /*เบี้ยสุทธิหลังหักส่วนลด       */       
    FIELD stamp_old        AS CHAR FORMAT "X(20)"  INIT ""   /*จำนวนอากรสแตมป์               */       
    FIELD vat_old          AS CHAR FORMAT "X(20)"  INIT ""   /*จำนวนภาษี Vat                 */       
    FIELD premtotal_old    AS CHAR FORMAT "X(20)"  INIT ""   /*เบี้ยรวม ภาษี-อากร            */
    .                                              

DEF VAR nv_titlematch      AS CHAR FORMAT "X(50)"  INIT "".
DEF VAR nv_fnamematch      AS CHAR FORMAT "X(150)" INIT "".
DEF VAR nv_lnamematch      AS CHAR FORMAT "X(150)" INIT "".
DEF VAR nv_dedod           AS DECI. 
DEF VAR nv_dedod1          AS DECI. 
DEF VAR nv_dedod2          AS DECI. 
DEF VAR ut_netprm2         AS DECI. 
DEF VAR ut_netprm1         AS DECI. 

/*-- Add By Tontawan S. A68-0059 27/03/2025 --*/
DEF VAR n_drv3_salutation_M AS CHAR FORMAT "X(20)"  INIT "". // คนขับ 3 : คำนำหน้า
DEF VAR n_drv3_fname        AS CHAR FORMAT "X(100)" INIT "". // คนขับ 3 : ชื่อ
DEF VAR n_drv3_lname        AS CHAR FORMAT "X(100)" INIT "". // คนขับ 3 : นามสกุล
DEF VAR n_drv3_nid          AS CHAR FORMAT "X(20)"  INIT "". // คนขับ 3 : เลขบัตรประชาชน
DEF VAR n_drv3_occupation   AS CHAR FORMAT "X(50)"  INIT "". // คนขับ 3 : อาชีพ
DEF VAR n_drv3_gender       AS CHAR FORMAT "X(10)"  INIT "". // คนขับ 3 : เพศ
DEF VAR n_drv3_birthdate    AS CHAR FORMAT "X(10)"  INIT "". // คนขับ 3 : วันเกิด
DEF VAR n_drv4_salutation_M AS CHAR FORMAT "X(20)"  INIT "". // คนขับ 4 : คำนำหน้า      
DEF VAR n_drv4_fname        AS CHAR FORMAT "X(100)" INIT "". // คนขับ 4 : ชื่อ          
DEF VAR n_drv4_lname        AS CHAR FORMAT "X(100)" INIT "". // คนขับ 4 : นามสกุล       
DEF VAR n_drv4_nid          AS CHAR FORMAT "X(20)"  INIT "". // คนขับ 4 : เลขบัตรประชาชน
DEF VAR n_drv4_occupation   AS CHAR FORMAT "X(50)"  INIT "". // คนขับ 4 : อาชีพ         
DEF VAR n_drv4_gender       AS CHAR FORMAT "X(10)"  INIT "". // คนขับ 4 : เพศ           
DEF VAR n_drv4_birthdate    AS CHAR FORMAT "X(10)"  INIT "". // คนขับ 4 : วันเกิด       
DEF VAR n_drv5_salutation_M AS CHAR FORMAT "X(20)"  INIT "". // คนขับ 5 : คำนำหน้า      
DEF VAR n_drv5_fname        AS CHAR FORMAT "X(100)" INIT "". // คนขับ 5 : ชื่อ          
DEF VAR n_drv5_lname        AS CHAR FORMAT "X(100)" INIT "". // คนขับ 5 : นามสกุล       
DEF VAR n_drv5_nid          AS CHAR FORMAT "X(20)"  INIT "". // คนขับ 5 : เลขบัตรประชาชน
DEF VAR n_drv5_occupation   AS CHAR FORMAT "X(50)"  INIT "". // คนขับ 5 : อาชีพ         
DEF VAR n_drv5_gender       AS CHAR FORMAT "X(10)"  INIT "". // คนขับ 5 : เพศ           
DEF VAR n_drv5_birthdate    AS CHAR FORMAT "X(10)"  INIT "". // คนขับ 5 : วันเกิด       
DEF VAR n_drv1_dlicense     AS CHAR FORMAT "X(50)"  INIT "". // คนขับ 1 : ทะเบียนรถ
DEF VAR n_drv2_dlicense     AS CHAR FORMAT "X(50)"  INIT "". // คนขับ 2 : ทะเบียนรถ
DEF VAR n_drv3_dlicense     AS CHAR FORMAT "X(50)"  INIT "". // คนขับ 3 : ทะเบียนรถ
DEF VAR n_drv4_dlicense     AS CHAR FORMAT "X(50)"  INIT "". // คนขับ 4 : ทะเบียนรถ
DEF VAR n_drv5_dlicense     AS CHAR FORMAT "X(50)"  INIT "". // คนขับ 5 : ทะเบียนรถ
DEF VAR n_baty_snumber      AS CHAR FORMAT "X(20)"  INIT "". // Battery : Serial Number
DEF VAR n_batydate          AS CHAR FORMAT "X(10)"  INIT "". // Battery : Year
DEF VAR n_baty_rsi          AS CHAR FORMAT "X(20)"  INIT "". // Battery : Replacement SI
DEF VAR n_baty_npremium     AS CHAR FORMAT "X(20)"  INIT "". // Battery : Net Premium
DEF VAR n_baty_gpremium     AS CHAR FORMAT "X(20)"  INIT "". // Battery : Gross_Premium
DEF VAR n_wcharge_snumber   AS CHAR FORMAT "X(20)"  INIT "". // Wall Charge : Serial_Number 
DEF VAR n_wcharge_si        AS CHAR FORMAT "X(20)"  INIT "". // Wall Charge : SI            
DEF VAR n_wcharge_npremium  AS CHAR FORMAT "X(20)"  INIT "". // Wall Charge : Net Premium
DEF VAR n_wcharge_gpremium  AS CHAR FORMAT "X(20)"  INIT "". // Wall Charge : Gross Premium
/*-- End By Tontawan S. A68-0059 27/03/2025 --*/


    
     
 
 
 
 
 
 






