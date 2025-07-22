/* PORGRAm ID   : WGWAY721.I                                                                 */
/* PROGRAM NAME : SUBPROGRAM LOAD TEXT FILE COMPUKSORY AYCAL                                 */
/* Copyright    : Safety Insurance Public Company Limited บริษัท ประกันคุ้มภัย จำกัด (มหาชน) */ 
/* CREATE BY    : PORNTIWA P.  A59-0069   DATE: 10/03/2016                                   */
/*Modify       : Jiraporn P. [A59-0342]   date 13/08/2016
             : เพิ่มตัวแปร seat */
/*Modify by   : Kridtiya i. A63-0472 Date. 09/11/2020 add field firstname ,lastname.....*/
/*Modify by  : Ranu I. A64-0060 Date. 16/02/2020 แก้ไขการเช็ค campaign และแก้ไข producer code */
/*Modify by  : Ranu I. A67-0204 ขยายตัวแปร Subclass    */
/*-- ส่วนการนำเข้า --*/
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
DEF VAR  np_ADDRESS2            AS CHAR FORMAT "X(150)" INIT ""  .     /* 10  ADDRESS      */ /*Jiraphon A59-0451*/
DEF VAR  np_ADDRESS3            AS CHAR FORMAT "X(150)" INIT ""  .     /* 11  ADDRESS      */ /*Jiraphon A59-0451*/
DEF VAR  np_ADDRESS4            AS CHAR FORMAT "X(150)" INIT ""  .     /* 12  ADDRESS      */ /*Jiraphon A59-0451*/
DEF VAR  np_ADDRESS5            AS CHAR FORMAT "X(150)" INIT ""  .     /* 13  ADDRESS      */ /*Jiraphon A59-0451*/
DEF VAR  np_CARNO               AS CHAR FORMAT "X(10)"  INIT ""  .     /* 10  CARNO        */ 
DEF VAR  np_modcod              AS CHAR FORMAT "X(10)"  INIT ""  .     /* Model Code  A59-0069*/
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
DEF VAR  np_producer            AS CHAR FORMAT "X(10)"  INIT ""  .     /* Producer Code  A59-0069*/
DEF VAR  np_agent               AS CHAR FORMAT "X(10)"  INIT ""  .     /* Agent Code  A59-0069*/
DEF VAR  np_status              AS CHAR FORMAT "x(15)"  INIT ""  .     /* A64-0060 */
DEF VAR  np_remark              AS CHAR FORMAT "x(15)"  INIT ""  .     /* Remark OV A64-0060 */

/*-- GEN DATA TEANS. --*/
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
    FIELD nmember     AS CHAR FORMAT "x(255)" INIT ""
    FIELD nmember2    AS CHAR FORMAT "x(255)" INIT ""
    FIELD benname     AS CHAR FORMAT "x(100)" INIT ""  
    FIELD vatcode     AS CHAR FORMAT "x(10)"  INIT ""   
    FIELD prempa      AS CHAR FORMAT "x"      INIT ""    
    /*FIELD subclass    AS CHAR FORMAT "x(3)"   INIT ""  */ /*A67-0204*/  
    FIELD subclass    AS CHAR FORMAT "x(5)"   INIT ""   /*A67-0204*/ 
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
    FIELD comper      AS CHAR FORMAT ">,>>>,>>>,>>>,>>9" INIT "50000"                     
    FIELD comacc      AS CHAR FORMAT ">,>>>,>>>,>>>,>>9" INIT "50000"                     
    FIELD NO_41       AS CHAR FORMAT ">,>>>,>>>,>>>,>>9" INIT "50000"                     
    FIELD NO_42       AS CHAR FORMAT ">,>>>,>>>,>>>,>>9" INIT "50000"                      
    FIELD NO_43       AS CHAR FORMAT ">,>>>,>>>,>>>,>>9" INIT "200000"                    
    FIELD baseprem    AS INTE FORMAT ">,>>>,>>>,>>>,>>9" INIT  0
    FIELD cargrp      AS CHAR FORMAT "x(2)"   INIT ""      
    FIELD producer    AS CHAR FORMAT "x(10)"  INIT ""      
    FIELD agent       AS CHAR FORMAT "x(10)"  INIT "" 
    FIELD redbook     AS CHAR FORMAT "X(8)"   INIT ""   
    FIELD base        AS CHAR FORMAT "x(8)"   INIT ""   
    FIELD accdat      AS CHAR FORMAT "x(10)"  INIT ""   
    FIELD docno       AS CHAR FORMAT "x(10)"  INIT ""   
    FIELD idno        AS CHAR FORMAT "X(15)"  INIT ""  
    FIELD prekpi      AS CHAR FORMAT "X(20)"  INIT ""  
    FIELD payamount   AS CHAR FORMAT "X(10)"  INIT ""  
    FIELD financecd   AS CHAR FORMAT "x(60)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD firstName   AS CHAR FORMAT "x(60)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD lastName    AS CHAR FORMAT "x(60)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD postcd      AS CHAR FORMAT "x(15)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeocc     AS CHAR FORMAT "x(4)"   INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr1   AS CHAR FORMAT "x(2)"   INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr2   AS CHAR FORMAT "x(2)"   INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr3   AS CHAR FORMAT "x(2)"   INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD br_insured  AS CHAR FORMAT "x(5)"   INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD campaign_ov AS CHAR FORMAT "x(30)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
    FIELD insnamtyp   AS CHAR FORMAT "x(60)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD remark      AS CHAR FORMAT "x(15)"  INIT ""   /* A64-0060 */
    FIELD province    AS CHAR FORMAT "x(35)"  INIT "" . /* A64-0060 */
DEF VAR nv_chkerror   AS CHAR FORMAT "x(250)"  INIT "".  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
DEF VAR nv_postcd     AS CHAR FORMAT "x(15)"  INIT "".  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
 

DEF NEW SHARED VAR nv_seat41   AS INTEGER      FORMAT ">>9".            
DEF NEW SHARED VAR nv_totsi    AS DECIMAL      FORMAT ">>,>>>,>>9.99-".   
DEF NEW SHARED VAR nv_polday   AS INTE         FORMAT ">>9".             
DEF NEW SHARED VAR nv_uom6_u   AS CHAR.        
DEF NEW SHARED VAR nv_odcod    AS CHAR         FORMAT "X(4)".                               
DEF NEW SHARED VAR nv_cons     AS CHAR         FORMAT "X(2)".                               
DEF NEW SHARED VAR nv_prem     AS DECIMAL      FORMAT ">,>>>,>>9.99-"   INITIAL 0  NO-UNDO. 
DEF NEW SHARED VAR nv_baseap   AS DECI         FORMAT ">>,>>>,>>9.99-".                    
DEF NEW SHARED VAR nv_ded      AS INTEGER      FORMAT ">>,>>>,>>9"      INITIAL 0  NO-UNDO. 
DEF NEW SHARED VAR nv_gapprm   AS DECI         FORMAT ">>,>>>,>>9.99-"  INITIAL 0  NO-UNDO. 
DEF NEW SHARED VAR nv_pdprm    AS DECI         FORMAT ">>,>>>,>>9.99-"  INITIAL 0  NO-UNDO. 
DEF NEW SHARED VAR nv_prvprm   AS DECI         FORMAT ">>,>>>,>>9.99-".                     
DEF NEW SHARED VAR nv_41prm    AS INTEGER      FORMAT ">,>>>,>>9"       INITIAL 0  NO-UNDO. 
DEF NEW SHARED VAR nv_ded1prm  AS INTEGER      FORMAT ">>>,>>9-"        INITIAL 0  NO-UNDO. 
DEF NEW SHARED VAR nv_aded1prm AS INTEGER      FORMAT ">>>,>>9-"        INITIAL 0  NO-UNDO. 
DEF New SHARED VAR nv_ded2prm  AS INTEGER      FORMAT ">>>,>>9-"        INITIAL 0  NO-UNDO.
DEF NEW SHARED VAR nv_dedod    AS INTEGER      FORMAT ">>,>>>,>>9"      INITIAL 0  NO-UNDO.
DEF NEW SHARED VAR nv_addod    AS INTEGER      FORMAT ">>,>>>,>>9"      INITIAL 0  NO-UNDO.
DEF NEW SHARED VAR nv_dedpd    AS INTEGER      FORMAT ">>,>>>,>>9"      INITIAL 0  NO-UNDO.
DEF NEW SHARED VAR nv_prem1    AS DECIMAL      FORMAT ">,>>>,>>9.99-"   INITIAL 0  NO-UNDO.
DEF NEW SHARED VAR nv_addprm   AS INTEGER      FORMAT ">>,>>>,>>9"      INITIAL 0  NO-UNDO.
DEF NEW SHARED VAR nv_totded   AS INTEGER      FORMAT ">>,>>>,>>9-"     INITIAL 0  NO-UNDO.
DEF NEW SHARED VAR nv_totdis   AS INTEGER      FORMAT ">>,>>>,>>9-"     INITIAL 0  NO-UNDO.
DEF NEW SHARED VAR nv_41cod1   AS CHARACTER    FORMAT "X(4)".
DEF NEW SHARED VAR nv_41cod2   AS CHARACTER    FORMAT "X(4)".
DEF NEW SHARED VAR nv_41       AS INTEGER      FORMAT ">>>,>>>,>>9".
DEF NEW SHARED VAR nv_411prm   AS DECI         FORMAT ">,>>>,>>9.99".
DEF NEW SHARED VAR nv_412prm   AS DECI         FORMAT ">,>>>,>>9.99".
DEF NEW SHARED VAR nv_411var1  AS CHAR         FORMAT "X(30)".
DEF NEW SHARED VAR nv_411var2  AS CHAR         FORMAT "X(30)".
DEF NEW SHARED VAR nv_411var   AS CHAR         FORMAT "X(60)".
DEF NEW SHARED VAR nv_412var1  AS CHAR         FORMAT "X(30)".
DEF NEW SHARED VAR nv_412var2  AS CHAR         FORMAT "X(30)".
DEF NEW SHARED VAR nv_412var   AS CHAR         FORMAT "X(60)".
DEF NEW SHARED VAR nv_42cod    AS CHARACTER    FORMAT "X(4)".
DEF NEW SHARED VAR nv_42       AS INTEGER      FORMAT ">>>,>>>,>>9".
DEF NEW SHARED VAR nv_42prm    AS DECI         FORMAT ">,>>>,>>9.99".
DEF NEW SHARED VAR nv_42var1   AS CHAR         FORMAT "X(30)".
DEF NEW SHARED VAR nv_42var2   AS CHAR         FORMAT "X(30)".
DEF NEW SHARED VAR nv_42var    AS CHAR         FORMAT "X(60)".
DEF NEW SHARED VAR nv_43cod    AS CHARACTER    FORMAT "X(4)".
DEF NEW SHARED VAR nv_43       AS INTEGER      FORMAT ">>>,>>>,>>9".
DEF NEW SHARED VAR nv_43prm    AS DECI         FORMAT ">,>>>,>>9.99".
DEF NEW SHARED VAR nv_43var1   AS CHAR         FORMAT "X(30)".
DEF NEW SHARED VAR nv_43var2   AS CHAR         FORMAT "X(30)".
DEF NEW SHARED VAR nv_43var    AS CHAR         FORMAT "X(60)".
DEF NEW SHARED VAR nv_campcod  AS CHAR         FORMAT "X(4)".
DEF NEW SHARED VAR nv_camprem  AS DECI         FORMAT ">>>9".
DEF NEW SHARED VAR nv_campvar1 AS CHAR         FORMAT "X(30)".
DEF NEW SHARED VAR nv_campvar2 AS CHAR         FORMAT "X(30)".
DEF NEW SHARED VAR nv_campvar  AS CHAR         FORMAT "X(60)".
DEF NEW SHARED VAR nv_compcod  AS CHAR         FORMAT "X(4)".
DEF NEW SHARED VAR nv_compprm  AS DECI         FORMAT ">>>,>>9.99-".
DEF NEW SHARED VAR nv_compvar1 AS CHAR         FORMAT "X(30)".
DEF NEW SHARED VAR nv_compvar2 AS CHAR         FORMAT "X(30)".
DEF NEW SHARED VAR nv_compvar  AS CHAR         FORMAT "X(60)".
DEF NEW SHARED VAR nv_basecod  AS CHAR         FORMAT "X(4)".
DEF NEW SHARED VAR nv_baseprm  AS DECI         FORMAT ">>,>>>,>>9.99-". 
DEF NEW SHARED VAR nv_basevar1 AS CHAR         FORMAT "X(30)".
DEF NEW SHARED VAR nv_basevar2 AS CHAR         FORMAT "X(30)".
DEF NEW SHARED VAR nv_basevar  AS CHAR         FORMAT "X(60)".
/*-- LOAD CLAIM --*/
DEF NEW  SHARED VAR nv_cl_cod     AS CHAR     FORMAT "X(4)".
DEF NEW  SHARED VAR nv_cl_per     AS DECIMAL  FORMAT ">9.99".
DEF NEW  SHARED VAR nv_lodclm     AS INTEGER  FORMAT ">>>,>>9.99-".
DEF NEW  SHARED VAR nv_lodclm1    AS INTEGER  FORMAT ">>>,>>9.99-".
DEF NEW  SHARED VAR nv_clmvar1    AS CHAR     FORMAT "X(30)".
DEF NEW  SHARED VAR nv_clmvar2    AS CHAR     FORMAT "X(30)".
DEF NEW  SHARED VAR nv_clmvar     AS CHAR     FORMAT "X(60)".
/*-- STAFF--*/                              
DEF NEW  SHARED VAR nv_stf_cod    AS CHAR     FORMAT "X(4)".
DEF NEW  SHARED VAR nv_stf_per    AS DECIMAL  FORMAT ">9.99".
DEF NEW  SHARED VAR nv_stf_amt    AS INTEGER  FORMAT ">>>,>>9.99-".
DEF NEW  SHARED VAR nv_stfvar1    AS CHAR     FORMAT "X(30)".
DEF NEW  SHARED VAR nv_stfvar2    AS CHAR     FORMAT "X(30)".
DEF NEW  SHARED VAR nv_stfvar     AS CHAR     FORMAT "X(60)".
/*-- DSCP--*/       
DEF NEW  SHARED VAR nv_dss_cod    AS CHAR     FORMAT "X(4)".
DEF NEW  SHARED VAR nv_dss_per    AS DECIMAL  FORMAT ">9.99".
DEF NEW  SHARED VAR nv_dsspc      AS INTEGER  FORMAT ">>>,>>9.99-".
DEF NEW  SHARED VAR nv_dsspcvar1  AS CHAR     FORMAT "X(30)".
DEF NEW  SHARED VAR nv_dsspcvar2  AS CHAR     FORMAT "X(30)".
DEF NEW  SHARED VAR nv_dsspcvar   AS CHAR     FORMAT "X(60)".
/*-- NCB --*/       
DEF NEW  SHARED VAR nv_ncb_cod    AS CHAR     FORMAT "X(4)".
DEF NEW  SHARED VAR nv_ncbper     LIKE sicuw.uwm301.ncbper.
DEF NEW  SHARED VAR nv_ncb        AS DECI     FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR nv_ncbvar1    AS CHAR     FORMAT "X(30)".
DEF NEW  SHARED VAR nv_ncbvar2    AS CHAR     FORMAT "X(30)".
DEF NEW  SHARED VAR nv_ncbvar     AS CHAR     FORMAT "X(60)".
/*-- Fleet --*/     
DEF NEW  SHARED VAR nv_flet_cod   AS CHAR     FORMAT "X(4)".
DEF NEW  SHARED VAR nv_flet_per   AS DECIMAL  FORMAT ">>9".
DEF NEW  SHARED VAR nv_flet       AS DECI     FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR nv_fletvar1   AS CHAR     FORMAT "X(30)".
DEF NEW  SHARED VAR nv_fletvar2   AS CHAR     FORMAT "X(30)".
DEF NEW  SHARED VAR nv_fletvar    AS CHAR     FORMAT "X(60)".
/*-- COMP --*/
DEF NEW  SHARED VAR nv_vehuse       LIKE sicuw.uwm301.vehuse.                 
DEF NEW  SHARED VAR nv_grpcod       AS CHARACTER FORMAT "X(4)".
DEF NEW  SHARED VAR nv_grprm        AS DECI      FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR nv_grpvar1      AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR nv_grpvar2      AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR nv_grpvar       AS CHAR      FORMAT "X(60)".
DEF NEW  SHARED VAR nv_othcod       AS CHARACTER FORMAT "X(4)".
DEF NEW  SHARED VAR nv_othprm       AS DECI      FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR nv_othvar1      AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR nv_othvar2      AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR nv_othvar       AS CHAR      FORMAT "X(60)".
DEF NEW  SHARED VAR nv_dedod1_cod   AS CHAR      FORMAT "X(4)".             
DEF NEW  SHARED VAR nv_dedod1_prm   AS DECI      FORMAT ">,>>>,>>9.99-".    
DEF NEW  SHARED VAR nv_dedod1var1   AS CHAR      FORMAT "X(30)".            
DEF NEW  SHARED VAR nv_dedod1var2   AS CHAR      FORMAT "X(30)".            
DEF NEW  SHARED VAR nv_dedod1var    AS CHAR      FORMAT "X(60)".            
DEF NEW  SHARED VAR nv_dedod2_cod   AS CHAR      FORMAT "X(4)".             
DEF NEW  SHARED VAR nv_dedod2_prm   AS DECI      FORMAT ">,>>>,>>9.99-".    
DEF NEW  SHARED VAR nv_dedod2var1   AS CHAR      FORMAT "X(30)".            
DEF NEW  SHARED VAR nv_dedod2var2   AS CHAR      FORMAT "X(30)".            
DEF NEW  SHARED VAR nv_dedod2var    AS CHAR      FORMAT "X(60)".            
DEF NEW  SHARED VAR nv_dedpd_cod    AS CHAR      FORMAT "X(4)".             
DEF NEW  SHARED VAR nv_dedpd_prm    AS DECI      FORMAT ">,>>>,>>9.99-".    
DEF NEW  SHARED VAR nv_dedpdvar1    AS CHAR      FORMAT "X(30)".            
DEF NEW  SHARED VAR nv_dedpdvar2    AS CHAR      FORMAT "X(30)".            
DEF NEW  SHARED VAR nv_dedpdvar     AS CHAR      FORMAT "X(60)". 
/*-- USFBAS --*/
DEF NEW SHARED VAR nv_tariff   LIKE sicuw.uwm301.tariff.
DEF NEW SHARED VAR nv_comdat   LIKE sicuw.uwm100.comdat.
DEF NEW SHARED VAR nv_covcod   LIKE sicuw.uwm301.covcod.
/*DEF NEW SHARED VAR nv_class    AS CHAR    FORMAT "X(4)".*/ /*A67-0204*/
DEF NEW SHARED VAR nv_class    AS CHAR    FORMAT "X(5)".  /*A67-0204*/
DEF NEW SHARED VAR nv_key_b    AS DECIMAL FORMAT ">>>,>>>,>>>,>>9.99-" INITIAL 0 NO-UNDO.
DEF NEW SHARED VAR nv_drivname AS logic INIT NO .
DEF NEW SHARED VAR nv_drivno   AS INT   INIT 0  . 
DEF NEW SHARED VAR nv_drivcod  AS CHARACTER FORMAT "X(4)".
DEF NEW SHARED VAR nv_drivprm  AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW SHARED VAR nv_drivvar1 AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR nv_drivvar2 AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR nv_drivvar  AS CHAR  FORMAT "X(60)".
/*-- USECOD --*/
DEF NEW SHARED VAR nv_usecod   AS CHARACTER FORMAT "X(4)".
DEF NEW SHARED VAR nv_useprm   AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW SHARED VAR nv_usevar1  AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR nv_usevar2  AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR nv_usevar   AS CHAR  FORMAT "X(60)".
DEF NEW SHARED VAR nv_sicod    AS CHARACTER FORMAT "X(4)".
DEF NEW SHARED VAR nv_siprm    AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW SHARED VAR nv_sivar1   AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR nv_sivar2   AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR nv_sivar    AS CHAR  FORMAT "X(60)".
DEF NEW SHARED VAR nv_uom6_c   AS CHAR.      /* Sum  si*/
DEF NEW SHARED VAR nv_uom7_c   AS CHAR.      /* Fire/Theft*/
DEF NEW SHARED VAR nv_bipcod   AS CHARACTER FORMAT "X(4)".
DEF NEW SHARED VAR nv_bipprm   AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW SHARED VAR nv_bipvar1  AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR nv_bipvar2  AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR nv_bipvar   AS CHAR  FORMAT "X(60)".
DEF NEW SHARED VAR nv_biacod   AS CHARACTER FORMAT "X(4)".
DEF NEW SHARED VAR nv_biaprm   AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW SHARED VAR nv_biavar1  AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR nv_biavar2  AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR nv_biavar   AS CHAR  FORMAT "X(60)".
DEF NEW SHARED VAR nv_pdacod   AS CHARACTER FORMAT "X(4)".
DEF NEW SHARED VAR nv_pdaprm   AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW SHARED VAR nv_pdavar1  AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR nv_pdavar2  AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR nv_pdavar   AS CHAR  FORMAT "X(60)".
DEF NEW SHARED VAR nv_engine   LIKE sicsyac.xmm102.engine.       
DEF NEW SHARED VAR nv_tons     LIKE sicsyac.xmm102.tons.         
DEF NEW SHARED VAR nv_seats    LIKE sicsyac.xmm102.seats.        
/*DEF NEW SHARED VAR nv_sclass   AS CHAR FORMAT "x(3)". */   /*A67-0204*/
DEF NEW SHARED VAR nv_sclass   AS CHAR FORMAT "x(5)".        /*A67-0204*/    
DEF NEW SHARED VAR nv_engcod   AS CHAR FORMAT "x(4)".            
DEF NEW SHARED VAR nv_engprm   AS DECI FORMAT ">>,>>>,>>9.99-". 
DEF NEW SHARED VAR nv_engvar1  AS CHAR FORMAT "X(30)".          
DEF NEW SHARED VAR nv_engvar2  AS CHAR FORMAT "X(30)".          
DEF NEW SHARED VAR nv_engvar   AS CHAR FORMAT "X(60)".  
DEF NEW SHARED VAR nv_poltyp   AS CHAR   INIT  "".
DEF NEW SHARED VAR nv_yrcod    AS CHARACTER FORMAT "X(4)".
DEF NEW SHARED VAR nv_yrprm    AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW SHARED VAR nv_yrvar1   AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR nv_yrvar2   AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR nv_yrvar    AS CHAR  FORMAT "X(60)".
DEF NEW SHARED VAR nv_caryr    AS INTE  FORMAT ">>>9" .
DEF NEW SHARED VAR nv_dspc     AS DECI.
DEF NEW SHARED VAR nv_mv1      AS INT .
DEF NEW SHARED VAR nv_mv1_s    AS INT . 
DEF NEW SHARED VAR nv_mv2      AS INT . 
DEF NEW SHARED VAR nv_mv3      AS INT . 
DEF NEW SHARED VAR nv_comprm   AS INT .  
DEF NEW SHARED VAR nv_model    AS CHAR.  
DEF NEW SHARED VAR chr_sticker AS CHAR FORMAT "9999999999999" INIT "".  
DEF NEW SHARED VAR nv_modulo   AS INT  FORMAT "9".
DEF NEW SHARED VAR nv_branch   LIKE sicsyac.XMM023.BRANCH.  
DEF NEW SHARED VAR nv_makdes   AS CHAR    .
DEF NEW SHARED VAR nv_moddes   AS CHAR.
DEF NEW SHARED VAR nv_message  AS CHAR.
DEF NEW SHARED VAR no_baseprm  AS DECI  FORMAT ">>,>>>,>>9.99-".  /*note add test Base Premium 25/09/2006*/
DEF NEW SHARED VAR NO_basemsg  AS CHAR  FORMAT "x(50)" . 
DEF NEW SHARED VAR nv_batchyr  AS INT FORMAT "9999"        INIT 0.
DEF NEW SHARED VAR nv_batcnt   AS INT FORMAT "99"          INIT 0.
DEF NEW SHARED VAR nv_batchno  AS CHARACTER FORMAT "X(13)" INIT ""  NO-UNDO.
DEF     SHARED VAR n_User      AS CHAR . 
DEF VAR chk         AS LOGICAL.
DEF VAR model       AS CHAR .
DEF VAR aa          AS DECI.
DEF VAR n_prem      AS DECI.
DEF VAR nv_uom1_v   AS INTE INIT 0.     
DEF VAR nv_uom2_v   AS INTE INIT 0.     
DEF VAR nv_uom5_v   AS INTE INIT 0.
DEF VAR dod0        AS DECI.
DEF VAR dod1        AS DECI.
DEF VAR dod2        AS DECI.
DEF VAR dpd0        AS DECI.
DEF VAR nv_comper   AS DECI INIT 0.                 
DEF VAR nv_comacc   AS DECI INIT 0.                 
DEF VAR nv_modcod   AS CHAR FORMAT "x(8)" INIT "" .              
DEF VAR nv_chk      AS LOGICAL.                                         
DEF VAR nv_ncbyrs   AS INTE.  
DEF VAR NO_CLASS    AS CHAR INIT "".                              
DEF VAR no_tariff   AS CHAR INIT "".

DEF VAR s_recid1          AS RECID .     /* uwm100  */
DEF VAR s_recid2          AS RECID .     /* uwm120  */
DEF VAR s_recid3          AS RECID .     /* uwm130  */  
DEF VAR s_recid4          AS RECID .     /* uwm301  */                                 
                          
DEF VAR nv_lnumber        AS INTE INIT 0.
DEF VAR nv_provi          AS CHAR INIT "".
DEF VAR n_rencnt          LIKE sicuw.uwm100.rencnt INITIAL "".
DEF VAR nv_index          AS INT INIT  0.         
DEF VAR n_endcnt          LIKE sicuw.uwm100.endcnt INITIAL "".
DEF VAR n_comdat          LIKE sicuw.uwm100.comdat NO-UNDO.
DEF VAR n_policy          LIKE sicuw.uwm100.policy INITIAL "" .
DEF VAR nv_daily          AS CHARACTER FORMAT "X(1024)" INITIAL ""  NO-UNDO.
DEF VAR nv_reccnt         AS INT INIT 0.  
DEF VAR nv_completecnt    AS INT INIT 0.  

DEF VAR s_riskgp          AS INTE FORMAT ">9".
DEF VAR s_riskno          AS INTE FORMAT "999".
DEF VAR s_itemno          AS INTE FORMAT "999". 
DEF VAR nv_drivage1       AS INTE INIT 0.
DEF VAR nv_drivage2       AS INTE INIT 0.
DEF VAR nv_drivbir1       AS CHAR INIT "".
DEF VAR nv_drivbir2       AS CHAR INIT "".
DEF VAR nv_dept           AS CHAR FORMAT  "X(1)".
                          
DEF VAR nv_undyr          AS CHAR  INIT  ""    FORMAT   "X(4)".
DEF VAR n_newpol          LIKE sicuw.uwm100.policy  INIT  "".
DEF VAR n_curbil          LIKE sicuw.uwm100.curbil  NO-UNDO.
                          
DEF VAR nv_lastno         AS INT.
DEF VAR nv_seqno          AS INT.
DEF VAR sv_xmm600         AS RECID.

DEF VAR n_firstdat        AS CHAR FORMAT "x(10)"  INIT ""  .
DEF VAR nv_riskgp         LIKE sicuw.uwm120.riskgp         NO-UNDO.
DEF VAR nv_accdat         AS DATE  FORMAT "99/99/9999" INIT ?  .     
DEF VAR nv_docno          AS CHAR  FORMAT "9999999"    INIT " ".
DEF VAR nv_batrunno       AS INT FORMAT  ">,>>9"          INIT 0.
DEF VAR nv_imppol         AS INT  FORMAT ">>,>>9"         INIT 0.
DEF VAR nv_impprem        AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.
DEF VAR nv_batprev        AS CHARACTER FORMAT "X(13)"     INIT ""  NO-UNDO.
DEF VAR nv_tmppolrun      AS INTEGER FORMAT "999"         INIT 0.            /*Temp Policy Running No.*/
DEF VAR nv_batbrn         AS CHARACTER FORMAT "x(2)"      INIT ""  NO-UNDO.  /*Batch Branch*/
DEF VAR nv_tmppol         AS CHARACTER FORMAT "x(16)"     INIT "".           /*Temp Policy*/
DEF VAR nv_rectot         AS INT  FORMAT ">>,>>9"         INIT 0.            /* Display จำนวน ก/ธ ทั้งไฟล์ */
DEF VAR nv_recsuc         AS INT  FORMAT ">>,>>9"         INIT 0.            /* Display จำนวน ก/ธ ที่นำเข้าได้ */
DEF VAR nv_netprm_t       AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.            /* Display เบี้ยรวม ทั้งไฟล์ */
DEF VAR nv_netprm_s       AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.            /* Display เบี้ยรวม ที่นำเข้าได้ */
DEF VAR nv_batflg         AS LOG                          INIT NO.           
DEF VAR nv_txtmsg         AS CHAR FORMAT "x(50)"          INIT "".           /* Parameter คู่กับ nv_check */
DEF VAR n_model           AS CHAR FORMAT "x(40)".
DEF VAR n_41              AS DECI FORMAT ">,>>>,>>9.99" INIT 0.
DEF VAR n_42              AS DECI FORMAT ">,>>>,>>9.99" INIT 0.
DEF VAR n_43              AS DECI FORMAT ">,>>>,>>9.99" INIT 0.
DEF VAR nr_use            AS DECI FORMAT ">,>>>,>>9.99" INIT 0.  
DEF VAR nr_grpvar         AS DECI FORMAT ">,>>>,>>9.99" INIT 0.  
DEF VAR nr_yrvar          AS DECI FORMAT ">,>>>,>>9.99" INIT 0.  
DEF VAR nv_basere         AS DECI FORMAT ">>,>>>,>>9.99-" INIT 0. 
/*DEF VAR n_sclass72        AS CHAR FORMAT "x(4)".  A67-0204*/
DEF VAR n_sclass72        AS CHAR FORMAT "x(5)".  /*A67-0204*/
DEF VAR nv_maxdes         AS CHAR.
DEF VAR nv_mindes         AS CHAR.
DEF VAR nv_si             AS DECI FORMAT ">>,>>>,>>9.99-".  /* Maximum Sum Insure */
DEF VAR nv_maxSI          AS DECI FORMAT ">>,>>>,>>9.99-".  /* Maximum Sum Insure */
DEF VAR nv_minSI          AS DECI FORMAT ">>,>>>,>>9.99-".  /* Minimum Sum Insure */
DEF VAR nv_newsck         AS CHAR FORMAT "x(15)" INIT " ".
DEF VAR nv_simat          AS DECI FORMAT ">>>,>>>,>>>,>>9.99-".      
DEF VAR nv_simat1         AS DECI FORMAT ">>>,>>>,>>>,>>9.99-".     
DEF VAR nv_uwm301trareg   LIKE sic_bran.uwm301.cha_no INIT "".  
DEF VAR gv_id             AS CHAR FORMAT "X(8)" NO-UNDO.
DEF VAR nv_pwd            AS CHAR NO-UNDO.
DEF VAR n_insref          AS CHARACTER FORMAT "X(10)".  
DEF VAR nv_messagein      AS CHAR FORMAT "X(200)". 
DEF VAR nv_usrid          AS CHARACTER FORMAT "X(08)".
DEF VAR nv_transfer       AS LOGICAL   .
DEF VAR n_check           AS CHARACTER . 
DEF VAR nv_insref         AS CHARACTER FORMAT "X(10)".  
DEF VAR putchr            AS CHAR FORMAT "X(200)" INIT "" NO-UNDO.
DEF VAR putchr1           AS CHAR FORMAT "X(100)" INIT "" NO-UNDO.
DEF VAR nv_typ            AS CHAR FORMAT "X(2)".
DEF VAR nv_type           AS INTEGER  LABEL "Type".   
DEF VAR naddr1            AS CHAR INIT "" .
DEF VAR naddr2            AS CHAR INIT "" .
DEF VAR naddr3            AS CHAR INIT "" .
DEF VAR naddr4            AS CHAR INIT "" .
DEF VAR n_packcomp        AS CHAR FORMAT "X(10)"   INITIAL "".
DEF VAR nv_txt1           AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEF VAR nv_txt2           AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEF VAR nv_txt3           AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEF VAR nv_txt4           AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEF VAR nv_txt5           AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEF VAR nv_txt6           AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEF VAR nv_txt7           AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEF VAR nv_txt8           AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEF VAR nv_line1          AS INTEGER   INITIAL 0            NO-UNDO.
DEF VAR nv_nptr           AS RECID.
DEF VAR n_index           AS INTE INIT 0 .
DEF VAR n_index2          AS INTE INIT 0.
DEF VAR nc_r2             AS CHAR FORMAT "x(20)" INIT "".
DEF VAR no_policy         AS CHAR FORMAT "x(12)" .
DEF VAR no_rencnt         AS CHAR FORMAT "99".
DEF VAR no_endcnt         AS CHAR FORMAT "999".
DEF VAR no_riskno         AS CHAR FORMAT "999".
DEF VAR no_itemno         AS CHAR FORMAT "999".
DEF VAR nv_chkpol         AS CHAR FORMAT "X(30)" INITIAL "" NO-UNDO. 
DEF VAR nv_name1          AS CHAR FORMAT "X(50)".                  
DEF VAR nv_name2          AS CHAR FORMAT "X(50)".                  
DEF VAR nv_sex1           AS CHAR FORMAT "X(6)".                   
DEF VAR nv_sex2           AS CHAR FORMAT "X(6)".                   
DEF VAR nv_age1           AS CHAR FORMAT "X(2)".                     
DEF VAR nv_age2           AS CHAR FORMAT "X(2)".                    
DEF VAR nv_birdat1        AS DATE FORMAT "99/99/9999".               
DEF VAR nv_birdat2        AS DATE FORMAT "99/99/9999".              
DEF VAR nv_occup1         AS CHAR FORMAT "X(15)".                  
DEF VAR nv_occup2         AS CHAR FORMAT "X(15)".
DEF VAR nv_stm_per        AS DECIMAL FORMAT ">9.99" INITIAL 0 NO-UNDO.
DEF VAR nv_tax_per        AS DECIMAL FORMAT ">9.99" INITIAL 0 NO-UNDO.
DEF VAR nv_com1_per       AS DECIMAL FORMAT ">9.99" INITIAL 0 NO-UNDO.
DEF VAR nv_com1_prm       AS DECIMAL FORMAT ">>>>>9.99-"      NO-UNDO.
DEF VAR s_130bp1          AS RECID                            NO-UNDO.
DEF VAR s_130fp1          AS RECID                            NO-UNDO.
DEF VAR nvffptr           AS RECID                            NO-UNDO.
DEF VAR n_rd132           AS RECID                            NO-UNDO.
DEF VAR nv_gap            AS DECIMAL                          NO-UNDO.
DEF VAR nv_fptr           AS RECID.
DEF VAR nv_bptr           AS RECID.
DEF VAR nv_gap2           AS DECIMAL                          NO-UNDO.
DEF VAR nv_prem2          AS DECIMAL                          NO-UNDO.
DEF VAR nv_rstp           AS DECIMAL                          NO-UNDO.
DEF VAR nv_rtax           AS DECIMAL                          NO-UNDO.
DEF VAR nv_key_a          AS DECIMAL INITIAL 0                NO-UNDO.
DEF VAR nv_rec100         AS RECID .
DEF VAR nv_rec120         AS RECID .
DEF VAR nv_rec130         AS RECID .
DEF VAR nv_rec301         AS RECID .

DEFINE  WORKFILE wuppertxt NO-UNDO
/*1*/  FIELD line AS INTEGER   FORMAT ">>9"
/*2*/  FIELD txt  AS CHARACTER FORMAT "X(78)" INITIAL "".
DEFINE  WORKFILE wuppertxt2 NO-UNDO
/*1*/  FIELD line AS INTEGER   FORMAT ">>9"
/*2*/  FIELD txt  AS CHARACTER FORMAT "X(78)" INITIAL "".
DEFINE  WORKFILE wuppertxt3 NO-UNDO
/*1*/  FIELD line AS INTEGER   FORMAT ">>9"
/*2*/  FIELD txt  AS CHARACTER FORMAT "X(78)" INITIAL "". 
DEFINE  WORKFILE wcomp NO-UNDO
/*1*/  FIELD package  AS CHARACTER FORMAT "X(10)" INITIAL ""
/*2*/  FIELD premcomp AS DECI FORMAT "->>,>>9.99" INITIAL 0
       FIELD seat     AS CHARACTER FORMAT "X(2)" /*Jiraphon A59-0342*/
       FIELD body     AS CHAR FORMAT "X(10)" INIT "" .  /*A64-0060*/

DEF BUFFER buwm100   FOR sic_bran.uwm100. 
DEF  STREAM ns1.
/*Add Jiraphon A59-0451*/
DEF VAR n_addr AS CHAR FORMAT "X(150)".
DEF VAR n_no AS CHAR FORMAT "X(150)".
DEF VAR n_soi AS CHAR FORMAT "X(70)".
DEF VAR n_road AS CHAR FORMAT "X(70)".
DEF VAR n_tum AS CHAR FORMAT "X(70)".
DEF VAR n_amp AS CHAR FORMAT "X(70)".
/*End Jiraphon A59-0451*/
DEF VAR n_typbody AS CHAR FORMAT "x(15)" . /*A64-0060*/

