/* WGWTC130.P */
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

def     shared var sh_policy like sic_bran.uwm100.policy.
def     shared var sh_rencnt like sic_bran.uwm100.rencnt.
def     shared var sh_endcnt like sic_bran.uwm100.endcnt.

def     shared var nv_duprec100  as logi init no no-undo.
def     shared var nv_duprec120  as logi init no no-undo.
def     shared var nv_duprec301  as logi init no no-undo.
def            var nv_brsic_bran as inte init 0  no-undo.
def            var nv_host       as inte init 0  no-undo.

def            var nv_fptr       as   recid.

for each brsic_bran.uwm130 where
    brsic_bran.uwm130.policy = sh_policy and
    brsic_bran.uwm130.rencnt = sh_rencnt and
    brsic_bran.uwm130.endcnt = sh_endcnt
no-lock:
    nv_brsic_bran = nv_brsic_bran + 1.
end.

for each sic_bran.uwm130 where
    sic_bran.uwm130.policy = sh_policy and
    sic_bran.uwm130.rencnt = sh_rencnt and
    sic_bran.uwm130.endcnt = sh_endcnt
no-lock:
    nv_host = nv_host + 1.
end.

/* Delete host file uwm130 */
IF nv_host <> nv_brsic_bran THEN DO:
  for each sic_bran.uwm130 where
      sic_bran.uwm130.policy = sh_policy and
      sic_bran.uwm130.rencnt = sh_rencnt and
      sic_bran.uwm130.endcnt = sh_endcnt
  :

/*delete uwd130 */
    nv_fptr = sic_bran.uwm130.fptr01.
    do while nv_fptr <> 0 and sic_bran.uwm130.fptr01 <> ? :
       find sic_bran.uwd130 where recid(sic_bran.uwd130) = nv_fptr
           no-error.
       if available sic_bran.uwd130 then do: /*sombat */
          nv_fptr = sic_bran.uwd130.fptr.
          if sic_bran.uwd130.policy = sh_policy and
             sic_bran.uwd130.rencnt = sh_rencnt and
             sic_bran.uwd130.endcnt = sh_endcnt then do:
             delete sic_bran.uwd130.
           end.
           else
             nv_fptr = 0.
       end.
       else
           nv_fptr = 0.
    end.


/*delete uwd131 */
    nv_fptr = sic_bran.uwm130.fptr02.
    do while nv_fptr <> 0 and sic_bran.uwm130.fptr02 <> ? :
       find sic_bran.uwd131 where recid(sic_bran.uwd131) = nv_fptr
           no-error.
       if available sic_bran.uwd131 then do: /*sombat */
          nv_fptr = sic_bran.uwd131.fptr.
          if sic_bran.uwd131.policy = sh_policy and
             sic_bran.uwd131.rencnt = sh_rencnt and
             sic_bran.uwd131.endcnt = sh_endcnt then do:
             delete sic_bran.uwd131.
           end.
           else
             nv_fptr = 0.
       end.
       else
           nv_fptr = 0.
    end.

/*delete uwd132 */
    nv_fptr = sic_bran.uwm130.fptr03.
    do while nv_fptr <> 0 and sic_bran.uwm130.fptr03 <> ? :
       find sic_bran.uwd132 where recid(sic_bran.uwd132) = nv_fptr
           no-error.
       if available sic_bran.uwd132 then do: /*sombat */
          nv_fptr = sic_bran.uwd132.fptr.
          if sic_bran.uwd132.policy = sh_policy and
             sic_bran.uwd132.rencnt = sh_rencnt and
             sic_bran.uwd132.endcnt = sh_endcnt then do:
             delete sic_bran.uwd132.
           end.
           else
             nv_fptr = 0.
       end.
       else
           nv_fptr = 0.
    end.

/*delete uwd134 */
    nv_fptr = sic_bran.uwm130.fptr04.
    do while nv_fptr <> 0 and sic_bran.uwm130.fptr04 <> ? :
       find sic_bran.uwd134 where recid(sic_bran.uwd134) = nv_fptr
           no-error.
       if available sic_bran.uwd134 then do: /*sombat */
          nv_fptr = sic_bran.uwd134.fptr.
          if sic_bran.uwd134.policy = sh_policy and
             sic_bran.uwd134.rencnt = sh_rencnt and
             sic_bran.uwd134.endcnt = sh_endcnt then do:
             delete sic_bran.uwd134.
           end.
           else
             nv_fptr = 0.
       end.
       else
           nv_fptr = 0.
    end.

/*delete uwd136 */
    nv_fptr = sic_bran.uwm130.fptr05.
    do while nv_fptr <> 0 and sic_bran.uwm130.fptr05 <> ? :
       find sic_bran.uwd136 where recid(sic_bran.uwd136) = nv_fptr
           no-error.
       if available sic_bran.uwd136 then do: /*sombat */
          nv_fptr = sic_bran.uwd136.fptr.
          if sic_bran.uwd136.policy = sh_policy and
             sic_bran.uwd136.rencnt = sh_rencnt and
             sic_bran.uwd136.endcnt = sh_endcnt then do:
             delete sic_bran.uwd136.
           end.
           else
             nv_fptr = 0.
       end.
       else
           nv_fptr = 0.
    end.

    delete sic_bran.uwm130.
  end.

  nv_duprec100 = no.
END.
ELSE DO:
  nv_duprec100 = YES.

  FOR EACH brsic_bran.uwm130 WHERE
           brsic_bran.uwm130.policy = sh_policy AND
           brsic_bran.uwm130.rencnt = sh_rencnt AND
           brsic_bran.uwm130.endcnt = sh_endcnt
  NO-LOCK:

    FIND FIRST sic_bran.uwm130 WHERE
         sic_bran.uwm130.policy = brsic_bran.uwm130.policy AND
         sic_bran.uwm130.rencnt = brsic_bran.uwm130.rencnt AND
         sic_bran.uwm130.endcnt = brsic_bran.uwm130.endcnt AND
         sic_bran.uwm130.riskgp = brsic_bran.uwm130.riskgp AND
         sic_bran.uwm130.riskno = brsic_bran.uwm130.riskno AND
         sic_bran.uwm130.itemno = brsic_bran.uwm130.itemno
    NO-ERROR.

    IF NOT AVAILABLE sic_bran.uwm130 THEN DO:
      nv_duprec100 = no.
      LEAVE.
    END.

    IF sic_bran.uwm130.dl1per   <> brsic_bran.uwm130.dl1per
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm130.dl2per   <> brsic_bran.uwm130.dl2per
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm130.dl3per   <> brsic_bran.uwm130.dl3per
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm130.endcnt   <> brsic_bran.uwm130.endcnt
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm130.itemno   <> brsic_bran.uwm130.itemno
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm130.itmdel   <> brsic_bran.uwm130.itmdel
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm130.i_text   <> brsic_bran.uwm130.i_text
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm130.policy   <> brsic_bran.uwm130.policy
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm130.rencnt   <> brsic_bran.uwm130.rencnt
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm130.riskgp   <> brsic_bran.uwm130.riskgp
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm130.riskno   <> brsic_bran.uwm130.riskno
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm130.styp20   <> brsic_bran.uwm130.styp20
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm130.sval20   <> brsic_bran.uwm130.sval20
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm130.uom1_c   <> brsic_bran.uwm130.uom1_c
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm130.uom1_u   <> brsic_bran.uwm130.uom1_u
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm130.uom1_v   <> brsic_bran.uwm130.uom1_v
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm130.uom2_c   <> brsic_bran.uwm130.uom2_c
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm130.uom2_u   <> brsic_bran.uwm130.uom2_u
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm130.uom2_v   <> brsic_bran.uwm130.uom2_v
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm130.uom3_c   <> brsic_bran.uwm130.uom3_c
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm130.uom3_u   <> brsic_bran.uwm130.uom3_u
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm130.uom3_v   <> brsic_bran.uwm130.uom3_v
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm130.uom4_c   <> brsic_bran.uwm130.uom4_c
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm130.uom4_u   <> brsic_bran.uwm130.uom4_u
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm130.uom4_v   <> brsic_bran.uwm130.uom4_v
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm130.uom5_c   <> brsic_bran.uwm130.uom5_c
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm130.uom5_u   <> brsic_bran.uwm130.uom5_u
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm130.uom5_v   <> brsic_bran.uwm130.uom5_v
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm130.uom6_c   <> brsic_bran.uwm130.uom6_c
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm130.uom6_u   <> brsic_bran.uwm130.uom6_u
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm130.uom6_v   <> brsic_bran.uwm130.uom6_v
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm130.uom7_c   <> brsic_bran.uwm130.uom7_c
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm130.uom7_u   <> brsic_bran.uwm130.uom7_u
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm130.uom7_v   <> brsic_bran.uwm130.uom7_v
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm130.uom8_c   <> brsic_bran.uwm130.uom8_c
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm130.uom8_v   <> brsic_bran.uwm130.uom8_v
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm130.uom9_c   <> brsic_bran.uwm130.uom9_c
    then do: nv_duprec100 = no. leave. end.
    IF sic_bran.uwm130.uom9_v   <> brsic_bran.uwm130.uom9_v
    then do: nv_duprec100 = no. leave. end.
  END.

END.   /* End for brsic_bran uwm130 */

/* END OFF : WGWTC130.P */
