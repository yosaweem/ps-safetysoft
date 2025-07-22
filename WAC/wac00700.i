/*---jeab
def {1} SHARED VAR  fr_trndat   as date format "99/99/9999" LABEL "TRAN DATE FROM ".
def {1} SHARED VAR  to_trndat   as date format "99/99/9999" LABEL "TRAN DATE TO ".
def {1} SHARED VAR  nv_output   as char format "x(10)" LABEL "OUTPUT ".
---*/

def var nt_sigr      like  uwm100.sigr_p.
def var nt_prem      like  uwm100.prem_t.

def var nt_stat_pr   like  uwd200.ripr.
def var nt_ret_pr    like  uwd200.ripr.
def var nt_0q_pr     like  uwd200.ripr.
def var nt_0t_pr     like  uwd200.ripr.
def var nt_0s_pr     like  uwd200.ripr.
def var nt_f1_pr     like  uwd200.ripr.
def var nt_f2_pr     like  uwd200.ripr.
def var nt_f3_pr     like  uwd200.ripr.
def var nt_f4_pr     like  uwd200.ripr.
def var nt_0rq_pr    like  uwd200.ripr.
def var nt_0ps_pr    like  uwd200.ripr.
def var nt_btr_pr    like  uwd200.ripr.
def var nt_otr_pr    like  uwd200.ripr.
def var nt_ftr_pr    like  uwd200.ripr.
def var nt_s8_pr     like  uwd200.ripr.
def var nt_other_pr  like  uwd200.ripr.

/*---------------- End. Prem ----------------*/

def var nt_stat_per   like  uwm200.rip1.
def var nt_ret_per    like  uwm200.rip1.
def var nt_0q_per     like  uwm200.rip1.
def var nt_0t_per     like  uwm200.rip1.
def var nt_0s_per     like  uwm200.rip1.
def var nt_f1_per     like  uwm200.rip1.
def var nt_f2_per     like  uwm200.rip1.
def var nt_f3_per     like  uwm200.rip1.
def var nt_f4_per     like  uwm200.rip1.
def var nt_0rq_per    like  uwm200.rip1.
def var nt_0ps_per    like  uwm200.rip1.
def var nt_btr_per    like  uwm200.rip1.
def var nt_otr_per    like  uwm200.rip1.
def var nt_ftr_per    like  uwm200.rip1.  
def var nt_s8_per     like  uwm200.rip1.
def var nt_other_per  like  uwm200.rip1.
/*---------------- End. % Comm.----------------*/

def var nt_com      like  uwm100.coty_t.

def var nt_stat_co   like  uwd200.ric1 FORMAT ">>,>>>,>>>,>>9.99-".
def var nt_ret_co    like  uwd200.ric1 FORMAT ">>,>>>,>>>,>>9.99-".
def var nt_0q_co     like  uwd200.ric1 FORMAT ">>,>>>,>>>,>>9.99-".
def var nt_0t_co     like  uwd200.ric1 FORMAT ">>,>>>,>>>,>>9.99-".
def var nt_0s_co     like  uwd200.ric1 FORMAT ">>,>>>,>>>,>>9.99-".
def var nt_f1_co     like  uwd200.ric1 FORMAT ">>,>>>,>>>,>>9.99-".
def var nt_f2_co     like  uwd200.ric1 FORMAT ">>,>>>,>>>,>>9.99-".
def var nt_f3_co     like  uwd200.ric1 FORMAT ">>,>>>,>>>,>>9.99-".
def var nt_f4_co     like  uwd200.ric1 FORMAT ">>,>>>,>>>,>>9.99-". /* A450055*/
def var nt_0rq_co    like  uwd200.ric1 FORMAT ">>,>>>,>>>,>>9.99-".
def var nt_0ps_co    like  uwd200.ric1 FORMAT ">>,>>>,>>>,>>9.99-".
def var nt_btr_co    like  uwd200.ric1 FORMAT ">>,>>>,>>>,>>9.99-".
def var nt_otr_co    like  uwd200.ric1 FORMAT ">>,>>>,>>>,>>9.99-".
def var nt_ftr_co    like  uwd200.ric1 FORMAT ">>,>>>,>>>,>>9.99-".  /* A450055*/
def var nt_s8_co     like  uwd200.ric1 FORMAT ">>,>>>,>>>,>>9.99-".
def var nt_other_co  like  uwd200.ric1 FORMAT ">>,>>>,>>>,>>9.99-".
/*------------------End. Comm.----------------*/
def var np_line      as char format "x(30)".


def var nv_brn_line as char format "x(4)" COLUMN-LABEL "  LINE  ".


DEF {1} SHARED var n_gldat       as     DATE  FORMAT   "99/99/9999" LABEL "GL_DATE ".


/*DEF NEW SHARED VAR n_poltyp      AS     CHAR  FORMAT   "X(2)".*/
DEF NEW SHARED VAR n_branch      LIKE   uwm100.branch.
DEF NEW SHARED VAR poltype       LIKE   uwm100.poltyp.

DEF VAR n_m1        AS CHAR FORMAT "X(1)".
DEF VAR n_m2        AS CHAR FORMAT "X(2)".
DEF VAR n_m3        AS CHAR FORMAT "X(2)".
DEF VAR n_m41       AS CHAR FORMAT "X(2)".
DEF VAR n_m42       AS CHAR FORMAT "X(2)".
DEF VAR n_Crfg      AS CHAR FORMAT "X(7)".
DEF VAR n_prgrp     AS INTEGER   FORMAT "9".

DEF NEW SHARED VAR n_macc  AS CHAR      FORMAT "X(8)".
DEF NEW SHARED VAR n_sacc1 AS CHAR      FORMAT "X(6)".
DEF NEW SHARED VAR n_sacc2 AS CHAR      FORMAT "X(6)".

DEF VAR typfir  AS CHAR INIT "10".
DEF VAR typris  AS CHAR INIT "11,12,13".
DEF VAR typass  AS CHAR INIT "14,15,16,17,18,19".
DEF VAR typpro  AS CHAR INIT "20,32,33,34,35,36,39".
DEF VAR typmis  AS CHAR INIT "01,02,03,04,05,06,07,08,09,21,22,23,24,30,37,38,50,51,52,53,54,55,56,57,58,59".
DEF VAR typlia  AS CHAR INIT "40,41,43".
DEF VAR typeng  AS CHAR INIT "80,81,82,83,84,85".
DEF VAR typhea  AS CHAR INIT "65,66".
DEF VAR typpa   AS CHAR INIT "60,61,62,63,64,67".
DEF VAR typmar  AS CHAR INIT "31,90,92,93,94,95,96,97,98,99".
DEF VAR typhul  AS CHAR INIT "91".



