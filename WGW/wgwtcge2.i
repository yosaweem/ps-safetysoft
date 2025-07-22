/*programid   : wgwtbgen.i                                            */
/*programname : load text file Tisco to GW                              */
/* Copyright  : Safety Insurance Public Company Limited 			  */
/*			  บริษัท ประกันคุ้มภัย จำกัด (มหาชน)				  */
/*create by   : Kridtiya i. A53-0207  date . 29/06/2010             
              ปรับโปรแกรมให้สามารถนำเข้า text file tisco to GW system */ 
/*copy write  : wgwargen.i                                            */
/*modify by   : Kridtiya i. A54-0061 date 05042011 */
/**********************************************************************/
DEFINE NEW SHARED TEMP-TABLE wdetail2
    /*FIELD recordID   AS CHAR FORMAT "x(2)"   INIT ""*/
    FIELD Pro_off      AS CHAR FORMAT "x(2)"  INIT ""   /*  1   Processing Office*/                                                         
    FIELD cmr_code     AS CHAR FORMAT "x(5)"  INIT ""   /*  2   CMR  code*/                                                                 
    FIELD comcode      AS CHAR FORMAT "x(3)"  INIT ""   /*  3   Insur.comp*/                                                                 
    FIELD policyno     AS CHAR FORMAT "x(25)" INIT ""   /*  4   notify number*/                                                     
    FIELD caryear      AS CHAR FORMAT "x(4)"  INIT ""   /*  5   Caryear*/                                                             
    FIELD eng          AS CHAR FORMAT "x(25)" INIT ""   /*  6   Engine*/                                                             
    FIELD chasno       AS CHAR FORMAT "x(25)" INIT ""   /*  7   Chassis*/                                                 
    FIELD engcc        AS CHAR FORMAT "x(7)"  INIT ""   /*  8   Weight*/                                                                 
    FIELD power        AS CHAR FORMAT "x(7)"  INIT ""   /*  9   Power */                                                                 
    FIELD colorcode    AS CHAR FORMAT "x(20)" INIT ""   /*  10  Color*/                                                             
    FIELD vehreg       AS CHAR FORMAT "x(10)" INIT ""   /*  11  licence no*/                                                             
    FIELD garage       AS CHAR FORMAT "x(1)"  INIT ""   /*  12  garage*/                                                                     
    FIELD fleetper     AS CHAR FORMAT "X(5)"  INIT ""   /*  13  fleet disc.*/                                                             
    FIELD ncb          AS CHAR FORMAT "X(5)"  INIT ""   /*  14  ncb disc.*/                                                                 
    FIELD orthper      AS CHAR FORMAT "X(5)"  INIT ""   /*  15  other disc.*/                                                             
    FIELD vehuse       AS CHAR FORMAT "x(1)"  INIT ""   /*  16  vehuse*/                                                                     
    FIELD comdat       AS CHAR FORMAT "x(10)" INIT ""   /*  17  comdat */                                                         
    FIELD si           AS CHAR FORMAT "x(13)" INIT ""   /*  18  sum si */                                                                 
    FIELD name_insur   AS CHAR FORMAT "x(20)" INIT ""   /*  19  ชื่อเจ้าหน้าที่ประกัน*/                                         
    FIELD not_office   AS CHAR FORMAT "x(75)" INIT ""   /*  20  รหัสเจ้าหน้าที่แจ้งประกัน*/
    FIELD entdat       AS CHAR FORMAT "x(10)" INIT ""   /*  21  วันที่แจ้งประกัน*/                                                 
    FIELD enttim       AS CHAR FORMAT "x(8)"  INIT ""   /*  22  เวลาแจ้งประกัน*/                                                     
    FIELD not_code     AS CHAR FORMAT "x(4)"  INIT ""   /*  23  รหัสแจ้งงาน*/                                                             
    FIELD premt        AS CHAR FORMAT "x(11)" INIT ""   /*  24  prem.1  17037.61    */                                                             
    FIELD comp_prm     AS CHAR FORMAT "x(9)"  INIT ""   /*  25  comp.prm    645.21  */                                                             
    FIELD stk          AS CHAR FORMAT "x(25)" INIT ""   /*  26  sticker         */                                                                 
    FIELD brand        AS CHAR FORMAT "x(50)" INIT ""   /*  27  brand   TOYOTA SOLUNA 1.5 (A/T) */                                                 
    FIELD addr1        AS CHAR FORMAT "x(50)" INIT ""   /*  28  address1    230 ซอยท่าเตียน */                                                     
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
    FIELD prev_insur   AS CHAR FORMAT "x(50)" INIT ""   /*  43  บริษัทประกันภัยเดิม */     
    FIELD prepol       AS CHAR FORMAT "X(15)"  INIT ""  /*  44  old policy          */                                                             
    FIELD deduct       AS CHAR FORMAT "x(10)" INIT ""   /*  45  deduct disc.    0   */                                                             
    FIELD branch       AS CHAR FORMAT "x(2)"  INIT ""   /*  46  branch      b   */                                                                 
    FIELD prempa       AS CHAR FORMAT "x(5)"  INIT ""   /*  47  prempa      g110    */                                                             
    FIELD tp1          AS CHAR FORMAT "x(30)" INIT ""   /*  48  tp1             */                                                                 
    FIELD tp2          AS CHAR FORMAT "x(30)" INIT ""   /*  49  tp2             */                                                                 
    FIELD tp3          AS CHAR FORMAT "x(5)"  INIT ""   /*  50  tp3             */                                                                 
    FIELD covcod       AS CHAR FORMAT "x(14)" INIT "" .  /*  51  covcod      1   */                                                                 
    /*FIELD compul       AS CHAR FORMAT "x"     INIT "n"  
    FIELD pass         AS CHAR FORMAT "x(40)" INIT ""   
    FIELD model         AS CHAR FORMAT "x(2)"  INIT ""  
    FIELD seat          AS CHAR FORMAT "x(14)" INIT ""  
    FIELD comper        AS CHAR FORMAT "x(14)" INIT ""  
    FIELD comacc        AS CHAR FORMAT "X(14)" INIT ""  
    FIELD deductpd      AS CHAR FORMAT "x(30)" INIT ""  
    FIELD road          AS CHAR FORMAT "x"     INIT ""  
    FIELD cargrp        AS CHAR FORMAT "x(40)" INIT ""  
    FIELD body          AS CHAR FORMAT "X(14)" INIT ""  *//*60*/
DEFINE NEW SHARED TEMP-TABLE wdetail 
    FIELD policyno     AS CHAR FORMAT "x(25)" INIT ""   /*  4   notify number*/                                                     
    FIELD caryear      AS CHAR FORMAT "x(4)"  INIT ""   /*  5   Caryear*/                                                             
    FIELD eng          AS CHAR FORMAT "x(25)" INIT ""   /*  6   Engine*/                                                             
    FIELD chasno       AS CHAR FORMAT "x(25)" INIT ""   /*  7   Chassis*/                                                 
    FIELD engcc        AS CHAR FORMAT "x(7)"  INIT ""   /*  8   Weight*/ 
    FIELD tonss        AS CHAR FORMAT "x(7)"  INIT ""   /*  8   Weight*/  
    FIELD vehreg       AS CHAR FORMAT "x(10)" INIT ""   /*  11  licence no*/                                                             
    FIELD garage       AS CHAR FORMAT "x(1)"  INIT ""   /*  12  garage*/                                                                     
    FIELD fleetper     AS DECI FORMAT ">>>>>9.99"  INIT ""   /*  13  fleet disc.*/                                                             
    FIELD ncb          AS DECI FORMAT ">>>>>9.99"  INIT ""   /*  14  ncb disc.*/                                                                 
    FIELD orthper      AS CHAR FORMAT "X(5)"  INIT ""   /*  15  other disc.*/                                                             
    FIELD vehuse       AS CHAR FORMAT "x(1)"  INIT ""   /*  16  vehuse*/                                                                     
    FIELD comdat       AS CHAR FORMAT "x(10)" INIT ""   /*  17  comdat */                                                         
    FIELD si           AS CHAR FORMAT "x(13)" INIT ""   /*  18  sum si */                                                                 
    FIELD name_insur   AS CHAR FORMAT "x(20)" INIT ""   /*  19  ชื่อเจ้าหน้าที่ประกัน*/                                         
    FIELD not_office   AS CHAR FORMAT "x(75)" INIT ""   /*  20  รหัสเจ้าหน้าที่แจ้งประกัน*/
    FIELD entdat       AS CHAR FORMAT "x(10)" INIT ""   /*  21  วันที่แจ้งประกัน*/                                                 
    FIELD enttim       AS CHAR FORMAT "x(8)"  INIT ""   /*  22  เวลาแจ้งประกัน*/                                                     
    FIELD not_code     AS CHAR FORMAT "x(4)"  INIT ""   /*  23  รหัสแจ้งงาน*/                                                             
    FIELD premt        AS CHAR FORMAT "x(11)" INIT ""   /*  24  prem.1  17037.61    */                                                             
    FIELD comp_prm     AS CHAR FORMAT "x(9)"  INIT ""   /*  25  comp.prm    645.21  */                                                             
    FIELD stk          AS CHAR FORMAT "x(25)" INIT ""   /*  26  sticker         */                                                                 
    FIELD brand        AS CHAR FORMAT "x(50)" INIT ""   /*  27  brand   TOYOTA SOLUNA 1.5 (A/T) */                                                 
    FIELD addr1        AS CHAR FORMAT "x(50)" INIT ""   /*  28  address1    230 ซอยท่าเตียน */                                                     
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
    FIELD NO_41          AS CHAR FORMAT "x(14)" INIT ""  
   /* FIELD tp_bi          AS CHAR FORMAT "x(14)" INIT ""  
    FIELD tp_bi2         AS CHAR FORMAT "x(14)" INIT ""  
    FIELD tp_bi3         AS CHAR FORMAT "x(14)" INIT ""  */
      /*FIELD ac2            AS CHAR FORMAT "x(2)"  INIT "" */   
      FIELD NO_42          AS CHAR FORMAT "x(14)" INIT ""   
      /*FIELD ac4            AS CHAR FORMAT "x(14)" INIT ""    
      FIELD ac5            AS CHAR FORMAT "x(2)"  INIT ""    
      FIELD ac6            AS CHAR FORMAT "x(14)" INIT ""    
      FIELD ac7            AS CHAR FORMAT "x(14)" INIT "" */   
      FIELD NO_43          AS CHAR FORMAT "x(14)" INIT ""      
      /*FIELD nstatus        AS CHAR FORMAT "x(6)"  INIT ""    
      FIELD typrequest     AS CHAR FORMAT "x(10)" INIT ""    
      FIELD comrequest     AS CHAR FORMAT "x(10)" INIT ""      
      FIELD brrequest      AS CHAR FORMAT "x(30)" INIT ""      
      FIELD salename       AS CHAR FORMAT "x(80)" INIT ""      
      FIELD comcar         AS CHAR FORMAT "x(10)" INIT ""      
      FIELD brcar          AS CHAR FORMAT "x(30)" INIT ""      
      FIELD projectno      AS CHAR FORMAT "x(12)" INIT ""      
      FIELD caryear        AS CHAR FORMAT "x(3)"  INIT ""      
      FIELD special1       AS CHAR FORMAT "x(10)" INIT ""      
      FIELD specialprem1   AS CHAR FORMAT "x(14)" INIT ""      
      FIELD special2       AS CHAR FORMAT "x(10)" INIT ""      
      FIELD specialprem2   AS CHAR FORMAT "x(14)" INIT ""      
      FIELD special3       AS CHAR FORMAT "x(10)" INIT ""      
      FIELD specialprem3   AS CHAR FORMAT "x(14)" INIT ""      
      FIELD special4       AS CHAR FORMAT "x(10)" INIT ""      
      FIELD specialprem4   AS CHAR FORMAT "x(14)" INIT ""      
      FIELD special5       AS CHAR FORMAT "x(10)" INIT ""      
      FIELD specialprem5   AS CHAR FORMAT "x(14)" INIT "" */     
      FIELD comment        AS CHAR FORMAT "x(512)"  INIT ""
      FIELD producer       AS CHAR FORMAT "x(10)" INIT ""   
      FIELD trandat        AS CHAR FORMAT "x(10)" INIT ""      
      FIELD trantim        AS CHAR FORMAT "x(8)" INIT ""       
      FIELD n_IMPORT       AS CHAR FORMAT "x(2)" INIT ""       
      FIELD n_EXPORT       AS CHAR FORMAT "x(2)" INIT "" 
      FIELD poltyp         AS CHAR FORMAT "x(3)" INIT "" 
      FIELD pass           AS CHAR FORMAT "x"  INIT "n"
      FIELD OK_GEN         AS CHAR FORMAT "X" INIT "Y" 
      FIELD renpol         AS CHAR FORMAT "x(20)" INIT ""     
      FIELD cr_2           AS CHAR FORMAT "x(20)" INIT ""  
      FIELD docno          AS CHAR INIT "" FORMAT "x(10)" 
      FIELD redbook        AS CHAR INIT "" FORMAT "X(10)"
      FIELD drivnam        AS CHAR FORMAT "x" INIT "n" 
      FIELD tariff         AS CHAR FORMAT "x(2)" INIT "9"
      /*FIELD weight         AS CHAR FORMAT "x(5)" INIT ""*/
      FIELD cancel         AS CHAR FORMAT "x(2)" INIT ""    
      FIELD accdat         AS CHAR INIT "" FORMAT "x(10)"   
      FIELD prempa         AS CHAR FORMAT "x(4)" INIT ""       
      FIELD subclass       AS CHAR FORMAT "x(4)" INIT ""    
      FIELD cndat          AS CHAR FORMAT "x(10)" INIT ""   
      FIELD WARNING        AS CHAR FORMAT "X(30)" INIT ""
      FIELD seat41         AS INTE FORMAT "99" INIT 0
      /*FIELD volprem     AS CHAR FORMAT "x(20)" INIT "" 
      FIELD Compprem    AS CHAR FORMAT "x(20)" INIT "" */
      /*FIELD ac_no       AS CHAR FORMAT "x(15)" INIT ""
      FIELD ac_date     AS CHAR FORMAT "x(10)" INIT ""
      FIELD ac_amount   AS CHAR FORMAT "x(14)" INIT ""
      FIELD ac_pay      AS CHAR FORMAT "x(10)" INIT ""
      FIELD ac_agent    AS CHAR FORMAT "x(20)" INIT ""
      FIELD n_branch    AS CHAR FORMAT "x(5)" INIT "" 
      FIELD n_delercode AS CHAR FORMAT "x(15)" INIT "" 
      FIELD voictitle   AS CHAR FORMAT "x(1)" INIT ""       
      FIELD voicnam     AS CHAR FORMAT "x(120)" INIT ""       
      FIELD detailcam   AS CHAR FORMAT "x(100)" INIT ""        
      FIELD ins_pay     AS CHAR FORMAT "x(2)" INIT "" */    .
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
DEF VAR n_ratmin  AS INTE INIT 0.
DEF VAR n_ratmax  AS INTE INIT 0.


