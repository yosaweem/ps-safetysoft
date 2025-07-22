/************************************************************************/
/* WUWPGPM1.I   Program Generate Premium on Table pmuwd132              */
/* Copyright Tokio Marine Safety Insurance (Thailand) PCL.              */
/* Create By : Porntiwa T. 20/06/2023 A65-0149                          */
/************************************************************************/

ASSIGN
    nv_itemno   = 0
    nv_bencod   = ""
    nv_benvar   = ""
    nv_benvar1  = ""
    nv_benvar2  = ""
    nv_gap      = 0
    nv_prem_c   = 0
    n_uom_c     = ""
    n_uom_v     = 0
    /*nv_gapprm   = 0
    nv_pdprm    = 0*/
    nv_adjpd    = 0
    nv_adjgap   = 0.

IF nv_campcd = "" THEN nv_campcd = nv_policy.

/*-- Clear pmuwd132 ก่อน Assign ค่าใหม่ --*/
FOR EACH stat.pmuwd132 WHERE 
         stat.pmuwd132.campcd = nv_campcd AND
         stat.pmuwd132.policy = nv_policy :
    DELETE stat.pmuwd132.
END.

/* COMPULSORY  Premium */
IF nv_compprm <> 0 THEN DO:
    ASSIGN
        nv_gap    = 0
        nv_prem_c = 0
        n_uom_c   = ""
        n_uom_v   = 0
        nv_gap    = nv_compprm.
        /*nv_gap    = ROUND(nv_compprm,0).*/
    
    IF nv_flgsht = "Y" THEN DO:
        nv_prem_c = TRUNCATE(nv_gap * (nv_short / 100),0).
    END.
    ELSE DO:
        nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).
    END.

    ASSIGN
        nv_bencod  = "COMP"
        nv_benvar  = ""
        nv_benvar1 = "     Compulsory  =   "
        nv_benvar1 = nv_benvar1 + FILL(" ",30 - LENGTH(nv_benvar1))
        nv_benvar2 = STRING(nv_uom9_v)
        nv_benvar  = nv_benvar1 + nv_benvar2.
    
    nv_itemno = nv_itemno + 1.
    RUN PdWkUwd132.
END.

/*-- BASE --*/
ASSIGN
    nv_gap    = 0
    nv_prem_c = 0
    n_uom_c   = ""
    n_uom_v   = 0
    nv_gap    = nv_baseprm.
    /*nv_gap    = ROUND(nv_baseprm,0).*/
   /* nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).*/

IF nv_flgsht = "Y" THEN DO:
    nv_prem_c = TRUNCATE(nv_gap * (nv_short / 100),0).
END.
ELSE DO:
    nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).
END.

ASSIGN
    nv_bencod  = "BASE"
    nv_benvar  = ""
    nv_benvar1 = "     Base Premium = " 
    nv_benvar1 = nv_benvar1 + FILL(" ",30 - LENGTH(nv_benvar1))
    nv_benvar2 = STRING(nv_baseprm)
    nv_benvar  = nv_benvar1 + nv_benvar2.

nv_itemno = nv_itemno + 1.
RUN PdWkUwd132.

/*-- USE --*/
ASSIGN
    nv_gap    = 0
    nv_prem_c = 0
    n_uom_c   = ""
    n_uom_v   = 0
    nv_gap    = nv_useprm.
    /*nv_gap    = ROUND(nv_useprm,0).*/
    /*nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).*/

IF nv_flgsht = "Y" THEN DO:
    nv_prem_c = TRUNCATE(nv_gap * (nv_short / 100),0).
END.
ELSE DO:
    nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).
END.

ASSIGN
    nv_bencod  = "USE" + TRIM(nv_vehuse)
    nv_benvar  = ""
    nv_benvar1 = "     Vehicle Use = " 
    nv_benvar1 = nv_benvar1 + FILL(" ",30 - LENGTH(nv_benvar1))
    nv_benvar2 = nv_vehuse
    nv_benvar  = nv_benvar1 + nv_benvar2.

nv_itemno = nv_itemno + 1.
RUN PdWkUwd132.

/*-- ENGINE --*/
ASSIGN
    nv_gap    = 0
    nv_prem_c = 0
    n_uom_c   = ""
    n_uom_v   = 0
    nv_gap    = nv_engprm.
    /*nv_gap    = ROUND(nv_engprm,0).*/
    /*nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).*/

IF nv_flgsht = "Y" THEN DO:
    nv_prem_c = TRUNCATE(nv_gap * (nv_short / 100),0).
END.
ELSE DO:
    nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).
END.

IF nv_benecd[2] = "ENGC" THEN DO:
    ASSIGN
        nv_bencod  = nv_benecd[2]
        nv_benvar  = ""
        nv_benvar1 = IF nv_cstflg = "C" THEN "     Vehicle CC. = " ELSE "     Vehicle KW. = "
        nv_benvar1 = nv_benvar1 + FILL(" ",30 - LENGTH(nv_benvar1))
        nv_benvar2 = STRING (nv_engcst)
        nv_benvar  = nv_benvar1 + nv_benvar2.

    nv_itemno = nv_itemno + 1.
    RUN PdWkUwd132.
END.
ELSE IF nv_benecd[2] = "ENGS" THEN DO:
    ASSIGN
        nv_bencod  = nv_benecd[2]
        nv_benvar  = ""
        nv_benvar1 = "     Vehicle Seats = "
        nv_benvar1 = nv_benvar1 + FILL(" ",30 - LENGTH(nv_benvar1))
        nv_benvar2 = STRING (nv_engcst)
        nv_benvar  = nv_benvar1 + nv_benvar2.

    nv_itemno = nv_itemno + 1.
    RUN PdWkUwd132.
END.
ELSE IF nv_benecd[2] = "ENGT" THEN DO:
    ASSIGN
        nv_bencod  = nv_benecd[2]
        nv_benvar  = ""
        nv_benvar1 = IF nv_engcst > 100 THEN "     Vehicle Kilograms = " ELSE "     Vehicle Tons. = "
        nv_benvar1 = nv_benvar1 + FILL(" ",30 - LENGTH(nv_benvar1))
        nv_benvar2 = STRING (nv_engcst)
        nv_benvar  = nv_benvar1 + nv_benvar2.

    nv_itemno = nv_itemno + 1.
    RUN PdWkUwd132.
END.
/*-- Add A67-0029 --*/
ELSE IF nv_benecd[2] = "ENGH" THEN DO:
    ASSIGN
        nv_bencod  = nv_benecd[2]
        nv_benvar  = ""
        nv_benvar1 = "     Vehicle HP. = "
        nv_benvar1 = nv_benvar1 + FILL(" ",30 - LENGTH(nv_benvar1))
        nv_benvar2 = STRING (nv_engcst)
        nv_benvar  = nv_benvar1 + nv_benvar2.

    nv_itemno = nv_itemno + 1.
    RUN PdWkUwd132.
END.
/*-- End Add A67-0029 --*/

/*-- DRIVER NAME --*/
ASSIGN
    nv_gap    = 0
    nv_prem_c = 0
    n_uom_c   = ""
    n_uom_v   = 0
    nv_gap    = nv_drivprm.
    /*nv_gap    = ROUND(nv_drivprm,0).*/
    /*nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).*/

IF nv_flgsht = "Y" THEN DO:
    nv_prem_c = TRUNCATE(nv_gap * (nv_short / 100),0).
END.
ELSE DO:
    nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).
END.

IF nv_benecd[3] = "A000" THEN DO:
    ASSIGN
        nv_bencod  = nv_benecd[3]
        nv_benvar  = ""
        nv_benvar1 = "     Unname Driver = "
        nv_benvar1 = nv_benvar1 + FILL(" ",30 - LENGTH(nv_benvar1))
        nv_benvar2 = STRING (nv_drivno)
        nv_benvar  = nv_benvar1 + nv_benvar2.

    nv_itemno = nv_itemno + 1.
    RUN PdWkUwd132.
END.
ELSE DO:
    ASSIGN
        nv_bencod  = nv_benecd[3]
        nv_benvar  = ""
        nv_benvar1 = "     Driver name person = "
        nv_benvar1 = nv_benvar1 + FILL(" ",30 - LENGTH(nv_benvar1))
        nv_benvar2 = STRING (nv_drivno)
        nv_benvar  = nv_benvar1 + nv_benvar2. 

    nv_itemno = nv_itemno + 1.
    RUN PdWkUwd132.
END.

/*-- CAR AGE --*/
ASSIGN
    nv_gap    = 0
    nv_prem_c = 0
    n_uom_c   = ""
    n_uom_v   = 0
    nv_gap    = nv_yrprm.
    /*nv_gap    = ROUND(nv_yrprm,0).*/
    /*nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).*/

IF nv_flgsht = "Y" THEN DO:
    nv_prem_c = TRUNCATE(nv_gap * (nv_short / 100),0).
END.
ELSE DO:
    nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).
END.

ASSIGN
    nv_bencod  = nv_benecd[4]
    nv_benvar  = ""
    nv_benvar1 = "     Vehicle Year = "
    nv_benvar1 = nv_benvar1 + FILL(" ",30 - LENGTH(nv_benvar1))
    nv_benvar2 = STRING (nv_yrmanu)
    nv_benvar  = nv_benvar1 + nv_benvar2.  

nv_itemno = nv_itemno + 1.
RUN PdWkUwd132.

/*-- SUM INSURED --*/
ASSIGN
    nv_gap    = 0
    nv_prem_c = 0
    n_uom_c   = "D6"
    n_uom_v   = nv_totsi
    nv_gap    = nv_siprm.
    /*nv_gap    = ROUND(nv_siprm,0).*/
    /*nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).*/

IF nv_flgsht = "Y" THEN DO:
    nv_prem_c = TRUNCATE(nv_gap * (nv_short / 100),0).
END.
ELSE DO:
    nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).
END.

ASSIGN
    nv_bencod  = nv_benecd[5]
    nv_benvar  = ""
    nv_benvar1 = "     Own Damage = "
    nv_benvar1 = nv_benvar1 + FILL(" ",30 - LENGTH(nv_benvar1))
    nv_benvar2 = STRING (nv_totsi)
    nv_benvar  = nv_benvar1 + nv_benvar2.

nv_itemno = nv_itemno + 1.
RUN PdWkUwd132.

/*-- GROUP CODE --*/
/*IF nv_sclass = "110" OR nv_sclass = "120" THEN DO:*//*Comment A67-0029*/
IF LENGTH(nv_benecd[6]) > 3 THEN DO:
    ASSIGN
        nv_gap    = 0
        nv_prem_c = 0
        n_uom_c   = ""
        n_uom_v   = 0
        nv_gap    = nv_grprm.
        /*nv_gap    = ROUND(nv_grprm,0).*/
        /*nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).*/

    IF nv_flgsht = "Y" THEN DO:
        nv_prem_c = TRUNCATE(nv_gap * (nv_short / 100),0).
    END.
    ELSE DO:
        nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).
    END.

    ASSIGN
        nv_bencod  = nv_benecd[6]
        nv_benvar  = ""
        nv_benvar1 = "     Vehicle Group = " 
        nv_benvar1 = nv_benvar1 + FILL(" ",30 - LENGTH(nv_benvar1))
        nv_benvar2 = TRIM(nv_vehgrp)
        nv_benvar  = nv_benvar1 + nv_benvar2.

    nv_itemno = nv_itemno + 1.
    RUN PdWkUwd132.
END.
    
/*-- ACCESSORY --*/
ASSIGN
    nv_gap    = 0
    nv_prem_c = 0
    n_uom_c   = ""
    n_uom_v   = 0
    nv_gap    = nv_othprm.
    /*nv_gap    = ROUND(nv_othprm,0).*/
    /*nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).*/

IF nv_flgsht = "Y" THEN DO:
    nv_prem_c = TRUNCATE(nv_gap * (nv_short / 100),0).
END.
ELSE DO:
    nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).
END.

IF nv_access = "A" THEN DO:
    ASSIGN
        nv_bencod  = nv_benecd[7]
        nv_benvar  = ""
        nv_benvar1 = "     Accessory  = "
        nv_benvar1 = nv_benvar1 + FILL(" ",30 - LENGTH(nv_benvar1))
        nv_benvar2 = STRING(nv_access)
        nv_benvar  = nv_benvar1 + nv_benvar2.

    nv_itemno = nv_itemno + 1.
    RUN PdWkUwd132.
END.

/*-- TPBI/PER --*/
ASSIGN
    nv_gap    = 0
    nv_prem_c = 0
    n_uom_c   = "D1"
    n_uom_v   = nv_tpbi1si
    nv_gap    = nv_bipprm.
    /*nv_gap    = ROUND(nv_bipprm,0).*/
    /*nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).*/

IF nv_flgsht = "Y" THEN DO:
    nv_prem_c = TRUNCATE(nv_gap * (nv_short / 100),0).
END.
ELSE DO:
    nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).
END.

ASSIGN
    nv_bencod  = nv_benecd[8]
    nv_benvar  = ""
    nv_benvar1 = "     BI per Person = "
    nv_benvar1 = nv_benvar1 + FILL(" ",30 - LENGTH(nv_benvar1))
    nv_benvar2 = STRING(nv_tpbi1si)
    nv_benvar  = nv_benvar1 + nv_benvar2.

nv_itemno = nv_itemno + 1.
RUN PdWkUwd132.

/*-- TPBI/ACC --*/
ASSIGN
    nv_gap    = 0
    nv_prem_c = 0
    n_uom_c   = "D2"
    n_uom_v   = nv_tpbi2si
    nv_gap    = nv_biaprm.
    /*nv_gap    = ROUND(nv_biaprm,0).*/
    /*nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).*/

IF nv_flgsht = "Y" THEN DO:
    nv_prem_c = TRUNCATE(nv_gap * (nv_short / 100),0).
END.
ELSE DO:
    nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).
END.

ASSIGN
    nv_bencod  = nv_benecd[9]
    nv_benvar  = ""
    nv_benvar1 = "     BI per Accident = "
    nv_benvar1 = nv_benvar1 + FILL(" ",30 - LENGTH(nv_benvar1))
    nv_benvar2 = STRING(nv_tpbi2si)
    nv_benvar  = nv_benvar1 + nv_benvar2.

nv_itemno = nv_itemno + 1.
RUN PdWkUwd132.

/*-- TPPD/PER --*/
ASSIGN
    nv_gap    = 0
    nv_prem_c = 0
    n_uom_c   = "D5"
    n_uom_v   = nv_tppdsi
    nv_gap    = nv_pdaprm.
    /*nv_gap    = ROUND(nv_pdaprm,0).*/
    /*nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).*/

IF nv_flgsht = "Y" THEN DO:
    nv_prem_c = TRUNCATE(nv_gap * (nv_short / 100),0).
END.
ELSE DO:
    nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).
END.

ASSIGN
    nv_bencod  = nv_benecd[10]
    nv_benvar  = ""
    nv_benvar1 = "     PD per Accident = "
    nv_benvar1 = nv_benvar1 + FILL(" ",30 - LENGTH(nv_benvar1))
    nv_benvar2 = STRING(nv_tppdsi)
    nv_benvar  = nv_benvar1 + nv_benvar2.

nv_itemno = nv_itemno + 1.
RUN PdWkUwd132.

/*-- TOTAL LOSS --*/
IF nv_covcod = "5" THEN DO:
    ASSIGN
        nv_gap    = 0
        nv_prem_c = 0
        n_uom_c   = ""
        n_uom_v   = 0
        nv_gap    = nv_totlprm.
        /*nv_gap    = ROUND(nv_totlprm,0).*/
        /*nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).*/

    IF nv_flgsht = "Y" THEN DO:
        nv_prem_c = TRUNCATE(nv_gap * (nv_short / 100),0).
    END.
    ELSE DO:
        nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).
    END.

    ASSIGN
        nv_bencod  = nv_benecd[11]
        nv_benvar  = ""
        nv_benvar1 = "     Total Loss = "
        nv_benvar1 = nv_benvar1 + FILL(" ",30 - LENGTH(nv_benvar1))
        nv_benvar2 = STRING(nv_totsi)
        nv_benvar  = nv_benvar1 + nv_benvar2.

    nv_itemno = nv_itemno + 1.
    RUN PdWkUwd132.
END.

/*-- SUPE --*/
IF nv_supe = YES THEN DO:
    ASSIGN
        nv_gap    = 0
        nv_prem_c = 0
        n_uom_c   = ""
        n_uom_v   = 0
        nv_gap    = nv_supeprm.
        /*nv_gap    = ROUND(nv_supeprm,0).*/
        /*nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).*/

    IF nv_flgsht = "Y" THEN DO:
        nv_prem_c = TRUNCATE(nv_gap * (nv_short / 100),0).
    END.
    ELSE DO:
        nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).
    END.

    ASSIGN
        nv_bencod  = nv_benecd[12]
        nv_benvar  = ""
        nv_benvar1 = "     Super Premium = "
        nv_benvar1 = nv_benvar1 + FILL(" ",30 - LENGTH(nv_benvar1))
        nv_benvar2 = STRING(nv_supe00)
        nv_benvar  = nv_benvar1 + nv_benvar2.

    nv_itemno = nv_itemno + 1.
    RUN PdWkUwd132.
END.

/*-- 411 --*/
IF nv_411si <> 0 THEN DO:
    ASSIGN
        nv_gap    = 0
        nv_prem_c = 0
        n_uom_c   = ""
        n_uom_v   = nv_411si
        nv_gap    = nv_411prm.
        /*nv_gap    = ROUND(nv_411prm,0).*/
        /*nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).*/

    IF nv_flgsht = "Y" THEN DO:
        nv_prem_c = TRUNCATE(nv_gap * (nv_short / 100),0).
    END.
    ELSE DO:
        nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).
    END.

    ASSIGN
        nv_bencod   = "411"
		nv_benvar   = ""
		nv_benvar1  = "     PA Driver = "
        nv_benvar1  = nv_benvar1 + FILL(" ",30 - LENGTH(nv_benvar1))
        nv_benvar2  = STRING(nv_411si)
        nv_benvar   = nv_benvar1 + nv_benvar2. 

    nv_itemno = nv_itemno + 1.
    RUN PdWkUwd132.
END.

/*-- 412 --*/
IF nv_412si <> 0 THEN DO:
    ASSIGN
        nv_gap    = 0
        nv_prem_c = 0
        n_uom_c   = ""
        n_uom_v   = nv_412si
        nv_gap    = nv_412prm.
        /*nv_gap    = ROUND(nv_412prm,0). */
        /*nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).*/

    IF nv_flgsht = "Y" THEN DO:
        nv_prem_c = TRUNCATE(nv_gap * (nv_short / 100),0).
    END.
    ELSE DO:
        nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).
    END.

    ASSIGN
        nv_bencod   = "412"
		nv_benvar   = ""
		nv_benvar1  = "     PA Passengers = "
        nv_benvar1  = nv_benvar1 + FILL(" ",30 - LENGTH(nv_benvar1))
        nv_benvar2  = STRING(nv_412si)
        nv_benvar   = nv_benvar1 + nv_benvar2. 

    nv_itemno = nv_itemno + 1.
    RUN PdWkUwd132.
END.

/*-- 413 --*/
IF nv_413si <> 0 THEN DO:
    ASSIGN
        nv_gap    = 0
        nv_prem_c = 0
        n_uom_c   = ""
        n_uom_v   = nv_413si
        nv_gap    = nv_413prm.
        /*nv_gap    = ROUND(nv_413prm,0).*/
        /*nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).*/

    IF nv_flgsht = "Y" THEN DO:
        nv_prem_c = TRUNCATE(nv_gap * (nv_short / 100),0).
    END.
    ELSE DO:
        nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).
    END.

    ASSIGN
        nv_bencod   = "413"
        nv_benvar   = ""
        nv_benvar1  = "     PA Temp. Driver = "
        nv_benvar1  = nv_benvar1 + FILL(" ",30 - LENGTH(nv_benvar1))
        nv_benvar2  = STRING(nv_413si)
        nv_benvar   = nv_benvar1 + nv_benvar2. 

    nv_itemno = nv_itemno + 1.
    RUN PdWkUwd132.
END.

/*-- 414 --*/
IF nv_414si <> 0 THEN DO:
    ASSIGN
        nv_gap    = 0
        nv_prem_c = 0
        n_uom_c   = ""
        n_uom_v   = nv_414si
        nv_gap    = nv_414prm.
        /*nv_gap    = ROUND(nv_414prm,0).*/
        /*nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).*/

    IF nv_flgsht = "Y" THEN DO:
        nv_prem_c = TRUNCATE(nv_gap * (nv_short / 100),0).
    END.
    ELSE DO:
        nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).
    END.

    ASSIGN
        nv_bencod   = "414"
        nv_benvar   = " "
        nv_benvar1  = "     PA Temp. Passengers = "
        nv_benvar1  = nv_benvar1 + FILL(" ",30 - LENGTH(nv_benvar1))
        nv_benvar2  = STRING(nv_414si)
        nv_benvar   = nv_benvar1 + nv_benvar2.

    nv_itemno = nv_itemno + 1.
    RUN PdWkUwd132.
END.

/*-- 42 --*/
IF nv_42si <> 0 THEN DO:
    ASSIGN
        nv_gap    = 0
        nv_prem_c = 0
        n_uom_c   = ""
        n_uom_v   = nv_42si
        nv_gap    = nv_42prm.
        /*nv_gap    = ROUND(nv_42prm,0).*/
        /*nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).*/

    IF nv_flgsht = "Y" THEN DO:
        nv_prem_c = TRUNCATE(nv_gap * (nv_short / 100),0).
    END.
    ELSE DO:
        nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).
    END.

    ASSIGN
        nv_bencod   = "42"
		nv_benvar   = ""
		nv_benvar1  = "     Medical Expense = "
        nv_benvar1  = nv_benvar1 + FILL(" ",30 - LENGTH(nv_benvar1))
        nv_benvar2  = STRING(nv_42si)
        nv_benvar   = nv_benvar1 + nv_benvar2.

    nv_itemno = nv_itemno + 1.
    RUN PdWkUwd132.
END.

/*-- 43 --*/
IF nv_43si <> 0 THEN DO:
    ASSIGN
        nv_gap    = 0
        nv_prem_c = 0
        n_uom_c   = ""
        n_uom_v   = nv_43si
        nv_gap    = nv_43prm.
        /*nv_gap    = ROUND(nv_43prm,0).*/
        /*nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).*/

    IF nv_flgsht = "Y" THEN DO:
        nv_prem_c = TRUNCATE(nv_gap * (nv_short / 100),0).
    END.
    ELSE DO:
        nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).
    END.

    ASSIGN
        nv_bencod   = "43"
		nv_benvar   = ""
		nv_benvar1  = "     Airfrieght = "
        nv_benvar1  = nv_benvar1 + FILL(" ",30 - LENGTH(nv_benvar1))
        nv_benvar2  = STRING(nv_43si)
        nv_benvar   = nv_benvar1 + nv_benvar2.

    nv_itemno = nv_itemno + 1.
    RUN PdWkUwd132.
END.

IF nv_covcod = "2.1" OR nv_covcod = "2.2" OR
   nv_covcod = "3.1" OR nv_covcod = "3.2" THEN DO:
    /*-- BASE3 --*/
    ASSIGN
        nv_gap    = 0
        nv_prem_c = 0
        n_uom_c   = ""
        n_uom_v   = 0
        nv_gap    = nv_baseprm3.
        /*nv_gap    = ROUND(nv_baseprm3,0).*/
        /*nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).*/

    IF nv_flgsht = "Y" THEN DO:
        nv_prem_c = TRUNCATE(nv_gap * (nv_short / 100),0).
    END.
    ELSE DO:
        nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).
    END.

    ASSIGN
        nv_bencod  = "BA" + TRIM(SUBSTR(nv_covcod,1,1)) + TRIM(SUBSTR(nv_covcod,3,1))
        nv_benvar  = ""
        nv_benvar1 = "     Base Premium3 = "
        nv_benvar1 = nv_benvar1 + FILL(" ",30 - LENGTH(nv_benvar1))
        nv_benvar2 = STRING(nv_baseprm3)
        nv_benvar  = nv_benvar1 + nv_benvar2. 

    nv_itemno = nv_itemno + 1.
    RUN PdWkUwd132.
    
    /*-- USE3 --*/
    ASSIGN
        nv_gap    = 0
        nv_prem_c = 0
        n_uom_c   = ""
        n_uom_v   = 0
        nv_gap    = nv_useprm3.
        /*nv_gap    = ROUND(nv_useprm3,0).*/
        /*nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).*/

    IF nv_flgsht = "Y" THEN DO:
        nv_prem_c = TRUNCATE(nv_gap * (nv_short / 100),0).
    END.
    ELSE DO:
        nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).
    END.

    ASSIGN
        nv_bencod  = nv_benecd[13]
        nv_benvar  = ""
        nv_benvar1 = "     Vehicle Use = "
        nv_benvar1 = nv_benvar1 + FILL(" ",30 - LENGTH(nv_benvar1))
        nv_benvar2 = STRING(nv_vehuse)
        nv_benvar  = nv_benvar1 + nv_benvar2.

    nv_itemno = nv_itemno + 1.
    RUN PdWkUwd132.
    
    /*-- ENPT --*/
    IF nv_benecd[14] <> "" THEN DO:
        ASSIGN
            nv_gap    = 0
            nv_prem_c = 0
            n_uom_c   = ""
            n_uom_v   = 0
            nv_gap    = nv_engprm3.
            /*nv_gap    = ROUND(nv_engprm3,0).*/
            /*nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).*/

        IF nv_flgsht = "Y" THEN DO:
            nv_prem_c = TRUNCATE(nv_gap * (nv_short / 100),0).
        END.
        ELSE DO:
            nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).
        END.

        ASSIGN
            nv_bencod  = nv_benecd[14]
            nv_benvar  = ""
            nv_benvar1 = IF nv_engcst > 100 THEN "     Veh. Plus Kilograms = " ELSE "     Veh. Plus Tons. = "
            nv_benvar1 = nv_benvar1 + FILL(" ",30 - LENGTH(nv_benvar1))
            nv_benvar2 = STRING(nv_engcst)
            nv_benvar  = nv_benvar1 + nv_benvar2.

        nv_itemno = nv_itemno + 1.
        RUN PdWkUwd132.
    END.
    
    /*-- SI3 --*/
    ASSIGN
        nv_gap    = 0
        nv_prem_c = 0
        n_uom_c   = ""
        n_uom_v   = 0
        nv_gap    = nv_siprm3.
        /*nv_gap    = ROUND(nv_siprm3,0).*/
        /*nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).*/

    IF nv_flgsht = "Y" THEN DO:
        nv_prem_c = TRUNCATE(nv_gap * (nv_short / 100),0).
    END.
    ELSE DO:
        nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).
    END.

    ASSIGN
        nv_bencod  = nv_benecd[15]
        nv_benvar  = ""
        nv_benvar1 = "     Own Damage = "
        nv_benvar1 = nv_benvar1 + FILL(" ",30 - LENGTH(nv_benvar1))
        nv_benvar2 = STRING(nv_totsi)
        nv_benvar  = nv_benvar1 + nv_benvar2.

    nv_itemno = nv_itemno + 1.
    RUN PdWkUwd132.
END.

/*-- DEDOD --*/
IF nv_dedod1prm <> 0 THEN DO:
    ASSIGN
        nv_gap    = 0
        nv_prem_c = 0
        n_uom_c   = ""
        n_uom_v   = 0 
        nv_gap    = nv_dedod1prm.
        /*nv_gap    = ROUND(nv_dedod1prm,0).*/
        /*nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).*/

    IF nv_flgsht = "Y" THEN DO:
        nv_prem_c = TRUNCATE(nv_gap * (nv_short / 100),0).
    END.
    ELSE DO:
        nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).
    END.

    ASSIGN
        nv_bencod  = "DOD"
        nv_benvar  = ""
        nv_benvar1 = "     Deduct OD = "
        nv_benvar1 = nv_benvar1 + FILL(" ",30 - LENGTH(nv_benvar1))
        nv_benvar2 = STRING(nv_dedod)
        nv_benvar  = nv_benvar1 + nv_benvar2.

    nv_itemno = nv_itemno + 1.
    RUN PdWkUwd132.
END.

/*-- ADDOD --*/
IF nv_dedod2prm <> 0 THEN DO:
    ASSIGN
        nv_gap    = 0
        nv_prem_c = 0
        n_uom_c   = ""
        n_uom_v   = 0
        nv_gap    = nv_dedod2prm.
        /*nv_gap    = ROUND(nv_dedod2prm,0).*/
        /*nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).*/

    IF nv_flgsht = "Y" THEN DO:
        nv_prem_c = TRUNCATE(nv_gap * (nv_short / 100),0).
    END.
    ELSE DO:
        nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).
    END.

    ASSIGN  
        nv_bencod  = "DOD2"
		nv_benvar  = ""
		nv_benvar1 = "     Add Ded.OD = "
        nv_benvar1 = nv_benvar1 + FILL(" ",30 - LENGTH(nv_benvar1))
        nv_benvar2 = STRING(nv_addod)
        nv_benvar  = nv_benvar1 + nv_benvar2.

    nv_itemno = nv_itemno + 1.
    RUN PdWkUwd132.
END.

/*-- DEDPD --*/
IF nv_dedpdprm <> 0 THEN DO:
    ASSIGN
        nv_gap    = 0
        nv_prem_c = 0
        n_uom_c   = ""
        n_uom_v   = 0 
        nv_gap    = nv_dedpdprm.
        /*nv_gap    = ROUND(nv_dedpdprm,0).*/
        /*nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).*/

    IF nv_flgsht = "Y" THEN DO:
        nv_prem_c = TRUNCATE(nv_gap * (nv_short / 100),0).
    END.
    ELSE DO:
        nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).
    END.

    ASSIGN	
        nv_bencod  = "DPD"
        nv_benvar  = ""
		nv_benvar1 = "     Deduct PD = "
        nv_benvar1 = nv_benvar1 + FILL(" ",30 - LENGTH(nv_benvar1))
        nv_benvar2 = STRING(nv_dedpd)
        nv_benvar  = nv_benvar1 + nv_benvar2.

    nv_itemno = nv_itemno + 1.
    RUN PdWkUwd132.
END.

/*-- FLEET --*/
IF nv_fletp <> 0 THEN DO:
    ASSIGN
        nv_gap    = 0
        nv_prem_c = 0
        n_uom_c   = ""
        n_uom_v   = 0
        nv_gap    = nv_fletprm.
        /*nv_gap    = ROUND(nv_fletprm,0).*/
        /*nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).*/

    IF nv_flgsht = "Y" THEN DO:
        nv_prem_c = TRUNCATE(nv_gap * (nv_short / 100),0).
    END.
    ELSE DO:
        nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).
    END.

    ASSIGN
        nv_bencod  = "FLET"
        nv_benvar  = " "
		nv_benvar1	= "     Fleet % = "
        nv_benvar1 = nv_benvar1 + FILL(" ",30 - LENGTH(nv_benvar1))
        nv_benvar2 = STRING(nv_fletp)
        nv_benvar  = nv_benvar1 + nv_benvar2.

    nv_itemno = nv_itemno + 1.
    RUN PdWkUwd132.
END.

/*-- NCB --*/
IF nv_ncbp <> 0 THEN DO:
    ASSIGN
        nv_gap    = 0
        nv_prem_c = 0
        n_uom_c   = ""
        n_uom_v   = 0
        nv_gap    = nv_ncbprm.
        /*nv_gap    = ROUND(nv_ncbprm,0).*/
        /*nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).*/

    IF nv_flgsht = "Y" THEN DO:
        nv_prem_c = TRUNCATE(nv_gap * (nv_short / 100),0).
    END.
    ELSE DO:
        nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).
    END.

    ASSIGN
        nv_bencod  = "NCB"
        nv_benvar  = ""
        nv_benvar1 = "     NCB % = "
        nv_benvar1 = nv_benvar1 + FILL(" ",30 - LENGTH(nv_benvar1))
        nv_benvar2 = STRING(nv_ncbp)
        nv_benvar  = nv_benvar1 + nv_benvar2.

    nv_itemno = nv_itemno + 1.
    RUN PdWkUwd132.
END.

/*-- DSPC --*/
IF nv_dspcp <> 0 THEN DO:
    ASSIGN
        nv_gap    = 0
        nv_prem_c = 0
        n_uom_c   = ""
        n_uom_v   = 0
        nv_gap    = nv_dspcprm.
        /*nv_gap    = ROUND(nv_dspcprm,0).*/
        /*nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).*/

    IF nv_flgsht = "Y" THEN DO:
        nv_prem_c = TRUNCATE(nv_gap * (nv_short / 100),0).
    END.
    ELSE DO:
        nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).
    END.

    ASSIGN
        nv_bencod  = "DSPC"
        nv_benvar  = ""
        nv_benvar1	= "     Discount Special % = "
        nv_benvar1 = nv_benvar1 + FILL(" ",30 - LENGTH(nv_benvar1))
        nv_benvar2 = STRING(nv_dspcp)
        nv_benvar  = nv_benvar1 + nv_benvar2. 

    nv_itemno = nv_itemno + 1.
    RUN PdWkUwd132.
END.

/*-- LOAD CLAIM --*/
IF nv_clmp <> 0 THEN DO:
    ASSIGN
        nv_gap    = 0
        nv_prem_c = 0
        n_uom_c   = ""
        n_uom_v   = 0
        nv_gap    = nv_clmprm.
        /*nv_gap    = ROUND(nv_clmprm,0).*/
        /*nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).*/

    IF nv_flgsht = "Y" THEN DO:
        nv_prem_c = TRUNCATE(nv_gap * (nv_short / 100),0).
    END.
    ELSE DO:
        nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).
    END.

    ASSIGN
        nv_bencod  = "CL" + STRING(nv_clmp)
        nv_benvar  = ""
        nv_benvar1 = "     Load Claim % = "
        nv_benvar1 = nv_benvar1 + FILL(" ",30 - LENGTH(nv_benvar1))
        nv_benvar2 = STRING(nv_clmp)
        nv_benvar  = nv_benvar1 + nv_benvar2.

    nv_itemno = nv_itemno + 1.
    RUN PdWkUwd132.
END.

/*-- DSTF --*/
IF nv_dstfp <> 0 THEN DO:
    ASSIGN
        nv_gap    = 0
        nv_prem_c = 0
        n_uom_c   = ""
        n_uom_v   = 0
        nv_gap    = nv_dstfprm.
        /*nv_gap    = ROUND(nv_dstfprm,0).*/
        /*nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).*/

    IF nv_flgsht = "Y" THEN DO:
        nv_prem_c = TRUNCATE(nv_gap * (nv_short / 100),0).
    END.
    ELSE DO:
        nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).
    END.

    ASSIGN
        nv_bencod  = "DSTF"
        nv_benvar  = ""
        nv_benvar1 = "     Discount Staff % = "
        nv_benvar1 = nv_benvar1 + FILL(" ",30 - LENGTH(nv_benvar1))
        nv_benvar2 = STRING(nv_dstfp)
        nv_benvar  = nv_benvar1 + nv_benvar2. 

    nv_itemno = nv_itemno + 1.
    RUN PdWkUwd132.
END.


PROCEDURE PdWkUwd132:

    FIND LAST stat.pmuwd132 WHERE 
              stat.pmuwd132.campcd = nv_campcd AND
              stat.pmuwd132.policy = nv_policy AND
              stat.pmuwd132.itemno = nv_itemno NO-ERROR NO-WAIT.
    IF NOT AVAIL stat.pmuwd132 THEN DO:
        CREATE stat.pmuwd132.
        ASSIGN
            stat.pmuwd132.policy = nv_policy
            stat.pmuwd132.campcd = nv_campcd
            stat.pmuwd132.rencnt = nv_rencnt 
            stat.pmuwd132.endcnt = nv_endcnt 
            stat.pmuwd132.riskno = nv_riskno
            stat.pmuwd132.itemno = nv_itemno
            stat.pmuwd132.bencod = nv_bencod
            stat.pmuwd132.benvar = nv_benvar
            stat.pmuwd132.gap_ae = NO  /* yes  comment ranu*/
            stat.pmuwd132.gap_c  = nv_gap
            stat.pmuwd132.pd_aep = "E"
            stat.pmuwd132.prem_c = nv_prem_c
            stat.pmuwd132.uom_c  = n_uom_c
            stat.pmuwd132.uom_v  = n_uom_v
            stat.pmuwd132.trndat = TODAY
            stat.pmuwd132.trntim = STRING(TIME,"HH:MM:SS")
            stat.pmuwd132.usrid  = USERID(LDBNAME(1))
            stat.pmuwd132.effdat = nv_effdat
            stat.pmuwd132.expdat = nv_effdat + 365
            stat.pmuwd132.stcd   = nv_status
            stat.pmuwd132.txt1   = string(nv_batchyr,"9999")
            stat.pmuwd132.txt2   = nv_batchno . 

        /*--
        IF stat.pmuwd132.bencod <> "COMP" THEN DO:
            ASSIGN
                nv_gapprm = nv_gapprm + stat.pmuwd132.gap_c
                nv_pdprm  = nv_pdprm  + stat.pmuwd132.prem_c.
        END.
        --*/

    END.
   
END PROCEDURE.

nt_gapprm   = 0.
nt_pdprm    = 0.

FOR EACH stat.pmuwd132 WHERE 
         stat.pmuwd132.campcd = nv_campcd AND
         stat.pmuwd132.policy = nv_policy  :

    IF stat.pmuwd132.bencod <> "COMP" THEN DO:
        nt_gapprm   = nt_gapprm + stat.pmuwd132.gap_c.
        nt_pdprm    = nt_pdprm  + stat.pmuwd132.prem_c. 
    END.
         
END.

IF nv_gapprm <> nt_gapprm THEN DO:
    nv_adjgap = nv_gapprm - nt_gapprm.

    FIND FIRST stat.pmuwd132 WHERE
               stat.pmuwd132.policy = nv_policy AND
               stat.pmuwd132.campcd = nv_campcd AND
               stat.pmuwd132.bencod = "PD"      NO-ERROR.
    IF  AVAIL  stat.pmuwd132  THEN  DO:
        ASSIGN  
            stat.pmuwd132.gap_c = stat.pmuwd132.gap_c + nv_adjgap.
    END.
END.

IF nv_pdprm <> nt_pdprm THEN DO:
   nv_adjpd = nv_pdprm - nt_pdprm.

   FIND FIRST stat.pmuwd132 WHERE
              stat.pmuwd132.policy = nv_policy AND      
              stat.pmuwd132.campcd = nv_campcd AND      
              stat.pmuwd132.bencod = "PD"      NO-ERROR.
   IF  AVAIL stat.pmuwd132  THEN DO:
       ASSIGN  
           stat.pmuwd132.prem_c = stat.pmuwd132.prem_c + nv_adjpd.
   END.
END.
/***********************************************************************************/
/*-- Adjust ให้ตรงกับเบี้ยที่ต้องการ nv_diffprm ที่รับได้ --*/
ASSIGN
    nv_gapprm = 0
    nv_pdprm  = 0
    nv_adjgap = 0
    nv_adjpd  = 0.

FOR EACH stat.pmuwd132 WHERE 
         stat.pmuwd132.campcd = nv_campcd AND
         stat.pmuwd132.policy = nv_policy  :

    IF stat.pmuwd132.bencod <> "COMP" THEN DO:
        nv_gapprm   = nv_gapprm + stat.pmuwd132.gap_c.
        nv_pdprm    = nv_pdprm  + stat.pmuwd132.prem_c. 
    END.
         
END.

/*-- Adjust GAP --*/
IF nv_message = "" THEN DO:
    nv_adjgap = nv_netprem - nv_gapprm.
    IF nv_adjgap <> 0 THEN DO:
        IF nv_adjgap < nv_mindiff OR nv_adjgap > nv_maxdiff THEN DO:
            nv_message = "Not Adjust Gap Prem.(" + STRING(nv_adjgap) + ")".
            nv_status  = "NO".
        END.
        ELSE DO:
            FIND FIRST stat.pmuwd132 WHERE
                       stat.pmuwd132.policy = nv_policy AND
                       stat.pmuwd132.campcd = nv_campcd AND
                       stat.pmuwd132.bencod = "PD"      NO-ERROR.
            IF  AVAIL  stat.pmuwd132  THEN  DO:
                ASSIGN  
                    stat.pmuwd132.gap_c = stat.pmuwd132.gap_c + nv_adjgap.
            END.
        END.
    END.
    
    /*-- Adjust PD --*/
    nv_adjpd = nv_pdprem - nv_pdprm.
    IF nv_adjpd <> 0 THEN DO: 
        IF nv_adjpd < nv_mindiff OR nv_adjpd > nv_maxdiff THEN DO:
            nv_message = "Not Adjust PD Prem.(" + STRING(nv_adjpd) + ")".
            nv_status  = "NO".
        END.
        ELSE DO:
            FIND FIRST stat.pmuwd132 WHERE
                       stat.pmuwd132.policy = nv_policy AND      
                       stat.pmuwd132.campcd = nv_campcd AND      
                       stat.pmuwd132.bencod = "PD"      NO-ERROR.
            IF  AVAIL stat.pmuwd132  THEN DO:
                ASSIGN  
                    stat.pmuwd132.prem_c = stat.pmuwd132.prem_c + nv_adjpd.
            END.
        END.
    END.
END. 

ASSIGN
    nv_gapprm = 0
    nv_pdprm  = 0.

FOR EACH stat.pmuwd132 WHERE 
         stat.pmuwd132.campcd = nv_campcd AND
         stat.pmuwd132.policy = nv_policy  :

    IF stat.pmuwd132.bencod <> "COMP" THEN DO:
        nv_gapprm   = nv_gapprm + stat.pmuwd132.gap_c.
        nv_pdprm    = nv_pdprm  + stat.pmuwd132.prem_c. 
    END.
         
END.



