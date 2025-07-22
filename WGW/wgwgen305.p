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
FOR EACH sic_bran.uwm305 WHERE 
         sic_bran.uwm305.policy = nv_policy AND
         sic_bran.uwm305.rencnt = nv_rencnt AND
         sic_bran.uwm305.endcnt = nv_endcnt AND
         sic_bran.uwm305.bchyr   = nv_bchyr  AND
         sic_bran.uwm305.bchno   = nv_bchno  AND
         sic_bran.uwm305.bchcnt  = nv_bchcnt NO-LOCK:
  FIND FIRST sicuw.uwm305 WHERE 
       sicuw.uwm305.policy = sic_bran.uwm305.policy AND
       sicuw.uwm305.rencnt = sic_bran.uwm305.rencnt AND
       sicuw.uwm305.endcnt = sic_bran.uwm305.endcnt AND
       sicuw.uwm305.riskgp = sic_bran.uwm305.riskgp AND
       sicuw.uwm305.riskno = sic_bran.uwm305.riskno
  NO-ERROR.

  IF NOT AVAILABLE sicuw.uwm305 THEN DO:
    CREATE sicuw.uwm305.
  END.

  ASSIGN
    sicuw.uwm305.policy = sic_bran.uwm305.policy       
    sicuw.uwm305.rencnt = sic_bran.uwm305.rencnt       
    sicuw.uwm305.endcnt = sic_bran.uwm305.endcnt       
    sicuw.uwm305.riskgp = sic_bran.uwm305.riskgp       
    sicuw.uwm305.riskno = sic_bran.uwm305.riskno       
    sicuw.uwm305.hoco_n = sic_bran.uwm305.hoco_n       
    sicuw.uwm305.cocd_n = sic_bran.uwm305.cocd_n       
    sicuw.uwm305.cont_n = sic_bran.uwm305.cont_n.
END.
HIDE MESSAGE NO-PAUSE.
