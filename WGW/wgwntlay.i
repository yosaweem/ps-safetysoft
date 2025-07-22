/*programid   : wgwntlay.i                                               */
/*programname : load text file aycal new form to GW                               */
/* Copyright  : Safety Insurance Public Company Limited 			     */
/*			    บริษัท ประกันคุ้มภัย จำกัด (มหาชน)				         */
/*create by   : Ranu i. a61-0573 10/02/2019           
                โปรแกรมให้สามารถนำเข้า text file AYCAL to GW system    */ 
/*copy write  : wgwtlscb.i                                               */
/*Modify by   : Kridtiya i. A63-0472 Date. 09/11/2020 add field firstname ,lastname.....*/
/*Mofiby by : Ranu I. a64-0138 เพิ่มตัวแปรเก็บข้อมูลจากการคำนวณเบี้ย    */
/*modify by : Ranu I. A65-0115 เพิ่มตัวแปร Dealer code */
/*Modify by   : Kridtiya i. A66-0160 Add color and campaign = Producer    */
/*Modify by : Ranu I. A67-0162 เพิ่มการเก็ฐข้อมูลรถไฟฟ้า */
/*Modify by : Ranu I. A67-0204 ขยายฟอร์แมตตัวแปร subclass     */
/*************************************************************************/
DEFINE NEW SHARED TEMP-TABLE wdetail NO-UNDO
    FIELD poltyp         AS CHAR FORMAT "x(5)" INIT ""
    FIELD policy         AS CHAR FORMAT "x(15)" INIT ""
    field account_no     as  CHAR FORMAT "X(20)"  INIT ""
    field inscode        as  CHAR FORMAT "X(20)"  INIT ""
    FIELD campcode       as  CHAR FORMAT "X(20)"  INIT ""        
    FIELD campname       as  CHAR FORMAT "X(35)"  INIT ""        
    FIELD procode        as  CHAR FORMAT "X(20)"  INIT ""        
    FIELD proname        as  CHAR FORMAT "X(35)"  INIT ""        
    FIELD packname       as  CHAR FORMAT "X(35)"  INIT ""        
    FIELD packcode       as  CHAR FORMAT "X(20)"  INIT ""        
    FIELD instype        as  CHAR FORMAT "X(1)"   INIT ""        
    FIELD tiname         as  CHAR FORMAT "X(20)"  INIT ""        
    FIELD insnam         as  CHAR FORMAT "X(100)" INIT ""        
    FIELD title_eng      as  CHAR FORMAT "X(10)"  INIT ""        
    FIELD insname_eng    as  CHAR FORMAT "X(100)" INIT ""        
    FIELD icno           as  CHAR FORMAT "X(13)"  INIT "" 
    FIELD bdate          as  CHAR FORMAT "X(15)"  INIT ""        
    FIELD occup          as  CHAR FORMAT "X(50)"  INIT ""        
    FIELD tel            as  CHAR FORMAT "X(50)"  INIT ""        
    FIELD mail           as  CHAR FORMAT "X(50)"  INIT ""        
    FIELD addr1          as  CHAR FORMAT "X(40)"  INIT ""        
    FIELD addr2          as  CHAR FORMAT "X(40)"  INIT ""        
    FIELD addr3          as  CHAR FORMAT "X(40)"  INIT ""        
    FIELD addr4          as  CHAR FORMAT "X(40)"  INIT "" 
    FIELD benname        as  CHAR FORMAT "X(100)" INIT "" 
    field brand          as  char format "x(35)"  init ""
    field Model          as  char format "x(50)"  init ""
    field body           as  char format "x(20)"  init ""
    field vehreg         as  char format "x(11)"  init ""
    field re_country     as  char format "x(25)"  init ""
    field chasno         as  char format "x(50)"  init ""
    field eng            as  char format "x(50)"  init ""
    field caryear        as  char format "x(5)"   init ""
    field seate          as  INT  INIT 0
    FIELD engcc          as  CHAR FORMAT "x(15)"  INIT ""
    FIELD weight         as  CHAR FORMAT "X(15)"  INIT ""
    FIELD subclass       as  char format "x(5)"   init ""                                        
    FIELD garage         as  char format "x(35)"  init ""
    FIELD colorcode      as  char format "x(35)"  init ""
    FIELD covcod         as  char format "x(50)"  init ""
    FIELD covtyp         as  char format "x(30)"  init ""
    FIELD comdat         as  char format "x(15)"  init ""
    FIELD expdat         as  char format "x(15)"  init ""
    FIELD si             as  CHAR FORMAT "x(20)"  INIT ""
    FIELD prem1          as  char format "x(20)"  init ""
    FIELD gross_prm      as  char format "x(20)"  init ""
    FIELD stamp          as  CHAR FORMAT "x(10)"  INIT ""
    FIELD vat            as  CHAR FORMAT "X(10)"  INIT ""
    FIELD premtotal      as  CHAR FORMAT "x(20)"  INIT ""
    field deduct         as  char format "x(10)"  init ""
    field fleetper       as  char format "x(10)"  init ""
    field ncb            as  DECI   INIT 0
    field drivper        as  char format "x(10)"  init ""
    field othper         as  char format "X(10)"  INIT ""
    field cctvper        as  char format "X(10)"  INIT "" 
    FIELD Surcharper     as  CHAR FORMAT "x(10)"  INIT ""
    FIELD drivnam        as  CHAR FORMAT "X(2)"   INIT ""        
    FIELD drivnam1       as  CHAR FORMAT "X(70)"  INIT "" 
    FIELD driveno1       as  CHAR FORMAT "X(15)"  INIT ""        
    FIELD occupdri1      as  CHAR FORMAT "X(50)"  INIT ""        
    FIELD sexdriv1       as  CHAR FORMAT "X(10)"  INIT ""        
    FIELD bdatedri1      as  CHAR FORMAT "X(15)"  INIT "" 
    FIELD drivnam2       as  CHAR FORMAT "x(70)"  INIT "" 
    FIELD driveno2       as  char format "x(15)"  init ""        
    FIELD occupdri2      as  char format "x(50)"  init ""        
    FIELD sexdriv2       as  char format "x(10)"  init ""        
    FIELD bdatedri2      as  char format "x(15)"  init "" 
    FIELD comment        AS CHAR FORMAT "x(512)"  INIT ""
    FIELD producer       AS CHAR FORMAT "x(10)" INIT "" 
    FIELD agent          AS CHAR FORMAT "X(10)" INIT ""
    FIELD trandat        AS CHAR FORMAT "x(10)" INIT ""      
    FIELD trantim        AS CHAR FORMAT "x(8)" INIT ""       
    FIELD n_IMPORT       AS CHAR FORMAT "x(2)" INIT ""       
    FIELD n_EXPORT       AS CHAR FORMAT "x(2)" INIT "" 
    FIELD pass           AS CHAR FORMAT "x"  INIT "n"
    FIELD OK_GEN         AS CHAR FORMAT "X" INIT "Y" 
    FIELD vehuse         AS CHAR FORMAT "x(2)" INIT ""
    FIELD cargrp         AS CHAR FORMAT "x(2)" INIT ""
    FIELD cr_2           AS CHAR FORMAT "x(20)" INIT ""  
    FIELD docno          AS CHAR INIT "" FORMAT "x(10)" 
    FIELD redbook        AS CHAR INIT "" FORMAT "X(10)"
    FIELD stk            AS CHAR FORMAT "X(15)" INIT ""
    FIELD tariff         AS CHAR FORMAT "x(2)" INIT "9"
    FIELD cancel         AS CHAR FORMAT "x(2)" INIT ""    
    FIELD accdat         AS CHAR INIT "" FORMAT "x(10)"   
    FIELD prempa         AS CHAR FORMAT "x(4)" INIT "" 
    FIELD cndat          AS CHAR FORMAT "x(10)" INIT ""   
    FIELD WARNING        AS CHAR FORMAT "X(30)" INIT ""
    FIELD compul         AS CHAR FORMAT "x"     INIT "n"
    FIELD tp1            AS CHAR FORMAT "x(15)" INIT ""  
    FIELD tp2            AS CHAR FORMAT "x(15)" INIT ""  
    FIELD tp3            AS CHAR FORMAT "x(15)"  INIT "" 
    FIELD NO_41          AS CHAR FORMAT "x(14)" INIT "" 
    FIELD NO_42          AS CHAR FORMAT "x(14)" INIT "" 
    FIELD NO_43          AS CHAR FORMAT "x(14)" INIT "" 
    FIELD branch         AS CHAR FORMAT "x(2)" INIT ""
    FIELD prepol         AS CHAR FORMAT "x(15)" INIT ""
    field comper         as char format "x(15)" init ""      
    field comacc         as char format "x(15)" init ""
    FIELD fi             AS CHAR FORMAT "x(15)" INIT "" 
    FIELD financecd      AS CHAR FORMAT "x(60)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD firstName      AS CHAR FORMAT "x(60)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD lastName       AS CHAR FORMAT "x(60)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD postcd         AS CHAR FORMAT "x(15)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeocc        AS CHAR FORMAT "x(4)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr1      AS CHAR FORMAT "x(2)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr2      AS CHAR FORMAT "x(2)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr3      AS CHAR FORMAT "x(2)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD br_insured     AS CHAR FORMAT "x(5)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD campaign_ov    AS CHAR FORMAT "x(30)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
    FIELD insnamtyp      AS CHAR FORMAT "x(60)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD dealer         AS CHAR FORMAT "x(10)" INIT ""   /*A65-0115 */
     /* A67-0162 */
    field licenno1       AS  CHAR FORMAT "x(10)"  INIT ""                  /* เลขใบขับขี่      */ 
    field licenex1       AS  CHAR FORMAT "x(15)"  INIT ""                  /* วันที่บัตรหมดอายุ*/ 
    field licenno2       AS  CHAR FORMAT "x(10)"  INIT ""                  /* เลขใบขับขี่      */ 
    field licenex2       AS  CHAR FORMAT "x(15)"  INIT ""                  /* วันที่บัตรหมดอายุ*/ 
    FIELD drivename3     as  CHAR FORMAT "X(70)"  INIT ""                  /* ชื่อผู้ขับขี่1   */                        
    FIELD driveno3       as  CHAR FORMAT "X(15)"  INIT ""                  /* เลขบัตรผู้ขับขี่1*/                        
    FIELD occupdriv3     as  CHAR FORMAT "X(50)"  INIT ""                  /* อาชีพผู้ขับขี่1  */                        
    FIELD sexdriv3       as  CHAR FORMAT "X(10)"  INIT ""                  /* เพศผู้ขับขี่1    */                        
    FIELD bdatedriv3     as  CHAR FORMAT "X(15)"  INIT ""                  /* วันเกิดผู้ขับขี่1*/
    field licenno3       AS  CHAR FORMAT "x(10)"  INIT ""                  /* เลขใบขับขี่      */ /* A67-0162  */
    field licenex3       AS  CHAR FORMAT "x(15)"  INIT ""                  /* วันที่บัตรหมดอายุ*/ /* A67-0162  */
    FIELD drivename4     as  CHAR FORMAT "x(70)"  INIT ""                  /* ชื่อผู้ขับขี่2   */                        
    FIELD driveno4       as  char format "x(15)"  init ""                  /* เลขบัตรผู้ขับขี่2*/                        
    FIELD occupdriv4     as  char format "x(50)"  init ""                  /* อาชีพผู้ขับขี่2  */                        
    FIELD sexdriv4       as  char format "x(10)"  init ""                  /* เพศผู้ขับขี่2    */                        
    FIELD bdatedriv4     as  char format "x(15)"  init ""                  /* วันเกิดผู้ขับขี่2*/
    field licenno4       AS  CHAR FORMAT "x(10)"  INIT ""                  /* เลขใบขับขี่      */ /* A67-0162  */
    field licenex4       AS  CHAR FORMAT "x(15)"  INIT ""                  /* วันที่บัตรหมดอายุ*/ /* A67-0162  */
    FIELD drivename5     as  CHAR FORMAT "x(70)"  INIT ""                  /* ชื่อผู้ขับขี่2   */                        
    FIELD driveno5       as  char format "x(15)"  init ""                  /* เลขบัตรผู้ขับขี่2*/                        
    FIELD occupdriv5     as  char format "x(50)"  init ""                  /* อาชีพผู้ขับขี่2  */                        
    FIELD sexdriv5       as  char format "x(10)"  init ""                  /* เพศผู้ขับขี่2    */                        
    FIELD bdatedriv5     as  char format "x(15)"  init ""                  /* วันเกิดผู้ขับขี่2*/
    field licenno5       AS  CHAR FORMAT "x(10)"  INIT ""                  /* เลขใบขับขี่      */ /* A67-0162  */
    field licenex5       AS  CHAR FORMAT "x(15)"  INIT ""                  /* วันที่บัตรหมดอายุ*/ 
    FIELD drilevel       AS  CHAR FORMAT "X(4)" INIT "" 
    field tyeeng        as char format "X(50)" init ""
    field typMC         as char format "X(50)" init ""
    field watt          as char format "X(50)" init ""
    field engno2        as char format "X(50)" init ""
    field evmotor2      as char format "X(50)" init ""
    field evmotor3      as char format "X(50)" init ""
    field evmotor4      as char format "X(50)" init ""
    field evmotor5      as char format "X(50)" init ""
    FIELD maksi         as char format "X(50)" init ""
    field battflag      as char format "X(50)" init ""
    field battyr        as INTE init 0
    field battdate      as char format "X(50)" init ""
    field battprice     as char format "X(50)" init ""
    field battno        as char format "X(50)" init ""
    field battsi        as char format "X(50)" init ""
    field chagreno      as char format "X(50)" init ""
    field chagrebrand   as char format "X(50)" init "" 
    FIELD battper       AS DECI INIT 0
    FIELD drivlevel1     AS  INTE INIT 0
    FIELD drivlevel2     AS  INTE INIT 0
    FIELD drivlevel3     AS  INTE INIT 0
    FIELD drivlevel4     AS  INTE INIT 0
    FIELD drivlevel5     AS  INTE INIT 0.
   /* end: A67-0162 */
DEF VAR nv_chkerror      AS CHAR FORMAT "x(250)" INIT "".  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
DEF VAR nv_postcd        AS CHAR FORMAT "x(25)" INIT "".  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/

DEFINE NEW SHARED TEMP-TABLE wtxt NO-UNDO
    FIELD poltyp         AS  CHAR FORMAT "x(5)"   INIT ""
    FIELD policy         AS  CHAR FORMAT "x(15)"  INIT ""
    FIELD policy2         AS  CHAR FORMAT "x(15)"  INIT ""
    field account_no     as  CHAR FORMAT "X(20)"  INIT ""
    field inscode        as  CHAR FORMAT "X(20)"  INIT ""
    FIELD addrsend1      as  CHAR FORMAT "X(45)"  INIT ""   /* ที่อยู่จัดส่ง*/     
    FIELD addrsend2      as  CHAR FORMAT "X(45)"  INIT ""   /* ที่อยู่จัดส่ง*/     
    FIELD addrsend3      as  CHAR FORMAT "X(45)"  INIT ""   /* ที่อยู่จัดส่ง*/     
    FIELD addrsend4      as  CHAR FORMAT "X(45)"  INIT ""   /* ที่อยู่จัดส่ง*/     
    FIELD paytype        as  CHAR FORMAT "X(2)"   INIT ""        
    FIELD paytitle       as  CHAR FORMAT "X(20)"  INIT ""        
    FIELD payname        as  CHAR FORMAT "X(100)" INIT ""
    FIELD payic          AS  CHAR FORMAT "x(15)"  INIT ""
    FIELD addrpay1       as  char format "x(50)"  init ""  /* ที่อยู่ออกใบเสร็จ */
    FIELD addrpay2       as  char format "x(50)"  init ""  /* ที่อยู่ออกใบเสร็จ */
    FIELD addrpay3       as  char format "x(50)"  init ""  /* ที่อยู่ออกใบเสร็จ */
    FIELD addrpay4       as  char format "x(50)"  init ""  /* ที่อยู่ออกใบเสร็จ */
    FIELD branch         as  CHAR FORMAT "X(20)"  INIT ""   
    FIELD pmentcode      as  CHAR FORMAT "X(10)"  INIT ""        
    FIELD pmenttyp       as  CHAR FORMAT "X(75)"  INIT ""        
    FIELD pmentcode1     as  CHAR FORMAT "X(10)"  INIT ""        
    FIELD pmentcode2     as  CHAR FORMAT "X(75)"  INIT ""        
    FIELD pmentbank      as  CHAR FORMAT "X(50)"  INIT ""  
    FIELD pmentdate      as  CHAR FORMAT "X(15)"  INIT ""        
    FIELD pmentsts       as  CHAR FORMAT "X(15)"  INIT "" 
    field Surchardetail  as  CHAR FORMAT "X(250)" INIT ""
    field acc1           as  CHAR FORMAT "X(100)" INIT ""
    field accdetail1     as  CHAR FORMAT "X(100)" INIT ""
    field accprice1      as  CHAR FORMAT "X(20)"  INIT ""
    field acc2           as  CHAR FORMAT "X(100)" INIT ""
    field accdetail2     as  CHAR FORMAT "X(100)" INIT ""
    field accprice2      as  CHAR FORMAT "X(20)"  INIT ""
    field acc3           as  CHAR FORMAT "X(100)" INIT ""
    field accdetail3     as  CHAR FORMAT "X(100)" INIT ""
    field accprice3      as  CHAR FORMAT "X(20)"  INIT ""
    field acc4           as  CHAR FORMAT "X(100)" INIT ""
    field accdetail4     as  CHAR FORMAT "X(100)" INIT ""
    field accprice4      as  CHAR FORMAT "X(20)"  INIT ""
    field acc5           as  CHAR FORMAT "X(100)" INIT ""
    field accdetail5     as  CHAR FORMAT "X(100)" INIT ""
    field accprice5      as  CHAR FORMAT "X(20)"  INIT ""
    field inspdate       as  CHAR FORMAT "X(15)"  INIT ""
    field inspdate_app   as  CHAR FORMAT "X(50)"  INIT ""
    field inspsts        as  CHAR FORMAT "X(50)"  INIT ""
    field inspdetail     as  CHAR FORMAT "X(250)" INIT ""
    field not_date       as  CHAR FORMAT "X(15)"  INIT ""
    field paydate        as  CHAR FORMAT "X(15)"  INIT ""
    field paysts         as  CHAR FORMAT "X(15)"  INIT ""
    field licenBroker    as  CHAR FORMAT "X(20)"  INIT ""
    field brokname       as  CHAR FORMAT "X(100)" INIT ""
    field brokcode       as  CHAR FORMAT "X(15)"  INIT ""
    field lang           as  CHAR FORMAT "X(50)"  INIT ""
    field deli           as  CHAR FORMAT "X(100)" INIT ""
    field delidetail     as  CHAR FORMAT "X(100)" INIT ""
    field gift           as  CHAR FORMAT "X(100)" INIT ""
    field remark         as  CHAR FORMAT "X(250)" INIT ""
    field inspno         AS  CHAR FORMAT "x(25)" INIT "" 
    field remarkinsp     AS  CHAR FORMAT "x(750)" INIT ""
    field damang1        AS  CHAR FORMAT "x(750)" INIT ""
    field damang2        AS  CHAR FORMAT "x(750)" INIT ""
    field damang3        AS  CHAR FORMAT "x(750)" INIT ""
    field dataoth        AS  CHAR FORMAT "x(750)" INIT ""
    FIELD noti_no        AS  CHAR FORMAT "x(12)"  INIT "" .
    
DEF NEW SHARED TEMP-TABLE wcampaign NO-UNDO 
    FIELD  campno  AS CHAR FORMAT "x(20)"    INIT ""
    FIELD  nclass  AS CHAR FORMAT "x(5)"    INIT ""  
    FIELD  cover   AS CHAR FORMAT "x(3)"    INIT ""  
    FIELD  pack    AS CHAR FORMAT "x(3)"    INIT "" 
    FIELD  bi      AS CHAR FORMAT "x(10)"   INIT ""  
    FIELD  pd1     AS CHAR FORMAT "x(10)"   INIT ""  
    FIELD  pd2     AS CHAR FORMAT "x(10)"   INIT "" 
    FIELD  n41     AS CHAR FORMAT "x(10)"   INIT "" 
    FIELD  n42     AS CHAR FORMAT "x(10)"   INIT ""  
    FIELD  n43     AS CHAR FORMAT "x(10)"   INIT ""  
    FIELD  FI      AS CHAR FORMAT "x(25)"    INIT ""
    FIELD  garage  AS CHAR FORMAT "x(2)"    INIT ""  
    FIELD  tariff  AS CHAR FORMAT "X(2)"  INIT "".


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
/*DEFINE VAR n_sclass72  AS CHAR FORMAT "x(4)". */ /*A67-0204*/  
DEFINE VAR n_sclass72  AS CHAR FORMAT "x(5)". /*A67-0204*/ 
/*def var s_riskgp    AS INTE FORMAT ">9".                                                         
def var s_riskno    AS INTE FORMAT "999".                                                        
def var s_itemno    AS INTE FORMAT "999".*/                                                        
DEF VAR nv_comper  AS DECI INIT 0.                    
DEF VAR nv_comacc  AS DECI INIT 0. 
/*def var  s_recid1       as RECID .     /* uwm100  */                    
def var  s_recid2       as recid .     /* uwm120  */                    
def var  s_recid3       as recid .
def var  s_recid4       as recid .*/
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
def var nv_chk as  logic.
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
def var n_curbil    LIKE  sicuw.uwm100.curbil  NO-UNDO.            
def var nv_dept     as char format  "X(1)".
DEF  var  nv_row  as  int  init  0. 
DEFINE STREAM  ns1.                                        
DEFINE STREAM  ns2.                                         
DEFINE STREAM  ns3.  
DEF  VAR gv_id AS CHAR FORMAT "X(8)" NO-UNDO. 
/*DEF VAR nv_pwd AS CHAR NO-UNDO. */  /*A60-0405*/
DEF VAR nv_pwd AS CHAR FORMAT "x(15)" NO-UNDO.   /*A60-0405*/
DEF VAR nv_drivage1 AS INTE INIT 0.                                
DEF VAR nv_drivage2 AS INTE INIT 0.  
DEF VAR nv_bptr     AS RECID.                           
DEF VAR nv_nptr     AS RECID.  
DEFINE VAR nv_line1   AS INTEGER   INITIAL 0            NO-UNDO.                                 
def var nv_undyr    as    char  init  ""    format   "X(4)". 
DEFINE  WORKFILE wuppertxt3 NO-UNDO                                                             
 /*1*/  FIELD line     AS INTEGER   FORMAT ">>9"                                                
 /*2*/  FIELD txt      AS CHARACTER FORMAT "X(200)"   INITIAL "".  
DEFINE  WORKFILE wuppertxt NO-UNDO                                                             
 /*1*/  FIELD line     AS INTEGER   FORMAT ">>9"                                                
 /*2*/  FIELD txt      AS CHARACTER FORMAT "X(200)"   INITIAL "".    
DEF VAR nv_lnumber AS   INTE INIT 0.
DEF  VAR n_41   AS DECI     FORMAT ">,>>>,>>9.99" INIT 0.
DEF  VAR n_42   AS DECI     FORMAT ">,>>>,>>9.99" INIT 0.
DEF  VAR n_43   AS DECI     FORMAT ">,>>>,>>9.99" INIT 0.
DEF VAR dod1       AS DECI.
DEF VAR dod2       AS DECI.
DEF VAR dpd0       AS DECI.
DEF VAR dod0       AS DECI.
DEF VAR n_firstdat AS CHAR FORMAT "x(10)"  INIT "".
DEF VAR nv_dscom   AS DECI INIT      0 .
/*add A55-0325 */
DEFINE VAR nv_insref   AS CHARACTER FORMAT "X(10)".          
DEFINE VAR n_insref    AS CHARACTER FORMAT "X(10)".  
DEF VAR nv_usrid    AS CHARACTER FORMAT "X(08)".             
DEF VAR nv_transfer AS LOGICAL   .                            
DEF VAR n_check     AS CHARACTER .                            
DEF VAR nv_typ      AS CHAR FORMAT "X(2)".    
/*add A55-0325 */
DEFINE VAR  nv_driver    AS CHARACTER FORMAT "X(23)" INITIAL ""  .
DEFINE VAR  np_driver    AS CHAR      FORMAT "x(23)" INIT "".
DEFINE NEW SHARED WORKFILE ws0m009 NO-UNDO
/*1*/  FIELD policy     AS CHARACTER    INITIAL ""  
/*2*/  FIELD lnumber    AS INTEGER   
       FIELD ltext      AS CHARACTER    INITIAL "" 
       FIELD ltext2     AS CHARACTER    INITIAL "" 
     /* add by : A67-0162 */ 
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
       /* end A67-01214 */ 

DEFINE NEW SHARED WORKFILE wuwd132
    FIELD prepol  AS CHAR FORMAT "x(20)" INIT ""
    FIELD bencod  AS CHAR FORMAT "x(30)" INIT "" 
    FIELD benvar  AS CHAR FORMAT "x(40)" INIT "" 
    FIELD gap_c   AS DECI FORMAT ">>>,>>>,>>9.99-"    
    FIELD prem_c  AS DECI FORMAT ">>>,>>>,>>9.99-"  . 

DEF NEW SHARED VAR nr_premtxt      AS CHAR FORMAT "x(100)" INIT "".
DEF NEW SHARED VAR n_poltyp         AS CHAR FORMAT "x(5)" INIT ""    .
DEF NEW SHARED VAR n_bray           AS CHAR FORMAT "x(2)" INIT "" .
DEF NEW SHARED VAR n_account_no     as  CHAR FORMAT "X(20)"  INIT "" .
DEF NEW SHARED VAR n_inscode        as  CHAR FORMAT "X(20)"  INIT "" .
DEF NEW SHARED VAR n_campcode       as  CHAR FORMAT "X(20)"  INIT "" .      
DEF NEW SHARED VAR n_campname       as  CHAR FORMAT "X(35)"  INIT "" .      
DEF NEW SHARED VAR n_procode        as  CHAR FORMAT "X(20)"  INIT "" .      
DEF NEW SHARED VAR n_proname        as  CHAR FORMAT "X(35)"  INIT "" .      
DEF NEW SHARED VAR n_packname       as  CHAR FORMAT "X(35)"  INIT "" .      
DEF NEW SHARED VAR n_packcode       as  CHAR FORMAT "X(20)"  INIT "" .      
DEF NEW SHARED VAR n_instype        as  CHAR FORMAT "X(1)"   INIT "" .      
DEF NEW SHARED VAR n_tiname         as  CHAR FORMAT "X(20)"  INIT "" .      
DEF NEW SHARED VAR n_insnam         as  CHAR FORMAT "X(100)" INIT "" .      
DEF NEW SHARED VAR n_title_eng      as  CHAR FORMAT "X(10)"  INIT "" .      
DEF NEW SHARED VAR n_insname_eng    as  CHAR FORMAT "X(100)" INIT "" .      
DEF NEW SHARED VAR n_icno           as  CHAR FORMAT "X(13)"  INIT "" .
DEF NEW SHARED VAR n_bdate          as  CHAR FORMAT "X(15)"  INIT "" .      
DEF NEW SHARED VAR n_occup          as  CHAR FORMAT "X(50)"  INIT "" .      
DEF NEW SHARED VAR n_tel            as  CHAR FORMAT "X(50)"  INIT "" .      
DEF NEW SHARED VAR n_mail           as  CHAR FORMAT "X(50)"  INIT "" .      
DEF NEW SHARED VAR n_addrpol1       as  CHAR FORMAT "X(40)"  INIT "" .      
DEF NEW SHARED VAR n_addrpol2       as  CHAR FORMAT "X(40)"  INIT "" .      
DEF NEW SHARED VAR n_addrpol3       as  CHAR FORMAT "X(40)"  INIT "" .      
DEF NEW SHARED VAR n_addrpol4       as  CHAR FORMAT "X(40)"  INIT "" .      
DEF NEW SHARED VAR n_addrsend1      as  CHAR FORMAT "X(45)"  INIT "" .      
DEF NEW SHARED VAR n_addrsend2      as  CHAR FORMAT "X(45)"  INIT "" .      
DEF NEW SHARED VAR n_addrsend3      as  CHAR FORMAT "X(45)"  INIT "" .      
DEF NEW SHARED VAR n_addrsend4      as  CHAR FORMAT "X(45)"  INIT "" .      
DEF NEW SHARED VAR n_paytype        as  CHAR FORMAT "X(2)"   INIT "" .      
DEF NEW SHARED VAR n_paytitle       as  CHAR FORMAT "X(20)"  INIT "" .      
DEF NEW SHARED VAR n_payname        as  CHAR FORMAT "X(100)" INIT "" .
DEF NEW SHARED VAR n_payic          AS  CHAR FORMAT "x(13)" INIT "" .
DEF NEW SHARED VAR n_addrpay1       as  CHAR FORMAT "X(45)"  INIT "" .      
DEF NEW SHARED VAR n_addrpay2       as  CHAR FORMAT "X(45)"  INIT "" .      
DEF NEW SHARED VAR n_addrpay3       as  CHAR FORMAT "X(45)"  INIT "" .      
DEF NEW SHARED VAR n_addrpay4       as  CHAR FORMAT "X(45)"  INIT "" . 
DEF NEW SHARED VAR n_branch         as  CHAR FORMAT "X(20)"  INIT "" .      
DEF NEW SHARED VAR n_ben_name       as  CHAR FORMAT "X(100)" INIT "" .      
DEF NEW SHARED VAR n_pmentcode      as  CHAR FORMAT "X(10)"  INIT "" .      
DEF NEW SHARED VAR n_pmenttyp       as  CHAR FORMAT "X(75)"  INIT "" .      
DEF NEW SHARED VAR n_pmentcode1     as  CHAR FORMAT "X(10)"  INIT "" .      
DEF NEW SHARED VAR n_pmentcode2     as  CHAR FORMAT "X(75)"  INIT "" .      
DEF NEW SHARED VAR n_pmentbank      as  CHAR FORMAT "X(50)"  INIT "" .
DEF NEW SHARED VAR n_pmentdate      as  CHAR FORMAT "X(15)"  INIT "" .      
DEF NEW SHARED VAR n_pmentsts       as  CHAR FORMAT "X(15)"  INIT "" .      
DEF NEW SHARED VAR n_brand          as  char format "x(35)"  init "" .
DEF NEW SHARED VAR n_Model          as  char format "x(50)"  init "" .
DEF NEW SHARED VAR n_body           as  char format "x(20)"  init "" .
DEF NEW SHARED VAR n_vehreg         as  char format "x(11)"  init "" .
DEF NEW SHARED VAR n_re_country     as  char format "x(25)"  init "" .
DEF NEW SHARED VAR n_chasno         as  char format "x(50)"  init "" .
DEF NEW SHARED VAR n_eng            as  char format "x(50)"  init "" .
DEF NEW SHARED VAR n_caryear        as  char format "x(5)"   init "" .
DEF NEW SHARED VAR n_seate          as  char format "x(5)"   init "" .
DEF NEW SHARED VAR n_engcc          as  CHAR FORMAT "x(15)"  INIT "" .
DEF NEW SHARED VAR n_power          as  CHAR FORMAT "X(15)"  INIT "" .
DEF NEW SHARED VAR n_class          as  char format "x(5)"   init "" .                                      
DEF NEW SHARED VAR n_garage         as  char format "x(35)"  init "" .
DEF NEW SHARED VAR n_colorcode      as  char format "x(35)"  init "" .
DEF NEW SHARED VAR n_covcod         as  char format "x(50)"  init "" .
DEF NEW SHARED VAR n_covtyp         as  char format "x(30)"  init "" .
DEF NEW SHARED VAR n_comdat         as  char format "x(15)"  init "" .
DEF NEW SHARED VAR n_expdat         as  char format "x(15)"  init "" .
DEF NEW SHARED VAR n_si             as  CHAR FORMAT "x(20)"  INIT "" .
DEF NEW SHARED VAR n_prem1          as  char format "x(20)"  init "" .
DEF NEW SHARED VAR n_gross_prm      as  char format "x(20)"  init "" .
DEF NEW SHARED VAR n_stamp          as  CHAR FORMAT "x(10)"  INIT "" .
DEF NEW SHARED VAR n_vat            as  CHAR FORMAT "X(10)"  INIT "" .
DEF NEW SHARED VAR n_premtotal      as  CHAR FORMAT "x(20)"  INIT "" .
DEF NEW SHARED VAR n_deduct         as  char format "x(10)"  init "" .
DEF NEW SHARED VAR n_fleetper       as  char format "x(10)"  init "" .
DEF NEW SHARED VAR n_ncb            as  char format "x(10)"  init "" .
DEF NEW SHARED VAR n_drivper        as  char format "x(10)"  init "" .
DEF NEW SHARED VAR n_othper         as  char format "X(10)"  INIT "" .
DEF NEW SHARED VAR n_cctvper        as  char format "X(10)"  INIT "" .
DEF NEW SHARED VAR n_Surcharper     as  CHAR FORMAT "x(10)"  INIT "" .
DEF NEW SHARED VAR n_Surchardetail  as  CHAR FORMAT "X(250)" INIT "" .
DEF NEW SHARED VAR n_driver         as  CHAR FORMAT "X(2)"   INIT "" .      
DEF NEW SHARED VAR n_drivnam1       as  CHAR FORMAT "X(70)"  INIT "" .
DEF NEW SHARED VAR n_driveno1       as  CHAR FORMAT "X(15)"  INIT "" .      
DEF NEW SHARED VAR n_occupdri1      as  CHAR FORMAT "X(50)"  INIT "" .      
DEF NEW SHARED VAR n_sexdriv1       as  CHAR FORMAT "X(10)"  INIT "" .      
DEF NEW SHARED VAR n_bdatedri1      as  CHAR FORMAT "X(15)"  INIT "" .      
DEF NEW SHARED VAR n_drivnam2       as  CHAR FORMAT "x(70)"  INIT "" .
DEF NEW SHARED VAR n_driveno2       as  char format "x(15)"  init "" .      
DEF NEW SHARED VAR n_occupdri2      as  char format "x(50)"  init "" .      
DEF NEW SHARED VAR n_sexdriv2       as  char format "x(10)"  init "" .      
DEF NEW SHARED VAR n_bdatedri2      as  char format "x(15)"  init "" . 
DEF NEW SHARED VAR n_acc1           as  CHAR FORMAT "X(100)" INIT "" .
DEF NEW SHARED VAR n_accdetail1     as  CHAR FORMAT "X(100)" INIT "" .
DEF NEW SHARED VAR n_accprice1      as  CHAR FORMAT "X(20)"  INIT "" .
DEF NEW SHARED VAR n_acc2           as  CHAR FORMAT "X(100)" INIT "" .
DEF NEW SHARED VAR n_accdetail2     as  CHAR FORMAT "X(100)" INIT "" .
DEF NEW SHARED VAR n_accprice2      as  CHAR FORMAT "X(20)"  INIT "" .
DEF NEW SHARED VAR n_acc3           as  CHAR FORMAT "X(100)" INIT "" .
DEF NEW SHARED VAR n_accdetail3     as  CHAR FORMAT "X(100)" INIT "" .
DEF NEW SHARED VAR n_accprice3      as  CHAR FORMAT "X(20)"  INIT "" .
DEF NEW SHARED VAR n_acc4           as  CHAR FORMAT "X(100)" INIT "" .
DEF NEW SHARED VAR n_accdetail4     as  CHAR FORMAT "X(100)" INIT "" .
DEF NEW SHARED VAR n_accprice4      as  CHAR FORMAT "X(20)"  INIT "" .
DEF NEW SHARED VAR n_acc5           as  CHAR FORMAT "X(100)" INIT "" .
DEF NEW SHARED VAR n_accdetail5     as  CHAR FORMAT "X(100)" INIT "" .
DEF NEW SHARED VAR n_accprice5      as  CHAR FORMAT "X(20)"  INIT "" .
DEF NEW SHARED VAR n_inspdate       as  CHAR FORMAT "X(15)"  INIT "" .
DEF NEW SHARED VAR n_inspdate_app   as  CHAR FORMAT "X(50)"  INIT "" .
DEF NEW SHARED VAR n_inspsts        as  CHAR FORMAT "X(50)"  INIT "" .
DEF NEW SHARED VAR n_inspdetail     as  CHAR FORMAT "X(250)" INIT "" .
DEF NEW SHARED VAR n_not_date       as  CHAR FORMAT "X(15)"  INIT "" .
DEF NEW SHARED VAR n_paydate        as  CHAR FORMAT "X(15)"  INIT "" .
DEF NEW SHARED VAR n_paysts         as  CHAR FORMAT "X(15)"  INIT "" .
DEF NEW SHARED VAR n_licenBroker    as  CHAR FORMAT "X(20)"  INIT "" .
DEF NEW SHARED VAR n_brokname       as  CHAR FORMAT "X(100)" INIT "" .
DEF NEW SHARED VAR n_brokcode       as  CHAR FORMAT "X(15)"  INIT "" .
DEF NEW SHARED VAR n_lang           as  CHAR FORMAT "X(50)"  INIT "" .
DEF NEW SHARED VAR n_deli           as  CHAR FORMAT "X(100)" INIT "" .
DEF NEW SHARED VAR n_delidetail     as  CHAR FORMAT "X(100)" INIT "" .
DEF NEW SHARED VAR n_gift           as  CHAR FORMAT "X(100)" INIT "" .
DEF NEW SHARED VAR n_remark         as  CHAR FORMAT "X(250)" INIT "" .
DEF NEW SHARED VAR n_inspno         AS  CHAR FORMAT "x(25)" INIT "" .
DEF NEW SHARED VAR n_remarkinsp     AS  CHAR FORMAT "x(750)" INIT "".
DEF NEW SHARED VAR n_damang1        AS  CHAR FORMAT "x(750)" INIT "".
DEF NEW SHARED VAR n_damang2        AS  CHAR FORMAT "x(750)" INIT "".
DEF NEW SHARED VAR n_damang3        AS  CHAR FORMAT "x(750)" INIT "".
DEF NEW SHARED VAR n_dataoth        AS  CHAR FORMAT "x(750)" INIT "".
DEF NEW SHARED VAR n_policy         AS  CHAR FORMAT "x(13)" INIT "" .
DEF NEW SHARED VAR n_hobr           AS  CHAR FORMAT "x(2)" INIT "" .
DEF NEW SHARED VAR n_producer       AS  CHAR FORMAT "x(10)" INIT "" .
DEF NEW SHARED VAR n_agent          AS  CHAR FORMAT "x(10)" INIT "" .
DEF NEW SHARED VAR n_remark2        AS CHAR  FORMAT "x(150)" INIT "" . 
DEF NEW SHARED VAR n_contract       AS CHAR FORMAT "x(10)" INIT "" .  
DEF NEW SHARED VAR n_fi             AS CHAR FORMAT "x(15)" INIT "" .

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
DEFINE NEW  SHARED VAR   nv_pdprm0      AS DECI     FORMAT ">>,>>>,>>9.99-".


DEFINE new SHARED VAR   s_recid1   AS RECID.  /* NO-UNDO.*/   /* uwm100 */
DEFINE new SHARED VAR   s_recid2   AS RECID.  /* NO-UNDO.*/   /* uwm120 */
DEFINE new SHARED VAR   s_recid3   AS RECID.  /* NO-UNDO.*/   /* uwm130 */
DEFINE new SHARED VAR   s_recid4   AS RECID.  /* NO-UNDO.*/   /* uwm301 */
DEFINE          VAR   nv_si00_p   AS INTEGER FORMAT ">,>>>,>>>,>>9".
DEFINE new  SHARED VAR   s_riskgp   AS INTE FORMAT ">9".
DEFINE new  SHARED VAR   s_riskno   AS INTE FORMAT "999".
DEFINE new  SHARED VAR   s_itemno   AS INTE FORMAT "999".
/*DEFINE   SHARED VAR   nv_polday  AS INTE FORMAT ">>9".*/
/*
DEFINE   SHARED VAR   nv_compcod AS CHAR   FORMAT "X(4)".
DEFINE   SHARED VAR   nv_compprm AS DECI   FORMAT ">>>,>>9.99-".
DEFINE   SHARED VAR   nv_compvar1 AS CHAR  FORMAT "X(30)".
DEFINE   SHARED VAR   nv_compvar2 AS CHAR  FORMAT "X(30)".
DEFINE   SHARED VAR   nv_compvar  AS CHAR  FORMAT "X(60)".

DEFINE   SHARED VAR   nv_basecod AS CHAR  FORMAT "X(4)".
DEFINE   SHARED VAR   nv_baseprm AS DECI  FORMAT ">>,>>>,>>9.99-".
DEFINE   SHARED VAR   nv_baseprm2 AS DECI  FORMAT ">>,>>>,>>9.99-".
DEFINE   SHARED VAR   nv_basevar1 AS CHAR  FORMAT "X(30)".
DEFINE   SHARED VAR   nv_basevar2 AS CHAR  FORMAT "X(30)".
DEFINE   SHARED VAR   nv_basevar  AS CHAR  FORMAT "X(60)".

DEFINE   SHARED VAR   nv_usecod   AS CHARACTER FORMAT "X(4)".
DEFINE   SHARED VAR   nv_useprm   AS DECI  FORMAT ">>,>>>,>>9.99-".
DEFINE   SHARED VAR   nv_usevar1  AS CHAR  FORMAT "X(30)".
DEFINE   SHARED VAR   nv_usevar2  AS CHAR  FORMAT "X(30)".
DEFINE   SHARED VAR   nv_usevar   AS CHAR  FORMAT "X(60)".

DEFINE   SHARED VAR   nv_grpcod  AS CHARACTER FORMAT "X(4)".
DEFINE   SHARED VAR   nv_grprm   AS DECI  FORMAT ">>,>>>,>>9.99-".
DEFINE   SHARED VAR   nv_grpvar1 AS CHAR  FORMAT "X(30)".
DEFINE   SHARED VAR   nv_grpvar2 AS CHAR  FORMAT "X(30)".
DEFINE   SHARED VAR   nv_grpvar  AS CHAR  FORMAT "X(60)".

DEFINE   SHARED VAR   nv_yrcod   AS CHARACTER FORMAT "X(4)".
DEFINE   SHARED VAR   nv_yrprm   AS DECI  FORMAT ">>,>>>,>>9.99-".
DEFINE   SHARED VAR   nv_yrvar1  AS CHAR  FORMAT "X(30)".
DEFINE   SHARED VAR   nv_yrvar2  AS CHAR  FORMAT "X(30)".
DEFINE   SHARED VAR   nv_yrvar   AS CHAR  FORMAT "X(60)".

DEFINE   SHARED VAR   nv_sicod   AS CHARACTER FORMAT "X(4)".
DEFINE   SHARED VAR   nv_siprm   AS DECI  FORMAT ">>,>>>,>>9.99-".
DEFINE   SHARED VAR   nv_sivar1  AS CHAR  FORMAT "X(30)".
DEFINE   SHARED VAR   nv_sivar2  AS CHAR  FORMAT "X(30)".
DEFINE   SHARED VAR   nv_sivar   AS CHAR  FORMAT "X(60)".*/

DEFINE new  SHARED VAR   nv_totlcod  AS CHAR  FORMAT "X(4)".
DEFINE new  SHARED VAR   nv_totlprm  AS DECI  FORMAT ">>,>>>,>>9.99-".
DEFINE new  SHARED VAR   nv_totlvar1 AS CHAR  FORMAT "X(30)".
DEFINE new  SHARED VAR   nv_totlvar2 AS CHAR  FORMAT "X(30)".
DEFINE new  SHARED VAR   nv_totlvar  AS CHAR  FORMAT "X(60)".

/*
DEFINE   SHARED VAR   nv_othcod  AS CHARACTER  FORMAT "X(4)".
DEFINE   SHARED VAR   nv_othprm  AS DECI  FORMAT ">>,>>>,>>9.99-".
DEFINE   SHARED VAR   nv_othvar1 AS CHAR  FORMAT "X(30)".
DEFINE   SHARED VAR   nv_othvar2 AS CHAR  FORMAT "X(30)".
DEFINE   SHARED VAR   nv_othvar  AS CHAR  FORMAT "X(60)".

DEFINE   SHARED VAR   nv_engcod  AS CHARACTER FORMAT "X(4)".
DEFINE   SHARED VAR   nv_engprm  AS DECI  FORMAT ">>,>>>,>>9.99-".
DEFINE   SHARED VAR   nv_engvar1 AS CHAR  FORMAT "X(30)".
DEFINE   SHARED VAR   nv_engvar2 AS CHAR  FORMAT "X(30)".
DEFINE   SHARED VAR   nv_engvar  AS CHAR  FORMAT "X(60)".

DEFINE   SHARED VAR   nv_drivcod AS CHARACTER FORMAT "X(4)".
DEFINE   SHARED VAR   nv_drivprm AS DECI  FORMAT ">>,>>>,>>9.99-".
DEFINE   SHARED VAR   nv_drivvar1 AS CHAR  FORMAT "X(30)".
DEFINE   SHARED VAR   nv_drivvar2 AS CHAR  FORMAT "X(30)".
DEFINE   SHARED VAR   nv_drivvar  AS CHAR  FORMAT "X(60)".

DEFINE   SHARED VAR   nv_bipcod  AS CHARACTER FORMAT "X(4)".
DEFINE   SHARED VAR   nv_bipprm  AS DECI  FORMAT ">>,>>>,>>9.99-".
DEFINE   SHARED VAR   nv_bipvar1 AS CHAR  FORMAT "X(30)".
DEFINE   SHARED VAR   nv_bipvar2 AS CHAR  FORMAT "X(30)".
DEFINE   SHARED VAR   nv_bipvar  AS CHAR  FORMAT "X(60)".

DEFINE   SHARED VAR   nv_biacod   AS CHARACTER FORMAT "X(4)".
DEFINE   SHARED VAR   nv_biaprm   AS DECI  FORMAT ">>,>>>,>>9.99-".
DEFINE   SHARED VAR   nv_biavar1  AS CHAR  FORMAT "X(30)".
DEFINE   SHARED VAR   nv_biavar2  AS CHAR  FORMAT "X(30)".
DEFINE   SHARED VAR   nv_biavar   AS CHAR  FORMAT "X(60)".

DEFINE   SHARED VAR   nv_pdacod   AS CHARACTER FORMAT "X(4)".
DEFINE   SHARED VAR   nv_pdaprm   AS DECI  FORMAT ">>,>>>,>>9.99-".
DEFINE   SHARED VAR   nv_pdavar1  AS CHAR  FORMAT "X(30)".
DEFINE   SHARED VAR   nv_pdavar2  AS CHAR  FORMAT "X(30)".
DEFINE   SHARED VAR   nv_pdavar   AS CHAR  FORMAT "X(60)".

DEFINE   SHARED VAR   nv_41cod1   AS CHARACTER FORMAT "X(4)".
DEFINE   SHARED VAR   nv_41cod2   AS CHARACTER FORMAT "X(4)".
DEFINE   SHARED VAR   nv_41       AS INTEGER   FORMAT ">>>,>>>,>>9".
/*DEFINE   SHARED VAR   nv_seat41   AS INTEGER   FORMAT ">>9".*/
DEFINE   SHARED VAR   nv_411prm   AS DECI      FORMAT ">,>>>,>>9.99".
DEFINE   SHARED VAR   nv_412prm   AS DECI      FORMAT ">,>>>,>>9.99".
DEFINE   SHARED VAR   nv_411var1  AS CHAR  FORMAT "X(30)".
DEFINE   SHARED VAR   nv_411var2  AS CHAR  FORMAT "X(30)".
DEFINE   SHARED VAR   nv_411var   AS CHAR  FORMAT "X(60)".

DEFINE   SHARED VAR   nv_412var1  AS CHAR  FORMAT "X(30)".
DEFINE   SHARED VAR   nv_412var2  AS CHAR  FORMAT "X(30)".
DEFINE   SHARED VAR   nv_412var   AS CHAR  FORMAT "X(60)".

DEFINE   SHARED VAR   nv_42cod    AS CHARACTER FORMAT "X(4)".
DEFINE   SHARED VAR   nv_42       AS INTEGER   FORMAT ">>>,>>>,>>9".
DEFINE   SHARED VAR   nv_42prm    AS DECI      FORMAT ">,>>>,>>9.99".
DEFINE   SHARED VAR   nv_42var1   AS CHAR  FORMAT "X(30)".
DEFINE   SHARED VAR   nv_42var2   AS CHAR  FORMAT "X(30)".
DEFINE   SHARED VAR   nv_42var    AS CHAR  FORMAT "X(60)".

DEFINE   SHARED VAR   nv_43cod    AS CHARACTER FORMAT "X(4)".
DEFINE   SHARED VAR   nv_43       AS INTEGER   FORMAT ">>>,>>>,>>9".
DEFINE   SHARED VAR   nv_43prm    AS DECI      FORMAT ">,>>>,>>9.99".
DEFINE   SHARED VAR   nv_43var1   AS CHAR  FORMAT "X(30)".
DEFINE   SHARED VAR   nv_43var2   AS CHAR  FORMAT "X(30)".
DEFINE   SHARED VAR   nv_43var    AS CHAR  FORMAT "X(60)".

DEFINE   SHARED VAR   nv_dedod1_cod AS CHAR  FORMAT "X(4)".
DEFINE   SHARED VAR   nv_dedod1_prm AS DECI  FORMAT ">,>>>,>>9.99-".
DEFINE   SHARED VAR   nv_dedod1var1 AS CHAR  FORMAT "X(30)".
DEFINE   SHARED VAR   nv_dedod1var2 AS CHAR  FORMAT "X(30)".
DEFINE   SHARED VAR   nv_dedod1var  AS CHAR  FORMAT "X(60)".

DEFINE   SHARED VAR   nv_dedod2_cod AS CHAR  FORMAT "X(4)".
DEFINE   SHARED VAR   nv_dedod2_prm AS DECI  FORMAT ">,>>>,>>9.99-".
DEFINE   SHARED VAR   nv_dedod2var1 AS CHAR  FORMAT "X(30)".
DEFINE   SHARED VAR   nv_dedod2var2 AS CHAR  FORMAT "X(30)".
DEFINE   SHARED VAR   nv_dedod2var  AS CHAR  FORMAT "X(60)".

DEFINE   SHARED VAR   nv_dedpd_cod  AS CHAR  FORMAT "X(4)".
DEFINE   SHARED VAR   nv_dedpd_prm  AS DECI  FORMAT ">,>>>,>>9.99-".
DEFINE   SHARED VAR   nv_dedpdvar1  AS CHAR  FORMAT "X(30)".
DEFINE   SHARED VAR   nv_dedpdvar2  AS CHAR  FORMAT "X(30)".
DEFINE   SHARED VAR   nv_dedpdvar   AS CHAR  FORMAT "X(60)".

DEFINE   SHARED VAR   nv_flet_cod AS CHAR    FORMAT "X(4)".
DEFINE   SHARED VAR   nv_flet_per AS DECIMAL FORMAT ">>9".
DEFINE   SHARED VAR   nv_flet     AS DECI  FORMAT ">>,>>>,>>9.99-".
DEFINE          VAR   nv_flet2     AS DECI  FORMAT ">>,>>>,>>9.99-".  /*Kridtiya  I.  A51-0198*/
DEFINE   SHARED VAR   nv_fletvar1 AS CHAR  FORMAT "X(30)".
DEFINE   SHARED VAR   nv_fletvar2 AS CHAR  FORMAT "X(30)".
DEFINE   SHARED VAR   nv_fletvar  AS CHAR  FORMAT "X(60)".

DEFINE   SHARED VAR   nv_ncb_cod  AS CHAR  FORMAT "X(4)".
DEFINE   SHARED VAR   nv_ncbper   LIKE sic_bran.uwm301.ncbper.
DEFINE   SHARED VAR   nv_ncb      AS DECI  FORMAT ">>,>>>,>>9.99-".
DEFINE          VAR   nv_ncb2      AS DECI  FORMAT ">>,>>>,>>9.99-".   /*Kridtiya  I.  A51-0198*/
DEFINE   SHARED VAR   nv_ncbvar1  AS CHAR  FORMAT "X(30)".
DEFINE   SHARED VAR   nv_ncbvar2  AS CHAR  FORMAT "X(30)".
DEFINE   SHARED VAR   nv_ncbvar   AS CHAR  FORMAT "X(60)".

DEFINE   SHARED VAR   nv_dss_cod  AS CHAR      FORMAT "X(4)".
DEFINE   SHARED VAR   nv_dss_per  AS DECIMAL   FORMAT ">9.99".
DEFINE   SHARED VAR   nv_dsspc    AS INTEGER   FORMAT ">>>,>>9.99-".
DEFINE          VAR   nv_dsspc2    AS INTEGER   FORMAT ">>>,>>9.99-".   /*Kridtiya  I.  A51-0198*/
DEFINE   SHARED VAR   nv_dsspcvar1 AS CHAR  FORMAT "X(30)".
DEFINE   SHARED VAR   nv_dsspcvar2 AS CHAR  FORMAT "X(30)".
DEFINE   SHARED VAR   nv_dsspcvar  AS CHAR  FORMAT "X(60)".

DEFINE   SHARED VAR   nv_stf_cod  AS CHAR      FORMAT "X(4)".
DEFINE   SHARED VAR   nv_stf_per  AS DECIMAL   FORMAT ">9.99".
DEFINE   SHARED VAR   nv_stf_amt  AS INTEGER   FORMAT ">>>,>>9.99-".
DEFINE          VAR   nv_stf_amt2  AS INTEGER   FORMAT ">>>,>>9.99-".     /*Kridtiya  I.  A51-0198*/
DEFINE   SHARED VAR   nv_stfvar1  AS CHAR  FORMAT "X(30)".
DEFINE   SHARED VAR   nv_stfvar2  AS CHAR  FORMAT "X(30)".
DEFINE   SHARED VAR   nv_stfvar   AS CHAR  FORMAT "X(60)".

DEFINE   SHARED VAR   nv_cl_cod   AS CHAR      FORMAT "X(4)".
DEFINE   SHARED VAR   nv_cl_per   AS DECIMAL   FORMAT ">9.99".
DEFINE   SHARED VAR   nv_lodclm   AS INTEGER   FORMAT ">>>,>>9.99-".
DEFINE          VAR   nv_lodclm1  AS INTEGER   FORMAT ">>>,>>9.99-".
DEFINE          VAR   nv_lodclm2   AS INTEGER   FORMAT ">>>,>>9.99-".      /*Kridtiya  I.  A51-0198*/
DEFINE          VAR   nv_lodclm12  AS INTEGER   FORMAT ">>>,>>9.99-".
DEFINE   SHARED VAR   nv_clmvar1  AS CHAR  FORMAT "X(30)".
DEFINE   SHARED VAR   nv_clmvar2  AS CHAR  FORMAT "X(30)".
DEFINE   SHARED VAR   nv_clmvar   AS CHAR  FORMAT "X(60)".


DEFINE   SHARED VAR   nv_campcod AS CHAR   FORMAT "X(4)".
DEFINE   SHARED VAR   nv_camprem AS DECI   FORMAT ">>>9".
DEFINE   SHARED VAR   nv_campvar1 AS CHAR  FORMAT "X(30)".
DEFINE   SHARED VAR   nv_campvar2 AS CHAR  FORMAT "X(30)".
DEFINE   SHARED VAR   nv_campvar  AS CHAR  FORMAT "X(60)".

/*DEFINE   SHARED VAR   nv_gapprm  AS DECI  FORMAT ">>,>>>,>>9.99-"  INITIAL 0  NO-UNDO.*/
/*DEFINE   SHARED VAR   nv_pdprm   AS DECI  FORMAT ">>,>>>,>>9.99-"  INITIAL 0  NO-UNDO.*/
DEFINE          VAR   nv_gapprm2  AS DECI  FORMAT ">>,>>>,>>9.99-"  INITIAL 0  NO-UNDO.   /*Kridtiya  I.  A51-0198*/
DEFINE          VAR   nv_pdprm2   AS DECI  FORMAT ">>,>>>,>>9.99-"  INITIAL 0  NO-UNDO.   /*Kridtiya  I.  A51-0198*/

DEFINE   SHARED VAR   nv_engine LIKE sicsyac.xmm102.engine.
DEFINE   SHARED VAR   nv_tons   LIKE sicsyac.xmm102.tons.
DEFINE   SHARED VAR   nv_seats  LIKE sicsyac.xmm102.seats.

/*DEFINE   SHARED VAR   nv_prvprm     AS DECI  FORMAT ">>,>>>,>>9.99-".*/

DEFINE   SHARED VAR   nv_sclass     AS CHAR FORMAT "X(3)".

DEFINE   SHARED VAR   nv_newrec     AS LOGICAL.
DEFINE   SHARED VAR   nv_yrold      LIKE sic_bran.uwm301.yrmanu.

/*--------nee 06/01/00----------*/
/*DEFINE   SHARED VAR   nv_41prm      AS INTEGER   FORMAT ">,>>>,>>9"  INITIAL 0 no-undo.*/

/*DEFINE  SHARED VAR   nv_ded1prm    AS INTEGER   FORMAT ">>>,>>9-"       INITIAL 0  NO-UNDO. */
/*DEFINE  SHARED VAR   nv_aded1prm   AS INTEGER   FORMAT ">>>,>>9-"       INITIAL 0  NO-UNDO. */
/*DEFINE  SHARED VAR   nv_ded2prm    AS INTEGER   FORMAT ">>>,>>9-"       INITIAL 0  NO-UNDO. */
/*DEFINE  SHARED VAR   nv_dedod      AS INTEGER   FORMAT ">>,>>>,>>9"     INITIAL 0  NO-UNDO. */
/*DEFINE  SHARED VAR   nv_addod      AS INTEGER   FORMAT ">>,>>>,>>9"     INITIAL 0  NO-UNDO. */
/*DEFINE  SHARED VAR   nv_dedpd      AS INTEGER   FORMAT ">>,>>>,>>9"     INITIAL 0  NO-UNDO. */
/*DEFINE  SHARED VAR   nv_prem1      AS DECIMAL   FORMAT ">,>>>,>>9.99-"  INITIAL 0  NO-UNDO. */
/*DEFINE  SHARED VAR   nv_addprm     AS INTEGER   FORMAT ">>>,>>>,>>9"    INITIAL 0  NO-UNDO. */     /*--- A59-0095 ---*/
/*DEFINE  SHARED VAR nv_totded       AS INTEGER   FORMAT ">>,>>>,>>9-"    INITIAL 0  NO-UNDO. */
/*DEFINE  SHARED VAR nv_totdis       AS INTEGER   FORMAT ">>,>>>,>>9-"    INITIAL 0  NO-UNDO. */
DEFINE          VAR nv_totdis2       AS INTEGER   FORMAT ">>,>>>,>>9-"  INITIAL 0  NO-UNDO.      /*Kridtiya  I.  A51-0198*/
/*--------nee 06/01/00----------*/
DEFINE          VAR   nv_prem_p0      AS DECIMAL   FORMAT ">,>>>,>>9.99-"   INITIAL 0 NO-UNDO.    /*Kridtiya  I.  A51-0198*/
DEFINE  VAR nv_covcod00 AS CHAR    FORMAT "X(3)".  /*A56-0394*/
/*---------------------------*/
/*DEFINE new  SHARED VAR   nv_sicod3   AS CHARACTER FORMAT "X(4)".
DEFINE new  SHARED VAR   nv_prem3    AS DECIMAL   FORMAT ">,>>>,>>9.99-"   INITIAL 0  NO-UNDO.
DEFINE new  SHARED VAR   nv_usecod3  AS CHARACTER FORMAT "X(4)".
DEFINE new  SHARED VAR   nv_prvprm3  AS DECI      FORMAT ">>,>>>,>>9.99-".
DEFINE new  SHARED VAR   nv_useprm3  AS DECI      FORMAT ">>,>>>,>>9.99-".
DEFINE new  SHARED VAR   nv_siprm3   AS DECI      FORMAT ">>,>>>,>>9.99-".*/
/*--- End A56-0394 ---*/

/*--- Add A57-0453 ---*/
*/
DEFINE NEW  SHARED VAR nv_44prm      AS INTEGER   FORMAT ">,>>>,>>9"  INITIAL 0 no-undo. /*A57-0453*/
DEFINE new  SHARED VAR nv_44cod1      AS CHAR      FORMAT "X(4)".
DEFINE new  SHARED VAR nv_44cod2      AS CHAR      FORMAT "X(4)".
DEFINE new  SHARED VAR nv_44          AS INTE      FORMAT ">>>,>>>,>>9".
DEFINE new  SHARED VAR nv_413prm      AS DECI      FORMAT ">,>>>,>>9.99".
DEFINE new  SHARED VAR nv_413var1     AS CHAR      FORMAT "X(30)".
DEFINE new  SHARED VAR nv_413var2     AS CHAR      FORMAT "X(30)".
DEFINE new  SHARED VAR nv_413var      AS CHAR      FORMAT "X(60)".
DEFINE new  SHARED VAR nv_414prm      AS DECI      FORMAT ">,>>>,>>9.99".
DEFINE new  SHARED VAR nv_414var1     AS CHAR      FORMAT "X(30)".
DEFINE new  SHARED VAR nv_414var2     AS CHAR      FORMAT "X(30)".
DEFINE new  SHARED VAR nv_414var      AS CHAR      FORMAT "X(60)".
/*--- End A57-0453 ---*/
/*-- Add A59-0049 --*/
DEFINE new  SHARED VAR nv_supecod  AS CHAR  FORMAT "X(4)".
DEFINE new  SHARED VAR nv_supeprm  AS DECI  FORMAT ">>,>>>,>>9.99-".
DEFINE new  SHARED VAR nv_supevar1 AS CHAR  FORMAT "X(30)".
DEFINE new  SHARED VAR nv_supevar2 AS CHAR  FORMAT "X(30)".
DEFINE new  SHARED VAR nv_supevar  AS CHAR  FORMAT "X(60)".
DEFINE new  SHARED VAR nv_supe00   AS DECI  FORMAT ">>,>>>,>>9.99-".
/*-- End Add A59-0049 --*/

/* add by : A64-0138 */
DEFINE NEW SHARED TEMP-TABLE wkuwd132 LIKE stat.pmuwd132.
DEF    VAR nv_cstflg  AS CHAR FORMAT "X(2)".     /*C=CC ; S=Seat ; T=Tons ; W=Watts*/  
DEFINE VAR nv_engcst  AS DECI FORMAT ">>>>>9.99".

DEFINE VAR nv_driage1 AS INTE FORMAT ">>9".
DEFINE VAR nv_driage2 AS INTE FORMAT ">>9".
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
DEF    VAR nv_41prmt  as DECI FORMAT ">>>,>>>,>>9.99-".  /*A65-0115*/
DEF    VAR nv_42prmt  as DECI FORMAT ">>>,>>>,>>9.99-".  /*A65-0115*/
DEF    VAR nv_43prmt  as DECI FORMAT ">>>,>>>,>>9.99-".  /*A65-0115*/

DEFINE VAR nv_ncbp    AS DECI FORMAT ">,>>9.99-".
DEFINE VAR nv_fletp   AS DECI FORMAT ">,>>9.99-".
DEFINE VAR nv_dspcp   AS DECI FORMAT ">,>>9.99-".
DEFINE VAR nv_dstfp   AS DECI FORMAT ">,>>9.99-".
DEFINE VAR nv_clmp    AS DECI FORMAT ">,>>9.99-".

DEFINE VAR nv_netprem AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_gapprem AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_flagprm AS CHAR FORMAT "X(2)". /* N=Net,G=Gross */
DEF    VAR nv_pdprem  AS DECI FORMAT ">>>,>>>,>>9.99-". /*A65-0115*/
DEF    VAR nv_status  AS CHAR .

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
/* end A64-0138 */
DEF VAR n_dealer AS CHAR FORMAT "x(10)" INIT "" . /*a65-0115*/
/* add by : A67-0162 */
def var n_tyeeng         as char format "x(20)"   init "". 
def var n_typMC          as char format "x(20)"   init "". 
def var n_watt           as CHAR FORMAT "x(4)"    init "". 
def var n_evmotor1       as char format "x(45)"   init "". 
def var n_evmotor2       as char format "x(45)"   init "". 
def var n_evmotor3       as char format "x(45)"   init "". 
def var n_evmotor4       as char format "x(45)"   init "". 
def var n_evmotor5       as char format "x(45)"   init "". 
def var n_evmotor6       as char format "x(45)"   init "". 
def var n_evmotor7       as char format "x(45)"   init "". 
def var n_evmotor8       as char format "x(45)"   init "". 
def var n_evmotor9       as char format "x(45)"   init "". 
def var n_evmotor10      as char format "x(45)"   init "". 
def var n_evmotor11      as char format "x(45)"   init "". 
def var n_evmotor12      as char format "x(45)"   init "". 
def var n_evmotor13      as char format "x(45)"   init "". 
def var n_evmotor14      as char format "x(45)"   init "". 
def var n_evmotor15      as char format "x(45)"   init "". 
def var n_carprice       as CHAR FORMAT "x(15)"   init "". 
def var n_drivlicen1     as CHAR FORMAT "x(20)"   init "". 
def var n_drivcardexp1   as CHAR FORMAT "x(15)"   init "". 
def var n_drivcartyp1    as char format "x(20)"   init "". 
def var n_drivlicen2     as char format "x(20)"   init "". 
def var n_drivcardexp2   as CHAR FORMAT "x(15)"   init "". 
def var n_drivnam3       as char format "x(200)"   init "". 
def var n_bdatedri3     as CHAR FORMAT "x(15)"   init "". 
def var n_sexdriv3       as char format "x(1)"    init "". 
def var n_driveno3       as char format "x(20)"   init "". 
def var n_drivlicen3     as char format "x(20)"   init "". 
def var n_drivcardexp3   as CHAR FORMAT "x(15)"   init "". 
def var n_occupdri3     as char format "x(255)"  init "". 
def var n_drivnam4     as char format "x(200)"   init "". 
def var n_bdatedri4     as CHAR FORMAT "x(15)"   init "". 
def var n_sexdriv4       as char format "X(1)"    init "". 
def var n_driveno4       as char format "X(20)"   init "". 
def var n_drivlicen4     as char format "X(20)"   init "". 
def var n_drivcardexp4   as CHAR FORMAT "x(15)"   init "". 
def var n_occupdri4     as char format "x(255)"  init "". 
def var n_drivnam5     as char format "x(200)"   init "". 
def var n_bdatedri5     as CHAR FORMAT "x(15)"   init "". 
def var n_sexdriv5       as char format "X(1)"    init "". 
def var n_driveno5       as char format "X(20)"   init "". 
def var n_drivlicen5     as char format "X(20)"   init "". 
def var n_drivcardexp5   as CHAR FORMAT "x(15)"   init "". 
def var n_occupdri5     as char format "x(255)"  init "". 
def var n_battflag       as char format "x(1)"    init "". 
def var n_battyr         as CHAR FORMAT "x(10)"   init "". 
def var n_battdate       as CHAR FORMAT "x(15)"   init "". 
def var n_battprice      as CHAR FORMAT "x(20)"   init "". 
def var n_battno         as CHAR FORMAT "x(50)"   init "". 
def var n_battsi         as CHAR FORMAT "x(20)"   init "". 
def var n_chagreno       as char format "x(50)"   init "". 
def var n_chagrebrand    as char format "x(50)"   init "". 
DEF VAR n_inspbr  AS CHAR FORMAT "x(70)" INIT "" .

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
/* end : A67-0162  */

