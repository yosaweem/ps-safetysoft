/*programid   : wgwtamnh.i                                                            */ 
/*programname : load text file Amanh                                                  */ 
/*Copyright   : Safety Insurance Public Company Limited 			                  */ 
/*			    บริษัท ประกันคุ้มภัย จำกัด (มหาชน)				                      */ 
/*create by   : Kridtiya i. A59-0145   date .  25/04/2016                             
                ปรับโปรแกรมให้สามารถนำเข้างาน Amanh to GW system                      */ 
/*modify by   : kridtiya i. A59-0183 add 41,42,43 name, address,vehreg                */
/*modify by   : Ranu I. A61-0386 เพิ่มตัวแปรเก็บข้อมูล text f7                        */                     
/*Modify by   : Ranu I. A62-0445 เพิ่มตัวแปรเก็บข้อมูล ผลการตรวจสภาพ                  */
/*Modify by   : Kridtiya i. A63-0472 Date. 09/11/2020 add field firstname ,lastname...*/
/*Modify by   : Ranu I. A64-0138 เพิ่มตัวแปรเก็บค่าการคำนวณเบี้ย */
/**************************************************************************************/
DEF VAR nv_number           AS CHAR INIT "" FORMAT "x(10)".
DEF VAR nv_senddate         AS CHAR INIT "" FORMAT "x(15)". 
DEF VAR nv_policy           AS CHAR INIT "" FORMAT "x(20)".
DEF VAR nv_policy72         AS CHAR INIT "" FORMAT "x(20)".
DEF VAR nv_comname          AS CHAR INIT "" FORMAT "x(60)".
DEF VAR nv_sendby           AS CHAR INIT "" FORMAT "x(60)". 
DEF VAR nv_brname           AS CHAR INIT "" FORMAT "x(50)". 
DEF VAR nv_covercar         AS CHAR INIT "" FORMAT "x(30)". 
DEF VAR nv_covertypecar     AS CHAR INIT "" FORMAT "x(30)".
DEF VAR nv_cover            AS CHAR INIT "" FORMAT "x(30)". 
DEF VAR nv_coverfree        AS CHAR INIT "" FORMAT "x(30)". 
DEF VAR nv_compfree         AS CHAR INIT "" FORMAT "x(30)". 
DEF VAR nv_comdat70         AS CHAR INIT "" FORMAT "x(10)".  
DEF VAR nv_expdat70         AS CHAR INIT "" FORMAT "x(10)". 
DEF VAR nv_title            AS CHAR INIT "" FORMAT "x(20)". 
DEF VAR nv_name1            AS CHAR INIT "" FORMAT "x(60)". 
DEF VAR nv_icno             AS CHAR INIT "" FORMAT "x(15)". 
DEF VAR nv_datbirth         AS CHAR INIT "" FORMAT "x(10)". 
DEF VAR nv_datbirthexp      AS CHAR INIT "" FORMAT "x(10)". 
DEF VAR nv_occup            AS CHAR INIT "" FORMAT "x(60)". 
DEF VAR nv_name2            AS CHAR INIT "" FORMAT "x(60)". 
DEF VAR nv_addr1            AS CHAR INIT "" FORMAT "x(150)". 
DEF VAR nv_addr2            AS CHAR INIT "" FORMAT "x(40)". 
DEF VAR nv_addr3            AS CHAR INIT "" FORMAT "x(40)". 
DEF VAR nv_addr4            AS CHAR INIT "" FORMAT "x(40)". 
DEF VAR nv_post             AS CHAR INIT "" FORMAT "x(20)". 
DEF VAR nv_phone            AS CHAR INIT "" FORMAT "x(30)". 
DEF VAR nv_driverno         AS CHAR INIT "" FORMAT "x(50)".
DEF VAR nv_driname1         AS CHAR INIT "" FORMAT "x(100)".  
DEF VAR nv_driname1gen      AS CHAR INIT "" FORMAT "x(20)".   
DEF VAR nv_driname1birth    AS CHAR INIT "" FORMAT "x(20)".   
DEF VAR nv_driname1occup    AS CHAR INIT "" FORMAT "x(60)".   
DEF VAR nv_driname1number   AS CHAR INIT "" FORMAT "x(15)". 
DEF VAR nv_driname2         AS CHAR INIT "" FORMAT "x(100)". 
DEF VAR nv_driname2gen      AS CHAR INIT "" FORMAT "x(20)". 
DEF VAR nv_driname2birth    AS CHAR INIT "" FORMAT "x(20)". 
DEF VAR nv_driname2occup    AS CHAR INIT "" FORMAT "x(60)". 
DEF VAR nv_driname2number   AS CHAR INIT "" FORMAT "x(15)".  
DEF VAR nv_nbrand           AS CHAR INIT "" FORMAT "x(30)".  
DEF VAR nv_nmodel           AS CHAR INIT "" FORMAT "x(60)". 
DEF VAR nv_nengno           AS CHAR INIT "" FORMAT "x(30)". 
DEF VAR nv_nchassis         AS CHAR INIT "" FORMAT "x(30)".  
DEF VAR nv_nengcc           AS CHAR INIT "" FORMAT "x(10)". 
DEF VAR nv_ncaryear         AS CHAR INIT "" FORMAT "x(5)".  
DEF VAR nv_nvehreg          AS CHAR INIT "" FORMAT "x(30)".  
DEF VAR nv_nvehreg2         AS CHAR INIT "" FORMAT "x(30)".  
DEF VAR nv_garage           AS CHAR INIT "" FORMAT "x(30)".  
DEF VAR nv_SUMINSURED       AS CHAR INIT "" FORMAT "x(20)".  
DEF VAR nv_npremt           AS CHAR INIT "" FORMAT "x(20)".  
DEF VAR nv_npremtnet        AS CHAR INIT "" FORMAT "x(20)".  
DEF VAR nv_npremtcomp       AS CHAR INIT "" FORMAT "x(20)".  
DEF VAR nv_npremtotle       AS CHAR INIT "" FORMAT "x(20)".  
DEF VAR nv_stkno            AS CHAR INIT "" FORMAT "x(15)". 
DEF VAR nv_vatname          AS CHAR INIT "" FORMAT "x(100)". 
DEF VAR nv_bennam           AS CHAR INIT "" FORMAT "x(100)".
DEF VAR nv_remak            AS CHAR INIT "" FORMAT "x(150)". 
DEF VAR nv_ispno            AS CHAR INIT "" FORMAT "x(50)". 
DEF VAR nv_prepol70         AS CHAR INIT "" FORMAT "x(25)". 
DEF VAR nv_cedpol           AS CHAR INIT "" FORMAT "x(25)".   /*A61-0386*/
def var nv_producer         as char init "" format "x(10)" .  /*A61-0386*/
def var nv_agent            as char init "" format "x(10)" .  /*A61-0386*/
DEF VAR nv_campaign_ov      AS CHAR FORMAT "x(30)" INIT "" .  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
DEF VAR nv_codeocc          AS CHAR FORMAT "x(30)" INIT "" .  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
DEF VAR nv_codeaddr1        AS CHAR FORMAT "x(30)" INIT "" .  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
DEF VAR nv_codeaddr2        AS CHAR FORMAT "x(30)" INIT "" .  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
DEF VAR nv_codeaddr3        AS CHAR FORMAT "x(30)" INIT "" .  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
DEF VAR nv_insnamtyp        AS CHAR FORMAT "x(60)" INIT "" .  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
DEF VAR nv_firstName        AS CHAR FORMAT "x(60)" INIT "" .  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
DEF VAR nv_lastName         AS CHAR FORMAT "x(60)" INIT "" .  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
DEF VAR nv_postcd           AS CHAR FORMAT "x(60)" INIT "" .  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
/*DEFINE  WORKFILE    wdetail2*/ /*comment by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
DEFINE  TEMP-TABLE  wdetail2     /*Add     by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
    FIELD wk_number           AS CHAR INIT "" FORMAT "x(10)"
    FIELD wk_senddate         AS CHAR INIT "" FORMAT "x(15)"
    FIELD wk_policy           AS CHAR INIT "" FORMAT "x(20)"
    FIELD wk_policy72         AS CHAR INIT "" FORMAT "x(20)"
    FIELD wk_comname          AS CHAR INIT "" FORMAT "x(70)"
    FIELD wk_sendby           AS CHAR INIT "" FORMAT "x(70)"
    FIELD wk_brname           AS CHAR INIT "" FORMAT "x(50)"
    FIELD wk_covercar         AS CHAR INIT "" FORMAT "x(30)"
    FIELD wk_covertypecar     AS CHAR INIT "" FORMAT "x(30)"
    FIELD wk_cover            AS CHAR INIT "" FORMAT "x(30)"
    FIELD wk_coverfree        AS CHAR INIT "" FORMAT "x(30)"
    FIELD wk_compfree         AS CHAR INIT "" FORMAT "x(30)"
    FIELD wk_comdat70         AS CHAR INIT "" FORMAT "x(10)"
    FIELD wk_expdat70         AS CHAR INIT "" FORMAT "x(10)"
    FIELD wk_title            AS CHAR INIT "" FORMAT "x(20)"
    FIELD wk_name1            AS CHAR INIT "" FORMAT "x(80)"
    FIELD wk_icno             AS CHAR INIT "" FORMAT "x(15)"
    FIELD wk_datbirth         AS CHAR INIT "" FORMAT "x(10)"
    FIELD wk_datbirthexp      AS CHAR INIT "" FORMAT "x(10)"
    FIELD wk_occup            AS CHAR INIT "" FORMAT "x(60)"
    FIELD wk_name2            AS CHAR INIT "" FORMAT "x(60)"
    FIELD wk_addr1            AS CHAR INIT "" FORMAT "x(150)"
    FIELD wk_addr2            AS CHAR INIT "" FORMAT "x(50)"
    FIELD wk_addr3            AS CHAR INIT "" FORMAT "x(50)"
    FIELD wk_addr4            AS CHAR INIT "" FORMAT "x(50)"
    FIELD wk_post             AS CHAR INIT "" FORMAT "x(20)"
    FIELD wk_phone            AS CHAR INIT "" FORMAT "x(30)"
    FIELD wk_driverno         AS CHAR INIT "" FORMAT "x(50)"
    FIELD wk_driname1         AS CHAR INIT "" FORMAT "x(100)"  
    FIELD wk_driname1gen      AS CHAR INIT "" FORMAT "x(20)"
    FIELD wk_driname1birth    AS CHAR INIT "" FORMAT "x(20)"
    FIELD wk_driname1occup    AS CHAR INIT "" FORMAT "x(60)"
    FIELD wk_driname1number   AS CHAR INIT "" FORMAT "x(15)"
    FIELD wk_driname2         AS CHAR INIT "" FORMAT "x(100)" 
    FIELD wk_driname2gen      AS CHAR INIT "" FORMAT "x(20)"
    FIELD wk_driname2birth    AS CHAR INIT "" FORMAT "x(20)"
    FIELD wk_driname2occup    AS CHAR INIT "" FORMAT "x(60)"
    FIELD wk_driname2number   AS CHAR INIT "" FORMAT "x(15)"
    FIELD wk_nbrand           AS CHAR INIT "" FORMAT "x(40)"
    FIELD wk_nmodel           AS CHAR INIT "" FORMAT "x(60)"
    FIELD wk_nengno           AS CHAR INIT "" FORMAT "x(30)"
    FIELD wk_nchassis         AS CHAR INIT "" FORMAT "x(30)"
    FIELD wk_nengcc           AS CHAR INIT "" FORMAT "x(10)"
    FIELD wk_ncaryear         AS CHAR INIT "" FORMAT "x(5)"
    FIELD wk_nvehreg          AS CHAR INIT "" FORMAT "x(30)"
    FIELD wk_nvehreg2         AS CHAR INIT "" FORMAT "x(30)"
    FIELD wk_garage           AS CHAR INIT "" FORMAT "x(30)"
    FIELD wk_SUMINSURED       AS CHAR INIT "" FORMAT "x(20)"
    FIELD wk_npremt           AS CHAR INIT "" FORMAT "x(20)"
    FIELD wk_npremtnet        AS CHAR INIT "" FORMAT "x(20)"
    FIELD wk_npremtcomp       AS CHAR INIT "" FORMAT "x(20)"
    FIELD wk_npremtotle       AS CHAR INIT "" FORMAT "x(20)"
    FIELD wk_stkno            AS CHAR INIT "" FORMAT "x(15)"
    FIELD wk_vatname          AS CHAR INIT "" FORMAT "x(100)"
    FIELD wk_bennam           AS CHAR INIT "" FORMAT "x(100)"
    FIELD wk_remak            AS CHAR INIT "" FORMAT "x(150)"
    FIELD wk_ispno            AS CHAR INIT "" FORMAT "x(50)"
    FIELD wk_prepol70         AS CHAR INIT "" FORMAT "x(25)"
    field wk_class            as char init "" format "X(4)"     /*a61-0386*/
    field wk_producer         as char init "" format "X(10)"    /*a61-0386*/
    field wk_agent            as char init "" format "X(10)"    /*a61-0386*/
    FIELD wk_result           AS CHAR INIT "" FORMAT "x(255)" . /*a62-0445*/
/*DEFINE  WORKFILE   wdetail*//*comment by Kridtiya i. A63-0472 Date. 09/11/2020*/
DEFINE  TEMP-TABLE wdetail    /*Add     by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD policy      AS CHAR FORMAT "x(16)"  INIT ""   
    FIELD covcod      AS CHAR FORMAT "x(5)"   INIT ""   
    FIELD producer    AS CHAR FORMAT "x(10)"  INIT ""   
    FIELD agent       AS CHAR FORMAT "x(10)"  INIT ""   
    FIELD inserf      AS CHAR FORMAT "x(10)"  INIT ""  
    FIELD promoti     AS CHAR FORMAT "x(20)"  INIT ""  
    FIELD vatcode     AS CHAR FORMAT "x(10)"  INIT ""   
    FIELD commission  AS DECI FORMAT ">>>,>>>,>>9.99-"  INIT ""     
    FIELD class       AS CHAR FORMAT "x(5)"   INIT ""   
    FIELD uom1_v      AS DECI FORMAT ">>>,>>>,>>9.99-"  INIT ""   
    FIELD uom2_v      AS DECI FORMAT ">>>,>>>,>>9.99-"  INIT "" 
    FIELD uom5_v      AS DECI FORMAT ">>>,>>>,>>9.99-"  INIT ""  
    FIELD si          AS CHAR FORMAT "x(20)"  INIT ""   
    FIELD fi          AS CHAR FORMAT "x(20)"  INIT ""   
    FIELD nv_41       AS DECI FORMAT ">>>,>>>,>>9.99-"  INIT "" 
    FIELD nv_42       AS DECI FORMAT ">>>,>>>,>>9.99-"  INIT ""   
    FIELD nv_43       AS DECI FORMAT ">>>,>>>,>>9.99-"  INIT ""  
    FIELD base        AS CHAR FORMAT "x(20)"  INIT ""   
    FIELD vehreg      AS CHAR FORMAT "x(11)"  INIT ""   
    FIELD brand       AS CHAR FORMAT "x(60)"  INIT ""   
    FIELD model       AS CHAR FORMAT "x(50)"  INIT ""   
    FIELD chassis     AS CHAR FORMAT "x(30)"  INIT ""   
    FIELD engno       AS CHAR FORMAT "x(30)"  INIT ""   
    FIELD caryear     AS CHAR FORMAT "x(5)"   INIT ""   
    FIELD comdat      AS CHAR FORMAT "x(10)"  INIT ""  
    FIELD expdat      AS CHAR FORMAT "x(10)"   INIT "" 
    FIELD n_rencnt    LIKE sicuw.uwm100.rencnt INITIAL ""
    FIELD n_endcnt    LIKE sicuw.uwm100.endcnt INITIAL ""
    FIELD n_branch    AS CHAR FORMAT "x(2)"    INIT "" 
    FIELD poltyp      AS CHAR FORMAT "x(3)"    INIT "" 
    FIELD tiname      AS CHAR FORMAT "x(20)"   INIT "" 
    FIELD insnam      AS CHAR FORMAT "x(60)"   INIT ""  
    FIELD name2       AS CHAR FORMAT "x(60)"   INIT ""     
    FIELD name3       AS CHAR FORMAT "x(60)"   INIT ""  
    FIELD occup       AS CHAR FORMAT "x(40)"   INIT ""
    FIELD fristdat    AS CHAR FORMAT "x(10)"   INIT ""  
    FIELD n_addr1     AS CHAR FORMAT "x(35)"   INIT ""     
    FIELD n_addr2     AS CHAR FORMAT "x(35)"   INIT ""     
    FIELD n_addr3     AS CHAR FORMAT "x(35)"   INIT ""     
    FIELD n_addr4     AS CHAR FORMAT "x(35)"   INIT ""     
    FIELD trandat     AS CHAR FORMAT "x(10)"   INIT "" 
    FIELD garage      AS CHAR FORMAT "x"       INIT "" 
    FIELD tariff      AS CHAR FORMAT "x"       INIT "9"
    FIELD redbook     AS CHAR FORMAT "X(10)"   INIT ""      
    FIELD body        AS CHAR FORMAT "x(30)"   INIT ""
    FIELD engcc       AS CHAR FORMAT "x(5)"    INIT ""
    FIELD Tonn        AS DECI FORMAT ">>,>>9.99-" 
    FIELD seat        AS CHAR FORMAT "x(2)"    INIT "" 
    FIELD cargrp      AS CHAR FORMAT "x"       INIT ""  
    FIELD vehuse      AS CHAR INIT "" FORMAT "x"
    FIELD benname     AS CHAR FORMAT "x(65)"   INIT "" 
    FIELD prmtxt      AS CHAR FORMAT "x(100)"  INIT ""
    FIELD seat41      AS INTE FORMAT "99"      INIT 0
    FIELD ncb         AS CHAR FORMAT "x(10)"   INIT ""  
    FIELD fleet       AS CHAR FORMAT "x(10)"   INIT "" 
    FIELD dspc        AS CHAR FORMAT "x(10)"   INIT ""
    FIELD stk         AS CHAR FORMAT "x(25)"   INIT ""  
    FIELD compul      AS CHAR FORMAT "x"       INIT ""   
    FIELD comment     AS CHAR FORMAT "x(512)"  INIT ""
    FIELD pass        AS CHAR FORMAT "x"       INIT "n" 
    FIELD WARNING     AS CHAR FORMAT "X(30)"   INIT ""
    FIELD OK_GEN      AS CHAR FORMAT "X"       INIT "Y" 
    FIELD premt       AS CHAR FORMAT "x(15)"   INIT ""  
    FIELD comp_prm    AS CHAR FORMAT "x(15)"   INIT ""  
    FIELD cndat       AS CHAR FORMAT "x(10)"   INIT ""  
    FIELD prepol      AS CHAR FORMAT "x(16)"   INIT ""  
    FIELD prem_r      AS CHAR FORMAT "x(14)"   INIT "" 
    FIELD comper      AS CHAR FORMAT "x(14)"   INIT ""   
    FIELD comacc      AS CHAR FORMAT "x(14)"   INIT ""   
    FIELD enttim      AS CHAR FORMAT "x(8)"    INIT ""       
    FIELD trantim     AS CHAR FORMAT "x(8)"    INIT ""       
    FIELD n_IMPORT    AS CHAR FORMAT "x(2)"    INIT ""       
    FIELD n_EXPORT    AS CHAR FORMAT "x(2)"    INIT "" 
    FIELD cr_2        AS CHAR FORMAT "x(12)"   INIT ""  
    FIELD docno       AS CHAR INIT "" FORMAT  "x(10)" 
    FIELD drivnam     AS CHAR FORMAT "x"       INIT "n" 
    FIELD cancel      AS CHAR FORMAT "x(2)"    INIT ""    
    FIELD accdat      AS CHAR INIT "" FORMAT  "x(10)"  
    FIELD nv_icno     AS CHAR FORMAT "x(13)" 
    FIELD datbirth    AS CHAR FORMAT "x(13)"
    FIELD datbirthexp AS CHAR FORMAT "x(13)"
    FIELD cedpol      AS CHAR INIT "" FORMAT "x(16)"
    field drivnam1    as char format "x(50)" init ""   /*A61-0386*/
    field sexdriv1    as char format "x(5)" init ""   /*A61-0386*/
    field bdatedri1   as char format "x(15)" init ""   /*A61-0386*/
    field occupdri1   as char format "x(50)" init ""   /*A61-0386*/
    field driveno1    as char format "x(15)" init ""   /*A61-0386*/
    field drivnam2    as char format "x(50)" init ""   /*A61-0386*/
    field sexdriv2    as char format "x(5)"  init ""   /*A61-0386*/
    field bdatedri2   as char format "x(15)" init ""   /*A61-0386*/
    field occupdri2   as char format "x(50)" init ""   /*A61-0386*/
    field driveno2    as char format "x(15)" init ""   /*A61-0386*/
    FIELD phone       AS CHAR FORMAT "x(20)" INIT ""   /*A61-0386*/
    FIELD campaign    AS CHAR FORMAT "x(20)" INIT ""   /*A61-0386*/
    /*FIELD dealerno  AS CHAR INIT "" FORMAT "x(10)"*/  
    FIELD insnamtyp   AS CHAR FORMAT "x(60)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD firstName   AS CHAR FORMAT "x(60)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD lastName    AS CHAR FORMAT "x(60)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD postcd      AS CHAR FORMAT "x(15)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeocc     AS CHAR FORMAT "x(4)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr1   AS CHAR FORMAT "x(2)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr2   AS CHAR FORMAT "x(2)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr3   AS CHAR FORMAT "x(2)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD br_insured  AS CHAR FORMAT "x(5)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD campaign_ov AS CHAR FORMAT "x(30)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/   
    FIELD financecd   AS CHAR FORMAT "x(60)" INIT "".  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/

/*DEFINE WORKFILE wtextaccf6*/ /*comment by Kridtiya i. A63-0472 Date. 09/11/2020*/
DEFINE TEMP-TABLE wtextaccf6   /*Add     by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD n_policytxt   AS CHAR  INIT "" FORMAT "x(100)"  
    FIELD n_textacc1    AS CHAR  INIT "" FORMAT "x(100)"   
    FIELD n_textacc2    AS CHAR  INIT "" FORMAT "x(100)"   
    FIELD n_textacc3    AS CHAR  INIT "" FORMAT "x(100)"   
    FIELD n_textacc4    AS CHAR  INIT "" FORMAT "x(100)"   
    FIELD n_textacc5    AS CHAR  INIT "" FORMAT "x(100)". 
/*DEFINE WORKFILE wtextf7*/  /*comment by Kridtiya i. A63-0472 Date. 09/11/2020*/
DEFINE TEMP-TABLE wtextf7    /*Add     by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD n_policytxt   AS CHAR  INIT "" FORMAT "x(100)"  
    FIELD nv_memof71    AS CHAR  INIT "" FORMAT "x(100)"  
    FIELD nv_memof72    AS CHAR  INIT "" FORMAT "x(100)"  
    FIELD nv_memof73    AS CHAR  INIT "" FORMAT "x(100)"  
    FIELD nv_memof74    AS CHAR  INIT "" FORMAT "x(100)"  
    FIELD nv_memof75    AS CHAR  INIT "" FORMAT "x(100)"
    FIELD nv_memof76    AS CHAR  INIT "" FORMAT "x(100)"  /*A61-0386*/
    FIELD nv_memof77    AS CHAR  INIT "" FORMAT "x(100)"  /*A61-0386*/
    FIELD nv_memof78    AS CHAR  INIT "" FORMAT "x(100)"  /*A61-0386*/
    FIELD nv_memof79    AS CHAR  INIT "" FORMAT "x(100)"  /*A61-0386*/
    FIELD nv_memof710   AS CHAR  INIT "" FORMAT "x(100)"  /*A61-0386*/
    FIELD nv_memof711   AS CHAR  INIT "" FORMAT "x(100)"  /*A61-0386*/
    FIELD nv_memof712   AS CHAR  INIT "" FORMAT "x(100)"  /*A61-0386*/
    FIELD nv_memof713   AS CHAR  INIT "" FORMAT "x(100)"  /*A61-0386*/ 
    FIELD nv_memof714   AS CHAR  INIT "" FORMAT "x(100)". /*A61-0386*/ 
/*DEFINE WORKFILE wtextf5*/  /*comment by Kridtiya i. A63-0472 Date. 09/11/2020*/
DEFINE TEMP-TABLE wtextf5    /*Add     by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD n_policytxt   AS CHAR  INIT "" FORMAT "x(100)"  
    FIELD nv_textf51    AS CHAR  INIT "" FORMAT "x(100)"  
    FIELD nv_textf52    AS CHAR  INIT "" FORMAT "x(100)"  
    FIELD nv_textf53    AS CHAR  INIT "" FORMAT "x(100)"  
    FIELD nv_textf54    AS CHAR  INIT "" FORMAT "x(100)"  
    FIELD nv_textf55    AS CHAR  INIT "" FORMAT "x(100)" .  
DEFINE NEW SHARED VAR  nv_message   AS char.                                        
DEFINE NEW SHARED VAR  NO_basemsg   AS CHAR      FORMAT "x(50)" .                       
DEFINE            VAR  nv_accdat    AS DATE      FORMAT "99/99/9999"    INIT ?  .         
DEFINE            VAR  nv_docno     AS CHAR      FORMAT "9999999"       INIT " ".         
DEFINE NEW SHARED VAR  nv_batchyr   AS INT       FORMAT "9999"          INIT 0.           
DEFINE NEW SHARED VAR  nv_batcnt    AS INT       FORMAT "99"            INIT 0.           
DEFINE NEW SHARED VAR  nv_batchno   AS CHARACTER FORMAT "X(13)"         INIT ""  NO-UNDO. 
DEFINE VAR             nv_batrunno  AS INT       FORMAT ">,>>9"         INIT 0.                 
DEFINE VAR             nv_imppol    AS INT       FORMAT ">>,>>9"        INIT 0.                  
DEFINE VAR             nv_impprem   AS DECI      FORMAT "->,>>>,>>9.99" INIT 0.                 
DEFINE VAR             nv_batprev   AS CHARACTER FORMAT "X(20)"         INIT ""  NO-UNDO.        
DEFINE VAR             nv_tmppolrun AS INTEGER   FORMAT "999"           INIT 0.                 
DEFINE VAR             nv_batbrn    AS CHARACTER FORMAT "x(2)"          INIT ""  NO-UNDO.       
DEFINE VAR             nv_tmppol    AS CHARACTER FORMAT "x(16)"         INIT "".                
DEFINE VAR             nv_rectot    AS INT       FORMAT ">>,>>9"        INIT 0.                 
DEFINE VAR             nv_recsuc    AS INT       FORMAT ">>,>>9"        INIT 0.                 
DEFINE VAR             nv_netprm_t  AS DECI      FORMAT "->,>>>,>>9.99" INIT 0.                
DEFINE VAR             nv_netprm_s  AS DECI      FORMAT "->,>>>,>>9.99" INIT 0.                
DEFINE VAR             nv_batflg    AS LOG       INIT NO.               
DEFINE VAR             nv_txtmsg    AS CHAR      FORMAT "x(50)"  INIT "".   
DEFINE VAR             np_dedod     AS CHAR      FORMAT "x(30)"  INIT "".  
DEFINE VAR             np_addod     AS CHAR      FORMAT "x(30)"  INIT "".  
DEFINE VAR             np_dedpd     AS CHAR      FORMAT "x(30)"  INIT "".  
DEFINE VAR             np_stf_per   AS CHAR      FORMAT "x(30)"  INIT "".  
DEFINE VAR             np_cl_per    AS CHAR      FORMAT "x(30)"  INIT "".  
DEFINE VAR             nn_dedod     AS CHAR      FORMAT "x(30)"  INIT "".  
DEFINE VAR             nn_addod     AS CHAR      FORMAT "x(30)"  INIT "".  
DEFINE VAR             nn_dedpd     AS CHAR      FORMAT "x(30)"  INIT "".  
DEFINE VAR             nn_stf_per   AS CHAR      FORMAT "x(30)"  INIT "".  
DEFINE VAR             nn_cl_per    AS CHAR      FORMAT "x(30)"  INIT "".  
DEFINE VAR             nv_line1     AS INTEGER   INITIAL 0       NO-UNDO. 
DEFINE VAR             nv_newsck    AS CHAR FORMAT "x(15)" INIT " ".            
DEFINE VAR             nv_uwm301trareg    LIKE sicuw.uwm301.cha_no INIT "".    
DEFINE VAR             gv_id        AS CHAR FORMAT "X(8)" NO-UNDO.                
DEFINE VAR             nv_pwd       AS CHAR NO-UNDO.                              
DEFINE VAR             stklen       AS INTE.                         
DEFINE VAR             dod0         AS DECI.                         
DEFINE VAR             dod1         AS DECI.                         
DEFINE VAR             dod2         AS DECI.                         
DEFINE VAR             dpd0         AS DECI.
DEF VAR nv_ckclass AS CHAR INIT "".  /* match class */
DEF VAR nv_ckcover AS CHAR INIT "".  /* match cover 1 2 3 2+ 3+ compulsary */
DEF VAR nv_chkbase AS DECI INIT 0.
DEF VAR nv_chkNCB  AS DECI INIT 0.
DEF VAR nv_egcc    AS DECI INIT 0.
DEF VAR nv_usrid     AS CHARACTER FORMAT "X(15)".  
DEFINE VAR nv_insref AS CHARACTER FORMAT "X(10)".          
DEFINE VAR n_insref  AS CHARACTER FORMAT "X(10)".  
/* DEF VAR nv_usrid     AS CHARACTER FORMAT "X(08)".  */
DEF VAR nv_transfer  AS LOGICAL   .                 
DEF VAR n_check      AS CHARACTER .                
DEF VAR nv_typ       AS CHAR FORMAT "X(2)".       
/* DEF VAR n_icno       AS CHAR FORMAT "x(13)".       */
DEFINE NEW SHARED WORKFILE wuwd132                                                                 
    FIELD prepol  AS CHAR FORMAT "x(20)" INIT ""                                                   
    FIELD bencod  AS CHAR FORMAT "x(30)" INIT ""                                                   
    FIELD benvar  AS CHAR FORMAT "x(40)" INIT ""                                                   
    FIELD gap_c   AS DECI FORMAT ">>>,>>>,>>9.99-"                                                 
    FIELD prem_c  AS DECI FORMAT ">>>,>>>,>>9.99-"  . 
/*DEFINE  WORKFILE   wuppertxt NO-UNDO *//*comment by Kridtiya i. A63-0472 Date. 09/11/2020*/
DEFINE  TEMP-TABLE wuppertxt NO-UNDO     /*Add     by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD line    AS INTEGER   FORMAT ">>9"                 
    FIELD txt     AS CHARACTER FORMAT "X(78)"   INITIAL "". 
/*DEFINE  WORKFILE   wuppertxt3 NO-UNDO */ /*comment by Kridtiya i. A63-0472 Date. 09/11/2020*/      
DEFINE  TEMP-TABLE wuppertxt3 NO-UNDO      /*Add     by Kridtiya i. A63-0472 Date. 09/11/2020*/    
    FIELD line    AS INTEGER   FORMAT ">>9"                  
    FIELD txt     AS CHARACTER FORMAT "X(78)"   INITIAL "".  
DEFINE VAR vAcProc_fil1 AS   CHAR.
DEFINE VAR vAcProc_fil2 AS   CHAR.
DEFINE VAR vAcProc_fil3 AS   CHAR.
/*-- Add ranu A61-0386--*/
DEF NEW  SHARED VAR nv_pdprm0   AS DECI FORMAT ">>,>>>,>>9.99-"  INITIAL 0  . 
DEFINE new  SHARED VAR nv_totlcod  AS CHAR  FORMAT "X(4)".
DEFINE new  SHARED VAR nv_totlprm  AS DECI  FORMAT ">>,>>>,>>9.99-".
DEFINE new  SHARED VAR nv_totlvar1 AS CHAR  FORMAT "X(30)".
DEFINE new  SHARED VAR nv_totlvar2 AS CHAR  FORMAT "X(30)".
DEFINE new  SHARED VAR nv_totlvar  AS CHAR  FORMAT "X(60)".
DEFINE new  SHARED VAR nv_44prm    AS INTEGER   FORMAT ">,>>>,>>9"  INITIAL 0 NO-UNDO.
DEFINE new  SHARED VAR nv_supecod  AS CHAR  FORMAT "X(4)".
DEFINE new  SHARED VAR nv_supeprm  AS DECI  FORMAT ">>,>>>,>>9.99-".
DEFINE new  SHARED VAR nv_supevar1 AS CHAR  FORMAT "X(30)".
DEFINE new  SHARED VAR nv_supevar2 AS CHAR  FORMAT "X(30)".
DEFINE new  SHARED VAR nv_supevar  AS CHAR  FORMAT "X(60)".
DEFINE new  SHARED VAR nv_supe00   AS DECI  FORMAT ">>,>>>,>>9.99-".
DEFINE new  SHARED VAR  nv_baseprm3 AS DECI      FORMAT ">>,>>>,>>9.99-".
DEFINE new  SHARED VAR  nv_sicod3   AS CHARACTER FORMAT "X(4)".
DEFINE new  SHARED VAR  nv_prem3    AS DECIMAL   FORMAT ">,>>>,>>9.99-"   INITIAL 0  NO-UNDO.
DEFINE new  SHARED VAR  nv_usecod3  AS CHARACTER FORMAT "X(4)".
DEFINE new  SHARED VAR  nv_prvprm3  AS DECI      FORMAT ">>,>>>,>>9.99-".
DEFINE new  SHARED VAR  nv_useprm3  AS DECI      FORMAT ">>,>>>,>>9.99-".
DEFINE new  SHARED VAR  nv_siprm3   AS DECI      FORMAT ">>,>>>,>>9.99-".
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
DEFINE new  SHARED VAR  nv_usevar4   as char format "x(60)" init "".
DEFINE new  SHARED VAR  nv_usevar5   as char format "x(60)" init "".
DEFINE new  SHARED VAR nv_usevar3   AS CHAR FORMAT "x(60)" INIT "" .
DEFINE new  SHARED VAR  nv_basecod3  AS CHAR FORMAT "x(60)" INIT "" . 
DEFINE new  SHARED VAR  nv_basevar3  as char format "x(60)" init "" .
DEFINE new  SHARED VAR  nv_basevar4  as char format "x(60)" init "" .
DEFINE new  SHARED VAR  nv_basevar5  as char format "x(60)" init "" .
DEFINE new  SHARED VAR  nv_sivar4    as char format "x(60)" init "" .             
DEFINE new  SHARED VAR  nv_sivar5    as char format "x(60)" init "" . 
DEFINE new  SHARED VAR  nv_sivar3    as char format "x(60)" init "" . 
/*-- End ranu A61-0386--*/
/*Add by Kridtiya i. A63-0472 Date. 09/11/2020 Move on wgwtamnh.w to wgwtamnh.i */ 
DEFINE VAR            nv_lnumber    AS INTE INIT 0.
DEFINE VAR            nv_provi      AS CHAR INIT "".
DEFINE VAR            n_rencnt      LIKE sicuw.uwm100.rencnt INITIAL "".
DEFINE VAR            nv_index      as   int  init  0. 
DEFINE VAR            n_endcnt      LIKE sicuw.uwm100.endcnt  INITIAL "".
DEFINE VAR            n_comdat      LIKE sicuw.uwm100.comdat  NO-UNDO.
DEFINE VAR            n_policy      LIKE sicuw.uwm100.policy  INITIAL "" .
DEFINE VAR            nv_daily      AS  CHARACTER FORMAT "X(1024)"     INITIAL ""  NO-UNDO.
DEFINE VAR            nv_reccnt     AS  INT  INIT  0.           /*all load record*/
DEFINE VAR            nv_completecnt    AS   INT   INIT  0.     /*complete record */
DEFINE VAR            s_riskgp    AS INTE FORMAT ">9".
DEFINE VAR            s_riskno    AS INTE FORMAT "999".
DEFINE VAR            s_itemno    AS INTE FORMAT "999". 
DEFINE VAR            nv_drivage1 AS INTE INIT 0.
DEFINE VAR            nv_drivage2 AS INTE INIT 0.
DEFINE VAR            nv_drivbir1 AS CHAR INIT "".
DEFINE VAR            nv_drivbir2 AS CHAR INIT "".
DEFINE VAR            nv_dept     as char format  "X(1)".
DEFINE VAR nv_undyr    as    char  init  ""    format   "X(4)".
DEFINE VAR n_newpol    Like  sicuw.uwm100.policy  init  "".
DEFINE VAR n_curbil    LIKE  sicuw.uwm100.curbil  NO-UNDO.
DEFINE VAR nv_lastno   As       Int.
DEFINE VAR nv_seqno    As       Int.
DEFINE VAR sv_xmm600   AS       RECID.
DEFINE VAR nv_stm_per  AS DECIMAL FORMAT ">9.99" INITIAL 0 NO-UNDO.
DEFINE VAR nv_tax_per  AS DECIMAL FORMAT ">9.99" INITIAL 0 NO-UNDO.
DEFINE VAR nv_com1_per AS DECIMAL FORMAT ">9.99" INITIAL 0 NO-UNDO.
DEFINE VAR nv_com1_prm AS DECIMAL FORMAT ">>>>>9.99-"      NO-UNDO.
DEFINE VAR s_130bp1    AS RECID                            NO-UNDO.
DEFINE VAR s_130fp1    AS RECID                            NO-UNDO.
DEFINE VAR nvffptr     AS RECID                            NO-UNDO.
DEFINE VAR n_rd132     AS RECID                            NO-UNDO.
DEFINE VAR nv_gap      AS DECIMAL                          NO-UNDO.
DEFINE VAR nv_fptr     AS RECID.
DEFINE VAR nv_bptr     AS RECID.
DEFINE VAR nv_nptr     AS RECID.
DEFINE VAR nv_gap2     AS DECIMAL                          NO-UNDO.
DEFINE VAR nv_prem2    AS DECIMAL                          NO-UNDO.
DEFINE VAR nv_rstp     AS DECIMAL                          NO-UNDO.
DEFINE VAR nv_rtax     AS DECIMAL                          NO-UNDO.
DEFINE VAR nv_key_a    AS DECIMAL INITIAL 0                NO-UNDO.
DEFINE VAR nv_rec100   AS RECID .
DEFINE VAR nv_rec120   AS RECID .
DEFINE VAR nv_rec130   AS RECID .
DEFINE VAR nv_rec301   AS RECID .
DEF VAR nv_simat   AS DECI.    /* A57-0186 */
DEF VAR nv_simat1  AS DECI.    /* A57-0186 */
DEF VAR nv_result  AS CHAR FORMAT "x(255)" . /*A62-0445*/
/*end.Add by Kridtiya i. A63-0472 Date. 09/11/2020 Move on wgwtamnh.w to wgwtamnh.i */ 
/* add by : A64-0138 */
DEFINE NEW SHARED TEMP-TABLE wkuwd132 LIKE stat.pmuwd132.
DEF    VAR nv_cstflg  AS CHAR FORMAT "X(2)".     /*C=CC ; S=Seat ; T=Tons ; W=Watts*/  
DEFINE VAR nv_engcst  AS DECI FORMAT ">>>>>9.99".

DEFINE VAR nv_driage1 AS INTE FORMAT ">>9".
DEFINE VAR nv_driage2 AS INTE FORMAT ">>9".
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
DEF    VAR  nv_chkerr AS CHAR FORMAT "x(250)"    INIT "" .  
DEFINE VAR nv_41prmt   AS DECI FORMAT ">>>,>>>,>>9.99-".  /* fleet */
DEFINE VAR nv_42prmt   AS DECI FORMAT ">>>,>>>,>>9.99-".  /* fleet */
DEFINE VAR nv_43prmt   AS DECI FORMAT ">>>,>>>,>>9.99-".  /* fleet */
DEFINE VAR nv_pdprem   AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_status   AS CHAR .   /*fleet YES=Complete , NO=Not Complete */
 /* end A64-0138 */


