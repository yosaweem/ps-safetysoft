/*=================================================================*/
/* Program Name :  Transfer Data   GW to Premium                   */
/* CREATE  By   : Chaiyong W. A58-0123 24/04/2015                  */
/*                Transfer Data   GW to Premium                    */
/* Modify by Chaiyong W. A68-0034 15/05/2025    Add Field          */
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

FOR EACH sic_bran.uwm101 WHERE
         sic_bran.uwm101.policy = nv_policy AND
         sic_bran.uwm101.rencnt = nv_rencnt AND
         sic_bran.uwm101.endcnt = nv_endcnt AND
         sic_bran.uwm101.bchyr  = nv_bchyr  AND
         sic_bran.uwm101.bchno  = nv_bchno  AND
         sic_bran.uwm101.bchcnt = nv_bchcnt 
NO-LOCK:

  FIND FIRST sicuw.uwm101 WHERE 
       sicuw.uwm101.policy = sic_bran.uwm101.policy AND
       sicuw.uwm101.rencnt = sic_bran.uwm101.rencnt AND
       sicuw.uwm101.endcnt = sic_bran.uwm101.endcnt AND
       sicuw.uwm101.instno = sic_bran.uwm101.instno
  NO-ERROR.

  IF NOT AVAILABLE sicuw.uwm101 THEN DO:
    CREATE sicuw.uwm101.
  END.

  ASSIGN
    sicuw.uwm101.policy  = sic_bran.uwm101.policy       
    sicuw.uwm101.rencnt  = sic_bran.uwm101.rencnt       
    sicuw.uwm101.endcnt  = sic_bran.uwm101.endcnt       
    sicuw.uwm101.instno  = sic_bran.uwm101.instno       
    sicuw.uwm101.duedat  = sic_bran.uwm101.duedat       
    sicuw.uwm101.prem_i  = sic_bran.uwm101.prem_i       
    sicuw.uwm101.com1_i  = sic_bran.uwm101.com1_i       
    sicuw.uwm101.com2_i  = sic_bran.uwm101.com2_i       
    sicuw.uwm101.pstp_i  = sic_bran.uwm101.pstp_i       
    sicuw.uwm101.pfee_i  = sic_bran.uwm101.pfee_i       
    sicuw.uwm101.ptax_i  = sic_bran.uwm101.ptax_i       
    sicuw.uwm101.rstp_i  = sic_bran.uwm101.rstp_i       
    sicuw.uwm101.rfee_i  = sic_bran.uwm101.rfee_i       
    sicuw.uwm101.rtax_i  = sic_bran.uwm101.rtax_i       
    sicuw.uwm101.desc_i  = sic_bran.uwm101.desc_i       
    sicuw.uwm101.trty1i  = sic_bran.uwm101.trty1i       
    sicuw.uwm101.docnoi  = sic_bran.uwm101.docnoi
    /*---Begin by Chaiyong W. A68-0034 15/05/2025*/
    sicuw.uwm101.com3_i   = sic_bran.uwm101.com3_i  
    sicuw.uwm101.com4_i   = sic_bran.uwm101.com4_i  
    sicuw.uwm101.prem_g   = sic_bran.uwm101.prem_g  
    sicuw.uwm101.com1_g   = sic_bran.uwm101.com1_g  
    sicuw.uwm101.com3_g   = sic_bran.uwm101.com3_g  
    sicuw.uwm101.com4_g   = sic_bran.uwm101.com4_g  
    sicuw.uwm101.gstae    = sic_bran.uwm101.gstae   
    sicuw.uwm101.trty2i   = sic_bran.uwm101.trty2i  
    sicuw.uwm101.trty3i   = sic_bran.uwm101.trty3i  
    sicuw.uwm101.docno2   = sic_bran.uwm101.docno2  
    sicuw.uwm101.docno3   = sic_bran.uwm101.docno3  
    sicuw.uwm101.insref_i = sic_bran.uwm101.insref_i
    sicuw.uwm101.chr1     = sic_bran.uwm101.chr1    
    sicuw.uwm101.chr2     = sic_bran.uwm101.chr2    
    sicuw.uwm101.chr3     = sic_bran.uwm101.chr3    
    sicuw.uwm101.chr4     = sic_bran.uwm101.chr4    
    sicuw.uwm101.chr5     = sic_bran.uwm101.chr5    
    sicuw.uwm101.date1    = sic_bran.uwm101.date1   
    sicuw.uwm101.date2    = sic_bran.uwm101.date2   
    sicuw.uwm101.dec1     = sic_bran.uwm101.dec1    
    sicuw.uwm101.dec2     = sic_bran.uwm101.dec2    
    sicuw.uwm101.int1     = sic_bran.uwm101.int1    
    sicuw.uwm101.int2     = sic_bran.uwm101.int2    
    sicuw.uwm101.flgprn   = sic_bran.uwm101.flgprn  
    sicuw.uwm101.accod    = sic_bran.uwm101.accod   
    sicuw.uwm101.effdat   = sic_bran.uwm101.effdat  
    sicuw.uwm101.prndat   = sic_bran.uwm101.prndat  
    sicuw.uwm101.com1ae   = sic_bran.uwm101.com1ae  
    sicuw.uwm101.com2ae   = sic_bran.uwm101.com2ae  
    sicuw.uwm101.com3ae   = sic_bran.uwm101.com3ae  
    sicuw.uwm101.com4ae   = sic_bran.uwm101.com4ae  
    sicuw.uwm101.pstpae   = sic_bran.uwm101.pstpae  
    sicuw.uwm101.stmpae   = sic_bran.uwm101.stmpae  
    sicuw.uwm101.pfeeae   = sic_bran.uwm101.pfeeae  
    sicuw.uwm101.rfeeae   = sic_bran.uwm101.rfeeae  
    sicuw.uwm101.ptaxae   = sic_bran.uwm101.ptaxae  
    sicuw.uwm101.taxae    = sic_bran.uwm101.taxae   
    sicuw.uwm101.ltdocno  = sic_bran.uwm101.ltdocno 
    sicuw.uwm101.pprem_t  = sic_bran.uwm101.pprem_t 
    sicuw.uwm101.pcom1_t  = sic_bran.uwm101.pcom1_t 
    sicuw.uwm101.pcom2_t  = sic_bran.uwm101.pcom2_t 
    sicuw.uwm101.pcom3_t  = sic_bran.uwm101.pcom3_t 
    sicuw.uwm101.pcom4_t  = sic_bran.uwm101.pcom4_t 
    sicuw.uwm101.ppstp_t  = sic_bran.uwm101.ppstp_t 
    sicuw.uwm101.prstp_t  = sic_bran.uwm101.prstp_t 
    sicuw.uwm101.ppfee_t  = sic_bran.uwm101.ppfee_t 
    sicuw.uwm101.prfee_t  = sic_bran.uwm101.prfee_t 
    sicuw.uwm101.pptax_t  = sic_bran.uwm101.pptax_t 
    sicuw.uwm101.prtax_t  = sic_bran.uwm101.prtax_t 
    sicuw.uwm101.invoice  = sic_bran.uwm101.invoice 
    /*End by chaiyong W. A68-0034 15/05/2025-----*/
      
      
      
      
      
      
      
      
      
      
      
      
      
      .
END.
