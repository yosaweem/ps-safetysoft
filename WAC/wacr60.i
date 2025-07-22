/* wac/wacr60.i :  include of wacr60.w           */
/* Create by    :  Lukkana M. Date : 15/11/2011  */
/* Assign No   :  A54-0318                       */

DEF   VAR nv_f1_si   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR nv_f1_pr   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR nv_f1_cm   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR n_sumf1    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR n_prmf1    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR p_f1       AS DEC FORMAT ">>9.99" INIT 0.

DEF   VAR nv_f1_sib   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR nv_f1_prb   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR nv_f2_sib   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR nv_f2_prb   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.

DEF   VAR nv_f2_si   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR nv_f2_pr   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR nv_f2_cm   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR n_sumf2    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR n_prmf2    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR p_f2       AS DEC FORMAT ">>9.99" INIT 0.

DEF   VAR nv_stat_si AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR nv_stat_pr AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR n_sumq AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR n_prmq AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR p_q    AS DEC  FORMAT ">>9.99" INIT 0.

DEF   VAR nv_0rq_si AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR nv_0rq_pr AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR n_sumrq AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR n_prmrq AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR p_rq    AS DEC  FORMAT ">>9.99" INIT 0.

DEF   VAR nv_0q_si   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR nv_0q_pr   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR nv_0q_cm   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR n_sumtfp   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR n_prmtfp   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR p_tfp      AS DEC  FORMAT ">>9.99" INIT 0.

DEF   VAR nv_0t_si   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR nv_0t_pr   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR n_sumt     AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR n_prmt     AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR p_t        AS DEC  FORMAT ">>9.99" INIT 0.

DEF   VAR nv_0s_si   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR nv_0s_pr   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR n_sums AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR n_prms AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR p_s    AS DEC  FORMAT ">>9.99" INIT 0.

DEF   VAR pv_f1_si AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR pv_f1_pr AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.

DEF   VAR pv_f2_si AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR pv_f2_pr AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.

DEF   VAR pv_stat_si AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR pv_stat_pr AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.

DEF   VAR pv_0d_si   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR pv_0d_pr   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.

DEF   VAR pv_0f_si   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR pv_0f_pr   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.

DEF   VAR pv_0q_si   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR pv_0q_pr   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.

DEF   VAR pv_0t_si   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR pv_0t_pr   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.

DEF   VAR pv_0s_si   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR pv_0s_pr   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.

DEF   VAR pv_0rq_si   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR pv_0rq_pr   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.

DEF   VAR iv_f1_si AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR iv_f1_pr AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.

DEF   VAR iv_f2_si AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR iv_f2_pr AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.

DEF   VAR iv_stat_si AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR iv_stat_pr AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.

DEF   VAR iv_0d_si   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR iv_0d_pr   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.

DEF   VAR iv_0f_si   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR iv_0f_pr   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.

DEF   VAR iv_0q_si   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR iv_0q_pr   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.

DEF   VAR iv_0t_si   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR iv_0t_pr   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.

DEF   VAR iv_0s_si   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR iv_0s_pr   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.

DEF   VAR iv_0rq_si   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR iv_0rq_pr   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.

DEF   VAR pv_f1_sib AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR pv_f1_prb AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.

DEF   VAR pv_f2_sib AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR pv_f2_prb AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.

DEF   VAR pv_stat_sib AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR pv_stat_prb AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.

DEF   VAR pv_0d_sib   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR pv_0d_prb   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.

DEF   VAR pv_0q_sib   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR pv_0q_prb   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.

DEF   VAR pv_0t_sib   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR pv_0t_prb   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.

DEF   VAR pv_0s_sib  AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR pv_0s_prb   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.

DEF   VAR pv_0rq_sib   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR pv_0rq_prb   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR pv_ret_sib    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR pv_ret_prb    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR pv_0f_sib     AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR pv_0f_prb     AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.

DEF   VAR iv_f1_sib   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR iv_f1_prb   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR iv_f2_sib   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR iv_f2_prb   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.

DEF   VAR iv_stat_sib AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR iv_stat_prb AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR iv_0d_sib   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR iv_0d_prb   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR iv_0q_sib   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR iv_0q_prb   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR iv_0t_sib   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR iv_0t_prb   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR iv_0s_sib   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR iv_0s_prb   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR iv_0rq_sib  AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR iv_0rq_prb  AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR iv_ret_sib    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR iv_ret_prb    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR iv_0f_sib     AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR iv_0f_prb     AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR n_sumr        AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR n_prmr        AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR p_r           AS DEC  FORMAT ">>9.99" INIT 0.
DEF   VAR nv_totprem  AS DEC FORMAT ">>>>>>>>>>>9.99-" INIT 0.
DEF   VAR nv_totsi    AS DEC FORMAT ">>>>>>>>>>>9.99-" INIT 0.
DEF   VAR nv_decprem  AS DEC FORMAT ">>>>>>>>>>>9.99-" INIT 0.
DEF   VAR nv_decsi    AS DEC FORMAT ">>>>>>>>>>>9.99-" INIT 0.
DEF   VAR nv_incprem  AS DEC FORMAT ">>>>>>>>>>>9.99-" INIT 0.
DEF   VAR nv_incsi    AS DEC FORMAT ">>>>>>>>>>>9.99-" INIT 0.

DEF   VAR nv_totpremb  AS DEC FORMAT ">>>>>>>>>>>9.99-" INIT 0.
DEF   VAR nv_totsib    AS DEC FORMAT ">>>>>>>>>>>9.99-" INIT 0.
DEF   VAR nv_decpremb  AS DEC FORMAT ">>>>>>>>>>>9.99-" INIT 0.
DEF   VAR nv_decsib    AS DEC FORMAT ">>>>>>>>>>>9.99-" INIT 0.
DEF   VAR nv_incpremb  AS DEC FORMAT ">>>>>>>>>>>9.99-" INIT 0.
DEF   VAR nv_incsib    AS DEC FORMAT ">>>>>>>>>>>9.99-" INIT 0.

DEF  VAR nvexch      LIKE   uwm120.siexch.
DEF  VAR n_endcnt    LIKE   uwm100.endcnt.

DEF  VAR     nv_0t_sib     AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF  VAR     nv_0t_prb     AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF  VAR     nv_0s_sib     AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF  VAR     nv_0s_prb     AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF  VAR     nv_stat_sib   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF  VAR     nv_stat_prb   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF  VAR     nv_0q_sib     AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF  VAR     nv_0q_prb     AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF  VAR     nv_0rq_sib    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF  VAR     nv_0rq_prb    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF  VAR     nv_ret_sib    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF  VAR     nv_ret_prb    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF  VAR     nv_0f_sib     AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF  VAR     nv_0f_prb     AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.

DEF  VAR tem_prem    AS DEC FORMAT ">>>>>>>>>>>>9.99-" INIT 0.
DEF  VAR wrk_si      AS DEC FORMAT ">>>>>>>>>>>>9.99-" INIT 0.
DEF  VAR Bwrk_si     AS DEC FORMAT ">>>>>>>>>>>>9.99-" INIT 0.

DEF   VAR nv_0ps_si   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR nv_0ps_prb  AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR nv_0ps_sib  AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR nv_0ps_pr   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR n_sumps     AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR n_prmps     AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR p_ps        AS DEC FORMAT ">>9.99"         INIT 0.
DEF   VAR pv_0ps_si   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR pv_0ps_pr   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR iv_0ps_si   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR iv_0ps_pr   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR pv_0ps_sib  AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR pv_0ps_prb  AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR iv_0ps_sib  AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR iv_0ps_prb  AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.

DEF   VAR nv_btr_si   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR nv_btr_prb  AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR nv_btr_sib  AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR nv_btr_pr   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR n_sumbtr    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR n_prmbtr    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR p_btr       AS DEC FORMAT ">>9.99"         INIT 0.
DEF   VAR pv_btr_si   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR pv_btr_pr   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR iv_btr_si   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR iv_btr_pr   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR pv_btr_sib  AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR pv_btr_prb  AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR iv_btr_sib  AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR iv_btr_prb  AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.

DEF   VAR nv_otr_si   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR nv_otr_prb  AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR nv_otr_sib  AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR nv_otr_pr   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR n_sumotr    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR n_prmotr    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR p_otr       AS DEC FORMAT ">>9.99"         INIT 0.
DEF   VAR pv_otr_si   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR pv_otr_pr   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR iv_otr_si   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR iv_otr_pr   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR pv_otr_sib  AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR pv_otr_prb  AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR iv_otr_sib  AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR iv_otr_prb  AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.

DEF   VAR nv_f4_si   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0. 
DEF   VAR nv_f4_prb   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR nv_f4_sib   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0. 
DEF   VAR nv_f4_pr   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR nv_f4_cm   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR n_sumf4    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR n_prmf4    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR p_f4       AS DEC FORMAT ">>9.99" INIT 0.
DEF   VAR pv_f4_si AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.  
DEF   VAR pv_f4_pr AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR iv_f4_si AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0. 
DEF   VAR iv_f4_pr AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR pv_f4_sib AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0. 
DEF   VAR pv_f4_prb AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR iv_f4_sib   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0. 
DEF   VAR iv_f4_prb   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.

DEF   VAR nv_ftr_si   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0. 
DEF   VAR nv_ftr_prb  AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR nv_ftr_sib  AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR nv_ftr_pr   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR n_sumftr    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR n_prmftr    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR p_ftr       AS DEC FORMAT ">>9.99"         INIT 0.
DEF   VAR pv_ftr_si   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR pv_ftr_pr   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR iv_ftr_si   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR iv_ftr_pr   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR pv_ftr_sib  AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR pv_ftr_prb  AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR iv_ftr_sib  AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF   VAR iv_ftr_prb  AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.

DEF   VAR n_rb_pf     AS DEC FORMAT ">>9.99"           INIT 0.
DEF   VAR n_rb_sum    AS DEC FORMAT ">>>>>>>>>>>9.99-" INIT 0.
DEF   VAR n_rb_prm    AS DEC FORMAT ">>>>>>>>>>9.99-"  INIT 0.
DEF   VAR n_rf_pf     AS DEC FORMAT ">>9.99"           INIT 0.
DEF   VAR n_rf_sum    AS DEC FORMAT ">>>>>>>>>>>9.99-" INIT 0.
DEF   VAR n_rf_prm    AS DEC FORMAT ">>>>>>>>>>9.99-"  INIT 0.

DEFINE VAR s_recid AS RECID NO-UNDO.

