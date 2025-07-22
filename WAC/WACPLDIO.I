/* WACANN.I     ....   						                            */                          
/* Copyright	: Safety Insurance Public Company Limited 				*/  
/*			      ºÃÔÉÑ· »ÃĞ¡Ñ¹¤ØéÁÀÑÂ ¨Ó¡Ñ´ (ÁËÒª¹)					*/  
/* CREATE BY	: Suthida T.   ASSIGN A530326  DATE 22/10/2010			*/  

DEF VAR nv_policy   AS CHAR  FORMAT "X(20)".
DEF VAR nv_rencnt   AS INT   FORMAT ">9" .                 
DEF VAR nv_endcnt   AS INT   FORMAT "999".

DEF VAR nt_stat_pr  LIKE uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nt_stat_per LIKE uwm200.rip1.
DEF VAR mstat_c     AS DEC. 
DEF VAR nv_stat     LIKE uwd200.ripr.
DEF VAR nv_pstat    LIKE uwm200.rip1. 
DEF VAR nv_cstat    LIKE uwd200.ric1.
DEF VAR mstat_pr    AS DEC. 


DEF VAR nv_si0d     LIKE uwd200.risi. 
DEF VAR nv_si0a     LIKE uwd200.risi. 
DEF VAR nv_si0f     LIKE uwd200.risi. 
DEF VAR nv_siret    LIKE uwd200.risi. 
DEF VAR nv_sistat   LIKE uwd200.risi.
DEF VAR nv_si0q     LIKE uwd200.risi.
DEF VAR nv_si0t     LIKE uwd200.risi.
DEF VAR nv_si0s     LIKE uwd200.risi.
DEF VAR nv_sif1     LIKE uwd200.risi.
DEF VAR nv_sif2     LIKE uwd200.risi.
DEF VAR nv_sif3     LIKE uwd200.risi.
DEF VAR nv_sif4     LIKE uwd200.risi.
DEF VAR nv_si0rq    LIKE uwd200.risi.
DEF VAR nv_si0ps    LIKE uwd200.risi.
DEF VAR nv_sibtr    LIKE uwd200.risi.
DEF VAR nv_siotr    LIKE uwd200.risi.
DEF VAR nv_sis8     LIKE uwd200.risi.
DEF VAR nv_siftr    LIKE uwd200.risi.

DEF VAR nt_var_per1 LIKE uwd200.risi. 
DEF VAR nv_ppstat   LIKE uwd200.risi_p. 
DEF VAR nv_pret     LIKE uwm200.rip1.
DEF VAR nv_0t_pr    LIKE uwd200.risi_p. 
DEF VAR nv_0S_pr    LIKE uwd200.risi_p. 
DEF VAR nv_0RQ      LIKE uwd200.risi_p. 
DEF VAR nv_0q_pr    LIKE uwd200.risi_p. 
DEF VAR nv_f1_pr    LIKE uwd200.risi_p. 
DEF VAR nv_f2_pr    LIKE uwd200.risi_p. 
DEF VAR nv_f3_pr    LIKE uwd200.risi_p. 
DEF VAR nv_f4_pr    LIKE uwd200.risi_p. 
DEF VAR nv_0ps      LIKE uwd200.risi_p.
DEF VAR nv_btr      LIKE uwd200.risi_p.
DEF VAR nv_otr      LIKE uwd200.risi_p.
DEF VAR nv_s8       LIKE uwd200.risi_p.
DEF VAR nv_ftr      LIKE uwd200.risi_p.
DEF VAR nv_p0a      LIKE uwd200.risi_p.
DEF VAR nv_p0d      LIKE uwd200.risi_p.
DEF VAR nv_p0f      LIKE uwd200.risi_p.

DEF BUFFER buwd200  FOR uwd200.


DEF VAR nt_ret_per  LIKE uwm200.rip1.
DEF VAR nt_0t_per   LIKE uwm200.rip1.
DEF VAR nt_0s_per   LIKE uwm200.rip1.
DEF VAR nt_0rq_per  LIKE uwm200.rip1.
DEF VAR nt_0q_per   LIKE uwm200.rip1.
DEF VAR nt_f1_per   LIKE uwm200.rip1.
DEF VAR nt_f2_per   LIKE uwm200.rip1.
DEF VAR nt_f3_per   LIKE uwm200.rip1.
DEF VAR nt_f4_per   LIKE uwm200.rip1.
DEF VAR nt_0ps_per  LIKE uwm200.rip1. 
DEF VAR nt_btr_per  LIKE uwm200.rip1. 
DEF VAR nt_otr_per  LIKE uwm200.rip1. 
DEF VAR nt_s8_per   LIKE uwm200.rip1. 
DEF VAR nt_ftr_per  LIKE uwm200.rip1. 
DEF VAR nt_0a_per   LIKE uwm200.rip1. 
DEF VAR nt_0d_per   LIKE uwm200.rip1. 
DEF VAR nt_0f_per   LIKE uwm200.rip1. 

DEF VAR m0t_c   AS DEC.
DEF VAR m0s_c   AS DEC.
DEF VAR m0rq_c  AS DEC.
DEF VAR mret_c  AS DEC.
DEF VAR m0q_c   AS DEC.
DEF VAR mf1_c   AS DEC.
DEF VAR mf2_c   AS DEC.
DEF VAR mf3_c   AS DEC.
DEF VAR mf4_c   AS DEC.
DEF VAR m0ps_c  AS DEC.
DEF VAR mbtr_c  AS DEC.
DEF VAR motr_c  AS DEC.
DEF VAR ms8_c   AS DEC.
DEF VAR mftr_c  AS DEC.
DEF VAR m0A_c   AS DEC.
DEF VAR m0D_c   AS DEC.
DEF VAR m0F_c   AS DEC.

DEF VAR nt_ret_pr  LIKE uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nt_0t_pr   LIKE uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nt_0s_pr   LIKE uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nt_0rq_pr  LIKE uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nt_0q_pr   LIKE uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nt_f1_pr   LIKE uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nt_f2_pr   LIKE uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nt_f3_pr   LIKE uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nt_f4_pr   LIKE uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nt_0ps_pr  LIKE uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99". 
DEF VAR nt_btr_pr  LIKE uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99". 
DEF VAR nt_otr_pr  LIKE uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99". 
DEF VAR nt_s8_pr   LIKE uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99". 
DEF VAR nt_ftr_pr  LIKE uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99". 
DEF VAR nt_0A_pr   LIKE uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99". 
DEF VAR nt_0D_pr   LIKE uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99". 
DEF VAR nt_0F_pr   LIKE uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99". 

DEF VAR nsd_ret     LIKE uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99".  
DEF VAR nsd_0t      LIKE uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nsd_0s      LIKE uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nsd_stat    LIKE uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nsd_0rq     LIKE uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nsd_f1      LIKE uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nsd_f2      LIKE uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nsd_0ps     LIKE uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nsd_btr     LIKE uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nsd_otr     LIKE uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nsd_f3      LIKE uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nsd_f4      LIKE uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nsd_ftr     LIKE uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nsd_0q      LIKE uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nsd_s8      LIKE uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nsd_0D      LIKE uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nsd_0A      LIKE uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nsd_0F      LIKE uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nsd_recom   LIKE uwd200.ric1 FORMAT "->>,>>>,>>>,>>9.99". 
DEF VAR nsd_0tcom   LIKE uwd200.ric1 FORMAT "->>,>>>,>>>,>>9.99". 
DEF VAR nsd_0scom   LIKE uwd200.ric1 FORMAT "->>,>>>,>>>,>>9.99". 
DEF VAR nsd_statcom LIKE uwd200.ric1 FORMAT "->>,>>>,>>>,>>9.99". 
DEF VAR nsd_0rqcom  LIKE uwd200.ric1 FORMAT "->>,>>>,>>>,>>9.99". 
DEF VAR nsd_f1com   LIKE uwd200.ric1 FORMAT "->>,>>>,>>>,>>9.99". 
DEF VAR nsd_f2com   LIKE uwd200.ric1 FORMAT "->>,>>>,>>>,>>9.99". 
DEF VAR nsd_0pscom  LIKE uwd200.ric1 FORMAT "->>,>>>,>>>,>>9.99". 
DEF VAR nsd_btrcom  LIKE uwd200.ric1 FORMAT "->>,>>>,>>>,>>9.99". 
DEF VAR nsd_otrcom  LIKE uwd200.ric1 FORMAT "->>,>>>,>>>,>>9.99". 
DEF VAR nsd_f3com   LIKE uwd200.ric1 FORMAT "->>,>>>,>>>,>>9.99". 
DEF VAR nsd_f4com   LIKE uwd200.ric1 FORMAT "->>,>>>,>>>,>>9.99". 
DEF VAR nsd_ftrcom  LIKE uwd200.ric1 FORMAT "->>,>>>,>>>,>>9.99". 
DEF VAR nsd_0qcom   LIKE uwd200.ric1 FORMAT "->>,>>>,>>>,>>9.99". 
DEF VAR nsd_s8com   LIKE uwd200.ric1 FORMAT "->>,>>>,>>>,>>9.99". 
DEF VAR nsd_0dcom   LIKE uwd200.ric1 FORMAT "->>,>>>,>>>,>>9.99". 
DEF VAR nsd_0acom   LIKE uwd200.ric1 FORMAT "->>,>>>,>>>,>>9.99". 
DEF VAR nsd_0fcom   LIKE uwd200.ric1 FORMAT "->>,>>>,>>>,>>9.99". 

DEF VAR nsd_sumper   LIKE uwd200.ric1 FORMAT "->>,>>>,>>>,>>9.99". 
DEF VAR nsd_sumprm   LIKE uwd200.ric1 FORMAT "->>,>>>,>>>,>>9.99". 

DEF VAR np_sumretc  AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR np_0tc      AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR np_0sc      AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR np_statc    AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR np_0rqc     AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR np_f1c      AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR np_f2c      AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR np_0psc     AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR np_btrc     AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR np_otrc     AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR np_f3c      AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR np_f4c      AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR np_ftrc     AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR np_0qc      AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR np_s8c      AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR np_0Dc      AS DEC FORMAT "->>>,>>>,>>>,>>9.99". 
DEF VAR np_0Ac      AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR np_0Fc      AS DEC FORMAT "->>>,>>>,>>>,>>9.99".

DEF VAR np_retp   AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR np_0tp    AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR np_0sp    AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR np_statp  AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR np_0rqp   AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR np_f1p    AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR np_f2p    AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR np_0psp   AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR np_btrp   AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR np_otrp   AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR np_f3p    AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR np_f4p    AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR np_ftrp   AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR np_0qp    AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR np_s8p    AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR np_0Dp    AS DEC FORMAT "->>>,>>>,>>>,>>9.99". 
DEF VAR np_0Ap    AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR np_0Fp    AS DEC FORMAT "->>>,>>>,>>>,>>9.99".

DEF VAR ns_sumretc  AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR ns_0tc      AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR ns_0sc      AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR ns_statc    AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR ns_0rqc     AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR ns_f1c      AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR ns_f2c      AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR ns_0psc     AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR ns_btrc     AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR ns_otrc     AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR ns_f3c      AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR ns_f4c      AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR ns_ftrc     AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR ns_0qc      AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR ns_s8c      AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR ns_0Dc      AS DEC FORMAT "->>>,>>>,>>>,>>9.99". 
DEF VAR ns_0Ac      AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR ns_0Fc      AS DEC FORMAT "->>>,>>>,>>>,>>9.99".

DEF VAR ns_retp   AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR ns_0tp    AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR ns_0sp    AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR ns_statp  AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR ns_0rqp   AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR ns_f1p    AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR ns_f2p    AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR ns_0psp   AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR ns_btrp   AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR ns_otrp   AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR ns_f3p    AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR ns_f4p    AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR ns_ftrp   AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR ns_0qp    AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR ns_s8p    AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR ns_0Dp    AS DEC FORMAT "->>>,>>>,>>>,>>9.99". 
DEF VAR ns_0Ap    AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR ns_0Fp    AS DEC FORMAT "->>>,>>>,>>>,>>9.99".

DEF VAR nb_sumretc  AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR nb_0tc      AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR nb_0sc      AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR nb_statc    AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR nb_0rqc     AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR nb_f1c      AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR nb_f2c      AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR nb_0psc     AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR nb_btrc     AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR nb_otrc     AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR nb_f3c      AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR nb_f4c      AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR nb_ftrc     AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR nb_0qc      AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR nb_s8c      AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR nb_0Dc      AS DEC FORMAT "->>>,>>>,>>>,>>9.99". 
DEF VAR nb_0Ac      AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR nb_0Fc      AS DEC FORMAT "->>>,>>>,>>>,>>9.99".

DEF VAR nb_retp   AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR nb_0tp    AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR nb_0sp    AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR nb_statp  AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR nb_0rqp   AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR nb_f1p    AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR nb_f2p    AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR nb_0psp   AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR nb_btrp   AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR nb_otrp   AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR nb_f3p    AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR nb_f4p    AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR nb_ftrp   AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR nb_0qp    AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR nb_s8p    AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR nb_0Dp    AS DEC FORMAT "->>>,>>>,>>>,>>9.99". 
DEF VAR nb_0Ap    AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR nb_0Fp    AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF WORKFILE wacm001
    FIELD policy  AS CHAR FORMAT "X(20)"
    FIELD rencnt  AS INTE FORMAT ">9"
    FIELD endcnt  AS INTE FORMAT "999"
    FIELD endno   AS CHAR FORMAT "X(9)"
    FIELD poltyp  AS CHAR FORMAT "X(3)"
    FIELD bran    AS CHAR FORMAT "x(2)"
    FIELD comdat  AS DATE FORMAT "99/99/9999"
    FIELD trndat  AS DATE FORMAT "99/99/9999"
    FIELD prem    AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD comp    AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD prepa   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD totpre  AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD stamp   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD stamc   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD stampa  AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD totstm  AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD vatp    AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD vatc    AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD vatpa   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD totvat  AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD totpvat AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD scb     AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD totpscb AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD comm    AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD co_comp AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD compa   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD totcom  AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD ridis   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD totdis  AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD prnvat  AS CHAR FORMAT "X(1)".

DEF WORKFILE wuwm200
    FIELD policy  AS CHAR FORMAT "X(20)"
    FIELD rencnt  AS INTE FORMAT ">9"
    FIELD endcnt  AS INTE FORMAT "999"
    FIELD pepret  AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD prmret  AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD pecret  AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD comret  AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD pep0t   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD prm0t   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD pec0t   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD com0t   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD pep0s   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD prm0s   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD pec0s   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD com0s   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD pepstat AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD prmstat AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD pecstat AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD comstat AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD pep0rq  AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD prm0rq  AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD pec0rq  AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD com0rq  AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD pepf1   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD prmf1   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD pecf1   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD comf1   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD pepf2   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD prmf2   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD pecf2   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD comf2   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD pep0ps  AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD prm0ps  AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD pec0ps  AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD com0ps  AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD pepbtr  AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD prmbtr  AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD pecbtr  AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD combtr  AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD pepotr  AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD prmotr  AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD pecotr  AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD comotr  AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD pepf3   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD prmf3   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD pecf3   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD comf3   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD pepf4   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD prmf4   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD pecf4   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD comf4   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD pepftr  AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD prmftr  AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD pecftr  AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD comftr  AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD pep0q   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD prm0q   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD pec0q   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD com0q   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD peps8   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD prms8   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD pecs8   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD coms8   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD pep0d   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD prm0d   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD pec0d   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD com0d   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD pep0f   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD prm0f   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD pec0f   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD com0f   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD pep0a   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD prm0a   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD pec0a   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD com0a   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD sumper  AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD sumprm  AS DECI FORMAT "->>,>>>,>>>,>>9.99".














/* ann */
