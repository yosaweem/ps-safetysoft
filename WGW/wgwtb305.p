/* WGWTB305.P */
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

hide message no-pause.
/*message "Update uwm305".*/
    /*
FOR EACH brsic_bran.uwm305 WHERE 
         brsic_bran.uwm305.policy = sh_policy AND
         brsic_bran.uwm305.rencnt = sh_rencnt AND
         brsic_bran.uwm305.endcnt = sh_endcnt
:
    */
FIND FIRST brsic_bran.uwm305 WHERE 
           brsic_bran.uwm305.policy = sh_policy AND
           brsic_bran.uwm305.rencnt = sh_rencnt AND
           brsic_bran.uwm305.endcnt = sh_endcnt NO-LOCK NO-ERROR NO-WAIT.

IF AVAILABLE brsic_bran.uwm305 THEN DO:

  FIND sic_bran.uwm305 WHERE 
       sic_bran.uwm305.policy = brsic_bran.uwm305.policy AND
       sic_bran.uwm305.rencnt = brsic_bran.uwm305.rencnt AND
       sic_bran.uwm305.endcnt = brsic_bran.uwm305.endcnt AND
       sic_bran.uwm305.riskgp = brsic_bran.uwm305.riskgp AND
       sic_bran.uwm305.riskno = brsic_bran.uwm305.riskno AND
       sic_bran.uwm305.bchyr  = nv_batchyr          AND
       sic_bran.uwm305.bchno  = nv_batchno          AND
       sic_bran.uwm305.bchcnt = nv_batcnt  

  NO-ERROR.

  IF NOT AVAILABLE sic_bran.uwm305 THEN DO:
     CREATE sic_bran.uwm305.
  END.

  ASSIGN
    sic_bran.uwm305.policy = brsic_bran.uwm305.policy       
    sic_bran.uwm305.rencnt = brsic_bran.uwm305.rencnt       
    sic_bran.uwm305.endcnt = brsic_bran.uwm305.endcnt       
    sic_bran.uwm305.riskgp = brsic_bran.uwm305.riskgp       
    sic_bran.uwm305.riskno = brsic_bran.uwm305.riskno       
    sic_bran.uwm305.hoco_n = brsic_bran.uwm305.hoco_n       
    sic_bran.uwm305.cocd_n = brsic_bran.uwm305.cocd_n       
    sic_bran.uwm305.cont_n = brsic_bran.uwm305.cont_n
    sic_bran.uwm305.bchyr  = nv_batchyr  
    sic_bran.uwm305.bchno  = nv_batchno
    sic_bran.uwm305.bchcnt = nv_batcnt .
END. /* IF AVAILABLE brsic_bran.uwm305 THEN DO: */

/* END OF : WGWTB305.P */
