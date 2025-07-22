/* WGWGE304   : Program Generage Fire Risk (uwm304)        */
/* Copyright   # Safety Insurance Public Company Limited   */
/*               บริษัท ประกันคุ้มภัย จำกัด (มหาชน)        */
/* WRITE      : Wantanee.  29/09/2006                      */
/* Copy From  : wtmge304.p                                 */
/* Wgwimpt0, Wgwimpt1  : Program ที่เรียกใช้มาก่อน         */


/*---Wantanee 29/09/2006 A49-0165 ---*/
DEF INPUT        PARAMETER nv_batchyr   AS INTEGER   FORMAT "9999".
DEF INPUT        PARAMETER nv_batchno   AS CHARACTER FORMAT "X(13)".
DEF INPUT        PARAMETER nv_batcnt    AS INTEGER   FORMAT "99".
/*------*/

DEF INPUT        PARAMETER nv_policy   AS CHARACTER FORMAT "X(12)".
DEF INPUT        PARAMETER nv_rencnt   AS INTEGER   FORMAT "999".
DEF INPUT        PARAMETER nv_endcnt   AS INTEGER   FORMAT "999".
DEF OUTPUT       PARAMETER n_recid304  AS RECID.
DEF INPUT-OUTPUT PARAMETER nv_check    AS CHARACTER .

/*----Wantanee 29/09/2006------
FIND sic_bran.uwm304 USE-INDEX uwm30401 WHERE
     sic_bran.uwm304.policy = nv_policy AND
     sic_bran.uwm304.rencnt = nv_rencnt AND
     sic_bran.uwm304.endcnt = nv_endcnt AND
     sic_bran.uwm304.riskgp = 0         AND
     sic_bran.uwm304.riskno = 1
NO-LOCK NO-ERROR NO-WAIT.
IF AVAILABLE sic_bran.uwm304 THEN DO:
  nv_check = "ERROR".
  RETURN.
END.
IF LOCKED sic_bran.uwm304 THEN DO:
  nv_check = "ERROR".
  RETURN.
END.
----Wantanee 29/09/2006------*/

CREATE sic_bran.uwm304.
ASSIGN
  sic_bran.uwm304.policy   = nv_policy    /*Policy No.*/
  sic_bran.uwm304.rencnt   = nv_rencnt    /*Renewal Count */
  sic_bran.uwm304.endcnt   = nv_endcnt    /*Endorsement Count */
  sic_bran.uwm304.riskgp   = 0            /*Risk Group*/
  sic_bran.uwm304.riskno   = 1            /*Risk No.*/
  sic_bran.uwm304.locn1    = ""           /*Location line 1 */
  sic_bran.uwm304.locn2    = ""           /*Location Line 2 */
  sic_bran.uwm304.locn3    = ""           /*Location Line 3 */
  sic_bran.uwm304.ownten   = "O"          /*Owner/Tenant*/
  sic_bran.uwm304.storey   = ""           /*No. of Storeys*/
  sic_bran.uwm304.wall     = ""           /*External Wall */
  sic_bran.uwm304.floor    = ""           /*Upper Floor */
  sic_bran.uwm304.beam     = ""           /*Roof Beam */
  sic_bran.uwm304.roof     = ""           /*Roof*/
  sic_bran.uwm304.nohong   = 0            /*No. of Hong */
  sic_bran.uwm304.area     = ""           /*Internal Area */
  sic_bran.uwm304.front    = 0            /*Front Distance*/
  sic_bran.uwm304.rear     = 0            /*Rear Distance */
  sic_bran.uwm304.left     = 0            /*Left Distance */
  sic_bran.uwm304.right    = 0            /*Right Distance*/
  sic_bran.uwm304.occupy   = ""           /*Occupancy */
  sic_bran.uwm304.occupn   = "XXXX"       /*Occupation Class Code */
  sic_bran.uwm304.constr   = "X"          /*Construction Class Code */
  sic_bran.uwm304.distct   = "XXXX"       /*District Class Code */
  sic_bran.uwm304.clatch   = ""           /*Clauses attached*/
  sic_bran.uwm304.occlim   = ""           /*Occupation Class Limit Code */
  sic_bran.uwm304.fptr01   = 0            /*First sic_bran.uwd140 Fire Risk Sitn.*/
  sic_bran.uwm304.bptr01   = 0            /*Last sic_bran.uwd140 Fire Risk Sitn. */
  sic_bran.uwm304.fptr02   = 0            /*First sic_bran.uwd141 Block Nos. */
  sic_bran.uwm304.bptr02   = 0            /*Last sic_bran.uwd141 Block Nos.*/
  sic_bran.uwm304.pcrisk   = ""           /*Postal Code of Risk */
  sic_bran.uwm304.prevloc  = NO           /*Same as previous location */
  sic_bran.uwm304.planno   = "".          /*Plan No.*/

/*-----Wantanee 29/09/2006 A49-0165 -----*/
ASSIGN
  sic_bran.uwm304.bchyr = nv_batchyr    /* batch Year */  
  sic_bran.uwm304.bchno = nv_batchno    /* batchno    */  
  sic_bran.uwm304.bchcnt  = nv_batcnt.    /* batcnt     */  


/* Fire Risk Block Numbers */
CREATE sic_bran.uwd141.
ASSIGN
     sic_bran.uwd141.prov_n    = "XX"        /* Province No.*/
     sic_bran.uwd141.dist_n    = "XX"        /* District No.*/
     sic_bran.uwd141.blok_n    = "XXX"       /* Block No. */
     sic_bran.uwd141.fptr      = 0           /* Forward Pointer */
     sic_bran.uwd141.bptr      = 0           /* Backward Pointer*/
     sic_bran.uwd141.policy    = nv_policy   /* Policy No. - sic_bran.uwm304 */
     sic_bran.uwd141.rencnt    = nv_rencnt   /* Renewal Count  - sic_bran.uwm30*/
     sic_bran.uwd141.endcnt    = nv_endcnt   /* Endorsement Count - uw*/
     sic_bran.uwd141.riskgp    = 0           /* Risk Group - sic_bran.uwm304 */
     sic_bran.uwd141.riskno    = 1           /* Risk No. - sic_bran.uwm304 */
     sic_bran.uwd141.sblok_n   = "".         /* Sub Block */

ASSIGN
     sic_bran.uwd141.bchyr     = nv_batchyr  /* batch Year */
     sic_bran.uwd141.bchno     = nv_batchno  /* batchno    */
     sic_bran.uwd141.bchcnt    = nv_batcnt.  /* batcnt     */

ASSIGN
    sic_bran.uwm304.fptr02 = RECID(sic_bran.uwd141)
    sic_bran.uwm304.bptr02 = RECID(sic_bran.uwd141).

n_recid304   = RECID(sic_bran.uwm304).
/* END OF FILE : TMGEN304.P */
