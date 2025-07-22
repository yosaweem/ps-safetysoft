/*programid   : wgwtlscb.i                                               */
/*programname : load text file scbpt to GW                               */
/* Copyright  : Safety Insurance Public Company Limited 			     */
/*			    บริษัท ประกันคุ้มภัย จำกัด (มหาชน)				         */
/*create by   : Ranu i. A60-0448  date . 20/10/2017             
                โปรแกรมให้สามารถนำเข้า text file scbpt to GW system      */ 
/* copy write : wgwtcgen.i                                               */
/* Modify By  : Kridtiya i. A63-0472 Date. 09/11/2020 
              : Add FIELD firstname ,lAStname.....                       */
/* Modify By  : Ranu I. A64-0138 เพิ่มตัวแปรเก็บค่าเบี้ย                 */
/* Modify By  : Tontawan S. A66-0006 25/01/2023
              : Add FIELD ชื่อเซลและรหัสเซล                              
              : Add FIELD Camapaign
              : Add FIELD Branch Code                                   
              : Add FIELD Selling Channel                                */
// Modify By  : Tontawan S. A68-0059 26/03/2025     
//            : Add 35 Fields to support EV. 
/*************************************************************************/
DEFINE NEW SHARED TEMP-TABLE wdetail NO-UNDO
    FIELD poltyp         AS CHAR FORMAT "X(5)"   INIT ""
    FIELD policy         AS CHAR FORMAT "X(20)"  INIT ""
    FIELD account_no     AS CHAR FORMAT "X(20)"  INIT ""
    FIELD inscode        AS CHAR FORMAT "X(20)"  INIT ""
    FIELD campcode       AS CHAR FORMAT "X(20)"  INIT ""        
    FIELD campname       AS CHAR FORMAT "X(35)"  INIT ""        
    FIELD procode        AS CHAR FORMAT "X(20)"  INIT ""        
    FIELD proname        AS CHAR FORMAT "X(35)"  INIT ""        
    FIELD packname       AS CHAR FORMAT "X(35)"  INIT ""        
    FIELD packcode       AS CHAR FORMAT "X(20)"  INIT ""        
    FIELD instype        AS CHAR FORMAT "X(1)"   INIT ""        
    FIELD tiname         AS CHAR FORMAT "X(20)"  INIT ""        
    FIELD insnam         AS CHAR FORMAT "X(100)" INIT ""        
    FIELD title_eng      AS CHAR FORMAT "X(10)"  INIT ""        
    FIELD insname_eng    AS CHAR FORMAT "X(100)" INIT ""        
    FIELD icno           AS CHAR FORMAT "X(13)"  INIT "" 
    FIELD bdate          AS CHAR FORMAT "X(15)"  INIT ""        
    FIELD occup          AS CHAR FORMAT "X(50)"  INIT ""        
    FIELD tel            AS CHAR FORMAT "X(50)"  INIT ""        
    FIELD mail           AS CHAR FORMAT "X(50)"  INIT ""        
    FIELD addr1          AS CHAR FORMAT "X(40)"  INIT ""        
    FIELD addr2          AS CHAR FORMAT "X(40)"  INIT ""        
    FIELD addr3          AS CHAR FORMAT "X(40)"  INIT ""        
    FIELD addr4          AS CHAR FORMAT "X(40)"  INIT "" 
    FIELD benname        AS CHAR FORMAT "X(100)" INIT "" 
    FIELD brand          AS CHAR FORMAT "X(35)"  INIT ""
    FIELD Model          AS CHAR FORMAT "X(50)"  INIT ""
    FIELD body           AS CHAR FORMAT "X(20)"  INIT ""
    FIELD vehreg         AS CHAR FORMAT "X(11)"  INIT ""
    FIELD re_country     AS CHAR FORMAT "X(25)"  INIT ""
    FIELD chASno         AS CHAR FORMAT "X(20)"  INIT ""
    FIELD eng            AS CHAR FORMAT "X(20)"  INIT ""
    FIELD caryear        AS CHAR FORMAT "X(5)"   INIT ""
    FIELD seate          AS INT  INIT 0
    FIELD engcc          AS CHAR FORMAT "X(15)"  INIT ""
    FIELD weight         AS CHAR FORMAT "X(15)"  INIT ""
    FIELD subclASs       AS CHAR FORMAT "X(5)"   INIT ""                                        
    FIELD garage         AS CHAR FORMAT "X(35)"  INIT ""
    FIELD colorcode      AS CHAR FORMAT "X(35)"  INIT ""
    FIELD covcod         AS CHAR FORMAT "X(50)"  INIT ""
    FIELD covtyp         AS CHAR FORMAT "X(30)"  INIT ""
    FIELD comdat         AS CHAR FORMAT "X(15)"  INIT ""
    FIELD expdat         AS CHAR FORMAT "X(15)"  INIT ""
    FIELD si             AS CHAR FORMAT "X(20)"  INIT ""
    FIELD prem1          AS CHAR FORMAT "X(20)"  INIT ""
    FIELD gross_prm      AS CHAR FORMAT "X(20)"  INIT ""
    FIELD stamp          AS CHAR FORMAT "X(10)"  INIT ""
    FIELD vat            AS CHAR FORMAT "X(10)"  INIT ""
    FIELD premtotal      AS CHAR FORMAT "X(20)"  INIT ""
    FIELD deduct         AS CHAR FORMAT "X(10)"  INIT ""
    FIELD fleetper       AS CHAR FORMAT "X(10)"  INIT ""
    FIELD ncb            AS DECI   INIT 0
    FIELD drivper        AS CHAR FORMAT "X(10)"  INIT ""
    FIELD othper         AS CHAR FORMAT "X(10)"  INIT ""
    FIELD cctvper        AS CHAR FORMAT "X(10)"  INIT "" 
    FIELD Surcharper     AS CHAR FORMAT "X(10)"  INIT ""
    FIELD drivnam        AS CHAR FORMAT "X(2)"   INIT ""        
    FIELD drivnam1       AS CHAR FORMAT "X(70)"  INIT "" 
    FIELD driveno1       AS CHAR FORMAT "X(15)"  INIT ""        
    FIELD occupdri1      AS CHAR FORMAT "X(50)"  INIT ""        
    FIELD sexdriv1       AS CHAR FORMAT "X(10)"  INIT ""        
    FIELD bdatedri1      AS CHAR FORMAT "X(15)"  INIT ""        
    FIELD drivnam2       AS CHAR FORMAT "X(70)"  INIT "" 
    FIELD driveno2       AS CHAR FORMAT "X(15)"  INIT ""        
    FIELD occupdri2      AS CHAR FORMAT "X(50)"  INIT ""        
    FIELD sexdriv2       AS CHAR FORMAT "X(10)"  INIT ""        
    FIELD bdatedri2      AS CHAR FORMAT "X(15)"  INIT "" 
    FIELD comment        AS CHAR FORMAT "X(512)" INIT ""
    FIELD producer       AS CHAR FORMAT "X(10)"  INIT "" 
    FIELD agent          AS CHAR FORMAT "X(10)"  INIT ""
    FIELD trandat        AS CHAR FORMAT "X(10)"  INIT ""      
    FIELD trantim        AS CHAR FORMAT "X(8)"   INIT ""       
    FIELD n_IMPORT       AS CHAR FORMAT "X(2)"   INIT ""       
    FIELD n_EXPORT       AS CHAR FORMAT "X(2)"   INIT "" 
    FIELD pASs           AS CHAR FORMAT "x"      INIT "n"
    FIELD OK_GEN         AS CHAR FORMAT "X"      INIT "Y" 
    FIELD vehuse         AS CHAR FORMAT "X(2)"   INIT ""
    FIELD cargrp         AS CHAR FORMAT "X(2)"   INIT ""
    FIELD cr_2           AS CHAR FORMAT "X(20)"  INIT ""  
    FIELD docno          AS CHAR INIT "" FORMAT "X(10)" 
    FIELD redbook        AS CHAR INIT "" FORMAT "X(10)"
    FIELD stk            AS CHAR FORMAT "X(15)"  INIT ""
    FIELD tariff         AS CHAR FORMAT "X(2)"   INIT "9"
    FIELD cancel         AS CHAR FORMAT "X(2)"   INIT ""    
    FIELD accdat         AS CHAR INIT "" FORMAT "X(10)"   
    FIELD prempa         AS CHAR FORMAT "X(4)"   INIT "" 
    FIELD cndat          AS CHAR FORMAT "X(10)"  INIT ""   
    FIELD WARNING        AS CHAR FORMAT "X(30)"  INIT ""
    FIELD compul         AS CHAR FORMAT "x"      INIT "n"
    FIELD tp1            AS CHAR FORMAT "X(15)"  INIT ""  
    FIELD tp2            AS CHAR FORMAT "X(15)"  INIT ""  
    FIELD tp3            AS CHAR FORMAT "X(15)"  INIT "" 
    FIELD NO_41          AS CHAR FORMAT "X(14)"  INIT "" 
    FIELD NO_42          AS CHAR FORMAT "X(14)"  INIT "" 
    FIELD NO_43          AS CHAR FORMAT "X(14)"  INIT "" 
    FIELD branch         AS CHAR FORMAT "X(2)"   INIT ""
    FIELD prepol         AS CHAR FORMAT "X(15)"  INIT ""
    FIELD comper         AS CHAR FORMAT "X(15)"  INIT ""      
    FIELD comacc         AS CHAR FORMAT "X(15)"  INIT ""
    FIELD fi             AS CHAR FORMAT "X(15)"  INIT "" 
    FIELD insnamtyp      AS CHAR FORMAT "X(60)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD firstName      AS CHAR FORMAT "X(60)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD lAStName       AS CHAR FORMAT "X(60)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD postcd         AS CHAR FORMAT "X(15)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeocc        AS CHAR FORMAT "X(4)"   INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr1      AS CHAR FORMAT "X(2)"   INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr2      AS CHAR FORMAT "X(2)"   INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr3      AS CHAR FORMAT "X(2)"   INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD br_insured     AS CHAR FORMAT "X(5)"   INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD campaign_ov    AS CHAR FORMAT "X(30)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
    FIELD financecd      AS CHAR FORMAT "X(60)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD campaign       AS CHAR FORMAT "X(20)"  INIT ""   /*Add By Tontawan S. */    
    FIELD selling_c      AS CHAR FORMAT "X(100)" INIT ""   /*Add By Tontawan S. */
    FIELD drv3_name      AS CHAR FORMAT "X(100)" INIT "" // คนขับ 3 : ชื่อ-นามกสุล -- Add Tontawan S. A68-0059 --      
    FIELD drv3_salutation_M AS CHAR FORMAT "X(20)"  INIT "" // คนขับ 3 : คำนำหน้า  
    FIELD drv3_fname        AS CHAR FORMAT "X(100)" INIT "" // คนขับ 3 : ชื่อ      
    FIELD drv3_lname        AS CHAR FORMAT "X(100)" INIT "" // คนขับ 3 : นามสกุล   
    FIELD drv3_nid          AS CHAR FORMAT "X(20)"  INIT "" // คนขับ 3 : เลขบัตรประชาชน    
    FIELD drv3_occupation   AS CHAR FORMAT "X(50)"  INIT "" // คนขับ 3 : อาชีพ             
    FIELD drv3_gender       AS CHAR FORMAT "X(10)"  INIT "" // คนขับ 3 : เพศ               
    FIELD drv3_birthdate    AS CHAR FORMAT "X(10)"  INIT "" // คนขับ 3 : วันเกิด           
    FIELD drv4_name         AS CHAR FORMAT "X(100)" INIT "" // คนขับ 4 : ชื่อ-นามกสุล 
    FIELD drv4_salutation_M AS CHAR FORMAT "X(20)"  INIT "" // คนขับ 4 : คำนำหน้า
    FIELD drv4_fname        AS CHAR FORMAT "X(100)" INIT "" // คนขับ 4 : ชื่อ    
    FIELD drv4_lname        AS CHAR FORMAT "X(100)" INIT "" // คนขับ 4 : นามสกุล 
    FIELD drv4_nid          AS CHAR FORMAT "X(20)"  INIT "" // คนขับ 4 : เลขบัตรประชาชน    
    FIELD drv4_occupation   AS CHAR FORMAT "X(50)"  INIT "" // คนขับ 4 : อาชีพ             
    FIELD drv4_gender       AS CHAR FORMAT "X(10)"  INIT "" // คนขับ 4 : เพศ               
    FIELD drv4_birthdate    AS CHAR FORMAT "X(10)"  INIT "" // คนขับ 4 : วันเกิด           
    FIELD drv5_name         AS CHAR FORMAT "X(100)" INIT "" // คนขับ 5 : ชื่อ-นามกสุล    
    FIELD drv5_salutation_M AS CHAR FORMAT "X(20)"  INIT "" // คนขับ 5 : คำนำหน้า
    FIELD drv5_fname        AS CHAR FORMAT "X(100)" INIT "" // คนขับ 5 : ชื่อ    
    FIELD drv5_lname        AS CHAR FORMAT "X(100)" INIT "" // คนขับ 5 : นามสกุล 
    FIELD drv5_nid          AS CHAR FORMAT "X(20)"  INIT "" // คนขับ 5 : เลขบัตรประชาชน    
    FIELD drv5_occupation   AS CHAR FORMAT "X(50)"  INIT "" // คนขับ 5 : อาชีพ             
    FIELD drv5_gender       AS CHAR FORMAT "X(10)"  INIT "" // คนขับ 5 : เพศ               
    FIELD drv5_birthdate    AS CHAR FORMAT "X(10)"  INIT "" // คนขับ 5 : วันเกิด           
    FIELD drv1_dlicense     AS CHAR FORMAT "X(50)"  INIT "" // คนขับ 1 : ทะเบียนรถ         
    FIELD drv2_dlicense     AS CHAR FORMAT "X(50)"  INIT "" // คนขับ 2 : ทะเบียนรถ         
    FIELD drv3_dlicense     AS CHAR FORMAT "X(50)"  INIT "" // คนขับ 3 : ทะเบียนรถ         
    FIELD drv4_dlicense     AS CHAR FORMAT "X(50)"  INIT "" // คนขับ 4 : ทะเบียนรถ         
    FIELD drv5_dlicense     AS CHAR FORMAT "X(50)"  INIT "" // คนขับ 5 : ทะเบียนรถ         
    FIELD baty_snumber      AS CHAR FORMAT "X(20)"  INIT "" // Battery : Serial Number     
    FIELD batydate          AS CHAR FORMAT "X(10)"  INIT "" // Battery : Year              
    FIELD baty_rsi          AS CHAR FORMAT "X(20)"  INIT "" // Battery : Replacement SI    
    FIELD baty_npremium     AS CHAR FORMAT "X(20)"  INIT "" // Battery : Net Premium       
    FIELD baty_gpremium     AS CHAR FORMAT "X(20)"  INIT "" // Battery : Gross_Premium    
    FIELD battprice         AS CHAR FORMAT "X(20)"  INIT "" // Battery : Price
    FIELD battper           AS CHAR FORMAT "X(10)"  INIT "" // Battery : %    
    FIELD wcharge_snumber   AS CHAR FORMAT "X(20)"  INIT "" // Wall Charge : Serial_Number 
    FIELD wcharge_si        AS CHAR FORMAT "X(20)"  INIT "" // Wall Charge : SI            
    FIELD wcharge_npremium  AS CHAR FORMAT "X(20)"  INIT "" // Wall Charge : Net Premium   
    FIELD wcharge_gpremium  AS CHAR FORMAT "X(20)"  INIT "" // Wall Charge : Gross Premium
    FIELD drilevel          AS CHAR FORMAT "X(2)"   INIT "" // Level -- End Tontawan S. A68-0059 --
    FIELD driver            AS CHAR FORMAT "x(23)"  INIT ""
    FIELD ntrariff          AS LOGICAL.

DEFINE NEW SHARED TEMP-TABLE wtxt NO-UNDO
    FIELD poltyp         AS  CHAR FORMAT "X(5)"   INIT ""
    FIELD policy         AS  CHAR FORMAT "X(15)"  INIT ""
    FIELD account_no     AS  CHAR FORMAT "X(20)"  INIT ""
    FIELD inscode        AS  CHAR FORMAT "X(20)"  INIT ""
    FIELD addrsend1      AS  CHAR FORMAT "X(45)"  INIT ""   /* ที่อยู่จัดส่ง*/     
    FIELD addrsend2      AS  CHAR FORMAT "X(45)"  INIT ""   /* ที่อยู่จัดส่ง*/     
    FIELD addrsend3      AS  CHAR FORMAT "X(45)"  INIT ""   /* ที่อยู่จัดส่ง*/     
    FIELD addrsend4      AS  CHAR FORMAT "X(45)"  INIT ""   /* ที่อยู่จัดส่ง*/     
    FIELD paytype        AS  CHAR FORMAT "X(2)"   INIT ""        
    FIELD paytitle       AS  CHAR FORMAT "X(20)"  INIT ""        
    FIELD payname        AS  CHAR FORMAT "X(100)" INIT ""
    FIELD payic          AS  CHAR FORMAT "X(15)"  INIT ""
    FIELD addrpay1       AS  CHAR FORMAT "X(50)"  INIT ""  /* ที่อยู่ออกใบเสร็จ */
    FIELD addrpay2       AS  CHAR FORMAT "X(50)"  INIT ""  /* ที่อยู่ออกใบเสร็จ */
    FIELD addrpay3       AS  CHAR FORMAT "X(50)"  INIT ""  /* ที่อยู่ออกใบเสร็จ */
    FIELD addrpay4       AS  CHAR FORMAT "X(50)"  INIT ""  /* ที่อยู่ออกใบเสร็จ */
    FIELD branch         AS  CHAR FORMAT "X(20)"  INIT ""   
    FIELD pmentcode      AS  CHAR FORMAT "X(10)"  INIT ""        
    FIELD pmenttyp       AS  CHAR FORMAT "X(75)"  INIT ""        
    FIELD pmentcode1     AS  CHAR FORMAT "X(10)"  INIT ""        
    FIELD pmentcode2     AS  CHAR FORMAT "X(75)"  INIT ""        
    FIELD pmentbank      AS  CHAR FORMAT "X(50)"  INIT ""  
    FIELD pmentdate      AS  CHAR FORMAT "X(15)"  INIT ""        
    FIELD pmentsts       AS  CHAR FORMAT "X(15)"  INIT "" 
    FIELD Surchardetail  AS  CHAR FORMAT "X(250)" INIT ""
    FIELD acc1           AS  CHAR FORMAT "X(100)" INIT ""
    FIELD accdetail1     AS  CHAR FORMAT "X(100)" INIT ""
    FIELD accprice1      AS  CHAR FORMAT "X(20)"  INIT ""
    FIELD acc2           AS  CHAR FORMAT "X(100)" INIT ""
    FIELD accdetail2     AS  CHAR FORMAT "X(100)" INIT ""
    FIELD accprice2      AS  CHAR FORMAT "X(20)"  INIT ""
    FIELD acc3           AS  CHAR FORMAT "X(100)" INIT ""
    FIELD accdetail3     AS  CHAR FORMAT "X(100)" INIT ""
    FIELD accprice3      AS  CHAR FORMAT "X(20)"  INIT ""
    FIELD acc4           AS  CHAR FORMAT "X(100)" INIT ""
    FIELD accdetail4     AS  CHAR FORMAT "X(100)" INIT ""
    FIELD accprice4      AS  CHAR FORMAT "X(20)"  INIT ""
    FIELD acc5           AS  CHAR FORMAT "X(100)" INIT ""
    FIELD accdetail5     AS  CHAR FORMAT "X(100)" INIT ""
    FIELD accprice5      AS  CHAR FORMAT "X(20)"  INIT ""
    FIELD inspdate       AS  CHAR FORMAT "X(15)"  INIT ""
    FIELD inspdate_app   AS  CHAR FORMAT "X(50)"  INIT ""
    FIELD inspsts        AS  CHAR FORMAT "X(50)"  INIT ""
    FIELD inspdetail     AS  CHAR FORMAT "X(250)" INIT ""
    FIELD not_date       AS  CHAR FORMAT "X(15)"  INIT ""
    FIELD paydate        AS  CHAR FORMAT "X(15)"  INIT ""
    FIELD paysts         AS  CHAR FORMAT "X(15)"  INIT ""
    FIELD licenBroker    AS  CHAR FORMAT "X(20)"  INIT ""
    FIELD brokname       AS  CHAR FORMAT "X(100)" INIT ""
    FIELD brokcode       AS  CHAR FORMAT "X(15)"  INIT ""
    FIELD lang           AS  CHAR FORMAT "X(50)"  INIT ""
    FIELD deli           AS  CHAR FORMAT "X(100)" INIT ""
    FIELD delidetail     AS  CHAR FORMAT "X(100)" INIT ""
    FIELD gift           AS  CHAR FORMAT "X(100)" INIT ""
    FIELD remark         AS  CHAR FORMAT "X(250)" INIT ""
    FIELD inspno         AS  CHAR FORMAT "X(25)" INIT "" 
    FIELD remarkinsp     AS  CHAR FORMAT "X(750)" INIT ""
    FIELD damang1        AS  CHAR FORMAT "X(750)" INIT ""
    FIELD damang2        AS  CHAR FORMAT "X(750)" INIT ""
    FIELD damang3        AS  CHAR FORMAT "X(750)" INIT ""
    FIELD dataoth        AS  CHAR FORMAT "X(750)" INIT ""
    FIELD sellcode       AS  CHAR FORMAT "X(20)"  INIT ""   //Add By Tontawan S. A66-0006 25/01/2023
    FIELD sellname       AS  CHAR FORMAT "X(100)" INIT ""   //.    
    FIELD branch_c       AS  CHAR FORMAT "X(20)"  INIT ""   //.
    FIELD ispno          AS  CHAR FORMAT "X(25)"  INIT "".  //End Add By Tontawan S. A66-0006 25/01/2023

DEF NEW SHARED TEMP-TABLE wcampaign NO-UNDO 
    FIELD  campno        AS CHAR FORMAT "X(20)"   INIT ""
    FIELD  nclASs        AS CHAR FORMAT "X(5)"    INIT ""  
    FIELD  cover         AS CHAR FORMAT "X(3)"    INIT ""  
    FIELD  pack          AS CHAR FORMAT "X(3)"    INIT "" 
    FIELD  bi            AS CHAR FORMAT "X(10)"   INIT ""  
    FIELD  pd1           AS CHAR FORMAT "X(10)"   INIT ""  
    FIELD  pd2           AS CHAR FORMAT "X(10)"   INIT "" 
    FIELD  n41           AS CHAR FORMAT "X(10)"   INIT "" 
    FIELD  n42           AS CHAR FORMAT "X(10)"   INIT ""  
    FIELD  n43           AS CHAR FORMAT "X(10)"   INIT ""  
    FIELD  FI            AS CHAR FORMAT "X(25)"   INIT ""
    FIELD  garage        AS CHAR FORMAT "X(2)"    INIT ""  
    FIELD  tariff        AS CHAR FORMAT "X(2)"    INIT "".

DEF NEW SHARED VAR nv_message       AS CHAR.
DEF            VAR c                AS CHAR.
DEF            VAR nv_riskgp  LIKE sic_bran.uwm120.riskgp NO-UNDO.
DEFINE NEW SHARED VAR no_bASeprm    AS DECI  FORMAT ">>,>>>,>>9.99-".  
DEFINE NEW SHARED VAR NO_bASemsg    AS CHAR  FORMAT "X(50)" .          
DEFINE            VAR nv_accdat     AS DATE  FORMAT "99/99/9999"    INIT ?  .     
DEFINE            VAR nv_docno      AS CHAR  FORMAT "9999999"       INIT " ".
DEFINE NEW SHARED VAR  nv_batchyr   AS INT FORMAT "9999"            INIT 0.
DEFINE NEW SHARED VAR  nv_batcnt    AS INT FORMAT "99"              INIT 0.
DEFINE NEW SHARED VAR  nv_batchno   AS CHARACTER FORMAT "X(13)"     INIT ""  NO-UNDO.
DEFINE VAR  nv_batrunno             AS INT FORMAT  ">,>>9"          INIT 0.
DEFINE VAR  nv_imppol               AS INT  FORMAT ">>,>>9"         INIT 0.
DEFINE VAR  nv_impprem              AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.
DEFINE VAR  nv_batprev              AS CHARACTER FORMAT "X(13)"     INIT ""  NO-UNDO.
DEFINE VAR  nv_tmppolrun            AS INTEGER FORMAT "999"         INIT 0. 
DEFINE VAR  nv_batbrn               AS CHARACTER FORMAT "X(2)"      INIT ""  NO-UNDO. 
DEFINE VAR  nv_tmppol               AS CHARACTER FORMAT "X(16)"     INIT "". 
DEFINE VAR  nv_rectot               AS INT  FORMAT ">>,>>9"         INIT 0.  
DEFINE VAR  nv_recsuc               AS INT  FORMAT ">>,>>9"         INIT 0.  
DEFINE VAR  nv_netprm_t             AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.  
DEFINE VAR  nv_netprm_s             AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.  
DEFINE VAR  nv_batflg               AS LOG                          INIT NO.
DEFINE VAR  nv_txtmsg               AS CHAR FORMAT "X(50)"          INIT "". 
DEF VAR nv_modcod                   AS CHAR FORMAT "X(8)" INIT "" .  
DEF VAR n_ratmin                    AS INTE INIT 0.
DEF VAR n_ratmax                    AS INTE INIT 0.
DEF VAR n_policyno                  AS CHAR FORMAT "X(20)" INIT "" .
DEF VAR nv_sexdri                   AS CHAR FORMAT "X(60)" INIT "" .
DEF VAR nv_daily                    AS CHARACTER FORMAT "X(1024)"     INITIAL ""  NO-UNDO.     
DEF VAR nv_reccnt                   AS INT INIT  0.           /*all load record*/                              
DEF VAR nv_completecnt              AS INT INIT  0.   /*complete record */                              
DEF VAR chkred                      AS logi INIT NO.
DEFINE VAR n_sclASs72               AS CHAR FORMAT "X(4)".  
DEF VAR s_riskgp                    AS INTE FORMAT ">9".                                                         
DEF VAR s_riskno                    AS INTE FORMAT "999".                                                        
DEF VAR s_itemno                    AS INTE FORMAT "999".                                                        
DEF VAR nv_comper                   AS DECI INIT 0.                    
DEF VAR nv_comacc                   AS DECI INIT 0. 
DEF VAR  s_recid1                   AS RECID .     /* uwm100  */                    
DEF VAR  s_recid2                   AS recid .     /* uwm120  */                    
DEF VAR  s_recid3                   AS recid .
DEF VAR  s_recid4                   AS recid .
DEFINE VAR nv_newsck                AS CHAR FORMAT "X(15)" INIT " ".  
DEF VAR nv_rec100                   AS RECID .                                                                  
DEF VAR nv_rec120                   AS RECID .                                                                   
DEF VAR nv_rec130                   AS RECID .                                                                  
DEF VAR nv_rec301                   AS RECID .                                                                   
DEF VAR nv_gap                      AS DECIMAL NO-UNDO. 
DEF VAR nvffptr                     AS RECID   NO-UNDO. 
DEF VAR s_130bp1                    AS RECID   NO-UNDO.      
DEF VAR s_130fp1                    AS RECID   NO-UNDO.   
DEF VAR n_rd132                     AS RECID   NO-UNDO. 
DEF VAR nv_key_a                    AS DECIMAL INITIAL 0 NO-UNDO. 
DEF VAR nv_stm_per                  AS DECIMAL FORMAT ">9.99" INITIAL 0 NO-UNDO.      
DEF VAR nv_tax_per                  AS DECIMAL FORMAT ">9.99" INITIAL 0 NO-UNDO.      
DEF VAR nv_gap2                     AS DECIMAL               NO-UNDO. 
DEF VAR nv_prem2                    AS DECIMAL               NO-UNDO.
DEF VAR nv_rstp                     AS DECIMAL                          NO-UNDO.
DEF VAR nv_rtax                     AS DECIMAL                          NO-UNDO.
DEF VAR nv_com1_per                 AS DECIMAL FORMAT ">9.99" INITIAL 0 NO-UNDO.    
DEF VAR nv_com1_prm                 AS DECIMAL FORMAT ">>>>>9.99-"      NO-UNDO. 
DEF VAR nv_fptr                     AS RECID.  
DEFINE VAR nv_bASere                AS DECI        FORMAT ">>,>>>,>>9.99-" INIT 0.
DEF VAR nv_chk                      AS  logic.
DEF VAR nv_ncbyrs                   AS INTE. 
DEF VAR nv_uom1_v                   AS INTE INIT 0.                     
DEF VAR nv_uom2_v                   AS INTE INIT 0.                     
DEF VAR nv_uom5_v                   AS INTE INIT 0.                     
DEF VAR nv_uwm301trareg LIKE sicuw.uwm301.cha_no INIT "".
DEFINE VAR nv_maxSI                 AS DECI FORMAT ">>,>>>,>>9.99-".  /* Maximum Sum Insure */  
DEFINE VAR nv_minSI                 AS DECI FORMAT ">>,>>>,>>9.99-".  /* Minimum Sum Insure */  
DEFINE VAR nv_si                    AS DECI FORMAT ">>,>>>,>>9.99-".  /* Maximum Sum Insure */  
DEFINE VAR nv_maxdes                AS CHAR.                                                   
DEFINE VAR nv_mindes                AS CHAR.  
DEF VAR NO_CLASS                    AS CHAR INIT    "".
DEF VAR n_rencnt LIKE sicuw.uwm100.rencnt   INITIAL "".
DEF VAR n_endcnt LIKE sicuw.uwm100.endcnt   INITIAL "".                
DEF VAR n_curbil LIKE  sicuw.uwm100.curbil  NO-UNDO.            
DEF VAR nv_dept                     AS CHAR FORMAT  "X(1)".
DEF VAR nv_row                      AS  int  INIT  0. 
DEFINE STREAM  ns1.                                        
DEFINE STREAM  ns2.                                         
DEFINE STREAM  ns3.  
DEF VAR gv_id           AS CHAR FORMAT "X(8)" NO-UNDO. 
/*DEF VAR nv_pwd AS CHAR NO-UNDO. */  /*A60-0405*/
DEF VAR nv_pwd          AS CHAR FORMAT "X(15)" NO-UNDO.   /*A60-0405*/
DEF VAR nv_drivage1     AS INTE INIT 0.                                
DEF VAR nv_drivage2     AS INTE INIT 0.  
DEF VAR nv_drivage3     AS INTE INIT 0. //A68-0059 27/03/2025                                
DEF VAR nv_drivage4     AS INTE INIT 0. //A68-0059 27/03/2025
DEF VAR nv_drivage5     AS INTE INIT 0. //A68-0059 27/03/2025
DEF VAR nv_bptr         AS RECID.                           
DEF VAR nv_nptr         AS RECID.  
DEFINE VAR nv_line1     AS INTEGER   INITIAL 0 NO-UNDO.                                 
DEF VAR nv_undyr        AS CHAR INIT "" FORMA "X(4)". 

DEFINE  WORKFILE wuppertxt3 NO-UNDO                                                             
 /*1*/  FIELD line      AS INTEGER   FORMAT ">>9"                                                
 /*2*/  FIELD txt       AS CHARACTER FORMAT "X(200)"   INITIAL "".  

DEFINE  WORKFILE wuppertxt NO-UNDO                                                             
 /*1*/  FIELD line      AS INTEGER   FORMAT ">>9"                                                
 /*2*/  FIELD txt       AS CHARACTER FORMAT "X(200)"   INITIAL "".  

DEF VAR nv_lnumber      AS INTE INIT 0.
DEF VAR n_41            AS DECI FORMAT ">,>>>,>>9.99" INIT 0.
DEF VAR n_42            AS DECI FORMAT ">,>>>,>>9.99" INIT 0.
DEF VAR n_43            AS DECI FORMAT ">,>>>,>>9.99" INIT 0.
DEF VAR dod1            AS DECI.
DEF VAR dod2            AS DECI.
DEF VAR dpd0            AS DECI.
DEF VAR dod0            AS DECI.
DEF VAR n_firstdat      AS CHAR FORMAT "X(10)"  INIT "".
DEF VAR nv_dscom        AS DECI INIT      0 .
/*add A55-0325 */
DEFINE VAR nv_insref    AS CHARACTER FORMAT "X(10)".          
DEFINE VAR n_insref     AS CHARACTER FORMAT "X(10)".  
DEF VAR nv_usrid        AS CHARACTER FORMAT "X(08)".             
DEF VAR nv_transfer     AS LOGICAL   .                            
DEF VAR n_check         AS CHARACTER .                            
DEF VAR nv_typ          AS CHAR FORMAT "X(2)".    
/*add A55-0325 */
DEFINE VAR  nv_driver   AS CHARACTER FORMAT "X(23)" INITIAL ""  .
DEFINE VAR  np_driver   AS CHAR      FORMAT "X(23)" INIT "".

DEFINE NEW SHARED WORKFILE ws0m009 NO-UNDO
/*1*/  FIELD policy     AS CHARACTER    INITIAL ""  
/*2*/  FIELD lnumber    AS INTEGER   
       FIELD ltext      AS CHARACTER    INITIAL "" 
       FIELD ltext2     AS CHARACTER    INITIAL "" 
       FIELD drivbirth  AS date init ?            //-- A68-0059
       FIELD drivage    AS inte init 0            //  
       FIELD occupcod   AS char format "x(10)"    //
       FIELD occupdes   AS char format "x(60)"    //
       FIELD cardflg    AS char format "x(3) "    //
       FIELD drividno   AS char format "x(30)"    //
       FIELD licenno    AS char format "x(30)"    //
       FIELD drivnam    AS char format "x(120)"   //
       FIELD gender     AS char format "x(15)"    //
       FIELD drivlevel  AS inte init 0            //
       FIELD levelper   AS deci init 0            //
       FIELD titlenam   AS char FORMAT "x(40)"    //
       FIELD licenexp   AS date INIT ?            //
       FIELD firstnam   AS char format "x(60)"    //
       FIELD lastnam    AS char format "x(60)"    //
       FIELD dconsen    AS LOGICAL INIT NO.       //-- A68-0059

DEFINE NEW SHARED WORKFILE wuwd132
    FIELD prepol        AS CHAR FORMAT "X(20)" INIT ""
    FIELD bencod        AS CHAR FORMAT "X(30)" INIT "" 
    FIELD benvar        AS CHAR FORMAT "X(40)" INIT "" 
    FIELD gap_c         AS DECI FORMAT ">>>,>>>,>>9.99-"    
    FIELD prem_c        AS DECI FORMAT ">>>,>>>,>>9.99-"  . 

DEF NEW SHARED VAR nr_premtxt       AS CHAR FORMAT "X(100)" INIT "".
DEF NEW SHARED VAR n_poltyp         AS CHAR FORMAT "X(5)" INIT ""    .
DEF NEW SHARED VAR n_account_no     AS CHAR FORMAT "X(20)"  INIT "" .
DEF NEW SHARED VAR n_inscode        AS CHAR FORMAT "X(20)"  INIT "" .
DEF NEW SHARED VAR n_campcode       AS CHAR FORMAT "X(20)"  INIT "" .      
DEF NEW SHARED VAR n_campname       AS CHAR FORMAT "X(35)"  INIT "" .      
DEF NEW SHARED VAR n_procode        AS CHAR FORMAT "X(20)"  INIT "" .      
DEF NEW SHARED VAR n_proname        AS CHAR FORMAT "X(35)"  INIT "" .      
DEF NEW SHARED VAR n_packname       AS CHAR FORMAT "X(35)"  INIT "" .      
DEF NEW SHARED VAR n_packcode       AS CHAR FORMAT "X(20)"  INIT "" .      
DEF NEW SHARED VAR n_instype        AS CHAR FORMAT "X(1)"   INIT "" .      
DEF NEW SHARED VAR n_tiname         AS CHAR FORMAT "X(20)"  INIT "" .      
DEF NEW SHARED VAR n_insnam         AS CHAR FORMAT "X(100)" INIT "" .      
DEF NEW SHARED VAR n_title_eng      AS CHAR FORMAT "X(10)"  INIT "" .      
DEF NEW SHARED VAR n_insname_eng    AS CHAR FORMAT "X(100)" INIT "" .      
DEF NEW SHARED VAR n_icno           AS CHAR FORMAT "X(13)"  INIT "" .
DEF NEW SHARED VAR n_bdate          AS CHAR FORMAT "X(15)"  INIT "" .      
DEF NEW SHARED VAR n_occup          AS CHAR FORMAT "X(50)"  INIT "" .      
DEF NEW SHARED VAR n_tel            AS CHAR FORMAT "X(50)"  INIT "" .      
DEF NEW SHARED VAR n_mail           AS CHAR FORMAT "X(50)"  INIT "" .      
DEF NEW SHARED VAR n_addrpol1       AS CHAR FORMAT "X(40)"  INIT "" .      
DEF NEW SHARED VAR n_addrpol2       AS CHAR FORMAT "X(40)"  INIT "" .      
DEF NEW SHARED VAR n_addrpol3       AS CHAR FORMAT "X(40)"  INIT "" .      
DEF NEW SHARED VAR n_addrpol4       AS CHAR FORMAT "X(40)"  INIT "" .      
DEF NEW SHARED VAR n_addrsend1      AS CHAR FORMAT "X(45)"  INIT "" .      
DEF NEW SHARED VAR n_addrsend2      AS CHAR FORMAT "X(45)"  INIT "" .      
DEF NEW SHARED VAR n_addrsend3      AS CHAR FORMAT "X(45)"  INIT "" .      
DEF NEW SHARED VAR n_addrsend4      AS CHAR FORMAT "X(45)"  INIT "" .      
DEF NEW SHARED VAR n_paytype        AS CHAR FORMAT "X(2)"   INIT "" .      
DEF NEW SHARED VAR n_paytitle       AS CHAR FORMAT "X(20)"  INIT "" .      
DEF NEW SHARED VAR n_payname        AS CHAR FORMAT "X(100)" INIT "" .
DEF NEW SHARED VAR n_payic          AS CHAR FORMAT "X(13)" INIT "" .
DEF NEW SHARED VAR n_addrpay1       AS CHAR FORMAT "X(45)"  INIT "" .      
DEF NEW SHARED VAR n_addrpay2       AS CHAR FORMAT "X(45)"  INIT "" .      
DEF NEW SHARED VAR n_addrpay3       AS CHAR FORMAT "X(45)"  INIT "" .      
DEF NEW SHARED VAR n_addrpay4       AS CHAR FORMAT "X(45)"  INIT "" . 
DEF NEW SHARED VAR n_branch         AS CHAR FORMAT "X(20)"  INIT "" .      
DEF NEW SHARED VAR n_ben_name       AS CHAR FORMAT "X(100)" INIT "" .      
DEF NEW SHARED VAR n_pmentcode      AS CHAR FORMAT "X(10)"  INIT "" .      
DEF NEW SHARED VAR n_pmenttyp       AS CHAR FORMAT "X(75)"  INIT "" .      
DEF NEW SHARED VAR n_pmentcode1     AS CHAR FORMAT "X(10)"  INIT "" .      
DEF NEW SHARED VAR n_pmentcode2     AS CHAR FORMAT "X(75)"  INIT "" .      
DEF NEW SHARED VAR n_pmentbank      AS CHAR FORMAT "X(50)"  INIT "" .
DEF NEW SHARED VAR n_pmentdate      AS CHAR FORMAT "X(15)"  INIT "" .      
DEF NEW SHARED VAR n_pmentsts       AS CHAR FORMAT "X(15)"  INIT "" .      
DEF NEW SHARED VAR n_brand          AS CHAR FORMAT "X(35)"  INIT "" .
DEF NEW SHARED VAR n_Model          AS CHAR FORMAT "X(50)"  INIT "" .
DEF NEW SHARED VAR n_body           AS CHAR FORMAT "X(20)"  INIT "" .
DEF NEW SHARED VAR n_vehreg         AS CHAR FORMAT "X(11)"  INIT "" .
DEF NEW SHARED VAR n_re_country     AS CHAR FORMAT "X(25)"  INIT "" .
DEF NEW SHARED VAR n_chASno         AS CHAR FORMAT "X(20)"  INIT "" .
DEF NEW SHARED VAR n_eng            AS CHAR FORMAT "X(20)"  INIT "" .
DEF NEW SHARED VAR n_caryear        AS CHAR FORMAT "X(5)"   INIT "" .
DEF NEW SHARED VAR n_seate          AS CHAR FORMAT "X(5)"   INIT "" .
DEF NEW SHARED VAR n_engcc          AS CHAR FORMAT "X(15)"  INIT "" .
DEF NEW SHARED VAR n_power          AS CHAR FORMAT "X(15)"  INIT "" .
DEF NEW SHARED VAR n_clASs          AS CHAR FORMAT "X(5)"   INIT "" .                                      
DEF NEW SHARED VAR n_garage         AS CHAR FORMAT "X(35)"  INIT "" .
DEF NEW SHARED VAR n_colorcode      AS CHAR FORMAT "X(35)"  INIT "" .
DEF NEW SHARED VAR n_covcod         AS CHAR FORMAT "X(50)"  INIT "" .
DEF NEW SHARED VAR n_covtyp         AS CHAR FORMAT "X(30)"  INIT "" .
DEF NEW SHARED VAR n_comdat         AS CHAR FORMAT "X(15)"  INIT "" .
DEF NEW SHARED VAR n_expdat         AS CHAR FORMAT "X(15)"  INIT "" .
DEF NEW SHARED VAR n_si             AS CHAR FORMAT "X(20)"  INIT "" .
DEF NEW SHARED VAR n_prem1          AS CHAR FORMAT "X(20)"  INIT "" .
DEF NEW SHARED VAR n_gross_prm      AS CHAR FORMAT "X(20)"  INIT "" .
DEF NEW SHARED VAR n_stamp          AS CHAR FORMAT "X(10)"  INIT "" .
DEF NEW SHARED VAR n_vat            AS CHAR FORMAT "X(10)"  INIT "" .
DEF NEW SHARED VAR n_premtotal      AS CHAR FORMAT "X(20)"  INIT "" .
DEF NEW SHARED VAR n_deduct         AS CHAR FORMAT "X(10)"  INIT "" .
DEF NEW SHARED VAR n_fleetper       AS CHAR FORMAT "X(10)"  INIT "" .
DEF NEW SHARED VAR n_ncb            AS CHAR FORMAT "X(10)"  INIT "" .
DEF NEW SHARED VAR n_drivper        AS CHAR FORMAT "X(10)"  INIT "" .
DEF NEW SHARED VAR n_othper         AS CHAR FORMAT "X(10)"  INIT "" .
DEF NEW SHARED VAR n_cctvper        AS CHAR FORMAT "X(10)"  INIT "" .
DEF NEW SHARED VAR n_Surcharper     AS CHAR FORMAT "X(10)"  INIT "" .
DEF NEW SHARED VAR n_Surchardetail  AS CHAR FORMAT "X(250)" INIT "" .
DEF NEW SHARED VAR n_driver         AS CHAR FORMAT "X(2)"   INIT "" .      
DEF NEW SHARED VAR n_drivnam1       AS CHAR FORMAT "X(70)"  INIT "" .
DEF NEW SHARED VAR n_driveno1       AS CHAR FORMAT "X(15)"  INIT "" .      
DEF NEW SHARED VAR n_occupdri1      AS CHAR FORMAT "X(50)"  INIT "" .      
DEF NEW SHARED VAR n_sexdriv1       AS CHAR FORMAT "X(10)"  INIT "" .      
DEF NEW SHARED VAR n_bdatedri1      AS CHAR FORMAT "X(15)"  INIT "" .      
DEF NEW SHARED VAR n_drivnam2       AS CHAR FORMAT "X(70)"  INIT "" .
DEF NEW SHARED VAR n_driveno2       AS CHAR FORMAT "X(15)"  INIT "" .      
DEF NEW SHARED VAR n_occupdri2      AS CHAR FORMAT "X(50)"  INIT "" .      
DEF NEW SHARED VAR n_sexdriv2       AS CHAR FORMAT "X(10)"  INIT "" .      
DEF NEW SHARED VAR n_bdatedri2      AS CHAR FORMAT "X(15)"  INIT "" . 
DEF NEW SHARED VAR n_acc1           AS CHAR FORMAT "X(100)" INIT "" .
DEF NEW SHARED VAR n_accdetail1     AS CHAR FORMAT "X(100)" INIT "" .
DEF NEW SHARED VAR n_accprice1      AS CHAR FORMAT "X(20)"  INIT "" .
DEF NEW SHARED VAR n_acc2           AS CHAR FORMAT "X(100)" INIT "" .
DEF NEW SHARED VAR n_accdetail2     AS CHAR FORMAT "X(100)" INIT "" .
DEF NEW SHARED VAR n_accprice2      AS CHAR FORMAT "X(20)"  INIT "" .
DEF NEW SHARED VAR n_acc3           AS CHAR FORMAT "X(100)" INIT "" .
DEF NEW SHARED VAR n_accdetail3     AS CHAR FORMAT "X(100)" INIT "" .
DEF NEW SHARED VAR n_accprice3      AS CHAR FORMAT "X(20)"  INIT "" .
DEF NEW SHARED VAR n_acc4           AS CHAR FORMAT "X(100)" INIT "" .
DEF NEW SHARED VAR n_accdetail4     AS CHAR FORMAT "X(100)" INIT "" .
DEF NEW SHARED VAR n_accprice4      AS CHAR FORMAT "X(20)"  INIT "" .
DEF NEW SHARED VAR n_acc5           AS CHAR FORMAT "X(100)" INIT "" .
DEF NEW SHARED VAR n_accdetail5     AS CHAR FORMAT "X(100)" INIT "" .
DEF NEW SHARED VAR n_accprice5      AS CHAR FORMAT "X(20)"  INIT "" .
DEF NEW SHARED VAR n_inspdate       AS CHAR FORMAT "X(15)"  INIT "" .
DEF NEW SHARED VAR n_inspdate_app   AS CHAR FORMAT "X(50)"  INIT "" .
DEF NEW SHARED VAR n_inspsts        AS CHAR FORMAT "X(50)"  INIT "" .
DEF NEW SHARED VAR n_inspdetail     AS CHAR FORMAT "X(250)" INIT "" .
DEF NEW SHARED VAR n_not_date       AS CHAR FORMAT "X(15)"  INIT "" .
DEF NEW SHARED VAR n_paydate        AS CHAR FORMAT "X(15)"  INIT "" .
DEF NEW SHARED VAR n_paysts         AS CHAR FORMAT "X(15)"  INIT "" .
DEF NEW SHARED VAR n_licenBroker    AS CHAR FORMAT "X(20)"  INIT "" .
DEF NEW SHARED VAR n_brokname       AS CHAR FORMAT "X(100)" INIT "" .
DEF NEW SHARED VAR n_brokcode       AS CHAR FORMAT "X(15)"  INIT "" .
DEF NEW SHARED VAR n_lang           AS CHAR FORMAT "X(50)"  INIT "" .
DEF NEW SHARED VAR n_deli           AS CHAR FORMAT "X(100)" INIT "" .
DEF NEW SHARED VAR n_delidetail     AS CHAR FORMAT "X(100)" INIT "" .
DEF NEW SHARED VAR n_gift           AS CHAR FORMAT "X(100)" INIT "" .
DEF NEW SHARED VAR n_remark         AS CHAR FORMAT "X(250)" INIT "" .
DEF NEW SHARED VAR n_inspno         AS CHAR FORMAT "X(25)" INIT "" .
DEF NEW SHARED VAR n_remarkinsp     AS CHAR FORMAT "X(750)" INIT "".
DEF NEW SHARED VAR n_damang1        AS CHAR FORMAT "X(750)" INIT "".
DEF NEW SHARED VAR n_damang2        AS CHAR FORMAT "X(750)" INIT "".
DEF NEW SHARED VAR n_damang3        AS CHAR FORMAT "X(750)" INIT "".
DEF NEW SHARED VAR n_dataoth        AS CHAR FORMAT "X(750)" INIT "".
DEF NEW SHARED VAR n_sellcode       AS CHAR FORMAT "X(20)"  INIT "". /*-- Add By Tontawan S. A66-0006 25/01/2023 ---*/
DEF NEW SHARED VAR n_sellname       AS CHAR FORMAT "X(100)" INIT "". /*-- Add By Tontawan S. A66-0006 25/01/2023 ---*/
DEF NEW SHARED VAR n_campaign       AS CHAR FORMAT "X(20)"  INIT "". /*-- Add By Tontawan S. A66-0006 25/01/2023 ---*/
DEF NEW SHARED VAR n_branch_c       AS CHAR FORMAT "X(20)"  INIT "". /*-- Add By Tontawan S. A66-0006 25/01/2023 ---*/
DEF NEW SHARED VAR n_selling_ch     AS CHAR FORMAT "X(20)"  INIT "". /*-- Add By Tontawan S. A66-0006 25/01/2023 ---*/
DEF NEW SHARED VAR n_ispno          AS CHAR FORMAT "X(20)"  INIT "". /*-- Add By Tontawan S. A66-0006 25/01/2023 ---*/

DEF NEW SHARED VAR n_drv3_name          AS CHAR FORMAT "X(100)".    // คนขับ 3 : ชื่อ-นามสกุล ----------- Add Tontawan S. A68-0059 --     
DEF NEW SHARED VAR n_drv3_salutation_M  AS CHAR FORMAT "X(20)".     // คนขับ 3 : คำนำหน้า 
DEF NEW SHARED VAR n_drv3_fname         AS CHAR FORMAT "X(100)".    // คนขับ 3 : ชื่อ     
DEF NEW SHARED VAR n_drv3_lname         AS CHAR FORMAT "X(100)".    // คนขับ 3 : นามสกุล 
DEF NEW SHARED VAR n_drv3_nid           AS CHAR FORMAT "X(20)".     // คนขับ 3 : เลขบัตรประชาชน    
DEF NEW SHARED VAR n_drv3_occupation    AS CHAR FORMAT "X(50)".     // คนขับ 3 : อาชีพ             
DEF NEW SHARED VAR n_drv3_gender        AS CHAR FORMAT "X(10)".     // คนขับ 3 : เพศ               
DEF NEW SHARED VAR n_drv3_birthdate     AS CHAR FORMAT "X(15)".     // คนขับ 3 : วันเกิด           
DEF NEW SHARED VAR n_drv4_name          AS CHAR FORMAT "X(100)".    // คนขับ 4 : ชื่อ-นามสกุล
DEF NEW SHARED VAR n_drv4_salutation_M  AS CHAR FORMAT "X(20)".     // คนขับ 4 : คำนำหน้า 
DEF NEW SHARED VAR n_drv4_fname         AS CHAR FORMAT "X(100)".    // คนขับ 4 : ชื่อ     
DEF NEW SHARED VAR n_drv4_lname         AS CHAR FORMAT "X(100)".    // คนขับ 4 : นามสกุล 
DEF NEW SHARED VAR n_drv4_nid           AS CHAR FORMAT "X(20)".     // คนขับ 4 : เลขบัตรประชาชน    
DEF NEW SHARED VAR n_drv4_occupation    AS CHAR FORMAT "X(50)".     // คนขับ 4 : อาชีพ             
DEF NEW SHARED VAR n_drv4_gender        AS CHAR FORMAT "X(10)".     // คนขับ 4 : เพศ               
DEF NEW SHARED VAR n_drv4_birthdate     AS CHAR FORMAT "X(15)".     // คนขับ 4 : วันเกิด           
DEF NEW SHARED VAR n_drv5_name          AS CHAR FORMAT "X(100)".    // คนขับ 5 : ชื่อ-นามสกุล
DEF NEW SHARED VAR n_drv5_salutation_M  AS CHAR FORMAT "X(20)".     // คนขับ 5 : คำนำหน้า 
DEF NEW SHARED VAR n_drv5_fname         AS CHAR FORMAT "X(100)".    // คนขับ 5 : ชื่อ     
DEF NEW SHARED VAR n_drv5_lname         AS CHAR FORMAT "X(100)".    // คนขับ 5 : นามสกุล 
DEF NEW SHARED VAR n_drv5_nid           AS CHAR FORMAT "X(20)".     // คนขับ 5 : เลขบัตรประชาชน    
DEF NEW SHARED VAR n_drv5_occupation    AS CHAR FORMAT "X(50)".     // คนขับ 5 : อาชีพ             
DEF NEW SHARED VAR n_drv5_gender        AS CHAR FORMAT "X(10)".     // คนขับ 5 : เพศ               
DEF NEW SHARED VAR n_drv5_birthdate     AS CHAR FORMAT "X(15)".     // คนขับ 5 : วันเกิด           
DEF NEW SHARED VAR n_drv1_dlicense      AS CHAR FORMAT "X(50)".     // คนขับ 1 : ทะเบียนรถ         
DEF NEW SHARED VAR n_drv2_dlicense      AS CHAR FORMAT "X(50)".     // คนขับ 2 : ทะเบียนรถ         
DEF NEW SHARED VAR n_drv3_dlicense      AS CHAR FORMAT "X(50)".     // คนขับ 3 : ทะเบียนรถ         
DEF NEW SHARED VAR n_drv4_dlicense      AS CHAR FORMAT "X(50)".     // คนขับ 4 : ทะเบียนรถ         
DEF NEW SHARED VAR n_drv5_dlicense      AS CHAR FORMAT "X(50)".     // คนขับ 5 : ทะเบียนรถ         
DEF NEW SHARED VAR n_baty_snumber       AS CHAR FORMAT "X(20)".     // Battery : Serial Number     
DEF NEW SHARED VAR n_batydate           AS CHAR FORMAT "X(10)".     // Battery : Year              
DEF NEW SHARED VAR n_baty_rsi           AS CHAR FORMAT "X(20)".     // Battery : Replacement SI    
DEF NEW SHARED VAR n_baty_npremium      AS CHAR FORMAT "X(20)".     // Battery : Net Premium       
DEF NEW SHARED VAR n_baty_gpremium      AS CHAR FORMAT "X(20)".     // Battery : Gross_Premium     
DEF NEW SHARED VAR n_wcharge_snumber    AS CHAR FORMAT "X(20)".     // Wall Charge : Serial_Number 
DEF NEW SHARED VAR n_wcharge_si         AS CHAR FORMAT "X(20)".     // Wall Charge : SI            
DEF NEW SHARED VAR n_wcharge_npremium   AS CHAR FORMAT "X(20)".     // Wall Charge : Net Premium   
DEF NEW SHARED VAR n_wcharge_gpremium   AS CHAR FORMAT "X(20)".     // Wall Charge : Gross Premium 
DEF NEW SHARED VAR n_PerPersonBI        AS CHAR FORMAT "X(20)".     //
DEF NEW SHARED VAR n_PerAccident        AS CHAR FORMAT "X(20)".     //
DEF NEW SHARED VAR n_PerAccidentPD      AS CHAR FORMAT "X(20)".     //
DEF NEW SHARED VAR n_41SI               AS CHAR FORMAT "X(20)".     //
DEF NEW SHARED VAR n_42Sum              AS CHAR FORMAT "X(20)".     //
DEF NEW SHARED VAR n_43Sum              AS CHAR FORMAT "X(20)".     //
DEF NEW SHARED VAR n_newtrariff         AS CHAR FORMAT "X(5)".      //
DEF BUFFER wf_uwd132 FOR sic_bran.uwd132.                           //
DEF VAR nv_412                          AS DECIMAL.                //
DEF VAR nv_411t                         AS DECIMAL.                //
DEF VAR nv_412t                         AS DECIMAL.                //
DEF VAR nv_42t                          AS DECIMAL.                //
DEF VAR nv_43t                          AS DECIMAL.                //
DEF VAR nv_dstf                         AS DECIMAL.                //
DEF VAR nv_comment                      AS CHAR FORMAT "x(250)" .  //
DEF VAR nv_warning                      AS CHAR FORMAT "x(250)" .  //
DEF VAR nv_pass                         AS CHAR .                  //
DEF VAR n_case1                         AS CHAR INIT "".           //    
DEF VAR n_case2                         AS CHAR INIT "".           //    
DEF VAR n_case3                         AS CHAR INIT "".           //    
DEF VAR n_case4                         AS CHAR INIT "".           //-- End Tontawan S. A68-0059 --

DEF NEW SHARED VAR nv_prem3      AS DECIMAL FORMAT ">,>>>,>>9.99-" INITIAL 0  NO-UNDO.
DEF NEW SHARED VAR nv_sicod3     AS CHAR    FORMAT "X(4)".
DEF NEW SHARED VAR nv_usecod3    AS CHAR    FORMAT "X(4)".
DEF NEW SHARED VAR nv_siprm3     AS DECI    FORMAT ">>,>>>,>>9.99-".
DEF NEW SHARED VAR nv_prvprm3    AS DECI    FORMAT ">>,>>>,>>9.99-".
DEF NEW SHARED VAR nv_bASeprm3   AS DECI    FORMAT ">>,>>>,>>9.99-".
DEF NEW SHARED VAR nv_useprm3    AS DECI    FORMAT ">>,>>>,>>9.99-".
DEF NEW SHARED VAR nv_bASecod3   AS CHAR    FORMAT "X(4)".
DEF NEW SHARED VAR nv_bASevar3   AS CHAR    FORMAT "X(60)".
DEF NEW SHARED VAR nv_bASevar4   AS CHAR    FORMAT "X(30)".
DEF NEW SHARED VAR nv_bASevar5   AS CHAR    FORMAT "X(30)".
DEF NEW SHARED VAR nv_usevar3    AS CHAR    FORMAT "X(60)".
DEF NEW SHARED VAR nv_usevar4    AS CHAR    FORMAT "X(30)".
DEF NEW SHARED VAR nv_usevar5    AS CHAR    FORMAT "X(30)".
DEF NEW SHARED VAR nv_sivar3     AS CHAR    FORMAT "X(60)".
DEF NEW SHARED VAR nv_sivar4     AS CHAR    FORMAT "X(30)".
DEF NEW SHARED VAR nv_sivar5     AS CHAR    FORMAT "X(30)".

DEF VAR nv_campaign_ov              AS CHAR FORMAT "X(30)" INIT "" .  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
DEF VAR nv_codeocc                  AS CHAR FORMAT "X(30)" INIT "" .     /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
DEF VAR nv_codeaddr1                AS CHAR FORMAT "X(30)" INIT "" .     /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
DEF VAR nv_codeaddr2                AS CHAR FORMAT "X(30)" INIT "" .     /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
DEF VAR nv_codeaddr3                AS CHAR FORMAT "X(30)" INIT "" .     /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
DEF VAR nv_insnamtyp                AS CHAR FORMAT "X(30)" INIT "" .     /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/    
DEF VAR nv_firstName                AS CHAR FORMAT "X(30)" INIT "" .     /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/    
DEF VAR nv_lAStName                 AS CHAR FORMAT "X(30)" INIT "" .     /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/   
DEF VAR nv_postcd                   AS CHAR FORMAT "X(30)" INIT "" .     /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/  
DEF VAR nv_chkerror                 AS CHAR FORMAT "X(30)" INIT "" .     /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/  

/* add by : A64-0138 */
DEFINE NEW SHARED TEMP-TABLE wkuwd132 LIKE stat.pmuwd132.
DEF    VAR nv_cstflg       AS CHAR FORMAT "X(2)".     /*C=CC ; S=Seat ; T=Tons ; W=Watts*/  
DEFINE VAR nv_engcst       AS DECI FORMAT ">>>>>9.99".
                           
DEFINE VAR nv_driage1      AS INTE FORMAT ">>9".
DEFINE VAR nv_driage2      AS INTE FORMAT ">>9".
DEF    VAR nv_pdprm0       AS DECI FORMAT ">>>,>>>,>>9.99-". /*เบี้ยผู้ขับขี่*/
DEFINE VAR nv_yrmanu       AS INTE FORMAT "9999".
                           
DEFINE VAR nv_vehgrp       AS CHAR FORMAT "X(3)".
DEFINE VAR nv_access       AS CHAR FORMAT "X(3)".
DEFINE VAR nv_supe         AS LOGICAL.
DEFINE VAR nv_totfi        AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_tpbi1si      AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_tpbi2si      AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_tppdsi       AS DECI FORMAT ">>>,>>>,>>9.99-".
                           
DEFINE VAR nv_411si        AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_412si        AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_413si        AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_414si        AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_42si         AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_43si         AS DECI FORMAT ">>>,>>>,>>9.99-".
                           
DEFINE VAR nv_ncbp         AS DECI FORMAT ">,>>9.99-".
DEFINE VAR nv_fletp        AS DECI FORMAT ">,>>9.99-".
DEFINE VAR nv_dspcp        AS DECI FORMAT ">,>>9.99-".
DEFINE VAR nv_dstfp        AS DECI FORMAT ">,>>9.99-".
DEFINE VAR nv_clmp         AS DECI FORMAT ">,>>9.99-".
                           
DEFINE VAR nv_netprem      AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_gapprem      AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_flagprm      AS CHAR FORMAT "X(2)". /* N=Net,G=Gross */
                           
DEFINE VAR nv_effdat       AS DATE FORMAT "99/99/9999".

DEFINE VAR nv_ratatt       AS DECI FORMAT ">>,>>>,>>9-".
DEFINE VAR nv_siatt        AS DECI FORMAT ">>,>>>,>>9-".
DEFINE VAR nv_netatt       AS DECI FORMAT ">>,>>>,>>9-".
DEFINE VAR nv_fltatt       AS DECI FORMAT ">>,>>>,>>9-".
DEFINE VAR nv_ncbatt       AS DECI FORMAT ">>,>>>,>>9-".
DEFINE VAR nv_dscatt       AS DECI FORMAT ">>,>>>,>>9-".
DEFINE VAR nv_fcctv        AS LOGICAL . 
define var nv_uom1_c       AS char .
define var nv_uom2_c       AS char .
define var nv_uom5_c       AS char .

DEFINE VAR nv_41prmt       AS DECI FORMAT ">>>,>>>,>>9.99-".  /* fleet */
DEFINE VAR nv_42prmt       AS DECI FORMAT ">>>,>>>,>>9.99-".  /* fleet */
DEFINE VAR nv_43prmt       AS DECI FORMAT ">>>,>>>,>>9.99-".  /* fleet */
DEFINE VAR nv_pdprem       AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_412prmt      AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_413prmt      AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_414prmt      AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_status       AS CHAR .   /*fleet YES=Complete , NO=Not Complete */
DEFINE VAR nv_level        AS INT.
DEFINE VAR nv_levper       AS INT.
DEFINE VAR nv_mainprm      AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_dodamt       AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_dadamt       AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_dpdamt       AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_ncbamt       AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_fletamt      AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_dspcamt      AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_dstfamt      AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_clmamt       AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_attgap       AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_atfltgap     AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_atncbgap     AS DECI FORMAT ">>>,>>>,>>9.99-". 
DEFINE VAR nv_atdscgap     AS DECI FORMAT ">>>,>>>,>>9.99-". 
DEFINE VAR nv_packatt      AS CHAR.
DEFINE VAR nv_flgsht       AS CHAR.
DEFINE VAR nv_campcd       AS CHAR FORMAT "X(40)".

DEFINE VAR nv_adjpaprm     AS LOGICAL.  //Add A68-0059 30/04/2025
DEFINE VAR nv_flgpol       AS CHAR.     /*NR=New RedPlate, NU=New Used Car, RN=Renew*/
DEFINE VAR nv_flgclm       AS CHAR.     /*NC=NO CLAIM , WC=With Claim*/ 
DEFINE VAR nv_chgflg       AS LOGICAL.
DEFINE VAR nv_chgrate      AS DECI FORMAT ">>>9.9999-".
DEFINE VAR nv_chgsi        AS INTE FORMAT ">>>,>>>,>>9-".
DEFINE VAR nv_chgpdprm     AS DECI FORMAT ">>,>>>,>>9.99-".
DEFINE VAR nv_chggapprm    AS DECI FORMAT ">>,>>>,>>9.99-".
DEFINE VAR nv_battflg      AS LOGICAL.
DEFINE VAR nv_battrate     AS DECI FORMAT ">>>9.9999-".
DEFINE VAR nv_battsi       AS INTE FORMAT ">>>,>>>,>>9-".
DEFINE VAR nv_battprice    AS INTE FORMAT ">>>,>>>,>>9-".
DEFINE VAR nv_battpdprm    AS DECI FORMAT ">>,>>>,>>9.99-".
DEFINE VAR nv_battgapprm   AS DECI FORMAT ">>,>>>,>>9.99-".
DEFINE VAR nv_battyr       AS INTE FORMAT "9999".
DEFINE VAR nv_battper      AS DECI FORMAT ">>9.99-".  
DEFINE VAR nv_evflg        AS LOGICAL.     
DEFINE VAR nv_uom9_v       AS INTE FORMAT ">>>,>>>,>>9".  
DEFINE VAR nv_31prmt       AS DECI FORMAT ">>,>>>,>>9.99-".
DEFINE VAR nv_31rate       AS DECI FORMAT ">>,>>>,>>9.99-".
DEFINE VAR cv_lncbper   AS DECI FORMAT ">,>>9.99-".  /*Limit NCB %  50%*/ //End A68-0059 30/04/2025
/* end A64-0138 */

