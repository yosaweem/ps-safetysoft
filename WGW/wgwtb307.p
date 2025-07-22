/* WGWTB307.P */
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

hide message no-pause.
/*message "Update uwm307".*/
    
FIND FIRST  brsic_bran.uwm307 WHERE
            brsic_bran.uwm307.policy = sh_policy AND
            brsic_bran.uwm307.rencnt = sh_rencnt AND
            brsic_bran.uwm307.endcnt = sh_endcnt NO-LOCK NO-ERROR NO-WAIT.

IF AVAILABLE brsic_bran.uwm307 THEN DO:

  FIND sic_bran.uwm307 WHERE 
       sic_bran.uwm307.policy = brsic_bran.uwm307.policy AND
       sic_bran.uwm307.rencnt = brsic_bran.uwm307.rencnt AND
       sic_bran.uwm307.endcnt = brsic_bran.uwm307.endcnt AND
       sic_bran.uwm307.riskgp = brsic_bran.uwm307.riskgp AND
       sic_bran.uwm307.riskno = brsic_bran.uwm307.riskno AND
       sic_bran.uwm307.itemno = brsic_bran.uwm307.itemno AND
       sic_bran.uwm307.bchyr  = nv_batchyr          AND
       sic_bran.uwm307.bchno  = nv_batchno          AND
       sic_bran.uwm307.bchcnt = nv_batcnt  
  NO-ERROR.

  IF NOT AVAILABLE sic_bran.uwm307 THEN DO:
    CREATE sic_bran.uwm307.
  END.

  ASSIGN
    sic_bran.uwm307.policy = brsic_bran.uwm307.policy       
    sic_bran.uwm307.rencnt = brsic_bran.uwm307.rencnt       
    sic_bran.uwm307.endcnt = brsic_bran.uwm307.endcnt       
    sic_bran.uwm307.riskgp = brsic_bran.uwm307.riskgp       
    sic_bran.uwm307.riskno = brsic_bran.uwm307.riskno       
    sic_bran.uwm307.itemno = brsic_bran.uwm307.itemno       
    sic_bran.uwm307.iref   = brsic_bran.uwm307.iref         
    sic_bran.uwm307.ifirst = brsic_bran.uwm307.ifirst       
    sic_bran.uwm307.iname  = brsic_bran.uwm307.iname        
    sic_bran.uwm307.iyob   = brsic_bran.uwm307.iyob         
    sic_bran.uwm307.idob   = brsic_bran.uwm307.idob         
    sic_bran.uwm307.iocc   = brsic_bran.uwm307.iocc         
    sic_bran.uwm307.iocct  = brsic_bran.uwm307.iocct        
    sic_bran.uwm307.ioccs  = brsic_bran.uwm307.ioccs        
    sic_bran.uwm307.bname1 = brsic_bran.uwm307.bname1       
    sic_bran.uwm307.bname2 = brsic_bran.uwm307.bname2       
    sic_bran.uwm307.badd1  = brsic_bran.uwm307.badd1        
    sic_bran.uwm307.badd2  = brsic_bran.uwm307.badd2        
    sic_bran.uwm307.reship = brsic_bran.uwm307.reship       
    sic_bran.uwm307.endatt = brsic_bran.uwm307.endatt.

  ASSIGN
    sic_bran.uwm307.ldcd[1]   = brsic_bran.uwm307.ldcd[1]
    sic_bran.uwm307.ldcd[2]   = brsic_bran.uwm307.ldcd[2]
    sic_bran.uwm307.ldcd[3]   = brsic_bran.uwm307.ldcd[3]
    sic_bran.uwm307.ldae[1]   = brsic_bran.uwm307.ldae[1]
    sic_bran.uwm307.ldae[2]   = brsic_bran.uwm307.ldae[2]
    sic_bran.uwm307.ldae[3]   = brsic_bran.uwm307.ldae[3]
    sic_bran.uwm307.ldrate[1] = brsic_bran.uwm307.ldrate[1]
    sic_bran.uwm307.ldrate[2] = brsic_bran.uwm307.ldrate[2]
    sic_bran.uwm307.ldrate[3] = brsic_bran.uwm307.ldrate[3]
    sic_bran.uwm307.mb4wks    = brsic_bran.uwm307.mb4wks       
    sic_bran.uwm307.mb5wks    = brsic_bran.uwm307.mb5wks       
    sic_bran.uwm307.mb4ded    = brsic_bran.uwm307.mb4ded       
    sic_bran.uwm307.mb5ded    = brsic_bran.uwm307.mb5ded
    sic_bran.uwm307.mb6ded    = brsic_bran.uwm307.mb6ded.

  ASSIGN
    sic_bran.uwm307.abcd[1]   = brsic_bran.uwm307.abcd[1]
    sic_bran.uwm307.abcd[2]   = brsic_bran.uwm307.abcd[2]
    sic_bran.uwm307.abcd[3]   = brsic_bran.uwm307.abcd[3]
    sic_bran.uwm307.abcd[4]   = brsic_bran.uwm307.abcd[4]
    sic_bran.uwm307.abrtae[1] = brsic_bran.uwm307.abrtae[1]
    sic_bran.uwm307.abrtae[2] = brsic_bran.uwm307.abrtae[2]
    sic_bran.uwm307.abrtae[3] = brsic_bran.uwm307.abrtae[3]
    sic_bran.uwm307.abrtae[4] = brsic_bran.uwm307.abrtae[4]
    sic_bran.uwm307.abrt[1]   = brsic_bran.uwm307.abrt[1]
    sic_bran.uwm307.abrt[2]   = brsic_bran.uwm307.abrt[2]
    sic_bran.uwm307.abrt[3]   = brsic_bran.uwm307.abrt[3]
    sic_bran.uwm307.abrt[4]   = brsic_bran.uwm307.abrt[4]
    sic_bran.uwm307.abapae[1] = brsic_bran.uwm307.abapae[1]
    sic_bran.uwm307.abapae[2] = brsic_bran.uwm307.abapae[2]
    sic_bran.uwm307.abapae[3] = brsic_bran.uwm307.abapae[3]
    sic_bran.uwm307.abapae[4] = brsic_bran.uwm307.abapae[4]
    sic_bran.uwm307.abap[1]   = brsic_bran.uwm307.abap[1]
    sic_bran.uwm307.abap[2]   = brsic_bran.uwm307.abap[2]
    sic_bran.uwm307.abap[3]   = brsic_bran.uwm307.abap[3]
    sic_bran.uwm307.abap[4]   = brsic_bran.uwm307.abap[4]
    sic_bran.uwm307.abpdae[1] = brsic_bran.uwm307.abpdae[1]
    sic_bran.uwm307.abpdae[2] = brsic_bran.uwm307.abpdae[2]
    sic_bran.uwm307.abpdae[3] = brsic_bran.uwm307.abpdae[3]
    sic_bran.uwm307.abpdae[4] = brsic_bran.uwm307.abpdae[4]
    sic_bran.uwm307.abpd[1]   = brsic_bran.uwm307.abpd[1]
    sic_bran.uwm307.abpd[2]   = brsic_bran.uwm307.abpd[2]
    sic_bran.uwm307.abpd[3]   = brsic_bran.uwm307.abpd[3]
    sic_bran.uwm307.abpd[4]   = brsic_bran.uwm307.abpd[4].

    sic_bran.uwm307.tariff   = brsic_bran.uwm307.tariff     .
    sic_bran.uwm307.icno     = brsic_bran.uwm307.icno       .
    sic_bran.uwm307.bname3   = brsic_bran.uwm307.bname3     .
    sic_bran.uwm307.mbsi[1]  = brsic_bran.uwm307.mbsi[1]   .
    sic_bran.uwm307.mbsi[2]  = brsic_bran.uwm307.mbsi[2]   .
    sic_bran.uwm307.mbsi[3]  = brsic_bran.uwm307.mbsi[3]   .
    sic_bran.uwm307.mbsi[4]  = brsic_bran.uwm307.mbsi[4]   .
    sic_bran.uwm307.mbsi[5]  = brsic_bran.uwm307.mbsi[5]   .
    sic_bran.uwm307.mbsi[6]  = brsic_bran.uwm307.mbsi[6]   .
    /* ----------------
    sic_bran.uwm307.mbsi[7] = brsic_bran.uwm307.mbsi[7]   .
    sic_bran.uwm307.mbsi[8] = brsic_bran.uwm307.mbsi[8]   .
    sic_bran.uwm307.mbsi[9] = brsic_bran.uwm307.mbsi[9]   .
    sic_bran.uwm307.mbsi[10] = brsic_bran.uwm307.mbsi[10] .
    sic_bran.uwm307.mbsi[11] = brsic_bran.uwm307.mbsi[11] .
    sic_bran.uwm307.mbsi[12] = brsic_bran.uwm307.mbsi[12] .
    ----------------- */
    sic_bran.uwm307.mbr_ae[1] = brsic_bran.uwm307.mbr_ae[1].
    sic_bran.uwm307.mbr_ae[2] = brsic_bran.uwm307.mbr_ae[2].
    sic_bran.uwm307.mbr_ae[3] = brsic_bran.uwm307.mbr_ae[3].
    sic_bran.uwm307.mbr_ae[4] = brsic_bran.uwm307.mbr_ae[4].
    sic_bran.uwm307.mbr_ae[5] = brsic_bran.uwm307.mbr_ae[5].
    sic_bran.uwm307.mbr_ae[6] = brsic_bran.uwm307.mbr_ae[6].
    /* -----------------
    sic_bran.uwm307.mbr_ae[7] = brsic_bran.uwm307.mbr_ae[7].
    sic_bran.uwm307.mbr_ae[8] = brsic_bran.uwm307.mbr_ae[8].
    sic_bran.uwm307.mbr_ae[9] = brsic_bran.uwm307.mbr_ae[9].
    sic_bran.uwm307.mbr_ae[10] = brsic_bran.uwm307.mbr_ae[10].
    sic_bran.uwm307.mbr_ae[11] = brsic_bran.uwm307.mbr_ae[11].
    sic_bran.uwm307.mbr_ae[12] = brsic_bran.uwm307.mbr_ae[12].
    ----------------- */
    sic_bran.uwm307.mbrate[1] = brsic_bran.uwm307.mbrate[1]   .
    sic_bran.uwm307.mbrate[2] = brsic_bran.uwm307.mbrate[2]   .
    sic_bran.uwm307.mbrate[3] = brsic_bran.uwm307.mbrate[3]   .
    sic_bran.uwm307.mbrate[4] = brsic_bran.uwm307.mbrate[4]   .
    sic_bran.uwm307.mbrate[5] = brsic_bran.uwm307.mbrate[5]   .
    sic_bran.uwm307.mbrate[6] = brsic_bran.uwm307.mbrate[6]   .
    /* ------------------
    sic_bran.uwm307.mbrate[7] = brsic_bran.uwm307.mbrate[7]   .
    sic_bran.uwm307.mbrate[8] = brsic_bran.uwm307.mbrate[8]   .
    sic_bran.uwm307.mbrate[9] = brsic_bran.uwm307.mbrate[9]   .
    sic_bran.uwm307.mbrate[10] = brsic_bran.uwm307.mbrate[10] .
    sic_bran.uwm307.mbrate[11] = brsic_bran.uwm307.mbrate[11] .
    sic_bran.uwm307.mbrate[12] = brsic_bran.uwm307.mbrate[12] .
    ----------------- */
    sic_bran.uwm307.mbapae[1] = brsic_bran.uwm307.mbapae[1]   .
    sic_bran.uwm307.mbapae[2] = brsic_bran.uwm307.mbapae[2]   .
    sic_bran.uwm307.mbapae[3] = brsic_bran.uwm307.mbapae[3]   .
    sic_bran.uwm307.mbapae[4] = brsic_bran.uwm307.mbapae[4]   .
    sic_bran.uwm307.mbapae[5] = brsic_bran.uwm307.mbapae[5]   .
    sic_bran.uwm307.mbapae[6] = brsic_bran.uwm307.mbapae[6]   .
    /* -----------------
    sic_bran.uwm307.mbapae[7] = brsic_bran.uwm307.mbapae[7]   .
    sic_bran.uwm307.mbapae[8] = brsic_bran.uwm307.mbapae[8]   .
    sic_bran.uwm307.mbapae[9] = brsic_bran.uwm307.mbapae[9]   .
    sic_bran.uwm307.mbapae[10] = brsic_bran.uwm307.mbapae[10] .
    sic_bran.uwm307.mbapae[11] = brsic_bran.uwm307.mbapae[11] .
    sic_bran.uwm307.mbapae[12] = brsic_bran.uwm307.mbapae[12].
    ------------------ */
    sic_bran.uwm307.mbap[1]   = brsic_bran.uwm307.mbap[1]  .
    sic_bran.uwm307.mbap[2]   = brsic_bran.uwm307.mbap[2]  .
    sic_bran.uwm307.mbap[3]   = brsic_bran.uwm307.mbap[3]   .
    sic_bran.uwm307.mbap[4]   = brsic_bran.uwm307.mbap[4]   .
    sic_bran.uwm307.mbap[5]   = brsic_bran.uwm307.mbap[5]    .
    sic_bran.uwm307.mbap[6]   = brsic_bran.uwm307.mbap[6]    .
    /* -----------------
    sic_bran.uwm307.mbap[7]   = brsic_bran.uwm307.mbap[7]    .
    sic_bran.uwm307.mbap[8]   = brsic_bran.uwm307.mbap[8]    .
    sic_bran.uwm307.mbap[9]   = brsic_bran.uwm307.mbap[9]    .
    sic_bran.uwm307.mbap[10]   = brsic_bran.uwm307.mbap[10]  .
    sic_bran.uwm307.mbap[11]   = brsic_bran.uwm307.mbap[11]  .
    sic_bran.uwm307.mbap[12]   = brsic_bran.uwm307.mbap[12]  .
    ------------------ */
    sic_bran.uwm307.mbpdae[1] = brsic_bran.uwm307.mbpdae[1]  .
    sic_bran.uwm307.mbpdae[2] = brsic_bran.uwm307.mbpdae[2]  .
    sic_bran.uwm307.mbpdae[3] = brsic_bran.uwm307.mbpdae[3]  .
    sic_bran.uwm307.mbpdae[4] = brsic_bran.uwm307.mbpdae[4]  .
    sic_bran.uwm307.mbpdae[5] = brsic_bran.uwm307.mbpdae[5]  .
    sic_bran.uwm307.mbpdae[6] = brsic_bran.uwm307.mbpdae[6]  .
    /* -----------------
    sic_bran.uwm307.mbpdae[7] = brsic_bran.uwm307.mbpdae[7]  .
    sic_bran.uwm307.mbpdae[8] = brsic_bran.uwm307.mbpdae[8]  .
    sic_bran.uwm307.mbpdae[9] = brsic_bran.uwm307.mbpdae[9]  .
    sic_bran.uwm307.mbpdae[10] = brsic_bran.uwm307.mbpdae[10].
    sic_bran.uwm307.mbpdae[11] = brsic_bran.uwm307.mbpdae[11].
    sic_bran.uwm307.mbpdae[12] = brsic_bran.uwm307.mbpdae[12].
    ----------------- */
       
  ASSIGN
    sic_bran.uwm307.mbpd[1] = brsic_bran.uwm307.mbpd[1]
    sic_bran.uwm307.mbpd[2] = brsic_bran.uwm307.mbpd[2]
    sic_bran.uwm307.mbpd[3] = brsic_bran.uwm307.mbpd[3]
    sic_bran.uwm307.mbpd[4] = brsic_bran.uwm307.mbpd[4]
    sic_bran.uwm307.mbpd[5] = brsic_bran.uwm307.mbpd[5]
    sic_bran.uwm307.mbpd[6] = brsic_bran.uwm307.mbpd[6]
    /* ----------------
    sic_bran.uwm307.mbpd[7] = brsic_bran.uwm307.mbpd[7]
    sic_bran.uwm307.mbpd[8] = brsic_bran.uwm307.mbpd[8]
    sic_bran.uwm307.mbpd[9] = brsic_bran.uwm307.mbpd[9]
    sic_bran.uwm307.mbpd[10] = brsic_bran.uwm307.mbpd[10]
    sic_bran.uwm307.mbpd[11] = brsic_bran.uwm307.mbpd[11]
    sic_bran.uwm307.mbpd[12] = brsic_bran.uwm307.mbpd[12]
    ----------------- */
    sic_bran.uwm307.mb1day = brsic_bran.uwm307.mb1day       
    sic_bran.uwm307.mb6day = brsic_bran.uwm307.mb6day       
    sic_bran.uwm307.mb7day = brsic_bran.uwm307.mb7day       
    sic_bran.uwm307.mb8day = brsic_bran.uwm307.mb8day
    sic_bran.uwm307.bchyr  = nv_batchyr 
    sic_bran.uwm307.bchno  = nv_batchno 
    sic_bran.uwm307.bchcnt = nv_batcnt  .
END.  /* IF AVAILABLE brsic_bran.uwm130 THEN DO: */

/* END OF : WGWTB307.P */
