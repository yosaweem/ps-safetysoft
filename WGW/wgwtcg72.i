/*Program id  : wgwtcg72.i                                              */
/*programname : load text file Tisco to GW Compulsary                   */
/* Copyright  : Safety Insurance Public Company Limited 			    */
/*			    บริษัท ประกันคุ้มภัย จำกัด (มหาชน)				        */
/*create by   : Kridtiya i. A55-0184  date . 27/06/2012         
                ปรับโปรแกรมให้สามารถนำเข้า text file tisco to GW system */ 
/*copy write  : wgwargen.i                                              */
/*modify by   : Kridtiya i. A55-0325 เพิ่มข้อมูลผู้เอาประกันภัย insurce="" not create xmm600*/
/*modify by   : Kridtiya i. A54-0112 ขยายช่องทะเบียนรถ จาก 10 เป็น 11 หลัก*/
/*modify by   : Kridtiya i. A56-0323 เพิ่มการรับค่า package,class         */
/*modify by   : Kridtiya i. A57-0017 add seate                            */
/*modify by   : Kridtiya i. A57-0088 date. 10/03/2014 เพิ่มตัวแปรรับค่ารหัสรถ(Redbook) จากไฟล์*/
/*Modify by   : Kridtiya i. A63-0472 Date. 09/11/2020 add field firstname ,lastname.....*/
/*Modify by   : Kridtiya i. A65-0356 Date. 07/01/2023 ขยายช่อง เลขเครื่องเลขถัง ทะเบียน สี */
/*Modify by   : Ranu I. A67-0114 เพิ่มตัวแปรเก็บข้อมูลรถไฟฟ้า */
/*Modify by   : Ranu I. A67-0185 ขยายตัวแปร Class             */
/**************************************************************************/
DEFINE NEW SHARED TEMP-TABLE wdetail2
    FIELD Pro_off         AS CHAR FORMAT "x(10)"  INIT ""   /* Processing Office */  
    FIELD cmr_code        AS CHAR FORMAT "x(3)"   INIT ""   /* CMR  code        */  
    FIELD comcode         AS CHAR FORMAT "x(3)"   INIT ""   /* Insur.comp       */  
    FIELD policyno        AS CHAR FORMAT "x(25)"  INIT ""   /* notify number    */  
    FIELD caryear         AS CHAR FORMAT "x(4)"   INIT ""   /* year             */  
    /*FIELD eng             AS CHAR FORMAT "x(25)"  INIT ""   /* engine         */ /*A65-0356*/ 
    FIELD chasno          AS CHAR FORMAT "x(25)"  INIT ""   /* chassis      */  *//*A65-0356*/ 
    FIELD eng             AS CHAR FORMAT "x(35)"  INIT ""   /* engine           *//*A65-0356*/   
    FIELD chasno          AS CHAR FORMAT "x(35)"  INIT ""   /* chassis          *//*A65-0356*/  
    FIELD engcc           AS CHAR FORMAT "x(5)"   INIT ""   /* weight           */  
    FIELD power           AS CHAR FORMAT "x(7)"   INIT ""   /* power            */  
    /*FIELD colorcode       AS CHAR FORMAT "x(15)"  INIT ""   /* color        */*//*A65-0356*/ 
    FIELD colorcode       AS CHAR FORMAT "x(25)"  INIT ""   /* color            *//*A65-0356*/   
    /*FIELD vehreg          AS CHAR FORMAT "x(10)"  INIT "" /* licence no     */*//*kridtiya i. A54-0112*/ 
    /*FIELD vehreg          AS CHAR FORMAT "x(11)"  INIT ""   /*เลขทะเบียนรถ*/  /*kridtiya i. A54-0112*/*//*A65-0356*/ 
    FIELD vehreg          AS CHAR FORMAT "x(20)"  INIT ""   /*เลขทะเบียนรถ*/    /*kridtiya i. A54-0112*//*A65-0356*/ 
    FIELD garage          AS CHAR FORMAT "x(1)"   INIT ""   /* garage           */  
    FIELD fleetper        AS CHAR FORMAT "X(5)"   INIT ""   /* fleet disc.      */  
    FIELD ncb             AS CHAR FORMAT "X(5)"   INIT ""   /* ncb disc.        */  
    FIELD orthper         AS CHAR FORMAT "X(5)"   INIT ""   /* other disc.      */   
    FIELD vehuse          AS CHAR FORMAT "x(1)"   INIT ""   /* vehuse           */  
    FIELD comdat          AS CHAR FORMAT "x(10)"  INIT ""   /* comdat           */  
    FIELD si              AS CHAR FORMAT "x(13)"  INIT ""   /* sum si           */  
    FIELD name_insur      AS CHAR FORMAT "x(15)"  INIT ""   /* ชื่อเจ้าหน้าที่ประกัน     */ 
    FIELD not_office      AS CHAR FORMAT "x(75)"  INIT ""   /* รหัสเจ้าหน้าที่แจ้งประกัน */  
    FIELD entdat          AS CHAR FORMAT "x(10)"  INIT ""   /* วันที่แจ้งประกัน          */  
    FIELD enttim          AS CHAR FORMAT "x(8)"   INIT ""   /* เวลาแจ้งประกัน            */  
    FIELD not_code        AS CHAR FORMAT "x(4)"   INIT ""   /* รหัสแจ้งงาน               */  
    FIELD premt           AS CHAR FORMAT "x(11)"  INIT ""   /*  prem.1                   */  
    FIELD comp_prm        AS CHAR FORMAT "x(9)"   INIT ""   /* comp.prm                  */  
    FIELD stk             AS CHAR FORMAT "x(25)"  INIT ""   /* sticker                   */  
    FIELD brand           AS CHAR FORMAT "x(50)"  INIT ""   /* brand                     */     
    FIELD addr1           AS CHAR FORMAT "x(50)"  INIT ""   /* address1                  */     
    FIELD addr2           AS CHAR FORMAT "x(60)"  INIT ""   /* address2                  */     
    FIELD tambon          AS CHAR FORMAT "x(60)"  INIT ""   /*  29  address2    แขวงพระบรมมหาราชวัง */                                                 
    FIELD amper           AS CHAR FORMAT "x(30)"  INIT ""   /*  30  address3    เขตพระนคร   */                                                         
    FIELD country         AS CHAR FORMAT "x(60)"  INIT ""   /*  31  address4    กรุงเทพมหานคร 10200 */
    FIELD tiname          AS CHAR FORMAT "x(30)"  INIT ""   /* title name                */     
    FIELD insnam          AS CHAR FORMAT "x(55)"  INIT ""   /* first name                */     
    FIELD name2           AS CHAR FORMAT "x(45)"  INIT ""   /* last name                 */     
    FIELD benname         AS CHAR FORMAT "x(65)"  INIT ""   /* beneficiary               */     
    FIELD remark          AS CHAR FORMAT "x(150)" INIT ""   /* remark.                   */     
    FIELD Account_no      AS CHAR FORMAT "x(10)"  INIT ""   /* account no.               */     
    FIELD client_no       AS CHAR FORMAT "x(7)"   INIT ""   /* client No.                */     
    FIELD expdat          AS CHAR FORMAT "x(10)"  INIT ""   /* expiry date               */     
    FIELD gap             AS CHAR FORMAT "X(11)"  INIT ""   /* insurance amt.            */     
    FIELD re_country      AS CHAR FORMAT "x(18)"  INIT ""   /* province                  */     
    FIELD receipt_name    AS CHAR FORMAT "x(50)"  INIT ""   /* receipt name              */     
    FIELD agent           AS CHAR FORMAT "x(15)"  INIT ""   /* agent code                */     
    FIELD prev_insur      AS CHAR FORMAT "x(50)"  INIT ""   /* บริษัทประกันภัยเดิม       */     
    FIELD prepol          AS CHAR FORMAT "x(25)"  INIT ""   /* old policy                */     
    FIELD deduct          AS CHAR FORMAT "X(9)"   INIT ""   /* deduct disc.              */     
    FIELD add1_70         AS CHAR FORMAT "X(100)" INIT ""   /* ที่อยู่หน้าตาราง70       */     
    FIELD add2_70         AS CHAR FORMAT "X(60)"  INIT ""   /* ที่อยู่หน้าตาราง70กรณีไม่แยกที่อยู่*/     
    FIELD Sub_Di_70       AS CHAR FORMAT "X(30)"  INIT ""   /* ตำบล                               */     
    FIELD Direc_70        AS CHAR FORMAT "X(30)"  INIT ""   /* อำเภอ                              */     
    FIELD Provi_70        AS CHAR FORMAT "X(30)"  INIT ""   /* จังหวัด                            */     
    FIELD ZipCo_70        AS CHAR FORMAT "X(5)"   INIT ""   /* รหัสไปรษณีย์                       */     
    FIELD add1_72         AS CHAR FORMAT "X(50)"  INIT ""   /* ที่อยู่หน้าตาราง72                 */     
    FIELD add2_72         AS CHAR FORMAT "X(60)"  INIT ""   /* ที่อยู่หน้าตาราง72กรณีไม่แยกที่อยู่*/     
    FIELD Sub_Di_72       AS CHAR FORMAT "X(30)"  INIT ""   /* ตำบล                               */     
    FIELD Direc_72        AS CHAR FORMAT "X(30)"  INIT ""   /* อำเภอ                              */     
    FIELD Provi_72        AS CHAR FORMAT "X(30)"  INIT ""   /* จังหวัด                            */     
    FIELD ZipCo_72        AS CHAR FORMAT "X(5)"   INIT ""   /* รหัสไปรษณีย์                       */     
    FIELD apptype         AS CHAR FORMAT "X(10)"  INIT ""   /* Applicationtype                    */     
    FIELD appcode         AS CHAR FORMAT "X(02)"  INIT ""   /* Applicationcode                    */     
    FIELD nBLANK          AS CHAR FORMAT "X(09)"  INIT ""   /* Blank                              */     
    /*FIELD prempa          AS CHAR FORMAT "x(4)"   INIT ""   /* package */  --A67-0185--*/
    FIELD prempa          AS CHAR FORMAT "x(5)"   INIT ""   /* package */  /*--A67-0185--*/
    FIELD seate           AS CHAR FORMAT "x(4)"   INIT ""   /* seate   add A57-0017               */ 
    FIELD tp1             AS CHAR FORMAT "X(14)"  INIT ""   /* TPBI/Person                        */     
    FIELD tp2             AS CHAR FORMAT "X(14)"  INIT ""   /* TPBI/Per Acciden                   */     
    FIELD tp3             AS CHAR FORMAT "X(14)"  INIT ""   /* TPPD/Per Acciden                   */     
    FIELD covcod          AS CHAR FORMAT "x(1)"   INIT ""   /* covcod */  
    FIELD producer        AS CHAR FORMAT "x(1)"   INIT ""
    FIELD agent1          AS CHAR FORMAT "x(1)"   INIT ""                          
    FIELD nbranch         AS CHAR FORMAT "x(2)"   INIT ""   /* branch     */
    FIELD npolty          AS CHAR FORMAT "x(10)"  INIT ""  
    FIELD nredbook        AS CHAR FORMAT "x(10)"  INIT ""   /* A57-0088*/ 
    FIELD Price_Ford      AS CHAR FORMAT "X(20)"  INIT ""   /* Price Ford */
    FIELD Year_fd         AS CHAR FORMAT "X(10)"  INIT ""   /* Year FD */ 
    FIELD Brand_Model     AS CHAR FORMAT "X(60)"  INIT ""   
    FIELD id_no70         AS CHAR FORMAT "x(13)"  INIT ""   /*“เลขทีบัตรประจำตัวประชาชน/เลขทีหนังสือเดินทาง /เลขทะเบียนพาณิชย์”*/
    FIELD id_nobr70       AS CHAR FORMAT "x(20)"  INIT ""   /*สาขาของสถานประกอบการลูกค้า*/
    FIELD id_no72         AS CHAR FORMAT "x(13)"  INIT ""   /*“เลขทีบัตรประจำตัวประชาชน/เลขทีหนังสือเดินทาง /เลขทะเบียนพาณิชย์”*/
    FIELD id_nobr72       AS CHAR FORMAT "x(20)"  INIT ""   /*สาขาของสถานประกอบการลูกค้า*/
    /*- A59-0178 -*/
    FIELD comp_comdat     AS CHAR FORMAT "X(8)"   INIT ""   /*Effective Date Accidential*/        
    FIELD comp_expdat     AS CHAR FORMAT "X(8)"   INIT ""   /*Expiry Date Accidential*/         
    FIELD fi              AS CHAR FORMAT "X(11)"  INIT ""   /*Coverage Amount Theft*/           
   /* FIELD class           AS CHAR FORMAT "X(3)"   INIT ""   /*Car code*/   */ /*A67-0185*/
    FIELD class           AS CHAR FORMAT "X(5)"   INIT ""   /*Car code*/      /*A67-0185*/
    FIELD usedtype        AS CHAR FORMAT "x(1)"   INIT ""   /*Per Used*/                        
    /*---- Driver name ---*/
    FIELD driveno1        AS CHAR FORMAT "x(2)"   INIT ""   /*Driver Seq1*/                     
    FIELD drivename1      AS CHAR FORMAT "x(40)"  INIT ""   /*Driver Name1*/  
    FIELD bdatedriv1      AS CHAR FORMAT "x(8)"   INIT ""   /*Birthdate Driver1*/               
    FIELD occupdriv1      AS CHAR FORMAT "x(75)"  INIT ""   /*Occupation Driver1*/              
    FIELD positdriv1      AS CHAR FORMAT "X(40)"  INIT ""   /*Position Driver1 */               
    FIELD driveno2        AS CHAR FORMAT "x(2)"   INIT ""   /*Driver Seq2*/                     
    FIELD drivename2      AS CHAR FORMAT "x(40)"  INIT ""   /*Driver Name2*/                    
    FIELD bdatedriv2      AS CHAR FORMAT "x(8)"   INIT ""   /*Birthdate Driver2*/               
    FIELD occupdriv2      AS CHAR FORMAT "x(75)"  INIT ""   /*Occupation Driver2*/              
    FIELD positdriv2      AS CHAR FORMAT "X(40)"  INIT ""   /*Position Driver2*/                
    FIELD driveno3        AS CHAR FORMAT "x(2)"   INIT ""   /*Driver Seq3*/                     
    FIELD drivename3      AS CHAR FORMAT "x(40)"  INIT ""   /*Driver Name3*/                    
    FIELD bdatedriv3      AS CHAR FORMAT "x(8)"   INIT ""   /*Birthdate Driver3*/               
    FIELD occupdriv3      AS CHAR FORMAT "x(75)"  INIT ""   /*Occupation Driver3*/              
    FIELD positdriv3      AS CHAR FORMAT "X(40)"  INIT ""   /*Position Driver3*/                
    FIELD Reciept72       AS CHAR FORMAT "X(50)"  INIT ""   /*72Reciept*/
    /*---- Driver name ---*/
      /*A67-0114 */
    FIELD Rec_name72    AS CHAR FORMAT "x(60)"  INIT ""  /*A63-0210*/
    FIELD Rec_add1      AS CHAR FORMAT "x(60)"  INIT ""  /*A63-0210*/
    field n_comment    as char format "x(50)"  init ""     /*A61-0045*/
    FIELD brithday      AS CHAR FORMAT "X(20)"  INIT ""
    FIELD Schanel    AS Char FORMAT "X(1)"   init "" 
    FIELD bev        AS Char FORMAT "X(1)"   init "" 
    FIELD driveno4   AS CHAR FORMAT "x(2)"   INIT "" 
    FIELD drivename4 AS Char FORMAT "X(40)"  init "" 
    FIELD bdatedriv4 AS CHAR FORMAT "x(8)"   INIT "" 
    FIELD occupdriv4 AS Char FORMAT "X(75)"  init "" 
    FIELD positdriv4 AS Char FORMAT "X(40)"  init "" 
    FIELD driveno5   AS CHAR FORMAT "x(2)"   INIT ""  
    FIELD drivename5 AS Char FORMAT "X(40)"  init "" 
    FIELD bdatedriv5 AS CHAR FORMAT "x(8)"   INIT "" 
    FIELD occupdriv5 AS Char FORMAT "X(75)"  init "" 
    FIELD positdriv5 AS Char FORMAT "X(40)"  init "" 
    FIELD campagin   AS Char FORMAT "X(20)"  init "" 
    FIELD inspic     AS Char FORMAT "X(1)"   init "" 
    FIELD engcount   AS Char FORMAT "X(2)"   init "" 
    FIELD engno2     AS Char FORMAT "X(35)"  init "" 
    FIELD engno3     AS Char FORMAT "X(35)"  init "" 
    FIELD engno4     AS Char FORMAT "X(35)"  init "" 
    FIELD engno5     AS Char FORMAT "X(35)"  init "" 
    FIELD classcomp  AS Char FORMAT "X(5)"   init ""  
    FIELD carbrand   AS CHAR FORMAT "X(50)"  INIT "" 
    FIELD drilevel   AS CHAR FORMAT "x(5)"  INIT "" 
    FIELD access     AS CHAR FORMAT "x(150)" INIT "" .
  /* end : A67-0114 */
               
DEFINE NEW SHARED TEMP-TABLE wdetail 
    FIELD policyno     AS CHAR FORMAT "x(25)"     INIT ""   /*  4   notify number*/
    FIELD cedpol       AS CHAR FORMAT "x(25)"     INIT ""   /*  4   notify number*/
    FIELD caryear      AS CHAR FORMAT "x(4)"      INIT ""   /*  5   Caryear*/                                                             
    /*FIELD eng          AS CHAR FORMAT "x(25)"     INIT ""   /*  6   Engine*/  /*A65-0356*/                                                            
    FIELD chasno       AS CHAR FORMAT "x(25)"     INIT ""   /*  7   Chassis*/*/ /*A65-0356*/ 
    FIELD eng          AS CHAR FORMAT "x(35)"     INIT ""   /*  6   Engine*/    /*A65-0356*/                                                              
    FIELD chasno       AS CHAR FORMAT "x(35)"     INIT ""   /*  7   Chassis*/   /*A65-0356*/  
    FIELD engcc        AS CHAR FORMAT "x(7)"      INIT ""   /*  8   Weight*/ 
    FIELD tonss        AS CHAR FORMAT "x(7)"      INIT ""   /*  8   Weight*/  
    /*FIELD vehreg       AS CHAR FORMAT "x(10)"     INIT ""   /*  11  licence no*/  *//*kridtiya i. a54-0112*/
    /*FIELD vehreg       AS CHAR FORMAT "x(11)"     INIT ""   /*  11  licence no*/   */   /*kridtiya i. a54-0112*/
    FIELD vehreg       AS CHAR FORMAT "x(20)"     INIT ""   /*  11  licence no*/  /*A65-0356*/    
    FIELD colorcode    AS CHAR FORMAT "x(25)"     INIT ""   /* color            *//*A65-0356*/   
    FIELD garage       AS CHAR FORMAT "x(1)"      INIT ""   /*  12  garage*/                                                                     
    FIELD fleetper     AS DECI FORMAT ">>>>>9.99" INIT ""   /*  13  fleet disc.*/                                                             
    FIELD ncb          AS DECI FORMAT ">>>>>9.99" INIT ""   /*  14  ncb disc.*/                                                                 
    FIELD orthper      AS CHAR FORMAT "X(5)"      INIT ""   /*  15  other disc.*/                                                             
    FIELD vehuse       AS CHAR FORMAT "x(1)"      INIT ""   /*  16  vehuse*/                                                                     
    FIELD comdat       AS CHAR FORMAT "x(10)"     INIT ""   /*  17  comdat */                                                         
    FIELD si           AS CHAR FORMAT "x(13)"     INIT ""   /*  18  sum si */                                                                 
    FIELD name_insur   AS CHAR FORMAT "x(20)"     INIT ""   /*  19  ชื่อเจ้าหน้าที่ประกัน*/                                         
    FIELD not_office   AS CHAR FORMAT "x(75)"     INIT ""   /*  20  รหัสเจ้าหน้าที่แจ้งประกัน*/
    FIELD entdat       AS CHAR FORMAT "x(10)"     INIT ""   /*  21  วันที่แจ้งประกัน*/                                                 
    FIELD enttim       AS CHAR FORMAT "x(8)"      INIT ""   /*  22  เวลาแจ้งประกัน*/                                                     
    FIELD not_code     AS CHAR FORMAT "x(4)"      INIT ""   /*  23  รหัสแจ้งงาน*/                                                             
    FIELD premt        AS CHAR FORMAT "x(11)"     INIT ""   /*  24  prem.1  17037.61    */                                                             
    FIELD comp_prm     AS CHAR FORMAT "x(9)"      INIT ""   /*  25  comp.prm    645.21  */                                                             
    FIELD stk          AS CHAR FORMAT "x(25)"     INIT ""   /*  26  sticker         */                                                                 
    FIELD brand        AS CHAR FORMAT "x(50)"     INIT ""   /*  27  brand   TOYOTA SOLUNA 1.5 (A/T) */                                                 
    FIELD moo          AS CHAR FORMAT "x(50)"     INIT ""   /*  A55-0184 */
    FIELD soy          AS CHAR FORMAT "x(50)"     INIT ""   /*  A55-0184 */
    FIELD road         AS CHAR FORMAT "x(50)"     INIT ""   /*  A55-0184 */
    FIELD addr1        AS CHAR FORMAT "x(50)"     INIT ""   /*  28  address1    230 ซอยท่าเตียน */                                                     
    FIELD tambon       AS CHAR FORMAT "x(60)"     INIT ""   /*  29  address2    แขวงพระบรมมหาราชวัง */                                                 
    FIELD amper        AS CHAR FORMAT "x(30)"     INIT ""   /*  30  address3    เขตพระนคร   */                                                         
    FIELD country      AS CHAR FORMAT "x(60)"     INIT ""   /*  31  address4    กรุงเทพมหานคร 10200 */
    FIELD tiname       AS CHAR FORMAT "x(45)"     INIT ""   /*  32  title name  นาย */                                                             
    FIELD insnam       AS CHAR FORMAT "x(65)"     INIT ""   /*  33  first name  วิรัตน์ ศิลาสุวรรณ  */                                                 
    FIELD benname      AS CHAR FORMAT "x(150)"    INIT ""   /*  34  beneficiary     ระบุ 8.3 ธนาคารทิสโก้ จำกัด (มหาชน) */                             
    FIELD remark       AS CHAR FORMAT "x(10)"     INIT ""   /*  35  remark.   Confirmation_MV20020331_70040411_Confirmation_MV20020331_70040411   */ 
    FIELD Account_no   AS CHAR FORMAT "x(10)"     INIT ""   /*  36  account no.*/                                                         
    FIELD client_no    AS CHAR FORMAT "x(7)"      INIT ""    /*  37  client No.*/                                                             
    FIELD expdat       AS CHAR FORMAT "X(10)"     INIT ""   /*  38  expiry date */                                                     
    FIELD gap          AS CHAR FORMAT "x(15)"     INIT ""   /*  39  insurance amt. */                                                 
    FIELD re_country   AS CHAR FORMAT "x(30)"     INIT ""   /*  40  province */                                                                 
    FIELD receipt_name AS CHAR FORMAT "x(50)"     INIT ""   /*  41  receipt name */             
    FIELD agent        AS CHAR FORMAT "x(50)"     INIT ""   /*  42  agent code  TISCO*/                                                     
    FIELD prepol       AS CHAR FORMAT "X(15)"     INIT ""   /*  44  old policy          */                                                             
    FIELD deduct       AS CHAR FORMAT "x(10)"     INIT ""   /*  45  deduct disc.    0   */                                                             
    FIELD branch       AS CHAR FORMAT "x(2)"      INIT ""   /*  46  branch      b   */ 
    FIELD tp1          AS CHAR FORMAT "x(15)"     INIT ""   /*  48  tp1             */                                                                 
    FIELD tp2          AS CHAR FORMAT "x(15)"     INIT ""   /*  49  tp2             */                                                                 
    FIELD tp3          AS CHAR FORMAT "x(15)"     INIT ""   /*  50  tp3             */                                                                 
    FIELD covcod       AS CHAR FORMAT "x(1)"      INIT ""   /*  51  covcod      1   */                                                                 
    FIELD compul       AS CHAR FORMAT "x"         INIT "n"  
    FIELD model        AS CHAR FORMAT "x(40)"     INIT ""  
    FIELD seat         AS INTE FORMAT "99"        INIT ""  
    FIELD comper       AS CHAR FORMAT "x(14)"     INIT ""  
    FIELD comacc       AS CHAR FORMAT "X(14)"     INIT ""  
    FIELD deductpd     AS CHAR FORMAT "x(15)"     INIT ""  
    FIELD cargrp       AS CHAR FORMAT "x(2)"      INIT ""  
    FIELD body         AS CHAR FORMAT "X(20)"     INIT ""  
    FIELD NO_41        AS CHAR FORMAT "x(14)"     INIT ""    
    FIELD NO_42        AS CHAR FORMAT "x(14)"     INIT ""   
    FIELD NO_43        AS CHAR FORMAT "x(14)"     INIT ""  
    FIELD comment      AS CHAR FORMAT "x(512)"    INIT ""
    FIELD producer     AS CHAR FORMAT "x(10)"     INIT ""   
    FIELD trandat      AS CHAR FORMAT "x(10)"     INIT ""      
    FIELD trantim      AS CHAR FORMAT "x(8)"      INIT ""       
    FIELD n_IMPORT     AS CHAR FORMAT "x(2)"      INIT ""       
    FIELD n_EXPORT     AS CHAR FORMAT "x(2)"      INIT "" 
    FIELD poltyp       AS CHAR FORMAT "x(3)"      INIT "" 
    FIELD pass         AS CHAR FORMAT "x"         INIT "n"
    FIELD OK_GEN       AS CHAR FORMAT "X"         INIT "Y" 
    FIELD renpol       AS CHAR FORMAT "x(20)"     INIT ""     
    FIELD cr_2         AS CHAR FORMAT "x(20)"     INIT ""  
    FIELD docno        AS CHAR INIT ""            FORMAT "x(10)" 
    FIELD redbook      AS CHAR INIT ""            FORMAT "X(10)"
    FIELD drivnam      AS CHAR FORMAT "x"         INIT "n" 
    FIELD tariff       AS CHAR FORMAT "x(2)"      INIT "9"
    FIELD weight       AS CHAR FORMAT "x(5)"      INIT ""
    FIELD cancel       AS CHAR FORMAT "x(2)"      INIT ""    
    FIELD accdat       AS CHAR INIT ""  FORMAT "x(10)"   
    FIELD prempa       AS CHAR FORMAT "x(4)"    INIT ""       
    /*FIELD subclass     AS CHAR FORMAT "x(4)"    INIT ""   */ /*A67-0185*/
    FIELD subclass     AS CHAR FORMAT "x(5)"    INIT ""       /*A67-0185*/ 
    FIELD cndat        AS CHAR FORMAT "x(10)"   INIT ""   
    FIELD WARNING      AS CHAR FORMAT "X(30)"   INIT ""
    FIELD seat41       AS INTE FORMAT "99"      INIT 0 
    FIELD financecd    AS CHAR FORMAT "x(60)"   INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD firstName    AS CHAR FORMAT "x(60)"   INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD lastName     AS CHAR FORMAT "x(60)"   INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD postcd       AS CHAR FORMAT "x(15)"   INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeocc      AS CHAR FORMAT "x(4)"    INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr1    AS CHAR FORMAT "x(2)"    INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr2    AS CHAR FORMAT "x(2)"    INIT ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr3    AS CHAR FORMAT "x(2)"    INIT ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD br_insured   AS CHAR FORMAT "x(5)"    INIT ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD campaign_ov  AS CHAR FORMAT "x(30)"   INIT ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
    FIELD insnamtyp    AS CHAR FORMAT "x(60)"   INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    /* A67-0114 */
    FIELD Schanel       AS Char FORMAT "X(1)"   init "" 
    FIELD bev           AS Char FORMAT "X(1)"   init "" 
    FIELD campagin      AS Char FORMAT "X(20)"  init "" 
    FIELD inspic        AS Char FORMAT "X(1)"   init "" 
    FIELD engcount      AS Char FORMAT "X(2)"   init "" 
    FIELD engno2        AS Char FORMAT "X(35)"  init "" 
    FIELD engno3        AS Char FORMAT "X(35)"  init "" 
    FIELD engno4        AS Char FORMAT "X(35)"  init "" 
    FIELD engno5        AS Char FORMAT "X(35)"  init "" 
    FIELD classcomp     AS Char FORMAT "X(5)"   init ""  
    FIELD carbrand      AS CHAR FORMAT "X(50)"  INIT "" 
    FIELD drilevel      AS CHAR FORMAT "x(5)"   INIT "" 
    FIELD hp            AS CHAR FORMAT "x(10)"  INIT ""
    FIELD maksi         AS CHAR FORMAT "x(15)"  INIT ""
    /*FIELD n_class70     AS CHAR FORMAT "x(3)" INIT "" */ /*A67-0185*/
    FIELD n_class70     AS CHAR FORMAT "x(5)"  INIT ""   /*A67-0185*/
    FIELD watt          AS CHAR FORMAT "x(10)" INIT "" 
    FIELD battyr        AS CHAR FORMAT "x(4)"  INIT ""
    FIELD battper       AS DECI FORMAT ">>9"   INIT 0.    
    /* end A67-0114 */

DEF VAR nv_chkerror    AS CHAR FORMAT "x(250)"  INIT "".   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
DEF VAR nv_postcd      AS CHAR FORMAT "x(15)"   INIT "" .   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
DEF NEW SHARED VAR     nv_message AS char.
DEF            VAR     c          AS CHAR.
DEF            VAR     nv_riskgp  LIKE sic_bran.uwm120.riskgp NO-UNDO.
DEFINE NEW SHARED VAR  no_baseprm AS DECI  FORMAT ">>,>>>,>>9.99-".  
DEFINE NEW SHARED VAR  NO_basemsg AS CHAR  FORMAT "x(50)" .          
DEFINE            VAR  nv_accdat  AS DATE  FORMAT "99/99/9999" INIT ?  .     
DEFINE            VAR  nv_docno   AS CHAR  FORMAT "9999999"    INIT " ".
DEFINE NEW SHARED VAR  nv_batchyr   AS INT FORMAT "9999"       INIT 0.
DEFINE NEW SHARED VAR  nv_batcnt    AS INT FORMAT "99"         INIT 0.
DEFINE NEW SHARED VAR  nv_batchno   AS CHARACTER FORMAT "X(13)"     INIT ""  NO-UNDO.
DEFINE VAR  nv_batrunno  AS INT  FORMAT ">,>>9"          INIT 0.
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
DEF VAR n_ratmin  AS INTE INIT 0.
DEF VAR n_ratmax  AS INTE INIT 0.
DEF VAR n_policy72 AS CHAR FORMAT "x(20)" INIT "" .
DEF WORKFILE wclass
    FIELD wvehuse  AS CHAR FORMAT "x"
    FIELD wclass   AS CHAR FORMAT "x(10)"
    FIELD wbase    AS DECI FORMAT "->>>,>>9.99".
DEF  VAR n_41   AS DECI     FORMAT ">,>>>,>>9.99" INIT 0.
DEF  VAR n_42   AS DECI     FORMAT ">,>>>,>>9.99" INIT 0.
DEF  VAR n_43   AS DECI     FORMAT ">,>>>,>>9.99" INIT 0.
DEFINE VAR nv_txt1    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt2    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt3    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt4    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt5    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_line1   AS INTEGER   INITIAL 0            NO-UNDO.
/*add A55-0325 */
DEFINE VAR nv_insref   AS CHARACTER FORMAT "X(10)".          
DEFINE VAR n_insref    AS CHARACTER FORMAT "X(10)".  
DEF VAR nv_usrid    AS CHARACTER FORMAT "X(08)".             
DEF VAR nv_transfer AS LOGICAL   .                            
DEF VAR n_check     AS CHARACTER .                            
DEF VAR nv_typ      AS CHAR FORMAT "X(2)".    
DEF VAR n_icno      AS CHAR FORMAT "x(13)".
/*add A55-0325 */
DEFINE VAR nr_prempa    AS CHARACTER FORMAT "X".      /*A56-0323*/         
DEFINE VAR nr_subclass  AS CHARACTER FORMAT "X(5)".   /*A56-0323*/  

