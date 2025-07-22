&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          brstat           PROGRESS
*/
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*----------------------------------------------------------------------*/
/*          This .W file was created with the Progress UIB.             */
/*----------------------------------------------------------------------*/
/* Create an unnamed pool to store all the widgets created 
by this procedure. This is a good default which assures
that this procedure's triggers and internal procedures 
will execute in this procedure's storage, and that proper
cleanup will occur on deletion of the procedure. */
CREATE WIDGET-POOL.
/* ***************************  Definitions  ************************** */
/* wgwimscb.w : Import noitfy and Inspection file on table tlt( brstat)  
   Program Import Text File - File detail notify - File detail Inspection 
Create  By   : Ranu I. A60-0448 Date 16/10/2017
copy program : wuwimscb.w  
Connect      : GW_SAFE -LD SIC_BRAN, GW_STAT -LD BRSTAT ,SICSYAC  ,SICUW (not connect dbstat)*/
/*----------------------------------------------------------------------*/
/* modyfy by : Ranu I. A61-0228 Date 17/05/2018  แก้ไข producer / agent code = B3M0051 */
/* Modify By : Tontawan S. A66-0006 25/05/2023 
             : เพิ่มเช็ค Error Chassis เป็นค่าว่างจะแจ้ง Message Error 
             : เพิ่มเช็คการระบุผู้ขับขี่ใหม่ ให้แปลงค่าเป็นตัวเลข       */
/* Modify By : Tontawan S. A68-0059 27/03/2025
             : Add 35 Field for support EV                              */
/*----------------------------------------------------------------------*/
/* Parameters Definitions ---     */
/* Local Variable Definitions --- */
{wgw\wgwimscb.i}
DEF     SHARED VAR n_User    AS CHAR.  /*A60-0118*/
DEF     SHARED VAR n_Passwd  AS CHAR.  /*A60-0118*/
DEFINE VAR nv_daily       AS CHARACTER FORMAT "X(1024)"     INITIAL ""  NO-UNDO.
DEFINE VAR nv_reccnt      AS INT  INIT  0.
DEFINE VAR nv_dri_cnt     AS INT  INIT  0.
DEFINE VAR nv_completecnt AS INT  INIT  0.
DEFINE VAR nv_updatecnt   AS INT  INIT  0.
DEFINE VAR nv_dri_complet AS INT  INIT  0.
DEFINE VAR nv_enttim      AS CHAR INIT  "".
DEFINE VAR nv_Load        AS LOGIC INIT   YES.
DEF    VAR nv_type        AS CHAR FORMAT "x(5)" INIT "".
/*--------------------------สำหรับข้อมูลกรมธรรม์  ------------------------- 
DEFINE TEMP-TABLE wdetail NO-UNDO
    field cmr_code      as CHAR FORMAT "X(50)"     init ""   /*รหัสบริษัทประกันภัย */                                
    field comp_code     as CHAR FORMAT "X(50)"     init ""   /*ชื่อบริษัทประกันภัย */                             
    field campcode      as CHAR FORMAT "X(50)"     init ""   /*รหัสแคมเปญ          */                             
    field campname      as CHAR FORMAT "X(50)"     init ""   /*ชื่อแคมเปญ          */                             
    field procode       as CHAR FORMAT "X(50)"     init ""   /*รหัสผลิตภัณฑ์       */                             
    field proname       as CHAR FORMAT "X(50)"     init ""   /*ชื่อผลิตภัณฑ์ของประกันภัย*/                        
    field packname      as CHAR FORMAT "X(50)"     init ""   /*ชื่อแพคเกจ          */                             
    field packcode      as CHAR FORMAT "X(50)"     init ""   /*รหัสแพคเกจ          */                             
    field instype       as CHAR FORMAT "X(5)"      init ""   /*ประเภทผู้ถือกรมธรรม์*/                             
    field pol_title     as CHAR FORMAT "X(20)"     init ""   /*คำนำหน้าชื่อ ผู้ถือกรมธรรม์     */                 
    field pol_fname     as CHAR FORMAT "X(100)"    init ""   /*ชื่อผู้เอาประกันผู้ถือกรมธรรม์  */                 
    field pol_lname     as CHAR FORMAT "X(100)"    init ""   /*นามสกุลผู้เอาประกัน ผู้ถือกรมธรรม์   */            
    field pol_title_eng as CHAR FORMAT "X(20)"     init ""   /*คำนำหน้าชื่อ ผู้ถือกรมธรรม์ ภาษาอังกฤษ */          
    field pol_fname_eng as CHAR FORMAT "X(50)"     init ""   /*ชื่อภาษา อังกฤษ    */                              
    field pol_lname_eng as CHAR FORMAT "X(50)"     init ""   /*นามสกุลภาษา อังกฤษ */                              
    field icno          as CHAR FORMAT "X(20)"     init ""   /*เลขที่บัตร         */                              
    field sex           as CHAR FORMAT "X(1) "     init ""   /*เพศ ผู้ถือกรมธรรม์ */                              
    field bdate         as CHAR FORMAT "X(10)"     init ""   /*วันเดือนปีเกิด ( DD/MM/YYYY) ผู้ถือกรมธรรม์ */     
    field occup         as CHAR FORMAT "X(50)"     init ""   /*อาชีพ ผู้ถือกรมธรรม์            */                 
    field tel           as CHAR FORMAT "X(20)"     init ""   /*โทรศัพท์-บ้าน-ผู้ถือกรมธรรม์    */                 
    field phone         as CHAR FORMAT "X(20)"     init ""   /*เบอร์ต่อโทรศัพท์-บ้าน-ผู้ถือกรมธรรม์ */            
    field teloffic      as CHAR FORMAT "X(20)"     init ""   /*โทรศัพท์-ที่ทำงาน ผู้ถือกรมธรรม์*/                 
    field telext        as CHAR FORMAT "X(20)"     init ""   /*เบอร์ต่อโทรศัพท์-ที่ทำงาน ผู้ถือกรมธรรม์   */      
    field moblie        as CHAR FORMAT "X(20)"     init ""   /*โทรศัพท์-มือถือ  ผู้ถือกรมธรรม์ */                 
    field mobliech      as CHAR FORMAT "X(20)"     init ""   /*โทรศัพท์-มือถือ  ในกรณีที่เปลี่ยนเบอร์มือถือ*/     
    field mail          as CHAR FORMAT "X(40)"     init ""   /*email-ผู้ถือกรมธรรม์ */                            
    field lineid        as CHAR FORMAT "X(100)"    init ""   /*Line ID              */                            
    field addr1_70      as CHAR FORMAT "X(20)"     init ""   /*ที่อยู่ เลขที่บ้าน-ผู้ถือกรมธรรม์  */              
    field addr2_70      as CHAR FORMAT "X(100)"    init ""   /*ที่อยู่ หมู่บ้าน - ผู้ถือกรมธรรม์  */              
    field addr3_70      as CHAR FORMAT "X(100)"    init ""   /*ที่อยู่ หมู่-ผู้ถือกรมธรรม์     */                 
    field addr4_70      as CHAR FORMAT "X(100)"    init ""   /*ที่อยู่ ตรอก ซอย-ผู้ถือกรมธรรม์ */                 
    field addr5_70      as CHAR FORMAT "X(40)"     init ""   /*ที่อยู่ ถนน-ผู้ถือกรมธรรม์      */                 
    field nsub_dist70   as CHAR FORMAT "X(20)"     init ""   /*ที่อยู่ รหัสแขวง-ผู้ถือกรมธรรม์ */                 
    field ndirection70  as CHAR FORMAT "X(20)"     init ""   /*ที่อยู่ เขต/อำเภอ-ผู้ถือกรมธรรม์*/                 
    field nprovin70     as CHAR FORMAT "X(20)"     init ""   /*ที่อยู่ จังหวัด-ผู้ถือกรมธรรม์  */                 
    field zipcode70     as CHAR FORMAT "X(10)"     init ""   /*ที่อยู่ รหัสไปรษณีย์-ผู้ถือกรมธรรม์        */      
    field addr1_72      as CHAR FORMAT "X(20)"     init ""   /*ที่อยู่ เลขที่บ้าน-ที่อยู่ในการจัดส่งเอกสาร*/      
    field addr2_72      as CHAR FORMAT "X(100)"    init ""   /*ที่อยู่ หมู่บ้าน - ที่อยู่ในการจัดส่งเอกสาร*/      
    field addr3_72      as CHAR FORMAT "X(100)"    init ""   /*ที่อยู่ หมู่-ที่อยู่ในการจัดส่งเอกสาร      */      
    field addr4_72      as CHAR FORMAT "X(100)"    init ""   /*ที่อยู่ ตรอก ซอย-ที่อยู่ในการจัดส่งเอกสาร  */      
    field addr5_72      as CHAR FORMAT "X(40)"     init ""   /*ที่อยู่ ถนน-ที่อยู่ในการจัดส่งเอกสาร       */      
    field nsub_dist72   as CHAR FORMAT "X(20)"     init ""   /*ที่อยู่ รหัสแขวง-ที่อยู่ในการจัดส่งเอกสาร  */      
    field ndirection72  as CHAR FORMAT "X(20)"     init ""   /*ที่อยู่ เขต/อำเภอ-ที่อยู่ในการจัดส่งเอกสาร */      
    field nprovin72     as CHAR FORMAT "X(20)"     init ""   /*ที่อยู่ จังหวัด-ที่อยู่ในการจัดส่งเอกสาร   */      
    field zipcode72     as CHAR FORMAT "X(10)"     init ""   /*ที่อยู่ รหัสไปรษณีย์-ที่อยู่ในการจัดส่งเอกสาร */   
    field paytype       as CHAR FORMAT "X(1) "     init ""   /*ประเภท(บริษัท,บุคคล) ผู้จ่ายเงินกรมธรรม์*/         
    field paytitle      as CHAR FORMAT "X(20)"     init ""   /*คำนำหน้าชื่อเต็ม   ผู้จ่ายเงินกรมธรรม์  */         
    field payname       as CHAR FORMAT "X(100)"    init ""   /*ชื่อผู้เอาประกัน   ผู้จ่ายเงินกรมธรรม์  */         
    field paylname      as CHAR FORMAT "X(100)"    init ""   /*นามสกุลผู้เอาประกัน  ผู้จ่ายเงินกรมธรรม์*/         
    field payicno       as CHAR FORMAT "X(20)"     init ""   /*เลขที่บัตรประชาชนผู้เอาประกัน        */            
    field payaddr1      as CHAR FORMAT "X(10)"     init ""   /*ที่อยู่ เลขที่บ้าน-สำหรับออกใบเสร็จ  */            
    field payaddr2      as CHAR FORMAT "X(100)"    init ""   /*ที่อยู่ หมู่บ้าน - สำหรับออกใบเสร็จ  */            
    field payaddr3      as CHAR FORMAT "X(100)"    init ""   /*ที่อยู่ หมู่-สำหรับออกใบเสร็จ        */            
    field payaddr4      as CHAR FORMAT "X(100)"    init ""   /*ที่อยู่ ตรอก ซอย-สำหรับออกใบเสร็จ    */            
    field payaddr5      as CHAR FORMAT "X(40)"     init ""   /*ที่อยู่ ถนน-สำหรับออกใบเสร็จ         */            
    field payaddr6      as CHAR FORMAT "X(20)"     init ""   /*ที่อยู่ แขวง-สำหรับออกใบเสร็จ        */            
    field payaddr7      as CHAR FORMAT "X(20)"     init ""   /*ที่อยู่ เขต/อำเภอ-สำหรับออกใบเสร็จ   */            
    field payaddr8      as CHAR FORMAT "X(20)"     init ""   /*ที่อยู่ จังหวัด-สำหรับออกใบเสร็จ     */            
    field payaddr9      as CHAR FORMAT "X(10)"     init ""   /*ที่อยู่ รหัสไปรษณีย์-สำหรับออกใบเสร็จ*/            
    field branch        as CHAR FORMAT "X(10)"     init ""   /*สำนักงานใหญ่หรือสาขา       */                      
    field ben_title     as CHAR FORMAT "X(10)"     init ""   /*คำนำหน้าชื่อ ผู้รับผลประโยชน์ */                   
    field ben_name      as CHAR FORMAT "X(50)"     init ""   /*ชื่อผู้รับผลประโยชน์          */                   
    field ben_lname     as CHAR FORMAT "X(50)"     init ""   /*นามสกุล ผู้รับผลประโยชน์      */                   
    field pmentcode     as CHAR FORMAT "X(10)"     init ""   /*รหัสประเภทการชำระเบี้ยประกัน  */                   
    field pmenttyp      as CHAR FORMAT "X(20)"     init ""   /*ประเภทการชำระเบี้ยประกัน      */                   
    field pmentcode1    as CHAR FORMAT "X(20)"     init ""   /*รหัสช่องทางที่ชำระเบี้ย       */                   
    field pmentcode2    as CHAR FORMAT "X(50)"     init ""   /*ช่องทางที่ชำระค่าเบี้ย        */                   
    field pmentbank     as CHAR FORMAT "X(20)"     init ""   /*ธนาคารที่ชำระเบี้ย            */                   
    field pmentdate     as CHAR FORMAT "X(10)"     init ""   /*วันที่ชำระค่าเบี้ย            */                   
    field pmentsts      as CHAR FORMAT "X(10)"     init ""   /*สถานะการชำระเบี้ย             */                   
    field driver        as CHAR FORMAT "X(10)"     init ""   /*การระบุชื่อผู้ขับ             */                   
    field drivetitle1   as CHAR FORMAT "X(10)"     init ""   /*คำนำหน้าชื่อ ผู้ขับขี่ 1      */                   
    field drivename1    as CHAR FORMAT "X(50)"     init ""   /*ชื่อผู้ขับขี่ 1               */                   
    field drivelname1   as CHAR FORMAT "X(50)"     init ""   /*นามสกุล ผู้ขับขี่ 1           */                   
    field driveno1      as CHAR FORMAT "X(20)"     init ""   /*เลขที่บัตรประชาชนผู้ขับขี่ 1  */                   
    field occupdriv1    as CHAR FORMAT "X(30)"     init ""   /*Driver1Occupation             */                   
    field sexdriv1      as CHAR FORMAT "X(1) "     init ""   /*เพศ ผู้ขับขี่ 1               */                   
    field bdatedriv1    as CHAR FORMAT "X(10)"     init ""   /*วันเดือนปีเกิด ผู้ขับขี่ 1    */                   
    field drivetitle2   as CHAR FORMAT "X(10)"     init ""   /*คำนำหน้าชื่อ ผู้ขับขี่ 2      */                   
    field drivename2    as CHAR FORMAT "X(50)"     init ""   /*ชื่อผู้ขับขี่ 2               */                   
    field drivelname2   as CHAR FORMAT "X(50)"     init ""   /*นามสกุล ผู้ขับขี่ 2           */                   
    field driveno2      as CHAR FORMAT "X(20)"     init ""   /*เลขที่บัตรประชาชนผู้ขับขี่ 2  */                   
    field occupdriv2    as CHAR FORMAT "X(50)"     init ""   /*Driver2Occupation             */                   
    field sexdriv2      as CHAR FORMAT "X(1) "     init ""   /*เพศ ผู้ขับขี่ 2               */                   
    field bdatedriv2    as CHAR FORMAT "X(10)"     init ""   /*วันเดือนปีเกิด ผู้ขับขี่ 2    */                   
    field chassis       as CHAR FORMAT "X(50)"     init ""  
    field covcod        as CHAR FORMAT "X(10)"     init "" 
    field covtyp        as CHAR FORMAT "X(20)"     init "" .
DEFINE TEMP-TABLE wdetail2 NO-UNDO
    field brand         as CHAR FORMAT "X(50)"     init ""   /*ชื่อรถยนต์                    */      
    field brand_cd      as CHAR FORMAT "X(50)"     init ""   /*รหัสชื่อรถยนต์                */  
    field Model         as CHAR FORMAT "X(50)"     init ""   /*ชื่อรุ่นรถยนต์                */  
    field Model_cd      as CHAR FORMAT "X(50)"     init ""   /*รหัสชื่อรุ่นรถยนต์            */  
    field body          as CHAR FORMAT "X(50)"     init ""   /*แบบตัวถัง                     */  
    field body_cd       as CHAR FORMAT "X(50)"     init ""   /*รหัสแบบตัวถัง                 */  
    field licence       as CHAR FORMAT "X(50)"     init ""   /*ทะเบียนรถ                     */  
    field province      as CHAR FORMAT "X(50)"     init ""   /*จังหวัดที่จดทะเบียน           */  
    field chassis       as CHAR FORMAT "X(50)"     init ""   /*เลขตัวถัง                     */  
    field engine        as CHAR FORMAT "X(50)"     init ""   /*เลขเครื่องยนต์                */  
    field yrmanu        as CHAR FORMAT "X(10)"     init ""   /*ปีจดทะเบียนรถ                 */  
    field seatenew      as CHAR FORMAT "X(10)"     init ""   /*จำนวนที่นั่ง                  */  
    field power         as CHAR FORMAT "X(10)"     init ""   /*ขนาดเครื่องยนต์               */  
    field weight        as CHAR FORMAT "X(10)"     init ""   /*น้ำหนัก                       */  
    field class         as CHAR FORMAT "X(10)"     init ""   /*รหัสการใช้รถยนต์              */  
    field garage_cd     as CHAR FORMAT "X(10)"     init ""   /*รหัสการซ่อม                   */  
    field garage        as CHAR FORMAT "X(10)"     init ""   /*ประเภทการซ่อม                 */  
    field colorcode     as CHAR FORMAT "X(20)"     init ""   /*สีรถยนต์                      */  
    field covcod        as CHAR FORMAT "X(10)"     init ""   /*รหัสประเภทของประกันภัย        */  
    field covtyp        as CHAR FORMAT "X(20)"     init ""   /*ประเภทของประกันภัย            */  
    field covtyp1       as CHAR FORMAT "X(50)"     init ""   /*ประเภทของความคุ้มครอง         */  
    field covtyp2       as CHAR FORMAT "X(50)"     init ""   /*ประเภทย่อยของความคุ้มครอง     */  
    field covtyp3       as CHAR FORMAT "X(50)"     init ""   /*รายละเอียดประเภทย่อยของความคุ้มครอง */ 
    field comdat        as CHAR FORMAT "X(20)"     init ""   /*วันเริ่มความคุ้มครอง          */       
    field expdat        as CHAR FORMAT "X(20)"     init ""   /*วันที่สิ้นสุดความคุ้มครอง     */       
    field ins_amt       as CHAR FORMAT "X(20)"     init ""   /*ทุนประกัน                     */       
    field prem1         as CHAR FORMAT "X(20)"     init ""   /*เบี้ยประกันตามความคุ้มครองหลัก*/       
    field gross_prm     as CHAR FORMAT "X(20)"     init ""   /*เบี้ยสุทธิหลังหักส่วนลด       */       
    field stamp         as CHAR FORMAT "X(20)"     init ""   /*จำนวนอากรสแตมป์               */       
    field vat           as CHAR FORMAT "X(20)"     init ""   /*จำนวนภาษี Vat                 */       
    field premtotal     as CHAR FORMAT "X(20)"     init ""   /*เบี้ยรวม ภาษี-อากร            */       
    field deduct        as CHAR FORMAT "X(20)"     init ""   /*ค่าความเสียหายส่วนแรก         */       
    field fleetper      as CHAR FORMAT "X(20)"     init ""   /*% ส่วนลดกลุ่ม                 */       
    field fleet         as CHAR FORMAT "X(20)"     init ""   /*จำนวนส่วนลดกลุ่ม              */       
    field ncbper        as CHAR FORMAT "X(20)"     init ""   /*% ส่วนลดประวัติดี             */       
    field ncb           as CHAR FORMAT "X(20)"     init ""   /*จำนวนส่วนลดประวัติดี          */       
    field drivper       as CHAR FORMAT "X(20)"     init ""   /*% ส่วนลดกรณีระบุชื่อผู้ขับขี่ */       
    field drivdis       as CHAR FORMAT "X(20)"     init ""   /*จำนวนส่วนลดกรณีระบุชื่อผู้ขับขี่ */    
    field othper        as CHAR FORMAT "X(20)"     init ""   /*%สวนลดอื่นๆ        */       
    field oth           as CHAR FORMAT "X(20)"     init ""   /*จำนวนส่วนลดอื่นๆ   */       
    field cctvper       as CHAR FORMAT "X(20)"     init ""   /*%สวนลดกล้อง        */       
    field cctv          as CHAR FORMAT "X(20)"     init ""   /*จำนวนส่วนลดกล้อง   */       
    field Surcharper    as CHAR FORMAT "X(20)"     init ""   /*%ส่วนลดเพิ่ม       */       
    field Surchar       as CHAR FORMAT "X(20)"     init ""   /*จำนวนส่วนลดเพิ่ม   */       
    field Surchardetail as CHAR FORMAT "X(20)"     init ""   /*รายละเอียดส่วนเพิ่ม*/       
    field acc1          as CHAR FORMAT "X(50)"     init ""   /*รหัส อุปกรณ์ เพิ่มเติม 1 */       
    field accdetail1    as CHAR FORMAT "X(500)"    init ""   /*รายละเอียดเพิ่มเติม 1    */       
    field accprice1     as CHAR FORMAT "X(10)"     init ""   /*ราคาอุปกรณ์ เพิ่มเติม 1*/
    field acc2          as CHAR FORMAT "X(50)"     init ""   /*รหัส อุปกรณ์ เพิ่มเติม 2 */       
    field accdetail2    as CHAR FORMAT "X(500)"    init ""   /*รายละเอียดเพิ่มเติม 2    */       
    field accprice2     as CHAR FORMAT "X(10)"     init ""   /*ราคาอุปกรณ์ เพิ่มเติม 2*/
    field acc3          as CHAR FORMAT "X(50)"     init ""   /*รหัส อุปกรณ์ เพิ่มเติม 3 */       
    field accdetail3    as CHAR FORMAT "X(500)"    init ""   /*รายละเอียดเพิ่มเติม 3    */       
    field accprice3     as CHAR FORMAT "X(10)"     init ""   /*ราคาอุปกรณ์ เพิ่มเติม 3*/
    field acc4          as CHAR FORMAT "X(50)"     init ""   /*รหัส อุปกรณ์ เพิ่มเติม 4 */       
    field accdetail4    as CHAR FORMAT "X(500)"    init ""   /*รายละเอียดเพิ่มเติม 4    */       
    field accprice4     as CHAR FORMAT "X(10)"     init ""   /*ราคาอุปกรณ์ เพิ่มเติม 4*/
    field acc5          as CHAR FORMAT "X(50)"     init ""   /*รหัส อุปกรณ์ เพิ่มเติม 5 */          
    field accdetail5    as CHAR FORMAT "X(500)"    init ""   /*รายละเอียดเพิ่มเติม 5    */          
    field accprice5     as CHAR FORMAT "X(10)"     init ""   /*ราคาอุปกรณ์ เพิ่มเติม 5*/
    field inspdate      as CHAR FORMAT "X(10)"     init ""   /*วันที่ตรวจสภาพรถ         */          
    field inspdate_app  as CHAR FORMAT "X(10)"     init ""   /*วันที่อนุมัติผลการตรวจสภาพรถ  */          
    field inspsts       as CHAR FORMAT "X(10)"     init ""   /*ผลการตรวจสภาพรถ        */          
    field inspdetail    as CHAR FORMAT "X(500)"    init ""   /*รายละเอียดการตรวจสภาพรถ*/          
    field not_date      as CHAR FORMAT "X(10)"     init ""   /*วันที่ขาย              */          
    field paydate       as CHAR FORMAT "X(10)"     init ""   /*วันที่รับชำระเงิน      */          
    field paysts        as CHAR FORMAT "X(10)"     init ""   /*สถานะการจ่ายเงิน       */          
    field licenBroker   as CHAR FORMAT "X(20)"     init ""   /*เลขที่ใบอนุญาตนายหน้า (SCBPT) */          
    field brokname      as CHAR FORMAT "X(20)"     init ""   /*ชื่อบริษัทนายหน้า (SCBPT) */          
    field brokcode      as CHAR FORMAT "X(10)"     init ""   /*รหัสโบรคเกอร์ */          
    field lang          as CHAR FORMAT "X(20)"     init ""   /*ภาษา*/                    
    field deli          as CHAR FORMAT "X(50)"     init ""   /*ช่องทางการจัดส่ง     */   
    field delidetail    as CHAR FORMAT "X(100)"    init ""   /*รายละเอียดการจัดส่ง  */   
    field gift          as CHAR FORMAT "X(100)"    init ""   /*ของแถม  */                
    field cedcode       as CHAR FORMAT "X(20)"     init ""   /*เลขที่อ้างอิง  */         
    field inscode       as CHAR FORMAT "X(20)"     init ""   /*รหัสลูกค้า */             
    field remark        as CHAR FORMAT "X(500)"    init ""   /*หมายเหตุ   */
    FIELD pass          AS CHAR FORMAT "x(2)"      INIT "" . /* update */ */
DEF BUFFER bfwdetail FOR wdetail.
DEF BUFFER bfwinsp   FOR winsp.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main
&Scoped-define BROWSE-NAME br_imptxt

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES tlt

/* Definitions for BROWSE br_imptxt                                     */
&Scoped-define FIELDS-IN-QUERY-br_imptxt ~
IF (tlt.flag = "V70"  OR  tlt.flag = "V72") THEN (substr(tlt.ins_name,index(tlt.ins_name,":") + 1,index(tlt.ins_name,"NameEng") - 9)) ELSE (tlt.ins_name) ~
tlt.lince1 tlt.cha_no tlt.expodat ~
IF (tlt.flag <> "Paid") THEN (tlt.brand) ELSE (string(brstat.tlt.comp_coamt)) ~
IF (tlt.flag <> "Paid") THEN (tlt.model) ELSE (brstat.tlt.exp) ~
IF (tlt.flag = "V70" or tlt.flag = "V72") THEN (substr(tlt.nor_noti_tlt,index(tlt.nor_noti_tlt,":") + 1 , index(tlt.nor_noti_tlt,"InspDe:") - 9  )) ELSE  IF (tlt.flag = "Paid") THEN (tlt.filler2) ELSE (tlt.nor_noti_tlt) ~
if (tlt.flag = "V70" or tlt.flag = "V72") then (substr(tlt.nor_noti_tlt,r-index(tlt.nor_noti_tlt,":") + 1)) else (tlt.nor_noti_tlt) 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_imptxt 
&Scoped-define QUERY-STRING-br_imptxt FOR EACH tlt NO-LOCK
&Scoped-define OPEN-QUERY-br_imptxt OPEN QUERY br_imptxt FOR EACH tlt NO-LOCK.
&Scoped-define TABLES-IN-QUERY-br_imptxt tlt
&Scoped-define FIRST-TABLE-IN-QUERY-br_imptxt tlt


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_loaddat fi_compa ra_txttyp fi_producer ~
fi_agent fi_insp fi_filename bu_file bu_ok bu_exit br_imptxt bu_hpacno1 ~
bu_hpacno2 RECT-1 RECT-387 RECT-388 
&Scoped-Define DISPLAYED-OBJECTS fi_loaddat fi_compa ra_txttyp fi_producer ~
fi_agent fi_insp fi_filename fi_proname fi_impcnt fi_completecnt ~
fi_proname2 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_exit 
     LABEL "EXIT" 
     SIZE 8.5 BY 1
     FONT 6.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 4 BY 1.

DEFINE BUTTON bu_hpacno1  NO-CONVERT-3D-COLORS
     LABEL "..." 
     SIZE 4 BY 1.

DEFINE BUTTON bu_hpacno2 
     LABEL "..." 
     SIZE 4 BY 1.

DEFINE BUTTON bu_ok 
     LABEL "OK" 
     SIZE 8.5 BY 1
     FONT 6.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 16.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_compa AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_completecnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY 1
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 76 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_impcnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11 BY 1
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_insp AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 10.17 BY 1
     BGCOLOR 15 FGCOLOR 6 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_loaddat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 16.5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 16.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_proname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 45.67 BY 1
     BGCOLOR 20 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_proname2 AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 45.67 BY 1
     BGCOLOR 20 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE ra_txttyp AS INTEGER INITIAL 1 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "ไฟล์แจ้งงาน", 1,
"ไฟล์ตรวจสภาพ", 2
     SIZE 66.5 BY .95
     BGCOLOR 14 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132 BY 23.76
     BGCOLOR 30 .

DEFINE RECTANGLE RECT-387
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10.17 BY 1.29
     BGCOLOR 2 .

DEFINE RECTANGLE RECT-388
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10.17 BY 1.29
     BGCOLOR 6 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_imptxt FOR 
      tlt SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_imptxt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_imptxt C-Win _STRUCTURED
  QUERY br_imptxt NO-LOCK DISPLAY
      IF (tlt.flag = "V70"  OR  tlt.flag = "V72") THEN (substr(tlt.ins_name,index(tlt.ins_name,":") + 1,index(tlt.ins_name,"NameEng") - 9)) ELSE (tlt.ins_name) COLUMN-LABEL "ชื่อผู้เอาประกัน" FORMAT "X(70)":U
            WIDTH 28.67
      tlt.lince1 FORMAT "x(12)":U WIDTH 14.17
      tlt.cha_no FORMAT "x(25)":U WIDTH 15.5
      tlt.expodat COLUMN-LABEL "วันที่หมดอายุ" FORMAT "99/99/9999":U
            WIDTH 12.5
      IF (tlt.flag <> "Paid") THEN (tlt.brand) ELSE (string(brstat.tlt.comp_coamt)) COLUMN-LABEL "ยี่ห้อ/เบี้ยรวม" FORMAT "X(15)":U
            WIDTH 15.17
      IF (tlt.flag <> "Paid") THEN (tlt.model) ELSE (brstat.tlt.exp) COLUMN-LABEL "รุ่นรถ/ ยอดที่ชำระ" FORMAT "X(30)":U
            WIDTH 15.83
      IF (tlt.flag = "V70" or tlt.flag = "V72") THEN (substr(tlt.nor_noti_tlt,index(tlt.nor_noti_tlt,":") + 1 , index(tlt.nor_noti_tlt,"InspDe:") - 9  )) ELSE  IF (tlt.flag = "Paid") THEN (tlt.filler2) ELSE (tlt.nor_noti_tlt) COLUMN-LABEL "การตรวจสภาพ/ หมายเหตุ" FORMAT "X(30)":U
      if (tlt.flag = "V70" or tlt.flag = "V72") then (substr(tlt.nor_noti_tlt,r-index(tlt.nor_noti_tlt,":") + 1)) else (tlt.nor_noti_tlt) COLUMN-LABEL "รายละเอียดตรวจสภาพ" FORMAT "X(50)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 129.17 BY 14.67
         BGCOLOR 15  ROW-HEIGHT-CHARS .67.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_loaddat AT ROW 1.52 COL 35.17 COLON-ALIGNED NO-LABEL
     fi_compa AT ROW 1.52 COL 71.5 COLON-ALIGNED NO-LABEL
     ra_txttyp AT ROW 2.57 COL 37.5 NO-LABEL
     fi_producer AT ROW 3.62 COL 35.17 COLON-ALIGNED NO-LABEL
     fi_agent AT ROW 4.76 COL 35.17 COLON-ALIGNED NO-LABEL
     fi_insp AT ROW 5.86 COL 35.33 COLON-ALIGNED NO-LABEL
     fi_filename AT ROW 6.95 COL 35.17 COLON-ALIGNED NO-LABEL
     bu_file AT ROW 6.95 COL 113.5
     bu_ok AT ROW 8.48 COL 108.83
     bu_exit AT ROW 8.48 COL 119.67
     br_imptxt AT ROW 9.81 COL 3.17
     fi_proname AT ROW 3.62 COL 56.33 COLON-ALIGNED NO-LABEL
     fi_impcnt AT ROW 8.14 COL 35.5 COLON-ALIGNED NO-LABEL
     fi_completecnt AT ROW 8.14 COL 72.33 COLON-ALIGNED NO-LABEL
     fi_proname2 AT ROW 4.76 COL 56.33 COLON-ALIGNED NO-LABEL
     bu_hpacno1 AT ROW 3.62 COL 54.17
     bu_hpacno2 AT ROW 4.76 COL 54.17
     "รายการ" VIEW-AS TEXT
          SIZE 7 BY 1 AT ROW 8.14 COL 49.83
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "          กรุณาป้อนชื่อไฟล์นำเข้า :" VIEW-AS TEXT
          SIZE 29 BY 1 AT ROW 6.95 COL 7.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "               ข้อมูลนำเข้าทั้งหมด  :":50 VIEW-AS TEXT
          SIZE 29 BY 1 AT ROW 8.14 COL 7.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     " ปีที่ค้นหาและเพิ่มข้อมูลของกล่อง Inspection" VIEW-AS TEXT
          SIZE 34.83 BY .71 AT ROW 6.05 COL 48.83
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "                  กล่องตรวจสภาพ :" VIEW-AS TEXT
          SIZE 29.17 BY 1 AT ROW 5.86 COL 7.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "DATE:27/03/2025" VIEW-AS TEXT
          SIZE 18 BY .95 AT ROW 1.48 COL 114 WIDGET-ID 2
          BGCOLOR 30 FGCOLOR 10 FONT 6
     "                      Agent Code  :" VIEW-AS TEXT
          SIZE 29 BY 1 AT ROW 4.76 COL 7.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "                   เลือกข้อมูลนำเข้า  :" VIEW-AS TEXT
          SIZE 29 BY .95 AT ROW 2.57 COL 7.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "                   วันที่ไฟล์แจ้งงาน :" VIEW-AS TEXT
          SIZE 29 BY .95 AT ROW 1.52 COL 7.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "                  Producer Code  :" VIEW-AS TEXT
          SIZE 29 BY 1 AT ROW 3.67 COL 7.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Company Code :" VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 1.52 COL 56.83
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "รายการ" VIEW-AS TEXT
          SIZE 7 BY 1 AT ROW 8.14 COL 86.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "นำเข้าระบบได้  :":60 VIEW-AS TEXT
          SIZE 15 BY 1 AT ROW 8.14 COL 58.83
          BGCOLOR 19 FGCOLOR 1 FONT 6
     RECT-1 AT ROW 1.05 COL 1.5
     RECT-387 AT ROW 8.33 COL 108
     RECT-388 AT ROW 8.33 COL 118.83
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 23.91
         BGCOLOR 3 .


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
         TITLE              = "Import text file SCBPT"
         HEIGHT             = 23.91
         WIDTH              = 133
         MAX-HEIGHT         = 47.67
         MAX-WIDTH          = 213.33
         VIRTUAL-HEIGHT     = 47.67
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
/* SETTINGS FOR FRAME fr_main
   FRAME-NAME Custom                                                    */
/* BROWSE-TAB br_imptxt bu_exit fr_main */
ASSIGN 
       bu_file:AUTO-RESIZE IN FRAME fr_main      = TRUE.

/* SETTINGS FOR FILL-IN fi_completecnt IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_impcnt IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_proname IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_proname2 IN FRAME fr_main
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_imptxt
/* Query rebuild information for BROWSE br_imptxt
     _TblList          = "brstat.tlt"
     _Options          = "NO-LOCK"
     _FldNameList[1]   > "_<CALC>"
"IF (tlt.flag = ""V70""  OR  tlt.flag = ""V72"") THEN (substr(tlt.ins_name,index(tlt.ins_name,"":"") + 1,index(tlt.ins_name,""NameEng"") - 9)) ELSE (tlt.ins_name)" "ชื่อผู้เอาประกัน" "X(70)" ? ? ? ? ? ? ? no ? no no "28.67" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > brstat.tlt.lince1
"tlt.lince1" ? "x(12)" "character" ? ? ? ? ? ? no ? no no "14.17" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > brstat.tlt.cha_no
"tlt.cha_no" ? "x(25)" "character" ? ? ? ? ? ? no ? no no "15.5" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > brstat.tlt.expodat
"tlt.expodat" "วันที่หมดอายุ" "99/99/9999" "date" ? ? ? ? ? ? no ? no no "12.5" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > "_<CALC>"
"IF (tlt.flag <> ""Paid"") THEN (tlt.brand) ELSE (string(brstat.tlt.comp_coamt))" "ยี่ห้อ/เบี้ยรวม" "X(15)" ? ? ? ? ? ? ? no ? no no "15.17" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > "_<CALC>"
"IF (tlt.flag <> ""Paid"") THEN (tlt.model) ELSE (brstat.tlt.exp)" "รุ่นรถ/ ยอดที่ชำระ" "X(30)" ? ? ? ? ? ? ? no ? no no "15.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > "_<CALC>"
"IF (tlt.flag = ""V70"" or tlt.flag = ""V72"") THEN (substr(tlt.nor_noti_tlt,index(tlt.nor_noti_tlt,"":"") + 1 , index(tlt.nor_noti_tlt,""InspDe:"") - 9  )) ELSE  IF (tlt.flag = ""Paid"") THEN (tlt.filler2) ELSE (tlt.nor_noti_tlt)" "การตรวจสภาพ/ หมายเหตุ" "X(30)" ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > "_<CALC>"
"if (tlt.flag = ""V70"" or tlt.flag = ""V72"") then (substr(tlt.nor_noti_tlt,r-index(tlt.nor_noti_tlt,"":"") + 1)) else (tlt.nor_noti_tlt)" "รายละเอียดตรวจสภาพ" "X(50)" ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE br_imptxt */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Import text file SCBPT */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Import text file SCBPT */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit C-Win
ON CHOOSE OF bu_exit IN FRAME fr_main /* EXIT */
DO:
  Apply "Close" To  This-procedure.
  Return no-apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_file
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_file C-Win
ON CHOOSE OF bu_file IN FRAME fr_main /* ... */
DO:
    DEFINE VARIABLE cvData        AS CHARACTER NO-UNDO.
    DEFINE VARIABLE OKpressed AS LOGICAL INITIAL TRUE.
    SYSTEM-DIALOG GET-FILE cvData
        TITLE      "Choose Data File to Import ..."
        /*      FILTERS    "Text Documents" "*.txt"    */
        FILTERS    /* "Text Documents"   "*.txt",
        "Data Files (*.*)"     "*.*"*/
        "Text Documents" "*.csv"
        
        
        MUST-EXIST
        USE-FILENAME
        UPDATE OKpressed.
    IF OKpressed = TRUE THEN DO:
        fi_filename  = cvData.
        DISP fi_filename WITH FRAME fr_main.     
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_hpacno1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpacno1 C-Win
ON CHOOSE OF bu_hpacno1 IN FRAME fr_main /* ... */
DO:
   Def   var     n_acno       As  Char.
   Def   var     n_agent      As  Char.    
     
   Run whp\whpacno1(output  n_acno,
                                      output  n_agent).
                                          
     If  n_acno  <>  ""  Then  fi_producer =  n_acno.
     
     disp  fi_producer  with frame  fr_main.

     Apply "Entry"  to  fi_producer.
     Return no-apply.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_hpacno2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpacno2 C-Win
ON CHOOSE OF bu_hpacno2 IN FRAME fr_main /* ... */
DO:
   Def   var     n_acno       As  Char.
   Def   var     n_agent      As  Char.    
     
   Run whp\whpacno1(output  n_acno,output  n_agent).
                                          
     If  n_acno  <>  ""  Then  fi_agent =  n_acno.
     
     disp  fi_agent  with frame  fr_main.

     Apply "Entry"  to  fi_agent.
     Return no-apply.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok C-Win
ON CHOOSE OF bu_ok IN FRAME fr_main /* OK */
DO:
    ASSIGN 
        nv_daily     = ""
        nv_reccnt    = 0
        nv_updatecnt = 0.

    FOR EACH wdetail:
        DELETE  wdetail.
    END.

    IF ra_txttyp = 1 Then DO:      /*--- ไฟล์แจ้งงาน กรมธรรม์ ---*/
        Run  Import_notification.   
    END.                            
    ELSE IF ra_txttyp = 2 THEN DO: /*--- ไฟล์ตรวจสภาพ ---*/
        Run  Import_Inspection. 
    END.

  /*ELSE IF ra_txttyp = 3 THEN  RUN  IMPORT_Payment.*/
    RELEASE brstat.tlt.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agent C-Win
ON LEAVE OF fi_agent IN FRAME fr_main
DO:
    fi_agent = INPUT fi_agent .

    If Input  fi_agent  =  ""  Then do:
        Apply "Choose"  to  bu_hpacno2.
        Return no-apply.
    END.
    FIND sicsyac.xmm600 USE-INDEX xmm60001   WHERE
        xmm600.acno  =  Input fi_agent    NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAIL sicsyac.xmm600 THEN DO:
        Message  "Not on Name & Address Master File xmm600" 
            View-as alert-box.
        Apply "Entry" To  fi_agent.
        Return no-apply.
    END.
    ELSE 
        ASSIGN fi_proname2 =  TRIM(xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name) .
        fi_agent =  CAPS(INPUT fi_agent).
    Disp  fi_agent  fi_proname2  WITH Frame  fr_main.                 

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_compa
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_compa C-Win
ON LEAVE OF fi_compa IN FRAME fr_main
DO:
    fi_compa =  INPUT  fi_compa.
     IF fi_compa    = "SCBPT" THEN
        ASSIGN
         fi_producer = "B3MLSCB201" 
         fi_agent    = "B3MLSCB200" .
     ELSE 
          ASSIGN
         fi_producer = "B3MLSCB203" 
         fi_agent    = "B3MLSCB200" . 





    Disp  fi_compa  fi_producer  fi_agent  WITH Frame  fr_main.                 

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_filename
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_filename C-Win
ON LEAVE OF fi_filename IN FRAME fr_main
DO:
  fi_filename  =  Input  fi_filename .
  Disp  fi_filename with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_insp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_insp C-Win
ON LEAVE OF fi_insp IN FRAME fr_main
DO:
    fi_insp = INPUT fi_insp.
    IF fi_insp > STRING(YEAR(TODAY),"9999")  THEN DO:
        MESSAGE "ปีที่ระบุมากกว่าปีปัจจุบัน !! " VIEW-AS ALERT-BOX.
        APPLY "ENTRY" TO fi_insp.
        RETURN NO-APPLY.
    END.
    DISP fi_insp WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_loaddat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_loaddat C-Win
ON LEAVE OF fi_loaddat IN FRAME fr_main
DO:
    fi_loaddat  =  Input  fi_loaddat.
    Disp fi_loaddat  with frame  fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer C-Win
ON LEAVE OF fi_producer IN FRAME fr_main
DO:
    /*
    If  Input  fi_producer  =  ""  Then do:
       Message "กรุณาระบุรหัสผู้หางาน "  View-as alert-box.
       Apply "Entry" to fi_producer.
       End.
    */
    If Input  fi_producer  =  ""  Then do:
        Apply "Choose"  to  bu_hpacno1.
        Return no-apply.
    END.
    FIND sicsyac.xmm600 USE-INDEX xmm60001   WHERE
        xmm600.acno  =  Input fi_producer    NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAIL sicsyac.xmm600 THEN DO:
        Message  "Not on Name & Address Master File xmm600" 
            View-as alert-box.
        Apply "Entry" To  fi_producer.
        Return no-apply.
    END.
    ELSE 
        ASSIGN fi_proname =  TRIM(xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name) .
    fi_producer =  CAPS(INPUT fi_producer).
    Disp  fi_producer  fi_proname  WITH Frame  fr_main.                 

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_txttyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_txttyp C-Win
ON ENTER OF ra_txttyp IN FRAME fr_main
DO:
  Apply "Entry" to fi_producer.
  Return no-apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_txttyp C-Win
ON VALUE-CHANGED OF ra_txttyp IN FRAME fr_main
DO:
  ra_txttyp  =  Input  ra_txttyp.
  Disp  ra_txttyp  with  frame fr_main.

  IF ra_txttyp = 3 THEN DO:
      DISABLE fi_Producer fi_agent bu_hpacno1 bu_hpacno2 WITH FRAME fr_main.
      fi_producer:BGCOLOR = 19.
      fi_agent:BGCOLOR = 19.
  END.
  ELSE DO:
      ENABLE fi_Producer fi_agent bu_hpacno1 bu_hpacno2 WITH FRAME fr_main.
      fi_producer:BGCOLOR = 15.
      fi_agent:BGCOLOR = 15.

  END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_imptxt
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
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.
  
     /********************  T I T L E   F O R  C - W I N  ****************/
  DEF  VAR  gv_prgid   AS   CHAR.
  DEF  VAR  gv_prog    AS   CHAR.
  
  gv_prgid = "wgwimscb".
  gv_prog  = "Import Text File data SCBPT ".
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).

/*********************************************************************/ 

  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.
  
  /*RECT-4:MOVE-TO-TOP().
  RECT-75:MOVE-TO-TOP().  */
 
  Hide Frame  fr_gen  .
  ASSIGN  
      fi_loaddat  =  today
      fi_compa    = "SCBPT"
      fi_producer = "B3MLSCB201"
      fi_agent    = "B3MLSCB200"
    /*fi_producer = "B3M0051"    /*A61-0228*/
      fi_agent    = "B3M0051"    /*A61-0228*/*/
      ra_txttyp   = 1 
      fi_insp     = STRING(YEAR(TODAY),"9999"). /* ranu insp */

  DISP fi_loaddat  fi_producer ra_txttyp fi_compa fi_insp fi_agent with  frame  fr_main.
  
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Create_tlt_insp C-Win 
PROCEDURE Create_tlt_insp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
LOOP_Insp:
FOR EACH winsp WHERE
     winsp.inscode <> "" AND             
     INDEX(winsp.inscode,"CustCode") = 0 .
   /* IF index(winsp.n_no,"Line") <> 0 THEN  DELETE winsp.
    ELSE  IF index(winsp.n_no,"ลำดับ") <> 0 THEN  DELETE winsp.
    ELSE IF winsp.n_no  = "" THEN DELETE winsp.
    ELSE */
    
        IF (winsp.chassis = "" ) THEN 
        MESSAGE "พบเลขตัวถังเป็นค่าว่าง..." VIEW-AS ALERT-BOX.
    ELSE DO:
        winsp.chassis = CAPS(winsp.chassis).
        nv_reccnt  = nv_reccnt + 1.
        FIND LAST brstat.tlt USE-INDEX tlt06  WHERE         
            brstat.tlt.cha_no    = trim(winsp.chassis)  AND
            brstat.tlt.eng_no    = TRIM(winsp.engine)   AND  
            brstat.tlt.flag      = "INSPEC"             AND 
            brstat.tlt.genusr    = trim(fi_compa)       NO-ERROR NO-WAIT .
        IF NOT AVAIL brstat.tlt THEN DO:    /*  kridtiya i. A54-0216 ....*/
            CREATE brstat.tlt.
            nv_completecnt  =  nv_completecnt + 1.
            ASSIGN                                                 
                brstat.tlt.trndat        = TODAY                           /* date  99/99/9999  */
                brstat.tlt.trntim        = STRING(TIME,"HH:MM:SS")         /* char  x(8)        */
                brstat.tlt.genusr        = TRIM(fi_compa)                  /* SCBPT*/                    
                brstat.tlt.usrid         = USERID(LDBNAME(1))              /*User Load Data */
                brstat.tlt.releas        = "No"
                brstat.tlt.flag          = "INSPEC"                        /* ประเภทไฟล์ ตรวจสภาพ */
                brstat.tlt.subins        = TRIM(fi_producer)        
                brstat.tlt.recac         = TRIM(fi_agent)
                brstat.tlt.nor_usr_ins   = trim(winsp.inscode)                                  /*เลขที่ Prospect       */  
                brstat.tlt.lotno         = "CamCode:" + trim(winsp.campcode)  + " " +           /*รหัสแคมเปญ            */  
                                           "CamName:" + trim(winsp.campname)                    /*ชื่อแคมเปญ            */  
                brstat.tlt.usrsent       = "ProCode:" + trim(winsp.procode) + " " +             /*รหัสผลิตภัณฑ์         */  
                                           "ProName:" + trim(winsp.proname) + " " +             /*ชื่อผลิตภัณฑ์         */  
                                           "PlanCod:" + trim(winsp.packcode) + " " +            /*รหัสย่อยผลิตภัณฑ์     */  
                                           "PlanNam:" + trim(winsp.packnam)                     /*ชื่อรหัสย่อยผลิตภัณฑ์ */  
                brstat.tlt.nor_noti_ins  = trim(winsp.Refno)                                    /*เลขที่ใบคำขอ          */  
                brstat.tlt.ins_name      = trim(winsp.pol_fname) + " " + TRIM(winsp.pol_lname)  /*ชื่อผู้เอาประกัน      */  
                brstat.tlt.ins_addr5     = trim(winsp.pol_tel)                                  /*เบอร์โทรศัพท์ผู้เอาประกัน */
                brstat.tlt.imp           = trim(winsp.instype)                                  /*ประเภทผู้เอาประกัน        */
                
                brstat.tlt.nor_effdat    = DATE(SUBSTR(winsp.inspdate,9,2) + "/" +
                                                SUBSTR(winsp.inspdate,6,2) + "/" + 
                                                SUBSTR(winsp.inspdate,1,4))  
                                         /*วันทีนัดตรวจสภาพรถยนต์    */
                brstat.tlt.old_eng       = trim(winsp.insptime)                                 /*เวลาที่นัดตรวจสภาพรถยนต์  */
                brstat.tlt.ins_addr1     = trim(winsp.inspcont)                                 /*ชื่อผู้ที่ติดต่อ          */
                brstat.tlt.ins_addr2     = "InspTel:" + trim(winsp.insptel) + " " +             /*เบอร์โทรศัพท์ผู้ติดต่อ    */
                                           "InspLin:" + trim(winsp.lineid) + " " +              /*Line ID                   */
                                           "InspMal:" + TRIM(winsp.mail)                        /*email-ผู้ติดต่อ           */
                brstat.tlt.ins_addr3     = trim(winsp.inspaddr)                                 /*ที่อยู่ในการตรวจสภาพรถยนต์*/
                brstat.tlt.brand         = TRIM(winsp.brand)                                    /*ยี่ห้อรถ                  */
                brstat.tlt.model         = trim(winsp.Model)                                    /*รหัสรุ่นรถ                */
                brstat.tlt.expotim       = trim(winsp.class)                                    /*รหัสรถ (MotorCode)        */
                brstat.tlt.sentcnt       = INT(winsp.seatenew)                                  /*จำนวนที่นั่ง              */
                brstat.tlt.rencnt        = deci(winsp.power)                                    /*ขนาด ซี ซี                */
                brstat.tlt.cc_weight     = deci(winsp.weight)                                   /*น้ำหนัก                   */
                brstat.tlt.lince2        = trim(winsp.province)                                 /*จังหวัดที่จดทะเบียน       */
                brstat.tlt.gentim        = trim(winsp.yrmanu)                                   /*ปีที่จดทะเบียน            */
                brstat.tlt.lince1        = trim(winsp.licence)                                  /*ทะเบียนรถ                 */
                brstat.tlt.cha_no        = CAPS(trim(winsp.chassis))                           /*หมายเลขตัวถัง             */
                brstat.tlt.eng_no        = CAPS(trim(winsp.engine))                                   /*หมายเลขเครื่อง            */
                brstat.tlt.gendat        = DATE(SUBSTR(winsp.comdat,9,2) + "/" +
                                                SUBSTR(winsp.comdat,6,2) + "/" + 
                                                SUBSTR(winsp.comdat,1,4)) 
 
                brstat.tlt.expodat       = DATE(SUBSTR(winsp.expdat,9,2) + "/" +
                                                SUBSTR(winsp.expdat,6,2) + "/" + 
                                                SUBSTR(winsp.expdat,1,4))
                
                brstat.tlt.nor_coamt     = deci(winsp.ins_amt)                                  /*ทุนประกันภัย              */
                brstat.tlt.comp_coamt    = deci(winsp.premtotal)                                /*ค่าเบี้ยประกันภัย         */
                brstat.tlt.filler1       = "Acc1:" + trim(winsp.acc1)       + " " +             /*รหัส อุปกรณ์1  */   
                                           "Acd1:" + trim(winsp.accdetail1) + " " +             /*รายละเอียด1    */    
                                           "Acp1:" + STRING(DECI(winsp.accprice1))  + " " +     /*ราคาอุปกรณ์1   */    
                                           "Acc2:" + trim(winsp.acc2)       + " " +             /*รหัส อุปกรณ์2  */    
                                           "Acd2:" + trim(winsp.accdetail2) + " " +             /*รายละเอียด2    */    
                                           "Acp2:" + STRING(DECI(winsp.accprice2))  + " " +     /*ราคาอุปกรณ์2   */    
                                           "Acc3:" + trim(winsp.acc3)       + " " +             /*รหัส อุปกรณ์3  */    
                                           "Acd3:" + trim(winsp.accdetail3) + " " +             /*รายละเอียด3    */    
                                           "Acp3:" + STRING(DECI(winsp.accprice3))  + " " +     /*ราคาอุปกรณ์3   */    
                                           "Acc4:" + trim(winsp.acc4)       + " " +             /*รหัส อุปกรณ์4  */    
                                           "Acd4:" + trim(winsp.accdetail4) + " " +             /*รายละเอียด 4   */    
                                           "Acp4:" + STRING(DECI(winsp.accprice4))  + " " +     /*ราคาอุปกรณ์4   */    
                                           "Acc5:" + trim(winsp.acc5)       + " " +             /*รหัส อุปกรณ์5  */    
                                           "Acd5:" + TRIM(winsp.accdetail5) + " " +             /*รายละเอียด 5   */    
                                           "Acp5:" + STRING(DECI(winsp.accprice5))              /*ราคาอุปกรณ์5     */
               brstat.tlt.rec_addr1      = trim(winsp.custcode)
               brstat.tlt.rec_addr2      = trim(winsp.tmp1)
               brstat.tlt.rec_addr3      = trim(winsp.tmp2)
               brstat.tlt.nor_noti_tlt   = ""           /*เลขที่ตรวจสภาพ */  
               brstat.tlt.safe1          = ""           /* ความเสียหาย */
               brstat.tlt.safe2          = ""           /*รายการความเสียหาย */
               brstat.tlt.safe3          = ""           /*รายละเอียดอุปกรณ์เสริม */
               brstat.tlt.filler2        = ""           /*รายละเอียดอื่นๆ */
               /*brstat.tlt.datesent       = ?           /*วันที่ปิดเรื่อง */*/
               brstat.tlt.stat           = "No"        /*ส่งข้อมูลให้ SCBPT*/   
               /*brstat.tlt.entdat         = ?         /*วันที่ส่งรายงาน */*/ 
               brstat.tlt.note5          = trim(winsp.Selling_Channel).
             
            RUN Proc_inspection.
             
            ASSIGN winsp.pass = "Y" .
        END.
        ELSE DO:
             nv_updatecnt = nv_updatecnt + 1 .
             ASSIGN winsp.pass = "N".
        END.
    END.  /*winsp.Notify_no <> "" */
END.   /* FOR EACH winsp NO-LOCK: */
Run Open_tlt.
RELEASE winsp.
RELEASE brstat.tlt.

IF nv_updatecnt <> 0 THEN DO:
    MESSAGE "มีข้อมูลการตรวจสภาพซ้ำจำนวน " nv_updatecnt " รายการ จะทำการอัพเดทข้อมูลใหม่หรือไม่ ? " 
    VIEW-AS ALERT-BOX QUESTION BUTTON YES-NO TITLE "อัพเดทการตรวจสภาพ" UPDATE choic AS LOGICAL.
    CASE choic:
        WHEN TRUE THEN DO:
            FOR EACH winsp WHERE winsp.pass = "N" .
               FIND LAST brstat.tlt USE-INDEX tlt06  WHERE         
                    brstat.tlt.cha_no    = trim(winsp.chassis)  AND
                    brstat.tlt.eng_no    = TRIM(winsp.engine)   AND  
                    brstat.tlt.flag      = "INSPEC"             AND 
                    brstat.tlt.genusr    = trim(fi_compa)       NO-ERROR NO-WAIT .
                IF AVAIL brstat.tlt THEN DO:   
                    nv_completecnt  =  nv_completecnt + 1.
                  
                    RUN Create_tlt_insp2.
                     
                    ASSIGN winsp.pass = "Y" .
                END.
            END. /*if avail wdetail2 */
        END.
        WHEN FALSE THEN DO:
            RETURN NO-APPLY.
        END.
    END CASE.
    Run Open_tlt.   
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Create_tlt_insp2 C-Win 
PROCEDURE Create_tlt_insp2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    ASSIGN                                           
          brstat.tlt.trndat        = TODAY                           /* date  99/99/9999  */
          brstat.tlt.trntim        = STRING(TIME,"HH:MM:SS")         /* char  x(8)        */
          brstat.tlt.genusr        = TRIM(fi_compa)                  /* SCBPT*/                    
          brstat.tlt.usrid         = USERID(LDBNAME(1))              /*User Load Data */
          brstat.tlt.releas        = "No" 
          brstat.tlt.flag          = "INSPEC"                        /* ประเภทไฟล์ ตรวจสภาพ */   
          brstat.tlt.nor_usr_ins   = trim(winsp.inscode)                                  /*เลขที่ Prospect*/  
          brstat.tlt.lotno         = "CamCode:" + trim(winsp.campcode)  + " " +           /*รหัสแคมเปญ     */  
                                     "CamName:" + trim(winsp.campname)                    /*ชื่อแคมเปญ     */  
          brstat.tlt.usrsent       = "ProCode:" + trim(winsp.procode) + " " +             /*รหัสผลิตภัณฑ์  */  
                                     "ProName:" + trim(winsp.proname) + " " +             /*ชื่อผลิตภัณฑ์  */  
                                     "PlanCod:" + trim(winsp.packcode) + " " +            /*รหัสย่อยผลิตภัณฑ์     */  
                                     "PlanNam:" + trim(winsp.packnam)                     /*ชื่อรหัสย่อยผลิตภัณฑ์ */  
          brstat.tlt.nor_noti_ins  = trim(winsp.Refno)                                    /*เลขที่ใบคำขอ     */  
          brstat.tlt.ins_name      = trim(winsp.pol_fname) + " " + TRIM(winsp.pol_lname)  /*ชื่อผู้เอาประกัน */  
          brstat.tlt.ins_addr5     = trim(winsp.pol_tel)                                  /*เบอร์โทรศัพท์ผู้เอาประกัน */
          brstat.tlt.imp           = trim(winsp.instype)                                  /*ประเภทผู้เอาประกัน     */
          brstat.tlt.nor_effdat    = DATE(SUBSTR(winsp.inspdate,9,2) + "/" +                                     /*วันทีนัดตรวจสภาพรถยนต์ */
                                          SUBSTR(winsp.inspdate,6,2) + "/" +
                                          SUBSTR(winsp.inspdate,1,4))      

          brstat.tlt.old_eng       = trim(winsp.insptime)                                 /*เวลาที่นัดตรวจสภาพรถยนต์*/
          brstat.tlt.ins_addr1     = trim(winsp.inspcont)                                 /*ชื่อผู้ที่ติดต่อ       */
          brstat.tlt.ins_addr2     = "InspTel:" + trim(winsp.insptel) + " " +             /*เบอร์โทรศัพท์ผู้ติดต่อ */
                                     "InspLin:" + trim(winsp.lineid) + " " +              /*Line ID                */
                                     "InspMal:" + TRIM(winsp.mail)                        /*email-ผู้ติดต่อ        */
          brstat.tlt.ins_addr3     = trim(winsp.inspaddr)                                 /*ที่อยู่ในการตรวจสภาพรถยนต์*/
          brstat.tlt.brand         = TRIM(winsp.brand)                                    /*ยี่ห้อรถ             */ 
          brstat.tlt.model         = trim(winsp.Model)                                    /*รหัสรุ่นรถ           */ 
          brstat.tlt.expotim       = trim(winsp.class)                                    /*รหัสรถ (MotorCode)   */ 
          brstat.tlt.sentcnt       = INT(winsp.seatenew)                                  /*จำนวนที่นั่ง         */ 
          brstat.tlt.rencnt        = deci(winsp.power)                                    /*ขนาด ซี ซี           */ 
          brstat.tlt.cc_weight     = deci(winsp.weight)                                   /*น้ำหนัก              */ 
          brstat.tlt.lince2        = trim(winsp.province)                                 /*จังหวัดที่จดทะเบียน  */ 
          brstat.tlt.gentim        = trim(winsp.yrmanu)                                   /*ปีที่จดทะเบียน       */ 
          brstat.tlt.lince1        = trim(winsp.licence)                                  /*ทะเบียนรถ            */ 
          brstat.tlt.cha_no        = CAPS(trim(winsp.chassis))                            /*หมายเลขตัวถัง        */ 
          brstat.tlt.eng_no        = CAPS(trim(winsp.engine))                             /*หมายเลขเครื่อง       */ 

          brstat.tlt.gendat        = DATE(SUBSTR(winsp.comdat,9,2) + "/" +                /*วันที่เริ่มคุ้มครอง  */ 
                                          SUBSTR(winsp.comdat,6,2) + "/" +
                                          SUBSTR(winsp.comdat,1,4))       
          brstat.tlt.expodat       = DATE(SUBSTR(winsp.expdat,9,2) + "/" +                /*วันที่สิ้นสุดคุ้มครอง*/ 
                                          SUBSTR(winsp.expdat,6,2) + "/" +
                                          SUBSTR(winsp.expdat,1,4))       

          brstat.tlt.nor_coamt     = deci(winsp.ins_amt)                                  /*ทุนประกันภัย         */ 
          brstat.tlt.comp_coamt    = deci(winsp.premtotal)                                /*ค่าเบี้ยประกันภัย    */ 
          brstat.tlt.filler1       = "Acc1:" + trim(winsp.acc1)       + " " +             /*รหัส อุปกรณ์1  */   
                                     "Acd1:" + trim(winsp.accdetail1) + " " +             /*รายละเอียด1    */    
                                     "Acp1:" + STRING(DECI(winsp.accprice1))  + " " +     /*ราคาอุปกรณ์1   */    
                                     "Acc2:" + trim(winsp.acc2)       + " " +             /*รหัส อุปกรณ์2  */    
                                     "Acd2:" + trim(winsp.accdetail2) + " " +             /*รายละเอียด2    */    
                                     "Acp2:" + STRING(DECI(winsp.accprice2))  + " " +     /*ราคาอุปกรณ์2   */    
                                     "Acc3:" + trim(winsp.acc3)       + " " +             /*รหัส อุปกรณ์3  */    
                                     "Acd3:" + trim(winsp.accdetail3) + " " +             /*รายละเอียด3    */    
                                     "Acp3:" + STRING(DECI(winsp.accprice3))  + " " +     /*ราคาอุปกรณ์3   */    
                                     "Acc4:" + trim(winsp.acc4)       + " " +             /*รหัส อุปกรณ์4  */    
                                     "Acd4:" + trim(winsp.accdetail4) + " " +             /*รายละเอียด 4   */    
                                     "Acp4:" + STRING(DECI(winsp.accprice4))  + " " +     /*ราคาอุปกรณ์4   */    
                                     "Acc5:" + trim(winsp.acc5)       + " " +             /*รหัส อุปกรณ์5  */    
                                     "Acd5:" + TRIM(winsp.accdetail5) + " " +             /*รายละเอียด 5   */    
                                     "Acp5:" + STRING(DECI(winsp.accprice5))              /*ราคาอุปกรณ์5     */
          brstat.tlt.rec_addr1      = trim(winsp.custcode)
          brstat.tlt.rec_addr2      = trim(winsp.tmp1)
          brstat.tlt.rec_addr3      = trim(winsp.tmp2)
          brstat.tlt.nor_noti_tlt   = ""      /*เลขที่ตรวจสภาพ */  
          brstat.tlt.safe1          = ""      /* ความเสียหาย */
          brstat.tlt.safe2          = ""      /*รายการความเสียหาย */
          brstat.tlt.safe3          = ""      /*รายละเอียดอุปกรณ์เสริม */
          brstat.tlt.filler2        = ""      /*รายละเอียดอื่นๆ */
          /*brstat.tlt.datesent       = ?       /*วันที่ปิดเรื่อง */*/
          brstat.tlt.stat           = "No"    /*ส่งข้อมูลให้ SCBPT*/ 
          brstat.tlt.entdat         = ?    .  /*วันที่ส่งรายงาน */
          RUN Proc_inspection.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE create_tlt_noti C-Win 
PROCEDURE create_tlt_noti :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
LOOP_wdetail2:
FOR EACH wdetail2 .
    IF INDEX(wdetail2.chassis,"Chassis") <> 0  THEN DELETE wdetail2.
    ELSE IF wdetail2.chassis = ""  THEN DELETE wdetail2.
    ELSE DO:
        FIND FIRST wdetail WHERE wdetail.chassis = wdetail2.chassis AND
                                 wdetail.covtyp  = wdetail2.covtyp  NO-ERROR.
        IF AVAIL wdetail THEN DO:
            IF INDEX(wdetail.chassis,"Chassis") <> 0 THEN DELETE wdetail.
            ELSE IF wdetail.chassis = "" THEN DELETE wdetail. 
            ELSE DO:
                ASSIGN  
                    nv_type = "" 
                    nv_reccnt  = nv_reccnt + 1
                    wdetail2.engine = REPLACE(wdetail2.engine,"*","").
               IF ( wdetail2.chassis = "" ) THEN 
                    MESSAGE "พบเลขตัวถังค่าว่าง..." VIEW-AS ALERT-BOX.
                ELSE DO:
                    /* ------------------------check policy  Duplicate--------------------------------------*/ 
                    IF index(wdetail2.covtyp,"CMI") <> 0 THEN ASSIGN nv_type = "V72" .
                    ELSE ASSIGN nv_type = "V70" .
                    FIND LAST brstat.tlt USE-INDEX tlt06  WHERE         
                        brstat.tlt.cha_no    = trim(wdetail2.chassis)  AND
                        brstat.tlt.eng_no    = TRIM(wdetail2.engine)   AND
                        brstat.tlt.flag      = trim(nv_type)           AND 
                        brstat.tlt.genusr    = trim(fi_compa)          NO-ERROR NO-WAIT .
                    IF NOT AVAIL brstat.tlt THEN DO: 
                        CREATE brstat.tlt.
                        nv_completecnt  =  nv_completecnt + 1.
                        
                        RUN Proc_Adddatatlt.
                        RUN Proc_AddDatatlt2.

                        ASSIGN wdetail2.pass = "Y" .
                    END.
                    ELSE DO:
                        nv_updatecnt = nv_updatecnt + 1 .
                        ASSIGN wdetail2.pass = "N".
                    END.
                END.  /*wdetail.Notify_no <> "" */
            END. /* else do: */
        END. /* if avail wdetail*/
    END. /*if avail wdetail2 */
END.   /* FOR EACH wdetail2 NO-LOCK: */
RELEASE wdetail.
RELEASE wdetail2.
RELEASE brstat.tlt.
/*Run Open_tlt.*/

IF nv_updatecnt <> 0 THEN DO:
    MESSAGE "มีข้อมูลการแจ้งงานซ้ำจำนวน " nv_updatecnt " รายการ จะทำการอัพเดทข้อมูลใหม่หรือไม่ ? " 
    VIEW-AS ALERT-BOX QUESTION BUTTON YES-NO TITLE "อัพเดทการแจ้งงาน" UPDATE choic AS LOGICAL.
    CASE choic:
        WHEN TRUE THEN DO:
            FOR EACH wdetail2 WHERE wdetail2.pass = "N" .
                FIND FIRST wdetail WHERE wdetail.chassis = wdetail2.chassis AND
                                         wdetail.covtyp  = wdetail2.covtyp  NO-ERROR.
                IF AVAIL wdetail THEN DO:
                   ASSIGN  
                       nv_type = "" 
                       wdetail2.engine = REPLACE(wdetail2.engine,"*","").
                   IF ( wdetail2.chassis = "" ) THEN 
                       MESSAGE "พบเลขตัวถังค่าว่าง..." VIEW-AS ALERT-BOX.
                   ELSE DO:
                       /* ------------------------check policy  Duplicate--------------------------------------*/ 
                       IF index(wdetail2.covtyp,"CMI") <> 0 THEN ASSIGN nv_type = "V72" .
                       ELSE ASSIGN nv_type = "V70" .
                       FIND LAST brstat.tlt USE-INDEX tlt06  WHERE         
                           brstat.tlt.cha_no    = trim(wdetail2.chassis)  AND
                           brstat.tlt.eng_no    = TRIM(wdetail2.engine)   AND
                           brstat.tlt.flag      = trim(nv_type)           AND 
                           brstat.tlt.genusr    = trim(fi_compa)          NO-ERROR NO-WAIT .
                       IF AVAIL brstat.tlt THEN DO: 
                           nv_completecnt  =  nv_completecnt + 1.
                           
                           RUN Proc_Updatatlt.
                           RUN Proc_Updatatlt2.
                           ASSIGN wdetail2.pass = "Y" .
                       END.
                   END.  /*wdetail.Notify_no <> "" */
                END. /* if avail wdetail*/
            END. /*if avail wdetail2 */
        END.
        WHEN FALSE THEN DO:
            RETURN NO-APPLY.
        END.
    END CASE.
    Run Open_tlt.            
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Create_tlt_paid C-Win 
PROCEDURE Create_tlt_paid :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*LOOP_Paid:
FOR EACH wpaid .
    IF index(wpaid.refno,"RefNo") <> 0 THEN  DELETE wpaid.
    ELSE IF wpaid.refno  = "" THEN DELETE wpaid.
    ELSE IF (wpaid.refno = "" ) THEN DO:
        MESSAGE " X-RefNo.เป็นค่าว่าง..." VIEW-AS ALERT-BOX.
    END.
    ELSE DO:
        nv_reccnt  = nv_reccnt + 1.
        FIND LAST brstat.tlt USE-INDEX tlt06  WHERE         
            brstat.tlt.cha_no          = trim(wpaid.chassis)  AND
            brstat.tlt.nor_noti_ins    = TRIM(wpaid.refno)    AND  
            brstat.tlt.flag            = "Paid"               AND 
            brstat.tlt.genusr          = trim(fi_compa)       NO-ERROR NO-WAIT .
        IF NOT AVAIL brstat.tlt THEN DO:    /*  kridtiya i. A54-0216 ....*/
            CREATE brstat.tlt.
            nv_completecnt  =  nv_completecnt + 1.
            ASSIGN                                                 
                brstat.tlt.trndat        = TODAY                           /* date  99/99/9999  */
                brstat.tlt.trntim        = STRING(TIME,"HH:MM:SS")         /* char  x(8)        */
                brstat.tlt.genusr        = TRIM(fi_compa)                                  /* SCBPT*/                    
                brstat.tlt.usrid         = USERID(LDBNAME(1))                              /*User Load Data */
                brstat.tlt.releas        = IF INT(wpaid.balance) = 0 THEN "YES" ELSE "No"  /* yes จ่ายครบ , no ยังไม่ครบ */  
                brstat.tlt.flag          = "Paid"                                         /* ประเภทไฟล์ ชำระเงิน */ 
                brstat.tlt.nor_noti_ins  = trim(wpaid.refno)    
                brstat.tlt.nor_usr_ins   = trim(wpaid.custcod)  
                brstat.tlt.lotno         = trim(wpaid.campcod)  
                brstat.tlt.usrsent       = trim(wpaid.proname)  
                brstat.tlt.rec_addr5     = "Planam:" + trim(wpaid.planame)  + " " +
                                           "Plan:" + trim(wpaid.plan)     
                brstat.tlt.ins_name      = trim(wpaid.polname)  
                brstat.tlt.rec_name      = trim(wpaid.payname)  
                brstat.tlt.lince1        = trim(wpaid.Liencen)  
                brstat.tlt.cha_no        = trim(wpaid.chassis)  
                brstat.tlt.imp           = trim(wpaid.instyp)  
                brstat.tlt.rec_addr3     = trim(wpaid.covtyp)  
                brstat.tlt.old_cha       = trim(wpaid.garage)  
                brstat.tlt.gendat        = Date(wpaid.comdate)  
                brstat.tlt.expodat       = Date(wpaid.expdate)  
                brstat.tlt.nor_coamt     = deci(wpaid.sumins)  
                brstat.tlt.comp_grprm    = deci(wpaid.netprem)  
                brstat.tlt.stat          = "Stamp:" + STRING(DECI(wpaid.stamp))  + " " +
                                           "Vat:" + STRING(DECI(wpaid.vat))      
                brstat.tlt.comp_coamt    = DECI(wpaid.totalprem)
                brstat.tlt.comp_noti_ins = "Othdis:" + string(deci(wpaid.othdis)) + " " +   
                                           "Othrat:" + string(deci(wpaid.othrate))  
                brstat.tlt.safe3         = trim(wpaid.wht)      
                brstat.tlt.comp_sub      = trim(wpaid.typpol)   
                brstat.tlt.safe2         = trim(wpaid.paytyp)   
                brstat.tlt.datesent      = IF trim(wpaid.saledat) <> "" THEN date(SUBSTR(wpaid.saledat,1,INDEX(wpaid.saledat," "))) ELSE ?
                brstat.tlt.rec_addr4     = trim(wpaid.paysts)   
                brstat.tlt.dat_ins_noti  = DATE(wpaid.paydate)  
                brstat.tlt.exp           = STRING(deci(wpaid.payamount))
                brstat.tlt.safe1         = STRING(deci(wpaid.balance))
                brstat.tlt.endcnt        = 1
                brstat.tlt.filler2       = IF INT(wpaid.balance) = 0 THEN "ชำระเงินครบ" 
                                           ELSE "ชำระบางส่วน : ครั้งที่ 1 " + TRIM(wpaid.paydate) + " " + 
                                                "จำนวน " + STRING(deci(wpaid.payamount)) + ".-  " + 
                                                "ยอดคงเหลือ " + STRING(deci(wpaid.balance)) + ".-" .
        END.
        ELSE DO: 
            nv_completecnt  =  nv_completecnt + 1.
            RUN Create_tlt_paid2.
        END.
    END.  /*winsp.Notify_no <> "" */
END.   /* FOR EACH winsp NO-LOCK: */
Run Open_tlt.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE create_tlt_paid2 C-Win 
PROCEDURE create_tlt_paid2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*DO:
    ASSIGN                                        
           brstat.tlt.trndat        = TODAY                           /* date  99/99/9999  */
           brstat.tlt.trntim        = STRING(TIME,"HH:MM:SS")         /* char  x(8)        */
           brstat.tlt.genusr        = TRIM(fi_compa)                                  /* SCBPT*/                    
           brstat.tlt.usrid         = USERID(LDBNAME(1))                              /*User Load Data */
           brstat.tlt.releas        = IF INT(wpaid.balance) = 0 THEN "YES" ELSE "No"  /* yes จ่ายครบ , no ยังไม่ครบ */  
           brstat.tlt.flag          = "Paid"                                         /* ประเภทไฟล์ ชำระเงิน */ 
           brstat.tlt.nor_noti_ins  = trim(wpaid.refno)    
           brstat.tlt.nor_usr_ins   = trim(wpaid.custcod)  
           brstat.tlt.lotno         = trim(wpaid.campcod)  
           brstat.tlt.usrsent       = trim(wpaid.proname)  
           brstat.tlt.rec_addr5     = "Planam:" + trim(wpaid.planame)  + " " +
                                      "Plan:" + trim(wpaid.plan)     
           brstat.tlt.ins_name      = trim(wpaid.polname)  
           brstat.tlt.rec_name      = trim(wpaid.payname)  
           brstat.tlt.lince1        = trim(wpaid.Liencen)  
           brstat.tlt.cha_no        = trim(wpaid.chassis)  
           brstat.tlt.imp           = trim(wpaid.instyp)  
           brstat.tlt.rec_addr3     = trim(wpaid.covtyp)  
           brstat.tlt.old_cha       = trim(wpaid.garage)  
           brstat.tlt.gendat        = Date(wpaid.comdate)  
           brstat.tlt.expodat       = Date(wpaid.expdate)  
           brstat.tlt.nor_coamt     = deci(wpaid.sumins)  
           brstat.tlt.comp_grprm    = deci(wpaid.netprem)  
           brstat.tlt.stat          = "Stamp:" + STRING(DECI(wpaid.stamp))  + " " +
                                      "Vat:" + STRING(DECI(wpaid.vat))      
           brstat.tlt.comp_coamt    = DECI(wpaid.totalprem)
           brstat.tlt.comp_noti_ins = "Othdis:" + string(deci(wpaid.othdis)) + " " +   
                                      "Othrat:" + string(deci(wpaid.othrate))  
           brstat.tlt.safe3         = trim(wpaid.wht)      
           brstat.tlt.comp_sub      = trim(wpaid.typpol)   
           brstat.tlt.safe2         = trim(wpaid.paytyp)   
           brstat.tlt.datesent      = IF trim(wpaid.saledat) <> "" THEN date(SUBSTR(wpaid.saledat,1,INDEX(wpaid.saledat," "))) ELSE ? .

        IF brstat.tlt.dat_ins_not <> DATE(wpaid.paydate) THEN DO:
            ASSIGN 
                 brstat.tlt.rec_addr4     = trim(wpaid.paysts)   
                 brstat.tlt.dat_ins_noti  = DATE(wpaid.paydate)  
                 brstat.tlt.exp           = STRING(deci(wpaid.payamount))
                 brstat.tlt.safe1         = STRING(deci(wpaid.balance))
                 brstat.tlt.endcnt        = brstat.tlt.endcnt + 1
                 brstat.tlt.filler2       = IF INT(wpaid.balance) = 0 THEN "ชำระเงินครบ" 
                                            ELSE brstat.tlt.filler2 + "| ชำระบางส่วน : ครั้งที่" +  STRING(tlt.endcnt) + " " + 
                                                 TRIM(wpaid.paydate) + " " + "จำนวน " + STRING(deci(wpaid.payamount)) + ".-  " + 
                                                 "ยอดคงเหลือ " + STRING(deci(wpaid.balance)) + ".-" .
        END.
END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

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
  DISPLAY fi_loaddat fi_compa ra_txttyp fi_producer fi_agent fi_insp fi_filename 
          fi_proname fi_impcnt fi_completecnt fi_proname2 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_loaddat fi_compa ra_txttyp fi_producer fi_agent fi_insp fi_filename 
         bu_file bu_ok bu_exit br_imptxt bu_hpacno1 bu_hpacno2 RECT-1 RECT-387 
         RECT-388 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Import_Inspection C-Win 
PROCEDURE Import_Inspection :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH  winsp :
    DELETE  winsp.
END.
INPUT FROM VALUE(fi_FileName).
REPEAT:
    CREATE winsp.
    IMPORT DELIMITER "|"
       /* winsp.n_no  */ /*A64-0295*/    
        winsp.inscode     
        winsp.campcode    
        winsp.campname    
        winsp.procode     
        winsp.proname     
        winsp.packcode    
        winsp.packname    
        winsp.Refno       
        /*winsp.custcode*/ /*A64-0295*/
        winsp.pol_fname   
        winsp.pol_lname   
        winsp.pol_tel     
        winsp.tmp1
        winsp.tmp2
        winsp.instype     
        winsp.inspdate    
        winsp.insptime    
        winsp.inspcont    
        winsp.insptel     
        winsp.lineid      
        winsp.mail        
        winsp.inspaddr    
        winsp.brand       
        winsp.Model       
        winsp.class       
        winsp.seatenew    
        winsp.power       
        winsp.weight      
        winsp.province    
        winsp.yrmanu      
        winsp.licence     
        winsp.chassis     
        winsp.engine      
        winsp.comdat      
        winsp.expdat      
        winsp.ins_amt     
        winsp.premtotal   
        winsp.acc1        
        winsp.accdetail1  
        winsp.accprice1   
        winsp.acc2        
        winsp.accdetail2  
        winsp.accprice2   
        winsp.acc3        
        winsp.accdetail3  
        winsp.accprice3   
        winsp.acc4        
        winsp.accdetail4  
        winsp.accprice4   
        winsp.acc5        
        winsp.accdetail5  
        winsp.accprice5  
        winsp.Selling_Channel.  /*Add Kridtiya i. A64-0295 DATE. 25/07/2021*/   
    /*Kridtiya i. A64-0295 DATE. 25/07/2021
    IF index(winsp.n_no,"line") <> 0 THEN DELETE winsp.
    ELSE IF index(winsp.n_no,"no") <> 0 THEN DELETE winsp. 
    ELSE IF index(winsp.n_no,"num") <> 0 THEN DELETE winsp.
    ELSE IF winsp.n_no  = "" THEN  DELETE winsp.
    Kridtiya i. A64-0295 DATE. 25/07/2021*/
    IF winsp.inscode = ""  THEN DELETE winsp.  /*Kridtiya i. A64-0295 DATE. 25/07/2021*/
    ELSE IF index(winsp.inscode,"CustCode")   <> 0   THEN DELETE winsp. 
    ELSE IF index(winsp.inscode,"ProspectID") <> 0   THEN DELETE winsp.   

END.  /* repeat  */ 
FIND FIRST bfwinsp WHERE 
   /* index("0123456789",bfwinsp.n_no) <> 0 AND */
    bfwinsp.inscode <> "" AND 
    INDEX(bfwinsp.inscode,"CustCode") = 0  NO-LOCK NO-ERROR NO-WAIT.

    IF AVAIL bfwinsp THEN DO:
        ASSIGN nv_reccnt       = 0
               nv_completecnt  = 0 
               nv_updatecnt    = 0. 
        Run  Create_tlt_insp. 
    END.
    ELSE DO: 
       MESSAGE " Format ไฟล์ตรวจสภาพไม่ถูกต้อง " VIEW-AS ALERT-BOX.
       FOR EACH winsp:
           DELETE winsp.
       END.
       RETURN NO-APPLY.
    END.

If  nv_completecnt  <>  0  Then do:
    Enable br_imptxt  With frame fr_main.
End. 

fi_completecnt  =  nv_completecnt.
fi_impcnt       =  nv_reccnt.
Run Open_tlt.

Disp fi_completecnt   fi_impcnt with frame  fr_main.
Message "Load  Data Inspection Finnish "  View-as alert-box.  

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE import_notification C-Win 
PROCEDURE import_notification :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH  wdetail :
    DELETE  wdetail.
END.
FOR EACH  wdetail2 :
    DELETE  wdetail2.
END.
RUN Proc_Cleardata.
INPUT FROM VALUE(fi_FileName).
REPEAT:
    IMPORT DELIMITER "|"
        n_cmr_code     
        n_comp_code    
        n_campcode     
        n_campname     
        n_procode      
        n_proname      
        n_packname     
        n_packcode     
        n_instype      
        n_pol_title    
        n_pol_fname    
        n_pol_lname    
        n_pol_title_eng
        n_pol_fname_eng
        n_pol_lname_eng
        n_icno         
        n_sex          
        n_bdate        
        n_occup        
        n_tel          
        n_phone        
        n_teloffic     
        n_telext       
        n_moblie       
        n_mobliech     
        n_mail         
        n_lineid       
        n_addr1_70          /*เลขที่บ้าน   */  
        n_addr2_70          /*หมู่บ้าน     */ 
        n_addr3_70          /*หมู่         */ 
        n_addr4_70          /*ซอย          */ 
        n_addr5_70          /*ถนน          */ 
        n_nsub_dist70       /*รหัสแขวง     */ 
        n_ndirection70      /*เขต/อำเภอ    */ 
        n_nprovin70         /*จังหวัด      */ 
        n_zipcode70         /*รหัสไปรษณีย์ */ 
        n_addr1_72          /*เลขที่บ้าน   จัดส่ง */ 
        n_addr2_72          /*หมู่บ้าน     จัดส่ง */ 
        n_addr3_72          /*หมู่         จัดส่ง */ 
        n_addr4_72          /*ซอย          จัดส่ง */ 
        n_addr5_72          /*ถนน          จัดส่ง */ 
        n_nsub_dist72       /*รหัสแขวง     จัดส่ง */ 
        n_ndirection72      /*เขต/อำเภอ    จัดส่ง */ 
        n_nprovin72         /*จังหวัด      จัดส่ง */ 
        n_zipcode72         /*รหัสไปรษณีย์ จัดส่ง */ 
        n_paytype         
        n_paytitle     
        n_payname      
        n_paylname     
        n_payicno      
        n_payaddr1          /*เลขที่บ้าน   ชำระเงิน */      
        n_payaddr2          /*หมู่บ้าน     ชำระเงิน */   
        n_payaddr3          /*หมู่         ชำระเงิน */   
        n_payaddr4          /*ซอย          ชำระเงิน */   
        n_payaddr5          /*ถนน          ชำระเงิน */   
        n_payaddr6          /*รหัสแขวง     ชำระเงิน */   
        n_payaddr7          /*เขต/อำเภอ    ชำระเงิน */   
        n_payaddr8          /*จังหวัด      ชำระเงิน */   
        n_payaddr9          /*รหัสไปรษณีย์ ชำระเงิน */   
        n_branch            
        n_ben_title         
        n_ben_name          
        n_ben_lname         
        n_ben_2title        /*Add Kridtiya i. A64-0295 DATE. 25/07/2021*/
        n_ben_2name         /*Add Kridtiya i. A64-0295 DATE. 25/07/2021*/
        n_ben_2lname        /*Add Kridtiya i. A64-0295 DATE. 25/07/2021*/
        n_ben_3title        /*Add Kridtiya i. A64-0295 DATE. 25/07/2021*/
        n_ben_3name         /*Add Kridtiya i. A64-0295 DATE. 25/07/2021*/
        n_ben_3lname        /*Add Kridtiya i. A64-0295 DATE. 25/07/2021*/
        n_pmentcode    
        n_pmenttyp     
        n_pmentcode1   
        n_pmentcode2   
        n_pmentbank    
        n_pmentdate    
        n_pmentsts     
        n_driver       
        n_drivetitle1  
        n_drivename1   
        n_drivelname1  
        n_driveno1     
        n_occupdriv1   
        n_sexdriv1     
        n_bdatedriv1   
        n_drivetitle2  
        n_drivename2   
        n_drivelname2  
        n_driveno2     
        n_occupdriv2   
        n_sexdriv2     
        n_bdatedriv2   
        n_brand        
        n_brand_cd     
        n_Model        
        n_Model_cd     
        n_body         
        n_body_cd      
        n_licence      
        n_province     
        n_chassis      
        n_engine       
        n_yrmanu       
        n_seatenew     
        n_power        
        n_weight       
        n_class        
        n_garage_cd    
        n_garage       
        n_colorcode    
        n_covcod       
        n_covtyp       
        n_covtyp1      
        n_covtyp2      
        n_covtyp3      
        n_comdat       
        n_expdat       
        n_ins_amt      
        n_prem1        
        n_gross_prm    
        n_stamp        
        n_vat          
        n_premtotal    
        n_deduct       
        n_fleetper     
        n_fleet        
        n_ncbper       
        n_ncb          
        n_drivper      
        n_drivdis      
        n_othper       
        n_oth          
        n_cctvper      
        n_cctv         
        n_Surcharper   
        n_Surchar      
        n_Surchardetail
        n_acc1         
        n_accdetail1   
        n_accprice1    
        n_acc2         
        n_accdetail2   
        n_accprice2    
        n_acc3         
        n_accdetail3   
        n_accprice3    
        n_acc4         
        n_accdetail4   
        n_accprice4    
        n_acc5         
        n_accdetail5   
        n_accprice5    
        n_inspdate     
        n_inspdate_app 
        n_inspsts      
        n_inspdetail   
        n_not_date     
      /*n_paydate      
        n_paysts */      
        n_licenBroker  
        n_brokname     
        n_brokcode     
        n_lang         
        n_deli         
        n_delidetail   
        n_gift         
        n_cedcode      
        n_inscode      
        n_remark       
        n_Agent_Code              /* Add Kridtiya i. A64-0295 DATE. 25/07/2021 */ 
        n_Agent_Name_TH           /* Add Kridtiya i. A64-0295 DATE. 25/07/2021 */ 
        n_Agent_Name_Eng          /* Add Kridtiya i. A64-0295 DATE. 25/07/2021 */ 
        n_Selling_Channel         /* Add Kridtiya i. A64-0295 DATE. 25/07/2021 */  
        /*-- Add By Tontawan S. A68-0059 27/03/2025 --*/
        n_drv3_salutation_M       // คนขับ 3 : คำนำหน้า          
        n_drv3_fname              // คนขับ 3 : ชื่อ              
        n_drv3_lname              // คนขับ 3 : นามสกุล           
        n_drv3_nid                // คนขับ 3 : เลขบัตรประชาชน    
        n_drv3_occupation         // คนขับ 3 : อาชีพ             
        n_drv3_gender             // คนขับ 3 : เพศ               
        n_drv3_birthdate          // คนขับ 3 : วันเกิด           
        n_drv4_salutation_M       // คนขับ 4 : คำนำหน้า          
        n_drv4_fname              // คนขับ 4 : ชื่อ              
        n_drv4_lname              // คนขับ 4 : นามสกุล           
        n_drv4_nid                // คนขับ 4 : เลขบัตรประชาชน    
        n_drv4_occupation         // คนขับ 4 : อาชีพ             
        n_drv4_gender             // คนขับ 4 : เพศ               
        n_drv4_birthdate          // คนขับ 4 : วันเกิด           
        n_drv5_salutation_M       // คนขับ 5 : คำนำหน้า          
        n_drv5_fname              // คนขับ 5 : ชื่อ              
        n_drv5_lname              // คนขับ 5 : นามสกุล           
        n_drv5_nid                // คนขับ 5 : เลขบัตรประชาชน    
        n_drv5_occupation         // คนขับ 5 : อาชีพ             
        n_drv5_gender             // คนขับ 5 : เพศ               
        n_drv5_birthdate          // คนขับ 5 : วันเกิด           
        n_drv1_dlicense           // คนขับ 1 : รหัสผู้ขับขี่ 1         
        n_drv2_dlicense           // คนขับ 2 : รหัสผู้ขับขี่ 2         
        n_drv3_dlicense           // คนขับ 3 : รหัสผู้ขับขี่ 3         
        n_drv4_dlicense           // คนขับ 4 : รหัสผู้ขับขี่ 4         
        n_drv5_dlicense           // คนขับ 5 : รหัสผู้ขับขี่ 5         
        n_baty_snumber            // Battery : Serial Number     
        n_batydate                // Battery : Year              
        n_baty_rsi                // Battery : Replacement SI    
        n_baty_npremium           // Battery : Net Premium       
        n_baty_gpremium           // Battery : Gross_Premium     
        n_wcharge_snumber         // Wall Charge : Serial_Number 
        n_wcharge_si              // Wall Charge : SI            
        n_wcharge_npremium        // Wall Charge : Net Premium   
        n_wcharge_gpremium.       // Wall Charge : Gross Premium 
        /*-- End By Tontawan S. A68-0059 27/03/2025 --*/

    IF            n_cmr_code         = "" THEN NEXT.
    ELSE IF INDEX(n_cmr_code,"Insurer") <> 0 THEN NEXT.
    /*-- Add By Tontawan S. A66-0006 25/05/2023 --*/
    ELSE IF n_chassis = "" THEN DO: 
        MESSAGE " พบเลขตัวถังเป็นค่าว่าง... (Column CV) " n_pol_title n_pol_fname n_pol_lname VIEW-AS ALERT-BOX WARNING.
        NEXT. 
    END.
    /*-- End By Tontawan S. A66-0006 25/05/2023 --*/
    ELSE DO:
        RUN proc_chkaddrcut.  //A68-0059
        RUN proc_chkcut.      //A68-0059

        /*-- Add By Tontawan S. A66-0006 25/05/2023 --
        IF n_drivename1 = "" AND n_drivename2 = "" THEN n_driver = "0".
        ELSE DO:
            IF n_drivename2 <> "" THEN n_driver = "2".
            ELSE DO:
                IF n_drivename1 <> "" THEN n_driver = "1".
            END.
            /*-- End By Tontawan S. A66-0006 25/05/2023 --*/
        END.*/
   
        /*-- Add By Tontawan S. A68-0059 27/03/2025 --*/
        IF n_drivename1 = "" AND n_drivename2 = "" AND
           n_drv3_fname = "" AND n_drv4_fname = "" AND
           n_drv5_fname = "" THEN n_driver = "0".
        ELSE DO:
            IF n_drv5_fname <> "" THEN n_driver = "5".
            ELSE DO:
                IF n_drv4_fname <> "" THEN n_driver = "4".
                ELSE DO:
                    IF n_drv3_fname <> "" THEN n_driver = "3".
                    ELSE DO:
                        IF n_drivename2 <> "" THEN n_driver = "2".
                        ELSE DO:
                            IF n_drivename1 <> "" THEN n_driver = "1".
                        END.
                    END.
                END.
            END.
        END.
        /*-- End By Tontawan S. A68-0059 27/03/2025 --*/

        RUN proc_create.
        RUN proc_cleardata.
    END.
END.      /* repeat  */ 
FIND FIRST bfwdetail WHERE INDEX(bfwdetail.comp_code,"คุ้มภัย") = 0 NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL bfwdetail THEN DO:
    MESSAGE " Format ไฟล์แจ้งงานไม่ถูกต้อง " VIEW-AS ALERT-BOX.
    FOR EACH wdetail:
        DELETE wdetail.
    END.
    FOR EACH wdetail2:
        DELETE wdetail2.
    END.
    RETURN NO-APPLY.
END.
ELSE DO: 
    ASSIGN nv_reccnt   = 0
        nv_completecnt = 0 . 
    Run Create_tlt_noti. 
END.
If  nv_completecnt  <>  0  Then do:
    Enable br_imptxt  With frame fr_main.
END.
fi_completecnt  =  nv_completecnt.
fi_impcnt       =  nv_reccnt.
Disp fi_completecnt   fi_impcnt with frame  fr_main.
Message "Load  Data Finnish "  View-as alert-box.  
Run Open_tlt.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE IMPORT_Payment C-Win 
PROCEDURE IMPORT_Payment :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*FOR EACH  wpaid :
    DELETE  wpaid.
END.
INPUT FROM VALUE(fi_FileName).
REPEAT:
    CREATE wpaid.
    IMPORT DELIMITER "|"
        wpaid.refno     
        wpaid.custcod   
        wpaid.campcod   
        wpaid.proname   
        wpaid.planame   
        wpaid.plan      
        wpaid.polname   
        wpaid.payname   
        wpaid.Liencen   
        wpaid.chassis   
        wpaid.instyp    
        wpaid.covtyp    
        wpaid.garage    
        wpaid.comdate   
        wpaid.expdate   
        wpaid.sumins    
        wpaid.netprem   
        wpaid.stamp     
        wpaid.vat       
        wpaid.totalprem 
        wpaid.othdis    
        wpaid.othrate   
        wpaid.wht       
        wpaid.typpol    
        wpaid.paytyp    
        wpaid.saledat   
        wpaid.paysts    
        wpaid.paydate   
        wpaid.payamount 
        wpaid.balance .

       IF wpaid.refno  = "" THEN  NEXT.
END.  /* repeat  */ 

ASSIGN nv_reccnt       = 0
       nv_completecnt  = 0 . 
Run  Create_tlt_paid. 

If  nv_completecnt  <>  0  Then do:
    Enable br_imptxt  With frame fr_main.
End. 

fi_completecnt  =  nv_completecnt.
fi_impcnt       =  nv_reccnt.

Disp fi_completecnt   fi_impcnt with frame  fr_main.
Message "Load  Data Inspection Complete"  View-as alert-box.  
Run Open_tlt.*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Open_tlt C-Win 
PROCEDURE Open_tlt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF ra_txttyp = 1  THEN DO:
    Open Query br_imptxt  For each tlt  Use-index tlt01  where
               tlt.trndat     = fi_loaddat    AND
               tlt.flag       >= "V70"        AND
               tlt.flag       <= "V72"        AND
               tlt.genusr     =  fi_compa     NO-LOCK .
END.
ELSE IF ra_txttyp = 2 THEN do: 
    Open Query br_imptxt  For each tlt  Use-index tlt01  where
               tlt.trndat     =  TODAY        and
               tlt.flag       = "INSPEC"      AND
               tlt.genusr     =  fi_compa     NO-LOCK .
END.
/*ELSE DO:
    Open Query br_imptxt  For each tlt  Use-index tlt01  where
               tlt.trndat     =  TODAY        and
               tlt.flag       = "Paid"        AND
               tlt.genusr     =  fi_compa     NO-LOCK .
END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_AddDatatlt C-Win 
PROCEDURE Proc_AddDatatlt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    ASSIGN   brstat.tlt.entdat        = TODAY                           /* date  99/99/9999  */
             brstat.tlt.enttim        = STRING(TIME,"HH:MM:SS")         /* char  x(8)        */
             brstat.tlt.trndat        = fi_loaddat
             brstat.tlt.genusr        = "SCBPT"        
             brstat.tlt.usrid         = USERID(LDBNAME(1))          
             brstat.tlt.flag          = IF index(wdetail2.covtyp,"CMI") <> 0 THEN "V72" ELSE "V70"         
             brstat.tlt.policy        = ""        
             brstat.tlt.releas        = "NO"        
             brstat.tlt.subins        = TRIM(fi_producer)        
             brstat.tlt.recac         = TRIM(fi_agent)
             brstat.tlt.lotno         = "InsCode:" + trim(wdetail.cmr_code)  + " " +   /*รหัสบริษัทประกันภัย */                   
                                        "InsName:" + trim(wdetail.comp_code) + " " +   /*ชื่อบริษัทประกันภัย */                   
                                        "CamCode:" + trim(wdetail.campcode)  + " " +   /*รหัสแคมเปญ    */                   
                                        "CamName:" + trim(wdetail.campname)            /*ชื่อแคมเปญ    */                   
             brstat.tlt.usrsent       = "ProCode:" + trim(wdetail.procode ) + " " +    /*รหัสผลิตภัณฑ์ */                   
                                        "ProName:" + trim(wdetail.proname ) + " " +    /*ชื่อผลิตภัณฑ์ */                   
                                        "PackNam:" + trim(wdetail.packname) + " " +    /*ชื่อแพคเกจ    */                   
                                        "PackCod:" + trim(wdetail.packcode)            /*รหัสแพคเกจ    */                   
             brstat.tlt.imp           = TRIM(wdetail.instype)                          /*ประเภท        */                   
             brstat.tlt.ins_name      = "NameTha:" + trim(wdetail.pol_title) + " "     /*คำนำหน้าชื่อ  */                   
                                                   + trim(wdetail.pol_fname) + " "     /*ชื่อผู้เอาประกัน    */                   
                                                   + trim(wdetail.pol_lname) + " " +   /*นามสกุลผู้เอาประกัน */                   
                                        "NameEng:" + trim(wdetail.pol_title_eng) + " " /*คำนำหน้าชื่อ  ภาษาอังกฤษ  */             
                                                   + trim(wdetail.pol_fname_eng) + " " /*ชื่อภาษา อังกฤษ           */             
                                                   + trim(wdetail.pol_lname_eng)       /*นามสกุลภาษา อังกฤษ        */             
             brstat.tlt.rec_addr5     = "ICNo:"  + trim(wdetail.icno)  + " " +         /*เลขที่บัตรประชาชน/เลขที่ผูเสียภาษี   */  
                                        "Sex:"   + trim(wdetail.sex)   + " " +         /*เพศ                          */          
                                        "Birth:" + trim(wdetail.bdate) + " " +         /*วันเดือนปีเกิด ( DD/MM/YYYY) */          
                                        "Occup:" + trim(wdetail.occup)                 /*อาชีพ                        */          
             brstat.tlt.ins_addr5     = "Phone:" + TRIM(wdetail.tel) + " " + TRIM(wdetail.phone) + " "          /*เบอร์โทรบ้าน ที่ทำงาน มือถือ*/          
                                                 + trim(wdetail.teloffic) + " " + TRIM(wdetail.telext) + " "      
                                                 + TRIM(wdetail.moblie) + " " + trim(wdetail.mobliech) + " " +    
                                        "Email:" + TRIM(wdetail.mail) + " " +                                 /*email   */                              
                                        "Linid:" + TRIM(wdetail.lineid)                                       /*Line_ID */    
             brstat.tlt.ins_addr1     = trim(wdetail.addr1_70) + " " + trim(wdetail.addr2_70)  + " " +        /*ที่อยูลูกค้า*/    
                                        trim(wdetail.addr3_70) + " " + trim(wdetail.addr4_70)  + " " +        
                                        trim(wdetail.addr5_70)                                                
             brstat.tlt.ins_addr2     = trim(wdetail.nsub_dist70) + " " + trim(wdetail.ndirection70) + " " +  
                                        trim(wdetail.nprovin70) + " " + trim(wdetail.zipcode70)               
             brstat.tlt.ins_addr3     = trim(wdetail.addr1_72) + " " + trim(wdetail.addr2_72) + " " +         /*ที่อยูจัดส่ง*/        
                                        trim(wdetail.addr3_72) + " " + TRIM(wdetail.addr4_72) + " " +         
                                        trim(wdetail.addr5_72)                                                
             brstat.tlt.ins_addr4     = trim(wdetail.nsub_dist72) + " " + trim(wdetail.ndirection72) + " " +  
                                        trim(wdetail.nprovin72) + " " + TRIM(wdetail.zipcode72)               
             brstat.tlt.exp           = "PayTyp:" + TRIM(wdetail.paytype) + " " +                             /*ประเภท ผู้จ่ายเงิน*/
                                        "Branch:" + TRIM(wdetail.branch)                                      /*สาขา*/
             brstat.tlt.rec_name      = trim(wdetail.paytitle) + " " + trim(wdetail.payname) + " " + TRIM(wdetail.paylname) /* ชื่อ - สกุล ผู้จ่ายเงิน*/
             brstat.tlt.comp_sub      = trim(wdetail.payicno)                                                               /* เลขบัตร ปปช. ผู้จ่ายเงิน*/
             brstat.tlt.rec_addr1     = trim(wdetail.payaddr1) + " " + TRIM(wdetail.payaddr2) + " " +        /*ที่อยู่ออกใบเสร็จ */
                                        trim(wdetail.payaddr3) + " " + trim(wdetail.payaddr4) + " " + 
                                        trim(wdetail.payaddr5)
             brstat.tlt.rec_addr2     = trim(wdetail.payaddr6) + " " + TRIM(wdetail.payaddr7) + " " +
                                        trim(wdetail.payaddr8) + " " + trim(wdetail.payaddr9)
             brstat.tlt.safe1         = trim(wdetail.ben_title) + " " + TRIM(wdetail.ben_name) + " " + trim(wdetail.ben_lname) /*ชื่อ - สกุล ผู้รับผลประโยชน์*/
             brstat.tlt.safe2         = "PaymentMD:"   + trim(wdetail.pmentcode)  + " " + /*รหัสประเภทการชำระเบี้ยประกัน*/  
                                        "PaymentMDTy:" + TRIM(wdetail.pmenttyp)   + " " + /*ประเภทการชำระเบี้ยประกัน    */  
                                        "PaymentTyCd:" + trim(wdetail.pmentcode1) + " " + /*รหัสช่องทางที่ชำระเบี้ย*/  
                                        "Paymentty:"   + trim(wdetail.pmentcode2)         /*ช่องทางที่ชำระค่าเบี้ย */  
             brstat.tlt.safe3         = TRIM(wdetail.pmentbank)                           /*ธนาคารที่ชำระเบี้ย*/  
             brstat.tlt.rec_addr4     = "Paydat:" + trim(wdetail.pmentdate) + " " +       /*วันที่ชำระค่าเบี้ย*/  
                                        "PaySts:" + trim(wdetail.pmentsts)  + " " +       /*สถานะการชำระเบี้ย */  
                                        "Paid:"   + trim(wdetail2.paysts)                 /*สถานะการจ่ายเงิน*/
             brstat.tlt.datesent      = if wdetail2.not_date = "" then ? else date(wdetail2.not_date)                           /*วันที่ขาย       */
             brstat.tlt.dat_ins_noti  = if wdetail2.paydate  = "" then ? else date(wdetail2.paydate)                            /*วันที่รับชำระเงิน */  
             /*brstat.tlt.endcnt      = IF wdetail.driver = "ไม่ระบุผู้ขับขี่" THEN 0 ELSE INT(wdetail.driver)  /*การระบุชื่อผู้ขับ */  --- Comment By Tontawan S. A66-0006 --*/  
             brstat.tlt.endcnt        = INT(wdetail.driver)    /*การระบุชื่อผู้ขับ */ /*------ Add By Tontawan S. A66-0006 --*/
             brstat.tlt.dri_name1     = "Drinam1:" + trim(wdetail.drivetitle1) + " " +    /*คำนำหน้าชื่อ ผู้ขับขี่ 1  */ 
                                                     trim(wdetail.drivename1)  + " " +    /*ชื่อผู้ขับขี่ 1 */    
                                                     trim(wdetail.drivelname1) + " " +    /*นามสกุล ผู้ขับขี่ 1   */  
                                        "DriId1:"  + trim(wdetail.driveno1)               /*เลขที่บัตรผู้ขับขี่ 1 */  
             brstat.tlt.dri_no1       = "DriOcc1:" + trim(wdetail.occupdriv1) + " " +     /*Driver1Occupation  */  
                                        "DriSex1:" + TRIM(wdetail.sexdriv1)   + " " +     /*เพศ ผู้ขับขี่ 1 */ 
                                        "DriBir1:" + trim(wdetail.bdatedriv1)             /*วันเดือนปีเกิดผู้ขับขี่ 1 */ 
             brstat.tlt.dri_name2     = "Drinam2:" + trim(wdetail.drivetitle2) + " " +    /*คำนำหน้าชื่อ ผู้ขับขี่ 2  */ 
                                                     trim(wdetail.drivename2)  + " " +    /*ชื่อผู้ขับขี่ 2    */ 
                                                     trim(wdetail.drivelname2) + " " +    /*นามสกุล ผู้ขับขี่ 2*/
                                        "DriId2:"  + trim(wdetail.driveno2)               /*เลขที่บัตรผู้ขับขี่2 */ 
             brstat.tlt.dri_no2       = "DriOcc2:" + trim(wdetail.occupdriv2) + " " +     /*Driver2Occupation  */
                                        "DriSex2:" + TRIM(wdetail.sexdriv2)   + " " +      /*เพศ ผู้ขับขี่ 2    */
                                        "DriBir2:" + trim(wdetail.bdatedriv2)               /*วันเดือนปีเกิดผู้ขับขี่ 2 */
             brstat.tlt.ben83    = IF   (trim(wdetail2.ben_2title) + " " + TRIM(wdetail2.ben_2name) + " " + trim(wdetail2.ben_2lname)) = "" THEN ""
                                   ELSE  trim(wdetail2.ben_2title) + " " + TRIM(wdetail2.ben_2name) + " " + trim(wdetail2.ben_2lname)
             brstat.tlt.note4    = IF   (trim(wdetail2.ben_3title) + " " + TRIM(wdetail2.ben_3name) + " " + trim(wdetail2.ben_3lname)) = "" THEN ""
                                   ELSE  trim(wdetail2.ben_3title) + " " + TRIM(wdetail2.ben_3name) + " " + trim(wdetail2.ben_3lname)
                                       
             brstat.tlt.agent    = TRIM(wdetail2.Agent_Code) 
             brstat.tlt.note1    = trim(wdetail2.Agent_Name_TH)     
             brstat.tlt.note2    = trim(wdetail2.Agent_Name_Eng)     
             brstat.tlt.note3    = trim(wdetail2.Selling_Channel).                 
END.            
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_AddDatatlt2 C-Win 
PROCEDURE Proc_AddDatatlt2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    ASSIGN 
           brstat.tlt.brand         = TRIM(wdetail2.brand)           /*ชื่อรถยนต์         */                                    
           brstat.tlt.model         = trim(wdetail2.Model)           /*ชื่อรุ่นรถยนต์     */                                    
           brstat.tlt.expousr       = trim(wdetail2.body)            /*แบบตัวถัง          */                                    
           brstat.tlt.lince1        = trim(wdetail2.licence)         /*ทะเบียนรถ          */                                    
           brstat.tlt.lince2        = trim(wdetail2.province)        /*จังหวัดที่จดทะเบียน*/                                    
           brstat.tlt.cha_no        = CAPS(trim(wdetail2.chassis))   /*เลขตัวถัง          */                                    
           brstat.tlt.eng_no        = CAPS(trim(wdetail2.engine))    /*เลขเครื่องยนต์     */                                    
           brstat.tlt.gentim        = trim(wdetail2.yrmanu)          /*ปีจดทะเบียนรถ      */                                    
           brstat.tlt.sentcnt       = INT(wdetail2.seatenew)         /*จำนวนที่นั่ง       */                                    
           brstat.tlt.rencnt        = INT(wdetail2.power)            /*ขนาดเครื่องยนต์    */                                    
           brstat.tlt.cc_weight     = INT(wdetail2.weight)           /*น้ำหนัก            */                                    
           brstat.tlt.expotim       = trim(wdetail2.class)           /*รหัสการใช้รถยนต์   */                                    
           brstat.tlt.old_cha       = "GarCd:" + trim(wdetail2.garage_cd) + " " + /*รหัสการซ่อม        */                 
                                      "GarTy:" + trim(wdetail2.garage)            /*ประเภทการซ่อม      */                 
           brstat.tlt.colorcod      = trim(wdetail2.colorcode) /*สีรถยนต์  */                                             
           brstat.tlt.rec_addr3     = "CovCod:" + trim(wdetail2.covcod)  + " " +        /*ประเภทของประกันภัย        */    
                                      "CovTcd:" + trim(wdetail2.covtyp)  + " " +        /*รหัสประเภทของประกันภัย    */    
                                      "CovTyp:" + trim(wdetail2.covtyp1) + " " +        /*ประเภทของความคุ้มครอง     */    
                                      "CovTy1:" + trim(wdetail2.covtyp2) + " " +        /*ประเภทย่อยของความคุ้มครอง */    
                                      "CovTy2:" + trim(wdetail2.covtyp3)                /*รายละเอียดความคุ้มครอง    */    
           brstat.tlt.gendat        = date(wdetail2.comdat)                              /*วันเริ่มความคุ้มครอง      */   
                                                  
           brstat.tlt.expodat       = DATE(wdetail2.expdat)       
           brstat.tlt.nor_coamt     = DECI(wdetail2.ins_amt)                            /*ทุนประกัน                 */    
           brstat.tlt.nor_grprm     = DECI(wdetail2.prem1)                              /*เบี้ยสุทธิก่อนหักส่วนลด   */    
           brstat.tlt.comp_grprm    = DECI(wdetail2.gross_prm)                          /*เบี้ยสุทธิหลังหักส่วนลด   */    
           brstat.tlt.stat          = "Stm:" + STRING(deci(wdetail2.stamp)) + " " +     /*จำนวนอากรสแตมป์       */    
                                      "Vat:" + STRING(DECI(wdetail2.vat))               /*จำนวนภาษี SBT/Vat     */    
           brstat.tlt.comp_coamt    = deci(wdetail2.premtotal)                          /*เบี้ยรวม ภาษี-อากร    */    
           brstat.tlt.endno         = IF wdetail2.deduct = "no" THEN "0" ELSE string(DECI(wdetail2.deduct))                     /*ค่าความเสียหายส่วนแรก */    
           brstat.tlt.comp_sck      = "fetP:" + STRING(DECI(wdetail2.fleetper)) + " " + /*% ส่วนลดกลุ่ม         */    
                                      "felA:" + STRING(DECI(wdetail2.fleet))            /*จำนวนส่วนลดกลุ่ม      */    
           brstat.tlt.comp_noti_tlt = "NcbP:" + string(DECI(wdetail2.ncbper)) + " " +   /*% ส่วนลดประวัติดี     */    
                                      "NcbA:" + string(DECI(wdetail2.ncb))              /*จำนวนส่วนลดประวัติดี  */    
           brstat.tlt.comp_usr_tlt  = "DriP:" + string(DECI(wdetail2.drivper)) + " " +  /*% ส่วนลดกรณีผู้ขับขี่ */    
                                      "DriA:" + string(DECI(wdetail2.drivdis))          /*จำนวนส่วนลดกรณีผู้ขับขี่  */    
           brstat.tlt.comp_noti_ins = "OthP:" + string(DECI(wdetail2.othper)) + " " +   /*%สวนลดอื่นๆ           */    
                                      "OthA:" + string(DECI(wdetail2.oth))              /*จำนวนส่วนลดอื่นๆ      */    
           brstat.tlt.comp_usr_ins  = "CTVP:" + string(DECI(wdetail2.cctvper)) + " " +  /*%สวนลดกล้อง           */    
                                      "CTVA:" + string(DECI(wdetail2.cctv))             /*จำนวนส่วนลดกล้อง      */    
           brstat.tlt.comp_pol      = "SurP:" + string(DECI(wdetail2.Surcharper)) + " " + /*%ส่วนลดเพิ่ม        */   
                                      "SurA:" + string(DECI(wdetail2.Surchar))    + " " + /*จำนวนส่วนลดเพิ่ม    */    
                                      "SurD:" + trim(wdetail2.Surchardetail)              /*รายละเอียดส่วนเพิ่ม */    
           brstat.tlt.filler1       = "Acc1:" + trim(wdetail2.acc1)       + " " +         /*รหัส อุปกรณ์1  */   
                                      "Acd1:" + trim(wdetail2.accdetail1) + " " +         /*รายละเอียด1    */    
                                      "Acp1:" + STRING(DECI(wdetail2.accprice1))  + " " + /*ราคาอุปกรณ์1   */    
                                      "Acc2:" + trim(wdetail2.acc2)       + " " +         /*รหัส อุปกรณ์2  */    
                                      "Acd2:" + trim(wdetail2.accdetail2) + " " +         /*รายละเอียด2    */    
                                      "Acp2:" + STRING(DECI(wdetail2.accprice2))  + " " + /*ราคาอุปกรณ์2   */    
                                      "Acc3:" + trim(wdetail2.acc3)       + " " +         /*รหัส อุปกรณ์3  */    
                                      "Acd3:" + trim(wdetail2.accdetail3) + " " +         /*รายละเอียด3    */    
                                      "Acp3:" + STRING(DECI(wdetail2.accprice3))  + " " + /*ราคาอุปกรณ์3   */    
                                      "Acc4:" + trim(wdetail2.acc4)       + " " +         /*รหัส อุปกรณ์4  */    
                                      "Acd4:" + trim(wdetail2.accdetail4) + " " +         /*รายละเอียด 4   */    
                                      "Acp4:" + STRING(DECI(wdetail2.accprice4))  + " " + /*ราคาอุปกรณ์4   */    
                                      "Acc5:" + trim(wdetail2.acc5)       + " " +         /*รหัส อุปกรณ์5  */    
                                      "Acd5:" + TRIM(wdetail2.accdetail5) + " " +        /*รายละเอียด 5   */    
                                      "Acp5:" + STRING(deci(wdetail2.accprice5))         /*ราคาอุปกรณ์5     */    
           brstat.tlt.nor_effdat    = if wdetail2.inspdate     = "" then ? else date(wdetail2.inspdate)                           /*วันที่ตรวจสภาพรถ */    
           brstat.tlt.comp_effdat   = if wdetail2.inspdate_app = "" then ? else date(wdetail2.inspdate_app)                       /*วันที่อนุมัติตรวจสภาพรถ   */    
           brstat.tlt.nor_noti_tlt  = "InspSt:" + trim(wdetail2.inspsts) + " " +        /*ผลการตรวจสภาพรถ           */    
                                      "InspDe:" + trim(wdetail2.inspdetail)             /*รายละเอียดการตรวจสภาพรถ   */    
           brstat.tlt.old_eng       = "BLice:"  + trim(wdetail2.licenBroker) + " " +    /*เลขที่ใบอนุญาตนายหน้า   */      
                                      "Bname:"  + trim(wdetail2.brokname) + " " +       /*ชื่อบริษัทนายหน้า       */      
                                      "Bcode:"  + trim(wdetail2.brokcode)               /*รหัสโบรคเกอร์           */      
           brstat.tlt.filler2       = "Detai1:" + trim(wdetail2.lang) + " " +           /*ภาษาในการออกกรมธรรม์    */      
                                      "Detai2:" + trim(wdetail2.deli) + " " +           /*ช่องทางการจัดส่ง        */      
                                      "Detai3:" + trim(wdetail2.delidetail) + " " +     /*หมายเหตุการจัดส่ง       */      
                                      "Detai4:" + trim(wdetail2.gift) + " " +           /*ของแถม                  */      
                                      "Remark:" + trim(wdetail2.remark)                 /*หมายเหตุ                */      
           brstat.tlt.nor_noti_ins  = trim(wdetail2.cedcode)                            /*เลขที่อ้างอิง ความคุ้มครอง*/    
           brstat.tlt.nor_usr_ins   = trim(wdetail2.inscode)                            /*Cust.Code No              */ 

           /*-- Add by Tontawan S. A68-0059 27/03/2025 --*/
           //Driver 3
           brstat.tlt.dri_title3    = TRIM(wdetail.drv3_salutation_M) /* คำนำหน้าชื่อ ผู้ขับขี่ 3    */ 
           brstat.tlt.dri_fname3    = TRIM(wdetail.drv3_fname)        /* ชื่อผู้ขับขี่ 3             */    
           brstat.tlt.dri_lname3    = TRIM(wdetail.drv3_lname)        /* นามสกุล ผู้ขับขี่ 3         */  
           brstat.tlt.dri_ic3       = TRIM(wdetail.drv3_nid)          /* เลขที่บัตรผู้ขับขี่ 3       */  
           brstat.tlt.dir_occ3      = TRIM(wdetail.drv3_occupation)   /* Driver3 Occupation          */  
           brstat.tlt.dri_gender3   = TRIM(wdetail.drv3_gender)       /* เพศ ผู้ขับขี่ 3             */ 
           brstat.tlt.dri_birth3    = TRIM(wdetail.drv3_birthdate)    /* วันเดือนปีเกิดผู้ขับขี่ 3   */ 
           //Driver 4
           brstat.tlt.dri_title4    = TRIM(wdetail.drv4_salutation_M) /* คำนำหน้าชื่อ ผู้ขับขี่ 4    */ 
           brstat.tlt.dri_fname4    = TRIM(wdetail.drv4_fname)        /* ชื่อผู้ขับขี่ 4             */    
           brstat.tlt.dri_lname4    = TRIM(wdetail.drv4_lname)        /* นามสกุล ผู้ขับขี่ 4         */  
           brstat.tlt.dri_ic4       = TRIM(wdetail.drv4_nid)          /* เลขที่บัตรผู้ขับขี่ 4       */  
           brstat.tlt.dri_occ4      = TRIM(wdetail.drv4_occupation)   /* Driver4 Occupation          */  
           brstat.tlt.dri_gender4   = TRIM(wdetail.drv4_gender)       /* เพศ ผู้ขับขี่ 4             */ 
           brstat.tlt.dri_birth4    = TRIM(wdetail.drv4_birthdate)    /* วันเดือนปีเกิดผู้ขับขี่ 4   */
           //Driver 5 
           brstat.tlt.dri_title5    = TRIM(wdetail.drv5_salutation_M) /* คำนำหน้าชื่อ ผู้ขับขี่ 5    */ 
           brstat.tlt.dri_fname5    = TRIM(wdetail.drv5_fname)        /* ชื่อผู้ขับขี่ 5             */    
           brstat.tlt.dri_lname5    = TRIM(wdetail.drv5_lname)        /* นามสกุล ผู้ขับขี่ 5         */  
           brstat.tlt.dri_ic5       = TRIM(wdetail.drv5_nid)          /* เลขที่บัตรผู้ขับขี่ 5       */  
           brstat.tlt.dri_occ5      = TRIM(wdetail.drv5_occupation)   /* Driver5 Occupation          */  
           brstat.tlt.dri_gender5   = TRIM(wdetail.drv5_gender)       /* เพศ ผู้ขับขี่ 5             */ 
           brstat.tlt.dri_birth5    = TRIM(wdetail.drv5_birthdate)    /* วันเดือนปีเกิดผู้ขับขี่ 5   */

           brstat.tlt.dri_lic1      = TRIM(wdetail.drv1_dlicense)     /* รหัสผู้ขับขี่ 1             */ 
           brstat.tlt.dri_lic2      = TRIM(wdetail.drv2_dlicense)     /* รหัสผู้ขับขี่ 2             */
           brstat.tlt.dri_lic3      = TRIM(wdetail.drv3_dlicense)     /* รหัสผู้ขับขี่ 3             */
           brstat.tlt.dri_lic4      = TRIM(wdetail.drv4_dlicense)     /* รหัสผู้ขับขี่ 4             */
           brstat.tlt.dri_lic5      = TRIM(wdetail.drv5_dlicense)     /* รหัสผู้ขับขี่ 5             */
           brstat.tlt.battno        = TRIM(wdetail.baty_snumber)      /* Battery : Serial Number     */
           brstat.tlt.battyr        = TRIM(wdetail.batydate)          /* Battery : Year              */
           brstat.tlt.battsi        = DECI(wdetail.baty_rsi)          /* Battery : Replacement SI    */
           brstat.tlt.battprem      = DECI(wdetail.baty_npremium)     /* Battery : Net Premium       */
           brstat.tlt.ndeci1        = DECI(wdetail.baty_gpremium)     /* Battery : Gross_Premium     */ //-- ไม่ชัวว่าใช้ Field 
           brstat.tlt.chargno       = TRIM(wdetail.wcharge_snumber)   /* Wall Charge : Serial_Number */
           brstat.tlt.chargsi       = DECI(wdetail.wcharge_si)        /* Wall Charge : SI            */
           brstat.tlt.chargprem     = DECI(wdetail.wcharge_gpremium)  /* Wall Charge : Net Premium   */
           brstat.tlt.ndeci2        = DECI(wdetail.wcharge_npremium)  /* Wall Charge : Gross Premium */ //-- ไม่ชัวว่าใช้ Field
           .
           /*-- End by Tontawan S. A68-0059 27/03/2025 --*/

END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkaddr C-Win 
PROCEDURE proc_chkaddr :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n AS CHAR INIT "".
    /*--- ทีอยุ่หน้าตาราง----*/
    IF n_addr2_70   <> ""  THEN DO: 
        IF INDEX(n_addr2_70,"อาคาร")     <> 0    THEN ASSIGN n_addr2_70 = trim(n_addr2_70). 
        ELSE IF INDEX(n_addr2_70,"ตึก")  <> 0    THEN ASSIGN n_addr2_70 = trim(n_addr2_70).
        ELSE IF INDEX(n_addr2_70,"บ้าน") <> 0    THEN ASSIGN n_addr2_70 = trim(n_addr2_70).
        ELSE IF index(n_addr2_70,"บจก")  <> 0    THEN ASSIGN n_addr2_70 = trim(n_addr2_70).
        ELSE IF index(n_addr2_70,"หจก")  <> 0    THEN ASSIGN n_addr2_70 = trim(n_addr2_70).
        ELSE IF index(n_addr2_70,"บริษัท")  <> 0 THEN ASSIGN n_addr2_70 = trim(n_addr2_70).
        ELSE IF index(n_addr2_70,"ห้าง")    <> 0 THEN ASSIGN n_addr2_70 = trim(n_addr2_70).
        ELSE IF index(n_addr2_70,"มูลนิธิ") <> 0 THEN ASSIGN n_addr2_70 = trim(n_addr2_70).
        ELSE IF index(n_addr2_70,"ชั้น")    <> 0 THEN ASSIGN n_addr2_70 = trim(n_addr2_70).
        ELSE IF index(n_addr2_70,"ห้อง")    <> 0 THEN ASSIGN n_addr2_70 = trim(n_addr2_70).
        ELSE ASSIGN n_addr2_70 = "หมู่บ้าน" + trim(n_addr2_70).
    END.
    IF n_addr3_70  <> ""  THEN DO: 
        IF INDEX(n_addr3_70,"หมู่")      <> 0      THEN n_addr3_70 = REPLACE(n_addr3_70,"หมู่","ม.").
        ELSE IF INDEX(n_addr3_70,"ม.")   <> 0      THEN n_addr3_70 = trim(n_addr3_70).
        ELSE IF INDEX(n_addr3_70,"บ้าน") <> 0      THEN n_addr3_70 = trim(n_addr3_70). 
        ELSE IF INDEX(n_addr3_70,"หมู่บ้าน") <> 0  THEN n_addr3_70 = trim(n_addr3_70).
        ELSE IF INDEX(n_addr3_70,"ที่")  <> 0      THEN n_addr3_70 = trim(n_addr3_70).
        ELSE DO:
            ASSIGN  n = ""  
                n = SUBSTR(TRIM(n_addr3_70),1,1).
                IF INDEX("0123456789",n) <> 0 THEN n_addr3_70 = "ม." + trim(n_addr3_70).
                ELSE n_addr3_70 = trim(n_addr3_70).
        END.
    END.
    IF n_addr4_70 <> ""  THEN DO:
        IF      INDEX(n_addr4_70,"ซ.")  <> 0 THEN n_addr4_70 = trim(n_addr4_70) .
        ELSE IF INDEX(n_addr4_70,"ซอย") <> 0 THEN n_addr4_70 = REPLACE(n_addr4_70,"ซอย","ซ.").
        ELSE n_addr4_70 = "ซ." + trim(n_addr4_70) .
    END.
    IF n_addr5_70 <> ""  THEN DO: 
        IF INDEX(n_addr5_70,"ถ.")       <> 0 THEN n_addr5_70 = trim(n_addr5_70).
        ELSE IF INDEX(n_addr5_70,"ถนน") <> 0 THEN n_addr5_70 = REPLACE(n_addr5_70,"ถนน","ถ.").
        ELSE n_addr5_70 = "ถ." + trim(n_addr5_70) .
    END.    
    IF n_nprovin70 <> ""  THEN DO:
        IF (index(n_nprovin70,"กทม") <> 0 ) OR (index(n_nprovin70,"กรุงเทพ") <> 0 ) THEN DO:
            ASSIGN 
            n_nsub_dist70  = IF index(n_nsub_dist70,"แขวง") <> 0 THEN trim(n_nsub_dist70) ELSE "แขวง" + trim(n_nsub_dist70)
            n_ndirection70 = IF index(n_ndirection70,"เขต") <> 0 THEN trim(n_ndirection70) ELSE "เขต" + trim(n_ndirection70)
            n_nprovin70    = trim(n_nprovin70)
            n_zipcode70    = trim(n_zipcode70). 
        END.
        ELSE DO:
            ASSIGN 
            n_nsub_dist70  = IF index(n_nsub_dist70,"ต.") <> 0 THEN trim(n_nsub_dist70) 
                             ELSE IF index(n_nsub_dist70,"ตำบล") <> 0 THEN REPLACE(n_nsub_dist70,"ตำบล","ต.")
                             ELSE "ต." + trim(n_nsub_dist70)
            n_ndirection70 = IF index(n_ndirection70,"อ.") <> 0 THEN trim(n_ndirection70) 
                             ELSE IF index(n_ndirection70,"อำเภอ") <> 0  THEN REPLACE(n_nsub_dist70,"อำเภอ","อ.")
                             ELSE "อ." + trim(n_ndirection70)
            n_nprovin70    = IF index(n_nprovin70,"จังหวัด") <> 0 OR INDEX(n_nprovin70,"จ.") <> 0 THEN TRIM(n_nprovin70)
                             ELSE "จ." + TRIM(n_nprovin70)
            n_zipcode70    = trim(n_zipcode70).
        END.
    END.

    /*--- ทีอยุ่จัดส่ง----*/
    IF n_addr2_72   <> ""  THEN DO: 
        IF INDEX(n_addr2_72,"อาคาร")     <> 0    THEN ASSIGN n_addr2_72 = trim(n_addr2_72). 
        ELSE IF INDEX(n_addr2_72,"ตึก")  <> 0    THEN ASSIGN n_addr2_72 = trim(n_addr2_72).
        ELSE IF INDEX(n_addr2_72,"บ้าน") <> 0    THEN ASSIGN n_addr2_72 = trim(n_addr2_72).
        ELSE IF index(n_addr2_72,"บจก")  <> 0    THEN ASSIGN n_addr2_72 = trim(n_addr2_72).
        ELSE IF index(n_addr2_72,"หจก")  <> 0    THEN ASSIGN n_addr2_72 = trim(n_addr2_72).
        ELSE IF index(n_addr2_72,"บริษัท")  <> 0 THEN ASSIGN n_addr2_72 = trim(n_addr2_72).
        ELSE IF index(n_addr2_72,"ห้าง")    <> 0 THEN ASSIGN n_addr2_72 = trim(n_addr2_72).
        ELSE IF index(n_addr2_72,"มูลนิธิ") <> 0 THEN ASSIGN n_addr2_72 = trim(n_addr2_72).
        ELSE IF index(n_addr2_72,"ชั้น")    <> 0 THEN ASSIGN n_addr2_72 = trim(n_addr2_72).
        ELSE IF index(n_addr2_72,"ห้อง")    <> 0 THEN ASSIGN n_addr2_72 = trim(n_addr2_72).
        ELSE ASSIGN n_addr2_72 = "หมู่บ้าน" + trim(n_addr2_72).
    END.
    IF n_addr3_72  <> ""  THEN DO: 
        IF INDEX(n_addr3_72,"หมู่")      <> 0      THEN n_addr3_72 = REPLACE(n_addr3_72,"หมู่","ม.").
        ELSE IF INDEX(n_addr3_72,"ม.")   <> 0      THEN n_addr3_72 = trim(n_addr3_72).
        ELSE IF INDEX(n_addr3_72,"บ้าน") <> 0      THEN n_addr3_72 = trim(n_addr3_72). 
        ELSE IF INDEX(n_addr3_72,"หมู่บ้าน") <> 0  THEN n_addr3_72 = trim(n_addr3_72).
        ELSE IF INDEX(n_addr3_72,"ที่")  <> 0      THEN n_addr3_72 = trim(n_addr3_72).
        ELSE DO:
            ASSIGN  n = ""  
                n = SUBSTR(TRIM(n_addr3_72),1,1).
                IF INDEX("0123456789",n) <> 0 THEN n_addr3_72 = "ม." + trim(n_addr3_72).
                ELSE n_addr3_72 = trim(n_addr3_72).
        END.
    END.
    IF n_addr4_72 <> ""  THEN DO:
        IF INDEX(n_addr4_72,"ซ.")       <> 0 THEN n_addr4_72 = trim(n_addr4_72) .
        ELSE IF INDEX(n_addr4_72,"ซอย") <> 0 THEN n_addr4_72 = REPLACE(n_addr4_72,"ซอย","ซ.").
        ELSE n_addr4_72 = "ซ." + trim(n_addr4_72) .
    END.
    IF n_addr5_72 <> ""  THEN DO: 
        IF INDEX(n_addr5_72,"ถ.")       <> 0 THEN n_addr5_72 = trim(n_addr5_72) .
        ELSE IF INDEX(n_addr5_72,"ถนน") <> 0 THEN n_addr5_72 = REPLACE(n_addr5_72,"ถนน","ถ.").
        ELSE n_addr5_72 = "ถ." + trim(n_addr5_72) .
    END.    
    IF n_nprovin72 <> ""  THEN DO:
        IF (index(n_nprovin72,"กทม") <> 0 ) OR (index(n_nprovin72,"กรุงเทพ") <> 0 ) THEN DO:
            ASSIGN 
            n_nsub_dist72  = IF index(n_nsub_dist72,"แขวง") <> 0 THEN trim(n_nsub_dist72) ELSE "แขวง" + trim(n_nsub_dist72)
            n_ndirection72 = IF index(n_ndirection72,"เขต") <> 0 THEN trim(n_ndirection72) ELSE "เขต" + trim(n_ndirection72)
            n_nprovin72    = trim(n_nprovin72)
            n_zipcode72    = trim(n_zipcode72). 
        END.
        ELSE DO:
            ASSIGN 
            n_nsub_dist72  = IF index(n_nsub_dist72,"ตำบล")    <> 0 THEN REPLACE(n_nsub_dist72,"ตำบล","ต.")
                             ELSE IF index(n_nsub_dist72,"ต.") <> 0 THEN trim(n_nsub_dist72) 
                             ELSE "ต." + trim(n_nsub_dist72)
            n_ndirection72 = IF index(n_ndirection72,"อำเภอ")   <> 0 THEN REPLACE(n_ndirection72,"อำเภอ","อ.") 
                             ELSE IF index(n_ndirection72,"อ.") <> 0 THEN trim(n_ndirection72) 
                             ELSE "อ." + trim(n_ndirection72)
            n_nprovin72    = IF index(n_nprovin72,"จังหวัด")    <> 0 THEN REPLACE(n_nprovin72,"จังหวัด","จ.") 
                             ELSE IF INDEX(n_nprovin72,"จ.")    <> 0 THEN TRIM(n_nprovin72)
                             ELSE "จ." + TRIM(n_nprovin72)
            n_zipcode72    = trim(n_zipcode72).
        END.
    END.

    /*--- ทีอยุ่ชำระเงิน----*/
    IF n_payaddr2   <> ""  THEN DO: 
        IF INDEX(n_payaddr2,"อาคาร")     <> 0    THEN ASSIGN n_payaddr2 = trim(n_payaddr2). 
        ELSE IF INDEX(n_payaddr2,"ตึก")  <> 0    THEN ASSIGN n_payaddr2 = trim(n_payaddr2).
        ELSE IF INDEX(n_payaddr2,"บ้าน") <> 0    THEN ASSIGN n_payaddr2 = trim(n_payaddr2).
        ELSE IF index(n_payaddr2,"บจก")  <> 0    THEN ASSIGN n_payaddr2 = trim(n_payaddr2).
        ELSE IF index(n_payaddr2,"หจก")  <> 0    THEN ASSIGN n_payaddr2 = trim(n_payaddr2).
        ELSE IF index(n_payaddr2,"บริษัท")  <> 0 THEN ASSIGN n_payaddr2 = trim(n_payaddr2).
        ELSE IF index(n_payaddr2,"ห้าง")    <> 0 THEN ASSIGN n_payaddr2 = trim(n_payaddr2).
        ELSE IF index(n_payaddr2,"มูลนิธิ") <> 0 THEN ASSIGN n_payaddr2 = trim(n_payaddr2).
        ELSE IF index(n_payaddr2,"ชั้น")    <> 0 THEN ASSIGN n_payaddr2 = trim(n_payaddr2).
        ELSE IF index(n_payaddr2,"ห้อง")    <> 0 THEN ASSIGN n_payaddr2 = trim(n_payaddr2).
        ELSE ASSIGN n_payaddr2 = "หมู่บ้าน" + trim(n_payaddr2).
    END.
    IF n_payaddr3  <> ""  THEN DO: 
        IF INDEX(n_payaddr3,"หมู่")      <> 0      THEN n_payaddr3 = REPLACE(n_payaddr3,"หมู่","ม.").
        ELSE IF INDEX(n_payaddr3,"ม.")   <> 0      THEN n_payaddr3 = trim(n_payaddr3).
        ELSE IF INDEX(n_payaddr3,"บ้าน") <> 0      THEN n_payaddr3 = trim(n_payaddr3). 
        ELSE IF INDEX(n_payaddr3,"หมู่บ้าน") <> 0  THEN n_payaddr3 = trim(n_payaddr3).
        ELSE IF INDEX(n_payaddr3,"ที่")  <> 0      THEN n_payaddr3 = trim(n_payaddr3).
        ELSE DO:
            ASSIGN  n = ""  
                n = SUBSTR(TRIM(n_payaddr3),1,1).
                IF INDEX("0123456789",n) <> 0 THEN n_payaddr3 = "ม." + trim(n_payaddr3).
                ELSE n_payaddr3 = trim(n_payaddr3).
        END.
    END.
    IF n_payaddr4 <> ""  THEN DO:
        IF INDEX(n_payaddr4,"ซ.") <> 0  THEN n_payaddr4 = trim(n_payaddr4) .
        ELSE IF INDEX(n_payaddr4,"ซอย") <> 0 THEN n_payaddr4 = REPLACE(n_payaddr4,"ซอย","ซ.").
        ELSE n_payaddr4 = "ซ." + trim(n_payaddr4) .
    END.
    IF n_payaddr5 <> ""  THEN DO: 
        IF INDEX(n_payaddr5,"ถ.") <> 0 THEN n_payaddr5 = trim(n_payaddr5) .
        ELSE IF INDEX(n_payaddr5,"ถนน") <> 0  THEN n_payaddr5 = REPLACE(n_payaddr5,"ถนน","ถ.").
        ELSE n_payaddr5 = "ถ." + trim(n_payaddr5) .
    END.    
    IF n_payaddr8 <> ""  THEN DO:
        IF (index(n_payaddr8,"กทม") <> 0 ) OR (index(n_payaddr8,"กรุงเทพ") <> 0 ) THEN DO:
            ASSIGN 
            n_payaddr6 = IF index(n_payaddr6,"แขวง") <> 0 THEN trim(n_payaddr6) ELSE "แขวง" + trim(n_payaddr6)
            n_payaddr7 = IF index(n_payaddr7,"เขต") <> 0 THEN trim(n_payaddr7) ELSE "เขต" + trim(n_payaddr7)
            n_payaddr8 = trim(n_payaddr8)
            n_payaddr9 = trim(n_payaddr9). 
        END.           
        ELSE DO:       
            ASSIGN     
            n_payaddr6 = IF index(n_payaddr6,"ตำบล")    <> 0 THEN REPLACE(n_payaddr6,"ตำบล","ต.") 
                         ELSE IF index(n_payaddr6,"ต.") <> 0 THEN trim(n_payaddr6) 
                         ELSE "ต." + trim(n_payaddr6)
            n_payaddr7 = IF index(n_payaddr7,"อำเภอ")   <> 0 THEN REPLACE(n_payaddr7,"อำเภอ","อ.")
                         ELSE IF index(n_payaddr7,"อ.") <> 0 THEN trim(n_payaddr7)
                         ELSE "อ." + trim(n_payaddr7)
            n_payaddr8 = IF index(n_payaddr8,"จังหวัด") <> 0 THEN REPLACE(n_payaddr8,"จังหวัด","จ.")
                         ELSE IF INDEX(n_payaddr8,"จ.") <> 0 THEN TRIM(n_payaddr8)
                         ELSE "จ." + TRIM(n_payaddr8)
            n_payaddr9 = trim(n_payaddr9).
        END.
    END.
   

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkaddrcut C-Win 
PROCEDURE proc_chkaddrcut :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF n_addr1_70 <> "" THEN DO:
    n_chkaddr = "".
    n_cntaddr = "".
    n_cntaddr = "1".
    n_chkaddr = n_addr1_70.
    RUN proc_replaceaddr.
END.
IF n_addr2_70 <> "" THEN DO:
    n_chkaddr = "".
    n_cntaddr = "".
    n_cntaddr = "2".
    n_chkaddr = n_addr2_70.
    RUN proc_replaceaddr.
END.
IF n_addr3_70 <> "" THEN DO:
    n_chkaddr = "".
    n_cntaddr = "".
    n_cntaddr = "3".
    n_chkaddr = n_addr3_70.
    RUN proc_replaceaddr.
END.
IF n_addr4_70 <> "" THEN DO:
    n_chkaddr = "".
    n_cntaddr = "".
    n_cntaddr = "4".
    n_chkaddr = n_addr4_70.
    RUN proc_replaceaddr.
END.
IF n_addr5_70 <> "" THEN DO:
    n_chkaddr = "".
    n_cntaddr = "".
    n_cntaddr = "5".
    n_chkaddr = n_addr5_70.
    RUN proc_replaceaddr.
END.
IF n_nsub_dist70 <> "" THEN DO:
    n_chkaddr = "".
    n_cntaddr = "".
    n_cntaddr = "6".
    n_chkaddr = n_nsub_dist70.
    RUN proc_replaceaddr.
END.
IF n_ndirection70 <> "" THEN DO:
    n_chkaddr = "".
    n_cntaddr = "".
    n_cntaddr = "7".
    n_chkaddr = n_ndirection70.
    RUN proc_replaceaddr.
END.
IF n_nprovin70 <> "" THEN DO:
    n_chkaddr = "".
    n_cntaddr = "".
    n_cntaddr = "8".
    n_chkaddr = n_nprovin70.
    RUN proc_replaceaddr.
END.
IF n_zipcode70 <> "" THEN DO:
    n_chkaddr = "".
    n_cntaddr = "".
    n_cntaddr = "9".
    n_chkaddr = n_zipcode70.
    RUN proc_replaceaddr.
END.
IF n_addr1_72 <> "" THEN DO: 
    n_chkaddr = "".
    n_cntaddr = "".
    n_cntaddr = "10".
    n_chkaddr = n_addr1_72.
    RUN proc_replaceaddr.
END.
IF n_addr2_72 <> "" THEN DO: 
    n_chkaddr = "".
    n_cntaddr = "".
    n_cntaddr = "11".
    n_chkaddr = n_addr2_72.
    RUN proc_replaceaddr.
END.
IF n_addr3_72 <> "" THEN DO:
    n_chkaddr = "".
    n_cntaddr = "".
    n_cntaddr = "12".
    n_chkaddr = n_addr3_72.
    RUN proc_replaceaddr.
END.
IF n_addr4_72 <> "" THEN DO: 
    n_chkaddr = "".
    n_cntaddr = "".
    n_cntaddr = "13".
    n_chkaddr = n_addr4_72.
    RUN proc_replaceaddr.
END.
IF n_addr5_72 <> "" THEN DO: 
    n_chkaddr = "".
    n_cntaddr = "".
    n_cntaddr = "14".
    n_chkaddr = n_addr5_72.
    RUN proc_replaceaddr.
END.
IF n_nsub_dist72 <> "" THEN DO:
    n_chkaddr = "".
    n_cntaddr = "".
    n_cntaddr = "15".
    n_chkaddr = n_nsub_dist72.
    RUN proc_replaceaddr.
END.
IF n_ndirection72 <> "" THEN DO:
    n_chkaddr = "".
    n_cntaddr = "".
    n_cntaddr = "16".
    n_chkaddr = n_ndirection72.
    RUN proc_replaceaddr.
END.
IF n_nprovin72 <> "" THEN DO:
    n_chkaddr = "".
    n_cntaddr = "".
    n_cntaddr = "17".
    n_chkaddr = n_nprovin72.
    RUN proc_replaceaddr.
END.
IF n_zipcode72 <> "" THEN DO: 
    n_chkaddr = "".
    n_cntaddr = "".
    n_cntaddr = "18".
    n_chkaddr = n_zipcode72.
    RUN proc_replaceaddr.
END.
IF n_payaddr1 <> "" THEN DO:   
    n_chkaddr = "".
    n_cntaddr = "".
    n_cntaddr = "19".
    n_chkaddr = n_payaddr1.
    RUN proc_replaceaddr.
END.
IF n_payaddr2 <> "" THEN DO:  
    n_chkaddr = "".
    n_cntaddr = "".
    n_cntaddr = "20".
    n_chkaddr = n_payaddr2.
    RUN proc_replaceaddr.
END.
IF n_payaddr3 <> "" THEN DO:  
    n_chkaddr = "".
    n_cntaddr = "".
    n_cntaddr = "21".
    n_chkaddr = n_payaddr3.
    RUN proc_replaceaddr.
END.
IF n_payaddr4 <> "" THEN DO: 
    n_chkaddr = "".
    n_cntaddr = "".
    n_cntaddr = "22".
    n_chkaddr = n_payaddr4.
    RUN proc_replaceaddr.
END.
IF n_payaddr5 <> "" THEN DO:  
    n_chkaddr = "".
    n_cntaddr = "".
    n_cntaddr = "23".
    n_chkaddr = n_payaddr5.
    RUN proc_replaceaddr.
END.
IF n_payaddr6 <> "" THEN DO:  
    n_chkaddr = "".
    n_cntaddr = "".
    n_cntaddr = "24".
    n_chkaddr = n_payaddr6.
    RUN proc_replaceaddr.
END.
IF n_payaddr7 <> "" THEN DO:   
    n_chkaddr = "".
    n_cntaddr = "".
    n_cntaddr = "25".
    n_chkaddr = n_payaddr7.
    RUN proc_replaceaddr.
END.
IF n_payaddr8 <> "" THEN DO:   
    n_cntaddr = "".
    n_chkaddr = "".
    n_cntaddr = "26".
    n_chkaddr = n_payaddr8.
    RUN proc_replaceaddr.
END.
IF n_payaddr9 <> "" THEN DO:   
    n_chkaddr = "".
    n_cntaddr = "".
    n_cntaddr = "27".
    n_chkaddr = n_payaddr9.
    RUN proc_replaceaddr.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkcut C-Win 
PROCEDURE proc_chkcut :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Tontawan S. A68-0059      
------------------------------------------------------------------------------*/
IF INDEX(n_engine,"-") <> 0 OR INDEX(n_engine,"Car_EngineNo__c") <> 0 THEN n_engine = "".

IF INDEX(n_addr2_70,"-") <> 0 OR INDEX(n_addr2_70,"Holder_Register_Village__c") <> 0 THEN n_addr2_70 = "".
IF INDEX(n_addr3_70,"-") <> 0 OR INDEX(n_addr3_70,"Holder_Register_Moo__c")     <> 0 THEN n_addr3_70 = "".
IF INDEX(n_addr4_70,"-") <> 0 OR INDEX(n_addr4_70,"Holder_Register_Soi__c")     <> 0 THEN n_addr4_70 = "".
IF INDEX(n_addr5_70,"-") <> 0 OR INDEX(n_addr5_70,"Holder_Register_Street__c")  <> 0 THEN n_addr5_70 = "".

IF INDEX(n_addr2_72,"-") <> 0 OR INDEX(n_addr2_72,"Holder_Billing_Village__c")  <> 0 THEN n_addr2_72 = "".
IF INDEX(n_addr3_72,"-") <> 0 OR INDEX(n_addr3_72,"Holder_Billing_Moo__c")      <> 0 THEN n_addr3_72 = "".
IF INDEX(n_addr4_72,"-") <> 0 OR INDEX(n_addr4_72,"Holder_Billing_Soi__c")      <> 0 THEN n_addr4_72 = "".
IF INDEX(n_addr5_72,"-") <> 0 OR INDEX(n_addr5_72,"Holder_Billing_Street__c")   <> 0 THEN n_addr5_72 = "".

IF INDEX(n_payaddr2,"-") <> 0 OR INDEX(n_payaddr2,"Payer_Village__c") <> 0 THEN n_payaddr2 = "".
IF INDEX(n_payaddr3,"-") <> 0 OR INDEX(n_payaddr3,"Payer_Moo__c")     <> 0 THEN n_payaddr3 = "".
IF INDEX(n_payaddr4,"-") <> 0 OR INDEX(n_payaddr4,"Payer_Soi__c")     <> 0 THEN n_payaddr4 = "".
IF INDEX(n_payaddr5,"-") <> 0 OR INDEX(n_payaddr5,"Payer_Street__c")  <> 0 THEN n_payaddr5 = "".

IF INDEX(n_deduct,"Factor_13__c") <> 0 THEN n_deduct = "0.00".
ELSE IF n_deduct = "" OR INDEX(n_deduct,"-") <> 0 THEN n_deduct = "0.00".
ELSE n_deduct.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkpattern C-Win 
PROCEDURE proc_chkpattern :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: create by A63-0450      
------------------------------------------------------------------------------*/
DO:
   IF trim(winsp.licence) <> "" THEN DO:
   ASSIGN nv_licen = REPLACE(winsp.licence," ","").
   IF INDEX("0123456789",SUBSTR(winsp.licence,1,1)) <> 0 THEN DO:
       IF LENGTH(nv_licen) = 4 THEN 
          ASSIGN nv_Pattern1 = "yxx-y-xx"
                 nv_licen    = SUBSTR(nv_licen,1,3) + " " + SUBSTR(nv_licen,4,1).
       ELSE IF LENGTH(nv_licen) = 5 THEN
           ASSIGN nv_Pattern1 = "yxx-yy-xx"
                  nv_licen    = SUBSTR(nv_licen,1,3) + " " + SUBSTR(nv_licen,4,2).
       ELSE IF LENGTH(nv_licen) = 6 THEN DO:
           IF INDEX("0123456789",SUBSTR(nv_licen,2,1)) <> 0 THEN
               ASSIGN nv_Pattern1 = "yy-yyyy-xx"
                      nv_licen    = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,4).
           ELSE IF INDEX("0123456789",SUBSTR(nv_licen,3,1)) <> 0 THEN
               ASSIGN nv_Pattern1 = "yx-yyyy-xx"
                      nv_licen    = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,4).
           ELSE 
               ASSIGN nv_Pattern1 = "yxx-yyy-xx"
                      nv_licen    = SUBSTR(nv_licen,1,3) + " " + SUBSTR(nv_licen,4,3). 
       END.
       ELSE 
           ASSIGN nv_Pattern1 = "yxx-yyyy-xx"
                  nv_licen    = SUBSTR(nv_licen,1,3) + " " + SUBSTR(nv_licen,4,4).
    END.
    ELSE DO:
        IF LENGTH(nv_licen) = 3 THEN 
          ASSIGN nv_Pattern1 = "xx-y-xx"
                 nv_licen    = SUBSTR(nv_licen,1,2) + " "  + SUBSTR(nv_licen,3,1) .
        ELSE IF LENGTH(nv_licen) = 4 THEN
           ASSIGN nv_Pattern1 = "xx-yy-xx"
                  nv_licen    = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,2) .
        ELSE IF LENGTH(nv_licen) = 6 THEN
           ASSIGN nv_Pattern1 = "xx-yyyy-xx" 
                  nv_licen    = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,4) .
        ELSE IF LENGTH(nv_licen) = 5 THEN DO:
            IF INDEX("0123456789",SUBSTR(nv_licen,2,1)) <> 0 THEN
               ASSIGN nv_Pattern1 = "x-yyyy-xx"
                      nv_licen    = SUBSTR(nv_licen,1,1) + " " + SUBSTR(nv_licen,2,4).
            ELSE 
               ASSIGN nv_Pattern1 = "xx-yyy-xx" 
                      nv_licen    = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,3).
        END.
        ELSE 
               ASSIGN nv_Pattern1 = "xxx-yyy-xx" 
                      nv_licen    = SUBSTR(nv_licen,1,3) + " " + SUBSTR(nv_licen,3,3).
    END.
END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_Cleardata C-Win 
PROCEDURE Proc_Cleardata :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN 
    n_cmr_code          = ""         
    n_comp_code         = ""         
    n_campcode          = ""         
    n_campname          = ""         
    n_procode           = ""         
    n_proname           = ""         
    n_packname          = ""         
    n_packcode          = ""         
    n_instype           = ""         
    n_pol_title         = ""         
    n_pol_fname         = ""         
    n_pol_lname         = ""         
    n_pol_title_eng     = ""         
    n_pol_fname_eng     = ""         
    n_pol_lname_eng     = ""         
    n_icno              = ""         
    n_sex               = ""         
    n_bdate             = ""         
    n_occup             = ""         
    n_tel               = ""         
    n_phone             = ""         
    n_teloffic          = ""         
    n_telext            = ""         
    n_moblie            = ""         
    n_mobliech          = ""         
    n_mail              = ""         
    n_lineid            = ""         
    n_addr1_70          = ""         
    n_addr2_70          = ""         
    n_addr3_70          = ""         
    n_addr4_70          = ""         
    n_addr5_70          = ""         
    n_nsub_dist70       = ""         
    n_ndirection70      = ""         
    n_nprovin70         = ""         
    n_zipcode70         = ""         
    n_addr1_72          = ""         
    n_addr2_72          = ""         
    n_addr3_72          = ""         
    n_addr4_72          = ""         
    n_addr5_72          = ""         
    n_nsub_dist72       = ""         
    n_ndirection72      = ""         
    n_nprovin72         = ""         
    n_zipcode72         = ""         
    n_paytype           = ""         
    n_paytitle          = ""         
    n_payname           = ""         
    n_paylname          = ""         
    n_payicno           = ""         
    n_payaddr1          = ""         
    n_payaddr2          = ""         
    n_payaddr3          = ""         
    n_payaddr4          = ""         
    n_payaddr5          = ""         
    n_payaddr6          = ""         
    n_payaddr7          = ""         
    n_payaddr8          = ""         
    n_payaddr9          = ""         
    n_branch            = ""         
    n_ben_title         = ""         
    n_ben_name          = ""         
    n_ben_lname         = ""         
    n_pmentcode         = ""         
    n_pmenttyp          = ""         
    n_pmentcode1        = ""         
    n_pmentcode2        = ""         
    n_pmentbank         = ""         
    n_pmentdate         = ""         
    n_pmentsts          = ""         
    n_driver            = ""         
    n_drivetitle1       = ""         
    n_drivename1        = ""         
    n_drivelname1       = ""         
    n_driveno1          = ""         
    n_occupdriv1        = ""         
    n_sexdriv1          = ""         
    n_bdatedriv1        = ""         
    n_drivetitle2       = ""         
    n_drivename2        = ""         
    n_drivelname2       = ""         
    n_driveno2          = ""         
    n_occupdriv2        = ""         
    n_sexdriv2          = ""         
    n_bdatedriv2        = ""         
    n_brand             = ""         
    n_brand_cd          = ""         
    n_Model             = ""         
    n_Model_cd          = ""         
    n_body              = ""         
    n_body_cd           = ""         
    n_licence           = ""         
    n_province          = ""         
    n_chassis           = ""         
    n_engine            = ""         
    n_yrmanu            = ""         
    n_seatenew          = ""         
    n_power             = ""         
    n_weight            = ""         
    n_class             = ""         
    n_garage_cd         = ""         
    n_garage            = ""         
    n_colorcode         = ""         
    n_covcod            = ""         
    n_covtyp            = ""         
    n_covtyp1           = ""         
    n_covtyp2           = ""         
    n_covtyp3           = ""         
    n_comdat            = ""         
    n_expdat            = ""         
    n_ins_amt           = ""         
    n_prem1             = ""         
    n_gross_prm         = ""         
    n_stamp             = ""         
    n_vat               = ""         
    n_premtotal         = ""         
    n_deduct            = ""         
    n_fleetper          = ""         
    n_fleet             = ""         
    n_ncbper            = ""         
    n_ncb               = ""         
    n_drivper           = ""         
    n_drivdis           = ""         
    n_othper            = ""         
    n_oth               = ""         
    n_cctvper           = ""         
    n_cctv              = ""         
    n_Surcharper        = ""         
    n_Surchar           = ""         
    n_Surchardetail     = ""         
    n_acc1              = ""         
    n_accdetail1        = ""         
    n_accprice1         = ""         
    n_acc2              = ""         
    n_accdetail2        = ""         
    n_accprice2         = ""         
    n_acc3              = ""         
    n_accdetail3        = ""         
    n_accprice3         = ""         
    n_acc4              = ""         
    n_accdetail4        = ""         
    n_accprice4         = ""         
    n_acc5              = ""         
    n_accdetail5        = ""         
    n_accprice5         = ""         
    n_inspdate          = ""         
    n_inspdate_app      = ""         
    n_inspsts           = ""         
    n_inspdetail        = ""         
    n_not_date          = ""         
    n_paydate           = ""         
    n_paysts            = ""         
    n_licenBroker       = ""         
    n_brokname          = ""         
    n_brokcode          = ""         
    n_lang              = ""         
    n_deli              = ""         
    n_delidetail        = ""         
    n_gift              = ""         
    n_cedcode           = ""         
    n_inscode           = ""         
    n_remark            = ""
    
    /*-- Add By Tontawan S. A68-0059 27/03/2025 --*/
    n_drv3_salutation_M = ""
    n_drv3_fname        = ""
    n_drv3_lname        = ""
    n_drv3_nid          = ""
    n_drv3_occupation   = ""
    n_drv3_gender       = ""
    n_drv3_birthdate    = ""
    n_drv4_salutation_M = ""
    n_drv4_fname        = ""
    n_drv4_lname        = ""
    n_drv4_nid          = ""
    n_drv4_occupation   = ""
    n_drv4_gender       = ""
    n_drv4_birthdate    = ""
    n_drv5_salutation_M = ""
    n_drv5_fname        = ""
    n_drv5_lname        = ""
    n_drv5_nid          = ""
    n_drv5_occupation   = ""
    n_drv5_gender       = ""
    n_drv5_birthdate    = ""
    n_drv1_dlicense     = ""
    n_drv2_dlicense     = ""
    n_drv3_dlicense     = ""
    n_drv4_dlicense     = ""
    n_drv5_dlicense     = ""
    n_baty_snumber      = ""
    n_batydate          = ""
    n_baty_rsi          = ""
    n_baty_npremium     = ""
    n_baty_gpremium     = ""
    n_wcharge_snumber   = ""
    n_wcharge_si        = ""
    n_wcharge_npremium  = ""
    n_wcharge_gpremium  = ""
    /*-- End By Tontawan S. A68-0059 27/03/2025 --*/
    . 

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create C-Win 
PROCEDURE proc_create :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND FIRST wdetail WHERE wdetail.chassis = TRIM(n_chassis) AND
           wdetail.covtyp  = TRIM(n_covtyp)  NO-LOCK NO-ERROR.
IF NOT AVAIL wdetail THEN DO:
    RUN proc_chkaddr.
    CREATE wdetail.
    ASSIGN 
        wdetail.chassis             = TRIM(n_chassis) 
        wdetail.covcod              = TRIM(n_covcod) 
        wdetail.covtyp              = TRIM(n_covtyp) 
        wdetail.cmr_code            = TRIM(n_cmr_code)     
        wdetail.comp_code           = "บริษัท ประกันคุ้มภัย จำกัด(มหาชน)"     
        wdetail.campcode            = TRIM(n_campcode)     
        wdetail.campname            = TRIM(n_campname)     
        wdetail.procode             = TRIM(n_procode)     
        wdetail.proname             = TRIM(n_proname)     
        wdetail.packname            = TRIM(n_packname)     
        wdetail.packcode            = TRIM(n_packcode)     
        wdetail.instype             = TRIM(n_instype)     
        wdetail.pol_title           = TRIM(n_pol_title)     
        wdetail.pol_fname           = TRIM(n_pol_fname)     
        wdetail.pol_lname           = IF INDEX(n_pol_lname," ") <> 0 THEN TRIM(REPLACE(n_pol_lname," ","")) ELSE TRIM(n_pol_lname)    
        wdetail.pol_title_eng       = IF TRIM(n_pol_fname_eng) = "" THEN "" ELSE TRIM(n_pol_title_eng)
        wdetail.pol_fname_eng       = TRIM(n_pol_fname_eng) 
        wdetail.pol_lname_eng       = TRIM(n_pol_lname_eng) 
        wdetail.icno                = TRIM(n_icno)         
        wdetail.sex                 = TRIM(n_sex)         
        /*wdetail.bdate               = STRING(DATE(n_bdate),"99/99/9999")  /*1993-08-05*/    */
        wdetail.bdate               = IF n_bdate = "" THEN "" ELSE 
                                      SUBSTR(TRIM(n_bdate),9,2) + "/" +   /*1993-08-05*/
                                      SUBSTR(TRIM(n_bdate),6,2) + "/" + 
                                      SUBSTR(TRIM(n_bdate),1,4)         
                                    
        wdetail.occup               = TRIM(n_occup)         
        wdetail.tel                 = TRIM(n_tel)         
        wdetail.phone               = TRIM(n_phone)         
        wdetail.teloffic            = TRIM(n_teloffic)      
        wdetail.telext              = TRIM(n_telext)      
        wdetail.moblie              = TRIM(n_moblie)      
        wdetail.moblie              = TRIM(n_mobliech)      
        wdetail.mail                = TRIM(n_mail)      
        wdetail.lineid              = TRIM(n_lineid)      
        wdetail.addr1_70            = TRIM(n_addr1_70)      
        wdetail.addr2_70            = TRIM(n_addr2_70)      
        wdetail.addr3_70            = TRIM(n_addr3_70)      
        wdetail.addr4_70            = TRIM(n_addr4_70)      
        wdetail.addr5_70            = TRIM(n_addr5_70)      
        wdetail.nsub_dist70         = TRIM(n_nsub_dist70)  
        wdetail.ndirection70        = TRIM(n_ndirection70) 
        wdetail.nprovin70           = TRIM(n_nprovin70)  
        wdetail.zipcode70           = TRIM(n_zipcode70)  
        wdetail.addr1_72            = TRIM(n_addr1_72)  
        wdetail.addr2_72            = TRIM(n_addr2_72)  
        wdetail.addr3_72            = TRIM(n_addr3_72)  
        wdetail.addr4_72            = TRIM(n_addr4_72)  
        wdetail.addr5_72            = TRIM(n_addr5_72)  
        wdetail.nsub_dist72         = TRIM(n_nsub_dist72)  
        wdetail.ndirection72        = TRIM(n_ndirection72) 
        wdetail.nprovin72           = TRIM(n_nprovin72)  
        wdetail.zipcode72           = TRIM(n_zipcode72)  
        wdetail.paytype             = TRIM(n_paytype)  
        wdetail.paytitle            = TRIM(n_paytitle)  
        wdetail.payname             = TRIM(n_payname)  
        wdetail.paylname            = TRIM(n_paylname)  
        wdetail.payicno             = TRIM(n_payicno)  
        wdetail.payaddr1            = TRIM(n_payaddr1)  
        wdetail.payaddr2            = TRIM(n_payaddr2)  
        wdetail.payaddr3            = TRIM(n_payaddr3)  
        wdetail.payaddr4            = TRIM(n_payaddr4)  
        wdetail.payaddr5            = TRIM(n_payaddr5)  
        wdetail.payaddr6            = TRIM(n_payaddr6)  
        wdetail.payaddr7            = TRIM(n_payaddr7)  
        wdetail.payaddr8            = TRIM(n_payaddr8)  
        wdetail.payaddr9            = TRIM(n_payaddr9)  
        wdetail.branch              = TRIM(n_branch)  
        wdetail.ben_title           = TRIM(n_ben_title)  
        wdetail.ben_name            = TRIM(n_ben_name)
        wdetail.ben_lname           = TRIM(n_ben_lname)  
        wdetail.pmentcode           = TRIM(n_pmentcode)  
        wdetail.pmenttyp            = TRIM(n_pmenttyp)
        wdetail.pmentcode1          = TRIM(n_pmentcode1)  
        wdetail.pmentcode2          = TRIM(n_pmentcode2)  
        wdetail.pmentbank           = TRIM(n_pmentbank)  
        wdetail.pmentdate           = IF n_pmentdate = "" THEN "" ELSE 
                                      SUBSTR(n_pmentdate,9,2) + "/" +     /*2021/08/24 17:50:00*/ 
                                      SUBSTR(n_pmentdate,6,2) + "/" +     /*2021/08/24 17:50:00*/ 
                                      SUBSTR(n_pmentdate,1,4)             /*2021/08/24 17:50:00*/ 
                                    
        wdetail.pmentsts            = TRIM(n_pmentsts)  
        wdetail.driver              = TRIM(n_driver)  
        wdetail.drivetitle1         = TRIM(n_drivetitle1)  
        wdetail.drivename1          = TRIM(n_drivename1)  
        wdetail.drivelname1         = TRIM(n_drivelname1)  
        wdetail.driveno1            = TRIM(n_driveno1)  
        wdetail.occupdriv1          = TRIM(n_occupdriv1)  
        wdetail.sexdriv1            = TRIM(n_sexdriv1)  
        wdetail.bdatedriv1          = IF n_bdatedriv1 = "" THEN "" ELSE
                                      SUBSTR(n_bdatedriv1,1,2) + "/" +      /*'01/09/1996*/
                                      SUBSTR(n_bdatedriv1,4,2) + "/" + 
                                      SUBSTR(n_bdatedriv1,7,4)         
        wdetail.drivetitle2         = TRIM(n_drivetitle2)  
        wdetail.drivename2          = TRIM(n_drivename2)  
        wdetail.drivelname2         = TRIM(n_drivelname2)  
        wdetail.driveno2            = TRIM(n_driveno2)  
        wdetail.occupdriv2          = TRIM(n_occupdriv2)  
        wdetail.sexdriv2            = TRIM(n_sexdriv2)  
        wdetail.bdatedriv2          = IF n_bdatedriv2 = "" THEN "" ELSE
                                      SUBSTR(n_bdatedriv2,1,2) + "/" +      /*'01/09/1996*/
                                      SUBSTR(n_bdatedriv2,4,2) + "/" + 
                                      SUBSTR(n_bdatedriv2,7,4)  
        /*-- Add By Tontawan S. A68-0059 27/03/2025 --*/
        wdetail.drv3_salutation_M   = TRIM(n_drv3_salutation_M)
        wdetail.drv3_fname          = TRIM(n_drv3_fname)       
        wdetail.drv3_lname          = TRIM(n_drv3_lname)       
        wdetail.drv3_nid            = TRIM(n_drv3_nid)       
        wdetail.drv3_occupation     = TRIM(n_drv3_occupation)  
        wdetail.drv3_gender         = TRIM(n_drv3_gender)      
        wdetail.drv3_birthdate      = TRIM(n_drv3_birthdate)
        wdetail.drv4_salutation_M   = TRIM(n_drv4_salutation_M)
        wdetail.drv4_fname          = TRIM(n_drv4_fname)
        wdetail.drv4_lname          = TRIM(n_drv4_lname)
        wdetail.drv4_nid            = TRIM(n_drv4_nid)
        wdetail.drv4_occupation     = TRIM(n_drv4_occupation)
        wdetail.drv4_gender         = TRIM(n_drv4_gender)
        wdetail.drv4_birthdate      = TRIM(n_drv4_birthdate) 
        wdetail.drv5_salutation_M   = TRIM(n_drv5_salutation_M)
        wdetail.drv5_fname          = TRIM(n_drv5_fname)
        wdetail.drv5_lname          = TRIM(n_drv5_lname)
        wdetail.drv5_nid            = TRIM(n_drv5_nid)
        wdetail.drv5_occupation     = TRIM(n_drv5_occupation)
        wdetail.drv5_gender         = TRIM(n_drv5_gender)      
        wdetail.drv5_birthdate      = TRIM(n_drv5_birthdate) 
        wdetail.drv1_dlicense       = TRIM(n_drv1_dlicense)    
        wdetail.drv2_dlicense       = TRIM(n_drv2_dlicense)    
        wdetail.drv3_dlicense       = TRIM(n_drv3_dlicense)    
        wdetail.drv4_dlicense       = TRIM(n_drv4_dlicense)    
        wdetail.drv5_dlicense       = TRIM(n_drv5_dlicense)    
        wdetail.baty_snumber        = TRIM(n_baty_snumber)
        wdetail.batydate            = TRIM(n_batydate)         
        wdetail.baty_rsi            = IF TRIM(n_baty_rsi)         = "" THEN "0" ELSE TRIM(n_baty_rsi)      
        wdetail.baty_npremium       = IF TRIM(n_baty_npremium)    = "" THEN "0" ELSE TRIM(n_baty_npremium)
        wdetail.baty_gpremium       = IF TRIM(n_baty_gpremium)    = "" THEN "0" ELSE TRIM(n_baty_gpremium)
        wdetail.wcharge_snumber     = TRIM(n_wcharge_snumber)
        wdetail.wcharge_si          = IF TRIM(n_wcharge_si)       = "" THEN "0" ELSE TRIM(n_baty_rsi)     
        wdetail.wcharge_npremium    = IF TRIM(n_wcharge_npremium) = "" THEN "0" ELSE TRIM(n_baty_npremium)
        wdetail.wcharge_gpremium    = IF TRIM(n_wcharge_gpremium) = "" THEN "0" ELSE TRIM(n_baty_gpremium).
        /*-- End By Tontawan S. A68-0059 27/03/2025 --*/

    CREATE wdetail2.
    ASSIGN
        wdetail2.chassis         = TRIM(n_chassis) 
        wdetail2.covcod          = TRIM(n_covcod) 
        wdetail2.covtyp          = TRIM(n_covtyp)
        wdetail2.brand           = TRIM(n_brand)    
        wdetail2.brand_cd        = TRIM(n_brand_cd)    
        wdetail2.Model           = TRIM(n_Model)    
        wdetail2.Model_cd        = TRIM(n_Model_cd)    
        wdetail2.body            = TRIM(n_body)    
        wdetail2.body_cd         = TRIM(n_body_cd)    
        wdetail2.licence         = TRIM(n_licence)    
        wdetail2.province        = TRIM(n_province)    
        wdetail2.chassis         = TRIM(n_chassis)    
        wdetail2.engine          = TRIM(n_engine)    
        wdetail2.yrmanu          = IF SUBSTRING(n_yrmanu,1,2) = "25" THEN TRIM(STRING(INT(n_yrmanu) - 543)) ELSE TRIM(n_yrmanu) //TRIM(n_yrmanu)   
        wdetail2.seatenew        = TRIM(n_seatenew)    
        wdetail2.power           = TRIM(n_power)    
        wdetail2.weight          = TRIM(n_weight)    
        wdetail2.class           = TRIM(n_class)    
        wdetail2.garage_cd       = TRIM(n_garage_cd)    
        wdetail2.garage          = TRIM(n_garage)    
        wdetail2.colorcode       = TRIM(n_colorcode)    
        wdetail2.covcod          = TRIM(n_covcod)    
        wdetail2.covtyp          = TRIM(n_covtyp)    
        wdetail2.covtyp1         = TRIM(n_covtyp1)    
        wdetail2.covtyp2         = TRIM(n_covtyp2)    
        wdetail2.covtyp3         = TRIM(n_covtyp3)   

        wdetail2.comdat          = IF n_comdat = "" THEN "" ELSE 
                                   SUBSTR(n_comdat,9,2) + "/" +  /*''2022-07-15 */
                                   SUBSTR(n_comdat,6,2) + "/" +   
                                   SUBSTR(n_comdat,1,4)     
  
        wdetail2.expdat          =  IF n_expdat = "" THEN "" ELSE
                                     SUBSTR(n_expdat,9,2) + "/" +  /*'2023-07-15*/
                                     SUBSTR(n_expdat,6,2) + "/" + 
                                     SUBSTR(n_expdat,1,4)   

        wdetail2.ins_amt         = TRIM(n_ins_amt)    
        wdetail2.prem1           = TRIM(n_prem1)    
        wdetail2.gross_prm       = TRIM(n_gross_prm)    
        wdetail2.stamp           = TRIM(n_stamp)    
        wdetail2.vat             = TRIM(n_vat)    
        wdetail2.premtotal       = TRIM(n_premtotal)    
        wdetail2.deduct          = TRIM(n_deduct)
        wdetail2.fleetper        = IF INDEX(n_fleetper,"%") <> 0 THEN REPLACE(n_fleetper,"%","") ELSE TRIM(n_fleetper)    
        wdetail2.fleet           = TRIM(n_fleet)    
        wdetail2.ncbper          = IF INDEX(n_ncbper,"%") <> 0 THEN REPLACE(n_ncbper,"%","") ELSE TRIM(n_ncbper)    
        wdetail2.ncb             = TRIM(n_ncb )  
        wdetail2.drivper         = IF INDEX(n_drivper,"%") <> 0 THEN REPLACE(n_drivper,"%","") ELSE TRIM(n_drivper)    
        wdetail2.drivdis         = TRIM(n_drivdis)    
        wdetail2.othper          = IF INDEX(n_othper,"%") <> 0 THEN REPLACE(n_othper,"%","") ELSE TRIM(n_othper)    
        wdetail2.oth             = TRIM(n_oth )  
        wdetail2.cctvper         = IF INDEX(n_cctvper,"%") <> 0 THEN REPLACE(n_cctvper,"%","") ELSE TRIM(n_cctvper)    
        wdetail2.cctv            = TRIM(n_cctv)    
        wdetail2.Surcharper      = IF INDEX(n_Surcharper,"%") <> 0 THEN REPLACE(n_Surcharper,"%","") ELSE TRIM(n_Surcharper)   
        wdetail2.Surchar         = TRIM(n_Surchar)
        wdetail2.Surchardetail   = TRIM(n_Surchardetail)
        wdetail2.acc1            = TRIM(n_acc1) 
        wdetail2.accdetail1      = TRIM(n_accdetail1)   
        wdetail2.accprice1       = TRIM(n_accprice1)
        wdetail2.acc2            = TRIM(n_acc2) 
        wdetail2.accdetail2      = TRIM(n_accdetail2)   
        wdetail2.accprice2       = TRIM(n_accprice2)
        wdetail2.acc3            = TRIM(n_acc3) 
        wdetail2.accdetail3      = TRIM(n_accdetail3)   
        wdetail2.accprice3       = TRIM(n_accprice3)
        wdetail2.acc4            = TRIM(n_acc4) 
        wdetail2.accdetail4      = TRIM(n_accdetail4)   
        wdetail2.accprice4       = TRIM(n_accprice4)
        wdetail2.acc5            = TRIM(n_acc5) 
        wdetail2.accdetail5      = TRIM(n_accdetail5)   
        wdetail2.accprice5       = TRIM(n_accprice5)
        wdetail2.inspdate        = IF n_inspdate = "" THEN "" ELSE    
                                   SUBSTR(n_inspdate,9,2) + "/" +  /*''2022-07-11 16:21:26*/
                                   SUBSTR(n_inspdate,6,2) + "/" +                 
                                   SUBSTR(n_inspdate,1,4)
        wdetail2.inspdate_app    = IF n_inspdate_app = "" THEN "" ELSE    
                                   SUBSTR(n_inspdate_app,9,2) + "/" +  /*''2022-07-11 16:21:26*/
                                   SUBSTR(n_inspdate_app,6,2) + "/" +                 
                                   SUBSTR(n_inspdate_app,1,4)                         
        wdetail2.inspsts         = TRIM(n_inspsts)
        wdetail2.inspdetail      = TRIM(n_inspdetail)
        wdetail2.not_date        = IF n_not_date = "" THEN "" ELSE    
                                   SUBSTR(n_not_date,9,2) + "/" +  /*'01/09/1996*/
                                   SUBSTR(n_not_date,6,2) + "/" +                 
                                   SUBSTR(n_not_date,1,4) 
        wdetail2.paydate         = IF n_paydate = "" THEN "" ELSE    
                                   SUBSTR(n_paydate,9,2) + "/" +  /*'01/09/1996*/
                                   SUBSTR(n_paydate,6,2) + "/" +                 
                                   SUBSTR(n_paydate,1,4)
        wdetail2.paysts          = TRIM(n_paysts)
        wdetail2.licenBroker     = TRIM(n_licenBroker)
        wdetail2.brokname        = TRIM(n_brokname)
        wdetail2.brokcode        = TRIM(n_brokcode)
        wdetail2.lang            = TRIM(n_lang) 
        wdetail2.deli            = TRIM(n_deli) 
        wdetail2.delidetail      = TRIM(n_delidetail)
        wdetail2.gift            = TRIM(n_gift) 
        wdetail2.cedcode         = TRIM(n_cedcode)  
        wdetail2.inscode         = TRIM(n_inscode)  
        wdetail2.remark          = TRIM(n_remark)  
        wdetail2.ben_2title      = TRIM(n_ben_2title)        /*Add Kridtiya i. A64-0295 DATE. 25/07/2021*/ 
        wdetail2.ben_2name       = TRIM(n_ben_2name)         /*Add Kridtiya i. A64-0295 DATE. 25/07/2021*/ 
        wdetail2.ben_2lname      = TRIM(n_ben_2lname)        /*Add Kridtiya i. A64-0295 DATE. 25/07/2021*/ 
        wdetail2.ben_3title      = TRIM(n_ben_3title)        /*Add Kridtiya i. A64-0295 DATE. 25/07/2021*/ 
        wdetail2.ben_3name       = TRIM(n_ben_3name)         /*Add Kridtiya i. A64-0295 DATE. 25/07/2021*/ 
        wdetail2.ben_3lname      = TRIM(n_ben_3lname)        /*Add Kridtiya i. A64-0295 DATE. 25/07/2021*/ 
        wdetail2.Agent_Code      = TRIM(n_Agent_Code)        /*Add Kridtiya i. A64-0295 DATE. 25/07/2021*/ 
        wdetail2.Agent_Name_TH   = TRIM(n_Agent_Name_TH)     /*Add Kridtiya i. A64-0295 DATE. 25/07/2021*/ 
        wdetail2.Agent_Name_Eng  = TRIM(n_Agent_Name_Eng)    /*Add Kridtiya i. A64-0295 DATE. 25/07/2021*/ 
        wdetail2.Selling_Channel = TRIM(n_Selling_Channel) . /*Add Kridtiya i. A64-0295 DATE. 25/07/2021*/ 

END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cutremak C-Win 
PROCEDURE proc_cutremak :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*wdetail2.remark*/ 
ASSIGN  nn_remark1 = ""
        nn_remark2 = ""
        nn_remark3 = "".
IF      R-INDEX(wdetail2.remark,"/บริษัท") <> 0 THEN DO: 
    ASSIGN 
        nn_remark2 = trim(SUBSTR(wdetail2.remark,R-INDEX(wdetail2.remark,"/บริษัท"))) 
        nn_remark1 = trim(SUBSTR(wdetail2.remark,1,R-INDEX(wdetail2.remark,"/บริษัท") - 1 )) .
    IF LENGTH(nn_remark1 + " " + nn_remark2) <= 110 THEN 
        ASSIGN nn_remark1 = nn_remark1 + " " + nn_remark2
               nn_remark2 = "".
    IF LENGTH(nn_remark1) > 110 THEN DO:
        IF R-INDEX(nn_remark1," ") <> 0  THEN
            ASSIGN  
            nn_remark2 = trim(substr(nn_remark1,R-INDEX(nn_remark1," "))) + " " + nn_remark2
            nn_remark1 = trim(substr(nn_remark1,1,R-INDEX(nn_remark1," "))).
        ELSE ASSIGN 
            nn_remark2 = trim(substr(nn_remark1,110 )) + " " + nn_remark2
            nn_remark1 = trim(substr(nn_remark1,1,110)).
    END.
    IF LENGTH(nn_remark2) > 85 THEN DO:
        IF R-INDEX(nn_remark2," ") <> 0  THEN
            ASSIGN  
            nn_remark3 = trim(substr(nn_remark2,R-INDEX(nn_remark2," ")))
            nn_remark2 = trim(substr(nn_remark2,1,R-INDEX(nn_remark2," "))).
        ELSE ASSIGN 
            nn_remark3 = trim(substr(nn_remark2,86 )) 
            nn_remark2 = trim(substr(nn_remark2,1,85)).
    END.

END.
ELSE IF      R-INDEX(wdetail2.remark,"/บจก") <> 0 THEN DO: 
    ASSIGN 
        nn_remark2 = trim(SUBSTR(wdetail2.remark,R-INDEX(wdetail2.remark,"/บจก"))) 
        nn_remark1 = trim(SUBSTR(wdetail2.remark,1,R-INDEX(wdetail2.remark,"/บจก") - 1 )) .
    IF LENGTH(nn_remark1 + " " + nn_remark2) <= 110 THEN 
        ASSIGN nn_remark1 = nn_remark1 + " " + nn_remark2
               nn_remark2 = "".
    IF LENGTH(nn_remark1) > 110 THEN DO:
        IF R-INDEX(nn_remark1," ") <> 0  THEN
            ASSIGN  
            nn_remark2 = trim(substr(nn_remark1,R-INDEX(nn_remark1," "))) + " " + nn_remark2
            nn_remark1 = trim(substr(nn_remark1,1,R-INDEX(nn_remark1," "))).
        ELSE ASSIGN 
            nn_remark2 = trim(substr(nn_remark1,110 )) + " " + nn_remark2
            nn_remark1 = trim(substr(nn_remark1,1,110)).
    END.
    IF LENGTH(nn_remark2) > 110 THEN DO:
        IF R-INDEX(nn_remark2," ") <> 0  THEN
            ASSIGN  
            nn_remark3 = trim(substr(nn_remark2,R-INDEX(nn_remark2," ")))
            nn_remark2 = trim(substr(nn_remark2,1,R-INDEX(nn_remark2," "))).
        ELSE ASSIGN 
            nn_remark3 = trim(substr(nn_remark2,111 )) 
            nn_remark2 = trim(substr(nn_remark2,1,110)).
    END.
END.
ELSE IF      R-INDEX(wdetail2.remark,"/ห้าง") <> 0 THEN DO: 
    ASSIGN 
        nn_remark2 = trim(SUBSTR(wdetail2.remark,R-INDEX(wdetail2.remark,"/ห้าง"))) 
        nn_remark1 = trim(SUBSTR(wdetail2.remark,1,R-INDEX(wdetail2.remark,"/ห้าง") - 1 )) .
    IF LENGTH(nn_remark1 + " " + nn_remark2) <= 110 THEN 
        ASSIGN nn_remark1 = nn_remark1 + " " + nn_remark2
               nn_remark2 = "".
    IF LENGTH(nn_remark1) > 110 THEN DO:
        IF R-INDEX(nn_remark1," ") <> 0  THEN
            ASSIGN  
            nn_remark2 = trim(substr(nn_remark1,R-INDEX(nn_remark1," "))) + " " + nn_remark2
            nn_remark1 = trim(substr(nn_remark1,1,R-INDEX(nn_remark1," "))).
        ELSE ASSIGN 
            nn_remark2 = trim(substr(nn_remark1,110 )) + " " + nn_remark2
            nn_remark1 = trim(substr(nn_remark1,1,110)).
    END.
    IF LENGTH(nn_remark2) > 110 THEN DO:
        IF R-INDEX(nn_remark2," ") <> 0  THEN
            ASSIGN  
            nn_remark3 = trim(substr(nn_remark2,R-INDEX(nn_remark2," ")))
            nn_remark2 = trim(substr(nn_remark2,1,R-INDEX(nn_remark2," "))).
        ELSE ASSIGN 
            nn_remark3 = trim(substr(nn_remark2,111 )) 
            nn_remark2 = trim(substr(nn_remark2,1,110)).
    END.
END.
ELSE DO:
    ASSIGN 
        nn_remark2 = trim(SUBSTR(wdetail2.remark,R-INDEX(wdetail2.remark," "))) 
        nn_remark1 = trim(SUBSTR(wdetail2.remark,1,R-INDEX(wdetail2.remark," ") - 1 )) .
    IF LENGTH(nn_remark1 + " " + nn_remark2) <= 110 THEN 
        ASSIGN nn_remark1 = nn_remark1 + " " + nn_remark2
               nn_remark2 = "".  
    loop_chk0:
    REPEAT:
        IF LENGTH(nn_remark1) > 110 THEN DO:
            IF R-INDEX(nn_remark1," ") <> 0  THEN
                ASSIGN  
                nn_remark2 = trim(substr(nn_remark1,R-INDEX(nn_remark1," "))) + " " + nn_remark2
                nn_remark1 = trim(substr(nn_remark1,1,R-INDEX(nn_remark1," "))).
            ELSE ASSIGN 
                nn_remark2 = trim(substr(nn_remark1,111)) + " " + nn_remark2
                nn_remark1 = trim(substr(nn_remark1,1,110)) .
        END.
        ELSE IF LENGTH(nn_remark2) > 85 THEN DO:
            IF R-INDEX(nn_remark2," ") <> 0  THEN
                ASSIGN  
                nn_remark3 = trim(substr(nn_remark2,R-INDEX(nn_remark2," "))) 
                nn_remark2 = trim(substr(nn_remark2,1,R-INDEX(nn_remark2," "))).
            ELSE ASSIGN 
                nn_remark3 = trim(substr(nn_remark2,86)) 
                nn_remark2 = trim(substr(nn_remark2,1,85)).
        END.
        ELSE LEAVE loop_chk0.
    END.
END.
loop_chk1:
REPEAT:
    IF INDEX(nn_remark1,"  ") <> 0 THEN DO:
        nv_len = LENGTH(nn_remark1).
        nn_remark1 = SUBSTRING(nn_remark1,1,INDEX(nn_remark1,"  ") - 2 ) + " " +
            trim(SUBSTRING(nn_remark1,INDEX(nn_remark1,"  "), nv_len )) .
    END.
    ELSE LEAVE loop_chk1.
END.
loop_chk2:
REPEAT:
    IF INDEX(nn_remark2,"  ") <> 0 THEN DO:
        nv_len = LENGTH(nn_remark2).
        nn_remark2 = SUBSTRING(nn_remark2,1,INDEX(nn_remark2,"  ") - 2 ) + " " +
            trim(SUBSTRING(nn_remark2,INDEX(nn_remark2,"  "), nv_len )) .
    END.
    ELSE LEAVE loop_chk2.
END.
loop_chk3:
REPEAT:
    IF INDEX(nn_remark3,"  ") <> 0 THEN DO:
        nv_len = LENGTH(nn_remark3).
        nn_remark3 = SUBSTRING(nn_remark3,1,INDEX(nn_remark3,"  ") - 2 ) + " " +
            trim(SUBSTRING(nn_remark3,INDEX(nn_remark3,"  "), nv_len )) .
    END.
    ELSE LEAVE loop_chk3.
END.
IF LENGTH(nn_remark2 + " " + nn_remark3 ) <= 85 THEN 
    ASSIGN nn_remark2 = nn_remark2 + " " + nn_remark3  
           nn_remark3 = "".
IF LENGTH(nn_remark1 + " " + nn_remark2) <= 110 THEN 
    ASSIGN nn_remark1 = nn_remark1 + " " + nn_remark2
           nn_remark2 = "".
/*
DISP LENGTH(nn_remark1)
     nn_remark1 FORMAT "x(65)"
     nn_remark2 FORMAT "x(65)"  
     nn_remark3 FORMAT "x(65)" .*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_definition C-Win 
PROCEDURE Proc_definition :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*Modify BY : Kridtiya i. A64-0295 DATE. 25/07/2021 เพิ่ม ข้อมูลตาม Layout ใหม่ 
                          นำตัวแปร ไปเก็บไว้ ที่ wgwimscb.i เนื่องจาก ไม่สามารถเขียน code เพิ่มได้ codeing full  */
/*Modify BY : Kridtiya i. A65-0174 DATE. 12/08/2022 ปรับแก้ไขรับ format new  */
                          
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_Getdatainsp C-Win 
PROCEDURE proc_Getdatainsp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_list      AS INT init 0.
DEF VAR n_count     AS INT init 0.
DEF VAR n_agent     AS CHAR FORMAT "x(10)" INIT "".
DEF VAR n_repair    AS CHAR FORMAT "x(10)" init "".
DEF VAR n_dam       AS CHAR FORMAT "x(10)" init "".
DEF VAR n_deatil    AS CHAR FORMAT "x(60)" init "".
DEF VAR nv_damag    AS CHAR FORMAT "x(30)" init "".
DEF VAR nv_repair   AS CHAR FORMAT "x(30)" init "".
DO:
      chitem       = chDocument:Getfirstitem("ConsiderDate").      /*วันที่ปิดเรื่อง*/
      IF chitem <> 0 THEN nv_date = chitem:TEXT. 
      ELSE nv_date = "".

      chitem       = chDocument:Getfirstitem("docno").      /*เลขตรวจสภาพ*/
      IF chitem <> 0 THEN nv_docno = chitem:TEXT. 
      ELSE nv_docno = "".
      
      chitem       = chDocument:Getfirstitem("SurveyClose").    /* สเตตัสปิดเรื่อง */
      IF chitem <> 0 THEN nv_survey  = chitem:TEXT. 
      ELSE nv_survey = "".

      chitem       = chDocument:Getfirstitem("SurveyResult").  /*ผลการตรวจ*/
      IF chitem <> 0 THEN  nv_detail = chitem:TEXT. 
      ELSE nv_detail = "".

      IF nv_detail = "ติดปัญหา" THEN DO:
          chitem       = chDocument:Getfirstitem("DamageC").    /*ข้อมูลการติดปัญหา */
          IF chitem <> 0 THEN nv_damage    = chitem:TEXT.
          ELSE nv_damage = "".
      END.
      IF nv_detail = "มีความเสียหาย"  THEN DO:
          chitem       = chDocument:Getfirstitem("DamageList").  /* รายการความเสียหาย */
          IF chitem <> 0 THEN nv_damlist  = chitem:TEXT.
          ELSE nv_damlist = "".
          chitem       = chDocument:Getfirstitem("TotalExpensive").  /* ราคาความเสียหาย */
          IF chitem <> 0 THEN nv_totaldam  = chitem:TEXT.
          ELSE nv_totaldam = "".

          IF nv_damlist <> "" THEN DO: 
              ASSIGN    n_list     = INT(nv_damlist) 
                        nv_damlist = "จำนวนความเสียหาย " + nv_damlist + " รายการ " .
          END.
          IF nv_totaldam <> "" THEN ASSIGN nv_totaldam = "รวมความเสียหายทั้งสิ้น " + nv_totaldam + " บาท " .
          
          IF n_list > 0  THEN DO:
            ASSIGN  n_count = 1 .
            loop_damage:
            REPEAT:
                IF n_count <= n_list THEN DO:
                    ASSIGN  n_dam    = "List"   + STRING(n_count) 
                            n_repair = "Repair" + STRING(n_count) .

                    chitem       = chDocument:Getfirstitem(n_dam).
                    IF chitem <> 0 THEN  nv_damag  = chitem:TEXT. 
                    ELSE nv_damag = "".   
                    chitem       = chDocument:Getfirstitem(n_repair).
                    IF chitem <> 0 THEN  nv_repair = chitem:TEXT. 
                    ELSE nv_repair = "".

                    IF nv_damag <> "" THEN  
                        ASSIGN nv_damdetail = nv_damdetail + STRING(n_count) + "." + nv_damag + " " + nv_repair + " , " .
                        
                    n_count = n_count + 1.
                END.
                ELSE LEAVE loop_damage.
            END.
          END.
      END.
      /*-- ข้อมูลอื่น ๆ ---*/
      chitem       = chDocument:Getfirstitem("SurverData").
      IF chitem <> 0 THEN  nv_surdata = chitem:TEXT. 
      ELSE nv_surdata = "".
      IF trim(nv_surdata) <> "" THEN  nv_surdata = "ข้อมูลอื่นๆ :"  +  nv_surdata .
      
      chitem       = chDocument:Getfirstitem("agentCode").      /*agentCode*/
      IF chitem <> 0 THEN n_agent = chitem:TEXT. 
      ELSE n_agent = "".
      
      IF TRIM(n_agent) <> "" THEN ASSIGN nv_surdata = nv_surdata + " โค้ดตัวแทน: " + n_agent.

      /*-- อุปกรณ์เสริม --*/  
      chitem       = chDocument:Getfirstitem("device1").
      IF chitem <> 0 THEN  nv_device = chitem:TEXT. 
      ELSE nv_device = "".
      IF nv_device <> "" THEN DO:
          chitem       = chDocument:Getfirstitem("PricesTotal").  /* ราคารวมอุปกรณ์เสริม */
          IF chitem <> 0 THEN  nv_acctotal = chitem:TEXT. 
          ELSE nv_acctotal = "".
          chitem       = chDocument:Getfirstitem("DType1").
          IF chitem <> 0 THEN  nv_acc1 = chitem:TEXT. 
          ELSE nv_acc1 = "".
          chitem       = chDocument:Getfirstitem("DType2").
          IF chitem <> 0 THEN  nv_acc2 = chitem:TEXT. 
          ELSE nv_acc2 = "".
          chitem       = chDocument:Getfirstitem("DType3").
          IF chitem <> 0 THEN  nv_acc3 = chitem:TEXT. 
          ELSE nv_acc3 = "".
          chitem       = chDocument:Getfirstitem("DType4").
          IF chitem <> 0 THEN  nv_acc4 = chitem:TEXT. 
          ELSE nv_acc4 = "".
          chitem       = chDocument:Getfirstitem("DType5").
          IF chitem <> 0 THEN  nv_acc5 = chitem:TEXT. 
          ELSE nv_acc5 = "".
          chitem       = chDocument:Getfirstitem("DType6").
          IF chitem <> 0 THEN  nv_acc6 = chitem:TEXT. 
          ELSE nv_acc6 = "".
          chitem       = chDocument:Getfirstitem("DType7").
          IF chitem <> 0 THEN  nv_acc7 = chitem:TEXT. 
          ELSE nv_acc7 = "".
          chitem       = chDocument:Getfirstitem("DType8").
          IF chitem <> 0 THEN  nv_acc8 = chitem:TEXT. 
          ELSE nv_acc8 = "".
          chitem       = chDocument:Getfirstitem("DType9").
          IF chitem <> 0 THEN  nv_acc9 = chitem:TEXT. 
          ELSE nv_acc9 = "".
          chitem       = chDocument:Getfirstitem("DType10").
          IF chitem <> 0 THEN  nv_acc10 = chitem:TEXT. 
          ELSE nv_acc10 = "".
          chitem       = chDocument:Getfirstitem("DType11").
          IF chitem <> 0 THEN  nv_acc11 = chitem:TEXT. 
          ELSE nv_acc11 = "".
          chitem       = chDocument:Getfirstitem("DType12").
          IF chitem <> 0 THEN  nv_acc12 = chitem:TEXT. 
          ELSE nv_acc12 = "".
          
          nv_device = "" .
          IF TRIM(nv_acc1)  <> "" THEN nv_device = nv_device + TRIM(nv_acc1).
          IF TRIM(nv_acc2)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc2).
          IF TRIM(nv_acc3)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc3).
          IF TRIM(nv_acc4)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc4).
          IF TRIM(nv_acc5)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc5).
          IF TRIM(nv_acc6)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc6).
          IF TRIM(nv_acc7)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc7).
          IF TRIM(nv_acc8)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc8).
          IF TRIM(nv_acc9)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc9).
          IF TRIM(nv_acc10) <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc10).
          IF TRIM(nv_acc11) <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc11).
          IF TRIM(nv_acc12) <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc12) .
          nv_acctotal = " ราคารวมอุปกรณ์เสริม " + nv_acctotal + " บาท " .
      END.

END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_inspection C-Win 
PROCEDURE proc_inspection :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Create by A60-0118      
------------------------------------------------------------------------------*/
ASSIGN  nv_nameT    = ""   nv_agentname = ""  nv_brand    = ""   nv_model     = ""   nv_licentyp = ""   nv_licen     = ""  
        nv_pattern1 = ""   nv_pattern4  = ""  nv_today    = ""   nv_time      = ""   nv_docno    = ""   nv_survey    = ""  
        nv_detail   = ""   nv_remark1   = ""  nv_remark2  = ""   nv_damlist   = ""   nv_damage   = ""   nv_totaldam  = ""  
        nv_attfile  = ""   nv_device    = ""  nv_acc1     = ""   nv_acc2      = ""   nv_acc3     = ""   nv_acc4      = ""   
        nv_acc5     = ""   nv_acc6      = ""  nv_acc7     = ""   nv_acc8      = ""   nv_acc9     = ""   nv_acc10     = ""   
        nv_acc11    = ""   nv_acc12    = ""   nv_acctotal  = ""  nv_surdata   = ""   nv_date     = ""   nv_damdetail = ""
        nv_tmp      = "Inspect" + SUBSTR(fi_insp,3,2) + ".nsf" 
        nv_today    = STRING(DAY(TODAY),"99") + "/" + STRING(MONTH(TODAY),"99") + "/" + STRING(YEAR(TODAY),"9999")
        nv_time     = STRING(TIME,"HH:MM:SS")
        nv_remark1  = IF trim(winsp.inspcont) <> ""  THEN "ติดต่อ : " + trim(winsp.inspcont) ELSE ""
        nv_remark1  = IF trim(winsp.insptel)  <> ""  THEN trim(nv_remark1) + " เบอร์โทร: " + trim(winsp.insptel) ELSE trim(nv_remark1)
        nv_remark1  = IF trim(winsp.lineid)   <> ""  THEN trim(nv_remark1) + " LineID: " + trim(winsp.lineid)    ELSE trim(nv_remark1)
        nv_remark1  = IF trim(winsp.mail)     <> ""  THEN trim(nv_remark1) + " Email: "  + trim(winsp.mail)      ELSE trim(nv_remark1)
        nv_remark1  = IF trim(winsp.insptime) <> ""  THEN trim(nv_remark1) + " เวลา: "   + trim(winsp.insptime)  ELSE trim(nv_remark1)
        nv_remark1  = IF trim(winsp.inspaddr) <> ""  THEN trim(nv_remark1) + " สถานที่: " + trim(winsp.inspaddr) ELSE trim(nv_remark1)
        nv_remark2  = IF trim(winsp.acc1) <> "" OR TRIM(winsp.accdetail1) <> "" THEN "อุปกรณ์เสริม : " + trim(winsp.acc1) + " " 
                    + TRIM(winsp.accdetail1) + "ราคา : " + trim(winsp.accprice1) ELSE ""
        nv_remark2  = IF trim(winsp.acc2) <> "" OR TRIM(winsp.accdetail2) <> "" THEN trim(nv_remark2) + " อุปกรณ์เสริม : " + trim(winsp.acc2) + " " 
                    + TRIM(winsp.accdetail2) + "ราคา : " + trim(winsp.accprice2) ELSE trim(nv_remark2)
        nv_remark2  = IF trim(winsp.acc3) <> "" OR TRIM(winsp.accdetail3) <> "" THEN trim(nv_remark2) + " อุปกรณ์เสริม : " + trim(winsp.acc3) + " " 
                    + TRIM(winsp.accdetail3) + "ราคา : " + trim(winsp.accprice3) ELSE trim(nv_remark2)
        nv_remark2  = IF trim(winsp.acc4) <> "" OR TRIM(winsp.accdetail4) <> "" THEN trim(nv_remark2) + " อุปกรณ์เสริม : " + trim(winsp.acc2) + " " 
                    + TRIM(winsp.accdetail4) + "ราคา : " + trim(winsp.accprice4) ELSE trim(nv_remark2)
        nv_remark2  = IF trim(winsp.acc5) <> "" OR TRIM(winsp.accdetail5) <> "" THEN trim(nv_remark2) + " อุปกรณ์เสริม : " + trim(winsp.acc2) + " " 
                    + TRIM(winsp.accdetail5) + "ราคา : " + trim(winsp.accprice5) ELSE trim(nv_remark2).
IF INDEX(winsp.pol_fname,"คุณ")               <> 0 THEN ASSIGN winsp.pol_fname = REPLACE(winsp.pol_fname,"คุณ","")    nv_nameT = "บุคคล".
ELSE IF INDEX(winsp.pol_fname,"นาย")          <> 0 THEN ASSIGN winsp.pol_fname = REPLACE(winsp.pol_fname,"นาย","")    nv_nameT = "บุคคล".
ELSE IF INDEX(winsp.pol_fname,"นางสาว")       <> 0 THEN ASSIGN winsp.pol_fname = REPLACE(winsp.pol_fname,"นางสาว","") nv_nameT = "บุคคล".
ELSE IF INDEX(winsp.pol_fname,"นาง")          <> 0 THEN ASSIGN winsp.pol_fname = REPLACE(winsp.pol_fname,"นาง","")    nv_nameT = "บุคคล".
ELSE IF INDEX(winsp.pol_fname,"น.ส.")         <> 0 THEN ASSIGN winsp.pol_fname = REPLACE(winsp.pol_fname,"น.ส.","")   nv_nameT = "บุคคล".
ELSE IF INDEX(winsp.pol_fname,"ห้างหุ้นส่วน") <> 0 THEN ASSIGN nv_nameT = "ห้างหุ้นส่วนจำกัด / ห้างหุ้นส่วน".
ELSE IF INDEX(winsp.pol_fname,"หจก")          <> 0 THEN ASSIGN nv_nameT = "ห้างหุ้นส่วนจำกัด / ห้างหุ้นส่วน".
ELSE IF INDEX(winsp.pol_fname,"บริษัท")       <> 0 THEN ASSIGN nv_nameT = "บริษัท".
ELSE IF INDEX(winsp.pol_fname,"บจก")          <> 0 THEN ASSIGN nv_nameT = "บริษัท".
ELSE IF INDEX(winsp.pol_fname,"มูลนิธิ")      <> 0 THEN ASSIGN nv_nameT = "มูลนิธิ".
ELSE IF INDEX(winsp.pol_fname,"โรงแรม")       <> 0 THEN ASSIGN nv_nameT = "โรงแรม".
ELSE IF INDEX(winsp.pol_fname,"โรงเรียน")     <> 0 THEN ASSIGN nv_nameT = "โรงเรียน".
ELSE IF INDEX(winsp.pol_fname,"ร.ร.")         <> 0 THEN ASSIGN nv_nameT = "โรงเรียน".
ELSE IF INDEX(winsp.pol_fname,"โรงพยาบาล")    <> 0 THEN ASSIGN nv_nameT = "โรงพยาบาล".
ELSE IF INDEX(winsp.pol_fname,"นิติบุคคลอาคารชุด") <> 0 THEN ASSIGN nv_nameT = "นิติบุคคลอาคารชุด".
ELSE ASSIGN nv_nameT = "อื่นๆ".
ASSIGN nv_brand = trim(winsp.brand)
       nv_model = TRIM(winsp.model).
IF trim(winsp.licence) <> "" AND trim(winsp.province) <> "" THEN DO:
    ASSIGN nv_licentyp = "รถเก๋ง/กระบะ/บรรทุก".
    RUN proc_province.
END.
ELSE DO: 
    ASSIGN nv_licentyp = "รถที่ยังไม่มีทะเบียน"
           nv_pattern4 = "/ZZZZZZZZZ" 
           winsp.licence = "/" + SUBSTR(winsp.chassis,LENGTH(winsp.chassis) - 8,LENGTH(winsp.chassis)) 
           winsp.province = "".
END.
IF trim(fi_producer) <> "" THEN DO:
    FIND sicsyac.xmm600 USE-INDEX xmm60001   WHERE
        xmm600.acno  =  trim(fi_producer) NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAIL sicsyac.xmm600 THEN DO:
        FIND sicsyac.xtm600 USE-INDEX xtm60001  WHERE xtm600.acno  =  trim(fi_producer) NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL xtm600 THEN 
            ASSIGN nv_agentname = TRIM(sicsyac.xtm600.ntitle) + "  "  + TRIM(sicsyac.xtm600.name) .
        ELSE 
            ASSIGN nv_agentname = "".
    END.
    ELSE 
        ASSIGN nv_agentname =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name) .
END.
RUN proc_chkpattern.  /*A63-0450*/
/* comment by A63-450 ...
IF trim(winsp.licence) <> "" THEN DO:
   ASSIGN nv_licen = REPLACE(winsp.licence," ","").
   IF INDEX("0123456789",SUBSTR(winsp.licence,1,1)) <> 0 THEN DO:
       IF LENGTH(nv_licen) = 4 THEN 
          ASSIGN nv_Pattern1 = "y-xx-y-xx"
                 nv_licen    = SUBSTR(nv_licen,1,1) + " " + SUBSTR(nv_licen,2,2) + " " + SUBSTR(nv_licen,4,1).
       ELSE IF LENGTH(nv_licen) = 5 THEN
           ASSIGN nv_Pattern1 = "y-xx-yy-xx"
                  nv_licen    = SUBSTR(nv_licen,1,1) + " " + SUBSTR(nv_licen,2,2) + " " + SUBSTR(nv_licen,4,2).
       ELSE IF LENGTH(nv_licen) = 6 THEN DO:
           IF INDEX("0123456789",SUBSTR(nv_licen,2,1)) <> 0 THEN
               ASSIGN nv_Pattern1 = "yy-yyyy-xx"
                      nv_licen    = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,4).
           ELSE IF INDEX("0123456789",SUBSTR(nv_licen,3,1)) <> 0 THEN
               ASSIGN nv_Pattern1 = "yx-yyyy-xx"
                      nv_licen    = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,4).
           ELSE 
               ASSIGN nv_Pattern1 = "y-xx-yyy-xx"
                      nv_licen    = SUBSTR(nv_licen,1,1) + " " + SUBSTR(nv_licen,2,2) + " " + SUBSTR(nv_licen,4,3). 
       END.
       ELSE 
           ASSIGN nv_Pattern1 = "y-xx-yyyy-xx"
                  nv_licen    = SUBSTR(nv_licen,1,1) + " " + SUBSTR(nv_licen,2,2) + " " + SUBSTR(nv_licen,4,4).
    END.
    ELSE DO:
        IF LENGTH(nv_licen) = 3 THEN 
          ASSIGN nv_Pattern1 = "xx-y-xx"
                 nv_licen    = SUBSTR(nv_licen,1,2) + " "  + SUBSTR(nv_licen,3,1) .
        ELSE IF LENGTH(nv_licen) = 4 THEN
           ASSIGN nv_Pattern1 = "xx-yy-xx"
                  nv_licen    = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,2) .
        ELSE IF LENGTH(nv_licen) = 6 THEN
           ASSIGN nv_Pattern1 = "xx-yyyy-xx" 
                  nv_licen    = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,4) .
        ELSE IF LENGTH(nv_licen) = 5 THEN DO:
            IF INDEX("0123456789",SUBSTR(nv_licen,2,1)) <> 0 THEN
               ASSIGN nv_Pattern1 = "x-yyyy-xx"
                      nv_licen    = SUBSTR(nv_licen,1,1) + " " + SUBSTR(nv_licen,2,4).
            ELSE 
               ASSIGN nv_Pattern1 = "xx-yyy-xx" 
                      nv_licen    = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,3).
        END.
    END.
END.
... end A63-0450 */

/*--------- Server Real ---------- */
nv_server = "Safety_NotesServer/Safety".
nv_tmp    = "safety\uw\" + nv_tmp .

/*-------------------------------*/

/*---------- Server test local ------- TEST A68-0059 27/03/2025 
nv_server = "".
nv_tmp    = "D:\Lotus\Notes\Data\" + nv_tmp .
/*----Server test local --------*/*/


CREATE "Notes.NotesSession"  chNotesSession.
chNotesDatabase  = chNotesSession:GetDatabase (nv_server,nv_tmp).
IF  chNotesDatabase:IsOpen()  = NO  THEN  DO:
    MESSAGE "Can not open database" SKIP  
        "Please Check database and serve" VIEW-AS  ALERT-BOX ERROR.
END.
chNotesView    = chNotesDatabase:GetView("เลขตัวถัง").
/*chNavView      = chNotesView:CreateViewNav.
chDocument     = chNotesView:GetDocumentByKey(trim(winsp.chassis)).*/
chNavView      = chNotesView:CreateViewNavFromCategory(brstat.tlt.cha_no).
chViewEntry    = chNavView:GetLastDocument.
IF chViewEntry <> 0 THEN DO: 
    chDocument = chViewEntry:Document.
    IF VALID-HANDLE(chDocument) = YES THEN DO:
        RUN Proc_Getdatainsp.
        IF nv_docno <> ""  THEN DO:
            IF nv_survey <> "" THEN DO:
                IF nv_detail = "ติดปัญหา" THEN DO:
                    ASSIGN brstat.tlt.releas      = "YES" 
                        brstat.tlt.nor_noti_tlt   = nv_docno                      /*เลขที่ตรวจสภาพ */  
                        brstat.tlt.safe1          = nv_detail + " : " + nv_damage /* ความเสียหาย */
                        brstat.tlt.safe2          = nv_damdetail                  /*รายการความเสียหาย */
                        brstat.tlt.safe3          = nv_device + nv_acctotal       /*รายละเอียดอุปกรณ์เสริม */
                        brstat.tlt.filler2        = nv_surdata                    /*รายละเอียดอื่นๆ */
                        brstat.tlt.datesent       = DATE(nv_date) .
                END.
                ELSE IF nv_detail = "มีความเสียหาย"  THEN DO:
                    ASSIGN brstat.tlt.releas         = "YES"
                        brstat.tlt.nor_noti_tlt   = nv_docno                      /*เลขที่ตรวจสภาพ */  
                        brstat.tlt.safe1          = nv_detail + " : " + nv_damlist + nv_totaldam /* ความเสียหาย */
                        brstat.tlt.safe2          = nv_damdetail                  /*รายการความเสียหาย */
                        brstat.tlt.safe3          = nv_device + nv_acctotal       /*รายละเอียดอุปกรณ์เสริม */
                        brstat.tlt.filler2        = nv_surdata                    /*รายละเอียดอื่นๆ */
                        brstat.tlt.datesent       = DATE(nv_date) .
                END.
                ELSE DO:
                    ASSIGN brstat.tlt.releas      = "YES" 
                        brstat.tlt.nor_noti_tlt   = nv_docno                      /*เลขที่ตรวจสภาพ */  
                        brstat.tlt.safe1          = nv_detail                     /* ความเสียหาย */
                        brstat.tlt.safe2          = nv_damdetail                  /*รายการความเสียหาย */
                        brstat.tlt.safe3          = nv_device + nv_acctotal       /*รายละเอียดอุปกรณ์เสริม */
                        brstat.tlt.filler2        = nv_surdata                    /*รายละเอียดอื่นๆ */
                        brstat.tlt.datesent       = DATE(nv_date) .
                END.
            END.
            ELSE 
                ASSIGN brstat.tlt.releas     = "NO"
                    brstat.tlt.nor_noti_tlt  = nv_docno                   /*เลขที่ตรวจสภาพ */          
                    brstat.tlt.safe1         = nv_detail                   /* ความเสียหาย */            
                    brstat.tlt.safe2         = ""                          /*รายการความเสียหาย */       
                    brstat.tlt.safe3         = nv_device + nv_acctotal     /*รายละเอียดอุปกรณ์เสริม */  
                    brstat.tlt.filler2       = nv_surdata .                /*รายละเอียดอื่นๆ */
        END.
        ELSE 
            ASSIGN  brstat.tlt.releas   = "NO"
                brstat.tlt.nor_noti_tlt = ""     /*เลขที่ตรวจสภาพ */          
                brstat.tlt.safe1        = ""     /* ความเสียหาย */            
                brstat.tlt.safe2        = ""     /*รายการความเสียหาย */       
                brstat.tlt.safe3        = ""     /*รายละเอียดอุปกรณ์เสริม */  
                brstat.tlt.filler2      = "".    /*รายละเอียดอื่นๆ */ 
            RELEASE  OBJECT chitem          NO-ERROR.
            RELEASE  OBJECT chDocument      NO-ERROR.          
            RELEASE  OBJECT chNotesDataBase NO-ERROR.     
            RELEASE  OBJECT chNotesSession  NO-ERROR.
    END.
    ELSE IF VALID-HANDLE(chDocument) = NO  THEN DO:
        chDocument = chNotesDatabase:CreateDocument.
        chDocument:AppendItemValue( "Form", "Inspection").
        chDocument:AppendItemValue( "createdBy", chNotesSession:UserName).
        chDocument:AppendItemValue( "createdOn", nv_today + " " + nv_time).
        chDocument:AppendItemValue( "App", "0").
        chDocument:AppendItemValue( "Chk", "0").
        chDocument:AppendItemValue( "dateS", brstat.tlt.gendat).
        chDocument:AppendItemValue( "dateE", brstat.tlt.expodat).
        chDocument:AppendItemValue( "ReqType_sub", "ตรวจสภาพใหม่").
        chDocument:AppendItemValue( "BranchReq", "Business Unit 3").
        chDocument:AppendItemValue( "Tname", nv_nameT).
        chDocument:AppendItemValue( "Fname", winsp.pol_fname).    
        chDocument:AppendItemValue( "Lname", winsp.pol_lname).
        chDocument:AppendItemValue( "Phone1", winsp.pol_tel).
        chDocument:AppendItemValue( "Phone2", winsp.insptel ).
        chDocument:AppendItemValue( "dateMeet", winsp.inspdate).    
        chDocument:AppendItemValue( "placeMeet", nv_remark1).
        chDocument:AppendItemValue( "PolicyNo", ""). 
        chDocument:AppendItemValue( "agentCode",trim(fi_producer)).  
        chDocument:AppendItemValue( "Agentname",TRIM(nv_agentname)).
        chDocument:AppendItemValue( "model", nv_brand).
        chDocument:AppendItemValue( "modelCode", nv_model).
        chDocument:AppendItemValue( "carCC", trim(winsp.chassis)).
        chDocument:AppendItemValue( "Year", trim(winsp.yrmanu)).           
        chDocument:AppendItemValue( "LicenseType", trim(nv_licentyp)).
        chDocument:AppendItemValue( "PatternLi1", trim(nv_Pattern1)).
        chDocument:AppendItemValue( "PatternLi4", trim(nv_Pattern4)).
        chDocument:AppendItemValue( "LicenseNo_1", trim(nv_licen)).
        chDocument:AppendItemValue( "LicenseNo_2", trim(winsp.province)).
        chDocument:AppendItemValue( "commentMK", "ทุนประกัน " + winsp.ins_amt + " เบี้ย " + winsp.premtotal + " " + trim(nv_remark2)).
        chDocument:SAVE(TRUE,TRUE).
        RELEASE  OBJECT chitem          NO-ERROR.
        RELEASE  OBJECT chDocument      NO-ERROR.          
        RELEASE  OBJECT chNotesDataBase NO-ERROR.     
        RELEASE  OBJECT chNotesSession  NO-ERROR.
        ASSIGN  brstat.tlt.releas   = "NO"
            brstat.tlt.nor_noti_tlt = ""     /*เลขที่ตรวจสภาพ */          
            brstat.tlt.safe1        = ""     /* ความเสียหาย */            
            brstat.tlt.safe2        = ""     /*รายการความเสียหาย */       
            brstat.tlt.safe3        = ""     /*รายละเอียดอุปกรณ์เสริม */  
            brstat.tlt.filler2      = "".    /*รายละเอียดอื่นๆ */ 
    END.
END.
ELSE  DO:
    chDocument = chNotesDatabase:CreateDocument.
    chDocument:AppendItemValue( "Form", "Inspection").
    chDocument:AppendItemValue( "createdBy", chNotesSession:UserName).
    chDocument:AppendItemValue( "createdOn", nv_today + " " + nv_time).
    chDocument:AppendItemValue( "App", "0").
    chDocument:AppendItemValue( "Chk", "0").
    chDocument:AppendItemValue( "dateS", brstat.tlt.gendat).
    chDocument:AppendItemValue( "dateE", brstat.tlt.expodat).
    chDocument:AppendItemValue( "ReqType_sub", "ตรวจสภาพใหม่").
    chDocument:AppendItemValue( "BranchReq", "Business Unit 3").
    chDocument:AppendItemValue( "Tname", nv_nameT).
    chDocument:AppendItemValue( "Fname", winsp.pol_fname).    
    chDocument:AppendItemValue( "Lname", winsp.pol_lname).
    chDocument:AppendItemValue( "Phone1", winsp.pol_tel).
    chDocument:AppendItemValue( "Phone2", winsp.insptel ).
    chDocument:AppendItemValue( "dateMeet", winsp.inspdate).    
    chDocument:AppendItemValue( "placeMeet", nv_remark1).
    chDocument:AppendItemValue( "PolicyNo", ""). 
    chDocument:AppendItemValue( "agentCode",trim(fi_producer)).  
    chDocument:AppendItemValue( "Agentname",TRIM(nv_agentname)).
    chDocument:AppendItemValue( "model", nv_brand).
    chDocument:AppendItemValue( "modelCode", nv_model).
    chDocument:AppendItemValue( "carCC", trim(winsp.chassis)).
    chDocument:AppendItemValue( "Year", trim(winsp.yrmanu)).           
    chDocument:AppendItemValue( "LicenseType", trim(nv_licentyp)).
    chDocument:AppendItemValue( "PatternLi1", trim(nv_Pattern1)).
    chDocument:AppendItemValue( "PatternLi4", trim(nv_Pattern4)).
    chDocument:AppendItemValue( "LicenseNo_1", trim(nv_licen)).
    chDocument:AppendItemValue( "LicenseNo_2", trim(winsp.province)).
    chDocument:AppendItemValue( "commentMK", "ทุนประกัน " + winsp.ins_amt + " เบี้ย " + winsp.premtotal + " " + trim(nv_remark2)).
    chDocument:SAVE(TRUE,TRUE).
    RELEASE  OBJECT chitem          NO-ERROR.
    RELEASE  OBJECT chDocument      NO-ERROR.          
    RELEASE  OBJECT chNotesDataBase NO-ERROR.     
    RELEASE  OBJECT chNotesSession  NO-ERROR.
    ASSIGN  brstat.tlt.releas   = "NO"
        brstat.tlt.nor_noti_tlt = ""    /*เลขที่ตรวจสภาพ */          
        brstat.tlt.safe1        = ""    /* ความเสียหาย */            
        brstat.tlt.safe2        = ""    /*รายการความเสียหาย */       
        brstat.tlt.safe3        = ""    /*รายละเอียดอุปกรณ์เสริม */  
        brstat.tlt.filler2      = "".   /*รายละเอียดอื่นๆ */ 
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_province C-Win 
PROCEDURE proc_province :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
        IF INDEX(winsp.province,".") <> 0 THEN REPLACE(winsp.province,".","").
        IF winsp.province = "กทม"         THEN winsp.province = "กท".  
        ELSE DO:
           FIND FIRST brstat.insure USE-INDEX Insure05   WHERE   /*use-index fname */
                brstat.insure.compno = "999" AND 
                brstat.insure.FName  = TRIM(winsp.province) NO-LOCK NO-WAIT NO-ERROR.
            IF AVAIL brstat.insure THEN  ASSIGN winsp.province = brstat.Insure.LName.
        END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_replaceaddr C-Win 
PROCEDURE proc_replaceaddr :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF n_chkaddr <> "" THEN DO:
    n_chkaddr = REPLACE(n_chkaddr,"บ้านเลขที่",""). 
    n_chkaddr = REPLACE(n_chkaddr,"อาคาร -",""). 
    n_chkaddr = REPLACE(n_chkaddr,"อาคาร  -",""). 
    n_chkaddr = REPLACE(n_chkaddr,"อาคาร   -",""). 
    n_chkaddr = REPLACE(n_chkaddr,"ชั้น -",""). 
    n_chkaddr = REPLACE(n_chkaddr,"ชั้น  -","").
    n_chkaddr = REPLACE(n_chkaddr,"ชั้น   -","").
    n_chkaddr = REPLACE(n_chkaddr,"ห้อง -",""). 
    n_chkaddr = REPLACE(n_chkaddr,"ห้อง  -","").
    n_chkaddr = REPLACE(n_chkaddr,"ห้อง   -","").
    n_chkaddr = REPLACE(n_chkaddr,"-","").
    IF LENGTH(TRIM(n_chkaddr)) = 1 THEN n_chkaddr = REPLACE(n_chkaddr,"-","").

    IF n_chkaddr <> "" AND n_cntaddr = "1"  THEN n_addr1_70     = n_chkaddr.
    IF n_chkaddr <> "" AND n_cntaddr = "2"  THEN n_addr2_70     = n_chkaddr.
    IF n_chkaddr <> "" AND n_cntaddr = "3"  THEN n_addr3_70     = n_chkaddr.
    IF n_chkaddr <> "" AND n_cntaddr = "4"  THEN n_addr4_70     = n_chkaddr.
    IF n_chkaddr <> "" AND n_cntaddr = "5"  THEN n_addr5_70     = n_chkaddr.
    IF n_chkaddr <> "" AND n_cntaddr = "6"  THEN n_nsub_dist70  = n_chkaddr.
    IF n_chkaddr <> "" AND n_cntaddr = "7"  THEN n_ndirection70 = n_chkaddr.
    IF n_chkaddr <> "" AND n_cntaddr = "8"  THEN n_nprovin70    = n_chkaddr.
    IF n_chkaddr <> "" AND n_cntaddr = "9"  THEN n_zipcode70    = n_chkaddr.
    IF n_chkaddr <> "" AND n_cntaddr = "10" THEN n_addr1_72     = n_chkaddr.
    IF n_chkaddr <> "" AND n_cntaddr = "11" THEN n_addr2_72     = n_chkaddr.
    IF n_chkaddr <> "" AND n_cntaddr = "12" THEN n_addr3_72     = n_chkaddr.
    IF n_chkaddr <> "" AND n_cntaddr = "13" THEN n_addr4_72     = n_chkaddr.
    IF n_chkaddr <> "" AND n_cntaddr = "14" THEN n_addr5_72     = n_chkaddr.
    IF n_chkaddr <> "" AND n_cntaddr = "15" THEN n_nsub_dist72  = n_chkaddr.
    IF n_chkaddr <> "" AND n_cntaddr = "16" THEN n_ndirection72 = n_chkaddr.
    IF n_chkaddr <> "" AND n_cntaddr = "17" THEN n_nprovin72    = n_chkaddr.
    IF n_chkaddr <> "" AND n_cntaddr = "18" THEN n_zipcode72    = n_chkaddr.
    IF n_chkaddr <> "" AND n_cntaddr = "19" THEN n_payaddr1     = n_chkaddr.
    IF n_chkaddr <> "" AND n_cntaddr = "20" THEN n_payaddr2     = n_chkaddr.
    IF n_chkaddr <> "" AND n_cntaddr = "21" THEN n_payaddr3     = n_chkaddr.
    IF n_chkaddr <> "" AND n_cntaddr = "22" THEN n_payaddr4     = n_chkaddr.
    IF n_chkaddr <> "" AND n_cntaddr = "23" THEN n_payaddr5     = n_chkaddr.
    IF n_chkaddr <> "" AND n_cntaddr = "24" THEN n_payaddr6     = n_chkaddr.
    IF n_chkaddr <> "" AND n_cntaddr = "25" THEN n_payaddr7     = n_chkaddr.
    IF n_chkaddr <> "" AND n_cntaddr = "26" THEN n_payaddr8     = n_chkaddr.
    IF n_chkaddr <> "" AND n_cntaddr = "27" THEN n_payaddr9     = n_chkaddr.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_Updatatlt C-Win 
PROCEDURE Proc_Updatatlt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    ASSIGN   brstat.tlt.entdat        = TODAY                           /* date  99/99/9999  */
             brstat.tlt.enttim        = STRING(TIME,"HH:MM:SS")         /* char  x(8)        */
             brstat.tlt.trndat        = fi_loaddat
             brstat.tlt.genusr        = "SCBPT"        
             brstat.tlt.usrid         = USERID(LDBNAME(1))          
             brstat.tlt.flag          = IF index(wdetail2.covtyp,"CMI") <> 0 THEN "V72" ELSE "V70"        
             brstat.tlt.policy        = ""        
             brstat.tlt.releas        = "NO"        
             brstat.tlt.subins        = TRIM(fi_producer)        
             brstat.tlt.recac         = TRIM(fi_agent)
             brstat.tlt.lotno         = "InsCode:" + TRIM(wdetail.cmr_code)  + " " +   /*รหัสบริษัทประกันภัย */                   
                                        "InsName:" + TRIM(wdetail.comp_code) + " " +   /*ชื่อบริษัทประกันภัย */                   
                                        "CamCode:" + TRIM(wdetail.campcode)  + " " +   /*รหัสแคมเปญ    */                   
                                        "CamName:" + TRIM(wdetail.campname)            /*ชื่อแคมเปญ    */                   
             brstat.tlt.usrsent       = "ProCode:" + TRIM(wdetail.procode ) + " " +    /*รหัสผลิตภัณฑ์ */                   
                                        "ProName:" + TRIM(wdetail.proname ) + " " +    /*ชื่อผลิตภัณฑ์ */                   
                                        "PackNam:" + TRIM(wdetail.packname) + " " +    /*ชื่อแพคเกจ    */                   
                                        "PackCod:" + TRIM(wdetail.packcode)            /*รหัสแพคเกจ    */                   
             brstat.tlt.imp           = TRIM(wdetail.instype)                          /*ประเภท        */                   
             brstat.tlt.ins_name      = "NameTha:" + TRIM(wdetail.pol_title) + " "     /*คำนำหน้าชื่อ  */                   
                                                   + TRIM(wdetail.pol_fname) + " "     /*ชื่อผู้เอาประกัน    */                   
                                                   + TRIM(wdetail.pol_lname) + " " +   /*นามสกุลผู้เอาประกัน */                   
                                        "NameEng:" + TRIM(wdetail.pol_title_eng) + " " /*คำนำหน้าชื่อ  ภาษาอังกฤษ  */             
                                                   + TRIM(wdetail.pol_fname_eng) + " " /*ชื่อภาษา อังกฤษ           */             
                                                   + TRIM(wdetail.pol_lname_eng)       /*นามสกุลภาษา อังกฤษ        */             
             brstat.tlt.rec_addr5     = "ICNo:"  + TRIM(wdetail.icno)  + " " +         /*เลขที่บัตรประชาชน/เลขที่ผูเสียภาษี   */  
                                        "Sex:"   + TRIM(wdetail.sex)   + " " +         /*เพศ                          */          
                                        "Birth:" + TRIM(wdetail.bdate) + " " +         /*วันเดือนปีเกิด ( DD/MM/YYYY) */          
                                        "Occup:" + TRIM(wdetail.occup)                 /*อาชีพ                        */          
             brstat.tlt.ins_addr5     = "Phone:" + TRIM(wdetail.tel) + " " + TRIM(wdetail.phone) + " "          /*เบอร์โทรบ้าน ที่ทำงาน มือถือ*/          
                                                 + TRIM(wdetail.teloffic) + " " + TRIM(wdetail.telext) + " "      
                                                 + TRIM(wdetail.moblie) + " " + TRIM(wdetail.mobliech) + " " +    
                                        "Email:" + TRIM(wdetail.mail) + " " +                                 /*email   */                              
                                        "Linid:" + TRIM(wdetail.lineid)                                       /*Line_ID */    
             brstat.tlt.ins_addr1     = TRIM(wdetail.addr1_70) + " " + TRIM(wdetail.addr2_70)  + " " +        /*ที่อยูลูกค้า*/    
                                        TRIM(wdetail.addr3_70) + " " + TRIM(wdetail.addr4_70)  + " " +        
                                        TRIM(wdetail.addr5_70)                                                
             brstat.tlt.ins_addr2     = TRIM(wdetail.nsub_dist70) + " " + TRIM(wdetail.ndirection70) + " " +  
                                        TRIM(wdetail.nprovin70) + " " + TRIM(wdetail.zipcode70)               
             brstat.tlt.ins_addr3     = TRIM(wdetail.addr1_72) + " " + TRIM(wdetail.addr2_72) + " " +         /*ที่อยูจัดส่ง*/        
                                        TRIM(wdetail.addr3_72) + " " + TRIM(wdetail.addr4_72) + " " +         
                                        TRIM(wdetail.addr5_72)                                                
             brstat.tlt.ins_addr4     = TRIM(wdetail.nsub_dist72) + " " + TRIM(wdetail.ndirection72) + " " +  
                                        TRIM(wdetail.nprovin72) + " " + TRIM(wdetail.zipcode72)               
             brstat.tlt.exp           = "PayTyp:" + TRIM(wdetail.paytype) + " " +                             /*ประเภท ผู้จ่ายเงิน*/
                                        "Branch:" + TRIM(wdetail.branch)                                      /*สาขา*/
             brstat.tlt.rec_name      = TRIM(wdetail.paytitle) + " " + TRIM(wdetail.payname) + " " + TRIM(wdetail.paylname) /* ชื่อ - สกุล ผู้จ่ายเงิน*/
             brstat.tlt.comp_sub      = TRIM(wdetail.payicno)                                                               /* เลขบัตร ปปช. ผู้จ่ายเงิน*/
             brstat.tlt.rec_addr1     = TRIM(wdetail.payaddr1) + " " + TRIM(wdetail.payaddr2) + " " +        /*ที่อยู่ออกใบเสร็จ */
                                        TRIM(wdetail.payaddr3) + " " + TRIM(wdetail.payaddr4) + " " + 
                                        TRIM(wdetail.payaddr5)
             brstat.tlt.rec_addr2     = TRIM(wdetail.payaddr6) + " " + TRIM(wdetail.payaddr7) + " " +
                                        TRIM(wdetail.payaddr8) + " " + TRIM(wdetail.payaddr9)
             brstat.tlt.safe1         = TRIM(wdetail.ben_title) + " " + TRIM(wdetail.ben_name) + " " + TRIM(wdetail.ben_lname) /*ชื่อ - สกุล ผู้รับผลประโยชน์*/
             brstat.tlt.safe2         = "PaymentMD:"   + TRIM(wdetail.pmentcode)  + " " + /*รหัสประเภทการชำระเบี้ยประกัน*/  
                                        "PaymentMDTy:" + TRIM(wdetail.pmenttyp)   + " " + /*ประเภทการชำระเบี้ยประกัน    */  
                                        "PaymentTyCd:" + TRIM(wdetail.pmentcode1) + " " + /*รหัสช่องทางที่ชำระเบี้ย*/  
                                        "Paymentty:"   + TRIM(wdetail.pmentcode2)         /*ช่องทางที่ชำระค่าเบี้ย */  
             brstat.tlt.safe3         = TRIM(wdetail.pmentbank)                           /*ธนาคารที่ชำระเบี้ย*/  
             brstat.tlt.rec_addr4     = "Paydat:" + TRIM(wdetail.pmentdate) + " " +       /*วันที่ชำระค่าเบี้ย*/  
                                        "PaySts:" + TRIM(wdetail.pmentsts)  + " " +       /*สถานะการชำระเบี้ย */  
                                        "Paid:"   + TRIM(wdetail2.paysts)                 /*สถานะการจ่ายเงิน*/
             brstat.tlt.datesent      = IF wdetail2.not_date = "" THEN ? ELSE date(wdetail2.not_date)                           /*วันที่ขาย       */
             brstat.tlt.dat_ins_noti  = IF wdetail2.paydate  = "" THEN ? ELSE date(wdetail2.paydate)                            /*วันที่รับชำระเงิน */  
           /*brstat.tlt.endcnt        = IF wdetail.driver = "ไม่ระบุผู้ขับขี่" THEN 0 ELSE INT(wdetail.driver)  /*การระบุชื่อผู้ขับ */  --- Comment By Tontawan S. A66-0006 --*/  
             brstat.tlt.endcnt        = INT(wdetail.driver)    /*การระบุชื่อผู้ขับ */ /*------ Add By Tontawan S. A66-0006 --*/                                                                  
             brstat.tlt.dri_name1     = "Drinam1:" + TRIM(wdetail.drivetitle1) + " " +    /*คำนำหน้าชื่อ ผู้ขับขี่ 1  */ 
                                                     TRIM(wdetail.drivename1)  + " " +    /*ชื่อผู้ขับขี่ 1 */    
                                                     TRIM(wdetail.drivelname1) + " " +    /*นามสกุล ผู้ขับขี่ 1   */  
                                        "DriId1:"  + TRIM(wdetail.driveno1)               /*เลขที่บัตรผู้ขับขี่ 1 */  
             brstat.tlt.dri_no1       = "DriOcc1:" + TRIM(wdetail.occupdriv1) + " " +     /*Driver1Occupation  */  
                                        "DriSex1:" + TRIM(wdetail.sexdriv1)   + " " +     /*เพศ ผู้ขับขี่ 1 */ 
                                        "DriBir1:" + TRIM(wdetail.bdatedriv1)             /*วันเดือนปีเกิดผู้ขับขี่ 1 */ 
             brstat.tlt.dri_name2     = "Drinam2:" + TRIM(wdetail.drivetitle2) + " " +    /*คำนำหน้าชื่อ ผู้ขับขี่ 2  */ 
                                                     TRIM(wdetail.drivename2)  + " " +    /*ชื่อผู้ขับขี่ 2    */ 
                                                     TRIM(wdetail.drivelname2) + " " +    /*นามสกุล ผู้ขับขี่ 2*/
                                        "DriId2:"  + TRIM(wdetail.driveno2)               /*เลขที่บัตรผู้ขับขี่2 */ 
             brstat.tlt.dri_no2       = "DriOcc2:" + TRIM(wdetail.occupdriv2) + " " +     /*Driver2Occupation  */
                                        "DriSex2:" + TRIM(wdetail.sexdriv2)   + " " +     /*เพศ ผู้ขับขี่ 2    */
                                        "DriBir2:" + TRIM(wdetail.bdatedriv2).             /*วันเดือนปีเกิดผู้ขับขี่ 2 */
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_Updatatlt2 C-Win 
PROCEDURE Proc_Updatatlt2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    ASSIGN 
           brstat.tlt.brand         = TRIM(wdetail2.brand)     /*ชื่อรถยนต์         */                                    
           brstat.tlt.model         = TRIM(wdetail2.Model)     /*ชื่อรุ่นรถยนต์     */                                    
           brstat.tlt.expousr       = TRIM(wdetail2.body)      /*แบบตัวถัง          */                                    
           brstat.tlt.lince1        = TRIM(wdetail2.licence)   /*ทะเบียนรถ          */                                    
           brstat.tlt.lince2        = TRIM(wdetail2.province)  /*จังหวัดที่จดทะเบียน*/                                    
           brstat.tlt.cha_no        = CAPS(TRIM(wdetail2.chassis))   /*เลขตัวถัง          */                                    
           brstat.tlt.eng_no        = CAPS(TRIM(wdetail2.engine))    /*เลขเครื่องยนต์     */                                    
           brstat.tlt.gentim        = TRIM(wdetail2.yrmanu)    /*ปีจดทะเบียนรถ      */                                    
           brstat.tlt.sentcnt       = INT(wdetail2.seatenew)   /*จำนวนที่นั่ง       */                                    
           brstat.tlt.rencnt        = INT(wdetail2.power)      /*ขนาดเครื่องยนต์    */                                    
           brstat.tlt.cc_weight     = INT(wdetail2.weight)     /*น้ำหนัก            */                                    
           brstat.tlt.expotim       = TRIM(wdetail2.class)     /*รหัสการใช้รถยนต์   */                                    
           brstat.tlt.old_cha       = "GarCd:" + TRIM(wdetail2.garage_cd) + " " + /*รหัสการซ่อม        */                 
                                      "GarTy:" + TRIM(wdetail2.garage)            /*ประเภทการซ่อม      */                 
           brstat.tlt.colorcod      = TRIM(wdetail2.colorcode) /*สีรถยนต์  */                                             
           brstat.tlt.rec_addr3     = "CovCod:" + TRIM(wdetail2.covcod)  + " " +        /*ประเภทของประกันภัย        */    
                                      "CovTcd:" + TRIM(wdetail2.covtyp)  + " " +        /*รหัสประเภทของประกันภัย    */    
                                      "CovTyp:" + TRIM(wdetail2.covtyp1) + " " +        /*ประเภทของความคุ้มครอง     */    
                                      "CovTy1:" + TRIM(wdetail2.covtyp2) + " " +        /*ประเภทย่อยของความคุ้มครอง */    
                                      "CovTy2:" + TRIM(wdetail2.covtyp3)                /*รายละเอียดความคุ้มครอง    */  

           brstat.tlt.gendat        = date(wdetail2.comdat)                             /*วันเริ่มความคุ้มครอง      */    
           brstat.tlt.expodat       = DATE(wdetail2.expdat)                             /*วันที่สิ้นสุดความคุ้มครอง */   

           brstat.tlt.nor_coamt     = DECI(wdetail2.ins_amt)                            /*ทุนประกัน                 */    
           brstat.tlt.nor_grprm     = DECI(wdetail2.prem1)                              /*เบี้ยสุทธิก่อนหักส่วนลด   */    
           brstat.tlt.comp_grprm    = DECI(wdetail2.gross_prm)                          /*เบี้ยสุทธิหลังหักส่วนลด   */    
           brstat.tlt.stat          = "Stm:" + STRING(deci(wdetail2.stamp)) + " " +     /*จำนวนอากรสแตมป์       */    
                                      "Vat:" + STRING(DECI(wdetail2.vat))               /*จำนวนภาษี SBT/Vat     */    
           brstat.tlt.comp_coamt    = deci(wdetail2.premtotal)                          /*เบี้ยรวม ภาษี-อากร    */    
           brstat.tlt.endno         = IF wdetail2.deduct = "no" THEN "0" ELSE string(DECI(wdetail2.deduct))                     /*ค่าความเสียหายส่วนแรก */    
           brstat.tlt.comp_sck      = "fetP:" + STRING(DECI(wdetail2.fleetper)) + " " + /*% ส่วนลดกลุ่ม         */    
                                      "felA:" + STRING(DECI(wdetail2.fleet))            /*จำนวนส่วนลดกลุ่ม      */    
           brstat.tlt.comp_noti_tlt = "NcbP:" + string(DECI(wdetail2.ncbper)) + " " +   /*% ส่วนลดประวัติดี     */    
                                      "NcbA:" + string(DECI(wdetail2.ncb))              /*จำนวนส่วนลดประวัติดี  */    
           brstat.tlt.comp_usr_tlt  = "DriP:" + string(DECI(wdetail2.drivper)) + " " +  /*% ส่วนลดกรณีผู้ขับขี่ */    
                                      "DriA:" + string(DECI(wdetail2.drivdis))          /*จำนวนส่วนลดกรณีผู้ขับขี่  */    
           brstat.tlt.comp_noti_ins = "OthP:" + string(DECI(wdetail2.othper)) + " " +   /*%สวนลดอื่นๆ           */    
                                      "OthA:" + string(DECI(wdetail2.oth))              /*จำนวนส่วนลดอื่นๆ      */    
           brstat.tlt.comp_usr_ins  = "CTVP:" + string(DECI(wdetail2.cctvper)) + " " +  /*%สวนลดกล้อง           */    
                                      "CTVA:" + string(DECI(wdetail2.cctv))             /*จำนวนส่วนลดกล้อง      */    
           brstat.tlt.comp_pol      = "SurP:" + string(DECI(wdetail2.Surcharper)) + " " + /*%ส่วนลดเพิ่ม        */   
                                      "SurA:" + string(DECI(wdetail2.Surchar))    + " " + /*จำนวนส่วนลดเพิ่ม    */    
                                      "SurD:" + TRIM(wdetail2.Surchardetail)              /*รายละเอียดส่วนเพิ่ม */    
           brstat.tlt.filler1       = "Acc1:" + TRIM(wdetail2.acc1)       + " " +         /*รหัส อุปกรณ์1  */   
                                      "Acd1:" + TRIM(wdetail2.accdetail1) + " " +         /*รายละเอียด1    */    
                                      "Acp1:" + STRING(DECI(wdetail2.accprice1))  + " " + /*ราคาอุปกรณ์1   */    
                                      "Acc2:" + TRIM(wdetail2.acc2)       + " " +         /*รหัส อุปกรณ์2  */    
                                      "Acd2:" + TRIM(wdetail2.accdetail2) + " " +         /*รายละเอียด2    */    
                                      "Acp2:" + STRING(DECI(wdetail2.accprice2))  + " " + /*ราคาอุปกรณ์2   */    
                                      "Acc3:" + TRIM(wdetail2.acc3)       + " " +         /*รหัส อุปกรณ์3  */    
                                      "Acd3:" + TRIM(wdetail2.accdetail3) + " " +         /*รายละเอียด3    */    
                                      "Acp3:" + STRING(DECI(wdetail2.accprice3))  + " " + /*ราคาอุปกรณ์3   */    
                                      "Acc4:" + TRIM(wdetail2.acc4)       + " " +         /*รหัส อุปกรณ์4  */    
                                      "Acd4:" + TRIM(wdetail2.accdetail4) + " " +         /*รายละเอียด 4   */    
                                      "Acp4:" + STRING(DECI(wdetail2.accprice4))  + " " + /*ราคาอุปกรณ์4   */    
                                      "Acc5:" + TRIM(wdetail2.acc5)       + " " +         /*รหัส อุปกรณ์5  */    
                                      "Acd5:" + TRIM(wdetail2.accdetail5) + " " +         /*รายละเอียด 5   */    
                                      "Acp5:" + STRING(DECI(wdetail2.accprice5))         /*ราคาอุปกรณ์5     */    
           brstat.tlt.nor_effdat    = if wdetail2.inspdate      = "" then ? else date(wdetail2.inspdate)                           /*วันที่ตรวจสภาพรถ */    
           brstat.tlt.comp_effdat   = if wdetail2.inspdate_app  = "" then ? else date(wdetail2.inspdate_app)                       /*วันที่อนุมัติตรวจสภาพรถ   */    
           brstat.tlt.nor_noti_tlt  = "InspSt:" + TRIM(wdetail2.inspsts) + " " +        /*ผลการตรวจสภาพรถ           */    
                                      "InspDe:" + TRIM(wdetail2.inspdetail)             /*รายละเอียดการตรวจสภาพรถ   */    
           brstat.tlt.old_eng       = "BLice:"  + TRIM(wdetail2.licenBroker) + " " +    /*เลขที่ใบอนุญาตนายหน้า   */      
                                      "Bname:"  + TRIM(wdetail2.brokname) + " " +       /*ชื่อบริษัทนายหน้า       */      
                                      "Bcode:"  + TRIM(wdetail2.brokcode)               /*รหัสโบรคเกอร์           */      
           brstat.tlt.filler2       = "Detai1:" + TRIM(wdetail2.lang) + " " +           /*ภาษาในการออกกรมธรรม์    */      
                                      "Detai2:" + TRIM(wdetail2.deli) + " " +           /*ช่องทางการจัดส่ง        */      
                                      "Detai3:" + TRIM(wdetail2.delidetail) + " " +     /*หมายเหตุการจัดส่ง       */      
                                      "Detai4:" + TRIM(wdetail2.gift) + " " +           /*ของแถม                  */      
                                      "Remark:" + TRIM(wdetail2.remark)                 /*หมายเหตุ                */      
           brstat.tlt.nor_noti_ins  = TRIM(wdetail2.cedcode)                            /*เลขที่อ้างอิง ความคุ้มครอง*/    
           brstat.tlt.nor_usr_ins   = TRIM(wdetail2.inscode)                            /*Cust.Code No              */ 

           /*-- Add by Tontawan S. A68-0059 27/03/2025 --*/
           //Driver 3
           brstat.tlt.dri_title3    = TRIM(wdetail.drv3_salutation_M) /* คำนำหน้าชื่อ ผู้ขับขี่ 3    */ 
           brstat.tlt.dri_fname3    = TRIM(wdetail.drv3_fname)        /* ชื่อผู้ขับขี่ 3             */    
           brstat.tlt.dri_lname3    = TRIM(wdetail.drv3_lname)        /* นามสกุล ผู้ขับขี่ 3         */  
           brstat.tlt.dri_ic3       = TRIM(wdetail.drv3_nid)          /* เลขที่บัตรผู้ขับขี่ 3       */  
           brstat.tlt.dir_occ3      = TRIM(wdetail.drv3_occupation)   /* Driver3 Occupation          */  
           brstat.tlt.dri_gender3   = TRIM(wdetail.drv3_gender)       /* เพศ ผู้ขับขี่ 3             */ 
           brstat.tlt.dri_birth3    = TRIM(wdetail.drv3_birthdate)    /* วันเดือนปีเกิดผู้ขับขี่ 3   */ 
           //Driver 4
           brstat.tlt.dri_title4    = TRIM(wdetail.drv4_salutation_M) /* คำนำหน้าชื่อ ผู้ขับขี่ 4    */ 
           brstat.tlt.dri_fname4    = TRIM(wdetail.drv4_fname)        /* ชื่อผู้ขับขี่ 4             */    
           brstat.tlt.dri_lname4    = TRIM(wdetail.drv4_lname)        /* นามสกุล ผู้ขับขี่ 4         */  
           brstat.tlt.dri_ic4       = TRIM(wdetail.drv4_nid)          /* เลขที่บัตรผู้ขับขี่ 4       */  
           brstat.tlt.dri_occ4      = TRIM(wdetail.drv4_occupation)   /* Driver4 Occupation          */  
           brstat.tlt.dri_gender4   = TRIM(wdetail.drv4_gender)       /* เพศ ผู้ขับขี่ 4             */ 
           brstat.tlt.dri_birth4    = TRIM(wdetail.drv4_birthdate)    /* วันเดือนปีเกิดผู้ขับขี่ 4   */
           //Driver 5 
           brstat.tlt.dri_title5    = TRIM(wdetail.drv5_salutation_M) /* คำนำหน้าชื่อ ผู้ขับขี่ 5    */ 
           brstat.tlt.dri_fname5    = TRIM(wdetail.drv5_fname)        /* ชื่อผู้ขับขี่ 5             */    
           brstat.tlt.dri_lname5    = TRIM(wdetail.drv5_lname)        /* นามสกุล ผู้ขับขี่ 5         */  
           brstat.tlt.dri_ic5       = TRIM(wdetail.drv5_nid)          /* เลขที่บัตรผู้ขับขี่ 5       */  
           brstat.tlt.dri_occ5      = TRIM(wdetail.drv5_occupation)   /* Driver5 Occupation          */  
           brstat.tlt.dri_gender5   = TRIM(wdetail.drv5_gender)       /* เพศ ผู้ขับขี่ 5             */ 
           brstat.tlt.dri_birth5    = TRIM(wdetail.drv5_birthdate)    /* วันเดือนปีเกิดผู้ขับขี่ 5   */

           brstat.tlt.dri_lic1      = TRIM(wdetail.drv1_dlicense)     /* รหัสผู้ขับขี่ 1             */ 
           brstat.tlt.dri_lic2      = TRIM(wdetail.drv2_dlicense)     /* รหัสผู้ขับขี่ 2             */
           brstat.tlt.dri_lic3      = TRIM(wdetail.drv3_dlicense)     /* รหัสผู้ขับขี่ 3             */
           brstat.tlt.dri_lic4      = TRIM(wdetail.drv4_dlicense)     /* รหัสผู้ขับขี่ 4             */
           brstat.tlt.dri_lic5      = TRIM(wdetail.drv5_dlicense)     /* รหัสผู้ขับขี่ 5             */
           brstat.tlt.battno        = TRIM(wdetail.baty_snumber)      /* Battery : Serial Number     */
           brstat.tlt.battyr        = TRIM(wdetail.batydate)          /* Battery : Year              */
           brstat.tlt.battsi        = DECI(STRING(wdetail.baty_rsi))            /* Battery : Replacement SI    */
           brstat.tlt.battprem      = DECI(STRING(wdetail.baty_npremium))       /* Battery : Net Premium       */
           brstat.tlt.ndeci1        = DECI(STRING(wdetail.baty_gpremium))       /* Battery : Gross_Premium     */ //-- ไม่ชัวว่าใช้ Field 
           brstat.tlt.chargno       = TRIM(wdetail.wcharge_snumber)   /* Wall Charge : Serial_Number */
           brstat.tlt.chargsi       = DECI(STRING(wdetail.wcharge_si))       /* Wall Charge : SI            */
           brstat.tlt.chargprem     = DECI(STRING(wdetail.wcharge_gpremium)) /* Wall Charge : Net Premium   */
           brstat.tlt.ndeci2        = DECI(STRING(wdetail.wcharge_npremium)) /* Wall Charge : Gross Premium */ //-- ไม่ชัวว่าใช้ Field
           .
           /*-- End by Tontawan S. A68-0059 27/03/2025 --*/
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

