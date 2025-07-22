/*program_id   : wgwtsge2.w                                               */ 
/*programname  : Load text file TIL-RE to GW  -สำหรับงานต่ออายุ           */ 
/* Copyright  : Safety Insurance Public Company Limited                   */  
/*                            บริษัท ประกันคุ้มภัย จำกัด (มหาชน)          */  
/*create by   : Kridtiya i. A53-0374   date. 22/11/2010                   
               ปรับโปรแกรมให้สามารถนำเข้า text file TIL-renew to GW system*/ 
/*copy write  : wgwargen.w                                                */ 
/*modify by   : Kridtiya i. A54-0112 ขยายช่องทะเบียนรถ จาก 10 เป็น 11 หลัก*/
/*modify by   : Kridtiya i. A56-0217 เพิ่มเลขบัตรประจำตัวผู้เอาประกัน     */
/*modify by   : Kridtiya i. A56-0262 เพิ่มส่วนการแปลงไฟล์ที่หน้าจอการนำเข้าข้อมูล*/
/*modify  by  : Kridtiya i. A57-0010 date . 15/01/2014 add pretxt (F6)add driver    */
/*modify  by  : Kridtiya i. A57-0226 date . 30/06/2014 add file non-til  */
DEFINE NEW SHARED WORKFILE wdetail2 NO-UNDO 
    FIELD number           AS CHAR FORMAT "x(10)"  INIT ""  
    FIELD Contract_No      AS CHAR FORMAT "x(20)"  INIT ""  
    FIELD Ref_no           AS CHAR FORMAT "x(20)"  INIT ""  
    FIELD ntitle           AS CHAR FORMAT "x(40)"  INIT ""  
    FIELD insurce          AS CHAR FORMAT "x(40)"  INIT ""  
    FIELD Surename         AS CHAR FORMAT "x(40)"  INIT ""  
    FIELD Contact_Address  AS CHAR FORMAT "x(55)"  INIT ""    
    FIELD Sub_District     AS CHAR FORMAT "x(40)"  INIT ""    
    FIELD District         AS CHAR FORMAT "x(40)"  INIT ""    
    FIELD Postcode         AS CHAR FORMAT "x(10)"  INIT ""    
    FIELD Landmark         AS CHAR FORMAT "x(100)" INIT ""  
    FIELD nColor           AS CHAR FORMAT "x(30)"  INIT "" 
    FIELD policy           AS CHAR FORMAT "x(25)"  INIT ""  
    FIELD branch           AS CHAR FORMAT "x(2)"   INIT ""   /*A57-0226*/
    FIELD contractno       AS CHAR FORMAT "x(15)"  INIT ""  
    FIELD insnam           AS CHAR FORMAT "x(60)"  INIT "" 
    FIELD insnam2          AS CHAR FORMAT "x(60)"  INIT ""   /* A56-0262 */
    FIELD address          AS CHAR FORMAT "x(160)" INIT ""  
    FIELD brand            AS CHAR FORMAT "x(30)"  INIT ""  
    FIELD model            AS CHAR FORMAT "x(30)"  INIT ""  
    FIELD ccolor           AS CHAR FORMAT "x(30)"  INIT ""  
    FIELD caryear          AS CHAR FORMAT "x(4)"   INIT ""  
    FIELD cc               AS CHAR FORMAT "x(10)"  INIT ""  
    FIELD Weight           AS CHAR FORMAT "x(10)"  INIT ""  
    FIELD finance_Comp     AS CHAR FORMAT "x(60)"  INIT "" 
    FIELD Insurance_Type   AS CHAR FORMAT "x(20)"  INIT "" 
    FIELD engno            AS CHAR FORMAT "x(25)"  INIT ""  
    FIELD chasno           AS CHAR FORMAT "x(25)"  INIT ""  
    FIELD vehreg           AS CHAR FORMAT "x(12)"  INIT "" 
    FIELD vehreg2          AS CHAR FORMAT "x(25)"  INIT ""  
    FIELD province         AS CHAR FORMAT "x(20)"  INIT ""  
    FIELD ins_compa        AS CHAR FORMAT "x(20)"  INIT "" 
    FIELD comdat           AS CHAR FORMAT "x(12)"  INIT ""  
    FIELD expdat           AS CHAR FORMAT "x(12)"  INIT ""  
    FIELD prvpol           AS CHAR FORMAT "x(25)"  INIT ""
    FIELD ins_si           AS CHAR FORMAT "x(30)"  INIT ""  
    FIELD ins_amt          AS CHAR FORMAT "x(30)"  INIT ""  
    FIELD prem_vo          AS CHAR FORMAT "x(30)"   INIT ""  
    FIELD sckno            AS CHAR FORMAT "x(20)"  INIT "" 
    FIELD prem_70          AS CHAR FORMAT "x(20)"  INIT "" 
    FIELD prem_70net       AS CHAR FORMAT "x(20)"  INIT "" 
    FIELD prem_72          AS CHAR FORMAT "x(20)"  INIT "" 
    FIELD prem_72net       AS CHAR FORMAT "x(20)"  INIT "" 
    FIELD Request_Date     AS CHAR FORMAT "x(20)"  INIT ""     
    FIELD companyins       AS CHAR FORMAT "x(10)"  INIT "" 
    FIELD policy72         AS CHAR FORMAT "x(16)"  INIT "" 
    FIELD comdat72         AS CHAR FORMAT "x(10)"  INIT "" 
    FIELD expdat72         AS CHAR FORMAT "x(10)"  INIT "" 
    FIELD notino           AS CHAR FORMAT "x(20)"  INIT ""  
    FIELD remark           AS CHAR FORMAT "x(100)" INIT ""
    FIELD sendContact_Addr AS CHAR FORMAT "x(60)"  INIT ""    
    FIELD sendSub_District AS CHAR FORMAT "x(35)"  INIT ""    
    FIELD sendDistrict     AS CHAR FORMAT "x(35)"  INIT ""    
    FIELD sendProvince     AS CHAR FORMAT "x(35)"  INIT ""    
    FIELD sendPostcode     AS CHAR FORMAT "x(10)"  INIT "" 
    FIELD mail             AS CHAR FORMAT "x(160)"  INIT ""  
    /*FIELD ref_no       AS CHAR FORMAT "x(20)"  INIT ""   /*A56-0217*/
    FIELD temp         AS CHAR FORMAT "x(20)"  INIT "" */  /*A56-0217*/
    FIELD ICNO         AS CHAR INIT "" FORMAT "x(15)"      /*A56-0217*/
    FIELD instyp       AS CHAR INIT "" FORMAT "x"          /*A56-0217*/
    FIELD sendnam      AS CHAR FORMAT "x(50)"  INIT ""  
    FIELD chkcar       AS CHAR FORMAT "x(50)"  INIT ""  
    FIELD telno        AS CHAR FORMAT "x(30)"  INIT ""  
    FIELD tiname       AS CHAR FORMAT "x(20)"  INIT ""
    FIELD add1         AS CHAR FORMAT "x(35)"  INIT "" 
    FIELD add2         AS CHAR FORMAT "x(35)"  INIT "" 
    FIELD add3         AS CHAR FORMAT "x(35)"  INIT "" 
    FIELD add4         AS CHAR FORMAT "x(20)"  INIT "" 
    FIELD scknumber    AS CHAR INIT "" FORMAT "x(20)"             /*stk      72*/
    FIELD docno        AS CHAR INIT "" FORMAT "x(10)"             /*Docno For 72*/
    FIELD net_prm      AS INT  FORMAT ">>>,>>>,>>9.99-"  INIT ""   /*24 A56-0262 Net Premium (Voluntary). */
    FIELD net_comp     AS INT  FORMAT ">>>,>>>,>>9.99-"  INIT ""   /*25 A56-0262 Net Premium (Compulsory) */
    FIELD class72      AS CHAR FORMAT "x(10)"  INIT "" 
    FIELD seat72       AS CHAR FORMAT "x(10)"  INIT "" 
    FIELD class70      AS CHAR FORMAT "x(10)"  INIT "" 
    FIELD seat70       AS CHAR FORMAT "x(10)"  INIT "" 
    FIELD np_f18line1  AS CHAR FORMAT "x(60)"  INIT "" 
    FIELD np_f18line2  AS CHAR FORMAT "x(60)"  INIT "" 
    FIELD np_f18line3  AS CHAR FORMAT "x(60)"  INIT "" 
    FIELD np_f18line4  AS CHAR FORMAT "x(60)"  INIT "" 
    FIELD np_f18line5  AS CHAR FORMAT "x(60)"  INIT "" .
DEFINE NEW SHARED TEMP-TABLE wdetail
    FIELD cedpol       AS CHAR FORMAT "x(20)" INIT "" 
    FIELD branch       AS CHAR FORMAT "x(10)" INIT "" 
    FIELD entdat       AS CHAR FORMAT "x(10)" INIT ""     
    FIELD enttim       AS CHAR FORMAT "x(10)" INIT ""      
    FIELD trandat      AS CHAR FORMAT "x(10)" INIT ""     
    FIELD trantim      AS CHAR FORMAT "x(10)" INIT ""      
    FIELD poltyp       AS CHAR FORMAT "x(3)"  INIT ""      
    FIELD policy       AS CHAR FORMAT "x(20)" INIT ""     
    FIELD prvpol       AS CHAR FORMAT "x(20)" INIT ""     
    FIELD comdat       AS CHAR FORMAT "x(10)" INIT ""     
    FIELD expdat       AS CHAR FORMAT "x(10)" INIT ""     
    FIELD compul       AS CHAR FORMAT "x"     INIT ""         
    FIELD tiname       AS CHAR FORMAT "x(15)" INIT ""     
    FIELD insnam       AS CHAR FORMAT "x(60)" INIT ""  
    FIELD insnam2      AS CHAR FORMAT "x(60)" INIT "" 
    FIELD iadd1        AS CHAR FORMAT "x(160)" INIT ""
    FIELD iadd2        AS CHAR FORMAT "x(35)" INIT ""
    FIELD iadd3        AS CHAR FORMAT "x(35)" INIT ""
    FIELD iadd4        AS CHAR FORMAT "x(20)" INIT ""
    FIELD prempa       AS CHAR FORMAT "x"     INIT ""         
    FIELD subclass     AS CHAR FORMAT "x(3)"  INIT ""      
    FIELD brand        AS CHAR FORMAT "x(30)" INIT ""
    FIELD model        AS CHAR FORMAT "x(50)" INIT ""
    FIELD cc           AS CHAR FORMAT "x(10)" INIT ""
    FIELD weight       AS CHAR FORMAT "x(10)" INIT ""
    FIELD seat         AS CHAR FORMAT "x(2)"  INIT ""
    FIELD body         AS CHAR FORMAT "x(25)" INIT ""
    /*FIELD vehreg       AS CHAR FORMAT "x(10)" INIT ""    *//*A54-0112 */
    FIELD vehreg       AS CHAR FORMAT "x(11)" INIT ""        /*A54-0112 */
    FIELD engno        AS CHAR FORMAT "x(25)" INIT ""     
    FIELD chasno       AS CHAR FORMAT "x(25)" INIT ""     
    FIELD caryear      AS CHAR FORMAT "x(4)"  INIT ""      
    FIELD carprovi     AS CHAR FORMAT "x(2)"  INIT ""      
    FIELD vehuse       AS CHAR FORMAT "x"     INIT ""         
    FIELD garage       AS CHAR FORMAT "x"     INIT ""         
    FIELD stk          AS CHAR FORMAT "x(15)" INIT ""     
    FIELD access       AS CHAR FORMAT "x"     INIT ""      
    FIELD covcod       AS CHAR FORMAT "x"     INIT ""         
    FIELD si           AS CHAR FORMAT "x(25)" INIT ""     
    FIELD volprem      AS CHAR FORMAT "x(20)" INIT ""     
    FIELD Compprem     AS CHAR FORMAT "x(20)" INIT ""     
    FIELD fleet        AS CHAR FORMAT "x(10)" INIT ""     
    FIELD ncb          AS CHAR FORMAT "x(10)" INIT "" 
    FIELD revday       AS CHAR FORMAT "x(10)" INIT "" 
    FIELD finint       AS CHAR FORMAT "x(10)" INIT ""
    FIELD deductpp     AS CHAR FORMAT "x(10)" INIT "500000"   /*deduct da*/
    FIELD deductba     AS CHAR FORMAT "x(10)" INIT "10000000" /*deduct da*/
    FIELD deductpa     AS CHAR FORMAT "x(10)" INIT "1000000"  /*deduct pd*/
    FIELD benname      AS CHAR FORMAT "x(50)" INIT ""         /*benificiary*/
    FIELD n_user       AS CHAR FORMAT "x(10)" INIT ""         /*user id*/
    FIELD n_IMPORT     AS CHAR FORMAT "x(2)"  INIT ""      
    FIELD n_export     AS CHAR FORMAT "x(2)"  INIT ""      
    FIELD cancel       AS CHAR FORMAT "x(2)" INIT ""         /*cancel*/
    FIELD WARNING      AS CHAR FORMAT "X(30)" INIT ""
    FIELD comment      AS CHAR FORMAT "x(512)"  INIT ""      
    FIELD seat41       AS INTE FORMAT "99" INIT 0         
    FIELD pass         AS CHAR FORMAT "x"  INIT "n"       
    FIELD OK_GEN       AS CHAR FORMAT "X" INIT "Y"        
    FIELD comper       AS CHAR INIT "50000"    FORMAT ">,>>>,>>>,>>>,>>9"                  
    FIELD comacc       AS CHAR INIT "50000"    FORMAT ">,>>>,>>>,>>>,>>9"                  
    FIELD NO_41        AS CHAR INIT "50000"   FORMAT ">,>>>,>>>,>>>,>>9"                  
    FIELD NO_42        AS CHAR INIT "50000"   FORMAT ">,>>>,>>>,>>>,>>9"                   
    FIELD NO_43        AS CHAR INIT "200000"  FORMAT ">,>>>,>>>,>>>,>>9"                  
    FIELD tariff       AS CHAR FORMAT "x(2)" INIT ""      
    FIELD baseprem     AS INTE FORMAT ">,>>>,>>>,>>>,>>9" INIT  0
    FIELD cargrp       AS CHAR FORMAT "x(2)" INIT ""      
    FIELD producer     AS CHAR FORMAT "x(10)" INIT ""      
    FIELD agent        AS CHAR FORMAT "x(10)" INIT ""      
    FIELD inscod       AS CHAR INIT ""   
    FIELD premt        AS CHAR FORMAT "x(10)" INIT ""
    FIELD redbook      AS CHAR INIT "" FORMAT "X(10)"     /*note add*/
    FIELD base         AS CHAR INIT "" FORMAT "x(8)"      /*Note add Base Premium 25/09/2006*/
    FIELD accdat       AS CHAR INIT "" FORMAT "x(10)"     /*Account Date For 72*/
    FIELD docno        AS CHAR INIT "" FORMAT "x(10)"     /*Docno For 72*/
    FIELD ICNO         AS CHAR INIT "" FORMAT "x(15)"     /*ICNO For COVER NOTE A51-0071 amparat*/
    FIELD CoverNote    AS CHAR INIT "" FORMAT "x(13)"     /* ระบุว่าเป็นงาน COVER NOTE A51-0071 amparat*/
    FIELD sendnam      AS CHAR FORMAT "x(50)"  INIT ""    
    FIELD chkcar       AS CHAR FORMAT "x(50)"  INIT ""    
    FIELD telno        AS CHAR FORMAT "x(30)"  INIT ""    
    FIELD insrefno     AS CHAR FORMAT "x(10)"  INIT ""    
    FIELD prmtxt       AS CHAR FORMAT "x(100)" INIT ""    
    FIELD instyp       AS CHAR INIT "" FORMAT "x" .       /*A56-0217*/  
DEFINE NEW SHARED WORKFILE wdetmemo NO-UNDO
    FIELD policymemo   AS CHAR FORMAT "x(12)"  INIT ""
    FIELD f18line1     AS CHAR FORMAT "x(60)"  INIT ""  
    FIELD f18line2     AS CHAR FORMAT "x(60)"  INIT ""  
    FIELD f18line3     AS CHAR FORMAT "x(60)"  INIT "" 
    FIELD f18line4     AS CHAR FORMAT "x(60)"  INIT "" 
    FIELD f18line5     AS CHAR FORMAT "x(60)"  INIT "" .
DEF NEW SHARED VAR     nv_message as   char.
DEF VAR nv_riskgp      LIKE sicuw.uwm120.riskgp  NO-UNDO.
/***--- Note Add Condition Base Premium ---***/
DEFINE NEW SHARED VAR no_baseprm  AS DECI  FORMAT ">>,>>>,>>9.99-".   /*note add test Base Premium 25/09/2006*/
DEFINE NEW SHARED VAR NO_basemsg  AS CHAR  FORMAT "x(50)" .           /*Warning Error If Not in Range 25/09/2006 */
DEFINE            VAR nv_accdat   AS DATE  FORMAT "99/99/9999" INIT ?  .     
DEFINE            VAR nv_docno    AS CHAR  FORMAT "9999999"    INIT " ".
DEFINE NEW SHARED VAR nv_batchyr  AS INT   FORMAT "9999"       INIT 0.
DEFINE NEW SHARED VAR nv_batcnt   AS INT   FORMAT "99"         INIT 0.
DEFINE NEW SHARED VAR nv_batchno  AS CHARACTER FORMAT "X(13)"  INIT ""  NO-UNDO.
DEFINE VAR  nv_batrunno  AS INT FORMAT  ">,>>9"          INIT 0.
DEFINE VAR  nv_imppol    AS INT  FORMAT ">>,>>9"         INIT 0.
DEFINE VAR  nv_impprem   AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.
DEFINE VAR  nv_batprev   AS CHARACTER FORMAT "X(13)"     INIT ""  NO-UNDO.
DEFINE VAR  nv_tmppolrun AS INTEGER FORMAT "999"         INIT 0.           /*Temp Policy Running No.*/
DEFINE VAR  nv_batbrn    AS CHARACTER FORMAT "x(2)"      INIT ""  NO-UNDO. /*Batch Branch*/
DEFINE VAR  nv_tmppol    AS CHARACTER FORMAT "x(16)"     INIT "".          /*Temp Policy*/
DEFINE VAR  nv_rectot    AS INT  FORMAT ">>,>>9"         INIT 0.           /* Display จำนวน ก/ธ ทั้งไฟล์ */
DEFINE VAR  nv_recsuc    AS INT  FORMAT ">>,>>9"         INIT 0.           /* Display จำนวน ก/ธ ที่นำเข้าได้ */
DEFINE VAR  nv_netprm_t  AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.           /* Display เบี้ยรวม ทั้งไฟล์ */
DEFINE VAR  nv_netprm_s  AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.           /* Display เบี้ยรวม ที่นำเข้าได้ */
DEFINE VAR  nv_batflg    AS LOG                          INIT NO.
DEFINE VAR  nv_txtmsg    AS CHAR FORMAT "x(50)"          INIT "".          /* Parameter คู่กับ nv_check */
DEFINE VAR  n_model      AS CHAR FORMAT "x(40)".
DEF VAR nv_export      AS char FORMAT "X(8)"    INIT "" .            /* A56-0262 */
DEF VAR ns_policyrenew AS CHAR FORMAT "x(30)"   INIT "" .            /* A56-0262 */       
DEF VAR ns_policy72    AS CHAR FORMAT "x(30)"   INIT "" .            /* A56-0262 */
DEFINE VAR  nv_driver    AS CHARACTER FORMAT "X(23)" INITIAL ""  .   /*A57-0010*/
DEFINE NEW SHARED WORKFILE ws0m009 NO-UNDO                           /*A57-0010*/
/*1*/  FIELD policy     AS CHARACTER    INITIAL ""                   /*A57-0010*/
/*2*/  FIELD lnumber    AS INTEGER                                   /*A57-0010*/
       FIELD ltext      AS CHARACTER    INITIAL ""                   /*A57-0010*/
       FIELD ltext2     AS CHARACTER    INITIAL "" .                 /*A57-0010*/
DEF VAR nv_drivage1 AS INTE INIT 0.                                  /*A57-0010*/
DEF VAR nv_drivage2 AS INTE INIT 0.                                  /*A57-0010*/
DEF VAR nv_nptr    AS RECID.                                         /*A57-0010*/
DEFINE  WORKFILE wuppertxt3 NO-UNDO                                  /*A57-0010*/
/*1*/  FIELD line     AS INTEGER   FORMAT ">>9"                      /*A57-0010*/
/*2*/  FIELD txt      AS CHARACTER FORMAT "X(78)"   INITIAL "".      /*A57-0010*/
DEFINE  WORKFILE wcomp NO-UNDO                                            /*A57-0010*/
/*1*/      FIELD package     AS CHARACTER FORMAT "X(10)"   INITIAL ""     /*A57-0010*/
/*2*/      FIELD premcomp    AS DECI FORMAT "->>,>>9.99"    INITIAL 0.    /*A57-0010*/
DEF VAR np_number           AS CHAR FORMAT "x(10)"  INIT "" .                      
DEF VAR np_Contract_No      AS CHAR FORMAT "x(10)"  INIT "" .      
DEF VAR np_Ref_no           AS CHAR FORMAT "x(15)"  INIT "" .      
DEF VAR np_comdat           AS CHAR FORMAT "x(10)"  INIT "" .      
DEF VAR np_expdat           AS CHAR FORMAT "x(10)"  INIT "" .      
DEF VAR np_ntitle           AS CHAR FORMAT "x(20)"  INIT "" .      
DEF VAR np_insurce          AS CHAR FORMAT "x(45)"  INIT "" .      
DEF VAR np_Surename         AS CHAR FORMAT "x(30)"  INIT "" .      
DEF VAR np_Contact_Address  AS CHAR FORMAT "x(35)"  INIT "" .      
DEF VAR np_Sub_District     AS CHAR FORMAT "x(35)"  INIT "" .      
DEF VAR np_District         AS CHAR FORMAT "x(35)"  INIT "" .      
DEF VAR np_Province         AS CHAR FORMAT "x(35)"  INIT "" .      
DEF VAR np_Postcode         AS CHAR FORMAT "x(10)"  INIT "" .      
DEF VAR np_Landmark         AS CHAR FORMAT "x(100)" INIT "" .       
DEF VAR np_Brand            AS CHAR FORMAT "x(30)"  INIT "" .      
DEF VAR np_nColor           AS CHAR FORMAT "x(30)"  INIT "" .      
DEF VAR np_model            AS CHAR FORMAT "x(55)"  INIT "" .      
DEF VAR np_License          AS CHAR FORMAT "x(10)"  INIT "" .       
DEF VAR np_Li_Province      AS CHAR FORMAT "x(30)"  INIT "" .      
DEF VAR np_Chassis          AS CHAR FORMAT "x(30)"  INIT "" .      
DEF VAR np_Engine           AS CHAR FORMAT "x(30)"  INIT "" .      
DEF VAR np_model_year       AS CHAR FORMAT "x(10)"  INIT "" .      
DEF VAR np_cc               AS CHAR FORMAT "x(5)"   INIT "" .     
DEF VAR np_Weight           AS CHAR FORMAT "x(5)"   INIT "" .     
DEF VAR np_finance_Comp     AS CHAR FORMAT "x(30)"  INIT "" .      
DEF VAR np_Insurance_Type   AS CHAR FORMAT "x(25)"  INIT "" .      
DEF VAR np_Insured_Amount   AS CHAR FORMAT "x(25)"  INIT "" .
DEF VAR np_netVol           AS CHAR FORMAT "x(25)"  INIT "" .  
DEF VAR np_Voluntary        AS CHAR FORMAT "x(25)"  INIT "" .
DEF VAR np_netCompul        AS CHAR FORMAT "x(20)"  INIT "" . 
DEF VAR np_Compulsory       AS CHAR FORMAT "x(20)"  INIT "" .        
DEF VAR np_nTotal           AS CHAR FORMAT "x(25)"  INIT "" .       
DEF VAR np_Request_Date     AS CHAR FORMAT "x(10)"  INIT "" .   
DEF VAR np_companyins       AS CHAR FORMAT "x(10)"  INIT "" .   
DEF VAR np_policy72         AS CHAR FORMAT "x(20)"  INIT "" .  
DEF VAR np_stk72            AS CHAR FORMAT "x(15)"  INIT "" .  
DEF VAR np_docno72          AS CHAR FORMAT "x(10)"  INIT "" .  
DEF VAR np_comdat72         AS CHAR FORMAT "x(10)"  INIT "" .   
DEF VAR np_expdat72         AS CHAR FORMAT "x(10)"  INIT "" .   
DEF VAR np_prepol           AS CHAR FORMAT "x(12)"  INIT "" .   
DEF VAR np_notino           AS CHAR FORMAT "x(12)"  INIT "" . 
DEF VAR np_packclass        AS CHAR FORMAT "x(12)"  INIT "" . 
DEF VAR np_seate            AS CHAR FORMAT "x(12)"  INIT "" . 
DEF VAR np_seate72          AS CHAR FORMAT "x(12)"  INIT "" . 
DEF VAR np_remark           AS CHAR FORMAT "x(150)" INIT "" .   
DEF VAR np_icno             AS CHAR FORMAT "x(10)"  INIT "" .   
DEF VAR np_sendContact_Addr AS CHAR FORMAT "x(60)"  INIT "" .   
DEF VAR np_sendSub_District AS CHAR FORMAT "x(35)"  INIT "" .  
DEF VAR np_sendDistrict     AS CHAR FORMAT "x(35)"  INIT "" .  
DEF VAR np_sendProvince     AS CHAR FORMAT "x(35)"  INIT "" .   
DEF VAR np_sendPostcode     AS CHAR FORMAT "x(10)"  INIT "" .
DEF VAR np_f18line1         AS CHAR FORMAT "x(60)"  INIT "" .
DEF VAR np_f18line2         AS CHAR FORMAT "x(60)"  INIT "" .
DEF VAR np_f18line3         AS CHAR FORMAT "x(60)"  INIT "" .
DEF VAR np_f18line4         AS CHAR FORMAT "x(60)"  INIT "" .
DEF VAR np_f18line5         AS CHAR FORMAT "x(60)"  INIT "" .
DEF VAR np_class72          AS CHAR FORMAT "x(10)"  INIT "" .
DEFINE VAR  n_insref     AS CHARACTER FORMAT "X(10)". 
DEFINE VAR  nv_messagein AS CHAR FORMAT "X(200)". 
DEFINE VAR  nv_usrid     AS CHARACTER FORMAT "X(08)".
DEFINE VAR  nv_transfer  AS LOGICAL   .
DEFINE VAR  n_check      AS CHARACTER .
DEFINE VAR  nv_insref    AS CHARACTER FORMAT "X(10)".  
DEFINE VAR  putchr       AS CHAR FORMAT "X(200)" INIT "" NO-UNDO.
DEFINE VAR  putchr1      AS CHAR FORMAT "X(100)" INIT "" NO-UNDO.
DEFINE VAR  nv_typ       AS CHAR FORMAT "X(2)".
