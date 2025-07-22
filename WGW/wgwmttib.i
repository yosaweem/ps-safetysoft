/*programid   : wgwmttib.i                                                   */ 
/*programname : Match file TIB to Standard Templet                           */ 
/* Copyright	: Safety Insurance Public Company Limited 			         */ 
/*			      บริษัท ประกันคุ้มภัย จำกัด (มหาชน)				         */ 
/*create by   : Ranu I. A67-0222  date. 25/12/2024                              */
/***********************************************************************************/
DEF VAR n_firstdat AS DATE INIT ?.              /*A53-0220*/                  
DEF NEW SHARED VAR nv_producer AS CHAR FORMAT "x(10)".                        
DEF NEW SHARED VAR nv_agent    AS CHAR FORMAT "x(10)".                        
DEF NEW SHARED VAR nv_riskno   Like  sicuw.uwm301.riskgp.                     
DEF NEW SHARED VAR nv_itemno   Like  sicuw.uwm301.itemno.                     
DEF VAR  n_textfi AS CHAR FORMAT  "x(30)" INIT "".    /*A540125*/             
def var  nv_row  as  int  init  0. 
DEFINE TEMP-TABLE wdetail 
 FIELD riskno       as char format "x(3)"  /*init ""*/   /* Risk No   a64-0355 */                      
 FIELD itemno       as char format "x(12)" init "1"  /*ItemNo                                   */                      
 FIELD policyno     as char format "x(20)" /*init ""*/   /*Policy No (เลขที่กรมธรรม์ภาคสมัครใจ)     */                      
 FIELD n_branch     as char format "x(20)" /*init ""*/   /*Branch (สาขา)                            */                      
 FIELD agent        as char format "x(20)" /*init ""*/   /*Agent Code (รหัสตัวแทน)                  */                      
 FIELD producer     as char format "x(20)" /*init ""*/   /*Producer Code                            */                      
 FIELD n_delercode  as char format "x(20)" /*init ""*/   /*Dealer Code (รหัสดีเลอร์)                */                      
 FIELD fincode      as char format "x(20)" /*init ""*/   /*Finance Code (รหัสไฟแนนซ์)               */                      
 FIELD appenno      as char format "x(20)" /*init ""*/   /*Notification Number (เลขที่รับแจ้ง)      */                      
 FIELD salename     as char format "x(20)" /*init ""*/   /*Notification Name (ชื่อผู้แจ้ง)          */                      
 FIELD srate        as char format "x(20)" /*init ""*/   /*Short Rate                               */                      
 FIELD comdat       as char format "x(20)" /*init ""*/   /*Effective Date (วันที่เริ่มความคุ้มครอง) */                      
 FIELD expdat       as char format "x(20)" /*init ""*/   /*Expiry Date (วันที่สิ้นสุดความคุ้มครอง)  */                      
 FIELD agreedat     as char format "x(20)" /*init ""*/   /*Agree Date                               */                      
 FIELD firstdat     as char format "x(20)" /*init ""*/   /*First Date                               */                      
 FIELD packcod      AS CHAR FORMAT "x(10)" /*INIT ""*/   /*รหัส Package   */
 FIELD camp_no      as char format "x(20)" /*init ""*/   /*Campaign Code (รหัสแคมเปญ)               */                      
 FIELD campen       as char format "x(20)" /*init ""*/   /*Campaign Text                            */                      
 FIELD specon       as char format "x(20)" /*init ""*/   /*Spec Con                                 */                      
 FIELD product      as char format "x(20)" /*init ""*/   /*Product Type                             */                      
 FIELD promo        as char format "x(20)" /*init ""*/   /*Promotion Code                           */                      
 FIELD rencnt       as char format "x(20)" /*init ""*/   /*Renew Count                              */                      
 FIELD prepol       as char format "x(20)" /*init ""*/   /*Previous Policy (เลขทีกรมธรรม์ภาคสมัครใจเดิม)*/                  
 FIELD txt1         as char format "x(20)" /*init ""*/   /*Policy Text 1  */                     
 FIELD txt2         as char format "x(20)" /*init ""*/   /*Policy Text 2  */                     
 FIELD txt3         as char format "x(20)" /*init ""*/   /*Policy Text 3  */                     
 FIELD txt4         as char format "x(20)" /*init ""*/   /*Policy Text 4  */                     
 FIELD txt5         as char format "x(20)" /*init ""*/   /*Policy Text 5  */                     
 FIELD txt6         as char format "x(20)" /*init ""*/   /*Policy Text 6  */                     
 FIELD txt7         as char format "x(20)" /*init ""*/   /*Policy Text 7  */                     
 FIELD txt8         as char format "x(20)" /*init ""*/   /*Policy Text 8  */                     
 FIELD txt9         as char format "x(20)" /*init ""*/   /*Policy Text 9  */                     
 FIELD txt10        as char format "x(20)" /*init ""*/   /*Policy Text 10 */                     
 FIELD memo1        as char format "x(20)" /*init ""*/   /*Memo Text 1    */                     
 FIELD memo2        as char format "x(20)" /*init ""*/   /*Memo Text 2    */                     
 FIELD memo3        as char format "x(20)" /*init ""*/   /*Memo Text 3    */                     
 FIELD memo4        as char format "x(20)" /*init ""*/   /*Memo Text 4    */                     
 FIELD memo5        as char format "x(20)" /*init ""*/   /*Memo Text 5    */                     
 FIELD memo6        as char format "x(20)" /*init ""*/   /*Memo Text 6    */                     
 FIELD memo7        as char format "x(20)" /*init ""*/   /*Memo Text 7    */                     
 FIELD memo8        as char format "x(20)" /*init ""*/   /*Memo Text 8    */                     
 FIELD memo9        as char format "x(20)" /*init ""*/   /*Memo Text 9    */                     
 FIELD memo10       as char format "x(20)" /*init ""*/   /*Memo Text 10   */                     
 FIELD accdata1     as char format "x(20)" /*init ""*/   /*Accessory Text 1 */                     
 FIELD accdata2     as char format "x(20)" /*init ""*/   /*Accessory Text 2 */                     
 FIELD accdata3     as char format "x(20)" /*init ""*/   /*Accessory Text 3 */                     
 FIELD accdata4     as char format "x(20)" /*init ""*/   /*Accessory Text 4 */                     
 FIELD accdata5     as char format "x(20)" /*init ""*/   /*Accessory Text 5 */                     
 FIELD accdata6     as char format "x(20)" /*init ""*/   /*Accessory Text 6 */                     
 FIELD accdata7     as char format "x(20)" /*init ""*/   /*Accessory Text 7 */                     
 FIELD accdata8     as char format "x(20)" /*init ""*/   /*Accessory Text 8 */                     
 FIELD accdata9     as char format "x(20)" /*init ""*/   /*Accessory Text 9 */                     
 FIELD accdata10    as char format "x(20)" /*init ""*/   /*Accessory Text 10*/                     
 FIELD compul       as char format "x(20)" /*init ""*/   /*กรมธรรม์ซื้อควบ (Y/N)  */ 
 FIELD insref       as char format "x(20)" /*init ""*/   /*รหัสลูกค้า  A64-0355   */    
 FIELD instyp       as char format "x(20)" /*init ""*/   /*ประเภทบุคคล            */                     
 FIELD inslang      as char format "x(20)" /*init ""*/   /*ภาษาที่ใช้สร้าง Cilent Code               */                     
 FIELD tiname       as char format "x(20)" /*init ""*/   /*คำนำหน้า               */                     
 FIELD insnam       as char format "x(20)" /*init ""*/   /*ชื่อ                   */                     
 FIELD lastname     as char format "x(20)" /*init ""*/   /*นามสกุล                */                     
 FIELD icno         as char format "x(20)" /*init ""*/   /*เลขที่บัตรประชาชน / เลขที่นิติบุคคล       */                     
 FIELD insbr        as char format "x(20)" /*init ""*/   /*ลำดับที่สาขา           */                     
 FIELD occup        as char format "x(20)" /*init ""*/   /*อาชีพ                  */                     
 FIELD addr         as char format "x(20)" /*init ""*/   /*ที่อยู่บรรทัดที่ 1     */                     
 FIELD tambon       as char format "x(20)" /*init ""*/   /*ที่อยู่บรรทัดที่ 2     */                     
 FIELD amper        as char format "x(20)" /*init ""*/   /*ที่อยู่บรรทัดที่ 3     */              
 FIELD country      as char format "x(20)" /*init ""*/   /*ที่อยู่บรรทัดที่ 4     */                
 FIELD post         as char format "x(20)" /*init ""*/   /*รหัสไปรษณีย์           */                     
 FIELD provcod      as char format "x(20)" /*init ""*/   /*province code          */                     
 FIELD distcod      as char format "x(20)" /*init ""*/   /*district code          */                     
 FIELD sdistcod     as char format "x(20)" /*init ""*/   /*sub district code      */ 
 FIELD jpae         as char format "x(12)" /*init ""*/   /* A64-0355 :  ae  new Xmm600 งาน Japanes*/    
 FIELD jpjtl        as char format "x(12)" /*init ""*/   /* A64-0355 :  jtl new Xmm600 งาน Japanes*/    
 FIELD jpts         as char format "x(12)" /*init ""*/   /* A64-0355 :  ts  new Xmm600 งาน Japanes*/    
 FIELD gender       as char format "x(20)" /*init ""*/   /*Gender (Male/Female/Other)                */                     
 FIELD tele1        as char format "x(20)" /*init ""*/   /*Telephone 1            */                     
 FIELD tele2        as char format "x(20)" /*init ""*/   /*Telephone 2            */                
 FIELD mail1        as char format "x(20)" /*init ""*/   /*E-Mail 1               */                     
 FIELD mail2        as char format "x(20)" /*init ""*/   /*E-Mail 2               */                     
 FIELD mail3        as char format "x(20)" /*init ""*/   /*E-Mail 3               */                     
 FIELD mail4        as char format "x(20)" /*init ""*/   /*E-Mail 4               */                     
 FIELD mail5        as char format "x(20)" /*init ""*/   /*E-Mail 5               */                     
 FIELD mail6        as char format "x(20)" /*init ""*/   /*E-Mail 6               */                     
 FIELD mail7        as char format "x(20)" /*init ""*/   /*E-Mail 7               */                     
 FIELD mail8        as char format "x(20)" /*init ""*/   /*E-Mail 8               */                     
 FIELD mail9        as char format "x(20)" /*init ""*/   /*E-Mail 9               */                     
 FIELD mail10       as char format "x(20)" /*init ""*/   /*E-Mail 10              */                     
 FIELD fax          as char format "x(20)" /*init ""*/   /*Fax                    */                     
 FIELD lineID       as char format "x(20)" /*init ""*/   /*Line ID                */                     
 FIELD name2        as char format "x(20)" /*init ""*/   /*CareOf1                */                     
 FIELD name3        as char format "x(20)" /*init ""*/   /*CareOf2                */                     
 FIELD benname      as char format "x(20)" /*init ""*/   /*Benefit Name           */                     
 FIELD payercod     as char format "x(20)" /*init ""*/   /*Payer Code             */                     
 FIELD vatcode      as char format "x(20)" /*init ""*/   /*VAT Code               */                     
 FIELD instcod1     as char format "x(20)" /*init ""*/   /*Client Code            */                     
 FIELD insttyp1     as char format "x(20)" /*init ""*/   /*ประเภทบุคคล            */                
 FIELD insttitle1   as char format "x(20)" /*init ""*/   /*คำนำหน้า               */                     
 FIELD instname1    as char format "x(20)" /*init ""*/   /*ชื่อ                   */                     
 FIELD instlname1   as char format "x(20)" /*init ""*/   /*นามสกุล                */                     
 FIELD instic1      as char format "x(20)" /*init ""*/   /*เลขที่บัตรประชาชน / เลขที่นิติบุคคล       */                    
 FIELD instbr1      as char format "x(20)" /*init ""*/   /*ลำดับที่สาขา           */                     
 FIELD instaddr11   as char format "x(20)" /*init ""*/   /*ที่อยู่บรรทัดที่ 1     */                     
 FIELD instaddr21   as char format "x(20)" /*init ""*/   /*ที่อยู่บรรทัดที่ 2     */                     
 FIELD instaddr31   as char format "x(20)" /*init ""*/   /*ที่อยู่บรรทัดที่ 3     */                     
 FIELD instaddr41   as char format "x(20)" /*init ""*/   /*ที่อยู่บรรทัดที่ 4     */                     
 FIELD instpost1    as char format "x(20)" /*init ""*/   /* รหัสไปรษณีย์          */                     
 FIELD instprovcod1 as char format "x(20)" /*init ""*/   /*province code          */                     
 FIELD instdistcod1 as char format "x(20)" /*init ""*/   /*district code          */                     
 FIELD instsdistcod1 as char format "x(20)" /*init ""*/   /*sub district code      */                     
 FIELD instprm1     as char format "x(20)" /*init ""*/   /*เบี้ยก่อนภาษีอากร      */                     
 FIELD instrstp1    as char format "x(20)" /*init ""*/   /*อากร                   */                     
 FIELD instrtax1    as char format "x(20)" /*init ""*/   /*ภาษี                   */                     
 FIELD instcomm01   as char format "x(20)" /*init ""*/   /*คอมมิชชั่น 1           */                     
 FIELD instcomm12   as char format "x(20)" /*init ""*/   /*คอมมิชชั่น 2 (co-broker)     */                     
 FIELD instcod2     as char format "x(20)" /*init ""*/   /*Client Code            */    
 FIELD insttyp2     as char format "x(20)" /*init ""*/   /*ประเภทบุคคล            */    
 FIELD insttitle2   as char format "x(20)" /*init ""*/   /*คำนำหน้า               */    
 FIELD instname2    as char format "x(20)" /*init ""*/   /*ชื่อ                   */    
 FIELD instlname2   as char format "x(20)" /*init ""*/   /*นามสกุล                */    
 FIELD instic2      as char format "x(20)" /*init ""*/   /*เลขที่บัตรประชาชน / เลขที่นิติบุคคล*/                     
 FIELD instbr2      as char format "x(20)" /*init ""*/   /*ลำดับที่สาขา           */          
 FIELD instaddr12   as char format "x(20)" /*init ""*/   /*ที่อยู่บรรทัดที่ 1     */          
 FIELD instaddr22   as char format "x(20)" /*init ""*/   /*ที่อยู่บรรทัดที่ 2     */          
 FIELD instaddr32   as char format "x(20)" /*init ""*/   /*ที่อยู่บรรทัดที่ 3     */          
 FIELD instaddr42   as char format "x(20)" /*init ""*/   /*ที่อยู่บรรทัดที่ 4     */          
 FIELD instpost2    as char format "x(20)" /*init ""*/   /*รหัสไปรษณีย์           */          
 FIELD instprovcod2 as char format "x(20)" /*init ""*/   /*province code          */          
 FIELD instdistcod2 as char format "x(20)" /*init ""*/   /*district code          */          
 FIELD instsdistcod2 as char format "x(20)" /*init ""*/   /*sub district code      */          
 FIELD instprm2     as char format "x(20)" /*init ""*/   /*เบี้ยก่อนภาษีอากร      */          
 FIELD instrstp2    as char format "x(20)" /*init ""*/   /*อากร                   */          
 FIELD instrtax2    as char format "x(20)" /*init ""*/   /*ภาษี                   */          
 FIELD instcomm02   as char format "x(20)" /*init ""*/   /*คอมมิชชั่น 1           */          
 FIELD instcomm22   as char format "x(20)" /*init ""*/   /*คอมมิชชั่น 2 (co-broker)     */    
 FIELD instcod3     as char format "x(20)" /*init ""*/   /*Client Code            */          
 FIELD insttyp3     as char format "x(20)" /*init ""*/   /*ประเภทบุคคล            */          
 FIELD insttitle3   as char format "x(20)" /*init ""*/   /*คำนำหน้า               */          
 FIELD instname3    as char format "x(20)" /*init ""*/   /*ชื่อ                   */          
 FIELD instlname3   as char format "x(20)" /*init ""*/   /*นามสกุล                */          
 FIELD instic3      as char format "x(20)" /*init ""*/   /*เลขที่บัตรประชาชน/เลขที่นิติบุคคล  */                     
 FIELD instbr3      as char format "x(20)" /*init ""*/   /*ลำดับที่สาขา          */                     
 FIELD instaddr13   as char format "x(20)" /*init ""*/   /*ที่อยู่บรรทัดที่ 1    */                     
 FIELD instaddr23   as char format "x(20)" /*init ""*/   /*ที่อยู่บรรทัดที่ 2    */                     
 FIELD instaddr33   as char format "x(20)" /*init ""*/   /*ที่อยู่บรรทัดที่ 3    */                     
 FIELD instaddr43   as char format "x(20)" /*init ""*/   /*ที่อยู่บรรทัดที่ 4    */                     
 FIELD instpost3    as char format "x(20)" /*init ""*/   /*รหัสไปรษณีย์          */                     
 FIELD instprovcod3 as char format "x(20)" /*init ""*/   /*province code         */                     
 FIELD instdistcod3 as char format "x(20)" /*init ""*/   /*district code         */                     
 FIELD instsdistcod3 as char format "x(20)" /*init ""*/   /*sub district code     */                     
 FIELD instprm3     as char format "x(20)" /*init ""*/   /*เบี้ยก่อนภาษีอากร     */              
 FIELD instrstp3    as char format "x(20)" /*init ""*/   /*อากร                  */                                     
 FIELD instrtax3    as char format "x(20)" /*init ""*/   /*ภาษี                  */              
 FIELD instcomm03   as char format "x(20)" /*init ""*/   /*คอมมิชชั่น 1          */              
 FIELD instcomm23   as char format "x(20)" /*init ""*/   /*คอมมิชชั่น 2 (co-broker)                  */              
 FIELD covcod       as char format "x(20)" /*init ""*/   /*Cover Type (ประเภทความคุ้มครอง)           */              
 FIELD garage       as char format "x(20)" /*init ""*/   /*Garage (ประเภทการซ่อม ซ่อมอู่/ซ่อมห้าง)   */              
 FIELD special      as char format "x(20)" /*init ""*/   /*Spacial Equipment Flag(A/Blank)*/              
 FIELD inspec       as char format "x(20)" /*init ""*/   /*Inspection            */       
 FIELD class70      as char format "x(20)" /*init ""*/   /*รหัสรถภาคสมัครใจ (110/120/…)   */              
 FIELD vehuse       as char format "x(2)"  /*init ""*/    /* A64-0355 : vehuse 15/12/2021 */
 FIELD redbook      as char format "x(20)" /*init ""*/   /*redbook    */  /*a65-0079*/      
 FIELD brand        as char format "x(20)" /*init ""*/   /*ยี่ห้อรถ              */       
 FIELD model        as char format "x(20)" /*init ""*/   /*ชื่อรุ่นรถ            */       
 FIELD submodel     as char format "x(20)" /*init ""*/   /*ชื่อรุ่นย่อยรถ        */       
 FIELD yrmanu       as char format "x(20)" /*init ""*/   /*ปีรุ่นรถ              */       
 FIELD chasno       as char format "x(20)" /*init ""*/   /*หมายเลขตัวถัง         */       
 FIELD engno        as char format "x(20)" /*init ""*/   /*หมายเลขเครื่อง        */       
 FIELD seat         as char format "x(20)" /*init ""*/   /*จำนวนที่นั่ง (รวมผู้ขับขี่)    */              
 FIELD engcc        as char format "x(20)" /*init ""*/   /*ปริมาตรกระบอกสูบ (CC) */              
 FIELD weight       as char format "x(20)" /*init ""*/   /*น้ำหนัก (ตัน)         */              
 FIELD watt         as char format "x(20)" /*init ""*/   /*Kilowatt              */              
 FIELD body         as char format "x(20)" /*init ""*/   /*รหัสแบบตัวถัง         */              
 FIELD ntype        as char format "x(20)" /*init ""*/   /*ป้ายแดง (Y/N)         */              
 FIELD re_year      as char format "x(20)" /*init ""*/   /*ปีที่จดทะเบียน        */              
 FIELD vehreg       as char format "x(20)" /*init ""*/   /*เลขทะเบียนรถ          */              
 FIELD re_country   as char format "x(20)" /*init ""*/   /*จังหวัดที่จดทะเบียน   */              
 FIELD cargrp       as char format "x(20)" /*init ""*/   /*Group Car (กลุ่มรถ)   */              
 FIELD colorcar     as char format "x(20)" /*init ""*/   /*Color (สี)            */              
 FIELD fule         as char format "x(20)" /*init ""*/    /*Fule (เชื้อเพลิง)     */              
 FIELD drivnam      as char format "x(2)"  /*init ""*/     /*Driver Number          */              
 FIELD ntitle1      as char format "x(20)" /*init ""*/    /*คำนำหน้า              */              
 FIELD drivername1  as char format "x(20)" /*init ""*/    /*ชื่อ                  */              
 FIELD dname2       as char format "x(20)" /*init ""*/    /*นามสกุล               */              
 FIELD dicno        as char format "x(20)" /*init ""*/    /*เลขที่บัตรประชาชน     */              
 FIELD dgender1     as char format "x(20)" /*init ""*/    /*เพศ                   */              
 FIELD dbirth       as char format "x(20)" /*init ""*/    /*วันเกิด               */              
 FIELD doccup       as char format "x(20)" /*init ""*/    /*ชื่ออาชีพ             */              
 FIELD ddriveno     as char format "x(20)" /*init ""*/    /*เลขที่ใบอนุญาตขับขี่  */            
 FIELD ntitle2      as char format "x(20)" /*init ""*/    /*คำนำหน้า              */              
 FIELD drivername2  as char format "x(20)" /*init ""*/    /*ชื่อ                  */              
 FIELD ddname1      as char format "x(20)" /*init ""*/    /*นามสกุล               */              
 FIELD ddicno       as char format "x(20)" /*init ""*/    /*เลขที่บัตรประชาชน     */              
 FIELD dgender2     as char format "x(20)" /*init ""*/    /*เพศ                   */              
 FIELD ddbirth      as char format "x(20)" /*init ""*/    /*วันเกิด               */              
 FIELD ddoccup      as char format "x(20)" /*init ""*/    /*ชื่ออาชีพ             */              
 FIELD dddriveno    as char format "x(20)" /*init ""*/    /*เลขที่ใบอนุญาตขับขี่  */              
 FIELD baseplus     as char format "x(20)" /*init ""*/    /*Base Premium Plus     */              
 FIELD siplus       as char format "x(20)" /*init ""*/    /*Sum Insured Plus      */              
 FIELD rs10         as char format "x(20)" /*init ""*/    /*RS10 Amount           */              
 FIELD comper       as char format "x(20)" /*init ""*/    /*TPBI / person         */              
 FIELD comacc       as char format "x(20)" /*init ""*/    /*TPBI / occurrence     */              
 FIELD deductpd     as char format "x(20)" /*init ""*/    /*TPPD                  */              
 FIELD DOD          as char format "x(20)" /*init ""*/    /*Deduct / OD           */
 FIELD DOD1         as char format "x(20)" /*init ""*/    /*Deduct / dod1         */   /*A65-0079*/
 FIELD DPD          as char format "x(20)" /*init ""*/    /*Deduct / PD           */              
 FIELD tpfire       as char format "x(20)" /*init ""*/    /*Theft & Fire          */              
 FIELD NO_41        as char format "x(20)" /*init ""*/    /*PA1.1 / driver        */              
 FIELD ac2          as char format "x(20)" /*init ""*/    /*PA1.1 no.of passenger */              
 FIELD ac4          as char format "x(20)" /*init ""*/    /*PA1.1 / passenger     */              
 FIELD ac5          as char format "x(20)" /*init ""*/    /*PA1.2 / driver        */              
 FIELD ac6          as char format "x(20)" /*init ""*/    /*PA1.2 no.of passenger */              
 FIELD ac7          as char format "x(20)" /*init ""*/    /*PA1.2 / passenger     */              
 FIELD NO_42        as char format "x(20)" /*init ""*/    /*PA2                   */              
 FIELD NO_43        as char format "x(20)" /*init ""*/    /*PA3                   */              
 FIELD base         as char format "x(20)" /*init ""*/    /*Base Premium          */              
 FIELD unname       as char format "x(20)" /*init ""*/    /*Unname                */              
 FIELD nname        as char format "x(20)" /*init ""*/    /*Name                  */              
 FIELD tpbi         as char format "x(20)" /*init ""*/    /*TPBI/Person Amount    */   
 FIELD bi2          AS CHAR FORMAT "x(20)" /*INIT ""*/    /*TPBI/occurance Amount */  /*A64-0355 :28/01/20222 */   
 FIELD tppd         as char format "x(20)" /*init ""*/    /*TPPD Amount           */ 
 FIELD dodamt       as char format "x(20)" /*init ""*/     /* dod premt */             /*A65-0079*/
 FIELD dod1amt      as char format "x(20)" /*init ""*/     /* dod1 premt */            /*A65-0079*/
 FIELD dpdamt       as char format "x(20)" /*init ""*/     /* dpd premt */             /*A65-0079*/
 FIELD ry01         as char format "x(20)" /*init ""*/    /*RY411 Amount           */ 
 FIELD ry412        as char format "x(20)" /*init ""*/    /*RY412 Amount           */  /*A64-0355 26/01/2022 */
 FIELD ry413        as char format "x(20)" /*init ""*/    /*RY413 Amount           */  /*A64-0355 26/01/2022 */
 FIELD ry414        as char format "x(20)" /*init ""*/    /*RY414 Amount           */  /*A64-0355 26/01/2022 */
 FIELD ry02         as char format "x(20)" /*init ""*/    /*RY02 Amount           */              
 FIELD ry03         as char format "x(20)" /*init ""*/    /*RY03 Amount           */              
 FIELD fleet        as char format "x(20)" /*init ""*/    /*Fleet%                */              
 FIELD ncb          as char format "x(20)" /*init ""*/    /*NCB%                  */              
 FIELD claim        as char format "x(20)" /*init ""*/    /*Load Claim%           */              
 FIELD dspc         as char format "x(20)" /*init ""*/    /*Other Disc.%          */              
 FIELD cctv         as char format "x(20)" /*init ""*/    /*CCTV%                 */              
 FIELD dstf         as char format "x(20)" /*init ""*/    /*Walkin Disc.%         */              
 FIELD fleetprem    as char format "x(20)" /*init ""*/    /*Fleet Amount          */              
 FIELD ncbprem      as char format "x(20)" /*init ""*/    /*NCB Amount            */              
 FIELD clprem       as char format "x(20)" /*init ""*/    /*Load Claim Amount     */              
 FIELD dspcprem     as char format "x(20)" /*init ""*/    /*Other Disc. Amount    */              
 FIELD cctvprem     as char format "x(20)" /*init ""*/    /*CCTV Amount           */              
 FIELD dstfprem     as char format "x(20)" /*init ""*/    /*Walk in Disc. Amount  */              
 FIELD premt        as char format "x(20)" /*init ""*/    /*เบี้ยสุทธิ            */              
 FIELD rstp_t       as char format "x(20)" /*init ""*/    /*Stamp Duty            */              
 FIELD rtax_t       as char format "x(20)" /*init ""*/    /*VAT                   */              
 FIELD comper70     as char format "x(20)" /*init ""*/    /*Commission %          */              
 FIELD comprem70    as char format "x(20)" /*init ""*/    /*Commission Amount     */              
 FIELD agco70       as char format "x(20)" /*init ""*/    /*Agent Code co-broker (รหัสตัวแทน)*/              
 FIELD comco_per70  as char format "x(20)" /*init ""*/    /*Commission % co-broker*/         
 FIELD comco_prem70 as char format "x(20)" /*init ""*/    /*Commission Amount co-broker*/              
 FIELD dgpackge     as char format "x(20)" /*init ""*/    /*Package (Attach Coverage)  */              
 FIELD danger1      as char format "x(20)" /*init ""*/    /*Dangerous Object 1    */   
 FIELD danger2      as char format "x(20)" /*init ""*/    /*Dangerous Object 2    */   
 FIELD dgsi         as char format "x(20)" /*init ""*/    /*Sum Insured           */   
 FIELD dgrate       as char format "x(20)" /*init ""*/    /*Rate%                 */   
 FIELD dgfeet       as char format "x(20)" /*init ""*/    /*Fleet%                */   
 FIELD dgncb        as char format "x(20)" /*init ""*/    /*NCB%                  */   
 FIELD dgdisc       as char format "x(20)" /*init ""*/    /*Discount%             */ 
 FIELD dgwdisc      as char format "x(20)" /*init ""*/    /*Walkin Discount%        */ 
 FIELD dgatt        as char format "x(20)" /*init ""*/    /*Premium Attach Coverage */              
 FIELD dgfeetprm    as char format "x(20)" /*init ""*/    /*Discount Fleet        */   
 FIELD dgncbprm     as char format "x(20)" /*init ""*/    /*Discount NCB          */   
 FIELD dgdiscprm    as char format "x(20)" /*init ""*/    /*Other Discount        */  
 FIELD dgWdiscprm   as char format "x(20)" /*init ""*/    /*Other Discount        */   
 FIELD dgprem       as char format "x(20)" /*init ""*/    /*Net Premium           */ 
 FIELD dgrstp_t     as char format "x(20)" /*init ""*/    /*Stamp Duty            */                
 FIELD dgrtax_t     as char format "x(20)" /*init ""*/    /*VAT                   */                
 FIELD dgcomper     as char format "x(20)" /*init ""*/    /*Commission %          */                
 FIELD dgcomprem    as char format "x(20)" /*init ""*/    /*Commission Amount     */    
 FIELD cltxt        as char format "x(20)" /*init ""*/    /*Claim Text            */   
 FIELD clamount     as char format "x(20)" /*init ""*/    /*Claim Amount          */   
 FIELD faultno      as char format "x(20)" /*init ""*/    /*Claim Count Fault     */   
 FIELD faultprm     as char format "x(20)" /*init ""*/    /*Claim Count Fault Amount   */              
 FIELD goodno       as char format "x(20)" /*init ""*/    /*Claim Count Good           */              
 FIELD goodprm      as char format "x(20)" /*init ""*/    /*Claim Count Good Amount    */              
 FIELD loss         as char format "x(20)" /*init ""*/    /*Loss Ratio % (Not TP)      */              
 FIELD compolusory  as char format "x(20)" /*init ""*/    /*Compulsory Policy Number (เลขที่กรมธรรม์ พรบ.)*/          
 FIELD barcode      as char format "x(20)" /*init ""*/    /*Barcode No.                    */                
 FIELD class72      as char format "x(20)" /*init ""*/    /*Compulsory Class (รหัส พรบ.)   */                
 FIELD dstf72       as char format "x(20)" /*init ""*/    /*Compulsory Walk In Discount %  */                
 FIELD dstfprem72   as char format "x(20)" /*init ""*/    /*Compulsory Walk In Discount Amount      */                
 FIELD premt72      as char format "x(20)" /*init ""*/    /*เบี้ยสุทธิ พ.ร.บ. กรณี "กรมธรรม์ซื้อควบ"*/                
 FIELD rstp_t72     as char format "x(20)" /*init ""*/    /*Stamp Duty            */                
 FIELD rtax_t72     as char format "x(20)" /*init ""*/    /*VAT                   */                
 FIELD comper72     as char format "x(20)" /*init ""*/    /*Commission %          */                
 FIELD comprem72    as char format "x(20)" /*init ""*/    /*Commission Amount     */    
 FIELD instot       AS INT INIT 0
 FIELD drivexp1     AS CHAR FORMAT "X(13)" /*INIT ""*/    /*เลขที่ใบอนุญาตขับขี่ หมดอายุ */ 
 FIELD dconsen1     AS CHAR FORMAT "x(5)"  /*INIT ""*/ 
 FIELD dlevel1      AS CHAR FORMAT "X(2)"  /*INIT ""*/    /*ระดับผู้ขับขี่ */ 
 FIELD drivexp2     AS CHAR FORMAT "X(13)" /*INIT ""*/    /*เลขที่ใบอนุญาตขับขี่ หมดอายุ */
 FIELD dconsen2     AS CHAR FORMAT "x(5)"  /*INIT ""*/ 
 FIELD dlevel2      AS CHAR FORMAT "X(2)"  /*INIT ""*/    /*ระดับผู้ขับขี่ */ 
 FIELD ntitle3      AS CHAR FORMAT "X(20)" /*INIT ""*/    /*คำนำหน้า              */  
 FIELD dname3       AS CHAR FORMAT "X(50)" /*INIT ""*/    /*ชื่อ                  */                        
 FIELD dlname3      AS CHAR FORMAT "X(50)" /*INIT ""*/    /*นามสกุล               */                        
 FIELD dicno3       AS CHAR FORMAT "X(13)" /*INIT ""*/    /*เลขที่บัตรประชาชน     */                        
 FIELD dgender3     AS CHAR FORMAT "X(20)" /*INIT ""*/    /*เพศ                   */                        
 FIELD dbirth3      AS CHAR FORMAT "X(15)" /*INIT ""*/    /*วันเกิด               */                        
 FIELD doccup3      AS CHAR FORMAT "X(20)" /*INIT ""*/    /*ชื่ออาชีพ             */                        
 FIELD ddriveno3    AS CHAR FORMAT "X(13)" /*INIT ""*/    /*เลขที่ใบอนุญาตขับขี่  */  
 FIELD drivexp3     AS CHAR FORMAT "X(13)" /*INIT ""*/    /*เลขที่ใบอนุญาตขับขี่ หมดอายุ */ 
 FIELD dconsen3     AS CHAR FORMAT "x(5)"  /*INIT ""*/ 
 FIELD dlevel3      AS CHAR FORMAT "X(2)"  /*INIT ""*/    /*ระดับผู้ขับขี่ */ 
 FIELD ntitle4      AS CHAR FORMAT "X(20)" /*INIT ""*/     /*คำนำหน้า              */                        
 FIELD dname4       AS CHAR FORMAT "X(50)" /*INIT ""*/     /*ชื่อ                  */                        
 FIELD dlname4      AS CHAR FORMAT "X(50)" /*INIT ""*/     /*นามสกุล               */                        
 FIELD dicno4       AS CHAR FORMAT "X(13)" /*INIT ""*/     /*เลขที่บัตรประชาชน     */                        
 FIELD dgender4     AS CHAR FORMAT "X(20)" /*INIT ""*/     /*เพศ                   */                        
 FIELD dbirth4      AS CHAR FORMAT "X(15)" /*INIT ""*/     /*วันเกิด               */                        
 FIELD doccup4      AS CHAR FORMAT "X(20)" /*INIT ""*/     /*ชื่ออาชีพ             */                        
 FIELD ddriveno4    AS CHAR FORMAT "X(13)" /*INIT ""*/     /*เลขที่ใบอนุญาตขับขี่  */  
 FIELD drivexp4     AS CHAR FORMAT "X(13)" /*INIT ""*/     /*เลขที่ใบอนุญาตขับขี่ หมดอายุ */
 FIELD dconsen4     AS CHAR FORMAT "x(5)"  /*INIT ""*/ 
 FIELD dlevel4      AS CHAR FORMAT "X(2)"  /*INIT ""*/     /*ระดับผู้ขับขี่ */ 
 FIELD ntitle5      AS CHAR FORMAT "X(20)" /*INIT ""*/    /*คำนำหน้า              */                        
 FIELD dname5       AS CHAR FORMAT "X(50)" /*INIT ""*/    /*ชื่อ                  */                        
 FIELD dlname5      AS CHAR FORMAT "X(50)" /*INIT ""*/    /*นามสกุล               */                        
 FIELD dicno5       AS CHAR FORMAT "X(13)" /*INIT ""*/    /*เลขที่บัตรประชาชน     */                        
 FIELD dgender5     AS CHAR FORMAT "X(20)" /*INIT ""*/    /*เพศ                   */                        
 FIELD dbirth5      AS CHAR FORMAT "X(15)" /*INIT ""*/    /*วันเกิด               */                        
 FIELD doccup5      AS CHAR FORMAT "X(20)" /*INIT ""*/    /*ชื่ออาชีพ             */                        
 FIELD ddriveno5    AS CHAR FORMAT "X(13)" /*INIT ""*/    /*เลขที่ใบอนุญาตขับขี่  */  
 FIELD drivexp5     AS CHAR FORMAT "X(13)" /*INIT ""*/    /*เลขที่ใบอนุญาตขับขี่ หมดอายุ */
 FIELD dconsen5     AS CHAR FORMAT "x(5)"  /*INIT ""*/ 
 FIELD dlevel5      AS CHAR FORMAT "X(2)"  /*INIT ""*/    /*ระดับผู้ขับขี่ */ 
 FIELD maksi        as char format "X(20)" /*init ""*/
 FIELD eng_no2      as char format "X(20)" /*init ""*/
 FIELD battper      as char format "X(20)" /*init ""*/
 FIELD battrate     as char format "X(20)" /*init ""*/
 FIELD battyr       as char format "X(20)" /*init ""*/
 FIELD battsi       as char format "X(20)" /*init ""*/
 FIELD battprice    as char format "X(20)" /*init ""*/
 FIELD battno       as char format "X(20)" /*init ""*/
 FIELD battprm      as char format "X(20)" /*init ""*/
 FIELD chargno      as char format "X(20)" /*init ""*/
 FIELD chargsi      as char format "X(20)" /*init ""*/
 FIELD chargrate    as char format "X(20)" /*init ""*/
 FIELD chargprm     as char format "X(20)" /*init ""*/ 
 FIELD comdat72     AS CHAR FORMAT "x(15)" /*INIT ""*/
 FIELD expdat72     AS CHAR FORMAT "x(15)" /*INIT ""*/  
 FIELD bdate        as char format "x(15)" /*init ""*/ 
 FIELD nation       as char format "x(20)" /*init ""*/ 
 FIELD prmtotal70   AS CHAR FORMAT "x(20)" /*INIT ""*/ 
 FIELD prmtotal72   AS CHAR FORMAT "x(20)" /*INIT ""*/  
 FIELD comment      AS CHAR FORMAT "x(250)" 
 FIELD pass         AS CHAR FORMAT "x(10)"        
 FIELD polyr        AS CHAR FORMAT "x(25)"  
 FIELD senddate     AS CHAR FORMAT "x(15)" .
DEFINE STREAM  ns1.

DEFINE VAR  re_comdat    AS CHAR FORMAT "x(10)" INIT "" .        
DEFINE VAR  re_expdat    AS CHAR FORMAT "x(10)" INIT "" .        
DEFINE VAR  re_class     AS CHAR FORMAT "x(5)" .   
DEFINE VAR  re_moddes    AS CHAR FORMAT "x(65)".                 
DEFINE VAR  re_yrmanu    AS CHAR FORMAT "x(5)".
DEFINE VAR  re_poltyp    AS CHAR FORMAT "x(15)" .
/*DEFINE VAR  re_seats     AS CHAR FORMAT "x(2)"   INIT "" . */       
DEFINE VAR  re_vehuse    AS CHAR FORMAT "x"      INIT "" .      
DEFINE VAR  re_covcod    AS CHAR FORMAT "x"      INIT "" .       
DEFINE VAR  re_garage    AS CHAR FORMAT "x"      INIT "" .       
DEFINE VAR  re_vehreg    AS CHAR FORMAT "x(11)"  INIT "" .       
DEFINE VAR  re_cha_no    AS CHAR FORMAT "x(30)"  INIT "" .       
DEFINE VAR  re_eng_no    AS CHAR FORMAT "x(30)"  INIT "" .     
DEFINE VAR  re_colors    AS CHAR FORMAT "x(10)"  INIT "" . 
DEFINE VAR  re_insp      AS CHAR FORMAT "x(5)"  INIT "" . 
/*DEFINE VAR  re_uom1_v    AS CHAR FORMAT "x(30)"  INIT "" .       
DEFINE VAR  re_uom2_v    AS CHAR FORMAT "x(30)"  INIT "" .       
DEFINE VAR  re_uom5_v    AS CHAR FORMAT "x(30)"  INIT "" .  */     
DEFINE VAR  re_si        AS CHAR FORMAT "x(30)"  INIT "" .       
/*DEFINE VAR  re_baseprm   AS DECI FORMAT ">>>>>>>>9.99-"  .     
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
Define var  re_insnam    as char format "x(70)" init "".   */
Define var  re_name2     as char format "x(50)" init "".   
Define var  re_name3     as char format "x(50)" init "".   
/*Define var  re_n_addr1   as char format "x(60)" init "".   
Define var  re_n_addr2   as char format "x(60)" init "".   
Define var  re_n_addr3   as char format "x(60)" init "".   
Define var  re_n_addr4   as char format "x(60)" init "".
DEF    VAR  re_lastname  AS CHAR FORMAT "x(60)" INIT "" .*/
def    var  re_branch    as char format "x(2)" init "" .
def    var  re_insref    as char format "x(12)" init "" .
def    var  re_agent     as char format "x(10)" init "" .
def    var  re_producer  as char format "x(10)" init "" .
def    var  re_delercode as char format "x(10)" init "" .
def    var  re_fincode   as char format "x(10)" init "" .
def    var  re_payercod  as char format "x(10)" init "" .
def    var  re_vatcode   as char format "x(10)" init "" .
/*def    var  re_post      as char format "x(5)"  init "" .
def    var  re_provcod   as char format "x(2)"  init "" .
def    var  re_distcod   as char format "x(2)" init "" .
def    var  re_sdistcod  as char format "x(2)" init "" .*/
def    var  re_firstdat  as CHAR format "X(10)" init "" .
/*def    var  re_cargrp    as char format "x(2)" init "" .*/
def    var  re_premt     as DECI format ">>>>>>>9.99" INIT 0 .
/*DEF    VAR  re_comm      AS DECI FORMAT ">9.99" INIT 0.
DEFINE var  re_driver     AS CHARACTER FORMAT "X(23)" INITIAL "" NO-UNDO.
DEF    VAR  re_prmtdriv   AS DECI FORMAT ">>>>>9.99-" .*/
DEFINE var  re_acctxt     AS CHAR    FORMAT "x(250)" .
/*define var  re_chkmemo    as char format "x(10)" .
define var  re_chktxt     as char format "x(10)" .
DEF    VAR  re_chkdriv  AS CHAR FORMAT "x(10)" .*/
def    var  re_adj       as char format "x(10)" init "" .
/*DEF    VAR  re_rencnt    AS INT  INIT 0.
def    var  re_agco      as CHAR FORMAT "X10)" .     /*A64-0355*/
def    var  re_commco    as DECI FORMAT ">>9.99-" .  /*A64-0355*/*/
DEF    VAR  re_comment   AS CHAR FORMAT "x(350)" INIT "" . 
DEF    VAR  re_loss      AS CHAR FORMAT "x(10)" INIT "" .
def    var  re_promo     as char format "x(15)" init "" .  
def    var  re_product   as char format "x(15)" init "" .  
DEF    VAR   re_campno   AS CHAR FORMAT "x(15)" INIT "" .
/*DEF    VAR  re_watt      AS DECI FORMAT ">>>>9.99" . /* A66-0202*/
DEFINE VAR  re_acctyp    AS CHAR FORMAT "x(2)"  INIT ""  .   /*A66-0202*/
/*A67-0212*/
DEF    VAR  re_battyr    AS CHAR FORMAT "X(5)" INIT "" . 
def    VAR  re_battsi    as char format "x(15)" init "" .
def    VAR  re_battprice as char format "x(10)" init "" .
def    VAR  re_battno    as char format "x(50)" init "" .
def    VAR  re_chargno   as char format "x(50)" init "" .
def    VAR  re_chargsi   as char format "x(15)" init "" .
def    VAR  re_battprm   as char format "x(15)" init "" .
def    VAR  re_chargprm  as char format "x(15)" init "" .*/

def  var nv_acc as char format "x(1000)"   init "" .
def  var nv_acc1 as char format "x(60)"   init "" .
def  var nv_acc2 as char format "x(60)"   init "" .
def  var nv_acc3 as char format "x(60)"   init "" .
def  var nv_acc4 as char format "x(60)"   init "" .
def  var nv_acc5 as char format "x(60)"   init "" .
DEF  VAR nv_acc6 AS CHAR FORMAT "x(60)"   init "" .
DEF  VAR nv_acc7 AS CHAR FORMAT "x(60)"   init "" .
DEF  VAR nv_acc8 AS CHAR FORMAT "x(60)"   init "" .
DEF  VAR nv_acc9 AS CHAR FORMAT "x(60)"   init "" .
DEF  VAR nv_acc10 AS CHAR FORMAT "x(60)"  init ""  .
DEF  VAR nv_acc11 AS CHAR FORMAT "x(60)"  init ""  .
DEF  VAR nv_acc12 AS CHAR FORMAT "x(60)"  init ""  .
DEF  VAR nv_acc13 AS CHAR FORMAT "x(60)"  init ""  .
DEF  VAR nv_acc14 AS CHAR FORMAT "x(60)"  init ""  .
DEF  VAR nv_acc15 AS CHAR FORMAT "x(60)"  init ""  .
def  var nv_acc16 as char format "x(60)"  INIT "".
def  var nv_acc17 as char format "x(60)"  INIT "".
def  var nv_acc18 as char format "x(60)"  INIT "".
def  var nv_acc19 as char format "x(60)"  INIT "".
def  var nv_acc20 as char format "x(60)"  INIT "".

def  var nv_txt as char format "x(1000)"   init "" .
def  var nv_txt1 as char format "x(100)"   init "" .
def  var nv_txt2 as char format "x(100)"   init "" .
def  var nv_txt3 as char format "x(100)"   init "" .
def  var nv_txt4 as char format "x(100)"   init "" .
def  var nv_txt5 as char format "x(100)"   init "" .
DEF  VAR nv_txt6 AS CHAR FORMAT "x(100)"   init "" .
DEF  VAR nv_txt7 AS CHAR FORMAT "x(100)"   init "" .
DEF  VAR nv_txt8 AS CHAR FORMAT "x(100)"   init "" .
DEF  VAR nv_txt9 AS CHAR FORMAT "x(100)"   init "" .
DEF  VAR nv_txt10 AS CHAR FORMAT "x(100)"  init ""  .
DEF  VAR nv_txt11 AS CHAR FORMAT "x(100)"  init ""  .
DEF  VAR nv_txt12 AS CHAR FORMAT "x(100)"  init ""  .
DEF  VAR nv_txt13 AS CHAR FORMAT "x(100)"  init ""  .
DEF  VAR nv_txt14 AS CHAR FORMAT "x(100)"  init ""  .
DEF  VAR nv_txt15 AS CHAR FORMAT "x(100)"  init ""  .
def  var nv_txt16 as char format "x(100)"  INIT "".
def  var nv_txt17 as char format "x(100)"  INIT "".
def  var nv_txt18 as char format "x(100)"  INIT "".
def  var nv_txt19 as char format "x(100)"  INIT "".
def  var nv_txt20 as char format "x(100)"  INIT "".





