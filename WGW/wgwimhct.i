/*programid   :wgwimhct.i                                                    */ 
/*programname : load text file HCT to GW                                     */ 
/* Copyright  : Safety Insurance Public Company Limited 			         */ 
/*			    บริษัท ประกันคุ้มภัย จำกัด (มหาชน)				             */ 
/*create by   : Kridtiya i. A64-0414   date .27/11/2021                      
                ปรับโปรแกรมให้สามารถนำเข้า text file HCT to GW system        */
/* Modify by : Ranu I. A68-0061 แก้ไข Format file แจ้งงานเป็น CSV */                 
/*****************************************************************************/
DEFINE   TEMP-TABLE wdetail NO-UNDO                                           
    FIELD  n_text001    as char   /*1     เลขที่ใบคำขอ          HA641108150   */
    FIELD  n_text002    as char   /*2     วันที่ใบคำขอ          12/11/2021    */
    FIELD  n_text003    as char   /*3     เลขที่รับแจ้ง         21/TMS11-3098 */
    FIELD  n_text004    as char   /*4     วันที่เริ่มคุ้มครอง              */  
    FIELD  n_text005    as char   /*5     วันที่สิ้นสุด                    */  
    FIELD  n_text006    as char   /*6     รหัสบริษัทประกันภัย              */  
    FIELD  n_text007    as char   /*7     ประเภทรถ                         */  
    FIELD  n_text008    as char   /*8     ประเภทการขาย          N          */      
    FIELD  n_text009    as char   /*9     ประเภทแคมเปญ                     */  
    FIELD  n_text010    as char   /*10    จำนวนเงินที่เรียกเก็บ 0000000.00 */  
    FIELD  n_text011    as char   /*11    ประเภทความคุ้มครอง        0      */      
    FIELD  n_text012    as char   /*12    ประเภทประกัน                     */  
    FIELD  n_text013    as char   /*13    ประเภทการซ่อม         GARAGE     */          
    FIELD  n_text014    as char   /*14    ผู้บันทึก                        */  
    FIELD  n_text015    as char   /*15    คำนำหน้า                         */  
    FIELD  n_text016    as char   /*16    ชื่อลูกค้า                       */  
    FIELD  n_text017    as char   /*17    ชื่อกลาง                         */  
    FIELD  n_text018    as char   /*18    นามสกุล                          */  
    FIELD  n_text019    as char   /*19    ที่อยู่ 5 หมู่ 1                 */  
    FIELD  n_text020    as char   /*20    ถนน     ถนน                      */  
    FIELD  n_text021    as char   /*21    แขวง/ตำบล  แคนใหญ่               */  
    FIELD  n_text022    as char   /*22    เขต/อำเภอ  เมืองร้อยเอ็ด         */
    FIELD  n_text023    as char   /*23    จังหวัด จดทะเบียน                */
    FIELD  n_text024    as char   /*24    รหัสไปรษณีย์      45000          */
    FIELD  n_text025    as char   /*25    อาชีพ                            */
    FIELD  n_text026    as char   /*26    วันเกิด                          */   
    FIELD  n_text027    as char   /*27    เลขที่บัตรประชาชน                */
    FIELD  n_text028    as char   /*28    เลขที่ใบขับขี่                   */
    FIELD  n_text029    as char   /*29    ยี่ห้อรถ                         */
    FIELD  n_text030    as char   /*30    กลุ่มรถยนต์      5               */     
    FIELD  n_text031    as char   /*31    หมายเลขตัวถัง                    */
    FIELD  n_text032    as char   /*32    หมายเลขเครื่อง                   */
    FIELD  n_text033    as char   /*33    ชื่อรุ่นรถ                       */
    FIELD  n_text034    as char   /*34    รุ่นปี   2015                    */     
    FIELD  n_text035    as char   /*35    ชื่อประเภทรถ     V AT            */     
    FIELD  n_text036    as char   /*36    แบบตัวถัง  เก๋งสองตอน            */   
    FIELD  n_text037    as char   /*37    รหัสประเภทรถ       1             */       
    FIELD  n_text038    as char   /*38    รหัสลักษณะการใช้งาน              */
    FIELD  n_text039    as char   /*39    จำนวนที่นั่ง                     */
    FIELD  n_text040    as char   /*40    ปริมาตรกระบอกสูบ                 */
    FIELD  n_text041    as char   /*41    ชื่อสีรถ                         */
    FIELD  n_text042    as char   /*42    เลขทะเบียนรถ                     */
    FIELD  n_text043    as char   /*43    จังหวัดที่จดทะเบียน      ร้อยเอ็ด */    
    FIELD  n_text044    as char   /*44    ปีที่จดทะเบียน  2014              */    
    FIELD  n_text045    as char   /*45    หมายเหตุ    /1.ฟิล์มลามิล่า 5,500 */    
    FIELD  n_text046    as char   /*46    วงเงินทุนประกัน       00000000000.00    */    
    FIELD  n_text047    as char   /*47    เบี้ยประกัน               00000000600.00*/    
    FIELD  n_text048    as char   /*48    อากร                  00000000003.00    */    
    FIELD  n_text049    as char   /*49    จำนวนเงินภาษี         00000000042.21    */    
    FIELD  n_text050    as char   /*50    เบี้ยประกันรวม        00000000645.21    */    
    FIELD  n_text051    as char   /*51    เบี้ยประกันรวมทั้งหมด 00000015309.56    */
    FIELD  n_text052    as char   /*52    อัตราส่วนลดประวัติดี  00000000000.00    */
    FIELD  n_text053    as char   /*53    ส่วนลดประวัติดี       00000000000.00    */    
    FIELD  n_text054    as char   /*54    หมายเลขสติ๊กเกอร์                       */
    FIELD  n_text055    as char   /*55    เลขที่กรมธรรมเดิม          78-70-63/H00458  */ 
    FIELD  n_text056    as char   /*56    Flag ระบุชื่อ      0                    */
    FIELD  n_text057    as char   /*57    Flag ไม่ระบุชื่อ      1                 */
    FIELD  n_text058    as char   /*58    คำนำหน้า                                */
    FIELD  n_text059    as char   /*59    ชื่อผู้ขับขี่คนที่ 1                    */
    FIELD  n_text060    as char   /*60    ชื่อกลาง                                */
    FIELD  n_text061    as char   /*61    นามสกุล                                 */
    FIELD  n_text062    as char   /*62    อาชีพ                                   */
    FIELD  n_text063    as char   /*63    วันเกิด                                 */
    FIELD  n_text064    as char   /*64    เลขที่บัตรประชาชน                       */
    FIELD  n_text065    as char   /*65    เลขที่ใบขับขี่                          */
    FIELD  n_text066    as char   /*66    คำนำหน้า                                */
    FIELD  n_text067    as char   /*67    ชื่อผู้ขับขี่คนที่ 2                    */
    FIELD  n_text068    as char   /*68    ชื่อกลาง                                */
    FIELD  n_text069    as char   /*69    นามสกุล                                 */
    FIELD  n_text070    as char   /*70    อาชีพ                                   */
    FIELD  n_text071    as char   /*71    วันเกิด                                 */
    FIELD  n_text072    as char   /*72    เลขที่บัตรประชาชน                       */
    FIELD  n_text073    as char   /*73    เลขที่ใบขับขี่                          */
    FIELD  n_text074    as char   /*74    ผู้รับผลประโยชน์                        */
    FIELD  n_text075    as char   /*75    ความเสียหายต่อชีวิต (บาท/คน)      00000000000.00 */
    FIELD  n_text076    as char   /*76    ความเสียหายต่อชีวิต (บาท/ครั้ง)   00000000000.00 */
    FIELD  n_text077    as char   /*77    ความเสียหายต่อทรัพย์สิน           00000000000.00 */
    FIELD  n_text078    as char   /*78    ความเสียหายส่วนแรกบุคคล           00000000000.00 */
    FIELD  n_text079    as char   /*79    ความเสียหายต่อรถยนต์              00000000000.00 */
    FIELD  n_text080    as char   /*80    ความเสียหายส่วนแรกรถยนต์              00000000000.00 */
    FIELD  n_text081    as char   /*81    รถยนต์สูญหาย/ไฟไหม้                   00000000000.00 */
    FIELD  n_text082    as char   /*82    อุบัติเหตุส่วนบุคคลเสียชีวิตผู้ขับขี่             00000000000.00 */
    FIELD  n_text083    as char   /*83    อุบัติเหตุส่วนบุคคลเสียชีวิตจน.ผู้โดยสาร              00             */
    FIELD  n_text084    as char   /*84    อุบัติเหตุส่วนบุคคลเสียชีวิตผู้โดยสาร/ครั้ง           00000000000.00 */
    FIELD  n_text085    as char   /*85    อุบัติเหตุส่วนบุคคลทุพพลภาพชั่วคราว ผู้ขับขี่     00000000000.00 */
    FIELD  n_text086    as char   /*86    อุบัติเหตุส่วนบุคคลทุพพลภาพชั่วคราว จน.ผู้โดยสาร  00             */
    FIELD  n_text087    as char   /*87    อุบัติเหตุส่วนบุคคลทุพพลภาพชั่วคราวผู้โดยสาร/ครั้ง00000000000.00 */
    FIELD  n_text088    as char   /*88    ค่ารักษาพยาบาล                                    00000000000.00 */
    FIELD  n_text089    as char   /*89    การประกันตัวผู้ขับขี่                             00000000000.00 */
    FIELD  n_text090    as char   /*90    สถานะข้อมูล                                           NEW        */         
    FIELD  n_text091    as char   /*91    ประเภทผู้แจ้งประกัน          DLR              */  
    FIELD  n_text092    as char   /*92    รหัสบริษัทผู้แจ้งประกัน  RJM                  */  
    FIELD  n_text093    as char   /*93    สาขาบริษัทผู้แจ้งประกัน  สำนักงานใหญ่         */  
    FIELD  n_text094    as char   /*94    ชื่อผู้ติดต่อ / Salesman ชฎาภรณ์ นนทะคำจันทร์ */  
    FIELD  n_text095    as char   /*95    บริษัทที่ปล่อยรถ         RJS                  */   
    FIELD  n_text096    as char   /*96    สาขาบริษัทที่ปล่อยรถ     สำนักงานใหญ่         */  
    FIELD  n_text097    as char   /*97    Honda Project            นอกโครงการ           */       
    FIELD  n_text098    as char   /*98    อายุรถ                   008                  */               
    FIELD  n_text099    as char   /*99    บริการเสริมพิเศษ 1 AA                         */  
    FIELD  n_text100    as char   /*100   ราคาบริการเสริมพิเศษ 1                        */  
    FIELD  n_text101    as char   /*101   บริการเสริมพิเศษ 2                            */  
    FIELD  n_text102    as char   /*102   ราคาบริการเสริมพิเศษ 2                        */  
    FIELD  n_text103    as char   /*103   บริการเสริมพิเศษ 3                            */  
    FIELD  n_text104    as char   /*104   ราคาบริการเสริมพิเศษ 3                        */  
    FIELD  n_text105    as char   /*105   บริการเสริมพิเศษ 4                            */  
    FIELD  n_text106    as char   /*106   ราคาบริการเสริมพิเศษ 4                        */  
    FIELD  n_text107    as char   /*107   บริการเสริมพิเศษ 5                            */  
    FIELD  n_text108    as char   /*108   ราคาบริการเสริมพิเศษ 5                        */  
    FIELD  n_text109    as char   /*109   เลมที่       /                                */  
    FIELD  n_text110    as char   /*110   วันที่    13/11/2021                          */  
    FIELD  n_text111    as char   /*111   จำนวนเงิน     00000015309.56                  */  
    FIELD  n_text112    as char   /*112   ชำระโดย  CASH                                 */  
    FIELD  n_text113    as char   /*113   เลขที่บัตรนายหน้า    6204023613               */  
    FIELD  n_text114    as char   /*114   ออกใบเสร็จในนาม   1                           */  
    FIELD  n_text115    as char   /*115   ชื่อใบเสร็จ     ชื่อใบเสร็จ น.ส.มะลิ สีลาดเลา */  
    FIELD  n_text116    as char   /*116   รายละเอียดเคมเปญ                              */  
    FIELD  n_text117    as char   /*117   รับประกันจ่ายแน่ๆ                             */  
    FIELD  n_text118    as char   /*118   ผ่อนชำระ/เดือน                                */  
    FIELD  n_text119    as char   /*119   บัตรเครดิตธนาคาร                              */  
    FIELD  n_text120    as char   /*120   ประเภทการแจ้งงาน          R                   */  
    FIELD  n_text121    as char   /*121   รวมราคาอุปกรณ์เสริม       5500.00             */  
    FIELD  n_text122    as char   /*122   รายละเอียดอุปกรณ์เสริม                        */  
    FIELD  n_text123    as char   /*123   สาขาบริษัทของผู้เอาประกัน (ลูกค้า)      สาขาบริษัทของผู้เอาประกัน (ลูกค้า) */                                     
    FIELD  n_text124    as char   /*124   ยี่ห้อเคลือบแก้ว        ยี่ห้อเคลือบแก้ว */                                                       
    FIELD  n_text125    as char   /*125   ราคาเคลือบแก้ว  ราคาเคลือบแก้ว  0    */                                                   
    FIELD  n_text126    as char   /*126   ชื่อบริษัทเต็มบนใบกำกับภาษี1    ชื่อบริษัทเต็มบนใบกำกับภาษี1    น.ส.มะลิ สีลาดเลา  */                     
    FIELD  n_text127    as char   /*127   สาขาบริษัทบนใบกำกับภาษี1        สาขาบริษัทบนใบกำกับภาษี1                            */                    
    FIELD  n_text128    as char   /*128   ที่อยู่บนใบกำกับภาษี1   ที่อยู่บนใบกำกับภาษี1   5 หมู่ 1  แคนใหญ่ เมืองร้อยเอ็ด จ.ร้อยเอ็ด 45000 */
    FIELD  n_text129    as char   /*129   เลขที่ผู้เสียภาษี1      เลขที่ผู้เสียภาษี1                                                           */
    FIELD  n_text130    as char   /*130   อัตราเบี้ยตามใบกำกับ1 (เบี้ยรวมอากรและภาษี)     อัตราเบี้ยตามใบกำกับ1 (เบี้ยรวมอากรและภาษี) 645.21   */                   
    FIELD  n_text131    as char   /*131   ชื่อบริษัทเต็มบนใบกำกับภาษี2    ชื่อบริษัทเต็มบนใบกำกับภาษี2                                     */
    FIELD  n_text132    as char   /*132   สาขาบริษัทบนใบกำกับภาษี2        สาขาบริษัทบนใบกำกับภาษี2                                             */
    FIELD  n_text133    as char   /*133   ที่อยู่บนใบกำกับภาษี2   ที่อยู่บนใบกำกับภาษี2                                                    */
    FIELD  n_text134    as char   /*134   เลขที่ผู้เสียภาษี2      เลขที่ผู้เสียภาษี2                                                           */
    FIELD  n_text135    as char   /*135   อัตราเบี้ยตามใบกำกับ2 (เบี้ยรวมอากรและภาษี)     อัตราเบี้ยตามใบกำกับ2 (เบี้ยรวมอากรและภาษี) 0        */
    FIELD  n_text136    as char   /*136   ชื่อบริษัทเต็มบนใบกำกับภาษี3    ชื่อบริษัทเต็มบนใบกำกับภาษี3                                     */
    FIELD  n_text137    as char   /*137   สาขาบริษัทบนใบกำกับภาษี3        สาขาบริษัทบนใบกำกับภาษี3                                             */
    FIELD  n_text138    as char   /*138   ที่อยู่บนใบกำกับภาษี3   ที่อยู่บนใบกำกับภาษี3                                                    */
    FIELD  n_text139    as char   /*139   เลขที่ผู้เสียภาษี3      เลขที่ผู้เสียภาษี3                                                           */
    FIELD  n_text140    as char   /*140   อัตราเบี้ยตามใบกำกับ3 (เบี้ยรวมอากรและภาษี)     อัตราเบี้ยตามใบกำกับ3 (เบี้ยรวมอากรและภาษี) 0        */
    FIELD  n_text141    as char   /*141   เลขที่แคมเปญ    เลขที่แคมเปญ            */
    FIELD  n_text142    as char  /*142   ประเภทการชำระเบี้ย      ประเภทการชำระเบี้ย  */ 
    /*-- data new format ----*/
    field typepol       as char format "x(20)"  
    field typecar       as char format "x(20)"  
    field maksi         as char format "x(20)"  
    field drivexp1      as char format "x(20)"  
    FIELD drivcon1      AS CHAR FORMAT "x(20)"  
    field dlevel1       as char format "x(20)"  
    field dgender1      as char format "x(20)"  
    field drelation1    as char format "x(20)"  
    field drivexp2      as char format "x(20)"  
    FIELD drivcon2      AS CHAR FORMAT "x(20)"  
    field dlevel2       as char format "x(20)"  
    field dgender2      as char format "x(20)"  
    field drelation2    as char format "x(20)"  
    field ntitle3       as char format "x(20)"  
    field dname3        as char format "x(20)"  
    field dcname3       as char format "x(20)"  
    field dlname3       as char format "x(20)"  
    field doccup3       as char format "x(20)"  
    field dbirth3       as char format "x(20)"  
    field dicno3        as char format "x(20)"  
    field ddriveno3     as char format "x(20)"  
    field drivexp3      as char format "x(20)"  
    FIELD drivcon3      AS CHAR FORMAT "x(20)"  
    field dlevel3       as char format "x(20)"  
    field dgender3      as char format "x(20)"  
    field drelation3    as char format "x(20)"  
    field ntitle4       as char format "x(20)"  
    field dname4        as char format "x(20)"  
    field dcname4       as char format "x(20)"  
    field dlname4       as char format "x(20)"  
    field doccup4       as char format "x(20)"  
    field dbirth4       as char format "x(20)"  
    field dicno4        as char format "x(20)"  
    field ddriveno4     as char format "x(20)"  
    field drivexp4      as char format "x(20)"  
    FIELD drivcon4      AS CHAR FORMAT "x(20)"  
    field dlevel4       as char format "x(20)"  
    field dgender4      as char format "x(20)"  
    field drelation4    as char format "x(20)"  
    field ntitle5       as char format "x(20)"  
    field dname5        as char format "x(20)"  
    field dcname5       as char format "x(20)"  
    field dlname5       as char format "x(20)"  
    field doccup5       as char format "x(20)"  
    field dbirth5       as char format "x(20)"  
    field dicno5        as char format "x(20)"  
    field ddriveno5     as char format "x(20)"  
    field drivexp5      as char format "x(20)"  
    FIELD drivcon5      AS CHAR FORMAT "x(20)"  
    field dlevel5       as char format "x(20)"  
    field dgender5      as char format "x(20)"  
    field drelation5    as char format "x(20)"  
    field chargflg      as char format "x(20)"  
    field chargprice    as char format "x(20)"  
    field chargno       as char format "x(20)"  
    field chargprm      as char format "x(20)"  
    field battflg       as char format "x(20)"  
    field battprice     as char format "x(20)"  
    field battno        as char format "x(20)"  
    field battprm       as char format "x(20)"  
    field battdate      as char format "x(20)"  
    field net_re1       as char format "x(20)"  
    field stam_re1      as char format "x(20)"  
    field vat_re1       as char format "x(20)"  
    field inscode_re2   as char format "x(20)"  
    field net_re2       as char format "x(20)"  
    field stam_re2      as char format "x(20)"  
    field vat_re2       as char format "x(20)"  
    field inscode_re3   as char format "x(20)"  
    field net_re3       as char format "x(20)"  
    field stam_re3      as char format "x(20)"  
    field vat_re3       as char format "x(20)"  .

 DEFINE TEMP-TABLE wimproducer                       
    FIELD idno      AS CHAR FORMAT "x(10)" INIT ""   
    FIELD saletype  AS CHAR FORMAT "x(10)" INIT ""   
    FIELD camname   AS CHAR FORMAT "x(30)" INIT ""   
    FIELD notitype  AS CHAR FORMAT "x(10)" INIT ""   
    FIELD producer  AS CHAR FORMAT "x(10)" INIT "".  

 def var wf_policyno       as char .  
def var wf_cndat          as char .
def var wf_appenno        as char .
def var wf_comdat         as char .
def var wf_expdat         as char .
def var wf_comcode        as char .
def var wf_cartyp         as char .
def var wf_saletyp        as char .
def var wf_typcom         as char .
def var wf_covhct         as char .
def var wf_garage         as char .
def var wf_typepol        as char .
def var wf_bysave         as char .
def var wf_tiname         as char .
def var wf_insnam         as char .
def var wf_name2          as char .
def var wf_name3          as char .
def var wf_addr           as char .
def var wf_road           as char .
def var wf_tambon         as char .
def var wf_amper          as char .
def var wf_country        as char .
def var wf_post           as char .
def var wf_icno           as char .
def var wf_brdealer       as char .
def var wf_occup          as char .
def var wf_birthdat       as char .
def var wf_driverno       as char .
def var wf_brand          as char .
def var wf_cargrp         as char .
def var wf_typecar        as char .
def var wf_chasno         as char .
def var wf_eng            as char .
def var wf_model          as char .
def var wf_caryear        as char .
def var wf_carcode        as char .
def var wf_maksi          as char .
def var wf_body           as char .
def var wf_carno          as char .
def var wf_seat           as char .
def var wf_engcc          as char .
def var wf_colorcar       as char .
def var wf_vehreg         as char .
def var wf_re_country     as char .
def var wf_re_year        as char .
DEF VAR wf_si             AS CHAR .
def var wf_premt          as char .
def var wf_rstp_t         as char .
def var wf_rtax_t         as char .
def var wf_prem_r         as char .
def var wf_gap            as char .
def var wf_ncb            as char .
def var wf_ncbprem        as char .
def var wf_stk            as char .
def var wf_prepol         as char .
def var wf_ntitle1        as char .
def var wf_drivername1    as char .
def var wf_dname1         as char .
def var wf_dname2         as char .
def var wf_docoup         as char .
def var wf_dbirth         as char .
def var wf_dicno          as char .
def var wf_ddriveno       as char .
def var wf_drivexp1       as char .
def var wf_drivcon1       as char .
def var wf_dlevel1        as char .
def var wf_dgender1       as char .
def var wf_drelation1     as char .
def var wf_ntitle2        as char .
def var wf_drivername2    as char .
def var wf_ddname1        as char .
def var wf_ddname2        as char .
def var wf_ddocoup        as char .
def var wf_ddbirth        as char .
def var wf_ddicno         as char .
def var wf_dddriveno      as char .
def var wf_drivexp2       as char .
def var wf_drivcon2       as char .
def var wf_dlevel2        as char .
def var wf_dgender2       as char .
def var wf_drelation2     as char .
def var wf_ntitle3        as char .
def var wf_dname3         as char .
def var wf_dcname3        as char .
def var wf_dlname3        as char .
def var wf_doccup3        as char .
def var wf_dbirth3        as char .
def var wf_dicno3         as char .
def var wf_ddriveno3      as char .
def var wf_drivexp3       as char .
def var wf_drivcon3       as char .
def var wf_dlevel3        as char .
def var wf_dgender3       as char .
def var wf_drelation3     as char .
def var wf_ntitle4        as char .
def var wf_dname4         as char .
def var wf_dcname4        as char .
def var wf_dlname4        as char .
def var wf_doccup4        as char .
def var wf_dbirth4        as char .
def var wf_dicno4         as char .
def var wf_ddriveno4      as char .
def var wf_drivexp4       as char .
def var wf_drivcon4       as char .
def var wf_dlevel4        as char .
def var wf_dgender4       as char .
def var wf_drelation4     as char .
def var wf_ntitle5        as char .
def var wf_dname5         as char .
def var wf_dcname5        as char .
def var wf_dlname5        as char .
def var wf_doccup5        as char .
def var wf_dbirth5        as char .
def var wf_dicno5         as char .
def var wf_ddriveno5      as char .
def var wf_drivexp5       as char .
def var wf_drivcon5       as char .
def var wf_dlevel5        as char .
def var wf_dgender5       as char .
def var wf_drelation5     as char .
def var wf_benname        as char .
def var wf_comper         as char .
def var wf_comacc         as char .
def var wf_tp1            as char .
def var wf_tp2            as char .
def var wf_deductda       as char .
def var wf_deductpd       as char .
def var wf_tpfire         as char .
def var wf_ac1            as char .
def var wf_ac2            as char .
def var wf_ac3            as char .
def var wf_ac4            as char .
def var wf_ac5            as char .
def var wf_ac6            as char .
def var wf_ac7            as char .
def var wf_drityp         as char .
def var wf_typrequest     as char .
def var wf_comrequest     as char .
def var wf_brrequest      as char .
def var wf_salename       as char .
def var wf_comcar         as char .
def var wf_brcar          as char .
def var wf_carold         as char .
def var wf_ac_date        as char .
def var wf_ac_amount      as char .
def var wf_ac_pay         as char .
def var wf_ac_agent       as char .
def var wf_detailcam      as char .
def var wf_ins_pay        as char .
def var wf_n_month        as char .
def var wf_n_bank         as char .
def var wf_TYPE_notify    as char .
def var wf_price_acc      as char .
def var wf_accdata        as char .
def var wf_chargflg       as char .
def var wf_chargprice     as char .
def var wf_chargno        as char .
def var wf_chargprm       as char .
def var wf_battflg        as char .
def var wf_battprice      as char .
def var wf_battno         as char .
def var wf_battprm        as char .
def var wf_battdate       as char .
def var wf_brand_gals     as char .
def var wf_brand_galsprm  as char .
def var wf_voicnam        as char .
def var wf_companyre1     as char .
def var wf_companybr1     as char .
def var wf_addr_re1       as char .
def var wf_idno_re1       as char .
def var wf_net_re1        as char .
def var wf_stam_re1       as char .
def var wf_vat_re1        as char .
def var wf_premt_re1      as char .
def var wf_inscode_re2    as char .
def var wf_companyre2     as char .
def var wf_companybr2     as char .
def var wf_addr_re2       as char .
def var wf_idno_re2       as char .
def var wf_net_re2        as char .
def var wf_stam_re2       as char .
def var wf_vat_re2        as char .
def var wf_premt_re2      as char .
def var wf_inscode_re3    as char .
def var wf_companyre3     as char .
def var wf_companybr3     as char .
def var wf_addr_re3       as char .
def var wf_idno_re3       as char .
def var wf_net_re3        as char .
def var wf_stam_re3       as char .
def var wf_vat_re3        as char .
def var wf_premt_re3      as char .
def var wf_camp_no        as char .
def var wf_payment_type   as char .
def var wf_nmember        as char .
def var wf_campen         as char .
