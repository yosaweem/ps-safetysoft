
/*Program ID   : wgwmtaycl.i                                                */
/*Program name : Match File Load and Update Data TLT                        */
/*create by    : Ranu i. A61-0573  date 10/02/2019
                โปรแกรม match file สำหรับโหลดเข้า GW และ Match Policy no on TLT */
/*Modify by   : Ranu I. A67-0162 เพิ่มการเก็บข้อมูลรถไฟฟ้า    */
/* ประกาศตัวแปร -*/
DEF VAR n_cmr_code      as CHAR FORMAT "X(50)"     init "".  
DEF VAR n_comp_code     as CHAR FORMAT "X(50)"     init "".  
DEF VAR n_campcode      as CHAR FORMAT "X(50)"     init "".  
DEF VAR n_campname      as CHAR FORMAT "X(50)"     init "".  
DEF VAR n_procode       as CHAR FORMAT "X(50)"     init "".  
DEF VAR n_proname       as CHAR FORMAT "X(50)"     init "".  
DEF VAR n_packname      as CHAR FORMAT "X(50)"     init "".  
DEF VAR n_packcode      as CHAR FORMAT "X(50)"     init "".
DEF VAR n_prepol        as CHAR FORMAT "X(13)"     init "". 
DEF VAR n_instype       as CHAR FORMAT "X(5)"      init "".  
DEF VAR n_pol_title     as CHAR FORMAT "X(20)"     init "".  
DEF VAR n_pol_fname     as CHAR FORMAT "X(100)"    init "".  
DEF VAR n_pol_lname     as CHAR FORMAT "X(100)"    init "".  
DEF VAR n_pol_title_eng as CHAR FORMAT "X(20)"     init "".  
DEF VAR n_pol_fname_eng as CHAR FORMAT "X(50)"     init "".  
DEF VAR n_pol_lname_eng as CHAR FORMAT "X(50)"     init "".  
DEF VAR n_icno          as CHAR FORMAT "X(20)"     init "".  
DEF VAR n_sex           as CHAR FORMAT "X(1) "     init "".  
DEF VAR n_bdate         as CHAR FORMAT "X(10)"     init "".  
DEF VAR n_occup         as CHAR FORMAT "X(50)"     init "".  
DEF VAR n_tel           as CHAR FORMAT "X(20)"     init "".  
DEF VAR n_phone         as CHAR FORMAT "X(20)"     init "".  
DEF VAR n_teloffic      as CHAR FORMAT "X(20)"     init "".  
DEF VAR n_telext        as CHAR FORMAT "X(20)"     init "".  
DEF VAR n_moblie        as CHAR FORMAT "X(20)"     init "".  
DEF VAR n_mobliech      as CHAR FORMAT "X(20)"     init "".  
DEF VAR n_mail          as CHAR FORMAT "X(40)"     init "".  
DEF VAR n_lineid        as CHAR FORMAT "X(100)"    init "".  
DEF VAR n_addr1_70      as CHAR FORMAT "X(100)"     init "".  
DEF VAR n_addr2_70      as CHAR FORMAT "X(100)"    init "".  
DEF VAR n_addr3_70      as CHAR FORMAT "X(100)"    init "".  
DEF VAR n_addr4_70      as CHAR FORMAT "X(100)"    init "".  
DEF VAR n_addr5_70      as CHAR FORMAT "X(40)"     init "".  
DEF VAR n_nsub_dist70   as CHAR FORMAT "X(20)"     init "".  
DEF VAR n_ndirection70  as CHAR FORMAT "X(20)"     init "".  
DEF VAR n_nprovin70     as CHAR FORMAT "X(20)"     init "".  
DEF VAR n_zipcode70     as CHAR FORMAT "X(10)"     init "".  
DEF VAR n_addr1_72      as CHAR FORMAT "X(100)"     init "".  
DEF VAR n_addr2_72      as CHAR FORMAT "X(100)"    init "".  
DEF VAR n_addr3_72      as CHAR FORMAT "X(100)"    init "".  
DEF VAR n_addr4_72      as CHAR FORMAT "X(100)"    init "".  
DEF VAR n_addr5_72      as CHAR FORMAT "X(40)"     init "".  
DEF VAR n_nsub_dist72   as CHAR FORMAT "X(20)"     init "".  
DEF VAR n_ndirection72  as CHAR FORMAT "X(20)"     init "".  
DEF VAR n_nprovin72     as CHAR FORMAT "X(20)"     init "".  
DEF VAR n_zipcode72     as CHAR FORMAT "X(10)"     init "".  
DEF VAR n_paytype       as CHAR FORMAT "X(1) "     init "".  
DEF VAR n_paytitle      as CHAR FORMAT "X(20)"     init "".  
DEF VAR n_payname       as CHAR FORMAT "X(100)"    init "".  
DEF VAR n_paylname      as CHAR FORMAT "X(100)"    init "".  
DEF VAR n_payicno       as CHAR FORMAT "X(20)"     init "".  
DEF VAR n_payaddr1      as CHAR FORMAT "X(100)"     init "".  
DEF VAR n_payaddr2      as CHAR FORMAT "X(100)"    init "".  
DEF VAR n_payaddr3      as CHAR FORMAT "X(100)"    init "".  
DEF VAR n_payaddr4      as CHAR FORMAT "X(100)"    init "".  
DEF VAR n_payaddr5      as CHAR FORMAT "X(40)"     init "".  
DEF VAR n_payaddr6      as CHAR FORMAT "X(20)"     init "".  
DEF VAR n_payaddr7      as CHAR FORMAT "X(20)"     init "".  
DEF VAR n_payaddr8      as CHAR FORMAT "X(20)"     init "".  
DEF VAR n_payaddr9      as CHAR FORMAT "X(10)"     init "".  
DEF VAR n_branch        as CHAR FORMAT "X(10)"     init "".  
DEF VAR n_ben_title     as CHAR FORMAT "X(10)"     init "".  
DEF VAR n_ben_name      as CHAR FORMAT "X(50)"     init "".  
DEF VAR n_ben_lname     as CHAR FORMAT "X(50)"     init "".  
DEF VAR n_pmentcode     as CHAR FORMAT "X(10)"     init "".  
DEF VAR n_pmenttyp      as CHAR FORMAT "X(20)"     init "".  
DEF VAR n_pmentcode1    as CHAR FORMAT "X(20)"     init "".  
DEF VAR n_pmentcode2    as CHAR FORMAT "X(50)"     init "".  
DEF VAR n_pmentbank     as CHAR FORMAT "X(20)"     init "".  
DEF VAR n_pmentdate     as CHAR FORMAT "X(10)"     init "".  
DEF VAR n_pmentsts      as CHAR FORMAT "X(10)"     init "".  
DEF VAR n_driver        as CHAR FORMAT "X(10)"     init "".  
DEF VAR n_drivetitle1   as CHAR FORMAT "X(10)"     init "".  
DEF VAR n_drivename1    as CHAR FORMAT "X(50)"     init "".  
DEF VAR n_drivelname1   as CHAR FORMAT "X(50)"     init "".  
DEF VAR n_driveno1      as CHAR FORMAT "X(20)"     init "".  
DEF VAR n_occupdriv1    as CHAR FORMAT "X(30)"     init "".  
DEF VAR n_sexdriv1      as CHAR FORMAT "X(1) "     init "".  
DEF VAR n_bdatedriv1    as CHAR FORMAT "X(10)"     init "".  
DEF VAR n_drivetitle2   as CHAR FORMAT "X(10)"     init "".  
DEF VAR n_drivename2    as CHAR FORMAT "X(50)"     init "".  
DEF VAR n_drivelname2   as CHAR FORMAT "X(50)"     init "".  
DEF VAR n_driveno2      as CHAR FORMAT "X(20)"     init "".  
DEF VAR n_occupdriv2    as CHAR FORMAT "X(50)"     init "".  
DEF VAR n_sexdriv2      as CHAR FORMAT "X(1) "     init "".  
DEF VAR n_bdatedriv2    as CHAR FORMAT "X(10)"     init "".  
DEF VAR n_brand         as CHAR FORMAT "X(50)"     init "".   
DEF VAR n_brand_cd      as CHAR FORMAT "X(50)"     init "".   
DEF VAR n_Model         as CHAR FORMAT "X(50)"     init "".   
DEF VAR n_Model_cd      as CHAR FORMAT "X(50)"     init "".   
DEF VAR n_body          as CHAR FORMAT "X(50)"     init "".   
DEF VAR n_body_cd       as CHAR FORMAT "X(50)"     init "".   
DEF VAR n_licence       as CHAR FORMAT "X(50)"     init "".   
DEF VAR n_province      as CHAR FORMAT "X(50)"     init "".   
DEF VAR n_chassis       as CHAR FORMAT "X(50)"     init "".   
DEF VAR n_engine        as CHAR FORMAT "X(50)"     init "".   
DEF VAR n_yrmanu        as CHAR FORMAT "X(10)"     init "".   
DEF VAR n_seatenew      as CHAR FORMAT "X(10)"     init "".   
DEF VAR n_power         as CHAR FORMAT "X(10)"     init "".   
DEF VAR n_weight        as CHAR FORMAT "X(10)"     init "".   
DEF VAR n_class         as CHAR FORMAT "X(10)"     init "".   
DEF VAR n_garage_cd     as CHAR FORMAT "X(10)"     init "".   
DEF VAR n_garage        as CHAR FORMAT "X(10)"     init "".   
DEF VAR n_colorcode     as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_covcod        as CHAR FORMAT "X(10)"     init "".   
DEF VAR n_covtyp        as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_covtyp1       as CHAR FORMAT "X(50)"     init "".   
DEF VAR n_covtyp2       as CHAR FORMAT "X(50)"     init "".   
DEF VAR n_covtyp3       as CHAR FORMAT "X(50)"     init "".   
DEF VAR n_comdat        as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_expdat        as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_ins_amt       as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_prem1         as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_gross_prm     as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_stamp         as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_vat           as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_premtotal     as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_deduct        as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_fleetper      as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_fleet         as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_ncbper        as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_ncb           as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_drivper       as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_drivdis       as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_othper        as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_oth           as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_cctvper       as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_cctv          as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_Surcharper    as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_Surchar       as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_Surchardetail as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_acc1          as CHAR FORMAT "X(50)"     init "".   
DEF VAR n_accdetail1    as CHAR FORMAT "X(500)"    init "".   
DEF VAR n_accprice1     as CHAR FORMAT "X(10)"     init "".   
DEF VAR n_acc2          as CHAR FORMAT "X(50)"     init "".   
DEF VAR n_accdetail2    as CHAR FORMAT "X(500)"    init "".   
DEF VAR n_accprice2     as CHAR FORMAT "X(10)"     init "".   
DEF VAR n_acc3          as CHAR FORMAT "X(50)"     init "".   
DEF VAR n_accdetail3    as CHAR FORMAT "X(500)"    init "".   
DEF VAR n_accprice3     as CHAR FORMAT "X(10)"     init "".   
DEF VAR n_acc4          as CHAR FORMAT "X(50)"     init "".   
DEF VAR n_accdetail4    as CHAR FORMAT "X(500)"    init "".   
DEF VAR n_accprice4     as CHAR FORMAT "X(10)"     init "".   
DEF VAR n_acc5          as CHAR FORMAT "X(50)"     init "".   
DEF VAR n_accdetail5    as CHAR FORMAT "X(500)"    init "".   
DEF VAR n_accprice5     as CHAR FORMAT "X(10)"     init "".   
DEF VAR n_inspdate      as CHAR FORMAT "X(10)"     init "".   
DEF VAR n_inspdate_app  as CHAR FORMAT "X(10)"     init "".   
DEF VAR n_inspsts       as CHAR FORMAT "X(10)"     init "".   
DEF VAR n_inspdetail    as CHAR FORMAT "X(500)"    init "".   
DEF VAR n_not_date      as CHAR FORMAT "X(10)"     init "".   
DEF VAR n_paydate       as CHAR FORMAT "X(10)"     init "".   
DEF VAR n_paysts        as CHAR FORMAT "X(10)"     init "".   
DEF VAR n_licenBroker   as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_brokname      as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_brokcode      as CHAR FORMAT "X(10)"     init "".   
DEF VAR n_lang          as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_deli          as CHAR FORMAT "X(50)"     init "".   
DEF VAR n_delidetail    as CHAR FORMAT "X(100)"    init "".   
DEF VAR n_gift          as CHAR FORMAT "X(100)"    init "".   
DEF VAR n_cedcode       as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_inscode       as CHAR FORMAT "X(20)"     init "".   
DEF VAR n_remark        as CHAR FORMAT "X(500)"    init "" . 
def var n_poltyp        AS CHAR FORMAT "x(5)" INIT "".
def var n_insno         as char format "x(250)" init "".
def var n_resultins     as char format "x(250)" init "".
def var n_damage1       as char format "x(250)" init "".
def var n_damage2       as char format "x(250)" init "".
def var n_damage3       as char format "x(250)" init "".
def var n_dataoth       as char format "x(250)" init "".
DEF VAR n_policy        AS CHAR FORMAT "x(13)"  INIT "" .
DEF VAR n_polbdate      AS CHAR FORMAT "x(15)"  INIT "" .
DEF VAR n_bray          AS CHAR FORMAT "x(2)" INIT "" .
DEF VAR n_producer      AS CHAR FORMAT "x(10)" INIT "" .
DEF VAR n_agent         AS CHAR FORMAT "x(10)" INIT "" .
DEF VAR n_remark2        AS CHAR FORMAT "x(150)" INIT "" .
DEF VAR n_hobr          AS CHAR FORMAT "x(2)" INIT "" .
DEF VAR n_contract      AS CHAR FORMAT "x(10)" INIT "" .
DEF VAR n_fi            AS CHAR FORMAT "x(15)" INIT "" .
DEF  STREAM nfile. 
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
def var n_drivcartyp2    as char format "x(20)"   init "". 
def var n_drivetitle3    as char format "x(10)"   init "". 
def var n_drivename3     as char format "x(50)"   init "". 
def var n_drivelname3    as char format "x(50)"   init "". 
def var n_bdatedriv3     as CHAR FORMAT "x(15)"   init "". 
def var n_sexdriv3       as char format "x(1)"    init "". 
def var n_drivcartyp3    as char format "x(20)"   init "". 
def var n_driveno3       as char format "x(20)"   init "". 
def var n_drivlicen3     as char format "x(20)"   init "". 
def var n_drivcardexp3   as CHAR FORMAT "x(15)"   init "". 
def var n_occupdriv3     as char format "x(255)"  init "". 
def var n_drivetitle4    as char format "x(10)"   init "". 
def var n_drivename4     as char format "x(50)"   init "". 
def var n_drivelname4    as char format "x(50)"   init "". 
def var n_bdatedriv4     as CHAR FORMAT "x(15)"   init "". 
def var n_sexdriv4       as char format "X(1)"    init "". 
def var n_drivcartyp4    as char format "X(20)"   init "". 
def var n_driveno4       as char format "X(20)"   init "". 
def var n_drivlicen4     as char format "X(20)"   init "". 
def var n_drivcardexp4   as CHAR FORMAT "x(15)"   init "". 
def var n_occupdriv4     as char format "x(255)"  init "". 
def var n_drivetitle5    as char format "x(10)"   init "". 
def var n_drivename5     as char format "x(50)"   init "". 
def var n_drivelname5    as char format "x(50)"   init "". 
def var n_bdatedriv5     as CHAR FORMAT "x(15)"   init "". 
def var n_sexdriv5       as char format "X(1)"    init "". 
def var n_drivcartyp5    as char format "X(20)"   init "". 
def var n_driveno5       as char format "X(20)"   init "". 
def var n_drivlicen5     as char format "X(20)"   init "". 
def var n_drivcardexp5   as CHAR FORMAT "x(15)"   init "". 
def var n_occupdriv5     as char format "x(255)"  init "". 
def var n_battflag       as char format "x(1)"    init "". 
def var n_battyr         as CHAR FORMAT "x(10)"   init "". 
def var n_battdate       as CHAR FORMAT "x(15)"   init "". 
def var n_battprice      as CHAR FORMAT "x(20)"   init "". 
def var n_battno         as CHAR FORMAT "x(50)"   init "". 
def var n_battsi         as CHAR FORMAT "x(20)"   init "". 
def var n_chagreno       as char format "x(50)"   init "". 
def var n_chagrebrand    as char format "x(50)"   init "". 
DEF VAR n_color  AS CHAR FORMAT "x(50)" INIT "" .
/* end A67-0162 */
/* A67-0162 ย้ายมาจาก .w */
DEFINE NEW SHARED TEMP-TABLE wtxt NO-UNDO
    FIELD poltyp         AS  CHAR FORMAT "x(5)" INIT ""
    FIELD policy         AS  CHAR FORMAT "x(13)" INIT ""
    field cedcode        as  CHAR FORMAT "X(20)"  INIT ""
    field inscode        as  CHAR FORMAT "X(20)"  INIT ""
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
    FIELD insno          AS  CHAR FORMAT "x(25)" INIT ""
    FIELD resultins      AS  CHAR FORMAT "x(250)" INIT ""
    field damage1        as  CHAR format "x(250)" init ""
    field damage2        as  CHAR format "x(250)" init ""
    field damage3        as  CHAR format "x(250)" init ""
    field dataoth        as  CHAR format "x(250)" init ""
    FIELD remark2        AS  CHAR FORMAT "X(250)" INIT ""
    FIELD producer       AS  CHAR FORMAT "x(12)"  INIT ""  
    FIELD agent          AS  CHAR FORMAT "x(12)"  INIT ""
    FIELD hobr           AS  CHAR FORMAT "x(3)"   INIT ""  
    FIELD dealer         AS  CHAR FORMAT "x(10)"  INIT ""   /*A65-0115*/
    FIELD nCOLOR         AS  CHAR FORMAT "X(50)"  INIT ""
    /* Add by : A67-0162 */
    field tyeeng        as char format "X(50)" init ""
    field typMC         as char format "X(50)" init ""
    field watt          as char format "X(50)" init ""
    field evmotor1      as char format "X(50)" init ""
    field evmotor2      as char format "X(50)" init ""
    field evmotor3      as char format "X(50)" init ""
    field evmotor4      as char format "X(50)" init ""
    field evmotor5      as char format "X(50)" init ""
    field carprice      as char format "X(50)" init ""
    field battflag      as char format "X(50)" init ""
    field battyr        as char format "X(50)" init ""
    field battdate      as char format "X(50)" init ""
    field battprice     as char format "X(50)" init ""
    field battno        as char format "X(50)" init ""
    field battsi        as char format "X(50)" init ""
    field chagreno      as char format "X(50)" init ""
    field chagrebrand   as char format "X(50)" init "" .
   /* end: A67-0162 */
DEF NEW SHARED TEMP-TABLE wdetail NO-UNDO
    FIELD   Codecompany  AS CHAR FORMAT "X(10)"  INIT ""   /*  Code บ.ประกัน   KPI */                                    
    FIELD   renew        AS CHAR FORMAT "X(10)"  INIT ""   /*  ปีประกัน    2   */
    FIELD   product      AS CHAR FORMAT "x(10)"  INIT ""   /*  Product code  A65-0115 */
    FIELD   Branch       AS CHAR FORMAT "X(10)"  INIT ""   /*  Branch  11  */                                             
    FIELD   Contract     AS CHAR FORMAT "X(20)"  INIT ""   /*  Contract    T053357 */                                  
    FIELD   name1        AS CHAR FORMAT "X(100)"  INIT ""   /*  ชื่อลูกค้า  กฤตพัฒน์    */   
    FIELD   policy       AS CHAR FORMAT "X(12)"  INIT ""   /*  เลขรับแจ้ง  STAY13-0257 */
    FIELD   vehreg       AS CHAR FORMAT "X(10)"  INIT ""   /*  เลขทะเบียน  ฎฮ 8828 */                                  
    FIELD   provin       AS CHAR FORMAT "X(50)"  INIT ""   /*  จังหวัดที่จดทะเบียน กรุงเทพมหานคร   */                  
    FIELD   chassis      AS CHAR FORMAT "X(50)"  INIT ""   /*  เลขตัวถัง   MR053ZEE106184578   */                      
    FIELD   engno        AS CHAR FORMAT "X(50)"  INIT ""   /*  เลขเครื่อง  3ZZB029121  */                                                
    FIELD   comdat70     AS CHAR FORMAT "X(10)"  INIT ""   /*  วันคุ้มครองประกัน   560722  */                                                
    FIELD   premtnet     AS CHAR FORMAT "X(15)"  INIT ""   /*  ค่าเบี้ยรวมภาษีอากร 1478312 */                                                
    FIELD   recivedat    AS CHAR FORMAT "x(10)"  INIT ""   /*  วันที่ชำระล่าสุด */
    /* Add by : A65-0115 12/07/2022 */
    FIELD   polno        AS CHAR FORMAT "x(12)"  INIT ""   /* เบอร์ กธ.         */
    FIELD   polsi        AS CHAR FORMAT "x(15)"  INIT ""   /* ทุน               */
    FIELD   polcomdat    AS CHAR FORMAT "x(15)"  INIT ""   /* วันที่คุ้มครอง    */ 
    FIELD   polexpdat    AS CHAR FORMAT "x(15)"  INIT ""   /* วันที่หมดอายุ     */  
    FIELD   polnetprm    AS CHAR FORMAT "x(20)"  INIT ""   /* เบี้ยสุทธิ        */ 
    FIELD   poltotalprm  AS CHAR FORMAT "x(20)"  INIT ""   /* เบี้ยรวม          */ 
    FIELD   comment      AS CHAR FORMAT "x(250)" INIT ""   
    /* end : A65-0115 */
    FIELD   remark       AS CHAR FORMAT "X(50)"  INIT "" .  /* หมายเหตุ.       */

DEF VAR n_dealer   AS CHAR FORMAT "X(10)"  INIT "" . /*A65-0115*/
DEF VAR n_char     AS CHAR FORMAT "x(500)" INIT "" .
DEF VAR nv_cnt     as int init 0.
DEF VAR nv_row     as int init 0.
DEF VAR nv_oldpol  AS CHAR FORMAT "x(15)" INIT "".
DEF VAR nv_output   AS CHAR FORMAT "x(60)" INIT "".
DEF VAR nv_policy   AS CHAR FORMAT "X(13)" INIT "" .
DEF VAR np_title    AS CHAR FORMAT "x(30)"     INIT "" .
DEF VAR np_name     AS CHAR FORMAT "x(40)"     INIT "" .
DEF VAR np_name2    AS CHAR FORMAT "x(40)"     INIT "" .
DEF VAR nv_isp      AS CHAR FORMAT "x(20)" INIT "" .
DEF VAR n_record    AS INT INIT 0.
/* end A67-0162 */



 
 
 
 
 
 






