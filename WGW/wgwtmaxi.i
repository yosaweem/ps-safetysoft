/*programid  : wgwtmaxi.i                                                              */ 
/*programname: Load Text & Generate maxi                                               */ 
/*Copyright  : Safety Insurance Public Company Limited 			                       */ 
/*			   บริษัท ประกันคุ้มภัย จำกัด (มหาชน)				                       */ 
/*create by  : Kridtiya i. A58-0321 date. 25/08/2015                                  
               ปรับโปรแกรมให้สามารถนำเข้า Load Text & Generate maxi                    */ 
/***************************************************************************************/
DEFINE NEW SHARED TEMP-TABLE wdetail
    FIELD policy      AS CHAR FORMAT "x(20)"  INIT ""   
    FIELD cedpol      AS CHAR FORMAT "x(20)"  INIT ""  
    FIELD covcod      AS CHAR FORMAT "x(3)"   INIT ""   
    FIELD producer    AS CHAR FORMAT "x(10)"  INIT ""   
    FIELD agent       AS CHAR FORMAT "x(10)"  INIT ""   
    FIELD inserf      AS CHAR FORMAT "x(10)"  INIT ""   
    FIELD vatcode     AS CHAR FORMAT "x(10)"  INIT ""   
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
    FIELD opnpol      AS CHAR FORMAT "x(30)"   INIT ""
    FIELD finint      AS CHAR FORMAT "X(10)"   INIT ""
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
    FIELD stk         AS CHAR FORMAT "x(25)"   INIT ""  
    FIELD compul      AS CHAR FORMAT "x"       INIT ""   
    FIELD comment     AS CHAR FORMAT "x(512)"  INIT ""
    FIELD pass        AS CHAR FORMAT "x"       INIT "n" 
    FIELD WARNING     AS CHAR FORMAT "X(30)"   INIT ""
    FIELD OK_GEN      AS CHAR FORMAT "X"       INIT "Y" 
    FIELD premt       AS CHAR FORMAT "x(15)"   INIT ""  
    /*FIELD comp_prm    AS CHAR FORMAT "x(15)"   INIT "" */ 
    FIELD cndat       AS CHAR FORMAT "x(10)"   INIT ""  
    FIELD prepol      AS CHAR FORMAT "x(16)"   INIT ""   
    FIELD prem_r      AS CHAR FORMAT "x(14)" INIT "" 
    /*FIELD prem_nap    AS CHAR FORMAT "x(14)" INIT ""   */ 
    FIELD comper      AS CHAR FORMAT "x(14)" INIT ""   
    FIELD comacc      AS CHAR FORMAT "x(14)" INIT "" 
    FIELD enttim      AS CHAR FORMAT "x(8)"   INIT ""       
    FIELD trantim     AS CHAR FORMAT "x(8)"   INIT ""       
    FIELD n_IMPORT    AS CHAR FORMAT "x(2)"   INIT ""       
    FIELD n_EXPORT    AS CHAR FORMAT "x(2)"   INIT "" 
    FIELD cr_2        AS CHAR FORMAT "x(12)"   INIT ""  
    FIELD docno       AS CHAR INIT "" FORMAT "x(10)" 
    FIELD drivnam     AS CHAR FORMAT "x"       INIT "n" 
    FIELD cancel      AS CHAR FORMAT "x(2)"    INIT ""    
    FIELD accdat      AS CHAR INIT "" FORMAT "x(10)"  
    FIELD ICNO        AS CHAR INIT "" FORMAT "x(15)"  .
DEF    NEW SHARED VAR  nv_message   AS char.
DEF               VAR  nv_riskgp    LIKE sic_bran.uwm120.riskgp     NO-UNDO.
DEFINE NEW SHARED VAR  NO_basemsg   AS CHAR  FORMAT "x(50)" .       
DEFINE            VAR  nv_accdat    AS DATE  FORMAT "99/99/9999"    INIT ?  .     
DEFINE            VAR  nv_docno     AS CHAR  FORMAT "9999999"       INIT " ".
DEFINE NEW SHARED VAR  nv_batchyr   AS INT   FORMAT "9999"          INIT 0.
DEFINE NEW SHARED VAR  nv_batcnt    AS INT   FORMAT "99"            INIT 0.
DEFINE NEW SHARED VAR  nv_batchno   AS CHARACTER FORMAT "X(20)"     INIT ""  NO-UNDO.
DEFINE VAR             nv_batrunno  AS INT  FORMAT ">,>>9"          INIT 0.
DEFINE VAR             nv_imppol    AS INT  FORMAT ">>,>>9"         INIT 0.
DEFINE VAR             nv_impprem   AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.
DEFINE VAR             nv_batprev   AS CHARACTER FORMAT "X(20)"     INIT ""  NO-UNDO.
DEFINE VAR             nv_tmppolrun AS INTEGER FORMAT "999"         INIT 0. 
DEFINE VAR             nv_batbrn    AS CHARACTER FORMAT "x(2)"      INIT ""  NO-UNDO. 
DEFINE VAR             nv_tmppol    AS CHARACTER FORMAT "x(16)"     INIT "". 
DEFINE VAR             nv_rectot    AS INT  FORMAT ">>,>>9"         INIT 0.  
DEFINE VAR             nv_recsuc    AS INT  FORMAT ">>,>>9"         INIT 0.  
DEFINE VAR             nv_netprm_t  AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.  
DEFINE VAR             nv_netprm_s  AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.  
DEFINE VAR             nv_batflg    AS LOG                          INIT NO.
DEFINE VAR             nv_txtmsg    AS CHAR FORMAT "x(50)"          INIT "". 
DEF VAR np_idno       AS CHAR  INIT "" FORMAT "x(10)".
DEF VAR np_cedpol     AS CHAR  INIT "" FORMAT "x(20)". 
DEF VAR np_typepol    AS CHAR  INIT "" FORMAT "x(30)".  
DEF VAR np_status     AS CHAR  INIT "" FORMAT "x(30)".  
DEF VAR np_memo       AS CHAR  INIT "" FORMAT "x(150)". 
DEF VAR np_remak      AS CHAR          FORMAT "x(150)" .  
DEF VAR np_name1      AS CHAR FORMAT "x(100)" .  
DEF VAR np_sumins     AS CHAR FORMAT "x(20)"  .  
DEF VAR np_premt      AS CHAR FORMAT "x(20)" .  
DEF VAR np_sendat     AS CHAR FORMAT "x(30)" INIT "" .
DEF VAR np_comdat     AS CHAR FORMAT "x(30)" INIT "" .
DEF VAR np_recipdat   AS CHAR FORMAT "x(35)" INIT "" .
DEF VAR np_keydat     AS CHAR FORMAT "x(35)" INIT "" .
DEF VAR np_postdat     AS CHAR FORMAT "x(40)"  .  
DEF VAR np_brand      AS CHAR FORMAT "x(65)".
DEF VAR np_vehreg     AS CHAR FORMAT "x(20)"  .
DEF VAR np_chassis    AS CHAR FORMAT "x(30)". 
DEF VAR np_caryear    AS CHAR FORMAT "x(5)"  INIT "" .
DEF VAR np_comname    AS CHAR FORMAT "x(40)"  INIT "" .  
DEF VAR np_agentno    AS CHAR FORMAT "x(35)"  INIT "" . 
DEF VAR np_agenname   AS CHAR FORMAT "x(45)"  INIT "" .
DEF VAR np_AEname     AS CHAR FORMAT "x(35)"  INIT "" .
DEF VAR nn_address    AS CHAR FORMAT "x(150)"  INIT "" .
DEF VAR nn_icno       AS CHAR FORMAT "x(15)"  INIT "" .  
DEF VAR nn_pol70      AS CHAR FORMAT "x(12)"  INIT "" . 
DEF VAR nn_pol72      AS CHAR FORMAT "x(12)"  INIT "" .
DEF VAR nn_name2      AS CHAR FORMAT "x(80)"  INIT "" .
DEF VAR np_garage     AS CHAR  INIT "" FORMAT "x".
DEF VAR np_pack       AS CHAR  INIT "" FORMAT "x(5)".
DEF VAR np_41TPBI     AS CHAR  INIT "" FORMAT "x(20)".
DEF VAR np_42TPBI     AS CHAR  INIT "" FORMAT "x(20)".
DEF VAR np_43TPPD     AS CHAR  INIT "" FORMAT "x(20)".
DEF VAR np_41PA       AS CHAR  INIT "" FORMAT "x(20)".
DEF VAR np_42PA       AS CHAR  INIT "" FORMAT "x(20)".
DEF VAR np_43BAIL     AS CHAR  INIT "" FORMAT "x(20)".
DEF VAR np_ben83      AS CHAR  INIT "" FORMAT "x(80)".
DEF VAR np_F17_1      AS CHAR  INIT "" FORMAT "x(150)".
DEF VAR np_F17_2      AS CHAR  INIT "" FORMAT "x(150)".
DEF VAR np_F17_3      AS CHAR  INIT "" FORMAT "x(150)".
DEF VAR np_F17_4      AS CHAR  INIT "" FORMAT "x(150)".
DEF VAR np_F18_1      AS CHAR  INIT "" FORMAT "x(150)".
DEF VAR np_F18-2      AS CHAR  INIT "" FORMAT "x(150)".
DEF VAR np_F18_3      AS CHAR  INIT "" FORMAT "x(150)".
DEF VAR np_F18_4      AS CHAR  INIT "" FORMAT "x(150)".
DEF VAR np_F18_5      AS CHAR  INIT "" FORMAT "x(150)".
DEF VAR np_comdatday  AS CHAR INIT "" .
DEF VAR np_comdatmont AS CHAR INIT "" .
DEF VAR np_comdatyear AS CHAR INIT "" .
DEF VAR nn_addr1      AS CHAR INIT "" FORMAT "x(50)" .
DEF VAR nn_addr2      AS CHAR INIT "" FORMAT "x(50)" .
DEF VAR nn_addr3      AS CHAR INIT "" FORMAT "x(50)" .
DEF VAR nn_addr4      AS CHAR INIT "" FORMAT "x(50)" .
DEFINE VAR nv_txt1    AS CHARACTER    FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt2    AS CHARACTER    FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt3    AS CHARACTER    FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt4    AS CHARACTER    FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt5    AS CHARACTER    FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt6    AS CHARACTER    FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_line1   AS INTEGER      INITIAL 0            NO-UNDO.

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
    FIELD n_textacc3      AS CHAR  INIT "" FORMAT "x(100)" 
    FIELD n_textacc4      AS CHAR  INIT "" FORMAT "x(100)"  .
DEFINE WORKFILE wacctext17
    FIELD n_policytxt17   AS CHAR  INIT "" FORMAT "x(100)" 
    FIELD n_textacc1      AS CHAR  INIT "" FORMAT "x(100)"  
    FIELD n_textacc2      AS CHAR  INIT "" FORMAT "x(100)"  
    FIELD n_textacc3      AS CHAR  INIT "" FORMAT "x(100)" 
    FIELD n_textacc4      AS CHAR  INIT "" FORMAT "x(100)" 
    FIELD n_textacc5      AS CHAR  INIT "" FORMAT "x(100)"  .
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
/*add for 2+,3+*/
DEFINE NEW  SHARED VAR   nv_prem3       AS DECIMAL      FORMAT ">,>>>,>>9.99-" INITIAL 0  NO-UNDO.
DEFINE NEW  SHARED VAR   nv_sicod3      AS CHAR         FORMAT "X(4)".
DEFINE NEW  SHARED VAR   nv_usecod3     AS CHAR         FORMAT "X(4)".
DEFINE NEW  SHARED VAR   nv_siprm3      AS DECI         FORMAT ">>,>>>,>>9.99-".
DEFINE NEW  SHARED VAR   nv_prvprm3     AS DECI         FORMAT ">>,>>>,>>9.99-".
DEFINE NEW  SHARED VAR   nv_baseprm3    AS DECI         FORMAT ">>,>>>,>>9.99-".
DEFINE NEW  SHARED VAR   nv_useprm3     AS DECI         FORMAT ">>,>>>,>>9.99-".
DEFINE NEW  SHARED VAR   nv_basecod3    AS CHAR         FORMAT "X(4)".
DEFINE NEW  SHARED VAR   nv_basevar3    AS CHAR         FORMAT "X(60)".
DEFINE NEW  SHARED VAR   nv_basevar4    AS CHAR         FORMAT "X(30)".
DEFINE NEW  SHARED VAR   nv_basevar5    AS CHAR         FORMAT "X(30)".
DEFINE NEW  SHARED VAR   nv_usevar3     AS CHAR         FORMAT "X(60)".
DEFINE NEW  SHARED VAR   nv_usevar4     AS CHAR         FORMAT "X(30)".
DEFINE NEW  SHARED VAR   nv_usevar5     AS CHAR         FORMAT "X(30)".
DEFINE NEW  SHARED VAR   nv_sivar3      AS CHAR         FORMAT "X(60)".
DEFINE NEW  SHARED VAR   nv_sivar4      AS CHAR         FORMAT "X(30)".
DEFINE NEW  SHARED VAR   nv_sivar5      AS CHAR         FORMAT "X(30)".
DEFINE VAR               ns_basenew     AS CHAR         FORMAT "x(20)"     INIT "".  
DEFINE VAR               campaignno     AS CHAR INIT "" FORMAT "X(20)".    
/* add for 2+,3+*/
DEFINE NEW SHARED TEMP-TABLE wdetailfile
    field	np_idno       AS CHAR  INIT "" FORMAT "x(10)"                 
    field	np_cedpol     AS CHAR  INIT "" FORMAT "x(20)"                 
    field	np_typepol    AS CHAR  INIT "" FORMAT "x(30)"                 
    field	np_status     AS CHAR  INIT "" FORMAT "x(30)"                 
    field	np_memo       AS CHAR  INIT "" FORMAT "x(150)"               
    field	np_remak      AS CHAR          FORMAT "x(150)"               
    field	np_name1      AS CHAR FORMAT "x(100)"                        
    field	np_sumins     AS CHAR FORMAT "x(20)"                         
    field	np_premt      AS CHAR FORMAT "x(20)"                         
    field	np_sendat     AS CHAR FORMAT "x(30)" INIT ""                 
    field	np_comdat     AS CHAR FORMAT "x(30)" INIT ""                 
    field	np_recipdat   AS CHAR FORMAT "x(35)" INIT ""                 
    field	np_keydat     AS CHAR FORMAT "x(35)" INIT ""                 
    field	np_postdat    AS CHAR FORMAT "x(40)"                      
    field	np_brand      AS CHAR FORMAT "x(65)"                       
    field	np_vehreg     AS CHAR FORMAT "x(20)"                       
    field	np_chassis    AS CHAR FORMAT "x(30)"                       
    field	np_caryear    AS CHAR FORMAT "x(5)"  INIT ""                
    field	np_comname    AS CHAR FORMAT "x(40)"  INIT ""               
    field	np_agentno    AS CHAR FORMAT "x(35)"  INIT ""               
    field	np_agenname   AS CHAR FORMAT "x(45)"  INIT ""               
    field	np_AEname     AS CHAR FORMAT "x(35)"  INIT ""
    FIELD   nn_address    AS CHAR FORMAT "x(150)"  INIT ""   
    FIELD   nn_icno       AS CHAR FORMAT "x(15)"   INIT "" 
    FIELD   np_prepol     AS CHAR FORMAT "x(16)"  INIT ""
    field   nn_name2      AS CHAR FORMAT "x(80)"  INIT ""  
    field   np_garage     AS CHAR  INIT "" FORMAT "x" 
    field   np_fincode     AS CHAR  INIT "" FORMAT "x(10)" 
    field   np_pack       AS CHAR  INIT "" FORMAT "x(5)" 
    field   np_41TPBI     AS CHAR  INIT "" FORMAT "x(20)" 
    field   np_42TPBI     AS CHAR  INIT "" FORMAT "x(20)"
    field   np_43TPPD     AS CHAR  INIT "" FORMAT "x(20)"
    field   np_41PA       AS CHAR  INIT "" FORMAT "x(20)"
    field   np_42PA       AS CHAR  INIT "" FORMAT "x(20)"
    field   np_43BAIL     AS CHAR  INIT "" FORMAT "x(20)"
    field   np_ben83      AS CHAR  INIT "" FORMAT "x(80)"
    field   np_F17_1      AS CHAR  INIT "" FORMAT "x(150)" 
    field   np_F17_2      AS CHAR  INIT "" FORMAT "x(150)"
    field   np_F17_3      AS CHAR  INIT "" FORMAT "x(150)"
    field   np_F17_4      AS CHAR  INIT "" FORMAT "x(150)"
    FIELD   np_F18_1      AS CHAR  INIT "" FORMAT "x(150)"
    FIELD   np_F18-2      AS CHAR  INIT "" FORMAT "x(150)"
    field   np_F18_3      AS CHAR  INIT "" FORMAT "x(150)"
    FIELD   np_F18_4      AS CHAR  INIT "" FORMAT "x(150)"
    FIELD   np_F18_5      AS CHAR  INIT "" FORMAT "x(150)".
DEF VAR np_prepol     AS CHAR FORMAT "x(16)"  INIT "" .     
DEF VAR np_polnew     AS CHAR FORMAT "x(16)"  INIT "" .  
DEF VAR np_fincode    AS CHAR FORMAT "x(16)"  INIT "" .
