/*programid   : wgwnsgen.i                                               */ 
/*programname : Load text file LOCKTON [NISSAN] to GW                            */ 
/*Copyright   : Safety Insurance Public Company Limited 			     */ 
/*			    ºÃÔÉÑ· »ÃĞ¡Ñ¹¤ØéÁÀÑÂ ¨Ó¡Ñ´ (ÁËÒª¹)				         */ 
/*create by   : Ranu i. A60-0139 date . 05/04/2017                 
                »ÃÑºâ»Ãá¡ÃÁãËéÊÒÁÒÃ¶¹Óà¢éÒ text file Lockton[Renew] to GW system*/ 
/*copy write  : wgwnsren.i                                               */ 
/*Modify by   : Kridtiya i. A63-0472 Date. 09/11/2020 add field firstname ,lastname.....*/
/*Modify by  : Ranu I. A64-0138 à¾ÔèÁµÑÇá»Ãà¡çº¤èÒ¡ÒÃ¤Ó¹Ç³àºÕéÂ  */
/*************************************************************************/ 
DEFINE NEW SHARED TEMP-TABLE wdetail
 FIELD policy          AS CHAR FORMAT "x(25)"  INIT ""   /* notify number*/  
 FIELD poltyp          AS CHAR FORMAT "x(3)"   INIT ""   /* policy       */                
 FIELD cedpol          AS CHAR FORMAT "x(10)"  INIT ""   /* account no.        */     
 FIELD tiname          AS CHAR FORMAT "x(30)" INIT ""   /* title name         */     
 FIELD insnam          AS CHAR FORMAT "x(55)" INIT ""   /* first name         */     
 FIELD insnam2         AS CHAR FORMAT "x(40)" INIT ""   /* first name         */     
 FIELD insnam3         AS CHAR FORMAT "x(40)" INIT "" 
 FIELD addr1           AS CHAR FORMAT "x(100)" INIT ""  /* address1           */     
 FIELD tambon          AS CHAR FORMAT "x(35)" INIT ""    
 FIELD amper           AS CHAR FORMAT "x(35)" INIT ""    
 FIELD country         AS CHAR FORMAT "x(35)" INIT ""    
 FIELD caryear         AS CHAR FORMAT "x(4)"  INIT ""   /* year         */  
 FIELD eng             AS CHAR FORMAT "x(25)" INIT ""   /* engine       */  
 FIELD chasno          AS CHAR FORMAT "x(25)" INIT ""   /* chassis      */  
 FIELD engcc           AS CHAR FORMAT "x(5)"  INIT ""   /* weight       */  
 FIELD vehreg          AS CHAR FORMAT "x(11)" INIT ""   /* licence no   */      /*A54-0112*/
 FIELD garage          AS CHAR FORMAT "x(1)"  INIT ""   /* garage       */  
 FIELD vehuse          AS CHAR FORMAT "x(1)"  INIT ""   /* vehuse       */  
 FIELD comdat          AS CHAR FORMAT "x(15)" INIT ""   /* comdat       */  
 FIELD expdat          AS CHAR FORMAT "x(15)" INIT ""   /* expiry date        */ 
 FIELD comdat72        AS CHAR FORMAT "x(15)" INIT ""   /* comdat       */  
 FIELD expdat72        AS CHAR FORMAT "x(15)" INIT ""   /* expiry date        */   
 FIELD si              AS CHAR FORMAT "x(15)" INIT ""   /* sum si       */  
 FIELD fire            AS CHAR FORMAT "x(15)" INIT ""   
 FIELD premt           AS CHAR FORMAT "x(15)" INIT ""   /*  prem.1            */  
 FIELD stk             AS CHAR FORMAT "x(25)" INIT ""   /* sticker            */  
 FIELD brand           AS CHAR FORMAT "x(50)" INIT ""   /* brand              */     
 FIELD benname         AS CHAR FORMAT "x(65)" INIT ""   /* beneficiary        */ 
/* FIELD accesstxt       AS CHAR FORMAT "x(100)" INIT ""  
 FIELD receipt_name    AS CHAR FORMAT "x(50)" INIT ""   /* receipt name       */  */
 FIELD prepol          AS CHAR FORMAT "x(25)" INIT ""   /* old policy         */     
 FIELD ncb             AS CHAR FORMAT "X(10)"  INIT ""  /* deduct disc.       */     
 FIELD dspc            AS CHAR FORMAT "X(10)"  INIT ""  /* deduct disc.       */     
 FIELD tp1             AS CHAR FORMAT "X(14)" INIT ""   /* TPBI/Person       */     
 FIELD tp2             AS CHAR FORMAT "X(14)" INIT ""   /* TPBI/Per Acciden  */     
 FIELD tp3             AS CHAR FORMAT "X(14)" INIT ""   /* TPPD/Per Acciden  */     
 FIELD covcod          AS CHAR FORMAT "x(1)"  INIT ""   /* covcod            */     
 FIELD cndat           AS CHAR FORMAT "x(10)" INIT ""   
 FIELD compul          AS CHAR FORMAT "x"        INIT "" 
 FIELD model           AS CHAR FORMAT "x(50)"    INIT ""   
 FIELD seat            AS CHAR FORMAT "x(2)"     INIT ""    
 FIELD remark          AS CHAR FORMAT "x(100)"     INIT ""    
 FIELD comper          AS CHAR FORMAT "x(15)"    INIT ""    
 FIELD comacc          AS CHAR FORMAT "x(15)"    INIT ""    
 FIELD deductpd       AS CHAR FORMAT "X(14)"     INIT ""     
 FIELD deductpd2       AS CHAR FORMAT "X(14)"    INIT ""  
 FIELD cargrp         AS CHAR FORMAT "x"         INIT ""     
 FIELD body           AS CHAR FORMAT "x(40)"     INIT ""     
 FIELD NO_41          AS CHAR FORMAT "x(14)"     INIT ""  
 FIELD NO_42          AS CHAR FORMAT "x(14)"     INIT ""  
 FIELD NO_43          AS CHAR FORMAT "x(14)"     INIT ""  
 FIELD comment        AS CHAR FORMAT "x(512)"    INIT ""
 FIELD agent          AS CHAR FORMAT "x(10)"     INIT ""   
 FIELD producer       AS CHAR FORMAT "x(10)"     INIT ""  
 FIELD vatcode        AS CHAR FORMAT "x(10)"     INIT ""
 FIELD entdat         AS CHAR FORMAT "x(10)"     INIT ""      
 FIELD enttim         AS CHAR FORMAT "x(8)"      INIT ""       
 FIELD trandat        AS CHAR FORMAT "x(10)"     INIT "" 
 FIELD firstdat       AS CHAR FORMAT "x(10)"     INIT ""  
 FIELD trantim        AS CHAR FORMAT "x(8)"      INIT ""       
 FIELD n_IMPORT       AS CHAR FORMAT "x(2)"      INIT ""       
 FIELD n_EXPORT       AS CHAR FORMAT "x(2)"      INIT "" 
 FIELD pass           AS CHAR FORMAT "x"         INIT "n"
 FIELD OK_GEN         AS CHAR FORMAT "X"         INIT "Y" 
 FIELD renpol         AS CHAR FORMAT "x(32)"     INIT ""     
 FIELD cr_2           AS CHAR FORMAT "x(32)"     INIT ""  
 FIELD delerno        AS CHAR FORMAT "x(20)"     INIT ""  
 FIELD delername      AS CHAR FORMAT "x(60)"     INIT ""  
 FIELD docno          AS CHAR INIT "" FORMAT "x(10)" 
 FIELD redbook        AS CHAR INIT "" FORMAT "X(8)"
 FIELD drivnam        AS CHAR FORMAT "x"     INIT "n" 
 FIELD tariff         AS CHAR FORMAT "x(2)"  INIT "9"
 FIELD tons           AS DECI FORMAT "9999.99"  INIT ""
 FIELD cancel         AS CHAR FORMAT "x(2)"  INIT ""    
 FIELD accdat         AS CHAR INIT "" FORMAT "x(10)"   
 FIELD prempa         AS CHAR FORMAT "x"     INIT ""       
 FIELD subclass       AS CHAR FORMAT "x(5)"  INIT ""    
 FIELD fleet          AS CHAR FORMAT "x(10)" INIT ""   
 FIELD WARNING        AS CHAR FORMAT "X(30)" INIT ""
 FIELD seat41         AS INTE FORMAT "99"    INIT 0
 /*FIELD volprem        AS CHAR FORMAT "x(20)" INIT "" */
 FIELD icno           AS CHAR FORMAT "x(13)"  INIT ""
 FIELD n_branch       AS CHAR FORMAT "x(5)"  INIT "" 
 FIELD n_campaigns    AS CHAR FORMAT "x(40)"  INIT "" 
 field drive1         as char format "x(70)" init "" 
 FIELD bdate1         AS CHAR FORMAT "x(15)" INIT ""
 FIELD id1            AS CHAR FORMAT "x(13)" INIT ""
 field drive2         as char format "x(70)" init "" 
 FIELD bdate2         AS CHAR FORMAT "x(15)" INIT ""
 FIELD id2            AS CHAR FORMAT "x(13)" INIT ""
 field prmtotal       as char format "x(20)" init "" 
 /*field deduct         as char format "x(20)" init "" */
 field deduct2        as char format "x(20)" init "" 
 field contractno     as char format "x(20)" init "" 
 field userc          as char format "x(20)" init "" 
 field tempol         as char format "x(20)" init "" 
 field paiddat        as char format "x(20)" init "" 
 field typepaid       as char format "x(20)" init "" 
 field paidno         as char format "x(20)" init "" 
 field remarkpaid     as char format "x(20)" init "" 
 field paidtyp        as char format "x(20)" init "" 
 field remark2        as char format "x(20)" init ""
 field remark3        as char format "x(20)" init "" 
 FIELD compol         AS CHAR FORMAT "x(15)" INIT ""
 FIELD comprem        AS CHAR FORMAT "x(15)" INIT ""
 FIELD addr2          AS CHAR FORMAT "x(100)" INIT ""
 FIELD si2            AS CHAR FORMAT "x(20)" INIT ""
 FIELD firstName      AS CHAR FORMAT "x(60)" INIT ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
 FIELD lastName       AS CHAR FORMAT "x(60)" INIT ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
 FIELD postcd         AS CHAR FORMAT "x(15)" INIT ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
 FIELD codeocc        AS CHAR FORMAT "x(4)"  INIT ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
 FIELD codeaddr1      AS CHAR FORMAT "x(2)"  INIT ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
 FIELD codeaddr2      AS CHAR FORMAT "x(2)"  INIT ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
 FIELD codeaddr3      AS CHAR FORMAT "x(2)"  INIT ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
 FIELD br_insured     AS CHAR FORMAT "x(5)"  INIT ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
 FIELD campaign_ov    AS CHAR FORMAT "x(30)" INIT ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
 FIELD insnamtyp      AS CHAR FORMAT "x(60)" INIT "".    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
DEF VAR nv_chkerror    AS CHAR FORMAT "x(250)" INIT "".  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
DEF VAR np_campaign_ov AS CHAR FORMAT "x(60)" INIT "".   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
DEF VAR np_insnamtyp   AS CHAR FORMAT "x(60)" INIT "".   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
DEF VAR np_firstName   AS CHAR FORMAT "x(60)" INIT "".   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
DEF VAR np_lastName    AS CHAR FORMAT "x(60)" INIT "".   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
DEF VAR np_postcd      AS CHAR FORMAT "x(60)" INIT "".   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
DEF VAR np_codeocc     AS CHAR FORMAT "x(50)" INIT "".   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
DEF VAR np_codeaddr1   AS CHAR FORMAT "x(50)" INIT "".   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
DEF VAR np_codeaddr2   AS CHAR FORMAT "x(50)" INIT "".   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
DEF VAR np_codeaddr3   AS CHAR FORMAT "x(50)" INIT "".   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/

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
DEFINE VAR  nv_txtmsg    AS CHAR FORMAT "x(50)"          INIT "". 
DEF  var  nv_row  as  int  init  0.                       
DEFINE STREAM  ns1.                                        
DEFINE STREAM  ns2.                                         
DEFINE STREAM  ns3.                                        
DEF VAR nv_uom1_v AS INTE INIT 0.                     
DEF VAR nv_uom2_v AS INTE INIT 0.                     
DEF VAR nv_uom5_v AS INTE INIT 0.                     
DEF VAR chkred    AS logi INIT NO.                   
DEF VAR nv_comper  AS DECI INIT 0.                       
DEF VAR nv_comacc  AS DECI INIT 0.                       
DEF VAR nv_modcod  AS CHAR FORMAT "x(8)" INIT "" .       
def var nv_chk as  logic.                                
DEF VAR nv_ncbyrs AS INTE.                               
DEF VAR  NO_CLASS AS CHAR INIT "".                       
def var  s_recid1       as RECID .     /* uwm100  */                    
def var  s_recid2       as recid .     /* uwm120  */                    
def var  s_recid3       as recid .     /* uwm130  */                    
def var  s_recid4       as recid .     /* uwm301  */                    
DEF VAR nv_provi   AS   CHAR INIT "".                                   
DEF VAR n_rencnt   LIKE sicuw.uwm100.rencnt INITIAL "".              
DEF VAR n_endcnt   LIKE sicuw.uwm100.endcnt INITIAL "".                
DEF VAR nv_daily     AS CHARACTER FORMAT "X(1024)"     INITIAL ""  NO-UNDO.     
DEF VAR nv_reccnt   AS  INT  INIT  0.           /*all load record*/                              
DEF VAR nv_completecnt    AS   INT   INIT  0.   /*complete record */                              
def var s_riskgp    AS INTE FORMAT ">9".                                                         
def var s_riskno    AS INTE FORMAT "999".                                                        
def var s_itemno    AS INTE FORMAT "999".                                                        
DEF VAR nv_drivage1 AS INTE INIT 0.                                
DEF VAR nv_drivage2 AS INTE INIT 0.                                
DEF VAR nv_drivbir1 AS CHAR INIT "".                               
DEF VAR nv_drivbir2 AS CHAR INIT "".                               
def var nv_dept     as char format  "X(1)".       
def var nv_undyr    as    char  init  ""    format   "X(4)".       
def var n_curbil    LIKE  sicuw.uwm100.curbil  NO-UNDO.            
DEF VAR nv_stm_per  AS DECIMAL FORMAT ">9.99" INITIAL 0 NO-UNDO.      
DEF VAR nv_tax_per  AS DECIMAL FORMAT ">9.99" INITIAL 0 NO-UNDO.      
DEF VAR nv_com1_per AS DECIMAL FORMAT ">9.99" INITIAL 0 NO-UNDO.    
DEF VAR nv_com1_prm AS DECIMAL FORMAT ">>>>>9.99-"      NO-UNDO.    
DEF VAR s_130bp1    AS RECID                 NO-UNDO.      
DEF VAR s_130fp1    AS RECID                 NO-UNDO.      
DEF VAR nvffptr     AS RECID                 NO-UNDO.      
DEF VAR n_rd132     AS RECID                 NO-UNDO.      
DEF VAR nv_gap      AS DECIMAL               NO-UNDO.      
DEF VAR nv_fptr     AS RECID.                           
DEF VAR nv_bptr     AS RECID.                           
DEF VAR nv_nptr     AS RECID.                           
DEF VAR nv_gap2     AS DECIMAL               NO-UNDO.              
DEF VAR nv_prem2    AS DECIMAL               NO-UNDO.              
DEF VAR nv_rstp     AS DECIMAL               NO-UNDO.                                
DEF VAR nv_rtax     AS DECIMAL               NO-UNDO.                                
DEF VAR nv_key_a    AS DECIMAL INITIAL 0     NO-UNDO.                                 
DEF VAR nv_rec100   AS RECID .                                       
DEF VAR nv_rec120   AS RECID .                                                                   
DEF VAR nv_rec130   AS RECID .                                                                  
DEF VAR nv_rec301   AS RECID .                                                                   
DEFINE VAR nv_line1   AS INTEGER   INITIAL 0  NO-UNDO.                                 
DEFINE  WORKFILE wuppertxt3 NO-UNDO                                                             
 /*1*/  FIELD line     AS INTEGER   FORMAT ">>9"                                                
 /*2*/  FIELD txt      AS CHARACTER FORMAT "X(78)"   INITIAL "".                                
DEF  VAR n_41   AS DECI     FORMAT ">,>>>,>>9.99" INIT 0.                       
DEF  VAR n_42   AS DECI     FORMAT ">,>>>,>>9.99" INIT 0.                       
DEF  VAR n_43   AS DECI     FORMAT ">,>>>,>>9.99" INIT 0.                       
DEFINE VAR nv_basere   AS DECI        FORMAT ">>,>>>,>>9.99-" INIT 0.           
DEFINE VAR n_sclass72  AS CHAR FORMAT "x(4)".                                   
DEFINE VAR nv_maxdes AS CHAR.                                                   
DEFINE VAR nv_mindes AS CHAR.                                                   
DEFINE VAR nv_si     AS DECI FORMAT ">>,>>>,>>9.99-".  /* Maximum Sum Insure */  
DEFINE VAR nv_maxSI  AS DECI FORMAT ">>,>>>,>>9.99-".  /* Maximum Sum Insure */  
DEFINE VAR nv_minSI  AS DECI FORMAT ">>,>>>,>>9.99-".  /* Minimum Sum Insure */  
DEFINE VAR nv_newsck AS CHAR FORMAT "x(15)" INIT " ".                           
DEF VAR nv_uwm301trareg    LIKE sicuw.uwm301.cha_no INIT "".                    
DEF  VAR gv_id AS CHAR FORMAT "X(10)" NO-UNDO. 
DEF VAR nv_pwd AS CHAR FORMAT "x(10)" NO-UNDO.    
DEF VAR nv_txt1  AS CHAR FORMAT "x(100)"  .
DEF VAR nv_txt2  AS CHAR FORMAT "x(100)"  .
DEF VAR nv_txt3  AS CHAR FORMAT "x(100)"  .
DEF VAR nv_txt4  AS CHAR FORMAT "x(100)"  .
/*Add kridtiya i. A56-0037  */
DEFINE VAR  np_no            AS CHAR FORMAT "x(10)"  INIT "".   /* 1   No. */                                                                               
DEFINE VAR  np_cedpol        AS CHAR FORMAT "x(20)"  INIT "".   /* 2   TN# àÅ¢·ÕèÊÑ­­Ò*/                                                                                 
DEFINE VAR  np_companynam    AS CHAR FORMAT "x(50)"  INIT "".   
DEFINE VAR  np_senddate      AS CHAR FORMAT "x(10)"  INIT "".   /* 3   ÇÑ¹·Õèá¨é§»ÃĞ¡Ñ¹ÀÑÂ */                                                                 
DEFINE VAR  np_insurcename   AS CHAR FORMAT "x(50)"  INIT "".   /* 4   ª×èÍ¼ÙéàÍÒ»ÃĞ¡Ñ¹ÀÑÂ */                                                                 
DEFINE VAR  np_ntitle        AS CHAR FORMAT "x(20)"  INIT "".   
DEFINE VAR  np_insurceno     AS CHAR FORMAT "x(10)"  INIT "".   /* 5   ÃËÑÊÅÙ¡¤éÒ  */                                                                         
DEFINE VAR  np_addr1         AS CHAR FORMAT "x(100)" INIT "".   /* 6   ·ÕèÍÂÙè¼ÙéàÍÒ»ÃĞ¡Ñ¹ÀÑÂ  */                                                             
DEFINE VAR  np_model         AS CHAR FORMAT "x(60)"  INIT "".   /* 7   ÂÕèËéÍ/ÃØè¹ */                                                                         
DEFINE VAR  np_vehreg        AS CHAR FORMAT "x(30)"  INIT "".   /* 8   ·ĞàºÕÂ¹Ã¶   */  /*A54-0112*/
DEFINE VAR  np_caryear       AS CHAR FORMAT "X(4)"   INIT "".   /* 9   »Õ¨´·ĞàºÕÂ¹ */                                                                         
DEFINE VAR  np_cha_no        AS CHAR FORMAT "x(30)"  INIT "".   /* 10  àÅ¢µÑÇ¶Ñ§   */                                                                         
DEFINE VAR  np_engno         AS CHAR FORMAT "x(30)"  INIT "".   /* 11  àÅ¢à¤Ã×èÍ§Â¹µì  */                                                                     
DEFINE VAR  np_engCC         AS CHAR FORMAT "x(4)"   INIT "".   /* 12  ¢¹Ò´à¤Ã×èÍ§Â¹µì */                                                                     
DEFINE VAR  np_benname       AS CHAR FORMAT "x(40)"  INIT "".   /* 13  ¼ÙéÃÑº¼Å»ÃĞâÂª¹ì    */                                                                 
/*DEFINE VAR  np_showroomno    AS CHAR FORMAT "x(50)"  INIT "".   /* 14  âªÇìÃÙÁ     */                                                                         
DEFINE VAR  np_showroom2     AS CHAR FORMAT "x(50)"  INIT "".   /* 14  âªÇìÃÙÁ     */  */                                                                      
DEFINE VAR  np_stkno         AS CHAR FORMAT "x(20)"  INIT "".   /* 15  à¤Ã×èÍ§ËÁÒÂ ¾Ãº */                                                                     
DEFINE VAR  np_pol72         AS CHAR FORMAT "x(15)"  INIT "".   /* 16  ¡ÃÁ¸ÃÃÁì ¾Ãº    */                                                                     
DEFINE VAR  np_garage        AS CHAR FORMAT "x(30)"  INIT "".   /* 17  ÈÙ¹Âì«èÍÁÃ¶ */                                                                         
DEFINE VAR  np_covcod        AS CHAR FORMAT "x(30)"  INIT "".   /* 18  »ÃĞàÀ·¤ÇÒÁ¤ØéÁ¤ÃÍ§  */                                                                 
DEFINE VAR  np_comdate       AS CHAR FORMAT "x(10)"  INIT "".   /* 19  ÇÑ¹·ÕèàÃÔèÁ¤ØéÁ¤ÃÍ§ */                                                                 
DEFINE VAR  np_si            AS CHAR FORMAT "x(20)"  INIT "".   /* 20  ·Ø¹»ÃĞ¡Ñ¹ÀÑÂ    */                                                                     
DEFINE VAR  np_premt         AS CHAR FORMAT "x(20)"  INIT "".   /* 21  àºÕéÂ»ÃĞ¡Ñ¹ÀÑÂÀÒ¤ÊÁÑ¤Ãã¨    */                                                         
DEFINE VAR  np_premtcomp     AS CHAR FORMAT "x(20)"  INIT "".   /* 22  àºÕéÂ»ÃĞ¡Ñ¹ÀÑÂÃÇÁ ¾Ãº   */                                                          
DEFINE VAR  np_deduct        AS CHAR FORMAT "X(20)"  INIT "".   /* 23  ¤ÇÒÁàÊÕÂËÒÂÊèÇ¹áÃ¡  */                                                                  
DEFINE VAR  np_tper          AS CHAR FORMAT "x(20)"  INIT "".   /* 24  ¤ÇÒÁÃÑº¼Ô´µèÍºØ¤¤ÅÀÒÂ¹Í¡ (ºÒ´à¨çºËÃ×ÍàÊÕÂªÕÇÔµ µèÍ¤¹)   */                              
DEFINE VAR  np_tpbi          AS CHAR FORMAT "x(20)"  INIT "".   /* 25  ¤ÇÒÁÃÑº¼Ô´µèÍºØ¤¤ÅÀÒÂ¹Í¡ (ºÒ´à¨çºËÃ×ÍàÊÕÂªÕÇÔµ µèÍ¤ÃÑé§)    */                          
DEFINE VAR  np_tppd          AS CHAR FORMAT "x(20)"  INIT "".   /* 26  ¤ÇÒÁÃÑº¼Ô´µèÍºØ¤¤ÅÀÒÂ¹Í¡ (·ÃÑ¾ÂìÊÔ¹ µèÍ¤ÃÑé§)   */                                      
DEFINE VAR  np_si1           AS CHAR FORMAT "x(20)"  INIT "".   /* 27  ¤ÇÒÁàÊÕÂËÒÂµèÍÃ¶Â¹µì·ÕèàÍÒ»ÃĞ¡Ñ¹ÀÑÂ(¤ÇÒÁàÊÕÂËÒÂµèÍµÑÇÃ¶)    */                          
DEFINE VAR  np_fire          AS CHAR FORMAT "x(20)"  INIT "".   /* 28  ¤ÇÒÁàÊÕÂËÒÂµèÍÃ¶Â¹µì·ÕèàÍÒ»ÃĞ¡Ñ¹ÀÑÂ(¡ÒÃÊÙ­ËÒÂáÅĞä¿äËÁé) */                               
DEFINE VAR  np_41            AS CHAR FORMAT "x(20)"  INIT "".   /* 29  ¢ÂÒÂ¤ÇÒÁ¤ØéÁ¤ÃÍ§(¡ÒÃ»ÃĞ¡Ñ¹ÍØºÑµÔàËµØÊèÇ¹ºØ¤¤Å ¤¹ÅĞ) */                                 
DEFINE VAR  np_42            AS CHAR FORMAT "x(20)"  INIT "".   /* 30  ¢ÂÒÂ¤ÇÒÁ¤ØéÁ¤ÃÍ§(¡ÒÃ»ÃĞ¡Ñ¹¤èÒÃÑ¡ÉÒ¾ÂÒºÒÅ ¤¹ÅĞ)  */             
DEFINE VAR  np_43            AS CHAR FORMAT "x(20)"  INIT "".   /* 31  ¢ÂÒÂ¤ÇÒÁ¤ØéÁ¤ÃÍ§(¡ÒÃ»ÃĞ¡Ñ¹µÑÇ¼Ùé¢Ñº¢Õè¤´ÕÍÒ­Ò)  */                                                    
DEFINE VAR  np_feet          AS CHAR FORMAT "x(20)"  INIT "".   /* 32  ÊèÇ¹Å´¡ÅØèÁ */                                                                                        
DEFINE VAR  np_ncb           AS CHAR FORMAT "x(20)"  INIT "".   /* 33  ÊèÇ¹Å´»ÃĞÇÑµÔ´Õ */                                                                                    
DEFINE VAR  np_other         AS CHAR FORMAT "x(20)"  INIT "".   /* 34  ÊèÇ¹Å´Í×è¹ æ  */                                             
DEFINE VAR  np_seats         AS CHAR FORMAT "x(3)"   INIT "".   /* 35  ¨Ó¹Ç¹·Õè¹Ñè§ */                                             
DEFINE VAR  np_remark        AS CHAR FORMAT "x(100)" INIT "".   /* 36  ËÁÒÂàËµØ  */                                                 
DEFINE VAR  np_subclass      AS CHAR FORMAT "x(10)"  INIT "".   /* 40  UserClosing */                                             
DEFINE VAR  np_campaign      AS CHAR FORMAT "x(30)"  INIT "".   /* 41  Campaign    */ 
DEFINE VAR  np_icno          AS CHAR FORMAT "x(20)"  INIT "".   /* 42  icno    */  /*A56-0243*/
DEFINE VAR  nv_numberno      AS DECI INIT 0 FORMAT ">>>9".      /*A57-0432*/
define var  np_typepol       as char format "x(3)" init "".
define var  np_addr2         as char format "x(100)" init "".
define var  np_Brand         as char format "x(20)" init "".
define var  np_oldpol        as char format "x(15)" init "".
define var  np_drive1        as char format "x(75)" init "".
define var  np_bdate1        as char format "x(15)" init "".
define var  np_id1           as char format "x(15)" init "".
define var  np_drive2        as char format "x(75)" init "".
define var  np_bdate2        as char FORMAT "x(15)" init "".
define var  np_id2           as char FORMAT "x(15)" init "".
define var  np_expdate       as char format "x(15)" init "".
define var  np_comdate72     as char format "x(15)" init "".
define var  np_expdate72     as char format "x(15)" init "".
define var  np_total         as char format "x(20)" init "".
define var  np_deduct2       as char format "x(20)" init "".
define var  np_dspc          as char format "x(20)" init "".
define var  np_contractno    as char format "x(20)" init "".
define var  np_user          as char format "x(50)" init "".
define var  np_policy        as char format "x(15)" init "".
define var  np_tempol        as char format "x(15)" init "".
define var  np_paiddat       as char format "x(15)" init "".
define var  np_typepaid      as char format "x(2)" init "".
define var  np_paidno        as char format "x(10)" init "".
define var  np_remarkpaid    as char format "x(100)" init "".
define var  np_paidtyp       as char format "x(10)" init "".
define var  np_br            as char format "x(5)" init "".
def var np_remark2    as char format "X(100)" init "".
def var np_remark3    as char format "X(100)" init "".
/* Add kridtiya i. A56-0037      */

/* add by : A64-0138 */
def var dod0 as INT format ">>>>>>9-" init 0.
def var dod1 as INT format ">>>>>>9-" init 0.           
def var dod2 as INT format ">>>>>>9-" init 0.
def var dpd0 as INT format ">>>>>>9-" init 0.

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

DEFINE VAR nv_ratatt    AS DECI FORMAT ">>,>>>,>>9-".
DEFINE VAR nv_siatt     AS DECI FORMAT ">>,>>>,>>9-".
DEFINE VAR nv_netatt    AS DECI FORMAT ">>,>>>,>>9-".
DEFINE VAR nv_fltatt    AS DECI FORMAT ">>,>>>,>>9-".
DEFINE VAR nv_ncbatt    AS DECI FORMAT ">>,>>>,>>9-".
DEFINE VAR nv_dscatt    AS DECI FORMAT ">>,>>>,>>9-".
DEFINE VAR nv_fcctv     AS LOGICAL . 
define var nv_uom1_c    as char .
define var nv_uom2_c    as char .
define var nv_uom5_c    as char .
DEFINE VAR nv_41prmt    AS DECI FORMAT ">>>,>>>,>>9.99-".  /* fleet */
DEFINE VAR nv_42prmt    AS DECI FORMAT ">>>,>>>,>>9.99-".  /* fleet */
DEFINE VAR nv_43prmt    AS DECI FORMAT ">>>,>>>,>>9.99-".  /* fleet */
DEFINE VAR nv_pdprem    AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_status    AS CHAR .     /*fleet YES=Complete , NO=Not Complete */
DEFINE VAR nv_baseprm3  AS DECI FORMAT ">>,>>>,>>9.99-".

/* end A64-0138 */
