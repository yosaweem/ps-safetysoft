/*programid  : wgwgen60.i                                                            */ 
/*programname: Load Text file PA60 PMIB                             */ 
/*Copyright  : Safety Insurance Public Company Limited 			                       */ 
/*			   บริษัท ประกันคุ้มภัย จำกัด (มหาชน)				                       */ 
/*create by  : Ranu I. A61-0024 Date : 20/01/2018              
               ปโปรแกรมนำเข้า text file PA60 PMIB */ 
/***************************************************************************************/
DEFINE NEW SHARED TEMP-TABLE wdetail
    FIELD number      AS CHAR FORMAT "x(5)"   INIT ""   
    FIELD policy      AS CHAR FORMAT "x(20)"  INIT ""   
    FIELD covcod      AS CHAR FORMAT "x"      INIT ""   
    FIELD producer    AS CHAR FORMAT "x(10)"  INIT ""   
    FIELD agent       AS CHAR FORMAT "x(10)"  INIT ""   
    FIELD inserf      AS CHAR FORMAT "x(10)"  INIT ""   
    FIELD vatcode     AS CHAR FORMAT "x(10)"  INIT ""   
    FIELD age         AS CHAR FORMAT "x(100)" INIT ""  
    FIELD bdate       AS CHAR FORMAT "x(100)" INIT ""  
    FIELD class       AS CHAR FORMAT "x(5)"   INIT ""   
    FIELD si          AS CHAR FORMAT "x(20)"  INIT ""   
    FIELD comdat      AS CHAR FORMAT "x(10)"  INIT ""  
    FIELD expdat      AS CHAR FORMAT "x(10)"   INIT "" 
    FIELD n_rencnt    LIKE sicuw.uwm100.rencnt INITIAL ""
    FIELD n_endcnt    LIKE sicuw.uwm100.endcnt INITIAL ""
    FIELD branch      AS CHAR FORMAT "x(2)"    INIT "" 
    FIELD poltyp      AS CHAR FORMAT "x(3)"    INIT "" 
    FIELD tiname      AS CHAR FORMAT "x(20)"   INIT "" 
    FIELD insnam      AS CHAR FORMAT "x(100)"  INIT ""
    FIELD name2       AS CHAR FORMAT "x(100)"  INIT ""
    FIELD phone       AS CHAR FORMAT "x(60)"   INIT ""    
    FIELD mobile      AS CHAR FORMAT "x(60)"   INIT ""    
    FIELD occup       AS CHAR FORMAT "x(100)"  INIT ""
    FIELD n_addr1     AS CHAR FORMAT "x(150)"  INIT ""     
    FIELD n_addr2     AS CHAR FORMAT "x(150)"  INIT ""     
    FIELD n_addr3     AS CHAR FORMAT "x(150)"  INIT ""     
    FIELD n_addr4     AS CHAR FORMAT "x(150)"  INIT ""     
    FIELD firstdat    AS CHAR FORMAT "x(10)"   INIT "" 
    FIELD trandat     AS CHAR FORMAT "x(10)"   INIT ""
    FIELD tariff      AS CHAR FORMAT "x"       INIT "9"
    FIELD vehuse      AS CHAR INIT "" FORMAT "x"
    FIELD benname     AS CHAR FORMAT "x(65)"   INIT "" 
    FIELD comment     AS CHAR FORMAT "x(512)"  INIT ""
    FIELD pass        AS CHAR FORMAT "x"       INIT "n" 
    FIELD WARNING     AS CHAR FORMAT "X(30)"   INIT ""
    FIELD OK_GEN      AS CHAR FORMAT "X"       INIT "Y" 
    FIELD premt       AS CHAR FORMAT "x(15)"   INIT ""  
    FIELD cndat       AS CHAR FORMAT "x(10)"   INIT "" 
    FIELD polmaster   AS CHAR FORMAT "x(16)"   INIT ""
    FIELD enttim      AS CHAR FORMAT "x(8)"   INIT ""       
    FIELD trantim     AS CHAR FORMAT "x(8)"   INIT ""       
    FIELD n_IMPORT    AS CHAR FORMAT "x(2)"   INIT ""       
    FIELD n_EXPORT    AS CHAR FORMAT "x(2)"   INIT "" 
    FIELD cr_1        AS CHAR FORMAT "x(15)"   INIT ""  
    FIELD docno       AS CHAR INIT "" FORMAT "x(10)" 
    FIELD drivnam     AS CHAR FORMAT "x"       INIT "n" 
    FIELD cancel      AS CHAR FORMAT "x(2)"    INIT ""    
    FIELD accdat      AS CHAR INIT "" FORMAT "x(10)"
    FIELD notidate    AS CHAR FORMAT "x(15)" INIT "" 
    FIELD nv_icno     AS CHAR FORMAT "x(13)"
    FIELD promo       AS CHAR FORMAT "x(20)" INIT ""
    FIELD mail        AS CHAR FORMAT "x(50)" INIT "".

DEF    NEW SHARED VAR  nv_message AS char.
DEF               VAR  nv_riskgp  LIKE sic_bran.uwm120.riskgp NO-UNDO.
DEFINE NEW SHARED VAR  NO_basemsg AS CHAR  FORMAT "x(50)" .      
DEFINE            VAR  nv_accdat  AS DATE  FORMAT "99/99/9999" INIT ?  .     
DEFINE            VAR  nv_docno   AS CHAR  FORMAT "9999999"    INIT " ".
DEFINE NEW SHARED VAR  nv_batchyr   AS INT FORMAT "9999"            INIT 0.
DEFINE NEW SHARED VAR  nv_batcnt    AS INT FORMAT "99"              INIT 0.
DEFINE NEW SHARED VAR  nv_batchno   AS CHARACTER FORMAT "X(13)"     INIT ""  NO-UNDO.
DEFINE VAR  nv_batrunno  AS INT  FORMAT ">,>>9"          INIT 0.
DEFINE VAR  nv_imppol    AS INT  FORMAT ">>,>>9"         INIT 0.
DEFINE VAR  nv_impprem   AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.
DEFINE VAR  nv_batprev   AS CHARACTER FORMAT "X(20)"     INIT ""  NO-UNDO.
DEFINE VAR  nv_tmppolrun AS INTEGER FORMAT "999"         INIT 0. 
DEFINE VAR  nv_batbrn    AS CHARACTER FORMAT "x(2)"      INIT ""  NO-UNDO. 
DEFINE VAR  nv_tmppol    AS CHARACTER FORMAT "x(16)"     INIT "". 
DEFINE VAR  nv_rectot    AS INT  FORMAT ">>,>>9"         INIT 0.  
DEFINE VAR  nv_recsuc    AS INT  FORMAT ">>,>>9"         INIT 0.  
DEFINE VAR  nv_netprm_t  AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.  
DEFINE VAR  nv_netprm_s  AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.  
DEFINE VAR  nv_batflg    AS LOG                          INIT NO.
DEFINE VAR  nv_txtmsg    AS CHAR FORMAT "x(50)"          INIT "". 
DEF VAR n_idno       AS CHAR  INIT "" FORMAT "x(10)".
DEF VAR n_datesend  AS CHAR  INIT "" FORMAT "x(50)".
DEF VAR n_refno     AS CHAR  INIT "" FORMAT "x(20)".
DEF VAR n_title     AS CHAR  INIT "" FORMAT "x(30)".
DEF VAR n_name      AS CHAR  INIT "" FORMAT "x(80)".
DEF VAR n_lname     AS CHAR  INIT "" FORMAT "x(80)".
DEF VAR n_icno      AS CHAR  INIT "" FORMAT "x(13)".
DEF VAR n_bdate     AS CHAR  INIT "" FORMAT "x(15)".
DEF VAR n_age       AS CHAR  INIT "" FORMAT "x(5)".
DEF VAR n_plan      AS CHAR  INIT "" FORMAT "x(15)".
DEF VAR n_siins     AS CHAR  INIT "" FORMAT "x(15)".
DEF VAR n_prem      AS CHAR  INIT "" FORMAT "x(15)".
DEF VAR n_addr1     AS CHAR  INIT "" FORMAT "x(100)".
DEF VAR n_addr2     AS CHAR  INIT "" FORMAT "x(100)".
DEF VAR n_addr3     AS CHAR  INIT "" FORMAT "x(100)".
DEF VAR n_addr4     AS CHAR  INIT "" FORMAT "x(100)".
DEF VAR n_mobile    AS CHAR  INIT "" FORMAT "x(15)".
DEF VAR n_phone     AS CHAR  INIT "" FORMAT "x(15)".
DEF VAR n_effdat    AS char  init "" FORMAT "X(15)".
DEF VAR n_expdat    AS char  init "" FORMAT "X(15)".
DEF    VAR  nv_occup         AS CHAR FORMAT "x(100)" INIT "". 
DEFINE NEW SHARED WORKFILE wxpara49
    FIELD para1  AS CHAR FORMAT "x(20)" INIT ""
    FIELD para3  AS CHAR FORMAT "x(30)" INIT ""
    FIELD para7  AS CHAR FORMAT "x(50)" INIT ""
    FIELD para9  AS CHAR FORMAT "x(40)" INIT "" 
    FIELD para10 AS CHAR FORMAT "x(15)" INIT ""
    FIELD para11 AS CHAR FORMAT "x(15)" INIT ""
    FIELD para12 AS CHAR FORMAT "x(20)" INIT ""
    FIELD prem_c AS DECI FORMAT ">>>,>>>,>>9.99-" .

DEFINE NEW SHARED WORKFILE wplan
    FIELD para3  AS CHAR FORMAT "x(20)" INIT ""
    FIELD para12 AS CHAR FORMAT "x(20)" INIT "".
   
