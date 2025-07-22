&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sicfn            PROGRESS
*/
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*
  File: WACROSCL.W

  Description: Printing Report for Outstanding Claim

  Input Parameters: 
      - Report for Motor / Non motor
      - Policy Type
      - OS Type : OS > 0, 
                  OS All (> 0, = 0, < 0 but CL Status = blank, O, P)
      - File Output for Motor = 2 Files (Detail, Summary)
                    for Non motor = 1 File
  Output Parameters:
      <none>
/* program id   : wacrosc2.p                                         */ 
/* program name : REPORT FOR  SUMMARY OF OUTSTANDING CLAIM (MONTHLY) */ 
/* create by    : Kridtiya i. A57-0343 date. 16/09/2014              */
/* database connect : sicsyac sicuw siccl stat sicfn claim9          */
  Author: By kridtiya i. A57-0343
  Created: 
------------------------------------------------------------------------*/
/*          This .W file was created with the Progress AppBuilder.      */
/*----------------------------------------------------------------------*/
/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */
/*Modify by:  Chaiyong W. A54-0112 12/11/2012         */
/*            chage format vehreg 10 to 11            */ 
/* Modify By :  Benjaporn J. A59-0613 [14/12/2016]   */    
/*           : เพิ่มเงื่อไขสำหรับบันทึก O/S Claim แบบ Auto Post to G/L System  */
/*           : ปรับเพิ่มช่องข้อมูลสัญญาในรายงานทะเบียน                  */
/* Modify By :  Saowapa U. A61-0460 [25/09/2018]   */    
/*           : ขอเพิ่มcolumn com.date (วันเริ่มคุ้มครอง)ในทะเบียนเคลม  */
/* Modify By : Nattanicha K. A64-0383 30/06/2022   */    
/*           : เพิ่ม Code FV เคลมอาสา และให้ดึงโค้ดผ่าน Parameter (FE,EX,FV)  */
CREATE WIDGET-POOL.

/* ***************************  Definitions  ************************** */
/* Parameters Definitions --- */
/* Local Variable Definitions --- */

{wac/wacros1.i}

DEF VAR nv_chkline AS LOGICAL. 
DEF VAR n_txtbr    AS CHAR  FORMAT "X(20)".
DEF VAR nv_reccnt  AS INT.
DEF VAR nv_reccnt2 AS INT.
DEF VAR nv_next    AS INT.
DEF VAR nv_next2   AS INT.
DEF VAR n_report   AS INT.
DEF VAR poltyp     AS CHAR FORMAT "X(2)".
DEF VAR n_poltyp   AS CHAR FORMAT "X(2)".
DEF VAR nb_cnt     AS INT INIT 0.   
DEF VAR nc_cnt     AS INT INIT 0.   
DEF VAR nct_cnt    AS INT INIT 0.   
DEF VAR nctg_cnt   AS INT INIT 0.   
DEF VAR cnt_comp   AS LOG.  

DEF WORKFILE wfcompcnt 
    FIELD wfcompcnt_br    AS CHAR FORMAT "X(2)"
    FIELD wfcompcnt_res   AS DEC FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfcompcnt_paid  AS DEC FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfcompcnt_cnt   AS INT INIT 0.
DEF NEW SHARED VAR non_poltyp AS INT INIT 0.
DEF NEW SHARED VAR n_asdat    AS DATE FORMAT "99/99/9999".
/*--- Benjaporn J. A59-0613 [14/12/2016] ---*/
DEF NEW SHARED VAR n_trndat   AS DATE FORMAT "99/99/9999". /*--A59-0007-*/
DEF NEW SHARED VAR nv_datfr   AS DATE FORMAT "99/99/9999". /*--A59-0007-*/
/*---End A59-0613  ---*/
DEF NEW SHARED VAR nv_datto   AS DATE FORMAT "99/99/9999". /*--A59-0007-*/
DEF VAR n_trndatto   AS DATE FORMAT "99/99/9999".

DEF NEW SHARED   VAR nv_branfr    AS CHAR FORMAT "X(2)". 
DEF NEW SHARED   VAR nv_branto    AS CHAR FORMAT "X(2)".
DEF NEW SHARED   VAR n_output     AS CHAR FORMAT "X(45)".
DEF NEW SHARED   VAR n_output2    AS CHAR FORMAT "X(45)".
DEF NEW SHARED   VAR n_ostyp      AS INT INIT 0.
DEF VAR nv_nbran     AS CHAR FORMAT "X(50)".
DEF VAR n_nbran      AS CHAR FORMAT "X(50)".
DEF VAR nv_ntype     AS CHAR FORMAT "X(30)".
DEF VAR nv_output    AS CHAR FORMAT "X(30)".
DEF VAR nv_output2   AS CHAR FORMAT "X(30)".
DEF VAR nv_Coutput   AS CHAR FORMAT "X(30)".  /*A51-0126*/
DEF VAR nv_claim     AS CHAR FORMAT "X(16)".
DEF VAR nv_clmant    AS INT  FORMAT 999.
DEF VAR nv_clitem    AS INT  FORMAT 999.
DEF VAR nv_poldes    AS CHAR FORMAT "X(50)".
DEF VAR nv_name      AS CHAR FORMAT "X(50)".
DEF VAR nv_acno1     AS CHAR FORMAT "X(30)".
DEF VAR nv_cedclm    AS CHAR FORMAT "X(30)".
DEF VAR nv_prodnam   AS CHAR FORMAT "X(30)".
DEF VAR nv_produc    AS CHAR FORMAT "X(30)".
DEF VAR nv_extcod    AS CHAR FORMAT "X(12)".   /*A51-0102*/ 
DEF VAR nv_extnam    AS CHAR FORMAT "X(30)".
DEF VAR nv_exter     AS CHAR FORMAT "X(30)".
DEF VAR nv_extref    AS CHAR FORMAT "X(30)".
DEF VAR nv_wextref   AS CHAR FORMAT "X(30)".
DEF VAR nv_adjust    AS CHAR FORMAT "X(30)".
DEF VAR nv_adjusna   AS CHAR FORMAT "X(30)".
DEF VAR nv_police    AS CHAR FORMAT "X(30)".
DEF VAR nv_pacod     AS CHAR FORMAT "X(30)".
DEF VAR nv_pades     AS CHAR FORMAT "X(30)".
DEF VAR n_adjusna    AS CHAR FORMAT "X(50)".
DEF VAR n_adjust     AS CHAR FORMAT "X(45)".
DEF VAR n_tos        AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_tpaid      AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_tamt       AS DECI EXTENT 20 FORMAT "->>,>>>,>>>,>>9.99".  
DEF VAR nv_bros      AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_brpaid    AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_bramt     AS DECI EXTENT 20 FORMAT "->>,>>>,>>>,>>9.99".  
DEF VAR n_bros       AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_brpaid     AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_bramt      AS DECI EXTENT 20 FORMAT "->>,>>>,>>>,>>9.99".  
DEF VAR n_gros       AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_grpaid     AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_gramt      AS DECI EXTENT 20 FORMAT "->>,>>>,>>>,>>9.99".  
DEF VAR n_dos        AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_damt       AS DECI EXTENT 20. 
DEF VAR n_txt        AS CHAR FORMAT "X(20)".
DEF VAR nv_asdat     AS DATE FORMAT "99/99/999".
DEF VAR nv_event     AS CHAR FORMAT "X(16)".
DEF VAR nv_defau     AS CHAR FORMAT "X(25)".
DEF VAR nv_loss1     LIKE clm100.loss1.
DEF VAR nv_comdat    AS DATE FORMAT "99/99/9999".
DEF VAR nv_expdat    AS DATE FORMAT "99/99/9999".
DEF VAR nv_renpol    AS CHAR FORMAT "X(16)".
DEF VAR nv_covcod    LIKE uwm301.covcod.
DEF VAR nv_insurnam  AS CHAR FORMAT "X(50)".
DEF VAR nv_pdcode    LIKE xmm600.acno.
DEF VAR nv_pdname    LIKE XMM600.name.
DEF VAR nv_nacod     AS CHAR FORMAT "X(2)".
DEF VAR nv_nades     AS CHAR FORMAT "X(40)".
DEF VAR nv_paid      AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_netl_d     LIKE clm130.netl_d.
DEF VAR n_paiddat    LIKE clm130.trndat.
DEFINE WORKFILE WCZM100
    FIELD wfpoltyp AS CHAR FORMAT "X(2)"
    FIELD wfDI     AS CHAR FORMAT "X"
    FIELD wfpoldes AS CHAR FORMAT "X(35)"
    FIELD wfos     AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfpaid   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfamt    AS DECI EXTENT 20 FORMAT "->>,>>>,>>>,>>9.99".  
DEFINE WORKFILE WLCZM100
    FIELD wlbran   AS CHAR FORMAT "X(2)"
    FIELD wlpoltyp AS CHAR FORMAT "X(2)"
    FIELD wlos     AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wlamt    AS DECI EXTENT 20 FORMAT "->>,>>>,>>>,>>9.99".  
DEF WORKFILE wfpoltyp
    FIELD wfpbr     AS CHAR FORMAT "X(2)"
    FIELD wftyp     AS CHAR FORMAT "x(1)"
    FIELD wfline    AS CHAR FORMAT "X(4)"
    FIELD wfpres    AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfppaid   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfpamt    AS DECI EXTENT 20 FORMAT "->>,>>>,>>>,>>9.99"  
    FIELD wfcnt     AS INT FORMAT ">>>,>>9".
DEF WORKFILE wfcpoltyp /*Comp*/
    FIELD wfcpbr     AS CHAR FORMAT "X(2)"
    FIELD wfctyp     AS CHAR FORMAT "x(1)"
    FIELD wfcloss    AS CHAR FORMAT "X(2)"    /*A51-0126*/
    FIELD wfcpres    AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfcppaid   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfcpamt    AS DECI EXTENT 20 FORMAT "->>,>>>,>>>,>>9.99"  
    FIELD wfcpcnt    AS INT  FORMAT ">>>,>>9".
DEF WORKFILE wfbranch
    FIELD wfbr       AS CHAR FORMAT "X(2)"
    FIELD wfbline    AS CHAR FORMAT "X(2)"
    FIELD wfbres     AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfbpaid    AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    /*FIELD wfbpamt  AS DECI EXTENT 18 FORMAT "->>,>>>,>>>,>>9.99" */
    FIELD wfbpamt    AS DECI EXTENT 20 FORMAT "->>,>>>,>>>,>>9.99"  /*Lukkana M. A53-0139 02/09/2010*/
    FIELD wfbcnt     AS INT  FORMAT ">>,>>9".
DEF WORKFILE wfcbranch /*Comp*/
    FIELD wfcbr      AS CHAR FORMAT "X(2)"
    FIELD wfcbline   AS CHAR FORMAT "X(2)"
    FIELD wfcbres    AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfcbpaid   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    /*FIELD wfcbpamt   AS DECI EXTENT 18 FORMAT "->>,>>>,>>>,>>9.99" */
    FIELD wfcbpamt   AS DECI EXTENT 20 FORMAT "->>,>>>,>>>,>>9.99" /*Lukkana M. A53-0139 02/09/2010*/
    FIELD wfcbcnt    AS INT  FORMAT ">>,>>9".
DEF WORKFILE wftbranch
    FIELD wftbr     AS CHAR FORMAT "X(2)"
    FIELD wftbres   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wftbpaid  AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    /*FIELD wftbpamt    AS DECI EXTENT 18 FORMAT "->>,>>>,>>>,>>9.99" */
    FIELD wftbpamt  AS DECI EXTENT 20 FORMAT "->>,>>>,>>>,>>9.99"  /*Lukkana M. A53-0139 02/09/2010*/
    FIELD wftbcnt   AS INT  FORMAT ">>,>>9".
DEF WORKFILE wfctbranch /*Comp*/
    FIELD wfctbr     AS CHAR FORMAT "X(2)"
    FIELD wfctbres   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfctbpaid  AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfctbamt   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfctbcnt   AS INT  FORMAT ">>,>>9".
DEF WORKFILE wfnon
    FIELD wfnbran   AS CHAR FORMAT "X(2)"
    FIELD wfnpoltyp AS CHAR FORMAT "X(2)"
    FIELD wfnDI     AS CHAR FORMAT "X"
    FIELD wfnos     AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfnpaid   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    /*FIELD wfnamt    AS DECI EXTENT 18 FORMAT "->>,>>>,>>>,>>9.99". */
    FIELD wfnamt    AS DECI EXTENT 20 FORMAT "->>,>>>,>>>,>>9.99".  /*Lukkana M. A53-0139 02/09/2010*/
DEF WORKFILE wfcnon
    FIELD wfcnbran   AS CHAR FORMAT "X(2)"
    FIELD wfcnpoltyp AS CHAR FORMAT "X(2)"
    FIELD wfcnDI     AS CHAR FORMAT "X"
    FIELD wfcnos     AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfcnpaid   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    /*FIELD wfcnamt    AS DECI EXTENT 18 FORMAT "->>,>>>,>>>,>>9.99". */
    FIELD wfcnamt    AS DECI EXTENT 20 FORMAT "->>,>>>,>>>,>>9.99".  /*Lukkana M. A53-0139 02/09/2010*/
DEF WORKFILE wfcnt  
    FIELD cntbranch AS CHAR FORMAT "X(2)"
    FIELD reccnt    AS INT  FORMAT ">>>,>>9" INIT 0.
DEF WORKFILE wflcnt  
    FIELD cntline   AS CHAR FORMAT "X(2)"
    FIELD reclcnt   AS INT  FORMAT ">>>,>>9" INIT 0.
DEF WORKFILE wfcntLine 
    FIELD cline      AS CHAR FORMAT "X(2)"
    FIELD reccntline AS INT  FORMAT ">>>,>>9" INIT 0.

DEF VAR n_sosres   AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_spaid    AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_bosres   AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_bpaid    AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_bcnt     AS INT  FORMAT ">>,>>9".
DEF VAR n_tosres   AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_gosres   AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_gpaid    AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_sumpaid AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_sumos   AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_os       AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_paid     AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_cnt      AS INT  FORMAT ">>,>>9".
DEF VAR n_compos   AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_comppaid AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_compcnt  AS INT  FORMAT ">>,>>9".
DEF VAR n_cosres   AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_cpaid    AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_ccnt     AS INT  FORMAT ">>,>>>,>>9".
DEF VAR n_tcosres  AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_tcpaid   AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_tcnt     AS INT  FORMAT ">>,>>9".
DEF VAR n_gcosres  AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_gcpaid   AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_gccnt    AS INT  FORMAT ">>,>>9".
DEF VAR i          AS INT  INIT 0.
DEF VAR wt_cnt     AS INT  FORMAT ">>,>>9".
DEF VAR w_cnt      AS INT  FORMAT ">>,>>9".
DEF VAR wg_cnt     AS INT  FORMAT ">>>,>>9".
DEF VAR n_claim    AS CHAR FORMAT "X(16)".
DEF VAR nt_cnt     AS INT  FORMAT ">>,>>9".
DEF VAR txtrep     AS CHAR FORMAT "X(15)".
DEF VAR txtpoltyp  AS CHAR FORMAT "X(15)".
DEF VAR n_len      AS INT.
DEF VAR n_bdes     LIKE xmm023.bdes.
DEF VAR n_br       AS CHAR FORMAT "X(2)".
DEF VAR n_loss     AS CHAR FORMAT "X(2)".
DEF VAR n_nbrn     AS CHAR FORMAT "X(2)".
DEF VAR n_obrn     AS CHAR FORMAT "X(2)".
DEF VAR nv_br1     AS CHAR. 
def var nv_row     AS  INT INIT 0.
def var nv_cnt     AS  INT INIT 0.
DEF VAR nv_count       AS  DECI INIT 0  FORMAT ">>>,>>9" .
DEF VAR nv_countline   AS  DECI INIT 0  FORMAT ">>>,>>9" .
DEF VAR nv_chkpollicy  AS  CHAR INIT "" FORMAT "x(16)"  .
DEF VAR nv_countcl     AS  DECI INIT 0  FORMAT ">,>>>,>>9" .
DEF VAR ngd_countcl    AS  DECI INIT 0  FORMAT ">,>>>,>>9" .
DEF VAR    nr_CLAIM      AS CHAR FORMAT "x(20)" .                    
DEF VAR    nr_entdat     AS CHAR FORMAT "X(20)" .                    
DEF VAR    nr_notdat     AS CHAR FORMAT "X(20)" .                     
DEF VAR    nr_LOSDAT     AS CHAR FORMAT "X(20)" .                     
DEF VAR    nr_POLICY     AS CHAR FORMAT "X(20)" .                    
DEF VAR    nr_name       AS CHAR FORMAT "x(60)" .                    
DEF VAR    nr_LOSS       AS CHAR FORMAT "x(20)" .                   
DEF VAR    nr_loss1      AS CHAR FORMAT "x(150)".                  
DEF VAR    nr_clmant_itm AS CHAR FORMAT "x(10)" .                    
DEF VAR    nr_osres      AS DEC  FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR    nr_facri      AS DEC  FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR    nr_adjust     AS CHAR FORMAT "X(40)" .                    
DEF VAR    nr_intref     AS CHAR FORMAT "X(30)" .                    
DEF VAR    nr_extref     AS CHAR FORMAT "X(30)" . 
DEF VAR    nr_agent      AS CHAR FORMAT "X(30)" .                    
DEF VAR    nr_cedclm     AS CHAR FORMAT "X(30)" .                    
DEF VAR    nr_DOCST      AS CHAR FORMAT "X(30)" .                    
DEF VAR    nr_pades      AS CHAR FORMAT "X(30)" . 
DEF VAR    nr_branchdsp  AS CHAR FORMAT "x(50)" .
DEF VAR    nr_countpag   AS DECI FORMAT ">>>,>>>,>>9".
DEF VAR    nr_type       AS CHAR FORMAT "x(5)"  .  /*add poltyp */

DEFINE STREAM ns1.

DEF VAR np_osres    AS DECI  FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR np_facri    AS DECI  FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR np_osres70  AS DECI  FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR np_osres71  AS DECI  FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR np_osres72  AS DECI  FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR np_osres73  AS DECI  FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR np_osres74  AS DECI  FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR np_facri70  AS DECI  FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR np_facri71  AS DECI  FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR np_facri72  AS DECI  FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR np_facri73  AS DECI  FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR np_facri74  AS DECI  FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR n_totres    AS DECI  FORMAT ">>,>>>,>>>,>>>.99-" .
DEF VAR n_totnet    AS DECI  FORMAT ">>,>>>,>>>,>>>.99-" .  
DEF VAR w_gross     AS DECI  FORMAT ">>,>>>,>>>,>>>.99-" .
DEF VAR tim01       AS CHAR  INIT "".
DEF VAR tim02       AS CHAR  INIT "".
DEF VAR np_branch   AS CHAR  FORMAT "x(2)" .
DEF VAR np_line     AS CHAR  FORMAT "x(3)" .
DEF VAR nv_text     AS CHAR  FORMAT "x(100)" .

DEF VAR nu_output   AS CHAR FORMAT "X(45)".
DEF VAR ntype       AS CHAR FORMAT "X(1)".
DEF VAR nr_osbh     AS DECI  FORMAT ">,>>>,>>>,>>9.99-".   
DEF VAR nr_facbh    AS DECI  FORMAT ">,>>>,>>>,>>9.99-". 
DEF VAR np_osbh     AS DECI  FORMAT ">,>>>,>>>,>>9.99-".   
DEF VAR np_facbh    AS DECI  FORMAT ">,>>>,>>>,>>9.99-". 
DEF VAR nr_ttybh    AS DECI  FORMAT ">,>>>,>>>,>>9.99-".   
DEF VAR nr_othbh    AS DECI  FORMAT ">,>>>,>>>,>>9.99-". 
DEF VAR np_ttybh    AS DECI  FORMAT ">,>>>,>>>,>>9.99-".   
DEF VAR np_othbh    AS DECI  FORMAT ">,>>>,>>>,>>9.99-". 
DEF VAR nr_osnap     AS DECI  FORMAT ">,>>>,>>>,>>9.99-".   
DEF VAR nr_facnap    AS DECI  FORMAT ">,>>>,>>>,>>9.99-". 
DEF VAR np_osnap     AS DECI  FORMAT ">,>>>,>>>,>>9.99-".   
DEF VAR np_facnap    AS DECI  FORMAT ">,>>>,>>>,>>9.99-". 
DEF VAR nr_ttynap    AS DECI  FORMAT ">,>>>,>>>,>>9.99-".   
DEF VAR nr_othnap    AS DECI  FORMAT ">,>>>,>>>,>>9.99-". 
DEF VAR np_ttynap    AS DECI  FORMAT ">,>>>,>>>,>>9.99-".   
DEF VAR np_othnap    AS DECI  FORMAT ">,>>>,>>>,>>9.99-".
DEF VAR np_xol      AS DECI  FORMAT ">,>>>,>>>,>>9.99-". 
DEF VAR nv_brnnzi   AS CHAR  FORMAT "x(2)" .
DEF VAR nv_trndat   AS DATE .
DEF VAR nr_trandat  AS DATE  FORMAT "99/99/9999". /*fai*/
DEF VAR nr_comdate  AS DATE  FORMAT "99/99/9999".
DEF VAR nr_agent1   AS CHAR  FORMAT "X(30)".
/*---  End A59-0613  ---*/

DEF BUFFER buwm100 FOR uwm100.
DEF VAR w_gross_nv     AS DECI  FORMAT ">>,>>>,>>>,>>>.99-" .
DEF VAR w_gross_v     AS DECI  FORMAT ">>,>>>,>>>,>>>.99-" .

DEF VAR np_osres_nv    AS DECI  FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR np_osres_v     AS DECI  FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR np_osres70_nv  AS DECI  FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR np_osres71_nv  AS DECI  FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR np_osres72_nv  AS DECI  FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR np_osres73_nv  AS DECI  FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR np_osres74_nv  AS DECI  FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR np_facri70_nv  AS DECI  FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR np_facri71_nv  AS DECI  FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR np_facri72_nv  AS DECI  FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR np_facri73_nv  AS DECI  FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR np_facri74_nv  AS DECI  FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR n_totres_nv    AS DECI  FORMAT ">>,>>>,>>>,>>>.99-" .
DEF VAR n_totnet_nv    AS DECI  FORMAT ">>,>>>,>>>,>>>.99-" .
DEF VAR nr_osres_nv    AS DECI  FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR nr_osres_v     AS DECI  FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR np_facri_nv    AS DECI  FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nr_osbh_nv     AS DECI  FORMAT ">,>>>,>>>,>>9.99-".   
DEF VAR nr_facbh_nv    AS DECI  FORMAT ">,>>>,>>>,>>9.99-". 
DEF VAR np_osbh_nv     AS DECI  FORMAT ">,>>>,>>>,>>9.99-".   
DEF VAR np_facbh_nv    AS DECI  FORMAT ">,>>>,>>>,>>9.99-". 
DEF VAR nr_ttybh_nv    AS DECI  FORMAT ">,>>>,>>>,>>9.99-".   
DEF VAR nr_othbh_nv    AS DECI  FORMAT ">,>>>,>>>,>>9.99-". 
DEF VAR np_ttybh_nv    AS DECI  FORMAT ">,>>>,>>>,>>9.99-".   
DEF VAR np_othbh_nv    AS DECI  FORMAT ">,>>>,>>>,>>9.99-".
DEF VAR nr_osnap_nv     AS DECI  FORMAT ">,>>>,>>>,>>9.99-".   
DEF VAR nr_facnap_nv    AS DECI  FORMAT ">,>>>,>>>,>>9.99-". 
DEF VAR np_osnap_nv     AS DECI  FORMAT ">,>>>,>>>,>>9.99-".   
DEF VAR np_facnap_nv    AS DECI  FORMAT ">,>>>,>>>,>>9.99-". 
DEF VAR nr_ttynap_nv    AS DECI  FORMAT ">,>>>,>>>,>>9.99-".   
DEF VAR nr_othnap_nv    AS DECI  FORMAT ">,>>>,>>>,>>9.99-". 
DEF VAR np_ttynap_nv    AS DECI  FORMAT ">,>>>,>>>,>>9.99-".   
DEF VAR np_othnap_nv    AS DECI  FORMAT ">,>>>,>>>,>>9.99-".
DEF VAR np_xol_nv      AS DECI  FORMAT ">,>>>,>>>,>>9.99-".
DEF VAR nn_vat_p      AS DECI  FORMAT ">,>>>,>>>,>>9.99-".
DEF VAR nn_clicod      AS CHAR  FORMAT "X(4)".

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME cmBROWSE-1

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES acproc_fil

/* Definitions for BROWSE cmBROWSE-1                                    */
&Scoped-define FIELDS-IN-QUERY-cmBROWSE-1 acproc_fil.asdat acproc_fil.type ~
acproc_fil.typdesc acproc_fil.trndatfr acproc_fil.trndatto ~
acproc_fil.entdat acproc_fil.enttim acproc_fil.usrid 
&Scoped-define ENABLED-FIELDS-IN-QUERY-cmBROWSE-1 
&Scoped-define QUERY-STRING-cmBROWSE-1 FOR EACH acproc_fil ~
      WHERE acproc_fil.type = "10" NO-LOCK ~
    BY acproc_fil.asdat DESCENDING INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-cmBROWSE-1 OPEN QUERY cmBROWSE-1 FOR EACH acproc_fil ~
      WHERE acproc_fil.type = "10" NO-LOCK ~
    BY acproc_fil.asdat DESCENDING INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-cmBROWSE-1 acproc_fil
&Scoped-define FIRST-TABLE-IN-QUERY-cmBROWSE-1 acproc_fil


/* Definitions for FRAME frReport                                       */
&Scoped-define OPEN-BROWSERS-IN-QUERY-frReport ~
    ~{&OPEN-QUERY-cmBROWSE-1}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS IMAGE-21 IMAGE-23 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE IMAGE IMAGE-21
     FILENAME "wimage/wallpape.bmp":U CONVERT-3D-COLORS
     SIZE 131.5 BY 23.57.

DEFINE IMAGE IMAGE-23
     FILENAME "wimage/bgc01.bmp":U CONVERT-3D-COLORS
     SIZE 117 BY 23.57.

DEFINE BUTTON buCancel 
     LABEL "Cancel" 
     SIZE 18.5 BY 1.52
     FONT 6.

DEFINE BUTTON buOK 
     LABEL "OK" 
     SIZE 18.5 BY 1.52
     FONT 6.

DEFINE VARIABLE fiAsdat AS DATE FORMAT "99/99/9999":U 
      VIEW-AS TEXT 
     SIZE 14 BY .71
     BGCOLOR 3 FGCOLOR 7  NO-UNDO.

DEFINE VARIABLE fiBranFr AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .71
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiBranTo AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .71
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiOutput AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 37 BY .91
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiPoltyp AS CHARACTER FORMAT "X(3)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 6 BY .95
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiProcessDate AS DATE FORMAT "99/99/9999":U 
      VIEW-AS TEXT 
     SIZE 14 BY .71
     BGCOLOR 3 FGCOLOR 7  NO-UNDO.

DEFINE VARIABLE rsOSTyp AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "O/S Claim > 0", 1,
"O/S Claim All", 2
     SIZE 23 BY 2
     BGCOLOR 3 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE rsProcTyp AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "MOTOR", 1,
"NON MOTOR", 2
     SIZE 17.5 BY 2.14
     BGCOLOR 8 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE rsProcTypN AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Not Line 30, 01, 04", 1,
"Only Line 30, 01, 04", 2,
"All", 3
     SIZE 25 BY 2.86
     BGCOLOR 3 FGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RecBrowse
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 106.5 BY 6.19
     BGCOLOR 8 .

DEFINE RECTANGLE RecOK
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 49 BY 2.52
     BGCOLOR 1 .

DEFINE RECTANGLE RecOStyp
     EDGE-PIXELS 4 GRAPHIC-EDGE    
     SIZE 25.17 BY 5.52
     BGCOLOR 8 .

DEFINE RECTANGLE recOutput
     EDGE-PIXELS 4 GRAPHIC-EDGE    
     SIZE 52 BY 1.43
     BGCOLOR 8 .

DEFINE RECTANGLE RecProctyp
     EDGE-PIXELS 4 GRAPHIC-EDGE    
     SIZE 19.5 BY 5.95
     BGCOLOR 8 .

DEFINE RECTANGLE RecProctyp-2
     EDGE-PIXELS 4 GRAPHIC-EDGE    
     SIZE 26 BY 5
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-100
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 106 BY 6.91
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-101
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 62 BY .24.

DEFINE RECTANGLE RECT-102
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE .67 BY 6.05.

DEFINE RECTANGLE RECT-104
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 27 BY 4.52.

DEFINE RECTANGLE RECT-105
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 25 BY 4.05.

DEFINE RECTANGLE RECT-108
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 25.5 BY 3.1.

DEFINE RECTANGLE RECT-110
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 26 BY 3.1.

DEFINE RECTANGLE RECT-99
     EDGE-PIXELS 4 GRAPHIC-EDGE    
     SIZE 24.17 BY 5.52
     BGCOLOR 8 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY cmBROWSE-1 FOR 
      acproc_fil SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE cmBROWSE-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS cmBROWSE-1 C-Win _STRUCTURED
  QUERY cmBROWSE-1 NO-LOCK DISPLAY
      acproc_fil.asdat FORMAT "99/99/9999":U
      acproc_fil.type COLUMN-LABEL "Type" FORMAT "X(2)":U WIDTH 3.5
      acproc_fil.typdesc COLUMN-LABEL "Process Desc." FORMAT "X(35)":U
            WIDTH 23.33
      acproc_fil.trndatfr COLUMN-LABEL "Trans.Date From" FORMAT "99/99/9999":U
            WIDTH 14.83
      acproc_fil.trndatto COLUMN-LABEL "Trans.Date To" FORMAT "99/99/9999":U
            WIDTH 14.33
      acproc_fil.entdat FORMAT "99/99/9999":U WIDTH 9.33
      acproc_fil.enttim FORMAT "X(8)":U
      acproc_fil.usrid FORMAT "X(6)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 102.83 BY 4.05
         BGCOLOR 15  FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     IMAGE-21 AT ROW 1.1 COL 1
     IMAGE-23 AT ROW 1 COL 7.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 132.33 BY 24.

DEFINE FRAME frReport
     cmBROWSE-1 AT ROW 4 COL 4
     rsProcTyp AT ROW 11.38 COL 16.67 NO-LABEL
     fiPoltyp AT ROW 11.71 COL 60.33 COLON-ALIGNED NO-LABEL
     rsProcTypN AT ROW 11.1 COL 79 NO-LABEL
     rsOSTyp AT ROW 18.05 COL 4.5 NO-LABEL
     fiBranFr AT ROW 18.38 COL 45.83 COLON-ALIGNED NO-LABEL
     fiBranTo AT ROW 19.38 COL 45.83 COLON-ALIGNED NO-LABEL
     fiOutput AT ROW 16.48 COL 68.33 COLON-ALIGNED NO-LABEL
     buOK AT ROW 19.67 COL 63
     buCancel AT ROW 19.67 COL 87.5
     fiAsdat AT ROW 2.86 COL 37 COLON-ALIGNED NO-LABEL
     fiProcessDate AT ROW 2.86 COL 69.5 COLON-ALIGNED NO-LABEL
     " BRANCH" VIEW-AS TEXT
          SIZE 23.5 BY .76 AT ROW 17.33 COL 31.33
          BGCOLOR 1 FGCOLOR 7 FONT 6
     " Branch From" VIEW-AS TEXT
          SIZE 13 BY .71 AT ROW 18.38 COL 32.17
          BGCOLOR 1 FGCOLOR 7 FONT 6
     " File Name" VIEW-AS TEXT
          SIZE 10.5 BY .91 AT ROW 16.48 COL 58.33
          BGCOLOR 1 FGCOLOR 7 FONT 6
     " O/S TYPE" VIEW-AS TEXT
          SIZE 24 BY .76 AT ROW 17.05 COL 4
          BGCOLOR 1 FGCOLOR 7 FONT 6
     " Process Date" VIEW-AS TEXT
          SIZE 14 BY .71 AT ROW 2.86 COL 57
          BGCOLOR 1 FGCOLOR 7 FONT 6
     " Branch To" VIEW-AS TEXT
          SIZE 13 BY .71 AT ROW 19.38 COL 32.17
          BGCOLOR 1 FGCOLOR 7 FONT 6
     " MOTOR" VIEW-AS TEXT
          SIZE 24.67 BY .71 AT ROW 10.05 COL 47.5
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "Line:  V" VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 11.71 COL 49.83
          FONT 2
     "" VIEW-AS TEXT
          SIZE 23 BY .76 AT ROW 20.43 COL 31.5
          BGCOLOR 1 FGCOLOR 7 FONT 6
     " CL.Status = Blank, O, P" VIEW-AS TEXT
          SIZE 24 BY .76 AT ROW 20.33 COL 4
          BGCOLOR 1 FGCOLOR 7 
     " NON MOTOR" VIEW-AS TEXT
          SIZE 25 BY .71 AT ROW 10.05 COL 79
          BGCOLOR 1 FGCOLOR 7 FONT 6
     " REPORT" VIEW-AS TEXT
          SIZE 40.17 BY .71 AT ROW 9.1 COL 3.83
          BGCOLOR 1 FGCOLOR 7 FONT 6
     " As of Date" VIEW-AS TEXT
          SIZE 11.5 BY .71 AT ROW 2.86 COL 27
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "                              REPORT FOR  SUMMARY OF OUTSTANDING CLAIM (MONTHLY)" VIEW-AS TEXT
          SIZE 110 BY 1 AT ROW 1 COL 1
          BGCOLOR 1 FGCOLOR 7 FONT 6
     " [70, 72, 73, 74, ALL]" VIEW-AS TEXT
          SIZE 22 BY .71 AT ROW 13.1 COL 49
          FONT 6
     RecBrowse AT ROW 2.29 COL 2.67
     RecProctyp AT ROW 8.95 COL 56.83
     recOutput AT ROW 16.19 COL 57
     RecOStyp AT ROW 16.19 COL 3.33
     RecOK AT ROW 19.14 COL 59.83
     RECT-99 AT ROW 16.19 COL 30.83
     RecProctyp-2 AT ROW 8.86 COL 81.5
     RECT-100 AT ROW 8.86 COL 3
     RECT-101 AT ROW 9.33 COL 45.5
     RECT-102 AT ROW 9.52 COL 75.17
     RECT-104 AT ROW 10.29 COL 11
     RECT-105 AT ROW 10.52 COL 12
     RECT-108 AT ROW 11 COL 47
     RECT-110 AT ROW 11 COL 78.5
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 12 ROW 2.76
         SIZE 110.5 BY 20.95
         BGCOLOR 3 .


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
         TITLE              = "SUMMARY OF OUTSTANDING CLAIM (MONTHLY)"
         HEIGHT             = 23.67
         WIDTH              = 131.67
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
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* REPARENT FRAME */
ASSIGN FRAME frReport:FRAME = FRAME DEFAULT-FRAME:HANDLE.

/* SETTINGS FOR FRAME DEFAULT-FRAME
   FRAME-NAME                                                           */
/* SETTINGS FOR FRAME frReport
   Custom                                                               */
/* BROWSE-TAB cmBROWSE-1 1 frReport */
/* SETTINGS FOR RADIO-SET rsProcTypN IN FRAME frReport
   NO-DISPLAY NO-ENABLE                                                 */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE cmBROWSE-1
/* Query rebuild information for BROWSE cmBROWSE-1
     _TblList          = "sicfn.acproc_fil"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _OrdList          = "sicfn.acproc_fil.asdat|no"
     _Where[1]         = "sicfn.acproc_fil.type = ""10"""
     _FldNameList[1]   = sicfn.acproc_fil.asdat
     _FldNameList[2]   > sicfn.acproc_fil.type
"acproc_fil.type" "Type" ? "character" ? ? ? ? ? ? no ? no no "3.5" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > sicfn.acproc_fil.typdesc
"acproc_fil.typdesc" "Process Desc." ? "character" ? ? ? ? ? ? no ? no no "23.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > sicfn.acproc_fil.trndatfr
"acproc_fil.trndatfr" "Trans.Date From" ? "date" ? ? ? ? ? ? no ? no no "14.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > sicfn.acproc_fil.trndatto
"acproc_fil.trndatto" "Trans.Date To" ? "date" ? ? ? ? ? ? no ? no no "14.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > sicfn.acproc_fil.entdat
"acproc_fil.entdat" ? ? "date" ? ? ? ? ? ? no ? no no "9.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   = sicfn.acproc_fil.enttim
     _FldNameList[8]   = sicfn.acproc_fil.usrid
     _Query            is OPENED
*/  /* BROWSE cmBROWSE-1 */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* SUMMARY OF OUTSTANDING CLAIM (MONTHLY) */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* SUMMARY OF OUTSTANDING CLAIM (MONTHLY) */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frReport
&Scoped-define SELF-NAME buCancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buCancel C-Win
ON CHOOSE OF buCancel IN FRAME frReport /* Cancel */
DO:
    RUN wac\wacdisc9.
    APPLY "CLOSE" TO THIS-PROCEDURE.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buOK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buOK C-Win
ON CHOOSE OF buOK IN FRAME frReport /* OK */
DO:
  
  IF nv_branfr = "" THEN DO:
     MESSAGE "Please Enter Branch From..." VIEW-AS ALERT-BOX.
     APPLY "ENTRY" TO fiBranFr.
     RETURN NO-APPLY.
  END.

  IF nv_branto = "" THEN DO:
     MESSAGE "Please Enter Branch To..." VIEW-AS ALERT-BOX.
     APPLY "ENTRY" TO fiBranTo.
     RETURN NO-APPLY.
  END.
  
  MESSAGE "ทำการออกรายงาน ! "           SKIP(1)
          "PROCESS OUTSTANDING CLAIM "  SKIP(1)
           txtrep " " "(" txtpoltyp ")" SKIP(1)
          "วันที่ประมวลผลข้อมูล  : " STRING(n_asdat,"99/99/9999")  SKIP (1)
          "กรมธรรม์ตั้งแต่วันที่ : " STRING(nv_datfr,"99/99/9999") " ถึง " 
           STRING(nv_datto,"99/99/9999") SKIP (1)
          "ตั้งแต่สาขา : " nv_branfr "ถึงสาขา: " nv_branto 

  VIEW-AS ALERT-BOX QUESTION  BUTTONS YES-NO
  UPDATE CHOICE AS LOGICAL.
  CASE CHOICE:
       WHEN TRUE THEN DO:

         RUN pdHeader.
        
         MESSAGE "Printing Complete" VIEW-AS ALERT-BOX.
      
       END.
       WHEN FALSE THEN DO:

         RETURN NO-APPLY.

       END.
  END CASE.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME cmBROWSE-1
&Scoped-define SELF-NAME cmBROWSE-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cmBROWSE-1 C-Win
ON VALUE-CHANGED OF cmBROWSE-1 IN FRAME frReport
DO:
  
  DO WITH FRAME frReport:
    IF NOT CAN-FIND(FIRST acproc_fil WHERE acproc_fil.type = "10") THEN DO:
        ASSIGN
            fiasdat         = ?
            fiProcessdate   = ?
            n_trndatto      = ?
            n_asdat         = fiasdat.
        DISP fiasdat fiProcessdate.
    END.
    ELSE DO:
        FIND CURRENT acproc_fil NO-LOCK.
        ASSIGN
            fiasdat       = acproc_fil.asdat
            fiProcessdate = acproc_fil.entdat
            n_trndatto    = acproc_fil.trndatto
            n_asdat       = fiasdat
            n_trndat      = acproc_fil.trndatto /*--A59-0007--*/
            nv_datfr      = acproc_fil.trndatfr
            nv_datto      = acproc_fil.trndatto.
        DISP fiasdat fiProcessdate .
    END.
  END. 

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiBranFr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBranFr C-Win
ON LEAVE OF fiBranFr IN FRAME frReport
DO:

  ASSIGN nv_branfr = CAPS (INPUT fiBranfr).
  DISP nv_branfr @ fiBranfr WITH FRAME frReport.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiBranTo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBranTo C-Win
ON LEAVE OF fiBranTo IN FRAME frReport
DO:

  ASSIGN nv_branto = CAPS (INPUT fiBranTo).
  DISP nv_branto @ fiBranTo WITH FRAME frReport.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiOutput
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiOutput C-Win
ON LEAVE OF fiOutput IN FRAME frReport
DO:

  ASSIGN n_output  = INPUT fiOutput 
         n_output2 = INPUT fiOutput .

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiPoltyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiPoltyp C-Win
ON LEAVE OF fiPoltyp IN FRAME frReport
DO:

  ASSIGN n_poltyp = INPUT fiPoltyp.
         txtpoltyp = "".
  
  IF INPUT fiPoltyp <> "" THEN DO:
     ASSIGN n_poltyp = INPUT fiPoltyp.
     
     IF  LOOKUP(n_poltyp, "70,72,73,74,all") = 0 THEN DO:
         MESSAGE "This Line is not Motor" SKIP
                 "Please enter [70], [72], [73], [74] or [All] for Motor" 
         VIEW-AS ALERT-BOX.
         APPLY "ENTRY" TO fiPoltyp.
         RETURN NO-APPLY.
     END.
     txtpoltyp = INPUT fipoltyp.
  END.
  ELSE DO:
     IF INPUT fipoltyp = "" THEN DO:
        MESSAGE "Please enter Policy Type (70, 72, 73,74 or ALL)"
        VIEW-AS ALERT-BOX.
        APPLY "ENTRY" TO fipoltyp.
        RETURN NO-APPLY.
     END.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rsOSTyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rsOSTyp C-Win
ON VALUE-CHANGED OF rsOSTyp IN FRAME frReport
DO:
  ASSIGN n_ostyp = INPUT rsOSTyp.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rsProcTyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rsProcTyp C-Win
ON VALUE-CHANGED OF rsProcTyp IN FRAME frReport
DO:
  ASSIGN n_report = INPUT rsProcTyp.

  IF n_report = 2 THEN DO:
     fipoltyp = "".
     DISP fipoltyp WITH FRAME frReport.
     DISABLE fiPoltyp   WITH FRAME frReport.
     ENABLE  rsProcTypN WITH FRAME frReport.
     txtrep = "Non Motor".
     APPLY "VALUE-CHANGED" TO rsProcTypN. 
  END.

  ELSE IF n_report = 1 THEN DO:
     DISABLE rsProcTypN WITH FRAME frReport.
     ENABLE  fiPoltyp   WITH FRAME frReport.
     txtrep = "Motor".
     APPLY "ENTRY" TO fipoltyp.
     RETURN NO-APPLY.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rsProcTypN
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rsProcTypN C-Win
ON VALUE-CHANGED OF rsProcTypN IN FRAME frReport
DO:
    ASSIGN 
        non_poltyp = INPUT rsProcTypN
        txtpoltyp  = INPUT rsProcTypN.

    IF non_poltyp = 1 THEN txtpoltyp = "Not Line 30, 01, 04".
    ELSE IF non_poltyp = 2 THEN txtpoltyp = "Only Line 30, 01, 04".
    ELSE txtpoltyp = "ALL".

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

  SESSION:DATA-ENTRY-RETURN = YES.

  DEF  VAR  gv_prgid   AS   CHAR  FORMAT "X(8)"  NO-UNDO.
  DEF  VAR  gv_prog    AS   CHAR  FORMAT "X(40)" NO-UNDO.

  ASSIGN   fiasdat        = acproc_fil.asdat
           fiPoltyp       = "all"
           fiProcessdate  = acproc_fil.entdat
           n_trndatto     = acproc_fil.trndatto
           n_asdat        = fiasdat
           nv_datfr       = acproc_fil.trndatfr
           nv_datto       = acproc_fil.trndatto
           n_report       = 1
           n_poltyp       = "all"
           non_poltyp     = 1
           n_ostyp        = 1
           txtrep         = "Motor" 
           txtpoltyp      = "70" 
           gv_prgid       = "wacrosc1.w"
           gv_prog        = "REPORT FILE SUMMARY OF OUTSTANDING CLAIM (MONTHLY)".

  DISP fiasdat fiPoltyp fiProcessdate WITH FRAME frReport.
RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).
    RUN  WUT\WUTWICEN ({&WINDOW-NAME}:handle).
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

IF nv_reccnt > 65500 THEN  DO:
    ASSIGN
      cntop     = LENGTH(nv_output) - 4  /*-- ตัดชื่อ ==> XXXX1.txt --*/
      nv_next   = nv_next + 1
      nv_output = SUBSTR(nv_output,1,cntop) + STRING(nv_next) + ".txt"
      nv_reccnt = 0.

    IF n_report = 1  THEN DO:     /*---Motor---*/
       RUN pdPrnHeadermotor.
       nv_reccnt = nv_reccnt + 3.
    END.
    ELSE IF n_report = 2 THEN DO:   /*---Non Motor---*/
       RUN pdPrnHeaderNon.
       nv_reccnt = nv_reccnt + 3.
    END.

END.  

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ChkLineExcel2 C-Win 
PROCEDURE ChkLineExcel2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR cntop2 AS INT.

IF nv_reccnt2 > 65500 THEN  DO:
    ASSIGN
      cntop2     = LENGTH(nv_output2) - 4  /*-- ตัดชื่อ ==> XXXX1.txt --*/
      nv_next2   = nv_next2 + 1
      nv_output2 = SUBSTR(nv_output2,1,cntop2) + STRING(nv_next2) + ".txt"
      nv_reccnt2 = 0.

    IF n_report = 1  THEN DO:     /*---Motor---*/
       RUN pdPrnHeadermotorS.
       nv_reccnt2 = nv_reccnt2 + 3.
    END.
    ELSE IF n_report = 2 THEN DO:   /*---Non Motor---*/
            RUN pdPrnHeaderNon.
            nv_reccnt2 = nv_reccnt2 + 3.
    END.

END.  
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
  ENABLE IMAGE-21 IMAGE-23 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  DISPLAY rsProcTyp fiPoltyp rsOSTyp fiBranFr fiBranTo fiOutput fiAsdat 
          fiProcessDate 
      WITH FRAME frReport IN WINDOW C-Win.
  ENABLE cmBROWSE-1 rsProcTyp fiPoltyp rsOSTyp fiBranFr fiBranTo fiOutput buOK 
         buCancel fiAsdat fiProcessDate RecBrowse RecProctyp recOutput RecOStyp 
         RecOK RECT-99 RecProctyp-2 RECT-100 RECT-101 RECT-102 RECT-104 
         RECT-105 RECT-108 RECT-110 
      WITH FRAME frReport IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frReport}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PdBdes C-Win 
PROCEDURE PdBdes :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*---
FIND FIRST xmm023 USE-INDEX xmm02301 WHERE n_br = xmm023.branch .
IF AVAIL xmm023 THEN DO:
   n_bdes = xmm023.bdes.
END.
Lukkana M. A53-0139 21/07/2010--*/

/*--Lukkana M. A53-0139 21/07/2010--*/
FIND FIRST xmm023 USE-INDEX xmm02301 WHERE 
           xmm023.branch = n_br NO-LOCK NO-ERROR.
IF AVAIL xmm023 THEN DO:
   n_bdes = xmm023.bdes.
END.
/*--Lukkana M. A53-0139 21/07/2010--*/


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdchk_linenew C-Win 
PROCEDURE pdchk_linenew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR cntop AS INT.
IF nv_reccnt > 100 THEN  DO:
    ASSIGN
      cntop     = LENGTH(n_output) - 4  /*-- ตัดชื่อ ==> XXXX1.txt --*/
      nv_next   = nv_next + 1
      n_output  = SUBSTR(n_output,1,cntop) + STRING(nv_next) + ".slk"
      nv_reccnt = 0.

    /*iF n_report = 1  THEN DO:     /*---Motor---*/
       RUN pdPrnHeadermotor.
       nv_reccnt = nv_reccnt + 3.
    END.
    ELSE IF n_report = 2 THEN DO:   /*---Non Motor---*/
       RUN pdPrnHeaderNon.
       nv_reccnt = nv_reccnt + 3.
    END.*/
     

END.  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdClearValue C-Win 
PROCEDURE pdClearValue :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN 
        nr_CLAIM      = "" 
        nr_trandat    = ?
        nr_comdate    = ?     
        nr_entdat     = ""  
        nr_notdat     = ""   
        nr_LOSDAT     = "" 
        nr_POLICY     = "" 
        nr_name       = ""    
        nr_LOSS       = ""  
        nr_loss1      = ""
        nr_clmant_itm = ""  
        nr_osres      = 0 
        nr_facri      = 0 
        nr_adjust     = "" 
        nr_intref     = "" 
        nr_extref     = "" 
        nr_agent      = "" 
        nr_cedclm     = "" 
        nr_DOCST      = "" 
        nr_pades      = ""
        nr_branchdsp  = ""
        nr_type       = "". 

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdClrValue C-Win 
PROCEDURE pdClrValue :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN nv_poldes  =  " "
       nv_name    =  " "
       nv_acno1   =  " "
       nv_cedclm  =  " "
       nv_prodnam =  " "
       nv_produc  =  " "
       nv_extnam  =  " "
       nv_exter   =  " "
       nv_extref  =  " "
       nv_wextref =  " "
    
       nv_adjust  =  " "
       nv_adjusna =  " "
                 
       nv_police  =  " "
       nv_pacod   =  " ".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdfindACNO C-Win 
PROCEDURE pdfindACNO PRIVATE :
/*------------------------------------------------------------------------------
  Purpose:   Find Account No., Adjustor, Cedding Claim, Default By, Comm.Date,
             Expire.Date, Insure Name, Cause of Loss, Notify No., Int.&Ext.Surveyor  
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN  nv_acno1    = ""
        nv_cedclm   = ""
        /*----A51-0102---*/
        nv_pacod    = ""
        nv_pades    = ""
        nv_pdcode   = ""
        nv_pdname   = "".
       /*---  A51-0102 ---*/

FIND FIRST clm100 USE-INDEX clm10001 WHERE
           clm100.claim = czm100.CLAIM NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL  clm100 THEN DO:
   ASSIGN nv_acno1      = clm100.acno1        
          nv_police     = clm100.police
          nv_cedclm     = clm100.cedclm
          nv_name       = TRIM (Clm100.ntitle) + TRIM (Clm100.name1)
          nv_event      = clm100.event
          nv_defau      = clm100.defau
          nv_comdat     = clm100.comdat
          nv_expdat     = clm100.expdat
          nv_insurnam   = TRIM(TRIM(clm100.ntitle) + " " + TRIM(clm100.name1))
          nv_loss1      = clm100.loss1.
   
    IF INDEX(nv_loss1,CHR(13)) <> 0 THEN DO:
        nv_loss1  = (SUBSTR(clm100.loss1,1,INDEX(clm100.loss1,CHR(13)))).
        nv_loss1  = SUBSTR(nv_loss1,1,LENGTH(nv_loss1) - 1).
    END.
    /*  claim paid text  */
    IF clm100.busreg <> "" THEN DO:
       FIND FIRST sym100 USE-INDEX sym10001 WHERE
                  sym100.tabcod = "U070"    AND
                  sym100.itmcod = clm100.busreg NO-LOCK NO-ERROR NO-WAIT.
       IF AVAIL sym100 THEN  DO:
          nv_pacod = sym100.itmcod.
          nv_pades = sym100.itmdes.
       END.
    END.
    /*--------------------*/
    IF clm100.agent <> "" THEN DO:
       FIND FIRST xmm600 USE-INDEX xmm60001  WHERE
                  xmm600.acno = clm100.agent NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL xmm600 THEN DO:
               nv_pdcode = xmm600.acno.
               nv_pdname = xmm600.name.
            END.
            ELSE DO:
               FIND FIRST xtm600 USE-INDEX xtm60001  WHERE
                          xtm600.acno = clm100.agent NO-LOCK NO-ERROR NO-WAIT.
               IF AVAIL xtm600 THEN DO:
                  nv_pdcode = xtm600.acno.
                  nv_pdname = xtm600.name.
               END.
            END.
    END.
END.

ASSIGN  nv_prodnam  = ""
        nv_produc   = ""
        nv_extcod   = ""
        nv_extnam   = ""           /*A51-0102*/
        nv_exter    = ""
        nv_wextref  = "".

FIND FIRST xtm600 USE-INDEX xtm60001 WHERE
           xtm600.acno = nv_acno1    NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL xtm600 THEN DO:
   ASSIGN 
      nv_prodnam = TRIM(TRIM(xtm600.ntitle) + " " + TRIM(xtm600.name))
      nv_produc  = TRIM(TRIM(xtm600.ntitle) + " " + TRIM(xtm600.name)).
END.
ELSE DO:
   FIND FIRST xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = nv_acno1
   NO-LOCK NO-ERROR NO-WAIT.
   IF AVAIL xmm600 THEN DO:
      ASSIGN 
         nv_prodnam = TRIM(TRIM(xmm600.ntitle) + " " + TRIM(xmm600.name))
         nv_produc  = TRIM(TRIM(xmm600.ntitle) + " " + TRIM(xmm600.name)).
         
   END.
   ELSE DO:
      ASSIGN  nv_prodnam  = ""
              nv_produc   = "".
   END.
END.

FIND FIRST clm120 USE-INDEX clm12001    WHERE
           clm120.claim = czm100.CLAIM  NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL clm120 THEN DO:
   
   nv_wextref = clm120.extref.

   FIND FIRST xtm600 USE-INDEX xtm60001 WHERE
              xtm600.acno = nv_wextref  NO-LOCK NO-ERROR NO-WAIT.
   IF AVAIL xtm600 THEN DO:
      ASSIGN
         nv_extnam  = TRIM(TRIM(xtm600.ntitle) + " " + TRIM(xtm600.name))
         nv_exter   = TRIM(TRIM(xtm600.ntitle) + " " + TRIM(xtm600.name))
         nv_extcod  = xtm600.acno.    /*A51-0102*/
   END.
   ELSE DO:
      FIND FIRST xmm600 USE-INDEX xmm60001 WHERE
                 xmm600.acno = nv_wextref  NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN DO:
         ASSIGN nv_extnam  = TRIM(TRIM(xmm600.ntitle) + " " + TRIM(xmm600.name))
                nv_exter   = TRIM(TRIM(xmm600.ntitle) + " " + TRIM(xmm600.name))
                nv_extcod  = xmm600.acno.   /*A51-0102*/
      END.
      ELSE DO:
         ASSIGN  nv_extnam  = ""
                 nv_exter   = ""
                 nv_extcod  = "".   /*A51-0102*/
      END.
   END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdfindCovcod C-Win 
PROCEDURE pdfindCovcod :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  nv_covcod  = "".   /* A51-0102 */
  FIND FIRST uwm301  WHERE uwm301.policy = clm100.policy  AND
                           uwm301.rencnt = clm100.rencnt  AND
                           uwm301.endcnt = clm100.endcnt  AND
                           uwm301.riskno = clm100.riskno  AND
                           uwm301.itemno = clm100.itemno
     NO-LOCK NO-ERROR NO-WAIT.
     IF AVAIL uwm301 THEN   
        ASSIGN nv_covcod  =  uwm301.covcod.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdfindLoss C-Win 
PROCEDURE pdfindLoss :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
n_loss = "".

FIND clm120 USE-INDEX clm12001 WHERE clm120.claim  = czd101.claim  AND
                                     clm120.clmant = czd101.clmant AND
                                     clm120.clitem = czd101.clitem NO-ERROR.  /*เพิ่ม no-error Lukkana M. A53-0139 02/09/2010*/
IF AVAIL clm120 THEN DO:
        IF SUBSTR(czd101.claim,3,1) = "7" THEN n_loss = clm120.loss.
            /*IF CLM120.LOSS <> 'FE'  AND CLM120.LOSS  <>  'EX' THEN DO: Lukkana M. A53-0139 02/09/2010*/
               n_loss = clm120.loss.
            /*END. /* "FE" & "EX" */*/
        /*---A51-0126---*/
        IF SUBSTR(czd101.claim,3,2) = "70" AND 
           (n_loss = "IC" OR n_loss = "LC" OR
            n_loss = "LL" OR n_loss = "DB") THEN DO:

             ASSIGN cnt_comp = YES.
            
            OUTPUT TO VALUE (nv_Coutput) APPEND NO-ECHO.
            EXPORT DELIMITER ";"
             ""
             czm100.Branch    czm100.POLTYP    nv_poldes
             czm100.GRPTYP    czm100.CLAIM     nv_event
             czm100.POLICY    
             /*---
             czm100.VEHREG
             comment by Chaiyong W. A54-0112 12/12/2012*/
             czm100.VEHREG FORMAT "X(11)" /*---add by Chaiyong W. A54-0112 12/12/2012*/   
             nv_insurnam      nv_pdcode        nv_pdname 
             nv_comdat        nv_expdat        nv_renpol
             nv_covcod        nv_defau         nv_loss1
             n_loss           czd101.clmant    czd101.clitem 
             czm100.ENTDAT    czm100.LOSDAT    czm100.NOTDAT  
             czm100.ENTDAT    czd101.osres     
             ""               ""               nv_nacod
             nv_nades         nv_pacod         nv_pades
             czd101.paidamt   czd101.paiddat   nv_police  
             nv_adjusna       nv_extcod        nv_extnam        
             nv_cedclm        czm100.DOCST. 
          OUTPUT CLOSE.
          
             /*FIND FIRST wfcpoltyp WHERE wfcpoltyp.wfcpbr = SUBSTR(czd101.claim,2,1) AND Lukkana M. A53-0139 22/07/2010*/
             FIND FIRST wfcpoltyp WHERE wfcpoltyp.wfcpbr = nv_br1 AND /*Lukkana M. A53-0139 22/07/2010*/
                                        wfcpoltyp.wfctyp = substr(czd101.claim,1,1) NO-ERROR.
             IF NOT AVAIL wfcpoltyp THEN 
             CREATE wfcpoltyp.
             /*ASSIGN wfcpoltyp.wfcpbr = SUBSTR(czd101.claim,2,1) Lukkana M. A53-0139 22/07/2010*/
             ASSIGN wfcpoltyp.wfcpbr   = nv_br1 /*Lukkana M. A53-0139 22/07/2010*/
                    wfcpoltyp.wfctyp   = SUBSTR(czd101.claim,1,1)
                    wfcpoltyp.wfcpres  = wfcpoltyp.wfcpres + czd101.osres
                    wfcpoltyp.wfcppaid = wfcpoltyp.wfcppaid + czd101.paidamt.
                 /* wfcpoltyp.wfcpcnt  = wfcpoltyp.wfcpcnt + 1.*/
          END.
          /*--end A51-0126---*/
        
END.   /* clm120*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdfindRenpol C-Win 
PROCEDURE pdfindRenpol :
/*------------------------------------------------------------------------------
  Purpose: Find Renew Policy    
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  nv_renpol = "" .    /* A51-0102 */
  FIND FIRST uwm100  WHERE uwm100.policy = clm100.policy  AND
                           uwm100.rencnt = clm100.rencnt  AND
                           uwm100.endcnt = clm100.endcnt
  NO-LOCK NO-ERROR NO-WAIT.
  IF AVAIL uwm100  THEN  
      nv_renpol  =  uwm100.renpol.
     
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdHeader C-Win 
PROCEDURE pdHeader :
/*------------------------------------------------------------------------------
  Purpose: Check Report Type (Motor/Non motor)     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF n_report = 1 THEN DO:           /* Motor */
   IF n_poltyp <> "ALL" THEN DO:   /* Policy Line 70 72 73 74 */

      ASSIGN poltyp = n_poltyp.
     
      RUN pdPrnMotor1.

      FOR EACH wText3.
          DELETE wText3.
      END.

      FOR EACH wText4.
          DELETE wText4.
      END.

      RUN proc_exporttext. 
      RUN proc_exporttextcsv. 

      MESSAGE "Export File Excel(csv) Complete" VIEW-AS ALERT-BOX . 
   END.
   ELSE DO:  /* All */

      RUN pdPrnAllMotor1_2.

      FOR EACH   wText3.
          DELETE wText3.
      END.
      FOR EACH   wText4.
          DELETE wText4.
      END.

      ASSIGN tim01      =  STRING(TIME,"HH:MM:SS") 
          nv_text       =  "" 
          nv_count      =  0
          nv_countcl    =  0
          nv_cnt        =  0
          nv_row        =  1
          nv_chkpollicy =  "".

      IF  INDEX(n_output,".slk") = 0 THEN  n_output  =  TRIM(n_output) + ".slk".

      RUN proc_exporttext.  

      ASSIGN tim02   = STRING(TIME,"HH:MM:SS").

      MESSAGE "export test slk complete" tim01 tim02 VIEW-AS ALERT-BOX.
    
   END.
END.
ELSE DO:       /* Non Motor */

    RUN wac\wacrosc2.

END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdItemCode C-Win 
PROCEDURE pdItemCode :
/*------------------------------------------------------------------------------
  Purpose: Find Text Code Claim   
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*--- A51-0102 ---*/
ASSIGN nv_nacod  = ""
       nv_nades  = "".
/*-------------------*/

FOR EACH clm120 USE-INDEX clm12001     WHERE
         clm120.claim  = clm100.claim  AND 
         clm120.clmant = czd101.clmant AND 
         clm120.clitem = czd101.clitem NO-LOCK 
BREAK BY clm120.claim 
      BY clm120.clmant
      BY clm120.clitem :

    IF clm120.bencod <> "" THEN DO:
          FIND FIRST sym100 USE-INDEX sym10001 WHERE
                     sym100.tabcod = "U070"    AND
                     sym100.itmcod = clm120.bencod NO-LOCK NO-ERROR.
          IF AVAIL sym100 THEN DO:
             nv_nacod = sym100.itmcod.
             nv_nades = sym100.itmdes.
          END.
    END.
    
END. /* Loop2 clm120 */


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdPrnAllMotor C-Win 
PROCEDURE pdPrnAllMotor :
/*------------------------------------------------------------------------------
  Purpose:   Print Report Motor - All (70, 72, 73, 74)  
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wfpoltyp NO-LOCK:
    DELETE wfpoltyp.
END.
FOR EACH wfbranch NO-LOCK:
    DELETE wfbranch.
END.
FOR EACH wftbranch NO-LOCK:
    DELETE wftbranch.
END.
FOR EACH wfcpoltyp NO-LOCK:
    DELETE wfcpoltyp.
END.
FOR EACH wfcbranch NO-LOCK:
    DELETE wfcbranch.
END.
FOR EACH wfctbranch NO-LOCK:
    DELETE wfctbranch.
END.
FOR EACH wfcnt NO-LOCK:
    DELETE wfcnt.
END.
DEF VAR nv_amt19  AS DECI. /*Lukkana M. A53-0139 03/09/2010*/
DEF VAR nv_amt20  AS DECI. /*Lukkana M. A53-0139 03/09/2010*/

ASSIGN nv_reccnt = 0       nv_reccnt2 = 0
       nv_next   = 1       nv_next2   = 1
       wt_cnt    = 0       wg_cnt     = 0.

loop_czm100:
  FOR EACH czm100  USE-INDEX czm10002 WHERE 
           czm100.ASDAT   = n_asdat     AND 
           czm100.BRANCH >= nv_branfr AND
           czm100.BRANCH <= nv_branto AND 
           SUBSTR(czm100.POLTYP,2,1) = "7" NO-LOCK
  BREAK BY czm100.BRANCH                   BY SUBSTR(czm100.POLTYP,2,2)
        BY SUBSTR(czm100.CLAIM,1,1)        BY czm100.CLAIM : 

        DISP czm100.claim WITH NO-LABEL TITLE "Printing Report..."
        FRAME a VIEW-AS DIALOG-BOX.
        
        RUN pdfindRenpol.   /*Find RenPol*/
        RUN pdfindCovcod.   /*Find CovCod*/
       
        IF FIRST-OF (czm100.BRANCH) THEN DO:
           nv_nbran = czm100.BRANCH.
           RUN pd_nbran.
        END.

        IF FIRST-OF (SUBSTRING (czm100.poltyp,2,2)) THEN DO:
           FIND Xmm031 USE-INDEX Xmm03101 WHERE 
                Xmm031.poltyp = czm100.POLTYP NO-LOCK NO-ERROR.
           nv_ntype = IF AVAILABLE Xmm031 THEN Xmm031.poldes
                      ELSE "!!! Not found (" + TRIM (czm100.POLTYP) + ")".
        END. /*--- FIRST-OF (czm100.poltyp) ---*/
       
        IF czm100.POLTYP  = " " THEN NEXT loop_czm100.
       
        FIND XMM031 USE-INDEX XMM03101 WHERE 
             XMM031.POLTYP = czm100.POLTYP NO-LOCK NO-ERROR.
             nv_poldes = IF AVAILABLE XMM031 THEN XMM031.POLDES
                         ELSE "!!! Not found (" + TRIM (czm100.POLTYP) + ")".

        FIND Xmm600 USE-INDEX Xmm60001 WHERE
             Xmm600.acno = czm100.INTREF NO-LOCK NO-ERROR NO-WAIT.
        IF AVAILABLE xmm600 THEN 
           ASSIGN nv_adjust  = TRIM(Xmm600.ntitle) + TRIM(Xmm600.name)
                  nv_adjusna = TRIM(TRIM(Xmm600.ntitle) + TRIM(Xmm600.name)).  
        ELSE ASSIGN  nv_adjust  = ""
                     nv_adjusna = "".

        RUN pdFindACNO.
        
        IF n_ostyp = 1 THEN DO:
           IF czm100.OS <= 0 THEN NEXT loop_czm100.
        END.
        ELSE DO:
            IF czm100.OS < 0 THEN NEXT loop_czm100. /*Lukkana M. A53-0139 03/09/2010 OS ติดลบไม่ต้องแสดงออกมา*/
        END.
       
        FOR EACH czd101 USE-INDEX czd10101  WHERE
                 czd101.asdat = czm100.asdat AND
                 czd101.claim = czm100.claim NO-LOCK
        BREAK BY SUBSTR(czd101.claim,1,1) BY SUBSTR(czd101.claim,2,1)
              BY SUBSTR(czd101.claim,3,2) BY czd101.claim:

              /*-Lukkana M. A53-0139 21/07/2010--*/
              nv_br1 = "".
              IF SUBSTR(czd101.claim,1,2) >= "10" AND
                 SUBSTR(czd101.claim,1,2) <= "99" THEN nv_br1 = SUBSTR(czd101.claim,1,2).
              ELSE nv_br1 = SUBSTR(czd101.claim,2,1).
              
              /*--Lukkana M. A53-0139 21/07/2010--*/
              
              RUN pdItemCode.     /*Find ItemCode*/

              /* A51-0102 */
              RUN pdfindLoss.     /*Find Nature of Loss*/ 

              /*--
              IF n_ostyp = 1 THEN DO:
                 IF czd101.osres <= 0 THEN NEXT.
              END.
              Lukkana m. A53-0139 03/09/2010*/

              /*-Lukkana M. A53-0139 21/07/2010--*/
              IF n_ostyp = 1 THEN DO:
                  //IF n_loss <> 'FE'  AND n_loss  <>  'EX' THEN IF czd101.osres  <= 0 THEN NEXT .   --A664-0383---
                  FIND FIRST sym100 USE-INDEX sym10001 WHERE
                     sym100.tabcod = "CMLO"         AND
                     sym100.itmcod = n_loss NO-LOCK NO-ERROR.  /*Nature FE EX FV*/
                  IF NOT AVAIL sym100 THEN IF czd101.osres  <= 0 THEN NEXT .    /*A64-0383*/
              END.
              /*-Lukkana M. A53-0139 21/07/2010--*/
              
              IF FIRST-OF (czd101.claim) THEN DO: 
                 ASSIGN wt_cnt     =  wt_cnt + 1   /*Claim Count*/
                        wg_cnt     =  wg_cnt + 1.  /*Grand Claim Count*/

                 /*---A51-0126---*/
                 IF SUBSTR(czd101.claim,3,2) = "70" AND cnt_comp = YES THEN DO:
                    ASSIGN nc_cnt = nc_cnt + 1.
                    
                 /*FIND FIRST wfcompcnt WHERE wfcompcnt.wfcompcnt_br = SUBSTR(czd101.claim,2,1) NO-ERROR. Lukkana M. A53-0139 21/07/2010--*/
                 FIND FIRST wfcompcnt WHERE wfcompcnt.wfcompcnt_br = nv_br1 NO-ERROR. /*Lukkana M. A53-0139 21/07/2010--*/
                   IF NOT AVAIL wfcompcnt THEN DO:
                      CREATE wfcompcnt.
                      /*ASSIGN wfcompcnt.wfcompcnt_br = SUBSTR(czd101.claim,2,1). Lukkana M. A53-0139 21/07/2010--*/
                      ASSIGN wfcompcnt.wfcompcnt_br = nv_br1. /*Lukkana M. A53-0139 21/07/2010--*/
                   END.
                   ASSIGN wfcompcnt.wfcompcnt_cnt  = wfcompcnt.wfcompcnt_cnt + 1
                          wfcompcnt.wfcompcnt_res  = wfcompcnt.wfcompcnt_res + czd101.osres
                          wfcompcnt.wfcompcnt_paid = wfcompcnt.wfcompcnt_paid + czd101.paidamt.
                 END.
                    cnt_comp = NO.
                 /*------------*/
                 /*Lukkana M. A53-0139 03/09/2010*/
                 //IF n_loss <> 'FE'  AND n_loss  <>  'EX' THEN  --A664-0383---
                  FIND FIRST sym100 USE-INDEX sym10001 WHERE
                     sym100.tabcod = "CMLO"         AND
                     sym100.itmcod = n_loss NO-LOCK NO-ERROR.  /*Nature FE EX FV*/
                  IF NOT AVAIL sym100 THEN     /*A64-0383*/
                     ASSIGN  nv_amt19  = 0
                             nv_amt20  = czd101.osres .
                 ELSE ASSIGN nv_amt19  = czm100.amt[19] 
                             nv_amt20  = czm100.amt[19].
                 /*Lukkana M. A53-0139 03/09/2010*/

                 RUN ChkLineExcel.
                 OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
                 EXPORT DELIMITER ";"
                     wt_cnt
                     czm100.Branch    czm100.POLTYP    nv_poldes
                     czm100.GRPTYP    czm100.CLAIM     nv_event
                     czm100.POLICY    
                     /*---
                     czm100.VEHREG 
                     comment by Chaiyong W. A54-0112 12/12/2012*/
                     czm100.VEHREG FORMAT "X(11)" /*---add by Chaiyong W. A54-0112 12/12/2012*/  
                     nv_insurnam      nv_pdcode        nv_pdname 
                     nv_comdat        nv_expdat        nv_renpol
                     nv_covcod        nv_defau         nv_loss1
                     czm100.LOSS      czd101.clmant    czd101.clitem 
                     czm100.ENTDAT    czm100.LOSDAT    czm100.NOTDAT  
                     czm100.ENTDAT    czd101.osres
                     nv_AMT19         nv_AMT20   /*Lukkana M. A53-0139 30/08/2010*/
                     ""               ""               nv_nacod
                     nv_nades         nv_pacod         nv_pades
                     czd101.paidamt   czd101.paiddat   nv_police  
                     nv_adjusna       nv_extnam        nv_cedclm
                     czm100.DOCST. 
                 OUTPUT CLOSE.
                 nv_reccnt = nv_reccnt + 1.

                 /*--- By Branch ---*/
                 /*FIND FIRST wfcnt WHERE wfcnt.cntbranch = SUBSTR(czd101.claim,2,1) NO-ERROR. Lukkana M. A53-0139 21/07/2010--*/
                 FIND FIRST wfcnt WHERE wfcnt.cntbranch = nv_br1 NO-ERROR. /*Lukkana M. A53-0139 21/07/2010--*/
                 IF NOT AVAIL wfcnt THEN CREATE wfcnt.
                 
                 /*ASSIGN wfcnt.cntbranch = SUBSTR(czd101.claim,2,1) Lukkana M. A53-0139 21/07/2010--*/
                 ASSIGN wfcnt.cntbranch = nv_br1  /*Lukkana M. A53-0139 21/07/2010--*/
                        wfcnt.reccnt    = wfcnt.reccnt + 1.
                 
                 /*----------------*/

              END.    /*First-of czd101.claim for count record*/
              ELSE DO:
                 /*Lukkana M. A53-0139 03/09/2010*/
                 //IF n_loss <> 'FE'  AND n_loss  <>  'EX' THEN  --A664-0383---
                  FIND FIRST sym100 USE-INDEX sym10001 WHERE
                     sym100.tabcod = "CMLO"         AND
                     sym100.itmcod = n_loss NO-LOCK NO-ERROR.  /*Nature FE EX FV*/
                  IF NOT AVAIL sym100 THEN     /*A64-0383*/
                     ASSIGN  nv_amt19  = 0
                             nv_amt20  = czd101.osres .
                 ELSE ASSIGN nv_amt19  = czm100.amt[19] 
                             nv_amt20  = czm100.amt[19].
                 /*Lukkana M. A53-0139 03/09/2010*/

                 RUN ChkLineExcel.
                 OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
                 EXPORT DELIMITER ";"
                     "" 
                     czm100.Branch    czm100.POLTYP    nv_poldes
                     czm100.GRPTYP    czm100.CLAIM     nv_event
                     czm100.POLICY    
                     /*----
                     czm100.VEHREG
                     comment by Chaiyong W. A54-0112 12/12/2012*/
                     czm100.VEHREG FORMAT "X(11)" /*---add by Chaiyong W. A54-0112 12/12/2012*/   
                     nv_insurnam      nv_pdcode        nv_pdname 
                     nv_comdat        nv_expdat        nv_renpol
                     nv_covcod        nv_defau         nv_loss1
                     czm100.LOSS      czd101.clmant    czd101.clitem 
                     czm100.ENTDAT    czm100.LOSDAT    czm100.NOTDAT  
                     czm100.ENTDAT    czd101.osres 
                     nv_AMT19         nv_AMT20   /*Lukkana M. A53-0139 30/08/2010*/
                     ""               ""               nv_nacod
                     nv_nades         nv_pacod         nv_pades
                     czd101.paidamt   czd101.paiddat   nv_police  
                     nv_adjusna       nv_extnam        nv_cedclm
                     czm100.DOCST. 
                 OUTPUT CLOSE.
                 nv_reccnt = nv_reccnt + 1.
              END. /*else do:*/

              CREATE wfpoltyp.    
              /*ASSIGN wfpoltyp.wfpbr = SUBSTR(czd101.claim,2,1) Lukkana M. A53-0139 21/07/2010--*/
              ASSIGN wfpoltyp.wfpbr   = nv_br1 /*Lukkana M. A53-0139 21/07/2010--*/
                     wfpoltyp.wftyp   = SUBSTR(czd101.claim,1,1)
                     wfpoltyp.wfline  = SUBSTR(czd101.claim,3,2)
                     wfpoltyp.wfpres  = wfpoltyp.wfpres + czd101.osres
                     wfpoltyp.wfppaid = wfpoltyp.wfppaid + czd101.paidamt.

              ASSIGN nv_sumos   = nv_sumos + czd101.osres
                     nv_sumpaid = nv_sumpaid + czd101.paidamt.
        END. /*Each czd101*/

        IF LAST-OF (czm100.branch) THEN DO:
           wt_cnt = 0.
        END.

        RUN pdPrnSMotor.

        RUN pdClrValue.
  END. /* Each czm100 */
  
  /*--Detail--*/  
  RUN ChkLineExcel.
  OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
  EXPORT DELIMITER ";" "".
  EXPORT DELIMITER ";"
        "Total By D/I" 
        "" "" "" "" "" "" "" "" "" "" "" ""
        "" "" "" "" "" "" "" "" "" "" "" ""  
        "O/S Claim" "" "" "" "" "" "" "" ""
        "Paid Amount".
  OUTPUT CLOSE.
  nv_reccnt = nv_reccnt + 2.
  /*--Sum--*/
  RUN ChkLineExcel2.
  OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO.
  EXPORT DELIMITER ";" "".
  EXPORT DELIMITER ";"
        "Total By D/I" 
        "" "" "" "" "" "" "" "" "" "" 
        "" "" "" "" "" "" "" "" "" "" 
        "O/S Claim" "" "" "" "" "" "" "" ""
        "Paid Amount".
  OUTPUT CLOSE. 
  nv_reccnt2 = nv_reccnt2 + 2.

  FOR EACH wfpoltyp BREAK BY wfpoltyp.wftyp BY wfpoltyp.wfpbr  BY wfpoltyp.wfline :
       /*--Detail--*/
       ASSIGN n_os = n_os + wfpoltyp.wfpres
              n_paid = n_paid + wfpoltyp.wfppaid.

      /* IF LAST-OF (wfpoltyp.wftyp)  THEN DO:*/
       IF LAST-OF (wfpoltyp.wfline)  THEN DO:
          n_br = wfpoltyp.wfpbr.
          RUN pdbdes.
          RUN ChkLineExcel.
          OUTPUT TO VALUE (nv_output) APPEND NO-ECHO. 
          EXPORT DELIMITER ";"
              ""
              wfpoltyp.wftyp + " - " + wfpoltyp.wfpbr + " - " + wfpoltyp.wfline
              n_bdes "" "" "" "" "" "" "" "" "" ""
              "" "" "" "" "" "" "" "" "" "" "" ""
              n_os  "" "" "" "" "" "" "" ""
              n_paid.
          OUTPUT CLOSE.
          nv_reccnt = nv_reccnt + 1.
          /*--Sum--*/
          RUN ChkLineExcel2.
          OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO. 
          EXPORT DELIMITER ";"
              "" 
              wfpoltyp.wftyp + " - " + wfpoltyp.wfpbr + " - " + wfpoltyp.wfline
              n_bdes "" "" "" "" "" "" "" "" "" 
              "" "" "" "" "" "" "" "" ""
              n_os  "" "" "" "" "" "" "" ""
              n_paid.
          OUTPUT CLOSE.
          nv_reccnt2 = + nv_reccnt2 + 1.
          
          ASSIGN n_bosres = n_bosres + n_os
                 n_bpaid  = n_bpaid + n_paid
                 n_os     = 0
                 n_paid   = 0.
       END.

       IF LAST-OF (wfpoltyp.wfline) THEN DO:
           CREATE wfbranch.
           ASSIGN wfbranch.wfbr = wfpoltyp.wfpbr
                  wfbranch.wfbline = wfpoltyp.wfline
                  wfbranch.wfbres =  n_bosres
                  wfbranch.wfbpaid = n_bpaid
                  n_bosres = 0
                  n_bpaid  = 0.
       END.
  END.

  FOR EACH wfbranch BREAK BY wfbranch.wfbr BY wfbranch.wfbline:

    ASSIGN n_tosres = n_tosres + wfbranch.wfbres
           n_tpaid  = n_tpaid + wfbranch.wfbpaid. 

    IF LAST-OF (wfbranch.wfbr) THEN DO:
       CREATE wftbranch.
       ASSIGN wftbranch.wftbr = wfbranch.wfbr
              wftbranch.wftbres = n_tosres
              wftbranch.wftbpaid = n_tpaid
              n_tosres = 0
              n_tpaid = 0. 
    END.
  END.
  
  /*--Detail--*/ 
  RUN ChkLineExcel.
  OUTPUT TO VALUE (nv_output) APPEND NO-ECHO. 
  EXPORT DELIMITER ";"
      "".
  EXPORT DELIMITER ";"
  "Total By Branch" "" "" "" "" "" "" "" "" ""
  "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" 
  "O/S Claim" "" "" "" "" "" "" "" "" 
  "Paid Amount".
  OUTPUT CLOSE.
  nv_reccnt = nv_reccnt + 2.
  /*--Sum--*/
  RUN ChkLineExcel2.
  OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO. 
  EXPORT DELIMITER ";"
      "".
  EXPORT DELIMITER ";"
  "Total By Branch" ""
  "" "" "" "" "" "" "" "" "" ""  
  "" "" "" "" "" "" "" "" ""
  "O/S Claim" "" "" "" "" "" "" "" ""
  "Paid Amount".
  OUTPUT CLOSE.
  nv_reccnt2 = nv_reccnt2 + 2.

  FOR EACH wftbranch BREAK BY wftbranch.wftbr:
      n_br = wftbranch.wftbr.
      RUN pdbdes.
      /*--Detail--*/
      RUN ChkLineExcel.
      OUTPUT TO VALUE (nv_output) APPEND NO-ECHO. 
      EXPORT DELIMITER ";"
        "" 
        "Total Branch: " + wftbranch.wftbr  
        n_bdes "" "" "" "" "" "" "" "" "" ""
        "" "" "" "" "" "" "" "" "" "" "" ""
        wftbranch.wftbres "" "" "" "" "" "" "" ""
        wftbranch.wftbpaid.
      OUTPUT CLOSE.
      nv_reccnt = nv_reccnt + 1.
      /*--Sum--*/
      RUN ChkLineExcel2.
      OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO. 
      EXPORT DELIMITER ";"
        "" 
        "Total Branch: " + wftbranch.wftbr 
        n_bdes "" "" "" "" "" "" "" "" ""  
        "" "" "" "" "" "" "" "" ""
        wftbranch.wftbres "" "" "" "" "" "" "" ""
        wftbranch.wftbpaid.
      OUTPUT CLOSE.
      nv_reccnt2 = nv_reccnt2 + 1.
      ASSIGN n_gosres = n_gosres + wftbranch.wftbres
             n_gpaid  = n_gpaid  + wftbranch.wftbpaid.
  END.
  /*--Detail--*/
  RUN ChkLineExcel.
  OUTPUT TO VALUE (nv_output) APPEND NO-ECHO. 
  EXPORT DELIMITER ";"
    "".
  EXPORT DELIMITER ";"
    "GrandTotal By Branch" "" ""
    "" "" "" "" "" "" "" "" "" "" ""
    "" "" "" "" "" "" "" "" "" "" "" 
    n_gosres "" "" "" "" "" "" "" ""
    n_gpaid.
  OUTPUT CLOSE.
  nv_reccnt = nv_reccnt + 2.
  /*--Sum--*/
  RUN ChkLineExcel2.
  OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO. 
  EXPORT DELIMITER ";"
    "".
  EXPORT DELIMITER ";"
    "GrandTotal By Branch" 
    "" "" "" "" "" "" "" "" "" ""
    "" "" "" "" "" "" "" "" "" ""
    n_gosres "" "" "" "" "" "" "" ""
    n_gpaid.
  OUTPUT CLOSE.
  nv_reccnt2 = nv_reccnt2 + 2.

  ASSIGN n_gosres = 0
         n_gpaid  = 0.
  /*Detail*/
  RUN ChkLineExcel.
  OUTPUT TO VALUE (nv_output) APPEND NO-ECHO. 
  EXPORT DELIMITER ";"
    "".
  EXPORT DELIMITER ";" 
    "Count By Branch:" "" 
    "Count Claim".
    OUTPUT CLOSE.
  nv_reccnt = nv_reccnt + 2.
  /*Summary*/
  RUN ChkLineExcel2.
  OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO. 
  EXPORT DELIMITER ";"
    "".
  EXPORT DELIMITER ";" 
    "Count By Branch:" ""
    "Count Claim".
    OUTPUT CLOSE.
  nv_reccnt2 = nv_reccnt2 + 2.

  FOR EACH wfcnt NO-LOCK:
      n_br = wfcnt.cntbranch.
      RUN pdbdes.
      /*Detail*/
      RUN ChkLineExcel.
      OUTPUT TO VALUE (nv_output) APPEND NO-ECHO. 
      EXPORT DELIMITER ";"
        "Branch: " + wfcnt.cntbranch 
        n_bdes
        wfcnt.reccnt.
      OUTPUT CLOSE.
      nv_reccnt = nv_reccnt + 1.
      /*Summary*/
      RUN ChkLineExcel2.
      OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO. 
      EXPORT DELIMITER ";"
        "Branch: " + wfcnt.cntbranch 
        n_bdes
        wfcnt.reccnt.
      OUTPUT CLOSE.
      nv_reccnt2 = nv_reccnt2 + 1.
  END.
  /*Detail*/
  RUN ChkLineExcel.
  OUTPUT TO VALUE (nv_output) APPEND NO-ECHO. 
  EXPORT DELIMITER ";" 
    "Total Claim: " "" 
    wg_cnt.
  OUTPUT CLOSE.
  nv_reccnt = nv_reccnt + 1.
  /*Summary*/
  RUN ChkLineExcel2.
  OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO. 
  EXPORT DELIMITER ";" 
    "Total Claim: " "" 
    wg_cnt.
  OUTPUT CLOSE.
  nv_reccnt2 = nv_reccnt2 + 1.

RUN pdPrnComp.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdPrnAllMotor1 C-Win 
PROCEDURE pdPrnAllMotor1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wText. 
    DELETE wText.
END.
FOR EACH wText2. 
    DELETE wText2.
END.
FOR EACH czm100  USE-INDEX czm10002 WHERE 
    czm100.ASDAT               = n_asdat    AND 
    czm100.BRANCH             >= nv_branfr  AND
    czm100.BRANCH             <= nv_branto  AND 
    czm100.POLTYP             >= "V70"      AND
    czm100.POLTYP             <= "V74"      NO-LOCK
    BREAK BY czm100.BRANCH                   
    BY SUBSTR(czm100.POLTYP,2,2)
    BY SUBSTR(czm100.CLAIM,1,1)       
    BY czm100.CLAIM : 
    
    DISP czm100.claim WITH NO-LABEL TITLE "Printing Report..."  FRAME a VIEW-AS DIALOG-BOX.
    ASSIGN 
        nr_CLAIM      = ""  
        nr_trandat    = ?              
        nr_comdate    = ?     /*fai*/  
        nr_agent1 = ""
        nr_entdat     = ""  
        nr_notdat     = ""   
        nr_LOSDAT     = "" 
        nr_POLICY     = "" 
        nr_name       = ""    
        nr_LOSS       = ""  
        nr_loss1      = ""
        nr_clmant_itm = ""  
        nr_osres      = 0 
        nr_facri      = 0 
        nr_adjust     = "" 
        nr_intref     = "" 
        nr_extref     = "" 
        nr_agent      = "" 
        nr_cedclm     = "" 
        nr_DOCST      = "" 
        nr_pades      = ""
        nr_branchdsp  = ""
        nr_countpag   = 0               /*count data */
        nr_type       = "".
    IF n_ostyp = 1 THEN DO:             /*"O/S Claim > 0"*/    
        IF czm100.OS <= 0 THEN NEXT .
    END.
    ELSE DO:                            /*"O/S Claim All"*/
        IF czm100.OS < 0 THEN NEXT .
    END.
    ASSIGN nr_countpag = nr_countpag + 1.
    /*IF (czm100.POLTYP = "v70") AND               /* line71 ( IC,LC,LL,DB )*/
        ((TRIM(STRING(czm100.LOSS)) = "IC" ) OR  (TRIM(STRING(czm100.LOSS)) = "LC" ) OR
         (TRIM(STRING(czm100.LOSS)) = "LL" ) OR  (TRIM(STRING(czm100.LOSS)) = "DB" )) THEN ASSIGN nr_type = "V71".
    ELSE ASSIGN nr_type = czm100.POLTYP .   
    FIND LAST  wText2 WHERE wText2.nr_branch = czm100.BRANCH  AND 
                            wText2.nr_Line   = nr_type        NO-ERROR NO-WAIT.
    IF NOT AVAIL wText2 THEN DO:
        CREATE wText2.
        ASSIGN wText2.nr_branch = czm100.BRANCH
               wText2.nr_Line   = nr_type .
        FIND LAST  xmm023  USE-INDEX xmm02301    WHERE xmm023.branch   =  czm100.BRANCH  NO-LOCK NO-ERROR NO-WAIT.
        IF  AVAIL  xmm023 THEN ASSIGN  wText2.nr_branchdsp  =  trim(xmm023.bdes) .
        ELSE ASSIGN  wText2.nr_branchdsp  = "" .
    END.*/
    FIND LAST clm100 USE-INDEX clm10001 WHERE  CLM100.CLAIM = czm100.CLAIM   NO-LOCK NO-ERROR.
    IF AVAIL clm100 THEN DO:
        ASSIGN 
            nr_agent  = clm100.agent
            nr_cedclm = clm100.cedclm
            nr_name   = TRIM(clm100.ntitle) + " " + TRIM(clm100.name1)    
            nr_loss1  = TRIM(clm100.loss1)  + " " + TRIM(clm100.loss2) + " " + TRIM(clm100.loss3)  .
        /*FIND LAST  clm120 USE-INDEX clm12001  WHERE clm120.claim  = clm100.claim  NO-LOCK NO-ERROR.*/

         /*Saowapa U. A61-0460*/  
       
         FIND FIRST uwm100  WHERE uwm100.policy = clm100.policy  AND                                          
             uwm100.rencnt = clm100.rencnt  AND                                                               
             uwm100.endcnt = clm100.endcnt                                                                    
             NO-LOCK NO-ERROR NO-WAIT.                                                                        
         IF AVAIL uwm100  THEN                                                                                
             ASSIGN                                                                                           
             nr_trandat = uwm100.trndat                                                                       
             nr_comdate = uwm100.comdat.                                                                      
         /*end Saowapa U. A61-0460*/                                                                                      
         FIND FIRST xmm600 USE-INDEX xmm60001  WHERE xmm600.acno = uwm100.acno1 NO-LOCK NO-ERROR NO-WAIT.     
         IF AVAIL xmm600 THEN DO:                                                                             
             nr_agent1  = uwm100.agent.                                                                       
         END.                                                                                                 
         ELSE DO:                                                                                             
             FIND FIRST xtm600 USE-INDEX xtm60001  WHERE xtm600.acno = uwm100.acno1 NO-LOCK NO-ERROR NO-WAIT. 
             IF AVAIL xtm600 THEN DO:                                                                         
                 nr_agent1  = uwm100.agent.                                                                   
             END.                                                                                             
         END.                                                                                                 
        /*-----*/        
        FOR EACH   clm120 USE-INDEX clm12001  WHERE 
            clm120.claim  = clm100.claim  NO-LOCK
            BREAK BY clm120.claim BY clm120.clmant BY clm120.clitem :
            /************************************/
            //IF (clm120.loss <> 'FE' AND clm120.loss <> 'EX') THEN DO:  --A664-0383---
                  FIND FIRST sym100 USE-INDEX sym10001 WHERE
                     sym100.tabcod = "CMLO"         AND
                     sym100.itmcod = clm120.loss NO-LOCK NO-ERROR.  /*Nature FE EX FV*/
                  IF NOT AVAIL sym100 THEN DO:    /*A64-0383*/
                IF (clm120.styp20 <> 'X' AND clm120.styp20 <> 'F' AND clm120.styp20 <> 'R') THEN DO:
                    IF LAST-OF(clm120.clitem) THEN DO:
                        /*w_docst = IF clm120.prdlos = 0 THEN "NO" ELSE "YES" . */
                        ASSIGN     
                            n_totres = 0
                            n_totnet = 0
                            w_gross  = 0.
                        FOR EACH clm131 USE-INDEX clm13101  WHERE
                            clm131.claim   = clm100.claim   AND
                            clm131.clmant  = clm120.clmant  AND
                            clm131.clitem  = clm120.clitem  AND
                            clm131.cpc_cd  = "EPD"       /* AND
                            clm131.trndat >= frdate         AND
                            clm131.trndat <= todate  */       NO-LOCK:
                            IF clm131.res <> ? THEN DO:
                                n_totres = n_totres + clm131.res.
                            END.
                        END.   /* end clm131 */
                        FOR EACH clm130 USE-INDEX clm13002      WHERE
                            clm130.claim   = clm100.claim  AND
                            clm130.clmant  = clm120.clmant AND
                            clm130.clitem  = clm120.clitem AND
                            clm130.cpc_cd  = 'EPD'     /*  AND
                            clm130.entdat >= frdate        AND
                            clm130.entdat <= todate */       NO-LOCK,
                            FIRST clm200 USE-INDEX clm20001 WHERE
                            clm200.trnty1 = clm130.trnty1   AND
                            clm200.docno  = clm130.docno    AND
                            clm200.releas = YES             NO-LOCK
                            BREAK BY clm130.claim BY clm130.clmant BY clm130.clitem :
                            IF clm130.netl_d <> ? THEN DO:
                                n_totnet = n_totnet + clm130.netl_d.
                            END.
                        END.      /* FOR EACH clm130 */
                        IF n_totres > 0 AND n_totres > n_totnet THEN DO:
                                w_gross = n_totres - n_totnet.
                                IF w_gross   < 0 THEN w_gross = 0.
                                IF w_gross   > 0  THEN DO:   
                                    ASSIGN  nr_extref =   clm120.extref.
                                    FIND FIRST czd101 USE-INDEX czd10101 WHERE
                                        czd101.asdat  = n_asdat          AND      /*Add A57-0343*/
                                        czd101.claim  = clm100.claim     AND
                                        czd101.clmant = clm120.clmant    AND 
                                        czd101.clitem = clm120.clitem    NO-LOCK NO-ERROR.
                                    IF   AVAIL czd101 THEN DO:
                                        ASSIGN  nr_clmant_itm = string(czd101.clmant,"999") + "/" + string(czd101.clitem,"999")  .
                                                nr_osres      = czd101.osres    .    
                                    END.
                                    
                                    IF (czm100.POLTYP = "v70") AND               /* line71 ( IC,LC,LL,DB )*/
                                        ((TRIM(STRING(CAPS(CLM120.LOSS))) = "IC" ) OR  (TRIM(STRING(CAPS(CLM120.LOSS))) = "LC" ) OR
                                         (TRIM(STRING(CAPS(CLM120.LOSS))) = "LL" ) OR  (TRIM(STRING(CAPS(CLM120.LOSS))) = "DB" )) THEN ASSIGN nr_type = "V71".
                                    ELSE ASSIGN nr_type = czm100.POLTYP .   
                                    FIND LAST  wText2 WHERE wText2.nr_branch = czm100.BRANCH  AND 
                                        wText2.nr_Line   = nr_type        NO-ERROR NO-WAIT.
                                    IF NOT AVAIL wText2 THEN DO:
                                        CREATE wText2.
                                        ASSIGN wText2.nr_branch = czm100.BRANCH
                                            wText2.nr_Line   = nr_type .
                                        FIND LAST  xmm023  USE-INDEX xmm02301    WHERE xmm023.branch   =  czm100.BRANCH  NO-LOCK NO-ERROR NO-WAIT.
                                        IF  AVAIL  xmm023 THEN ASSIGN  wText2.nr_branchdsp  =  trim(xmm023.bdes) .
                                        ELSE ASSIGN  wText2.nr_branchdsp  = "" .
                                    END.
                                    
                                    FIND xtm600 USE-INDEX xtm60001 WHERE xtm600.acno = clm120.intref NO-LOCK NO-ERROR.
                                    IF AVAIL xtm600 THEN  nr_adjust = xtm600.name.
                                    ELSE ASSIGN nr_adjust = "".
                                    FIND FIRST sym100 USE-INDEX sym10001 WHERE
                                        sym100.tabcod = "U070"    AND
                                        sym100.itmcod = clm100.busreg NO-LOCK NO-ERROR NO-WAIT.
                                    IF AVAIL sym100 THEN   ASSIGN nr_pades  = sym100.itmdes.
                                    ELSE ASSIGN nr_pades  = "".
                                    CREATE wText.
                                    ASSIGN 
                                        wText.nr_line       = nr_type              /* line 70,72,73,74 ,...71 ( IC,LC,LL,DB )*/
                                        wText.nr_branch     = czm100.BRANCH
                                        wText.nr_CLAIM      = czm100.CLAIM       
                                        wText.nr_entdat     = STRING(czm100.ENTDAT,"99/99/9999")     
                                        wText.nr_notdat     = STRING(czm100.NOTDAT,"99/99/9999")   
                                        wText.nr_LOSDAT     = STRING(czm100.LOSDAT,"99/99/9999") 
                                        wText.nr_POLICY     = TRIM(czm100.POLICY)
                                        /*SUBSTRING(czm100.POLICY,1,2) + "-" +  
                                        SUBSTRING(czm100.POLICY,3,2) + "-" +  
                                        SUBSTRING(czm100.POLICY,5,2) + "/" +  
                                        SUBSTRING(czm100.POLICY,7,6)  */  
                                        wText.nr_name       = nr_name 
                                        wText.nr_LOSS       = trim(clm120.loss)  /*STRING(czm100.LOSS)*//* error type****/
                                        wText.nr_loss1      = nr_loss1     
                                        wText.nr_clmant_itm = nr_clmant_itm 
                                      /*wText.nr_osres      = w_gross   /*czm100.OS  nr_osres */*/
                                        wText.nr_osres      = nr_osres 
                                        wText.nr_facri      = czm100.AMT[3] 
                                        wText.nr_adjust     = nr_adjust              
                                        wText.nr_intref     = czm100.intref 
                                        wText.nr_extref     = nr_extref   
                                        wText.nr_agent      = nr_agent    
                                        wText.nr_cedclm     = nr_cedclm    
                                        wText.nr_DOCST      = czm100.DOCST            
                                        wText.nr_pades      = nr_pades   
                                         wText.nr_trndat     = nr_trandat  /*fai*/   
                                          wText.nr_comdat     = nr_comdate             
                                          wText.nr_agent1     = nr_agent1.        
                                        
                                    
                                END.  /*w_gross   > 0*/

                        END. /*n_totres > 0*/
                    END. /**/
                END. /*(clm120.styp20 <> 'X'*/
            END. /*clm120.loss <> 'FE'*/
        END.  /* for each clm120 */
    END.
    ELSE ASSIGN 
        nr_name  =   ""      
        nr_loss1 =   ""  . 
    
END.    /* czm100 */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdPrnAllMotor1_2 C-Win 
PROCEDURE pdPrnAllMotor1_2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wText. 
    DELETE wText.
END.
FOR EACH wText2. 
    DELETE wText2.
END.
FOR EACH wfsum.
    DELETE wfsum.
END.                                

FOR EACH czm100  USE-INDEX czm10002 WHERE 
    czm100.ASDAT      = n_asdat    AND 
    czm100.BRANCH    >= nv_branfr  AND
    czm100.BRANCH    <= nv_branto  AND 
    czm100.POLTYP    >= "V70"      AND
    czm100.POLTYP    <= "V74" NO-LOCK
    BREAK BY czm100.BRANCH                   
    BY SUBSTR(czm100.POLTYP,2,2)
    BY SUBSTR(czm100.CLAIM,1,1)       
    BY czm100.CLAIM : 

    DISP czm100.claim WITH NO-LABEL TITLE "Printing Report..."  FRAME a VIEW-AS DIALOG-BOX.

    ASSIGN nr_CLAIM   = ""             nr_adjust     = ""
        nr_trandat    = ?              nr_comdate    = ?    
        nr_entdat     = ""             nr_intref     = ""                     
        nr_notdat     = ""             nr_extref     = ""                     
        nr_LOSDAT     = ""             nr_agent      = ""                     
        nr_POLICY     = ""             nr_cedclm     = ""                     
        nr_name       = ""             nr_DOCST      = ""                     
        nr_LOSS       = ""             nr_pades      = ""                     
        nr_loss1      = ""             nr_branchdsp  = ""                     
        nr_clmant_itm = ""             nr_countpag   = 0     /*count data */  
        nr_osres      = 0              nr_type       = ""                     
        nr_facri      = 0              np_facri      = 0 
        nr_osres_nv   = 0              nr_osres_v    = 0.
        
    IF ( n_ostyp = 1 ) AND ( czm100.OS <= 0 )  THEN  NEXT.  /*"O/S Claim > 0"*/    
    ELSE  IF czm100.OS < 0 THEN NEXT . 
       
    IF (SUBSTR(czm100.claim,1,1) <> "D"     AND 
        SUBSTR(czm100.claim,1,1) <> "G"     AND 
        SUBSTR(czm100.claim,1,1) <> "M"     AND 
        SUBSTR(czm100.claim,1,1) <> "I"     AND LENGTH(czm100.claim)     <> 12)     OR 
       (SUBSTR(czm100.claim,1,2) < "10"     AND SUBSTR(czm100.claim,1,2) > "99"  ) THEN   NEXT . /*kridtiya i.30/03/2015*/
         
    ASSIGN nr_countpag = nr_countpag + 1.

    FIND LAST clm100 USE-INDEX clm10001 WHERE  CLM100.CLAIM = czm100.CLAIM   NO-LOCK NO-ERROR.
    IF AVAIL clm100 THEN DO:
        ASSIGN 
            nr_cedclm = clm100.cedclm
            nr_name   = TRIM(clm100.ntitle) + " " + TRIM(clm100.name1)    
            nr_loss1  = TRIM(clm100.loss1)  + " " + TRIM(clm100.loss2) + " " + TRIM(clm100.loss3).
        
        /*Saowapa U. A61-0460*/ 
         FIND FIRST uwm100 USE-INDEX uwm10001 WHERE uwm100.policy = clm100.policy  
                                                AND uwm100.rencnt = clm100.rencnt  
                                                AND uwm100.endcnt = clm100.endcnt NO-LOCK NO-ERROR NO-WAIT.                                                                            
         IF AVAIL uwm100 THEN DO:                                                                                 
            ASSIGN nr_agent  = uwm100.acno1
                nr_trandat = uwm100.trndat                                                                           
                nr_comdate = uwm100.comdat
                nr_agent1  = uwm100.agent. 

            ASSIGN nv_trndat = ?
                   nv_comdat = ?.

            FIND FIRST buwm100 USE-INDEX uwm10001 WHERE buwm100.policy = uwm100.policy  
                                                 AND buwm100.rencnt = uwm100.rencnt  
                                                 AND buwm100.endcnt = 000  NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL buwm100 THEN ASSIGN nv_trndat = buwm100.trndat
                                         nv_comdat = buwm100.comdat.
            ELSE ASSIGN nv_trndat = ?
                        nv_comdat = ?.
         END.
         /*end Saowapa U. A61-0460*/ 

        /*-----*/                                                                                               
        FOR EACH  czd101 USE-INDEX czd10101 NO-LOCK WHERE czd101.asdat  = n_asdat 
                                                      AND czd101.claim  = clm100.claim  
            BREAK BY czd101.claim
                  BY czd101.clmant 
                  BY czd101.clitem.

            ASSIGN w_gross = 0   w_gross_nv = 0   w_gross_v = 0.

            FIND LAST clm120 USE-INDEX clm12001  WHERE 
                      clm120.claim  = czm100.CLAIM     AND
                      clm120.clmant = czd101.clmant    AND
                      clm120.clitem = czd101.clitem    NO-LOCK NO-ERROR.
            IF AVAIL clm120 THEN DO:
                
                    ASSIGN nr_extref     = clm120.extref 
                           nr_intref     = clm120.intref
                           nr_clmant_itm = STRING(czd101.clmant,"999") + "/" + STRING(czd101.clitem,"999")   
                           nr_osres      = czd101.osres 
                           w_gross       = czd101.osres
                           w_gross_nv    = czd101.osres_netvat
                           w_gross_v     = czd101.osres_vat.
                    
                    IF (czm100.POLTYP = "v70") AND   /* line71 ( IC,LC,LL,DB )*/
                        ((TRIM(STRING(CAPS(CLM120.LOSS))) = "IC" ) OR  (TRIM(STRING(CAPS(CLM120.LOSS))) = "LC" ) OR
                         (TRIM(STRING(CAPS(CLM120.LOSS))) = "LL" ) OR  (TRIM(STRING(CAPS(CLM120.LOSS))) = "DB" )) THEN 
                        ASSIGN nr_type = "V71".
                    ELSE ASSIGN nr_type = czm100.POLTYP .  

                    FIND LAST wText2 WHERE wText2.nr_branch = czm100.BRANCH   
                                       AND wText2.nr_Line   = nr_type  NO-ERROR NO-WAIT.
                    IF NOT AVAIL wText2 THEN DO:
                        CREATE wText2.
                        ASSIGN wText2.nr_branch = czm100.BRANCH 
                               wText2.nr_Line   = nr_type.    /*Policy Type*/

                        FIND LAST  xmm023  USE-INDEX xmm02301    WHERE xmm023.branch   =  czm100.BRANCH   NO-LOCK NO-ERROR NO-WAIT.
                        IF  AVAIL  xmm023 THEN ASSIGN  wText2.nr_branchdsp  =  TRIM(xmm023.bdes) .
                        ELSE ASSIGN  wText2.nr_branchdsp  = "" .
                    END.

                    IF clm120.intref <> "" THEN DO:
                        FIND xtm600 USE-INDEX xtm60001 WHERE xtm600.acno = clm120.intref NO-LOCK NO-ERROR.
                        IF AVAIL xtm600 THEN  nr_adjust = xtm600.name.
                        ELSE ASSIGN nr_adjust = "".
                    END.

                    FIND FIRST sym100 USE-INDEX sym10001 WHERE sym100.tabcod = "U070"    
                                                           AND sym100.itmcod = clm100.busreg NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAIL sym100 THEN   ASSIGN nr_pades  = sym100.itmdes.
                    ELSE ASSIGN nr_pades  = "".

                    ASSIGN np_facri  = 0.
                       
                    RUN PD_csftq.  /*------ Put Detail Report -------*/

               ASSIGN w_gross  = 0
                      n_totres = 0 
                      n_totnet = 0.

                /*---Add By Benjaporn J. A59-0613 [14/12/2016] ---*/
               IF SUBSTR(wText.nr_CLAIM,1,1) = "D" OR 
                  SUBSTR(wText.nr_CLAIM,1,1) = "I" THEN DO:
                  ASSIGN ntype = SUBSTR(wText.nr_CLAIM,1,1).    /* Direct/Inward */
               END.
               ELSE ASSIGN ntype = "D" .

                FIND FIRST wfsum WHERE wfsum.n_type = ntype            AND                            /* D/I */
                                       wfsum.n_bran = wText.nr_branch  AND                            /* Branch */
                                       wfsum.n_line = SUBSTR(wText.nr_line,2,2)  NO-LOCK NO-ERROR .   /* LINE */ 
               
                IF NOT AVAIL wfsum THEN DO:
                    CREATE wfsum.
                    ASSIGN 
                        wfsum.n_type     = ntype                 
                        wfsum.n_bran     = wText.nr_branch         
                        wfsum.n_line     = SUBSTR(wText.nr_line,2,2)
                        wfsum.n_gross    = wText.nr_osres
                        wfsum.n_fac      = wText.nr_facri
                        wfsum.n_treaty   = wText.nr_treaty
                        wfsum.n_comp     = wText.nr_comp 
                        wfsum.n_ret      = wText.nr_net 
                        wfsum.n_ced      = wText.nr_ced  
                        wfsum.n_1st      = wText.nr_1st  
                        wfsum.n_2nd      = wText.nr_2nd  
                        wfsum.n_qs5      = wText.nr_qs5  
                        wfsum.n_tfp      = wText.nr_tfp  
                        wfsum.n_mps      = wText.nr_mps  
                        wfsum.n_eng      = wText.nr_eng  
                        wfsum.n_mar      = wText.nr_mar  
                        wfsum.n_rq       = wText.nr_rq   
                        wfsum.n_btr      = wText.nr_btr  
                        wfsum.n_otr      = wText.nr_otr  
                        wfsum.n_ftr      = wText.nr_ftr  
                        wfsum.n_fo1      = wText.nr_fo1  
                        wfsum.n_fo2      = wText.nr_fo2  
                        wfsum.n_fo3      = wText.nr_fo3  
                        wfsum.n_fo4      = wText.nr_fo4 
                        /* A63-0417 */
                        wfsum.n_gross_nv    = wText.nr_osres_nv
                        wfsum.n_gross_v     = wText.nr_osres_v
                        wfsum.n_fac_nv      = wText.nr_facri_nv
                        wfsum.n_treaty_nv   = wText.nr_treaty_nv
                        wfsum.n_comp_nv     = wText.nr_comp_nv 
                        wfsum.n_ret_nv      = wText.nr_net_nv 
                        wfsum.n_ced_nv      = wText.nr_ced_nv  
                        wfsum.n_1st_nv      = wText.nr_1st_nv  
                        wfsum.n_2nd_nv      = wText.nr_2nd_nv  
                        wfsum.n_qs5_nv      = wText.nr_qs5_nv  
                        wfsum.n_tfp_nv      = wText.nr_tfp_nv  
                        wfsum.n_mps_nv      = wText.nr_mps_nv  
                        wfsum.n_eng_nv      = wText.nr_eng_nv  
                        wfsum.n_mar_nv      = wText.nr_mar_nv  
                        wfsum.n_rq_nv       = wText.nr_rq_nv  
                        wfsum.n_btr_nv      = wText.nr_btr_nv  
                        wfsum.n_otr_nv      = wText.nr_otr_nv  
                        wfsum.n_ftr_nv      = wText.nr_ftr_nv  
                        wfsum.n_fo1_nv      = wText.nr_fo1_nv  
                        wfsum.n_fo2_nv      = wText.nr_fo2_nv  
                        wfsum.n_fo3_nv      = wText.nr_fo3_nv  
                        wfsum.n_fo4_nv      = wText.nr_fo4_nv  .
                END.
                ELSE IF AVAIL wfsum THEN DO:
                    ASSIGN  
                      wfsum.n_gross  = wfsum.n_gross  + wText.nr_osres
                      wfsum.n_fac    = wfsum.n_fac    + wText.nr_facri
                      wfsum.n_treaty = wfsum.n_treaty + wText.nr_treaty
                      wfsum.n_comp   = wfsum.n_comp   + wText.nr_comp 
                      wfsum.n_ret    = wfsum.n_ret    + wText.nr_net 
                      wfsum.n_ced    = wfsum.n_ced  +  wText.nr_ced    
                      wfsum.n_1st    = wfsum.n_1st  +  wText.nr_1st    
                      wfsum.n_2nd    = wfsum.n_2nd  +  wText.nr_2nd    
                      wfsum.n_qs5    = wfsum.n_qs5  +  wText.nr_qs5    
                      wfsum.n_tfp    = wfsum.n_tfp  +  wText.nr_tfp    
                      wfsum.n_mps    = wfsum.n_mps  +  wText.nr_mps    
                      wfsum.n_eng    = wfsum.n_eng  +  wText.nr_eng    
                      wfsum.n_mar    = wfsum.n_mar  +  wText.nr_mar    
                      wfsum.n_rq     = wfsum.n_rq   +  wText.nr_rq     
                      wfsum.n_btr    = wfsum.n_btr  +  wText.nr_btr    
                      wfsum.n_otr    = wfsum.n_otr  +  wText.nr_otr    
                      wfsum.n_ftr    = wfsum.n_ftr  +  wText.nr_ftr    
                      wfsum.n_fo1    = wfsum.n_fo1  +  wText.nr_fo1    
                      wfsum.n_fo2    = wfsum.n_fo2  +  wText.nr_fo2    
                      wfsum.n_fo3    = wfsum.n_fo3  +  wText.nr_fo3    
                      wfsum.n_fo4    = wfsum.n_fo4  +  wText.nr_fo4  
                      /* A63-0417 */
                      wfsum.n_gross_nv  = wfsum.n_gross_nv  + wText.nr_osres_nv
                      wfsum.n_gross_v  = wfsum.n_gross_v  + wText.nr_osres_v
                      wfsum.n_fac_nv    = wfsum.n_fac_nv    + wText.nr_facri_nv
                      wfsum.n_treaty_nv = wfsum.n_treaty_nv + wText.nr_treaty_nv
                      wfsum.n_comp_nv   = wfsum.n_comp_nv   + wText.nr_comp_nv 
                      wfsum.n_ret_nv    = wfsum.n_ret_nv    + wText.nr_net_nv 
                      wfsum.n_ced_nv    = wfsum.n_ced_nv  +  wText.nr_ced_nv    
                      wfsum.n_1st_nv    = wfsum.n_1st_nv  +  wText.nr_1st_nv    
                      wfsum.n_2nd_nv    = wfsum.n_2nd_nv  +  wText.nr_2nd_nv    
                      wfsum.n_qs5_nv    = wfsum.n_qs5_nv  +  wText.nr_qs5_nv    
                      wfsum.n_tfp_nv    = wfsum.n_tfp_nv  +  wText.nr_tfp_nv    
                      wfsum.n_mps_nv    = wfsum.n_mps_nv  +  wText.nr_mps_nv    
                      wfsum.n_eng_nv    = wfsum.n_eng_nv  +  wText.nr_eng_nv    
                      wfsum.n_mar_nv    = wfsum.n_mar_nv  +  wText.nr_mar_nv    
                      wfsum.n_rq_nv     = wfsum.n_rq_nv   +  wText.nr_rq_nv    
                      wfsum.n_btr_nv    = wfsum.n_btr_nv  +  wText.nr_btr_nv    
                      wfsum.n_otr_nv    = wfsum.n_otr_nv  +  wText.nr_otr_nv    
                      wfsum.n_ftr_nv    = wfsum.n_ftr_nv  +  wText.nr_ftr_nv    
                      wfsum.n_fo1_nv    = wfsum.n_fo1_nv  +  wText.nr_fo1_nv    
                      wfsum.n_fo2_nv    = wfsum.n_fo2_nv  +  wText.nr_fo2_nv    
                      wfsum.n_fo3_nv    = wfsum.n_fo3_nv  +  wText.nr_fo3_nv    
                      wfsum.n_fo4_nv    = wfsum.n_fo4_nv  +  wText.nr_fo4_nv . 
                END.
               /*--End By Benjaporn J. A59-0613 [14/12/2016]--*/

            END.  /* for each clm120 */
        END.     /* for each czd101 */
    END.

    ELSE ASSIGN nr_name  =   ""      
                nr_loss1 =   ""  . 
 
END.    /* czm100 */              

RUN pdPrnAllMotor1_2_Sum.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdPrnAllMotor1_2_Sum C-Win 
PROCEDURE pdPrnAllMotor1_2_Sum :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*-- Add By Benjaporn J. A59-0613 [14/12/2016] --*/
    nu_output = n_output + "motor.slk".
    OUTPUT STREAM ns2 TO VALUE (nu_output).  /* For Summary Text Output */

    PUT STREAM ns2
    "TOTAL LIST OF OUTSTANDING CLAIM (MOTOR)" SKIP
    "AS AT  " 
    STRING (TODAY,"99/99/9999") FORMAT "X(10)" " "
    STRING(TIME,"HH:MM:SS")    SKIP 
    "RUNNING OF ENTRY DATE FROM : " n_asdat   SKIP .

    PUT STREAM ns2
        "Type"            "|"
        "BRANCH"          "|"
        "LINE"            "|"
        "YEAR"            "|"
        "MONTH"           "|"
        "TRANDATE FROM"   "|"
        "TRANDATE TO"     "|"
        "ENTRYDATE"       "|"
        "GROSS"           "|" 
        "CEDED"           "|"
        "1st.TREATY"      "|"
        "2nd.TREATY"      "|"   
        "FAC"             "|"
        "Q.S.5%"          "|"
        "TFP"             "|"
        "MPS"             "|"
        "ENG.FAC."        "|"
        "MARINE O/P"      "|"
        "R.Q."            "|"
        "BTR"             "|"
        "OTR"             "|"
        "FTR"             "|"
        "F/O I"           "|" 
        "F/O II"          "|"
        "F/O III"         "|"
        "F/O IV"          "|"
        "GROSS RET"       "|"
        /* A63-0417 */
        "GROSS_NETVAT"           "|" 
        "CEDED_NETVAT"           "|"
        "1st.TREATY_NETVAT"      "|"
        "2nd.TREATY_NETVAT"      "|"   
        "FAC_NETVAT"             "|"
        "Q.S.5%_NETVAT"          "|"
        "TFP_NETVAT"             "|"
        "MPS_NETVAT"             "|"
        "ENG.FAC._NETVAT"        "|"
        "MARINE O/P_NETVAT"      "|"
        "R.Q._NETVAT"            "|"
        "BTR_NETVAT"             "|"
        "OTR_NETVAT"             "|"
        "FTR_NETVAT"             "|"
        "F/O I_NETVAT"           "|" 
        "F/O II_NETVAT"          "|"
        "F/O III_NETVAT"         "|"
        "F/O IV_NETVAT"          "|"
        "GROSS RET_NETVAT"       SKIP. 
    
    FOR EACH wfsum NO-LOCK
        BREAK BY wfsum.n_type 
              BY wfsum.n_bran 
              BY wfsum.n_line.
    
        FIND FIRST fnm002 USE-INDEX fnm00201 WHERE
            fnm002.TYPE   = wfsum.n_type    AND 
            fnm002.branch = wfsum.n_bran    AND
            fnm002.poltyp = wfsum.n_line    AND
            fnm002.osyr   = YEAR(nv_datto)  AND
            fnm002.osmth  = MONTH(nv_datto) NO-ERROR.  

        IF AVAIL fnm002 THEN DO :
            ASSIGN 
                fnm002.gross     =  0     
                fnm002.trtamt    =  0    
                fnm002.facamt    =  0    
                fnm002.amt1      =  0 . 

            ASSIGN  
                fnm002.gross     =  wfsum.n_gross
                fnm002.trtamt    =  wfsum.n_treaty
                fnm002.facamt    =  wfsum.n_fac
                fnm002.amt1      =  wfsum.n_comp
                fnm002.entdat    =  TODAY .
        END.

        IF NOT AVAIL fnm002 THEN DO :
        CREATE  fnm002.
        ASSIGN  fnm002.TYPE      =  wfsum.n_type 
                fnm002.branch    =  wfsum.n_bran 
                fnm002.poltyp    =  wfsum.n_line  /*STRING(wfsum.n_line) */
                fnm002.osmth     =  INT(MONTH(nv_datto))
                fnm002.osyr      =  INT(YEAR(nv_datto))
                fnm002.trndatfr  =  nv_datfr 
                fnm002.trndatto  =  nv_datto 
                fnm002.gross     =  wfsum.n_gross
                fnm002.trtamt    =  wfsum.n_treaty
                fnm002.facamt    =  wfsum.n_fac
                fnm002.amt1      =  wfsum.n_comp
                fnm002.entdat    =  TODAY .
        END.
     
        PUT STREAM ns2
             wfsum.n_type                         "|" 
             wfsum.n_bran                         "|" 
             wfsum.n_line                         "|" 
             YEAR(nv_datto)   FORMAT "9999"       "|"
             MONTH(nv_datto)  FORMAT "99"         "|" 
             nv_datfr         FORMAT "99/99/9999" "|"
             nv_datto         FORMAT "99/99/9999" "|"
             TODAY            FORMAT "99/99/9999" "|"
             wfsum.n_gross                        "|" 
             wfsum.n_ced                          "|"
             wfsum.n_1st                          "|"
             wfsum.n_2nd                          "|"
             wfsum.n_fac                          "|"
             wfsum.n_qs5                          "|"
             wfsum.n_tfp                          "|"
             wfsum.n_mps                          "|"
             wfsum.n_eng                          "|"
             wfsum.n_mar                          "|"
             wfsum.n_rq                           "|"
             wfsum.n_btr                          "|"
             wfsum.n_otr                          "|"
             wfsum.n_ftr                          "|"
             wfsum.n_fo1                          "|"
             wfsum.n_fo2                          "|"
             wfsum.n_fo3                          "|"
             wfsum.n_fo4                          "|"
             wfsum.n_ret                          "|"
             /* A63-0417 */
             wfsum.n_gross_nv                     "|" 
             wfsum.n_ced_nv                       "|"
             wfsum.n_1st_nv                       "|"
             wfsum.n_2nd_nv                       "|"
             wfsum.n_fac_nv                       "|"
             wfsum.n_qs5_nv                       "|"
             wfsum.n_tfp_nv                       "|"
             wfsum.n_mps_nv                       "|"
             wfsum.n_eng_nv                       "|"
             wfsum.n_mar_nv                       "|"
             wfsum.n_rq_nv                        "|"
             wfsum.n_btr_nv                       "|"
             wfsum.n_otr_nv                       "|"
             wfsum.n_ftr_nv                       "|"
             wfsum.n_fo1_nv                       "|"
             wfsum.n_fo2_nv                       "|"
             wfsum.n_fo3_nv                       "|"
             wfsum.n_fo4_nv                       "|"
             wfsum.n_ret_nv                       SKIP.
    END.                                     
    
    OUTPUT STREAM ns2 CLOSE.
    RELEASE fnm002.
    
    ASSIGN
        wfsum.n_gross    = 0               wfsum.n_mps  = 0
        wfsum.n_fee      = 0               wfsum.n_eng  = 0
        wfsum.nt_gross   = 0               wfsum.n_mar  = 0
        wfsum.n_fac      = 0               wfsum.n_rq   = 0
        wfsum.n_comp     = 0               wfsum.n_btr  = 0
        wfsum.n_ret      = 0               wfsum.n_otr  = 0
        wfsum.n_ced      = 0               wfsum.n_ftr  = 0
        wfsum.n_1st      = 0               wfsum.n_fo1  = 0
        wfsum.n_2nd      = 0               wfsum.n_fo2  = 0
        wfsum.n_qs5      = 0               wfsum.n_fo3  = 0
        wfsum.n_tfp      = 0               wfsum.n_fo4  = 0  
        /*A63-0417*/
        wfsum.n_gross_nv  = 0              wfsum.n_mps_nv  = 0
        wfsum.n_fee_nv    = 0              wfsum.n_eng_nv  = 0
        wfsum.nt_gross_nv   = 0            wfsum.n_mar_nv  = 0
        wfsum.n_fac_nv   = 0               wfsum.n_rq_nv  = 0
        wfsum.n_comp_nv  = 0               wfsum.n_btr_nv  = 0
        wfsum.n_ret_nv   = 0               wfsum.n_otr_nv  = 0
        wfsum.n_ced_nv   = 0               wfsum.n_ftr_nv  = 0
        wfsum.n_1st_nv   = 0               wfsum.n_fo1_nv  = 0
        wfsum.n_2nd_nv   = 0               wfsum.n_fo2_nv  = 0
        wfsum.n_qs5_nv   = 0               wfsum.n_fo3_nv  = 0
        wfsum.n_tfp_nv   = 0               wfsum.n_fo4_nv  = 0 
        .
    /*---End Benjaporn J. A59-0613 [14/12/2016] --*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdPrnComp C-Win 
PROCEDURE pdPrnComp :
/*------------------------------------------------------------------------------
  Purpose:  Print Report for Motor V70 and Nature = IC, LC, LL, DB   
  Parameters:  <none>
  Notes:       Coutput  = Compulsory File  xxxC.txt
                output2 = Summary File xxxS.txt
------------------------------------------------------------------------------*/
RUN ChkLineExcel.
/*Detail*/
/*---A51-0126
OUTPUT TO VALUE (nv_output) APPEND NO-ECHO. 
---end A51-0126*/

/*----------------By A51-0126  Header-------------*/
OUTPUT TO VALUE (nv_Coutput) APPEND NO-ECHO. 
EXPORT DELIMITER ";"
  "".
EXPORT DELIMITER ";"
  "COMPULSARY (Nature of Loss for Line 70 = IC, LC, LL, DB)"
  "" "" "" "" "" "" "" "" "" "" "" "" 
  "" "" "" "" "" 
  "" "" "" "" "" "" ""  "O/S Claim"
  "" "" "" "" "" "" "Paid Amount".
OUTPUT CLOSE.
nv_reccnt = nv_reccnt + 2.

/*Sum*/
RUN ChkLineExcel2.
OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO. 
EXPORT DELIMITER ";"
  "".
EXPORT DELIMITER ";"
  "COMPULSARY (Nature of Loss for Line 70 = IC, LC, LL, DB)" "" ""
  "" "" "" "" "" "" "" "" ""
  "" "" "" "" "" "" "" "" ""
  "O/S Claim"  
  "" "" "" "" "" ""
  "Paid Amount".
OUTPUT CLOSE.
nv_reccnt2 = nv_reccnt2 + 2.
/*------end Header Summary ---------------------*/
    
FOR EACH wfcpoltyp BREAK BY wfcpoltyp.wfcpbr BY wfcpoltyp.wfctyp:
    n_br = wfcpoltyp.wfcpbr.
    RUN pdbdes.
    /*--Detail--*/
    RUN ChkLineExcel.

    /*---A51-0126
    OUTPUT TO VALUE (nv_output) APPEND NO-ECHO. 
    -----*/
    /*---A51-0126---*/
    /*nb_cnt = nb_cnt + nc_cnt.*/

    OUTPUT TO VALUE (nv_Coutput) APPEND NO-ECHO. 
    EXPORT DELIMITER ";"
       "Total Comp Branch: " + wfcpoltyp.wfctyp + "-" + wfcpoltyp.wfcpbr 
       n_bdes
       ""
       "" "" "" "" "" "" "" "" "" "" ""
       "" "" "" "" "" "" "" "" "" "" ""
       wfcpoltyp.wfcpres
       "" "" "" "" "" ""
       wfcpoltyp.wfcppaid.
    OUTPUT CLOSE.
    nct_cnt = nct_cnt + nc_cnt.
    nv_reccnt = nv_reccnt + 1.

    /*--Sum--*/
    RUN ChkLineExcel2.
    OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO. 
    EXPORT DELIMITER ";"
       "Total Comp Branch: " + wfcpoltyp.wfctyp + "-" + wfcpoltyp.wfcpbr
       n_bdes
       ""
       "" "" "" "" "" "" "" "" ""
       "" "" "" "" "" "" "" "" ""
       wfcpoltyp.wfcpres  
       "" "" "" "" "" ""
       wfcpoltyp.wfcppaid.
    OUTPUT CLOSE.
    nv_reccnt2 = nv_reccnt2 + 1.

    ASSIGN n_cosres = n_cosres + wfcpoltyp.wfcpres
           n_cpaid  = n_cpaid + wfcpoltyp.wfcppaid.
END.

/*---A51-0126
OUTPUT TO VALUE (nv_output) APPEND NO-ECHO. 
---*/
/*---A51-0126---*/
OUTPUT TO VALUE (nv_Coutput) APPEND NO-ECHO. 
RUN ChkLineExcel.
/*Detail*/
EXPORT DELIMITER ";"
   "".
EXPORT DELIMITER ";"
   "Grand Total Compulsary : " "" 
   "" "" "" "" "" "" "" "" "" "" "" 
   ""  "" "" "" "" "" "" "" "" "" "" "" 
   n_cosres  
   "" "" "" "" "" ""
   n_cpaid.
OUTPUT CLOSE.
nv_reccnt = nv_reccnt + 2.
/*Sum*/
RUN ChkLineExcel2.
OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO. 
EXPORT DELIMITER ";"
   "".
EXPORT DELIMITER ";"
   "Grand Total Compulsary : " "" 
    "" "" "" "" "" "" "" "" ""
   "" ""  "" "" "" "" "" "" "" "" 
   n_cosres "" "" "" "" "" ""
   n_cpaid.
OUTPUT CLOSE.
nv_reccnt2 = nv_reccnt2 + 2.

OUTPUT TO VALUE (nv_Coutput) APPEND NO-ECHO.
    EXPORT DELIMITER ";" "".
    EXPORT DELIMITER ";" "Count Claims".
OUTPUT CLOSE.

OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO.
    EXPORT DELIMITER ";" "".
    EXPORT DELIMITER ";" "Count Claims".
OUTPUT CLOSE.

FOR EACH wfcompcnt BREAK BY wfcompcnt_br.
    OUTPUT TO VALUE (nv_Coutput) APPEND NO-ECHO. 
    EXPORT DELIMITER ";"
        "Count Claim Branch: " + wfcompcnt_br
        wfcompcnt_cnt.
    OUTPUT CLOSE.

    OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO. 
    EXPORT DELIMITER ";"
        "Count Claim Branch: " + wfcompcnt_br
        wfcompcnt_cnt.
        OUTPUT CLOSE.
        nct_cnt  = wfcompcnt.wfcompcnt_cnt.
        nctg_cnt = nctg_cnt + nct_cnt.
        nct_cnt  = 0.
END.

OUTPUT TO VALUE (nv_Coutput) APPEND NO-ECHO. 
RUN ChkLineExcel.
/*Detail*/
EXPORT DELIMITER ";"
   "".
EXPORT DELIMITER ";"
   "CountTotal Claim-Compulsary : " 
    nctg_cnt.
OUTPUT CLOSE.

OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO. 
RUN ChkLineExcel.
/*Detail*/
EXPORT DELIMITER ";"
   "".
EXPORT DELIMITER ";"
   "CountTotal Claim-Compulsary : " 
    nctg_cnt.
OUTPUT CLOSE.

ASSIGN  n_cosres  = 0     
        n_cpaid   = 0    
        n_ccnt    = 0  
        nc_cnt    = 0
        nct_cnt   = 0.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdPrnHeaderComp C-Win 
PROCEDURE pdPrnHeaderComp :
/*------------------------------------------------------------------------------
  Purpose:  Print Header For Report Motor (Detail and Summary)   
  Parameters:  <none>
  Notes:        A51-0126 
------------------------------------------------------------------------------*/

/*--- Detail Report ---*/
OUTPUT TO VALUE (nv_Coutput) APPEND NO-ECHO.
EXPORT DELIMITER ";"
            "As of Date:  " 
            n_asdat FORMAT "99/99/9999"
            "" "" ""
            "Safety Insurance Public Company Limited"
            "" "" ""
            STRING(TIME,"HH:MM:SS").
 EXPORT DELIMITER ";"
            "RUNNING OF ENTRY DATE FROM : " nv_datfr FORMAT "99/99/9999" 
            " TO " nv_datto FORMAT "99/99/9999"
            ""
            "LIST OF OUTSTANDING CLAIM - MOTOR <DETAIL> " 
            "Line " + n_poltyp
            "(SYS : WACROSCL.W)"  
            "" "".
 EXPORT DELIMITER ";"
            "Count"
            "BRANCH"       
            "Policy Type"    
            "Policy Desc"
            "Group"             
            "Claim No." 
            "Notify No."
            "Policy No."
            "License"
            "Insure Name"
            "Producer Code"
            "Producer Name"
            "Comm. Date"
            "Expiry Date"
            "Renew Policy"
            "Cover Type"
            "Default By"
            "Cause of Loss"
            "Nature of Loss"
            "Clmant"
            "Clitem"
            "Entry Date"
            "Loss Date"         
            "Notify Date"
            "Open Date"        
            "O/S Claim"
            "Fac RI."
            "RET."
            "Text Code N."
            "Nature Comment"
            "Text Code Claim"  
            "Claim Comment"
            "Paid Amount"
            "Paid Date"
            "Accept By" 
            "Internal Surveyor"
            "External Code"       /*A51-0102*/
            "External Surveyor"
            "Ceding Claim No."
            "Document Status".
 OUTPUT CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdPrnHeaderMotor C-Win 
PROCEDURE pdPrnHeaderMotor :
/*------------------------------------------------------------------------------
  Purpose:  Print Header For Report Motor (Detail and Summary)   
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*--- Detail Report ---*/
OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
EXPORT DELIMITER ";"
            "As of Date:  " 
            n_asdat FORMAT "99/99/9999"
            "" "" ""
            "Safety Insurance Public Company Limited"
            "" "" ""
            STRING(TIME,"HH:MM:SS").
 EXPORT DELIMITER ";"
            "RUNNING OF ENTRY DATE FROM : " nv_datfr FORMAT "99/99/9999" 
            " TO " nv_datto FORMAT "99/99/9999"
            ""
            "LIST OF OUTSTANDING CLAIM - MOTOR <DETAIL> " 
            "Line " + n_poltyp
            "(SYS : WACROSCL.W)"  
            "" "".
 EXPORT DELIMITER ";"
            "Count"
            "BRANCH"       
            "Policy Type"    
            "Policy Desc"
            "Group"             
            "Claim No." 
            "Notify No."
            "Policy No."
            "License"
            "Insure Name"
            "Producer Code"
            "Producer Name"
            "Comm. Date"
            "Expiry Date"
            "Renew Policy"
            "Cover Type"
            "Default By"
            "Cause of Loss"
            "Nature of Loss"
            "Clmant"
            "Clitem"
            "Entry Date"
            "Loss Date"         
            "Notify Date"
            "Open Date"        
            "O/S Claim"
            "Survey Fee"    /*Lukkana M. A53-0139 30/08/2010*/
            "Total Gross"   /*Lukkana M. A53-0139 30/08/2010*/
            "Fac RI."
            "RET."
            "Text Code N."
            "Nature Comment"
            "Text Code Claim"  
            "Claim Comment"
            "Paid Amount"
            "Paid Date"
            "Accept By" 
            "Internal Surveyor"
            "External Code"       /*A51-0102*/
            "External Surveyor"
            "Ceding Claim No."
            "Document Status".
 OUTPUT CLOSE.

 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdPrnHeaderMotorS C-Win 
PROCEDURE pdPrnHeaderMotorS :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*--- Summary Report ---*/
 OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO.
 EXPORT DELIMITER ";"
            "As of Date:  " 
            n_asdat FORMAT "99/99/9999"
            "" "" ""
            "Safety Insurance Public Company Limited"
            "" "" ""
            STRING(TIME,"HH:MM:SS").
 EXPORT DELIMITER ";"
            "<SUMMARY>"
            "LIST OF OUTSTANDING CLAIM - MOTOR"
            "Line " + n_poltyp
            "(SYS : WACROSCL.W)"  
            "" ""
            "RUNNING OF ENTRY DATE FROM : " nv_datfr FORMAT "99/99/9999" 
            " TO " nv_datto FORMAT "99/99/9999".
 EXPORT DELIMITER ";"
            "BRANCH"       
            "Policy Type"    
            "Policy Desc"
            "Group"             
            "Claim No." 
            "Notify No."
            "Policy No."
            "License"
            "Insure Name"
            "Producer Code"
            "Producer Name"
            "Comm. Date"
            "Expiry Date"
            "Renew Policy"
            "Cover Type"
            "Default By"
            "Cause of Loss"
            "Entry Date"
            "Loss Date"         
            "Notify Date"
            "Open Date"        
            "O/S Claim"
            "Survey Fee"    /*Lukkana M. A53-0139 30/08/2010*/
            "Total Gross"   /*Lukkana M. A53-0139 30/08/2010*/ 
            "Fac RI."
            "RET."
            "Text Code N."
            "Nature Comment"
            "Text Code Claim"  
            "Claim Comment"
            "Paid Amount"
            "Accept By" 
            "Internal Surveyor"
            "External Surveyor"
            "Ceding Claim No."
            "Document Status".
 OUTPUT CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdPrnHeaderNon C-Win 
PROCEDURE pdPrnHeaderNon :
/*------------------------------------------------------------------------------
  Purpose:  check Non motor Report and Print Header for Non Motor    
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF non_poltyp = 5 THEN n_txt = "NOT 30, 01, 04".
ELSE IF non_poltyp = 6 THEN n_txt = "ONLY 30, 01, 04".
ELSE IF non_poltyp = 7 THEN n_txt = "All".

 OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
 EXPORT DELIMITER ";"
        "As of Date:  " 
        n_asdat FORMAT "99/99/9999"
        "" "" ""
        "Safety Insurance Public Company Limited"
        "" "" ""
        STRING(TIME,"HH:MM:SS").

 EXPORT DELIMITER ";"
        "RUNNING OF ENTRY DATE FROM : " nv_datfr FORMAT "99/99/9999" 
        " TO " nv_datto FORMAT "99/99/9999"
        ""
        "LIST OF OUTSTANDING CLAIM - NON MOTOR " 
        n_txt 
        "(SYS : WACROSCL.W)". 

 EXPORT DELIMITER ";"
        "BRANCH"       
        "Line"    
        "Type" 
        "Group"             
        "Claim No."    
        "Entry Date"        
        "Notify Date"       
        "Loss Date"         
        "Open Date"         
        "Policy No."
        "Insure Name"  
        "Nature of Loss" 
        "O/S Claim"  
        "Survey Fee"    /*Lukkana M. A53-0139 30/08/2010*/
        "Total Gross"   /*Lukkana M. A53-0139 30/08/2010*/
        "1st.TREATY"   
        "2nd.TREATY"      
        "FAC.RI."      
        "Q.S.5%"       
        "TFP"          
        "MPS" 
        "ENG.FAC."     
        "MARINE O/P"   
        "R.Q."         
        "BTR"          
        "OTR"          
        "FTR"
        "F/O I"        
        "F/O II"       
        "F/O III"      
        "F/O IV"
        "GROSS RET."   
        "XOL"          
        "CO%"          
        "CO SI"        
        "Adjustor"   
        "Int. Surveyor Name" 
        "Ext. Surveyor Name" 
        "Producer Name"
        "Ceding Claim no."   
        "Text code Claim"  
        "Claim comment "
        "Document Status".
 OUTPUT CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PdPrnMotor C-Win 
PROCEDURE PdPrnMotor :
/*------------------------------------------------------------------------------
  Purpose:  Print Report for Motor   
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wfpoltyp NO-LOCK:
    DELETE wfpoltyp.
END.
FOR EACH wfbranch NO-LOCK:
    DELETE wfbranch.
END.
FOR EACH wftbranch NO-LOCK:
    DELETE wftbranch.
END.
FOR EACH wfcpoltyp NO-LOCK:
    DELETE wfcpoltyp.
END.
FOR EACH wfcbranch NO-LOCK:
    DELETE wfcbranch.
END.
FOR EACH wfctbranch NO-LOCK:
    DELETE wfctbranch.
END.
FOR EACH wfcnt NO-LOCK:
    DELETE wfcnt.
END.
DEF VAR nv_amt19  AS DECI. /*Lukkana M. A53-0139 03/09/2010*/
DEF VAR nv_amt20  AS DECI. /*Lukkana M. A53-0139 03/09/2010*/

ASSIGN nv_reccnt = 0       nv_reccnt2 = 0
       nv_next   = 1       nv_next2   = 1
       wt_cnt    = 0       wg_cnt     = 0.

loop_czm100:
  FOR EACH czm100  USE-INDEX czm10002 WHERE 
           czm100.ASDAT = n_asdat     AND 
           czm100.BRANCH >= nv_branfr AND
           czm100.BRANCH <= nv_branto AND 
           SUBSTR(czm100.POLTYP,2,2) = poltyp NO-LOCK
  BREAK BY czm100.BRANCH                   BY SUBSTR(czm100.POLTYP,2,2)
        BY SUBSTR(czm100.CLAIM,1,1)        BY czm100.CLAIM : 

        DISP czm100.claim WITH NO-LABEL TITLE "Printing Report..."
        FRAME a VIEW-AS DIALOG-BOX.
        
        RUN pdfindRenpol.   /*Find RenPol*/
        RUN pdfindCovcod.   /*Find CovCod*/ 
        
        IF FIRST-OF (czm100.BRANCH) THEN DO:
           wt_cnt = 0.
           nv_nbran = czm100.BRANCH.
           RUN pd_nbran.
        END.

        IF FIRST-OF (SUBSTRING (czm100.poltyp,2,2)) THEN DO:
           FIND Xmm031 USE-INDEX Xmm03101 WHERE 
                Xmm031.poltyp = czm100.POLTYP NO-LOCK NO-ERROR.
           nv_ntype = IF AVAILABLE Xmm031 THEN Xmm031.poldes
                      ELSE "!!! Not found (" + TRIM (czm100.POLTYP) + ")".
        END. /*--- FIRST-OF (czm100.poltyp) ---*/
       
        IF czm100.POLTYP  = " " THEN NEXT loop_czm100.
       
        FIND XMM031 USE-INDEX XMM03101 WHERE 
             XMM031.POLTYP = czm100.POLTYP NO-LOCK NO-ERROR.
             nv_poldes = IF AVAILABLE XMM031 THEN XMM031.POLDES
                         ELSE "!!! Not found (" + TRIM (czm100.POLTYP) + ")".

        FIND Xmm600 USE-INDEX Xmm60001 WHERE
             Xmm600.acno = czm100.INTREF NO-LOCK NO-ERROR NO-WAIT.

        IF AVAILABLE xmm600 THEN 
           ASSIGN nv_adjust  = TRIM(Xmm600.ntitle) + TRIM(Xmm600.name)
                  nv_adjusna = TRIM(TRIM(Xmm600.ntitle) + TRIM(Xmm600.name)).  

        ELSE ASSIGN  nv_adjust  = ""
                     nv_adjusna = "".

        RUN pdFindACNO.
        
        IF n_ostyp = 1 THEN DO:
           IF czm100.OS <= 0 THEN NEXT loop_czm100.
        END.
        ELSE DO:
            IF czm100.OS < 0 THEN NEXT loop_czm100. /*Lukkana M. A53-0139 03/09/2010 OS ติดลบไม่ต้องแสดงออกมา*/
        END.
        
        FOR EACH czd101 USE-INDEX czd10101  WHERE
                 czd101.asdat = czm100.asdat AND
                 czd101.claim = czm100.claim NO-LOCK
        BREAK BY SUBSTR(czd101.claim,1,1) BY SUBSTR(czd101.claim,2,1)
              BY SUBSTR(czd101.claim,3,2) BY czd101.claim:

             /*---
             IF czd101.osres = 0 THEN NEXT loop_czm100.    /* A51-0102 */
             Lukkana M. A53-0139 21/07/2010--*/

             nv_br1 = "".
             IF SUBSTR(czd101.claim,1,2) >= "10" AND
                SUBSTR(czd101.claim,1,2) <= "99" THEN nv_br1 = SUBSTR(czd101.claim,1,2).
             ELSE nv_br1 = SUBSTR(czd101.claim,2,1).
             /*--Lukkana M. A53-0139 21/07/2010--*/

             RUN pdItemCode.     /*Find ItemCode*/

             /* A51-0102 */
             RUN pdfindLoss.     /*Find Nature of Loss*/  

             //IF n_loss <> 'FE'  AND n_loss  <>  'EX' THEN IF czd101.osres = 0 THEN NEXT .   /*-Lukkana M. A53-0139 21/07/2010--*/ --A664-0383---
             FIND FIRST sym100 USE-INDEX sym10001 WHERE
               sym100.tabcod = "CMLO"         AND
               sym100.itmcod = n_loss NO-LOCK NO-ERROR.  /*Nature FE EX FV*/
             IF NOT AVAIL sym100 THEN IF czd101.osres  = 0 THEN NEXT .    /*A64-0383*/
             
            /*-------72,73,74 Nature ต้องเป็น DB,IC,LC,LL,SF เท่านั้น -------*/
             IF LOOKUP(SUBSTR(czd101.claim,3,2),"72,73,74") <> 0  THEN DO:
                IF LOOKUP(n_loss,"DB,IC,LC,LL,SF") = 0 THEN DO:
                   IF czd101.osres <= 0 THEN NEXT.
                END.
             END.
             /*----end A51-0102------*/
             
             IF FIRST-OF (czd101.claim) THEN DO: 
                 ASSIGN wt_cnt  =  wt_cnt + 1   /*Claim Count*/
                        wg_cnt  =  wg_cnt + 1.  /*Grand Claim Count*/
                 
                 /*---A51-0126---*/
                 IF SUBSTR(czd101.claim,3,2) = "70" AND cnt_comp = YES THEN DO:
                    ASSIGN nc_cnt = nc_cnt + 1.
                    
                 /*FIND FIRST wfcompcnt WHERE wfcompcnt.wfcompcnt_br = SUBSTR(czd101.claim,2,1) NO-ERROR. Lukkana M. A53-0139 22/07/2010*/
                   FIND FIRST wfcompcnt WHERE wfcompcnt.wfcompcnt_br = nv_br1 NO-ERROR. /*-Lukkana M. A53-0139 22/07/2010*/
                   IF NOT AVAIL wfcompcnt THEN DO:
                      CREATE wfcompcnt.
                      /*ASSIGN wfcompcnt.wfcompcnt_br = SUBSTR(czd101.claim,2,1). Lukkana M. A53-0139 22/07/2010*/
                      ASSIGN wfcompcnt.wfcompcnt_br = nv_br1 . /*Lukkana M. A53-0139 22/07/2010*/
                   END.
                   ASSIGN wfcompcnt.wfcompcnt_cnt = wfcompcnt.wfcompcnt_cnt + 1
                          wfcompcnt.wfcompcnt_res = wfcompcnt.wfcompcnt_res + czd101.osres
                          wfcompcnt.wfcompcnt_paid = wfcompcnt.wfcompcnt_paid + czd101.paidamt.
                   
                 END.
                    cnt_comp = NO.
                 /*------------*/
                 /*Lukkana M. A53-0139 03/09/2010*/
                 //IF n_loss <> 'FE'  AND n_loss  <>  'EX' THEN   --A664-0383---
                  FIND FIRST sym100 USE-INDEX sym10001 WHERE
                     sym100.tabcod = "CMLO"         AND
                     sym100.itmcod = n_loss NO-LOCK NO-ERROR.  /*Nature FE EX FV*/
                  IF NOT AVAIL sym100 THEN     /*A64-0383*/
                     ASSIGN  nv_amt19  = 0
                             nv_amt20  = czd101.osres .
                 ELSE ASSIGN nv_amt19  = czm100.amt[19] 
                             nv_amt20  = czm100.amt[19].
                 /*Lukkana M. A53-0139 03/09/2010*/

                 RUN ChkLineExcel.
                 OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
                 EXPORT DELIMITER ";"
                     wt_cnt
                     czm100.Branch    czm100.POLTYP    nv_poldes
                     czm100.GRPTYP    czm100.CLAIM     nv_event
                     czm100.POLICY    
                     /*---
                     czm100.VEHREG
                     comment by Chaiyong W. A54-0112 12/12/2012*/
                     czm100.VEHREG FORMAT "X(11)" /*---add by Chaiyong W. A54-0112 12/12/2012*/   
                     nv_insurnam      nv_pdcode        nv_pdname 
                     nv_comdat        nv_expdat        nv_renpol
                     nv_covcod        nv_defau         nv_loss1
                     /*czm100.LOSS---A51-0102---*/
                     n_loss           czd101.clmant    czd101.clitem 
                     czm100.ENTDAT    czm100.LOSDAT    czm100.NOTDAT  
                     czm100.ENTDAT    czd101.osres     
                     nv_AMT19         nv_AMT20   /*Lukkana M. A53-0139 30/08/2010*/
                     ""               ""               nv_nacod
                     nv_nades         nv_pacod         nv_pades
                     czd101.paidamt   czd101.paiddat   nv_police  
                     nv_adjusna       nv_extcod        nv_extnam        
                     nv_cedclm        czm100.DOCST. 
                 OUTPUT CLOSE.
                 nv_reccnt = nv_reccnt + 1.

                 /*--- By Branch ---*/
                 /*FIND FIRST wfcnt WHERE wfcnt.cntbranch = SUBSTR(czd101.claim,2,1) NO-ERROR. Lukkana M. A53-0139 22/07/2010*/
                 FIND FIRST wfcnt WHERE wfcnt.cntbranch = nv_br1 NO-ERROR. /*Lukkana M. A53-0139 22/07/2010*/
                 IF NOT AVAIL wfcnt THEN DO: 
                    CREATE wfcnt.
                    /*ASSIGN  wfcnt.cntbranch = SUBSTR(czd101.claim,2,1). Lukkana M. A53-0139 22/07/2010*/
                    ASSIGN  wfcnt.cntbranch = nv_br1. /*Lukkana M. A53-0139 22/07/2010*/
                 END.
                 ASSIGN  wfcnt.reccnt    = wfcnt.reccnt + 1.
                 /*----------------*/
                    

              END.    /*First-of czd101.claim for count record*/
              ELSE DO:
                 /*Lukkana M. A53-0139 03/09/2010*/
                // IF n_loss <> 'FE'  AND n_loss  <>  'EX' THEN  --A664-0383---
                  FIND FIRST sym100 USE-INDEX sym10001 WHERE
                     sym100.tabcod = "CMLO"         AND
                     sym100.itmcod = n_loss NO-LOCK NO-ERROR.  /*Nature FE EX FV*/
                  IF NOT AVAIL sym100 THEN    /*A64-0383*/
                     ASSIGN  nv_amt19  = 0
                             nv_amt20  = czd101.osres .
                 ELSE ASSIGN nv_amt19  = czm100.amt[19] 
                             nv_amt20  = czm100.amt[19].
                 /*Lukkana M. A53-0139 03/09/2010*/

                 RUN ChkLineExcel.
                 OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
                 EXPORT DELIMITER ";"
                     "" 
                     czm100.Branch    czm100.POLTYP    nv_poldes
                     czm100.GRPTYP    czm100.CLAIM     nv_event
                     czm100.POLICY    
                     /*---
                     czm100.VEHREG
                     comment by Chaiyong W. A54-0112 12/12/2012*/
                     czm100.VEHREG FORMAT "X(11)" /*---add by Chaiyong W. A54-0112 12/12/2012*/
                        
                     nv_insurnam      nv_pdcode        nv_pdname 
                     nv_comdat        nv_expdat        nv_renpol
                     nv_covcod        nv_defau         nv_loss1
                     /*czm100.LOSS  ---A51-0102---*/
                     n_loss           czd101.clmant    czd101.clitem 
                     czm100.ENTDAT    czm100.LOSDAT    czm100.NOTDAT  
                     czm100.ENTDAT    czd101.osres     
                     nv_AMT19         nv_AMT20   /*Lukkana M. A53-0139 30/08/2010*/
                     ""               ""               nv_nacod
                     nv_nades         nv_pacod         nv_pades
                     czd101.paidamt   czd101.paiddat   nv_police  
                     nv_adjusna       nv_extcod        nv_extnam        
                     nv_cedclm        czm100.DOCST. 
                 OUTPUT CLOSE.
                 nv_reccnt = nv_reccnt + 1.
              END. /*else do:*/
             

              CREATE wfpoltyp.    
              ASSIGN /*wfpoltyp.wfpbr = SUBSTR(czd101.claim,2,1) Lukkana M. A53-0139 22/07/2010*/
                     wfpoltyp.wfpbr   = nv_br1 /*Lukkana M. A53-0139 22/07/2010*/
                     wfpoltyp.wftyp   = SUBSTR(czd101.claim,1,1)
                     wfpoltyp.wfline  = SUBSTR(czd101.claim,3,2)
                     wfpoltyp.wfpres  = wfpoltyp.wfpres + czd101.osres
                     wfpoltyp.wfppaid = wfpoltyp.wfppaid + czd101.paidamt.
              
              ASSIGN nv_sumos   = nv_sumos + czd101.osres
                     nv_sumpaid = nv_sumpaid + czd101.paidamt.
              
        END. /*Each czd101*/

        IF LAST-OF (czm100.branch) THEN DO:
           wt_cnt = 0.
        END.

        RUN pdPrnSMotor.

        RUN pdClrValue.
  END. /* Each czm100 */
  
  /*--Detail--*/  
  RUN ChkLineExcel.
  OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
  EXPORT DELIMITER ";" "".
  EXPORT DELIMITER ";"
        "Total By D/I" 
        "" "" "" "" "" "" "" "" "" "" "" ""
        "" "" "" "" "" "" "" "" "" "" "" ""  
        "O/S Claim" "" "" "" "" "" "" "" "" 
        "Paid Amount".
  OUTPUT CLOSE.
  nv_reccnt = nv_reccnt + 2.
  /*--Sum--*/
  RUN ChkLineExcel2.
  OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO.
  EXPORT DELIMITER ";" "".
  EXPORT DELIMITER ";"
        "Total By D/I" 
        "" "" "" "" "" "" "" "" "" "" 
        "" "" "" "" "" "" "" "" "" "" 
        "O/S Claim" "" "" "" "" "" "" "" ""
        "Paid Amount".
  OUTPUT CLOSE. 
  nv_reccnt2 = nv_reccnt2 + 2.

  FOR EACH wfpoltyp BREAK BY wfpoltyp.wftyp BY wfpoltyp.wfpbr  BY wfpoltyp.wfline :
       /*--Detail--*/
       ASSIGN n_os = n_os + wfpoltyp.wfpres
              n_paid = n_paid + wfpoltyp.wfppaid.

      /* IF LAST-OF (wfpoltyp.wftyp)  THEN DO:*/
       IF LAST-OF (wfpoltyp.wfline)  THEN DO:
          n_br = wfpoltyp.wfpbr.
          RUN pdbdes.
          RUN ChkLineExcel.
          OUTPUT TO VALUE (nv_output) APPEND NO-ECHO. 
          EXPORT DELIMITER ";"
              ""
              wfpoltyp.wftyp + " - " + wfpoltyp.wfpbr + " - " + wfpoltyp.wfline
              n_bdes "" "" "" "" "" "" "" "" "" ""
              "" "" "" "" "" "" "" "" "" "" "" ""
              n_os  "" "" "" "" "" "" "" ""
              n_paid.
          OUTPUT CLOSE.
          nv_reccnt = nv_reccnt + 1.
          /*--Sum--*/
          RUN ChkLineExcel2.
          OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO. 
          EXPORT DELIMITER ";"
              "" 
              wfpoltyp.wftyp + " - " + wfpoltyp.wfpbr + " - " + wfpoltyp.wfline
              n_bdes "" "" "" "" "" "" "" "" "" 
              "" "" "" "" "" "" "" "" ""
              n_os  "" "" "" "" "" "" "" ""
              n_paid.
          OUTPUT CLOSE.
          nv_reccnt2 = + nv_reccnt2 + 1.
          
          ASSIGN n_bosres = n_bosres + n_os
                 n_bpaid  = n_bpaid + n_paid
                 n_os     = 0
                 n_paid   = 0.
       END.

       IF LAST-OF (wfpoltyp.wfline) THEN DO:
           CREATE wfbranch.
           ASSIGN wfbranch.wfbr = wfpoltyp.wfpbr
                  wfbranch.wfbline = wfpoltyp.wfline
                  wfbranch.wfbres =  n_bosres
                  wfbranch.wfbpaid = n_bpaid
                  n_bosres = 0
                  n_bpaid  = 0.
       END.

  END.

  FOR EACH wfbranch BREAK BY wfbranch.wfbr BY wfbranch.wfbline:

    ASSIGN n_tosres = n_tosres + wfbranch.wfbres
           n_tpaid  = n_tpaid + wfbranch.wfbpaid. 

    IF LAST-OF (wfbranch.wfbr) THEN DO:
       CREATE wftbranch.
       ASSIGN wftbranch.wftbr = wfbranch.wfbr
              wftbranch.wftbres = n_tosres
              wftbranch.wftbpaid = n_tpaid
              n_tosres = 0
              n_tpaid = 0. 
    END.
  END.
  
  /*--Detail--*/ 
  RUN ChkLineExcel.
  OUTPUT TO VALUE (nv_output) APPEND NO-ECHO. 
  EXPORT DELIMITER ";"
      "".
  EXPORT DELIMITER ";"
  "Total By Branch" "" "" "" "" "" "" "" "" ""
  "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" 
  "O/S Claim" "" "" "" "" "" "" "" "" 
  "Paid Amount".
  OUTPUT CLOSE.
  nv_reccnt = nv_reccnt + 2.
  /*--Sum--*/
  RUN ChkLineExcel2.
  OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO. 
  EXPORT DELIMITER ";"
      "".
  EXPORT DELIMITER ";"
  "Total By Branch" ""
  "" "" "" "" "" "" "" "" "" ""  
  "" "" "" "" "" "" "" "" ""
  "O/S Claim" "" "" "" "" "" "" "" ""
  "Paid Amount".
  OUTPUT CLOSE.
  nv_reccnt2 = nv_reccnt2 + 2.

  FOR EACH wftbranch BREAK BY wftbranch.wftbr:
      n_br = wftbranch.wftbr.
      RUN pdbdes.
      /*--Detail--*/
      RUN ChkLineExcel.
      OUTPUT TO VALUE (nv_output) APPEND NO-ECHO. 
      EXPORT DELIMITER ";"
        "" 
        "Total Branch: " + wftbranch.wftbr  
        n_bdes "" "" "" "" "" "" "" "" "" ""
        "" "" "" "" "" "" "" "" "" "" "" ""
        wftbranch.wftbres "" "" "" "" "" "" "" "" 
        wftbranch.wftbpaid.
      OUTPUT CLOSE.
      nv_reccnt = nv_reccnt + 1.
      /*--Sum--*/
      RUN ChkLineExcel2.
      OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO. 
      EXPORT DELIMITER ";"
        "" 
        "Total Branch: " + wftbranch.wftbr 
        n_bdes "" "" "" "" "" "" "" "" ""  
        "" "" "" "" "" "" "" "" ""
        wftbranch.wftbres "" "" "" "" "" "" "" ""
        wftbranch.wftbpaid.
      OUTPUT CLOSE.
      nv_reccnt2 = nv_reccnt2 + 1.
      ASSIGN n_gosres = n_gosres + wftbranch.wftbres
             n_gpaid  = n_gpaid  + wftbranch.wftbpaid.
  END.
  /*--Detail--*/
  RUN ChkLineExcel.
  OUTPUT TO VALUE (nv_output) APPEND NO-ECHO. 
  EXPORT DELIMITER ";"
    "".
  EXPORT DELIMITER ";"
    "GrandTotal By Branch" "" ""
    "" "" "" "" "" "" "" "" "" "" ""
    "" "" "" "" "" "" "" "" "" "" "" 
    n_gosres "" "" "" "" "" "" "" ""
    n_gpaid.
  OUTPUT CLOSE.
  nv_reccnt = nv_reccnt + 2.
  /*--Sum--*/
  RUN ChkLineExcel2.
  OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO. 
  EXPORT DELIMITER ";"
    "".
  EXPORT DELIMITER ";"
    "GrandTotal By Branch" 
    "" "" "" "" "" "" "" "" "" ""
    "" "" "" "" "" "" "" "" "" ""
    n_gosres "" "" "" "" "" "" "" "" 
    n_gpaid.
  OUTPUT CLOSE.
  nv_reccnt2 = nv_reccnt2 + 2.

  ASSIGN n_gosres = 0
         n_gpaid  = 0.
  /*Detail*/
  RUN ChkLineExcel.
  OUTPUT TO VALUE (nv_output) APPEND NO-ECHO. 
  EXPORT DELIMITER ";"
    "".
  EXPORT DELIMITER ";" 
    "Count By Branch:" "" 
    "Count Claim".
    OUTPUT CLOSE.
  nv_reccnt = nv_reccnt + 2.
  /*Summary*/
  RUN ChkLineExcel2.
  OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO. 
  EXPORT DELIMITER ";"
    "".
  EXPORT DELIMITER ";" 
    "Count By Branch:" ""
    "Count Claim".
    OUTPUT CLOSE.
  nv_reccnt2 = nv_reccnt2 + 2.

  FOR EACH wfcnt NO-LOCK:
      n_br = wfcnt.cntbranch.
      RUN pdbdes.
      /*Detail*/
      RUN ChkLineExcel.
      OUTPUT TO VALUE (nv_output) APPEND NO-ECHO. 
      EXPORT DELIMITER ";"
        "Branch: " + wfcnt.cntbranch 
        n_bdes
        wfcnt.reccnt.
      OUTPUT CLOSE.
      nv_reccnt = nv_reccnt + 1.
      /*Summary*/
      RUN ChkLineExcel2.
      OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO. 
      EXPORT DELIMITER ";"
        "Branch: " + wfcnt.cntbranch 
        n_bdes
        wfcnt.reccnt.
      OUTPUT CLOSE.
      nv_reccnt2 = nv_reccnt2 + 1.
  END.
  /*Detail*/
  RUN ChkLineExcel.
  OUTPUT TO VALUE (nv_output) APPEND NO-ECHO. 
  EXPORT DELIMITER ";" 
    "Total Claim: " "" 
    wg_cnt.
  OUTPUT CLOSE.
  nv_reccnt = nv_reccnt + 1.
  /*Summary*/
  RUN ChkLineExcel2.
  OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO. 
  EXPORT DELIMITER ";" 
    "Total Claim: " "" 
    wg_cnt.
  OUTPUT CLOSE.
  nv_reccnt2 = nv_reccnt2 + 1.

RUN pdPrnComp.
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdPrnMotor1 C-Win 
PROCEDURE pdPrnMotor1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wText. 
    DELETE wText.
END.
FOR EACH wText2. 
    DELETE wText2.
END.
FOR EACH czm100  USE-INDEX czm10002  WHERE 
    czm100.ASDAT               = n_asdat   AND 
    czm100.BRANCH             >= nv_branfr AND
    czm100.BRANCH             <= nv_branto AND 
    czm100.POLTYP              = "V" + poltyp     NO-LOCK
    BREAK BY czm100.BRANCH                   
          BY SUBSTR(czm100.POLTYP,2,2)
          BY SUBSTR(czm100.CLAIM,1,1)       
          BY czm100.CLAIM : 

    DISP czm100.claim WITH NO-LABEL TITLE "Printing Report..."  FRAME a VIEW-AS DIALOG-BOX.
    RUN pdClearValue.
    
    IF ( n_ostyp = 1 ) AND ( czm100.OS <= 0 )  THEN  NEXT.  /*"O/S Claim > 0"*/ 
    ELSE  IF czm100.OS < 0 THEN NEXT .

    IF (czm100.POLTYP = "V70") AND ((TRIM(STRING(czm100.LOSS)) = "IC" ) OR   
       (TRIM(STRING(czm100.LOSS)) = "LC" ) OR (TRIM(STRING(czm100.LOSS)) = "LL" ) OR    
       (TRIM(STRING(czm100.LOSS)) = "DB" )) THEN ASSIGN nr_type = "V71".
    ELSE ASSIGN nr_type = czm100.POLTYP .   /* line71 ( IC,LC,LL,DB )*/

    FIND LAST  wText2 WHERE  wText2.nr_branch = czm100.BRANCH NO-ERROR NO-WAIT.
    IF NOT AVAIL wText2 THEN DO:
        CREATE wText2.
        ASSIGN wText2.nr_branch   = czm100.BRANCH.
        FIND LAST  xmm023  USE-INDEX xmm02301    WHERE xmm023.branch   =  czm100.BRANCH  NO-LOCK NO-ERROR NO-WAIT.
        IF  AVAIL  xmm023 THEN ASSIGN  wText2.nr_branchdsp  =  trim(xmm023.bdes) .
        ELSE ASSIGN  wText2.nr_branchdsp  = "" .
    END.
    FIND LAST clm100 USE-INDEX clm10001 WHERE  CLM100.CLAIM = czm100.CLAIM   NO-LOCK NO-ERROR.
    IF AVAIL clm100 THEN DO:
        ASSIGN 
            nr_agent  = clm100.agent
            nr_cedclm = clm100.cedclm
            nr_name   = TRIM(clm100.ntitle) + " " + TRIM(clm100.name1)    
            nr_loss1  = TRIM(clm100.loss1)  + " " + TRIM(clm100.loss2) + " " + TRIM(clm100.loss3)  .
        FIND LAST  clm120 USE-INDEX clm12001     WHERE clm120.claim  = clm100.claim  NO-LOCK NO-ERROR.
        IF AVAIL clm120 THEN DO:
            ASSIGN  nr_extref =   clm120.extref.
            FIND FIRST czd101 USE-INDEX czd10101      WHERE
                       czd101.asdat  = n_asdat        AND      /*Add A57-0343*/
                       czd101.claim  = clm100.claim   AND
                       czd101.clmant = clm120.clmant  AND 
                       czd101.clitem = clm120.clitem  NO-LOCK NO-ERROR.
            IF   AVAIL czd101 THEN DO:
                ASSIGN  
                    nr_clmant_itm = string(czd101.clmant,"999") + "/" + string(czd101.clitem,"999") . 
                    /*nr_osres      = czd101.osres*/  
            END.

            FIND xtm600 USE-INDEX xtm60001 WHERE xtm600.acno = clm120.intref NO-LOCK NO-ERROR.
            IF AVAIL xtm600 THEN  nr_adjust = xtm600.name.
            ELSE ASSIGN nr_adjust = "".
        END.
        FIND FIRST sym100 USE-INDEX sym10001 WHERE
            sym100.tabcod = "U070"    AND
            sym100.itmcod = clm100.busreg NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sym100 THEN   ASSIGN nr_pades  = sym100.itmdes.
        ELSE ASSIGN nr_pades  = "".
       
    END.
    ELSE ASSIGN nr_name  =   ""      
                nr_loss1 =   ""  . 

    CREATE wText.
    ASSIGN 
        wText.nr_line       = nr_type   /*czm100.POLTYP  */
        wText.nr_branch     = czm100.BRANCH
        wText.nr_CLAIM      = czm100.CLAIM       
        wText.nr_entdat     = STRING(czm100.ENTDAT,"99/99/9999")     
        wText.nr_notdat     = STRING(czm100.NOTDAT,"99/99/9999")   
        wText.nr_LOSDAT     = STRING(czm100.LOSDAT,"99/99/9999") 
        wText.nr_POLICY     = TRIM(czm100.POLICY)
        wText.nr_name       = nr_name 
        wText.nr_LOSS       = STRING(czm100.LOSS)   
        wText.nr_loss1      = nr_loss1     
        wText.nr_clmant_itm = nr_clmant_itm 
        wText.nr_osres      = czd101.osres 
        wText.nr_facri      = czm100.AMT[3] 
        wText.nr_adjust     = nr_adjust              
        wText.nr_intref     = czm100.intref 
        wText.nr_extref     = nr_extref   
        wText.nr_agent      = nr_agent    
        wText.nr_cedclm     = nr_cedclm    
        wText.nr_DOCST      = czm100.DOCST            
        wText.nr_pades      = nr_pades   .
      
          IF SUBSTR(wText.nr_CLAIM,1,1) = "D" OR 
             SUBSTR(wText.nr_CLAIM,1,1) = "I" THEN DO:
             ASSIGN ntype = SUBSTR(wText.nr_CLAIM,1,1).
          END.
          ELSE DO:
              ASSIGN ntype = "D" .
          END.
          /*  Benjaporn J. A59-0613 [14/12/2016]  */
          FIND FIRST wfsum WHERE wfsum.n_type = ntype            AND
                                 wfsum.n_bran = wText.nr_branch  AND
                                 wfsum.n_line = SUBSTR(wText.nr_POLICY,3,2) NO-ERROR.
          IF NOT AVAIL wfsum THEN DO:
              CREATE wfsum.
              ASSIGN 
                  wfsum.n_type     = ntype                 
                  wfsum.n_bran     = wText.nr_branch         
                  wfsum.n_line     = SUBSTR(wText.nr_POLICY,3,2)
                  wfsum.n_gross    = czm100.os
                  wfsum.nt_gross   = wText.nr_osres  
                  wfsum.n_fee      = czm100.amt[19] 
                  wfsum.n_fac      = wText.nr_facri
                  wfsum.n_ret      = wfsum.nt_gross - wfsum.n_fac.
                  
          END.
          ELSE DO:
              ASSIGN wfsum.n_gross  = wfsum.n_gross + czm100.os       
                     wfsum.nt_gross   = wfsum.nt_gross + wText.nr_osres 
                     wfsum.n_fee    = wfsum.n_fee + czm100.amt[19]
                     wfsum.n_fac    = wfsum.n_fac + wText.nr_facri
                     wfsum.n_ret    = wfsum.n_ret + (wfsum.nt_gross - wfsum.n_fac).
          END.
          /*--End Benjaporn J. A59-0613 [14/12/2016]--*/
END.  /* czm100 */

 /*-- Benjaporn J. A59-0613 [14/12/2016] --*/
        
        nu_output = n_output + "sum_motor.slk".
        OUTPUT STREAM ns2 TO VALUE (nu_output).  /* For Summary Text Output */
        PUT STREAM ns2
            "Total" SKIP.
        
        PUT STREAM ns2
            "Type"            "|"
            "BRANCH"          "|"
            "LINE"            "|"
            "YEAR"            "|"
            "MONTH"           "|"
            "TRANDATE FROM"   "|"
            "TRANDATE TO"     "|"
            "ENTRYDATE"       "|"
            "GROSS"           "|"
            "SURVEY FEE"      "|"
            "TOTAL GROSS"     "|"
            "FAC"             "|"
            "TREATY"          "|"
            "COMP"            "|"
            "GROSS RET"       SKIP. 
        
        FOR EACH wfsum NO-LOCK
            BREAK BY wfsum.n_type 
                  BY wfsum.n_bran 
                  BY wfsum.n_line.
        
            FIND FIRST fnm002 USE-INDEX fnm00201 WHERE
                fnm002.TYPE   = wfsum.n_type    AND 
                fnm002.branch = wfsum.n_bran    AND
                fnm002.poltyp = wfsum.n_line    AND
                fnm002.osyr   = YEAR(nv_datto)  AND
                fnm002.osmth  = MONTH(nv_datto) NO-ERROR.
        
            IF NOT AVAIL fnm002 THEN DO:
                CREATE  fnm002.
                ASSIGN  fnm002.TYPE      =  wfsum.n_type 
                        fnm002.branch    =  wfsum.n_bran 
                        fnm002.poltyp    =  STRING(wfsum.n_line) 
                        fnm002.osmth     =  INT(MONTH(nv_datto))
                        fnm002.osyr      =  INT(YEAR(nv_datto))
                        fnm002.trndatfr  =  nv_datfr 
                        fnm002.trndatto  =  nv_datto 
                        fnm002.gross     =  wfsum.nt_gross 
                        fnm002.trtamt    =  wfsum.n_treaty
                        fnm002.facamt    =  wfsum.n_fac
                        fnm002.entdat    =  TODAY .
            END.                           
            ELSE DO:                       
                 ASSIGN  fnm002.TYPE     =  wfsum.n_type           
                         fnm002.branch   =  wfsum.n_bran           
                         fnm002.poltyp   =  STRING(wfsum.n_line)   
                         fnm002.osmth    =  INT(MONTH(nv_datto))   
                         fnm002.osyr     =  INT(YEAR(nv_datto))    
                         fnm002.trndatfr =  nv_datfr              
                         fnm002.trndatto =  nv_datto              
                         fnm002.gross    =  fnm002.gross  + wfsum.nt_gross         
                         fnm002.trtamt   =  fnm002.trtamt + wfsum.n_treaty        
                         fnm002.facamt   =  fnm002.facamt + wfsum.n_fac
                         fnm002.entdat   =  TODAY .
            END. 
        
            PUT STREAM ns2
                 wfsum.n_type                         "|" 
                 wfsum.n_bran                         "|" 
                 wfsum.n_line                         "|" 
                 YEAR(nv_datto)   FORMAT "9999"       "|"
                 MONTH(nv_datto)  FORMAT "99"         "|" 
                 nv_datfr         FORMAT "99/99/9999" "|"
                 nv_datto         FORMAT "99/99/9999" "|"
                 TODAY            FORMAT "99/99/9999" "|"
                 wfsum.n_gross                        "|"
                 wfsum.n_fee                          "|"
                 wfsum.nt_gross                       "|" 
                 wfsum.n_fac                          "|"
                 wfsum.n_treaty                       "|"
                 wfsum.n_comp                         "|"
                 wfsum.n_ret                        SKIP.
                
        END.                                     
        
        OUTPUT STREAM ns2 CLOSE.
        RELEASE fnm002.
        
        ASSIGN
            wfsum.n_gross    = 0
            wfsum.n_fee      = 0
            wfsum.nt_gross   = 0
            wfsum.n_fac      = 0 
            wfsum.n_treaty   = 0
            wfsum.n_comp     = 0 
            wfsum.n_ret      = 0.
        
        /*---End Benjaporn J. A59-0613 [14/12/2016] --*/
        

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdPrnNonMotor C-Win 
PROCEDURE pdPrnNonMotor :
/*------------------------------------------------------------------------------
  Purpose: Print Non Motor Report     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

ASSIGN nv_reccnt = 0
       nv_next   = 1.
loop_czm100:
FOR EACH CZM100  USE-INDEX CZM10002 WHERE 
         CZM100.ASDAT = n_asdat     AND 
         CZM100.BRANCH >= nv_branfr AND
         CZM100.BRANCH <= nv_branto NO-LOCK
BREAK BY CZM100.BRANCH 
      BY SUBSTR(CZM100.POLTYP,2,2)
      BY SUBSTR(CZM100.CLAIM,1,1)
      BY CZM100.CLAIM:

      ASSIGN nv_asdat  = CZM100.ASDAT
             nv_claim  = CZM100.CLAIM
             nv_chkLine = NO.

      IF non_poltyp = 1 THEN DO: /*Non-Motor All But Not 30,01,04*/
         IF (SUBSTR(czm100.POLTYP,2,1) = "7"  OR   
             czm100.POLTYP  = "M30"  OR  /*CMIP*/
             czm100.POLTYP  = "M01"  OR  /*CMIP*/
             czm100.POLTYP  = "M04"  OR  /*CMIP*/
             czm100.POLTYP  = "  ") THEN NEXT loop_czm100.
      END.
      ELSE IF non_poltyp = 2 THEN DO:  /*30,01,04 Only*/
          IF (czm100.POLTYP  <>  "M01"  AND
              czm100.POLTYP  <>  "M04"  AND
              czm100.POLTYP  <>  "M30") THEN NEXT loop_czm100.
      END.
      ELSE IF non_poltyp = 3 THEN DO:
          IF (SUBSTR(czm100.POLTYP,2,1) = "7" OR /*Non-motor all*/
              czm100.POLTYP  = " ") THEN NEXT loop_czm100.
      END.
      ELSE DO:
          IF czm100.POLTYP  = "" THEN NEXT loop_czm100.
      END.
       
      DISP czm100.claim WITH NO-LABEL TITLE "Printing Report..."
      FRAME a VIEW-AS DIALOG-BOX.

      IF FIRST-OF (CZM100.BRANCH) THEN DO:
         nv_nbran = CZM100.BRANCH.
         RUN pd_nbran.
      END.

      IF FIRST-OF (SUBSTR(CZM100.POLTYP,2,2)) THEN DO:
         FIND XMM031 USE-INDEX XMM03101 WHERE XMM031.POLTYP = CZM100.POLTYP  
         NO-LOCK NO-ERROR.
         nv_ntype = IF AVAIL XMM031 THEN XMM031.POLDES
                    ELSE "!!! Not found (" + TRIM(CZM100.POLTYP) + ")".
      END. /*FIRST-OF (CZM100.POLTYP)*/
    
      IF FIRST-OF (SUBSTR(CZM100.CLAIM,1,1)) THEN DO:
        FIND FIRST WCZM100 WHERE WCZM100.WFPOLTYP = SUBSTR(CZM100.POLTYP,2,2) AND
                   WCZM100.WFDI = SUBSTR(CZM100.CLAIM,1,1)
        NO-LOCK NO-ERROR.
        IF NOT AVAIL WCZM100 THEN DO:
           CREATE WCZM100.
           ASSIGN WCZM100.WFPOLTYP = SUBSTR(czm100.POLTYP,2,2)
                  WCZM100.WFPOLDES = nv_ntype
                  WCZM100.WFDI     = SUBSTR (czm100.CLAIM,1,1).
        END. /*NOT AVAIL*/
      END. /*FIRST-OF (SUBSTR(czm100.claim,1,1))*/

      FIND Xmm600 USE-INDEX Xmm60001 WHERE
           Xmm600.acno = czm100.INTREF NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN 
         ASSIGN nv_adjust = TRIM(Xmm600.ntitle) + TRIM(Xmm600.name)
                nv_adjusna = TRIM(TRIM(Xmm600.ntitle) + TRIM(Xmm600.name)).  
      ELSE ASSIGN  nv_adjust = ""
                   nv_adjusna = "".

      RUN pdFindACNO.
      
      IF n_ostyp = 1 THEN DO:
         IF czm100.OS <= 0 THEN NEXT loop_czm100.
      END.
      ELSE DO:
          IF czm100.OS <= 0 THEN NEXT loop_czm100. /*Lukkana M. A53-0139 03/09/2010 OS ติดลบไม่ต้องแสดงออกมา*/
      END.

      FOR EACH CZD101 USE-INDEX CZD10101 WHERE
               CZD101.ASDAT = nv_asdat AND
               CZD101.CLAIM = nv_claim NO-LOCK 
      BREAK BY CZD101.ASDAT BY CZD101.CLAIM BY CZD101.CLMANT BY CZD101.CLITEM:

        /*-Lukkana M. A53-0139 21/07/2010--*/
        nv_br1 = "".
        IF SUBSTR(czd101.claim,1,2) >= "10" AND
           SUBSTR(czd101.claim,1,2) <= "99" THEN nv_br1 = SUBSTR(czd101.claim,1,2).
        ELSE nv_br1 = SUBSTR(czd101.claim,2,1).
        /*--Lukkana M. A53-0139 21/07/2010--*/
        
        IF LAST-OF (CZD101.CLAIM) THEN DO:  
           OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
           RUN ChkLineExcel.
           EXPORT DELIMITER ";"
             czm100.Branch  SUBSTR(czm100.POLTYP,2,2)  SUBSTR(czm100.claim,1,1)
             czm100.GRPTYP  czm100.CLAIM   czm100.ENTDAT
             czm100.NOTDAT  czm100.LOSDAT  czm100.ENTDAT
             czm100.POLICY  nv_name               
             czm100.LOSS    czm100.OS    
             czm100.amt[19] czm100.amt[20] /*Lukkana M. A53-0139 01/09/2010*/
             czm100.AMT[1]  czm100.AMT[2]  czm100.AMT[3]  
             czm100.AMT[4]  czm100.AMT[5]  czm100.AMT[6]
             czm100.AMT[7]  czm100.AMT[8]  czm100.AMT[9]
             czm100.AMT[10] czm100.AMT[11] czm100.AMT[12]
             czm100.AMT[13] czm100.AMT[14] czm100.AMT[15]
             czm100.AMT[16] czm100.AMT[17] czm100.AMT[18]
             czm100.COPER   czm100.SICO    
             nv_police      nv_adjusna     nv_extnam
             nv_prodnam     nv_cedclm      nv_pacod
             nv_pades       czm100.DOCST.
           OUTPUT CLOSE.
            ASSIGN
                  nv_reccnt  = nv_reccnt + 1
                  nv_police  = ""
                  nv_pacod   = ""
                  nv_pades   = "".
           
           FIND FIRST wfnon WHERE wfnon.wfnDI = substr(czm100.claim,1,1) AND 
                                /*wfnon.wfnbran = SUBSTR(czm100.claim,2,1) AND Lukkana M. A53-0139 22/07/2010*/
                                  wfnon.wfnbran = nv_br1 AND /*Lukkana M. A53-0139 22/07/2010*/
                                  wfnon.wfnpoltyp = substr(czm100.poltyp,2,2) NO-ERROR.
           IF NOT AVAIL wfnon THEN
           CREATE wfnon.
           /*ASSIGN wfnbran = SUBSTR(czm100.claim,2,1) Lukkana M. A53-0139 22/07/2010*/
           ASSIGN wfnbran = nv_br1 /*Lukkana M. A53-0139 22/07/2010*/
                  wfnpoltyp = SUBSTR(czm100.poltyp,2,2)
                  wfnDI   = SUBSTR(czm100.claim,1,1) 
                  wfnos   = wfnos + czm100.OS 
                  i = 1.
                  /*DO i = 1 TO 18: Lukkana M. A53-0139 02/09/2010*/
                  DO i = 1 TO 20: /*Lukkana M. A53-0139 02/09/2010*/
                     wfnamt[i] = wfnamt[i] + czm100.amt[i].
                  END.
        END.
      END.

      RUN pdClrvalue.
END. /* Each czm100 */
RUN ChkLineExcel.
OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
EXPORT DELIMITER ";"
    "".
EXPORT DELIMITER ";" 
    "".
EXPORT DELIMITER ";"
    "Total : " "" "" "" "" "" "" "" "" "" "" ""
    "O/S Claim"   
    "Survey Fee"    /*Lukkana M. A53-0139 30/08/2010*/
    "Total Gross"   /*Lukkana M. A53-0139 30/08/2010*/
    "1st.TREATY"   
    "2nd.TREATY"      
    "FAC.RI."      
    "Q.S.5%"       
    "TFP"          
    "MPS" 
    "ENG.FAC."     
    "MARINE O/P"   
    "R.Q."         
    "BTR"          
    "OTR"          
    "FTR"
    "F/O I"        
    "F/O II"       
    "F/O III"      
    "F/O IV"
    "GROSS RET."   
    "XOL" . 
OUTPUT CLOSE.
nv_reccnt = nv_reccnt + 3.

FOR EACH wfnon NO-LOCK BREAK BY wfnon.wfnDI BY wfnon.wfnbran  BY wfnpoltyp :
    IF n_ostyp = 1 THEN DO:
       IF wfnon.wfnos <= 0 THEN NEXT.
    END.
    
    RUN ChkLineExcel.
    OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
    EXPORT DELIMITER ";"
    "" 
    wfnon.wfnDI + " - " + wfnon.wfnbran + " - " + wfnon.wfnpoltyp
    "" "" "" "" "" "" "" "" "" "" 
    wfnon.wfnos 
    wfnon.wfnamt[19]  wfnon.wfnamt[20] /*Lukkana M. A53-0139 02/09/2010*/
    wfnon.wfnamt[1]   wfnon.wfnamt[2]   wfnon.wfnamt[3]
    wfnon.wfnamt[4]   wfnon.wfnamt[5]   wfnon.wfnamt[6]
    wfnon.wfnamt[7]   wfnon.wfnamt[8]   wfnon.wfnamt[9]
    wfnon.wfnamt[10]  wfnon.wfnamt[11]  wfnon.wfnamt[12]
    wfnon.wfnamt[13]  wfnon.wfnamt[14]  wfnon.wfnamt[15]
    wfnon.wfnamt[16]  wfnon.wfnamt[17]  wfnon.wfnamt[18].
    OUTPUT CLOSE.
    nv_reccnt = nv_reccnt + 1.

    ASSIGN n_tos      = n_tos + wfnon.wfnos
           i = 1.
    /*DO i = 1 TO 18: Lukkana M. A53-0139 02/09/2010*/
    DO i = 1 TO 20:  /*Lukkana M. A53-0139 02/09/2010*/
       ASSIGN n_tamt[i]  = n_tamt[i]  + wfnon.wfnamt[i].
    END.
   
    FIND FIRST Wczm100 WHERE Wczm100.wfpoltyp = wfnon.wfnpoltyp AND
                             Wczm100.wfDI  = wfnon.wfnDI NO-LOCK NO-ERROR.
    IF NOT AVAIL Wczm100 THEN 
       CREATE wczm100.
       ASSIGN wczm100.wfpoltyp = wfnon.wfnpoltyp
              wczm100.wfDI     = wfnon.wfnDI
              wczm100.wfos     = wczm100.wfos + wfnon.wfnos
              i    = 1.
            /*DO i = 1 TO 18: Lukkana M. A53-0139 02/09/2010*/
            DO i = 1 TO 20:  /*Lukkana M. A53-0139 02/09/2010*/
               ASSIGN wfamt[i] = wfamt[i] + wfnon.wfnamt[i].
            END.

    ASSIGN n_bros      = n_bros +   wfnon.wfnos
           i = 1.
    /*DO i = 1 TO 18: Lukkana M. A53-0139 02/09/2010*/
    DO i = 1 TO 20:   /*Lukkana M. A53-0139 02/09/2010*/
       ASSIGN n_bramt[i]  = n_bramt[i]  + wfnon.wfnamt[i].
    END.
    
    IF LAST-OF (wfnon.wfnbran) THEN DO:
       n_br = wfnon.wfnbran.
       RUN pdbdes.
       RUN ChkLineExcel.
       OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
       EXPORT DELIMITER ";"
       "Total: " + wfnon.wfnDI + " - " + wfnon.wfnbran + " ::"
       n_bdes "" "" "" "" ""
       "" "" "" "" "" 
       n_bros  
       n_bramt[19]  n_bramt[20]  /*Lukkana M. A53-0139 02/09/2010*/
       n_bramt[1]   n_bramt[2]   n_bramt[3]
       n_bramt[4]   n_bramt[5]   n_bramt[6]
       n_bramt[7]   n_bramt[8]   n_bramt[9]
       n_bramt[10]  n_bramt[11]  n_bramt[12]  
       n_bramt[13]  n_bramt[14]  n_bramt[15]  
       n_bramt[16]  n_bramt[17]  n_bramt[18].
       OUTPUT CLOSE.
ASSIGN
       nv_reccnt = nv_reccnt + 1
       n_bros    = 0    
       n_bramt   = 0.
    END.
END.
RUN pdSum_AllBr.
RUN pdSum_DI.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdPrnSMotor C-Win 
PROCEDURE pdPrnSMotor :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
RUN ChkLineExcel2.
OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO.
EXPORT DELIMITER ";"
    czm100.Branch    czm100.POLTYP   nv_poldes
    czm100.GRPTYP    czm100.CLAIM    nv_event
    czm100.POLICY    
  /*   czm100.VEHREG       comment by Chaiyong W. A54-0112 12/12/2012*/
    czm100.VEHREG FORMAT "X(11)" /*---add by Chaiyong W. A54-0112 12/12/2012*/
    nv_insurnam      nv_pdcode       nv_pdname 
    nv_comdat        nv_expdat       nv_renpol
    nv_covcod        nv_defau        nv_loss1      
    czm100.ENTDAT    czm100.LOSDAT   czm100.NOTDAT  
    czm100.ENTDAT    nv_sumos
    czm100.amt[19]   czm100.amt[20]  /*Lukkana M. A53-0139 03/09/2010*/
    czm100.amt[3]    czm100.amt[17]  nv_nacod
    nv_nades         nv_pacod        nv_pades
    nv_sumpaid       nv_police  
    nv_adjusna       nv_extnam       nv_cedclm
    czm100.DOCST. 
OUTPUT CLOSE.
nv_reccnt2 = nv_reccnt2 + 1.

ASSIGN nv_sumos   = 0
       nv_sumpaid = 0.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdSum_AllBr C-Win 
PROCEDURE pdSum_AllBr :
/*------------------------------------------------------------------------------
  Purpose:  Summary By Branch for Non motor    
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
RUN ChkLineExcel. 
OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
EXPORT DELIMITER ";" "".
EXPORT DELIMITER ";"
     "Grand Total All Branch: "
     "" "" "" "" "" 
     "" "" "" "" "" "" 
     n_tos        
     n_tamt[19]   n_tamt[20]  /*Lukkana M. A53-0139 02/09/2010*/
     n_tamt[1]    n_tamt[2]       n_tamt[3] 
     n_tamt[4]    n_tamt[5]       n_tamt[6]       n_tamt[7] 
     n_tamt[8]    n_tamt[9]       n_tamt[10]      n_tamt[11]
     n_tamt[12]   n_tamt[13]      n_tamt[14]      n_tamt[15]
     n_tamt[16]   n_tamt[17]      n_tamt[18].
OUTPUT CLOSE. 
 nv_reccnt = nv_reccnt + 2.

ASSIGN
     n_tos      = 0   n_tamt[1] = 0       n_tamt[2]  = 0      n_tamt[3]  = 0 
     n_tamt[4]  = 0   n_tamt[5] = 0       n_tamt[6]  = 0      n_tamt[7]  = 0
     n_tamt[8]  = 0   n_tamt[9] = 0       n_tamt[10] = 0      n_tamt[11] = 0
     n_tamt[12] = 0  n_tamt[13] = 0       n_tamt[14] = 0      n_tamt[15] = 0
     n_tamt[16] = 0  n_tamt[17] = 0       n_tamt[18] = 0      
     n_tamt[19] = 0  n_tamt[20] = 0.  /*Lukkana M. A53-0139 02/09/2010*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdSum_DI C-Win 
PROCEDURE pdSum_DI :
/*------------------------------------------------------------------------------
  Purpose: Summary By D/I for Non motor    
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
loop_sumDI:
FOR EACH Wczm100 BREAK BY Wczm100.wfDI BY Wczm100.wfpoltyp:
    IF n_ostyp = 1 THEN DO:
       IF wczm100.wfos <= 0 THEN NEXT.
    END.
    ASSIGN n_gros = n_gros + wczm100.wfos
           i = 0.

    /*DO i = 1 TO 18: Lukkana M. A53-0139 02/09/2010*/
    DO i = 1 TO 20:  /*Lukkana M. A53-0139 02/09/2010*/
       n_gramt[i] = n_gramt[i] + wczm100.wfamt[i].
    END.
        
    IF FIRST-OF (Wczm100.wfDI) THEN DO:
       RUN ChkLineExcel. 
       OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
       EXPORT DELIMITER ";" "".
       EXPORT DELIMITER ";"
       "Summary of " + CAPS (Wczm100.wfDI) 
       "" "" "" "" "" "" "" "" "" "" ""
       "O/S Claim"  
       "Survey Fee"   /*Lukkana M. A53-0139 02/09/2010*/
       "Total Gross"  /*Lukkana M. A53-0139 02/09/2010*/
        "1st.TREATY"   
        "2nd.TREATY"      
        "FAC.RI."      
        "Q.S.5%"       
        "TFP"          
        "MPS" 
        "ENG.FAC."     
        "MARINE O/P"   
        "R.Q."         
        "BTR"          
        "OTR"          
        "FTR"
        "F/O I"        
        "F/O II"       
        "F/O III"      
        "F/O IV"
        "GROSS RET."   
        "XOL".
       OUTPUT CLOSE.
       nv_reccnt = nv_reccnt + 2.
    END.

    IF FIRST-OF (Wczm100.wfpoltyp) THEN DO:
       RUN ChkLineExcel.
       OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
       EXPORT DELIMITER ";".
       EXPORT DELIMITER ";"
       "" 
       Wczm100.wfpoltyp
       Wczm100.wfpoldes 
       "" "" "" "" "" "" "" "" "" 
       wfos        
       wfamt[19]   wfamt[20]   /*Lukkana M. A53-0139 02/09/2010*/
       wfamt[1]    wfamt[2]       wfamt[3]
       wfamt[4]    wfamt[5]       wfamt[6]       wfamt[7]
       wfamt[8]    wfamt[9]       wfamt[10]      wfamt[11]
       wfamt[12]   wfamt[13]      wfamt[14]      wfamt[15]
       wfamt[16]   wfamt[17]      wfamt[18].
       OUTPUT CLOSE.
       nv_reccnt = nv_reccnt + 2.
    END.

    IF LAST-OF (wczm100.wfDI) THEN DO:
       RUN ChkLineExcel.
       OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
       EXPORT DELIMITER ";".
       EXPORT DELIMITER ";"
       "Summary of " + wczm100.wfDI + " = "
       "" "" "" "" "" "" "" "" "" "" "" 
       n_gros      
       n_gramt[19] n_gramt[20]   /*Lukkana M. A53-0139 02/09/2010*/
       n_gramt[1]  n_gramt[2]     n_gramt[3]
       n_gramt[4]  n_gramt[5]     n_gramt[6]     n_gramt[7]
       n_gramt[8]  n_gramt[9]     n_gramt[10]    n_gramt[11]
       n_gramt[12] n_gramt[13]    n_gramt[14]    n_gramt[15]
       n_gramt[16] n_gramt[17]    n_gramt[18].   
       OUTPUT CLOSE.
       ASSIGN 
              nv_reccnt = nv_reccnt + 2
              n_gros    = 0.
    END.
END. /* DI */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_bhnap C-Win 
PROCEDURE pd_bhnap :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*----------------------- B H ------------------------*/
IF czm100.losdat >= 07/01/2015 THEN DO:
     ASSIGN
        wtext.nr_osbh  = w_gross  * 0.2
        wtext.nr_facbh = np_facri * 0.2
        wtext.nr_osbh_nv  = w_gross_nv  * 0.2
        wtext.nr_facbh_nv = np_facri_nv * 0.2.

      IF nv_trndat >= 07/01/2012 THEN 
      ASSIGN
         wtext.nr_ttybh = (np_1st  + np_2nd + np_rq  + np_btr) * 0.2
         wtext.nr_othbh = (np_qs5  + np_tfp + np_mps + np_eng 
                         + np_mar  + np_otr + np_ftr + np_fo1 
                         + np_fo2  + np_fo3 + np_fo4) * 0.2
         wtext.nr_ttybh_nv = (np_1st_nv  + np_2nd_nv + np_rq_nv  + np_btr_nv) * 0.2
         wtext.nr_othbh_nv = (np_qs5_nv  + np_tfp_nv + np_mps_nv + np_eng_nv 
                            + np_mar_nv  + np_otr_nv + np_ftr_nv + np_fo1_nv 
                            + np_fo2_nv  + np_fo3_nv + np_fo4_nv) * 0.2.

      ELSE                                     
      ASSIGN 
         wtext.nr_ttybh = 0   
         wtext.nr_othbh = (np_1st + np_2nd + np_rq  + np_btr
                         + np_qs5 + np_tfp + np_mps + np_eng 
                         + np_mar + np_otr + np_ftr + np_fo1 
                         + np_fo2 + np_fo3 + np_fo4) * 0.2
         wtext.nr_ttybh_nv = 0   
         wtext.nr_othbh_nv = (np_1st_nv + np_2nd_nv + np_rq_nv  + np_btr_nv
                            + np_qs5_nv + np_tfp_nv + np_mps_nv + np_eng_nv 
                            + np_mar_nv + np_otr_nv + np_ftr_nv + np_fo1_nv 
                            + np_fo2_nv + np_fo3_nv + np_fo4_nv) * 0.2. 

   END.                      
   ELSE DO: 
     ASSIGN                                 
        wtext.nr_osbh  = 0
        wtext.nr_facbh = 0
        wtext.nr_ttybh = 0
        wtext.nr_othbh = 0 
        wtext.nr_osbh_nv  = 0
        wtext.nr_facbh_nv = 0
        wtext.nr_ttybh_nv = 0
        wtext.nr_othbh_nv = 0 .
   END.

   /*----------------- N A P -------------------------*/
   IF nv_comdat <= 09/01/2018 AND czm100.losdat >= 09/01/2018 THEN DO:
   
     ASSIGN
        wtext.nr_osnap  = w_gross  * 0.125
        wtext.nr_facnap = np_facri * 0.125
        wtext.nr_ttynap = (np_1st  + np_2nd + np_rq  + np_btr) * 0.125
        wtext.nr_othnap = (np_qs5  + np_tfp + np_mps + np_eng 
                         + np_mar  + np_otr + np_ftr + np_fo1 
                         + np_fo2  + np_fo3 + np_fo4) * 0.125
        wtext.nr_osnap_nv  = w_gross_nv  * 0.125
        wtext.nr_facnap_nv = np_facri_nv * 0.125
        wtext.nr_ttynap_nv = (np_1st_nv  + np_2nd_nv + np_rq_nv  + np_btr_nv) * 0.2
        wtext.nr_othnap_nv = (np_qs5_nv  + np_tfp_nv + np_mps_nv + np_eng_nv 
                            + np_mar_nv  + np_otr_nv + np_ftr_nv + np_fo1_nv 
                            + np_fo2_nv  + np_fo3_nv + np_fo4_nv) * 0.125.

   END.
   ELSE DO: 
     ASSIGN                                 
        wtext.nr_osbh  = 0
        wtext.nr_facbh = 0
        wtext.nr_ttybh = 0
        wtext.nr_othbh = 0 
        wtext.nr_osbh_nv  = 0
        wtext.nr_facbh_nv = 0
        wtext.nr_ttybh_nv = 0
        wtext.nr_othbh_nv = 0 .
   END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_csftq C-Win 
PROCEDURE PD_csftq :
/*------------------------------------------------------------------------------
  Purpose: create by :  Benjaporn J. A59-0613 [14/12/2016] 
  Parameters:  <none>
  Notes: เพิ่มเงื่อนไขของ allocate    
------------------------------------------------------------------------------*/
FOR EACH Clm300 USE-INDEX Clm30001  WHERE Clm300.claim = CLM100.CLAIM  NO-LOCK:
    IF Clm300.csftq = "F" THEN 
       ASSIGN np_facri = np_facri + (Clm300.risi_p * w_gross) / 100
              np_facri_nv = np_facri_nv + (Clm300.risi_p * w_gross_nv) / 100.
    IF SUBSTRING (Clm300.rico,1,2) = "0T" AND SUBSTRING (Clm300.rico,6,2) = "01" THEN
        ASSIGN np_1st = (Clm300.risi_p * w_gross) / 100
               np_1st_nv = (Clm300.risi_p * w_gross_nv) / 100.
    ELSE IF SUBSTRING (Clm300.rico,1,2) = "0T" AND 
            SUBSTRING (Clm300.rico,6,2) = "02" AND
            NOT (CLM100.POLTYP = "M80"  OR CLM100.POLTYP = "M81" OR
                 CLM100.POLTYP = "M82"  OR CLM100.POLTYP = "M83" OR
                 CLM100.POLTYP = "M84"  OR CLM100.POLTYP = "M85" OR
                 CLM100.POLTYP = "C90") THEN DO:
        ASSIGN np_2nd = (Clm300.risi_p * w_gross) / 100
               np_2nd_nv = (Clm300.risi_p * w_gross_nv) / 100.
    END.
    ELSE IF SUBSTR(CLM300.RICO,1,2) = "0T" AND 
            SUBSTR(CLM300.RICO,6,2) = "02" AND
            CLM100.poltyp           = "C90"  THEN 
            ASSIGN np_mar = (Clm300.risi_p * w_gross) / 100
                   np_mar_nv = (Clm300.risi_p * w_gross_nv) / 100.

    ELSE IF SUBSTRING(Clm300.rico,1,4) = "STAT" THEN 
         ASSIGN np_qs5 = (Clm300.risi_p * w_gross) / 100
                np_qs5_nv = (Clm300.risi_p * w_gross_nv) / 100.

    ELSE IF SUBSTRING(Clm300.rico,1,3) = "0QA"  THEN 
         ASSIGN np_tfp = (Clm300.risi_p * w_gross) / 100
                np_tfp_nv = (Clm300.risi_p * w_gross_nv) / 100.

    ELSE IF SUBSTRING(Clm300.rico,1,3) = "0RQ"  THEN 
         ASSIGN np_rq  = (Clm300.risi_p * w_gross) / 100   
                np_rq_nv  = (Clm300.risi_p * w_gross_nv) / 100.    

    ELSE IF SUBSTRING(Clm300.rico,1,2) = "0T" AND SUBSTRING(Clm300.rico,6,2) = "F1" THEN 
        ASSIGN np_fo1 = (Clm300.risi_p * w_gross) / 100
               np_fo1_nv = (Clm300.risi_p * w_gross_nv) / 100.

    ELSE IF SUBSTRING(Clm300.rico,1,2) = "0T" AND SUBSTRING(Clm300.rico,6,2) = "F2" THEN
        ASSIGN np_fo2 = (Clm300.risi_p * w_gross) / 100
               np_fo2_nv = (Clm300.risi_p * w_gross_nv) / 100.

    ELSE IF SUBSTRING(Clm300.rico,1,2) = "0T" AND SUBSTRING(Clm300.rico,6,2) = "F3" THEN DO:
        IF LOOKUP (wText2.nr_Line,"M80,M81,M82,M83,M84,M85") <> 0 THEN
            ASSIGN np_eng = np_eng + (Clm300.risi_p * w_gross) / 100
                   np_eng_nv = np_eng + (Clm300.risi_p * w_gross_nv) / 100.
        ELSE ASSIGN np_fo3 = (Clm300.risi_p * w_gross) / 100
                   np_fo3_nv = (Clm300.risi_p * w_gross_nv) / 100.
    END.
    ELSE IF SUBSTRING(Clm300.rico,1,2) = "0T" AND SUBSTRING(Clm300.rico,6,2)  = "F4" THEN
        ASSIGN np_fo4 = (Clm300.risi_p * w_gross) / 100
               np_fo4_nv = (Clm300.risi_p * w_gross_nv) / 100.
    ELSE IF SUBSTRING(Clm300.rico,1,2) = "0T" AND SUBSTRING(Clm300.rico,6,2)  = "FT" THEN
        ASSIGN np_ftr = (Clm300.risi_p * w_gross) / 100
               np_ftr_nv = (Clm300.risi_p * w_gross_nv) / 100.
    ELSE IF SUBSTRING(clm300.rico,1,3) = "0PS" AND SUBSTRING(clm300.rico,6,2) = "01" THEN
        ASSIGN np_mps = (clm300.risi_p * w_gross) / 100
               np_mps_nv = (clm300.risi_p * w_gross_nv) / 100.
    ELSE IF SUBSTRING(clm300.rico,1,2) = "0T" AND SUBSTRING(clm300.rico,6,2)  = "FB" THEN
        ASSIGN np_btr = (clm300.risi_p * w_gross) / 100
               np_btr_nv = (clm300.risi_p * w_gross_nv) / 100.
    ELSE IF SUBSTRING(clm300.rico,1,2) = "0T" AND SUBSTRING(clm300.rico,6,2)  = "FO" THEN
        ASSIGN np_otr = (clm300.risi_p * w_gross) / 100
               np_otr_nv = (clm300.risi_p * w_gross_nv) / 100.
END.  /*--- FOR EACH Clm300 ---*/ 

 ASSIGN
    n_fee      =  czm100.amt[19]
    n_totgross =  w_gross 
    
    n_fac      =  np_facri
    n_treaty   =  np_1st 
                + np_2nd + np_eng
                + np_mar + np_rq
                + np_fo1 + np_fo2
                + np_fo3 + np_fo4  
                + np_ftr + np_mps
                + np_btr + np_otr 

    n_ced     =   np_facri + n_treaty + np_qs5 + np_tfp
    n_comp    =   np_qs5 + np_tfp
    n_net     =   n_totgross - n_fac - n_treaty - n_comp.

 ASSIGN 
    n_fee_nv      =  czm100.amount_netvat[19]
    n_totgross_nv =  w_gross_nv 
    n_totgross_v  =  w_gross_v
    
    n_fac_nv      =  np_facri_nv
    n_treaty_nv   =  np_1st_nv 
                + np_2nd_nv + np_eng_nv
                + np_mar_nv + np_rq_nv
                + np_fo1_nv + np_fo2_nv
                + np_fo3_nv + np_fo4_nv  
                + np_ftr_nv + np_mps_nv
                + np_btr_nv + np_otr_nv 

    n_ced_nv     =   np_facri_nv + n_treaty_nv + np_qs5_nv + np_tfp_nv
    n_comp_nv    =   np_qs5_nv + np_tfp_nv
    n_net_nv     =   n_totgross_nv - n_fac_nv - n_treaty_nv - n_comp_nv.
/*----------------A63-0417-----------*/

 CREATE wText.
 ASSIGN 
     wText.nr_line       = nr_type              /* line 70,72,73,74 ,...71 ( IC,LC,LL,DB )*/
     wText.nr_branch     = czm100.BRANCH 
     wText.nr_CLAIM      = czm100.CLAIM       
     wText.nr_entdat     = STRING(czm100.ENTDAT,"99/99/9999")     
     wText.nr_notdat     = STRING(czm100.NOTDAT,"99/99/9999")   
     wText.nr_LOSDAT     = STRING(czm100.LOSDAT,"99/99/9999") 
     wText.nr_POLICY     = TRIM(czm100.POLICY)
     wText.nr_name       = nr_name 
     wText.nr_LOSS       = TRIM(clm120.loss) 
     wText.nr_loss1      = nr_loss1     
     wText.nr_clmant_itm = nr_clmant_itm 
     wText.nr_osres      = w_gross  
     /*  Benjaporn J. A59-0613 [14/12/2016]  */
     wtext.nr_xol        = 0
     wText.nr_ced        = n_ced
     wText.nr_1st        = np_1st  
     wText.nr_2nd        = np_2nd  
     wText.nr_facri      = np_facri
     wText.nr_treaty     = n_treaty
     wText.nr_qs5        = np_qs5  
     wText.nr_tfp        = np_tfp  
     wText.nr_mps        = np_mps
     wText.nr_eng        = np_eng
     wText.nr_mar        = np_mar
     wText.nr_rq         = np_rq 
     wText.nr_btr        = np_btr
     wText.nr_otr        = np_otr
     wText.nr_ftr        = np_ftr
     wText.nr_fo1        = np_fo1
     wText.nr_fo2        = np_fo2
     wText.nr_fo3        = np_fo3
     wText.nr_fo4        = np_fo4
     wText.nr_net        = n_net
     wText.nr_comp       = n_comp
     /*---- End [A59-0613] ----*/
     wText.nr_adjust     = nr_adjust              
     wText.nr_intref     = nr_intref
     wText.nr_extref     = nr_extref   
     wText.nr_agent      = nr_agent    
     wText.nr_cedclm     = nr_cedclm    
     wText.nr_DOCST      = czm100.DOCST            
     wText.nr_pades      = nr_pades    
     wText.nr_trndat     = nr_trandat   
     wText.nr_comdat     = nr_comdate            
     wText.nr_agent1     = nr_agent1
     /*--A63-0417--*/
     wText.nr_osres_nv      = w_gross_nv  
     wtext.nr_osres_v       = w_gross_v
     wtext.nr_xol_nv        = 0
     wText.nr_ced_nv        = n_ced_nv
     wText.nr_1st_nv        = np_1st_nv  
     wText.nr_2nd_nv        = np_2nd_nv  
     wText.nr_facri_nv      = np_facri_nv
     wText.nr_treaty_nv     = n_treaty_nv
     wText.nr_qs5_nv        = np_qs5_nv  
     wText.nr_tfp_nv        = np_tfp_nv  
     wText.nr_mps_nv        = np_mps_nv
     wText.nr_eng_nv        = np_eng_nv
     wText.nr_mar_nv        = np_mar_nv
     wText.nr_rq_nv         = np_rq_nv
     wText.nr_btr_nv        = np_btr_nv
     wText.nr_otr_nv        = np_otr_nv
     wText.nr_ftr_nv        = np_ftr_nv
     wText.nr_fo1_nv        = np_fo1_nv
     wText.nr_fo2_nv        = np_fo2_nv
     wText.nr_fo3_nv        = np_fo3_nv
     wText.nr_fo4_nv        = np_fo4_nv
     wText.nr_net_nv        = n_net_nv
     wText.nr_comp_nv       = n_comp_nv
     wtext.nr_rescod        = czd101.rescod
     wtext.nr_resref        = czd101.repref.

   RUN pd_bhnap.

 ASSIGN                          
     n_ced      = 0              np_rq      = 0     
     np_1st     = 0              np_btr     = 0     
     np_2nd     = 0              np_otr     = 0   
     np_facri   = 0              np_ftr     = 0 
     n_treaty   = 0              np_fo1     = 0   
     np_qs5     = 0              np_fo2     = 0   
     np_tfp     = 0              np_fo3     = 0   
     np_mps     = 0              np_fo4     = 0   
     np_eng     = 0              n_net      = 0   
     np_mar     = 0              n_comp     = 0   
     /* A63-0417 */
     n_ced_nv      = 0           np_rq_nv   = 0     
     np_1st_nv     = 0           np_btr_nv  = 0     
     np_2nd_nv     = 0           np_otr_nv  = 0   
     np_facri_nv   = 0           np_ftr_nv  = 0 
     n_treaty_nv   = 0           np_fo1_nv  = 0   
     np_qs5_nv     = 0           np_fo2_nv  = 0   
     np_tfp_nv     = 0           np_fo3_nv  = 0   
     np_mps_nv     = 0           np_fo4_nv  = 0   
     np_eng_nv     = 0           n_net_nv   = 0   
     np_mar_nv     = 0           n_comp_nv  = 0.  

 /* --- [ A59-0613 ] --- */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_nbran C-Win 
PROCEDURE pd_nbran :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

n_nbran = "".    /* A51-0102 */
/*--- Find n_nbran ---
 FIND Xmm023 USE-INDEX Xmm02301 WHERE Xmm023.branch = nv_nbran
 NO-LOCK NO-ERROR.
 n_nbran = IF AVAILABLE Xmm023 THEN Xmm023.bdes
           ELSE "". 
 Lukkana M. A53-0139 21/07/2010----*/


/*-- Lukkana M. A53-0139 21/07/2010----*/
FIND FIRST xmm023 USE-INDEX xmm02301 WHERE xmm023.branch = nv_nbran NO-LOCK NO-ERROR.
IF AVAIL xmm023 THEN n_nbran = xmm023.bdes.
ELSE n_nbran = "".
/*-- Lukkana M. A53-0139 21/07/2010----*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_clrgtotal C-Win 
PROCEDURE proc_clrgtotal :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN ngd_osres          =     0
       ngd_ced            =     0
       ngd_1st            =     0
       ngd_2nd            =     0
       ngd_facri          =     0
       ngd_qs5            =     0
       ngd_tfp            =     0
       ngd_mps            =     0
       ngd_eng            =     0
       ngd_mar            =     0
       ngd_rq             =     0
       ngd_btr            =     0
       ngd_otr            =     0
       ngd_ftr            =     0
       ngd_fo1            =     0
       ngd_fo2            =     0
       ngd_fo3            =     0
       ngd_fo4            =     0
       ngd_ret            =     0
       ngd_xol            =     0
       ngd_osbh           =     0
       ngd_ttybh          =     0
       ngd_facbh          =     0
       ngd_othbh          =     0
       ngd_osnap          =     0
       ngd_ttynap         =     0
       ngd_facnap         =     0
       ngd_othnap         =     0
       ngd_osres_v        =     0
       ngd_osres_nv       =     0
       ngd_ced_nv         =     0
       ngd_1st_nv         =     0
       ngd_2nd_nv         =     0
       ngd_facri_nv       =     0
       ngd_qs5_nv         =     0
       ngd_tfp_nv         =     0
       ngd_mps_nv         =     0
       ngd_eng_nv         =     0
       ngd_mar_nv         =     0
       ngd_rq_nv          =     0
       ngd_btr_nv         =     0
       ngd_otr_nv         =     0
       ngd_ftr_nv         =     0
       ngd_fo1_nv         =     0
       ngd_fo2_nv         =     0
       ngd_fo3_nv         =     0
       ngd_fo4_nv         =     0
       ngd_ret_nv         =     0
       ngd_xol_nv         =     0
       ngd_osbh_nv        =     0
       ngd_ttybh_nv       =     0
       ngd_facbh_nv       =     0
       ngd_othbh_nv       =     0
       ngd_osnap_nv       =     0
       ngd_ttynap_nv      =     0
       ngd_facnap_nv      =     0
       ngd_othnap_nv      =     0
       ngd_countcl        =     0.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_exporttext C-Win 
PROCEDURE proc_exporttext :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR cntop AS INT.

RUN proc_exporttext2. /*---Header Detail Report---*/

ASSIGN nv_reccnt = 0.

FOR EACH   wText2 USE-INDEX wText201  NO-LOCK.   /*BREAK BY wText2.nr_branch  BY wText2.nr_Line:*/

    ASSIGN np_branch = ""              np_line      = ""    np_branch    = wText2.nr_branch 
        np_line      = wText2.nr_Line  np_osres     = 0     np_facri     = 0
        np_osres70   = 0               np_osres71   = 0     np_osres72   = 0
        np_osres73   = 0               np_osres74   = 0     np_facri70   = 0 
        np_facri71   = 0               np_facri72   = 0     np_facri73   = 0  
        np_facri74   = 0               nv_count     = 0     nv_countcl   = 0    
        nv_next      = 0               nv_row       = nv_row + 1   
        /* Benjaporn J. A59-0613 [14/12/2016] */
        np_osbh      = 0               np_facbh     = 0   
        np_ttybh     = 0               np_othbh     = 0
        np_osnap     = 0               np_facnap    = 0   
        np_ttynap    = 0               np_othnap    = 0
        np_fee       = 0               np_1st       = 0  
        np_totgross  = 0               np_2nd       = 0  
        np_ced       = 0               np_ret       = 0 
        nt_qs5       = 0               nt_otr       = 0 
        nt_tfp       = 0               nt_ftr       = 0 
        nt_mps       = 0               nt_fo1       = 0 
        nt_eng       = 0               nt_fo2       = 0 
        nt_mar       = 0               nt_fo3       = 0 
        nt_rq        = 0               nt_fo4       = 0 
        nt_btr       = 0   . 
        ASSIGN   /*A63-0417*/
        np_osres_nv     = 0            np_osres_v      = 0
        np_facri_nv     = 0
        np_osbh_nv      = 0            np_facbh_nv     = 0   
        np_ttybh_nv     = 0            np_othbh_nv     = 0
        np_osnap_nv     = 0            np_facnap_nv     = 0   
        np_ttynap_nv    = 0            np_othnap_nv     = 0
        np_fee_nv       = 0            np_1st_nv       = 0  
        np_totgross_nv  = 0            np_2nd_nv       = 0  
        np_ced_nv       = 0            np_ret_nv       = 0 
        nt_qs5_nv       = 0            nt_otr_nv       = 0 
        nt_tfp_nv       = 0            nt_ftr_nv       = 0 
        nt_mps_nv       = 0            nt_fo1_nv       = 0 
        nt_eng_nv       = 0            nt_fo2_nv       = 0 
        nt_mar_nv       = 0            nt_fo3_nv       = 0 
        nt_rq_nv        = 0            nt_fo4_nv       = 0 
        nt_btr_nv       = 0   .        
    
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X1;K"   '"'  "Branch : "          '"' SKIP.            
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X2;K"   '"'  wText2.nr_branch     '"' SKIP.  
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X3;K"   '"'  wText2.nr_branchdsp  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X4;K"   '"'  "Policy Type :"      '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X5;K"   '"'  txtpoltyp            '"' SKIP.

    RUN proc_exporttext3.

    ASSIGN nv_row     = nv_row + 1
        nv_countcl = 0   .

    FOR EACH wText4 USE-INDEX wText401 WHERE 
        wText4.nr_branch   = wText2.nr_branch AND 
        wtext4.nr_Line     = wText2.nr_line NO-LOCK .
        nv_countcl = nv_countcl + 1.
    END.

    FOR EACH wText4. DELETE wText4. END.

    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X1;K"    '"'  "Total Branch : "   '"' SKIP.            
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X2;K"    '"'  wText2.nr_branch    '"' SKIP.  
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X3;K"    '"'  "Line "             '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X4;K"    '"'  wText.nr_line       '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X5;K"    '"'  "Count :"           '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X6;K"    '"'  nv_countcl          '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X15;K"   '"'  np_osres            '"' SKIP.
    /*---- Benjaporn J. A59-0613 [14/12/2016] ----*/
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X16;K"   '"'  np_ced    '"' SKIP.  
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X17;K"   '"'  np_1st    '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X18;K"   '"'  np_2nd    '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X19;K"   '"'  np_facri  '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X20;K"   '"'  nt_qs5    '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X21;K"   '"'  nt_tfp    '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X22;K"   '"'  nt_mps    '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X23;K"   '"'  nt_eng    '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X24;K"   '"'  nt_mar    '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X25;K"   '"'  nt_rq     '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X26;K"   '"'  nt_btr    '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X27;K"   '"'  nt_otr    '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X28;K"   '"'  nt_ftr    '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X29;K"   '"'  nt_fo1    '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X30;K"   '"'  nt_fo2    '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X31;K"   '"'  nt_fo3    '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X32;K"   '"'  nt_fo4    '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X33;K"   '"'  np_ret    '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X34;K"   '"'  np_xol    '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X35;K"   '"'  np_osbh   '"' SKIP.    
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X36;K"   '"'  np_ttybh  '"' SKIP.    
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X37;K"   '"'  np_facbh  '"' SKIP.    
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X38;K"   '"'  np_othbh  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X39;K"   '"'  np_osnap   '"' SKIP.    
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X40;K"   '"'  np_ttynap  '"' SKIP.    
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X41;K"   '"'  np_facnap  '"' SKIP.    
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X42;K"   '"'  np_othnap  '"' SKIP. 
    /*---- End [A59-0613] ----*/
    /*A63-0417*/
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X53;K"   '"'  np_osres_v   '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X54;K"   '"'  np_osres_nv   '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X55;K"   '"'  np_ced_nv  '"' SKIP.  
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X56;K"   '"'  np_1st_nv  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X57;K"   '"'  np_2nd_nv  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X58;K"   '"'  np_facri_nv  '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X59;K"   '"'  nt_qs5_nv  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X60;K"   '"'  nt_tfp_nv  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X61;K"   '"'  nt_mps_nv  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X62;K"   '"'  nt_eng_nv  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X63;K"   '"'  nt_mar_nv  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X64;K"   '"'  nt_rq_nv  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X65;K"   '"'  nt_btr_nv  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X66;K"   '"'  nt_otr_nv  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X67;K"   '"'  nt_ftr_nv  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X68;K"   '"'  nt_fo1_nv  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X69;K"   '"'  nt_fo2_nv  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X70;K"   '"'  nt_fo3_nv  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X71;K"   '"'  nt_fo4_nv  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X72;K"   '"'  np_ret_nv  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X73;K"   '"'  np_xol_nv  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X74;K"   '"'  np_osbh_nv  '"' SKIP.    
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X75;K"   '"'  np_ttybh_nv  '"' SKIP.    
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X76;K"   '"'  np_facbh_nv  '"' SKIP.    
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X77;K"   '"'  np_othbh_nv  '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X78;K"   '"'  np_osnap_nv  '"' SKIP.    
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X79;K"   '"'  np_ttynap_nv  '"' SKIP.    
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X80;K"   '"'  np_facnap_nv  '"' SKIP.    
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X81;K"   '"'  np_othnap_nv  '"' SKIP. 
    nv_row   = nv_row   + 1 .

    ngd_countcl = ngd_countcl + nv_countcl.

    RUN proc_exporttext4.

    RUN proc_wtext. /*---- Benjaporn J. A59-0613 [14/12/2016] ----*/

    

END.

RUN proc_exporttext5.   /* Grand Total */

OUTPUT STREAM ns1 CLOSE.  

ASSIGN cntop     = LENGTH(n_output) - 5   
       n_output  = SUBSTR(n_output,1,cntop) + "_sum"  + ".slk"
       nv_row    = 1 .


OUTPUT STREAM ns1 TO VALUE(n_output)  .   /*file summary */

    RUN proc_exporttext_p.   /*---- Benjaporn J. A59-0613 [14/12/2016] ----*/

    RUN proc_clrgtotal.
                          
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_exporttext2 C-Win 
PROCEDURE proc_exporttext2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
OUTPUT STREAM ns1 TO VALUE(n_output)  .
PUT STREAM ns1 "ID;PND" SKIP.  
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X1;K" '"' "Safety Insurance Public Company Limited"  '"' SKIP. 
ASSIGN nv_row   = nv_row + 1
       nv_text  = "Summary of Outstanding Claim Report (Monthly)" + STRING(TODAY,"99/99/9999") .
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X1;K" '"'  nv_text   '"' SKIP. 
ASSIGN nv_row   = nv_row + 1.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X1;K" '"' "This Report Print Only Claim Status = O And P   O/S = Reserve - Paid"        '"' SKIP. 
ASSIGN nv_row   = nv_row + 1
       nv_text  = "Running of :  Class ="  +  txtpoltyp  +  "As of Date :" +  STRING(n_asdat,"99/99/9999")     .
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X1;K" '"'   nv_text    '"' SKIP. 
ASSIGN nv_row   = nv_row + 1
       nv_text  = "Branch No. From : " +  nv_branfr + "To : " +  nv_branto     .
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X1;K" '"' nv_text  '"' SKIP. 
nv_row   = nv_row + 1. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X1;K"  '"'    "NO."                  '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X2;K"  '"'    "Claim NO."            '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X3;K"  '"'    "Tran Date กรมธรรม์"   '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X4;K"  '"'    "Com Date กรมธรรม์"    '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X5;K"  '"'    "ENTRY Date"           '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X6;K"  '"'    "Notify Date"          '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X7;K"  '"'    "Loss Date"            '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X8;K"  '"'    "OPEN Date"            '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X9;K"  '"'    "Policy NO."           '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X10;K" '"'    "Policy Line."         '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X11;K" '"'    "Insured"              '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X12;K" '"'    "TYPE"                 '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X13;K" '"'    "Cause OF Loss"        '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X14;K" '"'    "Claimant/Claim item"  '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X15;K" '"'    "O/S"                  '"' SKIP. 


/* comment by  Benjaporn J. A59-0613 [14/12/2016]  
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X14;K" '"'    "Gross BH QS"          '"' SKIP.  
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X15;K" '"'    "FAC BH QS"            '"' SKIP.  
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X16;K" '"'    "Adjuster"             '"' SKIP.  
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X17;K" '"'    "Int.Surveyor"         '"' SKIP.  
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X18;K" '"'    "Ext. Surveyor"        '"' SKIP.  
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X19;K" '"'    "Producer Surveyor"    '"' SKIP.  
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X20;K" '"'    "Ceding Claim NO."     '"' SKIP.  
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X21;K" '"'    "Doc.St"               '"' SKIP.  
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X22;K" '"'    "Cl.Comment"           '"' SKIP.  
------- End [A59-0613] ------------*/
/* --- Benjaporn J. A59-0613 [14/12/2016]--- */
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X16;K" '"'    "CEDED"                '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X17;K" '"'    "1st.TREATY"           '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X18;K" '"'    "2nd.TREATY"           '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X19;K" '"'    "FAC.RI."              '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X20;K" '"'    "Q.S.5%"               '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X21;K" '"'    "TFP"                  '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X22;K" '"'    "MPS"                  '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X23;K" '"'    "ENG.FAC."             '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X24;K" '"'    "MARINE O/P"           '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X25;K" '"'    "R.Q."                 '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X26;K" '"'    "BTR"                  '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X27;K" '"'    "OTR"                  '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X28;K" '"'    "FTR"                  '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X29;K" '"'    "F/O I"                '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X30;K" '"'    "F/O II"               '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X31;K" '"'    "F/O III"              '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X32;K" '"'    "F/O IV"               '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X33;K" '"'    "GROSS RET."           '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X34;K" '"'    "XOL."                 '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X35;K" '"'    "Gross QS BH"          '"' SKIP.     
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X36;K" '"'    "TTY QS BH"            '"' SKIP.     
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X37;K" '"'    "Fac QS BH"            '"' SKIP.     
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X38;K" '"'    "Other QS BH"          '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X39;K" '"'    "Gross QS NAP"          '"' SKIP.     
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X40;K" '"'    "TTY QS NAP"            '"' SKIP.     
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X41;K" '"'    "Fac QS NAP"            '"' SKIP.     
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X42;K" '"'    "Other QS NAP"          '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X43;K" '"'    "Adjuster"             '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X44;K" '"'    "Int.Surveyor"         '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X45;K" '"'    "Ext. Surveyor"        '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X46;K" '"'    "Producer Surveyor"    '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X47;K" '"'    "Agent Code"           '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X48;K" '"'    "Ceding Claim NO."     '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X49;K" '"'    "Doc.St"               '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X50;K" '"'    "Cl.Comment"           '"' SKIP. 
/* ------ End [A59-0613] ------ */
/*---A63-0417----*/
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X51;K" '"'    "RES.CODE"              '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X52;K" '"'    "RES.REF"              '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X53;K" '"'    "O/S vat"              '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X54;K" '"'    "O/S Netvat"           '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X55;K" '"'    "CEDED Netvat"         '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X56;K" '"'    "1st.TREATY Netvat"    '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X57;K" '"'    "2nd.TREATY Netbat"    '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X58;K" '"'    "FAC.RI. Netvat"       '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X59;K" '"'    "Q.S.5% Netvat"        '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X60;K" '"'    "TFP Netvat"           '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X61;K" '"'    "MPS Netvat"           '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X62;K" '"'    "ENG.FAC. Netvat"      '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X63;K" '"'    "MARINE O/P Netvat"    '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X64;K" '"'    "R.Q. Netvat"          '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X65;K" '"'    "BTR Netvat"           '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X66;K" '"'    "OTR Netvat"           '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X67;K" '"'    "FTR Netvat"           '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X68;K" '"'    "F/O I Netvat"         '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X69;K" '"'    "F/O II Netvat"        '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X70;K" '"'    "F/O IIINetvat"        '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X71;K" '"'    "F/O IV Netvat"        '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X72;K" '"'    "GROSS RET. Netvat"    '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X73;K" '"'    "XOL. Netvat"          '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X74;K" '"'    "Gross QS BH Netvat"   '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X75;K" '"'    "TTY QS BH Netvat"     '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X76;K" '"'    "Fac QS BH Netvat"     '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X77;K" '"'    "Other QS BH Netvat"   '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X78;K" '"'    "Gross QS NAP Netvat"   '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X79;K" '"'    "TTY QS NAP Netvat"     '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X80;K" '"'    "Fac QS NAP Netvat"     '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X81;K" '"'    "Other QS NAP Netvat"   '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X82;K" '"'    "Client Type Code"     '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X83;K" '"'    "%VAT"   '"' SKIP. 


/*----end A63-0417-----------*/

OUTPUT CLOSE.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_exporttext3 C-Win 
PROCEDURE proc_exporttext3 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wText  USE-INDEX wText101 NO-LOCK WHERE
        wText.nr_branch = wText2.nr_branch  AND
        wText.nr_Line   = wText2.nr_Line    AND
        wText.nr_osres  > 0
       BREAK BY wText.nr_CLAIM:   /*BREAK BY wText.nr_line  BY wText.nr_CLAIM: */
       
        ASSIGN  
            nv_count     = nv_count  + 1  
            nv_cnt       = nv_cnt    + 1
            nv_row       = nv_row    + 1 
            np_osres     = np_osres  + wText.nr_osres 
            np_facri     = np_facri  + wText.nr_facri 
            nv_reccnt    = nv_reccnt + 1 
            /* Benjaporn J. A59-0613 [14/12/2016] */
            np_xol       = np_xol    + wText.nr_xol 
            np_fee       = np_fee    + wText.nr_fee
            np_totgross  = np_totgross  + wText.nr_ntgross
            np_ced       = np_ced    + wText.nr_ced 
            np_1st       = np_1st    + wText.nr_1st
            np_2nd       = np_2nd    + wText.nr_2nd
            np_ret       = np_ret    + wText.nr_net
            nt_qs5       = nt_qs5    + wText.nr_qs5
            nt_tfp       = nt_tfp    + wText.nr_tfp
            nt_mps       = nt_mps    + wText.nr_mps
            nt_eng       = nt_eng    + wText.nr_eng
            nt_mar       = nt_mar    + wText.nr_mar
            nt_rq        = nt_rq     + wText.nr_rq 
            nt_btr       = nt_btr    + wText.nr_btr
            nt_otr       = nt_otr    + wText.nr_otr
            nt_ftr       = nt_ftr    + wText.nr_ftr
            nt_fo1       = nt_fo1    + wText.nr_fo1
            nt_fo2       = nt_fo2    + wText.nr_fo2
            nt_fo3       = nt_fo3    + wText.nr_fo3
            nt_fo4       = nt_fo4    + wText.nr_fo4
            np_osbh      = np_osbh   + wText.nr_osbh     
            np_facbh     = np_facbh  + wText.nr_facbh
            np_ttybh     = np_ttybh  + wText.nr_ttybh     
            np_othbh     = np_othbh  + wText.nr_othbh
            np_osnap      = np_osnap   + wText.nr_osnap     
            np_facnap     = np_facnap  + wText.nr_facnap
            np_ttynap     = np_ttynap  + wText.nr_ttynap     
            np_othnap     = np_othnap  + wText.nr_othnap
             .
            ASSIGN  /*A63-0417*/
            np_osres_nv   = np_osres_nv  + wText.nr_osres_nv
            np_osres_v    = np_osres_v   + wText.nr_osres_v
            np_facri_nv   = np_facri_nv  + wText.nr_facri_nv
            np_xol_nv     = np_xol_nv  + wText.nr_xol_nv
            np_fee_nv     = np_fee_nv  + wText.nr_fee_nv
            np_totgross_nv  = np_totgross_nv  + wText.nr_ntgross_nv
            np_ced_nv       = np_ced_nv    + wText.nr_ced_nv 
            np_1st_nv       = np_1st_nv    + wText.nr_1st_nv
            np_2nd_nv       = np_2nd_nv    + wText.nr_2nd_nv
            np_ret_nv       = np_ret_nv    + wText.nr_net_nv
            nt_qs5_nv       = nt_qs5_nv    + wText.nr_qs5_nv
            nt_tfp_nv       = nt_tfp_nv    + wText.nr_tfp_nv
            nt_mps_nv       = nt_mps_nv    + wText.nr_mps_nv
            nt_eng_nv       = nt_eng_nv    + wText.nr_eng_nv
            nt_mar_nv       = nt_mar_nv    + wText.nr_mar_nv
            nt_rq_nv        = nt_rq_nv     + wText.nr_rq_nv
            nt_btr_nv       = nt_btr_nv    + wText.nr_btr_nv
            nt_otr_nv       = nt_otr_nv    + wText.nr_otr_nv
            nt_ftr_nv       = nt_ftr_nv    + wText.nr_ftr_nv
            nt_fo1_nv       = nt_fo1_nv    + wText.nr_fo1_nv
            nt_fo2_nv       = nt_fo2_nv    + wText.nr_fo2_nv
            nt_fo3_nv       = nt_fo3_nv    + wText.nr_fo3_nv
            nt_fo4_nv       = nt_fo4_nv    + wText.nr_fo4_nv
            np_osbh_nv      = np_osbh_nv   + wText.nr_osbh_nv     
            np_facbh_nv     = np_facbh_nv  + wText.nr_facbh_nv
            np_ttybh_nv     = np_ttybh_nv  + wText.nr_ttybh_nv     
            np_othbh_nv     = np_othbh_nv  + wText.nr_othbh_nv
            np_osnap_nv     = np_osnap_nv  + wText.nr_osnap_nv     
            np_facnap_nv    = np_facnap_nv + wText.nr_facnap_nv
            np_ttynap_nv    = np_ttynap_nv + wText.nr_ttynap_nv     
            np_othnap_nv    = np_othnap_nv + wText.nr_othnap_nv  .

        DISP wText.nr_CLAIM WITH NO-LABEL TITLE "Output data:...."  FRAME a VIEW-AS DIALOG-BOX.
       
        /*IF nv_reccnt  > 60000 THEN  DO:
            ASSIGN cntop  = LENGTH(n_output) - 4   
                nv_next   = nv_next + 1
                n_output  = SUBSTR(n_output,1,cntop) + "_" + STRING(nv_next) + ".slk"
                nv_reccnt = 0
                nv_row    = 1 .
            RUN proc_exporttext2.   
            nv_row   = nv_row + 1. 
        END.
        */
        
        IF nv_chkpollicy <> wText.nr_CLAIM THEN  
            PUT STREAM ns1 "C;Y" STRING(nv_row) ";X1;K"   '"'  nv_count    '"' SKIP.   
        ELSE DO: 
            ASSIGN nv_count = nv_count - 1 .
            PUT STREAM ns1 "C;Y" STRING(nv_row) ";X1;K"   '"'  ""          '"' SKIP.   
        END.

        ASSIGN nn_clicod = ""
               nn_vat_p   = 0.

        IF wText.nr_resref <> "" THEN DO:
       
            FIND FIRST xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = wText.nr_resref NO-LOCK NO-ERROR.
            IF NOT AVAIL xmm600 THEN DO:
               nn_clicod = "".
            END.
            ELSE DO:
               FIND FIRST arm012 WHERE arm012.TYPE = "VR" 
                                   AND arm012.prjcod = xmm600.clicod NO-LOCK NO-ERROR.
               IF NOT AVAIL arm012 THEN DO:
                  ASSIGN nn_clicod = ""
                         nn_vat_p   = 0.
               END.
               ELSE DO:
                   nn_clicod = xmm600.clicod.
                   IF DEC(arm012.text1) = 0 THEN DO:
                      ASSIGN nn_vat_p   = 0.
                   END.
                   ELSE DO:
                      ASSIGN nn_vat_p  = DEC(arm012.text1).
                   END.
               END.
            END.

        END.

        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X2;K"  '"'  wText.nr_CLAIM         '"' SKIP.  
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X3;K"  '"'  wText.nr_trndat        '"' SKIP.  
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X4;K"  '"'  wText.nr_comdat       '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X5;K"  '"'  wText.nr_entdat        '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X6;K"  '"'  wText.nr_notdat        '"' SKIP.  
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X7;K"  '"'  wText.nr_LOSDAT        '"' SKIP.    
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X8;K"  '"'  wText.nr_entdat        '"' SKIP.    
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X9;K"  '"'  wText.nr_POLICY        '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X10;K" '"'  wText.nr_line          '"' SKIP.  
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X11;K" '"'  wText.nr_name          '"' SKIP.  
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X12;K" '"'  wText.nr_LOSS          '"' SKIP.  
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X13;K" '"'  wText.nr_loss1         '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X14;K" '"'  wText.nr_clmant_itm    '"' SKIP. 
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X15;K" '"'  wText.nr_osres         '"' SKIP. 
        /*---- Benjaporn J. A59-0613 [14/12/2016] ----*/
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X16;K"  '"'  wText.nr_ced       '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X17;K"  '"'  wText.nr_1st       '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X18;K"  '"'  wText.nr_2nd       '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X19;K"  '"'  wText.nr_facri     '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X20;K"  '"'  wText.nr_qs5       '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X21;K"  '"'  wText.nr_tfp       '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X22;K"  '"'  wText.nr_mps       '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X23;K"  '"'  wText.nr_eng       '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X24;K"  '"'  wText.nr_mar       '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X25;K"  '"'  wText.nr_rq        '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X26;K"  '"'  wText.nr_btr       '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X27;K"  '"'  wText.nr_otr       '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X28;K"  '"'  wText.nr_ftr       '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X29;K"  '"'  wText.nr_fo1       '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X30;K"  '"'  wText.nr_fo2       '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X31;K"  '"'  wText.nr_fo3       '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X32;K"  '"'  wText.nr_fo4       '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X33;K"  '"'  wText.nr_net       '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X34;K"  '"'  wtext.nr_xol       '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X35;K"  '"'  wText.nr_osbh      '"' SKIP.    
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X36;K"  '"'  wText.nr_ttybh     '"' SKIP.    
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X37;K"  '"'  wText.nr_facbh     '"' SKIP.    
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X38;K"  '"'  wText.nr_othbh     '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X39;K"  '"'  wText.nr_osnap      '"' SKIP.    
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X40;K"  '"'  wText.nr_ttynap     '"' SKIP.    
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X41;K"  '"'  wText.nr_facnap     '"' SKIP.    
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X42;K"  '"'  wText.nr_othnap     '"' SKIP.
          /*---- End [A59-0613] ----*/              
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X43;K"  '"'  wText.nr_adjust    '"' SKIP. 
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X44;K"  '"'  wText.nr_intref    '"' SKIP. 
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X45;K"  '"'  wText.nr_extref    '"' SKIP. 
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X46;K"  '"'  wText.nr_agent     '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X47;K"  '"'  wText.nr_agent1    '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X48;K"  '"'  wText.nr_cedclm    '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X49;K"  '"'  wText.nr_DOCST     '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X50;K"  '"'  wText.nr_pades     '"' SKIP.
        /*A63-0417*/
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X51;K"  '"'  wText.nr_rescod     '"' SKIP. 
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X52;K"  '"'  wText.nr_resref     '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X53;K"  '"'  wText.nr_osres_v    '"' SKIP. 
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X54;K"  '"'  wText.nr_osres_nv   '"' SKIP. 
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X55;K"  '"'  wText.nr_ced_nv     '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X56;K"  '"'  wText.nr_1st_nv     '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X57;K"  '"'  wText.nr_2nd_nv     '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X58;K"  '"'  wText.nr_facri_nv   '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X59;K"  '"'  wText.nr_qs5_nv     '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X60;K"  '"'  wText.nr_tfp_nv     '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X61;K"  '"'  wText.nr_mps_nv     '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X62;K"  '"'  wText.nr_eng_nv     '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X63;K"  '"'  wText.nr_mar_nv     '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X64;K"  '"'  wText.nr_rq_nv      '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X65;K"  '"'  wText.nr_btr_nv     '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X66;K"  '"'  wText.nr_otr_nv     '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X67;K"  '"'  wText.nr_ftr_nv     '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X68;K"  '"'  wText.nr_fo1_nv     '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X69;K"  '"'  wText.nr_fo2_nv     '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X70;K"  '"'  wText.nr_fo3_nv     '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X71;K"  '"'  wText.nr_fo4_nv     '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X72;K"  '"'  wText.nr_net_nv     '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X73;K"  '"'  wtext.nr_xol_nv     '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X74;K"  '"'  wText.nr_osbh_nv    '"' SKIP.    
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X75;K"  '"'  wText.nr_ttybh_nv   '"' SKIP.    
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X76;K"  '"'  wText.nr_facbh_nv   '"' SKIP.    
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X77;K"  '"'  wText.nr_othbh_nv   '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X78;K"  '"'  wText.nr_osnap_nv    '"' SKIP.    
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X79;K"  '"'  wText.nr_ttynap_nv   '"' SKIP.    
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X80;K"  '"'  wText.nr_facnap_nv   '"' SKIP.    
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X81;K"  '"'  wText.nr_othnap_nv   '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X82;K"  '"'  nn_clicod            '"' SKIP.    
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X83;K"  '"'  nn_vat_p             '"' SKIP.

        ASSIGN nv_chkpollicy = wText.nr_CLAIM . 

        FIND FIRST wText4 WHERE wText4.nr_branch = wText2.nr_branch  AND 
            wtext4.nr_Line       = wText2.nr_line     AND
            wtext4.nr_claimcount = wText.nr_CLAIM    NO-ERROR NO-WAIT.
        IF NOT AVAIL wText4 THEN DO:
            CREATE wText4.
            ASSIGN wText4.nr_branch   = wText2.nr_branch       
                wtext4.nr_Line        = wText2.nr_line
                wText4.nr_claimcount  = wText.nr_CLAIM  .
        END.
    END.
        
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_exporttext4 C-Win 
PROCEDURE proc_exporttext4 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN  ngd_osres          =        ngd_osres        +    np_osres    
        ngd_ced            =        ngd_ced          +    np_ced      
        ngd_1st            =        ngd_1st          +    np_1st      
        ngd_2nd            =        ngd_2nd          +    np_2nd      
        ngd_facri          =        ngd_facri        +    np_facri    
        ngd_qs5            =        ngd_qs5          +    nt_qs5      
        ngd_tfp            =        ngd_tfp          +    nt_tfp      
        ngd_mps            =        ngd_mps          +    nt_mps      
        ngd_eng            =        ngd_eng          +    nt_eng      
        ngd_mar            =        ngd_mar          +    nt_mar      
        ngd_rq             =        ngd_rq           +    nt_rq       
        ngd_btr            =        ngd_btr          +    nt_btr      
        ngd_otr            =        ngd_otr          +    nt_otr      
        ngd_ftr            =        ngd_ftr          +    nt_ftr      
        ngd_fo1            =        ngd_fo1          +    nt_fo1      
        ngd_fo2            =        ngd_fo2          +    nt_fo2      
        ngd_fo3            =        ngd_fo3          +    nt_fo3      
        ngd_fo4            =        ngd_fo4          +    nt_fo4      
        ngd_ret            =        ngd_ret          +    np_ret      
        ngd_xol            =        ngd_xol          +    np_xol      
        ngd_osbh           =        ngd_osbh         +    np_osbh     
        ngd_ttybh          =        ngd_ttybh        +    np_ttybh    
        ngd_facbh          =        ngd_facbh        +    np_facbh    
        ngd_othbh          =        ngd_othbh        +    np_othbh    
        ngd_osnap          =        ngd_osnap        +    np_osnap    
        ngd_ttynap         =        ngd_ttynap       +    np_ttynap   
        ngd_facnap         =        ngd_facnap       +    np_facnap   
        ngd_othnap         =        ngd_othnap       +    np_othnap   
        ngd_osres_v        =        ngd_osres_v      +    np_osres_v  
        ngd_osres_nv       =        ngd_osres_nv     +    np_osres_nv 
        ngd_ced_nv         =        ngd_ced_nv       +    np_ced_nv   
        ngd_1st_nv         =        ngd_1st_nv       +    np_1st_nv   
        ngd_2nd_nv         =        ngd_2nd_nv       +    np_2nd_nv   
        ngd_facri_nv       =        ngd_facri_nv     +    np_facri_nv 
        ngd_qs5_nv         =        ngd_qs5_nv       +    nt_qs5_nv   
        ngd_tfp_nv         =        ngd_tfp_nv       +    nt_tfp_nv   
        ngd_mps_nv         =        ngd_mps_nv       +    nt_mps_nv   
        ngd_eng_nv         =        ngd_eng_nv       +    nt_eng_nv   
        ngd_mar_nv         =        ngd_mar_nv       +    nt_mar_nv   
        ngd_rq_nv          =        ngd_rq_nv        +    nt_rq_nv    
        ngd_btr_nv         =        ngd_btr_nv       +    nt_btr_nv   
        ngd_otr_nv         =        ngd_otr_nv       +    nt_otr_nv   
        ngd_ftr_nv         =        ngd_ftr_nv       +    nt_ftr_nv   
        ngd_fo1_nv         =        ngd_fo1_nv       +    nt_fo1_nv   
        ngd_fo2_nv         =        ngd_fo2_nv       +    nt_fo2_nv   
        ngd_fo3_nv         =        ngd_fo3_nv       +    nt_fo3_nv   
        ngd_fo4_nv         =        ngd_fo4_nv       +    nt_fo4_nv   
        ngd_ret_nv         =        ngd_ret_nv       +    np_ret_nv   
        ngd_xol_nv         =        ngd_xol_nv       +    np_xol_nv   
        ngd_osbh_nv        =        ngd_osbh_nv      +    np_osbh_nv  
        ngd_ttybh_nv       =        ngd_ttybh_nv     +    np_ttybh_nv 
        ngd_facbh_nv       =        ngd_facbh_nv     +    np_facbh_nv 
        ngd_othbh_nv       =        ngd_othbh_nv     +    np_othbh_nv 
        ngd_osnap_nv       =        ngd_osnap_nv     +    np_osnap_nv 
        ngd_ttynap_nv      =        ngd_ttynap_nv    +    np_ttynap_nv
        ngd_facnap_nv      =        ngd_facnap_nv    +    np_facnap_nv
        ngd_othnap_nv      =        ngd_othnap_nv    +    np_othnap_nv.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_exporttext5 C-Win 
PROCEDURE proc_exporttext5 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X1;K"    '"'  "Grand Total : "    '"' SKIP.            
/*PUT STREAM ns1 "C;Y" STRING(nv_row) ";X3;K"    '"'  "Line "             '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X4;K"    '"'  wText.nr_line       '"' SKIP. */
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X5;K"    '"'  "Count (All) :"      '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X6;K"    '"'  ngd_countcl          '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X15;K"   '"'  ngd_osres          '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X16;K"   '"'  ngd_ced            '"' SKIP.  
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X17;K"   '"'  ngd_1st            '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X18;K"   '"'  ngd_2nd            '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X19;K"   '"'  ngd_facri          '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X20;K"   '"'  ngd_qs5            '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X21;K"   '"'  ngd_tfp            '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X22;K"   '"'  ngd_mps            '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X23;K"   '"'  ngd_eng            '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X24;K"   '"'  ngd_mar            '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X25;K"   '"'  ngd_rq             '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X26;K"   '"'  ngd_btr            '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X27;K"   '"'  ngd_otr            '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X28;K"   '"'  ngd_ftr            '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X29;K"   '"'  ngd_fo1            '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X30;K"   '"'  ngd_fo2            '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X31;K"   '"'  ngd_fo3            '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X32;K"   '"'  ngd_fo4            '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X33;K"   '"'  ngd_ret            '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X34;K"   '"'  ngd_xol            '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X35;K"   '"'  ngd_osbh           '"' SKIP.    
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X36;K"   '"'  ngd_ttybh          '"' SKIP.    
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X37;K"   '"'  ngd_facbh          '"' SKIP.    
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X38;K"   '"'  ngd_othbh          '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X39;K"   '"'  ngd_osnap           '"' SKIP.    
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X40;K"   '"'  ngd_ttynap          '"' SKIP.    
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X41;K"   '"'  ngd_facnap          '"' SKIP.    
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X42;K"   '"'  ngd_othnap          '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X53;K"   '"'  ngd_osres_v           '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X54;K"   '"'  ngd_osres_nv           '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X55;K"   '"'  ngd_ced_nv          '"' SKIP.  
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X56;K"   '"'  ngd_1st_nv          '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X57;K"   '"'  ngd_2nd_nv          '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X58;K"   '"'  ngd_facri_nv          '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X59;K"   '"'  ngd_qs5_nv          '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X60;K"   '"'  ngd_tfp_nv          '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X61;K"   '"'  ngd_mps_nv          '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X62;K"   '"'  ngd_eng_nv          '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X63;K"   '"'  ngd_mar_nv          '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X64;K"   '"'  ngd_rq_nv          '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X65;K"   '"'  ngd_btr_nv          '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X66;K"   '"'  ngd_otr_nv          '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X67;K"   '"'  ngd_ftr_nv          '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X68;K"   '"'  ngd_fo1_nv          '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X69;K"   '"'  ngd_fo2_nv          '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X70;K"   '"'  ngd_fo3_nv          '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X71;K"   '"'  ngd_fo4_nv          '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X72;K"   '"'  ngd_ret_nv          '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X73;K"   '"'  ngd_xol_nv          '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X74;K"   '"'  ngd_osbh_nv         '"' SKIP.    
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X75;K"   '"'  ngd_ttybh_nv        '"' SKIP.    
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X76;K"   '"'  ngd_facbh_nv        '"' SKIP.    
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X77;K"   '"'  ngd_othbh_nv        '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X78;K"   '"'  ngd_osnap_nv        '"' SKIP.    
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X79;K"   '"'  ngd_ttynap_nv        '"' SKIP.    
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X80;K"   '"'  ngd_facnap_nv        '"' SKIP.    
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X81;K"   '"'  ngd_othnap_nv        '"' SKIP. 


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_exporttextcsv C-Win 
PROCEDURE proc_exporttextcsv :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_text     AS CHAR        FORMAT "x(100)" .
DEF VAR np_branch   AS CHAR        FORMAT "x(2)" .
DEF VAR np_line     AS CHAR        FORMAT "x(3)" .
FOR EACH wText3.
    DELETE wText3.
END.
FOR EACH wText4.
    DELETE wText4.
END.
If  INDEX(n_output2,".csv") = 0 THEN  n_output2  =  Trim(n_output2)  + "_copy.csv"  . 
ASSIGN 
    nv_text       = ""
    nv_count      =  0
    nv_countcl    =  0
    nv_cnt        =  0
    nv_row        =  1
    nv_chkpollicy = "" .
OUTPUT TO VALUE(n_output2).

EXPORT DELIMITER "|" 
 "Safety Insurance Public Company Limited" .
 
EXPORT DELIMITER "|" 
    "Summary of Outstanding Claim Report (Monthly)" + STRING(TODAY,"99/99/9999") .

EXPORT DELIMITER "|" 
     "This Report Print Only Claim Status = O And P   O/S = Reserve - Paid"     .
EXPORT DELIMITER "|" 
      "As of Date :" +  STRING(n_asdat,"99/99/9999")     .
EXPORT DELIMITER "|" 
    "Branch No. From : " +  nv_branfr + "To : " +  nv_branto     .

EXPORT DELIMITER "|" 
    "NO."                 
    "Claim NO."           
    "ENTRY Date"          
    "Notify Date"         
    "Loss Date"           
    "OPEN Date"           
    "Policy NO."          
    "Policy Line."        
    "Insured"             
    "TYPE"                
    "Cause OF Loss"       
    "Claimant/Claim item" 
    "O/S"                 
    "FAC"                 
    "Adjuster"            
    "Int.Surveyor"        
    "Ext. Surveyor"       
    "Producer Surveyor"   
    "Ceding Claim NO."    
    "Doc.St"              
    "Cl.Comment"  .
ASSIGN nv_reccnt = 0.

FOR EACH   wText2 NO-LOCK
    BREAK BY wText2.nr_branch 
    BY wText2.nr_Line:
    ASSIGN np_branch = ""
        np_line      = ""
        np_branch    = wText2.nr_branch 
        np_line      = wText2.nr_Line 
        np_osres     = 0
        np_facri     = 0
        np_osres70   = 0
        np_osres71   = 0
        np_osres72   = 0
        np_osres73   = 0  
        np_osres74   = 0  
        np_facri70   = 0 
        np_facri71   = 0 
        np_facri72   = 0  
        np_facri73   = 0  
        np_facri74   = 0  
        nv_count     = 0
        nv_countcl   = 0 
        nv_next      = 0
        nv_row       = nv_row + 1. 
    EXPORT DELIMITER "|" 
        "Branch : "             
        wText2.nr_branch     
        wText2.nr_branchdsp  
        "Policy Type :"      
        txtpoltyp    .
    FOR EACH wText NO-LOCK 
        WHERE wText.nr_branch = wText2.nr_branch  AND
              wText.nr_Line   = wText2.nr_Line 
        BREAK BY wText.nr_line  
              BY wText.nr_CLAIM:
        ASSIGN 
            nv_count   = nv_count  + 1
            nv_cnt     = nv_cnt    + 1
            nv_row     = nv_row    + 1 
            np_osres   = np_osres  + wText.nr_osres 
            np_facri   = np_facri  + wText.nr_facri 
            nv_reccnt  = nv_reccnt + 1 .
        DEF VAR cntop AS INT.
        IF nv_reccnt  > 60000 THEN  DO:
            ASSIGN cntop   = LENGTH(n_output2) - 4   
                nv_next    = nv_next + 1
                n_output2  = SUBSTR(n_output2,1,cntop) + "_" + STRING(nv_next) + ".csv"
                nv_reccnt  = 0
                nv_row     = 1 .
            EXPORT DELIMITER "|" 
                "Safety Insurance Public Company Limited"  .

            EXPORT DELIMITER "|" 
                 "Summary of Outstanding Claim Report (Monthly)" + STRING(TODAY,"99/99/9999") .
              
            EXPORT DELIMITER "|" 
                 "This Report Print Only Claim Status = O And P   O/S = Reserve - Paid"   .
            EXPORT DELIMITER "|" 
                 "Running of :  Class ="  +  txtpoltyp  +  "As of Date :" +  STRING(n_asdat,"99/99/9999")     .
            EXPORT DELIMITER "|" 
                 "Branch No. From : " +  nv_branfr + "To : " +  nv_branto     .
            EXPORT DELIMITER "|" 
               "NO."                   
               "Claim NO."            
               "ENTRY Date"           
               "Notify Date"          
               "Loss Date"            
               "OPEN Date"            
               "Policy NO."           
               "Line."                
               "Insured"              
               "TYPE"                 
               "Cause OF Loss"        
               "Claimant/Claim item"  
               "O/S"                  
               "FAC"                  
               "Adjuster"             
               "Int.Surveyor"         
               "Ext. Surveyor"        
               "Producer Surveyor"    
               "Ceding Claim NO."     
               "Doc.St"               
               "Cl.Comment"  .
        END.
        IF nv_chkpollicy <> wText.nr_CLAIM THEN  DO:
            EXPORT DELIMITER "|" 
                nv_count      
                wText.nr_CLAIM        
                wText.nr_entdat       
                wText.nr_notdat       
                wText.nr_LOSDAT       
                wText.nr_entdat       
                wText.nr_POLICY       
                wText.nr_line         
                wText.nr_name         
                wText.nr_LOSS         
                wText.nr_loss1        
                wText.nr_clmant_itm   
                wText.nr_osres        
                wText.nr_facri     
                wText.nr_adjust       
                wText.nr_intref       
                wText.nr_extref       
                wText.nr_agent        
                wText.nr_cedclm       
                wText.nr_DOCST        
                wText.nr_pades .  
        END.
        ELSE DO:
            nv_count = nv_count - 1.
            EXPORT DELIMITER "|" 
                ""    
                wText.nr_CLAIM        
                wText.nr_entdat       
                wText.nr_notdat       
                wText.nr_LOSDAT       
                wText.nr_entdat       
                wText.nr_POLICY       
                wText.nr_line         
                wText.nr_name         
                wText.nr_LOSS         
                wText.nr_loss1        
                wText.nr_clmant_itm   
                wText.nr_osres        
                wText.nr_facri
                wText.nr_adjust       
                wText.nr_intref       
                wText.nr_extref       
                wText.nr_agent        
                wText.nr_cedclm       
                wText.nr_DOCST        
                wText.nr_pades .  
        END.
        FIND FIRST wText4 WHERE 
            wText4.nr_branch     = wText2.nr_branch  AND 
            wtext4.nr_Line       = wText.nr_line     AND
            wtext4.nr_claimcount = wText.nr_CLAIM    NO-ERROR NO-WAIT.
        IF NOT AVAIL wText4 THEN DO:
            CREATE wText4.
            ASSIGN 
                wText4.nr_branch      = wText2.nr_branch       
                wtext4.nr_Line        = wText.nr_line
                wText4.nr_claimcount  = wText.nr_CLAIM  .
        END.
    END.
    ASSIGN nv_countcl = 0.

    FOR EACH wText4 WHERE 
        wText4.nr_branch  =  wText2.nr_branch AND 
        wtext4.nr_Line    =  wText2.nr_line NO-LOCK .
        nv_countcl = nv_countcl + 1.
    END.
    EXPORT DELIMITER "|" 
       "Total Branch : "         
      wText2.nr_branch    
      "Line "             
      wText.nr_line       
      "Count :"           
      /*nv_count    */        
      nv_countcl
      np_osres            
      np_facri . 
    EXPORT DELIMITER "|" 
        "".
    FIND FIRST wText3 WHERE wText3.nr_branch = wText2.nr_branch    NO-ERROR NO-WAIT.
    IF NOT AVAIL wText3 THEN DO:
        CREATE wText3.
        ASSIGN 
            wText3.nr_branch     =  wText2.nr_branch    
            wText3.nr_branchdsp  =  wText2.nr_branchdsp 
            wText3.nv_count      =  nv_countcl .
        IF      wText2.nr_line = "V70" THEN ASSIGN wText3.nr_osres_70 = np_osres   wText3.nr_facri_70 = np_facri.
        ELSE IF wText2.nr_line = "V71" THEN ASSIGN wText3.nr_osres_71 = np_osres   wText3.nr_facri_71 = np_facri.
        ELSE IF wText2.nr_line = "V72" THEN ASSIGN wText3.nr_osres_72 = np_osres   wText3.nr_facri_72 = np_facri.
        ELSE IF wText2.nr_line = "V73" THEN ASSIGN wText3.nr_osres_73 = np_osres   wText3.nr_facri_73 = np_facri.
        ELSE IF wText2.nr_line = "V74" THEN ASSIGN wText3.nr_osres_74 = np_osres   wText3.nr_facri_74 = np_facri.
    END.
    ELSE DO:
        IF      wText2.nr_line = "V70" THEN 
            ASSIGN  wText3.nr_osres_70 = wText3.nr_osres_70 + np_osres   
            wText3.nr_facri_70 = wText3.nr_facri_70 + np_facri
            wText3.nv_count    = wText3.nv_count + nv_countcl .
        ELSE IF wText2.nr_line = "V71" THEN 
            ASSIGN  wText3.nr_osres_71 = wText3.nr_osres_71 + np_osres   
            wText3.nr_facri_71 = wText3.nr_facri_71 + np_facri 
            wText3.nv_count    = wText3.nv_count + nv_countcl .
        ELSE IF wText2.nr_line = "V72" THEN 
            ASSIGN wText3.nr_osres_72 = wText3.nr_osres_72 + np_osres   
            wText3.nr_facri_72 = wText3.nr_facri_72 + np_facri
            wText3.nv_count    = wText3.nv_count + nv_countcl .
        ELSE IF wText2.nr_line = "V73" THEN 
            ASSIGN wText3.nr_osres_73 = wText3.nr_osres_73 + np_osres   
            wText3.nr_facri_73 = wText3.nr_facri_73 + np_facri
            wText3.nv_count    = wText3.nv_count + nv_countcl .
        ELSE IF wText2.nr_line = "V74" THEN 
            ASSIGN wText3.nr_osres_74 = wText3.nr_osres_74 + np_osres   
            wText3.nr_facri_74 = wText3.nr_facri_74 + np_facri 
            wText3.nv_count    = wText3.nv_count + nv_countcl .
    END.
    ASSIGN nv_countcl = 0.
    
END.
 
/*file summary */
ASSIGN cntop  = LENGTH(n_output2) - 5   
    n_output2  = SUBSTR(n_output2,1,cntop) + "_sum"  + ".csv"
    nv_row    = 1 .
OUTPUT TO VALUE(n_output2).
EXPORT DELIMITER "|" 
    "Safety Insurance Public Company Limited" .
EXPORT DELIMITER "|" 
      "Summary of Outstanding Claim Report (Monthly)" + STRING(TODAY,"99/99/9999") .
 
EXPORT DELIMITER "|" 
  "This Report Print Only Claim Status = O And P   O/S = Reserve - Paid"   .
ASSIGN nv_row   = nv_row + 1
       nv_text  = "Running of :  Class ="  +  txtpoltyp  +  "As of Date :" +  STRING(n_asdat,"99/99/9999")     .
EXPORT DELIMITER "|" 
       nv_text    .
ASSIGN nv_row   = nv_row + 1
       nv_text  = "Branch No. From : " +  nv_branfr + "To : " +  nv_branto     .
EXPORT DELIMITER "|"  
    nv_text  .
EXPORT DELIMITER "|" 
    "Summary By Branch "  
    "Branch"                
    "Branch Des."          
    "Count :"              
    "Count NO."             
    "O/S70"                 
    "O/S71"                 
    "O/S72"                 
    "O/S73"                 
    "O/S74"                 
    "FAC70"                 
    "FAC71"                 
    "FAC72"                 
    "FAC73"                 
    "FAC74"  .               
    ASSIGN 
    nv_row  = nv_row + 1
    np_osres70 = 0  
    np_osres72 = 0 
    np_osres73 = 0
    np_osres74 = 0
    np_facri70 = 0
    np_facri72 = 0
    np_facri73 = 0
    np_facri74 = 0 .
FOR EACH wText3 NO-LOCK .
    EXPORT DELIMITER "|" 
        " Total By Branch : "         
        wText3.nr_branch       
        wText3.nr_branchdsp    
        "Count : "             
        wText3.nv_count        
        wText3.nr_osres_70     
        wText3.nr_osres_71     
        wText3.nr_osres_72     
        wText3.nr_osres_73     
        wText3.nr_osres_74     
        wText3.nr_facri_70     
        wText3.nr_facri_71     
        wText3.nr_facri_72     
        wText3.nr_facri_73     
        wText3.nr_facri_74   .  
        ASSIGN nv_row  = nv_row + 1 
        nv_count   = nv_count   + wText3.nv_count 
        np_osres70 = np_osres70 + wText3.nr_osres_70  
        np_osres72 = np_osres72 + wText3.nr_osres_72 
        np_osres73 = np_osres73 + wText3.nr_osres_73
        np_osres74 = np_osres74 + wText3.nr_osres_74
        np_facri70 = np_facri70 + wText3.nr_facri_70
        np_facri72 = np_facri72 + wText3.nr_facri_72
        np_facri73 = np_facri73 + wText3.nr_facri_73
        np_facri74 = np_facri74 + wText3.nr_facri_74    .
END. 
EXPORT DELIMITER "|" 
    "Grand Total "  
    "Count :"       
    nv_count        
    np_osres70      
    np_osres71      
    np_osres72      
    np_osres73      
    np_osres74      
    np_facri70      
    np_facri71      
    np_facri72      
    np_facri73      
    np_facri74 .
       

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_exporttext_p C-Win 
PROCEDURE proc_exporttext_p :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

PUT STREAM ns1 "ID;PND" SKIP.  
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X1;K" '"' "Safety Insurance Public Company Limited"  '"' SKIP. 
ASSIGN nv_row   =  nv_row + 1
       nv_text  =  "Summary of Outstanding Claim Report (Monthly)" + STRING(TODAY,"99/99/9999") .
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X1;K" '"'  nv_text   '"' SKIP. 
ASSIGN nv_row   = nv_row + 1.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X1;K" '"' "This Report Print Only Claim Status = O And P   O/S = Reserve - Paid"        '"' SKIP. 
ASSIGN nv_row   = nv_row + 1
       nv_text  = "Running of :  Class ="  +  txtpoltyp  +  "As of Date :" +  STRING(n_asdat,"99/99/9999")     .
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X1;K" '"'   nv_text    '"' SKIP. 
ASSIGN nv_row   = nv_row + 1
       nv_text  = "Branch No. From : " +  nv_branfr + "To : " +  nv_branto     .
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X1;K" '"' nv_text  '"' SKIP. 
nv_row   = nv_row + 1. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X1;K"  '"'    "Summary By Branch "    '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X2;K"  '"'    "Branch"                '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X3;K"  '"'    "Branch Des."           '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X4;K"  '"'    "Count :"               '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X5;K"  '"'    "Count NO."             '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X6;K"  '"'    "O/S70"                 '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X7;K"  '"'    "O/S71"                 '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X8;K"  '"'    "O/S72"                 '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X9;K"  '"'    "O/S73"                 '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X10;K" '"'    "O/S74"                 '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X11;K" '"'    "FAC70"                 '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X12;K" '"'    "FAC71"                 '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X13;K" '"'    "FAC72"                 '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X14;K" '"'    "FAC73"                 '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X15;K" '"'    "FAC74"                 '"' SKIP.
/*- Benjaporn J. A59-0613 [14/12/2016] -*/
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X16;K" '"'    "Gross RQ BH"           '"' SKIP.    
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X17;K" '"'    "TTY RQ BH"             '"' SKIP.    
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X18;K" '"'    "Fac RQ BH"             '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X19;K" '"'    "Other RQ BH"           '"' SKIP. 
/* ----------- End [A59-0613] -------- */
ASSIGN nv_row  = nv_row + 1
    np_osres70 = 0    np_osres71 = 0   np_osres72 = 0   np_osres73 = 0
    np_osres74 = 0    np_facri70 = 0   np_facri72 = 0
    np_facri73 = 0    np_facri74 = 0   np_osbh    = 0   np_facbh   = 0.

FOR EACH wText3 NO-LOCK .
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X1;K"   '"' " Total By Branch : "   '"' SKIP.            
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X2;K"   '"' wText3.nr_branch        '"' SKIP.  
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X3;K"   '"' wText3.nr_branchdsp     '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X4;K"   '"' "Count : "              '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X5;K"   '"' wText3.nv_count         '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X6;K"   '"' wText3.nr_osres_70      '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X7;K"   '"' wText3.nr_osres_71      '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X8;K"   '"' wText3.nr_osres_72      '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X9;K"   '"' wText3.nr_osres_73      '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X10;K"  '"' wText3.nr_osres_74      '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X11;K"  '"' wText3.nr_facri_70      '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X12;K"  '"' wText3.nr_facri_71      '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X13;K"  '"' wText3.nr_facri_72      '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X14;K"  '"' wText3.nr_facri_73      '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X15;K"  '"' wText3.nr_facri_74      '"' SKIP.
    /*- Benjaporn J. A59-0613 [14/12/2016] -*/
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X16;K"  '"' wText3.nr_osbh          '"' SKIP.       
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X17;K"  '"' wText3.nr_ttybh         '"' SKIP.       
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X18;K"  '"' wText3.nr_facbh         '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X19;K"  '"' wText3.nr_othbh         '"' SKIP.
    /* ----------- End [A59-0613] -------- */

    ASSIGN nv_row  = nv_row     + 1 
        nv_count   = nv_count   + wText3.nv_count 
        np_osres70 = np_osres70 + wText3.nr_osres_70  
        np_osres71 = np_osres71 + wText3.nr_osres_71 
        np_osres72 = np_osres72 + wText3.nr_osres_72 
        np_osres73 = np_osres73 + wText3.nr_osres_73
        np_osres74 = np_osres74 + wText3.nr_osres_74
        np_facri70 = np_facri70 + wText3.nr_facri_70
        np_facri72 = np_facri72 + wText3.nr_facri_72
        np_facri73 = np_facri73 + wText3.nr_facri_73
        np_facri74 = np_facri74 + wText3.nr_facri_74 
         /*- Benjaporn J. A59-0613 [14/12/2016] -*/
        np_osbh    = np_osbh    + wText3.nr_osbh          
        np_ttybh   = np_ttybh   + wText3.nr_ttybh         
        np_facbh   = np_facbh   + wText3.nr_facbh  
        np_othbh   = np_othbh   + wText3.nr_othbh .
         /* ----------- End [A59-0613] -------- */
END. 

PUT STREAM ns1 "C;Y" STRING(nv_row) ";X3;K"   '"' "Grand Total "  '"' SKIP.            
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X4;K"   '"' "Count :"       '"' SKIP.  
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X5;K"   '"' nv_count        '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X6;K"   '"' np_osres70      '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X7;K"   '"' np_osres71      '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X8;K"   '"' np_osres72      '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X9;K"   '"' np_osres73      '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X10;K"  '"' np_osres74      '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X11;K"  '"' np_facri70      '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X12;K"  '"' np_facri71      '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X13;K"  '"' np_facri72      '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X14;K"  '"' np_facri73      '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X15;K"  '"' np_facri74      '"' SKIP.
 /*- Benjaporn J. A59-0613 [14/12/2016] -*/
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X16;K"  '"' np_osbh         '"' SKIP.      
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X17;K"  '"' np_ttybh        '"' SKIP.      
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X18;K"  '"' np_facbh        '"' SKIP.      
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X19;K"  '"' np_othbh        '"' SKIP.      
/* ----------- End [A59-0613] -------- */

OUTPUT STREAM ns1 CLOSE. 

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_wtext C-Win 
PROCEDURE proc_wtext :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND FIRST wText3 WHERE wText3.nr_branch = wText2.nr_branch    NO-ERROR NO-WAIT.
    IF NOT AVAIL wText3 THEN DO:
        CREATE wText3.
        ASSIGN wText3.nr_branch     =  wText2.nr_branch    
               wText3.nr_branchdsp  =  wText2.nr_branchdsp 
               wText3.nv_count      =  nv_countcl .

        IF      wText2.nr_line = "V70" THEN 
            ASSIGN 
            wText3.nr_osres_70 = np_osres   
            wText3.nr_facri_70 = np_facri
            /*-- Benjaporn J. A59-0613 [14/12/2016] --*/
            wText3.nr_osbh     = np_osbh   
            wText3.nr_facbh    = np_facbh  
            wText3.nr_ttybh    = np_ttybh  
            wText3.nr_othbh    = np_othbh .
            /*----  End [A59-0613] ----*/

        ELSE IF wText2.nr_line = "V71" THEN 
            ASSIGN 
            wText3.nr_osres_71 = np_osres   
            wText3.nr_facri_71 = np_facri
            /*-- Benjaporn J. A59-0613 [14/12/2016] --*/
            wText3.nr_osbh     = np_osbh   
            wText3.nr_facbh    = np_facbh  
            wText3.nr_ttybh    = np_ttybh  
            wText3.nr_othbh    = np_othbh .
            /*----  End [A59-0613] ----*/ 

        ELSE IF wText2.nr_line = "V72" THEN 
            ASSIGN 
            wText3.nr_osres_72 = np_osres 
            wText3.nr_facri_72 = np_facri
            /*-- Benjaporn J. A59-0613 [14/12/2016] --*/
            wText3.nr_osbh     = np_osbh  
            wText3.nr_facbh    = np_facbh 
            wText3.nr_ttybh    = np_ttybh 
            wText3.nr_othbh    = np_othbh .
            /*----  End [A59-0613] ----*/   


        ELSE IF wText2.nr_line = "V73" THEN 
            ASSIGN 
            wText3.nr_osres_73 = np_osres   
            wText3.nr_facri_73 = np_facri
            /*-- Benjaporn J. A59-0613 [14/12/2016] --*/
            wText3.nr_osbh     = np_osbh   
            wText3.nr_facbh    = np_facbh  
            wText3.nr_ttybh    = np_ttybh  
            wText3.nr_othbh    = np_othbh .
            /*----  End [A59-0613] ----*/  

        ELSE IF wText2.nr_line = "V74" THEN 
            ASSIGN 
            wText3.nr_osres_74 = np_osres   
            wText3.nr_facri_74 = np_facri
            /*-- Benjaporn J. A59-0613 [14/12/2016] --*/
            wText3.nr_osbh     = np_osbh   
            wText3.nr_facbh    = np_facbh  
            wText3.nr_ttybh    = np_ttybh  
            wText3.nr_othbh    = np_othbh .
            /*----  End [A59-0613] ----*/ 
    END.
    ELSE DO:
        IF  wText2.nr_line = "V70"     THEN 
            ASSIGN 
            wText3.nv_count     = wText3.nv_count    + nv_countcl 
            wText3.nr_osres_70  = wText3.nr_osres_70 + np_osres   
            wText3.nr_facri_70  = wText3.nr_facri_70 + np_facri
             /*-- Benjaporn J. A59-0613 [14/12/2016] --*/
            wText3.nr_osbh      = wText3.nr_osbh     + np_osbh      
            wText3.nr_ttybh     = wText3.nr_ttybh    + np_ttybh 
            wText3.nr_facbh     = wText3.nr_facbh    + np_facbh     
            wText3.nr_othbh     = wText3.nr_othbh    + np_othbh .  
            /*----  End [A59-0613] ----*/  

        ELSE IF wText2.nr_line = "V71" THEN 
            ASSIGN 
            wText3.nr_osres_71  = wText3.nr_osres_71 + np_osres   
            wText3.nr_facri_71  = wText3.nr_facri_71 + np_facri
            wText3.nv_count     = wText3.nv_count    + nv_countcl
            /*-- Benjaporn J. A59-0613 [14/12/2016] --*/
            wText3.nr_osbh      = wText3.nr_osbh     + np_osbh      
            wText3.nr_ttybh     = wText3.nr_ttybh    + np_ttybh 
            wText3.nr_facbh     = wText3.nr_facbh    + np_facbh     
            wText3.nr_othbh     = wText3.nr_othbh    + np_othbh .  
            /*----  End [A59-0613] ----*/ 

        ELSE IF wText2.nr_line = "V72" THEN 
            ASSIGN 
            wText3.nr_osres_72  = wText3.nr_osres_72 + np_osres   
            wText3.nr_facri_72  = wText3.nr_facri_72 + np_facri 
            wText3.nv_count     = wText3.nv_count    + nv_countcl
            /*-- Benjaporn J. A59-0613 [14/12/2016] --*/
            wText3.nr_osbh      = wText3.nr_osbh     + np_osbh      
            wText3.nr_ttybh     = wText3.nr_ttybh    + np_ttybh 
            wText3.nr_facbh     = wText3.nr_facbh    + np_facbh     
            wText3.nr_othbh     = wText3.nr_othbh    + np_othbh .  
            /*----  End [A59-0613] ----*/     

        ELSE IF wText2.nr_line = "V73" THEN 
            ASSIGN 
            wText3.nr_osres_73 = wText3.nr_osres_73 + np_osres   
            wText3.nr_facri_73 = wText3.nr_facri_73 + np_facri 
            wText3.nv_count    = wText3.nv_count    + nv_countcl
             /*-- Benjaporn J. A59-0613 [14/12/2016] --*/
            wText3.nr_osbh     = wText3.nr_osbh     + np_osbh      
            wText3.nr_ttybh    = wText3.nr_ttybh    + np_ttybh 
            wText3.nr_facbh    = wText3.nr_facbh    + np_facbh     
            wText3.nr_othbh    = wText3.nr_othbh    + np_othbh .  
            /*----  End [A59-0613] ----*/             
                                                                   
        ELSE IF wText2.nr_line = "V74" THEN 
            ASSIGN 
            wText3.nr_osres_74  = wText3.nr_osres_74 + np_osres   
            wText3.nr_facri_74  = wText3.nr_facri_74 + np_facri 
            wText3.nv_count     = wText3.nv_count    + nv_countcl
             /*-- Benjaporn J. A59-0613 [14/12/2016] --*/
            wText3.nr_osbh      = wText3.nr_osbh     + np_osbh      
            wText3.nr_ttybh     = wText3.nr_ttybh    + np_ttybh 
            wText3.nr_facbh     = wText3.nr_facbh    + np_facbh     
            wText3.nr_othbh     = wText3.nr_othbh    + np_othbh .  
            /*----  End [A59-0613] ----*/     
    END.
    ASSIGN nv_countcl = 0.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

