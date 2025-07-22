/*Modify by   : kridtiya i. A55-0240 date. 08/08/2012 add address v72           */
/*modify by   : Kridtiya i. A54-0112 ขยายช่องทะเบียนรถ จาก 10 เป็น 11 หลัก      */
/*modify by   : Kridtiya i. A56-0212 เพิ่มเลขที่บัตรประชาชน                     */
/*Modify by   : Kridtiya i. A56-0309 เพิ่มการแปลงที่อยู่ ตามไฟล์แจ้งงานใหม่     */
/*Modify by   : Kridtiya i. A57-0434 เพิ่มขนาดหมายเหตุจากเดิม 40เป็น 150ตัวอักษร*/
/*Modify by   : Ranu i. A60-0232 เพิ่มตัวแปรเก็บค่าจากไฟล์*/
/*modify by   : Ranu I. A61-0335 เพิ่มการเก็บข้อมูลจากไฟล์ */
/*Modify by   : Kridtiya i. A63-0472 Date. 09/11/2020 add field firstname ,lastname.....*/
DEFINE NEW SHARED WORKFILE wdetail2 NO-UNDO  
    FIELD id               AS CHAR FORMAT "x(13)"  INIT ""  /*  1   */   
    FIELD br_nam           AS CHAR FORMAT "x(30)"  INIT ""  /*  2   */ 
    FIELD number           AS CHAR FORMAT "x(20)"  INIT ""  /*  3   */ 
    FIELD polstk           AS CHAR FORMAT "x(20)"  INIT ""  /*  4   */ 
    FIELD recivedat        AS CHAR FORMAT "x(15)"  INIT ""  /*  5   */ 
    FIELD cedpol           AS CHAR FORMAT "x(20)"  INIT ""  /*  6   */ 
    FIELD insurnam         AS CHAR FORMAT "x(60)"  INIT ""  /*  7   */ 
    FIELD ICNO             AS CHAR FORMAT "x(20)"  INIT ""  /*  A56-0212 */
    FIELD vehreg           AS CHAR FORMAT "x(30)"  INIT ""  /*  8   */ 
    FIELD brand            AS CHAR FORMAT "x(20)"  INIT ""  /*  9   */ 
    FIELD model            AS CHAR FORMAT "x(50)"  INIT ""  /*  10  */ 
    FIELD notifyno         AS CHAR FORMAT "x(30)"  INIT ""  /*  11  */ 
    FIELD namnotify        AS CHAR FORMAT "x(50)"  INIT ""  /*  12  */ 
    FIELD chassis          AS CHAR FORMAT "x(30)"  INIT ""  /*  13  */ 
    FIELD comp             AS CHAR FORMAT "x(20)"  INIT ""  /*  14  */ 
    FIELD premt            AS CHAR FORMAT "x(20)"  INIT ""  /*  15  */ 
    FIELD comdat           AS CHAR FORMAT "x(20)"  INIT ""  /*  16  */ 
    FIELD expdat           AS CHAR FORMAT "x(20)"  INIT ""  /*  17  */ 
    /*FIELD memmo            AS CHAR FORMAT "x(40)"  INIT ""  /*  18  */  *//*A57-0434*/
    FIELD memmo            AS CHAR FORMAT "x(200)"  INIT ""  /*  18  */     /*A57-0434*/
    FIELD ad11             AS CHAR FORMAT "x(200)" INIT ""  
    FIELD ad12             AS CHAR FORMAT "x(40)"  INIT ""  
    FIELD ad13             AS CHAR FORMAT "x(40)"  INIT ""  
    FIELD ad14             AS CHAR FORMAT "x(40)"  INIT ""  
    FIELD veh_country      AS CHAR FORMAT "x(20)"  INIT ""  
    FIELD branch           AS CHAR FORMAT "x(3)"   INIT ""  
    FIELD class            AS CHAR FORMAT "x(4)"   INIT ""  
    FIELD vatcode          AS CHAR FORMAT "x(10)"  INIT ""  
    FIELD addr72           AS CHAR FORMAT "x(200)" INIT ""  /*A55-0240*/
    FIELD road             AS CHAR FORMAT "x(35)"  INIT ""  /*A55-0240*/  
    FIELD soy              AS CHAR FORMAT "x(35)"  INIT ""  /*A55-0240*/  
    FIELD benname          AS CHAR FORMAT "x(100)" INIT ""
    FIELD namTITLE         AS CHAR FORMAT "x(30)"  INIT ""  
    /* A60-0232 */
    field phone         as char format "x(25)" init ""
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
    field nsend         as char format "x(100)" init ""    /*A61-0335*/
    field sendname      as char format "x(100)" init ""    /*A61-0335*/
    field kkapp         as char format "x(20)" init ""     /*A61-0335*/
    FIELD campaign_ov   AS CHAR FORMAT "x(30)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
    . 
    /* A60-0232 */
DEFINE NEW SHARED TEMP-TABLE wdetail
    FIELD cedpol      AS CHAR FORMAT "x(20)" INIT "" 
    FIELD branch      AS CHAR FORMAT "x(10)" INIT "" 
    FIELD entdat      AS CHAR FORMAT "x(10)" INIT ""     /*entry date*/
    FIELD enttim      AS CHAR FORMAT "x(8)"  INIT ""      /*entry time*/
    FIELD trandat     AS CHAR FORMAT "x(10)" INIT ""     /*tran date*/
    FIELD trantim     AS CHAR FORMAT "x(8)"  INIT ""      /*tran time*/
    FIELD poltyp      AS CHAR FORMAT "x(3)"  INIT ""      /*policy type*/
    FIELD policy      AS CHAR FORMAT "x(20)" INIT ""     /*policy*/       /*a40166 chg format from 12 to 16*/
    FIELD renpol      AS CHAR FORMAT "x(16)" INIT ""     /*renew policy*/ /*a40166 chg format from 12 to 16*/
    FIELD comdat      AS CHAR FORMAT "x(10)" INIT ""     /*comm date*/
    FIELD expdat      AS CHAR FORMAT "x(10)" INIT ""     /*expiry date*/
    FIELD compul      AS CHAR FORMAT "x"     INIT ""         /*compulsory*/
    FIELD tiname      AS CHAR FORMAT "x(15)" INIT ""     /*title*/
    FIELD insnam      AS CHAR FORMAT "x(50)" INIT ""     /*name*/
    FIELD name2       AS CHAR FORMAT "x(50)" INIT ""    /*  15  */ 
    FIELD iadd1       AS CHAR FORMAT "x(35)" INIT ""
    FIELD iadd2       AS CHAR FORMAT "x(35)" INIT ""
    FIELD iadd3       AS CHAR FORMAT "x(35)" INIT ""
    FIELD iadd4       AS CHAR FORMAT "x(20)" INIT ""
    FIELD prempa      AS CHAR FORMAT "x"     INIT ""         /*premium package*/
    FIELD subclass    AS CHAR FORMAT "x(4)"  INIT ""      /*sub class*/
    FIELD brand       AS CHAR FORMAT "x(30)" INIT ""
    FIELD model       AS CHAR FORMAT "x(50)" INIT ""
    FIELD cc          AS CHAR FORMAT "x(10)" INIT ""
    FIELD weight      AS CHAR FORMAT "x(10)" INIT ""
    FIELD seat        AS CHAR FORMAT "x(2)"  INIT ""
    FIELD body        AS CHAR FORMAT "x(20)" INIT ""
    /*FIELD vehreg      AS CHAR FORMAT "x(10)" INIT ""     /*vehicl registration*/*//*A54-0112*/
    FIELD vehreg      AS CHAR FORMAT "x(11)" INIT ""     /*vehicl registration*/   /*A54-0112*/
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
    FIELD deductpp    AS CHAR FORMAT "x(10)" INIT "100000"     /*deduct da*/
    FIELD deductba    AS CHAR FORMAT "x(10)" INIT "10000000"   /*deduct da*/
    FIELD deductpa    AS CHAR FORMAT "x(10)" INIT "600000"    /*deduct pd*/
    FIELD benname     AS CHAR FORMAT "x(50)" INIT ""     /*benificiary*/
    FIELD n_user      AS CHAR FORMAT "x(10)" INIT ""     /*user id*/
    FIELD n_IMPORT    AS CHAR FORMAT "x(2)" INIT ""      
    FIELD n_export    AS CHAR FORMAT "x(2)" INIT ""      
    FIELD drivnam     AS CHAR FORMAT "x" INIT ""         
    FIELD drivnam1    AS CHAR FORMAT "x(50)" INIT ""     /*driver name1*/
    /*FIELD drivnam2    AS CHAR FORMAT "x(50)" INIT ""  */   /*driver name2*/
    FIELD drivbir1    AS CHAR FORMAT "X(10)" INIT ""     /*driver birth date*/
    FIELD drivbir2    AS CHAR FORMAT "X(10)" INIT ""     /*driver birth date*/
    FIELD drivage1    AS CHAR FORMAT "X(2)" INIT ""      /*driver age1*/
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
    /* A60-0232 */
    field phone         as char format "x(25)" init ""
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
    FIELD namenotify    AS CHAR FORMAT "X(50)"  INIT ""    /*A61-0335*/
    field nsend         as char format "x(100)" init ""    /*A61-0335*/
    field sendname      as char format "x(100)" init ""    /*A61-0335*/
    field kkapp         as char format "x(20)"  init ""    /*A61-0335*/
    FIELD firstName     AS CHAR FORMAT "x(60)" INIT ""     /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD lastName      AS CHAR FORMAT "x(60)" INIT ""     /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD postcd        AS CHAR FORMAT "x(15)" INIT ""     /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeocc       AS CHAR FORMAT "x(4)"  INIT ""     /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr1     AS CHAR FORMAT "x(2)"  INIT ""     /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr2     AS CHAR FORMAT "x(2)"  INIT ""     /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr3     AS CHAR FORMAT "x(2)"  INIT ""     /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD br_insured    AS CHAR FORMAT "x(5)"  INIT ""     /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD campaign_ov   AS CHAR FORMAT "x(30)" INIT ""     /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
    FIELD insnamtyp     AS CHAR FORMAT "x(60)" INIT ""     /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD financecd     AS CHAR FORMAT "x(60)" INIT "".    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
DEF VAR nv_chkerror     AS CHAR FORMAT "x(250)" INIT "".   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
DEF VAR nv_postcd       AS CHAR FORMAT "x(250)" INIT "".   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    /* A60-0232 */  .
def    NEW SHARED VAR   nv_message as   char.
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
DEFINE VAR  nv_tmppolrun AS INTEGER FORMAT "999"         INIT 0. /*Temp Policy Running No.*/
DEFINE VAR  nv_batbrn    AS CHARACTER FORMAT "x(2)"      INIT ""  NO-UNDO. /*Batch Branch*/
DEFINE VAR  nv_tmppol    AS CHARACTER FORMAT "x(16)"     INIT "".  /*Temp Policy*/
DEFINE VAR  nv_rectot    AS INT  FORMAT ">>,>>9"         INIT 0.   /* Display จำนวน ก/ธ ทั้งไฟล์ */
DEFINE VAR  nv_recsuc    AS INT  FORMAT ">>,>>9"         INIT 0.   /* Display จำนวน ก/ธ ที่นำเข้าได้ */
DEFINE VAR  nv_netprm_t  AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.   /* Display เบี้ยรวม ทั้งไฟล์ */
DEFINE VAR  nv_netprm_s  AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.   /* Display เบี้ยรวม ที่นำเข้าได้ */
DEFINE VAR  nv_batflg    AS LOG                          INIT NO.
DEFINE VAR  nv_txtmsg    AS CHAR FORMAT "x(50)"          INIT "".   /* Parameter คู่กับ nv_check */
DEF VAR n_model AS CHAR FORMAT "x(40)".
DEF    VAR nv_insref   AS CHAR      FORMAT "x(10)" INIT "" .      /*a56-0309*/
DEFINE VAR n_insref    AS CHARACTER FORMAT "X(10)" .              /*a56-0309*/
DEFINE VAR nv_usrid     AS CHARACTER FORMAT "X(08)".              /*a56-0309*/ 
DEFINE VAR nv_transfer  AS LOGICAL   .                            /*a56-0309*/ 
DEFINE VAR n_check      AS CHARACTER .                            /*a56-0309*/ 
DEFINE VAR putchr       AS CHAR FORMAT "X(200)" INIT "" NO-UNDO.  /*a56-0309*/ 
DEFINE VAR putchr1      AS CHAR FORMAT "X(100)" INIT "" NO-UNDO.  /*a56-0309*/ 
DEFINE VAR nv_typ       AS CHAR FORMAT "X(2)".                    /*a56-0309*/ 
DEF VAR n_search   AS LOGICAL INIT YES .                          /*a56-0309*/ 
DEF VAR nv_lastno  AS INT INIT 0.                                 /*a56-0309*/ 
DEF VAR nv_seqno   AS INT INIT 0.                                 /*a56-0309*/ 
