/*programid  : wgwsagen.i                                                                    */ 
/*programname: load text file º¨¡.ÊÂÒÁÍÍâµéà«ÍÃìÇÔÊ to GW                                    */ 
/*Copyright  : Safety Insurance Public Company Limited 			                             */ 
/*			   ºÃÔÉÑ· »ÃĞ¡Ñ¹¤ØéÁÀÑÂ ¨Ó¡Ñ´ (ÁËÒª¹)				                             */ 
/*create by  : Kridtiya i. A54-0011  date . 11/01/2011               
               »ÃÑºâ»Ãá¡ÃÁãËéÊÒÁÒÃ¶¹Óà¢éÒ text file º¨¡.ÊÂÒÁÍÍâµéà«ÍÃìÇÔÊ to GW system       */ 
/*copy write : wgwargen.i                                                                    */ 
/*Modify by  : Kridtiya i. A56-0151 à¾ÔèÁ Text  Alt F7 ÍØ»¡Ã³ìàÊÃÔÁ ¨Ò¡ File ¡ÃÁ¸ÃÃÁì Master */
/*Modify by  : Kridtiya i. A56-0327 à¾ÔèÁ ¡ÒÃÃÑº·ĞàºÕÂ¹Ã¶¨Ò¡ä¿Åì¹Óà¢éÒ                       */
/*Modify by  : Kridtiya i. A57-0193 à¾ÔèÁ ¤èÒ commission    ¨Ò¡ ä¿Åì¹Óà¢éÒÃĞºº               */
/*Modify by  : Kridtiya i. A57-0302 à¾ÔèÁ ¤èÒ no-mn30                                        */
/* Modify By : Ranu I. Date 16/09/2015 [A58-0354] 
              à¾ÔèÁ FIELD promotion  à¡çº¤èÒ¨Ò¡ªèÍ§ Promotion                               */
/*Modify by  : Kridtiya i. A59-0186 date: 30/05/2016 add occupation                         */
/*Modify by  : Kridtiya i. A63-0472 Date. 09/11/2020 add field firstname ,lastname.....     */
/*Modify by  : Ranu i. A64-0138 à¾ÔèÁà§×èÍ¹ä¢¡ÒÃ¤Ó¹Ç³àºÕéÂ¨Ò¡â»Ãá¡ÃÁ¡ÅÒ§ */
/*********************************************************************************************/
DEFINE NEW SHARED TEMP-TABLE wdetail2
    FIELD benname       AS CHAR FORMAT "x(65)" INIT "" 
    FIELD prepol        AS CHAR FORMAT "x(25)" INIT ""
    FIELD comdat        AS CHAR FORMAT "x(10)" INIT ""  
    FIELD expdat        AS CHAR FORMAT "x(10)" INIT "" 
    FIELD licen         AS CHAR FORMAT "x(25)" INIT ""   /* a56-0327 */
    FIELD commiss70     AS CHAR FORMAT "x(10)" INIT ""   /* A57-0193 */
    FIELD commiss72     AS CHAR FORMAT "x(10)" INIT ""   /* A57-0193 */  
    FIELD nomn30        AS CHAR FORMAT "x(60)" INIT "".  /* A57-0302 */
DEFINE NEW SHARED TEMP-TABLE wdetail
    FIELD policyno      AS CHAR FORMAT "x(15)" INIT "" 
    FIELD n_rencnt      LIKE sicuw.uwm100.rencnt INITIAL ""
    FIELD n_endcnt      LIKE sicuw.uwm100.endcnt INITIAL ""
    FIELD n_branch      AS CHAR FORMAT "x(5)"  INIT "" 
    FIELD prepol        AS CHAR FORMAT "x(25)" INIT "" 
    FIELD poltyp        AS CHAR FORMAT "x(3)"  INIT "" 
    FIELD promotion     AS CHAR FORMAT "x(25)"  INIT ""  /*-- A58-0354--*/
    FIELD ins_co        AS CHAR FORMAT "x(10)" INIT ""   
    FIELD tiname        AS CHAR FORMAT "x(20)" INIT "" 
    FIELD insnam        AS CHAR FORMAT "x(60)" INIT ""     
    FIELD n_addr1       AS CHAR FORMAT "x(35)" INIT ""     
    FIELD n_addr2       AS CHAR FORMAT "x(35)" INIT ""     
    FIELD n_addr3       AS CHAR FORMAT "x(35)" INIT ""     
    FIELD n_addr4       AS CHAR FORMAT "x(35)" INIT ""     
    FIELD comdat        AS CHAR FORMAT "x(10)" INIT ""  
    FIELD expdat        AS CHAR FORMAT "x(10)" INIT "" 
    FIELD firstdat      AS CHAR FORMAT "x(10)" INIT "" 
    FIELD trandat       AS CHAR FORMAT "x(10)" INIT "" 
    FIELD agent         AS CHAR FORMAT "x(10)" INIT ""   
    FIELD producer      AS CHAR FORMAT "x(10)" INIT ""   
    FIELD vatcode       AS CHAR FORMAT "x(10)" INIT "" 
    /*FIELD prempa        AS CHAR FORMAT "x" INIT ""  */     
    FIELD subclass      AS CHAR FORMAT "x(4)" INIT ""   
    FIELD garage        AS CHAR FORMAT "x"  INIT "" 
    FIELD covcod        AS CHAR FORMAT "x"  INIT "" 
    FIELD tariff        AS CHAR FORMAT "x" INIT "9"
    FIELD redbook       AS CHAR INIT "" FORMAT "X(10)"
    FIELD brand         AS CHAR FORMAT "x(30)" INIT ""             
    FIELD model         AS CHAR FORMAT "x(50)" INIT ""  
    FIELD body          AS CHAR FORMAT "x(30)" INIT ""
    FIELD engcc         AS CHAR FORMAT "x(5)"  INIT ""
    FIELD Tonn          AS DECI FORMAT ">>,>>9.99-" 
    FIELD seat          AS CHAR FORMAT "x(2)"  INIT "" 
    FIELD cargrp        AS CHAR FORMAT "x"     INIT ""  
    FIELD vehreg        AS CHAR FORMAT "x(11)" INIT "" 
    FIELD chasno        AS CHAR FORMAT "x(25)" INIT ""
    FIELD eng           AS CHAR FORMAT "x(25)" INIT ""           
    FIELD caryear       AS CHAR FORMAT "x(4)"  INIT ""   
    FIELD vehuse        AS CHAR INIT "" FORMAT "x"
    FIELD benname       AS CHAR FORMAT "x(65)" INIT "" 
    FIELD seat41        AS INTE FORMAT "99" INIT 0
    FIELD ncb           AS CHAR FORMAT "x(10)" INIT ""  
    FIELD fleet         AS CHAR FORMAT "x(10)" INIT ""   
    FIELD si            AS CHAR FORMAT "x(15)" INIT ""  
    FIELD stk           AS CHAR FORMAT "x(25)" INIT ""  
    FIELD NO_41         AS CHAR FORMAT "x(14)" INIT ""  
    FIELD NO_42         AS CHAR FORMAT "x(14)" INIT ""   
    FIELD NO_43         AS CHAR FORMAT "x(14)" INIT ""   
    FIELD compul        AS CHAR FORMAT "x"     INIT ""   
    FIELD comment       AS CHAR FORMAT "x(512)" INIT ""
    FIELD pass          AS CHAR FORMAT "x"      INIT "n" 
    FIELD WARNING       AS CHAR FORMAT "X(30)"  INIT ""
    FIELD OK_GEN        AS CHAR FORMAT "X"      INIT "Y" 
    FIELD premt         AS CHAR FORMAT "x(15)" INIT ""  
    FIELD comp_prm      AS CHAR FORMAT "x(15)" INIT ""  
    FIELD cndat         AS CHAR FORMAT "x(10)" INIT ""  
    FIELD nv_com1p      LIKE sicuw.uwm120.com1p 
    FIELD n_taxae       LIKE sicuw.uwm120.taxae 
    FIELD n_stmpae      LIKE sicuw.uwm120.stmpae
    FIELD n_com2ae      LIKE sicuw.uwm120.com2ae
    FIELD n_com1ae      LIKE sicuw.uwm120.com1ae
    FIELD nv_fi_rstp_t  LIKE sicuw.uwm120.rstp_r
    FIELD nv_fi_rtax_t  LIKE sicuw.uwm120.rtax_r
   /* FIELD rstp_t        AS CHAR FORMAT "x(14)" INIT "" */ 
   /* FIELD rtax_t        AS CHAR FORMAT "x(14)" INIT "" */ 
    FIELD prem_r        AS CHAR FORMAT "x(14)" INIT "" 
    FIELD comper        AS CHAR FORMAT "x(14)" INIT ""   
    FIELD comacc        AS CHAR FORMAT "x(14)" INIT ""   
    FIELD deductpd      AS CHAR FORMAT "X(14)" INIT "" 
    FIELD tp1           AS CHAR FORMAT "X(14)" INIT "" 
    FIELD tp2           AS CHAR FORMAT "X(14)" INIT "" 
    FIELD tp3           AS CHAR FORMAT "X(14)" INIT "" 
    FIELD entdat        AS CHAR FORMAT "x(10)" INIT ""      
    FIELD enttim        AS CHAR FORMAT "x(8)"   INIT ""       
    FIELD trantim       AS CHAR FORMAT "x(8)"   INIT ""       
    FIELD n_IMPORT      AS CHAR FORMAT "x(2)"   INIT ""       
    FIELD n_EXPORT      AS CHAR FORMAT "x(2)"   INIT "" 
    FIELD cr_2          AS CHAR FORMAT "x(32)"   INIT ""  
    FIELD docno         AS CHAR INIT "" FORMAT "x(10)" 
    FIELD drivnam       AS CHAR FORMAT "x"       INIT "n" 
    FIELD cancel        AS CHAR FORMAT "x(2)"    INIT ""    
    FIELD accdat        AS CHAR INIT "" FORMAT "x(10)" 
    FIELD commission    AS CHAR FORMAT "x(10)" INIT ""  
    FIELD nomn30        AS CHAR FORMAT "x(60)" INIT ""   /* A57-0302 */
    FIELD occup         AS CHAR FORMAT "x(100)" INIT ""   /* A59-09999  add kridtiya i. date. 23/05/2016  */
    FIELD firstName     AS CHAR FORMAT "x(60)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD lastName      AS CHAR FORMAT "x(60)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD postcd        AS CHAR FORMAT "x(15)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD icno          AS CHAR FORMAT "x(15)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeocc       AS CHAR FORMAT "x(4)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr1     AS CHAR FORMAT "x(2)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr2     AS CHAR FORMAT "x(2)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr3     AS CHAR FORMAT "x(2)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD br_insured    AS CHAR FORMAT "x(5)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD campaign_ov   AS CHAR FORMAT "x(30)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/   
    FIELD product       AS CHAR FORMAT "x(30)" INIT "".  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
def var  s_recid3_1       as recid .     /* uwm130  */ /*Add kridtiya i. A56-0151*/ 
DEF VAR  nv_chkerror      AS CHAR FORMAT "x(100)".     /*Add kridtiya i. A56-0151*/ 

DEF NEW SHARED    VAR nv_message AS char.
DEF               VAR nv_riskgp  LIKE sic_bran.uwm120.riskgp      NO-UNDO.
DEFINE NEW SHARED VAR NO_basemsg AS CHAR  FORMAT "x(50)" .        
DEFINE            VAR nv_accdat  AS DATE  FORMAT "99/99/9999"     INIT ?  .     
DEFINE            VAR nv_docno   AS CHAR  FORMAT "9999999"        INIT " ".
DEFINE NEW SHARED VAR  nv_batchyr   AS INT FORMAT "9999"          INIT 0.
DEFINE NEW SHARED VAR  nv_batcnt    AS INT FORMAT "99"            INIT 0.
DEFINE NEW SHARED VAR  nv_batchno   AS CHARACTER FORMAT "X(13)"   INIT ""  NO-UNDO.
DEFINE VAR  nv_batrunno  AS INT FORMAT  ">,>>9"          INIT 0.
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
DEFINE VAR  nn_cr2       AS CHAR FORMAT "x(15)".
DEFINE VAR  nn_subclass  AS CHAR FORMAT "x(4)" .  
DEFINE VAR  nn_subclass2 AS CHAR FORMAT "x(4)" . 
DEFINE VAR  nn_covcod    AS CHAR FORMAT "x" .                
DEFINE VAR  nn_garage    AS CHAR FORMAT "x" .                
DEFINE VAR  nn_redbook   AS CHAR FORMAT "x(10)" .            
DEFINE VAR  nn_brand     AS CHAR FORMAT "x(30)" INIT "" .    
DEFINE VAR  nn_model     AS CHAR FORMAT "x(50)" INIT "" .    
DEFINE VAR  nn_body      AS CHAR FORMAT "x(30)" INIT "" .    
DEFINE VAR  nn_engcc     AS CHAR FORMAT "x(5)"  INIT "" .    
DEFINE VAR  nn_tonn      AS DECI FORMAT ">>,>>9.99-" .       
DEFINE VAR  nn_seat      AS CHAR FORMAT "x(2)"  .            
DEFINE VAR  nn_seat41    AS INTE FORMAT "99"  .            
DEFINE VAR  nn_cargrp    AS CHAR FORMAT "x"     .            
DEFINE VAR  nn_vehreg    AS CHAR FORMAT "x(10)".             
DEFINE VAR  nn_eng       AS CHAR FORMAT "x(25)".             
DEFINE VAR  nn_chasno    AS CHAR FORMAT "x(25)".             
DEFINE VAR  nn_caryear   AS CHAR FORMAT "x(4)"  .            
DEFINE VAR  nn_vehuse    AS CHAR INIT "" FORMAT "x".         
DEFINE VAR  nn_comdat    AS DATE FORMAT "99/99/9999".        
DEFINE VAR  nn_firstdat  AS DATE FORMAT "99/99/9999".  
DEF VAR n_yearpol        AS CHAR FORMAT "X(2)" INIT "".
DEF VAR nn_acno        LIKE sicsyac.xtm600.acno  .
DEF VAR nn_name        LIKE sicsyac.xtm600.name.  
DEF VAR nn_addr1       LIKE sicsyac.xtm600.addr1 .
DEF VAR nn_addr2       LIKE sicsyac.xtm600.addr2 .
DEF VAR nn_addr3       LIKE sicsyac.xtm600.addr3 .
DEF VAR nn_addr4       LIKE sicsyac.xtm600.addr4 .
DEF VAR nn_ntitle      LIKE sicsyac.xtm600.ntitle .
DEF VAR nv_com1p70     LIKE sicuw.uwm120.com1p. 
DEF VAR nv_taxae70     LIKE sicuw.uwm120.taxae .
DEF VAR nv_stmpae70    LIKE sicuw.uwm120.stmpae.
DEF VAR nv_com2ae70    LIKE sicuw.uwm120.com2ae.
DEF VAR nv_com1ae70    LIKE sicuw.uwm120.com1ae. 
DEF VAR nv_fi_rstp_t70 LIKE sicuw.uwm120.rstp_r. 
DEF VAR nv_fi_rtax_t70 LIKE sicuw.uwm120.rtax_r.  
DEF VAR n_si           LIKE sicuw.uwm130.uom6_v. 
DEF VAR n_tp1          LIKE sicuw.uwm130.uom1_v .                                                  
DEF VAR N_tp2          LIKE sicuw.uwm130.uom2_v.
DEF VAR n_tp3          LIKE sicuw.uwm130.uom5_v.
DEF VAR nv_com1p72     LIKE sicuw.uwm120.com1p .
DEF VAR nv_taxae72     LIKE sicuw.uwm120.taxae .
DEF VAR nv_stmpae72    LIKE sicuw.uwm120.stmpae.
DEF VAR nv_com2ae72    LIKE sicuw.uwm120.com2ae.
DEF VAR nv_com1ae72    LIKE sicuw.uwm120.com1ae.
DEF VAR nv_fi_rstp_t72 LIKE sicuw.uwm120.rstp_r.
DEF VAR nv_fi_rtax_t72 LIKE sicuw.uwm120.rtax_r. 
DEF VAR n_comp_prm     LIKE sicuw.uwd132.gap_c . 
DEF VAR n_premt        LIKE sicuw.uwd132.prem_c.
DEFINE NEW SHARED WORKFILE wacctext
    FIELD n_policytxt  AS CHAR  INIT "" FORMAT "x(100)"  /*Add kridtiya i. A56-0151*/
    FIELD n_textacc    AS CHAR  INIT "" FORMAT "x(100)"  /*Add kridtiya i. A56-0151*/
    FIELD n_textacc1   AS CHAR  INIT "" FORMAT "x(100)"  /*Add kridtiya i. A56-0151*/
    FIELD n_textacc2   AS CHAR  INIT "" FORMAT "x(100)"  /*Add kridtiya i. A56-0151*/
    FIELD n_textacc3   AS CHAR  INIT "" FORMAT "x(100)"  /*Add kridtiya i. A56-0151*/
    FIELD n_textacc4   AS CHAR  INIT "" FORMAT "x(100)"  /*Add kridtiya i. A56-0151*/
    FIELD n_textacc5   AS CHAR  INIT "" FORMAT "x(100)"  /*Add kridtiya i. A56-0151*/
    FIELD n_textacc6   AS CHAR  INIT "" FORMAT "x(100)"  /*Add kridtiya i. A56-0151*/
    FIELD n_textacc7   AS CHAR  INIT "" FORMAT "x(100)"  /*Add kridtiya i. A56-0151*/
    FIELD n_textacc8   AS CHAR  INIT "" FORMAT "x(100)"  /*Add kridtiya i. A56-0151*/ 
    FIELD n_textacc9   AS CHAR  INIT "" FORMAT "x(100)"  /*Add kridtiya i. A56-0151*/ .
DEFINE NEW SHARED WORKFILE wuppertxt NO-UNDO
       FIELD policy   AS CHAR      FORMAT "x(12)"
/*1*/  FIELD line     AS INTEGER   FORMAT ">>9"
/*2*/  FIELD txt      AS CHARACTER FORMAT "X(78)"   INITIAL "".
DEFINE NEW SHARED  WORKFILE wuppertxt3 NO-UNDO
       FIELD policy   AS CHAR      FORMAT "x(12)"
/*1*/  FIELD line     AS INTEGER   FORMAT ">>9"
/*2*/  FIELD txt      AS CHARACTER FORMAT "X(78)"   INITIAL "".
DEFINE VAR nvw_bptr   AS RECID.
DEFINE VAR sv_fptr    AS RECID no-undo.
DEFINE VAR sv_bptr    AS RECID no-undo.     
/* DEFINE VAR nvw_bptr        AS RECID.                   */
DEFINE VAR nvw_fptr   AS RECID.                   
DEFINE VAR nvw_index  AS INTEGER.                 
DEFINE VAR nvw_dl     AS INTEGER INITIAL[14].     
DEFINE VAR nvw_prev   AS RECID INITIAL[0].       
DEFINE VAR nvw_next   AS RECID INITIAL[0].       
DEFINE VAR nvw_list   AS LOGICAL INITIAL[YES].
DEF    VAR n_num1     AS INTE INIT 0.
DEF    VAR n_num2     AS INTE INIT 0.
DEF    VAR n_num3     AS INTE INIT 1.
DEF    VAR i          AS INTE INIT 0.
DEF    VAR n_text1    AS CHAR FORMAT "x(255)".
DEF    VAR n_numtxt   AS INTE INIT 0.
DEF BUFFER wf_uwd100  FOR sic_bran.uwd100.
DEF    VAR nv_occup         AS CHAR FORMAT "x(100)" INIT "".  /* A59-0186  add kridtiya i. date. 23/05/2016  */
def var nn_firstName  AS CHAR INIT "".   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
def var nn_lastName   AS CHAR INIT "".   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
def var nn_postcd     AS CHAR INIT "".   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
def var nn_icno       AS CHAR INIT "".   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
def var nn_codeocc    AS CHAR INIT "".   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
def var nn_codeaddr1  AS CHAR INIT "".   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
def var nn_codeaddr2  AS CHAR INIT "".   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
def var nn_codeaddr3  AS CHAR INIT "".   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
def var nn_br_insured AS CHAR INIT "".   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/

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

