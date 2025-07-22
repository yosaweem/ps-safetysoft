/* program   :  WACOSCM.P  Outstanding claim paid for profit center report (Detail) */
/* create by :  B.Phattranit  on 20/05/05  */
/*------------------------------------------------------------------
 Modify By : TANTAWAN C.   10/01/2008   [A500178]
             ปรับ FORMAT branch เพื่อรองรับการขยายสาขา
--------------------------------------------------------------------*/
/********************************************************/

DEFINE     INPUT parameter nvw_stdate  AS  DATE FORMAT 99/99/9999.
DEFINE     INPUT parameter nvw_endate  AS  DATE FORMAT 99/99/9999.
DEFINE     INPUT parameter nv_out      AS  CHAR FORMAT "X(25)".
DEFINE     INPUT parameter nv_poltyp   AS  INT  FORMAT "9"  .

/*--- A500178 ---
DEFINE VAR nvw_intref  AS  CHAR FORMAT "X(07)".
------*/
DEFINE VAR nvw_intref  AS  CHAR FORMAT "X(10)".
DEFINE VAR nvw_begin   AS  CHAR FORMAT "X(01)"        INIT "Y".
DEFINE VAR nvw_oldtyp  AS  CHAR FORMAT "X(04)"        INIT "".
DEFINE VAR nvw_chk_br  AS  CHAR FORMAT "X(01)"        INIT "".
DEFINE VAR nvw_nbran   AS  CHAR FORMAT "X(20)"        INIT "".
DEFINE VAR nvw_ntype   AS  CHAR FORMAT "X(35)"        INIT "".
DEFINE VAR nvw_insure  AS  CHAR FORMAT "X(22)".

DEFINE VAR nvw_adjust  AS  CHAR FORMAT "X(45)". /* A450171 (22) */

DEFINE VAR nvw_policy  AS  CHAR FORMAT "X(09)".
DEFINE VAR nvw_res     AS  INTE FORMAT ">>>,>>>,>>9-" INIT 0.
DEFINE VAR nvw_netl_d  AS  INTE FORMAT ">>>,>>>,>>9-" INIT 0.

DEFINE VAR nvw_gross   AS  INTE FORMAT ">>>,>>>,>>9-" INIT 0.
DEFINE VAR nvw_facri   AS  INTE FORMAT ">>>,>>>,>>9-" INIT 0.
DEFINE VAR nvw_1st     AS  INTE FORMAT ">>>,>>>,>>9-" INIT 0.
DEFINE VAR nvw_2nd     AS  INTE FORMAT ">>>,>>>,>>9-" INIT 0.
DEFINE VAR nvw_qs5     AS  INTE FORMAT ">>>,>>>,>>9-" INIT 0.
DEFINE VAR nvw_tfp     AS  INTE FORMAT ">>>,>>>,>>9-" INIT 0.
DEFINE VAR nvw_eng     AS  INTE FORMAT ">>>,>>>,>>9-" INIT 0.
DEFINE VAR nvw_mar     AS  INTE FORMAT ">>>,>>>,>>9-" INIT 0.
DEFINE VAR nvw_xol     AS  INTE FORMAT ">>>,>>>,>>9-" INIT 0.
DEFINE VAR nvw_rq      AS  INTE FORMAT ">>>,>>>,>>9-" INIT 0.

DEFINE VAR nvw_mps     AS  INTE FORMAT ">>>,>>>,>>9-" INIT 0.
DEFINE VAR nvw_btr     AS  INTE FORMAT ">>>,>>>,>>9-" INIT 0.
DEFINE VAR nvw_otr     AS  INTE FORMAT ">>>,>>>,>>9-" INIT 0.

DEFINE VAR nvw_fo1     AS  INTE FORMAT ">>>,>>>,>>9-" INIT 0.
DEFINE VAR nvw_fo2     AS  INTE FORMAT ">>>,>>>,>>9-" INIT 0.
DEFINE VAR nvw_fo3     AS  INTE FORMAT ">>>,>>>,>>9-" INIT 0.

DEFINE VAR nvw_fo4     AS  INTE FORMAT ">>>,>>>,>>9-" INIT 0.
DEFINE VAR nvw_ftr     AS  INTE FORMAT ">>>,>>>,>>9-" INIT 0.
DEFINE VAR nvw_net     AS  INTE FORMAT ">>>,>>>,>>9-" INIT 0.

DEFINE VAR n_claim2    AS  CHAR FORMAT "X(16)".

DEFINE VAR nv_coper  AS DECI FORMAT ">>9.99".
DEFINE VAR nv_sico   AS DECI FORMAT ">,>>>,>>>,>>>,>>9.99".
DEFINE VAR nv_sigr   AS DECI FORMAT ">,>>>,>>>,>>>,>>9.99".

DEFINE VAR nv_write1  AS CHAR .
/*--- A500178 ---
DEFINE VAR nv_acno1   AS CHAR FORMAT "X(07)".
-------*/
DEFINE VAR nv_acno1   AS CHAR FORMAT "X(10)".
DEFINE VAR nv_prodnam AS CHAR FORMAT "X(50)".
DEFINE VAR nvw_produc AS CHAR FORMAT "X(45)".
DEFINE VAR nv_adjusna AS CHAR FORMAT "X(50)".
DEFINE VAR nv_wextref AS CHAR FORMAT "X(45)".
DEFINE VAR nv_extnam  AS CHAR FORMAT "X(50)".
DEFINE VAR nvw_exter  AS CHAR FORMAT "X(45)".
DEFINE VAR nvw_losdat  AS DATE FORMAT "99/99/99".
DEFINE VAR nvw_notdat  AS DATE FORMAT "99/99/99".
DEFINE VAR nvw_group   AS CHAR FORMAT "X(4)".
DEFINE VAR nv_pacod    AS CHAR FORMAT "X(02)".
DEFINE VAR nv_pades    AS CHAR FORMAT "X(20)".

DEFINE VAR nv_write  AS CHAR INIT "".
DEFINE VAR nv_write2 AS CHAR INIT "".
DEFINE VAR nv_cedclm AS CHAR FORMAT "X(16)".
DEFINE VAR nv_row    AS INT  INIT 0.

DEFINE STREAM ns2. /* For Summary Page Text Output --> Excel */
/*--- A500178 ---*/
DEFINE VAR nv_brn    LIKE uwm100.branch.
DEFINE VAR nv_dirclm AS CHAR .
DEFINE VAR nv_dirpol AS CHAR.
/*--- A500178 ---*/

DEFINE WORKFILE W016
    FIELD wfpoltyp AS CHAR FORMAT "X(2)"
    FIELD wfDI     AS CHAR FORMAT "X"
    FIELD wfpoldes AS CHAR FORMAT "X(35)"
    FIELD wfgross  AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wf1st    AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wf2nd    AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wffacri  AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfqs5    AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wftfp    AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfeng    AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfmar    AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfrq     AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wffo1    AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wffo2    AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfret    AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfxol    AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfmps    AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfbtr    AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfotr    AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wffo3    AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wffo4    AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfftr    AS DECI FORMAT "->>,>>>,>>>,>>9.99" .

DEFINE VAR nv_loss AS CHAR FORMAT "X(23)".
DEFINE WORKFILE wclm120
    FIELD wclaim   AS CHAR FORMAT "X(12)"
    FIELD wloss    AS CHAR FORMAT "X(30)".


FORM SKIP(1)
  "    Claim No.....: " n_claim2 SKIP(1)
WITH COLOR YEL/BLUE FRAME nf2 NO-LABEL CENTERED ROW 15.

OUTPUT STREAM ns2 TO VALUE(nv_out).

PUT  STREAM  ns2  "ID;PND"  SKIP.
nv_row = nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"' "Branch"        '"'   SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"' "Policy type"   '"'   SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"' "Policy desc."  '"'   SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"' "Group type"    '"'   SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"' "Inward/Direct" '"'   SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"' "Claim"         '"'   SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"' "Entry date"    '"'   SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"' "Notify date"   '"'   SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"' "Loss date"     '"'   SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"' "Open date"     '"'   SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"' "Policy"        '"'   SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"' "Insured name"  '"'   SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"' "Nature"        '"'   SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"' "Gross"         '"'   SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"' "1st Treaty"    '"'   SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"' "2nd Treaty"    '"'   SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"' "Fac. RI"       '"'   SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"' "Q.S. 5%"       '"'   SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"   '"' "TFP"          '"'   SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"   '"' "MPS"          '"'   SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"   '"' "Eng.Fac."     '"'   SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"   '"' "Marine O/P"   '"'   SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"   '"' "R.Q."         '"'   SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"   '"' "BTR"          '"'   SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"   '"' "OTR"          '"'   SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"   '"' "FTR"          '"'   SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"   '"' "F/O I"        '"'   SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"' "F/O II"        '"'   SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"' "F/O III"       '"'   SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"' "F/O IV"        '"'   SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"' "Gross RET"     '"'   SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"' "XOL"           '"'   SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"' "Co %  "        '"'   SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"' "Co SI "        '"'   SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K"  '"' "Adjustor"      '"'   SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K"  '"' "Int.Surveyor Name " '"'   SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K"  '"' "Ext.Surveyor Name " '"'   SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K"  '"' "Producer Name"      '"'   SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K"  '"' "Cending Claim no."  '"'   SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K"  '"' "Text code claim"    '"'   SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K"  '"' "Claim comment"      '"'   SKIP.

DO TRANSACTION :
   FOR EACH Szr016: DELETE Szr016. END.
   FOR EACH W016: DELETE W016. END.
END.

Loop_clm100:
FOR EACH Clm102 USE-INDEX Clm10202   WHERE
         Clm102.entdat >= nvw_stdate AND
         Clm102.entdat <= nvw_endate
NO-LOCK:

    FIND FIRST Clm100 USE-INDEX Clm10001 WHERE
               Clm100.claim = Clm102.claim
    NO-LOCK NO-ERROR.
    IF AVAIL clm100 THEN DO:
    /*---jeab
    IF  SUBSTR(clm100.claim,1,1)  <> "D"  AND
        SUBSTR(clm100.claim,1,1)  <> "I"  THEN NEXT loop_clm100.
    ---*/    
   /*-- nv_poltyp  = 1  motor
                     2  non-motor NOT 30 & 01
                     3  30 & 01
   ---*/                  
        

        IF nv_poltyp = 2 THEN DO: /* non-motor all not 30,01 */
           IF (Clm100.poltyp = "V70"  OR   /* Check Policy Type */
              Clm100.poltyp  = "V72"  OR
              Clm100.poltyp  = "V73"  OR  /* CMIP  */
              Clm100.poltyp  = "V74"  OR  /* CMIP  */
              Clm100.poltyp  = "M30"  OR  /* CMIP  */
              Clm100.poltyp  = "M01"  OR  /* CMIP  */
              Clm100.poltyp  = "   ") THEN NEXT loop_clm100.
        END.
        ELSE IF nv_poltyp = 3 THEN DO:  /* 30,01 */
           IF (Clm100.poltyp <>  "M01"  AND
              Clm100.poltyp  <>  "M30") THEN NEXT loop_clm100.
        END.
        ELSE DO:
           IF (Clm100.poltyp <> "V70"  and  /* Check Policy Type */
              Clm100.poltyp  <> "V72"  and
              Clm100.poltyp  <> "V73"  and  /* CMIP  */
              Clm100.poltyp  <> "V74" )  /* CMIP  */  THEN NEXT loop_clm100.
        END.
        
        IF Clm100.padsts <> " "    AND      /* Check paid status is close or open */
           Clm100.padsts <> "O"    AND
           Clm100.padsts <> "P"    THEN NEXT loop_clm100.
        
        nvw_res    = 0.
        nvw_netl_d = 0.
        nvw_gross  = 0.
        nv_pacod   = "".
        nv_pades   = "" .
        n_claim2   = clm100.claim.
        
         DISP "Process policy : " clm100.claim WITH COLOR BLACK/WHITE NO-LABEL  
        TITLE "PROCESS..." WIDTH 50 FRAME BMain VIEW-AS DIALOG-BOX.
        
        Loop_clm120:
        FOR EACH Clm120  USE-INDEX  Clm12001     WHERE
                 Clm120.claim  = Clm100.claim    NO-LOCK
        BREAK BY Clm120.claim
              BY Clm120.clmant
              BY Clm120.clitem:
        
           IF FIRST-OF(Clm120.clmant) THEN DO:
             IF Clm120.loss <> 'FE' AND Clm120.loss <> 'EX' THEN DO:
               FIND FIRST Wclm120 WHERE
                          Wclm120.wclaim  = Clm120.claim  NO-ERROR.
               IF NOT AVAILABLE Wclm120 THEN DO:
                 CREATE Wclm120.
                 ASSIGN Wclm120.wclaim  = Clm120.claim
                        Wclm120.wloss   = "".
               END.
               IF Wclm120.wloss = "" THEN DO:
                 IF Clm120.loss <> "" THEN
                   Wclm120.wloss = CAPS(Clm120.loss).
               END.
               ELSE DO:
                 IF Clm120.loss <> "" THEN
                   Wclm120.wloss = TRIM(Wclm120.wloss) + "," + CAPS(Clm120.loss).
               END.
             END.
           END.
        
          /*-- Nature of loss (FE : free , EX : fire) --*/
          IF (Clm120.loss <> 'FE' AND Clm120.loss <> 'EX')
          THEN DO:
            IF (Clm120.styp20 <> 'X' AND    /* X : Claim Without Paid */
                Clm120.styp20 <> 'F' AND    /* F : Final (complet paid) */
                Clm120.styp20 <> 'R')       /* R : Re-open */
            THEN DO:
        
                IF LAST-OF (Clm120.clitem) THEN DO:
        
                    FOR EACH Clm131 USE-INDEX Clm13101    WHERE
                        Clm131.claim  = Clm100.claim      AND
                        Clm131.clmant = Clm120.clmant     AND
                        Clm131.clitem = Clm120.clitem     AND
                        Clm131.cpc_cd = "EPD"             AND
                        Clm131.trndat >= nvw_stdate       AND
                        Clm131.trndat <= nvw_endate
                    NO-LOCK:
                    
                        IF Clm131.res <> ? THEN DO:
                           nvw_res     = nvw_res + Clm131.res.
                           nvw_intref  = Clm120.intref.
                        END.
                        
                        nvw_netl_d = 0.
                        
                        LOOP_130:
                        FOR EACH Clm130 USE-INDEX Clm13002     WHERE
                                 Clm130.claim   = Clm100.claim  AND
                                 Clm130.clmant  = Clm120.clmant AND
                                 Clm130.clitem  = Clm120.clitem AND
                                 Clm130.cpc_cd  = 'EPD'         AND
                                 Clm130.trnty1  = "X"           AND
                                 Clm130.netl_d  <> ?            AND
                                 Clm130.entdat  >= nvw_stdate   AND
                                 Clm130.entdat  <= nvw_endate
                        NO-LOCK,
                        
                             FIRST Clm200 USE-INDEX Clm20001       WHERE
                                   Clm200.trnty1 = Clm130.trnty1   AND
                                   Clm200.docno  = Clm130.docno
                             NO-LOCK.
                             IF AVAIL Clm200 THEN
                                IF Clm200.releas <>  YES   THEN  NEXT loop_130.
                             
                             IF Clm130.netl_d <> ? THEN DO:
                                nvw_netl_d = nvw_netl_d + clm130.netl_d.
                             END.
                        
                        END.   /* FOR EACH clm130 */
                    END.  /* for each clm131 */
                END.  /* last-of clm120 */
            END.  /* <> "X"  */
          END.  /* <> "FE  */
         
        
        END.  /* for each clm120 */
        
        nvw_gross = (nvw_res - nvw_netl_d).
        
        IF nvw_gross < 0 THEN NEXT loop_clm100.   /* Paid more then Reserve */
        
        
        IF SUBSTRING (Clm100.claim,1,1) = "I" THEN nvw_intref = Clm100.agent.
        
        /*--- A500178 ---*/
        /*--- Branch 1 หลัก ---*/
        IF SUBSTRING(clm100.policy,1,1) = "D" OR  /*-- check ที่ policy เนื่องจาก claim มีทั้ง D, I , F, N ฯลฯ --*/
           SUBSTRING(clm100.policy,1,1) = "I" THEN
            ASSIGN
              nv_brn    = CAPS(SUBSTRING(clm100.policy,2,1))  /*0*/
              nv_dirpol = CAPS(SUBSTRING(clm100.policy,1,1))  /*D,I */
              nv_dirclm = CAPS(SUBSTRING(clm100.claim,1,1))   /*D,I,F,N */
            .

        ELSE /*--- Branch 2 หลัก ---*/
            ASSIGN
              nv_brn    = SUBSTRING(clm100.policy,1,2)  /*10*/
              nv_dirpol = "D"
              nv_dirclm = "D" 
              .
        /*--- A500178 ---*/


        FIND FIRST Szr016 USE-INDEX Szr01602      WHERE
                   Szr016.claim = Clm100.claim
        NO-ERROR.
        IF NOT AVAIL Szr016 THEN DO:
           CREATE Szr016.
           /*--- A500178 ---
           ASSIGN Szr016.poltyp = Clm100.poltyp
                  Szr016.branch = SUBSTR (Clm100.policy,2,1)
            ------*/
            ASSIGN 
                Szr016.poltyp = Clm100.poltyp + "|" + nv_dirclm    /* V70|D , V70|I */
                Szr016.branch = CAPS(nv_brn)                       /* 0 , 10 */
           /*--- A500178 ---*/

                Szr016.claim  = Clm100.claim
                Szr016.policy = Clm100.policy
                Szr016.losdat = Clm100.losdat
                Szr016.intref = nvw_intref
                Szr016.name   = TRIM (Clm100.ntitle) + TRIM (Clm100.name1)
                Szr016.gross  = nvw_gross.

        END. /* szr016 */
    END. /* end if avail clm100 */
END.  /* end for each clm102 */
/*Loop_clm100:*/


HIDE FRAME nf2 NO-PAUSE.  /* A45-0330 */

LOOP_szr016:
FOR EACH Szr016   NO-LOCK   /*  WHERE
         Szr016.gross <> 0  -- A45-0366 --*/

BREAK BY Szr016.branch
      BY SUBSTR (Szr016.poltyp,2,2)
      /*--- A500178 ---
      BY SUBSTR (Szr016.claim,1,1)
      ------*/
      BY SUBSTRING(szr016.poltyp,5,1)  /* V70|D */
     /*--- A500178 ---*/
      BY Szr016.claim :

    ASSIGN
      nvw_facri  = 0 nvw_1st    = 0 nvw_2nd    = 0 nvw_qs5    = 0
      nvw_tfp    = 0 nvw_eng    = 0 nvw_mar    = 0 nvw_xol    = 0
      nvw_rq     = 0
      nvw_fo1    = 0 nvw_fo2    = 0 nvw_fo3    = 0  nvw_fo4   = 0
      nvw_ftr    = 0  
      nvw_mps    = 0 nvw_btr    = 0 nvw_otr    = 0
      nvw_net    = 0 .

    FIND FIRST s0m005 USE-INDEX s0m00501    WHERE
               /*s0m005.key2 = szr016.poltyp --- A500178 ---*/
               s0m005.key2 = substring(szr016.poltyp,1,3)  /* V70|D */
    NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL s0m005 THEN nvw_group = s0m005.key1.

    /*----------- Add Field CO% and CO_SI ------------*/
    ASSIGN
      nv_coper   = 0
      nv_sico    = 0
      nv_sigr    = 0
      nv_acno1   = "".

    nv_cedclm = "".

    FIND FIRST clm100 USE-INDEX clm10001 WHERE
               clm100.claim = szr016.claim
    NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL clm100 THEN DO:

      FIND LAST uwm100 USE-INDEX uwm10001    WHERE
                uwm100.policy = clm100.policy
      NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL uwm100 THEN DO:

        IF uwm100.coins = Yes THEN DO:
          nv_coper = 100 - uwm100.co_per.

          FOR EACH uwm120 USE-INDEX uwm12001    WHERE
                   uwm120.policy = uwm100.policy  AND
                   uwm120.rencnt = uwm100.rencnt  AND
                   uwm120.endcnt = uwm100.endcnt
          NO-LOCK:
            nv_sico = nv_sico + uwm120.sico.
            nv_sigr = nv_sigr + uwm120.sigr.
          END.

          nv_sico = nv_sigr - nv_sico.

        END.
      END.

      nv_acno1   = clm100.acno1 .       /* A45-0330 */
      nvw_notdat = Clm100.notdat.       /* A46-0024 */
      nv_cedclm  = clm100.cedclm.
    END.

    ASSIGN  nv_prodnam  = ""
            nvw_produc  = ""
            nv_extnam   = ""
            nvw_exter   = ""
            nv_wextref  = "".

    FIND FIRST xtm600 USE-INDEX xtm60001 WHERE
               xtm600.acno = nv_acno1
    NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL xtm600 THEN DO:
      nv_prodnam = TRIM(TRIM(xtm600.ntitle) + " " + TRIM(xtm600.name)).

      nvw_produc = TRIM(TRIM(xtm600.ntitle) + " " + TRIM(xtm600.name)).
               /*    + " (" + TRIM(nv_acno1) + ")") .   -- A46-0024 */
    END.
    ELSE DO:
      FIND FIRST xmm600 USE-INDEX xmm60001 WHERE
                 xmm600.acno = nv_acno1
      NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN DO:
        nv_prodnam = TRIM(TRIM(xmm600.ntitle) + " " + TRIM(xmm600.name)).

        nvw_produc = TRIM(TRIM(xmm600.ntitle) + " " + TRIM(xmm600.name)).
               /*      + " (" + TRIM(nv_acno1) + ")") .   -- A46-0024 */
      END.
      ELSE DO:
         nv_prodnam  = "".
         nvw_produc  = "".
      END.
    END.

    FIND FIRST clm120 USE-INDEX clm12001    WHERE
               clm120.claim = szr016.claim
    NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL clm120 THEN DO:

      nv_wextref = clm120.extref.

      FIND FIRST xtm600 USE-INDEX xtm60001 WHERE
                 xtm600.acno = nv_wextref
      NO-LOCK NO-ERROR.
      IF AVAIL xtm600 THEN DO:
        nv_extnam  = TRIM(TRIM(xtm600.ntitle) + " " + TRIM(xtm600.name)).

        nvw_exter  = TRIM(TRIM(xtm600.ntitle) + " " + TRIM(xtm600.name)).
                 /*    + " (" + TRIM(xtm600.acno) + ")") . -- A46-0024 */
      END.
      ELSE DO:
        FIND FIRST xmm600 USE-INDEX xmm60001 WHERE
                   xmm600.acno = nv_wextref
        NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL xmm600 THEN DO:
          nv_extnam  = TRIM(TRIM(xmm600.ntitle) + " " + TRIM(xmm600.name)).

          nvw_exter  = TRIM(TRIM(xmm600.ntitle) + " " + TRIM(xmm600.name)).
                 /*      + " (" + TRIM(xmm600.acno) + ")") .  -- A46-0024 */
        END.
        ELSE DO:
             nv_extnam  = "".
             nvw_exter  = "".
        END.
      END.
    END.

    nv_loss = "".
    FIND FIRST Wclm120 WHERE
               Wclm120.wclaim = Szr016.claim
    NO-LOCK NO-ERROR.
    IF NOT AVAIL Wclm120 THEN nv_loss = "".
                         ELSE nv_loss = TRIM(Wclm120.wloss).
  

    FOR EACH Clm300 USE-INDEX Clm30001  WHERE
             Clm300.claim = Szr016.claim
    NO-LOCK:
             
        IF Clm300.csftq = "F" THEN
           nvw_facri = nvw_facri + (Clm300.risi_p * Szr016.gross) / 100.

        IF SUBSTRING (Clm300.rico,1,2) = "0T" AND
           SUBSTRING (Clm300.rico,6,2) = "01" THEN
           nvw_1st = (Clm300.risi_p * Szr016.gross) / 100.
        ELSE
          IF SUBSTRING (Clm300.rico,1,2) = "0T" AND 
             SUBSTRING (Clm300.rico,6,2) = "02" AND
             /*--- A500178 ---
             NOT (Szr016.poltyp = "M80"  OR Szr016.poltyp = "M81" OR
                  Szr016.poltyp = "M82"  OR Szr016.poltyp = "M83" OR
                  Szr016.poltyp = "M84"  OR Szr016.poltyp = "M85" OR
                  Szr016.poltyp = "C90") THEN
             ------*/
             NOT (SUBSTRING(Szr016.poltyp,1,3) = "M80"  OR SUBSTRING(Szr016.poltyp,1,3) = "M81" OR
                  SUBSTRING(Szr016.poltyp,1,3) = "M82"  OR SUBSTRING(Szr016.poltyp,1,3) = "M83" OR
                  SUBSTRING(Szr016.poltyp,1,3) = "M84"  OR SUBSTRING(Szr016.poltyp,1,3) = "M85" OR
                  SUBSTRING(Szr016.poltyp,1,3) = "C90") THEN
             /*--- A500178 ---*/
             nvw_2nd = (Clm300.risi_p * Szr016.gross) / 100.
        ELSE
          IF SUBSTRING (Clm300.rico,1,4) = "STAT"
             THEN nvw_qs5 = (Clm300.risi_p * Szr016.gross) / 100.
        ELSE

          IF SUBSTRING (Clm300.rico,1,3)  = "0QA"              
             THEN nvw_tfp = (Clm300.risi_p * Szr016.gross) / 100.
        ELSE
          IF SUBSTRING (Clm300.rico,1,2) = "0T" AND
             SUBSTRING (Clm300.rico,6,2) = "02" AND
             /*--- A500178 ---
             (Szr016.poltyp = "M80" OR Szr016.poltyp = "M81"  OR
              Szr016.poltyp = "M82" OR Szr016.poltyp = "M83"  OR
              Szr016.poltyp = "M84" OR Szr016.poltyp = "M85") THEN
              ------*/
             (SUBSTRING(Szr016.poltyp,1,3) = "M80" OR SUBSTRING(Szr016.poltyp,1,3) = "M81"  OR
              SUBSTRING(Szr016.poltyp,1,3) = "M82" OR SUBSTRING(Szr016.poltyp,1,3) = "M83"  OR
              SUBSTRING(Szr016.poltyp,1,3) = "M84" OR SUBSTRING(Szr016.poltyp,1,3) = "M85") THEN
              /*--- A500178 ---*/
             nvw_eng = (Clm300.risi_p * Szr016.gross) / 100.
        ELSE
          IF SUBSTRING (Clm300.rico,1,2) = "0T" AND 
             SUBSTRING (Clm300.rico,6,2) = "02" AND
             /*--- A500178 ---
             Szr016.poltyp = "C90"  THEN
             ------*/
             SUBSTRING(Szr016.poltyp,1,3) = "C90"  THEN
             nvw_mar = (Clm300.risi_p * Szr016.gross) / 100.
        ELSE
          IF SUBSTRING (Clm300.rico,1,3) = "0RQ"
             THEN nvw_rq  = (Clm300.risi_p * Szr016.gross) / 100.

        ELSE 
          IF SUBSTRING(Clm300.rico,1,2) = "0T" AND
             SUBSTRING(Clm300.rico,6,2) = "F1"
             THEN nvw_fo1 = (Clm300.risi_p * Szr016.gross) / 100.
        ELSE 
          IF SUBSTRING(Clm300.rico,1,2) = "0T" AND
             SUBSTRING(Clm300.rico,6,2) = "F2"
             THEN nvw_fo2 = (Clm300.risi_p * Szr016.gross) / 100.
        ELSE 
          IF SUBSTRING(Clm300.rico,1,2) = "0T" AND
             SUBSTRING(Clm300.rico,6,2) = "F3"

             THEN DO:
                /*--- A500178 ---
                IF LOOKUP (Szr016.poltyp,"M80,M81,M82,M83,M84,M85") <> 0 THEN
                ------*/
                IF LOOKUP (SUBSTRING(Szr016.poltyp,1,3),"M80,M81,M82,M83,M84,M85") <> 0 THEN
                    /*--- บวกเพิ่มเข้าใน Engineer ---*/
                    nvw_eng = nvw_eng + (Clm300.risi_p * Szr016.gross) / 100.
                ELSE
                    /*--- FO3 ไม่รวม Engineer ---*/
                    nvw_fo3 = (Clm300.risi_p * Szr016.gross) / 100.
             END. 
        /* FO4 */
        ELSE 
          IF SUBSTRING(Clm300.rico,1,2) = "0T" AND 
             SUBSTRING(Clm300.rico,6,2) = "F4"
             THEN nvw_fo4 = (Clm300.risi_p * Szr016.gross) / 100.
        /* FTR */     
        ELSE 
          IF SUBSTRING(Clm300.rico,1,2) = "0T" AND
             SUBSTRING(Clm300.rico,6,2) = "FT"
             THEN nvw_ftr = (Clm300.risi_p * Szr016.gross) / 100.

        ELSE 
          IF SUBSTRING(clm300.rico,1,3) = "0PS" AND
             SUBSTRING(clm300.rico,6,2) = "01"
             THEN nvw_mps = (clm300.risi_p * szr016.gross) / 100.
        ELSE 
          IF SUBSTRING(clm300.rico,1,2) = "0T" AND
             SUBSTRING(clm300.rico,6,2) = "FB"
             THEN nvw_btr = (clm300.risi_p * szr016.gross) / 100.
        ELSE 
          IF SUBSTRING(clm300.rico,1,2) = "0T" AND
             SUBSTRING(clm300.rico,6,2) = "FO"
             THEN nvw_otr = (clm300.risi_p * szr016.gross) / 100.
    END.  /*--- FOR EACH Clm300 ---*/

   FIND Xmm600 USE-INDEX Xmm60001 WHERE
        Xmm600.acno = Szr016.intref
   NO-LOCK NO-ERROR NO-WAIT.
   IF AVAILABLE xmm600 THEN DO:
      nvw_adjust = TRIM(Xmm600.ntitle) + TRIM(Xmm600.name) .
               /*    + " (" + Szr016.intref + ")".  -- 46-0024 */
      nv_adjusna = TRIM(TRIM(Xmm600.ntitle) + TRIM(Xmm600.name)).  /* A45-0330 */
   END.
   ELSE DO:
           nvw_adjust = "".
           nv_adjusna = "".  /* A45-0330 */
   END.

   nvw_net = (Szr016.gross - nvw_facri - nvw_1st
              - nvw_2nd   - nvw_qs5
              - nvw_tfp   - nvw_eng
              - nvw_mar   - nvw_rq
              - nvw_fo1   - nvw_fo2
              - nvw_fo3
                
              - nvw_fo4   - nvw_ftr
                        
              - nvw_mps   - nvw_btr
              - nvw_otr).
              
   IF nvw_net > 5000000 THEN DO:
      nvw_xol = nvw_net - 5000000.
      nvw_net = 5000000.
   END.

   /* nvw_order = nvw_order + 1. */

   /*--- A500178 ---
   ACCUMULATE 
      1 (COUNT BY Szr016.branch BY SUBSTRING (Szr016.poltyp,2,2) 
               BY SUBSTRING (Szr016.claim,1,1))
      Szr016.gross (TOTAL BY Szr016.branch BY SUBSTRING (Szr016.poltyp,2,2) 
                          BY SUBSTRING (Szr016.claim,1,1))
      nvw_facri (TOTAL BY Szr016.branch BY SUBSTRING (Szr016.poltyp,2,2) 
                       BY SUBSTRING (Szr016.claim,1,1))
      nvw_1st   (TOTAL BY Szr016.branch BY SUBSTRING (Szr016.poltyp,2,2) 
                       BY SUBSTRING (Szr016.claim,1,1))
      nvw_2nd   (TOTAL BY Szr016.branch BY SUBSTRING (Szr016.poltyp,2,2) 
                       BY SUBSTRING (Szr016.claim,1,1))
      nvw_qs5   (TOTAL BY Szr016.branch BY SUBSTRING (Szr016.poltyp,2,2) 
                       BY SUBSTRING (Szr016.claim,1,1))
      nvw_tfp   (TOTAL BY Szr016.Branch BY SUBSTRING (Szr016.poltyp,2,2) 
                       BY SUBSTRING (Szr016.claim,1,1))
      nvw_eng   (TOTAL BY Szr016.Branch BY SUBSTRING (Szr016.poltyp,2,2) 
                       BY SUBSTRING (Szr016.claim,1,1))
      nvw_mar   (TOTAL BY Szr016.Branch BY SUBSTRING (Szr016.poltyp,2,2) 
                       BY SUBSTRING (Szr016.claim,1,1))
      nvw_xol   (TOTAL BY Szr016.Branch BY SUBSTRING (Szr016.poltyp,2,2) 
                       BY SUBSTRING (Szr016.claim,1,1))
      nvw_rq    (TOTAL BY Szr016.Branch BY SUBSTRING (Szr016.poltyp,2,2) 
                       BY SUBSTRING (Szr016.claim,1,1))
      nvw_fo1   (TOTAL BY Szr016.Branch BY SUBSTRING (Szr016.poltyp,2,2) 
                       BY SUBSTRING (Szr016.claim,1,1))
      nvw_fo2   (TOTAL BY Szr016.Branch BY SUBSTRING (Szr016.poltyp,2,2) 
                       BY SUBSTRING (Szr016.claim,1,1))
      nvw_fo3   (TOTAL BY Szr016.Branch BY SUBSTRING (Szr016.poltyp,2,2) 
                       BY SUBSTRING (Szr016.claim,1,1))
      nvw_fo4   (TOTAL BY Szr016.Branch BY SUBSTRING (Szr016.poltyp,2,2) 
                       BY SUBSTRING (Szr016.claim,1,1))
      nvw_ftr   (TOTAL BY Szr016.Branch BY SUBSTRING (Szr016.poltyp,2,2) 
                       BY SUBSTRING (Szr016.claim,1,1))
      nvw_mps   (TOTAL BY Szr016.Branch BY SUBSTRING (Szr016.poltyp,2,2) 
                       BY SUBSTRING (Szr016.claim,1,1))
      nvw_btr   (TOTAL BY Szr016.Branch BY SUBSTRING (Szr016.poltyp,2,2) 
                       BY SUBSTRING (Szr016.claim,1,1))
      nvw_otr   (TOTAL BY Szr016.Branch BY SUBSTRING (Szr016.poltyp,2,2) 
                       BY SUBSTRING (Szr016.claim,1,1))
      nvw_net   (TOTAL BY Szr016.Branch BY SUBSTRING (Szr016.poltyp,2,2) 
                       BY SUBSTRING (Szr016.claim,1,1))
      .
      ------*/
    ACCUMULATE 
         1 (COUNT            BY Szr016.branch BY SUBSTRING (Szr016.poltyp,2,2) BY SUBSTRING (Szr016.poltyp,5,1))
         Szr016.gross (TOTAL BY Szr016.branch BY SUBSTRING (Szr016.poltyp,2,2) BY SUBSTRING (Szr016.poltyp,5,1))
         nvw_facri    (TOTAL BY Szr016.branch BY SUBSTRING (Szr016.poltyp,2,2) BY SUBSTRING (Szr016.poltyp,5,1))
         nvw_1st      (TOTAL BY Szr016.branch BY SUBSTRING (Szr016.poltyp,2,2) BY SUBSTRING (Szr016.poltyp,5,1))
         nvw_2nd      (TOTAL BY Szr016.branch BY SUBSTRING (Szr016.poltyp,2,2) BY SUBSTRING (Szr016.poltyp,5,1))
         nvw_qs5      (TOTAL BY Szr016.branch BY SUBSTRING (Szr016.poltyp,2,2) BY SUBSTRING (Szr016.poltyp,5,1))
         nvw_tfp      (TOTAL BY Szr016.Branch BY SUBSTRING (Szr016.poltyp,2,2) BY SUBSTRING (Szr016.poltyp,5,1))
         nvw_eng      (TOTAL BY Szr016.Branch BY SUBSTRING (Szr016.poltyp,2,2) BY SUBSTRING (Szr016.poltyp,5,1))
         nvw_mar      (TOTAL BY Szr016.Branch BY SUBSTRING (Szr016.poltyp,2,2) BY SUBSTRING (Szr016.poltyp,5,1))
         nvw_xol      (TOTAL BY Szr016.Branch BY SUBSTRING (Szr016.poltyp,2,2) BY SUBSTRING (Szr016.poltyp,5,1))
         nvw_rq       (TOTAL BY Szr016.Branch BY SUBSTRING (Szr016.poltyp,2,2) BY SUBSTRING (Szr016.poltyp,5,1))
         nvw_fo1      (TOTAL BY Szr016.Branch BY SUBSTRING (Szr016.poltyp,2,2) BY SUBSTRING (Szr016.poltyp,5,1))
         nvw_fo2      (TOTAL BY Szr016.Branch BY SUBSTRING (Szr016.poltyp,2,2) BY SUBSTRING (Szr016.poltyp,5,1))
         nvw_fo3      (TOTAL BY Szr016.Branch BY SUBSTRING (Szr016.poltyp,2,2) BY SUBSTRING (Szr016.poltyp,5,1))
         nvw_fo4      (TOTAL BY Szr016.Branch BY SUBSTRING (Szr016.poltyp,2,2) BY SUBSTRING (Szr016.poltyp,5,1))
         nvw_ftr      (TOTAL BY Szr016.Branch BY SUBSTRING (Szr016.poltyp,2,2) BY SUBSTRING (Szr016.poltyp,5,1))
         nvw_mps      (TOTAL BY Szr016.Branch BY SUBSTRING (Szr016.poltyp,2,2) BY SUBSTRING (Szr016.poltyp,5,1))
         nvw_btr      (TOTAL BY Szr016.Branch BY SUBSTRING (Szr016.poltyp,2,2) BY SUBSTRING (Szr016.poltyp,5,1))
         nvw_otr      (TOTAL BY Szr016.Branch BY SUBSTRING (Szr016.poltyp,2,2) BY SUBSTRING (Szr016.poltyp,5,1))
         nvw_net      (TOTAL BY Szr016.Branch BY SUBSTRING (Szr016.poltyp,2,2) BY SUBSTRING (Szr016.poltyp,5,1))
         .


   /*------ A500178 -------*/
  
   /***-------------------------------------------------------------------***/
   IF FIRST-OF (SUBSTRING (Szr016.poltyp,2,2)) THEN DO:
      /*--- a500178 ---
      FIND Xmm031 USE-INDEX Xmm03101 WHERE Xmm031.poltyp = Szr016.poltyp  
           NO-LOCK NO-ERROR.
      nvw_ntype = IF AVAILABLE Xmm031 THEN Xmm031.poldes
                  ELSE "!!! Not found (" + TRIM (Szr016.poltyp) + ")".
      ------*/
      FIND Xmm031 USE-INDEX Xmm03101 WHERE Xmm031.poltyp = SUBSTRING(Szr016.poltyp,1,3)  
           NO-LOCK NO-ERROR.
      nvw_ntype = IF AVAILABLE Xmm031 THEN Xmm031.poldes
                  ELSE "!!! Not found (" + TRIM (SUBSTRING(Szr016.poltyp,1,3)) + ")".
      /*--- A500178 ---*/

    END. /*--- FIRST-OF (SUBSTRING(Szr016.poltyp,2,2)) ---*/

   /*--- A500178 ---
   IF FIRST-OF (SUBSTRING (Szr016.claim,1,1)) THEN DO:
      FIND FIRST W016 WHERE W016.wfpoltyp = SUBSTR (Szr016.poltyp,2,2)
                      AND   W016.wfDI     = SUBSTR (Szr016.claim,1,1)
           NO-LOCK NO-ERROR.
      IF NOT AVAIL W016 THEN DO:
         CREATE W016.
         ASSIGN
           W016.wfpoltyp = SUBSTR (Szr016.poltyp,2,2)
           W016.wfpoldes = nvw_ntype
           W016.wfDI     = SUBSTR (Szr016.claim,1,1).
      END. /* NOT AVAIL */
   
   END. /* FIRST-OF (SUBSTRING (Szr016.claim,1,1)) */
   ------*/
   IF FIRST-OF (SUBSTRING (Szr016.poltyp,5,1)) THEN DO:
      FIND FIRST W016 WHERE W016.wfpoltyp = SUBSTR (Szr016.poltyp,2,2)
                      AND   W016.wfDI     = SUBSTR (Szr016.poltyp,5,1)
           NO-LOCK NO-ERROR.
      IF NOT AVAIL W016 THEN DO:
         CREATE W016.
         ASSIGN
           W016.wfpoltyp = SUBSTR (Szr016.poltyp,2,2)
           W016.wfpoldes = nvw_ntype
           W016.wfDI     = SUBSTR (Szr016.poltyp,5,1).
      END. /* NOT AVAIL */
   
   END. /* FIRST-OF (SUBSTRING (Szr016.poltyp,5,1)) */
   /*--- A500178 ---*/

   IF FIRST-OF (Szr016.branch) THEN DO:
      FIND Xmm023 USE-INDEX Xmm02301 WHERE Xmm023.branch = Szr016.branch
           NO-LOCK NO-ERROR.
      nvw_nbran = IF AVAILABLE Xmm023 THEN Xmm023.bdes
                  ELSE "". 
   END.  /* FIRST-OF (Szr016.branch) */

   IF FIRST (Szr016.branch) THEN DO:

   END.  /* IF FIRST (Szr016.branch) */
   
   /***-------------------------------------------------------------------***/

   nvw_policy = Szr016.policy.
   /*  claim paid text  */
   IF clm100.busreg <> "" THEN DO:
      FIND FIRST sym100 USE-INDEX sym10001 WHERE
                 sym100.tabcod = "U070"    AND
                 sym100.itmcod = clm100.busreg
      NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL sym100 THEN  DO:
         nv_pacod = sym100.itmcod.
         nv_pades = sym100.itmdes.
      END.
   END.

    /*--------------------*/

      nv_row = nv_row + 1.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"' Szr016.branch '"'   SKIP.
      /*--- A500178 ---                                               
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"' Szr016.poltyp '"'   SKIP.
      ------*/
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"' SUBSTRING(Szr016.poltyp,1,3)  '"'   SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"' nvw_ntype     '"'   SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"' nvw_group     '"'   SKIP.
      /*--- A500178 ---
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"' substr(nvw_policy,1,1)     '"'   SKIP.
      ------*/
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"' nv_dirpol     '"'   SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"' Szr016.claim  '"'   SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"' clm100.entdat '"'   SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"' nvw_notdat    '"'   SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"' Szr016.losdat '"'   SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"' clm100.entdat '"'   SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"' nvw_policy    '"'   SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"' Szr016.name   '"'   SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"' nv_loss       '"'   SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"' Szr016.gross  '"'   SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"' nvw_1st       '"'   SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"' nvw_2nd       '"'   SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"' nvw_facri     '"'   SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"' nvw_qs5       '"'   SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"' nvw_tfp       '"'   SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"' nvw_mps       '"'   SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"   '"' nvw_eng      '"'   SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"   '"' nvw_mar      '"'   SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"   '"' nvw_rq       '"'   SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"   '"' nvw_btr      '"'   SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"   '"' nvw_otr      '"'   SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"   '"' nvw_ftr      '"'   SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"   '"'nvw_fo1       '"'   SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"' nvw_fo2       '"'   SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"' nvw_fo3       '"'   SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"' nvw_fo4       '"'   SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"' nvw_net       '"'   SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"' nvw_xol       '"'   SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"' nv_coper      '"'   SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"' nv_sico       '"'   SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K"  '"' clm100.police '"'   SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K"  '"' nv_adjusna    '"'   SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K"  '"' nv_extnam     '"'   SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K"  '"' nv_prodnam    '"'   SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K"  '"' nv_cedclm     '"'   SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K"  '"' nv_pacod      '"'   SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K"  '"' nv_pades      '"'   SKIP.
    

   /*--- A500178 ---
   /***---  A450171 D.Sansom  --------------------------------------------***/
   IF LAST-OF (SUBSTRING (Szr016.claim,1,1)) THEN DO:  /* I,D */

      /***--- A450171 ----------------------------------------------------***/
      FIND FIRST W016 WHERE W016.wfpoltyp = SUBSTR (Szr016.poltyp,2,2)
                      AND   W016.wfDI     = SUBSTR (Szr016.claim,1,1)
      NO-LOCK NO-ERROR.
      IF AVAIL w016 THEN
      ASSIGN
        wfgross = wfgross + 
                  (ACCUM TOTAL BY SUBSTR (Szr016.claim,1,1) Szr016.gross)
        wf1st   = wf1st   + 
                  (ACCUM TOTAL BY SUBSTR (Szr016.claim,1,1) nvw_1st)
        wf2nd   = wf2nd   + 
                  (ACCUM TOTAL BY SUBSTR (Szr016.claim,1,1) nvw_2nd)
        wffacri = wffacri + 
                  (ACCUM TOTAL BY SUBSTR (Szr016.claim,1,1) nvw_facri)
        wfqs5   = wfqs5    + 
                  (ACCUM TOTAL BY SUBSTR (Szr016.claim,1,1) nvw_qs5)
        wftfp   = wftfp   + 
                  (ACCUM TOTAL BY SUBSTR (Szr016.claim,1,1) nvw_tfp)
        wfeng   = wfeng   + 
                  (ACCUM TOTAL BY SUBSTR (Szr016.claim,1,1) nvw_eng)
        wfmar   = wfmar   + 
                  (ACCUM TOTAL BY SUBSTR (Szr016.claim,1,1) nvw_mar)
        wfrq    = wfrq    + 
                  (ACCUM TOTAL BY SUBSTR (Szr016.claim,1,1) nvw_rq)
        wffo1   = wffo1   + 
                  (ACCUM TOTAL BY SUBSTR (Szr016.claim,1,1) nvw_fo1)
        wffo2   = wffo2   + 
                  (ACCUM TOTAL BY SUBSTR (Szr016.claim,1,1) nvw_fo2)
        wffo3   = wffo3   + 
                  (ACCUM TOTAL BY SUBSTR (Szr016.claim,1,1) nvw_fo3)
        wffo4   = wffo4   + 
                  (ACCUM TOTAL BY SUBSTR (Szr016.claim,1,1) nvw_fo4)
        wfftr   = wfftr   + 
                  (ACCUM TOTAL BY SUBSTR (Szr016.claim,1,1) nvw_ftr)
        wfret   = wfret   + 
                  (ACCUM TOTAL BY SUBSTR (Szr016.claim,1,1) nvw_net)
        wfxol   = wfxol   + 
                  (ACCUM TOTAL BY SUBSTR (Szr016.claim,1,1) nvw_xol)
        wfmps   = wfmps   + 
                  (ACCUM TOTAL BY SUBSTR (Szr016.claim,1,1) nvw_mps)
        wfbtr   = wfbtr   + 
                  (ACCUM TOTAL BY SUBSTR (Szr016.claim,1,1) nvw_btr)
        wfotr   = wfotr   + 
                  (ACCUM TOTAL BY SUBSTR (Szr016.claim,1,1) nvw_otr)
        .
    ------*/

    IF LAST-OF (SUBSTRING (Szr016.poltyp,5,1)) THEN DO:  /* I,D */
      
        FIND FIRST W016 WHERE W016.wfpoltyp = SUBSTR (Szr016.poltyp,2,2)
                        AND   W016.wfDI     = SUBSTR (Szr016.poltyp,5,1)
        NO-LOCK NO-ERROR.
        IF AVAIL w016 THEN
            ASSIGN
              wfgross = wfgross + (ACCUM TOTAL BY SUBSTR (Szr016.poltyp,5,1) Szr016.gross)
              wf1st   = wf1st   + (ACCUM TOTAL BY SUBSTR (Szr016.poltyp,5,1) nvw_1st)
              wf2nd   = wf2nd   + (ACCUM TOTAL BY SUBSTR (Szr016.poltyp,5,1) nvw_2nd)
              wffacri = wffacri + (ACCUM TOTAL BY SUBSTR (Szr016.poltyp,5,1) nvw_facri)
              wfqs5   = wfqs5   + (ACCUM TOTAL BY SUBSTR (Szr016.poltyp,5,1) nvw_qs5)
              wftfp   = wftfp   + (ACCUM TOTAL BY SUBSTR (Szr016.poltyp,5,1) nvw_tfp)
              wfeng   = wfeng   + (ACCUM TOTAL BY SUBSTR (Szr016.poltyp,5,1) nvw_eng)
              wfmar   = wfmar   + (ACCUM TOTAL BY SUBSTR (Szr016.poltyp,5,1) nvw_mar)
              wfrq    = wfrq    + (ACCUM TOTAL BY SUBSTR (Szr016.poltyp,5,1) nvw_rq)
              wffo1   = wffo1   + (ACCUM TOTAL BY SUBSTR (Szr016.poltyp,5,1) nvw_fo1)
              wffo2   = wffo2   + (ACCUM TOTAL BY SUBSTR (Szr016.poltyp,5,1) nvw_fo2)
              wffo3   = wffo3   + (ACCUM TOTAL BY SUBSTR (Szr016.poltyp,5,1) nvw_fo3)
              wffo4   = wffo4   + (ACCUM TOTAL BY SUBSTR (Szr016.poltyp,5,1) nvw_fo4)
              wfftr   = wfftr   + (ACCUM TOTAL BY SUBSTR (Szr016.poltyp,5,1) nvw_ftr)
              wfret   = wfret   + (ACCUM TOTAL BY SUBSTR (Szr016.poltyp,5,1) nvw_net)
              wfxol   = wfxol   + (ACCUM TOTAL BY SUBSTR (Szr016.poltyp,5,1) nvw_xol)
              wfmps   = wfmps   + (ACCUM TOTAL BY SUBSTR (Szr016.poltyp,5,1) nvw_mps)
              wfbtr   = wfbtr   + (ACCUM TOTAL BY SUBSTR (Szr016.poltyp,5,1) nvw_btr)
              wfotr   = wfotr   + (ACCUM TOTAL BY SUBSTR (Szr016.poltyp,5,1) nvw_otr) .

    /*--- A500178 ---*/

        /***----------------------------------------------------------------***/
        IF LAST-OF (SUBSTR (Szr016.poltyp,2,2)) THEN DO:
            /***-------------------------------------------------------------***/
            IF LAST-OF (Szr016.branch) THEN DO:
                /***---------------------------------------------------------***/                 
                IF LAST (Szr016.branch) THEN DO:  
                    ASSIGN
                     nvw_nbran = ""
                     nvw_ntype = "".
                    /***********************************************************/
                    FOR EACH W016 BREAK BY W016.wfDI BY W016.wfpoltyp
                       WITH WIDTH 255 NO-BOX NO-LABEL DOWN FRAME ftl :
                       
                        ACCUMULATE 
                            wfgross (TOTAL BY W016.wfDI)
                            wf1st   (TOTAL BY W016.wfDI)
                            wf2nd   (TOTAL BY W016.wfDI)
                            wffacri (TOTAL BY W016.wfDI)
                            wfqs5   (TOTAL BY W016.wfDI)
                            wftfp   (TOTAL BY W016.wfDI)
                            wfeng   (TOTAL BY W016.wfDI)
                            wfmar   (TOTAL BY W016.wfDI)
                            wfrq    (TOTAL BY W016.wfDI)
                            wffo1   (TOTAL BY W016.wfDI)
                            wffo2   (TOTAL BY W016.wfDI)
                            wffo3   (TOTAL BY W016.wfDI)
                            wffo4   (TOTAL BY W016.wfDI)
                            wfftr   (TOTAL BY W016.wfDI)
                            wfret   (TOTAL BY W016.wfDI)
                            wfxol   (TOTAL BY W016.wfDI)
                            wfmps   (TOTAL BY W016.wfDI)
                            wfbtr   (TOTAL BY W016.wfDI)
                            wfotr   (TOTAL BY W016.wfDI)
                         .
                    
                    END. /***--- FOR EACH W016 ---***/
                    LEAVE. 
                END. /* LAST (Szr016.branch) */
            END.  /*--- LAST-OF (Branch) ---*/
            /***-------------------------------------------------------------***/
        END.  /*--- LAST-OF (poltyp) ---*/
        /***----------------------------------------------------------------***/
   END. /***--- LAST-OF (SUBSTRING (Szr016.poltyp,5,1)) ---***/
   /*************************************************************************/

END.  /***--------------- LOOP_Szr016 ---------------------***/

PUT STREAM  ns2  "E"  SKIP.

OUTPUT STREAM ns2 CLOSE.


/*----- End Of File : WACOSCM.P -------*/
