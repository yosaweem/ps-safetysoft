
/* wacr0010n0.i : use for wacr0010.w                           */
/* Create by    : Benjaporn J. A59-0476 date 03/10/2016        */

DEF NEW SHARED VAR n_write1   AS CHAR FORMAT "X(25)".            
DEF NEW SHARED VAR nv_datetop AS CHAR FORMAT "X(50)".
DEF NEW SHARED VAR nv-1       AS CHAR FORMAT "X(198)" .
DEF NEW SHARED VAR nv-2       AS CHAR FORMAT "X(198)".
    nv-1 = FILL("-",198).
    nv-2 = nv-1.

DEF NEW SHARED VAR n_sum       AS DECI EXTENT 6.
DEF NEW SHARED VAR n_tot       AS DECI EXTENT 6.
DEF NEW SHARED VAR n_cur       AS DECI EXTENT 6.
DEF NEW SHARED VAR n_c         AS INT.
DEF NEW SHARED VAR nvprint     AS LOG.
DEF NEW SHARED VAR n_net       AS DECI.
DEF NEW SHARED VAR nv_last     AS LOG.
DEF NEW SHARED VAR nv_csfts    LIKE uwm200.csftq.
DEF NEW SHARED VAR w_name      LIKE xmm101.name INITIAL[""].
DEF NEW SHARED VAR n_cnt       AS INT.
DEF NEW SHARED VAR n_cnt1      AS INT.
DEF NEW SHARED VAR w_etime     AS CHAR.
DEF NEW SHARED VAR w_dtime     AS CHAR.
DEF NEW SHARED VAR n_etime     AS INTEGER.
DEF NEW SHARED VAR n_dtime     AS INTEGER.

DEF NEW SHARED VAR n_sumr      AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR n_prmr      AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR p_r         AS DEC FORMAT "->>9.99" INIT 0.

DEF NEW SHARED VAR nv_stat_si  AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR nv_stat_pr  AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR nv_stat_cm  AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR n_sumq      AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR n_prmq      AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR p_q         AS DEC FORMAT "->>9.99" INIT 0.

DEF NEW SHARED VAR nv_0q_si    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR nv_0q_pr    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR nv_0q_cm    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR n_sumtfp    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR n_prmtfp    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR p_tfp       AS DEC FORMAT "->>9.99" INIT 0.

DEF NEW SHARED VAR nv_0t_si    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR nv_0t_pr    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR nv_0t_cm    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR n_sumt      AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR n_prmt      AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR p_t         AS DEC FORMAT "->>9.99" INIT 0.

DEF NEW SHARED VAR nv_0rq_si   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR nv_0rq_pr   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR nv_0rq_cm   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR n_sumrq     AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR n_prmrq     AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR p_rq        AS DEC FORMAT "->>9.99" INIT 0.

DEF NEW SHARED VAR nv_0s_si    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR nv_0s_pr    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR nv_0s_cm    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR n_sums      AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR n_prms      AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR p_s         AS DEC  FORMAT "->>9.99" INIT 0.
DEF NEW SHARED VAR nv_ret      AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.

DEF NEW SHARED VAR nv_f1_si    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR nv_f1_pr    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR nv_f1_cm    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR n_sumf1     AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR n_prmf1     AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR p_f1        AS DEC FORMAT "->>9.99" INIT 0.

DEF NEW SHARED VAR nv_f2_si    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR nv_f2_pr    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR nv_f2_cm    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR n_sumf2     AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR n_prmf2     AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR p_f2        AS DEC FORMAT "->>9.99" INIT 0.

DEF NEW SHARED VAR nv_totprem  AS DEC FORMAT ">>>>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR nv_totsi    AS DEC FORMAT ">>>>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR nv_totcm    AS DEC FORMAT ">>>>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR nv_ret_si   AS DEC FORMAT ">>>>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR nv_ret_pr   AS DEC FORMAT ">>>>>>>>>>>9.99-" INIT 0.

DEF NEW SHARED VAR n_insur     AS CHAR FORMAT "X(50)".
DEF NEW SHARED VAR nv_rett     AS INT FORMAT "999".
DEF NEW SHARED VAR nv_sum      LIKE   uwm120.sigr.
DEF NEW SHARED VAR nv_sibht    LIKE   uwm120.sigr.
DEF NEW SHARED VAR nvexch      LIKE   uwm120.siexch.
DEF NEW SHARED VAR nv_tem      LIKE   uwm100.sigr_p.
DEF NEW SHARED VAR ret_prem    LIKE   uwm100.prem_t.
DEF NEW SHARED VAR nv_code     LIKE   uwm120.sicurr.
DEF NEW SHARED VAR n_riskgp    LIKE   uwd120.riskgp.

DEF NEW SHARED VAR n_risi      AS CHAR FORMAT "X(19)".
DEF NEW SHARED VAR n_net0      AS CHAR FORMAT "X(17)".

DEF NEW SHARED VAR n_branch    LIKE uwm100.branch.
DEF NEW SHARED VAR n_bdes      LIKE xmm023.bdes.
DEF NEW SHARED VAR n_dir       LIKE uwm100.dir_ri.

DEF NEW SHARED VAR nv_0t_sib    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR nv_0t_prb    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR nv_0f_sib    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR nv_0f_prb    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR nv_ret_sib   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR nv_ret_prb   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR nv_0s_sib    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR nv_0s_prb    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR nv_0q_sib    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR nv_0q_prb    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR nv_0rq_sib   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR nv_0rq_prb   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR nv_stat_sib  AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR nv_stat_prb  AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR nv_f1_sib    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR nv_f1_prb    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR nv_f2_sib    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR nv_f2_prb    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR nv_totsib    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR nv_totpremb  AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.

DEF NEW SHARED VAR n_0t_sib     AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3 INIT 0.
DEF NEW SHARED VAR n_0t_prb     AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3 INIT 0.
DEF NEW SHARED VAR n_0f_sib     AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3 INIT 0.
DEF NEW SHARED VAR n_0f_prb     AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3 INIT 0.
DEF NEW SHARED VAR n_ret_sib    AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3 INIT 0.
DEF NEW SHARED VAR n_ret_prb    AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3 INIT 0.
DEF NEW SHARED VAR n_0s_sib     AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3 INIT 0.
DEF NEW SHARED VAR n_0s_prb     AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3 INIT 0.
DEF NEW SHARED VAR n_0q_sib     AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3 INIT 0.
DEF NEW SHARED VAR n_0q_prb     AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3 INIT 0.
DEF NEW SHARED VAR n_0rq_sib    AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3 INIT 0.
DEF NEW SHARED VAR n_0rq_prb    AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3 INIT 0.
DEF NEW SHARED VAR n_stat_sib   AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3 INIT 0.
DEF NEW SHARED VAR n_stat_prb   AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3 INIT 0.
DEF NEW SHARED VAR n_f1_sib     AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3 INIT 0.
DEF NEW SHARED VAR n_f1_prb     AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3 INIT 0.
DEF NEW SHARED VAR n_f2_sib     AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3 INIT 0.
DEF NEW SHARED VAR n_f2_prb     AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3 INIT 0.
DEF NEW SHARED VAR n_totsib     AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3 INIT 0.
DEF NEW SHARED VAR n_totpremb   AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3 INIT 0.

DEF NEW SHARED VAR nv_0ps_si    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR nv_0ps_pr    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR nv_0ps_cm    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR n_sumps      AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR n_prmps      AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR p_ps         AS DEC FORMAT "->>9.99"        INIT 0.
DEF NEW SHARED VAR nv_0ps_sib   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR nv_0ps_prb   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR n_0ps_sib    AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3 INIT 0.
DEF NEW SHARED VAR n_0ps_prb    AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3 INIT 0.

DEF NEW SHARED VAR n_effect     AS INTE  FORMAT "9".
DEF NEW SHARED VAR s_recid      AS RECID.

DEF NEW SHARED VAR nv_btr_si    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR nv_btr_pr    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR nv_btr_cm    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR n_sumbtr     AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR n_prmbtr     AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR p_btr        AS DEC FORMAT "->>9.99"        INIT 0.
DEF NEW SHARED VAR nv_btr_sib   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR nv_btr_prb   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR n_btr_sib    AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3 INIT 0.
DEF NEW SHARED VAR n_btr_prb    AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3 INIT 0.

DEF NEW SHARED VAR nv_otr_si    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR nv_otr_pr    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR nv_otr_cm    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR n_sumotr     AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR n_prmotr     AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR p_otr        AS DEC FORMAT "->>9.99"        INIT 0.
DEF NEW SHARED VAR nv_otr_sib   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR nv_otr_prb   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR n_otr_sib    AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3 INIT 0.
DEF NEW SHARED VAR n_otr_prb    AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3 INIT 0.

DEF NEW SHARED VAR nv_f4_si    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR nv_f4_pr    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR nv_f4_cm    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR n_sumf4     AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR n_prmf4     AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR p_f4        AS DEC FORMAT "->>9.99"        INIT 0.
DEF NEW SHARED VAR nv_f4_sib   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR nv_f4_prb   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR n_f4_sib    AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3 INIT 0.
DEF NEW SHARED VAR n_f4_prb    AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3 INIT 0.

DEF NEW SHARED VAR nv_ftr_si   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR nv_ftr_pr   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR nv_ftr_cm   AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR n_sumftr    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR n_prmftr    AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR p_ftr       AS DEC FORMAT "->>9.99"        INIT 0.
DEF NEW SHARED VAR nv_ftr_sib  AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR nv_ftr_prb  AS DEC FORMAT ">>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR n_ftr_sib   AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3 INIT 0.
DEF NEW SHARED VAR n_ftr_prb   AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3 INIT 0.

DEF NEW SHARED VAR n_rb_pf     AS DEC FORMAT "->>9.99"          INIT 0.
DEF NEW SHARED VAR n_rb_sum    AS DEC FORMAT ">>>>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR n_rb_prm    AS DEC FORMAT ">>>>>>>>>>9.99-"  INIT 0.
DEF NEW SHARED VAR n_rf_pf     AS DEC FORMAT "->>9.99"          INIT 0.
DEF NEW SHARED VAR n_rf_sum    AS DEC FORMAT ">>>>>>>>>>>9.99-" INIT 0.
DEF NEW SHARED VAR n_rf_prm    AS DEC FORMAT ">>>>>>>>>>9.99-"  INIT 0.


