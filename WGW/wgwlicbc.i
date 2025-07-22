/*programid   : wgwsngen.i                                               */ 
/*programname : Load text file Sin_Asia to GW                            */ 
/*Copyright   : Safety Insurance Public Company Limited 			     */ 
/*			    บริษัท ประกันคุ้มภัย จำกัด (มหาชน)				         */ 
/* create by : Ranu I. A59-0288 Date : 30/09/2016                                    
                ปรับโปรแกรมให้สามารถนำเข้า text file icbc to GW system*/ 
/*copy write  : wgwargen.i                                               */ 
/*Modify by   : Ranu I. A60-0263 เพิ่มตัวแปรเก็บค่าแคมเปญ               */
/*Modify by   : Kridtiya i. A63-0472 Date. 09/11/2020 add field firstname ,lastname.....*/
/*Modify by : Ranu I. A64-0138 เพิ่มตัวแปรเก็บค่าการคำนวณเบี้ย */
/*Modify by : Krittapoj S. A65-0372 Date 16/01/2023 เพิ่มตัวแปร เก็บต่า สีรถยนต์ และ รหัสสีรถยนต์*/
/*************************************************************************/ 
DEFINE NEW SHARED TEMP-TABLE wdetail
    FIELD policy          AS CHAR FORMAT "x(25)" INIT ""   /* notify number*/  
    FIELD poltyp          AS CHAR FORMAT "x(3)"  INIT ""  
    FIELD occup           AS CHAR FORMAT "x(50)" INIT ""
    FIELD caryear         AS CHAR FORMAT "x(4)"  INIT ""   /* year         */  
    FIELD eng             AS CHAR FORMAT "x(25)" INIT ""   /* engine       */  
    FIELD chasno          AS CHAR FORMAT "x(25)" INIT ""   /* chassis      */  
    FIELD engcc           AS CHAR FORMAT "x(5)"  INIT ""   /* weight       */  
    FIELD vehreg          AS CHAR FORMAT "x(10)" INIT ""   /* licence no   */  
    FIELD garage          AS CHAR FORMAT "x(1)"  INIT ""   /* garage       */  
    FIELD idno            AS CHAR FORMAT "X(20)" INIT ""   /* fleet disc.  */  
    FIELD vehuse          AS CHAR FORMAT "x(1)"  INIT ""   /* vehuse       */  
    FIELD comdat          AS CHAR FORMAT "x(10)" INIT ""   /* comdat       */  
    FIELD expdat          AS CHAR FORMAT "x(10)" INIT ""   /* expiry date        */     
    FIELD si              AS CHAR FORMAT "x(15)" INIT ""   /* sum si       */  
    FIELD fire            AS CHAR FORMAT "x(15)" INIT ""   
    FIELD premt           AS CHAR FORMAT "x(15)" INIT ""   /*  prem.1            */  
    FIELD stk             AS CHAR FORMAT "x(25)" INIT ""   /* sticker            */  
    FIELD brand           AS CHAR FORMAT "x(60)" INIT ""   /* brand              */     
    FIELD addr1           AS CHAR FORMAT "x(150)" INIT ""  /* address1           */     
    FIELD addr2           AS CHAR FORMAT "x(60)" INIT ""   /* address2           */     
    FIELD addr3           AS CHAR FORMAT "x(60)" INIT ""  /* address1           */     
    FIELD addr4           AS CHAR FORMAT "x(60)" INIT ""   /* address2           */     
    FIELD tiname          AS CHAR FORMAT "x(30)" INIT ""   /* title name         */     
    FIELD insnam          AS CHAR FORMAT "x(55)" INIT ""   /* first name         */     
    FIELD np_name2        AS CHAR FORMAT "x(60)" INIT ""  
    FIELD np_name3        AS CHAR FORMAT "x(60)" INIT "" 
    FIELD benname         AS CHAR FORMAT "x(65)" INIT ""   /* beneficiary        */     
    FIELD cedpol          AS CHAR FORMAT "x(10)"  INIT ""  /* account no.        */     
    FIELD re_country      AS CHAR FORMAT "x(18)" INIT ""   /* province           */     
    FIELD receipt_name    AS CHAR FORMAT "x(50)" INIT ""   /* receipt name       */     
    FIELD prepol          AS CHAR FORMAT "x(25)" INIT ""   /* old policy         */     
    FIELD ncb             AS CHAR FORMAT "X(10)"  INIT ""  /* deduct disc.       */     
    /*FIELD add1_70         AS CHAR FORMAT "X(50)" INIT ""   /* ที่อยู่หน้าตาราง70 */     
    FIELD add2_70         AS CHAR FORMAT "X(60)" INIT ""   /* ที่อยู่หน้าตาราง70กรณีไม่แยกที่อยู่*/ */    
    FIELD tp1             AS CHAR FORMAT "X(14)" INIT ""   /* TPBI/Person       */     
    FIELD tp2             AS CHAR FORMAT "X(14)" INIT ""   /* TPBI/Per Acciden  */     
    FIELD tp3             AS CHAR FORMAT "X(14)" INIT ""   /* TPPD/Per Acciden  */    
    FIELD covcod          AS CHAR FORMAT "x(1)"  INIT ""   /* covcod            */     
    FIELD cndat           AS CHAR FORMAT "x(10)" INIT ""   
    FIELD tambon          AS CHAR FORMAT "x(35)" INIT ""    
    FIELD amper           AS CHAR FORMAT "x(35)" INIT ""    
    FIELD country         AS CHAR FORMAT "x(35)" INIT ""    
    FIELD compul          AS CHAR FORMAT "x"        INIT "" 
    FIELD model           AS CHAR FORMAT "x(50)"    INIT ""   
    FIELD seat            AS CHAR FORMAT "x(2)"     INIT ""    
    FIELD comper          AS CHAR FORMAT "x(14)"    INIT ""    
    FIELD comacc          AS CHAR FORMAT "x(14)"    INIT ""    
    FIELD deductpd        AS CHAR FORMAT "X(14)"     INIT ""     
    FIELD deductpd2       AS CHAR FORMAT "X(14)"    INIT ""  
    FIELD cargrp         AS CHAR FORMAT "x"         INIT ""     
    FIELD body           AS CHAR FORMAT "x(40)"     INIT ""     
    FIELD NO_41          AS CHAR FORMAT "x(14)"     INIT ""  
    FIELD NO_42          AS CHAR FORMAT "x(14)"     INIT ""  
    FIELD NO_43          AS CHAR FORMAT "x(14)"     INIT ""  
    FIELD comment        AS CHAR FORMAT "x(512)"    INIT ""
    FIELD agent          AS CHAR FORMAT "x(10)"     INIT ""   
    FIELD producer       AS CHAR FORMAT "x(10)"     INIT ""   
    FIELD entdat         AS CHAR FORMAT "x(10)"     INIT ""      
    FIELD enttim         AS CHAR FORMAT "x(8)"      INIT ""       
    FIELD trandat        AS CHAR FORMAT "x(10)"     INIT "" 
    FIELD firstdat       AS CHAR FORMAT "x(10)"     INIT ""  
    FIELD trantim        AS CHAR FORMAT "x(8)"      INIT ""       
    FIELD n_IMPORT       AS CHAR FORMAT "x(2)"      INIT ""       
    FIELD n_EXPORT       AS CHAR FORMAT "x(2)"      INIT "" 
    FIELD pass           AS CHAR FORMAT "x"         INIT "n"
    FIELD OK_GEN         AS CHAR FORMAT "X"         INIT "Y" 
    FIELD renpol         AS CHAR FORMAT "x(32)"     INIT ""     
    FIELD cr_2           AS CHAR FORMAT "x(32)"     INIT ""  
    FIELD namerequest    AS CHAR FORMAT "x(50)"     INIT ""  
    FIELD daterequest    AS CHAR FORMAT "x(20)"     INIT ""  
    FIELD nocheck        AS CHAR FORMAT "x(30)"     INIT ""  
    FIELD docno          AS CHAR INIT "" FORMAT "x(10)" 
    FIELD redbook        AS CHAR INIT "" FORMAT "X(8)"
    FIELD drivnam        AS CHAR FORMAT "x"     INIT "n" 
    FIELD tariff         AS CHAR FORMAT "x(2)"  INIT "9"
    FIELD tons           AS DECI FORMAT "9999.99"  INIT ""
    FIELD cancel         AS CHAR FORMAT "x(2)"  INIT ""    
    FIELD accdat         AS CHAR INIT "" FORMAT "x(10)"   
    FIELD prempa         AS CHAR FORMAT "x"     INIT ""       
    FIELD subclass       AS CHAR FORMAT "x(5)"  INIT ""    
    FIELD fleet          AS CHAR FORMAT "x(10)" INIT ""   
    FIELD WARNING        AS CHAR FORMAT "X(30)" INIT ""
    FIELD seat41         AS INTE FORMAT "99"    INIT 0
    FIELD volprem        AS CHAR FORMAT "x(20)" INIT "" 
    FIELD n_branch       AS CHAR FORMAT "x(2)"  INIT ""
    FIELD insref         AS CHAR FORMAT "x(10)" INIT ""
    FIELD txtmemo        AS CHAR FORMAT "x(100)" INIT ""  
    FIELD txtmemo2       AS CHAR FORMAT "x(100)" INIT ""
    FIELD class70        AS CHAR FORMAT "x(5)" INIT ""   
    field vatcode        as char format "X(10)"  init ""
    FIELD notfyby        AS CHAR FORMAT "x(30)"  INIT "" 
    FIELD Driv1          AS char format "x(60)" init ""
    FIELD idDriv1        as char format "x(60)" init ""
    FIELD BDriv1         as char format "x(60)" init ""
    FIELD LicenceNo1     as char format "x(60)" init ""
    FIELD Driv2          as char format "x(60)" init ""
    FIELD idDriv2        as char format "x(60)" init ""
    FIELD BDriv2         as char format "x(60)" init ""
    FIELD LicenceNo2     as char format "x(60)" init ""
    FIELD notify_no      AS CHAR FORMAT "x(20)" INIT ""
    FIELD promo          AS CHAR FORMAT "x(25)" INIT ""
    FIELD campaign       AS CHAR FORMAT "x(20)" INIT ""   /*A60-0263*/
    FIELD insnamtyp      AS CHAR FORMAT "x(60)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD firstName      AS CHAR FORMAT "x(60)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD lastName       AS CHAR FORMAT "x(60)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD postcd         AS CHAR FORMAT "x(15)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeocc        AS CHAR FORMAT "x(4)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr1      AS CHAR FORMAT "x(2)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr2      AS CHAR FORMAT "x(2)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr3      AS CHAR FORMAT "x(2)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD br_insured     AS CHAR FORMAT "x(5)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD campaign_ov    AS CHAR FORMAT "x(30)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
    FIELD financecd      AS CHAR FORMAT "x(60)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD colordes       AS CHAR FORMAT "x(20)"  INIT "".  /*Add by Krittapoj S. A65-0372 Date 16/01/2023*/
    

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
DEF  var  nv_row  as  int  init  0.                       
DEFINE STREAM  ns1.                                        
DEFINE STREAM  ns2.                                         
DEFINE STREAM  ns3.                                        
DEF VAR nv_uom1_v AS DECI INIT 0.                     
DEF VAR nv_uom2_v AS DECI INIT 0.                     
DEF VAR nv_uom5_v AS DECI INIT 0.                     
DEF VAR chkred    AS logi INIT NO.                   
DEF VAR nv_comper  AS DECI INIT 0.                       
DEF VAR nv_comacc  AS DECI INIT 0.                       
DEF VAR nv_modcod  AS CHAR FORMAT "x(8)" INIT "" .       
def var nv_chk as  logic.                                
DEF VAR nv_ncbyrs AS INTE.                               
DEF VAR  NO_CLASS AS CHAR INIT "".                       
def var  s_recid1       as RECID .     /* uwm100  */                    
def var  s_recid2       as recid .     /* uwm120  */                    
def var  s_recid3       as recid .     /* uwm130  */                    
def var  s_recid4       as recid .     /* uwm301  */                    
DEF VAR nv_provi   AS   CHAR INIT "".                                   
DEF VAR n_rencnt   LIKE sicuw.uwm100.rencnt INITIAL "".              
DEF VAR n_endcnt   LIKE sicuw.uwm100.endcnt INITIAL "".                
DEF VAR nv_daily     AS CHARACTER FORMAT "X(1024)"     INITIAL ""  NO-UNDO.     
DEF VAR nv_reccnt   AS  INT  INIT  0.           /*all load record*/                              
DEF VAR nv_completecnt    AS   INT   INIT  0.   /*complete record */                              
def var s_riskgp    AS INTE FORMAT ">9".                                                         
def var s_riskno    AS INTE FORMAT "999".                                                        
def var s_itemno    AS INTE FORMAT "999".                                                        
DEF VAR nv_drivage1 AS INTE INIT 0.                                
DEF VAR nv_drivage2 AS INTE INIT 0.                                
DEF VAR nv_drivbir1 AS CHAR INIT "".                               
DEF VAR nv_drivbir2 AS CHAR INIT "".                               
def var nv_dept     as char format  "X(1)".       
def var nv_undyr    as    char  init  ""    format   "X(4)".       
def var n_curbil    LIKE  sicuw.uwm100.curbil  NO-UNDO.            
DEF VAR nv_stm_per  AS DECIMAL FORMAT ">9.99" INITIAL 0 NO-UNDO.      
DEF VAR nv_tax_per  AS DECIMAL FORMAT ">9.99" INITIAL 0 NO-UNDO.      
DEF VAR nv_com1_per AS DECIMAL FORMAT ">9.99" INITIAL 0 NO-UNDO.    
DEF VAR nv_com1_prm AS DECIMAL FORMAT ">>>>>9.99-"      NO-UNDO.    
DEF VAR s_130bp1    AS RECID                 NO-UNDO.      
DEF VAR s_130fp1    AS RECID                 NO-UNDO.      
DEF VAR nvffptr     AS RECID                 NO-UNDO.      
DEF VAR n_rd132     AS RECID                 NO-UNDO.      
DEF VAR nv_gap      AS DECIMAL               NO-UNDO.      
DEF VAR nv_fptr     AS RECID.                           
DEF VAR nv_bptr     AS RECID.                           
DEF VAR nv_nptr     AS RECID.                           
DEF VAR nv_gap2     AS DECIMAL               NO-UNDO.              
DEF VAR nv_prem2    AS DECIMAL               NO-UNDO.              
DEF VAR nv_rstp     AS DECIMAL               NO-UNDO.                                
DEF VAR nv_rtax     AS DECIMAL               NO-UNDO.                                
DEF VAR nv_key_a    AS DECIMAL INITIAL 0     NO-UNDO.                                 
DEF VAR nv_rec100   AS RECID .                                       
DEF VAR nv_rec120   AS RECID .                                                                   
DEF VAR nv_rec130   AS RECID .                                                                  
DEF VAR nv_rec301   AS RECID .                                                                   
DEFINE VAR nv_line1   AS INTEGER   INITIAL 0  NO-UNDO.                                 
DEFINE  WORKFILE wuppertxt3 NO-UNDO                                                             
 /*1*/  FIELD line     AS INTEGER   FORMAT ">>9"                                                
 /*2*/  FIELD txt      AS CHARACTER FORMAT "X(78)"      INITIAL "".                                
DEF  VAR n_41          AS DECI      FORMAT ">,>>>,>>9.99"  INIT 0.                       
DEF  VAR n_42          AS DECI      FORMAT ">,>>>,>>9.99"  INIT 0.                       
DEF  VAR n_43          AS DECI      FORMAT ">,>>>,>>9.99"  INIT 0.                       
DEFINE VAR nv_basere   AS DECI      FORMAT ">>,>>>,>>9.99-" INIT 0.           
DEFINE VAR n_sclass72  AS CHAR FORMAT "x(4)".                                   
DEFINE VAR nv_maxdes AS CHAR.                                                   
DEFINE VAR nv_mindes AS CHAR.                                                   
DEFINE VAR nv_si     AS DECI FORMAT ">>,>>>,>>9.99-".  /* Maximum Sum Insure */  
DEFINE VAR nv_maxSI  AS DECI FORMAT ">>,>>>,>>9.99-".  /* Maximum Sum Insure */  
DEFINE VAR nv_minSI  AS DECI FORMAT ">>,>>>,>>9.99-".  /* Minimum Sum Insure */  
DEFINE VAR nv_newsck AS CHAR FORMAT "x(15)" INIT " ".                           
DEF VAR nv_uwm301trareg    LIKE sicuw.uwm301.cha_no INIT "".                    
DEF VAR gv_id  AS CHAR FORMAT "X(10)" NO-UNDO.  /*A60-0263*/
DEF VAR nv_pwd AS CHAR FORMAT "x(15)" NO-UNDO.  /*A60-0263*/
/*Add kridtiya i. A56-0071 */
DEFINE VAR  ns_rectype       AS CHAR FORMAT "X(10)" .   /*"ประเภทของ Record"           */                            
DEFINE VAR  ns_contno        AS CHAR FORMAT "X(10)" .   /*"เลขที่สัญญาในปีแรก"         */                           
DEFINE VAR  ns_id            AS CHAR FORMAT "X(15)" .   /*"เลขที่บัตรประชาชน"          */                           
DEFINE VAR  ns_insqno        AS CHAR FORMAT "X(10)" .   /*""                           */                           
DEFINE VAR  ns_bkdate        AS CHAR FORMAT "X(8)"  .   /*"วันที่ทำสัญญา"              */                           
DEFINE VAR  ns_notidate      AS CHAR FORMAT "X(8)"  .   /*"วันที่แจ้งประกัน"           */                           
DEFINE VAR  ns_inscmp        AS CHAR FORMAT "X(5)"  .   /*"รหัสบริษัทประกันภัย"        */
DEFINE VAR  ns_instyp        AS CHAR FORMAT "X(2)"  .   /*"ประเภทประกันเดิม"           */                           
DEFINE VAR  ns_covtyp        AS CHAR FORMAT "X(2)"  .   /*"ประเภทความคุ้มครอง"         */                           
DEFINE VAR  ns_inslictyp     AS CHAR FORMAT "X(5)"  .   /*"Insurance License Type"     */                           
DEFINE VAR  ns_insyearno     AS CHAR FORMAT "X(5)"  .   /*"ปีประกัน"                  */                           
DEFINE VAR  ns_policy        AS CHAR FORMAT "X(20)" .   /*"เลขที่กรมธรรม์"             */                           
DEFINE VAR  ns_prepol        AS CHAR FORMAT "x(20)" .
DEFINE VAR  ns_policy72      AS CHAR FORMAT "x(20)" .
DEFINE VAR  ns_covamt        AS CHAR FORMAT "X(20)" .   /*"ทุนประกัน"                  */                           
DEFINE VAR  ns_covamtthf     AS CHAR FORMAT "X(20)" .   /*"ทุนประกันรถหาย"             */                            
DEFINE VAR  ns_netamt        AS CHAR FORMAT "X(20)" .   /*"ค่าเบี้ยสุทธิ"                      */                            
DEFINE VAR  ns_groamt        AS CHAR FORMAT "X(20)" .   /*"ค่าเบี้ย"              */                            
DEFINE VAR  ns_taxamtins     AS CHAR FORMAT "X(20)" .   /*"หัก ณ ที่จ่ายของค่าเบี้ย"   */                            
DEFINE VAR  ns_gropduty      AS CHAR FORMAT "X(20)" .   /*"อากรเบี้ย"                  */                            
DEFINE VAR  ns_effdate       AS CHAR FORMAT "X(8)"  .   /*"วันที่ประกันภัยมีผล"        */                            
DEFINE VAR  ns_expdate       AS CHAR FORMAT "X(8)"  .   /*"วันที่หมดอายุ"              */
DEFINE VAR  ns_accpolicy     AS CHAR FORMAT "X(35)" .   /*"เลขที่ พรบ."                */                            
DEFINE VAR  ns_acccovamt     AS CHAR FORMAT "X(20)" .   /*"ทุนประกัน พรบ."             */                          
DEFINE VAR  ns_accnpmamt     AS CHAR FORMAT "X(20)" .   /*"ค่า พรบ. สุทธิ"                   */                          
DEFINE VAR  ns_accgpmamt     AS CHAR FORMAT "X(20)" .   /*"ค่า พรบ."             */                          
DEFINE VAR  ns_acctaxamt     AS CHAR FORMAT "X(20)" .   /*"หัก ณ ที่จ่าย พรบ."         */                          
DEFINE VAR  ns_accgpduty     AS CHAR FORMAT "X(20)" .   /*"อากร พรบ."                  */                          
DEFINE VAR  ns_acceffdat     AS CHAR FORMAT "X(8)"  .   /*"วันที่ประกันมีผล"           */                      
DEFINE VAR  ns_accexpdat     AS CHAR FORMAT "X(8)"  .   /*"วันที่หมดอายุ"              */                      
DEFINE VAR  ns_dscfamt       AS CHAR FORMAT "X(20)" .   /*"% ส่วนลดหมู่"               */                      
DEFINE VAR  ns_dscexpr       AS CHAR FORMAT "X(20)" .   /*"% ส่วนลดประวัติ"            */                      
DEFINE VAR  ns_dscdeduc      AS CHAR FORMAT "X(20)" .   /*"ความเสียหายส่วนแรก"         */                      
DEFINE VAR  ns_chassno       AS CHAR FORMAT "X(30)" .   /*"เลขตัวถัง"                  */                      
DEFINE VAR  ns_enginno       AS CHAR FORMAT "X(30)" .   /*"เลขเครื่องยนต์"             */                      
DEFINE VAR  ns_caryear       AS CHAR FORMAT "X(10)" .   /*"ปีรถ"                       */                      
DEFINE VAR  ns_regisprov     AS CHAR FORMAT "X(30)" .   /*"จังหวัดที่จดทะเบียน"        */                      
DEFINE VAR  ns_licenno       AS CHAR FORMAT "X(10)" .   /*"ทะเบียนรถ"                  */ 
DEFINE VAR  ns_cc            AS CHAR FORMAT "X(10)" .   /*"ซีซี"                       */                      
DEFINE VAR  ns_brand         AS CHAR FORMAT "X(100)".   /*"ยี่ห้อ"                     */                      
DEFINE VAR  ns_model         AS CHAR FORMAT "X(100)".   /*"รุ่น"                       */                      
DEFINE VAR  ns_titlen        AS CHAR FORMAT "X(100)".   /*"คำนำหน้าชื่อ"               */                      
DEFINE VAR  ns_cname         AS CHAR FORMAT "X(100)".   /*"ชื่อลูกค้า"                 */                      
DEFINE VAR  ns_csname        AS CHAR FORMAT "X(100)".   /*"นามสกุล"                    */                      
DEFINE VAR  ns_birthday      AS CHAR FORMAT "x(8)"  .   /*วันเกิดลูกค้า */ /*Add A56-0071*/
DEFINE VAR  ns_occuration    AS CHAR FORMAT "x(100)".   /*อาชีพ */         /*Add A56-0071*/
DEFINE VAR  ns_upddte        AS CHAR FORMAT "X(8)"  .   /*"วันที่ทำรายการ"             */                      
DEFINE VAR  ns_updby         AS CHAR FORMAT "X(30)" .   /*"user ที่ทำรายการ"           */                
DEFINE VAR  ns_batchno       AS CHAR FORMAT "X(2)"  .   /*"สำหรับตรวจสอบรายการ"        */                      
DEFINE VAR  ns_remark        AS CHAR FORMAT "X(250)".   /*"หมายเหตุ"                   */                      
DEFINE VAR  ns_notfyby       AS CHAR FORMAT "X(50)" .   /*"ชื่อผู้แจ้งประกัน"                    */                      
DEFINE VAR  ns_overamt       AS CHAR FORMAT "X(20)" .   /*"เงินรับ (สามารถออกกรมธรรม์ได้)"       */                      
DEFINE VAR  ns_assured       AS CHAR FORMAT "X(50)" .   /*"ระบุ LACL"                            */                      
DEFINE VAR  ns_trandte       AS CHAR FORMAT "X(8)"  .   /*"วันที่ชำระเงิน"                       */                      
DEFINE VAR  ns_claim         AS CHAR FORMAT "X(50)" .   /*"การจัดซ่อม"                           */                      
DEFINE VAR  ns_drivers1      AS CHAR FORMAT "X(50)" .   /*"ระบุผู้ขับขี่คนที่ 1"                 */                      
DEFINE VAR  ns_id_driv1      AS CHAR FORMAT "X(15)" .   /*"เลขที่บัตรประชาชนผู้ขับขี่คนที่ 1"     */                     
DEFINE VAR  ns_bdaydr1       AS CHAR FORMAT "X(8)"  .   /*"วันเกิดผู้ขับขี่คนที่ 1"               */     
DEFINE VAR  ns_licnodr1      AS CHAR FORMAT "X(15)" .   /*"เลขที่ใบขับขี่คนที่ 1"                 */     
DEFINE VAR  ns_drivers2      AS CHAR FORMAT "X(50)" .   /*"ระบุผู้ขับขี่คนที่ 2"                  */     
DEFINE VAR  ns_id_driv2      AS CHAR FORMAT "X(15)" .   /*"เลขที่บัตรประชาชนผู้ขับขี่คนที่ 2"     */     
DEFINE VAR  ns_bdaydr2       AS CHAR FORMAT "X(8)"  .   /*"วันเกิดผู้ขับขี่คนที่ 2"               */     
DEFINE VAR  ns_licnodr2      AS CHAR FORMAT "X(15)" .   /*"เลขที่ใบขับขี่คนที่ 2"                 */     
DEFINE VAR  ns_namepol       AS CHAR FORMAT "X(50)" .   /*"ชื่อบนหน้ากรมธรรม์"                    */     
DEFINE VAR  ns_addpol        AS CHAR FORMAT "X(300)".   /*"ที่อยู่บนหน้ากรมธรรม์"                 */     
DEFINE VAR  ns_namsend       AS CHAR FORMAT "X(50)" .   /*"ชื่อที่ส่งเอกสาร"                      */     
DEFINE VAR  ns_addsend       AS CHAR FORMAT "X(300)".   /*"ที่อยู่สำหรับส่งเอกสาร"                */     
DEFINE VAR  ns_cpcode        AS CHAR FORMAT "X(20)" .   /*"รหัสผลิตกรมธรรม์(รหัสแคมเปน)"          */     
DEFINE VAR  ns_dealsub       AS CHAR FORMAT "X(1)"  .   /*"flag Dealer แถม"                       */     
DEFINE VAR  ns_covpes        AS CHAR FORMAT "X(20)" .   /*"ความรับผิดชอบบุคคลภายนอก/ชีวิตบุคคล"   */     
DEFINE VAR  ns_covacc        AS CHAR FORMAT "X(20)" .   /*"ความรับผิดชอบบุคคลภายนอก/ชีวิตร่างกาย" */     
DEFINE VAR  ns_covdacc       AS CHAR FORMAT "X(20)" .   /*"ความรับผิดชอบบุคคลภายนอก/ทรัพย์สิน"    */     
DEFINE VAR  ns_covaccp       AS CHAR FORMAT "X(20)" .   /*"ความคุ้มครองตามเอกสารแนบท้าย/อุบัติเหตุส่วนบุคคล" */     
DEFINE VAR  ns_covmdp        AS CHAR FORMAT "X(20)" .   /*"ความคุ้มครองตามเอกสารแนบท้าย/ค่ารักษาพยาบาล"      */     
DEFINE VAR  ns_covbllb       AS CHAR FORMAT "X(20)" .   /*"ความคุ้มครองตามเอกสารแนบท้าย/ประกันตัวผู้ขับขี่". */ 
DEF    VAR  ns_campaign      AS CHAR FORMAT "x(20)" .  /*a60-0263*/
DEFINE VAR  ns_memmo         AS CHAR FORMAT "X(20)" .
DEFINE VAR  ns_colordes      AS CHAR FORMAT "x(20)" .   /*Add by Krittapoj S. A65-0372 16/01/2023*/
def var ns_class70  as char format "x(5)" init "".
def var ns_producer as char format "x(10)" init "".
def var ns_agent    as char format "x(10)" init "".
def var ns_vatcode  as char format "x(10)" init "".
def var ns_bran     as char format "x(2)" init "".
def var ns_status   as char format "x(25)" init "".
DEF VAR     ns_garage         AS CHAR FORMAT "X(2)" .  
/*Add kridtiya i. A56-0071 */
DEF VAR ns_campaignov AS CHAR INIT "".  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
DEF VAR nv_postcd     AS CHAR INIT "".  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
DEF VAR nv_codeocc       AS CHAR INIT "".  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
DEF VAR nv_codeaddr1     AS CHAR INIT "".  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
DEF VAR nv_codeaddr2     AS CHAR INIT "".  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
DEF VAR nv_codeaddr3     AS CHAR INIT "".  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
DEF VAR nv_chkerror   AS CHAR INIT "".  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 

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
DEF VAR dod0 AS INTEGER.                                        
DEF VAR dod1 AS INTEGER.                                        
DEF VAR dod2 AS INTEGER.                                        
DEF VAR dpd0 AS INTEGER. 
DEFINE VAR nv_41prmt   AS DECI FORMAT ">>>,>>>,>>9.99-".  /* fleet */
DEFINE VAR nv_42prmt   AS DECI FORMAT ">>>,>>>,>>9.99-".  /* fleet */
DEFINE VAR nv_43prmt   AS DECI FORMAT ">>>,>>>,>>9.99-".  /* fleet */
DEFINE VAR nv_pdprem   AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_status   AS CHAR .   /*fleet YES=Complete , NO=Not Complete */
/*A58-0271 add for 2+,3+*/
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
DEFINE VAR               ns_basenew     AS CHAR     FORMAT "x(20)"     INIT "".  
DEFINE VAR               campaignno     AS CHAR INIT "" FORMAT "X(20)".    
/*A58-0271 add for 2+,3+*/
/* end A64-0138 */



