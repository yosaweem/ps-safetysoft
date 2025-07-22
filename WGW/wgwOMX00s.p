/* wgwomx00s.p      (COPY QUOMX00s.P)        CALAULATE PREMIUM1         */
/* Copyright  # Safety Insurance Public Company Limited */
/*              บริษัท ประกันคุ้มภัย จำกัด (มหาชน)      */
/* Create BY : Ranu I. A61-0313 26/06/2018   เพื่อคำนวณหาส่วนลดกรณีระบุชื่อผู้ขับขี่  */

DEFINE INPUT        PARAMETER nv_tariff AS CHARACTER FORMAT "X"    INITIAL "" NO-UNDO.
DEFINE INPUT        PARAMETER nv_bencod AS CHARACTER FORMAT "X(4)" INITIAL "" NO-UNDO.
DEFINE INPUT        PARAMETER nv_class  AS CHARACTER FORMAT "X(4)" INITIAL "" NO-UNDO.
DEFINE INPUT        PARAMETER nv_covcod AS CHARACTER FORMAT "X(4)" INITIAL "" NO-UNDO.
DEFINE INPUT        PARAMETER nv_key_b  AS DECIMAL   FORMAT ">>>,>>>,>>>,>>9.99-" INITIAL 0 NO-UNDO.
DEFINE INPUT        PARAMETER nv_effdat AS DATE      FORMAT "99/99/9999"      NO-UNDO.
DEFINE INPUT-OUTPUT PARAMETER nv_prem   AS DECIMAL   FORMAT ">>>,>>>,>>9.99-" INITIAL 0 NO-UNDO.
DEFINE INPUT-OUTPUT PARAMETER nv_prem_p AS DECIMAL   FORMAT ">>>,>>>,>>9.99-" INITIAL 0 NO-UNDO.
DEFINE VAR nv_rate AS DECIMAL FORMAT ">>>9.99" INITIAL 0 NO-UNDO.
DEFINE VAR nv_yr   AS INTEGER FORMAT ">9" INITIAL 0 NO-UNDO.

IF SUBSTRING(nv_bencod,1,2) = "YR" THEN DO:
  nv_yr = INTEGER(TRIM(SUBSTRING(nv_bencod,3,2))).
  FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
    sicsyac.xmm106.tariff = nv_tariff AND
    sicsyac.xmm106.bencod >= nv_bencod AND
    INTEGER(TRIM(SUBSTRING(sicsyac.xmm106.bencod,3,2))) >= nv_yr AND
    sicsyac.xmm106.class  = nv_class  AND
    sicsyac.xmm106.covcod = nv_covcod AND
    sicsyac.xmm106.key_b  GE nv_key_b  AND
    sicsyac.xmm106.effdat LE nv_effdat
  NO-LOCK NO-ERROR NO-WAIT.
END.
ELSE
  FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
    sicsyac.xmm106.tariff = nv_tariff AND
    sicsyac.xmm106.bencod = nv_bencod AND
    sicsyac.xmm106.class  = nv_class  AND
    sicsyac.xmm106.covcod = nv_covcod AND
    sicsyac.xmm106.key_b  GE nv_key_b  AND
    sicsyac.xmm106.effdat LE nv_effdat
  NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL sicsyac.xmm106 THEN DO:
  IF nv_bencod = "BI1" OR nv_bencod = "BI2" OR nv_bencod = "PD"
  THEN DO:
    nv_rate = sicsyac.xmm106.appinc.
/*  nv_prem = TRUNCATE((nv_prem *  nv_rate),0). */
    nv_prem  = nv_prem *  nv_rate.
    nv_prem_p = nv_prem_p *  nv_rate.  /*A51-0198*/
  END.
  ELSE DO:
    nv_rate = sicsyac.xmm106.appinc.
/*  nv_prem = TRUNCATE((nv_prem * ( nv_rate / 100 )),0).  */
    nv_prem  = nv_prem * ( nv_rate / 100 ).
    nv_prem_p = nv_prem_p * ( nv_rate / 100 ). /*A51-0198*/
  END.
END.
