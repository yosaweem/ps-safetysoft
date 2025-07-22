DEFINE TEMP-TABLE wText NO-UNDO   
    FIELD   nr_line       AS CHAR FORMAT "x(3)"  
    FIELD   nr_branch     AS CHAR FORMAT "x(2)"  
    FIELD   nr_CLAIM      AS CHAR FORMAT "x(20)"            
    FIELD   nr_entdat     AS CHAR FORMAT "X(20)"  
    FIELD   nr_notdat     AS CHAR FORMAT "X(20)"                         
    FIELD   nr_LOSDAT     AS CHAR FORMAT "X(20)" 
    FIELD   nr_POLICY     AS CHAR FORMAT "X(20)"                                  
    FIELD   nr_name       AS CHAR FORMAT "x(60)"                             
    FIELD   nr_LOSS       AS CHAR FORMAT "x(20)"                               
    FIELD   nr_loss1      AS CHAR FORMAT "x(150)"                            
    FIELD   nr_clmant_itm AS CHAR FORMAT "x(10)"                             
    FIELD   nr_osres      AS DECI FORMAT ">>,>>>,>>>,>>9.99-"       
    FIELD   nr_facri      AS DECI FORMAT ">>,>>>,>>>,>>9.99-" 
    FIELD   nr_treaty     AS DECI FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD   nr_osbh       AS DECI FORMAT ">>,>>>,>>>,>>9.99-"  
    FIELD   nr_facbh      AS DECI FORMAT ">>,>>>,>>>,>>9.99-"  
    FIELD   nr_ttybh      AS DECI FORMAT ">>,>>>,>>>,>>9.99-" 
    FIELD   nr_othbh      AS DECI FORMAT ">>,>>>,>>>,>>9.99-" 
    FIELD   nr_osnap       AS DECI FORMAT ">>,>>>,>>>,>>9.99-"  
    FIELD   nr_facnap      AS DECI FORMAT ">>,>>>,>>>,>>9.99-"  
    FIELD   nr_ttynap      AS DECI FORMAT ">>,>>>,>>>,>>9.99-" 
    FIELD   nr_othnap      AS DECI FORMAT ">>,>>>,>>>,>>9.99-" 
    FIELD   nr_adjust     AS CHAR FORMAT "X(40)"                      
    FIELD   nr_intref     AS CHAR FORMAT "X(30)"                      
    FIELD   nr_extref     AS CHAR FORMAT "X(30)" 
    FIELD   nr_agent      AS CHAR FORMAT "X(30)"
    FIELD   nr_agent1      AS CHAR FORMAT "X(30)"   /*Saowapa U. A61-0460 25/09/2018*/
    FIELD   nr_acno       AS CHAR FORMAT "X(30)"   
    FIELD   nr_trndat     AS DATE FORMAT "99/99/9999"   /*Saowapa U. A61-0460 25/09/2018*/
    FIELD   nr_comdat     AS DATE FORMAT "99/99/9999"   /*Saowapa U. A61-0460 25/09/2018*/
    FIELD   nr_cedclm     AS CHAR FORMAT "X(30)"   
    FIELD   nr_DOCST      AS CHAR FORMAT "X(30)"   
    FIELD   nr_pades      AS CHAR FORMAT "X(30)" 
    FIELD   nr_fee        AS DECI FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD   nr_ntgross    AS DECI FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD   nr_ced        AS DECI FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD   nr_1st        AS DECI FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD   nr_2nd        AS DECI FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD   nr_qs5        AS DECI FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD   nr_tfp        AS DECI FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD   nr_mps        AS DECI FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD   nr_eng        AS DECI FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD   nr_mar        AS DECI FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD   nr_rq         AS DECI FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD   nr_btr        AS DECI FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD   nr_otr        AS DECI FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD   nr_ftr        AS DECI FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD   nr_fo1        AS DECI FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD   nr_fo2        AS DECI FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD   nr_fo3        AS DECI FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD   nr_fo4        AS DECI FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD   nr_net        AS DECI FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD   nr_comp       AS DECI FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD   nr_xol        AS DECI FORMAT ">>,>>>,>>>,>>9.99-" 
    /*---A63-0417---*/
    FIELD   nr_rescod        AS CHAR FORMAT "X(30)"
    FIELD   nr_resref        AS CHAR FORMAT "X(30)"
    FIELD   nr_osres_nv      AS DECI FORMAT ">>,>>>,>>>,>>9.99-"  
    FIELD   nr_osres_v       AS DECI FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD   nr_facri_nv      AS DECI FORMAT ">>,>>>,>>>,>>9.99-" 
    FIELD   nr_treaty_nv     AS DECI FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD   nr_osbh_nv       AS DECI FORMAT ">>,>>>,>>>,>>9.99-"  
    FIELD   nr_facbh_nv      AS DECI FORMAT ">>,>>>,>>>,>>9.99-"  
    FIELD   nr_ttybh_nv      AS DECI FORMAT ">>,>>>,>>>,>>9.99-" 
    FIELD   nr_othbh_nv      AS DECI FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD   nr_osnap_nv       AS DECI FORMAT ">>,>>>,>>>,>>9.99-"  
    FIELD   nr_facnap_nv      AS DECI FORMAT ">>,>>>,>>>,>>9.99-"  
    FIELD   nr_ttynap_nv      AS DECI FORMAT ">>,>>>,>>>,>>9.99-" 
    FIELD   nr_othnap_nv      AS DECI FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD   nr_fee_nv        AS DECI FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD   nr_ntgross_nv    AS DECI FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD   nr_ced_nv        AS DECI FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD   nr_1st_nv        AS DECI FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD   nr_2nd_nv        AS DECI FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD   nr_qs5_nv        AS DECI FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD   nr_tfp_nv        AS DECI FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD   nr_mps_nv        AS DECI FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD   nr_eng_nv        AS DECI FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD   nr_mar_nv        AS DECI FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD   nr_rq_nv        AS DECI FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD   nr_btr_nv        AS DECI FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD   nr_otr_nv        AS DECI FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD   nr_ftr_nv        AS DECI FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD   nr_fo1_nv        AS DECI FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD   nr_fo2_nv        AS DECI FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD   nr_fo3_nv        AS DECI FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD   nr_fo4_nv        AS DECI FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD   nr_net_nv        AS DECI FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD   nr_comp_nv       AS DECI FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD   nr_xol_nv        AS DECI FORMAT ">>,>>>,>>>,>>9.99-" 
    /*---------------*/
    INDEX  wText101 nr_branch nr_line nr_CLAIM.

DEFINE TEMP-TABLE wText2 NO-UNDO   
    FIELD   nr_Line       AS CHAR FORMAT "x(3)"  
    FIELD   nr_branch     AS CHAR FORMAT "x(2)"  
    FIELD   nr_branchdsp  AS CHAR FORMAT "x(50)"
    INDEX wText201 nr_branch nr_Line .

DEFINE TEMP-TABLE wText3 NO-UNDO  
    FIELD   nr_Line       AS CHAR FORMAT "x(3)"  
    FIELD   nr_branch     AS CHAR FORMAT "x(2)"  
    FIELD   nr_branchdsp  AS CHAR FORMAT "x(50)"
    FIELD   nr_claimcount AS CHAR FORMAT "x(20)"    
    FIELD   nv_count      AS DECI FORMAT ">>>,>>9" 
    FIELD   nr_osres_70   AS DECI FORMAT ">>,>>>,>>>,>>9.99-"  
    FIELD   nr_osres_71   AS DECI FORMAT ">>,>>>,>>>,>>9.99-"  
    FIELD   nr_osres_72   AS DECI FORMAT ">>,>>>,>>>,>>9.99-"  
    FIELD   nr_osres_73   AS DECI FORMAT ">>,>>>,>>>,>>9.99-"  
    FIELD   nr_osres_74   AS DECI FORMAT ">>,>>>,>>>,>>9.99-"  
    FIELD   nr_facri_70   AS DECI FORMAT ">>,>>>,>>>,>>9.99-" 
    FIELD   nr_facri_71   AS DECI FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD   nr_facri_72   AS DECI FORMAT ">>,>>>,>>>,>>9.99-" 
    FIELD   nr_facri_73   AS DECI FORMAT ">>,>>>,>>>,>>9.99-" 
    FIELD   nr_facri_74   AS DECI FORMAT ">>,>>>,>>>,>>9.99-" 
    /*--- Benjaporn J. A59-0613 [14/12/2016] ---*/
    FIELD   nr_osbh       AS DECI FORMAT ">>,>>>,>>>,>>9.99-"     
    FIELD   nr_ttybh      AS DECI FORMAT ">>,>>>,>>>,>>9.99-"     
    FIELD   nr_facbh      AS DECI FORMAT ">>,>>>,>>>,>>9.99-"     
    FIELD   nr_othbh      AS DECI FORMAT ">>,>>>,>>>,>>9.99-" 
    FIELD   nr_osnap      AS DECI FORMAT ">>,>>>,>>>,>>9.99-"     
    FIELD   nr_ttynap     AS DECI FORMAT ">>,>>>,>>>,>>9.99-"     
    FIELD   nr_facnap     AS DECI FORMAT ">>,>>>,>>>,>>9.99-"     
    FIELD   nr_othnap     AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
    /*---End A59-0613  ---*/

DEFINE TEMP-TABLE wText4 NO-UNDO  
    FIELD   nr_Line       AS CHAR FORMAT "x(3)"  
    FIELD   nr_branch     AS CHAR FORMAT "x(2)"  
    FIELD   nr_claimcount AS CHAR FORMAT "x(20)"    
    FIELD   nv_count      AS DECI FORMAT ">>>,>>9" 
    INDEX wText401 nr_branch nr_Line .

DEF VAR np_1st    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR np_2nd    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR np_mar    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR np_qs5    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR np_tfp    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR np_rq     AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR np_fo1    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR np_fo2    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR np_eng    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR np_fo3    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR np_fo4    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR np_ftr    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR np_mps    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR np_btr    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR np_otr    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR n_fac     AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR n_treaty  AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR n_comp    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR n_ced     AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR n_net     AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR n_totgross  AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR n_fee     AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .

DEF VAR np_fee        AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .  
DEF VAR np_totgross   AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .  
DEF VAR np_ced        AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .  
DEF VAR np_ret        AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .  

DEF VAR nt_1st    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR nt_2nd    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR nt_mar    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR nt_qs5    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR nt_tfp    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR nt_rq     AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR nt_fo1    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR nt_fo2    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR nt_eng    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR nt_fo3    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR nt_fo4    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR nt_ftr    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR nt_mps    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR nt_btr    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR nt_otr    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .

/*----A63-0417----*/
DEF VAR np_1st_nv    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR np_2nd_nv    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR np_mar_nv    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR np_qs5_nv    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR np_tfp_nv    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR np_rq_nv    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR np_fo1_nv    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR np_fo2_nv    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR np_eng_nv    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR np_fo3_nv    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR np_fo4_nv    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR np_ftr_nv    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR np_mps_nv    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR np_btr_nv    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR np_otr_nv    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR n_fac_nv     AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR n_treaty_nv  AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR n_comp_nv    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR n_ced_nv     AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR n_net_nv     AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR n_totgross_nv  AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR n_totgross_v  AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR n_fee_nv     AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .

DEF VAR np_fee_nv        AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .  
DEF VAR np_totgross_nv   AS DECI FORMAT ">>,>>>,>>>,>>9.99-" . 
DEF VAR np_totgross_v   AS DECI FORMAT ">>,>>>,>>>,>>9.99-" . 
DEF VAR np_ced_nv        AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .  
DEF VAR np_ret_nv        AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .  

DEF VAR nt_1st_nv    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR nt_2nd_nv    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR nt_mar_nv    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR nt_qs5_nv    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR nt_tfp_nv    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR nt_rq_nv     AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR nt_fo1_nv    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR nt_fo2_nv    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR nt_eng_nv    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR nt_fo3_nv    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR nt_fo4_nv    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR nt_ftr_nv    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR nt_mps_nv    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR nt_btr_nv    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR nt_otr_nv    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
/*---end A63-0417---*/

DEFINE STREAM ns2. 
DEF WORKFILE wfsum 
    FIELD n_year     AS INT  
    FIELD n_month    AS INT  
    FIELD n_type     AS CHAR  FORMAT "X" 
    FIELD n_bran     AS CHAR  FORMAT "x(2)"
    FIELD n_line     AS CHAR  FORMAT "x(2)"
    FIELD n_ret      AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-"    
    FIELD n_gross    AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-"    
    FIELD nt_gross   AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-"    
    FIELD n_ceed     AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-"     
    FIELD n_fee      AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-"     
    FIELD n_fac      AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-"     
    FIELD n_treaty   AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-"    
    FIELD n_comp     AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-"  
    FIELD n_ced      AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-"
    FIELD n_1st      AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-"
    FIELD n_2nd      AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-"
    FIELD n_qs5      AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-"
    FIELD n_tfp      AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-"
    FIELD n_mps      AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-"
    FIELD n_eng      AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-"
    FIELD n_mar      AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-"
    FIELD n_rq       AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-"
    FIELD n_btr      AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-"
    FIELD n_otr      AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-"
    FIELD n_ftr      AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-"
    FIELD n_fo1      AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-"
    FIELD n_fo2      AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-"
    FIELD n_fo3      AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-"
    FIELD n_fo4      AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-"  
    /*----A63-0417---*/
    FIELD n_ret_nv      AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-"    
    FIELD n_gross_nv    AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-"    
    FIELD nt_gross_nv   AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-"  
    FIELD n_gross_v     AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-"    
    FIELD nt_gross_v    AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" 
    FIELD n_ceed_nv     AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-"     
    FIELD n_fee_nv      AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-"     
    FIELD n_fac_nv      AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-"     
    FIELD n_treaty_nv   AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-"    
    FIELD n_comp_nv     AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-"  
    FIELD n_ced_nv      AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-"
    FIELD n_1st_nv      AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-"
    FIELD n_2nd_nv      AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-"
    FIELD n_qs5_nv      AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-"
    FIELD n_tfp_nv      AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-"
    FIELD n_mps_nv      AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-"
    FIELD n_eng_nv      AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-"
    FIELD n_mar_nv      AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-"
    FIELD n_rq_nv       AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-"
    FIELD n_btr_nv      AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-"
    FIELD n_otr_nv      AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-"
    FIELD n_ftr_nv      AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-"
    FIELD n_fo1_nv      AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-"
    FIELD n_fo2_nv      AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-"
    FIELD n_fo3_nv      AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-"
    FIELD n_fo4_nv      AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-"
    . 

DEF VAR  ngd_osres       AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" INIT 0. 
DEF VAR  ngd_ced         AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" INIT 0. 
DEF VAR  ngd_1st         AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" INIT 0. 
DEF VAR  ngd_2nd         AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" INIT 0. 
DEF VAR  ngd_facri       AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" INIT 0. 
DEF VAR  ngd_qs5         AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" INIT 0. 
DEF VAR  ngd_tfp         AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" INIT 0. 
DEF VAR  ngd_mps         AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" INIT 0. 
DEF VAR  ngd_eng         AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" INIT 0. 
DEF VAR  ngd_mar         AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" INIT 0. 
DEF VAR  ngd_rq          AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" INIT 0. 
DEF VAR  ngd_btr         AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" INIT 0. 
DEF VAR  ngd_otr         AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" INIT 0. 
DEF VAR  ngd_ftr         AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" INIT 0. 
DEF VAR  ngd_fo1         AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" INIT 0. 
DEF VAR  ngd_fo2         AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" INIT 0. 
DEF VAR  ngd_fo3         AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" INIT 0. 
DEF VAR  ngd_fo4         AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" INIT 0. 
DEF VAR  ngd_ret         AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" INIT 0. 
DEF VAR  ngd_xol         AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" INIT 0. 
DEF VAR  ngd_osbh        AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" INIT 0. 
DEF VAR  ngd_ttybh       AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" INIT 0. 
DEF VAR  ngd_facbh       AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" INIT 0. 
DEF VAR  ngd_othbh       AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" INIT 0. 
DEF VAR  ngd_osnap       AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" INIT 0. 
DEF VAR  ngd_ttynap      AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" INIT 0. 
DEF VAR  ngd_facnap      AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" INIT 0. 
DEF VAR  ngd_othnap      AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" INIT 0.     
DEF VAR  ngd_osres_v     AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" INIT 0. 
DEF VAR  ngd_osres_nv    AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" INIT 0. 
DEF VAR  ngd_ced_nv      AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" INIT 0. 
DEF VAR  ngd_1st_nv      AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" INIT 0. 
DEF VAR  ngd_2nd_nv      AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" INIT 0. 
DEF VAR  ngd_facri_nv    AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" INIT 0. 
DEF VAR  ngd_qs5_nv      AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" INIT 0. 
DEF VAR  ngd_tfp_nv      AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" INIT 0. 
DEF VAR  ngd_mps_nv      AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" INIT 0. 
DEF VAR  ngd_eng_nv      AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" INIT 0. 
DEF VAR  ngd_mar_nv      AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" INIT 0. 
DEF VAR  ngd_rq_nv       AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" INIT 0. 
DEF VAR  ngd_btr_nv      AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" INIT 0. 
DEF VAR  ngd_otr_nv      AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" INIT 0. 
DEF VAR  ngd_ftr_nv      AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" INIT 0. 
DEF VAR  ngd_fo1_nv      AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" INIT 0. 
DEF VAR  ngd_fo2_nv      AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" INIT 0. 
DEF VAR  ngd_fo3_nv      AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" INIT 0. 
DEF VAR  ngd_fo4_nv      AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" INIT 0. 
DEF VAR  ngd_ret_nv      AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" INIT 0. 
DEF VAR  ngd_xol_nv      AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" INIT 0. 
DEF VAR  ngd_osbh_nv     AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" INIT 0. 
DEF VAR  ngd_ttybh_nv    AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" INIT 0. 
DEF VAR  ngd_facbh_nv    AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" INIT 0. 
DEF VAR  ngd_othbh_nv    AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR  ngd_osnap_nv    AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR  ngd_ttynap_nv   AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR  ngd_facnap_nv   AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR  ngd_othnap_nv   AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" INIT 0.

































































/*---end A63-0417---*/
             
