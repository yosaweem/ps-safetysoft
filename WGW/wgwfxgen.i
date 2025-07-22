/*programid   : wgwfxgen.i                                                                 */ 
/*programname : load text file fax to GW                                                   */ 
/* Copyright  : Safety Insurance Public Company Limited ����ѷ ��Сѹ������� �ӡѴ (��Ҫ�) */ 
/*create by   : Kridtiya i. A56-0024  date . 04/02/2013                                    */ 
/*              �������������ҧҹ�Ѻ��Сѹ��·ҧῡ��                                  */ 
DEFINE NEW SHARED WORKFILE wdetail2 NO-UNDO  
    FIELD recno            AS CHAR FORMAT "x(10)"  INIT ""  
    FIELD Notify_dat       AS CHAR FORMAT "X(10)"  INIT ""    /*  1  �ѹ����Ѻ��   */                        
    FIELD time_notify      AS CHAR FORMAT "X(10)"  INIT ""    /*  2  �ѹ����Ѻ�Թ������»�Сѹ */            
    FIELD notifyno         AS CHAR FORMAT "X(30)"  INIT ""    /*  3  ��ª��ͺ���ѷ��Сѹ���  */                
    FIELD comp_code        AS CHAR FORMAT "X(20)"  INIT ""    /*  4  �Ţ����ѭ����ҫ��� */                    
    FIELD NAME_mkt         AS CHAR FORMAT "X(45)"  INIT ""    /*  5  �Ţ�������������  */                    
    FIELD cmbr_no          AS CHAR FORMAT "X(30)"  INIT ""    /*  6  �����Ң�    */                            
    FIELD cmbr_code        AS CHAR FORMAT "X(20)"  INIT ""    /*  7  �Ң� KK */                                
    FIELD branch           AS CHAR FORMAT "X(10)"  INIT ""    /*  8  �Ţ�Ѻ��� */                            
    FIELD producer         AS CHAR FORMAT "X(15)"  INIT ""    /*  9  Campaign    */                            
    FIELD agent            AS CHAR FORMAT "X(15)"  INIT ""    /*  10 Sub Campaign    */      
    FIELD deler            AS CHAR FORMAT "X(10)"  INIT ""    /*     deler       */       
    FIELD campaigno        AS CHAR FORMAT "X(20)"  INIT ""    /*  11 �ؤ��/�ԵԺؤ�� */                        
    FIELD cov_car          AS CHAR FORMAT "X(20)"  INIT ""    /*  12 �ӹ�˹�Ҫ���    */                        
    FIELD cov_new          AS CHAR FORMAT "X(20)"  INIT ""    /*  13 ���ͼ����һ�Сѹ    */                    
    FIELD covcod           AS CHAR FORMAT "X(20)"  INIT ""    /*  14 ���ʡ�ż����һ�Сѹ */  
    FIELD product          AS CHAR FORMAT "X(30)"  INIT ""    /*  Add A55-0073   */
    FIELD freeprem         AS CHAR FORMAT "X(20)"  INIT ""    /*  15 ��ҹ�Ţ���  */                            
    FIELD freecomp         AS CHAR FORMAT "X(20)"  INIT ""    /*  21 �Ӻ�/�ǧ   */                            
    FIELD comdat           AS CHAR FORMAT "X(10)"  INIT ""    /*  22 �����/ࢵ   */                            
    FIELD expdat           AS CHAR FORMAT "X(10)"  INIT ""    /*  23 �ѧ��Ѵ */                                
    FIELD ispno            AS CHAR FORMAT "X(30)"  INIT ""    /*  24 ������ɳ���    */ /*A55-0046*/                       
    FIELD pol70            AS CHAR FORMAT "X(20)"  INIT ""    /*  24 ������ɳ���    */                        
    FIELD pol72            AS CHAR FORMAT "X(20)"  INIT ""    /*  25 ����������������ͧ  */                    
    FIELD n_TITLE          AS CHAR FORMAT "X(20)"  INIT ""    /*  26 ��������ë���   */                        
    FIELD n_name1          AS CHAR FORMAT "X(60)"  INIT ""    /*  27 �ѹ�����������ͧ    */                    
    FIELD ADD_1            AS CHAR FORMAT "X(150)" INIT ""    /*  28 �ѹ����ش������ͧ  */                    
    FIELD ADD_2            AS CHAR FORMAT "X(35)"  INIT ""    /*  29 ����ö  */                                
    FIELD ADD_3            AS CHAR FORMAT "X(35)"  INIT ""    /*  30 ��������Сѹ���ö¹��   */                
    FIELD ADD_4            AS CHAR FORMAT "X(35)"  INIT ""    /*  31 ����������ö    */                        
    FIELD ADD_5            AS CHAR FORMAT "X(10)"  INIT ""    /*  32 ���ö  */                                
    FIELD tel              AS CHAR FORMAT "X(30)"  INIT ""    /*  33 New/Used    */                            
    FIELD brand            AS CHAR FORMAT "X(20)"  INIT ""    /*  34 �Ţ����¹  */                            
    FIELD model            AS CHAR FORMAT "X(50)"  INIT ""    /*  35 �Ţ��Ƕѧ   */                            
    FIELD engine           AS CHAR FORMAT "X(30)"  INIT ""    /*  36 �Ţ����ͧ¹��  */                        
    FIELD chassis          AS CHAR FORMAT "X(30)"  INIT ""    /*  37 ��ö¹��    */                            
    FIELD power            AS CHAR FORMAT "X(10)"  INIT ""    /*  38 �ի�    */                                
    FIELD cyear            AS CHAR FORMAT "X(10)"  INIT ""    /*  39 ���˹ѡ/�ѹ */                            
    FIELD licence          AS CHAR FORMAT "X(30)"  INIT ""    /*  40 �ع��Сѹ�� 1   */                        
    FIELD provin           AS CHAR FORMAT "X(30)"  INIT ""    /*  41 ����������������ҡû� 1    */            
    FIELD subclass         AS CHAR FORMAT "X(10)"  INIT ""    /*  42 �ع��Сѹ�� 2   */                        
    FIELD garage           AS CHAR FORMAT "X(2)"   INIT ""    /*  43 ����������������ҡû� 2    */            
    FIELD ins_amt1         AS CHAR FORMAT "X(20)"  INIT ""    /*  44 �����Ѻ���    */                        
    FIELD prem1            AS CHAR FORMAT "X(20)"  INIT ""    /*  45 �������˹�ҷ�� MKT */                    
    FIELD prem2            AS CHAR FORMAT "X(20)"  INIT ""    /*  45 �������˹�ҷ�� MKT */                    
    FIELD comprem          AS CHAR FORMAT "X(20)"  INIT ""    /*  46 �����˵�    */                            
    FIELD prem3            AS CHAR FORMAT "X(20)"  INIT ""    /*  47 ���Ѻ����� 1 �����ѹ�Դ  */            
    FIELD sck              AS CHAR FORMAT "X(20)"  INIT ""    /*  48 ���Ѻ����� 2 �����ѹ�Դ  */            
    FIELD ref              AS CHAR FORMAT "X(30)"  INIT ""    /*  49 �ӹ�˹�Ҫ��� (�����/㺡ӡѺ����)  */    
    FIELD recivename       AS CHAR FORMAT "X(60)"  INIT ""    /*  50 ���� (�����/㺡ӡѺ����)  */            
    FIELD vatcode          AS CHAR FORMAT "X(15)"  INIT ""    /*  51 ���ʡ�� (�����/㺡ӡѺ����)   */        
    FIELD notiuser         AS CHAR FORMAT "X(50)"  INIT ""    /*  52 ��ҹ�Ţ��� (�����/㺡ӡѺ����)*/    
    FIELD bennam           AS CHAR FORMAT "X(55)"  INIT ""    /*  57 �Ӻ�/�ǧ (�����/㺡ӡѺ����) */        
    FIELD remak1           AS CHAR FORMAT "X(100)" INIT ""    /*  58 �����/ࢵ (�����/㺡ӡѺ����) */        
    FIELD statusco         AS CHAR FORMAT "X(35)"  INIT ""    /*  59 �ѧ��Ѵ (�����/㺡ӡѺ����)   */      
    FIELD idno             AS CHAR FORMAT "X(20)"  INIT ""  
    FIELD birthday         AS CHAR FORMAT "X(100)"  INIT ""  
    FIELD occupins         AS CHAR FORMAT "X(100)" INIT ""  
    FIELD namedirect       AS CHAR FORMAT "X(100)" INIT ""
    FIELD driv_no          AS CHAR FORMAT "X(20)"  INIT ""
    FIELD drivname1        AS CHAR FORMAT "X(100)" INIT "" 
    FIELD sexdri1          AS CHAR FORMAT "X(6)"   INIT "" 
    FIELD birthdri1        AS CHAR FORMAT "X(10)"  INIT ""  
    FIELD idexpdat         AS CHAR FORMAT "X(10)"  INIT ""  
    FIELD occupdri1        AS CHAR FORMAT "X(50)"  INIT ""  
    FIELD idnodri1         AS CHAR FORMAT "X(20)"  INIT ""  
    FIELD drivname2        AS CHAR FORMAT "X(100)" INIT ""  
    FIELD sexdri2          AS CHAR FORMAT "X(6)"   INIT ""    
    FIELD birthdri2        AS CHAR FORMAT "X(10)"  INIT ""   
    FIELD occupdri2        AS CHAR FORMAT "X(50)"  INIT ""   
    FIELD idnodri2         AS CHAR FORMAT "X(20)"  INIT "" .
DEFINE NEW SHARED TEMP-TABLE wdetail
    FIELD cedpol      AS CHAR FORMAT "x(25)"  INIT "" 
    FIELD campaigno   AS CHAR FORMAT "X(20)"  INIT ""     /*  11 �ؤ��/�ԵԺؤ�� */                        
    FIELD notiuser    AS CHAR FORMAT "X(50)"  INIT ""     /*  52 ��ҹ�Ţ��� (�����/㺡ӡѺ����)    */    
    FIELD branch      AS CHAR FORMAT "x(10)"  INIT ""    
    FIELD vatcode     AS CHAR FORMAT "x(10)"  INIT ""     
    FIELD poltyp      AS CHAR FORMAT "x(3)"   INIT ""     /*policy type*/
    FIELD policy      AS CHAR FORMAT "x(20)"  INIT ""     /*policy*//*a40166 chg format from 12 to 16*/
    FIELD comdat      AS CHAR FORMAT "x(10)"  INIT ""     /*comm date*/
    FIELD expdat      AS CHAR FORMAT "x(10)"  INIT ""     /*expiry date*/
    FIELD compul      AS CHAR FORMAT "x"      INIT ""     /*compulsory*/
    FIELD tiname      AS CHAR FORMAT "x(15)"  INIT ""     /*title*/
    FIELD insnam      AS CHAR FORMAT "x(50)"  INIT ""     /*name*/
    FIELD iadd1       AS CHAR FORMAT "x(150)" INIT ""    
    FIELD iadd2       AS CHAR FORMAT "x(35)"  INIT ""    
    FIELD iadd3       AS CHAR FORMAT "x(35)"  INIT ""    
    FIELD iadd4       AS CHAR FORMAT "x(35)"  INIT ""    
    FIELD prempa      AS CHAR FORMAT "x"      INIT ""     /*premium package*/
    FIELD subclass    AS CHAR FORMAT "x(3)"   INIT ""     /*sub class*/
    FIELD brand       AS CHAR FORMAT "x(30)"  INIT ""
    FIELD model       AS CHAR FORMAT "x(50)"  INIT ""
    FIELD cc          AS CHAR FORMAT "x(10)"  INIT ""
    FIELD weight      AS CHAR FORMAT "x(10)"  INIT ""
    FIELD seat        AS CHAR FORMAT "x(2)"   INIT ""
    FIELD body        AS CHAR FORMAT "x(20)"  INIT ""
    FIELD vehreg      AS CHAR FORMAT "x(11)"  INIT ""     /*vehicl registration*/
    FIELD engno       AS CHAR FORMAT "x(25)"  INIT ""     /*engine no*/
    FIELD chasno      AS CHAR FORMAT "x(25)"  INIT ""     /*chasis no*/
    FIELD caryear     AS CHAR FORMAT "x(4)"   INIT ""     
    FIELD vehuse      AS CHAR FORMAT "x"      INIT ""     /*vehicle use*/
    FIELD garage      AS CHAR FORMAT "x"      INIT ""     
    FIELD stk         AS CHAR FORMAT "x(15)"  INIT ""     
    FIELD access      AS CHAR FORMAT "x"      INIT ""     /*accessories*/
    FIELD covcod      AS CHAR FORMAT "x"      INIT ""     /*cover type*/
    FIELD product     AS CHAR FORMAT "X(30)"  INIT ""     /*  Add A55-0073   */
    FIELD si          AS CHAR FORMAT "x(25)"  INIT ""     /*sum insure*/
    FIELD volprem     AS CHAR FORMAT "x(20)"  INIT ""     /*voluntory premium*/
    FIELD ncb         AS CHAR FORMAT "x(10)"  INIT ""   
    FIELD deductpp    AS CHAR FORMAT "x(10)"  INIT ""    /*deduct da*/
    FIELD deductba    AS CHAR FORMAT "x(10)"  INIT ""    /*deduct da*/
    FIELD deductpa    AS CHAR FORMAT "x(10)"  INIT ""    /*deduct pd*/
    FIELD benname     AS CHAR FORMAT "x(100)" INIT ""    /*benificiary*/
    FIELD n_IMPORT    AS CHAR FORMAT "x(2)"   INIT ""     
    FIELD n_export    AS CHAR FORMAT "x(2)"   INIT ""     
    FIELD cancel      AS CHAR FORMAT "x(2)"   INIT ""     
    FIELD WARNING     AS CHAR FORMAT "X(30)"  INIT ""
    FIELD comment     AS CHAR FORMAT "x(512)" INIT ""    
    FIELD seat41      AS INTE FORMAT "99"     INIT 0         
    FIELD pass        AS CHAR FORMAT "x"      INIT "n"       
    FIELD OK_GEN      AS CHAR FORMAT "X"      INIT "Y"        
    FIELD comper      AS CHAR INIT "50000"    FORMAT ">,>>>,>>>,>>>,>>9"                  
    FIELD comacc      AS CHAR INIT "50000"    FORMAT ">,>>>,>>>,>>>,>>9"                  
    FIELD NO_41       AS CHAR INIT "50000"    FORMAT ">,>>>,>>>,>>>,>>9"                  
    FIELD NO_42       AS CHAR INIT "50000"    FORMAT ">,>>>,>>>,>>>,>>9"                   
    FIELD NO_43       AS CHAR INIT "200000"   FORMAT ">,>>>,>>>,>>>,>>9"                  
    FIELD baseprem    AS INTE FORMAT ">,>>>,>>>,>>>,>>9" INIT  0
    FIELD cargrp      AS CHAR FORMAT "x(2)"  INIT ""      
    FIELD producer    AS CHAR FORMAT "x(10)" INIT ""      
    FIELD agent       AS CHAR FORMAT "x(10)" INIT ""      
    FIELD deler       AS CHAR FORMAT "X(10)" INIT ""         
    FIELD premt       AS CHAR FORMAT "x(10)" INIT ""
    FIELD redbook     AS CHAR INIT "" FORMAT "X(8)"     
    FIELD base        AS CHAR INIT "" FORMAT "x(8)"     
    FIELD accdat      AS CHAR INIT "" FORMAT "x(10)"    
    FIELD docno       AS CHAR INIT "" FORMAT "x(10)"    
    FIELD nmember     AS CHAR INIT "" FORMAT "x(255)" 
    FIELD nmember2    AS CHAR INIT "" FORMAT "x(255)"
    FIELD delerco     AS CHAR FORMAT "x(10)"  INIT ""  
    FIELD remak1      AS CHAR FORMAT "x(100)" INIT ""
    FIELD typecar     AS CHAR FORMAT "x(30)"  INIT ""
    FIELD ispno       AS CHAR FORMAT "X(30)"  INIT ""       
    FIELD idno        AS CHAR FORMAT "X(20)"  INIT ""  
    FIELD birthday    AS CHAR FORMAT "X(100)"  INIT ""  
    FIELD occupins    AS CHAR FORMAT "X(100)" INIT ""   
    FIELD namedirect  AS CHAR FORMAT "X(100)" INIT ""  
    FIELD drivname1   AS CHAR FORMAT "X(100)" INIT "" 
    FIELD idnodri1    AS CHAR FORMAT "X(20)"  INIT ""  
    FIELD drivname2   AS CHAR FORMAT "X(100)" INIT ""  
    FIELD idnodri2    AS CHAR FORMAT "X(20)"  INIT ""   
    FIELD notifydat   AS CHAR FORMAT "X(60)"  INIT "" .
DEF VAR n_firstdat      AS CHAR FORMAT "x(10)"  INIT ""  .
def    NEW SHARED VAR   nv_message as   char.
DEF VAR nv_riskgp        LIKE sicuw.uwm120.riskgp                                  NO-UNDO.
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
DEF VAR n_model AS CHAR FORMAT "x(40)".
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
DEFINE VAR nv_si     AS DECI FORMAT ">>,>>>,>>9.99-".  /* Maximum Sum Insure */
DEFINE VAR nv_maxSI  AS DECI FORMAT ">>,>>>,>>9.99-".  /* Maximum Sum Insure */
DEFINE VAR nv_minSI  AS DECI FORMAT ">>,>>>,>>9.99-".  /* Minimum Sum Insure */
DEFINE VAR nv_newsck AS CHAR FORMAT "x(15)" INIT " ".
DEFINE VAR nv_simat  AS DECI FORMAT ">>>,>>>,>>>,>>9.99-".      
DEFINE VAR nv_simat1  AS DECI FORMAT ">>>,>>>,>>>,>>9.99-".     
DEF VAR nv_uwm301trareg    LIKE sic_bran.uwm301.cha_no INIT "".  
DEF  VAR gv_id AS CHAR FORMAT "X(8)" NO-UNDO.
DEF VAR nv_pwd AS CHAR NO-UNDO.
DEFINE  WORKFILE wuppertxt3 NO-UNDO
/*1*/  FIELD line     AS INTEGER   FORMAT ">>9"
/*2*/  FIELD txt      AS CHARACTER FORMAT "X(78)"   INITIAL "". 
DEFINE VAR n_insref   AS CHARACTER FORMAT "X(10)".  
DEFINE VAR nv_messagein AS CHAR FORMAT "X(200)". 
DEF VAR nv_usrid    AS CHARACTER FORMAT "X(08)".
DEF VAR nv_transfer AS LOGICAL   .
DEF VAR n_check     AS CHARACTER . 
DEF VAR nv_insref   AS CHARACTER FORMAT "X(10)".  
DEF VAR putchr      AS CHAR FORMAT "X(200)" INIT "" NO-UNDO.
DEF VAR putchr1     AS CHAR FORMAT "X(100)" INIT "" NO-UNDO.
DEF VAR nv_typ      AS CHAR FORMAT "X(2)".
DEF BUFFER buwm100   FOR sic_bran.uwm100. 
DEF  STREAM ns1.  
DEF  VAR nv_type  AS INTEGER  LABEL "Type".   
