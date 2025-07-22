/*=================================================================*/
/* Program Name : wGwCtx72.P   Gen. Data Uwm100 To DB GWCTX        */
/* Assign  No   : A54-0025                                         */
/* CREATE  By   : Amparat C.           (Date 13/02/2012)           */
/*                โอนข้อมูลจาก DB Sic_bran -Ld CtxBran To GwCtx    */
/*=================================================================*/
DEF SHARED VAR n_User   AS CHAR.
DEF INPUT PARAMETER nv_policy AS CHAR.
DEF INPUT PARAMETER n_compno AS CHAR.

DEF VAR nv_i AS INT.
DEFINE VAR nv_fptr       AS RECID.
DEFINE VAR nv_bptr       AS RECID.
DEFINE BUFFER wf_uwd100 FOR GwCtx.uwd100.

nv_i = nv_i + 1.
FIND CtxBran.uwm100 USE-INDEX uwm10001 WHERE 
     CtxBran.uwm100.policy =  nv_policy AND
     CtxBran.uwm100.rencnt =  0 AND
     CtxBran.uwm100.endcnt =  0 NO-ERROR.
IF AVAIL CtxBran.uwm100 THEN DO:    
   FIND LAST GwCtx.uwm100 USE-INDEX uwm10001 WHERE 
        GwCtx.uwm100.policy = CtxBran.uwm100.Policy AND
        GwCtx.uwm100.rencnt = CtxBran.uwm100.rencnt AND
        GwCtx.uwm100.endcnt = CtxBran.uwm100.endcnt AND 
        GwCtx.uwm100.releas = YES   NO-ERROR.
   IF AVAIL GwCtx.uwm100 THEN DO:    
      ASSIGN GwCtx.uwm100.releas = NO.
   END.
END.
