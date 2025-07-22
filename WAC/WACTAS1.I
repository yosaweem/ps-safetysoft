/* modify  by  Kanchana C. :  18/06/2002 */
/* wac\wactas1.i                      หา  Compulsory  Policy No. */

/*
DEF BUFFER Buwm_v72 FOR uwm100.
DEF BUFFER Buwm301  FOR uwm301.
DEF BUFFER Buwm130  FOR uwm130.

DEF WORKFILE vehreg72 NO-UNDO
        FIELD polsta  AS CHAR FORMAT "X(02)"       /* Policy Status / IF,RE,CA */
        FIELD vehreg  AS CHAR FORMAT "X(10)"       /* Vehicle Registration No. */
        FIELD comdat  AS DATE FORMAT "99/99/9999"
        FIELD expdat  AS DATE FORMAT "99/99/9999"  /* Expiry Date */
        FIELD enddat  AS DATE FORMAT "99/99/9999"  /* Endorsement Date */
        FIELD del_veh AS CHAR FORMAT "X"           /* Delete Item / 0," "=No, 1=Yes*/
        FIELD policy  AS CHAR FORMAT "X(12)"
        FIELD rencnt  AS INTE FORMAT "999"
        FIELD endcnt  AS INTE FORMAT "999"
        FIELD riskgp  AS INTE FORMAT "999"
        FIELD riskno  AS INTE FORMAT "999"
        FIELD itemno  AS INTE FORMAT "999"
        FIELD sticker LIKE uwm301.sckno.
*/

/*---------------------------------------*/

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

ASSIGN
   n_pol = ''
   n_ren = 0
   n_end = 0.

IF uwm130.uom8_v <> 0 AND uwm130.uom9_v <> 0 THEN DO:
/*p*/  nv_pol72 = ''.
/*p    nv_pol72 = uwm130.policy. */
/*p*/  nv_pol72 = uwm130.policy + '(' + uwm100.trty11 + uwm100.docno1 + ')'.
END.
ELSE DO:
    /* Compulsory แยก */
/*     IF uwm100.opnpol = "" THEN DO: */    /*A49-0014*/
    IF uwm100.cr_2 = "" THEN DO:

        FOR EACH Buwm301 USE-INDEX uwm30102 WHERE
                 Buwm301.vehreg = uwm301.vehreg NO-LOCK:
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
                                vehreg72.riskno  = Buwm301.riskno
                                vehreg72.itemno  = Buwm301.itemno.

                            IF Buwm301.sckno <> 0 THEN
                                vehreg72.sticker = Buwm301.sckno.
                        END.
                        ELSE DO:
                            IF vehreg72.expdat > Buwm_v72.expdat AND
                               vehreg72.policy = Buwm_v72.policy AND
                               vehreg72.endcnt < Buwm_v72.endcnt THEN DO:
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
                                    vehreg72.riskno  = Buwm301.riskno
                                    vehreg72.itemno  = Buwm301.itemno.

                                IF Buwm301.sckno <> 0 THEN
                                    vehreg72.sticker = Buwm301.sckno.
                            END.
                        END. /* else IF vehreg72.expdat <= Buwm_v72.expdat */
                    END.  /* not avail vehreg72  */
                END.  /*IF Buwm_v72.expdat >= uwm100.comdat */

                n_pol = vehreg72.policy.
                n_ren = vehreg72.rencnt.
                n_end = vehreg72.endcnt.

            END. /* IF SUBSTRING(Buwm301.policy,3,2) = "72" */
        END. /* for eachBuwm301*/

        /*2*/
        FIND FIRST Buwm_v72 USE-INDEX uwm10001 WHERE
                   Buwm_v72.policy = n_pol AND
                   Buwm_v72.rencnt = n_ren AND
                   Buwm_v72.endcnt = n_end
        NO-LOCK NO-ERROR NO-WAIT.
        IF AVAILABLE Buwm_v72 THEN
            nv_pol72 = Buwm_v72.policy.

    END. /*IF uwm100.opnpol = "" */
    ELSE DO:  /* uwm100.opnpol <> "" */

        FIND FIRST Buwm_v72 USE-INDEX uwm10001 WHERE
/*              Buwm_v72.policy = uwm100.opnpol */  /*A49-0002*/
             Buwm_v72.policy = uwm100.cr_2
        NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL Buwm_v72 THEN
            nv_pol72  = Buwm_v72.policy.
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
                                    vehreg72.riskno  = Buwm301.riskno
                                    vehreg72.itemno  = Buwm301.itemno.
               
                                    IF Buwm301.sckno <> 0 THEN
                                        vehreg72.sticker = Buwm301.sckno.
                            END.
                            ELSE DO:
                                IF vehreg72.expdat > Buwm_v72.expdat AND
                                   vehreg72.policy = Buwm_v72.policy AND
                                   vehreg72.endcnt < Buwm_v72.endcnt THEN DO:
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

	        /*2*/
            FIND FIRST Buwm_v72 WHERE
                       Buwm_v72.policy = vehreg72.policy AND
                       Buwm_v72.rencnt = vehreg72.rencnt AND
                       Buwm_v72.endcnt = vehreg72.endcnt
            NO-LOCK NO-ERROR NO-WAIT.
            IF AVAILABLE Buwm_v72 THEN DO:
                nv_pol72  = Buwm_v72.policy.
            END.  /* IF AVAILABLE Buwm_v72 */

        END.
    END. /* uwm100.opnpol <> "" */
END.  /* not (uwm130.uom8_v <> 0 AND uwm130.uom9_v <> 0) */
/*--------------------------------------*/


