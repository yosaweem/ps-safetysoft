/*programid   : wgwycgen.i                                                                   */
/*programname : load text file yakult to GW                                                  */
/* Copyright  : Safety Insurance Public Company Limited 			                         */
/*			    ºÃÔÉÑ· »ÃĞ¡Ñ¹¤ØéÁÀÑÂ ¨Ó¡Ñ´ (ÁËÒª¹)				                             */
/*create by   : Kridtiya i. A53-0232   date . 02/08/2010                                     
                »ÃÑºâ»Ãá¡ÃÁãËéÊÒÁÒÃ¶¹Óà¢éÒ text file yacool[ÂÒ¤ÙÅ¸ì] to GW system            */ 
/*copy write  : wgwargen.i                                                                   */
/*modify by   : Kridtiya i. A54-0129 27/05/2011 »ÃÑºá¡éä¢µÑÇá»Ã à¾ÔèÁà¾×èÍÃÑº¤èÒ¢Í§§Ò¹µèÍÍÒÂØ*/ 
/*modify by   : Kridtiya i. A55-0182 07/01/2013 »ÃÑº¡ÒÃãËé¤èÒÃØè¹Ã¶                          */
/*modify by   : Kridtiya i. A57-0042 10/02/2014 »ÃÑº¡ÒÃãËé¤èÒ·ĞàºÕÂ¹Ã¶,à¾ÔèÁÇÑ¹·ÕèÊÔé¹ÊØ´¤ÇÒÁ¤ØéÁ¤ÃÍ§  */
/*modify by   : Kridtiya i. A57-0430 03/12/2014 à¾ÔèÁ¡ÒÃÃÑº¤èÒ·Ø¹»ÃĞ¡Ñ¹ áÅĞ¡ÒÃºÑ¹·Ö¡¢éÍ¤ÇÒÁ F6,F17,F18 */
/*Modify by   : Kridtiya i. A63-0472 Date. 09/11/2020 add field firstname ,lastname.....*/
/*Modify by   : Ranu I. A64-0138 à¾ÔèÁµÑÇá»Ãà¡çº¤èÒ¡ÒÃ¤Ó¹Ç³àºÕéÂ */
/**********************************************************************/
/*DEFINE NEW SHARED TEMP-TABLE wdetail2
    FIELD number      AS CHAR FORMAT "x(10)"  INIT ""    /*1  ÅÓ´Ñº         */        
    FIELD prepol      AS CHAR FORMAT "x(25)"  INIT ""    /*2  ¡ÃÁ¸ÃÃÁìà´ÔÁ  */   
    FIELD policyno    AS CHAR FORMAT "x(20)"  INIT ""    /*3  ¡ÃÁ ¾Ãº.v72à¾ÔèÁ¡ÃÁªèÍ§·Õè 1 *//*A53-0370*/   
    FIELD tax_dat     AS CHAR FORMAT "x(10)"  INIT ""    /*4  ÇÑ¹àÊÕÂÀÒÉÕ   */     
    FIELD comcode     AS CHAR FORMAT "x(20)"  INIT ""    /*5  à«ç¹àµÍÃì     */     
    FIELD Key_ID      AS CHAR FORMAT "x(20)"  INIT ""    /*6  key.id        */
    FIELD tiname      AS CHAR FORMAT "x(30)"  INIT ""    /*7  title         */
    FIELD insnam      AS CHAR FORMAT "x(75)"  INIT ""    /*8  ª×èÍ          */
    FIELD name2       AS CHAR FORMAT "x(45)"  INIT ""    /*9  ¹ÒÁÊ¡ØÅ       */
    FIELD brand       AS CHAR FORMAT "x(50)"  INIT ""    /*10 ÂÕèËéÍÃ¶      */
    FIELD engcc       AS CHAR FORMAT "x(10)"  INIT ""    /*11 «Õ«Õ          */
    FIELD vehreg      AS CHAR FORMAT "x(15)"  INIT ""    /*12 ·ĞàºÕÂ¹Ã¶     */     
    FIELD re_country  AS CHAR FORMAT "x(30)"  INIT ""    /*13 ¨.Ç.·ĞàºÕÂ¹   */
    FIELD chasno      AS CHAR FORMAT "x(25)"  INIT ""    /*14 ËÁÒÂàÅ¢µÑÇ¶Ñ§*/
    FIELD caryear     AS CHAR FORMAT "x(5)"   INIT ""    /*15 »ÕÃ¶         */            
    FIELD comdat      AS CHAR FORMAT "x(10)"  INIT ""    /*16 Ç.´.».»ÃĞ¡Ñ¹  */      
    FIELD expdat      AS CHAR FORMAT "x(10)"  INIT ""    /*17 expidate à¾ÔèÁ¡ÃÁªèÍ§ expirydate.*//*A53-0370*/ 
    FIELD n_STATUS    AS CHAR FORMAT "x(30)"  INIT ""    /*18 µèÍ  ËÁÒÂàËµØ (µèÍ/ãËÁè) */   
    FIELD mem1        AS CHAR FORMAT "x(30)"  INIT ""    /*19 ¡ÃÁ¸ÃÃÁìv70ãËÁè à¾ÔèÁ¡ÃÁªèÍ§·Õè 1 *//*A53-0370*/                         
    FIELD mem2        AS CHAR FORMAT "x(30)"  INIT ""    /*20 D-0-70-53/013918*/                                    
    FIELD mem3        AS CHAR FORMAT "x(30)"  INIT ""    /*21 á·¹¤Ñ¹à¡èÒ      */    . */      
DEFINE NEW SHARED TEMP-TABLE wdetail 
    FIELD policy     AS CHAR FORMAT "x(25)" INIT "" 
    FIELD prepol     AS CHAR FORMAT "x(25)" INIT "" 
    FIELD poltyp     AS CHAR FORMAT "x(3)"  INIT "" 
    FIELD n_opnpol   AS CHAR FORMAT "x(20)" INIT ""
    FIELD producer   AS CHAR FORMAT "x(10)" INIT ""  
    FIELD agent      AS CHAR FORMAT "x(10)" INIT ""  
    FIELD n_insured  AS CHAR FORMAT "x(15)" INIT ""
    FIELD tiname     AS CHAR FORMAT "x(20)" INIT "" 
    FIELD insnam     AS CHAR FORMAT "x(50)" INIT "" 
    FIELD name2      AS CHAR FORMAT "x(50)" INIT "" 
    FIELD name3      AS CHAR FORMAT "x(50)" INIT "" 
    FIELD addr_1     AS CHAR FORMAT "x(35)" INIT ""     
    FIELD addr_2     AS CHAR FORMAT "x(35)" INIT ""     
    FIELD addr_3     AS CHAR FORMAT "x(35)" INIT ""     
    FIELD addr_4     AS CHAR FORMAT "x(20)" INIT "" 
    FIELD icno       AS CHAR FORMAT "x(15)" INIT ""   /*Add kridtiya i. A55-0182 */
    FIELD comdat     AS CHAR FORMAT "x(10)" INIT ""
    FIELD expdat     AS CHAR FORMAT "x(10)" INIT "" 
    FIELD firstdat   AS CHAR FORMAT "99/99/9999" INIT ""  
    FIELD cedpol     AS CHAR FORMAT "x(20)"  INIT "" 
    FIELD prempa     AS CHAR FORMAT "x(4)"   INIT ""    
    FIELD subclass   AS CHAR FORMAT "x(4)"   INIT ""      
    FIELD redbook    AS CHAR FORMAT "x(10)"  INIT "" 
    FIELD brand      AS CHAR FORMAT "x(30)"  INIT "" 
    FIELD model      AS CHAR FORMAT "x(40)"  INIT ""
    FIELD caryear    AS CHAR FORMAT "x(4)"   INIT "" 
    FIELD cargrp     AS CHAR FORMAT "x(2)"   INIT ""  
    FIELD body       AS CHAR FORMAT "x(30)"  INIT "" 
    FIELD engcc      AS CHAR FORMAT "x(10)"  INIT ""     
    FIELD tons       AS CHAR FORMAT "x(10)"  INIT ""     
    FIELD seat       AS INTE FORMAT "99"     INIT 0   
    FIELD vehuse     AS CHAR FORMAT "x(2)"   INIT ""   
    FIELD covcod     AS CHAR FORMAT "x(1)"   INIT ""
    FIELD garage     AS CHAR FORMAT "x"      INIT "" 
    FIELD vehreg     AS CHAR FORMAT "x(15)"  INIT ""
    FIELD chasno     AS CHAR FORMAT "x(30)"  INIT ""
    FIELD eng        AS CHAR FORMAT "x(30)"  INIT "" 
    FIELD tp1        AS DECI FORMAT ">,>>>,>>>,>>9.99-" INIT 0
    FIELD tp2        AS DECI FORMAT ">,>>>,>>>,>>9.99-" INIT 0
    FIELD tp3        AS DECI FORMAT ">,>>>,>>>,>>9.99-" INIT 0
    FIELD si         AS DECI FORMAT ">,>>>,>>>,>>9.99-" INIT 0
    FIELD fire       AS DECI FORMAT ">,>>>,>>>,>>9.99-" INIT 0
    FIELD NO_41      AS DECI INIT 0 
    FIELD seat41     AS DECI INIT 0          
    FIELD NO_42      AS DECI INIT 0   
    FIELD NO_43      AS DECI INIT 0 
    FIELD fleet      AS DECI FORMAT "99" INIT 0 
    FIELD ncb        AS DECI FORMAT "99" INIT 0 
    FIELD re_country AS CHAR FORMAT "x(30)"  INIT ""    /*13 ¨.Ç.·ĞàºÕÂ¹   */
    FIELD comment    AS CHAR FORMAT "x(512)" INIT ""
    FIELD trandat    AS CHAR FORMAT "x(10)" INIT ""    
    FIELD trantim    AS CHAR FORMAT "x(8)"  INIT ""       
    FIELD n_IMPORT   AS CHAR FORMAT "x(2)"  INIT ""       
    FIELD n_EXPORT   AS CHAR FORMAT "x(2)"  INIT "" 
    FIELD entdat     AS CHAR FORMAT "x(10)" INIT ""      
    FIELD enttim     AS CHAR FORMAT "x(8)"  INIT ""    
    FIELD premt      AS CHAR FORMAT "x(11)" INIT ""  
    FIELD comp_prm   AS CHAR FORMAT "x(9)"  INIT ""  
    FIELD stk        AS CHAR FORMAT "x(25)" INIT ""  
    FIELD benname    AS CHAR FORMAT "x(60)" INIT ""  
    FIELD nv_acctxt  AS CHAR FORMAT "x(120)" init ""
    FIELD gap        AS CHAR FORMAT "X(11)" INIT ""  
    /*FIELD deduct   AS CHAR FORMAT "X(9)"  INIT "" */
    FIELD cndat      AS CHAR FORMAT "x(10)" INIT ""     
    FIELD rstp_t     AS CHAR FORMAT "x(14)" INIT ""  
    FIELD rtax_t     AS CHAR FORMAT "x(14)" INIT ""  
    FIELD prem_r     AS CHAR FORMAT "x(14)" INIT ""  
    FIELD compul     AS CHAR FORMAT "x"     INIT ""   
    FIELD pass       AS CHAR FORMAT "x"     INIT "n" 
    FIELD comper     AS CHAR FORMAT "x(14)" INIT ""   
    FIELD comacc     AS CHAR FORMAT "x(14)" INIT ""   
    FIELD deductpd   AS CHAR FORMAT "X(14)" INIT ""  
    FIELD OK_GEN     AS CHAR FORMAT "X"     INIT "Y" 
    FIELD docno      AS CHAR FORMAT "x(10)" INIT "" 
    FIELD drivnam    AS CHAR FORMAT "x"     INIT "n" 
    FIELD tariff     AS CHAR FORMAT "x(2)"  INIT "9"
    FIELD cancel     AS CHAR FORMAT "x(2)"  INIT ""     
    FIELD accdat     AS CHAR FORMAT "x(10)" INIT ""    
    FIELD WARNING    AS CHAR FORMAT "X(30)" INIT ""     
    FIELD n_branch   AS CHAR FORMAT "x(5)"  INIT ""  
    FIELD campaignov AS CHAR FORMAT "X(30)" INIT "" .  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
DEF NEW SHARED    VAR nv_message AS char.
DEF               VAR c          AS CHAR.
DEF               VAR nv_riskgp  LIKE sic_bran.uwm120.riskgp NO-UNDO.
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
DEFINE VAR  nv_txtmsg    AS CHAR FORMAT "x(50)"          INIT "". 
DEF VAR dod0    AS INTEGER INIT 0.
DEF VAR dod1    AS INTEGER INIT 0.
DEF VAR dod2    AS INTEGER INIT 0.
DEF VAR dpd0    AS INTEGER INIT 0.
DEF VAR nv_ded2 AS INTEGER INIT 0.
DEF VAR nn_acno    LIKE  sicsyac.xtm600.acno  .
DEF VAR nn_name    LIKE sicsyac.xtm600.name. 
DEF VAR nn_name2   LIKE sicsyac.xtm600.name. 
DEF VAR nn_name3   LIKE sicsyac.xtm600.name. 
DEF VAR nn_addr1   LIKE  sicsyac.xtm600.addr1 .
DEF VAR nn_addr2   LIKE  sicsyac.xtm600.addr2 .
DEF VAR nn_addr3   LIKE  sicsyac.xtm600.addr3 .
DEF VAR nn_addr4   LIKE  sicsyac.xtm600.addr4 .
DEF VAR nn_ntitle  LIKE  sicsyac.xtm600.ntitle . 
/*Add kridtiya i. A55-0182 */
DEF VAR as_number      AS CHAR FORMAT "x(10)"  INIT ""  .  /*1  ÅÓ´Ñº         */        
DEF VAR as_prepol      AS CHAR FORMAT "x(25)"  INIT ""  .  /*2  ¡ÃÁ¸ÃÃÁìà´ÔÁ  */   
DEF VAR as_policyno    AS CHAR FORMAT "x(20)"  INIT "" .   /*3  ¡ÃÁ ¾Ãº.v72à¾ÔèÁ¡ÃÁªèÍ§·Õè 1 *//*A53-0370*/   
DEF VAR as_tax_dat     AS CHAR FORMAT "x(10)"  INIT "" .   /*4  ÇÑ¹àÊÕÂÀÒÉÕ   */     
DEF VAR as_comcode     AS CHAR FORMAT "x(20)"  INIT "" .   /*5  à«ç¹àµÍÃì     */     
DEF VAR as_Key_ID      AS CHAR FORMAT "x(20)"  INIT ""  .  /*6  key.id        */
DEF VAR as_tiname      AS CHAR FORMAT "x(30)"  INIT ""  .  /*7  title         */
DEF VAR as_insnam      AS CHAR FORMAT "x(75)"  INIT ""  .  /*8  ª×èÍ          */
DEF VAR as_name2       AS CHAR FORMAT "x(45)"  INIT ""  .  /*9  ¹ÒÁÊ¡ØÅ       */
DEF VAR as_brand       AS CHAR FORMAT "x(50)"  INIT ""  .  /*10 ÂÕèËéÍÃ¶      */
DEF VAR as_engcc       AS CHAR FORMAT "x(10)"  INIT "" .   /*11 «Õ«Õ          */
DEF VAR as_vehreg      AS CHAR FORMAT "x(15)"  INIT "" .   /*12 ·ĞàºÕÂ¹Ã¶     */     
DEF VAR as_re_country  AS CHAR FORMAT "x(30)"  INIT "" .   /*13 ¨.Ç.·ĞàºÕÂ¹   */
DEF VAR as_chasno      AS CHAR FORMAT "x(25)"  INIT ""  .  /*14 ËÁÒÂàÅ¢µÑÇ¶Ñ§*/
DEF VAR as_caryear     AS CHAR FORMAT "x(5)"   INIT "" .   /*15 »ÕÃ¶         */            
DEF VAR as_comdat      AS CHAR FORMAT "x(10)"  INIT "" .   /*16 Ç.´.».»ÃĞ¡Ñ¹  */      
DEF VAR as_expdat      AS CHAR FORMAT "x(10)"  INIT "" .   /*17 expidate à¾ÔèÁ¡ÃÁªèÍ§ expirydate.*//*A53-0370*/ 
DEF VAR as_n_STATUS    AS CHAR FORMAT "x(30)"  INIT "" .   /*18 µèÍ  ËÁÒÂàËµØ (µèÍ/ãËÁè) */   
DEF VAR as_mem1        AS CHAR FORMAT "x(30)"  INIT "" .   /*19 ¡ÃÁ¸ÃÃÁìv70ãËÁè à¾ÔèÁ¡ÃÁªèÍ§·Õè 1 *//*A53-0370*/                         
DEF VAR as_mem2        AS CHAR FORMAT "x(30)"  INIT "" .   /*20 D-0-70-53/013918*/                                    
DEF VAR as_mem3        AS CHAR FORMAT "x(30)"  INIT "" .   /*21 á·¹¤Ñ¹à¡èÒ      */ 
DEF VAR nn_icno        AS CHAR FORMAT "x(15)"  INIT "" .   
/*Add kridtiya i. A55-0182 */
DEFINE WORKFILE wcomp                                      /*A57-0042*/
    FIELD brand        AS CHAR FORMAT "x(25)"   INIT ""    /*A57-0042*/
    FIELD redbook      AS CHAR FORMAT "x(10)"   INIT "" .  /*A57-0042*/
DEF VAR as_sumins      AS CHAR FORMAT "x(20)"   INIT "" .  /*A57-0430*/
DEF VAR as_texF17_1    AS CHAR FORMAT "x(150)"  INIT "" .  /*A57-0430*/ 
DEF VAR as_texF17_2    AS CHAR FORMAT "x(150)"  INIT "" .  /*A57-0430*/ 
DEF VAR as_texF17_3    AS CHAR FORMAT "x(150)"  INIT "" .  /*A57-0430*/ 
DEF VAR as_texF18_1    AS CHAR FORMAT "x(150)"  INIT "" .  /*A57-0430*/ 
DEF VAR as_texF18_2    AS CHAR FORMAT "x(150)"  INIT "" .  /*A57-0430*/ 
DEF VAR as_texF18_3    AS CHAR FORMAT "x(150)"  INIT "" .  /*A57-0430*/ 
DEF VAR as_texF6_1     AS CHAR FORMAT "x(150)"  INIT "" .  /*A57-0430*/ 
DEF VAR as_texF6_2     AS CHAR FORMAT "x(150)"  INIT "" .  /*A57-0430*/ 
DEF VAR as_texF6_3     AS CHAR FORMAT "x(150)"  INIT "" .  /*A57-0430*/ 
DEF VAR as_texF6_4     AS CHAR FORMAT "x(150)"  INIT "" .  /*A57-0430*/ 
DEF VAR as_texF6_5     AS CHAR FORMAT "x(150)"  INIT "" .  /*A57-0430*/ 
DEF VAR chk_type       AS CHAR FORMAT "x(2)"    INIT "" .  /*A57-0430*/ 
DEFINE WORKFILE wtext17
    FIELD as_policyF17   AS CHAR FORMAT "x(16)"   INIT ""    /*A57-0430*/ 
    FIELD as_texF17_1    AS CHAR FORMAT "x(150)"  INIT ""    /*A57-0430*/ 
    FIELD as_texF17_2    AS CHAR FORMAT "x(150)"  INIT ""    /*A57-0430*/ 
    FIELD as_texF17_3    AS CHAR FORMAT "x(150)"  INIT "" .  /*A57-0430*/ 
DEFINE WORKFILE wtext18
    FIELD as_policyF18   AS CHAR FORMAT "x(16)"   INIT ""    /*A57-0430*/ 
    FIELD as_texF18_1    AS CHAR FORMAT "x(150)"  INIT ""    /*A57-0430*/ 
    FIELD as_texF18_2    AS CHAR FORMAT "x(150)"  INIT ""    /*A57-0430*/ 
    FIELD as_texF18_3    AS CHAR FORMAT "x(150)"  INIT "" .  /*A57-0430*/ 
DEFINE WORKFILE wtext6
    FIELD as_policyF6    AS CHAR FORMAT "x(16)"   INIT ""    /*A57-0430*/ 
    FIELD as_texF6_1     AS CHAR FORMAT "x(150)"  INIT ""    /*A57-0430*/ 
    FIELD as_texF6_2     AS CHAR FORMAT "x(150)"  INIT ""    /*A57-0430*/ 
    FIELD as_texF6_3     AS CHAR FORMAT "x(150)"  INIT ""   /*A57-0430*/ 
    FIELD as_texF6_4     AS CHAR FORMAT "x(150)"  INIT ""    /*A57-0430*/ 
    FIELD as_texF6_5     AS CHAR FORMAT "x(150)"  INIT "" .  /*A57-0430*/ 
DEFINE WORKFILE wmatch
    FIELD n_id      AS CHAR FORMAT "x(10)"    INIT ""    /*A57-0430*/ 
    FIELD n_prepol  AS CHAR FORMAT "x(16)"    INIT ""    /*A57-0430*/ 
    FIELD n_policy  AS CHAR FORMAT "x(16)"    INIT ""    /*A57-0430*/ 
    FIELD n_taxno   AS CHAR FORMAT "x(40)"    INIT ""    /*A57-0430*/ 
    FIELD n_dept    AS CHAR FORMAT "x(30)"    INIT ""    /*A57-0430*/ 
    FIELD n_recno   AS CHAR FORMAT "x(15)"    INIT ""    /*A57-0430*/ 
    FIELD n_title   AS CHAR FORMAT "x(25)"    INIT ""    /*A57-0430*/ 
    FIELD n_name1   AS CHAR FORMAT "x(35)"    INIT ""    /*A57-0430*/   
    FIELD n_name2   AS CHAR FORMAT "x(40)"    INIT ""    /*A57-0430*/ 
    FIELD n_brand   AS CHAR FORMAT "x(30)"    INIT ""    /*A57-0430*/ 
    FIELD n_cc      AS CHAR FORMAT "x(10)"    INIT ""    /*A57-0430*/ 
    FIELD n_vehreg  AS CHAR FORMAT "x(15)"    INIT ""    /*A57-0430*/ 
    FIELD n_provin  AS CHAR FORMAT "x(10)"    INIT ""    /*A57-0430*/ 
    FIELD n_chass   AS CHAR FORMAT "x(30)"    INIT ""    /*A57-0430*/ 
    FIELD n_year    AS CHAR FORMAT "x(10)"    INIT ""    /*A57-0430*/ 
    FIELD n_comdat  AS CHAR FORMAT "x(12)"    INIT ""    /*A57-0430*/ 
    FIELD n_expdat  AS CHAR FORMAT "x(12)"    INIT ""    /*A57-0430*/ 
    FIELD n_sumins  AS CHAR FORMAT "x(20)"    INIT ""    /*A57-0430*/ 
    FIELD n_tex1701 AS CHAR FORMAT "x(150)"   INIT ""    /*A57-0430*/ 
    FIELD n_tex1702 AS CHAR FORMAT "x(150)"   INIT ""    /*A57-0430*/ 
    FIELD n_tex1703 AS CHAR FORMAT "x(150)"   INIT ""    /*A57-0430*/ 
    FIELD n_tex1801 AS CHAR FORMAT "x(150)"   INIT ""    /*A57-0430*/ 
    FIELD n_tex1802 AS CHAR FORMAT "x(150)"   INIT ""    /*A57-0430*/ 
    FIELD n_tex1803 AS CHAR FORMAT "x(150)"   INIT ""    /*A57-0430*/ 
    FIELD n_tex1601 AS CHAR FORMAT "x(100)"   INIT ""    /*A57-0430*/ 
    FIELD n_tex1602 AS CHAR FORMAT "x(100)"   INIT ""    /*A57-0430*/ 
    FIELD n_tex1603 AS CHAR FORMAT "x(100)"   INIT ""    /*A57-0430*/ 
    FIELD n_tex1604 AS CHAR FORMAT "x(100)"   INIT ""    /*A57-0430*/ 
    FIELD n_tex1605 AS CHAR FORMAT "x(100)"   INIT "" .   /*A57-0430*/ 
DEF VAR nn_firstName   AS CHAR FORMAT "x(150)"   INIT "" . /*Add by Kridtiya i. A63-0472*/ 
DEF VAR nn_lastName    AS CHAR FORMAT "x(150)"   INIT "" . /*Add by Kridtiya i. A63-0472*/
DEF VAR nn_postcd      AS CHAR FORMAT "x(150)"   INIT "" . /*Add by Kridtiya i. A63-0472*/
DEF VAR nn_codeocc     AS CHAR FORMAT "x(150)"   INIT "" . /*Add by Kridtiya i. A63-0472*/
DEF VAR nn_codeaddr1   AS CHAR FORMAT "x(100)"   INIT "" . /*Add by Kridtiya i. A63-0472*/
DEF VAR nn_codeaddr2   AS CHAR FORMAT "x(100)"   INIT "" . /*Add by Kridtiya i. A63-0472*/
DEF VAR nn_codeaddr3   AS CHAR FORMAT "x(100)"   INIT "" . /*Add by Kridtiya i. A63-0472*/
DEF VAR nn_br_insured  AS CHAR FORMAT "x(100)"   INIT "" . /*Add by Kridtiya i. A63-0472*/
DEF  VAR n_41   AS DECI     FORMAT ">,>>>,>>9.99" INIT 0.
DEF  VAR n_42   AS DECI     FORMAT ">,>>>,>>9.99" INIT 0.
DEF  VAR n_43   AS DECI     FORMAT ">,>>>,>>9.99" INIT 0.
DEFINE VAR nv_basere  AS DECI FORMAT ">,>>>,>>>,>>9.99-" INIT 0. 
DEFINE VAR n_sclass72  AS CHAR FORMAT "x(4)".
DEFINE VAR nv_maxdes AS CHAR.
DEFINE VAR nv_mindes AS CHAR.
DEFINE VAR nv_si     AS DECI FORMAT ">>,>>>,>>9.99-". /* Maximum Sum Insure */
DEFINE VAR nv_maxSI  AS DECI FORMAT ">>,>>>,>>9.99-". /* Maximum Sum Insure */
DEFINE VAR nv_minSI  AS DECI FORMAT ">>,>>>,>>9.99-". /* Minimum Sum Insure */
DEFINE VAR nv_newsck AS CHAR FORMAT "x(15)" INIT " ".
DEFINE VAR nv_simat  AS DECI FORMAT ">>>,>>>,>>>,>>9.99-".
DEFINE VAR nv_simat1  AS DECI FORMAT ">>>,>>>,>>>,>>9.99-".
DEF VAR nv_uwm301trareg    LIKE sicuw.uwm301.cha_no INIT "".
DEF VAR gv_id AS CHAR FORMAT "X(8)" NO-UNDO.
DEF VAR gv_sp2 AS CHAR FORMAT "x(2)" NO-UNDO.
DEF VAR gv_ver AS CHAR NO-UNDO.
DEF VAR gv_prdid AS CHAR FORMAT "x(40)" NO-UNDO.
DEF VAR gv_sp1 AS CHAR FORMAT "x(1)" NO-UNDO.
DEF VAR gv_date AS DATE NO-UNDO.
DEF VAR gv_time AS CHAR NO-UNDO.
DEF VAR nv_pwd AS CHAR NO-UNDO.
DEF VAR nv_log AS CHAR FORMAT "X(100)".
DEF VAR n_db AS CHAR FORMAT "X(10)".
DEF VAR n_brand AS CHAR FORMAT "x(50)"  INIT "".
DEF VAR n_model AS CHAR FORMAT "x(50)"  INIT "".
DEF VAR n_index AS INTE  INIT 0.
DEF VAR stklen AS INTE.
DEF VAR aa  AS DECI .
DEF VAR n_firstdat AS DATE INIT ?.  
DEF VAR n_campaignov  AS CHAR INIT "".
DEFINE VAR nv_chkerror AS CHAR INIT "".    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 

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
DEFINE VAR nv_41prmt   AS DECI FORMAT ">>>,>>>,>>9.99-".  /* fleet */
DEFINE VAR nv_42prmt   AS DECI FORMAT ">>>,>>>,>>9.99-".  /* fleet */
DEFINE VAR nv_43prmt   AS DECI FORMAT ">>>,>>>,>>9.99-".  /* fleet */
DEFINE VAR nv_pdprem   AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_status   AS CHAR .   /*fleet YES=Complete , NO=Not Complete */
DEFINE VAR nv_baseprm3 AS DECI FORMAT ">>,>>>,>>9.99-".
     
/* end A64-0138 */

                                                           





