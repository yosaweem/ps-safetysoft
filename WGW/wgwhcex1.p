/* wgwtbex1.P  -- Load Text file tib [toyota]to gw                          */
/* Copyright   # Safety Insurance Public Company Limited                    */
/*               บริษัท ประกันคุ้มภัย จำกัด (มหาชน)                         */
/* WRITE  BY   : Kridtiya i.A53-0182  29/06/2010                            */
/*             : ส่วนการค้นหาค่า งานต่ออายุเพื่อให้ค่า กรมธรรม์ต่ออายุใหม่  */
/*Modify by   : Kridtiya i. A63-0472 Date. 09/11/2020 add  Deduct           */
/*Modify by   : Ranu I. A64-0328  date. 27/08/2021  เพิ่มการเก็บผู้ข้อมูลผู้ขับขี่ */
/* ------------------------------------------------------------------------ */
DEFINE INPUT-OUTPUT  PARAMETER n_prepol    AS CHAR FORMAT "x(12)" .
DEFINE INPUT-OUTPUT  PARAMETER n_prempa    AS CHAR FORMAT "x" .
/*DEFINE INPUT-OUTPUT  PARAMETER n_subclass  AS CHAR FORMAT "x(3)" . */ /*A64-0328 */  
DEFINE INPUT-OUTPUT  PARAMETER n_subclass  AS CHAR FORMAT "x(4)" .  /*A64-0328 */  
DEFINE INPUT-OUTPUT  PARAMETER n_model     AS CHAR FORMAT "x(40)" .   
DEFINE INPUT-OUTPUT  PARAMETER n_redbook   AS CHAR FORMAT "x(10)" .   
DEFINE INPUT-OUTPUT  PARAMETER n_cargrp    AS CHAR FORMAT "x(2)" .   
DEFINE INPUT-OUTPUT  PARAMETER n_chasno    AS CHAR FORMAT "x(30)" .   
DEFINE INPUT-OUTPUT  PARAMETER n_eng       AS CHAR FORMAT "x(30)" .   
DEFINE INPUT-OUTPUT  PARAMETER n_vehuse    AS CHAR FORMAT "x(2)" .   
DEFINE INPUT-OUTPUT  PARAMETER n_caryear   AS CHAR FORMAT "x(4)" .   
/*DEFINE INPUT-OUTPUT  PARAMETER n_carcode   AS CHAR FORMAT "x(30)" .  A64-0328 */ 
DEFINE INPUT-OUTPUT  PARAMETER n_covcod    AS CHAR FORMAT "x(3)" .  /*A64-0328 */ 
DEFINE INPUT-OUTPUT  PARAMETER n_body      AS CHAR FORMAT "x(30)" .   
DEFINE INPUT-OUTPUT  PARAMETER n_seat      AS INTE.
DEFINE INPUT-OUTPUT  PARAMETER n_engcc     AS CHAR FORMAT "x(30)" . 
DEFINE INPUT-OUTPUT  PARAMETER n_41        AS DECI.
DEFINE INPUT-OUTPUT  PARAMETER n_42        AS DECI. 
DEFINE INPUT-OUTPUT  PARAMETER n_43        AS DECI.  
DEFINE INPUT-OUTPUT  PARAMETER nv_basere   AS DECI.
DEFINE INPUT-OUTPUT  PARAMETER nv_dss_per  AS DECI.
DEFINE INPUT-OUTPUT  PARAMETER n_NCB       AS DECI. 
DEFINE INPUT-OUTPUT  PARAMETER n_garage    AS CHAR FORMAT "x".
DEFINE INPUT-OUTPUT  PARAMETER n_firstdat  AS DATE FORMAT "99/99/9999".
DEFINE INPUT-OUTPUT  PARAMETER n_deductDOD   AS INTE. /*A63-00472*/   
DEFINE INPUT-OUTPUT  PARAMETER n_deductDOD2  AS INTE. /*A63-00472*/   
DEFINE INPUT-OUTPUT  PARAMETER n_deductDPD   AS INTE. /*A63-00472*/   
/* add by : Ranu I. a64-0328 */
DEFINE INPUT-OUTPUT  PARAMETER n_netprem  AS DECI.
DEFINE INPUT-OUTPUT  PARAMETER nv_driver   AS CHAR.
DEFINE INPUT-OUTPUT  PARAMETER n_prmtdriv AS DECI .
DEFINE INPUT-OUTPUT  PARAMETER nv_drivnam  AS CHAR. 
DEFINE INPUT-OUTPUT  PARAMETER n_ndriv1   as char .
DEFINE INPUT-OUTPUT  PARAMETER n_bdate1   as char .
DEFINE INPUT-OUTPUT  PARAMETER n_ndriv2   as char .
DEFINE INPUT-OUTPUT  PARAMETER n_bdate2   as char .
DEFINE INPUT-OUTPUT  PARAMETER n_cctvcd   AS CHAR .
DEFINE SHARED TEMP-TABLE ws0m009 
/*1*/  FIELD policy     AS CHARACTER    INITIAL ""  
/*2*/  FIELD lnumber    AS INTEGER   
       FIELD ltext      AS CHARACTER    INITIAL "" 
       FIELD ltext2     AS CHARACTER    INITIAL "" .   
/* end : Ranu I. a64-0328 */
FIND LAST sic_exp.uwm100  WHERE
          sic_exp.uwm100.policy = n_prepol NO-LOCK NO-ERROR NO-WAIT.
IF AVAILABLE sic_exp.uwm100 THEN DO:
    FIND FIRST  sic_exp.uwm120 USE-INDEX uwm12001     WHERE
    sic_exp.uwm120.policy  = sic_exp.uwm100.policy  AND
    sic_exp.uwm120.rencnt  = sic_exp.uwm100.rencnt  AND
    sic_exp.uwm120.endcnt  = sic_exp.uwm100.endcnt   NO-ERROR NO-WAIT.
    IF AVAIL sic_exp.uwm120 THEN DO:
        ASSIGN 
        n_firstdat = sic_exp.uwm100.fstdat
        n_prempa   = trim(substring(sic_exp.uwm120.class,1,1))
        n_subclass = trim(substring(sic_exp.uwm120.class,2,4)).  /* A64-0328*/
        /*n_subclass = trim(substring(sic_exp.uwm120.class,2,3)).*/ /* A64-0328*/
    END.
    FIND FIRST  sic_exp.uwm130 USE-INDEX uwm13001     WHERE
        sic_exp.uwm130.policy  = sic_exp.uwm100.policy  AND
        sic_exp.uwm130.rencnt  = sic_exp.uwm100.rencnt  AND
        sic_exp.uwm130.endcnt  = sic_exp.uwm100.endcnt  NO-ERROR NO-WAIT.
    IF AVAIL sic_exp.uwm130 THEN DO:
        ASSIGN 
            n_cctvcd      = sic_exp.uwm130.i_text.
    END.
    FIND LAST sic_exp.uwm301 USE-INDEX uwm30101      WHERE
           sic_exp.uwm301.policy = sic_exp.uwm100.policy    AND
           sic_exp.uwm301.rencnt = sic_exp.uwm100.rencnt    AND
           sic_exp.uwm301.endcnt = sic_exp.uwm100.endcnt    NO-ERROR NO-WAIT.
    IF AVAIL uwm301 THEN DO:
        ASSIGN 
            n_garage      = sic_exp.uwm301.garage    
            n_model       = sic_exp.uwm301.moddes
            n_redbook     = sic_exp.uwm301.modcod   /* redbook  */                                            
            n_cargrp      = sic_exp.uwm301.vehgrp   /*กลุ่มรถยนต์*/                                       
            n_chasno      = sic_exp.uwm301.cha_no   /*หมายเลขตัวถัง */    
            n_eng         = sic_exp.uwm301.eng_no   /*หมายเลขเครื่อง*/                      
            n_vehuse      = sic_exp.uwm301.vehuse                                                                   
            n_caryear     = string(sic_exp.uwm301.yrmanu )   /*รุ่นปี*/
            n_covcod      = sic_exp.uwm301.covcod    /* A64-0328*/ 
            /*n_carcode     = sic_exp.uwm301.covcod*/   /* A64-0328*/                                                         
            n_body        = sic_exp.uwm301.body            /*แบบตัวถัง*/                                       
            n_seat        = sic_exp.uwm301.seats           /*จำนวนที่นั่ง*/                                                                
            n_engcc       = string(sic_exp.uwm301.engine)  /*ปริมาตรกระบอกสูบ*/                                     
            n_prmtdriv    = sic_exp.uwm301.actprm       /*A64-0328*/
            .

        FOR EACH sic_exp.uwd132 USE-INDEX uwd13290  WHERE
            sic_exp.uwd132.policy   = sic_exp.uwm301.policy  AND
            sic_exp.uwd132.rencnt   = sic_exp.uwm301.rencnt  AND
            sic_exp.uwd132.endcnt   = sic_exp.uwm301.endcnt  AND
            sic_exp.uwd132.riskno   = sic_exp.uwm301.riskno  AND
            sic_exp.uwd132.itemno   = sic_exp.uwm301.itemno  NO-LOCK .

            IF sic_exp.uwd132.bencod <> "COMP" THEN ASSIGN n_netprem = n_netprem + sic_exp.uwd132.prem_c .  /*A64-0328*/

            IF      sic_exp.uwd132.bencod = "411"  THEN ASSIGN n_41       = deci(SUBSTRING(sic_exp.uwd132.benvar,31,30)).  
            ELSE IF sic_exp.uwd132.bencod = "42"   THEN ASSIGN n_42       = deci(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
            ELSE IF sic_exp.uwd132.bencod = "43"   THEN ASSIGN n_43       = deci(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
            ELSE IF sic_exp.uwd132.bencod = "base" THEN ASSIGN nv_basere  = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
            ELSE IF sic_exp.uwd132.bencod = "dspc" THEN ASSIGN nv_dss_per = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
            ELSE IF sic_exp.uwd132.bencod = "ncb"  THEN ASSIGN n_NCB      = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
            ELSE IF sic_exp.uwd132.bencod = "DOD"  THEN ASSIGN n_deductDOD  = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)). /*A63-00472*/
            ELSE IF sic_exp.uwd132.bencod = "DOD2" THEN ASSIGN n_deductDOD2 = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)). /*A63-00472*/
            ELSE IF sic_exp.uwd132.bencod = "DPD"  THEN ASSIGN n_deductDPD  = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)). /*A63-00472*/
        END.
    END.
    /* add by : Ranu I. A64-0382 */
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
            sic_exp.s0m009.key1  = nv_driver  AND
            INTEGER(sic_exp.s0m009.noseq) = 1  NO-LOCK NO-ERROR NO-WAIT.
            IF AVAILABLE sic_exp.s0m009 THEN DO:
                FOR EACH stat.mailtxt WHERE stat.mailtxt_fil.policy = sic_exp.s0m009.key1  NO-LOCK.
                    CREATE ws0m009.
                    ASSIGN
                        ws0m009.policy  = nv_driver    /* sic_bran.s0m009.key1 */
                        ws0m009.lnumber = INTEGER(stat.mailtxt_fil.lnumber)
                        ws0m009.ltext   = stat.mailtxt_fil.ltext
                        ws0m009.ltext2  = stat.mailtxt_fil.ltext2.
                    nv_drivnam = "Y" .

                    IF stat.mailtxt_fil.lnumber = 1 THEN DO:
                        ASSIGN n_ndriv1 = substr(stat.mailtxt_fil.ltext,1,50) 
                               n_bdate1 = SUBSTR(stat.mailtxt_fil.ltext2,1,12).
                    END.
                    ELSE IF stat.mailtxt_fil.lnumber = 2 THEN DO:
                        ASSIGN 
                              n_ndriv2 = substr(stat.mailtxt_fil.ltext,1,50)   
                              n_bdate2 = SUBSTR(stat.mailtxt_fil.ltext2,1,12). 
                    END.
                END.
            END.
    END.
    /* end a64-0328*/
END.      
