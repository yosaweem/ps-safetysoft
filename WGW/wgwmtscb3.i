/********************************************************************************/
/*Program ID   : wgwmtscb3.i                                                    */
/*Program name : Match File Load and Update Data TLT                            */
/*create by    : Ranu i. A60-0488  date 16/10/2017 
                โปรแกรม match file สำหรับโหลดเข้า GW และ Match Policy no on TLT */
/* Modify BY   : Kridtiya i. A64-0295 DATE. 25/07/2021  เพิ่มฟิล์               */    
/* Modify By   : Tontawan S. A66-0006 24/05/2023 => เพิ่ม Field                 */          
/* Modify By   : Tontawan S. A68-0059 27/03/2025 => Add 35 Field for support EV */ 
/********************************************************************************/ 
/* ประกาศตัวแปร -*/
DEF VAR n_cmr_code      AS CHAR FORMAT "X(50)"     INIT "".  
DEF VAR n_comp_code     AS CHAR FORMAT "X(50)"     INIT "".  
DEF VAR n_campcode      AS CHAR FORMAT "X(50)"     INIT "".  
DEF VAR n_campname      AS CHAR FORMAT "X(50)"     INIT "".  
DEF VAR n_procode       AS CHAR FORMAT "X(50)"     INIT "".  
DEF VAR n_proname       AS CHAR FORMAT "X(50)"     INIT "".  
DEF VAR n_packname      AS CHAR FORMAT "X(50)"     INIT "".  
DEF VAR n_packcode      AS CHAR FORMAT "X(50)"     INIT "".
DEF VAR n_prepol        AS CHAR FORMAT "X(13)"     INIT "". 
DEF VAR n_instype       AS CHAR FORMAT "X(5)"      INIT "".  
DEF VAR n_pol_title     AS CHAR FORMAT "X(20)"     INIT "".  
DEF VAR n_pol_fname     AS CHAR FORMAT "X(100)"    INIT "".  
DEF VAR n_pol_lname     AS CHAR FORMAT "X(100)"    INIT "".  
DEF VAR n_pol_title_eng AS CHAR FORMAT "X(20)"     INIT "".  
DEF VAR n_pol_fname_eng AS CHAR FORMAT "X(50)"     INIT "".  
DEF VAR n_pol_lname_eng AS CHAR FORMAT "X(50)"     INIT "".  
DEF VAR n_icno          AS CHAR FORMAT "X(20)"     INIT "".  
DEF VAR n_sex           AS CHAR FORMAT "X(1) "     INIT "".  
DEF VAR n_bdate         AS CHAR FORMAT "X(10)"     INIT "".  
DEF VAR n_occup         AS CHAR FORMAT "X(50)"     INIT "".  
DEF VAR n_tel           AS CHAR FORMAT "X(20)"     INIT "".  
DEF VAR n_phone         AS CHAR FORMAT "X(20)"     INIT "".  
DEF VAR n_teloffic      AS CHAR FORMAT "X(20)"     INIT "".  
DEF VAR n_telext        AS CHAR FORMAT "X(20)"     INIT "".  
DEF VAR n_moblie        AS CHAR FORMAT "X(20)"     INIT "".  
DEF VAR n_mobliech      AS CHAR FORMAT "X(20)"     INIT "".  
DEF VAR n_mail          AS CHAR FORMAT "X(40)"     INIT "".  
DEF VAR n_lineid        AS CHAR FORMAT "X(100)"    INIT "".  
DEF VAR n_addr1_70      AS CHAR FORMAT "X(100)"     INIT "".  
DEF VAR n_addr2_70      AS CHAR FORMAT "X(100)"    INIT "".  
DEF VAR n_addr3_70      AS CHAR FORMAT "X(100)"    INIT "".  
DEF VAR n_addr4_70      AS CHAR FORMAT "X(100)"    INIT "".  
DEF VAR n_addr5_70      AS CHAR FORMAT "X(40)"     INIT "".  
DEF VAR n_nsub_dist70   AS CHAR FORMAT "X(20)"     INIT "".  
DEF VAR n_ndirection70  AS CHAR FORMAT "X(20)"     INIT "".  
DEF VAR n_nprovin70     AS CHAR FORMAT "X(20)"     INIT "".  
DEF VAR n_zipcode70     AS CHAR FORMAT "X(10)"     INIT "".  
DEF VAR n_addr1_72      AS CHAR FORMAT "X(100)"     INIT "".  
DEF VAR n_addr2_72      AS CHAR FORMAT "X(100)"    INIT "".  
DEF VAR n_addr3_72      AS CHAR FORMAT "X(100)"    INIT "".  
DEF VAR n_addr4_72      AS CHAR FORMAT "X(100)"    INIT "".  
DEF VAR n_addr5_72      AS CHAR FORMAT "X(40)"     INIT "".  
DEF VAR n_nsub_dist72   AS CHAR FORMAT "X(20)"     INIT "".  
DEF VAR n_ndirection72  AS CHAR FORMAT "X(20)"     INIT "".  
DEF VAR n_nprovin72     AS CHAR FORMAT "X(20)"     INIT "".  
DEF VAR n_zipcode72     AS CHAR FORMAT "X(10)"     INIT "".  
DEF VAR n_paytype       AS CHAR FORMAT "X(1) "     INIT "".  
DEF VAR n_paytitle      AS CHAR FORMAT "X(20)"     INIT "".  
DEF VAR n_payname       AS CHAR FORMAT "X(100)"    INIT "".  
DEF VAR n_paylname      AS CHAR FORMAT "X(100)"    INIT "".  
DEF VAR n_payicno       AS CHAR FORMAT "X(20)"     INIT "".  
DEF VAR n_payaddr1      AS CHAR FORMAT "X(100)"    INIT "".  
DEF VAR n_payaddr2      AS CHAR FORMAT "X(100)"    INIT "".  
DEF VAR n_payaddr3      AS CHAR FORMAT "X(100)"    INIT "".  
DEF VAR n_payaddr4      AS CHAR FORMAT "X(100)"    INIT "".  
DEF VAR n_payaddr5      AS CHAR FORMAT "X(40)"     INIT "".  
DEF VAR n_payaddr6      AS CHAR FORMAT "X(20)"     INIT "".  
DEF VAR n_payaddr7      AS CHAR FORMAT "X(20)"     INIT "".  
DEF VAR n_payaddr8      AS CHAR FORMAT "X(20)"     INIT "".  
DEF VAR n_payaddr9      AS CHAR FORMAT "X(10)"     INIT "".  
DEF VAR n_branch        AS CHAR FORMAT "X(10)"     INIT "".  
DEF VAR n_ben_title     AS CHAR FORMAT "X(10)"     INIT "".  
DEF VAR n_ben_name      AS CHAR FORMAT "X(50)"     INIT "".  
DEF VAR n_ben_lname     AS CHAR FORMAT "X(50)"     INIT "".  
DEF VAR n_ben_2title    AS CHAR FORMAT "X(10)"     INIT "". /*Kridtiya i. A64-0295 DATE. 25/07/2021 */ 
DEF VAR n_ben_2name     AS CHAR FORMAT "X(50)"     INIT "". /*Kridtiya i. A64-0295 DATE. 25/07/2021 */
DEF VAR n_ben_2lname    AS CHAR FORMAT "X(50)"     INIT "". /*Kridtiya i. A64-0295 DATE. 25/07/2021 */
DEF VAR n_ben_3title    AS CHAR FORMAT "X(10)"     INIT "". /*Kridtiya i. A64-0295 DATE. 25/07/2021 */
DEF VAR n_ben_3name     AS CHAR FORMAT "X(50)"     INIT "". /*Kridtiya i. A64-0295 DATE. 25/07/2021 */
DEF VAR n_ben_3lname    AS CHAR FORMAT "X(50)"     INIT "". /*Kridtiya i. A64-0295 DATE. 25/07/2021 */
DEF VAR n_pmentcode     AS CHAR FORMAT "X(10)"     INIT "".  
DEF VAR n_pmenttyp      AS CHAR FORMAT "X(20)"     INIT "".  
DEF VAR n_pmentcode1    AS CHAR FORMAT "X(20)"     INIT "".  
DEF VAR n_pmentcode2    AS CHAR FORMAT "X(50)"     INIT "".  
DEF VAR n_pmentbank     AS CHAR FORMAT "X(20)"     INIT "".  
DEF VAR n_pmentdate     AS CHAR FORMAT "X(10)"     INIT "".  
DEF VAR n_pmentsts      AS CHAR FORMAT "X(10)"     INIT "".  
DEF VAR n_driver        AS CHAR FORMAT "X(10)"     INIT "".  
DEF VAR n_drivetitle1   AS CHAR FORMAT "X(10)"     INIT "".  
DEF VAR n_drivename1    AS CHAR FORMAT "X(50)"     INIT "".  
DEF VAR n_drivelname1   AS CHAR FORMAT "X(50)"     INIT "".  
DEF VAR n_driveno1      AS CHAR FORMAT "X(20)"     INIT "".  
DEF VAR n_occupdriv1    AS CHAR FORMAT "X(30)"     INIT "".  
DEF VAR n_sexdriv1      AS CHAR FORMAT "X(1) "     INIT "".  
DEF VAR n_bdatedriv1    AS CHAR FORMAT "X(10)"     INIT "".  
DEF VAR n_drivetitle2   AS CHAR FORMAT "X(10)"     INIT "".  
DEF VAR n_drivename2    AS CHAR FORMAT "X(50)"     INIT "".  
DEF VAR n_drivelname2   AS CHAR FORMAT "X(50)"     INIT "".  
DEF VAR n_driveno2      AS CHAR FORMAT "X(20)"     INIT "".  
DEF VAR n_occupdriv2    AS CHAR FORMAT "X(50)"     INIT "".  
DEF VAR n_sexdriv2      AS CHAR FORMAT "X(1) "     INIT "".  
DEF VAR n_bdatedriv2    AS CHAR FORMAT "X(10)"     INIT "".  
DEF VAR n_brand         AS CHAR FORMAT "X(50)"     INIT "".   
DEF VAR n_brand_cd      AS CHAR FORMAT "X(50)"     INIT "".   
DEF VAR n_Model         AS CHAR FORMAT "X(50)"     INIT "".   
DEF VAR n_Model_cd      AS CHAR FORMAT "X(50)"     INIT "".   
DEF VAR n_body          AS CHAR FORMAT "X(50)"     INIT "".   
DEF VAR n_body_cd       AS CHAR FORMAT "X(50)"     INIT "".   
DEF VAR n_licence       AS CHAR FORMAT "X(50)"     INIT "".   
DEF VAR n_province      AS CHAR FORMAT "X(50)"     INIT "".   
DEF VAR n_chASsis       AS CHAR FORMAT "X(50)"     INIT "".   
DEF VAR n_engine        AS CHAR FORMAT "X(50)"     INIT "".   
DEF VAR n_yrmanu        AS CHAR FORMAT "X(10)"     INIT "".   
DEF VAR n_seatenew      AS CHAR FORMAT "X(10)"     INIT "".   
DEF VAR n_power         AS CHAR FORMAT "X(10)"     INIT "".   
DEF VAR n_weight        AS CHAR FORMAT "X(10)"     INIT "".   
DEF VAR n_clASs         AS CHAR FORMAT "X(10)"     INIT "".   
DEF VAR n_garage_cd     AS CHAR FORMAT "X(10)"     INIT "".   
DEF VAR n_garage        AS CHAR FORMAT "X(10)"     INIT "".   
DEF VAR n_colorcode     AS CHAR FORMAT "X(20)"     INIT "".   
DEF VAR n_covcod        AS CHAR FORMAT "X(10)"     INIT "".   
DEF VAR n_covtyp        AS CHAR FORMAT "X(20)"     INIT "".   
DEF VAR n_covtyp1       AS CHAR FORMAT "X(50)"     INIT "".   
DEF VAR n_covtyp2       AS CHAR FORMAT "X(50)"     INIT "".   
DEF VAR n_covtyp3       AS CHAR FORMAT "X(50)"     INIT "".   
DEF VAR n_comdat        AS CHAR FORMAT "X(20)"     INIT "".   
DEF VAR n_expdat        AS CHAR FORMAT "X(20)"     INIT "".   
DEF VAR n_ins_amt       AS CHAR FORMAT "X(20)"     INIT "".   
DEF VAR n_prem1         AS CHAR FORMAT "X(20)"     INIT "".   
DEF VAR n_gross_prm     AS CHAR FORMAT "X(20)"     INIT "".   
DEF VAR n_stamp         AS CHAR FORMAT "X(20)"     INIT "".   
DEF VAR n_vat           AS CHAR FORMAT "X(20)"     INIT "".   
DEF VAR n_premtotal     AS CHAR FORMAT "X(20)"     INIT "".   
DEF VAR n_deduct        AS CHAR FORMAT "X(20)"     INIT "".   
DEF VAR n_fleetper      AS CHAR FORMAT "X(20)"     INIT "".   
DEF VAR n_fleet         AS CHAR FORMAT "X(20)"     INIT "".   
DEF VAR n_ncbper        AS CHAR FORMAT "X(20)"     INIT "".   
DEF VAR n_ncb           AS CHAR FORMAT "X(20)"     INIT "".   
DEF VAR n_drivper       AS CHAR FORMAT "X(20)"     INIT "".   
DEF VAR n_drivdis       AS CHAR FORMAT "X(20)"     INIT "".   
DEF VAR n_othper        AS CHAR FORMAT "X(20)"     INIT "".   
DEF VAR n_oth           AS CHAR FORMAT "X(20)"     INIT "".   
DEF VAR n_cctvper       AS CHAR FORMAT "X(20)"     INIT "".   
DEF VAR n_cctv          AS CHAR FORMAT "X(20)"     INIT "".   
DEF VAR n_Surcharper    AS CHAR FORMAT "X(20)"     INIT "".   
DEF VAR n_Surchar       AS CHAR FORMAT "X(20)"     INIT "".   
DEF VAR n_Surchardetail AS CHAR FORMAT "X(20)"     INIT "".   
DEF VAR n_acc1          AS CHAR FORMAT "X(50)"     INIT "".   
DEF VAR n_accdetail1    AS CHAR FORMAT "X(500)"    INIT "".   
DEF VAR n_accprice1     AS CHAR FORMAT "X(10)"     INIT "".   
DEF VAR n_acc2          AS CHAR FORMAT "X(50)"     INIT "".   
DEF VAR n_accdetail2    AS CHAR FORMAT "X(500)"    INIT "".   
DEF VAR n_accprice2     AS CHAR FORMAT "X(10)"     INIT "".   
DEF VAR n_acc3          AS CHAR FORMAT "X(50)"     INIT "".   
DEF VAR n_accdetail3    AS CHAR FORMAT "X(500)"    INIT "".   
DEF VAR n_accprice3     AS CHAR FORMAT "X(10)"     INIT "".   
DEF VAR n_acc4          AS CHAR FORMAT "X(50)"     INIT "".   
DEF VAR n_accdetail4    AS CHAR FORMAT "X(500)"    INIT "".   
DEF VAR n_accprice4     AS CHAR FORMAT "X(10)"     INIT "".   
DEF VAR n_acc5          AS CHAR FORMAT "X(50)"     INIT "".   
DEF VAR n_accdetail5    AS CHAR FORMAT "X(500)"    INIT "".   
DEF VAR n_accprice5     AS CHAR FORMAT "X(10)"     INIT "".   
DEF VAR n_inspdate      AS CHAR FORMAT "X(10)"     INIT "".   
DEF VAR n_inspdate_app  AS CHAR FORMAT "X(10)"     INIT "".   
DEF VAR n_inspsts       AS CHAR FORMAT "X(10)"     INIT "".   
DEF VAR n_inspdetail    AS CHAR FORMAT "X(500)"    INIT "".   
DEF VAR n_not_date      AS CHAR FORMAT "X(10)"     INIT "".   
DEF VAR n_paydate       AS CHAR FORMAT "X(10)"     INIT "".   
DEF VAR n_paysts        AS CHAR FORMAT "X(10)"     INIT "".   
DEF VAR n_licenBroker   AS CHAR FORMAT "X(20)"     INIT "".   
DEF VAR n_brokname      AS CHAR FORMAT "X(20)"     INIT "".   
DEF VAR n_brokcode      AS CHAR FORMAT "X(10)"     INIT "".   
DEF VAR n_lang          AS CHAR FORMAT "X(20)"     INIT "".   
DEF VAR n_deli          AS CHAR FORMAT "X(50)"     INIT "".   
DEF VAR n_delidetail    AS CHAR FORMAT "X(100)"    INIT "".   
DEF VAR n_gift          AS CHAR FORMAT "X(100)"    INIT "".   
DEF VAR n_cedcode       AS CHAR FORMAT "X(20)"     INIT "".   
DEF VAR n_inscode       AS CHAR FORMAT "X(20)"     INIT "".   
DEF VAR n_remark        AS CHAR FORMAT "X(500)"    INIT "" . 
DEF VAR n_poltyp        AS CHAR FORMAT "x(5)"   INIT "".
DEF VAR n_insno         AS CHAR FORMAT "x(250)" INIT "".
DEF VAR n_resultins     AS CHAR FORMAT "x(250)" INIT "".
DEF VAR n_damage1       AS CHAR FORMAT "x(250)" INIT "".
DEF VAR n_damage2       AS CHAR FORMAT "x(250)" INIT "".
DEF VAR n_damage3       AS CHAR FORMAT "x(250)" INIT "".
DEF VAR n_dataoth       AS CHAR FORMAT "x(250)" INIT "".
DEF VAR n_Agent_Code      AS CHAR FORMAT "x(250)" INIT "". /*Kridtiya i. A64-0295 DATE. 25/07/2021 */
DEF VAR n_Agent_NameTH    AS CHAR FORMAT "x(250)" INIT "". /*Kridtiya i. A64-0295 DATE. 25/07/2021 */
DEF VAR n_Agent_NameEng   AS CHAR FORMAT "x(250)" INIT "". /*Kridtiya i. A64-0295 DATE. 25/07/2021 */
DEF VAR n_Selling_Channel AS CHAR FORMAT "x(250)" INIT "". /*Kridtiya i. A64-0295 DATE. 25/07/2021 */

/*-- Add By Tontawan S. A66-0006 24/05/2023 ---*/
DEF VAR n_sellcode          AS  CHAR FORMAT "x(20)"  INIT "". 
DEF VAR n_sellname          AS  CHAR FORMAT "X(100)" INIT "". 
DEF VAR n_campaign          AS  CHAR FORMAT "x(20)"  INIT "". 
DEF VAR n_branch_c          AS  CHAR FORMAT "x(20)"  INIT "". 
DEF VAR n_selling_ch        AS  CHAR FORMAT "x(20)"  INIT "". 
DEF VAR n_person            AS  CHAR FORMAT "X(20)"  INIT "". 
DEF VAR n_peracc            AS  CHAR FORMAT "X(20)"  INIT "". 
DEF VAR n_perpd             AS  CHAR FORMAT "X(20)"  INIT "". 
DEF VAR n_si411             AS  CHAR FORMAT "X(20)"  INIT "". 
DEF VAR n_si412             AS  CHAR FORMAT "X(20)"  INIT "". 
DEF VAR n_si43              AS  CHAR FORMAT "X(20)"  INIT "".
DEF VAR n_ispno             AS  CHAR FORMAT "X(20)"  INIT "".
/*-- End By Tontawan S. A66-0006 24/05/2023 ---*/
/*-- Add By Tontawan S. A68-0059 27/03/2025 --*/
DEFINE NEW SHARED TEMP-TABLE wload NO-UNDO
    FIELD poltyp         AS  CHAR FORMAT "x(5)"   INIT ""                      /* ประเภทกรมธรรม์*/                       
    FIELD policy         AS  CHAR FORMAT "x(13)"  INIT "" 
    FIELD prepol         AS  CHAR FORMAT "x(13)"  INIT ""                     
    field cedcode        AS  CHAR FORMAT "X(20)"  INIT ""                  /* รหัสอ้างอิง   */                           
    field inscode        AS  CHAR FORMAT "X(20)"  INIT ""                  /* รหัสลูกค้า    */                           
    FIELD campcode       AS  CHAR FORMAT "X(20)"  INIT ""                  /* รหัสแคมเปญ    */                           
    FIELD campname       AS  CHAR FORMAT "X(35)"  INIT ""                  /* ชื่อแคมเปญ    */                           
    FIELD procode        AS  CHAR FORMAT "X(20)"  INIT ""                  /* รหัสผลิตภัณฑ์ */                           
    FIELD proname        AS  CHAR FORMAT "X(35)"  INIT ""                  /* ชื่อผลิตภัณฑ์ */                           
    FIELD packname       AS  CHAR FORMAT "X(35)"  INIT ""                  /* ชื่อแพคเก็จ   */                           
    FIELD packcode       AS  CHAR FORMAT "X(20)"  INIT ""                  /* รหัสแพคเก็จ   */                           
    FIELD instype        AS  CHAR FORMAT "X(1)"   INIT ""                  /* ประเภทผู้เอาประกัน */                      
    FIELD pol_title      AS  CHAR FORMAT "X(20)"  INIT ""                  /* คำนำหน้าชื่อ ผู้เอาประกัน */               
    FIELD pol_fname      AS  CHAR FORMAT "X(100)" INIT ""                  /* ชื่อ ผู้เอาประกัน         */               
    FIELD pol_title_eng  AS  CHAR FORMAT "X(10)"  INIT ""                  /* คำนำหน้าชื่อ ผู้เอาประกัน (Eng) */         
    FIELD pol_fname_eng  AS  CHAR FORMAT "X(100)" INIT ""                  /* ชื่อ ผู้เอาประกัน (Eng)*/                  
    FIELD icno           AS  CHAR FORMAT "X(13)"  INIT ""                  /* เลขบัตรผู้เอาประกัน */                     
    FIELD bdate          AS  CHAR FORMAT "X(15)"  INIT ""                  /* วันเกิดผู้เอาประกัน */                     
    FIELD occup          AS  CHAR FORMAT "X(50)"  INIT ""                  /* อาชีพผู้เอาประกัน*/                        
    FIELD tel            AS  CHAR FORMAT "X(50)"  INIT ""                  /* เบอร์โทรผู้เอาประกัน*/                     
    FIELD mail           AS  CHAR FORMAT "X(50)"  INIT ""                  /* อีเมล์ผู้เอาประกัน  */                     
    FIELD addrpol1       AS  CHAR FORMAT "X(45)"  INIT ""                  /* ที่อยู่หน้าตาราง1*/                        
    FIELD addrpol2       AS  CHAR FORMAT "X(45)"  INIT ""                  /* ที่อยู่หน้าตาราง2*/                        
    FIELD addrpol3       AS  CHAR FORMAT "X(45)"  INIT ""                  /* ที่อยู่หน้าตาราง3*/                        
    FIELD addrpol4       AS  CHAR FORMAT "X(45)"  INIT ""                  /* ที่อยู่หน้าตาราง4*/                        
    FIELD addrsend1      AS  CHAR FORMAT "X(45)"  INIT ""                  /* ที่อยู่จัดส่ง 1  */                        
    FIELD addrsend2      AS  CHAR FORMAT "X(45)"  INIT ""                  /* ที่อยู่จัดส่ง 2  */                        
    FIELD addrsend3      AS  CHAR FORMAT "X(45)"  INIT ""                  /* ที่อยู่จัดส่ง 3  */                        
    FIELD addrsend4      AS  CHAR FORMAT "X(45)"  INIT ""                  /* ที่อยู่จัดส่ง 4  */                        
    FIELD paytype        AS  CHAR FORMAT "X(2)"   INIT ""                  /* ประเภทผู้จ่ายเงิน*/                        
    FIELD paytitle       AS  CHAR FORMAT "X(20)"  INIT ""                  /* คำนำหน้าชื่อ ผู้จ่ายเงิน*/                 
    FIELD payname        AS  CHAR FORMAT "X(100)" INIT ""                  /* ชื่อ ผู้จ่ายเงิน*/                         
    FIELD icpay          AS  CHAR FORMAT "X(50)"  INIT ""                  /* เลขประจำตัวผู้เสียภาษี*/                   
    FIELD addrpay1       AS  CHAR FORMAT "X(40)"  INIT ""                  /* ที่อยู่ออกใบเสร็จ1*/                       
    FIELD addrpay2       AS  CHAR FORMAT "X(40)"  INIT ""                  /* ที่อยู่ออกใบเสร็จ2*/                       
    FIELD addrpay3       AS  CHAR FORMAT "X(40)"  INIT ""                  /* ที่อยู่ออกใบเสร็จ3*/                       
    FIELD addrpay4       AS  CHAR FORMAT "X(40)"  INIT ""                  /* ที่อยู่ออกใบเสร็จ4*/                       
    FIELD branch         AS  CHAR FORMAT "X(20)"  INIT ""                  /* สาขา*/                                     
    FIELD ben_name       AS  CHAR FORMAT "X(100)" INIT ""                  /* ผู้รับผลประโยชน์  */                       
    FIELD pmentcode      AS  CHAR FORMAT "X(10)"  INIT ""                  /* รหัสประเภทการจ่าย */                       
    FIELD pmenttyp       AS  CHAR FORMAT "X(75)"  INIT ""                  /* ประเภทการจ่าย */                           
    FIELD pmentcode1     AS  CHAR FORMAT "X(10)"  INIT ""                  /* รหัสช่องทางการจ่าย*/                       
    FIELD pmentcode2     AS  CHAR FORMAT "X(75)"  INIT ""                  /* ช่องทางการจ่าย  */                         
    FIELD pmentbank      AS  CHAR FORMAT "X(50)"  INIT ""                  /* ธนาคารที่จ่าย*/                            
    FIELD pmentdate      AS  CHAR FORMAT "X(15)"  INIT ""                  /* วันที่จ่าย   */                            
    FIELD pmentsts       AS  CHAR FORMAT "X(15)"  INIT ""                  /* สถานะการจ่าย */                            
    field brand          AS  CHAR FORMAT "x(35)"  INIT ""                  /* ยี่ห้อ  */                                 
    field Model          AS  CHAR FORMAT "x(50)"  INIT ""                  /* รุ่น    */                                 
    field body           AS  CHAR FORMAT "x(20)"  INIT ""                  /* แบบตัวถัง*/                                
    field licence        AS  CHAR FORMAT "x(11)"  INIT ""                  /* ทะเบียน */                                 
    field province       AS  CHAR FORMAT "x(25)"  INIT ""                  /* จังหวัดทะเบียน */                          
    field chASsis        AS  CHAR FORMAT "x(20)"  INIT ""                  /* เลขตัวถัง*/                                
    field engine         AS  CHAR FORMAT "x(20)"  INIT ""                  /* เลขเครื่อง */                              
    field yrmanu         AS  CHAR FORMAT "x(5)"   INIT ""                  /* ปีรถ    */                                 
    field seatenew       AS  CHAR FORMAT "x(5)"   INIT ""                  /* ที่นั่ง */                                 
    FIELD power          AS  CHAR FORMAT "x(15)"  INIT ""                  /* ซีซี    */                                 
    FIELD weight         AS  CHAR FORMAT "X(15)"  INIT ""                  /* น้ำหนัก */                                 
    FIELD clASs          AS  CHAR FORMAT "x(5)"   INIT ""                  /* คลาสรถ  */  
    FIELD tclASs         AS  CHAR FORMAT "x(5)"   INIT ""                  /* รหัสรถยนต์  */  //Ton
    FIELD garage         AS  CHAR FORMAT "x(35)"  INIT ""                  /* การซ่อม */                                 
    FIELD colorcode      AS  CHAR FORMAT "x(35)"  INIT ""                  /* สี  */                                     
    FIELD covcod         AS  CHAR FORMAT "x(50)"  INIT ""                  /* ประเภทการประกัน */                         
    FIELD covtyp         AS  CHAR FORMAT "x(30)"  INIT ""                  /* รหัสการประกัน*/                            
    FIELD comdat         AS  CHAR FORMAT "x(15)"  INIT ""                  /* วันที่คุ้มครอง  */                         
    FIELD expdat         AS  CHAR FORMAT "x(15)"  INIT ""                  /* วันที่หมดอายุ*/                            
    FIELD ins_amt        AS  CHAR FORMAT "x(20)"  INIT ""                  /* ทุนประกัน*/                                
    FIELD prem1          AS  CHAR FORMAT "x(20)"  INIT ""                  /* เบี้ยสุทธิก่อนหักส่วนลด*/                  
    FIELD gross_prm      AS  CHAR FORMAT "x(20)"  INIT ""                  /* เบี้ยสุทธิหลังหักส่วนลด*/                  
    FIELD stamp          AS  CHAR FORMAT "x(10)"  INIT ""                  /* สแตมป์  */                                 
    FIELD vat            AS  CHAR FORMAT "X(10)"  INIT ""                  /* ภาษี    */                                 
    FIELD premtotal      AS  CHAR FORMAT "x(20)"  INIT ""                  /* เบี้ยรวม*/                                 
    field deduct         AS  CHAR FORMAT "x(10)"  INIT ""                  /* Deduct  */                                 
    field fleetper       AS  CHAR FORMAT "x(10)"  INIT ""                  /* fleet   */                                 
    field ncbper         AS  CHAR FORMAT "x(10)"  INIT ""                  /* ncb     */                                 
    field othper         AS  CHAR FORMAT "X(10)"  INIT ""                  /* other   */                                 
    field cctvper        AS  CHAR FORMAT "X(10)"  INIT ""                  /* cctv    */                                 
    FIELD driver         AS  CHAR FORMAT "X(2)"   INIT ""                  /* ระบุผู้ขับขี่    */                        
    FIELD drivename1     AS  CHAR FORMAT "X(70)"  INIT ""                  /* ชื่อผู้ขับขี่1   */                        
    FIELD driveno1       AS  CHAR FORMAT "X(15)"  INIT ""                  /* เลขบัตรผู้ขับขี่1*/                        
    FIELD occupdriv1     AS  CHAR FORMAT "X(50)"  INIT ""                  /* อาชีพผู้ขับขี่1  */                        
    FIELD sexdriv1       AS  CHAR FORMAT "X(10)"  INIT ""                  /* เพศผู้ขับขี่1    */                        
    FIELD bdatedriv1     AS  CHAR FORMAT "X(15)"  INIT ""                  /* วันเกิดผู้ขับขี่1*/                        
    FIELD drivename2     AS  CHAR FORMAT "x(70)"  INIT ""                  /* ชื่อผู้ขับขี่2   */                        
    FIELD driveno2       AS  CHAR FORMAT "x(15)"  INIT ""                  /* เลขบัตรผู้ขับขี่2*/                        
    FIELD occupdriv2     AS  CHAR FORMAT "x(50)"  INIT ""                  /* อาชีพผู้ขับขี่2  */                        
    FIELD sexdriv2       AS  CHAR FORMAT "x(10)"  INIT ""                  /* เพศผู้ขับขี่2    */                        
    FIELD bdatedriv2     AS  CHAR FORMAT "x(15)"  INIT ""                 /* วันเกิดผู้ขับขี่2*/
    FIELD producer       AS  CHAR FORMAT "x(25)"  INIT ""   /*Kridtiya i. A64-0295 DATE. 25/07/2021 */
    FIELD agent          AS  CHAR FORMAT "x(25)"  INIT ""   /*Kridtiya i. A64-0295 DATE. 25/07/2021 */
    /*-- Add By Tontawan S. A66-0006 17/05/2023 --*/
    FIELD sellcode       AS  CHAR FORMAT "X(25)"  INIT ""  
    FIELD sellname       AS  CHAR FORMAT "X(100)" INIT ""  
    FIELD selling_ch     AS  CHAR FORMAT "X(100)" INIT ""  
    FIELD branch_c       AS  CHAR FORMAT "X(25)"  INIT ""  
    FIELD campaign       AS  CHAR FORMAT "X(25)"  INIT ""
    FIELD person         AS  CHAR FORMAT "X(20)"  INIT ""
    FIELD peracc         AS  CHAR FORMAT "X(20)"  INIT ""
    FIELD perpd          AS  CHAR FORMAT "X(20)"  INIT ""
    FIELD si411          AS  CHAR FORMAT "X(20)"  INIT ""
    FIELD si412          AS  CHAR FORMAT "X(20)"  INIT ""
    FIELD si43           AS  CHAR FORMAT "X(20)"  INIT ""
    /*-- End By Tontawan S. A66-0006 17/05/2023 --*/
    /*-- Add By Tontawan S. A68-0059 27/03/2025 --*/
    FIELD drv3_salutation_M AS CHAR FORMAT "X(20)"  INIT "" 
    FIELD drv3_fname        AS CHAR FORMAT "X(100)" INIT "" 
    FIELD drv3_lname        AS CHAR FORMAT "X(100)" INIT "" 
    FIELD drv3_nid          AS CHAR FORMAT "X(20)"  INIT "" 
    FIELD drv3_occupation   AS CHAR FORMAT "X(50)"  INIT "" 
    FIELD drv3_gender       AS CHAR FORMAT "X(10)"  INIT "" 
    FIELD drv3_birthdate    AS CHAR FORMAT "X(10)"  INIT "" 
    FIELD drv4_salutation_M AS CHAR FORMAT "X(20)"  INIT "" 
    FIELD drv4_fname        AS CHAR FORMAT "X(100)" INIT "" 
    FIELD drv4_lname        AS CHAR FORMAT "X(100)" INIT "" 
    FIELD drv4_nid          AS CHAR FORMAT "X(20)"  INIT "" 
    FIELD drv4_occupation   AS CHAR FORMAT "X(50)"  INIT "" 
    FIELD drv4_gender       AS CHAR FORMAT "X(10)"  INIT "" 
    FIELD drv4_birthdate    AS CHAR FORMAT "X(10)"  INIT "" 
    FIELD drv5_salutation_M AS CHAR FORMAT "X(20)"  INIT "" 
    FIELD drv5_fname        AS CHAR FORMAT "X(100)" INIT "" 
    FIELD drv5_lname        AS CHAR FORMAT "X(100)" INIT "" 
    FIELD drv5_nid          AS CHAR FORMAT "X(20)"  INIT "" 
    FIELD drv5_occupation   AS CHAR FORMAT "X(50)"  INIT "" 
    FIELD drv5_gender       AS CHAR FORMAT "X(10)"  INIT "" 
    FIELD drv5_birthdate    AS CHAR FORMAT "X(10)"  INIT "" 
    FIELD drv1_dlicense     AS CHAR FORMAT "X(50)"  INIT "" 
    FIELD drv2_dlicense     AS CHAR FORMAT "X(50)"  INIT "" 
    FIELD drv3_dlicense     AS CHAR FORMAT "X(50)"  INIT "" 
    FIELD drv4_dlicense     AS CHAR FORMAT "X(50)"  INIT "" 
    FIELD drv5_dlicense     AS CHAR FORMAT "X(50)"  INIT "" 
    FIELD baty_snumber      AS CHAR FORMAT "X(20)"  INIT "" 
    FIELD batydate          AS CHAR FORMAT "X(10)"  INIT "" 
    FIELD baty_rsi          AS CHAR FORMAT "X(20)"  INIT "" 
    FIELD baty_npremium     AS CHAR FORMAT "X(20)"  INIT "" 
    FIELD baty_gpremium     AS CHAR FORMAT "X(20)"  INIT "" 
    FIELD wcharge_snumber   AS CHAR FORMAT "X(20)"  INIT "" 
    FIELD wcharge_si        AS CHAR FORMAT "X(20)"  INIT "" 
    FIELD wcharge_npremium  AS CHAR FORMAT "X(20)"  INIT "" 
    FIELD wcharge_gpremium  AS CHAR FORMAT "X(20)"  INIT "". 

DEF VAR n_drv3_salutation_M AS CHAR FORMAT "X(20)"  INIT "". // คนขับ 3 : คำนำหน้า
DEF VAR n_drv3_fname        AS CHAR FORMAT "X(100)" INIT "". // คนขับ 3 : ชื่อ
DEF VAR n_drv3_lname        AS CHAR FORMAT "X(100)" INIT "". // คนขับ 3 : นามสกุล
DEF VAR n_drv3_nid          AS CHAR FORMAT "X(20)"  INIT "". // คนขับ 3 : เลขบัตรประชาชน
DEF VAR n_drv3_occupation   AS CHAR FORMAT "X(50)"  INIT "". // คนขับ 3 : อาชีพ
DEF VAR n_drv3_gender       AS CHAR FORMAT "X(10)"  INIT "". // คนขับ 3 : เพศ
DEF VAR n_drv3_birthdate    AS CHAR FORMAT "X(10)"  INIT "". // คนขับ 3 : วันเกิด
DEF VAR n_drv4_salutation_M AS CHAR FORMAT "X(20)"  INIT "". // คนขับ 4 : คำนำหน้า      
DEF VAR n_drv4_fname        AS CHAR FORMAT "X(100)" INIT "". // คนขับ 4 : ชื่อ          
DEF VAR n_drv4_lname        AS CHAR FORMAT "X(100)" INIT "". // คนขับ 4 : นามสกุล       
DEF VAR n_drv4_nid          AS CHAR FORMAT "X(20)"  INIT "". // คนขับ 4 : เลขบัตรประชาชน
DEF VAR n_drv4_occupation   AS CHAR FORMAT "X(50)"  INIT "". // คนขับ 4 : อาชีพ         
DEF VAR n_drv4_gender       AS CHAR FORMAT "X(10)"  INIT "". // คนขับ 4 : เพศ           
DEF VAR n_drv4_birthdate    AS CHAR FORMAT "X(10)"  INIT "". // คนขับ 4 : วันเกิด       
DEF VAR n_drv5_salutation_M AS CHAR FORMAT "X(20)"  INIT "". // คนขับ 5 : คำนำหน้า      
DEF VAR n_drv5_fname        AS CHAR FORMAT "X(100)" INIT "". // คนขับ 5 : ชื่อ          
DEF VAR n_drv5_lname        AS CHAR FORMAT "X(100)" INIT "". // คนขับ 5 : นามสกุล       
DEF VAR n_drv5_nid          AS CHAR FORMAT "X(20)"  INIT "". // คนขับ 5 : เลขบัตรประชาชน
DEF VAR n_drv5_occupation   AS CHAR FORMAT "X(50)"  INIT "". // คนขับ 5 : อาชีพ         
DEF VAR n_drv5_gender       AS CHAR FORMAT "X(10)"  INIT "". // คนขับ 5 : เพศ           
DEF VAR n_drv5_birthdate    AS CHAR FORMAT "X(10)"  INIT "". // คนขับ 5 : วันเกิด       
DEF VAR n_drv1_dlicense     AS CHAR FORMAT "X(50)"  INIT "". // คนขับ 1 : ทะเบียนรถ
DEF VAR n_drv2_dlicense     AS CHAR FORMAT "X(50)"  INIT "". // คนขับ 2 : ทะเบียนรถ
DEF VAR n_drv3_dlicense     AS CHAR FORMAT "X(50)"  INIT "". // คนขับ 3 : ทะเบียนรถ
DEF VAR n_drv4_dlicense     AS CHAR FORMAT "X(50)"  INIT "". // คนขับ 4 : ทะเบียนรถ
DEF VAR n_drv5_dlicense     AS CHAR FORMAT "X(50)"  INIT "". // คนขับ 5 : ทะเบียนรถ
DEF VAR n_baty_snumber      AS CHAR FORMAT "X(20)"  INIT "". // Battery : Serial Number
DEF VAR n_batydate          AS CHAR FORMAT "X(10)"  INIT "". // Battery : Year
DEF VAR n_baty_rsi          AS CHAR FORMAT "X(20)"  INIT "". // Battery : Replacement SI
DEF VAR n_baty_npremium     AS CHAR FORMAT "X(20)"  INIT "". // Battery : Net Premium
DEF VAR n_baty_gpremium     AS CHAR FORMAT "X(20)"  INIT "". // Battery : Gross_Premium
DEF VAR n_wcharge_snumber   AS CHAR FORMAT "X(20)"  INIT "". // Wall Charge : Serial_Number 
DEF VAR n_wcharge_si        AS CHAR FORMAT "X(20)"  INIT "". // Wall Charge : SI            
DEF VAR n_wcharge_npremium  AS CHAR FORMAT "X(20)"  INIT "". // Wall Charge : Net Premium
DEF VAR n_wcharge_gpremium  AS CHAR FORMAT "X(20)"  INIT "". // Wall Charge : Gross Premium
/*-- End By Tontawan S. A68-0059 27/03/2025 --*/

DEF  STREAM nfile.  



 
 
 
 
 
 






