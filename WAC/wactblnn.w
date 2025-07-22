&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*------------------------------------------------------------------------
  File: WACTBLNM.W 
  Description: รายงานทะเบียน Premium By Line - Motor
  Input Parameters:  Process Type = n_type
                     Policy Type  = n_poltyp
                     Di/IF        = nv_dir2
                  Trans Date from = n_date_fr
                  Trans Date to   = n_date_to
                      Agent from  = n_ag_fr
                      Agent to    = n_ag_to
                      Branch from = n_saka
                      Branch to   = n_to
                      Output to   = n_write ==> nv_output
  Created: By Sayamol 
  Copy From: UZS001.P   (Policy)
             UZS002.P   (Endorse.)                  

  Modify By : TANTAWAN C.   23/01/2008   [A500178]           
             ปรับ format branch เพื่อรองรับการขยายสาขา 
             ขยาย FORMAT fi_agfr จาก "X(7)" เป็น  Char "X(10)"
                         fi_agto จาก "X(7)" เป็น  Char "X(10)"
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
DEF VAR    n_proc    AS INT.
DEF VAR    n_type    AS CHAR   FORMAT "x(4)".
DEF VAR    n_type2   AS CHAR   FORMAT "X(4)".
DEF VAR    nv_dir2   AS LOGI.  
DEF VAR    n_date_fr AS DATE   FORMAT "99/99/9999" .
DEF VAR    n_date_to AS DATE   FORMAT "99/99/9999" .
/*--- A500178 ---
DEF VAR    n_ag_fr   AS CHAR   FORMAT "X(7)".
DEF VAR    n_ag_to   AS CHAR   FORMAT "X(7)".
------*/
DEF VAR    n_ag_fr   AS CHAR   FORMAT "X(10)".
DEF VAR    n_ag_to   AS CHAR   FORMAT "X(10)".
DEF VAR    n_rel     AS CHAR   FORMAT "X(01)".
DEF VAR    n_saka    AS CHAR   FORMAT "X(2)".
DEF VAR    n_sakt    AS CHAR   FORMAT "X(2)".
DEF VAR    n_broker  AS LOGICAL.
DEF VAR    n_write   AS CHAR   FORMAT "X(12)". /*ของเดิม "X(8)"*/
DEF VAR    n_write1  AS CHAR   FORMAT "X(12)".
DEF VAR    nv_output AS CHAR   FORMAT "X(12)". 
DEF VAR    n_pacod   AS LOGICAL.
DEF NEW  SHARED VAR nv_datetop AS CHAR FORMAT "x(50)".

DEF WORKFILE motorcom NO-UNDO
    FIELD    policy   AS CHAR FORMAT "X(12)"
    FIELD    rencnt   AS INT  FORMAT ">9"
    FIELD    endcnt   AS INT  FORMAT "999"
    FIELD    comtotal AS DECI FORMAT ">,>>>,>>9.99-"
    FIELD    commo    AS DECI FORMAT ">,>>>,>>9.99-"
    FIELD    compa    AS DECI FORMAT ">,>>>,>>9.99-".

DEF VAR     n_ren_end  LIKE uwm100.renno.
DEF VAR     nv_sum     LIKE uwm120.sigr   INIT 0.
DEF VAR     nv_COM1P   LIKE UWM120.COM1P.
DEF VAR     nv_COM2P   LIKE UWM120.COM2P.
DEF VAR     n_net      LIKE uwm100.prem_t.
DEF VAR     n_insur    AS   CHAR  FORMAT "x(50)".
DEF VAR     n_sum1     LIKE uwm120.sigr   INIT 0.
DEF VAR     n_sum2     LIKE uwm100.prem_t INIT 0.
DEF VAR     n_sum3     LIKE uwm100.ptax   INIT 0.
DEF VAR     n_sum4     LIKE uwm100.pstp   INIT 0.
DEF VAR     n_sum5     LIKE uwm100.prem_t INIT 0.
DEF VAR     n_sum6     LIKE uwm100.com1_t INIT 0.
DEF VAR     n_sum1b    LIKE uwm120.sigr   INIT 0  FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR     n_sum2b    LIKE uwm100.prem_t INIT 0  FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR     n_sum3b    LIKE uwm100.ptax   INIT 0  FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR     n_sum4b    LIKE uwm100.pstp   INIT 0  FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR     n_sum5b    LIKE uwm100.prem_t INIT 0  FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR     n_sum6b    LIKE uwm100.com1_t INIT 0  FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR     n_sum10b   LIKE uwm100.com1_t INIT 0  FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR     n_tot      AS DECI EXTENT 13.
DEF VAR     n_c        AS INT.
DEF VAR     n_an       LIKE UWM120.SIGR.
DEF VAR     n-18       AS CHAR FORMAT "x(100)".
DEF VAR     n_print    AS LOG.
DEF VAR     n_policy   AS CHAR FORMAT "X(8)".
DEF VAR     N_ADD2     AS CHAR FORMAT "X(20)".
DEF VAR     N_ADD3     AS CHAR FORMAT "X(20)".
DEF VAR     t_riskgp   LIKE uwm120.riskgp INIT -1 .
DEF VAR     t_riskno   LIKE uwm120.riskno INIT -1 .
DEF VAR     nvexch     LIKE uwm120.siexch.
DEF VAR     t_exch     AS LOG.
DEF VAR     nvprint    AS LOG.
DEF VAR     n_branch   LIKE uwm100.branch.
DEF VAR     n_bdes     LIKE xmm023.bdes.
DEF VAR     n_dir      LIKE uwm100.dir_ri.
DEF VAR     n_dept     LIKE uwm100.dept.
DEF VAR     nv_last    AS LOG.
DEF VAR     n_cnt      AS  INT.
DEF VAR     n_cnt1     AS  INT.
DEF VAR     n_percen   AS  CHAR  FORMAT  "x".
DEF VAR     w_etime    AS  CHAR.
DEF VAR     w_dtime    AS  CHAR.
DEF VAR     n_etime    AS  INTEGER.
DEF VAR     n_dtime    AS  INTEGER.
DEF VAR     n_1        AS  CHAR  FORMAT  "xxx".
DEF VAR     n_2        AS  CHAR  FORMAT  "xxx".

/*-----------add -------------*/
DEF VAR nv_prstp    LIKE uwm100.pstp.
DEF VAR nv_prtax    LIKE uwm100.ptax.
DEF VAR nv_sumpts   LIKE uwm100.ptax.
DEF VAR nv_netamt   LIKE uwm100.prem_t.
DEF VAR n_billac    AS   CHAR FORMAT "x(20)".
DEF VAR n_agent     AS   CHAR FORMAT "x(60)".
DEF VAR n_sumb1     LIKE  uwm120.sigr   INIT 0.
DEF VAR n_sumb2     LIKE  uwm100.prem_t INIT 0.
DEF VAR n_sumb3     LIKE  uwm100.ptax   INIT 0.
DEF VAR n_sumb4     LIKE  uwm100.pstp   INIT 0.
DEF VAR n_sumb5     LIKE  uwm100.prem_t INIT 0.
DEF VAR n_sumb6     LIKE  uwm100.com1_t INIT 0.
DEF VAR n_sumb7     AS    DECI EXTENT 6.
DEF VAR  n_stp      LIKE  uwm100.pstp.
DEF VAR  n_stptrunc LIKE  uwm100.pstp.
DEF VAR  n_sum7     LIKE  uwm100.prem_t.
DEF VAR  n_sum8     LIKE  uwm100.ptax.
DEF VAR  n_sum9     LIKE  uwm100.pstp.
DEF VAR  n_sum7b    LIKE  uwm100.prem_t.
DEF VAR  n_sum8b    LIKE  uwm100.ptax.
DEF VAR  n_sum9b    LIKE  uwm100.pstp.
DEF VAR  n_prmcom   LIKE  uwm100.prem_t.
DEF VAR  n_stpcom   LIKE  uwm100.pstp.
DEF VAR  nu_prm     LIKE  uwm100.prem_t.
DEF VAR  nu_vat     LIKE  uwm100.ptax.
DEF VAR  nu_tax     LIKE  uwm100.ptax.
DEF VAR  nu_sbt     LIKE  uwm100.pstp.
DEF VAR  nu_vat_b   AS    DEC  FORMAT ">>>>9.99-".
DEF VAR  nu_sbt_b   AS    DEC  FORMAT ">>>>9.99-".
DEF VAR  n_taxcom   LIKE  uwm100.ptax.
DEF VAR  n_tstpcom  LIKE  uwm100.pstp.
DEF VAR  n_ttaxcom  LIKE  uwm100.ptax.
DEF VAR  n_sumprm   LIKE  uwm100.prem_t.
DEF VAR  n_sumstp   LIKE  uwm100.pstp.
DEF VAR  n_sumtax   LIKE  uwm100.ptax.
DEF VAR  n_com1_t   LIKE  uwm100.com1_t.
DEF VAR  n_compa_t  LIKE  uwm100.com1_t.
DEF VAR  n_taxpa    LIKE  uwm100.ptax.
DEF VAR  n_stppa    LIKE  uwm100.pstp.
DEF VAR  n_paprm    LIKE  uwm100.prem_t.
DEF VAR  n_tstppa   LIKE  uwm100.pstp.
DEF VAR  WV_COM1P   AS    CHAR FORMAT "X(7)".
DEF VAR  WV_COM2P   AS    CHAR FORMAT "X(7)".
DEF VAR  nv_bran    AS    CHAR FORMAT "X(15)" INIT "".
DEF VAR  nv_poltyp  AS    CHAR FORMAT "X(7)" INIT "".
DEF VAR nv_sum_an   LIKE  uwm100.sigr_p.

/*sum poltyp*/
DEF VAR nv_sum1p   AS DEC FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEF VAR nv_sum2p   AS DEC FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEF VAR nv_sum3p   AS DEC FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEF VAR nv_sum4p   AS DEC FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEF VAR nv_sum5p   AS DEC FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEF VAR nv_sum6p   AS DEC FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEF VAR nv_sum7p   AS DEC FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEF VAR nv_sum8p   AS DEC FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEF VAR nv_sum9p   AS DEC FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEF VAR nv_sum10p  AS DEC FORMAT "->>,>>>,>>>,>>9.99" INIT 0.

/*Non , PA*/
DEF VAR  n_prmpa   LIKE uwm100.prem_t.
DEF VAR  nv_si     LIKE uwm120.sigr.
DEF VAR  n_summ1   AS DEC FORMAT ">>>>>>>>>>>>9.99-".
DEF VAR  n_summ2   AS DEC FORMAT ">>>>>>>>9.99-".
DEF VAR  n_summ3   AS DEC FORMAT ">>>>>>9.99-".
DEF VAR  n_summ5   AS DEC FORMAT ">>>>>>>>9.99-".
DEF VAR  n_summ6   AS DEC FORMAT ">>>>>>>>9.99-".
DEF VAR  n_summ4   AS DEC FORMAT ">>>>>>9.99-".
DEF VAR n_psum1    AS DEC FORMAT ">>>>>>>>>>>>>>>9.99-"  INIT 0.
DEF VAR n_psum2    AS DEC FORMAT ">>>>>>>>>>>>9.99-"     INIT 0.
DEF VAR n_psum3    AS DEC FORMAT ">>>>>>>>>>9.99-"       INIT 0.
DEF VAR n_psum4    AS DEC FORMAT ">>>>>>>>>>9.99-"       INIT 0.
DEF VAR n_psum5    AS DEC FORMAT ">>>>>>>>>>>>>9.99-"    INIT 0.
DEF VAR n_psum6    AS DEC FORMAT ">>>>>>>>>>9.99-"       INIT 0.
DEF VAR n_msum1    AS DEC FORMAT ">>>>>>>>>>>>>>>9.99-"  INIT 0.
DEF VAR n_msum2    AS DEC FORMAT ">>>>>>>>>>>>9.99-"     INIT 0.
DEF VAR n_msum3    AS DEC FORMAT ">>>>>>>>>>9.99-"       INIT 0.
DEF VAR n_msum4    AS DEC FORMAT ">>>>>>>>>>9.99-"       INIT 0.
DEF VAR n_msum5    AS DEC FORMAT ">>>>>>>>>>>>>9.99-"    INIT 0.
DEF VAR n_msum6    AS DEC FORMAT ">>>>>>>>>>9.99-"       INIT 0.

/*Endorse.*/
DEF VAR n_psum1b   AS DEC FORMAT ">>>>>>>>>>>>>>>9.99-"  INIT 0.
DEF VAR n_psum2b   AS DEC FORMAT ">>>>>>>>>>>>9.99-"     INIT 0.
DEF VAR n_psum3b   AS DEC FORMAT ">>>>>>>>>>9.99-"       INIT 0.
DEF VAR n_psum4b   AS DEC FORMAT ">>>>>>>>>>9.99-"       INIT 0.
DEF VAR n_psum5b   AS DEC FORMAT ">>>>>>>>>>>>>9.99-"    INIT 0.
DEF VAR n_psum6b   AS DEC FORMAT ">>>>>>>>>>9.99-"       INIT 0.
DEF VAR n_msum1b   AS DEC FORMAT ">>>>>>>>>>>>>>>9.99-"  INIT 0.
DEF VAR n_msum2b   AS DEC FORMAT ">>>>>>>>>>>>9.99-"     INIT 0.
DEF VAR n_msum3b   AS DEC FORMAT ">>>>>>>>>>9.99-"       INIT 0.
DEF VAR n_msum4b   AS DEC FORMAT ">>>>>>>>>>9.99-"       INIT 0.
DEF VAR n_msum5b   AS DEC FORMAT ">>>>>>>>>>>>>9.99-"    INIT 0.
DEF VAR n_msum6b   AS DEC FORMAT ">>>>>>>>>>9.99-"       INIT 0.
DEF VAR e_sum1b    AS DEC FORMAT ">>>>>>>>>>>>9.99-"     INIT 0.
DEF VAR e_sum2b    AS DEC FORMAT ">>>>>>>>>>9.99-"       INIT 0.
DEF VAR e_sum3b    AS DEC FORMAT ">>>>>>>>>>9.99-"       INIT 0.
DEF VAR e_sum4b    AS DEC FORMAT ">>>>>>>>>>>>>9.99-"    INIT 0.
DEF VAR e_sum5b    AS DEC FORMAT ">>>>>>>>>>>>9.99-"     INIT 0.
DEF VAR e_sum6b    AS DEC FORMAT ">>>>>>>>>>9.99-"       INIT 0.
DEF VAR e_sum7b    AS DEC FORMAT ">>>>>>>>>>9.99-"       INIT 0.
DEF VAR e_sum8b    AS DEC FORMAT ">>>>>>>>>>>>>9.99-"    INIT 0.
DEF VAR s_sum1b    AS DEC FORMAT ">>>>>>>>>>>>9.99-"     INIT 0.
DEF VAR s_sum2b    AS DEC FORMAT ">>>>>>>>>>9.99-"       INIT 0.
DEF VAR s_sum3b    AS DEC FORMAT ">>>>>>>>>>9.99-"       INIT 0.
DEF VAR s_sum4b    AS DEC FORMAT ">>>>>>>>>>>>>9.99-"    INIT 0.
DEF VAR s_sum5b    AS DEC FORMAT ">>>>>>>>>>>>9.99-"     INIT 0.
DEF VAR s_sum6b    AS DEC FORMAT ">>>>>>>>>>9.99-"       INIT 0.
DEF VAR s_sum7b    AS DEC FORMAT ">>>>>>>>>>9.99-"       INIT 0.
DEF VAR s_sum8b    AS DEC FORMAT ">>>>>>>>>>>>>9.99-"    INIT 0.
DEF VAR n_tot1     AS DEC FORMAT ">>>>>>>>>>>>9.99-"     INIT 0.
DEF VAR n_tot2     AS DEC FORMAT ">>>>>>>>9.99-"         INIT 0.
DEF VAR n_tot3     AS DEC FORMAT ">>>>>>>9.99-"          INIT 0.
DEF VAR n_tot4     AS DEC FORMAT ">>>>>>>9.99-"          INIT 0.
DEF VAR n_tot5     AS DEC FORMAT ">>>>>>>9.99-"          INIT 0.
DEF VAR n_tot6     AS DEC FORMAT ">>>>>>>>9.99-"         INIT 0.
DEF VAR n_tot7     AS DEC FORMAT ">>>>>>>>9.99-"         INIT 0.
DEF VAR n_tot8     AS DEC FORMAT ">>>>>>>>9.99-"         INIT 0.
DEF VAR n_tot9     AS DEC FORMAT ">>>>>>>9.99-"          INIT 0.
DEF VAR n_tot10    AS DEC FORMAT ">>>>>>>>9.99-"         INIT 0.
DEF VAR e_sum1     AS DEC FORMAT ">>>>>>>>>>>>9.99-"     INIT 0.
DEF VAR e_sum2     AS DEC FORMAT ">>>>>>>>>>9.99-"       INIT 0.
DEF VAR e_sum3     AS DEC FORMAT ">>>>>>>>>>9.99-"       INIT 0.
DEF VAR e_sum4     AS DEC FORMAT ">>>>>>>>>>>>>9.99-"    INIT 0.
DEF VAR e_sum5     AS DEC FORMAT ">>>>>>>>>>>>9.99-"     INIT 0.
DEF VAR e_sum6     AS DEC FORMAT ">>>>>>>>>>9.99-"       INIT 0.
DEF VAR e_sum7     AS DEC FORMAT ">>>>>>>>>>9.99-"       INIT 0.
DEF VAR e_sum8     AS DEC FORMAT ">>>>>>>>>>>>>9.99-"    INIT 0.
DEF VAR s_sum1     AS DEC FORMAT ">>>>>>>>>>>>9.99-"     INIT 0.
DEF VAR s_sum2     AS DEC FORMAT ">>>>>>>>>>9.99-"       INIT 0.
DEF VAR s_sum3     AS DEC FORMAT ">>>>>>>>>>9.99-"       INIT 0.
DEF VAR s_sum4     AS DEC FORMAT ">>>>>>>>>>>>>9.99-"    INIT 0.
DEF VAR s_sum5     AS DEC FORMAT ">>>>>>>>>>>>9.99-"     INIT 0.
DEF VAR s_sum6     AS DEC FORMAT ">>>>>>>>>>9.99-"       INIT 0.
DEF VAR s_sum7     AS DEC FORMAT ">>>>>>>>>>9.99-"       INIT 0.
DEF VAR s_sum8     AS DEC FORMAT ">>>>>>>>>>>>>9.99-"    INIT 0.
DEF VAR e_com1     AS DEC FORMAT ">>>>>>>>>>>>>9.99-"    INIT 0.
DEF VAR e_com2     AS DEC FORMAT ">>>>>>>>>>>>>9.99-"    INIT 0.
DEF VAR s_com1     AS DEC FORMAT ">>>>>>>>>>>>>9.99-"    INIT 0.
DEF VAR s_com2     AS DEC FORMAT ">>>>>>>>>>>>>9.99-"    INIT 0.
DEF VAR e_sum1c    AS DEC FORMAT ">>>>>>>>>>9.99-"       INIT 0.
DEF VAR e_sum2c    AS DEC FORMAT ">>>>>>>>>>9.99-"       INIT 0.
DEF VAR e_sum3c    AS DEC FORMAT ">>>>>>>>>>9.99-"       INIT 0.
DEF VAR s_sum1c    AS DEC FORMAT ">>>>>>>>>>9.99-"       INIT 0.
DEF VAR s_sum2c    AS DEC FORMAT ">>>>>>>>>>9.99-"       INIT 0.
DEF VAR s_sum3c    AS DEC FORMAT ">>>>>>>>>>9.99-"       INIT 0.
DEF VAR t_sum1     AS DEC FORMAT ">>>>>>>>>>9.99-"       INIT 0.
DEF VAR t_sum2     AS DEC FORMAT ">>>>>>>>>>9.99-"       INIT 0.
DEF VAR t_sum3     AS DEC FORMAT ">>>>>>>>>>9.99-"       INIT 0.

/* sum poltyp*/
DEF VAR nv_sum1a   AS DEC FORMAT "->>>>>>>>>>>>9.99"     INIT 0.
DEF VAR nv_sum2a   AS DEC FORMAT "->>>>>>>>>>>>9.99"     INIT 0.
DEF VAR nv_sum3a   AS DEC FORMAT "->>>>>>>>>>>>9.99"     INIT 0.
DEF VAR nv_sum4a   AS DEC FORMAT "->>>>>>>>>>>>9.99"     INIT 0.
DEF VAR nv_sum5a   AS DEC FORMAT "->>>>>>>>>>>>9.99"     INIT 0.
DEF VAR nv_sum6a   AS DEC FORMAT "->>>>>>>>>>>>9.99"     INIT 0.
DEF VAR nv_sum7a   AS DEC FORMAT "->>>>>>>>>>>>9.99"     INIT 0.
DEF VAR nv_sum8a   AS DEC FORMAT "->>>>>>>>>>>>9.99"     INIT 0.
DEF VAR nv_sum9a   AS DEC FORMAT "->>>>>>>>>>>>9.99"     INIT 0.
DEF VAR nv_sum10a  AS DEC FORMAT "->>>>>>>>>>>>9.99"     INIT 0.
DEF VAR nv_sum11a  AS DEC FORMAT "->>>>>>>>>>>>9.99"     INIT 0.
DEF VAR nv_sum12a  AS DEC FORMAT "->>>>>>>>>>>>9.99"     INIT 0.
DEF VAR nv_sum13a  AS DEC FORMAT "->>>>>>>>>>>>9.99"     INIT 0.
DEF VAR nv_sum14a  AS DEC FORMAT "->>>>>>>>>>>>9.99"     INIT 0.
DEF VAR nv_sum15a  AS DEC FORMAT "->>>>>>>>>>>>9.99"     INIT 0.
DEF VAR nv_sum16a  AS DEC FORMAT "->>>>>>>>>>>>9.99"     INIT 0.
DEF VAR nv_sum17a  AS DEC FORMAT "->>>>>>>>>>>>9.99"     INIT 0.
DEF VAR n_cntb     AS INT.
DEF VAR nv_uom6    LIKE uwm130.uom6_v INIT 0.
DEF VAR n_txt1     AS CHAR FORMAT "x(25)".

DEF BUFFER BUWM130 FOR UWM130.
DEF BUFFER BUWM120 FOR UWM120.
DEF BUFFER BUWM307 FOR UWM307.

DEF VAR n_prmcomA  AS DEC FORMAT "->>>>>>>>>>>>9.99"    INIT 0.
DEF VAR n_prmcomB  AS DEC FORMAT "->>>>>>>>>>>>9.99"    INIT 0.
DEF VAR n_tstpcomA AS DEC FORMAT "->>>>>>>>>>>>9.99"    INIT 0.
DEF VAR n_tstpcomB AS DEC FORMAT "->>>>>>>>>>>>9.99"    INIT 0.
DEF VAR n_com2A    AS DEC FORMAT "->>>>>>>>>>>>9.99"    INIT 0.
DEF VAR n_com2B    AS DEC FORMAT "->>>>>>>>>>>>9.99"    INIT 0.
DEF VAR n_sumprmA  AS DEC FORMAT "->>>>>>>>>>>>9.99"    INIT 0.
DEF VAR n_sumprmB  AS DEC FORMAT "->>>>>>>>>>>>9.99"    INIT 0.
DEF VAR n_sumstpA  AS DEC FORMAT "->>>>>>>>>>>>9.99"    INIT 0.
DEF VAR n_sumstpB  AS DEC FORMAT "->>>>>>>>>>>>9.99"    INIT 0.
DEF VAR n_com1A    AS DEC FORMAT "->>>>>>>>>>>>9.99"    INIT 0.
DEF VAR n_com1B    AS DEC FORMAT "->>>>>>>>>>>>9.99"    INIT 0. 
DEF VAR nu_vatA    AS DEC FORMAT "->>>>>>>>>>>>9.99"    INIT 0.
DEF VAR nu_vatB    AS DEC FORMAT "->>>>>>>>>>>>9.99"    INIT 0.

/*สำหรับรวมค่าแต่ละ Line */
DEF VAR n_txt2     AS CHAR FORMAT "x(25)".
DEF VAR n_suml1    AS DEC  FORMAT ">>>>>>>>9.99-".
DEF VAR n_suml2    AS DEC  FORMAT ">>>>>>>>9.99-".
DEF VAR n_suml3    AS DEC  FORMAT ">>>>>>>>9.99-".
DEF VAR n_suml4    AS DEC  FORMAT ">>>>>>>>9.99-".
DEF VAR n_suml5    AS DEC  FORMAT ">>>>>>>>9.99-".
DEF VAR n_suml6    AS DEC  FORMAT ">>>>>>>>9.99-".
DEF VAR nv_mbsi    LIKE uwm120.sigr init 0.
DEF VAR n_endcnt   LIKE UWM100.ENDCNT.
DEF VAR nv_code    LIKE uwm120.sicurr.
DEF VAR nvcurr     LIKE uwm120.sicurr.
DEF var nu_prasee  LIKE  uwm100.ptax.
DEF var nu_prasee2 LIKE  uwm100.ptax.
DEF VAR e_sum1M    AS DEC FORMAT ">>>>>>>>>>>>9.99-" INIT 0.
DEF VAR e_sum2M    AS DEC FORMAT ">>>>>>>>9.99-" INIT 0.
DEF VAR e_sum3M    AS DEC FORMAT ">>>>>>9.99-" INIT 0.
DEF VAR e_sum4M    AS DEC FORMAT ">>>>>>9.99-" INIT 0.
DEF VAR e_sum5M    AS DEC FORMAT ">>>>>>>>9.99-" INIT 0.
DEF VAR e_sum6M    AS DEC FORMAT ">>>>>>>>9.99-" INIT 0.
DEF VAR s_sum1M    AS DEC FORMAT ">>>>>>>>>>>>9.99-" INIT 0.
DEF VAR s_sum2M    AS DEC FORMAT ">>>>>>>>9.99-" INIT 0.
DEF VAR s_sum3M    AS DEC FORMAT ">>>>>>9.99-" INIT 0.
DEF VAR s_sum4M    AS DEC FORMAT ">>>>>>9.99-" INIT 0.
DEF VAR s_sum5M    AS DEC FORMAT ">>>>>>>>9.99-" INIT 0.
DEF VAR s_sum6M    AS DEC FORMAT ">>>>>>>>9.99-" INIT 0.
DEF VAR n_sum1M    AS DEC FORMAT ">>>>>>>>>>>>9.99-" INIT 0.
DEF VAR n_sum2M    AS DEC FORMAT ">>>>>>>>9.99-" INIT 0.
DEF VAR n_sum3M    AS DEC FORMAT ">>>>>>9.99-" INIT 0.
DEF VAR n_sum4M    AS DEC FORMAT ">>>>>>9.99-" INIT 0.
DEF VAR n_sum5M    AS DEC FORMAT ">>>>>>>>9.99-" INIT 0.
DEF VAR n_sum6M    AS DEC FORMAT ">>>>>>>>9.99-" INIT 0.
DEF VAR e_sum1l   AS  DEC   FORMAT ">>>>>>>>9.99-".
DEF VAR e_sum2l   AS  DEC   FORMAT ">>>>>>>>9.99-".
DEF VAR e_sum3l   AS  DEC   FORMAT ">>>>>>>>9.99-".
DEF VAR e_sum4l   AS  DEC   FORMAT ">>>>>>>>9.99-".
DEF VAR e_sum5l   AS  DEC   FORMAT ">>>>>>>>9.99-".
DEF VAR e_sum6l   AS  DEC   FORMAT ">>>>>>>>9.99-".
DEF VAR s_sum1l   AS  DEC   FORMAT ">>>>>>>>9.99-".
DEF VAR s_sum2l   AS  DEC   FORMAT ">>>>>>>>9.99-".
DEF VAR s_sum3l   AS  DEC   FORMAT ">>>>>>>>9.99-".
DEF VAR s_sum4l   AS  DEC   FORMAT ">>>>>>>>9.99-".
DEF VAR s_sum5l   AS  DEC   FORMAT ">>>>>>>>9.99-".
DEF VAR s_sum6l   AS  DEC   FORMAT ">>>>>>>>9.99-".
DEF VAR n_sum1l   AS  DEC   FORMAT ">>>>>>>>9.99-".
DEF VAR n_sum2l   AS  DEC   FORMAT ">>>>>>>>9.99-".
DEF VAR n_sum3l   AS  DEC   FORMAT ">>>>>>>>9.99-".
DEF VAR n_sum4l   AS  DEC   FORMAT ">>>>>>>>9.99-".
DEF VAR n_sum5l   AS  DEC   FORMAT ">>>>>>>>9.99-".
DEF VAR n_sum6l   AS  DEC   FORMAT ">>>>>>>>9.99-".
DEF VAR nu_vat_p1 AS  DEC   FORMAT ">>>>>>>>9.99-".
DEF VAR nu_sbt_p1 AS  DEC   FORMAT ">>>>>>>>9.99-".
DEF VAR nu_vat_l1 AS  DEC   FORMAT ">>>>>>>>9.99-".
DEF VAR nu_sbt_l1 AS  DEC   FORMAT ">>>>>>>>9.99-".
DEF VAR nu_sbt_p2  LIKE  uwm100.pstp.
DEF VAR nu_vat_p2  LIKE  uwm100.ptax.
DEF VAR nu_sbt_l2  LIKE  uwm100.pstp.
DEF VAR nu_vat_l2  LIKE  uwm100.ptax.
DEF VAR nu_sbt_t2  LIKE  uwm100.pstp.
DEF VAR nu_vat_t2  LIKE  uwm100.ptax.
DEF VAR nu_vat_t1 AS  DEC   FORMAT ">>>>>>>>9.99-".
DEF VAR nu_sbt_t1 AS  DEC   FORMAT ">>>>>>>>9.99-".
def var nu_sbt_p   like uwm100.pstp.
def var nu_vat_p   like uwm100.ptax.
def var nu_sbt_l   like uwm100.pstp.
def var nu_vat_l   like uwm100.ptax.
def var nu_sbt_t   like uwm100.pstp.
def var nu_vat_t   like uwm100.ptax.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_proctyp fi_poltyp fi_poltyp2 fi_dir ~
fi_datfr fi_datto fi_agfr fi_agto fi_brfr fi_brto fi_broker fi_output ~
czjovtwiBu_ok Bu_Cancel IMAGE-24 RECT-303 
&Scoped-Define DISPLAYED-OBJECTS fi_proctyp fi_poltyp fi_poltyp2 fi_dir ~
fi_datfr fi_datto fi_agfr fi_agto fi_brfr fi_brto fi_broker fi_output 

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

DEFINE VARIABLE fi_agfr AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_agto AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_brfr AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_broker AS LOGICAL FORMAT "YES/NO":U INITIAL NO 
     VIEW-AS FILL-IN 
     SIZE 6 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_brto AS CHARACTER FORMAT "X(7)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_datfr AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_datto AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_dir AS LOGICAL FORMAT "D/I":U INITIAL NO 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_output AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 41.83 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_poltyp AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_poltyp2 AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_proctyp AS INTEGER FORMAT "9":U INITIAL 2 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE IMAGE IMAGE-24
     FILENAME "WIMAGE\bgc01":U
     SIZE 88.5 BY 16.67.

DEFINE RECTANGLE RECT-303
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 84.5 BY 13.57
     BGCOLOR 3 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     fi_proctyp AT ROW 3.19 COL 33 COLON-ALIGNED NO-LABEL
     fi_poltyp AT ROW 4.57 COL 32.83 COLON-ALIGNED NO-LABEL
     fi_poltyp2 AT ROW 4.57 COL 63.67 COLON-ALIGNED NO-LABEL
     fi_dir AT ROW 6.05 COL 33 COLON-ALIGNED NO-LABEL
     fi_datfr AT ROW 7.48 COL 27.17 COLON-ALIGNED NO-LABEL
     fi_datto AT ROW 7.43 COL 63.83 COLON-ALIGNED NO-LABEL
     fi_agfr AT ROW 9.1 COL 27.17 COLON-ALIGNED NO-LABEL
     fi_agto AT ROW 9.1 COL 63.83 COLON-ALIGNED NO-LABEL
     fi_brfr AT ROW 10.52 COL 27.17 COLON-ALIGNED NO-LABEL
     fi_brto AT ROW 10.62 COL 64 COLON-ALIGNED NO-LABEL
     fi_broker AT ROW 12 COL 27.17 COLON-ALIGNED NO-LABEL
     fi_output AT ROW 13.43 COL 27.17 COLON-ALIGNED NO-LABEL
     czjovtwiBu_ok AT ROW 15.48 COL 28
     Bu_Cancel AT ROW 15.52 COL 49.5
     "                             รายงานทะเบียน Premium By Line - NON MOTOR" VIEW-AS TEXT
          SIZE 83.83 BY .95 AT ROW 1.95 COL 3.5
          BGCOLOR 1 FGCOLOR 15 FONT 36
     "Direct = D , Inward = I  :" VIEW-AS TEXT
          SIZE 23.5 BY 1.19 AT ROW 6 COL 11
          BGCOLOR 3 FONT 6
     "Transaction Date From  :" VIEW-AS TEXT
          SIZE 23.5 BY 1.19 AT ROW 7.48 COL 5
          BGCOLOR 3 FONT 6
     "Transaction Date to  :" VIEW-AS TEXT
          SIZE 21.17 BY 1.19 AT ROW 7.48 COL 44.5
          BGCOLOR 3 FONT 6
     "Agent From  :" VIEW-AS TEXT
          SIZE 12.67 BY 1.19 AT ROW 9.1 COL 15.67
          BGCOLOR 3 FONT 6
     "Release  :  YES" VIEW-AS TEXT
          SIZE 15.5 BY .71 AT ROW 14.14 COL 71.5
          BGCOLOR 3 FGCOLOR 4 FONT 6
     "Policy Type To  :" VIEW-AS TEXT
          SIZE 17 BY 1.19 AT ROW 4.57 COL 49
          BGCOLOR 3 FONT 6
     "Print Broker  :" VIEW-AS TEXT
          SIZE 14 BY 1.19 AT ROW 11.91 COL 15.17
          BGCOLOR 3 FONT 6
     "Branch From  :" VIEW-AS TEXT
          SIZE 14 BY 1.19 AT ROW 10.52 COL 14.5
          BGCOLOR 3 FONT 6
     "Branch To  :" VIEW-AS TEXT
          SIZE 11.67 BY 1.19 AT ROW 10.57 COL 53.5
          BGCOLOR 3 FONT 6
     "Agent To  :" VIEW-AS TEXT
          SIZE 11 BY 1.19 AT ROW 9.1 COL 54.67
          BGCOLOR 3 FONT 6
     "Policy Type From  :" VIEW-AS TEXT
          SIZE 18 BY 1.19 AT ROW 4.57 COL 16
          BGCOLOR 3 FONT 6
     "Output To  :" VIEW-AS TEXT
          SIZE 12 BY 1.19 AT ROW 13.43 COL 16.83
          BGCOLOR 3 FONT 6
     "PROCESS FOR  :" VIEW-AS TEXT
          SIZE 16.5 BY 1.19 AT ROW 3.14 COL 17.5
          BGCOLOR 3 FONT 6
     "1 = Policy , 2 = Endorse." VIEW-AS TEXT
          SIZE 25 BY .95 AT ROW 3.24 COL 41
          BGCOLOR 3 FGCOLOR 4 FONT 6
     IMAGE-24 AT ROW 1 COL 1
     RECT-303 AT ROW 1.48 COL 3
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 88.5 BY 16.67
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
         HEIGHT             = 16.67
         WIDTH              = 88.5
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
  IF n_type  =  "V70"  OR                               
     n_type  =  "V72"  OR                               
     n_type  =  "V73"  OR                               
     n_type  =  "V74"  THEN DO:                          
     BELL.                                                       
     MESSAGE "Policy Type is not NON-MOTOR.".     
     NEXT.                                                      
  END. 
  ELSE DO:
    IF n_proc = 1 AND n_broker = YES THEN DO: 
       RUN ProcMPol.   /* UZSPR302.P */
       IF n_pacod THEN DO:
          RUN procNpol.
       END.
    END.
    ELSE IF n_proc = 1 AND n_broker = NO THEN DO:
        RUN ProcMPolBRNo.   /* UZSPR301.P ----------X */
    END.
    ELSE DO:     /*Endorse. Broker = NO เท่านั้น*/
        IF n_broker = YES THEN RUN ProcMEnd.   /* UZSPR402.P */
        ELSE RUN proNoBroker.    /* UZSPR401.P */
    END.

  MESSAGE "Process Data...Completed!!" VIEW-AS ALERT-BOX INFORMATION.

  END. /*else do*/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agfr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agfr C-Win
ON LEAVE OF fi_agfr IN FRAME DEFAULT-FRAME
DO:
  ASSIGN fi_agfr = INPUT FRAME {&FRAME-NAME} fi_agfr
         n_ag_fr = fi_agfr.

  DISP   fi_agfr   WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agto C-Win
ON LEAVE OF fi_agto IN FRAME DEFAULT-FRAME
DO:
  ASSIGN
        fi_agto = INPUT FRAME {&FRAME-NAME} fi_agto.

        IF fi_agto = ? THEN fi_agto = fi_agfr.

        IF fi_agfr = ? AND fi_agto = ? THEN 
           MESSAGE "Please, Key In From Agent" 
           VIEW-AS ALERT-BOX INFORMATION.

        IF INPUT fi_agto < n_ag_fr THEN DO:
           BELL.
           MESSAGE "Agent must be greater than or equal Agent From".
           NEXT-PROMPT fi_agto  WITH FRAME {&FRAME-NAME}.
           NEXT.
       END.

       ASSIGN n_ag_to = fi_agto.
       DISP   fi_agfr fi_agto  WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_brfr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_brfr C-Win
ON LEAVE OF fi_brfr IN FRAME DEFAULT-FRAME
DO:
    ASSIGN fi_brfr = CAPS (INPUT FRAME {&FRAME-NAME} fi_brfr)
           n_saka  = fi_brfr.

    DISP   fi_brfr WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_broker
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_broker C-Win
ON LEAVE OF fi_broker IN FRAME DEFAULT-FRAME
DO:
  ASSIGN 
    fi_broker  = INPUT fi_broker
    n_broker = fi_broker.

  DISP   fi_broker  WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_brto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_brto C-Win
ON LEAVE OF fi_brto IN FRAME DEFAULT-FRAME
DO:
  ASSIGN  fi_brto = CAPS (INPUT FRAME {&FRAME-NAME} fi_brto)
          n_sakt  = fi_brto.

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
    
    IF INPUT fi_poltyp  = "V70"  OR
       INPUT fi_poltyp  = "V72"  OR
       INPUT fi_poltyp  = "V73"  OR
       INPUT fi_poltyp  = "V74"  THEN DO:
             BELL.
             MESSAGE "This record is not NON-MOTOR " 
             VIEW-AS ALERT-BOX ERROR.
             APPLY "ENTRY" TO fi_poltyp.
             RETURN NO-APPLY.
     END.

     ASSIGN n_type  = fi_poltyp.
     DISP   fi_poltyp WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_poltyp2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_poltyp2 C-Win
ON LEAVE OF fi_poltyp2 IN FRAME DEFAULT-FRAME
DO:
    ASSIGN fi_poltyp2 = CAPS (INPUT FRAME {&FRAME-NAME} fi_poltyp2).

    IF INPUT fi_poltyp2  = "V70"  OR
       INPUT fi_poltyp2  = "V72"  OR
       INPUT fi_poltyp2  = "V73"  OR
       INPUT fi_poltyp2  = "V74"  THEN DO:
        BELL.
        MESSAGE "This record is not NON-MOTOR.".
        APPLY "ENTRY" TO fi_poltyp2.                                        
        RETURN NO-APPLY.
    END.

     ASSIGN n_type2  = fi_poltyp2.
     DISP   fi_poltyp2 WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_proctyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_proctyp C-Win
ON LEAVE OF fi_proctyp IN FRAME DEFAULT-FRAME
DO:
  ASSIGN  n_proc = INPUT fi_proctyp.
  DISP    fi_dir  WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


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

  ASSIGN fi_dir     = YES
         fi_poltyp  = ""
         fi_poltyp2 = ""
         fi_proctyp = 1
         fi_datfr   = TODAY
         fi_datto   = TODAY
         fi_agfr    = "A000000"
         fi_agto    = "B999999999"
         fi_brfr    = "0"
         fi_brto    = "Z"
         fi_broker  = YES.

  DISP fi_dir     WITH FRAME {&FRAME-NAME}.
  DISP fi_poltyp  WITH FRAME {&FRAME-NAME}.
  DISP fi_poltyp2 WITH FRAME {&FRAME-NAME}.
  DISP fi_proctyp WITH FRAME {&FRAME-NAME}. 
  DISP fi_datfr   WITH FRAME {&FRAME-NAME}.
  DISP fi_datto   WITH FRAME {&FRAME-NAME}.
  DISP fi_agfr    WITH FRAME {&FRAME-NAME}.
  DISP fi_agto    WITH FRAME {&FRAME-NAME}.
  DISP fi_brfr    WITH FRAME {&FRAME-NAME}.
  DISP fi_brto    WITH FRAME {&FRAME-NAME}.
  DISP fi_broker  WITH FRAME {&FRAME-NAME}.

  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE DetailMEnd C-Win 
PROCEDURE DetailMEnd :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND XMM600 WHERE XMM600.ACNO = UWM100.AGENT NO-LOCK NO-ERROR.
   IF NOT AVAILABLE XMM600 THEN DO:
      N_AGENT = " NOT FOUND PRODUCER CODE " + UWM100.AGENT.
   END.
   ELSE DO.
      N_AGENT = XMM600.ACNO + " " + XMM600.NAME.
   END.

   n_billac  =  "(" + uwm100.agent + ")" + "  "  + "(" + uwm100.acno1 + ")".

   FIND XMM600 WHERE XMM600.ACNO = UWM100.INSREF NO-LOCK NO-ERROR.
   IF NOT AVAILABLE XMM600 THEN DO:
      N_ADD2 = " NOT FOUND PRODUCER CODE " + UWM100.INSREF.
      N_ADD3 = "  ".
   END.
   ELSE DO.
      N_ADD2 =  XMM600.ADDR2.
      N_ADD3 =  XMM600.ADDR3.
   END.

   ASSIGN
      nv_prstp   =  uwm100.pstp + uwm100.rstp
      nv_prtax   =  uwm100.ptax + uwm100.rtax
      nv_sumpts  =  uwm100.prem_t + nv_prstp + nv_prtax - n_paprm - n_tstppa - n_taxpa
      n_tot6     =  n_tot6 + nv_sumpts
      n_sumprm   =  uwm100.prem_t - n_prmcom - n_paprm
      n_tot8     =  n_tot8 + n_sumprm
      n_sumstp   =  nv_prstp - n_tstpcom - n_tstppa
      n_tot9     =  n_tot9 + n_sumstp
      n_sumtax   =  nv_prtax
      n_compa_t  =  - TRUNCATE(n_paprm * nv_com1p / 100,0)
      n_compa_t  =  - n_paprm * nv_com1p / 100
      n_tot7     = n_tot7 + uwm100.com2_t.

   IF n_paprm = 0 THEN n_com1_t = uwm100.com1_t.
   ELSE DO:
      n_com1_t   =  uwm100.com1_t - n_compa_t.
      FIND FIRST motorcom WHERE motorcom.policy = uwm100.policy AND
                          motorcom.rencnt = uwm100.rencnt AND
                          motorcom.endcnt = uwm100.endcnt NO-LOCK NO-ERROR.
      IF NOT AVAIL motorcom THEN DO:
         CREATE motorcom.
         ASSIGN motorcom.policy = uwm100.policy
                motorcom.rencnt = uwm100.rencnt
                motorcom.endcnt = uwm100.endcnt
                motorcom.comtotal = uwm100.com1_t
                motorcom.commo = uwm100.com1_t - n_compa_t
                motorcom.compa = n_compa_t.
      END.
      ELSE DO:
         ASSIGN motorcom.policy = uwm100.policy
                motorcom.rencnt = uwm100.rencnt
                motorcom.endcnt = uwm100.endcnt
                motorcom.comtotal = uwm100.com1_t
                motorcom.commo = uwm100.com1_t - n_compa_t
                motorcom.compa = n_compa_t.
      END.
   END. /* Else n_paprm = 0 */

   n_tot10   =   n_tot10 + n_com1_t.
          
   wv_com1p  =   " ".  n_percen  = " ". wv_com2p = " ".

   IF   nv_com1p  <> 0  THEN DO:     
        n_percen  =  "%".
        wv_com1p  =  string(nv_com1p,">9.99") + " %".
   END.           
   ELSE DO:       
        n_percen  =  "%".
        wv_com1p  =  "0.00 %".

   END.           

   IF   nv_com2p  <> 0  then do:
        n_percen  =  "%".
        wv_com2p  =  string(nv_com2p,">9.99") + " %".
   END.           
   ELSE DO:       
        n_percen  =  "%".
        wv_com2p  =  "0.00 %".

   END. 

   ASSIGN  nu_tax = n_sumtax - n_taxpa
           nu_prm = n_prmcom + n_sumprm + n_tstpcom + n_sumstp
           nu_vat = nu_tax
           n_tot5 = n_tot5   + nu_vat.

   IF SUBSTR(uwm100.poltyp,2,2) >= "72" OR SUBSTR(uwm100.poltyp,2,2) <= "74" THEN DO:
      IF n_prmcom >= 0 THEN 
         ASSIGN n_prmcomA = n_prmcom
                n_prmcomB = 0.
      ELSE ASSIGN n_prmcomA = 0
                  n_prmcomB = n_prmcom.

      IF n_tstpcom >= 0 THEN
         ASSIGN n_tstpcomA = n_tstpcom
                n_tstpcomB = 0.
      ELSE ASSIGN n_tstpcomA = 0
                  n_tstpcomB = n_tstpcom.

      IF uwm100.com2_t >= 0 THEN
         ASSIGN n_com2A = uwm100.com2_t
                n_com2B = 0.
      ELSE ASSIGN n_com2A = 0
                  n_com2B = uwm100.com2_t.

      IF n_sumprm >= 0 THEN
         ASSIGN n_sumprmA = n_sumprm
                n_sumprmB = 0.
      ELSE ASSIGN n_sumprmA = 0
                  n_sumprmB = n_sumprm.

      IF n_sumstp >= 0 THEN
         ASSIGN n_sumstpA = n_sumstp
                n_sumstpB =0.
      ELSE ASSIGN n_sumstpA = 0
                  n_sumstpB =n_sumstp.

      IF uwm100.com1_t >= 0 THEN 
         ASSIGN n_com1A = uwm100.com1_t
                n_com1B = 0.
      ELSE ASSIGN n_com1A = 0
                  n_com1B = uwm100.com1_t.

      IF nu_vat >= 0 THEN
         ASSIGN nu_vatA = nu_vat
                nu_vatB = 0.
      ELSE ASSIGN nu_vatA = 0
                  nu_vatB = nu_vat.
      
      OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
      EXPORT DELIMITER ";"
        n_branch               
        uwm100.poltyp          
        uwm100.trndat          
        uwm100.policy          
        uwm100.endno           
        uwm100.comdat          
        uwm100.expdat          
        n_insur + " " + n_add2  + " " + n_add3  
        ""            /*รหัสรถ*/ 
        n_an    
        " "           /*อัตราเบี้ยประกัน %*/
        n_prmcomA     /*เบี้ยประกันพรบ. บวก*/
        n_prmcomB     /*เบี้ยประกันพรบ. ลบ*/
        n_tstpcomA    /*อากร พรบ. บวก*/
        n_tstpcomB    /*อากร พรบ. ลบ*/
        wv_com2p      /*อัตราค่าบำเหน็จโดยบังคับ % */
        n_com2A       /*ค่าบำเหน็จโดยบังคับ บวก*/
        n_com2B       /*ค่าบำเหน็จโดยบังคับ ลบ*/
        n_sumprmA     /*เบี้ยประกันโดยสมัครใจ บวก*/
        n_sumprmB     /*เบี้ยประกันโดยสมัครใจ ลบ*/
        n_sumstpA     /*อากรเบี้ยประกันโดยสมัครใจ บวก*/
        n_sumstpB     /*อากรเบี้ยประกันโดยสมัครใจ ลบ*/
        wv_com1p      /*อัตราค่าบำเหน็จโดยสมัครใจ*/
        n_com1A       /*ค่าบำเหน็จโดยสมัครใจ บวก*/
        n_com1B       /*ค่าบำเหน็จโดยสมัครใจ ลบ*/
        nu_sbt
        nu_vatA       /* VAT ที่เป็นบวก*/
        nu_vatB       /* VAT ที่เป็น ลบ*/
        nv_sumpts     /*เบี้ยประกันรวม*/
        " "           /*วันที่รับเงิน*/
        n_agent.
        EXPORT DELIMITER ";" "".
        OUTPUT CLOSE.
END.
ELSE DO:
      IF n_prmcom >= 0 THEN 
         ASSIGN n_prmcomA = n_prmcom
                n_prmcomB = 0.
      ELSE ASSIGN n_prmcomA = 0
                  n_prmcomB = n_prmcom.

      IF n_tstpcom >= 0 THEN
         ASSIGN n_tstpcomA = n_tstpcom
                n_tstpcomB = 0.
      ELSE ASSIGN n_tstpcomA = 0
                  n_tstpcomB = n_tstpcom.

      IF uwm100.com2_t >= 0 THEN
         ASSIGN n_com2A = uwm100.com2_t
                n_com2B = 0.
      ELSE ASSIGN n_com2A = 0
                  n_com2B = uwm100.com2_t.

      IF n_sumprm >= 0 THEN
         ASSIGN n_sumprmA = n_sumprm
                n_sumprmB = 0.
      ELSE ASSIGN n_sumprmA = 0
                  n_sumprmB = n_sumprm.

      IF n_sumstp >= 0 THEN
         ASSIGN n_sumstpA = n_sumstp
                n_sumstpB =0.
      ELSE ASSIGN n_sumstpA = 0
                  n_sumstpB =n_sumstp.

      IF uwm100.com1_t >= 0 THEN 
         ASSIGN n_com1A = uwm100.com1_t
                n_com1B = 0.
      ELSE ASSIGN n_com1A = 0
                  n_com1B = uwm100.com1_t.

      IF nu_vat >= 0 THEN
         ASSIGN nu_vatA = nu_vat
                nu_vatB = 0.
      ELSE ASSIGN nu_vatA = 0
                  nu_vatB = nu_vat.
 
      OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
      EXPORT DELIMITER ";"
         n_branch           
         uwm100.poltyp          
         uwm100.trndat         
         uwm100.policy         
         uwm100.endno          
         uwm100.comdat        
         uwm100.expdat        
         n_insur + " " +  n_add2  + " " +  n_add3   
         ""           /*รหัสรถ*/
         n_an         
         " "          /*อัตราเบี้ยประกัน %*/
                                             
         n_prmcomA    /*เบี้ยประกันพรบ. บวก*/
         n_prmcomB    /*เบี้ยประกันพรบ. ลบ*/
         n_tstpcomA   /*อากร พรบ. บวก*/
         n_tstpcomB   /*อากร พรบ. ลบ*/
         wv_com2p     /*อัตราค่าบำเหน็จโดยบังคับ % */
         n_com2A      /*ค่าบำเหน็จโดยบังคับ บวก*/
         n_com2B      /*ค่าบำเหน็จโดยบังคับ ลบ*/
         n_sumprmA    /*เบี้ยประกันโดยสมัครใจ บวก*/
         n_sumprmB    /*เบี้ยประกันโดยสมัครใจ ลบ*/
         n_sumstpA    /*อากรเบี้ยประกันโดยสมัครใจ บวก*/
         n_sumstpB    /*อากรเบี้ยประกันโดยสมัครใจ ลบ*/
         wv_com1p     /*อัตราค่าบำเหน็จโดยสมัครใจ*/
         n_com1A      /*ค่าบำเหน็จโดยสมัครใจ บวก*/
         n_com1B      /*ค่าบำเหน็จโดยสมัครใจ ลบ*/
         nu_sbt
         nu_vatA      /* VAT ที่เป็นบวก*/
         nu_vatB      /* VAT ที่เป็น ลบ*/
         nv_sumpts    /*เบี้ยประกันรวม*/
         " "          /*วันที่รับเงิน*/
         n_agent.     
         EXPORT DELIMITER ";" "".
         OUTPUT CLOSE.
END.
  
   IF uwm100.prem_t >=  0  THEN DO:
      /* plus compulsory */
      e_sum1  =  e_sum1  +  n_prmcom.
      e_sum2  =  e_sum2  +  n_ttaxcom.
      e_sum3  =  e_sum3  +  n_tstpcom.
      e_sum4  =  e_sum4  +  n_prmcom  +  n_ttaxcom  +  n_tstpcom.

      e_sum1b  =  e_sum1b  +  n_prmcom.
      e_sum2b  =  e_sum2b  +  n_ttaxcom.
      e_sum3b  =  e_sum3b  +  n_tstpcom.
      e_sum4b  =  e_sum4b  +  n_prmcom  +  n_ttaxcom  +  n_tstpcom.

      /* plus comprehensive */
      e_sum5  =  e_sum5  +  n_sumprm.
      e_sum6  =  e_sum6  +  n_sumtax.
      e_sum7  =  e_sum7  +  n_sumstp.
      e_sum8  =  e_sum8  +  n_sumprm  +  n_sumtax  +  n_sumstp.

      e_sum5b =  e_sum5b +  n_sumprm.
      e_sum6b =  e_sum6b +  n_sumtax.
      e_sum7b =  e_sum7b +  n_sumstp.
      e_sum8b =  e_sum8b +  n_sumprm  +  n_sumtax  +  n_sumstp.
      
      e_sum1c = e_sum1c + nu_vat.

      IF uwm100.com1_t > 0 THEN e_com1 = e_com1 + uwm100.com1_t.
      IF uwm100.com1_t < 0 THEN s_com1 = s_com1 + uwm100.com1_t.

      IF uwm100.com2_t > 0 THEN e_com2 = e_com2 + uwm100.com2_t.
      IF uwm100.com2_t < 0 THEN s_com2 = s_com2 + uwm100.com2_t.

      /* plus total */
      n_psum2  =  n_psum2  +  n_prmcom   +  n_sumprm.
      n_psum3  =  n_psum3  +  n_ttaxcom  +  n_sumtax.
      n_psum4  =  n_psum4  +  n_tstpcom  +  n_sumstp.
      n_psum5  =  n_psum5  +  (n_prmcom  +  n_ttaxcom  +  n_tstpcom)  +
                              (n_sumprm  +  n_sumtax   +  n_sumstp).
      n_psum6  =  e_com1 + e_com2.

      n_psum2b  =  n_psum2b  +  n_prmcom   +  n_sumprm.
      n_psum3b  =  n_psum3b  +  n_ttaxcom  +  n_sumtax.
      n_psum4b  =  n_psum4b  +  n_tstpcom  +  n_sumstp.
      n_psum5b  =  n_psum5b  +  (n_prmcom  +  n_ttaxcom  +  n_tstpcom)  +
                                (n_sumprm  +  n_sumtax   +  n_sumstp).
      n_psum6b  =  s_com1  +  s_com2.

   END.
   ELSE DO:
      /* minor compulsory */
      ASSIGN
      s_sum1  =  s_sum1  +  n_prmcom
      s_sum2  =  s_sum2  +  n_ttaxcom
      s_sum3  =  s_sum3  +  n_tstpcom
      s_sum4  =  s_sum4  +  n_prmcom  +  n_ttaxcom  +  n_tstpcom

      s_sum1b  =  s_sum1b  +  n_prmcom
      s_sum2b  =  s_sum2b  +  n_ttaxcom
      s_sum3b  =  s_sum3b  +  n_tstpcom
      s_sum4b  =  s_sum4b  +  n_prmcom  +  n_ttaxcom  +  n_tstpcom.

      /* minor comprehensive */
      ASSIGN
      s_sum5  =  s_sum5  +  n_sumprm
      s_sum6  =  s_sum6  +  n_sumtax
      s_sum7  =  s_sum7  +  n_sumstp
      s_sum8  =  s_sum8  +  n_sumprm  +  n_sumtax  +  n_sumstp
      
      s_sum5b =  s_sum5b +  n_sumprm
      s_sum6b =  s_sum6b +  n_sumtax
      s_sum7b =  s_sum7b +  n_sumstp
      s_sum8b =  s_sum8b +  n_sumprm  +  n_sumtax  +  n_sumstp
      
      s_sum1c = s_sum1c + nu_vat.
      

      IF uwm100.com1_t > 0 THEN e_com1 = e_com1 + uwm100.com1_t.
      IF uwm100.com1_t < 0 THEN s_com1 = s_com1 + uwm100.com1_t.

      IF uwm100.com2_t > 0 THEN e_com2 = e_com2 + uwm100.com2_t.
      IF uwm100.com2_t < 0 THEN s_com2 = s_com2 + uwm100.com2_t.

      /* minor total */
      ASSIGN
      n_msum2  =  n_msum2  +  n_prmcom   +  n_sumprm
      n_msum3  =  n_msum3  +  n_ttaxcom  +  n_sumtax
      n_msum4  =  n_msum4  +  n_tstpcom  +  n_sumstp
      n_msum5  =  n_msum5  +  (n_prmcom  +  n_ttaxcom  +  n_tstpcom)  +
                              (n_sumprm  +  n_sumtax   +  n_sumstp).
      
      ASSIGN
      n_msum2b  =  n_msum2b +  n_prmcom  +  n_sumprm
      n_msum3b  =  n_msum3b +  n_ttaxcom +  n_sumtax
      n_msum4b  =  n_msum4b +  n_tstpcom +  n_sumstp
      n_msum5b  =  n_msum5b +  (n_prmcom +  n_ttaxcom  +  n_tstpcom)  +
                               (n_sumprm +  n_sumtax   +  n_sumstp).
      ASSIGN                
      n_msum6b  =  s_com1   + s_com2
      n_psum6b  =  e_com1   + e_com2.

   END.

   IF nv_sum >= 0   THEN DO.
      /* plus total */
      n_psum1  =  n_psum1  +  nv_sum.
      n_psum1b =  n_psum1b +  nv_sum.
   END. 
   ELSE DO:
      /* minor total */
      n_msum1  =  n_msum1  +  nv_sum.
      n_msum1b  =  n_msum1b  +  nv_sum.
   END.
   
   IF n_an  >=  0 THEN  e_sum2c = e_sum2c + n_an.
   ELSE s_sum2c = s_sum2c + n_an.

   IF nv_sumpts >= 0 THEN  e_sum3c = e_sum3c + nv_sumpts.
   ELSE s_sum3c  = s_sum3c + nv_sumpts.

   ASSIGN t_sum1  = t_sum1 + n_an
          t_sum2  = t_sum2 + nu_sbt.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE DetailMPol C-Win 
PROCEDURE DetailMPol :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*-- % --*/
DEF VAR p1 AS CHAR FORMAT "X(7)".
DEF VAR p2 AS CHAR FORMAT "X(7)".

   FIND XMM600 WHERE XMM600.ACNO = UWM100.AGENT NO-LOCK NO-ERROR.
        IF NOT AVAILABLE XMM600 THEN DO:
           N_AGENT = " NOT FOUND PRODUCER CODE " + UWM100.AGENT.
        END.
        ELSE DO.
           N_AGENT = XMM600.ACNO + " " + XMM600.NAME.
        END.

     FIND XMM600 WHERE XMM600.ACNO = UWM100.INSREF NO-LOCK NO-ERROR.
        IF NOT AVAILABLE XMM600 THEN DO:
           N_ADD2 = " NOT FOUND PRODUCER CODE " + UWM100.INSREF.
           N_ADD3 = "  ".
        END.
        ELSE DO.
           N_ADD2 =  XMM600.ADDR2.
           N_ADD3 =  XMM600.ADDR3.
        END.
   
   ASSIGN
   nv_prstp   =  uwm100.pstp + uwm100.rstp
   nv_prtax   =  uwm100.ptax + uwm100.rtax
   nv_sumpts  =  uwm100.prem_t + nv_prstp + nv_prtax - n_paprm - n_tstppa - n_taxpa
   n_sumprm   =  uwm100.prem_t - n_prmcom - n_paprm
   n_sumstp   =  nv_prstp - n_tstpcom - n_tstppa

   n_sumtax   =  nv_prtax

   n_compa_t  =  - n_paprm * nv_com1p / 100.

   IF n_paprm = 0 THEN n_com1_t = uwm100.com1_t.
   ELSE DO:
        n_com1_t   =  uwm100.com1_t - n_compa_t.

        FIND FIRST motorcom WHERE motorcom.policy = uwm100.policy AND
                   motorcom.rencnt = uwm100.rencnt  AND
                   motorcom.endcnt = uwm100.endcnt  NO-LOCK NO-ERROR.
        IF NOT AVAIL motorcom THEN DO:
           CREATE motorcom.
           ASSIGN motorcom.policy = uwm100.policy
                  motorcom.rencnt = uwm100.rencnt
                  motorcom.endcnt = uwm100.endcnt
                  motorcom.comtotal = uwm100.com1_t
                  motorcom.commo  = uwm100.com1_t - n_compa_t
                  motorcom.compa  = n_compa_t.
        END.
        ELSE DO:
           ASSIGN motorcom.policy = uwm100.policy
                  motorcom.rencnt = uwm100.rencnt
                  motorcom.endcnt = uwm100.endcnt
                  motorcom.comtotal = uwm100.com1_t
                  motorcom.commo  = uwm100.com1_t - n_compa_t
                  motorcom.compa  = n_compa_t.
        END.
   END.

   wv_com1p   = " ".  n_percen = " ". wv_com2p = " ".

   IF    nv_com1p  <> 0  THEN DO:
         n_percen   =  "%".
         wv_com1p   = STRING(nv_com1p,">9.99") + " %".
   END.
   ELSE  DO:
         n_percen   =  "%".
         wv_com1p   =  "0.00 %".

   END.

   IF    nv_com2p  <> 0  THEN DO:
         n_percen   =  "%".
         wv_com2p   = STRING(nv_com2p,">9.99") + " %".
   END.
   ELSE  DO:
         n_percen   =  "%".
         wv_com2p   =  "0.00 %".

   END.

  ASSIGN  nu_tax = n_sumtax - n_taxpa
          nu_prm = n_prmcom + n_sumprm + n_tstpcom + n_sumstp
          nu_vat = nu_tax.

      IF  SUBSTR(uwm100.policy,3,2) <> "70" THEN DO:
          p1 = STRING(nv_com1p,">9.99") + " %".
          p2 = STRING(nv_com2p,">9.99") + " %".

          OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
          EXPORT DELIMITER ";"
          n_branch      
          uwm100.poltyp 
          uwm100.trndat 
          uwm100.policy 
          uwm100.comdat 
          uwm100.expdat 
          n_insur + " " + n_add2 + " " + n_add3 
          " "             /*รหัสรถ*/
          n_an          
          " "             /*อัตราเบี้ยประกัน %*/
          n_prmcom       
          n_tstpcom      
          n_sumprm       
          n_sumstp       
          nu_sbt         
          nu_vat         
          nv_sumpts      
          " "             /*วันที่รับเงิน*/
          uwm100.com1_t  
          p1              /*nv_com1p*/
          uwm100.com2_t  
          p2              /*nv_com2p */
          n_agent.
          OUTPUT CLOSE.
      END.                                                

      ELSE DO:
          OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
          EXPORT DELIMITER ";"
          n_branch      
          uwm100.poltyp 
          uwm100.trndat 
          uwm100.policy 
          uwm100.comdat 
          uwm100.expdat 
          n_insur + " " + n_add2 + " " + n_add3 
          " "            /*รหัสรถ*/
          n_an          
          " "            /*อัตราเบี้ยประกัน %*/
          n_prmcom       
          n_tstpcom      
          n_sumprm       
          n_sumstp       
          nu_sbt         
          nu_vat         
          nv_sumpts      
          " "             /*วันที่รับเงิน*/
          uwm100.com2_t 
          wv_com2p      
          uwm100.com1_t 
          wv_com1p 
          n_agent.
          OUTPUT CLOSE.
      END.
  
  ASSIGN  n_sum1 =  n_sum1 +  nv_sum
          n_sum2 =  n_sum2 +  n_sumprm
          n_sum3 =  n_sum3 +  n_sumtax
          n_sum4 =  n_sum4 +  n_sumstp
          n_sum5 =  n_sum5 +  nv_sumpts
          n_sum6 =  n_sum6 +  uwm100.com1_t
          n_sum7 =  n_sum7 +  n_prmcom
          n_sum8 =  n_sum8 +  n_ttaxcom
          n_sum9 =  n_sum9 +  n_tstpcom
          
          n_sum1b =  n_sum1b +  nv_sum
          n_sum2b =  n_sum2b +  n_sumprm
          n_sum3b =  n_sum3b +  n_sumtax
          n_sum4b =  n_sum4b +  n_sumstp
          n_sum5b =  n_sum5b +  nv_sumpts
          n_sum6b =  n_sum6b +  uwm100.com2_t
          
          n_sum10b =  n_sum10b +  n_com1_t
          
          n_sum7b =  n_sum7b +  n_prmcom
          n_sum8b =  n_sum8b +  n_ttaxcom
          n_sum9b =  n_sum9b +  n_tstpcom
          
          nu_sbt_t = nu_sbt_t + nu_sbt
          nu_vat_t = nu_vat_t + nu_vat.

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
  DISPLAY fi_proctyp fi_poltyp fi_poltyp2 fi_dir fi_datfr fi_datto fi_agfr 
          fi_agto fi_brfr fi_brto fi_broker fi_output 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE fi_proctyp fi_poltyp fi_poltyp2 fi_dir fi_datfr fi_datto fi_agfr 
         fi_agto fi_brfr fi_brto fi_broker fi_output czjovtwiBu_ok Bu_Cancel 
         IMAGE-24 RECT-303 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE prnColNon C-Win 
PROCEDURE prnColNon :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
EXPORT DELIMITER ";"
    "สมุดทะเบียนรับประกันภัยรถโดยความสมัครใจและโดยข้อบังคับของกฎหมาย (ทบ.1.2) (สลักหลัง) ".
EXPORT DELIMITER ";"
    nv_datetop.
EXPORT DELIMITER ";"
    "วันที่พิมพ์:"  TODAY   " เวลาที่พิมพ์:"   STRING(n_eTIME,"hh:mm:ss") 
    "     RELEASE: YES"   "  Program Id.: WACTBLNN (NON-MOTOR)".
EXPORT DELIMITER ";"
    "สาขา" 
    "ประเภทกรมธรรม์" 
    "วันทำสัญญา" 
    "เลขที่กรมธรรม์" 
    "เลขที่สลักหลัง" 
    "วันที่เริ่มต้น" 
    "วันที่สิ้นสุด"
    "ชื่อของผู้เอาประกันภัยและรายละเอียด" 
    "จำนวนเงินซึ่งเอาประกัน" 
    "วันที่รับเบี้ยประกัน" 
    "เบี้ยประกัน" 
    "อากร" 
    "VAT" 
    "SBT" 
    "เบี้ยประกันรวม" 
    "ค่าบำเหน็จ" 
    "วันที่จ่ายค่าบำเหน็จ" 
    "ชื่อผู้หาประกัน".  
OUTPUT CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE prnColumn C-Win 
PROCEDURE prnColumn :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
EXPORT DELIMITER ";"
    "สมุดทะเบียนรับประกันภัยรถโดยความสมัครใจและโดยข้อบังคับของกฎหมาย (ทบ.1.2) (กรมธรรม์) ".
EXPORT DELIMITER ";"
    nv_datetop.
EXPORT DELIMITER ";"
    "วันที่พิมพ์:"  TODAY   " เวลาที่พิมพ์:"     STRING(n_eTIME,"hh:mm:ss") 
    "     RELEASE: YES"     "  Program Id.: WACTBLNN (NON-MOTOR)".
EXPORT DELIMITER ";"
    "สาขา" 
    "ประเภทกรมธรรม์"
    "วันทำสัญญา" 
    "เลขที่กรมธรรม์" 
    "วันที่เริ่มต้น" 
    "วันที่สิ้นสุด" 
    "ชื่อของผู้เอาประกันภัยและรายละเอียด"
    "จำนวนเงินซึ่งเอาประกัน" 
    "วันที่รับเบี้ยประกัน"
    "เบี้ยประกัน"
    "อากร" 
    "VAT" 
    "SBT" 
    "เบี้ยประกันรวม" 
    "ค่าบำเหน็จ" 
    "วันที่จ่ายค่าบำเหน็จ" 
    "ชื่อผู้หาประกัน".  
OUTPUT CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProCan C-Win 
PROCEDURE ProCan :
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
            uwm307.endcnt = uwm100.endcnt NO-LOCK.

        IF AVAIL uwm307 THEN  DO:
           nv_sum  = nv_sum  + uwm307.mbsi[1].
        END.
        ELSE DO:
           DISPLAY   "ERROR UWM307 NOT AVAIL" UWM307.POLICY.
           PAUSE 5.
        END.

   END.
END.
ELSE DO:
  FOR EACH uwm120 USE-INDEX uwm12001 WHERE 
           uwm120.policy = uwm100.policy AND 
           uwm120.rencnt = uwm100.rencnt AND 
           uwm120.endcnt = uwm100.endcnt NO-LOCK.

     IF AVAIL uwm120 THEN DO:
        nv_sum  = nv_sum + (uwm120.sigr - uwm120.sico).
     END.

  END.

END.
 
nv_sum = nv_sum * -1.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcMEnd C-Win 
PROCEDURE ProcMEnd :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN nv_output = n_write
       n_etime = time.

RUN prnColNon.

FOR EACH uwm100 USE-INDEX uwm10008 NO-LOCK WHERE
         uwm100.trndat >= n_date_fr AND
         uwm100.trndat <= n_date_to AND
         uwm100.poltyp >= n_type    AND     
         uwm100.poltyp <= n_type2   AND     
         uwm100.agent  >= n_ag_fr   AND
         uwm100.agent  <= n_ag_to   AND
         uwm100.branch >= n_saka    AND
         uwm100.branch <= n_sakt    AND
         uwm100.endcnt <> 000       AND
         uwm100.dir_ri  = nv_dir2   AND
         SUBSTRING(uwm100.policy,7,1) = "B"  AND
        (SUBSTR(uwm100.policy,1,1)    = "D"   OR
         SUBSTR(uwm100.policy,1,1)    = "C"   OR  /* Credit Risk Line 01 */
         SUBSTR(uwm100.policy,1,1)    = "I"   OR
         /*--- A500178 ---*/
         SUBSTR(uwm100.policy,1,2)   >= "10"   AND
         SUBSTR(uwm100.policy,1,2)   <= "99")  AND
         /*--- A500178 ---*/
         uwm100.releas  = YES
         BREAK BY uwm100.branch
               BY uwm100.poltyp    
               BY SUBSTR(uwm100.policy,7,2)
               BY uwm100.endno
               BY uwm100.trndat
               BY TRANTY:

   FIND FIRST xmm023 USE-INDEX xmm02301 WHERE uwm100.branch = xmm023.branch
   NO-LOCK NO-ERROR.
   ASSIGN  n_branch = uwm100.branch
           n_bdes   = xmm023.bdes
           n_dir    = uwm100.dir_ri
           n_dept   = uwm100.dept

           n_an     = 0
           nv_sum   = 0
           nv_code  = "ERR"
           nvexch   = 1.

   FIND FIRST uwm120 USE-INDEX uwm12001 WHERE uwm120.policy = uwm100.policy
                                        AND   uwm120.rencnt = uwm100.rencnt
                                        AND   uwm120.endcnt = uwm100.endcnt
                                        NO-LOCK NO-ERROR.
   IF AVAIL uwm120 THEN DO:
      ASSIGN nvcurr    = uwm120.sicurr
             nv_com1p  = uwm120.com1p.

      IF SUBSTR(uwm120.policy,3,2) = "90" THEN nvexch = 1.
      ELSE  nvexch = uwm120.siexch.
   END.

   IF TRIM(uwm100.ntitle) = "" THEN n_insur = "".
   ELSE n_insur = TRIM(uwm100.ntitle) + " ".

   IF TRIM(uwm100.fname)  = "" THEN n_insur = n_insur + uwm100.name1.
   ELSE n_insur = n_insur + uwm100.fname + " " + uwm100.name1.

   N_ENDCNT =  uwm100.endcnt - 1.

  IF UWM100.TRANTY <> "C" THEN DO:
     RUN ProTranty.
  END.
  ELSE DO:
     RUN ProCan.
  END.

  IF   NVCURR <> "BHT"  THEN DO:
       n_an =  round(nvexch * nv_sum,2).
  END.
  ELSE DO:
       n_an =  nv_sum.
  END.

  nv_sum  =  n_an.

   FIND XMM600 WHERE XMM600.ACNO = UWM100.AGENT NO-LOCK NO-ERROR.
        IF NOT AVAILABLE XMM600 THEN DO:
           N_AGENT = " NOT FOUND PRODUCER CODE " + UWM100.AGENT.
        END.
        ELSE DO.
           N_AGENT = XMM600.ACNO + " " + XMM600.NAME.
        END.
     FIND XMM600 WHERE XMM600.ACNO = UWM100.INSREF NO-LOCK NO-ERROR.
        IF NOT AVAILABLE XMM600 THEN DO:
           ASSIGN N_ADD2 = " NOT FOUND PRODUCER CODE " + UWM100.INSREF
                  N_ADD3 = "  ".
        END.
        ELSE DO.
           ASSIGN N_ADD2 =  XMM600.ADDR2
                  N_ADD3 =  XMM600.ADDR3.
        END.
   
   ASSIGN   nv_prstp = uwm100.pstp + uwm100.rstp
            nv_prtax = uwm100.ptax + uwm100.rtax
            nv_sumpts = uwm100.prem_t + nv_prstp + nv_prtax
            N_PERCEN = "%"

            nu_prm = uwm100.prem_t + nv_prstp

            nu_prasee = nv_prtax
            nu_prasee2  = (nu_prm * 0.06).

   IF nu_prasee  < 0 THEN  nu_prasee  = nu_prasee  * -1.
   if nu_prasee2 < 0 THEN  nu_prasee2 = nu_prasee2 * -1.

   IF nu_prasee >= nu_prasee2 THEN DO:
      ASSIGN  nu_vat = nv_prtax
              nu_sbt = 0.
   END.
   ELSE DO:
      ASSIGN  nu_vat = 0
              nu_sbt = nv_prtax.
   END.
   
   OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
   EXPORT DELIMITER ";" 
       n_branch      
       uwm100.poltyp 
       uwm100.trndat  
       uwm100.policy  
       uwm100.endno   
       uwm100.comdat 
       uwm100.expdat 
       n_insur + " " + n_add2 + " " + n_add3 
       n_an           
       " "             /*วันที่รับเบี้ยประกัน*/
       uwm100.prem_t  
       nv_prstp       
       nu_vat         
       nu_sbt         
       nv_sumpts      
       uwm100.com1_t  
       " "             /*วันที่จ่ายค่าบำเหน็จ*/
       n_agent.
   OUTPUT CLOSE.

   /*-----รวมแต่ละ Broker-----*/
   IF FIRST-OF(SUBSTR(uwm100.policy,7,2)) THEN 
      ASSIGN e_sum1m   = 0     s_sum1m   =  0       n_sum1m   =  0
             e_sum2m   = 0     s_sum2m   =  0       n_sum2m   =  0
             e_sum3m   = 0     s_sum3m   =  0       n_sum3m   =  0
             e_sum4m   = 0     s_sum4m   =  0       n_sum4m   =  0
             e_sum5m   = 0     s_sum5m   =  0       n_sum5m   =  0
             e_sum6m   = 0     s_sum6m   =  0       n_sum6m   =  0
             nu_vat_p2 = 0     nu_vat_l2 =  0       nu_vat_t2 =  0
             nu_sbt_p2 = 0     nu_sbt_l2 =  0       nu_sbt_t2 =  0 .
               
   IF uwm100.prem_t > 0 THEN  DO:
      ASSIGN e_sum1m =  e_sum1m     + nv_sum
             e_sum2m =  e_sum2m     + uwm100.prem_t
             e_sum3m =  e_sum3m     + nv_prtax
             e_sum4m =  e_sum4m     + nv_prstp
             e_sum5m =  e_sum5m     + nv_sumpts
             nu_vat_p2  = nu_vat_p2 + nu_vat
             nu_sbt_p2  = nu_sbt_p2 + nu_sbt.
   END.
   ELSE DO.
      IF uwm100.prem_t <= 0 THEN DO :
         ASSIGN s_sum1m    = s_sum1m    + nv_sum
                s_sum2m    = s_sum2m    + uwm100.prem_t
                s_sum3m    = s_sum3m    + nv_prtax
                s_sum4m    = s_sum4m    + nv_prstp
                s_sum5m    = s_sum5m    + nv_sumpts
                nu_vat_l2  = nu_vat_l2  + nu_vat
                nu_sbt_l2  = nu_sbt_l2  + nu_sbt.
      END.
   END.

   IF uwm100.com1_t <  0  THEN DO:
      e_sum6m =  e_sum6m +  uwm100.com1_t.
   END.
   ELSE DO.
    IF uwm100.com1_t >=  0 THEN
       s_sum6m =  s_sum6m +  uwm100.com1_t.
   END.

   ASSIGN  n_sum1m   = n_sum1m   + nv_sum
           n_sum2m   = n_sum2m   + uwm100.prem_t
           n_sum3m   = n_sum3m   + nv_prtax
           n_sum4m   = n_sum4m   + nv_prstp
           n_sum5m   = n_sum5m   + nv_sumpts
           n_sum6m   = n_sum6m   + uwm100.com1_t
           nu_vat_t2 = nu_vat_t2 + nu_vat
           nu_sbt_t2 = nu_sbt_t2 + nu_sbt.

   IF LAST-OF(SUBSTR(uwm100.policy,7,2)) THEN DO:
      n_insur   =   "รวมสลักหลังเพิ่ม" .
    

    OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
    EXPORT DELIMITER ";"
         "" "" "" "" n_insur 
         "" "" ""    e_sum1m 
         ""          e_sum2m 
         e_sum4m   
         nu_vat_p2 
         nu_sbt_p2 
         e_sum5m   
         e_sum6m.
    OUTPUT CLOSE.

    ASSIGN n_insur   =   " " 
           n_insur   =   "รวมสลักหลังลด".
    
    OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
    EXPORT DELIMITER ";"
         "" "" "" "" n_insur 
         "" "" "" s_sum1m 
         ""         s_sum2m
         s_sum4m   
         nu_vat_l2 
         nu_sbt_l2 
         s_sum5m   
         s_sum6m.
    OUTPUT CLOSE.

    n_insur   =   " " .
    n_insur   =   "รวม" .
    

    OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
    EXPORT DELIMITER ";"
         "" "" "" "" n_insur 
         "" "" "" n_sum1m 
         ""       n_sum2m 
         n_sum4m   
         nu_vat_t2 
         nu_sbt_t2 
         n_sum5m   
         n_sum6m. 
    EXPORT DELIMITER ";" "".
    OUTPUT CLOSE.
   END.

   /*---รวมค่าแต่ละ Line ----*/
   IF FIRST-OF(uwm100.poltyp) THEN 
      ASSIGN 
         e_sum1l = 0       s_sum1l =  0         n_sum1l =  0
         e_sum2l = 0       s_sum2l =  0         n_sum2l =  0
         e_sum3l = 0       s_sum3l =  0         n_sum3l =  0
         e_sum4l = 0       s_sum4l =  0         n_sum4l =  0
         e_sum5l = 0       s_sum5l =  0         n_sum5l =  0
         e_sum6l = 0       s_sum6l =  0         n_sum6l =  0
         nu_vat_p1 = 0     nu_vat_l1 = 0        nu_vat_t1 = 0
         nu_sbt_p1 = 0     nu_sbt_l1 = 0        nu_sbt_t1 = 0 .

   IF uwm100.prem_t >  0 THEN DO:
      e_sum1l =  e_sum1l + nv_sum.
      e_sum2l =  e_sum2l + uwm100.prem_t.
      e_sum3l =  e_sum3l + nv_prtax.
      e_sum4l =  e_sum4l + nv_prstp.
      e_sum5l =  e_sum5l + nv_sumpts.
      nu_vat_p1  = nu_vat_p1  + nu_vat.
      nu_sbt_p1  = nu_sbt_p1  + nu_sbt.
   END.
   ELSE DO.
      IF uwm100.prem_t <= 0 THEN DO:
         ASSIGN s_sum1l = s_sum1l + nv_sum
                s_sum2l = s_sum2l + uwm100.prem_t
                s_sum3l = s_sum3l + nv_prtax
                s_sum4l = s_sum4l + nv_prstp
                s_sum5l = s_sum5l + nv_sumpts
                nu_vat_l1  = nu_vat_l1  + nu_vat
                nu_sbt_l1  = nu_sbt_l1  + nu_sbt.
      END.
   END.

   IF uwm100.com1_t <  0 THEN DO:
      e_sum6l =  e_sum6l +  uwm100.com1_t.
   END.
   ELSE DO.
      IF uwm100.com1_t >=  0  THEN 
         s_sum6l =  s_sum6l +  uwm100.com1_t.
   END .
   
   ASSIGN  n_sum1l = n_sum1l + nv_sum
           n_sum2l = n_sum2l + uwm100.prem_t
           n_sum3l = n_sum3l + nv_prtax
           n_sum4l = n_sum4l + nv_prstp
           n_sum5l = n_sum5l + nv_sumpts
           n_sum6l = n_sum6l + uwm100.com1_t
           nu_vat_t1 = nu_vat_t1 + nu_vat
           nu_sbt_t1 = nu_sbt_t1 + nu_sbt.

   IF LAST-OF(uwm100.poltyp) THEN DO:
      n_insur   =   "รวมสลักหลังเพิ่ม" + " " + uwm100.poltyp.
      
      OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
      EXPORT DELIMITER ";"
         "" "" "" "" n_insur 
         "" "" ""    e_sum1l 
         ""          e_sum2l 
         e_sum4l   
         nu_vat_p1 
         nu_sbt_p1 
         e_sum5l   
         e_sum6l.
      OUTPUT CLOSE.
    
      ASSIGN n_insur   =   " " 
             n_insur   =   "รวมสลักหลังลด" + " " + uwm100.poltyp.

      OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
      EXPORT DELIMITER ";"
         "" "" "" "" n_insur 
         "" "" ""    s_sum1l
         ""          s_sum2l
         s_sum4l   
         nu_vat_l1 
         nu_sbt_l1 
         s_sum5l   
         s_sum6l.
      OUTPUT CLOSE.
      
      ASSIGN n_insur   =   " " 
             n_insur   =   "รวม" + " " + uwm100.poltyp.

      OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
      EXPORT DELIMITER ";"
         "" "" "" "" n_insur 
         "" "" ""    n_sum1l 
         ""          n_sum2l 
         n_sum4l    
         nu_vat_t1  
         nu_sbt_t1  
         n_sum5l    
         n_sum6l.
      OUTPUT CLOSE.
   END.

   /*----รวมค่าแต่ละ Branch ------*/
   IF FIRST-OF(uwm100.branch) THEN 
      ASSIGN 
         e_sum1b = 0       s_sum1b =  0         n_sum1b =  0
         e_sum2b = 0       s_sum2b =  0         n_sum2b =  0
         e_sum3b = 0       s_sum3b =  0         n_sum3b =  0
         e_sum4b = 0       s_sum4b =  0         n_sum4b =  0
         e_sum5b = 0       s_sum5b =  0         n_sum5b =  0
         e_sum6b = 0       s_sum6b =  0         n_sum6b =  0
         nu_vat_t = 0      nu_sbt_t = 0
         nu_vat_p = 0      nu_sbt_p = 0
         nu_vat_l = 0      nu_sbt_l = 0.

   IF  uwm100.prem_t >  0  THEN DO:
       ASSIGN e_sum1b   =  e_sum1b  + nv_sum
              e_sum2b   =  e_sum2b  + uwm100.prem_t
              e_sum3b   =  e_sum3b  + nv_prtax
              e_sum4b   =  e_sum4b  + nv_prstp
              e_sum5b   =  e_sum5b  + nv_sumpts
              nu_vat_p  = nu_vat_p  + nu_vat
              nu_sbt_p  = nu_sbt_p  + nu_sbt.
   END.
   ELSE DO.
      IF uwm100.prem_t <= 0 THEN DO:
         ASSIGN s_sum1b = s_sum1b + nv_sum
                s_sum2b = s_sum2b + uwm100.prem_t
                s_sum3b = s_sum3b + nv_prtax
                s_sum4b = s_sum4b + nv_prstp
                s_sum5b = s_sum5b + nv_sumpts
                nu_vat_l = nu_vat_l  + nu_vat
                nu_sbt_l = nu_sbt_l  + nu_sbt.
      END.
   END.

   IF uwm100.com1_t <  0  THEN DO:
      e_sum6b =  e_sum6b +  uwm100.com1_t.
   END.
   ELSE DO.
      IF uwm100.com1_t >=  0  THEN
         s_sum6b =  s_sum6b +  uwm100.com1_t.
   END.

   ASSIGN n_sum1b = n_sum1b + nv_sum
          n_sum2b = n_sum2b + uwm100.prem_t
          n_sum3b = n_sum3b + nv_prtax
          n_sum4b = n_sum4b + nv_prstp
          n_sum5b = n_sum5b + nv_sumpts
          n_sum6b = n_sum6b + uwm100.com1_t
          nu_vat_t = nu_vat_t + nu_vat
          nu_sbt_t = nu_sbt_t + nu_sbt
          nu_vat   = 0
          nu_sbt   = 0.

   IF LAST-OF(uwm100.branch) THEN DO:
      n_insur = "รวมสลักหลังเพิ่มสาขา" + " " + uwm100.branch + " " + n_bdes.
    
      OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
      EXPORT DELIMITER ";"
         "" "" "" "" n_insur 
         "" "" ""    e_sum1b 
         ""          e_sum2b 
         e_sum4b   
         nu_vat_p  
         nu_sbt_p  
         e_sum5b   
         e_sum6b.
      OUTPUT CLOSE.
      
      ASSIGN n_insur = " " 
             n_insur = "รวมสลักหลังลดสาขา" + " " + uwm100.branch + " " + n_bdes.
    

      OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
      EXPORT DELIMITER ";"
         "" "" "" "" n_insur
         "" "" ""    s_sum1b
         ""          s_sum2b
         s_sum4b  
         nu_vat_l 
         nu_sbt_l 
         s_sum5b  
         s_sum6b.
      OUTPUT CLOSE.

      ASSIGN n_insur   =   " " 
             n_insur   =   "รวมสาขา" + " " + uwm100.branch + " " + n_bdes .
    
      OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
      EXPORT DELIMITER ";"
         "" "" "" "" n_insur 
         "" "" ""    n_sum1b 
         ""          n_sum2b 
         n_sum4b  
         nu_vat_t 
         nu_sbt_t 
         n_sum5b  
         n_sum6b.
      OUTPUT CLOSE.

   END.
   
END. /*FOR EACH*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcMPol C-Win 
PROCEDURE ProcMPol :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN nv_output = n_write + ".slk"
       n_etime = time.

RUN prncolumn.

FOR EACH uwm100 USE-INDEX uwm10008 NO-LOCK WHERE
         uwm100.trndat >= n_date_fr        AND
         uwm100.trndat <= n_date_to        AND
         uwm100.poltyp >= n_type           AND     
         uwm100.poltyp <= n_type2          AND     
         uwm100.branch >= n_saka           AND
         uwm100.branch <= n_sakt           AND
         uwm100.endcnt  = 000              AND
         uwm100.dir_ri  =  nv_dir2         AND
         uwm100.agent  >=  n_ag_fr         AND
         uwm100.agent  <=  n_ag_to         AND
         SUBSTR(uwm100.POLICY,7,1)  > "9"  AND
        (SUBSTR(uwm100.policy,1,1)  = "D"  OR
         SUBSTR(uwm100.policy,1,1)  = "I"  OR
         /*--- A500178 ---*/
         SUBSTR(uwm100.policy,1,2)   >= "10"   AND
         SUBSTR(uwm100.policy,1,2)   <= "99")  AND
         /*--- A500178 ---*/
         uwm100.releas = YES          
         BREAK BY uwm100.branch
               BY uwm100.poltyp 
               BY SUBSTR(uwm100.POLICY,7,2)
               BY uwm100.policy
               BY uwm100.trndat 
               BY TRANTY:

   FIND FIRST xmm023 USE-INDEX xmm02301 WHERE uwm100.branch = xmm023.branch
   NO-LOCK NO-ERROR.
   ASSIGN  n_branch = uwm100.branch
           n_bdes   = xmm023.bdes
           n_dir    = uwm100.dir_ri
           n_dept   = uwm100.dept
           
           n_an     = 0
           nv_sum   = 0
           nvexch   = 1.
   /*------*/
   IF TRIM(uwm100.ntitle) = "" THEN n_insur = "".
   ELSE  n_insur = TRIM(uwm100.ntitle) + " ".
   IF TRIM(uwm100.fname)  = "" THEN n_insur = n_insur + uwm100.name1.
   ELSE n_insur = n_insur + uwm100.fname + " " + uwm100.name1.

   IF uwm100.poltyp   = "M60" OR  uwm100.poltyp = "M61" OR
      uwm100.poltyp   = "M62" OR  uwm100.poltyp = "M63" OR
      uwm100.poltyp   = "M64" OR  uwm100.poltyp = "M67" THEN DO:

      FOR EACH uwm307 USE-INDEX uwm30701     WHERE 
               uwm307.policy = uwm100.policy AND 
               uwm307.rencnt = uwm100.rencnt AND 
               uwm307.endcnt = uwm100.endcnt NO-LOCK.
               nv_sum  = nv_sum  + uwm307.mbsi[1].
      END.
   END .
   ELSE DO:
        FOR EACH uwm120 USE-INDEX uwm12001     WHERE 
                 uwm120.policy = uwm100.policy AND 
                 uwm120.rencnt = uwm100.rencnt AND 
                 uwm120.endcnt = uwm100.endcnt NO-LOCK.
            IF AVAIL uwm120 THEN  DO:
               nv_sum  = nv_sum + (uwm120.sigr - uwm120.sico).
            END.
        END.
   END.

   FIND FIRST uwm120 USE-INDEX uwm12002     WHERE 
              uwm120.policy = uwm100.policy AND 
              uwm120.rencnt = uwm100.rencnt AND 
              uwm120.endcnt = uwm100.endcnt NO-LOCK NO-ERROR.
   IF AVAIL uwm120 THEN DO:
      IF SUBSTRING(uwm120.policy,3,2) = "90" THEN nvexch = 1.
      ELSE nvexch = uwm120.siexch.
      nv_com1p = uwm120.com1p.
   END.
    
   n_an =  nv_sum * nvexch.

   FIND XMM600 WHERE XMM600.ACNO = UWM100.AGENT NO-LOCK NO-ERROR.
   IF NOT AVAILABLE XMM600 THEN DO:
      N_AGENT = " NOT FOUND PRODUCER CODE " + UWM100.AGENT.
   END.
   ELSE DO.
      N_AGENT = XMM600.ACNO + " " + XMM600.NAME.
   END.

     FIND XMM600 WHERE XMM600.ACNO = UWM100.INSREF NO-LOCK NO-ERROR.
        IF NOT AVAILABLE XMM600 THEN DO:
           N_ADD2 = " NOT FOUND PRODUCER CODE " + UWM100.INSREF.
           N_ADD3 = "  ".
        END.
        ELSE DO.
           N_ADD2 =  XMM600.ADDR2.
           N_ADD3 =  XMM600.ADDR3.
        END.
   
   ASSIGN   nv_prstp  = uwm100.pstp   + uwm100.rstp
            nv_prtax  = uwm100.ptax   + uwm100.rtax
            nv_sumpts = uwm100.prem_t + nv_prstp  +  nv_prtax
            n_percen  = "%"
            nu_prm    = uwm100.prem_t + nv_prstp.

   IF nv_prtax >= (nu_prm * 0.06) THEN DO:
      ASSIGN nu_vat = nv_prtax
             nu_sbt = 0.
   END.
   ELSE DO:
      ASSIGN nu_vat = 0
             nu_sbt = nv_prtax.
   END.

   OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
   EXPORT DELIMITER ";"
       n_branch      
       uwm100.poltyp 
       uwm100.trndat  
       uwm100.policy  
       uwm100.comdat  FORMAT "99/99/9999" 
       uwm100.expdat  
       n_insur + " " + n_add2 + " " + n_add3 
       n_an           
       " "             /*วันที่รับเบี้ยประกัน*/
       uwm100.prem_t  
       nv_prstp       
       nu_vat         
       nu_sbt         
       nv_sumpts      
       uwm100.com1_t  
       " "            /*วันที่จ่ายค่าบำเหน็จ*/
       n_agent.
   OUTPUT CLOSE.
   
   ASSIGN  n_sum1 =  n_sum1 +  nv_sum
           n_sum2 =  n_sum2 +  prem_t
           n_sum3 =  n_sum3 +  nv_prtax
           n_sum4 =  n_sum4 +  nv_prstp
           n_sum5 =  n_sum5 +  nv_sumpts
           n_sum6 =  n_sum6 +  uwm100.com1_t.

  IF FIRST-OF(uwm100.branch) THEN DO:
     ASSIGN  n_sumb1  =  0     n_sumb2  =  0
             n_sumb3  =  0     n_sumb4  =  0
             n_sumb5  =  0     n_sumb6  =  0
             nu_vat_b =  0     nu_sbt_b =  0.
  END.

  ASSIGN  n_sumb1  =  n_sumb1 +  nv_sum
          n_sumb2  =  n_sumb2 +  prem_t
          n_sumb3  =  n_sumb3 +  nv_prtax
          n_sumb4  =  n_sumb4 +  nv_prstp
          n_sumb5  =  n_sumb5 +  nv_sumpts
          n_sumb6  =  n_sumb6 +  uwm100.com1_t
          nu_vat_b =  nu_vat_b +  nu_vat
          nu_sbt_b =  nu_sbt_b +  nu_sbt.

  /*รวมค่าแต่ละ Line */
  IF FIRST-OF(uwm100.poltyp) THEN DO:
     ASSIGN  n_suml1  =  0    n_suml2  =  0
             n_suml3  =  0    n_suml4  =  0
             n_suml5  =  0    n_suml6  =  0
             nu_vat_l =  0    nu_sbt_l =  0.
  END.

  ASSIGN n_suml1  =  n_suml1 +  nv_sum
         n_suml2  =  n_suml2 +  prem_t
         n_suml3  =  n_suml3 +  nv_prtax
         n_suml4  =  n_suml4 +  nv_prstp
         n_suml5  =  n_suml5 +  nv_sumpts
         n_suml6  =  n_suml6 +  uwm100.com1_t
         nu_vat_l =  nu_vat_l +  nu_vat
         nu_sbt_l =  nu_sbt_l +  nu_sbt.

  IF FIRST-OF(SUBSTR(uwm100.policy,7,2)) THEN DO:
     ASSIGN  n_sumM1 =  0     n_sumM2 =  0
             n_sumM3 =  0     n_sumM4 =  0
             n_sumM5 =  0     n_sumM6 =  0
             nu_vat_t = 0     nu_sbt_t = 0.
  END.

  ASSIGN  n_sumM1  =  n_sumM1 +  nv_sum
          n_sumM2  =  n_sumM2 +  prem_t
          n_sumM3  =  n_sumM3 +  nv_prtax
          n_sumM4  =  n_sumM4 +  nv_prstp
          n_sumM5  =  n_sumM5 +  nv_sumpts
          n_sumM6  =  n_sumM6 +  uwm100.com1_t
          nu_vat_t =  nu_vat_t + nu_vat
          nu_sbt_t =  nu_sbt_t + nu_sbt.

  IF LAST-OF(SUBSTR(uwm100.policy,7,2))  THEN DO:
     n_txt1   =   "รวม ".
     
     OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
     EXPORT DELIMITER ";"
         "" "" "" "" n_txt1 
         "" ""       n_sumM1 
         ""          n_sumM2 
         n_sumM4  
         nu_vat_t 
         nu_sbt_t 
         n_sumM5  
         n_sumM6.
     OUTPUT CLOSE.
  END.

  /*--รวมค่าแต่ละ Line--*/
  IF LAST-OF(uwm100.poltyp) THEN DO:
     n_txt2   =   "รวม" + "  " + uwm100.poltyp.

     OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
     EXPORT DELIMITER ";"
         "" "" "" "" n_txt2
         "" ""       n_suml1 
         ""          n_suml2 
         n_suml4  
         nu_vat_l 
         nu_sbt_l 
         n_suml5  
         n_suml6.
     EXPORT DELIMITER ";" "".
     OUTPUT CLOSE.
  END.

  IF LAST-OF(uwm100.branch) THEN DO:
     n_insur   =   "รวมสาขา" + " " + uwm100.branch + " " + n_bdes.
     
     OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
     EXPORT DELIMITER ";"
         "" "" "" "" n_insur
         "" ""       n_sumb1 
         ""          n_sumb2 
         n_sumb4  
         nu_vat_b 
         nu_sbt_b 
         n_sumb5  
         n_sumb6.
     EXPORT DELIMITER ";" "".
     OUTPUT CLOSE.
  END.
  
END. /*FOR EACH*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcMPolBrNo C-Win 
PROCEDURE ProcMPolBrNo :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN nv_output = n_write
       n_etime = time.

RUN prnColumn.

FOR EACH uwm100 USE-INDEX uwm10008 NO-LOCK WHERE
         uwm100.trndat >= n_date_fr          AND
         uwm100.trndat <= n_date_to          AND
         uwm100.poltyp >= n_type             AND    
         uwm100.poltyp <= n_type2            AND    
         uwm100.branch >= n_saka             AND
         uwm100.branch <= n_sakt             AND
         uwm100.endcnt  =  000               AND
         uwm100.dir_ri  =  nv_dir2           AND
         uwm100.agent  >=  n_ag_fr           AND
         uwm100.agent  <=  n_ag_to           AND
         SUBSTRING(uwm100.POLICY,7,1) <> "B" AND
        (SUBSTR(uwm100.policy,1,1)    = "D"  OR
         SUBSTR(uwm100.policy,1,1)    = "I"  OR
         /*--- A500178 ---*/
         SUBSTR(uwm100.policy,1,2)   >= "10"   AND
         SUBSTR(uwm100.policy,1,2)   <= "99")  AND
         /*--- A500178 ---*/
         uwm100.releas = YES
         BREAK  BY  uwm100.branch
                BY  uwm100.poltyp
                BY  UWM100.policy
                BY  uwm100.trndat
                BY  TRANTY:

   FIND FIRST xmm023 USE-INDEX xmm02301 WHERE uwm100.branch = xmm023.branch
   NO-LOCK NO-ERROR.
        ASSIGN  n_branch = uwm100.branch
                n_bdes   = xmm023.bdes
                n_dir    = uwm100.dir_ri
                n_dept   = uwm100.dept
                
                n_an     = 0
                nv_sum   = 0
                nvexch   = 1.
   
   /*------*/
   IF TRIM(uwm100.ntitle) = "" THEN n_insur = "".
   ELSE n_insur = TRIM(uwm100.ntitle) + " ".

   IF TRIM(uwm100.fname)  = "" THEN n_insur = n_insur + uwm100.name1.
   ELSE n_insur = n_insur + uwm100.fname + " " + uwm100.name1.

   IF uwm100.poltyp   = "M60" OR  uwm100.poltyp = "M61" OR
      uwm100.poltyp   = "M62" OR  uwm100.poltyp = "M63" OR
      uwm100.poltyp   = "M64" OR  uwm100.poltyp = "M67" THEN DO:

      FOR EACH uwm307 USE-INDEX uwm30701     WHERE 
               uwm307.policy = uwm100.policy AND 
               uwm307.rencnt = uwm100.rencnt AND 
               uwm307.endcnt = uwm100.endcnt NO-LOCK.
               nv_sum  = nv_sum  + uwm307.mbsi[1].
      END.
   END .
   ELSE DO:
        FOR EACH uwm120 USE-INDEX uwm12001     WHERE 
                 uwm120.policy = uwm100.policy AND 
                 uwm120.rencnt = uwm100.rencnt AND 
                 uwm120.endcnt = uwm100.endcnt NO-LOCK.
            IF AVAIL uwm120 THEN  DO:
               nv_sum  = nv_sum + (uwm120.sigr - uwm120.sico).
            END.
        END.
   END.

  FIND FIRST uwm120 USE-INDEX uwm12002 WHERE uwm120.policy = uwm100.policy AND 
                                             uwm120.rencnt = uwm100.rencnt AND 
                                             uwm120.endcnt = uwm100.endcnt
                                             NO-LOCK NO-ERROR.
  IF AVAIL uwm120 THEN DO:
     IF SUBSTRING(uwm120.policy,3,2) = "90" THEN nvexch = 1.
     ELSE  nvexch = uwm120.siexch.
     nv_com1p = uwm120.com1p.
  END.

  n_an =  nv_sum * nvexch.

   FIND XMM600 WHERE XMM600.ACNO = UWM100.AGENT NO-LOCK NO-ERROR.
        IF NOT AVAILABLE XMM600 THEN DO:
           N_AGENT = " NOT FOUND PRODUCER CODE " + UWM100.AGENT.
        END.
        ELSE DO.
           N_AGENT = XMM600.ACNO + " " + XMM600.NAME.
        END.
     FIND XMM600 WHERE XMM600.ACNO = UWM100.INSREF NO-LOCK NO-ERROR.
     IF NOT AVAILABLE XMM600 THEN DO:
        ASSIGN  N_ADD2 = " NOT FOUND PRODUCER CODE " + UWM100.INSREF
                N_ADD3 = "  ".
        END.
     ELSE DO.
        ASSIGN  N_ADD2 =  XMM600.ADDR2
                N_ADD3 =  XMM600.ADDR3.
        END.

   ASSIGN nv_prstp  = uwm100.pstp   + uwm100.rstp
          nv_prtax  = uwm100.ptax   + uwm100.rtax
          nv_sumpts = uwm100.prem_t + nv_prstp   +   nv_prtax
          n_percen  = "%"
          nu_prm    = uwm100.prem_t + nv_prstp.

   IF  nv_prtax >= (nu_prm * 0.06) THEN DO:
       ASSIGN nu_vat = nv_prtax
              nu_sbt = 0.
   END.
   ELSE DO:
     ASSIGN nu_vat = 0
            nu_sbt = nv_prtax.
   END.
   
  OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
  EXPORT DELIMITER ";" 
      n_branch       
      uwm100.poltyp  
      uwm100.trndat  
      uwm100.policy  
      uwm100.comdat  
      uwm100.expdat  
      n_insur + " " + n_add2 + " " + n_add3 
      n_an           
      " "            /*วันที่รับเบี้ยประกัน*/
      uwm100.prem_t  
      nv_prstp       
      nu_vat         
      nu_sbt         
      nv_sumpts      
      uwm100.com1_t  
      " "            /*วันที่จ่ายค่าบำเหน็จ*/
      n_agent.
  OUTPUT CLOSE.

  ASSIGN  n_sum1 =  n_sum1 +  nv_sum
          n_sum2 =  n_sum2 +  prem_t
          n_sum3 =  n_sum3 +  nv_prtax
          n_sum4 =  n_sum4 +  nv_prstp
          n_sum5 =  n_sum5 +  nv_sumpts
          n_sum6 =  n_sum6 +  uwm100.com1_t.

  /*--รวมค่าแต่ละ Line--*/
  IF FIRST-OF(uwm100.poltyp) THEN DO:
     ASSIGN  n_suml1  =  0      n_suml2 =  0
             n_suml3  =  0      n_suml4 =  0
             n_suml5  =  0      n_suml6 =  0
             nu_vat_l =  0      nu_sbt_l = 0.
  END.
  
  ASSIGN  n_suml1  =  n_suml1  +  nv_sum
          n_suml2  =  n_suml2  +  prem_t
          n_suml3  =  n_suml3  +  nv_prtax
          n_suml4  =  n_suml4  +  nv_prstp
          n_suml5  =  n_suml5  +  nv_sumpts
          n_suml6  =  n_suml6  +  uwm100.com1_t
          nu_vat_l =  nu_vat_l +  nu_vat
          nu_sbt_l =  nu_sbt_l +  nu_sbt.

  IF LAST-OF(uwm100.poltyp) THEN DO:
     n_txt1   =   "รวม" + "  " + uwm100.poltyp.

     OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
     EXPORT DELIMITER ";"
         "" "" "" "" n_txt1 
         "" ""       n_suml1
         ""      
         n_suml4 
         nu_vat_l
         nu_sbt_l
         n_suml5 
         n_suml6.
     OUTPUT CLOSE.
  END.
  
  IF FIRST-OF(uwm100.branch) THEN DO:
     ASSIGN   n_sumb1  =  0     n_sumb2   =  0
              n_sumb3  =  0     n_sumb4   =  0
              n_sumb5  =  0     n_sumb6   =  0
              nu_vat_t =  0      nu_sbt_t =  0.
  END.
  
  ASSIGN   n_sumb1  =  n_sumb1  +  nv_sum
           n_sumb2  =  n_sumb2  +  prem_t
           n_sumb3  =  n_sumb3  +  nv_prtax
           n_sumb4  =  n_sumb4  +  nv_prstp
           n_sumb5  =  n_sumb5  +  nv_sumpts
           n_sumb6  =  n_sumb6  +  uwm100.com1_t
           nu_vat_t =  nu_vat_t +  nu_vat
           nu_sbt_t =  nu_sbt_t +  nu_sbt.

  IF LAST-OF(uwm100.branch) THEN DO:
     n_insur   =   "รวมสาขา" + " " + uwm100.branch + " " + n_bdes.
     
     OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
     EXPORT DELIMITER ";"
         "" "" "" "" n_insur 
         "" ""       n_sumb1 
         ""          n_sumb2 
         n_sumb4  
         nu_vat_t 
         nu_sbt_t 
         n_sumb5  
         n_sumb6.
     EXPORT DELIMITER ";" "".
     OUTPUT CLOSE.
     
  END.
  
END. /*FOR EACH*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProNoBroker C-Win 
PROCEDURE ProNoBroker :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN  nv_output = n_write
        n_etime = time.

RUN prnColNon.

FOR EACH uwm100 USE-INDEX uwm10008 NO-LOCK WHERE
         uwm100.trndat >= n_date_fr AND
         uwm100.trndat <= n_date_to AND
         uwm100.poltyp >= n_type    AND     
         uwm100.poltyp <= n_type2   AND     
         uwm100.agent  >= n_ag_fr   AND
         uwm100.agent  <= n_ag_to   AND
         uwm100.branch >= n_saka    AND
         uwm100.branch <= n_sakt    AND
         uwm100.endcnt <> 000       AND
         uwm100.dir_ri = nv_dir2    AND
        (SUBSTR(uwm100.policy,1,1) = "D"  OR
         SUBSTR(uwm100.policy,1,1) = "C"  OR   /* Credit Risk Line 01 */
         SUBSTR(uwm100.policy,1,1) = "I"  OR
         /*--- A500178 ---*/
         SUBSTR(uwm100.policy,1,2)   >= "10"   AND
         SUBSTR(uwm100.policy,1,2)   <= "99")  AND
         /*--- A500178 ---*/
         uwm100.releas  = YES
         BREAK BY uwm100.branch
               BY uwm100.poltyp
               BY uwm100.endno
               BY uwm100.trndat
               BY TRANTY:

   FIND FIRST xmm023 USE-INDEX xmm02301 WHERE uwm100.branch = xmm023.branch
   NO-LOCK NO-ERROR.
   ASSIGN   n_branch = uwm100.branch
            n_bdes   = xmm023.bdes
            n_dir    = uwm100.dir_ri
            n_dept   = uwm100.dept

            n_an     = 0
            nv_sum   = 0
            nv_code  = "ERR"
            nvexch   = 1.

   FIND FIRST uwm120 USE-INDEX uwm12001 WHERE uwm120.policy = uwm100.policy
                                        AND   uwm120.rencnt = uwm100.rencnt
                                        AND   uwm120.endcnt = uwm100.endcnt
                                        NO-LOCK NO-ERROR.
   IF AVAIL uwm120 THEN DO:
      ASSIGN nvcurr    = uwm120.sicurr
             nv_com1p  = uwm120.com1p.
      IF  SUBSTRING(uwm120.policy,3,2) = "90" THEN nvexch = 1.
      ELSE  nvexch = uwm120.siexch.
   END.

    /*------*/
    IF TRIM(uwm100.ntitle) = "" THEN n_insur = "".
    ELSE n_insur = TRIM(uwm100.ntitle) + " ".
    IF TRIM(uwm100.fname)  = "" THEN n_insur = n_insur + uwm100.name1.
    ELSE n_insur = n_insur + uwm100.fname + " " + uwm100.name1.

   N_ENDCNT =  uwm100.endcnt - 1.

  IF UWM100.TRANTY <> "C" THEN DO:
     RUN ProTranty.
  END.
  ELSE DO:
     RUN ProCan.
  END.          

  IF   NVCURR <> "BHT"  THEN DO:
       n_an =  ROUND(nvexch * nv_sum,2).
  END.
  ELSE DO:
       n_an =  nv_sum.
  END.

  nv_sum  =  n_an.

  FIND XMM600 WHERE XMM600.ACNO = UWM100.AGENT NO-LOCK NO-ERROR.
  IF NOT AVAILABLE XMM600 THEN DO:
     N_AGENT = " NOT FOUND PRODUCER CODE " + UWM100.AGENT.
  END.
  ELSE DO.
     N_AGENT = XMM600.ACNO + " " + XMM600.NAME.
  END.

  FIND XMM600 WHERE XMM600.ACNO = UWM100.INSREF NO-LOCK NO-ERROR.
  IF NOT AVAILABLE XMM600 THEN DO:
     N_ADD2 = " NOT FOUND PRODUCER CODE " + UWM100.INSREF.
     N_ADD3 = "  ".
  END.
  ELSE DO.
     N_ADD2 =  XMM600.ADDR2.
     N_ADD3 =  XMM600.ADDR3.
  END.

  ASSIGN  nv_prstp = uwm100.pstp + uwm100.rstp
          nv_prtax = uwm100.ptax + uwm100.rtax
          nv_sumpts = uwm100.prem_t + nv_prstp + nv_prtax
          N_PERCEN = "%"
          nu_prm = uwm100.prem_t + nv_prstp

          nu_prasee   = nv_prtax
          nu_prasee2  = (nu_prm * 0.06).

   IF  nu_prasee  < 0 THEN  nu_prasee  = nu_prasee  * -1.
   IF  nu_prasee2 < 0 THEN  nu_prasee2 = nu_prasee2 * -1.

   IF nu_prasee >= nu_prasee2 THEN DO:
      ASSIGN nu_vat = nv_prtax
             nu_sbt = 0.
   END.
   ELSE DO:
      ASSIGN nu_vat = 0
             nu_sbt = nv_prtax.
   END.
   
   /*** delete in bak2 ****/
   OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
   EXPORT DELIMITER ";" 
       n_branch       
       uwm100.poltyp  
       uwm100.trndat  
       uwm100.policy  
       uwm100.endno   
       uwm100.comdat  
       uwm100.expdat  
       n_insur + " " + n_add2 + " " + n_add3 
       n_an           
       " "             /*วันที่รับเบี้ยประกัน*/
       uwm100.prem_t  
       nv_prstp       
       nu_vat         
       nu_sbt         
       nv_sumpts      
       uwm100.com1_t  
       " "            /*วันที่จ่ายค่าบำเหน็จ*/
       n_agent.
   OUTPUT CLOSE.
   
   /*---รวมค่าแต่ละ Line----*/
   IF FIRST-OF(uwm100.poltyp)  THEN 
      ASSIGN 
         e_sum1l = 0       s_sum1l =  0         n_sum1l =  0
         e_sum2l = 0       s_sum2l =  0         n_sum2l =  0
         e_sum3l = 0       s_sum3l =  0         n_sum3l =  0
         e_sum4l = 0       s_sum4l =  0         n_sum4l =  0
         e_sum5l = 0       s_sum5l =  0         n_sum5l =  0
         e_sum6l = 0       s_sum6l =  0         n_sum6l =  0
         nu_vat_p1 = 0     nu_vat_l1 = 0        nu_vat_t1 = 0
         nu_sbt_p1 = 0     nu_sbt_l1 = 0        nu_sbt_t1 = 0 .

   IF uwm100.prem_t >  0  THEN DO:
      ASSIGN 
          e_sum1l =  e_sum1l +  nv_sum
          e_sum2l =  e_sum2l +  uwm100.prem_t
          e_sum3l =  e_sum3l +  nv_prtax
          e_sum4l =  e_sum4l +  nv_prstp
          e_sum5l =  e_sum5l +  nv_sumpts
          nu_vat_p1 = nu_vat_p1 + nu_vat
          nu_sbt_p1 = nu_sbt_p1 + nu_sbt.
   END.
   ELSE DO:
       IF uwm100.prem_t <= 0 THEN DO:
          ASSIGN 
              s_sum1l =  s_sum1l +  nv_sum
              s_sum2l =  s_sum2l +  uwm100.prem_t
              s_sum3l =  s_sum3l +  nv_prtax
              s_sum4l =  s_sum4l +  nv_prstp
              s_sum5l =  s_sum5l +  nv_sumpts
              nu_vat_l1 = nu_vat_l1 + nu_vat
              nu_sbt_l1 = nu_sbt_l1 + nu_sbt.
        END.
   END.

   IF uwm100.com1_t <  0  THEN DO:
      e_sum6l =  e_sum6l + uwm100.com1_t.
   END.
   ELSE DO.
      IF uwm100.com1_t >=  0  THEN
         s_sum6l =  s_sum6l +  uwm100.com1_t.
   END.

   ASSIGN  n_sum1l   =  n_sum1l  +  nv_sum
           n_sum2l   =  n_sum2l  +  uwm100.prem_t
           n_sum3l   =  n_sum3l  +  nv_prtax
           n_sum4l   =  n_sum4l  +  nv_prstp
           n_sum5l   =  n_sum5l  +  nv_sumpts
           n_sum6l   =  n_sum6l  +  uwm100.com1_t
           nu_vat_t1 = nu_vat_t1 +  nu_vat
           nu_sbt_t1 = nu_sbt_t1 +  nu_sbt.
 
  IF LAST-OF(uwm100.poltyp) THEN DO:
     n_txt1   =   "รวมสลักหลังเพิ่ม ".

   OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
   EXPORT DELIMITER ";"
         "" "" "" "" n_txt1 
         "" "" ""    e_sum1l 
         ""          e_sum2l 
         e_sum4l   
         nu_vat_p1 
         nu_sbt_p1 
         e_sum5l   
         e_sum6l.
   OUTPUT CLOSE.

   ASSIGN n_txt1   =   " " 
          n_txt1   =   "รวมสลักหลังลด " .

   OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
   EXPORT DELIMITER ";"
         "" "" "" "" n_txt1  
         "" "" ""    s_sum1l 
         ""          s_sum2l 
         s_sum4l   
         nu_vat_l1 
         nu_sbt_l1 
         s_sum5l   
         s_sum6l.
   OUTPUT CLOSE.
   
   ASSIGN n_txt1   =   " " 
          n_txt1   =   "รวม" + " " + uwm100.poltyp.

   OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
   EXPORT DELIMITER ";"
         "" "" "" "" n_txt1 
         "" "" ""    n_sum1l
         ""          n_sum2l
         n_sum4l   
         nu_vat_t1 
         nu_sbt_t1 
         n_sum5l   
         n_sum6l.
   EXPORT DELIMITER ";" "".
   OUTPUT CLOSE.
  END.

  /*---รวมค่าแต่ละ Branch----*/
   IF FIRST-OF(uwm100.branch)  THEN 
     ASSIGN 
       e_sum1b = 0       s_sum1b =  0         n_sum1b =  0
       e_sum2b = 0       s_sum2b =  0         n_sum2b =  0
       e_sum3b = 0       s_sum3b =  0         n_sum3b =  0
       e_sum4b = 0       s_sum4b =  0         n_sum4b =  0
       e_sum5b = 0       s_sum5b =  0         n_sum5b =  0
       e_sum6b = 0       s_sum6b =  0         n_sum6b =  0
       nu_vat_t = 0      nu_sbt_t = 0
       nu_vat_p = 0      nu_sbt_p = 0
       nu_vat_l = 0      nu_sbt_l = 0.

   IF uwm100.prem_t >  0  THEN DO:
      ASSIGN  e_sum1b =  e_sum1b +  nv_sum
              e_sum2b =  e_sum2b +  uwm100.prem_t
              e_sum3b =  e_sum3b +  nv_prtax
              e_sum4b =  e_sum4b +  nv_prstp
              e_sum5b =  e_sum5b +  nv_sumpts
              nu_vat_p = nu_vat_p + nu_vat
              nu_sbt_p = nu_sbt_p + nu_sbt.
  END.
  ELSE DO.
     IF uwm100.prem_t <= 0 THEN DO :
        ASSIGN  s_sum1b =  s_sum1b +  nv_sum
                s_sum2b =  s_sum2b +  uwm100.prem_t
                s_sum3b =  s_sum3b +  nv_prtax
                s_sum4b =  s_sum4b +  nv_prstp
                s_sum5b =  s_sum5b +  nv_sumpts
                nu_vat_l = nu_vat_l + nu_vat
                nu_sbt_l = nu_sbt_l + nu_sbt.
     END.
  END.

  IF uwm100.com1_t <  0  THEN DO:
   e_sum6b =  e_sum6b +  uwm100.com1_t.
  END.
  ELSE DO. 
   IF uwm100.com1_t >=  0  THEN 
      s_sum6b =  s_sum6b +  uwm100.com1_t.
  END.

  ASSIGN  n_sum1b =  n_sum1b +  nv_sum
          n_sum2b =  n_sum2b +  uwm100.prem_t
          n_sum3b =  n_sum3b +  nv_prtax
          n_sum4b =  n_sum4b +  nv_prstp
          n_sum5b =  n_sum5b +  nv_sumpts
          n_sum6b =  n_sum6b +  uwm100.com1_t
          nu_vat_t = nu_vat_t + nu_vat
          nu_sbt_t = nu_sbt_t + nu_sbt
          nu_sbt = 0
          nu_vat = 0.

  IF LAST-OF(uwm100.branch)  THEN DO:
     n_insur   =   "รวมสลักหลังเพิ่มสาขา " + " " + uwm100.branch + " " + n_bdes.
   
     OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
     EXPORT DELIMITER ";"
         "" "" "" ""  n_insur
         "" "" ""     e_sum1b 
         ""           e_sum2b 
         e_sum4b 
         nu_vat_p
         nu_sbt_p
         e_sum5b 
         e_sum6b.
     OUTPUT CLOSE.

   ASSIGN n_insur = " " 
          n_insur = "รวมสลักหลังลดสาขา " + " " + uwm100.branch + " " + n_bdes.
   
   OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
   EXPORT DELIMITER ";"
         "" "" "" "" n_insur 
         "" "" ""    s_sum1b 
         ""          s_sum2b 
         s_sum4b  
         nu_vat_l 
         nu_sbt_l 
         s_sum5b  
         s_sum6b.
   OUTPUT CLOSE.
   
   ASSIGN  n_insur   =   " " 
           n_insur   =   "รวมสาขา " + " " + uwm100.branch + " " + n_bdes.
   
   OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
   EXPORT DELIMITER ";"
         "" "" "" "" n_insur 
         "" "" ""    n_sum1b 
         ""          n_sum2b 
         n_sum4b  
         nu_vat_t 
         nu_sbt_t 
         n_sum5b  
         n_sum6b.
   OUTPUT CLOSE.
  END.

END. /*FOR EACH*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProTranty C-Win 
PROCEDURE ProTranty :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF uwm100.poltyp  =  "M60"  OR uwm100.poltyp = "M61" OR uwm100.poltyp = "M62" OR
   uwm100.poltyp  =  "M63"  OR uwm100.poltyp = "M64" OR uwm100.poltyp = "M67" OR 
   uwm100.poltyp  =  "M68"  THEN DO:
   IF uwm100.endcnt > 000 THEN  DO:
      FOR EACH uwm307 USE-INDEX uwm30701 WHERE 
                                uwm307.policy = uwm100.policy AND 
                                uwm307.rencnt = uwm100.rencnt AND 
                                uwm307.endcnt = uwm100.endcnt NO-LOCK.
     nv_mbsi = 0.
     FIND Buwm307 use-index uwm30701 WHERE
                            Buwm307.policy = uwm307.policy AND 
                            Buwm307.rencnt = uwm307.rencnt AND 
                            Buwm307.riskgp = uwm307.riskgp AND 
                            Buwm307.riskno = uwm307.riskno AND 
                            Buwm307.itemno = uwm307.itemno AND 
                            Buwm307.endcnt = uwm307.endcnt NO-LOCK NO-ERROR.

     IF AVAIL Buwm307 THEN  DO:
        nv_mbsi  =  uwm307.mbsi[1].
        FIND  PREV Buwm307  use-index uwm30701 WHERE
                            Buwm307.policy = uwm307.policy AND 
                            Buwm307.rencnt = uwm307.rencnt NO-LOCK NO-ERROR.

        IF AVAIL Buwm307 THEN  DO:
           IF Buwm307.riskgp = uwm307.riskgp  AND 
              Buwm307.riskno = uwm307.riskno  AND 
              Buwm307.itemno = uwm307.itemno  THEN DO:
              nv_sum  = nv_sum  + (nv_mbsi - Buwm307.mbsi[1]).
          END.
        END.
        ELSE DO:
             nv_sum  = nv_sum  + nv_mbsi.
        END.
     END.

    END.
  END.
  ELSE DO: 
    FOR EACH uwm307 USE-INDEX uwm30701 WHERE 
                              uwm307.policy = uwm100.policy AND 
                              uwm307.rencnt = uwm100.rencnt AND 
                              uwm307.endcnt = uwm100.endcnt NO-LOCK.
        nv_sum  = nv_sum  + uwm307.mbsi[1].
    END.
  END.

END.
ELSE DO:
  FOR EACH uwm120 USE-INDEX uwm12002 WHERE 
                            uwm120.policy = uwm100.policy AND
                            uwm120.rencnt = uwm100.rencnt AND
                            uwm120.endcnt = uwm100.endcnt NO-LOCK.

     FIND  Buwm120  WHERE Buwm120.policy = uwm100.policy AND 
                          Buwm120.rencnt = uwm100.rencnt AND  
                          Buwm120.riskgp = uwm120.riskgp AND 
                          Buwm120.riskno = uwm120.riskno AND 
                          Buwm120.endcnt = n_endcnt NO-LOCK NO-ERROR.

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

