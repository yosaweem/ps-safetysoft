/* Programname :  -- Load Text file tib [toyota]to gw                       */
/* Copyright   # Safety Insurance Public Company Limited                    */
/*               บริษัท ประกันคุ้มภัย จำกัด (มหาชน)                         */
/* WRITE  BY   : Kridtiya i.A57-0244  29/07/2014                            */
/*             : ส่วนการค้นหาค่า งานต่ออายุเพื่อให้ค่า กรมธรรม์ต่ออายุใหม่  */
/* Modify by : Ranu I. A59-0182 Date 07/06/2016 เพิ่มการดึงข้อมูลผู้ขับขี่ */
/* Modify By : Ranu I. A61-0269 date 25/06/2018 เพิ่มการเก็บโค้ด Promotion เดิม */
/*Modify by   : Ranu I. A64-0138 เพิ่มตัวแปรเก็บค่าการคำนวณเบี้ย */
/*Modify by   : Kridtiya i. A65-0040 เพิ่มการรับส่ง รหัสลูกค้า  */
DEFINE INPUT-OUTPUT  PARAMETER n_expdat      AS DATE FORMAT "99/99/9999".
DEFINE INPUT-OUTPUT  PARAMETER n_prepol      AS CHAR FORMAT "x(15)" .
DEFINE INPUT-OUTPUT  PARAMETER n_branch      AS CHAR FORMAT "x(3)" .
DEFINE INPUT-OUTPUT  PARAMETER n_firstdat    AS DATE FORMAT "99/99/9999".
DEFINE INPUT-OUTPUT  PARAMETER n_subclass    AS CHAR FORMAT "x(3)" .  
DEFINE INPUT-OUTPUT  PARAMETER n_redbook     AS CHAR FORMAT "x(10)" .  
DEFINE INPUT-OUTPUT  PARAMETER n_vehuse      AS CHAR FORMAT "x(2)" .   
DEFINE INPUT-OUTPUT  PARAMETER n_covcod      AS CHAR FORMAT "x(30)" .  
DEFINE INPUT-OUTPUT  PARAMETER n_seat        AS INTE.
DEFINE INPUT-OUTPUT  PARAMETER nv_basere     AS DECI.
DEFINE INPUT-OUTPUT  PARAMETER nv_dedod      AS DECI.         
DEFINE INPUT-OUTPUT  PARAMETER nv_addod      AS DECI.        
DEFINE INPUT-OUTPUT  PARAMETER nv_dedpd      AS DECI. 
DEFINE INPUT-OUTPUT  PARAMETER nv_flet_per   AS DECI.  
DEFINE INPUT-OUTPUT  PARAMETER n_NCB         AS DECI.
DEFINE INPUT-OUTPUT  PARAMETER nv_dss_per    AS DECI.
DEFINE INPUT-OUTPUT  PARAMETER nv_cl_per     AS DECI.  
DEFINE INPUT-OUTPUT  PARAMETER nv_si         AS DECI FORMAT "->>,>>>,>>>,>>9.99"   INIT 0.
DEFINE INPUT-OUTPUT  PARAMETER n_41          AS DECI. 
DEFINE INPUT-OUTPUT  PARAMETER n_42          AS DECI. 
DEFINE INPUT-OUTPUT  PARAMETER n_43          AS DECI. 
DEFINE INPUT-OUTPUT  PARAMETER nv_stf_per    AS DECI.
DEFINE INPUT-OUTPUT  PARAMETER n_uom1_v      AS DECI FORMAT ">,>>>,>>>,>>9.99-" INIT 0. 
DEFINE INPUT-OUTPUT  PARAMETER n_uom2_v      AS DECI FORMAT ">,>>>,>>>,>>9.99-" INIT 0.  
DEFINE INPUT-OUTPUT  PARAMETER n_uom5_v      AS DECI FORMAT ">,>>>,>>>,>>9.99-" INIT 0.
DEFINE INPUT-OUTPUT  PARAMETER n_uom7_v      AS DECI FORMAT ">,>>>,>>>,>>9.99-" INIT 0.
DEFINE INPUT-OUTPUT  PARAMETER premt         AS DECI FORMAT ">,>>>,>>>,>>9.99-" INIT 0.
DEFINE INPUT-OUTPUT  PARAMETER n_engc        AS INTEGER.
DEFINE INPUT-OUTPUT  PARAMETER n_year        AS INTEGER.
/* A59-0182 */
DEFINE INPUT-OUTPUT  PARAMETER np_bennam1   AS CHAR FORMAT "x(60)"  INIT ""   .
DEFINE INPUT-OUTPUT  PARAMETER NE_prmtxt    AS CHAR FORMAT "x(100)" INIT "".   
DEFINE INPUT-OUTPUT  PARAMETER nv_driver    AS CHAR FORMAT "X(50)" INITIAL "" .
DEFINE INPUT-OUTPUT  PARAMETER nv_promo     AS CHAR FORMAT "x(10)" INIT "" . /* A61-0269*/
DEFINE INPUT-OUTPUT  PARAMETER nv_insf      AS CHAR FORMAT "x(20)" INIT "".  /*A65-0040 */
DEFINE SHARED WORKFILE ws0m009 NO-UNDO               
       FIELD policy     AS CHARACTER    INITIAL ""   
       FIELD lnumber    AS INTEGER                   
       FIELD ltext      AS CHARACTER    INITIAL ""   
       FIELD ltext2     AS CHARACTER    INITIAL "" . 
/* end A59-0182 */
ASSIGN nv_driver = "". /*A59-0182*/
FIND LAST sic_exp.uwm100 USE-INDEX uwm10001 WHERE
    sic_exp.uwm100.policy = n_prepol  NO-LOCK NO-ERROR NO-WAIT.
IF AVAILABLE sic_exp.uwm100 THEN DO:
    ASSIGN
        nv_promo = sic_exp.uwm100.opnpol    /*A61-0269*/
        n_branch = sic_exp.uwm100.branch
        n_expdat = sic_exp.uwm100.expdat 
        nv_insf  = trim(sic_exp.uwm100.insref).   /*A65-0040 */

    FIND FIRST  sic_exp.uwm120 USE-INDEX uwm12001       WHERE
        sic_exp.uwm120.policy  = sic_exp.uwm100.policy  AND
        sic_exp.uwm120.rencnt  = sic_exp.uwm100.rencnt  AND
        sic_exp.uwm120.endcnt  = sic_exp.uwm100.endcnt  NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sic_exp.uwm120 THEN                        
        ASSIGN                                          
        n_firstdat = sic_exp.uwm100.fstdat              
        n_subclass = sic_exp.uwm120.class.              
    FIND FIRST  sic_exp.uwm130 USE-INDEX uwm13001       WHERE 
        sic_exp.uwm130.policy  = sic_exp.uwm120.policy  AND 
        sic_exp.uwm130.rencnt  = sic_exp.uwm120.rencnt  AND 
        sic_exp.uwm130.endcnt  = sic_exp.uwm120.endcnt  NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sic_exp.uwm130 THEN
        ASSIGN 
        n_uom1_v  = 0 
        n_uom2_v  = 0
        n_uom5_v  = 0
        n_uom7_v  = 0
        n_uom1_v  = sic_exp.uwm130.uom1_v   
        n_uom2_v  = sic_exp.uwm130.uom2_v   
        n_uom5_v  = sic_exp.uwm130.uom5_v  
        nv_si     = sic_exp.uwm130.uom6_v    
        n_uom7_v  = sic_exp.uwm130.uom7_v
        /* A59-0182 */
        nv_driver =  TRIM(sic_exp.uwm130.policy) +
                     STRING(sic_exp.uwm130.rencnt,"99" ) +
                     STRING(sic_exp.uwm130.endcnt,"999")  +
                     STRING(sic_exp.uwm130.riskno,"999") +
                     STRING(sic_exp.uwm130.itemno,"999").
       /* end A59-0182 */
    FIND LAST sic_exp.uwm301 USE-INDEX uwm30101         WHERE
        sic_exp.uwm301.policy = sic_exp.uwm100.policy   AND
        sic_exp.uwm301.rencnt = sic_exp.uwm100.rencnt   AND
        sic_exp.uwm301.endcnt = sic_exp.uwm100.endcnt   NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL uwm301 THEN
        ASSIGN  
        NE_prmtxt     = "" /*A59-0182*/
        np_bennam1    = "" /*A59-0182*/
        n_redbook     = ""
        n_vehuse      = ""
        n_covcod      = "" 
        n_seat        = 0 
        n_engc        = 0 
        n_year        = 0
        n_redbook     = sic_exp.uwm301.modcod          /* redbook  */                                            
        n_vehuse      = sic_exp.uwm301.vehuse                                                               
        n_covcod      = sic_exp.uwm301.covcod
        n_seat        = sic_exp.uwm301.seats
        n_engc        = sic_exp.uwm301.engine
        n_year        = sic_exp.uwm301.yrmanu
        nv_basere     = 0
        nv_dedod      = 0
        nv_addod      = 0
        nv_dedpd      = 0
        nv_flet_per   = 0
        n_NCB         = 0
        nv_dss_per    = 0
        nv_cl_per     = 0        /*จำนวนที่นั่ง*/  
        n_41          = 0   
        n_42          = 0   
        n_43          = 0   
        nv_stf_per    = 0  
        premt         = 0 
        np_bennam1    = sic_exp.uwm301.mv_ben83     /*A59-0182*/  
        NE_prmtxt     = sic_exp.uwm301.prmtxt .     /*A59-0182*/  
    FOR EACH sic_exp.uwd132 USE-INDEX uwd13290  WHERE
        sic_exp.uwd132.policy   = sic_exp.uwm301.policy  AND
        sic_exp.uwd132.rencnt   = sic_exp.uwm301.rencnt  AND
        sic_exp.uwd132.endcnt   = sic_exp.uwm301.endcnt  AND
        sic_exp.uwd132.riskno   = sic_exp.uwm301.riskno  AND
        sic_exp.uwd132.itemno   = sic_exp.uwm301.itemno  NO-LOCK .
        IF sic_exp.uwd132.bencod  = "base" THEN
            ASSIGN  nv_basere = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
            ELSE IF uwd132.bencod = "DOD" THEN
                ASSIGN  nv_dedod  = DECIMAL(SUBSTRING(uwd132.benvar,31,30)).
            ELSE IF uwd132.bencod = "DOD2" THEN
                ASSIGN  nv_addod  = DECIMAL(SUBSTRING(uwd132.benvar,31,30)).
            ELSE IF uwd132.bencod = "DPD" THEN
                ASSIGN  nv_dedpd  = DECIMAL(SUBSTRING(uwd132.benvar,31,30)).
            ELSE IF uwd132.bencod = "FLET"    THEN
                ASSIGN  nv_flet_per = DECIMAL(SUBSTRING(uwd132.benvar,31,30)).
            ELSE IF sic_exp.uwd132.bencod    = "ncb" THEN
                ASSIGN   n_NCB = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
            ELSE IF sic_exp.uwd132.bencod    = "dspc" THEN
                ASSIGN   nv_dss_per = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
            ELSE IF SUBSTR(uwd132.bencod,1,2)    = "CL" THEN
                ASSIGN  nv_cl_per            = DECIMAL(SUBSTRING(uwd132.benvar,31,30)).
            ELSE IF sic_exp.uwd132.bencod                = "411" THEN
                ASSIGN   /*อุบัติเหตุส่วนบุคคลเสียชีวิตผู้ขับขี่*/ 
                     n_41   = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).  
            ELSE IF sic_exp.uwd132.bencod           = "42" THEN
                ASSIGN   /*อุบัติเหตุส่วนบุคคลเสียชีวิตผู้โดยสารต่อครั้ง*/   
                    n_42   =  DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
            ELSE IF sic_exp.uwd132.bencod                = "43" THEN
                ASSIGN   /*การประกันตัวผู้ขับขี่*/ 
                    n_43   =  DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
            ELSE IF sic_exp.uwd132.bencod                = "DSTF" THEN
                ASSIGN nv_stf_per = DECIMAL(SUBSTRING(sic_exp.uwd132.benvar,31,30)).

            /*premt = premt + uwd132.prem_c.*/
            /* create by : A64-0138...*/
        IF sic_exp.uwd132.bencod <> "comp"  THEN DO:
            premt = premt + sic_exp.uwd132.prem_c.
        END.
        /*...end A64-0138..*/
    END.
    /*A59-0182 */
    FIND FIRST sic_exp.s0m009 WHERE 
        sic_exp.s0m009.key1  = nv_driver  AND
        INTEGER(sic_exp.s0m009.noseq) = 1  NO-LOCK NO-ERROR NO-WAIT.
            IF AVAILABLE sic_exp.s0m009 THEN DO:
                FOR EACH sic_exp.s0m009   /*USE-INDEX mailtxt01*/ WHERE
                    sic_exp.s0m009.key1 = nv_driver  NO-LOCK.
                    CREATE ws0m009.
                    ASSIGN
                        ws0m009.policy  = nv_driver    /* sic_bran.s0m009.key1 */
                        ws0m009.lnumber = INTEGER(sic_exp.s0m009.noseq)
                        ws0m009.ltext   = sic_exp.s0m009.fld1
                        ws0m009.ltext2  = sic_exp.s0m009.fld2.
                END.
            END.
     /* End A59-0182*/
END.

