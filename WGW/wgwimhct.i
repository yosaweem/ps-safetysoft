/*programid   :wgwimhct.i                                                    */ 
/*programname : load text file HCT to GW                                     */ 
/* Copyright  : Safety Insurance Public Company Limited 			         */ 
/*			    ����ѷ ��Сѹ������� �ӡѴ (��Ҫ�)				             */ 
/*create by   : Kridtiya i. A64-0414   date .27/11/2021                      
                ��Ѻ������������ö����� text file HCT to GW system        */
/* Modify by : Ranu I. A68-0061 ��� Format file �駧ҹ�� CSV */                 
/*****************************************************************************/
DEFINE   TEMP-TABLE wdetail NO-UNDO                                           
    FIELD  n_text001    as char   /*1     �Ţ���㺤Ӣ�          HA641108150   */
    FIELD  n_text002    as char   /*2     �ѹ���㺤Ӣ�          12/11/2021    */
    FIELD  n_text003    as char   /*3     �Ţ����Ѻ��         21/TMS11-3098 */
    FIELD  n_text004    as char   /*4     �ѹ��������������ͧ              */  
    FIELD  n_text005    as char   /*5     �ѹ�������ش                    */  
    FIELD  n_text006    as char   /*6     ���ʺ���ѷ��Сѹ���              */  
    FIELD  n_text007    as char   /*7     ������ö                         */  
    FIELD  n_text008    as char   /*8     ��������â��          N          */      
    FIELD  n_text009    as char   /*9     ��������໭                     */  
    FIELD  n_text010    as char   /*10    �ӹǹ�Թ������¡�� 0000000.00 */  
    FIELD  n_text011    as char   /*11    ����������������ͧ        0      */      
    FIELD  n_text012    as char   /*12    ��������Сѹ                     */  
    FIELD  n_text013    as char   /*13    ��������ë���         GARAGE     */          
    FIELD  n_text014    as char   /*14    ���ѹ�֡                        */  
    FIELD  n_text015    as char   /*15    �ӹ�˹��                         */  
    FIELD  n_text016    as char   /*16    �����١���                       */  
    FIELD  n_text017    as char   /*17    ���͡�ҧ                         */  
    FIELD  n_text018    as char   /*18    ���ʡ��                          */  
    FIELD  n_text019    as char   /*19    ������� 5 ���� 1                 */  
    FIELD  n_text020    as char   /*20    ���     ���                      */  
    FIELD  n_text021    as char   /*21    �ǧ/�Ӻ�  ᤹�˭�               */  
    FIELD  n_text022    as char   /*22    ࢵ/�����  ���ͧ�������         */
    FIELD  n_text023    as char   /*23    �ѧ��Ѵ ������¹                */
    FIELD  n_text024    as char   /*24    ������ɳ���      45000          */
    FIELD  n_text025    as char   /*25    �Ҫվ                            */
    FIELD  n_text026    as char   /*26    �ѹ�Դ                          */   
    FIELD  n_text027    as char   /*27    �Ţ���ѵû�ЪҪ�                */
    FIELD  n_text028    as char   /*28    �Ţ���㺢Ѻ���                   */
    FIELD  n_text029    as char   /*29    ������ö                         */
    FIELD  n_text030    as char   /*30    �����ö¹��      5               */     
    FIELD  n_text031    as char   /*31    �����Ţ��Ƕѧ                    */
    FIELD  n_text032    as char   /*32    �����Ţ����ͧ                   */
    FIELD  n_text033    as char   /*33    �������ö                       */
    FIELD  n_text034    as char   /*34    ��蹻�   2015                    */     
    FIELD  n_text035    as char   /*35    ���ͻ�����ö     V AT            */     
    FIELD  n_text036    as char   /*36    Ẻ��Ƕѧ  ���ͧ�͹            */   
    FIELD  n_text037    as char   /*37    ���ʻ�����ö       1             */       
    FIELD  n_text038    as char   /*38    �����ѡɳС����ҹ              */
    FIELD  n_text039    as char   /*39    �ӹǹ�����                     */
    FIELD  n_text040    as char   /*40    ����ҵá�к͡�ٺ                 */
    FIELD  n_text041    as char   /*41    ������ö                         */
    FIELD  n_text042    as char   /*42    �Ţ����¹ö                     */
    FIELD  n_text043    as char   /*43    �ѧ��Ѵ��訴����¹      ������� */    
    FIELD  n_text044    as char   /*44    �շ�訴����¹  2014              */    
    FIELD  n_text045    as char   /*45    �����˵�    /1.������������ 5,500 */    
    FIELD  n_text046    as char   /*46    ǧ�Թ�ع��Сѹ       00000000000.00    */    
    FIELD  n_text047    as char   /*47    ���»�Сѹ               00000000600.00*/    
    FIELD  n_text048    as char   /*48    �ҡ�                  00000000003.00    */    
    FIELD  n_text049    as char   /*49    �ӹǹ�Թ����         00000000042.21    */    
    FIELD  n_text050    as char   /*50    ���»�Сѹ���        00000000645.21    */    
    FIELD  n_text051    as char   /*51    ���»�Сѹ��������� 00000015309.56    */
    FIELD  n_text052    as char   /*52    �ѵ����ǹŴ����ѵԴ�  00000000000.00    */
    FIELD  n_text053    as char   /*53    ��ǹŴ����ѵԴ�       00000000000.00    */    
    FIELD  n_text054    as char   /*54    �����Ţʵ������                       */
    FIELD  n_text055    as char   /*55    �Ţ������������          78-70-63/H00458  */ 
    FIELD  n_text056    as char   /*56    Flag �кت���      0                    */
    FIELD  n_text057    as char   /*57    Flag ����кت���      1                 */
    FIELD  n_text058    as char   /*58    �ӹ�˹��                                */
    FIELD  n_text059    as char   /*59    ���ͼ��Ѻ��褹��� 1                    */
    FIELD  n_text060    as char   /*60    ���͡�ҧ                                */
    FIELD  n_text061    as char   /*61    ���ʡ��                                 */
    FIELD  n_text062    as char   /*62    �Ҫվ                                   */
    FIELD  n_text063    as char   /*63    �ѹ�Դ                                 */
    FIELD  n_text064    as char   /*64    �Ţ���ѵû�ЪҪ�                       */
    FIELD  n_text065    as char   /*65    �Ţ���㺢Ѻ���                          */
    FIELD  n_text066    as char   /*66    �ӹ�˹��                                */
    FIELD  n_text067    as char   /*67    ���ͼ��Ѻ��褹��� 2                    */
    FIELD  n_text068    as char   /*68    ���͡�ҧ                                */
    FIELD  n_text069    as char   /*69    ���ʡ��                                 */
    FIELD  n_text070    as char   /*70    �Ҫվ                                   */
    FIELD  n_text071    as char   /*71    �ѹ�Դ                                 */
    FIELD  n_text072    as char   /*72    �Ţ���ѵû�ЪҪ�                       */
    FIELD  n_text073    as char   /*73    �Ţ���㺢Ѻ���                          */
    FIELD  n_text074    as char   /*74    ����Ѻ�Ż���ª��                        */
    FIELD  n_text075    as char   /*75    ����������µ�ͪ��Ե (�ҷ/��)      00000000000.00 */
    FIELD  n_text076    as char   /*76    ����������µ�ͪ��Ե (�ҷ/����)   00000000000.00 */
    FIELD  n_text077    as char   /*77    ����������µ�ͷ�Ѿ���Թ           00000000000.00 */
    FIELD  n_text078    as char   /*78    �������������ǹ�á�ؤ��           00000000000.00 */
    FIELD  n_text079    as char   /*79    ����������µ��ö¹��              00000000000.00 */
    FIELD  n_text080    as char   /*80    �������������ǹ�áö¹��              00000000000.00 */
    FIELD  n_text081    as char   /*81    ö¹���٭���/�����                   00000000000.00 */
    FIELD  n_text082    as char   /*82    �غѵ��˵���ǹ�ؤ�����ª��Ե���Ѻ���             00000000000.00 */
    FIELD  n_text083    as char   /*83    �غѵ��˵���ǹ�ؤ�����ª��Ե��.��������              00             */
    FIELD  n_text084    as char   /*84    �غѵ��˵���ǹ�ؤ�����ª��Ե��������/����           00000000000.00 */
    FIELD  n_text085    as char   /*85    �غѵ��˵���ǹ�ؤ�ŷؾ���Ҿ���Ǥ��� ���Ѻ���     00000000000.00 */
    FIELD  n_text086    as char   /*86    �غѵ��˵���ǹ�ؤ�ŷؾ���Ҿ���Ǥ��� ��.��������  00             */
    FIELD  n_text087    as char   /*87    �غѵ��˵���ǹ�ؤ�ŷؾ���Ҿ���Ǥ��Ǽ�������/����00000000000.00 */
    FIELD  n_text088    as char   /*88    ����ѡ�Ҿ�Һ��                                    00000000000.00 */
    FIELD  n_text089    as char   /*89    ��û�Сѹ��Ǽ��Ѻ���                             00000000000.00 */
    FIELD  n_text090    as char   /*90    ʶҹТ�����                                           NEW        */         
    FIELD  n_text091    as char   /*91    ����������駻�Сѹ          DLR              */  
    FIELD  n_text092    as char   /*92    ���ʺ���ѷ����駻�Сѹ  RJM                  */  
    FIELD  n_text093    as char   /*93    �ҢҺ���ѷ����駻�Сѹ  �ӹѡ�ҹ�˭�         */  
    FIELD  n_text094    as char   /*94    ���ͼ��Դ��� / Salesman ����ó� ���ФӨѹ��� */  
    FIELD  n_text095    as char   /*95    ����ѷ�������ö         RJS                  */   
    FIELD  n_text096    as char   /*96    �ҢҺ���ѷ�������ö     �ӹѡ�ҹ�˭�         */  
    FIELD  n_text097    as char   /*97    Honda Project            �͡�ç���           */       
    FIELD  n_text098    as char   /*98    ����ö                   008                  */               
    FIELD  n_text099    as char   /*99    ��ԡ������������ 1 AA                         */  
    FIELD  n_text100    as char   /*100   �ҤҺ�ԡ������������ 1                        */  
    FIELD  n_text101    as char   /*101   ��ԡ������������ 2                            */  
    FIELD  n_text102    as char   /*102   �ҤҺ�ԡ������������ 2                        */  
    FIELD  n_text103    as char   /*103   ��ԡ������������ 3                            */  
    FIELD  n_text104    as char   /*104   �ҤҺ�ԡ������������ 3                        */  
    FIELD  n_text105    as char   /*105   ��ԡ������������ 4                            */  
    FIELD  n_text106    as char   /*106   �ҤҺ�ԡ������������ 4                        */  
    FIELD  n_text107    as char   /*107   ��ԡ������������ 5                            */  
    FIELD  n_text108    as char   /*108   �ҤҺ�ԡ������������ 5                        */  
    FIELD  n_text109    as char   /*109   ������       /                                */  
    FIELD  n_text110    as char   /*110   �ѹ���    13/11/2021                          */  
    FIELD  n_text111    as char   /*111   �ӹǹ�Թ     00000015309.56                  */  
    FIELD  n_text112    as char   /*112   ������  CASH                                 */  
    FIELD  n_text113    as char   /*113   �Ţ���ѵù��˹��    6204023613               */  
    FIELD  n_text114    as char   /*114   �͡�����㹹��   1                           */  
    FIELD  n_text115    as char   /*115   ���������     ��������� �.�.���� ���Ҵ��� */  
    FIELD  n_text116    as char   /*116   ��������´��໭                              */  
    FIELD  n_text117    as char   /*117   �Ѻ��Сѹ�������                             */  
    FIELD  n_text118    as char   /*118   ��͹����/��͹                                */  
    FIELD  n_text119    as char   /*119   �ѵ��ôԵ��Ҥ��                              */  
    FIELD  n_text120    as char   /*120   ����������駧ҹ          R                   */  
    FIELD  n_text121    as char   /*121   ����Ҥ��ػ�ó������       5500.00             */  
    FIELD  n_text122    as char   /*122   ��������´�ػ�ó������                        */  
    FIELD  n_text123    as char   /*123   �ҢҺ���ѷ�ͧ�����һ�Сѹ (�١���)      �ҢҺ���ѷ�ͧ�����һ�Сѹ (�١���) */                                     
    FIELD  n_text124    as char   /*124   ���������ͺ���        ���������ͺ��� */                                                       
    FIELD  n_text125    as char   /*125   �Ҥ����ͺ���  �Ҥ����ͺ���  0    */                                                   
    FIELD  n_text126    as char   /*126   ���ͺ���ѷ�����㺡ӡѺ����1    ���ͺ���ѷ�����㺡ӡѺ����1    �.�.���� ���Ҵ���  */                     
    FIELD  n_text127    as char   /*127   �ҢҺ���ѷ��㺡ӡѺ����1        �ҢҺ���ѷ��㺡ӡѺ����1                            */                    
    FIELD  n_text128    as char   /*128   ������躹㺡ӡѺ����1   ������躹㺡ӡѺ����1   5 ���� 1  ᤹�˭� ���ͧ������� �.������� 45000 */
    FIELD  n_text129    as char   /*129   �Ţ�������������1      �Ţ�������������1                                                           */
    FIELD  n_text130    as char   /*130   �ѵ�����µ��㺡ӡѺ1 (��������ҡ��������)     �ѵ�����µ��㺡ӡѺ1 (��������ҡ��������) 645.21   */                   
    FIELD  n_text131    as char   /*131   ���ͺ���ѷ�����㺡ӡѺ����2    ���ͺ���ѷ�����㺡ӡѺ����2                                     */
    FIELD  n_text132    as char   /*132   �ҢҺ���ѷ��㺡ӡѺ����2        �ҢҺ���ѷ��㺡ӡѺ����2                                             */
    FIELD  n_text133    as char   /*133   ������躹㺡ӡѺ����2   ������躹㺡ӡѺ����2                                                    */
    FIELD  n_text134    as char   /*134   �Ţ�������������2      �Ţ�������������2                                                           */
    FIELD  n_text135    as char   /*135   �ѵ�����µ��㺡ӡѺ2 (��������ҡ��������)     �ѵ�����µ��㺡ӡѺ2 (��������ҡ��������) 0        */
    FIELD  n_text136    as char   /*136   ���ͺ���ѷ�����㺡ӡѺ����3    ���ͺ���ѷ�����㺡ӡѺ����3                                     */
    FIELD  n_text137    as char   /*137   �ҢҺ���ѷ��㺡ӡѺ����3        �ҢҺ���ѷ��㺡ӡѺ����3                                             */
    FIELD  n_text138    as char   /*138   ������躹㺡ӡѺ����3   ������躹㺡ӡѺ����3                                                    */
    FIELD  n_text139    as char   /*139   �Ţ�������������3      �Ţ�������������3                                                           */
    FIELD  n_text140    as char   /*140   �ѵ�����µ��㺡ӡѺ3 (��������ҡ��������)     �ѵ�����µ��㺡ӡѺ3 (��������ҡ��������) 0        */
    FIELD  n_text141    as char   /*141   �Ţ�����໭    �Ţ�����໭            */
    FIELD  n_text142    as char  /*142   ��������ê�������      ��������ê�������  */ 
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
