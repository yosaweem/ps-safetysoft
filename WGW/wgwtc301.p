/* CHUWM301.P */
/*
   Sombat Phu. : 26/04/2003
   Description : Transfer data from Brach to Branch
                 brsic_bran ->  sic_bran
                 brstat     ->  stat
   Modify  by  : sombat 04/03/1998
                 Transfer data path frame realay
                 change name host to sicuw
*/

def     shared var sh_policy like sic_bran.uwm100.policy.
def     shared var sh_rencnt like sic_bran.uwm100.rencnt.
def     shared var sh_endcnt like sic_bran.uwm100.endcnt.

def     shared var nv_duprec100  as logi init no no-undo.
def     shared var nv_duprec120  as logi init no no-undo.
def     shared var nv_duprec301  as logi init no no-undo.
def            var nv_brsic_bran     as inte init 0  no-undo.
def            var nv_host       as inte init 0  no-undo.

FOR EACH brsic_bran.uwm301 WHERE 
         brsic_bran.uwm301.policy = sh_policy AND
         brsic_bran.uwm301.rencnt = sh_rencnt AND
         brsic_bran.uwm301.endcnt = sh_endcnt
NO-LOCK:
  nv_brsic_bran = nv_brsic_bran + 1.
END.

FOR EACH sic_bran.uwm301 WHERE
         sic_bran.uwm301.policy = sh_policy AND
         sic_bran.uwm301.rencnt = sh_rencnt AND
         sic_bran.uwm301.endcnt = sh_endcnt
NO-LOCK:
  nv_host = nv_host + 1.
END.
IF nv_host <> nv_brsic_bran THEN DO:
  FOR EACH sic_bran.uwm301 WHERE
           sic_bran.uwm301.policy = sh_policy AND
           sic_bran.uwm301.rencnt = sh_rencnt AND
           sic_bran.uwm301.endcnt = sh_endcnt :
     delete sic_bran.uwm301.
  END.
  nv_duprec100 = no.
END.
ELSE DO:
  nv_duprec100 = YES.

  FOR EACH brsic_bran.uwm301 WHERE
           brsic_bran.uwm301.policy = sh_policy AND
           brsic_bran.uwm301.rencnt = sh_rencnt AND
           brsic_bran.uwm301.endcnt = sh_endcnt
  NO-LOCK:

    FIND FIRST sic_bran.uwm301 WHERE
         sic_bran.uwm301.policy = brsic_bran.uwm301.policy AND
         sic_bran.uwm301.rencnt = brsic_bran.uwm301.rencnt AND
         sic_bran.uwm301.endcnt = brsic_bran.uwm301.endcnt AND
         sic_bran.uwm301.riskgp = brsic_bran.uwm301.riskgp AND
         sic_bran.uwm301.riskno = brsic_bran.uwm301.riskno AND
         sic_bran.uwm301.itemno = brsic_bran.uwm301.itemno
    NO-ERROR.

    IF NOT AVAILABLE sic_bran.uwm301 THEN DO:
      nv_duprec100 = no.
      LEAVE.
    END.

    if sic_bran.uwm301.covcod       <> brsic_bran.uwm301.covcod  
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.modcod       <> brsic_bran.uwm301.modcod
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.vehreg       <> brsic_bran.uwm301.vehreg
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.eng_no       <> brsic_bran.uwm301.eng_no
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.cha_no       <> brsic_bran.uwm301.cha_no
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.yrmanu       <> brsic_bran.uwm301.yrmanu
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.vehuse       <> brsic_bran.uwm301.vehuse
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.ncbyrs       <> brsic_bran.uwm301.ncbyrs
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.ncbper       <> brsic_bran.uwm301.ncbper
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.tariff       <> brsic_bran.uwm301.tariff
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.drinam[1]    <> brsic_bran.uwm301.drinam[1]
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.drinam[2]    <> brsic_bran.uwm301.drinam[2]
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.drinam[3]    <> brsic_bran.uwm301.drinam[3]
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.drinam[4]    <> brsic_bran.uwm301.drinam[4]
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.drinam[5]    <> brsic_bran.uwm301.drinam[5]
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.drinam[6]    <> brsic_bran.uwm301.drinam[6]
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.drinam[7]    <> brsic_bran.uwm301.drinam[7]
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.drinam[8]    <> brsic_bran.uwm301.drinam[8]
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.drinam[9]    <> brsic_bran.uwm301.drinam[9]
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.drinam[10]   <> brsic_bran.uwm301.drinam[10]
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.driage[1]    <> brsic_bran.uwm301.driage[1]
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.driage[2]    <> brsic_bran.uwm301.driage[2]
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.driage[3]    <> brsic_bran.uwm301.driage[3]
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.driage[4]    <> brsic_bran.uwm301.driage[4]
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.driage[5]    <> brsic_bran.uwm301.driage[5]
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.driage[6]    <> brsic_bran.uwm301.driage[6]
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.driage[7]    <> brsic_bran.uwm301.driage[7]
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.driage[8]    <> brsic_bran.uwm301.driage[8]
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.driage[9]    <> brsic_bran.uwm301.driage[9]
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.driage[10]   <> brsic_bran.uwm301.driage[10]
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.driexp[1]    <> brsic_bran.uwm301.driexp[1]
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.driexp[2]    <> brsic_bran.uwm301.driexp[2]
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.driexp[3]    <> brsic_bran.uwm301.driexp[3]
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.driexp[4]    <> brsic_bran.uwm301.driexp[4]
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.driexp[5]    <> brsic_bran.uwm301.driexp[5]
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.driexp[6]    <> brsic_bran.uwm301.driexp[6]
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.driexp[7]    <> brsic_bran.uwm301.driexp[7]
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.driexp[8]    <> brsic_bran.uwm301.driexp[8]
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.driexp[9]    <> brsic_bran.uwm301.driexp[9]
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.driexp[10]   <> brsic_bran.uwm301.driexp[10]
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.dridip[1]    <> brsic_bran.uwm301.dridip[1]
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.dridip[2]    <> brsic_bran.uwm301.dridip[2]
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.dridip[3]    <> brsic_bran.uwm301.dridip[3]
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.dridip[4]    <> brsic_bran.uwm301.dridip[4]
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.dridip[5]    <> brsic_bran.uwm301.dridip[5]
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.dridip[6]    <> brsic_bran.uwm301.dridip[6]
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.dridip[7]    <> brsic_bran.uwm301.dridip[7]
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.dridip[8]    <> brsic_bran.uwm301.dridip[8]
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.dridip[9]    <> brsic_bran.uwm301.dridip[9]
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.dridip[10]   <> brsic_bran.uwm301.dridip[10]
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.act_ae       <> brsic_bran.uwm301.act_ae
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.actprm       <> brsic_bran.uwm301.actprm
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.tp_ae        <> brsic_bran.uwm301.tp_ae
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.tpprm        <> brsic_bran.uwm301.tpprm
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.policy       <> brsic_bran.uwm301.policy
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.rencnt       <> brsic_bran.uwm301.rencnt
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.endcnt       <> brsic_bran.uwm301.endcnt
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.riskgp       <> brsic_bran.uwm301.riskgp
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.riskno       <> brsic_bran.uwm301.riskno
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.itemno       <> brsic_bran.uwm301.itemno
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.cert         <> brsic_bran.uwm301.cert
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.moddes       <> brsic_bran.uwm301.moddes
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.body         <> brsic_bran.uwm301.body
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.engine       <> brsic_bran.uwm301.engine
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.tons         <> brsic_bran.uwm301.tons
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.seats        <> brsic_bran.uwm301.seats
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.vehgrp       <> brsic_bran.uwm301.vehgrp
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.trareg       <> brsic_bran.uwm301.trareg
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.logbok       <> brsic_bran.uwm301.logbok
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.garage       <> brsic_bran.uwm301.garage
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.mv41a        <> brsic_bran.uwm301.mv41a
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.mv41b        <> brsic_bran.uwm301.mv41b
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.mv41c        <> brsic_bran.uwm301.mv41c
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.mv42         <> brsic_bran.uwm301.mv42
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.atttxt       <> brsic_bran.uwm301.atttxt
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.mv41seat     <> brsic_bran.uwm301.mv41seat
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.comp_cod     <> brsic_bran.uwm301.comp_cod
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.sckno        <> brsic_bran.uwm301.sckno
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.mv_ben83     <> brsic_bran.uwm301.mv_ben83
       then do: nv_duprec100 = no. leave. end.
    if sic_bran.uwm301.prmtxt       <> brsic_bran.uwm301.prmtxt
       then do: nv_duprec100 = no. leave. end.
  END.

END.

/* END OFF : CHUWM301.P */
