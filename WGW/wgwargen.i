/* Copyright  # Safety Insurance Public Company Limited                     */  
/*              บริษัท ประกันคุ้มภัย จำกัด (มหาชน)                          */  
/* modify BY: Kridtiya i.A56-0152  09/05/2013                             */ 
/*          : ประกาศตัวแปร */   
/*modify  by: Kridtiya i. A58-0103 ปรับการนำเข้างาน 2+ , 3+               */  
/*modify  by: Kridtiya i. A58-0103 เพิ่มระบุชื่อผู้ขับขี่                 */  
/*Modify  by: Kridtiya i. A63-0472 Date. 09/11/2020 add field firstname ,lastname.....*/
/*Mofify  by: Ranu I. A64-0138 เพิ่มตัวแปรเก็บค่าการคำนวณเบี้ย  */   
/* ------------------------------------------------------------------------ */  
DEFINE NEW SHARED TEMP-TABLE wdetail
    FIELD entdat      AS CHAR FORMAT "x(10)" INIT ""    /*entry date*/
    FIELD enttim      AS CHAR FORMAT "x(8)"  INIT ""    /*entry time*/
    FIELD trandat     AS CHAR FORMAT "x(10)" INIT ""    /*tran date*/
    FIELD trantim     AS CHAR FORMAT "x(8)"  INIT ""    /*tran time*/
    FIELD poltyp      AS CHAR FORMAT "x(3)"  INIT ""    /*policy type*/
    FIELD policy      AS CHAR FORMAT "x(16)" INIT ""    /*policy*/       /*a40166 chg format from 12 to 16*/
    /*FIELD cedpol      AS CHAR FORMAT "x(16)" INIT ""*/
    FIELD n_opnpol    AS CHAR FORMAT "x(60)" INIT ""    
    FIELD renpol      AS CHAR FORMAT "x(16)" INIT ""    /*renew policy*/ /*a40166 chg format from 12 to 16*/
    FIELD comdat      AS CHAR FORMAT "x(10)" INIT ""    /*comm date*/
    FIELD expdat      AS CHAR FORMAT "x(10)" INIT ""    /*expiry date */
    FIELD firstdat    AS CHAR FORMAT "x(10)" INIT ""    /*comm date   */
    FIELD compul      AS CHAR FORMAT "x"     INIT ""    /*compulsory  */
    FIELD tiname      AS CHAR FORMAT "x(25)" INIT ""    /*title*/
    FIELD insnam      AS CHAR FORMAT "x(60)" INIT ""    /*name*/
    FIELD name2       AS CHAR FORMAT "x(60)" INIT ""    /*name*/
    FIELD name3       AS CHAR FORMAT "x(60)" INIT ""    /*name*/
    FIELD iadd1       AS CHAR FORMAT "x(35)" INIT ""
    FIELD iadd2       AS CHAR FORMAT "x(35)" INIT ""
    FIELD iadd3       AS CHAR FORMAT "x(35)" INIT ""
    FIELD iadd4       AS CHAR FORMAT "x(20)" INIT ""
    FIELD prempa      AS CHAR FORMAT "x"     INIT ""    /*premium package*/
    FIELD subclass    AS CHAR FORMAT "x(3)"  INIT ""    /*sub class*/
    FIELD brand       AS CHAR FORMAT "x(30)" INIT ""    
    FIELD model       AS CHAR FORMAT "x(50)" INIT ""    
    FIELD cc          AS CHAR FORMAT "x(10)" INIT ""    
    FIELD weight      AS CHAR FORMAT "x(10)" INIT ""    
    FIELD seat        AS CHAR FORMAT "x(2)"  INIT ""    
    FIELD body        AS CHAR FORMAT "x(20)" INIT ""    
    /*FIELD vehreg      AS CHAR FORMAT "x(10)" INIT ""  /*vehicl registration*/*//*A56-0152*/
    FIELD vehreg      AS CHAR FORMAT "x(11)" INIT ""    /*vehicl registration*/  /*A56-0152*/
    FIELD engno       AS CHAR FORMAT "x(25)" INIT ""    /*engine no*/ 
    FIELD chasno      AS CHAR FORMAT "x(25)" INIT ""    /*chasis no*/
    FIELD caryear     AS CHAR FORMAT "x(4)"  INIT ""
    /*FIELD carprovi    AS CHAR FORMAT "x(2)" INIT ""*/
    FIELD vehuse      AS CHAR FORMAT "x"     INIT ""        /*vehicle use*/
    FIELD garage      AS CHAR FORMAT "x"     INIT ""
    FIELD stk         AS CHAR FORMAT "x(15)" INIT ""    /*--A51-0253---Amparat*/
    FIELD access      AS CHAR FORMAT "x"     INIT ""    /*accessories*/
    /*FIELD covcod      AS CHAR FORMAT "x"     INIT ""    /*cover type*/*//*A580103*/  
    FIELD covcod      AS CHAR FORMAT "x(3)"  INIT ""    /*cover type*/    /*A580103*/  
    FIELD si          AS CHAR FORMAT "x(25)" INIT ""    /*sum insure*/
    FIELD volprem     AS CHAR FORMAT "x(20)" INIT ""    /*voluntory premium*/
    FIELD Compprem    AS CHAR FORMAT "x(20)" INIT ""    /*compulsory prem*/
    FIELD fleet       AS CHAR FORMAT "x(10)" INIT ""    /*fleet*/
    FIELD ncb         AS CHAR FORMAT "x(10)" INIT "" 
    FIELD loadclm     AS CHAR FORMAT "x(10)" INIT ""    /*load claim*/
    FIELD deductda    AS CHAR FORMAT "x(10)" INIT ""    /*deduct da*/
    FIELD deductpd    AS CHAR FORMAT "x(10)" INIT ""    /*deduct pd*/
    FIELD benname     AS CHAR FORMAT "x(50)" INIT ""    /*benificiary*/
    FIELD n_user      AS CHAR FORMAT "x(10)" INIT ""    /*user id*/
    FIELD n_IMPORT    AS CHAR FORMAT "x(2)"  INIT "" 
    FIELD n_export    AS CHAR FORMAT "x(2)"  INIT "" 
    FIELD drivnam     AS CHAR FORMAT "x"     INIT "" 
    FIELD drivnam1    AS CHAR FORMAT "x(50)" INIT "" /*driver name1*/
    FIELD drivnam2    AS CHAR FORMAT "x(50)" INIT "" /*driver name2*/
    FIELD drivbir1    AS CHAR FORMAT "X(10)" INIT ""  /*driver birth date*/
    FIELD drivbir2    AS CHAR FORMAT "X(10)" INIT ""  /*driver birth date*/
    FIELD drivage1    AS CHAR FORMAT "X(2)"  INIT ""  /*driver age1*/
    FIELD drivage2    AS CHAR FORMAT "x(2)"  INIT ""  /*driver age2*/
    FIELD cancel      AS CHAR FORMAT "x(2)"  INIT ""  /*cancel*/
    FIELD WARNING     AS CHAR FORMAT "X(30)" INIT ""
    FIELD comment     AS CHAR FORMAT "x(512)"  INIT ""  /*a490166 add format from 100 to 512*/
    FIELD seat41      AS DECI FORMAT "99"    INIT 0
    FIELD pass        AS CHAR FORMAT "x"     INIT "n"
    FIELD OK_GEN      AS CHAR FORMAT "X"     INIT "Y" 
    FIELD comper      AS DECI INIT 0
    FIELD comacc      AS DECI INIT 0
    FIELD NO_41       AS DECI INIT 0
    FIELD NO_42       AS DECI INIT 0
    FIELD NO_43       AS DECI INIT 0
    FIELD tariff      AS CHAR FORMAT "x(2)" INIT ""
    FIELD baseprem    AS INTE FORMAT ">,>>>,>>>,>>>,>>9" INIT  0
    FIELD cargrp      AS CHAR FORMAT "x(2)" INIT ""
    FIELD producer    AS CHAR FORMAT "x(7)" INIT ""
    FIELD agent       AS CHAR FORMAT "x(7)" INIT ""  
    FIELD inscod      AS CHAR INIT ""
    FIELD redbook     AS CHAR INIT "" FORMAT "X(8)"    /*note add*/
    /*FIELD base        AS CHAR INIT "" FORMAT "x(8)"  */  /*Note add Base Premium 25/09/2006*/
    FIELD accdat      AS CHAR INIT "" FORMAT "x(10)"   /*Account Date For 72*/
    FIELD docno       AS CHAR INIT "" FORMAT "x(10)"   /*Docno For 72*/
    FIELD ICNO        AS CHAR INIT "" FORMAT "x(13)"   /*ICNO For COVER NOTE A51-0071 amparat*/
    FIELD CoverNote   AS CHAR INIT "" FORMAT "x(13)"   /* ระบุว่าเป็นงาน COVER NOTE A51-0071 amparat*/
    FIELD note        AS CHAR INIT "" FORMAT "x(100)" 
    FIELD attach_n    AS CHAR INIT "" FORMAT "x(100)" 
    FIELD idcard      AS CHAR INIT "" FORMAT "x(100)" 
    FIELD BUSINESS    AS CHAR INIT "" FORMAT "x(100)" 
    FIELD nv_acctxt   AS CHAR INIT "" FORMAT "x(100)" 
    FIELD campaignno  AS CHAR INIT "" FORMAT "X(20)"    /* A58-0103 */     
    FIELD financecd   AS CHAR FORMAT "x(60)" INIT ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD firstName   AS CHAR FORMAT "x(60)" INIT ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD lastName    AS CHAR FORMAT "x(60)" INIT ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD postcd      AS CHAR FORMAT "x(15)" INIT ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeocc     AS CHAR FORMAT "x(4)"  INIT ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr1   AS CHAR FORMAT "x(2)"  INIT ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr2   AS CHAR FORMAT "x(2)"  INIT ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr3   AS CHAR FORMAT "x(2)"  INIT ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD br_insured  AS CHAR FORMAT "x(5)"  INIT ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD campaign_ov AS CHAR FORMAT "x(30)" INIT ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
    FIELD insnamtyp   AS CHAR FORMAT "x(60)" INIT ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD TPBIPer     AS deci  INIT 0 
    FIELD TPBIAcc     AS deci  INIT 0 
    FIELD pTPPD       AS deci  INIT 0 .
DEF VAR nv_chkerror   AS CHAR FORMAT "x(250)" INIT "".  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
DEF VAR nv_postcd     AS CHAR FORMAT "x(15)"  INIT "".  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/

DEF NEW SHARED VAR   nv_message as   char.
DEF VAR nv_riskgp        LIKE sicuw.uwm120.riskgp                                  NO-UNDO.
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
DEFINE VAR  nv_tmppolrun AS INTEGER FORMAT "999"         INIT 0.            /*Temp Policy Running No.*/
DEFINE VAR  nv_batbrn    AS CHARACTER FORMAT "x(2)"      INIT ""  NO-UNDO.  /*Batch Branch*/
DEFINE VAR  nv_tmppol    AS CHARACTER FORMAT "x(16)"     INIT "".           /*Temp Policy*/
DEFINE VAR  nv_rectot    AS INT  FORMAT ">>,>>9"         INIT 0.            /* Display จำนวน ก/ธ ทั้งไฟล์ */
DEFINE VAR  nv_recsuc    AS INT  FORMAT ">>,>>9"         INIT 0.            /* Display จำนวน ก/ธ ที่นำเข้าได้ */
DEFINE VAR  nv_netprm_t  AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.            /* Display เบี้ยรวม ทั้งไฟล์ */
DEFINE VAR  nv_netprm_s  AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.            /* Display เบี้ยรวม ที่นำเข้าได้ */
DEFINE VAR  nv_batflg    AS LOG                          INIT NO.
DEFINE VAR  nv_txtmsg    AS CHAR FORMAT "x(50)"          INIT "".           /* Parameter คู่กับ nv_check */
/*add kridtiya i. A56-0152 */
DEFINE VAR  ns_entrydat    AS CHAR FORMAT "x(20)"     INIT "". 
DEFINE VAR  ns_entrytim    AS CHAR FORMAT "x(20)"     INIT "". 
DEFINE VAR  ns_trndat      AS CHAR FORMAT "x(20)"     INIT "". 
DEFINE VAR  ns_trntim      AS CHAR FORMAT "x(20)"     INIT "". 
DEFINE VAR  ns_poltyp      AS CHAR FORMAT "x(5)"      INIT "". 
DEFINE VAR  ns_policy      AS CHAR FORMAT "x(20)"     INIT "". 
DEFINE VAR  ns_renewpol    AS CHAR FORMAT "x(20)"     INIT "". 
DEFINE VAR  ns_comdat      AS CHAR FORMAT "x(10)"     INIT "". 
DEFINE VAR  ns_expidat     AS CHAR FORMAT "x(10)"     INIT "". 
DEFINE VAR  ns_compul      AS CHAR FORMAT "x(2)"      INIT "". 
DEFINE VAR  ns_title       AS CHAR FORMAT "x(20)"     INIT "".   
DEFINE VAR  ns_insnam      AS CHAR FORMAT "x(100)"    INIT "". 
DEFINE VAR  ns_addr1       AS CHAR FORMAT "x(100)"     INIT "". 
DEFINE VAR  ns_addr2       AS CHAR FORMAT "x(100)"     INIT "". 
DEFINE VAR  ns_addr3       AS CHAR FORMAT "x(100)"     INIT "". 
DEFINE VAR  ns_addr4       AS CHAR FORMAT "x(100)"     INIT "". 
DEFINE VAR  ns_pack        AS CHAR FORMAT "x(3)"      INIT "". 
DEFINE VAR  ns_subclass    AS CHAR FORMAT "x(5)"      INIT "". 
DEFINE VAR  ns_Brand       AS CHAR FORMAT "x(30)"     INIT "". 
DEFINE VAR  ns_Mode        AS CHAR FORMAT "x(100)"    INIT "". 
DEFINE VAR  ns_Cc          AS CHAR FORMAT "x(5)"      INIT "". 
DEFINE VAR  ns_Weight      AS CHAR FORMAT "x(5)"      INIT "".   
DEFINE VAR  ns_Seat        AS CHAR FORMAT "x(5)"      INIT "". 
DEFINE VAR  ns_Body        AS CHAR FORMAT "x(30)"     INIT "". 
DEFINE VAR  ns_vehreg      AS CHAR FORMAT "x(11)"     INIT "". 
DEFINE VAR  ns_engno       AS CHAR FORMAT "x(25)"     INIT "". 
DEFINE VAR  ns_chassis     AS CHAR FORMAT "x(25)"     INIT "". 
DEFINE VAR  ns_caryear     AS CHAR FORMAT "x(5)"      INIT "". 
DEFINE VAR  ns_provin      AS CHAR FORMAT "x(30)"     INIT "". 
DEFINE VAR  ns_vehuse      AS CHAR FORMAT "x(3)"      INIT "". 
DEFINE VAR  ns_garage      AS CHAR FORMAT "x(3)"      INIT "". 
DEFINE VAR  ns_stkno       AS CHAR FORMAT "x(20)"     INIT "". 
DEFINE VAR  ns_access      AS CHAR FORMAT "x(2)"      INIT "".   
/*DEFINE VAR  ns_cover       AS CHAR FORMAT "x(2)"      INIT "". *//*A58-0103*/
DEFINE VAR  ns_cover       AS CHAR FORMAT "x(5)"      INIT "".     /*A58-0103*/
DEFINE VAR  ns_sumins      AS CHAR FORMAT "x(20)"     INIT "". 
DEFINE VAR  ns_volprem     AS CHAR FORMAT "x(20)"     INIT "". 
DEFINE VAR  ns_compprem    AS CHAR FORMAT "x(15)"     INIT "". 
DEFINE VAR  ns_fleet       AS CHAR FORMAT "x(10)"     INIT "". 
DEFINE VAR  ns_ncb         AS CHAR FORMAT "x(10)"     INIT "". 
DEFINE VAR  ns_loadcl      AS CHAR FORMAT "x(10)"     INIT "". 
DEFINE VAR  ns_DeductDA    AS CHAR FORMAT "x(20)"     INIT "". 
DEFINE VAR  ns_DeductPD    AS CHAR FORMAT "x(20)"     INIT "". 
DEFINE VAR  ns_Benname     AS CHAR FORMAT "x(100)"    INIT "". 
DEFINE VAR  ns_userid      AS CHAR FORMAT "x(60)"     INIT "".   
DEFINE VAR  ns_import      AS CHAR FORMAT "x(20)"     INIT "". 
DEFINE VAR  ns_export      AS CHAR FORMAT "x(20)"     INIT "". 
DEFINE VAR  ns_drivno      AS CHAR FORMAT "x(5)"      INIT "". 
DEFINE VAR  ns_drivname1   AS CHAR FORMAT "x(60)"     INIT "". 
DEFINE VAR  ns_drivname2   AS CHAR FORMAT "x(60)"     INIT "". 
DEFINE VAR  ns_drivbirth1  AS CHAR FORMAT "x(10)"     INIT "". 
DEFINE VAR  ns_drivbirth2  AS CHAR FORMAT "x(10)"     INIT "". 
DEFINE VAR  ns_drivage1    AS CHAR FORMAT "x(5)"      INIT "". 
DEFINE VAR  ns_drivage2    AS CHAR FORMAT "x(5)"      INIT "". 
DEFINE VAR  ns_cancel      AS CHAR FORMAT "x(10)"     INIT "". 
DEFINE VAR  ns_producer    AS CHAR FORMAT "x(10)"     INIT "".  
DEFINE VAR  ns_agent       AS CHAR FORMAT "x(10)"     INIT "". 
DEFINE VAR  ns_redbook     AS CHAR FORMAT "x(10)"     INIT "". 
DEFINE VAR  ns_note        AS CHAR FORMAT "x(50)"     INIT "". 
DEFINE VAR  ns_attach      AS CHAR FORMAT "x(40)"     INIT "". 
DEFINE VAR  ns_idcard      AS CHAR FORMAT "x(50)"     INIT "". 
DEFINE VAR  ns_BUSINESS    AS CHAR FORMAT "x(50)"     INIT "".  
DEFINE VAR  ns_accdat      AS CHAR FORMAT "x(10)"     INIT "".  
DEFINE VAR  ns_remak       AS CHAR FORMAT "x(100)"    INIT "".  
DEFINE VAR  ns_recipt      AS CHAR FORMAT "x(10)"     INIT "".  
/*add kridtiya i. A58-0103 */
DEFINE VAR n_insref     AS CHARACTER FORMAT "X(10)". 
DEFINE VAR nv_messagein AS CHAR FORMAT "X(200)". 
DEFINE VAR nv_usrid     AS CHARACTER FORMAT "X(08)".
DEFINE VAR nv_transfer  AS LOGICAL   .
DEFINE VAR n_check      AS CHARACTER .
DEFINE VAR nv_insref    AS CHARACTER FORMAT "X(10)".  
DEFINE VAR putchr       AS CHAR FORMAT "X(200)" INIT "" NO-UNDO.
DEFINE VAR putchr1      AS CHAR FORMAT "X(100)" INIT "" NO-UNDO.
DEFINE VAR nv_typ       AS CHAR FORMAT "X(2)".
DEF BUFFER buwm100      FOR sic_bran.uwm100 . 
/*A58-0103  add for 2+,3+*/
DEFINE NEW  SHARED VAR   nv_prem3       AS DECIMAL  FORMAT ">,>>>,>>9.99-" INITIAL 0  NO-UNDO.
DEFINE NEW  SHARED VAR   nv_sicod3      AS CHAR     FORMAT "X(4)".
DEFINE NEW  SHARED VAR   nv_usecod3     AS CHAR     FORMAT "X(4)".
DEFINE NEW  SHARED VAR   nv_siprm3      AS DECI     FORMAT ">>,>>>,>>9.99-".
DEFINE NEW  SHARED VAR   nv_prvprm3     AS DECI     FORMAT ">>,>>>,>>9.99-".
DEFINE NEW  SHARED VAR   nv_baseprm3    AS DECI     FORMAT ">>,>>>,>>9.99-".
DEFINE NEW  SHARED VAR   nv_useprm3     AS DECI     FORMAT ">>,>>>,>>9.99-".
DEFINE NEW  SHARED VAR   nv_basecod3    AS CHAR     FORMAT "X(4)".
DEFINE NEW  SHARED VAR   nv_basevar3    AS CHAR     FORMAT "X(60)".
DEFINE NEW  SHARED VAR   nv_basevar4    AS CHAR     FORMAT "X(30)".
DEFINE NEW  SHARED VAR   nv_basevar5    AS CHAR     FORMAT "X(30)".
DEFINE NEW  SHARED VAR   nv_usevar3     AS CHAR     FORMAT "X(60)".
DEFINE NEW  SHARED VAR   nv_usevar4     AS CHAR     FORMAT "X(30)".
DEFINE NEW  SHARED VAR   nv_usevar5     AS CHAR     FORMAT "X(30)".
DEFINE NEW  SHARED VAR   nv_sivar3      AS CHAR     FORMAT "X(60)".
DEFINE NEW  SHARED VAR   nv_sivar4      AS CHAR     FORMAT "X(30)".
DEFINE NEW  SHARED VAR   nv_sivar5      AS CHAR     FORMAT "X(30)".
DEFINE VAR               ns_basenew     AS CHAR     FORMAT "x(20)"     INIT "".  
DEFINE VAR               campaignno     AS CHAR INIT "" FORMAT "X(20)".    /* A58-0103 */ 
/*A58-0103 add for 2+,3+*/
DEF VAR np_driver  AS CHAR INIT "".                   /* A58-0103 */ 
DEF VAR nv_driver  AS CHAR INIT "" .                  /* A58-0103 */ 
DEFINE NEW SHARED WORKFILE ws0m009 NO-UNDO            /* A58-0103 */ 
/*1*/  FIELD policy     AS CHARACTER    INITIAL ""    /* A58-0103 */ 
/*2*/  FIELD lnumber    AS INTEGER                    /* A58-0103 */ 
       FIELD ltext      AS CHARACTER    INITIAL ""    /* A58-0103 */ 
       FIELD ltext2     AS CHARACTER    INITIAL "" .  /* A58-0103 */ 
/* add by : A64-0138 */
DEFINE NEW SHARED TEMP-TABLE wkuwd132 LIKE stat.pmuwd132.
DEF    VAR nv_cstflg  AS CHAR FORMAT "X(2)".     /*C=CC ; S=Seat ; T=Tons ; W=Watts*/  
DEFINE VAR nv_engcst  AS DECI FORMAT ">>>>>9.99".

DEFINE VAR nv_driage1 AS INTE FORMAT ">>9".
DEFINE VAR nv_driage2 AS INTE FORMAT ">>9".
DEF    VAR nv_pdprm0  AS DECI FORMAT ">>>,>>>,>>9.99-". /*เบี้ยผู้ขับขี่*/
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
DEFINE VAR nv_41prmt       AS DECI FORMAT ">>>,>>>,>>9.99-".  /* fleet */
DEFINE VAR nv_42prmt       AS DECI FORMAT ">>>,>>>,>>9.99-".  /* fleet */
DEFINE VAR nv_43prmt       AS DECI FORMAT ">>>,>>>,>>9.99-".  /* fleet */
DEFINE VAR nv_pdprem       AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_status       AS CHAR .   /*fleet YES=Complete , NO=Not Complete */
DEFINE VAR nv_TPBIPer      as char.
DEFINE VAR nv_TPBIAcc      as char.
DEFINE VAR nv_pTPPD        as char.
DEFINE VAR nv_ry41         as char.  
DEFINE VAR nv_ry42         as char.  
DEFINE VAR nv_ry43         as char.

   
/* end A64-0138 */


