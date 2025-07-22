/* Wactlt1.i : หา Compulsory Policy No.         */
/* Link from : Wactlt1.w                        */
/* Create By : Bunthiya C. A49-0015  10/02/2006 */

FIND FIRST uwm120 USE-INDEX uwm12001 WHERE
           uwm120.policy = uwm100.policy AND
           uwm120.rencnt = uwm100.rencnt AND
           uwm120.endcnt = uwm100.endcnt
NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAILABLE uwm120 THEN NEXT.

FIND FIRST uwm301 USE-INDEX uwm30101 WHERE
           uwm301.policy = uwm100.policy AND
           uwm301.rencnt = uwm100.rencnt AND
           uwm301.endcnt = uwm100.endcnt
NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAILABLE uwm301 THEN NEXT.

FIND FIRST uwm130 USE-INDEX uwm13001 WHERE
           uwm130.policy = uwm301.policy AND
           uwm130.rencnt = uwm301.rencnt AND
           uwm130.endcnt = uwm301.endcnt AND
           uwm130.riskgp = uwm301.riskgp AND
           uwm130.riskno = uwm301.riskno AND
           uwm130.itemno = uwm301.itemno
NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAILABLE uwm130 THEN NEXT.

FIND xmm020 USE-INDEX xmm02001 WHERE
     xmm020.branch = uwm100.branch AND
     xmm020.dir_ri = uwm100.dir_ri
NO-LOCK NO-ERROR NO-WAIT.
IF AVAILABLE xmm020 THEN
    ASSIGN
        nv_stamp_per  = xmm020.rvstam
        nv_tax_per    = xmm020.rvtax.

nv_nor_si = uwm130.uom6_v.
/*---- A50-0070 ----
nv_comm_per70 = nv_comm_per70 + uwm120.com1p.   /* Commission (%) of Policy */
-- END A50-0070 --*/

FOR EACH vehreg72:   DELETE  vehreg72.   END.

                                             /* Compulsory + Policy */
IF uwm130.uom8_v <> 0 AND uwm130.uom9_v <> 0 THEN DO:

    ASSIGN
        nv_pol72 = ''
        nv_pol72 = uwm130.policy    /* Policy of Compulsory */

        nv_comdat72 = agtprm_fil.comdat
        nv_expdat72 = uwm100.expdat .

    /* SI of Compulsory */
    IF uwm130.uom8_v = 50000 THEN nv_comp_si = 80000.
                             ELSE nv_comp_si = uwm130.uom8_v.

    /* Premium of Compulsory */
    nv_comp_net = agtprm.prem_comp.
    nv_comp_prm = nv_comp_net.

    /*---- A50-0070 ----
    nv_comm_per72 = nv_comm_per72 + uwm120.com2p.   /* Commission (%) of Compulsory */
    -- END A50-0070 --*/

    /* Stamp of Compulsory */
    nv_stamp72  = TRUNCATE(nv_comp_net * nv_stamp_per / 100,0) +
                      (IF (nv_comp_net * nv_stamp_per / 100) -
                  TRUNCATE(nv_comp_net * nv_stamp_per / 100,0) > 0
                  THEN 1 ELSE 0).

    /* Tax of Compulsory */
    IF uwm100.gstrat <> 0 AND agtprm_fil.tax <> 0 THEN
        nv_vat72 = (nv_comp_net + nv_stamp72) * uwm100.gstrat / 100.

    nv_stamp70 = agtprm_fil.stamp - nv_stamp72.     /* Stamp of Policy (70) */
    nv_vat70   = agtprm_fil.tax   - nv_vat72.       /* Tax of Policy (70) */

    IF nv_stamp70 < 0 THEN nv_stamp70 = 0.
    IF nv_vat70   < 0 THEN nv_vat70   = 0.

END.
ELSE DO:
    /* Compulsory แยก */
/*     IF uwm100.opnpol = "" THEN DO: */    /*A49-0015*/
    IF uwm100.cr_2 = "" THEN DO:    /*A49-0015*/

        FOR EACH Buwm301 USE-INDEX uwm30102 WHERE
                 Buwm301.vehreg = uwm301.vehreg
        NO-LOCK:
                                                    /* DM7245123456*/
            IF SUBSTRING(Buwm301.policy,3,2) = "72" THEN DO:
                                                        /* uwm100 */
                FIND FIRST Buwm_v72 USE-INDEX uwm10001 WHERE
                           Buwm_v72.policy = Buwm301.policy AND
                           Buwm_v72.rencnt = Buwm301.rencnt AND
                           Buwm_v72.endcnt = Buwm301.endcnt
                NO-LOCK NO-ERROR NO-WAIT.
                IF NOT AVAILABLE Buwm_v72 THEN NEXT.

                IF Buwm_v72.expdat >= uwm100.comdat THEN DO:

                    FIND FIRST vehreg72 WHERE
                               vehreg72.vehreg = Buwm301.vehreg
                    NO-ERROR NO-WAIT.
                    IF NOT AVAILABLE vehreg72 THEN DO:
                        CREATE vehreg72.
                        ASSIGN 
                            vehreg72.polsta  = Buwm_v72.polsta  /* IF ,RE ,CA */
                            vehreg72.vehreg  = Buwm301.vehreg   /* Vehicle Registration No. */
                            vehreg72.comdat  = Buwm_v72.comdat  /* Expiry Date */
                            vehreg72.expdat  = Buwm_v72.expdat  /* Expiry Date */
                            vehreg72.enddat  = Buwm_v72.enddat
                            vehreg72.del_veh = IF Buwm301.itmdel = NO THEN "" ELSE "Y"
                            vehreg72.policy  = Buwm301.policy
                            vehreg72.rencnt  = Buwm301.rencnt
                            vehreg72.endcnt  = Buwm301.endcnt
                            vehreg72.riskgp  = Buwm301.riskgp
                            vehreg72.riskno  = Buwm301.riskno
                            vehreg72.itemno  = Buwm301.itemno
                            vehreg72.sticker = Buwm301.sckno.
                    END.
                    ELSE DO:
                        /* ONLY BY 72
                           72comdat = 01/01/2001  72expdat = 01/01/2002
                           72comdat = 01/01/2001  72expdat = 01/01/2002
                        */
                        IF vehreg72.expdat <= Buwm_v72.expdat THEN DO:
                            ASSIGN
                                vehreg72.polsta  = Buwm_v72.polsta  /* IF ,RE ,CA */
                                vehreg72.vehreg  = Buwm301.vehreg   /* Vehicle Registration No. */
                                vehreg72.comdat  = Buwm_v72.comdat  /* Expiry Date */
                                vehreg72.expdat  = Buwm_v72.expdat  /* Expiry Date */
                                vehreg72.enddat  = Buwm_v72.enddat
                                vehreg72.del_veh = IF Buwm301.itmdel = NO THEN "" ELSE "Y"
                                vehreg72.policy  = Buwm301.policy
                                vehreg72.rencnt  = Buwm301.rencnt
                                vehreg72.endcnt  = Buwm301.endcnt
                                vehreg72.riskgp  = Buwm301.riskgp
                                vehreg72.riskno  = Buwm301.riskno
                                vehreg72.itemno  = Buwm301.itemno.

                            IF Buwm301.sckno <> 0 THEN
                                vehreg72.sticker = Buwm301.sckno.
                        END.
                        ELSE DO:
                            IF vehreg72.expdat > Buwm_v72.expdat AND
                               vehreg72.policy = Buwm_v72.policy AND
                               vehreg72.endcnt < Buwm_v72.endcnt
                            THEN DO:
                                ASSIGN
                                    vehreg72.polsta  = Buwm_v72.polsta  /* IF ,RE ,CA */
                                    vehreg72.vehreg  = Buwm301.vehreg  /* Vehicle Registration No. */
                                    vehreg72.comdat  = Buwm_v72.comdat  /* Expiry Date */
                                    vehreg72.expdat  = Buwm_v72.expdat  /* Expiry Date */
                                    vehreg72.enddat  = Buwm_v72.enddat
                                    vehreg72.del_veh = IF Buwm301.itmdel = NO THEN "" ELSE "Y"
                                    vehreg72.policy  = Buwm301.policy
                                    vehreg72.rencnt  = Buwm301.rencnt
                                    vehreg72.endcnt  = Buwm301.endcnt
                                    vehreg72.riskgp  = Buwm301.riskgp
                                    vehreg72.riskno  = Buwm301.riskno
                                    vehreg72.itemno  = Buwm301.itemno.

                                IF Buwm301.sckno <> 0 THEN
                                    vehreg72.sticker = Buwm301.sckno.
                            END.
                        END. /* else IF vehreg72.expdat <= Buwm_v72.expdat */
                    END.  /* not avail vehreg72  */
                END.  /*IF Buwm_v72.expdat >= uwm100.comdat */
            END. /* IF SUBSTRING(Buwm301.policy,3,2) = "72" */
        END. /* for eachBuwm301*/

        FIND FIRST vehreg72 NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL vehreg72 THEN DO:

            /*2*/
            FIND FIRST Buwm_v72 USE-INDEX uwm10001 WHERE
                       Buwm_v72.policy = vehreg72.policy AND
                       Buwm_v72.rencnt = vehreg72.rencnt AND
                       Buwm_v72.endcnt = vehreg72.endcnt
            NO-LOCK NO-ERROR NO-WAIT.
            IF AVAILABLE Buwm_v72 THEN DO:

                ASSIGN
                    nv_pol72    = Buwm_v72.policy   /* Policy (V72) */
                    nv_comdat72 = Buwm_v72.comdat   /* Comdat (V72) */
                    nv_expdat72 = Buwm_v72.expdat   /* Expdat (V72) */
                    nv_comp_net = Buwm_v72.prem_t   /* Premium of V72 */
                    nv_comp_prm = Buwm_v72.prem_t
                    nv_stamp72  = Buwm_v72.rstp_t   /* Stamp of V72 */
                    nv_vat72    = Buwm_v72.rtax_t.  /* Tax of V72 */

                /*---- A49-0015 ----
                IF Buwm_v72.com1_t < 0 THEN     /* Commission of V72 */
                     nv_comp_com = Buwm_v72.com1_t * -1.
                ELSE nv_comp_com = Buwm_v72.com1_t.
                -- End A49-0015 --*/

                /*---- A50-0070 ----
                /* Commission of V72 */
                FIND FIRST uwm120 USE-INDEX uwm12001 WHERE
                           uwm120.policy = Buwm_v72.policy AND
                           uwm120.rencnt = Buwm_v72.rencnt AND
                           uwm120.endcnt = Buwm_v72.endcnt
                NO-LOCK NO-ERROR NO-WAIT.
                IF AVAILABLE uwm120 THEN
                    nv_comm_per72 = nv_comm_per72 + uwm120.com1p.   /* Commission (%) of Compulsory */
                -- END A50-0070 --*/

                FIND FIRST Buwm301 USE-INDEX uwm30101 WHERE
                           Buwm301.policy = Buwm_v72.policy AND
                           Buwm301.rencnt = Buwm_v72.rencnt AND
                           Buwm301.endcnt = Buwm_v72.endcnt
                NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL Buwm301 THEN DO:

                    FIND FIRST Buwm130 USE-INDEX uwm13001 WHERE
                               Buwm130.policy = Buwm301.policy AND
                               Buwm130.rencnt = Buwm301.rencnt AND
                               Buwm130.endcnt = Buwm301.endcnt AND
                               Buwm130.riskgp = Buwm301.riskgp AND
                               Buwm130.riskno = Buwm301.riskno AND
                               Buwm130.itemno = Buwm301.itemno
                    NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAIL Buwm130 THEN DO:
                        IF Buwm130.uom8_v <> 0 AND Buwm130.uom9_v <> 0 THEN DO:
                            IF Buwm130.uom8_v = 50000 THEN nv_comp_si = 80000.
                                                      ELSE nv_comp_si = Buwm130.uom8_v.
                        END.
                    END.
                END.
            END.
        END.
    END. /*IF uwm100.opnpol = "" */
    ELSE DO:  /* uwm100.opnpol <> "" */

        FIND FIRST Buwm_v72 USE-INDEX uwm10001 WHERE
/*              Buwm_v72.policy = uwm100.opnpol */  /*A49-0015*/
                   Buwm_v72.policy = uwm100.cr_2    /*A49-0015*/
        NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL Buwm_v72 THEN DO:
            ASSIGN
                nv_pol72    = Buwm_v72.policy   /* Policy (V72) */
                nv_comdat72 = Buwm_v72.comdat   /* Comdat (V72) */
                nv_expdat72 = Buwm_v72.expdat   /* Expdat (V72) */
                nv_comp_net = Buwm_v72.prem_t   /* Premium (V72) */
                nv_comp_prm = Buwm_v72.prem_t
                nv_stamp72  = Buwm_v72.rstp_t   /* Stamp (V72) */
                nv_vat72    = Buwm_v72.rtax_t.  /* Tax (V72) */

            /*---- A49-0015 ----
            IF Buwm_v72.com1_t < 0 THEN     /* Commission of V72 */
                 nv_comp_com = Buwm_v72.com1_t * -1.
            ELSE nv_comp_com = Buwm_v72.com1_t.
            -- End A49-0015 --*/

            /*---- A50-0070 ----
            /* Commission of V72 */
            FIND FIRST uwm120 USE-INDEX uwm12001 WHERE
                       uwm120.policy = Buwm_v72.policy AND
                       uwm120.rencnt = Buwm_v72.rencnt AND
                       uwm120.endcnt = Buwm_v72.endcnt
            NO-LOCK NO-ERROR NO-WAIT.
            IF AVAILABLE uwm120 THEN
                nv_comm_per72 = nv_comm_per72 + uwm120.com1p.   /* Commission (%) of Compulsory */
            -- END A50-0070 --*/

            FIND FIRST Buwm301 USE-INDEX uwm30101 WHERE
                       Buwm301.policy = Buwm_v72.policy AND
                       Buwm301.rencnt = Buwm_v72.rencnt AND
                       Buwm301.endcnt = Buwm_v72.endcnt
            NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL Buwm301 THEN DO:

                FIND FIRST Buwm130 USE-INDEX uwm13001 WHERE
                           Buwm130.policy = Buwm301.policy AND
                           Buwm130.rencnt = Buwm301.rencnt AND
                           Buwm130.endcnt = Buwm301.endcnt AND
                           Buwm130.riskgp = Buwm301.riskgp AND
                           Buwm130.riskno = Buwm301.riskno AND
                           Buwm130.itemno = Buwm301.itemno
                NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL Buwm130 THEN DO:
                    IF Buwm130.uom8_v <> 0 AND Buwm130.uom9_v <> 0 THEN DO:
                        IF Buwm130.uom8_v = 50000 THEN nv_comp_si = 80000.
                                                  ELSE nv_comp_si = Buwm130.uom8_v.
                    END.
                END.
            END.
        END.
        ELSE DO:
            FOR EACH Buwm301 USE-INDEX uwm30102 WHERE
                     Buwm301.vehreg = uwm301.vehreg
            NO-LOCK:
                                     /* DM7245123456*/
                IF SUBSTRING(Buwm301.policy,3,2) = "72" THEN DO:
                                                               /* uwm100 */
                    FIND FIRST Buwm_v72 USE-INDEX uwm10001 WHERE
                               Buwm_v72.policy = Buwm301.policy AND
                               Buwm_v72.rencnt = Buwm301.rencnt AND
                               Buwm_v72.endcnt = Buwm301.endcnt
                    NO-LOCK NO-ERROR NO-WAIT.
                    IF NOT AVAILABLE Buwm_v72 THEN NEXT.

                    IF Buwm_v72.expdat >= uwm100.comdat THEN DO:

                        FIND FIRST vehreg72 WHERE
                                   vehreg72.vehreg = Buwm301.vehreg
                        NO-ERROR NO-WAIT.
                        IF NOT AVAILABLE vehreg72 THEN DO:
                            CREATE vehreg72.
                            ASSIGN
                                vehreg72.polsta  = Buwm_v72.polsta  /* IF ,RE ,CA */
                                vehreg72.vehreg  = Buwm301.vehreg   /* Vehicle Registration No. */
                                vehreg72.comdat  = Buwm_v72.comdat  /* Expiry Date */
                                vehreg72.expdat  = Buwm_v72.expdat  /* Expiry Date */
                                vehreg72.enddat  = Buwm_v72.enddat
                                vehreg72.del_veh = IF Buwm301.itmdel = NO THEN "" ELSE "Y"
                                vehreg72.policy  = Buwm301.policy
                                vehreg72.rencnt  = Buwm301.rencnt
                                vehreg72.endcnt  = Buwm301.endcnt
                                vehreg72.riskgp  = Buwm301.riskgp
                                vehreg72.riskno  = Buwm301.riskno
                                vehreg72.itemno  = Buwm301.itemno
                                vehreg72.sticker = Buwm301.sckno.
                        END.
                        ELSE DO:
                            /*  ONLY BY 72
                                72comdat = 01/01/2001  72expdat = 01/01/2002
                                72comdat = 01/01/2001  72expdat = 01/01/2002
                            */
                            IF vehreg72.expdat <= Buwm_v72.expdat THEN DO:
                                ASSIGN
                                    vehreg72.polsta  = Buwm_v72.polsta  /* IF ,RE ,CA */
                                    vehreg72.vehreg  = Buwm301.vehreg   /* Vehicle Registration No. */
                                    vehreg72.comdat  = Buwm_v72.comdat  /* Expiry Date */
                                    vehreg72.expdat  = Buwm_v72.expdat  /* Expiry Date */
                                    vehreg72.enddat  = Buwm_v72.enddat
                                    vehreg72.del_veh = IF Buwm301.itmdel = NO THEN "" ELSE "Y"
                                    vehreg72.policy  = Buwm301.policy
                                    vehreg72.rencnt  = Buwm301.rencnt
                                    vehreg72.endcnt  = Buwm301.endcnt
                                    vehreg72.riskgp  = Buwm301.riskgp
                                    vehreg72.riskno  = Buwm301.riskno
                                    vehreg72.itemno  = Buwm301.itemno.

                                IF Buwm301.sckno <> 0 THEN
                                    vehreg72.sticker = Buwm301.sckno.
                            END.
                            ELSE DO:
                                IF vehreg72.expdat > Buwm_v72.expdat AND
                                   vehreg72.policy = Buwm_v72.policy AND
                                   vehreg72.endcnt < Buwm_v72.endcnt
                                THEN DO:
                                    ASSIGN
                                        vehreg72.polsta  = Buwm_v72.polsta  /* IF ,RE ,CA */
                                        vehreg72.vehreg  = Buwm301.vehreg  /* Vehicle Registration No. */
                                        vehreg72.comdat  = Buwm_v72.comdat  /* Expiry Date */
                                        vehreg72.expdat  = Buwm_v72.expdat  /* Expiry Date */
                                        vehreg72.enddat  = Buwm_v72.enddat
                                        vehreg72.del_veh = IF Buwm301.itmdel = NO THEN "" ELSE "Y"
                                        vehreg72.policy  = Buwm301.policy
                                        vehreg72.rencnt  = Buwm301.rencnt
                                        vehreg72.endcnt  = Buwm301.endcnt
                                        vehreg72.riskgp  = Buwm301.riskgp
                                        vehreg72.riskno  = Buwm301.riskno
                                        vehreg72.itemno  = Buwm301.itemno.

                                    IF Buwm301.sckno <> 0 THEN
                                        vehreg72.sticker = Buwm301.sckno.
                                END.
                            END. /* else IF vehreg72.expdat <= Buwm_v72.expdat */
                        END.  /* not avail vehreg72  */
                    END.  /*IF Buwm_v72.expdat >= uwm100.comdat */
                END. /* IF SUBSTRING(Buwm301.policy,3,2) = "72" */
            END. /* for eachBuwm301*/

            FIND FIRST vehreg72 NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL vehreg72 THEN DO:

                /*2*/   
                FIND FIRST Buwm_v72 WHERE
                           Buwm_v72.policy = vehreg72.policy AND
                           Buwm_v72.rencnt = vehreg72.rencnt AND
                           Buwm_v72.endcnt = vehreg72.endcnt
                NO-LOCK NO-ERROR NO-WAIT.
                IF AVAILABLE Buwm_v72 THEN DO:

                    ASSIGN
                        nv_pol72    = Buwm_v72.policy   /* Policy (V72) */
                        nv_comdat72 = Buwm_v72.comdat   /* Comdat (V72) */
                        nv_expdat72 = Buwm_v72.expdat   /* Expdat (V72) */
                        nv_comp_net = Buwm_v72.prem_t   /* Premium (V72) */
                        nv_comp_prm = Buwm_v72.prem_t
                        nv_stamp72  = Buwm_v72.rstp_t   /* Stamp (V72) */
                        nv_vat72    = Buwm_v72.rtax_t.  /* Tax (V72) */

                    /*---- A49-0015 ----
                    IF Buwm_v72.com1_t < 0 THEN
                         nv_comp_com = Buwm_v72.com1_t * -1.
                    ELSE nv_comp_com = Buwm_v72.com1_t.
                    -- End A49-0015 --*/

                    /*---- A50-0070 ----
                    /* Commission of V72 */
                    FIND FIRST uwm120 USE-INDEX uwm12001 WHERE
                               uwm120.policy = Buwm_v72.policy AND
                               uwm120.rencnt = Buwm_v72.rencnt AND
                               uwm120.endcnt = Buwm_v72.endcnt
                    NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAILABLE uwm120 THEN
                        nv_comm_per72 = nv_comm_per72 + uwm120.com1p.   /* Commission (%) of Compulsory */
                    -- END A50-0070 --*/

                    FIND FIRST Buwm301 WHERE
                               Buwm301.policy = Buwm_v72.policy AND
                               Buwm301.rencnt = Buwm_v72.rencnt AND
                               Buwm301.endcnt = Buwm_v72.endcnt
                    NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAILABLE Buwm301 THEN DO:

                        FIND FIRST Buwm130 WHERE
                                   Buwm130.policy = Buwm301.policy AND
                                   Buwm130.rencnt = Buwm301.rencnt AND
                                   Buwm130.endcnt = Buwm301.endcnt AND
                                   Buwm130.riskgp = Buwm301.riskgp AND
                                   Buwm130.riskno = Buwm301.riskno AND
                                   Buwm130.itemno = Buwm301.itemno
                        NO-LOCK NO-ERROR NO-WAIT.
                        IF AVAILABLE Buwm130 THEN DO:
                            IF Buwm130.uom8_v <> 0 AND Buwm130.uom9_v <> 0 THEN DO:
                                IF Buwm130.uom8_v = 50000 THEN nv_comp_si = 80000.
                                                          ELSE nv_comp_si = Buwm130.uom8_v.
                            END.
                        END.
                    END.
                END.  /* IF AVAILABLE Buwm_v72 */
            END.
        END.
    END. /* uwm100.opnpol <> "" */
END.  /* not (uwm130.uom8_v <> 0 AND uwm130.uom9_v <> 0) */
/*--------------------------------------*/
