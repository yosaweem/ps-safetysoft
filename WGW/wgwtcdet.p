/* -----------------------------------------------------------------------------
Program Id. : TMUWCDET.P  >>> WGWTCDET.P
Copyright   # Safety Insurance Public Company Limited
                 บริษัท ประกันคุ้มภัย จำกัด (มหาชน)
Description : Transfer data from Brach to Branch
                 brsic_bran ->  sic_bran
                 lremote     ->  stat                

Modify by : Narin 19/10/2010    <A52-0242>
   สรุปหลักการ Connect Database GW  และ Database local 
   1. DATABASE GW  ที่ CONNECT ได้ ให้ทำการ DISCONNECT ออก SIC_BRAN  กับ  BRSTAT
      และ ทำการ Conncet database : gw_safe  &  gw_stat
          sic_bran  
          brstat    --->  gw_stat
   2. DATABASE Local Connect ดังนี้ 
          bransafe --->  -ld  brsic_bran
          brstat   --->  -ld  brstat

----------------------------------------------------------------------------- */

def     shared var sh_policy like sic_bran.uwm100.policy.
def     shared var sh_rencnt like sic_bran.uwm100.rencnt.
def     shared var sh_endcnt like sic_bran.uwm100.endcnt.

def     shared var nv_duprec100  as logi init no no-undo.
def     shared var nv_duprec120  as logi init no no-undo.
def     shared var nv_duprec301  as logi init no no-undo.
def            var nv_gw_stat    as inte init 0  no-undo.
def            var nv_stat       as inte init 0  no-undo.
def            var nv_host       as inte init 0  no-undo.


FOR EACH sic_bran.uwm301 WHERE 
         sic_bran.uwm301.policy = sh_policy AND
         sic_bran.uwm301.rencnt = sh_rencnt AND
         sic_bran.uwm301.endcnt = sh_endcnt NO-LOCK:
    FOR EACH stat.detaitem WHERE 
             stat.detaitem.policy = sic_bran.uwm301.policy  AND
             stat.detaitem.rencnt = sic_bran.uwm301.rencnt  AND
             stat.detaitem.endcnt = sic_bran.uwm301.endcnt  NO-LOCK:
         nv_stat = nv_stat + 1.
    END.
END.
IF nv_host <> nv_stat THEN DO:
   FOR EACH sic_bran.uwm301 WHERE 
         sic_bran.uwm301.policy = sh_policy AND
         sic_bran.uwm301.rencnt = sh_rencnt AND
         sic_bran.uwm301.endcnt = sh_endcnt NO-LOCK:
      FOR EACH gw_stat.detaitem WHERE
           gw_stat.detaitem.policy = sic_bran.uwm301.policy  AND
           gw_stat.detaitem.rencnt = sic_bran.uwm301.rencnt  AND
           gw_stat.detaitem.endcnt = sic_bran.uwm301.endcnt  :
     DELETE gw_stat.detaitem.
  END.
  nv_duprec100 = no.
  END.
END.
ELSE DO:
  nv_duprec100 = YES.

    FOR EACH sic_bran.uwm301 WHERE 
             sic_bran.uwm301.policy = sh_policy AND
             sic_bran.uwm301.rencnt = sh_rencnt AND
             sic_bran.uwm301.endcnt = sh_endcnt NO-LOCK:
    
        FOR EACH brstat.detaitem WHERE 
                 brstat.detaitem.policy = sic_bran.uwm301.policy AND
                 brstat.detaitem.rencnt = sic_bran.uwm301.rencnt AND
                 brstat.detaitem.endcnt = sic_bran.uwm301.endcnt :
          FIND FIRST gw_stat.detaitem WHERE 
               gw_stat.detaitem.policy = brstat.detaitem.policy AND
               gw_stat.detaitem.rencnt = brstat.detaitem.rencnt AND
               gw_stat.detaitem.endcnt = brstat.detaitem.endcnt AND       
               gw_stat.detaitem.riskno = brstat.detaitem.riskno AND
               gw_stat.detaitem.itemno = brstat.detaitem.itemno NO-ERROR.
    
        IF NOT AVAILABLE gw_stat.detaitem THEN DO:
          nv_duprec100 = no.
          LEAVE.
        END.    
        IF gw_stat.Detaitem.Policy          <> brstat.Detaitem.Policy       
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.Rencnt          <> brstat.Detaitem.Rencnt  
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.Endcnt          <> brstat.Detaitem.Endcnt       
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.RiskNo          <> brstat.Detaitem.RiskNo       
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.ItemNo          <> brstat.Detaitem.ItemNo  
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.seqno           <> brstat.Detaitem.seqno    
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.seqno2          <> brstat.Detaitem.seqno2   
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.ProTyp          <> brstat.Detaitem.ProTyp   
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.month           <> brstat.Detaitem.month        
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.Claim           <> brstat.Detaitem.Claim    
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.ComDate         <> brstat.Detaitem.ComDate  
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.ExpDate         <> brstat.Detaitem.ExpDate  
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.YearNo          <> brstat.Detaitem.YearNo   
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.prodtype        <> brstat.Detaitem.prodtype 
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.append          <> brstat.Detaitem.append   
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.ContractNo      <> brstat.Detaitem.ContractNo   
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.YearReg         <> brstat.Detaitem.YearReg      
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.modtyp          <> brstat.Detaitem.modtyp   
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.ModNo           <> brstat.Detaitem.ModNo    
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.makdes          <> brstat.Detaitem.makdes   
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.model           <> brstat.Detaitem.model    
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.MotColor        <> brstat.Detaitem.MotColor 
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.RegNo           <> brstat.Detaitem.RegNo    
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.BodyNo          <> brstat.Detaitem.BodyNo   
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.EngNo           <> brstat.Detaitem.EngNo    
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.Yrmnu           <> brstat.Detaitem.Yrmnu    
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.serailno        <> brstat.Detaitem.serailno 
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.BenNo           <> brstat.Detaitem.BenNo    
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.BenName         <> brstat.Detaitem.BenName  
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.TrnDate         <> brstat.Detaitem.TrnDate  
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.ReceNo          <> brstat.Detaitem.ReceNo   
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.receipt         <> brstat.Detaitem.receipt  
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.saledat         <> brstat.Detaitem.saledat  
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.recedat         <> brstat.Detaitem.recedat  
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.lease_si        <> brstat.Detaitem.lease_si 
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.lease_sale      <> brstat.Detaitem.lease_sale   
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.lease_prem      <> brstat.Detaitem.lease_prem   
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.lease_cre       <> brstat.Detaitem.lease_cre    
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.lease_month     <> brstat.Detaitem.lease_month   
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.lease_brn       <> brstat.Detaitem.lease_brn
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.lease_brname    <> brstat.Detaitem.lease_brname
            THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.lease_st        <> brstat.Detaitem.lease_st    
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.si_d            <> brstat.Detaitem.si_d     
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.load            <> brstat.Detaitem.load     
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.load2           <> brstat.Detaitem.load2    
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.prem_d          <> brstat.Detaitem.prem_d   
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.disc1           <> brstat.Detaitem.disc1    
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.disc2           <> brstat.Detaitem.disc2    
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.stamp_d         <> brstat.Detaitem.stamp_d  
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.tax_d           <> brstat.Detaitem.tax_d    
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.PolSta          <> brstat.Detaitem.PolSta   
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.DealCode        <> brstat.Detaitem.DealCode 
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.Dealer          <> brstat.Detaitem.Dealer   
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.EndDate         <> brstat.Detaitem.EndDate  
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.EntDate         <> brstat.Detaitem.EntDate  
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.EntTime         <> brstat.Detaitem.EntTime  
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.UDate           <> brstat.Detaitem.UDate    
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.UserNo          <> brstat.Detaitem.UserNo   
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.Date1           <> brstat.Detaitem.Date1    
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.Date2           <> brstat.Detaitem.Date2    
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.Date3           <> brstat.Detaitem.Date3    
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.Deci1           <> brstat.Detaitem.Deci1    
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.Deci2           <> brstat.Detaitem.Deci2    
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.Deci3           <> brstat.Detaitem.Deci3    
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.Deci4           <> brstat.Detaitem.Deci4    
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.Deci5           <> brstat.Detaitem.Deci5    
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.Text1           <> brstat.Detaitem.Text1    
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.Text10          <> brstat.Detaitem.Text10   
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.Text2           <> brstat.Detaitem.Text2    
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.Text3           <> brstat.Detaitem.Text3    
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.Text4           <> brstat.Detaitem.Text4    
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.Text5           <> brstat.Detaitem.Text5    
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.Text6           <> brstat.Detaitem.Text6    
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.Text7           <> brstat.Detaitem.Text7    
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.Text8           <> brstat.Detaitem.Text8    
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.Text9           <> brstat.Detaitem.Text9    
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.Flag1           <> brstat.Detaitem.Flag1    
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.Flag2           <> brstat.Detaitem.Flag2    
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.Flag3           <> brstat.Detaitem.Flag3    
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.Flag4           <> brstat.Detaitem.Flag4    
           THEN DO: nv_duprec100 = NO. LEAVE. END.
        IF gw_stat.Detaitem.Flag5           <> brstat.Detaitem.Flag5    
           THEN DO: nv_duprec100 = NO. LEAVE. END.
      END. /*--For each detaitem--*/
    END.
END.   /*--Else do:---*/

/* END OFF : tmuwcdet.p */
