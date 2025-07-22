/*=================================================================*/
/* Program Name : wGwGen02.P   Gen. Data Uwm120 To DB Premium      */
/* Assign  No   : A54-0005                                         */
/* CREATE  By   : Amparat C.           (Date 23/12/2010)           */
/*                โอนข้อมูลจาก DB Gw Transfer To Premium           */
/* Modify By : Narin L.  A58-0123   (Date 11-05-2015) 
               ปรับการ Transfer uwd103 , uwd104 , uwd105 , uwd106  */ 
/* Modify by : Songkran P. A65-0141 28/11/2022 add field           */               
/*=================================================================*/
DEF INPUT PARAMETER nv_bchyr  AS INT.
DEF INPUT PARAMETER nv_bchno  AS CHAR.
DEF INPUT PARAMETER nv_bchcnt AS INT.
DEF INPUT PARAMETER nv_policy AS CHAR.
DEF INPUT PARAMETER nv_rencnt AS INT.
DEF INPUT PARAMETER nv_endcnt AS INT.

/*---Begin by Narin L. A58-0123 11/05/2015*/
def var nv_fptr as recid.
def var nv_bptr as recid.

def buffer wf_uwd120 for sicuw.uwd120.
def buffer wf_uwd121 for sicuw.uwd121.
def buffer wf_uwd123 for sicuw.uwd123.
def buffer wf_uwd124 for sicuw.uwd124.
def buffer wf_uwd125 for sicuw.uwd125.
def buffer wf_uwd126 for sicuw.uwd126.
/*End by Narin L. A58-0123 11/05/2015-----*/
                                      /*---
FIND sic_bran.uwm120 USE-INDEX uwm12001 WHERE
     sic_bran.uwm120.policy  = nv_Policy AND
     sic_bran.uwm120.rencnt  = nv_RenCnt AND
     sic_bran.uwm120.endcnt  = nv_EndCnt AND
     sic_bran.uwm120.bchyr   = nv_bchyr  AND
     sic_bran.uwm120.bchno   = nv_bchno  AND
     sic_bran.uwm120.bchcnt  = nv_bchcnt NO-LOCK NO-ERROR.
IF AVAIL sic_bran.uwm120  THEN DO:  
comment by Chaiyong W. A58-0123 16/06/2015*/

/*---Begin by Chaiyong W. A58-0123 16/06/2015*/
FOR EACH sic_bran.uwm120 USE-INDEX uwm12001 WHERE
         sic_bran.uwm120.policy  = nv_Policy AND
         sic_bran.uwm120.rencnt  = nv_RenCnt AND
         sic_bran.uwm120.endcnt  = nv_EndCnt AND
         sic_bran.uwm120.bchyr   = nv_bchyr  AND
         sic_bran.uwm120.bchno   = nv_bchno  AND
         sic_bran.uwm120.bchcnt  = nv_bchcnt NO-LOCK:
/*End by Chaiyong w. A58-0123 16/06/2015-----*/

   FIND sicuw.uwm120 WHERE
         sicuw.uwm120.policy = sic_bran.uwm120.policy AND
         sicuw.uwm120.rencnt = sic_bran.uwm120.rencnt AND
         sicuw.uwm120.endcnt = sic_bran.uwm120.endcnt AND
         sicuw.uwm120.riskgp = sic_bran.uwm120.riskgp AND
         sicuw.uwm120.riskno = sic_bran.uwm120.riskno NO-ERROR.
   IF NOT AVAILABLE sicuw.uwm120 THEN DO:
     CREATE sicuw.uwm120.   
       ASSIGN
        sicuw.uwm120.policy      = sic_bran.uwm120.policy
        sicuw.uwm120.rencnt      = sic_bran.uwm120.rencnt
        sicuw.uwm120.endcnt      = sic_bran.uwm120.endcnt
        sicuw.uwm120.bptr01      = 0
        sicuw.uwm120.bptr02      = 0
        sicuw.uwm120.bptr03      = 0
        sicuw.uwm120.bptr04      = 0
        sicuw.uwm120.bptr08      = 0
        sicuw.uwm120.bptr09      = 0
        sicuw.uwm120.class       = sic_bran.uwm120.class
        sicuw.uwm120.com1ae      = sic_bran.uwm120.com1ae
        sicuw.uwm120.com1p       = sic_bran.uwm120.com1p
        sicuw.uwm120.com1_r      = sic_bran.uwm120.com1_r
        sicuw.uwm120.com2ae      = sic_bran.uwm120.com2ae
        sicuw.uwm120.com2p       = sic_bran.uwm120.com2p
        sicuw.uwm120.com2_r      = sic_bran.uwm120.com2_r
        sicuw.uwm120.com3ae      = sic_bran.uwm120.com3ae
        sicuw.uwm120.com3p       = sic_bran.uwm120.com3p
        sicuw.uwm120.com3_r      = sic_bran.uwm120.com3_r
        sicuw.uwm120.com4ae      = sic_bran.uwm120.com4ae
        sicuw.uwm120.com4p       = sic_bran.uwm120.com4p
        sicuw.uwm120.com4_r      = sic_bran.uwm120.com4_r
        sicuw.uwm120.comco       = sic_bran.uwm120.comco
        sicuw.uwm120.comfac      = sic_bran.uwm120.comfac
        sicuw.uwm120.comqs       = sic_bran.uwm120.comqs
        sicuw.uwm120.comst       = sic_bran.uwm120.comst
        sicuw.uwm120.comtty      = sic_bran.uwm120.comtty
        sicuw.uwm120.dl1_r       = sic_bran.uwm120.dl1_r
        sicuw.uwm120.dl2_r       = sic_bran.uwm120.dl2_r
        sicuw.uwm120.dl3_r       = sic_bran.uwm120.dl3_r
        sicuw.uwm120.feeae       = sic_bran.uwm120.feeae
        sicuw.uwm120.fptr01      = 0
        sicuw.uwm120.fptr02      = 0
        sicuw.uwm120.fptr03      = 0
        sicuw.uwm120.fptr04      = 0
        sicuw.uwm120.fptr08      = 0
        sicuw.uwm120.fptr09      = 0
        sicuw.uwm120.gap_r       = sic_bran.uwm120.gap_r
        sicuw.uwm120.pdco        = sic_bran.uwm120.pdco
        sicuw.uwm120.pdfac       = sic_bran.uwm120.pdfac
        sicuw.uwm120.pdqs        = sic_bran.uwm120.pdqs
        sicuw.uwm120.pdst        = sic_bran.uwm120.pdst
        sicuw.uwm120.pdtty       = sic_bran.uwm120.pdtty
        sicuw.uwm120.prem_r      = sic_bran.uwm120.prem_r
        sicuw.uwm120.rfee_r      = sic_bran.uwm120.rfee_r
        sicuw.uwm120.rilate      = sic_bran.uwm120.rilate
        sicuw.uwm120.riskgp      = sic_bran.uwm120.riskgp
        sicuw.uwm120.riskno      = sic_bran.uwm120.riskno
        sicuw.uwm120.rskdel      = sic_bran.uwm120.rskdel
        sicuw.uwm120.rstp_r      = sic_bran.uwm120.rstp_r
        sicuw.uwm120.rtax_r      = sic_bran.uwm120.rtax_r
        sicuw.uwm120.r_text      = sic_bran.uwm120.r_text
        sicuw.uwm120.sico        = sic_bran.uwm120.sico
        sicuw.uwm120.sicurr      = sic_bran.uwm120.sicurr
        sicuw.uwm120.siexch      = sic_bran.uwm120.siexch
        sicuw.uwm120.sifac       = sic_bran.uwm120.sifac
        sicuw.uwm120.sigr        = sic_bran.uwm120.sigr
        sicuw.uwm120.siqs        = sic_bran.uwm120.siqs
        sicuw.uwm120.sist        = sic_bran.uwm120.sist
        sicuw.uwm120.sitty       = sic_bran.uwm120.sitty
        sicuw.uwm120.stmpae      = sic_bran.uwm120.stmpae
        sicuw.uwm120.styp20      = sic_bran.uwm120.styp20
        sicuw.uwm120.sval20      = sic_bran.uwm120.sval20
        sicuw.uwm120.taxae       = sic_bran.uwm120.taxae.


       /*---A65-0141 28/11/2022*/
       ASSIGN
           sicuw.uwm120.siret        = sic_bran.uwm120.siret      
           sicuw.uwm120.premr_ae     = sic_bran.uwm120.premr_ae   
           sicuw.uwm120.subclass     = sic_bran.uwm120.subclass   
           sicuw.uwm120.chr1         = sic_bran.uwm120.chr1       
           sicuw.uwm120.chr2         = sic_bran.uwm120.chr2       
           sicuw.uwm120.chr3         = sic_bran.uwm120.chr3       
           sicuw.uwm120.chr4         = sic_bran.uwm120.chr4       
           sicuw.uwm120.chr5         = sic_bran.uwm120.chr5       
           sicuw.uwm120.date1        = sic_bran.uwm120.date1      
           sicuw.uwm120.date2        = sic_bran.uwm120.date2      
           sicuw.uwm120.dec1         = sic_bran.uwm120.dec1       
           sicuw.uwm120.dec2         = sic_bran.uwm120.dec2       
           sicuw.uwm120.int1         = sic_bran.uwm120.int1       
           sicuw.uwm120.int2         = sic_bran.uwm120.int2       
           sicuw.uwm120.disc1_r      = sic_bran.uwm120.disc1_r    
           sicuw.uwm120.disc2_r      = sic_bran.uwm120.disc2_r    
           sicuw.uwm120.disc3_r      = sic_bran.uwm120.disc3_r    
           sicuw.uwm120.disc1p       = sic_bran.uwm120.disc1p     
           sicuw.uwm120.disc2p       = sic_bran.uwm120.disc2p     
           sicuw.uwm120.disc3p       = sic_bran.uwm120.disc3p     
           sicuw.uwm120.disc1ae      = sic_bran.uwm120.disc1ae    
           sicuw.uwm120.disc2ae      = sic_bran.uwm120.disc2ae    
           sicuw.uwm120.disc3ae      = sic_bran.uwm120.disc3ae .   
       /*A65-0141 28/11/2022---*/

       /*---Begin A58-0123 11/05/2015*/
       /* Risk Level Upper Text  uwd120*/
        nv_fptr = sic_bran.uwm120.fptr01.
        nv_bptr = 0.
        do while nv_fptr <> 0 and sic_bran.uwm120.fptr01 <> ? :
         find sic_bran.uwd120 where recid(sic_bran.uwd120) = nv_fptr
         no-lock no-error.
        
         if available sic_bran.uwd120 then do: /*sombat */
           nv_fptr = sic_bran.uwd120.fptr.
           create sicuw.uwd120.
        
           assign
             sicuw.uwd120.bptr          = nv_bptr
             sicuw.uwd120.endcnt        = sic_bran.uwd120.endcnt
             sicuw.uwd120.fptr          = 0
             sicuw.uwd120.ltext         = sic_bran.uwd120.ltext
             sicuw.uwd120.policy        = sic_bran.uwd120.policy
             sicuw.uwd120.rencnt        = sic_bran.uwd120.rencnt
             sicuw.uwd120.riskgp        = sic_bran.uwd120.riskgp
             sicuw.uwd120.riskno        = sic_bran.uwd120.riskno.
           if nv_bptr <> 0 then do:
             find wf_uwd120 where recid(wf_uwd120) = nv_bptr.
             wf_uwd120.fptr = recid(sicuw.uwd120).
           end.
           if nv_bptr = 0 then  sicuw.uwm120.fptr01 = recid(sicuw.uwd120).
           nv_bptr = recid(sicuw.uwd120).
         end.
        
        end. /* End do nv_fptr */
        sicuw.uwm120.bptr01 = nv_bptr.
        
        /* Risk Level Lower Text */
        nv_fptr = sic_bran.uwm120.fptr02.
        nv_bptr = 0.
        do while nv_fptr <> 0 and sic_bran.uwm120.fptr02 <> ? :
         find sic_bran.uwd121 where recid(sic_bran.uwd121) = nv_fptr
         no-lock no-error.
         if available sic_bran.uwd121 then do: /*sombat */
           nv_fptr = sic_bran.uwd121.fptr.
           create sicuw.uwd121.
        
           assign
             sicuw.uwd121.bptr          = nv_bptr
             sicuw.uwd121.endcnt        = sic_bran.uwd121.endcnt
             sicuw.uwd121.fptr          = 0
             sicuw.uwd121.ltext         = sic_bran.uwd121.ltext
             sicuw.uwd121.policy        = sic_bran.uwd121.policy
             sicuw.uwd121.rencnt        = sic_bran.uwd121.rencnt
             sicuw.uwd121.riskgp        = sic_bran.uwd121.riskgp
             sicuw.uwd121.riskno        = sic_bran.uwd121.riskno.
           if nv_bptr <> 0 then do:
             find wf_uwd121 where recid(wf_uwd121) = nv_bptr.
             wf_uwd121.fptr = recid(sicuw.uwd121).
           end.
           if nv_bptr = 0 then  sicuw.uwm120.fptr02 = recid(sicuw.uwd121).
           nv_bptr = recid(sicuw.uwd121).
         end.
        end. /* End do nv_fptr */
        sicuw.uwm120.bptr02 = nv_bptr.
        
        /* Risk Level Bordereau Text */
        nv_fptr = sic_bran.uwm120.fptr03.
        nv_bptr = 0.
        do while nv_fptr <> 0 and sic_bran.uwm120.fptr03 <> ? :
         find sic_bran.uwd123 where recid(sic_bran.uwd123) = nv_fptr
         no-lock no-error.
         if available sic_bran.uwd123 then do: /*sombat */
           nv_fptr = sic_bran.uwd123.fptr.
           create sicuw.uwd123.
        
           assign
             sicuw.uwd123.bptr          = nv_bptr
             sicuw.uwd123.endcnt        = sic_bran.uwd123.endcnt
             sicuw.uwd123.fptr          = 0
             sicuw.uwd123.ltext         = sic_bran.uwd123.ltext
             sicuw.uwd123.policy        = sic_bran.uwd123.policy
             sicuw.uwd123.rencnt        = sic_bran.uwd123.rencnt
             sicuw.uwd123.riskgp        = sic_bran.uwd123.riskgp
             sicuw.uwd123.riskno        = sic_bran.uwd123.riskno.
           if nv_bptr <> 0 then do:
             find wf_uwd123 where recid(wf_uwd123) = nv_bptr.
             wf_uwd123.fptr = recid(sicuw.uwd123).
           end.
           if nv_bptr = 0 then  sicuw.uwm120.fptr03 = recid(sicuw.uwd123).
           nv_bptr = recid(sicuw.uwd123).
         end.
        end. /* End do nv_fptr */
        sicuw.uwm120.bptr03 = nv_bptr.
        
        /* Risk Level Clauses */
        nv_fptr = sic_bran.uwm120.fptr04.
        nv_bptr = 0.
        do while nv_fptr <> 0 and sic_bran.uwm120.fptr04 <> ? :
         find sic_bran.uwd125 where recid(sic_bran.uwd125) = nv_fptr
         no-lock no-error.
         if available sic_bran.uwd125 then do: /*sombat */
           nv_fptr = sic_bran.uwd125.fptr.
           create sicuw.uwd125.
        
           assign
             sicuw.uwd125.bptr          = nv_bptr
             sicuw.uwd125.clause        = sic_bran.uwd125.clause
             sicuw.uwd125.endcnt        = sic_bran.uwd125.endcnt
             sicuw.uwd125.fptr          = 0
             sicuw.uwd125.policy        = sic_bran.uwd125.policy
             sicuw.uwd125.rencnt        = sic_bran.uwd125.rencnt
             sicuw.uwd125.riskgp        = sic_bran.uwd125.riskgp
             sicuw.uwd125.riskno        = sic_bran.uwd125.riskno.
        
           if nv_bptr <> 0 then do:
             find wf_uwd125 where recid(wf_uwd125) = nv_bptr.
             wf_uwd125.fptr = recid(sicuw.uwd125).
           end.
           /*-- Comment by Narin A56-0225
           if nv_bptr = 0 then  sicuw.uwm120.fptr03 = recid(sicuw.uwd125).
           --*/
           /*--    Add by Narin A56-0225--*/
           if nv_bptr = 0 then  sicuw.uwm120.fptr04 = recid(sicuw.uwd125).
           /*--End Add by Narin A56-0225--*/
           nv_bptr = recid(sicuw.uwd125).
         end.
        end. /* End do nv_fptr */
        sicuw.uwm120.bptr04 = nv_bptr.
        
        /* Risk Level Endorsement Text */
        nv_fptr = sic_bran.uwm120.fptr08.
        nv_bptr = 0.
        do while nv_fptr <> 0 and sic_bran.uwm120.fptr08 <> ? :
         find sic_bran.uwd124 where recid(sic_bran.uwd124) = nv_fptr
         no-lock no-error.
         if available sic_bran.uwd124 then do: /*sombat */
           nv_fptr = sic_bran.uwd124.fptr.
           create sicuw.uwd124.
        
           assign
             sicuw.uwd124.bptr          = nv_bptr
             sicuw.uwd124.endcnt        = sic_bran.uwd124.endcnt
             sicuw.uwd124.fptr          = 0
             sicuw.uwd124.ltext         = sic_bran.uwd124.ltext
             sicuw.uwd124.policy        = sic_bran.uwd124.policy
             sicuw.uwd124.rencnt        = sic_bran.uwd124.rencnt
             sicuw.uwd124.riskgp        = sic_bran.uwd124.riskgp
             sicuw.uwd124.riskno        = sic_bran.uwd124.riskno.
        
           if nv_bptr <> 0 then do:
             find wf_uwd124 where recid(wf_uwd124) = nv_bptr.
             wf_uwd124.fptr = recid(sicuw.uwd124).
           end.
           if nv_bptr = 0 then  sicuw.uwm120.fptr08 = recid(sicuw.uwd124).
           nv_bptr = recid(sicuw.uwd124).
         end.
        end. /* End do nv_fptr */
        sicuw.uwm120.bptr08 = nv_bptr.
        
        /* Risk level Endorsement Clauses */
        nv_fptr = sic_bran.uwm120.fptr09.
        nv_bptr = 0.
        do while nv_fptr <> 0 and sic_bran.uwm120.fptr09 <> ? :
            find sic_bran.uwd126 where recid(sic_bran.uwd126) = nv_fptr
            no-lock no-error.
            if available sic_bran.uwd126 then do: /*sombat */
                nv_fptr = sic_bran.uwd126.fptr.
                create sicuw.uwd126.
                
                assign
                    sicuw.uwd126.bptr          = nv_bptr
                    sicuw.uwd126.endcls        = sic_bran.uwd126.endcls
                    sicuw.uwd126.endcnt        = sic_bran.uwd126.endcnt
                    sicuw.uwd126.fptr          = 0
                    sicuw.uwd126.policy        = sic_bran.uwd126.policy
                    sicuw.uwd126.rencnt        = sic_bran.uwd126.rencnt
                    sicuw.uwd126.riskgp        = sic_bran.uwd126.riskgp
                    sicuw.uwd126.riskno        = sic_bran.uwd126.riskno.
                
                if nv_bptr <> 0 then do:
                    find wf_uwd126 where recid(wf_uwd126) = nv_bptr.
                    wf_uwd126.fptr = recid(sicuw.uwd126).
                end.
                if nv_bptr = 0 then  sicuw.uwm120.fptr09 = recid(sicuw.uwd126).
                nv_bptr = recid(sicuw.uwd126).
            end.
        end. /* End do nv_fptr */
        sicuw.uwm120.bptr09 = nv_bptr.
        /*End by Narin L. A58-0123 11/05/2015*/


   END.
END.




