/************************************************************************/
/* wgwrwr70.p   Change Risk - itemno (Motor)                            */
/* Copyright	: Safety Insurance Public Company Limited 				*/
/*			  บริษัท ประกันคุ้มภัย จำกัด (มหาชน)					    */
/* CREATE BY	: Chaiyong W.   ASSIGN A61-0016 21/05/2018              */
/************************************************************************/
/*Connect gw_safe -ld sic_bran,gw_stat -ld brstat,sicsyac               */


DEFINE INPUT PARAMETER nv_newpol  AS CHAR INIT "".
DEFiNE INPUT PARAMETER nv_bchyr   AS INT INIT 0.
DEFiNE INPUT PARAMETER nv_bchno   AS CHAR INIT "".
DEFiNE INPUT PARAMETER nv_bchcnt  AS INT INIT 0.


DEF VAR nv_riskno AS INT INIT 0.
DEF VAR nv_itemno AS INT INIT 0.
DEF VAR nv_fptr   AS RECID INIT ?.
DEF VAR nv_chkpol AS CHAR INIT "".
DEF VAR nv_chkpo2 AS CHAR INIT "". 
DEF VAR nv_nap    AS DECI INIT 0.
DEF VAR nv_gap    AS DECI INIT 0.
DEF VAR nv_napo   AS DECI INIT 0.
DEF VAR nv_gapo   AS DECI INIT 0.
DEF VAR n_com1_t  AS DECI INIT 0.
DEF VAR n_rtax_t  AS DECI INIT 0.
DEF VAR n_rstp_t  AS DECI INIT 0.
DEF VAR n_sigr_t  AS DECI INIT 0.

DEF VAR n_stamp_per AS DECI INIT 0.
DEF VAR n_tax_per    AS DECI INIT 0.
DEF VAR nv_r132      AS RECID INIT ?.
DEF VAR nv_st132     AS CHAR  INIT "".
DEF BUFFER buwd132   FOR sic_bran.uwd132.
DEF VAR nv_chkdspc   AS LOGICAL INIT NO.

FIND FIRST sic_Bran.uwm100 USE-INDEX uwm10001 WHERE
    uwm100.policy  = nv_newpol    AND
    uwm100.bchyr   = nv_bchyr     AND
    uwm100.bchno   = nv_bchno     AND
    uwm100.bchcnt  = nv_bchcnt      NO-ERROR NO-WAIT.
IF AVAIL uwm100 THEN DO:
    FIND sicsyac.xmm020 USE-INDEX xmm02001	     WHERE
         sicsyac.xmm020.branch = sic_bran.uwm100.branch AND
         sicsyac.xmm020.dir_ri = sic_bran.uwm100.dir_ri NO-LOCK NO-ERROR.
    IF AVAIL sicsyac.xmm020 THEN  DO:
        ASSIGN
            n_stamp_per = sicsyac.xmm020.rvstam
            n_tax_per   = sic_bran.uwm100.gstrat.
    END.
    ELSE  n_tax_per    = sic_bran.uwm100.gstrat.




    FOR EACH sic_bran.uwm120 USE-INDEX uwm12001 WHERE
        uwm120.policy = uwm100.policy AND
        uwm120.rencnt = uwm100.rencnt AND
        uwm120.endcnt = uwm100.endcnt AND
        uwm120.bchyr  = uwm100.bchyr  AND
        uwm120.bchno  = uwm100.bchno  AND
        uwm120.bchcnt = uwm100.bchcnt :
        ASSIGN
            nv_riskno =  nv_riskno + 1
            nv_itemno =  0
            nv_nap    =  0
            nv_gap    =  0 .

        FOR EACH sic_bran.uwm130 USE-INDEX uwm13001 WHERE
            uwm130.policy = uwm120.policy AND
            uwm130.rencnt = uwm120.rencnt AND
            uwm130.endcnt = uwm120.endcnt AND
            uwm130.riskgp = uwm120.riskgp AND
            uwm130.riskno = uwm120.riskno AND
            uwm130.bchyr  = uwm120.bchyr  AND
            uwm130.bchno  = uwm120.bchno  AND
            uwm130.bchcnt = uwm120.bchcnt :
            ASSIGN
                n_sigr_t  = n_sigr_t + uwm130.uom6_v
                nv_itemno = nv_itemno + 1
                nv_r132   = ?
                .
            IF nv_riskno <> uwm120.riskno OR nv_itemno <> uwm130.itemno  THEN DO:
                nv_fptr = uwm130.fptr01.
                REPEAT:
                    IF nv_fptr = 0 OR nv_fptr = ? THEN LEAVE.
                    FIND sic_bran.uwd130 WHERE RECID(uwd130) = nv_fptr NO-ERROR NO-WAIT.
                    IF AVAIL uwd130 THEN DO:
                        ASSIGN
                            uwd130.riskno = nv_riskno
                            uwd130.itemno = nv_itemno.
                        nv_fptr = uwd130.fptr.
                    END.
                    ELSE LEAVE.
                END.
                nv_fptr = uwm130.fptr02.
                REPEAT:
                    IF nv_fptr = 0 OR nv_fptr = ? THEN LEAVE.
                    FIND sic_bran.uwd131 WHERE RECID(uwd131) = nv_fptr NO-ERROR NO-WAIT.
                    IF AVAIL uwd131 THEN DO:
                        ASSIGN
                            uwd131.riskno = nv_riskno
                            uwd131.itemno = nv_itemno.
                        nv_fptr = uwd131.fptr.
                    END.
                    ELSE LEAVE.
                END.
                nv_fptr = uwm130.fptr03.
                REPEAT:
                    IF nv_fptr = 0 OR nv_fptr = ? THEN LEAVE.
                    FIND sic_bran.uwd132 WHERE RECID(uwd132) = nv_fptr NO-ERROR NO-WAIT.
                    IF AVAIL uwd132 THEN DO:
                        ASSIGN
                            uwd132.riskno = nv_riskno
                            uwd132.itemno = nv_itemno.
                        nv_fptr = uwd132.fptr.
                        IF sic_bran.uwd132.bencod = "comp" THEN DO: 
                            nv_r132       = RECID(uwd132).
                            
                        END.
                        ELSE DO:
                            ASSIGN
                                nv_nap = nv_nap  + uwd132.gap_C
                                nv_gap = nv_gap  + uwd132.prem_c.
                        END.
                        IF uwd132.bencod = "DSPC" THEN nv_chkdspc = YES.
                    END.
                    ELSE LEAVE.
                END.
                nv_fptr = uwm130.fptr04.
                REPEAT:
                    IF nv_fptr = 0 OR nv_fptr = ? THEN LEAVE.
                    FIND sic_bran.uwd134 WHERE RECID(uwd134) = nv_fptr NO-ERROR NO-WAIT.
                    IF AVAIL uwd134 THEN DO:
                        ASSIGN
                            uwd134.riskno = nv_riskno
                            uwd134.itemno = nv_itemno.
                        nv_fptr = uwd134.fptr.
                    END.
                    ELSE LEAVE.
                END.
                nv_fptr = uwm130.fptr05.
                REPEAT:
                    IF nv_fptr = 0 OR nv_fptr = ? THEN LEAVE.
                    FIND sic_bran.uwd136 WHERE RECID(uwd136) = nv_fptr NO-ERROR NO-WAIT.
                    IF AVAIL uwd136 THEN DO:
                        ASSIGN
                            uwd136.riskno = nv_riskno
                            uwd136.itemno = nv_itemno.
                        nv_fptr = uwd136.fptr.
                    END.
                    ELSE LEAVE.
                END.
                ASSIGN  
                    nv_chkpol  = ""
                    nv_chkpo2  = "".
                nv_chkpol  = TRIM(uwm130.policy) + STRING(uwm130.rencnt,"99") + STRING(uwm130.endcnt,"999")
                             + STRING(uwm130.riskno,"999") + STRING(uwm130.itemno,"999").
                nv_chkpo2  = TRIM(uwm130.policy) + STRING(uwm130.rencnt,"99") + STRING(uwm130.endcnt,"999")
                             + STRING(nv_riskno,"999") + STRING(nv_itemno,"999").
                FOR EACH brstat.mailtxt_fil WHERE mailtxt_fil.policy = nv_chkpol AND
                     mailtxt_fil.bchyr  = uwm120.bchyr     AND
                     mailtxt_fil.bchno  = uwm120.bchno     AND
                     mailtxt_fil.bchcnt = uwm120.bchcnt   :
                    mailtxt_fil.policy = nv_chkpo2.
                END.

                FIND FIRST  sic_bran.uwm301 USE-INDEX uwm30101 WHERE
                    uwm301.policy = uwm130.policy AND    
                    uwm301.rencnt = uwm130.rencnt AND    
                    uwm301.endcnt = uwm130.endcnt AND    
                    uwm301.riskgp = uwm130.riskgp AND 
                    uwm301.riskno = uwm130.riskno AND
                    uwm301.itemno = uwm130.itemno AND
                    uwm301.bchyr  = uwm130.bchyr  AND    
                    uwm301.bchno  = uwm130.bchno  AND    
                    uwm301.bchcnt = uwm130.bchcnt NO-ERROR NO-WAIT .  
                IF AVAIL uwm301 THEN DO:

                    
                    FIND FIRST sicsyac.xmm104 USE-INDEX xmm10401 WHERE
                               sicsyac.xmm104.tariff = "X"           AND
                               sicsyac.xmm104.class  = uwm120.CLASS  AND
                               sicsyac.xmm104.covcod = uwm301.covcod AND
                               sicsyac.xmm104.ncbyrs = uwm301.ncbyrs  NO-LOCK NO-ERROR.
                    IF AVAIL sicsyac.xmm104 THEN uwm301.ncbper = sicsyac.xmm104.ncbper.  /*  uwm301.ncbyrs = sicsyac.xmm104.ncbyrs*/

                    ASSIGN
                       uwm301.riskno  = nv_riskno
                       uwm301.itemno  = nv_itemno.
                END.
                ASSIGN
                    uwm130.riskno  = nv_riskno
                    uwm130.itemno  = nv_itemno.
            END.
            ELSE DO:
                nv_fptr = uwm130.fptr03.
                REPEAT:
                    IF nv_fptr = 0 OR nv_fptr = ? THEN LEAVE.
                    FIND sic_bran.uwd132 WHERE RECID(uwd132) = nv_fptr NO-ERROR NO-WAIT.
                    IF AVAIL uwd132 THEN DO:
                        ASSIGN
                            uwd132.riskno = nv_riskno
                            uwd132.itemno = nv_itemno.
                        nv_fptr = uwd132.fptr.
                        IF sic_bran.uwd132.bencod = "comp" THEN DO: 
                            nv_r132       = RECID(uwd132).
                        END.
                        ELSE DO:
                            ASSIGN
                                nv_nap = nv_nap  + uwd132.gap_C
                                nv_gap = nv_gap  + uwd132.prem_c.
                        END.
                        IF uwd132.bencod = "DSPC" THEN nv_chkdspc = YES.
                       
                    END.
                    ELSE LEAVE.
                END.
                FIND FIRST  sic_bran.uwm301 USE-INDEX uwm30101 WHERE
                    uwm301.policy = uwm130.policy AND    
                    uwm301.rencnt = uwm130.rencnt AND    
                    uwm301.endcnt = uwm130.endcnt AND    
                    uwm301.riskgp = uwm130.riskgp AND 
                    uwm301.riskno = uwm130.riskno AND
                    uwm301.itemno = uwm130.itemno AND
                    uwm301.bchyr  = uwm130.bchyr  AND    
                    uwm301.bchno  = uwm130.bchno  AND    
                    uwm301.bchcnt = uwm130.bchcnt NO-ERROR NO-WAIT .  
                IF AVAIL uwm301 THEN DO:
                    FIND FIRST sicsyac.xmm104 USE-INDEX xmm10401 WHERE
                               sicsyac.xmm104.tariff = "X"           AND
                               sicsyac.xmm104.class  = uwm120.CLASS  AND
                               sicsyac.xmm104.covcod = uwm301.covcod AND
                               sicsyac.xmm104.ncbyrs = uwm301.ncbyrs  NO-LOCK NO-ERROR.
                    IF AVAIL sicsyac.xmm104 THEN uwm301.ncbper = sicsyac.xmm104.ncbper.  /*  uwm301.ncbyrs = sicsyac.xmm104.ncbyrs*/
                END.


            END.
            /*---Compulsory*/
            ASSIGN 
                uwm130.uom8_v = 0
                uwm130.uom9_v = 0
                
                nv_st132      = "".


            IF nv_r132 <> 0 THEN DO:
                FIND sic_bran.uwd132 WHERE RECID(uwd132) = nv_r132  NO-ERROR NO-WAIT.
                IF AVAIL uwd132 THEN DO:
                    IF uwd132.fptr = 0 THEN DO:
                        uwm130.bptr03 = uwd132.bptr.
                        FIND buwd132 WHERE RECID(buwd132) = uwd132.bptr NO-ERROR NO-WAIT.
                        IF AVAIL buwd132 THEN buwd132.fptr = 0.
                    END.
                    ELSE IF uwd132.bptr = 0 THEN DO:
                        uwm130.fptr03 = uwd132.fptr.
                        FIND buwd132 WHERE RECID(buwd132) = uwd132.fptr NO-ERROR NO-WAIT.
                        IF AVAIL buwd132 THEN buwd132.bptr = 0.
                    END.
                    ELSE DO:
                        FIND buwd132 WHERE RECID(buwd132) = uwd132.fptr NO-ERROR NO-WAIT.
                        IF AVAIL buwd132 THEN buwd132.fptr = uwd132.bptr.
                        FIND buwd132 WHERE RECID(buwd132) = uwd132.bptr NO-ERROR NO-WAIT.
                        IF AVAIL buwd132 THEN buwd132.bptr = uwd132.fptr.
                    END.
                    DELETE uwd132.
                END.
            END.
            /*Compulsory------*/





        END.
        IF nv_riskno <> uwm120.riskno THEN DO:
            nv_fptr = uwm120.fptr01.
            REPEAT:
                IF nv_fptr = 0 OR nv_fptr = ? THEN LEAVE.
                FIND sic_bran.uwd120 WHERE RECID(uwd120) = nv_fptr NO-ERROR NO-WAIT.
                IF AVAIL uwd120 THEN DO:
                    ASSIGN
                        uwd120.riskno = nv_riskno .
                    nv_fptr = uwd120.fptr.
                END.
                ELSE LEAVE.
            END.
            nv_fptr = uwm120.fptr02.
            REPEAT:
                IF nv_fptr = 0 OR nv_fptr = ? THEN LEAVE.
                FIND sic_bran.uwd121 WHERE RECID(uwd121) = nv_fptr NO-ERROR NO-WAIT.
                IF AVAIL uwd121 THEN DO:
                    ASSIGN
                        uwd121.riskno = nv_riskno.
                    nv_fptr = uwd121.fptr.
                END.
                ELSE LEAVE.
            END.
            nv_fptr = uwm120.fptr03.
            REPEAT:
                IF nv_fptr = 0 OR nv_fptr = ? THEN LEAVE.
                FIND sic_bran.uwd123 WHERE RECID(uwd123) = nv_fptr NO-ERROR NO-WAIT.
                IF AVAIL uwd123 THEN DO:
                    ASSIGN
                        uwd123.riskno = nv_riskno.
                    nv_fptr = uwd123.fptr.
                END.
                ELSE LEAVE.
            END.
            nv_fptr = uwm120.fptr08.
            REPEAT:
                IF nv_fptr = 0 OR nv_fptr = ? THEN LEAVE.
                FIND sic_bran.uwd124 WHERE RECID(uwd124) = nv_fptr NO-ERROR NO-WAIT.
                IF AVAIL uwd124 THEN DO:
                    ASSIGN
                        uwd124.riskno = nv_riskno.
                    nv_fptr = uwd124.fptr.
                END.
                ELSE LEAVE.
            END.
            nv_fptr = uwm120.fptr04.
            REPEAT:
                IF nv_fptr = 0 OR nv_fptr = ? THEN LEAVE.
                FIND sic_bran.uwd125 WHERE RECID(uwd125) = nv_fptr NO-ERROR NO-WAIT.
                IF AVAIL uwd125 THEN DO:
                    ASSIGN
                        uwd125.riskno = nv_riskno.
                    nv_fptr = uwd125.fptr.
                END.
                ELSE LEAVE.
            END.
            nv_fptr = uwm120.fptr09.
            REPEAT:
                IF nv_fptr = 0 OR nv_fptr = ? THEN LEAVE.
                FIND sic_bran.uwd126 WHERE RECID(uwd126) = nv_fptr NO-ERROR NO-WAIT.
                IF AVAIL uwd126 THEN DO:
                    ASSIGN
                        uwd126.riskno = nv_riskno.
                    nv_fptr = uwd126.fptr.
                END.
                ELSE LEAVE.
            END.  
            
        END.
        ASSIGN
            uwm120.com2p  = 0   /*% commission compulsory*/
            uwm120.com2_r = 0   /*Baht commission compulsory*/
            uwm120.riskno = nv_riskno
            uwm120.gap_r  = nv_nap
            uwm120.prem_r = nv_gap
            nv_napo       = nv_napo + nv_nap
            nv_gapo       = nv_gapo + nv_gap.
        /*---
         {uw/uwo09805.i "uwd140" "Fire Risk Location Text" "uwm304" "uwm30401" "fptr01" }
        {uw/uwo09805.i "uwd141" "Fire Risk Block Numbers" "uwm304" "uwm30401" "fptr02"}
        {uw/uwo09805.i "uwd200" "RI Out Premium "  "uwm200" "uwm20001" "fptr01"}
        {uw/uwo09805.i "uwd201" "RI Application Text"  "uwm200" "uwm20001" "fptr02" }
        {uw/uwo09805.i "uwd202" "RI Application Endorsement Text" "uwm200" "uwm20001" "fptr03"}

        {uw/uwo09803.i "uwm100" "use-index uwm10001" "Policy Header" }
        {uw/uwo09803.i "uwm101" "use-index uwm10101" "Premium Billing Instalments" }
        {uw/uwo09803.i "uwm110" "use-index uwm11001" "Risk Group Header" }
        {uw/uwo09803.i "uwm120" "use-index uwm12001" "Risk Header"  }
        {uw/uwo09803.i "uwm200" "use-index uwm20001" "RI Out Header"}
        {uw/uwo09803.i "uwm300" "use-index uwm30001" "Cargo Risk Details" }
        {uw/uwo09803.i "uwm301" "use-index uwm30101" "Motor Vehicle" }
        {uw/uwo09803.i "uwm303" "use-index uwm30301" "Hull Risk" }
        {uw/uwo09803.i "uwm304" "use-index uwm30401" "Fire Risk" }
        {uw/uwo09803.i "uwm305" "use-index uwm30501" "Bond Risk" }
        {uw/uwo09803.i "uwm307" "use-index uwm30701" "Personal Accident" }
        -*/
    END.
            
 

    FIND FIRST sic_bran.uwm120 USE-INDEX uwm12001 WHERE
               uwm120.policy = uwm100.policy AND
               uwm120.rencnt = uwm100.rencnt AND
               uwm120.endcnt = uwm100.endcnt AND
               uwm120.bchyr  = uwm100.bchyr  AND
               uwm120.bchno  = uwm100.bchno  AND
               uwm120.bchcnt = uwm100.bchcnt NO-ERROR NO-WAIT.
    IF AVAIL uwm120 THEN DO:
        /*--
        IF nv_chkdspc = YES THEN DO:
            FIND FIRST sic_bran.uwd132  WHERE
               uwd132.policy = uwm100.policy AND
               uwd132.rencnt = uwm100.rencnt AND
               uwd132.endcnt = uwm100.endcnt AND
               uwd132.bchyr  = uwm100.bchyr  AND
               uwd132.bchno  = uwm100.bchno  AND
               uwd132.bchcnt = uwm100.bchcnt AND 
               uwd132.bencod = "DSPC" NO-LOCK  NO-ERROR NO-WAIT.
            IF NOT AVAIL uwd132 THEN nv_chkdspc = NO.
                       

        END. */


        IF nv_chkdspc = NO THEN DO: /*Special For NTL*/
            FIND sicsyac.xmm031  USE-INDEX xmm03101  WHERE
                sicsyac.xmm031.poltyp = sic_bran.uwm100.poltyp NO-LOCK NO-ERROR NO-WAIT.
            IF AVAILABLE sicsyac.xmm031 THEN  sic_bran.uwm120.com1p = sicsyac.xmm031.comm1.
        END. /*Special For NTL*/
        /*MESSAGE uwm100.policy  SKIP nv_gapo SKIP uwm120.com1p  "TEST". */
        n_com1_t  = nv_gapo * uwm120.com1p / 100 * 1-.   
        IF sic_bran.uwm100.rstp_t = 0 THEN n_rstp_t = 0.
        ELSE DO:
             n_rstp_t  =  TRUNCATE(nv_gapo  * n_stamp_per / 100,0) +
                    (IF (nv_gapo  * n_stamp_per / 100) -
                     TRUNCATE(nv_gapo  * n_stamp_per / 100,0) > 0
                     THEN 1 ELSE 0).
        END.
        n_rtax_t  = (nv_gapo  + n_rstp_t) * n_tax_per / 100.
        ASSIGN
            sic_bran.uwm120.com1_r =  n_com1_t
            sic_bran.uwm120.rtax_r =  n_rtax_t
            sic_bran.uwm120.rstp_r =  n_rstp_t .

    END.
    ASSIGN
        sic_bran.uwm100.com2_t        = 0    /*commission compulsory*/
        sic_bran.uwm100.com1_t        = n_com1_t
        sic_bran.uwm100.rstp_t        = n_rstp_t
        sic_bran.uwm100.rtax_t        = n_rtax_t
        sic_bran.uwm100.sigr_p        = n_sigr_t
        sic_bran.uwm100.gap_p         = nv_napo
        sic_bran.uwm100.prem_t        = nv_gapo.

END.  /*uwm130 */

RELEASE sic_bran.uwm301.
RELEASE sic_bran.uwm130.
RELEASE sic_bran.uwm120.
RELEASE sic_bran.uwm100.
