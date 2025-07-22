/*-----------------------------------------------------------------------------*/
/* Modify by : Porntiwa P.  07/12/2010  A53-0362                               */
/*           : ปรับการดึงค่างาน Renew Thanachat                                */
/* Duplicate Form : wgwtbex1.p                                                 */
/*-----------------------------------------------------------------------------*/
/* Modify By : Porntiwa P.  A54-0112  07/01/2013                               */
/*           : ปรับ Format เลขทะเบียนรถจาก 10 เป็น 11 หลัก                     */
/*-----------------------------------------------------------------------------*/
/*Modify by : Ranu I. A60-0327 27/07/2017  เพิ่มการเก็บค่าความคุ้มครอง         */
/*Modify by : Ranu I. A64-0205 เพิ่มการเก็บข้อมูลปีต่ออายุ Dealer และเก็บ Error หากไม่มีข้อมูลใบเตือน */ 
/*Modify by   : Ranu I. A64-0138 เพิ่มตัวแปรเก็บค่าการคำนวณเบี้ย */
/*-----------------------------------------------------------------------------*/
DEFINE INPUT-OUTPUT  PARAMETER nv_renpol  AS CHAR FORMAT "x(16)".
DEFINE INPUT-OUTPUT  PARAMETER nv_ncnt    AS INT  INIT 0.           /* A64-0205*/
DEFINE INPUT-OUTPUT  PARAMETER nv_poltyp  AS CHAR FORMAT "x(3)".              
DEFINE INPUT-OUTPUT  PARAMETER nv_branch  AS CHAR FORMAT "X(2)".              
DEFINE INPUT-OUTPUT  PARAMETER nv_typreq  AS CHAR FORMAT "X(10)".              
DEFINE INPUT-OUTPUT  PARAMETER nv_finit   AS CHAR FORMAT "X(10)".               
DEFINE INPUT-OUTPUT  PARAMETER nv_inscod  AS CHAR.               
DEFINE INPUT-OUTPUT  PARAMETER nv_tiname  AS CHAR FORMAT "x(15)".               
DEFINE INPUT-OUTPUT  PARAMETER nv_insnam  AS CHAR FORMAT "x(50)".               
DEFINE INPUT-OUTPUT  PARAMETER nv_name2   AS CHAR FORMAT "X(50)".               
DEFINE INPUT-OUTPUT  PARAMETER nv_addr1   AS CHAR FORMAT "x(35)".               
DEFINE INPUT-OUTPUT  PARAMETER nv_addr2   AS CHAR FORMAT "x(35)".               
DEFINE INPUT-OUTPUT  PARAMETER nv_addr3   AS CHAR FORMAT "x(34)".               
DEFINE INPUT-OUTPUT  PARAMETER nv_addr4   AS CHAR FORMAT "x(20)".              
DEFINE INPUT-OUTPUT  PARAMETER nv_class   AS CHAR FORMAT "x(3)".               
DEFINE INPUT-OUTPUT  PARAMETER nv_brand   AS CHAR FORMAT "x(30)".               
DEFINE INPUT-OUTPUT  PARAMETER nv_model   AS CHAR FORMAT "x(50)".               
DEFINE INPUT-OUTPUT  PARAMETER nv_cc      AS CHAR FORMAT "x(10)".               
DEFINE INPUT-OUTPUT  PARAMETER nv_weigth  AS CHAR FORMAT "x(10)".               
DEFINE INPUT-OUTPUT  PARAMETER nv_seat    AS CHAR FORMAT "x(2)".               
DEFINE INPUT-OUTPUT  PARAMETER nv_body    AS CHAR FORMAT "x(20)".               
/*DEFINE INPUT-OUTPUT  PARAMETER nv_vehreg  AS CHAR FORMAT "x(10)". *//*Comment A54-0112*/ 
DEFINE INPUT-OUTPUT  PARAMETER nv_vehreg  AS CHAR FORMAT "x(11)". /*A54-0112*/
DEFINE INPUT-OUTPUT  PARAMETER nv_engno   AS CHAR FORMAT "x(20)".               
DEFINE INPUT-OUTPUT  PARAMETER nv_chasno  AS CHAR FORMAT "x(20)".               
DEFINE INPUT-OUTPUT  PARAMETER nv_caryea  AS CHAR FORMAT "x(2)".               
DEFINE INPUT-OUTPUT  PARAMETER nv_carpro  AS CHAR FORMAT "x(2)".               
DEFINE INPUT-OUTPUT  PARAMETER nv_vehuse  AS CHAR FORMAT "x".               
DEFINE INPUT-OUTPUT  PARAMETER nv_garage  AS CHAR FORMAT "x".               
DEFINE INPUT-OUTPUT  PARAMETER nv_covcod  AS CHAR FORMAT "x".               
DEFINE INPUT-OUTPUT  PARAMETER nv_bename  AS CHAR FORMAT "x(50)".               
DEFINE INPUT-OUTPUT  PARAMETER nv_no_41   AS INTE.               
DEFINE INPUT-OUTPUT  PARAMETER nv_no_42   AS INTE.               
DEFINE INPUT-OUTPUT  PARAMETER nv_no_43   AS INTE. 
DEFINE INPUT-OUTPUT  PARAMETER n_uom1_v   AS DECI FORMAT ">,>>>,>>>,>>9.99-" INIT 0.      /*A60-0327*/
DEFINE INPUT-OUTPUT  PARAMETER n_uom2_v   AS DECI FORMAT ">,>>>,>>>,>>9.99-" INIT 0.      /*A60-0327*/
DEFINE INPUT-OUTPUT  PARAMETER n_uom5_v   AS DECI FORMAT ">,>>>,>>>,>>9.99-" INIT 0.      /*A60-0327*/
DEFINE INPUT-OUTPUT  PARAMETER nv_ncbper  AS DECI FORMAT ">>,>>>,>>9.99-".       
DEFINE INPUT-OUTPUT  PARAMETER nv_tariff  AS CHAR.              
DEFINE INPUT-OUTPUT  PARAMETER nv_baseprm AS DECI FORMAT ">>>,>>>,>>>,>>9.99-".  
DEFINE INPUT-OUTPUT  PARAMETER nv_cargrp  AS CHAR FORMAT "x(2)".              
DEFINE INPUT-OUTPUT  PARAMETER nv_redbook AS CHAR FORMAT "X(8)".              
DEFINE INPUT-OUTPUT  PARAMETER nv_fstdat  AS DATE INIT ?.              
DEFINE INPUT-OUTPUT  PARAMETER nv_dscper  AS DECI. 
DEFINE INPUT-OUTPUT  PARAMETER nv_drivnam AS CHAR. 
DEFINE INPUT-OUTPUT  PARAMETER nv_drivnam1 AS CHAR FORMAT "X(50)".
DEFINE INPUT-OUTPUT  PARAMETER nv_drivbir1 AS CHAR FORMAT "X(10)".
DEFINE INPUT-OUTPUT  PARAMETER nv_drivnam2 AS CHAR FORMAT "X(50)".
DEFINE INPUT-OUTPUT  PARAMETER nv_drivbir2 AS CHAR FORMAT "X(10)".
DEFINE INPUT-OUTPUT  PARAMETER nv_si       AS CHAR FORMAT "x(25)".
DEFINE INPUT-OUTPUT  PARAMETER nv_loadclm  AS CHAR FORMAT "X(10)".
DEFINE INPUT-OUTPUT  PARAMETER nv_fleet    AS CHAR FORMAT "X(10)".
DEFINE INPUT-OUTPUT  PARAMETER nv_deductpd AS CHAR FORMAT "x(10)".
DEFINE INPUT-OUTPUT  PARAMETER nv_deductda AS CHAR FORMAT "X(10)".
DEFINE INPUT-OUTPUT  PARAMETER nv_deductdo AS CHAR FORMAT "X(10)".
DEFINE INPUT-OUTPUT  PARAMETER nv_stf_per  AS DECI.
DEFINE INPUT-OUTPUT  PARAMETER nv_dealer AS CHAR FORMAT "x(10)" . /* A64-0205*/
DEFINE INPUT-OUTPUT  PARAMETER nv_chkexp AS CHAR FORMAT "x(100)" . /* A64-0205*/
DEFINE INPUT-OUTPUT  PARAMETER n_premt      AS DECI FORMAT ">>>,>>>,>>9.99". /*A64-0138*/
/*DEFINE INPUT-OUTPUT  PARAMETER nv_basere  AS DECI FORMAT ">>,>>>,>>9.99-" INIT 0.*/
DEFINE VAR nv_driver AS CHAR FORMAT "X(23)".
DEFINE VAR nv_i      AS INTE.
DEFINE BUFFER buwm130 FOR sic_exp.uwm130.

FIND LAST sic_exp.uwm100 WHERE 
          sic_exp.uwm100.policy = nv_renpol NO-LOCK NO-ERROR.
IF AVAIL sic_exp.uwm100 THEN DO:

    ASSIGN
        nv_ncnt   = sic_exp.uwm100.rencnt  /*A64-0205*/
        nv_poltyp = sic_exp.uwm100.poltyp
        nv_branch = sic_exp.uwm100.branch
        nv_typreq = sic_exp.uwm100.bs_cd
        nv_finit  = sic_exp.uwm100.finint
        nv_inscod = sic_exp.uwm100.insref 
        nv_tiname = sic_exp.uwm100.ntitle
        nv_insnam = sic_exp.uwm100.name1
        nv_name2  = sic_exp.uwm100.name2
        nv_addr1  = sic_exp.uwm100.addr1
        nv_addr2  = sic_exp.uwm100.addr2
        nv_addr3  = sic_exp.uwm100.addr3
        nv_addr4  = sic_exp.uwm100.addr4
        nv_fstdat = sic_exp.uwm100.fstdat
        nv_dealer = sic_exp.uwm100.finint . /*A64-0205*/  

    FIND sic_exp.uwm120 WHERE
         sic_exp.uwm120.policy = sic_exp.uwm100.policy AND
         sic_exp.uwm120.rencnt = sic_exp.uwm100.rencnt AND
         sic_exp.uwm120.endcnt = sic_exp.uwm100.endcnt NO-LOCK NO-ERROR.
    IF AVAIL sic_exp.uwm120 THEN DO:
        ASSIGN
            nv_class = sic_exp.uwm120.class.
    END.
        
    FIND LAST sic_exp.uwm301 WHERE
         sic_exp.uwm301.policy = sic_exp.uwm100.policy AND
         sic_exp.uwm301.rencnt = sic_exp.uwm100.rencnt AND
         sic_exp.uwm301.endcnt = sic_exp.uwm100.endcnt 
    NO-LOCK NO-ERROR.
    IF AVAIL sic_exp.uwm301 THEN DO:
        /*covcod modcod vehreg eng_no cha_no yrmanu vehuse ncbyrs ncbper
        tariff drinam driage moddes body engine tons seats vehgrp trareg
        logbok garage */
        ASSIGN
            nv_cc      =  STRING(sic_exp.uwm301.engine)
            nv_weigth  =  STRING(sic_exp.uwm301.tons)
            nv_seat    =  STRING(sic_exp.uwm301.seats)
            nv_body    =  sic_exp.uwm301.body
            nv_engno   =  sic_exp.uwm301.eng_no
            nv_chasno  =  sic_exp.uwm301.cha_no
            nv_caryea  =  STRING(sic_exp.uwm301.yrmanu,"9999")
            nv_vehuse  =  sic_exp.uwm301.vehuse
            nv_garage  =  sic_exp.uwm301.garage
            nv_covcod  =  sic_exp.uwm301.covcod
            nv_ncbper  =  sic_exp.uwm301.ncbper
            nv_tariff  =  sic_exp.uwm301.tariff
            nv_cargrp  =  sic_exp.uwm301.vehgrp
            nv_redbook =  sic_exp.uwm301.modcod
            nv_brand   =  SUBSTRING(sic_exp.uwm301.moddes,1,INDEX(sic_exp.uwm301.moddes," ") - 1)
            nv_model   =  SUBSTRING(sic_exp.uwm301.moddes,INDEX(sic_exp.uwm301.moddes," "),40).
    END.
    FOR EACH sic_exp.uwd132 WHERE 
             sic_exp.uwd132.policy = sic_exp.uwm301.policy AND
             sic_exp.uwd132.rencnt = sic_exp.uwm301.rencnt AND
             sic_exp.uwd132.riskno = sic_exp.uwm301.riskno AND
             sic_exp.uwd132.itemno = sic_exp.uwm301.itemno NO-LOCK:
        IF sic_exp.uwd132.bencod  =  "411" THEN 
            nv_no_41   = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod = "42" THEN
            nv_no_42   = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod = "43" THEN
            nv_no_43   = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod = "BASE" THEN
            nv_baseprm = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod = "DSPC" THEN
            nv_dscper  = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod = "DSTF" THEN
            nv_stf_per  = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod = "FLET" THEN
            nv_fleet = STRING(DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30))).
        ELSE IF sic_exp.uwd132.bencod = "NCB" THEN
            nv_ncbper  = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF INDEX(sic_exp.uwd132.bencod,"CL") <> 0  THEN
            nv_loadclm = STRING(DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30))).
        ELSE IF sic_exp.uwd132.bencod = "DPD" THEN
            nv_deductpd = STRING(DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30))).
        ELSE IF sic_exp.uwd132.bencod = "DOD" THEN
            nv_deductdo = STRING(DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30))).
        ELSE IF sic_exp.uwd132.bencod = "DOD2" THEN
            nv_deductda = STRING(DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30))).
        /* create by : A64-0138...*/
        IF sic_exp.uwd132.bencod <> "comp"  THEN DO:
            n_premt = n_premt + sic_exp.uwd132.prem_c.
        END.
        /*...end A64-0138..*/

    END.
    FOR EACH sic_exp.uwm130 WHERE
             sic_exp.uwm130.policy = sic_exp.uwm100.policy AND
             sic_exp.uwm130.rencnt = sic_exp.uwm100.rencnt AND
             sic_exp.uwm130.endcnt = sic_exp.uwm100.endcnt NO-LOCK:

        nv_driver = TRIM(sic_exp.uwm130.policy) +
                    STRING(sic_exp.uwm130.rencnt,"99" ) +
                    STRING(sic_exp.uwm130.endcnt,"999") +
                    STRING(sic_exp.uwm130.riskno,"999") +
                    STRING(sic_exp.uwm130.itemno,"999").

        FIND FIRST sic_exp.s0m009 WHERE
                   sic_exp.s0m009.key1 = nv_driver AND
                   INTEGER(sic_exp.s0m009.noseq) = 1
        NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sic_exp.s0m009 THEN DO:
            nv_drivnam = "Y".
            FOR EACH sic_exp.s0m009 WHERE sic_exp.s0m009.key1 = nv_driver NO-LOCK:
                nv_i = nv_i + 1.
                IF nv_i = 1 THEN 
                    ASSIGN
                        nv_drivnam1 = sic_exp.s0m009.fld1
                        nv_drivbir1 = sic_exp.s0m009.fld2.
                IF nv_i = 2 THEN
                    ASSIGN
                        nv_drivnam2 = sic_exp.s0m009.fld1
                        nv_drivbir2 = sic_exp.s0m009.fld2.
            END.
            nv_i = 0.
        END.

        FIND FIRST buwm130 WHERE buwm130.policy = sic_exp.uwm130.policy AND
                                 buwm130.rencnt = sic_exp.uwm130.rencnt AND
                                 buwm130.endcnt = sic_exp.uwm130.endcnt AND
                                 buwm130.riskgp = sic_exp.uwm130.riskgp AND
                                 buwm130.riskno = sic_exp.uwm130.riskno AND
                                 buwm130.itemno = sic_exp.uwm130.itemno NO-LOCK NO-ERROR.
        IF AVAIL buwm130 THEN DO:
            ASSIGN
                n_uom1_v  = 0     /*A60-0327*/
                n_uom2_v  = 0     /*A60-0327*/
                n_uom5_v  = 0     /*A60-0327*/
                nv_si = STRING(buwm130.uom6_v)
                n_uom1_v  = buwm130.uom1_v  /*A60-0327*/ 
                n_uom2_v  = buwm130.uom2_v  /*A60-0327*/ 
                n_uom5_v  = buwm130.uom5_v . /*A60-0327*/
                
        END.

    END.
END.
ELSE DO:
    nv_chkexp = "ไม่พบข้อมูล " + nv_renpol + "ในระบบ Expiry " .
END.

