/************************************************************************/
/* WUWPCBW1.I   Program Backward Calculate Base Premium                 */
/* Copyright Tokio Marine Safety Insurance (Thailand) PCL.              */
/* Create By : Porntiwa T. 20/06/2023  A65-0149                         */
/************************************************************************/

ASSIGN
    nv_prem1   = nv_netprem
    nv_prvprm1 = nv_prem1
    nv_prem3   = 0   
    nv_prvprm3 = 0.
  
IF nv_covcod = "2.1" OR nv_covcod = "2.2" OR
   nv_covcod = "3.1" OR nv_covcod = "3.2" THEN DO:
    nv_prem3   = nv_baseprm3.
    nv_prvprm3 = nv_prem3.

    nv_prem3   = nv_prem3 * (nv_rate[13] / 100).  /* U121,.. */
    nv_useprm3 = nv_prvprm3 - nv_prem3.
    nv_prvprm3 = nv_prem3.

    nv_prem3   = nv_prem3 * (nv_rate[14] / 100).  /* ENPT */
    nv_engprm3 = nv_prvprm3 - nv_prem3.
    nv_prvprm3 = nv_prem3.

    nv_prem3   = nv_prem3 * (nv_rate[15] / 100).  /* SI21,.. */
    nv_siprm3  = nv_prvprm3 - nv_prem3.
    nv_prvprm3 = nv_prem3.

    nv_prem3 = ROUND(nv_prem3,0).
END.
ELSE DO: 
    nv_baseprm3 = 0.
    nv_prem3    = nv_baseprm3.
END.

IF nv_flagprm = "N" THEN DO:  /* Net Premium */

    /* DSTF : Direct Walk in รวม Premium Plus */
    nv_prem1   = ((nv_prem1 * 100) / (100 - nv_dstfp)).
    nv_dstfprm = TRUNCATE(nv_prvprm1 - nv_prem1,0).
    nv_prvprm1 = nv_prem1.

    /* Net Premium - Premium Plus */
    nv_prem1   = nv_prem1 - nv_prem3.
    nv_prvprm1 = nv_prem1.

    /* Total Loss */
    nv_prem1   = nv_prem1 - nv_totlprm.
    nv_prvprm1 = nv_prem1.

    /* Back Slove Calculate */
    nv_lodclm1 = (nv_prem1 * 100) / (100 + nv_clmp).
    nv_lodclm2 = TRUNCATE((nv_prem1 * 100) / (100 + nv_clmp),0).

    nv_prem1 = IF (nv_lodclm1 - nv_lodclm2) > 0 THEN nv_lodclm2 + 1 ELSE nv_lodclm1.

    nv_clmprm  = nv_prvprm1 - nv_prem1.
    nv_prvprm1 = nv_prem1.

    nv_prem1 = TRUNCATE((nv_prem1 * 100) / (100 - nv_dspcp),0).      /* DSPC */
    nv_dspcprm = nv_prvprm1 - nv_prem1.
    nv_prvprm1 = nv_prem1.

    nv_prem1 = TRUNCATE((nv_prem1 * 100) / (100 - nv_ncbp),0).       /* NCB */
    nv_ncbprm  = nv_prvprm1 - nv_prem1.
    nv_prvprm1 = nv_prem1.

    nv_prem1 = TRUNCATE((nv_prem1 * 100) / (100 - nv_fletp),0).      /* FLEET */
    nv_fletprm = nv_prvprm1 - nv_prem1.
    nv_prvprm1 = nv_prem1.

    nv_prem1   = nv_prem1 - nv_supeprm.   /* Super Car Premium */
    nv_prvprm1 = nv_prem1.

    nv_prem1   = nv_prem1 - nv_addprem.   /* 411,412,413,414,42,43 */
    nv_prvprm1 = nv_prem1.

    nv_prem1   = nv_prem1 - nv_tdeduct.   /* DEDUCT */
    nv_prvprm1 = nv_prem1.

    IF nv_rate[10] <> 0 THEN nv_prem1 = nv_prem1 / nv_rate[10].        ELSE nv_prem1 = nv_prem1.  /* PD */
    nv_pdaprm  = ROUND(nv_prvprm1 - nv_prem1,0).
    nv_prvprm1 = nv_prem1.
                                                             
    IF nv_rate[9] <> 0  THEN nv_prem1 = nv_prem1 / nv_rate[9].         ELSE nv_prem1 = nv_prem1.  /* BI2 */
    nv_biaprm  = ROUND(nv_prvprm1 - nv_prem1,0).
    nv_prvprm1 = nv_prem1.
                                                           
    IF nv_rate[8] <> 0  THEN nv_prem1 = nv_prem1 / nv_rate[8].         ELSE nv_prem1 = nv_prem1.  /* BI1 */
    nv_bipprm  = ROUND(nv_prvprm1 - nv_prem1,0).
    nv_prvprm1 = nv_prem1.

    IF nv_rate[7] <> 0  THEN nv_prem1 = nv_prem1 / (nv_rate[7] / 100). ELSE nv_prem1 = nv_prem1.  /* OTH */
    nv_othprm  = ROUND(nv_prvprm1 - nv_prem1,0).
    nv_prvprm1 = nv_prem1.

    IF nv_rate[6] <> 0  THEN nv_prem1 = nv_prem1 / (nv_rate[6] / 100). ELSE nv_prem1 = nv_prem1.  /* GRP */
    nv_grprm   = ROUND(nv_prvprm1 - nv_prem1,0).
    nv_prvprm1 = nv_prem1.

    IF nv_rate[5] <> 0  THEN nv_prem1 = nv_prem1 / (nv_rate[5] / 100). ELSE nv_prem1 = nv_prem1.  /* SI */
    nv_siprm   = ROUND(nv_prvprm1 - nv_prem1,0).
    nv_prvprm1 = nv_prem1.

    IF nv_rate[4] <> 0  THEN nv_prem1 = nv_prem1 / (nv_rate[4] / 100). ELSE nv_prem1 = nv_prem1.  /* AGE */
    nv_yrprm   = ROUND(nv_prvprm1 - nv_prem1,0).
    nv_prvprm1 = nv_prem1.

    IF nv_rate[3] <> 0  THEN nv_prem1 = nv_prem1 / (nv_rate[3] / 100). ELSE nv_prem1 = nv_prem1.  /* DRV */
    nv_drivprm = ROUND(nv_prvprm1 - nv_prem1,0).
    nv_prvprm1 = nv_prem1.

    IF nv_rate[2] <> 0  THEN nv_prem1 = nv_prem1 / (nv_rate[2] / 100). ELSE nv_prem1 = nv_prem1.  /* ENG */
    nv_engprm  = ROUND(nv_prvprm1 - nv_prem1,0).
    nv_prvprm1 = nv_prem1.

    IF nv_rate[1] <> 0  THEN nv_prem1 = nv_prem1 / (nv_rate[1] / 100). ELSE nv_prem1 = nv_prem1.  /* USE */
    nv_useprm  = ROUND(nv_prvprm1 - nv_prem1,0).
    nv_prvprm1 = nv_prem1.

    nv_prem1 =  ROUND(nv_prem1,0).

END.

nv_baseprm = nv_prem1.

/*--
OUTPUT TO "D:\NewTariffEV\Backwardcal.csv" APPEND.
PUT "nv_prem1   : " nv_prem1    "|".
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
