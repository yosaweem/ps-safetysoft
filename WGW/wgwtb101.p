/* WGWTB101.P */
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
     Author program : wgwdisgw.p , wgwcongw.p , wgwconbk.p      
-----------*/

DEFINE INPUT-OUTPUT PARAMETER  sh_policy    AS CHAR FORMAT "X(16)" INIT 0.
DEFINE INPUT-OUTPUT PARAMETER  sh_rencnt    AS INT  FORMAT "999"   INIT 0.
DEFINE INPUT-OUTPUT PARAMETER  sh_endcnt    AS INT  FORMAT "999"   INIT 0.
DEFINE INPUT-OUTPUT PARAMETER  nv_batchyr   AS INT  FORMAT "9999"  INIT 0.
DEFINE INPUT-OUTPUT PARAMETER  nv_batchno   AS CHAR FORMAT "X(13)" INIT ""  NO-UNDO.
DEFINE INPUT-OUTPUT PARAMETER  nv_batcnt    AS INT  FORMAT "99"    INIT 0.
                                       
HIDE MESSAGE NO-PAUSE.
/*message "Update uwm101".*/

FIND FIRST  brsic_bran.uwm101 WHERE
            brsic_bran.uwm101.policy = sh_policy AND
            brsic_bran.uwm101.rencnt = sh_rencnt AND
            brsic_bran.uwm101.endcnt = sh_endcnt NO-LOCK NO-ERROR NO-WAIT.

IF AVAILABLE brsic_bran.uwm101 THEN DO:

  FIND sic_bran.uwm101 WHERE 
       sic_bran.uwm101.policy = brsic_bran.uwm101.policy AND
       sic_bran.uwm101.rencnt = brsic_bran.uwm101.rencnt AND
       sic_bran.uwm101.endcnt = brsic_bran.uwm101.endcnt AND
       sic_bran.uwm101.instno = brsic_bran.uwm101.instno AND
       sic_bran.uwm101.bchyr  = nv_batchyr               AND
       sic_bran.uwm101.bchno  = nv_batchno               AND
       sic_bran.uwm101.bchcnt = nv_batcnt

  NO-ERROR.

  IF NOT AVAILABLE sic_bran.uwm101 THEN DO:
    CREATE sic_bran.uwm101.
  END. /*IF NOT AVAILABLE sic_bran.uwm101 THEN DO:*/

      ASSIGN
        sic_bran.uwm101.policy  = brsic_bran.uwm101.policy       
        sic_bran.uwm101.rencnt  = brsic_bran.uwm101.rencnt       
        sic_bran.uwm101.endcnt  = brsic_bran.uwm101.endcnt       
        sic_bran.uwm101.instno  = brsic_bran.uwm101.instno       
        sic_bran.uwm101.duedat  = brsic_bran.uwm101.duedat       
        sic_bran.uwm101.prem_i  = brsic_bran.uwm101.prem_i       
        sic_bran.uwm101.com1_i  = brsic_bran.uwm101.com1_i       
        sic_bran.uwm101.com2_i  = brsic_bran.uwm101.com2_i       
        sic_bran.uwm101.pstp_i  = brsic_bran.uwm101.pstp_i       
        sic_bran.uwm101.pfee_i  = brsic_bran.uwm101.pfee_i       
        sic_bran.uwm101.ptax_i  = brsic_bran.uwm101.ptax_i       
        sic_bran.uwm101.rstp_i  = brsic_bran.uwm101.rstp_i       
        sic_bran.uwm101.rfee_i  = brsic_bran.uwm101.rfee_i       
        sic_bran.uwm101.rtax_i  = brsic_bran.uwm101.rtax_i       
        sic_bran.uwm101.desc_i  = brsic_bran.uwm101.desc_i       
        sic_bran.uwm101.trty1i  = brsic_bran.uwm101.trty1i       
        sic_bran.uwm101.docnoi  = brsic_bran.uwm101.docnoi
        sic_bran.uwm101.bchyr   = nv_batchyr        
        sic_bran.uwm101.bchno   = nv_batchno     
        sic_bran.uwm101.bchcnt  = nv_batcnt.
  
END. /* IF AVAILABLE brsic_bran.uwm101 THEN DO:*/

/* END OF : WGWTB101.P */
