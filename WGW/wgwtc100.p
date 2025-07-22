/* WGWTC100.p */
/*
   Sombat Phu. : 26/04/2003
   Description : Transfer data from Brach to Branch
                 brsic_bran ->  sic_bran
                 brstat     ->  stat
   Modify  by  : sombat 04/03/1998
                 Transfer data path frame realay
                 change name host to sicuw
   Modify by : Narin 19/10/2010    <A52-0242>
   สรุปหลักการ Connect Database GW  และ Database local 
   1. DATABASE GW  ที่ CONNECT ได้ ให้ทำการ DISCONNECT ออก SIC_BRAN  กับ  BRSTAT
      และ ทำการ Conncet database : gw_safe  &  gw_stat
          sic_bran  
          brstat    --->  gw_stat
   2. DATABASE Local Connect ดังนี้ 
          bransafe --->  -ld  brsic_bran
          brstat   --->  -ld  brstat
*/

def     shared var sh_policy     like sic_bran.uwm100.policy.
def     shared var sh_rencnt     like sic_bran.uwm100.rencnt.
def     shared var sh_endcnt     like sic_bran.uwm100.endcnt.

def     shared var nv_duprec100  as logi init no no-undo.
def     shared var nv_duprec120  as logi init no no-undo.
def     shared var nv_duprec301  as logi init no no-undo.
def            var nv_brsic_bran as inte init 0  no-undo.
def            var nv_host       as inte init 0  no-undo.

def            var nv_fptr       as   recid.

find first brsic_bran.uwm100 where
     brsic_bran.uwm100.policy = sh_policy and
     brsic_bran.uwm100.rencnt = sh_rencnt and
     brsic_bran.uwm100.endcnt = sh_endcnt
no-error.

find first sic_bran.uwm100 where
     sic_bran.uwm100.policy = sh_policy and
     sic_bran.uwm100.rencnt = sh_rencnt and
     sic_bran.uwm100.endcnt = sh_endcnt 
no-error.

if not avail sic_bran.uwm100 then do:
  IF LOCKED sic_bran.uwm100 THEN DO:
    BELL.
    HIDE MESSAGE NO-PAUSE.
    MESSAGE "Policy no." sh_policy "R/E" sh_rencnt sh_endcnt
            "is Lock by another".
    PAUSE 3 NO-MESSAGE.

    nv_duprec100 = YES.
    RETURN.
  END.
end.
loop_chk:
repeat:
  if sic_bran.uwm100.accdat <>  brsic_bran.uwm100.accdat  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.acctim <>  brsic_bran.uwm100.acctim  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.acno1  <>  brsic_bran.uwm100.acno1   then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.acno2  <>  brsic_bran.uwm100.acno2   then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.acno3  <>  brsic_bran.uwm100.acno3   then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.addr1  <>  brsic_bran.uwm100.addr1   then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.addr2  <>  brsic_bran.uwm100.addr2   then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.addr3  <>  brsic_bran.uwm100.addr3   then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.addr4  <>  brsic_bran.uwm100.addr4   then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.agent  <>  brsic_bran.uwm100.agent   then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.agtref <>  brsic_bran.uwm100.agtref  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.apptax <>  brsic_bran.uwm100.apptax  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.billco <>  brsic_bran.uwm100.billco  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.branch <>  brsic_bran.uwm100.branch  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.cedces <>  brsic_bran.uwm100.cedces  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.cedco  <>  brsic_bran.uwm100.cedco   then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.cedpol <>  brsic_bran.uwm100.cedpol  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.cedsi  <>  brsic_bran.uwm100.cedsi   then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.cert_p <>  brsic_bran.uwm100.cert_p  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.cntry  <>  brsic_bran.uwm100.cntry   then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.cn_dat <>  brsic_bran.uwm100.cn_dat  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.cn_no  <>  brsic_bran.uwm100.cn_no   then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.coco_t <>  brsic_bran.uwm100.coco_t  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.cofa_t <>  brsic_bran.uwm100.cofa_t  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.coins  <>  brsic_bran.uwm100.coins   then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.com1_t <>  brsic_bran.uwm100.com1_t  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.com2_t <>  brsic_bran.uwm100.com2_t  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.com3_t <>  brsic_bran.uwm100.com3_t  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.com4_t <>  brsic_bran.uwm100.com4_t  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.comdat <>  brsic_bran.uwm100.comdat  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.coqs_t <>  brsic_bran.uwm100.coqs_t  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.cost_t <>  brsic_bran.uwm100.cost_t  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.coty_t <>  brsic_bran.uwm100.coty_t  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.co_per <>  brsic_bran.uwm100.co_per  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.curate <>  brsic_bran.uwm100.curate  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.curbil <>  brsic_bran.uwm100.curbil  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.dept   <>  brsic_bran.uwm100.dept    then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.dir_ri <>  brsic_bran.uwm100.dir_ri  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.dl1cod <>  brsic_bran.uwm100.dl1cod  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.dl1sch <>  brsic_bran.uwm100.dl1sch  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.dl1_p  <>  brsic_bran.uwm100.dl1_p   then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.dl2cod <>  brsic_bran.uwm100.dl2cod  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.dl2red <>  brsic_bran.uwm100.dl2red  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.dl2sch <>  brsic_bran.uwm100.dl2sch  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.dl2_p  <>  brsic_bran.uwm100.dl2_p   then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.dl3cod <>  brsic_bran.uwm100.dl3cod  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.dl3red <>  brsic_bran.uwm100.dl3red  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.dl3sch <>  brsic_bran.uwm100.dl3sch  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.dl3_p  <>  brsic_bran.uwm100.dl3_p   then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.docno1 <>  brsic_bran.uwm100.docno1  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.docno2 <>  brsic_bran.uwm100.docno2  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.docno3 <>  brsic_bran.uwm100.docno3  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.dreg_p <>  brsic_bran.uwm100.dreg_p  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.drnoae <>  brsic_bran.uwm100.drnoae  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.drn_p  <>  brsic_bran.uwm100.drn_p   then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.endcnt <>  brsic_bran.uwm100.endcnt  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.enddat <>  brsic_bran.uwm100.enddat  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.endno  <>  brsic_bran.uwm100.endno   then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.enform <>  brsic_bran.uwm100.enform  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.entdat <>  brsic_bran.uwm100.entdat  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.enttim <>  brsic_bran.uwm100.enttim  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.expdat <>  brsic_bran.uwm100.expdat  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.finint <>  brsic_bran.uwm100.finint  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.fname  <>  brsic_bran.uwm100.fname   then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.fstdat <>  brsic_bran.uwm100.fstdat  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.gap_p  <>  brsic_bran.uwm100.gap_p   then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.insddr <>  brsic_bran.uwm100.insddr  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.insref <>  brsic_bran.uwm100.insref  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.instot <>  brsic_bran.uwm100.instot  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.langug <>  brsic_bran.uwm100.langug  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.li_cer <>  brsic_bran.uwm100.li_cer  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.li_dr  <>  brsic_bran.uwm100.li_dr   then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.li_ri  <>  brsic_bran.uwm100.li_ri   then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.li_sch <>  brsic_bran.uwm100.li_sch  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.name1  <>  brsic_bran.uwm100.name1   then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.name2  <>  brsic_bran.uwm100.name2   then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.name3  <>  brsic_bran.uwm100.name3   then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.no_cer <>  brsic_bran.uwm100.no_cer  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.no_dr  <>  brsic_bran.uwm100.no_dr   then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.no_ri  <>  brsic_bran.uwm100.no_ri   then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.no_sch <>  brsic_bran.uwm100.no_sch  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.ntitle <>  brsic_bran.uwm100.ntitle  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.occupn <>  brsic_bran.uwm100.occupn  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.opnpol <>  brsic_bran.uwm100.opnpol  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.pdco_t <>  brsic_bran.uwm100.pdco_t  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.pdfa_t <>  brsic_bran.uwm100.pdfa_t  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.pdqs_t <>  brsic_bran.uwm100.pdqs_t  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.pdst_t <>  brsic_bran.uwm100.pdst_t  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.pdty_t <>  brsic_bran.uwm100.pdty_t  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.pfee   <>  brsic_bran.uwm100.pfee    then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.pmhead <>  brsic_bran.uwm100.pmhead  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.policy <>  brsic_bran.uwm100.policy  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.polsta <>  brsic_bran.uwm100.polsta  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.poltyp <>  brsic_bran.uwm100.poltyp  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.postcd <>  brsic_bran.uwm100.postcd  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.prem_t <>  brsic_bran.uwm100.prem_t  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.prog   <>  brsic_bran.uwm100.prog    then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.prvpol <>  brsic_bran.uwm100.prvpol  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.pstp   <>  brsic_bran.uwm100.pstp    then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.ptax   <>  brsic_bran.uwm100.ptax    then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.receit <>  brsic_bran.uwm100.receit  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.recip  <>  brsic_bran.uwm100.recip   then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.reduc1 <>  brsic_bran.uwm100.reduc1  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.reduc2 <>  brsic_bran.uwm100.reduc2  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.reduc3 <>  brsic_bran.uwm100.reduc3  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.reldat <>  brsic_bran.uwm100.reldat  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.releas <>  brsic_bran.uwm100.releas  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.reltim <>  brsic_bran.uwm100.reltim  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.rencnt <>  brsic_bran.uwm100.rencnt  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.rendat <>  brsic_bran.uwm100.rendat  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.renno  <>  brsic_bran.uwm100.renno   then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.renpol <>  brsic_bran.uwm100.renpol  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.rfee_t <>  brsic_bran.uwm100.rfee_t  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.rilate <>  brsic_bran.uwm100.rilate  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.ri_p   <>  brsic_bran.uwm100.ri_p    then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.rstp_t <>  brsic_bran.uwm100.rstp_t  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.rtax_t <>  brsic_bran.uwm100.rtax_t  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.scform <>  brsic_bran.uwm100.scform  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.sch_p  <>  brsic_bran.uwm100.sch_p   then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.sckno  <>  brsic_bran.uwm100.sckno   then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.short  <>  brsic_bran.uwm100.short   then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.sico_p <>  brsic_bran.uwm100.sico_p  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.sifa_p <>  brsic_bran.uwm100.sifa_p  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.sigr_p <>  brsic_bran.uwm100.sigr_p  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.siqs_p <>  brsic_bran.uwm100.siqs_p  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.sist_p <>  brsic_bran.uwm100.sist_p  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.sity_p <>  brsic_bran.uwm100.sity_p  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.styp20 <>  brsic_bran.uwm100.styp20  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.sval20 <>  brsic_bran.uwm100.sval20  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.terdat <>  brsic_bran.uwm100.terdat  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.tranty <>  brsic_bran.uwm100.tranty  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.trndat <>  brsic_bran.uwm100.trndat  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.trty11 <>  brsic_bran.uwm100.trty11  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.trty12 <>  brsic_bran.uwm100.trty12  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.trty13 <>  brsic_bran.uwm100.trty13  then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.undyr  <>  brsic_bran.uwm100.undyr   then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.usrid  <>  brsic_bran.uwm100.usrid   then do:
     nv_duprec100 = no. leave loop_chk. end.
  if sic_bran.uwm100.usridr <>  brsic_bran.uwm100.usridr  then do:
     nv_duprec100 = no. leave loop_chk. end.

  nv_duprec100 = yes.
  leave loop_chk.

end.

/* end off : WGWTC100.p */
