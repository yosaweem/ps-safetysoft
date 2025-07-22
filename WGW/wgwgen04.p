/*=================================================================*/
/* Program Name : wGwGen04.P   Gen. Data Uwm301 To DB Premium      */
/* Assign  No   : A54-0005                                         */
/* CREATE  By   : Amparat C.           (Date 23/12/2010)           */
/*                โอนข้อมูลจาก DB Gw Transfer To Premium           */
/*Modiffly     : Songkran A65-0141                                 
                Add feild uwm301.inspec */
/* Modify by : Naphasint C. A67-0029 09/05/2024                    */                              
/*             Add Filed uwm130 & mailtxt_fil & uwm301             */
/*=================================================================*/
DEF INPUT PARAMETER nv_bchyr  AS INT.
DEF INPUT PARAMETER nv_bchno  AS CHAR.
DEF INPUT PARAMETER nv_bchcnt AS INT.
DEF INPUT PARAMETER nv_policy AS CHAR.
DEF INPUT PARAMETER nv_rencnt AS INT.
DEF INPUT PARAMETER nv_endcnt AS INT.

DEF  VAR nv_sic_bran  AS INTE INIT 0  NO-UNDO.
DEF  VAR nv_host      AS INTE INIT 0  NO-UNDO.


/*-----
FIND sic_bran.uwm301 USE-INDEX uwm30101  WHERE
         sic_bran.uwm301.policy  = nv_Policy AND
         sic_bran.uwm301.rencnt  = nv_RenCnt AND
         sic_bran.uwm301.endcnt  = nv_EndCnt AND
         sic_bran.uwm301.riskgp  = 0         AND
         sic_bran.uwm301.riskno  = 1         AND
         sic_bran.uwm301.itemno  = 1         AND
         sic_bran.uwm301.bchyr   = nv_bchyr  AND
         sic_bran.uwm301.bchno   = nv_bchno  AND
         sic_bran.uwm301.bchcnt  = nv_bchcnt NO-LOCK NO-ERROR.
IF AVAIL sic_bran.uwm301 THEN DO:
comment by Chaiyong W. A58-0123 16/06/2015*/


/*---Begin by Chaiyong W. A58-0123 16/06/2015*/
FOR EACH sic_bran.uwm301 USE-INDEX uwm30101  WHERE
         sic_bran.uwm301.policy  = nv_Policy AND
         sic_bran.uwm301.rencnt  = nv_RenCnt AND
         sic_bran.uwm301.endcnt  = nv_EndCnt AND
         sic_bran.uwm301.bchyr   = nv_bchyr  AND
         sic_bran.uwm301.bchno   = nv_bchno  AND
         sic_bran.uwm301.bchcnt  = nv_bchcnt NO-LOCK:
/*End by Chaiyong W. A58-0123 16/06/2015-----*/
  FIND FIRST sicuw.uwm301 USE-INDEX uwm30101 WHERE
       sicuw.uwm301.policy = sic_bran.uwm301.policy AND
       sicuw.uwm301.rencnt = sic_bran.uwm301.rencnt AND
       sicuw.uwm301.endcnt = sic_bran.uwm301.endcnt AND
       sicuw.uwm301.riskgp = sic_bran.uwm301.riskgp AND
       sicuw.uwm301.riskno = sic_bran.uwm301.riskno AND
       sicuw.uwm301.itemno = sic_bran.uwm301.itemno NO-ERROR.
  IF NOT AVAILABLE sicuw.uwm301 THEN DO:
      /*- A65-0141  -*/
    CREATE sicuw.uwm301.  
    ASSIGN
        sicuw.uwm301.covcod          =    sic_bran.uwm301.covcod          
        sicuw.uwm301.modcod          =    sic_bran.uwm301.modcod          
        sicuw.uwm301.vehreg          =    sic_bran.uwm301.vehreg          
        sicuw.uwm301.eng_no          =    sic_bran.uwm301.eng_no          
        sicuw.uwm301.cha_no          =    sic_bran.uwm301.cha_no          
        sicuw.uwm301.yrmanu          =    sic_bran.uwm301.yrmanu          
        sicuw.uwm301.vehuse          =    sic_bran.uwm301.vehuse          
        sicuw.uwm301.ncbyrs          =    sic_bran.uwm301.ncbyrs          
        sicuw.uwm301.ncbper          =    sic_bran.uwm301.ncbper          
        sicuw.uwm301.tariff          =    sic_bran.uwm301.tariff          
        sicuw.uwm301.drinam          =    sic_bran.uwm301.drinam          
        sicuw.uwm301.driage          =    sic_bran.uwm301.driage          
        sicuw.uwm301.driexp          =    sic_bran.uwm301.driexp          
        sicuw.uwm301.dridip          =    sic_bran.uwm301.dridip          
        sicuw.uwm301.act_ae          =    sic_bran.uwm301.act_ae          
        sicuw.uwm301.actprm          =    sic_bran.uwm301.actprm          
        sicuw.uwm301.tp_ae           =    sic_bran.uwm301.tp_ae           
        sicuw.uwm301.tpprm           =    sic_bran.uwm301.tpprm           
        sicuw.uwm301.policy          =    sic_bran.uwm301.policy          
        sicuw.uwm301.rencnt          =    sic_bran.uwm301.rencnt          
        sicuw.uwm301.endcnt          =    sic_bran.uwm301.endcnt          
        sicuw.uwm301.riskgp          =    sic_bran.uwm301.riskgp          
        sicuw.uwm301.riskno          =    sic_bran.uwm301.riskno          
        sicuw.uwm301.itemno          =    sic_bran.uwm301.itemno          
        sicuw.uwm301.cert            =    sic_bran.uwm301.cert            
        sicuw.uwm301.moddes          =    sic_bran.uwm301.moddes          
        sicuw.uwm301.body            =    sic_bran.uwm301.body            
        sicuw.uwm301.engine          =    sic_bran.uwm301.engine          
        sicuw.uwm301.tons            =    sic_bran.uwm301.tons            
        sicuw.uwm301.seats           =    sic_bran.uwm301.seats           
        sicuw.uwm301.vehgrp          =    sic_bran.uwm301.vehgrp          
        sicuw.uwm301.trareg          =    sic_bran.uwm301.trareg          
        sicuw.uwm301.logbok          =    sic_bran.uwm301.logbok          
        sicuw.uwm301.garage          =    sic_bran.uwm301.garage          
        sicuw.uwm301.marsts          =    sic_bran.uwm301.marsts          
        sicuw.uwm301.mv41a           =    sic_bran.uwm301.mv41a           
        sicuw.uwm301.sex             =    sic_bran.uwm301.sex             
        sicuw.uwm301.mv41b           =    sic_bran.uwm301.mv41b           
        sicuw.uwm301.mv41c           =    sic_bran.uwm301.mv41c           
        sicuw.uwm301.mv42            =    sic_bran.uwm301.mv42            
        sicuw.uwm301.atttxt          =    sic_bran.uwm301.atttxt          
        sicuw.uwm301.mv41seat        =    sic_bran.uwm301.mv41seat        
        sicuw.uwm301.comp_cod        =    sic_bran.uwm301.comp_cod        
        sicuw.uwm301.sckno           =    sic_bran.uwm301.sckno           
        sicuw.uwm301.mv_ben83        =    sic_bran.uwm301.mv_ben83.
    ASSIGN                                
        sicuw.uwm301.prmtxt          =    sic_bran.uwm301.prmtxt          
        sicuw.uwm301.itmdel          =    sic_bran.uwm301.itmdel                     
        sicuw.uwm301.watts           =    sic_bran.uwm301.watts           
        sicuw.uwm301.car_reg         =    sic_bran.uwm301.car_reg         
        sicuw.uwm301.province_reg    =    sic_bran.uwm301.province_reg    
        sicuw.uwm301.car_color       =    sic_bran.uwm301.car_color       
        sicuw.uwm301.car_year        =    sic_bran.uwm301.car_year        
        sicuw.uwm301.chr1            =    sic_bran.uwm301.chr1            
        sicuw.uwm301.chr2            =    sic_bran.uwm301.chr2            
        sicuw.uwm301.chr3            =    sic_bran.uwm301.chr3            
        sicuw.uwm301.chr4            =    sic_bran.uwm301.chr4            
        sicuw.uwm301.chr5            =    sic_bran.uwm301.chr5            
        sicuw.uwm301.date1           =    sic_bran.uwm301.date1           
        sicuw.uwm301.date2           =    sic_bran.uwm301.date2           
        sicuw.uwm301.dec1            =    sic_bran.uwm301.dec1            
        sicuw.uwm301.dec2            =    sic_bran.uwm301.dec2            
        sicuw.uwm301.int1            =    sic_bran.uwm301.int1            
        sicuw.uwm301.int2            =    sic_bran.uwm301.int2            
        sicuw.uwm301.fuelcd          =    sic_bran.uwm301.fuelcd          
        sicuw.uwm301.fuel            =    sic_bran.uwm301.fuel            
        sicuw.uwm301.bnfid           =    sic_bran.uwm301.bnfid           
        sicuw.uwm301.inspec          =    sic_bran.uwm301.inspec          
        sicuw.uwm301.noteflg         =    sic_bran.uwm301.noteflg         
        sicuw.uwm301.notedat         =    sic_bran.uwm301.notedat         
        sicuw.uwm301.inspclose       =    sic_bran.uwm301.inspclose       
        sicuw.uwm301.incdat          =    sic_bran.uwm301.incdat          
        sicuw.uwm301.inspdet         =    sic_bran.uwm301.inspdet         
        sicuw.uwm301.usrtrn          =    sic_bran.uwm301.usrtrn          
        sicuw.uwm301.usrcls          =    sic_bran.uwm301.usrcls          
        sicuw.uwm301.notetim         =    sic_bran.uwm301.notetim         
        sicuw.uwm301.inctim          =    sic_bran.uwm301.inctim   .
    /*- Add A65-0141  -*/

    /*--- Add by Naphasint C. A67-0029 09/05/2024 ---*/
    ASSIGN
        sicuw.uwm301.maksi           =    sic_bran.uwm301.maksi
        sicuw.uwm301.eng_no2         =    sic_bran.uwm301.eng_no2
        sicuw.uwm301.battper         =    sic_bran.uwm301.battper
        sicuw.uwm301.battyr          =    sic_bran.uwm301.battyr
        sicuw.uwm301.battprice       =    sic_bran.uwm301.battprice
        sicuw.uwm301.battno          =    sic_bran.uwm301.battno
        sicuw.uwm301.battflg         =    sic_bran.uwm301.battflg
        sicuw.uwm301.chargno         =    sic_bran.uwm301.chargno
        sicuw.uwm301.chargsi         =    sic_bran.uwm301.chargsi
        sicuw.uwm301.chargper        =    sic_bran.uwm301.chargper
        sicuw.uwm301.chargflg        =    sic_bran.uwm301.chargflg
        sicuw.uwm301.chagprice       =    sic_bran.uwm301.chagprice
        sicuw.uwm301.battsi          =    sic_bran.uwm301.battsi .
    /*--- End by Naphasint C. A67-0029 09/05/2024 ---*/

    /*--
    ASSIGN
      sicuw.uwm301.covcod       = sic_bran.uwm301.covcod       
      sicuw.uwm301.modcod       = sic_bran.uwm301.modcod       
      sicuw.uwm301.vehreg       = sic_bran.uwm301.vehreg       
      sicuw.uwm301.eng_no       = sic_bran.uwm301.eng_no       
      sicuw.uwm301.cha_no       = sic_bran.uwm301.cha_no       
      sicuw.uwm301.yrmanu       = sic_bran.uwm301.yrmanu       
      sicuw.uwm301.vehuse       = sic_bran.uwm301.vehuse       
      sicuw.uwm301.ncbyrs       = sic_bran.uwm301.ncbyrs       
      sicuw.uwm301.ncbper       = sic_bran.uwm301.ncbper       
      sicuw.uwm301.tariff       = sic_bran.uwm301.tariff       
      sicuw.uwm301.drinam[1]    = sic_bran.uwm301.drinam[1]
      sicuw.uwm301.drinam[2]    = sic_bran.uwm301.drinam[2]
      sicuw.uwm301.drinam[3]    = sic_bran.uwm301.drinam[3]
      sicuw.uwm301.drinam[4]    = sic_bran.uwm301.drinam[4]
      sicuw.uwm301.drinam[5]    = sic_bran.uwm301.drinam[5]
      sicuw.uwm301.drinam[6]    = sic_bran.uwm301.drinam[6]
      sicuw.uwm301.drinam[7]    = sic_bran.uwm301.drinam[7]
      sicuw.uwm301.drinam[8]    = sic_bran.uwm301.drinam[8]
      sicuw.uwm301.drinam[9]    = sic_bran.uwm301.drinam[9]
      sicuw.uwm301.drinam[10]   = sic_bran.uwm301.drinam[10]
      
      sicuw.uwm301.driage[1]    = sic_bran.uwm301.driage[1]
      sicuw.uwm301.driage[2]    = sic_bran.uwm301.driage[2]
      sicuw.uwm301.driage[3]    = sic_bran.uwm301.driage[3]
      sicuw.uwm301.driage[4]    = sic_bran.uwm301.driage[4]
      sicuw.uwm301.driage[5]    = sic_bran.uwm301.driage[5]
      sicuw.uwm301.driage[6]    = sic_bran.uwm301.driage[6]
      sicuw.uwm301.driage[7]    = sic_bran.uwm301.driage[7]
      sicuw.uwm301.driage[8]    = sic_bran.uwm301.driage[8]
      sicuw.uwm301.driage[9]    = sic_bran.uwm301.driage[9]
      sicuw.uwm301.driage[10]   = sic_bran.uwm301.driage[10]
  
      sicuw.uwm301.driexp[1]    = sic_bran.uwm301.driexp[1]
      sicuw.uwm301.driexp[2]    = sic_bran.uwm301.driexp[2]
      sicuw.uwm301.driexp[3]    = sic_bran.uwm301.driexp[3]
      sicuw.uwm301.driexp[4]    = sic_bran.uwm301.driexp[4]
      sicuw.uwm301.driexp[5]    = sic_bran.uwm301.driexp[5]
      sicuw.uwm301.driexp[6]    = sic_bran.uwm301.driexp[6]
      sicuw.uwm301.driexp[7]    = sic_bran.uwm301.driexp[7]
      sicuw.uwm301.driexp[8]    = sic_bran.uwm301.driexp[8]
      sicuw.uwm301.driexp[9]    = sic_bran.uwm301.driexp[9]
      sicuw.uwm301.driexp[10]   = sic_bran.uwm301.driexp[10]
      
      sicuw.uwm301.dridip[1]    = sic_bran.uwm301.dridip[1]
      sicuw.uwm301.dridip[2]    = sic_bran.uwm301.dridip[2]
      sicuw.uwm301.dridip[3]    = sic_bran.uwm301.dridip[3]
      sicuw.uwm301.dridip[4]    = sic_bran.uwm301.dridip[4]
      sicuw.uwm301.dridip[5]    = sic_bran.uwm301.dridip[5]
      sicuw.uwm301.dridip[6]    = sic_bran.uwm301.dridip[6]
      sicuw.uwm301.dridip[7]    = sic_bran.uwm301.dridip[7]
      sicuw.uwm301.dridip[8]    = sic_bran.uwm301.dridip[8]
      sicuw.uwm301.dridip[9]    = sic_bran.uwm301.dridip[9]
      sicuw.uwm301.dridip[10]   = sic_bran.uwm301.dridip[10]
      
      sicuw.uwm301.act_ae       = sic_bran.uwm301.act_ae       
      sicuw.uwm301.actprm       = sic_bran.uwm301.actprm       
      sicuw.uwm301.tp_ae        = sic_bran.uwm301.tp_ae        
      sicuw.uwm301.tpprm        = sic_bran.uwm301.tpprm        
      sicuw.uwm301.policy       = sic_bran.uwm301.policy        
      sicuw.uwm301.rencnt       = sic_bran.uwm301.rencnt        
      sicuw.uwm301.endcnt       = sic_bran.uwm301.endcnt        
      sicuw.uwm301.riskgp       = sic_bran.uwm301.riskgp       
      sicuw.uwm301.riskno       = sic_bran.uwm301.riskno       
      sicuw.uwm301.itemno       = sic_bran.uwm301.itemno.
    ASSIGN
      sicuw.uwm301.cert         = sic_bran.uwm301.cert         
      sicuw.uwm301.moddes       = sic_bran.uwm301.moddes       
      sicuw.uwm301.body         = sic_bran.uwm301.body         
      sicuw.uwm301.engine       = sic_bran.uwm301.engine
      sicuw.uwm301.watts        = sic_bran.uwm301.watts  /*-- Add A65-0141 --*/
      sicuw.uwm301.tons         = sic_bran.uwm301.tons         
      sicuw.uwm301.seats        = sic_bran.uwm301.seats        
      sicuw.uwm301.vehgrp       = sic_bran.uwm301.vehgrp       
      sicuw.uwm301.trareg       = sic_bran.uwm301.trareg       
      sicuw.uwm301.logbok       = sic_bran.uwm301.logbok
      sicuw.uwm301.inspec       = sic_bran.uwm301.inspec  /*-- Add A65-0141 --*/
      sicuw.uwm301.garage       = sic_bran.uwm301.garage       
      sicuw.uwm301.mv41a        = sic_bran.uwm301.mv41a        
      sicuw.uwm301.mv41b        = sic_bran.uwm301.mv41b        
      sicuw.uwm301.mv41c        = sic_bran.uwm301.mv41c        
      sicuw.uwm301.mv42         = sic_bran.uwm301.mv42         
      sicuw.uwm301.atttxt       = sic_bran.uwm301.atttxt       
      sicuw.uwm301.mv41seat     = sic_bran.uwm301.mv41seat     
      sicuw.uwm301.comp_cod     = sic_bran.uwm301.comp_cod     
      sicuw.uwm301.sckno        = sic_bran.uwm301.sckno        
      sicuw.uwm301.mv_ben83     = sic_bran.uwm301.mv_ben83     
      sicuw.uwm301.prmtxt       = sic_bran.uwm301.prmtxt.
      
      */
  END.
END.  




