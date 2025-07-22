/*=================================================================*/
/* Program Name : wGwtra04.P   Gen. Data Uwm301 To DB Premium      */
/* Assign  No   : A56-0299                                         */
/* CREATE  By   : Watsana K.          (Date 18/09/2013)           */
/*                โอนข้อมูลจาก DB Gw Transfer To Premium           */
/* modify by   : Kridtiya i. A57-0391 date. 27/11/2014 เพิ่มการเช็คเลขกรมธรรม์ ที่พบในระบบ */
/*=================================================================*/
DEF INPUT PARAMETER nv_bchyr  AS INT.
DEF INPUT PARAMETER nv_bchno  AS CHAR.
DEF INPUT PARAMETER nv_bchcnt AS INT.
DEF INPUT PARAMETER nv_policy AS CHAR.
DEF INPUT PARAMETER nv_rencnt AS INT.
DEF INPUT PARAMETER nv_endcnt AS INT.
DEF  VAR nv_sic_bran  AS INTE INIT 0  NO-UNDO.
DEF  VAR nv_host      AS INTE INIT 0  NO-UNDO.
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
    FIND FIRST sicuw.uwm301 USE-INDEX uwm30101 WHERE
        sicuw.uwm301.policy = sic_bran.uwm301.policy AND
        sicuw.uwm301.rencnt = sic_bran.uwm301.rencnt AND
        sicuw.uwm301.endcnt = sic_bran.uwm301.endcnt AND
        sicuw.uwm301.riskgp = sic_bran.uwm301.riskgp AND
        sicuw.uwm301.riskno = sic_bran.uwm301.riskno AND
        sicuw.uwm301.itemno = sic_bran.uwm301.itemno NO-ERROR.
    IF NOT AVAILABLE sicuw.uwm301 THEN DO:
        CREATE sicuw.uwm301.  
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
            sicuw.uwm301.tons         = sic_bran.uwm301.tons         
            sicuw.uwm301.seats        = sic_bran.uwm301.seats        
            sicuw.uwm301.vehgrp       = sic_bran.uwm301.vehgrp       
            sicuw.uwm301.trareg       = sic_bran.uwm301.trareg       
            sicuw.uwm301.logbok       = sic_bran.uwm301.logbok       
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
    END.
    ELSE 
        ASSIGN     /*Add kridtiya i. A57-0391 */
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
            sicuw.uwm301.tons         = sic_bran.uwm301.tons         
            sicuw.uwm301.seats        = sic_bran.uwm301.seats        
            sicuw.uwm301.vehgrp       = sic_bran.uwm301.vehgrp       
            sicuw.uwm301.trareg       = sic_bran.uwm301.trareg       
            sicuw.uwm301.logbok       = sic_bran.uwm301.logbok       
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
       /*Add kridtiya i. A57-0391 */
END.  

RELEASE sicuw.uwm301.




