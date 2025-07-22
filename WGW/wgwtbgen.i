/*programid   : wgwtbgen.i                                            */
/*programname : load text file Toyota to GW                              */
/* Copyright  : Safety Insurance Public Company Limited 			  */
/*			      ºÃÔÉÑ· »ÃĞ¡Ñ¹¤ØéÁÀÑÂ ¨Ó¡Ñ´ (ÁËÒª¹)				  */
/*create by   : Kridtiya i. A53-0182   date . 29/06/2010             
                »ÃÑºâ»Ãá¡ÃÁãËéÊÒÁÒÃ¶¹Óà¢éÒ text file tib[toyota] to GW system */ 
/*copy write  : wgwargen.i                                            */
/*modify by Kridtiya i. A53-0351 date. 11/11/2010  »ÃÑº¡ÒÃáÊ´§¤èÒà¹×èÍ§¨Ò¡à¾ÔèÁ format file new
                        à¾ÔèÁ á¶ÇÊØ´·éÒÂ "ÍØ»¡Ã³ìàÊÃÔÁ"                                       */
/*modify by   : Kridtiya i. A54-0062 »ÃĞ¡ÒÈà¾ÔèÁµÑÇá»Ã   */
/*modify by   : Kridtiya i. A54-0197 »ÃĞ¡ÒÈà¾ÔèÁµÑÇá»Ã   */
/*modify by   : Kridtiya i. A54-0112 ¢ÂÒÂªèÍ§·ĞàºÕÂ¹Ã¶ ¨Ò¡ 10 à»ç¹ 11 ËÅÑ¡          */
/*Modify by   : Kridtiya i. A63-0472 Date. 09/11/2020 add field firstname ,lastname.....*/
/*Modify by   : Ranu I. A64-0138 à¾ÔèÁµÑÇá»Ãà¡çº¤èÒ¡ÒÃ¤Ó¹Ç³àºÕéÂ */
/*Modify by   : Kridtiyai .A67-0184 Date.24/10/2024 à¾ÔèÁ ¿ÔÅì´ */
/**********************************************************************/
DEFINE NEW SHARED TEMP-TABLE wdetail2
    FIELD head          AS CHAR FORMAT "x(1)"   INIT ""      
    FIELD comcode       AS CHAR FORMAT "x(4)"   INIT ""      
    FIELD senddat       AS CHAR FORMAT "x(8)"   INIT ""      
    FIELD contractno    AS CHAR FORMAT "x(10)"  INIT ""     
    FIELD lotno         AS CHAR FORMAT "x(9)"   INIT ""      
    FIELD seqno         AS CHAR FORMAT "x(6)"   INIT ""      
    FIELD recact        AS CHAR FORMAT "x(1)"   INIT ""     
    FIELD STATUSno      AS CHAR FORMAT "x(1)"   INIT ""     
    FIELD flag          AS CHAR FORMAT "x(1)"   INIT ""  
    FIELD tiname        AS CHAR FORMAT "x(20)"  INIT ""  
    FIELD insname       AS CHAR FORMAT "x(100)" INIT ""   
    FIELD moo           AS CHAR FORMAT "x(50)"  INIT ""   /* A55-0197 */
    FIELD soy           AS CHAR FORMAT "x(50)"  INIT ""   /* A55-0197 */ 
    FIELD road          AS CHAR FORMAT "x(50)"  INIT ""   /* A55-0197 */
    FIELD add1          AS CHAR FORMAT "x(100)" INIT ""     
    FIELD add2          AS CHAR FORMAT "x(50)"  INIT ""    
    FIELD add3          AS CHAR FORMAT "x(50)"  INIT ""    
    FIELD add4          AS CHAR FORMAT "x(50)"  INIT ""     
    FIELD add5          AS CHAR FORMAT "x(5)"   INIT ""      
    FIELD engno         AS CHAR FORMAT "x(100)"  INIT ""     
    FIELD chasno        AS CHAR FORMAT "x(100)"  INIT ""     
    FIELD brand         AS CHAR FORMAT "x(3)"   INIT ""      
    FIELD model         AS CHAR FORMAT "x(40)"  INIT ""     
    FIELD cc            AS CHAR FORMAT "x(5)"   INIT ""      
    FIELD COLORno       AS CHAR FORMAT "x(4)"   INIT ""   
    FIELD reg1          AS CHAR FORMAT "x(5)"   INIT ""     
    FIELD reg2          AS CHAR FORMAT "x(5)"   INIT ""     
    FIELD provinco      AS CHAR FORMAT "x(2)"   INIT ""       
    FIELD subinsco      AS CHAR FORMAT "x(50)"  INIT ""       
    FIELD covamount     AS CHAR FORMAT "x(20)"  INIT ""       
    FIELD grpssprem     AS CHAR FORMAT "x(20)"  INIT ""       
    FIELD effecdat      AS CHAR FORMAT "x(10)"  INIT ""       
    FIELD notifyno      AS CHAR FORMAT "x(100)" INIT ""       
    FIELD noticode      AS CHAR FORMAT "x(50)"  INIT ""       
    FIELD noticodesty   AS CHAR FORMAT "x(25)"  INIT ""       
    FIELD notiname      AS CHAR FORMAT "x(50)"  INIT ""       
    FIELD substyname    AS CHAR FORMAT "x(50)"  INIT ""       
    FIELD comamount     AS CHAR FORMAT "x(20)"  INIT ""      
    FIELD comprem       AS CHAR FORMAT "x(20)"  INIT ""       
    FIELD comeffecdat   AS CHAR FORMAT "x(10)"  INIT ""       
    FIELD compno        AS CHAR FORMAT "x(25)"  INIT ""      
    FIELD recivno       AS CHAR FORMAT "x(100)" INIT ""      
    FIELD recivcode     AS CHAR FORMAT "x(4)"   INIT ""       
    FIELD recivcosty    AS CHAR FORMAT "x(25)"  INIT ""      
    FIELD recivstynam   AS CHAR FORMAT "x(50)"  INIT ""      
    FIELD comppol       AS CHAR FORMAT "x(25)"  INIT ""      
    FIELD recivstydat   AS CHAR FORMAT "x(8)"   INIT ""      
    FIELD drivnam1      AS CHAR FORMAT "x(30)"  INIT ""      
    FIELD drivnam2      AS CHAR FORMAT "x(30)"  INIT ""    
    FIELD drino1        AS CHAR FORMAT "x(13)"  INIT ""     
    FIELD drino2        AS CHAR FORMAT "x(13)"  INIT ""     
    FIELD oldeng        AS CHAR FORMAT "x(20)"  INIT ""      
    FIELD oldchass      AS CHAR FORMAT "x(20)"  INIT ""      
    FIELD NAMEpay       AS CHAR FORMAT "x(100)" INIT ""      
    FIELD addpay1       AS CHAR FORMAT "X(50)"  INIT ""     
    FIELD addpay2       AS CHAR FORMAT "X(50)"   INIT ""      
    FIELD addpay3       AS CHAR FORMAT "X(50)"   INIT ""      
    FIELD addpay4       AS CHAR FORMAT "x(50)"   INIT ""      
    FIELD postpay       AS CHAR FORMAT "x(5)"    INIT ""       
    FIELD Reserved1     AS CHAR FORMAT "X(13)"   INIT ""      
    FIELD Reserved2     AS CHAR FORMAT "x(13)"   INIT ""      
    FIELD norcovdat     AS CHAR FORMAT "x(10)"   INIT ""       
    FIELD norcovenddat  AS CHAR FORMAT "x(10)"   INIT ""       
    FIELD delercode     AS CHAR FORMAT "X(40)"   INIT ""       
    FIELD caryear       AS CHAR FORMAT "x(4)"    INIT ""       
    FIELD renewtyp      AS CHAR FORMAT "x(1)"    INIT ""       
    FIELD Reserved5     AS CHAR FORMAT "x(59)"   INIT ""      
    FIELD Reserved6     AS CHAR FORMAT "x(21)"   INIT ""  
    FIELD access        AS CHAR FORMAT "x(100)"  INIT ""    /*kridtiya i. A53-0351*/
    FIELD branch	    AS CHAR FORMAT "x(2)"    INIT ""    /*kridtiya i. A54-0062*/
    FIELD producer      AS CHAR FORMAT "x(10)"   INIT ""    /*kridtiya i. A54-0062*/
    FIELD agent	        AS CHAR FORMAT "x(10)"   INIT ""    /*kridtiya i. A54-0062*/
    FIELD prvpol	    AS CHAR FORMAT "x(15)"   INIT ""    /*kridtiya i. A54-0062*/
    FIELD covcod	    AS CHAR FORMAT "x(1)"    INIT ""    /*kridtiya i. A54-0062*/
    FIELD class         AS CHAR FORMAT "x(5)"    INIT ""    /*kridtiya i. A54-0062*/ 
    FIELD campaign_ov   AS CHAR FORMAT "x(30)"   INIT ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
    FIELD occup            AS CHAR FORMAT "x(130)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
    FIELD GarageType       AS CHAR FORMAT "x(30)"   INIT ""    /*A67-0184*/   
    FIELD DriverFlag       AS CHAR FORMAT "x(10)"   INIT ""    /*A67-0184*/   
    FIELD Driver1name      AS CHAR FORMAT "x(130)"  INIT ""   /*A67-0184*/   
    FIELD Driver1DOB       AS CHAR FORMAT "x(30)"   INIT ""    /*A67-0184*/   
    FIELD Driver1License   AS CHAR FORMAT "x(30)"   INIT ""    /*A67-0184*/   
    FIELD Driver2name      AS CHAR FORMAT "x(130)"  INIT ""   /*A67-0184*/   
    FIELD Driver2DOB       AS CHAR FORMAT "x(30)"   INIT ""    /*A67-0184*/   
    FIELD Driver2License   AS CHAR FORMAT "x(30)"   INIT ""    /*A67-0184*/   
    FIELD DealerCode       AS CHAR FORMAT "x(30)"   INIT ""    
    FIELD CarUsageCode     AS CHAR FORMAT "x(30)"   INIT ""    /*A67-0184*/   
         .


DEFINE NEW SHARED TEMP-TABLE wdetail
    FIELD policy      AS CHAR FORMAT "x(20)" INIT ""
    FIELD cndat       AS CHAR FORMAT "x(10)" INIT ""     
    FIELD appenno     AS CHAR FORMAT "x(32)" INIT ""  
    FIELD comdat      AS CHAR FORMAT "x(10)" INIT ""     
    FIELD expdat      AS CHAR FORMAT "x(10)" INIT ""    
    FIELD active      AS CHAR FORMAT "x"     INIT ""        
    FIELD nSTATUS     AS CHAR FORMAT "x"     INIT ""        
    FIELD flag        AS CHAR FORMAT "x"     INIT ""         
    FIELD covcod      AS CHAR FORMAT "x(1)"  INIT ""     
    FIELD seqno       AS CHAR FORMAT "x(6)"  INIT ""     
    FIELD garage      AS CHAR FORMAT "x(6)"  INIT ""     
    FIELD lotno       AS CHAR FORMAT "x(9)"  INIT ""      
    FIELD tiname      AS CHAR FORMAT "x(20)" INIT ""     
    FIELD insnam      AS CHAR FORMAT "x(80)" INIT "" 
    FIELD name2       AS CHAR FORMAT "x(20)" INIT "" 
    FIELD add1        AS CHAR FORMAT "x(50)" INIT ""     
    FIELD add2        AS CHAR FORMAT "x(50)" INIT ""     
    FIELD add3        AS CHAR FORMAT "x(50)" INIT ""     
    FIELD add4        AS CHAR FORMAT "x(50)" INIT ""    
    FIELD comprem     AS CHAR FORMAT "x(20)" INIT ""  /*kridtiya i. A55-0197 */
    FIELD stk         AS CHAR FORMAT "x(20)" INIT ""     
    FIELD brand       AS CHAR FORMAT "x(10)" INIT ""    
    FIELD cargrp      AS CHAR FORMAT "x"     INIT ""    
    FIELD chasno      AS CHAR FORMAT "x(25)" INIT ""    
    FIELD eng         AS CHAR FORMAT "x(20)" INIT ""    
    FIELD model       AS CHAR FORMAT "x(40)" INIT ""    
    FIELD caryear     AS CHAR FORMAT "x(4)"  INIT ""   
    FIELD vehuse      AS CHAR FORMAT "x(2)"  INIT ""     
    FIELD seat        AS CHAR FORMAT "x(2)"  INIT ""     
    FIELD engcc       AS CHAR FORMAT "x(4)"  INIT ""     
    /*FIELD vehreg      AS CHAR FORMAT "x(10)" INIT ""    *//*A54-0112*/
    FIELD vehreg      AS CHAR FORMAT "x(11)" INIT ""        /*A54-0112*/
    FIELD re_country  AS CHAR FORMAT "x(30)" INIT ""  
    FIELD ncd         AS CHAR FORMAT "x(4)"  INIT ""     
    FIELD si          AS CHAR FORMAT "x(14)" INIT ""    
    FIELD premt       AS CHAR FORMAT "x(14)" INIT ""    
    FIELD rstp_t      AS CHAR FORMAT "x(14)" INIT ""    
    FIELD rtax_t      AS CHAR FORMAT "x(14)" INIT ""    
    FIELD prem_r      AS CHAR FORMAT "x(14)" INIT ""     
    FIELD gap         AS CHAR FORMAT "X(14)" INIT ""     
    FIELD ncb         AS CHAR FORMAT "X(14)" INIT ""     
    FIELD benname     AS CHAR FORMAT "x(80)" INIT ""  
    FIELD ccd         AS CHAR FORMAT "X(4)"  INIT ""    
    /*FIELD ddriveno    AS CHAR FORMAT "x(15)" INIT ""     
    FIELD ntitle2     AS CHAR FORMAT "x(20)" INIT ""     
    FIELD drivername2 AS CHAR FORMAT "x(80)" INIT ""     
    FIELD ddname1     AS CHAR FORMAT "x(20)" INIT ""     
    FIELD ddname2     AS CHAR FORMAT "x(60)" INIT ""  
    FIELD drivername1 AS CHAR FORMAT "x(80)" INIT ""     
    FIELD dname1      AS CHAR FORMAT "X(20)" INIT ""     
    FIELD dname2      AS CHAR FORMAT "x(60)" INIT ""  
    FIELD dddriveno   AS CHAR FORMAT "x(15)" INIT "" */ 
    /*FIELD comper      AS CHAR FORMAT "x(14)" INIT ""    
    FIELD comacc      AS CHAR FORMAT "x(14)" INIT ""  */
    FIELD deductpd    AS DECI FORMAT "->>>,>>>,>>9.99"  INIT 0 
    FIELD deductpd2   AS DECI FORMAT "->>>,>>>,>>9.99"  INIT 0  
    FIELD nSTATUS2    AS CHAR FORMAT "X(5)" INIT ""     
    FIELD deductda    AS CHAR FORMAT "X(14)" INIT ""    
    /*FIELD deduct      AS CHAR FORMAT "X(14)" INIT ""      
    FIELD tpfire      AS CHAR FORMAT "x(14)" INIT "" */   
    FIELD compul      AS CHAR FORMAT "x"     INIT "" 
    FIELD pass        AS CHAR FORMAT "x"     INIT "n"
    FIELD body        AS CHAR FORMAT "x(40)" INIT ""  
    FIELD prepol      AS CHAR FORMAT "x(32)" INIT "" 
    FIELD firstdat    AS DATE FORMAT "99/99/9999" 
   /* FIELD NO_41       AS CHAR FORMAT "x(14)" INIT ""  
    FIELD NO_42       AS CHAR FORMAT "x(14)" INIT ""  
    FIELD NO_43       AS CHAR FORMAT "x(14)" INIT ""  */
    FIELD ntitle1        AS CHAR FORMAT "x(20)" INIT ""  
    FIELD icno           AS CHAR FORMAT "x(15)" INIT ""    
    FIELD vatcode        AS CHAR FORMAT "x(10)" INIT ""      
    FIELD deler          AS CHAR FORMAT "x(10)" INIT ""  
    FIELD br_sta         AS CHAR FORMAT "x(10)"  INIT ""    
    FIELD access         AS CHAR FORMAT "x(100)" INIT ""     
    FIELD comment        AS CHAR FORMAT "x(512)"  INIT ""   
    FIELD agent          AS CHAR FORMAT "x(10)" INIT ""      
    FIELD producer       AS CHAR FORMAT "x(10)" INIT ""     
    FIELD entdat         AS CHAR FORMAT "x(10)" INIT ""     
    FIELD enttim         AS CHAR FORMAT "x(8)" INIT ""      
    FIELD trandat        AS CHAR FORMAT "x(10)" INIT ""     
    FIELD trantim        AS CHAR FORMAT "x(8)" INIT ""      
    FIELD n_IMPORT       AS CHAR FORMAT "x(2)" INIT ""      
    FIELD n_EXPORT       AS CHAR FORMAT "x(2)" INIT ""      
    FIELD poltyp         AS CHAR FORMAT "x(3)" INIT ""        
    FIELD OK_GEN         AS CHAR FORMAT "X" INIT "Y"       
    FIELD renpol         AS CHAR FORMAT "x(32)" INIT ""   
    FIELD cr_2           AS CHAR FORMAT "x(32)" INIT ""    
    FIELD docno          AS CHAR INIT "" FORMAT "x(10)"    
    FIELD redbook        AS CHAR INIT "" FORMAT "X(8)"      
    FIELD drivnam        AS CHAR FORMAT "x" INIT "n"       
    FIELD tariff         AS CHAR FORMAT "x(2)" INIT "9"      
    FIELD weight         AS CHAR FORMAT "x(5)" INIT ""      
    FIELD cancel         AS CHAR FORMAT "x(2)" INIT ""     
    FIELD accdat         AS CHAR INIT "" FORMAT "x(10)"    
    FIELD prempa         AS CHAR FORMAT "x" INIT ""        
    FIELD subclass       AS CHAR FORMAT "x(4)" INIT ""      
    FIELD fleet          AS CHAR FORMAT "x(10)" INIT ""    
    FIELD WARNING        AS CHAR FORMAT "X(30)" INIT ""     
    FIELD seat41         AS INTE FORMAT "99" INIT 0  
    FIELD n_branch       AS CHAR FORMAT "x(5)" INIT ""  
    FIELD insnamtyp      AS CHAR FORMAT "x(60)"  INIT ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD financecd      AS CHAR FORMAT "x(60)"  INIT ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD occup          AS CHAR FORMAT "x(130)" INIT ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
    FIELD firstName      AS CHAR FORMAT "x(60)" INIT ""     /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD lastName       AS CHAR FORMAT "x(60)" INIT ""     /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD postcd         AS CHAR FORMAT "x(15)" INIT ""     /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeocc        AS CHAR FORMAT "x(4)"  INIT ""     /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr1      AS CHAR FORMAT "x(2)"  INIT ""     /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr2      AS CHAR FORMAT "x(2)"  INIT ""     /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr3      AS CHAR FORMAT "x(2)"  INIT ""     /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD br_insured     AS CHAR FORMAT "x(5)"  INIT ""     /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD campaign_ov    AS CHAR FORMAT "x(30)" INIT ""     /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
    FIELD Driver1name      AS CHAR FORMAT "x(130)"  INIT ""   /*A67-0184*/   
    FIELD Driver1DOB       AS CHAR FORMAT "x(30)"   INIT ""    /*A67-0184*/   
    FIELD Driver1License   AS CHAR FORMAT "x(30)"   INIT ""    /*A67-0184*/   
    FIELD Driver2name      AS CHAR FORMAT "x(130)"  INIT ""   /*A67-0184*/   
    FIELD Driver2DOB       AS CHAR FORMAT "x(30)"   INIT ""    /*A67-0184*/   
    FIELD Driver2License   AS CHAR FORMAT "x(30)"   INIT ""    /*A67-0184*/   
    FIELD DealerCode       AS CHAR FORMAT "x(30)"   INIT ""    .


DEF NEW SHARED VAR nv_message AS char.
DEF            VAR c          AS CHAR.
DEF            VAR nv_riskgp  LIKE sic_bran.uwm120.riskgp NO-UNDO.
DEFINE NEW SHARED VAR no_baseprm AS DECI  FORMAT ">>,>>>,>>9.99-".  
DEFINE NEW SHARED VAR NO_basemsg AS CHAR  FORMAT "x(50)" .          
DEFINE            VAR nv_accdat  AS DATE  FORMAT "99/99/9999" INIT ?  .     
DEFINE            VAR nv_docno   AS CHAR  FORMAT "9999999"    INIT " ".
DEFINE NEW SHARED VAR  nv_batchyr   AS INT FORMAT "9999"            INIT 0.
DEFINE NEW SHARED VAR  nv_batcnt    AS INT FORMAT "99"              INIT 0.
DEFINE NEW SHARED VAR  nv_batchno   AS CHARACTER FORMAT "X(13)"     INIT ""  NO-UNDO.
DEFINE VAR  nv_batrunno  AS INT FORMAT  ">,>>9"          INIT 0.
DEFINE VAR  nv_imppol    AS INT  FORMAT ">>,>>9"         INIT 0.
DEFINE VAR  nv_impprem   AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.
DEFINE VAR  nv_batprev   AS CHARACTER FORMAT "X(13)"     INIT ""  NO-UNDO.
DEFINE VAR  nv_tmppolrun AS INTEGER FORMAT "999"         INIT 0. 
DEFINE VAR  nv_batbrn    AS CHARACTER FORMAT "x(2)"      INIT ""  NO-UNDO. 
DEFINE VAR  nv_tmppol    AS CHARACTER FORMAT "x(16)"     INIT "". 
DEFINE VAR  nv_rectot    AS INT  FORMAT ">>,>>9"         INIT 0.  
DEFINE VAR  nv_recsuc    AS INT  FORMAT ">>,>>9"         INIT 0.  
DEFINE VAR  nv_netprm_t  AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.  
DEFINE VAR  nv_netprm_s  AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.  
DEFINE VAR  nv_batflg    AS LOG                          INIT NO.
DEFINE VAR  nv_txtmsg    AS CHAR FORMAT "x(50)"   INIT "". 
DEFINE VAR  nv_chkerror  AS CHAR FORMAT "x(150)"  INIT "". /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
DEFINE VAR  nv_insref    AS CHAR FORMAT "x(20)"   INIT "". /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/    
DEFINE VAR  n_insref     AS CHAR FORMAT "x(20)"   INIT "". /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
DEFINE VAR  nv_messagein AS CHAR FORMAT "x(200)"  INIT "". /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
DEFINE VAR  nv_usrid     AS CHAR FORMAT "x(20)"   INIT "". /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
DEFINE VAR  nv_transfer  AS LOGICAL .             
DEFINE VAR  n_check      AS CHAR FORMAT "x(200)"  INIT "". /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 

DEFINE VAR  putchr      AS CHAR FORMAT "x(200)"  INIT "". /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 

DEFINE VAR  putchr1     AS CHAR FORMAT "x(200)"  INIT "". /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
DEFINE VAR  nv_typ      AS CHAR FORMAT "x(200)"  INIT "". /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 


/* add by : A64-0138 */
DEFINE NEW SHARED TEMP-TABLE wkuwd132 LIKE stat.pmuwd132.
DEF    VAR nv_cstflg  AS CHAR FORMAT "X(2)".     /*C=CC ; S=Seat ; T=Tons ; W=Watts*/  
DEFINE VAR nv_engcst  AS DECI FORMAT ">>>>>9.99".

DEFINE VAR nv_driage1 AS INTE FORMAT ">>9".
DEFINE VAR nv_driage2 AS INTE FORMAT ">>9".
DEF    VAR nv_pdprm0  AS DECI FORMAT ">>>,>>>,>>9.99-". /*àºÕéÂ¼Ùé¢Ñº¢Õè*/
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
DEF VAR dod0  AS INTEGER.
DEF VAR dod1  AS INTEGER.
DEF VAR dod2  AS INTEGER.
DEF VAR dpd0  AS INTEGER.
DEF VAR n_net AS DECI FORMAT ">>,>>>,>>9-".
DEFINE VAR nv_41prmt   AS DECI FORMAT ">>>,>>>,>>9.99-".  /* fleet */
DEFINE VAR nv_42prmt   AS DECI FORMAT ">>>,>>>,>>9.99-".  /* fleet */
DEFINE VAR nv_43prmt   AS DECI FORMAT ">>>,>>>,>>9.99-".  /* fleet */
DEFINE VAR nv_pdprem   AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_status   AS CHAR .   /*fleet YES=Complete , NO=Not Complete */
DEFINE   VAR   nv_baseprm3 AS DECI FORMAT ">>,>>>,>>9.99-".
/* end A64-0138 */   

