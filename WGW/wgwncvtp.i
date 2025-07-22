/*programid   : wgwntpis.i                                                        */
/*programname : load text file tpis to GW                                            */
/* Copyright  : Safety Insurance Public Company Limited 			                */
/*			    ����ѷ ��Сѹ������� �ӡѴ (��Ҫ�)				                    */
/*create by   : Ranu I. A58-0489  Date 20/09/2016         
                ����Ң�� TPIS ���ͧ�ҡ�ա������¹ format file ����               */ 
/*copy write  : wgwtsgen.i                                                           */
/*----------------------------------------------------------------------------------*/
/* Modify by : Ranu I. A62-0422 date 13/09/2019 ��������� Garage , Desmodel �Ѻ��Ҩҡ��� */
/*Modify by  : Kridtiya i. A63-0472 Date. 09/11/2020 add field firstname ,lastname.....*/
/*Modify by  : Ranu I. A64-0344 ��������á�äӹǳ���¨ҡ�������ҧ */
/*Modify by  : Ranu I. A64-0138 ����������纤�ҡ�äӹǳ���� */
/*Modify by  : Ranu I. A66-0252 ����������纤�ҵ�������Ŵ */
/*Modify by  : Kridtiya i. A68-0044 Date. 02/05/2025 Add driver for ICF */
 /*----------------------------- start A58-0489 -------------------------------------*/
DEFINE NEW SHARED TEMP-TABLE wdetail2 NO-UNDO  
   FIELD ins_ytyp                AS CHAR FORMAT "x(20)"         INIT ""      /*�������ҹ = ������اҹ����*/
   FIELD bus_typ                 AS CHAR FORMAT "x(20)"         INIT ""      /*��������áԨ */
   FIELD TASreceived             AS CHAR FORMAT "x(100)"        INIT ""      /*���Դ��ͧҹ*/     
   FIELD InsCompany              AS CHAR FORMAT "x(20)"         INIT ""      /*���ͺ���ѷ��Сѹ*/ 
   FIELD Insurancerefno          AS CHAR FORMAT "x(20)"         INIT ""      /*�Ţ����Ѻ�駪��Ǥ���*/
   FIELD tpis_no                 AS CHAR FORMAT "x(11)"         INIT ""      /*�Ţ����ѭ��*/
   FIELD ntitle                  AS CHAR FORMAT "x(20)"         INIT ""      /*�ӹ�˹�Ҫ���*/
   FIELD insnam                  AS CHAR FORMAT "x(100)"        INIT ""      /*����*/
   FIELD NAME2                   AS CHAR FORMAT "x(100)"        INIT ""      /*ʡ��*/   
   FIELD cust_type               AS CHAR FORMAT "x(1)"          INIT ""      /*�������١��� = �ؤ��, �ԵԺ�Ť� */
   FIELD nDirec                  AS CHAR FORMAT "x(100)"        INIT ""      /*�ؤ�� = ""  �ԵԺ�Ť� <> "" */
   FIELD ICNO                    AS CHAR FORMAT "x(20)"         INIT ""      /*�Ţ��ЪҪ�*/
   FIELD address                 AS CHAR FORMAT "x(60)"         INIT ""      /*��ҹ�Ţ���*/
   FIELD build                   AS CHAR FORMAT "x(60)"         INIT ""      /*�Ҥ��*/
   FIELD mu                      AS CHAR FORMAT "x(60)"         INIT ""      /*�����ҹ*/
   FIELD soi                     AS CHAR FORMAT "x(60)"         INIT ""      /*���*/
   FIELD road                    AS CHAR FORMAT "x(60)"         INIT ""      /*���*/
   FIELD tambon                  AS CHAR FORMAT "x(60)"         INIT ""      /*�Ӻ�*/
   FIELD amper                   AS CHAR FORMAT "x(60)"         INIT ""      /*�����*/
   FIELD country                 AS CHAR FORMAT "x(50)"         INIT ""      /*�ѧ��Ѵ*/
   FIELD post                    AS CHAR FORMAT "x(50)"         INIT ""      /*������ɳ���*/
   FIELD brand                   AS CHAR FORMAT "x(30)"         INIT ""      /*������*/
   FIELD model                   AS CHAR FORMAT "x(30)"         INIT ""      /*���ö*/
   FIELD class                   AS CHAR FORMAT "x(20)"         INIT ""      /*���ʺ���ѷ��Сѹ*/
   FIELD md_year                 AS CHAR FORMAT "x(20)"         INIT ""      /*�����ö*/
   FIELD Usage                   AS CHAR FORMAT "x(100)"        INIT ""      /*�����������ö*/
   FIELD coulor                  AS CHAR FORMAT "x(30)"         INIT ""      /*��ö*/
   FIELD cc                      AS CHAR FORMAT "x(20)"         INIT ""      /* ���˹ѡ CC.*/
   FIELD regis_year              AS CHAR FORMAT "x(20)"         INIT ""      /*������ö��*/
   FIELD engno                   AS CHAR FORMAT "x(40)"         INIT ""      /*�Ţ��Ƕѧ*/
   FIELD chasno                  AS CHAR FORMAT "x(25)"         INIT ""      /*�Ţ Chassis*/
   /*FIELD Acc_CV                  AS CHAR FORMAT "x(100)"        INIT ""  */    /*�ػ�ó������*/    /*A66-0252*/
   FIELD Acc_CV                  AS CHAR FORMAT "x(300)"        INIT ""       /*�ػ�ó������*/       /*A66-0252*/
   FIELD Acc_amount              AS CHAR FORMAT "x(100)"        INIT ""      /*�Ҥ��ػ�ó�*/
   FIELD License                 AS CHAR FORMAT "x(20)"         INIT ""      /*����¹*/
   FIELD regis_CL                AS CHAR FORMAT "x(100)"        INIT ""      /*�ѧ��Ѵ��訴����¹*/
   FIELD campaign                AS CHAR FORMAT "x(100)"        INIT ""      /*������໭*/
   FIELD typ_work                AS CHAR FORMAT "x(20)"         INIT ""      /* �������� 70 ,72*/
   FIELD si                      AS CHAR FORMAT "X(20)"         INIT ""      /* �ع��Сѹ */
   FIELD pol_comm_date           AS CHAR FORMAT "X(20)"         INIT ""      /*�ѹ������ͧ�ͧ ��.*/
   FIELD pol_exp_date            AS CHAR FORMAT "x(20)"         INIT ""      /*�ѹ������آͧ ��.*/
   FIELD LAST_pol                AS CHAR FORMAT "x(20)"         INIT ""      /* ����������� */
   FIELD cover                   AS CHAR FORMAT "x(20)"         INIT ""      /*����������������ͧ �.1 2 3 2+ 3+*/
   FIELD pol_netprem             AS CHAR FORMAT "X(15)"         INIT ""      /*�����ط�� (��.)*/
   FIELD pol_gprem               AS CHAR FORMAT "X(15)"         INIT ""      /*������ (��.)*/
   FIELD pol_stamp               AS CHAR FORMAT "X(15)"         INIT ""      /*�ʵ��� (��.)*/
   FIELD pol_vat                 AS CHAR FORMAT "X(15)"         INIT ""      /*Vat (��.)*/
   FIELD pol_wht                 AS CHAR FORMAT "X(15)"         INIT ""      /*wht (��.)*/
   FIELD com_no                  AS CHAR FORMAT "x(20)"         INIT ""      /* ���� �ú.*/
   FIELD stkno                   AS CHAR FORMAT "x(20)"         INIT ""      /* �Ţʵ������.*/
   FIELD com_comm_date           AS CHAR FORMAT "X(20)"         INIT ""      /* �ѹ��������ͧ �ú.*/
   FIELD com_exp_date            AS CHAR FORMAT "X(20)"         INIT ""      /* �ѹ���������� �ú.*/
   FIELD com_netprem             AS CHAR FORMAT "x(15)"         INIT ""      /* �����ط�� �ú.*/
   FIELD com_gprem               AS CHAR FORMAT "x(15)"         INIT ""      /* ������� �ú.*/
   FIELD com_stamp               AS CHAR FORMAT "x(15)"         INIT ""      /* �ʵ��� �ú.*/
   FIELD com_vat                 AS CHAR FORMAT "X(15)"         INIT ""      /* vat �ú.*/
   FIELD com_wht                 AS CHAR FORMAT "x(15)"         INIT ""      /* wht �ú.*/
   FIELD deler                   AS CHAR FORMAT "x(200)"        INIT ""      /* ���᷹ */
   FIELD showroom                AS CHAR FORMAT "x(200)"        INIT ""      /* ������ */
   FIELD typepay                 AS CHAR FORMAT "x(20)"         INIT ""      /*��������ê����Թ*/
   FIELD financename             AS CHAR FORMAT "x(200)"        INIT ""      /*����Ѻ�Ż���ª��*/           
   FIELD mail_hno                AS CHAR FORMAT "x(60)"         INIT ""      /*�������Ѵ��*/               
   FIELD mail_build              AS CHAR FORMAT "x(60)"         INIT ""      /*�������Ѵ��*/               
   FIELD mail_mu                 AS CHAR FORMAT "x(60)"         INIT ""      /*�������Ѵ��*/               
   FIELD mail_soi                AS CHAR FORMAT "x(60)"         INIT ""      /*�������Ѵ��*/               
   FIELD mail_road               AS CHAR FORMAT "x(60)"         INIT ""      /*�������Ѵ��*/               
   FIELD mail_tambon             AS CHAR FORMAT "x(60)"         INIT ""      /*�������Ѵ��*/               
   FIELD mail_amper              AS CHAR FORMAT "x(60)"         INIT ""      /*�������Ѵ��*/               
   FIELD mail_country            AS CHAR FORMAT "x(50)"         INIT ""      /*�������Ѵ��*/               
   FIELD mail_post               AS CHAR FORMAT "x(50)"         INIT ""      /*�������Ѵ��*/               
   FIELD send_date               AS CHAR FORMAT "x(20)"         INIT ""      /*�ѹ���Ѵ�觡�������*/        
   FIELD policy_no               AS CHAR FORMAT "x(20)"         INIT ""      /* �����������*/              
   FIELD send_data               AS CHAR FORMAT "x(20)"         INIT ""      /*�ѹ���Ѵ�觢�������� TPIS*/  
   /*FIELD REMARK1                 AS CHAR FORMAT "x(200)"        INIT ""  */   /*�����˵�*/  /*A66-0252*/
   FIELD REMARK1                 AS CHAR FORMAT "x(300)"        INIT ""      /*�����˵�*/     /*A66-0252*/  
   FIELD occup                   AS CHAR FORMAT "x(20)"         INIT ""      /*�Ҫվ*/                       
   FIELD regis_no                AS CHAR FORMAT "x(20)"         INIT ""      /*�Ţ���ŧ����¹*/ 
   FIELD np_f18line1             AS CHAR FORMAT "x(60)"         INIT "" 
   FIELD np_f18line2             AS CHAR FORMAT "x(60)"         INIT "" 
   FIELD np_f18line3             AS CHAR FORMAT "x(60)"         INIT "" 
   FIELD np_f18line4             AS CHAR FORMAT "x(60)"         INIT "" 
   FIELD np_f18line5             AS CHAR FORMAT "x(60)"         INIT "" 
   FIELD pol_typ                 AS CHAR FORMAT "x(3)"          INIT "" 
   FIELD financename2            AS CHAR FORMAT "x(10)"         INIT ""     
   FIELD branch                  AS CHAR FORMAT "x(10)"         INIT ""     
   FIELD baseprm                 AS CHAR FORMAT "x(10)"         INIT "" 
   FIELD delerco                 AS CHAR FORMAT "x(10)"         INIT "" 
   FIELD dealer_name2            AS CHAR FORMAT "x(60)"         INIT ""
   field campens                 as char format "X(50)"  init ""
   field producer                as char format "X(10)"  init ""
   field agent                   as char format "X(10)"  init ""
   field memotext                as char format "X(50)"  init ""
   field vatcode                 as char format "X(10)"  init ""
   field name02                  as char format "X(50)"  init ""
   FIELD bran_name               AS CHAR FORMAT "X(30)"  INIT ""
   FIELD bran_name2              AS CHAR FORMAT "X(15)"  INIT ""
   FIELD Region                  AS CHAR FORMAT "X(20)"  INIT ""
   FIELD ton                     AS CHAR FORMAT "x(5)"   INIT ""  /*A61-0152*/
   FIELD prempa                  AS CHAR FORMAT "x(2)"   INIT ""  /*A61-0152*/
   field garage                  as char format "X(25)"  INIT ""  /*a62-0422*/
   field desmodel                as char format "X(50)"  INIT ""  /*a62-0422*/
   FIELD codeocc                 AS CHAR FORMAT "x(4)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
   FIELD codeaddr1               AS CHAR FORMAT "x(2)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
   FIELD codeaddr2               AS CHAR FORMAT "x(2)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
   FIELD codeaddr3               AS CHAR FORMAT "x(2)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
   FIELD campaign_ov             AS CHAR FORMAT "x(30)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
   FIELD insnamtyp               AS CHAR FORMAT "x(60)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
   FIELD firstName               AS CHAR FORMAT "x(60)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
   FIELD lastName                AS CHAR FORMAT "x(60)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
   FIELD financecd               AS CHAR FORMAT "x(60)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
   field claimdi                 as char format "x(15)" init "" 
   field product                 as char format "x(15)" init "" 
   FIELD body                    AS CHAR FORMAT "x(35)"  INIT ""   /*a66-0252*/
   FIELD txterr                  AS CHAR FORMAT "x(100)" INIT ""
   field Driver1_title           AS CHAR FORMAT "x(100)" INIT ""  
   field Driver1_name            AS CHAR FORMAT "x(100)" INIT ""  
   field Driver1_lastname        AS CHAR FORMAT "x(100)" INIT ""  
   FIELD Driver1_birthdate       AS CHAR FORMAT "x(20)"  INIT ""  
   FIELD Driver1_id_no           AS CHAR FORMAT "x(20)"  INIT ""  
   FIELD Driver1_license_no      AS CHAR FORMAT "x(20)"  INIT ""  
   FIELD Driver1_occupation      AS CHAR FORMAT "x(100)" INIT "" 
   FIELD Driver2_title           AS CHAR FORMAT "x(100)" INIT "" 
   FIELD Driver2_name            AS CHAR FORMAT "x(100)" INIT ""  
   FIELD Driver2_lastname        AS CHAR FORMAT "x(100)" INIT ""  
   FIELD Driver2_birthdate       AS CHAR FORMAT "x(20)"  INIT ""   
   FIELD Driver2_id_no           AS CHAR FORMAT "x(20)"  INIT ""   
   FIELD Driver2_license_no      AS CHAR FORMAT "x(20)"  INIT ""   
   FIELD Driver2_occupation      AS CHAR FORMAT "x(100)" INIT ""  
   FIELD Driver3_title           AS CHAR FORMAT "x(100)" INIT "" 
   FIELD Driver3_name            AS CHAR FORMAT "x(100)" INIT ""  
   FIELD Driver3_lastname        AS CHAR FORMAT "x(100)" INIT ""  
   FIELD Driver3_birthday        AS CHAR FORMAT "x(20)"  INIT ""   
   FIELD Driver3_id_no           AS CHAR FORMAT "x(20)"  INIT ""   
   FIELD Driver3_license_no      AS CHAR FORMAT "x(20)"  INIT ""   
   FIELD Driver3_occupation      AS CHAR FORMAT "x(100)" INIT ""  
   FIELD Driver4_title           AS CHAR FORMAT "x(100)" INIT "" 
   FIELD Driver4_name            AS CHAR FORMAT "x(100)" INIT ""  
   FIELD Driver4_lastname        AS CHAR FORMAT "x(100)" INIT ""  
   FIELD Driver4_birthdate       AS CHAR FORMAT "x(20)"  INIT ""   
   FIELD Driver4_id_no           AS CHAR FORMAT "x(20)"  INIT ""   
   FIELD Driver4_license_no      AS CHAR FORMAT "x(20)"  INIT ""   
   FIELD Driver4_occupation      AS CHAR FORMAT "x(100)" INIT ""  
   FIELD Driver5_title           AS CHAR FORMAT "x(100)" INIT "" 
   FIELD Driver5_name            AS CHAR FORMAT "x(100)" INIT ""  
   FIELD Driver5_lastname        AS CHAR FORMAT "x(100)" INIT ""  
   FIELD Driver5_birthdate       AS CHAR FORMAT "x(20)"  INIT ""   
   FIELD Driver5_id_no           AS CHAR FORMAT "x(20)"  INIT ""   
   FIELD Driver5_license_no      AS CHAR FORMAT "x(20)"  INIT ""   
   FIELD Driver5_occupation      AS CHAR FORMAT "x(100)" INIT ""  .
/*----------------------End A58-0489------------------------------------*/
DEFINE NEW SHARED TEMP-TABLE wdetail NO-UNDO
      FIELD cedpol      AS CHAR FORMAT "x(20)" INIT "" 
      FIELD branch      AS CHAR FORMAT "x(10)" INIT "" 
      FIELD entdat      AS CHAR FORMAT "x(10)" INIT ""     /*entry date*/
      FIELD enttim      AS CHAR FORMAT "x(8)"  INIT ""     /*entry time*/
      FIELD trandat     AS CHAR FORMAT "x(10)" INIT ""     /*tran date*/
      FIELD trantim     AS CHAR FORMAT "x(8)"  INIT ""     /*tran time*/
      FIELD poltyp      AS CHAR FORMAT "x(3)"  INIT ""     /*policy type*/
      FIELD policy      AS CHAR FORMAT "x(20)" INIT ""     /*policy*/       /*a40166 chg format from 12 to 16*/
      FIELD renpol      AS CHAR FORMAT "x(16)" INIT ""     /*renew policy*/ /*a40166 chg format from 12 to 16*/
      FIELD comdat      AS CHAR FORMAT "x(10)" INIT ""     /*comm date*/
      FIELD expdat      AS CHAR FORMAT "x(10)" INIT ""     /*expiry date*/
      FIELD compul      AS CHAR FORMAT "x"     INIT ""     /*compulsory*/
      FIELD tiname      AS CHAR FORMAT "x(15)" INIT ""     /*title*/
      FIELD insnam      AS CHAR FORMAT "x(50)" INIT ""     /*name*/
      FIELD name2       AS CHAR FORMAT "x(60)" INIT ""     /*name*/
      FIELD iadd1       AS CHAR FORMAT "x(35)" INIT ""     
      FIELD iadd2       AS CHAR FORMAT "x(35)" INIT ""     
      /*FIELD iadd3       AS CHAR FORMAT "x(34)" INIT ""  *//*A58-0136*/
      FIELD iadd3       AS CHAR FORMAT "x(35)" INIT ""      /*A58-0136*/
      FIELD iadd4       AS CHAR FORMAT "x(20)" INIT ""     
      FIELD prempa      AS CHAR FORMAT "x"     INIT ""     /*premium package*/
      FIELD subclass    AS CHAR FORMAT "x(3)"  INIT ""     /*sub class*/
      FIELD brand       AS CHAR FORMAT "x(30)" INIT ""
      FIELD model       AS CHAR FORMAT "x(50)" INIT ""
      FIELD cc          AS CHAR FORMAT "x(10)" INIT ""
      FIELD weight      AS CHAR FORMAT "x(10)" INIT ""
      FIELD seat        AS CHAR FORMAT "x(2)"  INIT ""
      FIELD body        AS CHAR FORMAT "x(20)" INIT ""
      /*FIELD vehreg      AS CHAR FORMAT "x(10)" INIT ""   /*vehicl registration*/*//*kridtiya i. A54-0112*/
      FIELD vehreg      AS CHAR FORMAT "x(11)" INIT ""     /*vehicl registration*//*kridtiya i. A54-0112*/
      FIELD engno       AS CHAR FORMAT "x(20)" INIT ""     /*engine no*/
      FIELD chasno      AS CHAR FORMAT "x(20)" INIT ""     /*chasis no*/
      FIELD caryear     AS CHAR FORMAT "x(4)"  INIT ""     
      FIELD carprovi    AS CHAR FORMAT "x(2)"  INIT ""     
      FIELD vehuse      AS CHAR FORMAT "x"     INIT ""     /*vehicle use*/
      FIELD garage      AS CHAR FORMAT "x"     INIT ""     
      FIELD stk         AS CHAR FORMAT "x(15)" INIT ""     /*--A51-0253---Amparat*/
      FIELD access      AS CHAR FORMAT "x"     INIT ""     /*accessories*/
      FIELD covcod      AS CHAR FORMAT "x"     INIT ""     /*cover type*/
      FIELD si          AS CHAR FORMAT "x(25)" INIT ""     /*sum insure*/
      FIELD volprem     AS CHAR FORMAT "x(20)" INIT ""     /*voluntory premium*/
      FIELD Compprem    AS CHAR FORMAT "x(20)" INIT ""     /*compulsory prem*/
      FIELD fleet       AS CHAR FORMAT "x(10)" INIT ""     /*fleet*/
      FIELD ncb         AS CHAR FORMAT "x(10)" INIT "" 
      FIELD revday      AS CHAR FORMAT "x(10)" INIT ""  
      FIELD finint      AS CHAR FORMAT "x(10)" INIT ""
      FIELD loadclm     AS CHAR FORMAT "x(10)" INIT ""     /*load claim*/
      /*FIELD deductpp    AS CHAR FORMAT "x(10)" INIT "500000"   */  /*deduct da*/  /*A61-0152*/
      /*FIELD deductba    AS CHAR FORMAT "x(10)" INIT "10000000" */  /*deduct da*/  /*A61-0152*/
      /*FIELD deductpa    AS CHAR FORMAT "x(10)" INIT "1000000"  */  /*deduct pd*/  /*A61-0152*/
      FIELD benname     AS CHAR FORMAT "x(50)" INIT ""         /*benificiary*/       
      FIELD n_user      AS CHAR FORMAT "x(10)" INIT ""         /*user id*/
      FIELD n_IMPORT    AS CHAR FORMAT "x(2)"  INIT ""      
      FIELD n_export    AS CHAR FORMAT "x(2)"  INIT ""      
      FIELD drivnam     AS CHAR FORMAT "x" INIT ""         
      FIELD drivnam1    AS CHAR FORMAT "x(50)" INIT ""     /*driver name1*/
      /*FIELD drivnam2    AS CHAR FORMAT "x(50)" INIT ""  */   /*driver name2*/
      FIELD drivbir1    AS CHAR FORMAT "X(10)" INIT ""     /*driver birth date*/
      /*FIELD drivbir2    AS CHAR FORMAT "X(10)" INIT ""     /*driver birth date*/*/
      /*FIELD drivage1    AS CHAR FORMAT "X(2)" INIT ""      /*driver age1*/*/
      /*FIELD drivage2    AS CHAR FORMAT "x(2)" INIT ""    /*driver age2*/*/
      FIELD cancel      AS CHAR FORMAT "x(2)" INIT ""      /*cancel*/
      FIELD WARNING     AS CHAR FORMAT "X(30)" INIT ""     
      FIELD comment     AS CHAR FORMAT "x(512)"  INIT ""   /*a490166 add format from 100 to 512*/
      FIELD seat41      AS INTE FORMAT "99" INIT 0         
      FIELD pass        AS CHAR FORMAT "x"  INIT "n"       
      FIELD OK_GEN      AS CHAR FORMAT "X" INIT "Y"  
    /* comment by A61-0152....
      FIELD comper      AS CHAR INIT "50000"    FORMAT ">,>>>,>>>,>>>,>>9"                  
      FIELD comacc      AS CHAR INIT "50000"    FORMAT ">,>>>,>>>,>>>,>>9"                  
      FIELD NO_41       AS CHAR INIT "50000"   FORMAT ">,>>>,>>>,>>>,>>9"                  
      FIELD NO_42       AS CHAR INIT "50000"   FORMAT ">,>>>,>>>,>>>,>>9"                   
      FIELD NO_43       AS CHAR INIT "200000"  FORMAT ">,>>>,>>>,>>>,>>9"  
    ... end A61-0152...*/ 
    /* create by A61-0152 ...*/
      FIELD deductpp    AS CHAR FORMAT "x(12)" INIT "0"   /*deduct da*/
      FIELD deductba    AS CHAR FORMAT "x(12)" INIT "0" /*deduct da*/
      FIELD deductpa    AS CHAR FORMAT "x(12)" INIT "0"  /*deduct pd*/
      FIELD comper      AS CHAR INIT "0"  FORMAT ">,>>>,>>>,>>>,>>9"                  
      FIELD comacc      AS CHAR INIT "0"  FORMAT ">,>>>,>>>,>>>,>>9"                  
      FIELD NO_411      AS CHAR INIT "0"  FORMAT ">,>>>,>>>,>>>,>>9" 
      FIELD NO_412      AS CHAR INIT "0"  FORMAT ">,>>>,>>>,>>>,>>9"  
      FIELD NO_42       AS CHAR INIT "0"  FORMAT ">,>>>,>>>,>>>,>>9"                   
      FIELD NO_43       AS CHAR INIT "0"  FORMAT ">,>>>,>>>,>>>,>>9" 
      FIELD dspc        AS CHAR INIT "0"  FORMAT ">>9.99"
      FIELD base3       AS CHAR INIT "0"  FORMAT ">,>>>,>>>,>>>,>>9"
      FIELD netprem     AS CHAR INIT "0"  FORMAT ">,>>>,>>>,>>>,>>9"
      FIELD polmaster   AS CHAR FORMAT "x(40)" INIT ""  /*A61-0152*/
     /* end A61-0152 */
      FIELD tariff      AS CHAR FORMAT "x(2)" INIT ""      
      FIELD baseprem    AS INTE FORMAT ">,>>>,>>>,>>>,>>9" INIT  0
      FIELD cargrp      AS CHAR FORMAT "x(2)" INIT ""      
      FIELD producer    AS CHAR FORMAT "x(7)" INIT ""      
      FIELD agent       AS CHAR FORMAT "x(7)" INIT ""      
      FIELD inscod      AS CHAR INIT ""   
      FIELD premt       AS CHAR FORMAT "x(10)" INIT ""
      FIELD redbook     AS CHAR INIT "" FORMAT "X(8)"      /*note add*/
      FIELD base        AS CHAR INIT "" FORMAT "x(8)"      /*Note add Base Premium 25/09/2006*/
      FIELD accdat      AS CHAR INIT "" FORMAT "x(10)"     /*Account Date For 72*/
      FIELD docno       AS CHAR INIT "" FORMAT "x(10)"     /*Docno For 72*/
      FIELD ICNO        AS CHAR INIT "" FORMAT "x(13)"     /*ICNO For COVER NOTE A51-0071 amparat*/
      FIELD CoverNote   AS CHAR INIT "" FORMAT "x(13)"     /* �к�����繧ҹ COVER NOTE A51-0071 amparat*/
      FIELD nmember     AS CHAR INIT "" FORMAT "x(13)"
      FIELD delerco     AS CHAR FORMAT "x(10)" INIT "" 
      FIELD n_telreq    AS CHAR FORMAT "x(100)" INIT ""    /*A57-0260*/
      FIELD remark1     AS CHAR FORMAT "x(100)" INIT ""    /*A58-0489*/
      FIELD occupn      AS CHAR FORMAT "x(35)"  INIT ""    /*A58-0489*/ 
      /*FIELD accdata     AS CHAR FORMAT "x(200)" INIT ""    /*A58-0489*/ */ /*A66-0252*/
      FIELD accdata     AS CHAR FORMAT "x(300)" INIT ""    /*A66-0252*/
      FIELD accamount   AS CHAR FORMAT "x(10)"  INIT ""    /*A58-0489*/
      field campens     as char format "X(50)"  init ""    /*A58-0489*/  
      field memotext    as char format "X(50)"  init ""    /*A58-0489*/  
      field vatcode     as char format "X(10)"  init ""    /*A58-0489*/  
      field name02      as char format "X(50)"  init ""    /*A58-0489*/   
      FIELD nDirec      AS CHAR FORMAT "x(60)"  INIT ""    /*A58-0489*/  
      FIELD ton         AS CHAR FORMAT "x(5)"   INIT ""   /*A61-0152*/
      FIELD Promo       AS CHAR FORMAT "x(5)"   INIT ""   /*A61-0152*/
      FIELD acctyp      AS CHAR FORMAT "x(3)"   INIT ""   /*A61-0152*/
      FIELD insnamtyp   AS CHAR FORMAT "x(60)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
      FIELD firstName   AS CHAR FORMAT "x(60)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
      FIELD lastName    AS CHAR FORMAT "x(60)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
      FIELD postcd      AS CHAR FORMAT "x(15)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
      FIELD codeocc     AS CHAR FORMAT "x(4)"   INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
      FIELD codeaddr1   AS CHAR FORMAT "x(2)"   INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
      FIELD codeaddr2   AS CHAR FORMAT "x(2)"   INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
      FIELD codeaddr3   AS CHAR FORMAT "x(2)"   INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
      FIELD br_insured  AS CHAR FORMAT "x(5)"   INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
      FIELD campaign_ov AS CHAR FORMAT "x(30)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
      FIELD financecd   AS CHAR FORMAT "x(60)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
      FIELD product     AS CHAR FORMAT "x(30)" INIT ""    /*A66-0252*/
      FIELD colors      AS CHAR FORMAT "x(30)" INIT ""    /*A66-0252*/
      FIELD memo        as char format "x(100)" init ""   /*A66-0252*/
      FIELD memo2       as char format "x(100)" init ""   /*A66-0252*/
      FIELD memo3       as char format "x(100)" init ""   /*A66-0252*/
      FIELD memo4       as char format "x(100)" init ""   /*A66-0252*/
      field Driver1_title           AS CHAR FORMAT "x(100)" INIT ""  
      field Driver1_name            AS CHAR FORMAT "x(100)" INIT ""  
      field Driver1_lastname        AS CHAR FORMAT "x(100)" INIT ""  
      FIELD Driver1_birthdate       AS CHAR FORMAT "x(20)"  INIT ""  
      FIELD Driver1_id_no           AS CHAR FORMAT "x(20)"  INIT ""  
      FIELD Driver1_license_no      AS CHAR FORMAT "x(20)"  INIT ""  
      FIELD Driver1_occupation      AS CHAR FORMAT "x(100)" INIT "" 
      FIELD Driver2_title           AS CHAR FORMAT "x(100)" INIT "" 
      FIELD Driver2_name            AS CHAR FORMAT "x(100)" INIT ""  
      FIELD Driver2_lastname        AS CHAR FORMAT "x(100)" INIT ""  
      FIELD Driver2_birthdate       AS CHAR FORMAT "x(20)"  INIT ""   
      FIELD Driver2_id_no           AS CHAR FORMAT "x(20)"  INIT ""   
      FIELD Driver2_license_no      AS CHAR FORMAT "x(20)"  INIT ""   
      FIELD Driver2_occupation      AS CHAR FORMAT "x(100)" INIT ""  
      FIELD Driver3_title           AS CHAR FORMAT "x(100)" INIT "" 
      FIELD Driver3_name            AS CHAR FORMAT "x(100)" INIT ""  
      FIELD Driver3_lastname        AS CHAR FORMAT "x(100)" INIT ""  
      FIELD Driver3_birthdate        AS CHAR FORMAT "x(20)"  INIT ""   
      FIELD Driver3_id_no           AS CHAR FORMAT "x(20)"  INIT ""   
      FIELD Driver3_license_no      AS CHAR FORMAT "x(20)"  INIT ""   
      FIELD Driver3_occupation      AS CHAR FORMAT "x(100)" INIT ""  
      FIELD Driver4_title           AS CHAR FORMAT "x(100)" INIT "" 
      FIELD Driver4_name            AS CHAR FORMAT "x(100)" INIT ""  
      FIELD Driver4_lastname        AS CHAR FORMAT "x(100)" INIT ""  
      FIELD Driver4_birthdate       AS CHAR FORMAT "x(20)"  INIT ""   
      FIELD Driver4_id_no           AS CHAR FORMAT "x(20)"  INIT ""   
      FIELD Driver4_license_no      AS CHAR FORMAT "x(20)"  INIT ""   
      FIELD Driver4_occupation      AS CHAR FORMAT "x(100)" INIT ""  
      FIELD Driver5_title           AS CHAR FORMAT "x(100)" INIT "" 
      FIELD Driver5_name            AS CHAR FORMAT "x(100)" INIT ""  
      FIELD Driver5_lastname        AS CHAR FORMAT "x(100)" INIT ""  
      FIELD Driver5_birthdate       AS CHAR FORMAT "x(20)"  INIT ""   
      FIELD Driver5_id_no           AS CHAR FORMAT "x(20)"  INIT ""   
      FIELD Driver5_license_no      AS CHAR FORMAT "x(20)"  INIT ""   
      FIELD Driver5_occupation      AS CHAR FORMAT "x(100)" INIT ""
      FIELD watt                    AS CHAR
      FIELD drilevel                AS CHAR FORMAT "x(100)" INIT "" .

   
def    NEW SHARED VAR   nv_message as   char.
DEF VAR nv_riskgp        LIKE sicuw.uwm120.riskgp     NO-UNDO.

/***--- Note Add Condition Base Premium ---***/
DEFINE NEW SHARED VAR no_baseprm AS DECI  FORMAT ">>,>>>,>>9.99-". /*note add test Base Premium 25/09/2006*/
DEFINE NEW SHARED VAR NO_basemsg AS CHAR  FORMAT "x(50)" .         /*Warning Error If Not in Range 25/09/2006 */
DEFINE            VAR nv_accdat  AS DATE  FORMAT "99/99/9999" INIT ?  .     
DEFINE            VAR nv_docno   AS CHAR  FORMAT "9999999"    INIT " ".
/*a490166*/
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
DEF    VAR  n_model      AS CHAR FORMAT "x(40)".
DEFINE VAR  n_titlenam   AS CHAR FORMAT "x(100)" .    /* kridtiya i. A57-0159*/
DEFINE VAR  n_name01     AS CHAR FORMAT "x(100)" .    /* kridtiya i. A57-0159*/
def var         nv_cnt   as  int  init 0.             /*A57-0260*/
DEFINE VARIABLE cvData      AS CHARACTER NO-UNDO.      /*A57-0260*/
DEFINE VARIABLE OKpressed   AS LOGICAL INITIAL TRUE.   /*A57-0260*/
DEF VAR         no_add      AS CHAR FORMAT "x(8)" .    /*A57-0260*/
DEF VAR         Branch_Name  AS CHAR FORMAT "x(30)"  INIT "" .  /*A57-0415*/
DEF VAR         Branch_Name2 AS CHAR FORMAT "x(30)"  INIT "" .  /*A57-0415*/
DEF VAR         nRegion      AS CHAR FORMAT "x(30)"  INIT "" .  /*A57-0415*/
/* ------A58-0489------- */
DEF VAR nv_acc6 AS CHAR FORMAT "x(60)" INIT "".      
DEF VAR nv_acc1 AS CHAR FORMAT "x(60)" INIT "".      
DEF VAR nv_acc2 AS CHAR FORMAT "x(60)" INIT "".      
DEF VAR nv_acc3 AS CHAR FORMAT "x(60)" INIT "".      
DEF VAR nv_acc4 AS CHAR FORMAT "x(60)" INIT "".      
DEF VAR nv_acc5 AS CHAR FORMAT "x(60)" INIT "". 
/*---- end A58-0489------------*/
DEF VAR nv_chkerror AS CHAR FORMAT "x(150)" INIT "".   /*Add by Kridtiya i. A63-0472*/
/*----- add by : A64-0344 ------ */
DEFINE NEW SHARED TEMP-TABLE wkuwd132 LIKE stat.pmuwd132.
DEF    VAR nv_cstflg  AS CHAR FORMAT "X(2)".     /*C=CC ; S=Seat ; T=Tons ; W=Watts*/  
DEFINE VAR nv_engcst  AS DECI FORMAT ">>>>>9.99".

DEFINE VAR nv_driage1 AS INTE FORMAT ">>9".
DEFINE VAR nv_driage2 AS INTE FORMAT ">>9".
DEFINE VAR nv_pdprm0  AS DECI FORMAT ">>>,>>>,>>9.99-".
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
DEFINE VAR nv_baseprm3 AS DECI FORMAT ">>,>>>,>>9.99-". 
/*--- end A64-0344 ----*/
/*Add A68-0044*/
DEF VAR nv_campcd AS CHAR.
DEF VAR nv_usrid AS CHAR.
DEF VAR nv_level AS INTE.
DEF VAR nv_levper AS INTE.
def var nv_412prmt  as deci.
def var nv_413prmt  as deci.
def var nv_414prmt  as deci.
DEF VAR nv_dodamt   AS DECI.
DEF VAR nv_dadamt AS DECI.
DEF VAR nv_dpdamt AS DECI.
DEF VAR nv_adjpaprm AS LOGICAL. 
DEF VAR nv_flgpol AS CHAR.
DEF VAR nv_flgclm AS CHAR.
DEF VAR cv_lncbper AS DECI.
DEF VAR nv_ncbamt AS DECI.
DEF VAR nv_fletamt AS DECI.
DEF VAR nv_dspcamt   as deci.
DEF VAR nv_dstfamt   as deci.
DEF VAR nv_clmamt    as deci.
DEF VAR nv_mainprm AS DECI.
DEF VAR nv_attgap  AS DECI FORMAT ">>,>>>,>>9.99-".
def var nv_atfltgap    AS DECI FORMAT ">>,>>>,>>9.99-".  
def var nv_atncbgap    AS DECI FORMAT ">>,>>>,>>9.99-".  
def var nv_atdscgap    AS DECI FORMAT ">>,>>>,>>9.99-".  
def var nv_packatt     AS CHARACTER FORMAT "X(4)".
def var nv_chgflg      AS LOGICAL.                           
def var nv_chgrate     AS DECI FORMAT ">>>9.9999-".      
def var nv_chgsi       AS INTE FORMAT ">>>,>>>,>>9-".    
def var nv_chgpdprm    AS DECI FORMAT ">>,>>>,>>9.99-".  
def var nv_chggapprm   AS DECI FORMAT ">>,>>>,>>9.99-".  
def var nv_battflg    AS LOGICAL.                        
def var nv_battrate   AS DECI FORMAT ">>>9.9999-".       
def var nv_battsi     AS INTE FORMAT ">>>,>>>,>>9-".     
def var nv_battprice  AS INTE FORMAT ">>>,>>>,>>9-".     
def var nv_battpdprm  AS DECI FORMAT ">>,>>>,>>9.99-".   
def var nv_battgapprm AS DECI FORMAT ">>,>>>,>>9.99-".   
def var nv_battyr     AS INTE FORMAT "9999".             
def var nv_battper    AS DECI FORMAT ">>9.99-".          
def var nv_flag       AS LOGICAL.                      
def var nv_garage     AS CHAR.                             
def var nv_31rate     AS DECI FORMAT ">>>9.99999-".        
def var nv_31prmt     AS DECI FORMAT ">>>,>>>,>>9.99-".  
def var nv_uom9_v     AS INTE FORMAT ">>>,>>>,>>9".   
 
def var nv_flgsht AS CHAR.      
def var nv_evflg  AS LOGICAL. 
DEF VAR no_policy AS CHAR.
def var no_rencnt       as char. 
def var no_endcnt       as char. 
def var no_riskno       as char. 
def var no_itemno       as char. 
def var nv_dribirth     as char. 
def var nv_dconsent     as char.  
def var nv_drivage3     as inte.
def var nv_drivage4     as inte.
def var nv_drivage5     as inte.
def var nv_dlevel       as inte.
def var nv_drivbir3     as char.
def var nv_drivbir4     as char.
def var nv_drivbir5     as char.
def var nv_dlevper      AS INTE.
DEF VAR n_count         AS INTE.
DEF VAR nv_ntitle    AS CHAR.
def var nv_name     as char.
def var nv_lname    as char.
def var nv_drinam   as char.
def var nv_dicno    as char.
def var nv_dgender  as char.
def var nv_dbirth   as char.
def var nv_dage     as INTE.
def var nv_doccup   as char.
def var nv_ddriveno as char.
def var nv_drivexp  as char. 
DEFINE VAR n_len_c AS INTE INIT 0.                   
DEFINE VAR n_cha_no AS CHAR FORMAT "x(25)" INIT "".  
DEF VAR np_70 AS CHAR FORMAT "x(15)" INIT "".        
DEF VAR np_72 AS CHAR FORMAT "x(15)" INIT "".    

/*Add A68-0044*/


