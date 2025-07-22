/* WGWGE200   : Program Generage RI OUT HEADER ( Gwtransfer uwm200)  */ 
/* Copyright   # Safety Insurance Public Company Limited             */ 
/*               บริษัท ประกันคุ้มภัย จำกัด (มหาชน)                  */ 
/* WRITE      : Wantanee.  28/09/2006                                */ 
/* Copy From  : Twtmge200                                            */ 
/* Wgwimpt0, Wgwimpt1  : Program ที่เรียกใช้มาก่อน                   */ 
/*Modify BY : Jiraphon P. A64-0380 06/06/2022
            : Change Table Allocate Treaty Code (xmm025 > run uwetr225) */
/*---Wantanee 29/09/2006 A49-0165 ---*/
DEF INPUT        PARAMETER nv_batchyr   AS INTEGER   FORMAT "9999".
DEF INPUT        PARAMETER nv_batchno   AS CHARACTER FORMAT "X(13)".
DEF INPUT        PARAMETER nv_batcnt    AS INTEGER   FORMAT "99".
/*---------*/
DEF INPUT        PARAMETER nv_policy AS CHARACTER FORMAT "X(12)".
DEF INPUT        PARAMETER nv_rencnt AS INTEGER   FORMAT "999".
DEF INPUT        PARAMETER nv_endcnt AS INTEGER   FORMAT "999".
DEF INPUT        PARAMETER nv_csftq  AS CHARACTER FORMAT "X(01)".
DEF INPUT        PARAMETER nv_rico   AS CHARACTER FORMAT "X(07)".
DEF INPUT        PARAMETER nv_rip2ae AS LOGICAL                 .
DEF INPUT        PARAMETER nv_rip1   AS DECIMAL   FORMAT ">>9.999999".
DEF INPUT        PARAMETER nv_comdat AS DATE      FORMAT "99/99/9999".
DEF INPUT        PARAMETER nv_expdat AS DATE      FORMAT "99/99/9999".
DEF INPUT        PARAMETER nv_trndat AS DATE      FORMAT "99/99/9999".
DEF INPUT        PARAMETER nv_c_year AS INTEGER   FORMAT "9999".
DEF INPUT        PARAMETER nv_risiae AS LOGICAL                 .
DEF INPUT        PARAMETER nv_risi   AS DECIMAL   FORMAT ">>>,>>>,>>>,>>9.99-".
DEF INPUT        PARAMETER nv_risi_p AS DECIMAL   FORMAT ">>9.999999-".
DEF INPUT        PARAMETER nv_ripsae AS LOGICAL                 .
DEF INPUT        PARAMETER nv_ripr   AS DECIMAL   FORMAT ">>,>>>,>>>,>>9.99-".
DEF INPUT        PARAMETER nv_ric1   AS DECIMAL   FORMAT ">>9.99-".
DEF INPUT-OUTPUT PARAMETER nv_check  AS CHARACTER .
/*Add A64-0380*/
DEF INPUT        PARAMETER nv_rip2      AS DECIMAL   FORMAT ">>9.999999".
DEF INPUT        PARAMETER nv_ric2      AS DECIMAL   FORMAT ">>9.99-".
DEF INPUT        PARAMETER nv_treaty_yr AS CHAR   FORMAT "X(10)".
DEF INPUT        PARAMETER nv_rip1ae AS LOGICAL.
/*End A64-0380*/
/*  sic_bran.uwm200  :  RI Out Header   */
/* -------------------------------------------------------------
pu    sic_bran.uwm20001                           6 + policy
                                           + rencnt
                                           + endcnt
                                           + csftq
                                           + rico
                                           - c_enct
------------------------------------------------------------- */
/*----Wantanee 28/09/2006------
FIND sic_bran.uwm200 USE-INDEX  uwm20001 WHERE
     sic_bran.uwm200.policy = nv_policy AND
     sic_bran.uwm200.rencnt = nv_rencnt AND
     sic_bran.uwm200.endcnt = nv_endcnt AND
     sic_bran.uwm200.csftq  = nv_csftq  AND
     sic_bran.uwm200.rico   = nv_rico   AND
     sic_bran.uwm200.c_enct = 0
NO-LOCK NO-ERROR NO-WAIT.
IF AVAILABLE sic_bran.uwm200 THEN DO:
  nv_check = "ERROR".
  RETURN.
END.
IF LOCKED sic_bran.uwm200 THEN DO:
  nv_check = "ERROR".
  RETURN.
END.
----Wantanee 28/09/2006------*/

CREATE sic_bran.uwm200.
ASSIGN
  sic_bran.uwm200.policy    = nv_policy      /*Policy No.*/
  sic_bran.uwm200.rencnt    = nv_rencnt      /*Renewal Count*/
  sic_bran.uwm200.endcnt    = nv_endcnt      /*Endorsement Count*/
  sic_bran.uwm200.c_enct    = 0              /*Cession Endorsement Count*/
  sic_bran.uwm200.csftq     = nv_csftq       /*Co/Stat/Fac/Tty/Qs*/
  sic_bran.uwm200.rico      = nv_rico        /*RI Company/Treaty*/
  sic_bran.uwm200.dept      = "B"            /*Department Code*/
  sic_bran.uwm200.c_no      = 0              /*Cession No.*/
  sic_bran.uwm200.c_enno    = 0              /*Cession Endorsement No.*/
  sic_bran.uwm200.rip1ae    = NO             /*Commission 1% A/E*/
  sic_bran.uwm200.rip2ae    = nv_rip2ae      /*Commission 2% A/E*/
  sic_bran.uwm200.rip1      = nv_rip1        /*Commission 1%*/
  sic_bran.uwm200.rip2      = 0              /*Commission 2%*/
  sic_bran.uwm200.recip     = "N"            /*Reciprocal (Y/N/C)*/
  sic_bran.uwm200.ricomm    = nv_comdat      /*RI Cover Commencement Date*/
  sic_bran.uwm200.riexp     = nv_expdat      /*RI Cover Expiry Date*/
  sic_bran.uwm200.trndat    = nv_trndat      /*Transaction Date*/
  sic_bran.uwm200.com2gn    = YES            /*Commission 2 Gross/Net*/
  sic_bran.uwm200.ristmp    = 0              /*Stamp Duty on Cession*/
  sic_bran.uwm200.prntri    = NO             /*Print RI Application Y/N*/
  sic_bran.uwm200.thpol     = ""             /*Their Policy No.*/
  sic_bran.uwm200.c_year    = nv_c_year      /*Cession Year*/
  sic_bran.uwm200.trtyri    = ""             /*Tran. Type(1) RI Out*/
  sic_bran.uwm200.docri     = ""             /*Document No.*/
  sic_bran.uwm200.fptr01    = 0              /*First sic_bran.uwd200 RI Out Premium*/
  sic_bran.uwm200.bptr01    = 0              /*Last sic_bran.uwd200 RI Out Premium*/
  sic_bran.uwm200.fptr02    = 0              /*First sic_bran.uwd201 RI Appl. Text*/
  sic_bran.uwm200.bptr02    = 0              /*Last sic_bran.uwd201 RI Appl. Text*/
  sic_bran.uwm200.fptr03    = 0              /*First sic_bran.uwd202 RI Appl.Endt.Text*/
  sic_bran.uwm200.bptr03    = 0              /*Last sic_bran.uwd202 RI Appl.Endt.Text*/
  sic_bran.uwm200.dreg_p    = NO             /*Daily Prem.Reg.Printed*/
  sic_bran.uwm200.curbil    = "BHT"          /*Currency of Billing*/
  sic_bran.uwm200.reg_no    = 0              /*Daily Prem. Reg. No.*/
  sic_bran.uwm200.bordno    = 0              /*Bordereau No.*/
  sic_bran.uwm200.panel     = ""             /*Open Cover Fac Panel*/
  sic_bran.uwm200.riendt    = ?              /*RI Cover Endorsement Date*/
  /*Add A64-0380*/
  sic_bran.uwm200.rip1ae    = nv_rip1ae
  sic_bran.uwm200.rip2      = nv_rip2        /*Commission 2%*/
  sic_bran.uwm200.treaty_yr = nv_treaty_yr.  /*Treaty Year*/
  /*End A64-0380*/

/*----------Wantanee 29/09/2006 A49-0165----*/
ASSIGN
  sic_bran.uwm200.bchyr   = nv_batchyr         /* batch Year */ 
  sic_bran.uwm200.bchno   = nv_batchno         /* batchno    */ 
  sic_bran.uwm200.bchcnt  = nv_batcnt.         /* batcnt     */ 

/*  sic_bran.uwd200  :  RI Out Premium  */
/* ------------------------------------------------------------------------
pu    sic_bran.uwd20001                           8 + policy
                                           + rencnt
                                           + endcnt
                                           + csftq
                                           + rico
                                           + riskgp
                                           + riskno
                                           - c_enct
------------------------------------------------------------------------ */
/*----Wantanee 28/09/2006------
FIND sic_bran.uwd200 USE-INDEX  uwd20001 WHERE
     sic_bran.uwd200.policy = nv_policy   AND
     sic_bran.uwd200.rencnt = nv_rencnt   AND
     sic_bran.uwd200.endcnt = nv_endcnt   AND
     sic_bran.uwd200.csftq  = nv_csftq    AND
     sic_bran.uwd200.rico   = nv_rico     AND
     sic_bran.uwd200.riskgp = 0           AND
     sic_bran.uwd200.riskno = 1           AND
     sic_bran.uwd200.c_enct = 0
NO-LOCK NO-ERROR NO-WAIT.
IF AVAILABLE sic_bran.uwd200 THEN DO:
  nv_check = "ERROR".
  RETURN.
END.
IF LOCKED sic_bran.uwd200 THEN DO:
  nv_check = "ERROR".
  RETURN.
END.
----Wantanee 28/09/2006------*/ 

CREATE sic_bran.uwd200.
ASSIGN
  sic_bran.uwd200.policy  = nv_policy     /*Policy No. - sic_bran.uwm200*/
  sic_bran.uwd200.rencnt  = nv_rencnt     /*Renewal Count  - sic_bran.uwm200*/
  sic_bran.uwd200.endcnt  = nv_endcnt     /*Endorsement Count - sic_bran.uwm200*/
  sic_bran.uwd200.c_enct  = 0             /*Cession Endt. Count - sic_bran.uwm200*/
  sic_bran.uwd200.csftq   = nv_csftq      /*Co/Stat/Fac/Tty/Qs - sic_bran.uwm200*/
  sic_bran.uwd200.rico    = nv_rico       /*RI Company/Treaty - sic_bran.uwm200*/
  sic_bran.uwd200.riskgp  = 0             /*Risk Group*/
  sic_bran.uwd200.riskno  = 1             /*Risk No.*/
  sic_bran.uwd200.risiae  = nv_risiae     /*RI SI A/E*/
  sic_bran.uwd200.risi    = nv_risi       /*RI SI*/
  sic_bran.uwd200.risiid  = 0             /*RI SI Increase/Decrease*/
  sic_bran.uwd200.risi_p  = nv_risi_p     /*RI SI %*/
  sic_bran.uwd200.ripsae  = nv_ripsae     /*RI Premium A/E*/
  sic_bran.uwd200.ripr    = nv_ripr       /*RI Premium*/
  sic_bran.uwd200.ric1ae  = YES           /*RI Commission 1 A/E*/
  sic_bran.uwd200.ric2ae  = YES           /*RI Commission 2 A/E*/
  sic_bran.uwd200.ric1    = nv_ric1       /*RI Commission 1*/
  sic_bran.uwd200.ric2    = nv_ric2       /*RI Commission 2*/ /*Add A64-0380*/
  /*sic_bran.uwd200.ric2    = 0           /*RI Commission 2*/ Comment A64-0380*/
  sic_bran.uwd200.fptr    = 0             /*Forward Pointer*/
  sic_bran.uwd200.bptr    = 0             /*Backward pointer*/
  sic_bran.uwd200.sicurr  = "BHT".        /*Sum Insured Currency*/
  

ASSIGN
  sic_bran.uwd200.bchyr = nv_batchyr    /* batch Year */
  sic_bran.uwd200.bchno = nv_batchno    /* batchno    */
  sic_bran.uwd200.bchcnt = nv_batcnt.    /* batcnt     */

ASSIGN
  sic_bran.uwm200.fptr01  = RECID(sic_bran.uwd200)   /*First sic_bran.uwd200 RI Out Premium*/
  sic_bran.uwm200.bptr01  = RECID(sic_bran.uwd200).  /*Last sic_bran.uwd200 RI Out Premium*/

HIDE MESSAGE NO-PAUSE.
/* END OF FILE : TMGEN200.P */
