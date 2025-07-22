
/*modify by : Kridtiya i. A54-0351..ปรับค่าเริ่มต้นของ deductpp,deductba,deductpa เป็นค่าว่าง..*/
/*modify by : Kridtiya i. A55-0046..เพิ่ม ฟิล์ด ispno เลขที่ตรวจสภาพ..            */
/*modify by : Kridtiya i. A55-0073..เพิ่ม ฟิล์ด Product Type                      */
/*modify by : Kridtiya i. A55-0257..เพิ่ม ฟิล์ด เลขบัตรประชาชน,อาชีพ,ชื่อผู้ขับขี่*/
/*modify by : Kridtiya i. A54-0112 ขยายช่องทะเบียนรถ จาก 10 เป็น 11 หลัก          */
/*modify by : Kridtiya i. A56-0024 เพิ่มตัวแปรดีเลอร์                             */
/*modify by : Kridtiya i. A57-0063 เพิ่มตัวแปรดีดัก                            */
/*modify by : Phaiboon W. [A59-0488] Date 07/11/2016                             */
/*Modify by : Ranu I. A62-0219 เพิ่มตัวแปรรับค่าจากไฟล์เพิ่ม                    */
/*Modify by   : Kridtiya i. A63-0472 Date. 09/11/2020 add field firstname ,lastname.....*/
/*Modify by   : Ranu I. A64-0138 เพิ่มเงื่อนไขการคำนวณเบี้ยจากโปรแกรมกลาง    */
DEFINE NEW SHARED WORKFILE wdetail2 NO-UNDO  
    FIELD recno            AS CHAR FORMAT "x(10)"  INIT ""  
    FIELD Notify_dat       AS CHAR FORMAT "X(10)"  INIT ""    /*  1  วันที่รับแจ้ง   */                        
    FIELD time_notify      AS CHAR FORMAT "X(10)"  INIT ""    /*  2  วันที่รับเงินค่าเบิ้ยประกัน */            
    FIELD notifyno         AS CHAR FORMAT "X(30)"  INIT ""    /*  3  รายชื่อบริษัทประกันภัย  */                
    FIELD comp_code        AS CHAR FORMAT "X(20)"  INIT ""    /*  4  เลขที่สัญญาเช่าซื้อ */                    
    FIELD NAME_mkt         AS CHAR FORMAT "X(45)"  INIT ""    /*  5  เลขที่กรมธรรม์เดิม  */                    
    FIELD cmbr_no          AS CHAR FORMAT "X(30)"  INIT ""    /*  6  รหัสสาขา    */                            
    FIELD cmbr_code        AS CHAR FORMAT "X(20)"  INIT ""    /*  7  สาขา KK */                                
    FIELD branch           AS CHAR FORMAT "X(10)"  INIT ""    /*  8  เลขรับเเจ้ง */                            
    FIELD producer         AS CHAR FORMAT "X(15)"  INIT ""    /*  9  Campaign    */                            
    FIELD agent            AS CHAR FORMAT "X(15)"  INIT ""    /*  10 Sub Campaign    */                        
    FIELD deler            AS CHAR FORMAT "X(15)"  INIT ""    /*     A56-0024        */ 
    FIELD campaigno        AS CHAR FORMAT "X(20)"  INIT ""    /*  11 บุคคล/นิติบุคคล */                        
    FIELD cov_car          AS CHAR FORMAT "X(20)"  INIT ""    /*  12 คำนำหน้าชื่อ    */                        
    FIELD cov_new          AS CHAR FORMAT "X(20)"  INIT ""    /*  13 ชื่อผู้เอาประกัน    */                    
    FIELD covcod           AS CHAR FORMAT "X(20)"  INIT ""    /*  14 นามสกุลผู้เอาประกัน */  
    FIELD product          AS CHAR FORMAT "X(30)"  INIT ""    /*  Add A55-0073   */
    FIELD freeprem         AS CHAR FORMAT "X(20)"  INIT ""    /*  15 บ้านเลขที่  */                            
    FIELD freecomp         AS CHAR FORMAT "X(20)"  INIT ""    /*  21 ตำบล/แขวง   */                            
    FIELD comdat           AS CHAR FORMAT "X(10)"  INIT ""    /*  22 อำเภอ/เขต   */                            
    FIELD expdat           AS CHAR FORMAT "X(10)"  INIT ""    /*  23 จังหวัด */                                
    FIELD ispno            AS CHAR FORMAT "X(30)"  INIT ""    /*  24 รหัสไปรษณีย์    */ /*A55-0046*/                       
    FIELD pol70            AS CHAR FORMAT "X(20)"  INIT ""    /*  24 รหัสไปรษณีย์    */                        
    FIELD pol72            AS CHAR FORMAT "X(20)"  INIT ""    /*  25 ประเภทความคุ้มครอง  */                    
    FIELD n_TITLE          AS CHAR FORMAT "X(20)"  INIT ""    /*  26 ประเภทการซ่อม   */                        
    FIELD n_name1          AS CHAR FORMAT "X(60)"  INIT ""    /*  27 วันเริ่มคุ้มครอง    */                    
    FIELD ADD_1            AS CHAR FORMAT "X(150)" INIT ""    /*  28 วันสิ้นสุดคุ้มครอง  */                    
    FIELD ADD_2            AS CHAR FORMAT "X(35)"  INIT ""    /*  29 รหัสรถ  */                                
    FIELD ADD_3            AS CHAR FORMAT "X(35)"  INIT ""    /*  30 ประเภทประกันภัยรถยนต์   */                
    FIELD ADD_4            AS CHAR FORMAT "X(35)"  INIT ""    /*  31 ชื่อยี่ห้อรถ    */                        
    FIELD ADD_5            AS CHAR FORMAT "X(10)"  INIT ""    /*  32 รุ่นรถ  */                                
    FIELD tel              AS CHAR FORMAT "X(30)"  INIT ""    /*  33 New/Used    */                            
    FIELD brand            AS CHAR FORMAT "X(20)"  INIT ""    /*  34 เลขทะเบียน  */                            
    FIELD model            AS CHAR FORMAT "X(50)"  INIT ""    /*  35 เลขตัวถัง   */                            
    FIELD engine           AS CHAR FORMAT "X(30)"  INIT ""    /*  36 เลขเครื่องยนต์  */                        
    FIELD chassis          AS CHAR FORMAT "X(30)"  INIT ""    /*  37 ปีรถยนต์    */                            
    FIELD power            AS CHAR FORMAT "X(10)"  INIT ""    /*  38 ซีซี    */                                
    FIELD cyear            AS CHAR FORMAT "X(10)"  INIT ""    /*  39 น้ำหนัก/ตัน */                            
    FIELD licence          AS CHAR FORMAT "X(30)"  INIT ""    /*  40 ทุนประกันปี 1   */                        
    FIELD provin           AS CHAR FORMAT "X(30)"  INIT ""    /*  41 เบี้ยรวมภาษีเเละอากรปี 1    */            
    FIELD subclass         AS CHAR FORMAT "X(10)"  INIT ""    /*  42 ทุนประกันปี 2   */                        
    FIELD garage           AS CHAR FORMAT "X(2)"   INIT ""    /*  43 เบี้ยรวมภาษีเเละอากรปี 2    */            
    FIELD ins_amt1         AS CHAR FORMAT "X(20)"  INIT ""    /*  44 เวลารับเเจ้ง    */ 
    FIELD fi               AS CHAR FORMAT "x(20)"  INIT ""    /*  ทุนสูญหาย */  /*A62-0219*/
    FIELD prem1            AS CHAR FORMAT "X(20)"  INIT ""    /*  45 ชื่อเจ้าหน้าที่ MKT */                    
    FIELD prem2            AS CHAR FORMAT "X(20)"  INIT ""    /*  45 ชื่อเจ้าหน้าที่ MKT */                    
    FIELD comprem          AS CHAR FORMAT "X(20)"  INIT ""    /*  46 หมายเหตุ    */                            
    FIELD prem3            AS CHAR FORMAT "X(20)"  INIT ""    /*  47 ผู้ขับขี่ที่ 1 เเละวันเกิด  */            
    FIELD deduct           AS CHAR FORMAT "X(20)"  INIT ""    /*  Add kridtiya i. A57-0063  */
    FIELD sck              AS CHAR FORMAT "X(20)"  INIT ""    /*  48 ผู้ขับขี่ที่ 2 เเละวันเกิด  */            
    FIELD ref              AS CHAR FORMAT "X(30)"  INIT ""    /*  49 คำนำหน้าชื่อ (ใบเสร็จ/ใบกำกับภาษี)  */    
   /* FIELD recivename       AS CHAR FORMAT "X(60)"  INIT "" */ /*A62-0219*/   /*  50 ชื่อ (ใบเสร็จ/ใบกำกับภาษี)  */            
    FIELD recivename       AS CHAR FORMAT "X(255)"  INIT ""    /*A62-0219*/ 
    FIELD vatcode          AS CHAR FORMAT "X(15)"  INIT ""    /*  51 นามสกุล (ใบเสร็จ/ใบกำกับภาษี)   */        
    FIELD notiuser         AS CHAR FORMAT "X(50)"  INIT ""    /*  52 บ้านเลขที่ (ใบเสร็จ/ใบกำกับภาษี)*/    
    FIELD bennam           AS CHAR FORMAT "X(55)"  INIT ""    /*  57 ตำบล/แขวง (ใบเสร็จ/ใบกำกับภาษี) */        
    FIELD remak1           AS CHAR FORMAT "X(100)" INIT ""    /*  58 อำเภอ/เขต (ใบเสร็จ/ใบกำกับภาษี) */        
    FIELD statusco         AS CHAR FORMAT "X(35)"  INIT ""    /*  59 จังหวัด (ใบเสร็จ/ใบกำกับภาษี)   *//*Add Kridtiya i. A55-0257...*/
    FIELD idno             AS CHAR FORMAT "X(20)"  INIT ""  
    FIELD birthday         AS CHAR FORMAT "X(100)" INIT ""  
    FIELD occupins         AS CHAR FORMAT "X(100)" INIT ""  
    FIELD namedirect       AS CHAR FORMAT "X(100)" INIT ""
    FIELD driv_no          AS CHAR FORMAT "X(20)"  INIT ""
    FIELD drivname1        AS CHAR FORMAT "X(100)" INIT "" 
    FIELD sexdri1          AS CHAR FORMAT "X(6)"   INIT "" 
    FIELD birthdri1        AS CHAR FORMAT "X(10)"  INIT ""  
    FIELD idexpdat         AS CHAR FORMAT "X(10)"  INIT ""  
    FIELD occupdri1        AS CHAR FORMAT "X(50)"  INIT ""  
    FIELD idnodri1         AS CHAR FORMAT "X(20)"  INIT ""  
    FIELD drivname2        AS CHAR FORMAT "X(100)" INIT ""  
    FIELD sexdri2          AS CHAR FORMAT "X(6)"   INIT ""    
    FIELD birthdri2        AS CHAR FORMAT "X(10)"  INIT ""   
    FIELD occupdri2        AS CHAR FORMAT "X(50)"  INIT ""   
    FIELD idnodri2         AS CHAR FORMAT "X(20)"  INIT "" 
    FIELD remak2           AS CHAR FORMAT "X(100)" INIT ""      /* add by Phaiboon W. [A59-0488] Date 07/11/2016 */ 
    FIELD other1           AS CHAR FORMAT "X(50)"  INIT ""      /* add by Phaiboon W. [A59-0488] Date 07/11/2016 */
    FIELD other2           AS CHAR FORMAT "X(10)"  INIT ""      /* add by Phaiboon W. [A59-0488] Date 07/11/2016 */
    FIELD other3           AS CHAR FORMAT "X(60)"  INIT ""      /* add by Phaiboon W. [A59-0488] Date 21/11/2016 */
    FIELD quotation        AS CHAR FORMAT "X(20)"  INIT ""      /* add by Phaiboon W. [A59-0488] Date 15/11/2016 */
    FIELD ngarage          AS CHAR FORMAT "X(20)"  INIT ""      /* add by Phaiboon W. [A59-0488] Date 15/11/2016 */
    FIELD ispstatus        AS CHAR FORMAT "X(1)"   INIT ""     /* add by Phaiboon W. [A59-0488] Date 30/11/2016 */
    FIELD notbr            AS CHAR FORMAT "x(25)"  INIT ""     /* A62-0219 */
    FIELD tp               AS CHAR FORMAT "x(15)"  INIT ""     /* A62-0219 */
    FIELD ta               AS CHAR FORMAT "x(15)"  INIT ""     /* A62-0219 */
    FIELD td               AS CHAR FORMAT "x(15)"  INIT ""     /* A62-0219 */
    FIELD n41              AS CHAR FORMAT "x(15)"  INIT ""     /* A62-0219 */
    FIELD n42              AS CHAR FORMAT "x(15)"  INIT ""     /* A62-0219 */
    FIELD n43              AS CHAR FORMAT "x(15)"  INIT ""     /* A62-0219 */
    FIELD docno            AS CHAR FORMAT "x(10)"  INIT ""     /* A62-0219 */
    FIELD reinsp           AS CHAR FORMAT "x(225)" INIT ""     /* A62-0219 */
    FIELD redbook          AS CHAR FORMAT "x(15)"  INIT "".    /*A62-0219*/
    
    /*Add Kridtiya i. A55-0257...*/     
DEFINE NEW SHARED TEMP-TABLE wdetail
    FIELD cedpol      AS CHAR FORMAT "x(25)"  INIT "" 
    FIELD campaigno   AS CHAR FORMAT "X(20)"  INIT ""     /*  11 บุคคล/นิติบุคคล */                        
    FIELD notiuser    AS CHAR FORMAT "X(50)"  INIT ""     /*  52 บ้านเลขที่ (ใบเสร็จ/ใบกำกับภาษี)    */    
    FIELD branch      AS CHAR FORMAT "x(10)"  INIT ""    
    /*comment by Kridtiya i. A55-0257.....               
    FIELD entdat      AS CHAR FORMAT "x(10)"  INIT ""     /*entry date*/
    FIELD enttim      AS CHAR FORMAT "x(8)"   INIT ""     /*entry time*/
    FIELD trandat     AS CHAR FORMAT "x(10)"  INIT ""     /*tran date*/
    FIELD trantim     AS CHAR FORMAT "x(8)"   INIT ""     /*tran time*/
    end ....by Kridtiya i. A55-0257.....*/
    FIELD vatcode     AS CHAR FORMAT "x(10)"  INIT ""     /*A55-0046*/
    FIELD poltyp      AS CHAR FORMAT "x(3)"   INIT ""     /*policy type*/
    FIELD policy      AS CHAR FORMAT "x(20)"  INIT ""     /*policy*//*a40166 chg format from 12 to 16*/
    /*FIELD prepol      AS CHAR FORMAT "x(20)"  INIT ""*/ /*renew policy*/ /*a40166 chg format from 12 to 16*/
    FIELD comdat      AS CHAR FORMAT "x(10)"  INIT ""     /*comm date*/
    FIELD expdat      AS CHAR FORMAT "x(10)"  INIT ""     /*expiry date*/
    FIELD compul      AS CHAR FORMAT "x"      INIT ""     /*compulsory*/
    FIELD tiname      AS CHAR FORMAT "x(15)"  INIT ""     /*title*/
    FIELD insnam      AS CHAR FORMAT "x(50)"  INIT ""     /*name*/
    FIELD iadd1       AS CHAR FORMAT "x(150)" INIT ""    
    FIELD iadd2       AS CHAR FORMAT "x(35)"  INIT ""    
    FIELD iadd3       AS CHAR FORMAT "x(35)"  INIT ""    
    FIELD iadd4       AS CHAR FORMAT "x(35)"  INIT ""    
    FIELD prempa      AS CHAR FORMAT "x"      INIT ""     /*premium package*/
    FIELD subclass    AS CHAR FORMAT "x(3)"   INIT ""     /*sub class*/
    FIELD brand       AS CHAR FORMAT "x(30)"  INIT ""
    FIELD model       AS CHAR FORMAT "x(50)"  INIT ""
    FIELD cc          AS CHAR FORMAT "x(10)"  INIT ""
    FIELD weight      AS CHAR FORMAT "x(10)"  INIT ""
    FIELD seat        AS CHAR FORMAT "x(2)"   INIT ""
    FIELD body        AS CHAR FORMAT "x(20)"  INIT ""
    /*FIELD vehreg      AS CHAR FORMAT "x(10)"  INIT ""      *//*A54-0112*/
    FIELD vehreg      AS CHAR FORMAT "x(11)"  INIT ""     /*vehicl registration*//*A54-0112*/
    FIELD engno       AS CHAR FORMAT "x(25)"  INIT ""     /*engine no*/
    FIELD chasno      AS CHAR FORMAT "x(25)"  INIT ""     /*chasis no*/
    FIELD caryear     AS CHAR FORMAT "x(4)"   INIT ""     
    FIELD vehuse      AS CHAR FORMAT "x"      INIT ""     /*vehicle use*/
    FIELD garage      AS CHAR FORMAT "x"      INIT ""     
    FIELD stk         AS CHAR FORMAT "x(15)"  INIT ""     
    FIELD access      AS CHAR FORMAT "x"      INIT ""     /*accessories*/
    FIELD covcod      AS CHAR FORMAT "x"      INIT ""     /*cover type*/
    FIELD product     AS CHAR FORMAT "X(30)"  INIT ""     /*  Add A55-0073   */
    FIELD si          AS CHAR FORMAT "x(25)"  INIT ""     /*sum insure*/
    FIELD volprem     AS CHAR FORMAT "x(20)"  INIT ""     /*voluntory premium*/
    /*FIELD fleet       AS CHAR FORMAT "x(10)"  INIT ""*/ /*fleet*//*A55-0257*/
    FIELD ncb         AS CHAR FORMAT "x(10)"  INIT ""   
    /* FIELD revday      AS CHAR FORMAT "x(10)"  INIT ""  *//*A55-0257*/  
    FIELD deductpp    AS CHAR FORMAT "x(10)"  INIT ""    /*deduct da*/
    FIELD deductba    AS CHAR FORMAT "x(10)"  INIT ""    /*deduct da*/
    FIELD deductpa    AS CHAR FORMAT "x(10)"  INIT ""   /*deduct pd*/
    FIELD benname     AS CHAR FORMAT "x(100)" INIT ""   /*benificiary*/
    FIELD n_IMPORT    AS CHAR FORMAT "x(2)"   INIT ""     
    FIELD n_export    AS CHAR FORMAT "x(2)"   INIT ""     
    /*FIELD drivnam     AS CHAR FORMAT "x" INIT ""        
    FIELD drivnam1    AS CHAR FORMAT "x(50)" INIT ""    /*driver name1*/*/
    FIELD cancel      AS CHAR FORMAT "x(2)"   INIT ""     /*cancel*/
    FIELD WARNING     AS CHAR FORMAT "X(30)"  INIT ""
    FIELD comment     AS CHAR FORMAT "x(512)" INIT ""   /*a490166 add format from 100 to 512*/
    FIELD seat41      AS INTE FORMAT "99"     INIT 0         
    FIELD pass        AS CHAR FORMAT "x"      INIT "n"       
    FIELD OK_GEN      AS CHAR FORMAT "X"      INIT "Y"        
    FIELD comper      AS CHAR INIT "50000"    FORMAT ">,>>>,>>>,>>>,>>9"                  
    FIELD comacc      AS CHAR INIT "50000"    FORMAT ">,>>>,>>>,>>>,>>9"                  
    FIELD NO_41       AS CHAR INIT "50000"    FORMAT ">,>>>,>>>,>>>,>>9"                  
    FIELD NO_42       AS CHAR INIT "50000"    FORMAT ">,>>>,>>>,>>>,>>9"                   
    FIELD NO_43       AS CHAR INIT "200000"   FORMAT ">,>>>,>>>,>>>,>>9"                  
    /*FIELD tariff      AS CHAR FORMAT "x(2)"   INIT "" *//* A55-0257 */  
    FIELD baseprem    AS INTE FORMAT ">,>>>,>>>,>>>,>>9" INIT  0
    FIELD deduct      AS INTE FORMAT ">,>>>,>>>,>>>,>>9" INIT  0
    FIELD cargrp      AS CHAR FORMAT "x(2)"  INIT ""      
    FIELD producer    AS CHAR FORMAT "x(10)" INIT ""      
    FIELD agent       AS CHAR FORMAT "x(10)" INIT ""      
    FIELD deler       AS CHAR FORMAT "X(10)"  INIT ""    /*  A56-0024*/
    FIELD premt       AS CHAR FORMAT "x(10)" INIT ""
    FIELD redbook     AS CHAR INIT "" FORMAT "X(8)"     /*note add*/
    FIELD base        AS CHAR INIT "" FORMAT "x(8)"     /*Note add Base Premium 25/09/2006*/
    FIELD accdat      AS CHAR INIT "" FORMAT "x(10)"    /*Account Date For 72*/
    FIELD docno       AS CHAR INIT "" FORMAT "x(10)"    /*Docno For 72*/
    /*FIELD ICNO        AS CHAR INIT "" FORMAT "x(13)"*/    /*ICNO For COVER NOTE A51-0071 amparat*/
    /*FIELD CoverNote   AS CHAR INIT "" FORMAT "x(13)" */   /* ระบุว่าเป็นงาน COVER NOTE A51-0071 amparat*/
    FIELD nmember     AS CHAR INIT "" FORMAT "x(255)" 
    FIELD nmember2    AS CHAR INIT "" FORMAT "x(255)"
    FIELD delerco     AS CHAR FORMAT "x(10)"  INIT ""  
    FIELD remak1      AS CHAR FORMAT "x(100)" INIT ""
    /*FIELD remak2      AS CHAR FORMAT "x(100)" INIT "" *//*A55-0257*/
    FIELD typecar     AS CHAR FORMAT "x(30)"  INIT ""
    FIELD ispno       AS CHAR FORMAT "X(30)"  INIT ""     /*A55-0046*/   
    FIELD idno        AS CHAR FORMAT "X(20)"  INIT ""  
    FIELD birthday    AS CHAR FORMAT "X(100)"  INIT ""  
    FIELD occupins    AS CHAR FORMAT "X(100)" INIT ""   
    FIELD namedirect  AS CHAR FORMAT "X(100)" INIT ""  
    FIELD drivname1   AS CHAR FORMAT "X(100)" INIT "" 
    /*FIELD sexdri1     AS CHAR FORMAT "X(6)"   INIT "" 
    FIELD birthdri1   AS CHAR FORMAT "X(10)"  INIT ""  
    FIELD occupdri1   AS CHAR FORMAT "X(50)"  INIT "" */ 
    FIELD idnodri1    AS CHAR FORMAT "X(20)"  INIT ""  
    FIELD drivname2   AS CHAR FORMAT "X(100)" INIT ""  
    /*FIELD sexdri2     AS CHAR FORMAT "X(6)"   INIT ""    
    FIELD birthdri2   AS CHAR FORMAT "X(10)"  INIT ""   
    FIELD occupdri2   AS CHAR FORMAT "X(50)"  INIT ""  */ 
    FIELD idnodri2    AS CHAR FORMAT "X(20)"  INIT ""   
    FIELD notifydat   AS CHAR FORMAT "X(60)"  INIT ""
    FIELD remak2      AS CHAR FORMAT "X(100)" INIT ""      /* add by Phaiboon W. [A59-0488] Date 07/11/2016 */ 
    FIELD prmtxt      AS CHAR FORMAT "X(60)"  INIT ""      /* add by Phaiboon W. [A59-0488] Date 07/11/2016 */
    FIELD quotation   AS CHAR FORMAT "X(40)"  INIT ""      /* add by Phaiboon W. [A59-0488] Date 15/11/2016 */
    FIELD prmtxt2     AS CHAR FORMAT "X(20)"  INIT ""      /* add by Phaiboon W. [A59-0488] Date 21/11/2016 */
    FIELD prmtxt3     AS CHAR FORMAT "X(20)"  INIT ""      /* add by Phaiboon W. [A59-0488] Date 21/11/2016 */
    FIELD ispstatus   AS CHAR FORMAT "X(1)"   INIT ""     /* add by Phaiboon W. [A59-0488] Date 30/11/2016 */
    FIELD notbr       AS CHAR FORMAT "x(25)"  INIT ""     /* A62-0219 */
    FIELD tp          AS CHAR FORMAT "x(15)"  INIT ""     /* A62-0219 */
    FIELD ta          AS CHAR FORMAT "x(15)"  INIT ""     /* A62-0219 */
    FIELD td          AS CHAR FORMAT "x(15)"  INIT ""     /* A62-0219 */
    FIELD reinsp      AS CHAR FORMAT "x(255)" INIT ""     /* A62-0219 */
    FIELD fi          AS CHAR FORMAT "x(20)"  INIT ""      /*a62-0219*/
    FIELD recivename  AS CHAR FORMAT "x(75)"  INIT ""     /*a62-0219*/
    FIELD recaddr     AS CHAR FORMAT "x(150)" INIT ""     /*a62-0219*/
    FIELD rectax      AS CHAR FORMAT "x(13)"  INIT ""      /*a62-0219*/
    FIELD phone       AS CHAR FORMAT "x(20)"  INIT ""      /* A62-0219 */
    FIELD financecd   AS CHAR FORMAT "x(60)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD firstName   AS CHAR FORMAT "x(60)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD lastName    AS CHAR FORMAT "x(60)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD postcd      AS CHAR FORMAT "x(15)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeocc     AS CHAR FORMAT "x(4)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr1   AS CHAR FORMAT "x(2)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr2   AS CHAR FORMAT "x(2)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr3   AS CHAR FORMAT "x(2)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD br_insured  AS CHAR FORMAT "x(5)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD campaign_ov AS CHAR FORMAT "x(30)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
    FIELD insnamtyp   AS CHAR FORMAT "x(60)" INIT "".  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
DEF VAR nv_postcd     AS CHAR FORMAT "x(25)" INIT "".  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
DEF VAR nv_chkerror   AS CHAR FORMAT "x(250)" INIT "".  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
DEF VAR n_firstdat      AS CHAR FORMAT "x(10)"  INIT ""  .
def    NEW SHARED VAR   nv_message as   char.
DEF VAR nv_riskgp        LIKE sicuw.uwm120.riskgp                                  NO-UNDO.
DEFINE NEW SHARED VAR no_baseprm AS DECI  FORMAT ">>,>>>,>>9.99-". /*note add test Base Premium 25/09/2006*/
DEFINE NEW SHARED VAR NO_basemsg AS CHAR  FORMAT "x(50)" .         /*Warning Error If Not in Range 25/09/2006 */
DEFINE            VAR nv_accdat  AS DATE  FORMAT "99/99/9999" INIT ?  .     
DEFINE            VAR nv_docno   AS CHAR  FORMAT "9999999"    INIT " ".
DEFINE NEW SHARED VAR  nv_batchyr   AS INT FORMAT "9999"            INIT 0.
DEFINE NEW SHARED VAR  nv_batcnt    AS INT FORMAT "99"              INIT 0.
DEFINE NEW SHARED VAR  nv_batchno   AS CHARACTER FORMAT "X(13)"     INIT ""  NO-UNDO.
DEFINE VAR  nv_batrunno  AS INT FORMAT  ">,>>9"          INIT 0.
DEFINE VAR  nv_imppol    AS INT  FORMAT ">>,>>9"         INIT 0.
DEFINE VAR  nv_impprem   AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.
DEFINE VAR  nv_batprev   AS CHARACTER FORMAT "X(13)"     INIT ""  NO-UNDO.
DEFINE VAR  nv_tmppolrun AS INTEGER FORMAT "999"         INIT 0.  /*Temp Policy Running No.*/
DEFINE VAR  nv_batbrn    AS CHARACTER FORMAT "x(2)"      INIT ""  NO-UNDO.  /*Batch Branch*/
DEFINE VAR  nv_tmppol    AS CHARACTER FORMAT "x(16)"     INIT "".  /*Temp Policy*/
DEFINE VAR  nv_rectot    AS INT  FORMAT ">>,>>9"         INIT 0.   /* Display จำนวน ก/ธ ทั้งไฟล์ */
DEFINE VAR  nv_recsuc    AS INT  FORMAT ">>,>>9"         INIT 0.   /* Display จำนวน ก/ธ ที่นำเข้าได้ */
DEFINE VAR  nv_netprm_t  AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.   /* Display เบี้ยรวม ทั้งไฟล์ */
DEFINE VAR  nv_netprm_s  AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.   /* Display เบี้ยรวม ที่นำเข้าได้ */
DEFINE VAR  nv_batflg    AS LOG                          INIT NO.
DEFINE VAR  nv_txtmsg    AS CHAR FORMAT "x(50)"          INIT "".   /* Parameter คู่กับ nv_check */
DEF VAR n_model AS CHAR FORMAT "x(40)".
DEFINE  WORKFILE wuppertxt NO-UNDO
/*1*/  FIELD line     AS INTEGER   FORMAT ">>9"
/*2*/  FIELD txt      AS CHARACTER FORMAT "X(78)"   INITIAL "".
DEFINE  WORKFILE wuppertxt2 NO-UNDO
/*1*/  FIELD line     AS INTEGER   FORMAT ">>9"
/*2*/  FIELD txt      AS CHARACTER FORMAT "X(78)"   INITIAL "".
DEF  VAR n_41   AS DECI     FORMAT ">,>>>,>>9.99" INIT 0.
DEF  VAR n_42   AS DECI     FORMAT ">,>>>,>>9.99" INIT 0.
DEF  VAR n_43   AS DECI     FORMAT ">,>>>,>>9.99" INIT 0.
DEFINE VAR nv_basere   AS DECI        FORMAT ">>,>>>,>>9.99-" INIT 0. 
DEFINE VAR n_sclass72  AS CHAR FORMAT "x(4)".
DEFINE VAR nv_maxdes AS CHAR.
DEFINE VAR nv_mindes AS CHAR.
DEFINE VAR nv_si     AS DECI FORMAT ">>,>>>,>>9.99-".  /* Maximum Sum Insure */
DEFINE VAR nv_maxSI  AS DECI FORMAT ">>,>>>,>>9.99-".  /* Maximum Sum Insure */
DEFINE VAR nv_minSI  AS DECI FORMAT ">>,>>>,>>9.99-".  /* Minimum Sum Insure */
DEFINE VAR nv_newsck AS CHAR FORMAT "x(15)" INIT " ".
DEFINE VAR nv_simat  AS DECI FORMAT ">>>,>>>,>>>,>>9.99-".      
DEFINE VAR nv_simat1  AS DECI FORMAT ">>>,>>>,>>>,>>9.99-".     
DEF VAR nv_uwm301trareg    LIKE sic_bran.uwm301.cha_no INIT "".  
DEF  VAR gv_id AS CHAR FORMAT "X(8)" NO-UNDO.
DEF VAR nv_pwd AS CHAR NO-UNDO.
DEFINE  WORKFILE wuppertxt3 NO-UNDO
/*1*/  FIELD line     AS INTEGER   FORMAT ">>9"
/*2*/  FIELD txt      AS CHARACTER FORMAT "X(78)"   INITIAL "". 
DEFINE VAR n_insref   AS CHARACTER FORMAT "X(10)".  
DEFINE VAR nv_messagein AS CHAR FORMAT "X(200)". 
DEF VAR nv_usrid    AS CHARACTER FORMAT "X(08)".
DEF VAR nv_transfer AS LOGICAL   .
DEF VAR n_check     AS CHARACTER . 
DEF VAR nv_insref   AS CHARACTER FORMAT "X(10)".  
DEF VAR putchr      AS CHAR FORMAT "X(200)" INIT "" NO-UNDO.
DEF VAR putchr1     AS CHAR FORMAT "X(100)" INIT "" NO-UNDO.
DEF VAR nv_typ      AS CHAR FORMAT "X(2)".
DEF BUFFER buwm100   FOR sic_bran.uwm100. 
DEF  STREAM ns1.  
DEF  VAR nv_type  AS INTEGER  LABEL "Type".   
DEF VAR dod0      AS DECI.    /*A57-0063*/    
DEF VAR dod1      AS DECI.    /*A57-0063*/            
DEF VAR dod2      AS DECI.    /*A57-0063*/             
DEF VAR dpd0      AS DECI.    /*A57-0063*/            
DEF VAR nv_quota   AS CHAR.    /* add by Phaiboon W. [A59-0488] Date 16/11/2016 */
DEF VAR nv_prmtxt1 AS CHAR.    /* add by Phaiboon W. [A59-0488] Date 21/11/2016 */
DEF VAR nv_prmtxt2 AS CHAR.    /* add by Phaiboon W. [A59-0488] Date 21/11/2016 */
DEF VAR nv_prmchk  AS DEC.     /* add by Phaiboon W. [A59-0488] Date 21/11/2016 */
DEF VAR nv_polmaster AS CHAR FORMAT "x(35)" INIT "" .  /*A62-0219*/
/* add by A62-0219 */
def var n_address  as char format "x(50)".
def var n_build    as char format "x(50)".
def var n_mu       as char format "x(50)".
def var n_soi      as char format "x(50)".
def var n_road     as char format "x(50)".
def var n_tambon   as char format "x(50)".
def var n_amper    as char format "x(50)".
def var n_country  as char format "x(50)".
def var n_post     as char format "x(50)".
DEF VAR n_length   AS INT.
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
/* end A62-0219*/
/*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/

DEF VAR nv_stm_per  AS DECIMAL FORMAT ">9.99" INITIAL 0 NO-UNDO.
DEF VAR nv_tax_per  AS DECIMAL FORMAT ">9.99" INITIAL 0 NO-UNDO.
DEF VAR nv_com1_per AS DECIMAL FORMAT ">9.99" INITIAL 0 NO-UNDO.
DEF VAR nv_com1_prm AS DECIMAL FORMAT ">>>>>9.99-"      NO-UNDO.
DEF VAR s_130bp1    AS RECID                            NO-UNDO.
DEF VAR s_130fp1    AS RECID                            NO-UNDO.
DEF VAR nvffptr     AS RECID                            NO-UNDO.
DEF VAR n_rd132     AS RECID                            NO-UNDO.
DEF VAR nv_gap      AS DECIMAL                          NO-UNDO.
DEF VAR nv_fptr     AS RECID.
DEF VAR nv_bptr     AS RECID.
DEF VAR nv_gap2     AS DECIMAL                          NO-UNDO.
DEF VAR nv_prem2    AS DECIMAL                          NO-UNDO.
DEF VAR nv_rstp     AS DECIMAL                          NO-UNDO.
DEF VAR nv_rtax     AS DECIMAL                          NO-UNDO.
DEF VAR nv_key_a    AS DECIMAL INITIAL 0                NO-UNDO.
DEF VAR nv_rec100   AS RECID .
DEF VAR nv_rec120   AS RECID .
DEF VAR nv_rec130   AS RECID .
DEF VAR nv_rec301   AS RECID .
DEFINE VAR nv_txt1    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt2    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt3    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt4    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt5    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt6    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt7    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt8    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_line1   AS INTEGER   INITIAL 0            NO-UNDO.
DEF VAR nv_nptr     AS RECID.
DEF VAR n_index AS INTE INIT 0 .
DEF VAR n_index2 AS INTE INIT 0.
DEF VAR nc_r2    AS CHAR FORMAT "x(20)" INIT "".
/*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/


/* add by : A64-0138 */
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

/* end A64-0138 */

