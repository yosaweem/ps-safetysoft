/* wgwtilexp.P  : Load Text file BU2 (ข้อมูลกรมธรรม์เดิม)                    */
/* Copyright   : Safety Insurance Public Company Limited                    */
/*               บริษัท ประกันคุ้มภัย จำกัด (มหาชน)                         */
/* Duppicate from  : wgwsaex1.p    Kridtiya i.                              */             
/* Modify by      : Ranu i.  A59-0060  Date : 25/02/2016                    */
/*                : รับค่าข้อมูลกรมธรรม์เดิม                                */
/* Modify by      : Ranu i.  A61-0152  Date : 23/03/2018                   */
/*                : เก็บค่า Base3 และเบี้ยต่ออายุ                           */  
/*Modify by       : Ranu I. A61-0416 date .11/09/2018  เก็บข้อมูล CCTV      */  
/*Modify by       : Ranu I. A65-0177 date .30/06/2022  แก้ไขการเก็บ Acc Text*/  
/*Modify by      : Kridtiya i. A68-0019 เพิ่ม การรับส่งค่า Product          */        
/* ------------------------------------------------------------------------ */
DEFINE INPUT-OUTPUT  PARAMETER np_prepol    AS CHAR FORMAT "x(16)".
DEFINE INPUT-OUTPUT  PARAMETER np_branch    AS CHAR FORMAT "x(2)" .
DEFINE INPUT-OUTPUT  PARAMETER np_insref    AS CHAR FORMAT "x(10)".
DEFINE INPUT-OUTPUT  PARAMETER ne_dealer    AS CHAR FORMAT "x(10)".
DEFINE INPUT-OUTPUT  PARAMETER np_firstdat  AS CHAR FORMAT "x(10)" INIT "" .
DEFINE INPUT-OUTPUT  PARAMETER np_comdat    AS CHAR FORMAT "x(10)" INIT "" . 
DEFINE INPUT-OUTPUT  PARAMETER np_expdat    AS CHAR FORMAT "x(10)" INIT "" .
DEFINE INPUT-OUTPUT  PARAMETER ne_prempa    AS CHAR FORMAT "x" .
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
/*DEFINE INPUT-OUTPUT  PARAMETER np_covcod    AS CHAR FORMAT "x"      INIT "" .  */ /*A61-0152*/
DEFINE INPUT-OUTPUT  PARAMETER np_covcod    AS CHAR FORMAT "x(3)"   INIT "" .  /*A61-0152*/
DEFINE INPUT-OUTPUT  PARAMETER np_garage    AS CHAR FORMAT "x"      INIT "" .
DEFINE INPUT-OUTPUT  PARAMETER np_vehreg    AS CHAR FORMAT "x(11)"  INIT "" .
DEFINE INPUT-OUTPUT  PARAMETER np_cha_no    AS CHAR FORMAT "x(30)"  INIT "" .
DEFINE INPUT-OUTPUT  PARAMETER np_eng_no    AS CHAR FORMAT "x(30)"  INIT "" .
DEFINE INPUT-OUTPUT  PARAMETER np_uom1_v    AS CHAR FORMAT "x(30)"  INIT "" .
DEFINE INPUT-OUTPUT  PARAMETER np_uom2_v    AS CHAR FORMAT "x(30)"  INIT "" .
DEFINE INPUT-OUTPUT  PARAMETER np_uom5_v    AS CHAR FORMAT "x(30)"  INIT "" .
DEFINE INPUT-OUTPUT  PARAMETER np_si        AS CHAR FORMAT "x(30)"  INIT "" .
DEFINE INPUT-OUTPUT  PARAMETER np_baseprm   AS DECI FORMAT ">>>,>>>,>>9.99-" init 0  .
DEFINE INPUT-OUTPUT  PARAMETER np_baseprm3  AS DECI FORMAT ">>>,>>>,>>9.99-" init 0  .     /*A61-0152*/ 
DEFINE INPUT-OUTPUT  PARAMETER np_41        AS DECI FORMAT ">>>,>>>,>>9.99-" init 0  . 
DEFINE INPUT-OUTPUT  PARAMETER np_42        AS DECI FORMAT ">>>,>>>,>>9.99-" init 0  . 
DEFINE INPUT-OUTPUT  PARAMETER np_43        AS DECI FORMAT ">>>,>>>,>>9.99-" init 0  . 
DEFINE INPUT-OUTPUT  PARAMETER np_seat41    AS DECI FORMAT ">>,>>9.99-"   .
DEFINE INPUT-OUTPUT  PARAMETER np_dedod     AS DECI FORMAT ">>>,>>>,>>9.99-"  . 
DEFINE INPUT-OUTPUT  PARAMETER np_addod     AS DECI FORMAT ">>>,>>>,>>9.99-"  . 
DEFINE INPUT-OUTPUT  PARAMETER np_dedpd     AS DECI FORMAT ">>>,>>>,>>9.99-"  . 
DEFINE INPUT-OUTPUT  PARAMETER np_flet_per  AS CHAR FORMAT "x(30)"  INIT "" . 
DEFINE INPUT-OUTPUT  PARAMETER np_ncbper    AS CHAR FORMAT "x(30)"  INIT "" . 
DEFINE INPUT-OUTPUT  PARAMETER np_dss_per   AS CHAR FORMAT "x(30)"  INIT "" . 
DEFINE INPUT-OUTPUT  PARAMETER np_stf_per   AS DECI FORMAT ">>>,>>>,>>9.99-"  . 
DEFINE INPUT-OUTPUT  PARAMETER np_cl_per    AS DECI FORMAT ">>>,>>>,>>9.99-"  .
DEFINE INPUT-OUTPUT  PARAMETER np_prem      AS DECI FORMAT "->>>,>>>,>>9.99"  .  /*A61-0152*/
DEFINE INPUT-OUTPUT  PARAMETER np_bennam1   AS CHAR FORMAT "x(60)"  INIT ""   .
DEFINE INPUT-OUTPUT  PARAMETER NE_prmtxt    AS CHAR FORMAT "x(600)" INIT "".    /*A57-0010*/
DEFINE INPUT-OUTPUT  PARAMETER nv_driver    AS CHAR FORMAT "X(23)"  INITIAL "" .
DEFINE INPUT-OUTPUT  PARAMETER nv_status    AS CHAR FORMAT "x(5)"   INIT "".
DEFINE INPUT-OUTPUT  PARAMETER nv_renpol    AS CHAR FORMAT "x(13)"  INIT "".
DEFINE INPUT-OUTPUT  PARAMETER nv_cctv      AS CHAR FORMAT "x(5)"   INIT "" . /*A61-0416*/
DEFINE INPUT-OUTPUT  PARAMETER nv_product   AS CHAR FORMAT "x(30)"   INIT "" . /*A61-0416*/
DEF VAR nv_comp AS DECI FORMAT ">>,>>>.99-" INIT "". /*A61-0152*/

DEFINE SHARED WORKFILE ws0m009 NO-UNDO               
/*1*/  FIELD policy     AS CHARACTER    INITIAL ""   
/*2*/  FIELD lnumber    AS INTEGER                   
       FIELD ltext      AS CHARACTER    INITIAL ""   
       FIELD ltext2     AS CHARACTER    INITIAL "" . 
ASSIGN nv_driver = "".
/* Add by : Ranu I. A65-0177 */
DEFINE SHARED TEMP-TABLE wuwd132
    FIELD prepol  AS CHAR FORMAT "x(20)" INIT ""
    FIELD bencod  AS CHAR FORMAT "x(30)" INIT "" 
    FIELD benvar  AS CHAR FORMAT "x(40)" INIT "" 
    FIELD gap_ae  AS LOGICAL INIT NO      /* A64-0355*/
    FIELD pd_aep  AS CHAR    INIT "E"     /* A64-0355*/
    FIELD gap_c   AS DECI FORMAT ">>>,>>>,>>9.99-"    
    FIELD prem_c  AS DECI FORMAT ">>>,>>>,>>9.99-"  . 
/* end : A65-0177 */
FIND LAST sic_exp.uwm100 USE-INDEX uwm10001 WHERE
    sic_exp.uwm100.policy = np_prepol   NO-LOCK NO-ERROR NO-WAIT.
IF AVAILABLE sic_exp.uwm100 THEN DO:
    FIND FIRST  sic_exp.uwm120 USE-INDEX uwm12001        WHERE
        sic_exp.uwm120.policy  = sic_exp.uwm100.policy   AND
        sic_exp.uwm120.rencnt  = sic_exp.uwm100.rencnt   AND
        sic_exp.uwm120.endcnt  = sic_exp.uwm100.endcnt   NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sic_exp.uwm120 THEN
        ASSIGN 
        nv_product  = ""
        nv_product  = sic_exp.uwm100.cr_1
        ne_dealer   = sic_exp.uwm100.finint
        np_branch   = TRIM(sic_exp.uwm100.branch)
        np_insref   = TRIM(sic_exp.uwm100.insref)  
        np_firstdat = string(sic_exp.uwm100.fstdat,"99/99/9999") 
        np_comdat   = string(sic_exp.uwm100.expdat,"99/99/9999") 
        np_expdat   = IF (string(day(sic_exp.uwm100.expdat),"99")   = "29" ) AND 
                         (STRING(MONTH(sic_exp.uwm100.expdat),"99") = "02" ) THEN 
                             string(date("01/03/" + STRING(YEAR(sic_exp.uwm100.expdat) + 1,"9999")),"99/99/9999")  
                         ELSE   string(day(sic_exp.uwm100.expdat),"99") + "/" +  
                                STRING(MONTH(sic_exp.uwm100.expdat),"99") + "/" +  
                                STRING(YEAR(sic_exp.uwm100.expdat) + 1 ,"9999")
        ne_prempa   = substring(sic_exp.uwm120.class,1,1) 
        np_class    = substring(sic_exp.uwm120.class,2,3)
        nv_status   = TRIM(sic_exp.uwm100.polsta)                  
        nv_renpol   = TRIM(sic_exp.uwm100.renpol)  .
    FIND LAST sic_exp.uwm301 USE-INDEX uwm30101       WHERE
        sic_exp.uwm301.policy = sic_exp.uwm100.policy AND
        sic_exp.uwm301.rencnt = sic_exp.uwm100.rencnt AND
        sic_exp.uwm301.endcnt = sic_exp.uwm100.endcnt NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL uwm301 THEN DO:
        ASSIGN
            NE_prmtxt     = ""
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
            np_bennam1    = sic_exp.uwm301.mv_ben83
            NE_prmtxt     = trim(substr(sic_exp.uwm301.prmtxt,1,600)) . /*A65-0177*/
            /*NE_prmtxt     = sic_exp.uwm301.prmtxt   . /*A57-0010*/*/ /*A65-0177*/
        FIND LAST sic_exp.uwm130 USE-INDEX uwm13002         WHERE
            sic_exp.uwm130.policy = sic_exp.uwm301.policy   AND
            sic_exp.uwm130.rencnt = sic_exp.uwm301.rencnt   AND
            sic_exp.uwm130.endcnt = sic_exp.uwm301.endcnt   AND
            sic_exp.uwm130.riskno = sic_exp.uwm301.riskno   AND
            sic_exp.uwm130.itemno = sic_exp.uwm301.itemno   NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sic_exp.uwm130  THEN
            ASSIGN 
            nv_driver =  TRIM(sic_exp.uwm130.policy) +
                         STRING(sic_exp.uwm130.rencnt,"99" ) +  
                         STRING(sic_exp.uwm130.endcnt,"999") + 
                         STRING(sic_exp.uwm130.riskno,"999") +  
                         STRING(sic_exp.uwm130.itemno,"999")
            np_uom1_v = string(sic_exp.uwm130.uom1_v)
            np_uom2_v = string(sic_exp.uwm130.uom2_v)
            np_uom5_v = string(sic_exp.uwm130.uom5_v)
            np_si     = string(sic_exp.uwm130.uom6_v)
            nv_cctv   = sic_exp.uwm130.i_text . /*a61-0416*/

        FOR EACH sic_exp.uwd132 USE-INDEX uwd13290  WHERE
            sic_exp.uwd132.policy   = sic_exp.uwm301.policy  AND
            sic_exp.uwd132.rencnt   = sic_exp.uwm301.rencnt  AND
            sic_exp.uwd132.endcnt   = sic_exp.uwm301.endcnt  AND
            sic_exp.uwd132.riskno   = sic_exp.uwm301.riskno  AND
            sic_exp.uwd132.itemno   = sic_exp.uwm301.itemno  NO-LOCK .

            /*np_prem = np_prem + (sic_exp.uwd132.gap_c) .*/ /* A65-0177*/

            IF      sic_exp.uwd132.bencod = "COMP"         THEN ASSIGN nv_comp     = sic_exp.uwd132.gap_c.  /*A61-0152*/
            ELSE IF sic_exp.uwd132.bencod = "base"         THEN ASSIGN np_baseprm  = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
            /*ELSE IF sic_exp.uwd132.bencod = "base3"        THEN ASSIGN np_baseprm3 = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).  /*A61-0152*/*/ /*A65-0177*/
            ELSE IF sic_exp.uwd132.bencod = "411"          THEN ASSIGN np_41       = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).  
            ELSE IF sic_exp.uwd132.bencod = "42"           THEN ASSIGN np_42       = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
            ELSE IF sic_exp.uwd132.bencod = "43"           THEN ASSIGN np_43       = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
            ELSE IF sic_exp.uwd132.bencod = "dod"          THEN ASSIGN np_dedod    = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
            ELSE IF sic_exp.uwd132.bencod = "dod2"         THEN ASSIGN np_addod    = DECI(DECI(np_dedod)  +  DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30))).
            ELSE IF sic_exp.uwd132.bencod = "dpd"          THEN ASSIGN np_dedpd    = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
            ELSE IF sic_exp.uwd132.bencod = "flet"         THEN ASSIGN np_flet_per = SUBSTRING(sic_exp.uwd132.benvar,31,30).
            ELSE IF sic_exp.uwd132.bencod = "ncb"          THEN ASSIGN np_ncbper   = string(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
            ELSE IF sic_exp.uwd132.bencod = "dspc"         THEN ASSIGN np_dss_per  = string(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
            ELSE IF sic_exp.uwd132.bencod = "dstf"         THEN ASSIGN np_stf_per  = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
            ELSE IF index(sic_exp.uwd132.bencod,"cl") <> 0 THEN ASSIGN np_cl_per   = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
            /* Add by : A65-0177 */
            IF np_covcod = "2.1" AND sic_exp.uwd132.bencod = "ba21" THEN ASSIGN np_baseprm3  = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)). 
            ELSE IF np_covcod = "2.2" AND sic_exp.uwd132.bencod = "ba22" THEN ASSIGN np_baseprm3  = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
            else IF np_covcod = "2.3" AND sic_exp.uwd132.bencod = "ba23" THEN ASSIGN np_baseprm3  = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
            else IF np_covcod = "3.1" AND sic_exp.uwd132.bencod = "ba31" THEN ASSIGN np_baseprm3  = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
            else IF np_covcod = "3.2" AND sic_exp.uwd132.bencod = "ba32" THEN ASSIGN np_baseprm3  = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
            else IF np_covcod = "3.3" AND sic_exp.uwd132.bencod = "ba33" THEN ASSIGN np_baseprm3  = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).

            IF sic_exp.uwd132.bencod <> "COMP"  THEN DO:
                np_prem = np_prem + sic_exp.uwd132.prem_c .
                FIND FIRST wuwd132 WHERE 
                    wuwd132.prepol = sic_exp.uwm301.policy  AND
                    wuwd132.bencod = sic_exp.uwd132.bencod   NO-WAIT NO-ERROR.
                IF NOT AVAIL wuwd132 THEN DO:
                    CREATE wuwd132.
                    ASSIGN 
                        wuwd132.prepol = sic_exp.uwd132.policy
                        wuwd132.bencod = sic_exp.uwd132.bencod
                        wuwd132.benvar = sic_exp.uwd132.benvar
                        wuwd132.gap_ae = sic_exp.uwd132.gap_ae   
                        wuwd132.pd_aep = sic_exp.uwd132.pd_aep   
                        wuwd132.gap_c  = sic_exp.uwd132.gap_c 
                        wuwd132.prem_c = sic_exp.uwd132.prem_c.
                END.
            END.
            /* end A65-0177 */
        END.
        
       /* IF nv_comp <> 0 THEN ASSIGN np_prem = (np_prem - nv_comp) .*/ /* A65-0177*/

        FIND FIRST sic_exp.s0m009 USE-INDEX s0m00901 WHERE sic_exp.s0m009.key1  = nv_driver  AND
                                                           INTEGER(sic_exp.s0m009.noseq) = 1  NO-LOCK NO-ERROR NO-WAIT.
            IF AVAILABLE sic_exp.s0m009 THEN DO:
                FOR EACH sic_exp.s0m009   USE-INDEX s0m00901 WHERE
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
    
END. 
RELEASE sic_exp.s0m009.
RELEASE sic_exp.uwd132.
RELEASE sic_exp.uwm130.
RELEASE sic_exp.uwm301.
RELEASE sic_exp.uwm120.
RELEASE sic_exp.uwm100.
                                                                                 
