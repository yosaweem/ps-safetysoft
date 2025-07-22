/* ประกาศตัวแปร -*/
/*programid   : wgwimscb.i                                                      */ 
/*programname : Import file Hold to brstat.tlt                                  */ 
/* Copyright  : Safety Insurance Public Company Limited 			            */ 
/*			    บริษัท ประกันคุ้มภัย จำกัด (มหาชน)				                */ 
/*create by   : Ranu i. A60-0448  date . 20/10/2017                             
               โปรแกรมให้สามารถนำเข้าไฟล์แจ้งงาน และไฟล์ตรวจสภาพเก็บลง TLT       */ 
/*modify By  : Ranu I. a63-0448 เพิ่มการเก็บค่าข้อมูลจากไฟล์แจ้งบัตรเครดิต       */
/*Modify by   : Ranu I. A67-0162 เพิ่มการเก็บข้อมูลรถไฟฟ้า    */
/*-------------------------------------------------------------------------------*/
DEFINE NEW SHARED TEMP-TABLE wdetail2 NO-UNDO
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
    FIELD policy        AS CHAR FORMAT "x(13)"     INIT ""  /* policy */
    FIELD prvpol        AS CHAR FORMAT "x(13)"     INIT ""  /* old poliy */
    FIELD pass          AS CHAR FORMAT "x(2)"      INIT ""  /* update */
    field inspname      as char format "x(75)"     init "" 
    field inspphone     as char format "x(20)"     init "" 
    field insploca      as char format "x(250)"    init "" 
    FIELD agname        as char format "x(25)"     init ""
    FIELD ftype         AS CHAR FORMAT "x(2)" INIT ""
    /* Add by : A67-0162 */
    field tyeeng         as char format "x(20)"   init ""
    field typMC          as char format "x(20)"   init ""
    field watt           as CHAR FORMAT "x(4)"    init ""
    field evmotor1       as char format "x(45)"   init ""
    field evmotor2       as char format "x(45)"   init ""
    field evmotor3       as char format "x(45)"   init ""
    field evmotor4       as char format "x(45)"   init ""
    field evmotor5       as char format "x(45)"   init ""
    field evmotor6       as char format "x(45)"   init ""
    field evmotor7       as char format "x(45)"   init ""
    field evmotor8       as char format "x(45)"   init ""
    field evmotor9       as char format "x(45)"   init ""
    field evmotor10      as char format "x(45)"   init ""
    field evmotor11      as char format "x(45)"   init ""
    field evmotor12      as char format "x(45)"   init ""
    field evmotor13      as char format "x(45)"   init ""
    field evmotor14      as char format "x(45)"   init ""
    field evmotor15      as char format "x(45)"   init ""
    field carprice       as CHAR FORMAT "x(15)"   init ""
    field drivlicen1     as CHAR FORMAT "x(20)"   init ""
    field drivcardexp1   as CHAR FORMAT "x(15)"   init ""
    field drivcartyp1    as char format "x(20)"   init ""
    field drivlicen2     as char format "x(20)"   init ""
    field drivcardexp2   as CHAR FORMAT "x(15)"   init ""
    field drivcartyp2    as char format "x(20)"   init ""
    field drivetitle3    as char format "x(10)"   init ""
    field drivename3     as char format "x(50)"   init ""
    field drivelname3    as char format "x(50)"   init ""
    field bdatedriv3     as CHAR FORMAT "x(15)"   init ""
    field sexdriv3       as char format "x(1)"    init ""
    field drivcartyp3    as char format "x(20)"   init ""
    field driveno3       as char format "x(20)"   init ""
    field drivlicen3     as char format "x(20)"   init ""
    field drivcardexp3   as CHAR FORMAT "x(15)"   init ""
    field occupdriv3     as char format "x(255)"  init ""
    field drivetitle4    as char format "x(10)"   init ""
    field drivename4     as char format "x(50)"   init ""
    field drivelname4    as char format "x(50)"   init ""
    field bdatedriv4     as CHAR FORMAT "x(15)"   init ""
    field sexdriv4       as char format "X(1)"    init ""
    field drivcartyp4    as char format "X(20)"   init ""
    field driveno4       as char format "X(20)"   init ""
    field drivlicen4     as char format "X(20)"   init ""
    field drivcardexp4   as CHAR FORMAT "x(15)"   init ""
    field occupdriv4     as char format "x(255)"  init ""
    field drivetitle5    as char format "x(10)"   init ""
    field drivename5     as char format "x(50)"   init ""
    field drivelname5    as char format "x(50)"   init ""
    field bdatedriv5     as CHAR FORMAT "x(15)"   init ""
    field sexdriv5       as char format "X(1)"    init ""
    field drivcartyp5    as char format "X(20)"   init ""
    field driveno5       as char format "X(20)"   init ""
    field drivlicen5     as char format "X(20)"   init ""
    field drivcardexp5   as CHAR FORMAT "x(15)"   init ""
    field occupdriv5     as char format "x(255)"  init ""
    field battflag       as char format "x(1)"    init ""
    field battyr         as CHAR FORMAT "x(10)"   init ""
    field battdate       as CHAR FORMAT "x(15)"   init ""
    field battprice      as CHAR FORMAT "x(20)"   init ""
    field battno         as CHAR FORMAT "x(50)"   init ""
    field battsi         as CHAR FORMAT "x(20)"   init ""
    field chagreno       as char format "x(50)"   init ""
    field chagrebrand    as char format "x(50)"   init "".
   /* end : A67-0162 */

DEFINE NEW SHARED TEMP-TABLE winsp NO-UNDO
    field n_no        as  char  format "X(10)"    
    field inscode     as  char  format "X(50)"    
    field campcode    as  char  format "X(50)"    
    field campname    as  char  format "X(50)"    
    field procode     as  char  format "X(50)"    
    field proname     as  char  format "X(50)"    
    field packcode    as  char  format "X(50)"    
    field packname    as  char  format "X(50)"    
    field Refno       as  char  format "X(50)"
    FIELD custcode    AS  CHAR  FORMAT "x(20)"
    field pol_fname   as  char  format "X(50)"    
    field pol_lname   as  char  format "X(50)"    
    field pol_tel     as  char  format "X(20)"
    field tmp1        as  char  format "X(50)"    
    field tmp2        as  char  format "X(50)"  
    field instype     as  char  format "X(50)"    
    field inspdate    as  CHAR  FORMAT "x(10)"                    
    field insptime    as  CHAR  FORMAT "x(10)"                   
    field inspcont    as  char  format "X(50)"    
    field insptel     as  char  format "X(20)"    
    field lineid      as  char  format "X(50)"    
    field mail        as  char  format "X(50)"    
    field inspaddr    as  CHAR  format "X(500)"   
    field brand       as  char  format "X(20)"    
    field Model       as  char  format "X(50)"    
    field class       as  char  format "X(5)"     
    field seatenew    as  char  format "x(10)"              
    field power       as  char  format "x(10)"              
    field weight      as  char  format "x(10)"              
    field province    as  char  format "x(100)"   
    field yrmanu      as  char  format "x(4)"     
    field licence     as  char  format "x(10)"    
    field chassis     as  char  format "x(50)"    
    field engine      as  char  format "x(50)"    
    field comdat      as  char  format "x(10)"                    
    field expdat      as  char  format "x(10)"                   
    field ins_amt     as  CHAR format "x(18)"     
    field premtotal   as  char format "x(10)"     
    field acc1        as  char format "x(50)"     
    field accdetail1  as  char format "x(100)"    
    field accprice1   as  CHAR format "x(18)"     
    field acc2        as  char format "x(50)"     
    field accdetail2  as  char format "x(100)"    
    field accprice2   as  CHAR format "x(18)"     
    field acc3        as  char format "x(50)"     
    field accdetail3  as  char format "x(100)"    
    field accprice3   as  CHAR format "x(18)"     
    field acc4        as  char format "x(50)"     
    field accdetail4  as  char format "x(100)"    
    field accprice4   as  CHAR format "x(18)"     
    field acc5        as  char format "x(50)"     
    field accdetail5  as  char format "x(100)"    
    field accprice5   as  CHAR format "x(18)"  
    FIELD pass        AS  CHAR FORMAT "x(3)" .

DEFINE NEW SHARED TEMP-TABLE wpaid NO-UNDO
    field company_cod      as char format "x(50)"  /*รหัสบริษัทประกันภัย        */   
    field company_nam      as char format "x(50)"  /*ชื่อบริษัทประกันภัย        */   
    field RefNo            as char format "x(50)"  /*หมายเลขอ้างอิง X-Reference */ 
    field Pay_no           as char format "x(50)"  /*หมายเลขการชำระ             */
    FIELD Trntyp           AS CHAR FORMAT "x(10)" /* Trans type */
    field Pay_mode         as char format "x(50)"  /*ประเภทการชำระ              */   
    field Pay_type         as char format "x(50)"  /*วิธีการชำระ                */   
    field card_no          as char format "x(50)"  /*หมายเลขบัตรเครดิต          */   
    field card_type        as char format "x(50)"  /*ประเภทบัตรเครดิต           */   
    field card_exp         as char format "x(50)"  /*วันหมดอายุหน้าบัตร         */   
    field card_Hname       as char format "x(50)"  /*ชื่อเจ้าของบัตร            */   
    field Card_bank        as char format "x(50)"  /*ธนาคารเจ้าของบัตร          */   
    field Pay_due_date     as char format "x(15)"  /*วันครบกำหนดชำระ            */   
    field Due_Amount       as char format "x(20)"  /*ยอดชำระ                    */   
    field promo_code       as char format "x(50)"  /*รหัสส่งเสริมการขาย         */   
    field product_code     as char format "x(50)"  /*รหัสสินค้า                 */
    FIELD remark           AS CHAR FORMAT "x(20)"  /* หมายเหตุ */
    FIELD holdername       AS CHAR FORMAT "X(100)"   /*A63-0448*/
    FIELD CustNo           AS CHAR FORMAT "x(15)"  /*A63-0448*/
    FIELD PayDate          AS CHAR FORMAT "X(15)"   /*A63-0448*/
    FIELD PayAmount        AS CHAR FORMAT "X(15)"   /*A63-0448*/
    FIELD ApproveNo        AS CHAR FORMAT "X(15)"   /*A63-0448*/
    FIELD nResult          AS CHAR FORMAT "X(150)"   /*A63-0448*/
    FIELD PolicyNo         AS CHAR FORMAT "X(12)" . /*A63-0448*/

DEFINE NEW SHARED TEMP-TABLE wcancel NO-UNDO
    field recno            as char format "x(3)"    init "" 
    field Company          as char format "x(10)"   init "" 
    field Product          as char format "x(30)"   init "" 
    field Branch           as char format "x(3)"    init "" 
    field contract         as char format "x(20)"   init "" 
    field comname          as char format "x(10)"   init "" 
    field licence          as char format "x(30)"   init "" 
    field chassis          as char format "x(20)"   init "" 
    field notify           as char format "x(20)"   init "" 
    field name             as char format "x(150)"  init "" 
    field comdate          as char format "x(20)"   init "" 
    field sale             as char format "x(10)"   init "" 
    field remark           as char format "x(255)"  init ""
    field comment          as char format "x(100)"  init ""  .

DEF VAR n_cmr_code      as CHAR FORMAT "X(50)"     init "".  
DEF VAR n_comp_code     as CHAR FORMAT "X(50)"     init "".  
DEF VAR n_campcode      as CHAR FORMAT "X(50)"     init "".  
DEF VAR n_campname      as CHAR FORMAT "X(50)"     init "".  
DEF VAR n_procode       as CHAR FORMAT "X(50)"     init "".  
DEF VAR n_proname       as CHAR FORMAT "X(50)"     init "".  
DEF VAR n_packname      as CHAR FORMAT "X(50)"     init "".  
DEF VAR n_packcode      as CHAR FORMAT "X(50)"     init "".  
DEF VAR n_instype       as CHAR FORMAT "X(5)"      init "".  
DEF VAR n_pol_title     as CHAR FORMAT "X(20)"     init "".  
DEF VAR n_pol_fname     as CHAR FORMAT "X(100)"    init "".  
DEF VAR n_pol_lname     as CHAR FORMAT "X(100)"    init "".  
DEF VAR n_pol_title_eng as CHAR FORMAT "X(20)"     init "".  
DEF VAR n_pol_fname_eng as CHAR FORMAT "X(50)"     init "".  
DEF VAR n_pol_lname_eng as CHAR FORMAT "X(50)"     init "".  
DEF VAR n_icno          as CHAR FORMAT "X(20)"     init "".  
DEF VAR n_sex           as CHAR FORMAT "X(1) "     init "".  
DEF VAR n_bdate         as CHAR FORMAT "X(10)"     init "".  
DEF VAR n_occup         as CHAR FORMAT "X(50)"     init "".  
DEF VAR n_tel           as CHAR FORMAT "X(20)"     init "".  
DEF VAR n_phone         as CHAR FORMAT "X(20)"     init "".  
DEF VAR n_teloffic      as CHAR FORMAT "X(20)"     init "".  
DEF VAR n_telext        as CHAR FORMAT "X(20)"     init "".  
DEF VAR n_moblie        as CHAR FORMAT "X(20)"     init "".  
DEF VAR n_mobliech      as CHAR FORMAT "X(20)"     init "".  
DEF VAR n_mail          as CHAR FORMAT "X(40)"     init "".  
DEF VAR n_lineid        as CHAR FORMAT "X(100)"    init "".  
DEF VAR n_addr1_70      as CHAR FORMAT "X(20)"     init "".  
DEF VAR n_addr2_70      as CHAR FORMAT "X(100)"    init "".  
DEF VAR n_addr3_70      as CHAR FORMAT "X(100)"    init "".  
DEF VAR n_addr4_70      as CHAR FORMAT "X(100)"    init "".  
DEF VAR n_addr5_70      as CHAR FORMAT "X(40)"     init "".  
DEF VAR n_nsub_dist70   as CHAR FORMAT "X(20)"     init "".  
DEF VAR n_ndirection70  as CHAR FORMAT "X(20)"     init "".  
DEF VAR n_nprovin70     as CHAR FORMAT "X(20)"     init "".  
DEF VAR n_zipcode70     as CHAR FORMAT "X(10)"     init "".  
DEF VAR n_addr1_72      as CHAR FORMAT "X(20)"     init "".  
DEF VAR n_addr2_72      as CHAR FORMAT "X(100)"    init "".  
DEF VAR n_addr3_72      as CHAR FORMAT "X(100)"    init "".  
DEF VAR n_addr4_72      as CHAR FORMAT "X(100)"    init "".  
DEF VAR n_addr5_72      as CHAR FORMAT "X(40)"     init "".  
DEF VAR n_nsub_dist72   as CHAR FORMAT "X(20)"     init "".  
DEF VAR n_ndirection72  as CHAR FORMAT "X(20)"     init "".  
DEF VAR n_nprovin72     as CHAR FORMAT "X(20)"     init "".  
DEF VAR n_zipcode72     as CHAR FORMAT "X(10)"     init "".  
DEF VAR n_paytype       as CHAR FORMAT "X(1) "     init "".  
DEF VAR n_paytitle      as CHAR FORMAT "X(20)"     init "".  
DEF VAR n_payname       as CHAR FORMAT "X(100)"    init "".  
DEF VAR n_paylname      as CHAR FORMAT "X(100)"    init "".  
DEF VAR n_payicno       as CHAR FORMAT "X(20)"     init "".  
DEF VAR n_payaddr1      as CHAR FORMAT "X(10)"     init "".  
DEF VAR n_payaddr2      as CHAR FORMAT "X(100)"    init "".  
DEF VAR n_payaddr3      as CHAR FORMAT "X(100)"    init "".  
DEF VAR n_payaddr4      as CHAR FORMAT "X(100)"    init "".  
DEF VAR n_payaddr5      as CHAR FORMAT "X(40)"     init "".  
DEF VAR n_payaddr6      as CHAR FORMAT "X(20)"     init "".  
DEF VAR n_payaddr7      as CHAR FORMAT "X(20)"     init "".  
DEF VAR n_payaddr8      as CHAR FORMAT "X(20)"     init "".  
DEF VAR n_payaddr9      as CHAR FORMAT "X(10)"     init "".  
DEF VAR n_branch        as CHAR FORMAT "X(10)"     init "".  
DEF VAR n_ben_title     as CHAR FORMAT "X(10)"     init "".  
DEF VAR n_ben_name      as CHAR FORMAT "X(50)"     init "".  
DEF VAR n_ben_lname     as CHAR FORMAT "X(50)"     init "".  
DEF VAR n_pmentcode     as CHAR FORMAT "X(10)"     init "".  
DEF VAR n_pmenttyp      as CHAR FORMAT "X(20)"     init "".  
DEF VAR n_pmentcode1    as CHAR FORMAT "X(20)"     init "".  
DEF VAR n_pmentcode2    as CHAR FORMAT "X(50)"     init "".  
DEF VAR n_pmentbank     as CHAR FORMAT "X(20)"     init "".  
DEF VAR n_pmentdate     as CHAR FORMAT "X(10)"     init "".  
DEF VAR n_pmentsts      as CHAR FORMAT "X(10)"     init "".  
DEF VAR n_driver        as CHAR FORMAT "X(10)"     init "".  
DEF VAR n_drivetitle1   as CHAR FORMAT "X(10)"     init "".  
DEF VAR n_drivename1    as CHAR FORMAT "X(50)"     init "".  
DEF VAR n_drivelname1   as CHAR FORMAT "X(50)"     init "".  
DEF VAR n_driveno1      as CHAR FORMAT "X(20)"     init "".  
DEF VAR n_occupdriv1    as CHAR FORMAT "X(30)"     init "".  
DEF VAR n_sexdriv1      as CHAR FORMAT "X(1) "     init "".  
DEF VAR n_bdatedriv1    as CHAR FORMAT "X(10)"     init "".  
DEF VAR n_drivetitle2   as CHAR FORMAT "X(10)"     init "".  
DEF VAR n_drivename2    as CHAR FORMAT "X(50)"     init "".  
DEF VAR n_drivelname2   as CHAR FORMAT "X(50)"     init "".  
DEF VAR n_driveno2      as CHAR FORMAT "X(20)"     init "".  
DEF VAR n_occupdriv2    as CHAR FORMAT "X(50)"     init "".  
DEF VAR n_sexdriv2      as CHAR FORMAT "X(1) "     init "".  
DEF VAR n_bdatedriv2    as CHAR FORMAT "X(10)"     init "".  
DEF VAR n_brand         as CHAR FORMAT "X(50)"     init "".   
DEF VAR n_brand_cd      as CHAR FORMAT "X(50)"     init "".   
DEF VAR n_Model         as CHAR FORMAT "X(50)"     init "".   
DEF VAR n_Model_cd      as CHAR FORMAT "X(50)"     init "".   
DEF VAR n_body          as CHAR FORMAT "X(50)"     init "".   
DEF VAR n_body_cd       as CHAR FORMAT "X(50)"     init "".   
DEF VAR n_licence       as CHAR FORMAT "X(50)"     init "".   
DEF VAR n_province      as CHAR FORMAT "X(50)"     init "".   
DEF VAR n_chassis       as CHAR FORMAT "X(50)"     init "".   
DEF VAR n_engine        as CHAR FORMAT "X(50)"     init "".   
DEF VAR n_yrmanu        as CHAR FORMAT "X(10)"     init "".   
DEF VAR n_seatenew      as CHAR FORMAT "X(10)"     init "".   
DEF VAR n_power         as CHAR FORMAT "X(10)"     init "".   
DEF VAR n_weight        as CHAR FORMAT "X(10)"     init "".   
DEF VAR n_class         as CHAR FORMAT "X(10)"     init "".   
DEF VAR n_garage_cd     as CHAR FORMAT "X(10)"     init "".   
DEF VAR n_garage        as CHAR FORMAT "X(10)"     init "".   
DEF VAR n_colorcode     as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_covcod        as CHAR FORMAT "X(10)"     init "".   
DEF VAR n_covtyp        as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_covtyp1       as CHAR FORMAT "X(50)"     init "".   
DEF VAR n_covtyp2       as CHAR FORMAT "X(50)"     init "".   
DEF VAR n_covtyp3       as CHAR FORMAT "X(50)"     init "".   
DEF VAR n_comdat        as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_expdat        as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_ins_amt       as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_prem1         as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_gross_prm     as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_stamp         as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_vat           as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_premtotal     as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_deduct        as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_fleetper      as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_fleet         as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_ncbper        as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_ncb           as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_drivper       as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_drivdis       as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_othper        as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_oth           as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_cctvper       as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_cctv          as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_Surcharper    as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_Surchar       as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_Surchardetail as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_acc1          as CHAR FORMAT "X(50)"     init "".   
DEF VAR n_accdetail1    as CHAR FORMAT "X(500)"    init "".   
DEF VAR n_accprice1     as CHAR FORMAT "X(10)"     init "".   
DEF VAR n_acc2          as CHAR FORMAT "X(50)"     init "".   
DEF VAR n_accdetail2    as CHAR FORMAT "X(500)"    init "".   
DEF VAR n_accprice2     as CHAR FORMAT "X(10)"     init "".   
DEF VAR n_acc3          as CHAR FORMAT "X(50)"     init "".   
DEF VAR n_accdetail3    as CHAR FORMAT "X(500)"    init "".   
DEF VAR n_accprice3     as CHAR FORMAT "X(10)"     init "".   
DEF VAR n_acc4          as CHAR FORMAT "X(50)"     init "".   
DEF VAR n_accdetail4    as CHAR FORMAT "X(500)"    init "".   
DEF VAR n_accprice4     as CHAR FORMAT "X(10)"     init "".   
DEF VAR n_acc5          as CHAR FORMAT "X(50)"     init "".   
DEF VAR n_accdetail5    as CHAR FORMAT "X(500)"    init "".   
DEF VAR n_accprice5     as CHAR FORMAT "X(10)"     init "".   
DEF VAR n_inspdate      as CHAR FORMAT "X(10)"     init "".   
DEF VAR n_inspdate_app  as CHAR FORMAT "X(10)"     init "".   
DEF VAR n_inspsts       as CHAR FORMAT "X(10)"     init "".   
DEF VAR n_inspdetail    as CHAR FORMAT "X(500)"    init "".   
DEF VAR n_not_date      as CHAR FORMAT "X(10)"     init "".   
DEF VAR n_paydate       as CHAR FORMAT "X(10)"     init "".   
DEF VAR n_paysts        as CHAR FORMAT "X(10)"     init "".   
DEF VAR n_licenBroker   as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_brokname      as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_brokcode      as CHAR FORMAT "X(10)"     init "".   
DEF VAR n_lang          as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_deli          as CHAR FORMAT "X(50)"     init "".   
DEF VAR n_delidetail    as CHAR FORMAT "X(100)"    init "".   
DEF VAR n_gift          as CHAR FORMAT "X(100)"    init "".   
DEF VAR n_cedcode       as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_inscode       as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_remark        as CHAR FORMAT "X(500)"    init "" . 
DEF VAR n_policy        AS CHAR FORMAT "X(13)"     INIT "" .
def var n_inspname      as char format "x(75)"     init "" .
def var n_inspphone     as char format "x(20)"     init "" .
def var n_insploca      as char format "x(250)"    init "" .
def var n_agentname     as char format "x(25)"     init "" .
/* add by : A67-0162 */
def var n_tyeeng         as char format "x(20)"   init "". 
def var n_typMC          as char format "x(20)"   init "". 
def var n_watt           as CHAR FORMAT "x(4)"    init "". 
def var n_evmotor1       as char format "x(45)"   init "". 
def var n_evmotor2       as char format "x(45)"   init "". 
def var n_evmotor3       as char format "x(45)"   init "". 
def var n_evmotor4       as char format "x(45)"   init "". 
def var n_evmotor5       as char format "x(45)"   init "". 
def var n_evmotor6       as char format "x(45)"   init "". 
def var n_evmotor7       as char format "x(45)"   init "". 
def var n_evmotor8       as char format "x(45)"   init "". 
def var n_evmotor9       as char format "x(45)"   init "". 
def var n_evmotor10      as char format "x(45)"   init "". 
def var n_evmotor11      as char format "x(45)"   init "". 
def var n_evmotor12      as char format "x(45)"   init "". 
def var n_evmotor13      as char format "x(45)"   init "". 
def var n_evmotor14      as char format "x(45)"   init "". 
def var n_evmotor15      as char format "x(45)"   init "". 
def var n_carprice       as CHAR FORMAT "x(15)"   init "". 
def var n_drivlicen1     as CHAR FORMAT "x(20)"   init "". 
def var n_drivcardexp1   as CHAR FORMAT "x(15)"   init "". 
def var n_drivcartyp1    as char format "x(20)"   init "". 
def var n_drivlicen2     as char format "x(20)"   init "". 
def var n_drivcardexp2   as CHAR FORMAT "x(15)"   init "". 
def var n_drivcartyp2    as char format "x(20)"   init "". 
def var n_drivetitle3    as char format "x(10)"   init "". 
def var n_drivename3     as char format "x(50)"   init "". 
def var n_drivelname3    as char format "x(50)"   init "". 
def var n_bdatedriv3     as CHAR FORMAT "x(15)"   init "". 
def var n_sexdriv3       as char format "x(1)"    init "". 
def var n_drivcartyp3    as char format "x(20)"   init "". 
def var n_driveno3       as char format "x(20)"   init "". 
def var n_drivlicen3     as char format "x(20)"   init "". 
def var n_drivcardexp3   as CHAR FORMAT "x(15)"   init "". 
def var n_occupdriv3     as char format "x(255)"  init "". 
def var n_drivetitle4    as char format "x(10)"   init "". 
def var n_drivename4     as char format "x(50)"   init "". 
def var n_drivelname4    as char format "x(50)"   init "". 
def var n_bdatedriv4     as CHAR FORMAT "x(15)"   init "". 
def var n_sexdriv4       as char format "X(1)"    init "". 
def var n_drivcartyp4    as char format "X(20)"   init "". 
def var n_driveno4       as char format "X(20)"   init "". 
def var n_drivlicen4     as char format "X(20)"   init "". 
def var n_drivcardexp4   as CHAR FORMAT "x(15)"   init "". 
def var n_occupdriv4     as char format "x(255)"  init "". 
def var n_drivetitle5    as char format "x(10)"   init "". 
def var n_drivename5     as char format "x(50)"   init "". 
def var n_drivelname5    as char format "x(50)"   init "". 
def var n_bdatedriv5     as CHAR FORMAT "x(15)"   init "". 
def var n_sexdriv5       as char format "X(1)"    init "". 
def var n_drivcartyp5    as char format "X(20)"   init "". 
def var n_driveno5       as char format "X(20)"   init "". 
def var n_drivlicen5     as char format "X(20)"   init "". 
def var n_drivcardexp5   as CHAR FORMAT "x(15)"   init "". 
def var n_occupdriv5     as char format "x(255)"  init "". 
def var n_battflag       as char format "x(1)"    init "". 
def var n_battyr         as CHAR FORMAT "x(10)"   init "". 
def var n_battdate       as CHAR FORMAT "x(15)"   init "". 
def var n_battprice      as CHAR FORMAT "x(20)"   init "". 
def var n_battno         as CHAR FORMAT "x(50)"   init "". 
def var n_battsi         as CHAR FORMAT "x(20)"   init "". 
def var n_chagreno       as char format "x(50)"   init "". 
def var n_chagrebrand    as char format "x(50)"   init "". 
DEF VAR n_inspbr  AS CHAR FORMAT "x(70)" INIT "" .
/* end A67-0162 */

DEF  STREAM nfile.  
DEF VAR nn_remark1  AS CHAR INIT "".   /*A56-0399*/
DEF VAR nn_remark2  AS CHAR INIT "".   /*A56-0399*/
DEF VAR nn_remark3  AS CHAR INIT "".   /*A56-0399*/
DEF VAR nv_len      AS INTE INIT 0.    /*A56-0399*/
Def  Var chNotesSession  As Com-Handle.
Def  Var chNotesDataBase As Com-Handle.
Def  Var chDocument      As Com-Handle.
Def  Var chNotesView     As Com-Handle .
Def  Var chNavView       As Com-Handle .
Def  Var chViewEntry     As Com-Handle .
Def  Var chItem          As Com-Handle .
Def  Var chData          As Com-Handle .
Def  Var nv_server       As Char.
Def  Var nv_tmp          As char .
def  var nv_extref       as char.
DEF VAR nv_nameT         AS CHAR FORMAT "X(50)".
DEF VAR nv_agentname     AS CHAR FORMAT "X(60)".
DEF VAR nv_brand         AS CHAR FORMAT "X(50)". 
DEF VAR nv_model         AS CHAR FORMAT "X(50)". 
DEF VAR nv_licentyp      AS CHAR FORMAT "X(50)".
DEF VAR nv_licen         AS CHAR FORMAT "X(20)". 
DEF VAR nv_pattern1      AS CHAR FORMAT "X(20)".  
DEF VAR nv_pattern4      AS CHAR FORMAT "X(20)".  
DEF VAR nv_today         AS CHAR init "" .
DEF VAR nv_time          AS CHAR init "" .
DEF VAR nv_docno         AS CHAR FORMAT "x(25)".
DEF VAR nv_survey        AS CHAR FORMAT "x(25)".
DEF VAR nv_detail        AS CHAR FORMAT "x(30)".
DEF VAR nv_remark1       AS CHAR FORMAT "x(250)".
DEF VAR nv_remark2       AS CHAR FORMAT "x(250)".
DEF VAR nv_damlist       AS CHAR FORMAT "x(150)" INIT "" .
DEF VAR nv_damage        AS CHAR FORMAT "x(250)" INIT "" .
DEF VAR nv_totaldam      AS CHAR FORMAT "X(150)" .
DEF VAR nv_attfile       AS CHAR FORMAT "x(100)" INIT "" .
DEF VAR nv_device        AS CHAR FORMAT "x(500)" INIT "".
Def var nv_acc1          as char format "x(50)".   
Def var nv_acc2          as char format "x(50)".   
Def var nv_acc3          as char format "x(50)".   
Def var nv_acc4          as char format "x(50)".   
Def var nv_acc5          as char format "x(50)".   
Def var nv_acc6          as char format "x(50)".   
Def var nv_acc7          as char format "x(50)".   
Def var nv_acc8          as char format "x(50)".   
Def var nv_acc9          as char format "x(50)".   
Def var nv_acc10         as char format "x(50)".   
Def var nv_acc11         as char format "x(50)".   
Def var nv_acc12         as char format "x(50)".   
Def var nv_acctotal      as char format "x(100)".   
DEF VAR nv_surdata       AS CHAR FORMAT "x(250)".  
DEF VAR nv_date          AS CHAR FORMAT "x(15)" .
DEF VAR nv_damdetail     AS LONGCHAR .

/*------- File Old ----------*/
DEFINE  TEMP-TABLE wdetail01 NO-UNDO
    FIELD   Seqno        AS CHAR FORMAT "X(10)"  INIT ""   /*  1   Seq.    1   */                                                       
    FIELD   Company      AS CHAR FORMAT "X(10)"  INIT ""   /*  2   Company AYCAL   */                                      
    FIELD   Porduct      AS CHAR FORMAT "X(10)"  INIT ""   /*  3   Porduct HP  */                                             
    FIELD   Branch       AS CHAR FORMAT "X(10)"  INIT ""   /*  4   Branch  11  */                                             
    FIELD   Contract     AS CHAR FORMAT "X(10)"  INIT ""   /*  5   Contract    T053357 */                                  
    FIELD   nTITLE       AS CHAR FORMAT "X(10)"  INIT ""   /*  6   ชื่อ+นามสกุล    นาย */                                                                         
    FIELD   name1        AS CHAR FORMAT "X(10)"  INIT ""   /*  7   กฤตพัฒน์    */                                      
    FIELD   name2        AS CHAR FORMAT "X(10)"  INIT ""   /*  8   ป้อมประยูร  */                                      
    FIELD   addr1        AS CHAR FORMAT "X(10)"  INIT ""   /*  9   ที่อยู่ 78/427 มบ.อินทราวิลล์ ถ.พระยาสุเรนทร์ ซ.19  */  
    FIELD   addr2        AS CHAR FORMAT "X(10)"  INIT ""   /*  10  แขวงบางชัน เขตคลองสามวา */                          
    FIELD   addr3        AS CHAR FORMAT "X(10)"  INIT ""   /*  11  กทม.    */                                          
    FIELD   addr4        AS CHAR FORMAT "X(10)"  INIT ""   /*  12  10510   */                                          
    FIELD   brand        AS CHAR FORMAT "X(10)"  INIT ""   /*  13  ยี่ห้อรถ    TOY */                                      
    FIELD   model        AS CHAR FORMAT "X(10)"  INIT ""   /*  14  รุ่นรถ  ALTIS 1.6E CNG  */                              
    FIELD   coler        AS CHAR FORMAT "X(10)"  INIT ""   /*  15  สี  เทา */                                                           
    FIELD   vehreg       AS CHAR FORMAT "X(10)"  INIT ""   /*  16  เลขทะเบียน  ฎฮ 8828 */                                  
    FIELD   provin       AS CHAR FORMAT "X(10)"  INIT ""   /*  17  จังหวัดที่จดทะเบียน กรุงเทพมหานคร   */                  
    FIELD   caryear      AS CHAR FORMAT "X(10)"  INIT ""   /*  18  ปีรถ    2010    */                                      
    FIELD   cc           AS CHAR FORMAT "X(10)"  INIT ""   /*  19  CC. 1598    */                                          
    FIELD   chassis      AS CHAR FORMAT "X(10)"  INIT ""   /*  20  เลขตัวถัง   MR053ZEE106184578   */                      
    FIELD   engno        AS CHAR FORMAT "X(10)"  INIT ""   /*  21  เลขเครื่อง  3ZZB029121  */                                                
    FIELD   notifyno     AS CHAR FORMAT "X(10)"  INIT ""   /*  22  Code ผู้แจ้ง    1112    */                                                
    FIELD   covcod       AS CHAR FORMAT "X(10)"  INIT ""   /*  23  ประเภท  1   */                                                            
    FIELD   Codecompany  AS CHAR FORMAT "X(10)"  INIT ""   /*  24  Code บ.ประกัน   KPI */                                    
    FIELD   prepol       AS CHAR FORMAT "X(10)"  INIT ""   /*  25  เลขกรมธรรม์เดิม     */                                       
    FIELD   comdat70     AS CHAR FORMAT "X(10)"  INIT ""   /*  26  วันคุ้มครองประกัน   560722  */                                                
    FIELD   expdat70     AS CHAR FORMAT "X(10)"  INIT ""   /*  27  วันหมดประกัน    570722  */                                                    
    FIELD   si           AS CHAR FORMAT "X(10)"  INIT ""   /*  28  ทุนประกัน   54000000    */                                                    
    FIELD   premt        AS CHAR FORMAT "X(10)"  INIT ""   /*  29  ค่าเบี้ยสุทธิ์  1376070 */                                                    
    FIELD   premtnet     AS CHAR FORMAT "X(10)"  INIT ""   /*  30  ค่าเบี้ยรวมภาษีอากร 1478312 */                                                
    FIELD   other        AS CHAR FORMAT "X(10)"  INIT ""   /*  31      0   */                                                                    
    FIELD   renew        AS CHAR FORMAT "X(10)"  INIT ""   /*  32  ปีประกัน    2   */                                                            
    FIELD   policy       AS CHAR FORMAT "X(10)"  INIT ""   /*  33  เลขรับแจ้ง  STAY13-0257 */    
    FIELD   idno         AS CHAR FORMAT "X(15)"  INIT ""   /*  33  id */ 
    FIELD   garage       AS CHAR FORMAT "X(10)"  INIT ""   /*  34      ซ่อมห้าง    */                                                            
    FIELD   notifydate   AS CHAR FORMAT "X(10)"  INIT ""   /*  35  วันที่แจ้ง  560621  */                                                                      
    FIELD   Deduct       AS CHAR FORMAT "X(10)"  INIT ""   /*  36  Deduct      */                                                                              
    FIELD   Codecompa72  AS CHAR FORMAT "X(10)"  INIT ""   /*  37  Code บ.ประกัน พรบ.      */                                                 
    FIELD   comdat72     AS CHAR FORMAT "X(10)"  INIT ""   /*  38  วันคุ้มครองพรบ.     */                                                     
    FIELD   expdat72     AS CHAR FORMAT "X(10)"  INIT ""   /*  39  วันหมดพรบ.      */                                                         
    FIELD   comp         AS CHAR FORMAT "X(10)"  INIT ""   /*  40  ค่าพรบ.     */                                                             
    FIELD   driverno     AS CHAR FORMAT "X(10)"  INIT ""   /*  41  ระบุผู้ขับขี่       */                                                     
    FIELD   access       AS CHAR FORMAT "X(10)"  INIT ""   /*  43  คุ้มครองอุปกรณ์เพิ่มเติม        */                                         
    FIELD   endoresadd   AS CHAR FORMAT "X(10)"  INIT ""   /*  44  แก้ไขที่อยู่        */                                   
    FIELD   remak        AS CHAR FORMAT "X(10)"  INIT ""   /*  45  หมายเหตุ.       */
    FIELD   recivedat    AS CHAR FORMAT "x(10)"  INIT ""
    FIELD   AgencyEmployee AS CHAR FORMAT "X(10)"  INIT ""   /*  ชื่อผู้แจ้งงาน */                                    
    FIELD   siIns          AS CHAR FORMAT "X(10)"  INIT ""   /*  เบี้ยประกันรับจากลูกค้า */                                       
    FIELD   InsCTP         AS CHAR FORMAT "X(10)"  INIT ""   /*  INSURER CTP  */                                                
    FIELD   drivername1    AS CHAR FORMAT "X(10)"  INIT ""   /*  ผู้ขับขี่คนที่ 1*/                                                     
    FIELD   driverbrith1   AS CHAR FORMAT "X(10)"  INIT ""   /*  วันเดือนปีเกิด 1 */                                                    
    FIELD   drivericno1    AS CHAR FORMAT "X(10)"  INIT ""   /*  หมายเลขบัตร 1 */                                                       
    FIELD   driverCard1    AS CHAR FORMAT "X(10)"  INIT ""   /*  DRIVER CARD 1 */        
    FIELD   driverexp1     AS CHAR FORMAT "X(10)"  INIT ""   /*  DRIVER CARD EXPIRE 1 */
    FIELD   drivername2    AS CHAR FORMAT "X(10)"  INIT ""   /*  ผู้ขับขี่คนที่ 2 */                                                   
    FIELD   driverbrith2   AS CHAR FORMAT "X(10)"  INIT ""   /*  วันเดือนปีเกิด 2 */                                                    
    FIELD   drivericno2    AS CHAR FORMAT "X(10)"  INIT ""   /*  วันเดือนปีเกิด 2 */                                                    
    FIELD   driverCard2    AS CHAR FORMAT "X(10)"  INIT ""   /*  หมายเลขบัตร 2 */         
    FIELD   driverexp2     AS CHAR FORMAT "X(15)"  INIT ""   /*  DRIVER CARD EXPIRE 2 */
    FIELD   InspectName    AS CHAR FORMAT "X(10)"  INIT ""   /*  ชื่อผู้ตรวจรถ */                                                                                   
    FIELD   InspectPhoneNo AS CHAR FORMAT "X(10)"  INIT ""   /*  เบอร์โทรศัพท์ผู้ตรวจรถ */                                                                  
    FIELD   Benefic        AS CHAR FORMAT "X(100)"  INIT ""   /*  ผู้รับผลประโยชน์ */                                                                        
    FIELD   Plus12         AS CHAR FORMAT "X(10)"  INIT ""   /*  FLAG FOR 12PLUS  */          
    FIELD   ISPNo          AS CHAR FORMAT "X(20)"  INIT ""   /*  Inspection No  */ 
    FIELD   pass           AS CHAR FORMAT "x(25)"  INIT "" 
    FIELD   ftype          AS CHAR FORMAT "x(2)" INIT "" .


DEF VAR np_addr1     AS CHAR FORMAT "x(256)"    INIT "" .
DEF VAR np_addr2     AS CHAR FORMAT "x(40)"     INIT "" .
DEF VAR np_addr3     AS CHAR FORMAT "x(40)"     INIT "" .
DEF VAR np_addr4     AS CHAR FORMAT "x(40)"     INIT "" .
DEF VAR np_addr5     AS CHAR FORMAT "x(40)"     INIT "" .   /*Add Jiraphon A59-0451*/
DEF VAR nv_prov     AS CHAR FORMAT "x(40)"     INIT "" .    /*Add Jiraphon A59-0451*/
DEF VAR nv_amp      AS CHAR FORMAT "x(40)"     INIT "" .    /*Add Jiraphon A59-0451*/
DEF VAR nv_tum      AS CHAR FORMAT "x(40)"     INIT "" .    /*Add Jiraphon A59-0451*/


DEF VAR np_addrall     AS CHAR FORMAT "x(40)"     INIT "" .
DEF VAR np_title     AS CHAR FORMAT "x(30)"     INIT "" .
DEF VAR np_name      AS CHAR FORMAT "x(40)"     INIT "" .
DEF VAR np_name2     AS CHAR FORMAT "x(40)"     INIT "" .














