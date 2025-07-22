/*modify by : Kridtiya i. A54-0344..ปรับค่าเริ่มต้นของ deductpp,deductba,deductpa เป็นค่าว่าง..*/
/*modify by : Kridtiya i. A55-0095..ปรับขยาย format ที่อยู่จาก 30 เป็น 40 ตัวอักษร             */
/*modify by : Kridtiya i. A54-0112 ขยายช่องทะเบียนรถ จาก 10 เป็น 11 หลัก                       */
/*modify by : Kridtiya i. A56-0021 เพิ่มข้อมูลลูกค้า วันเกิด เลขที่บัตร   */
/*modify by : Ranu I. A61-0335 เพิ่มการเก็บข้อมูล KK app  */
/*Modify by   : Kridtiya i. A63-0472 Date. 09/11/2020 add field firstname ,lastname.....*/
/*
DEFINE NEW SHARED WORKFILE wdetail2 NO-UNDO  
    FIELD createdat    AS CHAR FORMAT "x(10)" INIT ""    /*  1   */   
    FIELD createdat2   AS CHAR FORMAT "x(10)" INIT ""    /*  2   */ 
    FIELD compno       AS CHAR FORMAT "x(20)" INIT ""    /*  3   */ 
    FIELD brno         AS CHAR FORMAT "x(10)" INIT ""    /*  4   */ 
    FIELD brname       AS CHAR FORMAT "x(30)" INIT ""    /*  5   */ 
    FIELD cedno        AS CHAR FORMAT "x(10)" INIT ""    /*  6   */ 
    FIELD prevpol      AS CHAR FORMAT "x(15)" INIT ""    /*  7   */ 
    FIELD cedpol       AS CHAR FORMAT "x(15)" INIT ""    /*  8   */ 
    FIELD campaign     AS CHAR FORMAT "x(50)" INIT ""    /*  9   */ 
    FIELD subcam       AS CHAR FORMAT "x(50)" INIT ""    /*  10  */ 
    FIELD free         AS CHAR FORMAT "x(30)" INIT ""    /*  11  */ 
    FIELD typeins      AS CHAR FORMAT "x(20)" INIT ""    /*  12  */ 
    FIELD titlenam     AS CHAR FORMAT "x(15)" INIT ""    /*  13  */ 
    FIELD name1        AS CHAR FORMAT "x(30)" INIT ""    /*  14  */ 
    FIELD name2        AS CHAR FORMAT "x(30)" INIT ""    /*  15  */ 
    FIELD ad11         AS CHAR FORMAT "x(30)" INIT ""    /*  16  */ 
    FIELD ad12         AS CHAR FORMAT "x(30)" INIT ""    /*  17  */ 
    FIELD ad13         AS CHAR FORMAT "x(30)" INIT ""    /*  18  */ 
    FIELD ad14         AS CHAR FORMAT "x(30)" INIT ""    /*  19  */
    FIELD ad15         AS CHAR FORMAT "x(30)" INIT ""    /*  20  */
    FIELD ad21         AS CHAR FORMAT "x(30)" INIT ""    /*  21  */
    FIELD ad22         AS CHAR FORMAT "x(30)" INIT ""    /*  22  */ 
    FIELD ad3          AS CHAR FORMAT "x(30)" INIT ""    /*  23  */
    FIELD post         AS CHAR FORMAT "x(10)" INIT ""    /*  24  */
    FIELD covcod       AS CHAR FORMAT "x(2)"  INIT ""    /*  25  */
    FIELD garage       AS CHAR FORMAT "x(1)"  INIT ""    /*  26  */
    FIELD comdat       AS CHAR FORMAT "x(10)" INIT ""    /*  27  */
    FIELD expdat       AS CHAR FORMAT "x(10)" INIT ""    /*  28  */
    FIELD class        AS CHAR FORMAT "x(3)"  INIT ""    /*  29  */
    FIELD typecar      AS CHAR FORMAT "x(15)" INIT ""    /*  30  */
    FIELD brand        AS CHAR FORMAT "x(20)" INIT ""    /*  31  */
    FIELD model        AS CHAR FORMAT "x(50)" INIT ""    /*  32  */
    FIELD typenam      AS CHAR FORMAT "x(10)" INIT ""    /*  33  */
    /*FIELD vehreg       AS CHAR FORMAT "x(10)" INIT ""    /*  34  */*//*A54-0112*/
    FIELD vehreg       AS CHAR FORMAT "x(11)" INIT ""    /*  34  *//*A54-0112*/
    FIELD veh_country  AS CHAR FORMAT "x(20)" INIT ""    /*  35  */
    FIELD chassis      AS CHAR FORMAT "x(25)" INIT ""    /*  36  */  
    FIELD engno        AS CHAR FORMAT "x(25)" INIT ""    /*  37  */   
    FIELD caryear      AS CHAR FORMAT "x(10)" INIT ""    /*  38  */   
    FIELD cc           AS CHAR FORMAT "x(30)" INIT ""    /*  39  */   
    FIELD weigth       AS CHAR FORMAT "x(30)" INIT ""    /*  40  */   
    FIELD si           AS CHAR FORMAT "x(20)" INIT ""    /*  41  */   
    FIELD prem         AS CHAR FORMAT "x(15)" INIT ""    /*  42  */   
    FIELD si2          AS CHAR FORMAT "x(20)" INIT ""    /*  43  */   
    FIELD prem2        AS CHAR FORMAT "x(15)" INIT ""    /*  44  */   
    FIELD timeno       AS CHAR FORMAT "x(10)" INIT ""    /*  45  */   
    FIELD stk          AS CHAR FORMAT "x(15)" INIT ""    /*  46  */  
    FIELD compdatco    AS CHAR FORMAT "x(10)" INIT ""    /*  47  */  
    FIELD expdatco     AS CHAR FORMAT "x(10)" INIT ""    /*  48  */  
    FIELD compprm      AS CHAR FORMAT "x(15)" INIT ""    /*  49  */ 
    FIELD notifynam    AS CHAR FORMAT "x(50)" INIT ""    /*  50  */  
    FIELD memmo        AS CHAR FORMAT "x(50)" INIT ""    /*  51  */  
    FIELD drivnam1     AS CHAR FORMAT "x(50)" INIT ""    /*  52  */ 
    FIELD birdth1      AS CHAR FORMAT "x(20)" INIT ""    /*  53  */  
    FIELD drivnam2     AS CHAR FORMAT "x(50)" INIT ""    /*  54  */  
    FIELD birdth2      AS CHAR FORMAT "x(20)" INIT ""    /*  55  */ 
    FIELD invoice      AS CHAR FORMAT "x(50)" INIT ""    /*  56  */  
    FIELD addinvoice   AS CHAR FORMAT "x(60)" INIT ""    /*  57  */  
    FIELD datasystem   AS CHAR FORMAT "x(10)" INIT ""    /*  58  */  
    FIELD branch       AS CHAR FORMAT "x(3)"  INIT "" .      
    */  
DEFINE NEW SHARED TEMP-TABLE wdetail
      FIELD cedpol      AS CHAR FORMAT "x(20)" INIT "" 
      FIELD branch      AS CHAR FORMAT "x(10)" INIT "" 
      FIELD entdat      AS CHAR FORMAT "x(10)" INIT ""     /*entry date*/
      FIELD enttim      AS CHAR FORMAT "x(8)" INIT ""      /*entry time*/
      FIELD trandat     AS CHAR FORMAT "x(10)" INIT ""     /*tran date*/
      FIELD trantim     AS CHAR FORMAT "x(8)" INIT ""      /*tran time*/
      FIELD poltyp      AS CHAR FORMAT "x(3)" INIT ""      /*policy type*/
      FIELD policy      AS CHAR FORMAT "x(20)" INIT ""     /*policy*/       /*a40166 chg format from 12 to 16*/
      FIELD renpol      AS CHAR FORMAT "x(16)" INIT ""     /*renew policy*/ /*a40166 chg format from 12 to 16*/
      FIELD comdat      AS CHAR FORMAT "x(10)" INIT ""     /*comm date*/
      FIELD expdat      AS CHAR FORMAT "x(10)" INIT ""     /*expiry date*/
      FIELD compul      AS CHAR FORMAT "x" INIT ""         /*compulsory*/
      FIELD tiname      AS CHAR FORMAT "x(15)" INIT ""     /*title*/
      FIELD insnam      AS CHAR FORMAT "x(50)" INIT ""     /*name*/
      FIELD name2       AS CHAR FORMAT "x(50)" INIT ""    /*  15  */ 
      FIELD iadd1       AS CHAR FORMAT "x(35)" INIT ""
      FIELD iadd2       AS CHAR FORMAT "x(35)" INIT ""
      FIELD iadd3       AS CHAR FORMAT "x(34)" INIT ""
      FIELD iadd4       AS CHAR FORMAT "x(20)" INIT ""
      FIELD prempa      AS CHAR FORMAT "x" INIT ""         /*premium package*/
      FIELD subclass    AS CHAR FORMAT "x(3)" INIT ""      /*sub class*/
      FIELD brand       AS CHAR FORMAT "x(30)" INIT ""
      FIELD model       AS CHAR FORMAT "x(50)" INIT ""
      FIELD cc          AS CHAR FORMAT "x(10)" INIT ""
      FIELD weight      AS CHAR FORMAT "x(10)" INIT ""
      FIELD seat        AS CHAR FORMAT "x(2)" INIT ""
      FIELD body        AS CHAR FORMAT "x(20)" INIT ""
      /*FIELD vehreg      AS CHAR FORMAT "x(10)" INIT ""   /*vehicl registration*/*//*A54-0112*/
      FIELD vehreg      AS CHAR FORMAT "x(11)" INIT ""     /*vehicl registration*/  /*A54-0112*/
      FIELD engno       AS CHAR FORMAT "x(20)" INIT ""     /*engine no*/
      FIELD chasno      AS CHAR FORMAT "x(20)" INIT ""     /*chasis no*/
      FIELD caryear     AS CHAR FORMAT "x(4)" INIT ""      
      FIELD carprovi    AS CHAR FORMAT "x(2)" INIT ""    
      FIELD vehuse      AS CHAR FORMAT "x" INIT ""         /*vehicle use*/
      FIELD garage      AS CHAR FORMAT "x" INIT ""         
      FIELD stk         AS CHAR FORMAT "x(15)" INIT ""     /*--A51-0253---Amparat*/
      FIELD access      AS CHAR FORMAT "x" INIT ""       /*accessories*/
      FIELD covcod      AS CHAR FORMAT "x" INIT ""         /*cover type*/
      FIELD si          AS CHAR FORMAT "x(25)" INIT ""     /*sum insure*/
      FIELD volprem     AS CHAR FORMAT "x(20)" INIT ""     /*voluntory premium*/
      FIELD Compprem    AS CHAR FORMAT "x(20)" INIT ""     /*compulsory prem*/
      FIELD fleet       AS CHAR FORMAT "x(10)" INIT ""     /*fleet*/
      FIELD ncb         AS CHAR FORMAT "x(10)" INIT "" 
      FIELD revday      AS CHAR FORMAT "x(10)" INIT "" 
      /*FIELD finint      AS CHAR FORMAT "x(10)" INIT ""*/
     /* FIELD loadclm     AS CHAR FORMAT "x(10)" INIT "" */    /*load claim*/
      /*comment by Kridtiya i. A54-0344....
      FIELD deductpp    AS CHAR FORMAT "x(10)" INIT "100000"    /*deduct da*/
      FIELD deductba    AS CHAR FORMAT "x(10)" INIT "10000000"  /*deduct da*/
      FIELD deductpa    AS CHAR FORMAT "x(10)" INIT "600000"    /*deduct pd*/  
      comment by Kridtiya i. A54-0344.......*/
      /*add by Kridtiya i. A54-0344....*/
      FIELD deductpp    AS CHAR FORMAT "x(10)" INIT ""    /*deduct da*/
      FIELD deductba    AS CHAR FORMAT "x(10)" INIT ""    /*deduct da*/
      FIELD deductpa    AS CHAR FORMAT "x(10)" INIT ""    /*deduct pd*/
      /*add by Kridtiya i. A54-0344....*/
      FIELD benname     AS CHAR FORMAT "x(50)" INIT ""    /*benificiary*/
      FIELD n_user      AS CHAR FORMAT "x(10)" INIT ""    /*user id*/
      FIELD n_IMPORT    AS CHAR FORMAT "x(2)" INIT ""      
      FIELD n_export    AS CHAR FORMAT "x(2)" INIT ""      
      FIELD drivnam     AS CHAR FORMAT "x" INIT ""         
      FIELD drivnam1    AS CHAR FORMAT "x(50)" INIT ""     /*driver name1*/
      FIELD notifynam    AS CHAR FORMAT "x(50)" INIT ""    /*  50  */ 
      /*FIELD drivnam2    AS CHAR FORMAT "x(50)" INIT ""  */   /*driver name2*/
      /*FIELD drivbir1    AS CHAR FORMAT "X(10)" INIT ""     /*driver birth date*/
      FIELD drivbir2    AS CHAR FORMAT "X(10)" INIT ""     /*driver birth date*/
      FIELD drivage1    AS CHAR FORMAT "X(2)" INIT ""      /*driver age1*/*/
      /*FIELD drivage2    AS CHAR FORMAT "x(2)" INIT ""      /*driver age2*/*/
      FIELD cancel      AS CHAR FORMAT "x(2)" INIT ""      /*cancel*/
      FIELD WARNING     AS CHAR FORMAT "X(30)" INIT ""
      FIELD comment     AS CHAR FORMAT "x(512)"  INIT ""   /*a490166 add format from 100 to 512*/
      FIELD seat41      AS INTE FORMAT "99" INIT 0         
      FIELD pass        AS CHAR FORMAT "x"  INIT "n"       
      FIELD OK_GEN      AS CHAR FORMAT "X" INIT "Y"        
      FIELD comper      AS CHAR INIT "50000"    FORMAT ">,>>>,>>>,>>>,>>9"                  
      FIELD comacc      AS CHAR INIT "50000"    FORMAT ">,>>>,>>>,>>>,>>9"                  
      FIELD NO_41       AS CHAR INIT "50000"   FORMAT ">,>>>,>>>,>>>,>>9"                  
      FIELD NO_42       AS CHAR INIT "50000"   FORMAT ">,>>>,>>>,>>>,>>9"                   
      FIELD NO_43       AS CHAR INIT "200000"  FORMAT ">,>>>,>>>,>>>,>>9"                  
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
      FIELD CoverNote   AS CHAR INIT "" FORMAT "x(13)"    /* ระบุว่าเป็นงาน COVER NOTE A51-0071 amparat*/
      FIELD nmember     AS CHAR INIT "" FORMAT "x(255)"
      FIELD delerco     AS CHAR FORMAT "x(10)" INIT ""   
      FIELD birthday    AS CHAR INIT "" FORMAT "X(10)" 
      FIELD kkapp       AS CHAR INIT "" FORMAT "x(20)"      /*A61-0335*/
      FIELD financecd   AS CHAR FORMAT "x(60)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
      FIELD firstName   AS CHAR FORMAT "x(60)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
      FIELD lastName    AS CHAR FORMAT "x(60)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
      FIELD postcd      AS CHAR FORMAT "x(15)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
      FIELD codeocc     AS CHAR FORMAT "x(4)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
      FIELD codeaddr1   AS CHAR FORMAT "x(2)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
      FIELD codeaddr2   AS CHAR FORMAT "x(2)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
      FIELD codeaddr3   AS CHAR FORMAT "x(2)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
      FIELD br_insured  AS CHAR FORMAT "x(5)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
      FIELD campaign_ov AS CHAR FORMAT "x(30)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
      FIELD insnamtyp   AS CHAR FORMAT "x(60)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
      FIELD product     AS CHAR FORMAT "x(30)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
      FIELD dealer      AS CHAR FORMAT "x(30)" INIT "".   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 


DEF VAR nv_chkerror     AS CHAR FORMAT "x(250)" INIT "".  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
DEF VAR im_campaign_ov  AS CHAR FORMAT "x(30)" INIT "".   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
DEF VAR n_postcd        AS CHAR FORMAT "x(30)" INIT "".   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 


DEF NEW SHARED VAR   nv_message as   char.
DEF            VAR nv_riskgp        LIKE sicuw.uwm120.riskgp                                  NO-UNDO.
/***--- Note Add Condition Base Premium ---***/
DEFINE NEW SHARED VAR no_baseprm AS DECI  FORMAT ">>,>>>,>>9.99-". /*note add test Base Premium 25/09/2006*/
DEFINE NEW SHARED VAR NO_basemsg AS CHAR  FORMAT "x(50)" .         /*Warning Error If Not in Range 25/09/2006 */
DEFINE            VAR nv_accdat  AS DATE  FORMAT "99/99/9999" INIT ?  .     
DEFINE            VAR nv_docno   AS CHAR  FORMAT "9999999"    INIT " ".
DEFINE NEW SHARED VAR nv_batchyr AS INT FORMAT "9999"            INIT 0.
DEFINE NEW SHARED VAR nv_batcnt  AS INT FORMAT "99"              INIT 0.
DEFINE NEW SHARED VAR nv_batchno AS CHARACTER FORMAT "X(13)"     INIT ""  NO-UNDO.
DEFINE VAR  nv_batrunno  AS INT FORMAT  ">,>>9"          INIT 0.
DEFINE VAR  nv_imppol    AS INT  FORMAT ">>,>>9"         INIT 0.
DEFINE VAR  nv_impprem   AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.
DEFINE VAR  nv_batprev   AS CHARACTER FORMAT "X(13)"     INIT ""  NO-UNDO.
DEFINE VAR  nv_tmppolrun AS INTEGER FORMAT "999"         INIT 0. /*Temp Policy Running No.*/
DEFINE VAR  nv_batbrn    AS CHARACTER FORMAT "x(2)"      INIT ""  NO-UNDO. /*Batch Branch*/
DEFINE VAR  nv_tmppol    AS CHARACTER FORMAT "x(16)"     INIT "". /*Temp Policy*/
DEFINE VAR  nv_rectot    AS INT  FORMAT ">>,>>9"         INIT 0.  /* Display จำนวน ก/ธ ทั้งไฟล์ */
DEFINE VAR  nv_recsuc    AS INT  FORMAT ">>,>>9"         INIT 0.  /* Display จำนวน ก/ธ ที่นำเข้าได้ */
DEFINE VAR  nv_netprm_t  AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.  /* Display เบี้ยรวม ทั้งไฟล์ */
DEFINE VAR  nv_netprm_s  AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.  /* Display เบี้ยรวม ที่นำเข้าได้ */
DEFINE VAR  nv_batflg    AS LOG                          INIT NO.
DEFINE VAR  nv_txtmsg    AS CHAR FORMAT "x(50)"          INIT "".   /* Parameter คู่กับ nv_check */
DEF VAR n_model AS CHAR FORMAT "x(40)".
def var s_riskgp    AS INTE FORMAT ">9".
def var s_riskno    AS INTE FORMAT "999".
def var s_itemno    AS INTE FORMAT "999". 
DEF VAR nv_drivage1 AS INTE INIT 0.
DEF VAR nv_drivage2 AS INTE INIT 0.
DEF VAR nv_drivbir1 AS CHAR INIT "".
DEF VAR nv_drivbir2 AS CHAR INIT "".
def var nv_dept     as char format  "X(1)".
def NEW SHARED var  nv_branch     LIKE sicsyac.XMM023.BRANCH.  
def var nv_undyr    as    char  init  ""    format   "X(4)".
def var n_newpol    Like  sicuw.uwm100.policy  init  "".
def var n_curbil    LIKE  sicuw.uwm100.curbil  NO-UNDO.
def New shared  var      nv_makdes    as   char    .
def New shared  var      nv_moddes    as   char.
DEF Var nv_lastno As       Int.
Def Var nv_seqno  As       Int.
DEF VAR sv_xmm600 AS       RECID.

DEF VAR nv_stm_per  AS DECIMAL FORMAT ">9.99" INITIAL 0 NO-UNDO.
DEF VAR nv_tax_per  AS DECIMAL FORMAT ">9.99" INITIAL 0 NO-UNDO.
DEF VAR nv_com1_per AS DECIMAL FORMAT ">9.99" INITIAL 0 NO-UNDO.
DEF VAR nv_com1_prm AS DECIMAL FORMAT ">>>>>9.99-"      NO-UNDO.
DEF VAR s_130bp1    AS RECID                            NO-UNDO.
DEF VAR s_130fp1    AS RECID                            NO-UNDO.
DEF VAR nvffptr     AS RECID                            NO-UNDO.
DEF VAR n_rd132     AS RECID                            NO-UNDO.
DEF VAR nv_gap      AS DECIMAL                          NO-UNDO.
DEF VAR nv_fptr     AS RECID.
DEF VAR nv_bptr     AS RECID.
DEF VAR nv_gap2     AS DECIMAL                          NO-UNDO.
DEF VAR nv_prem2    AS DECIMAL                          NO-UNDO.
DEF VAR nv_rstp     AS DECIMAL                          NO-UNDO.
DEF VAR nv_rtax     AS DECIMAL                          NO-UNDO.
DEF VAR nv_key_a    AS DECIMAL INITIAL 0                NO-UNDO.
DEF VAR nv_rec100   AS RECID .
DEF VAR nv_rec120   AS RECID .
DEF VAR nv_rec130   AS RECID .
DEF VAR nv_rec301   AS RECID .
DEF VAR im_createdat   AS CHAR FORMAT "x(10)" INIT "" .  /*  1   */   
DEF VAR im_createdat2  AS CHAR FORMAT "x(10)" INIT "" .  /*  2   */ 
DEF VAR im_compno      AS CHAR FORMAT "x(20)" INIT "" .  /*  3   */ 
DEF VAR im_brno        AS CHAR FORMAT "x(10)" INIT "" .  /*  4   */ 
DEF VAR im_brnam       AS CHAR FORMAT "x(30)" INIT "" .  /*  5   */ 
DEF VAR im_cedno       AS CHAR FORMAT "x(10)" INIT "" .  /*  6   */ 
DEF VAR im_prevpol     AS CHAR FORMAT "x(15)" INIT "" .  /*  7   */ 
DEF VAR im_cedpol      AS CHAR FORMAT "x(15)" INIT "" .  /*  8   */ 
DEF VAR im_campaign    AS CHAR FORMAT "x(50)" INIT "" .  /*  9   */ 
DEF VAR im_subcam      AS CHAR FORMAT "x(50)" INIT "" .  /*  10  */ 
DEF VAR im_free        AS CHAR FORMAT "x(30)" INIT "" .  /*  11  */ 
DEF VAR im_typeins     AS CHAR FORMAT "x(20)" INIT "" .  /*  12  */ 
DEF VAR im_titlenam    AS CHAR FORMAT "x(15)" INIT "" .  /*  13  */ 
DEF VAR im_name1       AS CHAR FORMAT "x(30)" INIT "" .  /*  14  */ 
DEF VAR im_name2       AS CHAR FORMAT "x(30)" INIT "" .  /*  15  */ 
DEF VAR im_ad11        AS CHAR FORMAT "x(30)" INIT "" .  /*  16  */ 
DEF VAR im_ad12        AS CHAR FORMAT "x(30)" INIT "" .  /*  17  */ 
DEF VAR im_ad13        AS CHAR FORMAT "x(30)" INIT "" .  /*  18  */ 
DEF VAR im_ad14        AS CHAR FORMAT "x(30)" INIT "" .  /*  19  */
DEF VAR im_ad15        AS CHAR FORMAT "x(30)" INIT "" .  /*  20  */
DEF VAR im_ad21        AS CHAR FORMAT "x(30)" INIT "" .  /*  21  */
DEF VAR im_ad22        AS CHAR FORMAT "x(30)" INIT "" .  /*  22  */ 
DEF VAR im_ad3         AS CHAR FORMAT "x(30)" INIT "" .  /*  23  */
DEF VAR im_post        AS CHAR FORMAT "x(10)" INIT "" .  /*  24  */
DEF VAR im_covcodic    AS CHAR FORMAT "x(2)"  INIT "" .  /*  25  */
DEF VAR im_garage      AS CHAR FORMAT "x(1)"  INIT "" .  /*  26  */
DEF VAR im_comdatic    AS CHAR FORMAT "x(10)" INIT "" .  /*  27  */
DEF VAR im_expdatic    AS CHAR FORMAT "x(10)" INIT "" .  /*  28  */
DEF VAR im_class       AS CHAR FORMAT "x(3)"  INIT "" .  /*  29  */
DEF VAR im_typecar     AS CHAR FORMAT "x(15)" INIT "" .  /*  30  */
DEF VAR im_brand       AS CHAR FORMAT "x(20)" INIT "" .  /*  31  */
DEF VAR im_model       AS CHAR FORMAT "x(50)" INIT "" .  /*  32  */
DEF VAR im_typenam     AS CHAR FORMAT "x(10)" INIT "" .  /*  33  */
DEF VAR im_vehreg      AS CHAR FORMAT "x(11)" INIT "" .  /*  34  *//*A54-0112*/
DEF VAR im_veh_country AS CHAR FORMAT "x(20)" INIT "" .  /*  35  */
DEF VAR im_chassis     AS CHAR FORMAT "x(25)" INIT "" .  /*  36  */  
DEF VAR im_engno       AS CHAR FORMAT "x(25)" INIT "" .  /*  37  */   
DEF VAR im_caryear     AS CHAR FORMAT "x(10)" INIT "" .  /*  38  */   
DEF VAR im_cc          AS CHAR FORMAT "x(30)" INIT "" .  /*  39  */   
DEF VAR im_weigth      AS CHAR FORMAT "x(30)" INIT "" .  /*  40  */   
DEF VAR im_si          AS CHAR FORMAT "x(20)" INIT "" .  /*  41  */   
DEF VAR im_prem        AS CHAR FORMAT "x(15)" INIT "" .  /*  42  */   
DEF VAR im_si2         AS CHAR FORMAT "x(20)" INIT "" .  /*  43  */   
DEF VAR im_prem2       AS CHAR FORMAT "x(15)" INIT "" .  /*  44  */   
DEF VAR im_timeno      AS CHAR FORMAT "x(10)" INIT "" .  /*  45  */   
DEF VAR im_stk         AS CHAR FORMAT "x(15)" INIT "" .  /*  46  */  
DEF VAR im_compdatco   AS CHAR FORMAT "x(10)" INIT "" .  /*  47  */  
DEF VAR im_expdatco    AS CHAR FORMAT "x(10)" INIT "" .  /*  48  */  
DEF VAR im_compprm     AS CHAR FORMAT "x(15)" INIT "" .  /*  49  */ 
DEF VAR im_notifynam   AS CHAR FORMAT "x(50)" INIT "" .  /*  50  */  
DEF VAR im_memmo       AS CHAR FORMAT "x(50)" INIT "" .  /*  51  */  
DEF VAR im_drivnam1    AS CHAR FORMAT "x(50)" INIT "" .  /*  52  */ 
DEF VAR im_birdth1     AS CHAR FORMAT "x(20)" INIT "" .  /*  53  */  
DEF VAR im_drivnam2    AS CHAR FORMAT "x(50)" INIT "" .  /*  54  */  
DEF VAR im_birdth2     AS CHAR FORMAT "x(20)" INIT "" .  /*  55  */ 
DEF VAR im_invoice     AS CHAR FORMAT "x(50)" INIT "" .  /*  56  */  
DEF VAR im_addinvoice  AS CHAR FORMAT "x(60)" INIT "" .  /*  57  */  
DEF VAR im_datasystem  AS CHAR FORMAT "x(10)" INIT "" .  /*  58  */  
DEF VAR im_branch      AS CHAR FORMAT "x(3)"  INIT "" .
DEF VAR im_empty       AS CHAR FORMAT "x(20)" INIT "".
DEF VAR im_hp          AS CHAR FORMAT "x(20)" INIT "" .  /*  43  */   
DEF VAR im_birthday    AS CHAR FORMAT "x(10)" INIT "" .  /*  44  */   
DEF VAR im_icno        AS CHAR FORMAT "x(15)" INIT "" .  /*  45  */   
DEF VAR im_nameicno    AS CHAR FORMAT "x(25)" INIT "" .  /*  46  */  
DEF VAR im_oppic       AS CHAR FORMAT "x(40)" INIT "" .  /*  47  */  
DEF VAR im_addnoic     AS CHAR FORMAT "x(100)" INIT "" .  /*  48  */  
DEF VAR im_addnoic2     AS CHAR FORMAT "x(100)" INIT "" .  /*  48  */ 
DEF VAR im_mubanic     AS CHAR FORMAT "x(25)" INIT "" .  /*  49  */ 
DEF VAR im_buildic     AS CHAR FORMAT "x(40)" INIT "" .  /*  50  */  
DEF VAR im_flooric     AS CHAR FORMAT "x(5)"  INIT "" .  /*  51  */  
DEF VAR im_mooic       AS CHAR FORMAT "x(20)" INIT "" .  /*  52  */ 
DEF VAR im_soiic       AS CHAR FORMAT "x(30)" INIT "" .  /*  53  */  
DEF VAR im_roadic      AS CHAR FORMAT "x(30)" INIT "" .  /*  54  */  
DEF VAR im_tambonic    AS CHAR FORMAT "x(40)" INIT "" .  /*  55  */ 
DEF VAR im_amperic     AS CHAR FORMAT "x(40)" INIT "" .  /*  56  */  
DEF VAR im_provinic    AS CHAR FORMAT "x(30)" INIT "" .  /*  57  */  
DEF VAR im_postic      AS CHAR FORMAT "x(5)"  INIT "" .  /*  58  */  
DEF VAR im_kkapp       AS CHAR FORMAT "x(20)" INIT "" . /*A61-0335*/
DEF VAR im_product     AS CHAR FORMAT "x(20)" INIT "" . /*A61-0335*/
DEF VAR im_dealer      AS CHAR FORMAT "x(20)" INIT "" . /*A61-0335*/

DEF VAR nv_insref      AS CHAR FORMAT "x(10)" INIT "" .
DEF VAR nv_seq         AS INTEGER  INIT  1.
DEF VAR nv_sum         AS INTEGER  INIT  0.
DEF VAR nv_checkdigit  AS INTEGER  . 
DEFINE VAR n_insref     AS CHARACTER FORMAT "X(10)". 
DEFINE VAR nv_messagein AS CHAR FORMAT "X(200)". 
DEFINE VAR nv_usrid     AS CHARACTER FORMAT "X(08)".
DEFINE VAR nv_transfer  AS LOGICAL   .
DEFINE VAR n_check      AS CHARACTER .
DEFINE VAR putchr       AS CHAR FORMAT "X(200)" INIT "" NO-UNDO.
DEFINE VAR putchr1      AS CHAR FORMAT "X(100)" INIT "" NO-UNDO.
DEFINE VAR nv_typ       AS CHAR FORMAT "X(2)".
DEF BUFFER buwm100      FOR sic_bran.uwm100 .  
