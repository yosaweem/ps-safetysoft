/* WGWTB306.P */
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
/*message "Update uwm306".*/
    
FIND FIRST  brsic_bran.uwm306 WHERE                 
            brsic_bran.uwm306.policy = sh_policy AND
            brsic_bran.uwm306.rencnt = sh_rencnt AND
            brsic_bran.uwm306.endcnt = sh_endcnt NO-LOCK NO-ERROR NO-WAIT.

IF AVAILABLE brsic_bran.uwm306 THEN DO:

  FIND sic_bran.uwm306 WHERE 
       sic_bran.uwm306.vehreg = brsic_bran.uwm306.vehreg AND
       sic_bran.uwm306.policy = brsic_bran.uwm306.policy AND
       sic_bran.uwm306.rencnt = brsic_bran.uwm306.rencnt AND
       sic_bran.uwm306.endcnt = brsic_bran.uwm306.endcnt AND
       sic_bran.uwm306.bchyr  = nv_batchyr               AND
       sic_bran.uwm306.bchno  = nv_batchno               AND
       sic_bran.uwm306.bchcnt = nv_batcnt
  NO-ERROR.

  IF NOT AVAILABLE sic_bran.uwm306 THEN DO:
    CREATE sic_bran.uwm306.
  END.

  ASSIGN
    sic_bran.uwm306.vehreg = brsic_bran.uwm306.vehreg       
    sic_bran.uwm306.policy = brsic_bran.uwm306.policy       
    sic_bran.uwm306.riskgp = brsic_bran.uwm306.riskgp       
    sic_bran.uwm306.riskno = brsic_bran.uwm306.riskno       
    sic_bran.uwm306.itemno = brsic_bran.uwm306.itemno       
    sic_bran.uwm306.rencnt = brsic_bran.uwm306.rencnt       
    sic_bran.uwm306.endcnt = brsic_bran.uwm306.endcnt       
    sic_bran.uwm306.ncbno  = brsic_bran.uwm306.ncbno        
    sic_bran.uwm306.ncbyrs = brsic_bran.uwm306.ncbyrs       
    sic_bran.uwm306.ncbper = brsic_bran.uwm306.ncbper       
    sic_bran.uwm306.polren = brsic_bran.uwm306.polren       
    sic_bran.uwm306.rem1   = brsic_bran.uwm306.rem1         
    sic_bran.uwm306.rem2   = brsic_bran.uwm306.rem2         
    sic_bran.uwm306.usrid  = brsic_bran.uwm306.usrid        
    sic_bran.uwm306.prtdat = brsic_bran.uwm306.prtdat       
    sic_bran.uwm306.prttim = brsic_bran.uwm306.prttim       
    sic_bran.uwm306.clmade = brsic_bran.uwm306.clmade       
    sic_bran.uwm306.losdat = brsic_bran.uwm306.losdat       
    sic_bran.uwm306.claim  = brsic_bran.uwm306.claim
    sic_bran.uwm306.bchyr  = nv_batchyr 
    sic_bran.uwm306.bchno  = nv_batchno 
    sic_bran.uwm306.bchcnt = nv_batcnt  .

END.  /* IF AVAILABLE brsic_bran.uwm306 THEN DO: */

/* END OF : WGWTB306.P */
