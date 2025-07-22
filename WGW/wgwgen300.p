/*=================================================================*/
/* Program Name :  Transfer Data   GW to Premium                   */
/* CREATE  By   : Chaiyong W. A58-0123 24/04/2015                  */
/*                Transfer Data   GW to Premium                    */
/* Dup Program Transfer                                            */   
/* Modify by : Songkran P. A65-0141 28/11/2022 add field           */                                             
/*=================================================================*/

DEF INPUT PARAMETER nv_bchyr  AS INT.
DEF INPUT PARAMETER nv_bchno  AS CHAR.
DEF INPUT PARAMETER nv_bchcnt AS INT.
DEF INPUT PARAMETER nv_policy AS CHAR.
DEF INPUT PARAMETER nv_rencnt AS INT.
DEF INPUT PARAMETER nv_endcnt AS INT.

FOR EACH sic_bran.uwm300 WHERE
         sic_bran.uwm300.policy = nv_policy AND
         sic_bran.uwm300.rencnt = nv_rencnt AND
         sic_bran.uwm300.endcnt = nv_endcnt AND
         sic_bran.uwm300.bchyr   = nv_bchyr  AND
         sic_bran.uwm300.bchno   = nv_bchno  AND
         sic_bran.uwm300.bchcnt  = nv_bchcnt NO-LOCK:
  FIND FIRST sicuw.uwm300 WHERE 
       sicuw.uwm300.policy = sic_bran.uwm300.policy AND
       sicuw.uwm300.rencnt = sic_bran.uwm300.rencnt AND
       sicuw.uwm300.endcnt = sic_bran.uwm300.endcnt AND
       sicuw.uwm300.riskgp = sic_bran.uwm300.riskgp AND
       sicuw.uwm300.riskno = sic_bran.uwm300.riskno
  NO-ERROR.

  IF NOT AVAILABLE sicuw.uwm300 THEN   CREATE sicuw.uwm300.

  ASSIGN
    sicuw.uwm300.vessel   = sic_bran.uwm300.vessel       
    sicuw.uwm300.vesno    = sic_bran.uwm300.vesno        
    sicuw.uwm300.voydat   = sic_bran.uwm300.voydat       
    sicuw.uwm300.vdat_c   = sic_bran.uwm300.vdat_c       
    sicuw.uwm300.voyno    = sic_bran.uwm300.voyno        
    sicuw.uwm300.voyage   = sic_bran.uwm300.voyage       
    sicuw.uwm300.survey   = sic_bran.uwm300.survey       
    sicuw.uwm300.settle   = sic_bran.uwm300.settle       
    sicuw.uwm300.declrn   = sic_bran.uwm300.declrn       
    sicuw.uwm300.und_si   = sic_bran.uwm300.und_si       
    sicuw.uwm300.policy   = sic_bran.uwm300.policy       
    sicuw.uwm300.rencnt   = sic_bran.uwm300.rencnt       
    sicuw.uwm300.endcnt   = sic_bran.uwm300.endcnt       
    sicuw.uwm300.riskgp   = sic_bran.uwm300.riskgp       
    sicuw.uwm300.riskno   = sic_bran.uwm300.riskno       
    sicuw.uwm300.claim_ie = sic_bran.uwm300.claim_ie     
    sicuw.uwm300.vessel2  = sic_bran.uwm300.vessel2      
    sicuw.uwm300.vesno2   = sic_bran.uwm300.vesno2       
    sicuw.uwm300.voyage2  = sic_bran.uwm300.voyage2.
    /*--Begin A65-0141 28/11/2022*/
    ASSIGN
        sicuw.uwm300.vesnam1    = sic_bran.uwm300.vesnam1        
        sicuw.uwm300.vesdes1    = sic_bran.uwm300.vesdes1        
        sicuw.uwm300.voydes11   = sic_bran.uwm300.voydes11       
        sicuw.uwm300.voydes12   = sic_bran.uwm300.voydes12       
        sicuw.uwm300.vesnam2    = sic_bran.uwm300.vesnam2        
        sicuw.uwm300.vesdes2    = sic_bran.uwm300.vesdes2        
        sicuw.uwm300.voydes21   = sic_bran.uwm300.voydes21       
        sicuw.uwm300.voydes22   = sic_bran.uwm300.voydes22       
        sicuw.uwm300.car_c      = sic_bran.uwm300.car_c          
        sicuw.uwm300.pac_c      = sic_bran.uwm300.pac_c          
        sicuw.uwm300.cou_c      = sic_bran.uwm300.cou_c          
        sicuw.uwm300.stype      = sic_bran.uwm300.stype          
        sicuw.uwm300.sdes       = sic_bran.uwm300.sdes           
        sicuw.uwm300.mcode      = sic_bran.uwm300.mcode          
        sicuw.uwm300.mdes       = sic_bran.uwm300.mdes           
        sicuw.uwm300.note1      = sic_bran.uwm300.note1          
        sicuw.uwm300.note2      = sic_bran.uwm300.note2          
        sicuw.uwm300.note3      = sic_bran.uwm300.note3          
        sicuw.uwm300.note4      = sic_bran.uwm300.note4          
        sicuw.uwm300.note5      = sic_bran.uwm300.note5          
        sicuw.uwm300.chr1       = sic_bran.uwm300.chr1           
        sicuw.uwm300.chr2       = sic_bran.uwm300.chr2           
        sicuw.uwm300.chr3       = sic_bran.uwm300.chr3           
        sicuw.uwm300.chr4       = sic_bran.uwm300.chr4           
        sicuw.uwm300.chr5       = sic_bran.uwm300.chr5           
        sicuw.uwm300.date1      = sic_bran.uwm300.date1          
        sicuw.uwm300.date2      = sic_bran.uwm300.date2          
        sicuw.uwm300.dec1       = sic_bran.uwm300.dec1           
        sicuw.uwm300.dec2       = sic_bran.uwm300.dec2           
        sicuw.uwm300.int1       = sic_bran.uwm300.int1           
        sicuw.uwm300.int2       = sic_bran.uwm300.int2 .
    /*End A65-0141 28/11/2022----*/

END.

HIDE MESSAGE NO-PAUSE.
