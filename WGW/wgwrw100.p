/*HO: GW_SAFE -LD SIC_BRAN,GW_STAT -LD BRSTAT,EXPIRY -LD SIC_EXP, SICSYAC, SICCL, STAT*/
/************************************************************************/
/* wgwrw100.p   Transfer Expiry to Gw_safe ,Gw_stat                     */
/* Dup Program  : uwt74001.p                                            */
/* Copyright	: Safety Insurance Public Company Limited 				*/
/*			  บริษัท ประกันคุ้มภัย จำกัด (มหาชน)					    */
/* CREATE BY	: Chaiyong W.   ASSIGN A61-0016 21/05/2018              */
/************************************************************************/
DEFINE NEW SHARED var sh_insref LIKE sic_bran.uwm100.insref INIT "".
DEFINE NEW SHARED var nv_duprec100  AS logi INIT NO NO-UNDO.
DEFINE NEW SHARED var nv_duprec120  AS logi INIT NO NO-UNDO.
DEFINE NEW SHARED var nv_duprec301  AS logi INIT NO NO-UNDO.
DEFINE NEW SHARED STREAM ns1.
DEFINE NEW SHARED STREAM ns2.
DEFINE NEW SHARED STREAM ns3.

DEFINE INPUT PARAMETER n_oldpol  AS CHAR INIT "".
DEFINE INPUT PARAMETER n_newpol  AS CHAR INIT "".
DEFiNE INPUT PARAMETER n_bchyr   AS INT INIT 0.
DEFiNE INPUT PARAMETER n_bchno   AS CHAR INIT "".
DEFiNE INPUT PARAMETER n_bchcnt  AS INT INIT 0.
DEFINE INPUT PARAMETER nv_branch AS CHAR INIT "".





DEFINE NEW SHARED var sh_policy LIKE sic_bran.uwm100.policy.
DEFINE NEW SHARED var sh_rencnt LIKE sic_bran.uwm100.rencnt.
DEFINE NEW SHARED var sh_endcnt LIKE sic_bran.uwm100.endcnt. 
DEFINE NEW SHARED VAR n_policy  LIKE sic_exp.UWM100.POLICY.
DEFINE NEW SHARED VAR n_renew   LIKE sic_exp.UWM100.RENCNT.
DEFINE NEW SHARED var sh_bchyr   AS INT INIT 0.    
DEFINE NEW SHARED VAR sh_bchno   AS CHAR INIT "".  
DEFINE NEW SHARED VAR sh_bchcnt  AS INT INIT 0.   


/*--
DEFINE     SHARED VAR n_polfr   LIKE sic_exp.uwm100.policy.
DEFINE     SHARED VAR n_polto   LIKE sic_exp.uwm100.policy.
DEFINE     SHARED VAR n_chgbr   AS CHAR FORMAT "X(2)".
DEFINE     SHARED VAR n_chgty   AS CHAR FORMAT "X(3)".
/*DEFINE     SHARED VAR gv_id     LIKE sic_exp._USER._USERID NO-UNDO.-- A50-0178 --*/
DEFINE     SHARED VAR gv_id AS CHAR FORMAT "X(8)" NO-UNDO. /*-- A50-0178 --*/
DEFINE     SHARED VAR n_newpol  AS CHAR FORMAT "X(12)".
DEFINE     SHARED VAR n_fpol    AS CHAR FORMAT "X(12)".
DEFINE     SHARED VAR n_lpol    AS CHAR FORMAT "X(12)".
DEFINE     SHARED VAR n_runpol  AS LOGI. */

DEFINE VAR nv_frm_policy LIKE sic_bran.uwm100.policy LABEL "From policy".
DEFINE VAR nv_to_policy  LIKE sic_bran.uwm100.policy LABEL "To policy".
/*==DEL FOLLOWING A440034==
DEFINE VAR n_dir_ri      AS CHAR FORMAT "X".
===END DEL FOLLOWING A440034===*/
/*==ADD FOLLOWING A440034==*/
DEFINE VAR n_dir_ri     AS LOGIC.
/*=END ADD FOLLOWING A440034==*/
DEFINE VAR n_number     AS CHAR FORMAT "XXXXXX".
DEFINE VAR n_day        AS INT  FORMAT "99".
DEFINE VAR n_month      AS INT  FORMAT "99".
DEFINE VAR n_year       AS INT  FORMAT "9999".
DEFINE VAR nv_frm_date  AS DATE LABEL "From date" INIT TODAY.
DEFINE VAR nv_to_date   AS DATE LABEL "To Date"   INIT TODAY.
DEFINE VAR nv_confirm   AS LOGI.
DEFINE VAR nv_int       AS INT.
DEFINE VAR nv_fptr      AS RECID.
DEFINE VAR nv_bptr      AS RECID.
DEFINE VAR nv_file      AS CHAR FORMAT "X(20)" LABEL "Update File".

DEFINE VAR putchr     AS CHAR FORMAT "X(100)" INIT "" NO-UNDO.
DEFINE VAR nv_errfile AS CHAR FORMAT "X(12)"  INIT "" NO-UNDO.
DEFINE VAR nv_brnfile AS CHAR FORMAT "X(12)"  INIT "" NO-UNDO.
DEFINE VAR nv_duprec  AS CHAR FORMAT "X(12)"  INIT "" NO-UNDO.
DEFINE VAR nv_releas  AS LOGI INIT NO NO-UNDO.
DEFINE VAR nv_time1   AS CHAR FORMAT "X(4)" init "".
DEFINE VAR nv_time2   AS INT  INIT 0.
DEFINE VAR nv_fire    AS LOGI.
DEFINE VAR n_chkpol   AS LOGI INIT YES.
DEFINE VAR n_polent   AS CHAR FORMAT "X(12)".

DEFINE STREAM str_inf.
DEFINE BUFFER wf_uwd100 FOR sic_bran.uwd100.
DEFINE BUFFER wf_uwd102 FOR sic_bran.uwd102.
DEFINE BUFFER wf_uwd103 FOR sic_bran.uwd103.
DEFINE BUFFER wf_uwd104 FOR sic_bran.uwd104.
DEFINE BUFFER wf_uwd105 FOR sic_bran.uwd105.
DEFINE BUFFER wf_uwd106 FOR sic_bran.uwd106.

/*==ADD FOLLOWING A440043===*/
DEFINE VAR n_message  AS CHARACTER  NO-UNDO.
DEFINE VAR n_undyr    AS CHAR FORMAT "X(4)".
/*=END ADD FOLLOWING A440043=*/
                             /*--
/*----A49-0013 (1)-----*/
DEFINE  SHARED VAR s_recid1  AS RECID NO-UNDO.   /* uwm100 */
DEFINE  SHARED VAR nv_policy LIKE sic_exp.uwm100.policy NO-UNDO. 
DEFINE  SHARED VAR nv_rencnt LIKE sic_exp.uwm100.rencnt NO-UNDO. 
DEFINE  SHARED VAR nv_endcnt LIKE sic_exp.uwm100.endcnt NO-UNDO. 
/*----A49-0013 (1)-----*/  */
DEFINE   VAR s_recid1  AS RECID NO-UNDO.   /* uwm100 */
DEFINE   VAR nv_policy LIKE sic_exp.uwm100.policy NO-UNDO. 
DEFINE   VAR nv_rencnt LIKE sic_exp.uwm100.rencnt NO-UNDO. 
DEFINE   VAR nv_endcnt LIKE sic_exp.uwm100.endcnt NO-UNDO. 

FORM
  nv_file SKIP
  WITH FRAME scr_beg OVERLAY CENTER ROW 19 NO-BOX.

FORM
 sic_exp.uwm100.policy sic_exp.uwm100.expdat sic_exp.uwm100.acno1 sic_exp.uwm100.name1 FORMAT "x(20)"
WITH COLOR LIGHT-YA/BLUE FRAME nf4 OVERLAY CENTERED ROW 12 1 DOWN SCROLL 1
NO-BOX NO-LABEL.

FORM
   "Renew " sic_exp.uwm100.policy " to Policy Number :" n_polent
WITH FRAME rp NO-LABEL CENTERED.
OUTPUT STREAM str_inf TO TERMINAL.

loop_main:
REPEAT:

    /*--    Add by Narin A57-0012 19/02/2014--*/
     
    nv_errfile = "C:\temp\".
     ASSIGN           
        nv_errfile = nv_errfile + "expiry"
        nv_brnfile = nv_errfile
        nv_duprec  = nv_errfile.
     /*--End Add by Narin A57-0012 19/02/2014--*/

   ASSIGN
     nv_confirm  = YES
     nv_fire     = NO
     nv_time1    = "0000"
     n_undyr = STRING(YEAR(TODAY) + 543,"9999").
   IF nv_confirm = YES THEN DO:
      nv_time2 = (INT(SUBSTRING(nv_time1,1,2)) * 3600) +
                 (INT(SUBSTRING(nv_time1,3,2)) * 60).
      IF SUBSTRING(nv_time1,1,2) > "24" or SUBSTRING(nv_time1,1,2) < "00"
      THEN DO:                             /*
         BELL.
         MESSAGE "Time (HH) is 00 -> 24".*/
         REPEAT:
            UPDATE nv_time1 WITH FRAME aa.
            IF SUBSTRING(nv_time1,1,2) > "24" or SUBSTRING(nv_time1,1,2) < "00"
            THEN DO:
               /*BELL.
               MESSAGE "Time (HH) is 00 -> 24".*/
               NEXT.
            END.
            nv_time2 = (int(SUBSTRING(nv_time1,1,2)) * 3600) +
                       (int(SUBSTRING(nv_time1,3,2)) * 60).
            HIDE FRAME aa NO-PAUSE.
            LEAVE.
         END.
         /*DISPLAY nv_time1 with fram scr_confirm.*/
      END.
      loop_time:
      REPEAT:
         IF nv_time2 < time then LEAVE loop_time.
         /*DISPLAY string(time,"HH:MM:SS") with fram bb overlay side-label.*/
         PAUSE 0.
      END.
      ASSIGN
          nv_duprec  = TRIM(nv_brnfile) + ".dup"
          nv_errfile = TRIM(nv_errfile) + ".err"
          nv_brnfile = TRIM(nv_brnfile) + ".doc".

      OUTPUT STREAM ns1 to value(nv_errfile).     /*sombat*/
      OUTPUT STREAM ns2 to value(nv_brnfile).     /*sombat*/
      OUTPUT STREAM ns3 to value(nv_duprec).      /*sombat*/

      loop_uwm100:
      FOR EACH sic_exp.uwm100 USE-INDEX uwm10001 WHERE
               sic_exp.uwm100.policy = n_oldpol  NO-LOCK:

                                                                              /*
         DISPLAY sic_exp.uwm100.policy sic_exp.uwm100.expdat
         sic_exp.uwm100.acno1 sic_exp.uwm100.name1 NO-LABEL WITH FRAME nf4. */
         PAUSE 0.

         
           
         n_policy = n_newpol.
         n_renew = 0.
         n_renew = sic_exp.uwm100.rencnt + 1.

         CREATE sic_bran.uwm100.

         /*Update data uwm100 */
         ASSIGN
           n_day   = DAY(sic_exp.uwm100.comdat)
           n_month = MONTH(sic_exp.uwm100.comdat)
           n_year  = YEAR(sic_exp.uwm100.comdat) + 1.

         ASSIGN
            sic_bran.uwm100.fptr01 = 0  sic_bran.uwm100.bptr01 = 0
            sic_bran.uwm100.fptr02 = 0  sic_bran.uwm100.bptr02 = 0
            sic_bran.uwm100.fptr03 = 0  sic_bran.uwm100.bptr03 = 0
            sic_bran.uwm100.fptr04 = 0  sic_bran.uwm100.bptr04 = 0
            sic_bran.uwm100.fptr05 = 0  sic_bran.uwm100.bptr05 = 0
            sic_bran.uwm100.fptr06 = 0  sic_bran.uwm100.bptr06 = 0
            /*----
            sic_bran.uwm100.accdat =  DATE(n_month,n_day,n_year)
            comment by Chaiyong W. A58-0411 28/01/2016*/
            sic_bran.uwm100.acctim    = sic_exp.uwm100.acctim
            sic_bran.uwm100.acno1     = sic_exp.uwm100.acno1
            sic_bran.uwm100.acno2     = sic_exp.uwm100.acno2
            sic_bran.uwm100.acno3     = sic_exp.uwm100.acno3
            sic_bran.uwm100.addr1     = sic_exp.uwm100.addr1
            sic_bran.uwm100.addr2     = sic_exp.uwm100.addr2
            sic_bran.uwm100.addr3     = sic_exp.uwm100.addr3
            sic_bran.uwm100.addr4     = sic_exp.uwm100.addr4
            sic_bran.uwm100.agent     = sic_exp.uwm100.agent
            sic_bran.uwm100.agtref    = sic_exp.uwm100.agtref
            sic_bran.uwm100.apptax    = sic_exp.uwm100.apptax
            sic_bran.uwm100.billco    = sic_exp.uwm100.billco
            sic_bran.uwm100.branch    = nv_branch.
         ASSIGN
            sic_bran.uwm100.nr_pol    = NO
            sic_bran.uwm100.cedces    = sic_exp.uwm100.cedces
            sic_bran.uwm100.cedco     = sic_exp.uwm100.cedco
            sic_bran.uwm100.cedpol    = sic_exp.uwm100.cedpol
            sic_bran.uwm100.cedsi     = sic_exp.uwm100.cedsi
            sic_bran.uwm100.cert_p    = sic_exp.uwm100.cert_p
            sic_bran.uwm100.cntry     = sic_exp.uwm100.cntry
            sic_bran.uwm100.cn_dat    = sic_exp.uwm100.cn_dat
            sic_bran.uwm100.cn_no     = sic_exp.uwm100.cn_no
            sic_bran.uwm100.cr_1      = sic_exp.uwm100.cr_1    /* Add Watsana K. [A55-0275] */
            sic_bran.uwm100.coco_t    = 0 /*sic_exp.uwm100.coco_t --A49-0013--*/
            sic_bran.uwm100.cofa_t    = 0 /*sic_exp.uwm100.cofa_t --A49-0013--*/
            sic_bran.uwm100.coins     = sic_exp.uwm100.coins
            sic_bran.uwm100.com1_t    = sic_exp.uwm100.com1_t
            sic_bran.uwm100.com2_t    = sic_exp.uwm100.com2_t
            sic_bran.uwm100.com3_t    = sic_exp.uwm100.com3_t
            sic_bran.uwm100.com4_t    = sic_exp.uwm100.com4_t
            sic_bran.uwm100.comdat    = sic_exp.uwm100.expdat
            sic_bran.uwm100.coqs_t    = 0 /*sic_exp.uwm100.coqs_t --A49-0013--*/
            sic_bran.uwm100.cost_t    = 0 /*sic_exp.uwm100.cost_t == A54-0350 Chutikarn.S ==*/
            sic_bran.uwm100.coty_t    = 0 /*sic_exp.uwm100.coty_t --A49-0013--*/
            sic_bran.uwm100.co_per    = sic_exp.uwm100.co_per
            sic_bran.uwm100.curate    = sic_exp.uwm100.curate
            sic_bran.uwm100.curbil    = sic_exp.uwm100.curbil
            sic_bran.uwm100.dept      = sic_exp.uwm100.dept
            sic_bran.uwm100.dir_ri    = sic_exp.uwm100.dir_ri
            sic_bran.uwm100.dl1cod    = sic_exp.uwm100.dl1cod
            sic_bran.uwm100.dl1sch    = sic_exp.uwm100.dl1sch
            sic_bran.uwm100.dl1_p     = sic_exp.uwm100.dl1_p
            sic_bran.uwm100.dl2cod    = sic_exp.uwm100.dl2cod
            sic_bran.uwm100.dl2red    = sic_exp.uwm100.dl2red
            sic_bran.uwm100.dl2sch    = sic_exp.uwm100.dl2sch
            sic_bran.uwm100.dl2_p     = sic_exp.uwm100.dl2_p
            sic_bran.uwm100.dl3cod    = sic_exp.uwm100.dl3cod
            sic_bran.uwm100.dl3red    = sic_exp.uwm100.dl3red
            sic_bran.uwm100.dl3sch    = sic_exp.uwm100.dl3sch
            sic_bran.uwm100.dl3_p     = sic_exp.uwm100.dl3_p
            sic_bran.uwm100.docno1    = ""
            sic_bran.uwm100.docno2    = ""
            sic_bran.uwm100.docno3    = ""
            sic_bran.uwm100.dreg_p    = sic_exp.uwm100.dreg_p
            sic_bran.uwm100.undyr     = STRING(n_year)
            sic_bran.uwm100.drnoae    = YES /*sic_exp.uwm100.drnoae*/
            sic_bran.uwm100.drn_p     = NO
            sic_bran.uwm100.bchyr     = n_bchyr
            sic_bran.uwm100.bchno     = n_bchno
            sic_bran.uwm100.bchcnt    = n_bchcnt


            n_day                  = 0
            n_month                = 0
            n_year                 = 0.

       



         ASSIGN
            n_day   = DAY(sic_bran.uwm100.comdat)
            n_month = month(sic_bran.uwm100.comdat)
            n_year  = YEAR(sic_bran.uwm100.comdat) + 1.

         ASSIGN
            sic_bran.uwm100.endcnt    = 0
            sic_bran.uwm100.enddat    = ?
            sic_bran.uwm100.endno     = ""
            /*---
            sic_bran.uwm100.enform    = sic_exp.uwm100.enform
            sic_bran.uwm100.scform    = sic_exp.uwm100.scform
            edit by jeab 11/11/2004----*/
            sic_bran.uwm100.enform    = " "
            sic_bran.uwm100.scform    = " "

            sic_bran.uwm100.entdat    = TODAY                    /*วันที่ transfer data ขึ้น alp*/
            sic_bran.uwm100.enttim    = string(time,"HH:MM:SS")  /*เวลา transfer data ขึ้น alp*/
            sic_bran.uwm100.expdat    = DATE(n_month,n_day,n_year)
            sic_bran.uwm100.finint    = sic_exp.uwm100.finint
            sic_bran.uwm100.fname     = sic_exp.uwm100.fname
            sic_bran.uwm100.fstdat    = sic_exp.uwm100.fstdat
            sic_bran.uwm100.gap_p     = sic_exp.uwm100.gap_p
            sic_bran.uwm100.insddr    = sic_exp.uwm100.insddr
            sic_bran.uwm100.insref    = sic_exp.uwm100.insref
            sic_bran.uwm100.instot    = 1
            sic_bran.uwm100.langug    = sic_exp.uwm100.langug
            sic_bran.uwm100.li_cer    = sic_exp.uwm100.li_cer
            sic_bran.uwm100.li_dr     = sic_exp.uwm100.li_dr
            sic_bran.uwm100.li_ri     = sic_exp.uwm100.li_ri
            sic_bran.uwm100.li_sch    = sic_exp.uwm100.li_sch
            sic_bran.uwm100.name1     = sic_exp.uwm100.name1
            sic_bran.uwm100.name2     = sic_exp.uwm100.name2
            sic_bran.uwm100.name3     = sic_exp.uwm100.name3
            n_day                  = 0
            n_month                = 0
            n_year                 = 0.
         ASSIGN
            sic_bran.uwm100.no_cer     = sic_exp.uwm100.no_cer
            sic_bran.uwm100.no_dr      = sic_exp.uwm100.no_dr
            sic_bran.uwm100.no_ri      = sic_exp.uwm100.no_ri
            sic_bran.uwm100.no_sch     = sic_exp.uwm100.no_sch
            sic_bran.uwm100.ntitle     = sic_exp.uwm100.ntitle
            sic_bran.uwm100.occupn     = sic_exp.uwm100.occupn
            sic_bran.uwm100.opnpol     = sic_exp.uwm100.opnpol
            sic_bran.uwm100.pdco_t     = 0 /*sic_exp.uwm100.pdco_t --A49-0013--*/
            sic_bran.uwm100.pdfa_t     = 0 /*sic_exp.uwm100.pdfa_t --A49-0013--*/
            sic_bran.uwm100.pdqs_t     = 0 /*sic_exp.uwm100.pdqs_t --A49-0013--*/
            sic_bran.uwm100.pdst_t     = 0 /*sic_exp.uwm100.pdst_t == A54-0350 Chutikarn.S ==*/
            sic_bran.uwm100.pdty_t     = 0 /*sic_exp.uwm100.pdty_t --A49-0013--*/
            sic_bran.uwm100.pfee       = sic_exp.uwm100.pfee
            sic_bran.uwm100.pmhead     = sic_exp.uwm100.pmhead
            sic_bran.uwm100.policy     = n_policy
            sic_bran.uwm100.polsta     = "IF"
            sic_bran.uwm100.poltyp     = sic_exp.uwm100.poltyp
            sic_bran.uwm100.postcd     = sic_exp.uwm100.postcd
            sic_bran.uwm100.prem_t     = sic_exp.uwm100.prem_t
            sic_bran.uwm100.prog       = sic_exp.uwm100.prog
            sic_bran.uwm100.prvpol     = sic_exp.uwm100.policy
            sic_bran.uwm100.pstp       = sic_exp.uwm100.pstp
            sic_bran.uwm100.ptax       = sic_exp.uwm100.ptax
            sic_bran.uwm100.receit     = sic_exp.uwm100.receit
            sic_bran.uwm100.recip      = sic_exp.uwm100.recip
            sic_bran.uwm100.reduc1     = sic_exp.uwm100.reduc1
            sic_bran.uwm100.reduc2     = sic_exp.uwm100.reduc2
            sic_bran.uwm100.reduc3     = sic_exp.uwm100.reduc3
            sic_bran.uwm100.reldat     = ? 
            sic_bran.uwm100.releas     = sic_exp.uwm100.releas
            sic_bran.uwm100.reltim     = ""
            sic_bran.uwm100.rencnt     = n_renew
            sic_bran.uwm100.rendat     = sic_exp.uwm100.rendat
            sic_bran.uwm100.renno      = sic_exp.uwm100.renno
            sic_bran.uwm100.renpol     = ""
            sic_bran.uwm100.rfee_t     = sic_exp.uwm100.rfee_t
            sic_bran.uwm100.rilate     = sic_exp.uwm100.rilate
            sic_bran.uwm100.ri_p       = sic_exp.uwm100.ri_p
            sic_bran.uwm100.rstp_t     = sic_exp.uwm100.rstp_t
            sic_bran.uwm100.rtax_t     = sic_exp.uwm100.rtax_t
            sic_bran.uwm100.sch_p      = NO
            sic_bran.uwm100.short      = sic_exp.uwm100.short
            sic_bran.uwm100.sico_p     = 0 /*sic_exp.uwm100.sico_p --A49-0013--*/
            sic_bran.uwm100.sifa_p     = 0 /*sic_exp.uwm100.sifa_p --A49-0013--*/
            sic_bran.uwm100.sigr_p     = sic_exp.uwm100.sigr_p
            sic_bran.uwm100.siqs_p     = 0 /*sic_exp.uwm100.siqs_p --A49-0013--*/
            sic_bran.uwm100.sist_p     = 0 /*sic_exp.uwm100.sist_p == A54-0350 Chutikarn.S ==*/
            sic_bran.uwm100.sity_p     = 0 /*sic_exp.uwm100.sity_p --A49-0013--*/
            /*==ADD FOLLOWING A440034==*/
            sic_bran.uwm100.styp20     = IF SUBSTRING(n_policy,7,1) = "P" THEN "PA" ELSE "NORM"
            /*==END ADD FOLLOWING A440034==*/
            /*==DEL FOLLOWING A440034==
            sic_bran.uwm100.styp20        = sic_exp.uwm100.styp20
              ==END DEL FOLLOWIG A440034==*/
            sic_bran.uwm100.sval20     = sic_exp.uwm100.sval20
            sic_bran.uwm100.terdat     = sic_exp.uwm100.terdat
            sic_bran.uwm100.tranty     = "R"
            sic_bran.uwm100.trndat     = TODAY
            sic_bran.uwm100.trty11     = "M"
            sic_bran.uwm100.trty12     = sic_exp.uwm100.trty12
            sic_bran.uwm100.trty13     = sic_exp.uwm100.trty13
            sic_bran.uwm100.usrid      = USERID(LDBNAME(1))
            sic_bran.uwm100.usridr     = ""
            sic_bran.uwm100.gstrat     = sic_exp.uwm100.gstrat
            sic_bran.uwm100.anam1      = sic_exp.uwm100.anam1 
            
                
            .

         /*---Begin by Chaiyong W. A58-0411 28/01/2016*/
         IF sic_bran.uwm100.comdat >= TODAY THEN
             ASSIGN
                n_day   = DAY(sic_bran.uwm100.trndat)
                n_month = month(sic_bran.uwm100.trndat)
                n_year  = YEAR(sic_bran.uwm100.trndat).
         ELSE
             ASSIGN
                 n_day   = DAY(sic_exp.uwm100.comdat)
                 n_month = MONTH(sic_exp.uwm100.comdat)
                 n_year  = YEAR(sic_exp.uwm100.comdat) + 1.

         sic_bran.uwm100.accdat    = DATE(n_month,n_day,n_year).
         /*End by Chaiyong W. A58-0411 28/01/2016-----*/



         /*----A49-0013 (2)--------------*/
         ASSIGN
            s_recid1  = RECID(sic_bran.uwm100)
            nv_policy = sic_bran.uwm100.policy
            nv_rencnt = sic_bran.uwm100.rencnt
            nv_endcnt = sic_bran.uwm100.endcnt.
         /*-------------A49-0013 (2)-----*/

         /*---
         ASSIGN
            sic_exp.uwm100.renpol  = n_policy
            sic_exp.uwm100.polsta  = "RW"
            sic_exp.uwm100.usridr  = gv_id.
        ----*/
         PUT STREAM ns2
             sic_exp.uwm100.policy
             sic_exp.uwm100.rencnt "/"
             sic_exp.uwm100.endcnt " "
             sic_exp.uwm100.trndat " "
             sic_exp.uwm100.usrid " Entdat " sic_exp.uwm100.entdat
             today  FORMAT "99/99/9999" " "
             string(time,"HH:MM:SS") " ".

            /*End Update uwm100 */

         /* Add, Update uwd100 */
         nv_fptr = sic_exp.uwm100.fptr01.
         nv_bptr = 0.
         DO WHILE nv_fptr <> 0 and sic_exp.uwm100.fptr01 <> ? :
            FIND sic_exp.uwd100 where recid(sic_exp.uwd100) = nv_fptr
            NO-LOCK NO-ERROR.
            IF AVAILABLE sic_exp.uwd100 THEN DO: /*sombat */
              nv_fptr = sic_exp.uwd100.fptr.
              CREATE sic_bran.uwd100.
              ASSIGN
                sic_bran.uwd100.bptr      = nv_bptr
                sic_bran.uwd100.endcnt    = 0
                sic_bran.uwd100.fptr      = 0
                sic_bran.uwd100.ltext     = sic_exp.uwd100.ltext
                sic_bran.uwd100.policy    = n_policy
                sic_bran.uwd100.rencnt    = n_renew /*
                sic_bran.uwd100.bchyr     = sic_bran.uwm100.bchyr      
                sic_bran.uwd100.bchno     = sic_bran.uwm100.bchno      
                sic_bran.uwd100.bchcnt    = sic_bran.uwm100.bchcnt     */
                  
                  .
              IF nv_bptr <> 0 THEN DO:
                FIND wf_uwd100 where recid(wf_uwd100) = nv_bptr.
                wf_uwd100.fptr = recid(sic_bran.uwd100).
              END.
              IF nv_bptr = 0 then  sic_bran.uwm100.fptr01 = recid(sic_bran.uwd100).
              nv_bptr = recid(sic_bran.uwd100).
            END.
            ELSE DO:    /*sombat*/
              HIDE MESSAGE NO-PAUSE.                            /*
              MESSAGE "not found " sic_exp.uwd100.policy sic_exp.uwd100.rencnt "/"
                       sic_exp.uwd100.endcnt "on file uwd100".*/
              putchr = "".
              putchr = "not found " + sic_exp.uwd100.policy +
                       " R/E " + STRING(sic_exp.uwd100.rencnt,"99")  +
                       "/"     + STRING(sic_exp.uwd100.endcnt,"999") +
                       " on file uwd100 Policy Upper Text".
              PUT STREAM ns1 putchr FORMAT "x(100)" SKIP.
              LEAVE.
            END.
         END. /* End DO nv_fptr */
         sic_bran.uwm100.bptr01 = nv_bptr.

         /* Add, Update uwd102 */
         nv_fptr = sic_exp.uwm100.fptr02.
         nv_bptr = 0.
         DO WHILE nv_fptr <> 0 and sic_exp.uwm100.fptr02 <> ? :
            FIND sic_exp.uwd102 where recid(sic_exp.uwd102) = nv_fptr
            NO-LOCK NO-ERROR.
            IF AVAILABLE sic_exp.uwd102 THEN DO: /*sombat */
               nv_fptr = sic_exp.uwd102.fptr.
               CREATE sic_bran.uwd102.
               ASSIGN
                  sic_bran.uwd102.bptr      = nv_bptr
                  sic_bran.uwd102.endcnt    = 0
                  sic_bran.uwd102.fptr      = 0
                  sic_bran.uwd102.ltext     = sic_exp.uwd102.ltext
                  sic_bran.uwd102.policy    = n_policy
                  sic_bran.uwd102.rencnt    = n_renew /*
                  sic_bran.uwd102.bchyr     = sic_bran.uwm100.bchyr      
                  sic_bran.uwd102.bchno     = sic_bran.uwm100.bchno      
                  sic_bran.uwd102.bchcnt    = sic_bran.uwm100.bchcnt */  .
               IF nv_bptr <> 0 THEN DO:
                  FIND wf_uwd102 where recid(wf_uwd102) = nv_bptr.
                  wf_uwd102.fptr = recid(sic_bran.uwd102).
               END.
               IF nv_bptr = 0 then  sic_bran.uwm100.fptr02 = recid(sic_bran.uwd102).
               nv_bptr = recid(sic_bran.uwd102).
            END.
            ELSE DO:    /*sombat*/
               HIDE MESSAGE NO-PAUSE.                            /*
               MESSAGE "not found " sic_exp.uwd102.policy sic_exp.uwd102.rencnt "/"
                        sic_exp.uwd102.endcnt "on file uwd102".*/
               putchr = "".
               putchr = "not found " + sic_exp.uwd102.policy +
                        " R/E " + STRING(sic_exp.uwd102.rencnt,"99")  +
                        "/"     + STRING(sic_exp.uwd102.endcnt,"999") +
                        " on file uwd102 Policy Memo Text".

               PUT STREAM ns1 putchr FORMAT "x(100)" SKIP.
               LEAVE.
            END.
         END. /* End DO nv_fptr */
         sic_bran.uwm100.bptr02 = nv_bptr.

         /* Add, Update uwd105 */
         nv_fptr = sic_exp.uwm100.fptr03.
         nv_bptr = 0.
         DO WHILE nv_fptr <> 0 and sic_exp.uwm100.fptr03 <> ? :
            FIND sic_exp.uwd105 where recid(sic_exp.uwd105) = nv_fptr
            NO-LOCK NO-ERROR.
            IF AVAILABLE sic_exp.uwd105 THEN DO:
               nv_fptr = sic_exp.uwd105.fptr.
               CREATE sic_bran.uwd105.
               ASSIGN
                  sic_bran.uwd105.bptr     = nv_bptr
                  sic_bran.uwd105.clause   = sic_exp.uwd105.clause
                  sic_bran.uwd105.endcnt   = 0 
                  sic_bran.uwd105.fptr     = 0 
                  sic_bran.uwd105.policy   = n_policy
                  sic_bran.uwd105.rencnt   = n_renew  /*
                  sic_bran.uwd105.bchyr     = sic_bran.uwm100.bchyr      
                  sic_bran.uwd105.bchno     = sic_bran.uwm100.bchno      
                  sic_bran.uwd105.bchcnt    = sic_bran.uwm100.bchcnt */  .

               IF nv_bptr <> 0 THEN DO:
                  FIND wf_uwd105 where recid(wf_uwd105) = nv_bptr NO-ERROR.
                     wf_uwd105.fptr = recid(sic_bran.uwd105).
               END.
               IF nv_bptr = 0 then  sic_bran.uwm100.fptr03 = recid(sic_bran.uwd105).
                  nv_bptr = recid(sic_bran.uwd105).
            END.
            ELSE DO:
               HIDE MESSAGE NO-PAUSE.                            /*
               MESSAGE "not found " sic_exp.uwd105.policy sic_exp.uwd105.rencnt "/"
                        sic_exp.uwd105.endcnt "on file uwd105".*/
               putchr = "".
               putchr = "not found " + sic_exp.uwd105.policy +
                        " R/E " + STRING(sic_exp.uwd105.rencnt,"99")  +
                        "/"     + STRING(sic_exp.uwd105.endcnt,"999") +
                       " on file uwd105 Policy Clauses".
               PUT STREAM ns1 putchr FORMAT "x(100)" SKIP.
               LEAVE.
            END.
         END. /* End DO nv_fptr */
         sic_bran.uwm100.bptr03 = nv_bptr.


         /* Add, Update uwd103 */
         nv_fptr = sic_exp.uwm100.fptr04.
         nv_bptr = 0.
         DO WHILE nv_fptr <> 0 and sic_exp.uwm100.fptr04 <> ? :
            FIND sic_exp.uwd103 where recid(sic_exp.uwd103) = nv_fptr
            NO-LOCK NO-ERROR.
            IF AVAILABLE sic_exp.uwd103 THEN DO:
               nv_fptr = sic_exp.uwd103.fptr.
               CREATE sic_bran.uwd103.
               ASSIGN
                  sic_bran.uwd103.bptr    = nv_bptr
                  sic_bran.uwd103.endcnt  = 0
                  sic_bran.uwd103.fptr    = 0
                  sic_bran.uwd103.ltext   = sic_exp.uwd103.ltext
                  sic_bran.uwd103.policy  = n_policy
                  sic_bran.uwd103.rencnt  = n_renew  /*
                  sic_bran.uwd103.bchyr     = sic_bran.uwm100.bchyr      
                  sic_bran.uwd103.bchno     = sic_bran.uwm100.bchno      
                  sic_bran.uwd103.bchcnt    = sic_bran.uwm100.bchcnt */  .

               IF nv_bptr <> 0 THEN DO:
                  FIND wf_uwd103 where recid(wf_uwd103) = nv_bptr.
                  wf_uwd103.fptr = recid(sic_bran.uwd103).
               END.
               IF nv_bptr = 0 then  sic_bran.uwm100.fptr04 = recid(sic_bran.uwd103).
               nv_bptr = recid(sic_bran.uwd103).
            END.
            ELSE DO:    /*sombat*/
               HIDE MESSAGE NO-PAUSE.                            /*
               MESSAGE "not found " sic_exp.uwd103.policy sic_exp.uwd103.rencnt "/"
                        sic_exp.uwd103.endcnt "on file uwd103".*/
               putchr = "".
               putchr = "not found " + sic_exp.uwd103.policy +
                        " R/E " + STRING(sic_exp.uwd103.rencnt,"99")  +
                        "/"     + STRING(sic_exp.uwd103.endcnt,"999") +
                        " on file uwd103 Policy Renewal Text".
               PUT STREAM ns1 putchr FORMAT "x(100)" SKIP.
               LEAVE.
            END.
         END. /* End DO nv_fptr */
         sic_bran.uwm100.bptr04 = nv_bptr.

         ASSIGN
           sh_policy = sic_exp.uwm100.policy
           sh_rencnt = sic_exp.uwm100.rencnt
           sh_endcnt = sic_exp.uwm100.endcnt
           sh_insref = sic_exp.uwm100.insref
           sh_bchyr  = n_bchyr  
           sh_bchno  = n_bchno  
           sh_bchcnt = n_bchcnt   
             
             
             
             
             .

         /* Risk Header */
         RUN wgw\wgwrw120.
         /* Insured Item */
         RUN wgw\wgwrw130.
         /* RI Out Header */
         /*RUN "uw/uwr70200". === Comment By Chutikarn.S A54-0350 */
         /* Cargo Risk Details */
         RUN wgw\wgwrw300.
         /* Motor Vehicle */
         RUN wgw\wgwrw301.
         /* Fire Risk */
         RUN wgw\wgwrw304.        /* Has Record */
         /* Bond Risk */
         RUN wgw\wgwrw305.  
         /* Printed NCB Letted */
         RUN wgw\wgwrw306. 
         /* Driver Name */
         RUN wgw\wgwrwdri(INPUT sic_exp.uwm100.policy,
                                sic_exp.uwm100.rencnt,
                                sic_exp.uwm100.endcnt,
                                sic_bran.uwm100.policy,
                                sic_bran.uwm100.rencnt,
                                sic_bran.uwm100.endcnt).
         /* Personal Accident*/
         RUN wgw\wgwrw307. 
         sh_insref = sic_exp.uwm100.insref.
         PUT STREAM ns2
                  STRING(TIME,"HH:MM:SS") " "
                  TRIM(TRIM(sic_exp.uwm100.ntitle) + " " +
                  TRIM(sic_exp.uwm100.name1)) FORMAT "X(60)" SKIP.


     /*---
     /* prasopsuk  29/09/1998*/
      FIND LAST sic_bran.uwm100 where sic_bran.uwm100.policy = sic_exp.uwm100.policy
                NO-ERROR.
      IF NOT AVAIL sic_bran.uwm100  THEN
          ASSIGN
            sic_bran.uwm100.renpol = n_policy.

     -----end----------------------*/

         /*---
         FOR EACH sic_bran.uwm100 WHERE sic_bran.uwm100.policy = sic_exp.uwm100.policy :
            sic_bran.uwm100.renpol    = n_policy.
         END.
         comment by Chaiyong W. NTL*/

      END. /* End for sic_exp uwm100 */

      OUTPUT STREAM ns1 CLOSE.
      OUTPUT STREAM ns2 CLOSE.
      OUTPUT STREAM ns3 CLOSE.
      LEAVE.
  END. /* End confirm = Yes */
END.
HIDE MESSAGE NO-PAUSE.
OUTPUT CLOSE.
HIDE FRAME rp  NO-PAUSE.
HIDE FRAME nf4 NO-PAUSE.
HIDE FRAME scr_beg NO-PAUSE.

/* End of : uwt74001.p */

