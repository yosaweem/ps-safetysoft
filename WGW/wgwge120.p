/* WGWGE120   : Program Generage Risk Header (gwtransfer sic_bran.uwm120) */
/* Copyright   # Safety Insurance Public Company Limited                  */
/*               บริษัท ประกันคุ้มภัย จำกัด (มหาชน)                       */
/* WRITE      : Wantanee.  28/09/2006                                     */
/* Copy From  : WGWGE120 (ModiFy)                                         */
/* Wgwimpt0, Wgwimpt1  : Program ที่เรียกใช้มาก่อน                        */


/*---Wantanee 29/09/2006 A49-0165 ---*/
DEF INPUT        PARAMETER nv_batchyr   AS INTEGER   FORMAT "9999".
DEF INPUT        PARAMETER nv_batchno   AS CHARACTER FORMAT "X(13)".
DEF INPUT        PARAMETER nv_batcnt    AS INTEGER   FORMAT "99".
/*-----*/

DEF INPUT        PARAMETER nv_policy    AS CHARACTER FORMAT "X(12)".
DEF INPUT        PARAMETER nv_rencnt    AS INTEGER   FORMAT "999".
DEF INPUT        PARAMETER nv_endcnt    AS INTEGER   FORMAT "999".
DEF INPUT        PARAMETER nv_prem      AS DECIMAL   FORMAT ">,>>>,>>9.99-".
/*DEF INPUT        PARAMETER nv_pdty_p    AS DECIMAL   FORMAT ">>>,>>9.99-".*/
DEF INPUT        PARAMETER nv_pdstp     AS DECIMAL   FORMAT ">,>>>,>>9.99-".
DEF INPUT        PARAMETER nv_pdtyp     AS DECIMAL   FORMAT ">,>>>,>>9.99-".
DEF INPUT        PARAMETER nv_pdcop     AS DECIMAL   FORMAT ">,>>>,>>9.99-".
DEF INPUT        PARAMETER nv_pdfap     AS DECIMAL   FORMAT ">,>>>,>>9.99-".
DEF INPUT        PARAMETER nv_pdqsp     AS DECIMAL   FORMAT ">,>>>,>>9.99-".
DEF INPUT        PARAMETER nv_com1_t    AS DECIMAL   FORMAT ">>>,>>9.99-".
DEF INPUT        PARAMETER nv_com1p     AS DECIMAL   FORMAT ">>9.99-".
DEF INPUT        PARAMETER nv_comst     AS DECIMAL   FORMAT ">>>,>>9.99-".
DEF INPUT        PARAMETER nv_comty     AS DECIMAL   FORMAT ">>>,>>9.99-".
DEF INPUT        PARAMETER nv_comco     AS DECIMAL   FORMAT ">>>,>>9.99-".
DEF INPUT        PARAMETER nv_comfa     AS DECIMAL   FORMAT ">>>,>>9.99-".
DEF INPUT        PARAMETER nv_comqs     AS DECIMAL   FORMAT ">>>,>>9.99-".
DEF INPUT        PARAMETER nv_si        AS DECIMAL   FORMAT ">,>>>,>>>,>>9.99".
/*DEF INPUT        PARAMETER nv_sity_p    AS DECIMAL   FORMAT ">,>>>,>>>,>>9.99".*/
DEF INPUT        PARAMETER nv_sistp     AS DECIMAL   FORMAT ">,>>>,>>>,>>9.99".
DEF INPUT        PARAMETER nv_sityp     AS DECIMAL   FORMAT ">,>>>,>>>,>>9.99".
DEF INPUT        PARAMETER nv_sicop     AS DECIMAL   FORMAT ">,>>>,>>>,>>9.99".
DEF INPUT        PARAMETER nv_sifap     AS DECIMAL   FORMAT ">,>>>,>>>,>>9.99".
DEF INPUT        PARAMETER nv_siqsp     AS DECIMAL   FORMAT ">,>>>,>>>,>>9.99".
DEF INPUT        PARAMETER nv_class     AS CHARACTER FORMAT "X(04)".
DEF INPUT        PARAMETER nv_r_text    AS CHARACTER FORMAT "X(04)".
DEF OUTPUT       PARAMETER n_recid120   AS RECID.
DEF INPUT-OUTPUT PARAMETER nv_check     AS CHARACTER .
/* ------------------------------------------------------------- */
/*---Wantanee 28/09/2006----
FIND sic_bran.uwm120 USE-INDEX uwm12001 WHERE
     sic_bran.uwm120.policy = nv_policy AND
     sic_bran.uwm120.rencnt = nv_rencnt AND
     sic_bran.uwm120.endcnt = nv_endcnt AND
     sic_bran.uwm120.riskgp = 0         AND
     sic_bran.uwm120.riskno = 1
NO-LOCK NO-ERROR NO-WAIT.
IF AVAILABLE sic_bran.uwm120 THEN DO:
  nv_check = "ERROR".
  RETURN.
END.
IF LOCKED sic_bran.uwm120 THEN DO:
  nv_check = "ERROR".
  RETURN.
END.
---Wantanee 28/09/2006----*/

CREATE sic_bran.uwm120.
ASSIGN
  sic_bran.uwm120.policy   = nv_policy      /*Policy No. */
  sic_bran.uwm120.rencnt   = nv_rencnt      /*Renewal Count*/
  sic_bran.uwm120.endcnt   = nv_endcnt      /*Endorsement Count*/
  sic_bran.uwm120.riskgp   = 0              /*Risk Group */
  sic_bran.uwm120.riskno   = 1              /*Risk No. */
  sic_bran.uwm120.fptr01   = 0              /*First uwd120 Risk Upper Text */
  sic_bran.uwm120.bptr01   = 0              /*Last  uwd120 Risk Upper Text */
  sic_bran.uwm120.fptr02   = 0              /*First uwd121 Risk Lower Text */
  sic_bran.uwm120.bptr02   = 0              /*Last  uwd121 Risk Lower Text */
  sic_bran.uwm120.fptr03   = 0              /*First uwd123 Borderau Text */
  sic_bran.uwm120.bptr03   = 0              /*Last  uwd123 Borderau Text */
  sic_bran.uwm120.fptr04   = 0              /*First uwd125 Risk Clauses*/
  sic_bran.uwm120.bptr04   = 0              /*Last  uwd125 Risk Clauses*/
  sic_bran.uwm120.fptr08   = 0              /*First uwd124 Risk Endt. Text */
  sic_bran.uwm120.bptr08   = 0              /*Last uwd124 Risk Endt. Text*/
  sic_bran.uwm120.fptr09   = 0              /*First uwd126 Risk Endt. Clause */
  sic_bran.uwm120.bptr09   = 0              /*Last uwd126 Risk Endt. Clause*/
  sic_bran.uwm120.class    = nv_class       /*Business Class Code*/
  sic_bran.uwm120.sicurr   = "BHT"          /*Sum Insured Currency */
  sic_bran.uwm120.siexch   = 1              /*Sum Insured Exchange Rate*/
  sic_bran.uwm120.r_text   = nv_r_text      /*Standard Risk Text Ref. No.*/
  /*sic_bran.uwm120.r_text   = "IN1"        /*Standard Risk Text Ref. No.*/*/
  sic_bran.uwm120.rskdel   = NO             /*Risk Deleted (Y/N) */
  sic_bran.uwm120.styp20   = ""             /*Statistic Type Codes (4 x 20)*/
  sic_bran.uwm120.sval20   = ""             /*Statistic Value Codes (4 x 20) */
  sic_bran.uwm120.gap_r    = nv_prem        /*Gross Annual Prem., Risk Total */
  sic_bran.uwm120.dl1_r    = 0              /*Discount/Loading 1, Risk Total */
  sic_bran.uwm120.dl2_r    = 0              /*Discount/Loading 2, Risk Total */
  sic_bran.uwm120.dl3_r    = 0              /*Discount/Loading 3, Risk Total */
  sic_bran.uwm120.rstp_r   = 0              /*Risk Level Stamp, Risk Total */
  sic_bran.uwm120.rfee_r   = 0              /*Risk Level Fee, Risk Total */
  sic_bran.uwm120.rtax_r   = 0              /*Risk Level Tax, Risk Total */
  sic_bran.uwm120.prem_r   = nv_prem        /*Premium Due, Risk Total*/
  sic_bran.uwm120.com1_r   = nv_com1_t      /*Commission 1, Risk Total */
  sic_bran.uwm120.com2_r   = 0              /*Commission 2, Risk Total */
  sic_bran.uwm120.com3_r   = 0              /*Commission 3, Risk Total */
  sic_bran.uwm120.com4_r   = 0              /*Commission 4, Risk Total */
  sic_bran.uwm120.com1p    = nv_com1p       /*Commission 1 % */
  sic_bran.uwm120.com2p    = 0              /*Commission 2 % */
  sic_bran.uwm120.com3p    = 0              /*Commission 3 % */
  sic_bran.uwm120.com4p    = 0              /*Commission 4 % */
  sic_bran.uwm120.com1ae   = NO             /*Commission 1 (A/E) */
  sic_bran.uwm120.com2ae   = YES            /*Commission 2 (A/E) */
  sic_bran.uwm120.com3ae   = YES            /*Commission 3 (A/E) */
  sic_bran.uwm120.com4ae   = YES            /*Commission 4 (A/E) */
  sic_bran.uwm120.rilate   = NO             /*RI to Enter Later (Y/N)*/
  sic_bran.uwm120.sigr     = nv_si          /*Sum Insured, Gross */
  sic_bran.uwm120.sico     = nv_sicop       /*Sum Insured, Coinsurance */
  sic_bran.uwm120.sist     = nv_sistp       /*Sum Insured, Statutory */
  sic_bran.uwm120.sifac    = nv_sifap       /*Sum Insured, Facultative */
  sic_bran.uwm120.sitty    = nv_sityp       /*Sum Insured, Treaty*/
  sic_bran.uwm120.siqs     = nv_siqsp       /*Sum Insured, Quota Share */
  sic_bran.uwm120.pdco     = nv_pdcop       /*Premium Due, Coinsurance */
  sic_bran.uwm120.pdst     = nv_pdstp       /*Premium Due, Statutory */
  sic_bran.uwm120.pdfac    = nv_pdfap       /*Premium Due, Facultative */
  sic_bran.uwm120.pdtty    = nv_pdtyp       /*Premium Due, Treaty*/
  sic_bran.uwm120.pdqs     = nv_pdqsp       /*Premium Due, Quota Share */
  sic_bran.uwm120.comco    = nv_comco       /*Commission, Coinsurance*/
  sic_bran.uwm120.comst    = nv_comst       /*Commission, Statutory*/
  sic_bran.uwm120.comfac   = nv_comfa       /*Commission, Facultative*/
  sic_bran.uwm120.comtty   = nv_comty       /*Commission, Treaty */
  sic_bran.uwm120.comqs    = nv_comqs       /*Commission, Quota Share*/
  sic_bran.uwm120.stmpae   = NO             /*Risk Level Stamp (A/E) */
  sic_bran.uwm120.feeae    = YES            /*Risk Level Fee (A/E) */
  sic_bran.uwm120.taxae    = NO             /*Risk Level Tax (A/E) */
  sic_bran.uwm120.siret    = 0.             /*SI Retention */
  /*sic_bran.uwm120.premr_ae =  */          /*Premium Risk,A/E */

/*----Wantanee 29/09/2006-----*/
ASSIGN                                     
  sic_bran.uwm120.bchyr  = nv_batchyr    /* batch Year */ 
  sic_bran.uwm120.bchno  = nv_batchno    /* batchno    */ 
  sic_bran.uwm120.bchcnt = nv_batcnt.    /* batcnt     */ 

n_recid120   = RECID(sic_bran.uwm120).

/* END OF FILE : TMGEN120.P */
