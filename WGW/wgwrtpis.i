/*program_id   : wgwrtpis.w                                               */ 
/*programname  : Load text file TIL-RE to GW  -สำหรับงานต่ออายุ           */ 
/* Copyright  : Safety Insurance Public Company Limited                   */  
/*                            บริษัท ประกันคุ้มภัย จำกัด (มหาชน)          */  
/*create by   : Ranu I. A58-0489 เปลี่ยน format file นำเข้าข้อมูลใหม่     */
/*Modify By   : Nontamas H. [A62-0329] Date 08/07/2019
                 - เพิ่ม Field Docno ใน Temp-Table wdetail2               */
/*Modify by  : Ranu I. A62-0422 date:10/09/2019 เพิ่มตัวแปรเก็บค่าการซ่อม */
/*Modify by  : Kridtiya i. A63-0370 Date.21/08/2020 เพิ่มบรรทัด F18       */
/*              และรายละเอียดรถ                                           */
/*Modify by  : Kridtiya i. A63-0472 Date. 09/11/2020 add field firstname ,lastname.....*/
/*Modify by  : Ranu I. A64-0344 เพิ่มตัวแปรการคำนวณเบี้ยจากโปรแกรมกลาง    */
/*Modify by   : Ranu I. A64-0138 เพิ่มตัวแปรเก็บค่าการคำนวณเบี้ย          */
/*Modify by  : Ranu I. A64-0177  เพิ่มตัวแปรเก็บเบี้ยจากใบเตือน           */
/*Modify by  : Ranu I. A66-0252 เพิ่มตัวแปรเก็บค่าตามไฟล์โหลด */
/*Modify by  : Kridtiya i. A68-0044 Date. 02/05/2025 Add driver for ICF */
/*----- start : A58-0489----*/ 
DEFINE NEW SHARED TEMP-TABLE wdetail2 NO-UNDO  
   FIELD ins_ytyp                AS CHAR FORMAT "x(20)"         INIT ""      /*ประเภทงาน = ต่ออายุงานใหม่*/
   FIELD bus_typ                 AS CHAR FORMAT "x(20)"         INIT ""      /*ประเภทธุรกิจ */
   FIELD TASreceived             AS CHAR FORMAT "x(100)"        INIT ""      /*ผู้ติดต่องาน*/     
   FIELD InsCompany              AS CHAR FORMAT "x(20)"         INIT ""      /*ชื่อบริษัทประกัน*/ 
   FIELD Insurancerefno          AS CHAR FORMAT "x(20)"         INIT ""      /*เลขที่รับแจ้งชั่วคราว*/
   FIELD tpis_no                 AS CHAR FORMAT "x(11)"         INIT ""      /*เลขที่สัญญา*/
   FIELD ntitle                  AS CHAR FORMAT "x(20)"         INIT ""      /*คำนำหน้าชื่อ*/
   FIELD insnam                  AS CHAR FORMAT "x(100)"        INIT ""      /*ชื่อ*/
   FIELD NAME2                   AS CHAR FORMAT "x(100)"        INIT ""      /*สกุล*/   
   FIELD cust_type               AS CHAR FORMAT "x(1)"          INIT ""      /*ประเภทลูกค้า = บุคคล, นิติบุลคล */
   FIELD nDirec                  AS CHAR FORMAT "x(100)"        INIT ""      /*บุคคล = ""  นิติบุลคล <> "" */
   FIELD ICNO                    AS CHAR FORMAT "x(20)"         INIT ""      /*เลขประชาชน*/
   FIELD address                 AS CHAR FORMAT "x(50)"         INIT ""      /*บ้านเลขที่*/
   FIELD build                   AS CHAR FORMAT "x(50)"         INIT ""      /*อาคาร*/
   FIELD mu                      AS CHAR FORMAT "x(50)"         INIT ""      /*หมู่บ้าน*/
   FIELD soi                     AS CHAR FORMAT "x(50)"         INIT ""      /*ซอย*/
   FIELD road                    AS CHAR FORMAT "x(50)"         INIT ""      /*ถนน*/
   FIELD tambon                  AS CHAR FORMAT "x(50)"         INIT ""      /*ตำบล*/
   FIELD amper                   AS CHAR FORMAT "x(50)"         INIT ""      /*อำเภอ*/
   FIELD country                 AS CHAR FORMAT "x(50)"         INIT ""      /*จังหวัด*/
   FIELD post                    AS CHAR FORMAT "x(50)"         INIT ""      /*รหัสไปรษณีย์*/
   FIELD brand                   AS CHAR FORMAT "x(30)"         INIT ""      /*ยี่ห้อ*/
   FIELD model                   AS CHAR FORMAT "x(30)"         INIT ""      /*รุ่นรถ*/
   FIELD class                   AS CHAR FORMAT "x(20)"          INIT ""      /*รหัสบริษัทประกัน*/
   FIELD md_year                 AS CHAR FORMAT "x(20)"          INIT ""      /*ปีรุ่นรถ*/
   FIELD Usage                   AS CHAR FORMAT "x(100)"        INIT ""      /*ประเภทการใช้รถ*/
   FIELD coulor                  AS CHAR FORMAT "x(30)"         INIT ""      /*สีรถ*/
   FIELD cc                      AS CHAR FORMAT "x(20)"          INIT ""      /* น้ำหนัก CC.*/
   FIELD regis_year              AS CHAR FORMAT "x(20)"          INIT ""      /*ข้อมูลรถปี*/
   FIELD engno                   AS CHAR FORMAT "x(40)"         INIT ""      /*เลขตัวถัง*/
   FIELD chasno                  AS CHAR FORMAT "x(25)"         INIT ""      /*เลข Chassis*/
   /*FIELD Acc_CV                  AS CHAR FORMAT "x(100)"        INIT ""   */   /*อุปกรณ์เสริม*/ /*A66-0252*/
   FIELD Acc_CV                  AS CHAR FORMAT "x(300)"        INIT ""     /*อุปกรณ์เสริม*/ /*A66-0252*/
   FIELD Acc_amount              AS CHAR FORMAT "x(100)"         INIT ""      /*ราคาอุปกรณ์*/
   FIELD License                 AS CHAR FORMAT "x(20)"         INIT ""      /*ทะเบียน*/
   FIELD regis_CL                AS CHAR FORMAT "x(100)"         INIT ""      /*จังหวัดที่จดทะเบียน*/
   FIELD campaign                AS CHAR FORMAT "x(100)"         INIT ""      /*ชื่อแคมเปญ*/
   FIELD typ_work                AS CHAR FORMAT "x(20)"         INIT ""      /* กรมธรรม์ 70 ,72*/
   FIELD si                      AS CHAR FORMAT "X(20)"         INIT ""      /* ทุนประกัน */
   FIELD pol_comm_date           AS CHAR FORMAT "X(20)"         INIT ""      /*วันคุ้มครองของ กธ.*/
   FIELD pol_exp_date            AS CHAR FORMAT "x(20)"         INIT ""      /*วันหมดอายุของ กธ.*/
   FIELD prvpol                  AS CHAR FORMAT "x(20)"         INIT ""      /* กรมธรรม์เดิม */
   FIELD cover                   AS CHAR FORMAT "x(20)"          INIT ""      /*ประเภทความคุ้มครอง ป.1 2 3 2+ 3+*/
   FIELD pol_netprem             AS CHAR FORMAT "X(15)"         INIT ""      /*เบี้ยสุทธิ (กธ.)*/
   FIELD pol_gprem               AS CHAR FORMAT "X(15)"         INIT ""      /*เบียรวม (กธ.)*/
   FIELD pol_stamp               AS CHAR FORMAT "X(15)"         INIT ""      /*แสตมป์ (กธ.)*/
   FIELD pol_vat                 AS CHAR FORMAT "X(15)"         INIT ""      /*Vat (กธ.)*/
   FIELD pol_stamp_ho            AS CHAR FORMAT "X(15)"         INIT ""      /*แสตมป์ (กธ.) ho */  /*A61-0152*/
   FIELD pol_vat_ho              AS CHAR FORMAT "X(15)"         INIT ""      /*Vat (กธ.) ho */     /*A61-0152*/
   FIELD pol_wht                 AS CHAR FORMAT "X(15)"         INIT ""      /*wht (กธ.)*/
   FIELD com_no                  AS CHAR FORMAT "x(20)"         INIT ""      /* เบอร์ พรบ.*/
   FIELD docno                   AS CHAR FORMAT "x(10)"         INIT ""      /*Docno For 72*/  /**Add By Nontamas H. [A62-0329] Date 08/07/2019****/
   FIELD stkno                   AS CHAR FORMAT "x(35)"         INIT ""      /* เลขสติ๊กเกอร์.*/
   FIELD com_comm_date           AS CHAR FORMAT "X(20)"         INIT ""      /* วันที่คุ้มครอง พรบ.*/
   FIELD com_exp_date            AS CHAR FORMAT "X(20)"         INIT ""      /* วันที่หมดอายุ พรบ.*/
   FIELD com_netprem             AS CHAR FORMAT "x(15)"         INIT ""      /* เบี้ยสุทธิ พรบ.*/
   FIELD com_gprem               AS CHAR FORMAT "x(15)"         INIT ""      /* เบี้ยรวม พรบ.*/
   FIELD com_stamp               AS CHAR FORMAT "x(15)"         INIT ""      /* แสตมป์ พรบ.*/
   FIELD com_vat                 AS CHAR FORMAT "X(15)"         INIT ""      /* vat พรบ.*/
   FIELD com_wht                 AS CHAR FORMAT "x(15)"         INIT ""      /* wht พรบ.*/
   FIELD deler                   AS CHAR FORMAT "x(200)"         INIT ""      /* ตัวแทน */
   FIELD showroom                AS CHAR FORMAT "x(200)"         INIT ""      /* โชว์รูม */
   FIELD typepay                 AS CHAR FORMAT "x(20)"         INIT ""      /*ประเภทการชำระเงิน*/
   FIELD financename             AS CHAR FORMAT "x(200)"         INIT ""      /*ผู้รับผลประโยชน์*/           
   FIELD mail_hno                AS CHAR FORMAT "x(50)"         INIT ""      /*ที่อยู่จัดส่ง*/               
   FIELD mail_build              AS CHAR FORMAT "x(50)"         INIT ""      /*ที่อยู่จัดส่ง*/               
   FIELD mail_mu                 AS CHAR FORMAT "x(50)"         INIT ""      /*ที่อยู่จัดส่ง*/               
   FIELD mail_soi                AS CHAR FORMAT "x(50)"         INIT ""      /*ที่อยู่จัดส่ง*/               
   FIELD mail_road               AS CHAR FORMAT "x(50)"         INIT ""      /*ที่อยู่จัดส่ง*/               
   FIELD mail_tambon             AS CHAR FORMAT "x(50)"         INIT ""      /*ที่อยู่จัดส่ง*/               
   FIELD mail_amper              AS CHAR FORMAT "x(50)"         INIT ""      /*ที่อยู่จัดส่ง*/               
   FIELD mail_country            AS CHAR FORMAT "x(50)"         INIT ""      /*ที่อยู่จัดส่ง*/               
   FIELD mail_post               AS CHAR FORMAT "x(50)"         INIT ""      /*ที่อยู่จัดส่ง*/               
   FIELD send_date               AS CHAR FORMAT "x(20)"         INIT ""      /*วันที่จัดส่งกรมธรรม์*/        
   FIELD policy_no               AS CHAR FORMAT "x(20)"         INIT ""      /* เบอร์กรมธรรม์*/              
   FIELD send_data               AS CHAR FORMAT "x(20)"         INIT ""      /*วันที่จัดส่งข้อมูลให้ TPIS*/  
   /*FIELD REMARK1                 AS CHAR FORMAT "x(200)"        INIT ""  */    /*หมายเหตุ*/      /*A66-0252*/  
   FIELD REMARK1                 AS CHAR FORMAT "x(300)"        INIT ""      /*หมายเหตุ*/      /*A66-0252*/  
   FIELD occup                   AS CHAR FORMAT "x(20)"         INIT ""      /*อาชีพ*/                       
   FIELD regis_no                AS CHAR FORMAT "x(20)"         INIT ""      /*เลขที่ลงทะเบียน*/ 
   FIELD np_f18line1             AS CHAR FORMAT "x(60)"         INIT "" 
   FIELD np_f18line2             AS CHAR FORMAT "x(60)"         INIT "" 
   FIELD np_f18line3             AS CHAR FORMAT "x(60)"         INIT "" 
   FIELD np_f18line4             AS CHAR FORMAT "x(60)"         INIT "" 
   FIELD np_f18line5             AS CHAR FORMAT "x(60)"         INIT ""
   FIELD np_f18line6             AS CHAR FORMAT "x(200)"        INIT ""  /*a61-0152*/
   FIELD np_f18line7             AS CHAR FORMAT "x(200)"        INIT "" /*Kridtiya .21/08/2020*/
   FIELD np_f18line8             AS CHAR FORMAT "x(200)"        INIT "" /*Kridtiya .21/08/2020*/
   FIELD np_f18line9             AS CHAR FORMAT "x(200)"        INIT "" /* A66-0252 */
   FIELD pol_typ                 AS CHAR FORMAT "x(3)"          INIT "" 
   FIELD financename2            AS CHAR FORMAT "x(10)"         INIT ""     
   FIELD branch                  AS CHAR FORMAT "x(10)"         INIT ""     
   FIELD baseprm                 AS CHAR FORMAT "x(10)"         INIT "" 
   FIELD delerco                 AS CHAR FORMAT "x(10)"         INIT "" 
   FIELD dealer_name2            AS CHAR FORMAT "x(60)"         INIT ""
   FIELD agent                   AS CHAR FORMAT  "X(10)"        INIT ""
   FIELD bran_name               AS CHAR FORMAT  "X(30)"        INIT ""    
   FIELD bran_name2              AS CHAR FORMAT  "X(15)"        INIT ""    
   FIELD Region                  AS CHAR FORMAT  "X(20)"        INIT ""
   FIELD Producer                AS CHAR FORMAT  "x(10)"        INIT ""
   FIELD garage                  AS CHAR FORMAT  "x(50)"        INIT ""     /* A62-0422*/
   FIELD desmodel                AS CHAR FORMAT "x(50)"         INIT ""     /* A62-0422*/
   FIELD insnamtyp               AS CHAR FORMAT "x(60)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
   FIELD firstName               AS CHAR FORMAT "x(60)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
   FIELD lastName                AS CHAR FORMAT "x(60)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
   FIELD codeocc                 AS CHAR FORMAT "x(4)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
   FIELD codeaddr1               AS CHAR FORMAT "x(2)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
   FIELD codeaddr2               AS CHAR FORMAT "x(2)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
   FIELD codeaddr3               AS CHAR FORMAT "x(2)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
   FIELD campaign_ov             AS CHAR FORMAT "x(30)" INIT ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
   FIELD financecd               AS CHAR FORMAT "x(30)" INIT ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
   FIELD product                 AS CHAR FORMAT "x(15)" INIT ""   /* A65-0177*/
   FIELD comment                 AS CHAR FORMAT "X(150)" INIT ""   /*A65-0177*/
   FIELD insp                    as char format "x(2)" init ""   /* A66-0252 */
   FIELD ispno                   as char format "x(20)" init ""   /* A66-0252 */
   FIELD detail                  as char format "x(50)" init ""   /* A66-0252 */
   FIELD damage                  as char format "x(255)" init ""   /* A66-0252 */
   FIELD ispacc                  as char format "x(255)" init "" . /* A66-0252 */

/*------ end A58-0489-----*/  
DEFINE NEW SHARED TEMP-TABLE wdetail
    FIELD cedpol       AS CHAR FORMAT "x(20)" INIT "" 
    FIELD branch       AS CHAR FORMAT "x(10)" INIT "" 
    FIELD entdat       AS CHAR FORMAT "x(20)" INIT ""     
    FIELD enttim       AS CHAR FORMAT "x(20)" INIT ""      
    FIELD trandat      AS CHAR FORMAT "x(20)" INIT ""     
    FIELD trantim      AS CHAR FORMAT "x(20)" INIT ""      
    FIELD poltyp       AS CHAR FORMAT "x(3)"  INIT ""      
    FIELD policy       AS CHAR FORMAT "x(20)" INIT ""     
    FIELD prvpol       AS CHAR FORMAT "x(20)" INIT ""     
    FIELD comdat       AS CHAR FORMAT "x(20)" INIT ""     
    FIELD expdat       AS CHAR FORMAT "x(20)" INIT ""     
    FIELD compul       AS CHAR FORMAT "x"     INIT ""         
    FIELD tiname       AS CHAR FORMAT "x(15)" INIT ""     
    FIELD insnam       AS CHAR FORMAT "x(60)" INIT ""  
    FIELD insnam2      AS CHAR FORMAT "x(60)" INIT "" 
    FIELD iadd1        AS CHAR FORMAT "x(160)" INIT ""
    FIELD iadd2        AS CHAR FORMAT "x(50)" INIT ""
    FIELD iadd3        AS CHAR FORMAT "x(50)" INIT ""
    FIELD iadd4        AS CHAR FORMAT "x(50)" INIT ""
    FIELD post         AS CHAR FORMAT "x(10)" INIT ""
    field address      AS CHAR FORMAT "x(160)" INIT "" 
    field tambon       AS CHAR FORMAT "x(50)" INIT ""  
    field amper        AS CHAR FORMAT "x(50)" INIT ""  
    field country      AS CHAR FORMAT "x(50)" INIT ""  
    FIELD prempa       AS CHAR FORMAT "x"     INIT ""         
    FIELD subclass     AS CHAR FORMAT "x(4)"  INIT ""      
    FIELD brand        AS CHAR FORMAT "x(30)" INIT ""
    FIELD model        AS CHAR FORMAT "x(50)" INIT ""
    FIELD cc           AS CHAR FORMAT "x(10)" INIT ""
    FIELD weight       AS CHAR FORMAT "x(10)" INIT ""
    FIELD seat         AS CHAR FORMAT "x(2)"  INIT ""
    FIELD body         AS CHAR FORMAT "x(25)" INIT ""
    /*FIELD vehreg       AS CHAR FORMAT "x(10)" INIT ""    *//*A54-0112 */
    FIELD vehreg       AS CHAR FORMAT "x(11)" INIT ""        /*A54-0112 */
    FIELD engno        AS CHAR FORMAT "x(25)" INIT ""     
    FIELD chasno       AS CHAR FORMAT "x(25)" INIT ""     
    FIELD caryear      AS CHAR FORMAT "x(4)"  INIT ""      
    FIELD carprovi     AS CHAR FORMAT "x(2)"  INIT ""      
    FIELD vehuse       AS CHAR FORMAT "x"     INIT ""         
    FIELD garage       AS CHAR FORMAT "x"     INIT ""         
    FIELD stk          AS CHAR FORMAT "x(15)" INIT ""     
    FIELD access       AS CHAR FORMAT "x"     INIT ""      
    /*FIELD covcod       AS CHAR FORMAT "x"     INIT "" */ /*A61-0152*/
    FIELD covcod       AS CHAR FORMAT "x(3)"     INIT ""  /*A61-0152*/
    FIELD si           AS CHAR FORMAT "x(25)" INIT ""     
    FIELD volprem      AS CHAR FORMAT "x(20)" INIT ""     
    FIELD Compprem     AS CHAR FORMAT "x(20)" INIT ""     
    FIELD fleet        AS CHAR FORMAT "x(10)" INIT ""     
    FIELD ncb          AS CHAR FORMAT "x(10)" INIT "" 
    FIELD revday       AS CHAR FORMAT "x(10)" INIT "" 
    FIELD finint       AS CHAR FORMAT "x(10)" INIT ""
    /* comment by A61-0152.....
    FIELD deductpp     AS CHAR FORMAT "x(10)" INIT "500000"   /*deduct da*/
    FIELD deductba     AS CHAR FORMAT "x(10)" INIT "10000000" /*deduct da*/
    FIELD deductpa     AS CHAR FORMAT "x(10)" INIT "1000000"  /*deduct pd*/
    .... end A61-0152....*/
    FIELD deductpp     AS CHAR FORMAT "x(12)" INIT "" /*a61-0152*/
    FIELD deductba     AS CHAR FORMAT "x(12)" INIT "" /*a61-0152*/
    FIELD deductpa     AS CHAR FORMAT "x(12)" INIT "" /*a61-0152*/
    FIELD benname      AS CHAR FORMAT "x(50)" INIT ""         /*benificiary*/
    FIELD n_user       AS CHAR FORMAT "x(10)" INIT ""         /*user id*/
    FIELD n_IMPORT     AS CHAR FORMAT "x(2)"  INIT ""      
    FIELD n_export     AS CHAR FORMAT "x(2)"  INIT ""      
    FIELD cancel       AS CHAR FORMAT "x(2)" INIT ""         /*cancel*/
    /*FIELD WARNING      AS CHAR FORMAT "X(30)" INIT ""*/  /*A61-0152*/
    FIELD WARNING      AS CHAR FORMAT "X(50)" INIT ""     /*A61-0152*/
    FIELD comment      AS CHAR FORMAT "x(512)"  INIT ""      
    FIELD seat41       AS INTE FORMAT "99" INIT 0         
    FIELD pass         AS CHAR FORMAT "x"  INIT "n"       
    FIELD OK_GEN       AS CHAR FORMAT "X" INIT "Y"  
    /* comment by A61-0152.........
    FIELD comper       AS CHAR INIT "50000"    FORMAT ">,>>>,>>>,>>>,>>9"                  
    FIELD comacc       AS CHAR INIT "50000"    FORMAT ">,>>>,>>>,>>>,>>9"                  
    FIELD NO_41        AS CHAR INIT "50000"   FORMAT ">,>>>,>>>,>>>,>>9"                  
    FIELD NO_42        AS CHAR INIT "50000"   FORMAT ">,>>>,>>>,>>>,>>9"                   
    FIELD NO_43        AS CHAR INIT "200000"  FORMAT ">,>>>,>>>,>>>,>>9"   
    ......end A61-0152....*/  
    /* create by A61-0152 */
    FIELD comper       AS CHAR  INIT ""   FORMAT ">,>>>,>>>,>>>,>>9"                  
    FIELD comacc       AS CHAR  INIT ""   FORMAT ">,>>>,>>>,>>>,>>9"                  
    FIELD NO_411       AS CHAR  INIT ""   FORMAT ">,>>>,>>>,>>>,>>9"  
    FIELD NO_412       AS CHAR  INIT ""   FORMAT ">,>>>,>>>,>>>,>>9" 
    FIELD NO_42        AS CHAR  INIT ""   FORMAT ">,>>>,>>>,>>>,>>9"                   
    FIELD NO_43        AS CHAR  INIT ""   FORMAT ">,>>>,>>>,>>>,>>9"  
    field dspc         as char init "" format ">>>.>9"
    field base3        as char init "" format ">>>,>>9"
    field netprem      as char init "" format ">,>>>,>>9"
    FIELD polmaster   AS CHAR FORMAT "x(40)" INIT "" 
    FIELD loadclm     AS CHAR FORMAT "x(10)" INIT ""  
    FIELD staff       AS CHAR FORMAT "x(10)" INIT ""
    /*....end A61-0152....*/  
    FIELD tariff       AS CHAR FORMAT "x(2)" INIT ""      
    FIELD baseprem     AS INTE INIT  0
    FIELD cargrp       AS CHAR FORMAT "x(2)" INIT ""      
    FIELD producer     AS CHAR FORMAT "x(10)" INIT ""      
    FIELD agent        AS CHAR FORMAT "x(10)" INIT ""      
    FIELD inscod       AS CHAR INIT ""   
    FIELD premt        AS CHAR FORMAT "x(10)" INIT ""
    FIELD redbook      AS CHAR INIT "" FORMAT "X(10)"     /*note add*/
    FIELD base         AS CHAR INIT "" FORMAT "x(8)"      /*Note add Base Premium 25/09/2006*/
    FIELD accdat       AS CHAR INIT "" FORMAT "x(10)"     /*Account Date For 72*/
    FIELD docno        AS CHAR INIT "" FORMAT "x(10)"     /*Docno For 72*/
    FIELD ICNO         AS CHAR INIT "" FORMAT "x(15)"     /*ICNO For COVER NOTE A51-0071 amparat*/
    FIELD CoverNote    AS CHAR INIT "" FORMAT "x(13)"     /* ระบุว่าเป็นงาน COVER NOTE A51-0071 amparat*/
    FIELD sendnam      AS CHAR FORMAT "x(50)"  INIT ""    
    FIELD chkcar       AS CHAR FORMAT "x(50)"  INIT ""    
    FIELD telno        AS CHAR FORMAT "x(30)"  INIT ""    
    FIELD insrefno     AS CHAR FORMAT "x(10)"  INIT ""    
    /*FIELD prmtxt       AS CHAR FORMAT "x(225)" INIT ""   */ /* A66-0252*/ 
    FIELD prmtxt       AS CHAR FORMAT "x(300)" INIT ""    /* A66-0252*/
    FIELD instyp       AS CHAR INIT "" FORMAT "x"        /*A56-0217*/
    FIELD promo        AS CHAR INIT "" FORMAT "x(20)"    /*A58-0489*/  
    FIELD nDirec       AS CHAR INIT "" FORMAT "x(60)"    /*A58-0489*/
    FIELD firstdat     AS CHAR INIT "" FORMAT "x(20)"    /*A58-0489*/
    /*FIELD Remark       AS CHAR INIT "" FORMAT "x(200)"  */  /*A58-0489*/ /*A66-0252*/
    FIELD Remark       AS CHAR INIT "" FORMAT "x(300)"    /*A66-0252*/
    FIELD cr_2         AS CHAR FORMAT "x(15)" INIT ""    /*A58-0489*/
    FIELD cuts_typ     AS CHAR FORMAT "x(2)" INIT ""     
    FIELD occup        AS CHAR FORMAT "x(50)" INIT ""    
    FIELD engine       AS CHAR FORMAT "x(10)" INIT ""    /*A61-0152*/
    FIELD accdata      AS CHAR FORMAT "x(200)" INIT ""   /*A61-0152*/ 
    FIELD accamount    AS CHAR FORMAT "x(10)"  INIT ""   /*A61-0152*/ 
    field campens      as char format "X(50)"  init ""   /*A61-0152*/   
    field memotext     as char format "X(50)"  init ""   /*A61-0152*/  
    field vatcode      as char format "X(10)"  init ""   /*A61-0152*/  
    field name02       as char format "X(50)"  init ""   /*A61-0152*/   
    FIELD ton          AS CHAR FORMAT "x(5)"   INIT ""     /*A61-0152*/
    FIELD firstName    AS CHAR FORMAT "x(60)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD lastName     AS CHAR FORMAT "x(60)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD postcd       AS CHAR FORMAT "x(15)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeocc      AS CHAR FORMAT "x(4)"   INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr1    AS CHAR FORMAT "x(2)"   INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr2    AS CHAR FORMAT "x(2)"   INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr3    AS CHAR FORMAT "x(2)"   INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD br_insured   AS CHAR FORMAT "x(5)"   INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD campaign_ov  AS CHAR FORMAT "x(30)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
    FIELD insnamtyp    AS CHAR FORMAT "x(60)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD financecd    AS CHAR FORMAT "x(30)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD product      AS CHAR FORMAT "x(15)"  INIT ""   /* A65-0177*/
    FIELD colorcar     AS CHAR FORMAT "x(25)"  INIT ""   /* A66-0252 */
    FIELD insp         as char format "x(2)" init ""   /* A66-0252 */
    FIELD ispno        as char format "x(20)" init ""   /* A66-0252 */
    FIELD detail       as char format "x(50)" init ""   /* A66-0252 */
    FIELD damage       as char format "x(255)" init ""   /* A66-0252 */
    FIELD ispacc       as char format "x(255)" init "" . /* A66-0252 */

DEFINE NEW SHARED WORKFILE wdetmemo NO-UNDO
    FIELD policymemo   AS CHAR FORMAT "x(12)"  INIT ""
    FIELD f18line1     AS CHAR FORMAT "x(60)"  INIT ""  
    FIELD f18line2     AS CHAR FORMAT "x(60)"  INIT ""  
    FIELD f18line3     AS CHAR FORMAT "x(60)"  INIT "" 
    FIELD f18line4     AS CHAR FORMAT "x(60)"  INIT "" 
    FIELD f18line5     AS CHAR FORMAT "x(60)"  INIT "" 
    FIELD f18line6     AS CHAR FORMAT "x(60)"  INIT ""  
    FIELD f18line7     AS CHAR FORMAT "x(60)"  INIT ""  
    FIELD f18line8     AS CHAR FORMAT "x(60)"  INIT ""
    /* A66-0252 */
    FIELD f18line9     AS CHAR FORMAT "x(60)"  INIT ""  
    FIELD ispno        as char format "x(20)" init "" 
    FIELD detail       as char format "x(50)" init "" 
    FIELD damage       as char format "x(255)" init "" 
    FIELD ispacc       as char format "x(255)" init "" .
    /* end : A66-0252 */

DEF NEW SHARED VAR     nv_message as   char.
DEF VAR nv_riskgp      LIKE sicuw.uwm120.riskgp  NO-UNDO.
/***--- Note Add Condition Base Premium ---***/
DEFINE NEW SHARED VAR no_baseprm  AS DECI  FORMAT ">>,>>>,>>9.99-".   /*note add test Base Premium 25/09/2006*/
DEFINE NEW SHARED VAR NO_basemsg  AS CHAR  FORMAT "x(50)" .           /*Warning Error If Not in Range 25/09/2006 */
DEFINE            VAR nv_accdat   AS DATE  FORMAT "99/99/9999" INIT ?  .     
DEFINE            VAR nv_docno    AS CHAR  FORMAT "9999999"    INIT " ".
DEFINE NEW SHARED VAR nv_batchyr  AS INT   FORMAT "9999"       INIT 0.
DEFINE NEW SHARED VAR nv_batcnt   AS INT   FORMAT "99"         INIT 0.
DEFINE NEW SHARED VAR nv_batchno  AS CHARACTER FORMAT "X(13)"  INIT ""  NO-UNDO.
DEFINE VAR  nv_batrunno  AS INT FORMAT  ">,>>9"          INIT 0.
DEFINE VAR  nv_imppol    AS INT  FORMAT ">>,>>9"         INIT 0.
DEFINE VAR  nv_impprem   AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.
DEFINE VAR  nv_batprev   AS CHARACTER FORMAT "X(13)"     INIT ""  NO-UNDO.
DEFINE VAR  nv_tmppolrun AS INTEGER FORMAT "999"         INIT 0.           /*Temp Policy Running No.*/
DEFINE VAR  nv_batbrn    AS CHARACTER FORMAT "x(2)"      INIT ""  NO-UNDO. /*Batch Branch*/
DEFINE VAR  nv_tmppol    AS CHARACTER FORMAT "x(16)"     INIT "".          /*Temp Policy*/
DEFINE VAR  nv_rectot    AS INT  FORMAT ">>,>>9"         INIT 0.           /* Display จำนวน ก/ธ ทั้งไฟล์ */
DEFINE VAR  nv_recsuc    AS INT  FORMAT ">>,>>9"         INIT 0.           /* Display จำนวน ก/ธ ที่นำเข้าได้ */
DEFINE VAR  nv_netprm_t  AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.           /* Display เบี้ยรวม ทั้งไฟล์ */
DEFINE VAR  nv_netprm_s  AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.           /* Display เบี้ยรวม ที่นำเข้าได้ */
DEFINE VAR  nv_batflg    AS LOG                          INIT NO.
DEFINE VAR  nv_txtmsg    AS CHAR FORMAT "x(50)"          INIT "".          /* Parameter คู่กับ nv_check */
DEFINE VAR  n_model      AS CHAR FORMAT "x(40)".
DEF VAR nv_export      AS char FORMAT "X(8)"    INIT "" .            /* A56-0262 */
DEF VAR ns_policyrenew AS CHAR FORMAT "x(30)"   INIT "" .            /* A56-0262 */       
DEF VAR ns_policy72    AS CHAR FORMAT "x(30)"   INIT "" .            /* A56-0262 */
DEFINE VAR  nv_driver    AS CHARACTER FORMAT "X(23)" INITIAL ""  .   /*A57-0010*/
DEFINE NEW SHARED WORKFILE ws0m009 NO-UNDO                           /*A57-0010*/
/*1*/  FIELD policy     AS CHARACTER    INITIAL ""                   /*A57-0010*/
/*2*/  FIELD lnumber    AS INTEGER                                   /*A57-0010*/
       FIELD ltext      AS CHARACTER    INITIAL ""                   /*A57-0010*/
       FIELD ltext2     AS CHARACTER    INITIAL "" .                 /*A57-0010*/
DEF VAR nv_drivage1 AS INTE INIT 0.                                  /*A57-0010*/
DEF VAR nv_drivage2 AS INTE INIT 0.                                  /*A57-0010*/
DEF VAR nv_nptr    AS RECID.                                         /*A57-0010*/
DEFINE  WORKFILE wuppertxt3 NO-UNDO                                  /*A57-0010*/
/*1*/  FIELD line     AS INTEGER   FORMAT ">>9"                      /*A57-0010*/
/*2*/  FIELD txt      AS CHARACTER FORMAT "X(78)"   INITIAL "".      /*A57-0010*/
DEFINE  WORKFILE wcomp NO-UNDO                                            /*A57-0010*/
/*1*/      FIELD package     AS CHARACTER FORMAT "X(10)"   INITIAL ""     /*A57-0010*/
/*2*/      FIELD premcomp    AS DECI FORMAT "->>,>>9.99"    INITIAL 0.    /*A57-0010*/
DEFINE VAR  n_insref     AS CHARACTER FORMAT "X(10)". 
DEFINE VAR  nv_messagein AS CHAR FORMAT "X(200)". 
DEFINE VAR  nv_usrid     AS CHARACTER FORMAT "X(08)".
DEFINE VAR  nv_transfer  AS LOGICAL   .
DEFINE VAR  n_check      AS CHARACTER .
DEFINE VAR  nv_insref    AS CHARACTER FORMAT "X(10)".  
DEFINE VAR  putchr       AS CHAR FORMAT "X(200)" INIT "" NO-UNDO.
DEFINE VAR  putchr1      AS CHAR FORMAT "X(100)" INIT "" NO-UNDO.
DEFINE VAR  nv_typ       AS CHAR FORMAT "X(2)".
/*--------A58-0489-------------*/
DEFINE new shared VAR  re_branch    AS CHAR FORMAT "x(3)" INIT "".
DEFINE new shared VAR  re_insno     AS CHAR FORMAT "x(11)" INIT "".
DEFINE new shared VAR  re_firstdat  AS CHAR FORMAT "x(15)" INIT "".
DEFINE new shared VAR  re_comdat    AS CHAR FORMAT "x(10)" INIT "" .        
DEFINE new shared VAR  re_expdat    AS CHAR FORMAT "x(10)" INIT "" .        
/*DEFINE new shared VAR  re_class     AS CHAR FORMAT "x(4)"      .*/   /*A66-0252*/
DEFINE new shared VAR  re_class     AS CHAR FORMAT "x(5)"      .  /*A66-0252*/
DEFINE new shared VAR  re_moddes    AS CHAR FORMAT "x(65)".                 
DEFINE new shared VAR  re_yrmanu    AS CHAR FORMAT "x(5)".
DEFINE new shared VAR  re_seats     AS CHAR FORMAT "x(2)"   INIT "" .       
DEFINE new shared VAR  re_vehuse    AS CHAR FORMAT "x"      INIT "" .       
/*DEFINE VAR  re_covcod    AS CHAR FORMAT "x"      INIT "" . */  /*A61-0152*/
DEFINE new SHARED VAR  re_covcod    AS CHAR FORMAT "x(3)"   INIT "" .       /*A61-0152*/
DEFINE new SHARED VAR  re_garage    AS CHAR FORMAT "x"      INIT "" .       
DEFINE new SHARED VAR  re_vehreg    AS CHAR FORMAT "x(11)"  INIT "" .       
DEFINE new SHARED VAR  re_cha_no    AS CHAR FORMAT "x(30)"  INIT "" .       
DEFINE new SHARED VAR  re_eng_no    AS CHAR FORMAT "x(30)"  INIT "" .       
DEFINE new SHARED VAR  re_uom1_v    AS char FORMAT ">>>,>>>,>>9.99-"  .      
DEFINE new SHARED VAR  re_uom2_v    AS char FORMAT ">>>,>>>,>>9.99-"  . 
DEFINE new SHARED VAR  re_uom5_v    AS char FORMAT ">>>,>>>,>>9.99-"  . 
DEFINE new SHARED VAR  re_si        AS CHAR FORMAT ">>>,>>>,>>9.99-"  .      
DEFINE new SHARED VAR  re_baseprm   AS DECI FORMAT ">>>,>>>,>>9.99-"  . 
DEFINE new SHARED VAR  re_baseprm3  AS DECI FORMAT ">>>,>>>,>>9.99-"  .  /*A61-0152*/ 
DEFINE new SHARED VAR  re_41        AS DECI FORMAT ">>>,>>>,>>9.99-"  .     
DEFINE new SHARED VAR  re_42        AS DECI FORMAT ">>>,>>>,>>9.99-"  .     
DEFINE new SHARED VAR  re_43        AS DECI FORMAT ">>>,>>>,>>9.99-"  .     
DEFINE new SHARED VAR  re_seat41    AS DECI FORMAT ">>,>>9.99-"   .         
DEFINE new SHARED VAR  re_dedod     AS DECI FORMAT ">>>,>>>,>>9.99-"  .     
DEFINE new SHARED VAR  re_addod     AS DECI FORMAT ">>>,>>>,>>9.99-"  .     
DEFINE new SHARED VAR  re_dedpd     AS DECI FORMAT ">>>,>>>,>>9.99-"  .     
DEFINE new SHARED VAR  re_flet_per  AS char FORMAT ">>>,>>>,>>9.99-"  .         
DEFINE new SHARED VAR  re_ncbper    AS char FORMAT ">>>,>>>,>>9.99-"  .         
DEFINE new SHARED VAR  re_dss_per   AS CHAR FORMAT ">>>,>>>,>>9.99-"  .    
DEFINE new SHARED VAR  re_stf_per   AS DECI FORMAT ">>>,>>>,>>9.99-"  .     
DEFINE new SHARED VAR  re_cl_per    AS DECI FORMAT ">>>,>>>,>>9.99-"  . 
DEFINE new SHARED VAR  re_prem      AS DECI FORMAT ">>>,>>>,>>9.99-"  .    /*A61-0152*/
DEFINE new SHARED VAR  re_bennam1   AS CHAR FORMAT "x(60)"  INIT ""   .
DEFINE VAR  re_year          AS CHAR .      /*A66-0252*/
DEFINE VAR  re_chassic       AS CHAR .      /*A66-0252*/
DEFINE VAR  re_rencnt        AS INTE .      /*A66-0252*/
DEF VAR n_status    AS LOGICAL.
DEF VAR n_statuscomp    AS CHAR INIT "".
DEF VAR n_statuspol     AS CHAR INIT "".
DEFINE NEW SHARED TEMP-TABLE wuwd132 
    FIELD prepol  AS CHAR FORMAT "x(20)" INIT "" 
    FIELD bencod  AS CHAR FORMAT "x(30)" INIT "" 
    FIELD benvar  AS CHAR FORMAT "x(40)" INIT "" 
    FIELD gap_ae  AS LOGICAL INIT NO      /* A65-0177*/
    FIELD pd_aep  AS CHAR    INIT "E"     /* A65-0177*/
    FIELD gap_c   AS DECI FORMAT ">>>,>>>,>>9.99-"    
    FIELD prem_c  AS DECI FORMAT ">>>,>>>,>>9.99-"  . 
DEF VAR nv_acc6 AS CHAR FORMAT "x(60)" INIT "".      
DEF VAR nv_acc1 AS CHAR FORMAT "x(60)" INIT "".      
DEF VAR nv_acc2 AS CHAR FORMAT "x(60)" INIT "".      
DEF VAR nv_acc3 AS CHAR FORMAT "x(60)" INIT "".      
DEF VAR nv_acc4 AS CHAR FORMAT "x(60)" INIT "".      
DEF VAR nv_acc5 AS CHAR FORMAT "x(255)" INIT "". 
/*A61- 0152*/
DEF VAR nv_cc AS CHAR FORMAT "x(10)" INIT "" . 
DEF VAR nv_yr AS INT  INIT 0 . 

DEFINE new shared VAR   nt_gapprm     AS DECI      FORMAT ">>,>>>,>>9.99-"  INITIAL 0.
DEFINE new shared VAR   nt_pdprm      AS DECI      FORMAT ">>,>>>,>>9.99-"  INITIAL 0.
DEFINE new shared VAR   nv_adjgap     AS DECI      FORMAT ">>,>>>,>>9.99-".
DEFINE new shared VAR   nv_adjpd      AS DECI      FORMAT ">>,>>>,>>9.99-".
DEFINE NEW SHARED VAR   nv_prem3       AS DECIMAL  FORMAT ">,>>>,>>9.99-" INITIAL 0  NO-UNDO.
DEFINE NEW SHARED VAR   nv_sicod3      AS CHAR     FORMAT "X(4)".
DEFINE NEW SHARED VAR   nv_usecod3     AS CHAR     FORMAT "X(4)".
DEFINE NEW SHARED VAR   nv_siprm3      AS DECI     FORMAT ">>,>>>,>>9.99-".
DEFINE NEW SHARED VAR   nv_prvprm3     AS DECI     FORMAT ">>,>>>,>>9.99-".
DEFINE NEW SHARED VAR   nv_baseprm3    AS DECI     FORMAT ">>,>>>,>>9.99-".
DEFINE NEW SHARED VAR   nv_useprm3     AS DECI     FORMAT ">>,>>>,>>9.99-".
DEFINE NEW SHARED VAR   nv_basecod3    AS CHAR     FORMAT "X(4)".
DEFINE NEW SHARED VAR   nv_basevar3    AS CHAR     FORMAT "X(60)".
DEFINE NEW SHARED VAR   nv_basevar4    AS CHAR     FORMAT "X(30)".
DEFINE NEW SHARED VAR   nv_basevar5    AS CHAR     FORMAT "X(30)".
DEFINE NEW SHARED VAR   nv_usevar3     AS CHAR     FORMAT "X(60)".
DEFINE NEW SHARED VAR   nv_usevar4     AS CHAR     FORMAT "X(30)".
DEFINE NEW SHARED VAR   nv_usevar5     AS CHAR     FORMAT "X(30)".
DEFINE NEW SHARED VAR   nv_sivar3      AS CHAR     FORMAT "X(60)".
DEFINE NEW SHARED VAR   nv_sivar4      AS CHAR     FORMAT "X(30)".
DEFINE NEW SHARED VAR   nv_sivar5      AS CHAR     FORMAT "X(30)".

DEFINE  VAR      nv_adjvar   AS CHAR FORMAT "X(60)".
/*DEFINE VAR nv_gap    AS INTEGER   INITIAL 0  NO-UNDO.*/
DEFINE VAR nv_prem_c AS INTEGER   INITIAL 0  NO-UNDO.
/*DEFINE VAR nv_prem   AS INTEGER   INITIAL 0  NO-UNDO.*/
DEFINE VAR nv_bencod AS CHARACTER INITIAL "" NO-UNDO.
DEFINE VAR nv_line   AS INTEGER   INITIAL 0  NO-UNDO.
DEFINE VAR   nv_benvar   AS CHARACTER         NO-UNDO.  
DEFINE VAR nv_lgar   AS INTEGER   INITIAL 0  NO-UNDO.
DEFINE VAR nv_lgar_c AS INTEGER   INITIAL 0  NO-UNDO.
DEFINE NEW SHARED WORKFILE wk_uwd132  LIKE brstat.wkuwd132.
/* add by A62-0422 */
DEFINE VAR nv_pdprm0   AS DECI FORMAT ">>,>>>,>>9.99-"  INITIAL 0 .    
DEFINE new  SHARED VAR   nv_totlcod  AS CHAR  FORMAT "X(4)".
DEFINE new  SHARED VAR   nv_totlprm  AS DECI  FORMAT ">>,>>>,>>9.99-".
DEFINE new  SHARED VAR   nv_totlvar1 AS CHAR  FORMAT "X(30)".
DEFINE new  SHARED VAR   nv_totlvar2 AS CHAR  FORMAT "X(30)".
DEFINE new  SHARED VAR   nv_totlvar  AS CHAR  FORMAT "X(60)".
DEFINE NEW  SHARED VAR   nv_44prm    AS INTEGER   FORMAT ">,>>>,>>9"  INITIAL 0 no-undo.
DEFINE new  SHARED VAR   nv_44cod1   AS CHAR      FORMAT "X(4)".
DEFINE new  SHARED VAR   nv_44cod2   AS CHAR      FORMAT "X(4)".
DEFINE new  SHARED VAR   nv_44       AS INTE      FORMAT ">>>,>>>,>>9".
DEFINE new  SHARED VAR   nv_413prm   AS DECI      FORMAT ">,>>>,>>9.99".
DEFINE new  SHARED VAR   nv_413var1  AS CHAR      FORMAT "X(30)".
DEFINE new  SHARED VAR   nv_413var2  AS CHAR      FORMAT "X(30)".
DEFINE new  SHARED VAR   nv_413var   AS CHAR      FORMAT "X(60)".
DEFINE new  SHARED VAR   nv_414prm   AS DECI      FORMAT ">,>>>,>>9.99".
DEFINE new  SHARED VAR   nv_414var1  AS CHAR      FORMAT "X(30)".
DEFINE new  SHARED VAR   nv_414var2  AS CHAR      FORMAT "X(30)".
DEFINE new  SHARED VAR   nv_414var   AS CHAR      FORMAT "X(60)".
DEFINE new  SHARED VAR   nv_supecod  AS CHAR  FORMAT "X(4)".
DEFINE new  SHARED VAR   nv_supeprm  AS DECI  FORMAT ">>,>>>,>>9.99-".
DEFINE new  SHARED VAR   nv_supevar1 AS CHAR  FORMAT "X(30)".
DEFINE new  SHARED VAR   nv_supevar2 AS CHAR  FORMAT "X(30)".
DEFINE new  SHARED VAR   nv_supevar  AS CHAR  FORMAT "X(60)".
DEFINE new  SHARED VAR   nv_supe00   AS DECI  FORMAT ">>,>>>,>>9.99-".
DEFINE VAR               nv_chkerror AS CHAR  FORMAT "X(150)".   /*Add by Kridtiya i. A63-0472*/
DEFINE VAR               re_producerexp   AS CHAR . /*A63-00472*/
DEFINE VAR               re_dealerexp     AS CHAR . /*A63-00472*/

/* add by : A64-0344 */
DEFINE NEW SHARED TEMP-TABLE wkuwd132 LIKE stat.pmuwd132.
DEF    VAR nv_cstflg  AS CHAR FORMAT "X(2)".     /*C=CC ; S=Seat ; T=Tons ; W=Watts*/  
DEFINE VAR nv_engcst  AS DECI FORMAT ">>>>>9.99".

DEFINE VAR nv_driage1 AS INTE FORMAT ">>9".
DEFINE VAR nv_driage2 AS INTE FORMAT ">>9".
/*DEFINE VAR nv_pdprm0  AS DECI FORMAT ">>>,>>>,>>9.99-".*/
DEFINE VAR nv_yrmanu  AS INTE FORMAT "9999".

DEFINE VAR nv_vehgrp  AS CHAR FORMAT "X(3)".
DEFINE VAR nv_access  AS CHAR FORMAT "X(3)".
DEFINE VAR nv_supe    AS LOGICAL.
DEFINE VAR nv_totfi   AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_tpbi1si AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_tpbi2si AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_tppdsi  AS DECI FORMAT ">>>,>>>,>>9.99-".

DEFINE VAR nv_411si   AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_412si   AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_413si   AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_414si   AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_42si    AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_43si    AS DECI FORMAT ">>>,>>>,>>9.99-".

DEFINE VAR nv_ncbp    AS DECI FORMAT ">,>>9.99-".
DEFINE VAR nv_fletp   AS DECI FORMAT ">,>>9.99-".
DEFINE VAR nv_dspcp   AS DECI FORMAT ">,>>9.99-".
DEFINE VAR nv_dstfp   AS DECI FORMAT ">,>>9.99-".
DEFINE VAR nv_clmp    AS DECI FORMAT ">,>>9.99-".


DEFINE VAR nv_netprem AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_gapprem AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_flagprm AS CHAR FORMAT "X(2)". /* N=Net,G=Gross */

DEFINE VAR nv_effdat  AS DATE FORMAT "99/99/9999".

DEFINE VAR nv_ratatt       AS DECI FORMAT ">>,>>>,>>9-".
DEFINE VAR nv_siatt        AS DECI FORMAT ">>,>>>,>>9-".
DEFINE VAR nv_netatt       AS DECI FORMAT ">>,>>>,>>9-".
DEFINE VAR nv_fltatt       AS DECI FORMAT ">>,>>>,>>9-".
DEFINE VAR nv_ncbatt       AS DECI FORMAT ">>,>>>,>>9-".
DEFINE VAR nv_dscatt       AS DECI FORMAT ">>,>>>,>>9-".
DEFINE VAR nv_fcctv        AS LOGICAL . 
define var nv_uom1_c       as char .
define var nv_uom2_c       as char .
define var nv_uom5_c       as char .
DEFINE VAR nv_41prmt   AS DECI FORMAT ">>>,>>>,>>9.99-".  /* fleet */
DEFINE VAR nv_42prmt   AS DECI FORMAT ">>>,>>>,>>9.99-".  /* fleet */
DEFINE VAR nv_43prmt   AS DECI FORMAT ">>>,>>>,>>9.99-".  /* fleet */
DEFINE VAR nv_pdprem   AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_status   AS CHAR .   /*fleet YES=Complete , NO=Not Complete */
 
/* end A64-0344*/

