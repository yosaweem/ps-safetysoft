/*=================================================================*/
/* Program Name : wGwGen06.P   Gen. Data Detaitem To DB Premium    */
/* Assign  No   : A54-0005                                         */
/* CREATE  By   : Amparat C.           (Date 23/12/2010)           */
/*                โอนข้อมูลจาก DB Gw Transfer To Premium           */
/*=================================================================*/
/*MESSAGE "Update  DETAITEM".*/
DEF INPUT PARAMETER nv_bchyr  AS INT.
DEF INPUT PARAMETER nv_bchno  AS CHAR.
DEF INPUT PARAMETER nv_bchcnt AS INT.
DEF INPUT PARAMETER nv_policy AS CHAR.
DEF INPUT PARAMETER nv_rencnt AS INT.
DEF INPUT PARAMETER nv_endcnt AS INT.

DEF  VAR nv_sic_bran  AS INTE INIT 0  NO-UNDO.
DEF  VAR nv_host      AS INTE INIT 0  NO-UNDO.


FOR EACH brstat.detaitem WHERE 
         brstat.detaitem.policy  = nv_Policy   AND
         brstat.detaitem.rencnt  = nv_RenCnt   AND
         brstat.detaitem.endcnt  = nv_EndCnt   AND
         brstat.detaitem.YearReg = nv_bchyr    AND   
         brstat.detaitem.seqno   = nv_bchno    AND   
         brstat.detaitem.seqno2  = STRING(nv_bchcnt)    :
  FIND FIRST stat.detaitem WHERE 
             stat.detaitem.policy = brstat.detaitem.policy AND
             stat.detaitem.rencnt = brstat.detaitem.rencnt AND
             stat.detaitem.endcnt = brstat.detaitem.endcnt AND       
             stat.detaitem.riskno = brstat.detaitem.riskno AND
             stat.detaitem.itemno = brstat.detaitem.itemno NO-ERROR.

  IF NOT AVAILABLE stat.detaitem THEN DO:
     CREATE stat.detaitem.
     ASSIGN
       stat.detaitem.policy   = brstat.detaitem.policy
       stat.detaitem.rencnt   = brstat.detaitem.rencnt
       stat.detaitem.endcnt   = brstat.detaitem.endcnt
       stat.detaitem.riskno   = brstat.detaitem.riskno 
       stat.detaitem.itemno   = brstat.detaitem.itemno 
       stat.detaitem.serailno = brstat.detaitem.serailno
       stat.detaitem.YearReg  = brstat.detaitem.YearReg
       stat.detaitem.seqno    = brstat.detaitem.seqno  
       stat.detaitem.seqno2   = brstat.detaitem.seqno2 .
  END.


END.



