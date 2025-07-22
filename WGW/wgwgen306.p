/*=================================================================*/
/* Program Name :  Transfer Data   GW to Premium                   */
/* CREATE  By   : Chaiyong W. A58-0123 24/04/2015                  */
/*                Transfer Data   GW to Premium                    */
/* Dup Program Transfer                                            */                                              
/*=================================================================*/
DEF INPUT PARAMETER nv_bchyr  AS INT.
DEF INPUT PARAMETER nv_bchno  AS CHAR.
DEF INPUT PARAMETER nv_bchcnt AS INT.
DEF INPUT PARAMETER nv_policy AS CHAR.
DEF INPUT PARAMETER nv_rencnt AS INT.
DEF INPUT PARAMETER nv_endcnt AS INT.

FOR EACH sic_bran.uwm306 WHERE
         sic_bran.uwm306.policy = nv_policy AND
         sic_bran.uwm306.rencnt = nv_rencnt AND
         sic_bran.uwm306.endcnt = nv_endcnt AND
         sic_bran.uwm306.bchyr   = nv_bchyr  AND
         sic_bran.uwm306.bchno   = nv_bchno  AND
         sic_bran.uwm306.bchcnt  = nv_bchcnt NO-LOCK:
  FIND FIRST sicuw.uwm306 WHERE 
       sicuw.uwm306.vehreg = sic_bran.uwm306.vehreg AND
       sicuw.uwm306.policy = sic_bran.uwm306.policy AND
       sicuw.uwm306.rencnt = sic_bran.uwm306.rencnt AND
       sicuw.uwm306.endcnt = sic_bran.uwm306.endcnt
  NO-ERROR.

  IF NOT AVAILABLE sicuw.uwm306 THEN DO:
    CREATE sicuw.uwm306.
  END.

  ASSIGN
    sicuw.uwm306.vehreg = sic_bran.uwm306.vehreg       
    sicuw.uwm306.policy = sic_bran.uwm306.policy       
    sicuw.uwm306.riskgp = sic_bran.uwm306.riskgp       
    sicuw.uwm306.riskno = sic_bran.uwm306.riskno       
    sicuw.uwm306.itemno = sic_bran.uwm306.itemno       
    sicuw.uwm306.rencnt = sic_bran.uwm306.rencnt       
    sicuw.uwm306.endcnt = sic_bran.uwm306.endcnt       
    sicuw.uwm306.ncbno  = sic_bran.uwm306.ncbno        
    sicuw.uwm306.ncbyrs = sic_bran.uwm306.ncbyrs       
    sicuw.uwm306.ncbper = sic_bran.uwm306.ncbper       
    sicuw.uwm306.polren = sic_bran.uwm306.polren       
    sicuw.uwm306.rem1   = sic_bran.uwm306.rem1         
    sicuw.uwm306.rem2   = sic_bran.uwm306.rem2         
    sicuw.uwm306.usrid  = sic_bran.uwm306.usrid        
    sicuw.uwm306.prtdat = sic_bran.uwm306.prtdat       
    sicuw.uwm306.prttim = sic_bran.uwm306.prttim       
    sicuw.uwm306.clmade = sic_bran.uwm306.clmade       
    sicuw.uwm306.losdat = sic_bran.uwm306.losdat       
    sicuw.uwm306.claim  = sic_bran.uwm306.claim.

END.

HIDE MESSAGE NO-PAUSE.
