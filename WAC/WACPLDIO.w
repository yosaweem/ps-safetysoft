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
/* PROGRAMID       : WACPLDIO.W Premium By Line To Excel (D/I/O)                                     */                          
/* Copyright       : Safety Insurance Public Company Limited            */  
/*                   บริษัท ประกันคุ้มภัย จำกัด (มหาชน)                 */  
/* DUPLICATE From :  wacprln.W                                          */  
/* CREATE BY      : Suthida T.   ASSIGN A530326  DATE 18/10/2010        */  
/***********************************************************************
   Modify BY      : Suthida T. A540223 DATE 01-08-2011
                    -> แก้ไขให้งาน FAC และ TREATY แสดงเครื่องหมายในไฟล์
                       ตามข้อมูลในระบบ
                    -> แก้ไขให้สามารถคำนวนยอด Allocate premium 
                       ตามข้อมูลในระบบ

***********************************************************************/  
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
DEF VAR n_stp        LIKE uwm100.rstp_t FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_stptrunc   LIKE uwm100.rstp_t FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_stpcom     LIKE uwm100.rstp_t FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_stppa      LIKE uwm100.rstp_t FORMAT "->>,>>>,>>>,>>9.99".
DEF WORKFILE wfbyline
    FIELD wfseq    AS CHAR FORMAT "X(02)"
    FIELD wfpoltyp AS CHAR FORMAT "X(05)"
    FIELD wfbran   AS CHAR FORMAT "X(02)"
    FIELD wfdesc   AS CHAR FORMAT "X(15)"    
    FIELD wfprem   LIKE UWD132.PREM_C FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfstp    LIKE UWD132.PREM_C FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfvat    LIKE UWD132.PREM_C FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfprvat  AS DEC FORMAT "->>>,>>>,>>>,>>9.99"   /*By Aom*/
    FIELD wfsbt    LIKE UWD132.PREM_C FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfprsbt  AS DEC FORMAT "->>>,>>>,>>>,>>9.99"   /*By Aom*/
    FIELD wftotprm AS DEC FORMAT "->>>,>>>,>>>,>>9.99"   /*By Aom*/
    FIELD wfcomm   LIKE UWD132.PREM_C FORMAT "->>,>>>,>>9.99"
    FIELD wffee    LIKE UWM120.RFEE_R FORMAT "->>,>>>,>>9.99"  /*A53-0020*/
    FIELD wfsum    AS DEC FORMAT "->>>,>>>,>>>,>>9.99"
    FIELD wfsumfee AS DEC FORMAT "->>>,>>>,>>>,>>9.99"   /*A53-0020*/
    FIELD wfretc   AS DEC FORMAT "->>>,>>>,>>>,>>9.99"  
    FIELD w0tc     AS DEC FORMAT "->>>,>>>,>>>,>>9.99" 
    FIELD w0sc     AS DEC FORMAT "->>>,>>>,>>>,>>9.99" 
    FIELD wstatc   AS DEC FORMAT "->>>,>>>,>>>,>>9.99" 
    FIELD w0rqc    AS DEC FORMAT "->>>,>>>,>>>,>>9.99" 
    FIELD wf1c     AS DEC FORMAT "->>>,>>>,>>>,>>9.99" 
    FIELD wf2c     AS DEC FORMAT "->>>,>>>,>>>,>>9.99" 
    FIELD w0psc    AS DEC FORMAT "->>>,>>>,>>>,>>9.99" 
    FIELD wbtrc    AS DEC FORMAT "->>>,>>>,>>>,>>9.99" 
    FIELD wotrc    AS DEC FORMAT "->>>,>>>,>>>,>>9.99" 
    FIELD wf3c     AS DEC FORMAT "->>>,>>>,>>>,>>9.99" 
    FIELD wf4c     AS DEC FORMAT "->>>,>>>,>>>,>>9.99" 
    FIELD wftrc    AS DEC FORMAT "->>>,>>>,>>>,>>9.99" 
    FIELD w0qc     AS DEC FORMAT "->>>,>>>,>>>,>>9.99" 
    FIELD ws8c     AS DEC FORMAT "->>>,>>>,>>>,>>9.99" 
    FIELD w0Dc     AS DEC FORMAT "->>>,>>>,>>>,>>9.99" 
    FIELD w0Ac     AS DEC FORMAT "->>>,>>>,>>>,>>9.99" 
    FIELD w0Fc     AS DEC FORMAT "->>>,>>>,>>>,>>9.99" 
    FIELD wfretp   AS DEC FORMAT "->>>,>>>,>>>,>>9.99"
    FIELD w0tp     AS DEC FORMAT "->>>,>>>,>>>,>>9.99" 
    FIELD w0sp     AS DEC FORMAT "->>>,>>>,>>>,>>9.99" 
    FIELD wstatp   AS DEC FORMAT "->>>,>>>,>>>,>>9.99" 
    FIELD w0rqp    AS DEC FORMAT "->>>,>>>,>>>,>>9.99" 
    FIELD wf1p     AS DEC FORMAT "->>>,>>>,>>>,>>9.99" 
    FIELD wf2p     AS DEC FORMAT "->>>,>>>,>>>,>>9.99" 
    FIELD w0psp    AS DEC FORMAT "->>>,>>>,>>>,>>9.99" 
    FIELD wbtrp    AS DEC FORMAT "->>>,>>>,>>>,>>9.99" 
    FIELD wotrp    AS DEC FORMAT "->>>,>>>,>>>,>>9.99" 
    FIELD wf3p     AS DEC FORMAT "->>>,>>>,>>>,>>9.99" 
    FIELD wf4p     AS DEC FORMAT "->>>,>>>,>>>,>>9.99" 
    FIELD wftrp    AS DEC FORMAT "->>>,>>>,>>>,>>9.99" 
    FIELD w0qp     AS DEC FORMAT "->>>,>>>,>>>,>>9.99" 
    FIELD ws8p     AS DEC FORMAT "->>>,>>>,>>>,>>9.99" 
    FIELD w0Dp     AS DEC FORMAT "->>>,>>>,>>>,>>9.99" 
    FIELD w0Ap     AS DEC FORMAT "->>>,>>>,>>>,>>9.99" 
    FIELD w0Fp     AS DEC FORMAT "->>>,>>>,>>>,>>9.99". 

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
DEF VAR nsd_fee      LIKE uwm100.rfee_t FORMAT "->>,>>>,>>>,>>9.99". /*nv_fee*/   /*A53-0020*/
DEF VAR nsd_sumfee   LIKE uwm100.rfee_t FORMAT "->>,>>>,>>>,>>9.99". /*nv_sumfee*/   /*A53-0020*/

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

DEF NEW SHARED VAR jv_bran   AS CHAR FORMAT "x(2)".
DEF NEW SHARED VAR jv_poltyp AS CHAR FORMAT "X(2)".
DEF NEW SHARED VAR jv_desc   AS CHAR FORMAT "x(15)".
DEF NEW SHARED VAR jv_prem   LIKE UWD132.PREM_C.                   
DEF NEW SHARED VAR jv_stp    LIKE UWD132.PREM_C.                   
DEF NEW SHARED VAR jv_vat    LIKE UWD132.PREM_C.                   
DEF NEW SHARED VAR jv_prvat  AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF NEW SHARED VAR jv_sbt    LIKE UWD132.PREM_C.                   
DEF NEW SHARED VAR jv_prsbt  AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF NEW SHARED VAR jv_comm   LIKE UWD132.PREM_C.                   
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
DEF VAR n_endno    AS CHAR  FORMAT "X(8)". 
DEF VAR n_trndat LIKE acm001.trndat FORMAT "99/99/9999" .
DEF VAR n_com2p  LIKE uwm120.com2p  FORMAT ">9".
DEF VAR n_prnvat   AS CHAR  FORMAT "X(1)".
DEF VAR n_comdat   AS DATE FORMAT "99/99/9999".
DEF VAR n_count    AS INTEGER. 

DEF VAR n_ri       AS LOGICAL. /*--Yes = InwTreaty, No = InwFAC.--A51-0078--*/

DEF VAR  n_name1   AS  CHAR    FORMAT "X(70)".     /*A51-0261*/
/* ------------- suthida T. A540223 01-08-11 ----------------- */
DEF     VAR nv_brdes        AS  CHARACTER FORMAT "X(200)". 
DEF     VAR nv_brdes1       AS  CHARACTER FORMAT "X(200)".
DEF     VAR nv_br           AS  CHAR      INIT "" .

{WAC\WACPLDIO.I}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
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

DEFINE VARIABLE fi_source-2 AS CHARACTER FORMAT "X(2)":U 
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
     SIZE 67 BY 12.86
     BGCOLOR 3 FGCOLOR 15 .

DEFINE RECTANGLE RECT-18
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 56 BY 3.1.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 72.67 BY 17.91.

DEFINE FRAME fr_prem
     fi_datfr AT ROW 1.95 COL 23.5 COLON-ALIGNED NO-LABEL
     fi_datto AT ROW 1.95 COL 47 COLON-ALIGNED NO-LABEL
     fi_frbrn AT ROW 3.38 COL 23.5 COLON-ALIGNED NO-LABEL
     fi_tobrn AT ROW 3.38 COL 47.17 COLON-ALIGNED NO-LABEL
     fi_reptyp AT ROW 4.81 COL 23.33 COLON-ALIGNED NO-LABEL
     fi_source-2 AT ROW 6.33 COL 23 COLON-ALIGNED NO-LABEL
     fi_jv AT ROW 8.1 COL 23.5 COLON-ALIGNED NO-LABEL
     fi_source AT ROW 11.1 COL 23.33 COLON-ALIGNED NO-LABEL
     fi_output AT ROW 12.33 COL 23.33 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 14.57 COL 16
     bu_exit AT ROW 14.57 COL 36.33
     bu_clear AT ROW 12.24 COL 53.67
     fi_gldat AT ROW 9.38 COL 23.5 COLON-ALIGNED NO-LABEL
     fi_sourcedes AT ROW 11.24 COL 30.5 COLON-ALIGNED NO-LABEL
     fi_outputdesc AT ROW 13.48 COL 1 COLON-ALIGNED NO-LABEL
     "To:" VIEW-AS TEXT
          SIZE 4 BY 1.05 AT ROW 1.95 COL 43.5
          BGCOLOR 3 FGCOLOR 15 FONT 36
     "Trans Date From:" VIEW-AS TEXT
          SIZE 20.5 BY 1.05 AT ROW 1.95 COL 4
          BGCOLOR 3 FGCOLOR 15 FONT 36
     "Output to File:" VIEW-AS TEXT
          SIZE 16.5 BY 1.05 AT ROW 12.33 COL 7.5
          BGCOLOR 3 FGCOLOR 15 FONT 36
     "POST JV:" VIEW-AS TEXT
          SIZE 12 BY 1.19 AT ROW 7.95 COL 12.5
          BGCOLOR 3 FGCOLOR 15 FONT 36
     "TYPE :" VIEW-AS TEXT
          SIZE 8.5 BY 1.19 AT ROW 6.24 COL 15.5
          BGCOLOR 3 FGCOLOR 15 FONT 36
     "1 = Motor,2 = Non-Motor,3 = All" VIEW-AS TEXT
          SIZE 36.5 BY 1.05 AT ROW 6.24 COL 31.5
          BGCOLOR 3 FGCOLOR 7 FONT 36
     "GL DATE:" VIEW-AS TEXT
          SIZE 12 BY 1.19 AT ROW 9.19 COL 12.17
          BGCOLOR 3 FGCOLOR 15 FONT 36
     "SOURCE:" VIEW-AS TEXT
          SIZE 12 BY 1.19 AT ROW 11 COL 12.33
          BGCOLOR 3 FGCOLOR 15 FONT 36
     "Branch From:" VIEW-AS TEXT
          SIZE 15.5 BY 1.05 AT ROW 3.38 COL 9
          BGCOLOR 3 FGCOLOR 15 FONT 36
     "To:" VIEW-AS TEXT
          SIZE 4 BY 1.05 AT ROW 3.38 COL 43.67
          BGCOLOR 3 FGCOLOR 15 FONT 36
     "Report Type:" VIEW-AS TEXT
          SIZE 16 BY 1.05 AT ROW 4.81 COL 8.33
          BGCOLOR 3 FGCOLOR 15 FONT 36
     "1 = Details ,  2 = Summary" VIEW-AS TEXT
          SIZE 32.5 BY 1.05 AT ROW 4.81 COL 31.5
          BGCOLOR 3 FGCOLOR 7 FONT 36
     RECT-17 AT ROW 1.48 COL 2
     RECT-18 AT ROW 7.67 COL 6
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 2.5 ROW 1.33
         SIZE 70 BY 16.33
         BGCOLOR 8 FGCOLOR 2 FONT 6
         TITLE BGCOLOR 15 FGCOLOR 1 "Premium By Line To Excel (D/I/O)".


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
         HEIGHT             = 16.86
         WIDTH              = 72.83
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
                                                                        */
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

    RUN Proc_crsumd.   /* ---- clear data ----- */
    RUN proc_clear.    /* ---- clear data ----- */

    IF n_jv = YES THEN DO:  /* ---- Post JV ----- */
       RUN DelAZR516.
       /*RUN pro_NewDetails.*/
       IF n_source = "DI" THEN RUN Proc_NewDetailsD.
       ELSE IF n_source = "IF" THEN RUN Proc_NewDetailsL.
       RUN PrnJV.
    END.
    ELSE DO: 
        /*RUN pro_NewDetails.*/
        IF n_source = "DI" THEN RUN Proc_NewDetailsD.
        ELSE IF n_source = "IF" THEN RUN Proc_NewDetailsL.
    END.

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

    RUN Proc_crsumd.   /* ---- clear data ----- */
    RUN proc_clear.    /* ---- clear data ----- */

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
 
  IF INPUT fi_reptyp = "1" THEN DO:
     ASSIGN  fi_jv        = NO
             fi_gldat     = ?
             fi_source-2  = "1".
     DISABLE fi_jv    WITH FRAME {&FRAME-NAME}.
     DISABLE fi_gldat WITH FRAME {&FRAME-NAME}.
     DISP    fi_jv    fi_gldat   fi_source-2  fi_source  WITH FRAME {&FRAME-NAME}.
     APPLY "ENTRY" TO fi_source-2.
     RETURN NO-APPLY.
  END.
  ELSE IF INPUT fi_reptyp = "2" THEN DO:
      
      ENABLE fi_jv WITH FRAME {&FRAME-NAME}.
      
      ASSIGN  fi_jv       = YES
              fi_gldat    = to_trndat
              fi_source-2 =  "3" .

      DISP fi_reptyp fi_jv fi_gldat  fi_source-2 WITH FRAME fr_prem.
      APPLY "ENTRY" TO fi_source-2.
      RETURN NO-APPLY.
  END.

  IF fi_reptyp <> "1"  AND fi_reptyp <> "2" THEN DO:
     MESSAGE "Mandatory to Report Type."
     VIEW-AS ALERT-BOX INFORMATION.
  END.   
  DISP fi_reptyp fi_jv fi_gldat  fi_source-2 WITH FRAME fr_prem.
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


&Scoped-define SELF-NAME fi_source-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_source-2 C-Win
ON ENTRY OF fi_source-2 IN FRAME fr_prem
DO:
  VIEW fi_outputdesc.
  fi_outputdesc = "[DI: Direct]  OR  [IF: Inward]".
  DISP fi_outputdesc WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_source-2 C-Win
ON LEAVE OF fi_source-2 IN FRAME fr_prem
DO:
 
  ASSIGN fi_source-2 = INPUT fi_source-2.
  DISP   fi_source-2  WITH FRAME {&FRAME-NAME}.
  
  IF (fi_source-2 <> "1" OR  fi_source-2 <> "2"  ) AND fi_source-2 =  "" THEN 
     MESSAGE "กรุณาระบุเป็น Type 1 หรือ 2 ค่ะ" VIEW-AS ALERT-BOX INFORMATION.
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
  gv_prgid = "WACPLDIO".
  gv_prog  = "Summary Premium by Line To Excel".
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).
/*********************************************************************/ 
  RUN  WUT\WUTWICEN (c-win:handle).
  Session:data-Entry-Return = Yes.

  ASSIGN  n_frdate    = TODAY
          n_todate    = TODAY
          n_frbr      = "0"
          n_tobr      = "Z"
          n_report    = "1"
          fi_source-2 = "1"
          n_jv        = YES.

  DISP n_frdate @ fi_datfr    WITH FRAME fr_prem.
  DISP n_todate @ fi_datto    WITH FRAME fr_prem.
  DISP n_frbr   @ fi_frbrn    WITH FRAME fr_prem.
  DISP n_tobr   @ fi_tobrn    WITH FRAME fr_prem.
  DISP n_report @ fi_reptyp   WITH FRAME fr_prem.
  DISP n_jv     @ fi_jv       WITH FRAME fr_prem.
  DISP            fi_source-2 WITH FRAME fr_prem.

  APPLY "Entry" TO fi_datfr .

  ASSIGN fi_datfr    = TODAY
         fi_datto    = TODAY
         fi_frbrn    = "0"
         fi_tobrn    = "Z"
         fi_reptyp   = "1"
         fi_source-2 = "1"
         fi_jv       = YES.

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
DEF VAR cntop AS INT.

IF nv_reccnt > 65000 THEN  DO:

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
    "BRANCH "                      /*1*/  
    "POL.LINE "                    /*2*/  
    "POLICY "                      /*3*/  
    "RENCNT "                      /*4*/  
    "ENDCNT "                      /*5*/  
    "ENDT.NO. "                    /*6*/  
    "COM.DATE"                     /*7*/  
    "TRANS.DATE "                  /*8*/  
    "PREMIUM "                     /*9*/  
    "COMPULSORY "                  /*10*/ 
    "PA "                          /*11*/ 
    "TOT.PREMIUM "                 /*12*/ 
    "STAMP "                       /*13*/ 
    "STAMP COMPULSORY "            /*14*/ 
    "STAMP PA "                    /*15*/ 
    "TOT.STAMP "                   /*16*/ 
    "VAT "                         /*17*/ 
    "VAT COMPULSORY "              /*18*/ 
    "VAT PA "                      /*19*/ 
    "TOT.VAT  "                    /*20*/ 
    "TOT.PREM VAT  "               /*21*/ 
    "SBT "                         /*22*/ 
    "TOT.PREM SBT "                /*23*/ 
    "COMM. "                       /*24*/ 
    "COMM. COMPULSORY "            /*25*/ 
    "COMM. PA  "                   /*26*/  
    "TOT.COMM.  "                  /*27*/  
    "R/I Disc."                    /*28*/  
    "TOT.COMM.DISC."               /*29*/  
    "PRNVAT "                      /*30*/  
    "%PREM.RET"                    /*31*/  
    "PREM.RET"                     /*32*/  
    "%COMM.RET"                    /*33*/  
    "COMM.RET"                     /*34*/  
    "%PREM.1ST"                    /*35*/  
    "PREM.1ST"                     /*36*/  
    "%COMM.1ST"                    /*37*/  
    "COMM.1ST"                     /*38*/  
    "%PREM.2ND"                    /*39*/  
    "PREM.2ND"                     /*40*/ 
    "%COMM.2ND"                    /*41*/ 
    "COMM.2ND"                     /*42*/ 
    "%PREM.QBATH"                  /*43*/ 
    "PREM.QBATH"                   /*44*/ 
    "%COMM.QBATH"                  /*45*/ 
    "COMM.QBATH"                   /*46*/ 
    "%PREM.Q/S"                    /*47*/ 
    "PREM.Q/S"                     /*48*/ 
    "%COMM.Q/S"                    /*49*/ 
    "COMM.Q/S"                     /*50*/ 
    "%PREM.FO1"                    /*51*/ 
    "PREM.FO1"                     /*52*/ 
    "%COMM.FO1"                    /*53*/ 
    "COMM.FO1"                     /*54*/ 
    "%PREM.FO2"                    /*55*/ 
    "PREM.FO2"                     /*56*/ 
    "%COMM.FO2"                    /*57*/ 
    "COMM.FO2"                     /*58*/ 
    "%PREM.MPS"                    /*59*/ 
    "PREM.MPS"                     /*60*/ 
    "%COMM.MPS"                    /*61*/  
    "COMM.MPS"                     /*62*/  
    "%PREM.BTR"                    /*63*/  
    "PREM.BTR"                     /*64*/  
    "%COMM.BTR"                    /*65*/  
    "COMM.BTR"                     /*66*/  
    "%PREM.OTR"                    /*67*/  
    "PREM.OTR"                     /*68*/  
    "%COMM.OTR"                    /*69*/  
    "COMM.OTR"                     /*70*/ 
    "%PREM.FO3"                    /*71*/ 
    "PREM.FO3"                     /*72*/ 
    "%COMM.FO3"                    /*73*/ 
    "COMM.FO3"                     /*74*/ 
    "%PREM.FO4"                    /*75*/ 
    "PREM.FO4"                     /*76*/ 
    "%COMM.FO4"                    /*77*/ 
    "COMM.FO4"                     /*78*/ 
    "%PREM.FTR"                    /*79*/ 
    "PREM.FTR"                     /*80*/ 
    "%COMM.FTR"                    /*81*/ 
    "COMM.FTR"                     /*82*/ 
    "%PREM.TFP"                    /*83*/ 
    "PREM.TFP"                     /*84*/ 
    "%COMM.TFP"                    /*85*/ 
    "COMM.TFP"                     /*86*/ 
    "%PREM.S8"                     /*87*/ 
    "PREM.S8"                      /*88*/ 
    "%COMM.S8"                     /*89*/ 
    "COMM.S8"                      /*90*/ 
    "%PREM.Local Fac"              /*101*/  
    "PREM.Local Fac"               /*102*/  
    "%COMM.Local Fac"              /*103*/  
    "COMM.Local Fac"               /*104*/  
    "%PREM.Asian Fac"              /*105*/  
    "PREM.Asian Fac"               /*106*/  
    "%COMM.Asian Fac"              /*107*/  
    "COMM.Asian Fac"               /*108*/  
    "%PREM.Foreign Fac"            /*109*/  
    "PREM.Foreign Fac"             /*110*/ 
    "%COMM.Foreign Fac"            /*111*/ 
    "COMM.Foreign Fac"             /*112*/ 
    "Allocate Percent premium"     /*113*/ 
    "Allocate premium".            /*114*/ 
                                    
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
    "".

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
    " " "TOT.PREM.RET"
    " " "TOT.COMM.RET"
    " " "TOT.PREM.1ST"
    " " "TOT.COMM.1ST"
    " " "TOT.PREM.2ND"
    " " "TOT.COMM.2ND"
    " " "TOT.PREM.QBATH"
    " " "TOT.COMM.QBATH"
    " " "TOT.PREM.Q/S"
    " " "TOT.COMM.Q/S"
    " " "TOT.PREM.FO1"
    " " "TOT.COMM.FO1"
    " " "TOT.PREM.FO2"
    " " "TOT.COMM.FO2"
    " " "TOT.PREM.MPS"
    " " "TOT.COMM.MPS"
    " " "TOT.PREM.BTR"
    " " "TOT.COMM.BTR"
    " " "TOT.PREM.OTR"
    " " "TOT.COMM.OTR"
    " " "TOT.PREM.FO3"
    " " "TOT.COMM.FO3"
    " " "TOT.PREM.FO4"
    " " "TOT.COMM.FO4"
    " " "TOT.PREM.FTR"
    " " "TOT.COMM.FTR"
    " " "TOT.PREM.TFP"
    " " "TOT.COMM.TFP"
    " " "TOT.PREM.S8"
    " " "TOT.COMM.S8"
    " " "TOT.PREM.Local Fac"
    " " "TOT.COMM.Local Fac"
    " " "TOT.PREM.Asian Fac"
    " " "TOT.COMM.Asian Fac"
    " " "TOT.PREM.Foreign Fac"
    " " "TOT.COMM.Foreign Fac".
    
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
  DISPLAY fi_datfr fi_datto fi_frbrn fi_tobrn fi_source-2 fi_jv fi_source 
          fi_output fi_gldat fi_sourcedes fi_outputdesc 
      WITH FRAME fr_prem IN WINDOW C-Win.
  ENABLE fi_datfr fi_datto fi_frbrn fi_tobrn fi_reptyp fi_source-2 fi_jv 
         fi_source fi_output bu_ok bu_exit bu_clear fi_sourcedes fi_outputdesc 
         RECT-17 RECT-18 
      WITH FRAME fr_prem IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_prem}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE findper200 C-Win 
PROCEDURE findper200 :
/*------------------------------------------------------------------------------
  Purpose:     find % Comm จากTable uwm200
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF INPUT-OUTPUT PARAMETER nv_prem      LIKE uwd200.ripr.
DEF INPUT-OUTPUT PARAMETER nv_com       AS DEC.
DEF INPUT-OUTPUT PARAMETER nv_si        LIKE uwd200.risi.
DEF INPUT-OUTPUT PARAMETER nt_var_per   LIKE uwm200.rip1.

FIND FIRST uwm200 USE-INDEX uwm20001 WHERE  /*----------find % Comm จากTable uwm200-------*/
           uwm200.policy = uwd200.policy AND
           uwm200.rencnt = uwd200.rencnt AND
           uwm200.endcnt = uwd200.endcnt AND
           uwm200.csftq  = uwd200.csftq  AND
           uwm200.rico   = uwd200.rico   AND
           uwm200.c_enct = uwd200.c_enct  NO-LOCK  NO-ERROR.
IF  AVAIL  uwm200  THEN nt_var_per   = uwm200.rip1.

ASSIGN                             
  nv_prem  = nv_prem + uwd200.ripr 
  nv_com   = nv_com  + uwd200.ric1 
  nv_si    = nv_si   + uwd200.risi.

RETURN.
   
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assignsum C-Win 
PROCEDURE proc_assignsum :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

ASSIGN  
    nsd_vol      = nsd_vol      + wacm001.prem   
    nsd_comp     = nsd_comp     + wacm001.comp   
    nsd_pa       = nsd_pa       + wacm001.prepa  
    nsd_pol_prem = nsd_pol_prem + wacm001.totpre 
    nsd_vol_stp  = nsd_vol_stp  + wacm001.stamp  
    nsd_comp_stp = nsd_comp_stp + wacm001.stamc  
    nsd_pa_stp   = nsd_pa_stp   + wacm001.stampa 
    nsd_stp      = nsd_stp      + wacm001.totstm 
    nsd_vol_vat  = nsd_vol_vat  + wacm001.vatp   
    nsd_comp_vat = nsd_comp_vat + wacm001.vatc   
    nsd_pa_vat   = nsd_pa_vat   + wacm001.vatpa  
    nsd_vat      = nsd_vat      + wacm001.totvat 
    nsd_tot_vat  = nsd_tot_vat  + wacm001.totpvat
    nsd_sbt      = nsd_sbt      + wacm001.scb    
    nsd_tot_sbt  = nsd_tot_sbt  + wacm001.totpscb
    nsd_com_vol  = nsd_com_vol  + wacm001.comm   
    nsd_com_comp = nsd_com_comp + wacm001.co_comp
    nsd_com_pa   = nsd_com_pa   + wacm001.compa  
    nsd_comm     = nsd_comm     + wacm001.totcom 
    nsd_fee      = nsd_fee      + wacm001.ridis  
    nsd_sumfee   = nsd_sumfee   + wacm001.totdis 
    nsd_ret      = nsd_ret      + wuwm200.prmret 
    nsd_0t       = nsd_0t       + wuwm200.prm0t  
    nsd_0s       = nsd_0s       + wuwm200.prm0s  
    nsd_stat     = nsd_stat     + wuwm200.prmstat
    nsd_0rq      = nsd_0rq      + wuwm200.prm0rq 
    nsd_f1       = nsd_f1       + wuwm200.prmf1  
    nsd_f2       = nsd_f2       + wuwm200.prmf2  
    nsd_0ps      = nsd_0ps      + wuwm200.prm0ps 
    nsd_btr      = nsd_btr      + wuwm200.prmbtr 
    nsd_otr      = nsd_otr      + wuwm200.prmotr 
    nsd_f3       = nsd_f3       + wuwm200.prmf3  
    nsd_f4       = nsd_f4       + wuwm200.prmf4  
    nsd_ftr      = nsd_ftr      + wuwm200.prmftr 
    nsd_0q       = nsd_0q       + wuwm200.prm0q  
    nsd_s8       = nsd_s8       + wuwm200.prms8  
    nsd_0D       = nsd_0D       + wuwm200.prm0d  
    nsd_0A       = nsd_0A       + wuwm200.prm0a  
    nsd_0F       = nsd_0F       + wuwm200.prm0f  

    nsd_recom    = nsd_recom    + wuwm200.comret  
    nsd_0tcom    = nsd_0tcom    + wuwm200.com0t   
    nsd_0scom    = nsd_0scom    + wuwm200.com0s                           
    nsd_statcom  = nsd_statcom  + wuwm200.comstat                         
    nsd_0rqcom   = nsd_0rqcom   + wuwm200.com0rq                          
    nsd_f1com    = nsd_f1com    + wuwm200.comf1                           
    nsd_f2com    = nsd_f2com    + wuwm200.comf2                           
    nsd_0pscom   = nsd_0pscom   + wuwm200.com0ps                          
    nsd_btrcom   = nsd_btrcom   + wuwm200.com0ps                          
    nsd_otrcom   = nsd_otrcom   + wuwm200.combtr                          
    nsd_f3com    = nsd_f3com    + wuwm200.comf3                           
    nsd_f4com    = nsd_f4com    + wuwm200.comf4                           
    nsd_ftrcom   = nsd_ftrcom   + wuwm200.comftr                          
    nsd_0qcom    = nsd_0qcom    + wuwm200.com0q                           
    nsd_s8com    = nsd_s8com    + wuwm200.coms8                           
    nsd_0dcom    = nsd_0dcom    + wuwm200.com0d                           
    nsd_0acom    = nsd_0acom    + wuwm200.com0a                           
    nsd_0fcom    = nsd_0fcom    + wuwm200.com0f.  
                                                  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_clear C-Win 
PROCEDURE proc_clear :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

ASSIGN
    nv_cstat   = 0 nv_stat   = 0 nv_pstat   = 0
    nt_stat_pr = 0 mstat_c   = 0 nv_ppstat  = 0
    nt_stat_per = 0
    nv_pret    = 0 mret_c    = 0 nt_ret_pr  = 0
    nt_ret_per = 0 m0t_c     = 0 nt_0t_pr   = 0 
    nt_0t_per  = 0 nv_0t_pr  = 0 m0s_c      = 0 
    nt_0s_pr   = 0 nt_0s_per = 0 nv_0s_pr   = 0 
    nv_0RQ     = 0 m0rq_c    = 0 nt_0rq_pr  = 0 
    nt_0rq_per = 0               
    nv_f1_pr   = 0 nt_f1_pr  = 0 nt_f1_per  = 0  mf1_c  = 0 
    nv_f2_pr   = 0 nt_f2_pr  = 0 nt_f2_per  = 0  mf2_c  = 0 
    nv_f3_pr   = 0 nt_f3_pr  = 0 nt_f3_per  = 0  mf3_c  = 0 
    nv_f4_pr   = 0 nt_f4_pr  = 0 nt_f4_per  = 0  mf4_c  = 0  
    nv_0q_pr   = 0 nt_0q_pr  = 0 nt_0q_per  = 0  m0q_c  = 0
    nv_0ps     = 0 nt_0ps_pr = 0 nt_0ps_per = 0  m0ps_c = 0
    nv_btr     = 0 nt_btr_pr = 0 nt_btr_per = 0  mbtr_c = 0
    nv_otr     = 0 nt_otr_pr = 0 nt_otr_per = 0  motr_c = 0
    nv_s8      = 0 nt_s8_pr  = 0 nt_s8_per  = 0  ms8_c  = 0
    nv_ftr     = 0 nt_ftr_pr = 0 nt_ftr_per = 0  mftr_c = 0
    nv_p0a     = 0 nt_0A_pr  = 0 nt_0a_per  = 0  m0a_c  = 0
    nv_p0d     = 0 nt_0d_pr  = 0 nt_0d_per  = 0  m0d_c  = 0
    nv_p0f     = 0 nt_0f_pr  = 0 nt_0f_per  = 0  m0f_c  = 0.

ASSIGN
    nv_si0d     = 0 nv_si0a     = 0 nv_si0f     = 0 nv_siret    = 0 
    nv_sistat   = 0 nv_si0q     = 0 nv_si0t     = 0 nv_si0s     = 0 
    nv_sif1     = 0 nv_sif2     = 0 nv_sif3     = 0 nv_sif4     = 0 
    nv_si0rq    = 0 nv_si0ps    = 0 nv_sibtr    = 0 nv_siotr    = 0 
    nv_sis8     = 0 nv_siftr    = 0 nt_var_per1 = 0.




END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_crsumd C-Win 
PROCEDURE Proc_crsumd :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   ASSIGN   
     nsd_vol      = 0  nsd_comp     = 0  nsd_pa       = 0
     nsd_pol_prem = 0  nsd_vol_stp  = 0  nsd_comp_stp = 0
     nsd_pa_stp   = 0  nsd_stp      = 0  nsd_vol_vat  = 0
     nsd_comp_vat = 0  nsd_pa_vat   = 0  nsd_vat      = 0
     nsd_tot_vat  = 0  nsd_sbt      = 0  nsd_tot_sbt  = 0     
     nsd_com_vol  = 0  nsd_com_comp = 0  nsd_com_pa   = 0     
     nsd_comm     = 0  nsd_fee      = 0  nsd_sumfee   = 0
     nsd_ret      = 0  nsd_f2       = 0  nsd_ftr      = 0 
     nsd_0t       = 0  nsd_0ps      = 0  nsd_0q       = 0 
     nsd_0s       = 0  nsd_btr      = 0  nsd_s8       = 0 
     nsd_stat     = 0  nsd_otr      = 0  nsd_0D       = 0 
     nsd_0rq      = 0  nsd_f3       = 0  nsd_0A       = 0 
     nsd_f1       = 0  nsd_f4       = 0  nsd_0F       = 0 
     nsd_recom    = 0  nsd_f2com    = 0  nsd_ftrcom   = 0
     nsd_0tcom    = 0  nsd_0pscom   = 0  nsd_0qcom    = 0
     nsd_0scom    = 0  nsd_btrcom   = 0  nsd_s8com    = 0
     nsd_statcom  = 0  nsd_otrcom   = 0  nsd_0dcom    = 0
     nsd_0rqcom   = 0  nsd_f3com    = 0  nsd_0acom    = 0  
     nsd_f1com    = 0  nsd_f4com    = 0  nsd_0fcom    = 0
     nsd_sumper   = 0  nsd_sumprm   = 0  .
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_crsummary C-Win 
PROCEDURE proc_crsummary :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    ASSIGN  
      np_prem = 0  np_stp    = 0  np_vat     = 0  np_prvat = 0   
      np_sbt  = 0  np_prsbt  = 0  np_totprm  = 0  np_comm  = 0  np_sum   = 0  
      np_fee  = 0  np_sumfee = 0  

      np_sumretc = 0  np_0tc  = 0  np_0sc = 0 np_statc = 0  
      np_0rqc    = 0  np_f1c  = 0  np_f2c = 0 np_0psc  = 0  
      np_btrc    = 0  np_otrc = 0  np_f3c = 0 np_f4c   = 0  
      np_ftrc    = 0  np_0qc  = 0  np_s8c = 0 np_0Dc   = 0  
      np_0Ac     = 0  np_0Fc  = 0             

      np_retp    = 0  np_0tp  = 0  np_0sp = 0 np_statp = 0
      np_0rqp    = 0  np_f1p  = 0  np_f2p = 0 np_0psp  = 0
      np_btrp    = 0  np_otrp = 0  np_f3p = 0 np_f4p   = 0
      np_ftrp    = 0  np_0qp  = 0  np_s8p = 0 np_0Dp   = 0
      np_0Ap     = 0  np_0Fp  = 0.  
    ASSIGN
       nb_prem = 0  nb_stp     = 0  nb_vat    = 0  nb_prvat = 0  
       nb_sbt  = 0  nb_prsbt   = 0  nb_totprm = 0  nb_comm  = 0  
       nb_fee  = 0  nb_sumfee  = 0  

       nb_sumretc = 0  nb_0tc  = 0  nb_0sc = 0 nb_statc = 0  
       nb_0rqc    = 0  nb_f1c  = 0  nb_f2c = 0 nb_0psc  = 0  
       nb_btrc    = 0  nb_otrc = 0  nb_f3c = 0 nb_f4c   = 0  
       nb_ftrc    = 0  nb_0qc  = 0  nb_s8c = 0 nb_0Dc   = 0  
       nb_0Ac     = 0  nb_0Fc  = 0             

       nb_retp    = 0  nb_0tp  = 0  nb_0sp = 0 nb_statp = 0
       nb_0rqp    = 0  nb_f1p  = 0  nb_f2p = 0 nb_0psp  = 0
       nb_btrp    = 0  nb_otrp = 0  nb_f3p = 0 nb_f4p   = 0
       nb_ftrp    = 0  nb_0qp  = 0  nb_s8p = 0 nb_0Dp   = 0
       nb_0Ap     = 0  nb_0Fp  = 0  

       nb_sum  = 0  jvg_comm   = 0  jv_summ   = 0  jv_tsumm = 0
       sumpa   = 0  jvg_sumfee = 0  .

    ASSIGN
       ns_prem = 0  ns_stp    = 0  ns_vat     = 0  ns_prvat = 0  
       ns_sbt  = 0  ns_prsbt  = 0  ns_totprm  = 0  ns_comm  = 0  ns_sum   = 0
       ns_fee  = 0  ns_sumfee = 0  

       ns_sumretc = 0  ns_0tc  = 0  ns_0sc = 0 ns_statc = 0  
       ns_0rqc    = 0  ns_f1c  = 0  ns_f2c = 0 ns_0psc  = 0  
       ns_btrc    = 0  ns_otrc = 0  ns_f3c = 0 ns_f4c   = 0  
       ns_ftrc    = 0  ns_0qc  = 0  ns_s8c = 0 ns_0Dc   = 0  
       ns_0Ac     = 0  ns_0Fc  = 0             

       ns_retp    = 0  ns_0tp  = 0  ns_0sp = 0 ns_statp = 0
       ns_0rqp    = 0  ns_f1p  = 0  ns_f2p = 0 ns_0psp  = 0
       ns_btrp    = 0  ns_otrp = 0  ns_f3p = 0 ns_f4p   = 0
       ns_ftrp    = 0  ns_0qp  = 0  ns_s8p = 0 ns_0Dp   = 0
       ns_0Ap     = 0  ns_0Fp  = 0.  
       
             


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_GrandTot C-Win 
PROCEDURE Proc_GrandTot :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 ASSIGN 
   nb_prem    = nb_prem    + wfbyline.wfprem 
   nb_stp     = nb_stp     + wfbyline.wfstp 
   nb_vat     = nb_vat     + wfbyline.wfvat 
   nb_prvat   = nb_prvat   + wfbyline.wfprvat 
   nb_sbt     = nb_sbt     + wfbyline.wfsbt 
   nb_prsbt   = nb_prsbt   + wfbyline.wfprsbt 
   nb_totprm  = nb_totprm  + wfbyline.wftotprm
   nb_comm    = nb_comm    + wfbyline.wfcomm 
   nb_sum     = nb_sum     + wfbyline.wfsum
   nb_fee     = nb_fee     + wfbyline.wffee
   nb_sumfee  = nb_sumfee  + wfbyline.wfsumfee

   nb_sumretc = nb_sumretc + wfbyline.wfretc
   nb_0tc     = nb_0tc     + wfbyline.w0tc  
   nb_0sc     = nb_0sc     + wfbyline.w0sc  
   nb_statc   = nb_statc   + wfbyline.wstatc
   nb_0rqc    = nb_0rqc    + wfbyline.w0rqc 
   nb_f1c     = nb_f1c     + wfbyline.wf1c  
   nb_f2c     = nb_f2c     + wfbyline.wf2c  
   nb_0psc    = nb_0psc    + wfbyline.w0psc 
   nb_btrc    = nb_btrc    + wfbyline.wbtrc 
   nb_otrc    = nb_otrc    + wfbyline.wotrc 
   nb_f3c     = nb_f3c     + wfbyline.wf3c  
   nb_f4c     = nb_f4c     + wfbyline.wf4c  
   nb_ftrc    = nb_ftrc    + wfbyline.wftrc 
   nb_0qc     = nb_0qc     + wfbyline.w0qc  
   nb_s8c     = nb_s8c     + wfbyline.ws8c  
   nb_0Dc     = nb_0Dc     + wfbyline.w0Dc  
   nb_0Ac     = nb_0Ac     + wfbyline.w0Ac  
   nb_0Fc     = nb_0Fc     + wfbyline.w0Fc  

   nb_retp    = nb_retp    + wfbyline.wfretp
   nb_0tp     = nb_0tp     + wfbyline.w0tp  
   nb_0sp     = nb_0sp     + wfbyline.w0sp  
   nb_statp   = nb_statp   + wfbyline.wstatp
   nb_0rqp    = nb_0rqp    + wfbyline.w0rqp 
   nb_f1p     = nb_f1p     + wfbyline.wf1p  
   nb_f2p     = nb_f2p     + wfbyline.wf2p  
   nb_0psp    = nb_0psp    + wfbyline.w0psp 
   nb_btrp    = nb_btrp    + wfbyline.wbtrp 
   nb_otrp    = nb_otrp    + wfbyline.wotrp 
   nb_f3p     = nb_f3p     + wfbyline.wf3p  
   nb_f4p     = nb_f4p     + wfbyline.wf4p  
   nb_ftrp    = nb_ftrp    + wfbyline.wftrp 
   nb_0qp     = nb_0qp     + wfbyline.w0qp  
   nb_s8p     = nb_s8p     + wfbyline.ws8p  
   nb_0Dp     = nb_0Dp     + wfbyline.w0Dp  
   nb_0Ap     = nb_0Ap     + wfbyline.w0Ap  
   nb_0Fp     = nb_0Fp     + wfbyline.w0Fp  .

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_Motor C-Win 
PROCEDURE Proc_Motor :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
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
           ASSIGN  nv_vol_stp = 1 /* --- กำหนดให้เป็น 1 ตามหลักกฎหมายเราต้องส่ง Stamp 
                                         แต่ทาง UW จะให้ stamp เป็น 0 ----  */
                   nv_stp  =  nv_vol_stp + nv_comp_stp + nv_pa_stp.
        ELSE ASSIGN nv_vol_stp = (uwm100.pstp + uwm100.rstp_t) - nv_pa_stp - nv_comp_stp
                    nv_stp     = uwm100.rstp_t + uwm100.pstp.   /* policy stamp */

        ASSIGN 
         nv_vol       = uwm100.prem_t - nv_comp - nv_pa
         tot_pa_stp   = tot_pa_stp    + nv_pa_stp
         tot_comp_stp = tot_comp_stp  + nv_comp_stp
         tot_vol_stp  = tot_vol_stp   + nv_vol_stp.
        
         /* --------- Calculate VAT  ------------- */
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
          pol_prem     = nv_vol  + nv_comp  + nv_pa  /*PREMIUM*/
          nv_comm      = com_vol + com_comp + com_pa /*COMMISSION*/
          nv_fee       = uwm100.rfee_t               /*RI DISC.*/  /*A53-0020*/
          nv_sumfee    = nv_comm + nv_fee
          nv_tot_sbt   = 0
          nv_tot_vat   = pol_prem + nv_vat + nv_stp   
          nv_row       = nv_row + 1.                 /*  ----- sum ยอดรวม ----- */

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
          
        ASSIGN
          nv_policy  = ""
          nv_rencnt  = 0
          nv_endcnt  = 0
          /* ---- suthida T. A53-0326 19-05 -11---- */
          nv_policy  =  n_policy 
          nv_rencnt  =  n_rencnt 
          nv_endcnt  =  n_endcnt .
          /* ---- suthida T. A53-0326 19-05 -11----
          nv_policy  = acm001.policy
          nv_rencnt  = acm001.rencnt
          nv_endcnt  = acm001.endcnt.
          ---- suthida T. A53-0326 19-05 -11---- */

       RUN proc_uwd200 (INPUT-OUTPUT nv_policy,
                        INPUT-OUTPUT nv_rencnt,
                        INPUT-OUTPUT nv_endcnt ).  /* ------ Allocate ------- */

       /* ---------- suthida t. A53-0326 19-05-11 -------------- 
        IF fi_reptyp = "2" THEN  RUN pro_motor. /* ---- Summary ---- */

       ASSIGN

          nsd_sumper   = nv_pret   + nv_0t_pr + nv_0s_pr + nv_ppstat + nv_0RQ   + nv_f1_pr +
                         nv_f2_pr  + nv_0ps   + nv_btr   + nv_otr    + nv_f3_pr + nv_f4_pr +
                         nv_ftr    + nv_0q_pr + nv_s8    + nv_p0d    + nv_p0a   + nv_p0f 

          nsd_sumprm   = nt_ret_pr + nt_0t_pr  + nt_0s_pr  + nt_stat_pr +
                         nt_0rq_pr + nt_f1_pr  + nt_f2_pr  + nt_0ps_pr  +
                         nt_btr_pr + nt_otr_pr + nt_f3_pr  + nt_f4_pr   +
                         nt_ftr_pr + nt_0q_pr  + nt_s8_pr  + nt_0D_pr   +
                         nt_0A_pr  + nt_0F_pr.
       ---------- suthida t. A53-0326 19-05-11 -------------- */                   
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
  nv_reccnt  = 0
  nv_next    = 1
  n_count    = 0
  nv_output2 = nv_output + STRING(nv_next) + "sum.SLK"
  nv_output  = nv_output + STRING(nv_next) + "det.SLK".

IF fi_reptyp = "1" THEN DO:
   OUTPUT TO VALUE (nv_output) NO-ECHO.
   EXPORT DELIMITER ";" 
     "Premium By Line - DETAIL".
   EXPORT DELIMITER ";"
     "Branch From : " frm_bran  "    To : "  to_bran
     "" "" "" "" "" "Transaction Type :  M    R".
   EXPORT DELIMITER ";"
     "Transaction Date From : " frm_trndat 
     "    TO : "  to_trndat 
     "" "" "" "" "" "Report Date : " TODAY.
   OUTPUT CLOSE.
   nv_reccnt = nv_reccnt + 3.
END.

RUN Proc_crsumd.   /* ---- clear data ----- */
RUN proc_clear.    /* ---- clear data ----- */

FOR EACH wacm001. DELETE wacm001. END.
FOR EACH wuwm200. DELETE wuwm200. END.
/* --- suthida T. A540223 01-08-11 ---- */
ASSIGN
  nv_brdes  = ""
  nv_brdes1 = "".
FOR EACH xmm023 USE-INDEX xmm02301 WHERE
         xmm023.branch >= frm_bran   AND
         xmm023.branch <= to_bran    NO-LOCK.

   IF LENGTH(xmm023.branch)     = 2 THEN DO:
       IF SUBSTRING(xmm023.branch,1,1) = "9"  AND SUBSTRING(xmm023.branch,2,1) <> "0"  
           THEN ASSIGN nv_brdes  = nv_brdes  + "," + xmm023.branch 
                       nv_brdes1 = nv_brdes1 + "," + xmm023.branch .
       ELSE DO:
           nv_br = to_bran.

           IF LENGTH(to_bran) = 1 AND 
              INDEX("0123456789" , to_bran) <> 0 THEN nv_br = "0" + to_bran. 
           
           IF (xmm023.branch > nv_br) THEN NEXT. 
           ELSE nv_brdes = nv_brdes + "," + xmm023.branch.
          
       END.
   END.
   ELSE IF LENGTH(xmm023.branch)     = 1 THEN nv_brdes = nv_brdes + "," + xmm023.branch .
END.
/* --- end suthida T. A540223 01-08-11 ---- */

loop_acm001:
FOR EACH acm001 NO-LOCK USE-INDEX acm00191 
    WHERE acm001.trndat >= frm_trndat 
    AND   acm001.trndat <= to_trndat  
    AND  (acm001.trnty1  = "A" OR acm001.trnty1  = "B" OR  /* --- เอา Type ที่เป็นเบี้ย ----- */
          acm001.trnty1  = "M" OR acm001.trnty1  = "R" OR
          acm001.trnty1  = "O" OR acm001.trnty1  = "T" OR
          acm001.trnty1  = "Q" OR acm001.trnty1  = "V" OR
          acm001.trnty1  = "U" OR acm001.trnty1  = "P"   )  
    AND (SUBSTR(acm001.policy,1,1) = "D" OR
        (SUBSTR(acm001.policy,1,2) >= "10" AND SUBSTRING(acm001.policy,1,2) <= "99"))
    /* ------- suthida T. A540223 02-08-11 ----
    AND acm001.branch >= frm_bran
    AND acm001.branch <= to_bran
    ------- suthida T. A540223 02-08-11 ---- */
    AND INDEX(nv_brdes, "," + acm001.branch) <> 0       /* ------- suthida T. A540223 01-08-11 -----  */
    AND ( (fi_source-2     = "1"   AND  /* Motor */
           (acm001.poltyp  = "V70" OR  
            acm001.poltyp  = "V72" OR  
            acm001.poltyp  = "V73" OR  
            acm001.poltyp  = "V74"))
    OR    (fi_source-2 = "2" AND 
           (acm001.poltyp   <> "V70" AND   /* Non- Motor */
            acm001.poltyp   <> "V72" AND  
            acm001.poltyp   <> "V73" AND  
            acm001.poltyp   <> "V74")) 
    OR    (fi_source-2 = "3" AND 
           (acm001.poltyp   <> " ")) )

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
    ASSIGN
    /* n_bran     = acm001.branch --- suthida T. A540223 --- */
    n_poltyp   = SUBSTR(acm001.policy,3,2)
    n_policy   = acm001.policy
    nv_chkline = NO.

    IF fi_reptyp = "1" THEN DO:
        IF FIRST-OF (acm001.branch) OR nv_reccnt = 0 THEN DO:
           RUN ChkLineExcel.
           nv_reccnt = nv_reccnt + 2.
        END.
        
    END.
    /* --- suthida T. A540223 01-08-11 ----*/
    n_bran     = "".
    n_bran     = acm001.branch.
     
    IF SUBSTR(acm001.policy,1,1) = "I" THEN DO:
         IF nv_brdes1 = ""  THEN NEXT loop_acm001.  
         IF INDEX(nv_brdes1,",9" + SUBSTRING(acm001.policy,2,1)) <> 0 THEN 
            n_bran = "9" + SUBSTRING(acm001.policy,2,1). 
    END.
    ELSE DO:    
         IF acm001.branch <  frm_bran OR acm001.branch > to_bran  THEN NEXT loop_acm001.                
    END.
    /* --- end suthida T. A540223 01-08-11 ----*/
    
    IF  acm001.trnty1 = "U" OR acm001.trnty1 = "P" THEN DO: 
        FIND FIRST uwm200 WHERE 
                   uwm200.trtyri = acm001.trnty1 AND
                   uwm200.docri  = acm001.docno  AND
                   uwm200.policy = acm001.policy  NO-LOCK NO-ERROR.
        IF AVAILABLE uwm200 THEN NEXT loop_acm001.
    END.
    ELSE DO:
        FIND FIRST uwm100 USE-INDEX uwm10090  WHERE
                   uwm100.trty11 = acm001.trnty1 AND
                   uwm100.docno1 = acm001.docno  AND  
                   uwm100.policy = acm001.policy AND
                   uwm100.releas = YES           NO-LOCK NO-ERROR.
        /*---A52-189---*/
        IF NOT AVAILABLE uwm100 THEN NEXT loop_acm001. 
    END.

    /* --------- Suthida T. A54-0223 ---------
    FIND FIRST uwm100 USE-INDEX uwm10001 
         WHERE uwm100.policy = acm001.policy 
         AND   uwm100.rencnt = acm001.rencnt
         AND   uwm100.endcnt = acm001.endcnt 
         AND   uwm100.releas = YES NO-LOCK NO-ERROR.
    --------- Suthida T. A54-0223 --------- */
    /* --------- Suthida T. A54-0223 --------- */
    FIND FIRST uwm100 USE-INDEX uwm10090 WHERE
               uwm100.trty11 = acm001.trnty1 AND
               uwm100.docno1 = acm001.docno  AND
               uwm100.policy = uwm100.policy AND
               uwm100.releas = YES NO-LOCK NO-ERROR.
    /* --------- Suthida T. A54-0223 --------- */
    IF AVAIL uwm100 THEN DO:

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
             "Com date     ="   uwm100.comdat.
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
         n_policy = uwm100.policy  /* --- suthida T. A53-0326 19-05-11 ----- */
         n_rencnt = uwm100.rencnt
         n_endcnt = uwm100.endcnt
         n_endno  = uwm100.endno
         n_trndat = uwm100.trndat
         n_comdat = uwm100.comdat.
      
       /*---------- Motor ---------*/
       IF (SUBSTRING(acm001.policy,3,2) = "70" OR SUBSTRING(acm001.policy,3,2) = "72" OR 
           SUBSTRING(acm001.policy,3,2) = "73" OR SUBSTRING(acm001.policy,3,2) = "74")  THEN DO:

           RUN proc_Motor.
           IF fi_reptyp = "2" THEN  RUN pro_motor. /* ---- Summary suthida t. A53-0326 19-05-11 ---- */
           RUN proc_wacm001. 
           
       END.
       ELSE DO:

           RUN proc_Non_Motor. /*------ Non Motor -------*/
           IF fi_reptyp = "2" THEN RUN pro_Nonmotor. /* ---- Summary suthida t. A53-0326 19-05-11  ----- */
           RUN proc_wacm001. 

       END.
        
       /* ----- suthida t. A53-0326 19-05-11  -----*/
       ASSIGN
         nsd_sumper   = nv_pret   + nv_0t_pr + nv_0s_pr + nv_ppstat + nv_0RQ   + nv_f1_pr +
                        nv_f2_pr  + nv_0ps   + nv_btr   + nv_otr    + nv_f3_pr + nv_f4_pr +
                        nv_ftr    + nv_0q_pr + nv_s8    + nv_p0d    + nv_p0a   + nv_p0f 

          nsd_sumprm   = nt_ret_pr + nt_0t_pr  + nt_0s_pr  + nt_stat_pr +
                         nt_0rq_pr + nt_f1_pr  + nt_f2_pr  + nt_0ps_pr  +
                         nt_btr_pr + nt_otr_pr + nt_f3_pr  + nt_f4_pr   +
                         nt_ftr_pr + nt_0q_pr  + nt_s8_pr  + nt_0D_pr   +
                         nt_0A_pr  + nt_0F_pr.

       RUN proc_wuwm200.  /* --- create data to wuwm200 ---- */

       /* RUN proc_assignsum. */
       ASSIGN 
           nv_vol     = 0   nv_comp     = 0   nv_pa     = 0   pol_prem = 0     
           nv_vol_stp = 0   nv_comp_stp = 0   nv_pa_stp = 0   nv_stp   = 0      
           nv_vol_vat = 0   nv_comp_vat = 0   nv_pa_vat = 0   nv_vat   = 0   nv_tot_vat  = 0      
           nv_sbt     = 0   nv_tot_sbt  = 0             
           com_vol    = 0   com_comp    = 0   com_pa    = 0        
           nv_comm    = 0   nv_fee      = 0   nv_sumfee = 0
           nsd_sumper = 0   nsd_sumprm  = 0.


    END. /* ----- uwm 1000 ------ */
    ELSE NEXT loop_acm001.
END.  /*each acm001*/

RUN Proc_crsumd.   /* ---- clear data ----- */
RUN proc_clear.    /* ---- clear data ----- */

loop_uwm100:
FOR EACH  uwm100 NO-LOCK USE-INDEX uwm10008 
    WHERE uwm100.trndat >= frm_trndat
    AND   uwm100.trndat <= to_trndat 
    AND (SUBSTR(uwm100.policy,1,1) = "D" OR
        (SUBSTR(uwm100.policy,1,2) >= "10" AND SUBSTRING(uwm100.policy,1,2) <= "99"))
    /* -------- Suthida T. A540223 02-08-11 ------- 
    AND uwm100.branch >= frm_bran
    AND uwm100.branch <= to_bran
    -------- Suthida T. A540223 02-08-11 -------  */
    AND INDEX(nv_brdes,"," + uwm100.branch) <> 0         /* --- suthida T. A540223 02-08-11  ---- */
    AND ( (fi_source-2     = "1"   AND  /* Motor */
           (uwm100.poltyp  = "V70" OR  
            uwm100.poltyp  = "V72" OR  
            uwm100.poltyp  = "V73" OR  
            uwm100.poltyp  = "V74"))
   OR     (fi_source-2     = "2" AND 
           (uwm100.poltyp   <> "V70" AND   /* Non- Motor */
            uwm100.poltyp   <> "V72" AND  
            uwm100.poltyp   <> "V73" AND  
            uwm100.poltyp   <> "V74")) 
   OR     (fi_source-2 = "3" AND 
          (uwm100.poltyp   <> " ")) )
   AND   uwm100.RELEAS       = YES .

    /* ----------- suthida T. A53-0326 10-05-11 ------------ ,
   EACH uwm200 NO-LOCK USE-INDEX uwm20001
   WHERE uwm200.policy  = uwm100.policy
   AND   uwm200.rencnt  = uwm100.rencnt
   AND   uwm200.endcnt >= 1
   AND   uwm200.csftq  <> "F" ,

   FIRST wacm001 NO-LOCK 
   WHERE wacm001.policy = uwm200.policy 
   
   FIND FIRST wuwm200 
        WHERE wuwm200.policy = uwm100.policy NO-ERROR.
   /*IF NOT AVAIL uwm200 THEN NEXT loop_uwm100.*/ /* ---- suthida T. A53-0326 ---- */
   IF NOT AVAIL wuwm200 THEN DO:
      RUN proc_wacm001. 
      RUN proc_wuwm200. 
   END.
   ELSE DO:

       ASSIGN
          nv_policy  = ""
          nv_rencnt  = 0
          nv_endcnt  = 0
          nv_policy  = wuwm200.policy
          nv_rencnt  = wuwm200.rencnt
          nv_endcnt  = wuwm200.endcnt.

        RUN proc_uwd200 (INPUT-OUTPUT nv_policy,
                         INPUT-OUTPUT nv_rencnt,
                         INPUT-OUTPUT nv_endcnt ).  /* ------ Allocate ------- */

        ASSIGN
          wuwm200.prmret     =  nt_ret_pr             wuwm200.comret  = mret_c 
          wuwm200.prm0t      =  nt_0t_pr              wuwm200.com0t   = m0t_c  
          wuwm200.prm0s      =  nt_0s_pr              wuwm200.com0s   = m0s_c  
          wuwm200.prmstat    =  nt_stat_pr            wuwm200.comstat = mstat_c
          wuwm200.prm0rq     =  nt_0rq_pr             wuwm200.com0rq  = m0rq_c 
          wuwm200.prmf1      =  nt_f1_pr              wuwm200.comf1   = mf1_c  
          wuwm200.prmf2      =  nt_f2_pr              wuwm200.comf2   = mf2_c  
          wuwm200.prm0ps     =  nt_0ps_pr             wuwm200.com0ps  = m0ps_c 
          wuwm200.prmbtr     =  nt_btr_pr             wuwm200.combtr  = mbtr_c 
          wuwm200.prmotr     =  nt_otr_pr             wuwm200.comotr  = motr_c 
          wuwm200.prmf3      =  nt_f3_pr              wuwm200.comf3   = mf3_c  
          wuwm200.prmf4      =  nt_f4_pr              wuwm200.comf4   = mf4_c  
          wuwm200.prmftr     =  nt_ftr_pr             wuwm200.comftr  = mftr_c 
          wuwm200.prm0q      =  nt_0q_pr              wuwm200.com0q   = m0q_c  
          wuwm200.prms8      =  nt_s8_pr              wuwm200.coms8   = ms8_c  
          wuwm200.prm0d      =  nt_0D_pr              wuwm200.com0d   = m0d_c  
          wuwm200.prm0a      =  nt_0A_pr              wuwm200.com0a   = m0a_c  
          wuwm200.prm0f      =  nt_0F_pr              wuwm200.com0f   = m0f_c. 

   END.  FIND FIRST wuwm200 if avail 
   ----------- suthida T. A53-0326 10-05-11 ------------  */
    /* --- suthida T. A540223 01-08-11 ----*/
   n_bran     = "".
   n_bran     = uwm100.branch.
    
    IF SUBSTR(uwm100.policy,1,1) = "I" THEN DO:
        IF nv_brdes1 = ""  THEN NEXT loop_uwm100.  
        IF INDEX(nv_brdes1,",9" + SUBSTRING(uwm100.policy,2,1)) <> 0 THEN 
           n_bran = "9" + SUBSTRING(uwm100.policy,2,1). 
    
    END.
    ELSE IF SUBSTR(uwm100.policy,1,1) = "D" THEN DO:    
         IF uwm100.branch <  frm_bran OR uwm100.branch > to_bran  THEN NEXT loop_uwm100.                
    END.
           
   /* --- end suthida T. A540223 01-08-11 ----*/

   /* ----------- suthida T. A53-0326 10-05-11 ------------ */
   FIND FIRST uwm200 NO-LOCK USE-INDEX uwm20001
        WHERE uwm200.policy  = uwm100.policy
        AND   uwm200.rencnt  = uwm100.rencnt
        AND   uwm200.endcnt  = uwm100.endcnt NO-ERROR.
   IF NOT AVAIL uwm200 THEN NEXT loop_uwm100.
   ELSE DO:
      
       FIND FIRST wacm001
              WHERE wacm001.policy = uwm100.policy 
              AND   wacm001.rencnt = uwm100.rencnt
              AND   wacm001.endcnt = uwm100.endcnt NO-ERROR.
       IF NOT AVAIL wacm001 THEN DO:
       
            ASSIGN
              n_policy       = uwm100.policy
              n_rencnt       = uwm100.rencnt
              n_endcnt       = uwm100.endcnt
              n_endno        = uwm100.endno
              n_trndat       = uwm100.trndat
              n_comdat       = uwm100.comdat
              n_poltyp       = SUBSTRING(uwm100.policy,3,2).
              /*n_bran         = uwm100.branch. ---- suthida T. A540223 01-08-11 ----- */
       
            IF (SUBSTRING(uwm100.policy,3,2) = "70" OR SUBSTRING(uwm100.policy,3,2) = "72" OR 
                SUBSTRING(uwm100.policy,3,2) = "73" OR SUBSTRING(uwm100.policy,3,2) = "74")  THEN DO:
       
                RUN proc_Motor.
                IF fi_reptyp = "2" THEN  RUN pro_motor. /* ---- Summary suthida t. A53-0326 19-05-11 ---- */
                RUN proc_wacm001. 
       
            END.
            ELSE DO:
       
                RUN proc_Non_Motor. /*------ Non Motor -------*/
                IF fi_reptyp = "2" THEN RUN pro_Nonmotor. /* ---- Summary suthida t. A53-0326 19-05-11 ---- */
                RUN proc_wacm001. 
            END.
       
       END. /* IF NOT AVAIL wacm001 */

       IF uwm200.csftq  <> "F"  THEN DO:
           ASSIGN
             nv_policy  = ""
             nv_rencnt  = 0
             nv_endcnt  = 0
             nv_policy  = wacm001.policy
             nv_rencnt  = wacm001.rencnt
             nv_endcnt  = wacm001.endcnt.

          RUN Proc_crsumd.   /* ---- clear data ----- */
          RUN proc_clear.    /* ---- clear data ----- */ 

          RUN proc_uwd200 (INPUT-OUTPUT nv_policy,
                           INPUT-OUTPUT nv_rencnt,
                           INPUT-OUTPUT nv_endcnt ).  /* ------ Allocate ------- */

         
          ASSIGN
             nsd_sumper   = nv_pret   + nv_0t_pr + nv_0s_pr + nv_ppstat + nv_0RQ   + nv_f1_pr +
                            nv_f2_pr  + nv_0ps   + nv_btr   + nv_otr    + nv_f3_pr + nv_f4_pr +
                            nv_ftr    + nv_0q_pr + nv_s8    + nv_p0d    + nv_p0a   + nv_p0f 

             nsd_sumprm   = nt_ret_pr + nt_0t_pr  + nt_0s_pr  + nt_stat_pr +
                            nt_0rq_pr + nt_f1_pr  + nt_f2_pr  + nt_0ps_pr  +
                            nt_btr_pr + nt_otr_pr + nt_f3_pr  + nt_f4_pr   +
                            nt_ftr_pr + nt_0q_pr  + nt_s8_pr  + nt_0D_pr   +
                            nt_0A_pr  + nt_0F_pr.

         RUN proc_wuwm200. /*  ----  suthida T. A53-0326 13-05-11 ----- */ 



         ASSIGN 
              nv_vol     = 0   nv_comp     = 0   nv_pa     = 0   pol_prem = 0     
              nv_vol_stp = 0   nv_comp_stp = 0   nv_pa_stp = 0   nv_stp   = 0      
              nv_vol_vat = 0   nv_comp_vat = 0   nv_pa_vat = 0   nv_vat   = 0   nv_tot_vat  = 0      
              nv_sbt     = 0   nv_tot_sbt  = 0             
              com_vol    = 0   com_comp    = 0   com_pa    = 0        
              nv_comm    = 0   nv_fee      = 0   nv_sumfee = 0
              nsd_sumper = 0   nsd_sumprm  = 0.

      END. /* uwm200.csftq  <> "F"*/
  END. /*IF AVAIL uwm200 */
END.
    
IF fi_reptyp = "1" THEN DO:
   OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
   EXPORT DELIMITER ";" "". 
   RUN DHeadTable.
   OUTPUT CLOSE.

   RUN Proc_reportIF . /* ---- suthida T. A540223 02-08-11 ----*/

   RUN sumDetail.    /*--By Aom Sum Detail --*/

END.  /* fi_reptyp = "1" */

IF fi_reptyp = "2" THEN RUN Proc_ProTot. /*A51-0078 Lukkana M. 25/08/2008*/

RUN Proc_crsumd.   /* ---- clear data ----- */
RUN proc_clear.    /* ---- clear data ----- */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_NewDetailsL C-Win 
PROCEDURE Proc_NewDetailsL :
/*------------------------------------------------------------------------------
  Purpose:      Process Detail Excel File  
  Parameters:  <None>
  Notes:   Title = 3 Lines,  DHeadtable = 2 Lines **** for Direct ****
------------------------------------------------------------------------------*/
ASSIGN 
  nv_reccnt  = 0
  nv_next    = 1
  n_count    = 0 /* ---- suthida T. A53-0326 18-05-11 ------ */
  nv_output2 = nv_output + STRING(nv_next) + "sum.SLK"
  nv_output  = nv_output + STRING(nv_next) + "det.SLK".

IF fi_reptyp = "1" THEN DO:
   OUTPUT TO VALUE (nv_output) NO-ECHO.
   EXPORT DELIMITER ";" 
     "Premium By Line - DETAIL".
   EXPORT DELIMITER ";"
     "Branch From : " frm_bran  "    To : "  to_bran
     "" "" "" "" "" "Transaction Type :  M    R".
   EXPORT DELIMITER ";"
     "Transaction Date From : " frm_trndat 
     "    TO : "  to_trndat 
     "" "" "" "" "" "Report Date : " TODAY.
   OUTPUT CLOSE.
   nv_reccnt = nv_reccnt + 3.
END.

RUN Proc_crsumd.   /* ---- clear data ----- */
RUN proc_clear.    /* ---- clear data ----- */

FOR EACH wacm001. DELETE wacm001. END.
FOR EACH wuwm200. DELETE wuwm200. END.

/* --- suthida T. A540223 01-08-11 ---- */
ASSIGN
  nv_brdes  = ""
  nv_brdes1 = "".
FOR EACH xmm023 USE-INDEX xmm02301 WHERE
         xmm023.branch >= frm_bran   AND
         xmm023.branch <= to_bran    NO-LOCK.

   IF LENGTH(xmm023.branch)     = 2 THEN DO:
       IF SUBSTRING(xmm023.branch,1,1) = "9"  AND SUBSTRING(xmm023.branch,2,1) <> "0"  
           THEN ASSIGN nv_brdes  = nv_brdes  + "," + xmm023.branch 
                       nv_brdes1 = nv_brdes1 + "," + xmm023.branch .
       ELSE DO:
           nv_br = to_bran.

           IF LENGTH(to_bran) = 1 AND 
              INDEX("0123456789" , to_bran) <> 0 THEN nv_br = "0" + to_bran. 
           
           IF (xmm023.branch > nv_br) THEN NEXT. 
           ELSE nv_brdes = nv_brdes + "," + xmm023.branch.
       END.
   END.
   ELSE IF LENGTH(xmm023.branch)     = 1 THEN nv_brdes = nv_brdes + "," + xmm023.branch .
END.
/* --- end suthida T. A540223 01-08-11 ---- */

loop_acm001:
FOR EACH acm001 NO-LOCK USE-INDEX acm00191 
    WHERE acm001.trndat >= frm_trndat 
     AND  acm001.trndat <= to_trndat  
     AND (acm001.trnty1  = "A" OR acm001.trnty1  = "B" OR  /* --- เอา Type ที่เป็นเบี้ย ----- */
          acm001.trnty1  = "M" OR acm001.trnty1  = "R" OR
          acm001.trnty1  = "O" OR acm001.trnty1  = "T" OR
          acm001.trnty1  = "Q" OR acm001.trnty1  = "V" OR
          acm001.trnty1  = "U" OR acm001.trnty1  = "P"   )  
     AND  SUBSTR(acm001.policy,1,1) = "I"
     /* ------- suthida T. A540223 01-08-11 -----
     AND  acm001.branch >= frm_bran
     AND  acm001.branch <= to_bran
     ------- suthida T. A540223 01-08-11 ----- */
     AND INDEX(nv_brdes, "," + acm001.branch) <> 0       /* ------- suthida T. A540223 01-08-11 -----  */
     AND ( (fi_source-2     = "1"   AND  /* Motor */
            (acm001.poltyp  = "V70" OR  
             acm001.poltyp  = "V72" OR  
             acm001.poltyp  = "V73" OR  
             acm001.poltyp  = "V74"))
    OR     (fi_source-2 = "2" AND 
            (acm001.poltyp   <> "V70" AND   /* Non- Motor */
             acm001.poltyp   <> "V72" AND  
             acm001.poltyp   <> "V73" AND  
             acm001.poltyp   <> "V74")) 
    OR     (fi_source-2 = "3" AND 
            (acm001.poltyp   <> " ")) )

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
       ELSE IF SUBSTR(acm001.policy,1,1) <> "D" THEN NEXT loop_acm001.
    END.
    ELSE IF n_source = "IF" THEN DO:
       IF SUBSTR(acm001.policy,1,1) <> "I" THEN NEXT loop_acm001.
    END.
    /* END --- A50-0178 fon---*/

    ASSIGN
     /* n_bran     = acm001.branch  ---- */
     n_poltyp   = SUBSTR(acm001.policy,3,2)
     n_policy   = acm001.policy
     nv_chkline = NO.

    IF fi_reptyp = "1" THEN DO:
        IF FIRST-OF (acm001.branch) OR nv_reccnt = 0 THEN DO:
           RUN ChkLineExcel.
           nv_reccnt = nv_reccnt + 2.
        END.
    END.
    /* --- suthida T. A540223 01-08-11 ----*/
    n_bran     = "".
    n_bran     = acm001.branch.
   
    IF SUBSTR(acm001.policy,1,1) = "I" THEN DO:
     IF nv_brdes1 = ""  THEN NEXT loop_acm001.  
     IF INDEX(nv_brdes1,",9" + SUBSTRING(acm001.policy,2,1)) <> 0 THEN 
        n_bran = "9" + SUBSTRING(acm001.policy,2,1). 
 
    END.
    ELSE DO:    
                         
      IF acm001.branch <  frm_bran OR acm001.branch > to_bran  THEN NEXT loop_acm001.                
    END.
   /* --- end suthida T. A540223 01-08-11 ----*/

    IF  acm001.trnty1 = "U" OR acm001.trnty1 = "P" THEN DO: 
        FIND FIRST uwm200 WHERE 
                   uwm200.trtyri = acm001.trnty1 AND
                   uwm200.docri  = acm001.docno  AND
                   uwm200.policy = acm001.policy  /* AND 
                   uwm200.endcnt = 0             */ NO-LOCK NO-ERROR. /* ---- suthida T. A53-0326 18-05-11---- */
        IF AVAILABLE uwm200 THEN NEXT loop_acm001.
    END.
    ELSE DO:
        FIND FIRST uwm100 USE-INDEX uwm10090  WHERE
                   uwm100.trty11 = acm001.trnty1 AND
                   uwm100.docno1 = acm001.docno  AND  
                   uwm100.policy = acm001.policy AND
                   uwm100.releas = YES           NO-LOCK NO-ERROR.
        /*---A52-189---*/
        IF NOT AVAILABLE uwm100 THEN NEXT loop_acm001. 
    END.
   
    /* -------- suthida T. A54-0223 --------------
    FIND FIRST uwm100 USE-INDEX uwm10001 
         WHERE uwm100.policy = acm001.policy 
         AND   uwm100.rencnt = acm001.rencnt
         AND   uwm100.endcnt = acm001.endcnt 
         AND   uwm100.releas = YES NO-LOCK NO-ERROR.
    -------- suthida T. A54-0223 -------------- */ 

    /* -------- suthida T. A54-0223 -------------- */

    FIND FIRST uwm100 USE-INDEX uwm10090 WHERE
               uwm100.trty11 = acm001.trnty1 AND
               uwm100.docno1 = acm001.docno  AND
               uwm100.policy = uwm100.policy AND
               uwm100.releas = YES NO-LOCK NO-ERROR.
    /* -------- suthida T. A54-0223 -------------- */
    IF AVAIL uwm100 THEN DO: 
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
        n_policy = uwm100.policy /* --- suthida T. A53-0326 19-05-11 ----- */
        n_rencnt = uwm100.rencnt
        n_endcnt = uwm100.endcnt
        n_endno  = uwm100.endno
        n_trndat = uwm100.trndat
        n_comdat = uwm100.comdat.
      /*---------- Motor ---------*/
      IF (SUBSTRING(acm001.policy,3,2) = "70" OR SUBSTRING(acm001.policy,3,2) = "72" OR 
          SUBSTRING(acm001.policy,3,2) = "73" OR SUBSTRING(acm001.policy,3,2) = "74")  THEN DO:
      
          RUN proc_Motor.
          IF fi_reptyp = "2" THEN  RUN pro_motor. /* ---- Summary suthida t. A53-0326 19-05-11 ---- */
          RUN proc_wacm001.  /* ---- suthida T. A53-0326 18-05-11 ----- */
           
      END.      /*---if poltyp = "70" (Motor)--*/
      ELSE DO: /*------ Non Motor -------*/
            RUN proc_Non_Motor. 
            IF fi_reptyp = "2" THEN RUN pro_Nonmotor. /* ---- Summary suthida t. A53-0326 19-05-11  ----- */
            RUN proc_wacm001.  /* ---- suthida T. A53-0326 18-05-11 ----- */
      
      END.  /*--- End Non Motor ---*/

      /* ----- suthida t. A53-0326 19-05-11  -----*/
      ASSIGN
        nsd_sumper   = nv_pret   + nv_0t_pr + nv_0s_pr + nv_ppstat + nv_0RQ   + nv_f1_pr +
                       nv_f2_pr  + nv_0ps   + nv_btr   + nv_otr    + nv_f3_pr + nv_f4_pr +
                       nv_ftr    + nv_0q_pr + nv_s8    + nv_p0d    + nv_p0a   + nv_p0f 

         nsd_sumprm   = nt_ret_pr + nt_0t_pr  + nt_0s_pr  + nt_stat_pr +
                        nt_0rq_pr + nt_f1_pr  + nt_f2_pr  + nt_0ps_pr  +
                        nt_btr_pr + nt_otr_pr + nt_f3_pr  + nt_f4_pr   +
                        nt_ftr_pr + nt_0q_pr  + nt_s8_pr  + nt_0D_pr   +
                        nt_0A_pr  + nt_0F_pr.
      
       /* RUN proc_crtworkfile.*/ /* ---- suthida T. A53-0326 18-05-11 ----- */

      RUN proc_wuwm200. /* ---- suthida T. A53-0326 18-05-11 ----- */

      ASSIGN 
           nv_vol     = 0   nv_comp     = 0   nv_pa     = 0   pol_prem = 0     
           nv_vol_stp = 0   nv_comp_stp = 0   nv_pa_stp = 0   nv_stp   = 0      
           nv_vol_vat = 0   nv_comp_vat = 0   nv_pa_vat = 0   nv_vat   = 0   nv_tot_vat  = 0      
           nv_sbt     = 0   nv_tot_sbt  = 0             
           com_vol    = 0   com_comp    = 0   com_pa    = 0     
           nv_comm    = 0   nv_fee      = 0   nv_sumfee = 0. 
    END.
    ELSE NEXT loop_acm001.
END.  /*each acm001*/ 


RUN Proc_crsumd.   /* ---- clear data ----- */
RUN proc_clear.    /* ---- clear data ----- */

loop_uwm100:
FOR EACH  uwm100 NO-LOCK USE-INDEX uwm10008 
    WHERE uwm100.trndat >= frm_trndat
    AND   uwm100.trndat <= to_trndat 
    AND  SUBSTR(uwm100.policy,1,1) = "I"
    /* -------- Suthida T. A540223 02-08-11 ------- 
    AND uwm100.branch >= frm_bran
    AND uwm100.branch <= to_bran
    -------- Suthida T. A540223 02-08-11 ------- */ 
    AND INDEX(nv_brdes,"," + uwm100.branch) <> 0         /* --- suthida T. A540223 02-08-11  ---- */

    AND ( (fi_source-2     = "1"   AND  /* Motor */
           (uwm100.poltyp  = "V70" OR  
            uwm100.poltyp  = "V72" OR  
            uwm100.poltyp  = "V73" OR  
            uwm100.poltyp  = "V74"))
   OR     (fi_source-2     = "2" AND 
           (uwm100.poltyp   <> "V70" AND   /* Non- Motor */
            uwm100.poltyp   <> "V72" AND  
            uwm100.poltyp   <> "V73" AND  
            uwm100.poltyp   <> "V74")) 
   OR     (fi_source-2 = "3" AND 
          (uwm100.poltyp   <> " ")) )
   AND   uwm100.RELEAS       = YES . 

    /* ----------- suthida T. A53-0326 18-05-11 ------------ ,

   EACH uwm200 NO-LOCK USE-INDEX uwm20001
   WHERE uwm200.policy  = uwm100.policy
   AND   uwm200.rencnt  = uwm100.rencnt
   AND   uwm200.endcnt >= 1
   AND   uwm200.csftq  <> "F" ,

   FIRST wacm001 NO-LOCK 
   WHERE wacm001.policy = uwm200.policy.

   
   FIND FIRST wuwm200 
        WHERE wuwm200.policy = uwm100.policy NO-ERROR.
   IF NOT AVAIL uwm200 THEN NEXT loop_uwm100.
   ELSE DO:

       ASSIGN
          nv_policy  = ""
          nv_rencnt  = 0
          nv_endcnt  = 0
          nv_policy  = wuwm200.policy
          nv_rencnt  = wuwm200.rencnt
          nv_endcnt  = wuwm200.endcnt.

        RUN proc_uwd200 (INPUT-OUTPUT nv_policy,
                         INPUT-OUTPUT nv_rencnt,
                         INPUT-OUTPUT nv_endcnt ).  /* ------ Allocate ------- */

        ASSIGN
          wuwm200.prmret     =  nt_ret_pr             wuwm200.comret  = mret_c 
          wuwm200.prm0t      =  nt_0t_pr              wuwm200.com0t   = m0t_c  
          wuwm200.prm0s      =  nt_0s_pr              wuwm200.com0s   = m0s_c  
          wuwm200.prmstat    =  nt_stat_pr            wuwm200.comstat = mstat_c
          wuwm200.prm0rq     =  nt_0rq_pr             wuwm200.com0rq  = m0rq_c 
          wuwm200.prmf1      =  nt_f1_pr              wuwm200.comf1   = mf1_c  
          wuwm200.prmf2      =  nt_f2_pr              wuwm200.comf2   = mf2_c  
          wuwm200.prm0ps     =  nt_0ps_pr             wuwm200.com0ps  = m0ps_c 
          wuwm200.prmbtr     =  nt_btr_pr             wuwm200.combtr  = mbtr_c 
          wuwm200.prmotr     =  nt_otr_pr             wuwm200.comotr  = motr_c 
          wuwm200.prmf3      =  nt_f3_pr              wuwm200.comf3   = mf3_c  
          wuwm200.prmf4      =  nt_f4_pr              wuwm200.comf4   = mf4_c  
          wuwm200.prmftr     =  nt_ftr_pr             wuwm200.comftr  = mftr_c 
          wuwm200.prm0q      =  nt_0q_pr              wuwm200.com0q   = m0q_c  
          wuwm200.prms8      =  nt_s8_pr              wuwm200.coms8   = ms8_c  
          wuwm200.prm0d      =  nt_0D_pr              wuwm200.com0d   = m0d_c  
          wuwm200.prm0a      =  nt_0A_pr              wuwm200.com0a   = m0a_c  
          wuwm200.prm0f      =  nt_0F_pr              wuwm200.com0f   = m0f_c. 

   END. /* FIND FIRST wuwm200 if avail */
  ----------- suthida T. A53-0326 18-05-11 ------------  */
  /* --- suthida T. A540223 01-08-11 ----*/
   n_bran     = "".
   n_bran     = uwm100.branch.
    
    IF SUBSTR(uwm100.policy,1,1) = "I" THEN DO:
        IF nv_brdes1 = ""  THEN NEXT loop_uwm100.  
        IF INDEX(nv_brdes1,",9" + SUBSTRING(uwm100.policy,2,1)) <> 0 THEN 
           n_bran = "9" + SUBSTRING(uwm100.policy,2,1). 
    
    END.
    ELSE IF SUBSTR(uwm100.policy,1,1) = "D" THEN DO:    
         IF uwm100.branch <  frm_bran OR uwm100.branch > to_bran  THEN NEXT loop_uwm100.                
    END.
   /* --- end suthida T. A540223 01-08-11 ----*/

    /* ----------- suthida T. A53-0326 18-05-11 ------------ */
   FIND FIRST uwm200 NO-LOCK USE-INDEX uwm20001
        WHERE uwm200.policy  = uwm100.policy
        AND   uwm200.rencnt  = uwm100.rencnt
        AND   uwm200.endcnt  = uwm100.endcnt NO-ERROR.
   IF NOT AVAIL uwm200 THEN NEXT loop_uwm100.
   ELSE DO:

       FIND FIRST wacm001
              WHERE wacm001.policy = uwm100.policy 
              AND   wacm001.rencnt = uwm100.rencnt
              AND   wacm001.endcnt = uwm100.endcnt NO-ERROR.
       IF NOT AVAIL wacm001 THEN DO:

            ASSIGN
              n_policy       = uwm100.policy
              n_rencnt       = uwm100.rencnt
              n_endcnt       = uwm100.endcnt
              n_endno        = uwm100.endno
              n_trndat       = uwm100.trndat
              n_comdat       = uwm100.comdat
              n_poltyp       = SUBSTRING(uwm100.policy,3,2).
              /*n_bran         = uwm100.branch. ---- suthida T. A540223 01-08-11 ----- */

            IF (SUBSTRING(uwm100.policy,3,2) = "70" OR SUBSTRING(uwm100.policy,3,2) = "72" OR 
                SUBSTRING(uwm100.policy,3,2) = "73" OR SUBSTRING(uwm100.policy,3,2) = "74")  THEN DO:

                RUN proc_Motor.
                IF fi_reptyp = "2" THEN  RUN pro_motor. /* ---- Summary suthida t. A53-0326 19-05-11 ---- */
                RUN proc_wacm001. 

            END.
            ELSE DO:

                RUN proc_Non_Motor. /*------ Non Motor -------*/
                IF fi_reptyp = "2" THEN RUN pro_Nonmotor. /* ---- Summary suthida t. A53-0326 19-05-11 ---- */
                RUN proc_wacm001. 
            END.

       END. /* IF NOT AVAIL wacm001 */

       IF uwm200.csftq  <> "F"  THEN DO:
           ASSIGN
             nv_policy  = ""
             nv_rencnt  = 0
             nv_endcnt  = 0
             nv_policy  = wacm001.policy
             nv_rencnt  = wacm001.rencnt
             nv_endcnt  = wacm001.endcnt.

          RUN Proc_crsumd.   /* ---- clear data ----- */
          RUN proc_clear.    /* ---- clear data ----- */ 

          RUN proc_uwd200 (INPUT-OUTPUT nv_policy,
                           INPUT-OUTPUT nv_rencnt,
                           INPUT-OUTPUT nv_endcnt ).  /* ------ Allocate ------- */

          ASSIGN
             nsd_sumper   = nv_pret   + nv_0t_pr + nv_0s_pr + nv_ppstat + nv_0RQ   + nv_f1_pr +
                            nv_f2_pr  + nv_0ps   + nv_btr   + nv_otr    + nv_f3_pr + nv_f4_pr +
                            nv_ftr    + nv_0q_pr + nv_s8    + nv_p0d    + nv_p0a   + nv_p0f 

             nsd_sumprm   = nt_ret_pr + nt_0t_pr  + nt_0s_pr  + nt_stat_pr +
                            nt_0rq_pr + nt_f1_pr  + nt_f2_pr  + nt_0ps_pr  +
                            nt_btr_pr + nt_otr_pr + nt_f3_pr  + nt_f4_pr   +
                            nt_ftr_pr + nt_0q_pr  + nt_s8_pr  + nt_0D_pr   +
                            nt_0A_pr  + nt_0F_pr.

         RUN proc_wuwm200. /* ann 13-05-11 */ 



         ASSIGN 
              nv_vol     = 0   nv_comp     = 0   nv_pa     = 0   pol_prem = 0     
              nv_vol_stp = 0   nv_comp_stp = 0   nv_pa_stp = 0   nv_stp   = 0      
              nv_vol_vat = 0   nv_comp_vat = 0   nv_pa_vat = 0   nv_vat   = 0   nv_tot_vat  = 0      
              nv_sbt     = 0   nv_tot_sbt  = 0             
              com_vol    = 0   com_comp    = 0   com_pa    = 0        
              nv_comm    = 0   nv_fee      = 0   nv_sumfee = 0
              nsd_sumper = 0   nsd_sumprm  = 0.

       END. /* uwm200.csftq  <> "F"*/
   END. /*IF AVAIL uwm200 */
   /* ----------- suthida T. A53-0326 18-05-11 ------------*/

END.

IF fi_reptyp = "1" THEN DO:
   OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
   EXPORT DELIMITER ";" "".
   RUN DHeadTable.
   OUTPUT CLOSE.
   RUN Proc_reportIF.  /* --- suthida T. A540223 02-08-11 ----*/ 
   RUN sumDetail.    /*--By Aom Sum Detail --*/

END.  /* fi_reptyp = "1" */

IF fi_reptyp = "2" THEN RUN Proc_ProTot. /* -- Report = Summary */

RUN Proc_crsumd.   /* ---- clear data ----- */
RUN proc_clear.    /* ---- clear data ----- */
FOR EACH wacm001. DELETE wacm001. END.
FOR EACH wuwm200. DELETE wuwm200. END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_Non_Motor C-Win 
PROCEDURE proc_Non_Motor :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

 ASSIGN  
          nv_comp = 0  
          nv_pa   = 0.  
 
         /* ----------------- suthida T. A53-0326 ลบลูป  FOR EACH uwd132 ออก ---------------------
          เนื่องจาก ไม่ใช้งานลูปนี้เพราะในงาน Non-Motor ไม่มีค่า comp และ PA          
           ----------------- suthida T. A53-0326 ลบลูป  FOR EACH uwd132 ออก -------------------- */

         IF SUBSTR(uwm100.policy,1,1) = "I" THEN 
            ASSIGN nv_vol_stp = 1
                   nv_stp       = nv_vol_stp + nv_comp_stp + nv_pa_stp.
         ELSE ASSIGN nv_vol_stp = (uwm100.pstp + uwm100.rstp_t ) - nv_pa_stp - nv_comp_stp
                     nv_stp     = uwm100.rstp_t    + uwm100.pstp.  /* policy stamp */ 

         ASSIGN  
          nv_vol       = uwm100.prem_t - nv_comp   -   nv_pa
          tot_pa_stp   = tot_pa_stp    + nv_pa_stp
          tot_comp_stp = tot_comp_stp  + nv_comp_stp
          tot_vol_stp  = tot_vol_stp   + nv_vol_stp.
         
        /*Calculate VAT*/
        IF uwm100.rtax_t <> 0 THEN nv_pa_vat    = (nv_pa   + nv_pa_stp)   * uwm100.gstrat / 100.
        IF uwm100.rtax_t <> 0 THEN nv_comp_vat  = (nv_comp + nv_comp_stp) * uwm100.gstrat / 100.

        ASSIGN 
         tot_vat_pa   = tot_vat_pa   + nv_pa_vat
         tot_vat_comp = tot_vat_comp + nv_comp_vat
         tot_vat_vol  = tot_vat_vol  + nv_vol_vat
         com_per = 0.

     FIND FIRST uwm120 NO-LOCK 
          WHERE uwm120.policy = uwm100.policy
            AND uwm120.rencnt = uwm100.rencnt
            AND uwm120.endcnt = uwm100.endcnt
            AND uwm120.riskno = 1 NO-ERROR.
     IF  AVAIL uwm120 THEN DO:
         IF com_per =  0  THEN  com_per  =  uwm120.com1p.  
         ASSIGN com_pa  = TRUNCATE((nv_pa * uwm120.com1p / 100),0)
                com_pa  = com_pa * (-1).
     END.

     ASSIGN 
      com_vol      = uwm100.com1_t - com_pa
      com_comp     = uwm100.com2_t
      tot_com_pa   = tot_com_pa    + com_pa
      tot_com_vol  = tot_com_vol   + com_vol
      tot_com_comp = tot_com_comp  + com_comp
      pol_prem     = nv_vol  + nv_comp  + nv_pa    /* PREMIUM  */
      nv_comm      = com_vol + com_comp + com_pa  /* COMMISSION */
      nv_fee       = uwm100.rfee_t    /*RI DISC.  */    /*A53-0020*/
      nv_sumfee    = nv_comm + nv_fee.

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


  /*---A51-0078---*/
  IF SUBSTR(acm001.policy,1,2) = "IY" AND acm001.acno = "0APTHAI" THEN 
     ASSIGN n_ri = YES
            n_poltyp = SUBSTR(acm001.policy,3,2) + "T".
  ELSE n_ri = NO.

 ASSIGN
    nv_policy  = ""
    nv_rencnt  = 0
    nv_endcnt  = 0
    /* ---- suthida T. A53-0326 19-05 -11---- */
    nv_policy  =  n_policy 
    nv_rencnt  =  n_rencnt 
    nv_endcnt  =  n_endcnt .

     /* ---- suthida T. A53-0326 19-05 -11---- 
    nv_policy  = acm001.policy
    nv_rencnt  = acm001.rencnt
    nv_endcnt  = acm001.endcnt.
    ---- suthida T. A53-0326 19-05 -11----  */

  RUN proc_uwd200 (INPUT-OUTPUT nv_policy,
                   INPUT-OUTPUT nv_rencnt,
                   INPUT-OUTPUT nv_endcnt ).  /* ------ Allocate ------- */
 
  /* ---------- suthida t. A53-0326 19-05-11 -------------- 
  IF fi_reptyp = "2" THEN RUN pro_Nonmotor. /* ---- Summary ----- */


  ASSIGN
    nsd_sumper   = nv_pret   + nv_0t_pr + nv_0s_pr + nv_ppstat + nv_0RQ   + nv_f1_pr +
                   nv_f2_pr  + nv_0ps   + nv_btr   + nv_otr    + nv_f3_pr + nv_f4_pr +
                   nv_ftr    + nv_0q_pr + nv_s8    + nv_p0d    + nv_p0a   + nv_p0f 

    nsd_sumprm   = nt_ret_pr + nt_0t_pr  + nt_0s_pr  + nt_stat_pr +
                   nt_0rq_pr + nt_f1_pr  + nt_f2_pr  + nt_0ps_pr  +
                   nt_btr_pr + nt_otr_pr + nt_f3_pr  + nt_f4_pr   +
                   nt_ftr_pr + nt_0q_pr  + nt_s8_pr  + nt_0D_pr   +
                   nt_0A_pr  + nt_0F_pr.  
  ---------- suthida t. A53-0326 19-05-11 --------------  */

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
  RUN proc_crsummary.  /* ----- clear data summary ----- */

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
    wfsumfee = wfcomm + wffee.
    wfsum = (wfprem + wfstp + wfvat + wfsbt + wfsumfee).
    OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO.   
    RUN ChkLineExcel.
    EXPORT DELIMITER ";"
        wfbran    wfpoltyp  wfdesc  wfprem    
        wfstp     wfvat     wfprvat wfsbt     
        wfprsbt   wftotprm  wfcomm  wffee  
        wfsumfee  wfsum             
        wfretp    wfretc    w0tp    w0tc    
        w0sp      w0sc      wstatp  wstatc  
        w0rqp     w0rqc     wf1p    wf1c    
        wf2p      wf2c      w0psp   w0psc   
        wbtrp     wbtrc     wotrp   wotrc   
        wf3p      wf3c      wf4p    wf4c    
        wftrp     wftrc     w0qp    w0qc    
        ws8p      ws8c      w0Dp    w0Dc    
        w0Ap      w0Ac      w0Fp    w0Fc.    

    OUTPUT CLOSE.               
    
    ASSIGN 
     jv_bran    = wfbran  /*-: Post JV -*/
     jv_desc    = wfdesc
     jv_prem    = wfprem
     jv_stp     = wfstp
     jv_vat     = wfvat
     jv_prvat   = wfprvat
     jv_sbt     = wfsbt
     jv_prsbt   = wfprsbt
     jv_comm    = wfcomm
     jv_sum     = wfsum
     jv_fee     = wffee
     jv_sumfee  = wfsumfee
     jvg_comm   = jvg_comm + jv_comm
     jvg_sumfee = jvg_sumfee + jv_sumfee
     jv_poltyp  = SUBSTR(wfpoltyp,1,2).   /*A51-0078*/

    IF n_jv = YES THEN DO:
       
       /*A51-0078*/
       IF SUBSTR(wfpoltyp,LENGTH(wfpoltyp),1) = "T" THEN ASSIGN n_ri = YES.
       ELSE n_ri = NO.
       
       RUN Pro_Fsacc.
       RUN Pro_Poltyp.
       RUN Pro_JV.     
        
    END.

    jv_comm = 0.
    /*-: Total Branch [+],[-] -*/
    n_desbr = "Total Branch: " + wfbran + "[" + SUBSTR(wfdesc,6,1) + "]".
    
    IF LENGTH(wfbran) = 1  THEN DO: /*เช็คbranch 1 หลัก*/
    
        IF wfbran = SUBSTR(n_desbr,15,1) AND wfprem > 0 THEN RUN proc_TotBran.

        IF wfbran = SUBSTR(n_desbr,15,1) AND wfprem < 0 THEN RUN proc_TotBran2.

        IF wfbran = substr(n_desbr,15,1) AND   /*-: GrandTotal of Branch -*/
           SUBSTR(wfdesc,6,1) = SUBSTR(n_desbr,17,1) THEN DO: 

           RUN Proc_GrandTot. 

           IF  LAST-OF (wfbran) THEN  RUN pro_sumBr.
        END.

    END. /*if length(wfbran) =1 than*/

    ELSE IF LENGTH(wfbran) = 2 THEN DO: /*เช็ค branch 2 หลัก*/
        IF wfbran = SUBSTR(n_desbr,15,2) AND wfprem > 0 THEN RUN proc_TotBran.

        IF wfbran = SUBSTR(n_desbr,15,2) AND wfprem < 0 THEN RUN proc_TotBran2.

        IF wfbran = substr(n_desbr,15,2) AND   /*-: GrandTotal of Branch -*/
           SUBSTR(wfdesc,6,1) = SUBSTR(n_desbr,18,1) THEN DO:

            RUN Proc_GrandTot.

            IF  LAST-OF (wfbran) THEN DO: 
                /*RUN pro_sumBr.*/
                OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO.  
                RUN ChkLineExcel.
                EXPORT DELIMITER ";"
                    "Total Branch: " + SUBSTRI(n_desbr,15,2) + " [+]"      
                    " "         " "          np_prem      
                    np_stp      np_vat       np_prvat   np_sbt     
                    np_prsbt    np_totprm    np_comm    np_fee  np_sumfee np_sum
                    np_retp     np_sumretc   np_0tp     np_0tc       
                    np_0sp      np_0sc       np_statp   np_statc     
                    np_0rqp     np_0rqc      np_f1p     np_f1c       
                    np_f2p      np_f2c       np_0psp    np_0psc      
                    np_btrp     np_btrc      np_otrp    np_otrc      
                    np_f3p      np_f3c       np_f4p     np_f4c       
                    np_ftrp     np_ftrc      np_0qp     np_0qc       
                    np_s8p      np_s8c       np_0Dp     np_0Dc       
                    np_0Ap      np_0Ac       np_0Fp     np_0Fc  .  
                OUTPUT CLOSE.

                OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO.   
                RUN ChkLineExcel.
                EXPORT DELIMITER ";"
                    "Total Branch: " + SUBSTRI(n_desbr,15,2) + " [-]"      
                    " "          " "              ns_prem    
                    ns_stp       ns_vat           ns_prvat   ns_sbt     
                    ns_prsbt     ns_totprm        ns_comm    ns_fee ns_sumfee ns_sum
                    ns_retp      ns_sumretc       ns_0tp     ns_0tc       
                    ns_0sp       ns_0sc           ns_statp   ns_statc     
                    ns_0rqp      ns_0rqc          ns_f1p     ns_f1c       
                    ns_f2p       ns_f2c           ns_0psp    ns_0psc      
                    ns_btrp      ns_btrc          ns_otrp    ns_otrc      
                    ns_f3p       ns_f3c           ns_f4p     ns_f4c       
                    ns_ftrp      ns_ftrc          ns_0qp     ns_0qc       
                    ns_s8p       ns_s8c           ns_0Dp     ns_0Dc       
                    ns_0Ap       ns_0Ac           ns_0Fp     ns_0Fc  .  

                OUTPUT CLOSE.

                IF n_jv = YES THEN DO: 
                   IF n_source = "DI" THEN DO:

                      totsumpa = nb_prvat - sumpa.

                      RUN wac/wacazr (INPUT (-1) * (totsumpa + sumpa), jv_bran, 2, "10400073", 
                                            n_sacc1, n_sacc2, n_gldat, n_source).

                      RUN wac/wacazr (INPUT (-1) * jvg_sumfee, jv_bran, 1, "20400077", 
                                            n_sacc1, n_sacc2, n_gldat, n_source).

                   END.
                   ELSE IF n_source = "IF" THEN
                      IF n_ri = YES THEN
                      RUN wac/wacazr (INPUT (-1) * jv_summ, jv_bran, 1, "10510000", 
                                            n_sacc1, n_sacc2, n_gldat, n_source).

                END.

                OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO.   
                RUN ChkLineExcel.
                EXPORT DELIMITER ";"
                    "GrandTotal of Branch:" + SUBSTRI(n_desbr,15,2)      
                    " "          " "              nb_prem    
                    nb_stp       nb_vat           nb_prvat    nb_sbt     
                    nb_prsbt     nb_totprm        nb_comm     nb_fee nb_sumfee  nb_sum
                    nb_retp      nb_sumretc       nb_0tp      nb_0tc       
                    nb_0sp       nb_0sc           nb_statp    nb_statc     
                    nb_0rqp      nb_0rqc          nb_f1p      nb_f1c       
                    nb_f2p       nb_f2c           nb_0psp     nb_0psc      
                    nb_btrp      nb_btrc          nb_otrp     nb_otrc      
                    nb_f3p       nb_f3c           nb_f4p      nb_f4c       
                    nb_ftrp      nb_ftrc          nb_0qp      nb_0qc       
                    nb_s8p       nb_s8c           nb_0Dp      nb_0Dc       
                    nb_0Ap       nb_0Ac           nb_0Fp      nb_0Fc  .   
                OUTPUT CLOSE.             

                RUN proc_crsummary.  /* ----- clear data summary ----- */

            END.
        END.
    END.   /*else if length(wfbran) = 2 */
  END.  /* FOR EACH wfbyline */
  RUN proc_crsummary.  /* ----- clear data summary ----- */

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_reportIF C-Win 
PROCEDURE Proc_reportIF :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 FOR EACH wacm001 NO-LOCK
       BREAK BY wacm001.bran
             BY SUBSTRING(wacm001.policy,3,2)
             BY wacm001.endno
             BY wacm001.policy
             BY wacm001.rencnt
             BY wacm001.endcnt
             BY wacm001.trndat.

       FOR EACH wuwm200 
           WHERE wuwm200.policy = wacm001.policy 
           AND   wuwm200.rencnt = wacm001.rencnt
           AND   wuwm200.endcnt = wacm001.endcnt .

              OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.   
              RUN ChkLineExcel.
              EXPORT DELIMITER ";"
   
              wacm001.bran    wacm001.poltyp wacm001.policy  wacm001.rencnt 
              wacm001.endcnt  wacm001.endno  wacm001.comdat  wacm001.trndat
              wacm001.prem    wacm001.comp   wacm001.prepa   wacm001.totpre 
              wacm001.stamp   wacm001.stamc  wacm001.stampa  wacm001.totstm 
              wacm001.vatp    wacm001.vatc   wacm001.vatpa   wacm001.totvat 
              wacm001.totpvat wacm001.scb    wacm001.totpscb wacm001.comm   
              wacm001.co_comp wacm001.compa  wacm001.totcom  wacm001.ridis  
              wacm001.totdis  wacm001.prnvat 
              
              wuwm200.pepret  wuwm200.prmret  wuwm200.pecret  wuwm200.comret 
              wuwm200.pep0t   wuwm200.prm0t   wuwm200.pec0t   wuwm200.com0t  
              wuwm200.pep0s   wuwm200.prm0s   wuwm200.pec0s   wuwm200.com0s  
              wuwm200.pepstat wuwm200.prmstat wuwm200.pecstat wuwm200.comstat
              wuwm200.pep0rq  wuwm200.prm0rq  wuwm200.pec0rq  wuwm200.com0rq 
              wuwm200.pepf1   wuwm200.prmf1   wuwm200.pecf1   wuwm200.comf1  
              wuwm200.pepf2   wuwm200.prmf2   wuwm200.pecf2   wuwm200.comf2  
              wuwm200.pep0ps  wuwm200.prm0ps  wuwm200.pec0ps  wuwm200.com0ps 
              wuwm200.pepbtr  wuwm200.prmbtr  wuwm200.pecbtr  wuwm200.combtr 
              wuwm200.pepotr  wuwm200.prmotr  wuwm200.pecotr  wuwm200.comotr 
              wuwm200.pepf3   wuwm200.prmf3   wuwm200.pecf3   wuwm200.comf3  
              wuwm200.pepf4   wuwm200.prmf4   wuwm200.pecf4   wuwm200.comf4  
              wuwm200.pepftr  wuwm200.prmftr  wuwm200.pecftr  wuwm200.comftr 
              wuwm200.pep0q   wuwm200.prm0q   wuwm200.pec0q   wuwm200.com0q  
              wuwm200.peps8   wuwm200.prms8   wuwm200.pecs8   wuwm200.coms8  
              wuwm200.pep0d   wuwm200.prm0d   wuwm200.pec0d   wuwm200.com0d 
              wuwm200.pep0a   wuwm200.prm0a   wuwm200.pec0a   wuwm200.com0a
              wuwm200.pep0f   wuwm200.prm0f   wuwm200.pec0f   wuwm200.com0f  
              wuwm200.sumper  wuwm200.sumprm .
   
              RUN proc_assignsum. 
   
              OUTPUT CLOSE.
              nv_reccnt = nv_reccnt + 1.
       END. /* for each wuwm200 */
   END. /* for each wacm001 */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_TotBran C-Win 
PROCEDURE Proc_TotBran :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 ASSIGN 
   np_prem    = np_prem    + wfbyline.wfprem  
   np_stp     = np_stp     + wfbyline.wfstp   
   np_vat     = np_vat     + wfbyline.wfvat   
   np_prvat   = np_prvat   + wfbyline.wfprvat
   np_sbt     = np_sbt     + wfbyline.wfsbt   
   np_prsbt   = np_prsbt   + wfbyline.wfprsbt
   np_totprm  = np_totprm  + wfbyline.wftotprm
   np_comm    = np_comm    + wfbyline.wfcomm  
   np_sum     = np_sum     + wfbyline.wfsum
   np_fee     = np_fee     + wfbyline.wffee
   np_sumfee  = np_sumfee  + wfbyline.wfsumfee

   np_sumretc = np_sumretc + wfbyline.wfretc
   np_0tc     = np_0tc     + wfbyline.w0tc  
   np_0sc     = np_0sc     + wfbyline.w0sc  
   np_statc   = np_statc   + wfbyline.wstatc
   np_0rqc    = np_0rqc    + wfbyline.w0rqc 
   np_f1c     = np_f1c     + wfbyline.wf1c  
   np_f2c     = np_f2c     + wfbyline.wf2c  
   np_0psc    = np_0psc    + wfbyline.w0psc 
   np_btrc    = np_btrc    + wfbyline.wbtrc 
   np_otrc    = np_otrc    + wfbyline.wotrc 
   np_f3c     = np_f3c     + wfbyline.wf3c  
   np_f4c     = np_f4c     + wfbyline.wf4c  
   np_ftrc    = np_ftrc    + wfbyline.wftrc 
   np_0qc     = np_0qc     + wfbyline.w0qc  
   np_s8c     = np_s8c     + wfbyline.ws8c  
   np_0Dc     = np_0Dc     + wfbyline.w0Dc  
   np_0Ac     = np_0Ac     + wfbyline.w0Ac  
   np_0Fc     = np_0Fc     + wfbyline.w0Fc  

   np_retp    = np_retp    + wfbyline.wfretp
   np_0tp     = np_0tp     + wfbyline.w0tp  
   np_0sp     = np_0sp     + wfbyline.w0sp  
   np_statp   = np_statp   + wfbyline.wstatp
   np_0rqp    = np_0rqp    + wfbyline.w0rqp 
   np_f1p     = np_f1p     + wfbyline.wf1p  
   np_f2p     = np_f2p     + wfbyline.wf2p  
   np_0psp    = np_0psp    + wfbyline.w0psp 
   np_btrp    = np_btrp    + wfbyline.wbtrp 
   np_otrp    = np_otrp    + wfbyline.wotrp 
   np_f3p     = np_f3p     + wfbyline.wf3p  
   np_f4p     = np_f4p     + wfbyline.wf4p  
   np_ftrp    = np_ftrp    + wfbyline.wftrp 
   np_0qp     = np_0qp     + wfbyline.w0qp  
   np_s8p     = np_s8p     + wfbyline.ws8p  
   np_0Dp     = np_0Dp     + wfbyline.w0Dp  
   np_0Ap     = np_0Ap     + wfbyline.w0Ap  
   np_0Fp     = np_0Fp     + wfbyline.w0Fp  .
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_TotBran2 C-Win 
PROCEDURE proc_TotBran2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 ASSIGN 
   ns_prem    = ns_prem    + wfbyline.wfprem  
   ns_stp     = ns_stp     + wfbyline.wfstp   
   ns_vat     = ns_vat     + wfbyline.wfvat   
   ns_prvat   = ns_prvat   + wfbyline.wfprvat
   ns_sbt     = ns_sbt     + wfbyline.wfsbt   
   ns_prsbt   = ns_prsbt   + wfbyline.wfprsbt
   ns_totprm  = ns_totprm  + wfbyline.wftotprm
   ns_comm    = ns_comm    + wfbyline.wfcomm  
   ns_sum     = ns_sum     + wfbyline.wfsum
   ns_fee     = ns_fee     + wfbyline.wffee
   ns_sumfee  = ns_sumfee  + wfbyline.wfsumfee

   ns_sumretc = ns_sumretc + wfbyline.wfretc
   ns_0tc     = ns_0tc     + wfbyline.w0tc  
   ns_0sc     = ns_0sc     + wfbyline.w0sc  
   ns_statc   = ns_statc   + wfbyline.wstatc
   ns_0rqc    = ns_0rqc    + wfbyline.w0rqc 
   ns_f1c     = ns_f1c     + wfbyline.wf1c  
   ns_f2c     = ns_f2c     + wfbyline.wf2c  
   ns_0psc    = ns_0psc    + wfbyline.w0psc 
   ns_btrc    = ns_btrc    + wfbyline.wbtrc 
   ns_otrc    = ns_otrc    + wfbyline.wotrc 
   ns_f3c     = ns_f3c     + wfbyline.wf3c  
   ns_f4c     = ns_f4c     + wfbyline.wf4c  
   ns_ftrc    = ns_ftrc    + wfbyline.wftrc 
   ns_0qc     = ns_0qc     + wfbyline.w0qc  
   ns_s8c     = ns_s8c     + wfbyline.ws8c  
   ns_0Dc     = ns_0Dc     + wfbyline.w0Dc  
   ns_0Ac     = ns_0Ac     + wfbyline.w0Ac  
   ns_0Fc     = ns_0Fc     + wfbyline.w0Fc  

   ns_retp    = ns_retp    + wfbyline.wfretp
   ns_0tp     = ns_0tp     + wfbyline.w0tp  
   ns_0sp     = ns_0sp     + wfbyline.w0sp  
   ns_statp   = ns_statp   + wfbyline.wstatp
   ns_0rqp    = ns_0rqp    + wfbyline.w0rqp 
   ns_f1p     = ns_f1p     + wfbyline.wf1p  
   ns_f2p     = ns_f2p     + wfbyline.wf2p  
   ns_0psp    = ns_0psp    + wfbyline.w0psp 
   ns_btrp    = ns_btrp    + wfbyline.wbtrp 
   ns_otrp    = ns_otrp    + wfbyline.wotrp 
   ns_f3p     = ns_f3p     + wfbyline.wf3p  
   ns_f4p     = ns_f4p     + wfbyline.wf4p  
   ns_ftrp    = ns_ftrp    + wfbyline.wftrp 
   ns_0qp     = ns_0qp     + wfbyline.w0qp  
   ns_s8p     = ns_s8p     + wfbyline.ws8p  
   ns_0Dp     = ns_0Dp     + wfbyline.w0Dp  
   ns_0Ap     = ns_0Ap     + wfbyline.w0Ap  
   ns_0Fp     = ns_0Fp     + wfbyline.w0Fp  .
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_trtyfac C-Win 
PROCEDURE proc_trtyfac :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

IF  uwd200.rico  = "STAT"  THEN  DO:  /* Qbaht */

    RUN findper200 (INPUT-OUTPUT  nt_stat_pr,
                    INPUT-OUTPUT  mstat_c   ,
                    INPUT-OUTPUT  nv_sistat ,
                    INPUT-OUTPUT  nt_stat_per). /*------- find % com -------*/
END.

ELSE IF uwd200.rico  = "0RET"  THEN DO:       /*-----------ไม่ต้อง Gen JV----------*/

    RUN findper200 (INPUT-OUTPUT  nt_ret_pr ,
                    INPUT-OUTPUT  mret_c    ,
                    INPUT-OUTPUT  nv_siret  ,
                    INPUT-OUTPUT  nt_ret_per ) . /*------- find % com -------*/
END.    

ELSE IF SUBSTRING(uwd200.rico,1,2) = "0Q"  THEN DO: /* TFP */

      RUN findper200 (INPUT-OUTPUT  nt_0q_pr    ,
                      INPUT-OUTPUT  m0q_c       ,
                      INPUT-OUTPUT  nv_si0q     ,
                      INPUT-OUTPUT  nt_0q_per   ) . /*------- find % com -------*/
END.  

ELSE IF SUBSTRING(uwd200.rico,1,2) = "0T"  AND          
        SUBSTRING(uwd200.rico,6,2) = "01"  THEN DO:          /*--1ST--*/

        RUN findper200 (INPUT-OUTPUT  nt_0t_pr    ,
                        INPUT-OUTPUT  m0t_c       ,
                        INPUT-OUTPUT  nv_si0t     ,
                        INPUT-OUTPUT  nt_0t_per   ) . /*------- find % com -------*/
END.  

ELSE IF SUBSTRING(uwd200.rico,1,2) = "0T"  AND
        SUBSTRING(uwd200.rico,6,2) = "02"  THEN DO:         /*--2ND--*/

        RUN findper200 (INPUT-OUTPUT  nt_0s_pr    ,
                        INPUT-OUTPUT  m0s_c       ,
                        INPUT-OUTPUT  nv_si0s     ,
                        INPUT-OUTPUT  nt_0s_per   ) . /*------- find % com -------*/
END. 

ELSE IF SUBSTRING(uwd200.rico,1,2) = "0T"  AND
        SUBSTRING(uwd200.rico,6,2) = "F1"  THEN DO:

        RUN findper200 (INPUT-OUTPUT  nt_f1_pr    ,
                        INPUT-OUTPUT  mf1_c       ,
                        INPUT-OUTPUT  nv_sif1     ,
                        INPUT-OUTPUT  nt_f1_per   ) . /*------- find % com -------*/
END.       

ELSE IF SUBSTRING(uwd200.rico,1,2) = "0T"  AND
        SUBSTRING(uwd200.rico,6,2) = "F2"  THEN DO:

        RUN findper200 (INPUT-OUTPUT  nt_f2_pr    ,
                        INPUT-OUTPUT  mf2_c       ,
                        INPUT-OUTPUT  nv_sif2     ,
                        INPUT-OUTPUT  nt_f2_per   ) . /*------- find % com -------*/
END.

ELSE IF SUBSTRING(uwd200.rico,1,2) = "0T"  AND
        SUBSTRING(uwd200.rico,6,2) = "F3"  THEN DO:

        RUN findper200 (INPUT-OUTPUT  nt_f3_pr    ,
                        INPUT-OUTPUT  mf3_c       ,
                        INPUT-OUTPUT  nv_sif3     ,
                        INPUT-OUTPUT  nt_f3_per   ) . /*------- find % com -------*/
        
END.

ELSE IF SUBSTRING(uwd200.rico,1,2) = "0T"  AND   /* A450055*/
        SUBSTRING(uwd200.rico,6,2) = "F4"  THEN DO:

        RUN findper200 (INPUT-OUTPUT  nt_f4_pr    ,
                        INPUT-OUTPUT  mf4_c       ,
                        INPUT-OUTPUT  nv_sif4     ,
                        INPUT-OUTPUT  nt_f4_per   ) . /*------- find % com -------*/
END.

ELSE IF SUBSTRING(uwd200.rico,1,3) = "0RQ" THEN DO:    /* --- Q/S -- */

        RUN findper200 (INPUT-OUTPUT  nt_0rq_pr   , 
                        INPUT-OUTPUT  m0rq_c      , 
                        INPUT-OUTPUT  nv_si0rq    , 
                        INPUT-OUTPUT  nt_0rq_per   ) . /*------- find % com -------*/
END.

ELSE IF SUBSTRING(uwd200.rico,1,3) = "0PS" THEN DO:            /*--MPS--*/

        RUN findper200 (INPUT-OUTPUT  nt_0ps_pr   , 
                        INPUT-OUTPUT  m0ps_c      , 
                        INPUT-OUTPUT  nv_si0ps    , 
                        INPUT-OUTPUT  nt_0ps_per   ) . /*------- find % com -------*/
END.

ELSE IF SUBSTRING(uwd200.rico,1,3) = "0TF"  AND
        SUBSTRING(uwd200.rico,6,2) = "FB"  THEN DO:

        RUN findper200 (INPUT-OUTPUT  nt_btr_pr   , 
                        INPUT-OUTPUT  mbtr_c      , 
                        INPUT-OUTPUT  nv_sibtr    , 
                        INPUT-OUTPUT  nt_btr_per   ) . /*------- find % com -------*/
END.

ELSE IF SUBSTRING(uwd200.rico,1,3) = "0TF"  AND
        SUBSTRING(uwd200.rico,6,2) = "FO"  THEN DO:

        RUN findper200 (INPUT-OUTPUT  nt_otr_pr   , 
                        INPUT-OUTPUT  motr_c      , 
                        INPUT-OUTPUT  nv_siotr    , 
                        INPUT-OUTPUT  nt_otr_per   ) . /*------- find % com -------*/
END.

ELSE IF SUBSTRING(uwd200.rico,1,3) = "0TF"  AND   /* A450055*/
        SUBSTRING(uwd200.rico,6,2) = "FT"  THEN DO:

        RUN findper200 (INPUT-OUTPUT  nt_ftr_pr   , 
                        INPUT-OUTPUT  mftr_c      , 
                        INPUT-OUTPUT  nv_siftr    , 
                        INPUT-OUTPUT  nt_ftr_per   ) . /*------- find % com -------*/

END.  

ELSE IF SUBSTRING(uwd200.rico,1,4) = "0TA8"  AND           /*----ยกเลิก---*/                      
        SUBSTRING(uwd200.rico,7,1) = "2"  THEN DO:

        RUN findper200 (INPUT-OUTPUT  nt_s8_pr    , 
                        INPUT-OUTPUT  ms8_c       , 
                        INPUT-OUTPUT  nv_sis8     , 
                        INPUT-OUTPUT  nt_s8_per   ) . /*------- find % com -------*/
END.


ELSE IF uwd200.rico    <> ""   AND 
        uwd200.csftq   = "F"  THEN DO:

   FIND FIRST xmm600 USE-INDEX xmm60001 WHERE
              xmm600.acno = uwd200.rico NO-LOCK NO-ERROR.
   IF AVAIL xmm600  THEN DO:

      IF (xmm600.clicod = "RD") OR 
         (xmm600.clicod = "RB" AND xmm600.acccod = "RD") THEN DO:  /* ---- Domestic (0D)----- */ /* ---- suthida T. A540233 ---- */

          RUN findper200 (INPUT-OUTPUT  nt_0d_pr ,
                          INPUT-OUTPUT  m0d_c    ,   
                          INPUT-OUTPUT  nv_si0d  , 
                          INPUT-OUTPUT  nt_0D_per  ).  /*------- find % com -------*/
      END.
 
      IF (xmm600.clicod = "RA") OR 
         (xmm600.clicod = "RB" AND xmm600.acccod = "RA") THEN DO:   /*---- Asian (0A)----- */ /* ---- suthida T. A540233 ---- */


          RUN findper200 (INPUT-OUTPUT  nt_0a_pr ,
                          INPUT-OUTPUT  m0a_c    ,   
                          INPUT-OUTPUT  nv_si0a  , 
                          INPUT-OUTPUT  nt_0a_per  ).  /*------- find % com -------*/
      END.

      IF (xmm600.clicod = "RF") OR 
         (xmm600.clicod = "RB" AND xmm600.acccod = "RF") THEN DO:  /* ---- Foreign (0F)----- */ /* ---- suthida T. A540233 ---- */
          RUN findper200 (INPUT-OUTPUT  nt_0f_pr ,
                          INPUT-OUTPUT  m0f_c    ,   
                          INPUT-OUTPUT  nv_si0f  , 
                          INPUT-OUTPUT  nt_0f_per  ).  /*------- find % com -------*/
      END.





   END. /* FIND FIRST xmm600 */
END. /* uwd200.csftq   = "F"  */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwd200 C-Win 
PROCEDURE proc_uwd200 :
/*------------------------------------------------------------------------------
  Purpose:   Add value rico to variable
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DEF INPUT-OUTPUT PARAMETER nv_policy1  AS CHAR  FORMAT "X(20)".
DEF INPUT-OUTPUT PARAMETER nv_rencnt1  AS INT   FORMAT ">9" .  
DEF INPUT-OUTPUT PARAMETER nv_endcnt1  AS INT   FORMAT "999".  

RUN proc_clear.

FOR EACH uwd200 USE-INDEX uwd20001   WHERE
         uwd200.policy = nv_policy1  AND
         uwd200.rencnt = nv_rencnt1  AND
         uwd200.endcnt = nv_endcnt1  AND
         uwd200.csftq  <> "C"        NO-LOCK.

    RUN proc_trtyfac. /* find RI =>  % com / premium Com / SI By RI /premium  */

    nt_var_per1  =  nt_var_per1  + uwd200.risi. /* total SI policy */

    
END.   /* each uwm200 */


IF  nt_var_per1 <> 0 THEN DO: /* เช็คในการณีที่ ไม่เข้าลูป FOR EACH uwd200 
                                 ค่าที่ได้จะเป็นคำนวนตามหลักคณิตศาสร์จะผิด
                                 ส่วนห้ามเป็น 0 */
    /*---------------- % premium ------------- */
    ASSIGN
      nv_p0d    = (nv_si0d   * 100 ) / nt_var_per1
      nv_p0a    = (nv_si0a   * 100 ) / nt_var_per1
      nv_p0f    = (nv_si0f   * 100 ) / nt_var_per1
      nv_pret   = (nv_siret  * 100 ) / nt_var_per1
      nv_ppstat = (nv_sistat * 100 ) / nt_var_per1
      nv_0q_pr  = (nv_si0q   * 100 ) / nt_var_per1
      nv_0t_pr  = (nv_si0t   * 100 ) / nt_var_per1
      nv_0S_pr  = (nv_si0s   * 100 ) / nt_var_per1
      nv_f1_pr  = (nv_sif1   * 100 ) / nt_var_per1
      nv_f2_pr  = (nv_sif2   * 100 ) / nt_var_per1
      nv_f3_pr  = (nv_sif3   * 100 ) / nt_var_per1
      nv_f4_pr  = (nv_sif4   * 100 ) / nt_var_per1
      nv_0RQ    = (nv_si0rq  * 100 ) / nt_var_per1
      nv_0ps    = (nv_si0ps  * 100 ) / nt_var_per1
      nv_btr    = (nv_sibtr  * 100 ) / nt_var_per1
      nv_otr    = (nv_siotr  * 100 ) / nt_var_per1
      nv_s8     = (nv_sis8   * 100 ) / nt_var_per1
      nv_ftr    = (nv_siftr  * 100 ) / nt_var_per1.
END.

ASSIGN
  nv_si0d     = 0 nv_si0a     = 0 nv_si0f     = 0 nv_siret    = 0 
  nv_sistat   = 0 nv_si0q     = 0 nv_si0t     = 0 nv_si0s     = 0 
  nv_sif1     = 0 nv_sif2     = 0 nv_sif3     = 0 nv_sif4     = 0 
  nv_si0rq    = 0 nv_si0ps    = 0 nv_sibtr    = 0 nv_siotr    = 0 
  nv_sis8     = 0 nv_siftr    = 0 nt_var_per1 = 0.

RUN proc_var.     /*---- ann suthida T. A54-0223 2907-11 --- */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_var C-Win 
PROCEDURE proc_var :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  /* premuim */
  /*  ---------------------- suthida t. A54-0223 15-08-11 ---------------
  IF nt_stat_pr < -1 THEN nt_stat_pr = nt_stat_pr * (-1). /* stat*/
  ELSE nt_stat_pr = nt_stat_pr.
  
  IF nt_ret_pr < -1 THEN nt_ret_pr = nt_ret_pr * (-1). /* retention*/
  ELSE nt_ret_pr = nt_ret_pr.
  
  IF nt_0t_pr < -1 THEN nt_0t_pr = nt_0t_pr * (-1).       /*--1ST--*/
  ELSE nt_0t_pr = nt_0t_pr.                               

  IF nt_0s_pr < -1 THEN nt_0s_pr = nt_0s_pr * (-1).       /*--2ND--*/
  ELSE nt_0s_pr = nt_0s_pr.                               

  IF nt_0rq_pr < -1 THEN nt_0rq_pr = nt_0rq_pr * (-1).    /*--Q/S--*/
  ELSE nt_0rq_pr = nt_0rq_pr.                             

  IF nt_0q_pr < -1 THEN nt_0q_pr = nt_0q_pr * (-1).       /*--TFP--*/
  ELSE nt_0q_pr = nt_0q_pr.                               

  IF nt_f1_pr < -1 THEN nt_f1_pr = nt_f1_pr * (-1).       /*--F1--*/
  ELSE nt_f1_pr = nt_f1_pr.                               
                                                        
  IF nt_f2_pr < -1 THEN nt_f2_pr = nt_f2_pr * (-1).       /*--F2--*/
  ELSE nt_f2_pr = nt_f2_pr.                               

  IF nt_0ps_pr < -1 THEN nt_0ps_pr = nt_0ps_pr * (-1).    /*--MPS--*/ 
  ELSE nt_0ps_pr = nt_0ps_pr.                             

  IF nt_btr_pr < -1 THEN nt_btr_pr = nt_btr_pr * (-1).    /*--BTR--*/
  ELSE nt_btr_pr = nt_btr_pr.                             

  IF nt_otr_pr < -1 THEN nt_otr_pr = nt_otr_pr * (-1).    /*--OTR--*/
  ELSE nt_otr_pr = nt_otr_pr.                             
                                                        
  IF nt_f3_pr < -1 THEN nt_f3_pr = nt_f3_pr * (-1).       /*--F3--*/
  ELSE nt_f3_pr = nt_f3_pr.                               
                                                        
  IF nt_f4_pr < -1 THEN nt_f4_pr = nt_f4_pr * (-1).       /*--F4--*/
  ELSE nt_f4_pr = nt_f4_pr.      

  IF nt_0q_pr  < -1 THEN nt_0q_pr  = nt_0q_pr  * (-1).    /*--TFP --*/
  ELSE nt_0q_pr  = nt_0q_pr.

  IF nt_ftr_pr < -1 THEN nt_ftr_pr = nt_ftr_pr * (-1).    /*--S8--*/
  ELSE nt_ftr_pr = nt_ftr_pr.   

  IF nt_0A_pr < -1 THEN nt_0A_pr = nt_0A_pr * (-1).       /*--0A--*/
  ELSE nt_0A_pr = nt_0A_pr. 

 IF nt_0D_pr < -1 THEN nt_0D_pr = nt_0D_pr * (-1).       /*--0D--*/
 ELSE nt_0D_pr = nt_0D_pr.                             

 IF nt_0F_pr < -1 THEN nt_0F_pr = nt_0F_pr * (-1).       /*--0F--*/
 ELSE nt_0F_pr = nt_0F_pr.                             

/* Comm */
  IF mstat_c < -1 THEN mstat_c = mstat_c * (-1).    /* stat*/     
  ELSE mstat_c = mstat_c.                                   
                                                            
  IF mret_c < -1 THEN mret_c = mret_c * (-1).       /* retention*/
  ELSE mret_c = mret_c.                                     
                                                            
  IF m0t_c < -1 THEN m0t_c = m0t_c * (-1).          /*--1ST--*/   
  ELSE m0t_c = m0t_c.                                       
                                                            
  IF m0s_c < -1 THEN m0s_c = m0s_c * (-1).          /*--2ND--*/   
  ELSE m0s_c = m0s_c.                                       
                                                            
  IF m0rq_c < -1 THEN m0rq_c = m0rq_c * (-1).       /*--Q/S--*/   
  ELSE m0rq_c = m0rq_c.                             

  IF m0q_c < -1 THEN m0q_c = m0q_c * (-1).          /*--TFP--*/ 
  ELSE m0q_c = m0q_c.                               

  IF mf1_c < -1 THEN mf1_c = mf1_c * (-1).          /*--F1--*/ 
  ELSE mf1_c = mf1_c.                               

  IF mf2_c < -1 THEN mf2_c = mf2_c * (-1).          /*--F2--*/ 
  ELSE mf2_c = mf2_c.                               

  IF m0ps_c < -1 THEN m0ps_c = m0ps_c * (-1).       /*--MPS--*/
  ELSE m0ps_c = m0ps_c.                                        
                                                               
  IF mbtr_c < -1 THEN mbtr_c = mbtr_c * (-1).       /*--BTR--*/
  ELSE mbtr_c = mbtr_c.                                        
                                                               
  IF motr_c < -1 THEN motr_c = motr_c * (-1).       /*--OTR--*/
  ELSE motr_c = motr_c.                             

  IF mf3_c < -1 THEN mf3_c = mf3_c * (-1).          /*--F3--*/ 
  ELSE mf3_c = mf3_c.                               

  IF mf4_c < -1 THEN mf4_c = mf4_c * (-1).          /*--F4--*/ 
  ELSE mf4_c = mf4_c.                               

  IF m0q_c < -1 THEN m0q_c = m0q_c * (-1).          /*--TFP --*/ 
  ELSE m0q_c = m0q_c.   

  IF mftr_c < -1 THEN mftr_c = mftr_c * (-1).       /*--S8--*/
  ELSE mftr_c = mftr_c.  

  IF m0a_c < -1 THEN m0a_c = m0a_c * (-1).       /*--0A--*/
  ELSE m0a_c = m0a_c.  

  IF m0d_c < -1 THEN m0d_c = m0d_c * (-1).       /*--0D--*/
  ELSE m0d_c = m0d_c.

  IF m0f_c < -1 THEN m0f_c = m0f_c * (-1).       /*--0F--*/
  ELSE m0f_c = m0f_c.       
  ---------------------- suthida t. A54-0223 15-08-11 --------------- */
  
  
  /* ---------------------- suthida t. A54-0223 15-08-11 --------------- */
  ASSIGN
  
    nt_stat_pr  = nt_stat_pr    * (-1)  /* stat*/
    nt_0t_pr    = nt_0t_pr      * (-1)  /*--1ST--*/
    nt_0s_pr    = nt_0s_pr      * (-1)  /*--2ND--*/
    nt_0rq_pr   = nt_0rq_pr     * (-1)  /*--Q/S--*/
    nt_0q_pr    = nt_0q_pr      * (-1)  /*--TFP--*/
    nt_f1_pr    = nt_f1_pr      * (-1)  /*--F1--*/
    nt_f2_pr    = nt_f2_pr      * (-1)  /*--F2--*/
    nt_0ps_pr   = nt_0ps_pr     * (-1)  /*--MPS--*/ 
    nt_btr_pr   = nt_btr_pr     * (-1)  /*--BTR--*/
    nt_otr_pr   = nt_otr_pr     * (-1)  /*--OTR--*/
    nt_f3_pr    = nt_f3_pr      * (-1)  /*--F3--*/
    nt_f4_pr    = nt_f4_pr      * (-1)  /*--F4--*/
    nt_0q_pr    = nt_0q_pr      * (-1)  /*--TFP --*/
    nt_ftr_pr   = nt_ftr_pr     * (-1)  /*--S8--*/
    nt_0A_pr    = nt_0A_pr      * (-1)  /*--0A--*/
    nt_0D_pr    = nt_0D_pr      * (-1)  /*--0D--*/
    nt_0F_pr    = nt_0F_pr      * (-1). /*--0F--*/

/* Comm */
  ASSIGN
    mstat_c = mstat_c * (-1)    /* stat*/     
    m0t_c   = m0t_c   * (-1)    /*--1ST--*/   
    m0s_c   = m0s_c   * (-1)    /*--2ND--*/   
    m0rq_c  = m0rq_c  * (-1)    /*--Q/S--*/   
    m0q_c   = m0q_c   * (-1)    /*--TFP--*/ 
    mf1_c   = mf1_c   * (-1)    /*--F1--*/ 
    mf2_c   = mf2_c   * (-1)    /*--F2--*/ 
    m0ps_c  = m0ps_c  * (-1)    /*--MPS--*/
    mbtr_c  = mbtr_c  * (-1)    /*--BTR--*/
    motr_c  = motr_c  * (-1)    /*--OTR--*/
    mf3_c   = mf3_c   * (-1)    /*--F3--*/ 
    mf4_c   = mf4_c   * (-1)    /*--F4--*/ 
    m0q_c   = m0q_c   * (-1)    /*--TFP --*/ 
    mftr_c  = mftr_c  * (-1)    /*--S8--*/
    m0a_c   = m0a_c   * (-1)    /*--0A--*/
    m0d_c   = m0d_c   * (-1)    /*--0D--*/
    m0f_c   = m0f_c   * (-1).   /*--0F--*/
  /* ---------------------- suthida t. A54-0223 15-08-11 --------------- */
  
  
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_wacm001 C-Win 
PROCEDURE proc_wacm001 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    CREATE wacm001.
    ASSIGN 
      wacm001.policy  = n_policy
      wacm001.rencnt  = n_rencnt
      wacm001.endcnt  = n_endcnt
      wacm001.endno   = n_endno 
      wacm001.trndat  = n_trndat
      wacm001.comdat  = n_comdat
      wacm001.poltyp  = n_poltyp
      wacm001.bran    = n_bran
      wacm001.prem    = nv_vol          
      wacm001.comp    = nv_comp
      wacm001.prepa   = nv_pa
      wacm001.totpre  = pol_prem
      wacm001.stamp   = nv_vol_stp
      wacm001.stamc   = nv_comp_stp
      wacm001.stampa  = nv_pa_stp
      wacm001.totstm  = nv_stp
      wacm001.vatp    = nv_vol_vat
      wacm001.vatc    = nv_comp_vat
      wacm001.vatpa   = nv_pa_vat
      wacm001.totvat  = nv_vat
      wacm001.totpvat = nv_tot_vat
      wacm001.scb     = nv_sbt
      wacm001.totpscb = nv_tot_sbt
      wacm001.comm    = com_vol
      wacm001.co_comp = com_comp
      wacm001.compa   = com_pa
      wacm001.totcom  = nv_comm
      wacm001.ridis   = nv_fee
      wacm001.totdis  = nv_sumfee
      wacm001.prnvat  = n_prnvat.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_wuwm200 C-Win 
PROCEDURE proc_wuwm200 :
/*------------------------------------------------------------------------------
  Purpose:  Create data to Workfile
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* ----------- suthida T. A53-0326 10-05-11 ------------ 
  CREATE wacm001.
    ASSIGN 
      wacm001.policy  = n_policy
      wacm001.rencnt  = n_rencnt
      wacm001.endcnt  = n_endcnt
      wacm001.endno   = n_endno 
      wacm001.trndat  = n_trndat
      wacm001.comdat  = n_comdat
      wacm001.poltyp  = n_poltyp
      wacm001.bran    = n_bran
      wacm001.prem    = nv_vol          
      wacm001.comp    = nv_comp
      wacm001.prepa   = nv_pa
      wacm001.totpre  = pol_prem
      wacm001.stamp   = nv_vol_stp
      wacm001.stamc   = nv_comp_stp
      wacm001.stampa  = nv_pa_stp
      wacm001.totstm  = nv_stp
      wacm001.vatp    = nv_vol_vat
      wacm001.vatc    = nv_comp_vat
      wacm001.vatpa   = nv_pa_vat
      wacm001.totvat  = nv_vat
      wacm001.totpvat = nv_tot_vat
      wacm001.scb     = nv_sbt
      wacm001.totpscb = nv_tot_sbt
      wacm001.comm    = com_vol
      wacm001.co_comp = com_comp
      wacm001.compa   = com_pa
      wacm001.totcom  = nv_comm
      wacm001.ridis   = nv_fee
      wacm001.totdis  = nv_sumfee
      wacm001.prnvat  = n_prnvat. 
  ----------- suthida T. A53-0326 10-05-11 ------------ */

   FIND FIRST wuwm200 
        WHERE wuwm200.policy = wacm001.policy 
        AND   wuwm200.rencnt = wacm001.rencnt 
        AND   wuwm200.endcnt = wacm001.endcnt NO-ERROR.
   IF NOT AVAIL wuwm200  THEN DO:
     CREATE wuwm200.
        ASSIGN
          wuwm200.policy  = n_policy
          wuwm200.rencnt  = n_rencnt
          wuwm200.endcnt  = n_endcnt
          wuwm200.pepret  = nv_pret
          wuwm200.prmret  = nt_ret_pr
          wuwm200.pecret  = nt_ret_per
          wuwm200.comret  = mret_c
          wuwm200.pep0t   = nv_0t_pr    
          wuwm200.prm0t   = nt_0t_pr     
          wuwm200.pec0t   = nt_0t_per      
          wuwm200.com0t   = m0t_c
          wuwm200.pep0s   = nv_0s_pr    
          wuwm200.prm0s   = nt_0s_pr     
          wuwm200.pec0s   = nt_0s_per     
          wuwm200.com0s   = m0s_c
          wuwm200.pepstat = nv_ppstat   
          wuwm200.prmstat = nt_stat_pr   
          wuwm200.pecstat = nt_stat_per   
          wuwm200.comstat = mstat_c
          wuwm200.pep0rq  = nv_0RQ      
          wuwm200.prm0rq  = nt_0rq_pr    
          wuwm200.pec0rq  = nt_0rq_per    
          wuwm200.com0rq  = m0rq_c
          wuwm200.pepf1   = nv_f1_pr    
          wuwm200.prmf1   = nt_f1_pr     
          wuwm200.pecf1   = nt_f1_per     
          wuwm200.comf1   = mf1_c
          wuwm200.pepf2   = nv_f2_pr      
          wuwm200.prmf2   = nt_f2_pr     
          wuwm200.pecf2   = nt_f2_per     
          wuwm200.comf2   = mf2_c
          wuwm200.pep0ps  = nv_0ps       
          wuwm200.prm0ps  = nt_0ps_pr    
          wuwm200.pec0ps  = nt_0ps_per    
          wuwm200.com0ps  = m0ps_c
          wuwm200.pepbtr  = nv_btr        
          wuwm200.prmbtr  = nt_btr_pr     
          wuwm200.pecbtr  = nt_btr_per    
          wuwm200.combtr  = mbtr_c
          wuwm200.pepotr  = nv_otr       
          wuwm200.prmotr  = nt_otr_pr     
          wuwm200.pecotr  = nt_otr_per    
          wuwm200.comotr  = motr_c
          wuwm200.pepf3   = nv_f3_pr        
          wuwm200.prmf3   = nt_f3_pr     
          wuwm200.pecf3   = nt_f3_per     
          wuwm200.comf3   = mf3_c
          wuwm200.pepf4   = nv_f4_pr       
          wuwm200.prmf4   = nt_f4_pr     
          wuwm200.pecf4   = nt_f4_per     
          wuwm200.comf4   = mf4_c
          wuwm200.pepftr  = nv_ftr         
          wuwm200.prmftr  = nt_ftr_pr    
          wuwm200.pecftr  = nt_ftr_per    
          wuwm200.comftr  = mftr_c
          wuwm200.pep0q   = nv_0q_pr     
          wuwm200.prm0q   = nt_0q_pr      
          wuwm200.pec0q   = nt_0q_per     
          wuwm200.com0q   = m0q_c
          wuwm200.peps8   = nv_s8            
          wuwm200.prms8   = nt_s8_pr      
          wuwm200.pecs8   = nt_s8_per     
          wuwm200.coms8   = ms8_c
          wuwm200.pep0d   = nv_p0d         
          wuwm200.prm0d   = nt_0D_pr        
          wuwm200.pec0d   = nt_0d_per     
          wuwm200.com0d   = m0d_c
          wuwm200.pep0a   = nv_p0a          
          wuwm200.prm0a   = nt_0A_pr         
          wuwm200.pec0a   = nt_0a_per     
          wuwm200.com0a   = m0a_c
          wuwm200.pep0f   = nv_p0f            
          wuwm200.prm0f   = nt_0F_pr     
          wuwm200.pec0f   = nt_0f_per     
          wuwm200.com0f   = m0f_c
          wuwm200.sumper  = nsd_sumper  
          wuwm200.sumprm  = nsd_sumprm.
   END.
   ELSE DO: /* ann 13-05-11 */

        ASSIGN
                wuwm200.prmret     =  nt_ret_pr         wuwm200.comret  = mret_c 
                wuwm200.prm0t      =  nt_0t_pr          wuwm200.com0t   = m0t_c  
                wuwm200.prm0s      =  nt_0s_pr          wuwm200.com0s   = m0s_c  
                wuwm200.prmstat    =  nt_stat_pr        wuwm200.comstat = mstat_c
                wuwm200.prm0rq     =  nt_0rq_pr         wuwm200.com0rq  = m0rq_c 
                wuwm200.prmf1      =  nt_f1_pr          wuwm200.comf1   = mf1_c  
                wuwm200.prmf2      =  nt_f2_pr          wuwm200.comf2   = mf2_c  
                wuwm200.prm0ps     =  nt_0ps_pr         wuwm200.com0ps  = m0ps_c 
                wuwm200.prmbtr     =  nt_btr_pr         wuwm200.combtr  = mbtr_c 
                wuwm200.prmotr     =  nt_otr_pr         wuwm200.comotr  = motr_c 
                wuwm200.prmf3      =  nt_f3_pr          wuwm200.comf3   = mf3_c  
                wuwm200.prmf4      =  nt_f4_pr          wuwm200.comf4   = mf4_c  
                wuwm200.prmftr     =  nt_ftr_pr         wuwm200.comftr  = mftr_c 
                wuwm200.prm0q      =  nt_0q_pr          wuwm200.com0q   = m0q_c  
                wuwm200.prms8      =  nt_s8_pr          wuwm200.coms8   = ms8_c  
                wuwm200.prm0d      =  nt_0D_pr          wuwm200.com0d   = m0d_c  
                wuwm200.prm0a      =  nt_0A_pr          wuwm200.com0a   = m0a_c  
                wuwm200.prm0f      =  nt_0F_pr          wuwm200.com0f   = m0f_c
                wuwm200.sumper     =  nsd_sumper        wuwm200.sumprm  = nsd_sumprm. 



   END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_creallowf C-Win 
PROCEDURE pro_creallowf :
/*------------------------------------------------------------------------------
  Purpose:   create data Allocate premium to workfile for Summary file
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  ASSIGN /*---- Allocate premium ------- */ 

    wfbyline.wfretc   = wfbyline.wfretc  + mret_c 
    wfbyline.w0tc     = wfbyline.w0tc    + m0t_c      
    wfbyline.w0sc     = wfbyline.w0sc    + m0s_c      
    wfbyline.wstatc   = wfbyline.wstatc  + mstat_c    
    wfbyline.w0rqc    = wfbyline.w0rqc   + m0rq_c     
    wfbyline.wf1c     = wfbyline.wf1c    + mf1_c      
    wfbyline.wf2c     = wfbyline.wf2c    + mf2_c      
    wfbyline.w0psc    = wfbyline.w0psc   + m0ps_c     
    wfbyline.wbtrc    = wfbyline.wbtrc   + mbtr_c     
    wfbyline.wotrc    = wfbyline.wotrc   + motr_c     
    wfbyline.wf3c     = wfbyline.wf3c    + mf3_c      
    wfbyline.wf4c     = wfbyline.wf4c    + mf4_c     
    wfbyline.wftrc    = wfbyline.wftrc   + mftr_c     
    wfbyline.w0qc     = wfbyline.w0qc    + m0q_c      
    wfbyline.ws8c     = wfbyline.ws8c    + ms8_c      
    wfbyline.w0Dc     = wfbyline.w0Dc    + m0d_c      
    wfbyline.w0Ac     = wfbyline.w0Ac    + m0a_c      
    wfbyline.w0Fc     = wfbyline.w0Fc    + m0f_c      
    wfbyline.wfretp   = wfbyline.wfretp  + nt_ret_pr
    wfbyline.w0tp     = wfbyline.w0tp    + nt_0t_pr  
    wfbyline.w0sp     = wfbyline.w0sp    + nt_0s_pr  
    wfbyline.wstatp   = wfbyline.wstatp  + nt_stat_pr
    wfbyline.w0rqp    = wfbyline.w0rqp   + nt_0rq_pr 
    wfbyline.wf1p     = wfbyline.wf1p    + nt_f1_pr  
    wfbyline.wf2p     = wfbyline.wf2p    + nt_f2_pr
    wfbyline.w0psp    = wfbyline.w0psp   + nt_0ps_pr
    wfbyline.wbtrp    = wfbyline.wbtrp   + nt_btr_pr
    wfbyline.wotrp    = wfbyline.wotrp   + nt_otr_pr
    wfbyline.wf3p     = wfbyline.wf3p    + nt_f3_pr 
    wfbyline.wf4p     = wfbyline.wf4p    + nt_f4_pr 
    wfbyline.wftrp    = wfbyline.wftrp   + nt_ftr_pr
    wfbyline.w0qp     = wfbyline.w0qp    + nt_0q_pr 
    wfbyline.ws8p     = wfbyline.ws8p    + nt_s8_pr 
    wfbyline.w0Dp     = wfbyline.w0Dp    + nt_0D_pr 
    wfbyline.w0Ap     = wfbyline.w0Ap    + nt_0A_pr 
    wfbyline.w0Fp     = wfbyline.w0Fp    + nt_0F_pr .

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
IF n_jv = YES  THEN DO:
   IF  n_source = "DI" THEN DO:
       RUN wac/wacazr (INPUT jv_sbt, jv_bran, 2, "20710004",     /* SBT */
           n_sacc1, n_sacc2, n_gldat, n_source).

       RUN wac/wacazr (INPUT jv_vat, jv_bran, 2, "20710006",     /* VAT */
           n_sacc1, n_sacc2, n_gldat, n_source).

       RUN wac/wacazr (INPUT jv_stp, jv_bran, 2, "73024030",     /* STP */
           n_sacc1, n_sacc2, n_gldat, n_source).

       RUN wac/wacazr (INPUT (-1) * jv_prsbt, jv_bran, 2,"10400071", /*TOTPrem. SBT*/
           n_sacc1, n_sacc2, n_gldat, n_source).
   END.
   ELSE IF n_source = "IF" THEN DO:
       RUN wac/wacazr (INPUT jv_sbt, jv_bran, 2, "20710004",     /* SBT */
           n_sacc1, n_sacc2, n_gldat, n_source).

       RUN wac/wacazr (INPUT jv_vat, jv_bran, 2, "20710006",     /* VAT */
           n_sacc1, n_sacc2, n_gldat, n_source).

       RUN wac/wacazr (INPUT jv_stp, jv_bran, 2, "73024030",     /* STP */
           n_sacc1, n_sacc2, n_gldat, n_source).

       ASSIGN  jv_summ = jv_summ + jv_sum.  /*(jv_prem  + jv_comm + jv_sbt + jv_vat + jv_stp + jv_fee).*/
    END.  /* n_jv */
END.

/**** PA ****/
IF jv_poltyp >= "72" AND jv_poltyp <= "74" THEN  /* Sum TOTPrem.VAT Line72-74*/
    ASSIGN sumpa = sumpa + jv_prvat.
/**END PA**/

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
          ASSIGN wfpoltyp = "70" 
                 wfbran   =  n_bran
                 wfdesc   = "prem + ". 
       END. 
       
       ASSIGN wfprem   = wfprem + nv_vol
              wfvat    = wfvat  + nv_vol_vat
              wfstp    = wfstp  + nv_vol_stp
              wfcomm   = wfcomm + com_vol
              wfprvat  = wfprem + wfvat + wfstp      /*By Aom*/
              wftotprm = wfprvat.

       RUN pro_creallowf.  /* --- create allocate to wfbyline เก็บค่าไว้ที่70 ไม่ต้องแยก เป็น 70PA 
                                  หรือ 71 เพราะทั้งหมดคืองาน 70 ค่ะ ----- */
    
    END. /*End if nv_vol > 0*/
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
    
        ASSIGN wfprem   = wfprem + nv_vol
               wfvat    = wfvat  + nv_vol_vat
               wfstp    = wfstp  + nv_vol_stp
               wfcomm   = wfcomm + com_vol
               wfprvat  = wfprem + wfvat + wfstp   /*By Aom*/
               wftotprm = wfprvat.
    
        RUN pro_creallowf.  /* --- create allocate to wfbyline  ----- */
    END.
    
    IF  nv_comp  > 0 THEN DO:
        FIND FIRST wfbyline WHERE wfpoltyp = "71"      AND
                                  wfbran   =  n_bran    AND
                                  wfdesc   = "prem + " NO-ERROR. 
         IF NOT AVAILABLE wfbyline THEN DO:
            CREATE wfbyline.
            ASSIGN wfpoltyp = "71" 
                   wfbran   =  n_bran
                   wfdesc   = "prem + ". 
         END. 
    
         ASSIGN wfprem   = wfprem + nv_comp
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
             ASSIGN wfpoltyp = "71" 
                    wfbran   =  n_bran
                    wfdesc   = "prem - ". 
          END. 
    
          ASSIGN wfprem   = wfprem + nv_comp
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
           ASSIGN wfpoltyp = "70PA"
                  wfbran   =  n_bran 
                  wfdesc   = "prem + ". 
        END.    
        
        ASSIGN wfprem   = wfprem + nv_pa
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
            ASSIGN wfpoltyp = "70PA"
                   wfbran   = n_bran 
                   wfdesc   = "prem - ". 
         END.
    
         ASSIGN wfprem   = wfprem + nv_pa
                wfvat    = wfvat  + nv_pa_vat
                wfstp    = wfstp  + nv_pa_stp
                wfcomm   = wfcomm + com_pa
                wfprvat  = wfprem + wfvat + wfstp    /*By Aom */
                wftotprm = wfprvat.
    
    END.

END. /*---if "70"---*/

ELSE DO:        /*-- 72,73,74 --*/
    IF  nv_comp  > 0 THEN DO:
        FIND FIRST wfbyline WHERE wfpoltyp = SUBSTR(acm001.policy,3,2)  AND
                                  wfbran   =  n_bran    AND
                                  wfdesc   = "prem + " NO-ERROR. 
        IF NOT AVAILABLE wfbyline THEN DO:
           CREATE wfbyline.
           ASSIGN wfpoltyp = SUBSTR(acm001.policy,3,2) 
                   wfbran   =  n_bran
                   wfdesc   = "prem + ". 
        END.    
        
        ASSIGN wfprem   = wfprem + nv_comp
               wfvat    = wfvat  + nv_comp_vat
               wfstp    = wfstp  + nv_comp_stp
               wfcomm   = wfcomm + com_vol
               wfprvat  = wfprem + wfvat + wfstp    /*By Aom*/
               wftotprm = wfprvat.
        
        RUN pro_creallowf.  /* --- create allocate to wfbyline  ----- */

    END.
    ELSE DO:
           FIND FIRST wfbyline WHERE wfpoltyp  = SUBSTR(acm001.policy,3,2) AND
                                     wfbran    = n_bran     AND
                                     wfdesc    = "prem - "  NO-ERROR. 
           IF NOT AVAILABLE wfbyline THEN DO:
              CREATE wfbyline.
              ASSIGN wfpoltyp = SUBSTR(acm001.policy,3,2)
                     wfbran   =  n_bran
                     wfdesc   = "prem - ". 
           END.    
    
           ASSIGN wfprem   = wfprem + nv_comp
                  wfvat    = wfvat  + nv_comp_vat
                  wfstp    = wfstp  + nv_comp_stp
                  wfcomm   = wfcomm + com_vol
                  wfprvat  = wfprem + wfvat + wfstp   /*By Aom */
                  wftotprm = wfprvat.
    
           RUN pro_creallowf.  /* --- create allocate to wfbyline  ----- */
    
    END.

END. /*End else 72,73,74 */

ASSIGN  nv_vol      = 0     nv_vol_vat  = 0      
        nv_vol_stp  = 0     com_vol     = 0
        nv_comp     = 0     nv_comp_vat = 0
        nv_comp_stp = 0     com_comp    = 0
        nv_pa       = 0     nv_pa_vat   = 0
        nv_pa_stp   = 0     com_pa      = 0.
    

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
IF n_ri = YES THEN DO:       /*---Yes = InwTreaty, No = InwFAC ---*/
   IF acm001.prem  > 0 THEN  DO:
      /* FIND FIRST wfbyline WHERE wfpoltyp = SUBSTR(acm001.policy,3,2)  + "T" AND   ---- suthida t. A540223 02-08-11 --- */
      FIND FIRST wfbyline WHERE wfpoltyp = SUBSTR(n_policy,3,2)  + "T" AND /* --- suthida t. A540223 02-08-11 --- */
                                wfbran   = n_bran AND
                                wfdesc   = "prem + " NO-ERROR.
      IF NOT AVAIL wfbyline THEN DO:
         CREATE wfbyline.
         /*ASSIGN wfpoltyp = SUBSTR(acm001.policy,3,2) + "T"  --- suthida t. A540223 02-08-11 --- */
         ASSIGN wfpoltyp = SUBSTR(n_policy,3,2) + "T" /* --- suthida t. A540223 02-08-11 --- */
                wfbran   = n_bran
                wfdesc   = "prem + ".
      END.
      wfprem = wfprem + pol_prem.
   END.
   ELSE DO:
        /* FIND FIRST wfbyline WHERE wfpoltyp  = SUBSTR(acm001.policy,3,2)  + "T"  AND --- suthida t. A540223 02-08-11 ---  */
        FIND FIRST wfbyline WHERE wfpoltyp  = SUBSTR(n_policy,3,2)  + "T"  AND /* --- suthida t. A540223 02-08-11 --- */
                    wfbran = n_bran  AND
                    wfdesc = "prem - " NO-ERROR. 
        IF NOT AVAILABLE wfbyline THEN DO:
           CREATE wfbyline.
           /*ASSIGN wfpoltyp = SUBSTR(acm001.policy,3,2)  + "T"  --- suthida t. A540223 02-08-11 --- */
             ASSIGN wfpoltyp = SUBSTR(n_policy,3,2)  + "T" /* --- suthida t. A540223 02-08-11 ---*/
                    wfbran   = n_bran
                    wfdesc   = "prem - ". 
        END.    
        wfprem = wfprem + pol_prem.
   END.
   
   ASSIGN wfstp    = wfstp    + nv_stp
          wfcomm   = wfcomm   + nv_comm
          wffee    = wffee    + nv_fee
          wfsumfee = wfsumfee + nv_sumfee.

   /* หมายเหตุ ไม่ต้องใส่ Allocate เนื่องจาก งาน 0APTHAI เป็นงาน Inw Treaty
               มีการบันทึกบันชีแยก ตรวจสอบข้อมูล ASSIGN -> A51-0078 */
END.
ELSE DO:    /*Non Motor อื่นๆ*/
    IF acm001.prem  > 0 THEN  DO:
        FIND FIRST wfbyline WHERE wfpoltyp  = n_poltyp  AND
                                  wfbran    = n_bran  AND
                                  wfdesc    = "prem + " NO-ERROR. 
        IF NOT AVAILABLE wfbyline THEN DO:
           CREATE wfbyline.
          /*  ASSIGN wfpoltyp = SUBSTR(acm001.policy,3,2)  --- suthida t. A540223 02-08-11 --- */
             ASSIGN wfpoltyp = SUBSTR(n_policy,3,2) /* --- suthida t. A540223 02-08-11 --- */
                    wfbran   = n_bran
                    wfdesc   = "prem + ". 
        END.  

        ASSIGN 
            wfprem   = wfprem   + pol_prem
            wfstp    = wfstp    + nv_stp
            wfcomm   = wfcomm   + nv_comm
            wffee    = wffee    + nv_fee
            wfsumfee = wfsumfee + nv_sumfee.

        IF n_poltyp <> "60" AND n_poltyp <> "61" AND
           n_poltyp <> "62" AND n_poltyp <> "63" AND
           n_poltyp <> "64" AND n_poltyp <> "67" THEN
        
            ASSIGN  
              wfvat   = wfvat  + nv_vat
              wfprvat = wfprem + wfvat + wfstp
              wfsbt   = 0.  
        
        ELSE ASSIGN 
              wfsbt    = wfsbt  + nv_sbt
              wfprsbt  = wfprsbt + nv_tot_sbt
              wfvat    = 0.
        
        ASSIGN 
           wftotprm = wfprvat + wfprsbt.  

        RUN pro_creallowf. /* --- create allocate to wfbyline  ----- */

    END.   /* Prem > 0 */
    ELSE DO:
        /* FIND FIRST wfbyline WHERE wfpoltyp  = substr(acm001.policy,3,2)  AND --- suthida t. A540223 02-08-11 --- */
        FIND FIRST wfbyline WHERE wfpoltyp  = substr(n_policy,3,2)  AND
                   wfbran = n_bran  AND
                   wfdesc = "prem - " NO-ERROR. 
        IF NOT AVAILABLE wfbyline THEN DO:
           CREATE wfbyline.
           /* ASSIGN wfpoltyp = SUBSTR(acm001.policy,3,2)  --- suthida t. A540223 02-08-11 --- */
           ASSIGN wfpoltyp = SUBSTR(n_policy,3,2) /* --- suthida t. A540223 02-08-11 --- */
                  wfbran   = n_bran
                  wfdesc   = "prem - ". 
        END.   

        ASSIGN 
            wfprem   = wfprem   + pol_prem
            wfstp    = wfstp    + nv_stp
            wfcomm   = wfcomm   + nv_comm
            wffee    = wffee    + nv_fee
            wfsumfee = wfsumfee + nv_sumfee.

        IF n_poltyp <> "60" AND n_poltyp <> "61" AND
           n_poltyp <> "62" AND n_poltyp <> "63" AND
           n_poltyp <> "64" AND n_poltyp <> "67" THEN
        
            ASSIGN  
              wfvat   = wfvat  + nv_vat
              wfprvat = wfprem + wfvat + wfstp
              wfsbt   = 0.  
        
        ELSE ASSIGN 
              wfsbt    = wfsbt  + nv_sbt
              wfprsbt  = wfprsbt + nv_tot_sbt
              wfvat    = 0.
        
        ASSIGN 
           wftotprm = wfprvat + wfprsbt.  

        RUN pro_creallowf. /* --- create allocate to wfbyline  ----- */

    END.

   

    
    
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

ELSE IF jv_poltyp = "10" THEN 
   ASSIGN n_grp#    = "10"
         /* jvt_comm  = jvt_comm + jv_comm*/
          jvt_sumfee  = jvt_sumfee + jv_sumfee.

ELSE IF (jv_poltyp = "11"  OR  jv_poltyp = "12" OR
        jv_poltyp = "13")  THEN 
        ASSIGN n_grp#    = "11"
               /*jvt_comm  = jvt_comm + jv_comm*/
               jvt_sumfee  = jvt_sumfee + jv_sumfee.

ELSE IF (jv_poltyp = "14"  OR  jv_poltyp = "15" OR
         jv_poltyp = "16"  OR  jv_poltyp = "17" OR 
         jv_poltyp = "18"  OR  jv_poltyp = "19") THEN 
        ASSIGN n_grp#    = "14"
               /*jvt_comm  = jvt_comm + jv_comm*/
               jvt_sumfee  = jvt_sumfee + jv_sumfee.

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
         jv_poltyp = "43"  OR   jv_poltyp = "44" ) THEN /*Piyachat A52-0040 กำหนดใด้ Line 44 อยู่ในกรุ๊ป 40 */
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

ELSE IF (jv_poltyp = "60"  OR   jv_poltyp = "61" OR
         jv_poltyp = "62"  OR   jv_poltyp = "63" OR
         jv_poltyp = "64"  OR   jv_poltyp = "67" OR
         jv_poltyp = "68") THEN 
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

ELSE ASSIGN n_grp#   = jv_poltyp
          /*  jvt_comm = jvt_comm + jv_comm*/
             jvt_sumfee = jvt_sumfee + jv_sumfee.

IF SUBSTR(jv_desc,6,1) = "+" THEN DO:                           
   n_macc  = n_p# + n_grp# + n_br# + n_pp.       /* เช่น 4XX11000 [Prem +] */
   RUN wac/wacazr (INPUT jv_prem, jv_bran,2, 
                   n_macc, n_sacc1, n_sacc2, n_gldat, n_source).
END.

ELSE IF SUBSTR(jv_desc,6,1) = "-" THEN DO:
        n_macc  = n_p# + n_grp# + n_br# + n_pe.  /* เช่น 4XX11090 [Prem -] */
        RUN wac/wacazr (INPUT jv_prem, jv_bran,2, 
                        n_macc, n_sacc1, n_sacc2, n_gldat, n_source).
END.
   
   n_macc  = n_c# + n_grp# + n_br# + n_c4.   /* เช่น 5XX11000 */
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
    OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO.  
    RUN ChkLineExcel.
    EXPORT DELIMITER ";"
        "Total Branch: " + SUBSTRI(n_desbr,15,1) + " [+]"      
        " "         " "         np_prem      
        np_stp      np_vat      np_prvat   np_sbt     
        np_prsbt    np_totprm   np_comm    np_fee np_sumfee  np_sum 
        np_retp     np_sumretc  np_0tp     np_0tc       
        np_0sp      np_0sc      np_statp   np_statc     
        np_0rqp     np_0rqc     np_f1p     np_f1c       
        np_f2p      np_f2c      np_0psp    np_0psc      
        np_btrp     np_btrc     np_otrp    np_otrc      
        np_f3p      np_f3c      np_f4p     np_f4c       
        np_ftrp     np_ftrc     np_0qp     np_0qc       
        np_s8p      np_s8c      np_0Dp     np_0Dc       
        np_0Ap      np_0Ac      np_0Fp     np_0Fc  .     

    OUTPUT CLOSE.
    
    OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO.   
    RUN ChkLineExcel.
    EXPORT DELIMITER ";"
        "Total Branch: " + SUBSTRI(n_desbr,15,1) + " [-]"      
        " "          " "       ns_prem    
        ns_stp      ns_vat     ns_prvat   ns_sbt     
        ns_prsbt    ns_totprm  ns_comm    ns_fee   
        ns_sumfee   ns_sum                
        ns_retp     ns_sumretc ns_0tp     ns_0tc       
        ns_0sp      ns_0sc     ns_statp   ns_statc     
        ns_0rqp     ns_0rqc    ns_f1p     ns_f1c       
        ns_f2p      ns_f2c     ns_0psp    ns_0psc      
        ns_btrp     ns_btrc    ns_otrp    ns_otrc      
        ns_f3p      ns_f3c     ns_f4p     ns_f4c       
        ns_ftrp     ns_ftrc    ns_0qp     ns_0qc       
        ns_s8p      ns_s8c     ns_0Dp     ns_0Dc       
        ns_0Ap      ns_0Ac     ns_0Fp     ns_0Fc  .  

    OUTPUT CLOSE.
    
    IF n_jv = YES THEN DO: 
       IF n_source = "DI" THEN DO:
          
          totsumpa = nb_prvat - sumpa.
       
          RUN wac/wacazr (INPUT (-1) * (totsumpa + sumpa), jv_bran, 2, "10400073", 
                                n_sacc1, n_sacc2, n_gldat, n_source).

          RUN wac/wacazr (INPUT (-1) * jvg_sumfee, jv_bran, 1, "20400077", 
                                n_sacc1, n_sacc2, n_gldat, n_source).
       END.
       ELSE IF n_source = "IF" THEN

          RUN wac/wacazr (INPUT (-1) * jv_summ, jv_bran, 1, "10510000", 
                                n_sacc1, n_sacc2, n_gldat, n_source).
    END.

    OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO.   
    RUN ChkLineExcel.
    EXPORT DELIMITER ";"
       "GrandTotal of Branch:" + SUBSTRI(n_desbr,15,1)      
       " "          " "        nb_prem   
       nb_stp       nb_vat     nb_prvat  nb_sbt     
       nb_prsbt     nb_totprm  nb_comm   
       nb_fee       nb_sumfee  nb_sum    
       nb_retp      nb_sumretc nb_0tp      nb_0tc       
       nb_0sp       nb_0sc     nb_statp    nb_statc     
       nb_0rqp      nb_0rqc    nb_f1p      nb_f1c       
       nb_f2p       nb_f2c     nb_0psp     nb_0psc      
       nb_btrp      nb_btrc    nb_otrp     nb_otrc      
       nb_f3p       nb_f3c     nb_f4p      nb_f4c       
       nb_ftrp      nb_ftrc    nb_0qp      nb_0qc       
       nb_s8p       nb_s8c     nb_0Dp      nb_0Dc       
       nb_0Ap       nb_0Ac     nb_0Fp      nb_0Fc  .     
    OUTPUT CLOSE.

    RUN proc_crsummary.  /* ----- clear data summary ----- */
       
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
    "BRANCH "             /*1*/                   
    "POL.TYPE  "          /*2*/    
    "DESC.  "             /*3*/    
    "PREM "               /*4*/    
    "STAMP "              /*5*/    
    "VAT "                /*6*/    
    "TOT.PREM-VAT "       /*7*/    
    "SBT "                /*8*/    
    "TOT.PREM-SBT "       /*9*/    
    "TOT.PREM "           /*10*/   
    "COMM "               /*11*/   
    "R/I DISC."           /*12*/   
    "TOT COMM."           /*13*/   
    "NETAMT "             /*14*/ 
    "PREM.RET"
    "COM.RET"  
    "PREM.1ST"         
    "COM.1ST"  
    "PREM.2ND"         
    "COM.2ND "  
    "PREM.QBATH"       
    "COM.QBATH"  
    "PREM.Q/S"         
    "COM.Q/S "  
    "PREM.FO1"         
    "COM.F01"  
    "PREM.FO2"         
    "COM.F02"  
    "PREM.MPS"         
    "COM.MPS"  
    "PREM.BTR"         
    "COM.BTR"  
    "PREM.OTR"         
    "COM.OTR"  
    "PREM.FO3"         
    "COM.F03"  
    "PREM.FO4"         
    "COM.F04"  
    "PREM.FTR"         
    "COM.FTR"  
    "PREM.TFP"         
    "COM.TFP"  
    "PREM.S8"          
    "COM.S8"  
    "PREM.Local Fac"   
    "COM.Local Fac"  
    "PREM.Asian Fac"   
    "COM.Asian Fac"  
    "PREM.Foreign Fac"
    "COM.Foreign Fac". 

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
    /*n_txtbr = "Total Branch : " + n_bran .*/
    n_txtbr = " Sum Total  : ".
    nv_row  = nv_row + 1.
    RUN ChkLineExcel.
    OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
    RUN DSDetTable.

    EXPORT DELIMITER ";"
    n_txtbr         " "             " "            " "
    " "             " "             " "            " "           nsd_vol         
    nsd_comp        nsd_pa          nsd_pol_prem   nsd_vol_stp     
    nsd_comp_stp    nsd_pa_stp      nsd_stp        nsd_vol_vat     
    nsd_comp_vat    nsd_pa_vat      nsd_vat        nsd_tot_vat     
    nsd_sbt         nsd_tot_sbt     nsd_com_vol    nsd_com_comp    
    nsd_com_pa      nsd_comm        nsd_fee        nsd_sumfee   " "
    " "             nsd_ret         " "            nsd_recom
    " "             nsd_0t          " "            nsd_0tcom    
    " "             nsd_0s          " "            nsd_0scom                            
    " "             nsd_stat        " "            nsd_statcom                          
    " "             nsd_0rq         " "            nsd_0rqcom                           
    " "             nsd_f1          " "            nsd_f1com                            
    " "             nsd_f2          " "            nsd_f2com                            
    " "             nsd_0ps         " "            nsd_0pscom                           
    " "             nsd_btr         " "            nsd_btrcom                           
    " "             nsd_otr         " "            nsd_otrcom                           
    " "             nsd_f3          " "            nsd_f3com                            
    " "             nsd_f4          " "            nsd_f4com                            
    " "             nsd_ftr         " "            nsd_ftrcom                           
    " "             nsd_0q          " "            nsd_0qcom                            
    " "             nsd_s8          " "            nsd_s8com                            
    " "             nsd_0D          " "            nsd_0dcom                            
    " "             nsd_0A          " "            nsd_0acom                            
    " "             nsd_0F          " "            nsd_0fcom.    

    OUTPUT CLOSE.

    nv_reccnt = nv_reccnt + 2.

    RUN Proc_crsumd.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

