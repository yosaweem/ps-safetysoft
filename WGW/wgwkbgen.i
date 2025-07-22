/*Create by : Kridtiya i. A55-0128..Program Load Text file KTBL .*/
/*modify by : Kridtiya i. A55-0301  เพิ่มข้อมูลผู้เอาประกันภัย   */
/*modify by : Kridtiya i. A56-0310  เพิ่มตัวแปร ตามฟอร์แมทใหม่   */
DEFINE NEW SHARED WORKFILE wdetail2  
    FIELD   recno        AS CHAR FORMAT "x(10)"  INIT ""  /* 1   */  
    FIELD   Notify_dat   AS CHAR FORMAT "x(12)"  INIT ""  /* 2   วันที่แจ้ง      */                                   
    FIELD   comp_code    AS CHAR FORMAT "x(40)"  INIT ""  /* 3   บริษัทประกัน        */                               
    FIELD   notifyno     AS CHAR FORMAT "x(30)"  INIT ""  /* 4   เลขที่รับแจ้ง       */                               
    FIELD   NAME_mkt     AS CHAR FORMAT "x(60)"  INIT ""  /* 5   ชื่อผู้แจ้ง     */                                   
    FIELD   ref          AS CHAR FORMAT "x(30)"  INIT ""  /* 6   เลขที่ใบคำขอ        */ 
    FIELD   n_TITLE      AS CHAR FORMAT "x(30)"  INIT ""  /* 7   คำนำหน้า        */                                       
    FIELD   n_name1      AS CHAR FORMAT "x(100)"  INIT ""  /* 8   ชื่อผู้เอาประกัน        */                           
    FIELD   sex          AS CHAR FORMAT "x(20)"  INIT ""  /* 9   เพศ     */                                           
    FIELD   idno         AS CHAR FORMAT "x(15)"  INIT ""  /* 10  เลขบัตรประชาชน      */                               
    FIELD   brithday     AS CHAR FORMAT "x(20)"  INIT ""  /* 11  วันเดือนปี เกิด     */                               
    FIELD   accoup       AS CHAR FORMAT "x(100)" INIT ""  /* 12  อาชีพ       */                                       
    FIELD   brand        AS CHAR FORMAT "x(30)"  INIT ""  /* 13  ชื่อรถยนต์      */                                   
    FIELD   model        AS CHAR FORMAT "x(100)" INIT ""  /* 14  รุ่น        */                                       
    FIELD   cyear        AS CHAR FORMAT "x(10)"  INIT ""  /* 15  ปีรุ่น      */                                       
    FIELD   cov_car      AS CHAR FORMAT "x(20)"  INIT ""  /* 16  แบบตัวถัง       */                                   
    FIELD   vehuse       AS CHAR FORMAT "x(20)"  INIT ""  /* 17  ลักษณะการใช้รถยนต์      */                           
    FIELD   power        AS CHAR FORMAT "x(10)"  INIT ""  /* 18  ซี.ซี.      */                                       
    FIELD   engine       AS CHAR FORMAT "x(30)"  INIT ""  /* 19  เลขเครื่องยนต์      */                               
    FIELD   chassis      AS CHAR FORMAT "x(30)"  INIT ""  /* 20  เลขตัวถัง       */                                   
    FIELD   licence      AS CHAR FORMAT "x(40)"  INIT ""  /* 21  ทะเบียน     */                                       
    FIELD   cov_new      AS CHAR FORMAT "x(20)"  INIT ""  /* 22  New Used    */                                       
    FIELD   comdat       AS CHAR FORMAT "x(12)"  INIT ""  /* 23  กรมธรรม์ภาคสมัครใจ  เริ่มต้นคุ้มครอง    */           
    FIELD   expdat       AS CHAR FORMAT "x(12)"  INIT ""  /* 24  สิ้นสุดวันที่   */                                 
    FIELD   covcod       AS CHAR FORMAT "x(20)"  INIT ""  /* 25  ประเภท  */                                       
    FIELD   ins_amt1     AS CHAR FORMAT "x(30)"  INIT ""  /* 26  ทุนประกันภัย    */                                 
    FIELD   prem1        AS CHAR FORMAT "x(30)"  INIT ""  /* 27  ค่าเบี้ยประกัน  */                                 
    FIELD   comprem      AS CHAR FORMAT "x(20)"  INIT ""  /* 28  กรมธรรม์ภาคบังคับ (พ.ร.บ.)  ค่า พ.ร.บ.  */             
    FIELD   comdat72     AS CHAR FORMAT "x(12)"  INIT ""  /* 29  วันที่คุ้มครอง พ.ร.บ.   */                         
    FIELD   expdat72     AS CHAR FORMAT "x(12)"  INIT ""  /* 30  วันที่สิ้นสุด พ.ร.บ.    */                       
    FIELD   sck          AS CHAR FORMAT "x(20)"  INIT ""  /* 31  เลขเครื่องหมาย พ.ร.บ.   */                       
    FIELD   prem2        AS CHAR FORMAT "x(30)"  INIT ""  /* 32  เบี้ยประกันภัยรวม พ.ร.บ.        */                     
    FIELD   pricar       AS CHAR FORMAT "x(30)"  INIT ""  /* 33  ราคารถ      */                                         
    FIELD   pricar2      AS CHAR FORMAT "x(30)"  INIT ""  /* 34  ยอดจัด      */                                       
    FIELD   driname1     AS CHAR FORMAT "x(60)"  INIT ""  /* 35  ประเภทการประกันภัยที่ต้องการ    ระบุชื่อผู้ขับขี่ 1 */
    FIELD   driname2     AS CHAR FORMAT "x(60)"  INIT ""  /* 36  ระบุชื่อผู้ขับขี่ 2 */                           
    FIELD   bennam       AS CHAR FORMAT "x(100)" INIT ""  /* 37  ผู้รับผลประโยชน์        */                           
    FIELD   ADD_1        AS CHAR FORMAT "x(150)" INIT ""  /* 38  ที่อยู่ที่จัดส่งกรมธรรม์        */                   
    FIELD   ADD_2        AS CHAR FORMAT "x(50)"  INIT ""  /* 38  ที่อยู่ที่จัดส่งกรมธรรม์        */                   
    FIELD   ADD_3        AS CHAR FORMAT "x(50)"  INIT ""  /* 38  ที่อยู่ที่จัดส่งกรมธรรม์        */                   
    FIELD   ADD_4        AS CHAR FORMAT "x(50)"  INIT ""  /* 38  ที่อยู่ที่จัดส่งกรมธรรม์        */                   
    FIELD   remak1       AS CHAR FORMAT "x(150)" INIT ""  /* 39  เงื่อนไขพิเศษ       */                               
    FIELD   deler        AS CHAR FORMAT "x(100)" INIT ""  /* 40  Dealer      */                                       
    FIELD   addr_deler   AS CHAR FORMAT "x(150)" INIT ""  /* 41  ที่อยู่ Dealer      */                               
    FIELD   notiuser     AS CHAR FORMAT "x(50)"  INIT ""  /* 42  แจ้งประกันโดย       */                                    
    FIELD   cedpol       AS CHAR FORMAT "x(20)"  INIT ""  /* 43   เลขที่สัญญา     */                                  
    FIELD   refince      AS CHAR FORMAT "x(50)"  INIT ""  /* 44   รถใหม่/รถเก่า/Refinance   */                   
    FIELD   branch2      AS CHAR FORMAT "x(10)"  INIT "" 
    FIELD   branchktb    AS CHAR FORMAT "x(50)"  INIT ""  /* A56-0310 สาขา KTBL             */    
    FIELD   delerktb     AS CHAR FORMAT "x(150)" INIT ""  /* A56-0310 Dealer                */    
    FIELD   noti_name    AS CHAR FORMAT "x(50)"  INIT ""  /* A56-0310 ผู้บันทึกข้อมูลประกัน */    
    FIELD   campaign     AS CHAR FORMAT "x(30)"  INIT ""  /* A56-0310 Campaign              */    
    FIELD   booking      AS CHAR FORMAT "x(20)"  INIT ""  /* A56-0310 วัน Booking           */    
    FIELD   si_ktb       AS CHAR FORMAT "x(20)"  INIT ""  /* A56-0310 ทุนประกัน             */    
    FIELD   premt_ktb    AS CHAR FORMAT "x(20)"  INIT ""  /* A56-0310 ค่าเบี้ย              */    .
DEFINE NEW SHARED TEMP-TABLE wdetail
      FIELD cedpol      AS CHAR FORMAT "x(25)"  INIT "" 
      FIELD campaigno   AS CHAR FORMAT "X(20)"  INIT ""    /*  11 บุคคล/นิติบุคคล */                        
      FIELD notiuser    AS CHAR FORMAT "X(50)"  INIT ""    /*  52 บ้านเลขที่ (ใบเสร็จ/ใบกำกับภาษี)    */    
      FIELD branch      AS CHAR FORMAT "x(10)"  INIT "" 
      FIELD entdat      AS CHAR FORMAT "x(10)"  INIT ""    /*entry date*/
      FIELD enttim      AS CHAR FORMAT "x(8)"   INIT ""    /*entry time*/
      FIELD trandat     AS CHAR FORMAT "x(10)"  INIT ""    /*tran date*/
      FIELD trantim     AS CHAR FORMAT "x(8)"   INIT ""    /*tran time*/
      FIELD vatcode     AS CHAR FORMAT "x(10)"  INIT ""    /*A55-0046*/
      FIELD poltyp      AS CHAR FORMAT "x(3)"   INIT ""    /*policy type*/
      FIELD policy      AS CHAR FORMAT "x(20)"  INIT ""    /*policy*/       /*a40166 chg format from 12 to 16*/
      FIELD prepol      AS CHAR FORMAT "x(20)"  INIT ""    /*renew policy*/ /*a40166 chg format from 12 to 16*/
      FIELD comdat      AS CHAR FORMAT "x(10)"  INIT ""    /*comm date*/
      FIELD expdat      AS CHAR FORMAT "x(10)"  INIT ""    /*expiry date*/
      FIELD compul      AS CHAR FORMAT "x"      INIT ""    /*compulsory*/
      FIELD tiname      AS CHAR FORMAT "x(15)"  INIT ""    /*title*/
      FIELD insnam      AS CHAR FORMAT "x(50)"  INIT ""    /*name*/
      FIELD name2       AS CHAR FORMAT "x(80)"  INIT ""    /*name2*/
      FIELD iadd1       AS CHAR FORMAT "x(150)" INIT ""    
      FIELD iadd2       AS CHAR FORMAT "x(35)"  INIT ""    
      FIELD iadd3       AS CHAR FORMAT "x(35)"  INIT ""    
      FIELD iadd4       AS CHAR FORMAT "x(35)"  INIT ""    
      FIELD prempa      AS CHAR FORMAT "x"      INIT ""    /*premium package*/
      FIELD subclass    AS CHAR FORMAT "x(3)"   INIT ""    /*sub class*/
      FIELD brand       AS CHAR FORMAT "x(30)"  INIT ""
      FIELD model       AS CHAR FORMAT "x(100)"  INIT ""
      FIELD cc          AS CHAR FORMAT "x(10)"  INIT ""
      FIELD weight      AS CHAR FORMAT "x(10)"  INIT ""
      FIELD seat        AS CHAR FORMAT "x(2)"   INIT ""
      FIELD body        AS CHAR FORMAT "x(20)"  INIT ""
      FIELD vehreg      AS CHAR FORMAT "x(11)"  INIT ""    /*vehicl registration*/
      FIELD engno       AS CHAR FORMAT "x(25)"  INIT ""    /*engine no*/
      FIELD chasno      AS CHAR FORMAT "x(25)"  INIT ""    /*chasis no*/
      FIELD caryear     AS CHAR FORMAT "x(4)"   INIT ""     
      FIELD vehuse      AS CHAR FORMAT "x"      INIT ""        /*vehicle use*/
      FIELD garage      AS CHAR FORMAT "x"      INIT ""        
      FIELD stk         AS CHAR FORMAT "x(15)"  INIT ""    
      FIELD access      AS CHAR FORMAT "x"      INIT ""        /*accessories*/
      FIELD covcod      AS CHAR FORMAT "x"      INIT ""        /*cover type*/
      FIELD product     AS CHAR FORMAT "X(30)"  INIT ""    /*  Add A55-0073   */
      FIELD si          AS CHAR FORMAT "x(25)"  INIT ""    /*sum insure*/
      FIELD volprem     AS CHAR FORMAT "x(20)"  INIT ""    /*voluntory premium*/
      FIELD fleet       AS CHAR FORMAT "x(10)"  INIT ""    /*fleet*/
      FIELD ncb         AS CHAR FORMAT "x(10)"  INIT ""    
      FIELD revday      AS CHAR FORMAT "x(10)"  INIT ""    
      /*FIELD deductpp    AS CHAR FORMAT "x(10)"  INIT ""    /*deduct da*/
      FIELD deductba    AS CHAR FORMAT "x(10)"  INIT ""    /*deduct da*/
      FIELD deductpa    AS CHAR FORMAT "x(10)"  INIT ""    /*deduct pd*/*/
      FIELD benname     AS CHAR FORMAT "x(100)" INIT ""   /*benificiary*/
      FIELD n_IMPORT    AS CHAR FORMAT "x(2)"   INIT ""     
      FIELD n_export    AS CHAR FORMAT "x(2)"   INIT ""  
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
      FIELD tariff      AS CHAR FORMAT "x(2)"   INIT ""      
      FIELD baseprem    AS INTE FORMAT ">,>>>,>>>,>>>,>>9" INIT  0
      FIELD cargrp      AS CHAR FORMAT "x(2)"  INIT ""      
      FIELD producer    AS CHAR FORMAT "x(10)" INIT ""      
      FIELD agent       AS CHAR FORMAT "x(10)" INIT ""      
      FIELD premt       AS CHAR FORMAT "x(10)" INIT ""
      FIELD redbook     AS CHAR INIT "" FORMAT "X(8)"     /*note add*/
      FIELD base        AS CHAR INIT "" FORMAT "x(8)"     /*Note add Base Premium 25/09/2006*/
      FIELD accdat      AS CHAR INIT "" FORMAT "x(10)"    /*Account Date For 72*/
      FIELD docno       AS CHAR INIT "" FORMAT "x(10)"    /*Docno For 72*/
      FIELD ICNO        AS CHAR INIT "" FORMAT "x(13)"    /*A55-0301*//*ICNO For COVER NOTE A51-0071 amparat*/
      FIELD brithday    AS CHAR INIT "" FORMAT "x(20)"    /*A55-0301*/
      FIELD accoup      AS CHAR INIT "" FORMAT "x(100)"   /*A55-0301*/
      FIELD CoverNote   AS CHAR INIT "" FORMAT "x(13)"    /*ระบุว่าเป็นงาน COVER NOTE A51-0071 amparat*/
      FIELD nmember     AS CHAR INIT "" FORMAT "x(255)" 
      FIELD nmember2    AS CHAR INIT "" FORMAT "x(255)"
      FIELD delerco     AS CHAR FORMAT "x(30)"  INIT ""  
      FIELD remak1      AS CHAR FORMAT "x(100)" INIT ""
      FIELD remak2      AS CHAR FORMAT "x(100)" INIT "" 
      FIELD typecar     AS CHAR FORMAT "x(30)"  INIT ""
      FIELD ispno       AS CHAR FORMAT "X(30)"  INIT ""  /*A55-0046*/  .
DEF VAR n_firstdat      AS CHAR FORMAT "x(10)"  INIT ""  .
def    NEW SHARED VAR   nv_message as   char.
DEF VAR nv_riskgp        LIKE sicuw.uwm120.riskgp                                  NO-UNDO.
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
DEF VAR n_setbranch     AS CHAR FORMAT "x(50)" INIT "" .
DEF VAR n_vehpro        AS CHAR FORMAT "x(50)" INIT "" .
DEF VAR n_campaign        AS CHAR FORMAT "x(50)" INIT "" .
DEF VAR n_proceder       AS CHAR FORMAT "x(12)" INIT "" .
DEFINE  WORKFILE wuppertxt3 NO-UNDO
/*1*/  FIELD line     AS INTEGER   FORMAT ">>9"
/*2*/  FIELD txt      AS CHARACTER FORMAT "X(78)"   INITIAL "". 
DEFINE  WORKFILE wcam NO-UNDO
/*1*/      FIELD campan    AS CHARACTER FORMAT "X(35)"   INITIAL ""
/*2*/      FIELD cover    AS CHARACTER FORMAT "X(5)"    INITIAL ""
           FIELD brand    AS CHARACTER FORMAT "X(30)"    INITIAL "".
DEFINE VAR nv_insref   AS CHARACTER FORMAT "X(10)".  
DEFINE VAR n_insref    AS CHARACTER FORMAT "X(10)". 
DEFINE VAR nv_messagein AS CHAR FORMAT "X(200)". 
DEF VAR nv_usrid    AS CHARACTER FORMAT "X(08)".
DEF VAR nv_transfer AS LOGICAL   .
DEF VAR n_check     AS CHARACTER .
DEF VAR putchr      AS CHAR FORMAT "X(200)" INIT "" NO-UNDO.
DEF VAR putchr1     AS CHAR FORMAT "X(100)" INIT "" NO-UNDO.
DEF VAR nv_typ      AS CHAR FORMAT "X(2)".
DEF BUFFER buwm100   FOR sic_bran.uwm100. 


