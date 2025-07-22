/* wgwttpex.P  -- Load Text file non-til [ตรีเพชรอีซูซุลิสซิ่ง ]to gw       */
/* Copyright   # Safety Insurance Public Company Limited                    */
/*               บริษัท ประกันคุ้มภัย จำกัด (มหาชน)                         */
/* WRITE  BY   : Kridtiya i.A56-0121  23/12/2013                            */
/*             : ส่วนการค้นหาค่า งานต่ออายุเพื่อให้ค่า กรมธรรม์ต่ออายุใหม่  */
/*modify  by   : Kridtiya i. A57-0010 date . 15/01/2014 add pretxt (F6)     */
/* ------------------------------------------------------------------------ */
DEFINE INPUT-OUTPUT  PARAMETER ne_prepol   AS CHAR    FORMAT "x(15)".
DEFINE INPUT-OUTPUT  PARAMETER ne_branch   AS CHAR    FORMAT "x(2)" .
DEFINE INPUT-OUTPUT  PARAMETER ne_insref   AS CHAR    FORMAT "x(10)".
DEFINE INPUT-OUTPUT  PARAMETER ne_finint   AS CHAR    FORMAT "x(10)".
DEFINE INPUT-OUTPUT  PARAMETER ne_prempa   AS CHAR    FORMAT "x" .
DEFINE INPUT-OUTPUT  PARAMETER ne_subclass AS CHAR    FORMAT "x(3)" .   
DEFINE INPUT-OUTPUT  PARAMETER ne_redbook  AS CHAR    FORMAT "x(10)".  
DEFINE INPUT-OUTPUT  PARAMETER ne_brand    AS CHAR    FORMAT "x(30)".  
DEFINE INPUT-OUTPUT  PARAMETER ne_model    AS CHAR    FORMAT "x(50)".  
DEFINE INPUT-OUTPUT  PARAMETER ne_caryear  AS CHAR    FORMAT "x(4)" .   
DEFINE INPUT-OUTPUT  PARAMETER ne_cargrp   AS CHAR    FORMAT "x(2)" .   
DEFINE INPUT-OUTPUT  PARAMETER ne_engcc    AS CHAR    FORMAT "x(4)" .   
DEFINE INPUT-OUTPUT  PARAMETER ne_tons     AS CHAR    FORMAT "x(4)" .   
DEFINE INPUT-OUTPUT  PARAMETER ne_body     AS CHAR    FORMAT "x(30)".  
DEFINE INPUT-OUTPUT  PARAMETER ne_vehuse   AS CHAR    FORMAT "x" .
DEFINE INPUT-OUTPUT  PARAMETER ne_covcod   AS CHAR    FORMAT "x" .  
DEFINE INPUT-OUTPUT  PARAMETER ne_garage   AS CHAR    FORMAT "x" .
DEFINE INPUT-OUTPUT  PARAMETER ne_bennam   AS CHAR    FORMAT "x(80)" .
DEFINE INPUT-OUTPUT  PARAMETER ne_prmtxt   AS CHAR    FORMAT "x(60)" .
DEFINE INPUT-OUTPUT  PARAMETER ne_uom1_v   AS DECI    INIT 0. 
DEFINE INPUT-OUTPUT  PARAMETER ne_uom2_v   AS DECI    INIT 0. 
DEFINE INPUT-OUTPUT  PARAMETER ne_uom5_v   AS DECI    INIT 0. 
DEFINE INPUT-OUTPUT  PARAMETER ne_si       AS CHAR    FORMAT "x(15)" INIT "" .  
DEFINE INPUT-OUTPUT  PARAMETER ne_basere   AS DECI    FORMAT ">>,>>>,>>9.99-" INIT 0.  
DEFINE INPUT-OUTPUT  PARAMETER ne_seat     AS CHAR    FORMAT "x(2)"  INIT "".   
DEFINE INPUT-OUTPUT  PARAMETER ne_seat41   AS INTE    FORMAT "99"    INIT 0  .     
DEFINE INPUT-OUTPUT  PARAMETER ne_41       AS CHAR    FORMAT ">,>>>,>>>,>>>,>>9" INIT "0" .
DEFINE INPUT-OUTPUT  PARAMETER ne_42       AS CHAR    FORMAT ">,>>>,>>>,>>>,>>9" INIT "0" .
DEFINE INPUT-OUTPUT  PARAMETER ne_43       AS CHAR    FORMAT ">,>>>,>>>,>>>,>>9" INIT "0" .
DEFINE INPUT-OUTPUT  PARAMETER ne_dod1     AS DECI.                                        
DEFINE INPUT-OUTPUT  PARAMETER ne_dod2     AS DECI.   
DEFINE INPUT-OUTPUT  PARAMETER ne_dod0     AS DECI.   
DEFINE INPUT-OUTPUT  PARAMETER ne_flet_per AS CHAR    FORMAT "x(10)" INIT "" .  
DEFINE INPUT-OUTPUT  PARAMETER ne_dss_per  AS DECIMAL FORMAT ">9.99"         .  
DEFINE INPUT-OUTPUT  PARAMETER ne_NCB      AS CHAR    FORMAT "x(10)" INIT "" . 
DEFINE INPUT-OUTPUT  PARAMETER ne_cl_per   AS DECIMAL FORMAT ">9.99"         .  
DEFINE INPUT-OUTPUT  PARAMETER ne_firstdat AS DATE    FORMAT "99/99/9999"    .
DEFINE INPUT-OUTPUT  PARAMETER nv_driver   AS CHARACTER FORMAT "X(23)" INITIAL "" NO-UNDO.
DEFINE SHARED WORKFILE ws0m009 NO-UNDO
/*1*/  FIELD policy     AS CHARACTER    INITIAL ""  
/*2*/  FIELD lnumber    AS INTEGER   
       FIELD ltext      AS CHARACTER    INITIAL "" 
       FIELD ltext2     AS CHARACTER    INITIAL "" .
ASSIGN nv_driver = "".
FIND LAST sic_exp.uwm100 USE-INDEX uwm10001 WHERE
    sic_exp.uwm100.policy = ne_prepol  NO-LOCK NO-ERROR NO-WAIT.
IF AVAILABLE sic_exp.uwm100 THEN DO:
    ASSIGN ne_branch = sic_exp.uwm100.branch
           ne_insref = sic_exp.uwm100.insref 
           ne_finint = sic_exp.uwm100.finint .
    FIND FIRST  sic_exp.uwm120 USE-INDEX uwm12001        WHERE
        sic_exp.uwm120.policy  = sic_exp.uwm100.policy   AND
        sic_exp.uwm120.rencnt  = sic_exp.uwm100.rencnt   AND
        sic_exp.uwm120.endcnt  = sic_exp.uwm100.endcnt   NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sic_exp.uwm120 THEN
        ASSIGN 
        ne_firstdat = sic_exp.uwm100.fstdat
        ne_prempa   = substring(sic_exp.uwm120.class,1,1) 
        ne_subclass = substring(sic_exp.uwm120.class,2,3).
    FIND LAST sic_exp.uwm130 USE-INDEX uwm13001 WHERE
        sic_exp.uwm130.policy = sic_exp.uwm100.policy AND
        sic_exp.uwm130.rencnt = sic_exp.uwm100.rencnt AND 
        sic_exp.uwm130.endcnt = sic_exp.uwm100.endcnt NO-LOCK NO-WAIT NO-ERROR.  /* A56-0146 */
    IF  AVAILABLE sic_exp.uwm130 THEN 
        ASSIGN
        nv_driver =  TRIM(sic_exp.uwm130.policy) +
                     STRING(sic_exp.uwm130.rencnt,"99" ) +
                     STRING(sic_exp.uwm130.endcnt,"999")  +
                     STRING(sic_exp.uwm130.riskno,"999") +
                     STRING(sic_exp.uwm130.itemno,"999")
        ne_uom1_v  = sic_exp.uwm130.uom1_v  
        ne_uom2_v  = sic_exp.uwm130.uom2_v  
        ne_uom5_v  = sic_exp.uwm130.uom5_v 
        NE_si      = IF sic_exp.uwm130.uom6_v = 0 THEN string(sic_exp.uwm130.uom7_v) ELSE string(sic_exp.uwm130.uom6_v). 
    FIND LAST sic_exp.uwm301 USE-INDEX uwm30101      WHERE
           sic_exp.uwm301.policy = sic_exp.uwm100.policy    AND
           sic_exp.uwm301.rencnt = sic_exp.uwm100.rencnt    AND
           sic_exp.uwm301.endcnt = sic_exp.uwm100.endcnt    NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL uwm301 THEN
        ASSIGN  
        ne_redbook  = ""
        ne_redbook  = sic_exp.uwm301.modcod          /* redbook  */   
        ne_brand    = IF INDEX(sic_exp.uwm301.moddes," ") <> 0 THEN 
                      trim(substr(sic_exp.uwm301.moddes,1,INDEX(sic_exp.uwm301.moddes," ") - 1 ))
                      ELSE trim(sic_exp.uwm301.moddes)
        ne_model    = IF INDEX(sic_exp.uwm301.moddes," ") <> 0 THEN 
                      trim(substr(sic_exp.uwm301.moddes,INDEX(sic_exp.uwm301.moddes," ") + 1 ))
                      ELSE  trim(sic_exp.uwm301.moddes)
        ne_caryear  = string(sic_exp.uwm301.yrmanu) 
        ne_cargrp   = sic_exp.uwm301.vehgrp
        ne_engcc    = STRING(sic_exp.uwm301.engine) 
        ne_tons     = string(sic_exp.uwm301.Tons)  
        ne_body     = sic_exp.uwm301.body
        ne_vehuse   = sic_exp.uwm301.vehuse 
        ne_covcod   = sic_exp.uwm301.covcod
        ne_garage   = sic_exp.uwm301.garage
        ne_bennam =  sic_exp.uwm301.mv_ben83
        ne_prmtxt =  sic_exp.uwm301.prmtxt
        ne_seat     = string(sic_exp.uwm301.seats)    
        ne_seat41   = sic_exp.uwm301.mv41seat 
        ne_basere   = 0
        ne_41       = "0"     
        ne_42       = "0"    
        ne_43       = "0"     
        ne_dod1     = 0        
        ne_dod2     = 0       
        ne_dod0     = 0       
        ne_flet_per = ""
        ne_dss_per  = 0                                                                           
        ne_NCB      = ""
        ne_cl_per   = 0  .   
    FOR EACH sic_exp.uwd132 USE-INDEX uwd13290  WHERE
        sic_exp.uwd132.policy   = sic_exp.uwm301.policy  AND
        sic_exp.uwd132.rencnt   = sic_exp.uwm301.rencnt  AND
        sic_exp.uwd132.endcnt   = sic_exp.uwm301.endcnt  AND
        sic_exp.uwd132.riskno   = sic_exp.uwm301.riskno  AND
        sic_exp.uwd132.itemno   = sic_exp.uwm301.itemno  NO-LOCK .
        IF sic_exp.uwd132.bencod  = "base" THEN
            ASSIGN  ne_basere  = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod                = "411" THEN
            ASSIGN   ne_41   = string(deci(SUBSTRING(sic_exp.uwd132.benvar,31,30))).  
        ELSE IF sic_exp.uwd132.bencod           = "42" THEN
            ASSIGN   ne_42   =  string(deci(SUBSTRING(sic_exp.uwd132.benvar,31,30))).
        ELSE IF sic_exp.uwd132.bencod                = "43" THEN
            ASSIGN   ne_43   =  string(deci(SUBSTRING(sic_exp.uwd132.benvar,31,30))).
        ELSE IF uwd132.bencod = "DOD" THEN
            ASSIGN  ne_dod1  = DECIMAL(SUBSTRING(uwd132.benvar,31,30)).
        ELSE IF uwd132.bencod = "DOD2" THEN
            ASSIGN  ne_dod2  = DECIMAL(SUBSTRING(uwd132.benvar,31,30)).
        ELSE IF uwd132.bencod = "DPD" THEN
            ASSIGN  ne_dod0  = DECIMAL(SUBSTRING(uwd132.benvar,31,30)).
        ELSE IF uwd132.bencod = "FLET"    THEN
            ASSIGN  ne_flet_per = (SUBSTRING(uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod    = "ncb" THEN
            ASSIGN   ne_NCB = (SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod    = "dspc" THEN
            ASSIGN   ne_dss_per = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF SUBSTR(uwd132.bencod,1,2)    = "CL" THEN
        ASSIGN  ne_cl_per            = DECIMAL(SUBSTRING(uwd132.benvar,31,30)).
    END.
    FIND FIRST sic_exp.s0m009 WHERE 
        sic_exp.s0m009.key1  = nv_driver  AND
        INTEGER(sic_exp.s0m009.noseq) = 1  NO-LOCK NO-ERROR NO-WAIT.
    IF AVAILABLE sic_exp.s0m009 THEN DO:
        FOR EACH sic_exp.s0m009  /* USE-INDEX mailtxt01 */ WHERE
            sic_exp.s0m009.key1 = nv_driver  NO-LOCK.
            CREATE ws0m009.
            ASSIGN
                ws0m009.policy  = nv_driver    /* sic_bran.s0m009.key1 */
                ws0m009.lnumber = INTEGER(sic_exp.s0m009.noseq)
                ws0m009.ltext   = sic_exp.s0m009.fld1
                ws0m009.ltext2  = sic_exp.s0m009.fld2.
        END.
    END.
END. 
