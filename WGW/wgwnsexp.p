/* wgwnsexp.P  -- Load Text file Lockton (Renew)                         */
/* Copyright   # Safety Insurance Public Company Limited                    */
/*               บริษัท ประกันคุ้มภัย จำกัด (มหาชน)                         */
/* WRITE  BY   : Ranu I. A60-0139                         */
/*             : ส่วนการค้นหาค่า งานต่ออายุเพื่อให้ค่า กรมธรรม์ต่ออายุใหม่  */
/* Modify by   : Ranu I. A64-0138 เพิ่มตัวแปรเก็บค่าการคำนวณเบี้ย */
/* ------------------------------------------------------------------------ */
DEFINE INPUT-OUTPUT  PARAMETER n_prepol    AS CHAR FORMAT "x(12)" .
DEFINE INPUT-OUTPUT  PARAMETER n_prempa    AS CHAR FORMAT "x" .
DEFINE INPUT-OUTPUT  PARAMETER n_subclass  AS CHAR FORMAT "x(3)" .  
DEFINE INPUT-OUTPUT  PARAMETER n_redbook   AS CHAR FORMAT "x(10)" . 
DEFINE INPUT-OUTPUT  PARAMETER n_brand     AS CHAR FORMAT "x(40)" . 
DEFINE INPUT-OUTPUT  PARAMETER n_model     AS CHAR FORMAT "x(50)" . 
DEFINE INPUT-OUTPUT  PARAMETER n_caryear   AS CHAR FORMAT "x(4)" . 
DEFINE INPUT-OUTPUT  PARAMETER n_cc        AS CHAR . 
DEFINE INPUT-OUTPUT  PARAMETER nv_vehgrp   AS CHAR FORMAT "x" . 
DEFINE INPUT-OUTPUT  PARAMETER nv_body     AS CHAR FORMAT "x(20)" . 
DEFINE INPUT-OUTPUT  PARAMETER nv_tons     AS CHAR.
DEFINE INPUT-OUTPUT  PARAMETER n_seat      AS CHAR.
DEFINE INPUT-OUTPUT  PARAMETER n_vehuse    AS CHAR FORMAT "x(2)" . 
DEFINE INPUT-OUTPUT  PARAMETER n_covcod    AS CHAR FORMAT "x(1)" . 
DEFINE INPUT-OUTPUT  PARAMETER n_garage    AS CHAR FORMAT "x".
DEFINE INPUT-OUTPUT  PARAMETER n_vehreg    AS CHAR FORMAT "x(10)" . 
DEFINE INPUT-OUTPUT  PARAMETER n_chassno   AS CHAR FORMAT "x(10)" . 
DEFINE INPUT-OUTPUT  PARAMETER n_engg      AS CHAR FORMAT "x(10)" . 
DEFINE INPUT-OUTPUT  PARAMETER re_uom1_v   AS DECI. 
DEFINE INPUT-OUTPUT  PARAMETER re_uom2_v   AS DECI. 
DEFINE INPUT-OUTPUT  PARAMETER re_uom5_v   AS DECI.    
DEFINE INPUT-OUTPUT  PARAMETER re_uom6_v   AS DECI. 
DEFINE INPUT-OUTPUT  PARAMETER re_uom7_v   AS DECI. 
DEFINE INPUT-OUTPUT  PARAMETER nv_basere   AS DECI.
DEFINE INPUT-OUTPUT  PARAMETER n_seat41    AS INTE.
DEFINE INPUT-OUTPUT  PARAMETER n_41        AS DECI INIT 0.
DEFINE INPUT-OUTPUT  PARAMETER n_42        AS DECI INIT 0.
DEFINE INPUT-OUTPUT  PARAMETER n_43        AS DECI INIT 0. 
DEFINE INPUT-OUTPUT  PARAMETER n_dod       AS DECI INIT 0. 
DEFINE INPUT-OUTPUT  PARAMETER n_dpd       AS DECI INIT 0.
DEFINE INPUT-OUTPUT  PARAMETER n_flet      AS CHAR.
DEFINE INPUT-OUTPUT  PARAMETER n_NCB       AS DECI INIT 0.
DEFINE INPUT-OUTPUT  PARAMETER nv_dss_per  AS DECI INIT 0.
DEFINE INPUT-OUTPUT  PARAMETER nv_dstf     AS DECI INIT 0.
DEFINE INPUT-OUTPUT  PARAMETER nv_cl       AS DECI INIT 0. 
DEFINE INPUT-OUTPUT  PARAMETER n_firstdat  AS DATE FORMAT "99/99/9999".
DEFINE INPUT-OUTPUT  PARAMETER nv_bennam1  AS CHAR FORMAT "x(30)" . 
DEFINE INPUT-OUTPUT  PARAMETER n_premt      AS DECI FORMAT ">>>,>>>,>>9.99". /*A64-0138*/
FIND LAST sic_exp.uwm100  WHERE  
    sic_exp.uwm100.policy = n_prepol  NO-LOCK NO-ERROR NO-WAIT.
IF AVAILABLE sic_exp.uwm100 THEN DO:
    FIND FIRST  sic_exp.uwm120 USE-INDEX uwm12001     WHERE
        sic_exp.uwm120.policy  = sic_exp.uwm100.policy  AND
        sic_exp.uwm120.rencnt  = sic_exp.uwm100.rencnt  AND
        sic_exp.uwm120.endcnt  = sic_exp.uwm100.endcnt   NO-ERROR NO-WAIT.
    IF AVAIL sic_exp.uwm120 THEN
        ASSIGN 
        n_firstdat = sic_exp.uwm100.fstdat
        n_prempa   = substring(sic_exp.uwm120.class,1,1)
        n_subclass = substring(sic_exp.uwm120.class,2,3).
    FIND FIRST  sic_exp.uwm130 USE-INDEX uwm13001     WHERE
        sic_exp.uwm130.policy  = sic_exp.uwm100.policy  AND
        sic_exp.uwm130.rencnt  = sic_exp.uwm100.rencnt  AND
        sic_exp.uwm130.endcnt  = sic_exp.uwm100.endcnt  NO-ERROR NO-WAIT.
    IF AVAIL sic_exp.uwm120 THEN
        ASSIGN 
        re_uom1_v  =   sic_exp.uwm130.uom1_v
        re_uom2_v  =   sic_exp.uwm130.uom2_v
        re_uom5_v  =   sic_exp.uwm130.uom5_v
        re_uom6_v  =   sic_exp.uwm130.uom6_v
        re_uom7_v  =   sic_exp.uwm130.uom7_v.
    ELSE ASSIGN 
        re_uom1_v  =   0
        re_uom2_v  =   0
        re_uom5_v  =   0
        re_uom6_v  =   0
        re_uom7_v  =   0.
    FIND LAST sic_exp.uwm301      USE-INDEX uwm30101      WHERE
        sic_exp.uwm301.policy = sic_exp.uwm100.policy  AND
        sic_exp.uwm301.rencnt = sic_exp.uwm100.rencnt  AND
        sic_exp.uwm301.endcnt = sic_exp.uwm100.endcnt  NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL uwm301 THEN
        ASSIGN 
        n_redbook  = sic_exp.uwm301.modcod     /* redbook  */ 
        n_brand    = substr(sic_exp.uwm301.moddes,1,INDEX(sic_exp.uwm301.moddes," ") - 1 )
        n_model    = substr(sic_exp.uwm301.moddes,INDEX(sic_exp.uwm301.moddes," ") + 1 )
        n_caryear  = string(sic_exp.uwm301.yrmanu)   /*รุ่นปี*/
        n_cc       = string(sic_exp.uwm301.engine)
        nv_vehgrp  = sic_exp.uwm301.vehgrp
        nv_body    = sic_exp.uwm301.body
        nv_tons    = string(sic_exp.uwm301.tons)
        n_seat     = string(sic_exp.uwm301.seats) 
        n_vehuse   = sic_exp.uwm301.vehuse       
        n_covcod   = sic_exp.uwm301.covcod      
        n_garage   = sic_exp.uwm301.garage     
        n_vehreg   = sic_exp.uwm301.vehreg     
        n_chassno  = sic_exp.uwm301.cha_no     
        n_engg     = sic_exp.uwm301.eng_no     
        n_seat41   = sic_exp.uwm301.mv41seat
        nv_bennam1 = SUBSTRING(sic_exp.uwm301.mv_ben83,1,60) .
    ELSE ASSIGN 
        n_redbook  = ""     /* redbook  */ 
        n_brand    = ""
        n_model    = ""
        n_caryear  = ""
        n_cc       = ""
        nv_vehgrp  = ""
        nv_body    = ""
        nv_tons    = ""
        n_seat     = ""
        n_vehuse   = ""      
        n_covcod   = ""    
        n_garage   = ""    
        n_vehreg   = ""    
        n_chassno  = ""    
        n_engg     = ""    
        n_seat41   = 0
        nv_bennam1 = "" .
    ASSIGN 
        nv_basere  = 0
        n_41       = 0
        n_42       = 0
        n_43       =  0
        n_dod      = 0
        n_dod      = 0
        n_dpd      = 0
        n_flet     = ""
        n_NCB      = 0
        nv_dss_per = 0
        nv_dstf    = 0
        nv_cl      = 0.
    FOR EACH sic_exp.uwd132 USE-INDEX uwd13290  WHERE
        sic_exp.uwd132.policy   = sic_exp.uwm301.policy  AND
        sic_exp.uwd132.rencnt   = sic_exp.uwm301.rencnt  AND
        sic_exp.uwd132.endcnt   = sic_exp.uwm301.endcnt  AND
        sic_exp.uwd132.riskno   = sic_exp.uwm301.riskno  AND
        sic_exp.uwd132.itemno   = sic_exp.uwm301.itemno  NO-LOCK .
        IF sic_exp.uwd132.bencod      = "base" THEN ASSIGN nv_basere  = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod = "411"  THEN ASSIGN n_41       = deci(SUBSTRING(sic_exp.uwd132.benvar,31,30)).  
        ELSE IF sic_exp.uwd132.bencod = "42"   THEN ASSIGN n_42       =  deci(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod = "43"   THEN ASSIGN n_43       =  deci(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod = "dod"  THEN ASSIGN n_dod      = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod = "dod2" THEN ASSIGN n_dod  = n_dod  +  DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod = "dpd"  THEN ASSIGN n_dpd  = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod = "flet" THEN ASSIGN n_flet     = SUBSTRING(sic_exp.uwd132.benvar,31,30).
        ELSE IF sic_exp.uwd132.bencod = "ncb"  THEN ASSIGN n_NCB      = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod = "dspc" THEN ASSIGN nv_dss_per = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod = "dstf"  THEN ASSIGN nv_dstf   = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF index(sic_exp.uwd132.bencod,"cl") <> 0 THEN ASSIGN  nv_cl = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        /* create by : A64-0138...*/
        IF sic_exp.uwd132.bencod <> "comp"  THEN DO:
            n_premt = n_premt + sic_exp.uwd132.prem_c.
        END.
        /*...end A64-0138..*/
    END.
    
END. 
