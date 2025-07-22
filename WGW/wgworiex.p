/* copy program : wgworiex.P  -- Load Text file .............           */
/* wgwqicex.P  -- Load Text file .............           */
/* Copyright   # Safety Insurance Public Company Limited                    */
/*               บริษัท ประกันคุ้มภัย จำกัด (มหาชน)                         */
/* WRITE  BY   : ranu i. A60-0340                           */
/*             : ส่วนการค้นหาค่า งานต่ออายุเพื่อให้ค่า กรมธรรม์ต่ออายุใหม่  */
/* Modify by   : Ranu I. A64-0138 เพิ่มตัวแปรเก็บค่าการคำนวณเบี้ย */
/* ------------------------------------------------------------------------ */
DEFINE INPUT-OUTPUT  PARAMETER np_prepol    AS CHAR FORMAT "x(16)".
DEFINE INPUT-OUTPUT  PARAMETER np_branch    AS CHAR FORMAT "x(2)" .
DEFINE INPUT-OUTPUT  PARAMETER np_producer  AS CHAR FORMAT "x(10)" .
DEFINE INPUT-OUTPUT  PARAMETER np_agent     AS CHAR FORMAT "x(10)" .
DEFINE INPUT-OUTPUT  PARAMETER np_insref    AS CHAR FORMAT "x(10)".
DEFINE INPUT-OUTPUT  PARAMETER np_title     AS CHAR FORMAT "x(20)" .  
DEFINE INPUT-OUTPUT  PARAMETER np_name1     AS CHAR FORMAT "x(60)" .  
DEFINE INPUT-OUTPUT  PARAMETER np_name2     AS CHAR FORMAT "x(60)" .  
DEFINE INPUT-OUTPUT  PARAMETER np_name3     AS CHAR FORMAT "x(60)" .  
DEFINE INPUT-OUTPUT  PARAMETER np_addr1     AS CHAR FORMAT "x(35)" INIT "" .
DEFINE INPUT-OUTPUT  PARAMETER np_addr2     AS CHAR FORMAT "x(35)" INIT "" .
DEFINE INPUT-OUTPUT  PARAMETER np_addr3     AS CHAR FORMAT "x(35)" INIT "" .
DEFINE INPUT-OUTPUT  PARAMETER np_addr4     AS CHAR FORMAT "x(35)" INIT "" .
DEFINE INPUT-OUTPUT  PARAMETER np_firstdat  AS CHAR FORMAT "x(10)" INIT "" .
DEFINE INPUT-OUTPUT  PARAMETER np_prepa     AS CHAR FORMAT "x"      .
DEFINE INPUT-OUTPUT  PARAMETER np_class     AS CHAR FORMAT "x(4)"      .
DEFINE INPUT-OUTPUT  PARAMETER np_redbook   AS CHAR FORMAT "x(10)".
DEFINE INPUT-OUTPUT  PARAMETER np_moddes    AS CHAR FORMAT "x(65)".
DEFINE INPUT-OUTPUT  PARAMETER np_yrmanu    AS CHAR FORMAT "x(5)".   
DEFINE INPUT-OUTPUT  PARAMETER np_vehgrp    AS CHAR FORMAT "x"  .
DEFINE INPUT-OUTPUT  PARAMETER np_body      AS CHAR FORMAT "x(20)".  
DEFINE INPUT-OUTPUT  PARAMETER np_engine    AS CHAR FORMAT "x(30)".  
DEFINE INPUT-OUTPUT  PARAMETER np_tons      AS DECI FORMAT ">>,>>9.99-"  .  
DEFINE INPUT-OUTPUT  PARAMETER np_seats     AS CHAR FORMAT "x(2)"   INIT "" .  
DEFINE INPUT-OUTPUT  PARAMETER np_vehuse    AS CHAR FORMAT "x"      INIT "" .  
DEFINE INPUT-OUTPUT  PARAMETER np_covcod    AS CHAR FORMAT "x"      INIT "" .  
DEFINE INPUT-OUTPUT  PARAMETER np_garage    AS CHAR FORMAT "x"      INIT "" .
DEFINE INPUT-OUTPUT  PARAMETER np_vehreg    AS CHAR FORMAT "x(11)"  INIT "" .
DEFINE INPUT-OUTPUT  PARAMETER np_cha_no    AS CHAR FORMAT "x(30)"  INIT "" .
DEFINE INPUT-OUTPUT  PARAMETER np_eng_no    AS CHAR FORMAT "x(30)"  INIT "" .
DEFINE INPUT-OUTPUT  PARAMETER np_uom1_v    AS DECI FORMAT ">>>,>>>,>>9.99-"  .
DEFINE INPUT-OUTPUT  PARAMETER np_uom2_v    AS DECI FORMAT ">>>,>>>,>>9.99-"  .
DEFINE INPUT-OUTPUT  PARAMETER np_uom5_v    AS DECI FORMAT ">>>,>>>,>>9.99-"  .
DEFINE INPUT-OUTPUT  PARAMETER np_si        AS CHAR FORMAT "x(30)"  INIT "" .
DEFINE INPUT-OUTPUT  PARAMETER np_baseprm   AS DECI FORMAT ">>>,>>>,>>9.99-"  .  
DEFINE INPUT-OUTPUT  PARAMETER np_41        AS DECI FORMAT ">>>,>>>,>>9.99-"  . 
DEFINE INPUT-OUTPUT  PARAMETER np_42        AS DECI FORMAT ">>>,>>>,>>9.99-"  . 
DEFINE INPUT-OUTPUT  PARAMETER np_43        AS DECI FORMAT ">>>,>>>,>>9.99-"  . 
DEFINE INPUT-OUTPUT  PARAMETER np_seat41    AS INTE INIT 0  FORMAT ">9.99-"   .
DEFINE INPUT-OUTPUT  PARAMETER np_dedod     AS DECI FORMAT ">>>,>>>,>>9.99-"  . 
DEFINE INPUT-OUTPUT  PARAMETER np_addod     AS DECI FORMAT ">>>,>>>,>>9.99-"  . 
DEFINE INPUT-OUTPUT  PARAMETER np_dedpd     AS DECI FORMAT ">>>,>>>,>>9.99-"  . 
DEFINE INPUT-OUTPUT  PARAMETER np_flet_per  AS CHAR FORMAT "x(30)"  INIT "" . 
DEFINE INPUT-OUTPUT  PARAMETER np_ncbper    AS CHAR FORMAT "x(30)"  INIT "" . 
DEFINE INPUT-OUTPUT  PARAMETER np_dss_per   AS DECIMAL   FORMAT ">9.99". 
DEFINE INPUT-OUTPUT  PARAMETER np_stf_per   AS DECIMAL   FORMAT ">9.99". 
DEFINE INPUT-OUTPUT  PARAMETER np_cl_per    AS DECIMAL   FORMAT ">9.99". 
DEFINE INPUT-OUTPUT  PARAMETER np_bennam1   AS CHAR FORMAT "x(60)"  INIT "" .   
DEFINE INPUT-OUTPUT  PARAMETER n_premt      AS DECI FORMAT ">>>,>>>,>>9.99".  /*A64-0138*/
FIND LAST sic_exp.uwm100 USE-INDEX uwm10001 WHERE
    sic_exp.uwm100.policy = np_prepol   NO-LOCK NO-ERROR NO-WAIT.
IF AVAILABLE sic_exp.uwm100 THEN DO:
    FIND FIRST  sic_exp.uwm120 USE-INDEX uwm12001        WHERE
        sic_exp.uwm120.policy  = sic_exp.uwm100.policy   AND
        sic_exp.uwm120.rencnt  = sic_exp.uwm100.rencnt   AND
        sic_exp.uwm120.endcnt  = sic_exp.uwm100.endcnt   NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sic_exp.uwm120 THEN
        ASSIGN 
        np_branch     = TRIM(sic_exp.uwm100.branch)
        np_producer   = TRIM(sic_exp.uwm100.acno1)
        np_agent      = TRIM(sic_exp.uwm100.agent)
        np_insref     = TRIM(sic_exp.uwm100.insref)  
        np_title      = TRIM(sic_exp.uwm100.ntitle)  
        np_name1      = TRIM(sic_exp.uwm100.name1)   
        np_name2      = TRIM(sic_exp.uwm100.name2)   
        np_name3      = TRIM(sic_exp.uwm100.name3)   
        np_addr1      = TRIM(sic_exp.uwm100.addr1)   
        np_addr2      = TRIM(sic_exp.uwm100.addr2)  
        np_addr3      = TRIM(sic_exp.uwm100.addr3)   
        np_addr4      = TRIM(sic_exp.uwm100.addr4)   
        np_firstdat   =  string(sic_exp.uwm100.fstdat,"99/99/9999") 
        np_prepa      =  substr(sic_exp.uwm120.class,1,1)
        np_class      =  substr(sic_exp.uwm120.class,2,3) . 
    FIND LAST sic_exp.uwm301 USE-INDEX uwm30101       WHERE
        sic_exp.uwm301.policy = sic_exp.uwm100.policy AND
        sic_exp.uwm301.rencnt = sic_exp.uwm100.rencnt AND
        sic_exp.uwm301.endcnt = sic_exp.uwm100.endcnt NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL uwm301 THEN
        ASSIGN  
        np_redbook    = sic_exp.uwm301.modcod
        np_moddes     = sic_exp.uwm301.moddes          /* redbook  */                                            
        np_yrmanu     = string(sic_exp.uwm301.yrmanu)                                                              
        np_vehgrp     = sic_exp.uwm301.vehgrp  
        np_body       = sic_exp.uwm301.body      
        np_engine     = string(sic_exp.uwm301.engine)     
        np_tons       = sic_exp.uwm301.tons    
        np_seats      = STRING(sic_exp.uwm301.seats)     
        np_vehuse     = sic_exp.uwm301.vehuse        
        np_covcod     = sic_exp.uwm301.covcod       
        np_garage     = sic_exp.uwm301.garage
        np_vehreg     = sic_exp.uwm301.vehreg    
        np_cha_no     = sic_exp.uwm301.cha_no  
        np_eng_no     = sic_exp.uwm301.eng_no
        np_seat41     = sic_exp.uwm301.mv41seat 
        /*
        np_dedod   
        np_addod   
        np_dedpd   
        np_flet_per
        np_ncbper  
        np_dss_per 
        np_stf_per 
        np_cl_per  
        np_bennam1 = sic_exp.uwm301.mv_ben83 */ .
    FIND LAST sic_exp.uwm130 USE-INDEX uwm13002     WHERE
                      sic_exp.uwm130.policy = sic_exp.uwm100.policy AND
                      sic_exp.uwm130.rencnt = sic_exp.uwm100.rencnt AND
                      sic_exp.uwm130.riskno = sic_exp.uwm120.riskno /*AND
                      sic_exp.uwm130.itemno = sic_exp.uwm120.itemno*/   NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sic_exp.uwm130  THEN
        ASSIGN 
        np_uom1_v = sic_exp.uwm130.uom1_v
        np_uom2_v = sic_exp.uwm130.uom2_v
        np_uom5_v = sic_exp.uwm130.uom5_v
        np_si     = IF sic_exp.uwm130.uom6_v = 0 THEN string(sic_exp.uwm130.uom7_v) 
                    ELSE string(sic_exp.uwm130.uom6_v).
    FOR EACH sic_exp.uwd132 USE-INDEX uwd13290  WHERE
        sic_exp.uwd132.policy   = sic_exp.uwm301.policy  AND
        sic_exp.uwd132.rencnt   = sic_exp.uwm301.rencnt  AND
        sic_exp.uwd132.endcnt   = sic_exp.uwm301.endcnt  AND
        sic_exp.uwd132.riskno   = sic_exp.uwm301.riskno  AND
        sic_exp.uwd132.itemno   = sic_exp.uwm301.itemno  NO-LOCK .
        IF      sic_exp.uwd132.bencod = "base"         THEN ASSIGN np_baseprm  = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod = "411"          THEN ASSIGN np_41       = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).  
        ELSE IF sic_exp.uwd132.bencod = "42"           THEN ASSIGN np_42       = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod = "43"           THEN ASSIGN np_43       = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod = "dod"          THEN ASSIGN np_dedod    = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod = "dod2"         THEN ASSIGN np_addod    = DECI(DECI(np_dedod)  +  DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30))).
        ELSE IF sic_exp.uwd132.bencod = "dpd"          THEN ASSIGN np_dedpd    = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod = "flet"         THEN ASSIGN np_flet_per = SUBSTRING(sic_exp.uwd132.benvar,31,30).
        ELSE IF sic_exp.uwd132.bencod = "ncb"          THEN ASSIGN np_ncbper   = string(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod = "dspc"         THEN ASSIGN np_dss_per  = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod = "dstf"         THEN ASSIGN np_stf_per  = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF index(sic_exp.uwd132.bencod,"cl") <> 0 THEN ASSIGN np_cl_per   = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        /* create by : A64-0138...*/
        IF sic_exp.uwd132.bencod <> "comp"  THEN DO:
            n_premt = n_premt + sic_exp.uwd132.prem_c.
        END.
        /*...end A64-0138..*/
    END.                                                                         
END.                                                                             
                                                                                 
