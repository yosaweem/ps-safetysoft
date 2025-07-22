/*create by : Ranu I. A64-0138 ����������纤�ҡ�äӹǳ���� */
/*Modify by : Ranu I. A64-0138 ����������纤�ҡ�äӹǳ���� ���駷�� 2 */
/* Modify by : Ranu I. A65-0288 20/10/2022 ��������红�������ö ��Т����š�õ�Ǩ��Ҿ */
/* Modify by   : Ranu I. A67-0076 ��������红�����ö俿�� */
/* Modify by : Ranu I. A67-0198 ���� format ����� Subclass     */
/*------------------------------------------------------------------------------------------------------*/
DEFINE NEW SHARED TEMP-TABLE wdetail2 NO-UNDO 
    FIELD recno          AS CHAR FORMAT "x(10)"  INIT ""  
    FIELD Notify_dat     AS CHAR FORMAT "X(10)"  INIT ""  /*  1  �ѹ����Ѻ��   */                        
    FIELD recive_dat     AS CHAR FORMAT "X(10)"  INIT ""  /*  2  �ѹ����Ѻ�Թ������»�Сѹ */            
    FIELD comp_code      AS CHAR FORMAT "X(50)"  INIT ""  /*  3  ��ª��ͺ���ѷ��Сѹ���  */                
    FIELD cedpol         AS CHAR FORMAT "X(20)"  INIT ""  /*  4  �Ţ����ѭ����ҫ��� */
    FIELD typpol         AS CHAR FORMAT "x(20)"  INIT ""  
    FIELD prepol         AS CHAR FORMAT "X(16)"  INIT ""  /*  5  �Ţ�������������  */                    
    FIELD cmbr_no        AS CHAR FORMAT "X(6)"   INIT ""  /*  6  �����Ң�    */                            
    FIELD cmbr_code      AS CHAR FORMAT "X(35)"  INIT ""  /*  7  �Ң� KK */                                
    FIELD notifyno       AS CHAR FORMAT "X(20)"  INIT ""  /*  8  �Ţ�Ѻ��� */  
    FIELD kkflag         AS CHAR FORMAT "x(20)"  INIT "" 
    FIELD campaigno      AS CHAR FORMAT "X(30)"  INIT ""  /*  9  Campaign    */                            
    FIELD campaigsub     AS CHAR FORMAT "X(30)"  INIT ""  /*  10 Sub Campaign    */                        
    FIELD typper         AS CHAR FORMAT "X(20)"  INIT ""  /*  11 �ؤ��/�ԵԺؤ�� */                        
    FIELD n_TITLE        AS CHAR FORMAT "X(20)"  INIT ""  /*  12 �ӹ�˹�Ҫ���    */                        
    FIELD n_name1        AS CHAR FORMAT "X(40)"  INIT ""  /*  13 ���ͼ����һ�Сѹ    */                    
    FIELD n_name2        AS CHAR FORMAT "X(40)"  INIT ""  /*  14 ���ʡ�ż����һ�Сѹ */                    
    FIELD ADD_1          AS CHAR FORMAT "X(10)"  INIT ""  /*  15 ��ҹ�Ţ���  */                            
    FIELD ADD_2          AS CHAR FORMAT "X(30)"  INIT ""  /*  21 �Ӻ�/�ǧ   */                            
    FIELD ADD_3          AS CHAR FORMAT "X(30)"  INIT ""  /*  22 �����/ࢵ   */                            
    FIELD ADD_4          AS CHAR FORMAT "X(30)"  INIT ""  /*  23 �ѧ��Ѵ */                                
    FIELD ADD_5          AS CHAR FORMAT "X(30)"  INIT ""  /*  24 ������ɳ���    */                        
    FIELD cover          AS CHAR FORMAT "X(20)"  INIT ""  /*  25 ����������������ͧ  */                    
    FIELD garage         AS CHAR FORMAT "X(20)"  INIT ""  /*  26 ��������ë���   */                        
    FIELD comdat         AS CHAR FORMAT "X(10)"  INIT ""  /*  27 �ѹ�����������ͧ    */                    
    FIELD expdat         AS CHAR FORMAT "X(10)"  INIT ""  /*  28 �ѹ����ش������ͧ  */                    
    FIELD subclass       AS CHAR FORMAT "X(20)"  INIT ""  /*  29 ����ö  */                                
    FIELD n_43           AS CHAR FORMAT "X(40)"  INIT ""  /*  30 ��������Сѹ���ö¹��   */                
    FIELD brand          AS CHAR FORMAT "X(20)"  INIT ""  /*  31 ����������ö    */                        
    FIELD model          AS CHAR FORMAT "X(50)"  INIT ""  /*  32 ���ö  */                                
    FIELD nSTATUS        AS CHAR FORMAT "X(10)"  INIT ""  /*  33 New/Used    */                            
    FIELD licence        AS CHAR FORMAT "X(45)"  INIT ""  /*  34 �Ţ����¹  */
    FIELD province       AS CHAR FORMAT "x(50)"  INIT "" 
    FIELD chassis        AS CHAR FORMAT "X(30)"  INIT ""  /*  35 �Ţ��Ƕѧ   */                            
    FIELD engine         AS CHAR FORMAT "X(30)"  INIT ""  /*  36 �Ţ����ͧ¹��  */                        
    FIELD cyear          AS CHAR FORMAT "X(10)"  INIT ""  /*  37 ��ö¹��    */                            
    FIELD power          AS CHAR FORMAT "X(10)"  INIT ""  /*  38 �ի�    */                                
    FIELD weight         AS CHAR FORMAT "X(10)"  INIT ""  /*  39 ���˹ѡ/�ѹ */  
    FIELD seat           AS CHAR FORMAT "x(3)"   INIT ""  /*  ����� */
    FIELD ins_amt1       AS CHAR FORMAT "X(20)"  INIT ""  /*  40 �ع��Сѹ�� 1   */ 
    FIELD netprem        AS CHAR FORMAT "x(20)"  INIT ""  
    FIELD prem1          AS CHAR FORMAT "X(20)"  INIT ""  /*  41 ����������������ҡû� 1    */
    FIELD time_notify    AS CHAR FORMAT "X(10)"  INIT ""  /*  44 �����Ѻ���    */                        
    FIELD NAME_mkt       AS CHAR FORMAT "X(50)"  INIT ""  /*  45 �������˹�ҷ�� MKT */                    
    FIELD benname        AS CHAR FORMAT "x(200)" INIT ""     /*benificiary*/  /*A55-0240*/
    FIELD drivno1        AS CHAR FORMAT "X(60)"  INIT ""  /*  47 ���Ѻ����� 1 �����ѹ�Դ  */            
    field drivdat1       as char format "x(20)"  init "" 
    field drivid1        as char format "x(20)"  init "" 
    FIELD drivno2        AS CHAR FORMAT "X(60)"  INIT ""  /*  48 ���Ѻ����� 2 �����ѹ�Դ  */            
    field drivdat2       as char format "x(20)"  init "" 
    field drivid2        as char format "x(20)"  init ""
    FIELD reci_title     AS CHAR FORMAT "X(20)"  INIT ""  /*  49 �ӹ�˹�Ҫ��� (�����/㺡ӡѺ����)  */    
    FIELD reci_name1     AS CHAR FORMAT "X(40)"  INIT ""  /*  50 ���� (�����/㺡ӡѺ����)  */            
    FIELD reci_name2     AS CHAR FORMAT "X(40)"  INIT ""  /*  51 ���ʡ�� (�����/㺡ӡѺ����)   */        
    FIELD reci_1         AS CHAR FORMAT "X(10)"  INIT ""  /*  52 ��ҹ�Ţ��� (�����/㺡ӡѺ����)    */    
    FIELD reci_2         AS CHAR FORMAT "X(35)"  INIT ""  /*  57 �Ӻ�/�ǧ (�����/㺡ӡѺ����) */        
    FIELD reci_3         AS CHAR FORMAT "X(35)"  INIT ""  /*  58 �����/ࢵ (�����/㺡ӡѺ����) */        
    FIELD reci_4         AS CHAR FORMAT "X(35)"  INIT ""  /*  59 �ѧ��Ѵ (�����/㺡ӡѺ����)   */        
    FIELD reci_5         AS CHAR FORMAT "X(10)"  INIT ""  /*  60 ������ɳ��� (�����/㺡ӡѺ����)  */    
    FIELD ncb            AS CHAR FORMAT "X(10)"  INIT ""  /*  61 ��ǹŴ����ѵԴ� */                          
    FIELD fleet          AS CHAR FORMAT "X(10)"  INIT ""  /*  62  ��ǹŴ�ҹ Fleet */
    FIELD remak1         AS CHAR FORMAT "x(150)" INIT ""
    FIELD remak2         AS CHAR FORMAT "x(150)" INIT ""
    FIELD branch         AS CHAR FORMAT "x(3)"   INIT "" 
    field phone         as char format "x(25)" init ""
    field icno          as char format "x(15)" init ""
    FIELD bdate         AS CHAR FORMAT "X(15)" INIT ""
    field tax           as char format "x(15)" init ""
    field cstatus       as char format "x(20)" init ""
    field occup         as char format "x(45)" init ""
    field icno3         as char format "x(15)" init ""
    field lname3        as char format "x(45)" init ""
    field cname3        as char format "x(45)" init ""
    field tname3        as char format "x(20)" init ""
    field icno2         as char format "x(15)" init ""
    field lname2        as char format "x(45)" init ""
    field cname2        as char format "x(45)" init ""
    field tname2        as char format "x(20)" init ""
    field icno1         as char format "x(15)" init ""
    field lname1        as char format "x(45)" init ""
    field cname1        as char format "x(45)" init ""
    field tname1        as char format "x(20)" init ""
    field nsend         as char format "x(50)" init ""     /*a61-0335*/ 
    field sendname      as char format "x(100)" init ""    /*a61-0335*/
    field bennefit      as char format "x(100)" init ""    /*a61-0335*/
    field KKapp         as char format "x(25)"  init ""     /*a61-0335*/
    FIELD dealercd      AS CHAR FORMAT "x(50)"  INIT ""       /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
    field packcod       as char format "x(20)"  init "" 
    field campOV        as char format "x(20)"  init "" 
    FIELD producer      AS CHAR FORMAT "x(15)"  INIT "" 
    FIELD agent         AS CHAR FORMAT "x(15)"  INIT "" 
    field RefNo         as char format "x(25)"  init ""     
    field KKQuo         as char format "x(25)"  init "" 
    field RiderNo       as char format "x(25)"  init "" 
    FIELD releas        AS CHAR FORMAT "x(10)"  INIT "" 
    FIELD loandat       AS CHAR FORMAT "x(15)"  INIT "" 
    FIELD vatcode       AS CHAR FORMAT "x(12)"  INIT "" 
    FIELD brtms         AS CHAR FORMAT "x(50)"   INIT "" 
    FIELD dealtms       AS CHAR FORMAT "x(10)"  INIT "" 
    field gender        as char format "x(50)"  init "" 
    field nation        as char format "x(50)"  init "" 
    field email         as char format "x(50)"  init "" 
    /*A65-0288*/
    field PolPrem       as char format "x(15)"  INIT "" 
    field UnProblem     as char format "x(225)" INIT "" 
    FIELD colors        AS CHAR FORMAT "x(50)"  INIT "" 
    field Insp          as char format "X(2)"  init "" 
    field Inspsts       as char format "X(2)"  init "" 
    field InspNo        as char format "X(10)"  init "" 
    field InspClosed    as char format "X(15)"  init "" 
    field InspDetail    as char format "X(100)"  init "" 
    field inspDamg      as char format "X(225)"  init "" 
    field inspAcc       as char format "X(225)"  init "" 
    /* end A65-0288 */
    /* A67-0076 */
    field hp            as char init ""   
    field drititle1     as char init ""   
    field drigender1    as char init ""   
    field drioccup1     as char init ""   
    field driToccup1    as char init ""   
    field driTicono1    as char init ""   
    field driICNo1      as char init "" 
    field drilevel1     as char init "" 
    field drititle2     as char init ""   
    field drigender2    as char init ""   
    field drioccup2     as char init ""   
    field driToccup2    as char init ""   
    field driTicono2    as char init ""   
    field driICNo2      as char init "" 
    field drilevel2     as char init "" 
    field drilic3       as char init ""   
    field drititle3     as char init ""   
    field driname3      as char init ""   
    field drivno3       as char init ""   
    field drigender3    as char init ""   
    field drioccup3     as char init ""   
    field driToccup3    as char init ""   
    field driTicono3    as char init ""   
    field driICNo3      as char init "" 
    field drilevel3     as char init "" 
    field drilic4       as char init ""   
    field drititle4     as char init ""   
    field driname4      as char init ""   
    field drivno4       as char init ""   
    field drigender4    as char init ""   
    field drioccup4     as char init ""   
    field driToccup4    as char init ""   
    field driTicono4    as char init ""   
    field driICNo4      as char init "" 
    field drilevel4     as char init "" 
    field drilic5       as char init ""   
    field drititle5     as char init ""   
    field driname5      as char init ""   
    field drivno5       as char init ""   
    field drigender5    as char init ""   
    field drioccup5     as char init ""   
    field driToccup5    as char init ""   
    field driTicono5    as char init ""   
    field driICNo5      as char init "" 
    field drilevel5     as char init "" 
    field dateregis     as char init ""   
    field pay_option    as char init ""   
    field battno        as char init ""   
    field battyr        as char init ""   
    field maksi         as char init ""   
    field chargno       as char init ""   
    field veh_key       as char init "" .
/* end A67-0076 */
    
DEFINE NEW SHARED TEMP-TABLE wdetail
      FIELD cedpol      AS CHAR FORMAT "x(25)" INIT "" 
      FIELD branch      AS CHAR FORMAT "x(10)" INIT "" 
      FIELD entdat      AS CHAR FORMAT "x(10)" INIT ""    /*entry date*/
      FIELD enttim      AS CHAR FORMAT "x(8)"  INIT ""    /*entry time*/
      FIELD trandat     AS CHAR FORMAT "x(10)" INIT ""    /*tran date*/
      FIELD trantim     AS CHAR FORMAT "x(8)"  INIT ""    /*tran time*/
      FIELD poltyp      AS CHAR FORMAT "x(3)"  INIT ""    /*policy type*/
      FIELD policy      AS CHAR FORMAT "x(20)" INIT ""    /*policy*/       /*a40166 chg format from 12 to 16*/
      FIELD prepol      AS CHAR FORMAT "x(20)" INIT ""    /*renew policy*/ /*a40166 chg format from 12 to 16*/
      FIELD comdat      AS CHAR FORMAT "x(10)" INIT ""    /*comm date*/
      FIELD expdat      AS CHAR FORMAT "x(10)" INIT ""    /*expiry date*/
      FIELD compul      AS CHAR FORMAT "x"     INIT ""    /*compulsory*/
      FIELD tiname      AS CHAR FORMAT "x(15)" INIT ""    /*title*/
      FIELD insnam      AS CHAR FORMAT "x(50)" INIT ""    /*name*/
      FIELD iadd1       AS CHAR FORMAT "x(60)" INIT ""    
      FIELD iadd2       AS CHAR FORMAT "x(35)" INIT ""    
      FIELD iadd3       AS CHAR FORMAT "x(35)" INIT ""    
      FIELD iadd4       AS CHAR FORMAT "x(35)" INIT ""    
      FIELD prempa      AS CHAR FORMAT "x"     INIT ""    /*premium package*/
      /*FIELD subclass    AS CHAR FORMAT "x(4)"  INIT ""   --A67-0198-- */   /*sub class*/
      FIELD subclass    AS CHAR FORMAT "x(5)"  INIT ""   /*--A67-0198-- */   /*sub class*/
      FIELD brand       AS CHAR FORMAT "x(30)" INIT ""
      FIELD model       AS CHAR FORMAT "x(50)" INIT ""
      FIELD cc          AS CHAR FORMAT "x(10)" INIT ""
      FIELD weight      AS CHAR FORMAT "x(10)" INIT ""
      FIELD seat        AS CHAR FORMAT "x(2)" INIT ""
      FIELD body        AS CHAR FORMAT "x(20)" INIT ""
      /*FIELD vehreg      AS CHAR FORMAT "x(10)" INIT ""     /*vehicl registration*/*//*A54-0112*/
      FIELD vehreg      AS CHAR FORMAT "x(11)" INIT ""     /*vehicl registration*/   /*A54-0112*/
      FIELD engno       AS CHAR FORMAT "x(25)" INIT ""    /*engine no*/
      FIELD chasno      AS CHAR FORMAT "x(25)" INIT ""    /*chasis no*/
      FIELD caryear     AS CHAR FORMAT "x(4)" INIT ""     
      FIELD vehuse      AS CHAR FORMAT "x" INIT ""        /*vehicle use*/
      FIELD garage      AS CHAR FORMAT "x" INIT ""        
      FIELD stk         AS CHAR FORMAT "x(15)" INIT ""    
      FIELD access      AS CHAR FORMAT "x" INIT ""        /*accessories*/
      FIELD covcod      AS CHAR FORMAT "x" INIT ""        /*cover type*/
      FIELD si          AS CHAR FORMAT "x(25)" INIT ""    /*sum insure*/
      FIELD volprem     AS CHAR FORMAT "x(20)" INIT ""    /*voluntory premium*/
      FIELD fleet       AS CHAR FORMAT "x(10)" INIT ""    /*fleet*/
      FIELD ncb         AS CHAR FORMAT "x(10)" INIT ""    
      FIELD revday      AS CHAR FORMAT "x(10)" INIT ""    
      FIELD deductpp    AS CHAR FORMAT "x(10)" INIT ""    /*deduct da*/
      FIELD deductba    AS CHAR FORMAT "x(10)" INIT ""    /*deduct da*/
      FIELD deductpa    AS CHAR FORMAT "x(10)" INIT ""    /*deduct pd*/
      /*FIELD benname     AS CHAR FORMAT "x(100)" INIT ""   /*benificiary*/*//*A55-0240*/
      FIELD benname     AS CHAR FORMAT "x(200)" INIT ""     /*benificiary*/  /*A55-0240*/
      FIELD n_IMPORT    AS CHAR FORMAT "x(2)" INIT ""     
      FIELD n_export    AS CHAR FORMAT "x(2)" INIT ""     
      FIELD drivnam     AS CHAR FORMAT "x" INIT ""        
      FIELD drivnam1    AS CHAR FORMAT "x(50)" INIT ""    /*driver name1*/
      FIELD drivbir1    AS CHAR FORMAT "X(15)" INIT ""    /*driver birth date*/
      FIELD drivid1     AS CHAR FORMAT "X(15)" INIT ""    /*driver age1*/
      FIELD drivnam2    AS CHAR FORMAT "x(50)" INIT ""    /*driver name2*/
      FIELD drivbir2    AS CHAR FORMAT "X(15)" INIT ""    /*driver birth date*/
      FIELD drivid2     AS CHAR FORMAT "x(15)" INIT ""    /*driver age2*/
      FIELD cancel      AS CHAR FORMAT "x(2)" INIT ""     /*cancel*/
      FIELD WARNING     AS CHAR FORMAT "X(30)" INIT ""
      FIELD comment     AS CHAR FORMAT "x(512)"  INIT ""   /*a490166 add format from 100 to 512*/
      FIELD seat41      AS INTE FORMAT "99" INIT 0         
      FIELD pass        AS CHAR FORMAT "x"  INIT "n"       
      FIELD OK_GEN      AS CHAR FORMAT "X" INIT "Y"        
      FIELD comper      AS CHAR INIT "50000"   FORMAT ">,>>>,>>>,>>>,>>9"                  
      FIELD comacc      AS CHAR INIT "50000"   FORMAT ">,>>>,>>>,>>>,>>9"                  
      FIELD NO_411      AS CHAR INIT "50000"   FORMAT ">,>>>,>>>,>>>,>>9" 
      FIELD NO_412      AS CHAR INIT "50000"   FORMAT ">,>>>,>>>,>>>,>>9" 
      FIELD NO_42       AS CHAR INIT "50000"   FORMAT ">,>>>,>>>,>>>,>>9"                   
      FIELD NO_43       AS CHAR INIT "200000"  FORMAT ">,>>>,>>>,>>>,>>9"                  
      FIELD tariff      AS CHAR FORMAT "x(2)" INIT ""      
      FIELD baseprem    AS INTE FORMAT ">,>>>,>>>,>>>,>>9" INIT  0
      FIELD cargrp      AS CHAR FORMAT "x(2)" INIT ""      
      FIELD producer    AS CHAR FORMAT "x(10)" INIT ""      
      FIELD agent       AS CHAR FORMAT "x(10)" INIT ""      
      FIELD premt       AS CHAR FORMAT "x(15)" INIT ""
      FIELD redbook     AS CHAR INIT "" FORMAT "X(8)"      /*note add*/
      FIELD base        AS CHAR INIT "" FORMAT "x(8)"      /*Note add Base Premium 25/09/2006*/
      FIELD accdat      AS CHAR INIT "" FORMAT "x(10)"     /*Account Date For 72*/
      FIELD docno       AS CHAR INIT "" FORMAT "x(10)"     /*Docno For 72*/
      FIELD ICNO        AS CHAR INIT "" FORMAT "x(13)"     /*ICNO For COVER NOTE A51-0071 amparat*/
      FIELD CoverNote   AS CHAR INIT "" FORMAT "x(13)"    /* �к�����繧ҹ COVER NOTE A51-0071 amparat*/
      FIELD nmember     AS CHAR INIT "" FORMAT "x(255)" 
      FIELD delerco     AS CHAR FORMAT "x(12)"    INIT ""  
      FIELD remak1      AS CHAR FORMAT "x(150)"   INIT ""
      FIELD remak2      AS CHAR FORMAT "x(150)"   INIT "" 
      /* create by A60-0232*/
      FIELD fi          AS CHAR FORMAT "x(15)" INIT ""
      field phone         as char format "x(25)" init ""
      FIELD bdate         AS CHAR FORMAT "X(15)" INIT ""
      field tax           as char format "x(15)" init ""
      field cstatus       as char format "x(20)" init ""
      field occup         as char format "x(45)" init ""
      field icno3         as char format "x(15)" init ""
      field lname3        as char format "x(45)" init ""
      field cname3        as char format "x(45)" init ""
      field tname3        as char format "x(20)" init ""
      field icno2         as char format "x(15)" init ""
      field lname2        as char format "x(45)" init ""
      field cname2        as char format "x(45)" init ""
      field tname2        as char format "x(20)" init ""
      field icno1         as char format "x(15)" init ""
      field lname1        as char format "x(45)" init ""
      field cname1        as char format "x(45)" init ""
      field tname1        as char format "x(20)" init ""
      field nsend         as char format "x(50)" init ""    /*A61-0335*/
      field sendname      as char format "x(100)" init ""   /*A61-0335*/
      field bennefit      as char format "x(100)" init ""   /*A61-0335*/
      field KKapp         as char format "x(25)"  init ""   /*A61-0335*/
      FIELD financecd   AS CHAR FORMAT "x(60)" INIT ""      /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
      FIELD firstName   AS CHAR FORMAT "x(60)" INIT ""      /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
      FIELD lastName    AS CHAR FORMAT "x(60)" INIT ""      /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
      FIELD postcd      AS CHAR FORMAT "x(15)" INIT ""      /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
      FIELD codeocc     AS CHAR FORMAT "x(4)"  INIT ""      /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
      FIELD codeaddr1   AS CHAR FORMAT "x(2)"  INIT ""      /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
      FIELD codeaddr2   AS CHAR FORMAT "x(2)"  INIT ""      /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
      FIELD codeaddr3   AS CHAR FORMAT "x(2)"  INIT ""      /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
      FIELD br_insured  AS CHAR FORMAT "x(5)"  INIT ""      /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
      FIELD campaign_ov AS CHAR FORMAT "x(30)" INIT ""      /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
      FIELD insnamtyp   AS CHAR FORMAT "x(60)" INIT ""      /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
      FIELD dealercd    AS CHAR FORMAT "x(30)" INIT ""      /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
      FIELD product     AS CHAR FORMAT "x(20)" INIT ""  
      FIELD name2       AS CHAR FORMAT "x(100)" INIT "" 
      FIELD namenotify  AS CHAR FORMAT "x(100)" INIT "" 
      FIELD notifyno    AS CHAR FORMAT "x(25)"  INIT "" 
      field RefNo       as char format "x(25)"  init ""     
      field KKQuo       as char format "x(25)"  init "" 
      field RiderNo     as char format "x(25)"  init "" 
      FIELD dealtms     AS CHAR FORMAT "x(10)"  INIT "" 
      FIELD reci_title  AS CHAR FORMAT "X(20)"  INIT ""  /*  49 �ӹ�˹�Ҫ��� (�����/㺡ӡѺ����)  */    
      FIELD reci_name1  AS CHAR FORMAT "X(40)"  INIT ""  /*  50 ���� (�����/㺡ӡѺ����)  */            
      FIELD reci_name2  AS CHAR FORMAT "X(40)"  INIT ""  /*  51 ���ʡ�� (�����/㺡ӡѺ����)   */        
      FIELD reci_1      AS CHAR FORMAT "X(10)"  INIT ""  /*  52 ��ҹ�Ţ��� (�����/㺡ӡѺ����)    */    
      FIELD reci_2      AS CHAR FORMAT "X(35)"  INIT ""  /*  57 �Ӻ�/�ǧ (�����/㺡ӡѺ����) */        
      FIELD reci_3      AS CHAR FORMAT "X(35)"  INIT ""  /*  58 �����/ࢵ (�����/㺡ӡѺ����) */        
      FIELD reci_4      AS CHAR FORMAT "X(35)"  INIT ""  /*  59 �ѧ��Ѵ (�����/㺡ӡѺ����)   */        
      FIELD reci_5      AS CHAR FORMAT "X(10)"  INIT ""  /*  60 ������ɳ��� (�����/㺡ӡѺ����)  */  
      field gender      as char format "x(50)"  init "" 
      field nation      as char format "x(50)"  init "" 
      field email       as char format "x(50)"  init "" 
      /*A65-0288*/
      FIELD problem     AS CHAR FORMAT "x(250)" INIT "" 
      FIELD colors        AS CHAR FORMAT "x(50)"  INIT "" 
      field Insp          as char format "X(2)"  init "" 
      field Inspsts       as char format "X(2)"  init "" 
      field InspNo        as char format "X(10)"  init "" 
      field InspClosed    as char format "X(15)"  init "" 
      field InspDetail    as char format "X(100)"  init "" 
      field inspDamg      as char format "X(225)"  init "" 
      field inspAcc       as char format "X(225)"  init "" 
    /* A67-0076 */
      field hp            as DECI  format ">>>9.99" init 0   
      field drititle1     as char  format "x(35)" init ""   
      field drigender1    as char  format "x(10)" init ""   
      field drioccup1     as char  format "x(100)" init "" 
      field driICNo1      as char  format "x(13)" init "" 
      field drilevel1     as char  format "x(2)" init "" 
      field drititle2     as char  format "x(35)" init ""   
      field drigender2    as char  format "x(10)" init ""   
      field drioccup2     as char  format "x(100)" init ""   
      field driICNo2      as char  format "x(13)" init "" 
      field drilevel2     as char  format "x(2)" init "" 
      field drilic3       as char  format "x(15)" init ""   
      field drititle3     as char  format "x(35)" init ""   
      field drivnam3      as char  format "x(100)" init ""   
      field drivbir3      as char  format "x(15)" init ""    
      field drigender3    as char  format "x(10)" init ""   
      field drioccup3     as char  format "x(100)" init ""   
      field driICNo3      as char  format "x(13)" init "" 
      field drilevel3     as char  format "x(2)" init "" 
      field drilic4       as char  format "x(13)" init ""   
      field drititle4     as char  format "x(35)" init ""   
      field drivnam4      as char  format "x(100)" init ""   
      field drivbir4      as char  format "x(15)" init ""    
      field drigender4    as char  format "x(10)" init ""   
      field drioccup4     as char  format "x(100)" init ""   
      field driICNo4      as char  format "x(13)" init "" 
      field drilevel4     as char  format "x(2)" init "" 
      field drilic5       as char  format "x(15)" init ""   
      field drititle5     as char  format "x(35)" init ""   
      field drivnam5      as char  format "x(100)" init ""   
      field drivbir5      as char  format "x(15)" init ""    
      field drigender5    as char  format "x(10)" init ""   
      field drioccup5     as char  format "x(100)" init ""   
      field driICNo5      as char  format "x(13)" init "" 
      field drilevel5     as CHAR  format "X(2)" init "" 
      FIELD drivlevel     AS CHAR  FORMAT "x(2)" INIT "" 
      field dateregis     as char  format "x(15)" init ""   
      field pay_option    as char  format "x(100)" init ""   
      field battno        as char  format "x(40)" init ""   
      field battyr        as char  format "x(4)" init ""   
      field maksi         as DECI  format ">>>>>>>9.99" init 0   
      field chargno       as char  format "x(40)" init ""   
      field veh_key       as char  format "x(15)" init "" 
      FIELD battper       AS DECI  FORMAT ">>>9.99" INIT 0.

DEFINE WORKFILE wexcamp 
    FIELD policy    AS CHAR
    FIELD campaign  AS CHAR     
    FIELD polmaster AS CHAR    
    FIELD tp_bi1 AS INTE FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD tp_bi2 AS INTE FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD tp_pd  AS INTE FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD sumins AS CHAR FORMAT "X(20)"
    FIELD sumfit AS CHAR FORMAT "X(20)"
    FIELD Prem_t AS DECI FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD base1  AS CHAR FORMAT "X(20)"
    FIELD pa411  AS INTE FORMAT ">>,>>>,>>>,>>9-"
    FIELD pa412  AS INTE FORMAT ">>,>>>,>>>,>>9-"
    FIELD pa42   AS INTE FORMAT ">>,>>>,>>>,>>9-"
    FIELD pa43   AS INTE FORMAT ">>,>>>,>>>,>>9-"
    FIELD base3  AS CHAR FORMAT "X(20)"
    FIELD dedod  AS CHAR FORMAT "X(20)"
    FIELD deaod  AS CHAR FORMAT "X(20)"
    FIELD dedpd  AS CHAR FORMAT "X(20)"
    FIELD fleet  AS CHAR FORMAT "X(5)"
    FIELD ncbper AS CHAR FORMAT "X(5)"
    FIELD dspc   AS CHAR FORMAT "X(5)"
    FIELD staff  AS CHAR FORMAT "X(5)"
    FIELD loadcl AS CHAR FORMAT "X(10)"
    FIELD base2  AS CHAR FORMAT "X(20)"  
    FIELD acc    AS CHAR . 
/* end A65-0288 */
      
DEF NEW SHARED TEMP-TABLE wcomp 
   field  package  as char format "x(10)" 
   field  seat     as char format "x(10)" 
   field  premcomp as INT                
   field  body     as char format "x(15)" .

DEF VAR nv_chkerror  AS CHAR FORMAT "x(250)" INIT "".       /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
DEF VAR nv_postcd    AS CHAR FORMAT "x(25)" INIT "".        /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
DEF VAR nv_chass AS CHAR FORMAT "x(10)" INIT "" .

     /* end A60-0232*/
DEF VAR n_firstdat    AS CHAR FORMAT "x(10)" INIT ""  .
def    NEW SHARED VAR   nv_message as   char.
DEF VAR nv_riskgp        LIKE sicuw.uwm120.riskgp                                  NO-UNDO.
DEFINE NEW SHARED VAR no_baseprm AS DECI  FORMAT ">>,>>>,>>9.99-". /*note add test Base Premium 25/09/2006*/
DEFINE NEW SHARED VAR NO_basemsg AS CHAR  FORMAT "x(50)" .         /*Warning Error If Not in Range 25/09/2006 */
DEFINE            VAR nv_accdat  AS DATE  FORMAT "99/99/9999" INIT ?  .     
DEFINE            VAR nv_docno   AS CHAR  FORMAT "9999999"    INIT " ".
DEFINE NEW SHARED VAR  nv_batchyr   AS INT FORMAT "9999"            INIT 0.
DEFINE NEW SHARED VAR  nv_batcnt    AS INT FORMAT "99"              INIT 0.
DEFINE NEW SHARED VAR  nv_batchno   AS CHARACTER FORMAT "X(13)"     INIT ""  NO-UNDO.
DEFINE VAR  nv_batrunno  AS INT FORMAT  ">,>>9"          INIT 0.
DEFINE VAR  nv_imppol    AS INT  FORMAT ">>,>>9"         INIT 0.
DEFINE VAR  nv_impprem   AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.
DEFINE VAR  nv_batprev   AS CHARACTER FORMAT "X(13)"     INIT ""  NO-UNDO.
DEFINE VAR  nv_tmppolrun AS INTEGER FORMAT "999"         INIT 0. /*Temp Policy Running No.*/
DEFINE VAR  nv_batbrn    AS CHARACTER FORMAT "x(2)"      INIT ""  NO-UNDO. /*Batch Branch*/
DEFINE VAR  nv_tmppol    AS CHARACTER FORMAT "x(16)"     INIT "". /*Temp Policy*/
DEFINE VAR  nv_rectot    AS INT  FORMAT ">>,>>9"         INIT 0.  /* Display �ӹǹ �/� ������ */
DEFINE VAR  nv_recsuc    AS INT  FORMAT ">>,>>9"         INIT 0.  /* Display �ӹǹ �/� ��������� */
DEFINE VAR  nv_netprm_t  AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.  /* Display ������� ������ */
DEFINE VAR  nv_netprm_s  AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.  /* Display ������� ��������� */
DEFINE VAR  nv_batflg    AS LOG                          INIT NO.
DEFINE VAR  nv_txtmsg    AS CHAR FORMAT "x(50)"          INIT "".   /* Parameter ���Ѻ nv_check */
DEF VAR n_model AS CHAR FORMAT "x(40)".
DEFINE  WORKFILE wuppertxt NO-UNDO
/*1*/  FIELD line     AS INTEGER   FORMAT ">>9"
/*2*/  FIELD txt      AS CHARACTER FORMAT "X(78)"   INITIAL "".
DEFINE  WORKFILE wuppertxt2 NO-UNDO
/*1*/  FIELD line     AS INTEGER   FORMAT ">>9"
/*2*/  FIELD txt      AS CHARACTER FORMAT "X(78)"   INITIAL "".
DEF  VAR n_411   AS DECI     FORMAT ">,>>>,>>9.99" INIT 0.
DEF  VAR n_412   AS DECI     FORMAT ">,>>>,>>9.99" INIT 0.
DEF  VAR n_42    AS DECI     FORMAT ">,>>>,>>9.99" INIT 0.
DEF  VAR n_43    AS DECI     FORMAT ">,>>>,>>9.99" INIT 0.
DEFINE VAR nv_basere   AS DECI        FORMAT ">>,>>>,>>9.99-" INIT 0. 
/*DEFINE VAR n_sclass72  AS CHAR FORMAT "x(4)". */ /*A67-0198*/
DEFINE VAR n_sclass72  AS CHAR FORMAT "x(5)".  /*A67-0198*/
DEFINE VAR nv_maxdes AS CHAR.
DEFINE VAR nv_mindes AS CHAR.
DEFINE VAR nv_si     AS DECI FORMAT ">>,>>>,>>9.99-". /* Maximum Sum Insure */
DEFINE VAR nv_maxSI  AS DECI FORMAT ">>,>>>,>>9.99-". /* Maximum Sum Insure */
DEFINE VAR nv_minSI  AS DECI FORMAT ">>,>>>,>>9.99-". /* Minimum Sum Insure */
DEFINE VAR nv_newsck AS CHAR FORMAT "x(15)" INIT " ".
DEFINE VAR nv_simat  AS DECI FORMAT ">>>,>>>,>>>,>>9.99-".      
DEFINE VAR nv_simat1  AS DECI FORMAT ">>>,>>>,>>>,>>9.99-".     
DEF VAR nv_uwm301trareg    LIKE sic_bran.uwm301.cha_no INIT "".  
DEF  VAR gv_id AS CHAR FORMAT "X(8)" NO-UNDO.
DEF  VAR nv_pwd AS CHAR FORMAT "x(20)" NO-UNDO.

DEFINE  VAR   nv_prem3       AS DECIMAL  FORMAT ">,>>>,>>9.99-" INITIAL 0  NO-UNDO.
DEFINE  VAR   nv_sicod3      AS CHAR     FORMAT "X(4)".
DEFINE  VAR   nv_usecod3     AS CHAR     FORMAT "X(4)".
DEFINE  VAR   nv_siprm3      AS DECI     FORMAT ">>,>>>,>>9.99-".
DEFINE  VAR   nv_prvprm3     AS DECI     FORMAT ">>,>>>,>>9.99-".
DEFINE  VAR   nv_baseprm3    AS DECI     FORMAT ">>,>>>,>>9.99-".
DEFINE  VAR   nv_useprm3     AS DECI     FORMAT ">>,>>>,>>9.99-".
DEFINE  VAR   nv_basecod3    AS CHAR     FORMAT "X(4)".
DEFINE  VAR   nv_basevar3    AS CHAR     FORMAT "X(60)".
DEFINE  VAR   nv_basevar4    AS CHAR     FORMAT "X(30)".
DEFINE  VAR   nv_basevar5    AS CHAR     FORMAT "X(30)".
DEFINE  VAR   nv_usevar3     AS CHAR     FORMAT "X(60)".
DEFINE  VAR   nv_usevar4     AS CHAR     FORMAT "X(30)".
DEFINE  VAR   nv_usevar5     AS CHAR     FORMAT "X(30)".
DEFINE  VAR   nv_sivar3      AS CHAR     FORMAT "X(60)".
DEFINE  VAR   nv_sivar4      AS CHAR     FORMAT "X(30)".
DEFINE  VAR   nv_sivar5      AS CHAR     FORMAT "X(30)".

DEFINE  WORKFILE wuppertxt3 NO-UNDO
/*1*/  FIELD line     AS INTEGER   FORMAT ">>9"
/*2*/  FIELD txt      AS CHARACTER FORMAT "X(78)"   INITIAL "". 

DEFINE VAR n_insref     AS CHARACTER FORMAT "X(10)". 
/* DEFINE VAR nv_messagein AS CHAR FORMAT "X(200)".                  */
DEFINE VAR nv_usrid     AS CHARACTER FORMAT "X(08)".            
DEFINE VAR nv_transfer  AS LOGICAL   .                          
DEFINE VAR n_check      AS CHARACTER .    
DEF VAR nv_insref      AS CHAR FORMAT "x(10)" INIT "" .

DEFINE VAR putchr       AS CHAR FORMAT "X(200)" INIT "" NO-UNDO. 
DEFINE VAR putchr1      AS CHAR FORMAT "X(100)" INIT "" NO-UNDO.  
DEFINE VAR nv_typ       AS CHAR FORMAT "X(2)".                   
/* DEF BUFFER buwm100      FOR sic_bran.uwm100 .                     */
DEF VAR nv_seq         AS INTEGER  INIT  1.
DEF VAR nv_sum         AS INTEGER  INIT  0.
DEF VAR nv_checkdigit  AS INTEGER  . 

/* add by : A64-0138 */
DEFINE NEW SHARED TEMP-TABLE wkuwd132 LIKE stat.pmuwd132.
DEF    VAR nv_cstflg  AS CHAR FORMAT "X(2)".     /*C=CC ; S=Seat ; T=Tons ; W=Watts*/  
DEFINE VAR nv_engcst  AS DECI FORMAT ">>>>>9.99".

DEFINE VAR nv_driage1 AS INTE FORMAT ">>9".
DEFINE VAR nv_driage2 AS INTE FORMAT ">>9".
DEF    VAR nv_pdprm0  AS DECI FORMAT ">>>,>>>,>>9.99-". /*���¼��Ѻ���*/
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

DEFINE VAR nv_ncbp    AS DECI FORMAT ">,>>9.99-".
DEFINE VAR nv_fletp   AS DECI FORMAT ">,>>9.99-".
DEFINE VAR nv_dspcp   AS DECI FORMAT ">,>>9.99-".
DEFINE VAR nv_dstfp   AS DECI FORMAT ">,>>9.99-".
DEFINE VAR nv_clmp    AS DECI FORMAT ">,>>9.99-".

DEFINE VAR nv_netprem AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_gapprem AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_flagprm AS CHAR FORMAT "X(2)". /* N=Net,G=Gross */

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
DEFINE VAR nv_41prmt   AS DECI FORMAT ">>>,>>>,>>9.99-".  /* fleet */
DEFINE VAR nv_42prmt   AS DECI FORMAT ">>>,>>>,>>9.99-".  /* fleet */
DEFINE VAR nv_43prmt   AS DECI FORMAT ">>>,>>>,>>9.99-".  /* fleet */
DEFINE VAR nv_pdprem   AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_status   AS CHAR .   /*fleet YES=Complete , NO=Not Complete */ 
/* end A64-0138 */
DEFINE VAR nv_mv411 AS DECIMAL.
DEFINE VAR nv_mv412 AS DECIMAL.
DEFINE VAR nv_mv42  AS DECIMAL.
DEFINE VAR nv_mv43  AS DECIMAL.
DEF    VAR nv_411t  AS DECIMAL.    
DEF    VAR nv_412t  AS DECIMAL.    
DEF    VAR nv_42t   AS DECIMAL.    
DEF    VAR nv_43t   AS DECIMAL.
/* A67-0076 */
DEF VAR n_count AS INTE INIT 0.
DEF VAR no_policy AS CHAR FORMAT "x(20)" .
DEF VAR no_rencnt AS CHAR FORMAT "99".
DEF VAR no_endcnt AS CHAR FORMAT "999".
DEF VAR no_riskno AS CHAR FORMAT "999".
DEF VAR no_itemno AS CHAR FORMAT "999".
/*def var nv_drivage1 as inte init 0 .*/
/*def var nv_drivage2 as inte init 0 .*/
def var nv_drivage3 as inte init 0 .
def var nv_drivage4 as inte init 0 .
def var nv_drivage5 as inte init 0 .
/*def var nv_drivbir1 as char init  "" .*/
/*def var nv_drivbir2 as char init  "" .*/
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
DEF VAR nv_driver   AS CHAR FORMAT "x(30)" . 

DEFINE NEW SHARED TEMP-TABLE ws0m009 
  FIELD policy     AS CHARACTER    INITIAL ""  
  FIELD lnumber    AS INTEGER   
  FIELD ltext      AS CHARACTER    INITIAL "" 
  FIELD ltext2     AS CHARACTER    INITIAL ""
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
/* end : A67-0076 */
/* A67-0114 */
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

DEFINE VAR nv_mainprm  AS DECI FORMAT ">>>,>>>,>>9.99-".   /*New*/ /* Main Premium ����������ѡ ��ͧ Name/Unname Premium (HG) */

DEFINE VAR  nv_atfltgap  AS DECI FORMAT ">>,>>>,>>9.99-".    /*New*/ /* �µ.NCB Premium */
DEFINE VAR  nv_atncbgap  AS DECI FORMAT ">>,>>>,>>9.99-".    /*New*/ /* �µ.DSPC Premium */
DEFINE VAR  nv_atdscgap  AS DECI FORMAT ">>,>>>,>>9.99-".    /*New*/ /* Package DG00 */

DEFINE VAR nv_levper  AS DECI.
DEFINE VAR nv_adjpaprm  AS LOGICAL. 
DEFINE VAR nv_adjprem   AS LOGICAL. 
DEFINE VAR nv_flgpol    AS CHAR.     /*NR=New RedPlate, NU=New Used Car, RN=Renew*/
DEFINE VAR nv_flgclm    AS CHAR.     /*NC=NO CLAIM , WC=With Claim*/

DEFINE VAR cv_lfletper  AS DECI FORMAT ">,>>9.99-".  /*Limit Fleet % 10%*/
DEFINE VAR cv_lncbper   AS DECI FORMAT ">,>>9.99-".  /*Limit NCB %  50%*/
DEFINE VAR cv_ldssper   AS DECI FORMAT ">,>>9.99-".  /*Limit DSPC % �óջ���ᴧ 110  �� 45%  �͡����� 30% 35%*/
DEFINE VAR cv_lclmper   AS DECI FORMAT ">,>>9.99-".  /*Limit Claim % �ó���� Load Claim �� New 0% or 50% , Renew 0% or 20 - 50%  0%*/
DEFINE VAR cv_ldstfper  AS DECI FORMAT ">,>>9.99-".  /*Limit DSTF % 0%*/
DEFINE VAR nv_reflag    AS LOGICAL INIT NO.          /*�ó�����ͧ��� Re-Calculate ��� Yes*/
/*-- �.�.�.05 Charger --*/
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

/*
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
DEF VAR nv_dconsent AS CHAR INIT "" .*/

DEF VAR nv_drivname AS CHAR INIT "" .
/* add by : A67-0114  */
