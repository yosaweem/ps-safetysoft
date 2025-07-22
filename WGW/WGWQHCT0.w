&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          brstat           PROGRESS
*/
&Scoped-define WINDOW-NAME c-wins
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS c-wins 
CREATE WIDGET-POOL.
/* ***************************  Definitions  ************************** */
/* Parameters Definitions ---                                           */
/* Local Variable Definitions ---                                       */
/*++++++++++++++++++++++++++++++++++++++++++++++
  wgwqhct0.w :  Import text file from  hct to create  new policy   
                         Add in table  tlt  
                         Query & Update flag detail
  Create  by   :  Kridtiya i. [A64-0414]   On  27/11/2021
  Connect      :  
+++++++++++++++++++++++++++++++++++++++++++++++*/
/*Modify by : Kridtiyai. Date.21/06/2021  A65-0139 ��������ʴ���§ҹ �ú*/
/*Modify by : Kridtiyai. Date.08/12/2021  A65-0363 ��������ʴ���§ҹ Producer/agent */
/*modify by : Kridtiya i. A66-0266 ����������¡��§ҹ������͹� */
/*Modify by : Ranu I. A68-0044 ��� Format file output ���ͧ�ҡ����¹ format file �駧ҹ */
 {wgw/wgwqhct0.i} /*add by A68-0061*/
 Def    var  nv_rectlt    as recid  init  0.
 Def    var  nv_recidtlt  as recid  init  0.
 DEFINE VAR  n_asdat      AS CHAR.
 DEFINE VAR  vAcProc_fil  AS CHAR.
 DEFINE VAR  n_asdat1     AS CHAR. 
 DEFINE VAR  vAcProc_fil1 AS CHAR. 
 DEFINE VAR  vAcProc_fil2 AS CHAR. 
 DEF    VAR  nv_72Reciept AS CHAR INIT "" .
 DEFINE stream  ns2.
 DEF VAR nv_row AS INT INIT 0.  
 DEF  stream ns2.
 DEF VAR nv_typre AS CHAR. 
 /*comment by:A68-0061..
 DEFINE   TEMP-TABLE wdetail NO-UNDO
     FIELD  n_text001    as char  format "X(12)"  /*1    �Ţ���㺤Ӣ�          HA641108150  */  
     FIELD  n_text002    as char  format "X(10)"  /*2    �ѹ���㺤Ӣ�          12/11/2021   */  
     FIELD  n_text003    as char  format "X(32)"  /*3    �Ţ����Ѻ��         21/TMS11-3098*/  
     FIELD  n_text004    as char  format "X(10)"  /*4    �ѹ��������������ͧ              */
     FIELD  n_text005    as char  format "X(10)"  /*5    �ѹ�������ش                */    
     FIELD  n_text006    as char  format "X(10)"  /*6    ���ʺ���ѷ��Сѹ���              */
     FIELD  n_text007    as char  format "X(4)"   /*7    ������ö                         */
     FIELD  n_text008    as char  format "X(1)"   /*8    ��������â��          N            */      
     FIELD  n_text009    as char  format "X(16)"  /*9    ��������໭                 */    
     FIELD  n_text010    as char  format "X(10)"  /*10   �ӹǹ�Թ������¡�� 0000000.00  */   
     FIELD  n_text011    as char  format "X(1)"   /*11   ����������������ͧ    0           */      
     FIELD  n_text012    as char  format "X(9)"   /*12   ��������Сѹ             */        
     FIELD  n_text013    as char  format "X(6)"   /*13   ��������ë���         GARAGE      */          
     FIELD  n_text014    as char  format "X(30)"  /*14   ���ѹ�֡                */        
     FIELD  n_text015    as char  format "X(20)"  /*15   �ӹ�˹��                 */        
     FIELD  n_text016    as char  format "X(80)"  /*16   �����١���               */        
     FIELD  n_text017    as char  format "X(20)"  /*17   ���͡�ҧ                 */        
     FIELD  n_text018    as char  format "X(60)"  /*18   ���ʡ��                  */        
     FIELD  n_text019    as char  format "X(80)"  /*19   ������� 5 ���� 1         */        
     FIELD  n_text020    as char  format "X(40)"  /*20   ���     ���                  */    
     FIELD  n_text021    as char  format "X(60)"  /*21   �ǧ/�Ӻ�  ᤹�˭�                */   
     FIELD  n_text022    as char  format "X(30)"  /*22   ࢵ/�����  ���ͧ�������          */   
     FIELD  n_text023    as char  format "X(30)"  /*23   �ѧ��Ѵ ������¹                 */   
     FIELD  n_text024    as char  format "X(5)"   /*24   ������ɳ���      45000           */   
     FIELD  n_text025    as char  format "X(50)"  /*25   �Ҫվ                             */   
     FIELD  n_text026    as char  format "X(10)"  /*26   �ѹ�Դ                           */   
     FIELD  n_text027    as char  format "X(15)"  /*27   �Ţ���ѵû�ЪҪ�                 */   
     FIELD  n_text028    as char  format "X(15)"  /*28   �Ţ���㺢Ѻ���                    */   
     FIELD  n_text029    as char  format "X(10)"  /*29   ������ö                           */  
     FIELD  n_text030    as char  format "X(1)"   /*30   �����ö¹��      5                 */     
     FIELD  n_text031    as char  format "X(25)"  /*31   �����Ţ��Ƕѧ                     */
     FIELD  n_text032    as char  format "X(20)"  /*32   �����Ţ����ͧ                    */
     FIELD  n_text033    as char  format "X(40)"  /*33   �������ö                        */
     FIELD  n_text034    as char  format "X(4)"   /*34   ��蹻�   2015                     */     
     FIELD  n_text035    as char  format "X(20)"  /*35   ���ͻ�����ö     V AT             */     
     FIELD  n_text036    as char  format "X(40)"  /*36   Ẻ��Ƕѧ  ���ͧ�͹             */   
     FIELD  n_text037    as char  format "X(1)"   /*37   ���ʻ�����ö       1              */       
     FIELD  n_text038    as char  format "X(2)"   /*38   �����ѡɳС����ҹ               */
     FIELD  n_text039    as char  format "X(2)"   /*39   �ӹǹ�����                      */
     FIELD  n_text040    as char  format "X(4)"   /*40   ����ҵá�к͡�ٺ                  */
     FIELD  n_text041    as char  format "X(40)"  /*41   ������ö                          */
     FIELD  n_text042    as char  format "X(10)"  /*42   �Ţ����¹ö                      */
     FIELD  n_text043    as char  format "X(30)"  /*43   �ѧ��Ѵ��訴����¹      ������� */    
     FIELD  n_text044    as char  format "X(4)"   /*44   �շ�訴����¹  2014              */    
     FIELD  n_text045    as char  format "X(512)" /*45   �����˵�    /1.������������ 5,500 */    
     FIELD  n_text046    as char  format "X(14)"  /*46   ǧ�Թ�ع��Сѹ       00000000000.00 */    
     FIELD  n_text047    as char  format "X(14)"  /*47   ���»�Сѹ           00000000600.00 */    
     FIELD  n_text048    as char  format "X(14)"  /*48   �ҡ�                  00000000003.00 */    
     FIELD  n_text049    as char  format "X(14)"  /*49   �ӹǹ�Թ����         00000000042.21 */    
     FIELD  n_text050    as char  format "X(14)"  /*50   ���»�Сѹ���        00000000645.21 */    
     FIELD  n_text051    as char  format "X(14)"  /*51   ���»�Сѹ��������� 00000015309.56 */
     FIELD  n_text052    as char  format "X(14)"  /*52   �ѵ����ǹŴ����ѵԴ�  00000000000.00 */
     FIELD  n_text053    as char  format "X(14)"  /*53   ��ǹŴ����ѵԴ�       00000000000.00 */    
     FIELD  n_text054    as char  format "X(20)"  /*54   �����Ţʵ������                           */
     FIELD  n_text055    as char  format "X(32)"  /*55   �Ţ������������          78-70-63/H00458  */ 
     FIELD  n_text056    as char  format "X(1)"   /*56   Flag �кت���      0                    */
     FIELD  n_text057    as char  format "X(1)"   /*57   Flag ����кت���      1                 */
     FIELD  n_text058    as char  format "X(20)"  /*58   �ӹ�˹��                                */
     FIELD  n_text059    as char  format "X(80)"  /*59   ���ͼ��Ѻ��褹��� 1                    */
     FIELD  n_text060    as char  format "X(20)"  /*60   ���͡�ҧ                                */
     FIELD  n_text061    as char  format "X(60)"  /*61   ���ʡ��                                 */
     FIELD  n_text062    as char  format "X(50)"  /*62   �Ҫվ                                   */
     FIELD  n_text063    as char  format "X(10)"  /*63   �ѹ�Դ                                 */
     FIELD  n_text064    as char  format "X(15)"  /*64   �Ţ���ѵû�ЪҪ�                       */
     FIELD  n_text065    as char  format "X(15)"  /*65   �Ţ���㺢Ѻ���                          */
     FIELD  n_text066    as char  format "X(20)"  /*66   �ӹ�˹��                                */
     FIELD  n_text067    as char  format "X(80)"  /*67   ���ͼ��Ѻ��褹��� 2                    */
     FIELD  n_text068    as char  format "X(20)"  /*68   ���͡�ҧ                                    */
     FIELD  n_text069    as char  format "X(60)"  /*69   ���ʡ��                                 */
     FIELD  n_text070    as char  format "X(50)"  /*70   �Ҫվ                                   */
     FIELD  n_text071    as char  format "X(10)"  /*71   �ѹ�Դ                                 */
     FIELD  n_text072    as char  format "X(15)"  /*72   �Ţ���ѵû�ЪҪ�                           */
     FIELD  n_text073    as char  format "X(15)"  /*73   �Ţ���㺢Ѻ���                          */
     FIELD  n_text074    as char  format "X(80)"  /*74   ����Ѻ�Ż���ª��                        */
     FIELD  n_text075    as char  format "X(14)"  /*75   ����������µ�ͪ��Ե (�ҷ/��)     00000000000.00 */
     FIELD  n_text076    as char  format "X(14)"  /*76   ����������µ�ͪ��Ե (�ҷ/����)  00000000000.00 */
     FIELD  n_text077    as char  format "X(14)"  /*77   ����������µ�ͷ�Ѿ���Թ          00000000000.00 */
     FIELD  n_text078    as char  format "X(14)"  /*78   �������������ǹ�á�ؤ��          00000000000.00 */
     FIELD  n_text079    as char  format "X(14)"  /*79   ����������µ��ö¹��             00000000000.00 */
     FIELD  n_text080    as char  format "X(14)"  /*80   �������������ǹ�áö¹��         00000000000.00 */
     FIELD  n_text081    as char  format "X(14)"  /*81   ö¹���٭���/�����              00000000000.00 */
     FIELD  n_text082    as char  format "X(14)"  /*82   �غѵ��˵���ǹ�ؤ�����ª��Ե���Ѻ���             00000000000.00 */
     FIELD  n_text083    as char  format "X(2)"   /*83   �غѵ��˵���ǹ�ؤ�����ª��Ե��.��������          00             */
     FIELD  n_text084    as char  format "X(14)"  /*84   �غѵ��˵���ǹ�ؤ�����ª��Ե��������/����       00000000000.00 */
     FIELD  n_text085    as char  format "X(14)"  /*85   �غѵ��˵���ǹ�ؤ�ŷؾ���Ҿ���Ǥ��� ���Ѻ���     00000000000.00 */
     FIELD  n_text086    as char  format "X(2)"   /*86   �غѵ��˵���ǹ�ؤ�ŷؾ���Ҿ���Ǥ��� ��.��������  00             */
     FIELD  n_text087    as char  format "X(14)"  /*87   �غѵ��˵���ǹ�ؤ�ŷؾ���Ҿ���Ǥ��Ǽ�������/����00000000000.00 */
     FIELD  n_text088    as char  format "X(14)"  /*88   ����ѡ�Ҿ�Һ��                                    00000000000.00 */
     FIELD  n_text089    as char  format "X(14)"  /*89   ��û�Сѹ��Ǽ��Ѻ���                             00000000000.00 */
     FIELD  n_text090    as char  format "X(6)"   /*90   ʶҹТ�����                                       NEW            */         
     FIELD  n_text091    as char  format "X(10)"  /*91   ����������駻�Сѹ          DLR                */ 
     FIELD  n_text092    as char  format "X(10)"  /*92   ���ʺ���ѷ����駻�Сѹ  RJM                    */ 
     FIELD  n_text093    as char  format "X(30)"  /*93   �ҢҺ���ѷ����駻�Сѹ  �ӹѡ�ҹ�˭�           */ 
     FIELD  n_text094    as char  format "X(80)"  /*94   ���ͼ��Դ��� / Salesman ����ó� ���ФӨѹ���   */ 
     FIELD  n_text095    as char  format "X(10)"  /*95   ����ѷ�������ö         RJS                    */   
     FIELD  n_text096    as char  format "X(30)"  /*96   �ҢҺ���ѷ�������ö     �ӹѡ�ҹ�˭�           */ 
     FIELD  n_text097    as char  format "X(12)"  /*97   Honda Project            �͡�ç���             */       
     FIELD  n_text098    as char  format "X(3)"   /*98   ����ö                   008                    */               
     FIELD  n_text099    as char  format "X(10)"  /*99   ��ԡ������������ 1 AA                           */ 
     FIELD  n_text100    as char  format "X(14)"  /*100  �ҤҺ�ԡ������������ 1                          */ 
     FIELD  n_text101    as char  format "X(10)"  /*101  ��ԡ������������ 2                              */ 
     FIELD  n_text102    as char  format "X(14)"  /*102  �ҤҺ�ԡ������������ 2                          */ 
     FIELD  n_text103    as char  format "X(10)"  /*103  ��ԡ������������ 3                              */ 
     FIELD  n_text104    as char  format "X(14)"  /*104  �ҤҺ�ԡ������������ 3                          */ 
     FIELD  n_text105    as char  format "X(10)"  /*105  ��ԡ������������ 4                              */ 
     FIELD  n_text106    as char  format "X(14)"  /*106  �ҤҺ�ԡ������������ 4                          */ 
     FIELD  n_text107    as char  format "X(10)"  /*107  ��ԡ������������ 5                              */ 
     FIELD  n_text108    as char  format "X(14)"  /*108  �ҤҺ�ԡ������������ 5                          */ 
     FIELD  n_text109    as char  format "X(15)"  /*109  ������       /                                  */ 
     FIELD  n_text110    as char  format "X(10)"  /*110  �ѹ���    13/11/2021                            */ 
     FIELD  n_text111    as char  format "X(14)"  /*111  �ӹǹ�Թ     00000015309.56                    */ 
     FIELD  n_text112    as char  format "X(10)"  /*112  ������  CASH                                   */ 
     FIELD  n_text113    as char  format "X(20)"  /*113  �Ţ���ѵù��˹��    6204023613                 */ 
     FIELD  n_text114    as char  format "X(1)"   /*114  �͡�����㹹��   1                             */ 
     FIELD  n_text115    as char  format "X(120)" /*115  ���������     ��������� �.�.���� ���Ҵ���   */ 
     FIELD  n_text116    as char  format "X(100)" /*116  ��������´��໭                                */ 
     FIELD  n_text117    as char  format "X(2)"   /*117  �Ѻ��Сѹ�������                               */ 
     FIELD  n_text118    as char  format "X(2)"   /*118  ��͹����/��͹                                  */ 
     FIELD  n_text119    as char  format "X(10)"  /*119  �ѵ��ôԵ��Ҥ��                                */ 
     FIELD  n_text120    as char  format "X(1)"   /*120  ����������駧ҹ          R                     */ 
     FIELD  n_text121    as char  format "X(10)"  /*121  ����Ҥ��ػ�ó������       5500.00                     */
     FIELD  n_text122    as char  format "X(255)" /*122  ��������´�ػ�ó������                            */
     FIELD  n_text123    as char  format "X(5)"   /*123  �ҢҺ���ѷ�ͧ�����һ�Сѹ (�١���)      �ҢҺ���ѷ�ͧ�����һ�Сѹ (�١���) */                                     
     FIELD  n_text124    as char  format "X(20)"  /*124  ���������ͺ���        ���������ͺ��� */                                                       
     FIELD  n_text125    as char  format "X(10)"  /*125  �Ҥ����ͺ���  �Ҥ����ͺ���  0    */                                                   
     FIELD  n_text126    as char  format "X(150)" /*126  ���ͺ���ѷ�����㺡ӡѺ����1    ���ͺ���ѷ�����㺡ӡѺ����1    �.�.���� ���Ҵ���  */                     
     FIELD  n_text127    as char  format "X(15)"  /*127  �ҢҺ���ѷ��㺡ӡѺ����1        �ҢҺ���ѷ��㺡ӡѺ����1                            */                    
     FIELD  n_text128    as char  format "X(250)" /*128  ������躹㺡ӡѺ����1   ������躹㺡ӡѺ����1   5 ���� 1  ᤹�˭� ���ͧ������� �.������� 45000 */
     FIELD  n_text129    as char  format "X(13)"  /*129  �Ţ�������������1      �Ţ�������������1                                                           */
     FIELD  n_text130    as char  format "X(10)"  /*130  �ѵ�����µ��㺡ӡѺ1 (��������ҡ��������)     �ѵ�����µ��㺡ӡѺ1 (��������ҡ��������) 645.21   */                   
     FIELD  n_text131    as char  format "X(150)" /*131  ���ͺ���ѷ�����㺡ӡѺ����2    ���ͺ���ѷ�����㺡ӡѺ����2                                     */
     FIELD  n_text132    as char  format "X(15)"  /*132  �ҢҺ���ѷ��㺡ӡѺ����2        �ҢҺ���ѷ��㺡ӡѺ����2                                             */
     FIELD  n_text133    as char  format "X(250)" /*133  ������躹㺡ӡѺ����2   ������躹㺡ӡѺ����2                                                    */
     FIELD  n_text134    as char  format "X(13)"  /*134  �Ţ�������������2      �Ţ�������������2                                                           */
     FIELD  n_text135    as char  format "X(10)"  /*135  �ѵ�����µ��㺡ӡѺ2 (��������ҡ��������)     �ѵ�����µ��㺡ӡѺ2 (��������ҡ��������) 0        */
     FIELD  n_text136    as char  format "X(150)" /*136  ���ͺ���ѷ�����㺡ӡѺ����3    ���ͺ���ѷ�����㺡ӡѺ����3                                     */
     FIELD  n_text137    as char  format "X(15)"  /*137  �ҢҺ���ѷ��㺡ӡѺ����3        �ҢҺ���ѷ��㺡ӡѺ����3                                             */
     FIELD  n_text138    as char  format "X(250)" /*138  ������躹㺡ӡѺ����3   ������躹㺡ӡѺ����3                                                    */
     FIELD  n_text139    as char  format "X(13)"  /*139  �Ţ�������������3      �Ţ�������������3                                                           */
     FIELD  n_text140    as char  format "X(10)"  /*140  �ѵ�����µ��㺡ӡѺ3 (��������ҡ��������)     �ѵ�����µ��㺡ӡѺ3 (��������ҡ��������) 0        */
     FIELD  n_text141    as char  format "X(10)"  /*141  �Ţ�����໭    �Ţ�����໭            */
     FIELD  n_text142    as char  format "X(10)"   /*142 ��������ê�������      ��������ê�������  */
     FIELD  n_text143    as char  format "X(10)"
     FIELD  n_text144    as char  format "X(10)" .
     ...end A68-0061..*/

  DEFINE   TEMP-TABLE wproducer NO-UNDO
     FIELD  producer   as char  format "X(20)" .

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main
&Scoped-define BROWSE-NAME br_tlt

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES tlt

/* Definitions for BROWSE br_tlt                                        */
&Scoped-define FIELDS-IN-QUERY-br_tlt tlt.releas tlt.policy ~
tlt.comp_noti_ins tlt.comp_noti_tlt tlt.comp_pol tlt.nor_effdat ~
tlt.comp_sub tlt.cifno tlt.comp_effdat tlt.nationality tlt.nor_noti_ins ~
tlt.nor_noti_tlt tlt.nor_usr_ins tlt.covcod tlt.nor_usr_tlt 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_tlt 
&Scoped-define QUERY-STRING-br_tlt FOR EACH tlt NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br_tlt OPEN QUERY br_tlt FOR EACH tlt NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br_tlt tlt
&Scoped-define FIRST-TABLE-IN-QUERY-br_tlt tlt


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS rs_typre ra_poltype ra_typedate fi_trndatfr ~
fi_trndatto bu_ok cb_search bu_oksch br_tlt fi_search cb_report fi_outfile ~
bu_report bu_exit bu_update bu_upyesno bu_match fi_producer fi_outfileexp ~
cb_reportstatus RECT-332 RECT-333 RECT-338 RECT-340 RECT-341 RECT-381 ~
RECT-343 RECT-383 
&Scoped-Define DISPLAYED-OBJECTS rs_typre ra_poltype ra_typedate ~
fi_trndatfr fi_trndatto cb_search fi_search cb_report fi_outfile fi_name ~
fi_producer fi_outfileexp cb_reportstatus 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR c-wins AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_exit 
     LABEL "Exit" 
     SIZE 9 BY 1.52
     FONT 6.

DEFINE BUTTON bu_match 
     LABEL "MatchData" 
     SIZE 12.5 BY 1
     BGCOLOR 7 FONT 6.

DEFINE BUTTON bu_ok 
     LABEL "OK" 
     SIZE 9 BY 1
     FONT 6.

DEFINE BUTTON bu_oksch 
     LABEL "OK" 
     SIZE 5 BY .95
     FONT 6.

DEFINE BUTTON bu_report 
     LABEL "OK" 
     SIZE 7 BY .95
     FONT 6.

DEFINE BUTTON bu_update 
     LABEL "CANCEL" 
     SIZE 14 BY 1.05
     BGCOLOR 12 FONT 6.

DEFINE BUTTON bu_upyesno 
     LABEL "YES/NO" 
     SIZE 14 BY 1.05
     BGCOLOR 2 FONT 6.

DEFINE VARIABLE cb_report AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "BR_M" 
     DROP-DOWN-LIST
     SIZE 20 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE cb_reportstatus AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "Yes" 
     DROP-DOWN-LIST
     SIZE 20 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE cb_search AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "�����١���" 
     DROP-DOWN-LIST
     SIZE 40 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_name AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 39 BY .95
     BGCOLOR 1 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_outfile AS CHARACTER FORMAT "X(500)":U 
     VIEW-AS FILL-IN 
     SIZE 96.17 BY .91
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_outfileexp AS CHARACTER FORMAT "X(500)":U 
     VIEW-AS FILL-IN 
     SIZE 96.17 BY .91
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY .91 NO-UNDO.

DEFINE VARIABLE fi_search AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 45 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_trndatfr AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 25 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_trndatto AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 25 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_poltype AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "V70", 1,
"V72", 2,
"ALL", 3
     SIZE 22 BY 1
     BGCOLOR 19  NO-UNDO.

DEFINE VARIABLE ra_typedate AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Comdate", 1,
"Trandate", 2
     SIZE 22 BY 1
     BGCOLOR 19  NO-UNDO.

DEFINE VARIABLE rs_typre AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Format Old (.TXT)", 1,
"Format New (.CSV)", 2
     SIZE 57.17 BY .91
     BGCOLOR 10 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-332
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132 BY 10.91
     BGCOLOR 31 .

DEFINE RECTANGLE RECT-333
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 11.5 BY 1.76
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-338
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 57 BY 3
     BGCOLOR 29 .

DEFINE RECTANGLE RECT-340
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 115.5 BY 2.14
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-341
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 12.33 BY 2
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-343
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 73.5 BY 3
     BGCOLOR 29 .

DEFINE RECTANGLE RECT-381
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 7.5 BY 1.52
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-383
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 9.17 BY 1.52
     BGCOLOR 11 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_tlt FOR 
      tlt SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_tlt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_tlt c-wins _STRUCTURED
  QUERY br_tlt NO-LOCK DISPLAY
      tlt.releas COLUMN-LABEL "Status" FORMAT "x(12)":U
      tlt.policy FORMAT "x(16)":U
      tlt.comp_noti_ins COLUMN-LABEL "�Ţ���㺤Ӣ�" FORMAT "x(15)":U
      tlt.comp_noti_tlt COLUMN-LABEL "�ѹ���㺤Ӣ�" FORMAT "x(10)":U
      tlt.comp_pol COLUMN-LABEL "�Ţ����Ѻ��" FORMAT "x(25)":U
            WIDTH 23.83
      tlt.nor_effdat FORMAT "99/99/9999":U
      tlt.comp_sub COLUMN-LABEL "���ʺ���ѷ" FORMAT "x(4)":U
      tlt.cifno COLUMN-LABEL "������ö" FORMAT "x(20)":U WIDTH 16.5
      tlt.comp_effdat COLUMN-LABEL "�ѹ�������ش" FORMAT "99/99/9999":U
      tlt.nationality COLUMN-LABEL "��������â��" FORMAT "x(20)":U
            WIDTH 15.17
      tlt.nor_noti_ins COLUMN-LABEL "��������໭" FORMAT "x(25)":U
            WIDTH 21.33
      tlt.nor_noti_tlt COLUMN-LABEL "�ӹǹ�Թ������¡��" FORMAT "x(25)":U
      tlt.nor_usr_ins COLUMN-LABEL "����������������ͧ" FORMAT "x(50)":U
      tlt.covcod FORMAT "x(5)":U
      tlt.nor_usr_tlt COLUMN-LABEL "��������ë���" FORMAT "x(4)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 132 BY 12.57
         BGCOLOR 15  ROW-HEIGHT-CHARS .75.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     rs_typre AT ROW 8.81 COL 16.83 NO-LABEL WIDGET-ID 66
     ra_poltype AT ROW 6.67 COL 86.5 NO-LABEL WIDGET-ID 50
     ra_typedate AT ROW 6.67 COL 109 NO-LABEL WIDGET-ID 22
     fi_trndatfr AT ROW 1.71 COL 23 COLON-ALIGNED NO-LABEL
     fi_trndatto AT ROW 1.71 COL 56.17 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 1.71 COL 85
     cb_search AT ROW 3.71 COL 15.5 COLON-ALIGNED NO-LABEL
     bu_oksch AT ROW 5.05 COL 51.17
     br_tlt AT ROW 11.95 COL 1.33
     fi_search AT ROW 4.95 COL 3 NO-LABEL
     cb_report AT ROW 6.71 COL 12.33 COLON-ALIGNED NO-LABEL
     fi_outfile AT ROW 9.81 COL 16.83 NO-LABEL
     bu_report AT ROW 10.05 COL 115.5
     bu_exit AT ROW 1.48 COL 121.67
     fi_name AT ROW 4.95 COL 60.17 COLON-ALIGNED NO-LABEL WIDGET-ID 8
     bu_update AT ROW 4.95 COL 102 WIDGET-ID 10
     bu_upyesno AT ROW 4.95 COL 117.17 WIDGET-ID 12
     bu_match AT ROW 1.71 COL 98 WIDGET-ID 16
     fi_producer AT ROW 7.86 COL 12 COLON-ALIGNED NO-LABEL WIDGET-ID 20
     fi_outfileexp AT ROW 10.76 COL 16.83 NO-LABEL WIDGET-ID 26
     cb_reportstatus AT ROW 6.71 COL 45 COLON-ALIGNED NO-LABEL WIDGET-ID 58
     "Click for update Flag Cancel":40 VIEW-AS TEXT
          SIZE 29.5 BY .95 AT ROW 3.76 COL 62.5 WIDGET-ID 6
          BGCOLOR 19 FGCOLOR 6 FONT 6
     "1Report BY" VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 6.71 COL 2.5
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "3Producer:" VIEW-AS TEXT
          SIZE 11 BY .91 AT ROW 7.81 COL 2.5 WIDGET-ID 18
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "Report Type :" VIEW-AS TEXT
          SIZE 13.33 BY .91 AT ROW 8.81 COL 2.67 WIDGET-ID 74
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "2Report BY" VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 6.71 COL 35.17 WIDGET-ID 60
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "Output CSV:" VIEW-AS TEXT
          SIZE 13.5 BY .91 AT ROW 10.76 COL 2.5 WIDGET-ID 28
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "To  :" VIEW-AS TEXT
          SIZE 7.5 BY 1 AT ROW 1.71 COL 50.33
          BGCOLOR 19 FONT 6
     "Output TXT :" VIEW-AS TEXT
          SIZE 13.33 BY .91 AT ROW 9.76 COL 2.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "�ѹ�������駧ҹ  From :" VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 1.71 COL 3
          BGCOLOR 19 FONT 6
     "ext.B3M0062,B3M0064,B3M0065,B3M0066 [����к�=������]" VIEW-AS TEXT
          SIZE 57 BY .91 AT ROW 7.81 COL 74.83 WIDGET-ID 56
          BGCOLOR 31 FONT 6
     "ext.Yes,No,Not Re" VIEW-AS TEXT
          SIZE 18 BY .95 AT ROW 6.71 COL 67.67 WIDGET-ID 54
          BGCOLOR 31 FONT 6
     "   Search  By :" VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 3.71 COL 3
          BGCOLOR 29 FGCOLOR 1 FONT 6
     RECT-332 AT ROW 1.05 COL 1.5
     RECT-333 AT ROW 1.48 COL 84
     RECT-338 AT ROW 3.43 COL 2
     RECT-340 AT ROW 1.24 COL 2
     RECT-341 AT ROW 1.24 COL 120
     RECT-381 AT ROW 4.76 COL 50
     RECT-343 AT ROW 3.43 COL 59 WIDGET-ID 2
     RECT-383 AT ROW 9.81 COL 114.5 WIDGET-ID 4
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
         BGCOLOR 8 .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Window
   Allow: Basic,Browse,DB-Fields,Window,Query
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW c-wins ASSIGN
         HIDDEN             = YES
         TITLE              = "Query && Update [HCT]"
         HEIGHT             = 23.81
         WIDTH              = 132.67
         MAX-HEIGHT         = 45.76
         MAX-WIDTH          = 213.33
         VIRTUAL-HEIGHT     = 45.76
         VIRTUAL-WIDTH      = 213.33
         RESIZE             = yes
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = ?
         FGCOLOR            = ?
         KEEP-FRAME-Z-ORDER = yes
         THREE-D            = yes
         FONT               = 6
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.

&IF '{&WINDOW-SYSTEM}' NE 'TTY' &THEN
IF NOT c-wins:LOAD-ICON("wimage\safety":U) THEN
    MESSAGE "Unable to load icon: wimage\safety"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW c-wins
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fr_main
   FRAME-NAME Custom                                                    */
/* BROWSE-TAB br_tlt bu_oksch fr_main */
/* SETTINGS FOR FILL-IN fi_name IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_outfile IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_outfileexp IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_search IN FRAME fr_main
   ALIGN-L                                                              */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(c-wins)
THEN c-wins:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_tlt
/* Query rebuild information for BROWSE br_tlt
     _TblList          = "brstat.tlt"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   > brstat.tlt.releas
"tlt.releas" "Status" "x(12)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   = brstat.tlt.policy
     _FldNameList[3]   > brstat.tlt.comp_noti_ins
"tlt.comp_noti_ins" "�Ţ���㺤Ӣ�" "x(15)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > brstat.tlt.comp_noti_tlt
"tlt.comp_noti_tlt" "�ѹ���㺤Ӣ�" "x(10)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > brstat.tlt.comp_pol
"tlt.comp_pol" "�Ţ����Ѻ��" ? "character" ? ? ? ? ? ? no ? no no "23.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   = brstat.tlt.nor_effdat
     _FldNameList[7]   > brstat.tlt.comp_sub
"tlt.comp_sub" "���ʺ���ѷ" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > brstat.tlt.cifno
"tlt.cifno" "������ö" ? "character" ? ? ? ? ? ? no ? no no "16.5" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > brstat.tlt.comp_effdat
"tlt.comp_effdat" "�ѹ�������ش" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   > brstat.tlt.nationality
"tlt.nationality" "��������â��" ? "character" ? ? ? ? ? ? no ? no no "15.17" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[11]   > brstat.tlt.nor_noti_ins
"tlt.nor_noti_ins" "��������໭" ? "character" ? ? ? ? ? ? no ? no no "21.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[12]   > brstat.tlt.nor_noti_tlt
"tlt.nor_noti_tlt" "�ӹǹ�Թ������¡��" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[13]   > brstat.tlt.nor_usr_ins
"tlt.nor_usr_ins" "����������������ͧ" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[14]   = brstat.tlt.covcod
     _FldNameList[15]   > brstat.tlt.nor_usr_tlt
"tlt.nor_usr_tlt" "��������ë���" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE br_tlt */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME c-wins
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-wins c-wins
ON END-ERROR OF c-wins /* Query  Update [HCT] */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-wins c-wins
ON WINDOW-CLOSE OF c-wins /* Query  Update [HCT] */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_tlt
&Scoped-define SELF-NAME br_tlt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_tlt c-wins
ON LEFT-MOUSE-DBLCLICK OF br_tlt IN FRAME fr_main
DO:
    Get Current br_tlt.
          nv_recidtlt  =  Recid(tlt).

    {&WINDOW-NAME}:hidden  =  Yes. 
    
    Run  wgw\WGWQHCT1(Input  nv_recidtlt).

    {&WINDOW-NAME}:hidden  =  No.                                               

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_tlt c-wins
ON VALUE-CHANGED OF br_tlt IN FRAME fr_main
DO:
     Get  current  br_tlt.
     nv_rectlt =  recid(tlt).
/*      fi_name   =  tlt.ins_name.          */
/*      disp  fi_name  with frame  fr_main. */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit c-wins
ON CHOOSE OF bu_exit IN FRAME fr_main /* Exit */
DO:
   
   Apply "Close" to This-procedure.
   Return no-apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_match
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_match c-wins
ON CHOOSE OF bu_match IN FRAME fr_main /* MatchData */
DO:
    For each tlt Use-index  tlt01  Where
        tlt.trndat  >=   fi_trndatfr   And
        tlt.trndat  <=   fi_trndatto   And
        tlt.genusr   =  "HCT"        .
        IF tlt.nor_usr_ins = "0"  THEN DO:
            FIND LAST sicuw.uwm100 USE-INDEX uwm10002 
                WHERE sicuw.uwm100.cedpol = tlt.comp_noti_ins   + "-" + tlt.note7   AND 
                sicuw.uwm100.poltyp       = "v72"    NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL uwm100 THEN DO: 
                ASSIGN  
                    brstat.tlt.policy  = sicuw.uwm100.policy
                    brstat.tlt.ins_brins = sicuw.uwm100.branch
                    brstat.tlt.acno1     = sicuw.uwm100.acno1  
                    brstat.tlt.agent     = sicuw.uwm100.agent .
                IF sicuw.uwm100.releas = YES THEN brstat.tlt.releas = "yes".
                ELSE brstat.tlt.releas = "Not Re".
            END.
        END.
        ELSE DO:
            FIND LAST sicuw.uwm100 USE-INDEX uwm10002 
                WHERE sicuw.uwm100.cedpol = tlt.comp_noti_ins   + "-" + tlt.note7   AND 
                sicuw.uwm100.poltyp       = "v70"    NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL uwm100 THEN DO: 
                ASSIGN  
                    brstat.tlt.policy  = sicuw.uwm100.policy
                    brstat.tlt.ins_brins = sicuw.uwm100.branch
                    brstat.tlt.acno1     = sicuw.uwm100.acno1  
                    brstat.tlt.agent     = sicuw.uwm100.agent .
                IF sicuw.uwm100.releas = YES THEN brstat.tlt.releas = "yes".
                ELSE brstat.tlt.releas = "Not Re".
            END.
        END.
    END.
    MESSAGE "Complete" VIEW-AS ALERT-BOX.
            
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok c-wins
ON CHOOSE OF bu_ok IN FRAME fr_main /* OK */
DO:
    Open Query br_tlt 
        For each tlt Use-index  tlt01  Where
        tlt.trndat  >=   fi_trndatfr   And
        tlt.trndat  <=   fi_trndatto   And
        /*tlt.policy  >=   fi_polfr     And
        tlt.policy  <=   fi_polto     And*/
        /*tlt.comp_sub  =  fi_producer  And*/
        tlt.genusr   =  "HCT"        no-lock.  
            nv_rectlt =  recid(tlt).   /*A55-0184*/
            Apply "Entry"  to br_tlt.
            Return no-apply.                             
            /*------------------------ 
            {&WINDOW-NAME}:hidden  =  Yes. 
            Run  wuw\wuwqtis1(Input  fi_trndatfr,
            fi_trndatto,
            fi_polfr,
            fi_polto,
            fi_producer).
            {&WINDOW-NAME}:hidden  =  No.                                               
            --------------------------*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_oksch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_oksch c-wins
ON CHOOSE OF bu_oksch IN FRAME fr_main /* OK */
DO:
    Disp fi_search  with frame fr_main.
    If  cb_search  = "�Ţ��Ƕѧ"  Then do:  /* chassis no */
        Open Query br_tlt 
            For each tlt Use-index  tlt06 Where
            tlt.trndat >=  fi_trndatfr    And
            tlt.trndat <=  fi_trndatto    AND 
            tlt.genusr   =  "HCT"       And
            INDEX(tlt.cha_no,trim(fi_search)) <> 0  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .   
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  cb_search = "�����١���"  Then do:              /* name  */                      
        Open Query br_tlt                                                        
            For each tlt Use-index  tlt01      Where                                     
            tlt.trndat  >=  fi_trndatfr        And                                            
            tlt.trndat  <=  fi_trndatto        And  
            tlt.genusr   =  "HCT"            And
            index(tlt.ins_name,fi_search) <> 0 no-lock.  
                ASSIGN nv_rectlt =  recid(tlt) .   
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  cb_search  =  "�Ţ����ѭ��"  Then do:    
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "HCT"      And
            index(tlt.comp_noti_ins,fi_search) <> 0  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .   
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  cb_search  =  "�ѹ��������ͧ"   Then do:   
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "HCT"      And
            tlt.nor_effdat    = date(fi_search)    no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  cb_search  =  "�ѹ����������"  Then do:    
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "HCT"      And
            tlt.comp_effdat      = date(fi_search)       no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .   
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  cb_search  =  "�������駧ҹ"  Then do:    
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "HCT"      And
            brstat.tlt.rec_note2     =  fi_search         no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .   
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  cb_search  =   "Producer"  Then do:          
        Open Query br_tlt 
            For each tlt Use-index  tlt01  Where
            tlt.trndat  >=  fi_trndatfr    And
            tlt.trndat  <=  fi_trndatto    And
            tlt.genusr   =  "hct"        And
            tlt.acno1        =  fi_search      no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .     
                Apply "Entry"  to br_tlt.
                Return no-apply.                             
    END.
    ELSE If  cb_search  =  "Stickerno"  Then do:        
        Open Query br_tlt 
            For each tlt Use-index  tlt01  Where
            tlt.trndat  >=  fi_trndatfr    And
            tlt.trndat  <=  fi_trndatto    And
            tlt.genusr   =  "hct"        And
            tlt.comp_sck =  fi_search      no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .     
                Apply "Entry"  to br_tlt.
                Return no-apply.                             
    END.
    ELSE If  cb_search  =  "�Ţ����Ѻ��"  Then do:        
        Open Query br_tlt 
            For each tlt Use-index  tlt01  Where
            tlt.trndat  >=  fi_trndatfr    And
            tlt.trndat  <=  fi_trndatto    And
            tlt.genusr   =  "hct"          And
            tlt.comp_pol =  fi_search      no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .     
                Apply "Entry"  to br_tlt.
                Return no-apply.                             
    END.
    Else  do:
        ASSIGN nv_rectlt =  recid(tlt) .  
        Apply "Entry"  to  fi_search.
        Return no-apply.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_report
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_report c-wins
ON CHOOSE OF bu_report IN FRAME fr_main /* OK */
DO:
    /*IF fi_outfile = "" THEN DO:*/               /*A68-0061*/
    IF fi_outfile = "" AND rs_typre = 1 THEN DO:  /*A68-0061*/
        MESSAGE "��س��ʪ������!!!"  VIEW-AS ALERT-BOX.
        Apply "Entry"  to fi_outfile.
        Return no-apply. 
    END.
    ELSE DO:
        RUN pd_cutproducer.
        RUN pd_reportfiel. 
        Message "Export data Complete"  View-as alert-box.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_update
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_update c-wins
ON CHOOSE OF bu_update IN FRAME fr_main /* CANCEL */
DO:
    Find tlt Where Recid(tlt)  =  nv_rectlt .
    If  avail tlt Then do:
        If  index(tlt.releas,"CA")  =  0  Then do:
            message "¡��ԡ��������¡�ù��  "  View-as alert-box.
              
            tlt.releas  =  "CA/" + tlt.releas .
        END.
        Else do:
            tlt.releas =  replace(tlt.releas,"CA/","")  .
            message "���¡�����š�Ѻ����ҹ "  View-as alert-box.
             
                
             
        END.
    END.
    RELEASE tlt.
    Run Pro_OpenQuery2.
    Apply "Entry"  to br_tlt.
    Return no-apply.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_upyesno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_upyesno c-wins
ON CHOOSE OF bu_upyesno IN FRAME fr_main /* YES/NO */
DO:
    Find tlt Where Recid(tlt)  =  nv_rectlt.
    If  avail tlt Then do:
        If  index(tlt.releas,"No")  =  0  Then do:  /* yes */
            message "Update No ��������¡�ù��  "  View-as alert-box.
            IF tlt.releas = "" THEN tlt.releas  =  "NO" .
            ELSE IF index(tlt.releas,"Cancel/")  <> 0 THEN 
                ASSIGN tlt.releas  =  "Cancel/no" .
            ELSE ASSIGN tlt.releas  =  "no" .
        END.
        Else do:    /* no */
            If  index(tlt.releas,"Yes")  =  0  Then do:  /* yes */
            message "Update Yes ��������¡�ù��  "  View-as alert-box.
            IF tlt.releas = "" THEN tlt.releas  =  "Yes" .
            ELSE IF index(tlt.releas,"Cancel/")  <> 0 THEN 
                ASSIGN tlt.releas  =  "Cancel/Yes" .
            ELSE ASSIGN tlt.releas  =  "Yes" .
        END.
        END.
    END.
    RELEASE tlt.
    Run Pro_OpenQuery2.
    Apply "Entry"  to br_tlt.
    Return no-apply. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cb_report
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cb_report c-wins
ON LEAVE OF cb_report IN FRAME fr_main
DO:
  /*p-------------*/
    cb_report = INPUT cb_report.
    n_asdat1  = INPUT cb_report.

    IF n_asdat1 = "" THEN DO:
        MESSAGE "��辺������ ��سҵ�Ǩ�ͺ��� Process ������" VIEW-AS ALERT-BOX WARNING.
        RETURN NO-APPLY.
    END.
    /*-------------p*/

    /*APPLY "ENTRY" TO fi_comdatF.*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cb_report c-wins
ON return OF cb_report IN FRAME fr_main
DO:
  APPLY "LEAVE" TO cb_report.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cb_report c-wins
ON VALUE-CHANGED OF cb_report IN FRAME fr_main
DO:
  /*p-------------*/
    cb_report = INPUT cb_report.
    n_asdat1 =  (INPUT cb_report).

    IF n_asdat1 = "" THEN DO:
        MESSAGE "��辺������ ��ä�" VIEW-AS ALERT-BOX WARNING.
        RETURN NO-APPLY.
    END.
    /*APPLY "ENTRY" TO fi_comdatF IN FRAME {&FRAME-NAME}.
    RETURN NO-APPLY.*/
    /*-------------p*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cb_reportstatus
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cb_reportstatus c-wins
ON LEAVE OF cb_reportstatus IN FRAME fr_main
DO:
  /*p-------------*/
    cb_report = INPUT cb_report.
    n_asdat1  = INPUT cb_report.

    IF n_asdat1 = "" THEN DO:
        MESSAGE "��辺������ ��سҵ�Ǩ�ͺ��� Process ������" VIEW-AS ALERT-BOX WARNING.
        RETURN NO-APPLY.
    END.
    /*-------------p*/

    /*APPLY "ENTRY" TO fi_comdatF.*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cb_reportstatus c-wins
ON return OF cb_reportstatus IN FRAME fr_main
DO:
  APPLY "LEAVE" TO cb_report.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cb_reportstatus c-wins
ON VALUE-CHANGED OF cb_reportstatus IN FRAME fr_main
DO:
  /*p-------------*/
    cb_reportstatus = INPUT cb_reportstatus.
    /*n_asdat1 =  (INPUT cb_reportstatus).

    IF n_asdat1 = "" THEN DO:
        MESSAGE "��辺������ ��ä�" VIEW-AS ALERT-BOX WARNING.
        RETURN NO-APPLY.
    END.*/
    /*APPLY "ENTRY" TO fi_comdatF IN FRAME {&FRAME-NAME}.
    RETURN NO-APPLY.*/
    /*-------------p*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cb_search
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cb_search c-wins
ON LEAVE OF cb_search IN FRAME fr_main
DO:
  /*p-------------*/
    cb_search = INPUT cb_search.
    n_asdat = INPUT cb_search.

    IF n_asdat = "" THEN DO:
        MESSAGE "��辺������ ��سҵ�Ǩ�ͺ��� Process ������" VIEW-AS ALERT-BOX WARNING.
        RETURN NO-APPLY.
    END.
    /*-------------p*/

    /*APPLY "ENTRY" TO fi_comdatF.*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cb_search c-wins
ON return OF cb_search IN FRAME fr_main
DO:
  APPLY "LEAVE" TO cb_search.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cb_search c-wins
ON VALUE-CHANGED OF cb_search IN FRAME fr_main
DO:
  /*p-------------*/
    cb_search = INPUT cb_search.
    n_asdat =  (INPUT cb_search).

    IF n_asdat = "" THEN DO:
        MESSAGE "��辺������ ��ä�" VIEW-AS ALERT-BOX WARNING.
        RETURN NO-APPLY.
    END.
    /*APPLY "ENTRY" TO fi_comdatF IN FRAME {&FRAME-NAME}.
    RETURN NO-APPLY.*/
    /*-------------p*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_name
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_name c-wins
ON LEAVE OF fi_name IN FRAME fr_main
DO:
  fi_name  =  Input  fi_name.
  Disp  fi_name  with frame  fr_main. 
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_outfile
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outfile c-wins
ON LEAVE OF fi_outfile IN FRAME fr_main
DO:
  fi_outfile = INPUT fi_outfile.
  DISP fi_outfile WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_outfileexp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outfileexp c-wins
ON LEAVE OF fi_outfileexp IN FRAME fr_main
DO:
  fi_outfileexp = INPUT fi_outfileexp.
  IF index(fi_outfileexp,".csv") = 0 THEN  
       fi_outfileexp = fi_outfileexp + ".csv" .
  DISP fi_outfileexp WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer c-wins
ON LEAVE OF fi_producer IN FRAME fr_main
DO:
  fi_producer = INPUT fi_producer.
  DISP fi_producer WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_search
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_search c-wins
ON LEAVE OF fi_search IN FRAME fr_main
DO:
    DEF VAR  nv_sort   as  int  init 0.
    ASSIGN
        fi_search     =  Input  fi_search.
    Disp fi_search  with frame fr_main.
    If  cb_search = "�����١���"  Then do:              /* name  */                          
        Open Query br_tlt                                                       
            For each tlt Use-index  tlt01  Where                                    
            tlt.trndat  >=  fi_trndatfr         And                                          
            tlt.trndat  <=  fi_trndatto         And                              
            tlt.genusr   =  "hct"             And                              
            index(tlt.ins_name,fi_search) <> 0  no-lock.                        
                ASSIGN nv_rectlt =  recid(tlt) .   
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.                                     
    ELSE If  cb_search  = "�Ţ��Ƕѧ"  Then do:  /* chassis no */
        Open Query br_tlt                           
            For each tlt Use-index  tlt06 Where     
            tlt.trndat >=  fi_trndatfr              And 
            tlt.trndat <=  fi_trndatto              AND 
            tlt.genusr   =  "hct"                 And 
            INDEX(tlt.cha_no,trim(fi_search)) <> 0  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  
                Apply "Entry"  to br_tlt.           
                Return no-apply.                    
    END.  
    ELSE If  cb_search  = "�Ţ����ѭ��"  Then do:  /* chassis no */
        Open Query br_tlt                           
            For each tlt Use-index  tlt06 Where     
            tlt.trndat >=  fi_trndatfr              And 
            tlt.trndat <=  fi_trndatto              AND 
            tlt.genusr   =  "hct"                 And 
            INDEX(tlt.comp_noti_ins,trim(fi_search)) <> 0  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  
                Apply "Entry"  to br_tlt.           
                Return no-apply.                    
    END.   
    ELSE If  cb_search  = "�ѹ��������ͧ" Then do:  /* chassis no */
        Open Query br_tlt                           
            For each tlt Use-index  tlt06 Where     
            tlt.trndat    >=  fi_trndatfr       And 
            tlt.trndat    <=  fi_trndatto       AND 
            tlt.genusr     =  "hct"             And 
            tlt.nor_effdat = date(fi_search)    no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .   
                Apply "Entry"  to br_tlt.           
                Return no-apply.                    
    END.  
    ELSE If  cb_search  = "�ѹ����������"  Then do:  /* chassis no */
        Open Query br_tlt                           
            For each tlt Use-index  tlt06 Where     
            tlt.trndat    >=  fi_trndatfr       And 
            tlt.trndat    <=  fi_trndatto       AND 
            tlt.genusr     =  "hct"             And 
            tlt.comp_effdat = date(fi_search)    no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  
                Apply "Entry"  to br_tlt.           
                Return no-apply.                    
    END.
    ELSE If  cb_search  =  "�������駧ҹ"  Then do:          /* cancel */
        Open Query br_tlt 
            For each tlt Use-index  tlt01  Where
            tlt.trndat  >=  fi_trndatfr    And
            tlt.trndat  <=  fi_trndatto    And
            tlt.genusr   =  "hct"        And
            tlt.rec_note2       =  fi_search      no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .     
                Apply "Entry"  to br_tlt.
                Return no-apply.                             
    END. 
    ELSE If  cb_search  =   "Producer"  Then do:          /* cancel */
        Open Query br_tlt 
            For each tlt Use-index  tlt01  Where
            tlt.trndat  >=  fi_trndatfr    And
            tlt.trndat  <=  fi_trndatto    And
            tlt.genusr   =  "hct"        And
            tlt.acno1        =  fi_search      no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .     
                Apply "Entry"  to br_tlt.
                Return no-apply.                             
    END.  
    ELSE If  cb_search  =  "Stickerno"  Then do:          /* cancel */
        Open Query br_tlt 
            For each tlt Use-index  tlt01  Where
            tlt.trndat  >=  fi_trndatfr    And
            tlt.trndat  <=  fi_trndatto    And
            tlt.genusr   =  "hct"        And
            tlt.comp_sck =  fi_search      no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .      
                Apply "Entry"  to br_tlt.
                Return no-apply.                             
    END.
    ELSE If  cb_search  =  "�Ţ����Ѻ��"  Then do:          /* cancel */
        Open Query br_tlt 
            For each tlt Use-index  tlt01  Where
            tlt.trndat  >=  fi_trndatfr    And
            tlt.trndat  <=  fi_trndatto    And
            tlt.genusr   =  "hct"          And
            tlt.comp_pol =  fi_search      no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .      
                Apply "Entry"  to br_tlt.
                Return no-apply.                             
    END.
    Else  do:
        ASSIGN nv_rectlt =  recid(tlt) .           
        Apply "Entry"  to  fi_search.
        Return no-apply.
    END.
     
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_trndatfr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_trndatfr c-wins
ON LEAVE OF fi_trndatfr IN FRAME fr_main
DO:
  fi_trndatfr  =  Input  fi_trndatfr.
  If  fi_trndatto  =  ?  Then  fi_trndatto  =  fi_trndatfr.
  Disp fi_trndatfr  fi_trndatto  with frame fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_trndatto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_trndatto c-wins
ON LEAVE OF fi_trndatto IN FRAME fr_main
DO:
  If  Input  fi_trndatto  <  fi_trndatfr  Then  fi_trndatto  =  fi_trndatfr.
  Else  fi_trndatto =  Input  fi_trndatto  .
  Disp  fi_trndatto  with frame fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_poltype
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_poltype c-wins
ON LEAVE OF ra_poltype IN FRAME fr_main
DO:
    ra_poltype = INPUT ra_poltype.
    DISP ra_poltype WITH FRAM fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_poltype c-wins
ON VALUE-CHANGED OF ra_poltype IN FRAME fr_main
DO:
    ra_poltype = INPUT ra_poltype.
    DISP ra_poltype WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_typedate
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_typedate c-wins
ON LEAVE OF ra_typedate IN FRAME fr_main
DO:
    ra_typedate = INPUT ra_typedate.
    DISP ra_typedate WITH FRAM fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_typedate c-wins
ON VALUE-CHANGED OF ra_typedate IN FRAME fr_main
DO:
  ra_typedate = INPUT ra_typedate.
  DISP ra_typedate WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rs_typre
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rs_typre c-wins
ON VALUE-CHANGED OF rs_typre IN FRAME fr_main
DO:
    ASSIGN rs_typre = INPUT rs_typre .
    DISP rs_typre WITH FRAME fr_main.

   IF rs_typre = 2 THEN do: 
       ASSIGN  fi_outfile    = "" 
               fi_outfileexp = "D:\temp\HCT" + 
                            STRING(YEAR(TODAY),"9999") + 
                            STRING(MONTH(TODAY),"99")  + 
                            STRING(DAY(TODAY),"99")    + 
                            SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                            SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + ".csv"  .
   END.
   ELSE DO:
     ASSIGN 
       fi_outfile = "D:\temp\HCT" + 
                 STRING(YEAR(TODAY),"9999") + 
                 STRING(MONTH(TODAY),"99")  + 
                 STRING(DAY(TODAY),"99")    + 
                 SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                 SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + ".txt"  
       fi_outfileexp = "D:\temp\HCT" + 
                 STRING(YEAR(TODAY),"9999") + 
                 STRING(MONTH(TODAY),"99")  + 
                 STRING(DAY(TODAY),"99")    + 
                 SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                 SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + ".csv"  .
   END.
   DISP fi_outfile fi_outfileexp WITH FRAME fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK c-wins 


/* ***************************  Main Block  *************************** */

/* Set CURRENT-WINDOW: this will parent dialog-boxes and frames.        */
ASSIGN CURRENT-WINDOW                = {&WINDOW-NAME} 
       THIS-PROCEDURE:CURRENT-WINDOW = {&WINDOW-NAME}.

/* The CLOSE event can be used from inside or outside the procedure to  */
/* terminate it.                                                        */
ON CLOSE OF THIS-PROCEDURE 
   RUN disable_UI.

/* Best default for GUI applications is...                              */
PAUSE 0 BEFORE-HIDE.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.
  
  
     /********************  T I T L E   F O R  C - W I N  ****************/
  DEF  VAR  gv_prgid   AS   CHAR.
  DEF  VAR  gv_prog    AS   CHAR.
  gv_prgid = "wgwqhct0".
  gv_prog  = "Query & Update  Detail  (HCT co.,ltd.) ".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).
  ASSIGN 
      fi_trndatfr = TODAY
      fi_trndatto = TODAY
      
      ra_typedate = 1      /*A65-0026*/
     /*ra_choice   =  1 */ /*A55-0184*/
      /*fi_polfr    = "0"
      fi_polto    = "Z" */   
      vAcProc_fil = vAcProc_fil   + "�Ţ��Ƕѧ"      + ","    
                                  + "�����١���"     + ","    
                                  + "�Ţ����ѭ��"    + "," 
                                  + "�ѹ��������ͧ" + "," 
                                  + "�ѹ����������"  + ","
                                  + "�������駧ҹ"  + "," 
                                  + "Producer"       + "," 
                                  + "Stickerno"      + "," 
                                  + "�Ţ����Ѻ��"      + "," 
        cb_search:LIST-ITEMS = vAcProc_fil
        cb_search = ENTRY(1,vAcProc_fil)

        vAcProc_fil1 = vAcProc_fil1 
                                  /*+ "All"        + ","
                                  + "New"        + "," 
                                  + "Renew"      + "," 
                                  + "Switch"     + "," */
                                  + "BR_M"      + "," 
                                  + "BR[No-M]"  + "," 
                                  + "BR_ALL"    + "," 
                                /*  + "Producer"   + "," 
                                  + "Status Yes/No"   + "," */
        cb_report:LIST-ITEMS = vAcProc_fil1
        cb_report = ENTRY(1,vAcProc_fil1)
        
        vAcProc_fil2 = vAcProc_fil2 + "Yes"    + "," 
                                    + "No" + "," 
                                    + "Not re"   + ","  
        cb_reportstatus:LIST-ITEMS = vAcProc_fil2
        cb_reportstatus = ENTRY(1,vAcProc_fil2)
        rs_typre = 2   /* A68-0061 */
        fi_outfile = "" /* A68-0061 */
        ra_poltype = 2 /* A68-0061 */
     /* fi_outfile = "D:\temp\HCT" + 
                    STRING(YEAR(TODAY),"9999") + 
                    STRING(MONTH(TODAY),"99")  + 
                    STRING(DAY(TODAY),"99")    + 
                    SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                    SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + ".txt" */ /* A68-0061 */
      fi_outfileexp = "D:\temp\HCT" + 
                    STRING(YEAR(TODAY),"9999") + 
                    STRING(MONTH(TODAY),"99")  + 
                    STRING(DAY(TODAY),"99")    + 
                    SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                    SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + ".csv" .
  /* add by: kridtiya i. A54-0061.. *//*
  FOR EACH brstat.tlt WHERE 
      brstat.tlt.genusr    = "tisco" AND
      brstat.tlt.rec_addr5 = ""      AND 
      brstat.tlt.ins_name  = "" .
      DELETE brstat.tlt.
  END. */   /* add by: kridtiya i. A54-0061.. */
  Disp fi_trndatfr  fi_trndatto cb_search cb_report cb_reportstatus  fi_outfile 
      ra_typedate  fi_outfileexp   /*A65-0026*/
      rs_typre ra_poltype /* A68-0061*/
      /*fi_polfr 
      fi_polto*/  with frame fr_main.

/*********************************************************************/ 
 /*  RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE). */ 
  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.
  
  
  Rect-333:Move-to-top().
  Rect-338:Move-to-top().  
   
  RECT-381:Move-to-top().
  
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI c-wins  _DEFAULT-DISABLE
PROCEDURE disable_UI :
/*------------------------------------------------------------------------------
  Purpose:     DISABLE the User Interface
  Parameters:  <none>
  Notes:       Here we clean-up the user-interface by deleting
               dynamic widgets we have created and/or hide 
               frames.  This procedure is usually called when
               we are ready to "clean-up" after running.
------------------------------------------------------------------------------*/
  /* Delete the WINDOW we created */
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(c-wins)
  THEN DELETE WIDGET c-wins.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI c-wins  _DEFAULT-ENABLE
PROCEDURE enable_UI :
/*------------------------------------------------------------------------------
  Purpose:     ENABLE the User Interface
  Parameters:  <none>
  Notes:       Here we display/view/enable the widgets in the
               user-interface.  In addition, OPEN all queries
               associated with each FRAME and BROWSE.
               These statements here are based on the "Other 
               Settings" section of the widget Property Sheets.
------------------------------------------------------------------------------*/
  DISPLAY rs_typre ra_poltype ra_typedate fi_trndatfr fi_trndatto cb_search 
          fi_search cb_report fi_outfile fi_name fi_producer fi_outfileexp 
          cb_reportstatus 
      WITH FRAME fr_main IN WINDOW c-wins.
  ENABLE rs_typre ra_poltype ra_typedate fi_trndatfr fi_trndatto bu_ok 
         cb_search bu_oksch br_tlt fi_search cb_report fi_outfile bu_report 
         bu_exit bu_update bu_upyesno bu_match fi_producer fi_outfileexp 
         cb_reportstatus RECT-332 RECT-333 RECT-338 RECT-340 RECT-341 RECT-381 
         RECT-343 RECT-383 
      WITH FRAME fr_main IN WINDOW c-wins.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW c-wins.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_cutproducer c-wins 
PROCEDURE pd_cutproducer :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nvpro AS CHAR INIT  "".
DEF VAR nv_len AS INTE.

FOR EACH wproducer.
        DELETE wproducer.
END.
    
IF  fi_producer <> "" THEN DO:
     
    ASSIGN 
        nvpro = ""
        nvpro = trim(fi_producer).
    
    loop_chk1:
    REPEAT:
        IF INDEX(nvpro,",") <> 0 THEN DO:
            nv_len = LENGTH(nvpro).
            
            CREATE wproducer.
            ASSIGN
                wproducer.producer  = trim(SUBSTRING(nvpro,1,INDEX(nvpro,",") - 1))   
                nvpro = trim(SUBSTRING(nvpro,INDEX(nvpro,",") + 1, nv_len )) .
        END.
        ELSE LEAVE loop_chk1.
    END.
    IF nvpro <> ""  THEN DO:
        CREATE wproducer.
        ASSIGN
            wproducer.producer  = trim(nvpro). 
    END.
END.
    
     
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_data_reportnew c-wins 
PROCEDURE pd_data_reportnew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
   
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_repfielAll1 c-wins 
PROCEDURE pd_repfielAll1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
For each tlt Use-index  tlt06 Where
    tlt.nor_effdat >=  fi_trndatfr    And
    tlt.nor_effdat <=  fi_trndatto    AND 
    tlt.genusr   =  "HCT"        NO-LOCK 
    BREAK BY brstat.tlt.comp_noti_ins :

    IF      nv_typre = "V70" AND brstat.tlt.nor_usr_ins  = "0" THEN NEXT.
    ELSE IF nv_typre = "V72" AND brstat.tlt.nor_usr_ins <> "0" THEN NEXT.
    CREATE  wdetail.
    ASSIGN 
    wdetail.n_text001      =  brstat.tlt.comp_noti_ins  
    wdetail.n_text002      =  brstat.tlt.comp_noti_tlt  
    wdetail.n_text003      =  brstat.tlt.comp_pol       
    wdetail.n_text004      =  string(brstat.tlt.nor_effdat,"99/99/9999")     
    wdetail.n_text005      =  string(brstat.tlt.comp_effdat,"99/99/9999")    
    wdetail.n_text006      =  brstat.tlt.comp_sub       
    wdetail.n_text007      =  brstat.tlt.cifno          
    wdetail.n_text008      =  brstat.tlt.nationality    
    wdetail.n_text009      =  brstat.tlt.nor_noti_ins   
    wdetail.n_text010      =  brstat.tlt.nor_noti_tlt   
    wdetail.n_text011      =  brstat.tlt.nor_usr_ins    
    wdetail.n_text012      =  brstat.tlt.covcod         
    wdetail.n_text013      =  brstat.tlt.nor_usr_tlt    
    wdetail.n_text014      =  brstat.tlt.comp_usr_ins   
    wdetail.n_text015      =  brstat.tlt.ins_title      
    wdetail.n_text016      =  brstat.tlt.ins_name       
    wdetail.n_text017      =  brstat.tlt.ins_firstname  
    wdetail.n_text018      =  brstat.tlt.ins_lastname   
    wdetail.n_text019      =  brstat.tlt.ins_addr       
    wdetail.n_text020      =  brstat.tlt.ins_addr1      
    wdetail.n_text021      =  brstat.tlt.ins_addr2      
    wdetail.n_text022      =  brstat.tlt.ins_addr3      
    wdetail.n_text023      =  brstat.tlt.lince2         
    wdetail.n_text024      =  brstat.tlt.ins_addr5      
    wdetail.n_text025      =  brstat.tlt.dir_occ1       
    wdetail.n_text026      =  brstat.tlt.note28         
    wdetail.n_text027      =  brstat.tlt.dri_ic1        
    wdetail.n_text028      =  brstat.tlt.dri_lic1       
    wdetail.n_text029      =  brstat.tlt.brand          
    wdetail.n_text030      =  substr(brstat.tlt.note10,1,1)         
    wdetail.n_text031      =  substr(brstat.tlt.cha_no,1,25)      
    wdetail.n_text032      =  substr(brstat.tlt.eng_no,1,20)                   
    wdetail.n_text033      =  substr(brstat.tlt.model,1,40)                 
    wdetail.n_text034      =  substr(brstat.tlt.note11,1,4)                  
    wdetail.n_text035      =  substr(brstat.tlt.note12,1,20)                  
    wdetail.n_text036      =  substr(brstat.tlt.note13,1,40)                  
    wdetail.n_text037      =  substr(brstat.tlt.note14,1,1)                   
    /*wdetail.n_text038      =  substr(brstat.tlt.vehuse,1,2) */ /* A68-0061*/
    wdetail.n_text038      =  IF rs_typre = 1 THEN substr(brstat.tlt.vehuse,1,2) ELSE TRIM(brstat.tlt.vehuse)  /* A68-0061*/                   
    wdetail.n_text039      =  string(brstat.tlt.seqno,"99")                        
    wdetail.n_text040      =  string(brstat.tlt.cc_weight,"9999")                  
    wdetail.n_text041      =  substr(brstat.tlt.colorcod,1,40)        
    wdetail.n_text042      =  substr(brstat.tlt.lince1,1,10)        
    wdetail.n_text043      =  substr(brstat.tlt.ins_addr4,1,30)        
    wdetail.n_text044      =  substr(brstat.tlt.note15,1,4)         
    wdetail.n_text045      =  substr(brstat.tlt.note16,1,512)              
    wdetail.n_text046      =  substr(brstat.tlt.note17,1,14)        
    wdetail.n_text047      =  substr(brstat.tlt.note18,1,14)       
    wdetail.n_text048      =  substr(brstat.tlt.note19,1,14)          
    wdetail.n_text049      =  substr(brstat.tlt.note2,1,14)          
    wdetail.n_text050      =  substr(brstat.tlt.note20,1,14)       
    wdetail.n_text051      =  substr(brstat.tlt.note21,1,14)          
    wdetail.n_text052      =  substr(brstat.tlt.note22,1,14)        
    wdetail.n_text053      =  substr(brstat.tlt.note23,1,14)        
    wdetail.n_text054      =  substr(brstat.tlt.comp_sck,1,20)        
    wdetail.n_text055      =  substr(brstat.tlt.note24,1,32)        
    wdetail.n_text056      =  substr(brstat.tlt.dri_no1,1,1)        
    wdetail.n_text057      =  substr(brstat.tlt.dri_no2,1,1)         
    wdetail.n_text058      =  substr(brstat.tlt.note25,1,20)      
    wdetail.n_text059      =  substr(brstat.tlt.dri_name1,1,80)      
    wdetail.n_text060      =  substr(brstat.tlt.note26,1,20)      
    wdetail.n_text061      =  substr(brstat.tlt.note27,1,60)      
    wdetail.n_text062      =  substr(brstat.tlt.dri_occ2,1,50)   
    wdetail.n_text063      =  substr(brstat.tlt.note4,1,10)         
    wdetail.n_text064      =  substr(brstat.tlt.dri_ic2,1,15)         
    wdetail.n_text065      =  substr(brstat.tlt.dri_lic2,1,15)         
    wdetail.n_text066      =  substr(brstat.tlt.note29,1,20)         
    wdetail.n_text067      =  substr(brstat.tlt.dri_name2,1,80)         
    wdetail.n_text068      =  substr(brstat.tlt.note3,1,20)         
    wdetail.n_text069      =  substr(brstat.tlt.note30,1,60)         
    wdetail.n_text070      =  substr(brstat.tlt.ins_occ,1,50)         
    wdetail.n_text071      =  IF brstat.tlt.birthdate = ? THEN "" ELSE string(brstat.tlt.birthdate,"99/99/9999")              
    wdetail.n_text072      =  substr(brstat.tlt.ins_icno,1,15)           
    wdetail.n_text073      =  substr(brstat.tlt.note1,1,15)                   
    wdetail.n_text074      =  substr(brstat.tlt.ben83,1,80)                   
    wdetail.n_text075      =  string(brstat.tlt.comp_coamt,"99999999999.99")      
    wdetail.n_text076      =  string(brstat.tlt.comp_grprm,"99999999999.99")      
    wdetail.n_text077      =  string(brstat.tlt.mileage,"99999999999.99")         
    wdetail.n_text078      =  string(brstat.tlt.ndeci1,"99999999999.99")          
    wdetail.n_text079      =  string(brstat.tlt.ndeci2,"99999999999.99")          
    wdetail.n_text080      =  string(brstat.tlt.ndeci3,"99999999999.99")          
    wdetail.n_text081      =  string(brstat.tlt.ndeci4,"99999999999.99")          
    wdetail.n_text082      =  string(brstat.tlt.ndeci5,"99999999999.99")          
    wdetail.n_text083      =  string(brstat.tlt.nor_coamt,"99")                    
    wdetail.n_text084      =  string(brstat.tlt.nor_grprm,"99999999999.99")       
    wdetail.n_text085      =  string(brstat.tlt.prem_amt,"99999999999.99")        
    wdetail.n_text086      =  string(brstat.tlt.prem_amttcop,"99")                 
    wdetail.n_text087      =  string(brstat.tlt.rstp,"99999999999.99")            
    wdetail.n_text088      =  string(brstat.tlt.rtax,"99999999999.99")            
    wdetail.n_text089      =  string(brstat.tlt.tax_coporate,"99999999999.99")    
    wdetail.n_text090      =  substr(brstat.tlt.note5,1,6)            
    wdetail.n_text091      =  substr(brstat.tlt.note6,1,10)        
    wdetail.n_text092      =  substr(brstat.tlt.note7,1,10)        
    wdetail.n_text093      =  substr(brstat.tlt.note8,1,30)        
    wdetail.n_text094      =  substr(brstat.tlt.note9,1,80)        
    wdetail.n_text095      =  substr(brstat.tlt.noteveh1,1,10)        
    wdetail.n_text096      =  substr(brstat.tlt.noteveh2,1,30)        
    wdetail.n_text097      =  substr(brstat.tlt.old_cha,1,12)        
    wdetail.n_text098      =  substr(brstat.tlt.old_eng,1,3)             
    wdetail.n_text099      =  substr(brstat.tlt.pack,1,10)      
    wdetail.n_text100      =  substr(brstat.tlt.packnme,1,14)      
    wdetail.n_text101      =  substr(brstat.tlt.period,1,10)      
    wdetail.n_text102      =  substr(brstat.tlt.ln_note1,1,14) 
    wdetail.n_text103      =  substr(brstat.tlt.product,1,10)   
    wdetail.n_text104      =  substr(brstat.tlt.projnme,1,14)   
    wdetail.n_text105      =  substr(brstat.tlt.proveh,1,10)   
    wdetail.n_text106      =  substr(brstat.tlt.race,1,14)   
    wdetail.n_text107      =  substr(brstat.tlt.recac,1,10)   
    wdetail.n_text108      =  substr(brstat.tlt.rec_addr,1,14)   
    wdetail.n_text109      =  substr(brstat.tlt.rec_addr1,1,15)   
    wdetail.n_text110      =  substr(brstat.tlt.rec_addr2,1,10)   
    wdetail.n_text111      =  substr(brstat.tlt.rec_addr3,1,14)   
    wdetail.n_text112      =  substr(brstat.tlt.rec_addr4,1,10)   
    wdetail.n_text113      =  substr(brstat.tlt.rec_addr5,1,20)   
    wdetail.n_text114      =  substr(brstat.tlt.rec_brins,1,1)         
    wdetail.n_text115      =  substr(brstat.tlt.rec_cou,1,120)      
    wdetail.n_text116      =  substr(brstat.tlt.rec_icno,1,100)      
    wdetail.n_text117      =  substr(brstat.tlt.rec_name,1,2)         
    wdetail.n_text118      =  substr(brstat.tlt.rec_name2,1,2)         
    wdetail.n_text119      =  substr(brstat.tlt.rec_note1,1,10)        
    wdetail.n_text120      =  substr(brstat.tlt.rec_note2,1,1)        
    wdetail.n_text121      =  substr(brstat.tlt.rec_title,1,10)        
    wdetail.n_text122      =  substr(brstat.tlt.rec_typ,1,255)       
    wdetail.n_text123      =  substr(brstat.tlt.rider,1,5)         
    wdetail.n_text124      =  substr(brstat.tlt.safe1,1,20)        
    wdetail.n_text125      =  substr(brstat.tlt.safe2,1,10)        
    wdetail.n_text126      =  substr(brstat.tlt.safe3,1,150)       
    wdetail.n_text127      =  substr(brstat.tlt.sex,1,15)        
    wdetail.n_text128      =  substr(brstat.tlt.stat,1,250)       
    wdetail.n_text129      =  substr(brstat.tlt.subins,1,13)        
    wdetail.n_text130      =  substr(brstat.tlt.tel,1,10)        
    wdetail.n_text131      =  substr(brstat.tlt.tel2,1,150)      
    wdetail.n_text132      =  substr(brstat.tlt.tel3,1,15)       
    wdetail.n_text133      =  substr(brstat.tlt.usrid,1,250)       
    wdetail.n_text134      =  substr(brstat.tlt.usrsent,1,13)       
    wdetail.n_text135      =  substr(brstat.tlt.ln_product,1,10)     
    wdetail.n_text136      =  substr(brstat.tlt.ln_pronme,1,150)    
    wdetail.n_text137      =  substr(brstat.tlt.ln_rate,1,15)     
    wdetail.n_text138      =  substr(brstat.tlt.ln_st,1,250)    
    wdetail.n_text139      =  substr(brstat.tlt.lotno,1,13)    
    wdetail.n_text140      =  substr(brstat.tlt.maritalsts,1,10)    
    wdetail.n_text141      =  substr(brstat.tlt.campaign,1,12)    
    wdetail.n_text142      =  substr(brstat.tlt.mobile,1,10)  .
     /* ADD BY : A68-0061 */
    ASSIGN 
    wdetail.typepol    =   brstat.tlt.poltyp
    wdetail.typecar    =   brstat.tlt.car_type
    wdetail.maksi      =   STRING(brstat.tlt.maksi)
    wdetail.drivexp1   =   brstat.tlt.dri_licenexp1
    wdetail.drivcon1   =   string(brstat.tlt.dri_consen1)
    wdetail.dlevel1    =   string(brstat.tlt.dri_level1)
    wdetail.dgender1   =   brstat.tlt.dri_gender1
    wdetail.drivexp2   =   brstat.tlt.dri_licenexp2
    wdetail.drivcon2   =   string(brstat.tlt.dri_consen2)
    wdetail.dlevel2    =   string(brstat.tlt.dri_level2)
    wdetail.dgender2   =   brstat.tlt.dri_gender2
    wdetail.ntitle3    =   brstat.tlt.dri_title3
    wdetail.dname3     =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,1,INDEX(brstat.tlt.dri_fname3," ") - 1) ELSE TRIM(brstat.tlt.dri_fname3)
    wdetail.dcname3    =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,R-INDEX(brstat.tlt.dri_fname3," ")) ELSE "" 
    wdetail.dlname3    =   brstat.tlt.dri_lname3
    wdetail.doccup3    =   brstat.tlt.dir_occ3
    wdetail.dbirth3    =   brstat.tlt.dri_birth3
    wdetail.dicno3     =   brstat.tlt.dri_ic3
    wdetail.ddriveno3  =   brstat.tlt.dri_lic3
    wdetail.drivexp3   =   brstat.tlt.dri_licenexp3
    wdetail.drivcon3   =   string(brstat.tlt.dri_consen3)
    wdetail.dlevel3    =   string(brstat.tlt.dri_level3)
    wdetail.dgender3   =   brstat.tlt.dri_gender3
    wdetail.ntitle4    =   brstat.tlt.dri_title4
    wdetail.dname4     =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,1,INDEX(brstat.tlt.dri_fname4," ") - 1) ELSE TRIM(brstat.tlt.dri_fname4)
    wdetail.dcname4    =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,R-INDEX(brstat.tlt.dri_fname4," ")) ELSE ""
    wdetail.dlname4    =   brstat.tlt.dri_lname4
    wdetail.doccup4    =   brstat.tlt.dri_occ4
    wdetail.dbirth4    =   brstat.tlt.dri_birth4
    wdetail.dicno4     =   brstat.tlt.dri_ic4
    wdetail.ddriveno4  =   brstat.tlt.dri_lic4
    wdetail.drivexp4   =   brstat.tlt.dri_licenexp4
    wdetail.drivcon4   =   string(brstat.tlt.dri_consen4)
    wdetail.dlevel4    =   string(brstat.tlt.dri_level4)
    wdetail.dgender4   =   brstat.tlt.dri_gender4
    wdetail.ntitle5    =   brstat.tlt.dri_title5
    wdetail.dname5     =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,1,INDEX(brstat.tlt.dri_fname5," ") - 1) ELSE TRIM(brstat.tlt.dri_fname5)
    wdetail.dcname5    =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,R-INDEX(brstat.tlt.dri_fname5," ")) ELSE "" 
    wdetail.dlname5    =   brstat.tlt.dri_lname5
    wdetail.doccup5    =   brstat.tlt.dri_occ5
    wdetail.dbirth5    =   brstat.tlt.dri_birth5
    wdetail.dicno5     =   brstat.tlt.dri_ic5
    wdetail.ddriveno5  =   brstat.tlt.dri_lic5
    wdetail.drivexp5   =   brstat.tlt.dri_licenexp5
    wdetail.drivcon5   =   string(brstat.tlt.dri_consen5)
    wdetail.dlevel5    =   string(brstat.tlt.dri_level5)
    wdetail.dgender5   =   brstat.tlt.dri_gender5  
    wdetail.chargflg    =  STRING(brstat.tlt.chargflg)
    wdetail.chargprice  =  STRING(brstat.tlt.chargsi)
    wdetail.chargno     =  brstat.tlt.chargno
    wdetail.chargprm    =  string(brstat.tlt.chargprem)
    wdetail.battflg     =  string(brstat.tlt.battflg  )
    wdetail.battprice   =  string(brstat.tlt.battprice)
    wdetail.battno      =  brstat.tlt.battno
    wdetail.battprm     =  string(brstat.tlt.battprem)
    wdetail.battdate    =  string(brstat.tlt.ndate1,"99/99/9999")
    wdetail.net_re1     =  string(brstat.tlt.dg_prem)
    wdetail.stam_re1    =  string(brstat.tlt.dg_rstp_t)
    wdetail.vat_re1     =  string(brstat.tlt.dg_rtax_t)
    wdetail.inscode_re2 =  brstat.tlt.ins_code
    wdetail.net_re2     =  string(brstat.tlt.dg_si  )
    wdetail.stam_re2    =  string(brstat.tlt.dg_rate)
    wdetail.vat_re2     =  string(brstat.tlt.dg_feet)
    wdetail.inscode_re3 =  brstat.tlt.Paycode
    wdetail.net_re3     =  string(brstat.tlt.dg_ncb  )
    wdetail.stam_re3    =  string(brstat.tlt.dg_disc )
    wdetail.vat_re3     =  string(brstat.tlt.dg_wdisc) .
 /* END : A68-0061 */
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_repfielAll2 c-wins 
PROCEDURE pd_repfielAll2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wproducer NO-LOCK.
    For each tlt Use-index  tlt06 Where
        tlt.nor_effdat >=  fi_trndatfr    And
        tlt.nor_effdat <=  fi_trndatto    AND 
        /*tlt.acno1    =  trim(fi_producer)  AND*/
        tlt.acno1      =  wproducer.producer  AND 
        tlt.genusr     =  "HCT"        NO-LOCK 
        BREAK BY brstat.tlt.comp_noti_ins :
        IF      nv_typre = "V70" AND brstat.tlt.nor_usr_ins  = "0" THEN NEXT.
        ELSE IF nv_typre = "V72" AND brstat.tlt.nor_usr_ins <> "0" THEN NEXT.
        CREATE  wdetail.
        ASSIGN 
        wdetail.n_text001      =  brstat.tlt.comp_noti_ins  
        wdetail.n_text002      =  brstat.tlt.comp_noti_tlt  
        wdetail.n_text003      =  brstat.tlt.comp_pol       
        wdetail.n_text004      =  string(brstat.tlt.nor_effdat,"99/99/9999")     
        wdetail.n_text005      =  string(brstat.tlt.comp_effdat,"99/99/9999")    
        wdetail.n_text006      =  brstat.tlt.comp_sub       
        wdetail.n_text007      =  brstat.tlt.cifno          
        wdetail.n_text008      =  brstat.tlt.nationality    
        wdetail.n_text009      =  brstat.tlt.nor_noti_ins   
        wdetail.n_text010      =  brstat.tlt.nor_noti_tlt   
        wdetail.n_text011      =  brstat.tlt.nor_usr_ins    
        wdetail.n_text012      =  brstat.tlt.covcod         
        wdetail.n_text013      =  brstat.tlt.nor_usr_tlt    
        wdetail.n_text014      =  brstat.tlt.comp_usr_ins   
        wdetail.n_text015      =  brstat.tlt.ins_title      
        wdetail.n_text016      =  brstat.tlt.ins_name       
        wdetail.n_text017      =  brstat.tlt.ins_firstname  
        wdetail.n_text018      =  brstat.tlt.ins_lastname   
        wdetail.n_text019      =  brstat.tlt.ins_addr       
        wdetail.n_text020      =  brstat.tlt.ins_addr1      
        wdetail.n_text021      =  brstat.tlt.ins_addr2      
        wdetail.n_text022      =  brstat.tlt.ins_addr3      
        wdetail.n_text023      =  brstat.tlt.lince2         
        wdetail.n_text024      =  brstat.tlt.ins_addr5      
        wdetail.n_text025      =  brstat.tlt.dir_occ1       
        wdetail.n_text026      =  brstat.tlt.note28         
        wdetail.n_text027      =  brstat.tlt.dri_ic1        
        wdetail.n_text028      =  brstat.tlt.dri_lic1       
        wdetail.n_text029      =  brstat.tlt.brand          
        wdetail.n_text030      =  substr(brstat.tlt.note10,1,1)         
        wdetail.n_text031      =  substr(brstat.tlt.cha_no,1,25)      
        wdetail.n_text032      =  substr(brstat.tlt.eng_no,1,20)                   
        wdetail.n_text033      =  substr(brstat.tlt.model,1,40)                 
        wdetail.n_text034      =  substr(brstat.tlt.note11,1,4)                  
        wdetail.n_text035      =  substr(brstat.tlt.note12,1,20)                  
        wdetail.n_text036      =  substr(brstat.tlt.note13,1,40)                  
        wdetail.n_text037      =  substr(brstat.tlt.note14,1,1)                   
        /*wdetail.n_text038      =  substr(brstat.tlt.vehuse,1,2) */ /* A68-0061*/
        wdetail.n_text038      =  IF rs_typre = 1 THEN substr(brstat.tlt.vehuse,1,2) ELSE TRIM(brstat.tlt.vehuse)  /* A68-0061*/                   
        wdetail.n_text039      =  string(brstat.tlt.seqno,"99")                        
        wdetail.n_text040      =  string(brstat.tlt.cc_weight,"9999")                  
        wdetail.n_text041      =  substr(brstat.tlt.colorcod,1,40)        
        wdetail.n_text042      =  substr(brstat.tlt.lince1,1,10)        
        wdetail.n_text043      =  substr(brstat.tlt.ins_addr4,1,30)        
        wdetail.n_text044      =  substr(brstat.tlt.note15,1,4)         
        wdetail.n_text045      =  substr(brstat.tlt.note16,1,512)              
        wdetail.n_text046      =  substr(brstat.tlt.note17,1,14)        
        wdetail.n_text047      =  substr(brstat.tlt.note18,1,14)       
        wdetail.n_text048      =  substr(brstat.tlt.note19,1,14)          
        wdetail.n_text049      =  substr(brstat.tlt.note2,1,14)          
        wdetail.n_text050      =  substr(brstat.tlt.note20,1,14)       
        wdetail.n_text051      =  substr(brstat.tlt.note21,1,14)          
        wdetail.n_text052      =  substr(brstat.tlt.note22,1,14)        
        wdetail.n_text053      =  substr(brstat.tlt.note23,1,14)        
        wdetail.n_text054      =  substr(brstat.tlt.comp_sck,1,20)        
        wdetail.n_text055      =  substr(brstat.tlt.note24,1,32)        
        wdetail.n_text056      =  substr(brstat.tlt.dri_no1,1,1)        
        wdetail.n_text057      =  substr(brstat.tlt.dri_no2,1,1)         
        wdetail.n_text058      =  substr(brstat.tlt.note25,1,20)      
        wdetail.n_text059      =  substr(brstat.tlt.dri_name1,1,80)      
        wdetail.n_text060      =  substr(brstat.tlt.note26,1,20)      
        wdetail.n_text061      =  substr(brstat.tlt.note27,1,60)      
        wdetail.n_text062      =  substr(brstat.tlt.dri_occ2,1,50)   
        wdetail.n_text063      =  substr(brstat.tlt.note4,1,10)         
        wdetail.n_text064      =  substr(brstat.tlt.dri_ic2,1,15)         
        wdetail.n_text065      =  substr(brstat.tlt.dri_lic2,1,15)         
        wdetail.n_text066      =  substr(brstat.tlt.note29,1,20)         
        wdetail.n_text067      =  substr(brstat.tlt.dri_name2,1,80)         
        wdetail.n_text068      =  substr(brstat.tlt.note3,1,20)         
        wdetail.n_text069      =  substr(brstat.tlt.note30,1,60)         
        wdetail.n_text070      =  substr(brstat.tlt.ins_occ,1,50)         
        wdetail.n_text071      =  IF brstat.tlt.birthdate = ? THEN "" ELSE string(brstat.tlt.birthdate,"99/99/9999")              
        wdetail.n_text072      =  substr(brstat.tlt.ins_icno,1,15)           
        wdetail.n_text073      =  substr(brstat.tlt.note1,1,15)                   
        wdetail.n_text074      =  substr(brstat.tlt.ben83,1,80)                   
        wdetail.n_text075      =  string(brstat.tlt.comp_coamt,"99999999999.99")      
        wdetail.n_text076      =  string(brstat.tlt.comp_grprm,"99999999999.99")      
        wdetail.n_text077      =  string(brstat.tlt.mileage,"99999999999.99")         
        wdetail.n_text078      =  string(brstat.tlt.ndeci1,"99999999999.99")          
        wdetail.n_text079      =  string(brstat.tlt.ndeci2,"99999999999.99")          
        wdetail.n_text080      =  string(brstat.tlt.ndeci3,"99999999999.99")          
        wdetail.n_text081      =  string(brstat.tlt.ndeci4,"99999999999.99")          
        wdetail.n_text082      =  string(brstat.tlt.ndeci5,"99999999999.99")          
        wdetail.n_text083      =  string(brstat.tlt.nor_coamt,"99")                    
        wdetail.n_text084      =  string(brstat.tlt.nor_grprm,"99999999999.99")       
        wdetail.n_text085      =  string(brstat.tlt.prem_amt,"99999999999.99")        
        wdetail.n_text086      =  string(brstat.tlt.prem_amttcop,"99")                 
        wdetail.n_text087      =  string(brstat.tlt.rstp,"99999999999.99")            
        wdetail.n_text088      =  string(brstat.tlt.rtax,"99999999999.99")            
        wdetail.n_text089      =  string(brstat.tlt.tax_coporate,"99999999999.99")    
        wdetail.n_text090      =  substr(brstat.tlt.note5,1,6)            
        wdetail.n_text091      =  substr(brstat.tlt.note6,1,10)        
        wdetail.n_text092      =  substr(brstat.tlt.note7,1,10)        
        wdetail.n_text093      =  substr(brstat.tlt.note8,1,30)        
        wdetail.n_text094      =  substr(brstat.tlt.note9,1,80)        
        wdetail.n_text095      =  substr(brstat.tlt.noteveh1,1,10)        
        wdetail.n_text096      =  substr(brstat.tlt.noteveh2,1,30)        
        wdetail.n_text097      =  substr(brstat.tlt.old_cha,1,12)        
        wdetail.n_text098      =  substr(brstat.tlt.old_eng,1,3)             
        wdetail.n_text099      =  substr(brstat.tlt.pack,1,10)      
        wdetail.n_text100      =  substr(brstat.tlt.packnme,1,14)      
        wdetail.n_text101      =  substr(brstat.tlt.period,1,10)      
        wdetail.n_text102      =  substr(brstat.tlt.ln_note1,1,14) 
        wdetail.n_text103      =  substr(brstat.tlt.product,1,10)   
        wdetail.n_text104      =  substr(brstat.tlt.projnme,1,14)   
        wdetail.n_text105      =  substr(brstat.tlt.proveh,1,10)   
        wdetail.n_text106      =  substr(brstat.tlt.race,1,14)   
        wdetail.n_text107      =  substr(brstat.tlt.recac,1,10)   
        wdetail.n_text108      =  substr(brstat.tlt.rec_addr,1,14)   
        wdetail.n_text109      =  substr(brstat.tlt.rec_addr1,1,15)   
        wdetail.n_text110      =  substr(brstat.tlt.rec_addr2,1,10)   
        wdetail.n_text111      =  substr(brstat.tlt.rec_addr3,1,14)   
        wdetail.n_text112      =  substr(brstat.tlt.rec_addr4,1,10)   
        wdetail.n_text113      =  substr(brstat.tlt.rec_addr5,1,20)   
        wdetail.n_text114      =  substr(brstat.tlt.rec_brins,1,1)         
        wdetail.n_text115      =  substr(brstat.tlt.rec_cou,1,120)      
        wdetail.n_text116      =  substr(brstat.tlt.rec_icno,1,100)      
        wdetail.n_text117      =  substr(brstat.tlt.rec_name,1,2)         
        wdetail.n_text118      =  substr(brstat.tlt.rec_name2,1,2)         
        wdetail.n_text119      =  substr(brstat.tlt.rec_note1,1,10)        
        wdetail.n_text120      =  substr(brstat.tlt.rec_note2,1,1)        
        wdetail.n_text121      =  substr(brstat.tlt.rec_title,1,10)        
        wdetail.n_text122      =  substr(brstat.tlt.rec_typ,1,255)       
        wdetail.n_text123      =  substr(brstat.tlt.rider,1,5)         
        wdetail.n_text124      =  substr(brstat.tlt.safe1,1,20)        
        wdetail.n_text125      =  substr(brstat.tlt.safe2,1,10)        
        wdetail.n_text126      =  substr(brstat.tlt.safe3,1,150)       
        wdetail.n_text127      =  substr(brstat.tlt.sex,1,15)        
        wdetail.n_text128      =  substr(brstat.tlt.stat,1,250)       
        wdetail.n_text129      =  substr(brstat.tlt.subins,1,13)        
        wdetail.n_text130      =  substr(brstat.tlt.tel,1,10)        
        wdetail.n_text131      =  substr(brstat.tlt.tel2,1,150)      
        wdetail.n_text132      =  substr(brstat.tlt.tel3,1,15)       
        wdetail.n_text133      =  substr(brstat.tlt.usrid,1,250)       
        wdetail.n_text134      =  substr(brstat.tlt.usrsent,1,13)       
        wdetail.n_text135      =  substr(brstat.tlt.ln_product,1,10)     
        wdetail.n_text136      =  substr(brstat.tlt.ln_pronme,1,150)    
        wdetail.n_text137      =  substr(brstat.tlt.ln_rate,1,15)     
        wdetail.n_text138      =  substr(brstat.tlt.ln_st,1,250)    
        wdetail.n_text139      =  substr(brstat.tlt.lotno,1,13)    
        wdetail.n_text140      =  substr(brstat.tlt.maritalsts,1,10)    
        wdetail.n_text141      =  substr(brstat.tlt.campaign,1,12)    
        wdetail.n_text142      =  substr(brstat.tlt.mobile,1,10)    . 
         /* ADD BY : A68-0061 */
    ASSIGN 
    wdetail.typepol    =   brstat.tlt.poltyp
    wdetail.typecar    =   brstat.tlt.car_type
    wdetail.maksi      =   STRING(brstat.tlt.maksi)
    wdetail.drivexp1   =   brstat.tlt.dri_licenexp1
    wdetail.drivcon1   =   string(brstat.tlt.dri_consen1)
    wdetail.dlevel1    =   string(brstat.tlt.dri_level1)
    wdetail.dgender1   =   brstat.tlt.dri_gender1
    wdetail.drivexp2   =   brstat.tlt.dri_licenexp2
    wdetail.drivcon2   =   string(brstat.tlt.dri_consen2)
    wdetail.dlevel2    =   string(brstat.tlt.dri_level2)
    wdetail.dgender2   =   brstat.tlt.dri_gender2
    wdetail.ntitle3    =   brstat.tlt.dri_title3
    wdetail.dname3     =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,1,INDEX(brstat.tlt.dri_fname3," ") - 1) ELSE TRIM(brstat.tlt.dri_fname3)
    wdetail.dcname3    =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,R-INDEX(brstat.tlt.dri_fname3," ")) ELSE "" 
    wdetail.dlname3    =   brstat.tlt.dri_lname3
    wdetail.doccup3    =   brstat.tlt.dir_occ3
    wdetail.dbirth3    =   brstat.tlt.dri_birth3
    wdetail.dicno3     =   brstat.tlt.dri_ic3
    wdetail.ddriveno3  =   brstat.tlt.dri_lic3
    wdetail.drivexp3   =   brstat.tlt.dri_licenexp3
    wdetail.drivcon3   =   string(brstat.tlt.dri_consen3)
    wdetail.dlevel3    =   string(brstat.tlt.dri_level3)
    wdetail.dgender3   =   brstat.tlt.dri_gender3
    wdetail.ntitle4    =   brstat.tlt.dri_title4
    wdetail.dname4     =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,1,INDEX(brstat.tlt.dri_fname4," ") - 1) ELSE TRIM(brstat.tlt.dri_fname4)
    wdetail.dcname4    =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,R-INDEX(brstat.tlt.dri_fname4," ")) ELSE ""
    wdetail.dlname4    =   brstat.tlt.dri_lname4
    wdetail.doccup4    =   brstat.tlt.dri_occ4
    wdetail.dbirth4    =   brstat.tlt.dri_birth4
    wdetail.dicno4     =   brstat.tlt.dri_ic4
    wdetail.ddriveno4  =   brstat.tlt.dri_lic4
    wdetail.drivexp4   =   brstat.tlt.dri_licenexp4
    wdetail.drivcon4   =   string(brstat.tlt.dri_consen4)
    wdetail.dlevel4    =   string(brstat.tlt.dri_level4)
    wdetail.dgender4   =   brstat.tlt.dri_gender4
    wdetail.ntitle5    =   brstat.tlt.dri_title5
    wdetail.dname5     =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,1,INDEX(brstat.tlt.dri_fname5," ") - 1) ELSE TRIM(brstat.tlt.dri_fname5)
    wdetail.dcname5    =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,R-INDEX(brstat.tlt.dri_fname5," ")) ELSE "" 
    wdetail.dlname5    =   brstat.tlt.dri_lname5
    wdetail.doccup5    =   brstat.tlt.dri_occ5
    wdetail.dbirth5    =   brstat.tlt.dri_birth5
    wdetail.dicno5     =   brstat.tlt.dri_ic5
    wdetail.ddriveno5  =   brstat.tlt.dri_lic5
    wdetail.drivexp5   =   brstat.tlt.dri_licenexp5
    wdetail.drivcon5   =   string(brstat.tlt.dri_consen5)
    wdetail.dlevel5    =   string(brstat.tlt.dri_level5)
    wdetail.dgender5   =   brstat.tlt.dri_gender5  
    wdetail.chargflg    =  STRING(brstat.tlt.chargflg)
    wdetail.chargprice  =  STRING(brstat.tlt.chargsi)
    wdetail.chargno     =  brstat.tlt.chargno
    wdetail.chargprm    =  string(brstat.tlt.chargprem)
    wdetail.battflg     =  string(brstat.tlt.battflg  )
    wdetail.battprice   =  string(brstat.tlt.battprice)
    wdetail.battno      =  brstat.tlt.battno
    wdetail.battprm     =  string(brstat.tlt.battprem)
    wdetail.battdate    =  string(brstat.tlt.ndate1,"99/99/9999")
    wdetail.net_re1     =  string(brstat.tlt.dg_prem)
    wdetail.stam_re1    =  string(brstat.tlt.dg_rstp_t)
    wdetail.vat_re1     =  string(brstat.tlt.dg_rtax_t)
    wdetail.inscode_re2 =  brstat.tlt.ins_code
    wdetail.net_re2     =  string(brstat.tlt.dg_si  )
    wdetail.stam_re2    =  string(brstat.tlt.dg_rate)
    wdetail.vat_re2     =  string(brstat.tlt.dg_feet)
    wdetail.inscode_re3 =  brstat.tlt.Paycode
    wdetail.net_re3     =  string(brstat.tlt.dg_ncb  )
    wdetail.stam_re3    =  string(brstat.tlt.dg_disc )
    wdetail.vat_re3     =  string(brstat.tlt.dg_wdisc) .
 /* END : A68-0061 */
    END.
END. 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_repfielBRALLM1 c-wins 
PROCEDURE pd_repfielBRALLM1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    For each tlt Use-index  tlt06 Where
        tlt.nor_effdat >=  fi_trndatfr    And
        tlt.nor_effdat <=  fi_trndatto    AND 
        tlt.genusr      =  "HCT"          NO-LOCK   
        BREAK BY brstat.tlt.comp_noti_ins :

        IF      nv_typre = "V70" AND brstat.tlt.nor_usr_ins  = "0" THEN NEXT.
        ELSE IF nv_typre = "V72" AND brstat.tlt.nor_usr_ins <> "0" THEN NEXT.
        IF brstat.tlt.releas <> cb_reportstatus  THEN NEXT.
        CREATE  wdetail.
        ASSIGN 
        wdetail.n_text001      =  brstat.tlt.comp_noti_ins  
        wdetail.n_text002      =  brstat.tlt.comp_noti_tlt  
        wdetail.n_text003      =  brstat.tlt.comp_pol       
        wdetail.n_text004      =  string(brstat.tlt.nor_effdat,"99/99/9999")     
        wdetail.n_text005      =  string(brstat.tlt.comp_effdat,"99/99/9999")    
        wdetail.n_text006      =  brstat.tlt.comp_sub       
        wdetail.n_text007      =  brstat.tlt.cifno          
        wdetail.n_text008      =  brstat.tlt.nationality    
        wdetail.n_text009      =  brstat.tlt.nor_noti_ins   
        wdetail.n_text010      =  brstat.tlt.nor_noti_tlt   
        wdetail.n_text011      =  brstat.tlt.nor_usr_ins    
        wdetail.n_text012      =  brstat.tlt.covcod         
        wdetail.n_text013      =  brstat.tlt.nor_usr_tlt    
        wdetail.n_text014      =  brstat.tlt.comp_usr_ins   
        wdetail.n_text015      =  brstat.tlt.ins_title      
        wdetail.n_text016      =  brstat.tlt.ins_name       
        wdetail.n_text017      =  brstat.tlt.ins_firstname  
        wdetail.n_text018      =  brstat.tlt.ins_lastname   
        wdetail.n_text019      =  brstat.tlt.ins_addr       
        wdetail.n_text020      =  brstat.tlt.ins_addr1      
        wdetail.n_text021      =  brstat.tlt.ins_addr2      
        wdetail.n_text022      =  brstat.tlt.ins_addr3      
        wdetail.n_text023      =  brstat.tlt.lince2         
        wdetail.n_text024      =  brstat.tlt.ins_addr5      
        wdetail.n_text025      =  brstat.tlt.dir_occ1       
        wdetail.n_text026      =  brstat.tlt.note28         
        wdetail.n_text027      =  brstat.tlt.dri_ic1        
        wdetail.n_text028      =  brstat.tlt.dri_lic1       
        wdetail.n_text029      =  brstat.tlt.brand          
        wdetail.n_text030      =  substr(brstat.tlt.note10,1,1)         
        wdetail.n_text031      =  substr(brstat.tlt.cha_no,1,25)      
        wdetail.n_text032      =  substr(brstat.tlt.eng_no,1,20)                   
        wdetail.n_text033      =  substr(brstat.tlt.model,1,40)                 
        wdetail.n_text034      =  substr(brstat.tlt.note11,1,4)                  
        wdetail.n_text035      =  substr(brstat.tlt.note12,1,20)                  
        wdetail.n_text036      =  substr(brstat.tlt.note13,1,40)                  
        wdetail.n_text037      =  substr(brstat.tlt.note14,1,1)                   
        /*wdetail.n_text038      =  substr(brstat.tlt.vehuse,1,2) */ /* A68-0061*/
        wdetail.n_text038      =  IF rs_typre = 1 THEN substr(brstat.tlt.vehuse,1,2) ELSE TRIM(brstat.tlt.vehuse)  /* A68-0061*/                  
        wdetail.n_text039      =  string(brstat.tlt.seqno,"99")                        
        wdetail.n_text040      =  string(brstat.tlt.cc_weight,"9999")                  
        wdetail.n_text041      =  substr(brstat.tlt.colorcod,1,40)        
        wdetail.n_text042      =  substr(brstat.tlt.lince1,1,10)        
        wdetail.n_text043      =  substr(brstat.tlt.ins_addr4,1,30)        
        wdetail.n_text044      =  substr(brstat.tlt.note15,1,4)         
        wdetail.n_text045      =  substr(brstat.tlt.note16,1,512)              
        wdetail.n_text046      =  substr(brstat.tlt.note17,1,14)        
        wdetail.n_text047      =  substr(brstat.tlt.note18,1,14)       
        wdetail.n_text048      =  substr(brstat.tlt.note19,1,14)          
        wdetail.n_text049      =  substr(brstat.tlt.note2,1,14)          
        wdetail.n_text050      =  substr(brstat.tlt.note20,1,14)       
        wdetail.n_text051      =  substr(brstat.tlt.note21,1,14)          
        wdetail.n_text052      =  substr(brstat.tlt.note22,1,14)        
        wdetail.n_text053      =  substr(brstat.tlt.note23,1,14)        
        wdetail.n_text054      =  substr(brstat.tlt.comp_sck,1,20)        
        wdetail.n_text055      =  substr(brstat.tlt.note24,1,32)        
        wdetail.n_text056      =  substr(brstat.tlt.dri_no1,1,1)        
        wdetail.n_text057      =  substr(brstat.tlt.dri_no2,1,1)         
        wdetail.n_text058      =  substr(brstat.tlt.note25,1,20)      
        wdetail.n_text059      =  substr(brstat.tlt.dri_name1,1,80)      
        wdetail.n_text060      =  substr(brstat.tlt.note26,1,20)      
        wdetail.n_text061      =  substr(brstat.tlt.note27,1,60)      
        wdetail.n_text062      =  substr(brstat.tlt.dri_occ2,1,50)   
        wdetail.n_text063      =  substr(brstat.tlt.note4,1,10)         
        wdetail.n_text064      =  substr(brstat.tlt.dri_ic2,1,15)         
        wdetail.n_text065      =  substr(brstat.tlt.dri_lic2,1,15)         
        wdetail.n_text066      =  substr(brstat.tlt.note29,1,20)         
        wdetail.n_text067      =  substr(brstat.tlt.dri_name2,1,80)         
        wdetail.n_text068      =  substr(brstat.tlt.note3,1,20)         
        wdetail.n_text069      =  substr(brstat.tlt.note30,1,60)         
        wdetail.n_text070      =  substr(brstat.tlt.ins_occ,1,50)         
        wdetail.n_text071      =  IF brstat.tlt.birthdate = ? THEN "" ELSE string(brstat.tlt.birthdate,"99/99/9999")              
        wdetail.n_text072      =  substr(brstat.tlt.ins_icno,1,15)           
        wdetail.n_text073      =  substr(brstat.tlt.note1,1,15)                   
        wdetail.n_text074      =  substr(brstat.tlt.ben83,1,80)                   
        wdetail.n_text075      =  string(brstat.tlt.comp_coamt,"99999999999.99")      
        wdetail.n_text076      =  string(brstat.tlt.comp_grprm,"99999999999.99")      
        wdetail.n_text077      =  string(brstat.tlt.mileage,"99999999999.99")         
        wdetail.n_text078      =  string(brstat.tlt.ndeci1,"99999999999.99")          
        wdetail.n_text079      =  string(brstat.tlt.ndeci2,"99999999999.99")          
        wdetail.n_text080      =  string(brstat.tlt.ndeci3,"99999999999.99")          
        wdetail.n_text081      =  string(brstat.tlt.ndeci4,"99999999999.99")          
        wdetail.n_text082      =  string(brstat.tlt.ndeci5,"99999999999.99")          
        wdetail.n_text083      =  string(brstat.tlt.nor_coamt,"99")                    
        wdetail.n_text084      =  string(brstat.tlt.nor_grprm,"99999999999.99")       
        wdetail.n_text085      =  string(brstat.tlt.prem_amt,"99999999999.99")        
        wdetail.n_text086      =  string(brstat.tlt.prem_amttcop,"99")                 
        wdetail.n_text087      =  string(brstat.tlt.rstp,"99999999999.99")            
        wdetail.n_text088      =  string(brstat.tlt.rtax,"99999999999.99")            
        wdetail.n_text089      =  string(brstat.tlt.tax_coporate,"99999999999.99")    
        wdetail.n_text090      =  substr(brstat.tlt.note5,1,6)            
        wdetail.n_text091      =  substr(brstat.tlt.note6,1,10)        
        wdetail.n_text092      =  substr(brstat.tlt.note7,1,10)        
        wdetail.n_text093      =  substr(brstat.tlt.note8,1,30)        
        wdetail.n_text094      =  substr(brstat.tlt.note9,1,80)        
        wdetail.n_text095      =  substr(brstat.tlt.noteveh1,1,10)        
        wdetail.n_text096      =  substr(brstat.tlt.noteveh2,1,30)        
        wdetail.n_text097      =  substr(brstat.tlt.old_cha,1,12)        
        wdetail.n_text098      =  substr(brstat.tlt.old_eng,1,3)             
        wdetail.n_text099      =  substr(brstat.tlt.pack,1,10)      
        wdetail.n_text100      =  substr(brstat.tlt.packnme,1,14)      
        wdetail.n_text101      =  substr(brstat.tlt.period,1,10)      
        wdetail.n_text102      =  substr(brstat.tlt.ln_note1,1,14) 
        wdetail.n_text103      =  substr(brstat.tlt.product,1,10)   
        wdetail.n_text104      =  substr(brstat.tlt.projnme,1,14)   
        wdetail.n_text105      =  substr(brstat.tlt.proveh,1,10)   
        wdetail.n_text106      =  substr(brstat.tlt.race,1,14)   
        wdetail.n_text107      =  substr(brstat.tlt.recac,1,10)   
        wdetail.n_text108      =  substr(brstat.tlt.rec_addr,1,14)   
        wdetail.n_text109      =  substr(brstat.tlt.rec_addr1,1,15)   
        wdetail.n_text110      =  substr(brstat.tlt.rec_addr2,1,10)   
        wdetail.n_text111      =  substr(brstat.tlt.rec_addr3,1,14)   
        wdetail.n_text112      =  substr(brstat.tlt.rec_addr4,1,10)   
        wdetail.n_text113      =  substr(brstat.tlt.rec_addr5,1,20)   
        wdetail.n_text114      =  substr(brstat.tlt.rec_brins,1,1)         
        wdetail.n_text115      =  substr(brstat.tlt.rec_cou,1,120)      
        wdetail.n_text116      =  substr(brstat.tlt.rec_icno,1,100)      
        wdetail.n_text117      =  substr(brstat.tlt.rec_name,1,2)         
        wdetail.n_text118      =  substr(brstat.tlt.rec_name2,1,2)         
        wdetail.n_text119      =  substr(brstat.tlt.rec_note1,1,10)        
        wdetail.n_text120      =  substr(brstat.tlt.rec_note2,1,1)        
        wdetail.n_text121      =  substr(brstat.tlt.rec_title,1,10)        
        wdetail.n_text122      =  substr(brstat.tlt.rec_typ,1,255)       
        wdetail.n_text123      =  substr(brstat.tlt.rider,1,5)         
        wdetail.n_text124      =  substr(brstat.tlt.safe1,1,20)        
        wdetail.n_text125      =  substr(brstat.tlt.safe2,1,10)        
        wdetail.n_text126      =  substr(brstat.tlt.safe3,1,150)       
        wdetail.n_text127      =  substr(brstat.tlt.sex,1,15)        
        wdetail.n_text128      =  substr(brstat.tlt.stat,1,250)       
        wdetail.n_text129      =  substr(brstat.tlt.subins,1,13)        
        wdetail.n_text130      =  substr(brstat.tlt.tel,1,10)        
        wdetail.n_text131      =  substr(brstat.tlt.tel2,1,150)      
        wdetail.n_text132      =  substr(brstat.tlt.tel3,1,15)       
        wdetail.n_text133      =  substr(brstat.tlt.usrid,1,250)       
        wdetail.n_text134      =  substr(brstat.tlt.usrsent,1,13)       
        wdetail.n_text135      =  substr(brstat.tlt.ln_product,1,10)     
        wdetail.n_text136      =  substr(brstat.tlt.ln_pronme,1,150)    
        wdetail.n_text137      =  substr(brstat.tlt.ln_rate,1,15)     
        wdetail.n_text138      =  substr(brstat.tlt.ln_st,1,250)    
        wdetail.n_text139      =  substr(brstat.tlt.lotno,1,13)    
        wdetail.n_text140      =  substr(brstat.tlt.maritalsts,1,10)    
        wdetail.n_text141      =  substr(brstat.tlt.campaign,1,12)    
        wdetail.n_text142      =  substr(brstat.tlt.mobile,1,10)    . 
         /* ADD BY : A68-0061 */
    ASSIGN 
    wdetail.typepol    =   brstat.tlt.poltyp
    wdetail.typecar    =   brstat.tlt.car_type
    wdetail.maksi      =   STRING(brstat.tlt.maksi)
    wdetail.drivexp1   =   brstat.tlt.dri_licenexp1
    wdetail.drivcon1   =   string(brstat.tlt.dri_consen1)
    wdetail.dlevel1    =   string(brstat.tlt.dri_level1)
    wdetail.dgender1   =   brstat.tlt.dri_gender1
    wdetail.drivexp2   =   brstat.tlt.dri_licenexp2
    wdetail.drivcon2   =   string(brstat.tlt.dri_consen2)
    wdetail.dlevel2    =   string(brstat.tlt.dri_level2)
    wdetail.dgender2   =   brstat.tlt.dri_gender2
    wdetail.ntitle3    =   brstat.tlt.dri_title3
    wdetail.dname3     =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,1,INDEX(brstat.tlt.dri_fname3," ") - 1) ELSE TRIM(brstat.tlt.dri_fname3)
    wdetail.dcname3    =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,R-INDEX(brstat.tlt.dri_fname3," ")) ELSE "" 
    wdetail.dlname3    =   brstat.tlt.dri_lname3
    wdetail.doccup3    =   brstat.tlt.dir_occ3
    wdetail.dbirth3    =   brstat.tlt.dri_birth3
    wdetail.dicno3     =   brstat.tlt.dri_ic3
    wdetail.ddriveno3  =   brstat.tlt.dri_lic3
    wdetail.drivexp3   =   brstat.tlt.dri_licenexp3
    wdetail.drivcon3   =   string(brstat.tlt.dri_consen3)
    wdetail.dlevel3    =   string(brstat.tlt.dri_level3)
    wdetail.dgender3   =   brstat.tlt.dri_gender3
    wdetail.ntitle4    =   brstat.tlt.dri_title4
    wdetail.dname4     =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,1,INDEX(brstat.tlt.dri_fname4," ") - 1) ELSE TRIM(brstat.tlt.dri_fname4)
    wdetail.dcname4    =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,R-INDEX(brstat.tlt.dri_fname4," ")) ELSE ""
    wdetail.dlname4    =   brstat.tlt.dri_lname4
    wdetail.doccup4    =   brstat.tlt.dri_occ4
    wdetail.dbirth4    =   brstat.tlt.dri_birth4
    wdetail.dicno4     =   brstat.tlt.dri_ic4
    wdetail.ddriveno4  =   brstat.tlt.dri_lic4
    wdetail.drivexp4   =   brstat.tlt.dri_licenexp4
    wdetail.drivcon4   =   string(brstat.tlt.dri_consen4)
    wdetail.dlevel4    =   string(brstat.tlt.dri_level4)
    wdetail.dgender4   =   brstat.tlt.dri_gender4
    wdetail.ntitle5    =   brstat.tlt.dri_title5
    wdetail.dname5     =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,1,INDEX(brstat.tlt.dri_fname5," ") - 1) ELSE TRIM(brstat.tlt.dri_fname5)
    wdetail.dcname5    =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,R-INDEX(brstat.tlt.dri_fname5," ")) ELSE "" 
    wdetail.dlname5    =   brstat.tlt.dri_lname5
    wdetail.doccup5    =   brstat.tlt.dri_occ5
    wdetail.dbirth5    =   brstat.tlt.dri_birth5
    wdetail.dicno5     =   brstat.tlt.dri_ic5
    wdetail.ddriveno5  =   brstat.tlt.dri_lic5
    wdetail.drivexp5   =   brstat.tlt.dri_licenexp5
    wdetail.drivcon5   =   string(brstat.tlt.dri_consen5)
    wdetail.dlevel5    =   string(brstat.tlt.dri_level5)
    wdetail.dgender5   =   brstat.tlt.dri_gender5  
    wdetail.chargflg    =  STRING(brstat.tlt.chargflg)
    wdetail.chargprice  =  STRING(brstat.tlt.chargsi)
    wdetail.chargno     =  brstat.tlt.chargno
    wdetail.chargprm    =  string(brstat.tlt.chargprem)
    wdetail.battflg     =  string(brstat.tlt.battflg  )
    wdetail.battprice   =  string(brstat.tlt.battprice)
    wdetail.battno      =  brstat.tlt.battno
    wdetail.battprm     =  string(brstat.tlt.battprem)
    wdetail.battdate    =  string(brstat.tlt.ndate1,"99/99/9999")
    wdetail.net_re1     =  string(brstat.tlt.dg_prem)
    wdetail.stam_re1    =  string(brstat.tlt.dg_rstp_t)
    wdetail.vat_re1     =  string(brstat.tlt.dg_rtax_t)
    wdetail.inscode_re2 =  brstat.tlt.ins_code
    wdetail.net_re2     =  string(brstat.tlt.dg_si  )
    wdetail.stam_re2    =  string(brstat.tlt.dg_rate)
    wdetail.vat_re2     =  string(brstat.tlt.dg_feet)
    wdetail.inscode_re3 =  brstat.tlt.Paycode
    wdetail.net_re3     =  string(brstat.tlt.dg_ncb  )
    wdetail.stam_re3    =  string(brstat.tlt.dg_disc )
    wdetail.vat_re3     =  string(brstat.tlt.dg_wdisc) .
 /* END : A68-0061 */
    END.  /* tlt */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_repfielBRALLM2 c-wins 
PROCEDURE pd_repfielBRALLM2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

FOR EACH wproducer NO-LOCK.
    For each tlt Use-index  tlt06 Where
        tlt.nor_effdat >=  fi_trndatfr    And
        tlt.nor_effdat <=  fi_trndatto    AND 
        /*tlt.acno1    =  trim(fi_producer)  AND*/
        tlt.acno1      =  wproducer.producer  AND 
        tlt.genusr     =  "HCT"            NO-LOCK
        BREAK BY brstat.tlt.comp_noti_ins :
        IF      nv_typre = "V70" AND brstat.tlt.nor_usr_ins  = "0" THEN NEXT.
        ELSE IF nv_typre = "V72" AND brstat.tlt.nor_usr_ins <> "0" THEN NEXT.
        IF brstat.tlt.releas <> cb_reportstatus  THEN NEXT.
        CREATE  wdetail.
        ASSIGN 
        wdetail.n_text001      =  brstat.tlt.comp_noti_ins  
        wdetail.n_text002      =  brstat.tlt.comp_noti_tlt  
        wdetail.n_text003      =  brstat.tlt.comp_pol       
        wdetail.n_text004      =  string(brstat.tlt.nor_effdat,"99/99/9999")     
        wdetail.n_text005      =  string(brstat.tlt.comp_effdat,"99/99/9999")    
        wdetail.n_text006      =  brstat.tlt.comp_sub       
        wdetail.n_text007      =  brstat.tlt.cifno          
        wdetail.n_text008      =  brstat.tlt.nationality    
        wdetail.n_text009      =  brstat.tlt.nor_noti_ins   
        wdetail.n_text010      =  brstat.tlt.nor_noti_tlt   
        wdetail.n_text011      =  brstat.tlt.nor_usr_ins    
        wdetail.n_text012      =  brstat.tlt.covcod         
        wdetail.n_text013      =  brstat.tlt.nor_usr_tlt    
        wdetail.n_text014      =  brstat.tlt.comp_usr_ins   
        wdetail.n_text015      =  brstat.tlt.ins_title      
        wdetail.n_text016      =  brstat.tlt.ins_name       
        wdetail.n_text017      =  brstat.tlt.ins_firstname  
        wdetail.n_text018      =  brstat.tlt.ins_lastname   
        wdetail.n_text019      =  brstat.tlt.ins_addr       
        wdetail.n_text020      =  brstat.tlt.ins_addr1      
        wdetail.n_text021      =  brstat.tlt.ins_addr2      
        wdetail.n_text022      =  brstat.tlt.ins_addr3      
        wdetail.n_text023      =  brstat.tlt.lince2         
        wdetail.n_text024      =  brstat.tlt.ins_addr5      
        wdetail.n_text025      =  brstat.tlt.dir_occ1       
        wdetail.n_text026      =  brstat.tlt.note28         
        wdetail.n_text027      =  brstat.tlt.dri_ic1        
        wdetail.n_text028      =  brstat.tlt.dri_lic1       
        wdetail.n_text029      =  brstat.tlt.brand          
        wdetail.n_text030      =  substr(brstat.tlt.note10,1,1)         
        wdetail.n_text031      =  substr(brstat.tlt.cha_no,1,25)      
        wdetail.n_text032      =  substr(brstat.tlt.eng_no,1,20)                   
        wdetail.n_text033      =  substr(brstat.tlt.model,1,40)                 
        wdetail.n_text034      =  substr(brstat.tlt.note11,1,4)                  
        wdetail.n_text035      =  substr(brstat.tlt.note12,1,20)                  
        wdetail.n_text036      =  substr(brstat.tlt.note13,1,40)                  
        wdetail.n_text037      =  substr(brstat.tlt.note14,1,1)                   
        /*wdetail.n_text038      =  substr(brstat.tlt.vehuse,1,2) */ /* A68-0061*/
        wdetail.n_text038      =  IF rs_typre = 1 THEN substr(brstat.tlt.vehuse,1,2) ELSE TRIM(brstat.tlt.vehuse)  /* A68-0061*/                   
        wdetail.n_text039      =  string(brstat.tlt.seqno,"99")                        
        wdetail.n_text040      =  string(brstat.tlt.cc_weight,"9999")                  
        wdetail.n_text041      =  substr(brstat.tlt.colorcod,1,40)        
        wdetail.n_text042      =  substr(brstat.tlt.lince1,1,10)        
        wdetail.n_text043      =  substr(brstat.tlt.ins_addr4,1,30)        
        wdetail.n_text044      =  substr(brstat.tlt.note15,1,4)         
        wdetail.n_text045      =  substr(brstat.tlt.note16,1,512)              
        wdetail.n_text046      =  substr(brstat.tlt.note17,1,14)        
        wdetail.n_text047      =  substr(brstat.tlt.note18,1,14)       
        wdetail.n_text048      =  substr(brstat.tlt.note19,1,14)          
        wdetail.n_text049      =  substr(brstat.tlt.note2,1,14)          
        wdetail.n_text050      =  substr(brstat.tlt.note20,1,14)       
        wdetail.n_text051      =  substr(brstat.tlt.note21,1,14)          
        wdetail.n_text052      =  substr(brstat.tlt.note22,1,14)        
        wdetail.n_text053      =  substr(brstat.tlt.note23,1,14)        
        wdetail.n_text054      =  substr(brstat.tlt.comp_sck,1,20)        
        wdetail.n_text055      =  substr(brstat.tlt.note24,1,32)        
        wdetail.n_text056      =  substr(brstat.tlt.dri_no1,1,1)        
        wdetail.n_text057      =  substr(brstat.tlt.dri_no2,1,1)         
        wdetail.n_text058      =  substr(brstat.tlt.note25,1,20)      
        wdetail.n_text059      =  substr(brstat.tlt.dri_name1,1,80)      
        wdetail.n_text060      =  substr(brstat.tlt.note26,1,20)      
        wdetail.n_text061      =  substr(brstat.tlt.note27,1,60)      
        wdetail.n_text062      =  substr(brstat.tlt.dri_occ2,1,50)   
        wdetail.n_text063      =  substr(brstat.tlt.note4,1,10)         
        wdetail.n_text064      =  substr(brstat.tlt.dri_ic2,1,15)         
        wdetail.n_text065      =  substr(brstat.tlt.dri_lic2,1,15)         
        wdetail.n_text066      =  substr(brstat.tlt.note29,1,20)         
        wdetail.n_text067      =  substr(brstat.tlt.dri_name2,1,80)         
        wdetail.n_text068      =  substr(brstat.tlt.note3,1,20)         
        wdetail.n_text069      =  substr(brstat.tlt.note30,1,60)         
        wdetail.n_text070      =  substr(brstat.tlt.ins_occ,1,50)         
        wdetail.n_text071      =  IF brstat.tlt.birthdate = ? THEN "" ELSE string(brstat.tlt.birthdate,"99/99/9999")              
        wdetail.n_text072      =  substr(brstat.tlt.ins_icno,1,15)           
        wdetail.n_text073      =  substr(brstat.tlt.note1,1,15)                   
        wdetail.n_text074      =  substr(brstat.tlt.ben83,1,80)                   
        wdetail.n_text075      =  string(brstat.tlt.comp_coamt,"99999999999.99")      
        wdetail.n_text076      =  string(brstat.tlt.comp_grprm,"99999999999.99")      
        wdetail.n_text077      =  string(brstat.tlt.mileage,"99999999999.99")         
        wdetail.n_text078      =  string(brstat.tlt.ndeci1,"99999999999.99")          
        wdetail.n_text079      =  string(brstat.tlt.ndeci2,"99999999999.99")          
        wdetail.n_text080      =  string(brstat.tlt.ndeci3,"99999999999.99")          
        wdetail.n_text081      =  string(brstat.tlt.ndeci4,"99999999999.99")          
        wdetail.n_text082      =  string(brstat.tlt.ndeci5,"99999999999.99")          
        wdetail.n_text083      =  string(brstat.tlt.nor_coamt,"99")                    
        wdetail.n_text084      =  string(brstat.tlt.nor_grprm,"99999999999.99")       
        wdetail.n_text085      =  string(brstat.tlt.prem_amt,"99999999999.99")        
        wdetail.n_text086      =  string(brstat.tlt.prem_amttcop,"99")                 
        wdetail.n_text087      =  string(brstat.tlt.rstp,"99999999999.99")            
        wdetail.n_text088      =  string(brstat.tlt.rtax,"99999999999.99")            
        wdetail.n_text089      =  string(brstat.tlt.tax_coporate,"99999999999.99")    
        wdetail.n_text090      =  substr(brstat.tlt.note5,1,6)            
        wdetail.n_text091      =  substr(brstat.tlt.note6,1,10)        
        wdetail.n_text092      =  substr(brstat.tlt.note7,1,10)        
        wdetail.n_text093      =  substr(brstat.tlt.note8,1,30)        
        wdetail.n_text094      =  substr(brstat.tlt.note9,1,80)        
        wdetail.n_text095      =  substr(brstat.tlt.noteveh1,1,10)        
        wdetail.n_text096      =  substr(brstat.tlt.noteveh2,1,30)        
        wdetail.n_text097      =  substr(brstat.tlt.old_cha,1,12)        
        wdetail.n_text098      =  substr(brstat.tlt.old_eng,1,3)             
        wdetail.n_text099      =  substr(brstat.tlt.pack,1,10)      
        wdetail.n_text100      =  substr(brstat.tlt.packnme,1,14)      
        wdetail.n_text101      =  substr(brstat.tlt.period,1,10)      
        wdetail.n_text102      =  substr(brstat.tlt.ln_note1,1,14) 
        wdetail.n_text103      =  substr(brstat.tlt.product,1,10)   
        wdetail.n_text104      =  substr(brstat.tlt.projnme,1,14)   
        wdetail.n_text105      =  substr(brstat.tlt.proveh,1,10)   
        wdetail.n_text106      =  substr(brstat.tlt.race,1,14)   
        wdetail.n_text107      =  substr(brstat.tlt.recac,1,10)   
        wdetail.n_text108      =  substr(brstat.tlt.rec_addr,1,14)   
        wdetail.n_text109      =  substr(brstat.tlt.rec_addr1,1,15)   
        wdetail.n_text110      =  substr(brstat.tlt.rec_addr2,1,10)   
        wdetail.n_text111      =  substr(brstat.tlt.rec_addr3,1,14)   
        wdetail.n_text112      =  substr(brstat.tlt.rec_addr4,1,10)   
        wdetail.n_text113      =  substr(brstat.tlt.rec_addr5,1,20)   
        wdetail.n_text114      =  substr(brstat.tlt.rec_brins,1,1)         
        wdetail.n_text115      =  substr(brstat.tlt.rec_cou,1,120)      
        wdetail.n_text116      =  substr(brstat.tlt.rec_icno,1,100)      
        wdetail.n_text117      =  substr(brstat.tlt.rec_name,1,2)         
        wdetail.n_text118      =  substr(brstat.tlt.rec_name2,1,2)         
        wdetail.n_text119      =  substr(brstat.tlt.rec_note1,1,10)        
        wdetail.n_text120      =  substr(brstat.tlt.rec_note2,1,1)        
        wdetail.n_text121      =  substr(brstat.tlt.rec_title,1,10)        
        wdetail.n_text122      =  substr(brstat.tlt.rec_typ,1,255)       
        wdetail.n_text123      =  substr(brstat.tlt.rider,1,5)         
        wdetail.n_text124      =  substr(brstat.tlt.safe1,1,20)        
        wdetail.n_text125      =  substr(brstat.tlt.safe2,1,10)        
        wdetail.n_text126      =  substr(brstat.tlt.safe3,1,150)       
        wdetail.n_text127      =  substr(brstat.tlt.sex,1,15)        
        wdetail.n_text128      =  substr(brstat.tlt.stat,1,250)       
        wdetail.n_text129      =  substr(brstat.tlt.subins,1,13)        
        wdetail.n_text130      =  substr(brstat.tlt.tel,1,10)        
        wdetail.n_text131      =  substr(brstat.tlt.tel2,1,150)      
        wdetail.n_text132      =  substr(brstat.tlt.tel3,1,15)       
        wdetail.n_text133      =  substr(brstat.tlt.usrid,1,250)       
        wdetail.n_text134      =  substr(brstat.tlt.usrsent,1,13)       
        wdetail.n_text135      =  substr(brstat.tlt.ln_product,1,10)     
        wdetail.n_text136      =  substr(brstat.tlt.ln_pronme,1,150)    
        wdetail.n_text137      =  substr(brstat.tlt.ln_rate,1,15)     
        wdetail.n_text138      =  substr(brstat.tlt.ln_st,1,250)    
        wdetail.n_text139      =  substr(brstat.tlt.lotno,1,13)    
        wdetail.n_text140      =  substr(brstat.tlt.maritalsts,1,10)    
        wdetail.n_text141      =  substr(brstat.tlt.campaign,1,12)    
        wdetail.n_text142      =  substr(brstat.tlt.mobile,1,10)    .  
         /* ADD BY : A68-0061 */
    ASSIGN 
    wdetail.typepol    =   brstat.tlt.poltyp
    wdetail.typecar    =   brstat.tlt.car_type
    wdetail.maksi      =   STRING(brstat.tlt.maksi)
    wdetail.drivexp1   =   brstat.tlt.dri_licenexp1
    wdetail.drivcon1   =   string(brstat.tlt.dri_consen1)
    wdetail.dlevel1    =   string(brstat.tlt.dri_level1)
    wdetail.dgender1   =   brstat.tlt.dri_gender1
    wdetail.drivexp2   =   brstat.tlt.dri_licenexp2
    wdetail.drivcon2   =   string(brstat.tlt.dri_consen2)
    wdetail.dlevel2    =   string(brstat.tlt.dri_level2)
    wdetail.dgender2   =   brstat.tlt.dri_gender2
    wdetail.ntitle3    =   brstat.tlt.dri_title3
    wdetail.dname3     =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,1,INDEX(brstat.tlt.dri_fname3," ") - 1) ELSE TRIM(brstat.tlt.dri_fname3)
    wdetail.dcname3    =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,R-INDEX(brstat.tlt.dri_fname3," ")) ELSE "" 
    wdetail.dlname3    =   brstat.tlt.dri_lname3
    wdetail.doccup3    =   brstat.tlt.dir_occ3
    wdetail.dbirth3    =   brstat.tlt.dri_birth3
    wdetail.dicno3     =   brstat.tlt.dri_ic3
    wdetail.ddriveno3  =   brstat.tlt.dri_lic3
    wdetail.drivexp3   =   brstat.tlt.dri_licenexp3
    wdetail.drivcon3   =   string(brstat.tlt.dri_consen3)
    wdetail.dlevel3    =   string(brstat.tlt.dri_level3)
    wdetail.dgender3   =   brstat.tlt.dri_gender3
    wdetail.ntitle4    =   brstat.tlt.dri_title4
    wdetail.dname4     =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,1,INDEX(brstat.tlt.dri_fname4," ") - 1) ELSE TRIM(brstat.tlt.dri_fname4)
    wdetail.dcname4    =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,R-INDEX(brstat.tlt.dri_fname4," ")) ELSE ""
    wdetail.dlname4    =   brstat.tlt.dri_lname4
    wdetail.doccup4    =   brstat.tlt.dri_occ4
    wdetail.dbirth4    =   brstat.tlt.dri_birth4
    wdetail.dicno4     =   brstat.tlt.dri_ic4
    wdetail.ddriveno4  =   brstat.tlt.dri_lic4
    wdetail.drivexp4   =   brstat.tlt.dri_licenexp4
    wdetail.drivcon4   =   string(brstat.tlt.dri_consen4)
    wdetail.dlevel4    =   string(brstat.tlt.dri_level4)
    wdetail.dgender4   =   brstat.tlt.dri_gender4
    wdetail.ntitle5    =   brstat.tlt.dri_title5
    wdetail.dname5     =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,1,INDEX(brstat.tlt.dri_fname5," ") - 1) ELSE TRIM(brstat.tlt.dri_fname5)
    wdetail.dcname5    =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,R-INDEX(brstat.tlt.dri_fname5," ")) ELSE "" 
    wdetail.dlname5    =   brstat.tlt.dri_lname5
    wdetail.doccup5    =   brstat.tlt.dri_occ5
    wdetail.dbirth5    =   brstat.tlt.dri_birth5
    wdetail.dicno5     =   brstat.tlt.dri_ic5
    wdetail.ddriveno5  =   brstat.tlt.dri_lic5
    wdetail.drivexp5   =   brstat.tlt.dri_licenexp5
    wdetail.drivcon5   =   string(brstat.tlt.dri_consen5)
    wdetail.dlevel5    =   string(brstat.tlt.dri_level5)
    wdetail.dgender5   =   brstat.tlt.dri_gender5  
    wdetail.chargflg    =  STRING(brstat.tlt.chargflg)
    wdetail.chargprice  =  STRING(brstat.tlt.chargsi)
    wdetail.chargno     =  brstat.tlt.chargno
    wdetail.chargprm    =  string(brstat.tlt.chargprem)
    wdetail.battflg     =  string(brstat.tlt.battflg  )
    wdetail.battprice   =  string(brstat.tlt.battprice)
    wdetail.battno      =  brstat.tlt.battno
    wdetail.battprm     =  string(brstat.tlt.battprem)
    wdetail.battdate    =  string(brstat.tlt.ndate1,"99/99/9999")
    wdetail.net_re1     =  string(brstat.tlt.dg_prem)
    wdetail.stam_re1    =  string(brstat.tlt.dg_rstp_t)
    wdetail.vat_re1     =  string(brstat.tlt.dg_rtax_t)
    wdetail.inscode_re2 =  brstat.tlt.ins_code
    wdetail.net_re2     =  string(brstat.tlt.dg_si  )
    wdetail.stam_re2    =  string(brstat.tlt.dg_rate)
    wdetail.vat_re2     =  string(brstat.tlt.dg_feet)
    wdetail.inscode_re3 =  brstat.tlt.Paycode
    wdetail.net_re3     =  string(brstat.tlt.dg_ncb  )
    wdetail.stam_re3    =  string(brstat.tlt.dg_disc )
    wdetail.vat_re3     =  string(brstat.tlt.dg_wdisc) .
 /* END : A68-0061 */
    END.
END. 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_repfielBrM1 c-wins 
PROCEDURE pd_repfielBrM1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    For each tlt Use-index  tlt06 Where
        tlt.nor_effdat >=  fi_trndatfr    And
        tlt.nor_effdat <=  fi_trndatto    AND 
        tlt.genusr      =  "HCT"          And
        tlt.ins_brins   = "M"             NO-LOCK   
        BREAK BY brstat.tlt.comp_noti_ins :
        IF      nv_typre = "V70" AND brstat.tlt.nor_usr_ins  = "0" THEN NEXT.
        ELSE IF nv_typre = "V72" AND brstat.tlt.nor_usr_ins <> "0" THEN NEXT.
        IF brstat.tlt.releas <> cb_reportstatus  THEN NEXT.
        CREATE  wdetail.
        ASSIGN 
        wdetail.n_text001      =  brstat.tlt.comp_noti_ins  
        wdetail.n_text002      =  brstat.tlt.comp_noti_tlt  
        wdetail.n_text003      =  brstat.tlt.comp_pol       
        wdetail.n_text004      =  string(brstat.tlt.nor_effdat,"99/99/9999")     
        wdetail.n_text005      =  string(brstat.tlt.comp_effdat,"99/99/9999")    
        wdetail.n_text006      =  brstat.tlt.comp_sub       
        wdetail.n_text007      =  brstat.tlt.cifno          
        wdetail.n_text008      =  brstat.tlt.nationality    
        wdetail.n_text009      =  brstat.tlt.nor_noti_ins   
        wdetail.n_text010      =  brstat.tlt.nor_noti_tlt   
        wdetail.n_text011      =  brstat.tlt.nor_usr_ins    
        wdetail.n_text012      =  brstat.tlt.covcod         
        wdetail.n_text013      =  brstat.tlt.nor_usr_tlt    
        wdetail.n_text014      =  brstat.tlt.comp_usr_ins   
        wdetail.n_text015      =  brstat.tlt.ins_title      
        wdetail.n_text016      =  brstat.tlt.ins_name       
        wdetail.n_text017      =  brstat.tlt.ins_firstname  
        wdetail.n_text018      =  brstat.tlt.ins_lastname   
        wdetail.n_text019      =  brstat.tlt.ins_addr       
        wdetail.n_text020      =  brstat.tlt.ins_addr1      
        wdetail.n_text021      =  brstat.tlt.ins_addr2      
        wdetail.n_text022      =  brstat.tlt.ins_addr3      
        wdetail.n_text023      =  brstat.tlt.lince2         
        wdetail.n_text024      =  brstat.tlt.ins_addr5      
        wdetail.n_text025      =  brstat.tlt.dir_occ1       
        wdetail.n_text026      =  brstat.tlt.note28         
        wdetail.n_text027      =  brstat.tlt.dri_ic1        
        wdetail.n_text028      =  brstat.tlt.dri_lic1       
        wdetail.n_text029      =  brstat.tlt.brand          
        wdetail.n_text030      =  substr(brstat.tlt.note10,1,1)         
        wdetail.n_text031      =  substr(brstat.tlt.cha_no,1,25)      
        wdetail.n_text032      =  substr(brstat.tlt.eng_no,1,20)                   
        wdetail.n_text033      =  substr(brstat.tlt.model,1,40)                 
        wdetail.n_text034      =  substr(brstat.tlt.note11,1,4)                  
        wdetail.n_text035      =  substr(brstat.tlt.note12,1,20)                  
        wdetail.n_text036      =  substr(brstat.tlt.note13,1,40)                  
        wdetail.n_text037      =  substr(brstat.tlt.note14,1,1)                   
        /*wdetail.n_text038      =  substr(brstat.tlt.vehuse,1,2) */ /* A68-0061*/
        wdetail.n_text038      =  IF rs_typre = 1 THEN substr(brstat.tlt.vehuse,1,2) ELSE TRIM(brstat.tlt.vehuse)  /* A68-0061*/                   
        wdetail.n_text039      =  string(brstat.tlt.seqno,"99")                        
        wdetail.n_text040      =  string(brstat.tlt.cc_weight,"9999")                  
        wdetail.n_text041      =  substr(brstat.tlt.colorcod,1,40)        
        wdetail.n_text042      =  substr(brstat.tlt.lince1,1,10)        
        wdetail.n_text043      =  substr(brstat.tlt.ins_addr4,1,30)        
        wdetail.n_text044      =  substr(brstat.tlt.note15,1,4)         
        wdetail.n_text045      =  substr(brstat.tlt.note16,1,512)              
        wdetail.n_text046      =  substr(brstat.tlt.note17,1,14)        
        wdetail.n_text047      =  substr(brstat.tlt.note18,1,14)       
        wdetail.n_text048      =  substr(brstat.tlt.note19,1,14)          
        wdetail.n_text049      =  substr(brstat.tlt.note2,1,14)          
        wdetail.n_text050      =  substr(brstat.tlt.note20,1,14)       
        wdetail.n_text051      =  substr(brstat.tlt.note21,1,14)          
        wdetail.n_text052      =  substr(brstat.tlt.note22,1,14)        
        wdetail.n_text053      =  substr(brstat.tlt.note23,1,14)        
        wdetail.n_text054      =  substr(brstat.tlt.comp_sck,1,20)        
        wdetail.n_text055      =  substr(brstat.tlt.note24,1,32)        
        wdetail.n_text056      =  substr(brstat.tlt.dri_no1,1,1)        
        wdetail.n_text057      =  substr(brstat.tlt.dri_no2,1,1)         
        wdetail.n_text058      =  substr(brstat.tlt.note25,1,20)      
        wdetail.n_text059      =  substr(brstat.tlt.dri_name1,1,80)      
        wdetail.n_text060      =  substr(brstat.tlt.note26,1,20)      
        wdetail.n_text061      =  substr(brstat.tlt.note27,1,60)      
        wdetail.n_text062      =  substr(brstat.tlt.dri_occ2,1,50)   
        wdetail.n_text063      =  substr(brstat.tlt.note4,1,10)         
        wdetail.n_text064      =  substr(brstat.tlt.dri_ic2,1,15)         
        wdetail.n_text065      =  substr(brstat.tlt.dri_lic2,1,15)         
        wdetail.n_text066      =  substr(brstat.tlt.note29,1,20)         
        wdetail.n_text067      =  substr(brstat.tlt.dri_name2,1,80)         
        wdetail.n_text068      =  substr(brstat.tlt.note3,1,20)         
        wdetail.n_text069      =  substr(brstat.tlt.note30,1,60)         
        wdetail.n_text070      =  substr(brstat.tlt.ins_occ,1,50)         
        wdetail.n_text071      =  IF brstat.tlt.birthdate = ? THEN "" ELSE string(brstat.tlt.birthdate,"99/99/9999")              
        wdetail.n_text072      =  substr(brstat.tlt.ins_icno,1,15)           
        wdetail.n_text073      =  substr(brstat.tlt.note1,1,15)                   
        wdetail.n_text074      =  substr(brstat.tlt.ben83,1,80)                   
        wdetail.n_text075      =  string(brstat.tlt.comp_coamt,"99999999999.99")      
        wdetail.n_text076      =  string(brstat.tlt.comp_grprm,"99999999999.99")      
        wdetail.n_text077      =  string(brstat.tlt.mileage,"99999999999.99")         
        wdetail.n_text078      =  string(brstat.tlt.ndeci1,"99999999999.99")          
        wdetail.n_text079      =  string(brstat.tlt.ndeci2,"99999999999.99")          
        wdetail.n_text080      =  string(brstat.tlt.ndeci3,"99999999999.99")          
        wdetail.n_text081      =  string(brstat.tlt.ndeci4,"99999999999.99")          
        wdetail.n_text082      =  string(brstat.tlt.ndeci5,"99999999999.99")          
        wdetail.n_text083      =  string(brstat.tlt.nor_coamt,"99")                    
        wdetail.n_text084      =  string(brstat.tlt.nor_grprm,"99999999999.99")       
        wdetail.n_text085      =  string(brstat.tlt.prem_amt,"99999999999.99")        
        wdetail.n_text086      =  string(brstat.tlt.prem_amttcop,"99")                 
        wdetail.n_text087      =  string(brstat.tlt.rstp,"99999999999.99")            
        wdetail.n_text088      =  string(brstat.tlt.rtax,"99999999999.99")            
        wdetail.n_text089      =  string(brstat.tlt.tax_coporate,"99999999999.99")    
        wdetail.n_text090      =  substr(brstat.tlt.note5,1,6)            
        wdetail.n_text091      =  substr(brstat.tlt.note6,1,10)        
        wdetail.n_text092      =  substr(brstat.tlt.note7,1,10)        
        wdetail.n_text093      =  substr(brstat.tlt.note8,1,30)        
        wdetail.n_text094      =  substr(brstat.tlt.note9,1,80)        
        wdetail.n_text095      =  substr(brstat.tlt.noteveh1,1,10)        
        wdetail.n_text096      =  substr(brstat.tlt.noteveh2,1,30)        
        wdetail.n_text097      =  substr(brstat.tlt.old_cha,1,12)        
        wdetail.n_text098      =  substr(brstat.tlt.old_eng,1,3)             
        wdetail.n_text099      =  substr(brstat.tlt.pack,1,10)      
        wdetail.n_text100      =  substr(brstat.tlt.packnme,1,14)      
        wdetail.n_text101      =  substr(brstat.tlt.period,1,10)      
        wdetail.n_text102      =  substr(brstat.tlt.ln_note1,1,14) 
        wdetail.n_text103      =  substr(brstat.tlt.product,1,10)   
        wdetail.n_text104      =  substr(brstat.tlt.projnme,1,14)   
        wdetail.n_text105      =  substr(brstat.tlt.proveh,1,10)   
        wdetail.n_text106      =  substr(brstat.tlt.race,1,14)   
        wdetail.n_text107      =  substr(brstat.tlt.recac,1,10)   
        wdetail.n_text108      =  substr(brstat.tlt.rec_addr,1,14)   
        wdetail.n_text109      =  substr(brstat.tlt.rec_addr1,1,15)   
        wdetail.n_text110      =  substr(brstat.tlt.rec_addr2,1,10)   
        wdetail.n_text111      =  substr(brstat.tlt.rec_addr3,1,14)   
        wdetail.n_text112      =  substr(brstat.tlt.rec_addr4,1,10)   
        wdetail.n_text113      =  substr(brstat.tlt.rec_addr5,1,20)   
        wdetail.n_text114      =  substr(brstat.tlt.rec_brins,1,1)         
        wdetail.n_text115      =  substr(brstat.tlt.rec_cou,1,120)      
        wdetail.n_text116      =  substr(brstat.tlt.rec_icno,1,100)      
        wdetail.n_text117      =  substr(brstat.tlt.rec_name,1,2)         
        wdetail.n_text118      =  substr(brstat.tlt.rec_name2,1,2)         
        wdetail.n_text119      =  substr(brstat.tlt.rec_note1,1,10)        
        wdetail.n_text120      =  substr(brstat.tlt.rec_note2,1,1)        
        wdetail.n_text121      =  substr(brstat.tlt.rec_title,1,10)        
        wdetail.n_text122      =  substr(brstat.tlt.rec_typ,1,255)       
        wdetail.n_text123      =  substr(brstat.tlt.rider,1,5)         
        wdetail.n_text124      =  substr(brstat.tlt.safe1,1,20)        
        wdetail.n_text125      =  substr(brstat.tlt.safe2,1,10)        
        wdetail.n_text126      =  substr(brstat.tlt.safe3,1,150)       
        wdetail.n_text127      =  substr(brstat.tlt.sex,1,15)        
        wdetail.n_text128      =  substr(brstat.tlt.stat,1,250)       
        wdetail.n_text129      =  substr(brstat.tlt.subins,1,13)        
        wdetail.n_text130      =  substr(brstat.tlt.tel,1,10)        
        wdetail.n_text131      =  substr(brstat.tlt.tel2,1,150)      
        wdetail.n_text132      =  substr(brstat.tlt.tel3,1,15)       
        wdetail.n_text133      =  substr(brstat.tlt.usrid,1,250)       
        wdetail.n_text134      =  substr(brstat.tlt.usrsent,1,13)       
        wdetail.n_text135      =  substr(brstat.tlt.ln_product,1,10)     
        wdetail.n_text136      =  substr(brstat.tlt.ln_pronme,1,150)    
        wdetail.n_text137      =  substr(brstat.tlt.ln_rate,1,15)     
        wdetail.n_text138      =  substr(brstat.tlt.ln_st,1,250)    
        wdetail.n_text139      =  substr(brstat.tlt.lotno,1,13)    
        wdetail.n_text140      =  substr(brstat.tlt.maritalsts,1,10)    
        wdetail.n_text141      =  substr(brstat.tlt.campaign,1,12)    
        wdetail.n_text142      =  substr(brstat.tlt.mobile,1,10)    .  
         /* ADD BY : A68-0061 */
    ASSIGN 
    wdetail.typepol    =   brstat.tlt.poltyp
    wdetail.typecar    =   brstat.tlt.car_type
    wdetail.maksi      =   STRING(brstat.tlt.maksi)
    wdetail.drivexp1   =   brstat.tlt.dri_licenexp1
    wdetail.drivcon1   =   string(brstat.tlt.dri_consen1)
    wdetail.dlevel1    =   string(brstat.tlt.dri_level1)
    wdetail.dgender1   =   brstat.tlt.dri_gender1
    wdetail.drivexp2   =   brstat.tlt.dri_licenexp2
    wdetail.drivcon2   =   string(brstat.tlt.dri_consen2)
    wdetail.dlevel2    =   string(brstat.tlt.dri_level2)
    wdetail.dgender2   =   brstat.tlt.dri_gender2
    wdetail.ntitle3    =   brstat.tlt.dri_title3
    wdetail.dname3     =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,1,INDEX(brstat.tlt.dri_fname3," ") - 1) ELSE TRIM(brstat.tlt.dri_fname3)
    wdetail.dcname3    =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,R-INDEX(brstat.tlt.dri_fname3," ")) ELSE "" 
    wdetail.dlname3    =   brstat.tlt.dri_lname3
    wdetail.doccup3    =   brstat.tlt.dir_occ3
    wdetail.dbirth3    =   brstat.tlt.dri_birth3
    wdetail.dicno3     =   brstat.tlt.dri_ic3
    wdetail.ddriveno3  =   brstat.tlt.dri_lic3
    wdetail.drivexp3   =   brstat.tlt.dri_licenexp3
    wdetail.drivcon3   =   string(brstat.tlt.dri_consen3)
    wdetail.dlevel3    =   string(brstat.tlt.dri_level3)
    wdetail.dgender3   =   brstat.tlt.dri_gender3
    wdetail.ntitle4    =   brstat.tlt.dri_title4
    wdetail.dname4     =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,1,INDEX(brstat.tlt.dri_fname4," ") - 1) ELSE TRIM(brstat.tlt.dri_fname4)
    wdetail.dcname4    =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,R-INDEX(brstat.tlt.dri_fname4," ")) ELSE ""
    wdetail.dlname4    =   brstat.tlt.dri_lname4
    wdetail.doccup4    =   brstat.tlt.dri_occ4
    wdetail.dbirth4    =   brstat.tlt.dri_birth4
    wdetail.dicno4     =   brstat.tlt.dri_ic4
    wdetail.ddriveno4  =   brstat.tlt.dri_lic4
    wdetail.drivexp4   =   brstat.tlt.dri_licenexp4
    wdetail.drivcon4   =   string(brstat.tlt.dri_consen4)
    wdetail.dlevel4    =   string(brstat.tlt.dri_level4)
    wdetail.dgender4   =   brstat.tlt.dri_gender4
    wdetail.ntitle5    =   brstat.tlt.dri_title5
    wdetail.dname5     =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,1,INDEX(brstat.tlt.dri_fname5," ") - 1) ELSE TRIM(brstat.tlt.dri_fname5)
    wdetail.dcname5    =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,R-INDEX(brstat.tlt.dri_fname5," ")) ELSE "" 
    wdetail.dlname5    =   brstat.tlt.dri_lname5
    wdetail.doccup5    =   brstat.tlt.dri_occ5
    wdetail.dbirth5    =   brstat.tlt.dri_birth5
    wdetail.dicno5     =   brstat.tlt.dri_ic5
    wdetail.ddriveno5  =   brstat.tlt.dri_lic5
    wdetail.drivexp5   =   brstat.tlt.dri_licenexp5
    wdetail.drivcon5   =   string(brstat.tlt.dri_consen5)
    wdetail.dlevel5    =   string(brstat.tlt.dri_level5)
    wdetail.dgender5   =   brstat.tlt.dri_gender5  
    wdetail.chargflg    =  STRING(brstat.tlt.chargflg)
    wdetail.chargprice  =  STRING(brstat.tlt.chargsi)
    wdetail.chargno     =  brstat.tlt.chargno
    wdetail.chargprm    =  string(brstat.tlt.chargprem)
    wdetail.battflg     =  string(brstat.tlt.battflg  )
    wdetail.battprice   =  string(brstat.tlt.battprice)
    wdetail.battno      =  brstat.tlt.battno
    wdetail.battprm     =  string(brstat.tlt.battprem)
    wdetail.battdate    =  string(brstat.tlt.ndate1,"99/99/9999")
    wdetail.net_re1     =  string(brstat.tlt.dg_prem)
    wdetail.stam_re1    =  string(brstat.tlt.dg_rstp_t)
    wdetail.vat_re1     =  string(brstat.tlt.dg_rtax_t)
    wdetail.inscode_re2 =  brstat.tlt.ins_code
    wdetail.net_re2     =  string(brstat.tlt.dg_si  )
    wdetail.stam_re2    =  string(brstat.tlt.dg_rate)
    wdetail.vat_re2     =  string(brstat.tlt.dg_feet)
    wdetail.inscode_re3 =  brstat.tlt.Paycode
    wdetail.net_re3     =  string(brstat.tlt.dg_ncb  )
    wdetail.stam_re3    =  string(brstat.tlt.dg_disc )
    wdetail.vat_re3     =  string(brstat.tlt.dg_wdisc) .
 /* END : A68-0061 */
    END.  /* tlt */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_repfielBrM2 c-wins 
PROCEDURE pd_repfielBrM2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wproducer NO-LOCK.
    For each tlt Use-index  tlt06 Where
        tlt.nor_effdat >=  fi_trndatfr    And
        tlt.nor_effdat <=  fi_trndatto    AND 
        /*tlt.acno1    =  trim(fi_producer)  AND*/
        tlt.acno1      =  wproducer.producer  AND 
        tlt.genusr     =  "HCT"            And
        brstat.tlt.ins_brins   = "M"       NO-LOCK
        BREAK BY brstat.tlt.comp_noti_ins :
        IF      nv_typre = "V70" AND brstat.tlt.nor_usr_ins  = "0" THEN NEXT.
        ELSE IF nv_typre = "V72" AND brstat.tlt.nor_usr_ins <> "0" THEN NEXT.
        IF brstat.tlt.releas <> cb_reportstatus  THEN NEXT.
        CREATE  wdetail.
        ASSIGN 
        wdetail.n_text001      =  brstat.tlt.comp_noti_ins  
        wdetail.n_text002      =  brstat.tlt.comp_noti_tlt  
        wdetail.n_text003      =  brstat.tlt.comp_pol       
        wdetail.n_text004      =  string(brstat.tlt.nor_effdat,"99/99/9999")     
        wdetail.n_text005      =  string(brstat.tlt.comp_effdat,"99/99/9999")    
        wdetail.n_text006      =  brstat.tlt.comp_sub       
        wdetail.n_text007      =  brstat.tlt.cifno          
        wdetail.n_text008      =  brstat.tlt.nationality    
        wdetail.n_text009      =  brstat.tlt.nor_noti_ins   
        wdetail.n_text010      =  brstat.tlt.nor_noti_tlt   
        wdetail.n_text011      =  brstat.tlt.nor_usr_ins    
        wdetail.n_text012      =  brstat.tlt.covcod         
        wdetail.n_text013      =  brstat.tlt.nor_usr_tlt    
        wdetail.n_text014      =  brstat.tlt.comp_usr_ins   
        wdetail.n_text015      =  brstat.tlt.ins_title      
        wdetail.n_text016      =  brstat.tlt.ins_name       
        wdetail.n_text017      =  brstat.tlt.ins_firstname  
        wdetail.n_text018      =  brstat.tlt.ins_lastname   
        wdetail.n_text019      =  brstat.tlt.ins_addr       
        wdetail.n_text020      =  brstat.tlt.ins_addr1      
        wdetail.n_text021      =  brstat.tlt.ins_addr2      
        wdetail.n_text022      =  brstat.tlt.ins_addr3      
        wdetail.n_text023      =  brstat.tlt.lince2         
        wdetail.n_text024      =  brstat.tlt.ins_addr5      
        wdetail.n_text025      =  brstat.tlt.dir_occ1       
        wdetail.n_text026      =  brstat.tlt.note28         
        wdetail.n_text027      =  brstat.tlt.dri_ic1        
        wdetail.n_text028      =  brstat.tlt.dri_lic1       
        wdetail.n_text029      =  brstat.tlt.brand          
        wdetail.n_text030      =  substr(brstat.tlt.note10,1,1)         
        wdetail.n_text031      =  substr(brstat.tlt.cha_no,1,25)      
        wdetail.n_text032      =  substr(brstat.tlt.eng_no,1,20)                   
        wdetail.n_text033      =  substr(brstat.tlt.model,1,40)                 
        wdetail.n_text034      =  substr(brstat.tlt.note11,1,4)                  
        wdetail.n_text035      =  substr(brstat.tlt.note12,1,20)                  
        wdetail.n_text036      =  substr(brstat.tlt.note13,1,40)                  
        wdetail.n_text037      =  substr(brstat.tlt.note14,1,1)                   
        /*wdetail.n_text038      =  substr(brstat.tlt.vehuse,1,2) */ /* A68-0061*/
        wdetail.n_text038      =  IF rs_typre = 1 THEN substr(brstat.tlt.vehuse,1,2) ELSE TRIM(brstat.tlt.vehuse)  /* A68-0061*/                   
        wdetail.n_text039      =  string(brstat.tlt.seqno,"99")                        
        wdetail.n_text040      =  string(brstat.tlt.cc_weight,"9999")                  
        wdetail.n_text041      =  substr(brstat.tlt.colorcod,1,40)        
        wdetail.n_text042      =  substr(brstat.tlt.lince1,1,10)        
        wdetail.n_text043      =  substr(brstat.tlt.ins_addr4,1,30)        
        wdetail.n_text044      =  substr(brstat.tlt.note15,1,4)         
        wdetail.n_text045      =  substr(brstat.tlt.note16,1,512)              
        wdetail.n_text046      =  substr(brstat.tlt.note17,1,14)        
        wdetail.n_text047      =  substr(brstat.tlt.note18,1,14)       
        wdetail.n_text048      =  substr(brstat.tlt.note19,1,14)          
        wdetail.n_text049      =  substr(brstat.tlt.note2,1,14)          
        wdetail.n_text050      =  substr(brstat.tlt.note20,1,14)       
        wdetail.n_text051      =  substr(brstat.tlt.note21,1,14)          
        wdetail.n_text052      =  substr(brstat.tlt.note22,1,14)        
        wdetail.n_text053      =  substr(brstat.tlt.note23,1,14)        
        wdetail.n_text054      =  substr(brstat.tlt.comp_sck,1,20)        
        wdetail.n_text055      =  substr(brstat.tlt.note24,1,32)        
        wdetail.n_text056      =  substr(brstat.tlt.dri_no1,1,1)        
        wdetail.n_text057      =  substr(brstat.tlt.dri_no2,1,1)         
        wdetail.n_text058      =  substr(brstat.tlt.note25,1,20)      
        wdetail.n_text059      =  substr(brstat.tlt.dri_name1,1,80)      
        wdetail.n_text060      =  substr(brstat.tlt.note26,1,20)      
        wdetail.n_text061      =  substr(brstat.tlt.note27,1,60)      
        wdetail.n_text062      =  substr(brstat.tlt.dri_occ2,1,50)   
        wdetail.n_text063      =  substr(brstat.tlt.note4,1,10)         
        wdetail.n_text064      =  substr(brstat.tlt.dri_ic2,1,15)         
        wdetail.n_text065      =  substr(brstat.tlt.dri_lic2,1,15)         
        wdetail.n_text066      =  substr(brstat.tlt.note29,1,20)         
        wdetail.n_text067      =  substr(brstat.tlt.dri_name2,1,80)         
        wdetail.n_text068      =  substr(brstat.tlt.note3,1,20)         
        wdetail.n_text069      =  substr(brstat.tlt.note30,1,60)         
        wdetail.n_text070      =  substr(brstat.tlt.ins_occ,1,50)         
        wdetail.n_text071      =  IF brstat.tlt.birthdate = ? THEN "" ELSE string(brstat.tlt.birthdate,"99/99/9999")              
        wdetail.n_text072      =  substr(brstat.tlt.ins_icno,1,15)           
        wdetail.n_text073      =  substr(brstat.tlt.note1,1,15)                   
        wdetail.n_text074      =  substr(brstat.tlt.ben83,1,80)                   
        wdetail.n_text075      =  string(brstat.tlt.comp_coamt,"99999999999.99")      
        wdetail.n_text076      =  string(brstat.tlt.comp_grprm,"99999999999.99")      
        wdetail.n_text077      =  string(brstat.tlt.mileage,"99999999999.99")         
        wdetail.n_text078      =  string(brstat.tlt.ndeci1,"99999999999.99")          
        wdetail.n_text079      =  string(brstat.tlt.ndeci2,"99999999999.99")          
        wdetail.n_text080      =  string(brstat.tlt.ndeci3,"99999999999.99")          
        wdetail.n_text081      =  string(brstat.tlt.ndeci4,"99999999999.99")          
        wdetail.n_text082      =  string(brstat.tlt.ndeci5,"99999999999.99")          
        wdetail.n_text083      =  string(brstat.tlt.nor_coamt,"99")                    
        wdetail.n_text084      =  string(brstat.tlt.nor_grprm,"99999999999.99")       
        wdetail.n_text085      =  string(brstat.tlt.prem_amt,"99999999999.99")        
        wdetail.n_text086      =  string(brstat.tlt.prem_amttcop,"99")                 
        wdetail.n_text087      =  string(brstat.tlt.rstp,"99999999999.99")            
        wdetail.n_text088      =  string(brstat.tlt.rtax,"99999999999.99")            
        wdetail.n_text089      =  string(brstat.tlt.tax_coporate,"99999999999.99")    
        wdetail.n_text090      =  substr(brstat.tlt.note5,1,6)            
        wdetail.n_text091      =  substr(brstat.tlt.note6,1,10)        
        wdetail.n_text092      =  substr(brstat.tlt.note7,1,10)        
        wdetail.n_text093      =  substr(brstat.tlt.note8,1,30)        
        wdetail.n_text094      =  substr(brstat.tlt.note9,1,80)        
        wdetail.n_text095      =  substr(brstat.tlt.noteveh1,1,10)        
        wdetail.n_text096      =  substr(brstat.tlt.noteveh2,1,30)        
        wdetail.n_text097      =  substr(brstat.tlt.old_cha,1,12)        
        wdetail.n_text098      =  substr(brstat.tlt.old_eng,1,3)             
        wdetail.n_text099      =  substr(brstat.tlt.pack,1,10)      
        wdetail.n_text100      =  substr(brstat.tlt.packnme,1,14)      
        wdetail.n_text101      =  substr(brstat.tlt.period,1,10)      
        wdetail.n_text102      =  substr(brstat.tlt.ln_note1,1,14) 
        wdetail.n_text103      =  substr(brstat.tlt.product,1,10)   
        wdetail.n_text104      =  substr(brstat.tlt.projnme,1,14)   
        wdetail.n_text105      =  substr(brstat.tlt.proveh,1,10)   
        wdetail.n_text106      =  substr(brstat.tlt.race,1,14)   
        wdetail.n_text107      =  substr(brstat.tlt.recac,1,10)   
        wdetail.n_text108      =  substr(brstat.tlt.rec_addr,1,14)   
        wdetail.n_text109      =  substr(brstat.tlt.rec_addr1,1,15)   
        wdetail.n_text110      =  substr(brstat.tlt.rec_addr2,1,10)   
        wdetail.n_text111      =  substr(brstat.tlt.rec_addr3,1,14)   
        wdetail.n_text112      =  substr(brstat.tlt.rec_addr4,1,10)   
        wdetail.n_text113      =  substr(brstat.tlt.rec_addr5,1,20)   
        wdetail.n_text114      =  substr(brstat.tlt.rec_brins,1,1)         
        wdetail.n_text115      =  substr(brstat.tlt.rec_cou,1,120)      
        wdetail.n_text116      =  substr(brstat.tlt.rec_icno,1,100)      
        wdetail.n_text117      =  substr(brstat.tlt.rec_name,1,2)         
        wdetail.n_text118      =  substr(brstat.tlt.rec_name2,1,2)         
        wdetail.n_text119      =  substr(brstat.tlt.rec_note1,1,10)        
        wdetail.n_text120      =  substr(brstat.tlt.rec_note2,1,1)        
        wdetail.n_text121      =  substr(brstat.tlt.rec_title,1,10)        
        wdetail.n_text122      =  substr(brstat.tlt.rec_typ,1,255)       
        wdetail.n_text123      =  substr(brstat.tlt.rider,1,5)         
        wdetail.n_text124      =  substr(brstat.tlt.safe1,1,20)        
        wdetail.n_text125      =  substr(brstat.tlt.safe2,1,10)        
        wdetail.n_text126      =  substr(brstat.tlt.safe3,1,150)       
        wdetail.n_text127      =  substr(brstat.tlt.sex,1,15)        
        wdetail.n_text128      =  substr(brstat.tlt.stat,1,250)       
        wdetail.n_text129      =  substr(brstat.tlt.subins,1,13)        
        wdetail.n_text130      =  substr(brstat.tlt.tel,1,10)        
        wdetail.n_text131      =  substr(brstat.tlt.tel2,1,150)      
        wdetail.n_text132      =  substr(brstat.tlt.tel3,1,15)       
        wdetail.n_text133      =  substr(brstat.tlt.usrid,1,250)       
        wdetail.n_text134      =  substr(brstat.tlt.usrsent,1,13)       
        wdetail.n_text135      =  substr(brstat.tlt.ln_product,1,10)     
        wdetail.n_text136      =  substr(brstat.tlt.ln_pronme,1,150)    
        wdetail.n_text137      =  substr(brstat.tlt.ln_rate,1,15)     
        wdetail.n_text138      =  substr(brstat.tlt.ln_st,1,250)    
        wdetail.n_text139      =  substr(brstat.tlt.lotno,1,13)    
        wdetail.n_text140      =  substr(brstat.tlt.maritalsts,1,10)    
        wdetail.n_text141      =  substr(brstat.tlt.campaign,1,12)    
        wdetail.n_text142      =  substr(brstat.tlt.mobile,1,10)    .  
         /* ADD BY : A68-0061 */
    ASSIGN 
    wdetail.typepol    =   brstat.tlt.poltyp
    wdetail.typecar    =   brstat.tlt.car_type
    wdetail.maksi      =   STRING(brstat.tlt.maksi)
    wdetail.drivexp1   =   brstat.tlt.dri_licenexp1
    wdetail.drivcon1   =   string(brstat.tlt.dri_consen1)
    wdetail.dlevel1    =   string(brstat.tlt.dri_level1)
    wdetail.dgender1   =   brstat.tlt.dri_gender1
    wdetail.drivexp2   =   brstat.tlt.dri_licenexp2
    wdetail.drivcon2   =   string(brstat.tlt.dri_consen2)
    wdetail.dlevel2    =   string(brstat.tlt.dri_level2)
    wdetail.dgender2   =   brstat.tlt.dri_gender2
    wdetail.ntitle3    =   brstat.tlt.dri_title3
    wdetail.dname3     =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,1,INDEX(brstat.tlt.dri_fname3," ") - 1) ELSE TRIM(brstat.tlt.dri_fname3)
    wdetail.dcname3    =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,R-INDEX(brstat.tlt.dri_fname3," ")) ELSE "" 
    wdetail.dlname3    =   brstat.tlt.dri_lname3
    wdetail.doccup3    =   brstat.tlt.dir_occ3
    wdetail.dbirth3    =   brstat.tlt.dri_birth3
    wdetail.dicno3     =   brstat.tlt.dri_ic3
    wdetail.ddriveno3  =   brstat.tlt.dri_lic3
    wdetail.drivexp3   =   brstat.tlt.dri_licenexp3
    wdetail.drivcon3   =   string(brstat.tlt.dri_consen3)
    wdetail.dlevel3    =   string(brstat.tlt.dri_level3)
    wdetail.dgender3   =   brstat.tlt.dri_gender3
    wdetail.ntitle4    =   brstat.tlt.dri_title4
    wdetail.dname4     =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,1,INDEX(brstat.tlt.dri_fname4," ") - 1) ELSE TRIM(brstat.tlt.dri_fname4)
    wdetail.dcname4    =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,R-INDEX(brstat.tlt.dri_fname4," ")) ELSE ""
    wdetail.dlname4    =   brstat.tlt.dri_lname4
    wdetail.doccup4    =   brstat.tlt.dri_occ4
    wdetail.dbirth4    =   brstat.tlt.dri_birth4
    wdetail.dicno4     =   brstat.tlt.dri_ic4
    wdetail.ddriveno4  =   brstat.tlt.dri_lic4
    wdetail.drivexp4   =   brstat.tlt.dri_licenexp4
    wdetail.drivcon4   =   string(brstat.tlt.dri_consen4)
    wdetail.dlevel4    =   string(brstat.tlt.dri_level4)
    wdetail.dgender4   =   brstat.tlt.dri_gender4
    wdetail.ntitle5    =   brstat.tlt.dri_title5
    wdetail.dname5     =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,1,INDEX(brstat.tlt.dri_fname5," ") - 1) ELSE TRIM(brstat.tlt.dri_fname5)
    wdetail.dcname5    =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,R-INDEX(brstat.tlt.dri_fname5," ")) ELSE "" 
    wdetail.dlname5    =   brstat.tlt.dri_lname5
    wdetail.doccup5    =   brstat.tlt.dri_occ5
    wdetail.dbirth5    =   brstat.tlt.dri_birth5
    wdetail.dicno5     =   brstat.tlt.dri_ic5
    wdetail.ddriveno5  =   brstat.tlt.dri_lic5
    wdetail.drivexp5   =   brstat.tlt.dri_licenexp5
    wdetail.drivcon5   =   string(brstat.tlt.dri_consen5)
    wdetail.dlevel5    =   string(brstat.tlt.dri_level5)
    wdetail.dgender5   =   brstat.tlt.dri_gender5  
    wdetail.chargflg    =  STRING(brstat.tlt.chargflg)
    wdetail.chargprice  =  STRING(brstat.tlt.chargsi)
    wdetail.chargno     =  brstat.tlt.chargno
    wdetail.chargprm    =  string(brstat.tlt.chargprem)
    wdetail.battflg     =  string(brstat.tlt.battflg  )
    wdetail.battprice   =  string(brstat.tlt.battprice)
    wdetail.battno      =  brstat.tlt.battno
    wdetail.battprm     =  string(brstat.tlt.battprem)
    wdetail.battdate    =  string(brstat.tlt.ndate1,"99/99/9999")
    wdetail.net_re1     =  string(brstat.tlt.dg_prem)
    wdetail.stam_re1    =  string(brstat.tlt.dg_rstp_t)
    wdetail.vat_re1     =  string(brstat.tlt.dg_rtax_t)
    wdetail.inscode_re2 =  brstat.tlt.ins_code
    wdetail.net_re2     =  string(brstat.tlt.dg_si  )
    wdetail.stam_re2    =  string(brstat.tlt.dg_rate)
    wdetail.vat_re2     =  string(brstat.tlt.dg_feet)
    wdetail.inscode_re3 =  brstat.tlt.Paycode
    wdetail.net_re3     =  string(brstat.tlt.dg_ncb  )
    wdetail.stam_re3    =  string(brstat.tlt.dg_disc )
    wdetail.vat_re3     =  string(brstat.tlt.dg_wdisc) .
 /* END : A68-0061 */
    END.
END. 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_repfielBRnoM1 c-wins 
PROCEDURE pd_repfielBRnoM1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    For each tlt Use-index  tlt06 Where
        tlt.nor_effdat >=  fi_trndatfr  And 
        tlt.nor_effdat <=  fi_trndatto  AND 
        tlt.genusr      =  "HCT"        And 
        brstat.tlt.ins_brins  <> "M"    
        
        BREAK BY brstat.tlt.comp_noti_ins :
        IF      nv_typre = "V70" AND brstat.tlt.nor_usr_ins  = "0" THEN NEXT.
        ELSE IF nv_typre = "V72" AND brstat.tlt.nor_usr_ins <> "0" THEN NEXT.
        IF brstat.tlt.releas <> cb_reportstatus  THEN NEXT.
        CREATE  wdetail.
        ASSIGN 
        wdetail.n_text001      =  brstat.tlt.comp_noti_ins  
        wdetail.n_text002      =  brstat.tlt.comp_noti_tlt  
        wdetail.n_text003      =  brstat.tlt.comp_pol       
        wdetail.n_text004      =  string(brstat.tlt.nor_effdat,"99/99/9999")     
        wdetail.n_text005      =  string(brstat.tlt.comp_effdat,"99/99/9999")    
        wdetail.n_text006      =  brstat.tlt.comp_sub       
        wdetail.n_text007      =  brstat.tlt.cifno          
        wdetail.n_text008      =  brstat.tlt.nationality    
        wdetail.n_text009      =  brstat.tlt.nor_noti_ins   
        wdetail.n_text010      =  brstat.tlt.nor_noti_tlt   
        wdetail.n_text011      =  brstat.tlt.nor_usr_ins    
        wdetail.n_text012      =  brstat.tlt.covcod         
        wdetail.n_text013      =  brstat.tlt.nor_usr_tlt    
        wdetail.n_text014      =  brstat.tlt.comp_usr_ins   
        wdetail.n_text015      =  brstat.tlt.ins_title      
        wdetail.n_text016      =  brstat.tlt.ins_name       
        wdetail.n_text017      =  brstat.tlt.ins_firstname  
        wdetail.n_text018      =  brstat.tlt.ins_lastname   
        wdetail.n_text019      =  brstat.tlt.ins_addr       
        wdetail.n_text020      =  brstat.tlt.ins_addr1      
        wdetail.n_text021      =  brstat.tlt.ins_addr2      
        wdetail.n_text022      =  brstat.tlt.ins_addr3      
        wdetail.n_text023      =  brstat.tlt.lince2         
        wdetail.n_text024      =  brstat.tlt.ins_addr5      
        wdetail.n_text025      =  brstat.tlt.dir_occ1       
        wdetail.n_text026      =  brstat.tlt.note28         
        wdetail.n_text027      =  brstat.tlt.dri_ic1        
        wdetail.n_text028      =  brstat.tlt.dri_lic1       
        wdetail.n_text029      =  brstat.tlt.brand          
        wdetail.n_text030      =  substr(brstat.tlt.note10,1,1)         
        wdetail.n_text031      =  substr(brstat.tlt.cha_no,1,25)      
        wdetail.n_text032      =  substr(brstat.tlt.eng_no,1,20)                   
        wdetail.n_text033      =  substr(brstat.tlt.model,1,40)                 
        wdetail.n_text034      =  substr(brstat.tlt.note11,1,4)                  
        wdetail.n_text035      =  substr(brstat.tlt.note12,1,20)                  
        wdetail.n_text036      =  substr(brstat.tlt.note13,1,40)                  
        wdetail.n_text037      =  substr(brstat.tlt.note14,1,1)                   
        /*wdetail.n_text038      =  substr(brstat.tlt.vehuse,1,2) */ /* A68-0061*/
        wdetail.n_text038      =  IF rs_typre = 1 THEN substr(brstat.tlt.vehuse,1,2) ELSE TRIM(brstat.tlt.vehuse)  /* A68-0061*/                   
        wdetail.n_text039      =  string(brstat.tlt.seqno,"99")                        
        wdetail.n_text040      =  string(brstat.tlt.cc_weight,"9999")                  
        wdetail.n_text041      =  substr(brstat.tlt.colorcod,1,40)        
        wdetail.n_text042      =  substr(brstat.tlt.lince1,1,10)        
        wdetail.n_text043      =  substr(brstat.tlt.ins_addr4,1,30)        
        wdetail.n_text044      =  substr(brstat.tlt.note15,1,4)         
        wdetail.n_text045      =  substr(brstat.tlt.note16,1,512)              
        wdetail.n_text046      =  substr(brstat.tlt.note17,1,14)        
        wdetail.n_text047      =  substr(brstat.tlt.note18,1,14)       
        wdetail.n_text048      =  substr(brstat.tlt.note19,1,14)          
        wdetail.n_text049      =  substr(brstat.tlt.note2,1,14)          
        wdetail.n_text050      =  substr(brstat.tlt.note20,1,14)       
        wdetail.n_text051      =  substr(brstat.tlt.note21,1,14)          
        wdetail.n_text052      =  substr(brstat.tlt.note22,1,14)        
        wdetail.n_text053      =  substr(brstat.tlt.note23,1,14)        
        wdetail.n_text054      =  substr(brstat.tlt.comp_sck,1,20)        
        wdetail.n_text055      =  substr(brstat.tlt.note24,1,32)        
        wdetail.n_text056      =  substr(brstat.tlt.dri_no1,1,1)        
        wdetail.n_text057      =  substr(brstat.tlt.dri_no2,1,1)         
        wdetail.n_text058      =  substr(brstat.tlt.note25,1,20)      
        wdetail.n_text059      =  substr(brstat.tlt.dri_name1,1,80)      
        wdetail.n_text060      =  substr(brstat.tlt.note26,1,20)      
        wdetail.n_text061      =  substr(brstat.tlt.note27,1,60)      
        wdetail.n_text062      =  substr(brstat.tlt.dri_occ2,1,50)   
        wdetail.n_text063      =  substr(brstat.tlt.note4,1,10)         
        wdetail.n_text064      =  substr(brstat.tlt.dri_ic2,1,15)         
        wdetail.n_text065      =  substr(brstat.tlt.dri_lic2,1,15)         
        wdetail.n_text066      =  substr(brstat.tlt.note29,1,20)         
        wdetail.n_text067      =  substr(brstat.tlt.dri_name2,1,80)         
        wdetail.n_text068      =  substr(brstat.tlt.note3,1,20)         
        wdetail.n_text069      =  substr(brstat.tlt.note30,1,60)         
        wdetail.n_text070      =  substr(brstat.tlt.ins_occ,1,50)         
        wdetail.n_text071      =  IF brstat.tlt.birthdate = ? THEN "" ELSE string(brstat.tlt.birthdate,"99/99/9999")              
        wdetail.n_text072      =  substr(brstat.tlt.ins_icno,1,15)           
        wdetail.n_text073      =  substr(brstat.tlt.note1,1,15)                   
        wdetail.n_text074      =  substr(brstat.tlt.ben83,1,80)                   
        wdetail.n_text075      =  string(brstat.tlt.comp_coamt,"99999999999.99")      
        wdetail.n_text076      =  string(brstat.tlt.comp_grprm,"99999999999.99")      
        wdetail.n_text077      =  string(brstat.tlt.mileage,"99999999999.99")         
        wdetail.n_text078      =  string(brstat.tlt.ndeci1,"99999999999.99")          
        wdetail.n_text079      =  string(brstat.tlt.ndeci2,"99999999999.99")          
        wdetail.n_text080      =  string(brstat.tlt.ndeci3,"99999999999.99")          
        wdetail.n_text081      =  string(brstat.tlt.ndeci4,"99999999999.99")          
        wdetail.n_text082      =  string(brstat.tlt.ndeci5,"99999999999.99")          
        wdetail.n_text083      =  string(brstat.tlt.nor_coamt,"99")                    
        wdetail.n_text084      =  string(brstat.tlt.nor_grprm,"99999999999.99")       
        wdetail.n_text085      =  string(brstat.tlt.prem_amt,"99999999999.99")        
        wdetail.n_text086      =  string(brstat.tlt.prem_amttcop,"99")                 
        wdetail.n_text087      =  string(brstat.tlt.rstp,"99999999999.99")            
        wdetail.n_text088      =  string(brstat.tlt.rtax,"99999999999.99")            
        wdetail.n_text089      =  string(brstat.tlt.tax_coporate,"99999999999.99")    
        wdetail.n_text090      =  substr(brstat.tlt.note5,1,6)            
        wdetail.n_text091      =  substr(brstat.tlt.note6,1,10)        
        wdetail.n_text092      =  substr(brstat.tlt.note7,1,10)        
        wdetail.n_text093      =  substr(brstat.tlt.note8,1,30)        
        wdetail.n_text094      =  substr(brstat.tlt.note9,1,80)        
        wdetail.n_text095      =  substr(brstat.tlt.noteveh1,1,10)        
        wdetail.n_text096      =  substr(brstat.tlt.noteveh2,1,30)        
        wdetail.n_text097      =  substr(brstat.tlt.old_cha,1,12)        
        wdetail.n_text098      =  substr(brstat.tlt.old_eng,1,3)             
        wdetail.n_text099      =  substr(brstat.tlt.pack,1,10)      
        wdetail.n_text100      =  substr(brstat.tlt.packnme,1,14)      
        wdetail.n_text101      =  substr(brstat.tlt.period,1,10)      
        wdetail.n_text102      =  substr(brstat.tlt.ln_note1,1,14) 
        wdetail.n_text103      =  substr(brstat.tlt.product,1,10)   
        wdetail.n_text104      =  substr(brstat.tlt.projnme,1,14)   
        wdetail.n_text105      =  substr(brstat.tlt.proveh,1,10)   
        wdetail.n_text106      =  substr(brstat.tlt.race,1,14)   
        wdetail.n_text107      =  substr(brstat.tlt.recac,1,10)   
        wdetail.n_text108      =  substr(brstat.tlt.rec_addr,1,14)   
        wdetail.n_text109      =  substr(brstat.tlt.rec_addr1,1,15)   
        wdetail.n_text110      =  substr(brstat.tlt.rec_addr2,1,10)   
        wdetail.n_text111      =  substr(brstat.tlt.rec_addr3,1,14)   
        wdetail.n_text112      =  substr(brstat.tlt.rec_addr4,1,10)   
        wdetail.n_text113      =  substr(brstat.tlt.rec_addr5,1,20)   
        wdetail.n_text114      =  substr(brstat.tlt.rec_brins,1,1)         
        wdetail.n_text115      =  substr(brstat.tlt.rec_cou,1,120)      
        wdetail.n_text116      =  substr(brstat.tlt.rec_icno,1,100)      
        wdetail.n_text117      =  substr(brstat.tlt.rec_name,1,2)         
        wdetail.n_text118      =  substr(brstat.tlt.rec_name2,1,2)         
        wdetail.n_text119      =  substr(brstat.tlt.rec_note1,1,10)        
        wdetail.n_text120      =  substr(brstat.tlt.rec_note2,1,1)        
        wdetail.n_text121      =  substr(brstat.tlt.rec_title,1,10)        
        wdetail.n_text122      =  substr(brstat.tlt.rec_typ,1,255)       
        wdetail.n_text123      =  substr(brstat.tlt.rider,1,5)         
        wdetail.n_text124      =  substr(brstat.tlt.safe1,1,20)        
        wdetail.n_text125      =  substr(brstat.tlt.safe2,1,10)        
        wdetail.n_text126      =  substr(brstat.tlt.safe3,1,150)       
        wdetail.n_text127      =  substr(brstat.tlt.sex,1,15)        
        wdetail.n_text128      =  substr(brstat.tlt.stat,1,250)       
        wdetail.n_text129      =  substr(brstat.tlt.subins,1,13)        
        wdetail.n_text130      =  substr(brstat.tlt.tel,1,10)        
        wdetail.n_text131      =  substr(brstat.tlt.tel2,1,150)      
        wdetail.n_text132      =  substr(brstat.tlt.tel3,1,15)       
        wdetail.n_text133      =  substr(brstat.tlt.usrid,1,250)       
        wdetail.n_text134      =  substr(brstat.tlt.usrsent,1,13)       
        wdetail.n_text135      =  substr(brstat.tlt.ln_product,1,10)     
        wdetail.n_text136      =  substr(brstat.tlt.ln_pronme,1,150)    
        wdetail.n_text137      =  substr(brstat.tlt.ln_rate,1,15)     
        wdetail.n_text138      =  substr(brstat.tlt.ln_st,1,250)    
        wdetail.n_text139      =  substr(brstat.tlt.lotno,1,13)    
        wdetail.n_text140      =  substr(brstat.tlt.maritalsts,1,10)    
        wdetail.n_text141      =  substr(brstat.tlt.campaign,1,12)    
        wdetail.n_text142      =  substr(brstat.tlt.mobile,1,10)    .  
         /* ADD BY : A68-0061 */
    ASSIGN 
    wdetail.typepol    =   brstat.tlt.poltyp
    wdetail.typecar    =   brstat.tlt.car_type
    wdetail.maksi      =   STRING(brstat.tlt.maksi)
    wdetail.drivexp1   =   brstat.tlt.dri_licenexp1
    wdetail.drivcon1   =   string(brstat.tlt.dri_consen1)
    wdetail.dlevel1    =   string(brstat.tlt.dri_level1)
    wdetail.dgender1   =   brstat.tlt.dri_gender1
    wdetail.drivexp2   =   brstat.tlt.dri_licenexp2
    wdetail.drivcon2   =   string(brstat.tlt.dri_consen2)
    wdetail.dlevel2    =   string(brstat.tlt.dri_level2)
    wdetail.dgender2   =   brstat.tlt.dri_gender2
    wdetail.ntitle3    =   brstat.tlt.dri_title3
    wdetail.dname3     =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,1,INDEX(brstat.tlt.dri_fname3," ") - 1) ELSE TRIM(brstat.tlt.dri_fname3)
    wdetail.dcname3    =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,R-INDEX(brstat.tlt.dri_fname3," ")) ELSE "" 
    wdetail.dlname3    =   brstat.tlt.dri_lname3
    wdetail.doccup3    =   brstat.tlt.dir_occ3
    wdetail.dbirth3    =   brstat.tlt.dri_birth3
    wdetail.dicno3     =   brstat.tlt.dri_ic3
    wdetail.ddriveno3  =   brstat.tlt.dri_lic3
    wdetail.drivexp3   =   brstat.tlt.dri_licenexp3
    wdetail.drivcon3   =   string(brstat.tlt.dri_consen3)
    wdetail.dlevel3    =   string(brstat.tlt.dri_level3)
    wdetail.dgender3   =   brstat.tlt.dri_gender3
    wdetail.ntitle4    =   brstat.tlt.dri_title4
    wdetail.dname4     =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,1,INDEX(brstat.tlt.dri_fname4," ") - 1) ELSE TRIM(brstat.tlt.dri_fname4)
    wdetail.dcname4    =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,R-INDEX(brstat.tlt.dri_fname4," ")) ELSE ""
    wdetail.dlname4    =   brstat.tlt.dri_lname4
    wdetail.doccup4    =   brstat.tlt.dri_occ4
    wdetail.dbirth4    =   brstat.tlt.dri_birth4
    wdetail.dicno4     =   brstat.tlt.dri_ic4
    wdetail.ddriveno4  =   brstat.tlt.dri_lic4
    wdetail.drivexp4   =   brstat.tlt.dri_licenexp4
    wdetail.drivcon4   =   string(brstat.tlt.dri_consen4)
    wdetail.dlevel4    =   string(brstat.tlt.dri_level4)
    wdetail.dgender4   =   brstat.tlt.dri_gender4
    wdetail.ntitle5    =   brstat.tlt.dri_title5
    wdetail.dname5     =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,1,INDEX(brstat.tlt.dri_fname5," ") - 1) ELSE TRIM(brstat.tlt.dri_fname5)
    wdetail.dcname5    =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,R-INDEX(brstat.tlt.dri_fname5," ")) ELSE "" 
    wdetail.dlname5    =   brstat.tlt.dri_lname5
    wdetail.doccup5    =   brstat.tlt.dri_occ5
    wdetail.dbirth5    =   brstat.tlt.dri_birth5
    wdetail.dicno5     =   brstat.tlt.dri_ic5
    wdetail.ddriveno5  =   brstat.tlt.dri_lic5
    wdetail.drivexp5   =   brstat.tlt.dri_licenexp5
    wdetail.drivcon5   =   string(brstat.tlt.dri_consen5)
    wdetail.dlevel5    =   string(brstat.tlt.dri_level5)
    wdetail.dgender5   =   brstat.tlt.dri_gender5  
    wdetail.chargflg    =  STRING(brstat.tlt.chargflg)
    wdetail.chargprice  =  STRING(brstat.tlt.chargsi)
    wdetail.chargno     =  brstat.tlt.chargno
    wdetail.chargprm    =  string(brstat.tlt.chargprem)
    wdetail.battflg     =  string(brstat.tlt.battflg  )
    wdetail.battprice   =  string(brstat.tlt.battprice)
    wdetail.battno      =  brstat.tlt.battno
    wdetail.battprm     =  string(brstat.tlt.battprem)
    wdetail.battdate    =  string(brstat.tlt.ndate1,"99/99/9999")
    wdetail.net_re1     =  string(brstat.tlt.dg_prem)
    wdetail.stam_re1    =  string(brstat.tlt.dg_rstp_t)
    wdetail.vat_re1     =  string(brstat.tlt.dg_rtax_t)
    wdetail.inscode_re2 =  brstat.tlt.ins_code
    wdetail.net_re2     =  string(brstat.tlt.dg_si  )
    wdetail.stam_re2    =  string(brstat.tlt.dg_rate)
    wdetail.vat_re2     =  string(brstat.tlt.dg_feet)
    wdetail.inscode_re3 =  brstat.tlt.Paycode
    wdetail.net_re3     =  string(brstat.tlt.dg_ncb  )
    wdetail.stam_re3    =  string(brstat.tlt.dg_disc )
    wdetail.vat_re3     =  string(brstat.tlt.dg_wdisc) .
 /* END : A68-0061 */
    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_repfielBRnoM2 c-wins 
PROCEDURE pd_repfielBRnoM2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wproducer NO-LOCK.
    For each tlt Use-index  tlt06 Where
        tlt.nor_effdat >=  fi_trndatfr        And
        tlt.nor_effdat <=  fi_trndatto        AND 
        tlt.genusr      =  "HCT"              And
        tlt.acno1       =  wproducer.producer AND
        tlt.ins_brins  <> "M"                 NO-LOCK 
        BREAK BY brstat.tlt.comp_noti_ins :
        IF      nv_typre = "V70" AND brstat.tlt.nor_usr_ins  = "0" THEN NEXT.
        ELSE IF nv_typre = "V72" AND brstat.tlt.nor_usr_ins <> "0" THEN NEXT.
        IF brstat.tlt.releas <> cb_reportstatus  THEN NEXT.
        CREATE  wdetail.
        ASSIGN 
        wdetail.n_text001      =  brstat.tlt.comp_noti_ins  
        wdetail.n_text002      =  brstat.tlt.comp_noti_tlt  
        wdetail.n_text003      =  brstat.tlt.comp_pol       
        wdetail.n_text004      =  string(brstat.tlt.nor_effdat,"99/99/9999")     
        wdetail.n_text005      =  string(brstat.tlt.comp_effdat,"99/99/9999")    
        wdetail.n_text006      =  brstat.tlt.comp_sub       
        wdetail.n_text007      =  brstat.tlt.cifno          
        wdetail.n_text008      =  brstat.tlt.nationality    
        wdetail.n_text009      =  brstat.tlt.nor_noti_ins   
        wdetail.n_text010      =  brstat.tlt.nor_noti_tlt   
        wdetail.n_text011      =  brstat.tlt.nor_usr_ins    
        wdetail.n_text012      =  brstat.tlt.covcod         
        wdetail.n_text013      =  brstat.tlt.nor_usr_tlt    
        wdetail.n_text014      =  brstat.tlt.comp_usr_ins   
        wdetail.n_text015      =  brstat.tlt.ins_title      
        wdetail.n_text016      =  brstat.tlt.ins_name       
        wdetail.n_text017      =  brstat.tlt.ins_firstname  
        wdetail.n_text018      =  brstat.tlt.ins_lastname   
        wdetail.n_text019      =  brstat.tlt.ins_addr       
        wdetail.n_text020      =  brstat.tlt.ins_addr1      
        wdetail.n_text021      =  brstat.tlt.ins_addr2      
        wdetail.n_text022      =  brstat.tlt.ins_addr3      
        wdetail.n_text023      =  brstat.tlt.lince2         
        wdetail.n_text024      =  brstat.tlt.ins_addr5      
        wdetail.n_text025      =  brstat.tlt.dir_occ1       
        wdetail.n_text026      =  brstat.tlt.note28         
        wdetail.n_text027      =  brstat.tlt.dri_ic1        
        wdetail.n_text028      =  brstat.tlt.dri_lic1       
        wdetail.n_text029      =  brstat.tlt.brand          
        wdetail.n_text030      =  substr(brstat.tlt.note10,1,1)         
        wdetail.n_text031      =  substr(brstat.tlt.cha_no,1,25)      
        wdetail.n_text032      =  substr(brstat.tlt.eng_no,1,20)                   
        wdetail.n_text033      =  substr(brstat.tlt.model,1,40)                 
        wdetail.n_text034      =  substr(brstat.tlt.note11,1,4)                  
        wdetail.n_text035      =  substr(brstat.tlt.note12,1,20)                  
        wdetail.n_text036      =  substr(brstat.tlt.note13,1,40)                  
        wdetail.n_text037      =  substr(brstat.tlt.note14,1,1)                   
        /*wdetail.n_text038      =  substr(brstat.tlt.vehuse,1,2) */ /* A68-0061*/
        wdetail.n_text038      =  IF rs_typre = 1 THEN substr(brstat.tlt.vehuse,1,2) ELSE TRIM(brstat.tlt.vehuse)  /* A68-0061*/                   
        wdetail.n_text039      =  string(brstat.tlt.seqno,"99")                        
        wdetail.n_text040      =  string(brstat.tlt.cc_weight,"9999")                  
        wdetail.n_text041      =  substr(brstat.tlt.colorcod,1,40)        
        wdetail.n_text042      =  substr(brstat.tlt.lince1,1,10)        
        wdetail.n_text043      =  substr(brstat.tlt.ins_addr4,1,30)        
        wdetail.n_text044      =  substr(brstat.tlt.note15,1,4)         
        wdetail.n_text045      =  substr(brstat.tlt.note16,1,512)              
        wdetail.n_text046      =  substr(brstat.tlt.note17,1,14)        
        wdetail.n_text047      =  substr(brstat.tlt.note18,1,14)       
        wdetail.n_text048      =  substr(brstat.tlt.note19,1,14)          
        wdetail.n_text049      =  substr(brstat.tlt.note2,1,14)          
        wdetail.n_text050      =  substr(brstat.tlt.note20,1,14)       
        wdetail.n_text051      =  substr(brstat.tlt.note21,1,14)          
        wdetail.n_text052      =  substr(brstat.tlt.note22,1,14)        
        wdetail.n_text053      =  substr(brstat.tlt.note23,1,14)        
        wdetail.n_text054      =  substr(brstat.tlt.comp_sck,1,20)        
        wdetail.n_text055      =  substr(brstat.tlt.note24,1,32)        
        wdetail.n_text056      =  substr(brstat.tlt.dri_no1,1,1)        
        wdetail.n_text057      =  substr(brstat.tlt.dri_no2,1,1)         
        wdetail.n_text058      =  substr(brstat.tlt.note25,1,20)      
        wdetail.n_text059      =  substr(brstat.tlt.dri_name1,1,80)      
        wdetail.n_text060      =  substr(brstat.tlt.note26,1,20)      
        wdetail.n_text061      =  substr(brstat.tlt.note27,1,60)      
        wdetail.n_text062      =  substr(brstat.tlt.dri_occ2,1,50)   
        wdetail.n_text063      =  substr(brstat.tlt.note4,1,10)         
        wdetail.n_text064      =  substr(brstat.tlt.dri_ic2,1,15)         
        wdetail.n_text065      =  substr(brstat.tlt.dri_lic2,1,15)         
        wdetail.n_text066      =  substr(brstat.tlt.note29,1,20)         
        wdetail.n_text067      =  substr(brstat.tlt.dri_name2,1,80)         
        wdetail.n_text068      =  substr(brstat.tlt.note3,1,20)         
        wdetail.n_text069      =  substr(brstat.tlt.note30,1,60)         
        wdetail.n_text070      =  substr(brstat.tlt.ins_occ,1,50)         
        wdetail.n_text071      =  IF brstat.tlt.birthdate = ? THEN "" ELSE string(brstat.tlt.birthdate,"99/99/9999")              
        wdetail.n_text072      =  substr(brstat.tlt.ins_icno,1,15)           
        wdetail.n_text073      =  substr(brstat.tlt.note1,1,15)                   
        wdetail.n_text074      =  substr(brstat.tlt.ben83,1,80)                   
        wdetail.n_text075      =  string(brstat.tlt.comp_coamt,"99999999999.99")      
        wdetail.n_text076      =  string(brstat.tlt.comp_grprm,"99999999999.99")      
        wdetail.n_text077      =  string(brstat.tlt.mileage,"99999999999.99")         
        wdetail.n_text078      =  string(brstat.tlt.ndeci1,"99999999999.99")          
        wdetail.n_text079      =  string(brstat.tlt.ndeci2,"99999999999.99")          
        wdetail.n_text080      =  string(brstat.tlt.ndeci3,"99999999999.99")          
        wdetail.n_text081      =  string(brstat.tlt.ndeci4,"99999999999.99")          
        wdetail.n_text082      =  string(brstat.tlt.ndeci5,"99999999999.99")          
        wdetail.n_text083      =  string(brstat.tlt.nor_coamt,"99")                    
        wdetail.n_text084      =  string(brstat.tlt.nor_grprm,"99999999999.99")       
        wdetail.n_text085      =  string(brstat.tlt.prem_amt,"99999999999.99")        
        wdetail.n_text086      =  string(brstat.tlt.prem_amttcop,"99")                 
        wdetail.n_text087      =  string(brstat.tlt.rstp,"99999999999.99")            
        wdetail.n_text088      =  string(brstat.tlt.rtax,"99999999999.99")            
        wdetail.n_text089      =  string(brstat.tlt.tax_coporate,"99999999999.99")    
        wdetail.n_text090      =  substr(brstat.tlt.note5,1,6)            
        wdetail.n_text091      =  substr(brstat.tlt.note6,1,10)        
        wdetail.n_text092      =  substr(brstat.tlt.note7,1,10)        
        wdetail.n_text093      =  substr(brstat.tlt.note8,1,30)        
        wdetail.n_text094      =  substr(brstat.tlt.note9,1,80)        
        wdetail.n_text095      =  substr(brstat.tlt.noteveh1,1,10)        
        wdetail.n_text096      =  substr(brstat.tlt.noteveh2,1,30)        
        wdetail.n_text097      =  substr(brstat.tlt.old_cha,1,12)        
        wdetail.n_text098      =  substr(brstat.tlt.old_eng,1,3)             
        wdetail.n_text099      =  substr(brstat.tlt.pack,1,10)      
        wdetail.n_text100      =  substr(brstat.tlt.packnme,1,14)      
        wdetail.n_text101      =  substr(brstat.tlt.period,1,10)      
        wdetail.n_text102      =  substr(brstat.tlt.ln_note1,1,14) 
        wdetail.n_text103      =  substr(brstat.tlt.product,1,10)   
        wdetail.n_text104      =  substr(brstat.tlt.projnme,1,14)   
        wdetail.n_text105      =  substr(brstat.tlt.proveh,1,10)   
        wdetail.n_text106      =  substr(brstat.tlt.race,1,14)   
        wdetail.n_text107      =  substr(brstat.tlt.recac,1,10)   
        wdetail.n_text108      =  substr(brstat.tlt.rec_addr,1,14)   
        wdetail.n_text109      =  substr(brstat.tlt.rec_addr1,1,15)   
        wdetail.n_text110      =  substr(brstat.tlt.rec_addr2,1,10)   
        wdetail.n_text111      =  substr(brstat.tlt.rec_addr3,1,14)   
        wdetail.n_text112      =  substr(brstat.tlt.rec_addr4,1,10)   
        wdetail.n_text113      =  substr(brstat.tlt.rec_addr5,1,20)   
        wdetail.n_text114      =  substr(brstat.tlt.rec_brins,1,1)         
        wdetail.n_text115      =  substr(brstat.tlt.rec_cou,1,120)      
        wdetail.n_text116      =  substr(brstat.tlt.rec_icno,1,100)      
        wdetail.n_text117      =  substr(brstat.tlt.rec_name,1,2)         
        wdetail.n_text118      =  substr(brstat.tlt.rec_name2,1,2)         
        wdetail.n_text119      =  substr(brstat.tlt.rec_note1,1,10)        
        wdetail.n_text120      =  substr(brstat.tlt.rec_note2,1,1)        
        wdetail.n_text121      =  substr(brstat.tlt.rec_title,1,10)        
        wdetail.n_text122      =  substr(brstat.tlt.rec_typ,1,255)       
        wdetail.n_text123      =  substr(brstat.tlt.rider,1,5)         
        wdetail.n_text124      =  substr(brstat.tlt.safe1,1,20)        
        wdetail.n_text125      =  substr(brstat.tlt.safe2,1,10)        
        wdetail.n_text126      =  substr(brstat.tlt.safe3,1,150)       
        wdetail.n_text127      =  substr(brstat.tlt.sex,1,15)        
        wdetail.n_text128      =  substr(brstat.tlt.stat,1,250)       
        wdetail.n_text129      =  substr(brstat.tlt.subins,1,13)        
        wdetail.n_text130      =  substr(brstat.tlt.tel,1,10)        
        wdetail.n_text131      =  substr(brstat.tlt.tel2,1,150)      
        wdetail.n_text132      =  substr(brstat.tlt.tel3,1,15)       
        wdetail.n_text133      =  substr(brstat.tlt.usrid,1,250)       
        wdetail.n_text134      =  substr(brstat.tlt.usrsent,1,13)       
        wdetail.n_text135      =  substr(brstat.tlt.ln_product,1,10)     
        wdetail.n_text136      =  substr(brstat.tlt.ln_pronme,1,150)    
        wdetail.n_text137      =  substr(brstat.tlt.ln_rate,1,15)     
        wdetail.n_text138      =  substr(brstat.tlt.ln_st,1,250)    
        wdetail.n_text139      =  substr(brstat.tlt.lotno,1,13)    
        wdetail.n_text140      =  substr(brstat.tlt.maritalsts,1,10)    
        wdetail.n_text141      =  substr(brstat.tlt.campaign,1,12)    
        wdetail.n_text142      =  substr(brstat.tlt.mobile,1,10)    . 
         /* ADD BY : A68-0061 */
    ASSIGN 
    wdetail.typepol    =   brstat.tlt.poltyp
    wdetail.typecar    =   brstat.tlt.car_type
    wdetail.maksi      =   STRING(brstat.tlt.maksi)
    wdetail.drivexp1   =   brstat.tlt.dri_licenexp1
    wdetail.drivcon1   =   string(brstat.tlt.dri_consen1)
    wdetail.dlevel1    =   string(brstat.tlt.dri_level1)
    wdetail.dgender1   =   brstat.tlt.dri_gender1
    wdetail.drivexp2   =   brstat.tlt.dri_licenexp2
    wdetail.drivcon2   =   string(brstat.tlt.dri_consen2)
    wdetail.dlevel2    =   string(brstat.tlt.dri_level2)
    wdetail.dgender2   =   brstat.tlt.dri_gender2
    wdetail.ntitle3    =   brstat.tlt.dri_title3
    wdetail.dname3     =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,1,INDEX(brstat.tlt.dri_fname3," ") - 1) ELSE TRIM(brstat.tlt.dri_fname3)
    wdetail.dcname3    =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,R-INDEX(brstat.tlt.dri_fname3," ")) ELSE "" 
    wdetail.dlname3    =   brstat.tlt.dri_lname3
    wdetail.doccup3    =   brstat.tlt.dir_occ3
    wdetail.dbirth3    =   brstat.tlt.dri_birth3
    wdetail.dicno3     =   brstat.tlt.dri_ic3
    wdetail.ddriveno3  =   brstat.tlt.dri_lic3
    wdetail.drivexp3   =   brstat.tlt.dri_licenexp3
    wdetail.drivcon3   =   string(brstat.tlt.dri_consen3)
    wdetail.dlevel3    =   string(brstat.tlt.dri_level3)
    wdetail.dgender3   =   brstat.tlt.dri_gender3
    wdetail.ntitle4    =   brstat.tlt.dri_title4
    wdetail.dname4     =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,1,INDEX(brstat.tlt.dri_fname4," ") - 1) ELSE TRIM(brstat.tlt.dri_fname4)
    wdetail.dcname4    =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,R-INDEX(brstat.tlt.dri_fname4," ")) ELSE ""
    wdetail.dlname4    =   brstat.tlt.dri_lname4
    wdetail.doccup4    =   brstat.tlt.dri_occ4
    wdetail.dbirth4    =   brstat.tlt.dri_birth4
    wdetail.dicno4     =   brstat.tlt.dri_ic4
    wdetail.ddriveno4  =   brstat.tlt.dri_lic4
    wdetail.drivexp4   =   brstat.tlt.dri_licenexp4
    wdetail.drivcon4   =   string(brstat.tlt.dri_consen4)
    wdetail.dlevel4    =   string(brstat.tlt.dri_level4)
    wdetail.dgender4   =   brstat.tlt.dri_gender4
    wdetail.ntitle5    =   brstat.tlt.dri_title5
    wdetail.dname5     =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,1,INDEX(brstat.tlt.dri_fname5," ") - 1) ELSE TRIM(brstat.tlt.dri_fname5)
    wdetail.dcname5    =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,R-INDEX(brstat.tlt.dri_fname5," ")) ELSE "" 
    wdetail.dlname5    =   brstat.tlt.dri_lname5
    wdetail.doccup5    =   brstat.tlt.dri_occ5
    wdetail.dbirth5    =   brstat.tlt.dri_birth5
    wdetail.dicno5     =   brstat.tlt.dri_ic5
    wdetail.ddriveno5  =   brstat.tlt.dri_lic5
    wdetail.drivexp5   =   brstat.tlt.dri_licenexp5
    wdetail.drivcon5   =   string(brstat.tlt.dri_consen5)
    wdetail.dlevel5    =   string(brstat.tlt.dri_level5)
    wdetail.dgender5   =   brstat.tlt.dri_gender5  
    wdetail.chargflg    =  STRING(brstat.tlt.chargflg)
    wdetail.chargprice  =  STRING(brstat.tlt.chargsi)
    wdetail.chargno     =  brstat.tlt.chargno
    wdetail.chargprm    =  string(brstat.tlt.chargprem)
    wdetail.battflg     =  string(brstat.tlt.battflg  )
    wdetail.battprice   =  string(brstat.tlt.battprice)
    wdetail.battno      =  brstat.tlt.battno
    wdetail.battprm     =  string(brstat.tlt.battprem)
    wdetail.battdate    =  string(brstat.tlt.ndate1,"99/99/9999")
    wdetail.net_re1     =  string(brstat.tlt.dg_prem)
    wdetail.stam_re1    =  string(brstat.tlt.dg_rstp_t)
    wdetail.vat_re1     =  string(brstat.tlt.dg_rtax_t)
    wdetail.inscode_re2 =  brstat.tlt.ins_code
    wdetail.net_re2     =  string(brstat.tlt.dg_si  )
    wdetail.stam_re2    =  string(brstat.tlt.dg_rate)
    wdetail.vat_re2     =  string(brstat.tlt.dg_feet)
    wdetail.inscode_re3 =  brstat.tlt.Paycode
    wdetail.net_re3     =  string(brstat.tlt.dg_ncb  )
    wdetail.stam_re3    =  string(brstat.tlt.dg_disc )
    wdetail.vat_re3     =  string(brstat.tlt.dg_wdisc) .
 /* END : A68-0061 */
    END.
END.
 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_repfielNew1 c-wins 
PROCEDURE pd_repfielNew1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
For each tlt Use-index  tlt06 Where
    tlt.nor_effdat >=  fi_trndatfr And
    tlt.nor_effdat <=  fi_trndatto AND 
    tlt.genusr      =  "HCT"       And
    tlt.rec_note2   = "N"          NO-LOCK 
    BREAK BY brstat.tlt.comp_noti_ins :

    IF      nv_typre = "V70" AND brstat.tlt.nor_usr_ins  = "0" THEN NEXT.
    ELSE IF nv_typre = "V72" AND brstat.tlt.nor_usr_ins <> "0" THEN NEXT.

    CREATE  wdetail.
    ASSIGN 
    wdetail.n_text001      =  brstat.tlt.comp_noti_ins  
    wdetail.n_text002      =  brstat.tlt.comp_noti_tlt  
    wdetail.n_text003      =  brstat.tlt.comp_pol       
    wdetail.n_text004      =  string(brstat.tlt.nor_effdat,"99/99/9999")     
    wdetail.n_text005      =  string(brstat.tlt.comp_effdat,"99/99/9999")    
    wdetail.n_text006      =  brstat.tlt.comp_sub       
    wdetail.n_text007      =  brstat.tlt.cifno          
    wdetail.n_text008      =  brstat.tlt.nationality    
    wdetail.n_text009      =  brstat.tlt.nor_noti_ins   
    wdetail.n_text010      =  brstat.tlt.nor_noti_tlt   
    wdetail.n_text011      =  brstat.tlt.nor_usr_ins    
    wdetail.n_text012      =  brstat.tlt.covcod         
    wdetail.n_text013      =  brstat.tlt.nor_usr_tlt    
    wdetail.n_text014      =  brstat.tlt.comp_usr_ins   
    wdetail.n_text015      =  brstat.tlt.ins_title      
    wdetail.n_text016      =  brstat.tlt.ins_name       
    wdetail.n_text017      =  brstat.tlt.ins_firstname  
    wdetail.n_text018      =  brstat.tlt.ins_lastname   
    wdetail.n_text019      =  brstat.tlt.ins_addr       
    wdetail.n_text020      =  brstat.tlt.ins_addr1      
    wdetail.n_text021      =  brstat.tlt.ins_addr2      
    wdetail.n_text022      =  brstat.tlt.ins_addr3      
    wdetail.n_text023      =  brstat.tlt.lince2         
    wdetail.n_text024      =  brstat.tlt.ins_addr5      
    wdetail.n_text025      =  brstat.tlt.dir_occ1       
    wdetail.n_text026      =  brstat.tlt.note28         
    wdetail.n_text027      =  brstat.tlt.dri_ic1        
    wdetail.n_text028      =  brstat.tlt.dri_lic1       
    wdetail.n_text029      =  brstat.tlt.brand          
    wdetail.n_text030      =  substr(brstat.tlt.note10,1,1)         
    wdetail.n_text031      =  substr(brstat.tlt.cha_no,1,25)      
    wdetail.n_text032      =  substr(brstat.tlt.eng_no,1,20)                   
    wdetail.n_text033      =  substr(brstat.tlt.model,1,40)                 
    wdetail.n_text034      =  substr(brstat.tlt.note11,1,4)                  
    wdetail.n_text035      =  substr(brstat.tlt.note12,1,20)                  
    wdetail.n_text036      =  substr(brstat.tlt.note13,1,40)                  
    wdetail.n_text037      =  substr(brstat.tlt.note14,1,1)                   
    /*wdetail.n_text038      =  substr(brstat.tlt.vehuse,1,2) */ /* A68-0061*/
    wdetail.n_text038      =  IF rs_typre = 1 THEN substr(brstat.tlt.vehuse,1,2) ELSE TRIM(brstat.tlt.vehuse)  /* A68-0061*/             
    wdetail.n_text039      =  string(brstat.tlt.seqno,"99")                        
    wdetail.n_text040      =  string(brstat.tlt.cc_weight,"9999")                  
    wdetail.n_text041      =  substr(brstat.tlt.colorcod,1,40)        
    wdetail.n_text042      =  substr(brstat.tlt.lince1,1,10)        
    wdetail.n_text043      =  substr(brstat.tlt.ins_addr4,1,30)        
    wdetail.n_text044      =  substr(brstat.tlt.note15,1,4)         
    wdetail.n_text045      =  substr(brstat.tlt.note16,1,512)              
    wdetail.n_text046      =  substr(brstat.tlt.note17,1,14)        
    wdetail.n_text047      =  substr(brstat.tlt.note18,1,14)       
    wdetail.n_text048      =  substr(brstat.tlt.note19,1,14)          
    wdetail.n_text049      =  substr(brstat.tlt.note2,1,14)          
    wdetail.n_text050      =  substr(brstat.tlt.note20,1,14)       
    wdetail.n_text051      =  substr(brstat.tlt.note21,1,14)          
    wdetail.n_text052      =  substr(brstat.tlt.note22,1,14)        
    wdetail.n_text053      =  substr(brstat.tlt.note23,1,14)        
    wdetail.n_text054      =  substr(brstat.tlt.comp_sck,1,20)        
    wdetail.n_text055      =  substr(brstat.tlt.note24,1,32)        
    wdetail.n_text056      =  substr(brstat.tlt.dri_no1,1,1)        
    wdetail.n_text057      =  substr(brstat.tlt.dri_no2,1,1)         
    wdetail.n_text058      =  substr(brstat.tlt.note25,1,20)      
    wdetail.n_text059      =  substr(brstat.tlt.dri_name1,1,80)      
    wdetail.n_text060      =  substr(brstat.tlt.note26,1,20)      
    wdetail.n_text061      =  substr(brstat.tlt.note27,1,60)      
    wdetail.n_text062      =  substr(brstat.tlt.dri_occ2,1,50)   
    wdetail.n_text063      =  substr(brstat.tlt.note4,1,10)         
    wdetail.n_text064      =  substr(brstat.tlt.dri_ic2,1,15)         
    wdetail.n_text065      =  substr(brstat.tlt.dri_lic2,1,15)         
    wdetail.n_text066      =  substr(brstat.tlt.note29,1,20)         
    wdetail.n_text067      =  substr(brstat.tlt.dri_name2,1,80)         
    wdetail.n_text068      =  substr(brstat.tlt.note3,1,20)         
    wdetail.n_text069      =  substr(brstat.tlt.note30,1,60)         
    wdetail.n_text070      =  substr(brstat.tlt.ins_occ,1,50)         
    wdetail.n_text071      =  IF brstat.tlt.birthdate = ? THEN "" ELSE string(brstat.tlt.birthdate,"99/99/9999")              
    wdetail.n_text072      =  substr(brstat.tlt.ins_icno,1,15)           
    wdetail.n_text073      =  substr(brstat.tlt.note1,1,15)                   
    wdetail.n_text074      =  substr(brstat.tlt.ben83,1,80)                   
    wdetail.n_text075      =  string(brstat.tlt.comp_coamt,"99999999999.99")      
    wdetail.n_text076      =  string(brstat.tlt.comp_grprm,"99999999999.99")      
    wdetail.n_text077      =     string(brstat.tlt.mileage,"99999999999.99")         
    wdetail.n_text078      =      string(brstat.tlt.ndeci1,"99999999999.99")          
    wdetail.n_text079      =      string(brstat.tlt.ndeci2,"99999999999.99")          
    wdetail.n_text080      =      string(brstat.tlt.ndeci3,"99999999999.99")          
    wdetail.n_text081      =      string(brstat.tlt.ndeci4,"99999999999.99")          
    wdetail.n_text082      =      string(brstat.tlt.ndeci5,"99999999999.99")          
    wdetail.n_text083      =   string(brstat.tlt.nor_coamt,"99")                    
    wdetail.n_text084      =   string(brstat.tlt.nor_grprm,"99999999999.99")       
    wdetail.n_text085      =    string(brstat.tlt.prem_amt,"99999999999.99")        
    wdetail.n_text086      = string(brstat.tlt.prem_amttcop,"99")                 
    wdetail.n_text087      =        string(brstat.tlt.rstp,"99999999999.99")            
    wdetail.n_text088      =        string(brstat.tlt.rtax,"99999999999.99")            
    wdetail.n_text089      = string(brstat.tlt.tax_coporate,"99999999999.99")    
    wdetail.n_text090      =  substr(brstat.tlt.note5,1,6)            
    wdetail.n_text091      =  substr(brstat.tlt.note6,1,10)        
    wdetail.n_text092      =  substr(brstat.tlt.note7,1,10)        
    wdetail.n_text093      =  substr(brstat.tlt.note8,1,30)        
    wdetail.n_text094      =  substr(brstat.tlt.note9,1,80)        
    wdetail.n_text095      =  substr(brstat.tlt.noteveh1,1,10)        
    wdetail.n_text096      =  substr(brstat.tlt.noteveh2,1,30)        
    wdetail.n_text097      =  substr(brstat.tlt.old_cha,1,12)        
    wdetail.n_text098      =  substr(brstat.tlt.old_eng,1,3)             
    wdetail.n_text099      =  substr(brstat.tlt.pack,1,10)      
    wdetail.n_text100      =  substr(brstat.tlt.packnme,1,14)      
    wdetail.n_text101      =  substr(brstat.tlt.period,1,10)      
    wdetail.n_text102      =  substr(brstat.tlt.ln_note1,1,14) 
    wdetail.n_text103      =  substr(brstat.tlt.product,1,10)   
    wdetail.n_text104      =  substr(brstat.tlt.projnme,1,14)   
    wdetail.n_text105      =  substr(brstat.tlt.proveh,1,10)   
    wdetail.n_text106      =  substr(brstat.tlt.race,1,14)   
    wdetail.n_text107      =  substr(brstat.tlt.recac,1,10)   
    wdetail.n_text108      =  substr(brstat.tlt.rec_addr,1,14)   
    wdetail.n_text109      =  substr(brstat.tlt.rec_addr1,1,15)   
    wdetail.n_text110      =  substr(brstat.tlt.rec_addr2,1,10)   
    wdetail.n_text111      =  substr(brstat.tlt.rec_addr3,1,14)   
    wdetail.n_text112      =  substr(brstat.tlt.rec_addr4,1,10)   
    wdetail.n_text113      =  substr(brstat.tlt.rec_addr5,1,20)   
    wdetail.n_text114      =  substr(brstat.tlt.rec_brins,1,1)         
    wdetail.n_text115      =  substr(brstat.tlt.rec_cou,1,120)      
    wdetail.n_text116      =  substr(brstat.tlt.rec_icno,1,100)      
    wdetail.n_text117      =  substr(brstat.tlt.rec_name,1,2)         
    wdetail.n_text118      =  substr(brstat.tlt.rec_name2,1,2)         
    wdetail.n_text119      =  substr(brstat.tlt.rec_note1,1,10)        
    wdetail.n_text120      =  substr(brstat.tlt.rec_note2,1,1)        
    wdetail.n_text121      =  substr(brstat.tlt.rec_title,1,10)        
    wdetail.n_text122      =  substr(brstat.tlt.rec_typ,1,255)       
    wdetail.n_text123      =  substr(brstat.tlt.rider,1,5)         
    wdetail.n_text124      =  substr(brstat.tlt.safe1,1,20)        
    wdetail.n_text125      =  substr(brstat.tlt.safe2,1,10)        
    wdetail.n_text126      =  substr(brstat.tlt.safe3,1,150)       
    wdetail.n_text127      =  substr(brstat.tlt.sex,1,15)        
    wdetail.n_text128      =  substr(brstat.tlt.stat,1,250)       
    wdetail.n_text129      =  substr(brstat.tlt.subins,1,13)        
    wdetail.n_text130      =  substr(brstat.tlt.tel,1,10)        
    wdetail.n_text131      =  substr(brstat.tlt.tel2,1,150)      
    wdetail.n_text132      =  substr(brstat.tlt.tel3,1,15)       
    wdetail.n_text133      =  substr(brstat.tlt.usrid,1,250)       
    wdetail.n_text134      =  substr(brstat.tlt.usrsent,1,13)       
    wdetail.n_text135      =  substr(brstat.tlt.ln_product,1,10)     
    wdetail.n_text136      =  substr(brstat.tlt.ln_pronme,1,150)    
    wdetail.n_text137      =  substr(brstat.tlt.ln_rate,1,15)     
    wdetail.n_text138      =  substr(brstat.tlt.ln_st,1,250)    
    wdetail.n_text139      =  substr(brstat.tlt.lotno,1,13)    
    wdetail.n_text140      =  substr(brstat.tlt.maritalsts,1,10)    
    wdetail.n_text141      =  substr(brstat.tlt.campaign,1,12)    
    wdetail.n_text142      =  substr(brstat.tlt.mobile,1,10)    .  
     /* ADD BY : A68-0061 */
    ASSIGN 
    wdetail.typepol    =   brstat.tlt.poltyp
    wdetail.typecar    =   brstat.tlt.car_type
    wdetail.maksi      =   STRING(brstat.tlt.maksi)
    wdetail.drivexp1   =   brstat.tlt.dri_licenexp1
    wdetail.drivcon1   =   string(brstat.tlt.dri_consen1)
    wdetail.dlevel1    =   string(brstat.tlt.dri_level1)
    wdetail.dgender1   =   brstat.tlt.dri_gender1
    wdetail.drivexp2   =   brstat.tlt.dri_licenexp2
    wdetail.drivcon2   =   string(brstat.tlt.dri_consen2)
    wdetail.dlevel2    =   string(brstat.tlt.dri_level2)
    wdetail.dgender2   =   brstat.tlt.dri_gender2
    wdetail.ntitle3    =   brstat.tlt.dri_title3
    wdetail.dname3     =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,1,INDEX(brstat.tlt.dri_fname3," ") - 1) ELSE TRIM(brstat.tlt.dri_fname3)
    wdetail.dcname3    =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,R-INDEX(brstat.tlt.dri_fname3," ")) ELSE "" 
    wdetail.dlname3    =   brstat.tlt.dri_lname3
    wdetail.doccup3    =   brstat.tlt.dir_occ3
    wdetail.dbirth3    =   brstat.tlt.dri_birth3
    wdetail.dicno3     =   brstat.tlt.dri_ic3
    wdetail.ddriveno3  =   brstat.tlt.dri_lic3
    wdetail.drivexp3   =   brstat.tlt.dri_licenexp3
    wdetail.drivcon3   =   string(brstat.tlt.dri_consen3)
    wdetail.dlevel3    =   string(brstat.tlt.dri_level3)
    wdetail.dgender3   =   brstat.tlt.dri_gender3
    wdetail.ntitle4    =   brstat.tlt.dri_title4
    wdetail.dname4     =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,1,INDEX(brstat.tlt.dri_fname4," ") - 1) ELSE TRIM(brstat.tlt.dri_fname4)
    wdetail.dcname4    =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,R-INDEX(brstat.tlt.dri_fname4," ")) ELSE ""
    wdetail.dlname4    =   brstat.tlt.dri_lname4
    wdetail.doccup4    =   brstat.tlt.dri_occ4
    wdetail.dbirth4    =   brstat.tlt.dri_birth4
    wdetail.dicno4     =   brstat.tlt.dri_ic4
    wdetail.ddriveno4  =   brstat.tlt.dri_lic4
    wdetail.drivexp4   =   brstat.tlt.dri_licenexp4
    wdetail.drivcon4   =   string(brstat.tlt.dri_consen4)
    wdetail.dlevel4    =   string(brstat.tlt.dri_level4)
    wdetail.dgender4   =   brstat.tlt.dri_gender4
    wdetail.ntitle5    =   brstat.tlt.dri_title5
    wdetail.dname5     =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,1,INDEX(brstat.tlt.dri_fname5," ") - 1) ELSE TRIM(brstat.tlt.dri_fname5)
    wdetail.dcname5    =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,R-INDEX(brstat.tlt.dri_fname5," ")) ELSE "" 
    wdetail.dlname5    =   brstat.tlt.dri_lname5
    wdetail.doccup5    =   brstat.tlt.dri_occ5
    wdetail.dbirth5    =   brstat.tlt.dri_birth5
    wdetail.dicno5     =   brstat.tlt.dri_ic5
    wdetail.ddriveno5  =   brstat.tlt.dri_lic5
    wdetail.drivexp5   =   brstat.tlt.dri_licenexp5
    wdetail.drivcon5   =   string(brstat.tlt.dri_consen5)
    wdetail.dlevel5    =   string(brstat.tlt.dri_level5)
    wdetail.dgender5   =   brstat.tlt.dri_gender5  
    wdetail.chargflg    =  STRING(brstat.tlt.chargflg)
    wdetail.chargprice  =  STRING(brstat.tlt.chargsi)
    wdetail.chargno     =  brstat.tlt.chargno
    wdetail.chargprm    =  string(brstat.tlt.chargprem)
    wdetail.battflg     =  string(brstat.tlt.battflg  )
    wdetail.battprice   =  string(brstat.tlt.battprice)
    wdetail.battno      =  brstat.tlt.battno
    wdetail.battprm     =  string(brstat.tlt.battprem)
    wdetail.battdate    =  string(brstat.tlt.ndate1,"99/99/9999")
    wdetail.net_re1     =  string(brstat.tlt.dg_prem)
    wdetail.stam_re1    =  string(brstat.tlt.dg_rstp_t)
    wdetail.vat_re1     =  string(brstat.tlt.dg_rtax_t)
    wdetail.inscode_re2 =  brstat.tlt.ins_code
    wdetail.net_re2     =  string(brstat.tlt.dg_si  )
    wdetail.stam_re2    =  string(brstat.tlt.dg_rate)
    wdetail.vat_re2     =  string(brstat.tlt.dg_feet)
    wdetail.inscode_re3 =  brstat.tlt.Paycode
    wdetail.net_re3     =  string(brstat.tlt.dg_ncb  )
    wdetail.stam_re3    =  string(brstat.tlt.dg_disc )
    wdetail.vat_re3     =  string(brstat.tlt.dg_wdisc) .
 /* END : A68-0061 */

END. 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_repfielNew2 c-wins 
PROCEDURE pd_repfielNew2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wproducer NO-LOCK.
    For each tlt Use-index  tlt06 Where
        tlt.nor_effdat >=  fi_trndatfr    And
        tlt.nor_effdat <=  fi_trndatto    AND 
        /*tlt.acno1    =  trim(fi_producer)  AND*/
        tlt.acno1      =  wproducer.producer  AND 
        tlt.genusr     =  "HCT"         And
        tlt.rec_note2  = "N"       NO-LOCK 
        BREAK BY brstat.tlt.comp_noti_ins :
        IF      nv_typre = "V70" AND brstat.tlt.nor_usr_ins  = "0" THEN NEXT.
        ELSE IF nv_typre = "V72" AND brstat.tlt.nor_usr_ins <> "0" THEN NEXT.
        CREATE  wdetail.
        ASSIGN 
        wdetail.n_text001      =  brstat.tlt.comp_noti_ins  
        wdetail.n_text002      =  brstat.tlt.comp_noti_tlt  
        wdetail.n_text003      =  brstat.tlt.comp_pol       
        wdetail.n_text004      =  string(brstat.tlt.nor_effdat,"99/99/9999")     
        wdetail.n_text005      =  string(brstat.tlt.comp_effdat,"99/99/9999")    
        wdetail.n_text006      =  brstat.tlt.comp_sub       
        wdetail.n_text007      =  brstat.tlt.cifno          
        wdetail.n_text008      =  brstat.tlt.nationality    
        wdetail.n_text009      =  brstat.tlt.nor_noti_ins   
        wdetail.n_text010      =  brstat.tlt.nor_noti_tlt   
        wdetail.n_text011      =  brstat.tlt.nor_usr_ins    
        wdetail.n_text012      =  brstat.tlt.covcod         
        wdetail.n_text013      =  brstat.tlt.nor_usr_tlt    
        wdetail.n_text014      =  brstat.tlt.comp_usr_ins   
        wdetail.n_text015      =  brstat.tlt.ins_title      
        wdetail.n_text016      =  brstat.tlt.ins_name       
        wdetail.n_text017      =  brstat.tlt.ins_firstname  
        wdetail.n_text018      =  brstat.tlt.ins_lastname   
        wdetail.n_text019      =  brstat.tlt.ins_addr       
        wdetail.n_text020      =  brstat.tlt.ins_addr1      
        wdetail.n_text021      =  brstat.tlt.ins_addr2      
        wdetail.n_text022      =  brstat.tlt.ins_addr3      
        wdetail.n_text023      =  brstat.tlt.lince2         
        wdetail.n_text024      =  brstat.tlt.ins_addr5      
        wdetail.n_text025      =  brstat.tlt.dir_occ1       
        wdetail.n_text026      =  brstat.tlt.note28         
        wdetail.n_text027      =  brstat.tlt.dri_ic1        
        wdetail.n_text028      =  brstat.tlt.dri_lic1       
        wdetail.n_text029      =  brstat.tlt.brand          
        wdetail.n_text030      =  substr(brstat.tlt.note10,1,1)         
        wdetail.n_text031      =  substr(brstat.tlt.cha_no,1,25)      
        wdetail.n_text032      =  substr(brstat.tlt.eng_no,1,20)                   
        wdetail.n_text033      =  substr(brstat.tlt.model,1,40)                 
        wdetail.n_text034      =  substr(brstat.tlt.note11,1,4)                  
        wdetail.n_text035      =  substr(brstat.tlt.note12,1,20)                  
        wdetail.n_text036      =  substr(brstat.tlt.note13,1,40)                  
        wdetail.n_text037      =  substr(brstat.tlt.note14,1,1)                   
        /*wdetail.n_text038      =  substr(brstat.tlt.vehuse,1,2) */ /* A68-0061*/
        wdetail.n_text038      =  IF rs_typre = 1 THEN substr(brstat.tlt.vehuse,1,2) ELSE TRIM(brstat.tlt.vehuse)  /* A68-0061*/                  
        wdetail.n_text039      =  string(brstat.tlt.seqno,"99")                        
        wdetail.n_text040      =  string(brstat.tlt.cc_weight,"9999")                  
        wdetail.n_text041      =  substr(brstat.tlt.colorcod,1,40)        
        wdetail.n_text042      =  substr(brstat.tlt.lince1,1,10)        
        wdetail.n_text043      =  substr(brstat.tlt.ins_addr4,1,30)        
        wdetail.n_text044      =  substr(brstat.tlt.note15,1,4)         
        wdetail.n_text045      =  substr(brstat.tlt.note16,1,512)              
        wdetail.n_text046      =  substr(brstat.tlt.note17,1,14)        
        wdetail.n_text047      =  substr(brstat.tlt.note18,1,14)       
        wdetail.n_text048      =  substr(brstat.tlt.note19,1,14)          
        wdetail.n_text049      =  substr(brstat.tlt.note2,1,14)          
        wdetail.n_text050      =  substr(brstat.tlt.note20,1,14)       
        wdetail.n_text051      =  substr(brstat.tlt.note21,1,14)          
        wdetail.n_text052      =  substr(brstat.tlt.note22,1,14)        
        wdetail.n_text053      =  substr(brstat.tlt.note23,1,14)        
        wdetail.n_text054      =  substr(brstat.tlt.comp_sck,1,20)        
        wdetail.n_text055      =  substr(brstat.tlt.note24,1,32)        
        wdetail.n_text056      =  substr(brstat.tlt.dri_no1,1,1)        
        wdetail.n_text057      =  substr(brstat.tlt.dri_no2,1,1)         
        wdetail.n_text058      =  substr(brstat.tlt.note25,1,20)      
        wdetail.n_text059      =  substr(brstat.tlt.dri_name1,1,80)      
        wdetail.n_text060      =  substr(brstat.tlt.note26,1,20)      
        wdetail.n_text061      =  substr(brstat.tlt.note27,1,60)      
        wdetail.n_text062      =  substr(brstat.tlt.dri_occ2,1,50)   
        wdetail.n_text063      =  substr(brstat.tlt.note4,1,10)         
        wdetail.n_text064      =  substr(brstat.tlt.dri_ic2,1,15)         
        wdetail.n_text065      =  substr(brstat.tlt.dri_lic2,1,15)         
        wdetail.n_text066      =  substr(brstat.tlt.note29,1,20)         
        wdetail.n_text067      =  substr(brstat.tlt.dri_name2,1,80)         
        wdetail.n_text068      =  substr(brstat.tlt.note3,1,20)         
        wdetail.n_text069      =  substr(brstat.tlt.note30,1,60)         
        wdetail.n_text070      =  substr(brstat.tlt.ins_occ,1,50)         
        wdetail.n_text071      =  IF brstat.tlt.birthdate = ? THEN "" ELSE string(brstat.tlt.birthdate,"99/99/9999")              
        wdetail.n_text072      =  substr(brstat.tlt.ins_icno,1,15)           
        wdetail.n_text073      =  substr(brstat.tlt.note1,1,15)                   
        wdetail.n_text074      =  substr(brstat.tlt.ben83,1,80)                   
        wdetail.n_text075      =  string(brstat.tlt.comp_coamt,"99999999999.99")      
        wdetail.n_text076      =  string(brstat.tlt.comp_grprm,"99999999999.99")      
        wdetail.n_text077      =     string(brstat.tlt.mileage,"99999999999.99")         
        wdetail.n_text078      =      string(brstat.tlt.ndeci1,"99999999999.99")          
        wdetail.n_text079      =      string(brstat.tlt.ndeci2,"99999999999.99")          
        wdetail.n_text080      =      string(brstat.tlt.ndeci3,"99999999999.99")          
        wdetail.n_text081      =      string(brstat.tlt.ndeci4,"99999999999.99")          
        wdetail.n_text082      =      string(brstat.tlt.ndeci5,"99999999999.99")          
        wdetail.n_text083      =   string(brstat.tlt.nor_coamt,"99")                    
        wdetail.n_text084      =   string(brstat.tlt.nor_grprm,"99999999999.99")       
        wdetail.n_text085      =    string(brstat.tlt.prem_amt,"99999999999.99")        
        wdetail.n_text086      = string(brstat.tlt.prem_amttcop,"99")                 
        wdetail.n_text087      =        string(brstat.tlt.rstp,"99999999999.99")            
        wdetail.n_text088      =        string(brstat.tlt.rtax,"99999999999.99")            
        wdetail.n_text089      = string(brstat.tlt.tax_coporate,"99999999999.99")    
        wdetail.n_text090      =  substr(brstat.tlt.note5,1,6)            
        wdetail.n_text091      =  substr(brstat.tlt.note6,1,10)        
        wdetail.n_text092      =  substr(brstat.tlt.note7,1,10)        
        wdetail.n_text093      =  substr(brstat.tlt.note8,1,30)        
        wdetail.n_text094      =  substr(brstat.tlt.note9,1,80)        
        wdetail.n_text095      =  substr(brstat.tlt.noteveh1,1,10)        
        wdetail.n_text096      =  substr(brstat.tlt.noteveh2,1,30)        
        wdetail.n_text097      =  substr(brstat.tlt.old_cha,1,12)        
        wdetail.n_text098      =  substr(brstat.tlt.old_eng,1,3)             
        wdetail.n_text099      =  substr(brstat.tlt.pack,1,10)      
        wdetail.n_text100      =  substr(brstat.tlt.packnme,1,14)      
        wdetail.n_text101      =  substr(brstat.tlt.period,1,10)      
        wdetail.n_text102      =  substr(brstat.tlt.ln_note1,1,14) 
        wdetail.n_text103      =  substr(brstat.tlt.product,1,10)   
        wdetail.n_text104      =  substr(brstat.tlt.projnme,1,14)   
        wdetail.n_text105      =  substr(brstat.tlt.proveh,1,10)   
        wdetail.n_text106      =  substr(brstat.tlt.race,1,14)   
        wdetail.n_text107      =  substr(brstat.tlt.recac,1,10)   
        wdetail.n_text108      =  substr(brstat.tlt.rec_addr,1,14)   
        wdetail.n_text109      =  substr(brstat.tlt.rec_addr1,1,15)   
        wdetail.n_text110      =  substr(brstat.tlt.rec_addr2,1,10)   
        wdetail.n_text111      =  substr(brstat.tlt.rec_addr3,1,14)   
        wdetail.n_text112      =  substr(brstat.tlt.rec_addr4,1,10)   
        wdetail.n_text113      =  substr(brstat.tlt.rec_addr5,1,20)   
        wdetail.n_text114      =  substr(brstat.tlt.rec_brins,1,1)         
        wdetail.n_text115      =  substr(brstat.tlt.rec_cou,1,120)      
        wdetail.n_text116      =  substr(brstat.tlt.rec_icno,1,100)      
        wdetail.n_text117      =  substr(brstat.tlt.rec_name,1,2)         
        wdetail.n_text118      =  substr(brstat.tlt.rec_name2,1,2)         
        wdetail.n_text119      =  substr(brstat.tlt.rec_note1,1,10)        
        wdetail.n_text120      =  substr(brstat.tlt.rec_note2,1,1)        
        wdetail.n_text121      =  substr(brstat.tlt.rec_title,1,10)        
        wdetail.n_text122      =  substr(brstat.tlt.rec_typ,1,255)       
        wdetail.n_text123      =  substr(brstat.tlt.rider,1,5)         
        wdetail.n_text124      =  substr(brstat.tlt.safe1,1,20)        
        wdetail.n_text125      =  substr(brstat.tlt.safe2,1,10)        
        wdetail.n_text126      =  substr(brstat.tlt.safe3,1,150)       
        wdetail.n_text127      =  substr(brstat.tlt.sex,1,15)        
        wdetail.n_text128      =  substr(brstat.tlt.stat,1,250)       
        wdetail.n_text129      =  substr(brstat.tlt.subins,1,13)        
        wdetail.n_text130      =  substr(brstat.tlt.tel,1,10)        
        wdetail.n_text131      =  substr(brstat.tlt.tel2,1,150)      
        wdetail.n_text132      =  substr(brstat.tlt.tel3,1,15)       
        wdetail.n_text133      =  substr(brstat.tlt.usrid,1,250)       
        wdetail.n_text134      =  substr(brstat.tlt.usrsent,1,13)       
        wdetail.n_text135      =  substr(brstat.tlt.ln_product,1,10)     
        wdetail.n_text136      =  substr(brstat.tlt.ln_pronme,1,150)    
        wdetail.n_text137      =  substr(brstat.tlt.ln_rate,1,15)     
        wdetail.n_text138      =  substr(brstat.tlt.ln_st,1,250)    
        wdetail.n_text139      =  substr(brstat.tlt.lotno,1,13)    
        wdetail.n_text140      =  substr(brstat.tlt.maritalsts,1,10)    
        wdetail.n_text141      =  substr(brstat.tlt.campaign,1,12)    
        wdetail.n_text142      =  substr(brstat.tlt.mobile,1,10)    .
         /* ADD BY : A68-0061 */
    ASSIGN 
    wdetail.typepol    =   brstat.tlt.poltyp
    wdetail.typecar    =   brstat.tlt.car_type
    wdetail.maksi      =   STRING(brstat.tlt.maksi)
    wdetail.drivexp1   =   brstat.tlt.dri_licenexp1
    wdetail.drivcon1   =   string(brstat.tlt.dri_consen1)
    wdetail.dlevel1    =   string(brstat.tlt.dri_level1)
    wdetail.dgender1   =   brstat.tlt.dri_gender1
    wdetail.drivexp2   =   brstat.tlt.dri_licenexp2
    wdetail.drivcon2   =   string(brstat.tlt.dri_consen2)
    wdetail.dlevel2    =   string(brstat.tlt.dri_level2)
    wdetail.dgender2   =   brstat.tlt.dri_gender2
    wdetail.ntitle3    =   brstat.tlt.dri_title3
    wdetail.dname3     =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,1,INDEX(brstat.tlt.dri_fname3," ") - 1) ELSE TRIM(brstat.tlt.dri_fname3)
    wdetail.dcname3    =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,R-INDEX(brstat.tlt.dri_fname3," ")) ELSE "" 
    wdetail.dlname3    =   brstat.tlt.dri_lname3
    wdetail.doccup3    =   brstat.tlt.dir_occ3
    wdetail.dbirth3    =   brstat.tlt.dri_birth3
    wdetail.dicno3     =   brstat.tlt.dri_ic3
    wdetail.ddriveno3  =   brstat.tlt.dri_lic3
    wdetail.drivexp3   =   brstat.tlt.dri_licenexp3
    wdetail.drivcon3   =   string(brstat.tlt.dri_consen3)
    wdetail.dlevel3    =   string(brstat.tlt.dri_level3)
    wdetail.dgender3   =   brstat.tlt.dri_gender3
    wdetail.ntitle4    =   brstat.tlt.dri_title4
    wdetail.dname4     =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,1,INDEX(brstat.tlt.dri_fname4," ") - 1) ELSE TRIM(brstat.tlt.dri_fname4)
    wdetail.dcname4    =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,R-INDEX(brstat.tlt.dri_fname4," ")) ELSE ""
    wdetail.dlname4    =   brstat.tlt.dri_lname4
    wdetail.doccup4    =   brstat.tlt.dri_occ4
    wdetail.dbirth4    =   brstat.tlt.dri_birth4
    wdetail.dicno4     =   brstat.tlt.dri_ic4
    wdetail.ddriveno4  =   brstat.tlt.dri_lic4
    wdetail.drivexp4   =   brstat.tlt.dri_licenexp4
    wdetail.drivcon4   =   string(brstat.tlt.dri_consen4)
    wdetail.dlevel4    =   string(brstat.tlt.dri_level4)
    wdetail.dgender4   =   brstat.tlt.dri_gender4
    wdetail.ntitle5    =   brstat.tlt.dri_title5
    wdetail.dname5     =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,1,INDEX(brstat.tlt.dri_fname5," ") - 1) ELSE TRIM(brstat.tlt.dri_fname5)
    wdetail.dcname5    =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,R-INDEX(brstat.tlt.dri_fname5," ")) ELSE "" 
    wdetail.dlname5    =   brstat.tlt.dri_lname5
    wdetail.doccup5    =   brstat.tlt.dri_occ5
    wdetail.dbirth5    =   brstat.tlt.dri_birth5
    wdetail.dicno5     =   brstat.tlt.dri_ic5
    wdetail.ddriveno5  =   brstat.tlt.dri_lic5
    wdetail.drivexp5   =   brstat.tlt.dri_licenexp5
    wdetail.drivcon5   =   string(brstat.tlt.dri_consen5)
    wdetail.dlevel5    =   string(brstat.tlt.dri_level5)
    wdetail.dgender5   =   brstat.tlt.dri_gender5  
    wdetail.chargflg    =  STRING(brstat.tlt.chargflg)
    wdetail.chargprice  =  STRING(brstat.tlt.chargsi)
    wdetail.chargno     =  brstat.tlt.chargno
    wdetail.chargprm    =  string(brstat.tlt.chargprem)
    wdetail.battflg     =  string(brstat.tlt.battflg  )
    wdetail.battprice   =  string(brstat.tlt.battprice)
    wdetail.battno      =  brstat.tlt.battno
    wdetail.battprm     =  string(brstat.tlt.battprem)
    wdetail.battdate    =  string(brstat.tlt.ndate1,"99/99/9999")
    wdetail.net_re1     =  string(brstat.tlt.dg_prem)
    wdetail.stam_re1    =  string(brstat.tlt.dg_rstp_t)
    wdetail.vat_re1     =  string(brstat.tlt.dg_rtax_t)
    wdetail.inscode_re2 =  brstat.tlt.ins_code
    wdetail.net_re2     =  string(brstat.tlt.dg_si  )
    wdetail.stam_re2    =  string(brstat.tlt.dg_rate)
    wdetail.vat_re2     =  string(brstat.tlt.dg_feet)
    wdetail.inscode_re3 =  brstat.tlt.Paycode
    wdetail.net_re3     =  string(brstat.tlt.dg_ncb  )
    wdetail.stam_re3    =  string(brstat.tlt.dg_disc )
    wdetail.vat_re3     =  string(brstat.tlt.dg_wdisc) .
 /* END : A68-0061 */
    END.
END. 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_repfielPro1 c-wins 
PROCEDURE pd_repfielPro1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*IF fi_report = "" THEN DO:
    MESSAGE "���� Producer �繤����ҧ " VIEW-AS ALERT-BOX.
END.
ELSE DO:
     
        For each tlt Use-index  tlt06 Where
            tlt.nor_effdat >=  fi_trndatfr     And
            tlt.nor_effdat <=  fi_trndatto     AND 
            tlt.genusr  =  "HCT"           And
            tlt.acno1   =  trim(fi_report) NO-LOCK  
            BREAK BY brstat.tlt.comp_noti_ins :
            IF      nv_typre = "V70" AND brstat.tlt.nor_usr_ins  = "0" THEN NEXT.
            ELSE IF nv_typre = "V72" AND brstat.tlt.nor_usr_ins <> "0" THEN NEXT.
            CREATE  wdetail.
            ASSIGN 
            wdetail.n_text001      =  brstat.tlt.comp_noti_ins  
            wdetail.n_text002      =  brstat.tlt.comp_noti_tlt  
            wdetail.n_text003      =  brstat.tlt.comp_pol       
            wdetail.n_text004      =  string(brstat.tlt.nor_effdat,"99/99/9999")     
            wdetail.n_text005      =  string(brstat.tlt.comp_effdat,"99/99/9999")    
            wdetail.n_text006      =  brstat.tlt.comp_sub       
            wdetail.n_text007      =  brstat.tlt.cifno          
            wdetail.n_text008      =  brstat.tlt.nationality    
            wdetail.n_text009      =  brstat.tlt.nor_noti_ins   
            wdetail.n_text010      =  brstat.tlt.nor_noti_tlt   
            wdetail.n_text011      =  brstat.tlt.nor_usr_ins    
            wdetail.n_text012      =  brstat.tlt.covcod         
            wdetail.n_text013      =  brstat.tlt.nor_usr_tlt    
            wdetail.n_text014      =  brstat.tlt.comp_usr_ins   
            wdetail.n_text015      =  brstat.tlt.ins_title      
            wdetail.n_text016      =  brstat.tlt.ins_name       
            wdetail.n_text017      =  brstat.tlt.ins_firstname  
            wdetail.n_text018      =  brstat.tlt.ins_lastname   
            wdetail.n_text019      =  brstat.tlt.ins_addr       
            wdetail.n_text020      =  brstat.tlt.ins_addr1      
            wdetail.n_text021      =  brstat.tlt.ins_addr2      
            wdetail.n_text022      =  brstat.tlt.ins_addr3      
            wdetail.n_text023      =  brstat.tlt.lince2         
            wdetail.n_text024      =  brstat.tlt.ins_addr5      
            wdetail.n_text025      =  brstat.tlt.dir_occ1       
            wdetail.n_text026      =  brstat.tlt.note28         
            wdetail.n_text027      =  brstat.tlt.dri_ic1        
            wdetail.n_text028      =  brstat.tlt.dri_lic1       
            wdetail.n_text029      =  brstat.tlt.brand          
            wdetail.n_text030      =  substr(brstat.tlt.note10,1,1)         
            wdetail.n_text031      =  substr(brstat.tlt.cha_no,1,25)      
            wdetail.n_text032      =  substr(brstat.tlt.eng_no,1,20)                   
            wdetail.n_text033      =  substr(brstat.tlt.model,1,40)                 
            wdetail.n_text034      =  substr(brstat.tlt.note11,1,4)                  
            wdetail.n_text035      =  substr(brstat.tlt.note12,1,20)                  
            wdetail.n_text036      =  substr(brstat.tlt.note13,1,40)                  
            wdetail.n_text037      =  substr(brstat.tlt.note14,1,1)                   
            wdetail.n_text038      =  substr(brstat.tlt.vehuse,1,2)                   
            wdetail.n_text039      =  string(brstat.tlt.seqno,"99")                        
            wdetail.n_text040      =  string(brstat.tlt.cc_weight,"9999")                  
            wdetail.n_text041      =  substr(brstat.tlt.colorcod,1,40)        
            wdetail.n_text042      =  substr(brstat.tlt.lince1,1,10)        
            wdetail.n_text043      =  substr(brstat.tlt.ins_addr4,1,30)        
            wdetail.n_text044      =  substr(brstat.tlt.note15,1,4)         
            wdetail.n_text045      =  substr(brstat.tlt.note16,1,512)              
            wdetail.n_text046      =  substr(brstat.tlt.note17,1,14)        
            wdetail.n_text047      =  substr(brstat.tlt.note18,1,14)       
            wdetail.n_text048      =  substr(brstat.tlt.note19,1,14)          
            wdetail.n_text049      =  substr(brstat.tlt.note2,1,14)          
            wdetail.n_text050      =  substr(brstat.tlt.note20,1,14)       
            wdetail.n_text051      =  substr(brstat.tlt.note21,1,14)          
            wdetail.n_text052      =  substr(brstat.tlt.note22,1,14)        
            wdetail.n_text053      =  substr(brstat.tlt.note23,1,14)        
            wdetail.n_text054      =  substr(brstat.tlt.comp_sck,1,20)        
            wdetail.n_text055      =  substr(brstat.tlt.note24,1,32)        
            wdetail.n_text056      =  substr(brstat.tlt.dri_no1,1,1)        
            wdetail.n_text057      =  substr(brstat.tlt.dri_no2,1,1)         
            wdetail.n_text058      =  substr(brstat.tlt.note25,1,20)      
            wdetail.n_text059      =  substr(brstat.tlt.dri_name1,1,80)      
            wdetail.n_text060      =  substr(brstat.tlt.note26,1,20)      
            wdetail.n_text061      =  substr(brstat.tlt.note27,1,60)      
            wdetail.n_text062      =  substr(brstat.tlt.dri_occ2,1,50)   
            wdetail.n_text063      =  substr(brstat.tlt.note4,1,10)         
            wdetail.n_text064      =  substr(brstat.tlt.dri_ic2,1,15)         
            wdetail.n_text065      =  substr(brstat.tlt.dri_lic2,1,15)         
            wdetail.n_text066      =  substr(brstat.tlt.note29,1,20)         
            wdetail.n_text067      =  substr(brstat.tlt.dri_name2,1,80)         
            wdetail.n_text068      =  substr(brstat.tlt.note3,1,20)         
            wdetail.n_text069      =  substr(brstat.tlt.note30,1,60)         
            wdetail.n_text070      =  substr(brstat.tlt.ins_occ,1,50)         
            wdetail.n_text071      =  IF brstat.tlt.birthdate = ? THEN "" ELSE string(brstat.tlt.birthdate,"99/99/9999")              
            wdetail.n_text072      =  substr(brstat.tlt.ins_icno,1,15)           
            wdetail.n_text073      =  substr(brstat.tlt.note1,1,15)                   
            wdetail.n_text074      =  substr(brstat.tlt.ben83,1,80)                   
            wdetail.n_text075      =  string(brstat.tlt.comp_coamt,"99999999999.99")      
            wdetail.n_text076      =  string(brstat.tlt.comp_grprm,"99999999999.99")      
            wdetail.n_text077      =     string(brstat.tlt.mileage,"99999999999.99")         
            wdetail.n_text078      =      string(brstat.tlt.ndeci1,"99999999999.99")          
            wdetail.n_text079      =      string(brstat.tlt.ndeci2,"99999999999.99")          
            wdetail.n_text080      =      string(brstat.tlt.ndeci3,"99999999999.99")          
            wdetail.n_text081      =      string(brstat.tlt.ndeci4,"99999999999.99")          
            wdetail.n_text082      =      string(brstat.tlt.ndeci5,"99999999999.99")          
            wdetail.n_text083      =   string(brstat.tlt.nor_coamt,"99")                    
            wdetail.n_text084      =   string(brstat.tlt.nor_grprm,"99999999999.99")       
            wdetail.n_text085      =    string(brstat.tlt.prem_amt,"99999999999.99")        
            wdetail.n_text086     = string(brstat.tlt.prem_amttcop,"99")                 
            wdetail.n_text087      =        string(brstat.tlt.rstp,"99999999999.99")            
            wdetail.n_text088      =        string(brstat.tlt.rtax,"99999999999.99")            
            wdetail.n_text089     = string(brstat.tlt.tax_coporate,"99999999999.99")    
            wdetail.n_text090      =  substr(brstat.tlt.note5,1,6)            
            wdetail.n_text091      =  substr(brstat.tlt.note6,1,10)        
            wdetail.n_text092      =  substr(brstat.tlt.note7,1,10)        
            wdetail.n_text093      =  substr(brstat.tlt.note8,1,30)        
            wdetail.n_text094      =  substr(brstat.tlt.note9,1,80)        
            wdetail.n_text095      =  substr(brstat.tlt.noteveh1,1,10)        
            wdetail.n_text096      =  substr(brstat.tlt.noteveh2,1,30)        
            wdetail.n_text097      =  substr(brstat.tlt.old_cha,1,12)        
            wdetail.n_text098      =  substr(brstat.tlt.old_eng,1,3)             
            wdetail.n_text099      =  substr(brstat.tlt.pack,1,10)      
            wdetail.n_text100      =  substr(brstat.tlt.packnme,1,14)      
            wdetail.n_text101      =  substr(brstat.tlt.period,1,10)      
            wdetail.n_text102      =  substr(brstat.tlt.ln_note1,1,14) 
            wdetail.n_text103      =  substr(brstat.tlt.product,1,10)   
            wdetail.n_text104      =  substr(brstat.tlt.projnme,1,14)   
            wdetail.n_text105      =  substr(brstat.tlt.proveh,1,10)   
            wdetail.n_text106      =  substr(brstat.tlt.race,1,14)   
            wdetail.n_text107      =  substr(brstat.tlt.recac,1,10)   
            wdetail.n_text108      =  substr(brstat.tlt.rec_addr,1,14)   
            wdetail.n_text109      =  substr(brstat.tlt.rec_addr1,1,15)   
            wdetail.n_text110      =  substr(brstat.tlt.rec_addr2,1,10)   
            wdetail.n_text111      =  substr(brstat.tlt.rec_addr3,1,14)   
            wdetail.n_text112      =  substr(brstat.tlt.rec_addr4,1,10)   
            wdetail.n_text113      =  substr(brstat.tlt.rec_addr5,1,20)   
            wdetail.n_text114      =  substr(brstat.tlt.rec_brins,1,1)         
            wdetail.n_text115      =  substr(brstat.tlt.rec_cou,1,120)      
            wdetail.n_text116      =  substr(brstat.tlt.rec_icno,1,100)      
            wdetail.n_text117      =  substr(brstat.tlt.rec_name,1,2)         
            wdetail.n_text118      =  substr(brstat.tlt.rec_name2,1,2)         
            wdetail.n_text119      =  substr(brstat.tlt.rec_note1,1,10)        
            wdetail.n_text120      =  substr(brstat.tlt.rec_note2,1,1)        
            wdetail.n_text121      =  substr(brstat.tlt.rec_title,1,10)        
            wdetail.n_text122      =  substr(brstat.tlt.rec_typ,1,255)       
            wdetail.n_text123      =  substr(brstat.tlt.rider,1,5)         
            wdetail.n_text124      =  substr(brstat.tlt.safe1,1,20)        
            wdetail.n_text125      =  substr(brstat.tlt.safe2,1,10)        
            wdetail.n_text126      =  substr(brstat.tlt.safe3,1,150)       
            wdetail.n_text127      =  substr(brstat.tlt.sex,1,15)        
            wdetail.n_text128      =  substr(brstat.tlt.stat,1,250)       
            wdetail.n_text129      =  substr(brstat.tlt.subins,1,13)        
            wdetail.n_text130      =  substr(brstat.tlt.tel,1,10)        
            wdetail.n_text131      =  substr(brstat.tlt.tel2,1,150)      
            wdetail.n_text132      =  substr(brstat.tlt.tel3,1,15)       
            wdetail.n_text133      =  substr(brstat.tlt.usrid,1,250)       
            wdetail.n_text134      =  substr(brstat.tlt.usrsent,1,13)       
            wdetail.n_text135      =  substr(brstat.tlt.ln_product,1,10)     
            wdetail.n_text136      =  substr(brstat.tlt.ln_pronme,1,150)    
            wdetail.n_text137      =  substr(brstat.tlt.ln_rate,1,15)     
            wdetail.n_text138      =  substr(brstat.tlt.ln_st,1,250)    
            wdetail.n_text139      =  substr(brstat.tlt.lotno,1,13)    
            wdetail.n_text140      =  substr(brstat.tlt.maritalsts,1,10)    
            wdetail.n_text141      =  substr(brstat.tlt.campaign,1,12)    
            wdetail.n_text142      =  substr(brstat.tlt.mobile,1,10)    . 
        END.
    
END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_repfielPro2 c-wins 
PROCEDURE pd_repfielPro2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF fi_producer = "" THEN DO:
    MESSAGE "���� Producer �繤����ҧ " VIEW-AS ALERT-BOX.
    
END.
ELSE DO:
    FOR EACH wproducer NO-LOCK.
        For each tlt Use-index  tlt06 Where
            tlt.nor_effdat >=  fi_trndatfr     And
            tlt.nor_effdat <=  fi_trndatto     AND 
            tlt.genusr   =  "HCT"              And
            /*tlt.acno1   =  trim(fi_report) NO-LOCK */
            tlt.acno1   =  wproducer.producer  NO-LOCK 
            BREAK BY brstat.tlt.comp_noti_ins :
            IF      nv_typre = "V70" AND brstat.tlt.nor_usr_ins  = "0" THEN NEXT.
            ELSE IF nv_typre = "V72" AND brstat.tlt.nor_usr_ins <> "0" THEN NEXT.
            CREATE  wdetail.
            ASSIGN 
            wdetail.n_text001      =  brstat.tlt.comp_noti_ins  
            wdetail.n_text002      =  brstat.tlt.comp_noti_tlt  
            wdetail.n_text003      =  brstat.tlt.comp_pol       
            wdetail.n_text004      =  string(brstat.tlt.nor_effdat,"99/99/9999")     
            wdetail.n_text005      =  string(brstat.tlt.comp_effdat,"99/99/9999")    
            wdetail.n_text006      =  brstat.tlt.comp_sub       
            wdetail.n_text007      =  brstat.tlt.cifno          
            wdetail.n_text008      =  brstat.tlt.nationality    
            wdetail.n_text009      =  brstat.tlt.nor_noti_ins   
            wdetail.n_text010      =  brstat.tlt.nor_noti_tlt   
            wdetail.n_text011      =  brstat.tlt.nor_usr_ins    
            wdetail.n_text012      =  brstat.tlt.covcod         
            wdetail.n_text013      =  brstat.tlt.nor_usr_tlt    
            wdetail.n_text014      =  brstat.tlt.comp_usr_ins   
            wdetail.n_text015      =  brstat.tlt.ins_title      
            wdetail.n_text016      =  brstat.tlt.ins_name       
            wdetail.n_text017      =  brstat.tlt.ins_firstname  
            wdetail.n_text018      =  brstat.tlt.ins_lastname   
            wdetail.n_text019      =  brstat.tlt.ins_addr       
            wdetail.n_text020      =  brstat.tlt.ins_addr1      
            wdetail.n_text021      =  brstat.tlt.ins_addr2      
            wdetail.n_text022      =  brstat.tlt.ins_addr3      
            wdetail.n_text023      =  brstat.tlt.lince2         
            wdetail.n_text024      =  brstat.tlt.ins_addr5      
            wdetail.n_text025      =  brstat.tlt.dir_occ1       
            wdetail.n_text026      =  brstat.tlt.note28         
            wdetail.n_text027      =  brstat.tlt.dri_ic1        
            wdetail.n_text028      =  brstat.tlt.dri_lic1       
            wdetail.n_text029      =  brstat.tlt.brand          
            wdetail.n_text030      =  substr(brstat.tlt.note10,1,1)         
            wdetail.n_text031      =  substr(brstat.tlt.cha_no,1,25)      
            wdetail.n_text032      =  substr(brstat.tlt.eng_no,1,20)                   
            wdetail.n_text033      =  substr(brstat.tlt.model,1,40)                 
            wdetail.n_text034      =  substr(brstat.tlt.note11,1,4)                  
            wdetail.n_text035      =  substr(brstat.tlt.note12,1,20)                  
            wdetail.n_text036      =  substr(brstat.tlt.note13,1,40)                  
            wdetail.n_text037      =  substr(brstat.tlt.note14,1,1)                   
            /*wdetail.n_text038      =  substr(brstat.tlt.vehuse,1,2) */ /* A68-0061*/
            wdetail.n_text038      =  IF rs_typre = 1 THEN substr(brstat.tlt.vehuse,1,2) ELSE TRIM(brstat.tlt.vehuse)  /* A68-0061*/                   
            wdetail.n_text039      =  string(brstat.tlt.seqno,"99")                        
            wdetail.n_text040      =  string(brstat.tlt.cc_weight,"9999")                  
            wdetail.n_text041      =  substr(brstat.tlt.colorcod,1,40)        
            wdetail.n_text042      =  substr(brstat.tlt.lince1,1,10)        
            wdetail.n_text043      =  substr(brstat.tlt.ins_addr4,1,30)        
            wdetail.n_text044      =  substr(brstat.tlt.note15,1,4)         
            wdetail.n_text045      =  substr(brstat.tlt.note16,1,512)              
            wdetail.n_text046      =  substr(brstat.tlt.note17,1,14)        
            wdetail.n_text047      =  substr(brstat.tlt.note18,1,14)       
            wdetail.n_text048      =  substr(brstat.tlt.note19,1,14)          
            wdetail.n_text049      =  substr(brstat.tlt.note2,1,14)          
            wdetail.n_text050      =  substr(brstat.tlt.note20,1,14)       
            wdetail.n_text051      =  substr(brstat.tlt.note21,1,14)          
            wdetail.n_text052      =  substr(brstat.tlt.note22,1,14)        
            wdetail.n_text053      =  substr(brstat.tlt.note23,1,14)        
            wdetail.n_text054      =  substr(brstat.tlt.comp_sck,1,20)        
            wdetail.n_text055      =  substr(brstat.tlt.note24,1,32)        
            wdetail.n_text056      =  substr(brstat.tlt.dri_no1,1,1)        
            wdetail.n_text057      =  substr(brstat.tlt.dri_no2,1,1)         
            wdetail.n_text058      =  substr(brstat.tlt.note25,1,20)      
            wdetail.n_text059      =  substr(brstat.tlt.dri_name1,1,80)      
            wdetail.n_text060      =  substr(brstat.tlt.note26,1,20)      
            wdetail.n_text061      =  substr(brstat.tlt.note27,1,60)      
            wdetail.n_text062      =  substr(brstat.tlt.dri_occ2,1,50)   
            wdetail.n_text063      =  substr(brstat.tlt.note4,1,10)         
            wdetail.n_text064      =  substr(brstat.tlt.dri_ic2,1,15)         
            wdetail.n_text065      =  substr(brstat.tlt.dri_lic2,1,15)         
            wdetail.n_text066      =  substr(brstat.tlt.note29,1,20)         
            wdetail.n_text067      =  substr(brstat.tlt.dri_name2,1,80)         
            wdetail.n_text068      =  substr(brstat.tlt.note3,1,20)         
            wdetail.n_text069      =  substr(brstat.tlt.note30,1,60)         
            wdetail.n_text070      =  substr(brstat.tlt.ins_occ,1,50)         
            wdetail.n_text071      =  IF brstat.tlt.birthdate = ? THEN "" ELSE string(brstat.tlt.birthdate,"99/99/9999")              
            wdetail.n_text072      =  substr(brstat.tlt.ins_icno,1,15)           
            wdetail.n_text073      =  substr(brstat.tlt.note1,1,15)                   
            wdetail.n_text074      =  substr(brstat.tlt.ben83,1,80)                   
            wdetail.n_text075      =  string(brstat.tlt.comp_coamt,"99999999999.99")      
            wdetail.n_text076      =  string(brstat.tlt.comp_grprm,"99999999999.99")      
            wdetail.n_text077      =     string(brstat.tlt.mileage,"99999999999.99")         
            wdetail.n_text078      =      string(brstat.tlt.ndeci1,"99999999999.99")          
            wdetail.n_text079      =      string(brstat.tlt.ndeci2,"99999999999.99")          
            wdetail.n_text080      =      string(brstat.tlt.ndeci3,"99999999999.99")          
            wdetail.n_text081      =      string(brstat.tlt.ndeci4,"99999999999.99")          
            wdetail.n_text082      =      string(brstat.tlt.ndeci5,"99999999999.99")          
            wdetail.n_text083      =   string(brstat.tlt.nor_coamt,"99")                    
            wdetail.n_text084      =   string(brstat.tlt.nor_grprm,"99999999999.99")       
            wdetail.n_text085      =    string(brstat.tlt.prem_amt,"99999999999.99")        
            wdetail.n_text086     = string(brstat.tlt.prem_amttcop,"99")                 
            wdetail.n_text087      =        string(brstat.tlt.rstp,"99999999999.99")            
            wdetail.n_text088      =        string(brstat.tlt.rtax,"99999999999.99")            
            wdetail.n_text089     = string(brstat.tlt.tax_coporate,"99999999999.99")    
            wdetail.n_text090      =  substr(brstat.tlt.note5,1,6)            
            wdetail.n_text091      =  substr(brstat.tlt.note6,1,10)        
            wdetail.n_text092      =  substr(brstat.tlt.note7,1,10)        
            wdetail.n_text093      =  substr(brstat.tlt.note8,1,30)        
            wdetail.n_text094      =  substr(brstat.tlt.note9,1,80)        
            wdetail.n_text095      =  substr(brstat.tlt.noteveh1,1,10)        
            wdetail.n_text096      =  substr(brstat.tlt.noteveh2,1,30)        
            wdetail.n_text097      =  substr(brstat.tlt.old_cha,1,12)        
            wdetail.n_text098      =  substr(brstat.tlt.old_eng,1,3)             
            wdetail.n_text099      =  substr(brstat.tlt.pack,1,10)      
            wdetail.n_text100      =  substr(brstat.tlt.packnme,1,14)      
            wdetail.n_text101      =  substr(brstat.tlt.period,1,10)      
            wdetail.n_text102      =  substr(brstat.tlt.ln_note1,1,14) 
            wdetail.n_text103      =  substr(brstat.tlt.product,1,10)   
            wdetail.n_text104      =  substr(brstat.tlt.projnme,1,14)   
            wdetail.n_text105      =  substr(brstat.tlt.proveh,1,10)   
            wdetail.n_text106      =  substr(brstat.tlt.race,1,14)   
            wdetail.n_text107      =  substr(brstat.tlt.recac,1,10)   
            wdetail.n_text108      =  substr(brstat.tlt.rec_addr,1,14)   
            wdetail.n_text109      =  substr(brstat.tlt.rec_addr1,1,15)   
            wdetail.n_text110      =  substr(brstat.tlt.rec_addr2,1,10)   
            wdetail.n_text111      =  substr(brstat.tlt.rec_addr3,1,14)   
            wdetail.n_text112      =  substr(brstat.tlt.rec_addr4,1,10)   
            wdetail.n_text113      =  substr(brstat.tlt.rec_addr5,1,20)   
            wdetail.n_text114      =  substr(brstat.tlt.rec_brins,1,1)         
            wdetail.n_text115      =  substr(brstat.tlt.rec_cou,1,120)      
            wdetail.n_text116      =  substr(brstat.tlt.rec_icno,1,100)      
            wdetail.n_text117      =  substr(brstat.tlt.rec_name,1,2)         
            wdetail.n_text118      =  substr(brstat.tlt.rec_name2,1,2)         
            wdetail.n_text119      =  substr(brstat.tlt.rec_note1,1,10)        
            wdetail.n_text120      =  substr(brstat.tlt.rec_note2,1,1)        
            wdetail.n_text121      =  substr(brstat.tlt.rec_title,1,10)        
            wdetail.n_text122      =  substr(brstat.tlt.rec_typ,1,255)       
            wdetail.n_text123      =  substr(brstat.tlt.rider,1,5)         
            wdetail.n_text124      =  substr(brstat.tlt.safe1,1,20)        
            wdetail.n_text125      =  substr(brstat.tlt.safe2,1,10)        
            wdetail.n_text126      =  substr(brstat.tlt.safe3,1,150)       
            wdetail.n_text127      =  substr(brstat.tlt.sex,1,15)        
            wdetail.n_text128      =  substr(brstat.tlt.stat,1,250)       
            wdetail.n_text129      =  substr(brstat.tlt.subins,1,13)        
            wdetail.n_text130      =  substr(brstat.tlt.tel,1,10)        
            wdetail.n_text131      =  substr(brstat.tlt.tel2,1,150)      
            wdetail.n_text132      =  substr(brstat.tlt.tel3,1,15)       
            wdetail.n_text133      =  substr(brstat.tlt.usrid,1,250)       
            wdetail.n_text134      =  substr(brstat.tlt.usrsent,1,13)       
            wdetail.n_text135      =  substr(brstat.tlt.ln_product,1,10)     
            wdetail.n_text136      =  substr(brstat.tlt.ln_pronme,1,150)    
            wdetail.n_text137      =  substr(brstat.tlt.ln_rate,1,15)     
            wdetail.n_text138      =  substr(brstat.tlt.ln_st,1,250)    
            wdetail.n_text139      =  substr(brstat.tlt.lotno,1,13)    
            wdetail.n_text140      =  substr(brstat.tlt.maritalsts,1,10)    
            wdetail.n_text141      =  substr(brstat.tlt.campaign,1,12)    
            wdetail.n_text142      =  substr(brstat.tlt.mobile,1,10)    . 
             /* ADD BY : A68-0061 */
            ASSIGN 
            wdetail.typepol    =   brstat.tlt.poltyp
            wdetail.typecar    =   brstat.tlt.car_type
            wdetail.maksi      =   STRING(brstat.tlt.maksi)
            wdetail.drivexp1   =   brstat.tlt.dri_licenexp1
            wdetail.drivcon1   =   string(brstat.tlt.dri_consen1)
            wdetail.dlevel1    =   string(brstat.tlt.dri_level1)
            wdetail.dgender1   =   brstat.tlt.dri_gender1
            wdetail.drivexp2   =   brstat.tlt.dri_licenexp2
            wdetail.drivcon2   =   string(brstat.tlt.dri_consen2)
            wdetail.dlevel2    =   string(brstat.tlt.dri_level2)
            wdetail.dgender2   =   brstat.tlt.dri_gender2
            wdetail.ntitle3    =   brstat.tlt.dri_title3
            wdetail.dname3     =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,1,INDEX(brstat.tlt.dri_fname3," ") - 1) ELSE TRIM(brstat.tlt.dri_fname3)
            wdetail.dcname3    =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,R-INDEX(brstat.tlt.dri_fname3," ")) ELSE "" 
            wdetail.dlname3    =   brstat.tlt.dri_lname3
            wdetail.doccup3    =   brstat.tlt.dir_occ3
            wdetail.dbirth3    =   brstat.tlt.dri_birth3
            wdetail.dicno3     =   brstat.tlt.dri_ic3
            wdetail.ddriveno3  =   brstat.tlt.dri_lic3
            wdetail.drivexp3   =   brstat.tlt.dri_licenexp3
            wdetail.drivcon3   =   string(brstat.tlt.dri_consen3)
            wdetail.dlevel3    =   string(brstat.tlt.dri_level3)
            wdetail.dgender3   =   brstat.tlt.dri_gender3
            wdetail.ntitle4    =   brstat.tlt.dri_title4
            wdetail.dname4     =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,1,INDEX(brstat.tlt.dri_fname4," ") - 1) ELSE TRIM(brstat.tlt.dri_fname4)
            wdetail.dcname4    =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,R-INDEX(brstat.tlt.dri_fname4," ")) ELSE ""
            wdetail.dlname4    =   brstat.tlt.dri_lname4
            wdetail.doccup4    =   brstat.tlt.dri_occ4
            wdetail.dbirth4    =   brstat.tlt.dri_birth4
            wdetail.dicno4     =   brstat.tlt.dri_ic4
            wdetail.ddriveno4  =   brstat.tlt.dri_lic4
            wdetail.drivexp4   =   brstat.tlt.dri_licenexp4
            wdetail.drivcon4   =   string(brstat.tlt.dri_consen4)
            wdetail.dlevel4    =   string(brstat.tlt.dri_level4)
            wdetail.dgender4   =   brstat.tlt.dri_gender4
            wdetail.ntitle5    =   brstat.tlt.dri_title5
            wdetail.dname5     =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,1,INDEX(brstat.tlt.dri_fname5," ") - 1) ELSE TRIM(brstat.tlt.dri_fname5)
            wdetail.dcname5    =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,R-INDEX(brstat.tlt.dri_fname5," ")) ELSE "" 
            wdetail.dlname5    =   brstat.tlt.dri_lname5
            wdetail.doccup5    =   brstat.tlt.dri_occ5
            wdetail.dbirth5    =   brstat.tlt.dri_birth5
            wdetail.dicno5     =   brstat.tlt.dri_ic5
            wdetail.ddriveno5  =   brstat.tlt.dri_lic5
            wdetail.drivexp5   =   brstat.tlt.dri_licenexp5
            wdetail.drivcon5   =   string(brstat.tlt.dri_consen5)
            wdetail.dlevel5    =   string(brstat.tlt.dri_level5)
            wdetail.dgender5   =   brstat.tlt.dri_gender5  
            wdetail.chargflg    =  STRING(brstat.tlt.chargflg)
            wdetail.chargprice  =  STRING(brstat.tlt.chargsi)
            wdetail.chargno     =  brstat.tlt.chargno
            wdetail.chargprm    =  string(brstat.tlt.chargprem)
            wdetail.battflg     =  string(brstat.tlt.battflg  )
            wdetail.battprice   =  string(brstat.tlt.battprice)
            wdetail.battno      =  brstat.tlt.battno
            wdetail.battprm     =  string(brstat.tlt.battprem)
            wdetail.battdate    =  string(brstat.tlt.ndate1,"99/99/9999")
            wdetail.net_re1     =  string(brstat.tlt.dg_prem)
            wdetail.stam_re1    =  string(brstat.tlt.dg_rstp_t)
            wdetail.vat_re1     =  string(brstat.tlt.dg_rtax_t)
            wdetail.inscode_re2 =  brstat.tlt.ins_code
            wdetail.net_re2     =  string(brstat.tlt.dg_si  )
            wdetail.stam_re2    =  string(brstat.tlt.dg_rate)
            wdetail.vat_re2     =  string(brstat.tlt.dg_feet)
            wdetail.inscode_re3 =  brstat.tlt.Paycode
            wdetail.net_re3     =  string(brstat.tlt.dg_ncb  )
            wdetail.stam_re3    =  string(brstat.tlt.dg_disc )
            wdetail.vat_re3     =  string(brstat.tlt.dg_wdisc) .
            /* END : A68-0061 */
        END.
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_repfielRenew1 c-wins 
PROCEDURE pd_repfielRenew1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

For each tlt Use-index  tlt06 Where
            tlt.nor_effdat >=  fi_trndatfr    And
            tlt.nor_effdat <=  fi_trndatto    AND 
            tlt.genusr   =  "HCT"         And
            tlt.rec_note2  = "R"       NO-LOCK 
    BREAK BY brstat.tlt.comp_noti_ins :

    IF      nv_typre = "V70" AND brstat.tlt.nor_usr_ins  = "0" THEN NEXT.
    ELSE IF nv_typre = "V72" AND brstat.tlt.nor_usr_ins <> "0" THEN NEXT.

    CREATE  wdetail.
    ASSIGN 
    wdetail.n_text001      =  brstat.tlt.comp_noti_ins  
    wdetail.n_text002      =  brstat.tlt.comp_noti_tlt  
    wdetail.n_text003      =  brstat.tlt.comp_pol       
    wdetail.n_text004      =  string(brstat.tlt.nor_effdat,"99/99/9999")     
    wdetail.n_text005      =  string(brstat.tlt.comp_effdat,"99/99/9999")    
    wdetail.n_text006      =  brstat.tlt.comp_sub       
    wdetail.n_text007      =  brstat.tlt.cifno          
    wdetail.n_text008      =  brstat.tlt.nationality    
    wdetail.n_text009      =  brstat.tlt.nor_noti_ins   
    wdetail.n_text010      =  brstat.tlt.nor_noti_tlt   
    wdetail.n_text011      =  brstat.tlt.nor_usr_ins    
    wdetail.n_text012      =  brstat.tlt.covcod         
    wdetail.n_text013      =  brstat.tlt.nor_usr_tlt    
    wdetail.n_text014      =  brstat.tlt.comp_usr_ins   
    wdetail.n_text015      =  brstat.tlt.ins_title      
    wdetail.n_text016      =  brstat.tlt.ins_name       
    wdetail.n_text017      =  brstat.tlt.ins_firstname  
    wdetail.n_text018      =  brstat.tlt.ins_lastname   
    wdetail.n_text019      =  brstat.tlt.ins_addr       
    wdetail.n_text020      =  brstat.tlt.ins_addr1      
    wdetail.n_text021      =  brstat.tlt.ins_addr2      
    wdetail.n_text022      =  brstat.tlt.ins_addr3      
    wdetail.n_text023      =  brstat.tlt.lince2         
    wdetail.n_text024      =  brstat.tlt.ins_addr5      
    wdetail.n_text025      =  brstat.tlt.dir_occ1       
    wdetail.n_text026      =  brstat.tlt.note28         
    wdetail.n_text027      =  brstat.tlt.dri_ic1        
    wdetail.n_text028      =  brstat.tlt.dri_lic1       
    wdetail.n_text029      =  brstat.tlt.brand          
    wdetail.n_text030      =  substr(brstat.tlt.note10,1,1)         
    wdetail.n_text031      =  substr(brstat.tlt.cha_no,1,25)      
    wdetail.n_text032      =  substr(brstat.tlt.eng_no,1,20)                   
    wdetail.n_text033      =  substr(brstat.tlt.model,1,40)                 
    wdetail.n_text034      =  substr(brstat.tlt.note11,1,4)                  
    wdetail.n_text035      =  substr(brstat.tlt.note12,1,20)                  
    wdetail.n_text036      =  substr(brstat.tlt.note13,1,40)                  
    wdetail.n_text037      =  substr(brstat.tlt.note14,1,1)                   
    /*wdetail.n_text038      =  substr(brstat.tlt.vehuse,1,2) */ /* A68-0061*/
    wdetail.n_text038      =  IF rs_typre = 1 THEN substr(brstat.tlt.vehuse,1,2) ELSE TRIM(brstat.tlt.vehuse)  /* A68-0061*/                   
    wdetail.n_text039      =  string(brstat.tlt.seqno,"99")                        
    wdetail.n_text040      =  string(brstat.tlt.cc_weight,"9999")                  
    wdetail.n_text041      =  substr(brstat.tlt.colorcod,1,40)        
    wdetail.n_text042      =  substr(brstat.tlt.lince1,1,10)        
    wdetail.n_text043      =  substr(brstat.tlt.ins_addr4,1,30)        
    wdetail.n_text044      =  substr(brstat.tlt.note15,1,4)         
    wdetail.n_text045      =  substr(brstat.tlt.note16,1,512)              
    wdetail.n_text046      =  substr(brstat.tlt.note17,1,14)        
    wdetail.n_text047      =  substr(brstat.tlt.note18,1,14)       
    wdetail.n_text048      =  substr(brstat.tlt.note19,1,14)          
    wdetail.n_text049      =  substr(brstat.tlt.note2,1,14)          
    wdetail.n_text050      =  substr(brstat.tlt.note20,1,14)       
    wdetail.n_text051      =  substr(brstat.tlt.note21,1,14)          
    wdetail.n_text052      =  substr(brstat.tlt.note22,1,14)        
    wdetail.n_text053      =  substr(brstat.tlt.note23,1,14)        
    wdetail.n_text054      =  substr(brstat.tlt.comp_sck,1,20)        
    wdetail.n_text055      =  substr(brstat.tlt.note24,1,32)        
    wdetail.n_text056      =  substr(brstat.tlt.dri_no1,1,1)        
    wdetail.n_text057      =  substr(brstat.tlt.dri_no2,1,1)         
    wdetail.n_text058      =  substr(brstat.tlt.note25,1,20)      
    wdetail.n_text059      =  substr(brstat.tlt.dri_name1,1,80)      
    wdetail.n_text060      =  substr(brstat.tlt.note26,1,20)      
    wdetail.n_text061      =  substr(brstat.tlt.note27,1,60)      
    wdetail.n_text062      =  substr(brstat.tlt.dri_occ2,1,50)   
    wdetail.n_text063      =  substr(brstat.tlt.note4,1,10)         
    wdetail.n_text064      =  substr(brstat.tlt.dri_ic2,1,15)         
    wdetail.n_text065      =  substr(brstat.tlt.dri_lic2,1,15)         
    wdetail.n_text066      =  substr(brstat.tlt.note29,1,20)         
    wdetail.n_text067      =  substr(brstat.tlt.dri_name2,1,80)         
    wdetail.n_text068      =  substr(brstat.tlt.note3,1,20)         
    wdetail.n_text069      =  substr(brstat.tlt.note30,1,60)         
    wdetail.n_text070      =  substr(brstat.tlt.ins_occ,1,50)         
    wdetail.n_text071      =  IF brstat.tlt.birthdate = ? THEN "" ELSE string(brstat.tlt.birthdate,"99/99/9999")              
    wdetail.n_text072      =  substr(brstat.tlt.ins_icno,1,15)           
    wdetail.n_text073      =  substr(brstat.tlt.note1,1,15)                   
    wdetail.n_text074      =  substr(brstat.tlt.ben83,1,80)                   
    wdetail.n_text075      =  string(brstat.tlt.comp_coamt,"99999999999.99")      
    wdetail.n_text076      =  string(brstat.tlt.comp_grprm,"99999999999.99")      
    wdetail.n_text077      =     string(brstat.tlt.mileage,"99999999999.99")         
    wdetail.n_text078      =      string(brstat.tlt.ndeci1,"99999999999.99")          
    wdetail.n_text079      =      string(brstat.tlt.ndeci2,"99999999999.99")          
    wdetail.n_text080      =      string(brstat.tlt.ndeci3,"99999999999.99")          
    wdetail.n_text081      =      string(brstat.tlt.ndeci4,"99999999999.99")          
    wdetail.n_text082      =      string(brstat.tlt.ndeci5,"99999999999.99")          
    wdetail.n_text083      =   string(brstat.tlt.nor_coamt,"99")                    
    wdetail.n_text084      =   string(brstat.tlt.nor_grprm,"99999999999.99")       
    wdetail.n_text085      =    string(brstat.tlt.prem_amt,"99999999999.99")        
    wdetail.n_text086     = string(brstat.tlt.prem_amttcop,"99")                 
    wdetail.n_text087      =        string(brstat.tlt.rstp,"99999999999.99")            
    wdetail.n_text088      =        string(brstat.tlt.rtax,"99999999999.99")            
    wdetail.n_text089     = string(brstat.tlt.tax_coporate,"99999999999.99")    
    wdetail.n_text090      =  substr(brstat.tlt.note5,1,6)            
    wdetail.n_text091      =  substr(brstat.tlt.note6,1,10)        
    wdetail.n_text092      =  substr(brstat.tlt.note7,1,10)        
    wdetail.n_text093      =  substr(brstat.tlt.note8,1,30)        
    wdetail.n_text094      =  substr(brstat.tlt.note9,1,80)        
    wdetail.n_text095      =  substr(brstat.tlt.noteveh1,1,10)        
    wdetail.n_text096      =  substr(brstat.tlt.noteveh2,1,30)        
    wdetail.n_text097      =  substr(brstat.tlt.old_cha,1,12)        
    wdetail.n_text098      =  substr(brstat.tlt.old_eng,1,3)             
    wdetail.n_text099      =  substr(brstat.tlt.pack,1,10)      
    wdetail.n_text100      =  substr(brstat.tlt.packnme,1,14)      
    wdetail.n_text101      =  substr(brstat.tlt.period,1,10)      
    wdetail.n_text102      =  substr(brstat.tlt.ln_note1,1,14) 
    wdetail.n_text103      =  substr(brstat.tlt.product,1,10)   
    wdetail.n_text104      =  substr(brstat.tlt.projnme,1,14)   
    wdetail.n_text105      =  substr(brstat.tlt.proveh,1,10)   
    wdetail.n_text106      =  substr(brstat.tlt.race,1,14)   
    wdetail.n_text107      =  substr(brstat.tlt.recac,1,10)   
    wdetail.n_text108      =  substr(brstat.tlt.rec_addr,1,14)   
    wdetail.n_text109      =  substr(brstat.tlt.rec_addr1,1,15)   
    wdetail.n_text110      =  substr(brstat.tlt.rec_addr2,1,10)   
    wdetail.n_text111      =  substr(brstat.tlt.rec_addr3,1,14)   
    wdetail.n_text112      =  substr(brstat.tlt.rec_addr4,1,10)   
    wdetail.n_text113      =  substr(brstat.tlt.rec_addr5,1,20)   
    wdetail.n_text114      =  substr(brstat.tlt.rec_brins,1,1)         
    wdetail.n_text115      =  substr(brstat.tlt.rec_cou,1,120)      
    wdetail.n_text116      =  substr(brstat.tlt.rec_icno,1,100)      
    wdetail.n_text117      =  substr(brstat.tlt.rec_name,1,2)         
    wdetail.n_text118      =  substr(brstat.tlt.rec_name2,1,2)         
    wdetail.n_text119      =  substr(brstat.tlt.rec_note1,1,10)        
    wdetail.n_text120      =  substr(brstat.tlt.rec_note2,1,1)        
    wdetail.n_text121      =  substr(brstat.tlt.rec_title,1,10)        
    wdetail.n_text122      =  substr(brstat.tlt.rec_typ,1,255)       
    wdetail.n_text123      =  substr(brstat.tlt.rider,1,5)         
    wdetail.n_text124      =  substr(brstat.tlt.safe1,1,20)        
    wdetail.n_text125      =  substr(brstat.tlt.safe2,1,10)        
    wdetail.n_text126      =  substr(brstat.tlt.safe3,1,150)       
    wdetail.n_text127      =  substr(brstat.tlt.sex,1,15)        
    wdetail.n_text128      =  substr(brstat.tlt.stat,1,250)       
    wdetail.n_text129      =  substr(brstat.tlt.subins,1,13)        
    wdetail.n_text130      =  substr(brstat.tlt.tel,1,10)        
    wdetail.n_text131      =  substr(brstat.tlt.tel2,1,150)      
    wdetail.n_text132      =  substr(brstat.tlt.tel3,1,15)       
    wdetail.n_text133      =  substr(brstat.tlt.usrid,1,250)       
    wdetail.n_text134      =  substr(brstat.tlt.usrsent,1,13)       
    wdetail.n_text135      =  substr(brstat.tlt.ln_product,1,10)     
    wdetail.n_text136      =  substr(brstat.tlt.ln_pronme,1,150)    
    wdetail.n_text137      =  substr(brstat.tlt.ln_rate,1,15)     
    wdetail.n_text138      =  substr(brstat.tlt.ln_st,1,250)    
    wdetail.n_text139      =  substr(brstat.tlt.lotno,1,13)    
    wdetail.n_text140      =  substr(brstat.tlt.maritalsts,1,10)    
    wdetail.n_text141      =  substr(brstat.tlt.campaign,1,12)    
    wdetail.n_text142      =  substr(brstat.tlt.mobile,1,10)    .  
     /* ADD BY : A68-0061 */
    ASSIGN 
    wdetail.typepol    =   brstat.tlt.poltyp
    wdetail.typecar    =   brstat.tlt.car_type
    wdetail.maksi      =   STRING(brstat.tlt.maksi)
    wdetail.drivexp1   =   brstat.tlt.dri_licenexp1
    wdetail.drivcon1   =   string(brstat.tlt.dri_consen1)
    wdetail.dlevel1    =   string(brstat.tlt.dri_level1)
    wdetail.dgender1   =   brstat.tlt.dri_gender1
    wdetail.drivexp2   =   brstat.tlt.dri_licenexp2
    wdetail.drivcon2   =   string(brstat.tlt.dri_consen2)
    wdetail.dlevel2    =   string(brstat.tlt.dri_level2)
    wdetail.dgender2   =   brstat.tlt.dri_gender2
    wdetail.ntitle3    =   brstat.tlt.dri_title3
    wdetail.dname3     =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,1,INDEX(brstat.tlt.dri_fname3," ") - 1) ELSE TRIM(brstat.tlt.dri_fname3)
    wdetail.dcname3    =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,R-INDEX(brstat.tlt.dri_fname3," ")) ELSE "" 
    wdetail.dlname3    =   brstat.tlt.dri_lname3
    wdetail.doccup3    =   brstat.tlt.dir_occ3
    wdetail.dbirth3    =   brstat.tlt.dri_birth3
    wdetail.dicno3     =   brstat.tlt.dri_ic3
    wdetail.ddriveno3  =   brstat.tlt.dri_lic3
    wdetail.drivexp3   =   brstat.tlt.dri_licenexp3
    wdetail.drivcon3   =   string(brstat.tlt.dri_consen3)
    wdetail.dlevel3    =   string(brstat.tlt.dri_level3)
    wdetail.dgender3   =   brstat.tlt.dri_gender3
    wdetail.ntitle4    =   brstat.tlt.dri_title4
    wdetail.dname4     =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,1,INDEX(brstat.tlt.dri_fname4," ") - 1) ELSE TRIM(brstat.tlt.dri_fname4)
    wdetail.dcname4    =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,R-INDEX(brstat.tlt.dri_fname4," ")) ELSE ""
    wdetail.dlname4    =   brstat.tlt.dri_lname4
    wdetail.doccup4    =   brstat.tlt.dri_occ4
    wdetail.dbirth4    =   brstat.tlt.dri_birth4
    wdetail.dicno4     =   brstat.tlt.dri_ic4
    wdetail.ddriveno4  =   brstat.tlt.dri_lic4
    wdetail.drivexp4   =   brstat.tlt.dri_licenexp4
    wdetail.drivcon4   =   string(brstat.tlt.dri_consen4)
    wdetail.dlevel4    =   string(brstat.tlt.dri_level4)
    wdetail.dgender4   =   brstat.tlt.dri_gender4
    wdetail.ntitle5    =   brstat.tlt.dri_title5
    wdetail.dname5     =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,1,INDEX(brstat.tlt.dri_fname5," ") - 1) ELSE TRIM(brstat.tlt.dri_fname5)
    wdetail.dcname5    =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,R-INDEX(brstat.tlt.dri_fname5," ")) ELSE "" 
    wdetail.dlname5    =   brstat.tlt.dri_lname5
    wdetail.doccup5    =   brstat.tlt.dri_occ5
    wdetail.dbirth5    =   brstat.tlt.dri_birth5
    wdetail.dicno5     =   brstat.tlt.dri_ic5
    wdetail.ddriveno5  =   brstat.tlt.dri_lic5
    wdetail.drivexp5   =   brstat.tlt.dri_licenexp5
    wdetail.drivcon5   =   string(brstat.tlt.dri_consen5)
    wdetail.dlevel5    =   string(brstat.tlt.dri_level5)
    wdetail.dgender5   =   brstat.tlt.dri_gender5  
    wdetail.chargflg    =  STRING(brstat.tlt.chargflg)
    wdetail.chargprice  =  STRING(brstat.tlt.chargsi)
    wdetail.chargno     =  brstat.tlt.chargno
    wdetail.chargprm    =  string(brstat.tlt.chargprem)
    wdetail.battflg     =  string(brstat.tlt.battflg  )
    wdetail.battprice   =  string(brstat.tlt.battprice)
    wdetail.battno      =  brstat.tlt.battno
    wdetail.battprm     =  string(brstat.tlt.battprem)
    wdetail.battdate    =  string(brstat.tlt.ndate1,"99/99/9999")
    wdetail.net_re1     =  string(brstat.tlt.dg_prem)
    wdetail.stam_re1    =  string(brstat.tlt.dg_rstp_t)
    wdetail.vat_re1     =  string(brstat.tlt.dg_rtax_t)
    wdetail.inscode_re2 =  brstat.tlt.ins_code
    wdetail.net_re2     =  string(brstat.tlt.dg_si  )
    wdetail.stam_re2    =  string(brstat.tlt.dg_rate)
    wdetail.vat_re2     =  string(brstat.tlt.dg_feet)
    wdetail.inscode_re3 =  brstat.tlt.Paycode
    wdetail.net_re3     =  string(brstat.tlt.dg_ncb  )
    wdetail.stam_re3    =  string(brstat.tlt.dg_disc )
    wdetail.vat_re3     =  string(brstat.tlt.dg_wdisc) .
 /* END : A68-0061 */
 
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_repfielRenew2 c-wins 
PROCEDURE pd_repfielRenew2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wproducer NO-LOCK.
    For each tlt Use-index  tlt06 Where
        tlt.nor_effdat >=  fi_trndatfr    And
        tlt.nor_effdat <=  fi_trndatto    AND 
        /*tlt.acno1     =  trim(fi_producer)  AND*/
        tlt.acno1       =  wproducer.producer  AND 
        tlt.genusr      =  "HCT"          And
        tlt.rec_note2   = "R"       NO-LOCK 
        BREAK BY brstat.tlt.comp_noti_ins :
        IF      nv_typre = "V70" AND brstat.tlt.nor_usr_ins  = "0" THEN NEXT.
        ELSE IF nv_typre = "V72" AND brstat.tlt.nor_usr_ins <> "0" THEN NEXT.
        CREATE  wdetail.
        ASSIGN 
        wdetail.n_text001      =  brstat.tlt.comp_noti_ins  
        wdetail.n_text002      =  brstat.tlt.comp_noti_tlt  
        wdetail.n_text003      =  brstat.tlt.comp_pol       
        wdetail.n_text004      =  string(brstat.tlt.nor_effdat,"99/99/9999")     
        wdetail.n_text005      =  string(brstat.tlt.comp_effdat,"99/99/9999")    
        wdetail.n_text006      =  brstat.tlt.comp_sub       
        wdetail.n_text007      =  brstat.tlt.cifno          
        wdetail.n_text008      =  brstat.tlt.nationality    
        wdetail.n_text009      =  brstat.tlt.nor_noti_ins   
        wdetail.n_text010      =  brstat.tlt.nor_noti_tlt   
        wdetail.n_text011      =  brstat.tlt.nor_usr_ins    
        wdetail.n_text012      =  brstat.tlt.covcod         
        wdetail.n_text013      =  brstat.tlt.nor_usr_tlt    
        wdetail.n_text014      =  brstat.tlt.comp_usr_ins   
        wdetail.n_text015      =  brstat.tlt.ins_title      
        wdetail.n_text016      =  brstat.tlt.ins_name       
        wdetail.n_text017      =  brstat.tlt.ins_firstname  
        wdetail.n_text018      =  brstat.tlt.ins_lastname   
        wdetail.n_text019      =  brstat.tlt.ins_addr       
        wdetail.n_text020      =  brstat.tlt.ins_addr1      
        wdetail.n_text021      =  brstat.tlt.ins_addr2      
        wdetail.n_text022      =  brstat.tlt.ins_addr3      
        wdetail.n_text023      =  brstat.tlt.lince2         
        wdetail.n_text024      =  brstat.tlt.ins_addr5      
        wdetail.n_text025      =  brstat.tlt.dir_occ1       
        wdetail.n_text026      =  brstat.tlt.note28         
        wdetail.n_text027      =  brstat.tlt.dri_ic1        
        wdetail.n_text028      =  brstat.tlt.dri_lic1       
        wdetail.n_text029      =  brstat.tlt.brand          
        wdetail.n_text030      =  substr(brstat.tlt.note10,1,1)         
        wdetail.n_text031      =  substr(brstat.tlt.cha_no,1,25)      
        wdetail.n_text032      =  substr(brstat.tlt.eng_no,1,20)                   
        wdetail.n_text033      =  substr(brstat.tlt.model,1,40)                 
        wdetail.n_text034      =  substr(brstat.tlt.note11,1,4)                  
        wdetail.n_text035      =  substr(brstat.tlt.note12,1,20)                  
        wdetail.n_text036      =  substr(brstat.tlt.note13,1,40)                  
        wdetail.n_text037      =  substr(brstat.tlt.note14,1,1)                   
        /*wdetail.n_text038      =  substr(brstat.tlt.vehuse,1,2) */ /* A68-0061*/
        wdetail.n_text038      =  IF rs_typre = 1 THEN substr(brstat.tlt.vehuse,1,2) ELSE TRIM(brstat.tlt.vehuse)  /* A68-0061*/                   
        wdetail.n_text039      =  string(brstat.tlt.seqno,"99")                        
        wdetail.n_text040      =  string(brstat.tlt.cc_weight,"9999")                  
        wdetail.n_text041      =  substr(brstat.tlt.colorcod,1,40)        
        wdetail.n_text042      =  substr(brstat.tlt.lince1,1,10)        
        wdetail.n_text043      =  substr(brstat.tlt.ins_addr4,1,30)        
        wdetail.n_text044      =  substr(brstat.tlt.note15,1,4)         
        wdetail.n_text045      =  substr(brstat.tlt.note16,1,512)              
        wdetail.n_text046      =  substr(brstat.tlt.note17,1,14)        
        wdetail.n_text047      =  substr(brstat.tlt.note18,1,14)       
        wdetail.n_text048      =  substr(brstat.tlt.note19,1,14)          
        wdetail.n_text049      =  substr(brstat.tlt.note2,1,14)          
        wdetail.n_text050      =  substr(brstat.tlt.note20,1,14)       
        wdetail.n_text051      =  substr(brstat.tlt.note21,1,14)          
        wdetail.n_text052      =  substr(brstat.tlt.note22,1,14)        
        wdetail.n_text053      =  substr(brstat.tlt.note23,1,14)        
        wdetail.n_text054      =  substr(brstat.tlt.comp_sck,1,20)        
        wdetail.n_text055      =  substr(brstat.tlt.note24,1,32)        
        wdetail.n_text056      =  substr(brstat.tlt.dri_no1,1,1)        
        wdetail.n_text057      =  substr(brstat.tlt.dri_no2,1,1)         
        wdetail.n_text058      =  substr(brstat.tlt.note25,1,20)      
        wdetail.n_text059      =  substr(brstat.tlt.dri_name1,1,80)      
        wdetail.n_text060      =  substr(brstat.tlt.note26,1,20)      
        wdetail.n_text061      =  substr(brstat.tlt.note27,1,60)      
        wdetail.n_text062      =  substr(brstat.tlt.dri_occ2,1,50)   
        wdetail.n_text063      =  substr(brstat.tlt.note4,1,10)         
        wdetail.n_text064      =  substr(brstat.tlt.dri_ic2,1,15)         
        wdetail.n_text065      =  substr(brstat.tlt.dri_lic2,1,15)         
        wdetail.n_text066      =  substr(brstat.tlt.note29,1,20)         
        wdetail.n_text067      =  substr(brstat.tlt.dri_name2,1,80)         
        wdetail.n_text068      =  substr(brstat.tlt.note3,1,20)         
        wdetail.n_text069      =  substr(brstat.tlt.note30,1,60)         
        wdetail.n_text070      =  substr(brstat.tlt.ins_occ,1,50)         
        wdetail.n_text071      =  IF brstat.tlt.birthdate = ? THEN "" ELSE string(brstat.tlt.birthdate,"99/99/9999")              
        wdetail.n_text072      =  substr(brstat.tlt.ins_icno,1,15)           
        wdetail.n_text073      =  substr(brstat.tlt.note1,1,15)                   
        wdetail.n_text074      =  substr(brstat.tlt.ben83,1,80)                   
        wdetail.n_text075      =  string(brstat.tlt.comp_coamt,"99999999999.99")      
        wdetail.n_text076      =  string(brstat.tlt.comp_grprm,"99999999999.99")      
        wdetail.n_text077      =  string(brstat.tlt.mileage,"99999999999.99")         
        wdetail.n_text078      =  string(brstat.tlt.ndeci1,"99999999999.99")          
        wdetail.n_text079      =  string(brstat.tlt.ndeci2,"99999999999.99")          
        wdetail.n_text080      =  string(brstat.tlt.ndeci3,"99999999999.99")          
        wdetail.n_text081      =  string(brstat.tlt.ndeci4,"99999999999.99")          
        wdetail.n_text082      =  string(brstat.tlt.ndeci5,"99999999999.99")          
        wdetail.n_text083      =  string(brstat.tlt.nor_coamt,"99")                    
        wdetail.n_text084      =  string(brstat.tlt.nor_grprm,"99999999999.99")       
        wdetail.n_text085      =  string(brstat.tlt.prem_amt,"99999999999.99")        
        wdetail.n_text086      =  string(brstat.tlt.prem_amttcop,"99")                 
        wdetail.n_text087      =  string(brstat.tlt.rstp,"99999999999.99")            
        wdetail.n_text088      =  string(brstat.tlt.rtax,"99999999999.99")            
        wdetail.n_text089      =  string(brstat.tlt.tax_coporate,"99999999999.99")    
        wdetail.n_text090      =  substr(brstat.tlt.note5,1,6)            
        wdetail.n_text091      =  substr(brstat.tlt.note6,1,10)        
        wdetail.n_text092      =  substr(brstat.tlt.note7,1,10)        
        wdetail.n_text093      =  substr(brstat.tlt.note8,1,30)        
        wdetail.n_text094      =  substr(brstat.tlt.note9,1,80)        
        wdetail.n_text095      =  substr(brstat.tlt.noteveh1,1,10)        
        wdetail.n_text096      =  substr(brstat.tlt.noteveh2,1,30)        
        wdetail.n_text097      =  substr(brstat.tlt.old_cha,1,12)        
        wdetail.n_text098      =  substr(brstat.tlt.old_eng,1,3)             
        wdetail.n_text099      =  substr(brstat.tlt.pack,1,10)      
        wdetail.n_text100      =  substr(brstat.tlt.packnme,1,14)      
        wdetail.n_text101      =  substr(brstat.tlt.period,1,10)      
        wdetail.n_text102      =  substr(brstat.tlt.ln_note1,1,14) 
        wdetail.n_text103      =  substr(brstat.tlt.product,1,10)   
        wdetail.n_text104      =  substr(brstat.tlt.projnme,1,14)   
        wdetail.n_text105      =  substr(brstat.tlt.proveh,1,10)   
        wdetail.n_text106      =  substr(brstat.tlt.race,1,14)   
        wdetail.n_text107      =  substr(brstat.tlt.recac,1,10)   
        wdetail.n_text108      =  substr(brstat.tlt.rec_addr,1,14)   
        wdetail.n_text109      =  substr(brstat.tlt.rec_addr1,1,15)   
        wdetail.n_text110      =  substr(brstat.tlt.rec_addr2,1,10)   
        wdetail.n_text111      =  substr(brstat.tlt.rec_addr3,1,14)   
        wdetail.n_text112      =  substr(brstat.tlt.rec_addr4,1,10)   
        wdetail.n_text113      =  substr(brstat.tlt.rec_addr5,1,20)   
        wdetail.n_text114      =  substr(brstat.tlt.rec_brins,1,1)         
        wdetail.n_text115      =  substr(brstat.tlt.rec_cou,1,120)      
        wdetail.n_text116      =  substr(brstat.tlt.rec_icno,1,100)      
        wdetail.n_text117      =  substr(brstat.tlt.rec_name,1,2)         
        wdetail.n_text118      =  substr(brstat.tlt.rec_name2,1,2)         
        wdetail.n_text119      =  substr(brstat.tlt.rec_note1,1,10)        
        wdetail.n_text120      =  substr(brstat.tlt.rec_note2,1,1)        
        wdetail.n_text121      =  substr(brstat.tlt.rec_title,1,10)        
        wdetail.n_text122      =  substr(brstat.tlt.rec_typ,1,255)       
        wdetail.n_text123      =  substr(brstat.tlt.rider,1,5)         
        wdetail.n_text124      =  substr(brstat.tlt.safe1,1,20)        
        wdetail.n_text125      =  substr(brstat.tlt.safe2,1,10)        
        wdetail.n_text126      =  substr(brstat.tlt.safe3,1,150)       
        wdetail.n_text127      =  substr(brstat.tlt.sex,1,15)        
        wdetail.n_text128      =  substr(brstat.tlt.stat,1,250)       
        wdetail.n_text129      =  substr(brstat.tlt.subins,1,13)        
        wdetail.n_text130      =  substr(brstat.tlt.tel,1,10)        
        wdetail.n_text131      =  substr(brstat.tlt.tel2,1,150)      
        wdetail.n_text132      =  substr(brstat.tlt.tel3,1,15)       
        wdetail.n_text133      =  substr(brstat.tlt.usrid,1,250)       
        wdetail.n_text134      =  substr(brstat.tlt.usrsent,1,13)       
        wdetail.n_text135      =  substr(brstat.tlt.ln_product,1,10)     
        wdetail.n_text136      =  substr(brstat.tlt.ln_pronme,1,150)    
        wdetail.n_text137      =  substr(brstat.tlt.ln_rate,1,15)     
        wdetail.n_text138      =  substr(brstat.tlt.ln_st,1,250)    
        wdetail.n_text139      =  substr(brstat.tlt.lotno,1,13)    
        wdetail.n_text140      =  substr(brstat.tlt.maritalsts,1,10)    
        wdetail.n_text141      =  substr(brstat.tlt.campaign,1,12)    
        wdetail.n_text142      =  substr(brstat.tlt.mobile,1,10)    .  
         /* ADD BY : A68-0061 */
        ASSIGN 
        wdetail.typepol    =   brstat.tlt.poltyp
        wdetail.typecar    =   brstat.tlt.car_type
        wdetail.maksi      =   STRING(brstat.tlt.maksi)
        wdetail.drivexp1   =   brstat.tlt.dri_licenexp1
        wdetail.drivcon1   =   string(brstat.tlt.dri_consen1)
        wdetail.dlevel1    =   string(brstat.tlt.dri_level1)
        wdetail.dgender1   =   brstat.tlt.dri_gender1
        wdetail.drivexp2   =   brstat.tlt.dri_licenexp2
        wdetail.drivcon2   =   string(brstat.tlt.dri_consen2)
        wdetail.dlevel2    =   string(brstat.tlt.dri_level2)
        wdetail.dgender2   =   brstat.tlt.dri_gender2
        wdetail.ntitle3    =   brstat.tlt.dri_title3
        wdetail.dname3     =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,1,INDEX(brstat.tlt.dri_fname3," ") - 1) ELSE TRIM(brstat.tlt.dri_fname3)
        wdetail.dcname3    =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,R-INDEX(brstat.tlt.dri_fname3," ")) ELSE "" 
        wdetail.dlname3    =   brstat.tlt.dri_lname3
        wdetail.doccup3    =   brstat.tlt.dir_occ3
        wdetail.dbirth3    =   brstat.tlt.dri_birth3
        wdetail.dicno3     =   brstat.tlt.dri_ic3
        wdetail.ddriveno3  =   brstat.tlt.dri_lic3
        wdetail.drivexp3   =   brstat.tlt.dri_licenexp3
        wdetail.drivcon3   =   string(brstat.tlt.dri_consen3)
        wdetail.dlevel3    =   string(brstat.tlt.dri_level3)
        wdetail.dgender3   =   brstat.tlt.dri_gender3
        wdetail.ntitle4    =   brstat.tlt.dri_title4
        wdetail.dname4     =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,1,INDEX(brstat.tlt.dri_fname4," ") - 1) ELSE TRIM(brstat.tlt.dri_fname4)
        wdetail.dcname4    =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,R-INDEX(brstat.tlt.dri_fname4," ")) ELSE ""
        wdetail.dlname4    =   brstat.tlt.dri_lname4
        wdetail.doccup4    =   brstat.tlt.dri_occ4
        wdetail.dbirth4    =   brstat.tlt.dri_birth4
        wdetail.dicno4     =   brstat.tlt.dri_ic4
        wdetail.ddriveno4  =   brstat.tlt.dri_lic4
        wdetail.drivexp4   =   brstat.tlt.dri_licenexp4
        wdetail.drivcon4   =   string(brstat.tlt.dri_consen4)
        wdetail.dlevel4    =   string(brstat.tlt.dri_level4)
        wdetail.dgender4   =   brstat.tlt.dri_gender4
        wdetail.ntitle5    =   brstat.tlt.dri_title5
        wdetail.dname5     =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,1,INDEX(brstat.tlt.dri_fname5," ") - 1) ELSE TRIM(brstat.tlt.dri_fname5)
        wdetail.dcname5    =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,R-INDEX(brstat.tlt.dri_fname5," ")) ELSE "" 
        wdetail.dlname5    =   brstat.tlt.dri_lname5
        wdetail.doccup5    =   brstat.tlt.dri_occ5
        wdetail.dbirth5    =   brstat.tlt.dri_birth5
        wdetail.dicno5     =   brstat.tlt.dri_ic5
        wdetail.ddriveno5  =   brstat.tlt.dri_lic5
        wdetail.drivexp5   =   brstat.tlt.dri_licenexp5
        wdetail.drivcon5   =   string(brstat.tlt.dri_consen5)
        wdetail.dlevel5    =   string(brstat.tlt.dri_level5)
        wdetail.dgender5   =   brstat.tlt.dri_gender5  
        wdetail.chargflg    =  STRING(brstat.tlt.chargflg)
        wdetail.chargprice  =  STRING(brstat.tlt.chargsi)
        wdetail.chargno     =  brstat.tlt.chargno
        wdetail.chargprm    =  string(brstat.tlt.chargprem)
        wdetail.battflg     =  string(brstat.tlt.battflg  )
        wdetail.battprice   =  string(brstat.tlt.battprice)
        wdetail.battno      =  brstat.tlt.battno
        wdetail.battprm     =  string(brstat.tlt.battprem)
        wdetail.battdate    =  string(brstat.tlt.ndate1,"99/99/9999")
        wdetail.net_re1     =  string(brstat.tlt.dg_prem)
        wdetail.stam_re1    =  string(brstat.tlt.dg_rstp_t)
        wdetail.vat_re1     =  string(brstat.tlt.dg_rtax_t)
        wdetail.inscode_re2 =  brstat.tlt.ins_code
        wdetail.net_re2     =  string(brstat.tlt.dg_si  )
        wdetail.stam_re2    =  string(brstat.tlt.dg_rate)
        wdetail.vat_re2     =  string(brstat.tlt.dg_feet)
        wdetail.inscode_re3 =  brstat.tlt.Paycode
        wdetail.net_re3     =  string(brstat.tlt.dg_ncb  )
        wdetail.stam_re3    =  string(brstat.tlt.dg_disc )
        wdetail.vat_re3     =  string(brstat.tlt.dg_wdisc) .
        /* END : A68-0061 */
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_repfielsts1 c-wins 
PROCEDURE pd_repfielsts1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
IF fi_report = "" THEN DO:
    MESSAGE "ʶҹ� �繤����ҧ " VIEW-AS ALERT-BOX.
    
END.
ELSE DO:
    
For each tlt Use-index  tlt06 Where
            tlt.nor_effdat >=  fi_trndatfr     And
            tlt.nor_effdat <=  fi_trndatto     AND 
            tlt.genusr  =  "HCT"           And
            brstat.tlt.releas =  trim(fi_report) NO-LOCK 
    BREAK BY brstat.tlt.comp_noti_ins :

    IF      nv_typre = "V70" AND brstat.tlt.nor_usr_ins  = "0" THEN NEXT.
    ELSE IF nv_typre = "V72" AND brstat.tlt.nor_usr_ins <> "0" THEN NEXT.
    
    CREATE  wdetail.
     
   ASSIGN 
  wdetail.n_text001      =  brstat.tlt.comp_noti_ins  
  wdetail.n_text002      =  brstat.tlt.comp_noti_tlt  
  wdetail.n_text003      =  brstat.tlt.comp_pol       
  wdetail.n_text004      =  string(brstat.tlt.nor_effdat,"99/99/9999")     
  wdetail.n_text005      =  string(brstat.tlt.comp_effdat,"99/99/9999")    
  wdetail.n_text006      =  brstat.tlt.comp_sub       
  wdetail.n_text007      =  brstat.tlt.cifno          
  wdetail.n_text008      =  brstat.tlt.nationality    
  wdetail.n_text009      =  brstat.tlt.nor_noti_ins   
  wdetail.n_text010      =  brstat.tlt.nor_noti_tlt   
  wdetail.n_text011      =  brstat.tlt.nor_usr_ins    
  wdetail.n_text012      =  brstat.tlt.covcod         
  wdetail.n_text013      =  brstat.tlt.nor_usr_tlt    
  wdetail.n_text014      =  brstat.tlt.comp_usr_ins   
  wdetail.n_text015      =  brstat.tlt.ins_title      
  wdetail.n_text016      =  brstat.tlt.ins_name       
  wdetail.n_text017      =  brstat.tlt.ins_firstname  
  wdetail.n_text018      =  brstat.tlt.ins_lastname   
  wdetail.n_text019      =  brstat.tlt.ins_addr       
  wdetail.n_text020      =  brstat.tlt.ins_addr1      
  wdetail.n_text021      =  brstat.tlt.ins_addr2      
  wdetail.n_text022      =  brstat.tlt.ins_addr3      
  wdetail.n_text023      =  brstat.tlt.lince2         
  wdetail.n_text024      =  brstat.tlt.ins_addr5      
  wdetail.n_text025      =  brstat.tlt.dir_occ1       
  wdetail.n_text026      =  brstat.tlt.note28         
  wdetail.n_text027      =  brstat.tlt.dri_ic1        
  wdetail.n_text028      =  brstat.tlt.dri_lic1       
  wdetail.n_text029      =  brstat.tlt.brand          
  wdetail.n_text030      =  substr(brstat.tlt.note10,1,1)         
  wdetail.n_text031      =  substr(brstat.tlt.cha_no,1,25)      
  wdetail.n_text032      =  substr(brstat.tlt.eng_no,1,20)                   
  wdetail.n_text033      =  substr(brstat.tlt.model,1,40)                 
  wdetail.n_text034      =  substr(brstat.tlt.note11,1,4)                  
  wdetail.n_text035      =  substr(brstat.tlt.note12,1,20)                  
  wdetail.n_text036      =  substr(brstat.tlt.note13,1,40)                  
  wdetail.n_text037      =  substr(brstat.tlt.note14,1,1)                   
  wdetail.n_text038      =  substr(brstat.tlt.vehuse,1,2)                   
  wdetail.n_text039      =  string(brstat.tlt.seqno,"99")                        
  wdetail.n_text040      =  string(brstat.tlt.cc_weight,"9999")                  
  wdetail.n_text041      =  substr(brstat.tlt.colorcod,1,40)        
  wdetail.n_text042      =  substr(brstat.tlt.lince1,1,10)        
  wdetail.n_text043      =  substr(brstat.tlt.ins_addr4,1,30)        
  wdetail.n_text044      =  substr(brstat.tlt.note15,1,4)         
  wdetail.n_text045      =  substr(brstat.tlt.note16,1,512)              
  wdetail.n_text046      =  substr(brstat.tlt.note17,1,14)        
  wdetail.n_text047      =  substr(brstat.tlt.note18,1,14)       
  wdetail.n_text048      =  substr(brstat.tlt.note19,1,14)          
  wdetail.n_text049      =  substr(brstat.tlt.note2,1,14)          
  wdetail.n_text050      =  substr(brstat.tlt.note20,1,14)       
  wdetail.n_text051      =  substr(brstat.tlt.note21,1,14)          
  wdetail.n_text052      =  substr(brstat.tlt.note22,1,14)        
  wdetail.n_text053      =  substr(brstat.tlt.note23,1,14)        
  wdetail.n_text054      =  substr(brstat.tlt.comp_sck,1,20)        
  wdetail.n_text055      =  substr(brstat.tlt.note24,1,32)        
  wdetail.n_text056      =  substr(brstat.tlt.dri_no1,1,1)        
  wdetail.n_text057      =  substr(brstat.tlt.dri_no2,1,1)         
  wdetail.n_text058      =  substr(brstat.tlt.note25,1,20)      
  wdetail.n_text059      =  substr(brstat.tlt.dri_name1,1,80)      
  wdetail.n_text060      =  substr(brstat.tlt.note26,1,20)      
  wdetail.n_text061      =  substr(brstat.tlt.note27,1,60)      
  wdetail.n_text062      =  substr(brstat.tlt.dri_occ2,1,50)   
  wdetail.n_text063      =  substr(brstat.tlt.note4,1,10)         
  wdetail.n_text064      =  substr(brstat.tlt.dri_ic2,1,15)         
  wdetail.n_text065      =  substr(brstat.tlt.dri_lic2,1,15)         
  wdetail.n_text066      =  substr(brstat.tlt.note29,1,20)         
  wdetail.n_text067      =  substr(brstat.tlt.dri_name2,1,80)         
  wdetail.n_text068      =  substr(brstat.tlt.note3,1,20)         
  wdetail.n_text069      =  substr(brstat.tlt.note30,1,60)         
  wdetail.n_text070      =  substr(brstat.tlt.ins_occ,1,50)         
  wdetail.n_text071      =  IF brstat.tlt.birthdate = ? THEN "" ELSE string(brstat.tlt.birthdate,"99/99/9999")              
  wdetail.n_text072      =  substr(brstat.tlt.ins_icno,1,15)           
  wdetail.n_text073      =  substr(brstat.tlt.note1,1,15)                   
  wdetail.n_text074      =  substr(brstat.tlt.ben83,1,80)                   
  wdetail.n_text075      =  string(brstat.tlt.comp_coamt,"99999999999.99")      
  wdetail.n_text076      =  string(brstat.tlt.comp_grprm,"99999999999.99")      
  wdetail.n_text077      =     string(brstat.tlt.mileage,"99999999999.99")         
  wdetail.n_text078      =      string(brstat.tlt.ndeci1,"99999999999.99")          
  wdetail.n_text079      =      string(brstat.tlt.ndeci2,"99999999999.99")          
  wdetail.n_text080      =      string(brstat.tlt.ndeci3,"99999999999.99")          
  wdetail.n_text081      =      string(brstat.tlt.ndeci4,"99999999999.99")          
  wdetail.n_text082      =      string(brstat.tlt.ndeci5,"99999999999.99")          
  wdetail.n_text083      =   string(brstat.tlt.nor_coamt,"99")                    
  wdetail.n_text084      =   string(brstat.tlt.nor_grprm,"99999999999.99")       
  wdetail.n_text085      =    string(brstat.tlt.prem_amt,"99999999999.99")        
  wdetail.n_text086     = string(brstat.tlt.prem_amttcop,"99")                 
  wdetail.n_text087      =        string(brstat.tlt.rstp,"99999999999.99")            
  wdetail.n_text088      =        string(brstat.tlt.rtax,"99999999999.99")            
  wdetail.n_text089     = string(brstat.tlt.tax_coporate,"99999999999.99")    
  wdetail.n_text090      =  substr(brstat.tlt.note5,1,6)            
  wdetail.n_text091      =  substr(brstat.tlt.note6,1,10)        
  wdetail.n_text092      =  substr(brstat.tlt.note7,1,10)        
  wdetail.n_text093      =  substr(brstat.tlt.note8,1,30)        
  wdetail.n_text094      =  substr(brstat.tlt.note9,1,80)        
  wdetail.n_text095      =  substr(brstat.tlt.noteveh1,1,10)        
  wdetail.n_text096      =  substr(brstat.tlt.noteveh2,1,30)        
  wdetail.n_text097      =  substr(brstat.tlt.old_cha,1,12)        
  wdetail.n_text098      =  substr(brstat.tlt.old_eng,1,3)             
  wdetail.n_text099      =  substr(brstat.tlt.pack,1,10)      
  wdetail.n_text100      =  substr(brstat.tlt.packnme,1,14)      
  wdetail.n_text101      =  substr(brstat.tlt.period,1,10)      
  wdetail.n_text102      =  substr(brstat.tlt.ln_note1,1,14) 
  wdetail.n_text103      =  substr(brstat.tlt.product,1,10)   
  wdetail.n_text104      =  substr(brstat.tlt.projnme,1,14)   
  wdetail.n_text105      =  substr(brstat.tlt.proveh,1,10)   
  wdetail.n_text106      =  substr(brstat.tlt.race,1,14)   
  wdetail.n_text107      =  substr(brstat.tlt.recac,1,10)   
  wdetail.n_text108      =  substr(brstat.tlt.rec_addr,1,14)   
  wdetail.n_text109      =  substr(brstat.tlt.rec_addr1,1,15)   
  wdetail.n_text110      =  substr(brstat.tlt.rec_addr2,1,10)   
  wdetail.n_text111      =  substr(brstat.tlt.rec_addr3,1,14)   
  wdetail.n_text112      =  substr(brstat.tlt.rec_addr4,1,10)   
  wdetail.n_text113      =  substr(brstat.tlt.rec_addr5,1,20)   
  wdetail.n_text114      =  substr(brstat.tlt.rec_brins,1,1)         
  wdetail.n_text115      =  substr(brstat.tlt.rec_cou,1,120)      
  wdetail.n_text116      =  substr(brstat.tlt.rec_icno,1,100)      
  wdetail.n_text117      =  substr(brstat.tlt.rec_name,1,2)         
  wdetail.n_text118      =  substr(brstat.tlt.rec_name2,1,2)         
  wdetail.n_text119      =  substr(brstat.tlt.rec_note1,1,10)        
  wdetail.n_text120      =  substr(brstat.tlt.rec_note2,1,1)        
  wdetail.n_text121      =  substr(brstat.tlt.rec_title,1,10)        
  wdetail.n_text122      =  substr(brstat.tlt.rec_typ,1,255)       
  wdetail.n_text123      =  substr(brstat.tlt.rider,1,5)         
  wdetail.n_text124      =  substr(brstat.tlt.safe1,1,20)        
  wdetail.n_text125      =  substr(brstat.tlt.safe2,1,10)        
  wdetail.n_text126      =  substr(brstat.tlt.safe3,1,150)       
  wdetail.n_text127      =  substr(brstat.tlt.sex,1,15)        
  wdetail.n_text128      =  substr(brstat.tlt.stat,1,250)       
  wdetail.n_text129      =  substr(brstat.tlt.subins,1,13)        
  wdetail.n_text130      =  substr(brstat.tlt.tel,1,10)        
  wdetail.n_text131      =  substr(brstat.tlt.tel2,1,150)      
  wdetail.n_text132      =  substr(brstat.tlt.tel3,1,15)       
  wdetail.n_text133      =  substr(brstat.tlt.usrid,1,250)       
  wdetail.n_text134      =  substr(brstat.tlt.usrsent,1,13)       
  wdetail.n_text135      =  substr(brstat.tlt.ln_product,1,10)     
  wdetail.n_text136      =  substr(brstat.tlt.ln_pronme,1,150)    
  wdetail.n_text137      =  substr(brstat.tlt.ln_rate,1,15)     
  wdetail.n_text138      =  substr(brstat.tlt.ln_st,1,250)    
  wdetail.n_text139      =  substr(brstat.tlt.lotno,1,13)    
  wdetail.n_text140      =  substr(brstat.tlt.maritalsts,1,10)    
  wdetail.n_text141      =  substr(brstat.tlt.campaign,1,12)    
  wdetail.n_text142      =  substr(brstat.tlt.mobile,1,10)    .  


END. 
END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_repfielsts2 c-wins 
PROCEDURE pd_repfielsts2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
IF fi_report = "" THEN DO:
    MESSAGE "ʶҹ� �繤����ҧ " VIEW-AS ALERT-BOX.
END.
ELSE DO:
    FOR EACH wproducer NO-LOCK.
        For each tlt Use-index  tlt06 Where
            tlt.nor_effdat >=  fi_trndatfr     And
            tlt.nor_effdat <=  fi_trndatto     AND 
            /*tlt.acno1     =  trim(fi_producer)  AND*/
            tlt.acno1       =  wproducer.producer  AND 
            tlt.genusr      =  "HCT"               And
            brstat.tlt.releas =  trim(fi_report)   NO-LOCK 
            BREAK BY brstat.tlt.comp_noti_ins :
            IF      nv_typre = "V70" AND brstat.tlt.nor_usr_ins  = "0" THEN NEXT.
            ELSE IF nv_typre = "V72" AND brstat.tlt.nor_usr_ins <> "0" THEN NEXT.
            CREATE  wdetail.
            ASSIGN 
            wdetail.n_text001      =  brstat.tlt.comp_noti_ins  
            wdetail.n_text002      =  brstat.tlt.comp_noti_tlt  
            wdetail.n_text003      =  brstat.tlt.comp_pol       
            wdetail.n_text004      =  string(brstat.tlt.nor_effdat,"99/99/9999")     
            wdetail.n_text005      =  string(brstat.tlt.comp_effdat,"99/99/9999")    
            wdetail.n_text006      =  brstat.tlt.comp_sub       
            wdetail.n_text007      =  brstat.tlt.cifno          
            wdetail.n_text008      =  brstat.tlt.nationality    
            wdetail.n_text009      =  brstat.tlt.nor_noti_ins   
            wdetail.n_text010      =  brstat.tlt.nor_noti_tlt   
            wdetail.n_text011      =  brstat.tlt.nor_usr_ins    
            wdetail.n_text012      =  brstat.tlt.covcod         
            wdetail.n_text013      =  brstat.tlt.nor_usr_tlt    
            wdetail.n_text014      =  brstat.tlt.comp_usr_ins   
            wdetail.n_text015      =  brstat.tlt.ins_title      
            wdetail.n_text016      =  brstat.tlt.ins_name       
            wdetail.n_text017      =  brstat.tlt.ins_firstname  
            wdetail.n_text018      =  brstat.tlt.ins_lastname   
            wdetail.n_text019      =  brstat.tlt.ins_addr       
            wdetail.n_text020      =  brstat.tlt.ins_addr1      
            wdetail.n_text021      =  brstat.tlt.ins_addr2      
            wdetail.n_text022      =  brstat.tlt.ins_addr3      
            wdetail.n_text023      =  brstat.tlt.lince2         
            wdetail.n_text024      =  brstat.tlt.ins_addr5      
            wdetail.n_text025      =  brstat.tlt.dir_occ1       
            wdetail.n_text026      =  brstat.tlt.note28         
            wdetail.n_text027      =  brstat.tlt.dri_ic1        
            wdetail.n_text028      =  brstat.tlt.dri_lic1       
            wdetail.n_text029      =  brstat.tlt.brand          
            wdetail.n_text030      =  substr(brstat.tlt.note10,1,1)         
            wdetail.n_text031      =  substr(brstat.tlt.cha_no,1,25)      
            wdetail.n_text032      =  substr(brstat.tlt.eng_no,1,20)                   
            wdetail.n_text033      =  substr(brstat.tlt.model,1,40)                 
            wdetail.n_text034      =  substr(brstat.tlt.note11,1,4)                  
            wdetail.n_text035      =  substr(brstat.tlt.note12,1,20)                  
            wdetail.n_text036      =  substr(brstat.tlt.note13,1,40)                  
            wdetail.n_text037      =  substr(brstat.tlt.note14,1,1)                   
            wdetail.n_text038      =  substr(brstat.tlt.vehuse,1,2)                   
            wdetail.n_text039      =  string(brstat.tlt.seqno,"99")                        
            wdetail.n_text040      =  string(brstat.tlt.cc_weight,"9999")                  
            wdetail.n_text041      =  substr(brstat.tlt.colorcod,1,40)        
            wdetail.n_text042      =  substr(brstat.tlt.lince1,1,10)        
            wdetail.n_text043      =  substr(brstat.tlt.ins_addr4,1,30)        
            wdetail.n_text044      =  substr(brstat.tlt.note15,1,4)         
            wdetail.n_text045      =  substr(brstat.tlt.note16,1,512)              
            wdetail.n_text046      =  substr(brstat.tlt.note17,1,14)        
            wdetail.n_text047      =  substr(brstat.tlt.note18,1,14)       
            wdetail.n_text048      =  substr(brstat.tlt.note19,1,14)          
            wdetail.n_text049      =  substr(brstat.tlt.note2,1,14)          
            wdetail.n_text050      =  substr(brstat.tlt.note20,1,14)       
            wdetail.n_text051      =  substr(brstat.tlt.note21,1,14)          
            wdetail.n_text052      =  substr(brstat.tlt.note22,1,14)        
            wdetail.n_text053      =  substr(brstat.tlt.note23,1,14)        
            wdetail.n_text054      =  substr(brstat.tlt.comp_sck,1,20)        
            wdetail.n_text055      =  substr(brstat.tlt.note24,1,32)        
            wdetail.n_text056      =  substr(brstat.tlt.dri_no1,1,1)        
            wdetail.n_text057      =  substr(brstat.tlt.dri_no2,1,1)         
            wdetail.n_text058      =  substr(brstat.tlt.note25,1,20)      
            wdetail.n_text059      =  substr(brstat.tlt.dri_name1,1,80)      
            wdetail.n_text060      =  substr(brstat.tlt.note26,1,20)      
            wdetail.n_text061      =  substr(brstat.tlt.note27,1,60)      
            wdetail.n_text062      =  substr(brstat.tlt.dri_occ2,1,50)   
            wdetail.n_text063      =  substr(brstat.tlt.note4,1,10)         
            wdetail.n_text064      =  substr(brstat.tlt.dri_ic2,1,15)         
            wdetail.n_text065      =  substr(brstat.tlt.dri_lic2,1,15)         
            wdetail.n_text066      =  substr(brstat.tlt.note29,1,20)         
            wdetail.n_text067      =  substr(brstat.tlt.dri_name2,1,80)         
            wdetail.n_text068      =  substr(brstat.tlt.note3,1,20)         
            wdetail.n_text069      =  substr(brstat.tlt.note30,1,60)         
            wdetail.n_text070      =  substr(brstat.tlt.ins_occ,1,50)         
            wdetail.n_text071      =  IF brstat.tlt.birthdate = ? THEN "" ELSE string(brstat.tlt.birthdate,"99/99/9999")              
            wdetail.n_text072      =  substr(brstat.tlt.ins_icno,1,15)           
            wdetail.n_text073      =  substr(brstat.tlt.note1,1,15)                   
            wdetail.n_text074      =  substr(brstat.tlt.ben83,1,80)                   
            wdetail.n_text075      =  string(brstat.tlt.comp_coamt,"99999999999.99")      
            wdetail.n_text076      =  string(brstat.tlt.comp_grprm,"99999999999.99")      
            wdetail.n_text077      =     string(brstat.tlt.mileage,"99999999999.99")         
            wdetail.n_text078      =      string(brstat.tlt.ndeci1,"99999999999.99")          
            wdetail.n_text079      =      string(brstat.tlt.ndeci2,"99999999999.99")          
            wdetail.n_text080      =      string(brstat.tlt.ndeci3,"99999999999.99")          
            wdetail.n_text081      =      string(brstat.tlt.ndeci4,"99999999999.99")          
            wdetail.n_text082      =      string(brstat.tlt.ndeci5,"99999999999.99")          
            wdetail.n_text083      =   string(brstat.tlt.nor_coamt,"99")                    
            wdetail.n_text084      =   string(brstat.tlt.nor_grprm,"99999999999.99")       
            wdetail.n_text085      =    string(brstat.tlt.prem_amt,"99999999999.99")        
            wdetail.n_text086     = string(brstat.tlt.prem_amttcop,"99")                 
            wdetail.n_text087      =        string(brstat.tlt.rstp,"99999999999.99")            
            wdetail.n_text088      =        string(brstat.tlt.rtax,"99999999999.99")            
            wdetail.n_text089     = string(brstat.tlt.tax_coporate,"99999999999.99")    
            wdetail.n_text090      =  substr(brstat.tlt.note5,1,6)            
            wdetail.n_text091      =  substr(brstat.tlt.note6,1,10)        
            wdetail.n_text092      =  substr(brstat.tlt.note7,1,10)        
            wdetail.n_text093      =  substr(brstat.tlt.note8,1,30)        
            wdetail.n_text094      =  substr(brstat.tlt.note9,1,80)        
            wdetail.n_text095      =  substr(brstat.tlt.noteveh1,1,10)        
            wdetail.n_text096      =  substr(brstat.tlt.noteveh2,1,30)        
            wdetail.n_text097      =  substr(brstat.tlt.old_cha,1,12)        
            wdetail.n_text098      =  substr(brstat.tlt.old_eng,1,3)             
            wdetail.n_text099      =  substr(brstat.tlt.pack,1,10)      
            wdetail.n_text100      =  substr(brstat.tlt.packnme,1,14)      
            wdetail.n_text101      =  substr(brstat.tlt.period,1,10)      
            wdetail.n_text102      =  substr(brstat.tlt.ln_note1,1,14) 
            wdetail.n_text103      =  substr(brstat.tlt.product,1,10)   
            wdetail.n_text104      =  substr(brstat.tlt.projnme,1,14)   
            wdetail.n_text105      =  substr(brstat.tlt.proveh,1,10)   
            wdetail.n_text106      =  substr(brstat.tlt.race,1,14)   
            wdetail.n_text107      =  substr(brstat.tlt.recac,1,10)   
            wdetail.n_text108      =  substr(brstat.tlt.rec_addr,1,14)   
            wdetail.n_text109      =  substr(brstat.tlt.rec_addr1,1,15)   
            wdetail.n_text110      =  substr(brstat.tlt.rec_addr2,1,10)   
            wdetail.n_text111      =  substr(brstat.tlt.rec_addr3,1,14)   
            wdetail.n_text112      =  substr(brstat.tlt.rec_addr4,1,10)   
            wdetail.n_text113      =  substr(brstat.tlt.rec_addr5,1,20)   
            wdetail.n_text114      =  substr(brstat.tlt.rec_brins,1,1)         
            wdetail.n_text115      =  substr(brstat.tlt.rec_cou,1,120)      
            wdetail.n_text116      =  substr(brstat.tlt.rec_icno,1,100)      
            wdetail.n_text117      =  substr(brstat.tlt.rec_name,1,2)         
            wdetail.n_text118      =  substr(brstat.tlt.rec_name2,1,2)         
            wdetail.n_text119      =  substr(brstat.tlt.rec_note1,1,10)        
            wdetail.n_text120      =  substr(brstat.tlt.rec_note2,1,1)        
            wdetail.n_text121      =  substr(brstat.tlt.rec_title,1,10)        
            wdetail.n_text122      =  substr(brstat.tlt.rec_typ,1,255)       
            wdetail.n_text123      =  substr(brstat.tlt.rider,1,5)         
            wdetail.n_text124      =  substr(brstat.tlt.safe1,1,20)        
            wdetail.n_text125      =  substr(brstat.tlt.safe2,1,10)        
            wdetail.n_text126      =  substr(brstat.tlt.safe3,1,150)       
            wdetail.n_text127      =  substr(brstat.tlt.sex,1,15)        
            wdetail.n_text128      =  substr(brstat.tlt.stat,1,250)       
            wdetail.n_text129      =  substr(brstat.tlt.subins,1,13)        
            wdetail.n_text130      =  substr(brstat.tlt.tel,1,10)        
            wdetail.n_text131      =  substr(brstat.tlt.tel2,1,150)      
            wdetail.n_text132      =  substr(brstat.tlt.tel3,1,15)       
            wdetail.n_text133      =  substr(brstat.tlt.usrid,1,250)       
            wdetail.n_text134      =  substr(brstat.tlt.usrsent,1,13)       
            wdetail.n_text135      =  substr(brstat.tlt.ln_product,1,10)     
            wdetail.n_text136      =  substr(brstat.tlt.ln_pronme,1,150)    
            wdetail.n_text137      =  substr(brstat.tlt.ln_rate,1,15)     
            wdetail.n_text138      =  substr(brstat.tlt.ln_st,1,250)    
            wdetail.n_text139      =  substr(brstat.tlt.lotno,1,13)    
            wdetail.n_text140      =  substr(brstat.tlt.maritalsts,1,10)    
            wdetail.n_text141      =  substr(brstat.tlt.campaign,1,12)    
            wdetail.n_text142      =  substr(brstat.tlt.mobile,1,10)    .  
        END.
    END.
END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_repfielSwitch1 c-wins 
PROCEDURE pd_repfielSwitch1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 
For each tlt Use-index  tlt06 Where
            tlt.nor_effdat >=  fi_trndatfr And
            tlt.nor_effdat <=  fi_trndatto AND 
            tlt.genusr      =  "HCT"       And
            tlt.rec_note2   =  "S"         NO-LOCK 
    BREAK BY brstat.tlt.comp_noti_ins :

    IF      nv_typre = "V70" AND brstat.tlt.nor_usr_ins  = "0" THEN NEXT.
    ELSE IF nv_typre = "V72" AND brstat.tlt.nor_usr_ins <> "0" THEN NEXT.

    CREATE  wdetail.
    ASSIGN 
    wdetail.n_text001      =  brstat.tlt.comp_noti_ins  
    wdetail.n_text002      =  brstat.tlt.comp_noti_tlt  
    wdetail.n_text003      =  brstat.tlt.comp_pol       
    wdetail.n_text004      =  string(brstat.tlt.nor_effdat,"99/99/9999")     
    wdetail.n_text005      =  string(brstat.tlt.comp_effdat,"99/99/9999")    
    wdetail.n_text006      =  brstat.tlt.comp_sub       
    wdetail.n_text007      =  brstat.tlt.cifno          
    wdetail.n_text008      =  brstat.tlt.nationality    
    wdetail.n_text009      =  brstat.tlt.nor_noti_ins   
    wdetail.n_text010      =  brstat.tlt.nor_noti_tlt   
    wdetail.n_text011      =  brstat.tlt.nor_usr_ins    
    wdetail.n_text012      =  brstat.tlt.covcod         
    wdetail.n_text013      =  brstat.tlt.nor_usr_tlt    
    wdetail.n_text014      =  brstat.tlt.comp_usr_ins   
    wdetail.n_text015      =  brstat.tlt.ins_title      
    wdetail.n_text016      =  brstat.tlt.ins_name       
    wdetail.n_text017      =  brstat.tlt.ins_firstname  
    wdetail.n_text018      =  brstat.tlt.ins_lastname   
    wdetail.n_text019      =  brstat.tlt.ins_addr       
    wdetail.n_text020      =  brstat.tlt.ins_addr1      
    wdetail.n_text021      =  brstat.tlt.ins_addr2      
    wdetail.n_text022      =  brstat.tlt.ins_addr3      
    wdetail.n_text023      =  brstat.tlt.lince2         
    wdetail.n_text024      =  brstat.tlt.ins_addr5      
    wdetail.n_text025      =  brstat.tlt.dir_occ1       
    wdetail.n_text026      =  brstat.tlt.note28         
    wdetail.n_text027      =  brstat.tlt.dri_ic1        
    wdetail.n_text028      =  brstat.tlt.dri_lic1       
    wdetail.n_text029      =  brstat.tlt.brand          
    wdetail.n_text030      =  substr(brstat.tlt.note10,1,1)         
    wdetail.n_text031      =  substr(brstat.tlt.cha_no,1,25)      
    wdetail.n_text032      =  substr(brstat.tlt.eng_no,1,20)                   
    wdetail.n_text033      =  substr(brstat.tlt.model,1,40)                 
    wdetail.n_text034      =  substr(brstat.tlt.note11,1,4)                  
    wdetail.n_text035      =  substr(brstat.tlt.note12,1,20)                  
    wdetail.n_text036      =  substr(brstat.tlt.note13,1,40)                  
    wdetail.n_text037      =  substr(brstat.tlt.note14,1,1)                   
    /*wdetail.n_text038      =  substr(brstat.tlt.vehuse,1,2) */ /* A68-0061*/
    wdetail.n_text038      =  IF rs_typre = 1 THEN substr(brstat.tlt.vehuse,1,2) ELSE TRIM(brstat.tlt.vehuse)  /* A68-0061*/                  
    wdetail.n_text039      =  string(brstat.tlt.seqno,"99")                        
    wdetail.n_text040      =  string(brstat.tlt.cc_weight,"9999")                  
    wdetail.n_text041      =  substr(brstat.tlt.colorcod,1,40)        
    wdetail.n_text042      =  substr(brstat.tlt.lince1,1,10)        
    wdetail.n_text043      =  substr(brstat.tlt.ins_addr4,1,30)        
    wdetail.n_text044      =  substr(brstat.tlt.note15,1,4)         
    wdetail.n_text045      =  substr(brstat.tlt.note16,1,512)              
    wdetail.n_text046      =  substr(brstat.tlt.note17,1,14)        
    wdetail.n_text047      =  substr(brstat.tlt.note18,1,14)       
    wdetail.n_text048      =  substr(brstat.tlt.note19,1,14)          
    wdetail.n_text049      =  substr(brstat.tlt.note2,1,14)          
    wdetail.n_text050      =  substr(brstat.tlt.note20,1,14)       
    wdetail.n_text051      =  substr(brstat.tlt.note21,1,14)          
    wdetail.n_text052      =  substr(brstat.tlt.note22,1,14)        
    wdetail.n_text053      =  substr(brstat.tlt.note23,1,14)        
    wdetail.n_text054      =  substr(brstat.tlt.comp_sck,1,20)        
    wdetail.n_text055      =  substr(brstat.tlt.note24,1,32)        
    wdetail.n_text056      =  substr(brstat.tlt.dri_no1,1,1)        
    wdetail.n_text057      =  substr(brstat.tlt.dri_no2,1,1)         
    wdetail.n_text058      =  substr(brstat.tlt.note25,1,20)      
    wdetail.n_text059      =  substr(brstat.tlt.dri_name1,1,80)      
    wdetail.n_text060      =  substr(brstat.tlt.note26,1,20)      
    wdetail.n_text061      =  substr(brstat.tlt.note27,1,60)      
    wdetail.n_text062      =  substr(brstat.tlt.dri_occ2,1,50)   
    wdetail.n_text063      =  substr(brstat.tlt.note4,1,10)         
    wdetail.n_text064      =  substr(brstat.tlt.dri_ic2,1,15)         
    wdetail.n_text065      =  substr(brstat.tlt.dri_lic2,1,15)         
    wdetail.n_text066      =  substr(brstat.tlt.note29,1,20)         
    wdetail.n_text067      =  substr(brstat.tlt.dri_name2,1,80)         
    wdetail.n_text068      =  substr(brstat.tlt.note3,1,20)         
    wdetail.n_text069      =  substr(brstat.tlt.note30,1,60)         
    wdetail.n_text070      =  substr(brstat.tlt.ins_occ,1,50)         
    wdetail.n_text071      =  IF brstat.tlt.birthdate = ? THEN "" ELSE string(brstat.tlt.birthdate,"99/99/9999")              
    wdetail.n_text072      =  substr(brstat.tlt.ins_icno,1,15)           
    wdetail.n_text073      =  substr(brstat.tlt.note1,1,15)                   
    wdetail.n_text074      =  substr(brstat.tlt.ben83,1,80)                   
    wdetail.n_text075      =  string(brstat.tlt.comp_coamt,"99999999999.99")      
    wdetail.n_text076      =  string(brstat.tlt.comp_grprm,"99999999999.99")      
    wdetail.n_text077      =  string(brstat.tlt.mileage,"99999999999.99")         
    wdetail.n_text078      =  string(brstat.tlt.ndeci1,"99999999999.99")          
    wdetail.n_text079      =  string(brstat.tlt.ndeci2,"99999999999.99")          
    wdetail.n_text080      =  string(brstat.tlt.ndeci3,"99999999999.99")          
    wdetail.n_text081      =  string(brstat.tlt.ndeci4,"99999999999.99")          
    wdetail.n_text082      =  string(brstat.tlt.ndeci5,"99999999999.99")          
    wdetail.n_text083      =  string(brstat.tlt.nor_coamt,"99")                    
    wdetail.n_text084      =  string(brstat.tlt.nor_grprm,"99999999999.99")       
    wdetail.n_text085      =  string(brstat.tlt.prem_amt,"99999999999.99")        
    wdetail.n_text086      =  string(brstat.tlt.prem_amttcop,"99")                 
    wdetail.n_text087      =  string(brstat.tlt.rstp,"99999999999.99")            
    wdetail.n_text088      =  string(brstat.tlt.rtax,"99999999999.99")            
    wdetail.n_text089      =  string(brstat.tlt.tax_coporate,"99999999999.99")    
    wdetail.n_text090      =  substr(brstat.tlt.note5,1,6)            
    wdetail.n_text091      =  substr(brstat.tlt.note6,1,10)        
    wdetail.n_text092      =  substr(brstat.tlt.note7,1,10)        
    wdetail.n_text093      =  substr(brstat.tlt.note8,1,30)        
    wdetail.n_text094      =  substr(brstat.tlt.note9,1,80)        
    wdetail.n_text095      =  substr(brstat.tlt.noteveh1,1,10)        
    wdetail.n_text096      =  substr(brstat.tlt.noteveh2,1,30)        
    wdetail.n_text097      =  substr(brstat.tlt.old_cha,1,12)        
    wdetail.n_text098      =  substr(brstat.tlt.old_eng,1,3)             
    wdetail.n_text099      =  substr(brstat.tlt.pack,1,10)      
    wdetail.n_text100      =  substr(brstat.tlt.packnme,1,14)      
    wdetail.n_text101      =  substr(brstat.tlt.period,1,10)      
    wdetail.n_text102      =  substr(brstat.tlt.ln_note1,1,14) 
    wdetail.n_text103      =  substr(brstat.tlt.product,1,10)   
    wdetail.n_text104      =  substr(brstat.tlt.projnme,1,14)   
    wdetail.n_text105      =  substr(brstat.tlt.proveh,1,10)   
    wdetail.n_text106      =  substr(brstat.tlt.race,1,14)   
    wdetail.n_text107      =  substr(brstat.tlt.recac,1,10)   
    wdetail.n_text108      =  substr(brstat.tlt.rec_addr,1,14)   
    wdetail.n_text109      =  substr(brstat.tlt.rec_addr1,1,15)   
    wdetail.n_text110      =  substr(brstat.tlt.rec_addr2,1,10)   
    wdetail.n_text111      =  substr(brstat.tlt.rec_addr3,1,14)   
    wdetail.n_text112      =  substr(brstat.tlt.rec_addr4,1,10)   
    wdetail.n_text113      =  substr(brstat.tlt.rec_addr5,1,20)   
    wdetail.n_text114      =  substr(brstat.tlt.rec_brins,1,1)         
    wdetail.n_text115      =  substr(brstat.tlt.rec_cou,1,120)      
    wdetail.n_text116      =  substr(brstat.tlt.rec_icno,1,100)      
    wdetail.n_text117      =  substr(brstat.tlt.rec_name,1,2)         
    wdetail.n_text118      =  substr(brstat.tlt.rec_name2,1,2)         
    wdetail.n_text119      =  substr(brstat.tlt.rec_note1,1,10)        
    wdetail.n_text120      =  substr(brstat.tlt.rec_note2,1,1)        
    wdetail.n_text121      =  substr(brstat.tlt.rec_title,1,10)        
    wdetail.n_text122      =  substr(brstat.tlt.rec_typ,1,255)       
    wdetail.n_text123      =  substr(brstat.tlt.rider,1,5)         
    wdetail.n_text124      =  substr(brstat.tlt.safe1,1,20)        
    wdetail.n_text125      =  substr(brstat.tlt.safe2,1,10)        
    wdetail.n_text126      =  substr(brstat.tlt.safe3,1,150)       
    wdetail.n_text127      =  substr(brstat.tlt.sex,1,15)        
    wdetail.n_text128      =  substr(brstat.tlt.stat,1,250)       
    wdetail.n_text129      =  substr(brstat.tlt.subins,1,13)        
    wdetail.n_text130      =  substr(brstat.tlt.tel,1,10)        
    wdetail.n_text131      =  substr(brstat.tlt.tel2,1,150)      
    wdetail.n_text132      =  substr(brstat.tlt.tel3,1,15)       
    wdetail.n_text133      =  substr(brstat.tlt.usrid,1,250)       
    wdetail.n_text134      =  substr(brstat.tlt.usrsent,1,13)       
    wdetail.n_text135      =  substr(brstat.tlt.ln_product,1,10)     
    wdetail.n_text136      =  substr(brstat.tlt.ln_pronme,1,150)    
    wdetail.n_text137      =  substr(brstat.tlt.ln_rate,1,15)     
    wdetail.n_text138      =  substr(brstat.tlt.ln_st,1,250)    
    wdetail.n_text139      =  substr(brstat.tlt.lotno,1,13)    
    wdetail.n_text140      =  substr(brstat.tlt.maritalsts,1,10)    
    wdetail.n_text141      =  substr(brstat.tlt.campaign,1,12)    
    wdetail.n_text142      =  substr(brstat.tlt.mobile,1,10)    . 
     /* ADD BY : A68-0061 */
    ASSIGN 
    wdetail.typepol    =   brstat.tlt.poltyp
    wdetail.typecar    =   brstat.tlt.car_type
    wdetail.maksi      =   STRING(brstat.tlt.maksi)
    wdetail.drivexp1   =   brstat.tlt.dri_licenexp1
    wdetail.drivcon1   =   string(brstat.tlt.dri_consen1)
    wdetail.dlevel1    =   string(brstat.tlt.dri_level1)
    wdetail.dgender1   =   brstat.tlt.dri_gender1
    wdetail.drivexp2   =   brstat.tlt.dri_licenexp2
    wdetail.drivcon2   =   string(brstat.tlt.dri_consen2)
    wdetail.dlevel2    =   string(brstat.tlt.dri_level2)
    wdetail.dgender2   =   brstat.tlt.dri_gender2
    wdetail.ntitle3    =   brstat.tlt.dri_title3
    wdetail.dname3     =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,1,INDEX(brstat.tlt.dri_fname3," ") - 1) ELSE TRIM(brstat.tlt.dri_fname3)
    wdetail.dcname3    =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,R-INDEX(brstat.tlt.dri_fname3," ")) ELSE "" 
    wdetail.dlname3    =   brstat.tlt.dri_lname3
    wdetail.doccup3    =   brstat.tlt.dir_occ3
    wdetail.dbirth3    =   brstat.tlt.dri_birth3
    wdetail.dicno3     =   brstat.tlt.dri_ic3
    wdetail.ddriveno3  =   brstat.tlt.dri_lic3
    wdetail.drivexp3   =   brstat.tlt.dri_licenexp3
    wdetail.drivcon3   =   string(brstat.tlt.dri_consen3)
    wdetail.dlevel3    =   string(brstat.tlt.dri_level3)
    wdetail.dgender3   =   brstat.tlt.dri_gender3
    wdetail.ntitle4    =   brstat.tlt.dri_title4
    wdetail.dname4     =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,1,INDEX(brstat.tlt.dri_fname4," ") - 1) ELSE TRIM(brstat.tlt.dri_fname4)
    wdetail.dcname4    =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,R-INDEX(brstat.tlt.dri_fname4," ")) ELSE ""
    wdetail.dlname4    =   brstat.tlt.dri_lname4
    wdetail.doccup4    =   brstat.tlt.dri_occ4
    wdetail.dbirth4    =   brstat.tlt.dri_birth4
    wdetail.dicno4     =   brstat.tlt.dri_ic4
    wdetail.ddriveno4  =   brstat.tlt.dri_lic4
    wdetail.drivexp4   =   brstat.tlt.dri_licenexp4
    wdetail.drivcon4   =   string(brstat.tlt.dri_consen4)
    wdetail.dlevel4    =   string(brstat.tlt.dri_level4)
    wdetail.dgender4   =   brstat.tlt.dri_gender4
    wdetail.ntitle5    =   brstat.tlt.dri_title5
    wdetail.dname5     =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,1,INDEX(brstat.tlt.dri_fname5," ") - 1) ELSE TRIM(brstat.tlt.dri_fname5)
    wdetail.dcname5    =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,R-INDEX(brstat.tlt.dri_fname5," ")) ELSE "" 
    wdetail.dlname5    =   brstat.tlt.dri_lname5
    wdetail.doccup5    =   brstat.tlt.dri_occ5
    wdetail.dbirth5    =   brstat.tlt.dri_birth5
    wdetail.dicno5     =   brstat.tlt.dri_ic5
    wdetail.ddriveno5  =   brstat.tlt.dri_lic5
    wdetail.drivexp5   =   brstat.tlt.dri_licenexp5
    wdetail.drivcon5   =   string(brstat.tlt.dri_consen5)
    wdetail.dlevel5    =   string(brstat.tlt.dri_level5)
    wdetail.dgender5   =   brstat.tlt.dri_gender5  
    wdetail.chargflg    =  STRING(brstat.tlt.chargflg)
    wdetail.chargprice  =  STRING(brstat.tlt.chargsi)
    wdetail.chargno     =  brstat.tlt.chargno
    wdetail.chargprm    =  string(brstat.tlt.chargprem)
    wdetail.battflg     =  string(brstat.tlt.battflg  )
    wdetail.battprice   =  string(brstat.tlt.battprice)
    wdetail.battno      =  brstat.tlt.battno
    wdetail.battprm     =  string(brstat.tlt.battprem)
    wdetail.battdate    =  string(brstat.tlt.ndate1,"99/99/9999")
    wdetail.net_re1     =  string(brstat.tlt.dg_prem)
    wdetail.stam_re1    =  string(brstat.tlt.dg_rstp_t)
    wdetail.vat_re1     =  string(brstat.tlt.dg_rtax_t)
    wdetail.inscode_re2 =  brstat.tlt.ins_code
    wdetail.net_re2     =  string(brstat.tlt.dg_si  )
    wdetail.stam_re2    =  string(brstat.tlt.dg_rate)
    wdetail.vat_re2     =  string(brstat.tlt.dg_feet)
    wdetail.inscode_re3 =  brstat.tlt.Paycode
    wdetail.net_re3     =  string(brstat.tlt.dg_ncb  )
    wdetail.stam_re3    =  string(brstat.tlt.dg_disc )
    wdetail.vat_re3     =  string(brstat.tlt.dg_wdisc) .
 /* END : A68-0061 */

END. 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_repfielSwitch2 c-wins 
PROCEDURE pd_repfielSwitch2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wproducer NO-LOCK.
    For each tlt Use-index  tlt06 Where
        tlt.nor_effdat >=  fi_trndatfr    And
        tlt.nor_effdat <=  fi_trndatto    AND 
        /*tlt.acno1    =  trim(fi_producer) AND*/
        tlt.acno1      =  wproducer.producer  AND 
        tlt.genusr   =  "HCT"             And
        tlt.rec_note2  = "S"       NO-LOCK 
        BREAK BY brstat.tlt.comp_noti_ins :

        IF      nv_typre = "V70" AND brstat.tlt.nor_usr_ins  = "0" THEN NEXT.
        ELSE IF nv_typre = "V72" AND brstat.tlt.nor_usr_ins <> "0" THEN NEXT.
        CREATE  wdetail.
        ASSIGN 
        wdetail.n_text001      =  brstat.tlt.comp_noti_ins  
        wdetail.n_text002      =  brstat.tlt.comp_noti_tlt  
        wdetail.n_text003      =  brstat.tlt.comp_pol       
        wdetail.n_text004      =  string(brstat.tlt.nor_effdat,"99/99/9999")     
        wdetail.n_text005      =  string(brstat.tlt.comp_effdat,"99/99/9999")    
        wdetail.n_text006      =  brstat.tlt.comp_sub       
        wdetail.n_text007      =  brstat.tlt.cifno          
        wdetail.n_text008      =  brstat.tlt.nationality    
        wdetail.n_text009      =  brstat.tlt.nor_noti_ins   
        wdetail.n_text010      =  brstat.tlt.nor_noti_tlt   
        wdetail.n_text011      =  brstat.tlt.nor_usr_ins    
        wdetail.n_text012      =  brstat.tlt.covcod         
        wdetail.n_text013      =  brstat.tlt.nor_usr_tlt    
        wdetail.n_text014      =  brstat.tlt.comp_usr_ins   
        wdetail.n_text015      =  brstat.tlt.ins_title      
        wdetail.n_text016      =  brstat.tlt.ins_name       
        wdetail.n_text017      =  brstat.tlt.ins_firstname  
        wdetail.n_text018      =  brstat.tlt.ins_lastname   
        wdetail.n_text019      =  brstat.tlt.ins_addr       
        wdetail.n_text020      =  brstat.tlt.ins_addr1      
        wdetail.n_text021      =  brstat.tlt.ins_addr2      
        wdetail.n_text022      =  brstat.tlt.ins_addr3      
        wdetail.n_text023      =  brstat.tlt.lince2         
        wdetail.n_text024      =  brstat.tlt.ins_addr5      
        wdetail.n_text025      =  brstat.tlt.dir_occ1       
        wdetail.n_text026      =  brstat.tlt.note28         
        wdetail.n_text027      =  brstat.tlt.dri_ic1        
        wdetail.n_text028      =  brstat.tlt.dri_lic1       
        wdetail.n_text029      =  brstat.tlt.brand          
        wdetail.n_text030      =  substr(brstat.tlt.note10,1,1)         
        wdetail.n_text031      =  substr(brstat.tlt.cha_no,1,25)      
        wdetail.n_text032      =  substr(brstat.tlt.eng_no,1,20)                   
        wdetail.n_text033      =  substr(brstat.tlt.model,1,40)                 
        wdetail.n_text034      =  substr(brstat.tlt.note11,1,4)                  
        wdetail.n_text035      =  substr(brstat.tlt.note12,1,20)                  
        wdetail.n_text036      =  substr(brstat.tlt.note13,1,40)                  
        wdetail.n_text037      =  substr(brstat.tlt.note14,1,1)                   
        /*wdetail.n_text038      =  substr(brstat.tlt.vehuse,1,2) */ /* A68-0061*/
        wdetail.n_text038      =  IF rs_typre = 1 THEN substr(brstat.tlt.vehuse,1,2) ELSE TRIM(brstat.tlt.vehuse)  /* A68-0061*/                  
        wdetail.n_text039      =  string(brstat.tlt.seqno,"99")                        
        wdetail.n_text040      =  string(brstat.tlt.cc_weight,"9999")                  
        wdetail.n_text041      =  substr(brstat.tlt.colorcod,1,40)        
        wdetail.n_text042      =  substr(brstat.tlt.lince1,1,10)        
        wdetail.n_text043      =  substr(brstat.tlt.ins_addr4,1,30)        
        wdetail.n_text044      =  substr(brstat.tlt.note15,1,4)         
        wdetail.n_text045      =  substr(brstat.tlt.note16,1,512)              
        wdetail.n_text046      =  substr(brstat.tlt.note17,1,14)        
        wdetail.n_text047      =  substr(brstat.tlt.note18,1,14)       
        wdetail.n_text048      =  substr(brstat.tlt.note19,1,14)          
        wdetail.n_text049      =  substr(brstat.tlt.note2,1,14)          
        wdetail.n_text050      =  substr(brstat.tlt.note20,1,14)       
        wdetail.n_text051      =  substr(brstat.tlt.note21,1,14)          
        wdetail.n_text052      =  substr(brstat.tlt.note22,1,14)        
        wdetail.n_text053      =  substr(brstat.tlt.note23,1,14)        
        wdetail.n_text054      =  substr(brstat.tlt.comp_sck,1,20)        
        wdetail.n_text055      =  substr(brstat.tlt.note24,1,32)        
        wdetail.n_text056      =  substr(brstat.tlt.dri_no1,1,1)        
        wdetail.n_text057      =  substr(brstat.tlt.dri_no2,1,1)         
        wdetail.n_text058      =  substr(brstat.tlt.note25,1,20)      
        wdetail.n_text059      =  substr(brstat.tlt.dri_name1,1,80)      
        wdetail.n_text060      =  substr(brstat.tlt.note26,1,20)      
        wdetail.n_text061      =  substr(brstat.tlt.note27,1,60)      
        wdetail.n_text062      =  substr(brstat.tlt.dri_occ2,1,50)   
        wdetail.n_text063      =  substr(brstat.tlt.note4,1,10)         
        wdetail.n_text064      =  substr(brstat.tlt.dri_ic2,1,15)         
        wdetail.n_text065      =  substr(brstat.tlt.dri_lic2,1,15)         
        wdetail.n_text066      =  substr(brstat.tlt.note29,1,20)         
        wdetail.n_text067      =  substr(brstat.tlt.dri_name2,1,80)         
        wdetail.n_text068      =  substr(brstat.tlt.note3,1,20)         
        wdetail.n_text069      =  substr(brstat.tlt.note30,1,60)         
        wdetail.n_text070      =  substr(brstat.tlt.ins_occ,1,50)         
        wdetail.n_text071      =  IF brstat.tlt.birthdate = ? THEN "" ELSE string(brstat.tlt.birthdate,"99/99/9999")              
        wdetail.n_text072      =  substr(brstat.tlt.ins_icno,1,15)           
        wdetail.n_text073      =  substr(brstat.tlt.note1,1,15)                   
        wdetail.n_text074      =  substr(brstat.tlt.ben83,1,80)                   
        wdetail.n_text075      =  string(brstat.tlt.comp_coamt,"99999999999.99")      
        wdetail.n_text076      =  string(brstat.tlt.comp_grprm,"99999999999.99")      
        wdetail.n_text077      =  string(brstat.tlt.mileage,"99999999999.99")         
        wdetail.n_text078      =  string(brstat.tlt.ndeci1,"99999999999.99")          
        wdetail.n_text079      =  string(brstat.tlt.ndeci2,"99999999999.99")          
        wdetail.n_text080      =  string(brstat.tlt.ndeci3,"99999999999.99")          
        wdetail.n_text081      =  string(brstat.tlt.ndeci4,"99999999999.99")          
        wdetail.n_text082      =  string(brstat.tlt.ndeci5,"99999999999.99")          
        wdetail.n_text083      =  string(brstat.tlt.nor_coamt,"99")                    
        wdetail.n_text084      =  string(brstat.tlt.nor_grprm,"99999999999.99")       
        wdetail.n_text085      =  string(brstat.tlt.prem_amt,"99999999999.99")        
        wdetail.n_text086      =  string(brstat.tlt.prem_amttcop,"99")                 
        wdetail.n_text087      =  string(brstat.tlt.rstp,"99999999999.99")            
        wdetail.n_text088      =  string(brstat.tlt.rtax,"99999999999.99")            
        wdetail.n_text089      =  string(brstat.tlt.tax_coporate,"99999999999.99")    
        wdetail.n_text090      =  substr(brstat.tlt.note5,1,6)            
        wdetail.n_text091      =  substr(brstat.tlt.note6,1,10)        
        wdetail.n_text092      =  substr(brstat.tlt.note7,1,10)        
        wdetail.n_text093      =  substr(brstat.tlt.note8,1,30)        
        wdetail.n_text094      =  substr(brstat.tlt.note9,1,80)        
        wdetail.n_text095      =  substr(brstat.tlt.noteveh1,1,10)        
        wdetail.n_text096      =  substr(brstat.tlt.noteveh2,1,30)        
        wdetail.n_text097      =  substr(brstat.tlt.old_cha,1,12)        
        wdetail.n_text098      =  substr(brstat.tlt.old_eng,1,3)             
        wdetail.n_text099      =  substr(brstat.tlt.pack,1,10)      
        wdetail.n_text100      =  substr(brstat.tlt.packnme,1,14)      
        wdetail.n_text101      =  substr(brstat.tlt.period,1,10)      
        wdetail.n_text102      =  substr(brstat.tlt.ln_note1,1,14) 
        wdetail.n_text103      =  substr(brstat.tlt.product,1,10)   
        wdetail.n_text104      =  substr(brstat.tlt.projnme,1,14)   
        wdetail.n_text105      =  substr(brstat.tlt.proveh,1,10)   
        wdetail.n_text106      =  substr(brstat.tlt.race,1,14)   
        wdetail.n_text107      =  substr(brstat.tlt.recac,1,10)   
        wdetail.n_text108      =  substr(brstat.tlt.rec_addr,1,14)   
        wdetail.n_text109      =  substr(brstat.tlt.rec_addr1,1,15)   
        wdetail.n_text110      =  substr(brstat.tlt.rec_addr2,1,10)   
        wdetail.n_text111      =  substr(brstat.tlt.rec_addr3,1,14)   
        wdetail.n_text112      =  substr(brstat.tlt.rec_addr4,1,10)   
        wdetail.n_text113      =  substr(brstat.tlt.rec_addr5,1,20)   
        wdetail.n_text114      =  substr(brstat.tlt.rec_brins,1,1)         
        wdetail.n_text115      =  substr(brstat.tlt.rec_cou,1,120)      
        wdetail.n_text116      =  substr(brstat.tlt.rec_icno,1,100)      
        wdetail.n_text117      =  substr(brstat.tlt.rec_name,1,2)         
        wdetail.n_text118      =  substr(brstat.tlt.rec_name2,1,2)         
        wdetail.n_text119      =  substr(brstat.tlt.rec_note1,1,10)        
        wdetail.n_text120      =  substr(brstat.tlt.rec_note2,1,1)        
        wdetail.n_text121      =  substr(brstat.tlt.rec_title,1,10)        
        wdetail.n_text122      =  substr(brstat.tlt.rec_typ,1,255)       
        wdetail.n_text123      =  substr(brstat.tlt.rider,1,5)         
        wdetail.n_text124      =  substr(brstat.tlt.safe1,1,20)        
        wdetail.n_text125      =  substr(brstat.tlt.safe2,1,10)        
        wdetail.n_text126      =  substr(brstat.tlt.safe3,1,150)       
        wdetail.n_text127      =  substr(brstat.tlt.sex,1,15)        
        wdetail.n_text128      =  substr(brstat.tlt.stat,1,250)       
        wdetail.n_text129      =  substr(brstat.tlt.subins,1,13)        
        wdetail.n_text130      =  substr(brstat.tlt.tel,1,10)        
        wdetail.n_text131      =  substr(brstat.tlt.tel2,1,150)      
        wdetail.n_text132      =  substr(brstat.tlt.tel3,1,15)       
        wdetail.n_text133      =  substr(brstat.tlt.usrid,1,250)       
        wdetail.n_text134      =  substr(brstat.tlt.usrsent,1,13)       
        wdetail.n_text135      =  substr(brstat.tlt.ln_product,1,10)     
        wdetail.n_text136      =  substr(brstat.tlt.ln_pronme,1,150)    
        wdetail.n_text137      =  substr(brstat.tlt.ln_rate,1,15)     
        wdetail.n_text138      =  substr(brstat.tlt.ln_st,1,250)    
        wdetail.n_text139      =  substr(brstat.tlt.lotno,1,13)    
        wdetail.n_text140      =  substr(brstat.tlt.maritalsts,1,10)    
        wdetail.n_text141      =  substr(brstat.tlt.campaign,1,12)    
        wdetail.n_text142      =  substr(brstat.tlt.mobile,1,10)    .
         /* ADD BY : A68-0061 */
       ASSIGN 
       wdetail.typepol    =   brstat.tlt.poltyp
       wdetail.typecar    =   brstat.tlt.car_type
       wdetail.maksi      =   STRING(brstat.tlt.maksi)
       wdetail.drivexp1   =   brstat.tlt.dri_licenexp1
       wdetail.drivcon1   =   string(brstat.tlt.dri_consen1)
       wdetail.dlevel1    =   string(brstat.tlt.dri_level1)
       wdetail.dgender1   =   brstat.tlt.dri_gender1
       wdetail.drivexp2   =   brstat.tlt.dri_licenexp2
       wdetail.drivcon2   =   string(brstat.tlt.dri_consen2)
       wdetail.dlevel2    =   string(brstat.tlt.dri_level2)
       wdetail.dgender2   =   brstat.tlt.dri_gender2
       wdetail.ntitle3    =   brstat.tlt.dri_title3
       wdetail.dname3     =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,1,INDEX(brstat.tlt.dri_fname3," ") - 1) ELSE TRIM(brstat.tlt.dri_fname3)
       wdetail.dcname3    =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,R-INDEX(brstat.tlt.dri_fname3," ")) ELSE "" 
       wdetail.dlname3    =   brstat.tlt.dri_lname3
       wdetail.doccup3    =   brstat.tlt.dir_occ3
       wdetail.dbirth3    =   brstat.tlt.dri_birth3
       wdetail.dicno3     =   brstat.tlt.dri_ic3
       wdetail.ddriveno3  =   brstat.tlt.dri_lic3
       wdetail.drivexp3   =   brstat.tlt.dri_licenexp3
       wdetail.drivcon3   =   string(brstat.tlt.dri_consen3)
       wdetail.dlevel3    =   string(brstat.tlt.dri_level3)
       wdetail.dgender3   =   brstat.tlt.dri_gender3
       wdetail.ntitle4    =   brstat.tlt.dri_title4
       wdetail.dname4     =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,1,INDEX(brstat.tlt.dri_fname4," ") - 1) ELSE TRIM(brstat.tlt.dri_fname4)
       wdetail.dcname4    =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,R-INDEX(brstat.tlt.dri_fname4," ")) ELSE ""
       wdetail.dlname4    =   brstat.tlt.dri_lname4
       wdetail.doccup4    =   brstat.tlt.dri_occ4
       wdetail.dbirth4    =   brstat.tlt.dri_birth4
       wdetail.dicno4     =   brstat.tlt.dri_ic4
       wdetail.ddriveno4  =   brstat.tlt.dri_lic4
       wdetail.drivexp4   =   brstat.tlt.dri_licenexp4
       wdetail.drivcon4   =   string(brstat.tlt.dri_consen4)
       wdetail.dlevel4    =   string(brstat.tlt.dri_level4)
       wdetail.dgender4   =   brstat.tlt.dri_gender4
       wdetail.ntitle5    =   brstat.tlt.dri_title5
       wdetail.dname5     =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,1,INDEX(brstat.tlt.dri_fname5," ") - 1) ELSE TRIM(brstat.tlt.dri_fname5)
       wdetail.dcname5    =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,R-INDEX(brstat.tlt.dri_fname5," ")) ELSE "" 
       wdetail.dlname5    =   brstat.tlt.dri_lname5
       wdetail.doccup5    =   brstat.tlt.dri_occ5
       wdetail.dbirth5    =   brstat.tlt.dri_birth5
       wdetail.dicno5     =   brstat.tlt.dri_ic5
       wdetail.ddriveno5  =   brstat.tlt.dri_lic5
       wdetail.drivexp5   =   brstat.tlt.dri_licenexp5
       wdetail.drivcon5   =   string(brstat.tlt.dri_consen5)
       wdetail.dlevel5    =   string(brstat.tlt.dri_level5)
       wdetail.dgender5   =   brstat.tlt.dri_gender5  
       wdetail.chargflg    =  STRING(brstat.tlt.chargflg)
       wdetail.chargprice  =  STRING(brstat.tlt.chargsi)
       wdetail.chargno     =  brstat.tlt.chargno
       wdetail.chargprm    =  string(brstat.tlt.chargprem)
       wdetail.battflg     =  string(brstat.tlt.battflg  )
       wdetail.battprice   =  string(brstat.tlt.battprice)
       wdetail.battno      =  brstat.tlt.battno
       wdetail.battprm     =  string(brstat.tlt.battprem)
       wdetail.battdate    =  string(brstat.tlt.ndate1,"99/99/9999")
       wdetail.net_re1     =  string(brstat.tlt.dg_prem)
       wdetail.stam_re1    =  string(brstat.tlt.dg_rstp_t)
       wdetail.vat_re1     =  string(brstat.tlt.dg_rtax_t)
       wdetail.inscode_re2 =  brstat.tlt.ins_code
       wdetail.net_re2     =  string(brstat.tlt.dg_si  )
       wdetail.stam_re2    =  string(brstat.tlt.dg_rate)
       wdetail.vat_re2     =  string(brstat.tlt.dg_feet)
       wdetail.inscode_re3 =  brstat.tlt.Paycode
       wdetail.net_re3     =  string(brstat.tlt.dg_ncb  )
       wdetail.stam_re3    =  string(brstat.tlt.dg_disc )
       wdetail.vat_re3     =  string(brstat.tlt.dg_wdisc) .
       /* END : A68-0061 */
    END.
END. 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_reportfiel c-wins 
PROCEDURE pd_reportfiel :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wdetail.
    DELETE wdetail.
END.
ASSIGN nv_typre = "".
IF      ra_poltype = 1 THEN nv_typre = "V70".
ELSE IF ra_poltype = 2 THEN nv_typre = "V72".
ELSE nv_typre = "ALL".

IF ra_typedate = 1 THEN DO:   /* comdate */
    IF fi_producer = ""  THEN DO:
        /*IF      cb_report = "All"           THEN RUN pd_repfielAll1.    
        ELSE IF cb_report = "New"           THEN RUN pd_repfielNew1.     
        ELSE IF cb_report = "Renew"         THEN RUN pd_repfielRenew1. 
        ELSE IF cb_report = "Switch"        THEN RUN pd_repfielSwitch1. 
        ELSE IF cb_report = "�Ң�[M]"       THEN RUN pd_repfielBrM1 .
        ELSE IF cb_report = "�Ң�[No-M]"    THEN RUN pd_repfielBRnoM1. 
        ELSE IF cb_report = "Producer"      THEN RUN pd_repfielPro1. 
        ELSE IF cb_report = "Status Yes/No" THEN RUN pd_repfielsts1. */
             IF cb_report = "BR_M"       THEN RUN pd_repfielBrM1 .
        ELSE IF cb_report = "BR[No-M]"   THEN RUN pd_repfielBRnoM1. 
        ELSE IF cb_report = "BR_ALL"     THEN RUN pd_repfielBRALLM1. 
    END.
    ELSE DO:
       /* IF      cb_report = "All"           THEN RUN pd_repfielAll2.    
        ELSE IF cb_report = "New"           THEN RUN pd_repfielNew2.     
        ELSE IF cb_report = "Renew"         THEN RUN pd_repfielRenew2. 
        ELSE IF cb_report = "Switch"        THEN RUN pd_repfielSwitch2. 
        ELSE IF cb_report = "�Ң�[M]"       THEN RUN pd_repfielBrM2 .
        ELSE IF cb_report = "�Ң�[No-M]"    THEN RUN pd_repfielBRnoM2. 
        ELSE IF cb_report = "Producer"      THEN RUN pd_repfielPro2. 
        ELSE IF cb_report = "Status Yes/No" THEN RUN pd_repfielsts2. */
             IF cb_report = "BR_M"        THEN RUN pd_repfielBrM2 .
        ELSE IF cb_report = "BR[No-M]"    THEN RUN pd_repfielBRnoM2. 
        ELSE IF cb_report = "BR_ALL"      THEN RUN pd_repfielBRALLM2. 
    END.
END.
ELSE DO:   /* trandate */
    IF fi_producer = ""  THEN DO:
        /*IF      cb_report = "All"           THEN RUN pd_reportfielAll.    
        ELSE IF cb_report = "New"           THEN RUN pd_reportfielNew.     
        ELSE IF cb_report = "Renew"         THEN RUN pd_reportfielRenew. 
        ELSE IF cb_report = "Switch"        THEN RUN pd_reportfielSwitch. 
        ELSE IF cb_report = "�Ң�[M]"       THEN RUN pd_reportfielBrM .
        ELSE IF cb_report = "�Ң�[No-M]"    THEN RUN pd_reportfielBRnoM. 
        ELSE IF cb_report = "Producer"      THEN RUN pd_reportfielPro. 
        ELSE IF cb_report = "Status Yes/No" THEN RUN pd_reportfielsts. */
             IF cb_report = "BR_M"        THEN RUN pd_reportfielBrM .
        ELSE IF cb_report = "BR[No-M]"    THEN RUN pd_reportfielBRnoM. 
        ELSE IF cb_report = "BR_ALL"      THEN RUN pd_reportfielBRALLM. 
    END.
    ELSE DO:
        /*IF      cb_report = "All"           THEN RUN pd_reportfielAll1.    
        ELSE IF cb_report = "New"           THEN RUN pd_reportfielNew1.     
        ELSE IF cb_report = "Renew"         THEN RUN pd_reportfielRenew1. 
        ELSE IF cb_report = "Switch"        THEN RUN pd_reportfielSwitch1. 
        ELSE IF cb_report = "�Ң�[M]"       THEN RUN pd_reportfielBrM1 .   
        ELSE IF cb_report = "�Ң�[No-M]"    THEN RUN pd_reportfielBRnoM1.  
        ELSE IF cb_report = "Producer"      THEN RUN pd_reportfielPro1.    
        ELSE IF cb_report = "Status Yes/No" THEN RUN pd_reportfielsts1. */
             IF cb_report = "BR_M"         THEN RUN pd_reportfielBrM1 .   
        ELSE IF cb_report = "BR[No-M]"     THEN RUN pd_reportfielBRnoM1.  
        ELSE IF cb_report = "BR_ALL"       THEN RUN pd_reportfielBRALLM1.

    END.

END.
IF rs_typre = 1 THEN DO:
    RUN pd_reportfielTXT. 
    RUN pd_reportfielTXTEX. 
END.
ELSE DO:
    RUN pd_reportfielCSV.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_reportfielAll c-wins 
PROCEDURE pd_reportfielAll :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
For each tlt Use-index  tlt06 Where
    tlt.trndat >=  fi_trndatfr    And
    tlt.trndat <=  fi_trndatto    AND 
    tlt.genusr   =  "HCT"        NO-LOCK 
    BREAK BY brstat.tlt.comp_noti_ins :

   IF      nv_typre = "V70" AND brstat.tlt.nor_usr_ins  = "0" THEN NEXT.
   ELSE IF nv_typre = "V72" AND brstat.tlt.nor_usr_ins <> "0" THEN NEXT.
    
    CREATE  wdetail.
     ASSIGN 
    wdetail.n_text001      =  brstat.tlt.comp_noti_ins  
    wdetail.n_text002      =  brstat.tlt.comp_noti_tlt  
    wdetail.n_text003      =  brstat.tlt.comp_pol       
    wdetail.n_text004      =  string(brstat.tlt.nor_effdat,"99/99/9999")     
    wdetail.n_text005      =  string(brstat.tlt.comp_effdat,"99/99/9999")    
    wdetail.n_text006      =  brstat.tlt.comp_sub       
    wdetail.n_text007      =  brstat.tlt.cifno          
    wdetail.n_text008      =  brstat.tlt.nationality    
    wdetail.n_text009      =  brstat.tlt.nor_noti_ins   
    wdetail.n_text010      =  brstat.tlt.nor_noti_tlt   
    wdetail.n_text011      =  brstat.tlt.nor_usr_ins    
    wdetail.n_text012      =  brstat.tlt.covcod         
    wdetail.n_text013      =  brstat.tlt.nor_usr_tlt    
    wdetail.n_text014      =  brstat.tlt.comp_usr_ins   
    wdetail.n_text015      =  brstat.tlt.ins_title      
    wdetail.n_text016      =  brstat.tlt.ins_name       
    wdetail.n_text017      =  brstat.tlt.ins_firstname  
    wdetail.n_text018      =  brstat.tlt.ins_lastname   
    wdetail.n_text019      =  brstat.tlt.ins_addr       
    wdetail.n_text020      =  brstat.tlt.ins_addr1      
    wdetail.n_text021      =  brstat.tlt.ins_addr2      
    wdetail.n_text022      =  brstat.tlt.ins_addr3      
    wdetail.n_text023      =  brstat.tlt.lince2         
    wdetail.n_text024      =  brstat.tlt.ins_addr5      
    wdetail.n_text025      =  brstat.tlt.dir_occ1       
    wdetail.n_text026      =  brstat.tlt.note28         
    wdetail.n_text027      =  brstat.tlt.dri_ic1        
    wdetail.n_text028      =  brstat.tlt.dri_lic1       
    wdetail.n_text029      =  brstat.tlt.brand          
    wdetail.n_text030      =  substr(brstat.tlt.note10,1,1)         
    wdetail.n_text031      =  substr(brstat.tlt.cha_no,1,25)      
    wdetail.n_text032      =  substr(brstat.tlt.eng_no,1,20)                   
    wdetail.n_text033      =  substr(brstat.tlt.model,1,40)                 
    wdetail.n_text034      =  substr(brstat.tlt.note11,1,4)                  
    wdetail.n_text035      =  substr(brstat.tlt.note12,1,20)                  
    wdetail.n_text036      =  substr(brstat.tlt.note13,1,40)                  
    wdetail.n_text037      =  substr(brstat.tlt.note14,1,1)                   
    /*wdetail.n_text038      =  substr(brstat.tlt.vehuse,1,2) */ /* A68-0061*/
    wdetail.n_text038      =  IF rs_typre = 1 THEN substr(brstat.tlt.vehuse,1,2) ELSE TRIM(brstat.tlt.vehuse)  /* A68-0061*/                   
    wdetail.n_text039      =  string(brstat.tlt.seqno,"99")                        
    wdetail.n_text040      =  string(brstat.tlt.cc_weight,"9999")                  
    wdetail.n_text041      =  substr(brstat.tlt.colorcod,1,40)        
    wdetail.n_text042      =  substr(brstat.tlt.lince1,1,10)        
    wdetail.n_text043      =  substr(brstat.tlt.ins_addr4,1,30)        
    wdetail.n_text044      =  substr(brstat.tlt.note15,1,4)         
    wdetail.n_text045      =  substr(brstat.tlt.note16,1,512)              
    wdetail.n_text046      =  substr(brstat.tlt.note17,1,14)        
    wdetail.n_text047      =  substr(brstat.tlt.note18,1,14)       
    wdetail.n_text048      =  substr(brstat.tlt.note19,1,14)          
    wdetail.n_text049      =  substr(brstat.tlt.note2,1,14)          
    wdetail.n_text050      =  substr(brstat.tlt.note20,1,14)       
    wdetail.n_text051      =  substr(brstat.tlt.note21,1,14)          
    wdetail.n_text052      =  substr(brstat.tlt.note22,1,14)        
    wdetail.n_text053      =  substr(brstat.tlt.note23,1,14)        
    wdetail.n_text054      =  substr(brstat.tlt.comp_sck,1,20)        
    wdetail.n_text055      =  substr(brstat.tlt.note24,1,32)        
    wdetail.n_text056      =  substr(brstat.tlt.dri_no1,1,1)        
    wdetail.n_text057      =  substr(brstat.tlt.dri_no2,1,1)         
    wdetail.n_text058      =  substr(brstat.tlt.note25,1,20)      
    wdetail.n_text059      =  substr(brstat.tlt.dri_name1,1,80)      
    wdetail.n_text060      =  substr(brstat.tlt.note26,1,20)      
    wdetail.n_text061      =  substr(brstat.tlt.note27,1,60)      
    wdetail.n_text062      =  substr(brstat.tlt.dri_occ2,1,50)   
    wdetail.n_text063      =  substr(brstat.tlt.note4,1,10)         
    wdetail.n_text064      =  substr(brstat.tlt.dri_ic2,1,15)         
    wdetail.n_text065      =  substr(brstat.tlt.dri_lic2,1,15)         
    wdetail.n_text066      =  substr(brstat.tlt.note29,1,20)         
    wdetail.n_text067      =  substr(brstat.tlt.dri_name2,1,80)         
    wdetail.n_text068      =  substr(brstat.tlt.note3,1,20)         
    wdetail.n_text069      =  substr(brstat.tlt.note30,1,60)         
    wdetail.n_text070      =  substr(brstat.tlt.ins_occ,1,50)         
    wdetail.n_text071      =  IF brstat.tlt.birthdate = ? THEN "" ELSE string(brstat.tlt.birthdate,"99/99/9999")              
    wdetail.n_text072      =  substr(brstat.tlt.ins_icno,1,15)           
    wdetail.n_text073      =  substr(brstat.tlt.note1,1,15)                   
    wdetail.n_text074      =  substr(brstat.tlt.ben83,1,80)                   
    wdetail.n_text075      =  string(brstat.tlt.comp_coamt,"99999999999.99")      
    wdetail.n_text076      =  string(brstat.tlt.comp_grprm,"99999999999.99")      
    wdetail.n_text077      =     string(brstat.tlt.mileage,"99999999999.99")         
    wdetail.n_text078      =      string(brstat.tlt.ndeci1,"99999999999.99")          
    wdetail.n_text079      =      string(brstat.tlt.ndeci2,"99999999999.99")          
    wdetail.n_text080      =      string(brstat.tlt.ndeci3,"99999999999.99")          
    wdetail.n_text081      =      string(brstat.tlt.ndeci4,"99999999999.99")          
    wdetail.n_text082      =      string(brstat.tlt.ndeci5,"99999999999.99")          
    wdetail.n_text083      =   string(brstat.tlt.nor_coamt,"99")                    
    wdetail.n_text084      =   string(brstat.tlt.nor_grprm,"99999999999.99")       
    wdetail.n_text085      =    string(brstat.tlt.prem_amt,"99999999999.99")        
    wdetail.n_text086     = string(brstat.tlt.prem_amttcop,"99")                 
    wdetail.n_text087      =        string(brstat.tlt.rstp,"99999999999.99")            
    wdetail.n_text088      =        string(brstat.tlt.rtax,"99999999999.99")            
    wdetail.n_text089     = string(brstat.tlt.tax_coporate,"99999999999.99")    
    wdetail.n_text090      =  substr(brstat.tlt.note5,1,6)            
    wdetail.n_text091      =  substr(brstat.tlt.note6,1,10)        
    wdetail.n_text092      =  substr(brstat.tlt.note7,1,10)        
    wdetail.n_text093      =  substr(brstat.tlt.note8,1,30)        
    wdetail.n_text094      =  substr(brstat.tlt.note9,1,80)        
    wdetail.n_text095      =  substr(brstat.tlt.noteveh1,1,10)        
    wdetail.n_text096      =  substr(brstat.tlt.noteveh2,1,30)        
    wdetail.n_text097      =  substr(brstat.tlt.old_cha,1,12)        
    wdetail.n_text098      =  substr(brstat.tlt.old_eng,1,3)             
    wdetail.n_text099      =  substr(brstat.tlt.pack,1,10)      
    wdetail.n_text100      =  substr(brstat.tlt.packnme,1,14)      
    wdetail.n_text101      =  substr(brstat.tlt.period,1,10)      
    wdetail.n_text102      =  substr(brstat.tlt.ln_note1,1,14) 
    wdetail.n_text103      =  substr(brstat.tlt.product,1,10)   
    wdetail.n_text104      =  substr(brstat.tlt.projnme,1,14)   
    wdetail.n_text105      =  substr(brstat.tlt.proveh,1,10)   
    wdetail.n_text106      =  substr(brstat.tlt.race,1,14)   
    wdetail.n_text107      =  substr(brstat.tlt.recac,1,10)   
    wdetail.n_text108      =  substr(brstat.tlt.rec_addr,1,14)   
    wdetail.n_text109      =  substr(brstat.tlt.rec_addr1,1,15)   
    wdetail.n_text110      =  substr(brstat.tlt.rec_addr2,1,10)   
    wdetail.n_text111      =  substr(brstat.tlt.rec_addr3,1,14)   
    wdetail.n_text112      =  substr(brstat.tlt.rec_addr4,1,10)   
    wdetail.n_text113      =  substr(brstat.tlt.rec_addr5,1,20)   
    wdetail.n_text114      =  substr(brstat.tlt.rec_brins,1,1)         
    wdetail.n_text115      =  substr(brstat.tlt.rec_cou,1,120)      
    wdetail.n_text116      =  substr(brstat.tlt.rec_icno,1,100)      
    wdetail.n_text117      =  substr(brstat.tlt.rec_name,1,2)         
    wdetail.n_text118      =  substr(brstat.tlt.rec_name2,1,2)         
    wdetail.n_text119      =  substr(brstat.tlt.rec_note1,1,10)        
    wdetail.n_text120      =  substr(brstat.tlt.rec_note2,1,1)        
    wdetail.n_text121      =  substr(brstat.tlt.rec_title,1,10)        
    wdetail.n_text122      =  substr(brstat.tlt.rec_typ,1,255)       
    wdetail.n_text123      =  substr(brstat.tlt.rider,1,5)         
    wdetail.n_text124      =  substr(brstat.tlt.safe1,1,20)        
    wdetail.n_text125      =  substr(brstat.tlt.safe2,1,10)        
    wdetail.n_text126      =  substr(brstat.tlt.safe3,1,150)       
    wdetail.n_text127      =  substr(brstat.tlt.sex,1,15)        
    wdetail.n_text128      =  substr(brstat.tlt.stat,1,250)       
    wdetail.n_text129      =  substr(brstat.tlt.subins,1,13)        
    wdetail.n_text130      =  substr(brstat.tlt.tel,1,10)        
    wdetail.n_text131      =  substr(brstat.tlt.tel2,1,150)      
    wdetail.n_text132      =  substr(brstat.tlt.tel3,1,15)       
    wdetail.n_text133      =  substr(brstat.tlt.usrid,1,250)       
    wdetail.n_text134      =  substr(brstat.tlt.usrsent,1,13)       
    wdetail.n_text135      =  substr(brstat.tlt.ln_product,1,10)     
    wdetail.n_text136      =  substr(brstat.tlt.ln_pronme,1,150)    
    wdetail.n_text137      =  substr(brstat.tlt.ln_rate,1,15)     
    wdetail.n_text138      =  substr(brstat.tlt.ln_st,1,250)    
    wdetail.n_text139      =  substr(brstat.tlt.lotno,1,13)    
    wdetail.n_text140      =  substr(brstat.tlt.maritalsts,1,10)    
    wdetail.n_text141      =  substr(brstat.tlt.campaign,1,12)    
    wdetail.n_text142      =  substr(brstat.tlt.mobile,1,10)    
    wdetail.n_text143      =  brstat.tlt.acno1   
    wdetail.n_text144      =  brstat.tlt.agent  .
    /* ADD BY : A68-0061 */
    ASSIGN 
    wdetail.typepol    =   brstat.tlt.poltyp
    wdetail.typecar    =   brstat.tlt.car_type
    wdetail.maksi      =   STRING(brstat.tlt.maksi)
    wdetail.drivexp1   =   brstat.tlt.dri_licenexp1
    wdetail.drivcon1   =   string(brstat.tlt.dri_consen1)
    wdetail.dlevel1    =   string(brstat.tlt.dri_level1)
    wdetail.dgender1   =   brstat.tlt.dri_gender1
    wdetail.drivexp2   =   brstat.tlt.dri_licenexp2
    wdetail.drivcon2   =   string(brstat.tlt.dri_consen2)
    wdetail.dlevel2    =   string(brstat.tlt.dri_level2)
    wdetail.dgender2   =   brstat.tlt.dri_gender2
    wdetail.ntitle3    =   brstat.tlt.dri_title3
    wdetail.dname3     =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,1,INDEX(brstat.tlt.dri_fname3," ") - 1) ELSE TRIM(brstat.tlt.dri_fname3)
    wdetail.dcname3    =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,R-INDEX(brstat.tlt.dri_fname3," ")) ELSE "" 
    wdetail.dlname3    =   brstat.tlt.dri_lname3
    wdetail.doccup3    =   brstat.tlt.dir_occ3
    wdetail.dbirth3    =   brstat.tlt.dri_birth3
    wdetail.dicno3     =   brstat.tlt.dri_ic3
    wdetail.ddriveno3  =   brstat.tlt.dri_lic3
    wdetail.drivexp3   =   brstat.tlt.dri_licenexp3
    wdetail.drivcon3   =   string(brstat.tlt.dri_consen3)
    wdetail.dlevel3    =   string(brstat.tlt.dri_level3)
    wdetail.dgender3   =   brstat.tlt.dri_gender3
    wdetail.ntitle4    =   brstat.tlt.dri_title4
    wdetail.dname4     =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,1,INDEX(brstat.tlt.dri_fname4," ") - 1) ELSE TRIM(brstat.tlt.dri_fname4)
    wdetail.dcname4    =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,R-INDEX(brstat.tlt.dri_fname4," ")) ELSE ""
    wdetail.dlname4    =   brstat.tlt.dri_lname4
    wdetail.doccup4    =   brstat.tlt.dri_occ4
    wdetail.dbirth4    =   brstat.tlt.dri_birth4
    wdetail.dicno4     =   brstat.tlt.dri_ic4
    wdetail.ddriveno4  =   brstat.tlt.dri_lic4
    wdetail.drivexp4   =   brstat.tlt.dri_licenexp4
    wdetail.drivcon4   =   string(brstat.tlt.dri_consen4)
    wdetail.dlevel4    =   string(brstat.tlt.dri_level4)
    wdetail.dgender4   =   brstat.tlt.dri_gender4
    wdetail.ntitle5    =   brstat.tlt.dri_title5
    wdetail.dname5     =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,1,INDEX(brstat.tlt.dri_fname5," ") - 1) ELSE TRIM(brstat.tlt.dri_fname5)
    wdetail.dcname5    =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,R-INDEX(brstat.tlt.dri_fname5," ")) ELSE "" 
    wdetail.dlname5    =   brstat.tlt.dri_lname5
    wdetail.doccup5    =   brstat.tlt.dri_occ5
    wdetail.dbirth5    =   brstat.tlt.dri_birth5
    wdetail.dicno5     =   brstat.tlt.dri_ic5
    wdetail.ddriveno5  =   brstat.tlt.dri_lic5
    wdetail.drivexp5   =   brstat.tlt.dri_licenexp5
    wdetail.drivcon5   =   string(brstat.tlt.dri_consen5)
    wdetail.dlevel5    =   string(brstat.tlt.dri_level5)
    wdetail.dgender5   =   brstat.tlt.dri_gender5  
    wdetail.chargflg    =  STRING(brstat.tlt.chargflg)
    wdetail.chargprice  =  STRING(brstat.tlt.chargsi)
    wdetail.chargno     =  brstat.tlt.chargno
    wdetail.chargprm    =  string(brstat.tlt.chargprem)
    wdetail.battflg     =  string(brstat.tlt.battflg  )
    wdetail.battprice   =  string(brstat.tlt.battprice)
    wdetail.battno      =  brstat.tlt.battno
    wdetail.battprm     =  string(brstat.tlt.battprem)
    wdetail.battdate    =  string(brstat.tlt.ndate1,"99/99/9999")
    wdetail.net_re1     =  string(brstat.tlt.dg_prem)
    wdetail.stam_re1    =  string(brstat.tlt.dg_rstp_t)
    wdetail.vat_re1     =  string(brstat.tlt.dg_rtax_t)
    wdetail.inscode_re2 =  brstat.tlt.ins_code
    wdetail.net_re2     =  string(brstat.tlt.dg_si  )
    wdetail.stam_re2    =  string(brstat.tlt.dg_rate)
    wdetail.vat_re2     =  string(brstat.tlt.dg_feet)
    wdetail.inscode_re3 =  brstat.tlt.Paycode
    wdetail.net_re3     =  string(brstat.tlt.dg_ncb  )
    wdetail.stam_re3    =  string(brstat.tlt.dg_disc )
    wdetail.vat_re3     =  string(brstat.tlt.dg_wdisc) .
 /* END : A68-0061 */
END. 
 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_reportfielAll1 c-wins 
PROCEDURE pd_reportfielAll1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wproducer NO-LOCK.
    For each tlt Use-index  tlt06 Where
        tlt.trndat >=  fi_trndatfr    And
        tlt.trndat <=  fi_trndatto    AND 
        /*tlt.acno1 =  trim(fi_producer)  AND*/
        tlt.acno1   =  wproducer.producer  AND 
        tlt.genusr  =  "HCT"        NO-LOCK 
    BREAK BY brstat.tlt.comp_noti_ins :

    IF      nv_typre = "V70" AND brstat.tlt.nor_usr_ins  = "0" THEN NEXT.
    ELSE IF nv_typre = "V72" AND brstat.tlt.nor_usr_ins <> "0" THEN NEXT.

    CREATE  wdetail.
    ASSIGN 
     wdetail.n_text001      =  brstat.tlt.comp_noti_ins  
     wdetail.n_text002      =  brstat.tlt.comp_noti_tlt  
     wdetail.n_text003      =  brstat.tlt.comp_pol       
     wdetail.n_text004      =  string(brstat.tlt.nor_effdat,"99/99/9999")     
     wdetail.n_text005      =  string(brstat.tlt.comp_effdat,"99/99/9999")    
     wdetail.n_text006      =  brstat.tlt.comp_sub       
     wdetail.n_text007      =  brstat.tlt.cifno          
     wdetail.n_text008      =  brstat.tlt.nationality    
     wdetail.n_text009      =  brstat.tlt.nor_noti_ins   
     wdetail.n_text010      =  brstat.tlt.nor_noti_tlt   
     wdetail.n_text011      =  brstat.tlt.nor_usr_ins    
     wdetail.n_text012      =  brstat.tlt.covcod         
     wdetail.n_text013      =  brstat.tlt.nor_usr_tlt    
     wdetail.n_text014      =  brstat.tlt.comp_usr_ins   
     wdetail.n_text015      =  brstat.tlt.ins_title      
     wdetail.n_text016      =  brstat.tlt.ins_name       
     wdetail.n_text017      =  brstat.tlt.ins_firstname  
     wdetail.n_text018      =  brstat.tlt.ins_lastname   
     wdetail.n_text019      =  brstat.tlt.ins_addr       
     wdetail.n_text020      =  brstat.tlt.ins_addr1      
     wdetail.n_text021      =  brstat.tlt.ins_addr2      
     wdetail.n_text022      =  brstat.tlt.ins_addr3      
     wdetail.n_text023      =  brstat.tlt.lince2         
     wdetail.n_text024      =  brstat.tlt.ins_addr5      
     wdetail.n_text025      =  brstat.tlt.dir_occ1       
     wdetail.n_text026      =  brstat.tlt.note28         
     wdetail.n_text027      =  brstat.tlt.dri_ic1        
     wdetail.n_text028      =  brstat.tlt.dri_lic1       
     wdetail.n_text029      =  brstat.tlt.brand          
     wdetail.n_text030      =  substr(brstat.tlt.note10,1,1)         
     wdetail.n_text031      =  substr(brstat.tlt.cha_no,1,25)      
     wdetail.n_text032      =  substr(brstat.tlt.eng_no,1,20)                   
     wdetail.n_text033      =  substr(brstat.tlt.model,1,40)                 
     wdetail.n_text034      =  substr(brstat.tlt.note11,1,4)                  
     wdetail.n_text035      =  substr(brstat.tlt.note12,1,20)                  
     wdetail.n_text036      =  substr(brstat.tlt.note13,1,40)                  
     wdetail.n_text037      =  substr(brstat.tlt.note14,1,1)                   
     /*wdetail.n_text038      =  substr(brstat.tlt.vehuse,1,2) */ /* A68-0061*/
     wdetail.n_text038      =  IF rs_typre = 1 THEN substr(brstat.tlt.vehuse,1,2) ELSE TRIM(brstat.tlt.vehuse)  /* A68-0061*/                 
     wdetail.n_text039      =  string(brstat.tlt.seqno,"99")                        
     wdetail.n_text040      =  string(brstat.tlt.cc_weight,"9999")                  
     wdetail.n_text041      =  substr(brstat.tlt.colorcod,1,40)        
     wdetail.n_text042      =  substr(brstat.tlt.lince1,1,10)        
     wdetail.n_text043      =  substr(brstat.tlt.ins_addr4,1,30)        
     wdetail.n_text044      =  substr(brstat.tlt.note15,1,4)         
     wdetail.n_text045      =  substr(brstat.tlt.note16,1,512)              
     wdetail.n_text046      =  substr(brstat.tlt.note17,1,14)        
     wdetail.n_text047      =  substr(brstat.tlt.note18,1,14)       
     wdetail.n_text048      =  substr(brstat.tlt.note19,1,14)          
     wdetail.n_text049      =  substr(brstat.tlt.note2,1,14)          
     wdetail.n_text050      =  substr(brstat.tlt.note20,1,14)       
     wdetail.n_text051      =  substr(brstat.tlt.note21,1,14)          
     wdetail.n_text052      =  substr(brstat.tlt.note22,1,14)        
     wdetail.n_text053      =  substr(brstat.tlt.note23,1,14)        
     wdetail.n_text054      =  substr(brstat.tlt.comp_sck,1,20)        
     wdetail.n_text055      =  substr(brstat.tlt.note24,1,32)        
     wdetail.n_text056      =  substr(brstat.tlt.dri_no1,1,1)        
     wdetail.n_text057      =  substr(brstat.tlt.dri_no2,1,1)         
     wdetail.n_text058      =  substr(brstat.tlt.note25,1,20)      
     wdetail.n_text059      =  substr(brstat.tlt.dri_name1,1,80)      
     wdetail.n_text060      =  substr(brstat.tlt.note26,1,20)      
     wdetail.n_text061      =  substr(brstat.tlt.note27,1,60)      
     wdetail.n_text062      =  substr(brstat.tlt.dri_occ2,1,50)   
     wdetail.n_text063      =  substr(brstat.tlt.note4,1,10)         
     wdetail.n_text064      =  substr(brstat.tlt.dri_ic2,1,15)         
     wdetail.n_text065      =  substr(brstat.tlt.dri_lic2,1,15)         
     wdetail.n_text066      =  substr(brstat.tlt.note29,1,20)         
     wdetail.n_text067      =  substr(brstat.tlt.dri_name2,1,80)         
     wdetail.n_text068      =  substr(brstat.tlt.note3,1,20)         
     wdetail.n_text069      =  substr(brstat.tlt.note30,1,60)         
     wdetail.n_text070      =  substr(brstat.tlt.ins_occ,1,50)         
     wdetail.n_text071      =  IF brstat.tlt.birthdate = ? THEN "" ELSE string(brstat.tlt.birthdate,"99/99/9999")              
     wdetail.n_text072      =  substr(brstat.tlt.ins_icno,1,15)           
     wdetail.n_text073      =  substr(brstat.tlt.note1,1,15)                   
     wdetail.n_text074      =  substr(brstat.tlt.ben83,1,80)                   
     wdetail.n_text075      =  string(brstat.tlt.comp_coamt,"99999999999.99")      
     wdetail.n_text076      =  string(brstat.tlt.comp_grprm,"99999999999.99")      
     wdetail.n_text077      =  string(brstat.tlt.mileage,"99999999999.99")         
     wdetail.n_text078      =  string(brstat.tlt.ndeci1,"99999999999.99")          
     wdetail.n_text079      =  string(brstat.tlt.ndeci2,"99999999999.99")          
     wdetail.n_text080      =  string(brstat.tlt.ndeci3,"99999999999.99")          
     wdetail.n_text081      =  string(brstat.tlt.ndeci4,"99999999999.99")          
     wdetail.n_text082      =  string(brstat.tlt.ndeci5,"99999999999.99")          
     wdetail.n_text083      =  string(brstat.tlt.nor_coamt,"99")                    
     wdetail.n_text084      =  string(brstat.tlt.nor_grprm,"99999999999.99")       
     wdetail.n_text085      =  string(brstat.tlt.prem_amt,"99999999999.99")        
     wdetail.n_text086      =  string(brstat.tlt.prem_amttcop,"99")                 
     wdetail.n_text087      =  string(brstat.tlt.rstp,"99999999999.99")            
     wdetail.n_text088      =  string(brstat.tlt.rtax,"99999999999.99")            
     wdetail.n_text089      =  string(brstat.tlt.tax_coporate,"99999999999.99")    
     wdetail.n_text090      =  substr(brstat.tlt.note5,1,6)            
     wdetail.n_text091      =  substr(brstat.tlt.note6,1,10)        
     wdetail.n_text092      =  substr(brstat.tlt.note7,1,10)        
     wdetail.n_text093      =  substr(brstat.tlt.note8,1,30)        
     wdetail.n_text094      =  substr(brstat.tlt.note9,1,80)        
     wdetail.n_text095      =  substr(brstat.tlt.noteveh1,1,10)        
     wdetail.n_text096      =  substr(brstat.tlt.noteveh2,1,30)        
     wdetail.n_text097      =  substr(brstat.tlt.old_cha,1,12)        
     wdetail.n_text098      =  substr(brstat.tlt.old_eng,1,3)             
     wdetail.n_text099      =  substr(brstat.tlt.pack,1,10)      
     wdetail.n_text100      =  substr(brstat.tlt.packnme,1,14)      
     wdetail.n_text101      =  substr(brstat.tlt.period,1,10)      
     wdetail.n_text102      =  substr(brstat.tlt.ln_note1,1,14) 
     wdetail.n_text103      =  substr(brstat.tlt.product,1,10)   
     wdetail.n_text104      =  substr(brstat.tlt.projnme,1,14)   
     wdetail.n_text105      =  substr(brstat.tlt.proveh,1,10)   
     wdetail.n_text106      =  substr(brstat.tlt.race,1,14)   
     wdetail.n_text107      =  substr(brstat.tlt.recac,1,10)   
     wdetail.n_text108      =  substr(brstat.tlt.rec_addr,1,14)   
     wdetail.n_text109      =  substr(brstat.tlt.rec_addr1,1,15)   
     wdetail.n_text110      =  substr(brstat.tlt.rec_addr2,1,10)   
     wdetail.n_text111      =  substr(brstat.tlt.rec_addr3,1,14)   
     wdetail.n_text112      =  substr(brstat.tlt.rec_addr4,1,10)   
     wdetail.n_text113      =  substr(brstat.tlt.rec_addr5,1,20)   
     wdetail.n_text114      =  substr(brstat.tlt.rec_brins,1,1)         
     wdetail.n_text115      =  substr(brstat.tlt.rec_cou,1,120)      
     wdetail.n_text116      =  substr(brstat.tlt.rec_icno,1,100)      
     wdetail.n_text117      =  substr(brstat.tlt.rec_name,1,2)         
     wdetail.n_text118      =  substr(brstat.tlt.rec_name2,1,2)         
     wdetail.n_text119      =  substr(brstat.tlt.rec_note1,1,10)        
     wdetail.n_text120      =  substr(brstat.tlt.rec_note2,1,1)        
     wdetail.n_text121      =  substr(brstat.tlt.rec_title,1,10)        
     wdetail.n_text122      =  substr(brstat.tlt.rec_typ,1,255)       
     wdetail.n_text123      =  substr(brstat.tlt.rider,1,5)         
     wdetail.n_text124      =  substr(brstat.tlt.safe1,1,20)        
     wdetail.n_text125      =  substr(brstat.tlt.safe2,1,10)        
     wdetail.n_text126      =  substr(brstat.tlt.safe3,1,150)       
     wdetail.n_text127      =  substr(brstat.tlt.sex,1,15)        
     wdetail.n_text128      =  substr(brstat.tlt.stat,1,250)       
     wdetail.n_text129      =  substr(brstat.tlt.subins,1,13)        
     wdetail.n_text130      =  substr(brstat.tlt.tel,1,10)        
     wdetail.n_text131      =  substr(brstat.tlt.tel2,1,150)      
     wdetail.n_text132      =  substr(brstat.tlt.tel3,1,15)       
     wdetail.n_text133      =  substr(brstat.tlt.usrid,1,250)       
     wdetail.n_text134      =  substr(brstat.tlt.usrsent,1,13)       
     wdetail.n_text135      =  substr(brstat.tlt.ln_product,1,10)     
     wdetail.n_text136      =  substr(brstat.tlt.ln_pronme,1,150)    
     wdetail.n_text137      =  substr(brstat.tlt.ln_rate,1,15)     
     wdetail.n_text138      =  substr(brstat.tlt.ln_st,1,250)    
     wdetail.n_text139      =  substr(brstat.tlt.lotno,1,13)    
     wdetail.n_text140      =  substr(brstat.tlt.maritalsts,1,10)    
     wdetail.n_text141      =  substr(brstat.tlt.campaign,1,12)    
     wdetail.n_text142      =  substr(brstat.tlt.mobile,1,10)     
     wdetail.n_text143      =  brstat.tlt.acno1   
     wdetail.n_text144      =  brstat.tlt.agent  .
     /* ADD BY : A68-0061 */
    ASSIGN 
    wdetail.typepol    =   brstat.tlt.poltyp
    wdetail.typecar    =   brstat.tlt.car_type
    wdetail.maksi      =   STRING(brstat.tlt.maksi)
    wdetail.drivexp1   =   brstat.tlt.dri_licenexp1
    wdetail.drivcon1   =   string(brstat.tlt.dri_consen1)
    wdetail.dlevel1    =   string(brstat.tlt.dri_level1)
    wdetail.dgender1   =   brstat.tlt.dri_gender1
    wdetail.drivexp2   =   brstat.tlt.dri_licenexp2
    wdetail.drivcon2   =   string(brstat.tlt.dri_consen2)
    wdetail.dlevel2    =   string(brstat.tlt.dri_level2)
    wdetail.dgender2   =   brstat.tlt.dri_gender2
    wdetail.ntitle3    =   brstat.tlt.dri_title3
    wdetail.dname3     =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,1,INDEX(brstat.tlt.dri_fname3," ") - 1) ELSE TRIM(brstat.tlt.dri_fname3)
    wdetail.dcname3    =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,R-INDEX(brstat.tlt.dri_fname3," ")) ELSE "" 
    wdetail.dlname3    =   brstat.tlt.dri_lname3
    wdetail.doccup3    =   brstat.tlt.dir_occ3
    wdetail.dbirth3    =   brstat.tlt.dri_birth3
    wdetail.dicno3     =   brstat.tlt.dri_ic3
    wdetail.ddriveno3  =   brstat.tlt.dri_lic3
    wdetail.drivexp3   =   brstat.tlt.dri_licenexp3
    wdetail.drivcon3   =   string(brstat.tlt.dri_consen3)
    wdetail.dlevel3    =   string(brstat.tlt.dri_level3)
    wdetail.dgender3   =   brstat.tlt.dri_gender3
    wdetail.ntitle4    =   brstat.tlt.dri_title4
    wdetail.dname4     =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,1,INDEX(brstat.tlt.dri_fname4," ") - 1) ELSE TRIM(brstat.tlt.dri_fname4)
    wdetail.dcname4    =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,R-INDEX(brstat.tlt.dri_fname4," ")) ELSE ""
    wdetail.dlname4    =   brstat.tlt.dri_lname4
    wdetail.doccup4    =   brstat.tlt.dri_occ4
    wdetail.dbirth4    =   brstat.tlt.dri_birth4
    wdetail.dicno4     =   brstat.tlt.dri_ic4
    wdetail.ddriveno4  =   brstat.tlt.dri_lic4
    wdetail.drivexp4   =   brstat.tlt.dri_licenexp4
    wdetail.drivcon4   =   string(brstat.tlt.dri_consen4)
    wdetail.dlevel4    =   string(brstat.tlt.dri_level4)
    wdetail.dgender4   =   brstat.tlt.dri_gender4
    wdetail.ntitle5    =   brstat.tlt.dri_title5
    wdetail.dname5     =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,1,INDEX(brstat.tlt.dri_fname5," ") - 1) ELSE TRIM(brstat.tlt.dri_fname5)
    wdetail.dcname5    =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,R-INDEX(brstat.tlt.dri_fname5," ")) ELSE "" 
    wdetail.dlname5    =   brstat.tlt.dri_lname5
    wdetail.doccup5    =   brstat.tlt.dri_occ5
    wdetail.dbirth5    =   brstat.tlt.dri_birth5
    wdetail.dicno5     =   brstat.tlt.dri_ic5
    wdetail.ddriveno5  =   brstat.tlt.dri_lic5
    wdetail.drivexp5   =   brstat.tlt.dri_licenexp5
    wdetail.drivcon5   =   string(brstat.tlt.dri_consen5)
    wdetail.dlevel5    =   string(brstat.tlt.dri_level5)
    wdetail.dgender5   =   brstat.tlt.dri_gender5  
    wdetail.chargflg    =  STRING(brstat.tlt.chargflg)
    wdetail.chargprice  =  STRING(brstat.tlt.chargsi)
    wdetail.chargno     =  brstat.tlt.chargno
    wdetail.chargprm    =  string(brstat.tlt.chargprem)
    wdetail.battflg     =  string(brstat.tlt.battflg  )
    wdetail.battprice   =  string(brstat.tlt.battprice)
    wdetail.battno      =  brstat.tlt.battno
    wdetail.battprm     =  string(brstat.tlt.battprem)
    wdetail.battdate    =  string(brstat.tlt.ndate1,"99/99/9999")
    wdetail.net_re1     =  string(brstat.tlt.dg_prem)
    wdetail.stam_re1    =  string(brstat.tlt.dg_rstp_t)
    wdetail.vat_re1     =  string(brstat.tlt.dg_rtax_t)
    wdetail.inscode_re2 =  brstat.tlt.ins_code
    wdetail.net_re2     =  string(brstat.tlt.dg_si  )
    wdetail.stam_re2    =  string(brstat.tlt.dg_rate)
    wdetail.vat_re2     =  string(brstat.tlt.dg_feet)
    wdetail.inscode_re3 =  brstat.tlt.Paycode
    wdetail.net_re3     =  string(brstat.tlt.dg_ncb  )
    wdetail.stam_re3    =  string(brstat.tlt.dg_disc )
    wdetail.vat_re3     =  string(brstat.tlt.dg_wdisc) .
 /* END : A68-0061 */
    END.
END. 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_reportfielBRALLM c-wins 
PROCEDURE pd_reportfielBRALLM :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    For each tlt Use-index  tlt06 Where
        tlt.trndat   >=  fi_trndatfr And
        tlt.trndat   <=  fi_trndatto AND 
        tlt.genusr    =  "HCT"         NO-LOCK
        BREAK BY brstat.tlt.comp_noti_ins :
        IF      nv_typre = "V70" AND brstat.tlt.nor_usr_ins  = "0" THEN NEXT.
        ELSE IF nv_typre = "V72" AND brstat.tlt.nor_usr_ins <> "0" THEN NEXT.
        IF brstat.tlt.releas <> cb_reportstatus  THEN NEXT.
        CREATE  wdetail.
        ASSIGN 
        wdetail.n_text001      =  brstat.tlt.comp_noti_ins  
        wdetail.n_text002      =  brstat.tlt.comp_noti_tlt  
        wdetail.n_text003      =  brstat.tlt.comp_pol       
        wdetail.n_text004      =  string(brstat.tlt.nor_effdat,"99/99/9999")     
        wdetail.n_text005      =  string(brstat.tlt.comp_effdat,"99/99/9999")    
        wdetail.n_text006      =  brstat.tlt.comp_sub       
        wdetail.n_text007      =  brstat.tlt.cifno          
        wdetail.n_text008      =  brstat.tlt.nationality    
        wdetail.n_text009      =  brstat.tlt.nor_noti_ins   
        wdetail.n_text010      =  brstat.tlt.nor_noti_tlt   
        wdetail.n_text011      =  brstat.tlt.nor_usr_ins    
        wdetail.n_text012      =  brstat.tlt.covcod         
        wdetail.n_text013      =  brstat.tlt.nor_usr_tlt    
        wdetail.n_text014      =  brstat.tlt.comp_usr_ins   
        wdetail.n_text015      =  brstat.tlt.ins_title      
        wdetail.n_text016      =  brstat.tlt.ins_name       
        wdetail.n_text017      =  brstat.tlt.ins_firstname  
        wdetail.n_text018      =  brstat.tlt.ins_lastname   
        wdetail.n_text019      =  brstat.tlt.ins_addr       
        wdetail.n_text020      =  brstat.tlt.ins_addr1      
        wdetail.n_text021      =  brstat.tlt.ins_addr2      
        wdetail.n_text022      =  brstat.tlt.ins_addr3      
        wdetail.n_text023      =  brstat.tlt.lince2         
        wdetail.n_text024      =  brstat.tlt.ins_addr5      
        wdetail.n_text025      =  brstat.tlt.dir_occ1       
        wdetail.n_text026      =  brstat.tlt.note28         
        wdetail.n_text027      =  brstat.tlt.dri_ic1        
        wdetail.n_text028      =  brstat.tlt.dri_lic1       
        wdetail.n_text029      =  brstat.tlt.brand          
        wdetail.n_text030      =  substr(brstat.tlt.note10,1,1)         
        wdetail.n_text031      =  substr(brstat.tlt.cha_no,1,25)      
        wdetail.n_text032      =  substr(brstat.tlt.eng_no,1,20)                   
        wdetail.n_text033      =  substr(brstat.tlt.model,1,40)                 
        wdetail.n_text034      =  substr(brstat.tlt.note11,1,4)                  
        wdetail.n_text035      =  substr(brstat.tlt.note12,1,20)                  
        wdetail.n_text036      =  substr(brstat.tlt.note13,1,40)                  
        wdetail.n_text037      =  substr(brstat.tlt.note14,1,1)                   
        /*wdetail.n_text038      =  substr(brstat.tlt.vehuse,1,2) */ /* A68-0061*/
        wdetail.n_text038      =  IF rs_typre = 1 THEN substr(brstat.tlt.vehuse,1,2) ELSE TRIM(brstat.tlt.vehuse)  /* A68-0061*/                   
        wdetail.n_text039      =  string(brstat.tlt.seqno,"99")                        
        wdetail.n_text040      =  string(brstat.tlt.cc_weight,"9999")                  
        wdetail.n_text041      =  substr(brstat.tlt.colorcod,1,40)        
        wdetail.n_text042      =  substr(brstat.tlt.lince1,1,10)        
        wdetail.n_text043      =  substr(brstat.tlt.ins_addr4,1,30)        
        wdetail.n_text044      =  substr(brstat.tlt.note15,1,4)         
        wdetail.n_text045      =  substr(brstat.tlt.note16,1,512)              
        wdetail.n_text046      =  substr(brstat.tlt.note17,1,14)        
        wdetail.n_text047      =  substr(brstat.tlt.note18,1,14)       
        wdetail.n_text048      =  substr(brstat.tlt.note19,1,14)          
        wdetail.n_text049      =  substr(brstat.tlt.note2,1,14)          
        wdetail.n_text050      =  substr(brstat.tlt.note20,1,14)       
        wdetail.n_text051      =  substr(brstat.tlt.note21,1,14)          
        wdetail.n_text052      =  substr(brstat.tlt.note22,1,14)        
        wdetail.n_text053      =  substr(brstat.tlt.note23,1,14)        
        wdetail.n_text054      =  substr(brstat.tlt.comp_sck,1,20)        
        wdetail.n_text055      =  substr(brstat.tlt.note24,1,32)        
        wdetail.n_text056      =  substr(brstat.tlt.dri_no1,1,1)        
        wdetail.n_text057      =  substr(brstat.tlt.dri_no2,1,1)         
        wdetail.n_text058      =  substr(brstat.tlt.note25,1,20)      
        wdetail.n_text059      =  substr(brstat.tlt.dri_name1,1,80)      
        wdetail.n_text060      =  substr(brstat.tlt.note26,1,20)      
        wdetail.n_text061      =  substr(brstat.tlt.note27,1,60)      
        wdetail.n_text062      =  substr(brstat.tlt.dri_occ2,1,50)   
        wdetail.n_text063      =  substr(brstat.tlt.note4,1,10)         
        wdetail.n_text064      =  substr(brstat.tlt.dri_ic2,1,15)         
        wdetail.n_text065      =  substr(brstat.tlt.dri_lic2,1,15)         
        wdetail.n_text066      =  substr(brstat.tlt.note29,1,20)         
        wdetail.n_text067      =  substr(brstat.tlt.dri_name2,1,80)         
        wdetail.n_text068      =  substr(brstat.tlt.note3,1,20)         
        wdetail.n_text069      =  substr(brstat.tlt.note30,1,60)         
        wdetail.n_text070      =  substr(brstat.tlt.ins_occ,1,50)         
        wdetail.n_text071      =  IF brstat.tlt.birthdate = ? THEN "" ELSE string(brstat.tlt.birthdate,"99/99/9999")              
        wdetail.n_text072      =  substr(brstat.tlt.ins_icno,1,15)           
        wdetail.n_text073      =  substr(brstat.tlt.note1,1,15)                   
        wdetail.n_text074      =  substr(brstat.tlt.ben83,1,80)                   
        wdetail.n_text075      =  string(brstat.tlt.comp_coamt,"99999999999.99")      
        wdetail.n_text076      =  string(brstat.tlt.comp_grprm,"99999999999.99")      
        wdetail.n_text077      =     string(brstat.tlt.mileage,"99999999999.99")         
        wdetail.n_text078      =      string(brstat.tlt.ndeci1,"99999999999.99")          
        wdetail.n_text079      =      string(brstat.tlt.ndeci2,"99999999999.99")          
        wdetail.n_text080      =      string(brstat.tlt.ndeci3,"99999999999.99")          
        wdetail.n_text081      =      string(brstat.tlt.ndeci4,"99999999999.99")          
        wdetail.n_text082      =      string(brstat.tlt.ndeci5,"99999999999.99")          
        wdetail.n_text083      =   string(brstat.tlt.nor_coamt,"99")                    
        wdetail.n_text084      =   string(brstat.tlt.nor_grprm,"99999999999.99")       
        wdetail.n_text085      =    string(brstat.tlt.prem_amt,"99999999999.99")        
        wdetail.n_text086      = string(brstat.tlt.prem_amttcop,"99")                 
        wdetail.n_text087      =        string(brstat.tlt.rstp,"99999999999.99")            
        wdetail.n_text088      =        string(brstat.tlt.rtax,"99999999999.99")            
        wdetail.n_text089      = string(brstat.tlt.tax_coporate,"99999999999.99")    
        wdetail.n_text090      =  substr(brstat.tlt.note5,1,6)            
        wdetail.n_text091      =  substr(brstat.tlt.note6,1,10)        
        wdetail.n_text092      =  substr(brstat.tlt.note7,1,10)        
        wdetail.n_text093      =  substr(brstat.tlt.note8,1,30)        
        wdetail.n_text094      =  substr(brstat.tlt.note9,1,80)        
        wdetail.n_text095      =  substr(brstat.tlt.noteveh1,1,10)        
        wdetail.n_text096      =  substr(brstat.tlt.noteveh2,1,30)        
        wdetail.n_text097      =  substr(brstat.tlt.old_cha,1,12)        
        wdetail.n_text098      =  substr(brstat.tlt.old_eng,1,3)             
        wdetail.n_text099      =  substr(brstat.tlt.pack,1,10)      
        wdetail.n_text100      =  substr(brstat.tlt.packnme,1,14)      
        wdetail.n_text101      =  substr(brstat.tlt.period,1,10)      
        wdetail.n_text102      =  substr(brstat.tlt.ln_note1,1,14) 
        wdetail.n_text103      =  substr(brstat.tlt.product,1,10)   
        wdetail.n_text104      =  substr(brstat.tlt.projnme,1,14)   
        wdetail.n_text105      =  substr(brstat.tlt.proveh,1,10)   
        wdetail.n_text106      =  substr(brstat.tlt.race,1,14)   
        wdetail.n_text107      =  substr(brstat.tlt.recac,1,10)   
        wdetail.n_text108      =  substr(brstat.tlt.rec_addr,1,14)   
        wdetail.n_text109      =  substr(brstat.tlt.rec_addr1,1,15)   
        wdetail.n_text110      =  substr(brstat.tlt.rec_addr2,1,10)   
        wdetail.n_text111      =  substr(brstat.tlt.rec_addr3,1,14)   
        wdetail.n_text112      =  substr(brstat.tlt.rec_addr4,1,10)   
        wdetail.n_text113      =  substr(brstat.tlt.rec_addr5,1,20)   
        wdetail.n_text114      =  substr(brstat.tlt.rec_brins,1,1)         
        wdetail.n_text115      =  substr(brstat.tlt.rec_cou,1,120)      
        wdetail.n_text116      =  substr(brstat.tlt.rec_icno,1,100)      
        wdetail.n_text117      =  substr(brstat.tlt.rec_name,1,2)         
        wdetail.n_text118      =  substr(brstat.tlt.rec_name2,1,2)         
        wdetail.n_text119      =  substr(brstat.tlt.rec_note1,1,10)        
        wdetail.n_text120      =  substr(brstat.tlt.rec_note2,1,1)        
        wdetail.n_text121      =  substr(brstat.tlt.rec_title,1,10)        
        wdetail.n_text122      =  substr(brstat.tlt.rec_typ,1,255)       
        wdetail.n_text123      =  substr(brstat.tlt.rider,1,5)         
        wdetail.n_text124      =  substr(brstat.tlt.safe1,1,20)        
        wdetail.n_text125      =  substr(brstat.tlt.safe2,1,10)        
        wdetail.n_text126      =  substr(brstat.tlt.safe3,1,150)       
        wdetail.n_text127      =  substr(brstat.tlt.sex,1,15)        
        wdetail.n_text128      =  substr(brstat.tlt.stat,1,250)       
        wdetail.n_text129      =  substr(brstat.tlt.subins,1,13)        
        wdetail.n_text130      =  substr(brstat.tlt.tel,1,10)        
        wdetail.n_text131      =  substr(brstat.tlt.tel2,1,150)      
        wdetail.n_text132      =  substr(brstat.tlt.tel3,1,15)       
        wdetail.n_text133      =  substr(brstat.tlt.usrid,1,250)       
        wdetail.n_text134      =  substr(brstat.tlt.usrsent,1,13)       
        wdetail.n_text135      =  substr(brstat.tlt.ln_product,1,10)     
        wdetail.n_text136      =  substr(brstat.tlt.ln_pronme,1,150)    
        wdetail.n_text137      =  substr(brstat.tlt.ln_rate,1,15)     
        wdetail.n_text138      =  substr(brstat.tlt.ln_st,1,250)    
        wdetail.n_text139      =  substr(brstat.tlt.lotno,1,13)    
        wdetail.n_text140      =  substr(brstat.tlt.maritalsts,1,10)    
        wdetail.n_text141      =  substr(brstat.tlt.campaign,1,12)    
        wdetail.n_text142      =  substr(brstat.tlt.mobile,1,10)   
        wdetail.n_text143      =  brstat.tlt.acno1   
        wdetail.n_text144      =  brstat.tlt.agent  .
        /* ADD BY : A68-0061 */
    ASSIGN 
    wdetail.typepol    =   brstat.tlt.poltyp
    wdetail.typecar    =   brstat.tlt.car_type
    wdetail.maksi      =   STRING(brstat.tlt.maksi)
    wdetail.drivexp1   =   brstat.tlt.dri_licenexp1
    wdetail.drivcon1   =   string(brstat.tlt.dri_consen1)
    wdetail.dlevel1    =   string(brstat.tlt.dri_level1)
    wdetail.dgender1   =   brstat.tlt.dri_gender1
    wdetail.drivexp2   =   brstat.tlt.dri_licenexp2
    wdetail.drivcon2   =   string(brstat.tlt.dri_consen2)
    wdetail.dlevel2    =   string(brstat.tlt.dri_level2)
    wdetail.dgender2   =   brstat.tlt.dri_gender2
    wdetail.ntitle3    =   brstat.tlt.dri_title3
    wdetail.dname3     =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,1,INDEX(brstat.tlt.dri_fname3," ") - 1) ELSE TRIM(brstat.tlt.dri_fname3)
    wdetail.dcname3    =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,R-INDEX(brstat.tlt.dri_fname3," ")) ELSE "" 
    wdetail.dlname3    =   brstat.tlt.dri_lname3
    wdetail.doccup3    =   brstat.tlt.dir_occ3
    wdetail.dbirth3    =   brstat.tlt.dri_birth3
    wdetail.dicno3     =   brstat.tlt.dri_ic3
    wdetail.ddriveno3  =   brstat.tlt.dri_lic3
    wdetail.drivexp3   =   brstat.tlt.dri_licenexp3
    wdetail.drivcon3   =   string(brstat.tlt.dri_consen3)
    wdetail.dlevel3    =   string(brstat.tlt.dri_level3)
    wdetail.dgender3   =   brstat.tlt.dri_gender3
    wdetail.ntitle4    =   brstat.tlt.dri_title4
    wdetail.dname4     =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,1,INDEX(brstat.tlt.dri_fname4," ") - 1) ELSE TRIM(brstat.tlt.dri_fname4)
    wdetail.dcname4    =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,R-INDEX(brstat.tlt.dri_fname4," ")) ELSE ""
    wdetail.dlname4    =   brstat.tlt.dri_lname4
    wdetail.doccup4    =   brstat.tlt.dri_occ4
    wdetail.dbirth4    =   brstat.tlt.dri_birth4
    wdetail.dicno4     =   brstat.tlt.dri_ic4
    wdetail.ddriveno4  =   brstat.tlt.dri_lic4
    wdetail.drivexp4   =   brstat.tlt.dri_licenexp4
    wdetail.drivcon4   =   string(brstat.tlt.dri_consen4)
    wdetail.dlevel4    =   string(brstat.tlt.dri_level4)
    wdetail.dgender4   =   brstat.tlt.dri_gender4
    wdetail.ntitle5    =   brstat.tlt.dri_title5
    wdetail.dname5     =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,1,INDEX(brstat.tlt.dri_fname5," ") - 1) ELSE TRIM(brstat.tlt.dri_fname5)
    wdetail.dcname5    =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,R-INDEX(brstat.tlt.dri_fname5," ")) ELSE "" 
    wdetail.dlname5    =   brstat.tlt.dri_lname5
    wdetail.doccup5    =   brstat.tlt.dri_occ5
    wdetail.dbirth5    =   brstat.tlt.dri_birth5
    wdetail.dicno5     =   brstat.tlt.dri_ic5
    wdetail.ddriveno5  =   brstat.tlt.dri_lic5
    wdetail.drivexp5   =   brstat.tlt.dri_licenexp5
    wdetail.drivcon5   =   string(brstat.tlt.dri_consen5)
    wdetail.dlevel5    =   string(brstat.tlt.dri_level5)
    wdetail.dgender5   =   brstat.tlt.dri_gender5  
    wdetail.chargflg    =  STRING(brstat.tlt.chargflg)
    wdetail.chargprice  =  STRING(brstat.tlt.chargsi)
    wdetail.chargno     =  brstat.tlt.chargno
    wdetail.chargprm    =  string(brstat.tlt.chargprem)
    wdetail.battflg     =  string(brstat.tlt.battflg  )
    wdetail.battprice   =  string(brstat.tlt.battprice)
    wdetail.battno      =  brstat.tlt.battno
    wdetail.battprm     =  string(brstat.tlt.battprem)
    wdetail.battdate    =  string(brstat.tlt.ndate1,"99/99/9999")
    wdetail.net_re1     =  string(brstat.tlt.dg_prem)
    wdetail.stam_re1    =  string(brstat.tlt.dg_rstp_t)
    wdetail.vat_re1     =  string(brstat.tlt.dg_rtax_t)
    wdetail.inscode_re2 =  brstat.tlt.ins_code
    wdetail.net_re2     =  string(brstat.tlt.dg_si  )
    wdetail.stam_re2    =  string(brstat.tlt.dg_rate)
    wdetail.vat_re2     =  string(brstat.tlt.dg_feet)
    wdetail.inscode_re3 =  brstat.tlt.Paycode
    wdetail.net_re3     =  string(brstat.tlt.dg_ncb  )
    wdetail.stam_re3    =  string(brstat.tlt.dg_disc )
    wdetail.vat_re3     =  string(brstat.tlt.dg_wdisc) .
 /* END : A68-0061 */
    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_reportfielBRALLM1 c-wins 
PROCEDURE pd_reportfielBRALLM1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

FOR EACH wproducer NO-LOCK.
    For each tlt Use-index  tlt06 Where
        tlt.trndat    >=  fi_trndatfr       And
        tlt.trndat    <=  fi_trndatto       AND 
        /*tlt.acno1    =  trim(fi_producer) AND*/
        tlt.acno1      =  wproducer.producer  AND 
        tlt.genusr     =  "HCT"              NO-LOCK
        BREAK BY brstat.tlt.comp_noti_ins :
        IF      nv_typre = "V70" AND brstat.tlt.nor_usr_ins  = "0" THEN NEXT.
        ELSE IF nv_typre = "V72" AND brstat.tlt.nor_usr_ins <> "0" THEN NEXT.
        IF brstat.tlt.releas <> cb_reportstatus  THEN NEXT.
        CREATE  wdetail.
        ASSIGN 
        wdetail.n_text001      =  brstat.tlt.comp_noti_ins  
        wdetail.n_text002      =  brstat.tlt.comp_noti_tlt  
        wdetail.n_text003      =  brstat.tlt.comp_pol       
        wdetail.n_text004      =  string(brstat.tlt.nor_effdat,"99/99/9999")     
        wdetail.n_text005      =  string(brstat.tlt.comp_effdat,"99/99/9999")    
        wdetail.n_text006      =  brstat.tlt.comp_sub       
        wdetail.n_text007      =  brstat.tlt.cifno          
        wdetail.n_text008      =  brstat.tlt.nationality    
        wdetail.n_text009      =  brstat.tlt.nor_noti_ins   
        wdetail.n_text010      =  brstat.tlt.nor_noti_tlt   
        wdetail.n_text011      =  brstat.tlt.nor_usr_ins    
        wdetail.n_text012      =  brstat.tlt.covcod         
        wdetail.n_text013      =  brstat.tlt.nor_usr_tlt    
        wdetail.n_text014      =  brstat.tlt.comp_usr_ins   
        wdetail.n_text015      =  brstat.tlt.ins_title      
        wdetail.n_text016      =  brstat.tlt.ins_name       
        wdetail.n_text017      =  brstat.tlt.ins_firstname  
        wdetail.n_text018      =  brstat.tlt.ins_lastname   
        wdetail.n_text019      =  brstat.tlt.ins_addr       
        wdetail.n_text020      =  brstat.tlt.ins_addr1      
        wdetail.n_text021      =  brstat.tlt.ins_addr2      
        wdetail.n_text022      =  brstat.tlt.ins_addr3      
        wdetail.n_text023      =  brstat.tlt.lince2         
        wdetail.n_text024      =  brstat.tlt.ins_addr5      
        wdetail.n_text025      =  brstat.tlt.dir_occ1       
        wdetail.n_text026      =  brstat.tlt.note28         
        wdetail.n_text027      =  brstat.tlt.dri_ic1        
        wdetail.n_text028      =  brstat.tlt.dri_lic1       
        wdetail.n_text029      =  brstat.tlt.brand          
        wdetail.n_text030      =  substr(brstat.tlt.note10,1,1)         
        wdetail.n_text031      =  substr(brstat.tlt.cha_no,1,25)      
        wdetail.n_text032      =  substr(brstat.tlt.eng_no,1,20)                   
        wdetail.n_text033      =  substr(brstat.tlt.model,1,40)                 
        wdetail.n_text034      =  substr(brstat.tlt.note11,1,4)                  
        wdetail.n_text035      =  substr(brstat.tlt.note12,1,20)                  
        wdetail.n_text036      =  substr(brstat.tlt.note13,1,40)                  
        wdetail.n_text037      =  substr(brstat.tlt.note14,1,1)                   
        /*wdetail.n_text038      =  substr(brstat.tlt.vehuse,1,2) */ /* A68-0061*/
        wdetail.n_text038      =  IF rs_typre = 1 THEN substr(brstat.tlt.vehuse,1,2) ELSE TRIM(brstat.tlt.vehuse)  /* A68-0061*/                  
        wdetail.n_text039      =  string(brstat.tlt.seqno,"99")                        
        wdetail.n_text040      =  string(brstat.tlt.cc_weight,"9999")                  
        wdetail.n_text041      =  substr(brstat.tlt.colorcod,1,40)        
        wdetail.n_text042      =  substr(brstat.tlt.lince1,1,10)        
        wdetail.n_text043      =  substr(brstat.tlt.ins_addr4,1,30)        
        wdetail.n_text044      =  substr(brstat.tlt.note15,1,4)         
        wdetail.n_text045      =  substr(brstat.tlt.note16,1,512)              
        wdetail.n_text046      =  substr(brstat.tlt.note17,1,14)        
        wdetail.n_text047      =  substr(brstat.tlt.note18,1,14)       
        wdetail.n_text048      =  substr(brstat.tlt.note19,1,14)          
        wdetail.n_text049      =  substr(brstat.tlt.note2,1,14)          
        wdetail.n_text050      =  substr(brstat.tlt.note20,1,14)       
        wdetail.n_text051      =  substr(brstat.tlt.note21,1,14)          
        wdetail.n_text052      =  substr(brstat.tlt.note22,1,14)        
        wdetail.n_text053      =  substr(brstat.tlt.note23,1,14)        
        wdetail.n_text054      =  substr(brstat.tlt.comp_sck,1,20)        
        wdetail.n_text055      =  substr(brstat.tlt.note24,1,32)        
        wdetail.n_text056      =  substr(brstat.tlt.dri_no1,1,1)        
        wdetail.n_text057      =  substr(brstat.tlt.dri_no2,1,1)         
        wdetail.n_text058      =  substr(brstat.tlt.note25,1,20)      
        wdetail.n_text059      =  substr(brstat.tlt.dri_name1,1,80)      
        wdetail.n_text060      =  substr(brstat.tlt.note26,1,20)      
        wdetail.n_text061      =  substr(brstat.tlt.note27,1,60)      
        wdetail.n_text062      =  substr(brstat.tlt.dri_occ2,1,50)   
        wdetail.n_text063      =  substr(brstat.tlt.note4,1,10)         
        wdetail.n_text064      =  substr(brstat.tlt.dri_ic2,1,15)         
        wdetail.n_text065      =  substr(brstat.tlt.dri_lic2,1,15)         
        wdetail.n_text066      =  substr(brstat.tlt.note29,1,20)         
        wdetail.n_text067      =  substr(brstat.tlt.dri_name2,1,80)         
        wdetail.n_text068      =  substr(brstat.tlt.note3,1,20)         
        wdetail.n_text069      =  substr(brstat.tlt.note30,1,60)         
        wdetail.n_text070      =  substr(brstat.tlt.ins_occ,1,50)         
        wdetail.n_text071      =  IF brstat.tlt.birthdate = ? THEN "" ELSE string(brstat.tlt.birthdate,"99/99/9999")              
        wdetail.n_text072      =  substr(brstat.tlt.ins_icno,1,15)           
        wdetail.n_text073      =  substr(brstat.tlt.note1,1,15)                   
        wdetail.n_text074      =  substr(brstat.tlt.ben83,1,80)                   
        wdetail.n_text075      =  string(brstat.tlt.comp_coamt,"99999999999.99")      
        wdetail.n_text076      =  string(brstat.tlt.comp_grprm,"99999999999.99")      
        wdetail.n_text077      =  string(brstat.tlt.mileage,"99999999999.99")         
        wdetail.n_text078      =  string(brstat.tlt.ndeci1,"99999999999.99")          
        wdetail.n_text079      =  string(brstat.tlt.ndeci2,"99999999999.99")          
        wdetail.n_text080      =  string(brstat.tlt.ndeci3,"99999999999.99")          
        wdetail.n_text081      =  string(brstat.tlt.ndeci4,"99999999999.99")          
        wdetail.n_text082      =  string(brstat.tlt.ndeci5,"99999999999.99")          
        wdetail.n_text083      =  string(brstat.tlt.nor_coamt,"99")                    
        wdetail.n_text084      =  string(brstat.tlt.nor_grprm,"99999999999.99")       
        wdetail.n_text085      =  string(brstat.tlt.prem_amt,"99999999999.99")        
        wdetail.n_text086      =  string(brstat.tlt.prem_amttcop,"99")                 
        wdetail.n_text087      =  string(brstat.tlt.rstp,"99999999999.99")            
        wdetail.n_text088      =  string(brstat.tlt.rtax,"99999999999.99")            
        wdetail.n_text089      =  string(brstat.tlt.tax_coporate,"99999999999.99")    
        wdetail.n_text090      =  substr(brstat.tlt.note5,1,6)            
        wdetail.n_text091      =  substr(brstat.tlt.note6,1,10)        
        wdetail.n_text092      =  substr(brstat.tlt.note7,1,10)        
        wdetail.n_text093      =  substr(brstat.tlt.note8,1,30)        
        wdetail.n_text094      =  substr(brstat.tlt.note9,1,80)        
        wdetail.n_text095      =  substr(brstat.tlt.noteveh1,1,10)        
        wdetail.n_text096      =  substr(brstat.tlt.noteveh2,1,30)        
        wdetail.n_text097      =  substr(brstat.tlt.old_cha,1,12)        
        wdetail.n_text098      =  substr(brstat.tlt.old_eng,1,3)             
        wdetail.n_text099      =  substr(brstat.tlt.pack,1,10)      
        wdetail.n_text100      =  substr(brstat.tlt.packnme,1,14)      
        wdetail.n_text101      =  substr(brstat.tlt.period,1,10)      
        wdetail.n_text102      =  substr(brstat.tlt.ln_note1,1,14) 
        wdetail.n_text103      =  substr(brstat.tlt.product,1,10)   
        wdetail.n_text104      =  substr(brstat.tlt.projnme,1,14)   
        wdetail.n_text105      =  substr(brstat.tlt.proveh,1,10)   
        wdetail.n_text106      =  substr(brstat.tlt.race,1,14)   
        wdetail.n_text107      =  substr(brstat.tlt.recac,1,10)   
        wdetail.n_text108      =  substr(brstat.tlt.rec_addr,1,14)   
        wdetail.n_text109      =  substr(brstat.tlt.rec_addr1,1,15)   
        wdetail.n_text110      =  substr(brstat.tlt.rec_addr2,1,10)   
        wdetail.n_text111      =  substr(brstat.tlt.rec_addr3,1,14)   
        wdetail.n_text112      =  substr(brstat.tlt.rec_addr4,1,10)   
        wdetail.n_text113      =  substr(brstat.tlt.rec_addr5,1,20)   
        wdetail.n_text114      =  substr(brstat.tlt.rec_brins,1,1)         
        wdetail.n_text115      =  substr(brstat.tlt.rec_cou,1,120)      
        wdetail.n_text116      =  substr(brstat.tlt.rec_icno,1,100)      
        wdetail.n_text117      =  substr(brstat.tlt.rec_name,1,2)         
        wdetail.n_text118      =  substr(brstat.tlt.rec_name2,1,2)         
        wdetail.n_text119      =  substr(brstat.tlt.rec_note1,1,10)        
        wdetail.n_text120      =  substr(brstat.tlt.rec_note2,1,1)        
        wdetail.n_text121      =  substr(brstat.tlt.rec_title,1,10)        
        wdetail.n_text122      =  substr(brstat.tlt.rec_typ,1,255)       
        wdetail.n_text123      =  substr(brstat.tlt.rider,1,5)         
        wdetail.n_text124      =  substr(brstat.tlt.safe1,1,20)        
        wdetail.n_text125      =  substr(brstat.tlt.safe2,1,10)        
        wdetail.n_text126      =  substr(brstat.tlt.safe3,1,150)       
        wdetail.n_text127      =  substr(brstat.tlt.sex,1,15)        
        wdetail.n_text128      =  substr(brstat.tlt.stat,1,250)       
        wdetail.n_text129      =  substr(brstat.tlt.subins,1,13)        
        wdetail.n_text130      =  substr(brstat.tlt.tel,1,10)        
        wdetail.n_text131      =  substr(brstat.tlt.tel2,1,150)      
        wdetail.n_text132      =  substr(brstat.tlt.tel3,1,15)       
        wdetail.n_text133      =  substr(brstat.tlt.usrid,1,250)       
        wdetail.n_text134      =  substr(brstat.tlt.usrsent,1,13)       
        wdetail.n_text135      =  substr(brstat.tlt.ln_product,1,10)     
        wdetail.n_text136      =  substr(brstat.tlt.ln_pronme,1,150)    
        wdetail.n_text137      =  substr(brstat.tlt.ln_rate,1,15)     
        wdetail.n_text138      =  substr(brstat.tlt.ln_st,1,250)    
        wdetail.n_text139      =  substr(brstat.tlt.lotno,1,13)    
        wdetail.n_text140      =  substr(brstat.tlt.maritalsts,1,10)    
        wdetail.n_text141      =  substr(brstat.tlt.campaign,1,12)    
        wdetail.n_text142      =  substr(brstat.tlt.mobile,1,10)
        wdetail.n_text143      =  brstat.tlt.acno1   
        wdetail.n_text144      =  brstat.tlt.agent  .
        /* ADD BY : A68-0061 */
    ASSIGN 
    wdetail.typepol    =   brstat.tlt.poltyp
    wdetail.typecar    =   brstat.tlt.car_type
    wdetail.maksi      =   STRING(brstat.tlt.maksi)
    wdetail.drivexp1   =   brstat.tlt.dri_licenexp1
    wdetail.drivcon1   =   string(brstat.tlt.dri_consen1)
    wdetail.dlevel1    =   string(brstat.tlt.dri_level1)
    wdetail.dgender1   =   brstat.tlt.dri_gender1
    wdetail.drivexp2   =   brstat.tlt.dri_licenexp2
    wdetail.drivcon2   =   string(brstat.tlt.dri_consen2)
    wdetail.dlevel2    =   string(brstat.tlt.dri_level2)
    wdetail.dgender2   =   brstat.tlt.dri_gender2
    wdetail.ntitle3    =   brstat.tlt.dri_title3
    wdetail.dname3     =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,1,INDEX(brstat.tlt.dri_fname3," ") - 1) ELSE TRIM(brstat.tlt.dri_fname3)
    wdetail.dcname3    =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,R-INDEX(brstat.tlt.dri_fname3," ")) ELSE "" 
    wdetail.dlname3    =   brstat.tlt.dri_lname3
    wdetail.doccup3    =   brstat.tlt.dir_occ3
    wdetail.dbirth3    =   brstat.tlt.dri_birth3
    wdetail.dicno3     =   brstat.tlt.dri_ic3
    wdetail.ddriveno3  =   brstat.tlt.dri_lic3
    wdetail.drivexp3   =   brstat.tlt.dri_licenexp3
    wdetail.drivcon3   =   string(brstat.tlt.dri_consen3)
    wdetail.dlevel3    =   string(brstat.tlt.dri_level3)
    wdetail.dgender3   =   brstat.tlt.dri_gender3
    wdetail.ntitle4    =   brstat.tlt.dri_title4
    wdetail.dname4     =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,1,INDEX(brstat.tlt.dri_fname4," ") - 1) ELSE TRIM(brstat.tlt.dri_fname4)
    wdetail.dcname4    =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,R-INDEX(brstat.tlt.dri_fname4," ")) ELSE ""
    wdetail.dlname4    =   brstat.tlt.dri_lname4
    wdetail.doccup4    =   brstat.tlt.dri_occ4
    wdetail.dbirth4    =   brstat.tlt.dri_birth4
    wdetail.dicno4     =   brstat.tlt.dri_ic4
    wdetail.ddriveno4  =   brstat.tlt.dri_lic4
    wdetail.drivexp4   =   brstat.tlt.dri_licenexp4
    wdetail.drivcon4   =   string(brstat.tlt.dri_consen4)
    wdetail.dlevel4    =   string(brstat.tlt.dri_level4)
    wdetail.dgender4   =   brstat.tlt.dri_gender4
    wdetail.ntitle5    =   brstat.tlt.dri_title5
    wdetail.dname5     =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,1,INDEX(brstat.tlt.dri_fname5," ") - 1) ELSE TRIM(brstat.tlt.dri_fname5)
    wdetail.dcname5    =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,R-INDEX(brstat.tlt.dri_fname5," ")) ELSE "" 
    wdetail.dlname5    =   brstat.tlt.dri_lname5
    wdetail.doccup5    =   brstat.tlt.dri_occ5
    wdetail.dbirth5    =   brstat.tlt.dri_birth5
    wdetail.dicno5     =   brstat.tlt.dri_ic5
    wdetail.ddriveno5  =   brstat.tlt.dri_lic5
    wdetail.drivexp5   =   brstat.tlt.dri_licenexp5
    wdetail.drivcon5   =   string(brstat.tlt.dri_consen5)
    wdetail.dlevel5    =   string(brstat.tlt.dri_level5)
    wdetail.dgender5   =   brstat.tlt.dri_gender5  
    wdetail.chargflg    =  STRING(brstat.tlt.chargflg)
    wdetail.chargprice  =  STRING(brstat.tlt.chargsi)
    wdetail.chargno     =  brstat.tlt.chargno
    wdetail.chargprm    =  string(brstat.tlt.chargprem)
    wdetail.battflg     =  string(brstat.tlt.battflg  )
    wdetail.battprice   =  string(brstat.tlt.battprice)
    wdetail.battno      =  brstat.tlt.battno
    wdetail.battprm     =  string(brstat.tlt.battprem)
    wdetail.battdate    =  string(brstat.tlt.ndate1,"99/99/9999")
    wdetail.net_re1     =  string(brstat.tlt.dg_prem)
    wdetail.stam_re1    =  string(brstat.tlt.dg_rstp_t)
    wdetail.vat_re1     =  string(brstat.tlt.dg_rtax_t)
    wdetail.inscode_re2 =  brstat.tlt.ins_code
    wdetail.net_re2     =  string(brstat.tlt.dg_si  )
    wdetail.stam_re2    =  string(brstat.tlt.dg_rate)
    wdetail.vat_re2     =  string(brstat.tlt.dg_feet)
    wdetail.inscode_re3 =  brstat.tlt.Paycode
    wdetail.net_re3     =  string(brstat.tlt.dg_ncb  )
    wdetail.stam_re3    =  string(brstat.tlt.dg_disc )
    wdetail.vat_re3     =  string(brstat.tlt.dg_wdisc) .
 /* END : A68-0061 */
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_reportfielBrM c-wins 
PROCEDURE pd_reportfielBrM :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 
    For each tlt Use-index  tlt06 Where
        tlt.trndat   >=  fi_trndatfr And
        tlt.trndat   <=  fi_trndatto AND 
        tlt.genusr    =  "HCT"       And
        tlt.ins_brins =  "M"          NO-LOCK
        BREAK BY brstat.tlt.comp_noti_ins :
        IF      nv_typre = "V70" AND brstat.tlt.nor_usr_ins  = "0" THEN NEXT.
        ELSE IF nv_typre = "V72" AND brstat.tlt.nor_usr_ins <> "0" THEN NEXT.
        IF brstat.tlt.releas <> cb_reportstatus  THEN NEXT.
        CREATE  wdetail.
        ASSIGN 
        wdetail.n_text001      =  brstat.tlt.comp_noti_ins  
        wdetail.n_text002      =  brstat.tlt.comp_noti_tlt  
        wdetail.n_text003      =  brstat.tlt.comp_pol       
        wdetail.n_text004      =  string(brstat.tlt.nor_effdat,"99/99/9999")     
        wdetail.n_text005      =  string(brstat.tlt.comp_effdat,"99/99/9999")    
        wdetail.n_text006      =  brstat.tlt.comp_sub       
        wdetail.n_text007      =  brstat.tlt.cifno          
        wdetail.n_text008      =  brstat.tlt.nationality    
        wdetail.n_text009      =  brstat.tlt.nor_noti_ins   
        wdetail.n_text010      =  brstat.tlt.nor_noti_tlt   
        wdetail.n_text011      =  brstat.tlt.nor_usr_ins    
        wdetail.n_text012      =  brstat.tlt.covcod         
        wdetail.n_text013      =  brstat.tlt.nor_usr_tlt    
        wdetail.n_text014      =  brstat.tlt.comp_usr_ins   
        wdetail.n_text015      =  brstat.tlt.ins_title      
        wdetail.n_text016      =  brstat.tlt.ins_name       
        wdetail.n_text017      =  brstat.tlt.ins_firstname  
        wdetail.n_text018      =  brstat.tlt.ins_lastname   
        wdetail.n_text019      =  brstat.tlt.ins_addr       
        wdetail.n_text020      =  brstat.tlt.ins_addr1      
        wdetail.n_text021      =  brstat.tlt.ins_addr2      
        wdetail.n_text022      =  brstat.tlt.ins_addr3      
        wdetail.n_text023      =  brstat.tlt.lince2         
        wdetail.n_text024      =  brstat.tlt.ins_addr5      
        wdetail.n_text025      =  brstat.tlt.dir_occ1       
        wdetail.n_text026      =  brstat.tlt.note28         
        wdetail.n_text027      =  brstat.tlt.dri_ic1        
        wdetail.n_text028      =  brstat.tlt.dri_lic1       
        wdetail.n_text029      =  brstat.tlt.brand          
        wdetail.n_text030      =  substr(brstat.tlt.note10,1,1)         
        wdetail.n_text031      =  substr(brstat.tlt.cha_no,1,25)      
        wdetail.n_text032      =  substr(brstat.tlt.eng_no,1,20)                   
        wdetail.n_text033      =  substr(brstat.tlt.model,1,40)                 
        wdetail.n_text034      =  substr(brstat.tlt.note11,1,4)                  
        wdetail.n_text035      =  substr(brstat.tlt.note12,1,20)                  
        wdetail.n_text036      =  substr(brstat.tlt.note13,1,40)                  
        wdetail.n_text037      =  substr(brstat.tlt.note14,1,1)                   
        /*wdetail.n_text038      =  substr(brstat.tlt.vehuse,1,2) */ /* A68-0061*/
        wdetail.n_text038      =  IF rs_typre = 1 THEN substr(brstat.tlt.vehuse,1,2) ELSE TRIM(brstat.tlt.vehuse)  /* A68-0061*/                   
        wdetail.n_text039      =  string(brstat.tlt.seqno,"99")                        
        wdetail.n_text040      =  string(brstat.tlt.cc_weight,"9999")                  
        wdetail.n_text041      =  substr(brstat.tlt.colorcod,1,40)        
        wdetail.n_text042      =  substr(brstat.tlt.lince1,1,10)        
        wdetail.n_text043      =  substr(brstat.tlt.ins_addr4,1,30)        
        wdetail.n_text044      =  substr(brstat.tlt.note15,1,4)         
        wdetail.n_text045      =  substr(brstat.tlt.note16,1,512)              
        wdetail.n_text046      =  substr(brstat.tlt.note17,1,14)        
        wdetail.n_text047      =  substr(brstat.tlt.note18,1,14)       
        wdetail.n_text048      =  substr(brstat.tlt.note19,1,14)          
        wdetail.n_text049      =  substr(brstat.tlt.note2,1,14)          
        wdetail.n_text050      =  substr(brstat.tlt.note20,1,14)       
        wdetail.n_text051      =  substr(brstat.tlt.note21,1,14)          
        wdetail.n_text052      =  substr(brstat.tlt.note22,1,14)        
        wdetail.n_text053      =  substr(brstat.tlt.note23,1,14)        
        wdetail.n_text054      =  substr(brstat.tlt.comp_sck,1,20)        
        wdetail.n_text055      =  substr(brstat.tlt.note24,1,32)        
        wdetail.n_text056      =  substr(brstat.tlt.dri_no1,1,1)        
        wdetail.n_text057      =  substr(brstat.tlt.dri_no2,1,1)         
        wdetail.n_text058      =  substr(brstat.tlt.note25,1,20)      
        wdetail.n_text059      =  substr(brstat.tlt.dri_name1,1,80)      
        wdetail.n_text060      =  substr(brstat.tlt.note26,1,20)      
        wdetail.n_text061      =  substr(brstat.tlt.note27,1,60)      
        wdetail.n_text062      =  substr(brstat.tlt.dri_occ2,1,50)   
        wdetail.n_text063      =  substr(brstat.tlt.note4,1,10)         
        wdetail.n_text064      =  substr(brstat.tlt.dri_ic2,1,15)         
        wdetail.n_text065      =  substr(brstat.tlt.dri_lic2,1,15)         
        wdetail.n_text066      =  substr(brstat.tlt.note29,1,20)         
        wdetail.n_text067      =  substr(brstat.tlt.dri_name2,1,80)         
        wdetail.n_text068      =  substr(brstat.tlt.note3,1,20)         
        wdetail.n_text069      =  substr(brstat.tlt.note30,1,60)         
        wdetail.n_text070      =  substr(brstat.tlt.ins_occ,1,50)         
        wdetail.n_text071      =  IF brstat.tlt.birthdate = ? THEN "" ELSE string(brstat.tlt.birthdate,"99/99/9999")              
        wdetail.n_text072      =  substr(brstat.tlt.ins_icno,1,15)           
        wdetail.n_text073      =  substr(brstat.tlt.note1,1,15)                   
        wdetail.n_text074      =  substr(brstat.tlt.ben83,1,80)                   
        wdetail.n_text075      =  string(brstat.tlt.comp_coamt,"99999999999.99")      
        wdetail.n_text076      =  string(brstat.tlt.comp_grprm,"99999999999.99")      
        wdetail.n_text077      =     string(brstat.tlt.mileage,"99999999999.99")         
        wdetail.n_text078      =      string(brstat.tlt.ndeci1,"99999999999.99")          
        wdetail.n_text079      =      string(brstat.tlt.ndeci2,"99999999999.99")          
        wdetail.n_text080      =      string(brstat.tlt.ndeci3,"99999999999.99")          
        wdetail.n_text081      =      string(brstat.tlt.ndeci4,"99999999999.99")          
        wdetail.n_text082      =      string(brstat.tlt.ndeci5,"99999999999.99")          
        wdetail.n_text083      =   string(brstat.tlt.nor_coamt,"99")                    
        wdetail.n_text084      =   string(brstat.tlt.nor_grprm,"99999999999.99")       
        wdetail.n_text085      =    string(brstat.tlt.prem_amt,"99999999999.99")        
        wdetail.n_text086      = string(brstat.tlt.prem_amttcop,"99")                 
        wdetail.n_text087      =        string(brstat.tlt.rstp,"99999999999.99")            
        wdetail.n_text088      =        string(brstat.tlt.rtax,"99999999999.99")            
        wdetail.n_text089      = string(brstat.tlt.tax_coporate,"99999999999.99")    
        wdetail.n_text090      =  substr(brstat.tlt.note5,1,6)            
        wdetail.n_text091      =  substr(brstat.tlt.note6,1,10)        
        wdetail.n_text092      =  substr(brstat.tlt.note7,1,10)        
        wdetail.n_text093      =  substr(brstat.tlt.note8,1,30)        
        wdetail.n_text094      =  substr(brstat.tlt.note9,1,80)        
        wdetail.n_text095      =  substr(brstat.tlt.noteveh1,1,10)        
        wdetail.n_text096      =  substr(brstat.tlt.noteveh2,1,30)        
        wdetail.n_text097      =  substr(brstat.tlt.old_cha,1,12)        
        wdetail.n_text098      =  substr(brstat.tlt.old_eng,1,3)             
        wdetail.n_text099      =  substr(brstat.tlt.pack,1,10)      
        wdetail.n_text100      =  substr(brstat.tlt.packnme,1,14)      
        wdetail.n_text101      =  substr(brstat.tlt.period,1,10)      
        wdetail.n_text102      =  substr(brstat.tlt.ln_note1,1,14) 
        wdetail.n_text103      =  substr(brstat.tlt.product,1,10)   
        wdetail.n_text104      =  substr(brstat.tlt.projnme,1,14)   
        wdetail.n_text105      =  substr(brstat.tlt.proveh,1,10)   
        wdetail.n_text106      =  substr(brstat.tlt.race,1,14)   
        wdetail.n_text107      =  substr(brstat.tlt.recac,1,10)   
        wdetail.n_text108      =  substr(brstat.tlt.rec_addr,1,14)   
        wdetail.n_text109      =  substr(brstat.tlt.rec_addr1,1,15)   
        wdetail.n_text110      =  substr(brstat.tlt.rec_addr2,1,10)   
        wdetail.n_text111      =  substr(brstat.tlt.rec_addr3,1,14)   
        wdetail.n_text112      =  substr(brstat.tlt.rec_addr4,1,10)   
        wdetail.n_text113      =  substr(brstat.tlt.rec_addr5,1,20)   
        wdetail.n_text114      =  substr(brstat.tlt.rec_brins,1,1)         
        wdetail.n_text115      =  substr(brstat.tlt.rec_cou,1,120)      
        wdetail.n_text116      =  substr(brstat.tlt.rec_icno,1,100)      
        wdetail.n_text117      =  substr(brstat.tlt.rec_name,1,2)         
        wdetail.n_text118      =  substr(brstat.tlt.rec_name2,1,2)         
        wdetail.n_text119      =  substr(brstat.tlt.rec_note1,1,10)        
        wdetail.n_text120      =  substr(brstat.tlt.rec_note2,1,1)        
        wdetail.n_text121      =  substr(brstat.tlt.rec_title,1,10)        
        wdetail.n_text122      =  substr(brstat.tlt.rec_typ,1,255)       
        wdetail.n_text123      =  substr(brstat.tlt.rider,1,5)         
        wdetail.n_text124      =  substr(brstat.tlt.safe1,1,20)        
        wdetail.n_text125      =  substr(brstat.tlt.safe2,1,10)        
        wdetail.n_text126      =  substr(brstat.tlt.safe3,1,150)       
        wdetail.n_text127      =  substr(brstat.tlt.sex,1,15)        
        wdetail.n_text128      =  substr(brstat.tlt.stat,1,250)       
        wdetail.n_text129      =  substr(brstat.tlt.subins,1,13)        
        wdetail.n_text130      =  substr(brstat.tlt.tel,1,10)        
        wdetail.n_text131      =  substr(brstat.tlt.tel2,1,150)      
        wdetail.n_text132      =  substr(brstat.tlt.tel3,1,15)       
        wdetail.n_text133      =  substr(brstat.tlt.usrid,1,250)       
        wdetail.n_text134      =  substr(brstat.tlt.usrsent,1,13)       
        wdetail.n_text135      =  substr(brstat.tlt.ln_product,1,10)     
        wdetail.n_text136      =  substr(brstat.tlt.ln_pronme,1,150)    
        wdetail.n_text137      =  substr(brstat.tlt.ln_rate,1,15)     
        wdetail.n_text138      =  substr(brstat.tlt.ln_st,1,250)    
        wdetail.n_text139      =  substr(brstat.tlt.lotno,1,13)    
        wdetail.n_text140      =  substr(brstat.tlt.maritalsts,1,10)    
        wdetail.n_text141      =  substr(brstat.tlt.campaign,1,12)    
        wdetail.n_text142      =  substr(brstat.tlt.mobile,1,10)   
        wdetail.n_text143      =  brstat.tlt.acno1   
        wdetail.n_text144      =  brstat.tlt.agent  .
        /* ADD BY : A68-0061 */
    ASSIGN 
    wdetail.typepol    =   brstat.tlt.poltyp
    wdetail.typecar    =   brstat.tlt.car_type
    wdetail.maksi      =   STRING(brstat.tlt.maksi)
    wdetail.drivexp1   =   brstat.tlt.dri_licenexp1
    wdetail.drivcon1   =   string(brstat.tlt.dri_consen1)
    wdetail.dlevel1    =   string(brstat.tlt.dri_level1)
    wdetail.dgender1   =   brstat.tlt.dri_gender1
    wdetail.drivexp2   =   brstat.tlt.dri_licenexp2
    wdetail.drivcon2   =   string(brstat.tlt.dri_consen2)
    wdetail.dlevel2    =   string(brstat.tlt.dri_level2)
    wdetail.dgender2   =   brstat.tlt.dri_gender2
    wdetail.ntitle3    =   brstat.tlt.dri_title3
    wdetail.dname3     =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,1,INDEX(brstat.tlt.dri_fname3," ") - 1) ELSE TRIM(brstat.tlt.dri_fname3)
    wdetail.dcname3    =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,R-INDEX(brstat.tlt.dri_fname3," ")) ELSE "" 
    wdetail.dlname3    =   brstat.tlt.dri_lname3
    wdetail.doccup3    =   brstat.tlt.dir_occ3
    wdetail.dbirth3    =   brstat.tlt.dri_birth3
    wdetail.dicno3     =   brstat.tlt.dri_ic3
    wdetail.ddriveno3  =   brstat.tlt.dri_lic3
    wdetail.drivexp3   =   brstat.tlt.dri_licenexp3
    wdetail.drivcon3   =   string(brstat.tlt.dri_consen3)
    wdetail.dlevel3    =   string(brstat.tlt.dri_level3)
    wdetail.dgender3   =   brstat.tlt.dri_gender3
    wdetail.ntitle4    =   brstat.tlt.dri_title4
    wdetail.dname4     =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,1,INDEX(brstat.tlt.dri_fname4," ") - 1) ELSE TRIM(brstat.tlt.dri_fname4)
    wdetail.dcname4    =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,R-INDEX(brstat.tlt.dri_fname4," ")) ELSE ""
    wdetail.dlname4    =   brstat.tlt.dri_lname4
    wdetail.doccup4    =   brstat.tlt.dri_occ4
    wdetail.dbirth4    =   brstat.tlt.dri_birth4
    wdetail.dicno4     =   brstat.tlt.dri_ic4
    wdetail.ddriveno4  =   brstat.tlt.dri_lic4
    wdetail.drivexp4   =   brstat.tlt.dri_licenexp4
    wdetail.drivcon4   =   string(brstat.tlt.dri_consen4)
    wdetail.dlevel4    =   string(brstat.tlt.dri_level4)
    wdetail.dgender4   =   brstat.tlt.dri_gender4
    wdetail.ntitle5    =   brstat.tlt.dri_title5
    wdetail.dname5     =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,1,INDEX(brstat.tlt.dri_fname5," ") - 1) ELSE TRIM(brstat.tlt.dri_fname5)
    wdetail.dcname5    =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,R-INDEX(brstat.tlt.dri_fname5," ")) ELSE "" 
    wdetail.dlname5    =   brstat.tlt.dri_lname5
    wdetail.doccup5    =   brstat.tlt.dri_occ5
    wdetail.dbirth5    =   brstat.tlt.dri_birth5
    wdetail.dicno5     =   brstat.tlt.dri_ic5
    wdetail.ddriveno5  =   brstat.tlt.dri_lic5
    wdetail.drivexp5   =   brstat.tlt.dri_licenexp5
    wdetail.drivcon5   =   string(brstat.tlt.dri_consen5)
    wdetail.dlevel5    =   string(brstat.tlt.dri_level5)
    wdetail.dgender5   =   brstat.tlt.dri_gender5  
    wdetail.chargflg    =  STRING(brstat.tlt.chargflg)
    wdetail.chargprice  =  STRING(brstat.tlt.chargsi)
    wdetail.chargno     =  brstat.tlt.chargno
    wdetail.chargprm    =  string(brstat.tlt.chargprem)
    wdetail.battflg     =  string(brstat.tlt.battflg  )
    wdetail.battprice   =  string(brstat.tlt.battprice)
    wdetail.battno      =  brstat.tlt.battno
    wdetail.battprm     =  string(brstat.tlt.battprem)
    wdetail.battdate    =  string(brstat.tlt.ndate1,"99/99/9999")
    wdetail.net_re1     =  string(brstat.tlt.dg_prem)
    wdetail.stam_re1    =  string(brstat.tlt.dg_rstp_t)
    wdetail.vat_re1     =  string(brstat.tlt.dg_rtax_t)
    wdetail.inscode_re2 =  brstat.tlt.ins_code
    wdetail.net_re2     =  string(brstat.tlt.dg_si  )
    wdetail.stam_re2    =  string(brstat.tlt.dg_rate)
    wdetail.vat_re2     =  string(brstat.tlt.dg_feet)
    wdetail.inscode_re3 =  brstat.tlt.Paycode
    wdetail.net_re3     =  string(brstat.tlt.dg_ncb  )
    wdetail.stam_re3    =  string(brstat.tlt.dg_disc )
    wdetail.vat_re3     =  string(brstat.tlt.dg_wdisc) .
 /* END : A68-0061 */
    END.
 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_reportfielBrM1 c-wins 
PROCEDURE pd_reportfielBrM1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wproducer NO-LOCK.
    For each tlt Use-index  tlt06 Where
        tlt.trndat    >=  fi_trndatfr       And
        tlt.trndat    <=  fi_trndatto       AND 
        /*tlt.acno1    =  trim(fi_producer) AND*/
        tlt.acno1      =  wproducer.producer  AND 
        tlt.genusr     =  "HCT"             And
        brstat.tlt.ins_brins   = "M"        NO-LOCK
        BREAK BY brstat.tlt.comp_noti_ins :
        IF      nv_typre = "V70" AND brstat.tlt.nor_usr_ins  = "0" THEN NEXT.
        ELSE IF nv_typre = "V72" AND brstat.tlt.nor_usr_ins <> "0" THEN NEXT.
        IF brstat.tlt.releas <> cb_reportstatus  THEN NEXT.
        CREATE  wdetail.
        ASSIGN 
        wdetail.n_text001      =  brstat.tlt.comp_noti_ins  
        wdetail.n_text002      =  brstat.tlt.comp_noti_tlt  
        wdetail.n_text003      =  brstat.tlt.comp_pol       
        wdetail.n_text004      =  string(brstat.tlt.nor_effdat,"99/99/9999")     
        wdetail.n_text005      =  string(brstat.tlt.comp_effdat,"99/99/9999")    
        wdetail.n_text006      =  brstat.tlt.comp_sub       
        wdetail.n_text007      =  brstat.tlt.cifno          
        wdetail.n_text008      =  brstat.tlt.nationality    
        wdetail.n_text009      =  brstat.tlt.nor_noti_ins   
        wdetail.n_text010      =  brstat.tlt.nor_noti_tlt   
        wdetail.n_text011      =  brstat.tlt.nor_usr_ins    
        wdetail.n_text012      =  brstat.tlt.covcod         
        wdetail.n_text013      =  brstat.tlt.nor_usr_tlt    
        wdetail.n_text014      =  brstat.tlt.comp_usr_ins   
        wdetail.n_text015      =  brstat.tlt.ins_title      
        wdetail.n_text016      =  brstat.tlt.ins_name       
        wdetail.n_text017      =  brstat.tlt.ins_firstname  
        wdetail.n_text018      =  brstat.tlt.ins_lastname   
        wdetail.n_text019      =  brstat.tlt.ins_addr       
        wdetail.n_text020      =  brstat.tlt.ins_addr1      
        wdetail.n_text021      =  brstat.tlt.ins_addr2      
        wdetail.n_text022      =  brstat.tlt.ins_addr3      
        wdetail.n_text023      =  brstat.tlt.lince2         
        wdetail.n_text024      =  brstat.tlt.ins_addr5      
        wdetail.n_text025      =  brstat.tlt.dir_occ1       
        wdetail.n_text026      =  brstat.tlt.note28         
        wdetail.n_text027      =  brstat.tlt.dri_ic1        
        wdetail.n_text028      =  brstat.tlt.dri_lic1       
        wdetail.n_text029      =  brstat.tlt.brand          
        wdetail.n_text030      =  substr(brstat.tlt.note10,1,1)         
        wdetail.n_text031      =  substr(brstat.tlt.cha_no,1,25)      
        wdetail.n_text032      =  substr(brstat.tlt.eng_no,1,20)                   
        wdetail.n_text033      =  substr(brstat.tlt.model,1,40)                 
        wdetail.n_text034      =  substr(brstat.tlt.note11,1,4)                  
        wdetail.n_text035      =  substr(brstat.tlt.note12,1,20)                  
        wdetail.n_text036      =  substr(brstat.tlt.note13,1,40)                  
        wdetail.n_text037      =  substr(brstat.tlt.note14,1,1)                   
        /*wdetail.n_text038      =  substr(brstat.tlt.vehuse,1,2) */ /* A68-0061*/
        wdetail.n_text038      =  IF rs_typre = 1 THEN substr(brstat.tlt.vehuse,1,2) ELSE TRIM(brstat.tlt.vehuse)  /* A68-0061*/                   
        wdetail.n_text039      =  string(brstat.tlt.seqno,"99")                        
        wdetail.n_text040      =  string(brstat.tlt.cc_weight,"9999")                  
        wdetail.n_text041      =  substr(brstat.tlt.colorcod,1,40)        
        wdetail.n_text042      =  substr(brstat.tlt.lince1,1,10)        
        wdetail.n_text043      =  substr(brstat.tlt.ins_addr4,1,30)        
        wdetail.n_text044      =  substr(brstat.tlt.note15,1,4)         
        wdetail.n_text045      =  substr(brstat.tlt.note16,1,512)              
        wdetail.n_text046      =  substr(brstat.tlt.note17,1,14)        
        wdetail.n_text047      =  substr(brstat.tlt.note18,1,14)       
        wdetail.n_text048      =  substr(brstat.tlt.note19,1,14)          
        wdetail.n_text049      =  substr(brstat.tlt.note2,1,14)          
        wdetail.n_text050      =  substr(brstat.tlt.note20,1,14)       
        wdetail.n_text051      =  substr(brstat.tlt.note21,1,14)          
        wdetail.n_text052      =  substr(brstat.tlt.note22,1,14)        
        wdetail.n_text053      =  substr(brstat.tlt.note23,1,14)        
        wdetail.n_text054      =  substr(brstat.tlt.comp_sck,1,20)        
        wdetail.n_text055      =  substr(brstat.tlt.note24,1,32)        
        wdetail.n_text056      =  substr(brstat.tlt.dri_no1,1,1)        
        wdetail.n_text057      =  substr(brstat.tlt.dri_no2,1,1)         
        wdetail.n_text058      =  substr(brstat.tlt.note25,1,20)      
        wdetail.n_text059      =  substr(brstat.tlt.dri_name1,1,80)      
        wdetail.n_text060      =  substr(brstat.tlt.note26,1,20)      
        wdetail.n_text061      =  substr(brstat.tlt.note27,1,60)      
        wdetail.n_text062      =  substr(brstat.tlt.dri_occ2,1,50)   
        wdetail.n_text063      =  substr(brstat.tlt.note4,1,10)         
        wdetail.n_text064      =  substr(brstat.tlt.dri_ic2,1,15)         
        wdetail.n_text065      =  substr(brstat.tlt.dri_lic2,1,15)         
        wdetail.n_text066      =  substr(brstat.tlt.note29,1,20)         
        wdetail.n_text067      =  substr(brstat.tlt.dri_name2,1,80)         
        wdetail.n_text068      =  substr(brstat.tlt.note3,1,20)         
        wdetail.n_text069      =  substr(brstat.tlt.note30,1,60)         
        wdetail.n_text070      =  substr(brstat.tlt.ins_occ,1,50)         
        wdetail.n_text071      =  IF brstat.tlt.birthdate = ? THEN "" ELSE string(brstat.tlt.birthdate,"99/99/9999")              
        wdetail.n_text072      =  substr(brstat.tlt.ins_icno,1,15)           
        wdetail.n_text073      =  substr(brstat.tlt.note1,1,15)                   
        wdetail.n_text074      =  substr(brstat.tlt.ben83,1,80)                   
        wdetail.n_text075      =  string(brstat.tlt.comp_coamt,"99999999999.99")      
        wdetail.n_text076      =  string(brstat.tlt.comp_grprm,"99999999999.99")      
        wdetail.n_text077      =  string(brstat.tlt.mileage,"99999999999.99")         
        wdetail.n_text078      =  string(brstat.tlt.ndeci1,"99999999999.99")          
        wdetail.n_text079      =  string(brstat.tlt.ndeci2,"99999999999.99")          
        wdetail.n_text080      =  string(brstat.tlt.ndeci3,"99999999999.99")          
        wdetail.n_text081      =  string(brstat.tlt.ndeci4,"99999999999.99")          
        wdetail.n_text082      =  string(brstat.tlt.ndeci5,"99999999999.99")          
        wdetail.n_text083      =  string(brstat.tlt.nor_coamt,"99")                    
        wdetail.n_text084      =  string(brstat.tlt.nor_grprm,"99999999999.99")       
        wdetail.n_text085      =  string(brstat.tlt.prem_amt,"99999999999.99")        
        wdetail.n_text086      =  string(brstat.tlt.prem_amttcop,"99")                 
        wdetail.n_text087      =  string(brstat.tlt.rstp,"99999999999.99")            
        wdetail.n_text088      =  string(brstat.tlt.rtax,"99999999999.99")            
        wdetail.n_text089      =  string(brstat.tlt.tax_coporate,"99999999999.99")    
        wdetail.n_text090      =  substr(brstat.tlt.note5,1,6)            
        wdetail.n_text091      =  substr(brstat.tlt.note6,1,10)        
        wdetail.n_text092      =  substr(brstat.tlt.note7,1,10)        
        wdetail.n_text093      =  substr(brstat.tlt.note8,1,30)        
        wdetail.n_text094      =  substr(brstat.tlt.note9,1,80)        
        wdetail.n_text095      =  substr(brstat.tlt.noteveh1,1,10)        
        wdetail.n_text096      =  substr(brstat.tlt.noteveh2,1,30)        
        wdetail.n_text097      =  substr(brstat.tlt.old_cha,1,12)        
        wdetail.n_text098      =  substr(brstat.tlt.old_eng,1,3)             
        wdetail.n_text099      =  substr(brstat.tlt.pack,1,10)      
        wdetail.n_text100      =  substr(brstat.tlt.packnme,1,14)      
        wdetail.n_text101      =  substr(brstat.tlt.period,1,10)      
        wdetail.n_text102      =  substr(brstat.tlt.ln_note1,1,14) 
        wdetail.n_text103      =  substr(brstat.tlt.product,1,10)   
        wdetail.n_text104      =  substr(brstat.tlt.projnme,1,14)   
        wdetail.n_text105      =  substr(brstat.tlt.proveh,1,10)   
        wdetail.n_text106      =  substr(brstat.tlt.race,1,14)   
        wdetail.n_text107      =  substr(brstat.tlt.recac,1,10)   
        wdetail.n_text108      =  substr(brstat.tlt.rec_addr,1,14)   
        wdetail.n_text109      =  substr(brstat.tlt.rec_addr1,1,15)   
        wdetail.n_text110      =  substr(brstat.tlt.rec_addr2,1,10)   
        wdetail.n_text111      =  substr(brstat.tlt.rec_addr3,1,14)   
        wdetail.n_text112      =  substr(brstat.tlt.rec_addr4,1,10)   
        wdetail.n_text113      =  substr(brstat.tlt.rec_addr5,1,20)   
        wdetail.n_text114      =  substr(brstat.tlt.rec_brins,1,1)         
        wdetail.n_text115      =  substr(brstat.tlt.rec_cou,1,120)      
        wdetail.n_text116      =  substr(brstat.tlt.rec_icno,1,100)      
        wdetail.n_text117      =  substr(brstat.tlt.rec_name,1,2)         
        wdetail.n_text118      =  substr(brstat.tlt.rec_name2,1,2)         
        wdetail.n_text119      =  substr(brstat.tlt.rec_note1,1,10)        
        wdetail.n_text120      =  substr(brstat.tlt.rec_note2,1,1)        
        wdetail.n_text121      =  substr(brstat.tlt.rec_title,1,10)        
        wdetail.n_text122      =  substr(brstat.tlt.rec_typ,1,255)       
        wdetail.n_text123      =  substr(brstat.tlt.rider,1,5)         
        wdetail.n_text124      =  substr(brstat.tlt.safe1,1,20)        
        wdetail.n_text125      =  substr(brstat.tlt.safe2,1,10)        
        wdetail.n_text126      =  substr(brstat.tlt.safe3,1,150)       
        wdetail.n_text127      =  substr(brstat.tlt.sex,1,15)        
        wdetail.n_text128      =  substr(brstat.tlt.stat,1,250)       
        wdetail.n_text129      =  substr(brstat.tlt.subins,1,13)        
        wdetail.n_text130      =  substr(brstat.tlt.tel,1,10)        
        wdetail.n_text131      =  substr(brstat.tlt.tel2,1,150)      
        wdetail.n_text132      =  substr(brstat.tlt.tel3,1,15)       
        wdetail.n_text133      =  substr(brstat.tlt.usrid,1,250)       
        wdetail.n_text134      =  substr(brstat.tlt.usrsent,1,13)       
        wdetail.n_text135      =  substr(brstat.tlt.ln_product,1,10)     
        wdetail.n_text136      =  substr(brstat.tlt.ln_pronme,1,150)    
        wdetail.n_text137      =  substr(brstat.tlt.ln_rate,1,15)     
        wdetail.n_text138      =  substr(brstat.tlt.ln_st,1,250)    
        wdetail.n_text139      =  substr(brstat.tlt.lotno,1,13)    
        wdetail.n_text140      =  substr(brstat.tlt.maritalsts,1,10)    
        wdetail.n_text141      =  substr(brstat.tlt.campaign,1,12)    
        wdetail.n_text142      =  substr(brstat.tlt.mobile,1,10)
        wdetail.n_text143      =  brstat.tlt.acno1   
        wdetail.n_text144      =  brstat.tlt.agent  .
        /* ADD BY : A68-0061 */
    ASSIGN 
    wdetail.typepol    =   brstat.tlt.poltyp
    wdetail.typecar    =   brstat.tlt.car_type
    wdetail.maksi      =   STRING(brstat.tlt.maksi)
    wdetail.drivexp1   =   brstat.tlt.dri_licenexp1
    wdetail.drivcon1   =   string(brstat.tlt.dri_consen1)
    wdetail.dlevel1    =   string(brstat.tlt.dri_level1)
    wdetail.dgender1   =   brstat.tlt.dri_gender1
    wdetail.drivexp2   =   brstat.tlt.dri_licenexp2
    wdetail.drivcon2   =   string(brstat.tlt.dri_consen2)
    wdetail.dlevel2    =   string(brstat.tlt.dri_level2)
    wdetail.dgender2   =   brstat.tlt.dri_gender2
    wdetail.ntitle3    =   brstat.tlt.dri_title3
    wdetail.dname3     =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,1,INDEX(brstat.tlt.dri_fname3," ") - 1) ELSE TRIM(brstat.tlt.dri_fname3)
    wdetail.dcname3    =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,R-INDEX(brstat.tlt.dri_fname3," ")) ELSE "" 
    wdetail.dlname3    =   brstat.tlt.dri_lname3
    wdetail.doccup3    =   brstat.tlt.dir_occ3
    wdetail.dbirth3    =   brstat.tlt.dri_birth3
    wdetail.dicno3     =   brstat.tlt.dri_ic3
    wdetail.ddriveno3  =   brstat.tlt.dri_lic3
    wdetail.drivexp3   =   brstat.tlt.dri_licenexp3
    wdetail.drivcon3   =   string(brstat.tlt.dri_consen3)
    wdetail.dlevel3    =   string(brstat.tlt.dri_level3)
    wdetail.dgender3   =   brstat.tlt.dri_gender3
    wdetail.ntitle4    =   brstat.tlt.dri_title4
    wdetail.dname4     =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,1,INDEX(brstat.tlt.dri_fname4," ") - 1) ELSE TRIM(brstat.tlt.dri_fname4)
    wdetail.dcname4    =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,R-INDEX(brstat.tlt.dri_fname4," ")) ELSE ""
    wdetail.dlname4    =   brstat.tlt.dri_lname4
    wdetail.doccup4    =   brstat.tlt.dri_occ4
    wdetail.dbirth4    =   brstat.tlt.dri_birth4
    wdetail.dicno4     =   brstat.tlt.dri_ic4
    wdetail.ddriveno4  =   brstat.tlt.dri_lic4
    wdetail.drivexp4   =   brstat.tlt.dri_licenexp4
    wdetail.drivcon4   =   string(brstat.tlt.dri_consen4)
    wdetail.dlevel4    =   string(brstat.tlt.dri_level4)
    wdetail.dgender4   =   brstat.tlt.dri_gender4
    wdetail.ntitle5    =   brstat.tlt.dri_title5
    wdetail.dname5     =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,1,INDEX(brstat.tlt.dri_fname5," ") - 1) ELSE TRIM(brstat.tlt.dri_fname5)
    wdetail.dcname5    =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,R-INDEX(brstat.tlt.dri_fname5," ")) ELSE "" 
    wdetail.dlname5    =   brstat.tlt.dri_lname5
    wdetail.doccup5    =   brstat.tlt.dri_occ5
    wdetail.dbirth5    =   brstat.tlt.dri_birth5
    wdetail.dicno5     =   brstat.tlt.dri_ic5
    wdetail.ddriveno5  =   brstat.tlt.dri_lic5
    wdetail.drivexp5   =   brstat.tlt.dri_licenexp5
    wdetail.drivcon5   =   string(brstat.tlt.dri_consen5)
    wdetail.dlevel5    =   string(brstat.tlt.dri_level5)
    wdetail.dgender5   =   brstat.tlt.dri_gender5  
    wdetail.chargflg    =  STRING(brstat.tlt.chargflg)
    wdetail.chargprice  =  STRING(brstat.tlt.chargsi)
    wdetail.chargno     =  brstat.tlt.chargno
    wdetail.chargprm    =  string(brstat.tlt.chargprem)
    wdetail.battflg     =  string(brstat.tlt.battflg  )
    wdetail.battprice   =  string(brstat.tlt.battprice)
    wdetail.battno      =  brstat.tlt.battno
    wdetail.battprm     =  string(brstat.tlt.battprem)
    wdetail.battdate    =  string(brstat.tlt.ndate1,"99/99/9999")
    wdetail.net_re1     =  string(brstat.tlt.dg_prem)
    wdetail.stam_re1    =  string(brstat.tlt.dg_rstp_t)
    wdetail.vat_re1     =  string(brstat.tlt.dg_rtax_t)
    wdetail.inscode_re2 =  brstat.tlt.ins_code
    wdetail.net_re2     =  string(brstat.tlt.dg_si  )
    wdetail.stam_re2    =  string(brstat.tlt.dg_rate)
    wdetail.vat_re2     =  string(brstat.tlt.dg_feet)
    wdetail.inscode_re3 =  brstat.tlt.Paycode
    wdetail.net_re3     =  string(brstat.tlt.dg_ncb  )
    wdetail.stam_re3    =  string(brstat.tlt.dg_disc )
    wdetail.vat_re3     =  string(brstat.tlt.dg_wdisc) .
 /* END : A68-0061 */
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_reportfielBRnoM c-wins 
PROCEDURE pd_reportfielBRnoM :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 
    For each tlt Use-index  tlt06     Where
        tlt.trndat >=  fi_trndatfr      And
        tlt.trndat <=  fi_trndatto      AND 
        /*tlt.releas  =  trim(fi_report)  AND*/
        tlt.genusr  =  "HCT"            And
        tlt.ins_brins  <> "M"            NO-LOCK 
        BREAK BY brstat.tlt.comp_noti_ins :
        IF      nv_typre = "V70" AND brstat.tlt.nor_usr_ins  = "0" THEN NEXT.
        ELSE IF nv_typre = "V72" AND brstat.tlt.nor_usr_ins <> "0" THEN NEXT.
        IF brstat.tlt.releas <> cb_reportstatus  THEN NEXT.
        CREATE  wdetail.
        ASSIGN 
        wdetail.n_text001      =  brstat.tlt.comp_noti_ins  
        wdetail.n_text002      =  brstat.tlt.comp_noti_tlt  
        wdetail.n_text003      =  brstat.tlt.comp_pol       
        wdetail.n_text004      =  string(brstat.tlt.nor_effdat,"99/99/9999")     
        wdetail.n_text005      =  string(brstat.tlt.comp_effdat,"99/99/9999")    
        wdetail.n_text006      =  brstat.tlt.comp_sub       
        wdetail.n_text007      =  brstat.tlt.cifno          
        wdetail.n_text008      =  brstat.tlt.nationality    
        wdetail.n_text009      =  brstat.tlt.nor_noti_ins   
        wdetail.n_text010      =  brstat.tlt.nor_noti_tlt   
        wdetail.n_text011      =  brstat.tlt.nor_usr_ins    
        wdetail.n_text012      =  brstat.tlt.covcod         
        wdetail.n_text013      =  brstat.tlt.nor_usr_tlt    
        wdetail.n_text014      =  brstat.tlt.comp_usr_ins   
        wdetail.n_text015      =  brstat.tlt.ins_title      
        wdetail.n_text016      =  brstat.tlt.ins_name       
        wdetail.n_text017      =  brstat.tlt.ins_firstname  
        wdetail.n_text018      =  brstat.tlt.ins_lastname   
        wdetail.n_text019      =  brstat.tlt.ins_addr       
        wdetail.n_text020      =  brstat.tlt.ins_addr1      
        wdetail.n_text021      =  brstat.tlt.ins_addr2      
        wdetail.n_text022      =  brstat.tlt.ins_addr3      
        wdetail.n_text023      =  brstat.tlt.lince2         
        wdetail.n_text024      =  brstat.tlt.ins_addr5      
        wdetail.n_text025      =  brstat.tlt.dir_occ1       
        wdetail.n_text026      =  brstat.tlt.note28         
        wdetail.n_text027      =  brstat.tlt.dri_ic1        
        wdetail.n_text028      =  brstat.tlt.dri_lic1       
        wdetail.n_text029      =  brstat.tlt.brand          
        wdetail.n_text030      =  substr(brstat.tlt.note10,1,1)         
        wdetail.n_text031      =  substr(brstat.tlt.cha_no,1,25)      
        wdetail.n_text032      =  substr(brstat.tlt.eng_no,1,20)                   
        wdetail.n_text033      =  substr(brstat.tlt.model,1,40)                 
        wdetail.n_text034      =  substr(brstat.tlt.note11,1,4)                  
        wdetail.n_text035      =  substr(brstat.tlt.note12,1,20)                  
        wdetail.n_text036      =  substr(brstat.tlt.note13,1,40)                  
        wdetail.n_text037      =  substr(brstat.tlt.note14,1,1)                   
        /*wdetail.n_text038      =  substr(brstat.tlt.vehuse,1,2) */ /* A68-0061*/
        wdetail.n_text038      =  IF rs_typre = 1 THEN substr(brstat.tlt.vehuse,1,2) ELSE TRIM(brstat.tlt.vehuse)  /* A68-0061*/                   
        wdetail.n_text039      =  string(brstat.tlt.seqno,"99")                        
        wdetail.n_text040      =  string(brstat.tlt.cc_weight,"9999")                  
        wdetail.n_text041      =  substr(brstat.tlt.colorcod,1,40)        
        wdetail.n_text042      =  substr(brstat.tlt.lince1,1,10)        
        wdetail.n_text043      =  substr(brstat.tlt.ins_addr4,1,30)        
        wdetail.n_text044      =  substr(brstat.tlt.note15,1,4)         
        wdetail.n_text045      =  substr(brstat.tlt.note16,1,512)              
        wdetail.n_text046      =  substr(brstat.tlt.note17,1,14)        
        wdetail.n_text047      =  substr(brstat.tlt.note18,1,14)       
        wdetail.n_text048      =  substr(brstat.tlt.note19,1,14)          
        wdetail.n_text049      =  substr(brstat.tlt.note2,1,14)          
        wdetail.n_text050      =  substr(brstat.tlt.note20,1,14)       
        wdetail.n_text051      =  substr(brstat.tlt.note21,1,14)          
        wdetail.n_text052      =  substr(brstat.tlt.note22,1,14)        
        wdetail.n_text053      =  substr(brstat.tlt.note23,1,14)        
        wdetail.n_text054      =  substr(brstat.tlt.comp_sck,1,20)        
        wdetail.n_text055      =  substr(brstat.tlt.note24,1,32)        
        wdetail.n_text056      =  substr(brstat.tlt.dri_no1,1,1)        
        wdetail.n_text057      =  substr(brstat.tlt.dri_no2,1,1)         
        wdetail.n_text058      =  substr(brstat.tlt.note25,1,20)      
        wdetail.n_text059      =  substr(brstat.tlt.dri_name1,1,80)      
        wdetail.n_text060      =  substr(brstat.tlt.note26,1,20)      
        wdetail.n_text061      =  substr(brstat.tlt.note27,1,60)      
        wdetail.n_text062      =  substr(brstat.tlt.dri_occ2,1,50)   
        wdetail.n_text063      =  substr(brstat.tlt.note4,1,10)         
        wdetail.n_text064      =  substr(brstat.tlt.dri_ic2,1,15)         
        wdetail.n_text065      =  substr(brstat.tlt.dri_lic2,1,15)         
        wdetail.n_text066      =  substr(brstat.tlt.note29,1,20)         
        wdetail.n_text067      =  substr(brstat.tlt.dri_name2,1,80)         
        wdetail.n_text068      =  substr(brstat.tlt.note3,1,20)         
        wdetail.n_text069      =  substr(brstat.tlt.note30,1,60)         
        wdetail.n_text070      =  substr(brstat.tlt.ins_occ,1,50)         
        wdetail.n_text071      =  IF brstat.tlt.birthdate = ? THEN "" ELSE string(brstat.tlt.birthdate,"99/99/9999")              
        wdetail.n_text072      =  substr(brstat.tlt.ins_icno,1,15)           
        wdetail.n_text073      =  substr(brstat.tlt.note1,1,15)                   
        wdetail.n_text074      =  substr(brstat.tlt.ben83,1,80)                   
        wdetail.n_text075      =  string(brstat.tlt.comp_coamt,"99999999999.99")      
        wdetail.n_text076      =  string(brstat.tlt.comp_grprm,"99999999999.99")      
        wdetail.n_text077      =     string(brstat.tlt.mileage,"99999999999.99")         
        wdetail.n_text078      =      string(brstat.tlt.ndeci1,"99999999999.99")          
        wdetail.n_text079      =      string(brstat.tlt.ndeci2,"99999999999.99")          
        wdetail.n_text080      =      string(brstat.tlt.ndeci3,"99999999999.99")          
        wdetail.n_text081      =      string(brstat.tlt.ndeci4,"99999999999.99")          
        wdetail.n_text082      =      string(brstat.tlt.ndeci5,"99999999999.99")          
        wdetail.n_text083      =   string(brstat.tlt.nor_coamt,"99")                    
        wdetail.n_text084      =   string(brstat.tlt.nor_grprm,"99999999999.99")       
        wdetail.n_text085      =    string(brstat.tlt.prem_amt,"99999999999.99")        
        wdetail.n_text086     = string(brstat.tlt.prem_amttcop,"99")                 
        wdetail.n_text087      =        string(brstat.tlt.rstp,"99999999999.99")            
        wdetail.n_text088      =        string(brstat.tlt.rtax,"99999999999.99")            
        wdetail.n_text089     = string(brstat.tlt.tax_coporate,"99999999999.99")    
        wdetail.n_text090      =  substr(brstat.tlt.note5,1,6)            
        wdetail.n_text091      =  substr(brstat.tlt.note6,1,10)        
        wdetail.n_text092      =  substr(brstat.tlt.note7,1,10)        
        wdetail.n_text093      =  substr(brstat.tlt.note8,1,30)        
        wdetail.n_text094      =  substr(brstat.tlt.note9,1,80)        
        wdetail.n_text095      =  substr(brstat.tlt.noteveh1,1,10)        
        wdetail.n_text096      =  substr(brstat.tlt.noteveh2,1,30)        
        wdetail.n_text097      =  substr(brstat.tlt.old_cha,1,12)        
        wdetail.n_text098      =  substr(brstat.tlt.old_eng,1,3)             
        wdetail.n_text099      =  substr(brstat.tlt.pack,1,10)      
        wdetail.n_text100      =  substr(brstat.tlt.packnme,1,14)      
        wdetail.n_text101      =  substr(brstat.tlt.period,1,10)      
        wdetail.n_text102      =  substr(brstat.tlt.ln_note1,1,14) 
        wdetail.n_text103      =  substr(brstat.tlt.product,1,10)   
        wdetail.n_text104      =  substr(brstat.tlt.projnme,1,14)   
        wdetail.n_text105      =  substr(brstat.tlt.proveh,1,10)   
        wdetail.n_text106      =  substr(brstat.tlt.race,1,14)   
        wdetail.n_text107      =  substr(brstat.tlt.recac,1,10)   
        wdetail.n_text108      =  substr(brstat.tlt.rec_addr,1,14)   
        wdetail.n_text109      =  substr(brstat.tlt.rec_addr1,1,15)   
        wdetail.n_text110      =  substr(brstat.tlt.rec_addr2,1,10)   
        wdetail.n_text111      =  substr(brstat.tlt.rec_addr3,1,14)   
        wdetail.n_text112      =  substr(brstat.tlt.rec_addr4,1,10)   
        wdetail.n_text113      =  substr(brstat.tlt.rec_addr5,1,20)   
        wdetail.n_text114      =  substr(brstat.tlt.rec_brins,1,1)         
        wdetail.n_text115      =  substr(brstat.tlt.rec_cou,1,120)      
        wdetail.n_text116      =  substr(brstat.tlt.rec_icno,1,100)      
        wdetail.n_text117      =  substr(brstat.tlt.rec_name,1,2)         
        wdetail.n_text118      =  substr(brstat.tlt.rec_name2,1,2)         
        wdetail.n_text119      =  substr(brstat.tlt.rec_note1,1,10)        
        wdetail.n_text120      =  substr(brstat.tlt.rec_note2,1,1)        
        wdetail.n_text121      =  substr(brstat.tlt.rec_title,1,10)        
        wdetail.n_text122      =  substr(brstat.tlt.rec_typ,1,255)       
        wdetail.n_text123      =  substr(brstat.tlt.rider,1,5)         
        wdetail.n_text124      =  substr(brstat.tlt.safe1,1,20)        
        wdetail.n_text125      =  substr(brstat.tlt.safe2,1,10)        
        wdetail.n_text126      =  substr(brstat.tlt.safe3,1,150)       
        wdetail.n_text127      =  substr(brstat.tlt.sex,1,15)        
        wdetail.n_text128      =  substr(brstat.tlt.stat,1,250)       
        wdetail.n_text129      =  substr(brstat.tlt.subins,1,13)        
        wdetail.n_text130      =  substr(brstat.tlt.tel,1,10)        
        wdetail.n_text131      =  substr(brstat.tlt.tel2,1,150)      
        wdetail.n_text132      =  substr(brstat.tlt.tel3,1,15)       
        wdetail.n_text133      =  substr(brstat.tlt.usrid,1,250)       
        wdetail.n_text134      =  substr(brstat.tlt.usrsent,1,13)       
        wdetail.n_text135      =  substr(brstat.tlt.ln_product,1,10)     
        wdetail.n_text136      =  substr(brstat.tlt.ln_pronme,1,150)    
        wdetail.n_text137      =  substr(brstat.tlt.ln_rate,1,15)     
        wdetail.n_text138      =  substr(brstat.tlt.ln_st,1,250)    
        wdetail.n_text139      =  substr(brstat.tlt.lotno,1,13)    
        wdetail.n_text140      =  substr(brstat.tlt.maritalsts,1,10)    
        wdetail.n_text141      =  substr(brstat.tlt.campaign,1,12)    
        wdetail.n_text142      =  substr(brstat.tlt.mobile,1,10)    
        wdetail.n_text143      =  brstat.tlt.acno1   
        wdetail.n_text144      =  brstat.tlt.agent  .
        /* ADD BY : A68-0061 */
    ASSIGN 
    wdetail.typepol    =   brstat.tlt.poltyp
    wdetail.typecar    =   brstat.tlt.car_type
    wdetail.maksi      =   STRING(brstat.tlt.maksi)
    wdetail.drivexp1   =   brstat.tlt.dri_licenexp1
    wdetail.drivcon1   =   string(brstat.tlt.dri_consen1)
    wdetail.dlevel1    =   string(brstat.tlt.dri_level1)
    wdetail.dgender1   =   brstat.tlt.dri_gender1
    wdetail.drivexp2   =   brstat.tlt.dri_licenexp2
    wdetail.drivcon2   =   string(brstat.tlt.dri_consen2)
    wdetail.dlevel2    =   string(brstat.tlt.dri_level2)
    wdetail.dgender2   =   brstat.tlt.dri_gender2
    wdetail.ntitle3    =   brstat.tlt.dri_title3
    wdetail.dname3     =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,1,INDEX(brstat.tlt.dri_fname3," ") - 1) ELSE TRIM(brstat.tlt.dri_fname3)
    wdetail.dcname3    =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,R-INDEX(brstat.tlt.dri_fname3," ")) ELSE "" 
    wdetail.dlname3    =   brstat.tlt.dri_lname3
    wdetail.doccup3    =   brstat.tlt.dir_occ3
    wdetail.dbirth3    =   brstat.tlt.dri_birth3
    wdetail.dicno3     =   brstat.tlt.dri_ic3
    wdetail.ddriveno3  =   brstat.tlt.dri_lic3
    wdetail.drivexp3   =   brstat.tlt.dri_licenexp3
    wdetail.drivcon3   =   string(brstat.tlt.dri_consen3)
    wdetail.dlevel3    =   string(brstat.tlt.dri_level3)
    wdetail.dgender3   =   brstat.tlt.dri_gender3
    wdetail.ntitle4    =   brstat.tlt.dri_title4
    wdetail.dname4     =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,1,INDEX(brstat.tlt.dri_fname4," ") - 1) ELSE TRIM(brstat.tlt.dri_fname4)
    wdetail.dcname4    =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,R-INDEX(brstat.tlt.dri_fname4," ")) ELSE ""
    wdetail.dlname4    =   brstat.tlt.dri_lname4
    wdetail.doccup4    =   brstat.tlt.dri_occ4
    wdetail.dbirth4    =   brstat.tlt.dri_birth4
    wdetail.dicno4     =   brstat.tlt.dri_ic4
    wdetail.ddriveno4  =   brstat.tlt.dri_lic4
    wdetail.drivexp4   =   brstat.tlt.dri_licenexp4
    wdetail.drivcon4   =   string(brstat.tlt.dri_consen4)
    wdetail.dlevel4    =   string(brstat.tlt.dri_level4)
    wdetail.dgender4   =   brstat.tlt.dri_gender4
    wdetail.ntitle5    =   brstat.tlt.dri_title5
    wdetail.dname5     =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,1,INDEX(brstat.tlt.dri_fname5," ") - 1) ELSE TRIM(brstat.tlt.dri_fname5)
    wdetail.dcname5    =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,R-INDEX(brstat.tlt.dri_fname5," ")) ELSE "" 
    wdetail.dlname5    =   brstat.tlt.dri_lname5
    wdetail.doccup5    =   brstat.tlt.dri_occ5
    wdetail.dbirth5    =   brstat.tlt.dri_birth5
    wdetail.dicno5     =   brstat.tlt.dri_ic5
    wdetail.ddriveno5  =   brstat.tlt.dri_lic5
    wdetail.drivexp5   =   brstat.tlt.dri_licenexp5
    wdetail.drivcon5   =   string(brstat.tlt.dri_consen5)
    wdetail.dlevel5    =   string(brstat.tlt.dri_level5)
    wdetail.dgender5   =   brstat.tlt.dri_gender5  
    wdetail.chargflg    =  STRING(brstat.tlt.chargflg)
    wdetail.chargprice  =  STRING(brstat.tlt.chargsi)
    wdetail.chargno     =  brstat.tlt.chargno
    wdetail.chargprm    =  string(brstat.tlt.chargprem)
    wdetail.battflg     =  string(brstat.tlt.battflg  )
    wdetail.battprice   =  string(brstat.tlt.battprice)
    wdetail.battno      =  brstat.tlt.battno
    wdetail.battprm     =  string(brstat.tlt.battprem)
    wdetail.battdate    =  string(brstat.tlt.ndate1,"99/99/9999")
    wdetail.net_re1     =  string(brstat.tlt.dg_prem)
    wdetail.stam_re1    =  string(brstat.tlt.dg_rstp_t)
    wdetail.vat_re1     =  string(brstat.tlt.dg_rtax_t)
    wdetail.inscode_re2 =  brstat.tlt.ins_code
    wdetail.net_re2     =  string(brstat.tlt.dg_si  )
    wdetail.stam_re2    =  string(brstat.tlt.dg_rate)
    wdetail.vat_re2     =  string(brstat.tlt.dg_feet)
    wdetail.inscode_re3 =  brstat.tlt.Paycode
    wdetail.net_re3     =  string(brstat.tlt.dg_ncb  )
    wdetail.stam_re3    =  string(brstat.tlt.dg_disc )
    wdetail.vat_re3     =  string(brstat.tlt.dg_wdisc) .
 /* END : A68-0061 */
    END.
 
/*
ELSE RUN pd_reportfielBRnoM2. */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_reportfielBRnoM1 c-wins 
PROCEDURE pd_reportfielBRnoM1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

/*IF fi_report = "" THEN DO:*/
    FOR EACH wproducer NO-LOCK.
        For each tlt Use-index  tlt06 Where
            tlt.trndat >=  fi_trndatfr       And
            tlt.trndat <=  fi_trndatto       AND 
            /*tlt.acno1   =  trim(fi_producer) AND*/
            tlt.acno1      =  wproducer.producer  AND 
            tlt.genusr   =  "HCT"            And
            brstat.tlt.ins_brins  <> "M"       NO-LOCK 
            BREAK BY brstat.tlt.comp_noti_ins :
            IF      nv_typre = "V70" AND brstat.tlt.nor_usr_ins  = "0" THEN NEXT.
            ELSE IF nv_typre = "V72" AND brstat.tlt.nor_usr_ins <> "0" THEN NEXT.
            IF brstat.tlt.releas <> cb_reportstatus  THEN NEXT.
            CREATE  wdetail.
            ASSIGN 
            wdetail.n_text001      =  brstat.tlt.comp_noti_ins  
            wdetail.n_text002      =  brstat.tlt.comp_noti_tlt  
            wdetail.n_text003      =  brstat.tlt.comp_pol       
            wdetail.n_text004      =  string(brstat.tlt.nor_effdat,"99/99/9999")     
            wdetail.n_text005      =  string(brstat.tlt.comp_effdat,"99/99/9999")    
            wdetail.n_text006      =  brstat.tlt.comp_sub       
            wdetail.n_text007      =  brstat.tlt.cifno          
            wdetail.n_text008      =  brstat.tlt.nationality    
            wdetail.n_text009      =  brstat.tlt.nor_noti_ins   
            wdetail.n_text010      =  brstat.tlt.nor_noti_tlt   
            wdetail.n_text011      =  brstat.tlt.nor_usr_ins    
            wdetail.n_text012      =  brstat.tlt.covcod         
            wdetail.n_text013      =  brstat.tlt.nor_usr_tlt    
            wdetail.n_text014      =  brstat.tlt.comp_usr_ins   
            wdetail.n_text015      =  brstat.tlt.ins_title      
            wdetail.n_text016      =  brstat.tlt.ins_name       
            wdetail.n_text017      =  brstat.tlt.ins_firstname  
            wdetail.n_text018      =  brstat.tlt.ins_lastname   
            wdetail.n_text019      =  brstat.tlt.ins_addr       
            wdetail.n_text020      =  brstat.tlt.ins_addr1      
            wdetail.n_text021      =  brstat.tlt.ins_addr2      
            wdetail.n_text022      =  brstat.tlt.ins_addr3      
            wdetail.n_text023      =  brstat.tlt.lince2         
            wdetail.n_text024      =  brstat.tlt.ins_addr5      
            wdetail.n_text025      =  brstat.tlt.dir_occ1       
            wdetail.n_text026      =  brstat.tlt.note28         
            wdetail.n_text027      =  brstat.tlt.dri_ic1        
            wdetail.n_text028      =  brstat.tlt.dri_lic1       
            wdetail.n_text029      =  brstat.tlt.brand          
            wdetail.n_text030      =  substr(brstat.tlt.note10,1,1)         
            wdetail.n_text031      =  substr(brstat.tlt.cha_no,1,25)      
            wdetail.n_text032      =  substr(brstat.tlt.eng_no,1,20)                   
            wdetail.n_text033      =  substr(brstat.tlt.model,1,40)                 
            wdetail.n_text034      =  substr(brstat.tlt.note11,1,4)                  
            wdetail.n_text035      =  substr(brstat.tlt.note12,1,20)                  
            wdetail.n_text036      =  substr(brstat.tlt.note13,1,40)                  
            wdetail.n_text037      =  substr(brstat.tlt.note14,1,1)                   
            /*wdetail.n_text038      =  substr(brstat.tlt.vehuse,1,2) */ /* A68-0061*/
            wdetail.n_text038      =  IF rs_typre = 1 THEN substr(brstat.tlt.vehuse,1,2) ELSE TRIM(brstat.tlt.vehuse)  /* A68-0061*/                  
            wdetail.n_text039      =  string(brstat.tlt.seqno,"99")                        
            wdetail.n_text040      =  string(brstat.tlt.cc_weight,"9999")                  
            wdetail.n_text041      =  substr(brstat.tlt.colorcod,1,40)        
            wdetail.n_text042      =  substr(brstat.tlt.lince1,1,10)        
            wdetail.n_text043      =  substr(brstat.tlt.ins_addr4,1,30)        
            wdetail.n_text044      =  substr(brstat.tlt.note15,1,4)         
            wdetail.n_text045      =  substr(brstat.tlt.note16,1,512)              
            wdetail.n_text046      =  substr(brstat.tlt.note17,1,14)        
            wdetail.n_text047      =  substr(brstat.tlt.note18,1,14)       
            wdetail.n_text048      =  substr(brstat.tlt.note19,1,14)          
            wdetail.n_text049      =  substr(brstat.tlt.note2,1,14)          
            wdetail.n_text050      =  substr(brstat.tlt.note20,1,14)       
            wdetail.n_text051      =  substr(brstat.tlt.note21,1,14)          
            wdetail.n_text052      =  substr(brstat.tlt.note22,1,14)        
            wdetail.n_text053      =  substr(brstat.tlt.note23,1,14)        
            wdetail.n_text054      =  substr(brstat.tlt.comp_sck,1,20)        
            wdetail.n_text055      =  substr(brstat.tlt.note24,1,32)        
            wdetail.n_text056      =  substr(brstat.tlt.dri_no1,1,1)        
            wdetail.n_text057      =  substr(brstat.tlt.dri_no2,1,1)         
            wdetail.n_text058      =  substr(brstat.tlt.note25,1,20)      
            wdetail.n_text059      =  substr(brstat.tlt.dri_name1,1,80)      
            wdetail.n_text060      =  substr(brstat.tlt.note26,1,20)      
            wdetail.n_text061      =  substr(brstat.tlt.note27,1,60)      
            wdetail.n_text062      =  substr(brstat.tlt.dri_occ2,1,50)   
            wdetail.n_text063      =  substr(brstat.tlt.note4,1,10)         
            wdetail.n_text064      =  substr(brstat.tlt.dri_ic2,1,15)         
            wdetail.n_text065      =  substr(brstat.tlt.dri_lic2,1,15)         
            wdetail.n_text066      =  substr(brstat.tlt.note29,1,20)         
            wdetail.n_text067      =  substr(brstat.tlt.dri_name2,1,80)         
            wdetail.n_text068      =  substr(brstat.tlt.note3,1,20)         
            wdetail.n_text069      =  substr(brstat.tlt.note30,1,60)         
            wdetail.n_text070      =  substr(brstat.tlt.ins_occ,1,50)         
            wdetail.n_text071      =  IF brstat.tlt.birthdate = ? THEN "" ELSE string(brstat.tlt.birthdate,"99/99/9999")              
            wdetail.n_text072      =  substr(brstat.tlt.ins_icno,1,15)           
            wdetail.n_text073      =  substr(brstat.tlt.note1,1,15)                   
            wdetail.n_text074      =  substr(brstat.tlt.ben83,1,80)                   
            wdetail.n_text075      =  string(brstat.tlt.comp_coamt,"99999999999.99")      
            wdetail.n_text076      =  string(brstat.tlt.comp_grprm,"99999999999.99")      
            wdetail.n_text077      =  string(brstat.tlt.mileage,"99999999999.99")         
            wdetail.n_text078      =  string(brstat.tlt.ndeci1,"99999999999.99")          
            wdetail.n_text079      =  string(brstat.tlt.ndeci2,"99999999999.99")          
            wdetail.n_text080      =  string(brstat.tlt.ndeci3,"99999999999.99")          
            wdetail.n_text081      =  string(brstat.tlt.ndeci4,"99999999999.99")          
            wdetail.n_text082      =  string(brstat.tlt.ndeci5,"99999999999.99")          
            wdetail.n_text083      =  string(brstat.tlt.nor_coamt,"99")                    
            wdetail.n_text084      =  string(brstat.tlt.nor_grprm,"99999999999.99")       
            wdetail.n_text085      =  string(brstat.tlt.prem_amt,"99999999999.99")        
            wdetail.n_text086      =  string(brstat.tlt.prem_amttcop,"99")                 
            wdetail.n_text087      =  string(brstat.tlt.rstp,"99999999999.99")            
            wdetail.n_text088      =  string(brstat.tlt.rtax,"99999999999.99")            
            wdetail.n_text089      =  string(brstat.tlt.tax_coporate,"99999999999.99")    
            wdetail.n_text090      =  substr(brstat.tlt.note5,1,6)            
            wdetail.n_text091      =  substr(brstat.tlt.note6,1,10)        
            wdetail.n_text092      =  substr(brstat.tlt.note7,1,10)        
            wdetail.n_text093      =  substr(brstat.tlt.note8,1,30)        
            wdetail.n_text094      =  substr(brstat.tlt.note9,1,80)        
            wdetail.n_text095      =  substr(brstat.tlt.noteveh1,1,10)        
            wdetail.n_text096      =  substr(brstat.tlt.noteveh2,1,30)        
            wdetail.n_text097      =  substr(brstat.tlt.old_cha,1,12)        
            wdetail.n_text098      =  substr(brstat.tlt.old_eng,1,3)             
            wdetail.n_text099      =  substr(brstat.tlt.pack,1,10)      
            wdetail.n_text100      =  substr(brstat.tlt.packnme,1,14)      
            wdetail.n_text101      =  substr(brstat.tlt.period,1,10)      
            wdetail.n_text102      =  substr(brstat.tlt.ln_note1,1,14) 
            wdetail.n_text103      =  substr(brstat.tlt.product,1,10)   
            wdetail.n_text104      =  substr(brstat.tlt.projnme,1,14)   
            wdetail.n_text105      =  substr(brstat.tlt.proveh,1,10)   
            wdetail.n_text106      =  substr(brstat.tlt.race,1,14)   
            wdetail.n_text107      =  substr(brstat.tlt.recac,1,10)   
            wdetail.n_text108      =  substr(brstat.tlt.rec_addr,1,14)   
            wdetail.n_text109      =  substr(brstat.tlt.rec_addr1,1,15)   
            wdetail.n_text110      =  substr(brstat.tlt.rec_addr2,1,10)   
            wdetail.n_text111      =  substr(brstat.tlt.rec_addr3,1,14)   
            wdetail.n_text112      =  substr(brstat.tlt.rec_addr4,1,10)   
            wdetail.n_text113      =  substr(brstat.tlt.rec_addr5,1,20)   
            wdetail.n_text114      =  substr(brstat.tlt.rec_brins,1,1)         
            wdetail.n_text115      =  substr(brstat.tlt.rec_cou,1,120)      
            wdetail.n_text116      =  substr(brstat.tlt.rec_icno,1,100)      
            wdetail.n_text117      =  substr(brstat.tlt.rec_name,1,2)         
            wdetail.n_text118      =  substr(brstat.tlt.rec_name2,1,2)         
            wdetail.n_text119      =  substr(brstat.tlt.rec_note1,1,10)        
            wdetail.n_text120      =  substr(brstat.tlt.rec_note2,1,1)        
            wdetail.n_text121      =  substr(brstat.tlt.rec_title,1,10)        
            wdetail.n_text122      =  substr(brstat.tlt.rec_typ,1,255)       
            wdetail.n_text123      =  substr(brstat.tlt.rider,1,5)         
            wdetail.n_text124      =  substr(brstat.tlt.safe1,1,20)        
            wdetail.n_text125      =  substr(brstat.tlt.safe2,1,10)        
            wdetail.n_text126      =  substr(brstat.tlt.safe3,1,150)       
            wdetail.n_text127      =  substr(brstat.tlt.sex,1,15)        
            wdetail.n_text128      =  substr(brstat.tlt.stat,1,250)       
            wdetail.n_text129      =  substr(brstat.tlt.subins,1,13)        
            wdetail.n_text130      =  substr(brstat.tlt.tel,1,10)        
            wdetail.n_text131      =  substr(brstat.tlt.tel2,1,150)      
            wdetail.n_text132      =  substr(brstat.tlt.tel3,1,15)       
            wdetail.n_text133      =  substr(brstat.tlt.usrid,1,250)       
            wdetail.n_text134      =  substr(brstat.tlt.usrsent,1,13)       
            wdetail.n_text135      =  substr(brstat.tlt.ln_product,1,10)     
            wdetail.n_text136      =  substr(brstat.tlt.ln_pronme,1,150)    
            wdetail.n_text137      =  substr(brstat.tlt.ln_rate,1,15)     
            wdetail.n_text138      =  substr(brstat.tlt.ln_st,1,250)    
            wdetail.n_text139      =  substr(brstat.tlt.lotno,1,13)    
            wdetail.n_text140      =  substr(brstat.tlt.maritalsts,1,10)    
            wdetail.n_text141      =  substr(brstat.tlt.campaign,1,12)    
            wdetail.n_text142      =  substr(brstat.tlt.mobile,1,10) 
            wdetail.n_text143      =  brstat.tlt.acno1   
            wdetail.n_text144      =  brstat.tlt.agent  .   
            /* ADD BY : A68-0061 */
           ASSIGN 
           wdetail.typepol    =   brstat.tlt.poltyp
           wdetail.typecar    =   brstat.tlt.car_type
           wdetail.maksi      =   STRING(brstat.tlt.maksi)
           wdetail.drivexp1   =   brstat.tlt.dri_licenexp1
           wdetail.drivcon1   =   string(brstat.tlt.dri_consen1)
           wdetail.dlevel1    =   string(brstat.tlt.dri_level1)
           wdetail.dgender1   =   brstat.tlt.dri_gender1
           wdetail.drivexp2   =   brstat.tlt.dri_licenexp2
           wdetail.drivcon2   =   string(brstat.tlt.dri_consen2)
           wdetail.dlevel2    =   string(brstat.tlt.dri_level2)
           wdetail.dgender2   =   brstat.tlt.dri_gender2
           wdetail.ntitle3    =   brstat.tlt.dri_title3
           wdetail.dname3     =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,1,INDEX(brstat.tlt.dri_fname3," ") - 1) ELSE TRIM(brstat.tlt.dri_fname3)
           wdetail.dcname3    =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,R-INDEX(brstat.tlt.dri_fname3," ")) ELSE "" 
           wdetail.dlname3    =   brstat.tlt.dri_lname3
           wdetail.doccup3    =   brstat.tlt.dir_occ3
           wdetail.dbirth3    =   brstat.tlt.dri_birth3
           wdetail.dicno3     =   brstat.tlt.dri_ic3
           wdetail.ddriveno3  =   brstat.tlt.dri_lic3
           wdetail.drivexp3   =   brstat.tlt.dri_licenexp3
           wdetail.drivcon3   =   string(brstat.tlt.dri_consen3)
           wdetail.dlevel3    =   string(brstat.tlt.dri_level3)
           wdetail.dgender3   =   brstat.tlt.dri_gender3
           wdetail.ntitle4    =   brstat.tlt.dri_title4
           wdetail.dname4     =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,1,INDEX(brstat.tlt.dri_fname4," ") - 1) ELSE TRIM(brstat.tlt.dri_fname4)
           wdetail.dcname4    =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,R-INDEX(brstat.tlt.dri_fname4," ")) ELSE ""
           wdetail.dlname4    =   brstat.tlt.dri_lname4
           wdetail.doccup4    =   brstat.tlt.dri_occ4
           wdetail.dbirth4    =   brstat.tlt.dri_birth4
           wdetail.dicno4     =   brstat.tlt.dri_ic4
           wdetail.ddriveno4  =   brstat.tlt.dri_lic4
           wdetail.drivexp4   =   brstat.tlt.dri_licenexp4
           wdetail.drivcon4   =   string(brstat.tlt.dri_consen4)
           wdetail.dlevel4    =   string(brstat.tlt.dri_level4)
           wdetail.dgender4   =   brstat.tlt.dri_gender4
           wdetail.ntitle5    =   brstat.tlt.dri_title5
           wdetail.dname5     =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,1,INDEX(brstat.tlt.dri_fname5," ") - 1) ELSE TRIM(brstat.tlt.dri_fname5)
           wdetail.dcname5    =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,R-INDEX(brstat.tlt.dri_fname5," ")) ELSE "" 
           wdetail.dlname5    =   brstat.tlt.dri_lname5
           wdetail.doccup5    =   brstat.tlt.dri_occ5
           wdetail.dbirth5    =   brstat.tlt.dri_birth5
           wdetail.dicno5     =   brstat.tlt.dri_ic5
           wdetail.ddriveno5  =   brstat.tlt.dri_lic5
           wdetail.drivexp5   =   brstat.tlt.dri_licenexp5
           wdetail.drivcon5   =   string(brstat.tlt.dri_consen5)
           wdetail.dlevel5    =   string(brstat.tlt.dri_level5)
           wdetail.dgender5   =   brstat.tlt.dri_gender5  
           wdetail.chargflg    =  STRING(brstat.tlt.chargflg)
           wdetail.chargprice  =  STRING(brstat.tlt.chargsi)
           wdetail.chargno     =  brstat.tlt.chargno
           wdetail.chargprm    =  string(brstat.tlt.chargprem)
           wdetail.battflg     =  string(brstat.tlt.battflg  )
           wdetail.battprice   =  string(brstat.tlt.battprice)
           wdetail.battno      =  brstat.tlt.battno
           wdetail.battprm     =  string(brstat.tlt.battprem)
           wdetail.battdate    =  string(brstat.tlt.ndate1,"99/99/9999")
           wdetail.net_re1     =  string(brstat.tlt.dg_prem)
           wdetail.stam_re1    =  string(brstat.tlt.dg_rstp_t)
           wdetail.vat_re1     =  string(brstat.tlt.dg_rtax_t)
           wdetail.inscode_re2 =  brstat.tlt.ins_code
           wdetail.net_re2     =  string(brstat.tlt.dg_si  )
           wdetail.stam_re2    =  string(brstat.tlt.dg_rate)
           wdetail.vat_re2     =  string(brstat.tlt.dg_feet)
           wdetail.inscode_re3 =  brstat.tlt.Paycode
           wdetail.net_re3     =  string(brstat.tlt.dg_ncb  )
           wdetail.stam_re3    =  string(brstat.tlt.dg_disc )
           wdetail.vat_re3     =  string(brstat.tlt.dg_wdisc) .
           /* END : A68-0061 */
    END.
END.
/*
END.
ELSE RUN pd_reportfielBRnoM3.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_reportfielBRnoM2 c-wins 
PROCEDURE pd_reportfielBRnoM2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
For each tlt Use-index  tlt06     Where
    tlt.trndat >=  fi_trndatfr      And
    tlt.trndat <=  fi_trndatto      AND 
    tlt.releas  =  trim(fi_report)  AND
    tlt.genusr  =  "HCT"            And
    brstat.tlt.ins_brins  <> "M"    NO-LOCK 
    BREAK BY brstat.tlt.comp_noti_ins :

    IF      nv_typre = "V70" AND brstat.tlt.nor_usr_ins  = "0" THEN NEXT.
    ELSE IF nv_typre = "V72" AND brstat.tlt.nor_usr_ins <> "0" THEN NEXT.

    CREATE  wdetail.
    ASSIGN 
 wdetail.n_text001      =  brstat.tlt.comp_noti_ins  
 wdetail.n_text002      =  brstat.tlt.comp_noti_tlt  
 wdetail.n_text003      =  brstat.tlt.comp_pol       
 wdetail.n_text004      =  string(brstat.tlt.nor_effdat,"99/99/9999")     
 wdetail.n_text005      =  string(brstat.tlt.comp_effdat,"99/99/9999")    
 wdetail.n_text006      =  brstat.tlt.comp_sub       
 wdetail.n_text007      =  brstat.tlt.cifno          
 wdetail.n_text008      =  brstat.tlt.nationality    
 wdetail.n_text009      =  brstat.tlt.nor_noti_ins   
 wdetail.n_text010      =  brstat.tlt.nor_noti_tlt   
 wdetail.n_text011      =  brstat.tlt.nor_usr_ins    
 wdetail.n_text012      =  brstat.tlt.covcod         
 wdetail.n_text013      =  brstat.tlt.nor_usr_tlt    
 wdetail.n_text014      =  brstat.tlt.comp_usr_ins   
 wdetail.n_text015      =  brstat.tlt.ins_title      
 wdetail.n_text016      =  brstat.tlt.ins_name       
 wdetail.n_text017      =  brstat.tlt.ins_firstname  
 wdetail.n_text018      =  brstat.tlt.ins_lastname   
 wdetail.n_text019      =  brstat.tlt.ins_addr       
 wdetail.n_text020      =  brstat.tlt.ins_addr1      
 wdetail.n_text021      =  brstat.tlt.ins_addr2      
 wdetail.n_text022      =  brstat.tlt.ins_addr3      
 wdetail.n_text023      =  brstat.tlt.lince2         
 wdetail.n_text024      =  brstat.tlt.ins_addr5      
 wdetail.n_text025      =  brstat.tlt.dir_occ1       
 wdetail.n_text026      =  brstat.tlt.note28         
 wdetail.n_text027      =  brstat.tlt.dri_ic1        
 wdetail.n_text028      =  brstat.tlt.dri_lic1       
 wdetail.n_text029      =  brstat.tlt.brand          
 wdetail.n_text030      =  substr(brstat.tlt.note10,1,1)         
 wdetail.n_text031      =  substr(brstat.tlt.cha_no,1,25)      
 wdetail.n_text032      =  substr(brstat.tlt.eng_no,1,20)                   
 wdetail.n_text033      =  substr(brstat.tlt.model,1,40)                 
 wdetail.n_text034      =  substr(brstat.tlt.note11,1,4)                  
 wdetail.n_text035      =  substr(brstat.tlt.note12,1,20)                  
 wdetail.n_text036      =  substr(brstat.tlt.note13,1,40)                  
 wdetail.n_text037      =  substr(brstat.tlt.note14,1,1)                   
 wdetail.n_text038      =  substr(brstat.tlt.vehuse,1,2)                   
 wdetail.n_text039      =  string(brstat.tlt.seqno,"99")                        
 wdetail.n_text040      =  string(brstat.tlt.cc_weight,"9999")                  
 wdetail.n_text041      =  substr(brstat.tlt.colorcod,1,40)        
 wdetail.n_text042      =  substr(brstat.tlt.lince1,1,10)        
 wdetail.n_text043      =  substr(brstat.tlt.ins_addr4,1,30)        
 wdetail.n_text044      =  substr(brstat.tlt.note15,1,4)         
 wdetail.n_text045      =  substr(brstat.tlt.note16,1,512)              
 wdetail.n_text046      =  substr(brstat.tlt.note17,1,14)        
 wdetail.n_text047      =  substr(brstat.tlt.note18,1,14)       
 wdetail.n_text048      =  substr(brstat.tlt.note19,1,14)          
 wdetail.n_text049      =  substr(brstat.tlt.note2,1,14)          
 wdetail.n_text050      =  substr(brstat.tlt.note20,1,14)       
 wdetail.n_text051      =  substr(brstat.tlt.note21,1,14)          
 wdetail.n_text052      =  substr(brstat.tlt.note22,1,14)        
 wdetail.n_text053      =  substr(brstat.tlt.note23,1,14)        
 wdetail.n_text054      =  substr(brstat.tlt.comp_sck,1,20)        
 wdetail.n_text055      =  substr(brstat.tlt.note24,1,32)        
 wdetail.n_text056      =  substr(brstat.tlt.dri_no1,1,1)        
 wdetail.n_text057      =  substr(brstat.tlt.dri_no2,1,1)         
 wdetail.n_text058      =  substr(brstat.tlt.note25,1,20)      
 wdetail.n_text059      =  substr(brstat.tlt.dri_name1,1,80)      
 wdetail.n_text060      =  substr(brstat.tlt.note26,1,20)      
 wdetail.n_text061      =  substr(brstat.tlt.note27,1,60)      
 wdetail.n_text062      =  substr(brstat.tlt.dri_occ2,1,50)   
 wdetail.n_text063      =  substr(brstat.tlt.note4,1,10)         
 wdetail.n_text064      =  substr(brstat.tlt.dri_ic2,1,15)         
 wdetail.n_text065      =  substr(brstat.tlt.dri_lic2,1,15)         
 wdetail.n_text066      =  substr(brstat.tlt.note29,1,20)         
 wdetail.n_text067      =  substr(brstat.tlt.dri_name2,1,80)         
 wdetail.n_text068      =  substr(brstat.tlt.note3,1,20)         
 wdetail.n_text069      =  substr(brstat.tlt.note30,1,60)         
 wdetail.n_text070      =  substr(brstat.tlt.ins_occ,1,50)         
 wdetail.n_text071      =  IF brstat.tlt.birthdate = ? THEN "" ELSE string(brstat.tlt.birthdate,"99/99/9999")              
 wdetail.n_text072      =  substr(brstat.tlt.ins_icno,1,15)           
 wdetail.n_text073      =  substr(brstat.tlt.note1,1,15)                   
 wdetail.n_text074      =  substr(brstat.tlt.ben83,1,80)                   
 wdetail.n_text075      =  string(brstat.tlt.comp_coamt,"99999999999.99")      
 wdetail.n_text076      =  string(brstat.tlt.comp_grprm,"99999999999.99")      
 wdetail.n_text077      =     string(brstat.tlt.mileage,"99999999999.99")         
 wdetail.n_text078      =      string(brstat.tlt.ndeci1,"99999999999.99")          
 wdetail.n_text079      =      string(brstat.tlt.ndeci2,"99999999999.99")          
 wdetail.n_text080      =      string(brstat.tlt.ndeci3,"99999999999.99")          
 wdetail.n_text081      =      string(brstat.tlt.ndeci4,"99999999999.99")          
 wdetail.n_text082      =      string(brstat.tlt.ndeci5,"99999999999.99")          
 wdetail.n_text083      =   string(brstat.tlt.nor_coamt,"99")                    
 wdetail.n_text084      =   string(brstat.tlt.nor_grprm,"99999999999.99")       
 wdetail.n_text085      =    string(brstat.tlt.prem_amt,"99999999999.99")        
 wdetail.n_text086     = string(brstat.tlt.prem_amttcop,"99")                 
 wdetail.n_text087      =        string(brstat.tlt.rstp,"99999999999.99")            
 wdetail.n_text088      =        string(brstat.tlt.rtax,"99999999999.99")            
 wdetail.n_text089     = string(brstat.tlt.tax_coporate,"99999999999.99")    
 wdetail.n_text090      =  substr(brstat.tlt.note5,1,6)            
 wdetail.n_text091      =  substr(brstat.tlt.note6,1,10)        
 wdetail.n_text092      =  substr(brstat.tlt.note7,1,10)        
 wdetail.n_text093      =  substr(brstat.tlt.note8,1,30)        
 wdetail.n_text094      =  substr(brstat.tlt.note9,1,80)        
 wdetail.n_text095      =  substr(brstat.tlt.noteveh1,1,10)        
 wdetail.n_text096      =  substr(brstat.tlt.noteveh2,1,30)        
 wdetail.n_text097      =  substr(brstat.tlt.old_cha,1,12)        
 wdetail.n_text098      =  substr(brstat.tlt.old_eng,1,3)             
 wdetail.n_text099      =  substr(brstat.tlt.pack,1,10)      
 wdetail.n_text100      =  substr(brstat.tlt.packnme,1,14)      
 wdetail.n_text101      =  substr(brstat.tlt.period,1,10)      
 wdetail.n_text102      =  substr(brstat.tlt.ln_note1,1,14) 
 wdetail.n_text103      =  substr(brstat.tlt.product,1,10)   
 wdetail.n_text104      =  substr(brstat.tlt.projnme,1,14)   
 wdetail.n_text105      =  substr(brstat.tlt.proveh,1,10)   
 wdetail.n_text106      =  substr(brstat.tlt.race,1,14)   
 wdetail.n_text107      =  substr(brstat.tlt.recac,1,10)   
 wdetail.n_text108      =  substr(brstat.tlt.rec_addr,1,14)   
 wdetail.n_text109      =  substr(brstat.tlt.rec_addr1,1,15)   
 wdetail.n_text110      =  substr(brstat.tlt.rec_addr2,1,10)   
 wdetail.n_text111      =  substr(brstat.tlt.rec_addr3,1,14)   
 wdetail.n_text112      =  substr(brstat.tlt.rec_addr4,1,10)   
 wdetail.n_text113      =  substr(brstat.tlt.rec_addr5,1,20)   
 wdetail.n_text114      =  substr(brstat.tlt.rec_brins,1,1)         
 wdetail.n_text115      =  substr(brstat.tlt.rec_cou,1,120)      
 wdetail.n_text116      =  substr(brstat.tlt.rec_icno,1,100)      
 wdetail.n_text117      =  substr(brstat.tlt.rec_name,1,2)         
 wdetail.n_text118      =  substr(brstat.tlt.rec_name2,1,2)         
 wdetail.n_text119      =  substr(brstat.tlt.rec_note1,1,10)        
 wdetail.n_text120      =  substr(brstat.tlt.rec_note2,1,1)        
 wdetail.n_text121      =  substr(brstat.tlt.rec_title,1,10)        
 wdetail.n_text122      =  substr(brstat.tlt.rec_typ,1,255)       
 wdetail.n_text123      =  substr(brstat.tlt.rider,1,5)         
 wdetail.n_text124      =  substr(brstat.tlt.safe1,1,20)        
 wdetail.n_text125      =  substr(brstat.tlt.safe2,1,10)        
 wdetail.n_text126      =  substr(brstat.tlt.safe3,1,150)       
 wdetail.n_text127      =  substr(brstat.tlt.sex,1,15)        
 wdetail.n_text128      =  substr(brstat.tlt.stat,1,250)       
 wdetail.n_text129      =  substr(brstat.tlt.subins,1,13)        
 wdetail.n_text130      =  substr(brstat.tlt.tel,1,10)        
 wdetail.n_text131      =  substr(brstat.tlt.tel2,1,150)      
 wdetail.n_text132      =  substr(brstat.tlt.tel3,1,15)       
 wdetail.n_text133      =  substr(brstat.tlt.usrid,1,250)       
 wdetail.n_text134      =  substr(brstat.tlt.usrsent,1,13)       
 wdetail.n_text135      =  substr(brstat.tlt.ln_product,1,10)     
 wdetail.n_text136      =  substr(brstat.tlt.ln_pronme,1,150)    
 wdetail.n_text137      =  substr(brstat.tlt.ln_rate,1,15)     
 wdetail.n_text138      =  substr(brstat.tlt.ln_st,1,250)    
 wdetail.n_text139      =  substr(brstat.tlt.lotno,1,13)    
 wdetail.n_text140      =  substr(brstat.tlt.maritalsts,1,10)    
 wdetail.n_text141      =  substr(brstat.tlt.campaign,1,12)    
 wdetail.n_text142      =  substr(brstat.tlt.mobile,1,10)    
 wdetail.n_text143      =  brstat.tlt.acno1   
 wdetail.n_text144      =  brstat.tlt.agent  .
END. 
 */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_reportfielBRnoM3 c-wins 
PROCEDURE pd_reportfielBRnoM3 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
FOR EACH wproducer NO-LOCK.
        For each tlt Use-index  tlt06 Where
            tlt.trndat >=  fi_trndatfr       And
            tlt.trndat <=  fi_trndatto       AND 
            /*tlt.acno1   =  trim(fi_producer) AND*/
            tlt.acno1      =  wproducer.producer  AND 
            tlt.genusr     =  "HCT"            And
            tlt.ins_brins  <> "M"              AND
            tlt.releas     =  trim(fi_report)  NO-LOCK 
            BREAK BY brstat.tlt.comp_noti_ins :
            IF      nv_typre = "V70" AND brstat.tlt.nor_usr_ins  = "0" THEN NEXT.
            ELSE IF nv_typre = "V72" AND brstat.tlt.nor_usr_ins <> "0" THEN NEXT.
            CREATE  wdetail.
            ASSIGN 
            wdetail.n_text001      =  brstat.tlt.comp_noti_ins  
            wdetail.n_text002      =  brstat.tlt.comp_noti_tlt  
            wdetail.n_text003      =  brstat.tlt.comp_pol       
            wdetail.n_text004      =  string(brstat.tlt.nor_effdat,"99/99/9999")     
            wdetail.n_text005      =  string(brstat.tlt.comp_effdat,"99/99/9999")    
            wdetail.n_text006      =  brstat.tlt.comp_sub       
            wdetail.n_text007      =  brstat.tlt.cifno          
            wdetail.n_text008      =  brstat.tlt.nationality    
            wdetail.n_text009      =  brstat.tlt.nor_noti_ins   
            wdetail.n_text010      =  brstat.tlt.nor_noti_tlt   
            wdetail.n_text011      =  brstat.tlt.nor_usr_ins    
            wdetail.n_text012      =  brstat.tlt.covcod         
            wdetail.n_text013      =  brstat.tlt.nor_usr_tlt    
            wdetail.n_text014      =  brstat.tlt.comp_usr_ins   
            wdetail.n_text015      =  brstat.tlt.ins_title      
            wdetail.n_text016      =  brstat.tlt.ins_name       
            wdetail.n_text017      =  brstat.tlt.ins_firstname  
            wdetail.n_text018      =  brstat.tlt.ins_lastname   
            wdetail.n_text019      =  brstat.tlt.ins_addr       
            wdetail.n_text020      =  brstat.tlt.ins_addr1      
            wdetail.n_text021      =  brstat.tlt.ins_addr2      
            wdetail.n_text022      =  brstat.tlt.ins_addr3      
            wdetail.n_text023      =  brstat.tlt.lince2         
            wdetail.n_text024      =  brstat.tlt.ins_addr5      
            wdetail.n_text025      =  brstat.tlt.dir_occ1       
            wdetail.n_text026      =  brstat.tlt.note28         
            wdetail.n_text027      =  brstat.tlt.dri_ic1        
            wdetail.n_text028      =  brstat.tlt.dri_lic1       
            wdetail.n_text029      =  brstat.tlt.brand          
            wdetail.n_text030      =  substr(brstat.tlt.note10,1,1)         
            wdetail.n_text031      =  substr(brstat.tlt.cha_no,1,25)      
            wdetail.n_text032      =  substr(brstat.tlt.eng_no,1,20)                   
            wdetail.n_text033      =  substr(brstat.tlt.model,1,40)                 
            wdetail.n_text034      =  substr(brstat.tlt.note11,1,4)                  
            wdetail.n_text035      =  substr(brstat.tlt.note12,1,20)                  
            wdetail.n_text036      =  substr(brstat.tlt.note13,1,40)                  
            wdetail.n_text037      =  substr(brstat.tlt.note14,1,1)                   
            wdetail.n_text038      =  substr(brstat.tlt.vehuse,1,2)                   
            wdetail.n_text039      =  string(brstat.tlt.seqno,"99")                        
            wdetail.n_text040      =  string(brstat.tlt.cc_weight,"9999")                  
            wdetail.n_text041      =  substr(brstat.tlt.colorcod,1,40)        
            wdetail.n_text042      =  substr(brstat.tlt.lince1,1,10)        
            wdetail.n_text043      =  substr(brstat.tlt.ins_addr4,1,30)        
            wdetail.n_text044      =  substr(brstat.tlt.note15,1,4)         
            wdetail.n_text045      =  substr(brstat.tlt.note16,1,512)              
            wdetail.n_text046      =  substr(brstat.tlt.note17,1,14)        
            wdetail.n_text047      =  substr(brstat.tlt.note18,1,14)       
            wdetail.n_text048      =  substr(brstat.tlt.note19,1,14)          
            wdetail.n_text049      =  substr(brstat.tlt.note2,1,14)          
            wdetail.n_text050      =  substr(brstat.tlt.note20,1,14)       
            wdetail.n_text051      =  substr(brstat.tlt.note21,1,14)          
            wdetail.n_text052      =  substr(brstat.tlt.note22,1,14)        
            wdetail.n_text053      =  substr(brstat.tlt.note23,1,14)        
            wdetail.n_text054      =  substr(brstat.tlt.comp_sck,1,20)        
            wdetail.n_text055      =  substr(brstat.tlt.note24,1,32)        
            wdetail.n_text056      =  substr(brstat.tlt.dri_no1,1,1)        
            wdetail.n_text057      =  substr(brstat.tlt.dri_no2,1,1)         
            wdetail.n_text058      =  substr(brstat.tlt.note25,1,20)      
            wdetail.n_text059      =  substr(brstat.tlt.dri_name1,1,80)      
            wdetail.n_text060      =  substr(brstat.tlt.note26,1,20)      
            wdetail.n_text061      =  substr(brstat.tlt.note27,1,60)      
            wdetail.n_text062      =  substr(brstat.tlt.dri_occ2,1,50)   
            wdetail.n_text063      =  substr(brstat.tlt.note4,1,10)         
            wdetail.n_text064      =  substr(brstat.tlt.dri_ic2,1,15)         
            wdetail.n_text065      =  substr(brstat.tlt.dri_lic2,1,15)         
            wdetail.n_text066      =  substr(brstat.tlt.note29,1,20)         
            wdetail.n_text067      =  substr(brstat.tlt.dri_name2,1,80)         
            wdetail.n_text068      =  substr(brstat.tlt.note3,1,20)         
            wdetail.n_text069      =  substr(brstat.tlt.note30,1,60)         
            wdetail.n_text070      =  substr(brstat.tlt.ins_occ,1,50)         
            wdetail.n_text071      =  IF brstat.tlt.birthdate = ? THEN "" ELSE string(brstat.tlt.birthdate,"99/99/9999")              
            wdetail.n_text072      =  substr(brstat.tlt.ins_icno,1,15)           
            wdetail.n_text073      =  substr(brstat.tlt.note1,1,15)                   
            wdetail.n_text074      =  substr(brstat.tlt.ben83,1,80)                   
            wdetail.n_text075      =  string(brstat.tlt.comp_coamt,"99999999999.99")      
            wdetail.n_text076      =  string(brstat.tlt.comp_grprm,"99999999999.99")      
            wdetail.n_text077      =  string(brstat.tlt.mileage,"99999999999.99")         
            wdetail.n_text078      =  string(brstat.tlt.ndeci1,"99999999999.99")          
            wdetail.n_text079      =  string(brstat.tlt.ndeci2,"99999999999.99")          
            wdetail.n_text080      =  string(brstat.tlt.ndeci3,"99999999999.99")          
            wdetail.n_text081      =  string(brstat.tlt.ndeci4,"99999999999.99")          
            wdetail.n_text082      =  string(brstat.tlt.ndeci5,"99999999999.99")          
            wdetail.n_text083      =  string(brstat.tlt.nor_coamt,"99")                    
            wdetail.n_text084      =  string(brstat.tlt.nor_grprm,"99999999999.99")       
            wdetail.n_text085      =  string(brstat.tlt.prem_amt,"99999999999.99")        
            wdetail.n_text086      =  string(brstat.tlt.prem_amttcop,"99")                 
            wdetail.n_text087      =  string(brstat.tlt.rstp,"99999999999.99")            
            wdetail.n_text088      =  string(brstat.tlt.rtax,"99999999999.99")            
            wdetail.n_text089      =  string(brstat.tlt.tax_coporate,"99999999999.99")    
            wdetail.n_text090      =  substr(brstat.tlt.note5,1,6)            
            wdetail.n_text091      =  substr(brstat.tlt.note6,1,10)        
            wdetail.n_text092      =  substr(brstat.tlt.note7,1,10)        
            wdetail.n_text093      =  substr(brstat.tlt.note8,1,30)        
            wdetail.n_text094      =  substr(brstat.tlt.note9,1,80)        
            wdetail.n_text095      =  substr(brstat.tlt.noteveh1,1,10)        
            wdetail.n_text096      =  substr(brstat.tlt.noteveh2,1,30)        
            wdetail.n_text097      =  substr(brstat.tlt.old_cha,1,12)        
            wdetail.n_text098      =  substr(brstat.tlt.old_eng,1,3)             
            wdetail.n_text099      =  substr(brstat.tlt.pack,1,10)      
            wdetail.n_text100      =  substr(brstat.tlt.packnme,1,14)      
            wdetail.n_text101      =  substr(brstat.tlt.period,1,10)      
            wdetail.n_text102      =  substr(brstat.tlt.ln_note1,1,14) 
            wdetail.n_text103      =  substr(brstat.tlt.product,1,10)   
            wdetail.n_text104      =  substr(brstat.tlt.projnme,1,14)   
            wdetail.n_text105      =  substr(brstat.tlt.proveh,1,10)   
            wdetail.n_text106      =  substr(brstat.tlt.race,1,14)   
            wdetail.n_text107      =  substr(brstat.tlt.recac,1,10)   
            wdetail.n_text108      =  substr(brstat.tlt.rec_addr,1,14)   
            wdetail.n_text109      =  substr(brstat.tlt.rec_addr1,1,15)   
            wdetail.n_text110      =  substr(brstat.tlt.rec_addr2,1,10)   
            wdetail.n_text111      =  substr(brstat.tlt.rec_addr3,1,14)   
            wdetail.n_text112      =  substr(brstat.tlt.rec_addr4,1,10)   
            wdetail.n_text113      =  substr(brstat.tlt.rec_addr5,1,20)   
            wdetail.n_text114      =  substr(brstat.tlt.rec_brins,1,1)         
            wdetail.n_text115      =  substr(brstat.tlt.rec_cou,1,120)      
            wdetail.n_text116      =  substr(brstat.tlt.rec_icno,1,100)      
            wdetail.n_text117      =  substr(brstat.tlt.rec_name,1,2)         
            wdetail.n_text118      =  substr(brstat.tlt.rec_name2,1,2)         
            wdetail.n_text119      =  substr(brstat.tlt.rec_note1,1,10)        
            wdetail.n_text120      =  substr(brstat.tlt.rec_note2,1,1)        
            wdetail.n_text121      =  substr(brstat.tlt.rec_title,1,10)        
            wdetail.n_text122      =  substr(brstat.tlt.rec_typ,1,255)       
            wdetail.n_text123      =  substr(brstat.tlt.rider,1,5)         
            wdetail.n_text124      =  substr(brstat.tlt.safe1,1,20)        
            wdetail.n_text125      =  substr(brstat.tlt.safe2,1,10)        
            wdetail.n_text126      =  substr(brstat.tlt.safe3,1,150)       
            wdetail.n_text127      =  substr(brstat.tlt.sex,1,15)        
            wdetail.n_text128      =  substr(brstat.tlt.stat,1,250)       
            wdetail.n_text129      =  substr(brstat.tlt.subins,1,13)        
            wdetail.n_text130      =  substr(brstat.tlt.tel,1,10)        
            wdetail.n_text131      =  substr(brstat.tlt.tel2,1,150)      
            wdetail.n_text132      =  substr(brstat.tlt.tel3,1,15)       
            wdetail.n_text133      =  substr(brstat.tlt.usrid,1,250)       
            wdetail.n_text134      =  substr(brstat.tlt.usrsent,1,13)       
            wdetail.n_text135      =  substr(brstat.tlt.ln_product,1,10)     
            wdetail.n_text136      =  substr(brstat.tlt.ln_pronme,1,150)    
            wdetail.n_text137      =  substr(brstat.tlt.ln_rate,1,15)     
            wdetail.n_text138      =  substr(brstat.tlt.ln_st,1,250)    
            wdetail.n_text139      =  substr(brstat.tlt.lotno,1,13)    
            wdetail.n_text140      =  substr(brstat.tlt.maritalsts,1,10)    
            wdetail.n_text141      =  substr(brstat.tlt.campaign,1,12)    
            wdetail.n_text142      =  substr(brstat.tlt.mobile,1,10) 
            wdetail.n_text143      =  brstat.tlt.acno1   
            wdetail.n_text144      =  brstat.tlt.agent  .   
    END.
END.
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_reportfielCSV c-wins 
PROCEDURE pd_reportfielCSV :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
OUTPUT TO VALUE(fi_outfileexp).
RUN pd_reportfielCSV_HD. 
For each wdetail   NO-LOCK 
   BREAK BY wdetail.n_text001 :
   EXPORT DELIMITER ","
      wdetail.n_text001    
      wdetail.n_text002    
      wdetail.n_text003    
      wdetail.n_text004    
      wdetail.n_text005    
      wdetail.n_text006    
      wdetail.n_text007    
      wdetail.n_text008
      wdetail.n_text012
      wdetail.n_text011
      wdetail.n_text013    
      wdetail.typepol      
      wdetail.n_text014    
      wdetail.n_text015    
      wdetail.n_text016    
      wdetail.n_text017    
      wdetail.n_text018    
      wdetail.n_text019    
      wdetail.n_text020    
      wdetail.n_text021    
      wdetail.n_text022    
      wdetail.n_text023    
      wdetail.n_text024    
      wdetail.n_text027    
      wdetail.n_text123    
      wdetail.n_text025    
      wdetail.n_text026    
      wdetail.n_text028    
      wdetail.n_text029    
      wdetail.n_text030    
      wdetail.typecar      
      wdetail.n_text031    
      wdetail.n_text032    
      wdetail.n_text033    
      wdetail.n_text034    
      wdetail.n_text035    
      wdetail.maksi        
      wdetail.n_text036    
      wdetail.n_text038    
      wdetail.n_text039    
      wdetail.n_text040    
      wdetail.n_text041    
      wdetail.n_text042    
      wdetail.n_text043    
      wdetail.n_text044    
      wdetail.n_text046    
      wdetail.n_text047    
      wdetail.n_text048    
      wdetail.n_text049    
      wdetail.n_text050    
      wdetail.n_text051    
      wdetail.n_text052    
      wdetail.n_text053    
      wdetail.n_text054    
      wdetail.n_text055    
      wdetail.n_text058    
      wdetail.n_text059    
      wdetail.n_text060    
      wdetail.n_text061    
      wdetail.n_text062    
      wdetail.n_text063    
      wdetail.n_text064    
      wdetail.n_text065    
      wdetail.drivexp1     
      wdetail.drivcon1     
      wdetail.dlevel1      
      wdetail.dgender1     
      ""                   
      wdetail.n_text066    
      wdetail.n_text067    
      wdetail.n_text068    
      wdetail.n_text069    
      wdetail.n_text070    
      wdetail.n_text071    
      wdetail.n_text072    
      wdetail.n_text073    
      wdetail.drivexp2     
      wdetail.drivcon2     
      wdetail.dlevel2      
      wdetail.dgender2     
      ""                   
      wdetail.ntitle3      
      wdetail.dname3       
      wdetail.dcname3      
      wdetail.dlname3      
      wdetail.doccup3      
      wdetail.dbirth3      
      wdetail.dicno3       
      wdetail.ddriveno3    
      wdetail.drivexp3     
      wdetail.drivcon3     
      wdetail.dlevel3      
      wdetail.dgender3     
      ""                   
      wdetail.ntitle4      
      wdetail.dname4       
      wdetail.dcname4      
      wdetail.dlname4      
      wdetail.doccup4      
      wdetail.dbirth4      
      wdetail.dicno4       
      wdetail.ddriveno4    
      wdetail.drivexp4     
      wdetail.drivcon4     
      wdetail.dlevel4      
      wdetail.dgender4     
      ""                   
      wdetail.ntitle5      
      wdetail.dname5       
      wdetail.dcname5      
      wdetail.dlname5      
      wdetail.doccup5      
      wdetail.dbirth5      
      wdetail.dicno5       
      wdetail.ddriveno5    
      wdetail.drivexp5     
      wdetail.drivcon5     
      wdetail.dlevel5      
      wdetail.dgender5     
      ""                   
      wdetail.n_text074    
      wdetail.n_text075    
      wdetail.n_text076    
      wdetail.n_text077    
      wdetail.n_text078    
      wdetail.n_text079    
      wdetail.n_text080    
      wdetail.n_text081    
      wdetail.n_text082    
      wdetail.n_text083    
      wdetail.n_text084    
      wdetail.n_text085    
      wdetail.n_text086    
      wdetail.n_text087    
      wdetail.n_text088    
      wdetail.n_text089    
      wdetail.n_text091    
      wdetail.n_text092    
      wdetail.n_text093    
      wdetail.n_text094    
      wdetail.n_text095    
      wdetail.n_text096    
      wdetail.n_text098    
      wdetail.n_text110    
      wdetail.n_text111    
      wdetail.n_text112    
      wdetail.n_text113   
      wdetail.n_text116   
      wdetail.n_text117   
      wdetail.n_text118   
      wdetail.n_text119   
      wdetail.n_text120    
      wdetail.n_text121    
      wdetail.n_text122    
      wdetail.chargflg     
      wdetail.chargprice   
      wdetail.chargno      
      wdetail.chargprm     
      wdetail.battflg      
      wdetail.battprice    
      wdetail.battno       
      wdetail.battprm      
      wdetail.battdate     
      wdetail.n_text124    
      wdetail.n_text125    
      wdetail.n_text115    
      wdetail.n_text126    
      wdetail.n_text127    
      wdetail.n_text128    
      wdetail.n_text129    
      wdetail.net_re1      
      wdetail.stam_re1     
      wdetail.vat_re1      
      wdetail.n_text130    
      wdetail.inscode_re2  
      wdetail.n_text131    
      wdetail.n_text132    
      wdetail.n_text133    
      wdetail.n_text134    
      wdetail.net_re2      
      wdetail.stam_re2     
      wdetail.vat_re2      
      wdetail.n_text135    
      wdetail.inscode_re3  
      wdetail.n_text136    
      wdetail.n_text137    
      wdetail.n_text138    
      wdetail.n_text139    
      wdetail.net_re3      
      wdetail.stam_re3     
      wdetail.vat_re3      
      wdetail.n_text140    
      wdetail.n_text141    
      wdetail.n_text142    
      wdetail.n_text045 
       ""
       ""
      wdetail.n_text143   
      wdetail.n_text144 .
   END.
OUTPUT   CLOSE.
MESSAGE "Complete "VIEW-AS ALERT-BOX. 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_reportfielCSV_HD c-wins 
PROCEDURE pd_reportfielCSV_HD :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: add by A68-0061      
------------------------------------------------------------------------------*/
EXPORT DELIMITER ","
    "�Ţ���㺤Ӣ�    "  
    "�ѹ���㺤Ӣ�    "  
    "�Ţ����Ѻ��   "  
    "�ѹ��������������ͧ"   
    "�ѹ�������ش   "  
    "���ʺ���ѷ��Сѹ���"   
    "�����������ҫ���ö"   
    "��������â��    "  
    "��������Сѹ    "  
    "����������������ͧ "   
    "��������ë���   "  
    "��������������  "  
    "���ѹ�֡    "  
    "�ӹ�˹��     "  
    "�����١���   "  
    "���͡�ҧ     "  
    "���ʡ��      "  
    "�������      "  
    "���          "  
    "�ǧ/�Ӻ�    "  
    "ࢵ/�����    "  
    "�ѧ��Ѵ      "  
    "������ɳ��� "  
    "�Ţ���ѵû�ЪҪ�/�Ţ���ԵԺؤ�� "
    "�ҢҺ���ѷ�ͧ�����һ�Сѹ (�١���)"
    "�Ҫվ          "
    "�ѹ�Դ        "
    "�Ţ���㺢Ѻ��� "
    "������ö       "
    "�����ö¹��    "
    "Ẻö¹��      "
    "�����Ţ��Ƕѧ  "
    "�����Ţ����ͧ "
    "�������ö     "
    "��蹻�         "
    "���ͻ�����ö   "
    "�Ҥ�ö         "
    "Ẻ��Ƕѧ      "
    "�ѡɳ�ö¹�� / ������ö¹�� / �����ö¹�� "
    "�ӹǹ����� "
    "����ҵá�к͡�ٺ (CC) / ������ẵ����� (KW) "
    "������ö     "
    "�Ţ����¹ö "
    "�ѧ��Ѵ��訴����¹          "
    "�շ�訴����¹ (���ͻ��Ѻö) "
    "ǧ�Թ�ع��Сѹ    "
    "���»�Сѹ����ط��"
    "�ҡ�               "
    "����               "
    "���»�Сѹ����ҡ�������� "
    "���»�Сѹ����ú.        "
    "�ѵ����ǹŴ����ѵԴ� / �дѺ�ĵԡ�����âѺ���"
    "��ǹŴ����ѵԴ�    "
    "�����Ţʵ������  "
    "�Ţ������������  "
    "���Ѻ����� 1 - �ӹ�˹�� "
    "���Ѻ����� 1 - ����     "
    "���Ѻ����� 1 - ���͡�ҧ "
    "���Ѻ����� 1 - ���ʡ��  "
    "���Ѻ����� 1 - �Ҫվ    "
    "���Ѻ����� 1 - �ѹ�Դ  "
    "���Ѻ����� 1 - �Ţ���ѵû�ЪҪ�      "
    "���Ѻ����� 1 - �Ţ���㺢Ѻ���         "
    "���Ѻ����� 1 - �ѹ�������㺢Ѻ���     "
    "�����Թ�������Ǩ�ͺ�ĵԡ����Ѻ���1     "
    "���Ѻ����� 1 - �дѺ�ĵԡ�����âѺ��� "
    "���Ѻ����� 1 - ��                    "
    "���Ѻ����� 1 - ��������ѹ��Ѻ�����һ�Сѹ"
    "���Ѻ����� 2 - �ӹ�˹�� "
    "���Ѻ����� 2 - ����     "
    "���Ѻ����� 2 - ���͡�ҧ "
    "���Ѻ����� 2 - ���ʡ��  "
    "���Ѻ����� 2 - �Ҫվ    "
    "���Ѻ����� 2 - �ѹ�Դ  "
    "���Ѻ����� 2 - �Ţ���ѵû�ЪҪ� "
    "���Ѻ����� 2 - �Ţ���㺢Ѻ���    "
    "���Ѻ����� 2 - �ѹ�������㺢Ѻ���"
    "�����Թ�������Ǩ�ͺ�ĵԡ����Ѻ���1"
    "���Ѻ����� 2 - �дѺ�ĵԡ�����âѺ���"
    "���Ѻ����� 2 - ��                   "
    "���Ѻ����� 2 - ��������ѹ��Ѻ�����һ�Сѹ"
    "���Ѻ����� 3 - �ӹ�˹��  "
    "���Ѻ����� 3 - ����      "
    "���Ѻ����� 3 - ���͡�ҧ  "
    "���Ѻ����� 3 - ���ʡ��   "
    "���Ѻ����� 3 - �Ҫվ     "
    "���Ѻ����� 3 - �ѹ�Դ   "
    "���Ѻ����� 3 - �Ţ���ѵû�ЪҪ� "
    "���Ѻ����� 3 - �Ţ���㺢Ѻ���    "
    "���Ѻ����� 3 - �ѹ�������㺢Ѻ���"
    "�����Թ�������Ǩ�ͺ�ĵԡ����Ѻ���3"
    "���Ѻ����� 3 - �дѺ�ĵԡ�����âѺ���"
    "���Ѻ����� 3 - ��                   "
    "���Ѻ����� 3 - ��������ѹ��Ѻ�����һ�Сѹ"
    "���Ѻ����� 4 - �ӹ�˹�� "
    "���Ѻ����� 4 - ����     "
    "���Ѻ����� 4 - ���͡�ҧ "
    "���Ѻ����� 4 - ���ʡ��  "
    "���Ѻ����� 4 - �Ҫվ    "
    "���Ѻ����� 4 - �ѹ�Դ  "
    "���Ѻ����� 4 - �Ţ���ѵû�ЪҪ� "
    "���Ѻ����� 4 - �Ţ���㺢Ѻ���    "
    "���Ѻ����� 4 - �ѹ�������㺢Ѻ���"
    "�����Թ�������Ǩ�ͺ�ĵԡ����Ѻ���4"
    "���Ѻ����� 4 - �дѺ�ĵԡ�����âѺ���"
    "���Ѻ����� 4 - ��                   "
    "���Ѻ����� 4 - ��������ѹ��Ѻ�����һ�Сѹ"
    "���Ѻ����� 5 - �ӹ�˹�� "
    "���Ѻ����� 5 - ����     "
    "���Ѻ����� 5 - ���͡�ҧ "
    "���Ѻ����� 5 - ���ʡ��  "
    "���Ѻ����� 5 - �Ҫվ    "
    "���Ѻ����� 5 - �ѹ�Դ  "
    "���Ѻ����� 5 - �Ţ���ѵû�ЪҪ� "
    "���Ѻ����� 5 - �Ţ���㺢Ѻ���    "
    "���Ѻ����� 5 - �ѹ�������㺢Ѻ���"
    "�����Թ�������Ǩ�ͺ�ĵԡ����Ѻ���5"
    "���Ѻ����� 5 - �дѺ�ĵԡ�����âѺ���"
    "���Ѻ����� 5 - ��                   "
    "���Ѻ����� 5 - ��������ѹ��Ѻ�����һ�Сѹ"
    "����Ѻ�Ż���ª��                "
    "����������µ�ͪ��Ե (�ҷ/��)    "
    "����������µ�ͪ��Ե (�ҷ/����) "
    "����������µ�ͷ�Ѿ���Թ         "
    "�������������ǹ�á�ؤ��         "
    "����������µ��ö¹��            "
    "�������������ǹ�áö¹��        "
    "ö¹���٭���/�����             "
    "�غѵ��˵���ǹ�ؤ�����ª��Ե���Ѻ���"
    "�ӹǹ��������"
    "�غѵ��˵���ǹ�ؤ�����ª��Ե��������"
    "�غѵ��˵���ǹ�ؤ�ŷؾ���Ҿ���Ǥ��� ���Ѻ���    "
    "�غѵ��˵���ǹ�ؤ�ŷؾ���Ҿ���Ǥ��� ��.�������� "
    "�غѵ��˵���ǹ�ؤ�ŷؾ���Ҿ���Ǥ��Ǽ�������     "
    "����ѡ�Ҿ�Һ��          "
    "��û�Сѹ��Ǽ��Ѻ���   "
    "����������駻�Сѹ     "
    "���ʺ���ѷ����駻�Сѹ "
    "�ҢҺ���ѷ����駻�Сѹ "
    "���ͼ��Դ��� / Salesman"
    "����ѷ�������ö    "
    "�ҢҺ���ѷ�������ö"
    "����ö      "  
    "�ѹ���      "  
    "�ӹǹ�Թ   "  
    "������     "  
    "�Ţ���ѵù��˹��   "
    "��������´��໭    "
    "�Ѻ��Сѹ�������   "
    "��͹����/��͹      "
    "�ѵ��ôԵ��Ҥ��    "
    "����������駧ҹ    "
    "����Ҥ��ػ�ó������ "
    "��������´�ػ�ó������"
    "Wall Charger / ��ҫ��ͤ���������ͧ�������"
    "Wall Charger Price        "
    "Wall Charger Serialnumber "
    "Wall Charger �ѵ�Ҥ������"
    "Battery Replacement / ��ҫ��ͤ���������ͧ������� "
    "Battery Price         "
    "Battery Serialnumber  "
    "Battery �ѵ�Ҥ������ "
    "Battery Date          "
    "���������ͺ���      "
    "�Ҥ����ͺ���        "
    "㺡ӡѺ����1 - Code "
    "㺡ӡѺ����1 - ���ͺ���ѷ"
    "㺡ӡѺ����1 - �Ң�      "
    "㺡ӡѺ����1 - �������   "
    "㺡ӡѺ����1 - �Ţ�������������"
    "㺡ӡѺ����1 - �����ط��  "   
    "㺡ӡѺ����1 - �ҡ�        "   
    "㺡ӡѺ����1 - ����        "   
    "㺡ӡѺ����1 - ��������ҡ��������"
    "㺡ӡѺ����2 - Code        "   
    "㺡ӡѺ����2 - ���ͺ���ѷ  "   
    "㺡ӡѺ����2 - �Ң�        "   
    "㺡ӡѺ����2 - �������     "   
    "㺡ӡѺ����2 - �Ţ�������������  "
    "㺡ӡѺ����2 - �����ط��  "   
    "㺡ӡѺ����2 - �ҡ�        "   
    "㺡ӡѺ����2 - ����        "   
    "㺡ӡѺ����2 - ��������ҡ��������"
    "㺡ӡѺ����3 - Code        "   
    "㺡ӡѺ����3 - ���ͺ���ѷ  "   
    "㺡ӡѺ����3 - �Ң�        "   
    "㺡ӡѺ����3 - �������     "   
    "㺡ӡѺ����3 - �Ţ�������������  "
    "㺡ӡѺ����3 - �����ط��  "   
    "㺡ӡѺ����3 - �ҡ�        "   
    "㺡ӡѺ����3 - ����        "   
    "㺡ӡѺ����3 - ��������ҡ��������"
    "�Ţ�����໭ "
    "��������ê������¢ͧ Loyalty Campaign"
    "�����˵� " 
    "Rate ��.31" 
    "���� ��.31"
    "Producer  "                    
    "Agent     "  .
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_reportfielNew c-wins 
PROCEDURE pd_reportfielNew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

For each tlt Use-index  tlt06 Where
            tlt.trndat >=  fi_trndatfr    And
            tlt.trndat <=  fi_trndatto    AND 
            tlt.genusr   =  "HCT"         And
            tlt.rec_note2  = "N"       NO-LOCK 
    BREAK BY brstat.tlt.comp_noti_ins :

    IF      nv_typre = "V70" AND brstat.tlt.nor_usr_ins  = "0" THEN NEXT.
    ELSE IF nv_typre = "V72" AND brstat.tlt.nor_usr_ins <> "0" THEN NEXT.

    CREATE  wdetail.
     ASSIGN 
  wdetail.n_text001      =  brstat.tlt.comp_noti_ins  
  wdetail.n_text002      =  brstat.tlt.comp_noti_tlt  
  wdetail.n_text003      =  brstat.tlt.comp_pol       
  wdetail.n_text004      =  string(brstat.tlt.nor_effdat,"99/99/9999")     
  wdetail.n_text005      =  string(brstat.tlt.comp_effdat,"99/99/9999")    
  wdetail.n_text006      =  brstat.tlt.comp_sub       
  wdetail.n_text007      =  brstat.tlt.cifno          
  wdetail.n_text008      =  brstat.tlt.nationality    
  wdetail.n_text009      =  brstat.tlt.nor_noti_ins   
  wdetail.n_text010      =  brstat.tlt.nor_noti_tlt   
  wdetail.n_text011      =  brstat.tlt.nor_usr_ins    
  wdetail.n_text012      =  brstat.tlt.covcod         
  wdetail.n_text013      =  brstat.tlt.nor_usr_tlt    
  wdetail.n_text014      =  brstat.tlt.comp_usr_ins   
  wdetail.n_text015      =  brstat.tlt.ins_title      
  wdetail.n_text016      =  brstat.tlt.ins_name       
  wdetail.n_text017      =  brstat.tlt.ins_firstname  
  wdetail.n_text018      =  brstat.tlt.ins_lastname   
  wdetail.n_text019      =  brstat.tlt.ins_addr       
  wdetail.n_text020      =  brstat.tlt.ins_addr1      
  wdetail.n_text021      =  brstat.tlt.ins_addr2      
  wdetail.n_text022      =  brstat.tlt.ins_addr3      
  wdetail.n_text023      =  brstat.tlt.lince2         
  wdetail.n_text024      =  brstat.tlt.ins_addr5      
  wdetail.n_text025      =  brstat.tlt.dir_occ1       
  wdetail.n_text026      =  brstat.tlt.note28         
  wdetail.n_text027      =  brstat.tlt.dri_ic1        
  wdetail.n_text028      =  brstat.tlt.dri_lic1       
  wdetail.n_text029      =  brstat.tlt.brand          
  wdetail.n_text030      =  substr(brstat.tlt.note10,1,1)         
  wdetail.n_text031      =  substr(brstat.tlt.cha_no,1,25)      
  wdetail.n_text032      =  substr(brstat.tlt.eng_no,1,20)                   
  wdetail.n_text033      =  substr(brstat.tlt.model,1,40)                 
  wdetail.n_text034      =  substr(brstat.tlt.note11,1,4)                  
  wdetail.n_text035      =  substr(brstat.tlt.note12,1,20)                  
  wdetail.n_text036      =  substr(brstat.tlt.note13,1,40)                  
  wdetail.n_text037      =  substr(brstat.tlt.note14,1,1)                   
  /*wdetail.n_text038      =  substr(brstat.tlt.vehuse,1,2) */ /* A68-0061*/
  wdetail.n_text038      =  IF rs_typre = 1 THEN substr(brstat.tlt.vehuse,1,2) ELSE TRIM(brstat.tlt.vehuse)  /* A68-0061*/                   
  wdetail.n_text039      =  string(brstat.tlt.seqno,"99")                        
  wdetail.n_text040      =  string(brstat.tlt.cc_weight,"9999")                  
  wdetail.n_text041      =  substr(brstat.tlt.colorcod,1,40)        
  wdetail.n_text042      =  substr(brstat.tlt.lince1,1,10)        
  wdetail.n_text043      =  substr(brstat.tlt.ins_addr4,1,30)        
  wdetail.n_text044      =  substr(brstat.tlt.note15,1,4)         
  wdetail.n_text045      =  substr(brstat.tlt.note16,1,512)              
  wdetail.n_text046      =  substr(brstat.tlt.note17,1,14)        
  wdetail.n_text047      =  substr(brstat.tlt.note18,1,14)       
  wdetail.n_text048      =  substr(brstat.tlt.note19,1,14)          
  wdetail.n_text049      =  substr(brstat.tlt.note2,1,14)          
  wdetail.n_text050      =  substr(brstat.tlt.note20,1,14)       
  wdetail.n_text051      =  substr(brstat.tlt.note21,1,14)          
  wdetail.n_text052      =  substr(brstat.tlt.note22,1,14)        
  wdetail.n_text053      =  substr(brstat.tlt.note23,1,14)        
  wdetail.n_text054      =  substr(brstat.tlt.comp_sck,1,20)        
  wdetail.n_text055      =  substr(brstat.tlt.note24,1,32)        
  wdetail.n_text056      =  substr(brstat.tlt.dri_no1,1,1)        
  wdetail.n_text057      =  substr(brstat.tlt.dri_no2,1,1)         
  wdetail.n_text058      =  substr(brstat.tlt.note25,1,20)      
  wdetail.n_text059      =  substr(brstat.tlt.dri_name1,1,80)      
  wdetail.n_text060      =  substr(brstat.tlt.note26,1,20)      
  wdetail.n_text061      =  substr(brstat.tlt.note27,1,60)      
  wdetail.n_text062      =  substr(brstat.tlt.dri_occ2,1,50)   
  wdetail.n_text063      =  substr(brstat.tlt.note4,1,10)         
  wdetail.n_text064      =  substr(brstat.tlt.dri_ic2,1,15)         
  wdetail.n_text065      =  substr(brstat.tlt.dri_lic2,1,15)         
  wdetail.n_text066      =  substr(brstat.tlt.note29,1,20)         
  wdetail.n_text067      =  substr(brstat.tlt.dri_name2,1,80)         
  wdetail.n_text068      =  substr(brstat.tlt.note3,1,20)         
  wdetail.n_text069      =  substr(brstat.tlt.note30,1,60)         
  wdetail.n_text070      =  substr(brstat.tlt.ins_occ,1,50)         
  wdetail.n_text071      =  IF brstat.tlt.birthdate = ? THEN "" ELSE string(brstat.tlt.birthdate,"99/99/9999")              
  wdetail.n_text072      =  substr(brstat.tlt.ins_icno,1,15)           
  wdetail.n_text073      =  substr(brstat.tlt.note1,1,15)                   
  wdetail.n_text074      =  substr(brstat.tlt.ben83,1,80)                   
  wdetail.n_text075      =  string(brstat.tlt.comp_coamt,"99999999999.99")      
  wdetail.n_text076      =  string(brstat.tlt.comp_grprm,"99999999999.99")      
  wdetail.n_text077      =     string(brstat.tlt.mileage,"99999999999.99")         
  wdetail.n_text078      =      string(brstat.tlt.ndeci1,"99999999999.99")          
  wdetail.n_text079      =      string(brstat.tlt.ndeci2,"99999999999.99")          
  wdetail.n_text080      =      string(brstat.tlt.ndeci3,"99999999999.99")          
  wdetail.n_text081      =      string(brstat.tlt.ndeci4,"99999999999.99")          
  wdetail.n_text082      =      string(brstat.tlt.ndeci5,"99999999999.99")          
  wdetail.n_text083      =   string(brstat.tlt.nor_coamt,"99")                    
  wdetail.n_text084      =   string(brstat.tlt.nor_grprm,"99999999999.99")       
  wdetail.n_text085      =    string(brstat.tlt.prem_amt,"99999999999.99")        
  wdetail.n_text086     = string(brstat.tlt.prem_amttcop,"99")                 
  wdetail.n_text087      =        string(brstat.tlt.rstp,"99999999999.99")            
  wdetail.n_text088      =        string(brstat.tlt.rtax,"99999999999.99")            
  wdetail.n_text089     = string(brstat.tlt.tax_coporate,"99999999999.99")    
  wdetail.n_text090      =  substr(brstat.tlt.note5,1,6)            
  wdetail.n_text091      =  substr(brstat.tlt.note6,1,10)        
  wdetail.n_text092      =  substr(brstat.tlt.note7,1,10)        
  wdetail.n_text093      =  substr(brstat.tlt.note8,1,30)        
  wdetail.n_text094      =  substr(brstat.tlt.note9,1,80)        
  wdetail.n_text095      =  substr(brstat.tlt.noteveh1,1,10)        
  wdetail.n_text096      =  substr(brstat.tlt.noteveh2,1,30)        
  wdetail.n_text097      =  substr(brstat.tlt.old_cha,1,12)        
  wdetail.n_text098      =  substr(brstat.tlt.old_eng,1,3)             
  wdetail.n_text099      =  substr(brstat.tlt.pack,1,10)      
  wdetail.n_text100      =  substr(brstat.tlt.packnme,1,14)      
  wdetail.n_text101      =  substr(brstat.tlt.period,1,10)      
  wdetail.n_text102      =  substr(brstat.tlt.ln_note1,1,14) 
  wdetail.n_text103      =  substr(brstat.tlt.product,1,10)   
  wdetail.n_text104      =  substr(brstat.tlt.projnme,1,14)   
  wdetail.n_text105      =  substr(brstat.tlt.proveh,1,10)   
  wdetail.n_text106      =  substr(brstat.tlt.race,1,14)   
  wdetail.n_text107      =  substr(brstat.tlt.recac,1,10)   
  wdetail.n_text108      =  substr(brstat.tlt.rec_addr,1,14)   
  wdetail.n_text109      =  substr(brstat.tlt.rec_addr1,1,15)   
  wdetail.n_text110      =  substr(brstat.tlt.rec_addr2,1,10)   
  wdetail.n_text111      =  substr(brstat.tlt.rec_addr3,1,14)   
  wdetail.n_text112      =  substr(brstat.tlt.rec_addr4,1,10)   
  wdetail.n_text113      =  substr(brstat.tlt.rec_addr5,1,20)   
  wdetail.n_text114      =  substr(brstat.tlt.rec_brins,1,1)         
  wdetail.n_text115      =  substr(brstat.tlt.rec_cou,1,120)      
  wdetail.n_text116      =  substr(brstat.tlt.rec_icno,1,100)      
  wdetail.n_text117      =  substr(brstat.tlt.rec_name,1,2)         
  wdetail.n_text118      =  substr(brstat.tlt.rec_name2,1,2)         
  wdetail.n_text119      =  substr(brstat.tlt.rec_note1,1,10)        
  wdetail.n_text120      =  substr(brstat.tlt.rec_note2,1,1)        
  wdetail.n_text121      =  substr(brstat.tlt.rec_title,1,10)        
  wdetail.n_text122      =  substr(brstat.tlt.rec_typ,1,255)       
  wdetail.n_text123      =  substr(brstat.tlt.rider,1,5)         
  wdetail.n_text124      =  substr(brstat.tlt.safe1,1,20)        
  wdetail.n_text125      =  substr(brstat.tlt.safe2,1,10)        
  wdetail.n_text126      =  substr(brstat.tlt.safe3,1,150)       
  wdetail.n_text127      =  substr(brstat.tlt.sex,1,15)        
  wdetail.n_text128      =  substr(brstat.tlt.stat,1,250)       
  wdetail.n_text129      =  substr(brstat.tlt.subins,1,13)        
  wdetail.n_text130      =  substr(brstat.tlt.tel,1,10)        
  wdetail.n_text131      =  substr(brstat.tlt.tel2,1,150)      
  wdetail.n_text132      =  substr(brstat.tlt.tel3,1,15)       
  wdetail.n_text133      =  substr(brstat.tlt.usrid,1,250)       
  wdetail.n_text134      =  substr(brstat.tlt.usrsent,1,13)       
  wdetail.n_text135      =  substr(brstat.tlt.ln_product,1,10)     
  wdetail.n_text136      =  substr(brstat.tlt.ln_pronme,1,150)    
  wdetail.n_text137      =  substr(brstat.tlt.ln_rate,1,15)     
  wdetail.n_text138      =  substr(brstat.tlt.ln_st,1,250)    
  wdetail.n_text139      =  substr(brstat.tlt.lotno,1,13)    
  wdetail.n_text140      =  substr(brstat.tlt.maritalsts,1,10)    
  wdetail.n_text141      =  substr(brstat.tlt.campaign,1,12)    
  wdetail.n_text142      =  substr(brstat.tlt.mobile,1,10)   
  wdetail.n_text143      =  brstat.tlt.acno1   
  wdetail.n_text144      =  brstat.tlt.agent  . 
  /* ADD BY : A68-0061 */
    ASSIGN 
    wdetail.typepol    =   brstat.tlt.poltyp
    wdetail.typecar    =   brstat.tlt.car_type
    wdetail.maksi      =   STRING(brstat.tlt.maksi)
    wdetail.drivexp1   =   brstat.tlt.dri_licenexp1
    wdetail.drivcon1   =   string(brstat.tlt.dri_consen1)
    wdetail.dlevel1    =   string(brstat.tlt.dri_level1)
    wdetail.dgender1   =   brstat.tlt.dri_gender1
    wdetail.drivexp2   =   brstat.tlt.dri_licenexp2
    wdetail.drivcon2   =   string(brstat.tlt.dri_consen2)
    wdetail.dlevel2    =   string(brstat.tlt.dri_level2)
    wdetail.dgender2   =   brstat.tlt.dri_gender2
    wdetail.ntitle3    =   brstat.tlt.dri_title3
    wdetail.dname3     =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,1,INDEX(brstat.tlt.dri_fname3," ") - 1) ELSE TRIM(brstat.tlt.dri_fname3)
    wdetail.dcname3    =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,R-INDEX(brstat.tlt.dri_fname3," ")) ELSE "" 
    wdetail.dlname3    =   brstat.tlt.dri_lname3
    wdetail.doccup3    =   brstat.tlt.dir_occ3
    wdetail.dbirth3    =   brstat.tlt.dri_birth3
    wdetail.dicno3     =   brstat.tlt.dri_ic3
    wdetail.ddriveno3  =   brstat.tlt.dri_lic3
    wdetail.drivexp3   =   brstat.tlt.dri_licenexp3
    wdetail.drivcon3   =   string(brstat.tlt.dri_consen3)
    wdetail.dlevel3    =   string(brstat.tlt.dri_level3)
    wdetail.dgender3   =   brstat.tlt.dri_gender3
    wdetail.ntitle4    =   brstat.tlt.dri_title4
    wdetail.dname4     =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,1,INDEX(brstat.tlt.dri_fname4," ") - 1) ELSE TRIM(brstat.tlt.dri_fname4)
    wdetail.dcname4    =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,R-INDEX(brstat.tlt.dri_fname4," ")) ELSE ""
    wdetail.dlname4    =   brstat.tlt.dri_lname4
    wdetail.doccup4    =   brstat.tlt.dri_occ4
    wdetail.dbirth4    =   brstat.tlt.dri_birth4
    wdetail.dicno4     =   brstat.tlt.dri_ic4
    wdetail.ddriveno4  =   brstat.tlt.dri_lic4
    wdetail.drivexp4   =   brstat.tlt.dri_licenexp4
    wdetail.drivcon4   =   string(brstat.tlt.dri_consen4)
    wdetail.dlevel4    =   string(brstat.tlt.dri_level4)
    wdetail.dgender4   =   brstat.tlt.dri_gender4
    wdetail.ntitle5    =   brstat.tlt.dri_title5
    wdetail.dname5     =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,1,INDEX(brstat.tlt.dri_fname5," ") - 1) ELSE TRIM(brstat.tlt.dri_fname5)
    wdetail.dcname5    =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,R-INDEX(brstat.tlt.dri_fname5," ")) ELSE "" 
    wdetail.dlname5    =   brstat.tlt.dri_lname5
    wdetail.doccup5    =   brstat.tlt.dri_occ5
    wdetail.dbirth5    =   brstat.tlt.dri_birth5
    wdetail.dicno5     =   brstat.tlt.dri_ic5
    wdetail.ddriveno5  =   brstat.tlt.dri_lic5
    wdetail.drivexp5   =   brstat.tlt.dri_licenexp5
    wdetail.drivcon5   =   string(brstat.tlt.dri_consen5)
    wdetail.dlevel5    =   string(brstat.tlt.dri_level5)
    wdetail.dgender5   =   brstat.tlt.dri_gender5  
    wdetail.chargflg    =  STRING(brstat.tlt.chargflg)
    wdetail.chargprice  =  STRING(brstat.tlt.chargsi)
    wdetail.chargno     =  brstat.tlt.chargno
    wdetail.chargprm    =  string(brstat.tlt.chargprem)
    wdetail.battflg     =  string(brstat.tlt.battflg  )
    wdetail.battprice   =  string(brstat.tlt.battprice)
    wdetail.battno      =  brstat.tlt.battno
    wdetail.battprm     =  string(brstat.tlt.battprem)
    wdetail.battdate    =  string(brstat.tlt.ndate1,"99/99/9999")
    wdetail.net_re1     =  string(brstat.tlt.dg_prem)
    wdetail.stam_re1    =  string(brstat.tlt.dg_rstp_t)
    wdetail.vat_re1     =  string(brstat.tlt.dg_rtax_t)
    wdetail.inscode_re2 =  brstat.tlt.ins_code
    wdetail.net_re2     =  string(brstat.tlt.dg_si  )
    wdetail.stam_re2    =  string(brstat.tlt.dg_rate)
    wdetail.vat_re2     =  string(brstat.tlt.dg_feet)
    wdetail.inscode_re3 =  brstat.tlt.Paycode
    wdetail.net_re3     =  string(brstat.tlt.dg_ncb  )
    wdetail.stam_re3    =  string(brstat.tlt.dg_disc )
    wdetail.vat_re3     =  string(brstat.tlt.dg_wdisc) .
 /* END : A68-0061 */
END. 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_reportfielNew1 c-wins 
PROCEDURE pd_reportfielNew1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wproducer NO-LOCK.
    For each tlt Use-index  tlt06 Where
        tlt.trndat >=  fi_trndatfr    And
        tlt.trndat <=  fi_trndatto    AND 
        /*tlt.acno1   =  trim(fi_producer)  AND*/
        tlt.acno1      =  wproducer.producer  AND 
        tlt.genusr     =  "HCT"         And
        tlt.rec_note2  = "N"       NO-LOCK 
        BREAK BY brstat.tlt.comp_noti_ins :
        IF      nv_typre = "V70" AND brstat.tlt.nor_usr_ins  = "0" THEN NEXT.
        ELSE IF nv_typre = "V72" AND brstat.tlt.nor_usr_ins <> "0" THEN NEXT.
        CREATE  wdetail.
        ASSIGN 
        wdetail.n_text001      =  brstat.tlt.comp_noti_ins  
        wdetail.n_text002      =  brstat.tlt.comp_noti_tlt  
        wdetail.n_text003      =  brstat.tlt.comp_pol       
        wdetail.n_text004      =  string(brstat.tlt.nor_effdat,"99/99/9999")     
        wdetail.n_text005      =  string(brstat.tlt.comp_effdat,"99/99/9999")    
        wdetail.n_text006      =  brstat.tlt.comp_sub       
        wdetail.n_text007      =  brstat.tlt.cifno          
        wdetail.n_text008      =  brstat.tlt.nationality    
        wdetail.n_text009      =  brstat.tlt.nor_noti_ins   
        wdetail.n_text010      =  brstat.tlt.nor_noti_tlt   
        wdetail.n_text011      =  brstat.tlt.nor_usr_ins    
        wdetail.n_text012      =  brstat.tlt.covcod         
        wdetail.n_text013      =  brstat.tlt.nor_usr_tlt    
        wdetail.n_text014      =  brstat.tlt.comp_usr_ins   
        wdetail.n_text015      =  brstat.tlt.ins_title      
        wdetail.n_text016      =  brstat.tlt.ins_name       
        wdetail.n_text017      =  brstat.tlt.ins_firstname  
        wdetail.n_text018      =  brstat.tlt.ins_lastname   
        wdetail.n_text019      =  brstat.tlt.ins_addr       
        wdetail.n_text020      =  brstat.tlt.ins_addr1      
        wdetail.n_text021      =  brstat.tlt.ins_addr2      
        wdetail.n_text022      =  brstat.tlt.ins_addr3      
        wdetail.n_text023      =  brstat.tlt.lince2         
        wdetail.n_text024      =  brstat.tlt.ins_addr5      
        wdetail.n_text025      =  brstat.tlt.dir_occ1       
        wdetail.n_text026      =  brstat.tlt.note28         
        wdetail.n_text027      =  brstat.tlt.dri_ic1        
        wdetail.n_text028      =  brstat.tlt.dri_lic1       
        wdetail.n_text029      =  brstat.tlt.brand          
        wdetail.n_text030      =  substr(brstat.tlt.note10,1,1)         
        wdetail.n_text031      =  substr(brstat.tlt.cha_no,1,25)      
        wdetail.n_text032      =  substr(brstat.tlt.eng_no,1,20)                   
        wdetail.n_text033      =  substr(brstat.tlt.model,1,40)                 
        wdetail.n_text034      =  substr(brstat.tlt.note11,1,4)                  
        wdetail.n_text035      =  substr(brstat.tlt.note12,1,20)                  
        wdetail.n_text036      =  substr(brstat.tlt.note13,1,40)                  
        wdetail.n_text037      =  substr(brstat.tlt.note14,1,1)                   
        /*wdetail.n_text038      =  substr(brstat.tlt.vehuse,1,2) */ /* A68-0061*/
        wdetail.n_text038      =  IF rs_typre = 1 THEN substr(brstat.tlt.vehuse,1,2) ELSE TRIM(brstat.tlt.vehuse)  /* A68-0061*/                   
        wdetail.n_text039      =  string(brstat.tlt.seqno,"99")                        
        wdetail.n_text040      =  string(brstat.tlt.cc_weight,"9999")                  
        wdetail.n_text041      =  substr(brstat.tlt.colorcod,1,40)        
        wdetail.n_text042      =  substr(brstat.tlt.lince1,1,10)        
        wdetail.n_text043      =  substr(brstat.tlt.ins_addr4,1,30)        
        wdetail.n_text044      =  substr(brstat.tlt.note15,1,4)         
        wdetail.n_text045      =  substr(brstat.tlt.note16,1,512)              
        wdetail.n_text046      =  substr(brstat.tlt.note17,1,14)        
        wdetail.n_text047      =  substr(brstat.tlt.note18,1,14)       
        wdetail.n_text048      =  substr(brstat.tlt.note19,1,14)          
        wdetail.n_text049      =  substr(brstat.tlt.note2,1,14)          
        wdetail.n_text050      =  substr(brstat.tlt.note20,1,14)       
        wdetail.n_text051      =  substr(brstat.tlt.note21,1,14)          
        wdetail.n_text052      =  substr(brstat.tlt.note22,1,14)        
        wdetail.n_text053      =  substr(brstat.tlt.note23,1,14)        
        wdetail.n_text054      =  substr(brstat.tlt.comp_sck,1,20)        
        wdetail.n_text055      =  substr(brstat.tlt.note24,1,32)        
        wdetail.n_text056      =  substr(brstat.tlt.dri_no1,1,1)        
        wdetail.n_text057      =  substr(brstat.tlt.dri_no2,1,1)         
        wdetail.n_text058      =  substr(brstat.tlt.note25,1,20)      
        wdetail.n_text059      =  substr(brstat.tlt.dri_name1,1,80)      
        wdetail.n_text060      =  substr(brstat.tlt.note26,1,20)      
        wdetail.n_text061      =  substr(brstat.tlt.note27,1,60)      
        wdetail.n_text062      =  substr(brstat.tlt.dri_occ2,1,50)   
        wdetail.n_text063      =  substr(brstat.tlt.note4,1,10)         
        wdetail.n_text064      =  substr(brstat.tlt.dri_ic2,1,15)         
        wdetail.n_text065      =  substr(brstat.tlt.dri_lic2,1,15)         
        wdetail.n_text066      =  substr(brstat.tlt.note29,1,20)         
        wdetail.n_text067      =  substr(brstat.tlt.dri_name2,1,80)         
        wdetail.n_text068      =  substr(brstat.tlt.note3,1,20)         
        wdetail.n_text069      =  substr(brstat.tlt.note30,1,60)         
        wdetail.n_text070      =  substr(brstat.tlt.ins_occ,1,50)         
        wdetail.n_text071      =  IF brstat.tlt.birthdate = ? THEN "" ELSE string(brstat.tlt.birthdate,"99/99/9999")              
        wdetail.n_text072      =  substr(brstat.tlt.ins_icno,1,15)           
        wdetail.n_text073      =  substr(brstat.tlt.note1,1,15)                   
        wdetail.n_text074      =  substr(brstat.tlt.ben83,1,80)                   
        wdetail.n_text075      =  string(brstat.tlt.comp_coamt,"99999999999.99")      
        wdetail.n_text076      =  string(brstat.tlt.comp_grprm,"99999999999.99")      
        wdetail.n_text077      =  string(brstat.tlt.mileage,"99999999999.99")         
        wdetail.n_text078      =  string(brstat.tlt.ndeci1,"99999999999.99")          
        wdetail.n_text079      =  string(brstat.tlt.ndeci2,"99999999999.99")          
        wdetail.n_text080      =  string(brstat.tlt.ndeci3,"99999999999.99")          
        wdetail.n_text081      =  string(brstat.tlt.ndeci4,"99999999999.99")          
        wdetail.n_text082      =  string(brstat.tlt.ndeci5,"99999999999.99")          
        wdetail.n_text083      =  string(brstat.tlt.nor_coamt,"99")                    
        wdetail.n_text084      =  string(brstat.tlt.nor_grprm,"99999999999.99")       
        wdetail.n_text085      =  string(brstat.tlt.prem_amt,"99999999999.99")        
        wdetail.n_text086      =  string(brstat.tlt.prem_amttcop,"99")                 
        wdetail.n_text087      =  string(brstat.tlt.rstp,"99999999999.99")            
        wdetail.n_text088      =  string(brstat.tlt.rtax,"99999999999.99")            
        wdetail.n_text089      =  string(brstat.tlt.tax_coporate,"99999999999.99")    
        wdetail.n_text090      =  substr(brstat.tlt.note5,1,6)            
        wdetail.n_text091      =  substr(brstat.tlt.note6,1,10)        
        wdetail.n_text092      =  substr(brstat.tlt.note7,1,10)        
        wdetail.n_text093      =  substr(brstat.tlt.note8,1,30)        
        wdetail.n_text094      =  substr(brstat.tlt.note9,1,80)        
        wdetail.n_text095      =  substr(brstat.tlt.noteveh1,1,10)        
        wdetail.n_text096      =  substr(brstat.tlt.noteveh2,1,30)        
        wdetail.n_text097      =  substr(brstat.tlt.old_cha,1,12)        
        wdetail.n_text098      =  substr(brstat.tlt.old_eng,1,3)             
        wdetail.n_text099      =  substr(brstat.tlt.pack,1,10)      
        wdetail.n_text100      =  substr(brstat.tlt.packnme,1,14)      
        wdetail.n_text101      =  substr(brstat.tlt.period,1,10)      
        wdetail.n_text102      =  substr(brstat.tlt.ln_note1,1,14) 
        wdetail.n_text103      =  substr(brstat.tlt.product,1,10)   
        wdetail.n_text104      =  substr(brstat.tlt.projnme,1,14)   
        wdetail.n_text105      =  substr(brstat.tlt.proveh,1,10)   
        wdetail.n_text106      =  substr(brstat.tlt.race,1,14)   
        wdetail.n_text107      =  substr(brstat.tlt.recac,1,10)   
        wdetail.n_text108      =  substr(brstat.tlt.rec_addr,1,14)   
        wdetail.n_text109      =  substr(brstat.tlt.rec_addr1,1,15)   
        wdetail.n_text110      =  substr(brstat.tlt.rec_addr2,1,10)   
        wdetail.n_text111      =  substr(brstat.tlt.rec_addr3,1,14)   
        wdetail.n_text112      =  substr(brstat.tlt.rec_addr4,1,10)   
        wdetail.n_text113      =  substr(brstat.tlt.rec_addr5,1,20)   
        wdetail.n_text114      =  substr(brstat.tlt.rec_brins,1,1)         
        wdetail.n_text115      =  substr(brstat.tlt.rec_cou,1,120)      
        wdetail.n_text116      =  substr(brstat.tlt.rec_icno,1,100)      
        wdetail.n_text117      =  substr(brstat.tlt.rec_name,1,2)         
        wdetail.n_text118      =  substr(brstat.tlt.rec_name2,1,2)         
        wdetail.n_text119      =  substr(brstat.tlt.rec_note1,1,10)        
        wdetail.n_text120      =  substr(brstat.tlt.rec_note2,1,1)        
        wdetail.n_text121      =  substr(brstat.tlt.rec_title,1,10)        
        wdetail.n_text122      =  substr(brstat.tlt.rec_typ,1,255)       
        wdetail.n_text123      =  substr(brstat.tlt.rider,1,5)         
        wdetail.n_text124      =  substr(brstat.tlt.safe1,1,20)        
        wdetail.n_text125      =  substr(brstat.tlt.safe2,1,10)        
        wdetail.n_text126      =  substr(brstat.tlt.safe3,1,150)       
        wdetail.n_text127      =  substr(brstat.tlt.sex,1,15)        
        wdetail.n_text128      =  substr(brstat.tlt.stat,1,250)       
        wdetail.n_text129      =  substr(brstat.tlt.subins,1,13)        
        wdetail.n_text130      =  substr(brstat.tlt.tel,1,10)        
        wdetail.n_text131      =  substr(brstat.tlt.tel2,1,150)      
        wdetail.n_text132      =  substr(brstat.tlt.tel3,1,15)       
        wdetail.n_text133      =  substr(brstat.tlt.usrid,1,250)       
        wdetail.n_text134      =  substr(brstat.tlt.usrsent,1,13)       
        wdetail.n_text135      =  substr(brstat.tlt.ln_product,1,10)     
        wdetail.n_text136      =  substr(brstat.tlt.ln_pronme,1,150)    
        wdetail.n_text137      =  substr(brstat.tlt.ln_rate,1,15)     
        wdetail.n_text138      =  substr(brstat.tlt.ln_st,1,250)    
        wdetail.n_text139      =  substr(brstat.tlt.lotno,1,13)    
        wdetail.n_text140      =  substr(brstat.tlt.maritalsts,1,10)    
        wdetail.n_text141      =  substr(brstat.tlt.campaign,1,12)    
        wdetail.n_text142      =  substr(brstat.tlt.mobile,1,10)    
        wdetail.n_text143      =  brstat.tlt.acno1   
        wdetail.n_text144      =  brstat.tlt.agent  .
        /* ADD BY : A68-0061 */
    ASSIGN 
    wdetail.typepol    =   brstat.tlt.poltyp
    wdetail.typecar    =   brstat.tlt.car_type
    wdetail.maksi      =   STRING(brstat.tlt.maksi)
    wdetail.drivexp1   =   brstat.tlt.dri_licenexp1
    wdetail.drivcon1   =   string(brstat.tlt.dri_consen1)
    wdetail.dlevel1    =   string(brstat.tlt.dri_level1)
    wdetail.dgender1   =   brstat.tlt.dri_gender1
    wdetail.drivexp2   =   brstat.tlt.dri_licenexp2
    wdetail.drivcon2   =   string(brstat.tlt.dri_consen2)
    wdetail.dlevel2    =   string(brstat.tlt.dri_level2)
    wdetail.dgender2   =   brstat.tlt.dri_gender2
    wdetail.ntitle3    =   brstat.tlt.dri_title3
    wdetail.dname3     =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,1,INDEX(brstat.tlt.dri_fname3," ") - 1) ELSE TRIM(brstat.tlt.dri_fname3)
    wdetail.dcname3    =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,R-INDEX(brstat.tlt.dri_fname3," ")) ELSE "" 
    wdetail.dlname3    =   brstat.tlt.dri_lname3
    wdetail.doccup3    =   brstat.tlt.dir_occ3
    wdetail.dbirth3    =   brstat.tlt.dri_birth3
    wdetail.dicno3     =   brstat.tlt.dri_ic3
    wdetail.ddriveno3  =   brstat.tlt.dri_lic3
    wdetail.drivexp3   =   brstat.tlt.dri_licenexp3
    wdetail.drivcon3   =   string(brstat.tlt.dri_consen3)
    wdetail.dlevel3    =   string(brstat.tlt.dri_level3)
    wdetail.dgender3   =   brstat.tlt.dri_gender3
    wdetail.ntitle4    =   brstat.tlt.dri_title4
    wdetail.dname4     =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,1,INDEX(brstat.tlt.dri_fname4," ") - 1) ELSE TRIM(brstat.tlt.dri_fname4)
    wdetail.dcname4    =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,R-INDEX(brstat.tlt.dri_fname4," ")) ELSE ""
    wdetail.dlname4    =   brstat.tlt.dri_lname4
    wdetail.doccup4    =   brstat.tlt.dri_occ4
    wdetail.dbirth4    =   brstat.tlt.dri_birth4
    wdetail.dicno4     =   brstat.tlt.dri_ic4
    wdetail.ddriveno4  =   brstat.tlt.dri_lic4
    wdetail.drivexp4   =   brstat.tlt.dri_licenexp4
    wdetail.drivcon4   =   string(brstat.tlt.dri_consen4)
    wdetail.dlevel4    =   string(brstat.tlt.dri_level4)
    wdetail.dgender4   =   brstat.tlt.dri_gender4
    wdetail.ntitle5    =   brstat.tlt.dri_title5
    wdetail.dname5     =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,1,INDEX(brstat.tlt.dri_fname5," ") - 1) ELSE TRIM(brstat.tlt.dri_fname5)
    wdetail.dcname5    =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,R-INDEX(brstat.tlt.dri_fname5," ")) ELSE "" 
    wdetail.dlname5    =   brstat.tlt.dri_lname5
    wdetail.doccup5    =   brstat.tlt.dri_occ5
    wdetail.dbirth5    =   brstat.tlt.dri_birth5
    wdetail.dicno5     =   brstat.tlt.dri_ic5
    wdetail.ddriveno5  =   brstat.tlt.dri_lic5
    wdetail.drivexp5   =   brstat.tlt.dri_licenexp5
    wdetail.drivcon5   =   string(brstat.tlt.dri_consen5)
    wdetail.dlevel5    =   string(brstat.tlt.dri_level5)
    wdetail.dgender5   =   brstat.tlt.dri_gender5  
    wdetail.chargflg    =  STRING(brstat.tlt.chargflg)
    wdetail.chargprice  =  STRING(brstat.tlt.chargsi)
    wdetail.chargno     =  brstat.tlt.chargno
    wdetail.chargprm    =  string(brstat.tlt.chargprem)
    wdetail.battflg     =  string(brstat.tlt.battflg  )
    wdetail.battprice   =  string(brstat.tlt.battprice)
    wdetail.battno      =  brstat.tlt.battno
    wdetail.battprm     =  string(brstat.tlt.battprem)
    wdetail.battdate    =  string(brstat.tlt.ndate1,"99/99/9999")
    wdetail.net_re1     =  string(brstat.tlt.dg_prem)
    wdetail.stam_re1    =  string(brstat.tlt.dg_rstp_t)
    wdetail.vat_re1     =  string(brstat.tlt.dg_rtax_t)
    wdetail.inscode_re2 =  brstat.tlt.ins_code
    wdetail.net_re2     =  string(brstat.tlt.dg_si  )
    wdetail.stam_re2    =  string(brstat.tlt.dg_rate)
    wdetail.vat_re2     =  string(brstat.tlt.dg_feet)
    wdetail.inscode_re3 =  brstat.tlt.Paycode
    wdetail.net_re3     =  string(brstat.tlt.dg_ncb  )
    wdetail.stam_re3    =  string(brstat.tlt.dg_disc )
    wdetail.vat_re3     =  string(brstat.tlt.dg_wdisc) .
 /* END : A68-0061 */
    END.
END. 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_reportfielPro c-wins 
PROCEDURE pd_reportfielPro :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
IF fi_report = "" THEN DO:
    MESSAGE "���� Producer �繤����ҧ " VIEW-AS ALERT-BOX.
    
END.
ELSE DO:
    For each tlt Use-index  tlt06 Where
        tlt.trndat >=  fi_trndatfr     And
        tlt.trndat <=  fi_trndatto     AND 
        tlt.genusr  =  "HCT"           And
        tlt.acno1   =  trim(fi_report) NO-LOCK  
        BREAK BY brstat.tlt.comp_noti_ins :
        IF      nv_typre = "V70" AND brstat.tlt.nor_usr_ins  = "0" THEN NEXT.
        ELSE IF nv_typre = "V72" AND brstat.tlt.nor_usr_ins <> "0" THEN NEXT.
        CREATE  wdetail.
        ASSIGN 
            wdetail.n_text001      =  brstat.tlt.comp_noti_ins  
            wdetail.n_text002      =  brstat.tlt.comp_noti_tlt  
            wdetail.n_text003      =  brstat.tlt.comp_pol       
            wdetail.n_text004      =  string(brstat.tlt.nor_effdat,"99/99/9999")     
            wdetail.n_text005      =  string(brstat.tlt.comp_effdat,"99/99/9999")    
            wdetail.n_text006      =  brstat.tlt.comp_sub       
            wdetail.n_text007      =  brstat.tlt.cifno          
            wdetail.n_text008      =  brstat.tlt.nationality    
            wdetail.n_text009      =  brstat.tlt.nor_noti_ins   
            wdetail.n_text010      =  brstat.tlt.nor_noti_tlt   
            wdetail.n_text011      =  brstat.tlt.nor_usr_ins    
            wdetail.n_text012      =  brstat.tlt.covcod         
            wdetail.n_text013      =  brstat.tlt.nor_usr_tlt    
            wdetail.n_text014      =  brstat.tlt.comp_usr_ins   
            wdetail.n_text015      =  brstat.tlt.ins_title      
            wdetail.n_text016      =  brstat.tlt.ins_name       
            wdetail.n_text017      =  brstat.tlt.ins_firstname  
            wdetail.n_text018      =  brstat.tlt.ins_lastname   
            wdetail.n_text019      =  brstat.tlt.ins_addr       
            wdetail.n_text020      =  brstat.tlt.ins_addr1      
            wdetail.n_text021      =  brstat.tlt.ins_addr2      
            wdetail.n_text022      =  brstat.tlt.ins_addr3      
            wdetail.n_text023      =  brstat.tlt.lince2         
            wdetail.n_text024      =  brstat.tlt.ins_addr5      
            wdetail.n_text025      =  brstat.tlt.dir_occ1       
            wdetail.n_text026      =  brstat.tlt.note28         
            wdetail.n_text027      =  brstat.tlt.dri_ic1        
            wdetail.n_text028      =  brstat.tlt.dri_lic1       
            wdetail.n_text029      =  brstat.tlt.brand          
            wdetail.n_text030      =  substr(brstat.tlt.note10,1,1)         
            wdetail.n_text031      =  substr(brstat.tlt.cha_no,1,25)      
            wdetail.n_text032      =  substr(brstat.tlt.eng_no,1,20)                   
            wdetail.n_text033      =  substr(brstat.tlt.model,1,40)                 
            wdetail.n_text034      =  substr(brstat.tlt.note11,1,4)                  
            wdetail.n_text035      =  substr(brstat.tlt.note12,1,20)                  
            wdetail.n_text036      =  substr(brstat.tlt.note13,1,40)                  
            wdetail.n_text037      =  substr(brstat.tlt.note14,1,1)                   
            wdetail.n_text038      =  substr(brstat.tlt.vehuse,1,2)                   
            wdetail.n_text039      =  string(brstat.tlt.seqno,"99")                        
            wdetail.n_text040      =  string(brstat.tlt.cc_weight,"9999")                  
            wdetail.n_text041      =  substr(brstat.tlt.colorcod,1,40)        
            wdetail.n_text042      =  substr(brstat.tlt.lince1,1,10)        
            wdetail.n_text043      =  substr(brstat.tlt.ins_addr4,1,30)        
            wdetail.n_text044      =  substr(brstat.tlt.note15,1,4)         
            wdetail.n_text045      =  substr(brstat.tlt.note16,1,512)              
            wdetail.n_text046      =  substr(brstat.tlt.note17,1,14)        
            wdetail.n_text047      =  substr(brstat.tlt.note18,1,14)       
            wdetail.n_text048      =  substr(brstat.tlt.note19,1,14)          
            wdetail.n_text049      =  substr(brstat.tlt.note2,1,14)          
            wdetail.n_text050      =  substr(brstat.tlt.note20,1,14)       
            wdetail.n_text051      =  substr(brstat.tlt.note21,1,14)          
            wdetail.n_text052      =  substr(brstat.tlt.note22,1,14)        
            wdetail.n_text053      =  substr(brstat.tlt.note23,1,14)        
            wdetail.n_text054      =  substr(brstat.tlt.comp_sck,1,20)        
            wdetail.n_text055      =  substr(brstat.tlt.note24,1,32)        
            wdetail.n_text056      =  substr(brstat.tlt.dri_no1,1,1)        
            wdetail.n_text057      =  substr(brstat.tlt.dri_no2,1,1)         
            wdetail.n_text058      =  substr(brstat.tlt.note25,1,20)      
            wdetail.n_text059      =  substr(brstat.tlt.dri_name1,1,80)      
            wdetail.n_text060      =  substr(brstat.tlt.note26,1,20)      
            wdetail.n_text061      =  substr(brstat.tlt.note27,1,60)      
            wdetail.n_text062      =  substr(brstat.tlt.dri_occ2,1,50)   
            wdetail.n_text063      =  substr(brstat.tlt.note4,1,10)         
            wdetail.n_text064      =  substr(brstat.tlt.dri_ic2,1,15)         
            wdetail.n_text065      =  substr(brstat.tlt.dri_lic2,1,15)         
            wdetail.n_text066      =  substr(brstat.tlt.note29,1,20)         
            wdetail.n_text067      =  substr(brstat.tlt.dri_name2,1,80)         
            wdetail.n_text068      =  substr(brstat.tlt.note3,1,20)         
            wdetail.n_text069      =  substr(brstat.tlt.note30,1,60)         
            wdetail.n_text070      =  substr(brstat.tlt.ins_occ,1,50)         
            wdetail.n_text071      =  IF brstat.tlt.birthdate = ? THEN "" ELSE string(brstat.tlt.birthdate,"99/99/9999")              
            wdetail.n_text072      =  substr(brstat.tlt.ins_icno,1,15)           
            wdetail.n_text073      =  substr(brstat.tlt.note1,1,15)                   
            wdetail.n_text074      =  substr(brstat.tlt.ben83,1,80)                   
            wdetail.n_text075      =  string(brstat.tlt.comp_coamt,"99999999999.99")      
            wdetail.n_text076      =  string(brstat.tlt.comp_grprm,"99999999999.99")      
            wdetail.n_text077      =     string(brstat.tlt.mileage,"99999999999.99")         
            wdetail.n_text078      =      string(brstat.tlt.ndeci1,"99999999999.99")          
            wdetail.n_text079      =      string(brstat.tlt.ndeci2,"99999999999.99")          
            wdetail.n_text080      =      string(brstat.tlt.ndeci3,"99999999999.99")          
            wdetail.n_text081      =      string(brstat.tlt.ndeci4,"99999999999.99")          
            wdetail.n_text082      =      string(brstat.tlt.ndeci5,"99999999999.99")          
            wdetail.n_text083      =   string(brstat.tlt.nor_coamt,"99")                    
            wdetail.n_text084      =   string(brstat.tlt.nor_grprm,"99999999999.99")       
            wdetail.n_text085      =    string(brstat.tlt.prem_amt,"99999999999.99")        
            wdetail.n_text086     = string(brstat.tlt.prem_amttcop,"99")                 
            wdetail.n_text087      =        string(brstat.tlt.rstp,"99999999999.99")            
            wdetail.n_text088      =        string(brstat.tlt.rtax,"99999999999.99")            
            wdetail.n_text089     = string(brstat.tlt.tax_coporate,"99999999999.99")    
            wdetail.n_text090      =  substr(brstat.tlt.note5,1,6)            
            wdetail.n_text091      =  substr(brstat.tlt.note6,1,10)        
            wdetail.n_text092      =  substr(brstat.tlt.note7,1,10)        
            wdetail.n_text093      =  substr(brstat.tlt.note8,1,30)        
            wdetail.n_text094      =  substr(brstat.tlt.note9,1,80)        
            wdetail.n_text095      =  substr(brstat.tlt.noteveh1,1,10)        
            wdetail.n_text096      =  substr(brstat.tlt.noteveh2,1,30)        
            wdetail.n_text097      =  substr(brstat.tlt.old_cha,1,12)        
            wdetail.n_text098      =  substr(brstat.tlt.old_eng,1,3)             
            wdetail.n_text099      =  substr(brstat.tlt.pack,1,10)      
            wdetail.n_text100      =  substr(brstat.tlt.packnme,1,14)      
            wdetail.n_text101      =  substr(brstat.tlt.period,1,10)      
            wdetail.n_text102      =  substr(brstat.tlt.ln_note1,1,14) 
            wdetail.n_text103      =  substr(brstat.tlt.product,1,10)   
            wdetail.n_text104      =  substr(brstat.tlt.projnme,1,14)   
            wdetail.n_text105      =  substr(brstat.tlt.proveh,1,10)   
            wdetail.n_text106      =  substr(brstat.tlt.race,1,14)   
            wdetail.n_text107      =  substr(brstat.tlt.recac,1,10)   
            wdetail.n_text108      =  substr(brstat.tlt.rec_addr,1,14)   
            wdetail.n_text109      =  substr(brstat.tlt.rec_addr1,1,15)   
            wdetail.n_text110      =  substr(brstat.tlt.rec_addr2,1,10)   
            wdetail.n_text111      =  substr(brstat.tlt.rec_addr3,1,14)   
            wdetail.n_text112      =  substr(brstat.tlt.rec_addr4,1,10)   
            wdetail.n_text113      =  substr(brstat.tlt.rec_addr5,1,20)   
            wdetail.n_text114      =  substr(brstat.tlt.rec_brins,1,1)         
            wdetail.n_text115      =  substr(brstat.tlt.rec_cou,1,120)      
            wdetail.n_text116      =  substr(brstat.tlt.rec_icno,1,100)      
            wdetail.n_text117      =  substr(brstat.tlt.rec_name,1,2)         
            wdetail.n_text118      =  substr(brstat.tlt.rec_name2,1,2)         
            wdetail.n_text119      =  substr(brstat.tlt.rec_note1,1,10)        
            wdetail.n_text120      =  substr(brstat.tlt.rec_note2,1,1)        
            wdetail.n_text121      =  substr(brstat.tlt.rec_title,1,10)        
            wdetail.n_text122      =  substr(brstat.tlt.rec_typ,1,255)       
            wdetail.n_text123      =  substr(brstat.tlt.rider,1,5)         
            wdetail.n_text124      =  substr(brstat.tlt.safe1,1,20)        
            wdetail.n_text125      =  substr(brstat.tlt.safe2,1,10)        
            wdetail.n_text126      =  substr(brstat.tlt.safe3,1,150)       
            wdetail.n_text127      =  substr(brstat.tlt.sex,1,15)        
            wdetail.n_text128      =  substr(brstat.tlt.stat,1,250)       
            wdetail.n_text129      =  substr(brstat.tlt.subins,1,13)        
            wdetail.n_text130      =  substr(brstat.tlt.tel,1,10)        
            wdetail.n_text131      =  substr(brstat.tlt.tel2,1,150)      
            wdetail.n_text132      =  substr(brstat.tlt.tel3,1,15)       
            wdetail.n_text133      =  substr(brstat.tlt.usrid,1,250)       
            wdetail.n_text134      =  substr(brstat.tlt.usrsent,1,13)       
            wdetail.n_text135      =  substr(brstat.tlt.ln_product,1,10)     
            wdetail.n_text136      =  substr(brstat.tlt.ln_pronme,1,150)    
            wdetail.n_text137      =  substr(brstat.tlt.ln_rate,1,15)     
            wdetail.n_text138      =  substr(brstat.tlt.ln_st,1,250)    
            wdetail.n_text139      =  substr(brstat.tlt.lotno,1,13)    
            wdetail.n_text140      =  substr(brstat.tlt.maritalsts,1,10)    
            wdetail.n_text141      =  substr(brstat.tlt.campaign,1,12)    
            wdetail.n_text142      =  substr(brstat.tlt.mobile,1,10)  
            wdetail.n_text143      =  brstat.tlt.acno1   
            wdetail.n_text144      =  brstat.tlt.agent  . 
         
    END.
END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_reportfielPro1 c-wins 
PROCEDURE pd_reportfielPro1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 
    FOR EACH wproducer NO-LOCK.
        For each tlt Use-index  tlt06 Where
            tlt.trndat >=  fi_trndatfr     And
            tlt.trndat <=  fi_trndatto     AND 
            tlt.genusr  =  "HCT"           AND 
            /*tlt.acno1   =  trim(fi_report) NO-LOCK */
            tlt.acno1   =  wproducer.producer  NO-LOCK 
            BREAK BY brstat.tlt.comp_noti_ins :
            IF      nv_typre = "V70" AND brstat.tlt.nor_usr_ins  = "0" THEN NEXT.
            ELSE IF nv_typre = "V72" AND brstat.tlt.nor_usr_ins <> "0" THEN NEXT.
            CREATE  wdetail.
            ASSIGN 
            wdetail.n_text001      =  brstat.tlt.comp_noti_ins  
            wdetail.n_text002      =  brstat.tlt.comp_noti_tlt  
            wdetail.n_text003      =  brstat.tlt.comp_pol       
            wdetail.n_text004      =  string(brstat.tlt.nor_effdat,"99/99/9999")     
            wdetail.n_text005      =  string(brstat.tlt.comp_effdat,"99/99/9999")    
            wdetail.n_text006      =  brstat.tlt.comp_sub       
            wdetail.n_text007      =  brstat.tlt.cifno          
            wdetail.n_text008      =  brstat.tlt.nationality    
            wdetail.n_text009      =  brstat.tlt.nor_noti_ins   
            wdetail.n_text010      =  brstat.tlt.nor_noti_tlt   
            wdetail.n_text011      =  brstat.tlt.nor_usr_ins    
            wdetail.n_text012      =  brstat.tlt.covcod         
            wdetail.n_text013      =  brstat.tlt.nor_usr_tlt    
            wdetail.n_text014      =  brstat.tlt.comp_usr_ins   
            wdetail.n_text015      =  brstat.tlt.ins_title      
            wdetail.n_text016      =  brstat.tlt.ins_name       
            wdetail.n_text017      =  brstat.tlt.ins_firstname  
            wdetail.n_text018      =  brstat.tlt.ins_lastname   
            wdetail.n_text019      =  brstat.tlt.ins_addr       
            wdetail.n_text020      =  brstat.tlt.ins_addr1      
            wdetail.n_text021      =  brstat.tlt.ins_addr2      
            wdetail.n_text022      =  brstat.tlt.ins_addr3      
            wdetail.n_text023      =  brstat.tlt.lince2         
            wdetail.n_text024      =  brstat.tlt.ins_addr5      
            wdetail.n_text025      =  brstat.tlt.dir_occ1       
            wdetail.n_text026      =  brstat.tlt.note28         
            wdetail.n_text027      =  brstat.tlt.dri_ic1        
            wdetail.n_text028      =  brstat.tlt.dri_lic1       
            wdetail.n_text029      =  brstat.tlt.brand          
            wdetail.n_text030      =  substr(brstat.tlt.note10,1,1)         
            wdetail.n_text031      =  substr(brstat.tlt.cha_no,1,25)      
            wdetail.n_text032      =  substr(brstat.tlt.eng_no,1,20)                   
            wdetail.n_text033      =  substr(brstat.tlt.model,1,40)                 
            wdetail.n_text034      =  substr(brstat.tlt.note11,1,4)                  
            wdetail.n_text035      =  substr(brstat.tlt.note12,1,20)                  
            wdetail.n_text036      =  substr(brstat.tlt.note13,1,40)                  
            wdetail.n_text037      =  substr(brstat.tlt.note14,1,1)                   
            /*wdetail.n_text038      =  substr(brstat.tlt.vehuse,1,2) */ /* A68-0061*/
            wdetail.n_text038      =  IF rs_typre = 1 THEN substr(brstat.tlt.vehuse,1,2) ELSE TRIM(brstat.tlt.vehuse)  /* A68-0061*/                   
            wdetail.n_text039      =  string(brstat.tlt.seqno,"99")                        
            wdetail.n_text040      =  string(brstat.tlt.cc_weight,"9999")                  
            wdetail.n_text041      =  substr(brstat.tlt.colorcod,1,40)        
            wdetail.n_text042      =  substr(brstat.tlt.lince1,1,10)        
            wdetail.n_text043      =  substr(brstat.tlt.ins_addr4,1,30)        
            wdetail.n_text044      =  substr(brstat.tlt.note15,1,4)         
            wdetail.n_text045      =  substr(brstat.tlt.note16,1,512)              
            wdetail.n_text046      =  substr(brstat.tlt.note17,1,14)        
            wdetail.n_text047      =  substr(brstat.tlt.note18,1,14)       
            wdetail.n_text048      =  substr(brstat.tlt.note19,1,14)          
            wdetail.n_text049      =  substr(brstat.tlt.note2,1,14)          
            wdetail.n_text050      =  substr(brstat.tlt.note20,1,14)       
            wdetail.n_text051      =  substr(brstat.tlt.note21,1,14)          
            wdetail.n_text052      =  substr(brstat.tlt.note22,1,14)        
            wdetail.n_text053      =  substr(brstat.tlt.note23,1,14)        
            wdetail.n_text054      =  substr(brstat.tlt.comp_sck,1,20)        
            wdetail.n_text055      =  substr(brstat.tlt.note24,1,32)        
            wdetail.n_text056      =  substr(brstat.tlt.dri_no1,1,1)        
            wdetail.n_text057      =  substr(brstat.tlt.dri_no2,1,1)         
            wdetail.n_text058      =  substr(brstat.tlt.note25,1,20)      
            wdetail.n_text059      =  substr(brstat.tlt.dri_name1,1,80)      
            wdetail.n_text060      =  substr(brstat.tlt.note26,1,20)      
            wdetail.n_text061      =  substr(brstat.tlt.note27,1,60)      
            wdetail.n_text062      =  substr(brstat.tlt.dri_occ2,1,50)   
            wdetail.n_text063      =  substr(brstat.tlt.note4,1,10)         
            wdetail.n_text064      =  substr(brstat.tlt.dri_ic2,1,15)         
            wdetail.n_text065      =  substr(brstat.tlt.dri_lic2,1,15)         
            wdetail.n_text066      =  substr(brstat.tlt.note29,1,20)         
            wdetail.n_text067      =  substr(brstat.tlt.dri_name2,1,80)         
            wdetail.n_text068      =  substr(brstat.tlt.note3,1,20)         
            wdetail.n_text069      =  substr(brstat.tlt.note30,1,60)         
            wdetail.n_text070      =  substr(brstat.tlt.ins_occ,1,50)         
            wdetail.n_text071      =  IF brstat.tlt.birthdate = ? THEN "" ELSE string(brstat.tlt.birthdate,"99/99/9999")              
            wdetail.n_text072      =  substr(brstat.tlt.ins_icno,1,15)           
            wdetail.n_text073      =  substr(brstat.tlt.note1,1,15)                   
            wdetail.n_text074      =  substr(brstat.tlt.ben83,1,80)                   
            wdetail.n_text075      =  string(brstat.tlt.comp_coamt,"99999999999.99")      
            wdetail.n_text076      =  string(brstat.tlt.comp_grprm,"99999999999.99")      
            wdetail.n_text077      =     string(brstat.tlt.mileage,"99999999999.99")         
            wdetail.n_text078      =      string(brstat.tlt.ndeci1,"99999999999.99")          
            wdetail.n_text079      =      string(brstat.tlt.ndeci2,"99999999999.99")          
            wdetail.n_text080      =      string(brstat.tlt.ndeci3,"99999999999.99")          
            wdetail.n_text081      =      string(brstat.tlt.ndeci4,"99999999999.99")          
            wdetail.n_text082      =      string(brstat.tlt.ndeci5,"99999999999.99")          
            wdetail.n_text083      =   string(brstat.tlt.nor_coamt,"99")                    
            wdetail.n_text084      =   string(brstat.tlt.nor_grprm,"99999999999.99")       
            wdetail.n_text085      =    string(brstat.tlt.prem_amt,"99999999999.99")        
            wdetail.n_text086     = string(brstat.tlt.prem_amttcop,"99")                 
            wdetail.n_text087      =        string(brstat.tlt.rstp,"99999999999.99")            
            wdetail.n_text088      =        string(brstat.tlt.rtax,"99999999999.99")            
            wdetail.n_text089     = string(brstat.tlt.tax_coporate,"99999999999.99")    
            wdetail.n_text090      =  substr(brstat.tlt.note5,1,6)            
            wdetail.n_text091      =  substr(brstat.tlt.note6,1,10)        
            wdetail.n_text092      =  substr(brstat.tlt.note7,1,10)        
            wdetail.n_text093      =  substr(brstat.tlt.note8,1,30)        
            wdetail.n_text094      =  substr(brstat.tlt.note9,1,80)        
            wdetail.n_text095      =  substr(brstat.tlt.noteveh1,1,10)        
            wdetail.n_text096      =  substr(brstat.tlt.noteveh2,1,30)        
            wdetail.n_text097      =  substr(brstat.tlt.old_cha,1,12)        
            wdetail.n_text098      =  substr(brstat.tlt.old_eng,1,3)             
            wdetail.n_text099      =  substr(brstat.tlt.pack,1,10)      
            wdetail.n_text100      =  substr(brstat.tlt.packnme,1,14)      
            wdetail.n_text101      =  substr(brstat.tlt.period,1,10)      
            wdetail.n_text102      =  substr(brstat.tlt.ln_note1,1,14) 
            wdetail.n_text103      =  substr(brstat.tlt.product,1,10)   
            wdetail.n_text104      =  substr(brstat.tlt.projnme,1,14)   
            wdetail.n_text105      =  substr(brstat.tlt.proveh,1,10)   
            wdetail.n_text106      =  substr(brstat.tlt.race,1,14)   
            wdetail.n_text107      =  substr(brstat.tlt.recac,1,10)   
            wdetail.n_text108      =  substr(brstat.tlt.rec_addr,1,14)   
            wdetail.n_text109      =  substr(brstat.tlt.rec_addr1,1,15)   
            wdetail.n_text110      =  substr(brstat.tlt.rec_addr2,1,10)   
            wdetail.n_text111      =  substr(brstat.tlt.rec_addr3,1,14)   
            wdetail.n_text112      =  substr(brstat.tlt.rec_addr4,1,10)   
            wdetail.n_text113      =  substr(brstat.tlt.rec_addr5,1,20)   
            wdetail.n_text114      =  substr(brstat.tlt.rec_brins,1,1)         
            wdetail.n_text115      =  substr(brstat.tlt.rec_cou,1,120)      
            wdetail.n_text116      =  substr(brstat.tlt.rec_icno,1,100)      
            wdetail.n_text117      =  substr(brstat.tlt.rec_name,1,2)         
            wdetail.n_text118      =  substr(brstat.tlt.rec_name2,1,2)         
            wdetail.n_text119      =  substr(brstat.tlt.rec_note1,1,10)        
            wdetail.n_text120      =  substr(brstat.tlt.rec_note2,1,1)        
            wdetail.n_text121      =  substr(brstat.tlt.rec_title,1,10)        
            wdetail.n_text122      =  substr(brstat.tlt.rec_typ,1,255)       
            wdetail.n_text123      =  substr(brstat.tlt.rider,1,5)         
            wdetail.n_text124      =  substr(brstat.tlt.safe1,1,20)        
            wdetail.n_text125      =  substr(brstat.tlt.safe2,1,10)        
            wdetail.n_text126      =  substr(brstat.tlt.safe3,1,150)       
            wdetail.n_text127      =  substr(brstat.tlt.sex,1,15)        
            wdetail.n_text128      =  substr(brstat.tlt.stat,1,250)       
            wdetail.n_text129      =  substr(brstat.tlt.subins,1,13)        
            wdetail.n_text130      =  substr(brstat.tlt.tel,1,10)        
            wdetail.n_text131      =  substr(brstat.tlt.tel2,1,150)      
            wdetail.n_text132      =  substr(brstat.tlt.tel3,1,15)       
            wdetail.n_text133      =  substr(brstat.tlt.usrid,1,250)       
            wdetail.n_text134      =  substr(brstat.tlt.usrsent,1,13)       
            wdetail.n_text135      =  substr(brstat.tlt.ln_product,1,10)     
            wdetail.n_text136      =  substr(brstat.tlt.ln_pronme,1,150)    
            wdetail.n_text137      =  substr(brstat.tlt.ln_rate,1,15)     
            wdetail.n_text138      =  substr(brstat.tlt.ln_st,1,250)    
            wdetail.n_text139      =  substr(brstat.tlt.lotno,1,13)    
            wdetail.n_text140      =  substr(brstat.tlt.maritalsts,1,10)    
            wdetail.n_text141      =  substr(brstat.tlt.campaign,1,12)    
            wdetail.n_text142      =  substr(brstat.tlt.mobile,1,10)    
            wdetail.n_text143      =  brstat.tlt.acno1   
            wdetail.n_text144      =  brstat.tlt.agent  .
            /* ADD BY : A68-0061 */
           ASSIGN 
           wdetail.typepol    =   brstat.tlt.poltyp
           wdetail.typecar    =   brstat.tlt.car_type
           wdetail.maksi      =   STRING(brstat.tlt.maksi)
           wdetail.drivexp1   =   brstat.tlt.dri_licenexp1
           wdetail.drivcon1   =   string(brstat.tlt.dri_consen1)
           wdetail.dlevel1    =   string(brstat.tlt.dri_level1)
           wdetail.dgender1   =   brstat.tlt.dri_gender1
           wdetail.drivexp2   =   brstat.tlt.dri_licenexp2
           wdetail.drivcon2   =   string(brstat.tlt.dri_consen2)
           wdetail.dlevel2    =   string(brstat.tlt.dri_level2)
           wdetail.dgender2   =   brstat.tlt.dri_gender2
           wdetail.ntitle3    =   brstat.tlt.dri_title3
           wdetail.dname3     =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,1,INDEX(brstat.tlt.dri_fname3," ") - 1) ELSE TRIM(brstat.tlt.dri_fname3)
           wdetail.dcname3    =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,R-INDEX(brstat.tlt.dri_fname3," ")) ELSE "" 
           wdetail.dlname3    =   brstat.tlt.dri_lname3
           wdetail.doccup3    =   brstat.tlt.dir_occ3
           wdetail.dbirth3    =   brstat.tlt.dri_birth3
           wdetail.dicno3     =   brstat.tlt.dri_ic3
           wdetail.ddriveno3  =   brstat.tlt.dri_lic3
           wdetail.drivexp3   =   brstat.tlt.dri_licenexp3
           wdetail.drivcon3   =   string(brstat.tlt.dri_consen3)
           wdetail.dlevel3    =   string(brstat.tlt.dri_level3)
           wdetail.dgender3   =   brstat.tlt.dri_gender3
           wdetail.ntitle4    =   brstat.tlt.dri_title4
           wdetail.dname4     =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,1,INDEX(brstat.tlt.dri_fname4," ") - 1) ELSE TRIM(brstat.tlt.dri_fname4)
           wdetail.dcname4    =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,R-INDEX(brstat.tlt.dri_fname4," ")) ELSE ""
           wdetail.dlname4    =   brstat.tlt.dri_lname4
           wdetail.doccup4    =   brstat.tlt.dri_occ4
           wdetail.dbirth4    =   brstat.tlt.dri_birth4
           wdetail.dicno4     =   brstat.tlt.dri_ic4
           wdetail.ddriveno4  =   brstat.tlt.dri_lic4
           wdetail.drivexp4   =   brstat.tlt.dri_licenexp4
           wdetail.drivcon4   =   string(brstat.tlt.dri_consen4)
           wdetail.dlevel4    =   string(brstat.tlt.dri_level4)
           wdetail.dgender4   =   brstat.tlt.dri_gender4
           wdetail.ntitle5    =   brstat.tlt.dri_title5
           wdetail.dname5     =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,1,INDEX(brstat.tlt.dri_fname5," ") - 1) ELSE TRIM(brstat.tlt.dri_fname5)
           wdetail.dcname5    =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,R-INDEX(brstat.tlt.dri_fname5," ")) ELSE "" 
           wdetail.dlname5    =   brstat.tlt.dri_lname5
           wdetail.doccup5    =   brstat.tlt.dri_occ5
           wdetail.dbirth5    =   brstat.tlt.dri_birth5
           wdetail.dicno5     =   brstat.tlt.dri_ic5
           wdetail.ddriveno5  =   brstat.tlt.dri_lic5
           wdetail.drivexp5   =   brstat.tlt.dri_licenexp5
           wdetail.drivcon5   =   string(brstat.tlt.dri_consen5)
           wdetail.dlevel5    =   string(brstat.tlt.dri_level5)
           wdetail.dgender5   =   brstat.tlt.dri_gender5  
           wdetail.chargflg    =  STRING(brstat.tlt.chargflg)
           wdetail.chargprice  =  STRING(brstat.tlt.chargsi)
           wdetail.chargno     =  brstat.tlt.chargno
           wdetail.chargprm    =  string(brstat.tlt.chargprem)
           wdetail.battflg     =  string(brstat.tlt.battflg  )
           wdetail.battprice   =  string(brstat.tlt.battprice)
           wdetail.battno      =  brstat.tlt.battno
           wdetail.battprm     =  string(brstat.tlt.battprem)
           wdetail.battdate    =  string(brstat.tlt.ndate1,"99/99/9999")
           wdetail.net_re1     =  string(brstat.tlt.dg_prem)
           wdetail.stam_re1    =  string(brstat.tlt.dg_rstp_t)
           wdetail.vat_re1     =  string(brstat.tlt.dg_rtax_t)
           wdetail.inscode_re2 =  brstat.tlt.ins_code
           wdetail.net_re2     =  string(brstat.tlt.dg_si  )
           wdetail.stam_re2    =  string(brstat.tlt.dg_rate)
           wdetail.vat_re2     =  string(brstat.tlt.dg_feet)
           wdetail.inscode_re3 =  brstat.tlt.Paycode
           wdetail.net_re3     =  string(brstat.tlt.dg_ncb  )
           wdetail.stam_re3    =  string(brstat.tlt.dg_disc )
           wdetail.vat_re3     =  string(brstat.tlt.dg_wdisc) .
           /* END : A68-0061 */
        END.
    END.
 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_reportfielRenew c-wins 
PROCEDURE pd_reportfielRenew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 
For each tlt Use-index  tlt06 Where
            tlt.trndat >=  fi_trndatfr    And
            tlt.trndat <=  fi_trndatto    AND 
            tlt.genusr   =  "HCT"         And
            tlt.rec_note2  = "R"       NO-LOCK 
    BREAK BY brstat.tlt.comp_noti_ins :
    IF      nv_typre = "V70" AND brstat.tlt.nor_usr_ins  = "0" THEN NEXT.
    ELSE IF nv_typre = "V72" AND brstat.tlt.nor_usr_ins <> "0" THEN NEXT.
     
    CREATE  wdetail.
      ASSIGN 
  wdetail.n_text001      =  brstat.tlt.comp_noti_ins  
  wdetail.n_text002      =  brstat.tlt.comp_noti_tlt  
  wdetail.n_text003      =  brstat.tlt.comp_pol       
  wdetail.n_text004      =  string(brstat.tlt.nor_effdat,"99/99/9999")     
  wdetail.n_text005      =  string(brstat.tlt.comp_effdat,"99/99/9999")    
  wdetail.n_text006      =  brstat.tlt.comp_sub       
  wdetail.n_text007      =  brstat.tlt.cifno          
  wdetail.n_text008      =  brstat.tlt.nationality    
  wdetail.n_text009      =  brstat.tlt.nor_noti_ins   
  wdetail.n_text010      =  brstat.tlt.nor_noti_tlt   
  wdetail.n_text011      =  brstat.tlt.nor_usr_ins    
  wdetail.n_text012      =  brstat.tlt.covcod         
  wdetail.n_text013      =  brstat.tlt.nor_usr_tlt    
  wdetail.n_text014      =  brstat.tlt.comp_usr_ins   
  wdetail.n_text015      =  brstat.tlt.ins_title      
  wdetail.n_text016      =  brstat.tlt.ins_name       
  wdetail.n_text017      =  brstat.tlt.ins_firstname  
  wdetail.n_text018      =  brstat.tlt.ins_lastname   
  wdetail.n_text019      =  brstat.tlt.ins_addr       
  wdetail.n_text020      =  brstat.tlt.ins_addr1      
  wdetail.n_text021      =  brstat.tlt.ins_addr2      
  wdetail.n_text022      =  brstat.tlt.ins_addr3      
  wdetail.n_text023      =  brstat.tlt.lince2         
  wdetail.n_text024      =  brstat.tlt.ins_addr5      
  wdetail.n_text025      =  brstat.tlt.dir_occ1       
  wdetail.n_text026      =  brstat.tlt.note28         
  wdetail.n_text027      =  brstat.tlt.dri_ic1        
  wdetail.n_text028      =  brstat.tlt.dri_lic1       
  wdetail.n_text029      =  brstat.tlt.brand          
  wdetail.n_text030      =  substr(brstat.tlt.note10,1,1)         
  wdetail.n_text031      =  substr(brstat.tlt.cha_no,1,25)      
  wdetail.n_text032      =  substr(brstat.tlt.eng_no,1,20)                   
  wdetail.n_text033      =  substr(brstat.tlt.model,1,40)                 
  wdetail.n_text034      =  substr(brstat.tlt.note11,1,4)                  
  wdetail.n_text035      =  substr(brstat.tlt.note12,1,20)                  
  wdetail.n_text036      =  substr(brstat.tlt.note13,1,40)                  
  wdetail.n_text037      =  substr(brstat.tlt.note14,1,1)                   
  /*wdetail.n_text038      =  substr(brstat.tlt.vehuse,1,2) */ /* A68-0061*/
  wdetail.n_text038      =  IF rs_typre = 1 THEN substr(brstat.tlt.vehuse,1,2) ELSE TRIM(brstat.tlt.vehuse)  /* A68-0061*/                   
  wdetail.n_text039      =  string(brstat.tlt.seqno,"99")                        
  wdetail.n_text040      =  string(brstat.tlt.cc_weight,"9999")                  
  wdetail.n_text041      =  substr(brstat.tlt.colorcod,1,40)        
  wdetail.n_text042      =  substr(brstat.tlt.lince1,1,10)        
  wdetail.n_text043      =  substr(brstat.tlt.ins_addr4,1,30)        
  wdetail.n_text044      =  substr(brstat.tlt.note15,1,4)         
  wdetail.n_text045      =  substr(brstat.tlt.note16,1,512)              
  wdetail.n_text046      =  substr(brstat.tlt.note17,1,14)        
  wdetail.n_text047      =  substr(brstat.tlt.note18,1,14)       
  wdetail.n_text048      =  substr(brstat.tlt.note19,1,14)          
  wdetail.n_text049      =  substr(brstat.tlt.note2,1,14)          
  wdetail.n_text050      =  substr(brstat.tlt.note20,1,14)       
  wdetail.n_text051      =  substr(brstat.tlt.note21,1,14)          
  wdetail.n_text052      =  substr(brstat.tlt.note22,1,14)        
  wdetail.n_text053      =  substr(brstat.tlt.note23,1,14)        
  wdetail.n_text054      =  substr(brstat.tlt.comp_sck,1,20)        
  wdetail.n_text055      =  substr(brstat.tlt.note24,1,32)        
  wdetail.n_text056      =  substr(brstat.tlt.dri_no1,1,1)        
  wdetail.n_text057      =  substr(brstat.tlt.dri_no2,1,1)         
  wdetail.n_text058      =  substr(brstat.tlt.note25,1,20)      
  wdetail.n_text059      =  substr(brstat.tlt.dri_name1,1,80)      
  wdetail.n_text060      =  substr(brstat.tlt.note26,1,20)      
  wdetail.n_text061      =  substr(brstat.tlt.note27,1,60)      
  wdetail.n_text062      =  substr(brstat.tlt.dri_occ2,1,50)   
  wdetail.n_text063      =  substr(brstat.tlt.note4,1,10)         
  wdetail.n_text064      =  substr(brstat.tlt.dri_ic2,1,15)         
  wdetail.n_text065      =  substr(brstat.tlt.dri_lic2,1,15)         
  wdetail.n_text066      =  substr(brstat.tlt.note29,1,20)         
  wdetail.n_text067      =  substr(brstat.tlt.dri_name2,1,80)         
  wdetail.n_text068      =  substr(brstat.tlt.note3,1,20)         
  wdetail.n_text069      =  substr(brstat.tlt.note30,1,60)         
  wdetail.n_text070      =  substr(brstat.tlt.ins_occ,1,50)         
  wdetail.n_text071      =  IF brstat.tlt.birthdate = ? THEN "" ELSE string(brstat.tlt.birthdate,"99/99/9999")              
  wdetail.n_text072      =  substr(brstat.tlt.ins_icno,1,15)           
  wdetail.n_text073      =  substr(brstat.tlt.note1,1,15)                   
  wdetail.n_text074      =  substr(brstat.tlt.ben83,1,80)                   
  wdetail.n_text075      =  string(brstat.tlt.comp_coamt,"99999999999.99")      
  wdetail.n_text076      =  string(brstat.tlt.comp_grprm,"99999999999.99")      
  wdetail.n_text077      =     string(brstat.tlt.mileage,"99999999999.99")         
  wdetail.n_text078      =      string(brstat.tlt.ndeci1,"99999999999.99")          
  wdetail.n_text079      =      string(brstat.tlt.ndeci2,"99999999999.99")          
  wdetail.n_text080      =      string(brstat.tlt.ndeci3,"99999999999.99")          
  wdetail.n_text081      =      string(brstat.tlt.ndeci4,"99999999999.99")          
  wdetail.n_text082      =      string(brstat.tlt.ndeci5,"99999999999.99")          
  wdetail.n_text083      =   string(brstat.tlt.nor_coamt,"99")                    
  wdetail.n_text084      =   string(brstat.tlt.nor_grprm,"99999999999.99")       
  wdetail.n_text085      =    string(brstat.tlt.prem_amt,"99999999999.99")        
  wdetail.n_text086     = string(brstat.tlt.prem_amttcop,"99")                 
  wdetail.n_text087      =        string(brstat.tlt.rstp,"99999999999.99")            
  wdetail.n_text088      =        string(brstat.tlt.rtax,"99999999999.99")            
  wdetail.n_text089     = string(brstat.tlt.tax_coporate,"99999999999.99")    
  wdetail.n_text090      =  substr(brstat.tlt.note5,1,6)            
  wdetail.n_text091      =  substr(brstat.tlt.note6,1,10)        
  wdetail.n_text092      =  substr(brstat.tlt.note7,1,10)        
  wdetail.n_text093      =  substr(brstat.tlt.note8,1,30)        
  wdetail.n_text094      =  substr(brstat.tlt.note9,1,80)        
  wdetail.n_text095      =  substr(brstat.tlt.noteveh1,1,10)        
  wdetail.n_text096      =  substr(brstat.tlt.noteveh2,1,30)        
  wdetail.n_text097      =  substr(brstat.tlt.old_cha,1,12)        
  wdetail.n_text098      =  substr(brstat.tlt.old_eng,1,3)             
  wdetail.n_text099      =  substr(brstat.tlt.pack,1,10)      
  wdetail.n_text100      =  substr(brstat.tlt.packnme,1,14)      
  wdetail.n_text101      =  substr(brstat.tlt.period,1,10)      
  wdetail.n_text102      =  substr(brstat.tlt.ln_note1,1,14) 
  wdetail.n_text103      =  substr(brstat.tlt.product,1,10)   
  wdetail.n_text104      =  substr(brstat.tlt.projnme,1,14)   
  wdetail.n_text105      =  substr(brstat.tlt.proveh,1,10)   
  wdetail.n_text106      =  substr(brstat.tlt.race,1,14)   
  wdetail.n_text107      =  substr(brstat.tlt.recac,1,10)   
  wdetail.n_text108      =  substr(brstat.tlt.rec_addr,1,14)   
  wdetail.n_text109      =  substr(brstat.tlt.rec_addr1,1,15)   
  wdetail.n_text110      =  substr(brstat.tlt.rec_addr2,1,10)   
  wdetail.n_text111      =  substr(brstat.tlt.rec_addr3,1,14)   
  wdetail.n_text112      =  substr(brstat.tlt.rec_addr4,1,10)   
  wdetail.n_text113      =  substr(brstat.tlt.rec_addr5,1,20)   
  wdetail.n_text114      =  substr(brstat.tlt.rec_brins,1,1)         
  wdetail.n_text115      =  substr(brstat.tlt.rec_cou,1,120)      
  wdetail.n_text116      =  substr(brstat.tlt.rec_icno,1,100)      
  wdetail.n_text117      =  substr(brstat.tlt.rec_name,1,2)         
  wdetail.n_text118      =  substr(brstat.tlt.rec_name2,1,2)         
  wdetail.n_text119      =  substr(brstat.tlt.rec_note1,1,10)        
  wdetail.n_text120      =  substr(brstat.tlt.rec_note2,1,1)        
  wdetail.n_text121      =  substr(brstat.tlt.rec_title,1,10)        
  wdetail.n_text122      =  substr(brstat.tlt.rec_typ,1,255)       
  wdetail.n_text123      =  substr(brstat.tlt.rider,1,5)         
  wdetail.n_text124      =  substr(brstat.tlt.safe1,1,20)        
  wdetail.n_text125      =  substr(brstat.tlt.safe2,1,10)        
  wdetail.n_text126      =  substr(brstat.tlt.safe3,1,150)       
  wdetail.n_text127      =  substr(brstat.tlt.sex,1,15)        
  wdetail.n_text128      =  substr(brstat.tlt.stat,1,250)       
  wdetail.n_text129      =  substr(brstat.tlt.subins,1,13)        
  wdetail.n_text130      =  substr(brstat.tlt.tel,1,10)        
  wdetail.n_text131      =  substr(brstat.tlt.tel2,1,150)      
  wdetail.n_text132      =  substr(brstat.tlt.tel3,1,15)       
  wdetail.n_text133      =  substr(brstat.tlt.usrid,1,250)       
  wdetail.n_text134      =  substr(brstat.tlt.usrsent,1,13)       
  wdetail.n_text135      =  substr(brstat.tlt.ln_product,1,10)     
  wdetail.n_text136      =  substr(brstat.tlt.ln_pronme,1,150)    
  wdetail.n_text137      =  substr(brstat.tlt.ln_rate,1,15)     
  wdetail.n_text138      =  substr(brstat.tlt.ln_st,1,250)    
  wdetail.n_text139      =  substr(brstat.tlt.lotno,1,13)    
  wdetail.n_text140      =  substr(brstat.tlt.maritalsts,1,10)    
  wdetail.n_text141      =  substr(brstat.tlt.campaign,1,12)    
  wdetail.n_text142      =  substr(brstat.tlt.mobile,1,10)  
  wdetail.n_text143      =  brstat.tlt.acno1   
  wdetail.n_text144      =  brstat.tlt.agent  .  
  /* ADD BY : A68-0061 */
    ASSIGN 
    wdetail.typepol    =   brstat.tlt.poltyp
    wdetail.typecar    =   brstat.tlt.car_type
    wdetail.maksi      =   STRING(brstat.tlt.maksi)
    wdetail.drivexp1   =   brstat.tlt.dri_licenexp1
    wdetail.drivcon1   =   string(brstat.tlt.dri_consen1)
    wdetail.dlevel1    =   string(brstat.tlt.dri_level1)
    wdetail.dgender1   =   brstat.tlt.dri_gender1
    wdetail.drivexp2   =   brstat.tlt.dri_licenexp2
    wdetail.drivcon2   =   string(brstat.tlt.dri_consen2)
    wdetail.dlevel2    =   string(brstat.tlt.dri_level2)
    wdetail.dgender2   =   brstat.tlt.dri_gender2
    wdetail.ntitle3    =   brstat.tlt.dri_title3
    wdetail.dname3     =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,1,INDEX(brstat.tlt.dri_fname3," ") - 1) ELSE TRIM(brstat.tlt.dri_fname3)
    wdetail.dcname3    =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,R-INDEX(brstat.tlt.dri_fname3," ")) ELSE "" 
    wdetail.dlname3    =   brstat.tlt.dri_lname3
    wdetail.doccup3    =   brstat.tlt.dir_occ3
    wdetail.dbirth3    =   brstat.tlt.dri_birth3
    wdetail.dicno3     =   brstat.tlt.dri_ic3
    wdetail.ddriveno3  =   brstat.tlt.dri_lic3
    wdetail.drivexp3   =   brstat.tlt.dri_licenexp3
    wdetail.drivcon3   =   string(brstat.tlt.dri_consen3)
    wdetail.dlevel3    =   string(brstat.tlt.dri_level3)
    wdetail.dgender3   =   brstat.tlt.dri_gender3
    wdetail.ntitle4    =   brstat.tlt.dri_title4
    wdetail.dname4     =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,1,INDEX(brstat.tlt.dri_fname4," ") - 1) ELSE TRIM(brstat.tlt.dri_fname4)
    wdetail.dcname4    =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,R-INDEX(brstat.tlt.dri_fname4," ")) ELSE ""
    wdetail.dlname4    =   brstat.tlt.dri_lname4
    wdetail.doccup4    =   brstat.tlt.dri_occ4
    wdetail.dbirth4    =   brstat.tlt.dri_birth4
    wdetail.dicno4     =   brstat.tlt.dri_ic4
    wdetail.ddriveno4  =   brstat.tlt.dri_lic4
    wdetail.drivexp4   =   brstat.tlt.dri_licenexp4
    wdetail.drivcon4   =   string(brstat.tlt.dri_consen4)
    wdetail.dlevel4    =   string(brstat.tlt.dri_level4)
    wdetail.dgender4   =   brstat.tlt.dri_gender4
    wdetail.ntitle5    =   brstat.tlt.dri_title5
    wdetail.dname5     =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,1,INDEX(brstat.tlt.dri_fname5," ") - 1) ELSE TRIM(brstat.tlt.dri_fname5)
    wdetail.dcname5    =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,R-INDEX(brstat.tlt.dri_fname5," ")) ELSE "" 
    wdetail.dlname5    =   brstat.tlt.dri_lname5
    wdetail.doccup5    =   brstat.tlt.dri_occ5
    wdetail.dbirth5    =   brstat.tlt.dri_birth5
    wdetail.dicno5     =   brstat.tlt.dri_ic5
    wdetail.ddriveno5  =   brstat.tlt.dri_lic5
    wdetail.drivexp5   =   brstat.tlt.dri_licenexp5
    wdetail.drivcon5   =   string(brstat.tlt.dri_consen5)
    wdetail.dlevel5    =   string(brstat.tlt.dri_level5)
    wdetail.dgender5   =   brstat.tlt.dri_gender5  
    wdetail.chargflg    =  STRING(brstat.tlt.chargflg)
    wdetail.chargprice  =  STRING(brstat.tlt.chargsi)
    wdetail.chargno     =  brstat.tlt.chargno
    wdetail.chargprm    =  string(brstat.tlt.chargprem)
    wdetail.battflg     =  string(brstat.tlt.battflg  )
    wdetail.battprice   =  string(brstat.tlt.battprice)
    wdetail.battno      =  brstat.tlt.battno
    wdetail.battprm     =  string(brstat.tlt.battprem)
    wdetail.battdate    =  string(brstat.tlt.ndate1,"99/99/9999")
    wdetail.net_re1     =  string(brstat.tlt.dg_prem)
    wdetail.stam_re1    =  string(brstat.tlt.dg_rstp_t)
    wdetail.vat_re1     =  string(brstat.tlt.dg_rtax_t)
    wdetail.inscode_re2 =  brstat.tlt.ins_code
    wdetail.net_re2     =  string(brstat.tlt.dg_si  )
    wdetail.stam_re2    =  string(brstat.tlt.dg_rate)
    wdetail.vat_re2     =  string(brstat.tlt.dg_feet)
    wdetail.inscode_re3 =  brstat.tlt.Paycode
    wdetail.net_re3     =  string(brstat.tlt.dg_ncb  )
    wdetail.stam_re3    =  string(brstat.tlt.dg_disc )
    wdetail.vat_re3     =  string(brstat.tlt.dg_wdisc) .
 /* END : A68-0061 */


END. 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_reportfielRenew1 c-wins 
PROCEDURE pd_reportfielRenew1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wproducer NO-LOCK.
    For each tlt Use-index  tlt06 Where
        tlt.trndat >=  fi_trndatfr    And
        tlt.trndat <=  fi_trndatto    AND 
        /*tlt.acno1   =  trim(fi_producer)  AND*/
        tlt.acno1      =  wproducer.producer  AND 
        tlt.genusr   =  "HCT"         And
        tlt.rec_note2  = "R"       NO-LOCK 
        BREAK BY brstat.tlt.comp_noti_ins :
        IF      nv_typre = "V70" AND brstat.tlt.nor_usr_ins  = "0" THEN NEXT.
        ELSE IF nv_typre = "V72" AND brstat.tlt.nor_usr_ins <> "0" THEN NEXT.
        CREATE  wdetail.
        ASSIGN 
        wdetail.n_text001      =  brstat.tlt.comp_noti_ins  
        wdetail.n_text002      =  brstat.tlt.comp_noti_tlt  
        wdetail.n_text003      =  brstat.tlt.comp_pol       
        wdetail.n_text004      =  string(brstat.tlt.nor_effdat,"99/99/9999")     
        wdetail.n_text005      =  string(brstat.tlt.comp_effdat,"99/99/9999")    
        wdetail.n_text006      =  brstat.tlt.comp_sub       
        wdetail.n_text007      =  brstat.tlt.cifno          
        wdetail.n_text008      =  brstat.tlt.nationality    
        wdetail.n_text009      =  brstat.tlt.nor_noti_ins   
        wdetail.n_text010      =  brstat.tlt.nor_noti_tlt   
        wdetail.n_text011      =  brstat.tlt.nor_usr_ins    
        wdetail.n_text012      =  brstat.tlt.covcod         
        wdetail.n_text013      =  brstat.tlt.nor_usr_tlt    
        wdetail.n_text014      =  brstat.tlt.comp_usr_ins   
        wdetail.n_text015      =  brstat.tlt.ins_title      
        wdetail.n_text016      =  brstat.tlt.ins_name       
        wdetail.n_text017      =  brstat.tlt.ins_firstname  
        wdetail.n_text018      =  brstat.tlt.ins_lastname   
        wdetail.n_text019      =  brstat.tlt.ins_addr       
        wdetail.n_text020      =  brstat.tlt.ins_addr1      
        wdetail.n_text021      =  brstat.tlt.ins_addr2      
        wdetail.n_text022      =  brstat.tlt.ins_addr3      
        wdetail.n_text023      =  brstat.tlt.lince2         
        wdetail.n_text024      =  brstat.tlt.ins_addr5      
        wdetail.n_text025      =  brstat.tlt.dir_occ1       
        wdetail.n_text026      =  brstat.tlt.note28         
        wdetail.n_text027      =  brstat.tlt.dri_ic1        
        wdetail.n_text028      =  brstat.tlt.dri_lic1       
        wdetail.n_text029      =  brstat.tlt.brand          
        wdetail.n_text030      =  substr(brstat.tlt.note10,1,1)         
        wdetail.n_text031      =  substr(brstat.tlt.cha_no,1,25)      
        wdetail.n_text032      =  substr(brstat.tlt.eng_no,1,20)                   
        wdetail.n_text033      =  substr(brstat.tlt.model,1,40)                 
        wdetail.n_text034      =  substr(brstat.tlt.note11,1,4)                  
        wdetail.n_text035      =  substr(brstat.tlt.note12,1,20)                  
        wdetail.n_text036      =  substr(brstat.tlt.note13,1,40)                  
        wdetail.n_text037      =  substr(brstat.tlt.note14,1,1)                   
        /*wdetail.n_text038      =  substr(brstat.tlt.vehuse,1,2) */ /* A68-0061*/
        wdetail.n_text038      =  IF rs_typre = 1 THEN substr(brstat.tlt.vehuse,1,2) ELSE TRIM(brstat.tlt.vehuse)  /* A68-0061*/                  
        wdetail.n_text039      =  string(brstat.tlt.seqno,"99")                        
        wdetail.n_text040      =  string(brstat.tlt.cc_weight,"9999")                  
        wdetail.n_text041      =  substr(brstat.tlt.colorcod,1,40)        
        wdetail.n_text042      =  substr(brstat.tlt.lince1,1,10)        
        wdetail.n_text043      =  substr(brstat.tlt.ins_addr4,1,30)        
        wdetail.n_text044      =  substr(brstat.tlt.note15,1,4)         
        wdetail.n_text045      =  substr(brstat.tlt.note16,1,512)              
        wdetail.n_text046      =  substr(brstat.tlt.note17,1,14)        
        wdetail.n_text047      =  substr(brstat.tlt.note18,1,14)       
        wdetail.n_text048      =  substr(brstat.tlt.note19,1,14)          
        wdetail.n_text049      =  substr(brstat.tlt.note2,1,14)          
        wdetail.n_text050      =  substr(brstat.tlt.note20,1,14)       
        wdetail.n_text051      =  substr(brstat.tlt.note21,1,14)          
        wdetail.n_text052      =  substr(brstat.tlt.note22,1,14)        
        wdetail.n_text053      =  substr(brstat.tlt.note23,1,14)        
        wdetail.n_text054      =  substr(brstat.tlt.comp_sck,1,20)        
        wdetail.n_text055      =  substr(brstat.tlt.note24,1,32)        
        wdetail.n_text056      =  substr(brstat.tlt.dri_no1,1,1)        
        wdetail.n_text057      =  substr(brstat.tlt.dri_no2,1,1)         
        wdetail.n_text058      =  substr(brstat.tlt.note25,1,20)      
        wdetail.n_text059      =  substr(brstat.tlt.dri_name1,1,80)      
        wdetail.n_text060      =  substr(brstat.tlt.note26,1,20)      
        wdetail.n_text061      =  substr(brstat.tlt.note27,1,60)      
        wdetail.n_text062      =  substr(brstat.tlt.dri_occ2,1,50)   
        wdetail.n_text063      =  substr(brstat.tlt.note4,1,10)         
        wdetail.n_text064      =  substr(brstat.tlt.dri_ic2,1,15)         
        wdetail.n_text065      =  substr(brstat.tlt.dri_lic2,1,15)         
        wdetail.n_text066      =  substr(brstat.tlt.note29,1,20)         
        wdetail.n_text067      =  substr(brstat.tlt.dri_name2,1,80)         
        wdetail.n_text068      =  substr(brstat.tlt.note3,1,20)         
        wdetail.n_text069      =  substr(brstat.tlt.note30,1,60)         
        wdetail.n_text070      =  substr(brstat.tlt.ins_occ,1,50)         
        wdetail.n_text071      =  IF brstat.tlt.birthdate = ? THEN "" ELSE string(brstat.tlt.birthdate,"99/99/9999")              
        wdetail.n_text072      =  substr(brstat.tlt.ins_icno,1,15)           
        wdetail.n_text073      =  substr(brstat.tlt.note1,1,15)                   
        wdetail.n_text074      =  substr(brstat.tlt.ben83,1,80)                   
        wdetail.n_text075      =  string(brstat.tlt.comp_coamt,"99999999999.99")      
        wdetail.n_text076      =  string(brstat.tlt.comp_grprm,"99999999999.99")      
        wdetail.n_text077      =  string(brstat.tlt.mileage,"99999999999.99")         
        wdetail.n_text078      =  string(brstat.tlt.ndeci1,"99999999999.99")          
        wdetail.n_text079      =  string(brstat.tlt.ndeci2,"99999999999.99")          
        wdetail.n_text080      =  string(brstat.tlt.ndeci3,"99999999999.99")          
        wdetail.n_text081      =  string(brstat.tlt.ndeci4,"99999999999.99")          
        wdetail.n_text082      =  string(brstat.tlt.ndeci5,"99999999999.99")          
        wdetail.n_text083      =  string(brstat.tlt.nor_coamt,"99")                    
        wdetail.n_text084      =  string(brstat.tlt.nor_grprm,"99999999999.99")       
        wdetail.n_text085      =  string(brstat.tlt.prem_amt,"99999999999.99")        
        wdetail.n_text086      =  string(brstat.tlt.prem_amttcop,"99")                 
        wdetail.n_text087      =  string(brstat.tlt.rstp,"99999999999.99")            
        wdetail.n_text088      =  string(brstat.tlt.rtax,"99999999999.99")            
        wdetail.n_text089      =  string(brstat.tlt.tax_coporate,"99999999999.99")    
        wdetail.n_text090      =  substr(brstat.tlt.note5,1,6)            
        wdetail.n_text091      =  substr(brstat.tlt.note6,1,10)        
        wdetail.n_text092      =  substr(brstat.tlt.note7,1,10)        
        wdetail.n_text093      =  substr(brstat.tlt.note8,1,30)        
        wdetail.n_text094      =  substr(brstat.tlt.note9,1,80)        
        wdetail.n_text095      =  substr(brstat.tlt.noteveh1,1,10)        
        wdetail.n_text096      =  substr(brstat.tlt.noteveh2,1,30)        
        wdetail.n_text097      =  substr(brstat.tlt.old_cha,1,12)        
        wdetail.n_text098      =  substr(brstat.tlt.old_eng,1,3)             
        wdetail.n_text099      =  substr(brstat.tlt.pack,1,10)      
        wdetail.n_text100      =  substr(brstat.tlt.packnme,1,14)      
        wdetail.n_text101      =  substr(brstat.tlt.period,1,10)      
        wdetail.n_text102      =  substr(brstat.tlt.ln_note1,1,14) 
        wdetail.n_text103      =  substr(brstat.tlt.product,1,10)   
        wdetail.n_text104      =  substr(brstat.tlt.projnme,1,14)   
        wdetail.n_text105      =  substr(brstat.tlt.proveh,1,10)   
        wdetail.n_text106      =  substr(brstat.tlt.race,1,14)   
        wdetail.n_text107      =  substr(brstat.tlt.recac,1,10)   
        wdetail.n_text108      =  substr(brstat.tlt.rec_addr,1,14)   
        wdetail.n_text109      =  substr(brstat.tlt.rec_addr1,1,15)   
        wdetail.n_text110      =  substr(brstat.tlt.rec_addr2,1,10)   
        wdetail.n_text111      =  substr(brstat.tlt.rec_addr3,1,14)   
        wdetail.n_text112      =  substr(brstat.tlt.rec_addr4,1,10)   
        wdetail.n_text113      =  substr(brstat.tlt.rec_addr5,1,20)   
        wdetail.n_text114      =  substr(brstat.tlt.rec_brins,1,1)         
        wdetail.n_text115      =  substr(brstat.tlt.rec_cou,1,120)      
        wdetail.n_text116      =  substr(brstat.tlt.rec_icno,1,100)      
        wdetail.n_text117      =  substr(brstat.tlt.rec_name,1,2)         
        wdetail.n_text118      =  substr(brstat.tlt.rec_name2,1,2)         
        wdetail.n_text119      =  substr(brstat.tlt.rec_note1,1,10)        
        wdetail.n_text120      =  substr(brstat.tlt.rec_note2,1,1)        
        wdetail.n_text121      =  substr(brstat.tlt.rec_title,1,10)        
        wdetail.n_text122      =  substr(brstat.tlt.rec_typ,1,255)       
        wdetail.n_text123      =  substr(brstat.tlt.rider,1,5)         
        wdetail.n_text124      =  substr(brstat.tlt.safe1,1,20)        
        wdetail.n_text125      =  substr(brstat.tlt.safe2,1,10)        
        wdetail.n_text126      =  substr(brstat.tlt.safe3,1,150)       
        wdetail.n_text127      =  substr(brstat.tlt.sex,1,15)        
        wdetail.n_text128      =  substr(brstat.tlt.stat,1,250)       
        wdetail.n_text129      =  substr(brstat.tlt.subins,1,13)        
        wdetail.n_text130      =  substr(brstat.tlt.tel,1,10)        
        wdetail.n_text131      =  substr(brstat.tlt.tel2,1,150)      
        wdetail.n_text132      =  substr(brstat.tlt.tel3,1,15)       
        wdetail.n_text133      =  substr(brstat.tlt.usrid,1,250)       
        wdetail.n_text134      =  substr(brstat.tlt.usrsent,1,13)       
        wdetail.n_text135      =  substr(brstat.tlt.ln_product,1,10)     
        wdetail.n_text136      =  substr(brstat.tlt.ln_pronme,1,150)    
        wdetail.n_text137      =  substr(brstat.tlt.ln_rate,1,15)     
        wdetail.n_text138      =  substr(brstat.tlt.ln_st,1,250)    
        wdetail.n_text139      =  substr(brstat.tlt.lotno,1,13)    
        wdetail.n_text140      =  substr(brstat.tlt.maritalsts,1,10)    
        wdetail.n_text141      =  substr(brstat.tlt.campaign,1,12)    
        wdetail.n_text142      =  substr(brstat.tlt.mobile,1,10)    
        wdetail.n_text143      =  brstat.tlt.acno1   
        wdetail.n_text144      =  brstat.tlt.agent  .
        /* ADD BY : A68-0061 */
    ASSIGN 
    wdetail.typepol    =   brstat.tlt.poltyp
    wdetail.typecar    =   brstat.tlt.car_type
    wdetail.maksi      =   STRING(brstat.tlt.maksi)
    wdetail.drivexp1   =   brstat.tlt.dri_licenexp1
    wdetail.drivcon1   =   string(brstat.tlt.dri_consen1)
    wdetail.dlevel1    =   string(brstat.tlt.dri_level1)
    wdetail.dgender1   =   brstat.tlt.dri_gender1
    wdetail.drivexp2   =   brstat.tlt.dri_licenexp2
    wdetail.drivcon2   =   string(brstat.tlt.dri_consen2)
    wdetail.dlevel2    =   string(brstat.tlt.dri_level2)
    wdetail.dgender2   =   brstat.tlt.dri_gender2
    wdetail.ntitle3    =   brstat.tlt.dri_title3
    wdetail.dname3     =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,1,INDEX(brstat.tlt.dri_fname3," ") - 1) ELSE TRIM(brstat.tlt.dri_fname3)
    wdetail.dcname3    =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,R-INDEX(brstat.tlt.dri_fname3," ")) ELSE "" 
    wdetail.dlname3    =   brstat.tlt.dri_lname3
    wdetail.doccup3    =   brstat.tlt.dir_occ3
    wdetail.dbirth3    =   brstat.tlt.dri_birth3
    wdetail.dicno3     =   brstat.tlt.dri_ic3
    wdetail.ddriveno3  =   brstat.tlt.dri_lic3
    wdetail.drivexp3   =   brstat.tlt.dri_licenexp3
    wdetail.drivcon3   =   string(brstat.tlt.dri_consen3)
    wdetail.dlevel3    =   string(brstat.tlt.dri_level3)
    wdetail.dgender3   =   brstat.tlt.dri_gender3
    wdetail.ntitle4    =   brstat.tlt.dri_title4
    wdetail.dname4     =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,1,INDEX(brstat.tlt.dri_fname4," ") - 1) ELSE TRIM(brstat.tlt.dri_fname4)
    wdetail.dcname4    =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,R-INDEX(brstat.tlt.dri_fname4," ")) ELSE ""
    wdetail.dlname4    =   brstat.tlt.dri_lname4
    wdetail.doccup4    =   brstat.tlt.dri_occ4
    wdetail.dbirth4    =   brstat.tlt.dri_birth4
    wdetail.dicno4     =   brstat.tlt.dri_ic4
    wdetail.ddriveno4  =   brstat.tlt.dri_lic4
    wdetail.drivexp4   =   brstat.tlt.dri_licenexp4
    wdetail.drivcon4   =   string(brstat.tlt.dri_consen4)
    wdetail.dlevel4    =   string(brstat.tlt.dri_level4)
    wdetail.dgender4   =   brstat.tlt.dri_gender4
    wdetail.ntitle5    =   brstat.tlt.dri_title5
    wdetail.dname5     =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,1,INDEX(brstat.tlt.dri_fname5," ") - 1) ELSE TRIM(brstat.tlt.dri_fname5)
    wdetail.dcname5    =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,R-INDEX(brstat.tlt.dri_fname5," ")) ELSE "" 
    wdetail.dlname5    =   brstat.tlt.dri_lname5
    wdetail.doccup5    =   brstat.tlt.dri_occ5
    wdetail.dbirth5    =   brstat.tlt.dri_birth5
    wdetail.dicno5     =   brstat.tlt.dri_ic5
    wdetail.ddriveno5  =   brstat.tlt.dri_lic5
    wdetail.drivexp5   =   brstat.tlt.dri_licenexp5
    wdetail.drivcon5   =   string(brstat.tlt.dri_consen5)
    wdetail.dlevel5    =   string(brstat.tlt.dri_level5)
    wdetail.dgender5   =   brstat.tlt.dri_gender5  
    wdetail.chargflg    =  STRING(brstat.tlt.chargflg)
    wdetail.chargprice  =  STRING(brstat.tlt.chargsi)
    wdetail.chargno     =  brstat.tlt.chargno
    wdetail.chargprm    =  string(brstat.tlt.chargprem)
    wdetail.battflg     =  string(brstat.tlt.battflg  )
    wdetail.battprice   =  string(brstat.tlt.battprice)
    wdetail.battno      =  brstat.tlt.battno
    wdetail.battprm     =  string(brstat.tlt.battprem)
    wdetail.battdate    =  string(brstat.tlt.ndate1,"99/99/9999")
    wdetail.net_re1     =  string(brstat.tlt.dg_prem)
    wdetail.stam_re1    =  string(brstat.tlt.dg_rstp_t)
    wdetail.vat_re1     =  string(brstat.tlt.dg_rtax_t)
    wdetail.inscode_re2 =  brstat.tlt.ins_code
    wdetail.net_re2     =  string(brstat.tlt.dg_si  )
    wdetail.stam_re2    =  string(brstat.tlt.dg_rate)
    wdetail.vat_re2     =  string(brstat.tlt.dg_feet)
    wdetail.inscode_re3 =  brstat.tlt.Paycode
    wdetail.net_re3     =  string(brstat.tlt.dg_ncb  )
    wdetail.stam_re3    =  string(brstat.tlt.dg_disc )
    wdetail.vat_re3     =  string(brstat.tlt.dg_wdisc) .
 /* END : A68-0061 */
    END.
END. 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_reportfielsts c-wins 
PROCEDURE pd_reportfielsts :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
IF fi_report = "" THEN DO:
    MESSAGE "ʶҹ� �繤����ҧ " VIEW-AS ALERT-BOX.
    
END.
ELSE DO:
    For each tlt Use-index  tlt06 Where
        tlt.trndat >=  fi_trndatfr     And
        tlt.trndat <=  fi_trndatto     AND 
        tlt.genusr  =  "HCT"           And
        brstat.tlt.releas =  trim(fi_report) NO-LOCK 
        BREAK BY brstat.tlt.comp_noti_ins :
        IF      nv_typre = "V70" AND brstat.tlt.nor_usr_ins  = "0" THEN NEXT.
        ELSE IF nv_typre = "V72" AND brstat.tlt.nor_usr_ins <> "0" THEN NEXT.
        CREATE  wdetail.
        ASSIGN 
        wdetail.n_text001      =  brstat.tlt.comp_noti_ins  
        wdetail.n_text002      =  brstat.tlt.comp_noti_tlt  
        wdetail.n_text003      =  brstat.tlt.comp_pol       
        wdetail.n_text004      =  string(brstat.tlt.nor_effdat,"99/99/9999")     
        wdetail.n_text005      =  string(brstat.tlt.comp_effdat,"99/99/9999")    
        wdetail.n_text006      =  brstat.tlt.comp_sub       
        wdetail.n_text007      =  brstat.tlt.cifno          
        wdetail.n_text008      =  brstat.tlt.nationality    
        wdetail.n_text009      =  brstat.tlt.nor_noti_ins   
        wdetail.n_text010      =  brstat.tlt.nor_noti_tlt   
        wdetail.n_text011      =  brstat.tlt.nor_usr_ins    
        wdetail.n_text012      =  brstat.tlt.covcod         
        wdetail.n_text013      =  brstat.tlt.nor_usr_tlt    
        wdetail.n_text014      =  brstat.tlt.comp_usr_ins   
        wdetail.n_text015      =  brstat.tlt.ins_title      
        wdetail.n_text016      =  brstat.tlt.ins_name       
        wdetail.n_text017      =  brstat.tlt.ins_firstname  
        wdetail.n_text018      =  brstat.tlt.ins_lastname   
        wdetail.n_text019      =  brstat.tlt.ins_addr       
        wdetail.n_text020      =  brstat.tlt.ins_addr1      
        wdetail.n_text021      =  brstat.tlt.ins_addr2      
        wdetail.n_text022      =  brstat.tlt.ins_addr3      
        wdetail.n_text023      =  brstat.tlt.lince2         
        wdetail.n_text024      =  brstat.tlt.ins_addr5      
        wdetail.n_text025      =  brstat.tlt.dir_occ1       
        wdetail.n_text026      =  brstat.tlt.note28         
        wdetail.n_text027      =  brstat.tlt.dri_ic1        
        wdetail.n_text028      =  brstat.tlt.dri_lic1       
        wdetail.n_text029      =  brstat.tlt.brand          
        wdetail.n_text030      =  substr(brstat.tlt.note10,1,1)         
        wdetail.n_text031      =  substr(brstat.tlt.cha_no,1,25)      
        wdetail.n_text032      =  substr(brstat.tlt.eng_no,1,20)                   
        wdetail.n_text033      =  substr(brstat.tlt.model,1,40)                 
        wdetail.n_text034      =  substr(brstat.tlt.note11,1,4)                  
        wdetail.n_text035      =  substr(brstat.tlt.note12,1,20)                  
        wdetail.n_text036      =  substr(brstat.tlt.note13,1,40)                  
        wdetail.n_text037      =  substr(brstat.tlt.note14,1,1)                   
        wdetail.n_text038      =  substr(brstat.tlt.vehuse,1,2)                   
        wdetail.n_text039      =  string(brstat.tlt.seqno,"99")                        
        wdetail.n_text040      =  string(brstat.tlt.cc_weight,"9999")                  
        wdetail.n_text041      =  substr(brstat.tlt.colorcod,1,40)        
        wdetail.n_text042      =  substr(brstat.tlt.lince1,1,10)        
        wdetail.n_text043      =  substr(brstat.tlt.ins_addr4,1,30)        
        wdetail.n_text044      =  substr(brstat.tlt.note15,1,4)         
        wdetail.n_text045      =  substr(brstat.tlt.note16,1,512)              
        wdetail.n_text046      =  substr(brstat.tlt.note17,1,14)        
        wdetail.n_text047      =  substr(brstat.tlt.note18,1,14)       
        wdetail.n_text048      =  substr(brstat.tlt.note19,1,14)          
        wdetail.n_text049      =  substr(brstat.tlt.note2,1,14)          
        wdetail.n_text050      =  substr(brstat.tlt.note20,1,14)       
        wdetail.n_text051      =  substr(brstat.tlt.note21,1,14)          
        wdetail.n_text052      =  substr(brstat.tlt.note22,1,14)        
        wdetail.n_text053      =  substr(brstat.tlt.note23,1,14)        
        wdetail.n_text054      =  substr(brstat.tlt.comp_sck,1,20)        
        wdetail.n_text055      =  substr(brstat.tlt.note24,1,32)        
        wdetail.n_text056      =  substr(brstat.tlt.dri_no1,1,1)        
        wdetail.n_text057      =  substr(brstat.tlt.dri_no2,1,1)         
        wdetail.n_text058      =  substr(brstat.tlt.note25,1,20)      
        wdetail.n_text059      =  substr(brstat.tlt.dri_name1,1,80)      
        wdetail.n_text060      =  substr(brstat.tlt.note26,1,20)      
        wdetail.n_text061      =  substr(brstat.tlt.note27,1,60)      
        wdetail.n_text062      =  substr(brstat.tlt.dri_occ2,1,50)   
        wdetail.n_text063      =  substr(brstat.tlt.note4,1,10)         
        wdetail.n_text064      =  substr(brstat.tlt.dri_ic2,1,15)         
        wdetail.n_text065      =  substr(brstat.tlt.dri_lic2,1,15)         
        wdetail.n_text066      =  substr(brstat.tlt.note29,1,20)         
        wdetail.n_text067      =  substr(brstat.tlt.dri_name2,1,80)         
        wdetail.n_text068      =  substr(brstat.tlt.note3,1,20)         
        wdetail.n_text069      =  substr(brstat.tlt.note30,1,60)         
        wdetail.n_text070      =  substr(brstat.tlt.ins_occ,1,50)         
        wdetail.n_text071      =  IF brstat.tlt.birthdate = ? THEN "" ELSE string(brstat.tlt.birthdate,"99/99/9999")              
        wdetail.n_text072      =  substr(brstat.tlt.ins_icno,1,15)           
        wdetail.n_text073      =  substr(brstat.tlt.note1,1,15)                   
        wdetail.n_text074      =  substr(brstat.tlt.ben83,1,80)                   
        wdetail.n_text075      =  string(brstat.tlt.comp_coamt,"99999999999.99")      
        wdetail.n_text076      =  string(brstat.tlt.comp_grprm,"99999999999.99")      
        wdetail.n_text077      =  string(brstat.tlt.mileage,"99999999999.99")         
        wdetail.n_text078      =  string(brstat.tlt.ndeci1,"99999999999.99")          
        wdetail.n_text079      =  string(brstat.tlt.ndeci2,"99999999999.99")          
        wdetail.n_text080      =  string(brstat.tlt.ndeci3,"99999999999.99")          
        wdetail.n_text081      =  string(brstat.tlt.ndeci4,"99999999999.99")          
        wdetail.n_text082      =  string(brstat.tlt.ndeci5,"99999999999.99")          
        wdetail.n_text083      =  string(brstat.tlt.nor_coamt,"99")                    
        wdetail.n_text084      =  string(brstat.tlt.nor_grprm,"99999999999.99")       
        wdetail.n_text085      =  string(brstat.tlt.prem_amt,"99999999999.99")        
        wdetail.n_text086      =  string(brstat.tlt.prem_amttcop,"99")                 
        wdetail.n_text087      =  string(brstat.tlt.rstp,"99999999999.99")            
        wdetail.n_text088      =  string(brstat.tlt.rtax,"99999999999.99")            
        wdetail.n_text089      =  string(brstat.tlt.tax_coporate,"99999999999.99")    
        wdetail.n_text090      =  substr(brstat.tlt.note5,1,6)            
        wdetail.n_text091      =  substr(brstat.tlt.note6,1,10)        
        wdetail.n_text092      =  substr(brstat.tlt.note7,1,10)        
        wdetail.n_text093      =  substr(brstat.tlt.note8,1,30)        
        wdetail.n_text094      =  substr(brstat.tlt.note9,1,80)        
        wdetail.n_text095      =  substr(brstat.tlt.noteveh1,1,10)        
        wdetail.n_text096      =  substr(brstat.tlt.noteveh2,1,30)        
        wdetail.n_text097      =  substr(brstat.tlt.old_cha,1,12)        
        wdetail.n_text098      =  substr(brstat.tlt.old_eng,1,3)             
        wdetail.n_text099      =  substr(brstat.tlt.pack,1,10)      
        wdetail.n_text100      =  substr(brstat.tlt.packnme,1,14)      
        wdetail.n_text101      =  substr(brstat.tlt.period,1,10)      
        wdetail.n_text102      =  substr(brstat.tlt.ln_note1,1,14) 
        wdetail.n_text103      =  substr(brstat.tlt.product,1,10)   
        wdetail.n_text104      =  substr(brstat.tlt.projnme,1,14)   
        wdetail.n_text105      =  substr(brstat.tlt.proveh,1,10)   
        wdetail.n_text106      =  substr(brstat.tlt.race,1,14)   
        wdetail.n_text107      =  substr(brstat.tlt.recac,1,10)   
        wdetail.n_text108      =  substr(brstat.tlt.rec_addr,1,14)   
        wdetail.n_text109      =  substr(brstat.tlt.rec_addr1,1,15)   
        wdetail.n_text110      =  substr(brstat.tlt.rec_addr2,1,10)   
        wdetail.n_text111      =  substr(brstat.tlt.rec_addr3,1,14)   
        wdetail.n_text112      =  substr(brstat.tlt.rec_addr4,1,10)   
        wdetail.n_text113      =  substr(brstat.tlt.rec_addr5,1,20)   
        wdetail.n_text114      =  substr(brstat.tlt.rec_brins,1,1)         
        wdetail.n_text115      =  substr(brstat.tlt.rec_cou,1,120)      
        wdetail.n_text116      =  substr(brstat.tlt.rec_icno,1,100)      
        wdetail.n_text117      =  substr(brstat.tlt.rec_name,1,2)         
        wdetail.n_text118      =  substr(brstat.tlt.rec_name2,1,2)         
        wdetail.n_text119      =  substr(brstat.tlt.rec_note1,1,10)        
        wdetail.n_text120      =  substr(brstat.tlt.rec_note2,1,1)        
        wdetail.n_text121      =  substr(brstat.tlt.rec_title,1,10)        
        wdetail.n_text122      =  substr(brstat.tlt.rec_typ,1,255)       
        wdetail.n_text123      =  substr(brstat.tlt.rider,1,5)         
        wdetail.n_text124      =  substr(brstat.tlt.safe1,1,20)        
        wdetail.n_text125      =  substr(brstat.tlt.safe2,1,10)        
        wdetail.n_text126      =  substr(brstat.tlt.safe3,1,150)       
        wdetail.n_text127      =  substr(brstat.tlt.sex,1,15)        
        wdetail.n_text128      =  substr(brstat.tlt.stat,1,250)       
        wdetail.n_text129      =  substr(brstat.tlt.subins,1,13)        
        wdetail.n_text130      =  substr(brstat.tlt.tel,1,10)        
        wdetail.n_text131      =  substr(brstat.tlt.tel2,1,150)      
        wdetail.n_text132      =  substr(brstat.tlt.tel3,1,15)       
        wdetail.n_text133      =  substr(brstat.tlt.usrid,1,250)       
        wdetail.n_text134      =  substr(brstat.tlt.usrsent,1,13)       
        wdetail.n_text135      =  substr(brstat.tlt.ln_product,1,10)     
        wdetail.n_text136      =  substr(brstat.tlt.ln_pronme,1,150)    
        wdetail.n_text137      =  substr(brstat.tlt.ln_rate,1,15)     
        wdetail.n_text138      =  substr(brstat.tlt.ln_st,1,250)    
        wdetail.n_text139      =  substr(brstat.tlt.lotno,1,13)    
        wdetail.n_text140      =  substr(brstat.tlt.maritalsts,1,10)    
        wdetail.n_text141      =  substr(brstat.tlt.campaign,1,12)    
        wdetail.n_text142      =  substr(brstat.tlt.mobile,1,10)     
        wdetail.n_text143      =  brstat.tlt.acno1   
        wdetail.n_text144      =  brstat.tlt.agent  .

END. 
END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_reportfielsts1 c-wins 
PROCEDURE pd_reportfielsts1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
IF fi_report = "" THEN DO:
    MESSAGE "ʶҹ� �繤����ҧ " VIEW-AS ALERT-BOX.
    
END.
ELSE DO:
    FOR EACH wproducer NO-LOCK.
        For each tlt Use-index  tlt06 Where
            tlt.trndat >=  fi_trndatfr     And
            tlt.trndat <=  fi_trndatto     AND 
            /*tlt.acno1 =  trim(fi_producer) AND*/
            tlt.acno1   =  wproducer.producer  AND 
            tlt.genusr  =  "HCT"               And
            brstat.tlt.releas =  trim(fi_report) NO-LOCK 
            BREAK BY brstat.tlt.comp_noti_ins :
            IF      nv_typre = "V70" AND brstat.tlt.nor_usr_ins  = "0" THEN NEXT.
            ELSE IF nv_typre = "V72" AND brstat.tlt.nor_usr_ins <> "0" THEN NEXT.
            CREATE  wdetail.
            ASSIGN 
            wdetail.n_text001      =  brstat.tlt.comp_noti_ins  
            wdetail.n_text002      =  brstat.tlt.comp_noti_tlt  
            wdetail.n_text003      =  brstat.tlt.comp_pol       
            wdetail.n_text004      =  string(brstat.tlt.nor_effdat,"99/99/9999")     
            wdetail.n_text005      =  string(brstat.tlt.comp_effdat,"99/99/9999")    
            wdetail.n_text006      =  brstat.tlt.comp_sub       
            wdetail.n_text007      =  brstat.tlt.cifno          
            wdetail.n_text008      =  brstat.tlt.nationality    
            wdetail.n_text009      =  brstat.tlt.nor_noti_ins   
            wdetail.n_text010      =  brstat.tlt.nor_noti_tlt   
            wdetail.n_text011      =  brstat.tlt.nor_usr_ins    
            wdetail.n_text012      =  brstat.tlt.covcod         
            wdetail.n_text013      =  brstat.tlt.nor_usr_tlt    
            wdetail.n_text014      =  brstat.tlt.comp_usr_ins   
            wdetail.n_text015      =  brstat.tlt.ins_title      
            wdetail.n_text016      =  brstat.tlt.ins_name       
            wdetail.n_text017      =  brstat.tlt.ins_firstname  
            wdetail.n_text018      =  brstat.tlt.ins_lastname   
            wdetail.n_text019      =  brstat.tlt.ins_addr       
            wdetail.n_text020      =  brstat.tlt.ins_addr1      
            wdetail.n_text021      =  brstat.tlt.ins_addr2      
            wdetail.n_text022      =  brstat.tlt.ins_addr3      
            wdetail.n_text023      =  brstat.tlt.lince2         
            wdetail.n_text024      =  brstat.tlt.ins_addr5      
            wdetail.n_text025      =  brstat.tlt.dir_occ1       
            wdetail.n_text026      =  brstat.tlt.note28         
            wdetail.n_text027      =  brstat.tlt.dri_ic1        
            wdetail.n_text028      =  brstat.tlt.dri_lic1       
            wdetail.n_text029      =  brstat.tlt.brand          
            wdetail.n_text030      =  substr(brstat.tlt.note10,1,1)         
            wdetail.n_text031      =  substr(brstat.tlt.cha_no,1,25)      
            wdetail.n_text032      =  substr(brstat.tlt.eng_no,1,20)                   
            wdetail.n_text033      =  substr(brstat.tlt.model,1,40)                 
            wdetail.n_text034      =  substr(brstat.tlt.note11,1,4)                  
            wdetail.n_text035      =  substr(brstat.tlt.note12,1,20)                  
            wdetail.n_text036      =  substr(brstat.tlt.note13,1,40)                  
            wdetail.n_text037      =  substr(brstat.tlt.note14,1,1)                   
            wdetail.n_text038      =  substr(brstat.tlt.vehuse,1,2)                   
            wdetail.n_text039      =  string(brstat.tlt.seqno,"99")                        
            wdetail.n_text040      =  string(brstat.tlt.cc_weight,"9999")                  
            wdetail.n_text041      =  substr(brstat.tlt.colorcod,1,40)        
            wdetail.n_text042      =  substr(brstat.tlt.lince1,1,10)        
            wdetail.n_text043      =  substr(brstat.tlt.ins_addr4,1,30)        
            wdetail.n_text044      =  substr(brstat.tlt.note15,1,4)         
            wdetail.n_text045      =  substr(brstat.tlt.note16,1,512)              
            wdetail.n_text046      =  substr(brstat.tlt.note17,1,14)        
            wdetail.n_text047      =  substr(brstat.tlt.note18,1,14)       
            wdetail.n_text048      =  substr(brstat.tlt.note19,1,14)          
            wdetail.n_text049      =  substr(brstat.tlt.note2,1,14)          
            wdetail.n_text050      =  substr(brstat.tlt.note20,1,14)       
            wdetail.n_text051      =  substr(brstat.tlt.note21,1,14)          
            wdetail.n_text052      =  substr(brstat.tlt.note22,1,14)        
            wdetail.n_text053      =  substr(brstat.tlt.note23,1,14)        
            wdetail.n_text054      =  substr(brstat.tlt.comp_sck,1,20)        
            wdetail.n_text055      =  substr(brstat.tlt.note24,1,32)        
            wdetail.n_text056      =  substr(brstat.tlt.dri_no1,1,1)        
            wdetail.n_text057      =  substr(brstat.tlt.dri_no2,1,1)         
            wdetail.n_text058      =  substr(brstat.tlt.note25,1,20)      
            wdetail.n_text059      =  substr(brstat.tlt.dri_name1,1,80)      
            wdetail.n_text060      =  substr(brstat.tlt.note26,1,20)      
            wdetail.n_text061      =  substr(brstat.tlt.note27,1,60)      
            wdetail.n_text062      =  substr(brstat.tlt.dri_occ2,1,50)   
            wdetail.n_text063      =  substr(brstat.tlt.note4,1,10)         
            wdetail.n_text064      =  substr(brstat.tlt.dri_ic2,1,15)         
            wdetail.n_text065      =  substr(brstat.tlt.dri_lic2,1,15)         
            wdetail.n_text066      =  substr(brstat.tlt.note29,1,20)         
            wdetail.n_text067      =  substr(brstat.tlt.dri_name2,1,80)         
            wdetail.n_text068      =  substr(brstat.tlt.note3,1,20)         
            wdetail.n_text069      =  substr(brstat.tlt.note30,1,60)         
            wdetail.n_text070      =  substr(brstat.tlt.ins_occ,1,50)         
            wdetail.n_text071      =  IF brstat.tlt.birthdate = ? THEN "" ELSE string(brstat.tlt.birthdate,"99/99/9999")              
            wdetail.n_text072      =  substr(brstat.tlt.ins_icno,1,15)           
            wdetail.n_text073      =  substr(brstat.tlt.note1,1,15)                   
            wdetail.n_text074      =  substr(brstat.tlt.ben83,1,80)                   
            wdetail.n_text075      =  string(brstat.tlt.comp_coamt,"99999999999.99")      
            wdetail.n_text076      =  string(brstat.tlt.comp_grprm,"99999999999.99")      
            wdetail.n_text077      =  string(brstat.tlt.mileage,"99999999999.99")         
            wdetail.n_text078      =  string(brstat.tlt.ndeci1,"99999999999.99")          
            wdetail.n_text079      =  string(brstat.tlt.ndeci2,"99999999999.99")          
            wdetail.n_text080      =  string(brstat.tlt.ndeci3,"99999999999.99")          
            wdetail.n_text081      =  string(brstat.tlt.ndeci4,"99999999999.99")          
            wdetail.n_text082      =  string(brstat.tlt.ndeci5,"99999999999.99")          
            wdetail.n_text083      =  string(brstat.tlt.nor_coamt,"99")                    
            wdetail.n_text084      =  string(brstat.tlt.nor_grprm,"99999999999.99")       
            wdetail.n_text085      =  string(brstat.tlt.prem_amt,"99999999999.99")        
            wdetail.n_text086      =  string(brstat.tlt.prem_amttcop,"99")                 
            wdetail.n_text087      =  string(brstat.tlt.rstp,"99999999999.99")            
            wdetail.n_text088      =  string(brstat.tlt.rtax,"99999999999.99")            
            wdetail.n_text089      =  string(brstat.tlt.tax_coporate,"99999999999.99")    
            wdetail.n_text090      =  substr(brstat.tlt.note5,1,6)            
            wdetail.n_text091      =  substr(brstat.tlt.note6,1,10)        
            wdetail.n_text092      =  substr(brstat.tlt.note7,1,10)        
            wdetail.n_text093      =  substr(brstat.tlt.note8,1,30)        
            wdetail.n_text094      =  substr(brstat.tlt.note9,1,80)        
            wdetail.n_text095      =  substr(brstat.tlt.noteveh1,1,10)        
            wdetail.n_text096      =  substr(brstat.tlt.noteveh2,1,30)        
            wdetail.n_text097      =  substr(brstat.tlt.old_cha,1,12)        
            wdetail.n_text098      =  substr(brstat.tlt.old_eng,1,3)             
            wdetail.n_text099      =  substr(brstat.tlt.pack,1,10)      
            wdetail.n_text100      =  substr(brstat.tlt.packnme,1,14)      
            wdetail.n_text101      =  substr(brstat.tlt.period,1,10)      
            wdetail.n_text102      =  substr(brstat.tlt.ln_note1,1,14) 
            wdetail.n_text103      =  substr(brstat.tlt.product,1,10)   
            wdetail.n_text104      =  substr(brstat.tlt.projnme,1,14)   
            wdetail.n_text105      =  substr(brstat.tlt.proveh,1,10)   
            wdetail.n_text106      =  substr(brstat.tlt.race,1,14)   
            wdetail.n_text107      =  substr(brstat.tlt.recac,1,10)   
            wdetail.n_text108      =  substr(brstat.tlt.rec_addr,1,14)   
            wdetail.n_text109      =  substr(brstat.tlt.rec_addr1,1,15)   
            wdetail.n_text110      =  substr(brstat.tlt.rec_addr2,1,10)   
            wdetail.n_text111      =  substr(brstat.tlt.rec_addr3,1,14)   
            wdetail.n_text112      =  substr(brstat.tlt.rec_addr4,1,10)   
            wdetail.n_text113      =  substr(brstat.tlt.rec_addr5,1,20)   
            wdetail.n_text114      =  substr(brstat.tlt.rec_brins,1,1)         
            wdetail.n_text115      =  substr(brstat.tlt.rec_cou,1,120)      
            wdetail.n_text116      =  substr(brstat.tlt.rec_icno,1,100)      
            wdetail.n_text117      =  substr(brstat.tlt.rec_name,1,2)         
            wdetail.n_text118      =  substr(brstat.tlt.rec_name2,1,2)         
            wdetail.n_text119      =  substr(brstat.tlt.rec_note1,1,10)        
            wdetail.n_text120      =  substr(brstat.tlt.rec_note2,1,1)        
            wdetail.n_text121      =  substr(brstat.tlt.rec_title,1,10)        
            wdetail.n_text122      =  substr(brstat.tlt.rec_typ,1,255)       
            wdetail.n_text123      =  substr(brstat.tlt.rider,1,5)         
            wdetail.n_text124      =  substr(brstat.tlt.safe1,1,20)        
            wdetail.n_text125      =  substr(brstat.tlt.safe2,1,10)        
            wdetail.n_text126      =  substr(brstat.tlt.safe3,1,150)       
            wdetail.n_text127      =  substr(brstat.tlt.sex,1,15)        
            wdetail.n_text128      =  substr(brstat.tlt.stat,1,250)       
            wdetail.n_text129      =  substr(brstat.tlt.subins,1,13)        
            wdetail.n_text130      =  substr(brstat.tlt.tel,1,10)        
            wdetail.n_text131      =  substr(brstat.tlt.tel2,1,150)      
            wdetail.n_text132      =  substr(brstat.tlt.tel3,1,15)       
            wdetail.n_text133      =  substr(brstat.tlt.usrid,1,250)       
            wdetail.n_text134      =  substr(brstat.tlt.usrsent,1,13)       
            wdetail.n_text135      =  substr(brstat.tlt.ln_product,1,10)     
            wdetail.n_text136      =  substr(brstat.tlt.ln_pronme,1,150)    
            wdetail.n_text137      =  substr(brstat.tlt.ln_rate,1,15)     
            wdetail.n_text138      =  substr(brstat.tlt.ln_st,1,250)    
            wdetail.n_text139      =  substr(brstat.tlt.lotno,1,13)    
            wdetail.n_text140      =  substr(brstat.tlt.maritalsts,1,10)    
            wdetail.n_text141      =  substr(brstat.tlt.campaign,1,12)    
            wdetail.n_text142      =  substr(brstat.tlt.mobile,1,10)    
            wdetail.n_text143      =  brstat.tlt.acno1   
            wdetail.n_text144      =  brstat.tlt.agent  .
        END.
    END.
END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_reportfielSwitch c-wins 
PROCEDURE pd_reportfielSwitch :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 
For each tlt Use-index  tlt06 Where
            tlt.trndat >=  fi_trndatfr    And
            tlt.trndat <=  fi_trndatto    AND 
            tlt.genusr   =  "HCT"         And
            tlt.rec_note2  = "S"       NO-LOCK 
    BREAK BY brstat.tlt.comp_noti_ins :

    IF      nv_typre = "V70" AND brstat.tlt.nor_usr_ins  = "0" THEN NEXT.
    ELSE IF nv_typre = "V72" AND brstat.tlt.nor_usr_ins <> "0" THEN NEXT.

    CREATE  wdetail.
    ASSIGN 
    wdetail.n_text001      =  brstat.tlt.comp_noti_ins  
    wdetail.n_text002      =  brstat.tlt.comp_noti_tlt  
    wdetail.n_text003      =  brstat.tlt.comp_pol       
    wdetail.n_text004      =  string(brstat.tlt.nor_effdat,"99/99/9999")     
    wdetail.n_text005      =  string(brstat.tlt.comp_effdat,"99/99/9999")    
    wdetail.n_text006      =  brstat.tlt.comp_sub       
    wdetail.n_text007      =  brstat.tlt.cifno          
    wdetail.n_text008      =  brstat.tlt.nationality    
    wdetail.n_text009      =  brstat.tlt.nor_noti_ins   
    wdetail.n_text010      =  brstat.tlt.nor_noti_tlt   
    wdetail.n_text011      =  brstat.tlt.nor_usr_ins    
    wdetail.n_text012      =  brstat.tlt.covcod         
    wdetail.n_text013      =  brstat.tlt.nor_usr_tlt    
    wdetail.n_text014      =  brstat.tlt.comp_usr_ins   
    wdetail.n_text015      =  brstat.tlt.ins_title      
    wdetail.n_text016      =  brstat.tlt.ins_name       
    wdetail.n_text017      =  brstat.tlt.ins_firstname  
    wdetail.n_text018      =  brstat.tlt.ins_lastname   
    wdetail.n_text019      =  brstat.tlt.ins_addr       
    wdetail.n_text020      =  brstat.tlt.ins_addr1      
    wdetail.n_text021      =  brstat.tlt.ins_addr2      
    wdetail.n_text022      =  brstat.tlt.ins_addr3      
    wdetail.n_text023      =  brstat.tlt.lince2         
    wdetail.n_text024      =  brstat.tlt.ins_addr5      
    wdetail.n_text025      =  brstat.tlt.dir_occ1       
    wdetail.n_text026      =  brstat.tlt.note28         
    wdetail.n_text027      =  brstat.tlt.dri_ic1        
    wdetail.n_text028      =  brstat.tlt.dri_lic1       
    wdetail.n_text029      =  brstat.tlt.brand          
    wdetail.n_text030      =  substr(brstat.tlt.note10,1,1)         
    wdetail.n_text031      =  substr(brstat.tlt.cha_no,1,25)      
    wdetail.n_text032      =  substr(brstat.tlt.eng_no,1,20)                   
    wdetail.n_text033      =  substr(brstat.tlt.model,1,40)                 
    wdetail.n_text034      =  substr(brstat.tlt.note11,1,4)                  
    wdetail.n_text035      =  substr(brstat.tlt.note12,1,20)                  
    wdetail.n_text036      =  substr(brstat.tlt.note13,1,40)                  
    wdetail.n_text037      =  substr(brstat.tlt.note14,1,1)                   
    /*wdetail.n_text038      =  substr(brstat.tlt.vehuse,1,2) */ /* A68-0061*/
    wdetail.n_text038      =  IF rs_typre = 1 THEN substr(brstat.tlt.vehuse,1,2) ELSE TRIM(brstat.tlt.vehuse)  /* A68-0061*/                   
    wdetail.n_text039      =  string(brstat.tlt.seqno,"99")                        
    wdetail.n_text040      =  string(brstat.tlt.cc_weight,"9999")                  
    wdetail.n_text041      =  substr(brstat.tlt.colorcod,1,40)        
    wdetail.n_text042      =  substr(brstat.tlt.lince1,1,10)        
    wdetail.n_text043      =  substr(brstat.tlt.ins_addr4,1,30)        
    wdetail.n_text044      =  substr(brstat.tlt.note15,1,4)         
    wdetail.n_text045      =  substr(brstat.tlt.note16,1,512)              
    wdetail.n_text046      =  substr(brstat.tlt.note17,1,14)        
    wdetail.n_text047      =  substr(brstat.tlt.note18,1,14)       
    wdetail.n_text048      =  substr(brstat.tlt.note19,1,14)          
    wdetail.n_text049      =  substr(brstat.tlt.note2,1,14)          
    wdetail.n_text050      =  substr(brstat.tlt.note20,1,14)       
    wdetail.n_text051      =  substr(brstat.tlt.note21,1,14)          
    wdetail.n_text052      =  substr(brstat.tlt.note22,1,14)        
    wdetail.n_text053      =  substr(brstat.tlt.note23,1,14)        
    wdetail.n_text054      =  substr(brstat.tlt.comp_sck,1,20)        
    wdetail.n_text055      =  substr(brstat.tlt.note24,1,32)        
    wdetail.n_text056      =  substr(brstat.tlt.dri_no1,1,1)        
    wdetail.n_text057      =  substr(brstat.tlt.dri_no2,1,1)         
    wdetail.n_text058      =  substr(brstat.tlt.note25,1,20)      
    wdetail.n_text059      =  substr(brstat.tlt.dri_name1,1,80)      
    wdetail.n_text060      =  substr(brstat.tlt.note26,1,20)      
    wdetail.n_text061      =  substr(brstat.tlt.note27,1,60)      
    wdetail.n_text062      =  substr(brstat.tlt.dri_occ2,1,50)   
    wdetail.n_text063      =  substr(brstat.tlt.note4,1,10)         
    wdetail.n_text064      =  substr(brstat.tlt.dri_ic2,1,15)         
    wdetail.n_text065      =  substr(brstat.tlt.dri_lic2,1,15)         
    wdetail.n_text066      =  substr(brstat.tlt.note29,1,20)         
    wdetail.n_text067      =  substr(brstat.tlt.dri_name2,1,80)         
    wdetail.n_text068      =  substr(brstat.tlt.note3,1,20)         
    wdetail.n_text069      =  substr(brstat.tlt.note30,1,60)         
    wdetail.n_text070      =  substr(brstat.tlt.ins_occ,1,50)         
    wdetail.n_text071      =  IF brstat.tlt.birthdate = ? THEN "" ELSE string(brstat.tlt.birthdate,"99/99/9999")              
    wdetail.n_text072      =  substr(brstat.tlt.ins_icno,1,15)           
    wdetail.n_text073      =  substr(brstat.tlt.note1,1,15)                   
    wdetail.n_text074      =  substr(brstat.tlt.ben83,1,80)                   
    wdetail.n_text075      =  string(brstat.tlt.comp_coamt,"99999999999.99")      
    wdetail.n_text076      =  string(brstat.tlt.comp_grprm,"99999999999.99")      
    wdetail.n_text077      =     string(brstat.tlt.mileage,"99999999999.99")         
    wdetail.n_text078      =      string(brstat.tlt.ndeci1,"99999999999.99")          
    wdetail.n_text079      =      string(brstat.tlt.ndeci2,"99999999999.99")          
    wdetail.n_text080      =      string(brstat.tlt.ndeci3,"99999999999.99")          
    wdetail.n_text081      =      string(brstat.tlt.ndeci4,"99999999999.99")          
    wdetail.n_text082      =      string(brstat.tlt.ndeci5,"99999999999.99")          
    wdetail.n_text083      =   string(brstat.tlt.nor_coamt,"99")                    
    wdetail.n_text084      =   string(brstat.tlt.nor_grprm,"99999999999.99")       
    wdetail.n_text085      =    string(brstat.tlt.prem_amt,"99999999999.99")        
    wdetail.n_text086     = string(brstat.tlt.prem_amttcop,"99")                 
    wdetail.n_text087      =        string(brstat.tlt.rstp,"99999999999.99")            
    wdetail.n_text088      =        string(brstat.tlt.rtax,"99999999999.99")            
    wdetail.n_text089     = string(brstat.tlt.tax_coporate,"99999999999.99")    
    wdetail.n_text090      =  substr(brstat.tlt.note5,1,6)            
    wdetail.n_text091      =  substr(brstat.tlt.note6,1,10)        
    wdetail.n_text092      =  substr(brstat.tlt.note7,1,10)        
    wdetail.n_text093      =  substr(brstat.tlt.note8,1,30)        
    wdetail.n_text094      =  substr(brstat.tlt.note9,1,80)        
    wdetail.n_text095      =  substr(brstat.tlt.noteveh1,1,10)        
    wdetail.n_text096      =  substr(brstat.tlt.noteveh2,1,30)        
    wdetail.n_text097      =  substr(brstat.tlt.old_cha,1,12)        
    wdetail.n_text098      =  substr(brstat.tlt.old_eng,1,3)             
    wdetail.n_text099      =  substr(brstat.tlt.pack,1,10)      
    wdetail.n_text100      =  substr(brstat.tlt.packnme,1,14)      
    wdetail.n_text101      =  substr(brstat.tlt.period,1,10)      
    wdetail.n_text102      =  substr(brstat.tlt.ln_note1,1,14) 
    wdetail.n_text103      =  substr(brstat.tlt.product,1,10)   
    wdetail.n_text104      =  substr(brstat.tlt.projnme,1,14)   
    wdetail.n_text105      =  substr(brstat.tlt.proveh,1,10)   
    wdetail.n_text106      =  substr(brstat.tlt.race,1,14)   
    wdetail.n_text107      =  substr(brstat.tlt.recac,1,10)   
    wdetail.n_text108      =  substr(brstat.tlt.rec_addr,1,14)   
    wdetail.n_text109      =  substr(brstat.tlt.rec_addr1,1,15)   
    wdetail.n_text110      =  substr(brstat.tlt.rec_addr2,1,10)   
    wdetail.n_text111      =  substr(brstat.tlt.rec_addr3,1,14)   
    wdetail.n_text112      =  substr(brstat.tlt.rec_addr4,1,10)   
    wdetail.n_text113      =  substr(brstat.tlt.rec_addr5,1,20)   
    wdetail.n_text114      =  substr(brstat.tlt.rec_brins,1,1)         
    wdetail.n_text115      =  substr(brstat.tlt.rec_cou,1,120)      
    wdetail.n_text116      =  substr(brstat.tlt.rec_icno,1,100)      
    wdetail.n_text117      =  substr(brstat.tlt.rec_name,1,2)         
    wdetail.n_text118      =  substr(brstat.tlt.rec_name2,1,2)         
    wdetail.n_text119      =  substr(brstat.tlt.rec_note1,1,10)        
    wdetail.n_text120      =  substr(brstat.tlt.rec_note2,1,1)        
    wdetail.n_text121      =  substr(brstat.tlt.rec_title,1,10)        
    wdetail.n_text122      =  substr(brstat.tlt.rec_typ,1,255)       
    wdetail.n_text123      =  substr(brstat.tlt.rider,1,5)         
    wdetail.n_text124      =  substr(brstat.tlt.safe1,1,20)        
    wdetail.n_text125      =  substr(brstat.tlt.safe2,1,10)        
    wdetail.n_text126      =  substr(brstat.tlt.safe3,1,150)       
    wdetail.n_text127      =  substr(brstat.tlt.sex,1,15)        
    wdetail.n_text128      =  substr(brstat.tlt.stat,1,250)       
    wdetail.n_text129      =  substr(brstat.tlt.subins,1,13)        
    wdetail.n_text130      =  substr(brstat.tlt.tel,1,10)        
    wdetail.n_text131      =  substr(brstat.tlt.tel2,1,150)      
    wdetail.n_text132      =  substr(brstat.tlt.tel3,1,15)       
    wdetail.n_text133      =  substr(brstat.tlt.usrid,1,250)       
    wdetail.n_text134      =  substr(brstat.tlt.usrsent,1,13)       
    wdetail.n_text135      =  substr(brstat.tlt.ln_product,1,10)     
    wdetail.n_text136      =  substr(brstat.tlt.ln_pronme,1,150)    
    wdetail.n_text137      =  substr(brstat.tlt.ln_rate,1,15)     
    wdetail.n_text138      =  substr(brstat.tlt.ln_st,1,250)    
    wdetail.n_text139      =  substr(brstat.tlt.lotno,1,13)    
    wdetail.n_text140      =  substr(brstat.tlt.maritalsts,1,10)    
    wdetail.n_text141      =  substr(brstat.tlt.campaign,1,12)    
    wdetail.n_text142      =  substr(brstat.tlt.mobile,1,10)    
    wdetail.n_text143      =  brstat.tlt.acno1   
    wdetail.n_text144      =  brstat.tlt.agent  .
    /* ADD BY : A68-0061 */
    ASSIGN 
    wdetail.typepol    =   brstat.tlt.poltyp
    wdetail.typecar    =   brstat.tlt.car_type
    wdetail.maksi      =   STRING(brstat.tlt.maksi)
    wdetail.drivexp1   =   brstat.tlt.dri_licenexp1
    wdetail.drivcon1   =   string(brstat.tlt.dri_consen1)
    wdetail.dlevel1    =   string(brstat.tlt.dri_level1)
    wdetail.dgender1   =   brstat.tlt.dri_gender1
    wdetail.drivexp2   =   brstat.tlt.dri_licenexp2
    wdetail.drivcon2   =   string(brstat.tlt.dri_consen2)
    wdetail.dlevel2    =   string(brstat.tlt.dri_level2)
    wdetail.dgender2   =   brstat.tlt.dri_gender2
    wdetail.ntitle3    =   brstat.tlt.dri_title3
    wdetail.dname3     =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,1,INDEX(brstat.tlt.dri_fname3," ") - 1) ELSE TRIM(brstat.tlt.dri_fname3)
    wdetail.dcname3    =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,R-INDEX(brstat.tlt.dri_fname3," ")) ELSE "" 
    wdetail.dlname3    =   brstat.tlt.dri_lname3
    wdetail.doccup3    =   brstat.tlt.dir_occ3
    wdetail.dbirth3    =   brstat.tlt.dri_birth3
    wdetail.dicno3     =   brstat.tlt.dri_ic3
    wdetail.ddriveno3  =   brstat.tlt.dri_lic3
    wdetail.drivexp3   =   brstat.tlt.dri_licenexp3
    wdetail.drivcon3   =   string(brstat.tlt.dri_consen3)
    wdetail.dlevel3    =   string(brstat.tlt.dri_level3)
    wdetail.dgender3   =   brstat.tlt.dri_gender3
    wdetail.ntitle4    =   brstat.tlt.dri_title4
    wdetail.dname4     =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,1,INDEX(brstat.tlt.dri_fname4," ") - 1) ELSE TRIM(brstat.tlt.dri_fname4)
    wdetail.dcname4    =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,R-INDEX(brstat.tlt.dri_fname4," ")) ELSE ""
    wdetail.dlname4    =   brstat.tlt.dri_lname4
    wdetail.doccup4    =   brstat.tlt.dri_occ4
    wdetail.dbirth4    =   brstat.tlt.dri_birth4
    wdetail.dicno4     =   brstat.tlt.dri_ic4
    wdetail.ddriveno4  =   brstat.tlt.dri_lic4
    wdetail.drivexp4   =   brstat.tlt.dri_licenexp4
    wdetail.drivcon4   =   string(brstat.tlt.dri_consen4)
    wdetail.dlevel4    =   string(brstat.tlt.dri_level4)
    wdetail.dgender4   =   brstat.tlt.dri_gender4
    wdetail.ntitle5    =   brstat.tlt.dri_title5
    wdetail.dname5     =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,1,INDEX(brstat.tlt.dri_fname5," ") - 1) ELSE TRIM(brstat.tlt.dri_fname5)
    wdetail.dcname5    =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,R-INDEX(brstat.tlt.dri_fname5," ")) ELSE "" 
    wdetail.dlname5    =   brstat.tlt.dri_lname5
    wdetail.doccup5    =   brstat.tlt.dri_occ5
    wdetail.dbirth5    =   brstat.tlt.dri_birth5
    wdetail.dicno5     =   brstat.tlt.dri_ic5
    wdetail.ddriveno5  =   brstat.tlt.dri_lic5
    wdetail.drivexp5   =   brstat.tlt.dri_licenexp5
    wdetail.drivcon5   =   string(brstat.tlt.dri_consen5)
    wdetail.dlevel5    =   string(brstat.tlt.dri_level5)
    wdetail.dgender5   =   brstat.tlt.dri_gender5  
    wdetail.chargflg    =  STRING(brstat.tlt.chargflg)
    wdetail.chargprice  =  STRING(brstat.tlt.chargsi)
    wdetail.chargno     =  brstat.tlt.chargno
    wdetail.chargprm    =  string(brstat.tlt.chargprem)
    wdetail.battflg     =  string(brstat.tlt.battflg  )
    wdetail.battprice   =  string(brstat.tlt.battprice)
    wdetail.battno      =  brstat.tlt.battno
    wdetail.battprm     =  string(brstat.tlt.battprem)
    wdetail.battdate    =  string(brstat.tlt.ndate1,"99/99/9999")
    wdetail.net_re1     =  string(brstat.tlt.dg_prem)
    wdetail.stam_re1    =  string(brstat.tlt.dg_rstp_t)
    wdetail.vat_re1     =  string(brstat.tlt.dg_rtax_t)
    wdetail.inscode_re2 =  brstat.tlt.ins_code
    wdetail.net_re2     =  string(brstat.tlt.dg_si  )
    wdetail.stam_re2    =  string(brstat.tlt.dg_rate)
    wdetail.vat_re2     =  string(brstat.tlt.dg_feet)
    wdetail.inscode_re3 =  brstat.tlt.Paycode
    wdetail.net_re3     =  string(brstat.tlt.dg_ncb  )
    wdetail.stam_re3    =  string(brstat.tlt.dg_disc )
    wdetail.vat_re3     =  string(brstat.tlt.dg_wdisc) .
 /* END : A68-0061 */

END. 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_reportfielSwitch1 c-wins 
PROCEDURE pd_reportfielSwitch1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wproducer NO-LOCK.
    For each tlt Use-index  tlt06 Where
        tlt.trndat >=  fi_trndatfr    And
        tlt.trndat <=  fi_trndatto    AND
        /*tlt.acno1   =  trim(fi_producer) AND*/
        tlt.acno1      =  wproducer.producer  AND 
        tlt.genusr     =  "HCT"         And
        tlt.rec_note2  = "S"       NO-LOCK 
        BREAK BY brstat.tlt.comp_noti_ins :

        IF      nv_typre = "V70" AND brstat.tlt.nor_usr_ins  = "0" THEN NEXT.
        ELSE IF nv_typre = "V72" AND brstat.tlt.nor_usr_ins <> "0" THEN NEXT.

        CREATE  wdetail.
        ASSIGN 
        wdetail.n_text001      =  brstat.tlt.comp_noti_ins  
        wdetail.n_text002      =  brstat.tlt.comp_noti_tlt  
        wdetail.n_text003      =  brstat.tlt.comp_pol       
        wdetail.n_text004      =  string(brstat.tlt.nor_effdat,"99/99/9999")     
        wdetail.n_text005      =  string(brstat.tlt.comp_effdat,"99/99/9999")    
        wdetail.n_text006      =  brstat.tlt.comp_sub       
        wdetail.n_text007      =  brstat.tlt.cifno          
        wdetail.n_text008      =  brstat.tlt.nationality    
        wdetail.n_text009      =  brstat.tlt.nor_noti_ins   
        wdetail.n_text010      =  brstat.tlt.nor_noti_tlt   
        wdetail.n_text011      =  brstat.tlt.nor_usr_ins    
        wdetail.n_text012      =  brstat.tlt.covcod         
        wdetail.n_text013      =  brstat.tlt.nor_usr_tlt    
        wdetail.n_text014      =  brstat.tlt.comp_usr_ins   
        wdetail.n_text015      =  brstat.tlt.ins_title      
        wdetail.n_text016      =  brstat.tlt.ins_name       
        wdetail.n_text017      =  brstat.tlt.ins_firstname  
        wdetail.n_text018      =  brstat.tlt.ins_lastname   
        wdetail.n_text019      =  brstat.tlt.ins_addr       
        wdetail.n_text020      =  brstat.tlt.ins_addr1      
        wdetail.n_text021      =  brstat.tlt.ins_addr2      
        wdetail.n_text022      =  brstat.tlt.ins_addr3      
        wdetail.n_text023      =  brstat.tlt.lince2         
        wdetail.n_text024      =  brstat.tlt.ins_addr5      
        wdetail.n_text025      =  brstat.tlt.dir_occ1       
        wdetail.n_text026      =  brstat.tlt.note28         
        wdetail.n_text027      =  brstat.tlt.dri_ic1        
        wdetail.n_text028      =  brstat.tlt.dri_lic1       
        wdetail.n_text029      =  brstat.tlt.brand          
        wdetail.n_text030      =  substr(brstat.tlt.note10,1,1)         
        wdetail.n_text031      =  substr(brstat.tlt.cha_no,1,25)      
        wdetail.n_text032      =  substr(brstat.tlt.eng_no,1,20)                   
        wdetail.n_text033      =  substr(brstat.tlt.model,1,40)                 
        wdetail.n_text034      =  substr(brstat.tlt.note11,1,4)                  
        wdetail.n_text035      =  substr(brstat.tlt.note12,1,20)                  
        wdetail.n_text036      =  substr(brstat.tlt.note13,1,40)                  
        wdetail.n_text037      =  substr(brstat.tlt.note14,1,1)                   
        /*wdetail.n_text038      =  substr(brstat.tlt.vehuse,1,2) */ /* A68-0061*/
        wdetail.n_text038      =  IF rs_typre = 1 THEN substr(brstat.tlt.vehuse,1,2) ELSE TRIM(brstat.tlt.vehuse)  /* A68-0061*/
        wdetail.n_text039      =  string(brstat.tlt.seqno,"99")                        
        wdetail.n_text040      =  string(brstat.tlt.cc_weight,"9999")                  
        wdetail.n_text041      =  substr(brstat.tlt.colorcod,1,40)        
        wdetail.n_text042      =  substr(brstat.tlt.lince1,1,10)        
        wdetail.n_text043      =  substr(brstat.tlt.ins_addr4,1,30)        
        wdetail.n_text044      =  substr(brstat.tlt.note15,1,4)         
        wdetail.n_text045      =  substr(brstat.tlt.note16,1,512)              
        wdetail.n_text046      =  substr(brstat.tlt.note17,1,14)        
        wdetail.n_text047      =  substr(brstat.tlt.note18,1,14)       
        wdetail.n_text048      =  substr(brstat.tlt.note19,1,14)          
        wdetail.n_text049      =  substr(brstat.tlt.note2,1,14)          
        wdetail.n_text050      =  substr(brstat.tlt.note20,1,14)       
        wdetail.n_text051      =  substr(brstat.tlt.note21,1,14)          
        wdetail.n_text052      =  substr(brstat.tlt.note22,1,14)        
        wdetail.n_text053      =  substr(brstat.tlt.note23,1,14)        
        wdetail.n_text054      =  substr(brstat.tlt.comp_sck,1,20)        
        wdetail.n_text055      =  substr(brstat.tlt.note24,1,32)        
        wdetail.n_text056      =  substr(brstat.tlt.dri_no1,1,1)        
        wdetail.n_text057      =  substr(brstat.tlt.dri_no2,1,1)         
        wdetail.n_text058      =  substr(brstat.tlt.note25,1,20)      
        wdetail.n_text059      =  substr(brstat.tlt.dri_name1,1,80)      
        wdetail.n_text060      =  substr(brstat.tlt.note26,1,20)      
        wdetail.n_text061      =  substr(brstat.tlt.note27,1,60)      
        wdetail.n_text062      =  substr(brstat.tlt.dri_occ2,1,50)   
        wdetail.n_text063      =  substr(brstat.tlt.note4,1,10)         
        wdetail.n_text064      =  substr(brstat.tlt.dri_ic2,1,15)         
        wdetail.n_text065      =  substr(brstat.tlt.dri_lic2,1,15)         
        wdetail.n_text066      =  substr(brstat.tlt.note29,1,20)         
        wdetail.n_text067      =  substr(brstat.tlt.dri_name2,1,80)         
        wdetail.n_text068      =  substr(brstat.tlt.note3,1,20)         
        wdetail.n_text069      =  substr(brstat.tlt.note30,1,60)         
        wdetail.n_text070      =  substr(brstat.tlt.ins_occ,1,50)         
        wdetail.n_text071      =  IF brstat.tlt.birthdate = ? THEN "" ELSE string(brstat.tlt.birthdate,"99/99/9999")              
        wdetail.n_text072      =  substr(brstat.tlt.ins_icno,1,15)           
        wdetail.n_text073      =  substr(brstat.tlt.note1,1,15)                   
        wdetail.n_text074      =  substr(brstat.tlt.ben83,1,80)                   
        wdetail.n_text075      =  string(brstat.tlt.comp_coamt,"99999999999.99")      
        wdetail.n_text076      =  string(brstat.tlt.comp_grprm,"99999999999.99")      
        wdetail.n_text077      =  string(brstat.tlt.mileage,"99999999999.99")         
        wdetail.n_text078      =  string(brstat.tlt.ndeci1,"99999999999.99")          
        wdetail.n_text079      =  string(brstat.tlt.ndeci2,"99999999999.99")          
        wdetail.n_text080      =  string(brstat.tlt.ndeci3,"99999999999.99")          
        wdetail.n_text081      =  string(brstat.tlt.ndeci4,"99999999999.99")          
        wdetail.n_text082      =  string(brstat.tlt.ndeci5,"99999999999.99")          
        wdetail.n_text083      =  string(brstat.tlt.nor_coamt,"99")                    
        wdetail.n_text084      =  string(brstat.tlt.nor_grprm,"99999999999.99")       
        wdetail.n_text085      =  string(brstat.tlt.prem_amt,"99999999999.99")        
        wdetail.n_text086      =  string(brstat.tlt.prem_amttcop,"99")                 
        wdetail.n_text087      =  string(brstat.tlt.rstp,"99999999999.99")            
        wdetail.n_text088      =  string(brstat.tlt.rtax,"99999999999.99")            
        wdetail.n_text089      =  string(brstat.tlt.tax_coporate,"99999999999.99")    
        wdetail.n_text090      =  substr(brstat.tlt.note5,1,6)            
        wdetail.n_text091      =  substr(brstat.tlt.note6,1,10)        
        wdetail.n_text092      =  substr(brstat.tlt.note7,1,10)        
        wdetail.n_text093      =  substr(brstat.tlt.note8,1,30)        
        wdetail.n_text094      =  substr(brstat.tlt.note9,1,80)        
        wdetail.n_text095      =  substr(brstat.tlt.noteveh1,1,10)        
        wdetail.n_text096      =  substr(brstat.tlt.noteveh2,1,30)        
        wdetail.n_text097      =  substr(brstat.tlt.old_cha,1,12)        
        wdetail.n_text098      =  substr(brstat.tlt.old_eng,1,3)             
        wdetail.n_text099      =  substr(brstat.tlt.pack,1,10)      
        wdetail.n_text100      =  substr(brstat.tlt.packnme,1,14)      
        wdetail.n_text101      =  substr(brstat.tlt.period,1,10)      
        wdetail.n_text102      =  substr(brstat.tlt.ln_note1,1,14) 
        wdetail.n_text103      =  substr(brstat.tlt.product,1,10)   
        wdetail.n_text104      =  substr(brstat.tlt.projnme,1,14)   
        wdetail.n_text105      =  substr(brstat.tlt.proveh,1,10)   
        wdetail.n_text106      =  substr(brstat.tlt.race,1,14)   
        wdetail.n_text107      =  substr(brstat.tlt.recac,1,10)   
        wdetail.n_text108      =  substr(brstat.tlt.rec_addr,1,14)   
        wdetail.n_text109      =  substr(brstat.tlt.rec_addr1,1,15)   
        wdetail.n_text110      =  substr(brstat.tlt.rec_addr2,1,10)   
        wdetail.n_text111      =  substr(brstat.tlt.rec_addr3,1,14)   
        wdetail.n_text112      =  substr(brstat.tlt.rec_addr4,1,10)   
        wdetail.n_text113      =  substr(brstat.tlt.rec_addr5,1,20)   
        wdetail.n_text114      =  substr(brstat.tlt.rec_brins,1,1)         
        wdetail.n_text115      =  substr(brstat.tlt.rec_cou,1,120)      
        wdetail.n_text116      =  substr(brstat.tlt.rec_icno,1,100)      
        wdetail.n_text117      =  substr(brstat.tlt.rec_name,1,2)         
        wdetail.n_text118      =  substr(brstat.tlt.rec_name2,1,2)         
        wdetail.n_text119      =  substr(brstat.tlt.rec_note1,1,10)        
        wdetail.n_text120      =  substr(brstat.tlt.rec_note2,1,1)        
        wdetail.n_text121      =  substr(brstat.tlt.rec_title,1,10)        
        wdetail.n_text122      =  substr(brstat.tlt.rec_typ,1,255)       
        wdetail.n_text123      =  substr(brstat.tlt.rider,1,5)         
        wdetail.n_text124      =  substr(brstat.tlt.safe1,1,20)        
        wdetail.n_text125      =  substr(brstat.tlt.safe2,1,10)        
        wdetail.n_text126      =  substr(brstat.tlt.safe3,1,150)       
        wdetail.n_text127      =  substr(brstat.tlt.sex,1,15)        
        wdetail.n_text128      =  substr(brstat.tlt.stat,1,250)       
        wdetail.n_text129      =  substr(brstat.tlt.subins,1,13)        
        wdetail.n_text130      =  substr(brstat.tlt.tel,1,10)        
        wdetail.n_text131      =  substr(brstat.tlt.tel2,1,150)      
        wdetail.n_text132      =  substr(brstat.tlt.tel3,1,15)       
        wdetail.n_text133      =  substr(brstat.tlt.usrid,1,250)       
        wdetail.n_text134      =  substr(brstat.tlt.usrsent,1,13)       
        wdetail.n_text135      =  substr(brstat.tlt.ln_product,1,10)     
        wdetail.n_text136      =  substr(brstat.tlt.ln_pronme,1,150)    
        wdetail.n_text137      =  substr(brstat.tlt.ln_rate,1,15)     
        wdetail.n_text138      =  substr(brstat.tlt.ln_st,1,250)    
        wdetail.n_text139      =  substr(brstat.tlt.lotno,1,13)    
        wdetail.n_text140      =  substr(brstat.tlt.maritalsts,1,10)    
        wdetail.n_text141      =  substr(brstat.tlt.campaign,1,12)    
        wdetail.n_text142      =  substr(brstat.tlt.mobile,1,10)   
        wdetail.n_text143      =  brstat.tlt.acno1   
        wdetail.n_text144      =  brstat.tlt.agent  .
        /* ADD BY : A68-0061 */
       ASSIGN 
       wdetail.typepol    =   brstat.tlt.poltyp
       wdetail.typecar    =   brstat.tlt.car_type
       wdetail.maksi      =   STRING(brstat.tlt.maksi)
       wdetail.drivexp1   =   brstat.tlt.dri_licenexp1
       wdetail.drivcon1   =   string(brstat.tlt.dri_consen1)
       wdetail.dlevel1    =   string(brstat.tlt.dri_level1)
       wdetail.dgender1   =   brstat.tlt.dri_gender1
       wdetail.drivexp2   =   brstat.tlt.dri_licenexp2
       wdetail.drivcon2   =   string(brstat.tlt.dri_consen2)
       wdetail.dlevel2    =   string(brstat.tlt.dri_level2)
       wdetail.dgender2   =   brstat.tlt.dri_gender2
       wdetail.ntitle3    =   brstat.tlt.dri_title3
       wdetail.dname3     =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,1,INDEX(brstat.tlt.dri_fname3," ") - 1) ELSE TRIM(brstat.tlt.dri_fname3)
       wdetail.dcname3    =   if index(brstat.tlt.dri_fname3," ") <> 0 then substr(brstat.tlt.dri_fname3,R-INDEX(brstat.tlt.dri_fname3," ")) ELSE "" 
       wdetail.dlname3    =   brstat.tlt.dri_lname3
       wdetail.doccup3    =   brstat.tlt.dir_occ3
       wdetail.dbirth3    =   brstat.tlt.dri_birth3
       wdetail.dicno3     =   brstat.tlt.dri_ic3
       wdetail.ddriveno3  =   brstat.tlt.dri_lic3
       wdetail.drivexp3   =   brstat.tlt.dri_licenexp3
       wdetail.drivcon3   =   string(brstat.tlt.dri_consen3)
       wdetail.dlevel3    =   string(brstat.tlt.dri_level3)
       wdetail.dgender3   =   brstat.tlt.dri_gender3
       wdetail.ntitle4    =   brstat.tlt.dri_title4
       wdetail.dname4     =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,1,INDEX(brstat.tlt.dri_fname4," ") - 1) ELSE TRIM(brstat.tlt.dri_fname4)
       wdetail.dcname4    =   if index(brstat.tlt.dri_fname4," ") <> 0 then substr(brstat.tlt.dri_fname4,R-INDEX(brstat.tlt.dri_fname4," ")) ELSE ""
       wdetail.dlname4    =   brstat.tlt.dri_lname4
       wdetail.doccup4    =   brstat.tlt.dri_occ4
       wdetail.dbirth4    =   brstat.tlt.dri_birth4
       wdetail.dicno4     =   brstat.tlt.dri_ic4
       wdetail.ddriveno4  =   brstat.tlt.dri_lic4
       wdetail.drivexp4   =   brstat.tlt.dri_licenexp4
       wdetail.drivcon4   =   string(brstat.tlt.dri_consen4)
       wdetail.dlevel4    =   string(brstat.tlt.dri_level4)
       wdetail.dgender4   =   brstat.tlt.dri_gender4
       wdetail.ntitle5    =   brstat.tlt.dri_title5
       wdetail.dname5     =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,1,INDEX(brstat.tlt.dri_fname5," ") - 1) ELSE TRIM(brstat.tlt.dri_fname5)
       wdetail.dcname5    =   if index(brstat.tlt.dri_fname5," ") <> 0 then substr(brstat.tlt.dri_fname5,R-INDEX(brstat.tlt.dri_fname5," ")) ELSE "" 
       wdetail.dlname5    =   brstat.tlt.dri_lname5
       wdetail.doccup5    =   brstat.tlt.dri_occ5
       wdetail.dbirth5    =   brstat.tlt.dri_birth5
       wdetail.dicno5     =   brstat.tlt.dri_ic5
       wdetail.ddriveno5  =   brstat.tlt.dri_lic5
       wdetail.drivexp5   =   brstat.tlt.dri_licenexp5
       wdetail.drivcon5   =   string(brstat.tlt.dri_consen5)
       wdetail.dlevel5    =   string(brstat.tlt.dri_level5)
       wdetail.dgender5   =   brstat.tlt.dri_gender5  
       wdetail.chargflg    =  STRING(brstat.tlt.chargflg)
       wdetail.chargprice  =  STRING(brstat.tlt.chargsi)
       wdetail.chargno     =  brstat.tlt.chargno
       wdetail.chargprm    =  string(brstat.tlt.chargprem)
       wdetail.battflg     =  string(brstat.tlt.battflg  )
       wdetail.battprice   =  string(brstat.tlt.battprice)
       wdetail.battno      =  brstat.tlt.battno
       wdetail.battprm     =  string(brstat.tlt.battprem)
       wdetail.battdate    =  string(brstat.tlt.ndate1,"99/99/9999")
       wdetail.net_re1     =  string(brstat.tlt.dg_prem)
       wdetail.stam_re1    =  string(brstat.tlt.dg_rstp_t)
       wdetail.vat_re1     =  string(brstat.tlt.dg_rtax_t)
       wdetail.inscode_re2 =  brstat.tlt.ins_code
       wdetail.net_re2     =  string(brstat.tlt.dg_si  )
       wdetail.stam_re2    =  string(brstat.tlt.dg_rate)
       wdetail.vat_re2     =  string(brstat.tlt.dg_feet)
       wdetail.inscode_re3 =  brstat.tlt.Paycode
       wdetail.net_re3     =  string(brstat.tlt.dg_ncb  )
       wdetail.stam_re3    =  string(brstat.tlt.dg_disc )
       wdetail.vat_re3     =  string(brstat.tlt.dg_wdisc) .
       /* END : A68-0061 */
    END.
END. 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_reportfielTXT c-wins 
PROCEDURE pd_reportfielTXT :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
OUTPUT STREAM ns2 TO VALUE(fi_outfile).
For each wdetail   NO-LOCK 
    BREAK BY wdetail.n_text001 :
     
   PUT STREAM NS2 
      wdetail.n_text001 
      wdetail.n_text002 
      wdetail.n_text003 
      wdetail.n_text004 
      wdetail.n_text005 
      wdetail.n_text006 
      wdetail.n_text007 
      wdetail.n_text008 
      wdetail.n_text009 
      wdetail.n_text010 
      wdetail.n_text011 
      wdetail.n_text012 
      wdetail.n_text013 
      wdetail.n_text014 
      wdetail.n_text015 
      wdetail.n_text016 
      wdetail.n_text017 
      wdetail.n_text018 
      wdetail.n_text019 
      wdetail.n_text020 
      wdetail.n_text021 
      wdetail.n_text022 
      wdetail.n_text023 
      wdetail.n_text024 
      wdetail.n_text025 
      wdetail.n_text026 
      wdetail.n_text027 
      wdetail.n_text028 
      wdetail.n_text029 
      wdetail.n_text030 
      wdetail.n_text031 
      wdetail.n_text032 
      wdetail.n_text033 
      wdetail.n_text034 
      wdetail.n_text035 
      wdetail.n_text036 
      wdetail.n_text037 
      wdetail.n_text038 
      wdetail.n_text039 
      wdetail.n_text040 
      wdetail.n_text041 
      wdetail.n_text042 
      wdetail.n_text043 
      wdetail.n_text044 
      wdetail.n_text045 
      wdetail.n_text046 
      wdetail.n_text047 
      wdetail.n_text048 
      wdetail.n_text049 
      wdetail.n_text050 
      wdetail.n_text051 
      wdetail.n_text052 
      wdetail.n_text053 
      wdetail.n_text054 
      wdetail.n_text055 
      wdetail.n_text056 
      wdetail.n_text057 
      wdetail.n_text058 
      wdetail.n_text059 
      wdetail.n_text060 
      wdetail.n_text061 
      wdetail.n_text062 
      wdetail.n_text063 
      wdetail.n_text064 
      wdetail.n_text065 
      wdetail.n_text066 
      wdetail.n_text067 
      wdetail.n_text068 
      wdetail.n_text069 
      wdetail.n_text070 
      wdetail.n_text071 
      wdetail.n_text072 
      wdetail.n_text073 
      wdetail.n_text074 
      wdetail.n_text075  
      wdetail.n_text076 
      wdetail.n_text077 
      wdetail.n_text078 
      wdetail.n_text079 
      wdetail.n_text080 
      wdetail.n_text081 
      wdetail.n_text082 
      wdetail.n_text083 
      wdetail.n_text084 
      wdetail.n_text085 
      wdetail.n_text086 
      wdetail.n_text087 
      wdetail.n_text088 
      wdetail.n_text089 
      wdetail.n_text090 
      wdetail.n_text091 
      wdetail.n_text092 
      wdetail.n_text093 
      wdetail.n_text094 
      wdetail.n_text095 
      wdetail.n_text096 
      wdetail.n_text097 
      wdetail.n_text098 
      wdetail.n_text099 
      wdetail.n_text100 
      wdetail.n_text101 
      wdetail.n_text102 
      wdetail.n_text103 
      wdetail.n_text104 
      wdetail.n_text105 
      wdetail.n_text106 
      wdetail.n_text107 
      wdetail.n_text108 
      wdetail.n_text109 
      wdetail.n_text110 
      wdetail.n_text111 
      wdetail.n_text112 
      wdetail.n_text113 
      wdetail.n_text114 
      wdetail.n_text115 
      wdetail.n_text116 
      wdetail.n_text117 
      wdetail.n_text118 
      wdetail.n_text119 
      wdetail.n_text120 
      wdetail.n_text121 
      wdetail.n_text122 
      wdetail.n_text123 
      wdetail.n_text124 
      wdetail.n_text125 
      wdetail.n_text126 
      wdetail.n_text127 
      wdetail.n_text128 
      wdetail.n_text129 
      wdetail.n_text130 
      wdetail.n_text131 
      wdetail.n_text132 
      wdetail.n_text133 
      wdetail.n_text134 
      wdetail.n_text135 
      wdetail.n_text136 
      wdetail.n_text137 
      wdetail.n_text138 
      wdetail.n_text139 
      wdetail.n_text140 
      wdetail.n_text141 
      wdetail.n_text142 

        SKIP.
      
END.
/*PUT STREAM NS2 SKIP(1).*/
OUTPUT STREAM  ns2 CLOSE. 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_reportfielTXTEX c-wins 
PROCEDURE pd_reportfielTXTEX :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: add by A68-0061    
------------------------------------------------------------------------------*/
OUTPUT TO VALUE(fi_outfileexp).
RUN pd_reportfielTX_HD. 
For each wdetail   NO-LOCK 
    BREAK BY wdetail.n_text001 :
   EXPORT DELIMITER "|"
      wdetail.n_text001 
      wdetail.n_text002 
      wdetail.n_text003 
      wdetail.n_text004 
      wdetail.n_text005 
      wdetail.n_text006 
      wdetail.n_text007 
      wdetail.n_text008 
      wdetail.n_text009 
      wdetail.n_text010 
      wdetail.n_text011 
      wdetail.n_text012 
      wdetail.n_text013 
      wdetail.n_text014 
      wdetail.n_text015 
      wdetail.n_text016 
      wdetail.n_text017 
      wdetail.n_text018 
      wdetail.n_text019 
      wdetail.n_text020 
      wdetail.n_text021 
      wdetail.n_text022 
      wdetail.n_text023 
      wdetail.n_text024 
      wdetail.n_text025 
      wdetail.n_text026 
      wdetail.n_text027 
      wdetail.n_text028 
      wdetail.n_text029 
      wdetail.n_text030 
      wdetail.n_text031 
      wdetail.n_text032 
      wdetail.n_text033 
      wdetail.n_text034 
      wdetail.n_text035 
      wdetail.n_text036 
      wdetail.n_text037 
      wdetail.n_text038 
      wdetail.n_text039 
      wdetail.n_text040 
      wdetail.n_text041 
      wdetail.n_text042 
      wdetail.n_text043 
      wdetail.n_text044 
      wdetail.n_text045 
      wdetail.n_text046 
      wdetail.n_text047 
      wdetail.n_text048 
      wdetail.n_text049 
      wdetail.n_text050 
      wdetail.n_text051 
      wdetail.n_text052 
      wdetail.n_text053 
      wdetail.n_text054 
      wdetail.n_text055 
      wdetail.n_text056 
      wdetail.n_text057 
      wdetail.n_text058 
      wdetail.n_text059 
      wdetail.n_text060 
      wdetail.n_text061 
      wdetail.n_text062 
      wdetail.n_text063 
      wdetail.n_text064 
      wdetail.n_text065 
      wdetail.n_text066 
      wdetail.n_text067 
      wdetail.n_text068 
      wdetail.n_text069 
      wdetail.n_text070 
      wdetail.n_text071 
      wdetail.n_text072 
      wdetail.n_text073 
      wdetail.n_text074 
      wdetail.n_text075  
      wdetail.n_text076 
      wdetail.n_text077 
      wdetail.n_text078 
      wdetail.n_text079 
      wdetail.n_text080 
      wdetail.n_text081 
      wdetail.n_text082 
      wdetail.n_text083 
      wdetail.n_text084 
      wdetail.n_text085 
      wdetail.n_text086 
      wdetail.n_text087 
      wdetail.n_text088 
      wdetail.n_text089 
      wdetail.n_text090 
      wdetail.n_text091 
      wdetail.n_text092 
      wdetail.n_text093 
      wdetail.n_text094 
      wdetail.n_text095 
      wdetail.n_text096 
      wdetail.n_text097 
      wdetail.n_text098 
      wdetail.n_text099 
      wdetail.n_text100 
      wdetail.n_text101 
      wdetail.n_text102 
      wdetail.n_text103 
      wdetail.n_text104 
      wdetail.n_text105 
      wdetail.n_text106 
      wdetail.n_text107 
      wdetail.n_text108 
      wdetail.n_text109 
      wdetail.n_text110 
      wdetail.n_text111 
      wdetail.n_text112 
      wdetail.n_text113 
      wdetail.n_text114 
      wdetail.n_text115 
      wdetail.n_text116 
      wdetail.n_text117 
      wdetail.n_text118 
      wdetail.n_text119 
      wdetail.n_text120 
      wdetail.n_text121 
      wdetail.n_text122 
      wdetail.n_text123 
      wdetail.n_text124 
      wdetail.n_text125 
      wdetail.n_text126 
      wdetail.n_text127 
      wdetail.n_text128 
      wdetail.n_text129 
      wdetail.n_text130 
      wdetail.n_text131 
      wdetail.n_text132 
      wdetail.n_text133 
      wdetail.n_text134 
      wdetail.n_text135 
      wdetail.n_text136 
      wdetail.n_text137 
      wdetail.n_text138 
      wdetail.n_text139 
      wdetail.n_text140 
      wdetail.n_text141 
      wdetail.n_text142 
      wdetail.n_text143    
      wdetail.n_text144    .
      
END.
OUTPUT   CLOSE.
MESSAGE "Complete "VIEW-AS ALERT-BOX. 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_reportfielTX_HD c-wins 
PROCEDURE pd_reportfielTX_HD :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
EXPORT DELIMITER "|"
      "�Ţ���㺤Ӣ�         "                     
      "�ѹ���㺤Ӣ�         "                     
      "�Ţ����Ѻ��        "                     
      "�ѹ��������������ͧ  "                     
      "�ѹ�������ش        "                     
      "���ʺ���ѷ��Сѹ���  "                     
      "������ö             "                     
      "��������â��         "                     
      "��������໭         "                     
      "�ӹǹ�Թ������¡��"                     
      "����������������ͧ   "                     
      "��������Сѹ         "                     
      "��������ë���        "                     
      "���ѹ�֡            "                     
      "�ӹ�˹��             "                     
      "�����١���           "                     
      "���͡�ҧ             "                     
      "���ʡ��              "                     
      "�������              "                     
      "���                  "                     
      "�ǧ/�Ӻ�            "                     
      "ࢵ/�����            "                     
      "�ѧ��Ѵ ������¹    "                     
      "������ɳ���         "                     
      "�Ҫվ                "                     
      "�ѹ�Դ              "                     
      "�Ţ���ѵû�ЪҪ�    "                     
      "�Ţ���㺢Ѻ���       "                     
      "������ö             "                     
      "�����ö¹��          "                     
      "�����Ţ��Ƕѧ        "                     
      "�����Ţ����ͧ       "                     
      "�������ö           "                     
      "��蹻�               "                     
      "���ͻ�����ö         "                     
      "Ẻ��Ƕѧ  ���ͧ�͹"                     
      "���ʻ�����ö         "                     
      "�����ѡɳС����ҹ  "                     
      "�ӹǹ�����         "                     
      "����ҵá�к͡�ٺ     "                     
      "������ö             "                     
      "�Ţ����¹ö         "                     
      "�ѧ��Ѵ��訴����¹  "                     
      "�շ�訴����¹       "                     
      "�����˵�             "                     
      "ǧ�Թ�ع��Сѹ      "                     
      "���»�Сѹ          "                     
      "�ҡ�                 "                       
      "�ӹǹ�Թ����        "                       
      "���»�Сѹ���       "                       
      "���»�Сѹ���������"                       
      "�ѵ����ǹŴ����ѵԴ� "                       
      "��ǹŴ����ѵԴ�      "                       
      "�����Ţʵ������    "                       
      "�Ţ������������    "                       
      "Flag �кت���        "                       
      "Flag ����кت���     "                       
      "�ӹ�˹��             "                       
      "���ͼ��Ѻ��褹��� 1 "                       
      "���͡�ҧ             "                       
      "���ʡ��              "                       
      "�Ҫվ                "                       
      "�ѹ�Դ              "                       
      "�Ţ���ѵû�ЪҪ�    "                       
      "�Ţ���㺢Ѻ���       "                       
      "�ӹ�˹��             "                       
      "���ͼ��Ѻ��褹��� 2 "                       
      "���͡�ҧ             "                       
      "���ʡ��              "                       
      "�Ҫվ                "                       
      "�ѹ�Դ              "                       
      "�Ţ���ѵû�ЪҪ�    "                       
      "�Ţ���㺢Ѻ���       "                       
      "����Ѻ�Ż���ª��     "                     
      "����������µ�ͪ��Ե (�ҷ/��)   " 
      "����������µ�ͪ��Ե (�ҷ/����)" 
      "����������µ�ͷ�Ѿ���Թ        " 
      "�������������ǹ�á�ؤ��        " 
      "����������µ��ö¹��           " 
      "�������������ǹ�áö¹��       " 
      "ö¹���٭���/�����            " 
      "�غѵ��˵���ǹ�ؤ�����ª��Ե���Ѻ���         "
      "�غѵ��˵���ǹ�ؤ�����ª��Ե��.��������      "
      "�غѵ��˵���ǹ�ؤ�����ª��Ե��������/����   "
      "�غѵ��˵���ǹ�ؤ�ŷؾ���Ҿ���Ǥ��� ���Ѻ��� "
      "�غѵ��˵���ǹ�ؤ�ŷؾ���Ҿ���Ǥ��� ��.������"
      "�غѵ��˵���ǹ�ؤ�ŷؾ���Ҿ���Ǥ��Ǽ�������/�"
      "����ѡ�Ҿ�Һ��             "                   
      "��û�Сѹ��Ǽ��Ѻ���      "                   
      "ʶҹТ�����                "                   
      "����������駻�Сѹ        "                   
      "���ʺ���ѷ����駻�Сѹ    "                   
      "�ҢҺ���ѷ����駻�Сѹ    "                   
      "���ͼ��Դ��� / Salesman   "                   
      "����ѷ�������ö           "                   
      "�ҢҺ���ѷ�������ö       "                   
      "Honda Project              "                   
      "����ö                     "                   
      "��ԡ������������ 1         "                   
      "�ҤҺ�ԡ������������ 1     "                   
      "��ԡ������������ 2         "                   
      "�ҤҺ�ԡ������������ 2     "                   
      "��ԡ������������ 3         "                   
      "�ҤҺ�ԡ������������ 3     "                   
      "��ԡ������������ 4         "                   
      "�ҤҺ�ԡ������������ 4     "                   
      "��ԡ������������ 5         "                   
      "�ҤҺ�ԡ������������ 5     "                   
      "������                     "                   
      "�ѹ���                     "                   
      "�ӹǹ�Թ                  "                   
      "������  CASH              "                   
      "�Ţ���ѵù��˹��          "                   
      "�͡�����㹹��            "                   
      "���������                "                   
      "��������´��໭           "                   
      "�Ѻ��Сѹ�������          "                   
      "��͹����/��͹             "                   
      "�ѵ��ôԵ��Ҥ��           "                   
      "����������駧ҹ           "                   
      "����Ҥ��ػ�ó������        "                   
      "��������´�ػ�ó������     "                   
      "�ҢҺ���ѷ�ͧ�����һ�Сѹ (�١���)"            
      "���������ͺ���"            
      "�Ҥ����ͺ���  "            
      "���ͺ���ѷ�����㺡ӡѺ����1"            
      "�ҢҺ���ѷ��㺡ӡѺ����1    "            
      "������躹㺡ӡѺ����1       "            
      "�Ţ�������������1          "            
      "�ѵ�����µ��㺡ӡѺ1       "            
      "���ͺ���ѷ�����㺡ӡѺ����2"            
      "�ҢҺ���ѷ��㺡ӡѺ����2    "            
      "������躹㺡ӡѺ����2       "            
      "�Ţ�������������2          "            
      "�ѵ�����µ��㺡ӡѺ2       "            
      "���ͺ���ѷ�����㺡ӡѺ����3"            
      "�ҢҺ���ѷ��㺡ӡѺ����3    "            
      "������躹㺡ӡѺ����3       "            
      "�Ţ�������������3          "            
      "�ѵ�����µ��㺡ӡѺ3       "            
      "�Ţ�����໭    "           
      "��������ê�������          "            
      "Producer        "                    
      "Agent           "   .
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_openQuery c-wins 
PROCEDURE Pro_openQuery :
/*------------------------------------------------------------------------------
  Purpose:
       
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*If  fi_polfr  =   "0"  Then  fi_polfr  =  " "  .*/
Open Query br_tlt 
    For each tlt Use-index  tlt01 Where
        tlt.trndat  >=  fi_trndatfr  And
        tlt.trndat  <=  fi_trndatto  And
        /*tlt.policy >=  fi_polfr      And
        tlt.policy <=  fi_polto     And*/
        /*  tlt.comp_sub  =  fi_producer  And*/
        tlt.genusr   =  "hct"      no-lock.
        ASSIGN
            nv_rectlt =  recid(tlt).   /*A55-0184*/
                             

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_openQuery2 c-wins 
PROCEDURE Pro_openQuery2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
Open Query br_tlt 
    /*For each tlt Use-index  tlt01 Where
                             tlt.trndat  >=  fi_trndatfr  And
                             tlt.trndat  <=  fi_trndatto  And
                             /*tlt.policy >=  fi_polfr      And
                             tlt.policy <=  fi_polto     And*/
                           /*  tlt.comp_sub  =  fi_producer  And*/
                             recid(tlt) = nv_rectlt        AND 
                             tlt.genusr   =  "Tisco"      no-lock.*/
    FOR EACH tlt Where Recid(tlt)  =  nv_rectlt NO-LOCK .
        ASSIGN nv_rectlt =  recid(tlt).   /*A57-0017*/
        
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

