/* wacr00100.i  : use for wacr0010.w                           */
/* Create by    : Benjaporn J. A59-0476 date 03/10/2016        */

DEF TEMP-TABLE tFacRe 
    FIELD asdat    AS   DATE FORMAT "99/99/9999"
    FIELD policy   AS   CHAR FORMAT "x(20)" 
    FIELD rencnt   AS   INT  FORMAT ">>9"
    FIELD endcnt   AS   INT  FORMAT "999"
    FIELD comdat   AS   DATE FORMAT "99/99/9999"
    FIELD expdat   AS   DATE FORMAT "99/99/9999"
    FIELD trndat   AS   DATE FORMAT "99/99/9999"
    FIELD cntrisk  AS   INT  FORMAT ">,>>9" 
    FIELD sigr     AS   DECI FORMAT "->,>>>,>>>,>>>,>>9.99"
    FIELD coins    LIKE uwm100.coins
    FIELD co_per   AS   DECI FORMAT ">>9.99"
    FIELD prem     AS   DECI FORMAT "->,>>>,>>>,>>>,>>9.99"
    FIELD polprm   AS   DECI FORMAT "->,>>>,>>>,>>>,>>9.99"
    FIELD flood    AS   DECI FORMAT "->,>>>,>>>,>>>,>>9.99"
    FIELD storm    AS   DECI FORMAT "->,>>>,>>>,>>>,>>9.99"
    FIELD earth    AS   DECI FORMAT "->,>>>,>>>,>>>,>>9.99" 
    FIELD bran     AS   CHAR FORMAT "x(4)"
    FIELD LINE     AS   CHAR FORMAT "x(4)" 
    FIELD poldisc  AS   DECI FORMAT "->,>>>,>>>,>>>,>>9.99" 
    FIELD ridisc   AS   DECI FORMAT "->,>>>,>>>,>>>,>>9.99" 
    FIELD risi_p   LIKE uwd200.risi FORMAT ">>9.99" 
    FIELD co_sty   AS   DECI FORMAT ">>9.99"
    FIELD ri_fac   AS   DECI FORMAT ">>9.99"
    FIELD ri_tty   AS   DECI FORMAT ">>9.99"
    FIELD ri_ret   AS   DECI FORMAT ">>9.99" 
    FIELD comri    AS   DECI FORMAT "->,>>>,>>>,>>>,>>9.99" 
    FIELD compol   AS   DECI FORMAT "->,>>>,>>>,>>>,>>9.99" 
    FIELD riprem   LIKE uwd200.ripr FORMAT "->,>>>,>>>,>>>,>>9.99" 
    FIELD endno    AS   CHAR FORMAT "x(9)"  
    FIELD sipol    AS   DECI FORMAT "->,>>>,>>>,>>>,>>9.99"   
    FIELD dtype    AS   CHAR FORMAT "X".


DEF TEMP-TABLE tFacRedet 
    FIELD asdat    AS   DATE FORMAT "99/99/9999"
    FIELD policy   AS   CHAR FORMAT "x(20)"
    FIELD rencnt   AS   INT  FORMAT ">>9"
    FIELD endcnt   AS   INT  FORMAT "999"
    FIELD comdat   AS   DATE FORMAT "99/99/9999" 
    FIELD expdat   AS   DATE FORMAT "99/99/9999" 
    FIELD sigr     AS   DECI FORMAT "->,>>>,>>>,>>>,>>9.99"
    FIELD coins    LIKE uwm100.coins
    FIELD co_per   AS   DECI FORMAT ">>9.99"
    FIELD prem     LIKE uwm100.prem_t FORMAT "->,>>>,>>>,>>>,>>9.99"
    FIELD csftq    LIKE uwd200.csftq 
    FIELD rico     LIKE uwd200.rico FORMAT "->,>>>,>>>,>>>,>>9.99"
    FIELD riconame AS   CHAR FORMAT "x(50)"
    FIELD ricoagtreg AS CHAR FORMAT "X(20)"
    FIELD risi     LIKE uwd200.risi FORMAT "->,>>>,>>>,>>>,>>9.99"
    FIELD riprem   LIKE uwd200.ripr FORMAT "->,>>>,>>>,>>>,>>9.99"
    FIELD risi_p   LIKE uwd200.risi FORMAT ">>9.99"
    FIELD riskgp   LIKE uwd200.riskgp
    FIELD riskno   LIKE uwd200.riskno
    FIELD subbroker AS LOGICAL 
    FIELD cedper   LIKE riroprm.cedper 
    FIELD comri    AS   DECI FORMAT "->,>>>,>>>,>>>,>>9.99"  
    FIELD ri_fac   AS   DECI FORMAT ">>9.99" .

DEF TEMP-TABLE tFacRedetriskno
    FIELD asdat    AS   DATE FORMAT "99/99/9999"
    FIELD policy   AS   CHAR FORMAT "x(20)"
    FIELD rencnt   AS   INT  FORMAT ">>9"
    FIELD endcnt   AS   INT  FORMAT "999"
    FIELD comdat   AS   DATE FORMAT "99/99/9999" 
    FIELD expdat   AS   DATE FORMAT "99/99/9999" 
    FIELD sigr     AS   DECI FORMAT "->,>>>,>>>,>>>,>>9.99"
    FIELD coins    LIKE uwm100.coins
    FIELD co_per   LIKE uwm100.co_per
    FIELD prem     LIKE uwm100.prem_t FORMAT "->,>>>,>>>,>>>,>>9.99"
    FIELD csftq    LIKE uwd200.csftq
    FIELD rico     LIKE uwd200.rico
    FIELD risi     LIKE uwd200.risi   FORMAT "->,>>>,>>>,>>>,>>9.99"
    FIELD riprem   LIKE uwd200.ripr   FORMAT "->,>>>,>>>,>>>,>>9.99"
    FIELD rfee_r   LIKE uwm120.rfee_r FORMAT ">>>>>>9.99-"
    FIELD riskgp   LIKE uwd200.riskgp
    FIELD riskno   LIKE uwd200.riskno 
    FIELD prov_n   like uwd141.prov_n
    FIELD blok_n   like uwd141.blok_n
    FIELD blok_s   like uwd141.sblok_n
    FIELD dist_n   like uwd141.dist_n
    FIELD blok_d   LIKE uwm502.blok_d 
    FIELD occupn   LIKE uwm304.occupn
    FIELD risi_p   LIKE uwd200.risi FORMAT ">>9.99" .

DEF TEMP-TABLE tFacRedetsub
    FIELD asdat    AS   DATE FORMAT "99/99/9999"
    FIELD policy   AS   CHAR FORMAT "x(20)"   
    FIELD rencnt   AS   INT  FORMAT ">>9"
    FIELD endcnt   AS   INT  FORMAT "999"
    FIELD comdat   AS   DATE FORMAT "99/99/9999"
    FIELD expdat   AS   DATE FORMAT "99/99/9999"
    FIELD sigr     AS   DECI FORMAT "->,>>>,>>>,>>>,>>9.99"
    FIELD coins    LIKE uwm100.coins
    FIELD co_per   LIKE uwm100.co_per
    FIELD prem     LIKE uwm100.prem_t FORMAT "->,>>>,>>>,>>>,>>9.99"
    FIELD csftq    LIKE uwd200.csftq
    FIELD rico     LIKE uwd200.rico
    FIELD risi     LIKE uwd200.risi FORMAT "->,>>>,>>>,>>>,>>9.99"
    FIELD riprem   LIKE uwd200.ripr FORMAT "->,>>>,>>>,>>>,>>9.99"
    FIELD riskgp   LIKE uwd200.riskgp
    FIELD riskno   LIKE uwd200.riskno
    FIELD ricosub  LIKE riroprm.ricosub 
    FIELD ricosubname AS   CHAR FORMAT "x(50)"
    FIELD ricosubagtreg AS CHAR FORMAT "X(20)"
    FIELD cedper   LIKE riroprm.cedper 
    FIELD risi_p   LIKE uwd200.risi FORMAT ">>9.99" .


DEF WORKFILE wfsum 
    FIELD asdat     AS DATE  FORMAT "99/99/9999"
    FIELD CLASS     AS CHAR  FORMAT "x(3)" 
    FIELD recode    AS CHAR  FORMAT "x(10)"
    FIELD rename    AS CHAR  FORMAT "x(30)"
    FIELD receive   AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" 
    FIELD duefr     AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" 
    FIELD osres     AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" 
    FIELD sumreins  AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-"
    FIELD outprm    AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-"
    FIELD outcom    AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-"   

    FIELD policy    AS CHAR  FORMAT "x(18)"
    FIELD branch    AS CHAR  FORMAT "x(3)"
    /*FIELD LINE      AS CHAR  FORMAT "x(5)" */
    FIELD polsi     AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" 
    FIELD polprm    AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-"
    FIELD risi      AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-"
    FIELD riprm     AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" 
    FIELD poldisc   AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-"
    FIELD ridisc    AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-"
    FIELD flood     AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" 
    FIELD storm     AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-"
    FIELD equake    AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" 
    FIELD comri     AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" 
    FIELD compol    AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-" .



DEF VAR pr1st_d  AS DEC.
DEF VAR com1st_d AS DEC.
DEF VAR res1st_d AS DEC.

DEF VAR pr1st_a  AS DEC.
DEF VAR com1st_a AS DEC.
DEF VAR res1st_a AS DEC.

DEF VAR pr1st_f  AS DEC.
DEF VAR com1st_f AS DEC.
DEF VAR res1st_f AS DEC.

/*-------A50-0256-------*/
DEF VAR nv_output2 AS CHAR. 
DEF VAR cntop      AS INT.
DEF VAR nv_reccnt  AS INT.
DEF VAR nv_next    AS INT.

DEF VAR msigr    AS DEC.
DEF VAR mprem    AS DEC.
DEF VAR mcomm    AS DEC.
DEF VAR mstat_pr AS DEC.
DEF VAR mret_pr  AS DEC.
DEF VAR m0q_pr   AS DEC.
DEF VAR m0t_pr   AS DEC.
DEF VAR m0s_pr   AS DEC.
DEF VAR mf1_pr   AS DEC.
DEF VAR mf2_pr   AS DEC.
DEF VAR mf3_pr   AS DEC.
DEF VAR mf4_pr   AS DEC.
DEF VAR m0rq_pr  AS DEC.
DEF VAR m0ps_pr  AS DEC.
DEF VAR mbtr_pr  AS DEC.
DEF VAR motr_pr  AS DEC.
DEF VAR mftr_pr  AS DEC.
DEF VAR ms8_pr   AS DEC.
DEF VAR mstat_c  AS DEC.
DEF VAR mret_c   AS DEC.
DEF VAR m0q_c    AS DEC.
DEF VAR m0t_c    AS DEC.
DEF VAR m0s_c    AS DEC.
DEF VAR mf1_c    AS DEC.
DEF VAR mf2_c    AS DEC.
DEF VAR mf3_c    AS DEC.
DEF VAR mf4_c    AS DEC.
DEF VAR m0rq_c   AS DEC.
DEF VAR m0ps_c   AS DEC.
DEF VAR mbtr_c   AS DEC.
DEF VAR motr_c   AS DEC.
DEF VAR mftr_c   AS DEC.
DEF VAR ms8_c    AS DEC.

DEF VAR nsigr    AS DEC.
DEF VAR nprem    AS DEC.
DEF VAR ncomm    AS DEC.
DEF VAR nstat_pr AS DEC.
DEF VAR nret_pr  AS DEC.
DEF VAR n0q_pr   AS DEC.
DEF VAR n0t_pr   AS DEC.
DEF VAR n0s_pr   AS DEC.
DEF VAR nf1_pr   AS DEC.
DEF VAR nf2_pr   AS DEC.
DEF VAR nf3_pr   AS DEC.
DEF VAR nf4_pr   AS DEC.
DEF VAR n0rq_pr  AS DEC.
DEF VAR n0ps_pr  AS DEC.
DEF VAR nbtr_pr  AS DEC.
DEF VAR notr_pr  AS DEC.
DEF VAR nftr_pr  AS DEC.
DEF VAR ns8_pr   AS DEC.
DEF VAR nstat_c  AS DEC.
DEF VAR nret_c   AS DEC.
DEF VAR n0q_c    AS DEC.
DEF VAR n0t_c    AS DEC.
DEF VAR n0s_c    AS DEC.
DEF VAR nf1_c    AS DEC.
DEF VAR nf2_c    AS DEC.
DEF VAR nf3_c    AS DEC.
DEF VAR nf4_c    AS DEC.
DEF VAR n0rq_c   AS DEC.
DEF VAR n0ps_c   AS DEC.
DEF VAR nbtr_c   AS DEC.
DEF VAR notr_c   AS DEC.
DEF VAR nftr_c   AS DEC.
DEF VAR ns8_c    AS DEC.
/*-----------------------------*/


DEF VAR nt_sigr      LIKE   uwm100.sigr_p FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR nt_prem      LIKE   uwm100.prem_t FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR nt_com       LIKE   uwm100.com1_t FORMAT "->>,>>>,>>>,>>>,>>9.99".

DEF  VAR nv_brn_line  AS CHAR FORMAT "x(4)" .
DEF  VAR nv_branch    AS CHAR FORMAT "x(2)" . 
DEF  VAR np_line      AS CHAR FORMAT "x(30)".
                          
DEF VAR nt_stat_pr   LIKE   uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nt_ret_pr    LIKE   uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nt_0q_pr     LIKE   uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nt_0t_pr     LIKE   uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nt_0s_pr     LIKE   uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nt_f1_pr     LIKE   uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nt_f2_pr     LIKE   uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nt_f3_pr     LIKE   uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nt_f4_pr     LIKE   uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99". 
DEF VAR nt_0rq_pr    LIKE   uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nt_0ps_pr    LIKE   uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nt_btr_pr    LIKE   uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nt_otr_pr    LIKE   uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nt_ftr_pr    LIKE   uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99". 
DEF VAR nt_s8_pr     LIKE   uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99".
/*---------------- End. Prem ----------------*/

DEF  VAR  nt_stat_per   LIKE   uwm200.rip1.
DEF  VAR  nt_ret_per    LIKE   uwm200.rip1.
DEF  VAR  nt_0q_per     LIKE   uwm200.rip1.
DEF  VAR  nt_0t_per     LIKE   uwm200.rip1.
DEF  VAR  nt_0s_per     LIKE   uwm200.rip1.
DEF  VAR  nt_f1_per     LIKE   uwm200.rip1.
DEF  VAR  nt_f2_per     LIKE   uwm200.rip1.
DEF  VAR  nt_f3_per     LIKE   uwm200.rip1.
DEF  VAR  nt_f4_per     LIKE   uwm200.rip1.
DEF  VAR  nt_0rq_per    LIKE   uwm200.rip1.
DEF  VAR  nt_0ps_per    LIKE   uwm200.rip1.
DEF  VAR  nt_btr_per    LIKE   uwm200.rip1.
DEF  VAR  nt_otr_per    LIKE   uwm200.rip1.
DEF  VAR  nt_ftr_per    LIKE   uwm200.rip1.  
DEF  VAR  nt_s8_per     LIKE   uwm200.rip1.
DEF  VAR  nt_other_per  LIKE   uwm200.rip1.
/*---------------- End. % Comm.----------------*/

DEF VAR nt_stat_co   LIKE   uwd200.ric1 FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nt_ret_co    LIKE   uwd200.ric1 FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nt_0q_co     LIKE   uwd200.ric1 FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nt_0t_co     LIKE   uwd200.ric1 FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nt_0s_co     LIKE   uwd200.ric1 FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nt_f1_co     LIKE   uwd200.ric1 FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nt_f2_co     LIKE   uwd200.ric1 FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nt_f3_co     LIKE   uwd200.ric1 FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nt_f4_co     LIKE   uwd200.ric1 FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nt_0rq_co    LIKE   uwd200.ric1 FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nt_0ps_co    LIKE   uwd200.ric1 FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nt_btr_co    LIKE   uwd200.ric1 FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nt_otr_co    LIKE   uwd200.ric1 FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nt_ftr_co    LIKE   uwd200.ric1 FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nt_s8_co     LIKE   uwd200.ric1 FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nt_other_co  LIKE   uwd200.ric1 FORMAT ">>,>>>,>>>,>>9.99-".
/*------------------End. Comm.----------------*/

DEF WORKFILE   work_fil
    FIELD      wbrn_line   AS CHAR FORMAT "x(10)" 
    FIELD      wbranch     AS CHAR FORMAT "x(2)" 
    FIELD      wsigr       LIKE   uwm100.sigr_p    
    FIELD      wprem       LIKE   uwm100.prem_t  
    FIELD      wstat       LIKE   uwd200.ripr      
    FIELD      wret        LIKE   uwd200.ripr      
    FIELD      w0q         LIKE   uwd200.ripr      
    FIELD      w0t         LIKE   uwd200.ripr      
    FIELD      w0s         LIKE   uwd200.ripr      
    FIELD      wf1         LIKE   uwd200.ripr      
    FIELD      wf2         LIKE   uwd200.ripr      
    FIELD      wf3         LIKE   uwd200.ripr      
    FIELD      wf4         LIKE   uwd200.ripr      
    FIELD      w0rq        LIKE   uwd200.ripr      
    FIELD      w0ps        LIKE   uwd200.ripr      
    FIELD      wbtr        LIKE   uwd200.ripr      
    FIELD      wotr        LIKE   uwd200.ripr      
    FIELD      wftr        LIKE   uwd200.ripr      
    FIELD      ws8         LIKE   uwd200.ripr  
     /*------ june -----------*/
    FIELD      wfac        LIKE   uwd200.ripr   
    FIELD      wflood      AS  DECI  FORMAT ">>,>>>,>>>,>>9.99-" 
    FIELD      wstorm      AS  DECI  FORMAT ">>,>>>,>>>,>>9.99-" 
    FIELD      wearth      AS  DECI  FORMAT ">>,>>>,>>>,>>9.99-" 
    FIELD      wlccom      AS  DECI  FORMAT ">>,>>>,>>>,>>9.99-"   
    FIELD      wfrcom      AS  DECI  FORMAT ">>,>>>,>>>,>>9.99-"   
     /*------ june -----------*/

    FIELD      wpfac       LIKE   uwm200.rip1    /* june */
    FIELD      wpstat      LIKE   uwm200.rip1  
    FIELD      wpret       LIKE   uwm200.rip1  
    FIELD      wp0q        LIKE   uwm200.rip1  
    FIELD      wp0t        LIKE   uwm200.rip1  
    FIELD      wp0s        LIKE   uwm200.rip1  
    FIELD      wpf1        LIKE   uwm200.rip1  
    FIELD      wpf2        LIKE   uwm200.rip1  
    FIELD      wpf3        LIKE   uwm200.rip1  
    FIELD      wpf4        LIKE   uwm200.rip1  
    FIELD      wp0rq       LIKE   uwm200.rip1  
    FIELD      wp0ps       LIKE   uwm200.rip1  
    FIELD      wpbtr       LIKE   uwm200.rip1  
    FIELD      wpotr       LIKE   uwm200.rip1  
    FIELD      wpftr       LIKE   uwm200.rip1  
    FIELD      wps8        LIKE   uwm200.rip1  
    FIELD      wpother     LIKE   uwm200.rip1  
                                              
    FIELD      wccom       LIKE   uwm100.coty_t
    FIELD      wcfac       LIKE   uwd200.ric1   
    FIELD      wcstat      LIKE   uwd200.ric1  
    FIELD      wcret       LIKE   uwd200.ric1  
    FIELD      wc0q        LIKE   uwd200.ric1  
    FIELD      wc0t        LIKE   uwd200.ric1  
    FIELD      wc0s        LIKE   uwd200.ric1  
    FIELD      wcf1        LIKE   uwd200.ric1  
    FIELD      wcf2        LIKE   uwd200.ric1  
    FIELD      wcf3        LIKE   uwd200.ric1  
    FIELD      wcf4        LIKE   uwd200.ric1  
    FIELD      wc0rq       LIKE   uwd200.ric1  
    FIELD      wc0ps       LIKE   uwd200.ric1  
    FIELD      wcbtr       LIKE   uwd200.ric1  
    FIELD      wcotr       LIKE   uwd200.ric1  
    FIELD      wcftr       LIKE   uwd200.ric1  
    FIELD      wcs8        LIKE   uwd200.ric1  
    FIELD      wcother     LIKE   uwd200.ric1. 


DEF VAR  fac_c       AS  DECI  FORMAT  "->,>>>,>>>,>>>,>>9.99"  .
DEF VAR  nt_fac_pr   AS  DECI  FORMAT  "->,>>>,>>>,>>>,>>9.99"  .
DEF VAR  nt_fac_per  AS  DECI  FORMAT  "->,>>>,>>>,>>>,>>9.99"  .

DEF VAR  mfac_pr     AS  DECI  FORMAT  "->,>>>,>>>,>>>,>>9.99"  .
DEF VAR  nfac_c      AS  DECI  FORMAT  "->,>>>,>>>,>>>,>>9.99"  .
DEF VAR  mfac_c      AS  DECI  FORMAT  "->,>>>,>>>,>>>,>>9.99"  .

DEF VAR  n_lc_com    AS  DECI  FORMAT  "->,>>>,>>>,>>>,>>9.99"  .
DEF VAR  n_fr_com    AS  DECI  FORMAT  "->,>>>,>>>,>>>,>>9.99"  .


  
