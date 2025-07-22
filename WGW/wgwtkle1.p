/* Programname :  -- Load Text file tib [toyota]to gw                       */
/* Copyright   # Safety Insurance Public Company Limited                    */
/*               บริษัท ประกันคุ้มภัย จำกัด (มหาชน)                         */
/* WRITE  BY   : Kridtiya i. A66-0108 Date.                        */
/*             : ส่วนการค้นหาค่า งานต่ออายุเพื่อเช็คข้อมูล */

DEFINE INPUT-OUTPUT  PARAMETER n_expdat      AS DATE FORMAT "99/99/9999".
DEFINE INPUT-OUTPUT  PARAMETER n_prepol      AS CHAR FORMAT "x(15)" .
DEFINE INPUT-OUTPUT  PARAMETER n_subclass    AS CHAR FORMAT "x(3)" .   
DEFINE INPUT-OUTPUT  PARAMETER n_covcod      AS CHAR FORMAT "x(30)" . 
DEFINE INPUT-OUTPUT  PARAMETER n_garage     AS CHAR FORMAT "x(30)" . 
DEFINE INPUT-OUTPUT  PARAMETER nv_si         AS DECI FORMAT "->>,>>>,>>>,>>9.99"   INIT 0.
DEFINE INPUT-OUTPUT  PARAMETER premt         AS DECI FORMAT ">,>>>,>>>,>>9.99-"    INIT 0.

ASSIGN
    n_expdat   = ? 
    n_subclass = ""
    n_covcod   = ""
    nv_si      = 0
    premt      = 0.

FIND LAST sic_exp.uwm100 USE-INDEX uwm10001 WHERE
    sic_exp.uwm100.policy = n_prepol  NO-LOCK NO-ERROR NO-WAIT.
IF AVAILABLE sic_exp.uwm100 THEN DO:
    ASSIGN n_expdat = sic_exp.uwm100.expdat .
    FIND FIRST  sic_exp.uwm120 USE-INDEX uwm12001       WHERE
        sic_exp.uwm120.policy  = sic_exp.uwm100.policy  AND
        sic_exp.uwm120.rencnt  = sic_exp.uwm100.rencnt  AND
        sic_exp.uwm120.endcnt  = sic_exp.uwm100.endcnt  NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sic_exp.uwm120 THEN                        
        ASSIGN  n_subclass = sic_exp.uwm120.class. 

    FIND FIRST  sic_exp.uwm130 USE-INDEX uwm13001       WHERE 
        sic_exp.uwm130.policy  = sic_exp.uwm120.policy  AND 
        sic_exp.uwm130.rencnt  = sic_exp.uwm120.rencnt  AND 
        sic_exp.uwm130.endcnt  = sic_exp.uwm120.endcnt  NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sic_exp.uwm130 THEN
        ASSIGN 
        nv_si     = IF sic_exp.uwm130.uom6_v  = 0 THEN sic_exp.uwm130.uom7_v 
                                                  ELSE sic_exp.uwm130.uom6_v  .

    FIND LAST sic_exp.uwm301 USE-INDEX uwm30101         WHERE
        sic_exp.uwm301.policy = sic_exp.uwm100.policy   AND
        sic_exp.uwm301.rencnt = sic_exp.uwm100.rencnt   AND
        sic_exp.uwm301.endcnt = sic_exp.uwm100.endcnt   NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL uwm301 THEN
        ASSIGN  
        n_garage      =  sic_exp.uwm301.garage
        n_covcod      = sic_exp.uwm301.covcod.

    FOR EACH sic_exp.uwd132 USE-INDEX uwd13290  WHERE
        sic_exp.uwd132.policy   = sic_exp.uwm301.policy  AND
        sic_exp.uwd132.rencnt   = sic_exp.uwm301.rencnt  AND
        sic_exp.uwd132.endcnt   = sic_exp.uwm301.endcnt  AND
        sic_exp.uwd132.riskno   = sic_exp.uwm301.riskno  AND
        sic_exp.uwd132.itemno   = sic_exp.uwm301.itemno  NO-LOCK .
        IF sic_exp.uwd132.bencod <> "comp"  THEN DO:
            premt = premt + sic_exp.uwd132.prem_c.
        END. 
    END.
END.

