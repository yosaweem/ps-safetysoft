/*---------------------**********-------------------------------------------------------*/
/* Program Id    : wgwMar01.P                                                           */
/* Copyright     # Safety Insurance Public Company Limited                              */
/*                 บริษัท ประกันคุ้มภัย จำกัด (มหาชน)                                   */
/* Motor Renewal :  CONNECT GwTransfer MODULE                                           */
/*               :  CALL GwCtxjob.P (Check List Data)                                   */
/* WRITE BY      :  A.Chantasen                                                         */
/* CONNECT       : Gw_Stat -ld brstat                                                   */  
/*               : Gw_safe -ld Sic_bran                                                 */   
/*               : Stat                                                                 */   
/*               : Sicuw                                                                */   
/* Modify By   : Piyacat P. A56-0357  Date 25-12-2013                                   */
/*               - ปรับแก้ไขการ Create ข้อมูล Icno & Branch Insure                      */
/* Modify by : Songkran P. & Tontawan S. A65-0141 29/11/2022 add field                  */   
/* Modigy By : Chaiyong W. A68-0034 19/05/2025                                          */
/*             Add Tranfer to Vat104                                                    */
/*---------------------**********-------------------------------------------------------*/
DEF INPUT PARAMETER nv_policy AS CHAR.
DEF INPUT PARAMETER nv_rencnt AS INT.
DEF INPUT PARAMETER nv_endcnt AS INT.
/*---Begin by Chaiyong W. A68-0034 19/05/2025-*/
DEF VAR nv_docno AS CHAR INIT "".
DEF VAR nv_taxno AS CHAR INIT "".
DEF VAR nv_brnins AS CHAR INIT "".
DEF VAR n_acnam   AS CHAR INIT "".
DEF VAR n_printbr AS CHAR INIT "".
def var nv_addv1  as char init "".
def var nv_addv2  as char init "".
def var nv_addv3  as char init "".
def var nv_addv4  as char init "".
def var n_add1    as char init "".
def var n_add2    as char init "".
/*End by Chaiyong W. A68-0034 19/05/2025------*/
FIND LAST brStat.Polmst_fil USE-INDEX Polmst01 
    WHERE brStat.Polmst_fil.policy = nv_policy
      AND brStat.Polmst_fil.rencnt = nv_rencnt
      AND brStat.Polmst_fil.endcnt = nv_endcnt NO-ERROR.  /*--Lock Record gw เพื่อ Update Status--*/
  IF AVAIL brStat.Polmst_fil THEN DO:
     FIND FIRST Stat.Polmst_fil USE-INDEX Polmst01
         WHERE Stat.Polmst_fil.policy = brStat.Polmst_fil.policy
           AND Stat.Polmst_fil.rencnt = brStat.Polmst_fil.rencnt
           AND Stat.Polmst_fil.endcnt = brStat.Polmst_fil.endcnt NO-LOCK NO-ERROR.
     IF NOT AVAIL Stat.Polmst_fil THEN DO:         
        CREATE Stat.Polmst_fil.
          ASSIGN
           Stat.Polmst_fil.branch  = brStat.Polmst_fil.branch               
           Stat.Polmst_fil.dir_ri  = brStat.Polmst_fil.dir_ri                   
           Stat.Polmst_fil.dept    = brStat.Polmst_fil.dept                     
           Stat.Polmst_fil.poltyp  = brStat.Polmst_fil.poltyp                   
           Stat.Polmst_fil.undyr   = brStat.Polmst_fil.undyr                    
           Stat.Polmst_fil.policy  = brStat.Polmst_fil.policy                   
           Stat.Polmst_fil.rencnt  = brStat.Polmst_fil.rencnt                   
           Stat.Polmst_fil.endcnt  = brStat.Polmst_fil.endcnt                   
           Stat.Polmst_fil.endno   = brStat.Polmst_fil.endno                    
           Stat.Polmst_fil.endform = brStat.Polmst_fil.endform                  
           Stat.Polmst_fil.appno   = brStat.Polmst_fil.appno                    
           Stat.Polmst_fil.prvpol  = brStat.Polmst_fil.prvpol                   
           Stat.Polmst_fil.langug  = brStat.Polmst_fil.langug                   
           Stat.Polmst_fil.insref  = brStat.Polmst_fil.insref                   
           Stat.Polmst_fil.ntitle  = brStat.Polmst_fil.ntitle                   
           Stat.Polmst_fil.name1   = brStat.Polmst_fil.name1                    
           Stat.Polmst_fil.name2   = brStat.Polmst_fil.name2                    
           Stat.Polmst_fil.name3   = brStat.Polmst_fil.name3                    
           Stat.Polmst_fil.addr1   = brStat.Polmst_fil.addr1                    
           Stat.Polmst_fil.addr2   = brStat.Polmst_fil.addr2                    
           Stat.Polmst_fil.addr3   = brStat.Polmst_fil.addr3              
           Stat.Polmst_fil.addr4   = brStat.Polmst_fil.addr4                    
           Stat.Polmst_fil.postcd  = brStat.Polmst_fil.postcd                   
           Stat.Polmst_fil.telno   = brStat.Polmst_fil.telno                    
           Stat.Polmst_fil.faxno   = brStat.Polmst_fil.faxno                    
           Stat.Polmst_fil.occupn  = brStat.Polmst_fil.occupn                   
           Stat.Polmst_fil.birdat  = brStat.Polmst_fil.birdat 

            /*Stat.Polmst_fil.age     = brStat.Polmst_fil.age  -- Piyachat A56-0357 --*/                       
            SUBSTRING(Stat.Polmst_fil.age,1,14)     = TRIM(SUBSTRING(brStat.Polmst_fil.age,1,14))
            SUBSTRING(Stat.Polmst_fil.age,20,5)     = TRIM(SUBSTRING(brStat.Polmst_fil.age,20,5))

           Stat.Polmst_fil.acno1   = brStat.Polmst_fil.acno1                    
           Stat.Polmst_fil.acno2   = brStat.Polmst_fil.acno2                    
           Stat.Polmst_fil.agent   = brStat.Polmst_fil.agent                    
           Stat.Polmst_fil.comdat  = brStat.Polmst_fil.comdat                   
           Stat.Polmst_fil.expdat  = brStat.Polmst_fil.expdat                   
           Stat.Polmst_fil.polday  = brStat.Polmst_fil.polday                   
           Stat.Polmst_fil.accdat  = brStat.Polmst_fil.accdat                   
           Stat.Polmst_fil.acctim  = brStat.Polmst_fil.acctim                   
           Stat.Polmst_fil.trndat  = brStat.Polmst_fil.trndat                   
           Stat.Polmst_fil.enddat  = brStat.Polmst_fil.enddat                   
           Stat.Polmst_fil.endday  = brStat.Polmst_fil.endday                   
           Stat.Polmst_fil.fstdat  = brStat.Polmst_fil.fstdat                   
           Stat.Polmst_fil.polsta  = brStat.Polmst_fil.polsta                   
           Stat.Polmst_fil.scform  = brStat.Polmst_fil.scform                   
           Stat.Polmst_fil.finint  = brStat.Polmst_fil.finint                   
           Stat.Polmst_fil.cedco   = brStat.Polmst_fil.cedco  .
          ASSIGN
           Stat.Polmst_fil.cedsi      = brStat.Polmst_fil.cedsi                    
           Stat.Polmst_fil.cedpol     = brStat.Polmst_fil.cedpol                   
           Stat.Polmst_fil.cedces     = brStat.Polmst_fil.cedces                   
           Stat.Polmst_fil.coins      = brStat.Polmst_fil.coins                    
           Stat.Polmst_fil.billco     = brStat.Polmst_fil.billco                   
           Stat.Polmst_fil.co_per     = brStat.Polmst_fil.co_per                   
           Stat.Polmst_fil.short      = brStat.Polmst_fil.short     
           Stat.Polmst_fil.short_per  = brStat.Polmst_fil.short_per           
           Stat.Polmst_fil.curbil     = brStat.Polmst_fil.curbil                   
           Stat.Polmst_fil.curate     = brStat.Polmst_fil.curate                   
           Stat.Polmst_fil.sigr_p     = brStat.Polmst_fil.sigr_p                   
           Stat.Polmst_fil.sico_p     = brStat.Polmst_fil.sico_p                   
           Stat.Polmst_fil.sist_p     = brStat.Polmst_fil.sist_p                   
           Stat.Polmst_fil.sitfp_p    = brStat.Polmst_fil.sitfp_p                  
           Stat.Polmst_fil.sity_p     = brStat.Polmst_fil.sity_p                   
           Stat.Polmst_fil.sity1_p    = brStat.Polmst_fil.sity1_p                  
           Stat.Polmst_fil.sity2_p    = brStat.Polmst_fil.sity2_p                
           Stat.Polmst_fil.sifc_p     = brStat.Polmst_fil.sifc_p                   
           Stat.Polmst_fil.sifcl_p    = brStat.Polmst_fil.sifcl_p                  
           Stat.Polmst_fil.sifcf_p    = brStat.Polmst_fil.sifcf_p 
           Stat.Polmst_fil.sirq_p     =  brStat.Polmst_fil.sirq_p    
           Stat.Polmst_fil.siret_p    =  brStat.Polmst_fil.siret_p                   
           Stat.Polmst_fil.instot     =  brStat.Polmst_fil.instot                      
           Stat.Polmst_fil.tranty     =  brStat.Polmst_fil.tranty                      
           Stat.Polmst_fil.trty11     =  brStat.Polmst_fil.trty11                      
           Stat.Polmst_fil.trty12     =  brStat.Polmst_fil.trty12                      
           Stat.Polmst_fil.docno1ae   =  brStat.Polmst_fil.docno1ae                    
           Stat.Polmst_fil.docno1     =  brStat.Polmst_fil.docno1                      
           Stat.Polmst_fil.docno2     =  brStat.Polmst_fil.docno2                      
           Stat.Polmst_fil.dup_trp    =  brStat.Polmst_fil.dup_trp                     
           Stat.Polmst_fil.pstp       =  brStat.Polmst_fil.pstp                        
           Stat.Polmst_fil.pfee       =  brStat.Polmst_fil.pfee                        
           Stat.Polmst_fil.ptax       =  brStat.Polmst_fil.ptax                        
           Stat.Polmst_fil.tax_p      =  brStat.Polmst_fil.tax_p                    
           Stat.Polmst_fil.stmpae     =  brStat.Polmst_fil.stmpae                      
           Stat.Polmst_fil.rstp_t     =  brStat.Polmst_fil.rstp_t                      
           Stat.Polmst_fil.rfee_t     =  brStat.Polmst_fil.rfee_t                      
           Stat.Polmst_fil.taxae      =  brStat.Polmst_fil.taxae                       
           Stat.Polmst_fil.rtax_t     =  brStat.Polmst_fil.rtax_t                      
           Stat.Polmst_fil.gap_p      =  brStat.Polmst_fil.gap_p                       
           Stat.Polmst_fil.premae     =  brStat.Polmst_fil.premae                      
           Stat.Polmst_fil.prem_t     =  brStat.Polmst_fil.prem_t        
           Stat.Polmst_fil.gapcomp_t  =  brStat.Polmst_fil.gapcomp_t                   
           Stat.Polmst_fil.pdcomp_t   =  brStat.Polmst_fil.pdcomp_t                    
           Stat.Polmst_fil.pdco_t     =  brStat.Polmst_fil.pdco_t       
           Stat.Polmst_fil.pdst_t     =  brStat.Polmst_fil.pdst_t                      
           Stat.Polmst_fil.pdtfp_t    =  brStat.Polmst_fil.pdtfp_t                     
           Stat.Polmst_fil.pdty_t     =  brStat.Polmst_fil.pdty_t                      
           Stat.Polmst_fil.pdty1_t    =  brStat.Polmst_fil.pdty1_t                     
           Stat.Polmst_fil.pdty2_t    =  brStat.Polmst_fil.pdty2_t                     
           Stat.Polmst_fil.pdfc_t     =  brStat.Polmst_fil.pdfc_t                      
           Stat.Polmst_fil.pdfcl_t    =  brStat.Polmst_fil.pdfcl_t                     
           Stat.Polmst_fil.pdfcf_t    =  brStat.Polmst_fil.pdfcf_t                     
           Stat.Polmst_fil.pdrq_t     =  brStat.Polmst_fil.pdrq_t                      
           Stat.Polmst_fil.pdret_t    =  brStat.Polmst_fil.pdret_t                     
           Stat.Polmst_fil.com1ae     =  brStat.Polmst_fil.com1ae     .
           ASSIGN
           Stat.Polmst_fil.com1_per   =  brStat.Polmst_fil.com1_per                    
           Stat.Polmst_fil.com2_per   =  brStat.Polmst_fil.com2_per                    
           Stat.Polmst_fil.com1_t     =  brStat.Polmst_fil.com1_t                      
           Stat.Polmst_fil.com2_t     =  brStat.Polmst_fil.com2_t                      
           Stat.Polmst_fil.coco_t     =  brStat.Polmst_fil.coco_t                      
           Stat.Polmst_fil.cost_t     =  brStat.Polmst_fil.cost_t                      
           Stat.Polmst_fil.cotfp_t    =  brStat.Polmst_fil.cotfp_t                     
           Stat.Polmst_fil.coty_t     =  brStat.Polmst_fil.coty_t                      
           Stat.Polmst_fil.coty1_t    =  brStat.Polmst_fil.coty1_t                     
           Stat.Polmst_fil.coty2_t    =  brStat.Polmst_fil.coty2_t              
           Stat.Polmst_fil.cofc_t     =  brStat.Polmst_fil.cofc_t                      
           Stat.Polmst_fil.cofcl_t    =  brStat.Polmst_fil.cofcl_t                     
           Stat.Polmst_fil.cofcf_t    =  brStat.Polmst_fil.cofcf_t                     
           Stat.Polmst_fil.corq_t     =  brStat.Polmst_fil.corq_t                      
           Stat.Polmst_fil.coret_t    =  brStat.Polmst_fil.coret_t                     
           Stat.Polmst_fil.sch_p      =  brStat.Polmst_fil.sch_p                       
           Stat.Polmst_fil.drn_p      =  brStat.Polmst_fil.drn_p                       
           Stat.Polmst_fil.ri_p       =  brStat.Polmst_fil.ri_p      
           Stat.Polmst_fil.usrid      =  brStat.Polmst_fil.usrid                       
           Stat.Polmst_fil.entdat     =  brStat.Polmst_fil.entdat                      
           Stat.Polmst_fil.enttim     =  brStat.Polmst_fil.enttim                      
           Stat.Polmst_fil.usrrew     =  brStat.Polmst_fil.usrrew                      
           Stat.Polmst_fil.rewdat     =  brStat.Polmst_fil.rewdat                      
           Stat.Polmst_fil.rewtim     =  brStat.Polmst_fil.rewtim                      
           Stat.Polmst_fil.releas     =  NO
           Stat.Polmst_fil.usrrel     =  ""
           Stat.Polmst_fil.reldat     =  ?
           Stat.Polmst_fil.reltim     =  "".
          ASSIGN            
           Stat.Polmst_fil.sigr_for     =  brStat.Polmst_fil.sigr_for                   
           Stat.Polmst_fil.poltxt       =  brStat.Polmst_fil.poltxt                     
           Stat.Polmst_fil.patttxt      =  brStat.Polmst_fil.patttxt                    
           Stat.Polmst_fil.endtxt       =  brStat.Polmst_fil.endtxt                     
           Stat.Polmst_fil.eatttxt      =  brStat.Polmst_fil.eatttxt                    
           Stat.Polmst_fil.memotext     =  brStat.Polmst_fil.memotext                   
           Stat.Polmst_fil.sigr_endt    =  brStat.Polmst_fil.sigr_endt                  
           Stat.Polmst_fil.polncbae     =  brStat.Polmst_fil.polncbae                   
           Stat.Polmst_fil.polncb_per   =  brStat.Polmst_fil.polncb_per                 
           Stat.Polmst_fil.polncb_amt   =  brStat.Polmst_fil.polncb_amt                            
           Stat.Polmst_fil.prem_tot     =  brStat.Polmst_fil.prem_tot                   
           Stat.Polmst_fil.discae       =  brStat.Polmst_fil.discae                     
           Stat.Polmst_fil.disc_per     =  brStat.Polmst_fil.disc_per                   
           Stat.Polmst_fil.disc         =  brStat.Polmst_fil.disc                       
           Stat.Polmst_fil.siend        =  brStat.Polmst_fil.siend                      
           Stat.Polmst_fil.loadclm      =  brStat.Polmst_fil.loadclm                    
           Stat.Polmst_fil.credat       =  brStat.Polmst_fil.credat                     
           Stat.Polmst_fil.cretyp       =  brStat.Polmst_fil.cretyp                     
           Stat.Polmst_fil.cre_bank     =  brStat.Polmst_fil.cre_bank                   
           Stat.Polmst_fil.creno        =  brStat.Polmst_fil.creno                      
           Stat.Polmst_fil.appcode      =  brStat.Polmst_fil.appcode                 
           Stat.Polmst_fil.cre_expdat   =  brStat.Polmst_fil.cre_expdat              
           Stat.Polmst_fil.prog         =  brStat.Polmst_fil.prog                       
           Stat.Polmst_fil.multi        =  brStat.Polmst_fil.multi                      
           Stat.Polmst_fil.sennam       =  brStat.Polmst_fil.sennam                     
           Stat.Polmst_fil.recnam       =  brStat.Polmst_fil.recnam                     
           Stat.Polmst_fil.senby        =  brStat.Polmst_fil.senby                      
           Stat.Polmst_fil.recdat       =  brStat.Polmst_fil.recdat                     
           Stat.Polmst_fil.transfer     =  brStat.Polmst_fil.transfer. 
    /*--Begin A65-0141 29/11/2022*/
    ASSIGN
        stat.polmst_fil.enddat2         = brstat.polmst_fil.enddat2
        stat.polmst_fil.car_c           = brstat.polmst_fil.car_c  
        stat.polmst_fil.pac_c           = brstat.polmst_fil.pac_c  
        stat.polmst_fil.cou_c           = brstat.polmst_fil.cou_c  
        stat.polmst_fil.icno            = brstat.polmst_fil.icno   
        stat.polmst_fil.brind           = brstat.polmst_fil.brind  
        stat.polmst_fil.note1           = brstat.polmst_fil.note1  
        stat.polmst_fil.note2           = brstat.polmst_fil.note2  
        stat.polmst_fil.note3           = brstat.polmst_fil.note3  
        stat.polmst_fil.note4           = brstat.polmst_fil.note4  
        stat.polmst_fil.note5           = brstat.polmst_fil.note5  .
    /*End A65-0141 29/11/2022----*/



     END.  /*--Polmst_fil--*/
     /*--Create Prmmst_fil---*/
     FIND FIRST brStat.prmmst_fil
          WHERE brStat.prmmst_fil.policy =  nv_policy
            AND brStat.prmmst_fil.rencnt =  nv_rencnt
            AND brStat.prmmst_fil.endcnt =  nv_endcnt
            AND brStat.prmmst_fil.riskno  =  1 NO-LOCK NO-ERROR NO-WAIT.
     IF AVAILABLE brStat.prmmst_fil THEN DO:     
        FIND FIRST Stat.prmmst_fil 
             WHERE Stat.prmmst_fil.policy = brStat.prmmst_fil.policy
               AND Stat.prmmst_fil.rencnt = brStat.prmmst_fil.rencnt
               AND Stat.prmmst_fil.endcnt = brStat.prmmst_fil.endcnt
               AND Stat.prmmst_fil.riskno  =  1  NO-LOCK NO-ERROR NO-WAIT. /*--No-Lock เพราะเป็นการ Create New Record--*/
        IF NOT AVAILABLE Stat.prmmst_fil THEN DO:
           CREATE Stat.prmmst_fil.
           ASSIGN
             Stat.prmmst_fil.policy  =  brStat.prmmst_fil.policy 
             Stat.prmmst_fil.rencnt  =  brStat.prmmst_fil.rencnt 
             Stat.prmmst_fil.endcnt  =  brStat.prmmst_fil.endcnt 
             Stat.prmmst_fil.riskno  =  brStat.prmmst_fil.riskno 
             Stat.prmmst_fil.itemno  =  brStat.prmmst_fil.itemno 
             Stat.prmmst_fil.bencod  =  brStat.prmmst_fil.bencod 
             Stat.prmmst_fil.benvar  =  brStat.prmmst_fil.benvar 
             Stat.prmmst_fil.rate    =  brStat.prmmst_fil.rate   
             Stat.prmmst_fil.rateae  =  brStat.prmmst_fil.rateae 
             Stat.prmmst_fil.gap_ae  =  brStat.prmmst_fil.gap_ae 
             Stat.prmmst_fil.gap_c   =  brStat.prmmst_fil.gap_c  
             Stat.prmmst_fil.pd_aep  =  brStat.prmmst_fil.pd_aep 
             Stat.prmmst_fil.prem_c  =  brStat.prmmst_fil.prem_c 
             Stat.prmmst_fil.premae  =  brStat.prmmst_fil.premae .
        END.
     END. /*--Avail brStat.prmmst_fil--*/
     /*--Create Marine_fil--*/
     FIND FIRST brStat.marine_fil
          WHERE brStat.marine_fil.policy = nv_policy
            AND brStat.marine_fil.rencnt = nv_rencnt
            AND brStat.marine_fil.endcnt = nv_endcnt NO-LOCK NO-ERROR NO-WAIT.
     IF AVAILABLE brStat.marine_fil THEN DO:             
        FIND FIRST Stat.marine_fil 
             WHERE Stat.marine_fil.policy = brStat.marine_fil.policy
               AND Stat.marine_fil.rencnt = brStat.marine_fil.rencnt
               AND Stat.marine_fil.endcnt = brStat.marine_fil.endcnt NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAILABLE Stat.marine_fil THEN DO:
           CREATE Stat.marine_fil.
           ASSIGN
             Stat.Marine_fil.vessel    = brStat.Marine_fil.vessel        
             Stat.Marine_fil.vesno     = brStat.Marine_fil.vesno         
             Stat.Marine_fil.voydat    = brStat.Marine_fil.voydat        
             Stat.Marine_fil.vdat_c    = brStat.Marine_fil.vdat_c        
             Stat.Marine_fil.voyno     = brStat.Marine_fil.voyno         
             Stat.Marine_fil.voyage    = brStat.Marine_fil.voyage        
             Stat.Marine_fil.survey    = brStat.Marine_fil.survey        
             Stat.Marine_fil.settle    = brStat.Marine_fil.settle        
             Stat.Marine_fil.declrn    = brStat.Marine_fil.declrn        
             Stat.Marine_fil.und_si    = brStat.Marine_fil.und_si        
             Stat.Marine_fil.policy    = brStat.Marine_fil.policy        
             Stat.Marine_fil.rencnt    = brStat.Marine_fil.rencnt        
             Stat.Marine_fil.endcnt    = brStat.Marine_fil.endcnt        
             Stat.Marine_fil.riskgp    = brStat.Marine_fil.riskgp        
             Stat.Marine_fil.riskno    = brStat.Marine_fil.riskno        
             Stat.Marine_fil.claim_ie  = brStat.Marine_fil.claim_ie      
             Stat.Marine_fil.vessel2   = brStat.Marine_fil.vessel2       
             Stat.Marine_fil.vesno2    = brStat.Marine_fil.vesno2        
             Stat.Marine_fil.voyage2   = brStat.Marine_fil.voyage2       
             Stat.Marine_fil.trndat    = brStat.Marine_fil.trndat        
             Stat.Marine_fil.enddat    = brStat.Marine_fil.enddat        
             Stat.Marine_fil.endno     = brStat.Marine_fil.endno         
             Stat.Marine_fil.cluno     = brStat.Marine_fil.cluno       
             Stat.Marine_fil.clause[1] = brStat.Marine_fil.clause[1]
             Stat.Marine_fil.clause[2] = brStat.Marine_fil.clause[2]
             Stat.Marine_fil.clause[3] = brStat.Marine_fil.clause[3]
             Stat.Marine_fil.clause[4] = brStat.Marine_fil.clause[4]
             Stat.Marine_fil.clause[5] = brStat.Marine_fil.clause[5]
             Stat.Marine_fil.clause[6] = brStat.Marine_fil.clause[6]
             Stat.Marine_fil.clause[7] = brStat.Marine_fil.clause[7]
             Stat.Marine_fil.netprm    = brStat.Marine_fil.netprm        
             Stat.Marine_fil.impexp    = brStat.Marine_fil.impexp        
             Stat.Marine_fil.curbil    = brStat.Marine_fil.curbil        
             Stat.Marine_fil.sigr_for  = brStat.Marine_fil.sigr_for      
             Stat.Marine_fil.curate    = brStat.Marine_fil.curate        
             Stat.Marine_fil.sigr      = brStat.Marine_fil.sigr .
            /*--Begin A65-0141 29/11/2022*/
            ASSIGN
                 stat.marine_fil.car_c           = brstat.marine_fil.car_c     
                 stat.marine_fil.pac_c           = brstat.marine_fil.pac_c     
                 stat.marine_fil.cou_c           = brstat.marine_fil.cou_c     
                 stat.marine_fil.mcode           = brstat.marine_fil.mcode     
                 stat.marine_fil.mdes            = brstat.marine_fil.mdes      
                 stat.marine_fil.note1           = brstat.marine_fil.note1     
                 stat.marine_fil.note2           = brstat.marine_fil.note2     
                 stat.marine_fil.note3           = brstat.marine_fil.note3     
                 stat.marine_fil.note4           = brstat.marine_fil.note4     
                 stat.marine_fil.note5           = brstat.marine_fil.note5  .   
            /*End A65-0141 29/11/2022----*/
        END.                             
     END. /*--Avail brStat.Marine_fil--*/

     /*--Create brStat.poltxt_fil--*/
     FOR EACH Stat.poltxt_fil WHERE 
              Stat.poltxt_fil.policy = nv_policy :
         DELETE Stat.Poltxt_fil.
     END.
     FOR EACH brStat.poltxt_fil WHERE 
              brStat.poltxt_fil.policy = nv_policy NO-LOCK:
         CREATE Stat.Poltxt_fil.
         ASSIGN
           Stat.Poltxt_fil.policy  = brStat.Poltxt_fil.policy 
           Stat.Poltxt_fil.lnumber = brStat.Poltxt_fil.lnumber     
           Stat.Poltxt_fil.ltext   = brStat.Poltxt_fil.ltext       
           Stat.Poltxt_fil.ltext2  = brStat.Poltxt_fil.ltext2.     
     END.

     /*--Create brStat.ucrisk--*/
     FIND FIRST Sic_bran.ucrisk 
          WHERE Sic_bran.ucrisk.point  = nv_policy
            AND Sic_bran.ucrisk.locatn = nv_rencnt
            AND Sic_bran.ucrisk.endcnt = nv_endcnt
            AND Sic_bran.ucrisk.riskno = 1 NO-LOCK NO-ERROR NO-WAIT.
     IF AVAILABLE  Sic_bran.ucrisk THEN DO:     
        FIND FIRST sicuw.ucrisk 
             WHERE sicuw.ucrisk.point  = Sic_bran.ucrisk.point
               AND sicuw.ucrisk.locatn = Sic_bran.ucrisk.locatn
               AND sicuw.ucrisk.endcnt = Sic_bran.ucrisk.endcnt
               AND sicuw.ucrisk.riskno = Sic_bran.ucrisk.riskno  NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAILABLE sicuw.ucrisk THEN DO:        
           CREATE sicuw.ucrisk.
           ASSIGN
             sicuw.ucrisk.point    = Sic_bran.ucrisk.point  
             sicuw.ucrisk.locatn   = Sic_bran.ucrisk.locatn 
             sicuw.ucrisk.endcnt   = Sic_bran.ucrisk.endcnt 
             sicuw.ucrisk.riskno   = Sic_bran.ucrisk.riskno 
             sicuw.ucrisk.mode1    = Sic_bran.ucrisk.mode1  
             sicuw.ucrisk.mode2    = Sic_bran.ucrisk.mode2  
             sicuw.ucrisk.mode3    = Sic_bran.ucrisk.mode3  
             sicuw.ucrisk.cmamt1   = Sic_bran.ucrisk.cmamt1 
             sicuw.ucrisk.cmper1   = Sic_bran.ucrisk.cmper1 
             sicuw.ucrisk.stamp    = Sic_bran.ucrisk.stamp  
             sicuw.ucrisk.tax      = Sic_bran.ucrisk.tax    
             sicuw.ucrisk.fee      = Sic_bran.ucrisk.fee    
             sicuw.ucrisk.ritba    = Sic_bran.ucrisk.ritba  
             sicuw.ucrisk.rissi    = Sic_bran.ucrisk.rissi  .
           /*--Begin A65-0141 29/11/2022*/
           ASSIGN
                sicuw.ucrisk.class     = sic_Bran.ucrisk.class     
                sicuw.ucrisk.sicurr    = sic_Bran.ucrisk.sicurr    
                sicuw.ucrisk.siexch    = sic_Bran.ucrisk.siexch    
                sicuw.ucrisk.textno    = sic_Bran.ucrisk.textno    
                sicuw.ucrisk.sval      = sic_Bran.ucrisk.sval      
                sicuw.ucrisk.deletes   = sic_Bran.ucrisk.deletes  
                sicuw.ucrisk.cmamt2    = sic_Bran.ucrisk.cmamt2    
                sicuw.ucrisk.cmamt3    = sic_Bran.ucrisk.cmamt3    
                sicuw.ucrisk.cmper2    = sic_Bran.ucrisk.cmper2    
                sicuw.ucrisk.cmper3    = sic_Bran.ucrisk.cmper3    
                sicuw.ucrisk.stamp     = sic_Bran.ucrisk.stamp     
                sicuw.ucrisk.fee       = sic_Bran.ucrisk.fee       
                sicuw.ucrisk.tax       = sic_Bran.ucrisk.tax       
                sicuw.ucrisk.pdgros    = sic_Bran.ucrisk.pdgros    
                sicuw.ucrisk.rdval1    = sic_Bran.ucrisk.rdval1    
                sicuw.ucrisk.rdval2    = sic_Bran.ucrisk.rdval2    
                sicuw.ucrisk.rdval3    = sic_Bran.ucrisk.rdval3    
                sicuw.ucrisk.rgap      = sic_Bran.ucrisk.rgap      
                sicuw.ucrisk.pdstat    = sic_Bran.ucrisk.pdstat    
                sicuw.ucrisk.coper     = sic_Bran.ucrisk.coper     
                sicuw.ucrisk.risper    = sic_Bran.ucrisk.risper    
                sicuw.ucrisk.cosi      = sic_Bran.ucrisk.cosi      
                sicuw.ucrisk.siae      = sic_Bran.ucrisk.siae      
                sicuw.ucrisk.cmstat    = sic_Bran.ucrisk.cmstat . 
           /*End A65-0141 29/11/2022----*/


        END.
     END.
     /*---Begin by Chaiyong W. A68-0034 19/05/2025-*/
    IF substr(stat.polmst_fil.policy,1,1) <> "C" THEN DO:

        ASSIGN
            nv_docno                = stat.polmst_fil.docno1
            nv_docno                = nv_docno 
            nv_taxno                = TRIM(SUBSTRING(stat.polmst_fil.age,1,14))
            nv_brnins               = TRIM(SUBSTRING(stat.polmst_fil.age,20,5))
            stat.polmst_fil.ptvdat  = stat.polmst_fil.fstdat  
            stat.polmst_fil.ptvttim = STRING(TIME,"hh:mm:ss") 
            stat.polmst_fil.ptvusr  = USERID(LDBNAME(1)) NO-ERROR.
        IF length(stat.polmst_fil.ptvttim) > 10 THEN  stat.polmst_fil.ptvttim = SUBSTR(stat.polmst_fil.ptvttim,1,10).
        ASSIGN
            stat.polmst_fil.code1   = "WGWTRN90"
            stat.polmst_fil.code1   = stat.polmst_fil.code1 + FILL(" ",10  -  LENGTH(stat.polmst_fil.code1))
            stat.polmst_fil.code1   = stat.polmst_fil.code1 +  STRING(stat.polmst_fil.ptvdat,"99/99/9999") + stat.polmst_fil.ptvttim
            stat.polmst_fil.code1   = stat.polmst_fil.code1 + FILL(" ",30 -  LENGTH(stat.polmst_fil.code1)) + stat.polmst_fil.ptvusr
            stat.polmst_fil.code1   = stat.polmst_fil.code1 + FILL(" ",40 -  LENGTH(stat.polmst_fil.code1)) + "S"
            stat.polmst_fil.code1   = stat.polmst_fil.code1 + FILL(" ",100 -  LENGTH(stat.polmst_fil.code1)) + "WGWTRN90".
        FIND sicsyac.xmm600 WHERE sicsyac.xmm600.acno  = stat.polmst_fil.acno1 NO-LOCK NO-ERROR.
        IF AVAIL sicsyac.xmm600  THEN n_acnam  = sicsyac.xmm600.name.
        
        n_printbr = TRIM(SUBSTRING(stat.polmst_fil.ptvusr,6,2)).
        RUN wuw\wuwpbrns1 (INPUT  TODAY,  /*Branch User*/
                           INPUT  n_printbr,
                           INPUT  stat.polmst_fil.langug,
                           OUTPUT n_printbr ,
                           OUTPUT nv_addv1  ,
                           OUTPUT nv_addv2  ,
                           OUTPUT nv_addv3  ,
                           OUTPUT nv_addv4 ).
        ASSIGN
            n_add1    = nv_addv1  + " " + nv_addv2
            n_add2    = nv_addv3  + " " + nv_addv4.
        
        
        CREATE brstat.vat100.                                                                                     
        ASSIGN                                                                                             
            brstat.vat100.invtyp    = "S" /** ประเภทภาษีขาย **/                                                      
            brstat.vat100.invoice   = nv_docno
            brstat.vat100.invdat    = stat.polmst_fil.ptvdat
            brstat.vat100.poltyp    = stat.polmst_fil.poltyp                                                              
            brstat.vat100.policy    = stat.polmst_fil.policy                                                              
            brstat.vat100.rencnt    = stat.polmst_fil.rencnt                                                              
            brstat.vat100.endcnt    = stat.polmst_fil.endcnt                                                              
            brstat.vat100.branch    = stat.polmst_fil.branch                                                              
            brstat.vat100.invbrn    = SUBSTRING(USERID(LDBNAME(1)),6,2)                                                          
            brstat.vat100.acno      = stat.polmst_fil.acno1                                                               
            brstat.vat100.agent     = stat.polmst_fil.agent                                                               
            brstat.vat100.trnty1    = "M"                                                         
            brstat.vat100.refno     = nv_docno                                                          
            brstat.vat100.amount    = stat.polmst_fil.prem_t + stat.polmst_fil.pstp + stat.polmst_fil.rstp_t   /* prm + stamp        */                                                
            brstat.vat100.discamt   = 0      /* disc               */                                                
            brstat.vat100.totamt    = stat.polmst_fil.prem_t + stat.polmst_fil.pstp + stat.polmst_fil.rstp_t /* prm + stamp        */                                                
            brstat.vat100.vatamt    = stat.polmst_fil.rtax_t + stat.polmst_fil.ptax  /* tax                */                                                
            brstat.vat100.grandamt  = stat.polmst_fil.prem_t + stat.polmst_fil.pstp + stat.polmst_fil.rstp_t + stat.polmst_fil.rtax_t + stat.polmst_fil.ptax  /* prm + stamp + tax  */                                                 
            brstat.vat100.pvrvjv    = " "     
            brstat.vat100.insref    = stat.polmst_fil.insref
            brstat.vat100.name      = TRIM(TRIM(stat.polmst_fil.ntitle) + " " + TRIM(stat.polmst_fil.name1))
            brstat.vat100.add1      = TRIM(stat.polmst_fil.addr1) 
            brstat.vat100.add2      = TRIM(stat.polmst_fil.addr2) 
            brstat.vat100.desci     = "ค่าเบี้ยประกันตามกรมธรรม์เลขที่ " + stat.polmst_fil.policy                                      
            brstat.vat100.descdis   = "หักส่วนลด"                                                                    
            brstat.vat100.entdat    = TODAY                                                                          
            brstat.vat100.enttime   = STRING(TIME,"hh:mm:ss")                                                        
            brstat.vat100.usrid     = stat.polmst_fil.ptvusr                                                                        
            brstat.vat100.remark1   = " "                                                                            
            brstat.vat100.remark2   = " "                                                                            
            brstat.vat100.print     = YES       
            brstat.vat100.program   = "WGWTRN90"
            brstat.vat100.taxmont   =  MONTH(stat.polmst_fil.ptvdat)
            brstat.vat100.taxyear   =  YEAR (stat.polmst_fil.ptvdat) 
            brstat.vat100.taxrepm   =  NO
            brstat.vat100.taxno     =  nv_taxno + FILL(" ",19 - LENGTH(nv_taxno)) + nv_brnins
            brstat.vat100.endno     = ""
            brstat.vat100.comdat    = ?
            brstat.vat100.addr3     = TRIM(stat.polmst_fil.addr3)
            brstat.vat100.addr4     = TRIM(stat.polmst_fil.addr4)
            brstat.vat100.postcode  = stat.polmst_fil.postcd
            brstat.vat100.expdat    = ?
            brstat.vat100.accdat    = stat.polmst_fil.accdat
            brstat.vat100.brnins    = nv_brnins     
            brstat.vat100.ac_name   = n_acnam  
            brstat.vat100.vdeci1    = stat.polmst_fil.prem_t
            brstat.vat100.vdeci2    = stat.polmst_fil.pstp + stat.polmst_fil.rstp_t 
            brstat.vat100.brncod    = n_printbr
            brstat.vat100.brnadd1   = n_add1 
            brstat.vat100.brnadd2   = n_add2  
            brstat.vat100.prndat    = TODAY
            brstat.vat100.ntitle    = stat.polmst_fil.ntitle
            brstat.vat100.firstname = stat.polmst_fil.name1 .
        IF stat.polmst_fil.firstname <> "" THEN DO:
            ASSIGN
                brstat.vat100.firstname = stat.polmst_fil.firstname 
                brstat.vat100.lastname  = stat.polmst_fil.lastname.
        END.
        //brstat.vat100.ratevat = stat.polmst_fil.gstrat.
        IF stat.polmst_fil.rtax_t  = 0 THEN brstat.vat100.ratevat = 0.
        ELSE brstat.vat100.ratevat = 7.
        
        {wgw\wgwvptv1.i}.
                                                  
        RELEASE brstat.vat100 NO-ERROR. 
        RELEASE stat.vat104 NO-ERROR. 
    END.

     /*End by Chaiyong W. A68-0034 19/05/2025------*/
END. /*--Polmst_fil--*/
 
