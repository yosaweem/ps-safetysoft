/* WGWGE130   : Program Generage Insured Item (gwtransfer uwm130)  */
/* Copyright   # Safety Insurance Public Company Limited           */ 
/*               บริษัท ประกันคุ้มภัย จำกัด (มหาชน)                */ 
/* WRITE      : Wantanee.  28/09/2006                              */ 
/* Copy From  : wtmge130                                           */ 
/* Wgwimpt0, wgeimpt1  : Program ที่เรียกใช้มาก่อน                 */ 


/*---Wantanee 29/09/2006 A49-0165 ---*/
DEF INPUT        PARAMETER nv_batchyr   AS INTEGER   FORMAT "9999".
DEF INPUT        PARAMETER nv_batchno   AS CHARACTER FORMAT "X(13)".
DEF INPUT        PARAMETER nv_batcnt    AS INTEGER   FORMAT "99".
/*-----------------*/
DEF INPUT        PARAMETER nv_policy    AS CHARACTER FORMAT "X(12)".
DEF INPUT        PARAMETER nv_rencnt    AS INTEGER   FORMAT "999".
DEF INPUT        PARAMETER nv_endcnt    AS INTEGER   FORMAT "999".
DEF INPUT        PARAMETER nv_prem      AS DECIMAL   FORMAT ">,>>>,>>9.99-".
DEF INPUT        PARAMETER nv_si        AS DECIMAL   FORMAT ">,>>>,>>>,>>9.99".
DEF INPUT        PARAMETER nv_i_text    AS CHARACTER FORMAT "X(04)".
DEF INPUT        PARAMETER nv_uom1_c    AS CHARACTER FORMAT "X(04)".
DEF INPUT        PARAMETER nv_poltyp    AS CHARACTER FORMAT "X(2)". 
DEF OUTPUT       PARAMETER n_recid130   AS RECID.
DEF OUTPUT       PARAMETER n_recid132   AS RECID.
DEF INPUT-OUTPUT PARAMETER nv_check     AS CHARACTER .

DEF VAR n_132fp3 AS RECID.
DEF VAR n_132bp3 AS RECID.
DEF VAR s_130fp3 AS RECID.
DEF VAR s_130bp3 AS RECID.
DEF VAR n_bencod AS CHAR FORMAT "x(4)" INIT "".
DEF VAR n_count  AS INTEGER            INIT 0.

/*----Wantanee 28/09/2006----
FIND sic_bran.uwm130 USE-INDEX uwm13001 WHERE
     sic_bran.uwm130.policy = nv_policy AND
     sic_bran.uwm130.rencnt = nv_rencnt AND
     sic_bran.uwm130.endcnt = nv_endcnt AND
     sic_bran.uwm130.riskgp = 0         AND
     sic_bran.uwm130.riskno = 1         AND
     sic_bran.uwm130.itemno = 1
NO-LOCK NO-ERROR NO-WAIT.
IF AVAILABLE sic_bran.uwm130 THEN DO:
  nv_check = "ERROR".
  RETURN.
END.
IF LOCKED sic_bran.uwm130 THEN DO:
  nv_check = "ERROR".
  RETURN.
END.
----Wantanee 28/09/2006----*/

CREATE sic_bran.uwm130.
ASSIGN
  sic_bran.uwm130.policy    = nv_policy   /*Policy No.*/
  sic_bran.uwm130.rencnt    = nv_rencnt   /*Renewal Count*/
  sic_bran.uwm130.endcnt    = nv_endcnt   /*Endorsement Count*/
  sic_bran.uwm130.riskgp    = 0           /*Risk Group*/
  sic_bran.uwm130.riskno    = 1           /*Risk No.*/
  sic_bran.uwm130.itemno    = 1           /*Item No.*/
  sic_bran.uwm130.i_text    = nv_i_text   /*Std. Item Text Ref. No.*/
  sic_bran.uwm130.uom1_c    = nv_uom1_c   /*UOM 1 Code*/
  sic_bran.uwm130.uom2_c    = ""          /*UOM 2 Code*/
  sic_bran.uwm130.uom3_c    = ""          /*UOM 3 Code*/
  sic_bran.uwm130.uom4_c    = ""          /*UOM 4 Code*/
  sic_bran.uwm130.uom5_c    = ""          /*UOM 5 Code*/
  sic_bran.uwm130.uom6_c    = ""          /*UOM 6 Code*/
  sic_bran.uwm130.uom7_c    = ""          /*UOM 7 Code*/
  sic_bran.uwm130.uom1_v    = nv_si       /*UOM 1 Value*/
  sic_bran.uwm130.uom2_v    = 0           /*UOM 2 Value*/
  sic_bran.uwm130.uom3_v    = 0           /*UOM 3 Value*/
  sic_bran.uwm130.uom4_v    = 0           /*UOM 4 Value*/
  sic_bran.uwm130.uom5_v    = 0           /*UOM 5 Value*/
  sic_bran.uwm130.uom6_v    = 0           /*UOM 6 Value*/
  sic_bran.uwm130.uom7_v    = 0           /*UOM 7 Value*/
  sic_bran.uwm130.uom1_u    = ""          /*UOM 1 Unlimited*/
  sic_bran.uwm130.uom2_u    = ""          /*UOM 2 Unlimited*/
  sic_bran.uwm130.uom3_u    = ""          /*UOM 3 Unlimited*/
  sic_bran.uwm130.uom4_u    = ""          /*UOM 4 Unlimited*/
  sic_bran.uwm130.uom5_u    = ""          /*UOM 5 Unlimited*/
  sic_bran.uwm130.uom6_u    = ""          /*UOM 6 Unlimited*/
  sic_bran.uwm130.uom7_u    = ""          /*UOM 7 Unlimited*/
  sic_bran.uwm130.dl1per    = 0           /*Discount/Loading 1 %*/
  sic_bran.uwm130.dl2per    = 0           /*Discount/Loading 2 %*/
  sic_bran.uwm130.dl3per    = 0           /*Discount/Loading 3 %*/
  sic_bran.uwm130.fptr01    = 0           /*First sic_bran.uwd130 Item Upper text*/
  sic_bran.uwm130.bptr01    = 0           /*Last  sic_bran.uwd130 Item Upper Text*/
  sic_bran.uwm130.fptr02    = 0           /*First sic_bran.uwd131 Item Lower Text*/
  sic_bran.uwm130.bptr02    = 0           /*Last  sic_bran.uwd131 Item Lower Text*/
  sic_bran.uwm130.fptr03    = 0           /*First sic_bran.uwd132 Cover & Premium*/
  sic_bran.uwm130.bptr03    = 0           /*Last  sic_bran.uwd132 Cover & Premium*/
  sic_bran.uwm130.fptr04    = 0           /*First sic_bran.uwd134 Item Endt. Text*/
  sic_bran.uwm130.bptr04    = 0           /*Last sic_bran.uwd134 Item Endt. Text*/
  sic_bran.uwm130.fptr05    = 0           /*First sic_bran.uwd136 Item Endt. Clause*/
  sic_bran.uwm130.bptr05    = 0           /*Last sic_bran.uwd136 Item Endt. Clause*/
  sic_bran.uwm130.styp20    = ""          /*Statistic Type Codes (4 x 20)*/
  sic_bran.uwm130.sval20    = ""          /*Statistic Value Codes (4 x 20)*/
  sic_bran.uwm130.itmdel    = NO          /*Item Deleted*/
  sic_bran.uwm130.uom8_c    = ""          /*UOM 8 Code*/
  sic_bran.uwm130.uom8_v    = 0           /*UOM 8 Value*/
  sic_bran.uwm130.uom9_c    = ""          /*UOM 9 Code*/
  sic_bran.uwm130.uom9_v    = 0           /*UOM 9 Value*/
  sic_bran.uwm130.prem_item = 0.          /*Premium Due,item total*/

/*----Wantanee A49-0165 29/09/2006-----*/
ASSIGN
  sic_bran.uwm130.bchyr   = nv_batchyr    /* batch Year */
  sic_bran.uwm130.bchno   = nv_batchno    /* batchno    */
  sic_bran.uwm130.bchcnt  = nv_batcnt.    /* batcnt     */

/* sic_bran.uwd132 : Insured */
/* -------------------------------------------------------------
p     sic_bran.uwd13290                           6 + policy
                                           + rencnt
                                           + endcnt
                                           + riskgp
                                           + riskno
                                           + itemno
-------------------------------------------------------------- */
/*----Wantanee 28/09/2006----
FIND sic_bran.uwd132 WHERE
     sic_bran.uwd132.policy = nv_policy AND
     sic_bran.uwd132.rencnt = nv_rencnt AND
     sic_bran.uwd132.endcnt = nv_endcnt AND
     sic_bran.uwd132.riskgp = 0         AND
     sic_bran.uwd132.riskno = 1         AND
     sic_bran.uwd132.itemno = 1
NO-LOCK NO-ERROR NO-WAIT.
IF AVAILABLE sic_bran.uwd132 THEN DO:
  nv_check = "ERROR".
  RETURN.
END.
IF LOCKED sic_bran.uwd132 THEN DO:
  nv_check = "ERROR".
  RETURN.
END.
----Wantanee 28/09/2006----*/
ASSIGN
  n_132fp3 = 0
  n_132bp3 = 0
  s_130fp3 = 0
  s_130bp3 = 0
  n_bencod = ""
  n_count  = 0.

/*IF SUBSTRING(nv_policy,3,2) = "10" THEN DO:--Wanatanee 28/09/2006--*/
IF nv_poltyp = "10" THEN DO:    
    CREATE sic_bran.uwd132.
    ASSIGN
      sic_bran.uwd132.bencod  = "FIRE"      /*Benefit Code*/
      sic_bran.uwd132.benvar  = ""          /*Benefit Variable*/
      sic_bran.uwd132.rate    = 0           /*Premium Rate %*/
      sic_bran.uwd132.gap_ae  = NO          /*GAP A/E Code*/
      sic_bran.uwd132.gap_c   = nv_prem     /*GAP, per Benefit per Item*/
      sic_bran.uwd132.dl1_c   = 0           /*Disc./Load 1,p. Benefit p.Item*/
      sic_bran.uwd132.dl2_c   = 0           /*Disc./Load 2,p. Benefit p.Item*/
      sic_bran.uwd132.dl3_c   = 0           /*Disc./Load 3,p. Benefit p.Item*/
      sic_bran.uwd132.pd_aep  = "E"         /*Premium Due A/E/P Code*/
      sic_bran.uwd132.prem_c  = nv_prem     /*PD, per Benefit per Item*/
      sic_bran.uwd132.fptr    = 0           /*Forward Pointer*/
      sic_bran.uwd132.bptr    = 0           /*Backward Pointer*/
      sic_bran.uwd132.policy  = nv_policy   /*Policy No. - sic_bran.uwm130*/
      sic_bran.uwd132.rencnt  = nv_rencnt   /*Renewal Count - sic_bran.uwm130*/
      sic_bran.uwd132.endcnt  = nv_endcnt   /*Endorsement Count - sic_bran.uwm130*/
      sic_bran.uwd132.riskgp  = 0           /*Risk Group - sic_bran.uwm130*/
      sic_bran.uwd132.riskno  = 1           /*Risk No. - sic_bran.uwm130*/
      sic_bran.uwd132.itemno  = 1           /*Insured Item No. - sic_bran.uwm130*/
      sic_bran.uwd132.rateae  = NO.         /*Premium Rate % A/E Code*/
    ASSIGN 
       n_132fp3 = RECID(sic_bran.uwd132)
       n_132bp3 = RECID(sic_bran.uwd132)
       s_130fp3 = RECID(sic_bran.uwd132)
       n_bencod = "SURC"
       n_count  = 1.
    loop_create:
    REPEAT:
       IF n_bencod = "" AND n_count > 3 THEN LEAVE loop_create.
       CREATE sic_bran.uwd132.
       ASSIGN
         sic_bran.uwd132.bencod  = n_bencod   
         sic_bran.uwd132.benvar  = ""       
         sic_bran.uwd132.rate    = 0        
         sic_bran.uwd132.gap_ae  = NO       
         sic_bran.uwd132.gap_c   = 0  
         sic_bran.uwd132.dl1_c   = 0        
         sic_bran.uwd132.dl2_c   = 0        
         sic_bran.uwd132.dl3_c   = 0        
         sic_bran.uwd132.pd_aep  = "E"      
         sic_bran.uwd132.prem_c  = 0  
         sic_bran.uwd132.fptr    = 0        
         sic_bran.uwd132.bptr    = n_132bp3        
         sic_bran.uwd132.policy  = nv_policy
         sic_bran.uwd132.rencnt  = nv_rencnt
         sic_bran.uwd132.endcnt  = nv_endcnt
         sic_bran.uwd132.riskgp  = 0        
         sic_bran.uwd132.riskno  = 1        
         sic_bran.uwd132.itemno  = 1        
         sic_bran.uwd132.rateae  = NO.

       ASSIGN 
          n_132fp3 = RECID(sic_bran.uwd132)
          n_count  = n_count + 1.
       IF      n_count = 2 THEN n_bencod = "FEDI".
       ELSE IF n_count = 3 THEN n_bencod = "FADD".
       ELSE n_bencod = "".

       FIND sic_bran.uwd132 WHERE RECID(sic_bran.uwd132) = n_132bp3 NO-WAIT NO-ERROR.
       sic_bran.uwd132.fptr  = n_132fp3.
       FIND sic_bran.uwd132 WHERE RECID(sic_bran.uwd132) = n_132fp3 NO-WAIT NO-ERROR.
       n_132bp3 = RECID(sic_bran.uwd132).
    END.
    s_130bp3 = n_132fp3.

    ASSIGN
      sic_bran.uwm130.fptr03 = s_130fp3
      sic_bran.uwm130.bptr03 = s_130bp3
      n_recid130    = RECID(sic_bran.uwm130)
      n_recid132    = RECID(sic_bran.uwd132).
END.
/*----Wantanee 28/09/2009---
ELSE IF SUBSTRING(nv_policy,3,2) = "60" OR
        SUBSTRING(nv_policy,3,2) = "61" OR 
        SUBSTRING(nv_policy,3,2) = "64" THEN DO:
----Wantanee 28/09/2009---*/           
ELSE IF nv_poltyp = "60" OR
        nv_poltyp = "61" OR 
        nv_poltyp = "64" THEN DO:     
    CREATE sic_bran.uwd132.
    ASSIGN
      sic_bran.uwd132.bencod  = ""            /*Benefit Code*/
      sic_bran.uwd132.benvar  = ""               /*Benefit Variable*/
      sic_bran.uwd132.rate    = 0                /*Premium Rate %*/
      sic_bran.uwd132.gap_ae  = NO               /*GAP A/E Code*/
      sic_bran.uwd132.gap_c   = nv_prem          /*GAP, per Benefit per Item*/
      sic_bran.uwd132.dl1_c   = 0                /*Disc./Load 1,p. Benefit p.Item*/
      sic_bran.uwd132.dl2_c   = 0                /*Disc./Load 2,p. Benefit p.Item*/
      sic_bran.uwd132.dl3_c   = 0                /*Disc./Load 3,p. Benefit p.Item*/
      sic_bran.uwd132.pd_aep  = "E"              /*Premium Due A/E/P Code*/
      sic_bran.uwd132.prem_c  = nv_prem          /*PD, per Benefit per Item*/
      sic_bran.uwd132.fptr    = 0                /*Forward Pointer*/
      sic_bran.uwd132.bptr    = 0                /*Backward Pointer*/
      sic_bran.uwd132.policy  = nv_policy        /*Policy No. - sic_bran.uwm130*/
      sic_bran.uwd132.rencnt  = nv_rencnt        /*Renewal Count - sic_bran.uwm130*/
      sic_bran.uwd132.endcnt  = nv_endcnt        /*Endorsement Count - sic_bran.uwm130*/
      sic_bran.uwd132.riskgp  = 0                /*Risk Group - sic_bran.uwm130*/
      sic_bran.uwd132.riskno  = 1                /*Risk No. - sic_bran.uwm130*/
      sic_bran.uwd132.itemno  = 1                /*Insured Item No. - sic_bran.uwm130*/
      sic_bran.uwd132.rateae  = NO               /*Premium Rate % A/E Code*/
      sic_bran.uwm130.fptr03  = RECID(sic_bran.uwd132)    /*First sic_bran.uwd132 Cover & Premium*/
      sic_bran.uwm130.bptr03  = RECID(sic_bran.uwd132).   /*Last  sic_bran.uwd132 Cover & Premium*/

    ASSIGN
      n_recid130   = RECID(sic_bran.uwm130)
      n_recid132   = RECID(sic_bran.uwd132).
END.
ELSE DO:
    CREATE sic_bran.uwd132.
    ASSIGN
      sic_bran.uwd132.bencod  = "PRM"            /*Benefit Code*/
      sic_bran.uwd132.benvar  = ""               /*Benefit Variable*/
      sic_bran.uwd132.rate    = 0                /*Premium Rate %*/
      sic_bran.uwd132.gap_ae  = NO               /*GAP A/E Code*/
      sic_bran.uwd132.gap_c   = nv_prem          /*GAP, per Benefit per Item*/
      sic_bran.uwd132.dl1_c   = 0                /*Disc./Load 1,p. Benefit p.Item*/
      sic_bran.uwd132.dl2_c   = 0                /*Disc./Load 2,p. Benefit p.Item*/
      sic_bran.uwd132.dl3_c   = 0                /*Disc./Load 3,p. Benefit p.Item*/
      sic_bran.uwd132.pd_aep  = "E"              /*Premium Due A/E/P Code*/
      sic_bran.uwd132.prem_c  = nv_prem          /*PD, per Benefit per Item*/
      sic_bran.uwd132.fptr    = 0                /*Forward Pointer*/
      sic_bran.uwd132.bptr    = 0                /*Backward Pointer*/
      sic_bran.uwd132.policy  = nv_policy        /*Policy No. - sic_bran.uwm130*/
      sic_bran.uwd132.rencnt  = nv_rencnt        /*Renewal Count - sic_bran.uwm130*/
      sic_bran.uwd132.endcnt  = nv_endcnt        /*Endorsement Count - sic_bran.uwm130*/
      sic_bran.uwd132.riskgp  = 0                /*Risk Group - sic_bran.uwm130*/
      sic_bran.uwd132.riskno  = 1                /*Risk No. - sic_bran.uwm130*/
      sic_bran.uwd132.itemno  = 1                /*Insured Item No. - sic_bran.uwm130*/
      sic_bran.uwd132.rateae  = NO               /*Premium Rate % A/E Code*/
      sic_bran.uwm130.fptr03  = RECID(sic_bran.uwd132)    /*First sic_bran.uwd132 Cover & Premium*/
      sic_bran.uwm130.bptr03  = RECID(sic_bran.uwd132).   /*Last  sic_bran.uwd132 Cover & Premium*/
    
    ASSIGN
      sic_bran.uwd132.bchyr   = nv_batchyr         /* batch Year */
      sic_bran.uwd132.bchno   = nv_batchno         /* batchno    */
      sic_bran.uwd132.bchcnt  = nv_batcnt .        /* batcnt     */

    ASSIGN
      n_recid130   = RECID(sic_bran.uwm130)
      n_recid132   = RECID(sic_bran.uwd132).
END.

/* END OF FILE : TMGEN130.P */
