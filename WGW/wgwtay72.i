/*programid   : wgwtay72.w                                                                 */ 
/*programname : load text file AYCL Compulsory to GW                                                  */ 
/*Copyright   : Safety Insurance Public Company Limited บริษัท ประกันคุ้มภัย จำกัด (มหาชน) */ 
/*create by   : Kridtiya i. A57-0005 date . 08/01/2014                                   */ 
DEF VAR  np_SEQ                 AS CHAR FORMAT "X(10)"  INIT ""  .     /* 1   SEQ          */ 
DEF VAR  np_INSURANCECODE       AS CHAR FORMAT "X(10)"  INIT ""  .     /* 2   INSURANCECODE*/ 
DEF VAR  np_CONTRACTNO          AS CHAR FORMAT "X(20)"  INIT ""  .     /* 3   CONTRACTNO   */ 
DEF VAR  np_BRANCHCODE          AS CHAR FORMAT "X(10)"  INIT ""  .     /* 4   BRANCHCODE   */ 
DEF VAR  np_BRANCHNO            AS CHAR FORMAT "X(150)" INIT ""  .     /* 5   BRANCHNO     */ 
DEF VAR  np_POLICY_COMP         AS CHAR FORMAT "X(12)"  INIT ""  .     /* 6   POLICY_COMP  */ 
DEF VAR  np_branch              AS CHAR FORMAT "x(2)"   INIT ""  .
DEF VAR  np_STICKERNO           AS CHAR FORMAT "X(50)"  INIT ""  .     /* 7   STICKERNO    */ 
DEF VAR  np_CUSTOMERNAME        AS CHAR FORMAT "X(100)" INIT ""  .     /* 8   CUSTOMERNAME */ 
DEF VAR  np_ADDRESS             AS CHAR FORMAT "X(150)" INIT ""  .     /* 9   ADDRESS      */ 
DEF VAR  np_CARNO               AS CHAR FORMAT "X(10)"  INIT ""  .     /* 10  CARNO        */ 
DEF VAR  np_BRAND               AS CHAR FORMAT "X(30)"  INIT ""  .     /* 11  BRAND        */ 
DEF VAR  np_MODEL               AS CHAR FORMAT "X(60)"  INIT ""  .     /* 12  MODEL        */ 
DEF VAR  np_CC                  AS CHAR FORMAT "X(10)"  INIT ""  .     /* 13  CC           */ 
DEF VAR  np_REGISTRATION        AS CHAR FORMAT "X(11)"  INIT ""  .     /* 14  REGISTRATION */ 
DEF VAR  np_PROVINCE            AS CHAR FORMAT "X(30)"  INIT ""  .     /* 15  PROVINCE     */ 
DEF VAR  np_BODY                AS CHAR FORMAT "X(30)"  INIT ""  .     /* 16  BODY         */ 
DEF VAR  np_ENGINE              AS CHAR FORMAT "X(30)"  INIT ""  .     /* 17  ENGINE       */ 
DEF VAR  np_STARTDATE           AS CHAR FORMAT "X(10)"  INIT ""  .     /* 18  STARTDATE    */ 
DEF VAR  np_ENDDATE             AS CHAR FORMAT "X(10)"  INIT ""  .     /* 19  ENDDATE      */ 
DEF VAR  np_NETINCOME           AS CHAR FORMAT "X(20)"  INIT ""  .     /* 20  NETINCOME    */ 
DEF VAR  np_TOTALINCOME         AS CHAR FORMAT "X(20)"  INIT ""  .     /* 21  TOTALINCOME  */ 
DEF VAR  np_CARDID              AS CHAR FORMAT "X(15)"  INIT ""  .     /* 22  CARDID       */  
DEFINE WORKFILE wdetail
    FIELD poltyp      AS CHAR FORMAT "x(3)"   INIT ""  
    FIELD policy      AS CHAR FORMAT "x(16)"  INIT ""   
    FIELD compul      AS CHAR FORMAT "x"      INIT ""
    FIELD notifydat   AS CHAR FORMAT "X(10)"  INIT "" 
    FIELD notifyno    AS CHAR FORMAT "x(20)"  INIT ""
    FIELD branch      AS CHAR FORMAT "x(2)"   INIT ""
    FIELD cedpol      AS CHAR FORMAT "x(25)"  INIT "" 
    FIELD insfer      AS CHAR FORMAT "x(10)"  INIT ""
    FIELD tiname      AS CHAR FORMAT "x(15)"  INIT ""   
    FIELD insnam      AS CHAR FORMAT "x(50)"  INIT ""  
    FIELD insnam2     AS CHAR FORMAT "x(50)"  INIT ""   
    FIELD insnam3     AS CHAR FORMAT "x(50)"  INIT ""   
    FIELD iadd1       AS CHAR FORMAT "x(150)" INIT ""    
    FIELD iadd2       AS CHAR FORMAT "x(35)"  INIT ""    
    FIELD iadd3       AS CHAR FORMAT "x(35)"  INIT ""    
    FIELD iadd4       AS CHAR FORMAT "x(35)"  INIT ""
    FIELD brand       AS CHAR FORMAT "x(30)"  INIT ""
    FIELD model       AS CHAR FORMAT "x(50)"  INIT ""
    FIELD vehreg      AS CHAR FORMAT "x(11)"  INIT ""
    FIELD caryear     AS CHAR FORMAT "x(4)"   INIT ""
    FIELD cc          AS CHAR FORMAT "x(10)"  INIT ""
    FIELD engno       AS CHAR FORMAT "x(25)"  INIT ""     
    FIELD chasno      AS CHAR FORMAT "x(25)"  INIT ""   
    FIELD notiuser    AS CHAR FORMAT "X(50)"  INIT ""   
    FIELD covcod      AS CHAR FORMAT "x"      INIT ""
    FIELD prepol      AS CHAR FORMAT "x(20)"  INIT ""
    FIELD comdat      AS CHAR FORMAT "x(10)"  INIT ""   
    FIELD expdat      AS CHAR FORMAT "x(10)"  INIT ""  
    FIELD premt       AS CHAR FORMAT "x(20)"  INIT ""
    FIELD volprem     AS CHAR FORMAT "x(20)"  INIT "" 
    FIELD garage      AS CHAR FORMAT "x"      INIT "" 
    FIELD textf6      AS CHAR FORMAT "X(100)" INIT "" 
    FIELD nmember     AS CHAR INIT "" FORMAT "x(255)" 
    FIELD nmember2    AS CHAR INIT "" FORMAT "x(255)"
    FIELD benname     AS CHAR FORMAT "x(100)" INIT ""  
    FIELD vatcode     AS CHAR FORMAT "x(10)"  INIT ""   
    FIELD prempa      AS CHAR FORMAT "x"      INIT ""    
    FIELD subclass    AS CHAR FORMAT "x(3)"   INIT ""    
    FIELD weight      AS CHAR FORMAT "x(10)"  INIT ""
    FIELD seat        AS CHAR FORMAT "x(2)"   INIT ""
    FIELD body        AS CHAR FORMAT "x(20)"  INIT ""
    FIELD vehuse      AS CHAR FORMAT "x"      INIT ""     
    FIELD stk         AS CHAR FORMAT "x(15)"  INIT ""     
    FIELD access      AS CHAR FORMAT "x"      INIT "" 
    FIELD ncb         AS CHAR FORMAT "x(10)"  INIT ""   
    FIELD tpbiper     AS CHAR FORMAT "x(20)"  INIT ""  
    FIELD tpbiacc     AS CHAR FORMAT "x(20)"  INIT ""  
    FIELD tppdacc     AS CHAR FORMAT "x(20)"  INIT "" 
    FIELD si          AS CHAR FORMAT "x(20)"  INIT ""   
    FIELD fi          AS CHAR FORMAT "x(20)"  INIT ""
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
    FIELD redbook     AS CHAR INIT "" FORMAT "X(8)"     
    FIELD base        AS CHAR INIT "" FORMAT "x(8)"     
    FIELD accdat      AS CHAR INIT "" FORMAT "x(10)"    
    FIELD docno       AS CHAR INIT "" FORMAT "x(10)"    
    FIELD idno        AS CHAR FORMAT "X(15)"  INIT ""  
    FIELD prekpi      AS CHAR FORMAT "X(20)"  INIT ""  
    FIELD payamount   AS CHAR FORMAT "X(10)"  INIT ""  
    /*FIELD delerco     AS CHAR FORMAT "x(10)"  INIT ""  
    FIELD remak1      AS CHAR FORMAT "x(100)" INIT ""
    FIELD typecar     AS CHAR FORMAT "x(30)"  INIT ""
    FIELD ispno       AS CHAR FORMAT "X(30)"  INIT ""   
    FIELD birthday    AS CHAR FORMAT "X(100)"  INIT ""  
    FIELD occupins    AS CHAR FORMAT "X(100)" INIT ""   
    FIELD namedirect  AS CHAR FORMAT "X(100)" INIT ""  
    FIELD drivname1   AS CHAR FORMAT "X(100)" INIT "" 
    FIELD idnodri1    AS CHAR FORMAT "X(20)"  INIT ""  
    FIELD drivname2   AS CHAR FORMAT "X(100)" INIT ""  
    FIELD idnodri2    AS CHAR FORMAT "X(20)"  INIT ""   
    FIELD campaigno   AS CHAR FORMAT "X(20)"  INIT ""    */         .
DEF VAR n_firstdat      AS CHAR FORMAT "x(10)"  INIT ""  .
def    NEW SHARED VAR   nv_message as   char.
DEF VAR nv_riskgp        LIKE sicuw.uwm120.riskgp         NO-UNDO.
DEFINE NEW SHARED VAR no_baseprm AS DECI  FORMAT ">>,>>>,>>9.99-".  /*note add test Base Premium 25/09/2006*/
DEFINE NEW SHARED VAR NO_basemsg AS CHAR  FORMAT "x(50)" .          /*Warning Error If Not in Range 25/09/2006 */
DEFINE            VAR nv_accdat  AS DATE  FORMAT "99/99/9999" INIT ?  .     
DEFINE            VAR nv_docno   AS CHAR  FORMAT "9999999"    INIT " ".
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
DEF  VAR nr_use     AS DECI     FORMAT ">,>>>,>>9.99" INIT 0.  
DEF  VAR nr_grpvar  AS DECI     FORMAT ">,>>>,>>9.99" INIT 0.  
DEF  VAR nr_yrvar   AS DECI     FORMAT ">,>>>,>>9.99" INIT 0.  
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
DEF VAR naddr1  AS CHAR INIT "" .
DEF VAR naddr2  AS CHAR INIT "" .
DEF VAR naddr3  AS CHAR INIT "" .
DEF VAR naddr4  AS CHAR INIT "" .
DEFINE  WORKFILE wcomp NO-UNDO
/*1*/    FIELD package     AS CHARACTER FORMAT "X(10)"   INITIAL ""
/*2*/    FIELD premcomp    AS DECI FORMAT "->>,>>9.99"    INITIAL 0.
DEF VAR n_packcomp AS CHAR FORMAT "X(10)"   INITIAL "".
