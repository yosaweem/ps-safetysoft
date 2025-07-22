&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME cC-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS cC-Win 
/*------------------------------------------------------------------------

  File: 

  Description: 

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author: 

  Created: Benjaporn J. [A59-0476] date 03/10/2016  
           Nattanicha K.  17/02/2021 แก้ไขต่อเนื่อง เนื่องจาก พนง.ลาออก

------------------------------------------------------------------------*/
/*          This .W file was created with the Progress AppBuilder.      */
/*----------------------------------------------------------------------*/

/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */

CREATE WIDGET-POOL.

/* ***************************  Definitions  ************************** */
/* Parameters Definitions ---                                           */
/* Local Variable Definitions ---                                       */
{wac/wacr0010n0.i} 
{wac/wacr0010n1.i}  
{wac/wacrfacre.i}
/*{wac/wacr00100.i}*/

DEF VAR n_User   AS CHAR.
DEF VAR n_Passwd AS CHAR.
DEF VAR nv_User  AS CHAR NO-UNDO. 
DEF VAR nv_pwd   LIKE _password NO-UNDO.
DEF VAR vFirstTime AS CHAR INIT "".
DEF VAR vLastTime  AS CHAR INIT "".

DEF VAR n_br1    AS  CHAR   FORMAT "XX".
DEF VAR n_br2    AS  CHAR   FORMAT "XX".
DEF VAR n_mr1    AS  CHAR   FORMAT "XX".
DEF VAR n_mr2    AS  CHAR   FORMAT "XX".
DEF VAR n_fr_pol AS  CHAR   FORMAT "X".
DEF VAR n_riname AS  CHAR   FORMAT "X(40)".

DEF NEW SHARED VAR br_totsib    LIKE   nv_totsib.
DEF NEW SHARED VAR br_totpremb  LIKE   nv_totpremb.
DEF NEW SHARED VAR br_f1_sib    LIKE   nv_f1_sib.
DEF NEW SHARED VAR br_f1_prb    LIKE   nv_f1_prb.
DEF NEW SHARED VAR br_f2_sib    LIKE   nv_f2_sib.
DEF NEW SHARED VAR br_f2_prb    LIKE   nv_f2_prb.
DEF NEW SHARED VAR br_0t_sib    LIKE   nv_0t_sib.
DEF NEW SHARED VAR br_0t_prb    LIKE   nv_0t_prb.
DEF NEW SHARED VAR br_0s_sib    LIKE   nv_0s_sib.
DEF NEW SHARED VAR br_0s_prb    LIKE   nv_0s_prb.
DEF NEW SHARED VAR br_stat_sib  LIKE   nv_stat_sib.
DEF NEW SHARED VAR br_stat_prb  LIKE   nv_stat_prb.
DEF NEW SHARED VAR br_0q_sib    LIKE   nv_0q_sib.
DEF NEW SHARED VAR br_0q_prb    LIKE   nv_0q_prb.
DEF NEW SHARED VAR br_0rq_sib   LIKE   nv_0rq_sib.
DEF NEW SHARED VAR br_0rq_prb   LIKE   nv_0rq_prb.
DEF NEW SHARED VAR br_ret_sib   LIKE   nv_ret_sib.
DEF NEW SHARED VAR br_ret_prb   LIKE   nv_ret_prb.
DEF NEW SHARED VAR br_0f_sib    LIKE   nv_0f_sib.
DEF NEW SHARED VAR br_0f_prb    LIKE   nv_0f_prb.
DEF NEW SHARED VAR br_0ps_sib   LIKE   nv_0ps_sib.
DEF NEW SHARED VAR br_0ps_prb   LIKE   nv_0ps_prb.
DEF NEW SHARED VAR br_btr_sib   LIKE   nv_0ps_sib.
DEF NEW SHARED VAR br_btr_prb   LIKE   nv_0ps_prb.
DEF NEW SHARED VAR br_otr_sib   LIKE   nv_0ps_sib.
DEF NEW SHARED VAR br_otr_prb   LIKE   nv_0ps_prb.
DEF NEW SHARED VAR br_f4_sib    LIKE   nv_f4_sib.
DEF NEW SHARED VAR br_f4_prb    LIKE   nv_f4_prb.
DEF NEW SHARED VAR br_ftr_sib   LIKE   nv_ftr_sib.
DEF NEW SHARED VAR br_ftr_prb   LIKE   nv_ftr_prb.

DEFINE NEW SHARED VAR p_s8        AS DECI FORMAT "->>9.99"        INIT 0.
DEFINE NEW SHARED VAR n_sums8     AS DECI FORMAT "->>>>>>>>>9.99" INIT 0.
DEFINE NEW SHARED VAR n_prms8     AS DECI FORMAT "->>>>>>>>>9.99" INIT 0.
DEFINE NEW SHARED VAR nv_s8_si    AS DECI FORMAT "->>>>>>>>>9.99" INIT 0.
DEFINE NEW SHARED VAR nv_s8_pr    AS DECI FORMAT "->>>>>>>>>9.99" INIT 0.
DEFINE NEW SHARED VAR nv_s8_cm    AS DECI FORMAT "->>>>>>>>>9.99" INIT 0.
DEFINE NEW SHARED VAR nv_s8_sib   AS DECI FORMAT "->>>>>>>>>9.99" INIT 0.
DEFINE NEW SHARED VAR nv_s8_prb   AS DECI FORMAT "->>>>>>>>>9.99" INIT 0.
DEFINE NEW SHARED VAR br_s8_sib   AS DECI FORMAT "->>>>>>>>>9.99" INIT 0.
DEFINE NEW SHARED VAR br_s8_prb   AS DECI FORMAT "->>>>>>>>>9.99" INIT 0.

DEFINE NEW SHARED VAR n_s8_sib    AS DECI FORMAT "->>>>>>>>>9.99" EXTENT 3 INIT 0.
DEFINE NEW SHARED VAR n_s8_prb    AS DECI FORMAT "->>>>>>>>>9.99" EXTENT 3 INIT 0.

DEF NEW SHARED WORKFILE wrk0f
    FIELD  rico  AS CHAR FORMAT "X(7)"
    FIELD  cess  AS INTE FORMAT "9999999"
    FIELD  pf    AS DECI FORMAT "->>9.99"
    FIELD  sumf  AS DECI FORMAT ">>,>>>,>>9.99-"
    FIELD  prmf  AS DECI FORMAT ">,>>>,>>9.99-".

DEFINE VAR nv_frm_policy AS CHAR FORMAT "X(16)".
DEFINE VAR nv_to_policy  AS CHAR FORMAT "X(16)".

DEFINE VAR NAME_1    AS  CHAR  FORMAT "X(70)". 
DEFINE VAR nv_gstrat AS  CHAR  FORMAT "X(20)".   
DEFINE VAR n_vatf1   AS  DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-".   
DEFINE VAR n_vatf2   AS  DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-".  
DEFINE VAR n_vatt    AS  DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-".   
DEFINE VAR n_vatq    AS  DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-". 
DEFINE VAR n_vatr    AS  DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-".   
DEFINE VAR nv_prmf1  AS  DECI  FORMAT ">>>>>>>>>9.99-" INIT 0.
DEFINE VAR nv_prmf2  AS  DECI  FORMAT ">>>>>>>>>9.99-" INIT 0.
DEFINE VAR nv_prmt   AS  DECI  FORMAT ">>>>>>>>>9.99-" INIT 0.
DEFINE VAR nv_prmq   AS  DECI  FORMAT ">>>>>>>>>9.99-" INIT 0.
DEFINE VAR nv_prmr   AS  DECI  FORMAT ">>>>>>>>>9.99-" INIT 0.

DEF VAR nv_comdat  AS DATE FORMAT "99/99/99".
DEF BUFFER buwm100 FOR uwm100.

DEF VAR  nv_brdes  AS CHAR FORMAT "X(2)".
DEF VAR  nv_brdes1 AS CHAR FORMAT "X(2)".
DEF VAR  n_bran1   AS CHAR FORMAT "X(2)".
DEF VAR  nv_brn_fr AS INTE.
DEF VAR  nv_brn_to AS INTE.
DEF VAR  i         AS INTE.

DEFINE NEW SHARED WORKFILE wvat7
    FIELD  wyear   AS CHAR FORMAT "X(4)"
    FIELD  wvat    AS DECI FORMAT "->9.99"
    FIELD  wvalf1  AS DECI FORMAT ">,>>>,>>>,>>>,>>9.99-"
    FIELD  wvalf2  AS DECI FORMAT ">,>>>,>>>,>>>,>>9.99-"    
    FIELD  wvalt   AS DECI FORMAT ">,>>>,>>>,>>>,>>9.99-" 
    FIELD  wvalq   AS DECI FORMAT ">,>>>,>>>,>>>,>>9.99-"
    FIELD  wvalr   AS DECI FORMAT ">,>>>,>>>,>>>,>>9.99-". 

DEFINE STREAM ns1.
DEFINE STREAM ns2.

DEFINE NEW SHARED WORK-TABLE wt_uwm200
    FIELD  wt_policy   AS CHAR   FORMAT  "X(16)"
    FIELD  wt_rencnt   AS INTE   FORMAT  ">9"
    FIELD  wt_endcnt   AS INTE   FORMAT  "999"
    FIELD  wt_c_enct   AS INTE   FORMAT  "999"
    FIELD  wt_csftq    AS CHAR   FORMAT  "X"
    FIELD  wt_rico     AS CHAR   FORMAT  "X(7)"
    FIELD  wt_dept     AS CHAR   FORMAT  "X"
    FIELD  wt_c_no     AS INTE   FORMAT  "9999999"
    FIELD  wt_c_enno   AS INTE   FORMAT  "9999999"
    FIELD  wt_rip1ae   AS LOG
    FIELD  wt_rip2ae   AS LOG 
    FIELD  wt_rip1     AS DECI   FORMAT  ">9.999999"
    FIELD  wt_rip2     AS DECI   FORMAT  ">9.999999"
    FIELD  wt_recip    AS CHAR   FORMAT  "X"
    FIELD  wt_ricomm   AS DATE   FORMAT  "99/99/9999"
    FIELD  wt_riexp    AS DATE   FORMAT  "99/99/9999"
    FIELD  wt_trndat   AS DATE   FORMAT  "99/99/9999"
    FIELD  wt_com2gn   AS LOG
    FIELD  wt_ristmp   AS DECI   FORMAT  ">,>>>,>>9.99-"
    FIELD  wt_prntri   AS LOG
    FIELD  wt_thpol    AS CHAR   FORMAT  "X(16)"
    FIELD  wt_c_year   AS INTE   FORMAT  "9999"
    FIELD  wt_trtyri   AS CHAR   FORMAT  "X"
    FIELD  wt_docri    AS CHAR   FORMAT  "X(7)"
    FIELD  wt_fptr01   AS RECID  FORMAT  "->>>>>>9"
    FIELD  wt_bptr01   AS RECID  FORMAT  "->>>>>>9"
    FIELD  wt_fptr02   AS RECID  FORMAT  "->>>>>>9"
    FIELD  wt_bptr02   AS RECID  FORMAT  "->>>>>>9"
    FIELD  wt_fptr03   AS RECID  FORMAT  "->>>>>>9"
    FIELD  wt_bptr03   AS RECID  FORMAT  "->>>>>>9"
    FIELD  wt_dreg_p   AS LOG
    FIELD  wt_curbil   AS CHAR   FORMAT  "X(3)"
    FIELD  wt_reg_no   AS DECI   FORMAT  ">,>>>,>>9"
    FIELD  wt_bordno   AS DECI   FORMAT  ">,>>>,>>9"
    FIELD  wt_panel    AS CHAR   FORMAT  "X(1)"
    FIELD  wt_riendt   AS DATE   FORMAT  "99/99/9999"
    FIELD  wt_branch   AS CHAR   FORMAT  "X(2)"  .

DEF  VAR  nv_potypfr   AS  CHAR   FORMAT  "X(5)" .   
DEF  VAR  nv_potypto   AS  CHAR   FORMAT  "X(5)" .   
DEF  VAR  nv_source1   AS  LOGICAL . 
DEF  VAR  nv_datefr    AS  DATE   FORMAT  "99/99/9999"  . 
DEF  VAR  nv_dateto    AS  DATE   FORMAT  "99/99/9999"  . 
DEF  VAR  nv_rel       AS  CHAR   FORMAT  "x(1)" .    
DEF  VAR  nv_branfr    AS  CHAR   FORMAT  "X(3)" .    
DEF  VAR  nv_branto    AS  CHAR   FORMAT  "X(3)" .    
DEF  VAR  nv_broker    AS  LOGICAL  .                  
DEF  VAR  nv_brokfr    AS  CHAR   FORMAT  "X(3)" .   
DEF  VAR  nv_brokto    AS  CHAR   FORMAT  "X(3)" .   
DEF  VAR  nv_outtyp    AS  CHAR   FORMAT  "X(1)"  .   
DEF  VAR  nv_output    AS  CHAR   FORMAT  "X(30)" .
DEF  VAR  nv_riskno    AS  INT    FORMAT  ">,>>9" .
DEF  VAR  nv_agent     AS  CHAR   FORMAT "x(10)".
DEF  VAR  nv_rename    AS  CHAR   FORMAT "x(50)".
DEF  VAR  nv_recode    AS  CHAR   FORMAT "x(10)". 
DEF  VAR  nv_flood     AS  DECI   FORMAT "->,>>>,>>>,>>>,>>9.99". 
DEF  VAR  nv_storm     AS  DECI   FORMAT "->,>>>,>>>,>>>,>>9.99". 
DEF  VAR  nv_earth     AS  DECI   FORMAT "->,>>>,>>>,>>>,>>9.99". 
DEF  VAR  nv_disp      AS  CHAR   FORMAT  "X(30)" .
DEF  VAR  nv_disc      AS  DECI   FORMAT "->,>>>,>>>,>>>,>>9.99". 
DEF  VAR  n_rb_com     AS  DECI   FORMAT "->,>>>,>>>,>>>,>>9.99".
DEF  VAR  n_rf_com     AS  DECI   FORMAT "->,>>>,>>>,>>>,>>9.99".
DEF  VAR  nv_comfac    AS  DECI   FORMAT "->>9.99".
DEF  VAR  nv_totflood  AS  DECI   FORMAT "->,>>>,>>>,>>>,>>9.99".
DEF  VAR  nv_totstrom  AS  DECI   FORMAT "->,>>>,>>>,>>>,>>9.99".
DEF  VAR  nv_totearth  AS  DECI   FORMAT "->,>>>,>>>,>>>,>>9.99".
DEF  VAR  br_totflood  AS  DECI   FORMAT "->,>>>,>>>,>>>,>>9.99".  
DEF  VAR  br_totstrom  AS  DECI   FORMAT "->,>>>,>>>,>>>,>>9.99".  
DEF  VAR  br_totearth  AS  DECI   FORMAT "->,>>>,>>>,>>>,>>9.99".
DEF  VAR  nb_flood     AS  DECI   FORMAT "->,>>>,>>>,>>>,>>9.99".
DEF  VAR  nb_strom     AS  DECI   FORMAT "->,>>>,>>>,>>>,>>9.99".
DEF  VAR  nb_earth     AS  DECI   FORMAT "->,>>>,>>>,>>>,>>9.99".
DEF  VAR  br_liflood   AS  DECI   FORMAT "->,>>>,>>>,>>>,>>9.99". 
DEF  VAR  br_listrom   AS  DECI   FORMAT "->,>>>,>>>,>>>,>>9.99". 
DEF  VAR  br_liearth   AS  DECI   FORMAT "->,>>>,>>>,>>>,>>9.99". 
DEF  VAR  nv_by        AS  CHAR   FORMAT "X(15)".
DEF  VAR  nv_totdisc   AS  DECI   FORMAT "->,>>>,>>>,>>>,>>9.99".
DEF  VAR  nb_disc      AS  DECI   FORMAT "->,>>>,>>>,>>>,>>9.99".
DEF  VAR  nv_retyp     AS  CHAR   FORMAT "x(1)".
DEF  VAR  nv_facp      AS  DECI   FORMAT "->>9.99". 
DEF  VAR  nv_clmpaid2  AS  DECI   FORMAT "->,>>>,>>>,>>>,>>9.99". 
DEF  VAR  nv_totclm    AS  DECI   FORMAT "->,>>>,>>>,>>>,>>9.99".  
DEF  VAR  nv_rencnt    AS  INT    FORMAT ">>9". 
DEF  VAR  nv_endcnt    AS  INT    FORMAT "999". 
DEF  VAR  nv_company   AS  CHAR   FORMAT "x(10)".
DEF  VAR  nv_due       AS  DECI   FORMAT "->,>>>,>>>,>>>,>>9.99".
DEF  VAR  nv_os        AS  DECI   FORMAT "->,>>>,>>>,>>>,>>9.99".
DEF  VAR  nv_trndatcl  AS  DATE.  
DEF  VAR  nv_docno     AS  CHAR   FORMAT "x(10)". 
DEF  VAR  nv_facnet    AS  DECI   FORMAT "->,>>>,>>>,>>>,>>9.99". 
DEF  VAR  nv_facamt    AS  DECI   FORMAT "->,>>>,>>>,>>>,>>9.99".
DEF VAR nt_totclm    AS DEC FORMAT "->,>>>,>>>,>>>,>>9.99".
DEF VAR nv_paid      AS DEC FORMAT "->,>>>,>>>,>>>,>>9.99".
DEF VAR nv_osr       AS DEC FORMAT "->,>>>,>>>,>>>,>>9.99".
DEF VAR nv_sumreins  AS DEC FORMAT "->,>>>,>>>,>>>,>>9.99". 
DEF VAR nv_outprm    AS DEC FORMAT "->,>>>,>>>,>>>,>>9.99". 
DEF VAR nv_outcom    AS DEC FORMAT "->,>>>,>>>,>>>,>>9.99". 

DEF VAR nv_asdat AS DATE INIT ?.
DEF BUFFER bfuwm100  FOR uwm100.
DEF BUFFER bfuwm1002 FOR uwm100.
DEF VAR nv_name   AS CHAR.
DEF VAR rico_name AS CHAR.
DEF VAR nv_polsta AS CHAR.
DEF VAR nv_asdat1 AS DATE   FORMAT  "99/99/9999" .

DEF VAR n_cntrisk  AS INT INIT 0.
DEF VAR n_noofrisk AS INT INIT 0.
DEF VAR nv_agtreg  AS CHAR FORMAT "x(10)" .
DEF VAR nv_per     AS DECI FORMAT "->>9.99" .
DEF VAR n_bran     AS CHAR FORMAT "X(2)".
DEF VAR nv_si_p    AS DECI FORMAT "->>9.99" . 
DEF VAR nv_sigr    AS DECI FORMAT "->>9.99" .  
DEF VAR nv_risi_p   AS DECI FORMAT "->>9.99" .
DEF VAR nv_risi     AS DECI FORMAT ">,>>>,>>>,>>>,>>9.99-" .
DEF VAR nv_riprem     AS DECI FORMAT ">,>>>,>>>,>>>,>>9.99-" .
DEF VAR nv_ricom     AS DECI FORMAT ">,>>>,>>>,>>>,>>9.99-" .
DEF VAR nv_costy    AS   DECI FORMAT ">>9.99" . 
DEF VAR nv_rifac    AS   DECI FORMAT ">>9.99" . 
DEF VAR nv_ritty    AS   DECI FORMAT ">>9.99" . 
DEF VAR nv_retper   AS   DECI FORMAT ">>9.99" .
DEF VAR nt_risi_p   AS DECI FORMAT "->>9.99" .

DEF VAR mstat_pr  AS DEC.
DEF VAR mret_pr   AS DEC.
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
DEF VAR nv_reccnt AS INT FORMAT ">>>,>>>,>>9".
DEF VAR cntop     AS INT FORMAT ">>>,>>>,>>9".
DEF VAR nv_next   AS INT FORMAT ">>>,>>>,>>9".
DEF VAR nv_output2 AS CHAR FORMAT "X(50)".
DEF VAR nv_sipol  AS   DECI FORMAT "->,>>>,>>>,>>>,>>9.99".
DEF VAR nv_compol  AS   DECI FORMAT "->,>>>,>>>,>>>,>>9.99".
DEF VAR nv_risi_f  LIKE uwd200.risi.
DEF VAR nv_fac_per LIKE uwd200.risi.
DEF VAR nv_riconame LIKE xmm600.NAME.     
DEF VAR nv_ricoagtreg  LIKE  xmm600.agtreg.  
DEF VAR nv_risi_r  LIKE uwd200.risi.
DEF VAR nv_riret  AS   DECI FORMAT "->,>>>,>>>,>>>,>>9.99".
DEF VAR nv_risi_t LIKE uwd200.risi.
DEF VAR nv_recid AS RECID.
DEF VAR nv_occup AS CHAR FORMAT "X(256)" INIT "".

/*---------Inward Parameter----------*/
DEF VAR n_sum1    like uwm120.sigr   INIT 0.
DEF VAR n_sum2    like uwm100.prem_t INIT 0.
DEF VAR n_sum3    like uwm100.ptax   INIT 0.
DEF VAR n_sum4    like uwm100.pstp   INIT 0.
DEF VAR n_sum6    like uwm100.prem_t INIT 0.

DEF VAR n_sum1b   like uwm120.sigr   INIT 0.
DEF VAR n_sum2b   like uwm100.prem_t INIT 0.
DEF VAR n_sum3b   like uwm100.ptax   INIT 0.
DEF VAR n_sum4b   like uwm100.pstp   INIT 0.
DEF VAR n_sum6b   like uwm100.prem_t INIT 0.
DEF VAR n_dept    LIKE uwm100.dept.

DEF VAR n_an      LIKE UWM120.SIGR.
DEF VAR n-18      AS CHAR FORMAT "x(100)".
DEF VAR nvcurr    LIKE uwm120.sicurr.
DEF VAR nv_com1p  LIKE UWM120.COM1P.
DEF VAR n_agent   AS CHAR FORMAT "x(60)".
def var n_percen            as char format "x".
DEF VAR nv_oicline AS CHAR FORMAT "X(8)" INIT "".
DEF VAR nv_uwline AS CHAR FORMAT "X(2)" INIT "".
DEF VAR nv_uwlinedesc AS CHAR FORMAT "X(50)" INIT "".

DEF VAR nn_acno     AS CHAR FORMAT "X(10)" INIT "".
DEF VAR nn_acnoname AS CHAR FORMAT "X(50)" INIT "".
DEF VAR nn_cedco    AS CHAR FORMAT "X(10)" INIT "".
DEF VAR nn_cedname  AS CHAR FORMAT "X(50)" INIT "".

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME frmain

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS cbRptList fi_potypfr fi_potypto fi_source ~
rd_date fi_datefr fi_dateto fi_branfr fi_branto fi_rel fi_brokfr fi_brokto ~
fi_output bt_ok bt_cancel fi_disp recOutput-7 recOutput-8 RECT-3 RecOK ~
RECT-4 RECT-5 RECT-102 recOutput-9 
&Scoped-Define DISPLAYED-OBJECTS cbRptList fi_potypfr fi_potypto fi_source ~
rd_date fi_datefr fi_dateto fi_branfr fi_branto fi_rel fi_brokfr fi_brokto ~
fi_output fi_disp 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR cC-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bt_cancel 
     LABEL "CANCEL" 
     SIZE 15 BY 1.52
     FONT 2.

DEFINE BUTTON bt_ok 
     LABEL "OK" 
     SIZE 15 BY 1.52
     FGCOLOR 7 FONT 2.

DEFINE VARIABLE cbRptList AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 4
     LIST-ITEMS "Statement Premium Outward","Statement Claim Paid Outward","Treaty Report","Statement Premium Inward" 
     DROP-DOWN-LIST
     SIZE 38.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_branfr AS CHARACTER FORMAT "X(4)":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_branto AS CHARACTER FORMAT "X(4)":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_brokfr AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_brokto AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_datefr AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_dateto AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_disp AS CHARACTER FORMAT "X(30)":U 
      VIEW-AS TEXT 
     SIZE 26.5 BY 1
     BGCOLOR 3 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_output AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 33.5 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_potypfr AS CHARACTER FORMAT "X(5)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_potypto AS CHARACTER FORMAT "X(5)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_rel AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_source AS CHARACTER FORMAT "X(1)":U INITIAL "no" 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 2 NO-UNDO.

DEFINE VARIABLE rd_date AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Tran Date", 1,
"Comm Date", 2
     SIZE 13 BY 3
     BGCOLOR 18  NO-UNDO.

DEFINE RECTANGLE RecOK
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 20 BY 4.52
     BGCOLOR 1 .

DEFINE RECTANGLE recOutput-7
     EDGE-PIXELS 4 GRAPHIC-EDGE    
     SIZE 48.83 BY 3.14
     BGCOLOR 8 .

DEFINE RECTANGLE recOutput-8
     EDGE-PIXELS 4 GRAPHIC-EDGE    
     SIZE 82.5 BY 3.52
     BGCOLOR 8 .

DEFINE RECTANGLE recOutput-9
     EDGE-PIXELS 4 GRAPHIC-EDGE    
     SIZE 48.83 BY 3.14
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-102
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE .67 BY 3.91.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 50.67 BY 4.71
     BGCOLOR 18 .

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 31.83 BY 4.71
     BGCOLOR 18 .

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 82.5 BY 3.24
     BGCOLOR 18 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME frmain
     cbRptList AT ROW 4.91 COL 9.17 COLON-ALIGNED NO-LABEL WIDGET-ID 138
     fi_potypfr AT ROW 7.29 COL 38.33 COLON-ALIGNED NO-LABEL WIDGET-ID 78
     fi_potypto AT ROW 7.24 COL 66.33 COLON-ALIGNED NO-LABEL WIDGET-ID 80
     fi_source AT ROW 8.62 COL 38.33 COLON-ALIGNED NO-LABEL WIDGET-ID 76
     rd_date AT ROW 12.14 COL 11.5 NO-LABEL WIDGET-ID 26
     fi_datefr AT ROW 12.38 COL 38.33 COLON-ALIGNED NO-LABEL WIDGET-ID 82
     fi_dateto AT ROW 13.76 COL 38.33 COLON-ALIGNED NO-LABEL WIDGET-ID 84
     fi_branfr AT ROW 12.38 COL 73.67 COLON-ALIGNED NO-LABEL WIDGET-ID 86
     fi_branto AT ROW 13.76 COL 73.67 COLON-ALIGNED NO-LABEL WIDGET-ID 88
     fi_rel AT ROW 15.86 COL 38.33 COLON-ALIGNED NO-LABEL WIDGET-ID 126
     fi_brokfr AT ROW 17.1 COL 38.33 COLON-ALIGNED NO-LABEL WIDGET-ID 92
     fi_brokto AT ROW 17.1 COL 58.33 COLON-ALIGNED NO-LABEL WIDGET-ID 94
     fi_output AT ROW 20.62 COL 24.33 COLON-ALIGNED NO-LABEL WIDGET-ID 98
     bt_ok AT ROW 19.48 COL 67.17 WIDGET-ID 100
     bt_cancel AT ROW 21.43 COL 67.33 WIDGET-ID 102
     fi_disp AT ROW 22.67 COL 30 NO-LABEL WIDGET-ID 136
     "Broker Code From :" VIEW-AS TEXT
          SIZE 25.67 BY 1.19 AT ROW 17 COL 14.17 WIDGET-ID 40
          BGCOLOR 18 FONT 2
     "Policy Type From  :" VIEW-AS TEXT
          SIZE 27.5 BY 1.19 AT ROW 7.24 COL 13 WIDGET-ID 18
          BGCOLOR 8 FGCOLOR 0 FONT 2
     "                          R/I EXPOSURE FOR YEAR" VIEW-AS TEXT
          SIZE 96.83 BY 1.52 AT ROW 1.38 COL 1.17 WIDGET-ID 16
          BGCOLOR 1 FGCOLOR 7 FONT 2
     "To :" VIEW-AS TEXT
          SIZE 6.5 BY 1.19 AT ROW 20.52 COL 19.33 WIDGET-ID 46
          BGCOLOR 8 FGCOLOR 0 FONT 2
     "Source  :" VIEW-AS TEXT
          SIZE 13.5 BY .62 AT ROW 8.76 COL 26.33 WIDGET-ID 24
          BGCOLOR 8 FGCOLOR 0 FONT 2
     "D = Direct , I = Ri" VIEW-AS TEXT
          SIZE 19.17 BY 1.19 AT ROW 8.57 COL 54.33 WIDGET-ID 22
          BGCOLOR 8 FGCOLOR 0 
     " Y = yes , N = no , A = all" VIEW-AS TEXT
          SIZE 19.5 BY .62 AT ROW 16.05 COL 53.67 WIDGET-ID 132
          BGCOLOR 18 FGCOLOR 0 
     " To :" VIEW-AS TEXT
          SIZE 7.5 BY 1.19 AT ROW 17 COL 52.67 WIDGET-ID 42
          BGCOLOR 18 FONT 2
     "   BY" VIEW-AS TEXT
          SIZE 50 BY .76 AT ROW 11.14 COL 8.5 WIDGET-ID 114
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "Releas Flag :" VIEW-AS TEXT
          SIZE 18.33 BY 1.19 AT ROW 15.76 COL 20.67 WIDGET-ID 130
          BGCOLOR 18 FONT 2
     "To  :" VIEW-AS TEXT
          SIZE 9 BY 1.19 AT ROW 13.67 COL 65.33 WIDGET-ID 36
          BGCOLOR 18 FONT 2
     "  Type Of Report" VIEW-AS TEXT
          SIZE 19 BY .76 AT ROW 3.76 COL 8 WIDGET-ID 142
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "From :" VIEW-AS TEXT
          SIZE 9.5 BY 1.19 AT ROW 12.43 COL 30.33 WIDGET-ID 20
          BGCOLOR 18 FONT 2
     "To   :" VIEW-AS TEXT
          SIZE 8.83 BY 1.19 AT ROW 13.71 COL 30.17 WIDGET-ID 30
          BGCOLOR 18 FONT 2
     "From :" VIEW-AS TEXT
          SIZE 9.5 BY 1.19 AT ROW 12.33 COL 64 WIDGET-ID 32
          BGCOLOR 18 FONT 2
     "  Output" VIEW-AS TEXT
          SIZE 13 BY .76 AT ROW 19.48 COL 13.83 WIDGET-ID 124
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "   Branch" VIEW-AS TEXT
          SIZE 30.83 BY .76 AT ROW 11.14 COL 59.17 WIDGET-ID 116
          BGCOLOR 1 FGCOLOR 7 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 97.17 BY 23.52
         BGCOLOR 3  WIDGET-ID 100.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME frmain
     " To  :" VIEW-AS TEXT
          SIZE 10 BY 1.19 AT ROW 7.24 COL 58.83 WIDGET-ID 14
          BGCOLOR 8 FGCOLOR 0 FONT 2
     recOutput-7 AT ROW 19 COL 13.83 WIDGET-ID 62
     recOutput-8 AT ROW 6.71 COL 8 WIDGET-ID 104
     RECT-3 AT ROW 10.62 COL 8 WIDGET-ID 108
     RecOK AT ROW 19 COL 64.67 WIDGET-ID 110
     RECT-4 AT ROW 10.62 COL 58.67 WIDGET-ID 112
     RECT-5 AT ROW 15.33 COL 8 WIDGET-ID 120
     RECT-102 AT ROW 11.43 COL 26.5 WIDGET-ID 122
     recOutput-9 AT ROW 3.29 COL 8 WIDGET-ID 140
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 97.17 BY 23.52
         BGCOLOR 3  WIDGET-ID 100.


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
  CREATE WINDOW cC-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "wacr0010.w - R/I Exposure For Year"
         HEIGHT             = 23.24
         WIDTH              = 97
         MAX-HEIGHT         = 45.81
         MAX-WIDTH          = 213.33
         VIRTUAL-HEIGHT     = 45.81
         VIRTUAL-WIDTH      = 213.33
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
/* SETTINGS FOR WINDOW cC-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME frmain
   FRAME-NAME Custom                                                    */
/* SETTINGS FOR FILL-IN fi_disp IN FRAME frmain
   ALIGN-L                                                              */
ASSIGN 
       fi_disp:HIDDEN IN FRAME frmain           = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(cC-Win)
THEN cC-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME cC-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cC-Win cC-Win
ON END-ERROR OF cC-Win /* wacr0010.w - R/I Exposure For Year */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cC-Win cC-Win
ON WINDOW-CLOSE OF cC-Win /* wacr0010.w - R/I Exposure For Year */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bt_cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt_cancel cC-Win
ON CHOOSE OF bt_cancel IN FRAME frmain /* CANCEL */
DO:

    APPLY "CLOSE" TO THIS-PROCEDURE.
    RETURN NO-APPLY.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bt_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt_ok cC-Win
ON CHOOSE OF bt_ok IN FRAME frmain /* OK */
DO:
  IF fi_potypfr = "" THEN DO:
     MESSAGE " ** Please Enter Policy Type From. ** " VIEW-AS ALERT-BOX.
     APPLY "ENTRY" TO fi_potypfr IN FRAM frmain.
     RETURN NO-APPLY.
  END.

  IF fi_potypto = "" THEN DO:
     MESSAGE " ** Please Enter Policy Type To. ** " VIEW-AS ALERT-BOX.
     APPLY "ENTRY" TO fi_potypto IN FRAM frmain.
     RETURN NO-APPLY.
  END.

  IF fi_datefr = ? THEN DO:
     MESSAGE " ** Please Enter Trandate From. ** " VIEW-AS ALERT-BOX.
     APPLY "ENTRY" TO fi_datefr IN FRAM frmain.
     RETURN NO-APPLY.
  END.

  IF fi_dateto = ? THEN DO:
     MESSAGE " ** Please Enter Trandate To. ** " VIEW-AS ALERT-BOX.
     APPLY "ENTRY" TO fi_dateto IN FRAM frmain.
     RETURN NO-APPLY.
  END.

  IF fi_branfr = "" THEN DO:
     MESSAGE " ** Please Enter Branch From. ** " VIEW-AS ALERT-BOX.
     APPLY "ENTRY" TO fi_branfr IN FRAM frmain.
     RETURN NO-APPLY.
  END.

  IF fi_branto = "" THEN DO:
     MESSAGE " ** Please Enter Branch To. ** " VIEW-AS ALERT-BOX.
     APPLY "ENTRY" TO fi_branto IN FRAM frmain.
     RETURN NO-APPLY.
  END.

  IF fi_rel = "" THEN DO:
     MESSAGE " ** Please Enter Releas. ** " VIEW-AS ALERT-BOX.
     APPLY "ENTRY" TO fi_rel IN FRAM frmain.
     RETURN NO-APPLY.
  END.
  
  IF fi_brokfr = "" THEN DO:
     MESSAGE " ** Please Enter Broker From. ** " VIEW-AS ALERT-BOX.
     APPLY "ENTRY" TO fi_brokfr IN FRAM frmain.
     RETURN NO-APPLY.
  END.

  IF fi_brokto = "" THEN DO:
     MESSAGE " ** Please Enter Broker To. ** " VIEW-AS ALERT-BOX.
     APPLY "ENTRY" TO fi_brokto IN FRAM frmain.
     RETURN NO-APPLY.
  END.

  IF fi_output = "" THEN DO:
     MESSAGE " ** Please Enter Output To. ** " VIEW-AS ALERT-BOX.
     APPLY "ENTRY" TO fi_output IN FRAM frmain.
     RETURN NO-APPLY.
  END.
  
  IF rd_date = 1 THEN nv_by = "Trandate".
  IF rd_date = 2 THEN nv_by = "Commdate".
  MESSAGE "PROCESS R/I EXPOSURE FOR YEAR "  SKIP(1)
          "BY : " nv_by  SKIP (1)
          "วันที่ : " STRING(fi_datefr,"99/99/9999")  SKIP (1)
          "ถึงวันที่ : " STRING(fi_dateto,"99/99/9999") SKIP (1)
          "ตั้งแต่สาขา : " nv_branfr   "ถึงสาขา: " nv_branto 

  VIEW-AS ALERT-BOX QUESTION  BUTTONS YES-NO
  UPDATE CHOICE AS LOGICAL.
  CASE CHOICE:
       WHEN TRUE THEN DO:

         IF cbRptList = "Statement Premium Outward" THEN DO: 
             RUN PD_brdesc.

         END.
       
         IF cbRptList = "Statement Claim Paid Outward" THEN DO:
             RUN PD_claim_trn .
            /* IF rd_date = 1 THEN RUN PD_claim_trn .*/
            /* IF rd_date = 2 THEN RUN PD_claim_com .*/
         END. 

         IF cbRptList = "Treaty Report" THEN DO:
              RUN pd_treaty_head .
         END.

         IF cbRptList = "Statement Premium Inward" THEN DO: 
             RUN PD_Inward.
         END.
         
         fi_disp = "   .. complete ..  ".
         DISP  fi_disp  WITH FRAME frmain .

         MESSAGE ".. Complete .." VIEW-AS ALERT-BOX.
       END.

       WHEN FALSE THEN DO:
       RETURN NO-APPLY.

       END.
  END CASE.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cbRptList
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cbRptList cC-Win
ON RETURN OF cbRptList IN FRAME frmain
DO:
    /*APPLY "ENTRY" TO fiBranch IN FRAME frST.*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cbRptList cC-Win
ON VALUE-CHANGED OF cbRptList IN FRAME frmain
DO:  
  cbRptList = INPUT cbRptList.


  IF cbRptList :SCREEN-VALUE = "Statement Premium Outward" THEN DO:
       DISP cbRptList WITH FRAME frmain .
  END.

  IF cbRptList:SCREEN-VALUE = "Statement Claim Paid Outward" THEN DO:
       DISP cbRptList WITH FRAME frmain .
  END.

  IF cbRptList:SCREEN-VALUE = "Treaty Report" THEN DO:
       DISP cbRptList WITH FRAME frmain .
  END.

  IF cbRptList :SCREEN-VALUE = "Statement Premium Inward" THEN DO:
       DISP cbRptList WITH FRAME frmain .
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_branfr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_branfr cC-Win
ON LEAVE OF fi_branfr IN FRAME frmain
DO:
  fi_branfr = INPUT fi_branfr.
    nv_branfr = fi_branfr.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_branto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_branto cC-Win
ON LEAVE OF fi_branto IN FRAME frmain
DO:
  fi_branto = INPUT fi_branto.
    nv_branto = fi_branto.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_brokfr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_brokfr cC-Win
ON LEAVE OF fi_brokfr IN FRAME frmain
DO:
  fi_brokfr = INPUT fi_brokfr.
    nv_brokfr = fi_brokfr.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_brokto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_brokto cC-Win
ON LEAVE OF fi_brokto IN FRAME frmain
DO:
  fi_brokto = INPUT fi_brokto.
    nv_brokto = fi_brokto.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_datefr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_datefr cC-Win
ON LEAVE OF fi_datefr IN FRAME frmain
DO:
  fi_datefr = INPUT fi_datefr.
    nv_datefr = fi_datefr.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dateto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dateto cC-Win
ON LEAVE OF fi_dateto IN FRAME frmain
DO:
  fi_dateto = INPUT fi_dateto.
    nv_dateto = fi_dateto.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_output
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_output cC-Win
ON LEAVE OF fi_output IN FRAME frmain
DO:
  fi_output = INPUT fi_output.
    nv_output = fi_output.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_potypfr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_potypfr cC-Win
ON LEAVE OF fi_potypfr IN FRAME frmain
DO:
  fi_potypfr = INPUT fi_potypfr.
  nv_potypfr = fi_potypfr .

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_potypto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_potypto cC-Win
ON LEAVE OF fi_potypto IN FRAME frmain
DO:
  fi_potypto = INPUT fi_potypto.
  nv_potypto = fi_potypto .
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_rel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_rel cC-Win
ON LEAVE OF fi_rel IN FRAME frmain
DO:
    fi_rel = INPUT fi_rel.
    nv_rel = fi_rel .
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_source
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_source cC-Win
ON LEAVE OF fi_source IN FRAME frmain
DO:
     fi_source = INPUT fi_source.

   /* IF fi_source = "D" THEN
    nv_source1 <> "i" .

    ELSE IF fi_source = "I" THEN
    nv_source1 = "i" .

    ELSE IF fi_source = "A" THEN
        nv_source1 <> "c" . */

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rd_date
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rd_date cC-Win
ON VALUE-CHANGED OF rd_date IN FRAME frmain
DO:
  rd_date = INPUT rd_date.
  /*
  IF rd_date = "Tran Date" THEN rd_date = "1" .
  IF rd_date = "Comm Date" THEN rd_date = "2" .*/
                                                      
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK cC-Win 


/* ***************************  Main Block  *************************** */

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

DO WITH FRAME frmain:
    ASSIGN
        
        fi_potypfr = "M01"
        fi_potypto = "C93"
        fi_source  = "A"
        rd_date    = 1
        fi_datefr  = TODAY 
        fi_dateto  = TODAY 
        fi_rel     = "A"  
        fi_branfr  = "0"
        fi_branto  = "Z"
        fi_brokfr  = "0" 
        fi_brokto  = "z".  
        cbRptList  = "Statement Premium Outward" .
    
    DISP fi_potypfr  fi_potypto  fi_source  rd_date   fi_branfr fi_branto
         fi_brokfr   fi_brokto   fi_datefr  fi_dateto fi_rel    cbRptList .

    ASSIGN nv_datefr  = fi_datefr
           nv_dateto  = fi_dateto
           nv_potypfr = fi_potypfr
           nv_potypto = fi_potypto
           nv_branfr  = fi_branfr  
           nv_branto  = fi_branto  
           nv_brokfr  = fi_brokfr  
           nv_brokto  = fi_brokto 
           nv_rel     = fi_rel  
           nv_retyp   = cbRptList .

  /*  IF fi_source = "D" THEN
    nv_source1 = YES .

    IF fi_source = "I" THEN
    nv_source1 = NO .  */

END.
                            
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI cC-Win  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(cC-Win)
  THEN DELETE WIDGET cC-Win.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI cC-Win  _DEFAULT-ENABLE
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
  DISPLAY cbRptList fi_potypfr fi_potypto fi_source rd_date fi_datefr fi_dateto 
          fi_branfr fi_branto fi_rel fi_brokfr fi_brokto fi_output fi_disp 
      WITH FRAME frmain IN WINDOW cC-Win.
  ENABLE cbRptList fi_potypfr fi_potypto fi_source rd_date fi_datefr fi_dateto 
         fi_branfr fi_branto fi_rel fi_brokfr fi_brokto fi_output bt_ok 
         bt_cancel fi_disp recOutput-7 recOutput-8 RECT-3 RecOK RECT-4 RECT-5 
         RECT-102 recOutput-9 
      WITH FRAME frmain IN WINDOW cC-Win.
  {&OPEN-BROWSERS-IN-QUERY-frmain}
  VIEW cC-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_brdesc cC-Win 
PROCEDURE pd_brdesc :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
vFirstTime =  STRING(TIME, "HH:MM AM").
 
FIND FIRST xmm024 NO-LOCK NO-ERROR.

ASSIGN
n_fr_pol      =  nv_frm_policy
nv_frm_policy =  nv_frm_policy + nv_branfr + SUBSTR(nv_potypfr,2,2) +
                 SUBSTR(STRING(YEAR(nv_datefr) + 543,"9999"),3,2) + nv_brokfr
nv_to_policy  =  n_fr_pol + nv_branto + SUBSTRING(nv_potypto,2,2) +
                 SUBSTR(STRING(YEAR(nv_dateto) + 543 ,"9999"),3,2) + nv_brokto +
                 "ZZZZZZ".
ASSIGN
n_br2      = ""
n_mr2      = ""
           
nv_brdes   = ""
nv_brn_fr  = 0
nv_brn_to  = 0                         
nv_brdes1  = ""                       
i          = 0.



IF INDEX("ABCDEFGHIJKLMNOPQRSTUVWXYZ" , nv_branto) <> 0 THEN DO: /*branch เป็นตัวอักษร*/
    
    loop1:
    FOR EACH xmm023 WHERE xmm023.branch >= nv_branfr AND
                          xmm023.branch <= nv_branto NO-LOCK BREAK BY branch:

        IF xmm023.branch < nv_branfr OR xmm023.branch > nv_branto THEN NEXT loop1.

        IF LENGTH(xmm023.branch) = 1 THEN DO:
            nv_brdes = nv_brdes + "," + xmm023.branch.
        END.
        ELSE DO:
            IF SUBSTR(xmm023.branch,1,1) = "9" AND SUBSTR(xmm023.branch,2,1) <> "0" THEN DO:
                ASSIGN
                nv_brdes  = nv_brdes + "," + substr(xmm023.branch,2,1)
                nv_brdes  = nv_brdes + "," + xmm023.branch
                nv_brdes1 = nv_brdes1 + "," + xmm023.branch.
            END.
            ELSE nv_brdes = nv_brdes + "," + xmm023.branch.
        END.
    END.
END.
ELSE DO: /*แสดงว่าเป็นตัวเลข*/
    ASSIGN
    nv_brn_fr = INTE(nv_branfr)
    nv_brn_to = INTE(nv_branto).

    loop2:
    FOR EACH xmm023 WHERE xmm023.branch >= nv_branfr AND
                          xmm023.branch <= nv_branto NO-LOCK BREAK BY branch:
 
        IF LENGTH(xmm023.branch) = 1 THEN DO:
           nv_brdes = nv_brdes + "," + xmm023.branch.
        END.
        ELSE DO:
            IF SUBSTR(xmm023.branch,1,1) = "9" AND SUBSTR(xmm023.branch,2,1) <> "0" THEN DO:
                nv_brdes  = nv_brdes + "," + substr(xmm023.branch,2,1).
                nv_brdes  = nv_brdes + "," + xmm023.branch.
                nv_brdes1 = nv_brdes1 + "," + xmm023.branch.
            END.
            ELSE nv_brdes = nv_brdes + "," + xmm023.branch.
            
            IF LENGTH(nv_branfr) = 1 AND LENGTH(nv_branto) = 2 THEN DO: /*วนค่าในกรณีที่เรียกbranch form-to 1-10*/
                DO i = nv_brn_fr TO nv_brn_to :
                    nv_brdes = nv_brdes + "," + STRING(i).
                END.
            END.
        END.
    END.
END.

IF rd_date = 1 THEN RUN pd_facrepol_trn.
IF rd_date = 2 THEN RUN pd_facrepol_com.

RUN pd_facpolrisi.
RUN pd_facpolsubrisi.
RUN pd_exportfacpol.


vLastTime = STRING(TIME, "HH:MM AM").


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_broker cC-Win 
PROCEDURE PD_broker :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
ASSIGN
    n_cnt  = 0
    n_cnt1 = 0.

FOR EACH wt_uwm200 NO-LOCK
    BREAK     BY wt_uwm200.wt_branch
    BY SUBSTRING(wt_uwm200.wt_policy,3,2)
              BY wt_uwm200.wt_policy
              BY wt_uwm200.wt_csftq
              BY wt_uwm200.wt_c_no
              BY wt_uwm200.wt_c_enno  :
   /* /*------------- june --------------*/

    IF FIRST-OF(wt_uwm200.wt_policy) THEN 
        ASSIGN
      nv_sibht  = 0       nv_flood  = 0  
      nv_riskno = 0       nv_storm  = 0  
      nv_agent  = ""      nv_earth  = 0  
      nv_rename = ""      n_rb_com  = 0  
      nv_recode = ""      n_rf_com  = 0  
                          nv_comfac = 0 .  */

    ASSIGN
    nv_comfac = wt_uwm200.wt_rip1.  /* june */

    FIND FIRST uwm100 USE-INDEX uwm10001  WHERE
               uwm100.policy = wt_uwm200.wt_policy      AND
               uwm100.rencnt = wt_uwm200.wt_rencnt      AND
               uwm100.endcnt = wt_uwm200.wt_endcnt      NO-LOCK NO-ERROR.
    IF AVAIL uwm100 THEN DO:
        FIND FIRST acm001 WHERE acm001.trndat = uwm100.trndat NO-LOCK NO-ERROR.
        IF AVAIL acm001 THEN ASSIGN nv_disc = (uwm100.prem_t * acm001.fee) / 100 .
    END.

    IF NOT AVAIL uwm100 THEN NEXT.

    IF SUBSTRING(wt_uwm200.wt_policy,1,2) >= "11" AND
       SUBSTRING(wt_uwm200.wt_policy,1,2) <= "99"  THEN /* branch 2 หลัก*/
        n_br1  =  SUBSTRING(wt_uwm200.wt_policy,1,2).
    ELSE  /* branch 1 หลัก */
        n_br1  =  SUBSTRING(wt_uwm200.wt_policy,2,1).
    
    n_mr1   =  SUBSTRING(wt_uwm200.wt_policy,7,2).


    FIND FIRST xmm023 USE-INDEX xmm02301 WHERE
               xmm023.branch = uwm100.branch  NO-LOCK NO-ERROR.
    IF AVAILABLE xmm023 THEN  n_bdes   = xmm023.bdes.
                        ELSE  n_bdes   = "".
    ASSIGN
    n_branch = wt_uwm200.wt_branch
    n_dir    = uwm100.dir_ri.

    /*--#3--*/
    IF FIRST-OF(wt_uwm200.wt_policy) THEN  DO:   /*STAT*/
    
        n_br2 = n_br1.
        n_mr2 = n_mr1.
    
        IF  SUBSTRING(uwm100.policy,1,1) = "I" THEN DO:

           FIND XMM600 WHERE XMM600.ACNO = UWM100.AGENT NO-LOCK NO-ERROR.
           IF NOT AVAILABLE XMM600 THEN DO:
               n_insur = " NOT FOUND PRODUCER CODE " + UWM100.AGENT.
           END.
           ELSE DO.
               n_insur =  XMM600.NAME.
           END.
        END.
        ELSE DO:
           n_insur  = " ".
           IF TRIM(uwm100.ntitle) = "" THEN n_insur = "".
           ELSE           n_insur = TRIM(uwm100.ntitle) + " ".
           IF TRIM(uwm100.fname)  = "" THEN n_insur = n_insur + uwm100.name1.
           ELSE           n_insur = n_insur + uwm100.fname
                                  + " " + uwm100.name1.
        END.
    
        FIND FIRST uwm120 USE-INDEX uwm12001      WHERE
                   uwm120.policy = uwm100.policy  AND
                   uwm120.rencnt = uwm100.rencnt  NO-LOCK NO-ERROR.
        IF AVAIL uwm120 THEN DO:
           nv_riskno = uwm120.riskno . /* june */

           IF SUBSTRING(uwm120.policy,3,2) = "90" THEN nvexch = 1.
                                                  ELSE nvexch = uwm120.siexch.
           
           FIND FIRST uwm130 USE-INDEX uwm13001 WHERE 
                uwm130.policy = uwm120.policy  /* AND 
                uwm130.rencnt = uwm120.rencnt   AND
                uwm130.endcnt = uwm120.endcnt   AND
                uwm130.riskgp = uwm120.riskgp   AND
                uwm130.riskno = uwm120.riskno */  NO-LOCK NO-ERROR.
           IF AVAIL uwm130 THEN DO : 
               
               IF uwm130.uom2_c = "FC" THEN nv_flood = uwm130.uom2_v.
               IF uwm130.uom2_c = "WI" THEN nv_storm = uwm130.uom2_v.
               IF uwm130.uom2_c = "EQ" THEN nv_earth = uwm130.uom2_v.
              
               IF uwm130.uom3_c = "FC" THEN nv_flood = uwm130.uom3_v. 
               IF uwm130.uom3_c = "WI" THEN nv_storm = uwm130.uom3_v.
               IF uwm130.uom3_c = "EQ" THEN nv_earth = uwm130.uom3_v.

               IF uwm130.uom4_c = "FC" THEN nv_flood = uwm130.uom4_v.  
               IF uwm130.uom4_c = "WI" THEN nv_storm = uwm130.uom4_v.
               IF uwm130.uom4_c = "EQ" THEN nv_earth = uwm130.uom4_v.
           END.  /* june */

        END.
    
        ASSIGN
           nv_totprem   =  nv_totprem  + uwm100.prem_t
           nv_totpremb  =  nv_totpremb + uwm100.prem_t
           br_totpremb  =  br_totpremb + uwm100.prem_t .
           
           nv_tem       =  0.
    
        IF uwm100.poltyp = "M60"  OR
           uwm100.poltyp = "M61"  OR
           uwm100.poltyp = "M62"  THEN DO:
            FOR EACH uwm307 USE-INDEX uwm30701    WHERE
                     uwm307.policy = uwm100.policy  AND
                     uwm307.rencnt = uwm100.rencnt  AND
                     uwm307.endcnt = uwm100.endcnt  NO-LOCK .
                nv_tem  = nv_tem  + uwm307.mbsi[1].
            END.
        END.
        ELSE DO:
            FOR EACH uwm120 USE-INDEX uwm12001    WHERE
                     uwm120.policy = uwm100.policy  AND
                     uwm120.rencnt = uwm100.rencnt  AND
                     uwm120.endcnt = uwm100.endcnt  NO-LOCK .
                IF AVAIL uwm120 THEN  DO:
                   nv_tem  = nv_tem + (uwm120.sigr - uwm120.sico).
                END.
            END.
        END.
    
        ASSIGN
           nv_sibht   =  nv_sibht  + (nv_tem * nvexch)
           nv_totsi   =  nv_totsi  + (nv_tem * nvexch)
           nv_totsib  =  nv_totsib + (nv_tem * nvexch)
           br_totsib  =  br_totsib + (nv_tem * nvexch).
           
    END. /* IF FIRST-OF(wt_uwm200.wt_policy) */  /*--#3--*/

    /*------------------------------------*/
    RUN PD_sumrico .

    IF LAST-OF(wt_uwm200.wt_policy) THEN DO: /* 0RET */
        ASSIGN
            n_prmf1  =  n_prmf1   * (-1)
            n_prmf2  =  n_prmf2   * (-1)
            n_prmt   =  n_prmt    * (-1)
            n_prms   =  n_prms    * (-1)
            n_prmq   =  n_prmq    * (-1)
            n_prmtfp =  n_prmtfp  * (-1)
            n_prmrq  =  n_prmrq   * (-1)
            n_prmps  =  n_prmps   * (-1)
            n_prmbtr =  n_prmbtr  * (-1)
            n_prmotr =  n_prmotr  * (-1)   
            n_prms8  =  ABSOLUTE(n_prms8)
            n_prmf4  =  n_prmf4   * (-1)
            n_prmftr =  n_prmftr  * (-1).
    
        ASSIGN
            nv_prmf1 = n_prmf1
            nv_prmf2 = n_prmf2
            nv_prmt  = n_prmt
            nv_prmq  = n_prmq
            nv_prmr  = n_prmr.
    
        IF uwm100.poltyp  = "M31"    OR 
           uwm100.poltyp  = "C90"    OR 
           uwm100.poltyp  = "C90C"   OR 
           uwm100.poltyp  = "C90Q"   OR 
           uwm100.poltyp  = "C92"    THEN DO:
        
           ASSIGN 
              nv_gstrat   =  STRING(uwm100.gstrat, "->>9.99").
        END.
        ELSE DO:
           ASSIGN
              nv_gstrat   =  "".
        END.
    END. /* LAST-OF(wt_uwm200.wt_policy) */  /*--#4--*/


END. /* FOR EACH wt_uwm200 */

 
*/


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_Bycomdat cC-Win 
PROCEDURE PD_Bycomdat :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Process By comdate      
------------------------------------------------------------------------------*/
/*
FIND LAST     uwm100 USE-INDEX uwm10008 WHERE
              uwm100.comdat      >= nv_datefr         AND
              uwm100.comdat      <= nv_dateto         AND
              uwm100.dir_ri       = nv_source1        AND
        INDEX(nv_brdes, "," + uwm100.branch) <> 0     AND
    SUBSTRING(uwm100.policy,7,1) >= nv_brokfr         AND
    SUBSTRING(uwm100.policy,7,1) <= nv_brokto         AND
    SUBSTRING(uwm100.policy,3,2) >= SUBSTRING(nv_potypfr,2,2)  AND 
    SUBSTRING(uwm100.policy,3,2) <= SUBSTRING(nv_potypto,2,2)  AND
           ( (nv_rel = "Y" AND  uwm100.releas = YES ) OR
             (nv_rel = "N" AND  uwm100.releas = NO  ) OR
             (nv_rel = "A" AND (uwm100.releas = YES OR uwm100.releas = NO) ) )
    NO-LOCK NO-ERROR .
IF AVAIL uwm100 THEN DO:

   /* BREAK BY SUBSTRING(uwm100.policy,3,2)   /* Policy Type */
          BY uwm100.policy  :*/
    
    DISP uwm100.policy  WITH NO-LABEL TITLE "Printing Report..."  FRAME a  VIEW-AS DIALOG-BOX . /* june */
    n_cnt = n_cnt + 1.

    IF uwm100.dir_ri = YES AND SUBSTRIN(uwm100.policy,1,1) = "I" THEN NEXT. 
    IF uwm100.dir_ri = NO  AND SUBSTRIN(uwm100.policy,1,1) = "D" THEN NEXT. 
    IF SUBSTRING(uwm100.policy,1,1) = "C" THEN NEXT.

    n_bran1     = "".
    n_bran1     = uwm100.branch.
   
    IF SUBSTR(uwm100.policy,1,1) = "I" THEN DO:
         
         IF nv_brdes1 = ""  THEN NEXT.
         IF INDEX(nv_brdes1,",9" + SUBSTRING(uwm100.policy,2,1)) <> 0 THEN 
             n_bran1 = "9" + SUBSTRING(uwm100.policy,2,1). 
         
    END.
    ELSE  DO:    
         IF INDEX("ABCDEFGHIJKLMNOPQRSTUVWXYZ" , nv_branto) <> 0  THEN DO: /*พบตัวอักษรในbranch*/
            IF uwm100.branch < nv_branfr OR uwm100.branch > nv_branto THEN NEXT.
         END.
         ELSE DO:
            IF INTEGER(uwm100.branch) < nv_brn_fr OR INTEGER(uwm100.branch) > nv_brn_to THEN NEXT.
         END.
    END.                                                            
   
    FOR EACH   uwm200   USE-INDEX uwm20001   WHERE
               uwm200.policy  = uwm100.policy AND
               uwm200.rencnt  = uwm100.rencnt AND 
               uwm200.endcnt  = uwm100.endcnt AND
               uwm200.csftq  <> "C"           NO-LOCK
    BREAK  BY uwm200.policy
           BY uwm200.csftq
           BY uwm200.c_no
           BY uwm200.c_enno:

        n_cnt1 = n_cnt1 + 1.
        
        CREATE wt_uwm200.
        ASSIGN
           wt_policy   =   uwm200.policy
           wt_rencnt   =   uwm200.rencnt 
           wt_endcnt   =   uwm200.endcnt
           wt_c_enct   =   uwm200.c_enct
           wt_csftq    =   uwm200.csftq
           wt_rico     =   uwm200.rico
           wt_dept     =   uwm200.dept
           wt_c_no     =   uwm200.c_no
           wt_c_enno   =   uwm200.c_enno
           wt_rip1ae   =   uwm200.rip1ae
           wt_rip2ae   =   uwm200.rip2ae
           wt_rip1     =   uwm200.rip1
           wt_rip2     =   uwm200.rip2
           wt_recip    =   uwm200.recip
           wt_ricomm   =   uwm200.ricomm
           wt_riexp    =   uwm200.riexp 
           wt_trndat   =   uwm200.trndat
           wt_com2gn   =   uwm200.com2gn
           wt_ristmp   =   uwm200.ristmp
           wt_prntri   =   uwm200.prntri
           wt_thpol    =   uwm200.thpol 
           wt_c_year   =   uwm200.c_year
           wt_trtyri   =   uwm200.trtyri
           wt_docri    =   uwm200.docri 
           wt_fptr01   =   uwm200.fptr01
           wt_bptr01   =   uwm200.bptr01
           wt_fptr02   =   uwm200.fptr02
           wt_bptr02   =   uwm200.bptr02
           wt_fptr03   =   uwm200.fptr03
           wt_bptr03   =   uwm200.bptr03
           wt_dreg_p   =   uwm200.dreg_p
           wt_curbil   =   uwm200.curbil
           wt_reg_no   =   uwm200.reg_no
           wt_bordno   =   uwm200.bordno
           wt_panel    =   uwm200.panel 
           wt_riendt   =   uwm200.riendt
           wt_branch   =   n_bran1. 

    END.    /*--- END FOR EACH UWM200 ---*/
END.    /*--- END FOR EACH UWM100 ---*/
*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_Bytrndat cC-Win 
PROCEDURE PD_Bytrndat :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Process By trandate      
------------------------------------------------------------------------------*/
/*
    FOR EACH      uwm100 USE-INDEX uwm10008 WHERE
              uwm100.trndat      >= nv_datefr        AND
              uwm100.trndat      <= nv_dateto        AND
              uwm100.dir_ri       = nv_source1       AND  
        INDEX(nv_brdes, "," + uwm100.branch) <> 0    AND
    SUBSTRING(uwm100.policy,7,1) >= nv_brokfr        AND
    SUBSTRING(uwm100.policy,7,1) <= nv_brokto        AND 
    SUBSTRING(uwm100.policy,3,2) >= SUBSTRING(nv_potypfr,2,2)  AND 
    SUBSTRING(uwm100.policy,3,2) <= SUBSTRING(nv_potypto,2,2)  AND
            ((nv_rel = "Y" AND  uwm100.releas = YES) OR
             (nv_rel = "N" AND  uwm100.releas = NO)  OR
             (nv_rel = "A" AND (uwm100.releas = YES  OR uwm100.releas = NO))) NO-LOCK . 
                                      
     /*   BREAK BY SUBSTRING(uwm100.policy,3,2)   /* Policy Type */
           BY uwm100.policy  :  */
    
    DISP uwm100.policy  WITH NO-LABEL TITLE "Printing Report..."  FRAME a  VIEW-AS DIALOG-BOX . /* june */
    n_cnt = n_cnt + 1.

    IF uwm100.dir_ri = YES AND SUBSTRIN(uwm100.policy,1,1) = "I" THEN NEXT. 
    IF uwm100.dir_ri = NO  AND SUBSTRIN(uwm100.policy,1,1) = "D" THEN NEXT. 
    IF SUBSTRING(uwm100.policy,1,1) = "C" THEN NEXT.

    n_bran1     = "".
    n_bran1     = uwm100.branch.

    IF SUBSTR(uwm100.policy,1,1) = "I" THEN DO:
         
         IF nv_brdes1 = ""  THEN NEXT.
         IF INDEX(nv_brdes1,",9" + SUBSTRING(uwm100.policy,2,1)) <> 0 THEN 
             n_bran1 = "9" + SUBSTRING(uwm100.policy,2,1). 
         
    END.
    ELSE  DO:    
         IF INDEX("ABCDEFGHIJKLMNOPQRSTUVWXYZ" , nv_branto) <> 0  THEN DO: /*พบตัวอักษรในbranch*/
            IF uwm100.branch < nv_branfr OR uwm100.branch > nv_branto THEN NEXT.
         END.
         ELSE DO:
            IF INTEGER(uwm100.branch) < nv_brn_fr OR INTEGER(uwm100.branch) > nv_brn_to THEN NEXT.
         END.
    END.
    
    FIND FIRST  uwm200   USE-INDEX uwm20001   WHERE
                uwm200.policy  = uwm100.policy AND
                uwm200.rencnt  = uwm100.rencnt AND 
                uwm200.endcnt  = uwm100.endcnt AND
                uwm200.csftq   = "F"          NO-LOCK NO-ERROR.
    IF AVAIL uwm200 THEN DO:
    /*    BREAK  BY uwm200.policy
           BY uwm200.csftq
           BY uwm200.c_no
           BY uwm200.c_enno: */

        n_cnt1 = n_cnt1 + 1.

      /*  FIND LAST buwm100 WHERE buwm100.trndat = uwm100.trndat AND
                                buwm100.policy = uwm100.policy AND 
                                buwm100.rencnt = uwm100.rencnt AND
                                buwm100.endcnt = uwm100.endcnt AND 
                                buwm100.polsta = "IF"          OR
                                buwm100.polsta = ""            NO-LOCK NO-ERROR.
        IF AVAIL buwm100 THEN DO:
            FIND FIRST wfuwm100 WHERE wfuwm100.trndat  = buwm100.trndat AND
                                      wfuwm100.policy  = buwm100.policy AND
                                      wfuwm100.rencnt  = buwm100.rencnt AND
                                      wfuwm100.endcnt  = buwm100.endcnt NO-LOCK NO-ERROR.
            IF NOT AVAIL wfuwm100 THEN DO:
                CREATE wfuwm100 .
                ASSIGN
                wfuwm100.trndat  = buwm100.trndat
                wfuwm100.policy  = buwm100.policy
                wfuwm100.rencnt  = buwm100.rencnt
                wfuwm100.endcnt  = buwm100.endcnt
                /*wfuwm100.sigr    = buwm100.sigr_p 
                wfuwm100.prem    = n_premt  */
                wfuwm100.comm    = buwm100.com1_t  .
            END.
        END.*/
    END.  /* uwm200 */
END. /* uwm100 */

/*----------- end june ---------------*/


        /*CREATE wt_uwm200.
        ASSIGN
           wt_policy   =   uwm200.policy
           wt_rencnt   =   uwm200.rencnt 
           wt_endcnt   =   uwm200.endcnt
           wt_c_enct   =   uwm200.c_enct
           wt_csftq    =   uwm200.csftq
           wt_rico     =   uwm200.rico
           wt_dept     =   uwm200.dept
           wt_c_no     =   uwm200.c_no
           wt_c_enno   =   uwm200.c_enno
           wt_rip1ae   =   uwm200.rip1ae
           wt_rip2ae   =   uwm200.rip2ae
           wt_rip1     =   uwm200.rip1
           wt_rip2     =   uwm200.rip2
           wt_recip    =   uwm200.recip
           wt_ricomm   =   uwm200.ricomm
           wt_riexp    =   uwm200.riexp 
           wt_trndat   =   uwm200.trndat
           wt_com2gn   =   uwm200.com2gn
           wt_ristmp   =   uwm200.ristmp
           wt_prntri   =   uwm200.prntri
           wt_thpol    =   uwm200.thpol 
           wt_c_year   =   uwm200.c_year
           wt_trtyri   =   uwm200.trtyri
           wt_docri    =   uwm200.docri 
           wt_fptr01   =   uwm200.fptr01
           wt_bptr01   =   uwm200.bptr01
           wt_fptr02   =   uwm200.fptr02
           wt_bptr02   =   uwm200.bptr02
           wt_fptr03   =   uwm200.fptr03
           wt_bptr03   =   uwm200.bptr03
           wt_dreg_p   =   uwm200.dreg_p
           wt_curbil   =   uwm200.curbil
           wt_reg_no   =   uwm200.reg_no
           wt_bordno   =   uwm200.bordno
           wt_panel    =   uwm200.panel 
           wt_riendt   =   uwm200.riendt
           wt_branch   =   n_bran1 .
       
    END.    /*--- END FOR EACH UWM200 ---*/

    RUN PD_broker.
    RUN PD_DetailPrem. 

  END.    /*--- END for each UWM100 ---*/   

OUTPUT STREAM ns1 CLOSE. */

/*/* ------------ put sum  ------------------ */

OUTPUT STREAM ns2 TO VALUE (nv_output + "_sum.slk") .  
nv_txt = "Outward Proportional Treaty".
PUT STREAM ns2
nv_txt                SKIP
"Class of Business"   ";"                     
"Reinsurer Code"      ";"     
"Reinsurer Name"      ";"               
"Sum Reinsured ceded to reinsurer"      ";"   
"Outward Rein Premium"                  ";"           
"Outward Rein Comm"          SKIP.

FOR EACH wfsum NO-LOCK  BREAK BY wfsum.CLASS 
                              BY wfsum.recode
                              BY wfsum.rename .


    PUT STREAM ns2
    SKIP
    wfsum.CLASS      ";"
    wfsum.recode     ";"
    wfsum.rename     ";"
    wfsum.sumreins   ";"
    wfsum.outprm     ";"
    wfsum.outcom     SKIP.
END.                                     

OUTPUT STREAM ns2 CLOSE.  */

fi_disp = "   .. complete ..  ".
DISP  fi_disp  WITH FRAME frmain .


*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_claim_com cC-Win 
PROCEDURE PD_claim_com :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
fi_disp = "   Processing  ...! " .
DISP  fi_disp  WITH FRAME frmain .

FOR EACH Wclp :
    DELETE  Wclp.
END.

FOR EACH Wfsum :
    DELETE  Wfsum.
END.

FOR EACH CLM130 USE-INDEX CLM13003 WHERE
             CLM130.trndat      >= nv_datefr  AND
             CLM130.Entdat      >= nv_datefr  AND
             CLM130.Entdat      <= nv_dateto  AND
            (CLM130.Trnty1       = "X"        OR
             CLM130.Trnty1       = "W")       AND
           ( (nv_rel = "Y"   AND  clm130.releas = YES ) OR
             (nv_rel = "N"   AND  clm130.releas = NO  ) OR
             (nv_rel = "A"   AND (clm130.releas = YES   OR clm130.releas = NO) ) )   
              NO-LOCK .
  DISP clm130.claim  WITH NO-LABEL TITLE "Printing Report..."  FRAME a  VIEW-AS DIALOG-BOX . /* june */

  IF CLM130.NETL_D = 0  OR CLM130.NETL_D = ? THEN NEXT .

  FIND CLM100 USE-INDEX CLM10001     WHERE
       CLM100.CLAIM  = CLM130.CLAIM  NO-LOCK NO-ERROR NO-WAIT.

  IF AVAILABLE CLM100 THEN DO:  
     
    FOR EACH riroprm USE-INDEX riroprm01 WHERE 
             riroprm.policy  = clm100.policy    AND 
             riroprm.rencnt  = clm100.rencnt    AND 
             riroprm.endcnt  = clm100.endcnt    AND 
             riroprm.riskgp  = clm100.riskgp    AND 
             riroprm.riskno  = clm100.riskno    AND 
             riroprm.rirotyp = NO               NO-LOCK .

        CREATE WCLM130.
        ASSIGN
          WCLM130.POLICY = CLM100.POLICY
          WCLM130.CLAIM  = CLM130.CLAIM
          WCLM130.ENTDAT = CLM130.ENTDAT
          WCLM130.TRNDAT = CLM130.TRNDAT
          WCLM130.TRNTY1 = CLM130.TRNTY1
          WCLM130.DOCNO  = CLM130.DOCNO
          WCLM130.CLITEM = CLM130.CLITEM
          WCLM130.CLMANT = CLM130.CLMANT
          WCLM130.CPC_CD = CLM130.CPC_CD
          WCLM130.NETL_D = CLM130.NETL_D
          WCLM130.RELEAS = CLM130.RELEAS
          wclm130.rico   = riroprm.ricosub
          wclm130.cedper = riroprm.cedper .
    
          IF (SUBSTR(CLM100.POLICY,1,1) = "D" OR   SUBSTR(CLM100.POLICY,1,1) = "I") THEN 
          ASSIGN WCLM130.BRANCH = SUBSTRING(CLM100.POLICY,2,1) 
                 WCLM130.DIR_RI = SUBSTRING(CLM100.POLICY,1,1).
          ELSE IF (SUBSTRING(CLM100.POLICY,1,2)  >= "10" AND  SUBSTRING(CLM100.POLICY,1,2)  <= "99") THEN
          ASSIGN WCLM130.BRANCH = SUBSTRING(CLM100.POLICY,1,2) 
                 WCLM130.DIR_RI = "D".   
          
          IF WCLM130.DIR_RI = "I" AND (WCLM130.BRANCH >= "1" AND WCLM130.BRANCH <= "8") THEN DO:
              WCLM130.BRANCH = "9" + WCLM130.BRANCH.
          END.
       
        FIND FIRST UWM100   WHERE
            UWM100.POLICY = CLM100.POLICY   NO-LOCK NO-ERROR NO-WAIT.
        IF AVAILABLE UWM100 THEN DO :
            ASSIGN
           WCLM130.POLTYP = UWM100.POLTYP
           nv_agent       = uwm100.agent 
           nv_recode      = uwm100.insref .
    
            FIND XMM600 WHERE XMM600.ACNO = riroprm.ricosub NO-LOCK NO-ERROR.
            IF NOT AVAILABLE XMM600 THEN DO:
               wclm130.riconam = " NOT FOUND PRODUCER CODE " + UWM100.AGENT.
            END.
            ELSE DO:
               wclm130.riconam =  xmm600.NAME.
            END.
        END.    
    END.  /*---end each riroprm ---*/
  END. /* clm 100 */
END.  /* FOR EACH CLM130 */


FIND FIRST WCLM130 NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAILABLE WCLM130 THEN DO:
  HIDE MESSAGE NO-PAUSE.
  MESSAGE "Not found Data Process".
  
END.


RUN PD_processclm .
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_claim_trn cC-Win 
PROCEDURE PD_claim_trn :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
fi_disp = "   Processing  ...! " .
DISP  fi_disp  WITH FRAME frmain .

FOR EACH Wclp :
    DELETE  Wclp.
END.

FOR EACH Wfsum :
    DELETE  Wfsum.
END.

FOR EACH CLM130 USE-INDEX CLM13003 WHERE
             CLM130.Trndat      >= nv_datefr  AND
             CLM130.Entdat      >= nv_datefr  AND
             CLM130.Entdat      <= nv_dateto  AND
            (CLM130.Trnty1       = "X"        OR
             CLM130.Trnty1       = "W")       AND
   SUBSTR(clm130.claim,1,1)  = fi_source      AND  
   SUBSTR(clm130.claim,3,2) >= SUBSTR(nv_potypfr,2,2)  AND 
   SUBSTR(clm130.claim,3,2) <= SUBSTR(nv_potypto,2,2)  AND

           ( (nv_rel = "Y"   AND  clm130.releas = YES ) OR
             (nv_rel = "N"   AND  clm130.releas = NO  ) OR
             (nv_rel = "A"   AND (clm130.releas = YES   OR clm130.releas = NO) ) )   
              NO-LOCK .
  DISP clm130.claim  WITH NO-LABEL TITLE "Printing Report..."  FRAME a  VIEW-AS DIALOG-BOX . /* june */

  IF CLM130.NETL_D = 0  OR CLM130.NETL_D = ? THEN NEXT .

  FIND CLM100 USE-INDEX CLM10001     WHERE
       CLM100.CLAIM  = CLM130.CLAIM  NO-LOCK NO-ERROR NO-WAIT.

  IF AVAILABLE CLM100 THEN DO:  
     
    FOR EACH riroprm USE-INDEX riroprm01 WHERE 
             riroprm.policy  = clm100.policy    AND 
             riroprm.rencnt  = clm100.rencnt    AND 
             riroprm.endcnt  = clm100.endcnt    AND 
             riroprm.riskgp  = clm100.riskgp    AND 
             riroprm.riskno  = clm100.riskno    AND 
             riroprm.rirotyp = NO               NO-LOCK .

        CREATE WCLM130.
        ASSIGN
          WCLM130.POLICY = CLM100.POLICY
          WCLM130.CLAIM  = CLM130.CLAIM
          WCLM130.ENTDAT = CLM130.ENTDAT
          WCLM130.TRNDAT = CLM130.TRNDAT
          WCLM130.TRNTY1 = CLM130.TRNTY1
          WCLM130.DOCNO  = CLM130.DOCNO
          WCLM130.CLITEM = CLM130.CLITEM
          WCLM130.CLMANT = CLM130.CLMANT
          WCLM130.CPC_CD = CLM130.CPC_CD
          WCLM130.NETL_D = CLM130.NETL_D
          WCLM130.RELEAS = CLM130.RELEAS
          wclm130.rico   = riroprm.ricosub
          wclm130.cedper = riroprm.cedper .
        
    
          IF (SUBSTR(CLM100.POLICY,1,1) = "D" OR   SUBSTR(CLM100.POLICY,1,1) = "I") THEN 
          ASSIGN WCLM130.BRANCH = SUBSTRING(CLM100.POLICY,2,1) 
                 WCLM130.DIR_RI = SUBSTRING(CLM100.POLICY,1,1).
          ELSE IF (SUBSTRING(CLM100.POLICY,1,2)  >= "10" AND  SUBSTRING(CLM100.POLICY,1,2)  <= "99") THEN
          ASSIGN WCLM130.BRANCH = SUBSTRING(CLM100.POLICY,1,2) 
                 WCLM130.DIR_RI = "D".   
          
          IF WCLM130.DIR_RI = "I" AND (WCLM130.BRANCH >= "1" AND WCLM130.BRANCH <= "8") THEN DO:
              WCLM130.BRANCH = "9" + WCLM130.BRANCH.
          END.
       
        FIND FIRST UWM100   WHERE
            UWM100.POLICY = CLM100.POLICY   NO-LOCK NO-ERROR NO-WAIT.
        IF AVAILABLE UWM100 THEN DO :
            ASSIGN
           WCLM130.POLTYP = UWM100.POLTYP
           nv_agent       = uwm100.agent 
           nv_recode      = uwm100.insref .
    
            FIND XMM600 WHERE XMM600.ACNO = riroprm.ricosub NO-LOCK NO-ERROR.
            IF NOT AVAILABLE XMM600 THEN DO:
               wclm130.riconam = " NOT FOUND PRODUCER CODE " + UWM100.AGENT.
            END.
            ELSE DO:
               wclm130.riconam =  xmm600.NAME.
            END.
        END.    
    END.  /*---end each riroprm ---*/
  END. /* clm 100 */
END.  /* FOR EACH CLM130 */


FIND FIRST WCLM130 NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAILABLE WCLM130 THEN DO:
  HIDE MESSAGE NO-PAUSE.
  MESSAGE "Not found Data Process".
  
END.

RUN PD_processclm .

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_DetailPrem cC-Win 
PROCEDURE PD_DetailPrem :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
ASSIGN nv_comdat = ?.

 FIND FIRST buwm100 USE-INDEX uwm10001 
                        WHERE buwm100.policy = uwm100.policy AND        
                              buwm100.rencnt = uwm100.rencnt AND        
                              buwm100.endcnt = uwm100.endcnt NO-LOCK NO-ERROR.  
 IF AVAIL buwm100 THEN ASSIGN nv_comdat = buwm100.comdat.
 ELSE ASSIGN nv_comdat = ?.
    
 /*--------- june ----------*/
    FIND FIRST uwm120 WHERE uwm120.policy = uwm100.policy AND 
                            uwm120.rencnt = uwm100.rencnt AND 
                            uwm120.endcnt = uwm100.endcnt NO-LOCK NO-ERROR .
    IF AVAIL uwm120 THEN DO : 

        FOR EACH riroprm USE-INDEX riroprm01 WHERE 
                 riroprm.policy  = uwm120.policy    AND 
                 riroprm.rencnt  = uwm120.rencnt    AND 
                 riroprm.endcnt  = uwm120.endcnt    AND 
                 riroprm.riskgp  = uwm120.riskgp    AND 
                 riroprm.riskno  = uwm120.riskno    AND  
                 riroprm.rirotyp = NO               NO-LOCK .
        
             ASSIGN
            nv_agent       = uwm100.agent 
            nv_recode      = riroprm.ricosub .
                                       
          FIND XMM600 WHERE XMM600.ACNO = riroprm.ricosub NO-LOCK NO-ERROR.
          IF NOT AVAILABLE XMM600 THEN DO:
             nv_rename = " NOT FOUND PRODUCER CODE " + UWM100.AGENT.
          END.
          ELSE DO:
             nv_rename =  xmm600.NAME.
          END.  
        END.


         /* /*--------------- % sum -----------------*/

         FIND FIRST  uwd200 USE-INDEX uwd20001 WHERE 
                     uwd200.policy  = uwm120.policy    AND 
                     uwd200.rencnt  = uwm120.rencnt    AND 
                     uwd200.endcnt  = uwm120.endcnt    AND 
                     uwd200.riskgp  = uwm120.riskgp    AND 
                     uwd200.riskno  = uwm120.riskno    NO-LOCK NO-ERROR .
         IF AVAIL uwd200 THEN ASSIGN nv_risi = uwd200.risi_p .
         

        /*---------------------- % sum ------------*/ */
  

      /* ASSIGN
           nv_sumreins = nv_sibht * nv_risi 
           nv_outprm   = uwm100.prem_t * nv_risi  
           nv_outcom   = uwm100.prem_t * wt_uwm200.wt_rip1 .  */      
     /* -------- june --------- */
        n_cnt1 = n_cnt1 + 1.

        PUT STREAM ns1
      n_branch  ";"
      uwm100.poltyp   FORMAT "X(4)"          ";" 
      uwm100.trndat   FORMAT "99/99/9999"    ";"
      nv_comdat       FORMAT "99/99/9999"    ";"  
      uwm100.policy   FORMAT "X(13)"         ";"
                /* june */
      nv_riskno       FORMAT ">>9"        ";"  
      nv_agent        FORMAT "x(10)"      ";" 
      nv_rename       FORMAT "x(50)"      ";" 
      nv_recode       FORMAT "x(10)"      ";" 
          /* june */
      n_insur         FORMAT "X(50)"      ";"      
      nv_sibht        FORMAT "->>>,>>>,>>>,>>9.99" ";"
                 /* june */
      nv_flood        FORMAT "->>>,>>>,>>>,>>9.99"  ";"
      nv_storm        FORMAT "->>>,>>>,>>>,>>9.99"  ";"
      nv_earth        FORMAT "->>>,>>>,>>>,>>9.99"  ";"
          /* june */
      uwm100.prem_t   FORMAT "->,>>>,>>>,>>9.99"   ";"    
      nv_disc         FORMAT "->>>,>>>,>>>,>>9.99" ";"   /* june  */
      p_f1            FORMAT ">>9.99"  ";"
      n_sumf1         FORMAT "->>>,>>>,>>>,>>9.99" ";"
      n_prmf1         FORMAT "->,>>>,>>>,>>9.99"   ";"
      nv_gstrat       FORMAT "X(6)" ";"
      p_f2            FORMAT ">>9.99"  ";"
      n_sumf2         FORMAT "->>>,>>>,>>>,>>9.99" ";"
      n_prmf2         FORMAT "->,>>>,>>>,>>9.99"   ";"
      nv_gstrat       FORMAT "X(6)" ";"
      p_t             FORMAT ">>9.99"  ";"
      n_sumt          FORMAT "->>>,>>>,>>>,>>9.99" ";"
      n_prmt          FORMAT "->,>>>,>>>,>>9.99"   ";"
      nv_gstrat       FORMAT "X(6)" ";"   /* june  */
    
      p_s             FORMAT ">>9.99"  ";"
      n_sums          FORMAT "->>>,>>>,>>>,>>9.99" ";"
      n_prms          FORMAT "->,>>>,>>>,>>9.99"   ";"
    
      p_q             FORMAT ">>9.99"  ";"
      n_sumq          FORMAT "->>>,>>>,>>>,>>9.99" ";"
      n_prmq          FORMAT "->,>>>,>>>,>>9.99"   ";"
      nv_gstrat       FORMAT "X(6)" ";"
      p_tfp           FORMAT ">>9.99"  ";"
      n_sumtfp        FORMAT "->>>,>>>,>>>,>>9.99" ";"
      n_prmtfp        FORMAT "->,>>>,>>>,>>9.99"   ";"     
      p_rq            FORMAT ">>9.99"  ";"
      n_sumrq         FORMAT "->>>,>>>,>>>,>>9.99" ";"
      n_prmrq         FORMAT "->,>>>,>>>,>>9.99"   ";"      
      p_r             FORMAT ">>9.99"  ";"
      n_sumr          FORMAT "->>>,>>>,>>>,>>9.99" ";"
      n_prmr          FORMAT "->,>>>,>>>,>>9.99"   ";"
      nv_gstrat       FORMAT "X(6)" ";"
      p_ps            FORMAT ">>9.99"  ";"
      n_sumps         FORMAT "->>>,>>>,>>>,>>9.99" ";"
      n_prmps         FORMAT "->,>>>,>>>,>>9.99"   ";"
      p_btr           FORMAT ">>9.99"  ";"
      n_sumbtr        FORMAT "->>>,>>>,>>>,>>9.99" ";"
      n_prmbtr        FORMAT "->,>>>,>>>,>>9.99"   ";"
      p_otr           FORMAT ">>9.99"  ";"
      n_sumotr        FORMAT "->>>,>>>,>>>,>>9.99" ";"
      n_prmotr        FORMAT "->,>>>,>>>,>>9.99"   ";"
      p_s8            FORMAT ">>9.99"  ";"
      n_sums8         FORMAT "->>>,>>>,>>>,>>9.99" ";"
      n_prms8         FORMAT "->,>>>,>>>,>>9.99"   ";"
      p_f4            FORMAT ">>9.99"  ";"
      n_sumf4         FORMAT "->>>,>>>,>>>,>>9.99" ";"
      n_prmf4         FORMAT "->,>>>,>>>,>>9.99"   ";"      
      p_ftr           FORMAT ">>9.99"  ";"
      n_sumftr        FORMAT "->>>,>>>,>>>,>>9.99" ";"
      n_prmftr        FORMAT "->,>>>,>>>,>>9.99"   ";"   .
     
    
    END. /* uwm120 */ 
    

        FOR EACH wrk0f:
    
            FIND xmm600 WHERE xmm600.acno = wrk0f.rico NO-LOCK NO-ERROR.
            IF AVAILABLE xmm600 THEN DO:
                 IF (xmm600.clicod = "RD") OR (xmm600.clicod = "RB") THEN
                    ASSIGN
                      n_rb_pf   = n_rb_pf  + wrk0f.pf
                      n_rb_sum  = n_rb_sum + wrk0f.sumf
                      n_rb_prm  = n_rb_prm + (wrk0f.prmf * (-1)) 
                      n_rb_com  = n_rb_com + ((n_rb_prm * nv_comfac) / 100) .   /* june */
                 
                 ELSE IF (xmm600.clicod = "RF") OR
                         (xmm600.clicod = "RA") THEN /*--เพิ่มเช็ค RA เนื่องจากมีการตั้ง code งาน fac ขึ้นมาใหม่ Lukkana M. A51-0201 04/09/2008 --*/
                    ASSIGN
                       n_rf_pf   = n_rf_pf  + wrk0f.pf
                       n_rf_sum  = n_rf_sum + wrk0f.sumf
                       n_rf_prm  = n_rf_prm + (wrk0f.prmf * (-1)) 
                       n_rf_com  = n_rf_com + ((n_rf_prm * nv_comfac) / 100) .   /* june */
            END.
        END.
    
        PUT STREAM ns1
           n_rb_pf     FORMAT ">>9.99"              ";"
           n_rb_sum    FORMAT "->>>,>>>,>>>,>>9.99" ";"
           n_rb_prm    FORMAT "->,>>>,>>>,>>9.99"   ";"
           n_rb_com    FORMAT "->,>>>,>>>,>>9.99"   ";"    /* june */

           n_rf_pf     FORMAT ">>9.99"              ";"
           n_rf_sum    FORMAT "->>>,>>>,>>>,>>9.99" ";"
           n_rf_prm    FORMAT "->,>>>,>>>,>>9.99"   ";"
           n_rf_com    FORMAT "->,>>>,>>>,>>9.99"   ";"  SKIP.  /* june */
           

    
        FOR EACH wrk0f:
            DELETE wrk0f.
        END.
    /*
         ASSIGN
            nv_sibht    = 0 
            p_f1        = 0   p_s      = 0      p_rq     = 0   p_tfp    = 0
            n_sumf1     = 0   n_sums   = 0      n_sumrq  = 0   n_sumtfp = 0
            n_prmf1     = 0   n_prms   = 0      n_prmrq  = 0   n_prmtfp = 0
            p_f2        = 0   p_q      = 0      p_r      = 0   p_t      = 0
            n_sumf2     = 0   n_sumq   = 0      n_sumr   = 0   n_sumt   = 0
            n_prmf2     = 0   n_prmq   = 0      n_prmr   = 0   n_prmt   = 0
            p_ps        = 0   n_sumps  = 0      n_prmps  = 0          
            p_btr       = 0   n_sumbtr = 0      n_prmbtr = 0
            p_otr       = 0   n_sumotr = 0      n_prmotr = 0        
            p_s8        = 0   n_sums8  = 0      n_prms8  = 0
            p_f4        = 0   n_sumf4  = 0      n_prmf4  = 0
            p_ftr       = 0   n_sumftr = 0      n_prmftr = 0
            n_rb_pf     = 0   n_rb_sum = 0      n_rb_prm = 0
            n_rf_pf     = 0   n_rf_sum = 0      n_rf_prm = 0  .*/
       
/*
            /* june */
        ASSIGN

      nv_riskno = 0 
      nv_agent  = "" 
      nv_rename = ""
      nv_recode = "" 
      nv_flood  = 0 
      nv_storm  = 0 
      nv_earth  = 0 
      n_rb_com  = 0 
      n_rf_com  = 0 
      nv_comfac = 0 .  */

/*/* ------------  sum  ------------------ */

  FIND FIRST wfsum WHERE wfsum.CLASS  = uwm100.poltyp     AND
                         wfsum.recode = nv_recode         AND
                         wfsum.rename = nv_rename         NO-LOCK NO-ERROR . 

   IF NOT AVAIL wfsum THEN DO:
   CREATE wfsum.
   ASSIGN
       wfsum.CLASS     =  uwm100.poltyp 
       wfsum.recode    =  nv_recode 
       wfsum.rename    =  nv_rename    
       wfsum.sumreins  =  nv_sumreins 
       wfsum.outprm    =  nv_outprm     
       wfsum.outcom    =  nv_outcom   .
   END.
   ELSE DO:
   ASSIGN
       wfsum.sumreins   = wfsum.sumreins + nv_sumreins
       wfsum.outprm     = wfsum.outprm   + nv_outprm      
       wfsum.outcom     = wfsum.outcom   + nv_outcom  .
   END.   
*/

*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_exportfacpol cC-Win 
PROCEDURE pd_exportfacpol :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DEF VAR nv_coins LIKE tfacre.coins.


nv_occup = "".
nv_output = nv_output + ".slk".

ASSIGN nv_oicline = ""
       nv_uwline = ""
       nv_uwlinedesc = "".

OUTPUT TO VALUE(nv_output) /*NO-ECHO*/ .  /*"u:\tfacre.txt".*/ 
/*
DEF VAR nv_name AS CHAR.
DEF VAR rico_name AS CHAR.
DEF VAR nv_polsta AS CHAR.  */

EXPORT DELIMITER "|" 
"*-- Statement Premium Outward --*".
EXPORT DELIMITER "|"
  "Trans.Date From: " fi_datefr  "to: " fi_dateto .
EXPORT DELIMITER "|".
EXPORT DELIMITER "|"

     "Branch"
     "Line"
     "Trn Date"
     "Com Date"
     "Exp Date"
     "Policy"
     "Endorse No."
     "Broker"
     "NO.of Risk"
     "RICO Code"
     "RICO Name"
     "Reinsurer Code"
     "Reinsurer Name"
     "Policy Status"
     "Co Ins"
     "Co Per"
      /* june */
     "Co STY"
     "RI FAC" 
     "RI TTY"  
     "RET"
     /* june */
     "Policy SumInsured"  
     "Policy Premium"
     "Ri SumInsured" 
     "Ri Premium"
     "Ri Comm"
     "Policy Disc"
     "RI Disc"
     "Flood Cover"  
     "Windstorm"    
     "Earthquake"  
     "Licence No" 
     "Occupation Cl"
     "OIC Line" 
     "UW Line" 
     "Line Description" 
     "Producer"
     "Producer Name"
     "Cedant Code"
     "Cedant Name".
    /* "Disc"  . /* june */*/

FOR EACH tfacre WHERE tfacre.asdat = nv_asdat NO-LOCK
    BREAK BY tFacRe.bran 
          BY SUBSTR(tfacre.policy,3,2)
          BY tfacre.policy
          BY tFacRe.endcnt .

    IF tfacre.coins = YES THEN
       nv_coins = YES.
    ELSE
       nv_coins = NO.
    ASSIGN nv_oicline = ""
           nv_uwline = ""
           nv_uwlinedesc = "".

    nv_uwline = SUBSTR(tfacre.policy,3,2).

    RUN pd_line.

    FOR EACH uwm304 NO-LOCK WHERE uwm304.policy = tfacre.policy AND
                                  uwm304.rencnt = tfacre.rencnt AND 
                                  uwm304.endcnt = tfacre.endcnt 
                            BREAK BY uwm304.policy 
                                  BY uwm304.rencnt 
                                  BY uwm304.endcnt. 

        IF FIRST-OF (uwm304.policy) THEN ASSIGN nv_occup = uwm304.occupn.
        ELSE nv_occup = nv_occup + "/" + uwm304.occupn.
    END.
    
    FOR EACH tfacredet WHERE 
             tfacredet.asdat  = tfacre.asdat  AND
             tfacredet.policy = tfacre.policy AND 
             tfacredet.rencnt = tfacre.rencnt AND
             tfacredet.endcnt = tfacre.endcnt NO-LOCK . 

        IF tfacredet.csftq = "T" THEN NEXT.
        IF tfacredet.csftq = "D" THEN NEXT.
        IF tfacredet.csftq = "S" THEN NEXT.

        ASSIGN
        nv_name   = "" 
        rico_name = ""
        nv_agtreg = ""  
        nv_si_p   = 0 . 

        IF tfacredet.SubBroker = NO THEN DO:
            
            FIND LAST uwm100  WHERE uwm100.policy = tfacredet.policy   NO-LOCK NO-ERROR.
            IF AVAILABLE uwm100 THEN DO: 
                ASSIGN nv_polsta     = uwm100.polsta.

                FIND FIRST acm001 USE-INDEX acm00101 WHERE 
                           acm001.trnty1 = uwm100.trty11 AND 
                           acm001.docno  = uwm100.docno1 NO-LOCK NO-ERROR.
                IF AVAIL acm001 THEN DO:

                   ASSIGN
                      tFacRe.poldisc  = (acm001.fee * tFacRedet.risi_p) / 100
                      tFacRe.ridisc   = 0 .
                END.
                ELSE ASSIGN 
                    tFacRe.poldisc  = 0      
                    tFacRe.ridisc   = 0. 

                /*------aaaaaaaaa-------*/
                ASSIGN nn_acno = ""
                       nn_acnoname = ""
                       nn_cedco = ""
                       nn_cedname = "".

                FIND xmm600 NO-LOCK WHERE xmm600.acno = uwm100.acno1 NO-ERROR.
                IF AVAILABLE xmm600 THEN DO:
                
                   ASSIGN nn_acno          = xmm600.acno
                          nn_acnoname      = xmm600.NAME.
                END.
                ELSE ASSIGN nn_acno        = ""
                            nn_acnoname    = "".

                FIND xmm600 NO-LOCK WHERE xmm600.acno = uwm100.cedco NO-ERROR.
                IF AVAILABLE xmm600 THEN DO:
                
                   ASSIGN nn_cedco         = xmm600.acno
                          nn_cedname       = xmm600.NAME.
                END.
                ELSE ASSIGN nn_acno        = ""
                            nn_acnoname    = "".
                /*-----------------------*/


            END.                                
            ELSE  ASSIGN nv_polsta = "".   

            FIND xmm600 NO-LOCK WHERE xmm600.acno = tfacredet.rico NO-ERROR.
            IF AVAILABLE xmm600 THEN DO:

               ASSIGN nv_name      = xmm600.NAME
                      nv_agtreg    = xmm600.agtreg .

               IF SUBSTRING(xmm600.acno,1,2) = "0D" OR SUBSTRING(xmm600.acno,1,2) = "0A"   THEN DO:   
                  nv_agtreg = "TIC-00" + nv_agtreg.                                                   
               END.                                                                                           
               IF SUBSTRING(xmm600.acno,1,2) = "0F"  THEN DO:                                             
                   nv_agtreg = "FIC-00" + nv_agtreg.                                                   
               END.                                         
            END.

         /*   OUTPUT TO VALUE (nv_output) APPEND NO-ECHO. */
            EXPORT Delimiter "|" 
             tFacRe.bran
             tFacRe.LINE
             tFacRe.trndat
             tfacre.comdat 
             tfacre.expdat 
             tfacredet.policy
             tfacre.endno /*tFacRe.endcnt */
             "No"
             tFacRe.cntrisk 
             tfacredet.rico
             nv_name
             tfacredet.rico
             nv_name
             nv_polsta
             tfacre.coins 
             tfacre.co_per
             tfacre.co_sty 
             tfacre.ri_fac 
             tfacre.ri_tty 
             tfacre.ri_ret  
             tfacre.sigr 
             tfacre.polprm
             tfacredet.risi 
             tfacredet.riprem
             tfacredet.comri 
             tFacRe.poldisc
             tFacRe.ridisc 
             tFacRe.flood
             tFacRe.storm
             tFacRe.earth 
             nv_agtreg 
             nv_occup 
             nv_oicline
             nv_uwline
             nv_uwlinedesc
             tfacredet.comri
             nn_acno
             nn_acnoname
             nn_cedco
             nn_cedname.
        END. 
  
        /*------------------------------------------*/

        ELSE DO:
            FOR EACH tfacredetsub  WHERE 
                     tfacredetsub.asdat  = tfacredet.asdat  AND 
                     tfacredetsub.policy = tfacredet.policy AND 
                     tfacredetsub.rencnt = tfacredet.rencnt AND
                     tfacredetsub.endcnt = tfacredet.endcnt AND
                     tfacredetsub.rico   = tfacredet.rico   NO-LOCK
                BREAK BY tFacRe.bran 
                      BY SUBSTR(tfacre.policy,3,2) 
                      BY tFacRe.endcnt .

             FIND LAST uwm100 WHERE uwm100.policy = tfacredetsub.policy NO-LOCK NO-ERROR. 
             IF AVAILABLE uwm100 THEN DO:
                ASSIGN nv_polsta     = uwm100.polsta
                       nv_si_p       = 100 - tfacre.risi_p .   /* june */

                /*------aaaaaaaaa-------*/
                ASSIGN nn_acno = ""
                       nn_acnoname = ""
                       nn_cedco = ""
                       nn_cedname = "".

                FIND xmm600 NO-LOCK WHERE xmm600.acno = uwm100.acno1 NO-ERROR.
                IF AVAILABLE xmm600 THEN DO:
                
                   ASSIGN nn_acno          = xmm600.acno
                          nn_acnoname      = xmm600.NAME.
                END.
                ELSE ASSIGN nn_acno        = ""
                            nn_acnoname    = "".

                FIND xmm600 NO-LOCK WHERE xmm600.acno = uwm100.cedco NO-ERROR.
                IF AVAILABLE xmm600 THEN DO:
                
                   ASSIGN nn_cedco         = xmm600.acno
                          nn_cedname       = xmm600.NAME.
                END.
                ELSE ASSIGN nn_acno        = ""
                            nn_acnoname    = "".
                /*-----------------------*/

               FIND FIRST acm001 USE-INDEX acm00101 WHERE 
                          acm001.trnty1 = uwm100.trty11 AND 
                          acm001.docno  = uwm100.docno1 NO-LOCK NO-ERROR.

                  IF AVAIL acm001 THEN DO:
             
                     ASSIGN
                         
                        tFacRe.poldisc  =  (acm001.fee * tFacRedetsub.risi_p) / 100 
                        tFacRe.ridisc   =  (tFacRe.poldisc * tFacRedetsub.cedper) / 100 . 

                  END.
                  ELSE ASSIGN 
                      tFacRe.poldisc  = 0
                      tFacRe.ridisc   = 0. 
             END. 

             ELSE
               nv_polsta = "".

             FIND xmm600 NO-LOCK WHERE xmm600.acno = tfacredetsub.rico  NO-ERROR.
             IF AVAILABLE xmm600 THEN
                 ASSIGN rico_name    = xmm600.NAME.

             FIND xmm600 NO-LOCK WHERE xmm600.acno = tfacredetsub.ricosub NO-ERROR.
             IF AVAILABLE xmm600 THEN DO:
                 ASSIGN
                    nv_name    = xmm600.NAME
                    nv_agtreg  = xmm600.agtreg. 

               IF SUBSTRING(xmm600.acno,1,2) = "0D" OR SUBSTRING(xmm600.acno,1,2) = "0A"   THEN DO:   
                  nv_agtreg = "TIC-00" + nv_agtreg.                                                   
               END.                                                                                           
               IF SUBSTRING(xmm600.acno,1,2) = "0F"  THEN DO:                                             
                   nv_agtreg = "FIC-00" + nv_agtreg.                                                   
               END.  

             END.
             

         /*    OUTPUT TO VALUE (nv_output) APPEND NO-ECHO. */
             EXPORT Delimiter "|"
                    tFacRe.bran
                    tFacRe.LINE
                    tFacRe.trndat
                    tfacre.comdat
                    tfacre.expdat
                    tfacredetsub.policy
                    tfacre.endno 
                    "YES"
                    tFacRe.cntrisk 
                    tfacredetsub.rico
                    rico_name
                    tfacredetsub.ricosub 
                    nv_name
                    nv_polsta
                    tfacre.coins
                    tfacre.co_per
                    tfacre.co_sty 
                    tfacre.ri_fac 
                    tfacre.ri_tty 
                    tFacRe.risi_p  /* june */
                    tfacre.sigr
                    tfacre.polprm
                    tfacredetsub.risi
                    tfacredetsub.riprem
                    tfacredetsub.ricom
                    tFacRe.poldisc
                    tFacRe.ridisc 
                    tFacRe.flood
                    tFacRe.storm
                    tFacRe.earth 
                    nv_agtreg 
                    nv_occup
                    nv_oicline
                    nv_uwline
                    nv_uwlinedesc
                    nn_acno
                    nn_acnoname
                    nn_cedco
                    nn_cedname.
                 
            END. 
        END. 
    END.
END.







END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_facPolrisi cC-Win 
PROCEDURE pd_facPolrisi :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

FOR EACH tfacre WHERE tFacRe.asdat = nv_asdat NO-LOCK .

   FIND FIRST uwm100 USE-INDEX uwm10001 WHERE
              uwm100.policy = tfacre.policy  AND
              uwm100.rencnt = tFacRe.rencnt AND
              uwm100.endcnt = tFacRe.endcnt NO-LOCK NO-ERROR .
   IF NOT AVAILABLE uwm100 THEN NEXT.
   
        tFacre.polprm = uwm100.prem_t.
        tfacre.endno  = uwm100.endno .
   
    FOR EACH uwm120 USE-INDEX uwm12001      WHERE 
             uwm120.policy = uwm100.policy  AND
             uwm120.rencnt = uwm100.rencnt  AND
             uwm120.endcnt = uwm100.endcnt  NO-LOCK.
    
        ASSIGN n_cntrisk = n_cntrisk + 1 
               nv_disc   = uwm120.rfee_r 
               nv_sigr   = nv_sigr + ((uwm120.sigr *  tFacRe.co_sty) / tFacRe.co_sty) . 
    
      FOR EACH uwd200  USE-INDEX uwd20001     WHERE 
               uwd200.policy = uwm120.policy  AND 
               uwd200.rencnt = uwm120.rencnt  AND 
               uwd200.endcnt = uwm120.endcnt  AND 
               uwd200.riskgp = uwm120.riskgp  AND
               uwd200.riskno = uwm120.riskno  NO-LOCK .
         
          DISP uwd200.policy uwd200.rencnt uwd200.endcnt uwd200.riskno FORMAT "999999" uwd200.rico WITH NO-LABEL TITLE "Process Data Allocate..."   FRAME b  VIEW-AS DIALOG-BOX . 
          //--F68-0002_CS2025-003638--Add-uwd200.riskno FORMAT "999999" --
    
          nv_sipol   = nv_sipol + uwd200.risi  .   /* june */
               /* FAC RI */
         IF uwd200.csftq = "F" THEN DO:
         
            ASSIGN nv_risi_f  =  nv_risi_f + uwd200.risi
                   nv_fac_per =  (nv_risi_f * 100) / nv_sigr 
                   mfac_c     =  mfac_c + uwd200.ric1.
                   nv_riprem  = nv_riprem + uwd200.ripr.

            FIND xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = uwd200.rico NO-ERROR.
            IF AVAIL xmm600 THEN ASSIGN nv_riconame      = xmm600.NAME
                                        nv_ricoagtreg    = xmm600.agtreg.  /* june */

         END.
       
         /*-------------------- ret -------------------*/
         IF uwd200.csftq <> "F" THEN DO:
            
             IF  uwd200.rico  = "0RET"  THEN DO:      /*-----ไม่ต้อง Gen JV-----*/
               ASSIGN nv_risi_r   =  nv_risi_r + uwd200.risi
                      nv_riret    =  (nv_risi_r * 100) / nv_sigr 
                      mret_c      =  0.
             END.
          /*------------------- tty --------------------*/
          
             IF  uwd200.rico   = "STAT"  THEN DO:   /* Qbaht */
               ASSIGN  nv_risi_t   =  nv_risi_t + uwd200.risi
                       nt_stat_per =  (nv_risi_t * 100) / nv_sigr  
                       mstat_c     =  mstat_c + uwd200.ric1 .
             END.
          
             IF  SUBSTRING(uwd200.rico,1,2) = "0Q"  THEN DO:  /* TFP */
               ASSIGN  nv_risi_t   =  nv_risi_t + uwd200.risi
                       nt_0q_per   =  (nv_risi_t * 100) / nv_sigr 
                       m0q_c       =  m0q_c + uwd200.ric1 .
             END.
            
             IF  SUBSTRING(uwd200.rico,1,2) = "0T"  AND          
                 SUBSTRING(uwd200.rico,6,2) = "01"  THEN DO:   /*--1ST--*/
               ASSIGN  nv_risi_t   =  nv_risi_t + uwd200.risi
                       nt_0t_per   =  (nv_risi_t * 100) / nv_sigr 
                       m0t_c       =  m0t_c + uwd200.ric1 .
             END.
            
             IF  SUBSTRING(uwd200.rico,1,2) = "0T"  AND
                 SUBSTRING(uwd200.rico,6,2) = "02"  THEN DO:   /*--2ND--*/
             ASSIGN  nv_risi_t   =  nv_risi_t + uwd200.risi
                     nt_0s_per   =  (nv_risi_t * 100) / nv_sigr  
                     m0s_c       =  m0s_c + uwd200.ric1 .
             END.
            
             IF  SUBSTRING(uwd200.rico,1,2) = "0T"  AND
                 SUBSTRING(uwd200.rico,6,2) = "F1"  THEN DO:
             ASSIGN  nv_risi_t   =  nv_risi_t + uwd200.risi
                     nt_f1_per   =  (nv_risi_t * 100) / nv_sigr 
                     mf1_c       =  mf1_c + uwd200.ric1 .
             END.
            
             IF  SUBSTRING(uwd200.rico,1,2) = "0T"  AND
                 SUBSTRING(uwd200.rico,6,2) = "F2"  THEN DO:
             ASSIGN  nv_risi_t   =  nv_risi_t + uwd200.risi
                     nt_f2_per   =  (nv_risi_t * 100) / nv_sigr 
                     mf2_c       =  mf2_c + uwd200.ric1 .
             END.
 
             IF  SUBSTRING(uwd200.rico,1,2) = "0T"  AND
                 SUBSTRING(uwd200.rico,6,2) = "F3"  THEN DO: 
             ASSIGN  nv_risi_t   =  nv_risi_t + uwd200.risi
                     nt_f3_per   =  (nv_risi_t * 100) / nv_sigr 
                     mf3_c       =  mf3_c + uwd200.ric1 .
             END.
            
             IF  SUBSTRING(uwd200.rico,1,2) = "0T"  AND  
                 SUBSTRING(uwd200.rico,6,2) = "F4"  THEN DO:
             ASSIGN nv_risi_t   =  nv_risi_t + uwd200.risi
                    nt_f4_per   =  (nv_risi_t * 100) / nv_sigr 
                    mf4_c       =  mf4_c + uwd200.ric1 .
             END.
            
             IF  SUBSTRING(uwd200.rico,1,3) = "0RQ" THEN DO:
             ASSIGN  nv_risi_t   =  nv_risi_t + uwd200.risi
                     nt_0rq_per  =  (nv_risi_t * 100) / nv_sigr 
                     m0rq_c      =  m0rq_c + uwd200.ric1 .
             END.
            
             IF  SUBSTRING(uwd200.rico,1,3) = "0PS" THEN DO:    /*--MPS--*/
             ASSIGN  nv_risi_t   =  nv_risi_t + uwd200.risi
                     nt_0ps_per  =  (nv_risi_t * 100) / nv_sigr 
                     m0ps_c      =  m0ps_c + uwd200.ric1 .
             END.
            
             IF  SUBSTRING(uwd200.rico,1,3) = "0TF"  AND
                 SUBSTRING(uwd200.rico,6,2) = "FB"  THEN DO:
             ASSIGN  nv_risi_t   =  nv_risi_t + uwd200.risi
                     nt_btr_per  =  (nv_risi_t * 100) / nv_sigr 
                     mbtr_c      =  mbtr_c + uwd200.ric1 .
             END.
            
             IF  SUBSTRING(uwd200.rico,1,3) = "0TF"  AND
                 SUBSTRING(uwd200.rico,6,2) = "FO"  THEN DO:
             ASSIGN  nv_risi_t   =  nv_risi_t + uwd200.risi
                     nt_otr_per  =  (nv_risi_t * 100) / nv_sigr 
                     motr_c      =  motr_c + uwd200.ric1 .
             END.
            
             IF  SUBSTRING(uwd200.rico,1,3) = "0TF"  AND 
                 SUBSTRING(uwd200.rico,6,2) = "FT"  THEN DO:
             ASSIGN  nv_risi_t   =  nv_risi_t + uwd200.risi
                     nt_ftr_per  =  (nv_risi_t * 100) / nv_sigr 
                     mftr_c      =  mftr_c + uwd200.ric1 .
             END.
 
             IF  SUBSTRING(uwd200.rico,1,4) = "0TA8"  AND   /*----ยกเลิก---*/                      
                 SUBSTRING(uwd200.rico,7,1) = "2"  THEN DO:
 
             ASSIGN  nv_risi_t  =  nv_risi_t + uwd200.risi
                     nt_s8_per  =  (nv_risi_t * 100) / nv_sigr 
                     ms8_c      =  ms8_c + uwd200.ric1 .
             END.
 
             ASSIGN
             nv_ritty  =  nt_stat_per + nt_0q_per  + nt_0t_per  + nt_0s_per  +
                          nt_f1_per   + nt_f2_per  + nt_f3_per  + nt_f4_per  +
                          nt_0rq_per  + nt_0ps_per + nt_btr_per + nt_otr_per +
                          nt_ftr_per  + nt_s8_per
 
             nt_stat_per = 0 nt_0q_per = 0 nt_0t_per  = 0 nt_0s_per  = 0 nt_f1_per  = 0 nt_f2_per  = 0
             nt_f3_per   = 0 nt_f4_per = 0 nt_0rq_per = 0 nt_0ps_per = 0 nt_btr_per = 0 nt_otr_per = 0
             nt_ftr_per  = 0 nt_s8_per = 0  . 
 
            FIND xmm025 USE-INDEX xmm02501 WHERE xmm025.treaty = uwd200.rico NO-ERROR.
            IF AVAIL xmm025 THEN DO:
               ASSIGN nv_riconame      = xmm025.trdes
                      nv_ricoagtreg    = "".  /* june */
            END.
         
         END.  /* csftq <> F */

         FIND tFacRedetriskno WHERE
              tFacRedetriskno.asdat  = tfacre.asdat    AND
              tFacRedetriskno.policy = uwd200.policy   AND
              tFacRedetriskno.rencnt = uwd200.rencnt   AND
              tFacRedetriskno.endcnt = uwd200.endcnt   AND
              tFacRedetriskno.riskgp = uwd200.riskgp   AND
              tFacRedetriskno.riskno = uwd200.riskno   AND
              tFacRedetriskno.rico   = uwd200.rico     NO-LOCK NO-ERROR.

         IF NOT AVAILABLE tFacRedetriskno THEN DO:
            CREATE tFacRedetriskno.
            ASSIGN
            tFacRedetriskno.asdat   = tfacre.asdat
            tFacRedetriskno.policy  = tfacre.policy
            tFacRedetriskno.rencnt  = uwd200.rencnt
            tFacRedetriskno.endcnt  = uwd200.endcnt
            tFacRedetriskno.riskgp  = uwd200.riskgp
            tFacRedetriskno.riskno  = uwd200.riskno
            tFacRedetriskno.rico    = uwd200.rico  
            tFacRedetriskno.risi_p  = uwd200.risi_p 
            tFacRedetriskno.riprem  = 0
            tFacRedetriskno.risi    = 0.

         END.

         tFacRedetriskno.riprem = tFacRedetriskno.riprem + uwd200.ripr.
    
         IF uwd200.endcnt = uwm100.endcnt THEN
            tFacRedetriskno.risi = tFacRedetriskno.risi + uwd200.risi.
 
 
         FIND uwm304 WHERE uwm304.policy = uwm120.policy  AND
                           uwm304.rencnt = uwm120.rencnt  AND
                           uwm304.endcnt = uwm120.endcnt  AND
                           uwm304.riskgp = uwm120.riskgp  AND
                           uwm304.riskno = uwm120.riskno  NO-LOCK NO-ERROR.
           
         IF AVAIL uwm304 THEN DO:
            
            ASSIGN
            tFacRedetriskno.occupn = uwm304.occupn
            nv_recid = uwm304.fptr02.
 
            DO WHILE nv_recid <> 0:
               
               FIND uwd141  WHERE RECID(uwd141) = nv_recid NO-LOCK NO-ERROR.
               IF AVAILABLE uwd141 THEN DO:
                   ASSIGN
                  nv_recid = 0
                  tFacRedetriskno.prov_n = uwd141.prov_n
                  tFacRedetriskno.blok_n = uwd141.blok_n
                  tFacRedetriskno.blok_s = uwd141.sblok_n
                  tFacRedetriskno.dist_n = uwd141.dist_n.
                  FIND uwm502  WHERE
                       uwm502.prov_n = uwd141.prov_n   AND
                       uwm502.dist_n = uwd141.dist_n   AND
                       uwm502.blok_n = uwd141.blok_n   AND
                       uwm502.blok_s = uwd141.sblok_n  NO-LOCK NO-ERROR  .
                  IF AVAIL uwm502 THEN
                       tFacRedetriskno.blok_d = uwm502.blok_d.
               END.
               ELSE nv_recid = 0.

            END.   /* DO WHILE */
         END.
    
         FIND tFacRedet WHERE tFacRedet.asdat  = tfacre.asdat   AND
                              tFacRedet.policy = uwd200.policy  AND
                              tFacRedet.rencnt = uwd200.rencnt  AND 
                              tFacRedet.endcnt = uwd200.endcnt  AND 
                              tFacRedet.rico   = uwd200.rico    NO-LOCK NO-ERROR.  
    
         IF NOT AVAIL tFacRedet THEN DO:
             CREATE tFacRedet.
             ASSIGN
                 tFacRedet.asdat   = tfacre.asdat
                 tFacRedet.policy  = tfacre.policy
                 tFacRedet.rencnt  = uwd200.rencnt
                 tFacRedet.endcnt  = uwd200.endcnt
                 tFacRedet.csftq   = uwd200.csftq
                 tFacRedet.rico    = uwd200.rico 
                 tFacRedet.risi_p  = uwd200.risi_p 
                 tFacRedet.riskgp  = uwd200.riskgp
                 tFacRedet.riskno  = uwd200.riskno  /* june */
                 tFacRedet.csftq   = uwd200.csftq
                 tFacRedet.risi   = 0
                 tFacRedet.riprem = 0
                 tFacRedet.ricomm = 0
                 tFacRedet.comri  = 0.
         END.
         
         
         ASSIGN
         tfacredet.comri  = tfacredet.comri  + uwd200.ric1
         tFacRedet.riprem = tFacRedet.riprem + uwd200.ripr
         tFacRedet.riconame = nv_riconame
         tFacRedet.ricoagtreg = nv_ricoagtreg.
    
         IF uwd200.endcnt = uwm100.endcnt THEN 
            tFacRedet.risi = tFacRedet.risi + uwd200.risi.


      END. /* uwd200 */
      
      
    END. /* uwm120 */

    ASSIGN
      tfacre.endno    = uwm100.endno
      tfacre.ri_fac   = tfacre.ri_fac + nv_fac_per
      tfacre.ri_tty   = nv_ritty
      tfacre.ri_ret   = nv_riret 
      tfacre.cntrisk  = n_cntrisk
      tfacre.sigr     = nv_sigr
      tfacre.sipol    = nv_sipol  /* june */
      tfacre.compol   = nv_compol
      n_cntrisk       = 0 .

    ASSIGN nv_rifac   = 0
           nv_ritty   = 0
           nv_riret   = 0
           nv_sigr    = 0
           nv_sipol   = 0
           nv_riprem  = 0
           nv_ricom   = 0
           nv_compol  = 0
           nv_risi_f  = 0
           nv_fac_per = 0
           mfac_c     = 0
           nv_risi_r  = 0
           nv_riret   = 0
           mret_c     = 0
           nv_risi_t  = 0
           nt_stat_per = 0
           mstat_c    = 0
           nv_risi_t  = 0
           nt_0q_per  = 0
           m0q_c      = 0
           nv_risi_t  = 0
           nt_0t_per  = 0
           m0t_c      = 0
           nv_risi_t  = 0
           nt_0s_per  = 0
           m0s_c      = 0
           nv_risi_t  = 0
           nt_f1_per  = 0
           mf1_c      = 0
           nv_risi_t  = 0
           nt_f2_per  = 0
           mf2_c      = 0
           nv_risi_t  = 0
           nt_f3_per  = 0
           mf3_c      = 0
           nv_risi_t  = 0
           nt_f4_per  = 0
           mf4_c      = 0
           nv_risi_t  = 0
           nt_0rq_per = 0
           m0rq_c     = 0
           nv_risi_t  = 0
           nt_0ps_per = 0
           m0ps_c     = 0
           nv_risi_t  = 0
           nt_btr_per = 0
           mbtr_c     = 0
           nv_risi_t  = 0
           nt_otr_per = 0
           motr_c     = 0
           nv_risi_t  = 0
           nt_ftr_per = 0
           mftr_c     = 0
           nv_risi_t  = 0
           nt_s8_per  = 0
           ms8_c      = 0
           nv_riprem = 0.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_FacPolsubrisi cC-Win 
PROCEDURE PD_FacPolsubrisi :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DEF VAR nv_sub    AS CHAR.
DEF VAR nv_asdate AS DATE.
DEF VAR nv_risi   LIKE tFacRedetsub.risi.
DEF VAR nv_RiPrem LIKE tFacRedetsub.RiPrem.
DEF VAR nv_endcnt LIKE riroprm.endcnt.
DEF BUFFER bfriroprm FOR riroprm.

nv_asdate = nv_dateto.
FOR EACH tFacRedetsub WHERE tFacRedetsub.asdat = nv_asdate.

    DELETE tFacRedetsub.
END.
FOR EACH tfacredet WHERE tFacRedet.asdat = nv_asdate NO-LOCK .

   ASSIGN 
   nv_risi   = 0
   nv_RiPrem = 0  
   nv_RiCom = 0
   nv_sub    = "".

   FOR EACH riroprm USE-INDEX riroprm01 WHERE  
            riroprm.policy = tfacredet.policy AND
            riroprm.rencnt = tfacredet.rencnt AND
            riroprm.endcnt = tfacredet.endcnt AND
            riroprm.riskgp = tfacredet.riskgp AND
            riroprm.rico   = tfacredet.rico   NO-LOCK
            BREAK BY riroprm.ricosub 
                  BY riroprm.rico.
        
        DISP riroprm.policy riroprm.rencnt riroprm.endcnt WITH NO-LABEL TITLE "Process Data Sub RI..."   FRAME c  VIEW-AS DIALOG-BOX . 

        
        FIND tFacRedetsub WHERE 
             tFacRedetsub.asdat   = tfacredet.asdat   AND 
             tFacRedetsub.policy  = tfacredet.policy  AND
             tfacredetsub.rencnt  = tfacredet.rencnt  AND
             tfacredetsub.endcnt  = tfacredet.endcnt  AND
             tFacRedetsub.rico    = tfacredet.rico    AND 
             tFacRedetsub.ricosub = riroprm.ricosub   NO-ERROR.

        IF NOT AVAILABLE tFacRedetsub THEN  DO:

            CREATE tFacRedetsub.
            ASSIGN 
                tFacRedetsub.asdat   = tfacredet.asdat
                tFacRedetsub.policy  = tfacredet.policy
                tfacredetsub.rencnt  = tfacredet.rencnt
                tfacredetsub.endcnt  = tfacredet.endcnt
                tFacRedetsub.rico    = tfacredet.rico
                tFacRedetsub.ricosub = riroprm.ricosub
                tFacRedetsub.cedper  = riroprm.cedper 
                tFacRedetsub.risi   = 0
                tFacRedetsub.RiPrem = 0 
                tFacRedetsub.RiCom  = 0 
                nv_ricom            = 0
                .

           FIND xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = riroprm.ricosub NO-LOCK NO-ERROR.
           IF AVAIL xmm600 THEN ASSIGN tfacredetsub.ricosubname = xmm600.NAME
                                       tfacredetsub.ricosubagtreg = xmm600.agtreg.
           ELSE DO:
              FIND xmm025 USE-INDEX xmm02501 WHERE xmm025.treaty = riroprm.ricosub NO-LOCK NO-ERROR.
              IF AVAIL xmm025 THEN ASSIGN tfacredetsub.ricosubname = xmm025.trdes
                                          tfacredetsub.ricosubagtreg = "".
           END.
        END.

        nv_risi = nv_risi + riroprm.cedsi.

        IF xol = YES THEN tFacRedetsub.risi = tFacRedetsub.risi + riskexp.
        ELSE tFacRedetsub.risi = tFacRedetsub.risi + riroprm.cedsi.

        ASSIGN
            nv_RiPrem           = nv_RiPrem + riroprm.cedpr
            /*---nv_riCom           = nv_riCom + riroprm.comgr_ri---A64-0082---*/
            nv_riCom           = nv_riCom + riroprm.comamt
            tFacRedetsub.RiPrem = tFacRedetsub.RiPrem + riroprm.cedpr.

        IF tFacredetsub.ricosub = riroprm.ricosub  THEN DO: 
           IF  riroprm.comamt <> 0 THEN tFacredetsub.Ricom = nv_ricom.
           ELSE tFacredetsub.Ricom =  ((riroprm.comgr_ri * riroprm.cedper) / 100). 
          
        END.
        ELSE DO:
           IF  riroprm.comamt <> 0 THEN tFacredetsub.Ricom = nv_ricom.    
           ELSE tFacredetsub.Ricom =  ((riroprm.comgr_ri * riroprm.cedper) / 100). 
        END.

        IF riroprm.ricosub <> riroprm.rico THEN ASSIGN nv_sub = "*"
                                                       tfacredet.SubBroker = YES.
        ELSE tfacredet.SubBroker = NO.
            
   END.

END.



END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_facrepolicyricoriskno cC-Win 
PROCEDURE PD_facrepolicyricoriskno :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DEF VAR nv_recid AS RECID.

ASSIGN n_cntrisk = 0  
       nv_disc   = 0 .

FOR EACH tfacre  WHERE tFacRe.asdat = nv_asdat NO-LOCK  .
   /* FIND LAST uwm100  WHERE 
              uwm100.policy = tfacre.policy   NO-LOCK NO-ERROR.  */
    FIND FIRST uwm100  USE-INDEX uwm10001    WHERE
               uwm100.policy = tfacre.policy AND
               uwm100.rencnt = tfacre.rencnt AND
               uwm100.endcnt = tfacre.endcnt NO-LOCK NO-ERROR. 

    IF NOT AVAILABLE uwm100 THEN NEXT.
 /* FOR EACH uwm100  WHERE uwm100.policy = tfacre.policy   NO-LOCK . */

ASSIGN nv_sigr   = 0        nv_rifac    = 0
       nv_risi   = 0        nv_retper   = 0
       nv_risi_p = 0        nv_ritty    = 0
       nt_fac_per  = 0                                                               
       nt_risi_p  = 0                                                               
       nt_stat_per = 0 nt_0q_per = 0 nt_0t_per  = 0 nt_0s_per  = 0 nt_f1_per  = 0 nt_f2_per  = 0 
       nt_f3_per   = 0 nt_f4_per = 0 nt_0rq_per = 0 nt_0ps_per = 0 nt_btr_per = 0 nt_otr_per = 0
       nt_ftr_per  = 0 nt_s8_per = 0 . 

    FOR EACH uwm120 USE-INDEX uwm12001 WHERE 
             uwm120.policy = uwm100.policy  AND
             uwm120.rencnt = uwm100.rencnt  AND
             uwm120.endcnt = uwm100.endcnt  NO-LOCK.

        ASSIGN n_cntrisk = n_cntrisk + 1 
               nv_disc   = uwm120.rfee_r 
               nv_sigr   = nv_sigr + uwm120.sigr .
        
        FOR EACH tFacRedetriskno WHERE 
                 tFacRedetriskno.asdat  = tfacre.asdat   AND
                 tFacRedetriskno.policy = tfacre.policy  AND
                 tFacRedetriskno.rencnt = tfacre.rencnt  AND
                 tFacRedetriskno.endcnt = tfacre.endcnt  AND
                 tFacRedetriskno.riskgp = uwm120.riskgp  AND
                 tFacRedetriskno.riskno = uwm120.riskno  NO-LOCK.

            ASSIGN
            tFacRedetriskno.risi   = 0
            tFacRedetriskno.RiPrem = 0 .

        END.
        FOR EACH uwd200  USE-INDEX uwd20001      WHERE
                 uwd200.policy = tfacre.policy   AND
                 uwd200.rencnt = tfacre.rencnt   AND 
                 uwd200.endcnt = tfacre.endcnt   AND 
                 /*uwd200.csftq  = "F"             AND*/
                 uwd200.riskgp = uwm120.riskgp   AND
                 uwd200.riskno = uwm120.riskno   NO-LOCK .
  /*---------------------------- june --------------------------*/
    /* FAC RI */
     IF uwd200.csftq = "F" THEN DO:
        ASSIGN
        nt_fac_pr  = nt_fac_pr + uwd200.ripr.

         FIND FIRST uwm200 USE-INDEX uwm20001 WHERE  /*---- find % Comm จากTable uwm200 ---*/
                    uwm200.policy = uwd200.policy AND
                    uwm200.rencnt = uwd200.rencnt AND
                    uwm200.endcnt = uwd200.endcnt AND
                    uwm200.csftq  = uwd200.csftq  AND
                    uwm200.rico   = uwd200.rico   AND
                    uwm200.c_enct = uwd200.c_enct  NO-LOCK  NO-ERROR.
         IF  AVAIL uwm200  THEN nt_fac_per  = uwm200.rip1.
         mfac_c = (nt_fac_pr * nt_fac_per) / 100.

            /*------------  Foreign --------*/
         IF SUBSTRING (uwm200.rico,1,2) = "0F" THEN DO:
              FIND XMM600 USE-INDEX XMM60001 WHERE
                   XMM600.ACNO = uwm200.rico NO-LOCK NO-ERROR .

              IF AVAILABLE xmm600 THEN DO:
                IF (xmm600.clicod = "RD") OR (xmm600.clicod = "RB") THEN
                ASSIGN  n_lc_com  = n_lc_com + ((nt_fac_pr * mfac_c) / 100) .

                ELSE IF (xmm600.clicod = "RF") OR (xmm600.clicod = "RA") THEN 
                ASSIGN  n_fr_com  = n_fr_com + ((nt_fac_pr * mfac_c) / 100) .

              END.
         END. 
     END.

     ELSE IF  uwd200.rico  = "STAT"  THEN  DO:  /* Qbaht */
         ASSIGN 
         nt_stat_pr      = nt_stat_pr + uwd200.ripr.
         
         FIND FIRST uwm200 USE-INDEX uwm20001 WHERE  /*---- find % Comm จากTable uwm200 ---*/
                    uwm200.policy = uwd200.policy AND
                    uwm200.rencnt = uwd200.rencnt AND
                    uwm200.endcnt = uwd200.endcnt AND
                    uwm200.csftq  = uwd200.csftq  AND
                    uwm200.rico   = uwd200.rico   AND
                    uwm200.c_enct = uwd200.c_enct  NO-LOCK  NO-ERROR.
         IF  AVAIL uwm200  THEN nt_stat_per  = uwm200.rip1.
         mstat_c = (nt_stat_pr * nt_stat_per) / 100.
     END.

     ELSE IF    uwd200.rico  = "0RET"  THEN DO:       /*-----ไม่ต้อง Gen JV-----*/
                ASSIGN
                nt_ret_pr       = nt_ret_pr + uwd200.ripr.
                
                FIND FIRST uwm200 USE-INDEX uwm20001 WHERE
                           uwm200.policy = uwd200.policy AND
                           uwm200.rencnt = uwd200.rencnt AND
                           uwm200.endcnt = uwd200.endcnt AND
                           uwm200.csftq  = uwd200.csftq  AND
                           uwm200.rico   = uwd200.rico   AND
                           uwm200.c_enct = uwd200.c_enct  NO-LOCK  NO-ERROR.
                IF  AVAIL uwm200  THEN nt_risi_p  = uwm200.rip1.
                mret_c = 0.
                
     END.

     ELSE IF    SUBSTRING(uwd200.rico,1,2) = "0Q"  THEN DO: /* TFP */
                ASSIGN
                nt_0q_pr        = nt_0q_pr  + uwd200.ripr.
                
                FIND FIRST uwm200 USE-INDEX uwm20001 WHERE
                           uwm200.policy = uwd200.policy AND
                           uwm200.rencnt = uwd200.rencnt AND
                           uwm200.endcnt = uwd200.endcnt AND
                           uwm200.csftq  = uwd200.csftq  AND
                           uwm200.rico   = uwd200.rico   AND
                           uwm200.c_enct = uwd200.c_enct  NO-LOCK  NO-ERROR.
                IF  AVAIL uwm200  THEN nt_0q_per  = uwm200.rip1.
                m0q_c = (nt_0q_pr * nt_0q_per) / 100.
               
     END.

     ELSE IF    SUBSTRING(uwd200.rico,1,2) = "0T"  AND          
                SUBSTRING(uwd200.rico,6,2) = "01"  THEN DO:    /*--1ST--*/
                ASSIGN
                nt_0t_pr        = nt_0t_pr + uwd200.ripr.

                FIND FIRST uwm200 USE-INDEX uwm20001 WHERE
                           uwm200.policy = uwd200.policy AND
                           uwm200.rencnt = uwd200.rencnt AND
                           uwm200.endcnt = uwd200.endcnt AND
                           uwm200.csftq  = uwd200.csftq  AND
                           uwm200.rico   = uwd200.rico   AND
                           uwm200.c_enct = uwd200.c_enct  NO-LOCK  NO-ERROR.
                IF  AVAIL uwm200  THEN nt_0t_per  = uwm200.rip1.
                m0t_c = (nt_0t_pr * nt_0t_per) / 100.
                
     END.
   
     ELSE IF    SUBSTRING(uwd200.rico,1,2) = "0T"  AND
                SUBSTRING(uwd200.rico,6,2) = "02"  THEN DO:   /*--2ND--*/
                
                ASSIGN
                nt_0s_pr        = nt_0s_pr + uwd200.ripr.

                FIND FIRST uwm200 USE-INDEX uwm20001 WHERE
                           uwm200.policy = uwd200.policy AND
                           uwm200.rencnt = uwd200.rencnt AND
                           uwm200.endcnt = uwd200.endcnt AND
                           uwm200.csftq  = uwd200.csftq  AND
                           uwm200.rico   = uwd200.rico   AND
                           uwm200.c_enct = uwd200.c_enct  NO-LOCK  NO-ERROR.
                IF  AVAIL uwm200  THEN nt_0s_per  = uwm200.rip1.
                m0s_c = (nt_0s_pr * nt_0s_per) / 100.

     END.

     ELSE IF    SUBSTRING(uwd200.rico,1,2) = "0T"  AND
                SUBSTRING(uwd200.rico,6,2) = "F1"  THEN DO:
                ASSIGN
                nt_f1_pr        = nt_f1_pr + uwd200.ripr.

                FIND FIRST uwm200 USE-INDEX uwm20001 WHERE
                           uwm200.policy = uwd200.policy AND
                           uwm200.rencnt = uwd200.rencnt AND
                           uwm200.endcnt = uwd200.endcnt AND
                           uwm200.csftq  = uwd200.csftq  AND
                           uwm200.rico   = uwd200.rico   AND
                           uwm200.c_enct = uwd200.c_enct  NO-LOCK  NO-ERROR.
                IF  AVAIL uwm200  THEN nt_f1_per  = uwm200.rip1.
                mf1_c = (nt_f1_pr * nt_f1_per) / 100.
                     
     END.                              

     ELSE IF    SUBSTRING(uwd200.rico,1,2) = "0T"  AND
                SUBSTRING(uwd200.rico,6,2) = "F2"  THEN DO:
                ASSIGN
                nt_f2_pr        = nt_f2_pr + uwd200.ripr.

                FIND FIRST uwm200 USE-INDEX uwm20001 WHERE
                           uwm200.policy = uwd200.policy AND
                           uwm200.rencnt = uwd200.rencnt AND
                           uwm200.endcnt = uwd200.endcnt AND
                           uwm200.csftq  = uwd200.csftq  AND
                           uwm200.rico   = uwd200.rico   AND
                           uwm200.c_enct = uwd200.c_enct  NO-LOCK  NO-ERROR.
                IF  AVAIL uwm200  THEN nt_f2_per  = uwm200.rip1.
                mf2_c = (nt_f2_pr * nt_f2_per) / 100.
                          
     END.

     ELSE IF    SUBSTRING(uwd200.rico,1,2) = "0T"  AND
                SUBSTRING(uwd200.rico,6,2) = "F3"  THEN DO:
                ASSIGN
                nt_f3_pr        = nt_f3_pr + uwd200.ripr.

                FIND FIRST uwm200 USE-INDEX uwm20001 WHERE
                           uwm200.policy = uwd200.policy AND
                           uwm200.rencnt = uwd200.rencnt AND
                           uwm200.endcnt = uwd200.endcnt AND
                           uwm200.csftq  = uwd200.csftq  AND
                           uwm200.rico   = uwd200.rico   AND
                           uwm200.c_enct = uwd200.c_enct  NO-LOCK  NO-ERROR.
                IF  AVAIL uwm200  THEN nt_f3_per  = uwm200.rip1.
                mf3_c = (nt_f3_pr * nt_f3_per) / 100.
                                    
     END.
                
     ELSE IF    SUBSTRING(uwd200.rico,1,2) = "0T"  AND   
                SUBSTRING(uwd200.rico,6,2) = "F4"  THEN DO:
                ASSIGN nt_f4_pr        = nt_f4_pr + uwd200.ripr.

                FIND FIRST uwm200 USE-INDEX uwm20001 WHERE
                           uwm200.policy = uwd200.policy AND
                           uwm200.rencnt = uwd200.rencnt AND
                           uwm200.endcnt = uwd200.endcnt AND
                           uwm200.csftq  = uwd200.csftq  AND
                           uwm200.rico   = uwd200.rico   AND
                           uwm200.c_enct = uwd200.c_enct  NO-LOCK  NO-ERROR.
                IF  AVAIL uwm200  THEN nt_f4_per  = uwm200.rip1.
                mf4_c = (nt_f4_pr * nt_f4_per) / 100.
                             
     END.
 
     ELSE IF    SUBSTRING(uwd200.rico,1,3) = "0RQ" THEN DO:
                ASSIGN
                nt_0rq_pr       = nt_0rq_pr + uwd200.ripr.

                FIND FIRST uwm200 USE-INDEX uwm20001 WHERE
                           uwm200.policy = uwd200.policy AND
                           uwm200.rencnt = uwd200.rencnt AND
                           uwm200.endcnt = uwd200.endcnt AND
                           uwm200.csftq  = uwd200.csftq  AND
                           uwm200.rico   = uwd200.rico   AND
                           uwm200.c_enct = uwd200.c_enct  NO-LOCK  NO-ERROR.
                IF  AVAIL uwm200  THEN nt_0rq_per  = uwm200.rip1.
                m0rq_c = (nt_0rq_pr * nt_0rq_per) / 100.
                                   
     END.

     ELSE IF    SUBSTRING(uwd200.rico,1,3) = "0PS" THEN DO:     /*--MPS--*/
                ASSIGN
                nt_0ps_pr       = nt_0ps_pr + uwd200.ripr.

                FIND FIRST uwm200 USE-INDEX uwm20001 WHERE
                           uwm200.policy = uwd200.policy AND
                           uwm200.rencnt = uwd200.rencnt AND
                           uwm200.endcnt = uwd200.endcnt AND
                           uwm200.csftq  = uwd200.csftq  AND
                           uwm200.rico   = uwd200.rico   AND
                           uwm200.c_enct = uwd200.c_enct  NO-LOCK  NO-ERROR.
                IF  AVAIL uwm200  THEN nt_0ps_per  = uwm200.rip1.
                m0ps_c = (nt_0ps_pr * nt_0ps_per) / 100.
                      
     END.

     ELSE IF    SUBSTRING(uwd200.rico,1,3) = "0TF"  AND
                SUBSTRING(uwd200.rico,6,2) = "FB"  THEN DO:
                ASSIGN
                nt_btr_pr        = nt_btr_pr + uwd200.ripr.

                FIND FIRST uwm200 USE-INDEX uwm20001 WHERE
                           uwm200.policy = uwd200.policy AND
                           uwm200.rencnt = uwd200.rencnt AND
                           uwm200.endcnt = uwd200.endcnt AND
                           uwm200.csftq  = uwd200.csftq  AND
                           uwm200.rico   = uwd200.rico   AND
                           uwm200.c_enct = uwd200.c_enct  NO-LOCK  NO-ERROR.
                IF  AVAIL uwm200  THEN nt_btr_per  = uwm200.rip1.
                mbtr_c = (nt_btr_pr * nt_btr_per) / 100.

     END.

     ELSE IF    SUBSTRING(uwd200.rico,1,3) = "0TF"  AND
                SUBSTRING(uwd200.rico,6,2) = "FO"  THEN DO:
                ASSIGN
                nt_otr_pr        = nt_otr_pr + uwd200.ripr.

                FIND FIRST uwm200 USE-INDEX uwm20001 WHERE
                           uwm200.policy = uwd200.policy AND
                           uwm200.rencnt = uwd200.rencnt AND
                           uwm200.endcnt = uwd200.endcnt AND
                           uwm200.csftq  = uwd200.csftq  AND
                           uwm200.rico   = uwd200.rico   AND
                           uwm200.c_enct = uwd200.c_enct  NO-LOCK  NO-ERROR.
                IF  AVAIL uwm200  THEN nt_otr_per  = uwm200.rip1.
                motr_c = (nt_otr_pr * nt_otr_per) / 100.
                   
     END.

     ELSE IF    SUBSTRING(uwd200.rico,1,3) = "0TF"  AND   
                SUBSTRING(uwd200.rico,6,2) = "FT"  THEN DO:
                ASSIGN
                nt_ftr_pr  = nt_ftr_pr + uwd200.ripr.

                FIND FIRST uwm200 USE-INDEX uwm20001 WHERE
                           uwm200.policy = uwd200.policy AND
                           uwm200.rencnt = uwd200.rencnt AND
                           uwm200.endcnt = uwd200.endcnt AND
                           uwm200.csftq  = uwd200.csftq  AND
                           uwm200.rico   = uwd200.rico   AND
                           uwm200.c_enct = uwd200.c_enct  NO-LOCK  NO-ERROR.
                IF  AVAIL uwm200  THEN nt_ftr_per  = uwm200.rip1.
                mftr_c = (nt_ftr_pr * nt_ftr_per) / 100.
                   
     END.

     ELSE IF    SUBSTRING(uwd200.rico,1,4) = "0TA8"  AND   /*----ยกเลิก---*/                      
                SUBSTRING(uwd200.rico,7,1) = "2"  THEN DO:
                ASSIGN
                nt_s8_pr   = nt_s8_pr + uwd200.ripr.

                FIND FIRST uwm200 USE-INDEX uwm20001 WHERE
                           uwm200.policy = uwd200.policy AND
                           uwm200.rencnt = uwd200.rencnt AND
                           uwm200.endcnt = uwd200.endcnt AND
                           uwm200.csftq  = uwd200.csftq  AND
                           uwm200.rico   = uwd200.rico   AND
                           uwm200.c_enct = uwd200.c_enct  NO-LOCK  NO-ERROR.
                IF  AVAIL uwm200  THEN nt_s8_per  = uwm200.rip1.
                ms8_c = (nt_s8_pr * nt_s8_per) / 100.

     END.

ASSIGN
nv_rifac  =  nt_fac_per
nv_retper =  nt_risi_p
nv_ritty  =  nt_stat_per + nt_0q_per + nt_0t_per + nt_0s_per + nt_f1_per + nt_f2_per
           + nt_f3_per + nt_f4_per + nt_0rq_per + nt_0ps_per + nt_btr_per + nt_otr_per  
           + nt_ftr_per + nt_s8_per .

     /*-----------------------------------------------------------------------*/


            FIND tFacRedetriskno WHERE
                 tFacRedetriskno.asdat  = tfacre.asdat    AND
                 tFacRedetriskno.policy = uwd200.policy   AND
                 tFacRedetriskno.rencnt = uwd200.rencnt   AND
                 tFacRedetriskno.endcnt = uwd200.endcnt   AND
                 tFacRedetriskno.riskgp = uwd200.riskgp   AND
                 tFacRedetriskno.riskno = uwd200.riskno   AND
                 tFacRedetriskno.rico   = uwd200.rico     NO-LOCK NO-ERROR.
            IF NOT AVAILABLE tFacRedetriskno THEN DO:

                CREATE tFacRedetriskno.
                ASSIGN
                tFacRedetriskno.asdat   = tfacre.asdat
                tFacRedetriskno.policy  = tfacre.policy
                tFacRedetriskno.rencnt  = uwd200.rencnt
                tFacRedetriskno.endcnt  = uwd200.endcnt
                tFacRedetriskno.riskgp  = uwd200.riskgp
                tFacRedetriskno.riskno  = uwd200.riskno
                tFacRedetriskno.rico    = uwd200.rico  .
              /*  tFacRedetriskno.risi_p  = uwd200.risi_p . */

            END.

           /* ASSIGN
            nv_risi   =  nv_risi + uwd200.risi
            nv_risi_p = (nv_risi * 100) / nv_sigr */  /* june */

            tFacRedetriskno.riprem = tFacRedetriskno.riprem + uwd200.ripr.

            IF uwd200.endcnt = uwm100.endcnt THEN
                tFacRedetriskno.risi = tFacRedetriskno.risi + uwd200.risi.

            FIND uwm304 WHERE uwm304.policy = uwm120.policy  AND
                              uwm304.rencnt = uwm120.rencnt  AND
                              uwm304.endcnt = uwm120.endcnt  AND
                              uwm304.riskgp = uwm120.riskgp  AND
                              uwm304.riskno = uwm120.riskno  NO-LOCK NO-ERROR.
            
            IF AVAILABLE uwm304 THEN DO:
               
                ASSIGN
                tFacRedetriskno.occupn = uwm304.occupn.
                nv_recid = uwm304.fptr02.

                DO WHILE nv_recid <> 0:
                
                    FIND uwd141  WHERE RECID(uwd141) = nv_recid NO-LOCK NO-ERROR.
                    IF AVAILABLE uwd141 THEN DO:
                        ASSIGN
                       nv_recid = 0
                       tFacRedetriskno.prov_n = uwd141.prov_n
                       tFacRedetriskno.blok_n = uwd141.blok_n
                       tFacRedetriskno.blok_s = uwd141.sblok_n
                       tFacRedetriskno.dist_n = uwd141.dist_n.
                       FIND uwm502  WHERE
                            uwm502.prov_n = uwd141.prov_n   AND
                            uwm502.dist_n = uwd141.dist_n   AND
                            uwm502.blok_n = uwd141.blok_n   AND
                            uwm502.blok_s = uwd141.sblok_n  NO-LOCK NO-ERROR  .
                        IF AVAILABLE uwm502 THEN
                            tFacRedetriskno.blok_d = uwm502.blok_d.
                    END.
                    ELSE nv_recid = 0.
                END.
            END.
        END. /* uwd200 */
    END. /* uwm120 */

    ASSIGN
    tfacre.ri_fac   = nv_rifac 
    tfacre.ri_tty   = nv_ritty 
    tfacre.risi_p  = nv_risi_p

    tfacre.cntrisk = n_cntrisk
    tfacre.sigr    = nv_sigr
  /*  tFacRe.risi_p  = nv_risi_p */
    n_cntrisk      = 0.


END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_facrepol_com cC-Win 
PROCEDURE pd_facrepol_com :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

FOR EACH tFacRe:
    DELETE tFacRe.
END.

FOR EACH tFacRedet :
    DELETE tFacRedet .
END.

FOR EACH tFacRedetriskno:
    DELETE tFacRedetriskno.
END.

FOR EACH tFacRedetsub:
    DELETE tFacRedetsub.
END.

/*
FOR EACH wfsum:
    DELETE wfsum.
END.  */
/*-------------------------------*/

nv_asdat = nv_dateto.

fi_disp = "   Processing  ...! " .
DISP  fi_disp  WITH FRAME frmain . 

FOR EACH uwm100 USE-INDEX uwm10008 WHERE
         uwm100.comdat      >= nv_datefr        AND
         uwm100.comdat      <= nv_dateto        AND
         uwm100.dir_ri       = nv_source1       AND  
  INDEX(nv_brdes, "," + uwm100.branch) <> 0     AND
  SUBSTR(uwm100.policy,7,1) >= nv_brokfr        AND
  SUBSTR(uwm100.policy,7,1) <= nv_brokto        AND 
  SUBSTR(uwm100.policy,3,2) >= SUBSTR(nv_potypfr,2,2)  AND 
  SUBSTR(uwm100.policy,3,2) <= SUBSTR(nv_potypto,2,2)  AND
         uwm100.branch      >= nv_branfr        AND 
         uwm100.branch      <= nv_branto        AND
            ((nv_rel = "Y" AND  uwm100.releas = YES) OR
             (nv_rel = "N" AND  uwm100.releas = NO)  OR
             (nv_rel = "A" AND (uwm100.releas = YES  OR uwm100.releas = NO))) NO-LOCK ,

    
    FIRST uwm200  WHERE uwm200.policy = uwm100.policy AND
                        uwm200.rencnt = uwm100.rencnt AND
                        uwm200.endcnt = uwm100.endcnt AND 
                        uwm200.csftq  = "F"           NO-LOCK ,

    FIRST bfuwm100  WHERE bfuwm100.policy = uwm100.policy AND
                          bfuwm100.rencnt = uwm100.rencnt AND
                          bfuwm100.endcnt = uwm100.endcnt AND
                         (bfuwm100.polsta = "IF" OR
                          bfuwm100.polsta = "")  NO-LOCK . 

 /*   FOR EACH uwm200  WHERE uwm200.policy = uwm100.policy AND
                        uwm200.rencnt = uwm100.rencnt AND
                        uwm200.endcnt = uwm100.endcnt AND 
                        uwm200.csftq  = "F"           NO-LOCK .

    FOR EACH  bfuwm100  WHERE bfuwm100.policy = uwm100.policy AND
                         bfuwm100.rencnt = uwm100.rencnt AND
                         bfuwm100.endcnt = uwm100.endcnt AND
                        (bfuwm100.polsta = "IF" OR
                         bfuwm100.polsta = "")  NO-LOCK .  */

/*----------- june ---------------*/
    DISP uwm100.policy  WITH NO-LABEL TITLE "Printing Report..."  FRAME a  VIEW-AS DIALOG-BOX . /* june */
    IF uwm100.dir_ri = YES AND SUBSTRIN(uwm100.policy,1,1) = "I" THEN NEXT. 
    IF uwm100.dir_ri = NO  AND SUBSTRIN(uwm100.policy,1,1) = "D" THEN NEXT. 
    IF SUBSTRING(uwm100.policy,1,1) = "C" THEN NEXT.

    n_bran1     = "".
    n_bran1     = uwm100.branch.

    IF SUBSTR(uwm100.policy,1,1) = "I" THEN DO:
         
         IF nv_brdes1 = ""  THEN NEXT.
         IF INDEX(nv_brdes1,",9" + SUBSTRING(uwm100.policy,2,1)) <> 0 THEN 
             n_bran1 = "9" + SUBSTRING(uwm100.policy,2,1). 
         
    END.
    ELSE  DO:    
         IF INDEX("ABCDEFGHIJKLMNOPQRSTUVWXYZ" , nv_branto) <> 0  THEN DO: /*พบตัวอักษรในbranch*/
            IF uwm100.branch < nv_branfr OR uwm100.branch > nv_branto THEN NEXT.
         END.
         ELSE DO:
            IF INTEGER(uwm100.branch) < nv_brn_fr OR INTEGER(uwm100.branch) > nv_brn_to THEN NEXT.
         END.
    END.

    /*------------------- june --------------------*/
     ASSIGN
     nv_flood   = 0
     nv_storm   = 0
     nv_earth   = 0 .                                

    FIND FIRST uwm130 USE-INDEX uwm13001 WHERE 
               uwm130.policy = uwm100.policy AND 
               uwm130.rencnt = uwm100.rencnt AND 
               uwm130.endcnt = uwm100.endcnt NO-LOCK NO-ERROR.
           IF AVAIL uwm130 THEN DO : 
               
               IF uwm130.uom2_c = "FC" THEN nv_flood = uwm130.uom2_v.
               IF uwm130.uom2_c = "WI" THEN nv_storm = uwm130.uom2_v.
               IF uwm130.uom2_c = "EQ" THEN nv_earth = uwm130.uom2_v.
              
               IF uwm130.uom3_c = "FC" THEN nv_flood = uwm130.uom3_v. 
               IF uwm130.uom3_c = "WI" THEN nv_storm = uwm130.uom3_v.
               IF uwm130.uom3_c = "EQ" THEN nv_earth = uwm130.uom3_v.

               IF uwm130.uom4_c = "FC" THEN nv_flood = uwm130.uom4_v.  
               IF uwm130.uom4_c = "WI" THEN nv_storm = uwm130.uom4_v.
               IF uwm130.uom4_c = "EQ" THEN nv_earth = uwm130.uom4_v.
    END.  /* june */
    
 /*   FIND tFacRe WHERE tFacRe.asdat  = nv_asdat       AND
                      tFacRe.policy = uwm100.policy  NO-ERROR. */

    FIND tFacRe WHERE tFacRe.asdat  = nv_asdat       AND
                      tFacRe.policy = uwm100.policy  AND 
                        /*-------- june ------------*/
                      tFacRe.rencnt = uwm100.rencnt  AND
                      tFacRe.endcnt = uwm100.endcnt  NO-ERROR.
                        /*-------- june ------------*/

    IF NOT AVAILABLE tFacRe THEN DO:
        CREATE tFacRe.
        ASSIGN tFacRe.asdat  = nv_asdat
               tFacRe.policy = uwm100.policy
               tFacRe.bran   = n_bran1
               tFacRe.LINE   = uwm100.poltyp
               tFacRe.comdat = bfuwm100.comdat
               tFacRe.expdat = bfuwm100.expdat
               tFacRe.trndat = bfuwm100.trndat
               tFacRe.rencnt = bfuwm100.rencnt 
               tFacRe.endcnt = bfuwm100.endcnt.

    END.
    ASSIGN
    /*tFacRe.sigr   = bfuwm100.sigr*/
    tFacRe.coins  = bfuwm100.coins
    tFacRe.co_per = bfuwm100.co_per
        /*--------- june ------------*/
    tFacRe.flood  = nv_flood
    tFacRe.storm  = nv_storm
    tFacRe.earth  = nv_earth .
    
END.

FOR EACH tFacRe WHERE tFacRe.asdat = nv_asdat.

    ASSIGN
    tFacRe.polprm  = 0
    tFacRe.prem    = 0 .
   
    FOR EACH uwm100 USE-INDEX uwm10001  WHERE 
             uwm100.policy = tFacRe.policy AND
              /*-------- june ------------*/
             uwm100.rencnt = tFacRe.rencnt AND
             uwm100.endcnt = tFacRe.endcnt NO-LOCK.
             /*-------- june ------------*/
        tFacRe.Prem = tFacRe.prem + uwm100.prem_t.
    
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_facrepol_trn cC-Win 
PROCEDURE pd_facrepol_trn :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

FOR EACH tFacRe:
    DELETE tFacRe.
END.

FOR EACH tFacRedet :
    DELETE tFacRedet .
END.

FOR EACH tFacRedetriskno:
    DELETE tFacRedetriskno.
END.

FOR EACH tFacRedetsub:
    DELETE tFacRedetsub.
END.


nv_asdat = nv_dateto.

fi_disp = "   Processing  ...! " .
DISP  fi_disp  WITH FRAME frmain . 

FOR EACH uwm100 USE-INDEX uwm10008 WHERE
         uwm100.trndat      >= nv_datefr        AND
         uwm100.trndat      <= nv_dateto        AND
  INDEX(nv_brdes, "," + uwm100.branch) <> 0     AND
  SUBSTR(uwm100.policy,7,1) >= nv_brokfr        AND
  SUBSTR(uwm100.policy,7,1) <= nv_brokto        AND 
  SUBSTR(uwm100.policy,3,2) >= SUBSTR(nv_potypfr,2,2)  AND 
  SUBSTR(uwm100.policy,3,2) <= SUBSTR(nv_potypto,2,2)  AND
         uwm100.branch      >= nv_branfr        AND 
         uwm100.branch      <= nv_branto        AND
            ((nv_rel = "Y" AND  uwm100.releas = YES) OR
             (nv_rel = "N" AND  uwm100.releas = NO)  OR
             (nv_rel = "A" AND (uwm100.releas = YES  OR uwm100.releas = NO))) NO-LOCK ,

    
    FIRST uwm200  USE-INDEX uwm20001 WHERE 
          uwm200.policy = uwm100.policy AND
          uwm200.rencnt = uwm100.rencnt AND
          uwm200.endcnt = uwm100.endcnt AND 
          uwm200.csftq  = "F"           NO-LOCK ,

    FIRST bfuwm100  WHERE bfuwm100.policy = uwm100.policy AND
                          bfuwm100.rencnt = uwm100.rencnt AND
                          bfuwm100.endcnt = uwm100.endcnt   NO-LOCK  . 

/*----------- june ---------------*/
    IF fi_source = "I" THEN DO:   /* Inward (I) */
       IF uwm100.dir_ri = YES AND SUBSTRIN(uwm100.policy,1,1) <> "I" THEN NEXT.
    END.
    IF fi_source = "D" THEN DO:
       IF uwm100.dir_ri = NO  THEN NEXT. 
    END.


    DISP uwm100.policy  WITH NO-LABEL TITLE "Printing Report..."  FRAME a  VIEW-AS DIALOG-BOX . /* june */
     

    IF SUBSTRING(uwm100.policy,1,1) = "C" THEN NEXT.

    n_bran1     = "".
    n_bran1     = uwm100.branch.

    IF SUBSTR(uwm100.policy,1,1) = "I" THEN DO:
         
         IF nv_brdes1 = ""  THEN NEXT.
         IF INDEX(nv_brdes1,",9" + SUBSTRING(uwm100.policy,2,1)) <> 0 THEN 
             n_bran1 = "9" + SUBSTRING(uwm100.policy,2,1). 
         
    END.
    ELSE  DO:    
         IF INDEX("ABCDEFGHIJKLMNOPQRSTUVWXYZ" , nv_branto) <> 0  THEN DO: /*พบตัวอักษรในbranch*/
            IF uwm100.branch < nv_branfr OR uwm100.branch > nv_branto THEN NEXT.
         END.
         ELSE DO:
            IF INTEGER(uwm100.branch) < nv_brn_fr OR INTEGER(uwm100.branch) > nv_brn_to THEN NEXT.
         END.
    END.

    /*------------------- june --------------------*/
     ASSIGN
     nv_flood   = 0
     nv_storm   = 0
     nv_earth   = 0 .                                

    FIND FIRST uwm130 USE-INDEX uwm13001 WHERE 
               uwm130.policy = uwm100.policy AND 
               uwm130.rencnt = uwm100.rencnt AND 
               uwm130.endcnt = uwm100.endcnt NO-LOCK NO-ERROR.
           IF AVAIL uwm130 THEN DO : 
               
               IF uwm130.uom2_c = "FC" THEN nv_flood = uwm130.uom2_v.
               IF uwm130.uom2_c = "WI" THEN nv_storm = uwm130.uom2_v.
               IF uwm130.uom2_c = "EQ" THEN nv_earth = uwm130.uom2_v.
              
               IF uwm130.uom3_c = "FC" THEN nv_flood = uwm130.uom3_v. 
               IF uwm130.uom3_c = "WI" THEN nv_storm = uwm130.uom3_v.
               IF uwm130.uom3_c = "EQ" THEN nv_earth = uwm130.uom3_v.

               IF uwm130.uom4_c = "FC" THEN nv_flood = uwm130.uom4_v.  
               IF uwm130.uom4_c = "WI" THEN nv_storm = uwm130.uom4_v.
               IF uwm130.uom4_c = "EQ" THEN nv_earth = uwm130.uom4_v.
    END.  /* june */

    FIND tFacRe WHERE tFacRe.asdat  = nv_asdat       AND
                      tFacRe.policy = uwm100.policy  AND 
                      tFacRe.rencnt = uwm100.rencnt  AND
                      tFacRe.endcnt = uwm100.endcnt  NO-ERROR.
    IF NOT AVAILABLE tFacRe THEN DO:
        CREATE tFacRe.
        ASSIGN tFacRe.asdat  = nv_asdat
               tFacRe.policy = uwm100.policy
               tFacRe.bran   = n_bran1
               tFacRe.LINE   = uwm100.poltyp
               tFacRe.comdat = bfuwm100.comdat
               tFacRe.expdat = bfuwm100.expdat
               tFacRe.trndat = bfuwm100.trndat
               tFacRe.rencnt = bfuwm100.rencnt 
               tFacRe.endcnt = bfuwm100.endcnt .

    END.

    ASSIGN
    
    tFacRe.coins  = bfuwm100.coins
    tFacRe.co_per = bfuwm100.co_per
    tFacRe.co_sty = 100 - tFacRe.co_per
    tFacRe.flood  = nv_flood
    tFacRe.storm  = nv_storm
    tFacRe.earth  = nv_earth 
    tFacRe.prem   =  uwm100.prem_t.
    .
    
END.


/*
FOR EACH tFacRe WHERE tFacRe.asdat = nv_asdat NO-LOCK .

    ASSIGN
    tFacRe.polprm  = 0
    tFacRe.prem    = 0 .
   
    FOR EACH uwm100 USE-INDEX uwm10001  WHERE 
             uwm100.policy = tFacRe.policy AND     
             uwm100.rencnt = tFacRe.rencnt AND
             uwm100.endcnt = tFacRe.endcnt NO-LOCK.

        tFacRe.Prem = tFacRe.prem + uwm100.prem_t.
    
    END.
END.
*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_HeadPrem cC-Win 
PROCEDURE PD_HeadPrem :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
fi_disp = "   Processing  ...! " .
DISP  fi_disp  WITH FRAME frmain .

/*- Yes -*/
ASSIGN
  n_cnt   = 0
  n_cnt1  = 0
  n_etime = TIME. 

FOR EACH wvat7 .
  DELETE wvat7 .
END.

FOR EACH wfsum .
  DELETE wfsum .
END.

FOR EACH sym003 WHERE sym003.co = "00" NO-LOCK.
    ASSIGN 
       NAME_1 = sym003.scrhdr.
END.

nv_output = nv_output + ".slk".
OUTPUT STREAM ns1 TO VALUE(nv_output).
PUT STREAM ns1

    NAME_1   "วันที่พิมพ์ : " TODAY FORMAT "99/99/9999"  SKIP
    "สมุดทะเบียนการประกันภัยต่อตามสัญญา"   ";"
    "เวลาพิมพ์ : " STRING(n_etime,"HH:MM:SS")   ";"  "UZS007N6" SKIP
    "ประกันตรง/ต่อ" + " "  n_dir   ";"  nv_datetop       SKIP                            
    "พิมพ์โดย : "  SUBSTRING(n_user,3,6)    ";" "Release : " nv_rel  SKIP
    "ประเภท   "  nv_potypfr " - " nv_potypto     SKIP
    "กรมธรรม์"   ";"  "กรมธรรม์ (ท.บ.1,ท.บ.1.5)" SKIP 
    "AS Date : fi_asdat " SKIP .  /* june */

PUT STREAM ns1
  "สาขา" ";"
  "ประเภท Line กรมธรรม์" ";"  
  "วันทำสัญญา" ";"
  "วันที่เริ่มต้นคุ้มครอง" ";"  
  "เลขที่กรมธรรม์" ";"
  "No.of Risk" ";"
  "Agent Code" ";"
  "Reinsure Name" ";"
  "Reinsure Code" ";"
  "ชื่อผู้เอาประกัน" ";"
  "จำนวนเงินเอาประกันภัยรวม" ";"
  "Flood Cover" ";"
  "Windstorm" ";"
  "Earthquake" ";"
  "เบี้ยประกันภัยรวม" ";"
  "Comm/Disc ประกันภัยรวม"  ";" /* june */
  "%FO1" ";"
  "SI FO1" ";"
  "FO1" ";"   
  "% Vat" ";"   /*--Add VAT--*/
  "%FO2" ";"
  "SI FO2" ";" 
  "FO2" ";"    
  "% Vat" ";"   /*--Add VAT--*/
  "%T" ";"
  "SI 1ST" ";"
  "1ST" ";"   
  "% Vat" ";"   /*--Add VAT--*/
  "%S" ";"       
  "SI 2ND" ";"
  "2ND" ";"   
  "%Q" ";"       
  "SI Q" ";"
  "Q" ";"   
  "% Vat" ";"   /*--Add VAT--*/
  "%TFP" ";"  
  "SI TFP" ";" 
  "TFP" ";"    
  "%RQ" ";"    
  "SI RQ" ";"
  "RQ" ";"   
  "%R" ";"
  "SI R" ";"
  "R" ";"   
  "% Vat" ";"   /*--Add VAT--*/
  "%MPS" ";"     
  "SI MPS" ";"
  "MPS" ";"   
  "%BTR" ";"     
  "SI BTR" ";"
  "BTR" ";"   
  "%OTR" ";"   
  "SI OTR" ";"
  "OTR" ";"   
  "%F03 +S8" ";"  
  "SI FO3" ";"
  "FO3" ";"   
  "%FO4" ";"
  "SI FO4" ";"
  "FO4" ";"   
  "%FTR" ";"
  "SI FTR" ";" 
  "FTR" ";"    
  "%F Local Fac" ";"
  "SI Local Fac" ";"
  "Local Fac" ";"   
  "Local Fac Comm" ";" /* june */
  "%F Foreign Fac" ";"
  "SI Foreign Fac" ";"
  "Foreign Fac" ";"   
  "Foreign Fac Comm" ";"  SKIP.     /* june */
  
FIND FIRST xmm024 NO-LOCK NO-ERROR.

IF  nv_source1 = NO    THEN  nv_frm_policy = "I".
                       ELSE  nv_frm_policy = "D".
ASSIGN
n_fr_pol      =  nv_frm_policy
nv_frm_policy =  nv_frm_policy + nv_branfr + SUBSTR(nv_potypfr,2,2) +
                 SUBSTR(STRING(YEAR(nv_datefr) + 543,"9999"),3,2) + nv_brokfr
nv_to_policy  =  n_fr_pol + nv_branto + SUBSTRING(nv_potypto,2,2) +
                 SUBSTR(STRING(YEAR(nv_dateto) + 543 ,"9999"),3,2) + nv_brokto +
                 "ZZZZZZ".
ASSIGN
n_br2      = ""
n_mr2      = ""
           
nv_brdes   = ""
nv_brn_fr  = 0
nv_brn_to  = 0                         
nv_brdes1  = ""                       
i          = 0.

IF INDEX("ABCDEFGHIJKLMNOPQRSTUVWXYZ" , nv_branto) <> 0 THEN DO: /*branch เป็นตัวอักษร*/
    
    loop1:
    FOR EACH xmm023 WHERE xmm023.branch >= nv_branfr AND
                          xmm023.branch <= nv_branto NO-LOCK BREAK BY branch:

        IF xmm023.branch < nv_branfr OR xmm023.branch > nv_branto THEN NEXT loop1.

        IF LENGTH(xmm023.branch) = 1 THEN DO:
            nv_brdes = nv_brdes + "," + xmm023.branch.
        END.
        ELSE DO:
            IF SUBSTR(xmm023.branch,1,1) = "9" AND SUBSTR(xmm023.branch,2,1) <> "0" THEN DO:
                ASSIGN
                nv_brdes  = nv_brdes + "," + substr(xmm023.branch,2,1)
                nv_brdes  = nv_brdes + "," + xmm023.branch
                nv_brdes1 = nv_brdes1 + "," + xmm023.branch.
            END.
            ELSE nv_brdes = nv_brdes + "," + xmm023.branch.
        END.
    END.
END.
ELSE DO: /*แสดงว่าเป็นตัวเลข*/
    ASSIGN
    nv_brn_fr = INTE(nv_branfr)
    nv_brn_to = INTE(nv_branto).

    loop2:
    FOR EACH xmm023 WHERE xmm023.branch >= nv_branfr AND
                          xmm023.branch <= nv_branto NO-LOCK BREAK BY branch:
 
        IF LENGTH(xmm023.branch) = 1 THEN DO:
           nv_brdes = nv_brdes + "," + xmm023.branch.
        END.
        ELSE DO:
            IF SUBSTR(xmm023.branch,1,1) = "9" AND SUBSTR(xmm023.branch,2,1) <> "0" THEN DO:
                nv_brdes  = nv_brdes + "," + substr(xmm023.branch,2,1).
                nv_brdes  = nv_brdes + "," + xmm023.branch.
                nv_brdes1 = nv_brdes1 + "," + xmm023.branch.
            END.
            ELSE nv_brdes = nv_brdes + "," + xmm023.branch.
            
            IF LENGTH(nv_branfr) = 1 AND LENGTH(nv_branto) = 2 THEN DO: /*วนค่าในกรณีที่เรียกbranch form-to 1-10*/
                DO i = nv_brn_fr TO nv_brn_to :
                    nv_brdes = nv_brdes + "," + STRING(i).
                END.
            END.
        END.
    END.
END.
   
FOR EACH wt_uwm200.
  DELETE wt_uwm200.
END.


IF rd_date = 1 THEN RUN PD_Bytrndat .

IF rd_date = 2 THEN RUN PD_Bycomdat .
*/


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_Inward cC-Win 
PROCEDURE pd_Inward :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
vFirstTime =  STRING(TIME, "HH:MM AM").
/*---a460017-----*/ /*สำหรับรวมค่าแต่ละ Line */
DEF VAR n_txt1   AS CHAR FORMAT "x(25)".
DEF VAR n_suml1  AS DEC  FORMAT ">>>>>>>>9.99-".
DEF VAR n_suml2  AS DEC  FORMAT ">>>>>>>>9.99-".
DEF VAR n_suml3  AS DEC  FORMAT ">>>>>>>>9.99-".
DEF VAR n_suml4  AS DEC  FORMAT ">>>>>>>>9.99-".
DEF VAR n_suml5  AS DEC  FORMAT ">>>>>>>>9.99-".
DEF VAR n_suml6  AS DEC  FORMAT ">>>>>>>>9.99-".
DEF VAR nu_vat_l AS DEC  FORMAT ">>>>>>>>9.99-".
DEF VAR nu_sbt_l AS DEC  FORMAT ">>>>>>>>9.99-".
/*---------------*/   

DEF VAR nv_output   AS CHAR    FORMAT "X(12)".

ASSIGN nv_oicline = ""
       nv_uwline = ""
       nv_uwlinedesc = ""
       nv_occup = "".

nv_output = fi_output + ".SLK".
n_etime = time.

OUTPUT TO VALUE(nv_output) NO-ECHO.
EXPORT DELIMITER ";"
 "สมุดทะเบียนรับประกันภัยต่อเฉพาะราย (กรมธรรม์) " 
 nv_datetop  
 "วันที่พิมพ์:"  + STRING(TODAY,"99/99/9999") + " เวลาที่พิมพ์:" + STRING(n_eTIME,"hh:mm:ss") .
EXPORT DELIMITER ";"
 "Branch"  
 "Line" 
 "Trn Date"  
 "Policy" 
 "Endorse No."
 "Com Date" 
 "Exp Date"
 "Agent"
 "Agent Name" 
 "Ced Co"
 "TranType"
 "Docno"
 "Sum Insured"
 "Premium"
 "Commission"
 "Comm. %" 
 "สุทธิ" 
 "Flood Cover"  
 "Windstorm"    
 "Earthquake"
 "Licence No" 
 "Occupation Cl"
 "วันที่รับประกันภัยต่อ"
 "หมายเหตุ" 
 "OIC Line" 
 "UW Line" 
 "Line Description" 
 "Producer"
 "Producer Name"
 "Cedant Code"
 "Cedant Name".
OUTPUT CLOSE.

IF rd_date = 1 THEN DO: /* by Trans Date */
    FOR EACH uwm100 USE-INDEX uwm10008 NO-LOCK WHERE
             uwm100.trndat      >= nv_datefr        AND
             uwm100.trndat      <= nv_dateto        AND
             uwm100.DIR_ri       = NO               AND
             uwm100.branch      >= nv_branfr        AND 
             uwm100.branch      <= nv_branto        AND
      SUBSTR(uwm100.policy,7,1) >= nv_brokfr        AND
      SUBSTR(uwm100.policy,7,1) <= nv_brokto        AND 
      SUBSTR(uwm100.policy,3,2) >= SUBSTR(nv_potypfr,2,2)  AND 
      SUBSTR(uwm100.policy,3,2) <= SUBSTR(nv_potypto,2,2)  AND
            ((nv_rel = "Y" AND  uwm100.releas = YES) OR
             (nv_rel = "N" AND  uwm100.releas = NO)  OR
             (nv_rel = "A" AND (uwm100.releas = YES  OR uwm100.releas = NO)))
    BREAK  BY uwm100.trndat
           BY uwm100.branch
           BY uwm100.poltyp  /*a460017*/
           BY uwm100.policy
           BY TRANTY:
   
         /*Begin Check Department Type */
        FIND FIRST xmm031 USE-INDEX xmm03101 WHERE xmm031.poltyp = uwm100.poltyp NO-LOCK NO-ERROR.
        IF NOT AVAIL xmm031 THEN NEXT.
        /*IF xmm031.dept = "G" OR xmm031.dept = "M" THEN NEXT.*/
       
        IF  FIRST-OF(uwm100.branch)   THEN
            ASSIGN      n_sum1b   =  0
                        n_sum2b   =  0
                        n_sum3b   =  0
                        n_sum4b   =  0 .
        
        IF FIRST-OF(uwm100.poltyp)    THEN
            ASSIGN       n_suml1   =  0
                         n_suml2   =  0
                         n_suml3   =  0
                         n_suml4   =  0 .

        
     ASSIGN
     nv_flood   = 0
     nv_storm   = 0
     nv_earth   = 0 .                                

     FIND FIRST uwm130 USE-INDEX uwm13001 WHERE 
                uwm130.policy = uwm100.policy AND 
                uwm130.rencnt = uwm100.rencnt AND 
                uwm130.endcnt = uwm100.endcnt NO-LOCK NO-ERROR.
            IF AVAIL uwm130 THEN DO : 
                
                IF uwm130.uom2_c = "FC" THEN nv_flood = uwm130.uom2_v.
                IF uwm130.uom2_c = "WI" THEN nv_storm = uwm130.uom2_v.
                IF uwm130.uom2_c = "EQ" THEN nv_earth = uwm130.uom2_v.
               
                IF uwm130.uom3_c = "FC" THEN nv_flood = uwm130.uom3_v. 
                IF uwm130.uom3_c = "WI" THEN nv_storm = uwm130.uom3_v.
                IF uwm130.uom3_c = "EQ" THEN nv_earth = uwm130.uom3_v.
    
                IF uwm130.uom4_c = "FC" THEN nv_flood = uwm130.uom4_v.  
                IF uwm130.uom4_c = "WI" THEN nv_storm = uwm130.uom4_v.
                IF uwm130.uom4_c = "EQ" THEN nv_earth = uwm130.uom4_v.
     END.  
        
        
        FIND FIRST xmm023 USE-INDEX  xmm02301 WHERE uwm100.branch = xmm023.branch
                                     NO-LOCK NO-ERROR.
        
            n_branch = uwm100.branch.
            n_bdes   = xmm023.bdes.
            n_dir    = uwm100.dir_ri.
            n_dept   = uwm100.dept.
            
            n_an     = 0.
            n_sum6   = 0.
            nv_sum   = 0.
            nv_code  = " ".
            nvexch   = 1.
            
            /*--- Find SI UWM120 ---*/
            nv_sum = 0.
            IF LAST-OF(uwm100.policy)  THEN DO:
               RUN pd_si120.
            END.
            
            FIND FIRST uwm120 USE-INDEX uwm12001 WHERE uwm120.policy = uwm100.policy AND
                                                   uwm120.rencnt = uwm100.rencnt
                                                   NO-LOCK NO-ERROR.
            IF AVAIL uwm120 THEN DO:
                nvcurr   = uwm120.sicurr.
                nv_com1p = uwm120.com1p.
            IF SUBSTRING(uwm120.policy,3,2) = "90" THEN nvexch = 1.
            ELSE  nvexch   = uwm120.siexch.
            END.
            n_an =  round(nvexch * nv_sum,2).
            nv_sum  =  n_an.
        
            FIND XMM600 WHERE XMM600.ACNO = UWM100.AGENT NO-LOCK NO-ERROR.
            IF NOT AVAILABLE XMM600 THEN DO:
               ASSIGN N_AGENT = " NOT FOUND PRODUCER CODE " + UWM100.AGENT
                      nv_ricoagtreg    = "".
            END.
            ELSE DO:
               ASSIGN N_AGENT =  XMM600.NAME
                      nv_ricoagtreg    =  xmm600.agtreg.
            END.
        
            n_percen  = "%".
            n_sum6    = uwm100.prem_t + uwm100.com1_t.

            FOR EACH uwm304 NO-LOCK WHERE uwm304.policy = tfacre.policy AND
                                          uwm304.rencnt = tfacre.rencnt AND 
                                          uwm304.endcnt = tfacre.endcnt 
                                    BREAK BY uwm304.policy 
                                          BY uwm304.rencnt 
                                          BY uwm304.endcnt. 
            
                IF FIRST-OF (uwm304.policy) THEN ASSIGN nv_occup = uwm304.occupn.
                ELSE nv_occup = nv_occup + "/" + uwm304.occupn.
            END.

            nv_uwline = SUBSTR(uwm100.policy,3,2).

            RUN pd_line.

            /*------aaaaaaaaa-------*/
            ASSIGN nn_acno = ""
                   nn_acnoname = ""
                   nn_cedco = ""
                   nn_cedname = "".

            FIND xmm600 NO-LOCK WHERE xmm600.acno = uwm100.acno1 NO-ERROR.
            IF AVAILABLE xmm600 THEN DO:
            
               ASSIGN nn_acno          = xmm600.acno
                      nn_acnoname      = xmm600.NAME.
            END.
            ELSE ASSIGN nn_acno        = ""
                        nn_acnoname    = "".

            FIND xmm600 NO-LOCK WHERE xmm600.acno = uwm100.cedco NO-ERROR.
            IF AVAILABLE xmm600 THEN DO:
            
               ASSIGN nn_cedco         = xmm600.acno
                      nn_cedname       = xmm600.NAME.
            END.
            ELSE ASSIGN nn_acno        = ""
                        nn_acnoname    = "".
            /*-----------------------*/
            
            OUTPUT TO VALUE(nv_output) APPEND NO-ECHO.
            EXPORT DELIMITER ";"
             n_branch       
             uwm100.poltyp  
             uwm100.trndat  FORMAT "99/99/9999" 
             uwm100.policy 
             uwm100.endno  
             uwm100.comdat  FORMAT "99/99/9999" 
             uwm100.expdat  FORMAT "99/99/9999" 
             UWM100.AGENT   FORMAT "X(10)"
             n_agent        FORMAT "X(80)" 
             uwm100.cedco   FORMAT "X(10)"
             uwm100.trty11  
             uwm100.docno1  FORMAT "X(10)"
             nv_sum         FORMAT "->>,>>>,>>>,>>9.99" 
             uwm100.prem_t  FORMAT "->>,>>>,>>>,>>9.99" 
             uwm100.com1_t  FORMAT "->>,>>>,>>>,>>9.99" 
             nv_com1p 
             n_percen  
             n_sum6 
             nv_flood
             nv_storm
             nv_earth
             nv_ricoagtreg
             nv_occup
             " "              /*วันที่รับประกันภัยต่อ*/
             " "  /*หมายเหตุ*/
             nv_oicline
             nv_uwline
             nv_uwlinedesc
             nn_acno
             nn_acnoname
             nn_cedco
             nn_cedname.
            OUTPUT CLOSE.
            
           /*--รวมค่าแต่ละ Line--*/
           n_suml1 =  n_suml1 +  nv_sum.
           n_suml2 =  n_suml2 +  uwm100.prem_t.
           n_suml3 =  n_suml3 +  uwm100.com1_t.
           n_suml4 =  n_suml4 +  n_sum6.
        
           IF LAST-OF(uwm100.poltyp)  THEN DO:
               n_txt1   =   "รวม" + "  " + uwm100.poltyp.
        
                OUTPUT TO VALUE(nv_output) APPEND NO-ECHO.
                EXPORT DELIMITER ";"
                   "" "" "" "" "" "" n_txt1 
                   n_suml1      FORMAT "->>,>>>,>>>,>>9.99"
                   n_suml2      FORMAT "->>,>>>,>>>,>>9.99"
                   n_suml3      FORMAT "->>,>>>,>>>,>>9.99"
                   ""
                   n_suml4  FORMAT "->>,>>>,>>>,>>9.99".
                OUTPUT CLOSE.
           END.
        
           /*---รวมค่าแต่ละ Branch---*/
           n_sum1b =  n_sum1b +  nv_sum.
           n_sum2b =  n_sum2b +  uwm100.prem_t.
           n_sum3b =  n_sum3b +  uwm100.com1_t.
           n_sum4b =  n_sum4b +  n_sum6.
        
           IF  LAST-OF(uwm100.branch)    THEN DO:
              
               n_insur = "รวมสาขา" + " " + uwm100.branch + " " + n_bdes.
               
                OUTPUT TO VALUE(nv_output) APPEND NO-ECHO.
                EXPORT DELIMITER ";"
                   "" "" "" "" "" "" n_insur 
                   n_sum1b      FORMAT "->>,>>>,>>>,>>9.99" 
                   n_sum2b      FORMAT "->>,>>>,>>>,>>9.99" 
                   n_sum3b      FORMAT "->>,>>>,>>>,>>9.99" 
                   ""
                   n_sum4b  FORMAT "->>,>>>,>>>,>>9.99".
                OUTPUT CLOSE.
                   
           END.
    END. /*FOR EACH*/ 
END.  /* Begin Expiry Date Chaiyong A54-0009 12/01/2011 */
IF rd_date = 2 THEN DO:
    FOR EACH uwm100 USE-INDEX uwm10093 NO-LOCK WHERE
             uwm100.expdat >= fi_datefr  AND
             uwm100.expdat <= fi_dateto  AND
             uwm100.poltyp >= fi_potypfr AND     
             uwm100.poltyp <= fi_potypto AND 
             uwm100.branch >= fi_branfr  AND
             uwm100.branch <= fi_branto  AND
          /*   uwm100.endcnt = 000        AND*/
             SUBSTRI(uwm100.policy,1,1) = "I"  AND
            uwm100.releas
            BREAK  BY uwm100.branch
                   BY uwm100.poltyp 
                   BY uwm100.policy
                   BY uwm100.expdat
                   BY TRANTY:

         /*Begin Check Department Type */
        FIND FIRST xmm031 USE-INDEX xmm03101 WHERE xmm031.poltyp = uwm100.poltyp NO-LOCK NO-ERROR.
        IF NOT AVAIL xmm031 THEN NEXT.
        IF xmm031.dept = "G" OR xmm031.dept = "M" THEN NEXT.
        
        IF  FIRST-OF(uwm100.branch)   THEN
            ASSIGN      n_sum1b   =  0
                        n_sum2b   =  0
                        n_sum3b   =  0
                        n_sum4b   =  0 .
        
        IF FIRST-OF(uwm100.poltyp)    THEN
            ASSIGN       n_suml1   =  0
                         n_suml2   =  0
                         n_suml3   =  0
                         n_suml4   =  0 .
     ASSIGN
     nv_flood   = 0
     nv_storm   = 0
     nv_earth   = 0 .                                

    FIND FIRST uwm130 USE-INDEX uwm13001 WHERE 
               uwm130.policy = uwm100.policy AND 
               uwm130.rencnt = uwm100.rencnt AND 
               uwm130.endcnt = uwm100.endcnt NO-LOCK NO-ERROR.
           IF AVAIL uwm130 THEN DO : 
               
               IF uwm130.uom2_c = "FC" THEN nv_flood = uwm130.uom2_v.
               IF uwm130.uom2_c = "WI" THEN nv_storm = uwm130.uom2_v.
               IF uwm130.uom2_c = "EQ" THEN nv_earth = uwm130.uom2_v.
              
               IF uwm130.uom3_c = "FC" THEN nv_flood = uwm130.uom3_v. 
               IF uwm130.uom3_c = "WI" THEN nv_storm = uwm130.uom3_v.
               IF uwm130.uom3_c = "EQ" THEN nv_earth = uwm130.uom3_v.

               IF uwm130.uom4_c = "FC" THEN nv_flood = uwm130.uom4_v.  
               IF uwm130.uom4_c = "WI" THEN nv_storm = uwm130.uom4_v.
               IF uwm130.uom4_c = "EQ" THEN nv_earth = uwm130.uom4_v.
    END.  
        
        
        FIND FIRST xmm023 USE-INDEX  xmm02301 WHERE uwm100.branch = xmm023.branch
                                     NO-LOCK NO-ERROR.
        
            n_branch = uwm100.branch.
            n_bdes   = xmm023.bdes.
            n_dir    = uwm100.dir_ri.
            n_dept   = uwm100.dept.
            
            n_an     = 0.
            n_sum6   = 0.
            nv_sum   = 0.
            nv_code  = " ".
            nvexch   = 1.
            
        nv_sum = 0.
        IF LAST-OF(uwm100.policy)  THEN DO:
           RUN pd_si120.
        END.
        
        FIND FIRST uwm120 USE-INDEX uwm12001 WHERE uwm120.policy = uwm100.policy AND
                                                   uwm120.rencnt = uwm100.rencnt
                                                   NO-LOCK NO-ERROR.
            IF AVAIL uwm120 THEN
            DO:
                nvcurr   = uwm120.sicurr.
                nv_com1p = uwm120.com1p.
            IF SUBSTRING(uwm120.policy,3,2) = "90" THEN nvexch = 1.
            ELSE  nvexch   = uwm120.siexch.
            END.
            n_an =  round(nvexch * nv_sum,2).
            nv_sum  =  n_an.
        
        FIND XMM600 WHERE XMM600.ACNO = UWM100.AGENT NO-LOCK NO-ERROR.
            IF NOT AVAILABLE XMM600 THEN DO:
               ASSIGN  N_AGENT = " NOT FOUND PRODUCER CODE " + UWM100.AGENT
                       nv_ricoagtreg    =  "".
            END.
            ELSE DO.
               ASSIGN N_AGENT =  XMM600.NAME
                      nv_ricoagtreg    =  xmm600.agtreg.
            END.
        
            n_percen  = "%".
            n_sum6    = uwm100.prem_t + uwm100.com1_t.

            FOR EACH uwm304 NO-LOCK WHERE uwm304.policy = tfacre.policy AND
                                          uwm304.rencnt = tfacre.rencnt AND 
                                          uwm304.endcnt = tfacre.endcnt 
                                    BREAK BY uwm304.policy 
                                          BY uwm304.rencnt 
                                          BY uwm304.endcnt. 
            
                IF FIRST-OF (uwm304.policy) THEN ASSIGN nv_occup = uwm304.occupn.
                ELSE nv_occup = nv_occup + "/" + uwm304.occupn.
            END.
          
            nv_uwline = SUBSTR(uwm100.policy,3,2).

            RUN pd_line.

            /*------aaaaaaaaa-------*/
            ASSIGN nn_acno = ""
                   nn_acnoname = ""
                   nn_cedco = ""
                   nn_cedname = "".

            FIND xmm600 NO-LOCK WHERE xmm600.acno = uwm100.acno1 NO-ERROR.
            IF AVAILABLE xmm600 THEN DO:
            
               ASSIGN nn_acno          = xmm600.acno
                      nn_acnoname      = xmm600.NAME.
            END.
            ELSE ASSIGN nn_acno        = ""
                        nn_acnoname    = "".

            FIND xmm600 NO-LOCK WHERE xmm600.acno = uwm100.cedco NO-ERROR.
            IF AVAILABLE xmm600 THEN DO:
            
               ASSIGN nn_cedco         = xmm600.acno
                      nn_cedname       = xmm600.NAME.
            END.
            ELSE ASSIGN nn_acno        = ""
                        nn_acnoname    = "".
            /*-----------------------*/

            OUTPUT TO VALUE(nv_output) APPEND NO-ECHO.
            EXPORT DELIMITER ";"
             n_branch       
             uwm100.poltyp  
             uwm100.trndat  FORMAT "99/99/9999" 
             uwm100.policy 
             uwm100.comdat  FORMAT "99/99/9999" 
             uwm100.expdat  FORMAT "99/99/9999" 
             UWM100.AGENT   FORMAT "X(10)"
             n_agent        FORMAT "X(80)" 
             uwm100.trty11  
             uwm100.docno1  FORMAT "X(10)"
             nv_sum         FORMAT "->>,>>>,>>>,>>9.99" 
             uwm100.prem_t  FORMAT "->>,>>>,>>>,>>9.99" 
             uwm100.com1_t  FORMAT "->>,>>>,>>>,>>9.99" 
             nv_com1p n_percen  
             n_sum6 
             nv_flood
             nv_storm
             nv_earth
             nv_ricoagtreg
             nv_occup
             " "              /*วันที่รับประกันภัยต่อ*/
             " "  /*หมายเหตุ*/
             nv_oicline
             nv_uwline
             nv_uwlinedesc
             nn_acno
             nn_acnoname
             nn_cedco
             nn_cedname.
            OUTPUT CLOSE.
        
           /*--รวมค่าแต่ละ Line--*/
           n_suml1 =  n_suml1 +  nv_sum.
           n_suml2 =  n_suml2 +  uwm100.prem_t.
           n_suml3 =  n_suml3 +  uwm100.com1_t.
           n_suml4 =  n_suml4 +  n_sum6.
        
           IF LAST-OF(uwm100.poltyp)  THEN DO:
               n_txt1   =   "รวม" + "  " + uwm100.poltyp.
        
               
                OUTPUT TO VALUE(nv_output) APPEND NO-ECHO.
                EXPORT DELIMITER ";"
                   "" "" "" "" "" "" n_txt1
                   n_suml1      FORMAT "->>,>>>,>>>,>>9.99"
                   n_suml2      FORMAT "->>,>>>,>>>,>>9.99"
                   n_suml3      FORMAT "->>,>>>,>>>,>>9.99"
                   ""
                   n_suml4  FORMAT "->>,>>>,>>>,>>9.99".
           END.
        
           /*---รวมค่าแต่ละ Branch---*/
           n_sum1b =  n_sum1b +  nv_sum.
           n_sum2b =  n_sum2b +  uwm100.prem_t.
           n_sum3b =  n_sum3b +  uwm100.com1_t.
           n_sum4b =  n_sum4b +  n_sum6.
        
           IF  LAST-OF(uwm100.branch)    THEN DO:
               n_insur = "รวมสาขา" + " " + uwm100.branch + " " + n_bdes.
               
                OUTPUT TO VALUE(nv_output) APPEND NO-ECHO.
                EXPORT DELIMITER ";"
                   "" "" "" "" "" "" n_insur 
                   n_sum1b      FORMAT "->>,>>>,>>>,>>9.99"
                   n_sum2b      FORMAT "->>,>>>,>>>,>>9.99"
                   n_sum3b      FORMAT "->>,>>>,>>>,>>9.99"
                   "" 
                   n_sum4b  FORMAT "->>,>>>,>>>,>>9.99".
           END.
    END. /*FOR EACH*/
END. /*End  */
HIDE MESSAGE NO-PAUSE.
/* End of uzspr501.p */



vLastTime = STRING(TIME, "HH:MM AM").

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_line cC-Win 
PROCEDURE pd_line :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

IF nv_uwline = "10" THEN DO:

   ASSIGN nv_oicline   = "NL2310"
          nv_uwlinedesc = "Fire" + nv_uwline.

END.
ELSE IF nv_uwline = "18" THEN DO:

   ASSIGN nv_oicline   = "NL2310"
          nv_uwlinedesc = "FireCatas" + nv_uwline.

END.
ELSE IF nv_uwline = "91" THEN DO:

   ASSIGN nv_oicline   = "NL2321"
          nv_uwlinedesc = "Hull" + nv_uwline.

END.
ELSE IF nv_uwline = "90" OR
        nv_uwline = "92" OR 
        nv_uwline = "31" THEN DO:

   ASSIGN nv_oicline   = "NL2322"
          nv_uwlinedesc = "Marine" + nv_uwline.

END.
ELSE IF nv_uwline = "93" THEN DO:

   ASSIGN nv_oicline   = "NL2322"
          nv_uwlinedesc = "Carrier Liability" + nv_uwline.

END.
ELSE IF nv_uwline = "72" THEN DO:

   ASSIGN nv_oicline   = "NL2331"
          nv_uwlinedesc = "Mocom" + nv_uwline.

END.
ELSE IF nv_uwline = "71" THEN DO:

   ASSIGN nv_oicline   = "NL2331"
          nv_uwlinedesc = "Motor (Mocom(" + nv_uwline.

END.
ELSE IF nv_uwline = "73" OR
        nv_uwline = "74" THEN DO:

   ASSIGN nv_oicline   = "NL2331"
          nv_uwlinedesc = "Motorcycle (Mocom)" + nv_uwline.

END.
ELSE IF nv_uwline = "70" THEN DO:

   ASSIGN nv_oicline   = "NL2332"
          nv_uwlinedesc = "Motor" + nv_uwline.

END.
ELSE IF nv_uwline = "11" OR
        nv_uwline = "12" OR 
        nv_uwline = "13" THEN DO:

   ASSIGN nv_oicline   = "NL2341"
          nv_uwlinedesc = "All Risk" + nv_uwline.

END.
ELSE IF nv_uwline = "14" OR
        nv_uwline = "15" OR 
        nv_uwline = "16" OR 
        nv_uwline = "17" OR
        nv_uwline = "18" OR 
        nv_uwline = "19" THEN DO:

   ASSIGN nv_oicline   = "NL2341"
          nv_uwlinedesc = "Asset" + nv_uwline.

END.
ELSE IF nv_uwline = "20" OR
        nv_uwline = "32" OR 
        nv_uwline = "33" OR 
        nv_uwline = "34" OR
        nv_uwline = "35" OR 
        nv_uwline = "36" OR
        nv_uwline = "39"  THEN DO:

   ASSIGN nv_oicline   = "NL2341"
          nv_uwlinedesc = "Prop" + nv_uwline.

END.
ELSE IF nv_uwline = "40" OR
        nv_uwline = "41" OR 
        nv_uwline = "43" THEN DO:

   ASSIGN nv_oicline   = "NL2342"
          nv_uwlinedesc = "Prop" + nv_uwline.

END.
ELSE IF nv_uwline = "60" OR       
        nv_uwline = "62" OR       
        nv_uwline = "63" OR       
        nv_uwline = "64" OR       
        nv_uwline = "67" THEN DO: 

   ASSIGN nv_oicline   = "NL2343"
          nv_uwlinedesc = "PA" + nv_uwline.

END.
ELSE IF nv_uwline = "61" THEN DO: 

   ASSIGN nv_oicline   = "NL2344"
          nv_uwlinedesc = "Healthcare" + nv_uwline.

END.
ELSE IF nv_uwline = "65" OR       
        nv_uwline = "66" THEN DO: 

   ASSIGN nv_oicline   = "NL2344"
          nv_uwlinedesc = "Health" + nv_uwline.

END.
ELSE IF nv_uwline = "68" OR       
        nv_uwline = "69" THEN DO: 

   ASSIGN nv_oicline   = "NL2345"
          nv_uwlinedesc = "TA" + nv_uwline.

END.
ELSE IF nv_uwline = "80" OR       
        nv_uwline = "81" OR       
        nv_uwline = "82" OR       
        nv_uwline = "83" OR       
        nv_uwline = "84" OR 
        nv_uwline = "85" THEN DO: 

   ASSIGN nv_oicline   = "NL2347"
          nv_uwlinedesc = "Eng" + nv_uwline.

END.
ELSE IF nv_uwline = "30" THEN DO: 

   ASSIGN nv_oicline   = "NL2347"
          nv_uwlinedesc = "MC" + nv_uwline.

END.
ELSE IF nv_uwline = "01" OR nv_uwline = "02" OR 
        nv_uwline = "03" OR nv_uwline = "04" OR     
        nv_uwline = "05" OR nv_uwline = "06" OR     
        nv_uwline = "07" OR nv_uwline = "08" OR
        nv_uwline = "09" OR nv_uwline = "50" OR 
        nv_uwline = "51" OR nv_uwline = "52" OR 
        nv_uwline = "53" OR nv_uwline = "54" OR
        nv_uwline = "55" OR nv_uwline = "56" OR 
        nv_uwline = "57" OR nv_uwline = "58" OR 
        nv_uwline = "59" THEN DO: 

   ASSIGN nv_oicline   = "NL2347"
          nv_uwlinedesc = "Misc" + nv_uwline.

END.
ELSE DO:

    ASSIGN nv_oicline   = "NL2347"
           nv_uwlinedesc = "Other" + nv_uwline.

END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_processclm cC-Win 
PROCEDURE PD_processclm :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
nv_output = nv_output + ".slk".
OUTPUT STREAM ns1 TO VALUE(nv_output).  /* For Detail Output To Excel */

/*--------     Header for Excel (ns1)    --------------*/
PUT STREAM ns1 "Statement Claim Paid Outward"      SKIP.
PUT STREAM ns1 "From  "  nv_datefr  "  To  "  nv_dateto  SKIP.
PUT STREAM ns1 "As Date  " TODAY FORMAT "99/99/9999"     SKIP.  

/*PUT STREAM ns1 "As Date : " fi_asdat     SKIP.   /* june */*/

PUT STREAM ns1 "BRANCH" ";"
               "POLICY TYPE" ";"
               "POLICY DES." ";"
               "GROUP TYPE"  ";"
               "POLICY"      ";"
               "TRANS.DATE R/E CNT." ";" 
               "COMM.DATE "  ";"
               "CLAIM" ";"
               "Agent Code"      ";"
               "Reinsurer Name"  ";"
               "Reinsurer Code"  ";"
               "LOSS DATE" ";"
               "NATURE"    ";"
               "INSURE NAME"   ";"  
               "CAUSE OF LOSS" ";"  
               "PV/CF" ";"
               "REQ.NO." ";"
               "ENTRY DATE" ";"
               "PAID DATE" ";"
               "TOTAL CLAIM" ";"
               "SURVEY FEE" ";"
               "NETVAT" ";"
               "VAT" ";"
               "TAX 3%" ";"
               "NETAMT" ";"
               "Claim Paid"    ";" 
               "Due to"        ";" 
               "Total Fac RI"  ";" 
               "Received"      ";" 
               "Due from"      ";" 
               "OS Reserve"    ";" 
               "1st TREATY" ";"
               "2nd TREATY" ";"
               "FAC. RI." ";"
               "Q.S. 5 %" ";"
               "TFP" ";"
               "MPS" ";"
               "ENG. FAC."  ";"
               "MARINE O/P" ";"
               "R.Q." ";"
               "BTR" ";"
               "OTR" ";"
               "FTR" ";"
               "F/O I"   ";"
               "F/O II"  ";"
               "F/O III" ";"
               "F/O IV"  ";"
               "RET."    ";"
               "GROSS RET."  ";"
               "XOL."        ";"
               "Gross QS BH" ";"
               "TTY QS BH"   ";"
               "Fac QS BH"   ";"
               "Other QS BH" ";"
               "ACNO" ";"
               "PAYEE" ";"
               "CLICOD" ";"
               "USER ID" ";"
               "ADJUSTER" ";"
               "DETAIL"   ";"
               "RELEAS"   ";"
               "STATUS"   ";"
               "COINS."   ";"
               "CO %"     ";"
               "FAC. LOC."  ";"
               "FAC. ASIAN" ";"
               "FAC. FOR."  ";"
               "FAC. ERR."  ";"
               "OTHER"    SKIP.  
ASSIGN

nv_sumtax = 0
nv_sumamt = 0
nv_sumtot = 0  .

/*----------   End Header for Excel   ------------*/
    
FOR EACH WCLM130 NO-LOCK BREAK BY WCLM130.DIR_RI
                               BY WCLM130.BRANCH
                               BY SUBSTRING(WCLM130.POLTYP,2,2)
                               BY WCLM130.POLICY
                               BY WCLM130.CLAIM 
                               BY WCLM130.DOCNO :

   IF FIRST-OF(WCLM130.DIR_RI) THEN
      n_dir_ri   = WCLM130.DIR_RI.

   IF FIRST-OF(WCLM130.BRANCH) THEN DO:
      n_branch  = WCLM130.BRANCH.
      jv_bran   = WCLM130.BRANCH.
   END.
   IF FIRST-OF(SUBSTRING(WCLM130.POLTYP,2,2)) THEN n_poltyp   = WCLM130.POLTYP.

   FIND CLM100 USE-INDEX CLM10001     WHERE
        CLM100.CLAIM  = WCLM130.CLAIM NO-LOCK NO-ERROR NO-WAIT.
   IF NOT AVAILABLE CLM100 THEN NEXT.

   ASSIGN nv_coins  = NO
          nv_coper  = 0  
          nv_osr    = 0
          nv_paid   = 0.
   
   FIND LAST UWM100 USE-INDEX UWM10001 WHERE
        UWM100.POLICY = CLM100.POLICY NO-LOCK NO-ERROR NO-WAIT.
   IF AVAILABLE UWM100 THEN DO:
      nv_coins  = UWM100.COINS.
      IF UWM100.COINS  = YES  AND
         UWM100.CO_PER <> 0   THEN nv_coper = 100 - UWM100.CO_PER.
   END.

   /* WCLM130.GROUPTYP */
   FIND S0M005 USE-INDEX S0M00501    WHERE
        S0M005.KEY2 = WCLM130.POLTYP NO-LOCK NO-ERROR NO-WAIT.
   IF AVAILABLE S0M005 THEN
      WCLM130.GROUPTYP = S0M005.KEY1.

   FOR EACH CLM130 USE-INDEX CLM13001       WHERE
           clm130.claim   = wclm130.claim    AND
           clm130.clmant  = wclm130.clmant   AND
           clm130.clitem  = wclm130.clitem   AND
           clm130.cpc_cd  = wclm130.cpc_cd   NO-LOCK .
       ASSIGN  nv_paid     = nv_paid + clm130.netl_d.
   END. 

   FOR EACH  clm131 USE-INDEX clm13101      WHERE
             clm131.claim  = wclm130.claim   AND
             clm131.clmant = wclm130.clmant  AND
             clm131.clitem = wclm130.clitem  AND
             clm131.cpc_cd = wclm130.cpc_cd  NO-LOCK .
       ASSIGN  nv_osr = clm131.res .
   END. 

   ASSIGN
       nv_policy = WCLM130.POLICY
       nv_poltyp = WCLM130.POLTYP
       nv_group  = WCLM130.GROUPTYP  
       nv_insure = CLM100.NAME1
       nv_req    = WCLM130.TRNTY1 + "-" + WCLM130.DOCNO 
       nv_userid = CLM100.ENTID
       nv_releas = WCLM130.RELEAS
       nv_sts    = CLM100.PADSTS
       nv_losdat = CLM100.LOSDAT
       nv_comdat = clm100.comdat
       nv_closs  = clm100.loss1. 

   FIND XMM031 USE-INDEX XMM03101    WHERE
        XMM031.POLTYP = WCLM130.POLTYP
   NO-LOCK NO-ERROR NO-WAIT.
   IF AVAILABLE XMM031 THEN
      nv_poldes = XMM031.POLDES.
   ELSE nv_poldes = "".

   FIND CLM120 USE-INDEX CLM12001       WHERE
        CLM120.CLAIM  = WCLM130.CLAIM    AND
        CLM120.CLMANT = WCLM130.CLMANT   AND
        CLM120.CLITEM = WCLM130.CLITEM   NO-LOCK NO-ERROR NO-WAIT.
   IF NOT AVAILABLE CLM120 THEN NEXT.

   ASSIGN
   nv_nature = CLM120.LOSS
   nv_intref = CLM120.INTREF
   nv_total  = 0
   nv_etotal = 0  .
       
   IF CLM120.LOSS  = "FE" OR CLM120.LOSS  = "EX" OR clm120.loss = "SV"   
   THEN DO:
      ASSIGN nv_etotal =  nv_etotal + WCLM130.NETL_D   /* Fee & Expense */  
             nv_fex    =  YES
             nv_osres  =  0.
      
   END.
   ELSE DO:
      ASSIGN nv_total =  nv_total + WCLM130.NETL_D  /* Paid */ 
             nv_fex   =  NO
             nv_osres = nv_osr - nv_paid. 
   END.               

   IF FIRST-OF (wclm130.docno) THEN DO:
      IF nv_fex = YES THEN nv_sumtot = nv_sumtot + nv_etotal.
      ELSE nv_sumtot = nv_sumtot + nv_total.
   END.

   ASSIGN
       nv_adjnam   = ""
       nv_prtadj   = "".

   FIND FIRST XTM600 USE-INDEX XTM60001 WHERE
        XTM600.ACNO = nv_intref
   NO-LOCK NO-ERROR NO-WAIT.
   IF AVAILABLE XTM600 THEN DO:
      IF XTM600.NTITLE = " " THEN
         nv_adjnam  = TRIM(XTM600.NAME).
      ELSE
         nv_adjnam  = TRIM(XTM600.NTITLE) + " " + TRIM(XTM600.NAME).
   END.
   IF CLM100.S_NO <> " " THEN
         nv_prtadj  = STRING(TRIM(nv_adjnam) + "(" + CLM100.S_NO + ")" ).
   ELSE
         nv_prtadj = nv_adjnam.

   RUN PD_processclm1 .  
   RUN PD_processclm2 .   
   RUN PD_sumclaim.
 /*  RUN PD_sumclm . */

END.  /* EACH  WCLM130  */

OUTPUT STREAM ns1 CLOSE.


OUTPUT STREAM ns2 TO VALUE (nv_output + "_sum.slk") .  
nv_txt = "Outward Proportional Treaty".
PUT STREAM ns2
nv_txt                SKIP
"Class of Business"   ";"                     
"Reinsurer Code"      ";"     
"Reinsurer Name"      ";"               
"Received"            ";"   
"Due From"            ";"           
"OS Reserve"          SKIP.

FOR EACH wfsum NO-LOCK  BREAK BY wfsum.CLASS 
                              BY wfsum.recode
                              BY wfsum.rename .
    PUT STREAM ns2
    SKIP
    wfsum.CLASS      ";"
    wfsum.recode     ";"
    wfsum.rename     ";"
    wfsum.receive    ";"
    wfsum.duefr      ";"
    wfsum.osres      SKIP.
END.                                     

OUTPUT STREAM ns2 CLOSE.
 

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_processclm1 cC-Win 
PROCEDURE PD_processclm1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND CLM200 USE-INDEX CLM20001        WHERE
        CLM200.TRNTY1 = WCLM130.TRNTY1   AND
        CLM200.DOCNO  = WCLM130.DOCNO    NO-LOCK NO-ERROR NO-WAIT.
   IF AVAILABLE CLM200 THEN DO:
        ASSIGN
           nv_acno   = CLM200.ACNO
           nv_payee  = TRIM(CLM200.NTITLE) + TRIM(CLM200.NAME).

        /* Note!  Loop find Vat, Tax  From Program Czr05201:Print Voucher Non-motor */
        /*--- find Vat, Tax 3% ---*/
        FIND FIRST XMM600 USE-INDEX XMM60001 WHERE
                   XMM600.ACNO = CLM200.ACNO
        NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAILABLE XMM600 THEN 
            ASSIGN nv_clicod = ""
                   nv_netvat = 0
                   nv_vat    = 0
                   nv_tax    = 0
                   nv_netamt = 0
                   n_vatrate = 0
                   n_taxrate = 0
                   n_paycd   = "".
        ELSE DO:
           ASSIGN  nv_clicod = xmm600.clicod
                   nv_netvat = 0
                   nv_vat    = 0
                   nv_tax    = 0
                   nv_netamt = 0

                   n_vatrate = 0
                   n_taxrate = 0
                   n_paycd   = "".

            FIND FIRST  arm012  USE-INDEX  arm01201  WHERE
                     arm012.type      = nv_vtype   AND
                     arm012.prjcode   = nv_clicod  NO-LOCK NO-ERROR.
            IF AVAIL arm012  THEN
            ASSIGN
                n_vatrate = INT(arm012.text1)  /*--อัตรา VAT--*/
                n_taxrate = INT(arm012.text2)  /*--อัตรา TAX--*/
                n_paycd   = TRIM(arm012.text3).
            ELSE DO:
                ASSIGN   n_vatrate = 0
                         n_taxrate = 0
                         n_paycd   = "".
            END.

           /*คำนวนค่า  vat tax netvat ก่อนเก็บ   ตาม rate ใน ARM120  "VR" */
          IF nv_fex = no THEN DO:            /* Paid */  
            ASSIGN
                nv_netvat = DEC( (nv_total / ((100 + n_vatrate) * 0.01) ) * 100 ) / 100     /* n_amount / 1.07 */
                nv_vat    = nv_total - nv_netvat
                nv_tax    = IF nv_total < 1000  THEN  0 ELSE DEC( (nv_netvat * ( n_taxrate * 0.01)) * 100) / 100   /* (n_netvat  * 3 ) / 100 */
                nv_netamt = nv_total - nv_tax.
          END.

          ELSE DO:
            ASSIGN
                nv_netvat = DEC( (nv_etotal  / ((100 + n_vatrate) * 0.01) ) * 100 ) / 100     /* n_amount / 1.07 */
                nv_vat    = nv_etotal  - nv_netvat
                nv_tax    = IF nv_etotal  < 1000  THEN  0 ELSE DEC( (nv_netvat * ( n_taxrate * 0.01)) * 100) / 100   /* (n_netvat  * 3 ) / 100 */
                nv_netamt = nv_etotal  - nv_tax.
          END.
          
        END. /* Find xmm600 */
   END. /* Find clm200 */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_processclm2 cC-Win 
PROCEDURE PD_processclm2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
nv_enetvat   = 0 .
                    
   IF nv_netvat <> 0 THEN
      nv_enetvat = nv_netvat.

   ELSE nv_enetvat = nv_total.
   
   ASSIGN
       nv_patycd = ""
       nv_tranC  = 0
       nv_paydet = "".
        
   FIND FIRST CLM130 USE-INDEX CLM13001  WHERE
        CLM130.TRNTY1 = WCLM130.TRNTY1   AND
        CLM130.DOCNO  = WCLM130.DOCNO    AND
        CLM130.CLAIM  = WCLM130.CLAIM    NO-LOCK NO-ERROR.
   IF AVAILABLE CLM130 THEN DO:
      ASSIGN
      nv_patycd   = CLM130.PATYCD   /* PV/CF */
      nv_paydet   = CLM130.PAYDET   /* Pay Detail */
       /* --------- june ----------- */ 
      nv_totclm   = clm130.netl_d  
      nv_trndatcl = clm130.trndat
      nv_docno    = clm130.docno
      nv_clmpaid  = nv_netvat .
      

      FIND FIRST acm001 USE-INDEX acm00191     WHERE 
                 acm001.trndat = clm130.trndat AND
                 acm001.trnty1 = clm130.trnty1 AND
                 acm001.docno  = clm130.docno  NO-LOCK NO-ERROR .
      IF AVAIL acm001 THEN DO :
           IF acm001.bal <> 0 THEN 
           ASSIGN nv_dueto = nv_netvat .
      END.
                                   
      IF clm130.patycd <> 'PV' AND  /* Transfer Claim */
         clm130.patycd <> 'CF'
      THEN  nv_tranC  = CLM130.NETL_D.

   END.  /* FIND CLM130 */
      nv_totfac   = (nv_netvat * wclm130.cedper) / 100 .

 
   ASSIGN
        nv_facri   = 0    nv_1st     = 0
        nv_2nd     = 0    nv_qs5     = 0
        nv_tfp     = 0    nv_eng     = 0
        nv_mar     = 0    nv_ret     = 0
        nv_xol     = 0    nv_rq      = 0
        nv_fo1     = 0    nv_fo2     = 0
        nv_fo3     = 0    nv_fo4     = 0
        nv_ftr     = 0
        nv_mps     = 0    nv_btr     = 0
        nv_otr     = 0    nv_gros    = 0
        nv_facl    = 0    nv_facf    = 0
        nv_faca    = 0    nv_facerr  = 0 
        nv_oth     = 0     .

  /*------------   Find  Reinsurance   -------------*/
        
FOR EACH CLM300  USE-INDEX CLM30001 WHERE
         CLM300.CLAIM = WCLM130.CLAIM NO-LOCK 
         BREAK BY clm130.docno :

     IF nv_fex = no THEN DO:                 /* Paid */
        /* FAC RI */
        IF Clm300.csftq = "F" THEN DO:
           ASSIGN
           nv_facri  = nv_facri + (Clm300.risi_p * nv_netvat) / 100.
           
           IF clm300.risi_p <> 0 THEN 
           ASSIGN
               nv_duefr = (nv_totclm * clm300.risi_p) / 100.
           
           IF SUBSTRING (Clm300.rico,1,2) = "0F" THEN DO:
              FIND XMM600 USE-INDEX XMM60001 WHERE
                   XMM600.ACNO = Clm300.rico
              NO-LOCK NO-ERROR NO-WAIT.
              IF NOT AVAILABLE XMM600 THEN DO:
                 nv_facerr = nv_facerr + (clm300.risi_p * nv_netvat) / 100.     /* Fac. Error */
              END.
              ELSE DO:
                 IF XMM600.ACCCOD  = "RA" THEN
                    nv_faca = nv_faca + (clm300.risi_p * nv_netvat) / 100.   /* Fac. Asian */
                 ELSE IF XMM600.ACCCOD = "RF" THEN
                    nv_facf = nv_facf + (clm300.risi_p * nv_netvat) / 100.   /* Fac. Foreign */
                 ELSE nv_facerr = nv_facerr + (clm300.risi_p * nv_netvat) / 100.
              END. /* find xmm600 */
           END. /* clm130.rico = "0F" */

           IF SUBSTRING (Clm300.rico,1,2) = "0D" THEN
              nv_facl =  nv_facl + (clm300.risi_p * nv_netvat) / 100.

        END. /* clm300.csftq = "F" */

        /* 1st Surplus */
        IF  Clm300.csftq = "T"     AND 
            (SUBSTRING (Clm300.rico,1,2) = "0T" AND
           SUBSTRING (Clm300.rico,6,2) = "01")
        THEN  nv_1st   = (Clm300.risi_p * nv_netvat) / 100.

        /* 2nd Surplus */
        IF SUBSTRING (Clm300.rico,1,2) = "0T" AND
           SUBSTRING (Clm300.rico,6,2) = "02" 
           
        THEN  nv_2nd    = (Clm300.risi_p * nv_netvat) / 100.

        /* THAI RI */
        IF SUBSTRING (Clm300.rico,1,4) = "STAT"
        THEN  nv_qs5  = (Clm300.risi_p * nv_netvat) / 100.

        /* TFP */
        IF SUBSTRING (Clm300.rico,1,3)  = "0QA"
        THEN  nv_tfp  = (Clm300.risi_p * nv_netvat) / 100.

        /* RET. */
         IF  Clm300.csftq = "T"     AND 
             SUBSTRING (Clm300.rico,1,4) = "0RET"
        THEN  nv_ret  = (Clm300.risi_p * nv_netvat) / 100.

        /* R.Q. */
        IF SUBSTRING (Clm300.rico,1,3) = "0RQ"
        THEN  nv_rq   = (Clm300.risi_p * nv_netvat) / 100.

        /* F/O I */
        IF SUBSTRING(Clm300.rico,1,2) = "0T" AND
           SUBSTRING(Clm300.rico,6,2) = "F1"
        THEN  nv_fo1  = (Clm300.risi_p * nv_netvat) / 100.

        /* F/O II */
        IF SUBSTRING(Clm300.rico,1,2) = "0T" AND
           SUBSTRING(Clm300.rico,6,2) = "F2"
        THEN  nv_fo2  = (Clm300.risi_p * nv_netvat) / 100.

        /* F/O III */
        IF SUBSTRING(Clm300.rico,1,2) = "0T" AND
           SUBSTRING(Clm300.rico,6,2) = "F3"
        THEN DO:
           IF LOOKUP (WCLM130.POLTYP,"M80,M81,M82,M83,M84,M85") <> 0
           THEN
               /*--- บวกเพิ่มเข้าใน Engineer ---*/
               nv_eng  = nv_eng + (Clm300.risi_p * nv_netvat) / 100.
           ELSE
               /*--- FO3 ไม่รวม Engineer ---*/
               nv_fo3  = (Clm300.risi_p * nv_netvat) / 100.
        END.

        /* F/O IV */
        IF SUBSTRING(Clm300.rico,1,2) = "0T" AND
           SUBSTRING(Clm300.rico,6,2) = "F4"
        THEN  nv_fo4  = (Clm300.risi_p * nv_netvat) / 100.

        /* FTR */
        IF SUBSTRING(Clm300.rico,1,2) = "0T" AND
           SUBSTRING(Clm300.rico,6,2) = "FT"
        THEN  nv_ftr  = (Clm300.risi_p * nv_netvat) / 100.

        /* MPS */
        IF SUBSTRING(clm300.rico,1,3) = "0PS" AND
           SUBSTRING(clm300.rico,6,2) = "01"
        THEN  nv_mps  = (clm300.risi_p * nv_netvat) / 100.

        /* BTR */
        IF SUBSTRING(clm300.rico,1,2) = "0T" AND
           SUBSTRING(clm300.rico,6,2) = "FB"
        THEN  nv_btr  = (clm300.risi_p * nv_netvat) / 100.

        /* OTR */
        IF SUBSTRING(clm300.rico,1,2) = "0T" AND
           SUBSTRING(clm300.rico,6,2) = "FO"
        THEN  nv_otr  = (clm300.risi_p * nv_netvat) / 100.

        IF clm300.rico = "0APTHAI"
        THEN  nv_oth  = (clm300.risi_p * nv_actual ) / 100.

        /* GROSS RET. */
        nv_gros = (nv_netvat  - nv_facri  - nv_1st - nv_2nd - nv_qs5
                              - nv_tfp    - nv_eng - nv_mar - nv_rq
                              - nv_fo1    - nv_fo2 - nv_fo3 - nv_fo4
                              - nv_ftr    - nv_mps - nv_btr - nv_otr
                              - nv_oth). 
     END.       /* nv_fex = no */
     ELSE DO:  /* fee & expense */
        
        IF Clm300.csftq = "F" THEN DO:
           IF nv_netvat <> 0 THEN nv_facri = nv_facri + (Clm300.risi_p * nv_netvat) / 100.
           ELSE nv_facri = nv_facri + (Clm300.risi_p * nv_enetvat) / 100.

           IF clm300.risi_p <> 0 THEN 
           ASSIGN    nv_duefr = (nv_totclm * clm300.risi_p) / 100.
                
           IF SUBSTRING (Clm300.rico,1,2) = "0F" THEN DO:
              FIND XMM600 USE-INDEX XMM60001 WHERE
                   XMM600.ACNO = Clm300.rico
              NO-LOCK NO-ERROR NO-WAIT.
              IF NOT AVAILABLE XMM600 THEN DO:
                 IF nv_netvat <> 0 THEN nv_facerr = nv_facerr + (clm300.risi_p * nv_netvat) / 100.      /* Fac. Error */
                 ELSE nv_facerr = nv_facerr + (clm300.risi_p * nv_enetvat) / 100.  /* Fac. Error */
              END.
              ELSE DO:
                 IF XMM600.ACCCOD  = "RA" THEN
                    IF nv_netvat <> 0 THEN nv_faca = nv_faca + (clm300.risi_p * nv_netvat ) / 100.    /* Fac. Asian */
                    ELSE nv_faca = nv_faca + (clm300.risi_p * nv_enetvat) / 100.    /* Fac. Asian */

                 ELSE IF XMM600.ACCCOD = "RF" THEN
                    IF nv_netvat <> 0 THEN nv_facf = nv_facf + (clm300.risi_p * nv_netvat ) / 100.    /* Fac. Foreign */
                    ELSE nv_facf = nv_facf + (clm300.risi_p * nv_enetvat) / 100.    /* Fac. Foreign */

                 ELSE 
                    IF nv_netvat <> 0 THEN nv_facerr = nv_facerr + (clm300.risi_p *  nv_netvat) / 100.
                    ELSE nv_facerr = nv_facerr + (clm300.risi_p * nv_enetvat) / 100.
              END. /* find xmm600 */
             
           END. /* clm130.rico = "0F" */

           IF SUBSTRING (Clm300.rico,1,2) = "0D" THEN
              nv_facl = nv_facl + (clm300.risi_p * nv_enetvat) / 100.
           
        END. /* clm300.csftq = "F" */

        /* 1st Surplus */
        IF  Clm300.csftq = "T" AND 
            SUBSTRING (Clm300.rico,1,2) = "0T" AND
           SUBSTRING (Clm300.rico,6,2) = "01"
        THEN DO:
           IF nv_netvat <> 0 THEN nv_1st   = (Clm300.risi_p * nv_netvat) / 100.
           ELSE nv_1st   = (Clm300.risi_p * nv_enetvat) / 100.
        END.

        /* 2nd Surplus */
        IF SUBSTRING (Clm300.rico,1,2) = "0T" AND
           SUBSTRING (Clm300.rico,6,2) = "02" 
       
        THEN DO:
              
              IF nv_netvat <> 0 THEN nv_2nd    = (Clm300.risi_p * nv_netvat) / 100.
              ELSE nv_2nd    = (Clm300.risi_p * nv_enetvat) / 100.
        END.

        /* THAI RI */
        IF SUBSTRING (Clm300.rico,1,4) = "STAT"
        THEN DO:
           IF nv_netvat <> 0 THEN nv_qs5  = (Clm300.risi_p * nv_netvat) / 100.
           ELSE nv_qs5  = (Clm300.risi_p * nv_enetvat) / 100.
        END.

        /* TFP */
        IF SUBSTRING (Clm300.rico,1,3)  = "0QA"
        THEN  
           IF nv_netvat <> 0 THEN nv_tfp  = (Clm300.risi_p * nv_netvat) / 100.
           ELSE nv_tfp  = (Clm300.risi_p * nv_enetvat) / 100.

        /* RET. */
        IF Clm300.csftq = "T"     AND 
           SUBSTRING (Clm300.rico,1,4) = "0RET" THEN  
           IF nv_netvat <> 0 THEN nv_ret  = (Clm300.risi_p * nv_netvat) / 100.
           ELSE nv_ret  = (Clm300.risi_p * nv_enetvat) / 100.

        /* R.Q. */
        IF SUBSTRING (Clm300.rico,1,3) = "0RQ"
        THEN 
           IF nv_netvat <> 0 THEN nv_rq   = (Clm300.risi_p * nv_netvat) / 100.
           ELSE  nv_rq   = (Clm300.risi_p * nv_enetvat) / 100.

        /* F/O I */
        IF  Clm300.csftq = "T" AND 
            (SUBSTRING(Clm300.rico,1,2) = "0T" AND
           SUBSTRING(Clm300.rico,6,2) = "F1")
        THEN  
           IF nv_netvat <> 0 THEN nv_fo1  = (Clm300.risi_p * nv_netvat) / 100.
           ELSE nv_fo1  = (Clm300.risi_p * nv_enetvat) / 100.

        /* F/O II */
        IF  Clm300.csftq = "T" AND 
            (SUBSTRING(Clm300.rico,1,2) = "0T" AND
           SUBSTRING(Clm300.rico,6,2) = "F2")
        THEN  
           IF nv_netvat <> 0 THEN nv_fo2  = (Clm300.risi_p * nv_netvat) / 100.
           ELSE nv_fo2  = (Clm300.risi_p * nv_enetvat) / 100.

        /* F/O III */
        IF  Clm300.csftq = "T" AND 
            (SUBSTRING(Clm300.rico,1,2) = "0T" AND
           SUBSTRING(Clm300.rico,6,2) = "F3")
        THEN DO:
              IF LOOKUP (WCLM130.POLTYP,"M80,M81,M82,M83,M84,M85") <> 0
              THEN
                  /*--- บวกเพิ่มเข้าใน Engineer ---*/
                  IF nv_netvat <> 0 THEN nv_eng  = nv_eng + (Clm300.risi_p * nv_netvat) / 100.
                  ELSE nv_eng  = nv_eng + (Clm300.risi_p * nv_enetvat) / 100.
              ELSE
                  /*--- FO3 ไม่รวม Engineer ---*/
                  IF nv_netvat <> 0 THEN nv_fo3  = (Clm300.risi_p * nv_netvat) / 100.
                  ELSE nv_fo3  = (Clm300.risi_p * nv_enetvat) / 100.
        END.

        /* F/O IV */
        IF SUBSTRING(Clm300.rico,1,2) = "0T" AND
           SUBSTRING(Clm300.rico,6,2) = "F4"
        THEN  
           IF nv_netvat <> 0 THEN nv_fo4  = (Clm300.risi_p * nv_netvat) / 100.
           ELSE nv_fo4  = (Clm300.risi_p * nv_enetvat) / 100.

        /* FTR */
        IF SUBSTRING(Clm300.rico,1,2) = "0T" AND
           SUBSTRING(Clm300.rico,6,2) = "FT"
        THEN 
           IF nv_netvat <> 0 THEN nv_ftr  = (Clm300.risi_p * nv_netvat) / 100.
           ELSE nv_ftr  = (Clm300.risi_p * nv_enetvat) / 100.

        /* MPS */
        IF SUBSTRING(clm300.rico,1,3) = "0PS" AND
           SUBSTRING(clm300.rico,6,2) = "01"
        THEN  
           IF nv_netvat <> 0 THEN nv_mps  = (clm300.risi_p * nv_netvat) / 100.
           ELSE nv_mps  = (clm300.risi_p * nv_enetvat) / 100.

        /* BTR */
        IF SUBSTRING(clm300.rico,1,2) = "0T" AND
           SUBSTRING(clm300.rico,6,2) = "FB"
        THEN  
           IF nv_netvat <> 0 THEN nv_btr  = (clm300.risi_p * nv_netvat) / 100.
           ELSE nv_btr  = (clm300.risi_p * nv_enetvat) / 100.

        /* OTR */
        IF SUBSTRING(clm300.rico,1,2) = "0T" AND
           SUBSTRING(clm300.rico,6,2) = "FO"
        THEN 
           IF nv_netvat <> 0 THEN nv_otr  = (clm300.risi_p * nv_netvat) / 100.
           ELSE nv_otr  = (clm300.risi_p * nv_enetvat) / 100.

        /* OTR */
        IF clm300.rico = "0APTHAI"
        THEN 
           IF nv_netvat <> 0 THEN nv_oth  = (clm300.risi_p * nv_netvat) / 100.
           ELSE nv_oth  = (clm300.risi_p * nv_enetvat) / 100.

        /* GROSS RET. */
        IF nv_netvat <> 0  THEN
            nv_gros = (nv_netvat - nv_facri - nv_1st
                     - nv_2nd - nv_qs5 - nv_tfp - nv_eng
                     - nv_mar - nv_rq  - nv_fo1 - nv_fo2
                     - nv_fo3 - nv_fo4 - nv_ftr - nv_mps
                     - nv_btr - nv_otr - nv_oth).    

        ELSE nv_gros = ( nv_enetvat  - nv_facri - nv_1st
                       - nv_2nd - nv_qs5 - nv_tfp - nv_eng
                       - nv_mar - nv_rq  - nv_fo1 - nv_fo2
                       - nv_fo3 - nv_fo4 - nv_ftr - nv_mps
                       - nv_btr - nv_otr - nv_oth).  

     END.   /* nv_fex = yes */
     nv_receive = nv_totfac - nv_duefr .  
    
END.   /* FOR EACH CLM300 */

   /*-----------    End of Find Reinsurance   -------------*/

     ASSIGN nv_trndat  = ?
            nv_insname = "".  

     FIND FIRST uwm100 USE-INDEX uwm10001 
                           WHERE uwm100.policy = nv_policy AND
                                 uwm100.endcnt = 000       NO-ERROR.
     IF AVAIL uwm100 THEN ASSIGN nv_trndat  = uwm100.trndat
                                 nv_insname = uwm100.name1.    
     ELSE ASSIGN nv_trndat = ?
                 nv_insname = "".  


    IF clm100.losdat >= 07/01/2015 THEN DO:
        ASSIGN
        nv_osbh   = nv_netvat  * 0.2
        nv_facbh  = nv_facri   * 0.2.
    
        IF uwm100.trndat >= 07/01/2012 THEN
           ASSIGN
           nv_ttybh = (nv_1st + nv_2nd + nv_rq  + nv_btr) * 0.2
           nv_othbh = (nv_qs5 + nv_tfp + nv_mps + nv_eng 
                     + nv_mar + nv_otr + nv_ftr + nv_fo1 
                     + nv_fo2 + nv_fo3 + nv_fo4) * 0.2.
        ELSE                                                   
           ASSIGN 
           nv_ttybh = 0   
           nv_othbh = (nv_1st + nv_2nd + nv_rq  + nv_btr
                     + nv_qs5 + nv_tfp + nv_mps + nv_eng 
                     + nv_mar + nv_otr + nv_ftr + nv_fo1 
                     + nv_fo2 + nv_fo3 + nv_fo4) * 0.2.
    END.
    ELSE DO: 
        ASSIGN                                 
        nv_osbh  = 0          nv_ttybh = 0  
        nv_facbh = 0          nv_othbh = 0. 
        
    END.
   
     
    
          
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_si120 cC-Win 
PROCEDURE pd_si120 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:     find SI on uwm120  
------------------------------------------------------------------------------*/
IF uwm100.poltyp   = "M60" OR 
   uwm100.poltyp   = "M62" OR  uwm100.poltyp = "M63" OR
   uwm100.poltyp   = "M64" OR  uwm100.poltyp = "M67" THEN DO:

    FOR EACH uwm307 USE-INDEX uwm30701 WHERE uwm307.policy = uwm100.policy AND 
                                           uwm307.rencnt = uwm100.rencnt AND 
                                           uwm307.endcnt = uwm100.endcnt
                                           NO-LOCK .
        nv_sum  = nv_sum  + uwm307.mbsi[1].
    END.

END.
ELSE DO:
  FOR EACH uwm120 USE-INDEX uwm12001 WHERE uwm120.policy = uwm100.policy AND 
                                           uwm120.rencnt = uwm100.rencnt AND 
                                           uwm120.endcnt = uwm100.endcnt
                                           NO-LOCK .

     IF AVAIL uwm120 THEN DO:
        nv_sum  = nv_sum + (uwm120.sigr - uwm120.sico).
     END.

  END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_sumclaim cC-Win 
PROCEDURE PD_sumclaim :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*-----------    Detail for Excel (ns1)   --------------*/
   PUT STREAM ns1
       wclm130.branch ";"
       nv_poltyp      ";"
       nv_poldes      ";"
       nv_group       ";" 
       nv_policy      ";"
       nv_trndat      ";"   
       nv_comdat      ";"
       wclm130.claim  ";"
       nv_agent        ";" 
       wclm130.riconam ";" 
       wclm130.rico    ";"   
       nv_losdat      ";"
       nv_nature      ";"
       nv_insname     ";" 
       nv_closs       ";" 
       nv_patycd      ";"
       nv_req         ";"
       wclm130.entdat ";"
       wclm130.trndat ";"
       nv_total       ";"
       nv_etotal      ";"
       nv_netvat      ";"
       nv_vat         ";"
       nv_tax         ";"
       nv_netamt      ";"
       nv_clmpaid     ";"
       nv_dueto       ";"
       nv_totfac      ";"
       nv_receive     ";"
       nv_duefr       ";"
       nv_osres       ";"   
       nv_1st         ";"
       nv_2nd         ";"
       nv_facri       ";"
       nv_qs5         ";"
       nv_tfp         ";"
       nv_mps         ";"
       nv_eng         ";"
       nv_mar         ";"
       nv_rq          ";"
       nv_btr         ";"
       nv_otr         ";"
       nv_ftr         ";"
       nv_fo1         ";"
       nv_fo2         ";"
       nv_fo3         ";"
       nv_fo4         ";"
       nv_ret         ";"
       nv_gros        ";"
       nv_xol         ";"
       nv_osbh        ";"
       nv_ttybh       ";"
       nv_facbh       ";"
       nv_othbh       ";"
       nv_acno        ";"
       nv_payee       ";"
       nv_clicod      ";"
       nv_userid      ";"
       nv_prtadj      ";"
       nv_paydet      ";"
       nv_releas      ";"
       nv_sts         ";"
       nv_coins       ";"
       nv_coper       ";"
       nv_facl        ";"
       nv_faca        ";"
       nv_facf        ";"
       nv_facerr      ";"
       nv_oth         SKIP.
   /*-----------   End of Detail for Excel   ----------*/
   
   ASSIGN
      nv_1sttot =  0          nv_2nda   =  0  
      nv_1stl   =  0          nv_2ndf   =  0  
      nv_1sta   =  0          nv_engl   =  0  
      nv_1stf   =  0          nv_enga   =  0  
      nv_2ndl   =  0          nv_engf   =  0 .

   FIND FIRST wfsum WHERE wfsum.CLASS  = nv_poltyp         AND
                          wfsum.recode = wclm130.rico      AND
                          wfsum.rename = wclm130.riconam   NO-LOCK NO-ERROR . 
 
    IF NOT AVAIL wfsum THEN DO:
    CREATE wfsum.
    ASSIGN
        wfsum.CLASS     =  nv_poltyp 
        wfsum.recode    =  wclm130.rico 
        wfsum.rename    =  wclm130.riconam    
        wfsum.receive   =  nv_receive 
        wfsum.duefr     =  nv_duefr     
        wfsum.osres     =  nv_osres   .
    END.
    ELSE DO:
    ASSIGN
        wfsum.receive   = wfsum.receive + nv_receive
        wfsum.duefr     = wfsum.duefr   + nv_duefr      
        wfsum.osres     = nv_osres     .
    END.


   
 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_sumrico cC-Win 
PROCEDURE PD_sumrico :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 /*
 FIND FIRST  uwd200 USE-INDEX uwd20001 WHERE
             uwd200.policy = wt_uwm200.wt_policy AND
             uwd200.rencnt = wt_uwm200.wt_rencnt AND
             uwd200.endcnt = wt_uwm200.wt_endcnt AND
             uwd200.csftq  = wt_uwm200.wt_csftq  AND
             uwd200.rico   = wt_uwm200.wt_rico   AND
             uwd200.c_enct = wt_uwm200.wt_c_enct NO-LOCK NO-ERROR.
    IF AVAIL uwd200 THEN DO :

        REPEAT WHILE AVAIL uwd200:
    
            FIND FIRST uwm120 USE-INDEX uwm12001 WHERE 
                       uwm120.policy = uwd200.policy  AND
                       uwm120.rencnt = uwd200.rencnt  AND 
                       uwm120.endcnt = uwd200.endcnt  AND 
                       uwm120.riskgp = uwd200.riskgp  AND 
                       uwm120.riskno = uwd200.riskno  NO-LOCK NO-ERROR.
            IF AVAIL uwm120 THEN DO:
               
               IF SUBSTRING(uwm120.policy,3,2) = "90"  THEN nvexch = 1.
               ELSE nvexch = uwm120.siexch.
            END.
            ELSE DO.
             
              nvexch = 1.
            END.
    
            IF uwd200.rico = "STAT"  THEN DO:
                ASSIGN
                    nv_stat_si   =  nv_stat_si  + (uwd200.risi * nvexch)
                    nv_stat_pr   =  nv_stat_pr  + (uwd200.ripr)
                    nv_stat_sib  =  nv_stat_sib + (uwd200.risi * nvexch)
                    nv_stat_prb  =  nv_stat_prb + (uwd200.ripr)
                    br_stat_sib  =  br_stat_sib + (uwd200.risi * nvexch)
                    br_stat_prb  =  br_stat_prb + (uwd200.ripr)
                    n_sumq       =  n_sumq + (uwd200.risi * nvexch)
                    n_prmq       =  n_prmq + (uwd200.ripr)
                    p_q          =  uwd200.risi_p.
            END.
            
            IF uwd200.rico = "0RET"  THEN DO:
                ASSIGN
                    nv_ret_sib =  nv_ret_sib + (uwd200.risi * nvexch)
                    nv_ret_prb =  nv_ret_prb + (uwd200.ripr)
                    br_ret_sib =  br_ret_sib + (uwd200.risi * nvexch)
                    br_ret_prb =  br_ret_prb + (uwd200.ripr)
                    n_sumr     =  n_sumr     + (uwd200.risi * nvexch)
                    n_prmr     =  n_prmr     + (uwd200.ripr)
                    p_r        =  uwd200.risi_p.
            END.
            
            IF SUBSTRING(uwd200.rico,1,2) = "0Q"  THEN DO:
                ASSIGN
                    nv_0q_si   =  nv_0q_si  + (uwd200.risi * nvexch)
                    nv_0q_pr   =  nv_0q_pr  + (uwd200.ripr)
                    nv_0q_sib  =  nv_0q_sib + (uwd200.risi * nvexch)
                    nv_0q_prb  =  nv_0q_prb + (uwd200.ripr)
                    br_0q_sib  =  br_0q_sib + (uwd200.risi * nvexch)
                    br_0q_prb  =  br_0q_prb + (uwd200.ripr)
                    n_sumtfp   =  n_sumtfp  + (uwd200.risi * nvexch)
                    n_prmtfp   =  n_prmtfp  + (uwd200.ripr)
                    p_tfp      =  uwd200.risi_p.
            END.
            
            IF SUBSTRING(uwd200.rico,1,2) = "0T"  AND
               SUBSTRING(uwd200.rico,6,2) = "01"  THEN DO:
                ASSIGN
                    nv_0t_si   =  nv_0t_si  + (uwd200.risi * nvexch)
                    nv_0t_pr   =  nv_0t_pr  + (uwd200.ripr)
                    nv_0t_sib  =  nv_0t_sib + (uwd200.risi * nvexch)
                    nv_0t_prb  =  nv_0t_prb + (uwd200.ripr)
                    br_0t_sib  =  br_0t_sib + (uwd200.risi * nvexch)
                    br_0t_prb  =  br_0t_prb + (uwd200.ripr)
                    n_sumt     =  n_sumt    + (uwd200.risi * nvexch)
                    n_prmt     =  n_prmt    + (uwd200.ripr)
                    p_t        =  uwd200.risi_p.
            END.
            
            IF SUBSTRING(uwd200.rico,1,2) = "0T"  AND
               SUBSTRING(uwd200.rico,6,2) = "02"  THEN DO:
                ASSIGN
                    nv_0s_si   =  nv_0s_si  + (uwd200.risi * nvexch)
                    nv_0s_pr   =  nv_0s_pr  + (uwd200.ripr)
                    nv_0s_sib  =  nv_0s_sib + (uwd200.risi * nvexch)
                    nv_0s_prb  =  nv_0s_prb + (uwd200.ripr)
                    br_0s_sib  =  br_0s_sib + (uwd200.risi * nvexch)
                    br_0s_prb  =  br_0s_prb + (uwd200.ripr)
                    n_sums     =  n_sums    + (uwd200.risi * nvexch)
                    n_prms     =  n_prms    + (uwd200.ripr)
                    p_s        =  uwd200.risi_p.
            END.
            
            IF SUBSTRING(uwd200.rico,1,2) = "0T"  AND
               SUBSTRING(uwd200.rico,6,2) = "F1"  THEN DO:
                ASSIGN
                    nv_f1_si   =  nv_f1_si  + (uwd200.risi * nvexch)
                    nv_f1_pr   =  nv_f1_pr  + (uwd200.ripr)
                    nv_f1_sib  =  nv_f1_sib + (uwd200.risi * nvexch)
                    nv_f1_prb  =  nv_f1_prb + (uwd200.ripr)
                    br_f1_sib  =  br_f1_sib + (uwd200.risi * nvexch)
                    br_f1_prb  =  br_f1_prb + (uwd200.ripr)
                    n_sumf1    =  n_sumf1   + (uwd200.risi * nvexch)
                    n_prmf1    =  n_prmf1   + (uwd200.ripr)
                    p_f1       =  uwd200.risi_p.
            END.
            
            IF SUBSTRING(uwd200.rico,1,2) = "0T"  AND
               SUBSTRING(uwd200.rico,6,2) = "F2"  THEN DO:
                ASSIGN
                    nv_f2_si   =  nv_f2_si  + (uwd200.risi * nvexch)
                    nv_f2_pr   =  nv_f2_pr  + (uwd200.ripr)
                    nv_f2_sib  =  nv_f2_sib + (uwd200.risi * nvexch)
                    nv_f2_prb  =  nv_f2_prb + (uwd200.ripr)
                    br_f2_sib  =  br_f2_sib + (uwd200.risi * nvexch)
                    br_f2_prb  =  br_f2_prb + (uwd200.ripr)
                    n_sumf2    =  n_sumf2   + (uwd200.risi * nvexch)
                    n_prmf2    =  n_prmf2   + (uwd200.ripr)
                    p_f2       =  uwd200.risi_p.
            END.
            
            IF SUBSTRING(uwd200.rico,1,3) = "0RQ" THEN DO:
                ASSIGN
                    nv_0rq_si     =  nv_0rq_si + (uwd200.risi * nvexch)
                    nv_0rq_pr     =  nv_0rq_pr + (uwd200.ripr)
                    nv_0rq_sib    =  nv_0rq_sib + (uwd200.risi * nvexch)
                    nv_0rq_prb    =  nv_0rq_prb + (uwd200.ripr)
                    br_0rq_sib    =  br_0rq_sib + (uwd200.risi * nvexch)
                    br_0rq_prb    =  br_0rq_prb + (uwd200.ripr)
                    n_sumrq       =  n_sumrq   + (uwd200.risi * nvexch)
                    n_prmrq       =  n_prmrq   + (uwd200.ripr)
                    p_rq          =  uwd200.risi_p.
            END.
            
            IF SUBSTRING(uwd200.rico,1,3) = "0PS" THEN DO:
                ASSIGN
                    nv_0ps_si     =  nv_0ps_si + (uwd200.risi * nvexch)
                    nv_0ps_pr     =  nv_0ps_pr + (uwd200.ripr)
                    nv_0ps_sib    =  nv_0ps_sib + (uwd200.risi * nvexch)
                    nv_0ps_prb    =  nv_0ps_prb + (uwd200.ripr)
                    br_0ps_sib    =  br_0ps_sib + (uwd200.risi * nvexch)
                    br_0ps_prb    =  br_0ps_prb + (uwd200.ripr)
                    n_sumps       =  n_sumps   + (uwd200.risi * nvexch)
                    n_prmps       =  n_prmps   + (uwd200.ripr)
                    p_ps          =  uwd200.risi_p.
            END.
            
            IF SUBSTRING(uwd200.rico,1,3) = "0TF" AND
               SUBSTRING(uwd200.rico,6,2) = "FB"  THEN DO:
                ASSIGN
                    nv_btr_si     =  nv_btr_si + (uwd200.risi * nvexch)
                    nv_btr_pr     =  nv_btr_pr + (uwd200.ripr)
                    nv_btr_sib    =  nv_btr_sib + (uwd200.risi * nvexch)
                    nv_btr_prb    =  nv_btr_prb + (uwd200.ripr)
                    br_btr_sib    =  br_btr_sib + (uwd200.risi * nvexch)
                    br_btr_prb    =  br_btr_prb + (uwd200.ripr)
                    n_sumbtr      =  n_sumbtr  + (uwd200.risi * nvexch)
                    n_prmbtr      =  n_prmbtr  + (uwd200.ripr).
                    p_btr         =  uwd200.risi_p.
            END.
            IF SUBSTRING(uwd200.rico,1,3) = "0TF" AND
               SUBSTRING(uwd200.rico,6,2) = "FO"  THEN DO:
                ASSIGN
                    nv_otr_si     =  nv_otr_si + (uwd200.risi * nvexch)
                    nv_otr_pr     =  nv_otr_pr + (uwd200.ripr)
                    nv_otr_sib    =  nv_otr_sib + (uwd200.risi * nvexch)
                    nv_otr_prb    =  nv_otr_prb + (uwd200.ripr)
                    br_otr_sib    =  br_otr_sib + (uwd200.risi * nvexch)
                    br_otr_prb    =  br_otr_prb + (uwd200.ripr)
                    n_sumotr      =  n_sumotr  + (uwd200.risi * nvexch)
                    n_prmotr      =  n_prmotr  + (uwd200.ripr)
                    p_otr         =  uwd200.risi_p.
            END.
            
            IF (SUBSTRING (uwd200.rico,1,4) = "0TA8" AND SUBSTRING (uwd200.rico,7,1) = "2" )  
               OR (SUBSTRING (uwd200.rico,1,2) = "0T"  AND SUBSTRING (uwd200.rico,6,2) = "F3")    /* A44-0012  -> เพิ่ม F3 (Munich Re.) */
            THEN DO:
                ASSIGN
                    nv_s8_si      =  nv_s8_si  + (uwd200.risi * nvexch)
                    nv_s8_pr      =  nv_s8_pr  + (uwd200.ripr)
                    nv_s8_sib     =  nv_s8_sib + (uwd200.risi * nvexch)
                    nv_s8_prb     =  nv_s8_prb + (uwd200.ripr)
                    br_s8_sib     =  br_s8_sib + (uwd200.risi * nvexch)
                    br_s8_prb     =  br_s8_prb + (uwd200.ripr)
                    n_sums8       =  n_sums8   + (uwd200.risi * nvexch)
                    n_prms8       =  n_prms8   + (uwd200.ripr)
                    p_s8          =  uwd200.risi_p.
            END.
            
            IF SUBSTRING(uwd200.rico,1,2) = "0T"  AND
               SUBSTRING(uwd200.rico,6,2) = "F4"  THEN DO:
                 ASSIGN
                    nv_f4_si      =  nv_f4_si  + (uwd200.risi * nvexch)
                    nv_f4_pr      =  nv_f4_pr  + (uwd200.ripr)
                    nv_f4_sib     =  nv_f4_sib + (uwd200.risi * nvexch)
                    nv_f4_prb     =  nv_f4_prb + (uwd200.ripr)
                    br_f4_sib     =  br_f4_sib + (uwd200.risi * nvexch)
                    br_f4_prb     =  br_f4_prb + (uwd200.ripr)
                    n_sumf4       =  n_sumf4   + (uwd200.risi * nvexch)
                    n_prmf4       =  n_prmf4   + (uwd200.ripr)
                    p_f4          =  uwd200.risi_p.
            END.

            IF SUBSTRING(uwd200.rico,1,2) = "0T"  AND
               SUBSTRING(uwd200.rico,6,2) = "FT"  THEN DO:
                 ASSIGN
                    nv_ftr_si     =  nv_ftr_si + (uwd200.risi * nvexch)
                    nv_ftr_pr     =  nv_ftr_pr + (uwd200.ripr)
                    nv_ftr_sib    =  nv_ftr_sib + (uwd200.risi * nvexch)
                    nv_ftr_prb    =  nv_ftr_prb + (uwd200.ripr)
                    br_ftr_sib    =  br_ftr_sib + (uwd200.risi * nvexch)
                    br_ftr_prb    =  br_ftr_prb + (uwd200.ripr)
                    n_sumftr      =  n_sumftr  + (uwd200.risi * nvexch)
                    n_prmftr      =  n_prmftr  + (uwd200.ripr)
                    p_ftr         =  uwd200.risi_p.
            END.
    
            IF SUBSTRING(uwd200.rico,1,2) = "0D" OR
               SUBSTRING(uwd200.rico,1,2) = "0F"  THEN DO:
                ASSIGN
                    nv_0f_sib = nv_0f_sib + ROUND((uwd200.risi * nvexch),2)
                    nv_0f_prb = nv_0f_prb + ROUND((uwd200.ripr),2)
                    br_0f_sib = br_0f_sib + ROUND((uwd200.risi * nvexch),2)
                    br_0f_prb = br_0f_prb + ROUND((uwd200.ripr),2).
            
              FIND FIRST wrk0f WHERE wrk0f.rico = uwd200.rico NO-ERROR.
              IF AVAILABLE wrk0f THEN DO:
                 wrk0f.sumf = wrk0f.sumf + ROUND(uwd200.risi * nvexch,2) .
                 wrk0f.prmf = wrk0f.prmf + ROUND(uwd200.ripr,2) .
              END.
              ELSE DO:
                 CREATE   wrk0f.
                 ASSIGN
                    wrk0f.sumf   = ROUND(uwd200.risi * nvexch,2)
                    wrk0f.prmf   = ROUND(uwd200.ripr,2)
                    wrk0f.pf     = uwd200.risi_p
                    wrk0f.rico   = uwd200.rico
                    wrk0f.cess   = wt_uwm200.wt_c_no.
              END.
            END.

            FIND NEXT uwd200 USE-INDEX uwd20001 WHERE
              uwd200.policy = wt_uwm200.wt_policy  AND
              uwd200.rencnt = wt_uwm200.wt_rencnt  AND
              uwd200.endcnt = wt_uwm200.wt_endcnt  AND
              uwd200.csftq  = wt_uwm200.wt_csftq   AND
              uwd200.rico   = wt_uwm200.wt_rico    AND
              uwd200.c_enct = wt_uwm200.wt_c_enct  NO-LOCK NO-ERROR.
    
        END. /* repeat */
    END.  */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_Total cC-Win 
PROCEDURE PD_Total :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
/*-- IF #1 --*/
 IF (n_mr1 <> n_mr2) AND  (n_mr2 <> " ")  THEN DO:
 
     IF br_totsib    =       0  AND    br_totpremb  =  0  AND
        br_f1_sib    =       0  AND    br_f1_prb    =  0  AND
        br_f2_sib    =       0  AND    br_f2_prb    =  0  AND
        br_0t_sib    =       0  AND    br_0t_prb    =  0  AND
        br_0s_sib    =       0  AND    br_0s_prb    =  0  AND
        br_stat_sib  =       0  AND    br_stat_prb  =  0  AND
        br_0q_sib    =       0  AND    br_0q_prb    =  0  AND
        br_0f_sib    =       0  AND    br_0f_prb    =  0  AND
        br_ret_sib   =       0  AND    br_ret_prb   =  0  AND
        br_0rq_sib   =       0  AND    br_0rq_prb   =  0  AND        
        br_0ps_sib   =       0  AND    br_0ps_prb   =  0  AND        
        br_btr_sib   =       0  AND    br_btr_prb   =  0  AND
        br_otr_sib   =       0  AND    br_otr_prb   =  0  AND        
        br_s8_sib    =       0  AND    br_s8_prb    =  0  AND
        br_f4_sib    =       0  AND    br_f4_prb    =  0  AND
        br_ftr_sib   =       0  AND    br_ftr_prb   =  0  THEN DO:
     
     END.
     ELSE DO: /*-- ELSE #1 --*/
       ASSIGN
          br_f1_prb    =  br_f1_prb      * (-1)
          br_f2_prb    =  br_f2_prb      * (-1)
          br_0t_prb    =  br_0t_prb      * (-1)
          br_0s_prb    =  br_0s_prb      * (-1)
          br_stat_prb  =  br_stat_prb    * (-1)
          br_0q_prb    =  br_0q_prb      * (-1)
          br_0f_prb    =  br_0f_prb      * (-1)
          br_0rq_prb   =  br_0rq_prb     * (-1)
          br_0ps_prb   =  br_0ps_prb     * (-1)
          br_btr_prb   =  br_btr_prb     * (-1)
          br_otr_prb   =  br_otr_prb     * (-1)
          br_s8_prb    =  ABSOLUTE(br_s8_prb)   
          br_f4_prb    =  br_f4_prb      * (-1)
          br_ftr_prb   =  br_ftr_prb     * (-1).
     
       PUT STREAM ns1
       "รวม By Line"  ";" ";" ";" ";" ";"
       ";" ";" ";" ";" ";"
       br_totsib     FORMAT "->,>>>,>>>,>>>,>>9.99" ";"
           /* june */
       br_totflood   FORMAT "->,>>>,>>>,>>>,>>9.99" ";"
       br_totstrom   FORMAT "->,>>>,>>>,>>>,>>9.99" ";"
       br_totearth   FORMAT "->,>>>,>>>,>>>,>>9.99" ";"
       /* june */
       br_totpremb   FORMAT "->>>,>>>,>>>,>>9.99"   ";"
       nv_totdisc    FORMAT "->>>,>>>,>>>,>>9.99"   ";"  /* june */
       ";"    
       br_f1_sib     FORMAT "->>>,>>>,>>>,>>9.99"   ";"
       br_f1_prb     FORMAT "->,>>>,>>>,>>9.99"     ";"
       ";"           
       ";"           
       br_f2_sib     FORMAT "->>>,>>>,>>>,>>9.99"   ";"
       br_f2_prb     FORMAT "->,>>>,>>>,>>9.99"     ";"
       ";"  .
       
       PUT STREAM ns1
       ";"
       br_0t_sib     FORMAT "->>>,>>>,>>>,>>9.99" ";"
       br_0t_prb     FORMAT "->,>>>,>>>,>>9.99"   ";"
       ";"          
       ";"          
       br_0s_sib     FORMAT "->>>,>>>,>>>,>>9.99" ";"
       br_0s_prb     FORMAT "->,>>>,>>>,>>9.99"   ";"
       ";"          
       br_stat_sib   FORMAT "->>>,>>>,>>>,>>9.99" ";"
       br_stat_prb   FORMAT "->,>>>,>>>,>>9.99"   ";"
       ";"          
       ";"          
       br_0q_sib     FORMAT "->>>,>>>,>>>,>>9.99" ";"
       br_0q_prb     FORMAT "->,>>>,>>>,>>9.99"   ";"
       ";"          
       br_0rq_sib    FORMAT "->>>,>>>,>>>,>>9.99" ";"
       br_0rq_prb    FORMAT "->,>>>,>>>,>>9.99"   ";"
       ";"          
       br_ret_sib    FORMAT "->>>,>>>,>>>,>>9.99" ";"
       br_ret_prb    FORMAT "->,>>>,>>>,>>9.99"   ";"
       ";"          
       ";"          
       br_0ps_sib    FORMAT "->>>,>>>,>>>,>>9.99" ";"
       br_0ps_prb    FORMAT "->,>>>,>>>,>>9.99"   ";"
       ";"          
       br_btr_sib    FORMAT "->>>,>>>,>>>,>>9.99" ";"
       br_btr_prb    FORMAT "->,>>>,>>>,>>9.99"   ";"
       ";"          
       br_otr_sib    FORMAT "->>>,>>>,>>>,>>9.99" ";"
       br_otr_prb    FORMAT "->,>>>,>>>,>>9.99"   ";"
       ";"          
       br_s8_sib     FORMAT "->>>,>>>,>>>,>>9.99" ";"
       br_s8_prb     FORMAT "->,>>>,>>>,>>9.99"   ";"
       ";"           
       br_f4_sib     FORMAT "->>>,>>>,>>>,>>9.99" ";"
       br_f4_prb     FORMAT "->,>>>,>>>,>>9.99"   ";"
       ";"          
       br_ftr_sib    FORMAT "->>>,>>>,>>>,>>9.99" ";"
       br_ftr_prb    FORMAT "->,>>>,>>>,>>9.99"   ";"  SKIP.
     
        FOR EACH wvat7 
            BY wvat7.wyear 
            BY wvat7.wvat DESCENDING.
        
            PUT STREAM ns1
                "รวมค่า Vat " TRIM(STRING(wvat7.wvat)) "% กรมธรรม์ Marine ปี 25" STRING(wvat7.wyear) ";"
                ";" ";" ";" ";" ";" ";" ";" ";" ";"
                wvat7.wvalf1      FORMAT "->,>>>,>>>,>>>,>>9.99" ";" 
                ";" ";" ";"
                wvat7.wvalf2      FORMAT "->,>>>,>>>,>>>,>>9.99" ";" 
                ";" ";" ";"  
                wvat7.wvalt       FORMAT "->,>>>,>>>,>>>,>>9.99" ";"
                ";" ";" ";" ";" ";" ";"                                           
                wvat7.wvalq       FORMAT "->,>>>,>>>,>>>,>>9.99" ";"
                ";" ";" ";" ";" ";" ";" ";" ";" ";"                              
                wvat7.wvalr       FORMAT "->,>>>,>>>,>>>,>>9.99" ";"   SKIP  .
        END.
        
        FOR EACH wvat7 .
            DELETE wvat7.
        END.
     
     END. /*-- ELSE #1 --*/
     
     
     ASSIGN
        br_0t_sib    = 0      br_totsib   = 0
        br_0t_prb    = 0      br_totpremb = 0
        br_0s_sib    = 0      br_f1_sib   = 0
        br_0s_prb    = 0      br_f1_prb   = 0
        br_stat_sib  = 0      br_f2_sib   = 0
        br_stat_prb  = 0      br_f2_prb   = 0
        br_0q_sib    = 0      br_0q_prb   = 0
        br_0rq_sib   = 0      br_0rq_prb  = 0
        br_ret_sib   = 0      br_ret_prb  = 0
        br_0f_sib    = 0      br_0f_prb   = 0
        br_0ps_sib   = 0      br_0ps_prb  = 0
        br_btr_sib   = 0      br_btr_prb  = 0
        br_otr_sib   = 0      br_otr_prb  = 0      
        br_s8_sib    = 0      br_s8_prb   = 0
        br_f4_sib    = 0      br_f4_prb   = 0
        br_ftr_sib   = 0      br_ftr_prb  = 0   

     n_mr2  =  n_mr1

     /* june */
         br_totflood   = 0
         br_totstrom   = 0
         br_totearth   = 0
         nv_totdisc    = 0 .
 
 END. /* IF (n_mr1 <> n_mr2) AND  (n_mr2 <> " ") */  /*-- IF #1 --*/

 /*-- IF #2 --*/
 IF (n_br1 <> n_br2) AND  (n_br2 <> " ")  THEN DO:
 
     IF nv_totsib    =       0  AND    nv_totpremb  =  0  AND
        nv_f1_sib    =       0  AND    nv_f1_prb    =  0  AND
        nv_f2_sib    =       0  AND    nv_f2_prb    =  0  AND
        nv_0t_sib    =       0  AND    nv_0t_prb    =  0  AND
        nv_0s_sib    =       0  AND    nv_0s_prb    =  0  AND
        nv_stat_sib  =       0  AND    nv_stat_prb  =  0  AND
        nv_0q_sib    =       0  AND    nv_0q_prb    =  0  AND
        nv_0f_sib    =       0  AND    nv_0f_prb    =  0  AND
        nv_ret_sib   =       0  AND    nv_ret_prb   =  0  AND
        nv_0rq_sib   =       0  AND    nv_0rq_prb   =  0  AND
       
        nv_0ps_sib   =       0  AND    nv_0ps_prb   =  0  AND
       
        nv_btr_sib   =       0  AND    nv_btr_prb   =  0  AND
        nv_otr_sib   =       0  AND    nv_otr_prb   =  0  AND
       
        nv_s8_sib    =       0  AND    nv_s8_prb    =  0  AND
        nv_f4_sib    =       0  AND    nv_f4_prb    =  0  AND
        nv_ftr_sib   =       0  AND    nv_ftr_prb   =  0  THEN DO:
 
     END.
     ELSE DO:  /*-- ELSE #2 --*/
         ASSIGN
            nv_f1_prb    =  nv_f1_prb      * (-1)
            nv_f2_prb    =  nv_f2_prb      * (-1)
            nv_0t_prb    =  nv_0t_prb      * (-1)
            nv_0s_prb    =  nv_0s_prb      * (-1)
            nv_stat_prb  =  nv_stat_prb    * (-1)
            nv_0q_prb    =  nv_0q_prb      * (-1)
            nv_0f_prb    =  nv_0f_prb      * (-1)
            nv_0rq_prb   =  nv_0rq_prb     * (-1)
            nv_0ps_prb   =  nv_0ps_prb     * (-1)
            nv_btr_prb   =  nv_btr_prb     * (-1)
            nv_otr_prb   =  nv_otr_prb     * (-1)      
            nv_s8_prb    =  ABSOLUTE(nv_s8_prb)
            nv_f4_prb    =  nv_f4_prb      * (-1)
            nv_ftr_prb   =  nv_ftr_prb     * (-1).
         
         PUT STREAM ns1
         "รวมสาขา" ";" ";" ";" ";" ";"
         ";" ";" ";" ";" ";"
         nv_totsib     FORMAT "->,>>>,>>>,>>>,>>9.99" ";"
             /* june */
         nb_flood      FORMAT "->,>>>,>>>,>>>,>>9.99" ";"
         nb_strom      FORMAT "->,>>>,>>>,>>>,>>9.99" ";"
         nb_earth      FORMAT "->,>>>,>>>,>>>,>>9.99" ";"
             /* june */

         nv_totpremb   FORMAT "->,>>>,>>>,>>9.99"     ";"
         nb_disc       FORMAT "->,>>>,>>>,>>9.99"     ";" /* june */
         ";"            
         nv_f1_sib     FORMAT "->>>,>>>,>>>,>>9.99" ";"
         nv_f1_prb     FORMAT "->,>>>,>>>,>>9.99"   ";"
         ";" ";"           
         nv_f2_sib     FORMAT "->>>,>>>,>>>,>>9.99" ";"
         nv_f2_prb     FORMAT "->,>>>,>>>,>>9.99"   ";"
         ";" .              
      
         PUT STREAM ns1    
         ";"
         nv_0t_sib     FORMAT "->>>,>>>,>>>,>>9.99" ";"
         nv_0t_prb     FORMAT "->,>>>,>>>,>>9.99"   ";"
         ";"  ";"           
         nv_0s_sib     FORMAT "->>>,>>>,>>>,>>9.99" ";"
         nv_0s_prb     FORMAT "->,>>>,>>>,>>9.99"   ";"
         ";"           
         nv_stat_sib   FORMAT "->>>,>>>,>>>,>>9.99" ";"
         nv_stat_prb   FORMAT "->,>>>,>>>,>>9.99"   ";"
         ";" ";"           
         nv_0q_sib     FORMAT "->>>,>>>,>>>,>>9.99" ";"
         nv_0q_prb     FORMAT "->,>>>,>>>,>>9.99"   ";"
         ";"             
         nv_0rq_sib    FORMAT "->>>,>>>,>>>,>>9.99" ";"
         nv_0rq_prb    FORMAT "->,>>>,>>>,>>9.99"   ";"
         ";"             
         nv_ret_sib    FORMAT "->>>,>>>,>>>,>>9.99" ";"
         nv_ret_prb    FORMAT "->,>>>,>>>,>>9.99"   ";"
         ";" ";"             
         nv_0ps_sib    FORMAT "->>>,>>>,>>>,>>9.99" ";"
         nv_0ps_prb    FORMAT "->,>>>,>>>,>>9.99"   ";"
         ";"             
         nv_btr_sib    FORMAT "->>>,>>>,>>>,>>9.99" ";"
         nv_btr_prb    FORMAT "->,>>>,>>>,>>9.99"   ";"
         ";"             
         nv_otr_sib    FORMAT "->>>,>>>,>>>,>>9.99" ";"
         nv_otr_prb    FORMAT "->,>>>,>>>,>>9.99"   ";"
         ";"             
         nv_s8_sib     FORMAT "->>>,>>>,>>>,>>9.99" ";"
         nv_s8_prb     FORMAT "->,>>>,>>>,>>9.99"   ";"
         ";"             
         nv_f4_sib     FORMAT "->>>,>>>,>>>,>>9.99" ";"
         nv_f4_prb     FORMAT "->,>>>,>>>,>>9.99"   ";"
         ";"             
         nv_ftr_sib    FORMAT "->>>,>>>,>>>,>>9.99" ";"
         nv_ftr_prb    FORMAT "->,>>>,>>>,>>9.99"   ";"   SKIP.   
     
     END. /*-- ELSE #2 --*/
 
     ASSIGN
        nv_0t_sib    = 0      nv_totsib   = 0
        nv_0t_prb    = 0      nv_totpremb = 0
        nv_0s_sib    = 0      nv_f1_sib   = 0
        nv_0s_prb    = 0      nv_f1_prb   = 0
        nv_stat_sib  = 0      nv_f2_sib   = 0
        nv_stat_prb  = 0      nv_f2_prb   = 0
        nv_0q_sib    = 0      nv_0q_prb   = 0
        nv_0rq_sib   = 0      nv_0rq_prb  = 0
        nv_ret_sib   = 0      nv_ret_prb  = 0
        nv_0f_sib    = 0      nv_0f_prb   = 0
        nv_0ps_sib   = 0      nv_0ps_prb  = 0
        nv_btr_sib   = 0      nv_btr_prb  = 0
        nv_otr_sib   = 0      nv_otr_prb  = 0   
        nv_s8_sib    = 0      nv_s8_prb   = 0
        nv_f4_sib    = 0      nv_f4_prb   = 0
        nv_ftr_sib   = 0      nv_ftr_prb  = 0 
        n_br2        =  n_br1

        /* june */
        nb_flood  = 0 
        nb_strom  = 0 
        nb_earth  = 0 
        nb_disc   = 0 .
        /* june */

 END.  /* IF (n_br1 <> n_br2)        AND  (n_br2 <> " ")  */ /*-- IF #2 --*/

*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_treaty cC-Win 
PROCEDURE pd_treaty :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH  uwm100  USE-INDEX uwm10008  WHERE
          uwm100.trndat >= nv_datefr      AND
          uwm100.trndat <= nv_dateto      AND
          uwm100.dir_ri  = nv_source1     AND
  SUBSTR(uwm100.policy,7,1) >= nv_brokfr  AND
  SUBSTR(uwm100.policy,7,1) <= nv_brokto  AND 
  SUBSTR(uwm100.policy,3,2) >= SUBSTR(nv_potypfr,2,2)  AND 
  SUBSTR(uwm100.policy,3,2) <= SUBSTR(nv_potypto,2,2)  AND
         uwm100.branch      >= nv_branfr  AND 
         uwm100.branch      <= nv_branto  AND
            ((nv_rel = "Y" AND  uwm100.releas = YES) OR
             (nv_rel = "N" AND  uwm100.releas = NO)  OR
             (nv_rel = "A" AND (uwm100.releas = YES  OR uwm100.releas = NO))) NO-LOCK 
 BREAK BY uwm100.branch
       BY uwm100.poltyp  
       BY uwm100.policy :

  /*  FIRST uwm200 NO-LOCK WHERE uwm200.policy = uwm100.policy
                           AND uwm200.csftq = "F",*/
   /* LAST bfuwm100 NO-LOCK WHERE bfuwm100.policy = uwm100.policy
                            AND bfuwm100.rencnt = uwm100.rencnt
                            AND (bfuwm100.polsta = "IF" OR
                                 bfuwm100.polsta = "").*/

    /**----------------------------------------*/

        DISP uwm100.policy  WITH NO-LABEL TITLE "Printing Report..."  FRAME a  VIEW-AS DIALOG-BOX . /* june */
    
        n_bran = "". 
        IF SUBSTR(uwm100.policy,1,1) = "D" OR SUBSTR(uwm100.policy,1,1) = "I" THEN DO:
            nv_brn_line    = "[" + SUBSTR(uwm100.policy,1,1) + 
                             SUBSTR(uwm100.policy,2,1) + "-" +
                             SUBSTR(uwm100.policy,3,2) + "]".
            nv_branch = SUBSTR(uwm100.policy,2,1) . 
            IF SUBSTR(uwm100.policy,1,1) = "I" THEN DO:
                IF SUBSTR(uwm100.policy,2,1) >= "1" AND SUBSTR(uwm100.policy,2,1) <= "8" THEN n_bran = "9" + SUBSTR(uwm100.policy,2,1).
                ELSE n_bran = SUBSTR(uwm100.policy,2,1).
            END.
            ELSE n_bran = SUBSTR(uwm100.policy,2,1).
        END.
        ELSE IF (SUBSTR(uwm100.policy,1,2) >= "10"  AND
                 SUBSTR(uwm100.policy,1,2) <= "99")  THEN DO:
            nv_brn_line   = "[" + SUBSTR(uwm100.policy,1,2) + "-" + 
                             SUBSTR(uwm100.policy,3,2) + "]".
            nv_branch = SUBSTR(uwm100.policy,1,2).  
            n_bran    = SUBSTR(uwm100.policy,1,2). 
        END.
        ELSE DO:
            n_bran = SUBSTR(uwm100.policy,2,1). 
        END.   
    /*-----------------------------------------------*/

        nt_sigr   = nt_sigr  + uwm100.sigr_p.
        nt_prem   = nt_prem  + uwm100.prem_t.

        /*-------------- june ---------------------*/
        FIND FIRST uwm130 USE-INDEX uwm13001 WHERE 
                   uwm130.policy = uwm100.policy  AND
                   uwm130.rencnt = uwm100.rencnt  AND
                   uwm130.endcnt = uwm100.endcnt  NO-LOCK NO-ERROR.
        IF AVAIL uwm130 THEN DO : 
               
               IF uwm130.uom2_c = "FC" THEN nv_flood = uwm130.uom2_v.
               IF uwm130.uom2_c = "WI" THEN nv_storm = uwm130.uom2_v.
               IF uwm130.uom2_c = "EQ" THEN nv_earth = uwm130.uom2_v.
              
               IF uwm130.uom3_c = "FC" THEN nv_flood = uwm130.uom3_v. 
               IF uwm130.uom3_c = "WI" THEN nv_storm = uwm130.uom3_v.
               IF uwm130.uom3_c = "EQ" THEN nv_earth = uwm130.uom3_v.

               IF uwm130.uom4_c = "FC" THEN nv_flood = uwm130.uom4_v.  
               IF uwm130.uom4_c = "WI" THEN nv_storm = uwm130.uom4_v.
               IF uwm130.uom4_c = "EQ" THEN nv_earth = uwm130.uom4_v.
        END. 
            /*
           FIND FIRST acm001 WHERE acm001.trndat = uwm100.trndat NO-LOCK NO-ERROR.
           IF AVAIL acm001 THEN ASSIGN nv_disc = (uwm100.prem_t * acm001.fee) / 100 .  */

        FIND FIRST acm001 USE-INDEX acm00101 WHERE 
                   acm001.trnty1 = uwm100.trty11 AND 
                   acm001.docno  = uwm100.docno1 NO-LOCK NO-ERROR.

        IF AVAIL acm001 THEN DO:
            ASSIGN nv_disc = (uwm100.prem_t * acm001.fee) / 100 .
        END.


           /*-------------- june ---------------------*/

        RUN pd_treaty_csftq .

         IF nt_fac_pr < -1 THEN mfac_pr = nt_fac_pr * (-1).   /* june */
         ELSE mfac_pr = nt_fac_pr.                            /* june */

         IF nt_stat_pr < -1 THEN mstat_pr = nt_stat_pr * (-1).
         ELSE mstat_pr = nt_stat_pr.
         IF nt_ret_pr < -1 THEN mret_pr = nt_ret_pr * (-1).
         ELSE mret_pr = nt_ret_pr.
         IF nt_0q_pr < -1 THEN m0q_pr = nt_0q_pr * (-1).
         ELSE m0q_pr = nt_0q_pr.
         IF nt_0t_pr < -1 THEN m0t_pr = nt_0t_pr * (-1).
         ELSE m0t_pr = nt_0t_pr.
         IF nt_0s_pr < -1 THEN m0s_pr = nt_0s_pr * (-1).
         ELSE m0s_pr = nt_0s_pr.
         IF nt_f1_pr < -1 THEN mf1_pr = nt_f1_pr * (-1).
         ELSE mf1_pr = nt_f1_pr.
         IF nt_f2_pr < -1 THEN mf2_pr = nt_f2_pr * (-1).
         ELSE mf2_pr = nt_f2_pr.
         IF nt_f3_pr < -1 THEN mf3_pr = nt_f3_pr * (-1).
         ELSE mf3_pr = nt_f3_pr.
         IF nt_f4_pr < -1 THEN mf4_pr = nt_f4_pr * (-1).
         ELSE mf4_pr = nt_f4_pr.
         IF nt_0rq_pr < -1 THEN m0rq_pr = nt_0rq_pr * (-1).
         ELSE m0rq_pr = nt_0rq_pr.
         IF nt_0ps_pr < -1 THEN m0ps_pr = nt_0ps_pr * (-1).
         ELSE m0ps_pr = nt_0ps_pr.
         IF nt_btr_pr < -1 THEN mbtr_pr = nt_btr_pr * (-1).
         ELSE mbtr_pr = nt_btr_pr.
         IF nt_otr_pr < -1 THEN motr_pr = nt_otr_pr * (-1).
         ELSE motr_pr = nt_otr_pr.
         IF nt_ftr_pr < -1 THEN mftr_pr = nt_ftr_pr * (-1).
         ELSE mftr_pr = nt_ftr_pr.
         IF nt_s8_pr < -1 THEN ms8_pr = nt_s8_pr * (-1).
         ELSE ms8_pr = nt_s8_pr.
         
/*Comm.*/
         IF mfac_c < -1 THEN nfac_c = mfac_c * (-1).    /* june */
         ELSE nfac_c = mfac_c.                          /* june */

         IF mstat_c < -1 THEN nstat_c = mstat_c * (-1).
         ELSE nstat_c = mstat_c.
         IF m0q_c < -1 THEN n0q_c = m0q_c * (-1).
         ELSE n0q_c = m0q_c.
         IF m0t_c < -1 THEN n0t_c = m0t_c * (-1).
         ELSE n0t_c = m0t_c.
         IF m0s_c < -1 THEN n0s_c = m0s_c * (-1).
         ELSE n0s_c = m0s_c.
         IF mf1_c < -1 THEN nf1_c = mf1_c * (-1).
         ELSE nf1_c = mf1_c.
         IF mf2_c < -1 THEN nf2_c = mf2_c * (-1).
         ELSE nf2_c = mf2_c.
         IF mf3_c < -1 THEN nf3_c = mf3_c * (-1).
         ELSE nf3_c = mf3_c.
         IF mf4_c < -1 THEN nf4_c = mf4_c * (-1).
         ELSE nf4_c = mf4_c.
         IF m0rq_c < -1 THEN n0rq_c = m0rq_c * (-1).
         ELSE n0rq_c = m0rq_c.    
         IF m0ps_c < -1 THEN n0ps_c = m0ps_c * (-1).
         ELSE n0ps_c = m0ps_c.
         IF mbtr_c < -1 THEN nbtr_c = mbtr_c * (-1).
         ELSE nbtr_c = mbtr_c.
         IF motr_c < -1 THEN notr_c = motr_c * (-1).
         ELSE notr_c = motr_c.
         IF mftr_c < -1 THEN nftr_c = mftr_c * (-1).
         ELSE nftr_c = mftr_c.
         IF ms8_c < -1 THEN ns8_c = ms8_c * (-1).
         ELSE ns8_c = ms8_c.
         nret_c = mret_c.
         
         ASSIGN
         nt_com = nret_c + nstat_c + n0q_c  + n0t_c  + n0s_c  + nf1_c + nf2_c +    
                  nf3_c  + nf4_c   + n0rq_c + n0ps_c + nbtr_c + notr_c +  
                  nftr_c + ns8_c. 
    
         ASSIGN nv_trndat = ?
                nv_comdat = ?.
        
         FIND FIRST buwm100 USE-INDEX uwm10001 WHERE
                    buwm100.policy = uwm100.policy AND
                    buwm100.rencnt = uwm100.rencnt AND
                    buwm100.endcnt = uwm100.endcnt NO-LOCK NO-ERROR.
         IF AVAIL buwm100 THEN nv_trndat = buwm100.trndat.
         ELSE nv_trndat = ?.
        
         FIND FIRST buwm100  USE-INDEX uwm10090 WHERE
                    buwm100.trty11 = uwm100.trty11 AND
                    buwm100.docno1 = uwm100.docno1 AND 
                    buwm100.policy = uwm100.policy NO-LOCK NO-ERROR.
         IF AVAIL buwm100 THEN nv_comdat = buwm100.comdat.
         ELSE nv_comdat = ?.

         IF nv_reccnt > 65500 THEN  DO:
            ASSIGN
                cntop      = LENGTH(nv_output2) - 4  /*-- ตัดชื่อ ==> XXXX1.txt --*/
                nv_next    = nv_next + 1
                nv_output2 = SUBSTR(nv_output2,1,cntop) + STRING(nv_next) + ".txt"
                nv_reccnt  = 0.
         END.  

      /*  OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO.     */
         OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
         EXPORT DELIMITER ";"   
             n_bran
             uwm100.poltyp 
             nv_trndat       nv_comdat     
             uwm100.policy   nt_sigr        nt_prem     nt_com
             mret_pr         nt_ret_per     nret_c
             mstat_pr        nt_stat_per    nstat_c  
             m0t_pr          nt_0t_per      n0t_c   
             m0s_pr          nt_0s_per      n0s_c   
             m0q_pr          nt_0q_per      n0q_c
             mf1_pr          nt_f1_per      nf1_c   
             mf2_pr          nt_f2_per      nf2_c   
             mf3_pr          nt_f3_per      nf3_c   
             mf4_pr          nt_f4_per      nf4_c   
             m0rq_pr         nt_0rq_per     n0rq_c  
             m0ps_pr         nt_0ps_per     n0ps_c  
             mbtr_pr         nt_btr_per     nbtr_c  
             motr_pr         nt_otr_per     notr_c  
             mftr_pr         nt_ftr_per     nftr_c  
             ms8_pr          nt_s8_per      ns8_c
             /* june */
             mfac_pr         nt_fac_per     nfac_c  
             nv_flood        nv_storm       nv_earth
             n_lc_com        n_fr_com       nv_disc .
             /* june */

         OUTPUT CLOSE.
         nv_reccnt = nv_reccnt + 1.

         ASSIGN  nret_c   = 0     nstat_c  = 0        
                 n0q_c    = 0     n0t_c    = 0        
                 n0s_c    = 0     nf1_c    = 0        
                 nf2_c    = 0     nf3_c    = 0        
                 nf4_c    = 0     n0rq_c   = 0        
                 n0ps_c   = 0     nbtr_c   = 0        
                 notr_c   = 0     nftr_c   = 0        
                 ns8_c    = 0
                 mstat_c  = 0     mret_c   = 0
                 m0q_c    = 0     m0t_c    = 0
                 m0s_c    = 0     mf1_c    = 0
                 mf2_c    = 0     mf3_c    = 0
                 mf4_c    = 0     m0rq_c   = 0
                 m0ps_c   = 0     mbtr_c   = 0
                 motr_c   = 0     mftr_c   = 0
                 ms8_c    = 0   

                 /* june */
                 nfac_c   = 0     mfac_pr  = 0  mfac_c  = 0 
                 n_lc_com = 0     n_fr_com = 0  nv_disc = 0
                 /* june */

                 nv_trndat = ?    nv_comdat = ?. 

         /*-------------------- Create work_fil -------------------*/
         FIND  FIRST work_fil  WHERE
                    work_fil.wbrn_line   = nv_brn_line NO-ERROR.
         IF  NOT AVAIL work_fil  THEN DO:
             CREATE  work_fil.
             ASSIGN  work_fil.wbrn_line  = nv_brn_line 
                     work_fil.wbranch    = nv_branch.
         END.

         ASSIGN   
             work_fil.wsigr  = work_fil.wsigr + nt_sigr
             work_fil.wprem  = work_fil.wprem + nt_prem
             work_fil.wccom  = work_fil.wccom + nt_com

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
             /*--------------- june -------------*/
            
             work_fil.wfac   = work_fil.wfac   + nt_fac_pr   
             work_fil.wflood = work_fil.wflood + nv_flood
             work_fil.wstorm = work_fil.wstorm + nv_storm
             work_fil.wearth = work_fil.wearth + nv_earth  
             work_fil.wlccom = work_fil.wlccom + n_lc_com
             work_fil.wfrcom = work_fil.wfrcom + n_fr_com  .
                 
            /*------------------ june ------------*/
             IF nt_fac_per = 0 THEN work_fil.wpfac = work_fil.wpfac.  /* june */
             ELSE work_fil.wpfac = nt_fac_per.                        /* june */

             IF nt_stat_per = 0 THEN work_fil.wpstat = work_fil.wpstat.
             ELSE work_fil.wpstat = nt_stat_per.
             IF nt_ret_per  = 0 THEN work_fil.wpret = work_fil.wpret.
             ELSE work_fil.wpret  = nt_ret_per .
             IF nt_0q_per = 0   THEN work_fil.wp0q = work_fil.wp0q.
             ELSE work_fil.wp0q   = nt_0q_per  .
             IF nt_0t_per = 0   THEN work_fil.wp0t = work_fil.wp0t.
             ELSE work_fil.wp0t   = nt_0t_per  .
             IF nt_0s_per = 0   THEN work_fil.wp0s = work_fil.wp0s.
             ELSE work_fil.wp0s    = nt_0s_per.  
             IF nt_f1_per = 0   THEN work_fil.wpf1 = work_fil.wpf1.
             ELSE work_fil.wpf1   = nt_f1_per.
             IF nt_f2_per = 0   THEN work_fil.wpf2 = work_fil.wpf2.
             ELSE work_fil.wpf2   = nt_f2_per.
             IF nt_f3_per = 0   THEN work_fil.wpf3 = work_fil.wpf3.
             ELSE work_fil.wpf3   = nt_f3_per.
             IF nt_f4_per = 0   THEN work_fil.wpf4 = work_fil.wpf4.
             ELSE work_fil.wpf4   = nt_f4_per.
             IF nt_0rq_per = 0  THEN work_fil.wp0rq = work_fil.wp0rq.
             ELSE work_fil.wp0rq  = nt_0rq_per.
             IF nt_0ps_per = 0  THEN work_fil.wp0ps = work_fil.wp0ps.
             ELSE work_fil.wp0ps  = nt_0ps_per.
             IF nt_btr_per = 0  THEN work_fil.wpbtr = work_fil.wpbtr.
             ELSE work_fil.wpbtr  = nt_btr_per.
             IF nt_otr_per = 0  THEN work_fil.wpotr = work_fil.wpotr.
             ELSE work_fil.wpotr  = nt_otr_per    .
             IF nt_ftr_per = 0  THEN work_fil.wpftr = work_fil.wpftr.
             ELSE work_fil.wpftr  = nt_ftr_per    .
             IF nt_s8_per  = 0  THEN work_fil.wps8  = work_fil.wps8   .
             ELSE work_fil.wps8   = nt_s8_per.

        ASSIGN   
             nt_sigr       = 0       nt_prem       = 0
             nt_com        = 0       nt_stat_pr    = 0
             nt_ret_pr     = 0       nt_0q_pr      = 0
             nt_0t_pr      = 0       nt_0s_pr      = 0
             nt_f1_pr      = 0       nt_f2_pr      = 0
             nt_f3_pr      = 0       nt_f4_pr      = 0   
             nt_0rq_pr     = 0       nt_0ps_pr     = 0
             nt_btr_pr     = 0       nt_otr_pr     = 0
             nt_ftr_pr     = 0       nt_s8_pr      = 0
             
                                     nt_stat_per   = 0       
             nt_ret_per    = 0       nt_0q_per     = 0
             nt_0t_per     = 0       nt_0s_per     = 0
             nt_f1_per     = 0       nt_f2_per     = 0
             nt_f3_per     = 0       nt_f4_per     = 0
             nt_0rq_per    = 0       nt_0ps_per    = 0
             nt_btr_per    = 0       nt_otr_per    = 0
             nt_ftr_per    = 0       nt_s8_per     = 0
             nv_branch     = ""

            /* june */
             nt_fac_pr     = 0       nv_flood  = 0 
             nt_fac_per    = 0       nv_storm  = 0 
                                     nv_earth  = 0  .
              /* june */                             

END.   /* each uwm100 */
/*
RUN pd_treaty_put .
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_treaty_csftq cC-Win 
PROCEDURE pd_treaty_csftq :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH uwd200 USE-INDEX uwd20001 WHERE
         uwd200.policy = uwm100.policy AND
         uwd200.rencnt = uwm100.rencnt AND
         uwd200.endcnt = uwm100.endcnt AND
         uwd200.csftq  <> "C"      NO-LOCK .
        
            /*---------------------------- june --------------------------*/
    /* FAC RI */
     IF uwd200.csftq = "F" THEN DO:
        ASSIGN
        nt_fac_pr  = nt_fac_pr + uwd200.ripr.

         FIND FIRST uwm200 USE-INDEX uwm20001 WHERE  /*---- find % Comm จากTable uwm200 ---*/
                    uwm200.policy = uwd200.policy AND
                    uwm200.rencnt = uwd200.rencnt AND
                    uwm200.endcnt = uwd200.endcnt AND
                    uwm200.csftq  = uwd200.csftq  AND
                    uwm200.rico   = uwd200.rico   AND
                    uwm200.c_enct = uwd200.c_enct  NO-LOCK  NO-ERROR.
         IF  AVAIL uwm200  THEN nt_fac_per  = uwm200.rip1.
         mfac_c = (nt_fac_pr * nt_fac_per) / 100.

            /*------------  Foreign --------*/
         IF SUBSTRING (uwm200.rico,1,2) = "0F" THEN DO:
              FIND XMM600 USE-INDEX XMM60001 WHERE
                   XMM600.ACNO = uwm200.rico NO-LOCK NO-ERROR .

              IF AVAILABLE xmm600 THEN DO:
                IF (xmm600.clicod = "RD") OR (xmm600.clicod = "RB") THEN
                ASSIGN  n_lc_com  = n_lc_com + ((nt_fac_pr * mfac_c) / 100) .

                ELSE IF (xmm600.clicod = "RF") OR (xmm600.clicod = "RA") THEN 
                ASSIGN  n_fr_com  = n_fr_com + ((nt_fac_pr * mfac_c) / 100) .

              END.
         END.
              /*
              IF NOT AVAILABLE XMM600 THEN DO:
                 nv_facerr = nv_facerr + (nt_fac_pr * uwm200.rip1) / 100.     /* Fac. Error */
              END.
              ELSE DO:
                 IF XMM600.ACCCOD  = "RA" THEN
                    nv_faca = nv_faca + (nt_fac_pr * uwm200.rip1) / 100.   /* Fac. Asian */
                 ELSE IF XMM600.ACCCOD = "RF" THEN
                    nv_facf = nv_facf + (nt_fac_pr * uwm200.rip1) / 100.   /* Fac. Foreign */
                 ELSE nv_facerr = nv_facerr + (nt_fac_pr * uwm200.rip1) / 100.
              END. /* find xmm600 */
         END. /* clm130.rico = "0F" */ 

         IF SUBSTRING (uwm200.rico,1,2) = "0D" THEN
             nv_facl =  nv_facl + (nt_fac_pr * uwm200.rip1) / 100.  */

     END.

     /*---------------------------- june -------------------------*/

     ELSE IF  uwd200.rico  = "STAT"  THEN  DO:  /* Qbaht */
         ASSIGN 
         nt_stat_pr      = nt_stat_pr + uwd200.ripr.
         
         FIND FIRST uwm200 USE-INDEX uwm20001 WHERE  /*---- find % Comm จากTable uwm200 ---*/
                    uwm200.policy = uwd200.policy AND
                    uwm200.rencnt = uwd200.rencnt AND
                    uwm200.endcnt = uwd200.endcnt AND
                    uwm200.csftq  = uwd200.csftq  AND
                    uwm200.rico   = uwd200.rico   AND
                    uwm200.c_enct = uwd200.c_enct  NO-LOCK  NO-ERROR.
         IF  AVAIL uwm200  THEN nt_stat_per  = uwm200.rip1.
         mstat_c = (nt_stat_pr * nt_stat_per) / 100.
     END.

     ELSE IF    uwd200.rico  = "0RET"  THEN DO:       /*-----ไม่ต้อง Gen JV-----*/
                ASSIGN
                nt_ret_pr       = nt_ret_pr + uwd200.ripr.
                
                FIND FIRST uwm200 USE-INDEX uwm20001 WHERE
                           uwm200.policy = uwd200.policy AND
                           uwm200.rencnt = uwd200.rencnt AND
                           uwm200.endcnt = uwd200.endcnt AND
                           uwm200.csftq  = uwd200.csftq  AND
                           uwm200.rico   = uwd200.rico   AND
                           uwm200.c_enct = uwd200.c_enct  NO-LOCK  NO-ERROR.
                IF  AVAIL uwm200  THEN nt_ret_per  = uwm200.rip1.
                mret_c = 0.
                
     END.

     ELSE IF    SUBSTRING(uwd200.rico,1,2) = "0Q"  THEN DO: /* TFP */
                ASSIGN
                nt_0q_pr        = nt_0q_pr  + uwd200.ripr.
                
                FIND FIRST uwm200 USE-INDEX uwm20001 WHERE
                           uwm200.policy = uwd200.policy AND
                           uwm200.rencnt = uwd200.rencnt AND
                           uwm200.endcnt = uwd200.endcnt AND
                           uwm200.csftq  = uwd200.csftq  AND
                           uwm200.rico   = uwd200.rico   AND
                           uwm200.c_enct = uwd200.c_enct  NO-LOCK  NO-ERROR.
                IF  AVAIL uwm200  THEN nt_0q_per  = uwm200.rip1.
                m0q_c = (nt_0q_pr * nt_0q_per) / 100.
               
     END.

     ELSE IF    SUBSTRING(uwd200.rico,1,2) = "0T"  AND          
                SUBSTRING(uwd200.rico,6,2) = "01"  THEN DO:    /*--1ST--*/
                ASSIGN
                nt_0t_pr        = nt_0t_pr + uwd200.ripr.

                FIND FIRST uwm200 USE-INDEX uwm20001 WHERE
                           uwm200.policy = uwd200.policy AND
                           uwm200.rencnt = uwd200.rencnt AND
                           uwm200.endcnt = uwd200.endcnt AND
                           uwm200.csftq  = uwd200.csftq  AND
                           uwm200.rico   = uwd200.rico   AND
                           uwm200.c_enct = uwd200.c_enct  NO-LOCK  NO-ERROR.
                IF  AVAIL uwm200  THEN nt_0t_per  = uwm200.rip1.
                m0t_c = (nt_0t_pr * nt_0t_per) / 100.
                
     END.
   
     ELSE IF    SUBSTRING(uwd200.rico,1,2) = "0T"  AND
                SUBSTRING(uwd200.rico,6,2) = "02"  THEN DO:   /*--2ND--*/
                
                ASSIGN
                nt_0s_pr        = nt_0s_pr + uwd200.ripr.

                FIND FIRST uwm200 USE-INDEX uwm20001 WHERE
                           uwm200.policy = uwd200.policy AND
                           uwm200.rencnt = uwd200.rencnt AND
                           uwm200.endcnt = uwd200.endcnt AND
                           uwm200.csftq  = uwd200.csftq  AND
                           uwm200.rico   = uwd200.rico   AND
                           uwm200.c_enct = uwd200.c_enct  NO-LOCK  NO-ERROR.
                IF  AVAIL uwm200  THEN nt_0s_per  = uwm200.rip1.
                m0s_c = (nt_0s_pr * nt_0s_per) / 100.

     END.

     ELSE IF    SUBSTRING(uwd200.rico,1,2) = "0T"  AND
                SUBSTRING(uwd200.rico,6,2) = "F1"  THEN DO:
                ASSIGN
                nt_f1_pr        = nt_f1_pr + uwd200.ripr.

                FIND FIRST uwm200 USE-INDEX uwm20001 WHERE
                           uwm200.policy = uwd200.policy AND
                           uwm200.rencnt = uwd200.rencnt AND
                           uwm200.endcnt = uwd200.endcnt AND
                           uwm200.csftq  = uwd200.csftq  AND
                           uwm200.rico   = uwd200.rico   AND
                           uwm200.c_enct = uwd200.c_enct  NO-LOCK  NO-ERROR.
                IF  AVAIL uwm200  THEN nt_f1_per  = uwm200.rip1.
                mf1_c = (nt_f1_pr * nt_f1_per) / 100.
                     
     END.                              

     ELSE IF    SUBSTRING(uwd200.rico,1,2) = "0T"  AND
                SUBSTRING(uwd200.rico,6,2) = "F2"  THEN DO:
                ASSIGN
                nt_f2_pr        = nt_f2_pr + uwd200.ripr.

                FIND FIRST uwm200 USE-INDEX uwm20001 WHERE
                           uwm200.policy = uwd200.policy AND
                           uwm200.rencnt = uwd200.rencnt AND
                           uwm200.endcnt = uwd200.endcnt AND
                           uwm200.csftq  = uwd200.csftq  AND
                           uwm200.rico   = uwd200.rico   AND
                           uwm200.c_enct = uwd200.c_enct  NO-LOCK  NO-ERROR.
                IF  AVAIL uwm200  THEN nt_f2_per  = uwm200.rip1.
                mf2_c = (nt_f2_pr * nt_f2_per) / 100.
                          
     END.

     ELSE IF    SUBSTRING(uwd200.rico,1,2) = "0T"  AND
                SUBSTRING(uwd200.rico,6,2) = "F3"  THEN DO:
                ASSIGN
                nt_f3_pr        = nt_f3_pr + uwd200.ripr.

                FIND FIRST uwm200 USE-INDEX uwm20001 WHERE
                           uwm200.policy = uwd200.policy AND
                           uwm200.rencnt = uwd200.rencnt AND
                           uwm200.endcnt = uwd200.endcnt AND
                           uwm200.csftq  = uwd200.csftq  AND
                           uwm200.rico   = uwd200.rico   AND
                           uwm200.c_enct = uwd200.c_enct  NO-LOCK  NO-ERROR.
                IF  AVAIL uwm200  THEN nt_f3_per  = uwm200.rip1.
                mf3_c = (nt_f3_pr * nt_f3_per) / 100.
                                    
     END.
                
     ELSE IF    SUBSTRING(uwd200.rico,1,2) = "0T"  AND   
                SUBSTRING(uwd200.rico,6,2) = "F4"  THEN DO:
                ASSIGN nt_f4_pr        = nt_f4_pr + uwd200.ripr.

                FIND FIRST uwm200 USE-INDEX uwm20001 WHERE
                           uwm200.policy = uwd200.policy AND
                           uwm200.rencnt = uwd200.rencnt AND
                           uwm200.endcnt = uwd200.endcnt AND
                           uwm200.csftq  = uwd200.csftq  AND
                           uwm200.rico   = uwd200.rico   AND
                           uwm200.c_enct = uwd200.c_enct  NO-LOCK  NO-ERROR.
                IF  AVAIL uwm200  THEN nt_f4_per  = uwm200.rip1.
                mf4_c = (nt_f4_pr * nt_f4_per) / 100.
                             
     END.
 
     ELSE IF    SUBSTRING(uwd200.rico,1,3) = "0RQ" THEN DO:
                ASSIGN
                nt_0rq_pr       = nt_0rq_pr + uwd200.ripr.

                FIND FIRST uwm200 USE-INDEX uwm20001 WHERE
                           uwm200.policy = uwd200.policy AND
                           uwm200.rencnt = uwd200.rencnt AND
                           uwm200.endcnt = uwd200.endcnt AND
                           uwm200.csftq  = uwd200.csftq  AND
                           uwm200.rico   = uwd200.rico   AND
                           uwm200.c_enct = uwd200.c_enct  NO-LOCK  NO-ERROR.
                IF  AVAIL uwm200  THEN nt_0rq_per  = uwm200.rip1.
                m0rq_c = (nt_0rq_pr * nt_0rq_per) / 100.
                                   
     END.

     ELSE IF    SUBSTRING(uwd200.rico,1,3) = "0PS" THEN DO:     /*--MPS--*/
                ASSIGN
                nt_0ps_pr       = nt_0ps_pr + uwd200.ripr.

                FIND FIRST uwm200 USE-INDEX uwm20001 WHERE
                           uwm200.policy = uwd200.policy AND
                           uwm200.rencnt = uwd200.rencnt AND
                           uwm200.endcnt = uwd200.endcnt AND
                           uwm200.csftq  = uwd200.csftq  AND
                           uwm200.rico   = uwd200.rico   AND
                           uwm200.c_enct = uwd200.c_enct  NO-LOCK  NO-ERROR.
                IF  AVAIL uwm200  THEN nt_0ps_per  = uwm200.rip1.
                m0ps_c = (nt_0ps_pr * nt_0ps_per) / 100.
                      
     END.

     ELSE IF    SUBSTRING(uwd200.rico,1,3) = "0TF"  AND
                SUBSTRING(uwd200.rico,6,2) = "FB"  THEN DO:
                ASSIGN
                nt_btr_pr        = nt_btr_pr + uwd200.ripr.

                FIND FIRST uwm200 USE-INDEX uwm20001 WHERE
                           uwm200.policy = uwd200.policy AND
                           uwm200.rencnt = uwd200.rencnt AND
                           uwm200.endcnt = uwd200.endcnt AND
                           uwm200.csftq  = uwd200.csftq  AND
                           uwm200.rico   = uwd200.rico   AND
                           uwm200.c_enct = uwd200.c_enct  NO-LOCK  NO-ERROR.
                IF  AVAIL uwm200  THEN nt_btr_per  = uwm200.rip1.
                mbtr_c = (nt_btr_pr * nt_btr_per) / 100.

     END.

     ELSE IF    SUBSTRING(uwd200.rico,1,3) = "0TF"  AND
                SUBSTRING(uwd200.rico,6,2) = "FO"  THEN DO:
                ASSIGN
                nt_otr_pr        = nt_otr_pr + uwd200.ripr.

                FIND FIRST uwm200 USE-INDEX uwm20001 WHERE
                           uwm200.policy = uwd200.policy AND
                           uwm200.rencnt = uwd200.rencnt AND
                           uwm200.endcnt = uwd200.endcnt AND
                           uwm200.csftq  = uwd200.csftq  AND
                           uwm200.rico   = uwd200.rico   AND
                           uwm200.c_enct = uwd200.c_enct  NO-LOCK  NO-ERROR.
                IF  AVAIL uwm200  THEN nt_otr_per  = uwm200.rip1.
                motr_c = (nt_otr_pr * nt_otr_per) / 100.
                   
     END.

     ELSE IF    SUBSTRING(uwd200.rico,1,3) = "0TF"  AND   
                SUBSTRING(uwd200.rico,6,2) = "FT"  THEN DO:
                ASSIGN
                nt_ftr_pr  = nt_ftr_pr + uwd200.ripr.

                FIND FIRST uwm200 USE-INDEX uwm20001 WHERE
                           uwm200.policy = uwd200.policy AND
                           uwm200.rencnt = uwd200.rencnt AND
                           uwm200.endcnt = uwd200.endcnt AND
                           uwm200.csftq  = uwd200.csftq  AND
                           uwm200.rico   = uwd200.rico   AND
                           uwm200.c_enct = uwd200.c_enct  NO-LOCK  NO-ERROR.
                IF  AVAIL uwm200  THEN nt_ftr_per  = uwm200.rip1.
                mftr_c = (nt_ftr_pr * nt_ftr_per) / 100.
                   
     END.

     ELSE IF    SUBSTRING(uwd200.rico,1,4) = "0TA8"  AND   /*----ยกเลิก---*/                      
                SUBSTRING(uwd200.rico,7,1) = "2"  THEN DO:
                ASSIGN
                nt_s8_pr   = nt_s8_pr + uwd200.ripr.

                FIND FIRST uwm200 USE-INDEX uwm20001 WHERE
                           uwm200.policy = uwd200.policy AND
                           uwm200.rencnt = uwd200.rencnt AND
                           uwm200.endcnt = uwd200.endcnt AND
                           uwm200.csftq  = uwd200.csftq  AND
                           uwm200.rico   = uwd200.rico   AND
                           uwm200.c_enct = uwd200.c_enct  NO-LOCK  NO-ERROR.
                IF  AVAIL uwm200  THEN nt_s8_per  = uwm200.rip1.
                ms8_c = (nt_s8_pr * nt_s8_per) / 100.

     END.

END.   /* each uwd200 */
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_treaty_head cC-Win 
PROCEDURE pd_treaty_head :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
fi_disp = "   Processing  ...! " .
DISP  fi_disp  WITH FRAME frmain .

FOR EACH work_fil.
    DELETE work_fil.
END.

/*
nv_output2 = nv_output + "2.slk".
OUTPUT TO VALUE (nv_output2) NO-ECHO.
EXPORT DELIMITER ";" 
  "*--Total Treaty Policy by Line--*".
EXPORT DELIMITER ";"
  "Trans.Date From : " fi_datefr  "to: " fi_dateto.
EXPORT DELIMITER ";"
EXPORT DELIMITER ";"
    "LINE" "SUM INSURED" "TotPREM." "TotCOMM." 
    "" "RETENTION" ""
    "" "QBAHT" ""
    "" "1ST" ""
    "" "2ND" ""
    "" "TFP" ""
    "" "FO1" ""
    "" "FO2" ""
    "" "FO3" ""
    "" "FO4" ""
    "" "Q/S" ""
    "" "MPS" ""
    "" "BTR" ""
    "" "OTR" ""
    "" "FTR" ""
    "" "S8"  ""

    "" "FAC" "".   /* JUNE */

EXPORT DELIMITER ";"
   
    "" "" "" ""
    "PREM.RET" "%RET" "COMM.RET"
    "PREM.QBAHT" "%QBAHT" "COMM.QBAHT"
    "PREM.1ST" "%1ST" "COMM.1ST"
    "PREM.2ND" "%2ND" "COMM.2ND"
    "PREM.TFP" "%TFP" "COMM.TFP"
    "PREM.FO1" "%FO1" "COMM.FO1"
    "PREM.FO2" "%FO2" "COMM.FO2"
    "PREM.FO3" "%FO3" "COMM.FO3"
    "PREM.FO4" "%FO4" "COMM.FO4"
    "PREM.Q/S" "%Q/S" "COMM.Q/S"
    "PREM.MPS" "%MPS" "COMM.MPS"
    "PREM.BTR" "%BTR" "COMM.BTR"
    "PREM.OTR" "%OTR" "COMM.OTR"
    "PREM.FTR" "%FTR" "COMM.FTR"
    "PREM.S8"  "%S8"  "COMM.S8"
    /*------------ JUNE */
    "PREM.FAC" "%FAC" "COMM.FAC"   
    "FLOOD COVER"     "WINDSTORM" "EARTHQUAKE"  
    "LOCAL FAC COMM"  "FOREIGN FAC COMM"  "Comm/Disc ประกันภัยรวม".
     /* june --------------- */

EXPORT DELIMITER ";" "".
OUTPUT CLOSE.*/

IF nv_reccnt > 65500 THEN  DO:
   ASSIGN
       cntop     = LENGTH(nv_output2) - 4  /*-- ตัดชื่อ ==> XXXX1.txt --*/
       nv_next   = nv_next + 1
       nv_output2 = SUBSTR(nv_output2,1,cntop) + STRING(nv_next) + ".txt"
       nv_reccnt = 0.
END.   /*End Check Line*/  

nv_output = nv_output + ".slk".
OUTPUT TO VALUE (nv_output) NO-ECHO.
EXPORT DELIMITER ";" 
  "*--Total Treaty Policy by Line (Detail Report)--*".
EXPORT DELIMITER ";"
  "Trans.Date From: " fi_datefr  "to: " fi_dateto.
EXPORT DELIMITER ";" .
EXPORT DELIMITER ";"
    "BRANCH"
    "LINE"
    "TRANS.DATE R/E CNT."   
    "COMDAT"                
    "POLICY"
    "SUM INSURED"
    "TOT_PREM."
    "TOT_COMM."
   "" "RETENTION" ""
   "" "QBAHT"     ""
   "" "1ST"       ""
   "" "2ND"       ""
   "" "TFP"       ""
   "" "FO1"       ""
   "" "FO2"       ""
   "" "FO3"       ""
   "" "FO4"       ""
   "" "Q/S"       ""
   "" "MPS"       ""
   "" "BTR"       ""
   "" "OTR"       ""
   "" "FTR"       ""
   "" "S8"        ""

   "" "FAC"       "".   /* JUNE */

   EXPORT DELIMITER ";"

    "" "" "" "" "" "" "" ""
    "PREM.RET" "%RET" "COMM.RET"
    "PREM.QBAHT" "%QBAHT" "COMM.QBAHT"
    "PREM.1ST"  "%1ST"  "COMM.1ST"
    "PREM.2ND"  "%2ND"  "COMM.2ND"
    "PREM.TFP"  "%TFP"  "COMM.TFP"
    "PREM.FO1"  "%FO1"  "COMM.FO1"
    "PREM.FO2"  "%FO2"  "COMM.FO2"
    "PREM.FO3"  "%FO3"  "COMM.FO3"
    "PREM.FO4"  "%FO4"  "COMM.FO4"
    "PREM.Q/S"  "%Q/S"  "COMM.Q/S"
    "PREM.MPS"  "%MPS"  "COMM.MPS"
    "PREM.BTR"  "%BTR"  "COMM.BTR"
    "PREM.OTR"  "%OTR"  "COMM.OTR"
    "PREM.FTR"  "%FTR"  "COMM.FTR"
    "PREM.S8"   "%S8"   "COMM.S8"

    /*------------ JUNE */
    "PREM.FAC" "%FAC" "COMM.FAC"   
    "FLOOD COVER"     "WINDSTORM" "EARTHQUAKE"  
    "LOCAL FAC COMM"  "FOREIGN FAC COMM"  "Comm/Disc ประกันภัยรวม" .
     /* june --------------- */

OUTPUT CLOSE.
nv_reccnt = nv_reccnt + 5.

RUN pd_treaty  .

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_treaty_put cC-Win 
PROCEDURE pd_treaty_put :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH work_fil 

BREAK BY work_fil.wbrn_line 
      BY work_fil.wbranch.   


    IF LAST-OF (work_fil.wbranch) THEN DO: 

       IF  work_fil.wfac  < 0  THEN                    /* june */
           work_fil.wfac  = work_fil.wfac * (-1).     /* june */
                                                                                   
       IF  work_fil.wstat < 0  THEN
           work_fil.wstat = work_fil.wstat * (-1).
       IF  work_fil.w0q   < 0 THEN
           work_fil.w0q   = work_fil.w0q  * (-1).
       IF  work_fil.w0t   < 0 THEN        
           work_fil.w0t   = work_fil.w0t  * (-1).
       IF  work_fil.w0s   < 0 THEN        
           work_fil.w0s   = work_fil.w0s  * (-1).
       IF  work_fil.wf1   < 0 THEN        
           work_fil.wf1   = work_fil.wf1  * (-1).
       IF  work_fil.wf2   < 0 THEN        
           work_fil.wf2   = work_fil.wf2  * (-1).
       IF  work_fil.wf3   < 0 THEN        
           work_fil.wf3   = work_fil.wf3  * (-1).
       IF  work_fil.wf4   < 0 THEN        
           work_fil.wf4   = work_fil.wf4  * (-1).  
       IF  work_fil.w0rq  < 0 THEN        
           work_fil.w0rq  = work_fil.w0rq * (-1).
       IF  work_fil.w0ps  < 0 THEN        
           work_fil.w0ps  = work_fil.w0ps * (-1).
       IF  work_fil.wbtr  < 0 THEN        
           work_fil.wbtr  = work_fil.wbtr * (-1).
       IF  work_fil.wotr  < 0 THEN        
           work_fil.wotr  = work_fil.wotr * (-1).
       IF  work_fil.wftr  < 0 THEN                              
           work_fil.wftr  = work_fil.wftr * (-1).
       IF  work_fil.ws8   < 0 THEN        
           work_fil.ws8   = work_fil.ws8  * (-1).
       IF  work_fil.wret  < 0 THEN        
           work_fil.wret  = work_fil.wret * (-1).
       
       ASSIGN 
       work_fil.wcfac  = (work_fil.wfac  * work_fil.wpfac) / 100     /* june */
       work_fil.wcstat = (work_fil.wstat * work_fil.wpstat) / 100
       work_fil.wc0t   = (work_fil.w0t   * work_fil.wp0t)   / 100
       work_fil.wc0s   = (work_fil.w0s   * work_fil.wp0s )  / 100
       work_fil.wc0q   = (work_fil.w0q   * work_fil.wp0q )  / 100
       work_fil.wcf1   = (work_fil.wf1   * work_fil.wpf1 )  / 100
       work_fil.wcf2   = (work_fil.wf2   * work_fil.wpf2 )  / 100
       work_fil.wcf3   = (work_fil.wf3   * work_fil.wpf3 )  / 100
       work_fil.wcf4   = (work_fil.wf4   * work_fil.wpf4 )  / 100
       work_fil.wc0rq  = (work_fil.w0rq  * work_fil.wp0rq)  / 100
       work_fil.wc0ps  = (work_fil.w0ps  * work_fil.wp0ps)  / 100
       work_fil.wcbtr  = (work_fil.wbtr  * work_fil.wpbtr)  / 100
       work_fil.wcotr  = (work_fil.wotr  * work_fil.wpotr)  / 100
       work_fil.wcftr  = (work_fil.wftr  * work_fil.wpftr)  / 100
       work_fil.wcs8   = (work_fil.ws8   * work_fil.wps8 )  / 100
       work_fil.wccom  = work_fil.wcstat + work_fil.wc0t   +
                         work_fil.wc0s   + work_fil.wc0q   +
                         work_fil.wcf1   + work_fil.wcf2   +
                         work_fil.wcf3   + work_fil.wcf4   +
                         work_fil.wc0rq  + work_fil.wc0ps  +
                         work_fil.wcbtr  + work_fil.wcotr  +
                         work_fil.wcftr  + work_fil.wcs8  .  

     /* /* OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.    */
       OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO. 
       EXPORT DELIMITER ";"   
       work_fil.wbrn_line
       work_fil.wsigr     work_fil.wprem      work_fil.wccom  
       work_fil.wret      work_fil.wpret      work_fil.wcret 
       work_fil.wstat     work_fil.wpstat     work_fil.wcstat
       work_fil.w0t       work_fil.wp0t       work_fil.wc0t  
       work_fil.w0s       work_fil.wp0s       work_fil.wc0s  
       work_fil.w0q       work_fil.wp0q       work_fil.wc0q  
       work_fil.wf1       work_fil.wpf1       work_fil.wcf1  
       work_fil.wf2       work_fil.wpf2       work_fil.wcf2  
       work_fil.wf3       work_fil.wpf3       work_fil.wcf3  
       work_fil.wf4       work_fil.wpf4       work_fil.wcf4  
       work_fil.w0rq      work_fil.wp0rq      work_fil.wc0rq 
       work_fil.w0ps      work_fil.wp0ps      work_fil.wc0ps 
       work_fil.wbtr      work_fil.wpbtr      work_fil.wcbtr 
       work_fil.wotr      work_fil.wpotr      work_fil.wcotr 
       work_fil.wftr      work_fil.wpftr      work_fil.wcftr 
       work_fil.ws8       work_fil.wps8       work_fil.wcs8
        /*---------- june ----------*/
       work_fil.wfac      work_fil.wpfac      work_fil.wcfac
       work_fil.wlccom    work_fil.wfrcom  .

       OUTPUT CLOSE.*/

    END.  /* Last-of */
       
END.  /* each work_fil */


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_vat cC-Win 
PROCEDURE PD_vat :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 /*
  FIND FIRST wvat7 WHERE wvat7.wyear = SUBSTRING(uwm100.policy,5,2) AND 
                         wvat7.wvat  = uwm100.gstrat NO-LOCK NO-ERROR.
  IF AVAIL wvat7 THEN DO:
      ASSIGN
          n_vatf1      = wvat7.wvalf1
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
      ASSIGN
          wvat7.wyear   = SUBSTRING(uwm100.policy,5,2)
          wvat7.wvat    = uwm100.gstrat
          wvat7.wvalf1  = nv_prmf1
          wvat7.wvalf2  = nv_prmf2
          wvat7.wvalt   = nv_prmt
          wvat7.wvalq   = nv_prmq
          wvat7.wvalr   = nv_prmr.
  END.
     
    */
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

