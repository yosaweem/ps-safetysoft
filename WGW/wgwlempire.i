/*programid   : wgwhcgen.i                                                   */ 
/*programname : load text file HCT to GW                                     */ 
/* Copyright	: Safety Insurance Public Company Limited 			         */ 
/*			      บริษัท ประกันคุ้มภัย จำกัด (มหาชน)				         */ 
/*create by   : Kridtiya i. A52-0172   date . 08/07/2009                     
                ปรับโปรแกรมให้สามารถนำเข้า text file HCT to GW system        */ 
/*copy write  : wgwargen.i                                                   */ 
/* Modify by : Ranu I. A64-0044 date:26/01/2021 ขยายฟอร์แมตตัวแปร            */ 
/* Modify by : Ranu I. a64-0355  Data : 21/10/2021 เพิ่มตัวแปรงาน Co-broker  */ 
/* Modify by : Ranu I. A66-0202  date : 24/10/2023 แก้ไขการเก็บค่าตัวแปร Watt เป็น Decimal
              เพิ่มตัวแปร re_watt  re_acctyp เก็บค่าจากใบเตือน                   */
/* Modify by   : Ranu I. A67-0029 เพิ่มตัวแปรเก็บข้อมูลรถไฟฟ้า             */  
/* Modify by  : Ranu I. F67-0001 เพิ่มการเก็บวันที่คุ้มครองของ พรบ.  */ 
/* Modify by  : Ranu I. A67-0212 แก้เงื่อนไขการเก็บผู้ขับขี่งานต่ออายุ */
/* Modify by : Ranu I. A68-0044 เพิ่มเงื่อนไข ICE */            
/***********************************************************************************/
DEF VAR n_firstdat AS DATE INIT ?.              /*A53-0220*/                  
DEF NEW SHARED VAR nv_producer AS CHAR FORMAT "x(10)".                        
DEF NEW SHARED VAR nv_agent    AS CHAR FORMAT "x(10)".                        
DEF NEW SHARED VAR nv_riskno   Like  sicuw.uwm301.riskgp.                     
DEF NEW SHARED VAR nv_itemno   Like  sicuw.uwm301.itemno.                     
DEF VAR  n_textfi AS CHAR FORMAT  "x(30)" INIT "".    /*A540125*/             
def var  nv_row  as  int  init  0. 
def var  wf_riskno           as char format "x(3)" init "" .  /* Risk No   a64-0355 */                      
def var  wf_num              as char format "x(12)" init "" .  /*ItemNo                                   */                      
def var  wf_policyno         as char format "x(20)" init "" .  /*Policy No (เลขที่กรมธรรม์ภาคสมัครใจ)     */                      
def var  wf_n_branch         as char format "x(20)" init "" .  /*Branch (สาขา)                            */                      
def var  wf_agent            as char format "x(20)" init "" .  /*Agent Code (รหัสตัวแทน)                  */                      
def var  wf_producer         as char format "x(20)" init "" .  /*Producer Code                            */                      
def var  wf_n_delercode      as char format "x(20)" init "" .  /*Dealer Code (รหัสดีเลอร์)                */                      
def var  wf_fincode          as char format "x(20)" init "" .  /*Finance Code (รหัสไฟแนนซ์)               */                      
def var  wf_appenno          as char format "x(20)" init "" .  /*Notification Number (เลขที่รับแจ้ง)      */                      
def var  wf_salename         as char format "x(20)" init "" .  /*Notification Name (ชื่อผู้แจ้ง)          */                      
def var  wf_srate            as char format "x(20)" init "" .  /*Short Rate                               */                      
def var  wf_comdat           as char format "x(20)" init "" .  /*Effective Date (วันที่เริ่มความคุ้มครอง) */                      
def var  wf_expdat           as char format "x(20)" init "" .  /*Expiry Date (วันที่สิ้นสุดความคุ้มครอง)  */                      
def var  wf_agreedat         as char format "x(20)" init "" .  /*Agree Date                               */                      
def var  wf_firstdat         as char format "x(20)" init "" .  /*First Date                               */                      
DEF VAR  wf_packcod          AS CHAR FORMAT "x(10)" INIT "" .  /*รหัส Package   */
def var  wf_camp_no          as char format "x(20)" init "" .  /*Campaign Code (รหัสแคมเปญ)               */                      
def var  wf_campen           as char format "x(20)" init "" .  /*Campaign Text                            */                      
def var  wf_specon           as char format "x(20)" init "" .  /*Spec Con                                 */                      
def var  wf_product          as char format "x(20)" init "" .  /*Product Type                             */                      
def var  wf_promo            as char format "x(20)" init "" .  /*Promotion Code                           */                      
def var  wf_rencnt           as char format "x(20)" init "" .  /*Renew Count                              */                      
def var  wf_prepol           as char format "x(20)" init "" .  /*Previous Policy (เลขทีกรมธรรม์ภาคสมัครใจเดิม)*/                  
def var  wf_txt1             as char format "x(20)" init "" .  /*Policy Text 1  */                     
def var  wf_txt2             as char format "x(20)" init "" .  /*Policy Text 2  */                     
def var  wf_txt3             as char format "x(20)" init "" .  /*Policy Text 3  */                     
def var  wf_txt4             as char format "x(20)" init "" .  /*Policy Text 4  */                     
def var  wf_txt5             as char format "x(20)" init "" .  /*Policy Text 5  */                     
def var  wf_txt6             as char format "x(20)" init "" .  /*Policy Text 6  */                     
def var  wf_txt7             as char format "x(20)" init "" .  /*Policy Text 7  */                     
def var  wf_txt8             as char format "x(20)" init "" .  /*Policy Text 8  */                     
def var  wf_txt9             as char format "x(20)" init "" .  /*Policy Text 9  */                     
def var  wf_txt10            as char format "x(20)" init "" .  /*Policy Text 10 */                     
def var  wf_memo1            as char format "x(20)" init "" .  /*Memo Text 1    */                     
def var  wf_memo2            as char format "x(20)" init "" .  /*Memo Text 2    */                     
def var  wf_memo3            as char format "x(20)" init "" .  /*Memo Text 3    */                     
def var  wf_memo4            as char format "x(20)" init "" .  /*Memo Text 4    */                     
def var  wf_memo5            as char format "x(20)" init "" .  /*Memo Text 5    */                     
def var  wf_memo6            as char format "x(20)" init "" .  /*Memo Text 6    */                     
def var  wf_memo7            as char format "x(20)" init "" .  /*Memo Text 7    */                     
def var  wf_memo8            as char format "x(20)" init "" .  /*Memo Text 8    */                     
def var  wf_memo9            as char format "x(20)" init "" .  /*Memo Text 9    */                     
def var  wf_memo10           as char format "x(20)" init "" .  /*Memo Text 10   */                     
def var  wf_accdata1         as char format "x(20)" init "" .  /*Accessory Text 1 */                     
def var  wf_accdata2         as char format "x(20)" init "" .  /*Accessory Text 2 */                     
def var  wf_accdata3         as char format "x(20)" init "" .  /*Accessory Text 3 */                     
def var  wf_accdata4         as char format "x(20)" init "" .  /*Accessory Text 4 */                     
def var  wf_accdata5         as char format "x(20)" init "" .  /*Accessory Text 5 */                     
def var  wf_accdata6         as char format "x(20)" init "" .  /*Accessory Text 6 */                     
def var  wf_accdata7         as char format "x(20)" init "" .  /*Accessory Text 7 */                     
def var  wf_accdata8         as char format "x(20)" init "" .  /*Accessory Text 8 */                     
def var  wf_accdata9         as char format "x(20)" init "" .  /*Accessory Text 9 */                     
def var  wf_accdata10        as char format "x(20)" init "" .  /*Accessory Text 10*/                     
def var  wf_compul           as char format "x(20)" init "" .  /*กรมธรรม์ซื้อควบ (Y/N)  */ 
def var  wf_insref           as char format "x(20)" init "" .  /*รหัสลูกค้า  A64-0355   */    
def var  wf_instyp           as char format "x(20)" init "" .  /*ประเภทบุคคล            */                     
def var  wf_inslang          as char format "x(20)" init "" .  /*ภาษาที่ใช้สร้าง Cilent Code               */                     
def var  wf_tiname           as char format "x(20)" init "" .  /*คำนำหน้า               */                     
def var  wf_insnam           as char format "x(20)" init "" .  /*ชื่อ                   */                     
def var  wf_lastname         as char format "x(20)" init "" .  /*นามสกุล                */                     
def var  wf_icno             as char format "x(20)" init "" .  /*เลขที่บัตรประชาชน / เลขที่นิติบุคคล       */                     
def var  wf_insbr            as char format "x(20)" init "" .  /*ลำดับที่สาขา           */                     
def var  wf_occup            as char format "x(20)" init "" .  /*อาชีพ                  */                     
def var  wf_addr             as char format "x(20)" init "" .  /*ที่อยู่บรรทัดที่ 1     */                     
def var  wf_tambon           as char format "x(20)" init "" .  /*ที่อยู่บรรทัดที่ 2     */                     
def var  wf_amper            as char format "x(20)" init "" .  /*ที่อยู่บรรทัดที่ 3     */              
def var  wf_country          as char format "x(20)" init "" .  /*ที่อยู่บรรทัดที่ 4     */                
def var  wf_post             as char format "x(20)" init "" .  /*รหัสไปรษณีย์           */                     
def var  wf_provcod          as char format "x(20)" init "" .  /*province code          */                     
def var  wf_distcod          as char format "x(20)" init "" .  /*district code          */                     
def var  wf_sdistcod         as char format "x(20)" init "" .  /*sub district code      */ 
def var  wf_ae               as char format "x(12)" init "" .  /* A64-0355 :  ae  new Xmm600 งาน Japanes*/    
def var  wf_jtl              as char format "x(12)" init "" .  /* A64-0355 :  jtl new Xmm600 งาน Japanes*/    
def var  wf_ts               as char format "x(12)" init "" .  /* A64-0355 :  ts  new Xmm600 งาน Japanes*/    
def var  wf_gender           as char format "x(20)" init "" .  /*Gender (Male/Female/Other)                */                     
def var  wf_tele1            as char format "x(20)" init "" .  /*Telephone 1            */                     
def var  wf_tele2            as char format "x(20)" init "" .  /*Telephone 2            */                
def var  wf_mail1            as char format "x(20)" init "" .  /*E-Mail 1               */                     
def var  wf_mail2            as char format "x(20)" init "" .  /*E-Mail 2               */                     
def var  wf_mail3            as char format "x(20)" init "" .  /*E-Mail 3               */                     
def var  wf_mail4            as char format "x(20)" init "" .  /*E-Mail 4               */                     
def var  wf_mail5            as char format "x(20)" init "" .  /*E-Mail 5               */                     
def var  wf_mail6            as char format "x(20)" init "" .  /*E-Mail 6               */                     
def var  wf_mail7            as char format "x(20)" init "" .  /*E-Mail 7               */                     
def var  wf_mail8            as char format "x(20)" init "" .  /*E-Mail 8               */                     
def var  wf_mail9            as char format "x(20)" init "" .  /*E-Mail 9               */                     
def var  wf_mail10           as char format "x(20)" init "" .  /*E-Mail 10              */                     
def var  wf_fax              as char format "x(20)" init "" .  /*Fax                    */                     
def var  wf_lineID           as char format "x(20)" init "" .  /*Line ID                */                     
def var  wf_name2            as char format "x(20)" init "" .  /*CareOf1                */                     
def var  wf_name3            as char format "x(20)" init "" .  /*CareOf2                */                     
def var  wf_benname          as char format "x(20)" init "" .  /*Benefit Name           */                     
def var  wf_payercod         as char format "x(20)" init "" .  /*Payer Code             */                     
def var  wf_vatcode          as char format "x(20)" init "" .  /*VAT Code               */                     
def var  wf_instcod1         as char format "x(20)" init "" .  /*Client Code            */                     
def var  wf_insttyp1         as char format "x(20)" init "" .  /*ประเภทบุคคล            */                
def var  wf_insttitle1       as char format "x(20)" init "" .  /*คำนำหน้า               */                     
def var  wf_instname1        as char format "x(20)" init "" .  /*ชื่อ                   */                     
def var  wf_instlname1       as char format "x(20)" init "" .  /*นามสกุล                */                     
def var  wf_instic1          as char format "x(20)" init "" .  /*เลขที่บัตรประชาชน / เลขที่นิติบุคคล       */                    
def var  wf_instbr1          as char format "x(20)" init "" .  /*ลำดับที่สาขา           */                     
def var  wf_instaddr11       as char format "x(20)" init "" .  /*ที่อยู่บรรทัดที่ 1     */                     
def var  wf_instaddr21       as char format "x(20)" init "" .  /*ที่อยู่บรรทัดที่ 2     */                     
def var  wf_instaddr31       as char format "x(20)" init "" .  /*ที่อยู่บรรทัดที่ 3     */                     
def var  wf_instaddr41       as char format "x(20)" init "" .  /*ที่อยู่บรรทัดที่ 4     */                     
def var  wf_instpost1        as char format "x(20)" init "" .  /* รหัสไปรษณีย์          */                     
def var  wf_instprovcod1     as char format "x(20)" init "" .  /*province code          */                     
def var  wf_instdistcod1     as char format "x(20)" init "" .  /*district code          */                     
def var  wf_instsdistcod1    as char format "x(20)" init "" .  /*sub district code      */                     
def var  wf_instprm1         as char format "x(20)" init "" .  /*เบี้ยก่อนภาษีอากร      */                     
def var  wf_instrstp1        as char format "x(20)" init "" .  /*อากร                   */                     
def var  wf_instrtax1        as char format "x(20)" init "" .  /*ภาษี                   */                     
def var  wf_instcomm01       as char format "x(20)" init "" .  /*คอมมิชชั่น 1           */                     
def var  wf_instcomm12       as char format "x(20)" init "" .  /*คอมมิชชั่น 2 (co-broker)     */                     
def var  wf_instcod2         as char format "x(20)" init "" .  /*Client Code            */    
def var  wf_insttyp2         as char format "x(20)" init "" .  /*ประเภทบุคคล            */    
def var  wf_insttitle2       as char format "x(20)" init "" .  /*คำนำหน้า               */    
def var  wf_instname2        as char format "x(20)" init "" .  /*ชื่อ                   */    
def var  wf_instlname2       as char format "x(20)" init "" .  /*นามสกุล                */    
def var  wf_instic2          as char format "x(20)" init "" .  /*เลขที่บัตรประชาชน / เลขที่นิติบุคคล*/                     
def var  wf_instbr2          as char format "x(20)" init "" .  /*ลำดับที่สาขา           */          
def var  wf_instaddr12       as char format "x(20)" init "" .  /*ที่อยู่บรรทัดที่ 1     */          
def var  wf_instaddr22       as char format "x(20)" init "" .  /*ที่อยู่บรรทัดที่ 2     */          
def var  wf_instaddr32       as char format "x(20)" init "" .  /*ที่อยู่บรรทัดที่ 3     */          
def var  wf_instaddr42       as char format "x(20)" init "" .  /*ที่อยู่บรรทัดที่ 4     */          
def var  wf_instpost2        as char format "x(20)" init "" .  /*รหัสไปรษณีย์           */          
def var  wf_instprovcod2     as char format "x(20)" init "" .  /*province code          */          
def var  wf_instdistcod2     as char format "x(20)" init "" .  /*district code          */          
def var  wf_instsdistcod2    as char format "x(20)" init "" .  /*sub district code      */          
def var  wf_instprm2         as char format "x(20)" init "" .  /*เบี้ยก่อนภาษีอากร      */          
def var  wf_instrstp2        as char format "x(20)" init "" .  /*อากร                   */          
def var  wf_instrtax2        as char format "x(20)" init "" .  /*ภาษี                   */          
def var  wf_instcomm02       as char format "x(20)" init "" .  /*คอมมิชชั่น 1           */          
def var  wf_instcomm22       as char format "x(20)" init "" .  /*คอมมิชชั่น 2 (co-broker)     */    
def var  wf_instcod3         as char format "x(20)" init "" .  /*Client Code            */          
def var  wf_insttyp3         as char format "x(20)" init "" .  /*ประเภทบุคคล            */          
def var  wf_insttitle3       as char format "x(20)" init "" .  /*คำนำหน้า               */          
def var  wf_instname3        as char format "x(20)" init "" .  /*ชื่อ                   */          
def var  wf_instlname3       as char format "x(20)" init "" .  /*นามสกุล                */          
def var  wf_instic3          as char format "x(20)" init "" .  /*เลขที่บัตรประชาชน/เลขที่นิติบุคคล  */                     
def var  wf_instbr3          as char format "x(20)" init "" .  /*ลำดับที่สาขา          */                     
def var  wf_instaddr13       as char format "x(20)" init "" .  /*ที่อยู่บรรทัดที่ 1    */                     
def var  wf_instaddr23       as char format "x(20)" init "" .  /*ที่อยู่บรรทัดที่ 2    */                     
def var  wf_instaddr33       as char format "x(20)" init "" .  /*ที่อยู่บรรทัดที่ 3    */                     
def var  wf_instaddr43       as char format "x(20)" init "" .  /*ที่อยู่บรรทัดที่ 4    */                     
def var  wf_instpost3        as char format "x(20)" init "" .  /*รหัสไปรษณีย์          */                     
def var  wf_instprovcod3     as char format "x(20)" init "" .  /*province code         */                     
def var  wf_instdistcod3     as char format "x(20)" init "" .  /*district code         */                     
def var  wf_instsdistcod3    as char format "x(20)" init "" .  /*sub district code     */                     
def var  wf_instprm3         as char format "x(20)" init "" .  /*เบี้ยก่อนภาษีอากร     */              
def var  wf_instrstp3        as char format "x(20)" init "" .  /*อากร                  */                                     
def var  wf_instrtax3        as char format "x(20)" init "" .  /*ภาษี                  */              
DEF VAR  wf_instcomm03       as char format "x(20)" init "" .  /*คอมมิชชั่น 1          */              
DEF VAR  wf_instcomm23       as char format "x(20)" init "" .  /*คอมมิชชั่น 2 (co-broker)                  */              
DEF VAR  wf_covcod           as char format "x(20)" init "" .  /*Cover Type (ประเภทความคุ้มครอง)           */              
DEF VAR  wf_garage           as char format "x(20)" init "" .  /*Garage (ประเภทการซ่อม ซ่อมอู่/ซ่อมห้าง)   */              
DEF VAR  wf_special          as char format "x(20)" init "" .  /*Spacial Equipment Flag(A/Blank)*/              
DEF VAR  wf_inspec           as char format "x(20)" init "" .  /*Inspection            */       
DEF VAR  wf_class70          as char format "x(20)" init "" .  /*รหัสรถภาคสมัครใจ (110/120/…)   */              
DEF VAR  wf_vehuse           as char format "x(2)" init "" . /* A64-0355 : vehuse 15/12/2021 */
DEF VAR  wf_redbook          as char format "x(20)" init "" .  /*redbook    */  /*a65-0079*/      
DEF VAR  wf_brand            as char format "x(20)" init "" .  /*ยี่ห้อรถ              */       
DEF VAR  wf_model            as char format "x(20)" init "" .  /*ชื่อรุ่นรถ            */       
DEF VAR  wf_submodel         as char format "x(20)" init "" .  /*ชื่อรุ่นย่อยรถ        */       
DEF VAR  wf_caryear          as char format "x(20)" init "" .  /*ปีรุ่นรถ              */       
DEF VAR  wf_chasno           as char format "x(20)" init "" .  /*หมายเลขตัวถัง         */       
DEF VAR  wf_eng              as char format "x(20)" init "" .  /*หมายเลขเครื่อง        */       
DEF VAR  wf_seat             as char format "x(20)" init "" .  /*จำนวนที่นั่ง (รวมผู้ขับขี่)    */              
DEF VAR  wf_engcc            as char format "x(20)" init "" .  /*ปริมาตรกระบอกสูบ (CC) */              
DEF VAR  wf_weight           as char format "x(20)" init "" .  /*น้ำหนัก (ตัน)         */              
DEF VAR  wf_watt             as char format "x(20)" init "" .  /*Kilowatt              */              
DEF VAR  wf_body             as char format "x(20)" init "" .  /*รหัสแบบตัวถัง         */              
DEF VAR  wf_type             as char format "x(20)" init "" .  /*ป้ายแดง (Y/N)         */              
DEF VAR  wf_re_year          as char format "x(20)" init "" .  /*ปีที่จดทะเบียน        */              
DEF VAR  wf_vehreg           as char format "x(20)" init "" .  /*เลขทะเบียนรถ          */              
DEF VAR  wf_re_country       as char format "x(20)" init "" .  /*จังหวัดที่จดทะเบียน   */              
DEF VAR  wf_cargrp           as char format "x(20)" init "" .  /*Group Car (กลุ่มรถ)   */              
DEF VAR  wf_colorcar         as char format "x(20)" init "" .  /*Color (สี)            */              
DEF VAR  wf_fule             as char format "x(20)" init "" .  /*Fule (เชื้อเพลิง)     */              
DEF VAR  wf_drivnam          as char format "x(2)" init "" .   /*Driver Number          */              
DEF VAR  wf_ntitle1          as char format "x(20)" init "" .  /*คำนำหน้า              */              
DEF VAR  wf_drivername1      as char format "x(20)" init "" .  /*ชื่อ                  */              
DEF VAR  wf_dname2           as char format "x(20)" init "" .  /*นามสกุล               */              
DEF VAR  wf_dicno            as char format "x(20)" init "" .  /*เลขที่บัตรประชาชน     */              
DEF VAR  wf_dgender1         as char format "x(20)" init "" .  /*เพศ                   */              
DEF VAR  wf_dbirth           as char format "x(20)" init "" .  /*วันเกิด               */              
DEF VAR  wf_doccup           as char format "x(20)" init "" .  /*ชื่ออาชีพ             */              
DEF VAR  wf_ddriveno         as char format "x(20)" init "" .  /*เลขที่ใบอนุญาตขับขี่  */            
DEF VAR  wf_ntitle2          as char format "x(20)" init "" .  /*คำนำหน้า              */              
DEF VAR  wf_drivername2      as char format "x(20)" init "" .  /*ชื่อ                  */              
DEF VAR  wf_ddname1          as char format "x(20)" init "" .  /*นามสกุล               */              
DEF VAR  wf_ddicno           as char format "x(20)" init "" .  /*เลขที่บัตรประชาชน     */              
DEF VAR  wf_dgender2         as char format "x(20)" init "" .  /*เพศ                   */              
DEF VAR  wf_ddbirth          as char format "x(20)" init "" .  /*วันเกิด               */              
DEF VAR  wf_ddoccup          as char format "x(20)" init "" .  /*ชื่ออาชีพ             */              
DEF VAR  wf_dddriveno        as char format "x(20)" init "" .  /*เลขที่ใบอนุญาตขับขี่  */              
DEF VAR  wf_baseplus         as char format "x(20)" init "" .  /*Base Premium Plus     */              
DEF VAR  wf_siplus           as char format "x(20)" init "" .  /*Sum Insured Plus      */              
DEF VAR  wf_rs10             as char format "x(20)" init "" .  /*RS10 Amount           */              
DEF VAR  wf_comper           as char format "x(20)" init "" .  /*TPBI / person         */              
DEF VAR  wf_comacc           as char format "x(20)" init "" .  /*TPBI / occurrence     */              
DEF VAR  wf_deductpd         as char format "x(20)" init "" .  /*TPPD                  */              
DEF VAR  wf_DOD              as char format "x(20)" init "" .  /*Deduct / OD           */
DEF VAR  wf_DOD1             as char format "x(20)" init "" .  /*Deduct / dod1         */   /*A65-0079*/
DEF VAR  wf_DPD              as char format "x(20)" init "" .  /*Deduct / PD           */              
DEF VAR  wf_tpfire           as char format "x(20)" init "" .  /*Theft & Fire          */              
DEF VAR  wf_NO_41            as char format "x(20)" init "" .  /*PA1.1 / driver        */              
DEF VAR  wf_ac2              as char format "x(20)" init "" .  /*PA1.1 no.of passenger */              
DEF VAR  wf_ac4              as char format "x(20)" init "" .  /*PA1.1 / passenger     */              
DEF VAR  wf_ac5              as char format "x(20)" init "" .  /*PA1.2 / driver        */              
DEF VAR  wf_ac6              as char format "x(20)" init "" .  /*PA1.2 no.of passenger */              
DEF VAR  wf_ac7              as char format "x(20)" init "" .  /*PA1.2 / passenger     */              
DEF VAR  wf_NO_42            as char format "x(20)" init "" .  /*PA2                   */              
DEF VAR  wf_NO_43            as char format "x(20)" init "" .  /*PA3                   */              
DEF VAR  wf_base             as char format "x(20)" init "" .  /*Base Premium          */              
DEF VAR  wf_unname           as char format "x(20)" init "" .  /*Unname                */              
DEF VAR  wf_nname            as char format "x(20)" init "" .  /*Name                  */              
DEF VAR  wf_tpbi             as char format "x(20)" init "" .  /*TPBI/Person Amount    */   
DEF VAR  wf_bi2              AS CHAR FORMAT "x(20)" INIT "" .  /*TPBI/occurance Amount */  /*A64-0355 :28/01/20222 */   
DEF VAR  wf_tppd             as char format "x(20)" init "" .  /*TPPD Amount           */ 
def var  wf_dodamt           as char format "x(20)" init "" .   /* dod premt */             /*A65-0079*/
def var  wf_dod1amt          as char format "x(20)" init "" .   /* dod1 premt */            /*A65-0079*/
def var  wf_dpdamt           as char format "x(20)" init "" .   /* dpd premt */             /*A65-0079*/
DEF VAR  wf_ry01             as char format "x(20)" init "" .  /*RY411 Amount           */ 
DEF VAR  wf_ry412            as char format "x(20)" init "" .  /*RY412 Amount           */  /*A64-0355 26/01/2022 */
DEF VAR  wf_ry413            as char format "x(20)" init "" .  /*RY413 Amount           */  /*A64-0355 26/01/2022 */
DEF VAR  wf_ry414            as char format "x(20)" init "" .  /*RY414 Amount           */  /*A64-0355 26/01/2022 */
DEF VAR  wf_ry02             as char format "x(20)" init "" .  /*RY02 Amount           */              
DEF VAR  wf_ry03             as char format "x(20)" init "" .  /*RY03 Amount           */              
DEF VAR  wf_fleet            as char format "x(20)" init "" .  /*Fleet%                */              
DEF VAR  wf_ncb              as char format "x(20)" init "" .  /*NCB%                  */              
DEF VAR  wf_claim            as char format "x(20)" init "" .  /*Load Claim%           */              
DEF VAR  wf_dspc             as char format "x(20)" init "" .  /*Other Disc.%          */              
DEF VAR  wf_cctv             as char format "x(20)" init "" .  /*CCTV%                 */              
DEF VAR  wf_dstf             as char format "x(20)" init "" .  /*Walkin Disc.%         */              
DEF VAR  wf_fleetprem        as char format "x(20)" init "" .  /*Fleet Amount          */              
DEF VAR  wf_ncbprem          as char format "x(20)" init "" .  /*NCB Amount            */              
DEF VAR  wf_clprem           as char format "x(20)" init "" .  /*Load Claim Amount     */              
DEF VAR  wf_dspcprem         as char format "x(20)" init "" .  /*Other Disc. Amount    */              
DEF VAR  wf_cctvprem         as char format "x(20)" init "" .  /*CCTV Amount           */              
DEF VAR  wf_dstfprem         as char format "x(20)" init "" .  /*Walk in Disc. Amount  */              
DEF VAR  wf_premt            as char format "x(20)" init "" .  /*เบี้ยสุทธิ            */              
DEF VAR  wf_rstp_t           as char format "x(20)" init "" .  /*Stamp Duty            */              
DEF VAR  wf_rtax_t           as char format "x(20)" init "" .  /*VAT                   */              
DEF VAR  wf_comper70         as char format "x(20)" init "" .  /*Commission %          */              
DEF VAR  wf_comprem70        as char format "x(20)" init "" .  /*Commission Amount     */              
DEF VAR  wf_agco70           as char format "x(20)" init "" .  /*Agent Code co-broker (รหัสตัวแทน)*/              
DEF VAR  wf_comco_per70      as char format "x(20)" init "" .  /*Commission % co-broker*/         
DEF VAR  wf_comco_prem70     as char format "x(20)" init "" .  /*Commission Amount co-broker*/              
DEF VAR  wf_dgpackge         as char format "x(20)" init "" .  /*Package (Attach Coverage)  */              
DEF VAR  wf_danger1          as char format "x(20)" init "" .  /*Dangerous Object 1    */   
DEF VAR  wf_danger2          as char format "x(20)" init "" .  /*Dangerous Object 2    */   
DEF VAR  wf_dgsi             as char format "x(20)" init "" .  /*Sum Insured           */   
DEF VAR  wf_dgrate           as char format "x(20)" init "" .  /*Rate%                 */   
DEF VAR  wf_dgfeet           as char format "x(20)" init "" .  /*Fleet%                */   
DEF VAR  wf_dgncb            as char format "x(20)" init "" .  /*NCB%                  */   
DEF VAR  wf_dgdisc           as char format "x(20)" init "" .  /*Discount%             */ 
DEF VAR  wf_dgwdisc          as char format "x(20)" init "" .  /*Walkin Discount%        */ 
DEF VAR  wf_dgatt            as char format "x(20)" init "" .  /*Premium Attach Coverage */              
DEF VAR  wf_dgfeetprm        as char format "x(20)" init "" .  /*Discount Fleet        */   
DEF VAR  wf_dgncbprm         as char format "x(20)" init "" .  /*Discount NCB          */   
DEF VAR  wf_dgdiscprm        as char format "x(20)" init "" .  /*Other Discount        */  
DEF VAR  wf_dgWdiscprm        as char format "x(20)" init "" .  /*Other Discount        */   
DEF VAR  wf_dgprem           as char format "x(20)" init "" .  /*Net Premium           */ 
DEF VAR  wf_dgrstp_t         as char format "x(20)" init "" .  /*Stamp Duty            */                
DEF VAR  wf_dgrtax_t         as char format "x(20)" init "" .  /*VAT                   */                
DEF VAR  wf_dgcomper         as char format "x(20)" init "" .  /*Commission %          */                
DEF VAR  wf_dgcomprem        as char format "x(20)" init "" .  /*Commission Amount     */    
DEF VAR  wf_cltxt            as char format "x(20)" init "" .  /*Claim Text            */   
DEF VAR  wf_clamount         as char format "x(20)" init "" .  /*Claim Amount          */   
DEF VAR  wf_faultno          as char format "x(20)" init "" .  /*Claim Count Fault     */   
DEF VAR  wf_faultprm         as char format "x(20)" init "" .  /*Claim Count Fault Amount   */              
DEF VAR  wf_goodno           as char format "x(20)" init "" .  /*Claim Count Good           */              
DEF VAR  wf_goodprm          as char format "x(20)" init "" .  /*Claim Count Good Amount    */              
DEF VAR  wf_loss             as char format "x(20)" init "" .  /*Loss Ratio % (Not TP)      */              
DEF VAR  wf_compolusory      as char format "x(20)" init "" .  /*Compulsory Policy Number (เลขที่กรมธรรม์ พรบ.)*/          
DEF VAR  wf_barcode          as char format "x(20)" init "" .  /*Barcode No.                    */                
DEF VAR  wf_class72          as char format "x(20)" init "" .  /*Compulsory Class (รหัส พรบ.)   */                
DEF VAR  wf_dstf72           as char format "x(20)" init "" .  /*Compulsory Walk In Discount %  */                
DEF VAR  wf_dstfprem72       as char format "x(20)" init "" .  /*Compulsory Walk In Discount Amount      */                
DEF VAR  wf_premt72          as char format "x(20)" init "" .  /*เบี้ยสุทธิ พ.ร.บ. กรณี "กรมธรรม์ซื้อควบ"*/                
DEF VAR  wf_rstp_t72         as char format "x(20)" init "" .  /*Stamp Duty            */                
DEF VAR  wf_rtax_t72         as char format "x(20)" init "" .  /*VAT                   */                
DEF VAR  wf_comper72         as char format "x(20)" init "" .  /*Commission %          */                
DEF VAR  wf_comprem72        as char format "x(20)" init "" .  /*Commission Amount     */    
DEF VAR  wf_instot           AS INT INIT 0.
/* Add by : A67-0029 */
DEF VAR wf_drivexp1         AS CHAR FORMAT "X(13)" INIT "" .    /*เลขที่ใบอนุญาตขับขี่ หมดอายุ */ 
DEF VAR wf_dconsen1         AS CHAR FORMAT "x(5)" INIT "" .
DEF VAR wf_dlevel1          AS CHAR FORMAT "X(2)" INIT ""  .   /*ระดับผู้ขับขี่ */ 
DEF VAR wf_drivexp2         AS CHAR FORMAT "X(13)" INIT "" .    /*เลขที่ใบอนุญาตขับขี่ หมดอายุ */
DEF VAR wf_dconsen2         AS CHAR FORMAT "x(5)" INIT "" . 
DEF VAR wf_dlevel2          AS CHAR FORMAT "X(2)" INIT ""  .   /*ระดับผู้ขับขี่ */ 

DEF VAR wf_ntitle3          AS CHAR FORMAT "X(20)" INIT "" .    /*คำนำหน้า              */  
DEF VAR wf_dname3           AS CHAR FORMAT "X(50)" INIT "" .    /*ชื่อ                  */                        
DEF VAR wf_dlname3          AS CHAR FORMAT "X(50)" INIT "" .    /*นามสกุล               */                        
DEF VAR wf_dicno3           AS CHAR FORMAT "X(13)" INIT "" .    /*เลขที่บัตรประชาชน     */                        
DEF VAR wf_dgender3         AS CHAR FORMAT "X(20)" INIT "" .    /*เพศ                   */                        
DEF VAR wf_dbirth3          AS CHAR FORMAT "X(15)" INIT "" .    /*วันเกิด               */                        
DEF VAR wf_doccup3          AS CHAR FORMAT "X(20)" INIT "" .    /*ชื่ออาชีพ             */                        
DEF VAR wf_ddriveno3        AS CHAR FORMAT "X(13)" INIT "" .    /*เลขที่ใบอนุญาตขับขี่  */  
DEF VAR wf_drivexp3         AS CHAR FORMAT "X(13)" INIT "" .    /*เลขที่ใบอนุญาตขับขี่ หมดอายุ */ 
DEF VAR wf_dconsen3         AS CHAR FORMAT "x(5)" INIT "" .
DEF VAR wf_dlevel3          AS CHAR FORMAT "X(2)" INIT ""  .   /*ระดับผู้ขับขี่ */ 

DEF VAR wf_ntitle4          AS CHAR FORMAT "X(20)" INIT "" .    /*คำนำหน้า              */                        
DEF VAR wf_dname4           AS CHAR FORMAT "X(50)" INIT "" .    /*ชื่อ                  */                        
DEF VAR wf_dlname4          AS CHAR FORMAT "X(50)" INIT "" .    /*นามสกุล               */                        
DEF VAR wf_dicno4           AS CHAR FORMAT "X(13)" INIT "" .    /*เลขที่บัตรประชาชน     */                        
DEF VAR wf_dgender4         AS CHAR FORMAT "X(20)" INIT "" .    /*เพศ                   */                        
DEF VAR wf_dbirth4          AS CHAR FORMAT "X(15)" INIT "" .    /*วันเกิด               */                        
DEF VAR wf_doccup4          AS CHAR FORMAT "X(20)" INIT "" .    /*ชื่ออาชีพ             */                        
DEF VAR wf_ddriveno4        AS CHAR FORMAT "X(13)" INIT "" .    /*เลขที่ใบอนุญาตขับขี่  */  
DEF VAR wf_drivexp4         AS CHAR FORMAT "X(13)" INIT "" .    /*เลขที่ใบอนุญาตขับขี่ หมดอายุ */
DEF VAR wf_dconsen4         AS CHAR FORMAT "x(5)" INIT "" .
DEF VAR wf_dlevel4          AS CHAR FORMAT "X(2)" INIT ""  .   /*ระดับผู้ขับขี่ */ 

DEF VAR wf_ntitle5          AS CHAR FORMAT "X(20)" INIT "" .    /*คำนำหน้า              */                        
DEF VAR wf_dname5           AS CHAR FORMAT "X(50)" INIT "" .    /*ชื่อ                  */                        
DEF VAR wf_dlname5          AS CHAR FORMAT "X(50)" INIT "" .    /*นามสกุล               */                        
DEF VAR wf_dicno5           AS CHAR FORMAT "X(13)" INIT "" .    /*เลขที่บัตรประชาชน     */                        
DEF VAR wf_dgender5         AS CHAR FORMAT "X(20)" INIT "" .    /*เพศ                   */                        
DEF VAR wf_dbirth5          AS CHAR FORMAT "X(15)" INIT "" .    /*วันเกิด               */                        
DEF VAR wf_doccup5          AS CHAR FORMAT "X(20)" INIT "" .    /*ชื่ออาชีพ             */                        
DEF VAR wf_ddriveno5        AS CHAR FORMAT "X(13)" INIT "" .    /*เลขที่ใบอนุญาตขับขี่  */  
DEF VAR wf_drivexp5         AS CHAR FORMAT "X(13)" INIT "" .    /*เลขที่ใบอนุญาตขับขี่ หมดอายุ */
DEF VAR wf_dconsen5         AS CHAR FORMAT "x(5)" INIT "" .
DEF VAR wf_dlevel5          AS CHAR FORMAT "X(2)" INIT ""  .   /*ระดับผู้ขับขี่ */ 

def var  wf_maksi            as char format "X(20)" init "" .
def var  wf_eng_no2          as char format "X(20)" init "" .
def var  wf_battper          as char format "X(20)" init "" .
def var  wf_battrate         as char format "X(20)" init "" .
def var  wf_battyr           as char format "X(20)" init "" .
def var  wf_battsi           as char format "X(20)" init "" .
def var  wf_battprice        as char format "X(20)" init "" .
def var  wf_battno           as char format "X(20)" init "" .
def var  wf_battprm          as char format "X(20)" init "" .
def var  wf_chargno          as char format "X(20)" init "" .
def var  wf_chargsi          as char format "X(20)" init "" .
def var  wf_chargrate        as char format "X(20)" init "" .
def var  wf_chargprm         as char format "X(20)" init "" .
/* end : A67-0029 */
DEF VAR  wf_comdat72         AS CHAR FORMAT "x(20)" INIT "" . /*F67-0001*/
DEF VAR  wf_expdat72         AS CHAR FORMAT "x(20)" INIT "" . /*F67-0001*/
/*A68-0044*/
DEF VAR  wf_31rate           AS CHAR FORMAT "x(10)" INIT "" . 
DEF VAR  wf_31prmt           AS CHAR FORMAT "x(10)" INIT "" . 
/*A68-0044*/

DEFINE TEMP-TABLE wdetail 
  FIELD   riskno         AS CHAR FORMAT "x(3)"  INIT ""     /* risk no */ /*A64-0355*/
  FIELD   itemNo         AS CHAR FORMAT "x(10)" INIT ""     /*item no */                    
  FIELD   policyno       AS CHAR FORMAT "X(16)" INIT ""     /*Policy No (เลขที่กรมธรรม์ภาคสมัครใจ)*/          
  FIELD   n_branch       AS CHAR FORMAT "X(2)" INIT ""      /*Branch (สาขา)                       */          
  FIELD   agent          AS CHAR FORMAT "X(10)" INIT ""     /*Agent Code (รหัสตัวแทน)             */          
  FIELD   producer       AS CHAR FORMAT "X(10)" INIT ""     /*Producer Code                       */          
  FIELD   n_delercode    AS CHAR FORMAT "X(10)" INIT ""     /*Dealer Code (รหัสดีเลอร์)           */          
  FIELD   fincode        AS CHAR FORMAT "X(10)" INIT ""     /*Finance Code (รหัสไฟแนนซ์)          */          
  FIELD   appenno        AS CHAR FORMAT "X(20)" INIT ""     /*Notification Number (เลขที่รับแจ้ง) */          
  FIELD   salename       AS CHAR FORMAT "X(50)" INIT ""     /*Notification Name (ชื่อผู้แจ้ง)     */          
  FIELD   srate          AS CHAR FORMAT "X(20)" INIT ""     /*Short Rate                          */          
  FIELD   comdat         AS date FORMAT "99/99/9999" INIT "?"     /*Effective Date (วันที่เริ่มความคุ้มครอง)*/      
  FIELD   expdat         AS date FORMAT "99/99/9999" INIT "?"     /*Expiry Date (วันที่สิ้นสุดความคุ้มครอง) */      
  FIELD   agreedat       AS date FORMAT "99/99/9999" INIT "?"     /*Agree Date                 */                   
  FIELD   firstdat       AS date FORMAT "99/99/9999" INIT "?"     /*First Date                 */                   
  FIELD   packcod        AS CHAR FORMAT "x(10)" INIT "?"    /*รหัสแพ็คเกจ */
  FIELD   camp_no        AS CHAR FORMAT "X(20)" INIT ""     /*Campaign Code (รหัสแคมเปญ) */                   
  FIELD   campen         AS CHAR FORMAT "X(20)" INIT ""     /*Campaign Text              */                   
  FIELD   specon         AS CHAR FORMAT "X(20)" INIT ""     /*Spec Con                   */                   
  FIELD   product        AS CHAR FORMAT "X(20)" INIT ""     /*Product Type               */                   
  FIELD   promo          AS CHAR FORMAT "X(20)" INIT ""     /*Promotion Code             */                   
  FIELD   rencnt         AS CHAR FORMAT "99"     INIT "0"   /*Renew Count                */                   
  FIELD   prepol         AS CHAR FORMAT "X(20)"  INIT ""    /*Previous Policy (เลขทีกรมธรรม์ภาคสมัครใจเดิม)*/   /* wtxt */ /* wmemo */ /* wacces */  
  FIELD   compul         AS CHAR FORMAT "X(1)"   INIT ""    /*กรมธรรม์ซื้อควบ (Y/N) */                        
  FIELD   instyp         AS CHAR FORMAT "X(2)"   INIT ""    /*ประเภทบุคคล           */                        
  FIELD   inslang        AS CHAR FORMAT "X(1)"   INIT ""    /*ภาษาที่ใช้สร้าง Cilent Code*/                   
  FIELD   tiname         AS CHAR FORMAT "X(50)"  INIT ""    /*คำนำหน้า                   */                   
  FIELD   insnam         AS CHAR FORMAT "X(100)" INIT ""    /*ชื่อ                       */                   
  FIELD   lastname       AS CHAR FORMAT "X(100)" INIT ""    /*นามสกุล                    */                   
  FIELD   icno           AS CHAR FORMAT "X(13)"  INIT ""    /*เลขที่บัตรประชาชน / เลขที่นิติบุคคล   */        
  FIELD   insbr          AS CHAR FORMAT "X(4)"   INIT ""    /*ลำดับที่สาขา               */                   
  FIELD   occup          AS CHAR FORMAT "X(10)"  INIT ""    /*อาชีพ                      */                   
  FIELD   addr           AS CHAR FORMAT "X(50)"  INIT ""    /*ที่อยู่บรรทัดที่ 1         */                   
  FIELD   tambon         AS CHAR FORMAT "X(50)"  INIT ""    /*ที่อยู่บรรทัดที่ 2         */                   
  FIELD   amper          AS CHAR FORMAT "X(50)"  INIT ""    /*ที่อยู่บรรทัดที่ 3         */                   
  FIELD   country        AS CHAR FORMAT "X(50)"  INIT ""    /*ที่อยู่บรรทัดที่ 4         */                   
  FIELD   post           AS CHAR FORMAT "X(5)"   INIT ""    /*รหัสไปรษณีย์               */                   
  FIELD   provcod        AS CHAR FORMAT "X(2)"   INIT ""    /*province code              */                   
  FIELD   distcod        AS CHAR FORMAT "X(2)"   INIT ""    /*district code              */                   
  FIELD   sdistcod       AS CHAR FORMAT "X(2)"   INIT ""    /*sub district code          */ 
  field   jpae           as char format "x(12)"            /*A64-0355*/      
  field   jpjtl          as char format "x(12)"            /*A64-0355*/      
  field   jpts           as char format "x(12)"            /*A64-0355*/      
  FIELD   gender         AS CHAR FORMAT "X(20)" INIT ""     /*Gender (Male/Female/Other) */                   
  FIELD   tele1          AS CHAR FORMAT "X(20)" INIT ""     /*Telephone 1     */                              
  FIELD   tele2          AS CHAR FORMAT "X(20)" INIT ""     /*Telephone 2     */                              
  FIELD   mail1          AS CHAR FORMAT "X(20)" INIT ""     /*E-Mail 1        */                              
  FIELD   mail2          AS CHAR FORMAT "X(20)" INIT ""     /*E-Mail 2        */                              
  FIELD   mail3          AS CHAR FORMAT "X(20)" INIT ""     /*E-Mail 3        */                              
  FIELD   mail4          AS CHAR FORMAT "X(20)" INIT ""     /*E-Mail 4        */                              
  FIELD   mail5          AS CHAR FORMAT "X(20)" INIT ""     /*E-Mail 5        */                              
  FIELD   mail6          AS CHAR FORMAT "X(20)" INIT ""     /*E-Mail 6        */                              
  FIELD   mail7          AS CHAR FORMAT "X(20)" INIT ""     /*E-Mail 7        */                              
  FIELD   mail8          AS CHAR FORMAT "X(20)" INIT ""     /*E-Mail 8        */                              
  FIELD   mail9          AS CHAR FORMAT "X(20)" INIT ""     /*E-Mail 9        */                              
  FIELD   mail10         AS CHAR FORMAT "X(20)" INIT ""     /*E-Mail 10       */                              
  FIELD   fax            AS CHAR FORMAT "X(20)" INIT ""     /*Fax             */                              
  FIELD   lineID         AS CHAR FORMAT "X(20)" INIT ""     /*Line ID         */                              
  FIELD   name2          AS CHAR FORMAT "X(100)" INIT ""    /*CareOf1         */                              
  FIELD   name3          AS CHAR FORMAT "X(100)" INIT ""    /*CareOf2         */                              
  FIELD   benname        AS CHAR FORMAT "X(20)" INIT ""     /*Benefit Name    */                              
  FIELD   payercod       AS CHAR FORMAT "X(10)" INIT ""     /*Payer Code      */                              
  FIELD   vatcode        AS CHAR FORMAT "X(10)" INIT ""     /*VAT Code        */  /*  winst */  
  FIELD   covcod         AS CHAR FORMAT "X(3)" INIT ""      /*Cover Type (ประเภทความคุ้มครอง)   */            
  FIELD   garage         AS CHAR FORMAT "X(2)" INIT ""      /*Garage (ประเภทการซ่อม ซ่อมอู่/ซ่อมห้าง) */      
  FIELD   special        AS CHAR FORMAT "X(2)" INIT ""      /*Spacial Equipment Flag (A/Blank)*/              
  FIELD   inspec         AS CHAR FORMAT "X(2)" INIT ""      /*Inspection                      */              
  /*FIELD   class70        AS CHAR FORMAT "X(4)" INIT ""    /*รหัสรถภาคสมัครใจ (110/120/320)  */*/  /*A64-0044 26/01/2020 */
  FIELD   class70        AS CHAR FORMAT "X(5)"  INIT ""      /*รหัสรถภาคสมัครใจ (110/120/320)  */      /*A64-0044 26/01/2020 */
  FIELD   brand          AS CHAR FORMAT "X(30)" INIT ""     /*ยี่ห้อรถ          */                            
  FIELD   model          AS CHAR FORMAT "X(50)" INIT ""     /*ชื่อรุ่นรถ        */                            
  FIELD   submodel       AS CHAR FORMAT "X(20)" INIT ""     /*ชื่อรุ่นย่อยรถ    */                            
  FIELD   yrmanu         AS CHAR FORMAT "X(4)"  INIT ""      /*ปีรุ่นรถ          */                            
  FIELD   chasno         AS CHAR FORMAT "X(20)" INIT ""     /*หมายเลขตัวถัง     */                            
  FIELD   eng            AS CHAR FORMAT "X(20)" INIT ""     /*หมายเลขเครื่อง    */                            
  FIELD   seat           AS INTE INIT 0 /*format ">9" */    /*จำนวนที่นั่ง (รวมผู้ขับขี่)*/                   
  FIELD   engcc          AS inte INIT 0 format ">>>9"       /*ปริมาตรกระบอกสูบ (CC)      */                   
  FIELD   weight         AS DECI INIT 0 format ">>>>>9.99"  /*น้ำหนัก (ตัน)         */                        
  /*FIELD   watt           AS inte INIT 0 format ">>>>>>9"    /*Kilowatt              */ */ /* A66-0202 */  
  FIELD   watt           AS DECI INIT 0 format ">>>>9.99"    /*Kilowatt              */  /* A66-0202 */
  FIELD   body           AS CHAR FORMAT "X(50)" INIT ""     /*รหัสแบบตัวถัง         */                        
  FIELD   typ            AS CHAR FORMAT "X(2)" INIT ""      /*ป้ายแดง (Y/N)         */                        
  FIELD   re_year        AS CHAR FORMAT "X(4)" INIT ""      /*ปีที่จดทะเบียน        */                        
  FIELD   vehreg         AS CHAR FORMAT "X(12)" INIT ""     /*เลขทะเบียนรถ          */                        
  FIELD   re_country     AS CHAR FORMAT "X(25)" INIT ""     /*จังหวัดที่จดทะเบียน   */                        
  FIELD   cargrp         AS CHAR FORMAT "X(2)" INIT ""      /*Group Car (กลุ่มรถ)   */                        
  FIELD   colorcar       AS CHAR FORMAT "X(25)" INIT ""     /*Color (สี)            */                        
  FIELD   fule           AS CHAR FORMAT "X(20)" INIT ""     /*Fule (เชื้อเพลิง)     */                        
  FIELD   drivnam        AS CHAR FORMAT "x(2)"  INIT ""     /*Driver Number         */                        
  /* A67-0029...
  FIELD   ntitle1        AS CHAR FORMAT "X(20)" INIT ""     /*คำนำหน้า              */                        
  FIELD   drivername1    AS CHAR FORMAT "X(50)" INIT ""     /*ชื่อ                  */                        
  FIELD   dname2         AS CHAR FORMAT "X(50)" INIT ""     /*นามสกุล               */                        
  FIELD   dicno          AS CHAR FORMAT "X(13)" INIT ""     /*เลขที่บัตรประชาชน     */                        
  FIELD   dgender1       AS CHAR FORMAT "X(20)" INIT ""     /*เพศ                   */                        
  FIELD   dbirth         AS CHAR FORMAT "X(15)" INIT ""     /*วันเกิด               */                        
  FIELD   doccup         AS CHAR FORMAT "X(20)" INIT ""     /*ชื่ออาชีพ             */                        
  FIELD   ddriveno       AS CHAR FORMAT "X(13)" INIT ""     /*เลขที่ใบอนุญาตขับขี่  */
  FIELD   ntitle2        AS CHAR FORMAT "X(20)" INIT ""     /*คำนำหน้า              */                        
  FIELD   drivername2    AS CHAR FORMAT "X(50)" INIT ""     /*ชื่อ                  */                        
  FIELD   ddname1        AS CHAR FORMAT "X(50)" INIT ""     /*นามสกุล               */                        
  FIELD   ddicno         AS CHAR FORMAT "X(13)" INIT ""     /*เลขที่บัตรประชาชน     */                        
  FIELD   dgender2       AS CHAR FORMAT "X(20)" INIT ""     /*เพศ                   */                        
  FIELD   ddbirth        AS CHAR FORMAT "X(15)" INIT ""     /*วันเกิด               */                        
  FIELD   ddoccup        AS CHAR FORMAT "X(20)" INIT ""     /*ชื่ออาชีพ             */                        
  FIELD   dddriveno      AS CHAR FORMAT "X(13)" INIT ""     /*เลขที่ใบอนุญาตขับขี่  */
  ...end : A67-0029..*/
  FIELD   baseplus       AS inte INIT 0 /*format "->>>>>>9"  */  /*Base Premium Plus     */                        
  FIELD   siplus         AS inte INIT 0 format "->>>>>>>9"   /*Sum Insured Plus      */                        
  FIELD   rs10           AS inte INIT 0 format "->>>>>>>>9"  /*RS10 Amount           */                        
  FIELD   comper         AS inte INIT 0 format "->>>>>>>>9"  /*TPBI / person         */                        
  FIELD   comacc         AS inte INIT 0 format "->>>>>>>>9"  /*TPBI / occurrence     */                        
  FIELD   deductpd       AS inte INIT 0 format "->>>>>>>>9"  /*TPPD                  */                        
  FIELD   DOD            AS inte INIT 0  /*format "->>>>9"    */  /*Deduct / OD           */
  FIELD   dod1           AS INTE INIT 0  /*DOD1 */ /*a65-0079*/
  FIELD   DPD            AS inte INIT 0  /*format "->>>>>9"   */  /*Deduct / PD           */                        
  FIELD   si             AS inte INIT 0  /*format "->>>>>>>>9"*/  /*suminsure         */                        
  FIELD   NO_411         AS inte INIT 0  /*format "->>>>>>>9" */  /*PA1.1 / driver        */                        
  FIELD   seat41         AS inte INIT 0  /*format "->>>>>>>9" */  /*PA1.1 no.of passenger */                        
  FIELD   NO_412         AS inte INIT 0  /*format "->>>>>>>9" */  /*PA1.1 / passenger     */                        
  FIELD   NO_413         AS inte INIT 0  /*format "->>>>>>>9" */  /*PA1.2 / driver        */                        
  FIELD   ac6            AS inte INIT 0  /*format "->>>>>>>9" */  /*PA1.2 no.of passenger */                        
  FIELD   NO_414         AS inte INIT 0  /*format "->>>>>>>9" */  /*PA1.2 / passenger     */                        
  FIELD   NO_42          AS inte INIT 0  /*format "->>>>>>>9" */  /*PA2                   */                        
  FIELD   NO_43          AS inte INIT 0  /*format "->>>>>>>9" */  /*PA3                   */  
  FIELD   base           AS inte INIT 0  /*format "->>>>>9"   */        /*Base Premium    */                              
  FIELD   unname         AS deci INIT 0  /*format "->>>>>9.99"*/   /*Unname          */                              
  FIELD   nname          AS deci INIT 0  /*format "->>>>>9.99"*/   /*Name            */                              
  FIELD   tpbi           AS deci INIT 0  /*format "->>>>>9.99"*/   /*TPBI/person Amount    */   
  FIELD   bi2            AS deci INIT 0  /*format "->>>>>9.99"*/   /*TPBI/occurance Amount */   
  FIELD   tppd           AS deci INIT 0  /*format "->>>>>9.99"*/   /*TPPD Amount     */ 
  FIELD   dod_prm        as inte init 0  /*A65-0079*/      
  FIELD   dod1_prm       as inte init 0  /*A65-0079*/      
  FIELD   dpd_prm        as inte init 0  /*A65-0079*/      
  FIELD   ry01           AS deci INIT 0  /*format "->>>>>9.99"*/   /*RY411 Amount    */  
  FIELD   ry412          AS deci INIT 0 /*format "->>>>>9.99"*/   /*RY412 Amount 26/01/2022 */  
  FIELD   ry413          AS deci INIT 0 /*format "->>>>>9.99"*/   /*RY413 Amount 26/01/2022 */  
  FIELD   ry414          AS deci INIT 0 /*format "->>>>>9.99"*/   /*RY414 Amount 26/01/2022 */  
  FIELD   ry02           AS deci INIT 0 /*format "->>>>>9.99"*/   /*RY02 Amount     */                              
  FIELD   ry03           AS deci INIT 0 /*format "->>>>>9.99"*/   /*RY03 Amount     */                              
  FIELD   fleet          AS char INIT "0" /*Fleet%          */                              
  FIELD   ncb            AS char INIT "0" /*NCB%            */                              
  FIELD   claim          AS char INIT "0" /*Load Claim%     */                              
  FIELD   dspc           AS char INIT "0" /*Other Disc.%    */                              
  FIELD   cctv           AS char INIT "0" /*CCTV%           */                              
  FIELD   dstf           AS char INIT "0" /*Walkin Disc.%   */                              
  FIELD   fleetprem      AS deci INIT 0 /*format "->>>>>>9.99" */  /*Fleet Amount    */                              
  FIELD   ncbprem        AS deci INIT 0 /*format "->>>>>>9.99" */  /*NCB Amount      */                              
  FIELD   clprem         AS deci INIT 0 /*format "->>>>>>9.99" */  /*Load Claim Amount   */                          
  FIELD   dspcprem       AS deci INIT 0 /*format "->>>>>>9.99" */  /*Other Disc. Amount  */                          
  FIELD   cctvprem       AS deci INIT 0 /*format "->>>>>>9.99" */  /*CCTV Amount         */                          
  FIELD   dstfprem       AS deci INIT 0 /*format "->>>>>>9.99" */  /*Walk in Disc. Amount*/                          
  FIELD   premt          AS deci INIT 0 /*format "->>>>>>>9.99" */ /*เบี้ยสุทธิ          */                          
  FIELD   rstp_t         AS deci INIT 0 /*format "->>>>>>9.99"  */ /*Stamp Duty          */                          
  FIELD   rtax_t         AS deci INIT 0 /*format "->>>>>>9.99"  */ /*VAT                 */                          
  FIELD   comper70       AS deci INIT 0 /*format "->>9.99"      */ /*Commission %        */                          
  FIELD   comprem70      AS deci INIT 0 /*format "->>>>>>9.99"  */ /*Commission Amount   */                          
  FIELD   agco70         AS CHAR FORMAT "X(20)" INIT ""         /*Agent Code co-broker (รหัสตัวแทน)*/             
  FIELD   comco_per70    AS deci  INIT 0                       /*Commission % co-broker     */                   
  FIELD   comco_prem70   AS deci  INIT 0                       /*Commission Amount co-broker*/  
  FIELD   dgpackge       AS CHAR FORMAT "X(20)" INIT ""         /*Package (Attach Coverage)  */                 
  FIELD   danger1        AS CHAR FORMAT "X(50)" INIT ""         /*Dangerous Object 1 */                           
  FIELD   danger2        AS CHAR FORMAT "X(50)" INIT ""         /*Dangerous Object 2 */                           
  FIELD   dgsi           AS inte  INIT 0  FORMAT ">>>>>>>>>9"                       /*Sum Insured        */                           
  FIELD   dgrate         AS char  INIT "0"       /*Rate%              */                           
  FIELD   dgfeet         AS char  INIT "0"       /*Fleet%             */                           
  FIELD   dgncb          AS char  INIT "0"       /*NCB%               */                           
  FIELD   dgdisc         AS char  INIT "0"       /*Discount%          */ 
  FIELD   dgWdisc        AS CHAR  INIT "0"
  FIELD   dgatt          AS inte  INIT 0 /*format "->>>>>>>9"   */  /*Premium Attach Coverage */                       
  FIELD   dgfeetprm      AS deci  INIT 0 /*format "->>>>>>>9.99"*/  /*Discount Fleet     */                           
  FIELD   dgncbprm       AS deci  INIT 0 /*format "->>>>>>>9.99"*/  /*Discount NCB       */                           
  FIELD   dgdiscprm      AS deci  INIT 0 /*format "->>>>>>>9.99"*/  /*Other Discount     */  
  FIELD   dgWdiscprm     AS deci  INIT 0 /*format "->>>>>>>9.99"*/  /*Walkin Discount     */                           
  FIELD   dgprem         AS deci  INIT 0 /*format "->>>>>>>9.99"*/  /*Net Premium        */
  FIELD   dgrstp_t       AS DECI  INIT 0                        /*Stamp Duty            */      
  FIELD   dgrtax_t       AS DECI  INIT 0                        /*VAT                   */      
  FIELD   dgcomper       AS DECI  INIT 0                        /*Commission %          */      
  FIELD   dgcomprem      AS DECI  INIT 0                        /*Commission Amount     */      
  FIELD   cltxt          AS CHAR FORMAT "X(20)" INIT ""         /*Claim Text         */                           
  FIELD   clamount       AS inte  INIT 0 /* format "->>>>>>9" */    /*Claim Amount       */                           
  FIELD   faultno        AS inte  INIT 0 /* format ">>9"      */    /*Claim Count Fault  */                           
  FIELD   faultprm       AS inte  INIT 0 /* format "->>>>>>9" */    /*Claim Count Fault Amount*/                      
  FIELD   goodno         AS inte  INIT 0 /* format ">>9"      */    /*Claim Count Good        */                      
  FIELD   goodprm        AS inte  INIT 0 /* format "->>>>>>9" */    /*Claim Count Good Amount */                      
  FIELD   loss           AS inte  INIT 0 /* format "->>>9"    */    /*Loss Ratio % (Not TP)   */                      
  FIELD   compolusory    AS CHAR FORMAT "X(20)" INIT ""         /*Compulsory Policy Number (เลขที่กรมธรรม์ พรบ.*/ 
  FIELD   stk            AS CHAR FORMAT "X(13)" INIT ""         /*sticker no                        */           
  FIELD   class72        AS CHAR FORMAT "X(4)" INIT ""          /*Compulsory Class (รหัส พรบ.)       */           
  FIELD   dstf72         AS CHAR FORMAT "x(10)" INIT "0"        /*Compulsory Walk In Discount %      */           
  FIELD   dstfprem72     AS DECI  INIT 0 /*format "->>>>>>9.99"*/  /*Compulsory Walk In Discount Amount */           
  FIELD   premt72        AS DECI  INIT 0 /*format "->>>>>>9.99"*/  /*เบี้ยสุทธิ พ.ร.บ. กรณี "กรมธรรม์ซื้อควบ"     */ 
  FIELD   rstp_t72       AS DECI  INIT 0 /*format "->>>>>9.99" */  /*Stamp Duty            */                        
  FIELD   rtax_t72       AS DECI  INIT 0 /*format "->>>>>9.99" */  /*VAT                   */                        
  FIELD   comper72       AS DECI  INIT 0 /*format "->>>>>9.99" */  /*Commission %          */                        
  FIELD   comprem72      AS DECI  INIT 0 /*format "->>>>>9.99" */  /*Commission Amount     */  /* ---- สิ้นสุดไฟล์โหลด ---*/ 
  FIELD   nv_insref      AS CHAR FORMAT "X(10)"  INIT ""       
  FIELD   birthdat       AS CHAR FORMAT "x(15)" INIT ""        
  FIELD   age            AS INT  INIT 0
  FIELD   entdat         AS CHAR FORMAT "x(10)" INIT ""     /*entry date*/                                                          
  FIELD   enttim         AS CHAR FORMAT "x(8)"  INIT ""     /*entry time*/                                                          
  FIELD   trandat        AS CHAR FORMAT "x(10)" INIT ""     /*tran date*/     
  FIELD   trantim        AS CHAR FORMAT "x(8)"  INIT ""     /*tran time*/     
  FIELD   n_IMPORT       AS CHAR FORMAT "x(2)"  INIT ""        
  /*FIELD   n_EXPORT       AS CHAR FORMAT "x(2)"  INIT "" */ /*A64-0044*/
  FIELD   vehuse         AS CHAR FORMAT "x(1)"  INIT "" 
  FIELD   poltyp         AS CHAR FORMAT "x(3)"  INIT "" 
  FIELD   renpol         AS CHAR FORMAT "x(32)" INIT ""     
  FIELD   cr_2           AS CHAR FORMAT "x(32)" INIT ""  
  /*FIELD   docno          AS CHAR FORMAT "x(10)" INIT "" */
  FIELD   redbook        AS CHAR FORMAT "X(8)"  INIT "" 
  FIELD   tariff         AS CHAR FORMAT "x(2)" INIT "9"
  FIELD   cancel         AS CHAR FORMAT "x(2)" INIT ""      /*cancel*/
  FIELD   accdat         AS CHAR INIT "" FORMAT "x(10)"     /*Account Date For 72*/
  FIELD   prempa         AS CHAR FORMAT "x" INIT ""         /*premium package*/ 
  /*FIELD   subclass       AS CHAR FORMAT "x(4)"   INIT ""  */     /*sub class*/ /*A64-0044 */ 
  FIELD   subclass       AS CHAR FORMAT "x(5)"   INIT ""          /*sub class*/ /*A64-0044 */ 
  FIELD   instot         AS INTE FORMAT "9"      INIT 0 
  FIELD   pass           AS CHAR FORMAT "x"      INIT "n"
  FIELD   OK_GEN         AS CHAR FORMAT "X"      INIT "Y" 
  FIELD   WARNING        AS CHAR FORMAT "X(30)"  INIT "" 
  FIELD   comment        AS CHAR FORMAT "X(350)" INIT ""
  FIELD   flagno         AS CHAR FORMAT "x(5)"  INIT ""
  FIELD   driver         AS CHAR FORMAT "x(23)"  INIT "" 
  FIELD   polmaster      AS CHAR FORMAT "x(20)" INIT ""  /*A64-0044*/
  /* add by : A67-0029 */
  FIELD  drilevel        AS CHAR FORMAT "x(2)" INIT "0" 
  field  maksi           as char format "X(20)" init "" 
  field  eng_no2         as char format "X(20)" init "" 
  field  battrate        as char format "X(20)" init "" 
  field  battper         as char format "X(20)" init ""  
  field  battyr          as char format "X(20)" init "" 
  field  battprice       as char format "X(20)" init "" 
  field  battno          as char format "X(20)" init "" 
  field  battsi          as char format "X(20)" init ""
  field  battprm         as char format "X(20)" init "" 
  field  chargno         as char format "X(20)" init "" 
  field  chargsi         as char format "X(20)" init "" 
  field  chargrate       as char format "X(20)" init "" 
  field  chargprm        as char format "X(20)" init "" 
  FIELD  comdat72        as char format "x(20)" init "" 
  FIELD  expdat72        as char format "x(20)" init ""
    /* end A67-0029*/
  field  rate31          as char format "x(10)" init ""   /*A68-0044*/
  field  prmt31          as char format "x(10)" init ""   /*A68-0044*/
    .

DEFINE TEMP-TABLE wtxt  /* TEXT F7 */
  FIELD   policyno       AS CHAR FORMAT "x(15)"  INIT ""  
  FIELD   txt1           AS CHAR FORMAT "X(50)" INIT ""  
  FIELD   txt2           AS CHAR FORMAT "X(50)" INIT "" 
  FIELD   txt3           AS CHAR FORMAT "X(50)" INIT "" 
  FIELD   txt4           AS CHAR FORMAT "X(50)" INIT "" 
  FIELD   txt5           AS CHAR FORMAT "X(50)" INIT "" 
  FIELD   txt6           AS CHAR FORMAT "X(50)" INIT "" 
  FIELD   txt7           AS CHAR FORMAT "X(50)" INIT "" 
  FIELD   txt8           AS CHAR FORMAT "X(50)" INIT "" 
  FIELD   txt9           AS CHAR FORMAT "X(50)" INIT "" 
  FIELD   txt10          AS CHAR FORMAT "X(50)" INIT "" .
DEFINE TEMP-TABLE wmemo  /* Memo F8 */
  FIELD   policyno       AS CHAR FORMAT "x(15)"  INIT ""  
  FIELD   memo1          AS CHAR FORMAT "X(50)"  INIT ""  
  FIELD   memo2          AS CHAR FORMAT "X(50)"  INIT "" 
  FIELD   memo3          AS CHAR FORMAT "X(50)"  INIT "" 
  FIELD   memo4          AS CHAR FORMAT "X(50)"  INIT "" 
  FIELD   memo5          AS CHAR FORMAT "X(50)"  INIT "" 
  FIELD   memo6          AS CHAR FORMAT "X(50)"  INIT "" 
  FIELD   memo7          AS CHAR FORMAT "X(50)"  INIT "" 
  FIELD   memo8          AS CHAR FORMAT "X(50)"  INIT "" 
  FIELD   memo9          AS CHAR FORMAT "X(50)"  INIT "" 
  FIELD   memo10         AS CHAR FORMAT "X(50)"  INIT "" .
DEFINE TEMP-TABLE wacces /* อุปกรณ์ตกแต่ง */
  FIELD   policyno       AS CHAR FORMAT "x(15)"  INIT ""  
  FIELD   accdata1       AS CHAR FORMAT "X(50)" INIT ""  
  FIELD   accdata2       AS CHAR FORMAT "X(50)" INIT "" 
  FIELD   accdata3       AS CHAR FORMAT "X(50)" INIT "" 
  FIELD   accdata4       AS CHAR FORMAT "X(50)" INIT "" 
  FIELD   accdata5       AS CHAR FORMAT "X(50)" INIT "" 
  FIELD   accdata6       AS CHAR FORMAT "X(50)" INIT "" 
  FIELD   accdata7       AS CHAR FORMAT "X(50)" INIT "" 
  FIELD   accdata8       AS CHAR FORMAT "X(50)" INIT "" 
  FIELD   accdata9       AS CHAR FORMAT "X(50)" INIT "" 
  FIELD   accdata10      AS CHAR FORMAT "X(50)" INIT "" .
DEFINE TEMP-TABLE winst  /* installment */
    FIELD policyno        AS CHAR FORMAT "x(15)"  INIT ""   
    FIELD instot          AS INTE FORMAT "9"      INIT 0    
    FIELD instcod1        AS CHAR FORMAT "x(10)"  INIT ""     
    FIELD insttyp1        AS CHAR FORMAT "x(10)"  INIT ""     
    FIELD insttitle1      AS CHAR FORMAT "x(20)" INIT ""     
    FIELD instname1       AS CHAR FORMAT "x(50)"  INIT ""     
    FIELD instlname1      AS CHAR FORMAT "x(50)" INIT ""     
    FIELD instic1         AS CHAR FORMAT "x(13)"  INIT ""     
    FIELD instbr1         AS CHAR FORMAT "x(2)"  INIT ""      
    FIELD instaddr11      AS CHAR FORMAT "x(50)" INIT ""     
    FIELD instaddr21      AS CHAR FORMAT "x(50)"  INIT ""     
    FIELD instaddr31      AS CHAR FORMAT "x(50)" INIT ""     
    FIELD instaddr41      AS CHAR FORMAT "x(50)"  INIT ""     
    FIELD instpost1       AS CHAR FORMAT "x(5)"  INIT ""     
    FIELD instprovcod1    AS CHAR FORMAT "x(2)" INIT ""     
    FIELD instdistcod1    AS CHAR FORMAT "x(2)"  INIT ""     
    FIELD instsdistcod1   AS CHAR FORMAT "x(2)" INIT ""     
    FIELD instprm1        AS DECI INIT 0 format ">>>>>>9.99"   
    FIELD instrstp1       AS DECI INIT 0 format ">>>>>9.99"    
    FIELD instrtax1       AS DECI INIT 0 format ">>>>>9.99"    
    FIELD instcomm01      AS DECI INIT 0 format ">>>>>9.99"    
    field instcomm12      as DECI INIT 0 format ">>>>>9.99"    
    field instcod2        as CHAR FORMAT "x(10)"  INIT ""           
    field insttyp2        as CHAR FORMAT "x(10)"  INIT ""           
    field insttitle2      as CHAR FORMAT "x(20)" INIT ""            
    field instname2       as CHAR FORMAT "x(50)"  INIT ""           
    field instlname2      as CHAR FORMAT "x(50)" INIT ""            
    field instic2         as CHAR FORMAT "x(13)"  INIT ""           
    field instbr2         as CHAR FORMAT "x(2)"  INIT ""            
    field instaddr12      as CHAR FORMAT "x(50)" INIT ""            
    field instaddr22      as CHAR FORMAT "x(50)"  INIT ""           
    field instaddr32      as CHAR FORMAT "x(50)" INIT ""            
    field instaddr42      as CHAR FORMAT "x(50)"  INIT ""           
    field instpost2       as CHAR FORMAT "x(5)"  INIT ""            
    field instprovcod2    as CHAR FORMAT "x(2)" INIT ""             
    field instdistcod2    as CHAR FORMAT "x(2)"  INIT ""            
    field instsdistcod2   as CHAR FORMAT "x(2)" INIT ""             
    field instprm2        as DECI INIT 0  format ">>>>>>9.99"                          
    field instrstp2       as DECI INIT 0  format ">>>>>9.99"                          
    field instrtax2       as DECI INIT 0  format ">>>>>9.99"                          
    field instcomm02      as DECI INIT 0  format ">>>>>9.99"                          
    field instcomm22      as DECI INIT 0  format ">>>>>9.99"                          
    field instcod3        as CHAR FORMAT "x(10)"  INIT ""           
    field insttyp3        as CHAR FORMAT "x(10)"  INIT ""           
    field insttitle3      as CHAR FORMAT "x(20)" INIT ""            
    field instname3       as CHAR FORMAT "x(50)"  INIT ""           
    field instlname3      as CHAR FORMAT "x(50)" INIT ""            
    field instic3         as CHAR FORMAT "x(13)"  INIT ""           
    field instbr3         as CHAR FORMAT "x(2)"  INIT ""            
    field instaddr13      as CHAR FORMAT "x(50)" INIT ""            
    field instaddr23      as CHAR FORMAT "x(50)"  INIT ""           
    field instaddr33      as CHAR FORMAT "x(50)" INIT ""            
    field instaddr43      as CHAR FORMAT "x(50)"  INIT ""           
    field instpost3       as CHAR FORMAT "x(5)"  INIT ""            
    field instprovcod3    as CHAR FORMAT "x(2)" INIT ""             
    field instdistcod3    as CHAR FORMAT "x(2)"  INIT ""            
    field instsdistcod3   as CHAR FORMAT "x(2)" INIT ""             
    field instprm3        as DECI INIT 0  format ">>>>>>9.99"                             
    field instrstp3       as DECI INIT 0  format ">>>>>9.99"                              
    field instrtax3       as DECI INIT 0  format ">>>>>9.99"                              
    field instcomm03      as DECI INIT 0  format ">>>>>9.99"                              
    field instcomm23      as DECI INIT 0  format ">>>>>9.99"  .    
DEFINE STREAM  ns1. 
DEFINE STREAM  ns2.
DEFINE STREAM  ns3.
DEF VAR nv_uom1_v AS INTE INIT 0.
DEF VAR nv_uom2_v AS INTE INIT 0.
DEF VAR nv_uom5_v AS INTE INIT 0.
DEF VAR chkred    AS logi INIT NO.
DEF SHARED Var   n_User    As CHAR .
DEF SHARED Var   n_PassWd  As CHAR .    
DEF VAR nv_clmtext AS CHAR INIT  "".
DEF VAR n_renew    AS LOGIC  .
DEF VAR nv_massage AS CHAR .
DEF VAR nv_comper  AS DECI INIT 0.
DEF VAR nv_comacc  AS DECI INIT 0.
DEF VAR NO_prem2   AS INTE INIT 0.
DEF VAR nv_modcod  AS CHAR FORMAT "x(8)" INIT "" .
DEF NEW SHARED VAR nv_seat41 AS INTEGER FORMAT ">>9".
DEF NEW SHARED VAR nv_totsi  AS DECIMAL FORMAT ">>,>>>,>>9.99-".
DEF NEW SHARED VAR nv_polday AS INTE    FORMAT ">>9".
def New SHARED VAR nv_uom6_u as char.                
def var nv_chk as  logic.
DEF VAR nv_ncbyrs AS INTE. 
DEFINE VAR nv_txt1    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt2    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt3    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt4    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt5    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt6    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt7    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt8    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_line1   AS INTEGER   INITIAL 0            NO-UNDO.
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
DEFINE VAR nv_si     AS DECI FORMAT ">>,>>>,>>9.99-". /* Maximum Sum Insure */
DEFINE VAR nv_maxSI  AS DECI FORMAT ">>,>>>,>>9.99-". /* Maximum Sum Insure */
DEFINE VAR nv_minSI  AS DECI FORMAT ">>,>>>,>>9.99-". /* Minimum Sum Insure */
DEFINE VAR nv_newsck AS CHAR FORMAT "x(15)" INIT " ".
DEFINE VAR nv_simat  AS DECI FORMAT ">>>,>>>,>>>,>>9.99-".
DEFINE VAR nv_simat1  AS DECI FORMAT ">>>,>>>,>>>,>>9.99-".
DEF VAR nv_uwm301trareg    LIKE sic_bran.uwm301.cha_no INIT "".
DEF VAR n_ratmin  AS INTE INIT 0.
DEF VAR n_ratmax  AS INTE INIT 0.
DEF VAR nv_dscom  AS DECI INIT 0.
DEF VAR nv_polmaster AS CHAR FORMAT "x(35)" INIT "" .

DEF NEW  SHARED VAR nv_odcod    AS CHAR     FORMAT "X(4)".
DEF NEW  SHARED VAR nv_cons     AS CHAR     FORMAT "X(2)".
DEF New  shared VAR nv_prem     AS DECIMAL  FORMAT ">,>>>,>>9.99-"   INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR nv_baseap   AS DECI     FORMAT ">>,>>>,>>9.99-".
DEF New  shared VAR nv_ded      AS INTEGER  FORMAT ">>,>>>,>>9"      INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR nv_gapprm   AS DECI     FORMAT ">>,>>>,>>9.99-"  INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR nv_pdprm    AS DECI     FORMAT ">>,>>>,>>9.99-"  INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR nv_prvprm   AS DECI     FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR nv_41prm    AS INTEGER  FORMAT ">,>>>,>>9"       INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR nv_ded1prm  AS INTEGER  FORMAT ">>>,>>9-"        INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR nv_aded1prm AS INTEGER  FORMAT ">>>,>>9-"        INITIAL 0  NO-UNDO.
DEF New  SHARED VAR nv_ded2prm  AS INTEGER  FORMAT ">>>,>>9-"        INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR nv_dedod    AS INTEGER  FORMAT ">>,>>>,>>9"      INITIAL 0  NO-UNDO.
DEF New  SHARED VAR nv_addod    AS INTEGER  FORMAT ">>,>>>,>>9"      INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR nv_dedpd    AS INTEGER  FORMAT ">>,>>>,>>9"      INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR nv_prem1    AS DECIMAL  FORMAT ">,>>>,>>9.99-"   INITIAL 0  NO-UNDO.
DEF New  SHARED VAR nv_addprm   AS INTEGER  FORMAT ">>,>>>,>>9"      INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR nv_totded   AS INTEGER  FORMAT ">>,>>>,>>9-"     INITIAL 0  NO-UNDO.
DEF New  SHARED VAR nv_totdis   AS INTEGER  FORMAT ">>,>>>,>>9-"     INITIAL 0  NO-UNDO.
DEF New  SHARED VAR nv_41cod1   AS CHARACTER    FORMAT "X(4)".
DEF NEW  SHARED VAR nv_41cod2   AS CHARACTER    FORMAT "X(4)".
DEF New  SHARED VAR nv_41       AS INTEGER      FORMAT ">>>,>>>,>>9".
DEF New  SHARED VAR nv_411prm   AS DECI         FORMAT ">,>>>,>>9.99".
DEF NEW  SHARED VAR nv_412prm   AS DECI         FORMAT ">,>>>,>>9.99".
DEF New  SHARED VAR nv_411var1  AS CHAR         FORMAT "X(30)".
DEF New  SHARED VAR nv_411var2  AS CHAR         FORMAT "X(30)".
DEF NEW  SHARED VAR nv_411var   AS CHAR         FORMAT "X(60)".
DEF New  SHARED VAR nv_412var1  AS CHAR         FORMAT "X(30)".
DEF NEW  SHARED VAR nv_412var2  AS CHAR         FORMAT "X(30)".
DEF New  SHARED VAR nv_412var   AS CHAR         FORMAT "X(60)".
DEF NEW  SHARED VAR nv_42cod    AS CHARACTER    FORMAT "X(4)".
DEF NEW  SHARED VAR nv_42       AS INTEGER      FORMAT ">>>,>>>,>>9".
DEF New  SHARED VAR nv_42prm    AS DECI         FORMAT ">,>>>,>>9.99".
DEF NEW  SHARED VAR nv_42var1   AS CHAR         FORMAT "X(30)".
DEF New  SHARED VAR nv_42var2   AS CHAR         FORMAT "X(30)".
DEF NEW  SHARED VAR nv_42var    AS CHAR         FORMAT "X(60)".
DEF New  SHARED VAR nv_43cod    AS CHARACTER    FORMAT "X(4)".
DEF NEW  SHARED VAR nv_43       AS INTEGER      FORMAT ">>>,>>>,>>9".
DEF New  SHARED VAR nv_43prm    AS DECI         FORMAT ">,>>>,>>9.99".
DEF New  SHARED VAR nv_43var1   AS CHAR         FORMAT "X(30)".
DEF NEW  SHARED VAR nv_43var2   AS CHAR         FORMAT "X(30)".
DEF New  SHARED VAR nv_43var    AS CHAR         FORMAT "X(60)".
DEF NEW  SHARED VAR nv_campcod   AS CHAR        FORMAT "X(4)".
DEF NEW  SHARED VAR nv_camprem   AS DECI        FORMAT ">>>9".
DEF New  SHARED VAR nv_campvar1  AS CHAR        FORMAT "X(30)".
DEF NEW  SHARED VAR nv_campvar2  AS CHAR        FORMAT "X(30)".
DEF New  SHARED VAR nv_campvar   AS CHAR        FORMAT "X(60)".
DEF NEW  SHARED VAR nv_compcod   AS CHAR        FORMAT "X(4)".
DEF NEW  SHARED VAR nv_compprm   AS DECI        FORMAT ">>>,>>9.99-".
DEF New  SHARED VAR nv_compvar1  AS CHAR        FORMAT "X(30)".
DEF NEW  SHARED VAR nv_compvar2  AS CHAR        FORMAT "X(30)".
DEF New  SHARED VAR nv_compvar   AS CHAR        FORMAT "X(60)".
DEF NEW  SHARED VAR nv_basecod   AS CHAR        FORMAT "X(4)".
DEF NEW  SHARED VAR nv_baseprm   AS DECI        FORMAT ">>,>>>,>>9.99-". 
DEF New  SHARED VAR nv_basevar1  AS CHAR        FORMAT "X(30)".
DEF NEW  SHARED VAR nv_basevar2  AS CHAR        FORMAT "X(30)".
DEF New  SHARED VAR nv_basevar   AS CHAR        FORMAT "X(60)".
DEF NEW  SHARED VAR   nv_cl_cod   AS CHAR       FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_cl_per   AS DECIMAL    FORMAT ">9.99".
DEF New  SHARED VAR   nv_lodclm   AS INTEGER    FORMAT ">>>,>>9.99-".
DEF             VAR   nv_lodclm1  AS INTEGER    FORMAT ">>>,>>9.99-".
DEF New  SHARED VAR   nv_clmvar1  AS CHAR       FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_clmvar2  AS CHAR       FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_clmvar   AS CHAR       FORMAT "X(60)".
DEF NEW  SHARED VAR   nv_stf_cod  AS CHAR      FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_stf_per  AS DECIMAL   FORMAT ">9.99".
DEF New  SHARED VAR   nv_stf_amt  AS INTEGER   FORMAT ">>>,>>9.99-".
DEF NEW  SHARED VAR   nv_stfvar1  AS CHAR      FORMAT "X(30)".
DEF New  SHARED VAR   nv_stfvar2  AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_stfvar   AS CHAR      FORMAT "X(60)".
DEF NEW  SHARED VAR   nv_dss_cod  AS CHAR      FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_dss_per  AS DECIMAL   FORMAT ">9.99".
DEF New  SHARED VAR   nv_dsspc    AS INTEGER   FORMAT ">>>,>>9.99-".
DEF NEW  SHARED VAR   nv_dsspcvar1 AS CHAR     FORMAT "X(30)".
DEF New  SHARED VAR   nv_dsspcvar2 AS CHAR     FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_dsspcvar  AS CHAR     FORMAT "X(60)".
DEF NEW  SHARED VAR   nv_ncb_cod  AS CHAR  FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_ncbper   LIKE sicuw.uwm301.ncbper.
DEF New  SHARED VAR   nv_ncb      AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR   nv_ncbvar1  AS CHAR  FORMAT "X(30)".
DEF New  SHARED VAR   nv_ncbvar2  AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_ncbvar   AS CHAR  FORMAT "X(60)".
DEF NEW  SHARED VAR   nv_flet_cod AS CHAR    FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_flet_per AS DECIMAL FORMAT ">>9".
DEF New  SHARED VAR   nv_flet     AS DECI    FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR   nv_fletvar1 AS CHAR    FORMAT "X(30)".
DEF New  SHARED VAR   nv_fletvar2 AS CHAR    FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_fletvar  AS CHAR    FORMAT "X(60)".
DEF NEW   SHARED VAR  nv_vehuse LIKE sicuw.uwm301.vehuse.                 
DEF NEW   SHARED VAR  nv_grpcod  AS CHARACTER FORMAT "X(4)".
DEF NEW   SHARED VAR  nv_grprm   AS DECI      FORMAT ">>,>>>,>>9.99-".
DEF NEW   SHARED VAR  nv_grpvar1 AS CHAR      FORMAT "X(30)".
DEF NEW   SHARED VAR  nv_grpvar2 AS CHAR      FORMAT "X(30)".
DEF NEW   SHARED VAR  nv_grpvar  AS CHAR      FORMAT "X(60)".
DEF NEW  SHARED VAR   nv_othcod  AS CHARACTER FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_othprm  AS DECI      FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR   nv_othvar1 AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_othvar2 AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_othvar  AS CHAR      FORMAT "X(60)".
DEF NEW  SHARED VAR   nv_dedod1_cod AS CHAR   FORMAT "X(4)".             
DEF NEW  SHARED VAR   nv_dedod1_prm AS DECI   FORMAT ">,>>>,>>9.99-".    
DEF NEW  SHARED VAR   nv_dedod1var1 AS CHAR   FORMAT "X(30)".            
DEF NEW  SHARED VAR   nv_dedod1var2 AS CHAR   FORMAT "X(30)".            
DEF NEW  SHARED VAR   nv_dedod1var  AS CHAR   FORMAT "X(60)".            
DEF NEW  SHARED VAR   nv_dedod2_cod AS CHAR   FORMAT "X(4)".             
DEF NEW  SHARED VAR   nv_dedod2_prm AS DECI   FORMAT ">,>>>,>>9.99-".    
DEF NEW  SHARED VAR   nv_dedod2var1 AS CHAR   FORMAT "X(30)".            
DEF NEW  SHARED VAR   nv_dedod2var2 AS CHAR   FORMAT "X(30)".            
DEF NEW  SHARED VAR   nv_dedod2var  AS CHAR   FORMAT "X(60)".            
DEF NEW  SHARED VAR   nv_dedpd_cod  AS CHAR   FORMAT "X(4)".             
DEF NEW  SHARED VAR   nv_dedpd_prm  AS DECI   FORMAT ">,>>>,>>9.99-".    
DEF NEW  SHARED VAR   nv_dedpdvar1  AS CHAR   FORMAT "X(30)".            
DEF NEW  SHARED VAR   nv_dedpdvar2  AS CHAR   FORMAT "X(30)".            
DEF NEW  SHARED VAR   nv_dedpdvar   AS CHAR   FORMAT "X(60)".            
DEF NEW SHARED VAR nv_tariff     LIKE sicuw.uwm301.tariff.
DEF NEW SHARED VAR nv_comdat     LIKE sicuw.uwm100.comdat.
DEF NEW SHARED VAR nv_covcod     LIKE sicuw.uwm301.covcod.
/*DEF NEW SHARED VAR nv_class      AS CHAR    FORMAT "X(4)". */ /*A64-0044*/
DEF NEW SHARED VAR nv_class      AS CHAR    FORMAT "X(5)".      /*A64-0044*/
DEF NEW SHARED VAR nv_key_b      AS DECIMAL FORMAT ">>>,>>>,>>>,>>9.99-" INITIAL 0 NO-UNDO.
DEF NEW SHARED VAR nv_drivno     AS INT       .
DEF NEW SHARED VAR nv_drivcod    AS CHARACTER FORMAT "X(4)".
DEF NEW SHARED VAR nv_drivprm    AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW SHARED VAR nv_drivvar1   AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR nv_drivvar2   AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR nv_drivvar    AS CHAR  FORMAT "X(60)".
DEF NEW SHARED VAR   nv_usecod   AS CHARACTER FORMAT "X(4)".
DEF NEW SHARED VAR   nv_useprm   AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW SHARED VAR   nv_usevar1  AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR   nv_usevar2  AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR   nv_usevar   AS CHAR  FORMAT "X(60)".
DEF NEW  SHARED VAR   nv_sicod   AS CHARACTER FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_siprm   AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR   nv_sivar1  AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_sivar2  AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_sivar   AS CHAR  FORMAT "X(60)".
def New  shared var   nv_uom6_c  as  char.      /* Sum  si*/
def New  shared var   nv_uom7_c  as  char.      /* Fire/Theft*/
DEF NEW  SHARED VAR   nv_bipcod  AS CHARACTER FORMAT "X(4)".
/*DEF NEW  SHARED VAR   nv_bipprm  AS DECI  FORMAT ">>,>>>,>>9.99-".*/
DEF NEW  SHARED VAR   nv_bipvar1 AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_bipvar2 AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_bipvar  AS CHAR  FORMAT "X(60)".
DEF NEW  SHARED VAR   nv_biacod   AS CHARACTER FORMAT "X(4)".
/*DEF NEW  SHARED VAR   nv_biaprm   AS DECI  FORMAT ">>,>>>,>>9.99-".*/
DEF NEW  SHARED VAR   nv_biavar1  AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_biavar2  AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_biavar   AS CHAR  FORMAT "X(60)".
DEF NEW  SHARED VAR   nv_pdacod   AS CHARACTER FORMAT "X(4)".
/*DEF NEW  SHARED VAR   nv_pdaprm   AS DECI  FORMAT ">>,>>>,>>9.99-".*/
DEF NEW  SHARED VAR   nv_pdavar1  AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_pdavar2  AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_pdavar   AS CHAR  FORMAT "X(60)".

DEFINE new SHARED VAR   nv_totlcod  AS CHAR  FORMAT "X(4)".
DEFINE new SHARED VAR   nv_totlprm  AS DECI  FORMAT ">>,>>>,>>9.99-".
DEFINE new SHARED VAR   nv_totlvar1 AS CHAR  FORMAT "X(30)".
DEFINE new SHARED VAR   nv_totlvar2 AS CHAR  FORMAT "X(30)".
DEFINE new SHARED VAR   nv_totlvar  AS CHAR  FORMAT "X(60)".

DEF NEW SHARED VAR nv_engine LIKE sicsyac.xmm102.engine.
DEF NEW SHARED VAR nv_tons   LIKE sicsyac.xmm102.tons.
DEF NEW SHARED VAR nv_seats  LIKE sicsyac.xmm102.seats.
/*DEF NEW SHARED VAR nv_sclass  AS CHAR FORMAT "x(3)".*/ /*A64-0044*/
DEF NEW SHARED VAR nv_sclass  AS CHAR FORMAT "x(4)".     /*A64-0044*/
DEF NEW SHARED VAR nv_engcod  AS CHAR FORMAT "x(4)".
DEF NEW SHARED VAR nv_engprm  AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW SHARED VAR nv_engvar1 AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR nv_engvar2 AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR nv_engvar  AS CHAR  FORMAT "X(60)".
DEF VAR  NO_CLASS AS CHAR INIT "".
DEF VAR no_tariff AS CHAR INIT "".
def  New  shared var  nv_poltyp   as   char   init  "".
DEF NEW SHARED VAR nv_yrcod   AS CHARACTER FORMAT "X(4)".
DEF NEW SHARED VAR nv_yrprm   AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW SHARED VAR nv_yrvar1  AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR nv_yrvar2  AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR nv_yrvar   AS CHAR  FORMAT "X(60)".
DEF New shared VAR nv_caryr   AS INTE  FORMAT ">>>9" .
def new shared var  s_recid1       as RECID .     /* uwm100  */
def new shared var  s_recid2       as recid .     /* uwm120  */
def new shared var  s_recid3       as recid .     /* uwm130  */  
def new shared var  s_recid4       as recid .     /* uwm301  */                                    
def New shared  var nv_dspc      as  deci.
def New shared  var nv_mv1       as  int .
def New shared  var nv_mv1_s     as  int . 
def New shared  var nv_mv2       as  int . 
def New shared  var nv_mv3       as  int . 
def New shared  var nv_comprm    as  int .  
def New shared  var nv_model     as  char.  
DEF VAR nv_lnumber AS   INTE INIT 0.
DEF VAR nv_provi   AS   CHAR INIT "".
DEF VAR n_rencnt   LIKE sicuw.uwm100.rencnt INITIAL "".
def var nv_index   as   int  init  0. 
DEF VAR n_endcnt   LIKE sicuw.uwm100.endcnt INITIAL "".
def var n_comdat   LIKE sicuw.uwm100.comdat  NO-UNDO.
def var n_policy   LIKE sicuw.uwm100.policy  INITIAL "" .
DEF VAR nv_daily     AS CHARACTER FORMAT "X(1024)"     INITIAL ""  NO-UNDO.
DEF VAR nv_reccnt   AS  INT  INIT  0.          /*all load record*/
DEF VAR nv_completecnt    AS   INT   INIT  0.  /*complete record */
DEF NEW SHARED VAR chr_sticker AS CHAR FORMAT "9999999999999" INIT "".  
def NEW SHARED  var nv_modulo    as int  format "9".

DEF    new shared VAR  s_riskgp    AS INTE FORMAT ">9".
DEF    new shared VAR  s_riskno    AS INTE FORMAT "999".
DEF    new shared VAR  s_itemno    AS INTE FORMAT "999". 
/* comment by : A67-0029...
DEF VAR nv_drivage1 AS INTE INIT 0.
DEF VAR nv_drivage2 AS INTE INIT 0.
DEF VAR nv_drivbir1 AS CHAR INIT "".
DEF VAR nv_drivbir2 AS CHAR INIT "".
...end A67-0029...*/
def var nv_dept     as char format  "X(1)".
def NEW SHARED var  nv_branch     LIKE sicsyac.XMM023.BRANCH.  
def var nv_undyr    as    char  init  ""    format   "X(4)".
def var n_newpol    Like  sicuw.uwm100.policy  init  "".
def var n_curbil    LIKE  sicuw.uwm100.curbil  NO-UNDO.
def New shared  var      nv_makdes    as   char    .
def New shared  var      nv_moddes    as   char.
DEF Var nv_lastno As       Int.
Def Var nv_seqno  As       Int.
DEF VAR sv_xmm600 AS       RECID.
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

DEF VAR nv_chkerror AS CHAR FORMAT "x(500)" .
/*DEFINE VAR nv_class70  AS CHARACTER FORMAT "X(4)"    INITIAL ""  NO-UNDO. */  /*A64-0044*/
DEFINE VAR nv_class70  AS CHARACTER FORMAT "X(5)"    INITIAL ""  NO-UNDO.       /*A64-0044*/
DEFINE VAR nv_covcod70 AS CHARACTER FORMAT "X(1)"    INITIAL ""  NO-UNDO.
DEFINE VAR nv_vehuse70 AS CHARACTER FORMAT "X(1)"    INITIAL ""  NO-UNDO.
DEFINE VAR nv_garage70 AS CHARACTER FORMAT "X(1)"    INITIAL ""  NO-UNDO.
DEFINE VAR nv_cc        AS int  FORMAT ">>>9"        .
DEFINE VAR nv_seat      AS int  FORMAT ">9"          .
DEFINE VAR nv_ton       AS DECI FORMAT ">>>>>.99"    .
define var nv_tariff72  as char format "x(1)" init "" .
define var nv_vehuse72  as char format "x(1)" init "" .
define var nv_uom8_c    as deci format ">>,>>>,>>9" init "0" .
define var nv_uom9_c    as deci format ">>,>>>,>>9" init "0" .
DEF    VAR nv_remark1 AS CHAR FORMAT "x(225)" INIT "" .
DEFINE VAR nv_class72  AS CHARACTER FORMAT "X(4)"    INITIAL ""  NO-UNDO.
DEFINE var  nv_caryear AS INT FORMAT "9999" .
DEFINE VAR  nv_redbook AS CHAR FORMAT "x(10)" .
DEF NEW SHARED VAR nv_message AS char.
DEF            VAR c          AS CHAR.
DEF            VAR nv_riskgp  AS INTE NO-UNDO.
/***--- Note Add Condition Base Premium ---***/
DEFINE NEW SHARED VAR no_baseprm AS DECI  FORMAT ">>,>>>,>>9.99-".  /*note add test Base Premium 25/09/2006*/
DEFINE NEW SHARED VAR NO_basemsg AS CHAR  FORMAT "x(50)" .          /*Warning Error If Not in Range 25/09/2006 */
DEFINE            VAR nv_accdat  AS DATE  FORMAT "99/99/9999" INIT ?  .     
DEFINE            VAR nv_docno   AS CHAR  FORMAT "9999999"    INIT " ".
/*a490166*/
DEFINE NEW SHARED VAR  nv_batchyr   AS INT FORMAT "9999"            INIT 0.
DEFINE NEW SHARED VAR  nv_batcnt    AS INT FORMAT "99"              INIT 0.
/*DEFINE NEW SHARED VAR  nv_batchno   AS CHARACTER FORMAT "X(13)"     INIT ""  NO-UNDO.*/ /*A64-0355*/
DEFINE NEW SHARED VAR  nv_batchno   AS CHARACTER FORMAT "X(15)"     INIT ""  NO-UNDO. /*A64-0355*/
/*DEFINE VAR  nv_batrunno  AS INT FORMAT  ">,>>9"          INIT 0.*/ /*A64-0355*/
DEFINE VAR  nv_batrunno  AS INT FORMAT  ">>>>9"          INIT 0.  /*A64-0355*/
DEFINE VAR  nv_imppol    AS INT  FORMAT ">>,>>9"         INIT 0.
DEFINE VAR  nv_impprem   AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.
DEFINE VAR  nv_batprev   AS CHARACTER FORMAT "X(13)"     INIT ""  NO-UNDO.
DEFINE VAR  nv_tmppolrun AS INTEGER FORMAT "999"         INIT 0. /*Temp Policy Running No.*/
DEFINE VAR  nv_batbrn    AS CHARACTER FORMAT "x(2)"      INIT ""  NO-UNDO. /*Batch Branch*/
DEFINE VAR  nv_tmppol    AS CHARACTER FORMAT "x(16)"     INIT "". /*Temp Policy*/
DEFINE VAR  nv_rectot    AS INT  FORMAT ">>,>>9"         INIT 0.  /* Display จำนวน ก/ธ ทั้งไฟล์ */
DEFINE VAR  nv_recsuc    AS INT  FORMAT ">>,>>9"         INIT 0.  /* Display จำนวน ก/ธ ที่นำเข้าได้ */
DEFINE VAR  nv_netprm_t  AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.  /* Display เบี้ยรวม ทั้งไฟล์ */
DEFINE VAR  nv_netprm_s  AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.  /* Display เบี้ยรวม ที่นำเข้าได้ */
DEF VAR n_producer  AS CHAR INIT "" FORMAT "x(10)"       .        /*A55-0043*/
DEFINE VAR  nv_batflg    AS LOG                          INIT NO.
DEFINE VAR  nv_txtmsg    AS CHAR FORMAT "x(50)"          INIT "".   /* Parameter คู่กับ nv_check */
DEF VAR n_age AS INTE INIT 0.      /* A55-0151 */
/*add A55-0268 by kridtiya i. ...*/
DEFINE VAR n_insref     AS CHARACTER FORMAT "X(10)". 
DEFINE VAR nv_messagein AS CHAR FORMAT "X(200)". 
DEFINE VAR nv_usrid     AS CHARACTER FORMAT "X(08)".
DEFINE VAR nv_transfer  AS LOGICAL   .
DEFINE VAR n_check      AS CHARACTER .
DEFINE VAR nv_insref    AS CHARACTER FORMAT "X(10)".  
DEFINE VAR putchr       AS CHAR FORMAT "X(200)" INIT "" NO-UNDO.
DEFINE VAR putchr1      AS CHAR FORMAT "X(100)" INIT "" NO-UNDO.
DEFINE VAR nv_typ       AS CHAR FORMAT "X(2)".
DEF BUFFER buwm100      FOR sic_bran.uwm100 .  
/*add A55-0268 by kridtiya i. ...*/
DEF VAR nv_acc1 AS CHAR FORMAT "x(60)" INIT "".      
DEF VAR nv_acc2 AS CHAR FORMAT "x(60)" INIT "".      
DEF VAR nv_acc3 AS CHAR FORMAT "x(60)" INIT "".      
DEF VAR nv_acc4 AS CHAR FORMAT "x(60)" INIT "".      
DEF VAR nv_acc5 AS CHAR FORMAT "x(60)" INIT "".      
DEF VAR nv_acc6 AS CHAR FORMAT "x(60)" INIT "".      
DEF VAR nv_acc7 AS CHAR FORMAT "x(60)" INIT "".      
DEF VAR nv_acc8 AS CHAR FORMAT "x(60)" INIT "".      
DEF VAR nv_acc9 AS CHAR FORMAT "x(60)" INIT "".      
DEF VAR nv_acc10 AS CHAR FORMAT "x(60)" INIT "".     
DEF VAR nv_acc AS CHAR FORMAT "x(550)" INIT "".   

DEFINE TEMP-TABLE wimproducer                         
    FIELD idno      AS CHAR FORMAT "x(10)" INIT ""    
    FIELD saletype  AS CHAR FORMAT "x(10)" INIT ""    
    FIELD camname   AS CHAR FORMAT "x(30)" INIT ""    
    FIELD notitype  AS CHAR FORMAT "x(10)" INIT ""    
    FIELD producer  AS CHAR FORMAT "x(10)" INIT "".   
/*A57-0126 add for 2+,3+*/
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

DEF VAR     nv_fi_tax_per       AS DECI INIT 0.00.
DEF VAR     nv_fi_stamp_per     AS DECI INIT 0.00.
DEF VAR     nv_fi_tax_per_ins   AS DECI INIT 0.00.
DEF VAR     nv_fi_stamp_per_ins AS DECI INIT 0.00.
DEF VAR     nv_com1p_ins        AS DECI . 
DEF VAR     nv_com3p_ins        AS DECI .  /*A64-0355 Co-broker */
DEF VAR nv_fi_rstp_t1       AS INTE INIT 0.
DEF VAR nv_fi_rstp_t2       AS INTE INIT 0.
DEF VAR nv_fi_rstp_t3       AS INTE INIT 0.

def var  nv_instcod         as char format "x(10)" init "" .   /*Client Code                               */                     
def var  nv_insttyp         as char format "x(2)" init "" .    /*ประเภทบุคคล                               */                
def var  nv_insttitle       as char format "x(20)" init "" .   /*คำนำหน้า                                  */                     
def var  nv_instname        as char format "x(100)" init "" .  /*ชื่อ                                      */                     
def var  nv_instlname       as char format "x(100)" init "" .  /*นามสกุล                                   */                     
def var  nv_instic          as char format "x(13)" init "" .   /*เลขที่บัตรประชาชน / เลขที่นิติบุคคล       */                    
def var  nv_instbr          as char format "x(10)" init "" .   /*ลำดับที่สาขา                              */                     
def var  nv_instaddr1       as char format "x(50)" init "" .   /*ที่อยู่บรรทัดที่ 1                        */                     
def var  nv_instaddr2       as char format "x(50)" init "" .   /*ที่อยู่บรรทัดที่ 2                        */                     
def var  nv_instaddr3       as char format "x(50)" init "" .   /*ที่อยู่บรรทัดที่ 3                        */                     
def var  nv_instaddr4       as char format "x(50)" init "" .   /*ที่อยู่บรรทัดที่ 4                        */                     
def var  nv_instpost        as char format "x(5)" init "" .    /* รหัสไปรษณีย์                              */                     
def var  nv_instprovcod     as char format "x(2)" init "" .    /*province code                             */                     
def var  nv_instdistcod     as char format "x(2)" init "" .    /*district code                             */                     
def var  nv_instsdistcod    as char format "x(2)" init "" .    /*sub district code                         */                     

/*-- Add ranu A61-0313 --*/
DEF    NEW  SHARED VAR nv_pdprm0   AS DECI FORMAT ">>,>>>,>>9.99-"  INITIAL 0  . 
DEFINE NEW  SHARED VAR nv_44prm    AS INTEGER   FORMAT ">,>>>,>>9"  INITIAL 0 NO-UNDO.
DEFINE new  SHARED VAR nv_supecod  AS CHAR  FORMAT "X(4)".
DEFINE new  SHARED VAR nv_supeprm  AS DECI  FORMAT ">>,>>>,>>9.99-".
DEFINE new  SHARED VAR nv_supevar1 AS CHAR  FORMAT "X(30)".
DEFINE new  SHARED VAR nv_supevar2 AS CHAR  FORMAT "X(30)".
DEFINE new  SHARED VAR nv_supevar  AS CHAR  FORMAT "X(60)".
DEFINE new  SHARED VAR nv_supe00   AS DECI  FORMAT ">>,>>>,>>9.99-".
DEFINE new  SHARED VAR nv_44cod1      AS CHAR    FORMAT "X(4)".
DEFINE new  SHARED VAR nv_44cod2      AS CHAR    FORMAT "X(4)".
DEFINE new  SHARED VAR nv_44          AS INTE    FORMAT ">>>,>>>,>>9".
DEFINE new  SHARED VAR nv_413prm      AS DECI    FORMAT ">,>>>,>>9.99".
DEFINE new  SHARED VAR nv_413var1     AS CHAR    FORMAT "X(30)".
DEFINE new  SHARED VAR nv_413var2     AS CHAR    FORMAT "X(30)".
DEFINE new  SHARED VAR nv_413var      AS CHAR    FORMAT "X(60)".
DEFINE new  SHARED VAR nv_414prm      AS DECI    FORMAT ">,>>>,>>9.99".
DEFINE new  SHARED VAR nv_414var1     AS CHAR    FORMAT "X(30)".
DEFINE new  SHARED VAR nv_414var2     AS CHAR    FORMAT "X(30)".
DEFINE new  SHARED VAR nv_414var      AS CHAR    FORMAT "X(60)".

DEF New  SHARED VAR nv_41cod3   AS CHARACTER    FORMAT "X(4)".   /*A64-0355*/
DEF NEW  SHARED VAR nv_41cod4   AS CHARACTER    FORMAT "X(4)".   /*A64-0355*/

DEFINE VAR  re_comdat    AS CHAR FORMAT "x(10)" INIT "" .        
DEFINE VAR  re_expdat    AS CHAR FORMAT "x(10)" INIT "" .        
/*DEFINE VAR  re_class     AS CHAR FORMAT "x(4)"      .*/ /* A64-0044 */
DEFINE VAR  re_class     AS CHAR FORMAT "x(5)"        .   /* A64-0044 */
DEFINE VAR  re_moddes    AS CHAR FORMAT "x(65)".                 
DEFINE VAR  re_yrmanu    AS CHAR FORMAT "x(5)".
DEFINE VAR  re_seats     AS CHAR FORMAT "x(2)"   INIT "" .       
DEFINE VAR  re_vehuse    AS CHAR FORMAT "x"      INIT "" .       
DEFINE VAR  re_covcod    AS CHAR FORMAT "x"      INIT "" .       
DEFINE VAR  re_garage    AS CHAR FORMAT "x"      INIT "" .       
DEFINE VAR  re_vehreg    AS CHAR FORMAT "x(11)"  INIT "" .       
DEFINE VAR  re_cha_no    AS CHAR FORMAT "x(30)"  INIT "" .       
DEFINE VAR  re_eng_no    AS CHAR FORMAT "x(30)"  INIT "" .       
DEFINE VAR  re_uom1_v    AS CHAR FORMAT "x(30)"  INIT "" .       
DEFINE VAR  re_uom2_v    AS CHAR FORMAT "x(30)"  INIT "" .       
DEFINE VAR  re_uom5_v    AS CHAR FORMAT "x(30)"  INIT "" .       
DEFINE VAR  re_si        AS CHAR FORMAT "x(30)"  INIT "" .       
DEFINE VAR  re_baseprm   AS DECI FORMAT ">>>>>>>>9.99-"  .     
DEFINE VAR  re_41        AS DECI FORMAT ">>>>>>>>9.99-"  .
DEFINE VAR  re_412       AS DECI FORMAT ">>>>>>>>9.99-"  .      /*A64-0355 26/01/2022*/
DEFINE VAR  re_413       AS DECI FORMAT ">>>>>>>>9.99-"  .      /*A64-0355 26/01/2022*/
DEFINE VAR  re_414       AS DECI FORMAT ">>>>>>>>9.99-"  .      /*A64-0355 26/01/2022*/
DEFINE VAR  re_42        AS DECI FORMAT ">>>>>>>>9.99-"  .     
DEFINE VAR  re_43        AS DECI FORMAT ">>>>>>>>9.99-"  .     
DEFINE VAR  re_seat41    AS DECI FORMAT ">>>>9.99-"   .         
DEFINE VAR  re_dedod     AS DECI FORMAT ">>>>>>>>9.99-"  .     
DEFINE VAR  re_addod     AS DECI FORMAT ">>>>>>>>9.99-"  .     
DEFINE VAR  re_dedpd     AS DECI FORMAT ">>>>>>>>9.99-"  .     
DEFINE VAR  re_flet_per  AS CHAR FORMAT "x(30)"  INIT "" .       
DEFINE VAR  re_ncbper    AS CHAR FORMAT "x(30)"  INIT "" .       
DEFINE VAR  re_dss_per   AS CHAR FORMAT "x(30)"  INIT "" .       
DEFINE VAR  re_stf_per   AS DECI FORMAT ">>>>>>>>9.99-"  .     
DEFINE VAR  re_cl_per    AS DECI FORMAT ">>>>>>>>9.99-"  .     
DEFINE VAR  re_bennam1   AS CHAR FORMAT "x(60)"  INIT ""   .
Define var  re_tiname    as char format "x(20)" init "".     
Define var  re_insnam    as char format "x(70)" init "".   
Define var  re_name2     as char format "x(50)" init "".   
Define var  re_name3     as char format "x(50)" init "".   
Define var  re_n_addr1   as char format "x(60)" init "".   
Define var  re_n_addr2   as char format "x(60)" init "".   
Define var  re_n_addr3   as char format "x(60)" init "".   
Define var  re_n_addr4   as char format "x(60)" init "".
DEF    VAR  re_lastname  AS CHAR FORMAT "x(60)" INIT "" .
def    var  re_branch    as char format "x(2)" init "" .
def    var  re_insref    as char format "x(12)" init "" .
def    var  re_agent     as char format "x(10)" init "" .
def    var  re_producer  as char format "x(10)" init "" .
def    var  re_delercode as char format "x(10)" init "" .
def    var  re_fincode   as char format "x(10)" init "" .
def    var  re_payercod  as char format "x(10)" init "" .
def    var  re_vatcode   as char format "x(10)" init "" .
def    var  re_post      as char format "x(5)"  init "" .
def    var  re_provcod   as char format "x(2)"  init "" .
def    var  re_distcod   as char format "x(2)" init "" .
def    var  re_sdistcod  as char format "x(2)" init "" .
def    var  re_firstdat  as CHAR format "X(10)" init "" .
def    var  re_cargrp    as char format "x(2)" init "" .
def    var  re_premt     as DECI format ">>>>>>>9.99" INIT 0 .
DEF    VAR  re_comm      AS DECI FORMAT ">9.99" INIT 0.
DEFINE var  re_driver     AS CHARACTER FORMAT "X(23)" INITIAL "" NO-UNDO.
DEF    VAR  re_prmtdriv   AS DECI FORMAT ">>>>>9.99-" .
DEFINE var  re_acctxt     AS CHAR    FORMAT "x(250)" .
define var  re_chkmemo    as char format "x(10)" .
define var  re_chktxt     as char format "x(10)" .
DEF    VAR  re_chkdriv  AS CHAR FORMAT "x(10)" .
def    var  re_adj       as char format "x(10)" init "" .
DEF    VAR  re_rencnt    AS INT  INIT 0.
def    var  re_agco      as CHAR FORMAT "X10)" .     /*A64-0355*/
def    var  re_commco    as DECI FORMAT ">>9.99-" .  /*A64-0355*/
DEF    VAR  re_comment   AS CHAR FORMAT "x(350)" INIT "" . 
DEF    VAR  re_watt      AS DECI FORMAT ">>>>9.99" . /* A66-0202*/
DEFINE VAR  re_acctyp    AS CHAR FORMAT "x(2)"  INIT ""  .   /*A66-0202*/
/*A67-0212*/
DEF    VAR  re_battyr    AS CHAR FORMAT "X(5)" INIT "" . 
def    VAR  re_battsi    as char format "x(15)" init "" .
def    VAR  re_battprice as char format "x(10)" init "" .
def    VAR  re_battno    as char format "x(50)" init "" .
def    VAR  re_chargno   as char format "x(50)" init "" .
def    VAR  re_chargsi   as char format "x(15)" init "" .
def    VAR  re_battprm   as char format "x(15)" init "" .
def    VAR  re_chargprm  as char format "x(15)" init "" .
/*A67-0212*/

DEF VAR np_prepol    AS CHAR  INIT "" FORMAT "x(12)". 
DEF VAR n_policy72   AS CHAR  INIT "" FORMAT "x(12)".
DEF VAR n_brand1     AS CHAR  INIT "" FORMAT "x(30)".
DEF VAR n_body       AS CHAR  INIT "" FORMAT "x(30)".
DEF VAR n_Engine     AS CHAR  INIT "" FORMAT "x(10)".   
DEF VAR n_Tonn70     AS CHAR  INIT "" FORMAT "x(10)".   
DEF VAR nn_redbook   AS CHAR  INIT "" FORMAT "x(10)".  

DEFINE NEW SHARED TEMP-TABLE wuwd132
    FIELD prepol  AS CHAR FORMAT "x(20)" INIT ""
    FIELD bencod  AS CHAR FORMAT "x(30)" INIT "" 
    FIELD benvar  AS CHAR FORMAT "x(40)" INIT "" 
    FIELD gap_ae  AS LOGICAL INIT NO      /* A64-0355*/
    FIELD pd_aep  AS CHAR    INIT "E"     /* A64-0355*/
    FIELD gap_c   AS DECI FORMAT ">>>,>>>,>>9.99-"    
    FIELD prem_c  AS DECI FORMAT ">>>,>>>,>>9.99-"  .

DEFINE NEW SHARED TEMP-TABLE ws0m009 
/*1*/  FIELD policy     AS CHARACTER    INITIAL ""  
/*2*/  FIELD lnumber    AS INTEGER   
       FIELD ltext      AS CHARACTER    INITIAL "" 
       FIELD ltext2     AS CHARACTER    INITIAL ""
       /* add by : A67-0029 */ 
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
       FIELD dconsen    AS LOGICAL INIT NO.
       /* end A67-0029 */ 

DEFINE NEW SHARED TEMP-TABLE wuwd100 
/*1*/  FIELD policy     AS CHARACTER    INITIAL ""  
/*2*/  FIELD lnumber    AS INTEGER   
       FIELD ltext      AS CHARACTER    INITIAL "" .
DEFINE NEW SHARED TEMP-TABLE wuwd102 
/*1*/  FIELD policy     AS CHARACTER    INITIAL ""  
/*2*/  FIELD lnumber    AS INTEGER   
       FIELD ltext      AS CHARACTER    INITIAL ""  .

/* add by : A64-0355 */
DEFINE NEW SHARED TEMP-TABLE wkuwd132 LIKE stat.pmuwd132.
DEF    VAR nv_cstflg  AS CHAR FORMAT "X(2)".     /*C=CC ; S=Seat ; T=Tons ; W=Watts*/  
DEFINE VAR nv_engcst  AS DECI FORMAT ">>>>>9.99".

DEFINE VAR nv_driage1 AS INTE FORMAT ">>9".
DEFINE VAR nv_driage2 AS INTE FORMAT ">>9".
/*DEF    VAR nv_pdprm0  AS DECI FORMAT ">>>,>>>,>>9.99-". /*เบี้ยผู้ขับขี่*/*/
DEFINE VAR nv_yrmanu  AS INTE FORMAT "9999".
DEFINE VAR nv_vehgrp  AS CHAR FORMAT "X(3)".
DEFINE VAR nv_access  AS CHAR FORMAT "X(3)".
DEFINE VAR nv_supe    AS LOGICAL.
DEFINE VAR nv_totfi   AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_tpbi1si AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_tpbi2si AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_tppdsi  AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE var nv_bipprm  AS DECI FORMAT ">>>,>>>,>>9.99-".  /*add 28/01/2022*/ 
DEFINE var nv_biaprm  AS DECI FORMAT ">>>,>>>,>>9.99-".  /*add 28/01/2022*/ 
DEFINE var nv_pdaprm  AS DECI FORMAT ">>>,>>>,>>9.99-".  /*add 28/01/2022*/ 

DEFINE VAR nv_411si   AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_412si   AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_413si   AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_414si   AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_42si    AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_43si    AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_41prmt  AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_412prmt AS DECI FORMAT ">>>,>>>,>>9.99-".    /*add  26/01/2022 */ 
DEFINE VAR nv_413prmt AS DECI FORMAT ">>>,>>>,>>9.99-".    /*add  26/01/2022 */
DEFINE VAR nv_414prmt AS DECI FORMAT ">>>,>>>,>>9.99-".    /*add  26/01/2022 */
DEFINE VAR nv_42prmt  AS DECI FORMAT ">>>,>>>,>>9.99-". 
DEFINE VAR nv_43prmt  AS DECI FORMAT ">>>,>>>,>>9.99-". 

DEFINE VAR nv_ncbp    AS DECI FORMAT ">,>>9.99-".
DEFINE VAR nv_fletp   AS DECI FORMAT ">,>>9.99-".
DEFINE VAR nv_dspcp   AS DECI FORMAT ">,>>9.99-".
DEFINE VAR nv_dstfp   AS DECI FORMAT ">,>>9.99-".
DEFINE VAR nv_clmp    AS DECI FORMAT ">,>>9.99-".
DEFINE var nv_ncbprm   AS DECI FORMAT ">>>,>>>,>>9.99-".   /*add 28/01/2022*/
DEFINE var nv_fletprm  AS DECI FORMAT ">>>,>>>,>>9.99-".   /*add 28/01/2022*/
DEFINE var nv_dspcprm  AS DECI FORMAT ">>>,>>>,>>9.99-".   /*add 28/01/2022*/
DEFINE var nv_dstfprm  AS DECI FORMAT ">>>,>>>,>>9.99-".   /*add 28/01/2022*/
DEFINE var nv_clmprm   AS DECI FORMAT ">>>,>>>,>>9.99-".   /*add 28/01/2022*/

DEFINE VAR nv_pdprem  AS DECI FORMAT ">>>,>>>,>>9.99-". 
DEFINE VAR nv_netprem AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_gapprem AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_flagprm AS CHAR FORMAT "X(2)". /* N=Net,G=Gross */
DEFINE VAR nv_flgsht  AS CHAR.  /* Short rate = "S" , Pro rate = "P" */ 

DEFINE VAR nv_effdat  AS DATE FORMAT "99/99/9999".
DEFINE VAR nv_ratatt  AS DECI FORMAT ">>,>>>,>>9.9999-".
DEFINE VAR nv_siatt   AS DECI FORMAT ">>,>>>,>>9.99-".
DEFINE VAR nv_netatt  AS DECI FORMAT ">>,>>>,>>9.99-".
DEFINE VAR nv_fltatt  AS DECI FORMAT ">>,>>>,>>9.99-".
DEFINE VAR nv_ncbatt  AS DECI FORMAT ">>,>>>,>>9.99-".
DEFINE VAR nv_dscatt  AS DECI FORMAT ">>,>>>,>>9.99-".
DEFINE VAR nv_attgap  AS DECI FORMAT ">>,>>>,>>9.99-".   /*add  26/01/2022 */ 
DEFINE VAR nv_fltgap  AS DECI FORMAT ">>,>>>,>>9.99-".   /*add  26/01/2022 */ 
DEFINE VAR nv_ncbgap  AS DECI FORMAT ">>,>>>,>>9.99-".   /*add  26/01/2022 */ 
DEFINE VAR nv_dscgap  AS DECI FORMAT ">>,>>>,>>9.99-".   /*add  26/01/2022 */ 
DEFINE VAR nv_packatt AS CHAR FORMAT "X(4)".             /*add  26/01/2022 */ 
DEFINE VAR nv_fcctv   AS LOGICAL . 
define var nv_uom1_c  as char .
define var nv_uom2_c  as char .
define var nv_uom5_c  as char .
define var nv_status  as char .
/* end A64-0355 */
/* A65-0079 */
DEFINE VAR  nv_campcd  AS CHAR FORMAT "X(40)".

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
/* add by : A67-0029  */
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

DEFINE var  nv_uom9_v   AS INTE FORMAT ">>>,>>>,>>9".
DEFINE var  nv_evflg   AS LOGICAL.

/* add by : A67-0029  */
DEFINE NEW SHARED TEMP-TABLE wdrive NO-UNDO 
  FIELD   policy         AS CHARACTER    INITIAL ""  
  FIELD   drivnam        AS CHAR FORMAT "x(2)"  INIT ""     /*Driver          */ 
  FIELD   drivno         AS INT  INIT 0 
  FIELD   ntitle1        AS CHAR FORMAT "X(20)" INIT ""     /*คำนำหน้า              */                        
  FIELD   name1          AS CHAR FORMAT "X(50)" INIT ""     /*ชื่อ                  */                        
  FIELD   lname1         AS CHAR FORMAT "X(50)" INIT ""     /*นามสกุล               */                        
  FIELD   dicno1         AS CHAR FORMAT "X(13)" INIT ""     /*เลขที่บัตรประชาชน     */                        
  FIELD   dgender1       AS CHAR FORMAT "X(20)" INIT ""     /*เพศ                   */                        
  FIELD   dbirth1        AS CHAR FORMAT "X(15)" INIT ""     /*วันเกิด               */                        
  FIELD   doccup1        AS CHAR FORMAT "X(20)" INIT ""     /*ชื่ออาชีพ             */                        
  FIELD   ddriveno1      AS CHAR FORMAT "X(13)" INIT ""     /*เลขที่ใบอนุญาตขับขี่  */
  FIELD   drivexp1       AS CHAR FORMAT "X(13)" INIT ""     /*เลขที่ใบอนุญาตขับขี่ หมดอายุ */ 
  FIELD   dconsen1       AS CHAR FORMAT "x(5)" INIT ""       
  FIELD   dlevel1        AS CHAR FORMAT "X(2)" INIT ""     /*ระดับผู้ขับขี่ */ 

  FIELD   ntitle2        AS CHAR FORMAT "X(20)" INIT ""     /*คำนำหน้า              */                        
  FIELD   name2          AS CHAR FORMAT "X(50)" INIT ""     /*ชื่อ                  */                        
  FIELD   lname2         AS CHAR FORMAT "X(50)" INIT ""     /*นามสกุล               */                        
  FIELD   dicno2         AS CHAR FORMAT "X(13)" INIT ""     /*เลขที่บัตรประชาชน     */                        
  FIELD   dgender2       AS CHAR FORMAT "X(20)" INIT ""     /*เพศ                   */                        
  FIELD   dbirth2        AS CHAR FORMAT "X(15)" INIT ""     /*วันเกิด               */                        
  FIELD   doccup2        AS CHAR FORMAT "X(20)" INIT ""     /*ชื่ออาชีพ             */                        
  FIELD   ddriveno2      AS CHAR FORMAT "X(13)" INIT ""     /*เลขที่ใบอนุญาตขับขี่  */
  FIELD   drivexp2       AS CHAR FORMAT "X(13)" INIT ""     /*เลขที่ใบอนุญาตขับขี่ หมดอายุ */ 
  FIELD   dconsen2       AS CHAR FORMAT "x(5)" INIT ""    
  FIELD   dlevel2        AS CHAR FORMAT "X(2)" INIT ""     /*ระดับผู้ขับขี่ */ 

  FIELD   ntitle3        AS CHAR FORMAT "X(20)" INIT ""     /*คำนำหน้า              */  
  FIELD   name3          AS CHAR FORMAT "X(50)" INIT ""     /*ชื่อ                  */                        
  FIELD   lname3         AS CHAR FORMAT "X(50)" INIT ""     /*นามสกุล               */                        
  FIELD   dicno3         AS CHAR FORMAT "X(13)" INIT ""     /*เลขที่บัตรประชาชน     */                        
  FIELD   dgender3       AS CHAR FORMAT "X(20)" INIT ""     /*เพศ                   */                        
  FIELD   dbirth3        AS CHAR FORMAT "X(15)" INIT ""     /*วันเกิด               */                        
  FIELD   doccup3        AS CHAR FORMAT "X(20)" INIT ""     /*ชื่ออาชีพ             */                        
  FIELD   ddriveno3      AS CHAR FORMAT "X(13)" INIT ""     /*เลขที่ใบอนุญาตขับขี่  */  
  FIELD   drivexp3       AS CHAR FORMAT "X(13)" INIT ""     /*เลขที่ใบอนุญาตขับขี่ หมดอายุ */ 
  FIELD   dconsen3       AS CHAR FORMAT "x(5)" INIT ""     
  FIELD   dlevel3        AS CHAR FORMAT "X(2)" INIT ""     /*ระดับผู้ขับขี่ */ 

  FIELD   ntitle4        AS CHAR FORMAT "X(20)" INIT ""     /*คำนำหน้า              */                        
  FIELD   name4          AS CHAR FORMAT "X(50)" INIT ""     /*ชื่อ                  */                        
  FIELD   lname4         AS CHAR FORMAT "X(50)" INIT ""     /*นามสกุล               */                        
  FIELD   dicno4         AS CHAR FORMAT "X(13)" INIT ""     /*เลขที่บัตรประชาชน     */                        
  FIELD   dgender4       AS CHAR FORMAT "X(20)" INIT ""     /*เพศ                   */                        
  FIELD   dbirth4        AS CHAR FORMAT "X(15)" INIT ""     /*วันเกิด               */                        
  FIELD   doccup4        AS CHAR FORMAT "X(20)" INIT ""     /*ชื่ออาชีพ             */                        
  FIELD   ddriveno4      AS CHAR FORMAT "X(13)" INIT ""     /*เลขที่ใบอนุญาตขับขี่  */  
  FIELD   drivexp4       AS CHAR FORMAT "X(13)" INIT ""     /*เลขที่ใบอนุญาตขับขี่ หมดอายุ */ 
  FIELD   dconsen4       AS CHAR FORMAT "x(5)" INIT ""     
  FIELD   dlevel4        AS CHAR FORMAT "X(2)" INIT ""     /*ระดับผู้ขับขี่ */ 

  FIELD   ntitle5        AS CHAR FORMAT "X(20)" INIT ""     /*คำนำหน้า              */                        
  FIELD   name5          AS CHAR FORMAT "X(50)" INIT ""     /*ชื่อ                  */                        
  FIELD   lname5         AS CHAR FORMAT "X(50)" INIT ""     /*นามสกุล               */                        
  FIELD   dicno5         AS CHAR FORMAT "X(13)" INIT ""     /*เลขที่บัตรประชาชน     */                        
  FIELD   dgender5       AS CHAR FORMAT "X(20)" INIT ""     /*เพศ                   */                        
  FIELD   dbirth5        AS CHAR FORMAT "X(15)" INIT ""     /*วันเกิด               */                        
  FIELD   doccup5        AS CHAR FORMAT "X(20)" INIT ""     /*ชื่ออาชีพ             */                        
  FIELD   ddriveno5      AS CHAR FORMAT "X(13)" INIT ""     /*เลขที่ใบอนุญาตขับขี่  */  
  FIELD   drivexp5       AS CHAR FORMAT "X(13)" INIT ""     /*เลขที่ใบอนุญาตขับขี่ หมดอายุ */
  FIELD   dconsen5       AS CHAR FORMAT "x(5)" INIT ""     
  FIELD   dlevel5        AS CHAR FORMAT "X(2)" INIT "" .    /*ระดับผู้ขับขี่ */ 

DEFINE VAR  nv_level  AS INTE INIT 0.
DEF VAR  re_maksi     AS DECI FORMAT ">>,>>>,>>9.99-" . 
DEF VAR  re_eng_no2   AS CHAR FORMAT "x(50)" INIT "" .  
/* end : A67-0029 */
/*--A68-0044-- */
def var nv_31rate as DECI format ">>9.99-".  /* Rate 31 */
def var nv_31prmt as DECI format ">>,>>>,>>9.99-".  /* เบี้ย 31 */
DEF VAR nv_flag   AS LOGICAL INIT NO .
DEF VAR nv_garage AS CHAR FORMAT "x(2)" .
/* end A68-0044 */







