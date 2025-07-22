/*programid   : wgwhcgen.i                                                          */
/*programname : load text file HCT to GW                                            */
/* Copyright	: Safety Insurance Public Company Limited 			                */
/*			      บริษัท ประกันคุ้มภัย จำกัด (มหาชน)				                */
/*create by   : Kridtiya i. A52-0172   date . 08/07/2009              
                ปรับโปรแกรมให้สามารถนำเข้า text file HCT to GW system               */ 
/*copy write  : wgwargen.i                                                          */
/*modify by   : kridtiya.i A55-0043 เพิ่มฟิล์ด การจ่าย,ธนาคาร                       */
/*modify by   : kridtiya.i  A55-0151 เพิ่มตัวแปร Producer code2: เพื่อแสดงออกรายงาน */
/*modify by   : kridtiya.i  A55-0190 ปรับขยายเลขที่สัญญา จาก 11 หลักเป็น 20 
                และตัวแปรเก็บค่า หมายเหตุจาก 255 ตัวอักษร เป็น 512 ตัวอักษร         */
/*modify by   : Kridtiya i. A55-0268 เพิ่มการเก็บวันเกิดผู้เอาประกัน                */
/*modify by   : Kridtiya i. A54-0112 ขยายช่องทะเบียนรถ จาก 10 เป็น 11 หลัก          */
/*modify by   : Kridtiya i. A56-0318 เพิ่มการรับค่า ประเภทการแจ้งงาน,ราคารวมอุปกรณ์เสริม,รายละเอียดอุปกรณ์เสริม */
/*Modify by   : Kridtiya i. A56-068 เพิ่มการเก็บรายละเอียดอุปกรณ์เสริม */
/*Modify by   : Kridtiya i. A57-0073 เพิ่มรหัสสาขาผู้เอาประกันภัย */
/*Modify by   : Kridtiya i. A57-0126 เพิ่มตัวแปรเก็บข้อมูล ลำดับที่ ของแคมเปญ      */
/*Modify by   : Kridtiya i. A58-0198 เพิ่มตัวแปรเก็บข้อมูล สำหรับออกใบเสร็จ 3 ใบ   */
/*Modify by   : Ranu I. A58-0419 Date. 04/11/2015  เพิ่มตัวแปรเก็บข้อมูล  เลขที่แคมเปญ  ประเภทการชำระเบี้ย */
/*Modify By   : Sarinya C. A62-0215 เพิ่มตัวแปรเก็บข้อมูล Campaign */
/*Modify by   : Kridtiya i. A63-0472 Date. 09/11/2020 add field firstname ,lastname.....*/
/*Modify by   : Ranu i. A64-0328 Date. 27/08/2021 เพิ่มตัวแปรเก็บข้อมูลผู้ขับขี่จากใบเตือน และการคำนวณเบี้ยกลาง*/
/*Modify by   : Ranu I. A64-0138 เพิ่มตัวแปรเก็บค่าการคำนวณเบี้ย */
/*Modify by   : Kridtiya i. A66-0162 Date. 18/08/2023 add Producer ...*/
/*Modify by   : Ranu I. A68-0061 เพิ่มการเก็บข้อมูลรถไฟฟ้า */
/***********************************************************************************/
DEFINE  TEMP-TABLE wdetail
    /*FIELD policyno       AS CHAR FORMAT "x(11)" INIT ""    /*เลขที่ใบคำขอ*/*/ /*A55-0190*/
    FIELD policyno       AS CHAR FORMAT "x(20)" INIT ""      /*เลขที่ใบคำขอ*/   /*A55-0190*/
    FIELD cndat          AS CHAR FORMAT "x(10)" INIT ""      /*วันที่ใบคำขอ*/
    FIELD appenno        AS CHAR FORMAT "x(32)" INIT ""      /*เลขที่รับแจ้ง*/
    FIELD comdat         AS CHAR FORMAT "x(10)" INIT ""      /*วันที่เริ่มคุ้มครอง*/
    FIELD expdat         AS CHAR FORMAT "x(10)" INIT ""      /*วันที่สิ้นสุด*/
    FIELD comcode        AS CHAR FORMAT "x(10)" INIT ""      /*รหัสบริษัทประกันภัย*/  
    FIELD cartyp         AS CHAR FORMAT "x(4)"  INIT ""      /*ประเภทรถ*/ 
    FIELD saletyp        AS CHAR FORMAT "x(1)"  INIT ""      /*ประเภทการขาย*/
    FIELD campen         AS CHAR FORMAT "x(16)" INIT ""      /*ประเภทแคมเปญ*/
    FIELD freeamonth     AS CHAR FORMAT "x(10)" INIT ""      /*จำนวนเงินให้ฟรี*/
    /*FIELD covcod         AS CHAR FORMAT "x(1)"  INIT ""      /*ประเภทความคุ้มครอง*/*//*A57-0073*/
    FIELD covcod         AS CHAR FORMAT "x(3)"  INIT ""      /*ประเภทความคุ้มครอง*//*A57-0073*/
    FIELD typcom         AS CHAR FORMAT "x(9)"  INIT ""      /*ประเภทประกัน*/
    FIELD garage         AS CHAR FORMAT "x(6)"  INIT ""      /*ประเภทการซ่อม*/
    FIELD bysave         AS CHAR FORMAT "x(30)" INIT ""      /*ผู้บันทึก*/
    FIELD tiname         AS CHAR FORMAT "x(20)" INIT ""      /*คำนำหน้า*/
    FIELD insnam         AS CHAR FORMAT "x(80)" INIT ""      /*ชื่อลูกค้า*/
    FIELD name2          AS CHAR FORMAT "x(20)" INIT ""      /*ชื่อกลาง*/
    FIELD name3          AS CHAR FORMAT "x(60)" INIT ""      /*นามสกุล*/
    FIELD addr           AS CHAR FORMAT "x(80)" INIT ""      /*ที่อยู่*/
    FIELD road           AS CHAR FORMAT "x(40)" INIT ""      /*ถนน*/
    FIELD tambon         AS CHAR FORMAT "x(60)" INIT ""      /*ตำบล*/
    FIELD amper          AS CHAR FORMAT "x(30)" INIT ""      /*อำเภอ*/
    FIELD country        AS CHAR FORMAT "x(30)" INIT ""      /*จังหวัด*/
    FIELD post           AS CHAR FORMAT "x(5)"  INIT ""      /*รหัสไปรษณีย์*/
    FIELD occup          AS CHAR FORMAT "x(50)" INIT ""      /*อาชีพ*/
    FIELD birthdat       AS CHAR FORMAT "x(10)" INIT ""      /*วันเกิด*/
    FIELD icno           AS CHAR FORMAT "x(15)" INIT ""      /*เลขที่บัตรประชาชน*/
    FIELD driverno       AS CHAR FORMAT "x(15)" INIT ""      /*เลขที่ใบขับขี่*/
    FIELD brand          AS CHAR FORMAT "x(10)" INIT ""      /*ยี่ห้อรถ*/
    FIELD cargrp         AS CHAR FORMAT "x"     INIT ""      /*กลุ่มรถยนต์*/
    FIELD chasno         AS CHAR FORMAT "x(25)" INIT ""      /*หมายเลขตัวถัง*/
    FIELD eng            AS CHAR FORMAT "x(20)" INIT ""      /*หมายเลขเครื่อง*/
    FIELD model          AS CHAR FORMAT "x(40)" INIT ""      /*ชื่อรุ่นรถ*/
    FIELD caryear        AS CHAR FORMAT "x(4)"  INIT ""      /*รุ่นปี*/
    FIELD carcode        AS CHAR FORMAT "x(20)" INIT ""      /*ชื่อประเภทรถ*/
    FIELD body           AS CHAR FORMAT "x(40)" INIT ""      /*แบบตัวถัง*/
    FIELD carno          AS CHAR FORMAT "x(1)"  INIT ""      /*รหัสประเภทรถ*/
    FIELD vehuse         AS CHAR FORMAT "x(2)"  INIT ""      /*รหัสลักษณะการใช้งาน*/
    FIELD seat           AS CHAR FORMAT "x(2)"  INIT ""      /*จำนวนที่นั่ง*/
    FIELD engcc          AS CHAR FORMAT "x(4)"  INIT ""      /*ปริมาตรกระบอกสูบ*/
    FIELD colorcar       AS CHAR FORMAT "x(40)" INIT ""      /*ชื่อสีรถ*/
    /*FIELD vehreg         AS CHAR FORMAT "x(10)" INIT ""      /*เลขทะเบียนรถ*/*//*kridtiya i. A54-0112*/
    FIELD vehreg         AS CHAR FORMAT "x(11)" INIT ""      /*เลขทะเบียนรถ*/    /*kridtiya i. A54-0112*/
    FIELD re_country     AS CHAR FORMAT "x(30)" INIT ""      /*จังหวัดที่จดทะเบียน*/
    FIELD re_year        AS CHAR FORMAT "x(4)"  INIT ""      /*ปีที่จดทะเบียน*/
    /*FIELD nmember        AS CHAR FORMAT "x(255)" INIT ""   /*หมายเหตุ*/*/ /*A55-0190*/
    FIELD nmember        AS CHAR FORMAT "x(512)" INIT ""     /*หมายเหตุ*/     /*A55-0190*/
    FIELD si             AS CHAR FORMAT "x(14)" INIT ""      /*วงเงินทุนประกัน*/
    FIELD premt          AS CHAR FORMAT "x(14)" INIT ""      /*เบี้ยประกัน*/
    FIELD rstp_t         AS CHAR FORMAT "x(14)" INIT ""      /*อากร*/
    FIELD rtax_t         AS CHAR FORMAT "x(14)" INIT ""      /*จำนวนเงินภาษี*/
    FIELD prem_r         AS CHAR FORMAT "x(14)" INIT ""      /*เบี้ยประกันรวม*/
    FIELD gap            AS CHAR FORMAT "X(14)" INIT ""      /*เบี้ยประกันรวมทั้งหมด*/
    FIELD ncb            AS CHAR FORMAT "X(14)" INIT ""      /*อัตราส่วนลดประวัติดี*/
    FIELD ncbprem        AS CHAR FORMAT "X(14)" INIT ""      /*ส่วนลดประวัติดี*/
    FIELD stk            AS CHAR FORMAT "x(20)" INIT ""      /*หมายเลขสติ๊กเกอร์*/
    FIELD prepol         AS CHAR FORMAT "x(32)" INIT ""      /*เลขที่กรมธรรม์เดิม*/
    FIELD flagname       AS CHAR FORMAT "X"     INIT ""      /*flag ระบุชื่อ*/
    FIELD flagno         AS CHAR FORMAT "x"     INIT ""      /*flag ไม่ระบุชื่อ*/
    FIELD ntitle1        AS CHAR FORMAT "x(20)" INIT ""      /*คำนำหน้า*/
    FIELD drivername1    AS CHAR FORMAT "x(80)" INIT ""      /*ชื่อผู้ขับขี่คนที่1 */
    FIELD dname1         AS CHAR FORMAT "X(20)" INIT ""      /*ชื่อกลาง*/
    FIELD dname2         AS CHAR FORMAT "x(60)" INIT ""      /*นามสกุล*/
    FIELD docoup         AS CHAR FORMAT "x(50)" INIT ""      /*อาชีพ*/
    FIELD dbirth         AS CHAR FORMAT "x(10)" INIT ""      /*วันเกิด*/
    FIELD dicno          AS CHAR FORMAT "x(15)" INIT ""      /*เลขที่บัตรประชาชน*/
    FIELD ddriveno       AS CHAR FORMAT "x(15)" INIT ""      /*เลขที่ใบขับขี่*/
    FIELD ntitle2        AS CHAR FORMAT "x(20)" INIT ""      /*คำนำหน้า2*/             
    FIELD drivername2    AS CHAR FORMAT "x(80)" INIT ""      /*ชื่อผู้ขับขี่คนที่2 */ 
    FIELD ddname1        AS CHAR FORMAT "x(20)" INIT ""      /*ชื่อกลาง2*/             
    FIELD ddname2        AS CHAR FORMAT "x(60)" INIT ""      /*นามสกุล2*/              
    FIELD ddocoup        AS CHAR FORMAT "x(50)" INIT ""      /*อาชีพ2*/                
    FIELD ddbirth        AS CHAR FORMAT "x(10)" INIT ""      /*วันเกิด2*/              
    FIELD ddicno         AS CHAR FORMAT "x(15)" INIT ""      /*เลขที่บัตรประชาชน2*/    
    FIELD dddriveno      AS CHAR FORMAT "x(15)" INIT ""      /*เลขที่ใบขับขี่2*/       
    FIELD benname        AS CHAR FORMAT "x(80)" INIT ""      /*ผู้รับผลประโยชน์*/
    FIELD comper         AS CHAR FORMAT "x(14)" INIT ""      /*ความเสียหายต่อชีวิต(บาท/คน)*/      
    FIELD comacc         AS CHAR FORMAT "x(14)" INIT ""      /*ความเสียหายต่อชีวิต(บาท/ครั้ง)*/      
    FIELD deductpd       AS CHAR FORMAT "X(14)" INIT ""      /*ความเสียหายต่อทรัพย์สิน*/      
    FIELD tp2            AS CHAR FORMAT "X(14)" INIT ""      /*ความเสียหายส่วนแรกบุคคล*/      
    FIELD deductda       AS CHAR FORMAT "X(14)" INIT ""      /*ความเสียหายต่อต่อรถยนต์*/      
    FIELD deduct         AS CHAR FORMAT "X(14)" INIT ""      /*ความเสียหายส่วนแรกรถยนต์*/     
    FIELD tpfire         AS CHAR FORMAT "x(14)" INIT ""      /*รถยนต์สูญหาย/ไฟไหม้*/     
    FIELD compul         AS CHAR FORMAT "x"     INIT "" 
    FIELD pass           AS CHAR FORMAT "x"     INIT "n"     
    /* add by : A68-0061 */       
    field typepol        as char format "x(20)"  
    field typecar        as char format "x(20)"  
    field maksi          as char format "x(20)"  
    field drivexp1       as char format "x(20)" 
    FIELD drivcon1       AS CHAR FORMAT "x(20)"
    field dlevel1        as char format "x(20)"  
    field dgender1       as char format "x(20)"  
    field drelation1     as char format "x(20)"  
    field drivexp2       as char format "x(20)" 
    FIELD drivcon2       AS CHAR FORMAT "x(20)"
    field dlevel2        as char format "x(20)"  
    field dgender2       as char format "x(20)"  
    field drelation2     as char format "x(20)"  
    field ntitle3        as char format "x(20)"  
    field dname3         as char format "x(20)"  
    field dcname3        as char format "x(20)"  
    field dlname3        as char format "x(20)"  
    field doccup3        as char format "x(20)"  
    field dbirth3        as char format "x(20)"  
    field dicno3         as char format "x(20)"  
    field ddriveno3      as char format "x(20)"  
    field drivexp3       as char format "x(20)" 
    FIELD drivcon3       AS CHAR FORMAT "x(20)"
    field dlevel3        as char format "x(20)"  
    field dgender3       as char format "x(20)"  
    field drelation3     as char format "x(20)"  
    field ntitle4        as char format "x(20)"  
    field dname4         as char format "x(20)"  
    field dcname4        as char format "x(20)"  
    field dlname4        as char format "x(20)"  
    field doccup4        as char format "x(20)"  
    field dbirth4        as char format "x(20)"  
    field dicno4         as char format "x(20)"  
    field ddriveno4      as char format "x(20)"  
    field drivexp4       as char format "x(20)" 
    FIELD drivcon4       AS CHAR FORMAT "x(20)"
    field dlevel4        as char format "x(20)"  
    field dgender4       as char format "x(20)"  
    field drelation4     as char format "x(20)"  
    field ntitle5        as char format "x(20)"  
    field dname5         as char format "x(20)"  
    field dcname5        as char format "x(20)"  
    field dlname5        as char format "x(20)"  
    field doccup5        as char format "x(20)"  
    field dbirth5        as char format "x(20)"  
    field dicno5         as char format "x(20)"  
    field ddriveno5      as char format "x(20)"  
    field drivexp5       as char format "x(20)" 
    FIELD drivcon5       AS CHAR FORMAT "x(20)"
    field dlevel5        as char format "x(20)"  
    field dgender5       as char format "x(20)"  
    field drelation5     as char format "x(20)"  
    field chargflg       as char format "x(20)"  
    field chargprice     as char format "x(20)"  
    field chargno        as char format "x(20)"  
    field chargprm       as char format "x(20)"  
    field battflg        as char format "x(20)"  
    field battprice      as char format "x(20)"  
    field battno         as char format "x(20)"  
    field battprm        as char format "x(20)"  
    field battdate       as char format "x(20)"  
    FIELD rate31         AS CHAR FORMAT "x(4)" 
    FIELD premt31        AS CHAR FORMAT "x(10)" 
    FIELD drilevel      AS INTE INIT 0.
    /* end : A68-0061 */

DEFINE TEMP-TABLE wdetail2
    FIELD policyno       AS CHAR FORMAT "x(11)" INIT "" 
    FIELD NO_41          AS CHAR FORMAT "x(14)" INIT ""     /*อุบัติเหตุส่วนบุคคลเสียชีวิตผู้ขับขี่*/ 
    FIELD ac2            AS CHAR FORMAT "x(2)"  INIT ""     /*อุบัติเหตุส่วนบุคคลเสียชีวิตจน.ผู้โดยสาร*/
    FIELD NO_42          AS CHAR FORMAT "x(14)" INIT ""     /*อุบัติเหตุส่วนบุคคลเสียชีวิตผู้โดยสารต่อครั้ง*/
    FIELD ac4            AS CHAR FORMAT "x(14)" INIT ""     /*อุบัติเหตุส่วนบุคคลทุพพลภาพชั่วคราวผู้ขับขี่ */
    FIELD ac5            AS CHAR FORMAT "x(2)"  INIT ""     /*อุบัติเหตุส่วนบุคคลทุพพลภาพชั่วคราวจน.ผู้โดยสาร*/
    FIELD ac6            AS CHAR FORMAT "x(14)" INIT ""     /*อุบัติเหตุส่วนบุคคลทุพพลภาพชั่วคราวผู้โดยสารต่อครั้ง*/
    FIELD ac7            AS CHAR FORMAT "x(14)" INIT ""     /*ค่ารักษาพยาบาล*/
    FIELD NO_43          AS CHAR FORMAT "x(14)" INIT ""     /*การประกันตัวผู้ขับขี่*/
    FIELD nstatus        AS CHAR FORMAT "x(6)"  INIT ""     /*สถานะข้อมูล*/
    FIELD typrequest     AS CHAR FORMAT "x(10)" INIT ""     /*ประเภทผู้แจ้งประกัน*/
    FIELD comrequest     AS CHAR FORMAT "x(10)" INIT ""     /*รหัสบริษัทผู้แจ้งประกัน*/
    FIELD brrequest      AS CHAR FORMAT "x(30)" INIT ""     /*สาขาบริษัทผู้แจ้งประกัน*/
    FIELD salename       AS CHAR FORMAT "x(80)" INIT ""     /*ชื่อผู้ติดต่อ/Saleman*/
    FIELD comcar         AS CHAR FORMAT "x(10)" INIT ""     /*บริษัทที่ปล่อยรถ*/
    FIELD brcar          AS CHAR FORMAT "x(30)" INIT ""     /*สาขาบริษัทที่ปล่อยรถ*/
    FIELD projectno      AS CHAR FORMAT "x(12)" INIT ""     /*honda project*/
    FIELD caryear        AS CHAR FORMAT "x(3)"  INIT ""     /*อายุรถ*/
    FIELD special1       AS CHAR FORMAT "x(10)" INIT ""     /*บริการเสริมพิเศษ1*/
    FIELD specialprem1   AS CHAR FORMAT "x(14)" INIT ""     /*ราคาบริการเสริมพิเศษ1*/
    FIELD special2       AS CHAR FORMAT "x(10)" INIT ""     /*บริการเสริมพิเศษ2*/       
    FIELD specialprem2   AS CHAR FORMAT "x(14)" INIT ""     /*ราคาบริการเสริมพิเศษ2*/   
    FIELD special3       AS CHAR FORMAT "x(10)" INIT ""     /*บริการเสริมพิเศษ3*/       
    FIELD specialprem3   AS CHAR FORMAT "x(14)" INIT ""     /*ราคาบริการเสริมพิเศษ3*/   
    FIELD special4       AS CHAR FORMAT "x(10)" INIT ""     /*บริการเสริมพิเศษ4*/       
    FIELD specialprem4   AS CHAR FORMAT "x(14)" INIT ""     /*ราคาบริการเสริมพิเศษ4*/   
    FIELD special5       AS CHAR FORMAT "x(10)" INIT ""     /*บริการเสริมพิเศษ5*/       
    FIELD specialprem5   AS CHAR FORMAT "x(14)" INIT ""     /*ราคาบริการเสริมพิเศษ5*/ 
    FIELD comment        AS CHAR FORMAT "x(512)"  INIT ""   
    FIELD agent          AS CHAR FORMAT "x(10)" INIT ""     
    FIELD producer       AS CHAR FORMAT "x(10)" INIT ""     
    FIELD producer2      AS CHAR FORMAT "x(10)" INIT ""     
    FIELD entdat         AS CHAR FORMAT "x(10)" INIT ""     /*entry date*/
    FIELD enttim         AS CHAR FORMAT "x(8)"  INIT ""     /*entry time*/    
    FIELD trandat        AS CHAR FORMAT "x(10)" INIT ""     /*tran date*/     
    FIELD trantim        AS CHAR FORMAT "x(8)"  INIT ""     /*tran time*/     
    FIELD n_IMPORT       AS CHAR FORMAT "x(2)"  INIT ""        
    FIELD n_EXPORT       AS CHAR FORMAT "x(2)"  INIT "" 
    FIELD poltyp         AS CHAR FORMAT "x(3)"  INIT "" 
    FIELD pass           AS CHAR FORMAT "x"     INIT "n"
    FIELD OK_GEN         AS CHAR FORMAT "X"     INIT "Y" 
    FIELD renpol         AS CHAR FORMAT "x(32)" INIT ""     
    FIELD cr_2           AS CHAR FORMAT "x(32)" INIT ""  
    FIELD docno          AS CHAR INIT "" FORMAT "x(10)" 
    FIELD redbook        AS CHAR INIT "" FORMAT "X(8)"
    FIELD drivnam        AS CHAR FORMAT "x" INIT "n" 
    FIELD tariff         AS CHAR FORMAT "x(2)" INIT "9"
    FIELD weight         AS CHAR FORMAT "x(5)" INIT ""
    FIELD cancel         AS CHAR FORMAT "x(2)" INIT ""      /*cancel*/
    FIELD accdat         AS CHAR INIT "" FORMAT "x(10)"     /*Account Date For 72*/
    FIELD prempa         AS CHAR FORMAT "x" INIT ""         /*premium package*/ 
    FIELD subclass       AS CHAR FORMAT "x(3)" INIT ""      /*sub class*/ 
    FIELD fleet          AS CHAR FORMAT "x(10)"  INIT ""    /*fleet*/
    FIELD WARNING        AS CHAR FORMAT "X(30)"  INIT ""    
    FIELD seat41         AS INTE FORMAT "99"     INIT 0     
    FIELD volprem        AS CHAR FORMAT "x(20)"  INIT ""    /*voluntory premium*/
    FIELD Compprem       AS CHAR FORMAT "x(20)"  INIT ""    /*compulsory prem*/
    FIELD ac_no          AS CHAR FORMAT "x(15)"  INIT ""   
    FIELD ac_date        AS CHAR FORMAT "x(10)"  INIT ""   
    FIELD ac_amount      AS CHAR FORMAT "x(14)"  INIT ""   
    FIELD ac_pay         AS CHAR FORMAT "x(10)"  INIT ""   
    FIELD ac_agent       AS CHAR FORMAT "x(20)"  INIT ""   
    FIELD n_branch       AS CHAR FORMAT "x(5)"   INIT ""   
    FIELD n_delercode    AS CHAR FORMAT "x(15)"  INIT ""   
    FIELD voictitle      AS CHAR FORMAT "x(1)"   INIT ""    
    FIELD voicnam        AS CHAR FORMAT "x(120)" INIT ""    
    FIELD detailcam      AS CHAR FORMAT "x(100)" INIT ""   
    FIELD ins_pay        AS CHAR FORMAT "x(2)"   INIT ""   
    FIELD n_month        AS CHAR FORMAT "x(2)"   INIT ""    /*A55-0043 */
    FIELD n_bank         AS CHAR FORMAT "x(10)"  INIT ""    /*A55-0043 */ 
    FIELD TYPE_notify    AS CHAR FORMAT "x"      INIT ""    /*A56-0318 120 */
    FIELD price_acc      AS CHAR FORMAT "x(10)"  INIT ""    /*A56-0318 121 */
    FIELD nv_insref      AS CHAR FORMAT "X(10)"  INIT ""    /*A56-0318  */
    FIELD accdata        AS CHAR FORMAT "x(255)" INIT ""    /*A56-0318 122 */
    FIELD name4          AS CHAR FORMAT "x(60)"  INIT ""     /*A57-0073 */
    FIELD brdealer       AS CHAR FORMAT "x(5)"   INIT ""    /*A7-0073  */ 
    FIELD Campaign       AS CHAR FORMAT "x(20)"  INIT ""    /*A62-0215*/
    FIELD WCampaign      AS CHAR FORMAT "x(50)"  INIT ""    /*A62-0215*/
    FIELD watt           AS DECI INIT 0.  /* A68-0061*/
DEFINE TEMP-TABLE wdetail3
    FIELD policyno        AS CHAR FORMAT "x(12)"  INIT "" 
    FIELD name3           AS CHAR FORMAT "x(150)" INIT ""   /* A58-0198 ชื่อ   */
    FIELD instot          AS INTE FORMAT "9"      INIT 0
    FIELD brand_gals      AS CHAR FORMAT "x(20)"  INIT ""   /* A58-0198 ยี่ห้อเคลือบแก้ว	*/
    FIELD brand_galsprm   AS CHAR FORMAT "x(20)"  INIT ""   /* A58-0198 ราคาเคลือบแก้ว	*/
    FIELD companyre1      AS CHAR FORMAT "x(150)" INIT ""   /* A58-0198 ชื่อบริษัทเต็มบนใบกำกับภาษี1	*/
    FIELD companybr1      AS CHAR FORMAT "x(15)"  INIT ""   /* A58-0198 สาขาบริษัทบนใบกำกับภาษี1	*/
    FIELD addr_re1        AS CHAR FORMAT "x(250)" INIT ""   /* A58-0198 ที่อยู่บนใบกำกับภาษี1	*/
    FIELD idno_re1        AS CHAR FORMAT "x(13)"  INIT ""   /* A58-0198 เลขที่ผู้เสียภาษี1	*/
    FIELD premt_re1       AS CHAR FORMAT "x(10)"  INIT ""   /* A58-0198 อัตราเบี้ยตามใบกำกับ1	*/
    FIELD companyre2      AS CHAR FORMAT "x(150)" INIT ""   /* A58-0198 ชื่อบริษัทเต็มบนใบกำกับภาษี2	*/
    FIELD companybr2      AS CHAR FORMAT "x(15)"  INIT ""   /* A58-0198 สาขาบริษัทบนใบกำกับภาษี2	*/
    FIELD addr_re2        AS CHAR FORMAT "x(250)" INIT ""   /* A58-0198 ที่อยู่บนใบกำกับภาษี2	*/
    FIELD idno_re2        AS CHAR FORMAT "x(13)"  INIT ""   /* A58-0198 เลขที่ผู้เสียภาษี2	*/
    FIELD premt_re2       AS CHAR FORMAT "x(10)"  INIT ""   /* A58-0198 อัตราเบี้ยตามใบกำกับ2	*/
    FIELD companyre3      AS CHAR FORMAT "x(150)" INIT ""   /* A58-0198 ชื่อบริษัทเต็มบนใบกำกับภาษี3	*/
    FIELD companybr3      AS CHAR FORMAT "x(15)"  INIT ""   /* A58-0198 สาขาบริษัทบนใบกำกับภาษี3	*/
    FIELD addr_re3        AS CHAR FORMAT "x(250)" INIT ""   /* A58-0198 ที่อยู่บนใบกำกับภาษี3	*/
    FIELD idno_re3        AS CHAR FORMAT "x(13)"  INIT ""   /* A58-0198 เลขที่ผู้เสียภาษี3	*/
    FIELD premt_re3       AS CHAR FORMAT "x(10)"  INIT ""   /* A58-0198 อัตราเบี้ยตามใบกำกับ3	*/
    FIELD camp_no         AS CHAR FORMAT "x(12)"  INIT ""   /* A58-0419 เลขที่แคมเปญ   */
    FIELD payment_type    AS CHAR FORMAT "x(10)"  INIT ""   /* A58-0419 ประเภทการชำระเบี้ย */
    FIELD insnamtyp       AS CHAR FORMAT "x(60)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD firstName       AS CHAR FORMAT "x(60)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD lastName        AS CHAR FORMAT "x(60)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeocc         AS CHAR FORMAT "x(4)"   INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr1       AS CHAR FORMAT "x(2)"   INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr2       AS CHAR FORMAT "x(2)"   INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr3       AS CHAR FORMAT "x(2)"   INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD br_insured      AS CHAR FORMAT "x(5)"   INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD financecd       AS CHAR FORMAT "x(50)"   INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD campaign_ov     AS CHAR FORMAT "x(30)"  INIT ""  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
    /* Add by : A68-0061 */
    field net_re1         as char format "x(20)"  init "" 
    field stam_re1        as char format "x(20)"  init "" 
    field vat_re1         as char format "x(20)"  init "" 
    field inscode_re2     as char format "x(20)"  init "" 
    field net_re2         as char format "x(20)"  init "" 
    field stam_re2        as char format "x(20)"  init "" 
    field vat_re2         as char format "x(20)"  init "" 
    field inscode_re3     as char format "x(20)"  init "" 
    field net_re3         as char format "x(20)"  init "" 
    field stam_re3        as char format "x(20)"  init "" 
    field vat_re3         as char format "x(20)"  init "" .
     /* end : A68-0061 */

DEF NEW SHARED VAR nv_message AS char.
DEF            VAR c          AS CHAR.
DEF            VAR nv_riskgp  AS INTE NO-UNDO.
/***--- Note Add Condition Base Premium ---***/
DEFINE NEW SHARED VAR no_baseprm AS DECI  FORMAT ">>,>>>,>>9.99-".  /*note add test Base Premium 25/09/2006*/
DEFINE NEW SHARED VAR NO_basemsg AS CHAR  FORMAT "x(50)" .          /*Warning Error If Not in Range 25/09/2006 */
DEFINE            VAR nv_accdat  AS DATE  FORMAT "99/99/9999" INIT ?  .     
DEFINE            VAR nv_docno   AS CHAR  FORMAT "9999999"    INIT " ".
/*a490166*/
DEFINE NEW SHARED VAR  nv_batchyr   AS INT FORMAT "9999"            INIT 0.
DEFINE NEW SHARED VAR  nv_batcnt    AS INT FORMAT "99"              INIT 0.
DEFINE NEW SHARED VAR  nv_batchno   AS CHARACTER FORMAT "X(13)"     INIT ""  NO-UNDO.
DEFINE VAR  nv_batrunno  AS INT FORMAT  ">,>>9"          INIT 0.
DEFINE VAR  nv_imppol    AS INT  FORMAT ">>,>>9"         INIT 0.
DEFINE VAR  nv_impprem   AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.
DEFINE VAR  nv_batprev   AS CHARACTER FORMAT "X(13)"     INIT ""  NO-UNDO.
DEFINE VAR  nv_tmppolrun AS INTEGER FORMAT "999"         INIT 0. /*Temp Policy Running No.*/
DEFINE VAR  nv_batbrn    AS CHARACTER FORMAT "x(2)"      INIT ""  NO-UNDO. /*Batch Branch*/
DEFINE VAR  nv_tmppol    AS CHARACTER FORMAT "x(16)"     INIT "". /*Temp Policy*/
DEFINE VAR  nv_rectot    AS INT  FORMAT ">>,>>9"         INIT 0.  /* Display จำนวน ก/ธ ทั้งไฟล์ */
DEFINE VAR  nv_recsuc    AS INT  FORMAT ">>,>>9"         INIT 0.  /* Display จำนวน ก/ธ ที่นำเข้าได้ */
DEFINE VAR  nv_netprm_t  AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.  /* Display เบี้ยรวม ทั้งไฟล์ */
DEFINE VAR  nv_netprm_s  AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.  /* Display เบี้ยรวม ที่นำเข้าได้ */
DEF VAR n_producer  AS CHAR INIT "" FORMAT "x(10)"       .        /*A55-0043*/
DEFINE VAR  nv_batflg    AS LOG                          INIT NO.
DEFINE VAR  nv_txtmsg    AS CHAR FORMAT "x(50)"          INIT "".   /* Parameter คู่กับ nv_check */
DEF VAR n_age AS INTE INIT 0.      /* A55-0151 */
/*add A55-0268 by kridtiya i. ...*/
DEFINE VAR n_insref     AS CHARACTER FORMAT "X(10)". 
DEFINE VAR nv_messagein AS CHAR FORMAT "X(200)". 
DEFINE VAR nv_usrid     AS CHARACTER FORMAT "X(08)".
DEFINE VAR nv_transfer  AS LOGICAL   .
DEFINE VAR n_check      AS CHARACTER .
DEFINE VAR nv_insref    AS CHARACTER FORMAT "X(10)".  
DEFINE VAR putchr       AS CHAR FORMAT "X(200)" INIT "" NO-UNDO.
DEFINE VAR putchr1      AS CHAR FORMAT "X(100)" INIT "" NO-UNDO.
DEFINE VAR nv_typ       AS CHAR FORMAT "X(2)".
DEF BUFFER buwm100      FOR sic_bran.uwm100 .  
/*add A55-0268 by kridtiya i. ...*/
DEF VAR nv_acc6  AS CHAR FORMAT "x(60)" INIT "".       /*add A56-0368 by kridtiya i. ...*/
DEF VAR nv_acc1  AS CHAR FORMAT "x(60)" INIT "".       /*add A56-0368 by kridtiya i. ...*/
DEF VAR nv_acc2  AS CHAR FORMAT "x(60)" INIT "".       /*add A56-0368 by kridtiya i. ...*/
DEF VAR nv_acc3  AS CHAR FORMAT "x(60)" INIT "".       /*add A56-0368 by kridtiya i. ...*/
DEF VAR nv_acc4  AS CHAR FORMAT "x(60)" INIT "".       /*add A56-0368 by kridtiya i. ...*/
DEF VAR nv_acc5  AS CHAR FORMAT "x(60)" INIT "".       /*add A56-0368 by kridtiya i. ...*/
DEF VAR nv_acc7  AS CHAR FORMAT "x(60)" INIT "".       /*add A56-0368 by kridtiya i. ...*/
DEF VAR nv_acc8  AS CHAR FORMAT "x(60)" INIT "".       /*add A56-0368 by kridtiya i. ...*/
DEF VAR nv_acc9  AS CHAR FORMAT "x(60)" INIT "".       /*add A56-0368 by kridtiya i. ...*/
DEF VAR nv_acc10 AS CHAR FORMAT "x(60)" INIT "".       /*add A56-0368 by kridtiya i. ...*/
DEF VAR nv_acc11 AS CHAR FORMAT "x(60)" INIT "".       /*add A56-0368 by kridtiya i. ...*/
DEF VAR nv_acc12 AS CHAR FORMAT "x(60)" INIT "".       /*add A56-0368 by kridtiya i. ...*/
DEF VAR nv_acc13 AS CHAR FORMAT "x(60)" INIT "".       /*add A56-0368 by kridtiya i. ...*/
DEFINE TEMP-TABLE wimproducer                         /*A57-0073*/
    FIELD idno      AS CHAR FORMAT "x(10)" INIT ""    /*A57-0126*/
    FIELD saletype  AS CHAR FORMAT "x(10)" INIT ""    /*A57-0073*/
    FIELD camname   AS CHAR FORMAT "x(30)" INIT ""    /*A57-0073*/  
    FIELD notitype  AS CHAR FORMAT "x(10)" INIT ""    /*A57-0073*/
    FIELD producer  AS CHAR FORMAT "x(10)" INIT "".   /*A57-0073*/
/*A57-0126 add for 2+,3+*/
DEFINE NEW  SHARED VAR   nv_prem3       AS DECIMAL  FORMAT ">,>>>,>>9.99-" INITIAL 0  NO-UNDO.
DEFINE NEW  SHARED VAR   nv_sicod3      AS CHAR     FORMAT "X(4)".
DEFINE NEW  SHARED VAR   nv_usecod3     AS CHAR     FORMAT "X(4)".
DEFINE NEW  SHARED VAR   nv_siprm3      AS DECI     FORMAT ">>,>>>,>>9.99-".
DEFINE NEW  SHARED VAR   nv_prvprm3     AS DECI     FORMAT ">>,>>>,>>9.99-".
DEFINE NEW  SHARED VAR   nv_baseprm3    AS DECI     FORMAT ">>,>>>,>>9.99-".
DEFINE NEW  SHARED VAR   nv_useprm3     AS DECI     FORMAT ">>,>>>,>>9.99-".
DEFINE NEW  SHARED VAR   nv_basecod3    AS CHAR     FORMAT "X(4)".
DEFINE NEW  SHARED VAR   nv_basevar3    AS CHAR     FORMAT "X(60)".
DEFINE NEW  SHARED VAR   nv_basevar4    AS CHAR     FORMAT "X(30)".
DEFINE NEW  SHARED VAR   nv_basevar5    AS CHAR     FORMAT "X(30)".
DEFINE NEW  SHARED VAR   nv_usevar3     AS CHAR     FORMAT "X(60)".
DEFINE NEW  SHARED VAR   nv_usevar4     AS CHAR     FORMAT "X(30)".
DEFINE NEW  SHARED VAR   nv_usevar5     AS CHAR     FORMAT "X(30)".
DEFINE NEW  SHARED VAR   nv_sivar3      AS CHAR     FORMAT "X(60)".
DEFINE NEW  SHARED VAR   nv_sivar4      AS CHAR     FORMAT "X(30)".
DEFINE NEW  SHARED VAR   nv_sivar5      AS CHAR     FORMAT "X(30)".
/*A57-0126 add for 2+,3+*/
def var 	wf_policyno       	as char format "x(20)" init "" .	/*   เลขที่ใบคำขอ    */                                         
def var 	wf_n_branch       	as char format "x(20)" init "" .	/*   สาขา    */                                                 
def var 	wf_n_delercode    	as char format "x(20)" init "" .	/*   รหัสดีเลอร์ */                                             
def var 	wf_vatcode       	as char format "x(20)" init "" .	/*   Vat code.   */                                             
def var 	wf_cndat          	as char format "x(20)" init "" .	/*   วันที่ใบคำขอ    */                                         
def var 	wf_appenno        	as char format "x(20)" init "" .	/*   เลขที่รับแจ้ง   */                                         
def var 	wf_comdat         	as char format "x(20)" init "" .	/*   วันที่เริ่มคุ้มครอง */                                     
def var 	wf_expdat         	as char format "x(20)" init "" .	/*   วันที่สิ้นสุด   */                                         
def var 	wf_comcode        	as char format "x(20)" init "" .	/*   รหัสบริษัทประกันภัย */                                     
def var 	wf_cartyp         	as char format "x(20)" init "" .	/*   ประเภทรถ    */                                             
def var 	wf_saletyp        	as char format "x(20)" init "" .	/*   ประเภทการขาย    */                                         
def var 	wf_campen         	as char format "x(20)" init "" .	/*   ประเภทแคมเปญ    */                                         
def var 	wf_freeamonth     	as char format "x(20)" init "" .	/*   จำนวนเงินให้ฟรี     */                                     
def var 	wf_covcod         	as char format "x(20)" init "" .	/*   ประเภทความคุ้มครอง  */                                     
def var 	wf_typcom         	as char format "x(20)" init "" .	/*   ประเภทประกัน    */                                         
def var 	wf_garage         	as char format "x(20)" init "" .	/*   ประเภทการซ่อม   */                                         
def var 	wf_bysave         	as char format "x(20)" init "" .	/*   ผู้บันทึก   */                                             
def var 	wf_tiname         	as char format "x(20)" init "" .	/*   คำนำหน้า    */                                             
def var 	wf_insnam         	as char format "x(20)" init "" .	/*   ชื่อลูกค้า  */                                             
def var 	wf_name2          	as char format "x(20)" init "" .	/*   ชื่อกลาง    */                                             
def var 	wf_name3          	as char format "x(20)" init "" .	/*   นามสกุล     */                                             
def var 	wf_addr           	as char format "x(20)" init "" .	/*   ที่อยู่     */                                             
def var 	wf_road           	as char format "x(20)" init "" .	/*   ถนน     */                                                 
def var 	wf_tambon         	as char format "x(20)" init "" .	/*   ตำบล    */                                                 
def var 	wf_amper          	as char format "x(20)" init "" .	/*   อำเภอ   */                                                 
def var 	wf_country        	as char format "x(20)" init "" .	/*   จังหวัด     */                                             
def var 	wf_post           	as char format "x(20)" init "" .	/*   รหัสไปรษณีย์    */                                         
def var 	wf_occup          	as char format "x(20)" init "" .	/*   อาชีพ   */                                                 
def var 	wf_birthdat       	as char format "x(20)" init "" .	/*   วันเกิด */                                                 
def var 	wf_icno           	as char format "x(20)" init "" .	/*   เลขที่บัตรประชาชน   */                                     
def var 	wf_driverno       	as char format "x(20)" init "" .	/*   เลขที่ใบขับขี่  */                                         
def var 	wf_brand          	as char format "x(20)" init "" .	/*   ยี่ห้อรถ    */                                             
def var 	wf_cargrp         	as char format "x(20)" init "" .	/*   กลุ่มรถยนต์     */                                         
def var 	wf_chasno         	as char format "x(20)" init "" .	/*   หมายเลขตัวถัง   */                                         
def var 	wf_eng            	as char format "x(20)" init "" .	/*   หมายเลขเครื่อง  */                                         
def var 	wf_model          	as char format "x(20)" init "" .	/*   ชื่อรุ่นรถ  */                                             
def var 	wf_caryear        	as char format "x(20)" init "" .	/*   รุ่นปี  */                                                 
def var 	wf_carcode        	as char format "x(20)" init "" .	/*   ชื่อประเภทรถ    */                                         
def var 	wf_body           	as char format "x(20)" init "" .	/*   แบบตัวถัง   */                                             
def var 	wf_vehuse         	as char format "x(20)" init "" .	/*   รหัสประเภทรถ    */                                         
def var 	wf_carno          	as char format "x(20)" init "" .	/*   รหัสลักษณะการใช้งาน */                                     
def var 	wf_seat           	as char format "x(20)" init "" .	/*   จำนวนที่นั่ง    */                                         
def var 	wf_engcc          	as char format "x(20)" init "" .	/*   ปริมาตรกระบอกสูบ    */                                     
def var 	wf_colorcar       	as char format "x(20)" init "" .	/*   ชื่อสีรถ    */                                             
def var 	wf_vehreg         	as char format "x(20)" init "" .	/*   เลขทะเบียนรถ    */                                         
def var 	wf_re_country     	as char format "x(20)" init "" .	/*   จังหวัดที่จดทะเบียน */                                     
def var 	wf_re_year        	as char format "x(20)" init "" .	/*   ปีที่จดทะเบียน  */                                         
def var 	wf_nmember        	as char format "x(20)" init "" .	/*   หมายเหตุ    */                                             
def var 	wf_si             	as char format "x(20)" init "" .	/*   วงเงินทุนประกัน */                                         
def var 	wf_premt          	as char format "x(20)" init "" .	/*   เบี้ยประกัน */                                             
def var 	wf_rstp_t         	as char format "x(20)" init "" .	/*   อากร    */                                                 
def var 	wf_rtax_t         	as char format "x(20)" init "" .	/*   จำนวนเงินภาษี   */                                         
def var 	wf_prem_r         	as char format "x(20)" init "" .	/*   เบี้ยประกันรวม  */                                         
def var 	wf_gap            	as char format "x(20)" init "" .	/*   เบี้ยประกันรวมทั้งหมด   */                                 
def var 	wf_ncb            	as char format "x(20)" init "" .	/*   อัตราส่วนลดประวัติดี    */                                 
def var 	wf_ncbprem        	as char format "x(20)" init "" .	/*   ส่วนลดประวัติดี */                                         
def var 	wf_stk            	as char format "x(20)" init "" .	/*   หมายเลขสติ๊กเกอร์   */                                     
def var 	wf_prepol         	as char format "x(20)" init "" .	/*   เลขที่กรมธรรม์เดิม  */                                     
def var 	wf_flagname       	as char format "x(20)" init "" .	/*   flag ระบุชื่อ   */                                         
def var 	wf_flagno         	as char format "x(20)" init "" .	/*   flag ไม่ระบุชื่อ    */                                     
def var 	wf_ntitle1        	as char format "x(20)" init "" .	/*   คำนำหน้า    */                                             
def var 	wf_drivername1    	as char format "x(20)" init "" .	/*   ชื่อผู้ขับขี่คนที่1 */                                     
def var 	wf_dname1         	as char format "x(20)" init "" .	/*   ชื่อกลาง    */                                             
def var 	wf_dname2         	as char format "x(20)" init "" .	/*   นามสกุล */                                                 
def var 	wf_docoup         	as char format "x(20)" init "" .	/*   อาชีพ   */                                                 
def var 	wf_dbirth         	as char format "x(20)" init "" .	/*   วันเกิด */                                                 
def var 	wf_dicno          	as char format "x(20)" init "" .	/*   เลขที่บัตรประชาชน   */                                     
def var 	wf_ddriveno       	as char format "x(20)" init "" .	/*   เลขที่ใบขับขี่  */                                         
def var 	wf_ntitle2        	as char format "x(20)" init "" .	/*   คำนำหน้า2   */                                             
def var 	wf_drivername2    	as char format "x(20)" init "" .	/*   ชื่อผู้ขับขี่คนที่2     */                                 
def var 	wf_ddname1        	as char format "x(20)" init "" .	/*   ชื่อกลาง2   */                                             
def var 	wf_ddname2        	as char format "x(20)" init "" .	/*   นามสกุล2    */                                             
def var 	wf_ddocoup        	as char format "x(20)" init "" .	/*   อาชีพ2  */                                                 
def var 	wf_ddbirth        	as char format "x(20)" init "" .	/*   วันเกิด2    */                                             
def var 	wf_ddicno         	as char format "x(20)" init "" .	/*   เลขที่บัตรประชาชน2  */                                     
def var 	wf_dddriveno      	as char format "x(20)" init "" .	/*   เลขที่ใบขับขี่2 */                                         
def var 	wf_benname        	as char format "x(20)" init "" .	/*   ผู้รับผลประโยชน์    */                                     
def var 	wf_comper         	as char format "x(20)" init "" .	/*   ความเสียหายต่อชีวิต(บาท/คน) */                             
def var 	wf_comacc         	as char format "x(20)" init "" .	/*   ความเสียหายต่อชีวิต(บาท/ครั้ง)  */                         
def var 	wf_deductpd       	as char format "x(20)" init "" .	/*   ความเสียหายต่อทรัพย์สิน */                                 
def var 	wf_tp2            	as char format "x(20)" init "" .	/*   ความเสียหายส่วนแรกบุคคล */                                 
def var 	wf_deductda       	as char format "x(20)" init "" .	/*   ความเสียหายต่อต่อรถยนต์ */                                 
def var 	wf_deduct         	as char format "x(20)" init "" .	/*   ความเสียหายส่วนแรกรถยนต์    */                             
def var 	wf_tpfire         	as char format "x(20)" init "" .	/*   รถยนต์สูญหาย/ไฟไหม้     */                                 
def var 	wf_NO_41          	as char format "x(20)" init "" .	/*  อุบัติเหตุส่วนบุคคลเสียชีวิตผู้ขับขี่    */                 
def var 	wf_ac2            	as char format "x(20)" init "" .	/*  อุบัติเหตุส่วนบุคคลเสียชีวิตจน.ผู้โดยสาร */                 
def var 	wf_NO_42          	as char format "x(20)" init "" .	/*  อุบัติเหตุส่วนบุคคลเสียชีวิตผู้โดยสารต่อครั้ง    */         
def var 	wf_ac4            	as char format "x(20)" init "" .	/*  อุบัติเหตุส่วนบุคคลทุพพลภาพชั่วคราวผู้ขับขี่ */             
def var 	wf_ac5            	as char format "x(20)" init "" .	/*  อุบัติเหตุส่วนบุคคลทุพพลภาพชั่วคราวจน.ผู้โดยสาร  */         
def var 	wf_ac6            	as char format "x(20)" init "" .	/*  อุบัติเหตุส่วนบุคคลทุพพลภาพชั่วคราวผู้โดยสารต่อครั้ง */     
def var 	wf_ac7            	as char format "x(20)" init "" .	/*  ค่ารักษาพยาบาล   */                                         
def var 	wf_NO_43          	as char format "x(20)" init "" .	/*  การประกันตัวผู้ขับขี่    */                                 
def var 	wf_nstatus        	as char format "x(20)" init "" .	/*  สถานะข้อมูล  */                                             
def var 	wf_typrequest     	as char format "x(20)" init "" .	/*  รหัสบริษัทผู้แจ้งประกัน  */                                
def var 	wf_comrequest     	as char format "x(20)" init "" .	/*  ชื่อบริษัทผู้แจ้งงาน */                                     
def var 	wf_brrequest      	as char format "x(20)" init "" .	/*  สาขาบริษัทผู้แจ้งประกัน  */                                 
def var 	wf_salename       	as char format "x(20)" init "" .	/*  ชื่อผู้ติดต่อ/Saleman    */                                 
def var 	wf_comcar         	as char format "x(20)" init "" .	/*  บริษัทที่ปล่อยรถ */                                         
def var 	wf_brcar          	as char format "x(20)" init "" .	/*  สาขาบริษัทที่ปล่อยรถ */                                     
def var 	wf_projectno      	as char format "x(20)" init "" .	/*  honda project    */                                         
def var 	wf_agcaryear        as char format "x(20)" init "" .	/*   รุ่นปี  */                                                 
def var 	wf_special1       	as char format "x(20)" init "" .	/*  บริการเสริมพิเศษ1    */                                     
def var 	wf_specialprem1   	as char format "x(20)" init "" .	/*  ราคาบริการเสริมพิเศษ1    */                                 
def var 	wf_special2       	as char format "x(20)" init "" .	/*  บริการเสริมพิเศษ2    */                                     
def var 	wf_specialprem2   	as char format "x(20)" init "" .	/*  ราคาบริการเสริมพิเศษ2    */                                 
def var 	wf_special3       	as char format "x(20)" init "" .	/*  บริการเสริมพิเศษ3    */                                     
def var 	wf_specialprem3   	as char format "x(20)" init "" .	/*  ราคาบริการเสริมพิเศษ3    */                                 
def var 	wf_special4       	as char format "x(20)" init "" .	/*  บริการเสริมพิเศษ4    */                                     
def var 	wf_specialprem4   	as char format "x(20)" init "" .	/*  ราคาบริการเสริมพิเศษ4    */                                 
def var 	wf_special5       	as char format "x(20)" init "" .	/*  บริการเสริมพิเศษ5    */                                     
def var 	wf_specialprem5   	as char format "x(20)" init "" .	/*  ราคาบริการเสริมพิเศษ5    */                                 
def var 	wf_ac_no          	as char format "x(20)" init "" .	/*  เล่มที่/เลขที่   */                                         
def var 	wf_ac_date        	as char format "x(20)" init "" .	/*  วันที่รับเงิน    */                                         
def var 	wf_ac_amount      	as char format "x(20)" init "" .	/*  จำนวนเงิน    */                                             
def var 	wf_ac_pay         	as char format "x(20)" init "" .	/*  ชำระโดย  */                                                 
def var 	wf_ac_agent       	as char format "x(20)" init "" .	/*  เลขที่นายหน้า    */                                         
def var 	wf_voictitle      	as char format "x(20)" init "" .	/*  ออกใบเสร็จในนาม  */                                         
def var 	wf_voicnam        	as char format "x(20)" init "" .	/*  รหัสDealer Receipt   */                                     
def var 	wf_voicnamdetail  	as char format "x(20)" init "" .	/*   ชื่อใบเสร็จ */                                             
def var 	wf_detailcam      	as char format "x(20)" init "" .	/*  รายละเอียดเคมเปญ */                                         
def var 	wf_ins_pay        	as char format "x(20)" init "" .	/*   รับประกันจ่ายแน่ๆ   */                                     
def var 	wf_n_month        	as char format "x(20)" init "" .	/*   ผ่อนชำระ/เดือน      */                                     
def var 	wf_n_bank         	as char format "x(20)" init "" .	/*   บัตรเครดิตธนาคาร    */                                     
def var 	wf_TYPE_notify    	as char format "x(20)" init "" .	/*   ประเภทการแจ้งงาน    */                                     
def var 	wf_price_acc      	as char format "x(20)" init "" .	/*   ราคารวมอุปกรณ์เสริม */                                     
def var 	wf_accdata        	as char format "x(20)" init "" .	/*  รายละเอียดอุปกรณ์เสริม   */                                 
def var 	wf_brdealer       	as char format "x(20)" init "" .	/*  สาขา(ชื่อผู้เอาประกันในนามบริษัท)    */                     
def var 	wf_brand_gals     	as char format "x(20)" init "" .	/*  ยี่ห้อเคลือบแก้ว */                                         
def var 	wf_brand_galsprm  	as char format "x(20)" init "" .	/*  ราคาเคลือบแก้ว   */                                         
def var 	wf_companyre1     	as char format "x(20)" init "" .	/*  ชื่อบริษัทเต็มบนใบกำกับภาษี1 */                             
def var 	wf_companybr1     	as char format "x(20)" init "" .	/*  สาขาบริษัทบนใบกำกับภาษี1 */                                 
def var 	wf_addr_re1       	as char format "x(20)" init "" .	/*  ที่อยู่บนใบกำกับภาษี1    */                                 
def var 	wf_idno_re1       	as char format "x(20)" init "" .	/*  เลขที่ผู้เสียภาษี1   */                                     
def var 	wf_premt_re1      	as char format "x(20)" init "" .	/*  อัตราเบี้ยตามใบกำกับ1    */                                 
def var 	wf_companyre2     	as char format "x(20)" init "" .	/*  ชื่อบริษัทเต็มบนใบกำกับภาษี2 */                             
def var 	wf_companybr2     	as char format "x(20)" init "" .	/*  สาขาบริษัทบนใบกำกับภาษี2 */                                 
def var 	wf_addr_re2       	as char format "x(20)" init "" .	/*  ที่อยู่บนใบกำกับภาษี2    */                                 
def var 	wf_idno_re2       	as char format "x(20)" init "" .	/*  เลขที่ผู้เสียภาษี2   */                                     
def var 	wf_premt_re2      	as char format "x(20)" init "" .	/*  อัตราเบี้ยตามใบกำกับ2    */                                 
def var 	wf_companyre3     	as char format "x(20)" init "" .	/*  ชื่อบริษัทเต็มบนใบกำกับภาษี3 */                             
def var 	wf_companybr3     	as char format "x(20)" init "" .	/*  สาขาบริษัทบนใบกำกับภาษี3 */                                 
def var 	wf_addr_re3       	as char format "x(20)" init "" .	/*  ที่อยู่บนใบกำกับภาษี3    */                                 
def var 	wf_idno_re3       	as char format "x(20)" init "" .	/*  เลขที่ผู้เสียภาษี3       */                                 
def var 	wf_premt_re3     	as char format "x(20)" init "" .	/*  อัตราเบี้ยตามใบกำกับ3    */         
def var 	wf_camp_no       	as char format "x(20)" init "" .	/*  เลขที่แคมเปญ          */     /*--A58-0419--*/                               
def var 	wf_payment_type    	as char format "x(20)" init "" .	/*  ประเภทการชำระเบี้ย    */     /*--A58-0419--*/  
def var 	wf_producer      	as char format "x(20)" init "" .
DEF VAR     wf_instot           AS INTE INIT 0.
/* add by : A68-0061 */
def var wf_typepol        as char .
def var wf_typecar        as char .
def var wf_maksi          as char .
def var wf_drivexp1       as char .
def var wf_drivcon1       as char .
def var wf_dlevel1        as char .
def var wf_dgender1       as char .
def var wf_drelation1     as char .
def var wf_drivexp2       as char .
def var wf_drivcon2       as char .
def var wf_dlevel2        as char .
def var wf_dgender2       as char .
def var wf_drelation2     as char .
def var wf_ntitle3        as char .
def var wf_dname3         as char .
def var wf_dcname3        as char .
def var wf_dlname3        as char .
def var wf_doccup3        as char .
def var wf_dbirth3        as char .
def var wf_dicno3         as char .
def var wf_ddriveno3      as char .
def var wf_drivexp3       as char .
def var wf_drivcon3       as char .
def var wf_dlevel3        as char .
def var wf_dgender3       as char .
def var wf_drelation3     as char .
def var wf_ntitle4        as char .
def var wf_dname4         as char .
def var wf_dcname4        as char .
def var wf_dlname4        as char .
def var wf_doccup4        as char .
def var wf_dbirth4        as char .
def var wf_dicno4         as char .
def var wf_ddriveno4      as char .
def var wf_drivexp4       as char .
def var wf_drivcon4       as char .
def var wf_dlevel4        as char .
def var wf_dgender4       as char .
def var wf_drelation4     as char .
def var wf_ntitle5        as char .
def var wf_dname5         as char .
def var wf_dcname5        as char .
def var wf_dlname5        as char .
def var wf_doccup5        as char .
def var wf_dbirth5        as char .
def var wf_dicno5         as char .
def var wf_ddriveno5      as char .
def var wf_drivexp5       as char .
def var wf_drivcon5       as char .
def var wf_dlevel5        as char .
def var wf_dgender5       as char .
def var wf_drelation5     as char .
def var wf_chargflg       as char .
def var wf_chargprice     as char .
def var wf_chargno        as char .
def var wf_chargprm       as char .
def var wf_battflg        as char .
def var wf_battprice      as char .
def var wf_battno         as char .
def var wf_battprm        as char .
def var wf_battdate       as char .
def var wf_net_re1        as char . 
def var wf_stam_re1       as char . 
def var wf_vat_re1        as char . 
def var wf_inscode_re2    as char .
def var wf_net_re2        as char .
def var wf_stam_re2       as char .
def var wf_vat_re2        as char .
def var wf_inscode_re3    as char .
def var wf_net_re3        as char .   
def var wf_stam_re3       as char .   
def var wf_vat_re3        as char . 
def var wf_remark1        as char .
def var wf_remark2        as char .
def var wf_remark3        as char .
def var wf_remark4        as char .
def var wf_31rate         as char .
def var wf_31premt        as char .
/* end : A68-0061 */
DEF VAR     nv_fi_tax_per       AS DECI INIT 0.00.
DEF VAR     nv_fi_stamp_per     AS DECI INIT 0.00.
DEF VAR     nv_fi_tax_per_ins   AS DECI INIT 0.00.
DEF VAR     nv_fi_stamp_per_ins AS DECI INIT 0.00.
DEF VAR     nv_com1p_ins        AS DECI . 
DEF VAR nv_fi_rstp_t1       AS INTE INIT 0.
DEF VAR nv_fi_rstp_t2       AS INTE INIT 0.
DEF VAR nv_fi_rstp_t3       AS INTE INIT 0.
DEFINE VAR nv_chkerror      AS CHAR INIT "".    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
DEFINE VAR nv_cctvcode      AS CHAR INIT "".    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
DEFINE VAR n_deductDOD      AS INTEGER INIT 0.  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
DEFINE VAR n_deductDOD2     AS INTEGER INIT 0.  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/  
DEFINE VAR n_deductDPD      AS INTEGER INIT 0.  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 

DEF VAR nv_driver  AS CHAR .
DEF VAR n_prmtdriv AS DECI .
DEF VAR n_drivnam  AS CHAR .
DEF VAR n_ndriv1   AS CHAR .
DEF VAR n_bdate1   AS CHAR .
DEF VAR n_ndriv2   AS CHAR .
DEF VAR n_bdate2   AS CHAR .
DEF VAR n_dstf     AS DECI .

DEF VAR dod0 AS INTEGER.
DEF VAR dod1 AS INTEGER.
DEF VAR dod2 AS INTEGER.
DEF VAR dpd0 AS INTEGER.
/* add by : A64-0328 */

DEFINE NEW SHARED TEMP-TABLE ws0m009 
/*1*/  FIELD policy     AS CHARACTER    INITIAL ""  
/*2*/  FIELD lnumber    AS INTEGER   
       FIELD ltext      AS CHARACTER    INITIAL "" 
       FIELD ltext2     AS CHARACTER    INITIAL "" .
       /* add by : A67-0029 
       FIELD drivbirth  AS date init ?
       FIELD drivage    AS inte init 0
       FIELD occupcod   AS char format "x(10)" 
       FIELD occupdes   AS char format "x(60)" 
       FIELD cardflg    AS char format "x(3) " 
       FIELD drividno   AS char format "x(30)" 
       FIELD licenno    AS char format "x(30)" 
       FIELD drivnam    AS char format "x(120)" 
       FIELD gender     AS char format "x(15)" 
       FIELD drivlevel  AS inte init 0   
       FIELD levelper   AS deci init 0   
       FIELD titlenam   AS char FORMAT "x(40)"
       FIELD licenexp   AS date INIT ?
       FIELD firstnam   AS char format "x(60)"
       FIELD lastnam    AS char format "x(60)" 
       FIELD dconsen    AS LOGICAL INIT NO.*/
       /* end A67-0029 */ 

DEFINE NEW SHARED TEMP-TABLE wuwd100 
/*1*/  FIELD policy     AS CHARACTER    INITIAL ""  
/*2*/  FIELD lnumber    AS INTEGER   
       FIELD ltext      AS CHARACTER    INITIAL "" .
DEFINE NEW SHARED TEMP-TABLE wuwd102 
/*1*/  FIELD policy     AS CHARACTER    INITIAL ""  
/*2*/  FIELD lnumber    AS INTEGER   
       FIELD ltext      AS CHARACTER    INITIAL ""  .

/* add by : A64-0355 */
DEFINE NEW SHARED TEMP-TABLE wkuwd132 LIKE stat.pmuwd132.
DEF    VAR nv_cstflg  AS CHAR FORMAT "X(2)".     /*C=CC ; S=Seat ; T=Tons ; W=Watts*/  
DEFINE VAR nv_engcst  AS DECI FORMAT ">>>>>9.99".

DEFINE VAR nv_driage1 AS INTE FORMAT ">>9".
DEFINE VAR nv_driage2 AS INTE FORMAT ">>9".
DEF    VAR nv_pdprm0  AS DECI FORMAT ">>>,>>>,>>9.99-". /*เบี้ยผู้ขับขี่*/
DEFINE VAR nv_yrmanu  AS INTE FORMAT "9999".
DEFINE VAR nv_vehgrp  AS CHAR FORMAT "X(3)".
DEFINE VAR nv_access  AS CHAR FORMAT "X(3)".
DEFINE VAR nv_supe    AS LOGICAL.
DEFINE VAR nv_totfi   AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_tpbi1si AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_tpbi2si AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_tppdsi  AS DECI FORMAT ">>>,>>>,>>9.99-".
/*DEFINE var nv_bipprm  AS DECI FORMAT ">>>,>>>,>>9.99-". */ /*add 28/01/2022*/ 
/*DEFINE var nv_biaprm  AS DECI FORMAT ">>>,>>>,>>9.99-".*/  /*add 28/01/2022*/ 
/*DEFINE var nv_pdaprm  AS DECI FORMAT ">>>,>>>,>>9.99-".*/  /*add 28/01/2022*/ 

DEFINE VAR nv_411si   AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_412si   AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_413si   AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_414si   AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_42si    AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_43si    AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_41prmt  AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_412prmt AS DECI FORMAT ">>>,>>>,>>9.99-".    /*add  26/01/2022 */ 
DEFINE VAR nv_413prmt AS DECI FORMAT ">>>,>>>,>>9.99-".    /*add  26/01/2022 */
DEFINE VAR nv_414prmt AS DECI FORMAT ">>>,>>>,>>9.99-".    /*add  26/01/2022 */
DEFINE VAR nv_42prmt  AS DECI FORMAT ">>>,>>>,>>9.99-". 
DEFINE VAR nv_43prmt  AS DECI FORMAT ">>>,>>>,>>9.99-". 

DEFINE VAR nv_ncbp    AS DECI FORMAT ">,>>9.99-".
DEFINE VAR nv_fletp   AS DECI FORMAT ">,>>9.99-".
DEFINE VAR nv_dspcp   AS DECI FORMAT ">,>>9.99-".
DEFINE VAR nv_dstfp   AS DECI FORMAT ">,>>9.99-".
DEFINE VAR nv_clmp    AS DECI FORMAT ">,>>9.99-".
DEFINE var nv_ncbprm   AS DECI FORMAT ">>>,>>>,>>9.99-".   /*add 28/01/2022*/
DEFINE var nv_fletprm  AS DECI FORMAT ">>>,>>>,>>9.99-".   /*add 28/01/2022*/
DEFINE var nv_dspcprm  AS DECI FORMAT ">>>,>>>,>>9.99-".   /*add 28/01/2022*/
DEFINE var nv_dstfprm  AS DECI FORMAT ">>>,>>>,>>9.99-".   /*add 28/01/2022*/
DEFINE var nv_clmprm   AS DECI FORMAT ">>>,>>>,>>9.99-".   /*add 28/01/2022*/

DEFINE VAR nv_pdprem  AS DECI FORMAT ">>>,>>>,>>9.99-". 
DEFINE VAR nv_netprem AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_gapprem AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_flagprm AS CHAR FORMAT "X(2)". /* N=Net,G=Gross */
DEFINE VAR nv_flgsht  AS CHAR.  /* Short rate = "S" , Pro rate = "P" */ 

DEFINE VAR nv_effdat  AS DATE FORMAT "99/99/9999".
DEFINE VAR nv_ratatt  AS DECI FORMAT ">>,>>>,>>9.9999-".
DEFINE VAR nv_siatt   AS DECI FORMAT ">>,>>>,>>9.99-".
DEFINE VAR nv_netatt  AS DECI FORMAT ">>,>>>,>>9.99-".
DEFINE VAR nv_fltatt  AS DECI FORMAT ">>,>>>,>>9.99-".
DEFINE VAR nv_ncbatt  AS DECI FORMAT ">>,>>>,>>9.99-".
DEFINE VAR nv_dscatt  AS DECI FORMAT ">>,>>>,>>9.99-".
DEFINE VAR nv_attgap  AS DECI FORMAT ">>,>>>,>>9.99-".   /*add  26/01/2022 */ 
DEFINE VAR nv_fltgap  AS DECI FORMAT ">>,>>>,>>9.99-".   /*add  26/01/2022 */ 
DEFINE VAR nv_ncbgap  AS DECI FORMAT ">>,>>>,>>9.99-".   /*add  26/01/2022 */ 
DEFINE VAR nv_dscgap  AS DECI FORMAT ">>,>>>,>>9.99-".   /*add  26/01/2022 */ 
DEFINE VAR nv_packatt AS CHAR FORMAT "X(4)".             /*add  26/01/2022 */ 
DEFINE VAR nv_fcctv   AS LOGICAL . 
define var nv_uom1_c  as char .
define var nv_uom2_c  as char .
define var nv_uom5_c  as char .
define var nv_status  as char .
/* end A64-0355 */
/* A65-0079 */
DEFINE VAR  nv_campcd  AS CHAR FORMAT "X(40)".

DEFINE VAR nv_dodamt  AS DECI FORMAT ">>>,>>>,>>9.99-".  /*New*/  /* DOD PREMIUM */
DEFINE VAR nv_dadamt  AS DECI FORMAT ">>>,>>>,>>9.99-".  /*New*/  /* DOD1 PREMIUM */
DEFINE VAR nv_dpdamt  AS DECI FORMAT ">>>,>>>,>>9.99-".  /*New*/  /* DPD PREMIUM */

DEFINE VAR  nv_ncbamt  AS DECI FORMAT ">>>,>>>,>>9.99-".   /*New*/  /* NCB PREMIUM */
DEFINE VAR  nv_fletamt AS DECI FORMAT ">>>,>>>,>>9.99-".   /*New*/  /* FLEET PREMIUM */
DEFINE VAR  nv_dspcamt AS DECI FORMAT ">>>,>>>,>>9.99-".   /*New*/  /* DSPC PREMIUM */
DEFINE VAR  nv_dstfamt AS DECI FORMAT ">>>,>>>,>>9.99-".   /*New*/  /* DSTF PREMIUM */
DEFINE VAR  nv_clmamt  AS DECI FORMAT ">>>,>>>,>>9.99-".   /*New*/  /* LOAD CLAIM PREMIUM */

DEFINE VAR nv_mainprm  AS DECI FORMAT ">>>,>>>,>>9.99-".   /*New*/ /* Main Premium หรือเบี้ยหลัก ช่อง Name/Unname Premium (HG) */

DEFINE VAR  nv_atfltgap  AS DECI FORMAT ">>,>>>,>>9.99-".    /*New*/ /* รยต.NCB Premium */
DEFINE VAR  nv_atncbgap  AS DECI FORMAT ">>,>>>,>>9.99-".    /*New*/ /* รยต.DSPC Premium */
DEFINE VAR  nv_atdscgap  AS DECI FORMAT ">>,>>>,>>9.99-".    /*New*/ /* Package DG00 */
/* add by : A67-0029  */
DEFINE VAR nv_levper  AS DECI.
DEFINE VAR nv_adjpaprm  AS LOGICAL. 
DEFINE VAR nv_adjprem   AS LOGICAL. 
DEFINE VAR nv_flgpol    AS CHAR.     /*NR=New RedPlate, NU=New Used Car, RN=Renew*/
DEFINE VAR nv_flgclm    AS CHAR.     /*NC=NO CLAIM , WC=With Claim*/

DEFINE VAR cv_lfletper  AS DECI FORMAT ">,>>9.99-".  /*Limit Fleet % 10%*/
DEFINE VAR cv_lncbper   AS DECI FORMAT ">,>>9.99-".  /*Limit NCB %  50%*/
DEFINE VAR cv_ldssper   AS DECI FORMAT ">,>>9.99-".  /*Limit DSPC % กรณีป้ายแดง 110  ส่ง 45%  นอกนั้นส่ง 30% 35%*/
DEFINE VAR cv_lclmper   AS DECI FORMAT ">,>>9.99-".  /*Limit Claim % กรณีให้ Load Claim ได้ New 0% or 50% , Renew 0% or 20 - 50%  0%*/
DEFINE VAR cv_ldstfper  AS DECI FORMAT ">,>>9.99-".  /*Limit DSTF % 0%*/
DEFINE VAR nv_reflag    AS LOGICAL INIT NO.          /*กรณีไม่ต้องการ Re-Calculate ใส่ Yes*/
/*-- ร.ย.ฟ.05 Charger --*/
DEFINE VAR nv_chgflg    AS LOGICAL.
DEFINE VAR nv_chgrate   AS DECI FORMAT ">>>9.9999-".
DEFINE VAR nv_chgsi     AS INTE FORMAT ">>>,>>>,>>9-".
DEFINE VAR nv_chgpdprm  AS DECI FORMAT ">>,>>>,>>9.99-".
DEFINE VAR nv_chggapprm AS DECI FORMAT ">>,>>>,>>9.99-".

DEFINE var  nv_battflg    AS LOGICAL.
DEFINE var  nv_battrate   AS DECI FORMAT ">>>9.9999-".
DEFINE var  nv_battsi     AS INTE FORMAT ">>>,>>>,>>9-".
DEFINE var  nv_battprice  AS INTE FORMAT ">>>,>>>,>>9-".
DEFINE var  nv_battpdprm  AS DECI FORMAT ">>,>>>,>>9.99-".
DEFINE var  nv_battgapprm AS DECI FORMAT ">>,>>>,>>9.99-".
DEFINE var  nv_battyr     AS INTE FORMAT "9999".
DEFINE var  nv_battper    AS DECI FORMAT ">>9.99-".

DEFINE var  nv_uom9_v   AS INTE FORMAT ">>>,>>>,>>9".
DEFINE var  nv_evflg   AS LOGICAL.


/* add by : A67-0029 
DEFINE NEW SHARED TEMP-TABLE wdrive NO-UNDO 
  FIELD   policy         AS CHARACTER    INITIAL ""  
  FIELD   drivnam        AS CHAR FORMAT "x(2)"  INIT ""     /*Driver          */ 
  FIELD   drivno         AS INT  INIT 0 
  FIELD   ntitle1        AS CHAR FORMAT "X(20)" INIT ""     /*คำนำหน้า              */                        
  FIELD   name1          AS CHAR FORMAT "X(50)" INIT ""     /*ชื่อ                  */                        
  FIELD   lname1         AS CHAR FORMAT "X(50)" INIT ""     /*นามสกุล               */                        
  FIELD   dicno1         AS CHAR FORMAT "X(13)" INIT ""     /*เลขที่บัตรประชาชน     */                        
  FIELD   dgender1       AS CHAR FORMAT "X(20)" INIT ""     /*เพศ                   */                        
  FIELD   dbirth1        AS CHAR FORMAT "X(15)" INIT ""     /*วันเกิด               */                        
  FIELD   doccup1        AS CHAR FORMAT "X(20)" INIT ""     /*ชื่ออาชีพ             */                        
  FIELD   ddriveno1      AS CHAR FORMAT "X(13)" INIT ""     /*เลขที่ใบอนุญาตขับขี่  */
  FIELD   drivexp1       AS CHAR FORMAT "X(13)" INIT ""     /*เลขที่ใบอนุญาตขับขี่ หมดอายุ */ 
  FIELD   dconsen1       AS CHAR FORMAT "x(5)" INIT ""       
  FIELD   dlevel1        AS CHAR FORMAT "X(2)" INIT ""     /*ระดับผู้ขับขี่ */ 

  FIELD   ntitle2        AS CHAR FORMAT "X(20)" INIT ""     /*คำนำหน้า              */                        
  FIELD   name2          AS CHAR FORMAT "X(50)" INIT ""     /*ชื่อ                  */                        
  FIELD   lname2         AS CHAR FORMAT "X(50)" INIT ""     /*นามสกุล               */                        
  FIELD   dicno2         AS CHAR FORMAT "X(13)" INIT ""     /*เลขที่บัตรประชาชน     */                        
  FIELD   dgender2       AS CHAR FORMAT "X(20)" INIT ""     /*เพศ                   */                        
  FIELD   dbirth2        AS CHAR FORMAT "X(15)" INIT ""     /*วันเกิด               */                        
  FIELD   doccup2        AS CHAR FORMAT "X(20)" INIT ""     /*ชื่ออาชีพ             */                        
  FIELD   ddriveno2      AS CHAR FORMAT "X(13)" INIT ""     /*เลขที่ใบอนุญาตขับขี่  */
  FIELD   drivexp2       AS CHAR FORMAT "X(13)" INIT ""     /*เลขที่ใบอนุญาตขับขี่ หมดอายุ */ 
  FIELD   dconsen2       AS CHAR FORMAT "x(5)" INIT ""    
  FIELD   dlevel2        AS CHAR FORMAT "X(2)" INIT ""     /*ระดับผู้ขับขี่ */ 

  FIELD   ntitle3        AS CHAR FORMAT "X(20)" INIT ""     /*คำนำหน้า              */  
  FIELD   name3          AS CHAR FORMAT "X(50)" INIT ""     /*ชื่อ                  */                        
  FIELD   lname3         AS CHAR FORMAT "X(50)" INIT ""     /*นามสกุล               */                        
  FIELD   dicno3         AS CHAR FORMAT "X(13)" INIT ""     /*เลขที่บัตรประชาชน     */                        
  FIELD   dgender3       AS CHAR FORMAT "X(20)" INIT ""     /*เพศ                   */                        
  FIELD   dbirth3        AS CHAR FORMAT "X(15)" INIT ""     /*วันเกิด               */                        
  FIELD   doccup3        AS CHAR FORMAT "X(20)" INIT ""     /*ชื่ออาชีพ             */                        
  FIELD   ddriveno3      AS CHAR FORMAT "X(13)" INIT ""     /*เลขที่ใบอนุญาตขับขี่  */  
  FIELD   drivexp3       AS CHAR FORMAT "X(13)" INIT ""     /*เลขที่ใบอนุญาตขับขี่ หมดอายุ */ 
  FIELD   dconsen3       AS CHAR FORMAT "x(5)" INIT ""     
  FIELD   dlevel3        AS CHAR FORMAT "X(2)" INIT ""     /*ระดับผู้ขับขี่ */ 

  FIELD   ntitle4        AS CHAR FORMAT "X(20)" INIT ""     /*คำนำหน้า              */                        
  FIELD   name4          AS CHAR FORMAT "X(50)" INIT ""     /*ชื่อ                  */                        
  FIELD   lname4         AS CHAR FORMAT "X(50)" INIT ""     /*นามสกุล               */                        
  FIELD   dicno4         AS CHAR FORMAT "X(13)" INIT ""     /*เลขที่บัตรประชาชน     */                        
  FIELD   dgender4       AS CHAR FORMAT "X(20)" INIT ""     /*เพศ                   */                        
  FIELD   dbirth4        AS CHAR FORMAT "X(15)" INIT ""     /*วันเกิด               */                        
  FIELD   doccup4        AS CHAR FORMAT "X(20)" INIT ""     /*ชื่ออาชีพ             */                        
  FIELD   ddriveno4      AS CHAR FORMAT "X(13)" INIT ""     /*เลขที่ใบอนุญาตขับขี่  */  
  FIELD   drivexp4       AS CHAR FORMAT "X(13)" INIT ""     /*เลขที่ใบอนุญาตขับขี่ หมดอายุ */ 
  FIELD   dconsen4       AS CHAR FORMAT "x(5)" INIT ""     
  FIELD   dlevel4        AS CHAR FORMAT "X(2)" INIT ""     /*ระดับผู้ขับขี่ */ 

  FIELD   ntitle5        AS CHAR FORMAT "X(20)" INIT ""     /*คำนำหน้า              */                        
  FIELD   name5          AS CHAR FORMAT "X(50)" INIT ""     /*ชื่อ                  */                        
  FIELD   lname5         AS CHAR FORMAT "X(50)" INIT ""     /*นามสกุล               */                        
  FIELD   dicno5         AS CHAR FORMAT "X(13)" INIT ""     /*เลขที่บัตรประชาชน     */                        
  FIELD   dgender5       AS CHAR FORMAT "X(20)" INIT ""     /*เพศ                   */                        
  FIELD   dbirth5        AS CHAR FORMAT "X(15)" INIT ""     /*วันเกิด               */                        
  FIELD   doccup5        AS CHAR FORMAT "X(20)" INIT ""     /*ชื่ออาชีพ             */                        
  FIELD   ddriveno5      AS CHAR FORMAT "X(13)" INIT ""     /*เลขที่ใบอนุญาตขับขี่  */  
  FIELD   drivexp5       AS CHAR FORMAT "X(13)" INIT ""     /*เลขที่ใบอนุญาตขับขี่ หมดอายุ */
  FIELD   dconsen5       AS CHAR FORMAT "x(5)" INIT ""     
  FIELD   dlevel5        AS CHAR FORMAT "X(2)" INIT "" .    /*ระดับผู้ขับขี่ */ 
...*/
DEFINE VAR  nv_level  AS INTE INIT 0.
DEF VAR  re_maksi     AS DECI FORMAT ">>,>>>,>>9.99-" . 
DEF VAR  re_eng_no2   AS CHAR FORMAT "x(50)" INIT "" .  
/* end : A67-0029 */
/*--A68-0044-- */
def var nv_31rate as DECI format ">>9.99-".  /* Rate 31 */
def var nv_31prmt as DECI format ">>,>>>,>>9.99-".  /* เบี้ย 31 */
DEF VAR nv_flag   AS LOGICAL INIT NO .
DEF VAR nv_garage AS CHAR FORMAT "x(2)" .

DEF VAR n_count AS INTE INIT 0.
DEF VAR no_policy   AS CHAR FORMAT "x(20)" .
DEF VAR no_rencnt   AS CHAR FORMAT "99".
DEF VAR no_endcnt   AS CHAR FORMAT "999".
DEF VAR no_riskno   AS CHAR FORMAT "999".
DEF VAR no_itemno   AS CHAR FORMAT "999".
/*def var nv_drivage1 as inte init 0 . */
/*def var nv_drivage2 as inte init 0 . */
def var nv_drivage3 as inte init 0 .
def var nv_drivage4 as inte init 0 .
def var nv_drivage5 as inte init 0 .
/*def var nv_drivbir1 as char init  "" . */
/*def var nv_drivbir2 as char init  "" . */
def var nv_drivbir3 as char init  "" .
def var nv_drivbir4 as char init  "" .
def var nv_drivbir5 as char init  "" .
def var nv_ntitle   as char init "" .
def var nv_name     as char init "" .
def var nv_lname    as char init "" .
def var nv_drinam   as char init "" .
def var nv_dicno    as char init "" .
def var nv_dgender  as char init "" .
def var nv_dbirth   as char init "" .
def var nv_dage     as INTE init 0 .
def var nv_doccup   as char init "" .
def var nv_ddriveno as char init "" .
def var nv_drivexp  as char init "" .
DEF VAR nv_dlevel   AS INTE INIT 0.
DEF VAR nv_dlevper  AS INTE INIT 0.
DEF VAR nv_dribirth AS CHAR INIT "" .
DEF VAR nv_dconsent AS CHAR INIT "" .
/* end A68-0044 */
