/* WGWTB301.p */
/*
   Sombat Phu. : 26/04/2003
   Description : Transfer data from Brach to Branch
                 brsic_bran ->  sic_bran
                 brstat     ->  stat
   Modify  by  : sombat 04/03/1998
                 Transfer data path frame realay
                 change name host to sicuw
   Modify by   : Narin  15/09/2010    A52-0242 
   DEFINE INPUT-OUTPUT PARAMETER  sh_policy  , sh_rencnt  , sh_endcnt , 
                                  nv_batchyr , nv_batchno , nv_batcnt  
   ค่าดังกล่าวมาจากโปรแกรม Main wgw\wgwtrn72.w >>>> tm\tmcount.p   
   สรุปหลักการ Connect Database GW  และ Database local 
   1. DATABASE GW  ที่ CONNECT ได้ ให้ทำการ DISCONNECT ออก SIC_BRAN  กับ  BRSTAT
      และ ทำการ Conncet database : gw_safe  &  gw_stat
          sic_bran  --->  
          brstat    --->  gw_stat
   2. DATABASE Local Connect ดังนี้ 
          bransafe --->  -ld  brsic_bran
          brstat   --->  -ld  brstat
*/                                  

DEFINE INPUT-OUTPUT PARAMETER  sh_policy    AS CHAR FORMAT "X(16)" INIT 0.
DEFINE INPUT-OUTPUT PARAMETER  sh_rencnt    AS INT  FORMAT "999"   INIT 0.
DEFINE INPUT-OUTPUT PARAMETER  sh_endcnt    AS INT  FORMAT "999"   INIT 0.
DEFINE INPUT-OUTPUT PARAMETER  nv_batchyr   AS INT  FORMAT "9999"  INIT 0.
DEFINE INPUT-OUTPUT PARAMETER  nv_batchno   AS CHAR FORMAT "X(13)" INIT ""  NO-UNDO.
DEFINE INPUT-OUTPUT PARAMETER  nv_batcnt    AS INT  FORMAT "99"    INIT 0.

DEF     SHARED VAR nv_duprec100  AS logi INIT NO NO-UNDO.
   
HIDE MESSAGE NO-PAUSE.
/*message "Update uwm301".*/

DEF            VAR nv_brsic_bran  AS INTE INIT 0  NO-UNDO.
DEF            VAR nv_host        AS INTE INIT 0  NO-UNDO.
/*----------------
FOR EACH brsic_bran.uwm301 WHERE 
         brsic_bran.uwm301.policy = sh_policy AND
         brsic_bran.uwm301.rencnt = sh_rencnt AND
         brsic_bran.uwm301.endcnt = sh_endcnt
NO-LOCK:
  nv_brsic_bran = nv_brsic_bran + 1.
END.

FOR EACH sic_bran.uwm301 WHERE
         sic_bran.uwm301.policy = sh_policy AND
         sic_bran.uwm301.rencnt = sh_rencnt AND
         sic_bran.uwm301.endcnt = sh_endcnt
NO-LOCK:
  nv_host = nv_host + 1.
END.
IF nv_host <> nv_brsic_bran THEN DO:
  FOR EACH sic_bran.uwm301 WHERE
           sic_bran.uwm301.policy = sh_policy AND
           sic_bran.uwm301.rencnt = sh_rencnt AND
           sic_bran.uwm301.endcnt = sh_endcnt :
     DELETE sic_bran.uwm301.
  END.
  nv_duprec100 = no.
END.
--------------*/
    /*
FOR EACH brsic_bran.uwm301 WHERE 
         brsic_bran.uwm301.policy = sh_policy AND
         brsic_bran.uwm301.rencnt = sh_rencnt AND
         brsic_bran.uwm301.endcnt = sh_endcnt :
    */
FIND FIRST brsic_bran.uwm301 WHERE
           brsic_bran.uwm301.policy = sh_policy AND
           brsic_bran.uwm301.rencnt = sh_rencnt AND
           brsic_bran.uwm301.endcnt = sh_endcnt NO-LOCK NO-ERROR NO-WAIT.

IF AVAILABLE brsic_bran.uwm301 THEN DO:

  FIND sic_bran.uwm301 WHERE 
       sic_bran.uwm301.policy = brsic_bran.uwm301.policy AND
       sic_bran.uwm301.rencnt = brsic_bran.uwm301.rencnt AND
       sic_bran.uwm301.endcnt = brsic_bran.uwm301.endcnt AND
       sic_bran.uwm301.riskgp = brsic_bran.uwm301.riskgp AND
       sic_bran.uwm301.riskno = brsic_bran.uwm301.riskno AND
       sic_bran.uwm301.itemno = brsic_bran.uwm301.itemno AND
       sic_bran.uwm301.bchyr  = nv_batchyr               AND
       sic_bran.uwm301.bchno  = nv_batchno               AND
       sic_bran.uwm301.bchcnt = nv_batcnt
  NO-ERROR .

  IF NOT AVAILABLE sic_bran.uwm301 THEN DO:
    CREATE sic_bran.uwm301.
  END. /*IF NOT AVAILABLE sic_bran.uwm301 THEN DO:*/

  ASSIGN
    sic_bran.uwm301.covcod       = brsic_bran.uwm301.covcod       
    sic_bran.uwm301.modcod       = brsic_bran.uwm301.modcod       
    sic_bran.uwm301.vehreg       = brsic_bran.uwm301.vehreg       
    sic_bran.uwm301.eng_no       = brsic_bran.uwm301.eng_no       
    sic_bran.uwm301.cha_no       = brsic_bran.uwm301.cha_no       
    sic_bran.uwm301.yrmanu       = brsic_bran.uwm301.yrmanu       
    sic_bran.uwm301.vehuse       = brsic_bran.uwm301.vehuse       
    sic_bran.uwm301.ncbyrs       = brsic_bran.uwm301.ncbyrs       
    sic_bran.uwm301.ncbper       = brsic_bran.uwm301.ncbper       
    sic_bran.uwm301.tariff       = brsic_bran.uwm301.tariff       
    sic_bran.uwm301.drinam[1]    = brsic_bran.uwm301.drinam[1]
    sic_bran.uwm301.drinam[2]    = brsic_bran.uwm301.drinam[2]
    sic_bran.uwm301.drinam[3]    = brsic_bran.uwm301.drinam[3]
    sic_bran.uwm301.drinam[4]    = brsic_bran.uwm301.drinam[4]
    sic_bran.uwm301.drinam[5]    = brsic_bran.uwm301.drinam[5]
    sic_bran.uwm301.drinam[6]    = brsic_bran.uwm301.drinam[6]
    sic_bran.uwm301.drinam[7]    = brsic_bran.uwm301.drinam[7]
    sic_bran.uwm301.drinam[8]    = brsic_bran.uwm301.drinam[8]
    sic_bran.uwm301.drinam[9]    = brsic_bran.uwm301.drinam[9]
    sic_bran.uwm301.drinam[10]   = brsic_bran.uwm301.drinam[10]
    /* ----- */
    sic_bran.uwm301.driage[1]    = brsic_bran.uwm301.driage[1]
    sic_bran.uwm301.driage[2]    = brsic_bran.uwm301.driage[2]
    sic_bran.uwm301.driage[3]    = brsic_bran.uwm301.driage[3]
    sic_bran.uwm301.driage[4]    = brsic_bran.uwm301.driage[4]
    sic_bran.uwm301.driage[5]    = brsic_bran.uwm301.driage[5]
    sic_bran.uwm301.driage[6]    = brsic_bran.uwm301.driage[6]
    sic_bran.uwm301.driage[7]    = brsic_bran.uwm301.driage[7]
    sic_bran.uwm301.driage[8]    = brsic_bran.uwm301.driage[8]
    sic_bran.uwm301.driage[9]    = brsic_bran.uwm301.driage[9]
    sic_bran.uwm301.driage[10]   = brsic_bran.uwm301.driage[10].

  ASSIGN
    /* ----- */
    sic_bran.uwm301.driexp[1]    = brsic_bran.uwm301.driexp[1]
    sic_bran.uwm301.driexp[2]    = brsic_bran.uwm301.driexp[2]
    sic_bran.uwm301.driexp[3]    = brsic_bran.uwm301.driexp[3]
    sic_bran.uwm301.driexp[4]    = brsic_bran.uwm301.driexp[4]
    sic_bran.uwm301.driexp[5]    = brsic_bran.uwm301.driexp[5]
    sic_bran.uwm301.driexp[6]    = brsic_bran.uwm301.driexp[6]
    sic_bran.uwm301.driexp[7]    = brsic_bran.uwm301.driexp[7]
    sic_bran.uwm301.driexp[8]    = brsic_bran.uwm301.driexp[8]
    sic_bran.uwm301.driexp[9]    = brsic_bran.uwm301.driexp[9]
    sic_bran.uwm301.driexp[10]   = brsic_bran.uwm301.driexp[10]
    /* ----- */
    sic_bran.uwm301.dridip[1]    = brsic_bran.uwm301.dridip[1]
    sic_bran.uwm301.dridip[2]    = brsic_bran.uwm301.dridip[2]
    sic_bran.uwm301.dridip[3]    = brsic_bran.uwm301.dridip[3]
    sic_bran.uwm301.dridip[4]    = brsic_bran.uwm301.dridip[4]
    sic_bran.uwm301.dridip[5]    = brsic_bran.uwm301.dridip[5]
    sic_bran.uwm301.dridip[6]    = brsic_bran.uwm301.dridip[6]
    sic_bran.uwm301.dridip[7]    = brsic_bran.uwm301.dridip[7]
    sic_bran.uwm301.dridip[8]    = brsic_bran.uwm301.dridip[8]
    sic_bran.uwm301.dridip[9]    = brsic_bran.uwm301.dridip[9]
    sic_bran.uwm301.dridip[10]   = brsic_bran.uwm301.dridip[10].

  ASSIGN
    /* ----- */
    sic_bran.uwm301.act_ae       = brsic_bran.uwm301.act_ae       
    sic_bran.uwm301.actprm       = brsic_bran.uwm301.actprm       
    sic_bran.uwm301.tp_ae        = brsic_bran.uwm301.tp_ae        
    sic_bran.uwm301.tpprm        = brsic_bran.uwm301.tpprm        
    sic_bran.uwm301.policy       = brsic_bran.uwm301.policy       
    sic_bran.uwm301.rencnt       = brsic_bran.uwm301.rencnt       
    sic_bran.uwm301.endcnt       = brsic_bran.uwm301.endcnt       
    sic_bran.uwm301.riskgp       = brsic_bran.uwm301.riskgp       
    sic_bran.uwm301.riskno       = brsic_bran.uwm301.riskno       
    sic_bran.uwm301.itemno       = brsic_bran.uwm301.itemno.

  ASSIGN
    sic_bran.uwm301.cert         = brsic_bran.uwm301.cert         
    sic_bran.uwm301.moddes       = brsic_bran.uwm301.moddes       
    sic_bran.uwm301.body         = brsic_bran.uwm301.body         
    sic_bran.uwm301.engine       = brsic_bran.uwm301.engine       
    sic_bran.uwm301.tons         = brsic_bran.uwm301.tons         
    sic_bran.uwm301.seats        = brsic_bran.uwm301.seats        
    sic_bran.uwm301.vehgrp       = brsic_bran.uwm301.vehgrp       
    sic_bran.uwm301.trareg       = brsic_bran.uwm301.trareg       
    sic_bran.uwm301.logbok       = brsic_bran.uwm301.logbok       
    sic_bran.uwm301.garage       = brsic_bran.uwm301.garage       
    sic_bran.uwm301.mv41a        = brsic_bran.uwm301.mv41a        
    sic_bran.uwm301.mv41b        = brsic_bran.uwm301.mv41b        
    sic_bran.uwm301.mv41c        = brsic_bran.uwm301.mv41c        
    sic_bran.uwm301.mv42         = brsic_bran.uwm301.mv42         
    sic_bran.uwm301.atttxt       = brsic_bran.uwm301.atttxt       
    sic_bran.uwm301.mv41seat     = brsic_bran.uwm301.mv41seat     
    sic_bran.uwm301.comp_cod     = brsic_bran.uwm301.comp_cod     
    sic_bran.uwm301.sckno        = brsic_bran.uwm301.sckno        
    sic_bran.uwm301.mv_ben83     = brsic_bran.uwm301.mv_ben83     
    sic_bran.uwm301.prmtxt       = brsic_bran.uwm301.prmtxt
    sic_bran.uwm301.bchyr        = nv_batchyr   
    sic_bran.uwm301.bchno        = nv_batchno   
    sic_bran.uwm301.bchcnt       = nv_batcnt.

END.   /* IF AVAILABLE brsic_bran.uwm301 THEN DO:*/

/* END OF : WGWTB301.P */
