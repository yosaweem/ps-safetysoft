/* WGWTB300.P : Cargo Risk Details */
/* MODIFY BY SOMBAT 30/11/1997     */
/*
   Sombat Phu. : 26/04/2003
   Description : Transfer data from Brach to Branch
                 brsic_bran ->  sic_bran
                 brstat     ->  stat
   Modify  by  : sombat 04/03/1998
                 Transfer data path frame realay
                 change name host to sicuw
   Modify by   : Narin  15/09/2010    A52-0242 
   DEFINE INPUT-OUTPUT PARAMETER  sh_policy  , sh_rencnt  , sh_endcnt , 
                                  nv_batchyr , nv_batchno , nv_batcnt
   ค่าดังกล่าวมาจากโปรแกรม Main wgw\wgwtrn72.w >>>> tm\tmcount.p  
   สรุปหลักการ Connect Database GW  และ Database local 
   1. DATABASE GW  ที่ CONNECT ได้ ให้ทำการ DISCONNECT ออก SIC_BRAN  กับ  BRSTAT
      และ ทำการ Conncet database : gw_safe  &  gw_stat
          sic_bran  --->  
          brstat    --->  gw_stat
   2. DATABASE Local Connect ดังนี้ 
          bransafe --->  -ld  brsic_bran
          brstat   --->  -ld  brstat
*/

DEFINE INPUT-OUTPUT PARAMETER  sh_policy    AS CHAR FORMAT "X(16)" INIT 0.
DEFINE INPUT-OUTPUT PARAMETER  sh_rencnt    AS INT  FORMAT "999"   INIT 0.
DEFINE INPUT-OUTPUT PARAMETER  sh_endcnt    AS INT  FORMAT "999"   INIT 0.
DEFINE INPUT-OUTPUT PARAMETER  nv_batchyr   AS INT  FORMAT "9999"  INIT 0.
DEFINE INPUT-OUTPUT PARAMETER  nv_batchno   AS CHAR FORMAT "X(13)" INIT ""  NO-UNDO.
DEFINE INPUT-OUTPUT PARAMETER  nv_batcnt    AS INT  FORMAT "99"    INIT 0.

HIDE MESSAGE NO-PAUSE.
/*MESSAGE "Update data uwm300".*/
    /*
FOR EACH brsic_bran.uwm300 WHERE
         brsic_bran.uwm300.policy = sh_policy AND
         brsic_bran.uwm300.rencnt = sh_rencnt AND
         brsic_bran.uwm300.endcnt = sh_endcnt
:
    */
FIND FIRST brsic_bran.uwm300 WHERE 
           brsic_bran.uwm300.policy = sh_policy AND
           brsic_bran.uwm300.rencnt = sh_rencnt AND
           brsic_bran.uwm300.endcnt = sh_endcnt NO-LOCK NO-ERROR NO-WAIT.

IF AVAILABLE brsic_bran.uwm300 THEN DO:
  FIND sic_bran.uwm300 WHERE 
       sic_bran.uwm300.policy = brsic_bran.uwm300.policy AND
       sic_bran.uwm300.rencnt = brsic_bran.uwm300.rencnt AND
       sic_bran.uwm300.endcnt = brsic_bran.uwm300.endcnt AND
       sic_bran.uwm300.riskgp = brsic_bran.uwm300.riskgp AND
       sic_bran.uwm300.riskno = brsic_bran.uwm300.riskno AND
       sic_bran.uwm300.bchyr  = nv_batchyr               AND
       sic_bran.uwm300.bchno  = nv_batchno               AND
       sic_bran.uwm300.bchcnt = nv_batcnt  
       
  NO-ERROR.

  IF NOT AVAILABLE sic_bran.uwm300 THEN DO:
     CREATE sic_bran.uwm300.
  END.

  ASSIGN
    sic_bran.uwm300.vessel   = brsic_bran.uwm300.vessel       
    sic_bran.uwm300.vesno    = brsic_bran.uwm300.vesno        
    sic_bran.uwm300.voydat   = brsic_bran.uwm300.voydat       
    sic_bran.uwm300.vdat_c   = brsic_bran.uwm300.vdat_c       
    sic_bran.uwm300.voyno    = brsic_bran.uwm300.voyno        
    sic_bran.uwm300.voyage   = brsic_bran.uwm300.voyage       
    sic_bran.uwm300.survey   = brsic_bran.uwm300.survey       
    sic_bran.uwm300.settle   = brsic_bran.uwm300.settle       
    sic_bran.uwm300.declrn   = brsic_bran.uwm300.declrn       
    sic_bran.uwm300.und_si   = brsic_bran.uwm300.und_si       
    sic_bran.uwm300.policy   = brsic_bran.uwm300.policy       
    sic_bran.uwm300.rencnt   = brsic_bran.uwm300.rencnt       
    sic_bran.uwm300.endcnt   = brsic_bran.uwm300.endcnt       
    sic_bran.uwm300.riskgp   = brsic_bran.uwm300.riskgp       
    sic_bran.uwm300.riskno   = brsic_bran.uwm300.riskno       
    sic_bran.uwm300.claim_ie = brsic_bran.uwm300.claim_ie     
    sic_bran.uwm300.vessel2  = brsic_bran.uwm300.vessel2      
    sic_bran.uwm300.vesno2   = brsic_bran.uwm300.vesno2       
    sic_bran.uwm300.voyage2  = brsic_bran.uwm300.voyage2
    sic_bran.uwm300.bchyr    = nv_batchyr   
    sic_bran.uwm300.bchno    = nv_batchno   
    sic_bran.uwm300.bchcnt   = nv_batcnt.

END. /*IF AVAILABLE brsic_bran.uwm300 THEN DO:*/

HIDE MESSAGE NO-PAUSE.

/* END OF : WGWTB300.P */
