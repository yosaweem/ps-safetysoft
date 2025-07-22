/************************************************************************/
/* wgweispno.p   Update Premium         		           */
/* Create By   : Songkran P. Date 01/06/2022 A65-0141                  */
/*---------------------------------------------------------------------*/
DEF INPUT PARAMETER nv_mode            as char.
DEF INPUT PARAMETER nv_policy          as char. //DEF  VAR nv_policy          as char. /*C65/00005 Input */ 
DEF INPUT PARAMETER nv_PromotionNumber as char. //DEF  VAR nv_PromotionNumber as char. /*C65/00005 Input */ 
DEF INPUT PARAMETER prv_class          as char. //DEF  VAR prv_class          as char. /*110       Input */ 
DEF INPUT PARAMETER prv_covcod         as char. //DEF  VAR prv_covcod         as char. /*1         Input */ 
DEF INPUT PARAMETER prv_vehgrp         as char.
DEF INPUT PARAMETER prv_vehuse         as char. //DEF  VAR prv_vehuse         as char. /*  1       Input */ 
DEF INPUT PARAMETER prv_garage         as char. //DEF  VAR prv_garage         as char. /*          Input */ 
DEF INPUT PARAMETER prv_engine         as INTE. //DEF  VAR prv_engine         as INTE. /*          Input */ 
DEF INPUT PARAMETER prv_yrmanu         as INTE. //DEF  VAR prv_yrmanu         as INTE. /*          Input */ 
DEF INPUT PARAMETER prv_uom6_v         as DECI. //DEF  VAR prv_uom6_v         as DECI. /*          Input */ 
DEF INPUT PARAMETER prv_WrittenAmt     as DECI. //DEF  VAR prv_WrittenAmt     as DECI. /*          Input */ 
DEF INPUT PARAMETER prv_CurrentTermAmt as DECI. //DEF  VAR prv_CurrentTermAmt as DECI. /*          Input */
DEF INPUT PARAMETER prv__Brand         AS CHAR. //DEF  VAR prv__Brand         AS CHAR. /*          Input */           
DEF INPUT PARAMETER prv_Model          AS CHAR. //DEF  VAR prv_Model          AS CHAR. /*          Input */
DEF INPUT PARAMETER prv_tarif          AS CHAR. //DEF  VAR prv_tarif          AS CHAR. /*          Input */
DEF OUTPUT PARAMETER prv_messe         AS CHAR. //DEF  VAR prv_messe          AS CHAR. /*          Input */

DEF VAR nv_polcamp         AS CHAR. /*          */  
DEF VAR prv_dedod          as DECI. /*          */  
DEF VAR prv_Ajbaseprm      as DECI. /*          */  
DEF VAR prv_basegapprm     as DECI. /*          */  
DEF VAR nv_uom1_v          as DECI. /*          */  
DEF VAR nv_uom2_v          as DECI. /*          */  
DEF VAR nv_uom5_v          as DECI. /*          */  
DEF VAR nv_uom6_v          as DECI. /*          */  
DEF VAR nv_mv411           as DECI.
DEF VAR nv_mv412           as DECI.
DEF VAR nv_mv42            as DECI.
DEF VAR nv_mv43            as DECI.
DEF VAR nv_sivar           AS CHAR  FORMAT "X(60)".
DEF VAR nv_bipvar          AS CHAR  FORMAT "X(60)".
DEF VAR nv_biavar          AS CHAR  FORMAT "X(60)".
DEF VAR nv_pdavar          AS CHAR  FORMAT "X(60)".
DEF VAR nv_411var          AS CHAR  FORMAT "X(60)".
DEF VAR nv_412var          AS CHAR  FORMAT "X(60)".
DEF VAR nv_42var           AS CHAR  FORMAT "X(60)".
DEF VAR nv_43var           AS CHAR  FORMAT "X(60)".
DEF VAR nv_ncbper          AS DECI.
DEF VAR nv_411t            AS DECI.
DEF VAR nv_412t            AS DECI.
DEF VAR nv_42t             AS DECI.
DEF VAR nv_43t             AS DECI.
DEF VAR prv_engstton       AS INTE. 

DEF VAR nv_gapprm          AS DECI  FORMAT ">>,>>>,>>9.99-"  INITIAL 0  NO-UNDO.
DEF VAR nv_pdprm           AS DECI  FORMAT ">>,>>>,>>9.99-"  INITIAL 0  NO-UNDO.
DEF VAR nv_CompanyCode     AS CHAR .
DEFINE VARIABLE nv_CheckData  AS LOGICAL   NO-UNDO.
DEFINE VARIABLE nv_RECFMRate  AS RECID     NO-UNDO.
DEF VAR nv_year               AS INTE INIT 0.
DEF BUFFER wf_uwd132 FOR sic_bran.uwd132.
DEF VAR nv_bptr     AS RECID. 
DEF VAR n_log   AS CHAR INIT "".
DEF VAR n_textewg   AS CHAR INIT "".

DEF TEMP-TABLE tt_uwd132 
     Field   bencod   As    Char
     Field   bensht   As    Char
     Field   nap      As    Deci     
     Field   gapae    As    Char
     Field   gap      As    Deci
     Field   benvar   As    Char
     Field   pdaep    As    Char
     Field   prem_c   As    DECI.

EMPTY TEMP-TABLE tt_uwd132.
n_log = "wgwetrprm_" + STRING(MONTH(TODAY),"99") + STRING(YEAR(TODAY),"9999") + ".TXT".
/*-- 
ASSIGN 
    nv_policy          = "Q07065C00060"
    nv_PromotionNumber = "C65/00008"    
    prv_class          = "110"      
    prv_covcod         = "1"             
    prv_vehgrp         = "3"            
    prv_vehuse         = "1"           
    prv_garage         = "G" 
    prv_seate          = 7
    prv_engine         = 2500 
    prv_tons           = 2.5
    prv_yrmanu         = 2019           
    prv_uom6_v         = 490000 
    prv__Brand         = "toyota"                       
    prv_Model          = "hilux revo" 
    prv_WrittenAmt     = 17406.64
    prv_CurrentTermAmt = 18700. 
---*/
   /* prv_CurrentTermAmt  = 18900 */

//nv_year =  (YEAR(TODAY) - prv_yrmanu ) + 1.
IF  INDEX(prv_class,"110") <> 0 THEN n_textewg = "Engine".
ELSE IF INDEX(prv_class,"210") <> 0 THEN  n_textewg  = "Seate".
ELSE IF INDEX(prv_class,"320") <> 0 THEN n_textewg  = "Tons".

prv_engstton =  prv_engine.
nv_year =  prv_yrmanu.

IF nv_PromotionNumber <> "" THEN DO:
    // all PromotionNumber,เบี้ยรวม ,นำเข้า เบี้ยสุทธิ 
    FIND LAST stat.campaign_fil USE-INDEX campfil01 WHERE
        stat.campaign_fil.camcod   = nv_PromotionNumber AND                   
        stat.campaign_fil.class    = prv_class          AND                       
        stat.campaign_fil.covcod   = prv_covcod         AND    
        stat.campaign_fil.vehgrp   = prv_vehgrp         AND
        stat.campaign_fil.vehuse   = prv_vehuse         AND 
        stat.campaign_fil.garage   = prv_garage         AND 
        stat.campaign_fil.maxcst  >= prv_engstton       AND
        stat.campaign_fil.maxyea   = nv_year            AND 
        stat.campaign_fil.simax    = prv_uom6_v         AND 
        stat.campaign_fil.netprm   = prv_WrittenAmt     AND                 
        stat.campaign_fil.grossprm = prv_CurrentTermAmt AND                     
        stat.campaign_fil.makdes   = prv__Brand         AND                     
        index(stat.campaign_fil.moddes,prv_Model) <> 0  NO-LOCK NO-ERROR NO-WAIT.   
    IF AVAIL stat.campaign_fil THEN DO:
        ASSIGN 
            nv_polcamp = stat.campaign_fil.polmst 
            nv_uom1_v  = stat.campaign_fil.uom1_v
            nv_uom2_v  = stat.campaign_fil.uom2_v
            nv_uom5_v  = stat.campaign_fil.uom5_v  
            nv_uom6_v  = stat.campaign_fil.simax  
            nv_mv411   = stat.campaign_fil.mv411     
            nv_mv412   = stat.campaign_fil.mv412     
            nv_mv42    = stat.campaign_fil.mv42      
            nv_mv43    = stat.campaign_fil.mv43  . 
    END.
    ELSE DO:
        // เบี้ยรวม
        FIND LAST stat.campaign_fil USE-INDEX campfil01 WHERE
            stat.campaign_fil.camcod   = nv_PromotionNumber   AND                 
            stat.campaign_fil.class    = prv_class            and                       
            stat.campaign_fil.covcod   = prv_covcod           and 
            stat.campaign_fil.vehgrp   = prv_vehgrp           AND
            stat.campaign_fil.vehuse   = prv_vehuse           and 
            stat.campaign_fil.garage   = prv_garage           and 
            stat.campaign_fil.maxcst  >= prv_engstton         AND
            stat.campaign_fil.maxyea   = nv_year              and 
            stat.campaign_fil.simax    = prv_uom6_v           AND            
            stat.campaign_fil.grossprm = prv_CurrentTermAmt   and                     
            stat.campaign_fil.makdes   = prv__Brand           and                     
            index(stat.campaign_fil.moddes,prv_Model) <> 0    NO-LOCK NO-ERROR NO-WAIT.   
        IF AVAIL stat.campaign_fil THEN DO:
            ASSIGN 
                nv_polcamp = stat.campaign_fil.polmst 
                nv_uom1_v  = stat.campaign_fil.uom1_v
                nv_uom2_v  = stat.campaign_fil.uom2_v
                nv_uom5_v  = stat.campaign_fil.uom5_v  
                nv_uom6_v  = stat.campaign_fil.simax
                nv_mv411   = stat.campaign_fil.mv411     
                nv_mv412   = stat.campaign_fil.mv412     
                nv_mv42    = stat.campaign_fil.mv42      
                nv_mv43    = stat.campaign_fil.mv43  . 
        END.
        ELSE DO:
            // นำเข้า เบี้ยสุทธิ
            FIND LAST stat.campaign_fil USE-INDEX campfil01 WHERE
                        stat.campaign_fil.camcod   = nv_PromotionNumber AND                 
                        stat.campaign_fil.class    = prv_class          and                        
                        stat.campaign_fil.covcod   = prv_covcod         and 
                        stat.campaign_fil.vehgrp   = prv_vehgrp         AND
                        stat.campaign_fil.vehuse   = prv_vehuse         and
                        stat.campaign_fil.garage   = prv_garage         and
                        stat.campaign_fil.maxcst  >= prv_engstton       AND
                        stat.campaign_fil.maxyea   = nv_year            and 
                        stat.campaign_fil.simax    = prv_uom6_v         AND
                        stat.campaign_fil.netprm   = prv_WrittenAmt     and                              
                        stat.campaign_fil.makdes   = prv__Brand         and                     
                        INDEX(stat.campaign_fil.moddes,prv_Model) <> 0  NO-LOCK NO-ERROR NO-WAIT.   
            IF AVAIL stat.campaign_fil THEN DO:
                ASSIGN 
                    nv_polcamp = stat.campaign_fil.polmst 
                    nv_uom1_v  = stat.campaign_fil.uom1_v
                    nv_uom2_v  = stat.campaign_fil.uom2_v
                    nv_uom5_v  = stat.campaign_fil.uom5_v  
                    nv_uom6_v  = stat.campaign_fil.simax
                    nv_mv411   = stat.campaign_fil.mv411     
                    nv_mv412   = stat.campaign_fil.mv412     
                    nv_mv42    = stat.campaign_fil.mv42      
                    nv_mv43    = stat.campaign_fil.mv43  .
            
            END.
        END.
    END.
END.

IF nv_polcamp <> "" AND nv_mode = "check" THEN DO: 
    FIND LAST sic_bran.uwm100 WHERE sic_bran.uwm100.policy = nv_policy NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sic_bran.uwm100 THEN DO:
        FIND LAST sic_bran.uwm130 WHERE sic_bran.uwm130.policy  = sic_bran.uwm100.policy NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sic_bran.uwm130 THEN DO:
             ASSIGN nv_bptr = 0      nv_gapprm   = 0     nv_pdprm    = 0 .
            FOR EACH sic_bran.uwd132  USE-INDEX uwd13201 WHERE
                    sic_bran.uwd132.policy  = sic_bran.uwm130.policy AND
                    sic_bran.uwd132.rencnt  = sic_bran.uwm130.rencnt AND
                    sic_bran.uwd132.endcnt  = sic_bran.uwm130.endcnt AND
                    sic_bran.uwd132.riskgp  = sic_bran.uwm130.riskgp AND
                    sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno AND
                    sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno NO-LOCK:

                 CREATE tt_uwd132.
                 Assign  
                     tt_uwd132.benvar   =  "old"
                     tt_uwd132.bencod   =  sic_bran.uwd132.bencod
                     tt_uwd132.nap      =  sic_bran.uwd132.gap_c + (sic_bran.uwd132.dl1_c + sic_bran.uwd132.dl2_c + sic_bran.uwd132.dl3_c) 
                     tt_uwd132.gapae    =  "A"
                     tt_uwd132.gap      =  sic_bran.uwd132.gap_c.

                     nv_gapprm = nv_gapprm + sic_bran.uwd132.gap_c + (sic_bran.uwd132.dl1_c + sic_bran.uwd132.dl2_c + sic_bran.uwd132.dl3_c) .
                     nv_pdprm =  nv_pdprm + sic_bran.uwd132.gap_c.
                 
                 FIND First sicsyac.xmm105 USE-INDEX xmm10501 WHERE 
                            sicsyac.xmm105.tariff EQ "x" AND
                            sicsyac.xmm105.bencod EQ sic_bran.uwd132.bencod NO-LOCK NO-ERROR.
                 IF AVAIL sicsyac.xmm105 THEN  tt_uwd132.bensht = sicsyac.xmm105.bensht .
       
            END.
            IF nv_pdprm <> 0 THEN DO:
                CREATE tt_uwd132.
                Assign  
                 tt_uwd132.benvar   =  "old"
                 tt_uwd132.bensht   =  "Total NAP/PD"
                 tt_uwd132.nap      =  nv_gapprm 
                 tt_uwd132.gap      =  nv_pdprm.
            END.
            
             

            RELEASE tt_uwd132.
            /*clear..sic_bran.uwd132. */
            ASSIGN nv_bptr = 0      nv_gapprm   = 0     nv_pdprm    = 0 .

            FOR EACH stat.pmuwd132 USE-INDEX pmuwd13201 WHERE 
                     stat.pmuwd132.campcd  = TRIM(nv_PromotionNumber)  AND
                     stat.pmuwd132.policy  = TRIM(nv_polcamp)          NO-LOCK:

                

                 CREATE tt_uwd132.
                 Assign  
                     tt_uwd132.benvar   =  "new"
                     tt_uwd132.bencod   =  stat.pmuwd132.bencod
                     tt_uwd132.nap      =  stat.pmuwd132.gap_c + (stat.pmuwd132.dl1_c + stat.pmuwd132.dl2_c + stat.pmuwd132.dl3_c) 
                     tt_uwd132.gapae    =  "A"
                     tt_uwd132.gap      =  stat.pmuwd132.gap_c.
                    // tt_uwd132.benvar   =  stat.pmuwd132.benvar
                    // tt_uwd132.pdaep    =  stat.pmuwd132.pd_aep
                    // tt_uwd132.prem_c   =  stat.pmuwd132.prem_c.
                 nv_gapprm = nv_gapprm +   stat.pmuwd132.gap_c + (stat.pmuwd132.dl1_c + stat.pmuwd132.dl2_c + stat.pmuwd132.dl3_c) .
                 nv_pdprm =  nv_pdprm + stat.pmuwd132.gap_c.
                 
                 FIND sicsyac.xmm105 USE-INDEX xmm10501 WHERE 
                            sicsyac.xmm105.tariff EQ "x" AND
                            sicsyac.xmm105.bencod EQ stat.pmuwd132.bencod NO-LOCK NO-ERROR.
                 IF AVAIL sicsyac.xmm105 THEN tt_uwd132.bensht = sicsyac.xmm105.bensht .

                

            END.    /*  FOR EACH stat.pmuwd132 ....*/
            IF nv_pdprm <> 0 THEN DO:
                CREATE tt_uwd132.
                Assign  
                 tt_uwd132.benvar   =  "new"
                 tt_uwd132.bensht   =  "Total NAP/PD"
                 tt_uwd132.nap      =  nv_gapprm 
                 tt_uwd132.gap      =  nv_pdprm .
            END.
            RELEASE tt_uwd132.
        END.        /*  sic_bran.uwm130 */
        /*MESSAGE nv_pdprm  inte(prv_uom6_v)  nv_gapprm VIEW-AS ALERT-BOX.*/
    END.  /*sic_bran.uwm100*/

    RUN wgw\wgwqmprm(INPUT TABLE tt_uwd132).
    
END.
ELSE IF nv_polcamp <> "" AND nv_mode = "update" THEN DO:
    FIND LAST sic_bran.uwm100 WHERE sic_bran.uwm100.policy  =  nv_policy  NO-WAIT NO-ERROR.
    IF AVAIL sic_bran.uwm100 THEN DO:
        FIND LAST sic_bran.uwm130 WHERE sic_bran.uwm130.policy  = sic_bran.uwm100.policy NO-WAIT NO-ERROR.
        IF AVAIL sic_bran.uwm130 THEN DO:
            ASSIGN 
                sic_bran.uwm130.uom1_v  = deci(nv_uom1_v)       
                sic_bran.uwm130.uom2_v  = deci(nv_uom2_v)       
                sic_bran.uwm130.uom5_v  = deci(nv_uom5_v)   
                . 

            IF prv_covcod = "3.2" OR prv_covcod = "3.1" THEN DO:
                ASSIGN
                    sic_bran.uwm130.uom6_v  = deci(prv_uom6_v)
                    sic_bran.uwm130.uom7_v  =  0.
            END.
            ELSE IF prv_covcod = "2" THEN DO:
                ASSIGN
                    sic_bran.uwm130.uom6_v  =  0
                    sic_bran.uwm130.uom7_v  = deci(prv_uom6_v).
            END.
            ELSE IF prv_covcod = "3" THEN DO:
                ASSIGN
                    sic_bran.uwm130.uom6_v  =  0
                    sic_bran.uwm130.uom7_v  =  0.
            END.
            ELSE DO:
                ASSIGN
                    sic_bran.uwm130.uom6_v  = deci(prv_uom6_v)
                    sic_bran.uwm130.uom7_v  = deci(prv_uom6_v).
            END.

            FIND LAST sic_bran.uwm301 WHERE sic_bran.uwm301.policy  = sic_bran.uwm100.policy NO-WAIT NO-ERROR.
            IF AVAIL sic_bran.uwm301 THEN sic_bran.uwm301.garage  = prv_garage.

            /*clear..sic_bran.uwd132. */
            FOR EACH stat.pmuwd132 USE-INDEX pmuwd13201 WHERE 
                stat.pmuwd132.campcd        = trim(nv_PromotionNumber)  AND
                TRIM(stat.pmuwd132.policy)  = TRIM(nv_polcamp)  NO-LOCK.
                FOR EACH  sic_bran.uwd132  USE-INDEX uwd13201 WHERE
                    sic_bran.uwd132.policy  = sic_bran.uwm100.policy  .
                    DELETE sic_bran.uwd132.
                END.
            END.
            /*clear..sic_bran.uwd132. */
            ASSIGN nv_bptr = 0      nv_gapprm   = 0     nv_pdprm    = 0 .
            FOR EACH stat.pmuwd132 USE-INDEX pmuwd13201 WHERE 
                stat.pmuwd132.campcd        = trim(nv_PromotionNumber)  AND
                TRIM(stat.pmuwd132.policy)  = TRIM(nv_polcamp)  NO-LOCK.
                
                FIND sic_bran.uwd132  USE-INDEX uwd13201 WHERE
                    sic_bran.uwd132.policy  = sic_bran.uwm100.policy AND
                    sic_bran.uwd132.rencnt  = sic_bran.uwm100.rencnt AND
                    sic_bran.uwd132.endcnt  = sic_bran.uwm100.endcnt AND
                    sic_bran.uwd132.riskgp  = sic_bran.uwm130.riskgp AND
                    sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno AND
                    sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno AND
                    sic_bran.uwd132.bchyr   = sic_bran.uwm100.bchyr  AND
                    sic_bran.uwd132.bchno   = sic_bran.uwm100.bchno  AND
                    sic_bran.uwd132.bchcnt  = sic_bran.uwm100.bchcnt AND 
                    sic_bran.uwd132.bencod  = stat.pmuwd132.bencod   NO-ERROR NO-WAIT.
                IF NOT AVAILABLE sic_bran.uwd132 THEN DO:
                    CREATE sic_bran.uwd132.
                    ASSIGN
                        sic_bran.uwd132.bencod  =  stat.pmuwd132.bencod 
                        sic_bran.uwd132.benvar  =  stat.pmuwd132.benvar 
                        sic_bran.uwd132.rate    =  stat.pmuwd132.rate                     
                        sic_bran.uwd132.gap_ae  =  NO                
                        sic_bran.uwd132.gap_c   =  stat.pmuwd132.gap_c                    
                        sic_bran.uwd132.dl1_c   =  stat.pmuwd132.dl1_c                    
                        sic_bran.uwd132.dl2_c   =  stat.pmuwd132.dl2_c                    
                        sic_bran.uwd132.dl3_c   =  stat.pmuwd132.dl3_c                    
                        sic_bran.uwd132.pd_aep  =  "E"                 
                        sic_bran.uwd132.prem_c  =  stat.pmuwd132.prem_c                   
                        sic_bran.uwd132.fptr    =  0                   
                        sic_bran.uwd132.bptr    =  nv_bptr                   
                        sic_bran.uwd132.policy  =  sic_bran.uwm100.policy 
                        sic_bran.uwd132.rencnt  =  sic_bran.uwm100.rencnt                    
                        sic_bran.uwd132.endcnt  =  sic_bran.uwm100.endcnt                    
                        sic_bran.uwd132.riskgp  =  sic_bran.uwm130.riskgp                 
                        sic_bran.uwd132.riskno  =  sic_bran.uwm130.riskno                 
                        sic_bran.uwd132.itemno  =  sic_bran.uwm130.itemno                 
                        sic_bran.uwd132.rateae  =  stat.pmuwd132.rateae                  
                        sic_bran.uwd132.bchyr   =  sic_bran.uwm100.bchyr               
                        sic_bran.uwd132.bchno   =  sic_bran.uwm100.bchno 
                        sic_bran.uwd132.bchcnt  =  sic_bran.uwm100.bchcnt.
                    nv_gapprm = nv_gapprm + stat.pmuwd132.gap_c .
                    nv_pdprm  = nv_pdprm  + stat.pmuwd132.prem_C. 
                    ASSIGN 
                        SUBSTRING(nv_sivar,1,30)   = "     Own Damage = "
                        SUBSTRING(nv_sivar,31,30)  = string(deci(prv_uom6_v))
                        SUBSTRING(nv_bipvar,1,30)  = "     BI per Person = "
                        SUBSTRING(nv_bipvar,31,30) = STRING(deci(nv_uom1_v))
                        SUBSTRING(nv_biavar,1,30)  = "     BI per Accident = "
                        SUBSTRING(nv_biavar,31,30) = STRING(deci(nv_uom2_v))
                        SUBSTRING(nv_pdavar,1,30)  = "     PD per Accident = "
                        SUBSTRING(nv_pdavar,31,30) = string(deci(nv_uom5_v))   
                        SUBSTRING(nv_411var,1,30)  =  "     PA Driver = "              
                        SUBSTRING(nv_411var,31,30) =   STRING(nv_mv411)                
                        SUBSTRING(nv_412var,1,30)  = "     PA Passengers = "           
                        SUBSTRING(nv_412var,31,30) =  STRING(nv_mv412)                 
                        SUBSTRING(nv_42var,1,30)   = "     Medical Expense = " 
                        SUBSTRING(nv_42var,31,30)  = STRING(nv_mv42)             
                        SUBSTRING(nv_43var,1,30)   = "     Airfrieght = " 
                        SUBSTRING(nv_43var,31,30)  =  STRING(nv_mv43 )    .
                    IF sic_bran.uwd132.bencod = "SI"  THEN ASSIGN sic_bran.uwd132.benvar = nv_sivar .
                    IF sic_bran.uwd132.bencod = "BI1" THEN ASSIGN sic_bran.uwd132.benvar = nv_bipvar.
                    IF sic_bran.uwd132.bencod = "BI2" THEN ASSIGN sic_bran.uwd132.benvar = nv_biavar.
                    IF sic_bran.uwd132.bencod = "PD"  THEN ASSIGN sic_bran.uwd132.benvar = nv_pdavar.
                    IF sic_bran.uwd132.bencod = "411" THEN ASSIGN sic_bran.uwd132.benvar = nv_411var.
                    IF sic_bran.uwd132.bencod = "412" THEN ASSIGN sic_bran.uwd132.benvar = nv_412var.
                    IF sic_bran.uwd132.bencod = "42"  THEN ASSIGN sic_bran.uwd132.benvar = nv_42var .
                    IF sic_bran.uwd132.bencod = "43"  THEN ASSIGN sic_bran.uwd132.benvar = nv_43var .
                    IF sic_bran.uwd132.bencod = "NCB"  THEN ASSIGN  nv_ncbper  = DECI(SUBSTRING(sic_bran.uwd132.benvar,31,30)). 
                    IF sic_bran.uwd132.bencod = "411"  THEN ASSIGN  nv_411t = stat.pmuwd132.prem_C  .  
                    IF sic_bran.uwd132.bencod = "412"  THEN ASSIGN  nv_412t = stat.pmuwd132.prem_C  . 
                    IF sic_bran.uwd132.bencod = "42"   THEN ASSIGN  nv_42t  = stat.pmuwd132.prem_C  .  
                    IF sic_bran.uwd132.bencod = "43"   THEN ASSIGN  nv_43t  = stat.pmuwd132.prem_C  .   
                    IF sic_bran.uwd132.bencod = "FLET" AND TRIM(stat.pmuwd132.benvar) = "" THEN DO:
                        ASSIGN sic_bran.uwd132.benvar = "     Fleet Discount %  =      10 " .
                    END.

                    

                    IF nv_bptr <> 0 THEN DO:
                        FIND wf_uwd132 WHERE RECID(wf_uwd132) = nv_bptr.
                        wf_uwd132.fptr = RECID(sic_bran.uwd132).
                    END.
                    IF nv_bptr = 0 THEN sic_bran.uwm130.fptr03  =  RECID(sic_bran.uwd132).
                    nv_bptr = RECID(sic_bran.uwd132).
                    /*MESSAGE nv_pdprm  inte(prv_uom6_v)  nv_gapprm VIEW-AS ALERT-BOX.*/
                END.    /*  sic_bran.uwd132   */
                sic_bran.uwm130.bptr03  =  nv_bptr. 
            END.    /*  FOR EACH stat.pmuwd132 ....*/
        END.        /*  sic_bran.uwm130 */
        /*MESSAGE nv_pdprm  inte(prv_uom6_v)  nv_gapprm VIEW-AS ALERT-BOX.*/
             
        DEF VAR nv_stamp_per  AS DECI INIT 0.
        DEF VAR nv_tax_per    AS DECI INIT 0.

        FIND sicsyac.xmm020 USE-INDEX xmm02001 WHERE sicsyac.xmm020.branch = sic_bran.uwm100.branch AND
                                                     sicsyac.xmm020.dir_ri = sic_bran.uwm100.dir_ri NO-LOCK NO-ERROR.
        IF AVAIL sicsyac.xmm020 THEN nv_stamp_per = sicsyac.xmm020.rvstam.

        ASSIGN 
            nv_tax_per   = sic_bran.uwm100.gstrat
            sic_bran.uwm100.prem_t = nv_pdprm  
            sic_bran.uwm100.sigr_p = inte(prv_uom6_v)
            sic_bran.uwm100.gap_p  = nv_gapprm.

        IF (((sic_bran.uwm100.prem_t * nv_stamp_per) / 100) - TRUNCATE(sic_bran.uwm100.prem_t * nv_stamp_per / 100,0)) > 0 THEN DO:
             sic_bran.uwm100.rstp_t  = TRUNCATE(sic_bran.uwm100.prem_t * nv_stamp_per / 100,0) + 1.
        END.
        ELSE sic_bran.uwm100.rstp_t  = TRUNCATE(sic_bran.uwm100.prem_t * nv_stamp_per / 100,0) .

        sic_bran.uwm100.rtax_t  = (sic_bran.uwm100.prem_t + sic_bran.uwm100.rstp_t + sic_bran.uwm100.pstp) * nv_tax_per  / 100.

        FIND LAST sic_bran.uwm120 WHERE sic_bran.uwm120.policy  = sic_bran.uwm100.policy NO-WAIT NO-ERROR.  
        IF AVAIL  sic_bran.uwm120 THEN DO:

            IF uwm120.com1p <> 0 THEN sic_bran.uwm100.com1_t = - (uwm100.prem_t * uwm120.com1p) / 100.
            

            ASSIGN
                sic_bran.uwm120.com1_r = sic_bran.uwm100.com1_t
                sic_bran.uwm120.com2_r = sic_bran.uwm100.com2_t
                sic_bran.uwm120.rtax_r = sic_bran.uwm100.rtax_t
                sic_bran.uwm120.rstp_r = sic_bran.uwm100.rstp_t
                sic_bran.uwm120.gap_r  = nv_gapprm
                sic_bran.uwm120.prem_r = nv_pdprm
                sic_bran.uwm120.sigr   = inte(prv_uom6_v).
        END.


    END.  /*sic_bran.uwm100*/
    RELEASE sic_bran.uwd132.
    RELEASE sic_bran.uwm100.
    RELEASE sic_bran.uwm130.
    RELEASE sic_bran.uwm301.
    RELEASE sic_bran.uwm120.

    OUTPUT TO VALUE(n_log) APPEND.
    PUT "Out. campaign: " TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3) SKIP
        " nv_PromotionNumberr  ="  nv_PromotionNumber FORMAT "X(40)"            SKIP               
        " prv_class            ="  prv_class          FORMAT "X(40)"            SKIP               
        " prv_covcod           ="  prv_covcod         FORMAT "X(50)"            SKIP               
//        " prv_vehgrp           :"  prv_vehgrp         FORMAT "X(50)"            SKIP               
        " prv_vehuse           :"  prv_vehuse         FORMAT "X(50)"            SKIP               
        " prv_garage           :"  prv_garage         FORMAT "X(50)"            SKIP               
        " prv_engine           :"  prv_engine         FORMAT ">>>>,>>>,>>9"     SKIP   
        " prv_yrmanu           :"  prv_yrmanu         FORMAT ">>>>,>>>,>>9"     SKIP   
        " prv_uom6_v           :"  prv_uom6_v         FORMAT ">>>>,>>>,>>9"     SKIP   
        " prv_WrittenAmt       :"  prv_WrittenAmt     FORMAT ">>>>,>>>,>>9.99"  SKIP  
        " prv_CurrentTermAmt   :"  prv_CurrentTermAmt FORMAT ">>>>,>>>,>>9.99"  SKIP  
        " prv__Brand           :"  prv__Brand         FORMAT "X(50)"            SKIP   
        " prv_Model            :"  prv_Model          FORMAT "X(50)"            SKIP   
        " nv_polcamp           :"  nv_polcamp         FORMAT "X(50)"            SKIP   
        " prv_dedod            :"  prv_dedod          FORMAT ">>>>,>>>,>>9"     SKIP   
        " prv_Ajbaseprm        :"  prv_Ajbaseprm      FORMAT ">>>>,>>>,>>9"     SKIP   
        " prv_basegapprm       :"  prv_basegapprm     FORMAT ">>>>,>>>,>>9"     SKIP   
        " nv_uom1_v            :"  nv_uom1_v          FORMAT ">>>>,>>>,>>9"     SKIP   
        " nv_uom2_v            :"  nv_uom2_v          FORMAT ">>>>,>>>,>>9"     SKIP   
        " nv_uom5_v            :"  nv_uom5_v          FORMAT ">>>>,>>>,>>9"     SKIP 
        "--------------------------------------------------" SKIP .
      OUTPUT CLOSE.
END.
ELSE DO: 
    prv_messe = "ไม่พบข้อมูล Campign ที่ตรงกัน" + CHR(10). 
    prv_messe = prv_messe + "โปรดตรวจสอบอิกครั้ง".
  //  prv_messe = prv_messe + "Campaign : " + STRING(nv_PromotionNumber) + CHR(10).
  //  prv_messe = prv_messe + "Class   : " + STRING(prv_class         ) + CHR(10).     
  //  prv_messe = prv_messe + "Covcod  : " + STRING(prv_covcod        ) + CHR(10).      
  //  prv_messe = prv_messe + "Vehuse  : " + STRING(prv_vehuse        ) + CHR(10).      
  //  prv_messe = prv_messe + "Garage  : " + STRING(prv_garage        ) + CHR(10).     
  //  prv_messe = prv_messe + n_textewg + " : " + STRING(prv_engstton)  + CHR(10).    
  //  prv_messe = prv_messe + "Car Year: " + STRING(nv_year           ) + CHR(10).    
  //  prv_messe = prv_messe + "Sum Insured  : " + STRING(prv_uom6_v        ) + CHR(10).
  //  prv_messe = prv_messe + "Gross Premium : " + STRING(prv_CurrentTermAmt) + " หรือ Net Premium :" + STRING(prv_WrittenAmt)  + CHR(10).
  //  prv_messe = prv_messe + "Brand   : " + STRING(prv__Brand        ) + CHR(10).  
  //  prv_messe = prv_messe + "Model   : " + STRING(prv_Model         ) + CHR(10).
END.

 

