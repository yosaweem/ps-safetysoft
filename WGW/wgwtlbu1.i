/*programid   : wgwtlbu1.i                                                             */ 
/*programname : Load Text & Generate text file BU1                                     */ 
/*Copyright   : Safety Insurance Public Company Limited 			                   */ 
/*			    บริษัท ประกันคุ้มภัย จำกัด (มหาชน)				                       */ 
/*create by   : Kridtiya i. A57-0430 date. 03/12/2014                                  
                ปรับโปรแกรมให้สามารถนำเข้า Load Text & Generate data                    */ 
/*Modify by   : Kridtiya i. A58-0053 เพิ่ม การให้ค่า Deduct */  
/*Modify by   : Ranu I. A60-0214 date: 08/05/2017 เพิ่มตัวแปรเก็บค่า discount , satff ,Load Claim , Base3 */            
/*Modify by   : Kridtiya i. A63-0472 Date. 09/11/2020 add field firstname ,lastname.....*/
/*Modify by  : Ranu I. A64-0138 เพิ่มตัวแปรเก็บข้อมูลการคำนวณเบี้ย */
/***************************************************************************************/
DEFINE NEW SHARED TEMP-TABLE wdetail
    FIELD number      AS CHAR FORMAT "x(5)"   INIT ""   
    FIELD policy      AS CHAR FORMAT "x(20)"  INIT ""   
    FIELD covcod      AS CHAR FORMAT "x(3)"   INIT ""   
    FIELD producer    AS CHAR FORMAT "x(10)"  INIT ""   
    FIELD agent       AS CHAR FORMAT "x(10)"  INIT ""   
    FIELD inserf      AS CHAR FORMAT "x(10)"  INIT ""   
    FIELD vatcode     AS CHAR FORMAT "x(10)"  INIT ""   
    FIELD textf7      AS CHAR FORMAT "x(100)" INIT ""  
    FIELD textf5      AS CHAR FORMAT "x(100)" INIT ""  
    FIELD commission  AS CHAR FORMAT "x(5)"   INIT "" 
    FIELD class       AS CHAR FORMAT "x(5)"   INIT ""   
    FIELD uom1_v      AS CHAR FORMAT "x(20)"  INIT ""   
    FIELD uom2_v      AS CHAR FORMAT "x(20)"  INIT ""   
    FIELD uom5_v      AS CHAR FORMAT "x(20)"  INIT ""   
    FIELD si          AS CHAR FORMAT "x(20)"  INIT ""   
    FIELD fi          AS CHAR FORMAT "x(20)"  INIT ""   
    FIELD nv_41       AS CHAR FORMAT "x(20)"  INIT ""   
    FIELD nv_412      AS CHAR FORMAT "x(20)"  INIT "" 
    FIELD nv_42       AS CHAR FORMAT "x(20)"  INIT ""   
    FIELD nv_43       AS CHAR FORMAT "x(20)"  INIT ""   
    FIELD base        AS CHAR FORMAT "x(20)"  INIT ""   
    FIELD vehreg      AS CHAR FORMAT "x(11)"  INIT ""   
    FIELD brand       AS CHAR FORMAT "x(60)"  INIT ""   
    FIELD model       AS CHAR FORMAT "x(50)"  INIT ""   
    FIELD chassis     AS CHAR FORMAT "x(30)"  INIT ""   
    FIELD engno       AS CHAR FORMAT "x(30)"  INIT ""   
    FIELD caryear     AS CHAR FORMAT "x(5)"   INIT ""   
    FIELD comdat      AS CHAR FORMAT "x(10)"  INIT ""  
    FIELD expdat      AS CHAR FORMAT "x(10)"   INIT "" 
    FIELD n_rencnt    LIKE sicuw.uwm100.rencnt INITIAL ""
    FIELD n_endcnt    LIKE sicuw.uwm100.endcnt INITIAL ""
    FIELD n_branch    AS CHAR FORMAT "x(2)"    INIT "" 
    FIELD poltyp      AS CHAR FORMAT "x(3)"    INIT "" 
    FIELD tiname      AS CHAR FORMAT "x(20)"   INIT "" 
    FIELD insnam      AS CHAR FORMAT "x(60)"   INIT ""  
    FIELD name2       AS CHAR FORMAT "x(60)"   INIT ""    
    FIELD name3       AS CHAR FORMAT "x(60)"   INIT ""    
    FIELD occup       AS CHAR FORMAT "x(40)"   INIT ""
    FIELD n_addr1     AS CHAR FORMAT "x(35)"   INIT ""     
    FIELD n_addr2     AS CHAR FORMAT "x(35)"   INIT ""     
    FIELD n_addr3     AS CHAR FORMAT "x(35)"   INIT ""     
    FIELD n_addr4     AS CHAR FORMAT "x(35)"   INIT ""     
    FIELD firstdat    AS CHAR FORMAT "x(10)"   INIT "" 
    FIELD trandat     AS CHAR FORMAT "x(10)"   INIT "" 
    FIELD garage      AS CHAR FORMAT "x"       INIT "" 
    FIELD tariff      AS CHAR FORMAT "x"       INIT "9"
    FIELD redbook     AS CHAR FORMAT "X(10)"   INIT ""      
    FIELD body        AS CHAR FORMAT "x(30)"   INIT ""
    FIELD engcc       AS CHAR FORMAT "x(10)"    INIT ""
    FIELD Tonn        AS DECI FORMAT ">>,>>9.99-" 
    FIELD seat        AS CHAR FORMAT "x(2)"    INIT "" 
    FIELD cargrp      AS CHAR FORMAT "x"       INIT ""  
    FIELD vehuse      AS CHAR INIT "" FORMAT "x"
    FIELD benname     AS CHAR FORMAT "x(65)"   INIT "" 
    FIELD prmtxt      AS CHAR FORMAT "x(100)"  INIT ""
    FIELD seat41      AS INTE FORMAT "99"      INIT 0
    FIELD ncb         AS CHAR FORMAT "x(10)"   INIT ""  
    FIELD fleet       AS CHAR FORMAT "x(10)"   INIT "" 
    FIELD dspc        AS CHAR FORMAT "x(10)"   INIT ""
    FIELD discount    AS CHAR FORMAT "x(10)"   INIT ""  
    FIELD stk         AS CHAR FORMAT "x(25)"   INIT ""  
    FIELD compul      AS CHAR FORMAT "x"       INIT ""   
    FIELD comment     AS CHAR FORMAT "x(512)"  INIT ""
    FIELD pass        AS CHAR FORMAT "x"       INIT "n" 
    FIELD WARNING     AS CHAR FORMAT "X(30)"   INIT ""
    FIELD OK_GEN      AS CHAR FORMAT "X"       INIT "Y" 
    FIELD premt       AS CHAR FORMAT "x(15)"   INIT ""  
    FIELD comp_prm    AS CHAR FORMAT "x(15)"   INIT ""  
    FIELD cndat       AS CHAR FORMAT "x(10)"   INIT ""  
    FIELD prepol      AS CHAR FORMAT "x(16)"   INIT ""   
    FIELD prem_r        AS CHAR FORMAT "x(14)" INIT "" 
    FIELD prem_nap      AS CHAR FORMAT "x(14)" INIT ""    /*A57-0426 */
    FIELD comper        AS CHAR FORMAT "x(14)" INIT ""   
    FIELD comacc        AS CHAR FORMAT "x(14)" INIT "" 
    FIELD enttim        AS CHAR FORMAT "x(8)"   INIT ""       
    FIELD trantim       AS CHAR FORMAT "x(8)"   INIT ""       
    FIELD n_IMPORT      AS CHAR FORMAT "x(2)"   INIT ""       
    FIELD n_EXPORT      AS CHAR FORMAT "x(2)"   INIT "" 
    FIELD cr_2          AS CHAR FORMAT "x(12)"   INIT ""  
    FIELD docno         AS CHAR INIT "" FORMAT "x(10)" 
    FIELD drivnam       AS CHAR FORMAT "x"       INIT "n" 
    FIELD cancel        AS CHAR FORMAT "x(2)"    INIT ""    
    /*FIELD nv_icno       AS CHAR INIT "" FORMAT "x(15)"  */
    FIELD accdat        AS CHAR INIT "" FORMAT "x(10)"  
    FIELD ICNO          AS CHAR INIT "" FORMAT "x(15)" 
    FIELD staff         AS CHAR FORMAT "x(15)" INIT ""       /*A60-0214*/
    FIELD loadcl        AS CHAR FORMAT "x(15)" INIT ""       /*A60-0214*/
    FIELD base3         AS CHAR FORMAT "x(15)" INIT ""       /*A60-0214*/
    FIELD insnamtyp     AS CHAR FORMAT "x(60)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD firstName     AS CHAR FORMAT "x(60)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD lastName      AS CHAR FORMAT "x(60)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD postcd        AS CHAR FORMAT "x(15)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeocc       AS CHAR FORMAT "x(4)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr1     AS CHAR FORMAT "x(2)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr2     AS CHAR FORMAT "x(2)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr3     AS CHAR FORMAT "x(2)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD br_insured    AS CHAR FORMAT "x(5)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD campaign_ov   AS CHAR FORMAT "x(30)" INIT "" .  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 

DEF    NEW SHARED VAR  nv_message AS char.
DEF               VAR  nv_riskgp  LIKE sic_bran.uwm120.riskgp NO-UNDO.
DEFINE NEW SHARED VAR  NO_basemsg AS CHAR  FORMAT "x(50)" .      
DEFINE            VAR  nv_accdat  AS DATE  FORMAT "99/99/9999" INIT ?  .     
DEFINE            VAR  nv_docno   AS CHAR  FORMAT "9999999"    INIT " ".
DEFINE NEW SHARED VAR  nv_batchyr   AS INT FORMAT "9999"            INIT 0.
DEFINE NEW SHARED VAR  nv_batcnt    AS INT FORMAT "99"              INIT 0.
DEFINE NEW SHARED VAR  nv_batchno   AS CHARACTER FORMAT "X(20)"     INIT ""  NO-UNDO.
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
DEFINE VAR  nn_cr2       AS CHAR FORMAT "x(15)".
DEFINE VAR  nn_subclass  AS CHAR FORMAT "x(4)" .  
DEFINE VAR  nn_subclass2 AS CHAR FORMAT "x(4)" . 
DEFINE VAR  nn_covcod    AS CHAR FORMAT "x(3)" .                
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
DEFINE VAR  nn_vehreg    AS CHAR FORMAT "x(11)".   
DEFINE VAR  nn_caryear   AS CHAR FORMAT "x(4)"  .            
DEFINE VAR  nn_vehuse    AS CHAR INIT "" FORMAT "x".         
DEFINE VAR  nn_comdat    AS DATE FORMAT "99/99/9999".        
DEFINE VAR  nn_firstdat  AS DATE FORMAT "99/99/9999".  
DEFINE VAR  n_yearpol    AS CHAR FORMAT "X(2)" INIT "".
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
DEF VAR n_idno       AS CHAR  INIT "" FORMAT "x(10)".
DEF VAR np_prepol    AS CHAR  INIT "" FORMAT "x(12)".  
DEF VAR np_prepol72  AS CHAR  INIT "" FORMAT "x(12)".  
DEF VAR np_icno      AS CHAR FORMAT "x(15)" .  
DEF VAR np_title     AS CHAR FORMAT "x(20)" .  
DEF VAR np_name1     AS CHAR FORMAT "x(60)" .  
DEF VAR np_name2     AS CHAR FORMAT "x(60)"  .  
DEF VAR np_name3     AS CHAR FORMAT "x(60)" .  
DEF VAR np_addr1     AS CHAR FORMAT "x(35)" INIT "" .
DEF VAR np_addr2     AS CHAR FORMAT "x(35)" INIT "" .
DEF VAR np_addr3     AS CHAR FORMAT "x(35)" INIT "" .
DEF VAR np_addr4     AS CHAR FORMAT "x(35)" INIT "" .
DEF VAR np_occupn    AS CHAR FORMAT "x(40)"  .  
DEF VAR np_moddes    AS CHAR FORMAT "x(65)".
DEF VAR np_vehgrp    AS CHAR FORMAT "x"  .
DEF VAR np_body      AS CHAR FORMAT "x(20)". 
DEF VAR np_dedod     AS CHAR FORMAT "x(30)"  INIT "" .
DEF VAR np_addod     AS CHAR FORMAT "x(30)"  INIT "" .  
DEF VAR np_dedpd     AS CHAR FORMAT "x(30)"  INIT "" . 
DEF VAR np_stf_per   AS CHAR FORMAT "x(30)"  INIT "" .
DEF VAR np_cl_per    AS CHAR FORMAT "x(30)"  INIT "" .
DEF VAR nn_dedod     AS CHAR FORMAT "x(30)"  INIT "" .
DEF VAR nn_addod     AS CHAR FORMAT "x(30)"  INIT "" .  
DEF VAR nn_dedpd     AS CHAR FORMAT "x(30)"  INIT "" . 
DEF VAR nn_stf_per   AS CHAR FORMAT "x(30)"  INIT "" .
DEF VAR nn_cl_per    AS CHAR FORMAT "x(30)"  INIT "" .
DEF VAR np_insref    AS CHAR  INIT "" FORMAT "x(10)".
DEF VAR n_policy70   AS CHAR  INIT "" FORMAT "x(12)".
DEF VAR n_policy72   AS CHAR  INIT "" FORMAT "x(12)".
DEF VAR n_branch     AS CHAR  INIT "" FORMAT "x(2)".
DEF VAR n_cover      AS CHAR  INIT "" FORMAT "x(3)".
DEF VAR n_textf5     AS CHAR  INIT "" FORMAT "x(150)".
DEF VAR n_textf52     AS CHAR  INIT "" FORMAT "x(150)".
DEF VAR n_textf53     AS CHAR  INIT "" FORMAT "x(150)".
DEF VAR n_textf7     AS CHAR  INIT "" FORMAT "x(150)".
DEF VAR n_textf72     AS CHAR  INIT "" FORMAT "x(150)".
DEF VAR n_textf73     AS CHAR  INIT "" FORMAT "x(150)".
DEF VAR n_com70      AS CHAR  INIT "" FORMAT "x(10)".
DEF VAR n_com72      AS CHAR  INIT "" FORMAT "x(10)".
DEF VAR n_class70    AS CHAR  INIT "" FORMAT "x(5)".
DEF VAR n_class72    AS CHAR  INIT "" FORMAT "x(5)".
DEF VAR n_seat1      AS CHAR  INIT "" FORMAT "x(5)".
DEF VAR n_Engine     AS CHAR  INIT "" FORMAT "x(10)".   /*A57-0195*/
DEF VAR n_Tonnage    AS CHAR  INIT "" FORMAT "x(10)".   /*A57-0195*/
DEF VAR n_bennams    AS CHAR  INIT "" FORMAT "x(100)".  /*A57-0195*/
DEF VAR n_uom1_v     AS CHAR  INIT "" FORMAT "x(15)".
DEF VAR n_uom2_v     AS CHAR  INIT "" FORMAT "x(15)".
DEF VAR n_uom5_v     AS CHAR  INIT "" FORMAT "x(15)".
DEF VAR n_siins      AS CHAR  INIT "" FORMAT "x(15)".
DEF VAR n_fi         AS CHAR  INIT "" FORMAT "x(15)".
DEF VAR n_nv_41      AS CHAR  INIT "" FORMAT "x(15)".
DEF VAR n_nv_412     AS CHAR  INIT "" FORMAT "x(15)".
DEF VAR n_nv_42      AS CHAR  INIT "" FORMAT "x(15)".
DEF VAR n_nv_43      AS CHAR  INIT "" FORMAT "x(15)".
DEF VAR n_ncb        AS CHAR  INIT "" FORMAT "x(15)".
DEF VAR n_feet       AS CHAR  INIT "" FORMAT "x(15)".
DEF VAR n_dspc       AS CHAR  INIT "" FORMAT "x(15)".
DEF VAR n_discount   AS CHAR  INIT "" FORMAT "x(10)".   /*A60-0214*/
DEF VAR n_staff      AS CHAR  INIT "" FORMAT "x(15)".   /*A60-0214*/
DEF VAR n_loadcl     AS CHAR  INIT "" FORMAT "x(15)".   /*A60-0211*/
DEF VAR n_dod1       AS CHAR FORMAT "x(10)"   INIT "".
DEF VAR n_dod2       AS CHAR FORMAT "x(10)"   INIT "".
DEF VAR n_dod3       AS CHAR FORMAT "x(10)"   INIT "".
DEF VAR n_base       AS CHAR  INIT "" FORMAT "x(15)".
DEF VAR n_base3      AS CHAR  INIT "" FORMAT "x(15)".   /*A60-0214*/
DEF VAR n_nap        AS CHAR  INIT "" FORMAT "x(15)".
DEF VAR n_vehreg     AS CHAR  INIT "" FORMAT "x(11)".
DEF VAR n_brand1     AS CHAR  INIT "" FORMAT "x(30)".
DEF VAR n_model1     AS CHAR  INIT "" FORMAT "x(60)".
DEF VAR n_body       AS CHAR  INIT "" FORMAT "x(30)".   /*kridtiya i. 19/11/2014*/
DEF VAR n_seat_41    AS CHAR  INIT "" FORMAT "x(30)".   /*kridtiya i. 19/11/2014*/
DEF VAR n_chassis    AS CHAR  INIT "" FORMAT "x(30)".
DEF VAR n_engno      AS CHAR  INIT "" FORMAT "x(30)".
DEF VAR n_caryear    AS CHAR  INIT "" FORMAT "x(5)".
DEF VAR n_comdat1    AS CHAR  INIT "" FORMAT "x(10)".
DEF VAR n_expdat1    AS CHAR  INIT "" FORMAT "x(10)".
DEF VAR n_comdat72   AS CHAR  INIT "" FORMAT "x(10)".  
DEF VAR n_expdat72   AS CHAR  INIT "" FORMAT "x(10)".  
DEF VAR n_benname    AS CHAR  INIT "" FORMAT "x(100)".   
DEF VAR n_textacc    AS CHAR  INIT "" FORMAT "x(100)".
DEF VAR n_garage     AS CHAR  INIT "" FORMAT "x(1)" .
DEF VAR nf_vehuse70  AS CHAR  INIT "" FORMAT "x" .    
DEF VAR nf_vehuse72  AS CHAR  INIT "" FORMAT "x" .    
DEFINE NEW SHARED VAR no_baseprm AS DECI  FORMAT ">>,>>>,>>9.99-".  
DEF VAR n_textacc1    AS CHAR  INIT "" FORMAT "x(100)". 
DEF VAR n_textacc2    AS CHAR  INIT "" FORMAT "x(100)". 
DEF VAR n_textacc3    AS CHAR  INIT "" FORMAT "x(100)". 
DEF VAR n_textacc4    AS CHAR  INIT "" FORMAT "x(100)". 
DEF VAR n_textacc5    AS CHAR  INIT "" FORMAT "x(100)". 
DEF VAR n_textacc6    AS CHAR  INIT "" FORMAT "x(100)". 
DEF VAR n_textacc7    AS CHAR  INIT "" FORMAT "x(100)". 
DEF VAR n_textacc8    AS CHAR  INIT "" FORMAT "x(100)". 
DEF VAR n_textacc9    AS CHAR  INIT "" FORMAT "x(100)".  
DEFINE WORKFILE wacctext
    FIELD n_policytxt   AS CHAR  INIT "" FORMAT "x(100)" 
    FIELD n_textacc    AS CHAR  INIT "" FORMAT "x(100)"  
    FIELD n_textacc1   AS CHAR  INIT "" FORMAT "x(100)"  
    FIELD n_textacc2   AS CHAR  INIT "" FORMAT "x(100)"  
    FIELD n_textacc3   AS CHAR  INIT "" FORMAT "x(100)"  
    FIELD n_textacc4   AS CHAR  INIT "" FORMAT "x(100)"  
    FIELD n_textacc5   AS CHAR  INIT "" FORMAT "x(100)"  
    FIELD n_textacc6   AS CHAR  INIT "" FORMAT "x(100)"  
    FIELD n_textacc7   AS CHAR  INIT "" FORMAT "x(100)"  
    FIELD n_textacc8   AS CHAR  INIT "" FORMAT "x(100)"   
    FIELD n_textacc9   AS CHAR  INIT "" FORMAT "x(100)"   .
DEFINE WORKFILE wacctext15
    FIELD n_policytxt15   AS CHAR  INIT "" FORMAT "x(100)" 
    FIELD n_textacc1      AS CHAR  INIT "" FORMAT "x(100)"  
    FIELD n_textacc2      AS CHAR  INIT "" FORMAT "x(100)"  
    FIELD n_textacc3      AS CHAR  INIT "" FORMAT "x(100)"  .
DEFINE WORKFILE wacctext17
    FIELD n_policytxt17   AS CHAR  INIT "" FORMAT "x(100)" 
    FIELD n_textacc1      AS CHAR  INIT "" FORMAT "x(100)"  
    FIELD n_textacc2      AS CHAR  INIT "" FORMAT "x(100)"  
    FIELD n_textacc3      AS CHAR  INIT "" FORMAT "x(100)"  .
DEFINE VAR  re_comdat    AS CHAR FORMAT "x(10)" INIT "" .        
DEFINE VAR  re_expdat    AS CHAR FORMAT "x(10)" INIT "" .        
DEFINE VAR  re_class     AS CHAR FORMAT "x(4)"      . 
DEFINE VAR  re_moddes    AS CHAR FORMAT "x(65)".                 
DEFINE VAR  re_yrmanu    AS CHAR FORMAT "x(5)".
DEFINE VAR  re_seats     AS CHAR FORMAT "x(2)"   INIT "" .       
DEFINE VAR  re_vehuse    AS CHAR FORMAT "x"      INIT "" .       
DEFINE VAR  re_covcod    AS CHAR FORMAT "x(3)"      INIT "" .       
DEFINE VAR  re_garage    AS CHAR FORMAT "x"      INIT "" .       
DEFINE VAR  re_vehreg    AS CHAR FORMAT "x(11)"  INIT "" .       
DEFINE VAR  re_cha_no    AS CHAR FORMAT "x(30)"  INIT "" .       
DEFINE VAR  re_eng_no    AS CHAR FORMAT "x(30)"  INIT "" .       
DEFINE VAR  re_uom1_v    AS CHAR FORMAT "x(30)"  INIT "" .       
DEFINE VAR  re_uom2_v    AS CHAR FORMAT "x(30)"  INIT "" .       
DEFINE VAR  re_uom5_v    AS CHAR FORMAT "x(30)"  INIT "" .       
DEFINE VAR  re_si        AS CHAR FORMAT "x(30)"  INIT "" .       
DEFINE VAR  re_baseprm   AS DECI FORMAT ">>>,>>>,>>9.99-"  .     
DEFINE VAR  re_41        AS DECI FORMAT ">>>,>>>,>>9.99-"  .   
DEFINE VAR  re_412       AS DECI FORMAT ">>>,>>>,>>9.99-"  . 
DEFINE VAR  re_42        AS DECI FORMAT ">>>,>>>,>>9.99-"  .     
DEFINE VAR  re_43        AS DECI FORMAT ">>>,>>>,>>9.99-"  .     
DEFINE VAR  re_seat41    AS DECI FORMAT ">>,>>9.99-"   .         
DEFINE VAR  re_dedod     AS DECI FORMAT ">>>,>>>,>>9.99-"  .     
DEFINE VAR  re_addod     AS DECI FORMAT ">>>,>>>,>>9.99-"  .     
DEFINE VAR  re_dedpd     AS DECI FORMAT ">>>,>>>,>>9.99-"  .     
DEFINE VAR  re_flet_per  AS CHAR FORMAT "x(30)"  INIT "" .       
DEFINE VAR  re_ncbper    AS CHAR FORMAT "x(30)"  INIT "" .       
DEFINE VAR  re_dss_per   AS CHAR FORMAT "x(30)"  INIT "" .       
DEFINE VAR  re_stf_per   AS DECI FORMAT ">>>,>>>,>>9.99-"  .     
DEFINE VAR  re_cl_per    AS DECI FORMAT ">>>,>>>,>>9.99-"  .     
DEFINE VAR  re_bennam1   AS CHAR FORMAT "x(60)"  INIT ""   . 
DEFINE NEW SHARED WORKFILE wuwd132
    FIELD prepol  AS CHAR FORMAT "x(20)" INIT ""
    FIELD bencod  AS CHAR FORMAT "x(30)" INIT "" 
    FIELD benvar  AS CHAR FORMAT "x(40)" INIT "" 
    FIELD gap_c   AS DECI FORMAT ">>>,>>>,>>9.99-"    
    FIELD prem_c  AS DECI FORMAT ">>>,>>>,>>9.99-"  .  
DEFINE VAR nv_insref    AS CHARACTER FORMAT "X(10)".  
DEFINE VAR n_insref     AS CHARACTER FORMAT "X(10)". 
DEFINE VAR nv_usrid     AS CHARACTER FORMAT "X(08)".
DEFINE VAR nv_transfer  AS LOGICAL   .
DEFINE VAR n_check      AS CHARACTER .
DEFINE VAR nv_typ       AS CHAR FORMAT "X(2)".
DEFINE VAR nv_simat     AS DECI INIT 0.          /*A57-0195*/ 
DEFINE VAR nv_simat1    AS DECI INIT 0.          /*A57-0195*/ 
DEFINE VAR nv_siredbook AS DECI INIT 0.          /*A57-0195*/ 
DEFINE VAR nv_class72rd AS CHAR FORMAT "X(4)".   /*A57-0195*/ 
/*Add A58-0053 kridtiya i. Add DEDUCT */
DEFINE WORKFILE wdisdod
    FIELD policy      AS CHAR FORMAT "x(12)"   INIT ""
    FIELD n_dod1      AS CHAR FORMAT "x(10)"   INIT ""
    FIELD n_dod2      AS CHAR FORMAT "x(10)"   INIT ""
    FIELD n_dod3      AS CHAR FORMAT "x(10)"   INIT "".
/*Add A58-0053 kridtiya i. Add DEDUCT */
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
DEFINE VAR nv_chkerror  AS CHAR INIT "".  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
DEFINE VAR n_campaignov AS CHAR INIT "".  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
DEFINE VAR n_occupation AS CHAR INIT "".  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
DEFINE VAR nv_postcd    as char init "".
DEFINE VAR nv_address   as char init "".

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
DEFINE VAR nv_41prmt   AS DECI FORMAT ">>>,>>>,>>9.99-".  /* fleet */
DEFINE VAR nv_42prmt   AS DECI FORMAT ">>>,>>>,>>9.99-".  /* fleet */
DEFINE VAR nv_43prmt   AS DECI FORMAT ">>>,>>>,>>9.99-".  /* fleet */
DEFINE VAR nv_pdprem   AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_status   AS CHAR .   /*fleet YES=Complete , NO=Not Complete */
/* end A64-0138 */

