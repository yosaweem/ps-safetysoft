&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*------------------------------------------------------------------------
File: 
Description: 
Input Parameters:
<none>
Output Parameters:
<none>
Author: 
Created: 
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

/************************************************************************/
DEF NEW SHARED VAR n_frbr   LIKE  uwm100.branch INIT "0".
DEF NEW SHARED VAR n_tobr   LIKE  uwm100.branch INIT "Z".
DEF NEW SHARED VAR n_frdate AS DATE FORMAT "99/99/9999". 
DEF NEW SHARED VAR n_todate AS DATE FORMAT "99/99/9999". 
DEF VAR n_write1 AS CHAR FORMAT "X(20)" LABEL "Output to file ".
DEF VAR n_write2 AS CHAR FORMAT "X(20)" LABEL "Output to file ".
DEF VAR n_write  AS CHAR FORMAT "X(12)".
DEF NEW SHARED VAR nv_write   AS CHAR FORMAT "X(20)".                                                                      
DEF NEW SHARED VAR nv_errfile AS CHAR FORMAT "X(20)".
DEF NEW SHARED VAR n_type     AS CHAR FORMAT "X" INIT "9".
DEF NEW SHARED VAR n_reptyp   AS INT  FORMAT "9" INITIAL 1.
DEF NEW SHARED VAR n_report   AS CHAR FORMAT "X" INIT "1".
DEF NEW SHARED VAR n_prvpol   LIKE    uwm100.prvpol.
DEF NEW SHARED VAR nv_row     AS INT  FORMAT ">>>>9". /*INIT 1.*/
DEF VAR frm_trndat AS DATE FORMAT "99/99/9999" LABEL " From Trans.date  :  ".
DEF VAR to_trndat  AS DATE FORMAT "99/99/9999" LABEL " To                             :  ".
DEF VAR frm_bran   LIKE uwm100.branch LABEL " From Branch        :  ".
DEF VAR to_bran    LIKE uwm100.branch LABEL "To                            :  ".
DEF VAR frm_poltyp AS CHAR FORMAT "X(2)".
DEF VAR to_poltyp  AS CHAR FORMAT "X(2)".
DEF NEW SHARED VAR n_bran   LIKE acm001.branch .
DEF NEW SHARED VAR n_poltyp AS CHAR FORMAT "X(2)".
DEF VAR nv_output  AS CHAR FORMAT "x(20)" LABEL "Output to :  ".
DEF VAR nv_output2 AS CHAR FORMAT "x(20)" LABEL "Output to :  ".
DEF VAR nv_seq AS INT.
DEF VAR nv_comp  LIKE uwd132.prem_c FORMAT "->>,>>>,>>>,>>9.99" LABEL "Prem Comp".
DEF VAR nv_pa    LIKE uwd132.prem_c FORMAT "->>,>>>,>>>,>>9.99" LABEL "Prem PA". 
DEF VAR nv_vol   LIKE uwd132.prem_c FORMAT "->>,>>>,>>>,>>9.99" LABEL "Prem motor". 
DEF VAR tot_comp LIKE uwd132.prem_c FORMAT "->>,>>>,>>>,>>9.99" LABEL "Tot Prem Comp".
DEF VAR tot_pa   LIKE uwd132.prem_c FORMAT "->>,>>>,>>>,>>9.99" LABEL "Tot Prem PA". 
DEF VAR tot_vol  LIKE uwd132.prem_c FORMAT "->>,>>>,>>>,>>9.99" LABEL "Tot Prem motor".
DEF VAR tot_prem LIKE uwd132.prem_c FORMAT "->>,>>>,>>>,>>9.99" LABEL "Tot Prem".  
DEF VAR com_comp LIKE uwm100.prem_t FORMAT "->>,>>>,>>>,>>9.99" LABEL "Com Comp".
DEF VAR com_pa   LIKE uwm100.prem_t FORMAT "->>,>>>,>>>,>>9.99" LABEL "Com PA". 
DEF VAR com_vol  LIKE uwm100.prem_t FORMAT "->>,>>>,>>>,>>9.99" LABEL "Com motor". 
DEF VAR com_volco  LIKE uwm100.prem_t FORMAT "->>,>>>,>>>,>>9.99" LABEL "Com-CO motor".  /*A64-0361*/
DEF VAR tot_com_volco  LIKE uwd132.prem_c FORMAT "->>,>>>,>>>,>>9.99" LABEL  "Tot Com-CO motor ". /*A64-0361*/
DEF VAR tot_com_comp LIKE uwd132.prem_c FORMAT "->>,>>>,>>>,>>9.99" LABEL "Tot Comm Comp  ".
DEF VAR tot_com_pa   LIKE uwd132.prem_c FORMAT "->>,>>>,>>>,>>9.99" LABEL "Tot Comm PA    ". 
DEF VAR tot_com_vol  LIKE uwd132.prem_c FORMAT "->>,>>>,>>>,>>9.99" LABEL  "Tot Comm motor ".
DEF VAR tot_com      LIKE uwd132.prem_c FORMAT "->>,>>>,>>>,>>9.99" LABEL "Tot Comm".
DEF VAR tot_stp      LIKE uwm100.rstp_t FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR tot_fee      LIKE uwm100.rfee_t FORMAT "->>,>>>,>>>,>>9.99".                      
DEF VAR tot_pa_stp   LIKE uwm100.rstp_t FORMAT "->>,>>>,>>>,>>9.99" LABEL "PA stamp   ".
DEF VAR tot_comp_stp LIKE uwm100.rstp_t FORMAT "->>,>>>,>>>,>>9.99" LABEL "Comp Stamp ".
DEF VAR tot_vol_stp  LIKE uwm100.rstp_t FORMAT "->>,>>>,>>>,>>9.99" LABEL "Vol  stamp ". 
DEF VAR tot_vat_comp LIKE uwd132.prem_c FORMAT "->>,>>>,>>>,>>9.99" LABEL "Tot Vat Comp  ".
DEF VAR tot_vat_pa   LIKE uwd132.prem_c FORMAT "->>,>>>,>>>,>>9.99" LABEL "Tot Vat PA    ". 
DEF VAR tot_vat_vol  LIKE uwd132.prem_c FORMAT "->>,>>>,>>>,>>9.99" LABEL "Tot Vat motor ".
DEF VAR tot_vat      LIKE uwd132.prem_c FORMAT "->>,>>>,>>>,>>9.99" LABEL "Tot Vat".     
DEF VAR nv_stp       LIKE uwm100.prem_t FORMAT "->>,>>>,>>>,>>9.99" LABEL "Stamp".
DEF VAR nv_pa_stp    LIKE uwm100.prem_t FORMAT "->>,>>>,>>>,>>9.99" LABEL "Pa stamp".
DEF VAR nv_comp_stp  LIKE uwm100.prem_t FORMAT "->>,>>>,>>>,>>9.99" LABEL "Comp Stamp".
DEF VAR nv_vol_stp   LIKE uwm100.prem_t FORMAT "->>,>>>,>>>,>>9.99" LABEL "Vol Stamp".     
DEF VAR nv_vat       LIKE uwm100.prem_t FORMAT "->>,>>>,>>>,>>9.99" LABEL "Vat".
DEF VAR nv_tot_vat   LIKE uwm100.prem_t FORMAT "->>,>>>,>>>,>>9.99" LABEL "Tot Vat".
DEF VAR nv_pa_vat    LIKE uwm100.prem_t FORMAT "->>,>>>,>>>,>>9.99" LABEL "Pa Vat".
DEF VAR nv_comp_vat  LIKE uwm100.prem_t FORMAT "->>,>>>,>>>,>>9.99" LABEL "Comp Vat".
DEF VAR nv_vol_vat   LIKE uwm100.prem_t FORMAT "->>,>>>,>>>,>>9.99" LABEL "Vol Vat".
DEF VAR nv_sbt       AS DECI FORMAT "->>,>>>,>>>,>>9.99". 
DEF VAR nv_tot_sbt   AS DECI FORMAT "->>,>>>,>>>,>>9.99" LABEL "Tot SBT".
DEF VAR pol_prem     LIKE uwm100.prem_t FORMAT "->>,>>>,>>>,>>9.99" LABEL "Policy Prem".
DEF VAR com_per      AS INT.                                   
DEF VAR nv_comm      LIKE uwm100.com1_t FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_fee       LIKE uwm100.rfee_t FORMAT "->>,>>>,>>>,>>9.99".  /*A53-0020*/
DEF VAR nv_sumfee    LIKE uwm100.rfee_t FORMAT "->>,>>>,>>>,>>9.99".  /*A53-0020*/
DEF VAR nv_sumfee_co LIKE uwm100.rfee_t FORMAT "->>,>>>,>>>,>>9.99".  /*A64-0361*/
DEF VAR n_stp        LIKE uwm100.rstp_t FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_stptrunc   LIKE uwm100.rstp_t FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_stpcom     LIKE uwm100.rstp_t FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_stppa      LIKE uwm100.rstp_t FORMAT "->>,>>>,>>>,>>9.99".
DEF WORKFILE wfbyline
    FIELD wfseq      AS CHAR FORMAT "X(02)"
    FIELD wfpoltyp   AS CHAR FORMAT "X(05)"
    FIELD wfbran     AS CHAR FORMAT "X(02)"
    FIELD wfdesc     AS CHAR FORMAT "X(15)"    
    FIELD wfprem     LIKE UWD132.PREM_C FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfstp      LIKE UWD132.PREM_C FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfvat      LIKE UWD132.PREM_C FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfprvat    AS DEC FORMAT "->>>,>>>,>>>,>>9.99"   /*By Aom*/
    FIELD wfsbt      LIKE UWD132.PREM_C FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfprsbt    AS DEC FORMAT "->>>,>>>,>>>,>>9.99"   /*By Aom*/
    FIELD wftotprm   AS DEC FORMAT "->>>,>>>,>>>,>>9.99"   /*By Aom*/
    FIELD wfcomm     LIKE UWD132.PREM_C FORMAT "->>,>>>,>>9.99"
    FIELD wfcommco   LIKE UWD132.PREM_C FORMAT "->>,>>>,>>9.99" /*A64-0361*/
    FIELD wffee      LIKE UWM120.RFEE_R FORMAT "->>,>>>,>>9.99"  /*A53-0020*/
    FIELD wfsum      AS DEC FORMAT "->>>,>>>,>>>,>>9.99"
    FIELD wfsumfee   AS DEC FORMAT "->>>,>>>,>>>,>>9.99"   /*A53-0020*/
    FIELD wfsumfeeco AS DEC FORMAT "->>>,>>>,>>>,>>9.99"   /*A64-0361*/
    /*A63-0038*/     
    FIELD wfprmloc   AS DEC FORMAT "->>>,>>>,>>>,>>9.99"   
    FIELD wfprmfor   AS DEC FORMAT "->>>,>>>,>>>,>>9.99"   
    FIELD wfcommloc  AS DEC FORMAT "->>>,>>>,>>>,>>9.99"  
    FIELD wfcommfor  AS DEC FORMAT "->>>,>>>,>>>,>>9.99" .
    /*A63-0038*/
DEF NEW SHARED VAR sumpa LIKE UWD132.PREM_C FORMAT "->>,>>>,>>>,>>9.99".
DEF NEW SHARED VAR totsumpa LIKE UWD132.PREM_C FORMAT "->>,>>>,>>>,>>9.99".
DEF NEW SHARED VAR totsumpr LIKE UWD132.PREM_C FORMAT "->>,>>>,>>>,>>9.99".
/*------------- Sum Detail -----------------*/
DEF VAR nsd_bran     LIKE acm001.branch. /*nv_bran*/
DEF VAR nsd_vol      LIKE uwd132.prem_c FORMAT "->>,>>>,>>>,>>9.99". /*nv_vol*/
DEF VAR nsd_comp     LIKE uwd132.prem_c FORMAT "->>,>>>,>>>,>>9.99". /*nv_comp*/
DEF VAR nsd_pa       LIKE uwd132.prem_c FORMAT "->>,>>>,>>>,>>9.99". /*nv_pa*/
DEF VAR nsd_pol_prem LIKE uwm100.prem_t FORMAT "->>,>>>,>>>,>>9.99". /*pol_prem*/
DEF VAR nsd_vol_stp  LIKE uwm100.prem_t FORMAT "->>,>>>,>>>,>>9.99". /*nv_vol_stp*/
DEF VAR nsd_comp_stp LIKE uwm100.prem_t FORMAT "->>,>>>,>>>,>>9.99". /*nv_comp_stp*/
DEF VAR nsd_pa_stp   LIKE uwm100.prem_t FORMAT "->>,>>>,>>>,>>9.99". /*nv_pa_stp*/
DEF VAR nsd_stp      LIKE uwm100.prem_t FORMAT "->>,>>>,>>>,>>9.99". /*nv_stp*/
DEF VAR nsd_vol_vat  LIKE uwm100.prem_t FORMAT "->>,>>>,>>>,>>9.99". /*nv_vol_vat*/
DEF VAR nsd_comp_vat LIKE uwm100.prem_t FORMAT "->>,>>>,>>>,>>9.99". /*nv_comp_vat*/
DEF VAR nsd_pa_vat   LIKE uwm100.prem_t FORMAT "->>,>>>,>>>,>>9.99". /*nv_pa_vat*/
DEF VAR nsd_vat      LIKE uwm100.prem_t FORMAT "->>,>>>,>>>,>>9.99". /*nv_vat*/
DEF VAR nsd_tot_vat  LIKE uwm100.prem_t FORMAT "->>,>>>,>>>,>>9.99". /*nv_tot_vat*/
DEF VAR nsd_sbt      AS DECI FORMAT "->>,>>>,>>>,>>9.99".            /*nv_sbt*/
DEF VAR nsd_tot_sbt  AS DECI FORMAT "->>,>>>,>>>,>>9.99".            /*nv_tot_sbt */
DEF VAR nsd_com_vol  LIKE uwm100.prem_t FORMAT "->>,>>>,>>>,>>9.99". /*com_vol*/
DEF VAR nsd_com_comp LIKE uwm100.prem_t FORMAT "->>,>>>,>>>,>>9.99". /*com_comp*/
DEF VAR nsd_com_pa   LIKE uwm100.prem_t FORMAT "->>,>>>,>>>,>>9.99". /*com_pa*/
DEF VAR nsd_comm     LIKE uwm100.com1_t FORMAT "->>,>>>,>>>,>>9.99". /*nv_comm*/
DEF VAR nsd_fee     LIKE uwm100.rfee_t FORMAT "->>,>>>,>>>,>>9.99". /*nv_fee*/   /*A53-0020*/
DEF VAR nsd_sumfee     LIKE uwm100.rfee_t FORMAT "->>,>>>,>>>,>>9.99". /*nv_sumfee*/   /*A53-0020*/
/*----A63-0038-----*/
DEF VAR nsd_prmloc    LIKE  uwm100.prem_t FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nsd_prmfor    LIKE  uwm100.prem_t FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nsd_commloc   LIKE  uwm100.prem_t FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nsd_commfor   LIKE  uwm100.prem_t FORMAT "->>,>>>,>>>,>>9.99".
/*----A63-0038-----*/



/**--- Aom Total Total_Prem.VAT & Total_Prem.SBT , Post JV ---**/
DEF VAR n_tot_prvat  AS  DEC  FORMAT "->>>,>>>,>>>,>>9.99" LABEL "Tot Prem VAT".
DEF VAR n_tot_prsbt  AS  DEC  FORMAT "->>>,>>>,>>>,>>9.99" LABEL "Tot Prem SBT".
DEF VAR n_desbr      AS  CHAR FORMAT "X(25)".
DEF VAR np_prem   LIKE UWD132.PREM_C.                   
DEF VAR np_stp    LIKE UWD132.PREM_C.                   
DEF VAR np_vat    LIKE UWD132.PREM_C.                   
DEF VAR np_prvat  AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR np_sbt    LIKE UWD132.PREM_C.                   
DEF VAR np_prsbt  AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR np_totprm AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR np_comm   LIKE UWD132.PREM_C.                   
DEF VAR np_fee   LIKE UWm120.RFEE_R.                    /*A53-0020*/
DEF VAR np_sumfee   LIKE UWm120.RFEE_R. 
DEF VAR np_sum    AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
/*----A63-0038-----*/
DEF VAR np_prmloc    LIKE  UWD132.PREM_C FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR np_prmfor    LIKE  UWD132.PREM_C FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR np_commloc   LIKE  UWD132.PREM_C FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR np_commfor   LIKE  UWD132.PREM_C FORMAT "->>,>>>,>>>,>>9.99".
/*----A63-0038-----*/



DEF VAR ns_prem   LIKE UWD132.PREM_C.                   
DEF VAR ns_stp    LIKE UWD132.PREM_C.                   
DEF VAR ns_vat    LIKE UWD132.PREM_C.                   
DEF VAR ns_prvat  AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR ns_sbt    LIKE UWD132.PREM_C.                   
DEF VAR ns_prsbt  AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR ns_totprm AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR ns_comm   LIKE UWD132.PREM_C.                   
DEF VAR ns_fee   LIKE UWM120.RFEE_R.                  /*A53-0020*/
DEF VAR ns_sumfee   LIKE UWM120.RFEE_R. 
DEF VAR ns_sum    AS DEC FORMAT "->>>,>>>,>>>,>>9.99". 
/*----A63-0038-----*/
DEF VAR ns_prmloc    LIKE  UWD132.PREM_C FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR ns_prmfor    LIKE  UWD132.PREM_C FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR ns_commloc   LIKE  UWD132.PREM_C FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR ns_commfor   LIKE  UWD132.PREM_C FORMAT "->>,>>>,>>>,>>9.99".
/*----A63-0038-----*/

DEF VAR nb_prem   LIKE UWD132.PREM_C.                   
DEF VAR nb_stp    LIKE UWD132.PREM_C.                   
DEF VAR nb_vat    LIKE UWD132.PREM_C.                   
DEF VAR nb_prvat  AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR nb_sbt    LIKE UWD132.PREM_C.                   
DEF VAR nb_prsbt  AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR nb_totprm AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR nb_comm   LIKE UWD132.PREM_C.                   
DEF VAR nb_fee   LIKE UWM120.RFEE_R.                     /*A53-0020*/
DEF VAR nb_sumfee   LIKE UWM120.RFEE_R. 
DEF VAR nb_sum    AS DEC FORMAT "->>>,>>>,>>>,>>9.99". 
/*----A63-0038-----*/
DEF VAR nb_prmloc    LIKE  UWD132.PREM_C FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nb_prmfor    LIKE  UWD132.PREM_C FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nb_commloc   LIKE  UWD132.PREM_C FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nb_commfor   LIKE  UWD132.PREM_C FORMAT "->>,>>>,>>>,>>9.99".
/*----A63-0038-----*/

DEF NEW SHARED VAR jv_bran   AS CHAR FORMAT "x(2)".
DEF NEW SHARED VAR jv_poltyp AS CHAR FORMAT "X(2)".
DEF NEW SHARED VAR jv_desc   AS CHAR FORMAT "x(15)".
DEF NEW SHARED VAR jv_prem   LIKE UWD132.PREM_C.                   
DEF NEW SHARED VAR jvn_prem   LIKE UWD132.PREM_C.   
DEF NEW SHARED VAR jv_stp    LIKE UWD132.PREM_C.                   
DEF NEW SHARED VAR jv_vat    LIKE UWD132.PREM_C.                   
DEF NEW SHARED VAR jv_prvat  AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF NEW SHARED VAR jv_sbt    LIKE UWD132.PREM_C.                   
DEF NEW SHARED VAR jv_prsbt  AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF NEW SHARED VAR jv_totprm  AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF NEW SHARED VAR jv_comm   LIKE UWD132.PREM_C.                   
DEF NEW SHARED VAR jv_comm1  AS DEC FORMAT "->>>,>>>,>>>,>>9.99". /*Lukkana M. A55-0304 01/10/2012*/
DEF NEW SHARED VAR jv_sum    AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF NEW SHARED VAR jvt_comm  LIKE UWD132.PREM_C. 
DEF NEW SHARED VAR jvg_comm  LIKE UWD132.PREM_C. 
DEF NEW SHARED VAR jv_summ   AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF NEW SHARED VAR jv_tsumm  AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
/*A53-0020*/
DEF NEW SHARED VAR jv_fee   AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF NEW SHARED VAR jvg_fee  LIKE UWM120.RFEE_R.  
DEF NEW SHARED VAR jvt_fee  LIKE UWM120.RFEE_R.
DEF NEW SHARED VAR jv_sumfee   AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF NEW SHARED VAR jvg_sumfee  LIKE UWM120.RFEE_R.  
DEF NEW SHARED VAR jvt_sumfee  LIKE UWM120.RFEE_R.
/*A63-0038*/
DEF NEW SHARED VAR jv_prmloc   AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF NEW SHARED VAR jv_prmfor   AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF NEW SHARED VAR jv_commloc  AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF NEW SHARED VAR jv_commfor  AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
/*A63-0038*/
/*--------*/

/**By Aom-Total Branch & Grand Total of Branch, Post JV**/
DEF NEW SHARED VAR n_jv     AS LOGICAL.
DEF NEW SHARED VAR n_gldat  AS DATE.
DEF NEW SHARED VAR n_source AS CHAR FORMAT "x(2)".
DEF NEW SHARED VAR n_macc   AS CHAR FORMAT "X(16)".
DEF NEW SHARED VAR n_sacc1  AS CHAR FORMAT "X(6)".
DEF NEW SHARED VAR n_sacc2  AS CHAR FORMAT "X(6)".
DEF NEW SHARED VAR n_c#     AS CHAR FORMAT "X" INIT "5".
DEF NEW SHARED VAR n_p#     AS CHAR FORMAT "X" INIT "4".
DEF NEW SHARED VAR n_grp#   AS CHAR FORMAT "X(2)".
DEF NEW SHARED VAR n_br#    AS CHAR FORMAT "X(2)".
DEF NEW SHARED VAR n_c4     AS CHAR FORMAT "X(3)" INIT "000".
DEF NEW SHARED VAR n_pp     AS CHAR FORMAT "X(3)" INIT "000".
DEF NEW SHARED VAR n_pe     AS CHAR FORMAT "X(3)" INIT "090".
DEF VAR n_trunc  AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_sumc   AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_chkline AS LOGICAL. 
DEF VAR n_txtbr   AS CHAR  FORMAT "X(20)".
DEF VAR nv_reccnt AS INT.
DEF VAR nv_next   AS INT.
DEF VAR JV_output AS CHAR  FORMAT "X(30)".
DEF STREAM ns1.
DEF STREAM ns2.
/*-- Prn JV --*/
DEF VAR  n_txt      AS CHAR     FORMAT "X(130)".
DEF VAR  n_branchT  AS CHAR     FORMAT "X(30)".
DEF VAR  n_prdes    AS CHAR     FORMAT "X(60)".
DEF VAR  n_txt2     AS CHAR     FORMAT "X(60)".

DEF VAR  n_date     AS DATE     FORMAT "99/99/9999".
DEF VAR  n_monthT   AS CHAR     FORMAT "X(30)".
DEF VAR  n_yearT    AS INTE     FORMAT "9999".

DEF VAR  n_gltxt    AS CHAR     FORMAT "X(50)".
DEF VAR  n_prnmacc  AS CHAR     FORMAT "X(16)".

DEF VAR  NT_DR      AS DECIMAL  FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR  NT_CR      AS DECIMAL  FORMAT "->>>,>>>,>>>,>>9.99".

DEF VAR  n_safety   AS  CHAR    FORMAT "X(50)".
DEF VAR  n_prnjv    AS  CHAR    FORMAT "X(25)".

DEF VAR  n_ln1      AS  CHAR    FORMAT "X(75)".
DEF VAR  n_ln2      AS  CHAR    FORMAT "X(75)".
DEF VAR  n_ln3      AS  CHAR    FORMAT "X(75)".

DEF VAR  n_HSln1    AS  CHAR    FORMAT "X(110)".
DEF VAR  n_HSln2    AS  CHAR    FORMAT "X(110)".
DEF VAR  n_HSln3    AS  CHAR    FORMAT "X(110)".

DEF VAR n_policy LIKE acm001.policy.
DEF VAR n_rencnt   AS INT   FORMAT ">9" .                 
DEF VAR n_endcnt   AS INT   FORMAT "999".
/*DEF VAR n_endno    AS CHAR  FORMAT "X(8)". *//*Comment A53-0039*/
DEF VAR n_endno    AS CHAR  FORMAT "X(9)". /*Add A53-0039*/
DEF VAR n_trndat LIKE acm001.trndat FORMAT "99/99/9999" .
DEF VAR n_com2p  LIKE uwm120.com2p  FORMAT ">9".
DEF VAR n_prnvat   AS CHAR  FORMAT "X(1)".
DEF VAR n_comdat   AS DATE FORMAT "99/99/9999".

DEF VAR n_ri       AS LOGICAL. /*--Yes = InwTreaty, No = InwFAC.--A51-0078--*/

DEF VAR  n_name1   AS  CHAR    FORMAT "X(70)".     /*A51-0261*/

/*----A54-0244----*/
DEF     VAR nv_brdes        AS  CHARACTER FORMAT "X(200)". 
DEF     VAR nv_brdes1       AS  CHARACTER FORMAT "X(200)".

/* - Benjaporn J. A58-0358 date 21/09/2015 -*/
DEF NEW SHARED VAR n_saccc1  AS CHAR FORMAT "X(3)" INIT "000".
DEF NEW SHARED VAR n_saccc2  AS CHAR LABEL "".

DEF NEW SHARED VAR nv_macc  AS CHAR FORMAT "X(16)".   /*ADD Saowapa U. A63-0038 18/02/2020*/
DEF NEW SHARED VAR nv_macc10  AS CHAR FORMAT "X(16)".
DEF NEW SHARED VAR nv_macc20  AS CHAR FORMAT "X(16)".
/* A63-0038 */
DEF NEW SHARED VAR nv_cedco AS CHAR FORMAT "X(10)". 
DEF NEW SHARED VAR nv_prmloc   AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF NEW SHARED VAR nv_prmfor   AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF NEW SHARED VAR nv_commloc  AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF NEW SHARED VAR nv_commfor  AS DEC FORMAT "->>>,>>>,>>>,>>9.99".

DEF BUFFER buwm100 FOR uwm100. /*A64-0361 */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_clear 
     LABEL "CLEAR" 
     SIZE 12 BY 1.19
     FONT 36.

DEFINE BUTTON bu_exit 
     LABEL "EXIT" 
     SIZE 12.5 BY 1.29
     FONT 36.

DEFINE BUTTON bu_ok 
     LABEL "OK" 
     SIZE 12.5 BY 1.29
     FONT 36.

DEFINE VARIABLE fi_datfr AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1.05
     BGCOLOR 15 FGCOLOR 2 FONT 36 NO-UNDO.

DEFINE VARIABLE fi_datto AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1.05
     BGCOLOR 15 FGCOLOR 2 FONT 36 NO-UNDO.

DEFINE VARIABLE fi_frbrn AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 4.5 BY 1.05
     BGCOLOR 15 FGCOLOR 2 FONT 36 NO-UNDO.

DEFINE VARIABLE fi_gldat AS DATE FORMAT "99/99/9999":U 
      VIEW-AS TEXT 
     SIZE 15 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 36 NO-UNDO.

DEFINE VARIABLE fi_jv AS LOGICAL FORMAT "yes/no":U INITIAL NO 
     VIEW-AS FILL-IN 
     SIZE 5 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 36 NO-UNDO.

DEFINE VARIABLE fi_output AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 27 BY 1
     BGCOLOR 15 FGCOLOR 2 FONT 36 NO-UNDO.

DEFINE VARIABLE fi_outputdesc AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 56.33 BY .62
     BGCOLOR 3 FGCOLOR 137 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_reptyp AS CHARACTER FORMAT "X(1)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 4.5 BY 1.05
     BGCOLOR 15 FGCOLOR 2 FONT 36 NO-UNDO.

DEFINE VARIABLE fi_source AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5.17 BY .95
     BGCOLOR 15 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_sourcedes AS CHARACTER FORMAT "X(20)":U 
      VIEW-AS TEXT 
     SIZE 27 BY .76
     BGCOLOR 3 FGCOLOR 7 FONT 36 NO-UNDO.

DEFINE VARIABLE fi_tobrn AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 4.5 BY 1.05
     BGCOLOR 15 FGCOLOR 2 FONT 36 NO-UNDO.

DEFINE RECTANGLE RECT-17
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 73 BY 14.05
     BGCOLOR 3 FGCOLOR 15 .

DEFINE RECTANGLE RECT-18
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 56 BY 3.1.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 80.5 BY 17.91.

DEFINE FRAME fr_prem
     fi_datfr AT ROW 1.95 COL 27.5 COLON-ALIGNED NO-LABEL
     fi_datto AT ROW 3.24 COL 27.5 COLON-ALIGNED NO-LABEL
     fi_frbrn AT ROW 4.57 COL 27.5 COLON-ALIGNED NO-LABEL
     fi_tobrn AT ROW 5.86 COL 27.5 COLON-ALIGNED NO-LABEL
     fi_reptyp AT ROW 7.14 COL 27.5 COLON-ALIGNED NO-LABEL
     fi_jv AT ROW 9.05 COL 27.5 COLON-ALIGNED NO-LABEL
     fi_source AT ROW 11.91 COL 27.33 COLON-ALIGNED NO-LABEL
     fi_output AT ROW 13.14 COL 27.33 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 15.71 COL 23.67
     bu_exit AT ROW 15.71 COL 44
     bu_clear AT ROW 13.14 COL 60.5
     fi_gldat AT ROW 10.33 COL 27.5 COLON-ALIGNED NO-LABEL
     fi_sourcedes AT ROW 12.05 COL 34.5 COLON-ALIGNED NO-LABEL
     fi_outputdesc AT ROW 14.67 COL 2.67 COLON-ALIGNED NO-LABEL
     "To:" VIEW-AS TEXT
          SIZE 4 BY 1.05 AT ROW 3.24 COL 24
          BGCOLOR 3 FGCOLOR 15 FONT 36
     "Branch From:" VIEW-AS TEXT
          SIZE 15.5 BY 1.05 AT ROW 4.57 COL 13
          BGCOLOR 3 FGCOLOR 15 FONT 36
     "To:" VIEW-AS TEXT
          SIZE 4 BY 1.05 AT ROW 5.86 COL 24
          BGCOLOR 3 FGCOLOR 15 FONT 36
     "Report Type:" VIEW-AS TEXT
          SIZE 16 BY 1.05 AT ROW 7.14 COL 12.5
          BGCOLOR 3 FGCOLOR 15 FONT 36
     "1 = Details ,  2 = Summary" VIEW-AS TEXT
          SIZE 32.5 BY 1.05 AT ROW 7.14 COL 35.67
          BGCOLOR 3 FGCOLOR 7 FONT 36
     "Trans Date From:" VIEW-AS TEXT
          SIZE 20.5 BY 1.05 AT ROW 1.95 COL 8
          BGCOLOR 3 FGCOLOR 15 FONT 36
     "Output to File:" VIEW-AS TEXT
          SIZE 16.5 BY 1.05 AT ROW 13.14 COL 11.5
          BGCOLOR 3 FGCOLOR 15 FONT 36
     "POST JV:" VIEW-AS TEXT
          SIZE 12 BY 1.19 AT ROW 8.91 COL 16.5
          BGCOLOR 3 FGCOLOR 15 FONT 36
     "GL DATE:" VIEW-AS TEXT
          SIZE 12 BY 1.19 AT ROW 10.14 COL 16.17
          BGCOLOR 3 FGCOLOR 15 FONT 36
     "SOURCE:" VIEW-AS TEXT
          SIZE 12 BY 1.19 AT ROW 11.81 COL 16.33
          BGCOLOR 3 FGCOLOR 15 FONT 36
     RECT-17 AT ROW 1.48 COL 2
     RECT-18 AT ROW 8.62 COL 10
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 2.5 ROW 1.33
         SIZE 78 BY 17.14
         BGCOLOR 8 FGCOLOR 2 FONT 6
         TITLE BGCOLOR 15 FGCOLOR 1 "Premium By Line To Excel".


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
         TITLE              = "<insert window title>"
         HEIGHT             = 17.86
         WIDTH              = 80.83
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
/* REPARENT FRAME */
ASSIGN FRAME fr_prem:FRAME = FRAME DEFAULT-FRAME:HANDLE.

/* SETTINGS FOR FRAME DEFAULT-FRAME
   FRAME-NAME                                                           */
/* SETTINGS FOR FRAME fr_prem
   Custom                                                               */
/* SETTINGS FOR FILL-IN fi_gldat IN FRAME fr_prem
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_reptyp IN FRAME fr_prem
   NO-DISPLAY                                                           */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* <insert window title> */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* <insert window title> */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_prem
&Scoped-define SELF-NAME bu_clear
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_clear C-Win
ON CHOOSE OF bu_clear IN FRAME fr_prem /* CLEAR */
DO:
  CLEAR FRAME fr_prem NO-PAUSE.
  APPLY "ENTRY" TO fi_datfr.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit C-Win
ON CHOOSE OF bu_exit IN FRAME fr_prem /* EXIT */
DO:
  APPLY "CLOSE" TO THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok C-Win
ON CHOOSE OF bu_ok IN FRAME fr_prem /* OK */
DO:
/*--Lukkana 24/07/2008--*/
ASSIGN nv_output  = ""
       nv_output2 = "".

IF fi_reptyp = "2" THEN DO:
    FOR EACH wfbyline.
        DELETE wfbyline.
    END.
END.
/*--Lukkana 24/07/2008--*/

ASSIGN frm_trndat = fi_datfr
       to_trndat  = fi_datto
       frm_bran   = fi_frbrn
       to_bran    = fi_tobrn
       n_report   = fi_reptyp
       n_jv       = INPUT fi_jv
       n_gldat    = fi_gldat.

    IF fi_output <> ""  THEN DO:  
       ASSIGN nv_output = nv_write  
              n_write1  = nv_output
              n_write2  = nv_output.
    END.

   /* IF fi_reptyp = "1" THEN RUN Pro_NewDetails. /* Detail  = 1 */
    ELSE IF fi_reptyp = "2" THEN DO:            /* Summary = 2 */
      IF n_jv = YES THEN DO:
         RUN DelAZR516.
         RUN Pro_NewDetails.
         RUN PrnJV.
      END. /*End if JV*/
      ELSE  RUN Pro_summary.
    END.*/

    IF n_jv = YES THEN DO: 
       RUN DelAZR516.
       RUN pro_NewDetails.
       RUN PrnJV.
    END.
    ELSE RUN pro_NewDetails.

    IF (fi_reptyp = "1") OR (fi_reptyp = "2" AND fi_JV = NO) THEN DO:
        VIEW fi_outputdesc.
        ASSIGN fi_outputdesc = "Output Files;  XXX 1.slk , XXX.err".
        DISP fi_outputdesc WITH FRAME {&FRAME-NAME}.
    END.
    ELSE IF fi_reptyp = "2" AND fi_JV = YES THEN DO:
        VIEW fi_outputdesc.
        ASSIGN fi_outputdesc = "Output Files;  XXX 1.slk , XXX JV.slk".
        DISP fi_outputdesc WITH FRAME {&FRAME-NAME}.
    END.

    MESSAGE "Process Data Complete!!!" VIEW-AS ALERT-BOX INFORMATION
    TITLE "Premium By Line To Excel".

    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_datfr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_datfr C-Win
ON LEAVE OF fi_datfr IN FRAME fr_prem
DO:
    ASSIGN
        fi_datfr = INPUT FRAME {&FRAME-NAME} fi_datfr.

        IF fi_datto = ? THEN fi_datto = fi_datfr.
        IF fi_datfr = ? AND fi_datto = ? THEN 
            MESSAGE "Please, Key In From Date" 
            VIEW-AS ALERT-BOX INFORMATION.

        DISP fi_datfr fi_datto WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_datto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_datto C-Win
ON LEAVE OF fi_datto IN FRAME fr_prem
DO:
  ASSIGN 
     fi_datto = INPUT FRAME {&FRAME-NAME} fi_datto
     to_trndat  = fi_datto.

  IF fi_datto = ?  THEN
     MESSAGE  "Please, Key In To Date"
     VIEW-AS ALERT-BOX INFORMATION.

  IF fi_datto < fi_datfr THEN
     MESSAGE "DATE TO ต้องมากกว่าหรือเท่ากับ DATE FROM"
     VIEW-AS ALERT-BOX INFORMATION.

  DISP fi_datto WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_frbrn
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_frbrn C-Win
ON LEAVE OF fi_frbrn IN FRAME fr_prem
DO:
ASSIGN fi_frbrn = CAPS (INPUT FRAME {&FRAME-NAME} fi_frbrn).
DISP fi_frbrn WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_jv
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_jv C-Win
ON LEAVE OF fi_jv IN FRAME fr_prem
DO:  
    ASSIGN n_jv = INPUT fi_jv.
    IF n_jv = NO THEN DO:
       ASSIGN   fi_gldat = ?.
       DISABLE  fi_gldat  WITH FRAME {&FRAME-NAME}. 
       DISP     fi_gldat  fi_source fi_sourcedes WITH FRAME {&FRAME-NAME}.
    END.
    ELSE DO:
       ASSIGN  fi_gldat = to_trndat
               n_gldat  = fi_gldat.
       DISP fi_gldat WITH FRAME {&FRAME-NAME}.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_output
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_output C-Win
ON LEAVE OF fi_output IN FRAME fr_prem
DO:
   ASSIGN n_write    = ""
          nv_write   = ""
          nv_errfile = "".
   HIDE fi_outputdesc.
   ASSIGN  fi_output = INPUT fi_output.
   IF fi_output <> "" THEN DO:
      ASSIGN  n_write = CAPS(INPUT fi_output)
              nv_write   = n_write   
              nv_errfile = n_write + ".ERR". 

   END.

      DISP fi_output WITH FRAME {&FRAME-NAME}.
   

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_reptyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_reptyp C-Win
ON LEAVE OF fi_reptyp IN FRAME fr_prem
DO:
  ASSIGN fi_reptyp = INPUT fi_reptyp.
  IF fi_reptyp = "1" THEN DO:
     ASSIGN  fi_jv    = NO
             fi_gldat = ?.
     DISABLE fi_jv    WITH FRAME {&FRAME-NAME}.
     DISABLE fi_gldat WITH FRAME {&FRAME-NAME}.
     DISP    fi_jv    fi_gldat   fi_source  WITH FRAME {&FRAME-NAME}.
     APPLY "ENTRY" TO fi_source.
     RETURN NO-APPLY.
  END.
  ELSE DO:
      ENABLE fi_jv WITH FRAME {&FRAME-NAME}.
      APPLY "ENTRY" TO fi_jv.
      RETURN NO-APPLY.
  END.
  IF fi_reptyp <> "1"  AND fi_reptyp <> "2" THEN DO:
     MESSAGE "Mandatory to Report Type."
     VIEW-AS ALERT-BOX INFORMATION.
  END.   
  DISP fi_reptyp WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_source
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_source C-Win
ON ENTRY OF fi_source IN FRAME fr_prem
DO:
  VIEW fi_outputdesc.
  fi_outputdesc = "[DI: Direct]  OR  [IF: Inward]".
  DISP fi_outputdesc WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_source C-Win
ON LEAVE OF fi_source IN FRAME fr_prem
DO:
    fi_outputdesc = "".
    HIDE fi_outputdesc.
  
  ASSIGN fi_source = CAPS (INPUT fi_source).
  DISP   fi_source  WITH FRAME {&FRAME-NAME}.
  ASSIGN n_source = fi_source.

  IF n_source = "DI" THEN DO:
     fi_sourcedes = "Direct Ins.".
     DISP fi_sourcedes WITH FRAME {&FRAME-NAME}.
  END.
  ELSE IF n_source = "IF" THEN DO:
          fi_sourcedes = "Inward Fac.".
          DISP fi_sourcedes WITH FRAME {&FRAME-NAME}.
  END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_tobrn
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_tobrn C-Win
ON LEAVE OF fi_tobrn IN FRAME fr_prem
DO:
  ASSIGN  fi_tobrn = CAPS (INPUT FRAME {&FRAME-NAME} fi_tobrn).
  DISP fi_tobrn WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME DEFAULT-FRAME
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* Write by Narin   9/07/05                                             */
/* Modify Summary & Post JV By Aom 08/2005                              */
/* Modify Policy Type [line] 01,04,30 By A49-0127 Sayamol   #04/08/2006 */
/* Modify By Sayamol #A51-0078   Date 11/03/2008                          */
/*             - Add New Branch for subacc1 subacc2                       */
/* Modify By: Lukkana M. A51-0078 Date : 21/08/2008                     */
/*            -  ทำการแก้ไขไม่ให้เวลาเรียกงาน I แล้วงาน D ออกมาด้วย     */

/* Modify By: kridtiya i. A51-0261 Date : 27/01/2009                    
           - ปรับหัวเอกสารรายงานทางฝ่ายบัญชีให้กับ  NZI     */

/* Modify By : Piyachat p. A52-0040 date 12/02/2009 
               ปรับการเรียก JV auto post ของ Line 44 ให้อยู่ในกรุ๊ป 40 */
/* Modify By : Sayamol N. A52-0189  Date 27/07/2009                     */
/*         - ปรับเงื่อนไขในการหาข้อมูลที่ UWM100 จาก ACM001             */
/*        โดยหาจาก   trty11 , docno1, policy และ releas                 */
/*Modify by : Sayamol N. 14/01/2009   [A53-0020]          */            
/*          - เพิ่มคอลัมน์ RI Disc. (uwm100.rfee_t หรือ uwm120.rfee_r */ 
/* Modify By : Porntiwa P.  A53-0039  24/01/2011 
             - ปรับ Running Endorse จาก 5 จาก 5 เป็น 6 หลัก          */
/* Modiry by : Sayamol N. A54-0244 15/08/2011                         */
/*           - ปรับเงื่อนไข find first uwm100 where uwm100.policy = uwm100.policy */ 
/* Modify By : Lukkana M. A54-0367 13/12/2011 แยก line61 มาเป็นกรุ๊ปใหม่*/
/*             และเพิ่ม line69ให้เข้าไปอยู่ในกรุ๊ป 60                   */
/* Modify By : Lukkana M. A55-0304 27/09/2012 เพิ่มline15,16,18 แยกกรุ๊ปใหม่*/
/*             และเพิ่ม line 14,19,10,17 จัดกรุ๊ปใหม่*/
/* Modify By : Lukkana M. A55-0345 07/11/2012                           */
/*             แก้ไขข้อมูลในรายงาน auto post เนื่องจาก blance ไม่ตรง    */
/* Modify By : Lukkana M. A55-0362 21/11/2012                           */
/*             แก้ไขcode 20525000 เนื่องจากไม่รวมค่าr/i discount มาด้วย */
/* Modify By : Lukkana M. A55-0372 13/12/2012                           */
/*             แก้ไขline68,69เนื่องจากข้อมูลvatไปออกช่องsbt และเพิ่มcode 57021000 สำหรับงาน inward*/
/* modify By : Kridtiya i. A57-0048 date. 05/02/2014 add case: motor 72 - dspc 
  modify By  : Suthida T. A57-0099  Date  26-03-57 
                -> เพื่อแยก line 68,69 ออกจาก line 60 
                -> แก้ไขโปรแกรมปรับเงื่อนไขการคำนวณ 0RET กรณีมี Quota Share*/
/*Modify by : Saowapa U. A63-0038 12/02/2020
              - แก้ไข โปรแกรม แยก code การบันทึกบัญชีตาม  line ของกรมธรรม์ LL แทนกรุ๊ปไลน์ 
              - แก้ไข code   10400071 , 10400073   เป็นเข้าตาม Line กธ.  code  104000LL
              - Add new Branch Empire Gx,Mx */

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
/********************  T I T L E   F O R  C - W I N  ****************/
  DEF  VAR  gv_prgid   AS   CHAR  FORMAT "X(8)"   NO-UNDO.
  DEF  VAR  gv_prog    AS   CHAR  FORMAT "X(40)" NO-UNDO.
  gv_prgid = "wacprln".
  gv_prog  = "Summary Premium by Line To Excel".
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).
/*********************************************************************/ 
  RUN  WUT\WUTWICEN (c-win:handle).
  Session:data-Entry-Return = Yes.

  ASSIGN  n_frdate = TODAY
          n_todate = TODAY
          n_frbr   = "0"
          n_tobr   = "Z"
          n_report = "1"
          n_jv     = YES.

  DISP n_frdate @ fi_datfr  WITH FRAME fr_prem.
  DISP n_todate @ fi_datto  WITH FRAME fr_prem.
  DISP n_frbr   @ fi_frbrn  WITH FRAME fr_prem.
  DISP n_tobr   @ fi_tobrn  WITH FRAME fr_prem.
  DISP n_report @ fi_reptyp WITH FRAME fr_prem.
  DISP n_jv     @ fi_jv     WITH FRAME fr_prem.

  APPLY "Entry" TO fi_datfr .

  ASSIGN fi_datfr  = TODAY
         fi_datto  = TODAY
         fi_frbrn  = "0"
         fi_tobrn  = "Z"
         fi_reptyp = "1"
         fi_jv      = YES.

  IF NOT THIS-PROCEDURE:PERSISTENT THEN 
  WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ChkLineExcel C-Win 
PROCEDURE ChkLineExcel :
/*------------------------------------------------------------------------------
Purpose:   Count  record เพื่อแยกไฟล์  หากเกิน  65500  limit ของ Excel    
Parameters:  <none>
Notes: Copy Program From: wacr0604.i    
------------------------------------------------------------------------------*/
/* --- A64-0361 05/10/2022---
DEF VAR cntop AS INT.

IF nv_reccnt > 65500 THEN  DO:
    ASSIGN
      cntop     = LENGTH(nv_output) - 5  /*-- ตัดชื่อ ==> XXXX1.SLK --*/
      nv_next   = nv_next + 1
      nv_output = SUBSTR(nv_output,1,cntop) + STRING(nv_next) + ".SLK"
      nv_reccnt = 0.
    OUTPUT TO VALUE (nv_output) NO-ECHO.
    RUN DHeadTable.
    OUTPUT CLOSE.
    nv_reccnt = nv_reccnt + 1.
END.  
*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ClearValue C-Win 
PROCEDURE ClearValue :
/*------------------------------------------------------------------------------
  Purpose:  Clear ค่าตัวแปรต่างๆ   
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
   nv_comp  = 0  nv_comp_stp = 0  nv_comp_vat = 0  com_comp = 0  
   nv_vol   = 0  nv_vol_stp  = 0  nv_vol_vat  = 0  com_vol  = 0  com_volco  = 0  
   nv_pa    = 0  nv_pa_stp   = 0  nv_pa_vat   = 0  com_pa   = 0  
   pol_prem = 0  nv_stp      = 0  nv_vat      = 0  nv_comm  = 0 

   np_prem  = 0  np_stp      = 0  np_vat      = 0  np_prvat = 0   
   np_sbt   = 0  np_prsbt    = 0  np_totprm   = 0  np_comm  = 0  
   np_sum   = 0  
   ns_prem  = 0  ns_stp      = 0  ns_vat      = 0  ns_prvat = 0  
   ns_sbt   = 0  ns_prsbt    = 0  ns_totprm   = 0  ns_comm  = 0  
   ns_sum   = 0

   nb_prem  = 0  nb_stp      = 0  nb_vat      = 0  nb_prvat = 0  
   nb_sbt   = 0  nb_prsbt    = 0  nb_totprm   = 0  nb_comm  = 0  
   nb_sum   = 0  

   sumpa    = 0
   
   /*jvn_prem  = 0   /*---A63-0038--*/*/
   jv_prem  = 0  jv_stp      = 0  jv_vat      = 0  jv_prvat = 0
   jv_sbt   = 0  jv_prsbt    = 0  jv_totprm   = 0  jv_comm  = 0  
   jv_sum   = 0
   jvt_comm = 0  jvg_comm    = 0  jv_summ     = 0  jv_tsumm = 0
   jv_comm1 = 0. /*Lukkana M. A55-0304 01/10/2012*/ 

   ASSIGN nv_cedco = ""
   nv_prmloc = 0 nv_prmfor = 0
   nv_commloc = 0 nv_commfor = 0.  /*A63-0038*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE DelAZR516 C-Win 
PROCEDURE DelAZR516 :
/*------------------------------------------------------------------------------
Purpose:  Delete AZR516 ก่อน Post JV   
Parameters:  <none>
Notes:    ป้องกันยอดเบิ้ล  
------------------------------------------------------------------------------*/
FOR EACH azr516 WHERE azr516.source  = n_source AND 
                      azr516.gldat   = n_gldat  AND 
                      azr516.branch >= frm_bran AND 
                      azr516.branch <= to_bran:

         DISP azr516.gldat  azr516.branch  azr516.macc FORMAT 99/99/9999
         WITH COLOR blue/withe NO-LABEL
         TITLE "Deleting Data..." WIDTH 60 FRAME amain VIEW-AS DIALOG-BOX.

         DELETE  azr516.
END. 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE DHeadTable C-Win 
PROCEDURE DHeadTable :
/*------------------------------------------------------------------------------
  Purpose: พิมพ์ Head Table บน Excel File ==> Output File (.slk)     
  Parameters:  <none> 
  Notes:   ใช้ semicolon (;) คั่น Column   
------------------------------------------------------------------------------*/
EXPORT DELIMITER ";"
    "BRANCH "          
    "POL.LINE "        
    "POLICY "          
    "RENCNT "          
    "ENDCNT "          
    "ENDT.NO. " 
    "COM.DATE"
    "TRANS.DATE "      
    "PREMIUM "         
    "COMPULSORY "      
    "PA "              
    "TOT.PREMIUM "     
    "STAMP "           
    "STAMP COMPULSORY "
    "STAMP PA "        
    "TOT.STAMP "       
    "VAT "             
    "VAT COMPULSORY "  
    "VAT PA "          
    "TOT.VAT  "        
    "TOT.PREM VAT  "   
    "SBT "             
    "TOT.PREM SBT "    
    "COMM. "           
    "COMM. COMPULSORY "
    "COMM. PA  " 
    "TOT.COMM.  "
    "R/I Disc."
    "TOT.COMM.DISC."
    "PRNVAT "
    /*---A63-0038---*/
    "CEDCO"
    "PREM.LOCAL"
    "PREM.FOREIGN"
    "COMM.LOCAL"
    "COMM.FOREGIN"
    "COMM.Co-Broker"
    "TOT.COMM.DISC. Co-Broker".  
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE DSDetTable C-Win 
PROCEDURE DSDetTable :
/*------------------------------------------------------------------------------
  Purpose: พิมพ์ Sum Table บน Excel File ==> Output File (.slk)     
  Parameters:  <none> 
  Notes:   ใช้ semicolon (;) คั่น Column   
------------------------------------------------------------------------------*/
EXPORT DELIMITER ";"
    "BRANCH "          
    " "        
    " "          
    " "          
    " "          
    " "        
    " " 
    " "
    "PREMIUM "         
    "COMPULSORY "      
    "PA "              
    "TOT.PREMIUM "     
    "STAMP "           
    "STAMP COMPULSORY "
    "STAMP PA "        
    "TOT.STAMP "       
    "VAT "             
    "VAT COMPULSORY "  
    "VAT PA "          
    "TOT.VAT  "        
    "TOT.PREM VAT  "   
    "SBT "             
    "TOT.PREM SBT "    
    "COMM. "           
    "COMM. COMPULSORY "
    "COMM. PA  "       
    "TOT.COMM.  " 
    "R/I DISC."
    "TOT.COMM.DISC."
    " "
    " "
    /*---A63-0038---*/
    "TOT.PRM.LOC"
    "TOT.PRM.FOR"
    "TOT.COMM.LOC"
    "TOT.COMM.FOR".
    /*---A63-0038---*/
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
  VIEW FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  DISPLAY fi_datfr fi_datto fi_frbrn fi_tobrn fi_jv fi_source fi_output fi_gldat 
          fi_sourcedes fi_outputdesc 
      WITH FRAME fr_prem IN WINDOW C-Win.
  ENABLE fi_datfr fi_datto fi_frbrn fi_tobrn fi_reptyp fi_jv fi_source 
         fi_output bu_ok bu_exit bu_clear fi_sourcedes fi_outputdesc RECT-17 
         RECT-18 
      WITH FRAME fr_prem IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_prem}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdBrn C-Win 
PROCEDURE pdBrn :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* ---By Sayamol A54-0244 ---- */
ASSIGN
  nv_brdes  = ""
  nv_brdes1 = "".
FOR EACH xmm023 USE-INDEX xmm02301 WHERE
         xmm023.branch >= frm_bran   AND
         xmm023.branch <= to_bran    NO-LOCK.

   IF LENGTH(xmm023.branch)     = 2 THEN DO:
       IF SUBSTRING(xmm023.branch,1,1) = "9"  AND SUBSTRING(xmm023.branch,2,1) <> "0"  
           THEN ASSIGN nv_brdes  = nv_brdes  + "," + SUBSTRING(xmm023.branch,2,1)
                       nv_brdes  = nv_brdes  + "," + xmm023.branch 
                       nv_brdes1 = nv_brdes1 + "," + xmm023.branch .
       ELSE nv_brdes = nv_brdes + "," + xmm023.branch   .
   END.
   ELSE IF LENGTH(xmm023.branch)     = 1 THEN nv_brdes = nv_brdes + "," + xmm023.branch .
END.
/* --- end A54-0244 ---- */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdSumRep C-Win 
PROCEDURE pdSumRep :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 FOR EACH wfbyline 
    BREAK BY wfbran
          BY wfpoltyp
          BY wfdes
          BY wfseq:

    IF FIRST-OF (wfbran) OR nv_reccnt = 0 THEN DO:
       OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO.
       RUN SHeadTable. 
       OUTPUT CLOSE.
       nv_reccnt = nv_reccnt + 3.
    END.
    wfsumfee    =  wfcomm + wffee.
    wfsumfeeco  =  wfsumfee + wfcommco.
    wfsum = (wfprem + wfstp + wfvat + wfsbt + wfsumfee).

    OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO.   
    RUN ChkLineExcel.
    EXPORT DELIMITER ";"
        wfbran      wfpoltyp    wfdesc      wfprem    
        wfstp       wfvat       wfprvat     wfsbt     
        wfprsbt     wftotprm    wfcomm      wffee  wfsumfee wfsum 
        /*A63-0038*/
        wfprmloc    wfprmfor    wfcommloc   wfcommfor wfcommco wfsumfeeco .
    OUTPUT CLOSE.
    ASSIGN 
     jv_bran   = wfbran  /*-: Post JV -*/
     jv_desc   = wfdesc
     jv_prem   = wfprem
     jv_stp    = wfstp
     jv_vat    = wfvat
     jv_prvat  = wfprvat
     jv_sbt    = wfsbt
     jv_prsbt  = wfprsbt
     /*jv_comm   = wfcomm --A64-0361--*/
     jv_comm   = wfcomm + wfcommco
     jv_fee    = wffee
     jv_sumfee = wfsumfee
     jv_sum    = wfsum
     jvg_comm  = jvg_comm + jv_comm
     jvg_fee   = jvg_fee + jv_fee
     jv_poltyp = SUBSTR(wfpoltyp,1,2)   /*A51-0078*/
     /*jv_comm1  = wfcomm.  /*Fac Comm. Lukkana M. A55-0345 07/11/2012*/ Lukkana M. A55-0362 21/11/2012*/
     /*jv_comm1  = wfsumfee A64-0361*/ /*Fac Comm. Lukkana M. A55-0362 21/11/2012*/
     jv_comm1  = wfsumfee + wfcommco /*A64-0361*/
     jv_summ   = wfprem + wfstp + wfvat + wfsbt  /*Fac Premium Lukkana M. A55-0345 07/11/2012*/
     /*A63-0038*/
     jv_prmloc = wfprmloc
     jv_prmfor = wfprmfor
     jv_commloc = wfcommloc
     jv_commfor = wfcommfor.

    IF n_jv = YES THEN DO:
       
       /*A51-0078*/
       IF SUBSTR(wfpoltyp,LENGTH(wfpoltyp),1) = "T" THEN 
       ASSIGN n_ri = YES.
           ELSE n_ri = NO.
       
       RUN Pro_Fsacc.
       RUN Pro_Poltyp.
       RUN Pro_JV.
    END.
    jv_comm = 0.
    /*-: Total Branch [+],[-] -*/
    IF LENGTH(wfbran) = 1  THEN DO: /*เช็คbranch 1 หลัก Lukkana M. A55-0345 08/11/2012 เช็คbrnchเพิ่ม*/

        n_desbr = "Total Branch: " + wfbran + "[" + SUBSTR(wfdesc,6,1) + "]".
        IF wfbran = SUBSTR(n_desbr,15,1) AND wfprem > 0 THEN DO:
           ASSIGN 
            np_prem   = np_prem   + wfprem  
            np_stp    = np_stp    + wfstp   
            np_vat    = np_vat    + wfvat   
            np_prvat  = np_prvat  + wfprvat
            np_sbt    = np_sbt    + wfsbt   
            np_prsbt  = np_prsbt  + wfprsbt
            np_totprm = np_totprm + wftotprm
            np_comm   = np_comm   + wfcomm  
            np_fee   = np_fee   + wffee  
            np_sum    = np_sum    + wfsum
            np_sumfee   = np_sumfee   + wfsumfee
            /*--A63-0038--*/
            np_prmloc  = np_prmloc  + wfprmloc    
            np_prmfor  = np_prmfor  + wfprmfor    
            np_commloc = np_commloc + wfcommloc   
            np_commfor = np_commfor + wfcommfor.   

        END.
        IF wfbran = SUBSTR(n_desbr,15,1) AND wfprem < 0 THEN DO:
           ASSIGN 
            ns_prem   = ns_prem   + wfprem  
            ns_stp    = ns_stp    + wfstp   
            ns_vat    = ns_vat    + wfvat   
            ns_prvat  = ns_prvat  + wfprvat
            ns_sbt    = ns_sbt    + wfsbt   
            ns_prsbt  = ns_prsbt  + wfprsbt
            ns_totprm = ns_totprm + wftotprm
            ns_comm   = ns_comm   + wfcomm  
            ns_fee   = ns_fee   + wffee 
            ns_sumfee   = ns_sumfee   + wfsumfee 
            ns_sum    = ns_sum    + wfsum
               /*--A63-0038--*/
            ns_prmloc  = ns_prmloc  + wfprmloc    
            ns_prmfor  = ns_prmfor  + wfprmfor    
            ns_commloc = ns_commloc + wfcommloc   
            ns_commfor = ns_commfor + wfcommfor. 
        END.
        IF wfbran = substr(n_desbr,15,1) AND   /*-: GrandTotal of Branch -*/
           SUBSTR(wfdesc,6,1) = SUBSTR(n_desbr,17,1) THEN do: 
           ASSIGN 
            nb_prem   = nb_prem   + wfprem 
            nb_stp    = nb_stp    + wfstp 
            nb_vat    = nb_vat    + wfvat 
            nb_prvat  = nb_prvat  + wfprvat 
            nb_sbt    = nb_sbt    + wfsbt 
            nb_prsbt  = nb_prsbt  + wfprsbt 
            nb_totprm = nb_totprm + wftotprm
            nb_comm   = nb_comm   + wfcomm 
            nb_fee    = nb_fee   + wffee 
            nb_sumfee = nb_sumfee   + wfsumfee 
            nb_sum    = nb_sum    + wfsum
            /*--A63-0038--*/
            nb_prmloc  = nb_prmloc  + wfprmloc    
            nb_prmfor  = nb_prmfor  + wfprmfor    
            nb_commloc = nb_commloc + wfcommloc   
            nb_commfor = nb_commfor + wfcommfor. 
            IF  LAST-OF (wfbran) THEN DO: 
                RUN pro_sumBr.
            END.
        END.
    END.
    ELSE DO: /*branch 2 หลัก*/
        n_desbr = "Total Branch: " + wfbran + "[" + SUBSTR(wfdesc,6,1) + "]".
        IF wfbran = SUBSTR(n_desbr,15,2) AND wfprem > 0 THEN DO:   
           ASSIGN 
            np_prem   = np_prem   + wfprem  
            np_stp    = np_stp    + wfstp   
            np_vat    = np_vat    + wfvat   
            np_prvat  = np_prvat  + wfprvat
            np_sbt    = np_sbt    + wfsbt   
            np_prsbt  = np_prsbt  + wfprsbt
            np_totprm = np_totprm + wftotprm
            np_comm   = np_comm   + wfcomm  
            np_fee   = np_fee   + wffee  
            np_sum    = np_sum    + wfsum
            np_sumfee   = np_sumfee   + wfsumfee 
            /*--A63-0038--*/
            np_prmloc  = np_prmloc  + wfprmloc    
            np_prmfor  = np_prmfor  + wfprmfor    
            np_commloc = np_commloc + wfcommloc   
            np_commfor = np_commfor + wfcommfor . 
        END.
        IF wfbran = SUBSTR(n_desbr,15,2) AND wfprem < 0 THEN DO: 
           ASSIGN 
            ns_prem   = ns_prem   + wfprem  
            ns_stp    = ns_stp    + wfstp   
            ns_vat    = ns_vat    + wfvat   
            ns_prvat  = ns_prvat  + wfprvat
            ns_sbt    = ns_sbt    + wfsbt   
            ns_prsbt  = ns_prsbt  + wfprsbt
            ns_totprm = ns_totprm + wftotprm
            ns_comm   = ns_comm   + wfcomm  
            ns_fee   = ns_fee   + wffee 
            ns_sumfee   = ns_sumfee   + wfsumfee 
            ns_sum    = ns_sum    + wfsum
            /*--A63-0038--*/
            ns_prmloc  = ns_prmloc  + wfprmloc    
            ns_prmfor  = ns_prmfor  + wfprmfor    
            ns_commloc = ns_commloc + wfcommloc   
            ns_commfor = ns_commfor + wfcommfor . 
        END.
        IF wfbran = substr(n_desbr,15,2) AND   /*-: GrandTotal of Branch -*/ 
           SUBSTR(wfdesc,6,1) = SUBSTR(n_desbr,18,1) THEN do: 
           ASSIGN 
            nb_prem   = nb_prem   + wfprem 
            nb_stp    = nb_stp    + wfstp 
            nb_vat    = nb_vat    + wfvat 
            nb_prvat  = nb_prvat  + wfprvat 
            nb_sbt    = nb_sbt    + wfsbt 
            nb_prsbt  = nb_prsbt  + wfprsbt 
            nb_totprm = nb_totprm + wftotprm
            nb_comm   = nb_comm   + wfcomm 
            nb_fee    = nb_fee   + wffee 
            nb_sumfee = nb_sumfee   + wfsumfee 
            nb_sum    = nb_sum    + wfsum
            /*--A63-0038--*/
            nb_prmloc  = nb_prmloc  + wfprmloc    
            nb_prmfor  = nb_prmfor  + wfprmfor    
            nb_commloc = nb_commloc + wfcommloc   
            nb_commfor = nb_commfor + wfcommfor .
           
            IF  LAST-OF (wfbran) THEN DO: 
                RUN pro_sumBr.
            END.
        END.
    END.
  END.  /* FOR EACH wfbyline */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_Cedco C-Win 
PROCEDURE pd_Cedco :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF nv_cedco <> "" THEN DO:
    FIND FIRST xmm600 NO-LOCK USE-INDEX xmm60001 WHERE xmm600.acno = nv_cedco NO-ERROR.
    IF AVAIL xmm600 THEN DO:
       IF xmm600.clicod = "RD" THEN   /*---Local---*/
          ASSIGN nv_prmloc = pol_prem
                 nv_commloc = nv_comm.
       ELSE  /*---Foreign---*/
          ASSIGN nv_prmfor = pol_prem
                 nv_commfor = nv_comm.
    END.

END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_uwd132 C-Win 
PROCEDURE PD_uwd132 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN  
  nv_comp = 0  
  nv_pa   = 0.  
 loop_uwd132:
FOR EACH uwd132 NO-LOCK 
    WHERE uwd132.policy = uwm100.policy
    AND uwd132.rencnt = uwm100.rencnt
    AND uwd132.endcnt = uwm100.endcnt
    AND uwd132.prem_c <> ?.

    /*23/06/2022 FIND FIRST buwm100 USE-INDEX uwm10001         WHERE
               buwm100.policy = uwd132.policy AND   
               buwm100.rencnt = uwd132.rencnt AND
               buwm100.endcnt = uwd132.endcnt AND
               buwm100.releas = YES           NO-LOCK NO-ERROR. 
    IF AVAILABLE buwm100 THEN DO:
             IF buwm100.acno2 <> "" THEN NEXT loop_uwd132.
    END.*/

    IF uwd132.bencod = "comp" THEN DO: 
        nv_comp = nv_comp + uwd132.prem_c.
        IF uwm100.pstp <> 0 OR uwm100.rstp_t <> 0 THEN DO:
            ASSIGN n_stp       = (uwd132.prem_c * 0.4) / 100
                   n_stpcom    = TRUNC(n_stp,0)
                   n_stptrunc  = n_stp - n_stpcom.
            IF   n_stptrunc    > 0  THEN  n_stpcom = n_stpcom + 1.
            ELSE IF n_stptrunc < 0  THEN  n_stpcom = n_stpcom - 1.
            IF SUBSTR(uwm100.policy,1,1) = "I" THEN nv_comp_stp = 1.
            ELSE nv_comp_stp = nv_comp_stp + n_stpcom.
            ASSIGN n_stpcom    = 0  
                   n_stptrunc  = 0.
        END.  /*rstp_t <> 0*/
    END.    /*bencod = "comp"*/
    ELSE IF uwd132.bencod = "pa" THEN DO:
        nv_pa = nv_pa + uwd132.prem_c.
        IF UWM100.PSTP <> 0 OR UWM100.RSTP_T <> 0 THEN DO:
            ASSIGN  N_STP      = (UWD132.PREM_C * 0.4) / 100
                    N_STPPA    = TRUNCATE(n_stp,0)
                    n_stptrunc = n_stp - n_stppa.
            IF   n_stptrunc    > 0  THEN n_stppa = n_stppa + 1.
            ELSE IF n_stptrunc < 0  THEN n_stppa = n_stppa - 1.

            IF SUBSTR(uwm100.policy,1,1) = "I" THEN nv_pa_stp = 1.
            ELSE nv_pa_stp  = nv_pa_stp + n_stppa.
            ASSIGN n_stppa    = 0
                   n_stptrunc = 0.
        END.  /* RSTP_T <> 0 */
    END.  /*BENCOD = PA*/
END.  /*EACH UWD132*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PrnJV C-Win 
PROCEDURE PrnJV :
/*------------------------------------------------------------------------------
Purpose:  Print JV Report    
Parameters:  <none> ระบุ GLDate และ Source :=> n_gldat, n_source
Notes:    Output File :=>  XXXXX JV.slk   
------------------------------------------------------------------------------*/
/*add A51-0261*/
FOR EACH xtm101 NO-LOCK.
    ASSIGN n_name1 = xtm101.left70.  
END.
/*end A51-0261*/

ASSIGN
    JV_output = nv_write + "JV.SLK"
    n_ln1     = FILL("=",75)
    n_ln2     = n_ln1
    n_ln3     = n_ln1
/*     n_safety  = CHR(27) + CHR(69) + CHR(14) + "บริษัท ประกันคุ้มภัย จำกัด (มหาชน)" + */ /*A51-0261*/
    n_safety  = CHR(27) + CHR(69) + CHR(14) + n_name1 +                                    /*A51-0261*/
                CHR(27) + CHR(70) + CHR(20)
    n_prnjv   = CHR(27) + CHR(69) + CHR(14) + "ใบสำคัญทั่วไป" +
                CHR(27) + CHR(70) + CHR(20).
    n_date    = n_gldat.

OUTPUT TO VALUE (JV_output) NO-ECHO.
EXPORT DELIMITER ";" 
  "" "ใบสำคัญทั่วไป".
EXPORT DELIMITER ";" "".
OUTPUT CLOSE.

FOR EACH azr516 WHERE azr516.gldat   = n_gldat  AND
                      azr516.branch >= frm_bran AND
                      azr516.branch <= to_bran  AND
                      azr516.amount <> 0        AND
                      azr516.source  = n_source AND
                      azr516.prgrp  <= 2        NO-LOCK
                BREAK BY azr516.branch
                      BY azr516.prgrp
                      BY azr516.drcr  DESCENDING
                      BY azr516.macc:  
    IF FIRST-OF (azr516.bran) THEN DO:
       OUTPUT TO VALUE (JV_output) APPEND NO-ECHO. 
       RUN prnJVHead.
       OUTPUT CLOSE. 
    END.

    IF  FIRST-OF(azr516.prgrp)  THEN DO:
        ASSIGN  n_branchT  = ""
                n_txt      = ""
                n_prdes    = ""
                n_txt2     = "".
        FIND FIRST xmd179 WHERE xmd179.docno  = "710"  AND
                      SUBSTRING(xmd179.headno,1,1) = azr516.branch 
                      NO-LOCK NO-ERROR.
        IF AVAILABLE xmd179 THEN n_branchT  = xmd179.head.

        IF azr516.prgrp <> 4 THEN DO:
           ASSIGN   n_date   = azr516.gldat
                    n_monthT = ""
                    n_yearT  = YEAR(azr516.gldat) + 543.

           IF MONTH(azr516.gldat) = 1  THEN  n_monthT = "มกราคม".
           IF MONTH(azr516.gldat) = 2  THEN  n_monthT = "กุมภาพันธ์".
           IF MONTH(azr516.gldat) = 3  THEN  n_monthT = "มีนาคม".
           IF MONTH(azr516.gldat) = 4  THEN  n_monthT = "เมษายน".
           IF MONTH(azr516.gldat) = 5  THEN  n_monthT = "พฤษภาคม".
           IF MONTH(azr516.gldat) = 6  THEN  n_monthT = "มิถุนายน".
           IF MONTH(azr516.gldat) = 7  THEN  n_monthT = "กรกฎาคม".
           IF MONTH(azr516.gldat) = 8  THEN  n_monthT = "สิงหาคม".
           IF MONTH(azr516.gldat) = 9  THEN  n_monthT = "กันยายน".
           IF MONTH(azr516.gldat) = 10 THEN  n_monthT = "ตุลาคม".
           IF MONTH(azr516.gldat) = 11 THEN  n_monthT = "พฤศจิกายน".
           IF MONTH(azr516.gldat) = 12 THEN  n_monthT = "ธันวาคม".

           IF azr516.prgrp = 1 THEN  n_prdes = "ค่านายหน้า".
           IF azr516.prgrp = 2 THEN  n_prdes = "ค่าเบี้ยประกัน".
           IF azr516.prgrp = 3 THEN  n_prdes = "ค่าภาษีมูลค่าเพิ่มค่านายหน้า".
        END.
        ELSE ASSIGN  n_prdes = "ยกเลิกการตั้งค่าภาษีมูลค่าเพิ่มค่านายหน้า"
                     n_date  = ?.

        n_txt = "คำอธิบาย  : บันทึก" + TRIM(n_prdes) + "  " +
                TRIM(n_branchT) + "(" + AZR516.BRANCH + ")" +
                "  ประจำเดือน " + TRIM(n_monthT) + " "  +
                STRING(n_yearT).

        n_txt2 = "(GL Date  : " + STRING(azr516.gldat,"99/99/9999") +   /* fon :17/09/03 */
                 "   Source : " + azr516.source + ")".
    END. /* End FIRST-OF (prgp) */

    FIND gl.glm001  USE-INDEX glm00101 WHERE
         gl.glm001.yr    = STRING(YEAR(azr516.gldat)) AND
         gl.glm001.compy = "0"                        AND
         gl.glm001.macc  = azr516.macc                AND
         gl.glm001.sacc1 = azr516.sacc1               AND
         gl.glm001.sacc2 = azr516.sacc2               NO-LOCK NO-ERROR.
    IF AVAILABLE  gl.glm001    THEN DO:
       ASSIGN  n_gltxt    =  TRIM(gl.glm001.desc1)
               n_prnmacc  =  gl.glm001.macc.
    END.
    ELSE DO:
       FIND FIRST gl.glm001  USE-INDEX glm00101  WHERE
                  gl.glm001.yr    = STRING(YEAR(azr516.gldat)) AND
                  gl.glm001.compy = "0"                        AND
                  gl.glm001.macc  = azr516.macc                AND
                  gl.glm001.sacc1 = azr516.sacc1 NO-LOCK NO-ERROR.
       IF AVAILABLE gl.glm001 THEN DO:
          ASSIGN  n_gltxt    =  TRIM(gl.glm001.desc1)
                  n_prnmacc  =  gl.glm001.macc.
       END.
       ELSE DO:
           FIND FIRST  gl.glm001  USE-INDEX glm00101 WHERE
                gl.glm001.yr    = STRING(YEAR(azr516.gldat)) AND
                gl.glm001.compy = "0"                        AND
                gl.glm001.macc  = azr516.macc   NO-LOCK NO-ERROR.
           IF AVAILABLE gl.glm001 THEN DO:
              ASSIGN  n_gltxt   = TRIM(gl.glm001.desc1)
                      n_prnmacc = gl.glm001.macc.
           END.
           ELSE ASSIGN  n_gltxt = ""
                        n_prnmacc  = azr516.macc.
       END.
    END.

    IF  azr516.drcr  THEN DO:
        n_gltxt  = TRIM(n_gltxt).
        OUTPUT TO VALUE (JV_output) APPEND NO-ECHO. 
        EXPORT DELIMITER ";" 
          n_gltxt 
          n_prnmacc
          "'" + azr516.sacc1 FORMAT "X(3)"
          "'" + azr516.sacc2 FORMAT "X(3)"
          azr516.amount.
        OUTPUT CLOSE.
        NT_DR   = NT_DR + AZR516.AMOUNT.
    END.
    ELSE DO:
        n_gltxt  = TRIM(n_gltxt).
        OUTPUT TO VALUE (JV_output) APPEND NO-ECHO.   
        RUN ChkLineExcel.
        EXPORT DELIMITER ";" 
          n_gltxt           
          n_prnmacc  
          "'" + azr516.sacc1 FORMAT "X(3)"
          "'" + azr516.sacc2 FORMAT "X(3)"
          ""
          azr516.amount .
        OUTPUT CLOSE.
        NT_CR   = NT_CR + AZR516.AMOUNT.
    END.
    
    IF LAST-OF(azr516.prgrp) THEN DO:
        OUTPUT TO VALUE (JV_output) APPEND NO-ECHO.
        EXPORT DELIMITER ";"
          FILL("-",120).
        EXPORT DELIMITER ";"
          n_txt.
        EXPORT DELIMITER ";"
          n_txt2.
        EXPORT DELIMITER ";" "".
        OUTPUT CLOSE.
   
        IF LAST-OF(azr516.branch) THEN DO:
           OUTPUT TO VALUE (JV_output) APPEND NO-ECHO.   
           EXPORT DELIMITER ";"
             "" "" "" "  Total DR/CR  "   NT_DR   NT_CR .
           OUTPUT CLOSE.
           ASSIGN nt_dr  = 0  nt_cr  = 0.

           OUTPUT TO VALUE (JV_output) APPEND NO-ECHO.  
           EXPORT DELIMITER ";" "".
           EXPORT DELIMITER ";"
             "____________________"          
             "____________________"           
             "____________________"           
             "____________________"  .
           EXPORT DELIMITER ";"
              "     ผู้จัดเตรียม   "           
              "    ผู้ตรวจฝ่ายบัญชี "          
              "      สมุห์บัญชี"               
              "     ผู้บันทึกบัญชี " .
           EXPORT DELIMITER ";"
              n_ln3.
           EXPORT DELIMITER ";" "".
           EXPORT DELIMITER ";" "".
           OUTPUT CLOSE. 
        END. /*END if Last-of (branch)*/
    END. /*END if Last-of (prgrp)*/
END.   /* END FOR EACH */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE prnJVHead C-Win 
PROCEDURE prnJVHead :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
EXPORT DELIMITER ";"
  "" "" "" "เลขที่ __________".
EXPORT DELIMITER ";" "".
EXPORT DELIMITER ";"
  "" n_safety.
EXPORT DELIMITER ";"
  "" n_jv.
EXPORT DELIMITER ";"
  "" "   วันที่" 
  n_date FORMAT "99/99/9999".
EXPORT DELIMITER ";"
  n_ln1.                           
EXPORT DELIMITER ";"
  "ประเภทบัญชี"                      
  "  บัญชีเลขที่"  
  " SUB1"
  " SUB2"
  "       เดบิต"                    
  "       เครดิต".
EXPORT DELIMITER ";"
  n_ln2.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_NewDetailsd C-Win 
PROCEDURE Proc_NewDetailsd :
/*------------------------------------------------------------------------------
  Purpose:      Process Detail Excel File  
  Parameters:  <None>
  Notes:   Title = 3 Lines,  DHeadtable = 2 Lines **** for Direct ****
------------------------------------------------------------------------------*/
DEF VAR nv_cnt AS INTE.
ASSIGN 
    nv_reccnt = 0
    nv_next   = 1
    nv_output2 = nv_output + STRING(nv_next) + "sum.SLK"
    nv_output  = nv_output + STRING(nv_next) + "det.SLK".
IF fi_reptyp = "1" THEN DO:
    OUTPUT TO VALUE (nv_output) NO-ECHO.
    EXPORT DELIMITER ";" 
        "Premium By Line - DETAIL".
    EXPORT DELIMITER ";"
        "Branch From : " frm_bran  "    To : "  to_bran
        "" "" "" "" "" "Tranaction Type :  M    R".
    EXPORT DELIMITER ";"
        "Tranaction Date From : " frm_trndat 
        "    TO : "  to_trndat 
        "" "" "" "" "" "Report Date : " TODAY.
    OUTPUT CLOSE.
    nv_reccnt = nv_reccnt + 3.
END.
loop_acm001:
FOR EACH acm001 NO-LOCK USE-INDEX acm00191 WHERE acm001.trndat >= frm_trndat 
    AND  acm001.trndat <= to_trndat  
    AND (acm001.trnty1  = "A" OR acm001.trnty1  = "B" OR
         acm001.trnty1  = "M" OR acm001.trnty1  = "R" OR
         acm001.trnty1  = "O" OR acm001.trnty1  = "T" OR
         acm001.trnty1  = "Q" OR acm001.trnty1  = "V" )
         /*--- A51-0078, A50-0178
         AND SUBSTR(acm001.policy,2,1) >= frm_bran
         AND SUBSTR(acm001.policy,2,1) <= to_bran
         AND SUBSTR(acm001.policy,1,1) = SUBSTR(n_source,1,1)
         ----*/
    AND (SUBSTR(acm001.policy,1,1) = "D" OR
         /*---A63-0038---*/
         SUBSTR(acm001.policy,1,1) = "G" OR
         SUBSTR(acm001.policy,1,1) = "M" OR
         /*----end A63-0038---*/
         (SUBSTR(acm001.policy,1,2) >= "10" AND SUBSTRING(acm001.policy,1,2) <= "99"))
    AND acm001.branch >= frm_bran
    AND acm001.branch <= to_bran
    BREAK /*BY SUBSTR(acm001.policy,2,1) ---A50-0178---*/
       BY acm001.branch      BY SUBSTR(acm001.policy,3,2)    
       BY acm001.recno       BY acm001.policy  
       BY acm001.rencnt      BY acm001.endcnt
       BY acm001.trndat. 
    /*---A50-0178----*/
    n_ri = NO.
   
    IF n_source = "DI"  THEN DO:
        IF SUBSTRING(acm001.policy,1,2)  >= "10" AND
            SUBSTRING(acm001.policy,1,2) <= "99" THEN DO:
            /* Valid Data -- Branch 2 หลัก เป็นการ Direct ทั้งหมด */
        END.
        ELSE IF SUBSTR(acm001.policy,1,1) <> "D" 
            /*---A63-0038---*/
            AND SUBSTR(acm001.policy,1,1) <> "G"
            AND SUBSTR(acm001.policy,1,1) <> "M" THEN NEXT loop_acm001. /*---end A63-0038---*/
    END.
    ELSE IF n_source = "IF" THEN DO:
        IF SUBSTR(acm001.policy,1,1) <> "I" THEN NEXT loop_acm001.
    END.
    /* END --- A50-0178 fon---*/
    ASSIGN n_bran     = acm001.branch
        n_poltyp   = SUBSTR(acm001.policy,3,2)
        n_policy   = acm001.policy
        nv_chkline = NO.
    IF fi_reptyp = "1" THEN DO:
        /*-IF FIRST-OF (SUBSTR(acm001.policy,2,1)) OR nv_reccnt = 0 THEN DO: --A50-0178 ---*/
        IF FIRST-OF (acm001.branch) OR nv_reccnt = 0 THEN DO:
            OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
            RUN ChkLineExcel.
            EXPORT DELIMITER ";" "".
            RUN DHeadTable.
            OUTPUT CLOSE.             
            nv_reccnt = nv_reccnt + 2.
         END.
      END.
     /*---A52-0189---*/
     FIND FIRST uwm100 USE-INDEX uwm10090     WHERE
                uwm100.trty11 = acm001.trnty1 AND
                uwm100.docno1 = acm001.docno  AND
                uwm100.policy = acm001.policy AND   /*--A54-0244--*/
                uwm100.releas = YES           NO-LOCK NO-ERROR. /*---A52-189---*/
     IF NOT AVAILABLE uwm100 THEN DO:
         NEXT loop_acm001.
         /* A64-0361 Suthida s. 01/04/2022
         FIND FIRST buwm100 USE-INDEX uwm10001         WHERE
                    buwm100.policy = acm001.policy AND   
                    buwm100.rencnt = acm001.rencnt AND
                    buwm100.endcnt = acm001.endcnt AND
                    buwm100.releas = YES           NO-LOCK NO-ERROR. 
         IF AVAILABLE buwm100 THEN DO:
             IF buwm100.acno2 = "" THEN NEXT loop_acm001.
         END.
         ELSE NEXT loop_acm001.
          A64-0361 Suthida s. 01/04/2022*/
     END.

     
     DISP uwm100.policy uwm100.trty11 uwm100.trndat FORMAT 99/99/9999 
          WITH COLOR blue/withe NO-LABEL 
          TITLE "Process Data.." WIDTH 60 FRAME amain VIEW-AS DIALOG-BOX.

     IF acm001.prem <> uwm100.prem_t THEN DO:   /*Prem.AC. กับ UW ไม่เท่ากัน*/
        OUTPUT TO VALUE (nv_errfile) APPEND NO-ECHO.
        EXPORT DELIMITER ";"
          "policy ="  uwm100.policy.
        EXPORT DELIMITER ";"
          "rencnt ="  uwm100.rencnt.
        EXPORT DELIMITER ";"
          "endcnt ="  uwm100.endcnt.
        EXPORT DELIMITER ";"
          "Com date     ="  uwm100.comdat.
        EXPORT DELIMITER ";"
          "Tran date     ="  uwm100.trndat.
        EXPORT DELIMITER ";"
          "uwm100.prem_t ="  uwm100.prem_t.
        EXPORT DELIMITER ";"
          "acm001.prem   ="  acm001.prem.
        EXPORT DELIMITER ";"
          "acm001.netloc ="  acm001.netloc.
        EXPORT DELIMITER ";" "".
        EXPORT DELIMITER ";" "".
        OUTPUT CLOSE.
     END.

     ASSIGN  n_rencnt = uwm100.rencnt
            n_endcnt = uwm100.endcnt
            n_endno  = uwm100.endno
            n_trndat = uwm100.trndat
            n_comdat = uwm100.comdat.
     /*---------- Motor ---------*/
     IF (SUBSTRING(acm001.policy,3,2) = "70" OR SUBSTRING(acm001.policy,3,2) = "72" OR 
         SUBSTRING(acm001.policy,3,2) = "73" OR SUBSTRING(acm001.policy,3,2) = "74")  THEN DO:

         RUN PD_UWD132. /* A64-0361 Suthida S. 01/04/2022 */
          
         IF SUBSTR(uwm100.policy,1,1) = "I" THEN 
             ASSIGN  nv_vol_stp = 1
                     nv_stp  =  nv_vol_stp + nv_comp_stp + nv_pa_stp.
         ELSE ASSIGN nv_vol_stp = (uwm100.pstp + uwm100.rstp_t) - nv_pa_stp - nv_comp_stp
                     nv_stp     = uwm100.rstp_t + uwm100.pstp.   /* policy stamp */
         ASSIGN nv_vol       = uwm100.prem_t - nv_comp - nv_pa
             tot_pa_stp   = tot_pa_stp    + nv_pa_stp
             tot_comp_stp = tot_comp_stp  + nv_comp_stp
             tot_vol_stp  = tot_vol_stp   + nv_vol_stp.
         /* Calculate VAT */
         IF uwm100.rtax_t <> 0 THEN nv_pa_vat   = (nv_pa + nv_pa_stp)     * uwm100.gstrat / 100.
         IF uwm100.rtax_t <> 0 THEN nv_comp_vat = (nv_comp + nv_comp_stp) * uwm100.gstrat / 100.
         ASSIGN  nv_vol_vat   = uwm100.rtax_t - nv_pa_vat - nv_comp_vat
             nv_vat       = nv_vol_vat    + nv_pa_vat + nv_comp_vat
             tot_vat_pa   = tot_vat_pa    + nv_pa_vat
             tot_vat_comp = tot_vat_comp  + nv_comp_vat
             tot_vat_vol  = tot_vat_vol   + nv_vol_vat
             com_per      = 0.
         FIND FIRST uwm120 NO-LOCK WHERE 
             uwm120.policy = uwm100.policy AND
             uwm120.rencnt = uwm100.rencnt AND
             uwm120.endcnt = uwm100.endcnt AND
             uwm120.riskno = 1 NO-ERROR.
         IF AVAIL uwm120 THEN DO:
             /*IF com_per = 0 THEN com_per = uwm120.com1p. A64-0361 */
             IF com_per = 0 THEN com_per = (uwm120.com1p + uwm120.com3p). /* A64-0361 */
             IF uwm100.com1_t  <> 0 THEN 
                 ASSIGN /*com_pa  = TRUNCATE((nv_pa * uwm120.com1p / 100),0). A64-0361 */
                        com_pa  = TRUNCATE((nv_pa * (uwm120.com1p + uwm120.com3p) / 100),0). /* A64-0361 */
                        com_pa  = com_pa * (-1).
         END.
         ASSIGN 
             com_vol       = uwm100.com1_t - com_pa
             com_volco     = uwm100.com3_t /* A64-0361 */
             com_comp      = uwm100.com2_t
             tot_com_pa    = tot_com_pa    + com_pa
             tot_com_vol   = tot_com_vol   + com_vol
             tot_com_volco = tot_com_volco + com_volco /* A64-0361 */
             tot_com_comp  = tot_com_comp  + com_comp
             pol_prem      = nv_vol  + nv_comp  + nv_pa   /*PREMIUM*/
             nv_comm       = com_vol + com_comp + com_pa /*COMMISSION*/
             nv_fee        = uwm100.rfee_t      /*RI DISC.*/  /*A53-0020*/
             nv_sumfee     = nv_comm + nv_fee
             nv_sumfee_co  = nv_comm + nv_fee + com_volco /* A64-0361 */
             nv_tot_sbt    = 0
             nv_tot_vat = pol_prem + nv_vat + nv_stp   
             nv_row = nv_row + 1. /*sum ยอดรวม*/
         IF (SUBSTR(acm001.policy,5,2)  = "99" OR  SUBSTR(acm001.policy,5,2) >= "43") AND /*check Print VAT*/
             SUBSTR(acm001.policy,3,2) <> "60" AND SUBSTR(acm001.policy,3,2) <> "61"  AND
             SUBSTR(acm001.policy,3,2) <> "62" AND SUBSTR(acm001.policy,3,2) <> "63"  AND
             SUBSTR(acm001.policy,3,2) <> "64" AND SUBSTR(acm001.policy,3,2) <> "67"  /*AND 
             SUBSTR(acm001.policy,3,2) <> "68" AND SUBSTR(acm001.policy,3,2) <> "69" Lukkana M. A55-0372 13/12/2012*/  THEN DO:  /*Lukkana M. A55-0345 07/11/2012 เพิ่มline 68,69*/ 
             FIND FIRST vat100 NO-LOCK  USE-INDEX vat10002 
                 WHERE vat100.policy = acm001.policy AND
                       vat100.trnty1 = acm001.trnty1 AND
                       vat100.refno  = acm001.docno  NO-ERROR.
             IF AVAIL vat100  THEN n_prnvat  = "V".
             ELSE  n_prnvat  = " ".
         END.
         IF fi_reptyp = "2" THEN  RUN pro_motor.
     END.  /*---if poltyp = "70" (Motor)--*/
     ELSE DO: /*------ Non Motor -------*/
         ASSIGN  
             nv_comp = 0  
             nv_pa   = 0. 
         loop_uwd132:
         FOR EACH uwd132 NO-LOCK 
             WHERE uwd132.policy = uwm100.policy
             AND uwd132.rencnt = uwm100.rencnt
             AND uwd132.endcnt = uwm100.endcnt
             AND uwd132.prem_c <> ?.

             /* 23/06/2022 FIND FIRST buwm100 USE-INDEX uwm10001         WHERE
                        buwm100.policy = uwd132.policy AND   
                        buwm100.rencnt = uwd132.rencnt AND
                        buwm100.endcnt = uwd132.endcnt AND
                        buwm100.releas = YES           NO-LOCK NO-ERROR. 
             IF AVAILABLE buwm100 THEN DO:
                      IF buwm100.acno2 <> "" THEN NEXT loop_uwd132.
             END. */

             IF  uwd132.bencod = "comp" THEN DO:
                 nv_comp = nv_comp + uwd132.prem_c.
                 IF UWM100.PSTP <> 0 OR UWM100.RSTP_T <> 0 THEN DO:
                     ASSIGN  
                         N_STP      = (UWD132.PREM_C * 0.4) / 100
                         N_STPCOM   = TRUNCATE(n_stp,0)
                         n_stptrunc = n_stp - n_stpcom.
                     IF      n_stptrunc > 0 THEN n_stpcom = n_stpcom + 1.
                     ELSE IF n_stptrunc < 0 THEN n_stpcom = n_stpcom - 1.
                     IF SUBSTR(uwm100.policy,1,1) = "I" THEN nv_comp_stp = 1.
                     ELSE  nv_comp_stp  = 0.
                     ASSIGN  n_stpcom     = 0    
                             n_stptrunc   = 0.
                 END.  /*RSTP_T  <> 0*/
             END.  /*BENCOD = COMP*/
             ELSE IF uwd132.bencod = "pa" THEN DO:
                 nv_pa = nv_pa + uwd132.prem_c.
                 IF UWM100.PSTP <> 0 OR UWM100.RSTP_T <> 0 THEN DO:
                     ASSIGN  
                         N_STP       = (UWD132.PREM_C * 0.4) / 100
                         N_STPPA     = TRUNCATE(n_stp,0)
                         n_stptrunc  = n_stp - n_stppa.
                     IF    n_stptrunc    > 0 THEN n_stppa = n_stppa + 1.
                     ELSE  IF n_stptrunc < 0 THEN n_stppa = n_stppa - 1.
                     IF SUBSTR(uwm100.policy,1,1) = "I" THEN nv_pa_stp = 1.
                     ELSE nv_pa_stp   = nv_pa_stp + n_stppa.

                     ASSIGN  n_stppa     = 0   
                             n_stptrunc  = 0.
                 END.   /*RSTP_T <> 0*/
             END.   /*BENCOD = PA*/
             IF SUBSTR(uwm100.policy,1,1) = "I" THEN 
                 ASSIGN nv_vol_stp = 1
                         nv_stp     = nv_vol_stp + nv_comp_stp + nv_pa_stp.
             ELSE ASSIGN nv_vol_stp = (uwm100.pstp + uwm100.rstp_t ) - nv_pa_stp - nv_comp_stp
                         nv_stp = uwm100.rstp_t    + uwm100.pstp.  /* policy stamp */ 

             ASSIGN  
                 nv_vol = uwm100.prem_t    - nv_comp   -   nv_pa
                 tot_pa_stp = tot_pa_stp   + nv_pa_stp
                 tot_comp_stp = tot_comp_stp + nv_comp_stp
                 tot_vol_stp  = tot_vol_stp  + nv_vol_stp.
             /*Calculate VAT*/
             IF uwm100.rtax_t <> 0 THEN nv_pa_vat    = (nv_pa   + nv_pa_stp)   * uwm100.gstrat / 100.
             IF uwm100.rtax_t <> 0 THEN nv_comp_vat  = (nv_comp + nv_comp_stp) * uwm100.gstrat / 100.
             ASSIGN
                 tot_vat_pa   = tot_vat_pa   + nv_pa_vat
                 tot_vat_comp = tot_vat_comp + nv_comp_vat
                 tot_vat_vol  = tot_vat_vol  + nv_vol_vat
                 com_per = 0.
             FIND FIRST uwm120 NO-LOCK WHERE uwm120.policy = uwm100.policy
                                         AND uwm120.rencnt = uwm100.rencnt
                                         AND uwm120.endcnt = uwm100.endcnt
                                         AND uwm120.riskno = 1 NO-ERROR.
             IF  AVAIL uwm120 THEN DO:
                 /* IF com_per =  0  THEN  com_per  =  uwm120.com1p.   A64-0361 */
                 IF com_per =  0  THEN  com_per  =  (uwm120.com1p + uwm120.com3p) .  /*  A64-0361 */
                 ASSIGN /*com_pa  = TRUNCATE((nv_pa * uwm120.com1p / 100),0) A64-0361 */
                        com_pa  = TRUNCATE((nv_pa * (uwm120.com1p + uwm120.com3p) / 100),0)  /*  A64-0361 */
                        com_pa  = com_pa * (-1).
             END.
             ASSIGN 
                 com_vol        = uwm100.com1_t - com_pa
                 com_comp       = uwm100.com2_t
                 com_volco      = uwm100.com3_t /* A64-0361 */
                 tot_com_pa     = tot_com_pa    + com_pa
                 tot_com_vol    = tot_com_vol   + com_vol
                 tot_com_comp   = tot_com_comp  + com_comp
                 tot_com_volco  = tot_com_volco  +  com_volco /* A64-0361 */
                 pol_prem       = nv_vol  + nv_comp  + nv_pa    /* PREMIUM  */
                 nv_comm        = com_vol + com_comp + com_pa  /* COMMISSION */
                 nv_fee         = uwm100.rfee_t    /*RI DISC.  */    /*A53-0020*/
                 nv_sumfee      = nv_comm + nv_fee
                 nv_sumfee_co   = nv_comm + nv_fee + com_volco. /* A64-0361 */
             IF SUBSTR(acm001.policy,3,2) <> "60" AND SUBSTR(acm001.policy,3,2) <> "61" AND
                 SUBSTR(acm001.policy,3,2) <> "62" AND SUBSTR(acm001.policy,3,2) <> "63" AND
                 SUBSTR(acm001.policy,3,2) <> "64" AND SUBSTR(acm001.policy,3,2) <> "67" /*AND 
                 SUBSTR(acm001.policy,3,2) <> "68" AND SUBSTR(acm001.policy,3,2) <> "69" Lukkana M. A55-0372 13/12/2012*/ THEN   /*Lukkana M. A55-0345 08/11/2012 เพิ่มline 68,69*/ 
                 ASSIGN nv_vol_vat = uwm100.rtax_t - nv_pa_vat - nv_comp_vat
                        nv_vat     = nv_vol_vat    + nv_pa_vat + nv_comp_vat
                        nv_tot_vat = pol_prem      + nv_vat    + nv_stp
                        nv_sbt     = 0
                        nv_tot_sbt = 0.
             ELSE ASSIGN nv_vol_vat = 0
                         nv_vat     = 0
                         nv_tot_vat = 0
                         nv_sbt     = acm001.tax
                         nv_tot_sbt = pol_prem + nv_sbt + nv_stp.
         END.  /*Each uwd132*/
         
         /*---A51-0078---*/
         IF SUBSTR(acm001.policy,1,2) = "IY" AND acm001.acno = "0APTHAI" THEN 
             ASSIGN n_ri = YES
             /* n_poltyp = n_poltyp + "T".*/
                    n_poltyp = SUBSTR(acm001.policy,3,2) + "T".
         ELSE n_ri = NO.
         
         IF fi_reptyp = "2" THEN RUN pro_Nonmotor.
         /*-----------*/
     END. /*--- End Non Motor ---*/ 

     /*--A63-0038--*/
    ASSIGN nv_cedco = ""
            nv_cedco = uwm100.cedco.  
    RUN pd_cedco.

     /*-- PUT Data TO Excel --*/
     IF fi_reptyp = "1" THEN DO:
         OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.   
         RUN ChkLineExcel.
         EXPORT DELIMITER ";"
             n_bran      n_poltyp     n_policy      n_Rencnt    n_Endcnt   
             n_endno     n_comdat     n_Trndat      
             nv_vol      nv_comp      nv_pa         pol_prem      
             nv_vol_stp  nv_comp_stp  nv_pa_stp     nv_stp     
             nv_vol_vat  nv_comp_vat  nv_pa_vat     nv_vat      nv_tot_vat 
             nv_sbt      nv_tot_sbt   com_vol       com_comp    com_pa     
             nv_comm     nv_fee       nv_sumfee     n_prnvat
             nv_cedco    nv_prmloc    nv_prmfor     nv_commloc nv_commfor   
             com_volco   nv_sumfee_co.   /*---A63-0038--*/ 
         OUTPUT CLOSE.
         nv_reccnt = nv_reccnt + 1.
     END.
     ASSIGN 
         nsd_vol      = nsd_vol      + nv_vol
         nsd_comp     = nsd_comp     + nv_comp
         nsd_pa       = nsd_pa       + nv_pa
         nsd_pol_prem = nsd_pol_prem + pol_prem
         nsd_vol_stp  = nsd_vol_stp  + nv_vol_stp
         nsd_comp_stp = nsd_comp_stp + nv_comp_stp
         nsd_pa_stp   = nsd_pa_stp   + nv_pa_stp
         nsd_stp      = nsd_stp      + nv_stp
         nsd_vol_vat  = nsd_vol_vat  + nv_vol_vat       
         nsd_comp_vat = nsd_comp_vat + nv_comp_vat
         nsd_pa_vat   = nsd_pa_vat   + nv_pa_vat  
         nsd_vat      = nsd_vat      + nv_vat    
         nsd_tot_vat  = nsd_tot_vat  + nv_tot_vat
         nsd_sbt      = nsd_sbt      + nv_sbt      
         nsd_tot_sbt  = nsd_tot_sbt  + nv_tot_sbt
         nsd_com_vol  = nsd_com_vol  + com_vol 
         nsd_com_comp = nsd_com_comp + com_comp
         nsd_com_pa   = nsd_com_pa   + com_pa
         nsd_comm     = nsd_comm     + nv_comm 
         nsd_fee      = nsd_fee      + nv_fee
         nsd_sumfee   = nsd_sumfee   + nv_sumfee
          /*---A63-0038---*/
         nsd_prmloc   = nsd_prmloc   +  nv_prmloc 
         nsd_prmfor   = nsd_prmfor   +  nv_prmfor 
         nsd_commloc  = nsd_commloc  +  nv_commloc
         nsd_commfor  = nsd_commfor  +  nv_commfor.
          /*---A63-0038---*/
     ASSIGN 
         nv_vol     = 0   nv_comp     = 0  nv_pa     = 0  pol_prem = 0     
         nv_vol_stp = 0   nv_comp_stp = 0  nv_pa_stp = 0  nv_stp   = 0      
         nv_vol_vat = 0   nv_comp_vat = 0  nv_pa_vat = 0  nv_vat   = 0   nv_tot_vat  = 0      
         nv_sbt     = 0   nv_tot_sbt  = 0            
         com_vol    = 0   com_comp    = 0  com_pa    = 0  com_volco    = 0      
         nv_comm    = 0   nv_fee      = 0  nv_sumfee = 0  nv_sumfee_co = 0 
         nv_cedco   = ""  nv_prmloc   = 0  nv_prmfor = 0  nv_commloc = 0 nv_commfor = 0.  /*A63-0038*/
     /*IF LAST-OF (SUBSTR(acm001.policy,2,1)) AND fi_reptyp = "1" THEN  RUN sumDetail. -A50-0178-*/
     IF LAST-OF (acm001.branch) AND fi_reptyp = "1" THEN RUN sumDetail. /*--By Aom Sum Detail --*/
END.  /*each acm001*/  
  
IF fi_reptyp = "2" THEN DO:
    /*  FOR EACH wfbyline 
    A51-0078 Lukkana M. 25/08/2008*/
    RUN Proc_ProTot. /*A51-0078 Lukkana M. 25/08/2008*/
END.  /* Report = Summary */
 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_NewDetailsL C-Win 
PROCEDURE Proc_NewDetailsL :
ASSIGN  nv_reccnt = 0
        nv_next   = 1
        nv_output2 = nv_output + STRING(nv_next) + "sum.SLK"
        nv_output  = nv_output + STRING(nv_next) + "det.SLK".
IF fi_reptyp = "1" THEN DO:
   OUTPUT TO VALUE (nv_output) NO-ECHO.
   EXPORT DELIMITER ";" 
     "Premium By Line - DETAIL".
   EXPORT DELIMITER ";"
     "Branch From : " frm_bran  "    To : "  to_bran
     "" "" "" "" "" "Tranaction Type :  M    R".
   EXPORT DELIMITER ";"
     "Tranaction Date From : " frm_trndat 
     "    TO : "  to_trndat 
     "" "" "" "" "" "Report Date : " TODAY.
   OUTPUT CLOSE.
   nv_reccnt = nv_reccnt + 3.
END.

RUN pdBrn.  /*A54-0244*/

loop_acm001:
FOR EACH acm001 NO-LOCK USE-INDEX acm00191 WHERE  acm001.trndat >= frm_trndat 
         AND  acm001.trndat <= to_trndat  
         AND (acm001.trnty1  = "A" OR acm001.trnty1  = "B" OR
         acm001.trnty1  = "M" OR acm001.trnty1  = "R" OR
         acm001.trnty1  = "O" OR acm001.trnty1  = "T" OR
         acm001.trnty1  = "Q" OR acm001.trnty1  = "V" )
         AND SUBSTR(acm001.policy,1,1) = "I"
         /*--A54-0244---
         AND acm001.branch >= frm_bran
         AND acm001.branch <= to_bran
         ----------*/
         AND INDEX(nv_brdes, "," + acm001.branch) <> 0    /*--A54-0244--*/
         BREAK BY acm001.branch
               BY SUBSTR(acm001.policy,3,2) 
               BY acm001.recno
               BY acm001.policy   
               BY acm001.rencnt
               BY acm001.endcnt
               BY acm001.trndat. 

    n_ri = NO.

    IF n_source = "DI"  THEN DO:
        IF SUBSTRING(acm001.policy,1,2) >= "10" AND
           SUBSTRING(acm001.policy,1,2) <= "99" THEN DO:
            /* Valid Data -- Branch 2 หลัก เป็นการ Direct ทั้งหมด */
        END.
        ELSE IF SUBSTR(acm001.policy,1,1) <> "D" 
            /*---A63-0038---*/
            AND SUBSTR(acm001.policy,1,1) <> "G" 
            AND SUBSTR(acm001.policy,1,1) <> "M" 
            /*---end A63-0038---*/
            
            THEN NEXT loop_acm001.
    END.
    ELSE IF n_source = "IF" THEN DO:
        IF SUBSTR(acm001.policy,1,1) <> "I" THEN NEXT loop_acm001.
    END.
    /* END --- A50-0178 fon---*/
    ASSIGN
        n_bran     = acm001.branch
        n_poltyp   = SUBSTR(acm001.policy,3,2)
        n_policy   = acm001.policy
        nv_chkline = NO.
    IF fi_reptyp = "1" THEN DO:
        /*-IF FIRST-OF (SUBSTR(acm001.policy,2,1)) OR nv_reccnt = 0 THEN DO: --A50-0178 ---*/
        IF FIRST-OF (acm001.branch) OR nv_reccnt = 0 THEN DO:
            OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
            RUN ChkLineExcel.
            EXPORT DELIMITER ";" "".
            RUN DHeadTable.
            OUTPUT CLOSE.             
            nv_reccnt = nv_reccnt + 2.
        END.
    END.

    /* --- By A54-0244 Sayamol ----*/
    n_bran     = "".
    n_bran     = acm001.branch.
    IF SUBSTR(acm001.policy,1,1) = "I" THEN DO:
        IF nv_brdes1 = ""  THEN NEXT loop_acm001.  
        IF INDEX(nv_brdes1,",9" + SUBSTRING(acm001.policy,2,1)) <> 0 THEN 
            n_bran = "9" + SUBSTRING(acm001.policy,2,1). 
    END.
    ELSE IF SUBSTR(acm001.policy,1,1) = "D" THEN DO:    
        IF acm001.branch <  frm_bran OR acm001.branch > to_bran  THEN NEXT loop_acm001.                
    END.
    /* --- end A54-0244 ----*/
    FIND FIRST uwm100 USE-INDEX uwm10090     WHERE
                uwm100.trty11 = acm001.trnty1 AND
                uwm100.docno1 = acm001.docno  AND
                uwm100.policy = acm001.policy AND   /*--A54-0244--*/
                uwm100.releas = YES           NO-LOCK NO-ERROR. /*---A52-189---*/
     IF NOT AVAILABLE uwm100 THEN DO:
         NEXT loop_acm001.
         /* A64-0361 Suthida s. 01/04/2022
         FIND FIRST uwm100 USE-INDEX uwm10001         WHERE
                    uwm100.policy = acm001.policy AND   
                    uwm100.rencnt = acm001.rencnt AND
                    uwm100.endcnt = acm001.endcnt AND
                    uwm100.releas = YES           NO-LOCK NO-ERROR. 
         IF AVAILABLE uwm100 THEN DO:
             IF uwm100.acno2 = "" THEN NEXT loop_acm001.
         END.
         ELSE NEXT loop_acm001.
         A64-0361 Suthida s. 01/04/2022*/
     END.

    DISP uwm100.policy uwm100.trty11 uwm100.trndat FORMAT 99/99/9999 
        WITH COLOR blue/withe NO-LABEL 
        TITLE "Process Data.." WIDTH 60 FRAME amain VIEW-AS DIALOG-BOX.
    IF acm001.prem <> uwm100.prem_t THEN DO:   /*Prem.AC. กับ UW ไม่เท่ากัน*/
        OUTPUT TO VALUE (nv_errfile) APPEND NO-ECHO.
        EXPORT DELIMITER ";"
            "policy ="  uwm100.policy.
        EXPORT DELIMITER ";"
            "rencnt ="  uwm100.rencnt.
        EXPORT DELIMITER ";"
            "endcnt ="  uwm100.endcnt.
        EXPORT DELIMITER ";"
            "Com date     ="  uwm100.comdat.
        EXPORT DELIMITER ";"
            "Tran date     ="  uwm100.trndat.
        EXPORT DELIMITER ";"
            "uwm100.prem_t ="  uwm100.prem_t.
        EXPORT DELIMITER ";"
            "acm001.prem   ="  acm001.prem.
        EXPORT DELIMITER ";"
            "acm001.netloc ="  acm001.netloc.
        EXPORT DELIMITER ";" "".
        EXPORT DELIMITER ";" "".
        OUTPUT CLOSE.
    END.
    ASSIGN
        n_rencnt = uwm100.rencnt
        n_endcnt = uwm100.endcnt
        n_endno  = uwm100.endno
        n_trndat = uwm100.trndat
        n_comdat = uwm100.comdat.

    /*---------- Motor ---------*/
    IF (SUBSTRING(acm001.policy,3,2) = "70" OR SUBSTRING(acm001.policy,3,2) = "72" OR 
        SUBSTRING(acm001.policy,3,2) = "73" OR SUBSTRING(acm001.policy,3,2) = "74")  THEN DO:

        RUN PD_uwd132.
        
        IF SUBSTR(uwm100.policy,1,1) = "I" THEN DO: 
            ASSIGN  
                nv_vol_stp = 1
                nv_stp  =  nv_vol_stp + nv_comp_stp + nv_pa_stp.
        END.
        ELSE DO:
            ASSIGN
                nv_vol_stp = (uwm100.pstp + uwm100.rstp_t) - nv_pa_stp - nv_comp_stp
                nv_stp     = uwm100.rstp_t + uwm100.pstp.   /* policy stamp */
        END.

        ASSIGN 
            nv_vol       = uwm100.prem_t - nv_comp - nv_pa
            tot_pa_stp   = tot_pa_stp    + nv_pa_stp
            tot_comp_stp = tot_comp_stp  + nv_comp_stp
            tot_vol_stp  = tot_vol_stp   + nv_vol_stp.
        /* Calculate VAT */
        IF uwm100.rtax_t <> 0 THEN nv_pa_vat   = (nv_pa + nv_pa_stp)     * uwm100.gstrat / 100.
        IF uwm100.rtax_t <> 0 THEN nv_comp_vat = (nv_comp + nv_comp_stp) * uwm100.gstrat / 100.
        ASSIGN  
            nv_vol_vat   = uwm100.rtax_t - nv_pa_vat - nv_comp_vat
            nv_vat       = nv_vol_vat    + nv_pa_vat + nv_comp_vat
            tot_vat_pa   = tot_vat_pa    + nv_pa_vat
            tot_vat_comp = tot_vat_comp  + nv_comp_vat
            tot_vat_vol  = tot_vat_vol   + nv_vol_vat
            com_per      = 0.
        FIND FIRST uwm120 NO-LOCK WHERE 
            uwm120.policy = uwm100.policy AND
            uwm120.rencnt = uwm100.rencnt AND
            uwm120.endcnt = uwm100.endcnt AND
            uwm120.riskno = 1 NO-ERROR.
        IF AVAIL uwm120 THEN DO:
             /*IF com_per = 0 THEN com_per = uwm120.com1p. A64-0361 */
            IF com_per = 0 THEN com_per =  (uwm120.com1p + uwm120.com3p). /* A64-0361 */
            IF uwm100.com1_t  <> 0 THEN DO:
                ASSIGN /*com_pa  = TRUNCATE((nv_pa * uwm120.com1p / 100),0). A64-0361 */
                      com_pa  = TRUNCATE((nv_pa * (uwm120.com1p + uwm120.com3p) / 100),0). /* A64-0361 */
                      com_pa  = com_pa * (-1).
                      
            END.
        END.
        ASSIGN 
            com_vol      = uwm100.com1_t - com_pa
            com_comp     = uwm100.com2_t
            com_volco     = uwm100.com3_t /* A64-0361 */
            tot_com_pa   = tot_com_pa    + com_pa
            tot_com_vol  = tot_com_vol   + com_vol
            tot_com_comp = tot_com_comp  + com_comp
            tot_com_volco = tot_com_volco + com_volco /* A64-0361 */
            pol_prem     = nv_vol  + nv_comp  + nv_pa   /*PREMIUM*/
            nv_comm      = com_vol + com_comp + com_pa /*COMMISSION*/
            nv_tot_sbt   = 0
            nv_tot_vat   = pol_prem + nv_vat + nv_stp   
            nv_row       = nv_row + 1 /*sum ยอดรวม*/
            nv_fee       = uwm100.rfee_t
            nv_sumfee    = nv_comm + nv_fee
            nv_sumfee_co  = nv_comm + nv_fee + com_volco. /* A64-0361 */

        IF (SUBSTR(acm001.policy,5,2)  = "99" OR  SUBSTR(acm001.policy,5,2) >= "43") AND /*check Print VAT*/
            SUBSTR(acm001.policy,3,2) <> "60" AND SUBSTR(acm001.policy,3,2) <> "61"  AND
            SUBSTR(acm001.policy,3,2) <> "62" AND SUBSTR(acm001.policy,3,2) <> "63"  AND
            SUBSTR(acm001.policy,3,2) <> "64" AND SUBSTR(acm001.policy,3,2) <> "67"  /*AND 
            SUBSTR(acm001.policy,3,2) <> "68" AND SUBSTR(acm001.policy,3,2) <> "69"Lukkana M. A55-0372 13/12/2012*/  THEN DO:  /*Lukkana M. A55-0345 08/11/2012 เพิ่มline 68,69*/ 
            
            FIND FIRST vat100 NO-LOCK  USE-INDEX vat10002 
                WHERE vat100.policy = acm001.policy AND
                      vat100.trnty1 = acm001.trnty1 AND
                      vat100.refno  = acm001.docno  NO-ERROR.
            IF AVAIL vat100  THEN n_prnvat  = "V".
            ELSE  n_prnvat  = " ".
        END.

        IF fi_reptyp = "2" THEN  RUN pro_motor.

    END.  /*---if poltyp = "70" (Motor)--*/
    ELSE DO: /*------ Non Motor -------*/
        ASSIGN  
            nv_comp = 0  
            nv_pa   = 0.  
        loop_uwd132:
        FOR EACH uwd132 NO-LOCK 
            WHERE uwd132.policy = uwm100.policy
              AND uwd132.rencnt = uwm100.rencnt
              AND uwd132.endcnt = uwm100.endcnt
              AND uwd132.prem_c <> ?.

            /* 23/06/2022 FIND FIRST buwm100 USE-INDEX uwm10001         WHERE
                       buwm100.policy = uwd132.policy AND   
                       buwm100.rencnt = uwd132.rencnt AND
                       buwm100.endcnt = uwd132.endcnt AND
                       buwm100.releas = YES           NO-LOCK NO-ERROR. 
            IF AVAILABLE buwm100 THEN DO:
                     IF buwm100.acno2 <> "" THEN NEXT loop_uwd132.
            END. */

            IF  uwd132.bencod = "comp" THEN DO:
                nv_comp = nv_comp + uwd132.prem_c.
                IF UWM100.PSTP <> 0 OR UWM100.RSTP_T <> 0 THEN DO:
                    ASSIGN  
                        N_STP      = (UWD132.PREM_C * 0.4) / 100
                        N_STPCOM   = TRUNCATE(n_stp,0)
                        n_stptrunc = n_stp - n_stpcom.
                    IF      n_stptrunc > 0 THEN n_stpcom = n_stpcom + 1.
                    ELSE IF n_stptrunc < 0 THEN n_stpcom = n_stpcom - 1.
                    IF SUBSTR(uwm100.policy,1,1) = "I" THEN nv_comp_stp = 1.
                    ELSE  nv_comp_stp  = 0.

                    ASSIGN 
                        n_stpcom     = 0    
                        n_stptrunc   = 0.
                END.  /*RSTP_T  <> 0*/
            END.   /*BENCOD = COMP*/
            ELSE IF uwd132.bencod = "pa" THEN DO:
                nv_pa = nv_pa + uwd132.prem_c.
                IF UWM100.PSTP <> 0 OR UWM100.RSTP_T <> 0 THEN DO:
                    ASSIGN  
                        N_STP       = (UWD132.PREM_C * 0.4) / 100
                        N_STPPA     = TRUNCATE(n_stp,0)
                        n_stptrunc  = n_stp - n_stppa.
                    IF    n_stptrunc    > 0 THEN n_stppa = n_stppa + 1.
                    ELSE  IF n_stptrunc < 0 THEN n_stppa = n_stppa - 1.
                    IF SUBSTR(uwm100.policy,1,1) = "I" THEN nv_pa_stp = 1.
                    ELSE nv_pa_stp   = nv_pa_stp + n_stppa.

                    ASSIGN  
                        n_stppa     = 0   
                        n_stptrunc  = 0.
                END.    /*RSTP_T <> 0*/
            END.   /*BENCOD = PA*/

            IF SUBSTR(uwm100.policy,1,1) = "I" THEN DO: 
                 ASSIGN
                     nv_vol_stp = 1
                     nv_stp     = nv_vol_stp + nv_comp_stp + nv_pa_stp.
            END.
            ELSE DO: 
                ASSIGN
                    nv_vol_stp = (uwm100.pstp + uwm100.rstp_t ) - nv_pa_stp - nv_comp_stp
                    nv_stp = uwm100.rstp_t    + uwm100.pstp.  /* policy stamp */ 
            END.

            ASSIGN  
                nv_vol       = uwm100.prem_t    - nv_comp   -   nv_pa
                tot_pa_stp   = tot_pa_stp   + nv_pa_stp
                tot_comp_stp = tot_comp_stp + nv_comp_stp
                tot_vol_stp  = tot_vol_stp  + nv_vol_stp.

            /*Calculate VAT*/
            IF uwm100.rtax_t <> 0 THEN nv_pa_vat    = (nv_pa   + nv_pa_stp)   * uwm100.gstrat / 100.
            IF uwm100.rtax_t <> 0 THEN nv_comp_vat  = (nv_comp + nv_comp_stp) * uwm100.gstrat / 100.
            ASSIGN
                tot_vat_pa   = tot_vat_pa   + nv_pa_vat
                tot_vat_comp = tot_vat_comp + nv_comp_vat
                tot_vat_vol  = tot_vat_vol  + nv_vol_vat
                com_per      = 0.
            FIND FIRST uwm120 NO-LOCK WHERE uwm120.policy = uwm100.policy
                                        AND uwm120.rencnt = uwm100.rencnt
                                        AND uwm120.endcnt = uwm100.endcnt
                                        AND uwm120.riskno = 1 NO-ERROR.
            IF  AVAIL uwm120 THEN DO:
                /* IF com_per =  0  THEN  com_per  =  uwm120.com1p.  A64-0361 */
                IF com_per =  0  THEN  com_per  =  (uwm120.com1p + uwm120.com3p).  /*  A64-0361 */
                ASSIGN /*com_pa  = TRUNCATE((nv_pa * uwm120.com1p / 100),0) A64-0361 */
                       com_pa  = TRUNCATE((nv_pa * (uwm120.com1p + uwm120.com3p) / 100),0)  /*  A64-0361 */
                       com_pa  = com_pa * (-1).
            END.
            ASSIGN 
                com_vol        = uwm100.com1_t - com_pa
                com_comp       = uwm100.com2_t
                com_volco      = uwm100.com3_t /* A64-0361 */
                tot_com_pa     = tot_com_pa    + com_pa
                tot_com_vol    = tot_com_vol   + com_vol
                tot_com_comp   = tot_com_comp  + com_comp
                tot_com_volco  = tot_com_volco  +  com_volco /* A64-0361 */
                pol_prem       = nv_vol  + nv_comp  + nv_pa    /* PREMIUM  */
                nv_comm        = com_vol + com_comp + com_pa  /* COMMISSION */
                nv_fee         = uwm100.rfee_t               /*Ri Disc. */
                nv_sumfee      = nv_comm + nv_fee
                nv_sumfee_co   = nv_comm + nv_fee + com_volco. /* A64-0361 */
            IF  SUBSTR(acm001.policy,3,2) <> "60" AND SUBSTR(acm001.policy,3,2) <> "61" AND
                SUBSTR(acm001.policy,3,2) <> "62" AND SUBSTR(acm001.policy,3,2) <> "63" AND
                SUBSTR(acm001.policy,3,2) <> "64" AND SUBSTR(acm001.policy,3,2) <> "67" /*AND 
                SUBSTR(acm001.policy,3,2) <> "68" AND SUBSTR(acm001.policy,3,2) <> "69" Lukkana M. A55-0372 13/12/2012*/ THEN   /*Lukkana M. A55-0345 08/11/2012 เพิ่มline 68,69*/  
                ASSIGN nv_vol_vat = uwm100.rtax_t - nv_pa_vat - nv_comp_vat
                       nv_vat     = nv_vol_vat    + nv_pa_vat + nv_comp_vat
                       nv_tot_vat = pol_prem      + nv_vat    + nv_stp
                       nv_sbt     = 0
                       nv_tot_sbt = 0.
            ELSE ASSIGN nv_vol_vat = 0
                        nv_vat     = 0
                        nv_tot_vat = 0
                        nv_sbt     = acm001.tax
                        nv_tot_sbt = pol_prem + nv_sbt + nv_stp.
        END.  /*Each uwd132*/

        /*---A51-0078---*/
        IF SUBSTR(acm001.policy,1,2) = "IY" AND acm001.acno = "0APTHAI" THEN 
            ASSIGN n_ri = YES
                   /* n_poltyp = n_poltyp + "T".*/
                   n_poltyp = SUBSTR(acm001.policy,3,2) + "T".
        ELSE n_ri = NO.

        /*--A63-0038--*/
        ASSIGN nv_cedco = ""
                nv_cedco = uwm100.cedco.  
        RUN pd_cedco.
    
        IF fi_reptyp = "2" THEN RUN pro_Nonmotor.

        /*-----------*/
    END.  /*--- End Non Motor ---*/ 

    /*-- PUT Data TO Excel --*/
    IF fi_reptyp = "1" THEN DO:
        OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.   
        RUN ChkLineExcel.
        EXPORT DELIMITER ";"
            n_bran      n_poltyp     n_policy      n_Rencnt    n_Endcnt   
            n_endno     n_comdat     n_Trndat      
            nv_vol      nv_comp      nv_pa         pol_prem      
            nv_vol_stp  nv_comp_stp  nv_pa_stp     nv_stp     
            nv_vol_vat  nv_comp_vat  nv_pa_vat     nv_vat      nv_tot_vat 
            nv_sbt      nv_tot_sbt   com_vol       com_comp    com_pa     
            nv_comm     nv_fee /*A53-0020*/  nv_sumfee  n_prnvat 
            nv_cedco    nv_prmloc   nv_prmfor      nv_commloc nv_commfor   /*---A63-0038----*/
            com_volco   nv_sumfee_co.   /*---A64-0361--*/ 
        OUTPUT CLOSE.
        nv_reccnt = nv_reccnt + 1.
    END.
    ASSIGN 
        nsd_vol      = nsd_vol      + nv_vol
        nsd_comp     = nsd_comp     + nv_comp
        nsd_pa       = nsd_pa       + nv_pa
        nsd_pol_prem = nsd_pol_prem + pol_prem
        nsd_vol_stp  = nsd_vol_stp  + nv_vol_stp
        nsd_comp_stp = nsd_comp_stp + nv_comp_stp
        nsd_pa_stp   = nsd_pa_stp   + nv_pa_stp
        nsd_stp      = nsd_stp      + nv_stp
        nsd_vol_vat  = nsd_vol_vat  + nv_vol_vat       
        nsd_comp_vat = nsd_comp_vat + nv_comp_vat
        nsd_pa_vat   = nsd_pa_vat   + nv_pa_vat  
        nsd_vat      = nsd_vat      + nv_vat    
        nsd_tot_vat  = nsd_tot_vat  + nv_tot_vat
        nsd_sbt      = nsd_sbt      + nv_sbt      
        nsd_tot_sbt  = nsd_tot_sbt  + nv_tot_sbt
        nsd_com_vol  = nsd_com_vol  + com_vol 
        nsd_com_comp = nsd_com_comp + com_comp
        nsd_com_pa   = nsd_com_pa   + com_pa
        nsd_comm     = nsd_comm     + nv_comm 
        nsd_fee      = nsd_fee     + nv_fee
        nsd_sumfee   = nsd_sumfee  + nv_sumfee
        /*---A63-0038---*/
        nsd_prmloc   = nsd_prmloc   +  nv_prmloc 
        nsd_prmfor   = nsd_prmfor   +  nv_prmfor 
        nsd_commloc  = nsd_commloc  +  nv_commloc
        nsd_commfor  = nsd_commfor  +  nv_commfor.
        /*---A63-0038---*/
    ASSIGN 
        nv_vol     = 0   nv_comp     = 0   nv_pa     = 0   pol_prem = 0     
        nv_vol_stp = 0   nv_comp_stp = 0   nv_pa_stp = 0   nv_stp   = 0      
        nv_vol_vat = 0   nv_comp_vat = 0   nv_pa_vat = 0   nv_vat   = 0         
        nv_sbt     = 0   nv_tot_sbt  = 0   nv_tot_vat  = 0          
        com_vol    = 0   com_comp    = 0   com_pa    = 0     com_volco    = 0    
        nv_comm    = 0   nv_fee      = 0   nv_sumfee = 0     nv_sumfee_co = 0    
        nv_cedco = "" nv_prmloc = 0 nv_prmfor = 0 nv_commloc = 0 nv_commfor = 0.    /*---A63-0038---*/
    IF LAST-OF (acm001.branch) AND fi_reptyp = "1" THEN  RUN sumDetail. /*--By Aom Sum Detail --*/
END.    /*each acm001*/ 

IF fi_reptyp = "2" THEN DO:
    RUN pdSumRep.
END.   /* Report = Summary */
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_ProTot C-Win 
PROCEDURE Proc_ProTot :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  FOR EACH wfbyline 
    BREAK BY wfbran
          BY wfpoltyp
          BY wfdes
          BY wfseq:

    IF FIRST-OF (wfbran) OR nv_reccnt = 0 THEN DO:
       OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO.
       RUN SHeadTable. 
       OUTPUT CLOSE.
       nv_reccnt = nv_reccnt + 3.
    END.
    wfsumfee   = wfcomm + wffee.
    wfsumfeeco = wfsumfee + wfcommco. /*A64-0361*/
    wfsum = (wfprem + wfstp + wfvat + wfsbt + wfsumfee).
    OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO.   
    RUN ChkLineExcel.
    EXPORT DELIMITER ";"
        wfbran      wfpoltyp    wfdesc      wfprem    
        wfstp       wfvat       wfprvat     wfsbt     
        wfprsbt     wftotprm    wfcomm      wffee  wfsumfee  wfsum
        /*A63-0038*/
        wfprmloc    wfprmfor    wfcommloc   wfcommfor wfcommco wfsumfeeco 
        .
    OUTPUT CLOSE.
    
    ASSIGN 
     jv_bran   = wfbran  /*-: Post JV -*/
     jv_desc   = wfdesc
     jv_prem   = wfprem
     jv_stp    = wfstp
     jv_vat    = wfvat
     jv_prvat  = wfprvat
     jv_sbt    = wfsbt
     jv_prsbt  = wfprsbt
     jv_totprm = wftotprm
     /*jv_comm   = wfcomm  A64-0361--*/
     jv_comm   = wfcomm + wfcommco /*-- A64-0361--*/
     jv_sum    = wfsum
     jv_fee    = wffee 
     /*jv_sumfee = wfsumfee 64-0361--*/
     jv_sumfee = wfsumfee + wfcommco /*-- A64-0361--*/
     jvg_comm  = jvg_comm + jv_comm
     jvg_sumfee = jvg_sumfee + jv_sumfee
     jv_poltyp = SUBSTR(wfpoltyp,1,2)   /*A51-0078*/
     /*---A63-0038---*/
     jv_prmloc = wfprmloc
     jv_prmfor = wfprmfor
     jv_commloc = wfcommloc
     jv_commfor = wfcommfor.

    IF n_jv = YES THEN DO:
       
       /*A51-0078*/
       IF SUBSTR(wfpoltyp,LENGTH(wfpoltyp),1) = "T" THEN 
       ASSIGN n_ri = YES.
           ELSE n_ri = NO.
       
       RUN Pro_Fsacc.
       RUN Pro_Poltyp.
       RUN Pro_JV.  

    END.
    jv_comm = 0.
    /*-: Total Branch [+],[-] -*/
    n_desbr = "Total Branch: " + wfbran + "[" + SUBSTR(wfdesc,6,1) + "]".
    
    
    IF LENGTH(wfbran) = 1  THEN DO: /*เช็คbranch 1 หลัก*/
    
        IF wfbran = SUBSTR(n_desbr,15,1) AND wfprem > 0 THEN DO:
           ASSIGN 
            np_prem   = np_prem   + wfprem  
            np_stp    = np_stp    + wfstp   
            np_vat    = np_vat    + wfvat   
            np_prvat  = np_prvat  + wfprvat
            np_sbt    = np_sbt    + wfsbt   
            np_prsbt  = np_prsbt  + wfprsbt
            np_totprm = np_totprm + wftotprm
            np_comm   = np_comm   + wfcomm  
            np_sum    = np_sum    + wfsum
            np_fee    = np_fee    + wffee
            np_sumfee  = np_sumfee    + wfsumfee
            /*A63-0038*/
            np_prmloc = np_prmloc + wfprmloc
            np_prmfor = np_prmfor + wfprmfor
            np_commloc = np_commloc + wfcommloc
            np_commfor = np_commfor + wfcommfor.
        END.
        IF wfbran = SUBSTR(n_desbr,15,1) AND wfprem < 0 THEN DO:
           ASSIGN 
            ns_prem   = ns_prem   + wfprem  
            ns_stp    = ns_stp    + wfstp   
            ns_vat    = ns_vat    + wfvat   
            ns_prvat  = ns_prvat  + wfprvat
            ns_sbt    = ns_sbt    + wfsbt   
            ns_prsbt  = ns_prsbt  + wfprsbt
            ns_totprm = ns_totprm + wftotprm
            ns_comm   = ns_comm   + wfcomm  
            ns_sum    = ns_sum    + wfsum
            ns_fee    = ns_fee    + wffee
            ns_sumfee  = ns_sumfee    + wfsumfee
            /*A63-0038*/
            ns_prmloc  = ns_prmloc +  wfprmloc
            ns_prmfor  = ns_prmfor +  wfprmfor
            ns_commloc = ns_commloc + wfcommloc
            ns_commfor = ns_commfor + wfcommfor.
        END.
        IF wfbran = substr(n_desbr,15,1) AND   /*-: GrandTotal of Branch -*/
           SUBSTR(wfdesc,6,1) = SUBSTR(n_desbr,17,1) THEN do: 
            
           ASSIGN 
            nb_prem   = nb_prem   + wfprem 
            nb_stp    = nb_stp    + wfstp 
            nb_vat    = nb_vat    + wfvat 
            nb_prvat  = nb_prvat  + wfprvat 
            nb_sbt    = nb_sbt    + wfsbt 
            nb_prsbt  = nb_prsbt  + wfprsbt 
            nb_totprm = nb_totprm + wftotprm
            nb_comm   = nb_comm   + wfcomm 
            nb_sum    = nb_sum    + wfsum
            nb_fee    = nb_fee    + wffee
            nb_sumfee    = nb_sumfee    + wfsumfee
            /*A63-0038*/
            nb_prmloc  = nb_prmloc  + wfprmloc
            nb_prmfor  = nb_prmfor  + wfprmfor
            nb_commloc = nb_commloc + wfcommloc
            nb_commfor = nb_commfor + wfcommfor.

            IF  LAST-OF (wfbran) THEN DO: 
                RUN pro_sumBr.
            END.
        END.
    END. /*if length(wfbran) =1 than*/
    ELSE IF LENGTH(wfbran) = 2 THEN DO: /*เช็ค branch 2 หลัก*/
        IF wfbran = SUBSTR(n_desbr,15,2) AND wfprem > 0 THEN DO:
           ASSIGN 
            np_prem   = np_prem   + wfprem  
            np_stp    = np_stp    + wfstp   
            np_vat    = np_vat    + wfvat   
            np_prvat  = np_prvat  + wfprvat
            np_sbt    = np_sbt    + wfsbt   
            np_prsbt  = np_prsbt  + wfprsbt
            np_totprm = np_totprm + wftotprm
            np_comm   = np_comm   + wfcomm  
            np_sum    = np_sum    + wfsum
            np_fee    = np_fee    + wffee
            np_sumfee = np_sumfee    + wfsumfee
            /*A63-0038*/
            np_prmloc = np_prmloc + wfprmloc
            np_prmfor = np_prmfor + wfprmfor
            np_commloc = np_commloc + wfcommloc
            np_commfor = np_commfor + wfcommfor.
        END.
        IF wfbran = SUBSTR(n_desbr,15,2) AND wfprem < 0 THEN DO:
           ASSIGN 
            ns_prem   = ns_prem   + wfprem  
            ns_stp    = ns_stp    + wfstp   
            ns_vat    = ns_vat    + wfvat   
            ns_prvat  = ns_prvat  + wfprvat
            ns_sbt    = ns_sbt    + wfsbt   
            ns_prsbt  = ns_prsbt  + wfprsbt
            ns_totprm = ns_totprm + wftotprm
            ns_comm   = ns_comm   + wfcomm  
            ns_sum    = ns_sum    + wfsum
            ns_fee    = ns_fee    + wffee
            ns_sumfee    = ns_sumfee    + wfsumfee
               /*A63-0038*/
            ns_prmloc  = ns_prmloc +  wfprmloc
            ns_prmfor  = ns_prmfor +  wfprmfor
            ns_commloc = ns_commloc + wfcommloc
            ns_commfor = ns_commfor + wfcommfor.
        END.

        IF wfbran = substr(n_desbr,15,2) AND   /*-: GrandTotal of Branch -*/
           SUBSTR(wfdesc,6,1) = SUBSTR(n_desbr,18,1) THEN do: 
           ASSIGN 
            nb_prem   = nb_prem   + wfprem 
            nb_stp    = nb_stp    + wfstp 
            nb_vat    = nb_vat    + wfvat 
            nb_prvat  = nb_prvat  + wfprvat 
            nb_sbt    = nb_sbt    + wfsbt 
            nb_prsbt  = nb_prsbt  + wfprsbt 
            nb_totprm = nb_totprm + wftotprm
            nb_comm   = nb_comm   + wfcomm 
            nb_sum    = nb_sum    + wfsum
            nb_fee    = nb_fee    + wffee
            nb_sumfee    = nb_sumfee    + wfsumfee
            /*A63-0038*/
            nb_prmloc  = nb_prmloc  + wfprmloc
            nb_prmfor  = nb_prmfor  + wfprmfor
            nb_commloc = nb_commloc + wfcommloc
            nb_commfor = nb_commfor + wfcommfor.


            IF  LAST-OF (wfbran) THEN DO: 
                /*RUN pro_sumBr.*/
                OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO.  
                RUN ChkLineExcel.
                EXPORT DELIMITER ";"
                    "Total Branch: " + SUBSTRI(n_desbr,15,2) + " [+]"      
                    " "         " "          np_prem      
                    np_stp      np_vat       np_prvat     np_sbt     
                    np_prsbt    np_totprm    np_comm        np_fee  np_sumfee np_sum
                    /*---A63-0038---*/
                    np_prmloc   np_prmfor    np_commloc   np_commfor.
                OUTPUT CLOSE.

                OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO.   
                RUN ChkLineExcel.
                EXPORT DELIMITER ";"
                    "Total Branch: " + SUBSTRI(n_desbr,15,2) + " [-]"      
                    " "          " "              ns_prem    
                    ns_stp       ns_vat           ns_prvat         ns_sbt     
                    ns_prsbt     ns_totprm        ns_comm          ns_sum ns_fee ns_sumfee
                    /*---A63-0038---*/
                    ns_prmloc   ns_prmfor    ns_commloc   ns_commfor.
                OUTPUT CLOSE.

                ASSIGN  np_prem = 0  np_stp   = 0  np_vat    = 0  np_prvat = 0   
                        np_sbt  = 0  np_prsbt = 0  np_totprm = 0  np_comm  = 0  np_sum   = 0  
                        np_fee  = 0  np_sumfee   = 0  
                        /*---A63-0038---*/
                        np_prmloc = 0   np_prmfor = 0    np_commloc = 0   np_commfor = 0
                        ns_prem = 0  ns_stp   = 0  ns_vat    = 0  ns_prvat = 0  
                        ns_sbt  = 0  ns_prsbt = 0  ns_totprm = 0  ns_comm  = 0  ns_sum   = 0
                        ns_fee  = 0  ns_sumfee   = 0  
                        /*---A63-0038---*/
                        ns_prmloc = 0   ns_prmfor = 0    ns_commloc = 0   ns_commfor = 0.

                IF n_jv = YES THEN DO: 
                   IF n_source = "DI" THEN DO:

                      nv_macc    = "".    /*ADD Saowapa U. A63-0038 18/02/2020*/
                      nv_macc20  = "".   /*ADD Saowapa U. A63-0038 18/02/2020*/
                      totsumpa = nb_prvat - sumpa.

                      /*--- Comment By A49-0127 Sayamol
                      RUN wac/wacazr (INPUT (-1) * sumpa, jv_bran, 2, "10400074",
                                            n_sacc1, n_sacc2, n_gldat, n_source).
                      End Modify A49-0127 ---*/

                      /*--- Modify By A49-0148 Sayamol---*/
                      /* RUN wac/wacazr (INPUT (-1) * (totsumpa + sumpa), jv_bran, 2, "10400073", 
                                            n_sacc1, n_sacc2, n_gldat, n_source).   ----Saowapa U. A63-0038 18/02/2020*/
                      /*--- End Modify A49-0148 ---*/

                      /*---ADD Saowapa U. A63-0038 18/02/2020 */
                      /****************** FFFFFFFFFFFFFFFFFFFF******************
                      FIND FIRST cvm008 NO-LOCK WHERE cvm008.poltyp = jv_poltyp NO-ERROR.
                      IF AVAIL cvm008 THEN DO:
                         nv_macc = "104000" + cvm008.codeac.   /*----104000LL---*/
                         nv_macc20 = "204000" + cvm008.codeac.  /*----204000LL---*/
                      END.

                      RUN wac/wacazr (INPUT (-1) * (totsumpa + sumpa), jv_bran, 2, nv_macc, 
                                          n_sacc1, "", n_gldat, n_source).
                      /*END Saowapa U. A63-0038 18/02/2020 */


                      /*RUN wac/wacazr (INPUT (-1) * jvg_comm, jv_bran, 1, "20400077", */
                      /*----Saowapa U. A63-0038 26/02/2020----
                      RUN wac/wacazr (INPUT (-1) * jvg_sumfee, jv_bran, 1, "20400077", 
                                            n_sacc1, n_sacc2, n_gldat, n_source).
                      ----------------*/
                      /*---ADD Saowapa U. A63-0038 18/02/2020----*/
                      RUN wac/wacazr (INPUT (-1) * jvg_sumfee, jv_bran, 1, nv_macc20, 
                                            n_sacc1, "", n_gldat, n_source).
                      ********************* END FFFFFFFFFFFFFFFFFFFFFFFFFFFF*************/
                      /*---END Saowapa U. A63-0038 18/02/2020----*/
                   END.
                   ELSE IF n_source = "IF" THEN
                      /*--
                      IF n_ri = YES THEN
                      RUN wac/wacazr (INPUT (-1) * jv_summ, jv_bran, 1, "10510000", 
                                            n_sacc1, n_sacc2, n_gldat, n_source).
                      Lukkana M. A55-0345 07/11/2012--*/                      
                END.

                OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO.   
                RUN ChkLineExcel.
                EXPORT DELIMITER ";"
                    "GrandTotal of Branch:" + SUBSTRI(n_desbr,15,2)      
                    " "          " "              nb_prem    
                    nb_stp       nb_vat           nb_prvat         nb_sbt     
                    nb_prsbt     nb_totprm        nb_comm          nb_fee nb_sumfee  nb_sum
                    /*---A63-0038---*/
                    nb_prmloc   nb_prmfor    nb_commloc   nb_commfor.
                OUTPUT CLOSE.

                ASSIGN nb_prem = 0  nb_stp   = 0  nb_vat    = 0  nb_prvat = 0  
                       nb_sbt  = 0  nb_prsbt = 0  nb_totprm = 0  nb_comm  = 0  
                       nb_sum  = 0  nb_fee   = 0  nb_sumfee = 0
                       /*---A63-0038---*/
                       nb_prmloc = 0   nb_prmfor = 0    nb_commloc = 0   nb_commfor = 0
                       jvg_comm = 0  jv_summ   = 0  jv_tsumm = 0
                       sumpa   = 0  jvg_sumfee = 0 nv_macc  = "".    /*ADD Saowapa U. A63-0038 18/02/2020*/
                       
            END.
        END.
    END.   /*else if length(wfbran) = 2 */
  END.  /* FOR EACH wfbyline */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_PutHead C-Win 
PROCEDURE Proc_PutHead :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
RUN ChkLineExcel.
EXPORT DELIMITER ";" "".
RUN DHeadTable.
OUTPUT CLOSE.             
nv_reccnt = nv_reccnt + 2.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_Fsacc C-Win 
PROCEDURE Pro_Fsacc :
/*------------------------------------------------------------------------------
  Purpose: Find n_sacc1, n_sacc2    
  Parameters:  jv_bran ==> n_sacc1, n_sacc2
  Notes:       
------------------------------------------------------------------------------*/
/*-----------A51-0078------------*/
FIND FIRST cvm002 WHERE cvm002.branch = jv_bran NO-ERROR.
IF AVAIL cvm002 THEN DO:
    ASSIGN n_sacc1 = cvm002.class
           n_sacc2 = cvm002.tariff.
END.
ELSE DO:
    n_sacc2 = "".
    FIND FIRST GL.Chm993 WHERE  GL.Chm993.compy = "0" AND
                         SUBSTR(GL.Chm993.branch,1,1) = jv_bran NO-LOCK NO-ERROR.
    IF AVAILABLE GL.Chm993 THEN n_sacc1 = "0" + SUBSTR(GL.Chm993.branch,2,2).
    ELSE DO:
        ASSIGN n_sacc1 = ""
               n_sacc2 = "".
    END.
END.
/*------------------------------------*/

/*--------By A51-0078 ---------------
IF jv_bran = "0" OR
   jv_bran = "M" OR
   jv_bran = "V" OR
   jv_bran = "W" OR
   jv_bran = "L" OR
   jv_bran = "X" THEN DO:
      IF jv_bran = "0" THEN n_sacc2 = "01".
      ELSE IF jv_bran = "M" THEN n_sacc2 = "03".
      ELSE IF jv_bran = "V" THEN n_sacc2 = "04".
      ELSE IF jv_bran = "W" THEN n_sacc2 = "02".
      ELSE IF jv_bran = "L" THEN n_sacc2 = "19".
      ELSE IF jv_bran = "X" THEN n_sacc2 = "28".
      n_sacc1 = "000".
END.
ELSE DO:
    n_sacc2   = "".
    
    FIND FIRST GL.Chm993 WHERE  GL.Chm993.compy = "0" AND
                         SUBSTR(GL.Chm993.branch,1,1) = jv_bran NO-LOCK NO-ERROR.
    IF AVAILABLE GL.Chm993 THEN n_sacc1 = "0" + SUBSTR(GL.Chm993.branch,2,2).
  
    IF jv_bran = "A"  THEN 
    ASSIGN  n_sacc1 = "007"
            n_sacc2 = "023".
    ELSE IF jv_bran = "B" THEN
    ASSIGN  n_sacc1 = "020"                  
            n_sacc2 = "  ".                  
    ELSE IF jv_bran = "C" THEN
    ASSIGN  n_sacc1 = "022"                  
            n_sacc2 = "".                    
    ELSE IF jv_bran = "D" THEN
    ASSIGN  n_sacc1 = "004"
            n_sacc2 = "021".
    ELSE IF jv_bran = "P" THEN
    ASSIGN  n_sacc1 = "005"
            n_sacc2 = "017".
    ELSE IF jv_bran = "9" THEN
    ASSIGN  n_sacc1 = "007"
            n_sacc2 = "025".
END. 
----------end A51-0078----------------*/         
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_JV C-Win 
PROCEDURE Pro_JV :
/*------------------------------------------------------------------------------
  Purpose: Post JV   (Create AZR516)
  Parameters:  run โปรแกรม wacazr
  Notes:   DI ==> "20710004" , "20710006" , "73024030" , "10400071" 
           IF ==> "20710004" , "20710006" , "73024030"    
------------------------------------------------------------------------------*/
/*  modify by : Benjaporn J. A58-0358 date 21/09/2015 
                กำหนดค่า sub1 และ sub2
------------------------------------------------------------------------------*/
/*--Add Saowapa U. A63-0038 27/02/2563--*/
ASSIGN 
    nv_macc10   = ""
    nv_macc20   = ""
    nv_macc     = "".
/*--END Saowapa U. A63-0038 27/02/2563--*/

IF n_jv = YES  THEN DO:

   IF  n_source = "DI" THEN DO:
       RUN wac/wacazr (INPUT jv_sbt, jv_bran, 2, "20710004",     /* SBT */
       /*  n_sacc1, n_sacc2 , n_gldat, n_source). */
           n_sacc1, n_saccc2, n_gldat, n_source). /* Benjaporn J. A58-0358 date 21/09/2015 */

       /*---Saowapa U. A63-0038 26/02/2020---
       RUN wac/wacazr (INPUT jv_vat, jv_bran, 2, "20710006",     /* VAT */
      /*   n_sacc1, n_sacc2, n_gldat, n_source).*/
           n_sacc1, n_saccc2 , n_gldat, n_source). /* Benjaporn J. A58-0358 date 21/09/2015 */
      --------*/

       /*ADD Saowapa U. A63-0038 26/02/2020*/
       RUN wac/wacazr (INPUT jv_vat, jv_bran, 2, "20710006",     /* VAT */
      /*   n_sacc1, n_sacc2, n_gldat, n_source).*/
           n_sacc1, "" , n_gldat, n_source). /* Benjaporn J. A58-0358 date 21/09/2015 */
       /*END Saowapa U. A63-0038 26/02/2020*/

       RUN wac/wacazr (INPUT jv_stp, jv_bran, 2, "73024030",     /* STP */
           n_sacc1, n_sacc2, n_gldat, n_source).

       /*---Saowapa U. A63-0038 18/02/2020---
       RUN wac/wacazr (INPUT (-1) * jv_prsbt, jv_bran, 2, "10400071", /*TOTPrem. SBT*/
           n_sacc1, n_sacc2, n_gldat, n_source).
       --------*/

       /*---ADD Saowapa U. A63-0038 18/02/2020 --*/
       IF jv_prsbt = 0 THEN DO:
          FIND FIRST cvm008 NO-LOCK WHERE cvm008.poltyp = jv_poltyp NO-ERROR.
          IF AVAIL cvm008 THEN DO:
              n_grp# = cvm008.codeac.   /*----104000LL---*/
          END.
          ELSE n_grp# = jv_poltyp.
          
          nv_macc = "104000" + n_grp#.
          
          RUN wac/wacazr (INPUT (-1) * jv_prsbt, jv_bran, 2, nv_macc, /*TOTPrem. SBT*/
              n_sacc1, "", n_gldat, n_source).
       END.

       /*********************************/
       /**** PA ****/
       IF jv_poltyp >= "72" AND jv_poltyp <= "74" THEN  /* Sum TOTPrem.VAT Line72-74*/
          ASSIGN sumpa = sumpa + jv_prvat.
       /**END PA**/
    
       /************* FFFFFFFFFFFFFFFFF *****************/
      
       nv_macc =  "104000" + n_grp#.  /*----104000LL---*/
       RUN wac/wacazr (INPUT (-1) * /*(totsumpa + sumpa)*/ /*jv_prvat + sumpa*/ jv_totprm, jv_bran, 2, nv_macc, 
          n_sacc1, "", n_gldat, n_source).
         
    
    
       nv_macc20 =  "204000" + n_grp#.  /*----204000LL---*/
       RUN wac/wacazr (INPUT (-1) * /*jvg_sumfee*/ jv_sumfee, jv_bran, 1, nv_macc20, 
           n_sacc1, "", n_gldat, n_source).
       /**************** FFFFFFFFFFFFFFFFFFFF ************/
       /*********************************/
       
       /*---End Saowapa U. A63-0038 18/02/2020----*/

   END.   /*end DI */
   ELSE IF n_source = "IF" THEN DO:

       RUN wac/wacazr (INPUT jv_sbt, jv_bran, 2, "20710004",     /* SBT */
       /*  n_sacc1, n_sacc2 ,  n_gldat, n_source). */
           n_sacc1, n_saccc2 , n_gldat, n_source).  /* Benjaporn J. A58-0358 date 21/09/2015 */
       /*Saowapa U. A63-0038 26/02/2020
       RUN wac/wacazr (INPUT jv_vat, jv_bran, 2, "20710006",     /* VAT */
       /*  n_sacc1, n_sacc2 , n_gldat, n_source).  */
           n_sacc1, n_saccc2 , n_gldat, n_source).  /* Benjaporn J. A58-0358 date 21/09/2015 */
       -----------*/
       /*ADD Saowapa U. A63-0038 26/02/2020*/
       RUN wac/wacazr (INPUT jv_vat, jv_bran, 2, "20710006",     /* VAT */
       /*  n_sacc1, n_sacc2 , n_gldat, n_source).  */
           n_sacc1, "" , n_gldat, n_source).  /* Benjaporn J. A58-0358 date 21/09/2015 */
       /*END Saowapa U. A63-0038 26/02/2020*/

       RUN wac/wacazr (INPUT jv_stp, jv_bran, 2, "73024030",     /* STP */
           n_sacc1 , n_sacc2, n_gldat, n_source).

       /*--
       ASSIGN  jv_summ = jv_summ + jv_sum.  /*(jv_prem  + jv_comm + jv_sbt + jv_vat + jv_stp + jv_fee).*/
       Lukkana M. A55-0304 01/10/2012--*/

       /*----Saowapa U. A63-0038 27/02/2020-----
       /*Lukkana M. A55-0345 07/11/2012*/
       RUN wac/wacazr (INPUT (-1) * jv_summ, jv_bran, 2, "10524000", /*Fac Prem*/
           /*n_sacc1*/ n_saccc1 /*-A58-0358-*/ , n_saccc2, n_gldat, n_source).

       RUN wac/wacazr (INPUT (-1) * jv_comm1, jv_bran,2, "20525000",     /*Fac Comm.*/
           /*n_sacc1*/ n_saccc1 /*-A58-0358-*/ , n_saccc2, n_gldat, n_source).
       /*Lukkana M. A55-0345 07/11/2012*/
       ------------*/
       /*----ADD Saowapa U. A63-0038 27/02/2020-----*/

       FIND FIRST cvm008 NO-LOCK WHERE cvm008.poltyp = jv_poltyp NO-ERROR.
       IF AVAIL cvm008 THEN DO:
           n_grp# = cvm008.codeac. 
       END.
       ELSE DO: 
           n_grp# = jv_poltyp.
       END.

       nv_macc10 = "105241" + n_grp#.   /*----105241LL---*/
       nv_macc20 = "205251" + n_grp#.   /*----205251LL---*/
       RUN wac/wacazr (INPUT (-1) * jv_summ, jv_bran, 2, nv_macc10, /*Fac Prem*/
           /*n_sacc1*/ n_saccc1 /*-A58-0358-*/ , "", n_gldat, n_source).

       RUN wac/wacazr (INPUT (-1) * jv_comm1, jv_bran,2, nv_macc20,     /*Fac Comm.*/
           /*n_sacc1*/ n_saccc1 /*-A58-0358-*/ , "", n_gldat, n_source).
       /*----END Saowapa U. A63-0038 27/02/2020-----*/



    END. 

END.   /* n_jv */

/**** PA ****
IF jv_poltyp >= "72" AND jv_poltyp <= "74" THEN  /* Sum TOTPrem.VAT Line72-74*/
    ASSIGN sumpa = sumpa + jv_prvat.
/**END PA**/

 /************* FFFFFFFFFFFFFFFFF *****************/
  
   nv_macc =  "104000" + n_grp#.  /*----104000LL---*/
   RUN wac/wacazr (INPUT (-1) * /*(totsumpa + sumpa)*/ /*jv_prvat + sumpa*/ jv_totprm, jv_bran, 2, nv_macc, 
      n_sacc1, "", n_gldat, n_source).
     


   nv_macc20 =  "204000" + n_grp#.  /*----204000LL---*/
   RUN wac/wacazr (INPUT (-1) * /*jvg_sumfee*/ jv_sumfee, jv_bran, 1, nv_macc20, 
       n_sacc1, "", n_gldat, n_source).
   *************** FFFFFFFFFFFFFFFFFFFF ************/
   

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_Motor C-Win 
PROCEDURE pro_Motor :
/*------------------------------------------------------------------------------
  Purpose: Create Workfile For Motor (70, 70PA, 71, 72, 73, 74) to Summary Report  
  Parameters:  <none>  
  Notes:       
------------------------------------------------------------------------------*/
IF SUBSTR(acm001.policy,3,2) = "70" THEN DO:
    IF nv_vol > 0 THEN DO:
        FIND FIRST wfbyline WHERE wfpoltyp = "70"  
                              AND wfbran   =  n_bran
                              AND wfdesc   = "prem + " NO-ERROR. 
        IF NOT AVAILABLE wfbyline THEN DO:
            CREATE wfbyline.
            ASSIGN 
                wfpoltyp = "70" 
                wfbran   =  n_bran
                wfdesc   = "prem + ". 
        END.
        ASSIGN 
            wfprem   = wfprem   + nv_vol
            wfvat    = wfvat    + nv_vol_vat
            wfstp    = wfstp    + nv_vol_stp
            wfcomm   = wfcomm   + com_vol
            wfcommco = wfcommco + com_volco   /*A64-0361*/
            wfprvat  = wfprem   + wfvat + wfstp      /*By Aom*/
            wftotprm = wfprvat
            wffee    = wffee + nv_fee. /*Lukkana M. A55-0372 13/12/2012*/
    END.  /*End if nv_vol > 0*/
    ELSE DO: 
        FIND FIRST wfbyline WHERE wfpoltyp = "70"      
                              AND wfbran   =  n_bran    
                              AND wfdesc   = "prem - " NO-ERROR. 
        IF NOT AVAILABLE wfbyline THEN DO:
            CREATE wfbyline.
            ASSIGN wfpoltyp = "70" 
                wfbran   =  n_bran 
                wfdesc   = "prem - ". 
        END.
        ASSIGN 
            wfprem   = wfprem + nv_vol
            wfvat    = wfvat  + nv_vol_vat
            wfstp    = wfstp  + nv_vol_stp
            wfcomm   = wfcomm + com_vol
            wfcommco = wfcommco + com_volco   /*A64-0361*/
            wfprvat  = wfprem + wfvat + wfstp   /*By Aom*/
            wftotprm = wfprvat
            wffee    = wffee + nv_fee.  /*Lukkana M. A55-0372 13/12/2012*/
    END.
    IF  nv_comp  > 0 THEN DO:
        FIND FIRST wfbyline WHERE wfpoltyp = "71"      AND
                                  wfbran   = n_bran    AND
                                  wfdesc   = "prem + " NO-ERROR. 
        IF NOT AVAILABLE wfbyline THEN DO:
            CREATE wfbyline.
            ASSIGN wfpoltyp = "71" 
                wfbran   =  n_bran
                wfdesc   = "prem + ". 
        END.
        ASSIGN 
            wfprem   = wfprem + nv_comp
            wfvat    = wfvat  + nv_comp_vat
            wfstp    = wfstp  + nv_comp_stp
            wfcomm   = wfcomm + com_comp
            wfprvat  = wfprem + wfvat + wfstp    /*By Aom*/
            wftotprm = wfprvat.
    END.
    ELSE DO:
        FIND FIRST wfbyline WHERE wfpoltyp  = "71"       AND
                                  wfbran    = n_bran     AND
                                  wfdesc    = "prem - "  NO-ERROR. 
        IF NOT AVAILABLE wfbyline THEN DO:
            CREATE wfbyline.
            ASSIGN 
                wfpoltyp = "71" 
                wfbran   =  n_bran
                wfdesc   = "prem - ". 
        END.
        ASSIGN 
            wfprem   = wfprem + nv_comp
            wfvat    = wfvat  + nv_comp_vat
            wfstp    = wfstp  + nv_comp_stp
            wfcomm   = wfcomm + com_comp
            wfprvat  = wfprem + wfvat + wfstp   /*By Aom */
            wftotprm = wfprvat.
    END.
    IF  nv_pa  > 0  THEN  DO:
        FIND FIRST wfbyline WHERE wfpoltyp = "70PA" 
                              AND wfbran   =  n_bran
                              AND wfdesc   = "prem + " NO-ERROR. 
        IF NOT AVAILABLE wfbyline THEN DO:
            CREATE wfbyline.
            ASSIGN 
                wfpoltyp = "70PA"
                wfbran   =  n_bran 
                wfdesc   = "prem + ". 
        END.
        ASSIGN 
            wfprem   = wfprem + nv_pa
            wfvat    = wfvat  + nv_pa_vat
            wfstp    = wfstp  + nv_pa_stp
            wfcomm   = wfcomm + com_pa
            wfprvat  = wfprem + wfvat + wfstp    /*By Aom */
            wftotprm = wfprvat.
    END.
    ELSE DO:
        FIND FIRST wfbyline WHERE wfpoltyp  = "70PA"    AND
                                  wfbran    = n_bran    AND
                                  wfdesc    = "prem - " NO-ERROR. 
        IF NOT AVAILABLE wfbyline THEN DO:
            CREATE wfbyline.
            ASSIGN 
                wfpoltyp = "70PA"
                wfbran   = n_bran 
                wfdesc   = "prem - ". 
        END.
        ASSIGN 
            wfprem   = wfprem + nv_pa
            wfvat    = wfvat  + nv_pa_vat
            wfstp    = wfstp  + nv_pa_stp
            wfcomm   = wfcomm + com_pa
            wfprvat  = wfprem + wfvat + wfstp    /*By Aom */
            wftotprm = wfprvat.
    END.
END.     /*---if "70"---*/
ELSE DO:        /*-- 72,73,74 --*/
    IF  nv_comp  > 0 THEN DO:
        FIND FIRST wfbyline WHERE wfpoltyp = SUBSTR(acm001.policy,3,2)  AND
                                  wfbran   =  n_bran                    AND
                                  wfdesc   = "prem + "                  NO-ERROR. 
        IF NOT AVAILABLE wfbyline THEN DO:
            CREATE wfbyline.
            ASSIGN 
                wfpoltyp = SUBSTR(acm001.policy,3,2) 
                wfbran   =  n_bran
                wfdesc   = "prem + ". 
        END.
        ASSIGN 
            wfprem   = wfprem + nv_comp        
            wfvat    = wfvat  + nv_comp_vat     
            wfstp    = wfstp  + nv_comp_stp     
            wfcomm   = wfcomm + com_vol   
            wfcommco = wfcommco + com_volco   /*A64-0361*/
            wfprvat  = wfprem + wfvat + wfstp     /*By Aom*/
            wftotprm = wfprvat.                 
    END.
    ELSE DO:
        FIND FIRST wfbyline WHERE wfpoltyp  = SUBSTR(acm001.policy,3,2) AND
                                  wfbran    = n_bran                    AND
                                  wfdesc    = "prem - "                 NO-ERROR. 
        IF NOT AVAILABLE wfbyline THEN DO:
            CREATE wfbyline.
            ASSIGN 
                wfpoltyp = SUBSTR(acm001.policy,3,2)
                wfbran   =  n_bran
                wfdesc   = "prem - ". 
        END.
        ASSIGN 
            wfprem   = wfprem + nv_comp
            wfvat    = wfvat  + nv_comp_vat
            wfstp    = wfstp  + nv_comp_stp
            wfcomm   = wfcomm + com_vol
            wfcommco = wfcommco + com_volco   /*A64-0361*/
            wfprvat  = wfprem + wfvat + wfstp   /*By Aom */
            wftotprm = wfprvat.
    END.
    /*Add kridtiya i. A57-0048 */
    IF nv_vol > 0 THEN DO:
        FIND FIRST wfbyline WHERE wfpoltyp = SUBSTR(acm001.policy,3,2)  AND
                                  wfbran   =  n_bran    AND
                                  wfdesc   = "prem - " NO-ERROR. 
        IF NOT AVAILABLE wfbyline THEN DO:
            CREATE wfbyline.
            ASSIGN 
                wfpoltyp = SUBSTR(acm001.policy,3,2) 
                wfbran   =  n_bran
                wfdesc   = "prem - ". 
        END.
        ASSIGN 
            wfprem   = wfprem + nv_vol                
            wfvat    = wfvat  + nv_vol_vat     
            wfstp    = wfstp  + nv_vol_stp     
            wfprvat  = wfprem + wfvat + wfstp     
            wftotprm = wfprvat.    
    END.  /*End if nv_vol > 0*/
    ELSE DO:
        FIND FIRST wfbyline WHERE wfpoltyp = SUBSTR(acm001.policy,3,2)  AND
                                  wfbran   =  n_bran    AND
                                  wfdesc   = "prem + " NO-ERROR. 
        IF NOT AVAILABLE wfbyline THEN DO:
            CREATE wfbyline.
            ASSIGN 
                wfpoltyp = SUBSTR(acm001.policy,3,2) 
                wfbran   =  n_bran
                wfdesc   = "prem + ". 
        END.
        ASSIGN 
            wfprem   = wfprem + nv_vol          
            wfvat    = wfvat  + nv_vol_vat      
            wfstp    = wfstp  + nv_vol_stp
            wfprvat  = wfprem + wfvat + wfstp      
            wftotprm = wfprvat    .              
    END.
    /*end. Add kridtiya i. A57-0048 */
END.   /*End else 72,73,74 */
ASSIGN  nv_vol      = 0     nv_vol_vat  = 0      
        nv_vol_stp  = 0     com_vol     = 0  
        com_volco   = 0 
        nv_comp     = 0     nv_comp_vat = 0
        nv_comp_stp = 0     com_comp    = 0
        nv_pa       = 0     nv_pa_vat   = 0
        nv_pa_stp   = 0     com_pa      = 0.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_NewDetails C-Win 
PROCEDURE Pro_NewDetails :
/*------------------------------------------------------------------------------
  Purpose:      Process Detail Excel File  
  Parameters:  <None>
  Notes:   Title = 3 Lines,  DHeadtable = 2 Lines **** for Direct ****
------------------------------------------------------------------------------*/

IF n_source = "DI" THEN RUN Proc_NewDetailsD.
ELSE IF n_source = "IF" THEN RUN Proc_NewDetailsL.

/*--- fon 22/08/2008
ASSIGN 
  nv_reccnt = 0
  nv_next   = 1
  nv_output2 = nv_output + STRING(nv_next) + "sum.SLK"
  nv_output  = nv_output + STRING(nv_next) + "det.SLK".
IF fi_reptyp = "1" THEN DO:
   OUTPUT TO VALUE (nv_output) NO-ECHO.
   EXPORT DELIMITER ";" 
     "Premium By Line - DETAIL".
   EXPORT DELIMITER ";"
     "Branch From : " frm_bran  "    To : "  to_bran
     "" "" "" "" "" "Tranaction Type :  M    R".
   EXPORT DELIMITER ";"
     "Tranaction Date From : " frm_trndat 
     "    TO : "  to_trndat 
     "" "" "" "" "" "Report Date : " TODAY.
   OUTPUT CLOSE.
   nv_reccnt = nv_reccnt + 3.
END.
loop_acm001:
FOR EACH acm001 NO-LOCK USE-INDEX acm00191 WHERE  acm001.trndat >= frm_trndat 
         AND  acm001.trndat <= to_trndat  
         AND (acm001.trnty1  = "A" OR acm001.trnty1  = "B" OR
         acm001.trnty1  = "M" OR acm001.trnty1  = "R" OR
         acm001.trnty1  = "O" OR acm001.trnty1  = "T" OR
         acm001.trnty1  = "Q" OR acm001.trnty1  = "V" )
         /*--- A51-0078, A50-0178
         AND SUBSTR(acm001.policy,2,1) >= frm_bran
         AND SUBSTR(acm001.policy,2,1) <= to_bran
         AND SUBSTR(acm001.policy,1,1) = SUBSTR(n_source,1,1)
         ----*/
         AND acm001.branch >= frm_bran
         AND acm001.branch <= to_bran
BREAK /*BY SUBSTR(acm001.policy,2,1) ---A50-0178---*/
      BY acm001.branch
      BY SUBSTR(acm001.policy,3,2) 
      BY acm001.recno
      BY acm001.policy   
      BY acm001.rencnt
      BY acm001.endcnt
      BY acm001.trndat. 
    /*---A50-0178----*/
   
    n_ri = NO.

    /*--- A50-0178 fon-----
    IF n_source = "DI"  THEN DO:
       IF SUBSTR(acm001.policy,1,1) <> "D" OR 
          SUBSTR(acm001.policy,1,2) <= "10" AND  
          SUBSTRING(acm001.policy,1,2) >= "99" THEN NEXT loop_acm001.
    END.
    ELSE IF n_source = "RI" THEN DO:
       IF SUBSTR(acm001.policy,1,1) <> "I" THEN NEXT loop_acm001.
    END.
    /*-------end A50-0178-------*/
    --- A50-0178 fon---*/

    IF n_source = "DI"  THEN DO:
       IF SUBSTRING(acm001.policy,1,2) >= "10" AND
          SUBSTRING(acm001.policy,1,2) <= "99" THEN DO:
           /* Valid Data -- Branch 2 หลัก เป็นการ Direct ทั้งหมด */
       END.
       ELSE IF SUBSTR(acm001.policy,1,1) <> "D" THEN NEXT loop_acm001.
    END.
    ELSE IF n_source = "IF" THEN DO:
       IF SUBSTR(acm001.policy,1,1) <> "I" THEN NEXT loop_acm001.
    END.
    /* END --- A50-0178 fon---*/

      ASSIGN
       n_bran     = acm001.branch
       n_poltyp   = SUBSTR(acm001.policy,3,2)
       n_policy   = acm001.policy
       nv_chkline = NO.
      IF fi_reptyp = "1" THEN DO:
         /*-IF FIRST-OF (SUBSTR(acm001.policy,2,1)) OR nv_reccnt = 0 THEN DO: --A50-0178 ---*/
         IF FIRST-OF (acm001.branch) OR nv_reccnt = 0 THEN DO:
            OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
            RUN ChkLineExcel.
            EXPORT DELIMITER ";" "".
            RUN DHeadTable.
            OUTPUT CLOSE.             
            nv_reccnt = nv_reccnt + 2.
         END.
      END.

     FIND uwm100 NO-LOCK 
         WHERE uwm100.policy = acm001.policy
          AND uwm100.trty11 = acm001.trnty1
          AND uwm100.docno1 = acm001.docno NO-ERROR.
     IF NOT AVAILABLE uwm100 THEN NEXT loop_acm001.
        DISP uwm100.policy uwm100.trty11 uwm100.trndat FORMAT 99/99/9999 
        WITH COLOR blue/withe NO-LABEL 
        TITLE "Process Data.." WIDTH 60 FRAME amain VIEW-AS DIALOG-BOX.
     IF acm001.prem <> uwm100.prem_t THEN DO:   /*Prem.AC. กับ UW ไม่เท่ากัน*/
        OUTPUT TO VALUE (nv_errfile) APPEND NO-ECHO.
        EXPORT DELIMITER ";"
          "policy ="  uwm100.policy.
        EXPORT DELIMITER ";"
          "rencnt ="  uwm100.rencnt.
        EXPORT DELIMITER ";"
          "endcnt ="  uwm100.endcnt.
        EXPORT DELIMITER ";"
          "Com date     ="  uwm100.comdat.
        EXPORT DELIMITER ";"
          "Tran date     ="  uwm100.trndat.
        EXPORT DELIMITER ";"
          "uwm100.prem_t ="  uwm100.prem_t.
        EXPORT DELIMITER ";"
          "acm001.prem   ="  acm001.prem.
        EXPORT DELIMITER ";"
          "acm001.netloc ="  acm001.netloc.
        EXPORT DELIMITER ";" "".
        EXPORT DELIMITER ";" "".
        OUTPUT CLOSE.
     END.
     ASSIGN  
      n_rencnt = uwm100.rencnt
      n_endcnt = uwm100.endcnt
      n_endno  = uwm100.endno
      n_trndat = uwm100.trndat
      n_comdat = uwm100.comdat.
     /*---------- Motor ---------*/
    IF (SUBSTRING(acm001.policy,3,2) = "70" OR SUBSTRING(acm001.policy,3,2) = "72" OR 
        SUBSTRING(acm001.policy,3,2) = "73" OR SUBSTRING(acm001.policy,3,2) = "74")  THEN DO:
        ASSIGN  nv_comp = 0         
                nv_pa   = 0.
        FOR EACH uwd132 NO-LOCK 
            WHERE uwd132.policy = uwm100.policy
             AND uwd132.rencnt = uwm100.rencnt
             AND uwd132.endcnt = uwm100.endcnt
             AND uwd132.prem_c <> ?.
        IF uwd132.bencod = "comp" THEN DO:             
           nv_comp = nv_comp + uwd132.prem_c.
           IF uwm100.pstp <> 0 OR uwm100.rstp_t <> 0 THEN DO:
              ASSIGN n_stp       = (uwd132.prem_c * 0.4) / 100
                     n_stpcom    = TRUNC(n_stp,0)
                     n_stptrunc  = n_stp - n_stpcom.
              IF   n_stptrunc    > 0  THEN  n_stpcom = n_stpcom + 1.
              ELSE IF n_stptrunc < 0  THEN  n_stpcom = n_stpcom - 1.
              IF SUBSTR(uwm100.policy,1,1) = "I" THEN nv_comp_stp = 1.
              ELSE nv_comp_stp = nv_comp_stp + n_stpcom.
              ASSIGN n_stpcom    = 0  
                     n_stptrunc  = 0.
              
           END.  /*rstp_t <> 0*/
        END.   /*bencod = "comp"*/
        ELSE IF uwd132.bencod = "pa" THEN DO:
                nv_pa = nv_pa + uwd132.prem_c.
                IF UWM100.PSTP <> 0 OR UWM100.RSTP_T <> 0 THEN DO:
                   ASSIGN  N_STP      = (UWD132.PREM_C * 0.4) / 100
                           N_STPPA    = TRUNCATE(n_stp,0)
                           n_stptrunc = n_stp - n_stppa.
                   IF   n_stptrunc    > 0  THEN n_stppa = n_stppa + 1.
                   ELSE IF n_stptrunc < 0  THEN n_stppa = n_stppa - 1.
                   IF SUBSTR(uwm100.policy,1,1) = "I" THEN nv_pa_stp = 1.
                   ELSE nv_pa_stp  = nv_pa_stp + n_stppa.
                   ASSIGN n_stppa    = 0
                          n_stptrunc = 0.
                END.  /* RSTP_T <> 0 */
        END. /*BENCOD = PA*/
        END. /*EACH UWD132*/  
     IF SUBSTR(uwm100.policy,1,1) = "I" THEN 
        ASSIGN  nv_vol_stp = 1
                nv_stp  =  nv_vol_stp + nv_comp_stp + nv_pa_stp.
     ELSE ASSIGN nv_vol_stp = (uwm100.pstp + uwm100.rstp_t) - nv_pa_stp - nv_comp_stp
               nv_stp     = uwm100.rstp_t + uwm100.pstp.   /* policy stamp */
     ASSIGN 
      nv_vol       = uwm100.prem_t - nv_comp - nv_pa
      tot_pa_stp   = tot_pa_stp    + nv_pa_stp
      tot_comp_stp = tot_comp_stp  + nv_comp_stp
      tot_vol_stp  = tot_vol_stp   + nv_vol_stp.

     /* Calculate VAT */
    IF uwm100.rtax_t <> 0 THEN nv_pa_vat   = (nv_pa + nv_pa_stp)     * uwm100.gstrat / 100.
    IF uwm100.rtax_t <> 0 THEN nv_comp_vat = (nv_comp + nv_comp_stp) * uwm100.gstrat / 100.
    ASSIGN  
     nv_vol_vat   = uwm100.rtax_t - nv_pa_vat - nv_comp_vat
     nv_vat       = nv_vol_vat    + nv_pa_vat + nv_comp_vat
     tot_vat_pa   = tot_vat_pa    + nv_pa_vat
     tot_vat_comp = tot_vat_comp  + nv_comp_vat
     tot_vat_vol  = tot_vat_vol   + nv_vol_vat
     com_per      = 0.
    FIND FIRST uwm120 NO-LOCK WHERE 
        uwm120.policy = uwm100.policy AND
        uwm120.rencnt = uwm100.rencnt AND
        uwm120.endcnt = uwm100.endcnt AND
        uwm120.riskno = 1 NO-ERROR.
    IF AVAIL uwm120 THEN DO:
       IF com_per = 0 THEN com_per = uwm120.com1p.
       IF uwm100.com1_t  <> 0 THEN 
            ASSIGN com_pa  = TRUNCATE((nv_pa * uwm120.com1p / 100),0).
                   com_pa  = com_pa * (-1).
    END.
    ASSIGN 
     com_vol      = uwm100.com1_t - com_pa
     com_comp     = uwm100.com2_t
     tot_com_pa   = tot_com_pa    + com_pa
     tot_com_vol  = tot_com_vol   + com_vol
     tot_com_comp = tot_com_comp  + com_comp
     pol_prem     = nv_vol  + nv_comp  + nv_pa   /*PREMIUM*/
     nv_comm      = com_vol + com_comp + com_pa /*COMMISSION*/
     nv_tot_sbt   = 0
     nv_tot_vat = pol_prem + nv_vat + nv_stp   
     nv_row = nv_row + 1. /*sum ยอดรวม*/
    IF (SUBSTR(acm001.policy,5,2)  = "99" OR  SUBSTR(acm001.policy,5,2) >= "43") AND /*check Print VAT*/
        SUBSTR(acm001.policy,3,2) <> "60" AND SUBSTR(acm001.policy,3,2) <> "61"  AND
        SUBSTR(acm001.policy,3,2) <> "62" AND SUBSTR(acm001.policy,3,2) <> "63"  AND
        SUBSTR(acm001.policy,3,2) <> "64" AND SUBSTR(acm001.policy,3,2) <> "67"  THEN DO:
        FIND FIRST vat100 NO-LOCK  USE-INDEX vat10002 
             WHERE vat100.policy = acm001.policy AND
                   vat100.trnty1 = acm001.trnty1 AND
                   vat100.refno  = acm001.docno  NO-ERROR.
        IF AVAIL vat100  THEN n_prnvat  = "V".
        ELSE  n_prnvat  = " ".
    END. 
    IF fi_reptyp = "2" THEN  RUN pro_motor.
   END. /*---if poltyp = "70" (Motor)--*/
   ELSE DO: /*------ Non Motor -------*/
         ASSIGN  
          nv_comp = 0  
          nv_pa   = 0.  
         FOR EACH uwd132 NO-LOCK 
             WHERE uwd132.policy = uwm100.policy
              AND uwd132.rencnt = uwm100.rencnt
              AND uwd132.endcnt = uwm100.endcnt
              AND uwd132.prem_c <> ?.
         IF  uwd132.bencod = "comp" THEN DO:
             nv_comp = nv_comp + uwd132.prem_c.
             IF UWM100.PSTP <> 0 OR UWM100.RSTP_T <> 0 THEN DO:
                ASSIGN  
                  N_STP      = (UWD132.PREM_C * 0.4) / 100
                  N_STPCOM   = TRUNCATE(n_stp,0)
                  n_stptrunc = n_stp - n_stpcom.
                IF      n_stptrunc > 0 THEN n_stpcom = n_stpcom + 1.
                ELSE IF n_stptrunc < 0 THEN n_stpcom = n_stpcom - 1.
                IF SUBSTR(uwm100.policy,1,1) = "I" THEN nv_comp_stp = 1.
                ELSE  nv_comp_stp  = 0.
                ASSIGN  n_stpcom     = 0    
                             n_stptrunc   = 0.
             END. /*RSTP_T  <> 0*/
         END. /*BENCOD = COMP*/
         ELSE IF uwd132.bencod = "pa" THEN DO:
              nv_pa = nv_pa + uwd132.prem_c.
              IF UWM100.PSTP <> 0 OR UWM100.RSTP_T <> 0 THEN DO:
                 ASSIGN  
                   N_STP       = (UWD132.PREM_C * 0.4) / 100
                   N_STPPA     = TRUNCATE(n_stp,0)
                   n_stptrunc  = n_stp - n_stppa.
                 IF    n_stptrunc    > 0 THEN n_stppa = n_stppa + 1.
                 ELSE  IF n_stptrunc < 0 THEN n_stppa = n_stppa - 1.
                 IF SUBSTR(uwm100.policy,1,1) = "I" THEN nv_pa_stp = 1.
                 ELSE nv_pa_stp   = nv_pa_stp + n_stppa.
                 ASSIGN  n_stppa     = 0   
                         n_stptrunc  = 0.
              END. /*RSTP_T <> 0*/
         END. /*BENCOD = PA*/
         IF SUBSTR(uwm100.policy,1,1) = "I" THEN 
            ASSIGN nv_vol_stp = 1
                   nv_stp     = nv_vol_stp + nv_comp_stp + nv_pa_stp.
         ELSE ASSIGN nv_vol_stp = (uwm100.pstp + uwm100.rstp_t ) - nv_pa_stp - nv_comp_stp
                   nv_stp = uwm100.rstp_t    + uwm100.pstp.  /* policy stamp */ 
         ASSIGN  
          nv_vol = uwm100.prem_t    - nv_comp   -   nv_pa
          tot_pa_stp = tot_pa_stp   + nv_pa_stp
          tot_comp_stp = tot_comp_stp + nv_comp_stp
          tot_vol_stp  = tot_vol_stp  + nv_vol_stp.
         
        /*Calculate VAT*/
        IF uwm100.rtax_t <> 0 THEN nv_pa_vat    = (nv_pa   + nv_pa_stp)   * uwm100.gstrat / 100.
        IF uwm100.rtax_t <> 0 THEN nv_comp_vat  = (nv_comp + nv_comp_stp) * uwm100.gstrat / 100.
        ASSIGN
         tot_vat_pa   = tot_vat_pa   + nv_pa_vat
         tot_vat_comp = tot_vat_comp + nv_comp_vat
         tot_vat_vol  = tot_vat_vol  + nv_vol_vat
         com_per = 0.
     FIND FIRST uwm120 NO-LOCK WHERE uwm120.policy = uwm100.policy
                                 AND uwm120.rencnt = uwm100.rencnt
                                 AND uwm120.endcnt = uwm100.endcnt
                                 AND uwm120.riskno = 1 NO-ERROR.
     IF  AVAIL uwm120 THEN DO:
         IF com_per =  0  THEN  com_per  =  uwm120.com1p.  
         ASSIGN com_pa  = TRUNCATE((nv_pa * uwm120.com1p / 100),0)
                com_pa  = com_pa * (-1).
     END.
     ASSIGN 
      com_vol  = uwm100.com1_t - com_pa
      com_comp = uwm100.com2_t
      tot_com_pa   = tot_com_pa    + com_pa
      tot_com_vol  = tot_com_vol   + com_vol
      tot_com_comp = tot_com_comp  + com_comp
      pol_prem = nv_vol  + nv_comp  + nv_pa    /* PREMIUM  */
      nv_comm  = com_vol + com_comp + com_pa.  /* COMMISSION */
     IF SUBSTR(acm001.policy,3,2) <> "60" AND SUBSTR(acm001.policy,3,2) <> "61" AND
        SUBSTR(acm001.policy,3,2) <> "62" AND SUBSTR(acm001.policy,3,2) <> "63" AND
        SUBSTR(acm001.policy,3,2) <> "64" AND SUBSTR(acm001.policy,3,2) <> "67" THEN  
        ASSIGN nv_vol_vat = uwm100.rtax_t - nv_pa_vat - nv_comp_vat
               nv_vat     = nv_vol_vat    + nv_pa_vat + nv_comp_vat
               nv_tot_vat = pol_prem      + nv_vat    + nv_stp
               nv_sbt     = 0
               nv_tot_sbt = 0.
     ELSE ASSIGN nv_vol_vat = 0
                 nv_vat     = 0
                 nv_tot_vat = 0
                 nv_sbt     = acm001.tax
                 nv_tot_sbt = pol_prem + nv_sbt + nv_stp.
  END.   /*Each uwd132*/
  /*---A51-0078---*/
  IF SUBSTR(acm001.policy,1,2) = "IY" AND acm001.acno = "0APTHAI" THEN 
     ASSIGN n_ri = YES
                /* n_poltyp = n_poltyp + "T".*/
                 n_poltyp = SUBSTR(acm001.policy,3,2) + "T".
  ELSE n_ri = NO.
  IF fi_reptyp = "2" THEN RUN pro_Nonmotor.
  /*-----------*/
 END.  /*--- End Non Motor ---*/ 
 /*-- PUT Data TO Excel --*/
 IF fi_reptyp = "1" THEN DO:
    OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.   
    RUN ChkLineExcel.
    /*IF nv_cnt = 0 THEN RUN DHeadTable. /*lukkana 24/03/2008 แสดงหัวรายงานใน record แรก*/*/
    
    EXPORT DELIMITER ";"
        n_bran      n_poltyp     n_policy      n_Rencnt    n_Endcnt   
        n_endno     n_comdat     n_Trndat      
            nv_vol      nv_comp      nv_pa         pol_prem      
        nv_vol_stp  nv_comp_stp  nv_pa_stp     nv_stp     
        nv_vol_vat  nv_comp_vat  nv_pa_vat     nv_vat      nv_tot_vat 
        nv_sbt      nv_tot_sbt   com_vol       com_comp    com_pa     
        nv_comm     n_prnvat. 
    OUTPUT CLOSE.
    nv_reccnt = nv_reccnt + 1.
        END. 
    ASSIGN 
     nsd_vol      = nsd_vol      + nv_vol
     nsd_comp     = nsd_comp     + nv_comp
     nsd_pa       = nsd_pa       + nv_pa
     nsd_pol_prem = nsd_pol_prem + pol_prem
     nsd_vol_stp  = nsd_vol_stp  + nv_vol_stp
     nsd_comp_stp = nsd_comp_stp + nv_comp_stp
     nsd_pa_stp   = nsd_pa_stp   + nv_pa_stp
     nsd_stp      = nsd_stp      + nv_stp
     nsd_vol_vat  = nsd_vol_vat  + nv_vol_vat       
     nsd_comp_vat = nsd_comp_vat + nv_comp_vat
     nsd_pa_vat   = nsd_pa_vat   + nv_pa_vat  
     nsd_vat      = nsd_vat      + nv_vat    
     nsd_tot_vat  = nsd_tot_vat  + nv_tot_vat
     nsd_sbt      = nsd_sbt      + nv_sbt      
     nsd_tot_sbt  = nsd_tot_sbt  + nv_tot_sbt
     nsd_com_vol  = nsd_com_vol  + com_vol 
     nsd_com_comp = nsd_com_comp + com_comp
     nsd_com_pa   = nsd_com_pa   + com_pa
     nsd_comm     = nsd_comm     + nv_comm .
    ASSIGN 
     nv_vol     = 0   nv_comp     = 0   nv_pa     = 0   pol_prem = 0     
     nv_vol_stp = 0   nv_comp_stp = 0   nv_pa_stp = 0   nv_stp   = 0      
     nv_vol_vat = 0   nv_comp_vat = 0   nv_pa_vat = 0   nv_vat   = 0   nv_tot_vat  = 0      
     nv_sbt     = 0   nv_tot_sbt  = 0             
     com_vol    = 0   com_comp    = 0   com_pa    = 0        
     nv_comm    = 0. 
    /*IF LAST-OF (SUBSTR(acm001.policy,2,1)) AND fi_reptyp = "1" THEN  RUN sumDetail. -A50-0178-*/
    IF LAST-OF (acm001.branch) AND fi_reptyp = "1" THEN  RUN sumDetail. /*--By Aom Sum Detail --*/
 END.  /*each acm001*/   
 IF fi_reptyp = "2" THEN DO:
    FOR EACH wfbyline 
    BREAK BY wfbran
          BY wfpoltyp
          BY wfdes
          BY wfseq:
    IF FIRST-OF (wfbran) OR nv_reccnt = 0 THEN DO:
       OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO.
       RUN SHeadTable. 
       OUTPUT CLOSE.
       nv_reccnt = nv_reccnt + 3.
    END.
    wfsum = (wfprem + wfstp + wfvat + wfsbt + wfcomm).
    OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO.   
    RUN ChkLineExcel.
    EXPORT DELIMITER ";"
        wfbran      wfpoltyp    wfdesc      wfprem    
        wfstp       wfvat       wfprvat     wfsbt     
        wfprsbt     wftotprm    wfcomm      wfsum.
    OUTPUT CLOSE.
    ASSIGN 
     jv_bran   = wfbran  /*-: Post JV -*/
     jv_desc   = wfdesc
     jv_prem   = wfprem
     jv_stp    = wfstp
     jv_vat    = wfvat
     jv_prvat  = wfprvat
     jv_sbt    = wfsbt
     jv_prsbt  = wfprsbt
     jv_comm   = wfcomm
     jv_sum    = wfsum
     jvg_comm  = jvg_comm + jv_comm
     jv_poltyp = SUBSTR(wfpoltyp,1,2).   /*A51-0078*/
    IF n_jv = YES THEN DO:
       
       /*A51-0078*/
       IF SUBSTR(wfpoltyp,LENGTH(wfpoltyp),1) = "T" THEN 
       ASSIGN n_ri = YES.
           ELSE n_ri = NO.
       
       RUN Pro_Fsacc.
       RUN Pro_Poltyp.
       RUN Pro_JV.     
        
    END.
    jv_comm = 0.
    /*-: Total Branch [+],[-] -*/
    n_desbr = "Total Branch: " + wfbran + "[" + SUBSTR(wfdesc,6,1) + "]".
    IF wfbran = SUBSTR(n_desbr,15,1) AND wfprem > 0 THEN DO:
       ASSIGN 
        np_prem   = np_prem   + wfprem  
        np_stp    = np_stp    + wfstp   
        np_vat    = np_vat    + wfvat   
        np_prvat  = np_prvat  + wfprvat
        np_sbt    = np_sbt    + wfsbt   
        np_prsbt  = np_prsbt  + wfprsbt
        np_totprm = np_totprm + wftotprm
        np_comm   = np_comm   + wfcomm  
        np_sum    = np_sum    + wfsum. 
    END.
    IF wfbran = SUBSTR(n_desbr,15,1) AND wfprem < 0 THEN DO:
       ASSIGN 
        ns_prem   = ns_prem   + wfprem  
        ns_stp    = ns_stp    + wfstp   
        ns_vat    = ns_vat    + wfvat   
        ns_prvat  = ns_prvat  + wfprvat
        ns_sbt    = ns_sbt    + wfsbt   
        ns_prsbt  = ns_prsbt  + wfprsbt
        ns_totprm = ns_totprm + wftotprm
        ns_comm   = ns_comm   + wfcomm  
        ns_sum    = ns_sum    + wfsum. 
    END.
    IF wfbran = substr(n_desbr,15,1) AND   /*-: GrandTotal of Branch -*/
       SUBSTR(wfdesc,6,1) = SUBSTR(n_desbr,17,1) THEN do: 
       ASSIGN 
        nb_prem   = nb_prem   + wfprem 
        nb_stp    = nb_stp    + wfstp 
        nb_vat    = nb_vat    + wfvat 
        nb_prvat  = nb_prvat  + wfprvat 
        nb_sbt    = nb_sbt    + wfsbt 
        nb_prsbt  = nb_prsbt  + wfprsbt 
        nb_totprm = nb_totprm + wftotprm
        nb_comm   = nb_comm   + wfcomm 
        nb_sum    = nb_sum    + wfsum.
        IF  LAST-OF (wfbran) THEN DO: 
            RUN pro_sumBr.
        END.
    END.
  END.  /* FOR EACH wfbyline */
 END. /* Report = Summary */
 fon A51-0078 22/08/2008---*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_Nonmotor C-Win 
PROCEDURE pro_Nonmotor :
/*------------------------------------------------------------------------------
  Purpose: Create Workfile For Non motor to Summary Report    
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF n_ri = YES THEN DO:       /*---Inward Treaty  A51-0078---*/
    IF acm001.prem  > 0 THEN  DO:
        FIND FIRST wfbyline WHERE wfpoltyp  = SUBSTR(acm001.policy,3,2)  + "T" AND   
                                  wfbran    = n_bran                           AND
                                  wfdesc    = "prem + "                        NO-ERROR.
        IF NOT AVAIL wfbyline THEN DO:
            CREATE wfbyline.
            ASSIGN
                wfpoltyp = SUBSTR(acm001.policy,3,2) + "T"
                wfbran   = n_bran
                wfdesc   = "prem + ".
        END.
        ASSIGN 
        wfprem    = wfprem + pol_prem
        /*---A63-0038---*/
        wfprmloc  = wfprmloc  + nv_prmloc 
        wfprmfor  = wfprmfor  + nv_prmfor 
        wfcommloc = wfcommloc + nv_commloc
        wfcommfor = wfcommfor + nv_commfor.
    END.
    ELSE DO:
        FIND FIRST wfbyline WHERE wfpoltyp  = SUBSTR(acm001.policy,3,2)  + "T"  AND
                                  wfbran    = n_bran    AND
                                  wfdesc    = "prem - " NO-ERROR. 
        IF NOT AVAILABLE wfbyline THEN DO:
            CREATE wfbyline.
            ASSIGN 
                wfpoltyp = SUBSTR(acm001.policy,3,2)  + "T" 
                wfbran   = n_bran
                wfdesc   = "prem - ". 
        END.
        ASSIGN 
            wfprem = wfprem + pol_prem
            /*---A63-0038---*/
           wfprmloc  = wfprmloc  + nv_prmloc 
           wfprmfor  = wfprmfor  + nv_prmfor 
           wfcommloc = wfcommloc + nv_commloc
           wfcommfor = wfcommfor + nv_commfor.
    END.
    ASSIGN wfstp      = wfstp + nv_stp
           wfcomm     = wfcomm   + nv_comm
           wfcommco   = wfcommco + com_volco /*A64-0361*/
           wffee      = wffee + nv_fee
           wfsumfee   = wfsumfee + nv_sumfee
           wfsumfeeco = wfsumfeeco + nv_sumfee_co. /*A64-0361*/
           
END.
ELSE DO:    /*Non Motor อื่นๆ*/
    IF acm001.prem  > 0 THEN  DO:
        FIND FIRST wfbyline WHERE wfpoltyp  = n_poltyp  AND
                                  wfbran    = n_bran    AND
                                  wfdesc    = "prem + " NO-ERROR. 
        IF NOT AVAILABLE wfbyline THEN DO:
            CREATE wfbyline.
            ASSIGN 
                wfpoltyp = SUBSTR(acm001.policy,3,2) 
                wfbran   = n_bran
                wfdesc   = "prem + ". 
        END.
        ASSIGN wfprem = wfprem + pol_prem
               /*---A63-0038---*/
           wfprmloc  = wfprmloc  + nv_prmloc 
           wfprmfor  = wfprmfor  + nv_prmfor 
           wfcommloc = wfcommloc + nv_commloc
           wfcommfor = wfcommfor + nv_commfor.

    END.   /* Prem > 0 */
    ELSE DO:
        FIND FIRST wfbyline WHERE wfpoltyp  = substr(acm001.policy,3,2)  AND
                                  wfbran    = n_bran  AND
                                  wfdesc    = "prem - " NO-ERROR. 
        IF NOT AVAILABLE wfbyline THEN DO:
            CREATE wfbyline.
            ASSIGN 
                wfpoltyp = SUBSTR(acm001.policy,3,2) 
                wfbran   = n_bran
                wfdesc   = "prem - ". 
        END.
        ASSIGN wfprem = wfprem + pol_prem
            /*---A63-0038---*/
           wfprmloc  = wfprmloc  + nv_prmloc 
           wfprmfor  = wfprmfor  + nv_prmfor 
           wfcommloc = wfcommloc + nv_commloc
           wfcommfor = wfcommfor + nv_commfor.
    END.
    ASSIGN wfstp  = wfstp + nv_stp
           wfcomm = wfcomm + nv_comm
           wfcommco   = wfcommco + com_volco /*A64-0361*/
           wffee = wffee + nv_fee
           wfsumfee = wfsumfee + nv_sumfee
           wfsumfeeco = wfsumfeeco + nv_sumfee_co. /*A64-0361*/
           

    IF n_poltyp <> "60" AND n_poltyp <> "61" AND
       n_poltyp <> "62" AND n_poltyp <> "63" AND
       n_poltyp <> "64" AND n_poltyp <> "67" /*AND 
       n_poltyp <> "68" AND n_poltyp <> "69" Lukkana M. A55-0372 13/12/2012*/ THEN  /*Lukkana M. A55-0345 08/11/2012 เช็คเพิ่มline 68,69*/ 
        ASSIGN wfvat   = wfvat  + nv_vat
               wfprvat = wfprem + wfvat + wfstp
               wfsbt   = 0. 
    ELSE ASSIGN wfsbt    = wfsbt  + nv_sbt
                wfprsbt  = wfprsbt + nv_tot_sbt
                wfvat    = 0.

    wftotprm = wfprvat + wfprsbt. /*By Aom*/
END.

n_ri = NO.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_Poltyp C-Win 
PROCEDURE Pro_Poltyp :
/*------------------------------------------------------------------------------
Purpose:   POST JV  ==>  n_poltyp <> 70    
Parameters:  <none>
Notes:  "41011000", "41011090", "51011000"     
------------------------------------------------------------------------------*/
/*  Modify BY :  Benjaporn J. A58-0358 date 18/09/2015 
              : ข้อมูล Line 45 เพิ่มเข้า Code  440xxxxx , 540xxxxx           
------------------------------------------------------------------------------*/ 
nv_macc = "".    /*add Saowapa U. A63-0038 27/02/2020*/
IF n_source  = "DI" THEN n_br# = "11".
ELSE DO:
   /*--A51-0078
   IF n_source = "IF" THEN n_br# = "21".
   --*/
   IF n_source = "IF" THEN DO:  
      IF n_ri = YES THEN n_br# = "31".
      ELSE ASSIGN n_br# = "21".
   END.
   
END.


/*------------Saowapa U. A63-0038 18/02/2020------
/*--- Add A49-0127 By Sayamol ---*/ 
IF jv_poltyp = "01" THEN 
   ASSIGN n_grp#    = "01"
          /*jvt_comm  = jvt_comm + jv_comm*/
          jvt_sumfee  = jvt_sumfee + jv_sumfee.

ELSE IF jv_poltyp = "04" THEN 
   ASSIGN n_grp#    = "04"
         /* jvt_comm  = jvt_comm + jv_comm*/
          jvt_sumfee  = jvt_sumfee + jv_sumfee.
/*--- End A49-0127 By Sayamol ---*/

/*ELSE IF jv_poltyp = "10" THEN  Lukkana M. A55-0304 27/09/2012*/
ELSE IF (jv_poltyp = "10" OR jv_poltyp = "17") THEN  /*Lukkana M. A55-0304 27/09/2012*/
   ASSIGN n_grp#    = "10"
         /* jvt_comm  = jvt_comm + jv_comm*/
          jvt_sumfee  = jvt_sumfee + jv_sumfee.

ELSE IF (jv_poltyp = "11"  OR  jv_poltyp = "12" OR
        jv_poltyp = "13")  THEN 
        ASSIGN n_grp#    = "11"
               /*jvt_comm  = jvt_comm + jv_comm*/
               jvt_sumfee  = jvt_sumfee + jv_sumfee.

/*--
ELSE IF (jv_poltyp = "14"  OR  jv_poltyp = "15" OR
         jv_poltyp = "16"  OR  jv_poltyp = "17" OR 
         jv_poltyp = "18"  OR  jv_poltyp = "19") THEN 
        ASSIGN n_grp#    = "14"
               /*jvt_comm  = jvt_comm + jv_comm*/
               jvt_sumfee  = jvt_sumfee + jv_sumfee.
Lukkana M. A55-0304 27/09/2012*/

/*Lukkana M. A55-0304 27/09/2012*/
ELSE IF jv_poltyp = "15" THEN 
        ASSIGN n_grp#    = "15"
               /*jvt_comm  = jvt_comm + jv_comm*/
               jvt_sumfee  = jvt_sumfee + jv_sumfee.

ELSE IF jv_poltyp = "16" THEN 
        ASSIGN n_grp#    = "16"
               /*jvt_comm  = jvt_comm + jv_comm*/
               jvt_sumfee  = jvt_sumfee + jv_sumfee.

ELSE IF jv_poltyp = "18" THEN 
        ASSIGN n_grp#    = "18"
               /*jvt_comm  = jvt_comm + jv_comm*/
               jvt_sumfee  = jvt_sumfee + jv_sumfee.

ELSE IF (jv_poltyp = "14"  OR  jv_poltyp = "19") THEN 
        ASSIGN n_grp#    = "14"
               /*jvt_comm  = jvt_comm + jv_comm*/
               jvt_sumfee  = jvt_sumfee + jv_sumfee.
/*Lukkana M. A55-0304 27/09/2012*/

ELSE IF (jv_poltyp = "20"  OR   jv_poltyp = "32" OR
         jv_poltyp = "33"  OR   jv_poltyp = "34" OR
         jv_poltyp = "35"  OR   jv_poltyp = "36" OR  
         jv_poltyp = "39") THEN 
         ASSIGN  n_grp#    = "20"
                 /*jvt_comm  = jvt_comm + jv_comm*/
                 jvt_sumfee  = jvt_sumfee + jv_sumfee.

/*--- Add A49-0127 By Sayamol ---*/
ELSE IF jv_poltyp = "30" THEN 
   ASSIGN n_grp#    = "30"
         /* jvt_comm  = jvt_comm + jv_comm*/
          jvt_sumfee  = jvt_sumfee + jv_sumfee.
/*--- End A49-0127 By Sayamol ---*/

ELSE IF (jv_poltyp = "21"  OR   jv_poltyp = "22" OR
         jv_poltyp = "23"  OR   jv_poltyp = "24" OR
         jv_poltyp = "37"  OR   jv_poltyp = "38" OR
         jv_poltyp = "02"  OR   jv_poltyp = "03" OR
         jv_poltyp = "05"  OR   jv_poltyp = "06" OR
         jv_poltyp = "07"  OR   jv_poltyp = "08" OR
         jv_poltyp = "09"  OR                   
         jv_poltyp = "50"  OR   jv_poltyp = "51" OR
         jv_poltyp = "52"  OR   jv_poltyp = "53" OR
         jv_poltyp = "54"  OR   jv_poltyp = "55" OR
         jv_poltyp = "56"  OR   jv_poltyp = "57" OR
         jv_poltyp = "58"  OR   jv_poltyp = "59") THEN 
         ASSIGN  n_grp#    = "50"
                /* jvt_comm  = jvt_comm + jv_comm*/
                 jvt_sumfee  = jvt_sumfee + jv_sumfee.
                 

ELSE IF (jv_poltyp = "40"  OR   jv_poltyp = "41" OR
         jv_poltyp = "43"  OR   jv_poltyp = "44" OR   /*Piyachat A52-0040 กำหนดใด้ Line 44 อยู่ในกรุ๊ป 40 */
         jv_poltyp = "45") THEN /* Benjaporn J. A58-0358 date 18/09/2015 */ 
         ASSIGN  n_grp#    = "40"
                /* jvt_comm  = jvt_comm + jv_comm*/
                 jvt_sumfee  = jvt_sumfee + jv_sumfee.

ELSE IF (jv_poltyp = "80"  OR   jv_poltyp = "81" OR
         jv_poltyp = "82"  OR   jv_poltyp = "83" OR
         jv_poltyp = "84"  OR   jv_poltyp = "85" OR
         jv_poltyp = "86") THEN 
         ASSIGN  n_grp#    = "80"
                /* jvt_comm  = jvt_comm + jv_comm.*/
                 jvt_sumfee  = jvt_sumfee + jv_sumfee.

ELSE IF (jv_poltyp = "65"  OR   jv_poltyp = "66") THEN 
         ASSIGN  n_grp#    = "65"
              /*  jvt_comm  = jvt_comm + jv_comm*/
                 jvt_sumfee  = jvt_sumfee + jv_sumfee.

ELSE IF (jv_poltyp = "61") THEN /*--Lukkana M. A54-0367 13/12/2011 แยกline 61 มาเป็นกรุ๊ปใหม่--*/
         ASSIGN  n_grp#    = "61"
                 jvt_sumfee  = jvt_sumfee + jv_sumfee.

ELSE IF (jv_poltyp = "60"  OR   /*jv_poltyp = "61" OR Lukkana M. A54-0367 13/12/2011*/
         jv_poltyp = "62"  OR   jv_poltyp = "63"  OR
         jv_poltyp = "64"  OR   jv_poltyp = "67" /* OR
         jv_poltyp = "68"  OR   jv_poltyp = "69" --- suthida T. A57-0079 ---- */ ) THEN  /*--Lukkana M. A54-0367 13/12/2011 เพิ่ม line 69--*/
         ASSIGN  n_grp#    = "60"
                /* jvt_comm  = jvt_comm + jv_comm*/
                 jvt_sumfee  = jvt_sumfee + jv_sumfee.

ELSE IF (jv_poltyp = "31"  OR   jv_poltyp = "90" OR
         jv_poltyp = "92"  OR   jv_poltyp = "93" OR   
         jv_poltyp = "94"  OR   jv_poltyp = "95" OR   
         jv_poltyp = "96"  OR   jv_poltyp = "97" OR   
         jv_poltyp = "98"  OR   jv_poltyp = "99") THEN 
         ASSIGN  n_grp#    = "90"
               /*  jvt_comm  = jvt_comm + jv_comm*/
                 jvt_sumfee  = jvt_sumfee + jv_sumfee.

ELSE IF  jv_poltyp = "91"  THEN 
         ASSIGN  n_grp#    = "91"
              /*   jvt_comm  = jvt_comm + jv_comm*/
                 jvt_sumfee  = jvt_sumfee + jv_sumfee.

ELSE IF  jv_poltyp = "70"  OR   jv_poltyp = "70PA" THEN 
         ASSIGN  n_grp#    = "70"
                /* jvt_comm  = jvt_comm + jv_comm*/
                 jvt_sumfee  = jvt_sumfee + jv_sumfee.

ELSE IF  jv_poltyp = "71"  THEN 
         ASSIGN  n_grp#    = "71"
              /*   jvt_comm  = jvt_comm + jv_comm.*/
                 jvt_sumfee  = jvt_sumfee + jv_sumfee.

ELSE IF  jv_poltyp = "72"  THEN 
         ASSIGN  n_grp#    = "72"
              /*   jvt_comm  = jvt_comm + jv_comm*/
                 jvt_sumfee  = jvt_sumfee + jv_sumfee.

ELSE IF  jv_poltyp = "73"  THEN 
         ASSIGN  n_grp#    = "73"
             /*    jvt_comm  = jvt_comm + jv_comm*/
                 jvt_sumfee  = jvt_sumfee + jv_sumfee.

ELSE IF  jv_poltyp = "74"  THEN 
         ASSIGN  n_grp#    = "74"
              /*   jvt_comm  = jvt_comm + jv_comm*/
                 jvt_sumfee  = jvt_sumfee + jv_sumfee.
/*----------- suthida T. A57-0099 ------------------*/
ELSE IF  jv_poltyp = "68"  OR jv_poltyp = "69"  THEN 
         ASSIGN  n_grp#    = "68"
              /*   jvt_comm  = jvt_comm + jv_comm*/
                 jvt_sumfee  = jvt_sumfee + jv_sumfee.
/*----------- suthida T. A57-0099 ------------------*/

ELSE ASSIGN n_grp#   = jv_poltyp
          /*  jvt_comm = jvt_comm + jv_comm*/
             jvt_sumfee = jvt_sumfee + jv_sumfee.
-----------------*/    

/*Add Saowapa U. A63-0038 18/02/2020*/
FIND FIRST cvm008 NO-LOCK WHERE cvm008.poltyp = jv_poltyp   NO-ERROR.
IF AVAIL cvm008 THEN DO:
    n_grp#  = cvm008.codeac.
END.
ELSE DO:
    n_grp#  = jv_poltyp.
END.

jvt_sumfee  = jvt_sumfee + jv_sumfee.

/*ELSE jvn_prem = jv_prem.*/
/*END Saowapa U. A63-0038 18/02/2020*/


IF SUBSTR(jv_desc,6,1) = "+" THEN DO: 
    n_macc  = n_p# + n_grp# + n_br# + n_pp.  /* เช่น 4LL11000 [Prem +] */
    RUN wac/wacazr (INPUT jv_prem, jv_bran,2, 
                    n_macc, n_sacc1, n_sacc2, n_gldat, n_source).
END.

ELSE IF SUBSTR(jv_desc,6,1) = "-" THEN DO:
    n_macc  = n_p# + n_grp# + n_br# + n_pe.   /* ---เช่น 4LL11090 [Prem -] -- */
    RUN wac/wacazr (INPUT jv_prem, jv_bran,2, 
                    n_macc, n_sacc1, n_sacc2, n_gldat, n_source).
END.
   
n_macc  = n_c# + n_grp#  + n_br# + n_c4.  /* เช่น 5XX11000 */
/* RUN wac/wacazr (INPUT jv_comm, jv_bran,1,*/
RUN wac/wacazr (INPUT jv_sumfee, jv_bran,1,
               n_macc,n_sacc1, n_sacc2, n_gldat, n_source).



    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_sumBr C-Win 
PROCEDURE pro_sumBr :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF LENGTH(jv_bran) = 1  THEN DO: /*เช็คbranch 1 หลัก Lukkana M. A55-0345 07/11/2012 เช็คbrnchเพิ่ม*/
    OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO.  
    RUN ChkLineExcel.
    EXPORT DELIMITER ";"
        "Total Branch: " + SUBSTRI(n_desbr,15,1) + " [+]"      
        " "         " "          np_prem      
        np_stp      np_vat       np_prvat     np_sbt     
        np_prsbt    np_totprm    np_comm    np_fee np_sumfee  np_sum
        /*A63-0038*/
        np_prmloc   np_prmfor    np_commloc  np_commfor.
    OUTPUT CLOSE.

    OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO.   
    RUN ChkLineExcel.
    EXPORT DELIMITER ";"
        "Total Branch: " + SUBSTRI(n_desbr,15,1) + " [-]"      
        " "          " "              ns_prem    
        ns_stp       ns_vat           ns_prvat         ns_sbt     
        ns_prsbt     ns_totprm        ns_comm     ns_fee   ns_sumfee  ns_sum   
        /*A63-0038*/
        ns_prmloc   ns_prmfor    ns_commloc  ns_commfor.
    OUTPUT CLOSE.
END.
ELSE DO: /*branch 2 หลัก Lukkana M. A55-0345 07/11/2012*/
    OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO.  
    RUN ChkLineExcel.
    EXPORT DELIMITER ";"
        "Total Branch: " + SUBSTRI(n_desbr,15,2) + " [+]"  
        " "         " "          np_prem      
        np_stp      np_vat       np_prvat     np_sbt     
        np_prsbt    np_totprm    np_comm    np_fee np_sumfee  np_sum
        /*A63-0038*/
        np_prmloc   np_prmfor    np_commloc  np_commfor.
    OUTPUT CLOSE.

    OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO.   
    RUN ChkLineExcel.
    EXPORT DELIMITER ";"
        "Total Branch: " + SUBSTRI(n_desbr,15,2) + " [-]" 
        " "          " "              ns_prem    
        ns_stp       ns_vat           ns_prvat         ns_sbt     
        ns_prsbt     ns_totprm        ns_comm     ns_fee   ns_sumfee  ns_sum  
        /*A63-0038*/
        ns_prmloc   ns_prmfor    ns_commloc  ns_commfor.
    OUTPUT CLOSE.
END.

    ASSIGN  np_prem = 0  np_stp   = 0  np_vat    = 0  np_prvat = 0   
            np_sbt  = 0  np_prsbt = 0  np_totprm = 0  np_comm  = 0  np_sum   = 0  
            np_fee   = 0  np_sumfee   = 0 
            /*A63-0038*/
            np_prmloc = 0   np_prmfor = 0    np_commloc = 0  np_commfor = 0
            ns_prem = 0  ns_stp   = 0  ns_vat    = 0  ns_prvat = 0  
            ns_sbt  = 0  ns_prsbt = 0  ns_totprm = 0  ns_comm  = 0  ns_sum   = 0
            ns_fee   = 0   ns_sumfee   = 0
            /*A63-0038*/
            ns_prmloc = 0   ns_prmfor = 0   ns_commloc = 0  ns_commfor = 0
            nv_macc = ""  nv_macc20 = "".  /*Saowapa u. A63-0038 26/02/2020*/

    IF n_jv = YES THEN DO: 
       IF n_source = "DI" THEN DO:
          
          totsumpa = nb_prvat - sumpa.
       
          /*--- Comment By A49-0127 Sayamol
          RUN wac/wacazr (INPUT (-1) * sumpa, jv_bran, 2, "10400074",
                                n_sacc1, n_sacc2, n_gldat, n_source).
          End Modify A49-0127 ---*/

          /********* FFFFFFFFFFFFF**************/
          /*---ADD Saowapa u. A63-0038 26/02/2020----
          FIND FIRST cvm008 NO-LOCK WHERE cvm008.poltyp = jv_poltyp NO-ERROR.
          IF AVAIL cvm008 THEN DO:
              nv_macc = "104000" + cvm008.codeac.   /*----104000LL---*/
              nv_macc20 = "204000" + cvm008.codeac.   /*----204000LL---*/
          END.
          /*---END Saowapa u. A63-0038 26/02/2020----*/
          /*-----Saowapa u. A63-0038 26/02/2020----
          /*--- Modify By A49-0148 Sayamol---*/
          RUN wac/wacazr (INPUT (-1) * (totsumpa + sumpa), jv_bran, 2, "10400073", 
                                n_sacc1, n_sacc2, n_gldat, n_source).
          /*--- End Modify A49-0148 ---*/
          -----Saowapa u. A63-0038 26/02/2020*/
          /*---ADD Saowapa u. A63-0038 26/02/2020----*/
          RUN wac/wacazr (INPUT (-1) * (totsumpa + sumpa), jv_bran, 2, nv_macc, 
                                n_sacc1, "", n_gldat, n_source).
          /*---End Saowapa u. A63-0038 26/02/2020----*/
          

          /*RUN wac/wacazr (INPUT (-1) * jvg_comm, jv_bran, 1, "20400077", */
          /*---Saowapa U. A63-0038 26/02/2020----
           RUN wac/wacazr (INPUT (-1) * jvg_sumfee, jv_bran, 1, "20400077", 
                                n_sacc1, n_sacc2, n_gldat, n_source).
          -------*/
          /*---ADD Saowapa u. A63-0038 26/02/2020----*/
          RUN wac/wacazr (INPUT (-1) * jvg_sumfee, jv_bran, 1, nv_macc20, 
                                n_sacc1, "", n_gldat, n_source).
          /*---End Saowapa u. A63-0038 26/02/2020----*/
        ************* FFFFFFFFFFFFF ************/
       END.
       ELSE IF n_source = "IF" THEN DO:
          /*IF n_ri = YES THEN fon 08/09/2008 A51-0078*/
           /*--
          RUN wac/wacazr (INPUT (-1) * jv_summ, jv_bran, 1, "10510000", 
                                n_sacc1, n_sacc2, n_gldat, n_source). 
          Lukkana M. A55-0304 01/10/2012--*/
       END.
          
    END.

    IF LENGTH(jv_bran) = 1  THEN DO: /*เช็คbranch 1 หลัก Lukkana M. A55-0345 07/11/2012 เช็คbrnchเพิ่ม*/
       OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO.   
       RUN ChkLineExcel.
       EXPORT DELIMITER ";"
           "GrandTotal of Branch:" + SUBSTRI(n_desbr,15,1)      
           " "          " "              nb_prem    
           nb_stp       nb_vat           nb_prvat         nb_sbt     
           nb_prsbt     nb_totprm        nb_comm          
           nb_fee      nb_sumfee         nb_sum
           /*A63-0038*/
          nb_prmloc   nb_prmfor    nb_commloc  nb_commfor.
       OUTPUT CLOSE.
    END.
    ELSE DO: /* branch 2 หลัก Lukkana M. A55-0345 07/11/2012*/
       OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO.   
       RUN ChkLineExcel.
       EXPORT DELIMITER ";"
           "GrandTotal of Branch:" + SUBSTRI(n_desbr,15,2) 
           " "          " "              nb_prem    
           nb_stp       nb_vat           nb_prvat         nb_sbt     
           nb_prsbt     nb_totprm        nb_comm          
           nb_fee      nb_sumfee         nb_sum
           /*A63-0038*/
           nb_prmloc   nb_prmfor    nb_commloc  nb_commfor.
       OUTPUT CLOSE.
    END.

       ASSIGN nb_prem = 0  nb_stp   = 0  nb_vat    = 0  nb_prvat = 0  
              nb_sbt  = 0  nb_prsbt = 0  nb_totprm = 0  nb_comm  = 0  
              nb_fee  = 0   nb_sumfee  = 0 
              /*A63-0038*/
              nb_prmloc = 0   nb_prmfor = 0   nb_commloc = 0  nb_commfor = 0
              nb_sum  = 0  jvg_comm = 0  jv_summ   = 0  jv_tsumm = 0
              sumpa   = 0   jvg_sumfee = 0.
              
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE SHeadTable C-Win 
PROCEDURE SHeadTable :
/*------------------------------------------------------------------------------
Purpose:    Print Head Table in Summary Excel File 
Parameters:  <none>
Notes:       
------------------------------------------------------------------------------*/
EXPORT DELIMITER ";" 
    n_HSln1.
EXPORT DELIMITER ";"
    "BRANCH "       
    "POL.TYPE  "    
    "DESC.  "       
    "PREM "         
    "STAMP "        
    "VAT "          
    "TOT.PREM-VAT " 
    "SBT "          
    "TOT.PREM-SBT " 
    "TOT.PREM "    
    "COMM " 
    "R/I DISC."
    "TOT COMM."
    "NETAMT "
    /*---A63-0038--*/
    "PRM.LOC"
    "PRM.FOR"
    "COMM.LOC"
    "COMM.FOR"
    "COMM CO."
    "TOT COMM. COMM DISC. COMM CO.".
EXPORT DELIMITER ";"
    n_HSln2.  

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE sumDetail C-Win 
PROCEDURE sumDetail :
/*------------------------------------------------------------------------------
  Purpose:  Summary of Detail File By Branch   
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    n_txtbr = "Total Branch : " + n_bran .
    nv_row = nv_row + 1.
    RUN ChkLineExcel.
    OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
    RUN DSDetTable.

    EXPORT DELIMITER ";"
    n_txtbr         " "             " "                 " "
    " "             " "             " "                 " "           nsd_vol         
    nsd_comp        nsd_pa          nsd_pol_prem        nsd_vol_stp     
    nsd_comp_stp    nsd_pa_stp      nsd_stp             nsd_vol_vat     
    nsd_comp_vat    nsd_pa_vat      nsd_vat             nsd_tot_vat     
    nsd_sbt         nsd_tot_sbt     nsd_com_vol         nsd_com_comp    
    nsd_com_pa      nsd_comm        nsd_fee             nsd_sumfee   " " " "
    nsd_prmloc      nsd_prmfor      nsd_commloc  nsd_commfor.  /*---A63-0038---*/
    OUTPUT CLOSE.
    nv_reccnt = nv_reccnt + 2.

    ASSIGN   nsd_vol        = 0     nsd_comp     = 0     nsd_pa         = 0
             nsd_pol_prem   = 0     nsd_vol_stp  = 0     nsd_comp_stp   = 0
             nsd_pa_stp     = 0     nsd_stp      = 0     nsd_vol_vat    = 0
             nsd_comp_vat   = 0     nsd_pa_vat   = 0     nsd_vat        = 0
             nsd_tot_vat    = 0     nsd_sbt      = 0     nsd_tot_sbt    = 0     
             nsd_com_vol    = 0     nsd_com_comp = 0    nsd_com_pa      = 0     
             nsd_comm       = 0     nsd_fee = 0       nsd_sumfee = 0
             nsd_prmloc = 0 nsd_prmfor = 0 nsd_commloc = 0 nsd_commfor = 0.   /*---A63-0038---*/
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

