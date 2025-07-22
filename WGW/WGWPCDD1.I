/************************************************************************/
/* WUWPCAL1.P   Program Calculate Deduct Premium                        */
/* Copyright Tokio Marine Safety Insurance (Thailand) PCL.              */
/* Create By : Porntiwa T. 20/06/2023 A65-0149                          */
/************************************************************************/
/*Deduct OD*/

nv_key_b = 0.

IF nv_dedod <> 0 THEN DO:
    IF nv_supe <> YES THEN DO:
        ASSIGN
            nv_bencod = "DC01"
            nv_tempsi = nv_dedod.

        RUN WGW\WGWMX024.P(INPUT nv_tariff,
                                 nv_bencod,
                                 nv_class,
                                 nv_key_b,
                                 nv_effdat,
                           INPUT-OUTPUT nv_tempsi,
                           OUTPUT nv_chk,
                           OUTPUT nv_baseap,
                           OUTPUT nv_message).

        IF NOT nv_chk THEN DO:
        END.
    END.
    ELSE DO:
        ASSIGN
            nv_bencod = "DC04"
            nv_tempsi = nv_dedod.

        RUN WGW\WGWMX027.P(INPUT nv_tariff,
                                 nv_bencod,
                                 nv_class,
                                 nv_tempsi,
                                 nv_tempsi,
                                 nv_effdat,
                           INPUT-OUTPUT nv_tempsi,
                           OUTPUT nv_message).
    END.

    ASSIGN
        nv_dedod1prm = (nv_tempsi).
END.
ELSE DO:
    nv_dedod1prm = 0.
END.

IF nv_covcod = "2.1" OR nv_covcod = "2.2" OR 
   nv_covcod = "3.1" OR nv_covcod = "3.2" THEN nv_dedod1prm = 0.

/*Add Deduct OD*/
IF nv_addod <> 0 THEN DO:
    IF nv_supe <> YES THEN DO:
        ASSIGN
            nv_cons   = "AD"
            nv_tempsi = nv_addod
            nv_prem   = 0.

        RUN WGW\WGWMX025.P (INPUT nv_tempsi,
                                  nv_tariff,
                                  nv_class,
                                  nv_key_b,
                                  nv_effdat,
                                  nv_cons,
                           OUTPUT nv_prem,
                           OUTPUT nv_message).

        nv_dedod2prm = (nv_prem).
    END.
    ELSE DO:
        ASSIGN
            nv_addod     = 0
            nv_dedod2prm = 0.
    END.
END.
ELSE DO:
    nv_dedod2prm = 0.
END.

/*Deduct PD*/
IF nv_dedpd <> 0 THEN DO:
    ASSIGN
        nv_cons   = "PD"
        nv_tempsi = nv_dedpd
        nv_prem   = 0.

    RUN WGW\WGWMX025.P (INPUT nv_tempsi,
                              nv_tariff,
                              nv_class,
                              nv_key_b,
                              nv_effdat,
                              nv_cons,
                       OUTPUT nv_prem,
                       OUTPUT nv_message).

    nv_dedpdprm = (nv_prem).
END.
ELSE DO:
    nv_dedpdprm = 0.
END.

/*-- Check Deduct ตาม File --*/
IF nv_dodamt <> 0 AND nv_dedod <> 0 THEN DO:
    IF nv_dedod1prm <> nv_dodamt THEN DO:
        nv_dedod1prm = nv_dodamt.
        nv_message = "PREMIUM DIFF [DEDUCT OD1]: " + STRING(nv_dedod1prm) + " <> " + STRING(nv_dodamt).
    END.
END.
IF nv_dadamt <> 0 AND nv_addod <> 0 THEN DO:
    IF nv_dedod2prm <> nv_dadamt THEN DO:
        nv_dedod2prm = nv_dadamt.
        nv_message = "PREMIUM DIFF [DEDUCT OD2]: " + STRING(nv_dedod2prm) + " <> " + STRING(nv_dadamt).
    END.
END.

IF nv_dpdamt <> 0 AND nv_dedpd <> 0 THEN DO:
    IF nv_dedpdprm <> nv_dpdamt THEN DO:
        nv_dedpdprm = nv_dpdamt.
        nv_message = "PREMIUM DIFF [DEDUCT PD]: " + STRING(nv_dedpdprm) + " <> " + STRING(nv_dpdamt).
    END.
END.

nv_tdeduct = nv_dedod1prm + nv_dedod2prm + nv_dedpdprm.

