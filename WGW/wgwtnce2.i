/*------------------------------------------------------------------------*/
/*programid   : wgwtnce2.i                                               */
/*programname : Match File Thanachat                                    */
/* Copyright  : Safety Insurance Public Company Limited 			     */
/*			    บริษัท ประกันคุ้มภัย จำกัด (มหาชน)				         */
/*create by   : Ranu I. A61-0512 date 31/10/2018           
                เก็บตัวแปรของโปรแกรม Match File comfirm ธนชาต            */
/*Modify by   : Kridtiya i. A60-0160 Date. 15/08/2023 nCOLOR mobile  receipaddr  sendaddr  notifycode salenotify */     
                                                    
/*************************************************************************/
 
 DEFINE NEW SHARED TEMP-TABLE wrec NO-UNDO
     FIELD not_date      AS CHAR FORMAT "X(15)"  INIT ""    /*วันที่รับแจ้ง           */
     FIELD Notify_no     AS CHAR FORMAT "X(18)"  INIT ""    /*เลขที่รับแจ้ง           */
     FIELD Account_no    AS CHAR FORMAT "X(20)"  INIT ""    /*สาขา – เลขที่สัญญา */  
     FIELD not_office    AS CHAR FORMAT "X(35)"  INIT ""    /*ชื่อประกันภัย         *//*ชื่อผู้เอาประกันภัย*/    
     FIELD ctype         AS CHAR FORMAT "X(15)"  INIT ""    /*สมัครใจ/พรบ.            */
     FIELD comdat        AS CHAR FORMAT "X(15)"  INIT ""    /*วันที่เริ่มคุ้มครอง*/      
     FIELD expdat        AS CHAR FORMAT "X(15)"  INIT ""    /*วันที่สิ้นสุด           */
     FIELD prem          AS CHAR FORMAT "X(15)"  INIT ""    /*ค่าเบี้ยประกันภัยรวม*/     
     FIELD paydate       AS CHAR FORMAT "X(15)"  INIT ""    /*วันที่ลูกค้าชำระเบี้ยครั้งสุดท้าย*/
     FIELD prevpol       AS CHAR FORMAT "x(15)"  INIT ""    /*A60-0383*/
     FIELD loss          AS CHAR FORMAT "x(10)"  INIT ""    /*A60-0383*/
     FIELD remark        AS CHAR FORMAT "X(15)"  INIT ""
     field company       as char format "x(100)" INIT ""     /*บริษัทประกันเก่า        */       
     field ben_name      as char format "x(60)"  INIT ""            /*ผู้รับผลประโยชน์        */       
     field licence       as char format "x(13)"  init ""      /*เลขทะเบียน              */       
     field province      as char format "x(25)"  init ""      /*จังหวัด                 */       
     field ins_amt       as char format "x(15)"  init ""      /*ทุนประกัน               */       
     field prem1         as char format "x(15)"  init ""      /*เบี้ยประกันสุทธิ        */       
     field not_name      as char format "x(75)"  init ""      /*ชื่อประกันภัย           */       
     field brand         as char format "x(35)"  init ""      /*ยี่ห้อ                  */       
     field Brand_Model   as char format "x(60)"  init ""      /*รุ่น                    */       
     field yrmanu        as char format "x(4)"  init ""      /*ปี                      */       
     field weight        as char format "x(6)"  init ""      /*ขนาดเครื่อง             */       
     field engine        as char format "x(50)"  init ""      /*เลขเครื่อง              */       
     field chassis       as char format "x(50)"  init ""      /*เลขถัง                  */       
     field pattern       as char format "x(100)"  init ""      /*Pattern Rate            */       
     field covcod        as char format "x(3)"  init ""      /*ประเภทประกัน            */       
     field vehuse        as char format "x(50)"  init ""      /*ประเภทรถ                */       
     field sclass        as char format "x(5)"  init ""      /*รหัสรถ                  */       
     field garage        as char format "x(10)"  init ""      /*สถานที่ซ่อม             */       
     field drivename1    as char format "x(100)"  init ""      /*ระบุผู้ขับขี่1          */       
     field driveid1      as char format "x(13)"  init ""      /*เลขที่ใบขับขี่1         */       
     field driveic1      as char format "x(13)"  init ""      /*เลขที่บัตรประชาชน1      */       
     field drivedate1    as char format "x(15)"  init ""      /*วันเดือนปีเกิด1         */       
     field drivname2     as char format "x(100)"  init ""      /*ระบุผู้ขับขี่2          */       
     field driveid2      as char format "x(13)"  init ""      /*เลขที่ใบขับขี่2         */       
     field driveic2      as char format "x(13)"  init ""      /*เลขที่บัตรประชาชน2      */       
     field drivedate2    as char format "x(15)"  init ""      /*วันเดือนปีเกิด2         */       
     field cl            as char format "x(10)"  init ""      /*ส่วนลดประวัติเสีย       */       
     field fleetper      as char format "x(10)"  init ""      /*ส่วนลดกลุ่ม             */       
     field ncbper        as char format "x(10)"  init ""      /*ประวัติดี               */       
     field othper        as char format "x(10)"  init ""      /*อื่น ๆ                  */       
     field pol_addr1     as char format "x(150)"  init ""      /*ที่อยู่ลูกค้า           */       
     field icno          as char format "x(13)"  init ""      /*IDCARD                  */       
     field icno_st       as char format "x(15)"  init ""      /*DateCARD_S              */       
     field icno_ex       as char format "x(15)"  init ""      /*DateCARD_E              */       
     field bdate         as char format "x(15)"  init ""      /*Birth Date              */       
     field paidtyp       as char format "x(25)"  init ""      /*Type_Paid_1             */       
     field paid          as char format "x(15)"  init ""      /*Paid_Amount             */       
     field prndate       as char format "x(15)"  init ""      /*วันที่พิมพ์ พรบ.        */       
     field sckno         as char format "x(35)"  init ""       /*เลขสติกเกอร์ / เลข กธ.  */
     field nCOLOR        as char format "x(50)"   init ""    /*A66-0160*/
     field mobile        as char format "x(50)"   init ""    /*A66-0160*/
     field receipaddr    as char format "x(150)"  init ""    /*A66-0160*/
     field sendaddr      as char format "x(150)"  init ""    /*A66-0160*/
     field notifycode    as char format "x(50)"   init ""    /*A66-0160*/
     field salenotify    as char format "x(150)"  init ""   /*A66-0160*/
     field ACCESSORY     as char format "x(250)"  init "".   /*A66-0160*/
