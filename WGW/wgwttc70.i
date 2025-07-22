/*programid   : wgwttc70.i                                               */
/*programname : load text file Tisco to GW                               */
/* Copyright  : Safety Insurance Public Company Limited 			     */
/*			    บริษัท ประกันคุ้มภัย จำกัด (มหาชน)				         */
/*create by   : Kridtiya i. A56-0323  date . 19/11/2013            
                ปรับโปรแกรมให้สามารถนำเข้า text file tisco to GW system  */
/*modify by   : Kridtiya i. A57-0017 add column seat , first date        */
/*modify by   : Ranu I. a61-0410 03/09/2018 เพิ่มตัวแปร cedpol           */
/*modify by   : Sarinya C. A63-0210 26/05/2020 เพิ่มตัวแปร อุปกรณ์เสริม  */
/*Modify by   : Kridtiya i. A63-0472 Date. 09/11/2020 add field firstname ,lastname.....*/
/*Modify by   : Ranu I. A64-0138 เพิ่มตัวแปรเก็บค่าการคำนวณเบี้ย */
/*Modify by   : Kridtiya i. A65-0364 เพิ่ม เลขแคมเปญ เพื่อเก็บที่ Product */
/*Modify by   : Kridtiya i. A65-0356 Date. 07/01/2023 ขยายช่อง เลขเครื่องเลขถัง ทะเบียน สี */
/*Modify by   : Ranu I. A67-0114 เพิ่มตัวแปรเก็บข้อมูลรถไฟฟ้า */
/*Modify by   : Ranu I. A67-0185 ขยายตัวแปร Class             */
/*Modify by   : Ranu I. A68-0044 เพิ่มตัวแปรการส่งค่าคำนวณเบี้ย */
/*************************************************************************/
DEF VAR Pro_off         AS CHAR FORMAT "x(2)"   INIT ""  .                                            
DEF VAR cmr_code        AS CHAR FORMAT "x(5)"   INIT ""  .                                            
DEF VAR comcode         AS CHAR FORMAT "x(3)"   INIT ""  .                                             
DEF VAR policyno        AS CHAR FORMAT "x(25)"  INIT ""  .                                    
DEF VAR caryear         AS CHAR FORMAT "x(4)"   INIT ""  .                                      
/*DEF VAR engno           AS CHAR FORMAT "x(25)"  INIT ""  . /*A65-0356*/                                   
DEF VAR chasno          AS CHAR FORMAT "x(25)"  INIT ""  . *//*A65-0356*/  
DEF VAR engno           AS CHAR FORMAT "x(35)"  INIT ""  .   /*A65-0356*/                                   
DEF VAR chasno          AS CHAR FORMAT "x(35)"  INIT ""  .   /*A65-0356*/ 
DEF VAR weight          AS CHAR FORMAT "x(7)"   INIT ""  .                                      
DEF VAR power           AS CHAR FORMAT "x(7)"   INIT ""  .                                      
/*DEF VAR colorcode       AS CHAR FORMAT "x(20)"  INIT ""  . /*A65-0356*/                                 
DEF VAR vehreg          AS CHAR FORMAT "x(11)"  INIT ""  . *//*A65-0356*/ 
DEF VAR colorcode       AS CHAR FORMAT "x(25)"  INIT ""  .   /*A65-0356*/                               
DEF VAR vehreg          AS CHAR FORMAT "x(20)"  INIT ""  .   /*A65-0356*/ 
DEF VAR garage          AS CHAR FORMAT "x(1)"   INIT ""  .                                             
DEF VAR fleetper        AS CHAR FORMAT "X(5)"   INIT ""  .                                          
DEF VAR ncb             AS CHAR FORMAT "X(5)"   INIT ""  .                                            
DEF VAR orthper         AS CHAR FORMAT "X(5)"   INIT ""  .                                          
DEF VAR vehuse          AS CHAR FORMAT "x(1)"   INIT ""  .                                             
DEF VAR comdat          AS CHAR FORMAT "x(10)"  INIT ""  .                                  
DEF VAR si              AS CHAR FORMAT "x(20)"  INIT ""  .                                           
DEF VAR name_insur      AS CHAR FORMAT "x(20)"  INIT ""  .                                 
DEF VAR not_office      AS CHAR FORMAT "x(75)"  INIT ""  .    
DEF VAR entdat          AS CHAR FORMAT "x(10)"  INIT ""  .                                    
DEF VAR enttim          AS CHAR FORMAT "x(8)"   INIT ""  .                                    
DEF VAR not_code        AS CHAR FORMAT "x(4)"   INIT ""  .                                         
DEF VAR premt           AS CHAR FORMAT "x(15)"  INIT ""  .                                                  
DEF VAR comp_prm        AS CHAR FORMAT "x(10)"  INIT ""  .                                                  
DEF VAR stk             AS CHAR FORMAT "x(25)"  INIT ""  .                                                  
DEF VAR brand           AS CHAR FORMAT "x(50)"  INIT ""  .                                                  
DEF VAR addr1           AS CHAR FORMAT "x(100)" INIT ""  .                                                  
DEF VAR addr2           AS CHAR FORMAT "x(100)" INIT ""  .                                                  
DEF VAR titlename       AS CHAR FORMAT "x(30)"  INIT ""  .                                                  
DEF VAR firstname       AS CHAR FORMAT "x(60)"  INIT ""  .   
DEF VAR lastname        AS CHAR FORMAT "x(55)"  INIT ""  .                                              
DEF VAR benefic         AS CHAR FORMAT "x(65)"  INIT ""  .    
DEF VAR remark          AS CHAR FORMAT "x(150)" INIT ""  .   
DEF VAR accountno       AS CHAR FORMAT "x(50)"  INIT ""  .   
DEF VAR clientNo        AS CHAR FORMAT "x(20)"  INIT ""  .   
DEF VAR expirydate      AS CHAR FORMAT "x(10)"  INIT ""  .                                    
DEF VAR insuranceamt    AS CHAR FORMAT "x(20)"  INIT ""  .                                         
DEF VAR province        AS CHAR FORMAT "X(30)"  INIT ""  .                                  
DEF VAR receiptname     AS CHAR FORMAT "x(100)" INIT ""  .                                 
DEF VAR agentcode       AS CHAR FORMAT "x(20)"  INIT ""  .                                           
DEF VAR compaprev       AS CHAR FORMAT "x(50)"  INIT ""  .   
DEF VAR oldpolicy       AS CHAR FORMAT "x(50)"  INIT ""  .                                       
DEF VAR deduct          AS CHAR FORMAT "x(10)" INIT "" .                                                                  
DEF VAR addr1_70        AS CHAR FORMAT "x(2)"  INIT "" .                                                                
DEF VAR addr2_70        AS CHAR FORMAT "x(5)"  INIT "" .                                                                
DEF VAR addr1_70tambon  AS CHAR FORMAT "x(30)" INIT "" .                                                                
DEF VAR addr1_70amper   AS CHAR FORMAT "x(30)" INIT "" .                                                                
DEF VAR addr1_70country AS CHAR FORMAT "x(5)"  INIT "" .                                                                
DEF VAR addr1_70post    AS CHAR FORMAT "x(14)" INIT "" .   
DEF VAR addr1_72        AS CHAR FORMAT "x(75)" INIT "" .   
DEF VAR addr2_72        AS CHAR FORMAT "x(10)" INIT "" .   
DEF VAR addr1_72tambon  AS CHAR FORMAT "x(75)" INIT "" .   
DEF VAR addr1_72amper   AS CHAR FORMAT "x(10)" INIT "" .    
DEF VAR addr1_72country AS CHAR FORMAT "x(10)" INIT "" .  
DEF VAR addr1_72post    AS CHAR FORMAT "x(10)" INIT "" .     
DEF VAR Applitype       AS CHAR FORMAT "x(10)" INIT "" .  
DEF VAR Applicode       AS CHAR FORMAT "x(10)" INIT "" .      
DEF VAR Blank_tis       AS CHAR FORMAT "x(60)" INIT "" .     
/*DEF VAR package         AS CHAR FORMAT "x(4)"  INIT "" . */ /*A67-0185*/
DEF VAR package         AS CHAR FORMAT "x(5)"  INIT "" .     /*A67-0185*/
DEF VAR seatnew         AS CHAR FORMAT "x(4)"  INIT "".    /*A57-0017*/
DEF VAR TPBIPerson      AS CHAR FORMAT "x(20)" INIT "" .     
DEF VAR TPBIPerAcc      AS CHAR FORMAT "X(20)" INIT "" .     
DEF VAR TPPDPerAcc      AS CHAR FORMAT "x(20)" INIT "" . 
DEF VAR covcod          AS CHAR FORMAT "x"     INIT "" .   
DEF VAR Producer        AS CHAR FORMAT "x(10)" INIT "" .   
DEF VAR Agent           AS CHAR FORMAT "X(10)" INIT "" .   
DEF VAR Branch          AS CHAR FORMAT "x(2)"  INIT "" .   
DEF VAR typepoli        AS CHAR FORMAT "X(15)" INIT "" . 

DEF VAR Price_Ford      AS CHAR FORMAT "X(20)" INIT "" . 
DEF VAR Year_fd         AS CHAR FORMAT "X(10)" INIT "" . 
DEF VAR Brand_Model     AS CHAR FORMAT "X(60)" INIT "" . 
DEF VAR id_no70         AS CHAR FORMAT "x(13)" INIT "" . 
DEF VAR id_nobr70       AS CHAR FORMAT "x(20)" INIT "" . 
DEF VAR id_no72         AS CHAR FORMAT "x(13)" INIT "" . 
DEF VAR id_nobr72       AS CHAR FORMAT "x(20)" INIT "" . 
DEF VAR comp_comdat     AS CHAR FORMAT "X(8)"  INIT "" . 
DEF VAR comp_expdat     AS CHAR FORMAT "X(8)"  INIT "" . 
DEF VAR fi              AS CHAR FORMAT "X(11)" INIT "" . 
/*DEF VAR class           AS CHAR FORMAT "X(3)"  INIT "" . */ /*A67-0185*/
DEF VAR class           AS CHAR FORMAT "X(5)"  INIT "" .  /*A67-0185*/
DEF VAR usedtype        AS CHAR FORMAT "x(1)"  INIT "" . 

DEF VAR driveno1        AS CHAR FORMAT "x(2)"  INIT "" . 
DEF VAR drivename1      AS CHAR FORMAT "x(40)" INIT "" . 
DEF VAR bdatedriv1      AS CHAR FORMAT "x(8)"  INIT "" . 
DEF VAR occupdriv1      AS CHAR FORMAT "x(75)" INIT "" . 
DEF VAR positdriv1      AS CHAR FORMAT "X(40)" INIT "" . 
DEF VAR driveno2        AS CHAR FORMAT "x(2)"  INIT "".  
DEF VAR drivename2      AS CHAR FORMAT "x(40)" INIT "" . 
DEF VAR bdatedriv2      AS CHAR FORMAT "x(8)"  INIT "" . 
DEF VAR occupdriv2      AS CHAR FORMAT "x(75)" INIT "" . 
DEF VAR positdriv2      AS CHAR FORMAT "X(40)" INIT "" . 
DEF VAR driveno3        AS CHAR FORMAT "x(2)"  INIT "" . 
DEF VAR drivename3      AS CHAR FORMAT "x(40)" INIT "" . 
DEF VAR bdatedriv3      AS CHAR FORMAT "x(8)"  INIT "" . 
DEF VAR occupdriv3      AS CHAR FORMAT "x(75)" INIT "" . 
DEF VAR positdriv3      AS CHAR FORMAT "X(40)" INIT "" . 
DEF VAR caracc          AS CHAR FORMAT "x(250)" INIT "" .     /*A63-0210*/
DEF VAR Rec_name72      AS CHAR FORMAT "x(150)" INIT "" .    /*A63-0210*/
DEF VAR Rec_add1        AS CHAR FORMAT "x(60)"  INIT "" .    /*A63-0210*/
DEF VAR Rec_add2        AS CHAR FORMAT "x(60)"  INIT "" .    /*A63-0210*/
DEF VAR Reciept72       AS CHAR FORMAT "x(60)"  INIT "" .    /*A63-0210*/
DEF VAR nv_campid       AS CHAR FORMAT "x(60)"  INIT "" .    /*A65-0364*/
/* A67-0114 */
def var pol_sta  as char format "x(20)" init "" .
def var birthdate   as char format "x(20)" init "" .
def var  Schanel    AS Char FORMAT "X(1)"   init "" .
def var  bev        AS Char FORMAT "X(1)"   init "" .
def var  driveno4   AS CHAR FORMAT "x(2)"   INIT "" .
def var  drivename4 AS Char FORMAT "X(40)"  init "" .
def var  bdatedriv4 AS CHAR FORMAT "x(8)"   INIT "" .
def var  occupdriv4 AS Char FORMAT "X(75)"  init "" .
def var  positdriv4 AS Char FORMAT "X(40)"  init "" .
def var  driveno5   AS CHAR FORMAT "x(2)"   INIT "" . 
def var  drivename5 AS Char FORMAT "X(40)"  init "" .
def var  bdatedriv5 AS CHAR FORMAT "x(8)"   INIT "" .
def var  occupdriv5 AS Char FORMAT "X(75)"  init "" .
def var  positdriv5 AS Char FORMAT "X(40)"  init "" .
def var  campagin   AS Char FORMAT "X(20)"  init "" .
def var  inspic     AS Char FORMAT "X(1)"   init "" .
def var  engcount   AS Char FORMAT "X(2)"   init "" .
def var  engno2     AS Char FORMAT "X(35)"  init "" .
def var  engno3     AS Char FORMAT "X(35)"  init "" .
def var  engno4     AS Char FORMAT "X(35)"  init "" .
def var  engno5     AS Char FORMAT "X(35)"  init "" .
def var  classcomp  AS Char FORMAT "X(5)"   init "" . 
def var  carbrand   AS CHAR FORMAT "X(50)"  INIT "". 
/* end : A67-0114 */
DEFINE TEMP-TABLE wdetail 
    FIELD policyno     AS CHAR FORMAT "x(25)" INIT ""       /*  4   notify number*/                                                     
    FIELD caryear      AS CHAR FORMAT "x(4)"  INIT ""       /*  5   Caryear*/                                                             
    /*FIELD eng          AS CHAR FORMAT "x(25)" INIT ""       /*  6   Engine*/   /*A65-0356*/                                                             
    FIELD chasno       AS CHAR FORMAT "x(25)" INIT ""       /*  7   Chassis*/ */ /*A65-0356*/    
    FIELD eng          AS CHAR FORMAT "x(35)" INIT ""       /*  6   Engine*/     /*A65-0356*/                                                                 
    FIELD chasno       AS CHAR FORMAT "x(35)" INIT ""       /*  7   Chassis*/    /*A65-0356*/  
    FIELD engcc        AS CHAR FORMAT "x(7)"  INIT ""       /*  8   Weight*/ 
    FIELD weight       AS CHAR FORMAT "x(5)" INIT ""        /*  8   Weight*/  
    /*FIELD vehreg       AS CHAR FORMAT "x(11)" INIT ""     /*  11  licence no*//*A54-0112*/*/  /*A65-0356*/  
    FIELD vehreg       AS CHAR FORMAT "x(20)" INIT ""       /*  11  licence no*/    /*A54-0112*//*A65-0356*/  
    FIELD colorcode    AS CHAR FORMAT "x(25)"  INIT ""                                          /*A65-0356*/  
    FIELD garage       AS CHAR FORMAT "x(1)"  INIT ""       /*  12  garage*/                                                                     
    FIELD fleetper     AS DECI FORMAT ">>>>>9.99"  INIT ""  /*  13  fleet disc.*/                                                             
    FIELD ncb          AS DECI FORMAT ">>>>>9.99"  INIT ""  /*  14  ncb disc.*/
    /* a61-0418*/
    FIELD loadclm     AS CHAR FORMAT "x(10)" INIT ""  
    FIELD dspc        AS CHAR INIT "0"  FORMAT ">>9.99"
    FIELD base3       AS CHAR INIT "0"  FORMAT ">,>>>,>>>,>>>,>>9"
    FIELD netprem     AS CHAR INIT "0"  FORMAT ">,>>>,>>>,>>>,>>9"
    FIELD polmaster   AS CHAR FORMAT "x(40)" INIT ""  
    FIELD baseprem    AS INTE FORMAT ">,>>>,>>>,>>>,>>9" INIT  0
    /* A61-0418*/
    FIELD orthper      AS CHAR FORMAT "X(5)"  INIT ""       /*  15  other disc.*/                                                             
    FIELD vehuse       AS CHAR FORMAT "x(1)"  INIT ""       /*  16  vehuse*/                                                                     
    FIELD comdat       AS CHAR FORMAT "x(10)" INIT ""       /*  17  comdat */                                                         
    FIELD si           AS CHAR FORMAT "x(13)" INIT ""       /*  18  sum si */                                                                 
    FIELD not_office   AS CHAR FORMAT "x(100)" INIT ""      /*  20  รหัสเจ้าหน้าที่แจ้งประกัน*/
    FIELD entdat       AS CHAR FORMAT "x(50)" INIT ""       /*  21  วันที่แจ้งประกัน*/                                                 
    FIELD not_code     AS CHAR FORMAT "x(4)"  INIT ""       /*  23  รหัสแจ้งงาน*/                                                             
    FIELD premt        AS CHAR FORMAT "x(11)" INIT ""       /*  24  prem.1  17037.61    */                                                             
    FIELD comp_prm     AS CHAR FORMAT "x(9)"  INIT ""       /*  25  comp.prm    645.21  */                                                             
    FIELD stk          AS CHAR FORMAT "x(25)" INIT ""   /*  26  sticker         */                                                                 
    FIELD brand        AS CHAR FORMAT "x(50)" INIT ""   /*  27  brand   TOYOTA SOLUNA 1.5 (A/T) */                                                 
    FIELD moo          AS CHAR FORMAT "x(50)" INIT ""   /*  A55-0184 */
    FIELD soy          AS CHAR FORMAT "x(50)" INIT ""   /*  A55-0184 */
    FIELD road         AS CHAR FORMAT "x(50)" INIT ""   /*  A55-0184 */
    FIELD addr1        AS CHAR FORMAT "x(150)" INIT ""   /*  28  address1    230 ซอยท่าเตียน */                                                     
    FIELD tambon       AS CHAR FORMAT "x(60)" INIT ""   /*  29  address2    แขวงพระบรมมหาราชวัง */                                                 
    FIELD amper        AS CHAR FORMAT "x(30)" INIT ""   /*  30  address3    เขตพระนคร   */                                                         
    FIELD country      AS CHAR FORMAT "x(60)" INIT ""   /*  31  address4    กรุงเทพมหานคร 10200 */
    FIELD tiname       AS CHAR FORMAT "x(45)" INIT ""   /*  32  title name  นาย */                                                             
    FIELD insnam       AS CHAR FORMAT "x(65)" INIT ""   /*  33  first name  วิรัตน์ ศิลาสุวรรณ  */                                                 
    FIELD benname      AS CHAR FORMAT "x(150)" INIT ""  /*  34  beneficiary     ระบุ 8.3 ธนาคารทิสโก้ จำกัด (มหาชน) */                             
    FIELD remark       AS CHAR FORMAT "x(10)" INIT ""   /*  35  remark.   Confirmation_MV20020331_70040411_Confirmation_MV20020331_70040411   */ 
    FIELD Account_no   AS CHAR FORMAT "x(10)"  INIT ""  /*  36  account no.*/                                                         
    FIELD client_no    AS CHAR FORMAT "x(7)" INIT ""    /*  37  client No.*/                                                             
    FIELD expdat       AS CHAR FORMAT "X(10)" INIT ""   /*  38  expiry date */                                                     
    FIELD gap          AS CHAR FORMAT "x(15)" INIT ""   /*  39  insurance amt. */                                                 
    FIELD re_country   AS CHAR FORMAT "x(30)" INIT ""   /*  40  province */                                                                 
    FIELD receipt_name AS CHAR FORMAT "x(50)" INIT ""   /*  41  receipt name */             
    FIELD agent        AS CHAR FORMAT "x(50)" INIT ""   /*  42  agent code  TISCO*/                                                     
    FIELD prepol       AS CHAR FORMAT "X(15)"  INIT ""  /*  44  old policy          */                                                             
    FIELD deduct       AS CHAR FORMAT "x(10)" INIT ""   /*  45  deduct disc.    0   */                                                             
    FIELD branch       AS CHAR FORMAT "x(2)"  INIT ""   /*  46  branch      b   */ 
    FIELD tp1          AS CHAR FORMAT "x(15)" INIT ""   /*  48  tp1             */                                                                 
    FIELD tp2          AS CHAR FORMAT "x(15)" INIT ""   /*  49  tp2             */                                                                 
    FIELD tp3          AS CHAR FORMAT "x(15)"  INIT ""  /*  50  tp3             */                                                                 
    FIELD covcod       AS CHAR FORMAT "x(1)" INIT ""    /*  51  covcod      1   */                                                                 
    FIELD compul       AS CHAR FORMAT "x"     INIT "n"  
    FIELD model        AS CHAR FORMAT "x(40)"  INIT ""  
    FIELD seat          AS INTE FORMAT "99"   INIT ""  
    FIELD comper        AS CHAR FORMAT "x(14)" INIT ""  
    FIELD comacc        AS CHAR FORMAT "X(14)" INIT ""  
    FIELD deductpd      AS CHAR FORMAT "x(15)" INIT ""  
    FIELD cargrp        AS CHAR FORMAT "x(2)" INIT ""  
    FIELD body          AS CHAR FORMAT "X(20)" INIT ""  
    FIELD NO_411        AS CHAR FORMAT "x(14)" INIT ""  
    FIELD NO_412        AS CHAR FORMAT "x(14)" INIT ""   /*A61-0418*/
    FIELD NO_42         AS CHAR FORMAT "x(14)" INIT ""   
    FIELD NO_43         AS CHAR FORMAT "x(14)" INIT ""      
    FIELD comment       AS CHAR FORMAT "x(512)"  INIT ""
    FIELD producer      AS CHAR FORMAT "x(10)" INIT ""   
    FIELD trandat       AS CHAR FORMAT "x(10)" INIT ""      
    FIELD trantim       AS CHAR FORMAT "x(8)" INIT ""       
    FIELD n_IMPORT      AS CHAR FORMAT "x(2)" INIT ""       
    FIELD n_EXPORT      AS CHAR FORMAT "x(2)" INIT "" 
    FIELD poltyp        AS CHAR FORMAT "x(3)" INIT "" 
    FIELD pass          AS CHAR FORMAT "x"  INIT "n"
    FIELD OK_GEN        AS CHAR FORMAT "X" INIT "Y" 
    FIELD cr_2          AS CHAR FORMAT "x(20)" INIT ""  
    FIELD docno         AS CHAR INIT "" FORMAT "x(10)" 
    FIELD redbook       AS CHAR INIT "" FORMAT "X(10)"
    FIELD tariff        AS CHAR FORMAT "x(2)" INIT "9"
    FIELD cancel        AS CHAR FORMAT "x(2)" INIT ""    
    FIELD accdat        AS CHAR INIT "" FORMAT "x(10)"   
    FIELD prempa        AS CHAR FORMAT "x(4)" INIT ""       
    /*FIELD subclass      AS CHAR FORMAT "x(4)" INIT ""   */ /*A67-0185*/ 
    FIELD subclass      AS CHAR FORMAT "x(5)" INIT ""    /*A67-0185*/ 
    FIELD cndat         AS CHAR FORMAT "x(10)" INIT ""   
    FIELD WARNING       AS CHAR FORMAT "X(30)" INIT ""
    FIELD seat41        AS INTE FORMAT "99" INIT 0
    FIELD drivnam1      AS CHAR FORMAT "x(75)" INIT "" 
    FIELD driag1        AS CHAR FORMAT "x(10)" INIT "" 
    FIELD drivnam2      AS CHAR FORMAT "x(75)" INIT ""
    FIELD driag2        AS CHAR FORMAT "x(10)" INIT "" 
    FIELD deler         AS CHAR FORMAT "x(25)"
    FIELD typpol        AS CHAR FORMAT "x(15)" 
    FIELD drioc1        AS CHAR FORMAT "X(70)"  INIT ""
    FIELD drioc2        AS CHAR FORMAT "X(70)"  INIT "" 
    FIELD fi            AS CHAR FORMAT "X(20)"  INIT ""           
    FIELD CLASS         AS CHAR FORMAT "X(5)"   INIT ""    
    FIELD usedtype      AS CHAR FORMAT "X(5)"   INIT "" 
    FIELD cedpol        AS CHAR FORMAT "x(20)"  INIT ""   /*A61-0410*/
    FIELD campaign      AS CHAR FORMAT "x(30)"  INIT ""   /*A61-0410*/
    FIELD caracc        AS CHAR FORMAT "x(250)" INIT ""   /*A63-0210*/
    FIELD Rec_name72    AS CHAR FORMAT "x(150)" INIT ""   /*A63-0210*/
    FIELD Rec_add1      AS CHAR FORMAT "x(60)"  INIT ""   /*A63-0210*/
    FIELD Rec_add2      AS CHAR FORMAT "x(60)"  INIT ""   /*A63-0210*/
    FIELD Reciept72     AS CHAR FORMAT "x(60)"  INIT ""   /*A63-0210*/
    FIELD financecd     AS CHAR FORMAT "x(60)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD firstName     AS CHAR FORMAT "x(60)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD lastName      AS CHAR FORMAT "x(60)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD postcd        AS CHAR FORMAT "x(15)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeocc       AS CHAR FORMAT "x(4)"   INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr1     AS CHAR FORMAT "x(2)"   INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr2     AS CHAR FORMAT "x(2)"   INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr3     AS CHAR FORMAT "x(2)"   INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD br_insured    AS CHAR FORMAT "x(5)"   INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD campaign_ov   AS CHAR FORMAT "x(30)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
    FIELD insnamtyp     AS CHAR FORMAT "x(60)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD camp_prod     AS CHAR FORMAT "x(30)"  INIT ""  /*Add by Kridtiya i. A65-0364 Date. 17/12/2022*/ 
    /* A67-0114 */
    /*FIELD drivocc1      AS CHAR FORMAT "x(75)"  INIT "" */
    FIELD drivicno1     as char format "x(40)"  INIT ""  
    FIELD drivlevel1    as char format "x(2)"   INIT ""  
    /*FIELD drivocc2      AS CHAR FORMAT "x(75)"  INIT "" */
    FIELD drivicno2     as char format "x(40)"  INIT ""
    FIELD drivlevel2    as char format "x(2)"   INIT "" 
    FIELD drivnam3      AS CHAR FORMAT "x(40)"  INIT ""   
    FIELD drivag3       AS CHAR FORMAT "x(10)"  INIT ""   
    FIELD drivocc3      AS CHAR FORMAT "x(75)"  INIT ""
    FIELD drivicno3     as char format "x(40)"  INIT ""  
    FIELD drivlevel3    as char format "x(2)"   INIT ""  
    FIELD Schanel       AS Char FORMAT "X(1)"   init "" 
    FIELD bev           AS Char FORMAT "X(1)"   init "" 
    FIELD drivnam4      AS Char FORMAT "X(40)"  init "" 
    FIELD drivag4       AS CHAR FORMAT "x(10)"  INIT "" 
    FIELD drivocc4      AS Char FORMAT "X(75)"  init "" 
    FIELD drivicno4     as char format "x(40)"  INIT ""  
    FIELD drivlevel4    as char format "x(2)"   INIT ""  
    FIELD drivnam5      AS Char FORMAT "X(40)"  init "" 
    FIELD drivag5       AS CHAR FORMAT "x(10)"  INIT "" 
    FIELD drivocc5      AS Char FORMAT "X(75)"  init ""
    FIELD drivicno5     as char format "x(40)"  INIT ""  
    FIELD drivlevel5    as char format "x(2)"   INIT ""  
    FIELD campagin      AS Char FORMAT "X(20)"  init "" 
    FIELD inspic        AS Char FORMAT "X(1)"   init "" 
    FIELD engcount      AS Char FORMAT "X(2)"   init "" 
    FIELD engno2        AS Char FORMAT "X(35)"  init "" 
    FIELD engno3        AS Char FORMAT "X(35)"  init "" 
    FIELD engno4        AS Char FORMAT "X(35)"  init "" 
    FIELD engno5        AS Char FORMAT "X(35)"  init "" 
    FIELD classcomp     AS Char FORMAT "X(5)"   init ""  
    FIELD carbrand      AS CHAR FORMAT "X(50)"  INIT "" 
    FIELD drilevel      AS CHAR FORMAT "x(5)"  INIT "" 
    FIELD hp            AS CHAR FORMAT "x(10)" INIT ""
    FIELD maksi         AS CHAR FORMAT "x(15)" INIT "" 
    FIELD battyr        AS CHAR FORMAT "x(4)" INIT ""
    FIELD battper       AS DECI FORMAT ">>9"  INIT 0
    FIELD flag          AS LOGICAL INIT NO /*A68-0044*/
    FIELD rate31        as deci  init 0   /*A68-0044*/
    FIELD prmt31        as deci  init 0 . /*A68-0044*/  
   /* end : A67-0114 */


DEF VAR nv_chkerror     AS CHAR FORMAT "x(250)" INIT "".  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
DEF VAR nv_postcd       AS CHAR FORMAT "x(15)"  INIT "".  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/

DEF VAR n_cedpol AS CHAR FORMAT "x(20)" INIT "" . /*a61-0410*/
DEF NEW SHARED VAR nv_message AS char.
DEF            VAR c          AS CHAR.
DEF            VAR nv_riskgp  LIKE sic_bran.uwm120.riskgp NO-UNDO.
DEFINE NEW SHARED VAR no_baseprm AS DECI  FORMAT ">>,>>>,>>9.99-".  
DEFINE NEW SHARED VAR NO_basemsg AS CHAR  FORMAT "x(50)" .          
DEFINE            VAR nv_accdat  AS DATE  FORMAT "99/99/9999" INIT ?  .     
DEFINE            VAR nv_docno   AS CHAR  FORMAT "9999999"    INIT " ".
DEFINE NEW SHARED VAR  nv_batchyr   AS INT FORMAT "9999"            INIT 0.
DEFINE NEW SHARED VAR  nv_batcnt    AS INT FORMAT "99"              INIT 0.
DEFINE NEW SHARED VAR  nv_batchno   AS CHARACTER FORMAT "X(13)"     INIT ""  NO-UNDO.
DEFINE VAR  nv_batrunno  AS INT FORMAT  ">,>>9"          INIT 0.
DEFINE VAR  nv_imppol    AS INT  FORMAT ">>,>>9"         INIT 0.
DEFINE VAR  nv_impprem   AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.
DEFINE VAR  nv_batprev   AS CHARACTER FORMAT "X(13)"     INIT ""  NO-UNDO.
DEFINE VAR  nv_tmppolrun AS INTEGER FORMAT "999"         INIT 0. 
DEFINE VAR  nv_batbrn    AS CHARACTER FORMAT "x(2)"      INIT ""  NO-UNDO. 
DEFINE VAR  nv_tmppol    AS CHARACTER FORMAT "x(16)"     INIT "". 
DEFINE VAR  nv_rectot    AS INT  FORMAT ">>,>>9"         INIT 0.  
DEFINE VAR  nv_recsuc    AS INT  FORMAT ">>,>>9"         INIT 0.  
DEFINE VAR  nv_netprm_t  AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.  
DEFINE VAR  nv_netprm_s  AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.  
DEFINE VAR  nv_batflg    AS LOG                          INIT NO.
DEFINE VAR  nv_txtmsg    AS CHAR FORMAT "x(50)"          INIT "". 
DEF VAR nv_modcod  AS CHAR FORMAT "x(8)" INIT "" .  
DEF VAR n_ratmin   AS INTE INIT 0.
DEF VAR n_ratmax   AS INTE INIT 0.
DEF VAR n_policyno AS CHAR FORMAT "x(20)" INIT "" .
DEF VAR nv_sexdri  AS CHAR FORMAT "x(60)" INIT "" .
DEF VAR nv_daily     AS CHARACTER FORMAT "X(1024)"     INITIAL ""  NO-UNDO.     
DEF VAR nv_reccnt   AS  INT  INIT  0.           /*all load record*/                              
DEF VAR nv_completecnt    AS   INT   INIT  0.   /*complete record */                              
DEF VAR chkred    AS logi INIT NO.
/*DEFINE VAR n_sclass72  AS CHAR FORMAT "x(4)".  */ /*A67-0185*/
DEFINE VAR n_sclass72  AS CHAR FORMAT "x(5)".   /*A67-0185*/
DEF VAR s_riskgp    AS INTE FORMAT ">9".                                                         
DEF VAR s_riskno    AS INTE FORMAT "999".                                                        
DEF VAR s_itemno    AS INTE FORMAT "999".                                                        
DEF VAR nv_comper  AS DECI INIT 0.                    
DEF VAR nv_comacc  AS DECI INIT 0. 
DEF VAR  s_recid1       as RECID .     /* uwm100  */                    
DEF VAR  s_recid2       as recid .     /* uwm120  */                    
DEF VAR  s_recid3       as recid .
DEF VAR  s_recid4       as recid .
DEFINE VAR nv_newsck AS CHAR FORMAT "x(15)" INIT " ".  
DEF VAR nv_rec100   AS RECID .                                                                  
DEF VAR nv_rec120   AS RECID .                                                                   
DEF VAR nv_rec130   AS RECID .                                                                  
DEF VAR nv_rec301   AS RECID .                                                                   
DEF VAR nv_gap      AS DECIMAL               NO-UNDO. 
DEF VAR nvffptr     AS RECID                 NO-UNDO. 
DEF VAR s_130bp1    AS RECID                 NO-UNDO.      
DEF VAR s_130fp1    AS RECID                 NO-UNDO.   
DEF VAR n_rd132     AS RECID                 NO-UNDO. 
DEF VAR nv_key_a    AS DECIMAL INITIAL 0                NO-UNDO. 
DEF VAR nv_stm_per  AS DECIMAL FORMAT ">9.99" INITIAL 0 NO-UNDO.      
DEF VAR nv_tax_per  AS DECIMAL FORMAT ">9.99" INITIAL 0 NO-UNDO.      
DEF VAR nv_gap2     AS DECIMAL               NO-UNDO. 
DEF VAR nv_prem2    AS DECIMAL               NO-UNDO.
DEF VAR nv_rstp     AS DECIMAL                          NO-UNDO.
DEF VAR nv_rtax     AS DECIMAL                          NO-UNDO.
DEF VAR nv_com1_per AS DECIMAL FORMAT ">9.99" INITIAL 0 NO-UNDO.    
DEF VAR nv_com1_prm AS DECIMAL FORMAT ">>>>>9.99-"      NO-UNDO. 
DEF VAR nv_fptr     AS RECID.  
DEFINE VAR nv_basere   AS DECI        FORMAT ">>,>>>,>>9.99-" INIT 0.
DEF VAR nv_chk as  logic.
DEF VAR nv_ncbyrs AS INTE. 
DEF VAR nv_uom1_v AS INTE INIT 0.                     
DEF VAR nv_uom2_v AS INTE INIT 0.                     
DEF VAR nv_uom5_v AS INTE INIT 0.                     
DEF VAR nv_uwm301trareg    LIKE sicuw.uwm301.cha_no INIT "".
DEFINE VAR nv_maxSI  AS DECI FORMAT ">>,>>>,>>9.99-".  /* Maximum Sum Insure */  
DEFINE VAR nv_minSI  AS DECI FORMAT ">>,>>>,>>9.99-".  /* Minimum Sum Insure */  
DEFINE VAR nv_si     AS DECI FORMAT ">>,>>>,>>9.99-".  /* Maximum Sum Insure */  
DEFINE VAR nv_maxdes AS CHAR.                                                   
DEFINE VAR nv_mindes AS CHAR.  
DEF VAR  NO_CLASS AS CHAR INIT "".
DEF VAR n_rencnt   LIKE sicuw.uwm100.rencnt INITIAL "".
DEF VAR n_endcnt   LIKE sicuw.uwm100.endcnt INITIAL "".                
DEF VAR n_curbil    LIKE  sicuw.uwm100.curbil  NO-UNDO.            
DEF VAR nv_dept     as char format  "X(1)".
DEF  var  nv_row  as  int  init  0. 
DEFINE STREAM  ns1.                                        
DEFINE STREAM  ns2.                                         
DEFINE STREAM  ns3.  
DEF  VAR gv_id AS CHAR FORMAT "X(8)" NO-UNDO. 
DEF VAR nv_pwd AS CHAR NO-UNDO. 
DEF VAR nv_drivage1 AS INTE INIT 0.                                
DEF VAR nv_drivage2 AS INTE INIT 0.  
DEF VAR nv_bptr     AS RECID.                           
DEF VAR nv_nptr     AS RECID.  
DEFINE VAR nv_line1   AS INTEGER   INITIAL 0            NO-UNDO.                                 
DEF VAR nv_undyr    as    char  init  ""    format   "X(4)". 
DEFINE  WORKFILE wuppertxt3 NO-UNDO                                                             
 /*1*/  FIELD line     AS INTEGER   FORMAT ">>9"                                                
 /*2*/  FIELD txt      AS CHARACTER FORMAT "X(200)"   INITIAL "".  
DEFINE  WORKFILE wuppertxt NO-UNDO                                                             
 /*1*/  FIELD line     AS INTEGER   FORMAT ">>9"                                                
 /*2*/  FIELD txt      AS CHARACTER FORMAT "X(200)"   INITIAL "".    
DEF VAR nv_lnumber AS INTE  INIT 0 .
DEF VAR n_41       AS DECI     FORMAT ">,>>>,>>9.99" INIT 0.
DEF VAR n_42       AS DECI     FORMAT ">,>>>,>>9.99" INIT 0.
DEF VAR n_43       AS DECI     FORMAT ">,>>>,>>9.99" INIT 0.
DEF VAR dod1       AS DECI.
DEF VAR dod2       AS DECI.
DEF VAR dpd0       AS DECI.
DEF VAR dod0         AS DECI.
DEF VAR n_firstdat   AS CHAR FORMAT "x(10)"  INIT "".
DEF VAR nv_txt1      AS CHAR FORMAT "x(200)" INIT "".
DEF VAR nv_dscom     AS DECI INIT      0 .
DEFINE VAR nv_insref AS CHARACTER FORMAT "X(10)".          
DEFINE VAR n_insref  AS CHARACTER FORMAT "X(10)".  
DEF VAR nv_usrid     AS CHARACTER FORMAT "X(08)".             
DEF VAR nv_transfer  AS LOGICAL   .                            
DEF VAR n_check      AS CHARACTER .                            
DEF VAR nv_typ       AS CHAR FORMAT "X(2)".    
DEF VAR n_icno       AS CHAR FORMAT "x(13)".
DEFINE VAR  nv_driver    AS CHARACTER FORMAT "X(23)" INITIAL ""  .
DEFINE VAR  np_driver    AS CHAR      FORMAT "x(23)" INIT "".
DEFINE NEW SHARED WORKFILE ws0m009 NO-UNDO
/*1*/  FIELD policy     AS CHARACTER    INITIAL ""  
/*2*/  FIELD lnumber    AS INTEGER   
       FIELD ltext      AS CHARACTER    INITIAL "" 
       FIELD ltext2     AS CHARACTER    INITIAL "" 
         /* add by : A67-0114 */ 
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
       FIELD dconsen    AS LOGICAL FORMAT NO .
       /* end A67-0114 */ 
/*DEF VAR nv_drivage1     AS INTE INIT 0.
DEF VAR nv_drivage2     AS INTE INIT 0.*/
DEF VAR nr_premtxt      AS CHAR FORMAT "x(100)" INIT "".
/*A61-0410*/
DEF VAR n_policy72 AS CHAR FORMAT "x(20)" INIT "" .  
DEF VAR n_packcomp AS CHAR FORMAT "x(3)" INIT "" .   
DEFINE  WORKFILE wcomp NO-UNDO
      FIELD package     AS CHARACTER FORMAT "X(10)"   INITIAL ""
      FIELD premcomp    AS DECI FORMAT "->>,>>9.99"    INITIAL 0.
DEF VAR nv_72Reciept   AS CHAR FORMAT "X(50)" INIT "".
DEF VAR n_blank AS CHAR FORMAT "x(50)" INIT "" .
/*A61-0410*/
DEF VAR nv_product AS CHAR FORMAT "x(50)" INIT "" . /*A63-0210*/

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
DEFINE VAR nv_41prmt       AS DECI FORMAT ">>>,>>>,>>9.99-".  /* fleet */
DEFINE VAR nv_42prmt       AS DECI FORMAT ">>>,>>>,>>9.99-".  /* fleet */
DEFINE VAR nv_43prmt       AS DECI FORMAT ">>>,>>>,>>9.99-".  /* fleet */
DEFINE VAR nv_pdprem       AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_status       AS CHAR .   /*fleet YES=Complete , NO=Not Complete */
DEFINE VAR nv_baseprm3     AS DECI FORMAT ">>,>>>,>>9.99-".
/* end A64-0138 */
/* A67-0114 */
DEFINE VAR nv_412prmt AS DECI FORMAT ">>>,>>>,>>9.99-".    /*add  26/01/2022 */ 
DEFINE VAR nv_413prmt AS DECI FORMAT ">>>,>>>,>>9.99-".    /*add  26/01/2022 */
DEFINE VAR nv_414prmt AS DECI FORMAT ">>>,>>>,>>9.99-".    /*add  26/01/2022 */
DEFINE var nv_ncbprm   AS DECI FORMAT ">>>,>>>,>>9.99-".   /*add 28/01/2022*/
DEFINE var nv_fletprm  AS DECI FORMAT ">>>,>>>,>>9.99-".   /*add 28/01/2022*/
DEFINE var nv_dspcprm  AS DECI FORMAT ">>>,>>>,>>9.99-".   /*add 28/01/2022*/
DEFINE var nv_dstfprm  AS DECI FORMAT ">>>,>>>,>>9.99-".   /*add 28/01/2022*/
DEFINE var nv_clmprm   AS DECI FORMAT ">>>,>>>,>>9.99-".   /*add 28/01/2022*/

DEFINE VAR nv_attgap  AS DECI FORMAT ">>,>>>,>>9.99-".   /*add  26/01/2022 */ 
DEFINE VAR nv_fltgap  AS DECI FORMAT ">>,>>>,>>9.99-".   /*add  26/01/2022 */ 
DEFINE VAR nv_ncbgap  AS DECI FORMAT ">>,>>>,>>9.99-".   /*add  26/01/2022 */ 
DEFINE VAR nv_dscgap  AS DECI FORMAT ">>,>>>,>>9.99-".   /*add  26/01/2022 */ 
DEFINE VAR nv_packatt AS CHAR FORMAT "X(4)".             /*add  26/01/2022 */ 

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

DEFINE var nv_uom9_v  AS INTE FORMAT ">>>,>>>,>>9".
DEFINE var nv_evflg   AS LOGICAL.
DEFINE VAR nv_flgsht  AS CHAR.  /* Short rate = "S" , Pro rate = "P" */ 
DEFINE VAR nv_level   AS INTE INIT 0.
DEF    VAR nv_campcd  AS CHAR INIT "" .

DEF VAR n_count AS INTE INIT 0.
DEF VAR no_policy   AS CHAR FORMAT "x(20)" .
DEF VAR no_rencnt   AS CHAR FORMAT "99".
DEF VAR no_endcnt   AS CHAR FORMAT "999".
DEF VAR no_riskno   AS CHAR FORMAT "999".
DEF VAR no_itemno   AS CHAR FORMAT "999".
def var nv_drivage3 as inte init 0 .
def var nv_drivage4 as inte init 0 .
def var nv_drivage5 as inte init 0 .
def var nv_drivbir1 as char init  "" .
def var nv_drivbir2 as char init  "" .
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

DEF VAR nv_drivname AS CHAR INIT "" .
/* add by : A67-0114  */
/*--A68-0044-- */
def var wf_31rate as char format "x(10)" .   /* Rate 31  --A68-0044-- */
def var wf_31prmt as char format "x(10)" .  /* เบี้ย 31 --A68-0044-- */
def var nv_31rate as DECI format ">>9.99-".  /* Rate 31 */
def var nv_31prmt as DECI format ">>,>>>,>>9.99-".  /* เบี้ย 31 */
DEF VAR nv_flag   AS LOGICAL INIT NO .
DEF VAR nv_garage AS CHAR FORMAT "x(2)" .
/* end A68-0044 */







