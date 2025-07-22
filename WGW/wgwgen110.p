/*=================================================================*/
/* Program Name :  Transfer Data   GW to Premium                   */
/* CREATE  By   : Chaiyong W. A58-0123 24/04/2015                  */
/*                Transfer Data   GW to Premium                    */
/* Dup Program Transfer                                            */                                              
/*=================================================================*/

DEF SHARED VAR n_User   AS CHAR.
DEF INPUT PARAMETER nv_bchyr  AS INT.
DEF INPUT PARAMETER nv_bchno  AS CHAR.
DEF INPUT PARAMETER nv_bchcnt AS INT.
DEF INPUT PARAMETER nv_policy AS CHAR.
DEF INPUT PARAMETER nv_rencnt AS INT.
DEF INPUT PARAMETER nv_endcnt AS INT.
hide message no-pause.

FOR EACH sic_bran.uwm110 WHERE
         sic_bran.uwm110.policy = nv_policy AND
         sic_bran.uwm110.rencnt = nv_rencnt AND
         sic_bran.uwm110.endcnt = nv_endcnt AND
         sic_bran.uwm110.bchyr  = nv_bchyr  AND
         sic_bran.uwm110.bchno  = nv_bchno  AND
         sic_bran.uwm110.bchcnt = nv_bchcnt 
NO-LOCK:


  FIND FIRST sicuw.uwm110 WHERE 
       sicuw.uwm110.policy = sic_bran.uwm110.policy AND
       sicuw.uwm110.rencnt = sic_bran.uwm110.rencnt AND
       sicuw.uwm110.endcnt = sic_bran.uwm110.endcnt AND
       sicuw.uwm110.riskgp = sic_bran.uwm110.riskgp
  NO-ERROR.

  IF NOT AVAILABLE sicuw.uwm110 THEN DO:
    CREATE sicuw.uwm110.
  END.

  ASSIGN
    sicuw.uwm110.policy = sic_bran.uwm110.policy       
    sicuw.uwm110.rencnt = sic_bran.uwm110.rencnt       
    sicuw.uwm110.endcnt = sic_bran.uwm110.endcnt       
    sicuw.uwm110.riskgp = sic_bran.uwm110.riskgp       
    sicuw.uwm110.gpdes1 = sic_bran.uwm110.gpdes1       
    sicuw.uwm110.gpdes2 = sic_bran.uwm110.gpdes2       
    sicuw.uwm110.gpdes3 = sic_bran.uwm110.gpdes3       
    sicuw.uwm110.rgpdel = sic_bran.uwm110.rgpdel.
END.
