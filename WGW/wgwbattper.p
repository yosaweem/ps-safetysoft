/* program ID : wgwbattper.p            */
/* Decripton : Check percen battery */
/* create by : Ranu I. A67-0029 เช็คเปอร์เซ็นแบตเตอรี่จากพารามิเตอร์ */
/*-------------------------------------------------------------------*/
DEF INPUT PARAMETER nv_battyr AS INTE .
DEF INPUT PARAMETER nv_comdat AS DATE .
DEF INPUT-OUTPUT PARAMETER nv_battper AS CHAR.
DEF INPUT-OUTPUT PARAMETER nv_error AS CHAR.
DEF VAR nv_ckbatyr AS INTE   init 0.

ASSIGN 
    nv_ckbatyr = 0
    nv_ckbatyr = (YEAR(nv_comdat) - nv_battyr) + 1 .

FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601 WHERE 
         xmm106.tariff  = "X"  /*nv_tariff*/  AND
         xmm106.bencod  = "CBAT"     AND
         xmm106.CLASS   = ""         AND
         xmm106.covcod  = ""         AND
         xmm106.KEY_a   = 0          AND
         xmm106.KEY_b  >= nv_ckbatyr AND
         xmm106.effdat <= nv_comdat  NO-LOCK NO-ERROR NO-WAIT.

IF AVAIL xmm106 THEN DO:
    ASSIGN nv_battper = string(xmm106.appinc)
           nv_error   = "".
END.
ELSE DO: 
    ASSIGN nv_battper = "0"
           nv_error   = "Not Found Parameter Battery (%) ".
END.

