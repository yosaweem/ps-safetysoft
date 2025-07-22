&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
CREATE WIDGET-POOL.
DEF VAR n_proc AS INT.
DEF VAR n_report AS CHAR FORMAT "X(2)".
DEF VAR n_type AS CHAR FORMAT "X(03)".
DEF VAR n_type_to AS CHAR FORMAT "X(03)".
DEF VAR nv_dir2 AS LOGI FORMAT "D/R" INIT "D".
DEF VAR n_date_fr AS DATE FORMAT "99/99/9999".
DEF VAR n_date_to AS DATE FORMAT "99/99/9999".
DEF VAR n_rel AS CHAR FORMAT "X(1)" init "Y".
DEF VAR n_bran AS CHAR FORMAT "X(2)" init "0".
DEF VAR n_brto AS CHAR FORMAT "X(2)" init "Z".
DEF VAR n_broker AS LOGICAL.
DEF VAR n_frbr AS CHAR FORMAT "X(2)".
DEF VAR n_tobr AS CHAR FORMAT "X(2)".
DEF VAR n_prntyp AS INT FORMAT "9" INITIAL 1.
DEF VAR n_write AS CHAR FORMAT "X(25)".
DEF VAR n_write1 AS CHAR FORMAT "X(25)".
DEF VAR nv_output AS CHAR FORMAT  "X(25)".
DEF VAR nv_datetop AS CHAR FORMAT "X(50)".
DEF VAR n_sum AS DECI EXTENT 6.
DEF VAR n_tot AS DECI EXTENT 6.
DEF VAR n_cur AS DECI EXTENT 6.
DEF VAR n_c AS INT.
DEF VAR nvprint AS LOG.
DEF VAR n_net AS DECI.
DEF VAR nv_last AS LOG.
DEF VAR nv_csfts LIKE uwm200.csftq.
DEF VAR n_cnt AS INT.
DEF VAR n_cnt1 AS INT.
DEF VAR w_etime AS CHAR.
DEF VAR w_dtime AS CHAR.
DEF VAR n_etime AS INTEGER.
DEF VAR n_dtime AS INTEGER.
DEF VAR n_sumr AS DEC.
DEF VAR n_prmr AS DEC.
DEF VAR p_r AS DEC FORMAT ">>9.99".
DEF VAR nv_stat_si AS DEC.
DEF VAR nv_stat_pr AS DEC.
DEF VAR nv_stat_cm AS DEC.
DEF VAR n_sumq AS DEC.
DEF VAR n_prmq AS DEC.
DEF VAR p_q AS DEC FORMAT ">>9.99".
DEF VAR nv_0q_si AS DEC.
DEF VAR nv_0q_pr AS DEC.
DEF VAR nv_0q_cm AS DEC.
DEF VAR n_sumtfp AS DEC.
DEF VAR n_prmtfp AS DEC.
DEF VAR p_tfp AS DEC FORMAT ">>9.99".
DEF VAR nv_0t_si AS DEC.
DEF VAR nv_0t_pr AS DEC.
DEF VAR nv_0t_cm AS DEC.
DEF VAR n_sumt AS DEC.
DEF VAR n_prmt AS DEC.
DEF VAR p_t AS DEC FORMAT ">>9.99".
DEF VAR nv_0rq_si AS DEC.
DEF VAR nv_0rq_pr AS DEC.
DEF VAR nv_0rq_cm AS DEC.
DEF VAR n_sumrq AS DEC.
DEF VAR n_prmrq AS DEC.
DEF VAR p_rq AS DEC FORMAT ">>9.99".
DEF VAR nv_0s_si AS DEC.
DEF VAR nv_0s_pr AS DEC.
DEF VAR nv_0s_cm AS DEC.
DEF VAR n_sums AS DEC.
DEF VAR n_prms AS DEC.
DEF VAR p_s AS DEC FORMAT ">>9.99".
DEF VAR nv_ret AS DEC.
DEF VAR nv_f1_si AS DEC.
DEF VAR nv_f1_pr AS DEC.
DEF VAR nv_f1_cm AS DEC.
DEF VAR n_sumf1 AS DEC.
DEF VAR n_prmf1 AS DEC.
DEF VAR p_f1 AS DEC FORMAT ">>9.99".
DEF VAR nv_f2_si AS DEC.
DEF VAR nv_f2_pr AS DEC.
DEF VAR nv_f2_cm AS DEC.
DEF VAR n_sumf2 AS DEC.
DEF VAR n_prmf2 AS DEC.
DEF VAR p_f2 AS DEC FORMAT ">>9.99".
DEF VAR nv_totprem AS DEC.
DEF VAR nv_totsi AS DEC.
DEF VAR nv_totcm AS DEC.
DEF VAR nv_ret_si AS DEC.
DEF VAR nv_ret_pr AS DEC.
DEF VAR n_insur AS CHAR FORMAT "X(50)".
DEF VAR nv_rett AS INT FORMAT "999".
DEF VAR nv_sum LIKE uwm120.sigr.
DEF VAR nv_sibht LIKE uwm120.sigr.
DEF VAR nvexch LIKE uwm120.siexch.
DEF VAR nv_tem LIKE uwm100.sigr_p.
DEF VAR ret_prem LIKE uwm100.prem_t.
DEF VAR nv_code LIKE uwm120.sicurr.
DEF VAR n_riskgp LIKE uwd120.riskgp.
DEF VAR n_risi AS CHAR FORMAT "X(19)".
DEF VAR n_net0 AS CHAR FORMAT "X(17)".
DEF VAR n_branch LIKE uwm100.branch.
DEF VAR n_bdes LIKE xmm023.bdes.
DEF VAR n_dir LIKE uwm100.dir_ri.
DEF VAR nv_0t_sib AS DEC.
DEF VAR nv_0t_prb AS DEC.
DEF VAR nv_0f_sib AS DEC.
DEF VAR nv_0f_prb AS DEC.
DEF VAR nv_ret_sib AS DEC.
DEF VAR nv_ret_prb AS DEC.
DEF VAR nv_0s_sib AS DEC.
DEF VAR nv_0s_prb AS DEC.
DEF VAR nv_0q_sib AS DEC.
DEF VAR nv_0q_prb AS DEC.
DEF VAR nv_0rq_sib AS DEC.
DEF VAR nv_0rq_prb AS DEC.
DEF VAR nv_stat_sib AS DEC.
DEF VAR nv_stat_prb AS DEC.
DEF VAR nv_f1_sib AS DEC.
DEF VAR nv_f1_prb AS DEC.
DEF VAR nv_f2_sib AS DEC.
DEF VAR nv_f2_prb AS DEC.
DEF VAR nv_totsib AS DEC.
DEF VAR nv_totpremb AS DEC FORMAT ">>>>>>>>>9.99-".
DEF VAR n_0t_sib AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3.
DEF VAR n_0t_prb AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3.
DEF VAR n_0f_sib AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3.
DEF VAR n_0f_prb AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3.
DEF VAR n_ret_sib AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3.
DEF VAR n_ret_prb AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3.
DEF VAR n_0s_sib AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3.
DEF VAR n_0s_prb AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3.
DEF VAR n_0q_sib AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3.
DEF VAR n_0q_prb AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3.
DEF VAR n_0rq_sib AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3.
DEF VAR n_0rq_prb AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3.
DEF VAR n_stat_sib AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3.
DEF VAR n_stat_prb AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3.
DEF VAR n_f1_sib AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3.
DEF VAR n_f1_prb AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3.
DEF VAR n_f2_sib AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3.
DEF VAR n_f2_prb AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3.
DEF VAR n_totsib AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3.
DEF VAR n_totpremb AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3.
DEF VAR nv_0ps_si AS DEC.
DEF VAR nv_0ps_pr AS DEC.
DEF VAR nv_0ps_cm AS DEC.
DEF VAR n_sumps AS DEC.
DEF VAR n_prmps AS DEC.
DEF VAR p_ps AS DEC FORMAT ">>9.99".
DEF VAR nv_0ps_sib AS DEC.
DEF VAR nv_0ps_prb AS DEC.
DEF VAR n_0ps_sib AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3.
DEF VAR n_0ps_prb AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3.
DEF VAR n_effect AS INTE FORMAT "9".
DEF VAR s_recid AS RECID.
DEF VAR nv_btr_si AS DEC.
DEF VAR nv_btr_pr AS DEC.
DEF VAR nv_btr_cm AS DEC.
DEF VAR n_sumbtr AS DEC.
DEF VAR n_prmbtr AS DEC.
DEF VAR p_btr AS DEC FORMAT ">>9.99".
DEF VAR nv_btr_sib AS DEC.
DEF VAR nv_btr_prb AS DEC.
DEF VAR n_btr_sib AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3.
DEF VAR n_btr_prb AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3.
DEF VAR nv_otr_si AS DEC.
DEF VAR nv_otr_pr AS DEC.
DEF VAR nv_otr_cm AS DEC.
DEF VAR n_sumotr AS DEC.
DEF VAR n_prmotr AS DEC.
DEF VAR p_otr AS DEC FORMAT ">>9.99".
DEF VAR nv_otr_sib AS DEC.
DEF VAR nv_otr_prb AS DEC.
DEF VAR n_otr_sib AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3.
DEF VAR n_otr_prb AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3.
DEF VAR nv_f4_si AS DEC.
DEF VAR nv_f4_pr AS DEC.
DEF VAR nv_f4_cm AS DEC.
DEF VAR n_sumf4 AS DEC.
DEF VAR n_prmf4 AS DEC.
DEF VAR p_f4 AS DEC FORMAT ">>9.99".
DEF VAR nv_f4_sib AS DEC.
DEF VAR nv_f4_prb AS DEC.
DEF VAR n_f4_sib AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3.
DEF VAR n_f4_prb AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3.
DEF VAR nv_ftr_si AS DEC.
DEF VAR nv_ftr_pr AS DEC.
DEF VAR nv_ftr_cm AS DEC.
DEF VAR n_sumftr AS DEC.
DEF VAR n_prmftr AS DEC.
DEF VAR p_ftr AS DEC FORMAT ">>9.99".
DEF VAR nv_ftr_sib AS DEC.
DEF VAR nv_ftr_prb AS DEC.
DEF VAR n_ftr_sib AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3.
DEF VAR n_ftr_prb AS DEC FORMAT ">>>>>>>>>9.99-" EXTENT 3.
DEF VAR n_rb_pf AS DEC FORMAT ">>9.99".
DEF VAR n_rb_sum AS DEC.
DEF VAR n_rb_prm AS DEC.
DEF VAR n_rf_pf AS DEC FORMAT ">>9.99".
DEF VAR n_rf_sum AS DEC.
DEF VAR n_rf_prm AS DEC.
DEF VAR n_br1 AS CHAR FORMAT "X".
DEF VAR n_br2 AS CHAR FORMAT "X".
DEF VAR n_mr1 AS CHAR FORMAT "XX".
DEF VAR n_mr2 AS CHAR FORMAT "XX".
DEF VAR n_fr_pol AS CHAR FORMAT "X".
DEF VAR n_riname AS CHAR FORMAT "X(40)".
DEF VAR br_totsib LIKE nv_totsib  .
DEF VAR br_totpremb LIKE nv_totpremb.
DEF VAR br_f1_sib LIKE nv_f1_sib.
DEF VAR br_f1_prb LIKE nv_f1_prb.
DEF VAR br_f2_sib LIKE nv_f2_sib.
DEF VAR br_f2_prb LIKE nv_f2_prb.
DEF VAR br_0t_sib LIKE nv_0t_sib.
DEF VAR br_0t_prb LIKE nv_0t_prb.
DEF VAR br_0s_sib LIKE nv_0s_sib.
DEF VAR br_0s_prb LIKE nv_0s_prb.
DEF VAR br_stat_sib LIKE nv_stat_sib.
DEF VAR br_stat_prb LIKE nv_stat_prb.
DEF VAR br_0q_sib LIKE nv_0q_sib.
DEF VAR br_0q_prb LIKE nv_0q_prb.
DEF VAR br_0rq_sib LIKE nv_0rq_sib.
DEF VAR br_0rq_prb LIKE nv_0rq_prb.
DEF VAR br_ret_sib LIKE nv_ret_sib.
DEF VAR br_ret_prb LIKE nv_ret_prb.
DEF VAR br_0f_sib LIKE nv_0f_sib.
DEF VAR br_0f_prb LIKE nv_0f_prb.
DEF VAR br_0ps_sib LIKE nv_0ps_sib.
DEF VAR br_0ps_prb LIKE nv_0ps_prb.
DEF VAR br_btr_sib LIKE nv_0ps_sib.
DEF VAR br_btr_prb LIKE nv_0ps_prb.
DEF VAR br_otr_sib LIKE nv_0ps_sib.
DEF VAR br_otr_prb LIKE nv_0ps_prb.
DEF VAR br_f4_sib LIKE nv_f4_sib.
DEF VAR br_f4_prb LIKE nv_f4_prb.
DEF VAR br_ftr_sib LIKE nv_ftr_sib.
DEF VAR br_ftr_prb LIKE nv_ftr_prb.
DEF VAR p_s8 AS DECI FORMAT ">>9.99".
DEF VAR n_sums8 AS DEC.
DEF VAR n_prms8 AS DEC.
DEF VAR nv_s8_si AS DEC.
DEF VAR nv_s8_pr AS DEC.
DEF VAR nv_s8_cm AS DEC.
DEF VAR nv_s8_sib AS DEC.
DEF VAR nv_s8_prb AS DEC.
DEF VAR br_s8_sib AS DEC.
DEF VAR br_s8_prb AS DEC.
DEF WORKFILE wrk0f
FIELD rico AS CHAR FORMAT "X(7)"
FIELD cess AS INTE FORMAT "9999999"
FIELD pf   AS DECI FORMAT ">>9.99"
FIELD sumf AS DECI FORMAT ">>,>>>,>>9.99-"
FIELD prmf AS DECI FORMAT ">,>>>,>>9.99-".
DEF VAR nv_frm_policy AS CHAR FORMAT "X(16)". 
DEF VAR nv_to_policy AS CHAR FORMAT "X(16)". 
DEF VAR nv_gstrat AS CHAR FORMAT "X(20)".   
DEF VAR n_vatf1 AS DEC.   
DEF VAR n_vatf2 AS DEC.  
DEF VAR n_vatt AS DEC.   
DEF VAR n_vatq AS DEC. 
DEF VAR n_vatr AS DEC.   
DEF VAR nv_prmf1 AS DEC.
DEF VAR nv_prmf2 AS DEC.
DEF VAR nv_prmt AS DEC.
DEF VAR nv_prmq AS DEC.
DEF VAR nv_prmr AS DEC.
DEF WORKFILE wvat7
FIELD wyear  AS CHAR FORMAT "X(4)"
FIELD wvat   AS DEC
FIELD wvalf1 AS DEC
FIELD wvalf2 AS DEC    
FIELD wvalt  AS DEC 
FIELD wvalq  AS DEC
FIELD wvalr  AS DEC.
DEF VAR pv_f1_si AS DEC.
DEF VAR pv_f1_pr AS DEC.
DEF VAR pv_f2_si AS DEC.
DEF VAR pv_f2_pr AS DEC.
DEF VAR pv_stat_si AS DEC.
DEF VAR pv_stat_pr AS DEC.
DEF VAR pv_0d_si AS DEC.
DEF VAR pv_0d_pr AS DEC.
DEF VAR pv_0f_si AS DEC.
DEF VAR pv_0f_pr AS DEC.
DEF VAR pv_0q_si AS DEC.
DEF VAR pv_0q_pr AS DEC.
DEF VAR pv_0t_si AS DEC.
DEF VAR pv_0t_pr AS DEC.
DEF VAR pv_0s_si AS DEC.
DEF VAR pv_0s_pr AS DEC.
DEF VAR pv_0rq_si AS DEC.
DEF VAR pv_0rq_pr AS DEC.
DEF VAR iv_f1_si AS DEC.
DEF VAR iv_f1_pr AS DEC.
DEF VAR iv_f2_si AS DEC.
DEF VAR iv_f2_pr AS DEC.
DEF VAR iv_stat_si AS DEC.
DEF VAR iv_stat_pr AS DEC.
DEF VAR iv_0d_si AS DEC.
DEF VAR iv_0d_pr AS DEC.
DEF VAR iv_0f_si AS DEC.
DEF VAR iv_0f_pr AS DEC.
DEF VAR iv_0q_si AS DEC.
DEF VAR iv_0q_pr AS DEC.
DEF VAR iv_0t_si AS DEC.
DEF VAR iv_0t_pr AS DEC.
DEF VAR iv_0s_si AS DEC.
DEF VAR iv_0s_pr AS DEC.
DEF VAR iv_0rq_si AS DEC.
DEF VAR iv_0rq_pr AS DEC.
DEF VAR pv_f1_sib AS DEC.
DEF VAR pv_f1_prb AS DEC.
DEF VAR pv_f2_sib AS DEC.
DEF VAR pv_f2_prb AS DEC.
DEF VAR pv_stat_sib AS DEC.
DEF VAR pv_stat_prb AS DEC.
DEF VAR pv_0d_sib AS DEC.
DEF VAR pv_0d_prb AS DEC.
DEF VAR pv_0q_sib AS DEC.
DEF VAR pv_0q_prb AS DEC.
DEF VAR pv_0t_sib AS DEC.
DEF VAR pv_0t_prb AS DEC.
DEF VAR pv_0s_sib AS DEC.
DEF VAR pv_0s_prb AS DEC.
DEF VAR pv_0rq_sib AS DEC.
DEF VAR pv_0rq_prb AS DEC.
DEF VAR pv_ret_sib AS DEC.
DEF VAR pv_ret_prb AS DEC.
DEF VAR pv_0f_sib AS DEC.
DEF VAR pv_0f_prb AS DEC.
DEF VAR iv_f1_sib AS DEC.
DEF VAR iv_f1_prb AS DEC.
DEF VAR iv_f2_sib AS DEC.
DEF VAR iv_f2_prb AS DEC.
DEF VAR iv_stat_sib AS DEC.
DEF VAR iv_stat_prb AS DEC.
DEF VAR iv_0d_sib AS DEC.
DEF VAR iv_0d_prb AS DEC.
DEF VAR iv_0q_sib AS DEC.
DEF VAR iv_0q_prb AS DEC.
DEF VAR iv_0t_sib AS DEC.
DEF VAR iv_0t_prb AS DEC.
DEF VAR iv_0s_sib AS DEC.
DEF VAR iv_0s_prb AS DEC.
DEF VAR iv_0rq_sib AS DEC.
DEF VAR iv_0rq_prb AS DEC.
DEF VAR iv_ret_sib AS DEC.
DEF VAR iv_ret_prb AS DEC.
DEF VAR iv_0f_sib AS DEC.
DEF VAR iv_0f_prb AS DEC.
DEF VAR nv_decprem AS DEC.
DEF VAR tem_prem AS DEC.
DEF VAR nv_decsi AS DEC.
DEF VAR nv_incprem AS DEC.
DEF VAR nv_incsi AS DEC.
DEF VAR nv_decpremb AS DEC.
DEF VAR nv_decsib AS DEC.
DEF VAR nv_incpremb AS DEC.
DEF VAR nv_incsib AS DEC.
DEF VAR pv_s8_si AS DEC.
DEF VAR pv_s8_pr AS DEC.
DEF VAR iv_s8_si AS DEC.
DEF VAR iv_s8_pr AS DEC.
DEF VAR pv_s8_sib AS DEC.
DEF VAR pv_s8_prb AS DEC.
DEF VAR iv_s8_sib AS DEC.
DEF VAR iv_s8_prb AS DEC.
DEF VAR pv_0ps_si AS DEC.
DEF VAR pv_0ps_pr AS DEC.
DEF VAR iv_0ps_si AS DEC.
DEF VAR iv_0ps_pr AS DEC.
DEF VAR pv_0ps_sib AS DEC.
DEF VAR pv_0ps_prb AS DEC.
DEF VAR iv_0ps_sib AS DEC.
DEF VAR iv_0ps_prb AS DEC.
DEF VAR pv_btr_si AS DEC.
DEF VAR pv_btr_pr AS DEC.
DEF VAR iv_btr_si AS DEC.
DEF VAR iv_btr_pr AS DEC.
DEF VAR pv_btr_sib AS DEC.
DEF VAR pv_btr_prb AS DEC.
DEF VAR iv_btr_sib AS DEC.
DEF VAR iv_btr_prb AS DEC.
DEF VAR pv_otr_si AS DEC. 
DEF VAR pv_otr_pr AS DEC. 
DEF VAR iv_otr_si AS DEC. 
DEF VAR iv_otr_pr AS DEC. 
DEF VAR pv_otr_sib AS DEC.
DEF VAR pv_otr_prb AS DEC.
DEF VAR iv_otr_sib AS DEC.
DEF VAR iv_otr_prb AS DEC. 
DEF VAR pv_f4_si AS DEC. 
DEF VAR pv_f4_pr AS DEC. 
DEF VAR iv_f4_si AS DEC. 
DEF VAR iv_f4_pr AS DEC.
DEF VAR pv_f4_sib AS DEC.
DEF VAR pv_f4_prb AS DEC.
DEF VAR iv_f4_sib AS DEC.
DEF VAR iv_f4_prb AS DEC.
DEF VAR pv_ftr_si AS DEC. 
DEF VAR pv_ftr_pr AS DEC. 
DEF VAR iv_ftr_si AS DEC. 
DEF VAR iv_ftr_pr AS DEC. 
DEF VAR pv_ftr_sib AS DEC.
DEF VAR pv_ftr_prb AS DEC.
DEF VAR iv_ftr_sib AS DEC.
DEF VAR iv_ftr_prb AS DEC.
DEF VAR nv_pol AS CHAR FORMAT "X(16)".
DEF VAR n_endcnt LIKE uwm100.endcnt.
DEF VAR wrk_si AS DEC.
DEF VAR Bwrk_si AS DEC.
DEF VAR nv_mbsi LIKE uwm120.sigr.
DEF BUFFER buwd200 FOR uwd200.
DEF BUFFER buwm307 FOR uwm307.
DEF BUFFER buwm120 FOR uwm120.
DEF WORKFILE work_fil
    FIELD    wbrn_line AS    CHAR    FORMAT "x(10)" COLUMN-LABEL "Line"
    FIELD    wsigr   LIKE  uwm100.sigr_p COLUMN-LABEL "Sum Insured"
    FIELD    wprem   LIKE  uwm100.prem_t COLUMN-LABEL "Prem Totot"
    FIELD    wstat   LIKE  uwd200.ripr  COLUMN-LABEL "Qbaht"
    FIELD    wret    LIKE  uwd200.ripr  COLUMN-LABEL "RETEN"
    FIELD    w0q     LIKE  uwd200.ripr  COLUMN-LABEL "TFP"
    FIELD    w0t     LIKE  uwd200.ripr  COLUMN-LABEL "1st"
    FIELD    w0s     LIKE  uwd200.ripr  COLUMN-LABEL "2nd"
    FIELD    wf1     LIKE  uwd200.ripr  COLUMN-LABEL "F1"
    FIELD    wf2     LIKE  uwd200.ripr  COLUMN-LABEL "F2"
    FIELD    wf3     LIKE  uwd200.ripr  COLUMN-LABEL "F3"
    FIELD    wf4     LIKE  uwd200.ripr  COLUMN-LABEL "F4"   
    FIELD    w0rq    LIKE  uwd200.ripr  COLUMN-LABEL "Q/S"
    FIELD    w0ps    LIKE  uwd200.ripr  COLUMN-LABEL "MPS"
    FIELD    wbtr    LIKE  uwd200.ripr  COLUMN-LABEL "BTR"  
    FIELD    wotr    LIKE  uwd200.ripr  COLUMN-LABEL "OTR"
    FIELD    wftr    LIKE  uwd200.ripr  COLUMN-LABEL "FTR"  
    FIELD    ws8     LIKE  uwd200.ripr  COLUMN-LABEL "S8"
    FIELD    wother  LIKE  uwd200.ripr  COLUMN-LABEL "OTHER"
    FIELD    wsigrp    AS DECI FORMAT ">>,>>>,>>>,>>9.99" 
    FIELD    wpremp    AS DECI FORMAT ">>,>>>,>>>,>>9.99" 
    FIELD    wstatp    AS DECI FORMAT ">>,>>>,>>>,>>9.99" 
    FIELD    wretp     AS DECI FORMAT ">>,>>>,>>>,>>9.99" 
    FIELD    w0qp      AS DECI FORMAT ">>,>>>,>>>,>>9.99" 
    FIELD    w0tp      AS DECI FORMAT ">>,>>>,>>>,>>9.99" 
    FIELD    w0sp      AS DECI FORMAT ">>,>>>,>>>,>>9.99" 
    FIELD    wf1p      AS DECI FORMAT ">>,>>>,>>>,>>9.99" 
    FIELD    wf2p      AS DECI FORMAT ">>,>>>,>>>,>>9.99" 
    FIELD    wf3p      AS DECI FORMAT ">>,>>>,>>>,>>9.99" 
    FIELD    wf4p      AS DECI FORMAT ">>,>>>,>>>,>>9.99" 
    FIELD    w0rqp     AS DECI FORMAT ">>,>>>,>>>,>>9.99" 
    FIELD    w0psp     AS DECI FORMAT ">>,>>>,>>>,>>9.99" 
    FIELD    wbtrp     AS DECI FORMAT ">>,>>>,>>>,>>9.99" 
    FIELD    wotrp     AS DECI FORMAT ">>,>>>,>>>,>>9.99"
    FIELD    wftrp     AS DECI FORMAT ">>,>>>,>>>,>>9.99"
    FIELD    ws8p      AS DECI FORMAT ">>,>>>,>>>,>>9.99" 
    FIELD    wotherp   AS DECI FORMAT ">>,>>>,>>>,>>9.99"
    FIELD    wsigrs    AS DECI FORMAT ">>,>>>,>>>,>>9.99" 
    FIELD    wprems    AS DECI FORMAT ">>,>>>,>>>,>>9.99" 
    FIELD    wstats    AS DECI FORMAT ">>,>>>,>>>,>>9.99" 
    FIELD    wrets     AS DECI FORMAT ">>,>>>,>>>,>>9.99" 
    FIELD    w0qs      AS DECI FORMAT ">>,>>>,>>>,>>9.99" 
    FIELD    w0ts      AS DECI FORMAT ">>,>>>,>>>,>>9.99" 
    FIELD    w0ss      AS DECI FORMAT ">>,>>>,>>>,>>9.99" 
    FIELD    wf1s      AS DECI FORMAT ">>,>>>,>>>,>>9.99" 
    FIELD    wf2s      AS DECI FORMAT ">>,>>>,>>>,>>9.99" 
    FIELD    wf3s      AS DECI FORMAT ">>,>>>,>>>,>>9.99" 
    FIELD    wf4s      AS DECI FORMAT ">>,>>>,>>>,>>9.99" 
    FIELD    w0rqs     AS DECI FORMAT ">>,>>>,>>>,>>9.99" 
    FIELD    w0pss     AS DECI FORMAT ">>,>>>,>>>,>>9.99" 
    FIELD    wbtrs     AS DECI FORMAT ">>,>>>,>>>,>>9.99"
    FIELD    wotrs     AS DECI FORMAT ">>,>>>,>>>,>>9.99" 
    FIELD    wftrs     AS DECI FORMAT ">>,>>>,>>>,>>9.99" 
    FIELD    ws8s      AS DECI FORMAT ">>,>>>,>>>,>>9.99"
    FIELD    wothers   AS DECI FORMAT ">>,>>>,>>>,>>9.99".

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_proctyp fi_reptyp fi_poltyp fi_poltyp_to ~
fi_dir fi_datfr fi_datto fi_brfr fi_brto fi_output czjovtwiBu_ok Bu_Cancel ~
fi_dirdesc IMAGE-24 RECT-303 RECT-304 RECT-305 RECT-306 
&Scoped-Define DISPLAYED-OBJECTS fi_proctyp fi_reptyp fi_poltyp ~
fi_poltyp_to fi_dir fi_datfr fi_datto fi_brfr fi_brto fi_broker ~
fi_broker_to fi_output fi_dirdesc 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON Bu_Cancel AUTO-END-KEY 
     LABEL "Cancel" 
     SIZE 13 BY 1.76
     BGCOLOR 8 FONT 6.

DEFINE BUTTON czjovtwiBu_ok AUTO-END-KEY 
     LABEL "OK" 
     SIZE 13 BY 1.76
     BGCOLOR 8 FONT 6.

DEFINE VARIABLE fi_brfr AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 4.67 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_broker AS CHARACTER FORMAT "X(7)":U 
     VIEW-AS FILL-IN 
     SIZE 10.33 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_broker_to AS CHARACTER FORMAT "X(7)":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_brto AS CHARACTER FORMAT "X(7)":U 
     VIEW-AS FILL-IN 
     SIZE 4.67 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_datfr AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13.33 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_datto AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_dir AS LOGICAL FORMAT "D/I":U INITIAL NO 
     VIEW-AS FILL-IN 
     SIZE 4.5 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_dirdesc AS CHARACTER FORMAT "X(3)":U 
      VIEW-AS TEXT 
     SIZE 10 BY .86
     BGCOLOR 3 FGCOLOR 4 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_output AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 29.67 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_poltyp AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 6.17 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_poltyp_to AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 6.33 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_proctyp AS INTEGER FORMAT "9":U INITIAL 2 
     VIEW-AS FILL-IN 
     SIZE 4.5 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_reptyp AS INTEGER FORMAT "9":U INITIAL 2 
     VIEW-AS FILL-IN 
     SIZE 4.5 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE IMAGE IMAGE-24
     FILENAME "WIMAGE\bgc01":U
     SIZE 88.5 BY 19.52.

DEFINE RECTANGLE RECT-303
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 84.5 BY 16.19
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-304
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 81.5 BY .24.

DEFINE RECTANGLE RECT-305
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 82 BY .24.

DEFINE RECTANGLE RECT-306
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 81.5 BY .24.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     fi_proctyp AT ROW 3.19 COL 33.33 COLON-ALIGNED NO-LABEL
     fi_reptyp AT ROW 4.33 COL 33.5 COLON-ALIGNED NO-LABEL
     fi_poltyp AT ROW 6.48 COL 33 COLON-ALIGNED NO-LABEL
     fi_poltyp_to AT ROW 6.48 COL 61.17 COLON-ALIGNED NO-LABEL
     fi_dir AT ROW 7.95 COL 33 COLON-ALIGNED NO-LABEL
     fi_datfr AT ROW 9.38 COL 33 COLON-ALIGNED NO-LABEL
     fi_datto AT ROW 9.33 COL 61.17 COLON-ALIGNED NO-LABEL
     fi_brfr AT ROW 10.81 COL 33 COLON-ALIGNED NO-LABEL
     fi_brto AT ROW 10.81 COL 61.17 COLON-ALIGNED NO-LABEL
     fi_broker AT ROW 14 COL 32.83 COLON-ALIGNED NO-LABEL
     fi_broker_to AT ROW 14 COL 61.33 COLON-ALIGNED NO-LABEL
     fi_output AT ROW 16.14 COL 32.67 COLON-ALIGNED NO-LABEL
     czjovtwiBu_ok AT ROW 18.14 COL 27.5
     Bu_Cancel AT ROW 18.19 COL 49
     fi_dirdesc AT ROW 8.05 COL 39 COLON-ALIGNED NO-LABEL
     IMAGE-24 AT ROW 1 COL 1
     RECT-303 AT ROW 1.48 COL 3
     RECT-304 AT ROW 15.48 COL 4.5
     RECT-305 AT ROW 5.67 COL 4.5
     RECT-306 AT ROW 12.33 COL 4
     "       รายงานทะเบียน OUTWARD TREATY POLICY AND ENDORSEMENT" VIEW-AS TEXT
          SIZE 83.83 BY .95 AT ROW 1.95 COL 3.33
          BGCOLOR 1 FGCOLOR 15 FONT 36
     "To  :" VIEW-AS TEXT
          SIZE 5.17 BY .95 AT ROW 10.95 COL 57.67
          BGCOLOR 3 FONT 6
     "Policy Type From  :" VIEW-AS TEXT
          SIZE 18 BY 1.19 AT ROW 6.48 COL 16
          BGCOLOR 3 FONT 6
     "Output To  :" VIEW-AS TEXT
          SIZE 12 BY .95 AT ROW 16.14 COL 22.33
          BGCOLOR 3 FONT 6
     "PROCESS FOR  :" VIEW-AS TEXT
          SIZE 16.5 BY 1.19 AT ROW 3.14 COL 17.83
          BGCOLOR 3 FONT 6
     "1 = Policy , 2 = Endorse." VIEW-AS TEXT
          SIZE 25 BY .95 AT ROW 3.24 COL 41.33
          BGCOLOR 3 FGCOLOR 4 FONT 6
     "Direct = D , Inward = I  :" VIEW-AS TEXT
          SIZE 23.5 BY 1.19 AT ROW 7.91 COL 11
          BGCOLOR 3 FONT 6
     "REPORT TYPE :" VIEW-AS TEXT
          SIZE 16.83 BY 1.19 AT ROW 4.24 COL 18.33
          BGCOLOR 3 FONT 6
     "1 = Detail, 2 = Summary" VIEW-AS TEXT
          SIZE 25 BY .95 AT ROW 4.33 COL 41.5
          BGCOLOR 3 FGCOLOR 4 FONT 6
     "Transaction Date From  :" VIEW-AS TEXT
          SIZE 23.5 BY 1.19 AT ROW 9.38 COL 10.83
          BGCOLOR 3 FONT 6
     "To  :" VIEW-AS TEXT
          SIZE 5.17 BY 1 AT ROW 9.48 COL 57.67
          BGCOLOR 3 FONT 6
     "Marine Broker :" VIEW-AS TEXT
          SIZE 15.5 BY .95 AT ROW 12.71 COL 4.5
          BGCOLOR 3 FGCOLOR 8 FONT 6
     "Broker Code From  :" VIEW-AS TEXT
          SIZE 20 BY .95 AT ROW 14.05 COL 15
          BGCOLOR 3 FONT 6
     "To  :" VIEW-AS TEXT
          SIZE 5.5 BY .95 AT ROW 14 COL 57.67
          BGCOLOR 3 FONT 6
     "Release  :  YES" VIEW-AS TEXT
          SIZE 15.5 BY .71 AT ROW 8.1 COL 52.5
          BGCOLOR 3 FGCOLOR 8 FONT 6
     "To  :" VIEW-AS TEXT
          SIZE 5.17 BY .95 AT ROW 6.62 COL 57.5
          BGCOLOR 3 FONT 6
     "Branch From  :" VIEW-AS TEXT
          SIZE 14 BY 1.19 AT ROW 10.81 COL 20.33
          BGCOLOR 3 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 88.67 BY 19.67
         BGCOLOR 10 .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Window
   Allow: Basic,Browse,DB-Fields,Window,Query
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW C-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "รายงานทะเบียน - WACTBLNN.W"
         HEIGHT             = 19.67
         WIDTH              = 88.67
         MAX-HEIGHT         = 35.33
         MAX-WIDTH          = 170.67
         VIRTUAL-HEIGHT     = 35.33
         VIRTUAL-WIDTH      = 170.67
         RESIZE             = yes
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = ?
         FGCOLOR            = ?
         KEEP-FRAME-Z-ORDER = yes
         THREE-D            = yes
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME DEFAULT-FRAME
   Custom                                                               */
/* SETTINGS FOR FILL-IN fi_broker IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_broker_to IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
ASSIGN 
       fi_dirdesc:HIDDEN IN FRAME DEFAULT-FRAME           = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* รายงานทะเบียน - WACTBLNN.W */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* รายงานทะเบียน - WACTBLNN.W */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Bu_Cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bu_Cancel C-Win
ON CHOOSE OF Bu_Cancel IN FRAME DEFAULT-FRAME /* Cancel */
DO:
    Apply "Close" To This-Procedure.
    Return No-Apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME czjovtwiBu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL czjovtwiBu_ok C-Win
ON CHOOSE OF czjovtwiBu_ok IN FRAME DEFAULT-FRAME /* OK */
DO:
    ASSIGN  nv_output   = TRIM(n_write) + ".SLK".
    
    
    IF n_proc = 1  THEN DO:       /*--Policy--*/
       IF INPUT fi_reptyp = 1 THEN RUN ProcPol.   /* Detail */
       ELSE RUN ProcSummp.                       /* Summary */
    END.
    ELSE DO:                      /*-- Endorse. --*/
       IF INPUT fi_reptyp = 1 THEN RUN ProcEnd.  /* Detail */
       ELSE RUN  ProcSumme.
    END.

    MESSAGE "Process Data Complete!!" VIEW-AS ALERT-BOX INFORMATION.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_brfr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_brfr C-Win
ON LEAVE OF fi_brfr IN FRAME DEFAULT-FRAME
DO:
    ASSIGN fi_brfr = CAPS (INPUT FRAME {&FRAME-NAME} fi_brfr)
           n_bran  = fi_brfr.

    DISP   fi_brfr WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_broker
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_broker C-Win
ON LEAVE OF fi_broker IN FRAME DEFAULT-FRAME
DO:
  ASSIGN fi_broker = INPUT FRAME {&FRAME-NAME} fi_broker
         n_frbr = fi_broker.

  DISP   fi_broker   WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_broker_to
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_broker_to C-Win
ON LEAVE OF fi_broker_to IN FRAME DEFAULT-FRAME
DO:
  ASSIGN
        fi_broker_to = INPUT FRAME {&FRAME-NAME} fi_broker_to.

        IF fi_broker_to = ? THEN fi_broker_to = fi_broker.

        IF fi_broker = ? AND fi_broker_to = ? THEN 
           MESSAGE "Please, Key In From Broker" 
           VIEW-AS ALERT-BOX INFORMATION.

        IF INPUT fi_broker_to < n_frbr THEN DO:
           BELL.
           MESSAGE "Broker must be greater than or equal Broker From".
           NEXT-PROMPT fi_broker_to  WITH FRAME  {&FRAME-NAME}.
           NEXT.
       END.

       ASSIGN n_tobr = fi_broker_to.
       DISP   fi_broker fi_broker_to  WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_brto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_brto C-Win
ON LEAVE OF fi_brto IN FRAME DEFAULT-FRAME
DO:
  ASSIGN  fi_brto = CAPS (INPUT FRAME {&FRAME-NAME} fi_brto)
          n_brto  = fi_brto.

  DISP fi_brto WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_datfr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_datfr C-Win
ON LEAVE OF fi_datfr IN FRAME DEFAULT-FRAME
DO:
  ASSIGN fi_datfr = INPUT FRAME {&FRAME-NAME} fi_datfr.

  IF fi_datto = ? THEN fi_datto = fi_datfr.

  IF fi_datfr = ? AND fi_datto = ? THEN 
     MESSAGE "Please, Key In From Date" 
     VIEW-AS ALERT-BOX INFORMATION.

  ASSIGN n_date_fr = INPUT fi_datfr.

  DISP fi_datfr fi_datto WITH FRAME {&FRAME-NAME}.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_datto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_datto C-Win
ON LEAVE OF fi_datto IN FRAME DEFAULT-FRAME
DO:
  ASSIGN 
     fi_datto = INPUT FRAME {&FRAME-NAME} fi_datto
     n_date_to  = fi_datto.

  IF fi_datto = ?  THEN
     MESSAGE  "Please, Key In To Date"
     VIEW-AS ALERT-BOX INFORMATION.

  IF fi_datto < fi_datfr THEN
     MESSAGE "DATE TO ต้องมากกว่าหรือเท่ากับ DATE FROM"
     VIEW-AS ALERT-BOX INFORMATION.

  DISP fi_datto WITH FRAME {&FRAME-NAME}.

  ASSIGN   nv_datetop = " "
           nv_datetop = "ประจำวันที่ : " + string(n_date_fr,"99/99/9999")
           nv_datetop = nv_datetop + " - " + string(n_date_to,"99/99/9999").

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dir C-Win
ON LEAVE OF fi_dir IN FRAME DEFAULT-FRAME
DO:
  ASSIGN 
    fi_dir  = INPUT fi_dir
    nv_dir2 = fi_dir.
  IF nv_dir2 = YES THEN n_report = "D".
  ELSE n_report = "I".

  DISP   fi_dir  WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_output
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_output C-Win
ON LEAVE OF fi_output IN FRAME DEFAULT-FRAME
DO:
  ASSIGN  fi_output = INPUT FRAME {&FRAME-NAME} fi_output.

  IF fi_output <> "" THEN  n_write = CAPS(INPUT fi_output).

  DISP fi_output WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_poltyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_poltyp C-Win
ON LEAVE OF fi_poltyp IN FRAME DEFAULT-FRAME
DO:
    ASSIGN fi_poltyp = CAPS (INPUT FRAME {&FRAME-NAME} fi_poltyp).
    
    FIND  xmm031  USE-INDEX xmm03101  WHERE xmm031.poltyp = INPUT fi_poltyp
    NO-LOCK NO-ERROR.
       IF NOT AVAILABLE  xmm031  THEN DO:
          BELL.
          MESSAGE "Policy type not on file xmm031.".
          NEXT-PROMPT  fi_poltyp   WITH FRAME {&FRAME-NAME}.
          NEXT.
       END.

       n_type  =  CAPS(INPUT fi_poltyp).
       DISP fi_poltyp WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_poltyp_to
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_poltyp_to C-Win
ON LEAVE OF fi_poltyp_to IN FRAME DEFAULT-FRAME
DO:
    ASSIGN fi_poltyp_to = CAPS (INPUT FRAME {&FRAME-NAME} fi_poltyp_to).
    
    FIND  xmm031  USE-INDEX xmm03101  WHERE xmm031.poltyp = INPUT fi_poltyp_to
    NO-LOCK NO-ERROR.
       IF NOT AVAILABLE  xmm031  THEN DO:
          BELL.
          MESSAGE "Policy type not on file xmm031.".
          NEXT-PROMPT  fi_poltyp_to   WITH FRAME {&FRAME-NAME}.
          NEXT.
       END.
       IF fi_proctyp = 2 THEN DO:
        IF INPUT fi_poltyp_to  < INPUT fi_poltyp 
        THEN DO:
          BELL.
          MESSAGE "Policy Type To  must be equal or greater than Policy Type From". PAUSE .
          NEXT-PROMPT  fi_poltyp_to   WITH FRAME {&FRAME-NAME}.
          NEXT.
        END.
       END.
       ELSE DO:
        IF SUBSTRING(INPUT fi_poltyp_to,2,2)  < SUBSTRING(INPUT fi_poltyp,2,2) 
        THEN DO:
          BELL.
          MESSAGE "Policy Type To  must be equal or greater than Policy Type From". PAUSE .
          NEXT-PROMPT  fi_poltyp_to   WITH FRAME {&FRAME-NAME}.
          NEXT.
        END.
       END.
       
     ASSIGN n_type_to  = CAPS(INPUT fi_poltyp_to).
     DISP   fi_poltyp_to WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_proctyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_proctyp C-Win
ON LEAVE OF fi_proctyp IN FRAME DEFAULT-FRAME
DO:

  ASSIGN fi_proctyp = INPUT fi_proctyp. 
  IF fi_proctyp = 1 THEN DO:
     ENABLE fi_broker fi_broker_to WITH FRAME {&FRAME-NAME}.
     ASSIGN fi_broker    = "0"
            fi_broker_to = "Z".
     DISP fi_broker fi_broker_to WITH FRAME {&FRAME-NAME}.

     
  END.
  ELSE DO:
      ASSIGN fi_broker = ""
             fi_broker_to = ""
             fi_poltyp = "C90"
             fi_poltyp_to = "M85".
      DISP   fi_broker fi_broker_to fi_poltyp fi_poltyp_to 
      WITH FRAME {&FRAME-NAME}. 
      DISABLE fi_broker fi_broker_to WITH FRAME {&FRAME-NAME}.
  END.

      n_proc =  fi_proctyp.
  DISP    fi_dir  WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_reptyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_reptyp C-Win
ON LEAVE OF fi_reptyp IN FRAME DEFAULT-FRAME
DO:
  ASSIGN fi_reptyp = INPUT fi_reptyp. 
  
  IF fi_reptyp = 2 THEN DO:
     DISABLE fi_poltyp fi_poltyp_to 
             fi_dir fi_brfr fi_brto 
             fi_broker fi_broker_to WITH FRAME {&FRAME-NAME}.
     
     ASSIGN  fi_poltyp = ""
             fi_poltyp_to = ""
             fi_dir   = ?
             fi_dirdesc = "D/I"
             fi_datfr = TODAY.

     DISP  fi_poltyp fi_poltyp_to 
           fi_dir    fi_datfr    fi_dirdesc WITH FRAME {&FRAME-NAME}. 
      
  END.
      
  DISP    fi_dir  WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */
/*-----Create By Sayamol----*/
/*----Assign: A49-0008----*/
/* Set CURRENT-WINDOW: this will parent dialog-boxes and frames.        */
ASSIGN CURRENT-WINDOW                = {&WINDOW-NAME} 
       THIS-PROCEDURE:CURRENT-WINDOW = {&WINDOW-NAME}.

/* The CLOSE event can be used from inside or outside the procedure to  */
/* terminate it.                                                        */
ON CLOSE OF THIS-PROCEDURE 
   RUN disable_UI.

/* Best default for GUI applications is...                              */
PAUSE 0 BEFORE-HIDE.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.

  SESSION:DATA-ENTRY-RETURN = YES.

  ASSIGN fi_proctyp   = 1
         fi_reptyp    = 1
         fi_poltyp    = "F10"
         fi_poltyp_to = "C91"
         fi_dir       = YES
         fi_datfr     = TODAY
         fi_datto     = TODAY
         fi_brfr      = "0"
         fi_brto      = "Z".

  DISP fi_proctyp fi_reptyp fi_poltyp fi_poltyp_to fi_dir 
       fi_datfr   fi_datto  fi_brfr   fi_brto   
  WITH FRAME {&FRAME-NAME}.
  

  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE clrEnd C-Win 
PROCEDURE clrEnd :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
     nv_sum      = 0
     nv_totprem  = 0
     nv_totsi    = 0
     nv_totpremb = 0
     nv_totsib   = 0
     tem_prem    = 0
     nv_incprem  = 0
     nv_incsi    = 0
     nv_incpremb = 0
     nv_incsib   = 0
     nv_decprem  = 0
     nv_decsi    = 0
     nv_decpremb = 0
     nv_decsib   = 0
     nv_gstrat   = "".
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE clrTOT C-Win 
PROCEDURE clrTOT :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
      br_0t_sib    = 0         br_totsib   = 0
      br_0t_prb    = 0         br_totpremb = 0
      br_0s_sib    = 0         br_f1_sib   = 0
      br_0s_prb    = 0         br_f1_prb   = 0
      br_stat_sib  = 0         br_f2_sib   = 0
      br_stat_prb  = 0         br_f2_prb   = 0
      br_0q_sib    = 0         br_0q_prb   = 0
      br_0f_sib    = 0         br_0f_prb   = 0
      br_ret_sib   = 0         br_ret_prb  = 0
      br_0rq_sib   = 0         br_0rq_prb  = 0
      br_0ps_sib   = 0         br_0ps_prb  = 0  
      br_btr_sib   = 0         br_btr_prb  = 0  
      br_otr_sib   = 0         br_otr_prb  = 0 
      br_s8_sib    = 0         br_s8_prb   = 0
      br_f4_sib    = 0         br_f4_prb   = 0
      br_ftr_sib   = 0         br_ftr_prb  = 0. 

ASSIGN
   n_br2  =  " "    n_mr2  =  " "
   nv_f1_si   = 0   nv_f1_pr    = 0
   nv_f2_si   = 0   nv_f2_pr    = 0
   nv_0t_si   = 0   nv_0t_pr    = 0
   nv_0s_si   = 0   nv_0s_pr    = 0
   nv_stat_si = 0   nv_stat_pr  = 0
   nv_0q_si   = 0   nv_0q_pr    = 0
   nv_0rq_si  = 0   nv_0rq_pr   = 0
   nv_0ps_si  = 0   nv_0ps_pr   = 0        
   nv_btr_si  = 0   nv_btr_pr   = 0        
   nv_otr_si  = 0   nv_otr_pr   = 0        
   nv_totsi   = 0   nv_totprem  = 0
   nv_s8_si   = 0   nv_s8_pr    = 0
   nv_f4_si   = 0   nv_f4_pr    = 0
   nv_ftr_si  = 0   nv_ftr_pr   = 0.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE clrval_AllEnd C-Win 
PROCEDURE clrval_AllEnd :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN nv_0t_si   = 0   nv_0t_pr    = 0
       nv_0s_si   = 0   nv_0s_pr    = 0
       nv_stat_si = 0   nv_stat_pr  = 0
       nv_0q_si   = 0   nv_0q_pr    = 0
       nv_0rq_si  = 0   nv_0rq_pr   = 0
       nv_s8_si   = 0   nv_s8_pr    = 0   
       nv_f1_si   = 0   nv_f1_pr    = 0
       nv_f2_si   = 0   nv_f2_pr    = 0
       
       pv_0t_si   = 0   pv_0t_pr    = 0
       pv_0s_si   = 0   pv_0s_pr    = 0
       pv_stat_si = 0   pv_stat_pr  = 0
       pv_0q_si   = 0   pv_0q_pr    = 0
       pv_0rq_si  = 0   pv_0rq_pr   = 0
       pv_s8_si   = 0   pv_s8_pr    = 0   
       pv_f1_si   = 0   pv_f1_pr    = 0
       pv_f2_si   = 0   pv_f2_pr    = 0
       
       iv_0t_si   = 0   iv_0t_pr    = 0
       iv_0s_si   = 0   iv_0s_pr    = 0
       iv_stat_si = 0   iv_stat_pr  = 0
       iv_0q_si   = 0   iv_0q_pr    = 0
       iv_0rq_si  = 0   iv_0rq_pr   = 0
       iv_s8_si   = 0   iv_s8_pr    = 0   
       iv_f1_si   = 0   iv_f1_pr    = 0
       iv_f2_si   = 0   iv_f2_pr    = 0
       
       nv_totsi   = 0   nv_totprem  = 0
       nv_decsi   = 0   nv_decprem  = 0
       nv_incsi   = 0   nv_incprem  = 0
       
       nv_0ps_si  = 0   nv_0ps_pr   = 0
       pv_0ps_si  = 0   pv_0ps_pr   = 0
       iv_0ps_si  = 0   iv_0ps_pr   = 0
       
       nv_btr_si  = 0   nv_btr_pr   = 0
       pv_btr_si  = 0   pv_btr_pr   = 0
       iv_btr_si  = 0   iv_btr_pr   = 0
       nv_otr_si  = 0   nv_otr_pr   = 0
       pv_otr_si  = 0   pv_otr_pr   = 0
       iv_otr_si  = 0   iv_otr_pr   = 0
       
       nv_f4_si   = 0   nv_f4_pr    = 0
       pv_f4_si   = 0   pv_f4_pr    = 0
       iv_f4_si   = 0   iv_f4_pr    = 0
       nv_ftr_si  = 0   nv_ftr_pr   = 0
       pv_ftr_si  = 0   pv_ftr_pr   = 0
       iv_ftr_si  = 0   iv_ftr_pr   = 0.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE clrval_br C-Win 
PROCEDURE clrval_br :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN  nv_0t_sib    = 0        nv_totsib   = 0
        nv_0t_prb    = 0        nv_totpremb = 0
        nv_0s_sib    = 0        nv_f1_sib   = 0
        nv_0s_prb    = 0        nv_f1_prb   = 0
        nv_stat_sib  = 0        nv_f2_sib   = 0
        nv_stat_prb  = 0        nv_f2_prb   = 0
        nv_0q_sib    = 0        nv_0q_prb   = 0
        nv_0rq_sib   = 0        nv_0rq_prb  = 0
        nv_ret_sib   = 0        nv_ret_prb  = 0
        nv_0f_sib    = 0        nv_0f_prb   = 0
        nv_0ps_sib   = 0        nv_0ps_prb  = 0  
        nv_btr_sib   = 0        nv_btr_prb  = 0  
        nv_otr_sib   = 0        nv_otr_prb  = 0       
        nv_s8_sib    = 0        nv_s8_prb   = 0
        nv_f4_sib    = 0        nv_f4_prb   = 0
        nv_ftr_sib   = 0        nv_ftr_prb  = 0.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE clrval_DEnd C-Win 
PROCEDURE clrval_DEnd :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
        nv_sum = 0 
        p_t    = 000  n_sumt   = 0   n_prmt    = 0
        p_s    = 000  n_sums   = 0   n_prms    = 0
        p_q    = 000  n_sumq   = 0   n_prmq    = 0
        p_tfp  = 000  n_sumtfp = 0   n_prmtfp  = 0
        p_rq   = 000  n_sumrq  = 0   n_prmrq   = 0
        p_f1   = 000  n_sumf1  = 0   n_prmf1   = 0
        p_f2   = 000  n_sumf2  = 0   n_prmf2   = 0
        p_r    = 000  n_sumr   = 0   n_prmr    = 0
        p_ps   = 000  n_sumps  = 0   n_prmps   = 0 
        p_btr  = 000  n_sumbtr = 0   n_prmbtr  = 0 
        p_otr  = 000  n_sumotr = 0   n_prmotr  = 0 
        p_s8   = 000  n_sums8  = 0   n_prms8   = 0 
        p_f4   = 000  n_sumf4  = 0   n_prmf4   = 0
        p_ftr  = 000  n_sumftr = 0   n_prmftr  = 0

        n_rb_pf  = 000            n_rb_sum  = 0          n_rb_prm  = 0
        n_rf_pf  = 000            n_rf_sum  = 0          n_rf_prm  = 0.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE DetailEnd C-Win 
PROCEDURE DetailEnd :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
EXPORT DELIMITER ";"
    n_branch  
    n_bdes         
    uwm100.trndat  
    uwm100.policy  
    uwm100.endno   
    n_insur        
    nv_sum         
    uwm100.prem_t  

    p_f1          
    n_sumf1       
    n_prmf1       
    nv_gstrat     

    p_f2           
    n_sumf2        
    n_prmf2        
    nv_gstrat      

    p_t            
    n_sumt         
    n_prmt         
    nv_gstrat      

    p_s            
    n_sums         
    n_prms         

    p_q            
    n_sumq         
    n_prmq         
    nv_gstrat      

    p_tfp         
    n_sumtfp      
    n_prmtfp      

    p_rq          
    n_sumrq       
    n_prmrq       

    p_r           
    n_sumr        
    n_prmr        
    nv_gstrat 
   
    p_ps          
    n_sumps       
    n_prmps       
    
    p_btr         
    n_sumbtr      
    n_prmbtr      

    p_otr         
    n_sumotr      
    n_prmotr      
    
    p_s8           
    n_sums8        
    n_prms8        
    

    
    p_f4          
    n_sumf4       
    n_prmf4       

    p_ftr         
    n_sumftr      
    n_prmftr

    n_rb_pf           
    n_rb_sum     
    n_rb_prm     
    n_rf_pf      
    n_rf_sum     
    n_rf_prm.
OUTPUT CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE DetailPol C-Win 
PROCEDURE DetailPol :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
EXPORT DELIMITER ";"
         n_branch  
         n_bdes         
         uwm100.trndat  
         uwm200.policy  
         n_insur  
         nv_sibht          
         uwm100.prem_t    
         p_f1      
         n_sumf1   
         n_prmf1   
     nv_gstrat   /*--Add VAT--*/

         p_f2           
         n_sumf2        
         n_prmf2        
     nv_gstrat   /*--Add VAT--*/

         p_t            
         n_sumt         
         n_prmt         

         p_s            
         n_sums         
         n_prms         
     nv_gstrat   /*--Add VAT--*/

         p_q            
         n_sumq         
         n_prmq         
     nv_gstrat   /*--Add VAT--*/

         p_tfp          
         n_sumtfp       
         n_prmtfp       

         p_rq           
         n_sumrq        
         n_prmrq        

         p_r            
         n_sumr         
         n_prmr         
     nv_gstrat  /*--Add VAT--*/
         
         p_ps      
         n_sumps   
         n_prmps   
         
         p_btr     
         n_sumbtr  
         n_prmbtr  

         p_otr     
         n_sumotr  
         n_prmotr    
     
     p_s8          
     n_sums8       
     n_prms8  

         p_f4           
         n_sumf4        
         n_prmf4        

         p_ftr     
         n_sumftr  
         n_prmftr
/*---*/     
     n_rb_pf   
     n_rb_sum  
     n_rb_prm  

     n_rf_pf   
     n_rf_sum  
     n_rf_prm.
/*----*/
OUTPUT CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI C-Win  _DEFAULT-DISABLE
PROCEDURE disable_UI :
/*------------------------------------------------------------------------------
  Purpose:     DISABLE the User Interface
  Parameters:  <none>
  Notes:       Here we clean-up the user-interface by deleting
               dynamic widgets we have created and/or hide 
               frames.  This procedure is usually called when
               we are ready to "clean-up" after running.
------------------------------------------------------------------------------*/
  /* Delete the WINDOW we created */
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
  THEN DELETE WIDGET C-Win.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI C-Win  _DEFAULT-ENABLE
PROCEDURE enable_UI :
/*------------------------------------------------------------------------------
  Purpose:     ENABLE the User Interface
  Parameters:  <none>
  Notes:       Here we display/view/enable the widgets in the
               user-interface.  In addition, OPEN all queries
               associated with each FRAME and BROWSE.
               These statements here are based on the "Other 
               Settings" section of the widget Property Sheets.
------------------------------------------------------------------------------*/
  DISPLAY fi_proctyp fi_reptyp fi_poltyp fi_poltyp_to fi_dir fi_datfr fi_datto 
          fi_brfr fi_brto fi_broker fi_broker_to fi_output fi_dirdesc 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE fi_proctyp fi_reptyp fi_poltyp fi_poltyp_to fi_dir fi_datfr fi_datto 
         fi_brfr fi_brto fi_output czjovtwiBu_ok Bu_Cancel fi_dirdesc IMAGE-24 
         RECT-303 RECT-304 RECT-305 RECT-306 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE prnColumn_E C-Win 
PROCEDURE prnColumn_E :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
EXPORT DELIMITER ";"
    "บริษัทประกันคุ้มภัย จำกัด (มหาชน)"  "" "" "" ""       
    "วันที่พิมพ์ : " 
    TODAY FORMAT "99/99/9999".
EXPORT DELIMITER ";"
    ""  ""  
    "สมุดทะเบียนการประกันภัยต่อตามสัญญา"   ""
    "เวลาพิมพ์ : " 
    STRING(n_etime,"HH:MM:SS")   
    "WACTBTTY".
EXPORT DELIMITER ";"
    "ประกันตรง/ต่อ"  
    n_report                                       
    nv_datetop   ""                                  
    "Release : " 
    n_rel.
EXPORT DELIMITER ";"
    "ประเภท" 
    n_type + " - " + n_type_to  
    "สลักหลัง"   ""                               
    "สลักหลัง (ท.บ.3,ท.บ.1.6)".
EXPORT DELIMITER ";" "".    
EXPORT DELIMITER ";"
    "สาขา" 
    "ประเภทกรมธรรม์" 
    "วันทำสัญญา" 
    "เลขที่กรมธรรม์" 
    "เลขที่สลักหลัง"
    "ชื่อผู้เอาประกัน" 
    "จำนวนเงินเอาประกันภัยรวม" 
    "เบี้ยประกันภัยรวม" 
    "%FO1" 
    "จำนวนเงินเอาประกันภัย" 
    "เบี้ยประกันภัย" 
    "% Vat"    /*--Add VAT--*/
    "%FO2" 
    "จำนวนเงินเอาประกันภัย" 
    "เบี้ยประกันภัย" 
    "% Vat"    /*--Add VAT--*/
    "%T" 
    "จำนวนเงินเอาประกันภัย" 
    "เบี้ยประกันภัย" 
    "% Vat"    /*--Add VAT--*/
    "%S"        
    "จำนวนเงินเอาประกันภัย" 
    "เบี้ยประกันภัย" 
    "%Q"        
    "จำนวนเงินเอาประกันภัย" 
    "เบี้ยประกันภัย" 
    "% Vat"   /*--Add VAT--*/
    "%TFP"   
    "จำนวนเงินเอาประกันภัย" 
    "เบี้ยประกันภัย" 
    "%QS"    
    "จำนวนเงินเอาประกันภัย" 
    "เบี้ยประกันภัย" 
    "%R" 
    "จำนวนเงินเอาประกันภัย" 
    "เบี้ยประกันภัย" 
    "% Vat"  /*--Add VAT--*/
    "%MPS"    
    "จำนวนเงินเอาประกันภัย" 
    " เบี้ยประกันภัย" 
    "%BTR"     
    "จำนวนเงินเอาประกันภัย" 
    "เบี้ยประกันภัย" 
    "%OTR"    
    "จำนวนเงินเอาประกันภัย" 
    "เบี้ยประกันภัย" 
    "%F03 +S8" ";"  
    "จำนวนเงินเอาประกันภัย" 
    "เบี้ยประกันภัย" 
    "%FO4" 
    "จำนวนเงินเอาประกันภัย" 
    "เบี้ยประกันภัย" 
    "%FTR" 
    "จำนวนเงินเอาประกันภัย" 
    "เบี้ยประกันภัย" 
    "%F Local Fac" 
    "จำนวนเงินเอาประกันภัย Local Fac" 
    "เบี้ยประกันภัย Local Fac" 
    "%F Foreign Fac" 
    "จำนวนเงินเอาประกันภัย Foreign Fac"
    "เบี้ยประกันภัย Foreign Fac".
OUTPUT CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE prnColumn_P C-Win 
PROCEDURE prnColumn_P :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
EXPORT DELIMITER ";"
    "บริษัทประกันคุ้มภัย จำกัด (มหาชน)"   "" "" "" ""      
    "วันที่พิมพ์ : " 
    TODAY FORMAT "99/99/9999".
EXPORT DELIMITER ";"
    ""  ""  
    "สมุดทะเบียนการประกันภัยต่อตามสัญญา"   ""
    "เวลาพิมพ์ : " 
    STRING(n_etime,"HH:MM:SS")   
    "WACTBTTY".
EXPORT DELIMITER ";"
    "ประกันตรง/ต่อ"  
    n_report                                       
    nv_datetop   ""                                  
    "Release : " 
    n_rel.
EXPORT DELIMITER ";"
    "ประเภท" 
    n_type + " - " + n_type_to  
    "กรมธรรม์"   ""                               
    "กรมธรรม์ (ท.บ.1,ท.บ.1.5)".
EXPORT DELIMITER ";" "".    
EXPORT DELIMITER ";"
    "สาขา" 
    "ประเภทกรมธรรม์" 
    "วันทำสัญญา" 
    "เลขที่กรมธรรม์" 
    "ชื่อผู้เอาประกัน" 
    "จำนวนเงินเอาประกันภัยรวม" 
    "เบี้ยประกันภัยรวม" 
    "%FO1" 
    "จำนวนเงินเอาประกันภัย" 
    "เบี้ยประกันภัย" 
    "% Vat"    /*--Add VAT--*/
    "%FO2" 
    "จำนวนเงินเอาประกันภัย" 
    "เบี้ยประกันภัย" 
    "% Vat"    /*--Add VAT--*/
    "%T" 
    "จำนวนเงินเอาประกันภัย" 
    "เบี้ยประกันภัย" 
    "% Vat"    /*--Add VAT--*/
    "%S"        
    "จำนวนเงินเอาประกันภัย" 
    "เบี้ยประกันภัย" 
    "%Q"        
    "จำนวนเงินเอาประกันภัย" 
    "เบี้ยประกันภัย" 
    "% Vat"   /*--Add VAT--*/
    "%TFP"   
    "จำนวนเงินเอาประกันภัย" 
    "เบี้ยประกันภัย" 
    "%QS"    
    "จำนวนเงินเอาประกันภัย" 
    "เบี้ยประกันภัย" 
    "%R" 
    "จำนวนเงินเอาประกันภัย" 
    "เบี้ยประกันภัย" 
    "% Vat"  /*--Add VAT--*/
    "%MPS"    
    "จำนวนเงินเอาประกันภัย" 
    " เบี้ยประกันภัย" 
    "%BTR"     
    "จำนวนเงินเอาประกันภัย" 
    "เบี้ยประกันภัย" 
    "%OTR"    
    "จำนวนเงินเอาประกันภัย" 
    "เบี้ยประกันภัย" 
    "%F03 +S8" ";"  
    "จำนวนเงินเอาประกันภัย" 
    "เบี้ยประกันภัย" 
    "%FO4" 
    "จำนวนเงินเอาประกันภัย" 
    "เบี้ยประกันภัย" 
    "%FTR" 
    "จำนวนเงินเอาประกันภัย" 
    "เบี้ยประกันภัย" 
    "%F Local Fac" 
    "จำนวนเงินเอาประกันภัย Local Fac" 
    "เบี้ยประกันภัย Local Fac" 
    "%F Foreign Fac" 
    "จำนวนเงินเอาประกันภัย Foreign Fac"
    "เบี้ยประกันภัย Foreign Fac".
OUTPUT CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE prnTOTAllEnd C-Win 
PROCEDURE prnTOTAllEnd :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
EXPORT DELIMITER ";"
   "รวมทั้งสิ้น" 
   "" "" "" "" ""
   nv_totsib    
   nv_totpremb  
   ""
   nv_f1_sib    
   nv_f1_prb    
   ""
   ""
   nv_f2_sib    
   nv_f2_prb    
   ""
   ""
   nv_0t_sib    
   nv_0t_prb    
   ""
   ""
   nv_0s_sib    
   nv_0s_prb    
   ""
   nv_stat_sib  
   nv_stat_prb  
   ""
   ""
   nv_0q_sib    
   nv_0q_prb    
   ""
   nv_0rq_sib   
   nv_0rq_prb   
   ""
   nv_ret_sib   
   nv_ret_prb   
   ""
   ""
   nv_0ps_sib   
   nv_0ps_prb   
   ""
   nv_btr_sib   
   nv_btr_prb   
   ""
   nv_otr_sib   
   nv_otr_prb   
   ""
   nv_s8_sib    
   nv_s8_prb    
   ""
   nv_f4_sib    
   nv_f4_prb    
   ""
   nv_ftr_sib   
   nv_ftr_prb   
   ""
   nv_0f_sib    
   nv_0f_prb.

EXPORT DELIMITER ";" "".
OUTPUT CLOSE.
   
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE prnTOTEnd C-Win 
PROCEDURE prnTOTEnd :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
EXPORT DELIMITER ";"
    "รวมสลักหลังเพิ่ม" 
    "" "" "" "" ""
    nv_incsib       
    nv_incpremb     
    ""
    pv_f1_sib      
    pv_f1_prb      
    "" 
    ""
    pv_f2_sib       
    pv_f2_prb       
    ""
    ""
    pv_0t_sib     
    pv_0t_prb     
    ""
    ""
    pv_0s_sib      
    pv_0s_prb      
    ""
    pv_stat_sib     
    pv_stat_prb     
    "" 
    ""
    pv_0q_sib      
    pv_0q_prb      
    ""
    pv_0rq_sib     
    pv_0rq_prb     
    ""
    pv_ret_sib      
    pv_ret_prb      
    "" 
    ""
    pv_0ps_sib     
    pv_0ps_prb     
    ""
    pv_btr_sib      
    pv_btr_prb      
    ""
    pv_otr_sib      
    pv_otr_prb      
    ""
    pv_s8_sib       
    pv_s8_prb       
    ""
    pv_f4_sib       
    pv_f4_prb       
    ""
    pv_ftr_sib      
    pv_ftr_prb.  
    
EXPORT DELIMITER ";"
    "รวมสลักหลังลด" 
    "" "" "" "" ""
    nv_decsib      
    nv_decpremb    
    ""
    iv_f1_sib      
    iv_f1_prb      
    "" 
    ""
    iv_f2_sib      
    iv_f2_prb      
    "" 
    ""
    iv_0t_sib     
    iv_0t_prb     
    "" 
    ""
    iv_0s_sib       
    iv_0s_prb       
    ""
    iv_stat_sib     
    iv_stat_prb     
    "" 
    ""
    iv_0q_sib      
    iv_0q_prb      
    ""
    iv_0rq_sib     
    iv_0rq_prb     
    ""
    iv_ret_sib     
    iv_ret_prb     
    "" 
    ""
    iv_0ps_sib     
    iv_0ps_prb     
    ""
    iv_btr_sib     
    iv_btr_prb     
    ""
    iv_otr_sib     
    iv_otr_prb     
    ""
    iv_s8_sib      
    iv_s8_prb      
    ""
    iv_f4_sib      
    iv_f4_prb      
    ""
    iv_ftr_sib     
    iv_ftr_prb.
    OUTPUT CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE prnTOT_Pbr C-Win 
PROCEDURE prnTOT_Pbr :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
OUTPUT TO VALUE(nv_output) APPEND NO-ECHO.
EXPORT DELIMITER ";"
           "รวมสาขา" 
           "" "" "" ""
           nv_totsib      
           nv_totpremb    
           ""
           nv_f1_sib      
           nv_f1_prb      
       ""   /*--Add VAT---*/
           ""
           nv_f2_sib      
           nv_f2_prb      
       ""   /*--Add VAT---*/
       ""
           nv_0t_sib       
           nv_0t_prb       
       ""   /*--Add VAT---*/
           ""
           nv_0s_sib      
           nv_0s_prb      
           ""
           nv_stat_sib    
           nv_stat_prb    
       ""   /*--Add VAT---*/
           ""
           nv_0q_sib      
           nv_0q_prb      
           ""
           nv_0rq_sib     
           nv_0rq_prb     
           ""
           nv_ret_sib     
           nv_ret_prb     
       ""   /*--Add VAT---*/
           ""
           nv_0ps_sib     
           nv_0ps_prb     
           ""
           nv_btr_sib     
           nv_btr_prb     
           ""
           nv_otr_sib     
           nv_otr_prb     
           ""
           nv_s8_sib      
           nv_s8_prb      
           ""
           nv_f4_sib      
           nv_f4_prb      
           ""
           nv_ftr_sib     
           nv_ftr_prb.
EXPORT DELIMITER ";" "".
OUTPUT CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE prnTOT_Pln C-Win 
PROCEDURE prnTOT_Pln :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
OUTPUT TO VALUE(nv_output) APPEND NO-ECHO.
EXPORT DELIMITER ";"
   "รวม By Line"  
   "" "" "" ""
   br_totsib       
   br_totpremb     
   ""
   br_f1_sib       
   br_f1_prb       
   ""   /*--Add VAT---*/
   ""
   br_f2_sib       
   br_f2_prb       
   ""   /*--Add VAT---*/
   ""
   br_0t_sib      
   br_0t_prb      
   ""   /*--Add VAT---*/
   ""
   br_0s_sib      
   br_0s_prb      
   ""
   br_stat_sib    
   br_stat_prb    
   ""   /*--Add VAT---*/
   ""
   br_0q_sib      
   br_0q_prb      
   ""
   br_0rq_sib     
   br_0rq_prb     
   ""
   br_ret_sib     
   br_ret_prb     
   ""   /*--Add VAT---*/
   ""
   br_0ps_sib     
   br_0ps_prb     
   ""
   br_btr_sib     
   br_btr_prb     
   ""
   br_otr_sib     
   br_otr_prb     
   ""
   br_s8_sib      
   br_s8_prb      
   ""
   br_f4_sib       
   br_f4_prb       
   ""
   br_ftr_sib      
   br_ftr_prb.
EXPORT DELIMITER ";" "".
OUTPUT CLOSE.
   
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcEnd C-Win 
PROCEDURE ProcEnd :
/*------------------------------------------------------------------------------
  Purpose:     Process Outward Treaty  [Endorse.]  
  Parameters:  <none>
  Notes:      Copy From UZS008n1.P 
------------------------------------------------------------------------------*/
RUN clrEnd.

ASSIGN  n_cnt   = 0
        n_cnt1  = 0
        n_etime = TIME
        nv_output  = n_write + ".slk".

FOR EACH wvat7 .
    DELETE wvat7.
END.

RUN prnColumn_E.

FIND FIRST xmm024 NO-LOCK NO-ERROR.

IF nv_dir2 = NO THEN nv_frm_policy = "I".
ELSE nv_frm_policy = "D".

ASSIGN  nv_pol  = nv_frm_policy
        nv_frm_policy = nv_frm_policy + n_bran + substr(n_type,2,2)
        nv_to_policy =  nv_pol + n_brto + SUBSTRING(n_type_to,2,2) + "9999999".

LOOPA:
FOR EACH uwm100 USE-INDEX uwm10008 WHERE
         uwm100.trndat  >= n_date_fr AND
         uwm100.trndat  <= n_date_to AND
         uwm100.branch  >= n_bran    AND
         uwm100.branch  <= n_brto    AND
         uwm100.poltyp  >= n_type    AND
         uwm100.poltyp  <= n_type_to AND  
         uwm100.endcnt  >  000       AND
         uwm100.dir_ri   = nv_dir2   AND
         uwm100.releas = YES         NO-LOCK
BREAK BY uwm100.branch  BY uwm100.poltyp  BY uwm100.endno:

    DISPLAY    uwm100.trndat uwm100.policy uwm100.endno 
    WITH COLOR blue/withe NO-LABEL 
    TITLE "Process Data.." WIDTH 60 FRAME amain VIEW-AS DIALOG-BOX.
    PAUSE 0.

    IF FIRST-OF(uwm100.poltyp) THEN
       ASSIGN
       nv_0t_sib   = 0      nv_incsib    = 0         nv_decsib    = 0
       nv_0t_prb   = 0      nv_incpremb  = 0         nv_decpremb  = 0      
       nv_0s_sib   = 0      pv_f1_sib    = 0         iv_f1_sib    = 0
       nv_0s_prb   = 0      pv_f1_prb    = 0         iv_f1_prb    = 0
       nv_stat_sib = 0      pv_f2_sib    = 0         iv_f2_sib    = 0
       nv_stat_prb = 0      pv_f2_prb    = 0         iv_f2_prb    = 0
       nv_0q_sib   = 0      pv_0t_sib    = 0         iv_0t_sib    = 0
       nv_0q_prb   = 0      pv_0t_prb    = 0         iv_0t_prb    = 0
       nv_0rq_sib  = 0      pv_0s_sib    = 0         iv_0s_sib    = 0
       nv_0rq_prb  = 0      pv_0s_prb    = 0         iv_0s_prb    = 0
       nv_totsib   = 0      pv_stat_sib  = 0         iv_stat_sib  = 0
       nv_totpremb = 0
       pv_stat_prb = 0      iv_stat_prb  = 0
       nv_f1_sib   = 0      pv_0q_sib    = 0         iv_0q_sib    = 0
       nv_f1_prb   = 0      pv_0q_prb    = 0         iv_0q_prb    = 0
       nv_f2_sib   = 0      pv_0rq_sib   = 0         iv_0rq_sib   = 0
       nv_f2_prb   = 0      pv_0rq_prb   = 0         iv_0rq_prb   = 0
       nv_ret_sib  = 0      pv_ret_sib   = 0         iv_ret_sib   = 0
       nv_ret_prb  = 0      pv_ret_prb   = 0         iv_ret_prb   = 0
       nv_0f_sib   = 0      pv_0f_sib    = 0         iv_0f_sib    = 0
       nv_0f_prb   = 0      pv_0f_prb    = 0         iv_0f_prb    = 0
       nv_0ps_sib  = 0      pv_0ps_sib   = 0         iv_0ps_sib   = 0
       nv_0ps_prb  = 0      pv_0ps_prb   = 0         iv_0ps_prb   = 0
       nv_btr_sib  = 0      pv_btr_sib   = 0         iv_btr_sib   = 0
       nv_btr_prb  = 0      pv_btr_prb   = 0         iv_btr_prb   = 0
       nv_otr_sib  = 0      pv_otr_sib   = 0         iv_otr_sib   = 0
       nv_otr_prb  = 0      pv_otr_prb   = 0         iv_otr_prb   = 0
       nv_s8_sib  = 0       pv_s8_sib    = 0         iv_s8_sib    = 0
       nv_s8_prb  = 0       pv_s8_prb    = 0         iv_s8_prb    = 0
       nv_f4_sib   = 0      pv_f4_sib    = 0         iv_f4_sib    = 0
       nv_f4_prb   = 0      pv_f4_prb    = 0         iv_f4_prb    = 0
       nv_ftr_sib  = 0      pv_ftr_sib   = 0         iv_ftr_sib   = 0
       nv_ftr_prb  = 0      pv_ftr_prb   = 0         iv_ftr_prb   = 0

       n_cnt = n_cnt + 1.
       
       FIND FIRST xmm023 USE-INDEX xmm02301 WHERE
                xmm023.branch = uwm100.branch NO-LOCK NO-ERROR.
       ASSIGN n_branch = uwm100.branch
              n_bdes   = xmm023.bdes
              n_dir    = uwm100.dir_ri.

       FIND FIRST uwm200 USE-INDEX uwm20001 WHERE
                  uwm200.policy = UWM100.POLICY  AND
                  uwm200.rencnt = uwm100.rencnt  AND
                  uwm200.endcnt = uwm100.endcnt  AND
                  uwm200.csftq  <> "C" NO-LOCK NO-ERROR.
       IF NOT AVAIL uwm200 THEN NEXT loopa.

       FIND FIRST uwm120 USE-INDEX uwm12001 WHERE
                  uwm120.policy = uwm100.policy AND
                  uwm120.rencnt = uwm100.rencnt AND
                  uwm120.endcnt = uwm100.endcnt NO-LOCK NO-ERROR.
            nvexch = 1.

       IF AVAIL uwm120 THEN DO:
          IF SUBSTRING(uwm120.policy,3,2) = "90" THEN nvexch = 1.
          ELSE nvexch = uwm120.siexch.
       END.

       n_insur  = " ".
       IF SUBSTRING(uwm100.policy,1,1) = "I" THEN DO:
          FIND xmm600 WHERE xmm600.acno = uwm100.agent NO-LOCK NO-ERROR.
          IF NOT AVAILABLE xmm600 THEN DO:
             n_insur = " NOT FOUND PRODUCER CODE " + uwm100.agent.
          END.
          ELSE DO:
             n_insur =  xmm600.name.
          END.
       END.
       ELSE DO:
          IF TRIM(uwm100.ntitle) = "" THEN n_insur = "".
          ELSE n_insur = TRIM(uwm100.ntitle) + " ".
          IF TRIM(uwm100.fname)  = "" THEN n_insur = n_insur + uwm100.name1.
          ELSE n_insur = n_insur + uwm100.fname + " " + uwm100.name1.
       END.

       ASSIGN nv_sum   = 0.
              n_endcnt = uwm100.endcnt - 1.

     IF uwm100.tranty  = "C" THEN DO:
        RUN proc_Can.
     END.
     ELSE DO:
        RUN proc_NCan.
     END.

     ASSIGN  nv_sum      = nv_sum * nvexch             /*จำนวนเงินเอาประกันภัยรวม*/
             nv_totprem  = nv_totprem + uwm100.prem_t
             nv_totsi    = nv_totsi + nv_sum   
             nv_totpremb = nv_totpremb + uwm100.prem_t /*รวมทั้งสิ้น ---> เบี้ยประกันภัยรวม*/
             nv_totsib   = nv_totsib + nv_sum          /*รวมทั้งสิ้น ---> จำนวนเงินเอาประกันรวม*/
             tem_prem    = uwm100.prem_t.              /*เบี้ยประกันภัยรวม*/

     IF uwm100.prem_t > 0    THEN DO:
        ASSIGN  nv_incprem  = nv_incprem + uwm100.prem_t
                nv_incsi    = nv_incsi + nv_sum
                nv_incpremb = nv_incpremb + uwm100.prem_t  /*รวมสลักหลังเพิ่ม ---->  เบี้ยประกันภัยรวม*/
                nv_incsib   = nv_incsib + nv_sum.          /*รวมสลักหลังเพิ่ม จำนวนเงินเอาประกันภัยรวม*/
     END.
     ELSE DO:
       IF uwm100.prem_t <= 0  THEN DO:
          ASSIGN nv_decprem  = nv_decprem + uwm100.prem_t
                 nv_decsi    = nv_decsi + nv_sum
                 nv_decpremb = nv_decpremb + uwm100.prem_t  /*รวมสลักหลังลด ----> เบี้ยประกันภัยรวม*/
                 nv_decsib   = nv_decsib + nv_sum.          /*รวมสลักหลังลด ----> จำนวนเงินเอาประกันภัยรวม*/
       END.
     END.

     LOOPB:
     REPEAT:
        ASSIGN n_cnt1  = n_cnt1 + 1
               s_recid = RECID(uwm200).

        IF UWM100.TRANTY <> "C" THEN DO:
           RUN procTrnty_NC.
        END.
        ELSE DO:
           RUN procTrnty_C.
        END.

        FIND NEXT uwm200  USE-INDEX  uwm20001  WHERE
                  uwm200.policy = uwm100.policy  AND
                  uwm200.rencnt = uwm100.rencnt  AND
                  uwm200.endcnt = uwm100.endcnt  NO-LOCK NO-ERROR.
        IF NOT AVAIL uwm200 THEN LEAVE loopb.
     END.   /* loopb */

     ASSIGN n_prmf1  = n_prmf1  * (-1)
            n_prmf2  = n_prmf2  * (-1)
            n_prmt   = n_prmt   * (-1)
            n_prms   = n_prms   * (-1)
            n_prmq   = n_prmq   * (-1)
            n_prmtfp = n_prmtfp * (-1)
            n_prmrq  = n_prmrq  * (-1)
            n_prmps  = n_prmps  * (-1)  
            n_prmbtr = n_prmbtr * (-1)  
            n_prmotr = n_prmotr * (-1)  
            n_prms8  = n_prms8  * (-1)  
            n_prmf4  = n_prmf4  * (-1)  
            n_prmftr = n_prmftr * (-1)
            nv_prmf1 = n_prmf1
            nv_prmf2 = n_prmf2
            nv_prmt  = n_prmt
            nv_prmq  = n_prmq
            nv_prmr  = n_prmr.

     IF uwm100.poltyp  = "M31"  OR uwm100.poltyp  = "C90"  OR 
        uwm100.poltyp  = "C90C" OR uwm100.poltyp  = "C90Q" OR 
        uwm100.poltyp  = "C92"  THEN  DO:
        ASSIGN nv_gstrat   =  String(uwm100.gstrat, ">>9.99").

        FIND FIRST wvat7 WHERE wvat7.wyear = SUBSTRING(uwm100.policy,5,2) AND 
                               wvat7.wvat  = uwm100.gstrat NO-LOCK NO-ERROR.
        IF AVAIL wvat7 THEN DO:
           ASSIGN n_vatf1      = wvat7.wvalf1
                  n_vatf2      = wvat7.wvalf2
                  n_vatt       = wvat7.wvalt
                  n_vatq       = wvat7.wvalq
                  n_vatr       = wvat7.wvalr
                  wvat7.wvalf1 = n_vatf1 + nv_prmf1
                  wvat7.wvalf2 = n_vatf2 + nv_prmf2
                  wvat7.wvalt  = n_vatt  + nv_prmt
                  wvat7.wvalq  = n_vatq  + nv_prmq
                  wvat7.wvalr  = n_vatr  + nv_prmr
                  n_vatf1      = 0
                  n_vatf2      = 0
                  n_vatt       = 0
                  n_vatq       = 0
                  n_vatr       = 0.
        END.
        ELSE DO:
            CREATE wvat7.
            ASSIGN wvat7.wyear   = SUBSTRING(uwm100.policy,5,2)
                   wvat7.wvat    = uwm100.gstrat
                   wvat7.wvalf1  = nv_prmf1
                   wvat7.wvalf2  = nv_prmf2
                   wvat7.wvalt   = nv_prmt
                   wvat7.wvalq   = nv_prmq
                   wvat7.wvalr   = nv_prmr.
        END.
     END.
     ELSE DO:
        ASSIGN
           nv_gstrat   =  "".
     END.
 
     FOR EACH wrk0f:
       FIND xmm600 WHERE xmm600.acno = wrk0f.rico NO-LOCK NO-ERROR.
       IF AVAILABLE xmm600 THEN DO:
         IF (xmm600.clicod = "RD") OR (xmm600.clicod = "RB") THEN
           ASSIGN n_rb_pf   = n_rb_pf  + wrk0f.pf
                  n_rb_sum  = n_rb_sum + wrk0f.sumf
                  n_rb_prm  = n_rb_prm + (wrk0f.prmf * (-1)) .
         ELSE IF xmm600.clicod = "RF" THEN
           ASSIGN n_rf_pf   = n_rf_pf  + wrk0f.pf
                  n_rf_sum  = n_rf_sum + wrk0f.sumf
                  n_rf_prm  = n_rf_prm + (wrk0f.prmf * (-1)) .
       END.

     END. /* END FOR EACH wrk0f */

     RUN DetailEnd.

     FOR EACH wrk0f:
         DELETE wrk0f.
     END.

     RUN clrval_DEnd.
    
     IF LAST-OF(uwm100.poltyp) THEN DO:
        ASSIGN pv_f1_prb   = pv_f1_prb   * (-1)      iv_f1_prb   = iv_f1_prb   * (-1)
               pv_f2_prb   = pv_f2_prb   * (-1)      iv_f2_prb   = iv_f2_prb   * (-1)
               pv_0t_prb   = pv_0t_prb   * (-1)      iv_0t_prb   = iv_0t_prb   * (-1)
               pv_0s_prb   = pv_0s_prb   * (-1)      iv_0s_prb   = iv_0s_prb   * (-1)
               pv_stat_prb = pv_stat_prb * (-1)      iv_stat_prb = iv_stat_prb * (-1)
               pv_0q_prb   = pv_0q_prb   * (-1)      iv_0q_prb   = iv_0q_prb   * (-1)
               pv_0rq_prb  = pv_0rq_prb  * (-1)      iv_0rq_prb  = iv_0rq_prb  * (-1)
               pv_0f_prb   = pv_0f_prb   * (-1)      iv_0f_prb   = iv_0f_prb   * (-1)
               nv_f1_prb   = nv_f1_prb   * (-1)      nv_f2_prb   = nv_f2_prb   * (-1)
               nv_0t_prb   = nv_0t_prb   * (-1)      nv_0s_prb   = nv_0s_prb   * (-1)
               nv_stat_prb = nv_stat_prb * (-1)      nv_0q_prb   = nv_0q_prb   * (-1)
               nv_0rq_prb  = nv_0rq_prb  * (-1)      nv_0f_prb   = nv_0f_prb   * (-1)
               pv_s8_prb   = pv_s8_prb   * (-1)      iv_s8_prb   = iv_s8_prb   * (-1) /*A42-0208*/
               
               nv_0ps_prb  = nv_0ps_prb  * (-1)
               pv_0ps_prb  = pv_0ps_prb  * (-1)      iv_0ps_prb   = iv_0ps_prb   * (-1)
               nv_btr_prb  = nv_btr_prb  * (-1)
               pv_btr_prb  = pv_btr_prb  * (-1)      iv_btr_prb   = iv_btr_prb   * (-1)
               nv_otr_prb  = nv_otr_prb  * (-1)
               pv_otr_prb  = pv_otr_prb  * (-1)      iv_otr_prb   = iv_otr_prb   * (-1)
               
               nv_f4_prb   = nv_f4_prb   * (-1)
               pv_f4_prb   = pv_f4_prb   * (-1)      iv_f4_prb    = iv_f4_prb    * (-1)
               nv_ftr_prb  = nv_ftr_prb  * (-1)
               pv_ftr_prb  = pv_ftr_prb  * (-1)      iv_ftr_prb   = iv_ftr_prb   * (-1).
        
        RUN prnTOTEnd.

        FOR EACH wvat7 BY wvat7.wyear BY wvat7.wvat DESCENDING.
           OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
           EXPORT DELIMITER ";"
               "รวมค่า Vat " + TRIM(STRING(wvat7.wvat)) + "% กรมธรรม์ Marine ปี 25" + STRING(wvat7.wyear) 
               "" "" "" "" "" "" "" "" ""
               wvat7.wvalf1      
               "" "" ""
               wvat7.wvalf2      
               "" "" ""  
               wvat7.wvalt       
               "" "" "" "" "" ""                                           
               wvat7.wvalq      
               "" "" "" "" "" "" "" "" ""                              
               wvat7.wvalr.
           OUTPUT CLOSE.
       END.

       FOR EACH wvat7 .
           DELETE wvat7.
       END.

       RUN prnTOTAllEnd.
     END. /* IF LAST-OF(uwm100.poltyp) */

END.   /* UWM100 */

RUN clrval_AllEnd.

ASSIGN  n_dtime  = TIME - n_etime
        n_etime  = TIME
        w_etime  = STRING(n_etime, "HH:MM:SS")
        w_dtime  = STRING(n_dtime, "HH:MM:SS").


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcPol C-Win 
PROCEDURE ProcPol :
/*------------------------------------------------ 
Purpose:     Process Outward Treaty  [Endorse.]  
Parameters:  <none>
Notes:      Copy From UZS008n1.P 
------------------------------------------------*/
ASSIGN  nv_gstrat   = ""
        n_cnt       = 0
        n_cnt1      = 0
        n_etime     = TIME
        nv_output   = n_write + ".slk".

FOR EACH wvat7. /*-Add VAT------------*/
    DELETE wvat7.
END.

RUN prnColumn_P.

FIND FIRST xmm024 NO-LOCK NO-ERROR.

IF   nv_dir2 = NO THEN  nv_frm_policy = "I".
ELSE nv_frm_policy = "D".
ASSIGN n_fr_pol      = nv_frm_policy
       nv_frm_policy = nv_frm_policy + n_bran + SUBSTR(n_type,2,2) +
                       SUBSTR(STRING(YEAR(n_date_fr),"9999"),3,2)  + n_frbr
       nv_to_policy  = n_fr_pol + n_brto + SUBSTRING(n_type_to,2,2) + 
                       SUBSTR(STRING(YEAR(n_date_fr),"9999"),3,2) + n_tobr +
                       "999999"
        n_br2   = ""
        n_mr2   = "".
        PAUSE 0.

FOR EACH uwm200  USE-INDEX uwm20001              WHERE
             uwm200.policy >= nv_frm_policy      AND
             uwm200.policy <= nv_to_policy       AND
             SUBSTR(uwm200.policy,2,1) >= n_bran AND
             SUBSTR(uwm200.policy,2,1) <= n_brto AND
             SUBSTR(uwm200.policy,7,2) >= n_frbr AND
             SUBSTR(uwm200.policy,7,2) <= n_tobr AND   
             SUBSTR(uwm200.policy,3,2) >= SUBSTR(n_type,2,2)     AND
             SUBSTR(uwm200.policy,3,2) <= SUBSTR(n_type_to,2,2)  AND   
             uwm200.endcnt = 000    AND 
             uwm200.csftq  <> "C"   NO-LOCK
BREAK BY SUBSTR(uwm200.policy,2,1)
          BY SUBSTR(uwm200.policy,3,2) 
          BY uwm200.policy
          BY uwm200.csftq
          BY uwm200.c_no
          BY uwm200.c_enno:

    DISPLAY  uwm200.policy  n_cnt n_cnt1 
    WITH COLOR blue/withe NO-LABEL 
    TITLE "Process Data.." WIDTH 60 FRAME amain VIEW-AS DIALOG-BOX.
    PAUSE 0.

    ASSIGN n_br1 =  SUBSTRING(uwm200.policy,2,1)
           n_mr1 =  SUBSTRING(uwm200.policy,7,2).

    IF (n_mr1 <> n_mr2) AND  (n_mr2 <> " ")  THEN DO:
       IF br_totsib   = 0  AND  br_totpremb  =  0  AND
          br_f1_sib   = 0  AND  br_f1_prb    =  0  AND
          br_f2_sib   = 0  AND  br_f2_prb    =  0  AND
          br_0t_sib   = 0  AND  br_0t_prb    =  0  AND
          br_0s_sib   = 0  AND  br_0s_prb    =  0  AND
          br_stat_sib = 0  AND  br_stat_prb  =  0  AND
          br_0q_sib   = 0  AND  br_0q_prb    =  0  AND
          br_0f_sib   = 0  AND  br_0f_prb    =  0  AND
          br_ret_sib  = 0  AND  br_ret_prb   =  0  AND
          br_0rq_sib  = 0  AND  br_0rq_prb   =  0  AND 
          br_0ps_sib  =     0  AND  br_0ps_prb   =  0  AND   
          br_btr_sib  = 0  AND  br_btr_prb   =  0  AND
          br_otr_sib  = 0  AND  br_otr_prb   =  0  AND 
          br_s8_sib   = 0  AND  br_s8_prb    =  0  AND 
          br_f4_sib   = 0  AND  br_f4_prb    =  0  AND
          br_ftr_sib  = 0  AND  br_ftr_prb   =  0  THEN DO:
     END.
     ELSE DO:
       ASSIGN  br_f1_prb      =  br_f1_prb      * (-1)
               br_f2_prb      =  br_f2_prb      * (-1)
               br_0t_prb      =  br_0t_prb      * (-1)
               br_0s_prb      =  br_0s_prb      * (-1)
               br_stat_prb    =  br_stat_prb    * (-1)
               br_0q_prb      =  br_0q_prb      * (-1)
               br_0f_prb      =  br_0f_prb      * (-1)
               br_0rq_prb     =  br_0rq_prb     * (-1)
               br_0ps_prb     =  br_0ps_prb     * (-1)      
               br_btr_prb     =  br_btr_prb     * (-1)      
               br_otr_prb     =  br_otr_prb     * (-1)    
               br_s8_prb          =  ABSOLUTE(br_s8_prb)        
               br_f4_prb          =  br_f4_prb     * (-1)
               br_ftr_prb         =  br_ftr_prb    * (-1).

       RUN prnTOT_Pln.

       FOR EACH wvat7 BY wvat7.wyear BY wvat7.wvat DESCENDING.
           OUTPUT TO VALUE(nv_output) APPEND NO-ECHO.
           EXPORT DELIMITER ";"
               "รวมค่า Vat " + TRIM(STRING(wvat7.wvat)) +
               "% กรมธรรม์ Marine ปี 25" + STRING(wvat7.wyear) 
               "" "" "" "" "" "" "" "" 
               wvat7.wvalf1       
               "" "" ""
               wvat7.wvalf2       
               "" "" ""  
               wvat7.wvalt
               "" "" "" "" "" ""                                           
               wvat7.wvalq 
               "" "" "" "" "" "" "" "" ""                              
               wvat7.wvalr.
           OUTPUT CLOSE.
       END.  /*For each*/

       FOR EACH wvat7 .
           DELETE wvat7.
       END.     /*-----------Add VAT-*/
     END.  /*Else*/

     ASSIGN  br_0t_sib    = 0    br_totsib   = 0
             br_0t_prb    = 0    br_totpremb = 0
             br_0s_sib    = 0    br_f1_sib   = 0
             br_0s_prb    = 0    br_f1_prb   = 0
             br_stat_sib  = 0    br_f2_sib   = 0
             br_stat_prb  = 0    br_f2_prb   = 0
             br_0q_sib    = 0    br_0q_prb   = 0
             br_0rq_sib   = 0    br_0rq_prb  = 0
             br_ret_sib   = 0    br_ret_prb  = 0
             br_0f_sib    = 0    br_0f_prb   = 0
             br_0ps_sib   = 0    br_0ps_prb  = 0
             br_btr_sib   = 0    br_btr_prb  = 0
             br_otr_sib   = 0    br_otr_prb  = 0      
             br_s8_sib    = 0    br_s8_prb   = 0      
             br_f4_sib    = 0    br_f4_prb   = 0
             br_ftr_sib   = 0    br_ftr_prb  = 0 
             n_mr2  =  n_mr1.
   END. /* IF (n_mr1 <> n_mr2)  AND  (n_mr2 <> " ") */

   IF (n_br1 <> n_br2)  AND  (n_br2 <> " ")  THEN DO: 
      IF nv_totsib    = 0  AND   nv_totpremb  =  0  AND
         nv_f1_sib    = 0  AND   nv_f1_prb    =  0  AND
         nv_f2_sib    = 0  AND   nv_f2_prb    =  0  AND
         nv_0t_sib    = 0  AND   nv_0t_prb    =  0  AND
         nv_0s_sib    = 0  AND   nv_0s_prb    =  0  AND
         nv_stat_sib  = 0  AND   nv_stat_prb  =  0  AND
         nv_0q_sib    = 0  AND   nv_0q_prb    =  0  AND
         nv_0f_sib    = 0  AND   nv_0f_prb    =  0  AND
         nv_ret_sib   = 0  AND   nv_ret_prb   =  0  AND
         nv_0rq_sib   = 0  AND   nv_0rq_prb   =  0  AND
         nv_0ps_sib   = 0  AND   nv_0ps_prb   =  0  AND
         nv_btr_sib   = 0  AND   nv_btr_prb   =  0  AND
         nv_otr_sib   = 0  AND   nv_otr_prb   =  0  AND
         nv_s8_sib    = 0  AND   nv_s8_prb    =  0  AND
         nv_f4_sib    = 0  AND   nv_f4_prb    =  0  AND
         nv_ftr_sib   = 0  AND   nv_ftr_prb   =  0  THEN DO:
     END.
     ELSE DO:
       ASSIGN
          nv_f1_prb   =  nv_f1_prb    * (-1)
          nv_f2_prb   =  nv_f2_prb    * (-1)
          nv_0t_prb   =  nv_0t_prb    * (-1)
          nv_0s_prb   =  nv_0s_prb    * (-1)
          nv_stat_prb =  nv_stat_prb  * (-1)
          nv_0q_prb   =  nv_0q_prb    * (-1)
          nv_0f_prb   =  nv_0f_prb    * (-1)
          nv_0rq_prb  =  nv_0rq_prb   * (-1)
          nv_0ps_prb  =  nv_0ps_prb       * (-1)
          nv_btr_prb  =  nv_btr_prb       * (-1)
          nv_otr_prb  =  nv_otr_prb       * (-1)
          nv_s8_prb       =  ABSOLUTE(nv_s8_prb)
          nv_f4_prb       =  nv_f4_prb    * (-1)
          nv_ftr_prb  =  nv_ftr_prb       * (-1).

       RUN prnTOT_Pbr.
     END.

     RUN clrval_br.

     n_br2  =  n_br1.   

   END. /* IF (n_br1 <> n_br2)  AND  (n_br2 <> " ")  */ 

   n_cnt = n_cnt + 1.

   FIND FIRST uwm100 USE-INDEX uwm10001 WHERE
                  uwm100.policy = uwm200.policy AND
                  uwm100.rencnt = uwm200.rencnt AND
                  uwm100.endcnt = uwm200.endcnt AND
                  uwm100.branch = n_br1             AND
                  uwm100.dir_ri = nv_dir2               AND
                  uwm100.trndat >= n_date_fr    AND
                  uwm100.trndat <= n_date_to    AND
              uwm100.releas = YES  NO-LOCK NO-ERROR.
   IF NOT AVAIL UWM100 THEN NEXT.

   FIND FIRST xmm023 USE-INDEX xmm02301     WHERE 
              xmm023.branch = uwm100.branch NO-LOCK NO-ERROR.
   IF AVAIL xmm023      THEN  n_bdes   = xmm023.bdes.
   ELSE  n_bdes = "".

   ASSIGN n_branch = uwm100.branch
          n_dir    = uwm100.dir_ri.

   IF FIRST-OF(uwm200.policy) THEN  DO:
      ASSIGN  n_br2 = n_br1
              n_mr2 = n_mr1.

      IF SUBSTR(uwm200.policy,1,1) = "I" THEN DO:
         FIND XMM600 WHERE XMM600.ACNO = UWM100.AGENT NO-LOCK NO-ERROR.
         IF NOT AVAIL XMM600 THEN DO:
                n_insur = " NOT FOUND PRODUCER CODE " + UWM100.AGENT.
         END.
         ELSE DO.
                n_insur =  XMM600.NAME.
         END.
      END.
      ELSE DO:
             n_insur  = " ".

             IF TRIM(uwm100.ntitle) = "" THEN n_insur = "".
                 ELSE n_insur = TRIM(uwm100.ntitle) + " ".

             IF TRIM(uwm100.fname)      = "" THEN n_insur = n_insur + uwm100.name1.
                 ELSE n_insur = n_insur + uwm100.fname + " " + uwm100.name1.
     END.

     FIND FIRST uwm120 USE-INDEX uwm12001      WHERE
                    uwm120.policy = uwm100.policy        AND
                    uwm120.rencnt = uwm100.rencnt  NO-LOCK NO-ERROR.
     IF AVAIL uwm120 THEN DO:
            IF SUBSTR(uwm120.policy,3,2) = "90" THEN nvexch = 1.
            ELSE  nvexch = uwm120.siexch.
     END.

     ASSIGN  nv_totprem   =     nv_totprem  + uwm100.prem_t
             nv_totpremb  =     nv_totpremb + uwm100.prem_t
             br_totpremb  =     br_totpremb + uwm100.prem_t
             nv_tem           = 0.

     IF uwm100.poltyp = "M60"  OR  uwm100.poltyp = "M61"  OR
            uwm100.poltyp = "M62"  THEN DO:

        FOR EACH uwm307 USE-INDEX uwm30701    WHERE
                 uwm307.policy = uwm100.policy  AND
                 uwm307.rencnt = uwm100.rencnt  AND
                 uwm307.endcnt = uwm100.endcnt NO-LOCK .
                nv_tem  = nv_tem  + uwm307.mbsi[1].
        END.
     END.
     ELSE DO:
        FOR EACH uwm120 USE-INDEX uwm12001    WHERE
                 uwm120.policy = uwm100.policy  AND
                 uwm120.rencnt = uwm100.rencnt  AND
                 uwm120.endcnt = uwm100.endcnt NO-LOCK .
            IF AVAIL uwm120 THEN  DO:
               nv_tem  = nv_tem + (uwm120.sigr - uwm120.sico).
            END.
     END. /* Else */
     END.

     ASSIGN nv_sibht   =  nv_sibht  + (nv_tem * nvexch)
            nv_totsi   =  nv_totsi  + (nv_tem * nvexch)
            nv_totsib  =  nv_totsib + (nv_tem * nvexch)
            br_totsib  =  br_totsib + (nv_tem * nvexch).

   END. /* IF FIRST-OF(uwm200.policy) */

   ASSIGN n_cnt1 = n_cnt1 + 1
          s_recid = RECID(uwm200).

   RUN proc_tty.

   IF LAST-OF(uwm200.policy) THEN DO:
   ASSIGN  n_prmf1  =  n_prmf1   * (-1)
           n_prmf2  =  n_prmf2   * (-1)
           n_prmt       =  n_prmt    * (-1)
           n_prms       =  n_prms    * (-1)
           n_prmq       =  n_prmq    * (-1)
           n_prmtfp =  n_prmtfp  * (-1)
           n_prmrq  =  n_prmrq   * (-1)
           n_prmps  =  n_prmps   * (-1) 
           n_prmbtr =  n_prmbtr  * (-1) 
           n_prmotr =  n_prmotr  * (-1) 
           n_prms8  =  ABSOLUTE(n_prms8)
           n_prmf4  =  n_prmf4   * (-1)
           n_prmftr =  n_prmftr  * (-1).

    /*-------Add VAT-------------------*/       
    ASSIGN nv_prmf1 = n_prmf1
           nv_prmf2 = n_prmf2
           nv_prmt  = n_prmt
           nv_prmq  = n_prmq
           nv_prmr  = n_prmr.

    IF  uwm100.poltyp = "M31"  OR uwm100.poltyp = "C90"  OR 
        uwm100.poltyp = "C90C" OR uwm100.poltyp = "C90Q" OR 
        uwm100.poltyp = "C92"  THEN DO:
        ASSIGN  nv_gstrat = STRING(uwm100.gstrat, ">>9.99").

        FIND FIRST wvat7 WHERE wvat7.wyear = SUBSTRING(uwm100.policy,5,2) AND 
                           wvat7.wvat  = uwm100.gstrat NO-LOCK NO-ERROR.
        IF AVAIL wvat7 THEN DO:
           ASSIGN n_vatf1      = wvat7.wvalf1
                  n_vatf2      = wvat7.wvalf2
                  n_vatt       = wvat7.wvalt
                  n_vatq       = wvat7.wvalq
                  n_vatr       = wvat7.wvalr
                  wvat7.wvalf1 = n_vatf1 + nv_prmf1
                  wvat7.wvalf2 = n_vatf2 + nv_prmf2
                  wvat7.wvalt  = n_vatt  + nv_prmt
                  wvat7.wvalq  = n_vatq  + nv_prmq
                  wvat7.wvalr  = n_vatr  + nv_prmr
                  n_vatf1      = 0
                  n_vatf2      = 0
                  n_vatt       = 0
                  n_vatq       = 0
                  n_vatr       = 0.
        END.
        ELSE DO:
            CREATE wvat7.
            ASSIGN wvat7.wyear  = SUBSTR(uwm100.policy,5,2)
                   wvat7.wvat   = uwm100.gstrat
                   wvat7.wvalf1 = nv_prmf1
                   wvat7.wvalf2 = nv_prmf2
                   wvat7.wvalt  = nv_prmt
                   wvat7.wvalq  = nv_prmq
                   wvat7.wvalr  = nv_prmr.
        END.  /*Else*/
    END.  /*IF*/

    ELSE ASSIGN nv_gstrat   =  "".
     /*---------Add VAT---------*/
   
    /*RUN DetailPol.*/
    FOR EACH wrk0f:
       FIND xmm600 WHERE xmm600.acno = wrk0f.rico NO-LOCK NO-ERROR.
       IF AVAILABLE xmm600 THEN DO:
              IF (xmm600.clicod = "RD") OR (xmm600.clicod = "RB") THEN
                 ASSIGN  n_rb_pf        = n_rb_pf  + wrk0f.pf
                         n_rb_sum       = n_rb_sum + wrk0f.sumf
                         n_rb_prm       = n_rb_prm + (wrk0f.prmf * (-1)).
                 ELSE IF xmm600.clicod = "RF" THEN
                     ASSIGN  n_rf_pf   = n_rf_pf        + wrk0f.pf
                             n_rf_sum  = n_rf_sum + wrk0f.sumf
                             n_rf_prm  = n_rf_prm + (wrk0f.prmf * (-1)).
       END.
    END. /* END FOR EACH wrk0f */

    RUN DetailPol.
   
    FOR EACH wrk0f:
            DELETE wrk0f.
    END.

    ASSIGN nv_sibht = 0     p_f1      = 000   p_s      = 000    
           p_rq     = 000   p_tfp     = 000   
           n_sumf1  = 0     n_sums    = 0     n_sumrq  = 0     
           n_sumtfp = 0     n_prmf1   = 0     n_prms   = 0     
           n_prmrq  = 0     n_prmtfp  = 0     
           p_f2     = 000   p_q       = 000   p_r      = 000    
           p_t      = 000                     
           n_sumf2  = 0     n_sumq    = 0     n_sumr   = 0      
           n_sumt   = 0     n_prmf2   = 0     n_prmq   = 0     
           n_prmr   = 0     n_prmt    = 0     
           p_ps     = 000   n_sumps   = 0     n_prmps  = 0
           p_btr    = 000   n_sumbtr  = 0     n_prmbtr = 0
           p_otr    = 000   n_sumotr  = 0     n_prmotr = 0
           p_s8     = 000   n_sums8   = 0     n_prms8  = 0
           p_f4     = 000   n_sumf4   = 0     n_prmf4  = 0
           p_ftr    = 000   n_sumftr  = 0     n_prmftr = 0
           n_rb_pf  = 000   n_rb_sum  = 0     n_rb_prm = 0
           n_rf_pf  = 000   n_rf_sum  = 0     n_rf_prm = 0.
  
   END. /* IF LAST-OF(uwm200.policy) */

   IF LAST-OF (SUBSTR(uwm200.policy,3,2)) THEN DO:
      IF br_totsib    = 0  AND   br_totpremb  =  0  AND
         br_f1_sib    = 0  AND   br_f1_prb    =  0  AND 
         br_f2_sib    = 0  AND   br_0t_sib    =  0  AND 
         br_0t_prb    = 0  AND   br_0s_sib    =  0  AND 
         br_0s_prb    = 0  AND   br_stat_sib  =  0  AND
         br_stat_prb  = 0  AND   br_0q_sib    =  0  AND 
         br_0q_prb    = 0  AND   br_0f_sib    =  0  AND 
         br_0f_prb    = 0  AND   br_ret_sib   =  0  AND
         br_ret_prb   = 0  AND   br_0rq_sib   =  0  AND
         br_0rq_prb   = 0  AND                      
         br_0ps_prb   = 0  AND   br_0ps_sib   =  0  AND 
         br_btr_prb   = 0  AND   br_btr_sib   =  0  AND 
         br_otr_prb   = 0  AND   br_otr_sib   =  0  AND 
         br_s8_prb    = 0  AND   br_s8_sib    =  0  AND 
         br_f4_prb    = 0  AND   br_f4_sib    =  0  AND 
         br_ftr_prb   = 0  AND   br_ftr_sib   =  0  THEN DO:
     END.
     ELSE DO:
       ASSIGN
          br_f1_prb   =  br_f1_prb   * (-1)
          br_f2_prb   =  br_f2_prb   * (-1)
          br_0t_prb   =  br_0t_prb   * (-1)
          br_0s_prb   =  br_0s_prb   * (-1)
          br_stat_prb =  br_stat_prb * (-1)
          br_0q_prb   =  br_0q_prb   * (-1)
          br_0f_prb   =  br_0f_prb   * (-1)
          br_0rq_prb  =  br_0rq_prb  * (-1)
          br_0ps_prb  =  br_0ps_prb  * (-1) 
          br_btr_prb  =  br_btr_prb  * (-1) 
          br_otr_prb  =  br_otr_prb  * (-1) 
          br_s8_prb   =  ABSOLUTE(br_s8_prb)
          br_f4_prb       =  br_f4_prb   * (-1)
          br_ftr_prb  =  br_ftr_prb      * (-1).

       RUN prnTOT_Pln.

       ASSIGN br_0t_sib    = 0   br_totsib   = 0
              br_0t_prb    = 0   br_totpremb = 0
              br_0s_sib    = 0   br_f1_sib   = 0
              br_0s_prb    = 0   br_f1_prb   = 0
              br_stat_sib  = 0   br_f2_sib   = 0
              br_stat_prb  = 0   br_f2_prb   = 0
              br_0q_sib    = 0   br_0q_prb   = 0
              br_0f_sib    = 0   br_0f_prb   = 0
              br_ret_sib   = 0   br_ret_prb  = 0
              br_0rq_sib   = 0   br_0rq_prb  = 0
              br_0ps_sib   = 0   br_0ps_prb  = 0  
              br_btr_sib   = 0   br_btr_prb  = 0  
              br_otr_sib   = 0   br_otr_prb  = 0  
              br_s8_sib    = 0   br_s8_prb   = 0
              br_f4_sib    = 0   br_f4_prb   = 0
              br_ftr_sib   = 0   br_ftr_prb  = 0. 
     END.
   END. /* IF LAST-OF (SUBSTRING(uwm200.policy,3,2))*/
END.  /* FOR EACH uwm200 */

IF nv_totsib    =  0  AND  nv_totpremb  =  0  AND
   nv_f1_sib    =  0  AND  nv_f1_prb    =  0  AND
   nv_f2_sib    =  0  AND  nv_0t_sib    =  0  AND
   nv_0t_prb    =  0  AND  nv_0s_sib    =  0  AND
   nv_0s_prb    =  0  AND  nv_stat_sib  =  0  AND
   nv_stat_prb  =  0  AND  nv_0q_sib    =  0  AND
   nv_0q_prb    =  0  AND  nv_0f_sib    =  0  AND
   nv_0f_prb    =  0  AND  nv_ret_sib   =  0  AND
   nv_ret_prb   =  0  AND  nv_0rq_sib   =  0  AND
   nv_0rq_prb   =  0  AND               
   nv_0ps_sib   =  0  AND  nv_0ps_prb   =  0  AND  
   nv_btr_sib   =  0  AND  nv_btr_prb   =  0  AND  
   nv_otr_sib   =  0  AND  nv_otr_prb   =  0  AND  
   nv_s8_sib    =  0  AND  nv_s8_prb    =  0  AND
   nv_f4_sib    =  0  AND  nv_f4_prb    =  0  AND
   nv_ftr_sib   =  0  AND  nv_ftr_prb   =  0  THEN DO:
   END.
   ELSE DO:
    ASSIGN nv_f1_prb    =  nv_f1_prb    * (-1)
               nv_f2_prb        =  nv_f2_prb    * (-1)
               nv_0t_prb        =  nv_0t_prb    * (-1)
               nv_0s_prb        =  nv_0s_prb    * (-1)
               nv_stat_prb      =  nv_stat_prb  * (-1)
               nv_0q_prb        =  nv_0q_prb    * (-1)
               nv_0f_prb        =  nv_0f_prb    * (-1)
               nv_0rq_prb       =  nv_0rq_prb   * (-1)
               nv_0ps_prb       =  nv_0ps_prb   * (-1)     
               nv_btr_prb       =  nv_btr_prb   * (-1)     
               nv_otr_prb       =  nv_otr_prb   * (-1)     
           nv_s8_prb    =  ABSOLUTE(nv_s8_prb)
           nv_f4_prb    =  nv_f4_prb    * (-1)
               nv_ftr_prb       =  nv_ftr_prb   * (-1).
    RUN prnTOT_Pbr.
  END. /*else*/
  RUN clrval_br.
  RUN clrTOT.
  ASSIGN  n_dtime  = TIME - n_etime 
          n_etime  = TIME
          w_etime  = STRING(n_etime, "HH:MM:SS")
          w_dtime  = STRING(n_dtime, "HH:MM:SS").

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcSumme C-Win 
PROCEDURE ProcSumme :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nt_sigr     LIKE uwm100.sigr_p.
DEF VAR nt_prem     LIKE uwm100.prem_t.
DEF VAR nt_stat_pr  LIKE uwd200.ripr.
DEF VAR nt_ret_pr   LIKE uwd200.ripr.
DEF VAR nt_0q_pr    LIKE uwd200.ripr.
DEF VAR nt_0t_pr    LIKE uwd200.ripr.
DEF VAR nt_0s_pr    LIKE uwd200.ripr.
DEF VAR nt_f1_pr    LIKE uwd200.ripr.
DEF VAR nt_f2_pr    LIKE uwd200.ripr.
DEF VAR nt_f3_pr    LIKE uwd200.ripr.
DEF VAR nt_f4_pr    LIKE uwd200.ripr. 
DEF VAR nt_0rq_pr   LIKE uwd200.ripr.
DEF VAR nt_0ps_pr   LIKE uwd200.ripr.
DEF VAR nt_btr_pr   LIKE uwd200.ripr.
DEF VAR nt_otr_pr   LIKE uwd200.ripr.
DEF VAR nt_ftr_pr   LIKE uwd200.ripr. 
DEF VAR nt_s8_pr    LIKE uwd200.ripr.
DEF VAR nt_other_pr LIKE uwd200.ripr.
DEF VAR np_line     AS CHAR FORMAT "x(30)".
/* สลักหลังเพิ่ม   p Plus */
DEF VAR nv_sigrp     LIKE uwm100.sigr_p.
DEF VAR nv_premp     LIKE uwm100.prem_t.
DEF VAR nv_stat_prp  LIKE uwd200.ripr.
DEF VAR nv_ret_prp   LIKE uwd200.ripr.
DEF VAR nv_0q_prp    LIKE uwd200.ripr.
DEF VAR nv_0t_prp    LIKE uwd200.ripr.
DEF VAR nv_0s_prp    LIKE uwd200.ripr.
DEF VAR nv_f1_prp    LIKE uwd200.ripr.
DEF VAR nv_f2_prp    LIKE uwd200.ripr.
DEF VAR nv_f3_prp    LIKE uwd200.ripr.
DEF VAR nv_f4_prp    LIKE uwd200.ripr.
DEF VAR nv_0rq_prp   LIKE uwd200.ripr.
DEF VAR nv_0ps_prp   LIKE uwd200.ripr.
DEF VAR nv_btr_prp   LIKE uwd200.ripr.
DEF VAR nv_otr_prp   LIKE uwd200.ripr.
DEF VAR nv_ftr_prp   LIKE uwd200.ripr.
DEF VAR nv_s8_prp    LIKE uwd200.ripr.
DEF VAR nv_other_prp LIKE uwd200.ripr.
/* สลักหลังลด  s Subtract */
DEF VAR nv_sigrs     LIKE uwm100.sigr_p.
DEF VAR nv_prems     LIKE uwm100.prem_t.
DEF VAR nv_stat_prs  LIKE uwd200.ripr.
DEF VAR nv_ret_prs   LIKE uwd200.ripr.
DEF VAR nv_0q_prs    LIKE uwd200.ripr.
DEF VAR nv_0t_prs    LIKE uwd200.ripr.
DEF VAR nv_0s_prs    LIKE uwd200.ripr.
DEF VAR nv_f1_prs    LIKE uwd200.ripr.
DEF VAR nv_f2_prs    LIKE uwd200.ripr.
DEF VAR nv_f3_prs    LIKE uwd200.ripr.
DEF VAR nv_f4_prs    LIKE uwd200.ripr.
DEF VAR nv_0rq_prs   LIKE uwd200.ripr.
DEF VAR nv_0ps_prs   LIKE uwd200.ripr.
DEF VAR nv_btr_prs   LIKE uwd200.ripr.
DEF VAR nv_otr_prs   LIKE uwd200.ripr.
DEF VAR nv_ftr_prs   LIKE uwd200.ripr.
DEF VAR nv_s8_prs    LIKE uwd200.ripr.
DEF VAR nv_other_prs LIKE uwd200.ripr.
DEF VAR nv_brn_line  AS CHAR FORMAT "x(4)" COLUMN-LABEL "  LINE  ".

ASSIGN  nv_output   = TRIM(n_write) + ".SLK".

OUTPUT TO VALUE (nv_output) NO-ECHO.
EXPORT DELIMITER ";"
    ""
    "Sum Insured" 
    "TOT Premium" 
    "Retention"   
    "QBaht"       
    "TFP"         
    "1st"         
    "2nd"         
    "F1"          
    "F2"          
    "F3"          
    "F4"          
    "0QS"         
    "MPS"         
    "BTR"         
    "OTR"         
    "FTR"         
    "S8".
OUTPUT CLOSE.

FOR EACH uwm100  NO-LOCK  USE-INDEX uwm10008  WHERE
         uwm100.trndat >= n_date_fr   AND 
         uwm100.trndat <= n_date_to   AND 
         uwm100.poltyp <> "V70"       AND 
         uwm100.poltyp <> "V72"       AND 
         Uwm100.poltyp <> "V73"       AND
         UWM100.POLTYP <> "V74"       AND 
         uwm100.releas = YES          AND 
         uwm100.endcnt  > 000.

         ASSIGN nv_brn_line    = SUBSTR(uwm100.policy,1,1) + "-" +
                                 SUBSTR(uwm100.policy,2,1) + "-" +
                                 SUBSTR(uwm100.policy,3,2)
                nt_sigr        = nt_sigr   + uwm100.sigr_p
                nt_prem        = nt_prem   + uwm100.prem_t.
         
         IF Uwm100.prem_t < 0 THEN /* สลักหลังลด */
            ASSIGN nv_sigrs = nv_sigrs + Uwm100.sigr_p
                   nv_prems = nv_prems + Uwm100.prem_t.
         ELSE ASSIGN  nv_sigrp = nv_sigrp + Uwm100.sigr_p
                      nv_premp = nv_premp + Uwm100.prem_t.
         
         FOR EACH uwd200 USE-INDEX uwd20001 WHERE
                                   uwd200.policy = uwm100.policy AND
                                   uwd200.rencnt = uwm100.rencnt AND
                                   uwd200.endcnt = uwm100.endcnt AND
                                   uwd200.csftq  <> "C"  NO-LOCK.

DISPLAY uwm100.trndat uwm100.policy SUBSTR(uwm100.policy,3,2) SUBSTR(uwm100.policy,2,1) uwd200.rico 
WITH COLOR blue/withe NO-LABEL 
TITLE "Process Data.." WIDTH 60 FRAME amain VIEW-AS DIALOG-BOX.
PAUSE 0.

          IF uwd200.rico  = "STAT"  THEN DO:   /* Qbaht */
             nt_stat_pr  = nt_stat_pr + uwd200.ripr.
               IF Uwm100.prem_t < 0 THEN nv_stat_prs = nv_stat_prs + Uwd200.ripr.
               ELSE nv_stat_prp = nv_stat_prp + Uwd200.ripr.
          END. /* STAT */

          ELSE IF uwd200.rico  = "0RET"  THEN DO:
                  nt_ret_pr = nt_ret_pr + uwd200.ripr.
               IF Uwm100.prem_t < 0 THEN nv_ret_prs = nv_ret_prs + Uwd200.ripr.
               ELSE nv_ret_prp = nv_ret_prp + UWd200.ripr.
          END. /* 0RET */

          ELSE IF SUBSTR(uwd200.rico,1,2) = "0Q"  THEN DO:  /*TFB */
                  nt_0q_pr = nt_0q_pr  + uwd200.ripr.
                  IF Uwm100.prem_t < 0 THEN nv_0q_prs = nv_0q_prs + Uwd200.ripr.
                  ELSE nv_0q_prp = nv_0q_prp + Uwd200.ripr.
          END. /* 0Q */

          ELSE IF SUBSTR(uwd200.rico,1,2) = "0T"  AND
                  SUBSTR(uwd200.rico,6,2) = "01"  THEN DO:
                  nt_0t_pr = nt_0t_pr + uwd200.ripr.
                  IF Uwm100.prem_t < 0 THEN nv_0t_prs = nv_0t_prs + Uwd200.ripr.
                  ELSE nv_0t_prp = nv_0t_prp + Uwd200.ripr.
          END. /* 0T */

          ELSE IF SUBSTRING(uwd200.rico,1,2) = "0T"  AND
                  SUBSTRING(uwd200.rico,6,2) = "02"  THEN DO:
                  nt_0s_pr = nt_0s_pr + uwd200.ripr.
                  IF Uwm100.prem_t < 0 THEN nv_0s_prs = nv_0s_prs + Uwd200.ripr.
                  ELSE nv_0s_prp = nv_0s_prp + Uwd200.ripr.
          END. /* 0S */

          ELSE IF SUBSTR(uwd200.rico,1,2) = "0T"  AND
                  SUBSTR(uwd200.rico,6,2) = "F1"  THEN DO:
                  nt_f1_pr = nt_f1_pr + uwd200.ripr.
                  IF Uwm100.prem_t < 0 THEN nv_f1_prs = nv_f1_prs + Uwd200.ripr.
                  ELSE nv_f1_prp = nv_f1_prp + Uwd200.ripr.
          END. /* F1 */

          ELSE IF SUBSTR(uwd200.rico,1,2) = "0T"  AND
                  SUBSTR(uwd200.rico,6,2) = "F2"  THEN DO:
                  nt_f2_pr = nt_f2_pr + uwd200.ripr.
                  IF Uwm100.prem_t < 0 THEN nv_f2_prs = nv_f2_prs + Uwd200.ripr.
                  ELSE nv_f2_prp = nv_f2_prp + Uwd200.ripr.
          END. /* F2 */

          ELSE IF SUBSTR(uwd200.rico,1,2) = "0T"  AND
                  SUBSTR(uwd200.rico,6,2) = "F3"  THEN DO:
                  nt_f3_pr = nt_f3_pr + uwd200.ripr.
                  IF Uwm100.prem_t < 0 THEN nv_f3_prs = nv_f3_prs + Uwd200.ripr.
                  ELSE nv_f3_prp = nv_f3_prp + Uwd200.ripr.
          END. /* F3 */   

          ELSE IF SUBSTR(uwd200.rico,1,2) = "0T"  AND   /* A450055*/
                  SUBSTR(uwd200.rico,6,2) = "F4"  THEN DO:
                  nt_f4_pr = nt_f4_pr + uwd200.ripr.
                  IF Uwm100.prem_t < 0 THEN nv_f4_prs = nv_f4_prs + Uwd200.ripr.
                  ELSE nv_f4_prp = nv_f4_prp + Uwd200.ripr.
          END. /* F4 */

          ELSE IF SUBSTRING(uwd200.rico,1,3) = "0RQ" THEN DO:
                  nt_0rq_pr = nt_0rq_pr + uwd200.ripr.
                  IF Uwm100.prem_t < 0 THEN nv_0rq_prs = nv_0rq_prs + Uwd200.ripr.
                  ELSE nv_0rq_prp = nv_0rq_prp + Uwd200.ripr.
          END. /* RQ */

          ELSE IF SUBSTRING(uwd200.rico,1,3) = "0PS" THEN DO:
                  nt_0ps_pr = nt_0ps_pr + uwd200.ripr.
                  IF Uwm100.prem_t < 0 THEN nv_0ps_prs = nv_0ps_prs + Uwd200.ripr.
                  ELSE nv_0ps_prp = nv_0ps_prp + Uwd200.ripr.
          END. /* PS */
          ELSE IF SUBSTRING(uwd200.rico,1,3) = "0TF"  AND
                  SUBSTRING(uwd200.rico,6,2) = "FB"  THEN DO:
                  nt_btr_pr = nt_btr_pr + uwd200.ripr.
                  IF Uwm100.prem_t < 0 THEN nv_btr_prs = nv_btr_prs + Uwd200.ripr.
                  ELSE nv_btr_prp = nv_btr_prp + Uwd200.ripr.
          END. /* FB */

          ELSE IF SUBSTRING(uwd200.rico,1,3) = "0TF"  AND
                  SUBSTRING(uwd200.rico,6,2) = "FO"  THEN DO:
                  nt_otr_pr = nt_otr_pr + uwd200.ripr.
                  IF Uwm100.prem_t < 0 THEN nv_otr_prs = nv_otr_prs + Uwd200.ripr.
                  ELSE nv_otr_prp = nv_otr_prp + Uwd200.ripr.
          END. /* FO */

          ELSE IF SUBSTRING(uwd200.rico,1,3) = "0TF"  AND   /* A450055*/
                  SUBSTRING(uwd200.rico,6,2) = "FT"  THEN DO:
                  nt_ftr_pr = nt_ftr_pr + uwd200.ripr.
                  IF Uwm100.prem_t < 0 THEN nv_ftr_prs = nv_ftr_prs + Uwd200.ripr.
                  ELSE nv_ftr_prp = nv_ftr_prp + Uwd200.ripr.
          END. /* FT */

          ELSE IF SUBSTRING(uwd200.rico,1,4) = "0TA8"  AND
                  SUBSTRING(uwd200.rico,7,1) = "2"  THEN DO:
                  nt_s8_pr = nt_s8_pr + uwd200.ripr.
                  IF Uwm100.prem_t < 0 THEN nv_s8_prs = nv_s8_prs + Uwd200.ripr.
                  ELSE nv_s8_prp = nv_s8_prp + Uwd200.ripr.
          END. /* s8 */

          ELSE DO:
              nt_other_pr     = nt_other_pr + uwd200.ripr.
              IF Uwm100.prem_t < 0 THEN nv_other_prs = nv_other_prs + Uwd200.ripr.
              ELSE nv_other_prp = nv_other_prp + Uwd200.ripr.
         END. /* Other */

         END.   /* each uwd200 */

         FIND  FIRST work_fil  WHERE
                     work_fil.wbrn_line = nv_brn_line NO-ERROR.
         IF  NOT AVAIL work_fil THEN DO:
            CREATE  work_fil.
            ASSIGN  work_fil.wbrn_line = nv_brn_line.
         END.

         ASSIGN work_fil.wsigr  = work_fil.wsigr + nt_sigr
                work_fil.wprem  = work_fil.wprem + nt_prem
                work_fil.wstat  = work_fil.wstat + nt_stat_pr
                work_fil.wret   = work_fil.wret  + nt_ret_pr
                work_fil.w0q    = work_fil.w0q   + nt_0q_pr
                work_fil.w0t    = work_fil.w0t   + nt_0t_pr
                work_fil.w0s    = work_fil.w0s   + nt_0s_pr
                work_fil.wf1    = work_fil.wf1   + nt_f1_pr
                work_fil.wf2    = work_fil.wf2   + nt_f2_pr
                work_fil.wf3    = work_fil.wf3   + nt_f3_pr
                work_fil.wf4    = work_fil.wf4   + nt_f4_pr  
                work_fil.w0rq   = work_fil.w0rq  + nt_0rq_pr
                work_fil.w0ps   = work_fil.w0ps  + nt_0ps_pr
                work_fil.wbtr   = work_fil.wbtr  + nt_btr_pr
                work_fil.wotr   = work_fil.wotr  + nt_otr_pr
                work_fil.wftr   = work_fil.wftr  + nt_ftr_pr 
                work_fil.ws8    = work_fil.ws8   + nt_s8_pr
                work_fil.wother = work_fil.wother + nt_other_pr.
          
         ASSIGN work_fil.wsigrp  = work_fil.wsigrp  + nv_sigrp
                work_fil.wpremp  = work_fil.wpremp  + nv_premp
                work_fil.wstatp  = work_fil.wstatp  + nv_stat_prp
                work_fil.wretp   = work_fil.wretp   + nv_ret_prp
                work_fil.w0qp    = work_fil.w0qp    + nv_0q_prp
                work_fil.w0tp    = work_fil.w0tp    + nv_0t_prp
                work_fil.w0sp    = work_fil.w0sp    + nv_0s_prp
                work_fil.wf1p    = work_fil.wf1p    + nv_f1_prp
                work_fil.wf2p    = work_fil.wf2p    + nv_f2_prp
                work_fil.wf3p    = work_fil.wf3p    + nv_f3_prp
                work_fil.wf4p    = work_fil.wf4p    + nv_f4_prp 
                work_fil.w0rqp   = work_fil.w0rqp   + nv_0rq_prp
                work_fil.w0psp   = work_fil.w0psp   + nv_0ps_prp
                work_fil.wbtrp   = work_fil.wbtrp   + nv_btr_prp
                work_fil.wotrp   = work_fil.wotrp   + nv_otr_prp
                work_fil.wftrp   = work_fil.wftrp   + nv_ftr_prp
                work_fil.ws8p    = work_fil.ws8p    + nv_s8_prp
                work_fil.wotherp = work_fil.wotherp + nv_other_prp.

         ASSIGN work_fil.wsigrs  = work_fil.wsigrs  + nv_sigrs
                work_fil.wprems  = work_fil.wprems  + nv_prems
                work_fil.wstats  = work_fil.wstats  + nv_stat_prs
                work_fil.wrets   = work_fil.wrets   + nv_ret_prs
                work_fil.w0qs    = work_fil.w0qs    + nv_0q_prs
                work_fil.w0ts    = work_fil.w0ts    + nv_0t_prs
                work_fil.w0ss    = work_fil.w0ss    + nv_0s_prs
                work_fil.wf1s    = work_fil.wf1s    + nv_f1_prs
                work_fil.wf2s    = work_fil.wf2s    + nv_f2_prs
                work_fil.wf3s    = work_fil.wf3s    + nv_f3_prs
                work_fil.wf4s    = work_fil.wf4s    + nv_f4_prs 
                work_fil.w0rqs   = work_fil.w0rqs   + nv_0rq_prs
                work_fil.w0pss   = work_fil.w0pss   + nv_0ps_prs
                work_fil.wbtrs   = work_fil.wbtrs   + nv_btr_prs
                work_fil.wotrs   = work_fil.wotrs   + nv_otr_prs
                work_fil.wftrs   = work_fil.wftrs   + nv_ftr_prs  
                work_fil.ws8s    = work_fil.ws8s    + nv_s8_prs
                work_fil.wothers = work_fil.wothers + nv_other_prs.
             
         ASSIGN nt_sigr      = 0        nt_prem      = 0
                nt_stat_pr   = 0        nt_ret_pr    = 0
                nt_0q_pr     = 0        nt_0t_pr     = 0
                nt_0s_pr     = 0        nt_f1_pr     = 0
                nt_f2_pr     = 0        nt_f3_pr     = 0
                nt_f4_pr     = 0        nt_0rq_pr    = 0
                nt_0ps_pr    = 0        nt_btr_pr    = 0
                nt_otr_pr    = 0        nt_ftr_pr    = 0  
                nt_s8_pr     = 0        nt_other_pr  = 0.
          
         ASSIGN nv_sigrp      = 0       nv_premp      = 0
                nv_stat_prp   = 0       nv_ret_prp    = 0
                nv_0q_prp     = 0       nv_0t_prp     = 0
                nv_0s_prp     = 0       nv_f1_prp     = 0
                nv_f2_prp     = 0       nv_f3_prp     = 0
                nv_f4_prp     = 0       nv_0rq_prp    = 0
                nv_0ps_prp    = 0       nv_btr_prp    = 0
                nv_otr_prp    = 0       nv_ftr_prp    = 0  
                nv_s8_prp     = 0       nv_other_prp  = 0.

         ASSIGN nv_sigrs      = 0       nv_prems      = 0
                nv_stat_prs   = 0       nv_ret_prs    = 0
                nv_0q_prs     = 0       nv_0t_prs     = 0
                nv_0s_prs     = 0       nv_f1_prs     = 0
                nv_f2_prs     = 0       nv_f3_prs     = 0
                nv_f4_prs     = 0       nv_0rq_prs    = 0
                nv_0ps_prs    = 0       nv_btr_prs    = 0
                nv_otr_prs    = 0       nv_ftr_prs    = 0  
                nv_s8_prs     = 0       nv_other_prs  = 0.

END. /* each uwm100 */

    FOR EACH  work_fil  
    BREAK BY  SUBSTR (work_fil.wbrn_line,1,1)
          BY  SUBSTR (work_fil.wbrn_line,5,2)
          BY  SUBSTR (work_fil.wbrn_line,3,1).

        OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
        EXPORT DELIMITER ";"
             work_fil.wbrn_line + " [+]"   
             work_fil.wsigrp      
             work_fil.wpremp      
             work_fil.wretp       
             work_fil.wstatp * -1 
             work_fil.w0tp   * -1 
             work_fil.w0sp   * -1 
             work_fil.w0qp   * -1 
             work_fil.wf1p   * -1 
             work_fil.wf2p   * -1 
             work_fil.wf3p   * -1 
             work_fil.wf4p   * -1 
             work_fil.w0rqp  * -1 
             work_fil.w0psp  * -1 
             work_fil.wbtrp  * -1 
             work_fil.wotrp  * -1 
             work_fil.wftrp  * -1 
             work_fil.ws8p   * -1.

        EXPORT DELIMITER ";"
             work_fil.wbrn_line + " [-]"  
             work_fil.wsigrs      
             work_fil.wprems      
             work_fil.wrets       
             work_fil.wstats * -1
             work_fil.w0ts   * -1
             work_fil.w0ss   * -1
             work_fil.w0qs   * -1
             work_fil.wf1s   * -1
             work_fil.wf2s   * -1
             work_fil.wf3s   * -1
             work_fil.wf4s   * -1
             work_fil.w0rqs  * -1
             work_fil.w0pss  * -1
             work_fil.wbtrs  * -1
             work_fil.wotrs  * -1
             work_fil.wftrs  * -1
             work_fil.ws8s   * -1.
        OUTPUT CLOSE.
        
    END.  /* each work_fil */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcSummp C-Win 
PROCEDURE ProcSummp :
/*------------------------------------------------------------------------------
  Purpose:   Summary For Policy  
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR fr_trndat   AS  DATE  FORMAT  "99/99/9999".
DEF VAR to_trndat   AS  DATE  FORMAT  "99/99/9999".
DEF VAR nv_output   AS  CHAR  FORMAT  "x(10)".

DEF VAR nt_sigr     LIKE  uwm100.sigr_p.
DEF VAR nt_prem     LIKE  uwm100.prem_t.

DEF VAR nt_stat_pr  LIKE  uwd200.ripr.
DEF VAR nt_ret_pr   LIKE  uwd200.ripr.
DEF VAR nt_0q_pr    LIKE  uwd200.ripr.
DEF VAR nt_0t_pr    LIKE  uwd200.ripr.
DEF VAR nt_0s_pr    LIKE  uwd200.ripr.
DEF VAR nt_f1_pr    LIKE  uwd200.ripr.
DEF VAR nt_f2_pr    LIKE  uwd200.ripr.
DEF VAR nt_f3_pr    LIKE  uwd200.ripr.
DEF VAR nt_f4_pr    LIKE  uwd200.ripr. 
DEF VAR nt_0rq_pr   LIKE  uwd200.ripr.
DEF VAR nt_0ps_pr   LIKE  uwd200.ripr.
DEF VAR nt_btr_pr   LIKE  uwd200.ripr.
DEF VAR nt_otr_pr   LIKE  uwd200.ripr.
DEF VAR nt_ftr_pr   LIKE  uwd200.ripr. 
DEF VAR nt_s8_pr    LIKE  uwd200.ripr.
DEF VAR nt_other_pr LIKE  uwd200.ripr.
DEF VAR np_line     AS    CHAR  FORMAT  "x(30)".

DEF VAR nv_brn_line AS CHAR FORMAT "x(4)" COLUMN-LABEL "  LINE  ".

ASSIGN  nv_output   = TRIM(n_write) + ".SLK".

OUTPUT TO VALUE (nv_output) NO-ECHO.
EXPORT DELIMITER ";"
    ""
    "Sum Insured" 
    "TOT Premium" 
    "Retention"   
    "QBaht"       
    "TFP"         
    "1st"         
    "2nd"         
    "F1"          
    "F2"          
    "F3"          
    "F4"          
    "0QS"         
    "MPS"         
    "BTR"         
    "OTR"         
    "FTR"         
    "S8".
OUTPUT CLOSE.

FOR EACH uwm100  NO-LOCK  USE-INDEX uwm10008  WHERE
         uwm100.trndat >= n_date_fr   AND 
         uwm100.trndat <= n_date_to   AND 
         uwm100.poltyp <> "V70"       AND 
         uwm100.poltyp <> "V72"       AND 
         uwm100.poltyp <> "V73"       AND 
         uwm100.poltyp <> "V74"       AND 
         uwm100.releas = YES          AND 
         uwm100.endcnt = 000.

         ASSIGN nv_brn_line  = SUBSTR (uwm100.policy,1,1) + "-" +
                               SUBSTR (uwm100.policy,2,1) + "-" +
                               SUBSTR (uwm100.policy,3,2)

                nt_sigr      = nt_sigr + uwm100.sigr_p
                nt_prem      = nt_prem + uwm100.prem_t.

         FOR EACH uwd200 USE-INDEX uwd20001 WHERE
                               uwd200.policy = uwm100.policy AND
                               uwd200.rencnt = uwm100.rencnt AND
                               uwd200.endcnt = uwm100.endcnt AND
                               uwd200.csftq  <> "C" 
                               NO-LOCK.

DISPLAY uwm100.trndat uwm100.policy SUBSTR(uwm100.policy,3, 2)
SUBSTR(uwm100.policy,2,1)  uwd200.rico 
WITH COLOR blue/withe NO-LABEL 
TITLE "Process Data.." WIDTH 60 FRAME amain VIEW-AS DIALOG-BOX.
PAUSE 0.

         IF         uwd200.rico  = "STAT"  THEN    /* Qbaht */
                  nt_stat_pr      = nt_stat_pr + uwd200.ripr.

         ELSE IF    uwd200.rico  = "0RET"  THEN
                  nt_ret_pr       = nt_ret_pr + uwd200.ripr.

         ELSE IF    SUBSTRING(uwd200.rico,1,2) = "0Q"  THEN   /*TFB */
                  nt_0q_pr        = nt_0q_pr  + uwd200.ripr.

         ELSE IF    SUBSTRING(uwd200.rico,1,2) = "0T"  AND
                  SUBSTRING(uwd200.rico,6,2) = "01"  THEN
                  nt_0t_pr        = nt_0t_pr + uwd200.ripr.

         ELSE IF    SUBSTRING(uwd200.rico,1,2) = "0T"  AND
                  SUBSTRING(uwd200.rico,6,2) = "02"  THEN
                  nt_0s_pr        = nt_0s_pr + uwd200.ripr.

         ELSE IF    SUBSTRING(uwd200.rico,1,2) = "0T"  AND
                  SUBSTRING(uwd200.rico,6,2) = "F1"  THEN
                  nt_f1_pr        = nt_f1_pr + uwd200.ripr.

         ELSE IF    SUBSTRING(uwd200.rico,1,2) = "0T"  AND
                  SUBSTRING(uwd200.rico,6,2) = "F2"  THEN
                  nt_f2_pr        = nt_f2_pr + uwd200.ripr.

         ELSE IF    SUBSTRING(uwd200.rico,1,2) = "0T"  AND
                  SUBSTRING(uwd200.rico,6,2) = "F3"  THEN
                  nt_f3_pr        = nt_f3_pr + uwd200.ripr.
                  
         ELSE IF    SUBSTRING(uwd200.rico,1,2) = "0T"  AND   
                  SUBSTRING(uwd200.rico,6,2) = "F4"  THEN
                  nt_f4_pr        = nt_f4_pr + uwd200.ripr.

         ELSE IF    SUBSTRING(uwd200.rico,1,3) = "0RQ" THEN
                  nt_0rq_pr       = nt_0rq_pr + uwd200.ripr.

         ELSE IF    SUBSTRING(uwd200.rico,1,3) = "0PS" THEN
                  nt_0ps_pr       = nt_0ps_pr + uwd200.ripr.

         ELSE IF    SUBSTRING(uwd200.rico,1,3) = "0TF"  AND
                  SUBSTRING(uwd200.rico,6,2) = "FB"  THEN
                  nt_btr_pr        = nt_btr_pr + uwd200.ripr.

         ELSE IF    SUBSTRING(uwd200.rico,1,3) = "0TF"  AND
                  SUBSTRING(uwd200.rico,6,2) = "FO"  THEN
                  nt_otr_pr        = nt_otr_pr + uwd200.ripr.

         ELSE IF    SUBSTRING(uwd200.rico,1,3) = "0TF"  AND  
                  SUBSTRING(uwd200.rico,6,2) = "FT"  THEN
                  nt_ftr_pr        = nt_ftr_pr + uwd200.ripr.

         ELSE IF    SUBSTRING(uwd200.rico,1,4) = "0TA8"  AND
                  SUBSTRING(uwd200.rico,7,1) = "2"  THEN
                  nt_s8_pr        = nt_s8_pr + uwd200.ripr.

         ELSE       nt_other_pr     = nt_other_pr + uwd200.ripr.


       END.   /*each uwd200 */

        FIND  FIRST work_fil  WHERE
                   work_fil.wbrn_line   = nv_brn_line NO-ERROR.
        IF  NOT AVAIL work_fil  THEN
            CREATE  work_fil.
            ASSIGN  work_fil.wbrn_line  = nv_brn_line.

        ASSIGN   work_fil.wsigr  = work_fil.wsigr + nt_sigr
                 work_fil.wprem  = work_fil.wprem + nt_prem
                 work_fil.wstat  = work_fil.wstat + nt_stat_pr
                 work_fil.wret   = work_fil.wret  + nt_ret_pr
                 work_fil.w0q    = work_fil.w0q   + nt_0q_pr
                 work_fil.w0t    = work_fil.w0t   + nt_0t_pr
                 work_fil.w0s    = work_fil.w0s   + nt_0s_pr
                 work_fil.wf1    = work_fil.wf1   + nt_f1_pr
                 work_fil.wf2    = work_fil.wf2   + nt_f2_pr
                 work_fil.wf3    = work_fil.wf3   + nt_f3_pr
                 work_fil.wf4    = work_fil.wf4   + nt_f4_pr  
                 work_fil.w0rq   = work_fil.w0rq  + nt_0rq_pr
                 work_fil.w0ps   = work_fil.w0ps  + nt_0ps_pr
                 work_fil.wbtr   = work_fil.wbtr  + nt_btr_pr
                 work_fil.wotr   = work_fil.wotr  + nt_otr_pr
                 work_fil.wftr   = work_fil.wftr  + nt_ftr_pr 
                 work_fil.ws8    = work_fil.ws8   + nt_s8_pr
                 work_fil.wother = work_fil.wother + nt_other_pr.


       ASSIGN   nt_sigr      = 0
                nt_prem      = 0
                nt_stat_pr   = 0
                nt_ret_pr    = 0
                nt_0q_pr     = 0
                nt_0t_pr     = 0
                nt_0s_pr     = 0
                nt_f1_pr     = 0
                nt_f2_pr     = 0
                nt_f3_pr     = 0
                nt_f4_pr     = 0  
                nt_0rq_pr    = 0
                nt_0ps_pr    = 0
                nt_btr_pr    = 0
                nt_otr_pr    = 0
                nt_ftr_pr    = 0  
                nt_s8_pr     = 0
                nt_other_pr  = 0.

END.   /* each uwm100 */

    FOR EACH  work_fil  
    BREAK  BY   SUBSTR (work_fil.wbrn_line,1,1)
           BY   SUBSTR (work_fil.wbrn_line,5,2)
           BY   SUBSTR (work_fil.wbrn_line,3,1).

        IF  work_fil.wstat  < 0  THEN
            work_fil.wstat  = work_fil.wstat * (-1).

        IF  work_fil.w0q    < 0 THEN
                  work_fil.w0q   = work_fil.w0q  * (-1).

        IF  work_fil.w0t    < 0 THEN
                  work_fil.w0t   = work_fil.w0t  * (-1).

        IF  work_fil.w0s    < 0 THEN
                  work_fil.w0s  =  work_fil.w0s  * (-1).

        IF  work_fil.wf1    < 0 THEN
                  work_fil.wf1  = work_fil.wf1  * (-1).

        IF  work_fil.wf2    < 0 THEN
                  work_fil.wf2  = work_fil.wf2  * (-1).

        IF  work_fil.wf3    < 0 THEN
                  work_fil.wf3  = work_fil.wf3  * (-1).

        IF  work_fil.wf4    < 0 THEN
                  work_fil.wf4  = work_fil.wf4  * (-1).   

        IF  work_fil.w0rq    < 0 THEN
                  work_fil.w0rq = work_fil.w0rq  * (-1).

        IF  work_fil.w0ps    < 0 THEN
                  work_fil.w0ps  = work_fil.w0ps  * (-1).

        IF  work_fil.wbtr    < 0 THEN
                  work_fil.wbtr  = work_fil.wbtr  * (-1).

        IF  work_fil.wotr    < 0 THEN
                  work_fil.wotr = work_fil.wotr  * (-1).

        IF  work_fil.wftr    < 0 THEN                     
                  work_fil.wftr = work_fil.wftr  * (-1).             

        IF  work_fil.ws8    < 0 THEN
                  work_fil.ws8 = work_fil.ws8  * (-1).

        IF  work_fil.wret    < 0 THEN
                  work_fil.wret = work_fil.wret  * (-1).

        IF  work_fil.wother    < 0 THEN
                  work_fil.wother = work_fil.wother  * (-1).
              
        OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
        EXPORT DELIMITER ";"    
            work_fil.wbrn_line
            work_fil.wsigr
            work_fil.wprem
            work_fil.wret
            work_fil.wstat
            work_fil.w0t
            work_fil.w0s
            work_fil.w0q
            work_fil.wf1
            work_fil.wf2
            work_fil.wf3
            work_fil.wf4                         
            work_fil.w0rq
            work_fil.w0ps
            work_fil.wbtr
            work_fil.wotr
            work_fil.wftr  
            work_fil.ws8.
        OUTPUT CLOSE.

    END. 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE procTrnty_C C-Win 
PROCEDURE procTrnty_C :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND FIRST xmm024 NO-LOCK NO-ERROR.
FIND uwm200 WHERE RECID(uwm200) = s_recid NO-WAIT NO-ERROR .
FIND FIRST uwd200 USE-INDEX uwd20001 WHERE 
           uwd200.policy = uwm200.policy AND
           uwd200.rencnt = uwm200.rencnt AND
           uwd200.endcnt = uwm200.endcnt AND
           uwd200.c_enct = uwm200.c_enct AND
           uwd200.csftq  = uwm200.csftq  AND
           uwd200.rico   = uwm200.rico   NO-LOCK NO-ERROR.
   IF NOT AVAIL uwd200 THEN DO:
    /*  DISPLAY  " *** UWD200 INVALID *** "  .  */
   END.
   ELSE DO:
     REPEAT:
     FIND FIRST uwm120 USE-INDEX uwm12001 WHERE 
                uwm120.policy = uwd200.policy AND
                uwm120.rencnt = uwd200.rencnt AND
                uwm120.endcnt = uwd200.endcnt AND
                uwm120.riskgp = uwd200.riskgp AND
                uwm120.riskno = uwd200.riskno NO-LOCK NO-ERROR.
       IF SUBSTRING(uwm120.policy,3,2) = "90" THEN nvexch = 1.
       ELSE nvexch = uwm120.siexch.

       IF uwd200.rico  = "STAT"  THEN DO:
          ASSIGN nv_stat_si   = nv_stat_si  + ((uwd200.risi * -1) * nvexch )
                 nv_stat_pr   = nv_stat_pr  + (uwd200.ripr)
                 nv_stat_sib  = nv_stat_sib + ((uwd200.risi * -1) * nvexch )
                 nv_stat_prb  = nv_stat_prb + (uwd200.ripr)
                 iv_stat_si   = iv_stat_si  + ((uwd200.risi * -1) * nvexch )
                 iv_stat_pr   = iv_stat_pr  + (uwd200.ripr)
                 iv_stat_sib  = iv_stat_sib + ((uwd200.risi * -1) * nvexch )
                 iv_stat_prb  = iv_stat_prb + (uwd200.ripr)
                 n_sumq       = n_sumq      + ((uwd200.risi * -1) * nvexch )
                 n_prmq       = n_prmq      + (uwd200.ripr)
                 p_q          = uwd200.risi_p.
       END.

       IF uwd200.rico  = "0RET"  THEN DO:
          ASSIGN nv_ret_sib  = nv_ret_sib + ((uwd200.risi * -1) * nvexch )
                 nv_ret_prb  = nv_ret_prb + (uwd200.ripr)
                 iv_ret_sib  = iv_ret_sib + ((uwd200.risi * -1) * nvexch )
                 iv_ret_prb  = iv_ret_prb + (uwd200.ripr)
                 n_sumr       = n_sumr    + ((uwd200.risi * -1) * nvexch )
                 n_prmr       = n_prmr    + (uwd200.ripr)
                 p_r          = uwd200.risi_p.
       END.

       IF SUBSTRING(uwd200.rico,1,3) = "0RQ"  THEN DO:
          ASSIGN nv_0rq_si   = nv_0rq_si  + ((uwd200.risi * -1) * nvexch )
                 nv_0rq_pr   = nv_0rq_pr  + (uwd200.ripr)
                 nv_0rq_sib  = nv_0rq_sib + ((uwd200.risi * -1) * nvexch )
                 nv_0rq_prb  = nv_0rq_prb + (uwd200.ripr)
                 iv_0rq_si   = iv_0rq_si  + ((uwd200.risi * -1) * nvexch )
                 iv_0rq_pr   = iv_0rq_pr  + (uwd200.ripr)
                 iv_0rq_sib  = iv_0rq_sib + ((uwd200.risi * -1) * nvexch )
                 iv_0rq_prb  = iv_0rq_prb + (uwd200.ripr)
                 n_sumrq     = n_sumrq    + ((uwd200.risi * -1) * nvexch )
                 n_prmrq     = n_prmrq    + (uwd200.ripr)
                 p_rq        = uwd200.risi_p.
       END.

       IF SUBSTRING(uwd200.rico,1,2) = "0Q"  THEN DO:
          ASSIGN nv_0q_si   = nv_0q_si  + ((uwd200.risi * -1) * nvexch )
                 nv_0q_pr   = nv_0q_pr  + (uwd200.ripr)
                 nv_0q_sib  = nv_0q_sib + ((uwd200.risi * -1) * nvexch )
                 nv_0q_prb  = nv_0q_prb + (uwd200.ripr)
                 iv_0q_si   = iv_0q_si  + ((uwd200.risi * -1) * nvexch )
                 iv_0q_pr   = iv_0q_pr  + (uwd200.ripr)
                 iv_0q_sib  = iv_0q_sib + ((uwd200.risi * -1) * nvexch )
                 iv_0q_prb  = iv_0q_prb + (uwd200.ripr)
                 n_sumtfp   = n_sumtfp  + ((uwd200.risi * -1) * nvexch )
                 n_prmtfp   = n_prmtfp  + (uwd200.ripr)
                 p_tfp      = uwd200.risi_p.
       END.

       IF SUBSTRING(uwd200.rico,1,2) = "0T"
          AND SUBSTRING(uwd200.rico,6,2) = "01"  THEN DO:
          ASSIGN nv_0t_si   = nv_0t_si  + ((uwd200.risi * -1) * nvexch )
                 nv_0t_pr   = nv_0t_pr  + (uwd200.ripr)
                 nv_0t_sib  = nv_0t_sib + ((uwd200.risi * -1) * nvexch )
                 nv_0t_prb  = nv_0t_prb + (uwd200.ripr)
                 iv_0t_si   = iv_0t_si  + ((uwd200.risi * -1) * nvexch )
                 iv_0t_pr   = iv_0t_pr  + (uwd200.ripr)
                 iv_0t_sib  = iv_0t_sib + ((uwd200.risi * -1) * nvexch )
                 iv_0t_prb  = iv_0t_prb + (uwd200.ripr)
                 n_sumt     = n_sumt    + ((uwd200.risi * -1) * nvexch )
                 n_prmt     = n_prmt    + (uwd200.ripr)
                 p_t        = uwd200.risi_p.
       END.

       IF SUBSTRING(uwd200.rico,1,2) = "0T"
          AND SUBSTRING(uwd200.rico,6,2) = "02"  THEN DO:
          ASSIGN nv_0s_si  = nv_0s_si  + ((uwd200.risi * -1) * nvexch )
                 nv_0s_pr  = nv_0s_pr  + (uwd200.ripr)
                 nv_0s_sib = nv_0s_sib + ((uwd200.risi * -1) * nvexch )
                 nv_0s_prb = nv_0s_prb + (uwd200.ripr)
                 iv_0s_si  = iv_0s_si  + ((uwd200.risi * -1) * nvexch )
                 iv_0s_pr  = iv_0s_pr  + (uwd200.ripr)
                 iv_0s_sib = iv_0s_sib + ((uwd200.risi * -1) * nvexch )
                 iv_0s_prb = iv_0s_prb + (uwd200.ripr)
                 n_sums    = n_sums    + ((uwd200.risi * -1) * nvexch )
                 n_prms    = n_prms    + (uwd200.ripr)
                 p_s       = uwd200.risi_p.
       END.

       IF SUBSTRING(uwd200.rico,1,2) = "0T"
          AND SUBSTRING(uwd200.rico,6,2) = "F1"  THEN DO:
          ASSIGN nv_f1_si  = nv_f1_si  + ((uwd200.risi * -1) * nvexch )
                 nv_f1_pr  = nv_f1_pr  + (uwd200.ripr)
                 nv_f1_sib = nv_f1_sib + ((uwd200.risi * -1) * nvexch )
                 nv_f1_prb = nv_f1_prb + (uwd200.ripr)
                 iv_f1_si  = iv_f1_si  + ((uwd200.risi * -1) * nvexch )
                 iv_f1_pr  = iv_f1_pr  + (uwd200.ripr)
                 iv_f1_sib = iv_f1_sib + ((uwd200.risi * -1) * nvexch )
                 iv_f1_prb = iv_f1_prb + (uwd200.ripr)
                 n_sumf1   = n_sumf1   + ((uwd200.risi * -1) * nvexch )
                 n_prmf1   = n_prmf1   + (uwd200.ripr)
                 p_f1      = uwd200.risi_p.
       END.

       IF SUBSTRING(uwd200.rico,1,2) = "0T"
          AND SUBSTRING(uwd200.rico,6,2) = "F2"  THEN DO:
          ASSIGN nv_f2_si  = nv_f2_si  + ((uwd200.risi * -1) * nvexch )
                 nv_f2_pr  = nv_f2_pr  + (uwd200.ripr)
                 nv_f2_sib = nv_f2_sib + ((uwd200.risi * -1) * nvexch )
                 nv_f2_prb = nv_f2_prb + (uwd200.ripr)
                 iv_f2_si  = iv_f2_si  + ((uwd200.risi * -1) * nvexch )
                 iv_f2_pr  = iv_f2_pr  + (uwd200.ripr)
                 iv_f2_sib = iv_f2_sib + ((uwd200.risi * -1) * nvexch )
                 iv_f2_prb = iv_f2_prb + (uwd200.ripr)
                 n_sumf2   = n_sumf2   + ((uwd200.risi * -1) * nvexch )
                 n_prmf2   = n_prmf2   + (uwd200.ripr)
                 p_f2      = uwd200.risi_p.
       END.

       IF SUBSTRING(uwd200.rico,1,3) = "0PS"  THEN DO:
          ASSIGN nv_0ps_si   = nv_0ps_si  + ((uwd200.risi * -1) * nvexch )
                 nv_0ps_pr   = nv_0ps_pr  + (uwd200.ripr)
                 nv_0ps_sib  = nv_0ps_sib + ((uwd200.risi * -1) * nvexch )
                 nv_0ps_prb  = nv_0ps_prb + (uwd200.ripr)
                 iv_0ps_si   = iv_0ps_si  + ((uwd200.risi * -1) * nvexch )
                 iv_0ps_pr   = iv_0ps_pr  + (uwd200.ripr)
                 iv_0ps_sib  = iv_0ps_sib + ((uwd200.risi * -1) * nvexch )
                 iv_0ps_prb  = iv_0ps_prb + (uwd200.ripr)
                 n_sumps     = n_sumps    + ((uwd200.risi * -1) * nvexch )
                 n_prmps     = n_prmps    + (uwd200.ripr)
                 p_ps        = uwd200.risi_p.
       END.
       
       IF SUBSTRING(uwd200.rico,1,3) = "0TF" AND
          SUBSTRING(uwd200.rico,6,2) = "FB"  THEN DO:
          ASSIGN nv_btr_si   = nv_btr_si  + ((uwd200.risi * -1) * nvexch )
                 nv_btr_pr   = nv_btr_pr  + (uwd200.ripr)
                 nv_btr_sib  = nv_btr_sib + ((uwd200.risi * -1) * nvexch )
                 nv_btr_prb  = nv_btr_prb + (uwd200.ripr)
                 iv_btr_si   = iv_btr_si  + ((uwd200.risi * -1) * nvexch )
                 iv_btr_pr   = iv_btr_pr  + (uwd200.ripr)
                 iv_btr_sib  = iv_btr_sib + ((uwd200.risi * -1) * nvexch )
                 iv_btr_prb  = iv_btr_prb + (uwd200.ripr)
                 n_sumbtr    = n_sumbtr   + ((uwd200.risi * -1) * nvexch )
                 n_prmbtr    = n_prmbtr   + (uwd200.ripr)
                 p_btr       = uwd200.risi_p.
       END.

       IF SUBSTRING(uwd200.rico,1,3) = "0TF" AND
          SUBSTRING(uwd200.rico,6,2) = "FO"  THEN DO:   
          ASSIGN nv_otr_si   = nv_otr_si  + ((uwd200.risi * -1) * nvexch )
                 nv_otr_pr   = nv_otr_pr  + (uwd200.ripr)
                 nv_otr_sib  = nv_otr_sib + ((uwd200.risi * -1) * nvexch )
                 nv_otr_prb  = nv_otr_prb + (uwd200.ripr)
                 iv_otr_si   = iv_otr_si  + ((uwd200.risi * -1) * nvexch )
                 iv_otr_pr   = iv_otr_pr  + (uwd200.ripr)
                 iv_otr_sib  = iv_otr_sib + ((uwd200.risi * -1) * nvexch )
                 iv_otr_prb  = iv_otr_prb + (uwd200.ripr)
                 n_sumotr    = n_sumotr   + ((uwd200.risi * -1) * nvexch )
                 n_prmotr    = n_prmotr   + (uwd200.ripr)
                 p_otr       = uwd200.risi_p.
       END.

       IF (SUBSTRING (uwd200.rico,1,4) = "0TA8" AND 
           SUBSTRING (uwd200.rico,7,1) = "2" )  OR 
          (SUBSTRING (uwd200.rico,1,2) = "0T"   AND 
           SUBSTRING (uwd200.rico,6,2) = "F3")  THEN DO:
           ASSIGN nv_s8_si  = nv_s8_si  + ((uwd200.risi * -1) * nvexch )
                  nv_s8_pr  = nv_s8_pr  + (uwd200.ripr)
                  nv_s8_sib = nv_s8_sib + ((uwd200.risi * -1) * nvexch )
                  nv_s8_prb = nv_s8_prb + (uwd200.ripr)
                  iv_s8_si  = iv_s8_si  + ((uwd200.risi * -1) * nvexch )
                  iv_s8_pr  = iv_s8_pr  + (uwd200.ripr)
                  iv_s8_sib = iv_s8_sib + ((uwd200.risi * -1) * nvexch )
                  iv_s8_prb = iv_s8_prb + (uwd200.ripr)
                  n_sums8   = n_sums8   + ((uwd200.risi * -1) * nvexch )
                  n_prms8   = n_prms8   + (uwd200.ripr)
                  p_s8      = uwd200.risi_p.
       END.
 
       IF SUBSTRING(uwd200.rico,1,2) = "0T"
          AND SUBSTRING(uwd200.rico,6,2) = "F4"  THEN DO:
          ASSIGN nv_f4_si  = nv_f4_si  + ((uwd200.risi * -1) * nvexch )
                 nv_f4_pr  = nv_f4_pr  + (uwd200.ripr)
                 nv_f4_sib = nv_f4_sib + ((uwd200.risi * -1) * nvexch )
                 nv_f4_prb = nv_f4_prb + (uwd200.ripr)
                 iv_f4_si  = iv_f4_si  + ((uwd200.risi * -1) * nvexch )
                 iv_f4_pr  = iv_f4_pr  + (uwd200.ripr)
                 iv_f4_sib = iv_f4_sib + ((uwd200.risi * -1) * nvexch )
                 iv_f4_prb = iv_f4_prb + (uwd200.ripr)
                 n_sumf4   = n_sumf4   + ((uwd200.risi * -1) * nvexch )
                 n_prmf4   = n_prmf4   + (uwd200.ripr)
                 p_f4      = uwd200.risi_p.
       END.
       IF SUBSTRING(uwd200.rico,1,2) = "0T"
          AND SUBSTRING(uwd200.rico,6,2) = "FT"  THEN DO:
          ASSIGN nv_ftr_si  = nv_ftr_si  + ((uwd200.risi * -1) * nvexch )
                 nv_ftr_pr  = nv_ftr_pr  + (uwd200.ripr)
                 nv_ftr_sib = nv_ftr_sib + ((uwd200.risi * -1) * nvexch )
                 nv_ftr_prb = nv_ftr_prb + (uwd200.ripr)
                 iv_ftr_si  = iv_ftr_si  + ((uwd200.risi * -1) * nvexch )
                 iv_ftr_pr  = iv_ftr_pr  + (uwd200.ripr)
                 iv_ftr_sib = iv_ftr_sib + ((uwd200.risi * -1) * nvexch )
                 iv_ftr_prb = iv_ftr_prb + (uwd200.ripr)
                 n_sumftr   = n_sumftr   + ((uwd200.risi * -1) * nvexch )
                 n_prmftr   = n_prmftr   + (uwd200.ripr)
                 p_ftr      = uwd200.risi_p.
       END.

       IF SUBSTRING(uwd200.rico,1,2) = "0D" OR
          SUBSTRING(uwd200.rico,1,2) = "0F"  THEN DO:
          ASSIGN nv_0f_sib  = nv_0f_sib + ROUND(((uwd200.risi * -1) * nvexch ),2)
                 nv_0f_prb  = nv_0f_prb + ROUND((uwd200.ripr),2)
                 iv_0f_sib  = iv_0f_sib + ROUND(((uwd200.risi * -1) * nvexch ),2)
                 iv_0f_prb  = iv_0f_prb + ROUND((uwd200.ripr),2).

         FIND FIRST wrk0f WHERE wrk0f.rico = uwd200.rico NO-ERROR.
         IF AVAILABLE wrk0f THEN DO:
            ASSIGN wrk0f.sumf = wrk0f.sumf + ROUND(((uwd200.risi * -1) * nvexch ),2)
                   wrk0f.prmf = wrk0f.prmf + ROUND((uwd200.ripr),2).
         END.
         ELSE DO:
            CREATE wrk0f.
            ASSIGN wrk0f.sumf   = ROUND(((uwd200.risi * -1) * nvexch ),2)
                   wrk0f.prmf   = ROUND((uwd200.ripr),2)
                   wrk0f.pf     = uwd200.risi_p
                   wrk0f.rico   = uwd200.rico
                   wrk0f.cess   = uwm200.c_enno.
         END.
       END.

       FIND NEXT uwd200 USE-INDEX uwd20001 WHERE 
                 uwd200.policy = uwm200.policy AND
                 uwd200.rencnt = uwm200.rencnt AND
                 uwd200.endcnt = uwm200.endcnt AND
                 uwd200.c_enct = uwm200.c_enct AND
                 uwd200.csftq  = uwm200.csftq  AND
                 uwd200.rico   = uwm200.rico NO-LOCK NO-ERROR.
      IF NOT AVAIL uwd200 THEN  LEAVE.
     END. /* repeat */
   END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE procTrnty_NC C-Win 
PROCEDURE procTrnty_NC :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND FIRST xmm024 NO-LOCK NO-ERROR.
FIND uwm200 WHERE RECID(uwm200) = s_recid NO-WAIT NO-ERROR .
FIND FIRST uwd200 USE-INDEX uwd20001 WHERE  
           uwd200.policy = uwm200.policy AND
           uwd200.rencnt = uwm200.rencnt AND
           uwd200.endcnt = uwm200.endcnt AND
           uwd200.c_enct = uwm200.c_enct AND
           uwd200.csftq  = uwm200.csftq  AND
           uwd200.rico   = uwm200.rico   NO-LOCK NO-ERROR.
IF NOT AVAIL uwd200 THEN DO:
  /* display  "*** uwd200 invalid ***".    */
END.
ELSE DO:
   REPEAT:
      wrk_si  = 0.     bwrk_si = 0.
      FIND FIRST buwd200 WHERE buwd200.policy = uwm200.policy AND
                 buwd200.rencnt = uwm200.rencnt AND
                 buwd200.endcnt = n_endcnt      AND
                 buwd200.c_enct = uwm200.c_enct AND
                 buwd200.csftq  = uwm200.csftq  AND
                 buwd200.rico   = uwm200.rico   AND
                 buwd200.riskgp = uwd200.riskgp AND
                 buwd200.riskno = uwd200.riskno NO-LOCK NO-ERROR.
      IF NOT AVAIL buwd200 THEN DO:
         wrk_si  = uwd200.risi.
      END.
      ELSE DO:
         ASSIGN bwrk_si = buwd200.risi
                wrk_si  = uwd200.risi - bwrk_si.
      END.

      FIND FIRST uwm120 USE-INDEX uwm12001     WHERE
                 uwm120.policy = uwd200.policy AND
                 uwm120.rencnt = uwd200.rencnt AND
                 uwm120.endcnt = uwd200.endcnt AND
                 uwm120.riskgp = uwd200.riskgp AND
                 uwm120.riskno = uwd200.riskno NO-LOCK NO-ERROR.
      IF SUBSTR(uwm120.policy,3,2) = "90" THEN nvexch = 1.
      ELSE nvexch = uwm120.siexch.
       
      IF uwd200.rico = "STAT"  THEN DO:
         ASSIGN nv_stat_si  = nv_stat_si  + ((uwd200.risi - bwrk_si) * nvexch )
                nv_stat_pr  = nv_stat_pr  + (uwd200.ripr)
                nv_stat_sib = nv_stat_sib + ((uwd200.risi - bwrk_si) * nvexch )
                nv_stat_prb = nv_stat_prb + (uwd200.ripr)
                n_sumq      = n_sumq      + ((uwd200.risi - bwrk_si) * nvexch )
                n_prmq      = n_prmq      + (uwd200.ripr)
                p_q         = uwd200.risi_p.  
       /*มีเบี้ย ต้องจ่ายออก*/
       IF uwd200.ripr < 0  THEN  DO:
          ASSIGN pv_stat_si   = pv_stat_si  + ((uwd200.risi - bwrk_si) * nvexch )
                 pv_stat_pr   = pv_stat_pr  + (uwd200.ripr)
                 pv_stat_sib  = pv_stat_sib + ((uwd200.risi - bwrk_si) * nvexch )
                 pv_stat_prb  = pv_stat_prb + (uwd200.ripr).
        END.
        ELSE DO:
          ASSIGN iv_stat_si   = iv_stat_si  + ((uwd200.risi - bwrk_si) * nvexch )
                 iv_stat_pr   = iv_stat_pr  + (uwd200.ripr)
                 iv_stat_sib  = iv_stat_sib + ((uwd200.risi - bwrk_si) * nvexch )
                 iv_stat_prb  = iv_stat_prb + (uwd200.ripr).
         END.
      END.

      IF uwd200.rico = "0RET"  THEN DO:
         ASSIGN n_sumr      = n_sumr      + ((uwd200.risi - bwrk_si) * nvexch)
                n_prmr      = n_prmr      + (uwd200.ripr)
                p_r         = uwd200.risi_p
                nv_ret_sib  = nv_ret_sib  + ((uwd200.risi - bwrk_si) * nvexch)
                nv_ret_prb  = nv_ret_prb  + (uwd200.ripr).

        IF uwd200.ripr < 0  THEN  DO:
           ASSIGN pv_ret_sib  = pv_ret_sib + ((uwd200.risi - bwrk_si) * nvexch)
                  pv_ret_prb  = pv_ret_prb + (uwd200.ripr).
        END.
        ELSE DO:
           ASSIGN iv_ret_sib  = iv_ret_sib + ((uwd200.risi - bwrk_si) * nvexch)
                  iv_ret_prb  = iv_ret_prb + (uwd200.ripr).
        END.
      END.

      IF SUBSTRING(uwd200.rico,1,3) = "0RQ"  THEN DO:
         ASSIGN nv_0rq_si  = nv_0rq_si  + ((uwd200.risi - bwrk_si) * nvexch )
                nv_0rq_pr  = nv_0rq_pr  + (uwd200.ripr)
                nv_0rq_sib = nv_0rq_sib + ((uwd200.risi - bwrk_si) * nvexch )
                nv_0rq_prb = nv_0rq_prb + (uwd200.ripr)
                n_sumrq    = n_sumrq    + ((uwd200.risi - bwrk_si) * nvexch )
                n_prmrq    = n_prmrq    + (uwd200.ripr)
                p_rq       = uwd200.risi_p.

        IF uwd200.ripr < 0  THEN  DO:
           ASSIGN pv_0rq_si   = pv_0rq_si  + ((uwd200.risi - bwrk_si) * nvexch )
                  pv_0rq_pr   = pv_0rq_pr  + (uwd200.ripr)
                  pv_0rq_sib  = pv_0rq_sib + ((uwd200.risi - bwrk_si) * nvexch )
                  pv_0rq_prb  = pv_0rq_prb + (uwd200.ripr).
        END.
        ELSE DO:
           ASSIGN iv_0rq_si   = iv_0rq_si  + ((uwd200.risi - bwrk_si) * nvexch )
                  iv_0rq_pr   = iv_0rq_pr  + (uwd200.ripr)
                  iv_0rq_sib  = iv_0rq_sib + ((uwd200.risi - bwrk_si) * nvexch )
                  iv_0rq_prb  = iv_0rq_prb + (uwd200.ripr).
        END.
      END.

      IF SUBSTRING(uwd200.rico,1,2) = "0Q" THEN DO:
         ASSIGN nv_0q_si  = nv_0q_si  + ((uwd200.risi - bwrk_si) * nvexch )
                nv_0q_pr  = nv_0q_pr  + (uwd200.ripr)
                nv_0q_sib = nv_0q_sib + ((uwd200.risi - bwrk_si) * nvexch )
                nv_0q_prb = nv_0q_prb + (uwd200.ripr)
                n_sumtfp  = n_sumtfp  + ((uwd200.risi - bwrk_si) * nvexch )
                n_prmtfp  = n_prmtfp  + (uwd200.ripr)
                p_tfp     = uwd200.risi_p.
                  
        IF uwd200.ripr < 0  THEN  DO:
           ASSIGN pv_0q_si   = pv_0q_si  + ((uwd200.risi - bwrk_si) * nvexch )
                  pv_0q_pr   = pv_0q_pr  + (uwd200.ripr)
                  pv_0q_sib  = pv_0q_sib + ((uwd200.risi - bwrk_si) * nvexch )
                  pv_0q_prb  = pv_0q_prb + (uwd200.ripr).
        END.
        ELSE DO:
          ASSIGN iv_0q_si   = iv_0q_si  + ((uwd200.risi - bwrk_si) * nvexch )
                 iv_0q_pr   = iv_0q_pr  + (uwd200.ripr)
                 iv_0q_sib  = iv_0q_sib + ((uwd200.risi - bwrk_si) * nvexch )
                 iv_0q_prb  = iv_0q_prb + (uwd200.ripr).
        END.
      END.

      IF SUBSTRING(uwd200.rico,1,2) = "0T"  AND
         SUBSTRING(uwd200.rico,6,2) = "01"  THEN DO:
         ASSIGN nv_0t_si  = nv_0t_si  + ((uwd200.risi - bwrk_si) * nvexch )
                nv_0t_pr  = nv_0t_pr  + (uwd200.ripr)
                nv_0t_sib = nv_0t_sib + ((uwd200.risi - bwrk_si) * nvexch )
                nv_0t_prb = nv_0t_prb + (uwd200.ripr)
                n_sumt    = n_sumt    + ((uwd200.risi - bwrk_si) * nvexch )
                n_prmt    = n_prmt    + (uwd200.ripr)
                p_t       = uwd200.risi_p.
        /* สลักหลังเบี้ย เพิ่ม */
        IF uwd200.ripr < 0  THEN  DO:
           ASSIGN pv_0t_si   = pv_0t_si  + ((uwd200.risi - bwrk_si) * nvexch )
                  pv_0t_pr   = pv_0t_pr  + (uwd200.ripr)
                  pv_0t_sib  = pv_0t_sib + ((uwd200.risi - bwrk_si) * nvexch )
                  pv_0t_prb  = pv_0t_prb + (uwd200.ripr).

        END.
        ELSE DO:
           ASSIGN iv_0t_si   = iv_0t_si  + ((uwd200.risi - bwrk_si) * nvexch )
                  iv_0t_pr   = iv_0t_pr  + (uwd200.ripr)
                  iv_0t_sib  = iv_0t_sib + ((uwd200.risi - bwrk_si) * nvexch )
                  iv_0t_prb  = iv_0t_prb + (uwd200.ripr).
        END.
      END.

      IF SUBSTRING(uwd200.rico,1,2) = "0T"  AND
         SUBSTRING(uwd200.rico,6,2) = "02"  THEN DO:
         ASSIGN nv_0s_si  = nv_0s_si  + ((uwd200.risi - bwrk_si) * nvexch )
                nv_0s_pr  = nv_0s_pr  + (uwd200.ripr)
                nv_0s_sib = nv_0s_sib + ((uwd200.risi - bwrk_si) * nvexch )
                nv_0s_prb = nv_0s_prb + (uwd200.ripr)
                n_sums    = n_sums    + ((uwd200.risi - bwrk_si) * nvexch )
                n_prms    = n_prms    + (uwd200.ripr)
                p_s       = uwd200.risi_p.

        IF uwd200.ripr < 0  THEN  DO:
           ASSIGN pv_0s_si   = pv_0s_si  + ((uwd200.risi - bwrk_si) * nvexch )
                  pv_0s_pr   = pv_0s_pr  + (uwd200.ripr)
                  pv_0s_sib  = pv_0s_sib + ((uwd200.risi - bwrk_si) * nvexch )
                  pv_0s_prb  = pv_0s_prb + (uwd200.ripr).
        END.
        ELSE DO:
           ASSIGN iv_0s_si   = iv_0s_si  + ((uwd200.risi - bwrk_si) * nvexch )
                  iv_0s_pr   = iv_0s_pr  + (uwd200.ripr)
                  iv_0s_sib  = iv_0s_sib + ((uwd200.risi - bwrk_si) * nvexch )
                  iv_0s_prb  = iv_0s_prb + (uwd200.ripr).
        END.
      END.

      IF SUBSTRING(uwd200.rico,1,2) = "0T"  AND
         SUBSTRING(uwd200.rico,6,2) = "f1"  THEN DO:
         ASSIGN nv_f1_si  = nv_f1_si    + ((uwd200.risi - bwrk_si) * nvexch )
                    nv_f1_pr  = nv_f1_pr        + (uwd200.ripr)
                    nv_f1_sib = nv_f1_sib + ((uwd200.risi - bwrk_si) * nvexch )
                    nv_f1_prb = nv_f1_prb + (uwd200.ripr)
                    n_sumf1   = n_sumf1 + ((uwd200.risi - bwrk_si) * nvexch )
                    n_prmf1   = n_prmf1 + (uwd200.ripr)
                    p_f1            = uwd200.risi_p.

        IF uwd200.ripr < 0  THEN  DO:
       ASSIGN pv_f1_si   = pv_f1_si  + ((uwd200.risi - bwrk_si) * nvexch )
              pv_f1_pr   = pv_f1_pr  + (uwd200.ripr)
              pv_f1_sib  = pv_f1_sib + ((uwd200.risi - bwrk_si) * nvexch )
              pv_f1_prb  = pv_f1_prb + (uwd200.ripr).
        END.
        ELSE DO:
       ASSIGN iv_f1_si   = iv_f1_si  + ((uwd200.risi - bwrk_si) * nvexch )
              iv_f1_pr   = iv_f1_pr  + (uwd200.ripr)
              iv_f1_sib  = iv_f1_sib + ((uwd200.risi - bwrk_si) * nvexch )
              iv_f1_prb  = iv_f1_prb + (uwd200.ripr).
        END.
  END.

  IF SUBSTRING(uwd200.rico,1,2) = "0T"  AND
     SUBSTRING(uwd200.rico,6,2) = "f2"  THEN DO:
     ASSIGN nv_f2_si  = nv_f2_si        + ((uwd200.risi - bwrk_si) * nvexch )
            nv_f2_pr  = nv_f2_pr        + (uwd200.ripr)
            nv_f2_sib = nv_f2_sib + ((uwd200.risi - bwrk_si) * nvexch )
            nv_f2_prb = nv_f2_prb + (uwd200.ripr)
            n_sumf2   = n_sumf2 + ((uwd200.risi - bwrk_si) * nvexch )
            n_prmf2   = n_prmf2 + (uwd200.ripr)
            p_f2            = uwd200.risi_p.

        IF uwd200.ripr < 0  THEN  DO:
       ASSIGN pv_f2_si   = pv_f2_si  + ((uwd200.risi - bwrk_si) * nvexch )
              pv_f2_pr   = pv_f2_pr  + (uwd200.ripr)
              pv_f2_sib  = pv_f2_sib + ((uwd200.risi - bwrk_si) * nvexch )
              pv_f2_prb  = pv_f2_prb + (uwd200.ripr).
        END.
        ELSE DO:   
           ASSIGN iv_f2_si   = iv_f2_si  + ((uwd200.risi - bwrk_si) * nvexch )
              iv_f2_pr   = iv_f2_pr  + (uwd200.ripr)
              iv_f2_sib  = iv_f2_sib + ((uwd200.risi - bwrk_si) * nvexch )
              iv_f2_prb  = iv_f2_prb + (uwd200.ripr).
        END.
  END.

  IF SUBSTRING(uwd200.rico,1,3) = "0PS" THEN DO:
         ASSIGN nv_0ps_si  = nv_0ps_si  + ((uwd200.risi - bwrk_si) * nvexch )
                nv_0ps_pr  = nv_0ps_pr  + (uwd200.ripr)
                nv_0ps_sib = nv_0ps_sib + ((uwd200.risi - bwrk_si) * nvexch )
                nv_0ps_prb = nv_0ps_prb + (uwd200.ripr)
                n_sumps    = n_sumps      + ((uwd200.risi - bwrk_si) * nvexch )
                n_prmps    = n_prmps      + (uwd200.ripr)
                p_ps         = uwd200.risi_p.

        IF uwd200.ripr < 0  THEN  DO:
       ASSIGN pv_0ps_si   = pv_0ps_si  + ((uwd200.risi - bwrk_si) * nvexch )
              pv_0ps_pr   = pv_0ps_pr  + (uwd200.ripr)
              pv_0ps_sib  = pv_0ps_sib + ((uwd200.risi - bwrk_si) * nvexch )
              pv_0ps_prb  = pv_0ps_prb + (uwd200.ripr).
        END.
        ELSE DO:
       ASSIGN iv_0ps_si   = iv_0ps_si  + ((uwd200.risi - bwrk_si) * nvexch )
              iv_0ps_pr   = iv_0ps_pr  + (uwd200.ripr)
              iv_0ps_sib  = iv_0ps_sib + ((uwd200.risi - bwrk_si) * nvexch )
              iv_0ps_prb  = iv_0ps_prb + (uwd200.ripr).
        END.
  END.

  IF SUBSTRING(uwd200.rico,1,3) = "0TF" AND
     SUBSTRING(uwd200.rico,6,2) = "FB"  THEN DO:
     ASSIGN nv_btr_si  = nv_btr_si  + ((uwd200.risi - bwrk_si) * nvexch )
                nv_btr_pr  = nv_btr_pr  + (uwd200.ripr)
                nv_btr_sib = nv_btr_sib + ((uwd200.risi - bwrk_si) * nvexch )
                nv_btr_prb = nv_btr_prb + (uwd200.ripr)
                n_sumbtr   = n_sumbtr   + ((uwd200.risi - bwrk_si) * nvexch )
                n_prmbtr   = n_prmbtr   + (uwd200.ripr)
                p_btr      = uwd200.risi_p.

        IF uwd200.ripr < 0  THEN  DO:
       ASSIGN pv_btr_si = pv_btr_si  + ((uwd200.risi - bwrk_si) * nvexch )
              pv_btr_pr = pv_btr_pr  + (uwd200.ripr)
              pv_btr_sib        = pv_btr_sib + ((uwd200.risi - bwrk_si) * nvexch )
              pv_btr_prb        = pv_btr_prb + (uwd200.ripr).
        END.
        ELSE DO:
       ASSIGN iv_btr_si = iv_btr_si  + ((uwd200.risi - bwrk_si) * nvexch )
              iv_btr_pr = iv_btr_pr  + (uwd200.ripr)
              iv_btr_sib        = iv_btr_sib + ((uwd200.risi - bwrk_si) * nvexch )
              iv_btr_prb        = iv_btr_prb + (uwd200.ripr).
        END.
  END.

  IF SUBSTRING(uwd200.rico,1,3) = "0TF" AND
     SUBSTRING(uwd200.rico,6,2) = "FO"  THEN DO:
     ASSIGN nv_otr_si  = nv_otr_si  + ((uwd200.risi - bwrk_si) * nvexch )
                nv_otr_pr  = nv_otr_pr  + (uwd200.ripr)
                nv_otr_sib = nv_otr_sib + ((uwd200.risi - bwrk_si) * nvexch )
                nv_otr_prb = nv_otr_prb + (uwd200.ripr)
                n_sumotr    = n_sumotr  + ((uwd200.risi - bwrk_si) * nvexch )
                n_prmotr    = n_prmotr  + (uwd200.ripr)
                p_otr       = uwd200.risi_p.

        IF uwd200.ripr < 0  THEN  DO:
       ASSIGN pv_otr_si   = pv_otr_si  + ((uwd200.risi - bwrk_si) * nvexch )
              pv_otr_pr   = pv_otr_pr  + (uwd200.ripr)
              pv_otr_sib  = pv_otr_sib + ((uwd200.risi - bwrk_si) * nvexch )
              pv_otr_prb  = pv_otr_prb + (uwd200.ripr).
        END.
        ELSE DO:
       ASSIGN iv_otr_si   = iv_otr_si  + ((uwd200.risi - bwrk_si) * nvexch )
              iv_otr_pr   = iv_otr_pr  + (uwd200.ripr)
              iv_otr_sib  = iv_otr_sib + ((uwd200.risi - bwrk_si) * nvexch )
              iv_otr_prb  = iv_otr_prb + (uwd200.ripr).
        END.
  END.

  IF (SUBSTRING(uwd200.rico,1,4) = "0TA8" AND
          SUBSTRING(uwd200.rico,7,1) = "2")   OR
         (SUBSTRING(uwd200.rico,1,2) = "0T"   AND
          SUBSTRING(uwd200.rico,6,2) = "F3")  THEN DO:     
          ASSIGN nv_s8_si  = nv_s8_si   + ((uwd200.risi - bwrk_si) * nvexch )
                 nv_s8_pr  = nv_s8_pr   + (uwd200.ripr)
                 nv_s8_sib = nv_s8_sib + ((uwd200.risi - bwrk_si) * nvexch )
                 nv_s8_prb = nv_s8_prb + (uwd200.ripr)
             n_sums8   = n_sums8   + ((uwd200.risi - bwrk_si) * nvexch )
             n_prms8   = n_prms8   + (uwd200.ripr)
                 p_s8       = uwd200.risi_p.

        IF uwd200.ripr < 0  THEN  DO:
       ASSIGN pv_s8_si   = pv_s8_si  + ((uwd200.risi - bwrk_si) * nvexch )
              pv_s8_pr   = pv_s8_pr  + (uwd200.ripr)
              pv_s8_sib  = pv_s8_sib + ((uwd200.risi - bwrk_si) * nvexch )
              pv_s8_prb  = pv_s8_prb + (uwd200.ripr).
        END.
        ELSE DO:
           ASSIGN iv_s8_si   = iv_s8_si  + ((uwd200.risi - bwrk_si) * nvexch )
              iv_s8_pr   = iv_s8_pr  + (uwd200.ripr)
              iv_s8_sib  = iv_s8_sib + ((uwd200.risi - bwrk_si) * nvexch )
              iv_s8_prb  = iv_s8_prb + (uwd200.ripr).
        END.
  END.

  IF SUBSTRING(uwd200.rico,1,2) = "0T"  AND
     SUBSTRING(uwd200.rico,6,2) = "F4"  THEN DO:
         ASSIGN nv_f4_si  = nv_f4_si    + ((uwd200.risi - bwrk_si) * nvexch )
                nv_f4_pr  = nv_f4_pr    + (uwd200.ripr)
                nv_f4_sib = nv_f4_sib + ((uwd200.risi - bwrk_si) * nvexch )
                nv_f4_prb = nv_f4_prb + (uwd200.ripr)
                n_sumf4   = n_sumf4     + ((uwd200.risi - bwrk_si) * nvexch )
                n_prmf4   = n_prmf4     + (uwd200.ripr)
                p_f4        = uwd200.risi_p.

        IF uwd200.ripr < 0  THEN  DO:
       ASSIGN pv_f4_si   = pv_f4_si  + ((uwd200.risi - bwrk_si) * nvexch )
              pv_f4_pr   = pv_f4_pr  + (uwd200.ripr)
              pv_f4_sib  = pv_f4_sib + ((uwd200.risi - bwrk_si) * nvexch )
              pv_f4_prb  = pv_f4_prb + (uwd200.ripr).
        END.
        ELSE DO:
           ASSIGN iv_f4_si   = iv_f4_si  + ((uwd200.risi - bwrk_si) * nvexch )
              iv_f4_pr   = iv_f4_pr  + (uwd200.ripr)
              iv_f4_sib  = iv_f4_sib + ((uwd200.risi - bwrk_si) * nvexch )
              iv_f4_prb  = iv_f4_prb + (uwd200.ripr).
        END.
  END.
      
  IF SUBSTRING(uwd200.rico,1,2) = "0T"  AND
     SUBSTRING(uwd200.rico,6,2) = "FT"  THEN DO:
         ASSIGN nv_ftr_si  = nv_ftr_si  + ((uwd200.risi - bwrk_si) * nvexch )
                nv_ftr_pr  = nv_ftr_pr  + (uwd200.ripr)
                nv_ftr_sib = nv_ftr_sib + ((uwd200.risi - bwrk_si) * nvexch )
                nv_ftr_prb = nv_ftr_prb + (uwd200.ripr)
                n_sumftr   = n_sumftr   + ((uwd200.risi - bwrk_si) * nvexch )
                n_prmftr   = n_prmftr   + (uwd200.ripr)
                p_ftr      = uwd200.risi_p.

     IF uwd200.ripr < 0  THEN  DO:
            ASSIGN pv_ftr_si   = pv_ftr_si  + ((uwd200.risi - bwrk_si) * nvexch )
               pv_ftr_pr   = pv_ftr_pr  + (uwd200.ripr)
               pv_ftr_sib  = pv_ftr_sib + ((uwd200.risi - bwrk_si) * nvexch )
               pv_ftr_prb  = pv_ftr_prb + (uwd200.ripr).
     END.
         ELSE DO:
            ASSIGN iv_ftr_si   = iv_ftr_si  + ((uwd200.risi - bwrk_si) * nvexch )
               iv_ftr_pr   = iv_ftr_pr  + (uwd200.ripr)
               iv_ftr_sib  = iv_ftr_sib + ((uwd200.risi - bwrk_si) * nvexch )
               iv_ftr_prb  = iv_ftr_prb + (uwd200.ripr).
     END.
   END.

   IF SUBSTRING(uwd200.rico,1,2) = "0D" OR
      SUBSTRING(uwd200.rico,1,2) = "0F"  THEN DO:
      ASSIGN nv_0f_sib  = nv_0f_sib  + ROUND(((uwd200.risi - bwrk_si) * nvexch),2)
             nv_0f_prb  = nv_0f_prb  + ROUND((uwd200.ripr),2).

      IF uwd200.ripr < 0  THEN  DO:
         ASSIGN pv_0f_sib  = pv_0f_sib + ROUND(((uwd200.risi - bwrk_si) * nvexch),2)
                pv_0f_prb  = pv_0f_prb + ROUND((uwd200.ripr),2).
      END.
      ELSE DO:
         ASSIGN iv_0f_sib  = iv_0f_sib + ROUND(((uwd200.risi - bwrk_si) * nvexch),2)
                iv_0f_prb  = iv_0f_prb + ROUND((uwd200.ripr),2).
      END.

      FIND FIRST wrk0f WHERE wrk0f.rico = uwd200.rico NO-ERROR.
      IF AVAILABLE wrk0f THEN DO:
         ASSIGN wrk0f.sumf = wrk0f.sumf + ROUND(((uwd200.risi - bwrk_si) * nvexch),2)
                wrk0f.prmf = wrk0f.prmf + ROUND((uwd200.ripr),2).
      END.
      ELSE DO:
         CREATE   wrk0f.
         ASSIGN wrk0f.sumf   = ROUND(((uwd200.risi - bwrk_si) * nvexch),2)
                wrk0f.prmf   = ROUND((uwd200.ripr),2)
                wrk0f.pf     = uwd200.risi_p
                wrk0f.rico   = uwd200.rico
                wrk0f.cess   = uwm200.c_enno.
        END.
      END.

      FIND NEXT uwd200 USE-INDEX uwd20001     WHERE
                uwd200.policy = uwm200.policy  AND
                uwd200.rencnt = uwm200.rencnt  AND
                uwd200.endcnt = uwm200.endcnt  AND
                uwd200.c_enct = uwm200.c_enct  AND
                uwd200.csftq  = uwm200.csftq   AND
                uwd200.rico   = uwm200.rico    NO-LOCK NO-ERROR.
      IF NOT AVAIL uwd200 THEN LEAVE.

   END. /* repeat */

END. /* IF NOT AVAIL uwd200 */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_Can C-Win 
PROCEDURE proc_Can :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF uwm100.poltyp = "M60" OR uwm100.poltyp = "M61"  OR  uwm100.poltyp = "M62" OR
   uwm100.poltyp = "M63" OR uwm100.poltyp = "M64"  OR  uwm100.poltyp = "M67" OR
   uwm100.poltyp = "M68" THEN DO:
   FOR EACH uwm307 USE-INDEX uwm30701 WHERE 
            uwm307.policy = uwm100.policy AND 
            uwm307.rencnt = uwm100.rencnt AND 
            uwm307.endcnt = uwm100.endcnt NO-LOCK .

   IF AVAIL uwm307 THEN  DO:
      nv_sum  = nv_sum  + uwm307.mbsi[1].

   END.
   ELSE DO:
      DISP "ERROR UWM307 NOT AVAIL" UWM307.POLICY.
      PAUSE  5.
   END.


   END.
END.
ELSE  DO:

   FOR EACH uwm120 USE-INDEX uwm12001 WHERE 
            uwm120.policy = uwm100.policy AND 
            uwm120.rencnt = uwm100.rencnt AND 
            uwm120.endcnt = uwm100.endcnt NO-LOCK .

   IF AVAIL uwm120 THEN  DO:
      nv_sum  = nv_sum + (uwm120.sigr - uwm120.sico).
   END.

   END.

END.

nv_sum = nv_sum * -1.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_NCan C-Win 
PROCEDURE proc_NCan :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF uwm100.poltyp  =  "M60"  OR uwm100.poltyp = "M61" OR uwm100.poltyp = "M62" OR
   uwm100.poltyp  =  "M63"  OR uwm100.poltyp = "M64" OR uwm100.poltyp = "M67" OR 
   uwm100.poltyp  =  "M68"  THEN DO:
   IF  uwm100.endcnt > 000 THEN  DO:
   FOR EACH uwm307 USE-INDEX uwm30701 WHERE 
            uwm307.policy = uwm100.policy AND 
            uwm307.rencnt = uwm100.rencnt AND 
            uwm307.endcnt = uwm100.endcnt NO-LOCK.
    nv_mbsi = 0.

    FIND Buwm307 USE-INDEX uwm30701 WHERE
         Buwm307.policy = uwm307.policy AND 
         Buwm307.rencnt = uwm307.rencnt AND 
         Buwm307.riskgp = uwm307.riskgp AND 
         Buwm307.riskno = uwm307.riskno AND 
         Buwm307.itemno = uwm307.itemno AND 
         Buwm307.endcnt = uwm307.endcnt NO-LOCK NO-ERROR.

    IF AVAIL Buwm307 THEN  DO:
       nv_mbsi  =  uwm307.mbsi[1].

       FIND  PREV Buwm307  USE-INDEX  uwm30701 WHERE
                  Buwm307.policy = uwm307.policy AND 
                  Buwm307.rencnt = uwm307.rencnt NO-LOCK NO-ERROR.

       IF AVAIL Buwm307 THEN  DO:
          IF Buwm307.riskgp = uwm307.riskgp  AND 
             Buwm307.riskno = uwm307.riskno  AND 
             Buwm307.itemno = uwm307.itemno  THEN  DO:
             nv_sum  = nv_sum  + (nv_mbsi - Buwm307.mbsi[1]).
          END.
        END.
        ELSE DO:
             nv_sum  = nv_sum  + nv_mbsi.
        END.
     END.

    END.
  END.
  else do:
    FOR EACH uwm307 USE-INDEX uwm30701 WHERE 
             uwm307.policy = uwm100.policy AND 
             uwm307.rencnt = uwm100.rencnt AND 
             uwm307.endcnt = uwm100.endcnt NO-LOCK .
        nv_sum  = nv_sum  + uwm307.mbsi[1].
    END.
  END.

END.
ELSE  DO:
  FOR EACH uwm120 USE-INDEX uwm12002 WHERE 
           uwm120.policy = uwm100.policy AND 
           uwm120.rencnt = uwm100.rencnt AND 
           uwm120.endcnt = uwm100.endcnt NO-LOCK .

      FIND  Buwm120  WHERE Buwm120.policy = uwm100.policy AND 
                           Buwm120.rencnt = uwm100.rencnt AND 
                           Buwm120.riskgp = uwm120.riskgp AND 
                           Buwm120.riskno = uwm120.riskno AND 
                           Buwm120.endcnt = n_endcnt
                           NO-LOCK NO-ERROR.

      IF AVAIL Buwm120 THEN  DO:
         nv_sum  = nv_sum + ((uwm120.sigr - uwm120.sico) -
                            (Buwm120.sigr - Buwm120.sico)).
      END.
      ELSE DO:
         nv_sum  = nv_sum + (uwm120.sigr - uwm120.sico).
      END.
  END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_tty C-Win 
PROCEDURE proc_tty :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND uwm200 WHERE RECID(uwm200) = s_recid NO-LOCK NO-WAIT NO-ERROR .

FIND FIRST uwd200 USE-INDEX uwd20001     WHERE
           uwd200.policy = uwm200.policy AND
           uwd200.rencnt = uwm200.rencnt AND
           uwd200.endcnt = uwm200.endcnt AND
           uwd200.csftq  = uwm200.csftq  AND
           uwd200.rico   = uwm200.rico   AND
           uwd200.c_enct = uwm200.c_enct NO-LOCK NO-ERROR.

IF NOT AVAIL uwd200 THEN DO:
  /**** uwd200 invalid ****/
END.
ELSE DO:
     REPEAT WHILE AVAIL uwd200:

     FIND FIRST uwm120 USE-INDEX uwm12001 WHERE 
                uwm120.policy = uwd200.policy AND
                uwm120.rencnt = uwd200.rencnt AND
                uwm120.endcnt = uwd200.endcnt AND
                uwm120.riskgp = uwd200.riskgp AND
                uwm120.riskno = uwd200.riskno NO-LOCK NO-ERROR.
     IF AVAIL uwm120 THEN DO:
        IF SUBSTR(uwm120.policy,3,2) = "90"  THEN nvexch = 1.
        ELSE nvexch = uwm120.siexch.
     END.
     ELSE DO.
        DISPLAY "  uwd120 invalid ".
        PAUSE 0.
        nvexch = 1.
     END.

     IF uwd200.rico = "STAT"  THEN DO:
        ASSIGN
            nv_stat_si  = nv_stat_si  + (uwd200.risi * nvexch)
            nv_stat_pr  = nv_stat_pr  + (uwd200.ripr)
            nv_stat_sib = nv_stat_sib + (uwd200.risi * nvexch)
            nv_stat_prb = nv_stat_prb + (uwd200.ripr)
            br_stat_sib = br_stat_sib + (uwd200.risi * nvexch)
            br_stat_prb = br_stat_prb + (uwd200.ripr)
            n_sumq      = n_sumq + (uwd200.risi * nvexch)     
            n_prmq      = n_prmq + (uwd200.ripr)
            p_q         = uwd200.risi_p.
     END.

     IF uwd200.rico = "0RET"  THEN DO:
        ASSIGN
            nv_ret_sib  = nv_ret_sib + (uwd200.risi * nvexch)
            nv_ret_prb  = nv_ret_prb + (uwd200.ripr)
            br_ret_sib  = br_ret_sib + (uwd200.risi * nvexch)
            br_ret_prb  = br_ret_prb + (uwd200.ripr)
            n_sumr      = n_sumr + (uwd200.risi * nvexch)    
            n_prmr      = n_prmr + (uwd200.ripr)
            p_r         = uwd200.risi_p.
     END.

     IF SUBSTR(uwd200.rico,1,2) = "0Q"  THEN DO:
        ASSIGN
           nv_0q_si  = nv_0q_si  + (uwd200.risi * nvexch)
           nv_0q_pr  = nv_0q_pr  + (uwd200.ripr)
           nv_0q_sib = nv_0q_sib + (uwd200.risi * nvexch)
           nv_0q_prb = nv_0q_prb + (uwd200.ripr)
           br_0q_sib = br_0q_sib + (uwd200.risi * nvexch)
           br_0q_prb = br_0q_prb + (uwd200.ripr)
           n_sumtfp  = n_sumtfp  + (uwd200.risi * nvexch)
           n_prmtfp  = n_prmtfp  + (uwd200.ripr)
           p_tfp     = uwd200.risi_p.
     END.

     IF SUBSTR(uwd200.rico,1,2) = "0T"  AND
        SUBSTR(uwd200.rico,6,2) = "01"  THEN DO:
        ASSIGN
            nv_0t_si  = nv_0t_si  + (uwd200.risi * nvexch)
            nv_0t_pr  = nv_0t_pr  + (uwd200.ripr)
            nv_0t_sib = nv_0t_sib + (uwd200.risi * nvexch)
            nv_0t_prb = nv_0t_prb + (uwd200.ripr)
            br_0t_sib = br_0t_sib + (uwd200.risi * nvexch)
            br_0t_prb = br_0t_prb + (uwd200.ripr)
            n_sumt    = n_sumt   + (uwd200.risi * nvexch)
            n_prmt    = n_prmt   + (uwd200.ripr)
            p_t       = uwd200.risi_p.
     END.

     IF SUBSTR(uwd200.rico,1,2) = "0T"  AND
        SUBSTR(uwd200.rico,6,2) = "02"  THEN DO:
        ASSIGN
            nv_0s_si  = nv_0s_si  + (uwd200.risi * nvexch)
            nv_0s_pr  = nv_0s_pr  + (uwd200.ripr)
            nv_0s_sib = nv_0s_sib + (uwd200.risi * nvexch)
            nv_0s_prb = nv_0s_prb + (uwd200.ripr)
            br_0s_sib = br_0s_sib + (uwd200.risi * nvexch)
            br_0s_prb = br_0s_prb + (uwd200.ripr)
            n_sums    = n_sums    + (uwd200.risi * nvexch) 
            n_prms    = n_prms    + (uwd200.ripr)
            p_s       = uwd200.risi_p.
     END.

     IF SUBSTR(uwd200.rico,1,2) = "0T"  AND
        SUBSTR(uwd200.rico,6,2) = "F1"  THEN DO:
        ASSIGN
            nv_f1_si  = nv_f1_si  + (uwd200.risi * nvexch)
            nv_f1_pr  = nv_f1_pr  + (uwd200.ripr)
            nv_f1_sib = nv_f1_sib + (uwd200.risi * nvexch)
            nv_f1_prb = nv_f1_prb + (uwd200.ripr)
            br_f1_sib = br_f1_sib + (uwd200.risi * nvexch)
            br_f1_prb = br_f1_prb + (uwd200.ripr)
            n_sumf1   = n_sumf1   + (uwd200.risi * nvexch)
            n_prmf1   = n_prmf1   + (uwd200.ripr)
            p_f1      = uwd200.risi_p.
     END.

     IF SUBSTR(uwd200.rico,1,2) = "0T"  AND
        SUBSTR(uwd200.rico,6,2) = "F2"  THEN DO:
        ASSIGN
            nv_f2_si  = nv_f2_si + (uwd200.risi * nvexch)
            nv_f2_pr  = nv_f2_pr + (uwd200.ripr)
            nv_f2_sib = nv_f2_sib + (uwd200.risi * nvexch)
            nv_f2_prb = nv_f2_prb + (uwd200.ripr)
            br_f2_sib = br_f2_sib + (uwd200.risi * nvexch)
            br_f2_prb = br_f2_prb + (uwd200.ripr)
            n_sumf2   = n_sumf2  + (uwd200.risi * nvexch)
            n_prmf2   = n_prmf2  + (uwd200.ripr)
            p_f2      = uwd200.risi_p.
     END.

      IF SUBSTR(uwd200.rico,1,3) = "0RQ" THEN DO:
         ASSIGN
             nv_0rq_si  = nv_0rq_si  + (uwd200.risi * nvexch)
             nv_0rq_pr  = nv_0rq_pr  + (uwd200.ripr)
             nv_0rq_sib = nv_0rq_sib + (uwd200.risi * nvexch)
             nv_0rq_prb = nv_0rq_prb + (uwd200.ripr)
             br_0rq_sib = br_0rq_sib + (uwd200.risi * nvexch)
             br_0rq_prb = br_0rq_prb + (uwd200.ripr)
             n_sumrq    = n_sumrq    + (uwd200.risi * nvexch)
             n_prmrq    = n_prmrq    + (uwd200.ripr)
             p_rq       = uwd200.risi_p.
      END.
     
      IF SUBSTR(uwd200.rico,1,3) = "0PS" THEN DO:
         ASSIGN
             nv_0ps_si  = nv_0ps_si  + (uwd200.risi * nvexch)
             nv_0ps_pr  = nv_0ps_pr  + (uwd200.ripr)
             nv_0ps_sib = nv_0ps_sib + (uwd200.risi * nvexch)
             nv_0ps_prb = nv_0ps_prb + (uwd200.ripr)
             br_0ps_sib = br_0ps_sib + (uwd200.risi * nvexch)
             br_0ps_prb = br_0ps_prb + (uwd200.ripr)
             n_sumps    = n_sumps    + (uwd200.risi * nvexch)
             n_prmps    = n_prmps    + (uwd200.ripr)
             p_ps       = uwd200.risi_p.
       END.

       IF SUBSTR(uwd200.rico,1,3) = "0TF" AND
          SUBSTR(uwd200.rico,6,2) = "FB"  THEN DO:
          ASSIGN
               nv_btr_si  = nv_btr_si + (uwd200.risi * nvexch)
               nv_btr_pr  = nv_btr_pr + (uwd200.ripr)
               nv_btr_sib = nv_btr_sib + (uwd200.risi * nvexch)
               nv_btr_prb = nv_btr_prb + (uwd200.ripr)
               br_btr_sib = br_btr_sib + (uwd200.risi * nvexch)
               br_btr_prb = br_btr_prb + (uwd200.ripr)
               n_sumbtr   = n_sumbtr  + (uwd200.risi * nvexch)
               n_prmbtr   = n_prmbtr  + (uwd200.ripr)
               p_btr      = uwd200.risi_p.
       END.

       IF SUBSTR(uwd200.rico,1,3) = "0TF" AND
          SUBSTR(uwd200.rico,6,2) = "FO"  THEN DO:
          ASSIGN
               nv_otr_si  = nv_otr_si + (uwd200.risi * nvexch)
               nv_otr_pr  = nv_otr_pr + (uwd200.ripr)
               nv_otr_sib = nv_otr_sib + (uwd200.risi * nvexch)
               nv_otr_prb = nv_otr_prb + (uwd200.ripr)
               br_otr_sib = br_otr_sib + (uwd200.risi * nvexch)
               br_otr_prb = br_otr_prb + (uwd200.ripr)
               n_sumotr   = n_sumotr  + (uwd200.risi * nvexch)
               n_prmotr   = n_prmotr  + (uwd200.ripr)
               p_otr      = uwd200.risi_p.
       END.

       IF (SUBSTR(uwd200.rico,1,4) = "0TA8" AND SUBSTR(uwd200.rico,7,1) = "2")  
          OR (SUBSTR(uwd200.rico,1,2) = "0T" AND SUBSTR(uwd200.rico,6,2) = "F3")    /* A44-0012  -> เพิ่ม F3 (Munich Re.) */
          THEN DO:
          ASSIGN
                    nv_s8_si  = nv_s8_si  + (uwd200.risi * nvexch)
                    nv_s8_pr  = nv_s8_pr  + (uwd200.ripr)
                nv_s8_sib = nv_s8_sib + (uwd200.risi * nvexch)
                nv_s8_prb = nv_s8_prb + (uwd200.ripr)
                    br_s8_sib = br_s8_sib + (uwd200.risi * nvexch)
                    br_s8_prb = br_s8_prb + (uwd200.ripr)
                    n_sums8       = n_sums8   + (uwd200.risi * nvexch)
                    n_prms8       = n_prms8   + (uwd200.ripr)
                p_s8      = uwd200.risi_p.
       END.

       IF SUBSTR(uwd200.rico,1,2) = "0T"  AND
          SUBSTR(uwd200.rico,6,2) = "F4"  THEN DO:
          ASSIGN
               nv_f4_si   = nv_f4_si + (uwd200.risi * nvexch)
               nv_f4_pr   = nv_f4_pr + (uwd200.ripr)
               nv_f4_sib  = nv_f4_sib + (uwd200.risi * nvexch)
               nv_f4_prb  = nv_f4_prb + (uwd200.ripr)
               br_f4_sib  = br_f4_sib + (uwd200.risi * nvexch)
               br_f4_prb  = br_f4_prb + (uwd200.ripr)
               n_sumf4    = n_sumf4  + (uwd200.risi * nvexch)
               n_prmf4    = n_prmf4  + (uwd200.ripr)
               p_f4       = uwd200.risi_p.
       END.

       IF SUBSTR(uwd200.rico,1,2) = "0T"  AND
          SUBSTR(uwd200.rico,6,2) = "FT"  THEN DO:
          ASSIGN
               nv_ftr_si  = nv_ftr_si  + (uwd200.risi * nvexch)
               nv_ftr_pr  = nv_ftr_pr  + (uwd200.ripr)
               nv_ftr_sib = nv_ftr_sib + (uwd200.risi * nvexch)
               nv_ftr_prb = nv_ftr_prb + (uwd200.ripr)
               br_ftr_sib = br_ftr_sib + (uwd200.risi * nvexch)
               br_ftr_prb = br_ftr_prb + (uwd200.ripr)
               n_sumftr   = n_sumftr   + (uwd200.risi * nvexch)
               n_prmftr   = n_prmftr   + (uwd200.ripr)
               p_ftr      = uwd200.risi_p.
       END.

       IF SUBSTR(uwd200.rico,1,2) = "0D" OR
          SUBSTR(uwd200.rico,1,2) = "0F" THEN DO:
          ASSIGN
               nv_0f_sib = nv_0f_sib + ROUND((uwd200.risi * nvexch),2)
               nv_0f_prb = nv_0f_prb + ROUND((uwd200.ripr),2)
               br_0f_sib = br_0f_sib + ROUND((uwd200.risi * nvexch),2)
               br_0f_prb = br_0f_prb + ROUND((uwd200.ripr),2).
               
          FIND FIRST wrk0f WHERE wrk0f.rico = uwd200.rico NO-ERROR.
          IF AVAILABLE wrk0f THEN DO:
             ASSIGN wrk0f.sumf = wrk0f.sumf + ROUND(uwd200.risi * nvexch,2)
                    wrk0f.prmf = wrk0f.prmf + ROUND(uwd200.ripr,2) .
         END.
         ELSE DO:
            CREATE  wrk0f.
            ASSIGN  wrk0f.sumf   = ROUND(uwd200.risi * nvexch,2)
                    wrk0f.prmf   = ROUND(uwd200.ripr,2)
                    wrk0f.pf     = uwd200.risi_p
                    wrk0f.rico   = uwd200.rico
                    wrk0f.cess   = uwm200.c_no.
         END.
       END.

       FIND NEXT uwd200 USE-INDEX uwd20001 WHERE
                         uwd200.policy = uwm200.policy  AND
                         uwd200.rencnt = uwm200.rencnt  AND
                         uwd200.endcnt = uwm200.endcnt  AND
                         uwd200.csftq  = uwm200.csftq   AND
                         uwd200.rico   = uwm200.rico    AND
                         uwd200.c_enct = uwm200.c_enct  NO-LOCK NO-ERROR.      

     END. /* repeat */

   END.
   
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

