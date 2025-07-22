/*----------------------------------------------------------------------------------*/
/*Program ID   : wgwmtscb3.i                                                        */
/*Program name : Match File Load and Update Data TLT                                */
/*create by    : Ranu i. A60-0488  date 16/10/2017 
                ����� match file ����Ѻ��Ŵ��� GW ��� Match Policy no on TLT     */
/*Modify BY    : Kridtiya i. A64-0295 DATE. 25/07/2021  ��������                   */    
// Modify BY   : Tontawan S. A68-0059 27/03/2025        
//             : Add 35 FIELD for support EV     
/*----------------------------------------------------------------------------------*/       
/* ��С�ȵ���� -*/
/*--------------------------����Ѻ�����š�������  -------------------------*/
DEFINE NEW SHARED WORKFILE wdetail NO-UNDO
    FIELD XRefNo1          AS CHAR FORMAT "X(50)"  INIT ""   /*�Ţ����͡�����ҧ�ԧ        */           
    FIELD Barcode          AS CHAR FORMAT "X(50)"  INIT ""   /*������                   */           
    FIELD InsuredName      AS CHAR FORMAT "X(225)" INIT ""   /*���ͺ���ѷ��Сѹ���        */           
    FIELD PolicyNo         AS CHAR FORMAT "X(20)"  INIT ""   /*�Ţ����������             */           
    FIELD EndorseNo        AS CHAR FORMAT "X(20)"  INIT ""   /*�Ţ�����ѡ��ѧ             */           
    FIELD SumInsured       AS CHAR FORMAT "X(20)"  INIT ""   /*�ع��Сѹ                  */
    FIELD sumfire          AS CHAR FORMAT "x(20)"  INIT ""   /* fire & theft */ /*A61-0228*/
    FIELD NetPremium       AS CHAR FORMAT "X(20)"  INIT ""   /*�����ط��                 */           
    FIELD VatTax           AS CHAR FORMAT "X(10)"  INIT ""   /*������Ť������            */           
    FIELD Stamp            AS CHAR FORMAT "X(10)"  INIT ""   /*�ҡ�                       */           
    FIELD GrossPremium     AS CHAR FORMAT "X(20)"  INIT ""   /*�������                   */           
    FIELD EffectiveDate    AS CHAR FORMAT "X(15)"  INIT ""   /*�ѹ��������������ͧ        */           
    FIELD ExpireDate       AS CHAR FORMAT "X(15)"  INIT ""   /*�ѹ�������ش����������ͧ  */         
    FIELD EndorseReASon    AS CHAR FORMAT "X(350)" INIT ""   /*�˵ؼš����ѡ��ѧ          */   
    FIELD trntyp           AS CHAR FORMAT "x(5)"   INIT ""   /* transtype */ /*a61-0228*/
    FIELD cmr_code         AS CHAR FORMAT "X(50)"  INIT ""   /*���ʺ���ѷ��Сѹ��� */                                
    FIELD comp_code        AS CHAR FORMAT "X(50)"  INIT ""   /*���ͺ���ѷ��Сѹ��� */                             
    FIELD campcode         AS CHAR FORMAT "X(50)"  INIT ""   /*������໭          */                             
    FIELD campname         AS CHAR FORMAT "X(50)"  INIT ""   /*������໭          */                             
    FIELD procode          AS CHAR FORMAT "X(50)"  INIT ""   /*���ʼ�Ե�ѳ��       */                             
    FIELD proname          AS CHAR FORMAT "X(50)"  INIT ""   /*���ͼ�Ե�ѳ��ͧ��Сѹ���*/                        
    FIELD packname         AS CHAR FORMAT "X(50)"  INIT ""   /*����ᾤࡨ          */                             
    FIELD packcode         AS CHAR FORMAT "X(50)"  INIT ""   /*����ᾤࡨ          */                             
    FIELD instype          AS CHAR FORMAT "X(5)"   INIT ""   /*����������͡�������*/                             
    FIELD pol_title        AS CHAR FORMAT "X(20)"  INIT ""   /*�ӹ�˹�Ҫ��� ����͡�������     */                 
    FIELD pol_fname        AS CHAR FORMAT "X(100)" INIT ""   /*���ͼ����һ�Сѹ����͡�������  */                 
    FIELD pol_lname        AS CHAR FORMAT "X(100)" INIT ""   /*���ʡ�ż����һ�Сѹ ����͡�������   */            
    FIELD pol_title_eng    AS CHAR FORMAT "X(20)"  INIT ""   /*�ӹ�˹�Ҫ��� ����͡������� �����ѧ��� */          
    FIELD pol_fname_eng    AS CHAR FORMAT "X(50)"  INIT ""   /*�������� �ѧ���    */                              
    FIELD pol_lname_eng    AS CHAR FORMAT "X(50)"  INIT ""   /*���ʡ������ �ѧ��� */                              
    FIELD icno             AS CHAR FORMAT "X(20)"  INIT ""   /*�Ţ���ѵ�         */                              
    FIELD sex              AS CHAR FORMAT "X(1) "  INIT ""   /*�� ����͡������� */                              
    FIELD bdate            AS CHAR FORMAT "X(10)"  INIT ""   /*�ѹ��͹���Դ ( DD/MM/YYYY) ����͡������� */     
    FIELD occup            AS CHAR FORMAT "X(50)"  INIT ""   /*�Ҫվ ����͡�������            */                 
    FIELD tel              AS CHAR FORMAT "X(20)"  INIT ""   /*���Ѿ��-��ҹ-����͡�������    */                 
    FIELD phone            AS CHAR FORMAT "X(20)"  INIT ""   /*���������Ѿ��-��ҹ-����͡������� */            
    FIELD teloffic         AS CHAR FORMAT "X(20)"  INIT ""   /*���Ѿ��-���ӧҹ ����͡�������*/                 
    FIELD telext           AS CHAR FORMAT "X(20)"  INIT ""   /*���������Ѿ��-���ӧҹ ����͡�������   */      
    FIELD moblie           AS CHAR FORMAT "X(20)"  INIT ""   /*���Ѿ��-��Ͷ��  ����͡������� */                 
    FIELD mobliech         AS CHAR FORMAT "X(20)"  INIT ""   /*���Ѿ��-��Ͷ��  㹡óշ������¹������Ͷ��*/     
    FIELD mail             AS CHAR FORMAT "X(40)"  INIT ""   /*email-����͡������� */                            
    FIELD lineid           AS CHAR FORMAT "X(100)" INIT ""   /*Line ID              */                            
    FIELD addr1_70         AS CHAR FORMAT "X(20)"  INIT ""   /*������� �Ţ����ҹ-����͡�������  */              
    FIELD addr2_70         AS CHAR FORMAT "X(100)" INIT ""   /*������� �����ҹ - ����͡�������  */              
    FIELD addr3_70         AS CHAR FORMAT "X(100)" INIT ""   /*������� ����-����͡�������     */                 
    FIELD addr4_70         AS CHAR FORMAT "X(100)" INIT ""   /*������� ��͡ ���-����͡������� */                 
    FIELD addr5_70         AS CHAR FORMAT "X(40)"  INIT ""   /*������� ���-����͡�������      */                 
    FIELD nsub_dist70      AS CHAR FORMAT "X(20)"  INIT ""   /*������� �����ǧ-����͡������� */                 
    FIELD ndirection70     AS CHAR FORMAT "X(20)"  INIT ""   /*������� ࢵ/�����-����͡�������*/                 
    FIELD nprovin70        AS CHAR FORMAT "X(20)"  INIT ""   /*������� �ѧ��Ѵ-����͡�������  */                 
    FIELD zipcode70        AS CHAR FORMAT "X(10)"  INIT ""   /*������� ������ɳ���-����͡�������        */      
    FIELD addr1_72         AS CHAR FORMAT "X(20)"  INIT ""   /*������� �Ţ����ҹ-�������㹡�èѴ���͡���*/      
    FIELD addr2_72         AS CHAR FORMAT "X(100)" INIT ""   /*������� �����ҹ - �������㹡�èѴ���͡���*/      
    FIELD addr3_72         AS CHAR FORMAT "X(100)" INIT ""   /*������� ����-�������㹡�èѴ���͡���      */      
    FIELD addr4_72         AS CHAR FORMAT "X(100)" INIT ""   /*������� ��͡ ���-�������㹡�èѴ���͡���  */      
    FIELD addr5_72         AS CHAR FORMAT "X(40)"  INIT ""   /*������� ���-�������㹡�èѴ���͡���       */      
    FIELD nsub_dist72      AS CHAR FORMAT "X(20)"  INIT ""   /*������� �����ǧ-�������㹡�èѴ���͡���  */      
    FIELD ndirection72     AS CHAR FORMAT "X(20)"  INIT ""   /*������� ࢵ/�����-�������㹡�èѴ���͡��� */      
    FIELD nprovin72        AS CHAR FORMAT "X(20)"  INIT ""   /*������� �ѧ��Ѵ-�������㹡�èѴ���͡���   */      
    FIELD zipcode72        AS CHAR FORMAT "X(10)"  INIT ""   /*������� ������ɳ���-�������㹡�èѴ���͡��� */   
    FIELD paytype          AS CHAR FORMAT "X(1) "  INIT ""   /*������(����ѷ,�ؤ��) �������Թ��������*/         
    FIELD paytitle         AS CHAR FORMAT "X(20)"  INIT ""   /*�ӹ�˹�Ҫ������   �������Թ��������  */         
    FIELD payname          AS CHAR FORMAT "X(100)" INIT ""   /*���ͼ����һ�Сѹ   �������Թ��������  */         
    FIELD paylname         AS CHAR FORMAT "X(100)" INIT ""   /*���ʡ�ż����һ�Сѹ  �������Թ��������*/         
    FIELD payicno          AS CHAR FORMAT "X(20)"  INIT ""   /*�Ţ���ѵû�ЪҪ������һ�Сѹ        */            
    FIELD payaddr1         AS CHAR FORMAT "X(10)"  INIT ""   /*������� �Ţ����ҹ-����Ѻ�͡�����  */            
    FIELD payaddr2         AS CHAR FORMAT "X(100)" INIT ""   /*������� �����ҹ - ����Ѻ�͡�����  */            
    FIELD payaddr3         AS CHAR FORMAT "X(100)" INIT ""   /*������� ����-����Ѻ�͡�����        */            
    FIELD payaddr4         AS CHAR FORMAT "X(100)" INIT ""   /*������� ��͡ ���-����Ѻ�͡�����    */            
    FIELD payaddr5         AS CHAR FORMAT "X(40)"  INIT ""   /*������� ���-����Ѻ�͡�����         */            
    FIELD payaddr6         AS CHAR FORMAT "X(20)"  INIT ""   /*������� �ǧ-����Ѻ�͡�����        */            
    FIELD payaddr7         AS CHAR FORMAT "X(20)"  INIT ""   /*������� ࢵ/�����-����Ѻ�͡�����   */            
    FIELD payaddr8         AS CHAR FORMAT "X(20)"  INIT ""   /*������� �ѧ��Ѵ-����Ѻ�͡�����     */            
    FIELD payaddr9         AS CHAR FORMAT "X(10)"  INIT ""   /*������� ������ɳ���-����Ѻ�͡�����*/            
    FIELD branch           AS CHAR FORMAT "X(10)"  INIT ""   /*�ӹѡ�ҹ�˭������Ң�       */                      
    FIELD ben_title        AS CHAR FORMAT "X(10)"  INIT ""   /*�ӹ�˹�Ҫ��� ����Ѻ�Ż���ª�� */                   
    FIELD ben_name         AS CHAR FORMAT "X(50)"  INIT ""   /*���ͼ���Ѻ�Ż���ª��          */                   
    FIELD ben_lname        AS CHAR FORMAT "X(50)"  INIT ""   /*���ʡ�� ����Ѻ�Ż���ª��      */    
    FIELD pmentcode        AS CHAR FORMAT "X(10)"  INIT ""   /*���ʻ�������ê������»�Сѹ  */                   
    FIELD pmenttyp         AS CHAR FORMAT "X(20)"  INIT ""   /*��������ê������»�Сѹ      */                   
    FIELD pmentcode1       AS CHAR FORMAT "X(20)"  INIT ""   /*���ʪ�ͧ�ҧ����������       */                   
    FIELD pmentcode2       AS CHAR FORMAT "X(50)"  INIT ""   /*��ͧ�ҧ�����Ф������        */                   
    FIELD pmentbank        AS CHAR FORMAT "X(20)"  INIT ""   /*��Ҥ�÷���������            */                   
    FIELD pmentdate        AS CHAR FORMAT "X(10)"  INIT ""   /*�ѹ�����Ф������            */                   
    FIELD pmentsts         AS CHAR FORMAT "X(10)"  INIT ""   /*ʶҹС�ê�������             */                   
    FIELD driver           AS CHAR FORMAT "X(10)"  INIT ""   /*����кت��ͼ��Ѻ             */                   
    FIELD drivetitle1      AS CHAR FORMAT "X(10)"  INIT ""   /*�ӹ�˹�Ҫ��� ���Ѻ��� 1      */                   
    FIELD drivename1       AS CHAR FORMAT "X(50)"  INIT ""   /*���ͼ��Ѻ��� 1               */                   
    FIELD drivelname1      AS CHAR FORMAT "X(50)"  INIT ""   /*���ʡ�� ���Ѻ��� 1           */                   
    FIELD driveno1         AS CHAR FORMAT "X(20)"  INIT ""   /*�Ţ���ѵû�ЪҪ����Ѻ��� 1  */                   
    FIELD occupdriv1       AS CHAR FORMAT "X(30)"  INIT ""   /*Driver1Occupation             */                   
    FIELD sexdriv1         AS CHAR FORMAT "X(1) "  INIT ""   /*�� ���Ѻ��� 1               */                   
    FIELD bdatedriv1       AS CHAR FORMAT "X(10)"  INIT ""   /*�ѹ��͹���Դ ���Ѻ��� 1    */                   
    FIELD drivetitle2      AS CHAR FORMAT "X(10)"  INIT ""   /*�ӹ�˹�Ҫ��� ���Ѻ��� 2      */                   
    FIELD drivename2       AS CHAR FORMAT "X(50)"  INIT ""   /*���ͼ��Ѻ��� 2               */                   
    FIELD drivelname2      AS CHAR FORMAT "X(50)"  INIT ""   /*���ʡ�� ���Ѻ��� 2           */                   
    FIELD driveno2         AS CHAR FORMAT "X(20)"  INIT ""   /*�Ţ���ѵû�ЪҪ����Ѻ��� 2  */                   
    FIELD occupdriv2       AS CHAR FORMAT "X(50)"  INIT ""   /*Driver2Occupation             */                   
    FIELD sexdriv2         AS CHAR FORMAT "X(1) "  INIT ""   /*�� ���Ѻ��� 2               */                   
    FIELD bdatedriv2       AS CHAR FORMAT "X(10)"  INIT ""   /*�ѹ��͹���Դ ���Ѻ��� 2    */                   
    FIELD chASsis          AS CHAR FORMAT "X(50)"  INIT ""  
    FIELD covcod           AS CHAR FORMAT "X(10)"  INIT "" 
    FIELD covtyp           AS CHAR FORMAT "X(20)"  INIT ""
    FIELD endorsedat       AS CHAR FORMAT "X(20)"  INIT ""
    /*-- Add By Tontawan S. A68-0059 27/03/2025 --*/
    FIELD drv3_salutation_M AS CHAR FORMAT "X(20)"  INIT ""  // ���Ѻ 3 : �ӹ�˹��         
    FIELD drv3_fname        AS CHAR FORMAT "X(100)" INIT ""  // ���Ѻ 3 : ����             
    FIELD drv3_lname        AS CHAR FORMAT "X(100)" INIT ""  // ���Ѻ 3 : ���ʡ��          
    FIELD drv3_nid          AS CHAR FORMAT "X(20)"  INIT ""  // ���Ѻ 3 : �Ţ�ѵû�ЪҪ�   
    FIELD drv3_occupation   AS CHAR FORMAT "X(50)"  INIT ""  // ���Ѻ 3 : �Ҫվ            
    FIELD drv3_gender       AS CHAR FORMAT "X(10)"  INIT ""  // ���Ѻ 3 : ��              
    FIELD drv3_birthdate    AS CHAR FORMAT "X(10)"  INIT ""  // ���Ѻ 3 : �ѹ�Դ          
    FIELD drv4_salutation_M AS CHAR FORMAT "X(20)"  INIT ""  // ���Ѻ 4 : �ӹ�˹��         
    FIELD drv4_fname        AS CHAR FORMAT "X(100)" INIT ""  // ���Ѻ 4 : ����             
    FIELD drv4_lname        AS CHAR FORMAT "X(100)" INIT ""  // ���Ѻ 4 : ���ʡ��          
    FIELD drv4_nid          AS CHAR FORMAT "X(20)"  INIT ""  // ���Ѻ 4 : �Ţ�ѵû�ЪҪ�   
    FIELD drv4_occupation   AS CHAR FORMAT "X(50)"  INIT ""  // ���Ѻ 4 : �Ҫվ            
    FIELD drv4_gender       AS CHAR FORMAT "X(10)"  INIT ""  // ���Ѻ 4 : ��              
    FIELD drv4_birthdate    AS CHAR FORMAT "X(10)"  INIT ""  // ���Ѻ 4 : �ѹ�Դ          
    FIELD drv5_salutation_M AS CHAR FORMAT "X(20)"  INIT ""  // ���Ѻ 5 : �ӹ�˹��         
    FIELD drv5_fname        AS CHAR FORMAT "X(100)" INIT ""  // ���Ѻ 5 : ����             
    FIELD drv5_lname        AS CHAR FORMAT "X(100)" INIT ""  // ���Ѻ 5 : ���ʡ��          
    FIELD drv5_nid          AS CHAR FORMAT "X(20)"  INIT ""  // ���Ѻ 5 : �Ţ�ѵû�ЪҪ�   
    FIELD drv5_occupation   AS CHAR FORMAT "X(50)"  INIT ""  // ���Ѻ 5 : �Ҫվ            
    FIELD drv5_gender       AS CHAR FORMAT "X(10)"  INIT ""  // ���Ѻ 5 : ��              
    FIELD drv5_birthdate    AS CHAR FORMAT "X(10)"  INIT ""  // ���Ѻ 5 : �ѹ�Դ          
    FIELD drv1_dlicense     AS CHAR FORMAT "X(50)"  INIT ""  // ���Ѻ 1 : ����¹ö        
    FIELD drv2_dlicense     AS CHAR FORMAT "X(50)"  INIT ""  // ���Ѻ 2 : ����¹ö        
    FIELD drv3_dlicense     AS CHAR FORMAT "X(50)"  INIT ""  // ���Ѻ 3 : ����¹ö        
    FIELD drv4_dlicense     AS CHAR FORMAT "X(50)"  INIT ""  // ���Ѻ 4 : ����¹ö        
    FIELD drv5_dlicense     AS CHAR FORMAT "X(50)"  INIT ""  // ���Ѻ 5 : ����¹ö        
    FIELD baty_snumber      AS CHAR FORMAT "X(20)"  INIT ""  // Battery : Serial Number    
    FIELD batydate          AS CHAR FORMAT "X(10)"  INIT ""  // Battery : Year             
    FIELD baty_rsi          AS CHAR FORMAT "X(20)"  INIT ""  // Battery : Replacement SI   
    FIELD baty_npremium     AS CHAR FORMAT "X(20)"  INIT ""  // Battery : Net Premium      
    FIELD baty_gpremium     AS CHAR FORMAT "X(20)"  INIT ""  // Battery : Gross_Premium    
    FIELD wcharge_snumber   AS CHAR FORMAT "X(20)"  INIT ""  // Wall Charge : Serial_Number
    FIELD wcharge_si        AS CHAR FORMAT "X(20)"  INIT ""  // Wall Charge : SI           
    FIELD wcharge_npremium  AS CHAR FORMAT "X(20)"  INIT ""  // Wall Charge : Net Premium  
    FIELD wcharge_gpremium  AS CHAR FORMAT "X(20)"  INIT "". // Wall Charge : Gross Premium
    /*-- End By Tontawan S. A68-0059 27/03/2025 --*/

DEFINE TEMP-TABLE wdetail2 NO-UNDO
    FIELD brand            AS CHAR FORMAT "X(50)"  INIT ""   /*����ö¹��                    */      
    FIELD brand_cd         AS CHAR FORMAT "X(50)"  INIT ""   /*���ʪ���ö¹��                */  
    FIELD Model            AS CHAR FORMAT "X(50)"  INIT ""   /*�������ö¹��                */  
    FIELD Model_cd         AS CHAR FORMAT "X(50)"  INIT ""   /*���ʪ������ö¹��            */  
    FIELD body             AS CHAR FORMAT "X(50)"  INIT ""   /*Ẻ��Ƕѧ                     */  
    FIELD body_cd          AS CHAR FORMAT "X(50)"  INIT ""   /*����Ẻ��Ƕѧ                 */  
    FIELD licence          AS CHAR FORMAT "X(50)"  INIT ""   /*����¹ö                     */  
    FIELD province         AS CHAR FORMAT "X(50)"  INIT ""   /*�ѧ��Ѵ��訴����¹           */  
    FIELD chASsis          AS CHAR FORMAT "X(50)"  INIT ""   /*�Ţ��Ƕѧ                     */  
    FIELD engine           AS CHAR FORMAT "X(50)"  INIT ""   /*�Ţ����ͧ¹��                */  
    FIELD yrmanu           AS CHAR FORMAT "X(10)"  INIT ""   /*�ը�����¹ö                 */  
    FIELD seatenew         AS CHAR FORMAT "X(10)"  INIT ""   /*�ӹǹ�����                  */  
    FIELD power            AS CHAR FORMAT "X(10)"  INIT ""   /*��Ҵ����ͧ¹��               */  
    FIELD weight           AS CHAR FORMAT "X(10)"  INIT ""   /*���˹ѡ                       */  
    FIELD clASs            AS CHAR FORMAT "X(10)"  INIT ""   /*���ʡ����ö¹��              */  
    FIELD garage_cd        AS CHAR FORMAT "X(10)"  INIT ""   /*���ʡ�ë���                   */  
    FIELD garage           AS CHAR FORMAT "X(10)"  INIT ""   /*��������ë���                 */  
    FIELD colorcode        AS CHAR FORMAT "X(20)"  INIT ""   /*��ö¹��                      */  
    FIELD covcod           AS CHAR FORMAT "X(10)"  INIT ""   /*���ʻ������ͧ��Сѹ���        */  
    FIELD covtyp           AS CHAR FORMAT "X(20)"  INIT ""   /*�������ͧ��Сѹ���            */  
    FIELD covtyp1          AS CHAR FORMAT "X(50)"  INIT ""   /*�������ͧ����������ͧ         */  
    FIELD covtyp2          AS CHAR FORMAT "X(50)"  INIT ""   /*���������¢ͧ����������ͧ     */  
    FIELD covtyp3          AS CHAR FORMAT "X(50)"  INIT ""   /*��������´���������¢ͧ����������ͧ */ 
    FIELD comdat           AS CHAR FORMAT "X(20)"  INIT ""   /*�ѹ���������������ͧ          */       
    FIELD expdat           AS CHAR FORMAT "X(20)"  INIT ""   /*�ѹ�������ش����������ͧ     */       
    FIELD ins_amt          AS CHAR FORMAT "X(20)"  INIT ""   /*�ع��Сѹ                     */       
    FIELD prem1            AS CHAR FORMAT "X(20)"  INIT ""   /*���»�Сѹ�������������ͧ��ѡ*/       
    FIELD gross_prm        AS CHAR FORMAT "X(20)"  INIT ""   /*�����ط����ѧ�ѡ��ǹŴ       */       
    FIELD stamp            AS CHAR FORMAT "X(20)"  INIT ""   /*�ӹǹ�ҡ������               */       
    FIELD vat              AS CHAR FORMAT "X(20)"  INIT ""   /*�ӹǹ���� Vat                 */       
    FIELD premtotal        AS CHAR FORMAT "X(20)"  INIT ""   /*������� ����-�ҡ�            */       
    FIELD deduct           AS CHAR FORMAT "X(20)"  INIT ""   /*��Ҥ������������ǹ�á         */       
    FIELD fleetper         AS CHAR FORMAT "X(20)"  INIT ""   /*% ��ǹŴ�����                 */       
    FIELD fleet            AS CHAR FORMAT "X(20)"  INIT ""   /*�ӹǹ��ǹŴ�����              */       
    FIELD ncbper           AS CHAR FORMAT "X(20)"  INIT ""   /*% ��ǹŴ����ѵԴ�             */       
    FIELD ncb              AS CHAR FORMAT "X(20)"  INIT ""   /*�ӹǹ��ǹŴ����ѵԴ�          */       
    FIELD drivper          AS CHAR FORMAT "X(20)"  INIT ""   /*% ��ǹŴ�ó��кت��ͼ��Ѻ��� */       
    FIELD drivdis          AS CHAR FORMAT "X(20)"  INIT ""   /*�ӹǹ��ǹŴ�ó��кت��ͼ��Ѻ��� */    
    FIELD othper           AS CHAR FORMAT "X(20)"  INIT ""   /*%�ǹŴ����        */       
    FIELD oth              AS CHAR FORMAT "X(20)"  INIT ""   /*�ӹǹ��ǹŴ����   */       
    FIELD cctvper          AS CHAR FORMAT "X(20)"  INIT ""   /*%�ǹŴ���ͧ        */       
    FIELD cctv             AS CHAR FORMAT "X(20)"  INIT ""   /*�ӹǹ��ǹŴ���ͧ   */       
    FIELD Surcharper       AS CHAR FORMAT "X(20)"  INIT ""   /*%��ǹŴ����       */       
    FIELD Surchar          AS CHAR FORMAT "X(20)"  INIT ""   /*�ӹǹ��ǹŴ����   */       
    FIELD Surchardetail    AS CHAR FORMAT "X(20)"  INIT ""   /*��������´��ǹ����*/       
    FIELD acc1             AS CHAR FORMAT "X(50)"  INIT ""   /*���� �ػ�ó� ������� 1 */       
    FIELD accdetail1       AS CHAR FORMAT "X(500)" INIT ""   /*��������´������� 1    */       
    FIELD accprice1        AS CHAR FORMAT "X(10)"  INIT ""   /*�Ҥ��ػ�ó� ������� 1*/
    FIELD acc2             AS CHAR FORMAT "X(50)"  INIT ""   /*���� �ػ�ó� ������� 2 */       
    FIELD accdetail2       AS CHAR FORMAT "X(500)" INIT ""   /*��������´������� 2    */       
    FIELD accprice2        AS CHAR FORMAT "X(10)"  INIT ""   /*�Ҥ��ػ�ó� ������� 2*/
    FIELD acc3             AS CHAR FORMAT "X(50)"  INIT ""   /*���� �ػ�ó� ������� 3 */       
    FIELD accdetail3       AS CHAR FORMAT "X(500)" INIT ""   /*��������´������� 3    */       
    FIELD accprice3        AS CHAR FORMAT "X(10)"  INIT ""   /*�Ҥ��ػ�ó� ������� 3*/
    FIELD acc4             AS CHAR FORMAT "X(50)"  INIT ""   /*���� �ػ�ó� ������� 4 */       
    FIELD accdetail4       AS CHAR FORMAT "X(500)" INIT ""   /*��������´������� 4    */       
    FIELD accprice4        AS CHAR FORMAT "X(10)"  INIT ""   /*�Ҥ��ػ�ó� ������� 4*/
    FIELD acc5             AS CHAR FORMAT "X(50)"  INIT ""   /*���� �ػ�ó� ������� 5 */          
    FIELD accdetail5       AS CHAR FORMAT "X(500)" INIT ""   /*��������´������� 5    */          
    FIELD accprice5        AS CHAR FORMAT "X(10)"  INIT ""   /*�Ҥ��ػ�ó� ������� 5*/
    FIELD inspdate         AS CHAR FORMAT "X(10)"  INIT ""   /*�ѹ����Ǩ��Ҿö         */          
    FIELD inspdate_app     AS CHAR FORMAT "X(10)"  INIT ""   /*�ѹ���͹��ѵԼš�õ�Ǩ��Ҿö  */          
    FIELD inspsts          AS CHAR FORMAT "X(10)"  INIT ""   /*�š�õ�Ǩ��Ҿö        */          
    FIELD inspdetail       AS CHAR FORMAT "X(500)" INIT ""   /*��������´��õ�Ǩ��Ҿö*/          
    FIELD not_date         AS CHAR FORMAT "X(10)"  INIT ""   /*�ѹ�����              */          
    FIELD paydate          AS CHAR FORMAT "X(10)"  INIT ""   /*�ѹ����Ѻ�����Թ      */          
    FIELD paysts           AS CHAR FORMAT "X(10)"  INIT ""   /*ʶҹС�è����Թ       */          
    FIELD licenBroker      AS CHAR FORMAT "X(20)"  INIT ""   /*�Ţ����͹حҵ���˹�� (SCBPT) */          
    FIELD brokname         AS CHAR FORMAT "X(20)"  INIT ""   /*���ͺ���ѷ���˹�� (SCBPT) */          
    FIELD brokcode         AS CHAR FORMAT "X(10)"  INIT ""   /*�����ä���� */          
    FIELD lang             AS CHAR FORMAT "X(20)"  INIT ""   /*����*/                    
    FIELD deli             AS CHAR FORMAT "X(50)"  INIT ""   /*��ͧ�ҧ��èѴ��     */   
    FIELD delidetail       AS CHAR FORMAT "X(100)" INIT ""   /*��������´��èѴ��  */   
    FIELD gift             AS CHAR FORMAT "X(100)" INIT ""   /*�ͧ��  */                
    FIELD cedcode          AS CHAR FORMAT "X(20)"  INIT ""   /*�Ţ�����ҧ�ԧ  */         
    FIELD inscode          AS CHAR FORMAT "X(20)"  INIT ""   /*�����١��� */             
    FIELD remark           AS CHAR FORMAT "X(500)" INIT ""   /*�����˵�   */
    FIELD pASs             AS CHAR FORMAT "x(2)"   INIT ""   /* update */ 
    FIELD ben_2title       AS CHAR FORMAT "X(10)"  INIT ""   /*�ӹ�˹�Ҫ��� ����Ѻ�Ż���ª�� */                   
    FIELD ben_2name        AS CHAR FORMAT "X(50)"  INIT ""   /*���ͼ���Ѻ�Ż���ª��          */                   
    FIELD ben_2lname       AS CHAR FORMAT "X(50)"  INIT ""   /*���ʡ�� ����Ѻ�Ż���ª��      */   
    FIELD ben_3title       AS CHAR FORMAT "X(10)"  INIT ""   /*�ӹ�˹�Ҫ��� ����Ѻ�Ż���ª�� */                   
    FIELD ben_3name        AS CHAR FORMAT "X(50)"  INIT ""   /*���ͼ���Ѻ�Ż���ª��          */                   
    FIELD ben_3lname       AS CHAR FORMAT "X(50)"  INIT ""   /*���ʡ�� ����Ѻ�Ż���ª��      */
    FIELD Agent_Code       AS CHAR FORMAT "X(100)" INIT ""   /*Kridtiya i. A64-0295 DATE. 25/07/2021*/    
    FIELD Agent_Name_TH    AS CHAR FORMAT "X(255)" INIT ""   /*Kridtiya i. A64-0295 DATE. 25/07/2021*/    
    FIELD Agent_Name_Eng   AS CHAR FORMAT "X(255)" INIT ""   /*Kridtiya i. A64-0295 DATE. 25/07/2021*/    
    FIELD Selling_Channel  AS CHAR FORMAT "X(50)"  INIT ""    /*Kridtiya i. A64-0295 DATE. 25/07/2021*/
    FIELD Send_Policy_Date AS CHAR FORMAT "X(255)" INIT ""  
    FIELD Tracking_Number  AS CHAR FORMAT "X(255)" INIT ""  
    FIELD Yes_File_Date    AS CHAR FORMAT "X(255)" INIT ""  
    FIELD Policy_Status    AS CHAR FORMAT "X(255)" INIT ""  
    FIELD Policy_Year      AS CHAR FORMAT "X(255)" INIT "" 
    FIELD comdat_old       AS CHAR FORMAT "X(20)"  INIT ""   /*�ѹ���������������ͧ          */       
    FIELD expdat_old       AS CHAR FORMAT "X(20)"  INIT ""   /*�ѹ�������ش����������ͧ     */       
    FIELD ins_amt_old      AS CHAR FORMAT "X(20)"  INIT ""   /*�ع��Сѹ                     */       
    FIELD prem1_old        AS CHAR FORMAT "X(20)"  INIT ""   /*���»�Сѹ�������������ͧ��ѡ*/       
    FIELD gross_prm_old    AS CHAR FORMAT "X(20)"  INIT ""   /*�����ط����ѧ�ѡ��ǹŴ       */       
    FIELD stamp_old        AS CHAR FORMAT "X(20)"  INIT ""   /*�ӹǹ�ҡ������               */       
    FIELD vat_old          AS CHAR FORMAT "X(20)"  INIT ""   /*�ӹǹ���� Vat                 */       
    FIELD premtotal_old    AS CHAR FORMAT "X(20)"  INIT ""   /*������� ����-�ҡ�            */
    .                                              

DEF VAR nv_titlematch      AS CHAR FORMAT "X(50)"  INIT "".
DEF VAR nv_fnamematch      AS CHAR FORMAT "X(150)" INIT "".
DEF VAR nv_lnamematch      AS CHAR FORMAT "X(150)" INIT "".
DEF VAR nv_dedod           AS DECI. 
DEF VAR nv_dedod1          AS DECI. 
DEF VAR nv_dedod2          AS DECI. 
DEF VAR ut_netprm2         AS DECI. 
DEF VAR ut_netprm1         AS DECI. 

/*-- Add By Tontawan S. A68-0059 27/03/2025 --*/
DEF VAR n_drv3_salutation_M AS CHAR FORMAT "X(20)"  INIT "". // ���Ѻ 3 : �ӹ�˹��
DEF VAR n_drv3_fname        AS CHAR FORMAT "X(100)" INIT "". // ���Ѻ 3 : ����
DEF VAR n_drv3_lname        AS CHAR FORMAT "X(100)" INIT "". // ���Ѻ 3 : ���ʡ��
DEF VAR n_drv3_nid          AS CHAR FORMAT "X(20)"  INIT "". // ���Ѻ 3 : �Ţ�ѵû�ЪҪ�
DEF VAR n_drv3_occupation   AS CHAR FORMAT "X(50)"  INIT "". // ���Ѻ 3 : �Ҫվ
DEF VAR n_drv3_gender       AS CHAR FORMAT "X(10)"  INIT "". // ���Ѻ 3 : ��
DEF VAR n_drv3_birthdate    AS CHAR FORMAT "X(10)"  INIT "". // ���Ѻ 3 : �ѹ�Դ
DEF VAR n_drv4_salutation_M AS CHAR FORMAT "X(20)"  INIT "". // ���Ѻ 4 : �ӹ�˹��      
DEF VAR n_drv4_fname        AS CHAR FORMAT "X(100)" INIT "". // ���Ѻ 4 : ����          
DEF VAR n_drv4_lname        AS CHAR FORMAT "X(100)" INIT "". // ���Ѻ 4 : ���ʡ��       
DEF VAR n_drv4_nid          AS CHAR FORMAT "X(20)"  INIT "". // ���Ѻ 4 : �Ţ�ѵû�ЪҪ�
DEF VAR n_drv4_occupation   AS CHAR FORMAT "X(50)"  INIT "". // ���Ѻ 4 : �Ҫվ         
DEF VAR n_drv4_gender       AS CHAR FORMAT "X(10)"  INIT "". // ���Ѻ 4 : ��           
DEF VAR n_drv4_birthdate    AS CHAR FORMAT "X(10)"  INIT "". // ���Ѻ 4 : �ѹ�Դ       
DEF VAR n_drv5_salutation_M AS CHAR FORMAT "X(20)"  INIT "". // ���Ѻ 5 : �ӹ�˹��      
DEF VAR n_drv5_fname        AS CHAR FORMAT "X(100)" INIT "". // ���Ѻ 5 : ����          
DEF VAR n_drv5_lname        AS CHAR FORMAT "X(100)" INIT "". // ���Ѻ 5 : ���ʡ��       
DEF VAR n_drv5_nid          AS CHAR FORMAT "X(20)"  INIT "". // ���Ѻ 5 : �Ţ�ѵû�ЪҪ�
DEF VAR n_drv5_occupation   AS CHAR FORMAT "X(50)"  INIT "". // ���Ѻ 5 : �Ҫվ         
DEF VAR n_drv5_gender       AS CHAR FORMAT "X(10)"  INIT "". // ���Ѻ 5 : ��           
DEF VAR n_drv5_birthdate    AS CHAR FORMAT "X(10)"  INIT "". // ���Ѻ 5 : �ѹ�Դ       
DEF VAR n_drv1_dlicense     AS CHAR FORMAT "X(50)"  INIT "". // ���Ѻ 1 : ����¹ö
DEF VAR n_drv2_dlicense     AS CHAR FORMAT "X(50)"  INIT "". // ���Ѻ 2 : ����¹ö
DEF VAR n_drv3_dlicense     AS CHAR FORMAT "X(50)"  INIT "". // ���Ѻ 3 : ����¹ö
DEF VAR n_drv4_dlicense     AS CHAR FORMAT "X(50)"  INIT "". // ���Ѻ 4 : ����¹ö
DEF VAR n_drv5_dlicense     AS CHAR FORMAT "X(50)"  INIT "". // ���Ѻ 5 : ����¹ö
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


    
     
 
 
 
 
 
 






