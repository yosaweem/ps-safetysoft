/************************************************************************/
/* WUWPCFW1.I   Program Forward Calculate Motor Premium                 */
/* Copyright Tokio Marine Safety Insurance (Thailand) PCL.              */
/* Create By : Porntiwa T. 20/06/2023 A65-0149                          */
/************************************************************************/

ASSIGN
    nv_prvprm   = nv_baseprm
    nv_prem1    = nv_baseprm
    nv_prvprm3  = nv_baseprm3
    nv_prem3    = nv_baseprm3
    nv_prem2    = nv_baseprm. /*ผู้ขับขี่*/

/* Vehicle Use 1 */
nv_prem1  = nv_prem1 * ( nv_rate[1] / 100 ).
nv_prem2  = nv_prem2 * ( nv_rate[1] / 100 ). /*ผู้ขับขี่*/
nv_useprm = nv_prem1 - nv_prvprm.
nv_prvprm = nv_prem1.

/* Engines Size */
IF nv_rate[2] <> 0 THEN DO:
    nv_prem1  = nv_prem1 * ( nv_rate[2] / 100 ).
    nv_prem2  = nv_prem2 * ( nv_rate[2] / 100 ). /*ผู้ขับขี่*/
    nv_engprm = nv_prem1 - nv_prvprm.
    nv_prvprm = nv_prem1.
END.

/*--*/
/* Driver Name */
IF nv_rate[3] <> 0 THEN DO:
    nv_prem1    = nv_prem1 * ( nv_rate[3] / 100 ).
    nv_drivprm  = nv_prem1 - nv_prvprm.
    nv_prvprm   = nv_prem1.
END.
/*--*/

/* Vehicle's Age */
IF nv_rate[4] <> 0 THEN DO:
    nv_prem1  = nv_prem1 * ( nv_rate[4] / 100 ).
    nv_prem2  = nv_prem2 * ( nv_rate[4] / 100 ). /*ผู้ขับขี่*/
    nv_yrprm  = nv_prem1 - nv_prvprm.
    nv_prvprm = nv_prem1.
END.

/* Sum Insured 1 */
IF nv_rate[5] <> 0 THEN DO:
    nv_prem1  = nv_prem1 * ( nv_rate[5] / 100 ).
    nv_prem2  = nv_prem2 * ( nv_rate[5] / 100 ). /*ผู้ขับขี่*/
    nv_siprm  = nv_prem1 - nv_prvprm.
    nv_prvprm = nv_prem1.
END.

/* Vehicle Group */
IF nv_rate[6] <> 0 THEN DO:
    nv_prem1  = nv_prem1 * ( nv_rate[6] / 100 ).
    nv_prem2  = nv_prem2 * ( nv_rate[6] / 100 ). /*ผู้ขับขี่*/
    nv_grprm  = nv_prem1 - nv_prvprm.
    nv_prvprm = nv_prem1.
END.

/* Accessory */
IF nv_rate[7] <> 0 THEN DO:
    nv_prem1  = nv_prem1 * (nv_rate[7] / 100).
    nv_prem2  = nv_prem2 * (nv_rate[7] / 100). /*ผู้ขับขี่*/
    nv_othprm = nv_prem1 - nv_prvprm.
    nv_prvprm = nv_prem1.
END.

/* TPBI/PER */
IF nv_rate[8] <> 0 THEN DO:
    nv_prem1  = nv_prem1 * nv_rate[8].
    nv_prem2  = nv_prem2 * nv_rate[8]. /*ผู้ขับขี่*/
    nv_bipprm = nv_prem1 - nv_prvprm.
    nv_prvprm = nv_prem1.
END.

/* TPBI/ACC */
IF nv_rate[9] <> 0 THEN DO:
    nv_prem1  = nv_prem1 * nv_rate[9].
    nv_prem2  = nv_prem2 * nv_rate[9]. /*ผู้ขับขี่*/
    nv_biaprm = nv_prem1 - nv_prvprm.
    nv_prvprm = nv_prem1.
END.

/* TPPD/PER */
IF nv_rate[10] <> 0 THEN DO:
    nv_prem1  = nv_prem1 * nv_rate[10].
    nv_prem2  = nv_prem2 * nv_rate[10]. /*ผู้ขับขี่*/
    nv_pdaprm = nv_prem1 - nv_prvprm.
    nv_prvprm = nv_prem1.
END.

nv_prem1   = ROUND(nv_prem1,0).

/* SUPER CAR */
IF nv_rate[11] <> 0 THEN DO:
    nv_supeprm = nv_prem1 * nv_rate[11].
    nv_supe00  = nv_prem1 - nv_supeprm.
END.

/*--
/* TOTAL LOSS คิดแยก */
IF nv_rate[11] <> 0 THEN DO:
    nv_totlprm = nv_sumins * nv_rate[11].
END.
--*/

IF nv_covcod = "2.1" OR nv_covcod = "2.2" OR
   nv_covcod = "3.1" OR nv_covcod = "3.2" THEN DO:
    ASSIGN
        nv_prem3   = nv_baseprm3
        nv_prvprm3 = nv_prem3.

    /* Vehicle Use 3 */
    IF nv_rate[13] <> 0 THEN DO:
        nv_prem3   = nv_prem3 * (nv_rate[13] / 100).
        nv_useprm3 = nv_prem3 - nv_prvprm3.
        nv_prvprm3 = nv_prem3.
    END.

    /* Engine 3 */
    IF nv_rate[14] <> 0 THEN DO:
        nv_prem3   = nv_prem3 * (nv_rate[14] / 100).
        nv_engprm3 = nv_prem3 - nv_prvprm3.
        nv_prvprm3 = nv_prem3.
    END.

    /* SI 3 */
    IF nv_rate[15] <> 0 THEN DO:
        nv_prem3   = nv_prem3 * (nv_rate[15] / 100).
        nv_siprm3  = nv_prem3 - nv_prvprm3.
        nv_prvprm3 = nv_prem3.
    END.
END.
ELSE DO:
    ASSIGN
        nv_baseprm3 = 0
        nv_prem3    = nv_baseprm3
        nv_prvprm3  = nv_prem3.
END.

nv_prem1   = ROUND(nv_prem1,0). /* คำนวนรวมส่วนลด Driver Named */
nv_prem2   = ROUND(nv_prem2,0). /* คำนวนแบบไม่รวมส่วนลด Driver Named */    
nv_prem3   = ROUND(nv_prem3,0).

nv_fletprm = - TRUNCATE((nv_prem1 + nv_addprem + nv_tdeduct + nv_supeprm) * (nv_fletp / 100),0).
nv_ncbprm  = - TRUNCATE((nv_prem1 + nv_addprem + nv_tdeduct + nv_supeprm + nv_fletprm) * (nv_ncbp / 100),0).
nv_dspcprm = - TRUNCATE((nv_prem1 + nv_addprem + nv_tdeduct + nv_supeprm + nv_fletprm + nv_ncbprm) * (nv_dspcp / 100),0).

nv_lodclm1 = (nv_prem1 + nv_addprem + nv_tdeduct + nv_supeprm + nv_fletprm + nv_ncbprm + nv_dspcprm) * (nv_clmp / 100).
nv_lodclm2 = TRUNCATE((nv_prem1 + nv_addprem + nv_tdeduct + nv_supeprm + nv_fletprm + nv_ncbprm + nv_dspcprm) * (nv_clmp / 100),0).
nv_clmprm  = IF (nv_lodclm1 - nv_lodclm2) > 0 THEN nv_lodclm2 + 1 ELSE nv_lodclm1.

nv_dstfprm = - TRUNCATE((nv_prem1 + nv_addprem + nv_tdeduct + nv_supeprm + nv_fletprm + nv_ncbprm + nv_dspcprm + nv_clmprm + nv_prem3) * (nv_dstfp / 100),0).

nv_totdis  = nv_tdeduct + nv_fletprm + nv_ncbprm + nv_dspcprm + nv_dstfprm.
nv_prem1   = nv_prem1 + nv_totlprm + nv_supeprm.
nv_gapprm  = ROUND((nv_prem1 + nv_prem3 + nv_addprem + nv_totdis + nv_clmprm),0).
/*nv_pdprm   = ROUND((nv_gapprm * nv_polday) / 365,0).*/
IF nv_flgsht = "Y" THEN DO:
    nv_pdprm = ROUND(nv_gapprm * (nv_short / 100),0).
END.
ELSE nv_pdprm   = ROUND((nv_gapprm * nv_polday) / 365,0).

/*-- Unnamed Premium --*/
nv_prem2   = nv_prem2 + nv_totlprm + nv_supeprm.
nv_pdprm0  = nv_prem2 - nv_prem1.  /* UnNamed Premium - Named Premium ใช้เบี้ยที่ยังไม่หักส่วนลด */

/*--
OUTPUT TO "D:\NewTariffEV\TestF\Forwardcal.csv" APPEND.
PUT "nv_prem1   : " nv_prem1    "|".
PUT "nv_gapprm  : " nv_gapprm   "|".
PUT "nv_netprem : " nv_netprem  "|".
PUT "nv_baseprm3: " nv_baseprm3 "|".
PUT "nv_useprm3 : " nv_useprm3  "|".
PUT "nv_engprm3 : " nv_engprm3  "|".
PUT "nv_siprm3  : " nv_siprm3   "|".
PUT "nv_prem3   : " nv_prem3    "|".
PUT "nv_dstfprm : " nv_dstfprm  "|".
PUT "nv_totlprm : " nv_totlprm  "|".
PUT "nv_clmprm  : " nv_clmprm   "|".
PUT "nv_dspcprm : " nv_dspcprm  "|".
PUT "nv_ncbprm  : " nv_ncbprm   "|".
PUT "nv_fletprm : " nv_fletprm  "|".
PUT "nv_addprem : " nv_addprem  "|".
PUT "nv_tdeduct : " nv_tdeduct  "|".
PUT "nv_pdaprm  : " nv_pdaprm   "|".
PUT "nv_biaprm  : " nv_biaprm   "|".
PUT "nv_bipprm  : " nv_bipprm   "|".
PUT "nv_othprm  : " nv_othprm   "|".
PUT "nv_grprm   : " nv_grprm    "|".
PUT "nv_siprm   : " nv_siprm    "|".
PUT "nv_yrprm   : " nv_yrprm    "|".
PUT "nv_drivprm : " nv_drivprm  "|".
PUT "nv_engprm  : " nv_engprm   "|".
PUT "nv_useprm  : " nv_useprm   "|".
PUT "nv_baseprm : " nv_baseprm  SKIP.
OUTPUT CLOSE.
--*/


