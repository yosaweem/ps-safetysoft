/* WGWTC120.p */
/*
   Sombat Phu. : 26/04/2003
   Description : Transfer data from Brach to Branch
                 brsic_bran ->  sic_bran
                 brstat     ->  stat
   Modify  by  : sombat 04/03/1998
                 Transfer data path frame realay
                 change name host to sicuw
   Modify  by  : Narin 19/10/2010              
   สรุปหลักการ Connect Database GW  และ Database local 
   1. DATABASE GW  ที่ CONNECT ได้ ให้ทำการ DISCONNECT ออก SIC_BRAN  กับ  BRSTAT
      และ ทำการ Conncet database : gw_safe  &  gw_stat
          sic_bran  
          brstat    --->  gw_stat
   2. DATABASE Local Connect ดังนี้ 
          bransafe --->  -ld  brsic_bran
          brstat   --->  -ld  brstat              
*/

def     shared var sh_policy like sic_bran.uwm100.policy.
def     shared var sh_rencnt like sic_bran.uwm100.rencnt.
def     shared var sh_endcnt like sic_bran.uwm100.endcnt.

def     shared var nv_duprec100  as logi init no no-undo.
def     shared var nv_duprec120  as logi init no no-undo.
def     shared var nv_duprec301  as logi init no no-undo.
def            var nv_brsic_bran as inte init 0  no-undo.
def            var nv_host       as inte init 0  no-undo.

def            var nv_fptr       as   recid.

for each brsic_bran.uwm120 where
    brsic_bran.uwm120.policy = sh_policy and
    brsic_bran.uwm120.rencnt = sh_rencnt and
    brsic_bran.uwm120.endcnt = sh_endcnt
no-lock:
    nv_brsic_bran = nv_brsic_bran + 1.
end.

for each sic_bran.uwm120 where 
    sic_bran.uwm120.policy = sh_policy and
    sic_bran.uwm120.rencnt = sh_rencnt and
    sic_bran.uwm120.endcnt = sh_endcnt
no-lock:
    nv_host = nv_host + 1.
end.

/* Delete host file uwm120 */
IF nv_host <> nv_brsic_bran THEN DO:
  for each sic_bran.uwm120 where
      sic_bran.uwm120.policy = sh_policy and
      sic_bran.uwm120.rencnt = sh_rencnt and
      sic_bran.uwm120.endcnt = sh_endcnt
  :

/*delete uwd120 */
    nv_fptr = sic_bran.uwm120.fptr01.
    do while nv_fptr <> 0 and sic_bran.uwm120.fptr01 <> ? :
       find sic_bran.uwd120 where recid(sic_bran.uwd120) = nv_fptr
           no-error.
       if available sic_bran.uwd120 then do: /*sombat */
          nv_fptr = sic_bran.uwd120.fptr.
          if sic_bran.uwd120.policy = sh_policy and
             sic_bran.uwd120.rencnt = sh_rencnt and
             sic_bran.uwd120.endcnt = sh_endcnt then do:
             delete sic_bran.uwd120.
           end.
           else
             nv_fptr = 0.
       end.
       else
           nv_fptr = 0.
    end.

/*delete uwd121 */
    nv_fptr = sic_bran.uwm120.fptr02.
    do while nv_fptr <> 0 and sic_bran.uwm120.fptr02 <> ? :
       find sic_bran.uwd121 where recid(sic_bran.uwd121) = nv_fptr
           no-error.
       if available sic_bran.uwd121 then do: /*sombat */
          nv_fptr = sic_bran.uwd121.fptr.
          if sic_bran.uwd121.policy = sh_policy and
             sic_bran.uwd121.rencnt = sh_rencnt and
             sic_bran.uwd121.endcnt = sh_endcnt then do:
             delete sic_bran.uwd121.
           end.
           else
             nv_fptr = 0.
       end.
       else
           nv_fptr = 0.
    end.

/*delete uwd123 */
    nv_fptr = sic_bran.uwm120.fptr03.
    do while nv_fptr <> 0 and sic_bran.uwm120.fptr03 <> ? :
       find sic_bran.uwd123 where recid(sic_bran.uwd123) = nv_fptr
           no-error.
       if available sic_bran.uwd123 then do: /*sombat */
          nv_fptr = sic_bran.uwd123.fptr.
          if sic_bran.uwd123.policy = sh_policy and
             sic_bran.uwd123.rencnt = sh_rencnt and
             sic_bran.uwd123.endcnt = sh_endcnt then do:
             delete sic_bran.uwd123.
           end.
           else
             nv_fptr = 0.
       end.
       else
           nv_fptr = 0.
    end.

/*delete uwd125 */
    nv_fptr = sic_bran.uwm120.fptr04.
    do while nv_fptr <> 0 and sic_bran.uwm120.fptr04 <> ? :
       find sic_bran.uwd125 where recid(sic_bran.uwd125) = nv_fptr
           no-error.
       if available sic_bran.uwd125 then do: /*sombat */
          nv_fptr = sic_bran.uwd125.fptr.
          if sic_bran.uwd125.policy = sh_policy and
             sic_bran.uwd125.rencnt = sh_rencnt and
             sic_bran.uwd125.endcnt = sh_endcnt then do:
             delete sic_bran.uwd125.
           end.
           else
             nv_fptr = 0.
       end.
       else
           nv_fptr = 0.
    end.

/*delete uwd124 */
    nv_fptr = sic_bran.uwm120.fptr08.
    do while nv_fptr <> 0 and sic_bran.uwm120.fptr08 <> ? :
       find sic_bran.uwd124 where recid(sic_bran.uwd124) = nv_fptr
           no-error.
       if available sic_bran.uwd124 then do: /*sombat */
          nv_fptr = sic_bran.uwd124.fptr.
          if sic_bran.uwd124.policy = sh_policy and
             sic_bran.uwd124.rencnt = sh_rencnt and
             sic_bran.uwd124.endcnt = sh_endcnt then do:
             delete sic_bran.uwd124.
           end.
           else
             nv_fptr = 0.
       end.
       else
           nv_fptr = 0.
    end.

/*delete uwd126 */
    nv_fptr = sic_bran.uwm120.fptr09.
    do while nv_fptr <> 0 and sic_bran.uwm120.fptr09 <> ? :
       find sic_bran.uwd126 where recid(sic_bran.uwd126) = nv_fptr
           no-error.
       if available sic_bran.uwd126 then do: /*sombat */
          nv_fptr = sic_bran.uwd126.fptr.
          if sic_bran.uwd126.policy = sh_policy and
             sic_bran.uwd126.rencnt = sh_rencnt and
             sic_bran.uwd126.endcnt = sh_endcnt then do:
             delete sic_bran.uwd126.
           end.
           else
             nv_fptr = 0.
       end.
       else
           nv_fptr = 0.
    end.

    delete sic_bran.uwm120.
  end.

  nv_duprec100 = no.
END.
ELSE DO:
  nv_duprec100 = YES.

  FOR EACH brsic_bran.uwm120 WHERE
           brsic_bran.uwm120.policy = sh_policy AND
           brsic_bran.uwm120.rencnt = sh_rencnt AND
           brsic_bran.uwm120.endcnt = sh_endcnt
  NO-LOCK:

    FIND FIRST sic_bran.uwm120 WHERE
         sic_bran.uwm120.policy = brsic_bran.uwm120.policy AND
         sic_bran.uwm120.rencnt = brsic_bran.uwm120.rencnt AND
         sic_bran.uwm120.endcnt = brsic_bran.uwm120.endcnt AND
         sic_bran.uwm120.riskgp = brsic_bran.uwm120.riskgp AND
         sic_bran.uwm120.riskno = brsic_bran.uwm120.riskno
    NO-ERROR.

    IF NOT AVAILABLE sic_bran.uwm120 THEN DO:
      nv_duprec100 = no.
      LEAVE.
    END.

    IF sic_bran.uwm120.class     <> brsic_bran.uwm120.class
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm120.com1ae    <> brsic_bran.uwm120.com1ae
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm120.com1p     <> brsic_bran.uwm120.com1p
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm120.com1_r    <> brsic_bran.uwm120.com1_r
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm120.com2ae    <> brsic_bran.uwm120.com2ae
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm120.com2p     <> brsic_bran.uwm120.com2p
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm120.com2_r    <> brsic_bran.uwm120.com2_r
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm120.com3ae    <> brsic_bran.uwm120.com3ae
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm120.com3p     <> brsic_bran.uwm120.com3p
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm120.com3_r    <> brsic_bran.uwm120.com3_r
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm120.com4ae    <> brsic_bran.uwm120.com4ae
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm120.com4p     <> brsic_bran.uwm120.com4p
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm120.com4_r    <> brsic_bran.uwm120.com4_r
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm120.comco     <> brsic_bran.uwm120.comco
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm120.comfac    <> brsic_bran.uwm120.comfac
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm120.comqs     <> brsic_bran.uwm120.comqs
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm120.comst     <> brsic_bran.uwm120.comst
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm120.comtty    <> brsic_bran.uwm120.comtty
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm120.dl1_r     <> brsic_bran.uwm120.dl1_r
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm120.dl2_r     <> brsic_bran.uwm120.dl2_r
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm120.dl3_r     <> brsic_bran.uwm120.dl3_r
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm120.endcnt    <> brsic_bran.uwm120.endcnt
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm120.feeae     <> brsic_bran.uwm120.feeae
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm120.gap_r     <> brsic_bran.uwm120.gap_r
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm120.pdco      <> brsic_bran.uwm120.pdco
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm120.pdfac     <> brsic_bran.uwm120.pdfac
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm120.pdqs      <> brsic_bran.uwm120.pdqs
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm120.pdst      <> brsic_bran.uwm120.pdst
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm120.pdtty     <> brsic_bran.uwm120.pdtty
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm120.policy    <> brsic_bran.uwm120.policy
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm120.prem_r    <> brsic_bran.uwm120.prem_r
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm120.rencnt    <> brsic_bran.uwm120.rencnt
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm120.rfee_r    <> brsic_bran.uwm120.rfee_r
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm120.rilate    <> brsic_bran.uwm120.rilate
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm120.riskgp    <> brsic_bran.uwm120.riskgp
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm120.riskno    <> brsic_bran.uwm120.riskno
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm120.rskdel    <> brsic_bran.uwm120.rskdel
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm120.rstp_r    <> brsic_bran.uwm120.rstp_r
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm120.rtax_r    <> brsic_bran.uwm120.rtax_r
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm120.r_text    <> brsic_bran.uwm120.r_text
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm120.sico      <> brsic_bran.uwm120.sico
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm120.sicurr    <> brsic_bran.uwm120.sicurr
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm120.siexch    <> brsic_bran.uwm120.siexch
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm120.sifac     <> brsic_bran.uwm120.sifac
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm120.sigr      <> brsic_bran.uwm120.sigr
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm120.siqs      <> brsic_bran.uwm120.siqs
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm120.sist      <> brsic_bran.uwm120.sist
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm120.sitty     <> brsic_bran.uwm120.sitty
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm120.stmpae    <> brsic_bran.uwm120.stmpae
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm120.styp20    <> brsic_bran.uwm120.styp20
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm120.sval20    <> brsic_bran.uwm120.sval20
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm120.taxae     <> brsic_bran.uwm120.taxae
    then do: nv_duprec100 = no. leave. end.

  END.

end. /* End for brsic_bran uwm120 */

/* END OFF : WGWTC120.P */
