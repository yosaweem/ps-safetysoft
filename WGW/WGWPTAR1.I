/************************************************************************/
/* WUWPTAR1.I   Program Check Tariff on sicsyac                         */
/* Copyright Tokio Marine Safety Insurance (Thailand) PCL.              */
/* Create By : Porntiwa T. 20/06/2023  A65-0149                         */
/************************************************************************/

ASSIGN
    nv_rate[1]  = 0     nv_benecd[1]  = ""      /* use */ 
    nv_rate[2]  = 0     nv_benecd[2]  = ""      /*eng : engine */
    nv_rate[3]  = 0     nv_benecd[3]  = ""      /* AXXX : drive age */
    nv_rate[4]  = 0     nv_benecd[4]  = ""      /* YRXX */
    nv_rate[5]  = 0     nv_benecd[5]  = ""      /* SI */
    nv_rate[6]  = 0     nv_benecd[6]  = ""      /* GRPX */
    nv_rate[7]  = 0     nv_benecd[7]  = ""      /* OTH */
    nv_rate[8]  = 0     nv_benecd[8]  = ""      /* BI1 */
    nv_rate[9]  = 0     nv_benecd[9]  = ""      /* BI2 */
    nv_rate[10] = 0     nv_benecd[10] = ""      /* pd */
    nv_rate[11] = 0     nv_benecd[11]  = ""     /* total loss */
    nv_rate[12] = 0     nv_benecd[12]  = ""     /* supe supercar */
    nv_rate[13] = 0     nv_benecd[13]  = ""     /* use plus*/
    nv_rate[14] = 0     nv_benecd[14]  = ""     /* enpt*/
    nv_rate[15] = 0     nv_benecd[15]  = ""     /* SIXX plus*/
    nv_rate[16] = 0     nv_benecd[16]  = ""     
    nv_rate[17] = 0     nv_benecd[17]  = "" 
    nv_rate[18] = 0     nv_benecd[18]  = "" 
    nv_rate[19] = 0     nv_benecd[19]  = "" 
    nv_rate[20] = 0     nv_benecd[20] = "".


/*-- BASE --*/
ASSIGN
    nv_bencod   = "BASE"
    nv_key_b    = 0
    nv_base1min = 0 
    nv_base1max = 0.

RUN PdChkTariff2.

ASSIGN
    nv_base1min = nv_basemin
    nv_base1max = nv_basemax.

/*-- USE --*/
ASSIGN
    nv_bencod    = "USE" + TRIM(nv_vehuse)
    nv_key_b     = 0
    nv_benecd[1] = nv_bencod.

RUN PdChkTariff1.
IF nv_ratep = 0 THEN nv_ratep = 100.
nv_rate[1] = nv_ratep.

/*-- ENGINE --*/
/*-- Comment A67-0029 --
IF SUBSTRING(TRIM(nv_class),2,1) <> "1" AND
   SUBSTRING(TRIM(nv_class),2,1) <> "6" AND
   SUBSTRING(TRIM(nv_class),2,1) <> "7" THEN DO:
    IF SUBSTRING(TRIM(nv_class),2,1) <> "2" THEN DO:
        IF SUBSTRING(TRIM(nv_class),2,1) <> "8" THEN DO:
            nv_bencod = "ENGT".
        END.
        ELSE DO:
                 IF TRIM(SUBSTRING(nv_class,2,3)) = "801" THEN nv_bencod = "ENG".
            ELSE IF TRIM(SUBSTRING(nv_class,2,3)) = "802" THEN nv_bencod = "ENGC".
            ELSE IF TRIM(SUBSTRING(nv_class,2,3)) = "803" OR
                    TRIM(SUBSTRING(nv_class,2,3)) = "804" OR
                    TRIM(SUBSTRING(nv_class,2,3)) = "805" THEN nv_bencod = "ENGT".
        END.
    END.
    ELSE nv_bencod = "ENGS".
END.
ELSE nv_bencod = "ENGC".
-- End Comment A67-0029 --*/

/*-- Add A67-0029 --*/
FIND FIRST sicsyac.xmm016 USE-INDEX xmm01601 WHERE
           sicsyac.xmm016.CLASS = nv_class NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL sicsyac.xmm016 THEN DO:
    nv_engcod = "ENG" + TRIM(sicsyac.xmm016.capuom).
    nv_evflg  = sicsyac.xmm016.evflg.
END.
ELSE DO:
    FIND FIRST stat.clastab_fil USE-INDEX clastab01 WHERE
               stat.clastab_fil.CLASS  = nv_class   AND
               stat.clastab_fil.covcod = nv_covcod  NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL stat.clastab_fil THEN DO:
        nv_engcod = "ENG" + TRIM(stat.clastab_fil.unit).
        nv_evflg  = stat.clastab_fil.evflg.
    END.

    IF nv_engcod = "ENG" THEN nv_engcod = "ENGC". /* กรณีรหัสไม่ใช้ Engine มาคำนวน */
END.

/*--
IF nv_engcod = "ENG" THEN DO:
    FIND FIRST clastab_fil USE-INDEX clastab01 WHERE
               clastab_fil.CLASS  = nv_class   AND
               clastab_fil.covcod = nv_covcod  NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL clastab_fil THEN DO:
        nv_engcod = "ENG" + TRIM(clastab_fil.unit).
        nv_evflg  = clastab_fil.evflg.
    END.

    IF nv_engcod = "ENG" THEN nv_engcod = "ENGC". /* กรณีรหัสไม่ใช้ Engine มาคำนวน */
END.
--*/

nv_bencod = nv_engcod.
/*-- End Add A67-0029 --*/

ASSIGN 
    nv_key_b     = nv_engcst
    nv_benecd[2] = nv_bencod.

RUN PdChkTariff1.

nv_rate[2] = nv_ratep.

/*-- DRIVER NAME --*/
nv_ratep = 0.
nv_key_b = 0.

IF nv_evflg = NO OR nv_sclass = "E12" THEN DO:
    IF nv_drivno <= 1 THEN DO:
        IF nv_drivno < 1 THEN DO:
            ASSIGN
                nv_bencod = "A000"
                nv_key_b  = 0.
        END.
        ELSE IF nv_drivno = 1 THEN DO:
            nv_driage = nv_driage1.
            RUN PdChkAge.
        END.
        /*RUN PdTarDriver.*/
        RUN PdChkTariff3.
    
    END.
    ELSE DO:
        IF nv_drivno = 2 THEN DO:
            nv_driage = nv_driage1.
    
            RUN PdChkAge.
            /*RUN PdTarDriver.*/
            RUN PdChkTariff3.
    
            ASSIGN
                nv_drivcod1 = nv_bencod
                nv_age1rate = nv_ratep.
    
            nv_driage = nv_driage2.
    
            RUN PdChkAge.
            /*RUN PdTarDriver.*/
            RUN PdChkTariff3.
    
            ASSIGN
                nv_drivcod2 = nv_bencod
                nv_age2rate = nv_ratep.
    
            IF nv_age2rate > nv_age1rate THEN nv_bencod = nv_drivcod2.
            ELSE nv_bencod = nv_drivcod1.
    
        END.
    END.
    
    ASSIGN 
        nv_benecd[3] = nv_bencod
        nv_rate[3]   = nv_ratep.
    
    PROCEDURE PdChkAge:
        nv_bencod = "A" + STRING(nv_drivno,"9").
        IF nv_driage <= 50 THEN DO:
            IF nv_driage <= 35 THEN DO:
                IF nv_driage <= 24 THEN DO:
                    nv_bencod = nv_bencod + "24".
                END.
                ELSE nv_bencod = nv_bencod + "35".
            END.
            ELSE nv_bencod = nv_bencod + "50".
        END.
        ELSE nv_bencod = nv_bencod + "99".
    END PROCEDURE.
END.  /* Add A67-0029 */
ELSE DO: /*E11*/
    IF nv_levcod >= 1 AND nv_levcod <= 5 THEN DO:
        nv_bencod = "AL0" + STRING(nv_levcod).
        nv_key_b  = 0.

        RUN PdChkTariff3.

        ASSIGN 
            nv_benecd[3] = nv_bencod
            nv_rate[3]   = nv_ratep.
    END.
    ELSE DO:
        nv_message = "Not Found Level No.".
    END.
END.  /* End Add A67-0029 */

/*-- VEHECLE'S AGE --*/
ASSIGN
    nv_caryr     = (YEAR(nv_effdat) - nv_yrmanu) + 1
    nv_bencod    = IF nv_caryr <= 10 THEN "YR" + STRING(nv_caryr) ELSE "YR99"
    nv_benecd[4] = nv_bencod
    nv_key_b     = 0
    nv_key_a     = 0 .

RUN PdChkTariff3.
nv_rate[4] = nv_ratep.

/*-- SI --*/
ASSIGN
    nv_bencod    = "SI"
    nv_key_b     = nv_sumins
    nv_benecd[5] = nv_bencod.

RUN PdChkTariff1.
nv_rate[5] = nv_ratep.

/*-- VEHGRP --*/
IF SUBSTR(nv_sclass,1,1) = "1" OR
   SUBSTR(nv_sclass,1,2) = "E1" OR  /*Add A67-0029*/
   SUBSTR(nv_sclass,1,3) = "730" THEN DO:
    ASSIGN
        nv_bencod    = "GRP" + nv_vehgrp
        nv_key_b     = 0
        nv_key_a     = 0
        nv_benecd[6] = nv_bencod.
    
    RUN PdChkTariff1.
    
    nv_rate[6] = nv_ratep.
END.
ELSE DO:
    ASSIGN
        nv_bencod    = ""
        nv_key_b     = 0
        nv_key_a     = 0
        nv_benecd[6] = ""
        nv_rate[6]   = 0.
END.

/*-- ACCESSORY --*/
IF nv_access <> "" THEN DO:
    ASSIGN
        nv_bencod    = "OTH"
        nv_benecd[7] = nv_bencod
        nv_key_b     = 0
        nv_key_a     = 0.
    
    RUN PdChkTariff1.
    
    nv_rate[7] = nv_ratep.
END.
ELSE DO:
    nv_rate[7]   = 0.
    nv_benecd[7] = "".
END.

/*-- TPBI/PER --*/
ASSIGN
    nv_bencod    = "BI1"
    nv_benecd[8] = nv_bencod
    nv_key_b     = nv_tpbi1si.

RUN PdChkTariff1.

nv_rate[8] = nv_ratep.

/*-- TPBI/ACC --*/
ASSIGN
    nv_bencod    = "BI2"
    nv_benecd[9] = nv_bencod
    nv_key_b     = nv_tpbi2si.

RUN PdChkTariff1.

nv_rate[9] = nv_ratep.


/*-- TPPD/PER --*/
ASSIGN
    nv_bencod    = "PD"
    nv_benecd[10] = nv_bencod
    nv_key_b     = nv_tppdsi.

RUN PdChkTariff1.

nv_rate[10] = nv_ratep.

/*-- TOTAL LOSS --*/
IF nv_covcod = "5" THEN DO:
    ASSIGN
        nv_bencod     = "TOTL"
        nv_benecd[11] = nv_bencod
        nv_key_b      = 0.

    RUN PdChkTariff1.

    nv_rate[11] = nv_ratep.
    nv_totlprm  = nv_sumins * nv_rate[11].
END.
ELSE DO:
    ASSIGN
        nv_rate[11] = 0
        nv_totlprm  = 0.
END.

/*-- SUPE --*/
IF nv_supe = YES THEN DO:
    ASSIGN
        nv_bencod = "SUPE"
        nv_benecd[12] = nv_bencod
        nv_key_b      = 0.

    RUN PdChkTariff1.

    nv_rate[12] = nv_ratep.
END.

IF nv_covcod = "2.1" OR nv_covcod = "2.2" OR
   nv_covcod = "3.1" OR nv_covcod = "3.2" THEN DO:
    /*-- BASE 3 --*/
    ASSIGN           
        nv_bencod   = "BA" + TRIM(SUBSTR(nv_covcod,1,1)) + TRIM(SUBSTR(nv_covcod,3,1))
        nv_key_b    = 0
        nv_base3min = 0
        nv_base3max = 0.

    RUN PdChkTariff2.

    ASSIGN
        nv_base3min = nv_basemin
        nv_base3max = nv_basemax.

    /*-- USE 3 --*/
    ASSIGN
        nv_bencod     = "U" + TRIM(nv_vehuse) + TRIM(SUBSTR(nv_covcod,1,1)) + TRIM(SUBSTR(nv_covcod,3,1))
        nv_key_b      = 0
        nv_benecd[13] = nv_bencod.

    RUN PdChkTariff1.
    nv_rate[13] = nv_ratep.
    
    /*-- ENG 3 --*/
    IF SUBSTR(nv_class,2,1) = "3" OR
       SUBSTR(nv_class,2,1) = "4" OR
       SUBSTR(nv_class,2,1) = "5" THEN DO:
        ASSIGN
            nv_bencod     = "ENPT"
            nv_benecd[14] = nv_bencod.

        RUN PdChkTariff1.
        nv_rate[14] = nv_ratep.
    END.
    ELSE DO: 
        nv_benecd[14] = "".
        nv_rate[14] = 100.
    END.

    /*-- SI 3 --*/
    ASSIGN
        nv_bencod     = "SI" + TRIM(SUBSTR(nv_covcod,1,1)) + TRIM(SUBSTR(nv_covcod,3,1))
        nv_key_b      = nv_siplus
        nv_benecd[15] = nv_bencod.

    RUN PdChkTariff1.
    nv_rate[15] = nv_ratep.

END.

PROCEDURE PdChkTariff1:
    nv_ratep = 0.

    FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
               sicsyac.xmm106.tariff  = nv_tariff AND
               sicsyac.xmm106.bencod  = nv_bencod AND
               sicsyac.xmm106.CLASS   = nv_class  AND
               sicsyac.xmm106.covcod  = nv_covcod AND
               sicsyac.xmm106.KEY_b  >= nv_key_b  AND
               sicsyac.xmm106.effdat <= nv_effdat NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicsyac.xmm106 THEN DO:
        FIND LAST bxmm106 USE-INDEX xmm10601 WHERE
                  bxmm106.tariff  = nv_tariff AND
                  bxmm106.bencod  = nv_bencod AND
                  bxmm106.CLASS   = nv_class  AND
                  bxmm106.covcod  = nv_covcod AND
                  bxmm106.key_b  >= nv_key_b  AND
                  bxmm106.key_b  <= sicsyac.xmm106.key_b AND
                  bxmm106.effdat <= nv_effdat NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL bxmm106 THEN DO:
            nv_ratep = bxmm106.appinc.
        END.
        ELSE DO:
            nv_message = "NOT FOUND BENEFIT: " + CAPS(nv_bencod) + " CLASS: " + CAPS(nv_class).
        END.
    END.
    ELSE DO:
        nv_message = "NOT FOUND BENEFIT: " + CAPS(nv_bencod) + " CLASS: " + CAPS(nv_class).
    END.

    IF nv_sclass = "801" THEN nv_message = "".

END PROCEDURE.

PROCEDURE PdChkTariff2:
    ASSIGN
        nv_basemin = 0
        nv_basemax = 0
        nv_ratep   = 0.

    FIND LAST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
              sicsyac.xmm106.tariff  = nv_tariff AND
              sicsyac.xmm106.bencod  = nv_bencod AND
              sicsyac.xmm106.CLASS   = nv_class  AND
              sicsyac.xmm106.covcod  = nv_covcod AND
              sicsyac.xmm106.KEY_b  >= nv_key_b  AND
              sicsyac.xmm106.effdat <= nv_effdat NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicsyac.xmm106 THEN DO:
        IF SUBSTRING(nv_bencod,1,2) = "BA" THEN DO:
            ASSIGN
                nv_basemin = sicsyac.xmm106.min_ap
                nv_basemax = sicsyac.xmm106.max_ap.
        END.
        ELSE DO:
            nv_ratep = sicsyac.xmm106.appinc.
        END.
    END.
    ELSE DO:
        nv_message = "NOT FOUND BENEFIT: " + CAPS(nv_bencod) + " CLASS: " + CAPS(nv_class).
    END.

    IF nv_sclass = "801" THEN nv_message = "".

END PROCEDURE.

PROCEDURE PdChkTariff3:
    nv_ratep = 0.
    FIND LAST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
              sicsyac.xmm106.tariff  = nv_tariff AND
              sicsyac.xmm106.bencod  = nv_bencod AND
              sicsyac.xmm106.CLASS   = nv_class  AND
              sicsyac.xmm106.covcod  = nv_covcod AND
              sicsyac.xmm106.KEY_b  >= nv_key_b  AND
              sicsyac.xmm106.effdat <= nv_effdat NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicsyac.xmm106 THEN DO:
        nv_ratep = sicsyac.xmm106.appinc.
    END.
    ELSE DO:
        nv_message = "NOT FOUND BENEFIT: " + CAPS(nv_bencod) + " CLASS: " + CAPS(nv_class).
    END.

    IF nv_sclass = "801" THEN nv_message = "".

END PROCEDURE.

