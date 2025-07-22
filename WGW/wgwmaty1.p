/* WGWMATC1.P     : Program Matching Chassis No.                         */  
/* Copyright      # Safety Insurance Public Company Limited              */  
/*                  บริษัท ประกันคุ้มภัย จำกัด (มหาชน)                   */  
/*Copy Program id : WGWMATCH.P                                           */  
/* WRITE  by      : Kridtiya i.  [A56-0119 : 14/05/2013]                 */  
/*                  โปรแกรม Matching Chassis No. และ Group Producer code */  
/*Modify          : Kridtiya i. A57-0291 date. 15/08/2014 
                    เพิ่มการให้ค่าทุนประกัน จากเดิม ใช้ ป 1,ป 2          */ 
/*Modify          : Kridtiya i. A58-0121 date. 22/03/2015 add tax+stmp   */ 
/* Modify by   : Ranu I. A65-0115 แก้ไขการออกรายงานเฉพาะงานที่ Release แล้ว 
                 แก้ไข Format ตาม AYCAL                                 */                                    
/*---------------------------------------------------------------------- */  
DEF SHARED VAR nv_bchyr     AS INT.
DEF SHARED VAR nv_bchno     AS CHAR.
DEF SHARED VAR nv_bchcnt    AS INT.
DEF SHARED VAR nv_compcnt   AS INT.
DEF SHARED VAR nv_ncompcnt  AS INT.
DEF SHARED VAR nv_outagent2 AS CHAR.  
DEF VAR nv_comdat           AS CHAR.
DEF VAR nv_expdat           AS CHAR.
DEF VAR nv_date             AS DATE.
DEF VAR nv_si               AS CHAR.
DEF BUFFER buwm100 FOR sicuw.uwm100. 
DEF VAR nv_prem             AS DECI.
DEF VAR nv_rstp_t           AS DECI.
DEF VAR nv_rtax_t           AS DECI.
DEF VAR nv_prem_n           AS DECI FORMAT ">>>,>>>,>>9.99".
DEF VAR nv_prem_taxstm      AS DECI FORMAT ">>>,>>>,>>9.99".  /*A58-0121*/
DEF VAR nv_premtot_n        AS DECI FORMAT ">>>,>>>,>>9.99".
DEF VAR nv_si_n             AS DECI FORMAT ">>>,>>>,>>9.99".
DEF VAR nv_name             AS CHAR . 
DEF VAR nv_acno             AS CHAR . 
DEF VAR nv_mon              AS CHAR FORMAT "X(2)". 
DEF VAR nv_yea              AS CHAR FORMAT "X(4)". 
DEF VAR nv_dat              AS CHAR FORMAT "X(2)". 
DEF VAR nv_mon1             AS CHAR FORMAT "X(2)". 
DEF VAR nv_yea1             AS CHAR FORMAT "X(4)". 
DEF VAR nv_dat1             AS CHAR FORMAT "X(2)". 
DEF VAR nv_i                AS INT.    
DEF VAR nv_policyno         AS CHAR.   
DEF VAR nv_l                AS INT.    
DEF VAR nv_p                AS CHAR.   
DEF VAR ind                 AS INT.    
DEF VAR nv_agentgpstmt      AS CHAR  .
ASSIGN nv_compcnt  = 0
    nv_ncompcnt    = 0
    nv_agentgpstmt = "" .
FOR EACH  sicsyac.xmm600 USE-INDEX xmm60009    WHERE 
    sicsyac.xmm600.gpstmt = TRIM(nv_outagent2) NO-LOCK .
    ASSIGN nv_agentgpstmt = nv_agentgpstmt  + sicsyac.xmm600.acno + ", " . 
END.
IF nv_outagent2 <> "" THEN DO:    /*by Group Producer code */

    ASSIGN nv_agentgpstmt = nv_agentgpstmt  + "A0MF29TLT0" + "," + "B3M4410273". /* A65-0115*/

    FOR EACH aycldeto2_fil USE-INDEX aycldeti02 WHERE 
        aycldeto2_fil.bchyr   =  nv_bchyr       AND
        aycldeto2_fil.bchno   =  nv_bchno       AND
        aycldeto2_fil.bchcnt  =  nv_bchcnt      AND
        (aycldeto2_fil.rectyp <> "H"            AND   
         aycldeto2_fil.rectyp <> "T" )          :   
        ASSIGN nv_prem  = 0 
            nv_rstp_t   = 0
            nv_rtax_t   = 0
            nv_dat      = ""  
            nv_mon      = ""  
            nv_yea      = ""
            nv_policyno = trim(aycldeto2_fil.notify)   
            nv_i        = 0                                  
            nv_l        = LENGTH(nv_policyno).  
        DO WHILE nv_i <= nv_l:
            ind = 0.
            ind = INDEX(nv_policyno,"/").
            IF ind <> 0 THEN DO:
                nv_policyno = TRIM (SUBSTRING(nv_policyno,1,ind - 1) + SUBSTRING(nv_policyno,ind + 1, nv_l)).
            END.
            ind = INDEX(nv_policyno,"\").
            IF ind <> 0 THEN DO:
                nv_policyno = TRIM (SUBSTRING(nv_policyno,1,ind - 1) + SUBSTRING(nv_policyno,ind + 1, nv_l)).
            END.
            ind = INDEX(nv_policyno,"-").
            IF ind <> 0 THEN DO:
                nv_policyno = TRIM (SUBSTRING(nv_policyno,1,ind - 1) + SUBSTRING(nv_policyno,ind + 1, nv_l)).
            END.
            ind = INDEX(nv_policyno," ").
            IF ind <> 0 THEN DO:
                nv_policyno = TRIM (SUBSTRING(nv_policyno,1,ind - 1) + SUBSTRING(nv_policyno,ind + 1, nv_l)).
            END.
            nv_i = nv_i + 1.
        END.
        FIND LAST sicuw.uwm100 USE-INDEX uwm10001  WHERE sicuw.uwm100.policy  = nv_policyno     AND
            sicuw.uwm100.releas  = YES             AND 
            INDEX(nv_agentgpstmt,TRIM(sicuw.uwm100.acno1)) <> 0 NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN DO:  
            FIND LAST sicuw.uwm301 USE-INDEX uwm30103                 WHERE
                sicuw.uwm301.trareg             = aycldeto2_fil.cha_no AND 
                sicuw.uwm301.policy             = nv_policyno         AND 
                SUBSTR(sicuw.uwm301.policy,3,2) = "70"                NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL uwm301 THEN DO:   /*เช็ค chasis และ policy ตรงกัน ให้ส่งข้อมูลได้ (ตามเงื่อนไขข้อ 1)*/
                FIND LAST sicuw.uwm100 USE-INDEX uwm10001     WHERE 
                    sicuw.uwm100.policy = sicuw.uwm301.policy AND 
                    sicuw.uwm100.rencnt = sicuw.uwm301.rencnt AND
                    sicuw.uwm100.endcnt = sicuw.uwm301.endcnt AND 
                    sicuw.uwm100.releas = YES                 NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL uwm100 THEN DO:
                    ASSIGN nv_dat = STRING(DAY(sicuw.uwm100.comdat),"99")
                        nv_mon    = STRING(MONTH(sicuw.uwm100.comdat),"99")
                        nv_yea    = STRING(YEAR(sicuw.uwm100.comdat) + 543 , "9999")
                        nv_dat1   = STRING(DAY(sicuw.uwm100.expdat),"99")
                        nv_mon1   = STRING(MONTH(sicuw.uwm100.expdat),"99")
                        nv_yea1   = STRING(YEAR(sicuw.uwm100.expdat) + 543 , "9999")
                        nv_comdat = SUBSTRING(nv_yea,3,2) + nv_mon + nv_dat 
                        nv_expdat = SUBSTRING(nv_yea1,3,2) + nv_mon1 + nv_dat1.
                    IF (SUBSTR(aycldeto2_fil.comdat,1,2) = SUBSTR(nv_comdat,1,2)) OR 
                        (aycldeto2_fil.comdat = "000000") THEN DO:   /*เช็คปีต้องเท่ากับไฟล์ที่ส่งมา หรือถ้าเป็นค่าว่างให้ส่งค่ากลับไป*/
                        ASSIGN aycldeto2_fil.policy  = CAPS(sicuw.uwm100.policy)
                            aycldeto2_fil.comdat     = nv_comdat
                            aycldeto2_fil.expdat     = nv_expdat .
                        FOR EACH sicuw.uwm100 USE-INDEX uwm10091       WHERE 
                            sicuw.uwm100.releas = YES                  AND
                            sicuw.uwm100.policy = sicuw.uwm301.policy  NO-LOCK.
                            ASSIGN nv_prem   = nv_prem   + sicuw.uwm100.prem_t
                                nv_rstp_t = nv_rstp_t + sicuw.uwm100.rstp_t
                                nv_rtax_t = nv_rtax_t + sicuw.uwm100.rtax_t.
                        END.
                        ASSIGN aycldeto2_fil.prem = TRIM(REPLACE(STRING(nv_prem,">>>>>>>>>>>>9.99"),".",""))
                            aycldeto2_fil.premtax = TRIM(REPLACE(STRING(nv_rstp_t + nv_rtax_t,">>>>>>>>>>>>9.99"),".","")) /*A58-0121*/
                            aycldeto2_fil.insrayrno = "การประกันภัยรถยนต์(ภาคสมัครใจ)"  /*A58-0121*/
                            aycldeto2_fil.premtot = TRIM(REPLACE(STRING(nv_prem + nv_rstp_t + nv_rtax_t,">>>>>>>>>>>>9.99"),".","")).
                        FIND LAST sicuw.uwm130 USE-INDEX uwm13001  WHERE 
                            sicuw.uwm130.policy = sicuw.uwm301.policy AND
                            sicuw.uwm130.rencnt = sicuw.uwm301.rencnt AND
                            sicuw.uwm130.endcnt = sicuw.uwm301.endcnt AND
                            sicuw.uwm130.riskgp = sicuw.uwm301.riskgp AND
                            sicuw.uwm130.riskno = sicuw.uwm301.riskno AND
                            sicuw.uwm130.itemno = sicuw.uwm301.itemno NO-LOCK NO-ERROR NO-WAIT.
                        IF AVAIL uwm130 THEN DO:
                            IF sicuw.uwm301.covcod = "1"      THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                            ELSE IF sicuw.uwm301.covcod = "2" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom7_v,">>>>>>>>>>>>9.99"),".","").
                            ELSE IF sicuw.uwm301.covcod = "2.1" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                            ELSE DO: 
                                /*A57-0291*/
                                IF      sicuw.uwm130.uom6_v <> 0 THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                ELSE IF sicuw.uwm130.uom7_v <> 0 THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom7_v,">>>>>>>>>>>>9.99"),".","").
                                ELSE nv_si = "000000000000000". 
                                /*A57-0291*/
                            END.
                            aycldeto2_fil.si      = TRIM(STRING(nv_si)).
                            /* add by : A65-0115 */
                            FIND FIRST  sicuw.uwm120 USE-INDEX uwm12001        WHERE
                                  sicuw.uwm120.policy  = sicuw.uwm130.policy   AND
                                  sicuw.uwm120.rencnt  = sicuw.uwm130.rencnt   AND
                                  sicuw.uwm120.endcnt  = sicuw.uwm130.endcnt   and
                                  sicuw.uwm120.riskgp  = sicuw.uwm130.riskgp   and
                                  sicuw.uwm120.riskno  = sicuw.uwm130.riskno   NO-LOCK NO-ERROR NO-WAIT.
                                 IF AVAIL sicuw.uwm120 THEN DO:
                                    IF SUBSTR(sicuw.uwm120.class,5,1) = "E" THEN  ASSIGN aycldeto2_fil.textchar2 = "E" .
                                 END.
                            /*..end A65-0115..*/
                        END.     /* Avail uwm130 */
                        nv_compcnt = nv_compcnt + 1.    /* record found count */
                    END.
                    ELSE DO:
                        ASSIGN nv_ncompcnt = nv_ncompcnt + 1       /* record not found count */
                            aycldeto2_fil.remark = "ปีที่คุ้มครองไม่ตรง" 
                            SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm100.policy. 
                    END.
                END.        /* Avail uwm100 */    
                ELSE DO:    /*--if not avail uwm100--*/
                    FIND LAST sicuw.uwm100 USE-INDEX uwm10091      WHERE 
                        sicuw.uwm100.releas = YES                  AND
                        sicuw.uwm100.policy = sicuw.uwm301.policy  NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAIL sicuw.uwm100 THEN DO:
                        FIND LAST sicuw.uwm301 USE-INDEX uwm30101 WHERE 
                            sicuw.uwm301.policy = sicuw.uwm100.policy AND
                            sicuw.uwm301.rencnt = sicuw.uwm100.rencnt AND
                            sicuw.uwm301.endcnt = sicuw.uwm100.endcnt NO-LOCK NO-ERROR NO-WAIT.
                        IF AVAIL sicuw.uwm301 THEN DO:
                            IF sicuw.uwm301.trareg = aycldeto2_fil.cha_no THEN DO: /*ย้อนมาเช็คเลขตัวถังรถว่าตรงกันหรือไม่*/
                                ASSIGN nv_dat = STRING(DAY(sicuw.uwm100.comdat),"99")
                                nv_mon    = STRING(MONTH(sicuw.uwm100.comdat),"99")
                                nv_yea    = STRING(YEAR(sicuw.uwm100.comdat) + 543 , "9999")
                                nv_dat1   = STRING(DAY(sicuw.uwm100.expdat),"99")
                                nv_mon1   = STRING(MONTH(sicuw.uwm100.expdat),"99")
                                nv_yea1   = STRING(YEAR(sicuw.uwm100.expdat) + 543 , "9999") 
                                nv_comdat = SUBSTRING(nv_yea,3,2) + nv_mon + nv_dat 
                                nv_expdat = SUBSTRING(nv_yea1,3,2) + nv_mon1 + nv_dat1.
                                IF (SUBSTR(aycldeto2_fil.comdat,1,2) = SUBSTR(nv_comdat,1,2)) OR (aycldeto2_fil.comdat = "000000") THEN DO: /*เช็คปีต้องเท่ากับไฟล์ที่ส่งมา หรือถ้าเป็นค่าว่างให้ส่งค่ากลับไป*/
                                    ASSIGN aycldeto2_fil.policy  = CAPS(sicuw.uwm100.policy)
                                    aycldeto2_fil.comdat  = nv_comdat
                                    aycldeto2_fil.expdat  = nv_expdat .
                                    FOR EACH sicuw.uwm100 USE-INDEX uwm10091      WHERE 
                                        sicuw.uwm100.releas = YES                 AND
                                        sicuw.uwm100.policy = sicuw.uwm301.policy NO-LOCK.  /*คำนวณเบี้ย*/
                                        ASSIGN
                                            nv_prem   = nv_prem   + sicuw.uwm100.prem_t
                                            nv_rstp_t = nv_rstp_t + sicuw.uwm100.rstp_t
                                            nv_rtax_t = nv_rtax_t + sicuw.uwm100.rtax_t.
                                    END.
                                    ASSIGN                                             
                                        aycldeto2_fil.prem    = TRIM(REPLACE(STRING(nv_prem,">>>>>>>>>>>>9.99"),".",""))
                                        aycldeto2_fil.premtax = TRIM(REPLACE(STRING(nv_rstp_t + nv_rtax_t,">>>>>>>>>>>>9.99"),".","")) /*A58-0121*/
                                        aycldeto2_fil.insrayrno = "การประกันภัยรถยนต์(ภาคสมัครใจ)"  /*A58-0121*/
                                        aycldeto2_fil.premtot = TRIM(REPLACE(STRING(nv_prem + nv_rstp_t + nv_rtax_t,">>>>>>>>>>>>9.99"),".","")).
                                    FIND LAST sicuw.uwm130 USE-INDEX uwm13001     WHERE 
                                        sicuw.uwm130.policy = sicuw.uwm301.policy AND
                                        sicuw.uwm130.rencnt = sicuw.uwm301.rencnt AND
                                        sicuw.uwm130.endcnt = sicuw.uwm301.endcnt AND
                                        sicuw.uwm130.riskgp = sicuw.uwm301.riskgp AND
                                        sicuw.uwm130.riskno = sicuw.uwm301.riskno AND
                                        sicuw.uwm130.itemno = sicuw.uwm301.itemno NO-LOCK NO-ERROR NO-WAIT.
                                    IF AVAIL uwm130 THEN DO:
                                        IF sicuw.uwm301.covcod = "1" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                        ELSE IF sicuw.uwm301.covcod = "2" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom7_v,">>>>>>>>>>>>9.99"),".","").
                                        ELSE IF sicuw.uwm301.covcod = "2.1" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                        ELSE DO: 
                                            /* A57-0291 */
                                            IF      sicuw.uwm130.uom6_v <> 0 THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                            ELSE IF sicuw.uwm130.uom7_v <> 0 THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom7_v,">>>>>>>>>>>>9.99"),".","").
                                            ELSE nv_si = "000000000000000". 
                                            /* A57-0291 */
                                        END.
                                        aycldeto2_fil.si  = TRIM(STRING(nv_si)).

                                        /* add by : A65-0115 */
                                        FIND FIRST  sicuw.uwm120 USE-INDEX uwm12001        WHERE
                                              sicuw.uwm120.policy  = sicuw.uwm130.policy   AND
                                              sicuw.uwm120.rencnt  = sicuw.uwm130.rencnt   AND
                                              sicuw.uwm120.endcnt  = sicuw.uwm130.endcnt   and
                                              sicuw.uwm120.riskgp  = sicuw.uwm130.riskgp   and
                                              sicuw.uwm120.riskno  = sicuw.uwm130.riskno   NO-LOCK NO-ERROR NO-WAIT.
                                             IF AVAIL sicuw.uwm120 THEN DO:
                                                IF SUBSTR(sicuw.uwm120.class,5,1) = "E" THEN  ASSIGN aycldeto2_fil.textchar2 = "E" .
                                             END.
                                        /*..end A65-0115..*/

                                    END.     /* Avail uwm130 */
                                    nv_compcnt = nv_compcnt + 1.      /* record found count */
                                END.    /*IF (SUBSTR(aycldeto2_fil.comdat,1,2) = SUBSTR(nv_comdat,1,2)) OR aycldeto2_fil.comdat = "000000" THEN DO:*/
                                ELSE DO:
                                    ASSIGN nv_ncompcnt = nv_ncompcnt + 1    /* record not found count */
                                        aycldeto2_fil.remark = "ปีที่คุ้มครองไม่ตรง" 
                                        SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm301.policy. 
                                END.
                            END.        /*--if sicuw.uwm301.trareg = aycldeto2_fil.cha_no--*/
                            ELSE DO:    /*เลขตัวถังรถไม่ตรงกัน*/
                                ASSIGN nv_ncompcnt  = nv_ncompcnt + 1    /* record not found count */
                                aycldeto2_fil.remark = "Not Found Policy permitt Chassis " + aycldeto2_fil.cha_no
                                SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm301.policy .
                                /* comment by : Ranu I. A65-0115...
                                nv_si_n        = INTE(aycldeto2_fil.si)
                                nv_prem_n      = INTE(aycldeto2_fil.prem)
                                nv_prem_taxstm = INTE(aycldeto2_fil.premtax) /*A58-0121*/
                                nv_premtot_n   = INTE(aycldeto2_fil.premtot)
                                aycldeto2_fil.si      = TRIM(REPLACE(STRING(nv_si_n,">>>>>>>>>>>>9.99"),".",""))
                                aycldeto2_fil.prem    = TRIM(REPLACE(STRING(nv_prem_n,">>>>>>>>>>>>9.99"),".",""))
                                aycldeto2_fil.premtax = TRIM(REPLACE(STRING(nv_prem_taxstm,">>>>>>>>>>>>9.99"),".","")) /*A58-0121*/
                                aycldeto2_fil.insrayrno = "การประกันภัยรถยนต์(ภาคสมัครใจ)"  /*A58-0121*/
                                aycldeto2_fil.premtot = TRIM(REPLACE(STRING(nv_premtot_n,">>>>>>>>>>>>9.99"),".","")).
                                ...end A65-0115...*/
                            END.
                        END.     /*--if avail sicuw.uwm301--*/
                    END.         /*--if avail sicuw.uwm100--*/
                    ELSE DO:     /*uwm100.releas = no       */
                        ASSIGN nv_ncompcnt = nv_ncompcnt + 1   /* record not found count */
                        aycldeto2_fil.remark = "Policy Not Release" 
                        SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm301.policy .
                        /* comment by : Ranu I. A65-0115...
                        nv_si_n        = INTE(aycldeto2_fil.si)
                        nv_prem_n      = INTE(aycldeto2_fil.prem)
                        nv_prem_taxstm = INTE(aycldeto2_fil.premtax) /*A58-0121*/
                        nv_premtot_n   = INTE(aycldeto2_fil.premtot)
                        aycldeto2_fil.si      = TRIM(REPLACE(STRING(nv_si_n,">>>>>>>>>>>>9.99"),".",""))
                        aycldeto2_fil.prem    = TRIM(REPLACE(STRING(nv_prem_n,">>>>>>>>>>>>9.99"),".",""))
                        aycldeto2_fil.premtax = TRIM(REPLACE(STRING(nv_prem_taxstm,">>>>>>>>>>>>9.99"),".","")) /*A58-0121*/
                        aycldeto2_fil.insrayrno = "การประกันภัยรถยนต์(ภาคสมัครใจ)"  /*A58-0121*/
                        aycldeto2_fil.premtot = TRIM(REPLACE(STRING(nv_premtot_n,">>>>>>>>>>>>9.99"),".","")).
                        ...end : A65-0115...*/
                    END.
                END.      /*--else do (if not avail uwm100)--*/
            END.          /* Avail uwm301     */
            ELSE DO:      /* Not Avail uwm301 */
                FIND LAST sicuw.uwm301 USE-INDEX uwm30103                 WHERE
                    sicuw.uwm301.trareg             = aycldeto2_fil.cha_no AND 
                    SUBSTR(sicuw.uwm301.policy,3,2) = "70"                NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL uwm301 THEN DO:                             /*เช็คทีละเงื่อนไข ถ้า chasiss ตรงกัน (ตามเงื่อนไขข้อ 4,5) */
                    IF sicuw.uwm301.policy  <> nv_policyno THEN DO:  /*ให้เช็คเพิ่มถ้า policy ไม่ตรงกัน*/
                        IF sicuw.uwm301.trareg = ""  THEN DO:
                            ASSIGN nv_ncompcnt = nv_ncompcnt + 1    /* record not found count */
                                aycldeto2_fil.remark = "Chassis is null " 
                                SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm301.policy. 
                        END.      /*IF sicuw.uwm301.trareg = ""  THEN DO:*/
                        ELSE DO:
                            FIND LAST sicuw.uwm100 USE-INDEX uwm10001     WHERE 
                                sicuw.uwm100.policy = sicuw.uwm301.policy AND 
                                sicuw.uwm100.rencnt = sicuw.uwm301.rencnt AND
                                sicuw.uwm100.endcnt = sicuw.uwm301.endcnt AND 
                                sicuw.uwm100.releas = YES                 NO-LOCK NO-ERROR NO-WAIT.
                            IF AVAIL uwm100 THEN DO:
                                ASSIGN
                                    nv_dat   = STRING(DAY(sicuw.uwm100.comdat),"99")
                                    nv_mon   = STRING(MONTH(sicuw.uwm100.comdat),"99")
                                    nv_yea   = STRING(YEAR(sicuw.uwm100.comdat) + 543 , "9999")
                                    nv_dat1  = STRING(DAY(sicuw.uwm100.expdat),"99")
                                    nv_mon1  = STRING(MONTH(sicuw.uwm100.expdat),"99")
                                    nv_yea1  = STRING(YEAR(sicuw.uwm100.expdat) + 543 , "9999") 
                                    nv_comdat = SUBSTRING(nv_yea,3,2) + nv_mon + nv_dat 
                                    nv_expdat = SUBSTRING(nv_yea1,3,2) + nv_mon1 + nv_dat1.
                                IF (SUBSTR(aycldeto2_fil.comdat,1,2) = SUBSTR(nv_comdat,1,2)) OR 
                                    (aycldeto2_fil.comdat = "000000") THEN DO: /*เช็คปีต้องเท่ากับไฟล์ที่ส่งมา หรือถ้าเป็นค่าว่างให้ส่งค่ากลับไป*/
                                    ASSIGN
                                        aycldeto2_fil.policy  = CAPS(sicuw.uwm100.policy)
                                        aycldeto2_fil.comdat  = nv_comdat
                                        aycldeto2_fil.expdat  = nv_expdat .
                                    FOR EACH sicuw.uwm100 USE-INDEX uwm10091       WHERE 
                                        sicuw.uwm100.releas = YES                  AND 
                                        sicuw.uwm100.policy = sicuw.uwm301.policy  NO-LOCK .
                                        ASSIGN
                                            nv_prem   = nv_prem   + sicuw.uwm100.prem_t
                                            nv_rstp_t = nv_rstp_t + sicuw.uwm100.rstp_t
                                            nv_rtax_t = nv_rtax_t + sicuw.uwm100.rtax_t.
                                    END.
                                    ASSIGN                                             
                                        aycldeto2_fil.prem    = TRIM(REPLACE(STRING(nv_prem,">>>>>>>>>>>>9.99"),".",""))
                                        aycldeto2_fil.premtax = TRIM(REPLACE(STRING(nv_rstp_t + nv_rtax_t,">>>>>>>>>>>>9.99"),".","")) /*A58-0121*/
                                        aycldeto2_fil.insrayrno = "การประกันภัยรถยนต์(ภาคสมัครใจ)"  /*A58-0121*/
                                        aycldeto2_fil.premtot = TRIM(REPLACE(STRING(nv_prem + nv_rstp_t + nv_rtax_t,">>>>>>>>>>>>9.99"),".","")).
                                    FIND LAST sicuw.uwm130 USE-INDEX uwm13001 WHERE 
                                        sicuw.uwm130.policy = sicuw.uwm301.policy AND
                                        sicuw.uwm130.rencnt = sicuw.uwm301.rencnt AND
                                        sicuw.uwm130.endcnt = sicuw.uwm301.endcnt AND
                                        sicuw.uwm130.riskgp = sicuw.uwm301.riskgp AND
                                        sicuw.uwm130.riskno = sicuw.uwm301.riskno AND
                                        sicuw.uwm130.itemno = sicuw.uwm301.itemno NO-LOCK NO-ERROR NO-WAIT.
                                    IF AVAIL uwm130 THEN DO:
                                        IF sicuw.uwm301.covcod = "1" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                        ELSE IF sicuw.uwm301.covcod = "2" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom7_v,">>>>>>>>>>>>9.99"),".","").
                                        ELSE IF sicuw.uwm301.covcod = "2.1" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                        ELSE DO: 
                                            /*A57-0291*/
                                            IF      sicuw.uwm130.uom6_v <> 0 THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                            ELSE IF sicuw.uwm130.uom7_v <> 0 THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom7_v,">>>>>>>>>>>>9.99"),".","").
                                            ELSE nv_si = "000000000000000". 
                                            /*A57-0291*/
                                        END.
                                        aycldeto2_fil.si      = TRIM(STRING(nv_si)).

                                        /* add by : A65-0115 */
                                        FIND FIRST  sicuw.uwm120 USE-INDEX uwm12001        WHERE
                                              sicuw.uwm120.policy  = sicuw.uwm130.policy   AND
                                              sicuw.uwm120.rencnt  = sicuw.uwm130.rencnt   AND
                                              sicuw.uwm120.endcnt  = sicuw.uwm130.endcnt   and
                                              sicuw.uwm120.riskgp  = sicuw.uwm130.riskgp   and
                                              sicuw.uwm120.riskno  = sicuw.uwm130.riskno   NO-LOCK NO-ERROR NO-WAIT.
                                             IF AVAIL sicuw.uwm120 THEN DO:
                                                IF SUBSTR(sicuw.uwm120.class,5,1) = "E" THEN  ASSIGN aycldeto2_fil.textchar2 = "E" .
                                             END.
                                        /*..end A65-0115..*/

                                    END.                           /* Avail uwm130 */
                                    nv_compcnt = nv_compcnt + 1.   /* record found count */
                                END.       /*IF (SUBSTR(aycldeto2_fil.comdat,1,2) = SUBSTR(nv_comdat,1,2)) OR aycldeto2_fil.comdat = "000000" */
                                ELSE DO:
                                    ASSIGN nv_ncompcnt = nv_ncompcnt + 1    /* record not found count */
                                        aycldeto2_fil.remark = "ปีที่คุ้มครองไม่ตรง" 
                                        SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm100.policy.
                                END.
                            END.       /* Avail uwm100 */    
                            ELSE DO:   /*--if not avail uwm100--*/
                                FIND LAST sicuw.uwm100 USE-INDEX uwm10091      WHERE 
                                    sicuw.uwm100.releas = YES                  AND
                                    sicuw.uwm100.policy = sicuw.uwm301.policy  NO-LOCK NO-ERROR NO-WAIT.
                                IF AVAIL sicuw.uwm100 THEN DO:
                                    FIND LAST sicuw.uwm301 USE-INDEX uwm30101 WHERE 
                                        sicuw.uwm301.policy = sicuw.uwm100.policy AND
                                        sicuw.uwm301.rencnt = sicuw.uwm100.rencnt AND
                                        sicuw.uwm301.endcnt = sicuw.uwm100.endcnt NO-LOCK NO-ERROR NO-WAIT.
                                    IF AVAIL sicuw.uwm301 THEN DO:
                                        IF sicuw.uwm301.trareg = aycldeto2_fil.cha_no THEN DO:  /*ย้อนมาเช็คเลขตัวถังรถว่าตรงกันหรือไม่*/
                                            ASSIGN
                                                nv_dat   = STRING(DAY(sicuw.uwm100.comdat),"99")
                                                nv_mon   = STRING(MONTH(sicuw.uwm100.comdat),"99")
                                                nv_yea   = STRING(YEAR(sicuw.uwm100.comdat) + 543 , "9999")
                                                nv_dat1  = STRING(DAY(sicuw.uwm100.expdat),"99")
                                                nv_mon1  = STRING(MONTH(sicuw.uwm100.expdat),"99")
                                                nv_yea1  = STRING(YEAR(sicuw.uwm100.expdat) + 543 , "9999")
                                                nv_comdat = SUBSTRING(nv_yea,3,2) + nv_mon + nv_dat
                                                nv_expdat = SUBSTRING(nv_yea1,3,2) + nv_mon1 + nv_dat1.
                                            IF (SUBSTR(aycldeto2_fil.comdat,1,2) = SUBSTR(nv_comdat,1,2)) OR 
                                                (aycldeto2_fil.comdat = "000000") THEN DO:  /*เช็คปีต้องเท่ากับไฟล์ที่ส่งมา หรือถ้าเป็นค่าว่างให้ส่งค่ากลับไป*/
                                                ASSIGN
                                                    aycldeto2_fil.policy  = CAPS(sicuw.uwm100.policy)
                                                    aycldeto2_fil.comdat  = nv_comdat
                                                    aycldeto2_fil.expdat  = nv_expdat .
                                                FOR EACH sicuw.uwm100 USE-INDEX uwm10091      WHERE 
                                                    sicuw.uwm100.releas = YES                 AND
                                                    sicuw.uwm100.policy = sicuw.uwm301.policy NO-LOCK.  /*คำนวณเบี้ย*/
                                                    ASSIGN
                                                        nv_prem   = nv_prem   + sicuw.uwm100.prem_t
                                                        nv_rstp_t = nv_rstp_t + sicuw.uwm100.rstp_t
                                                        nv_rtax_t = nv_rtax_t + sicuw.uwm100.rtax_t.
                                                END.
                                                ASSIGN                                             
                                                    aycldeto2_fil.prem    = TRIM(REPLACE(STRING(nv_prem,">>>>>>>>>>>>9.99"),".",""))
                                                    aycldeto2_fil.premtax = TRIM(REPLACE(STRING(nv_rstp_t + nv_rtax_t,">>>>>>>>>>>>9.99"),".","")) /*A58-0121*/
                                                    aycldeto2_fil.insrayrno = "การประกันภัยรถยนต์(ภาคสมัครใจ)"  /*A58-0121*/
                                                    aycldeto2_fil.premtot = TRIM(REPLACE(STRING(nv_prem + nv_rstp_t + nv_rtax_t,">>>>>>>>>>>>9.99"),".","")).
                                                /**** Insured Item ****/
                                                FIND LAST sicuw.uwm130 USE-INDEX uwm13001     WHERE 
                                                    sicuw.uwm130.policy = sicuw.uwm301.policy AND
                                                    sicuw.uwm130.rencnt = sicuw.uwm301.rencnt AND
                                                    sicuw.uwm130.endcnt = sicuw.uwm301.endcnt AND
                                                    sicuw.uwm130.riskgp = sicuw.uwm301.riskgp AND
                                                    sicuw.uwm130.riskno = sicuw.uwm301.riskno AND
                                                    sicuw.uwm130.itemno = sicuw.uwm301.itemno NO-LOCK NO-ERROR NO-WAIT.
                                                IF AVAIL uwm130 THEN DO:
                                                    IF sicuw.uwm301.covcod = "1" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                                    ELSE IF sicuw.uwm301.covcod = "2" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom7_v,">>>>>>>>>>>>9.99"),".","").
                                                    ELSE IF sicuw.uwm301.covcod = "2.1" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                                    ELSE DO: 
                                                        /*A57-0291*/
                                                        IF      sicuw.uwm130.uom6_v <> 0 THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                                        ELSE IF sicuw.uwm130.uom7_v <> 0 THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom7_v,">>>>>>>>>>>>9.99"),".","").
                                                        ELSE nv_si = "000000000000000". 
                                                        /*A57-0291*/
                                                    END.
                                                    aycldeto2_fil.si      = TRIM(STRING(nv_si)).

                                                    /* add by : A65-0115 */
                                                    FIND FIRST  sicuw.uwm120 USE-INDEX uwm12001        WHERE
                                                          sicuw.uwm120.policy  = sicuw.uwm130.policy   AND
                                                          sicuw.uwm120.rencnt  = sicuw.uwm130.rencnt   AND
                                                          sicuw.uwm120.endcnt  = sicuw.uwm130.endcnt   and
                                                          sicuw.uwm120.riskgp  = sicuw.uwm130.riskgp   and
                                                          sicuw.uwm120.riskno  = sicuw.uwm130.riskno   NO-LOCK NO-ERROR NO-WAIT.
                                                         IF AVAIL sicuw.uwm120 THEN DO:
                                                            IF SUBSTR(sicuw.uwm120.class,5,1) = "E" THEN  ASSIGN aycldeto2_fil.textchar2 = "E" .
                                                         END.
                                                    /*..end A65-0115..*/

                                                END.                          /* Avail uwm130 */
                                                nv_compcnt = nv_compcnt + 1.   /* record found count */
                                            END.       /*IF (SUBSTR(aycldeto2_fil.comdat,1,2) = SUBSTR(nv_comdat,1,2)) OR aycldeto2_fil.comdat = "000000" THEN DO:*/
                                            ELSE DO:
                                                ASSIGN
                                                    nv_ncompcnt = nv_ncompcnt + 1   /* record not found count */
                                                    aycldeto2_fil.remark = "ปีที่คุ้มครองไม่ตรง" 
                                                    SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm301.policy. 
                                            END.
                                        END.        /*--if sicuw.uwm301.trareg = aycldeto2_fil.cha_no--*/
                                        ELSE DO:    /*เลขตัวถังรถไม่ตรงกัน*/
                                            ASSIGN  nv_ncompcnt = nv_ncompcnt + 1     /* record not found count */
                                            aycldeto2_fil.remark = "Not Found Policy permitt Chassis " + aycldeto2_fil.cha_no
                                            SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm301.policy  .
                                            /* comment by : Ranu I. A65-0115...
                                            nv_si_n        = INTE(aycldeto2_fil.si)
                                            nv_prem_n      = INTE(aycldeto2_fil.prem)
                                            nv_prem_taxstm = INTE(aycldeto2_fil.premtax) /*A58-0121*/
                                            nv_premtot_n   = INTE(aycldeto2_fil.premtot) 
                                            aycldeto2_fil.si      = TRIM(REPLACE(STRING(nv_si_n,">>>>>>>>>>>>9.99"),".",""))
                                            aycldeto2_fil.prem    = TRIM(REPLACE(STRING(nv_prem_n,">>>>>>>>>>>>9.99"),".",""))
                                            aycldeto2_fil.premtax = TRIM(REPLACE(STRING(nv_prem_taxstm,">>>>>>>>>>>>9.99"),".","")) /*A58-0121*/
                                            aycldeto2_fil.insrayrno = "การประกันภัยรถยนต์(ภาคสมัครใจ)"  /*A58-0121*/
                                            aycldeto2_fil.premtot = TRIM(REPLACE(STRING(nv_premtot_n,">>>>>>>>>>>>9.99"),".","")).
                                            ...end A65-0115...*/
                                        END.
                                    END.       /*--if avail sicuw.uwm301--*/
                                END.           /*--if avail sicuw.uwm100--*/
                                ELSE DO:       /* uwm100.releas = no*/
                                    ASSIGN nv_ncompcnt = nv_ncompcnt + 1              /* record not found count */
                                    aycldeto2_fil.remark = "Policy Not Release" 
                                    SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm301.policy.
                                    /* comment by : Ranu I. A65-0115...
                                    nv_si_n              = INTE(aycldeto2_fil.si)
                                    nv_prem_n            = INTE(aycldeto2_fil.prem)
                                    nv_prem_taxstm       = INTE(aycldeto2_fil.premtax) /*A58-0121*/
                                    nv_premtot_n         = INTE(aycldeto2_fil.premtot)
                                    aycldeto2_fil.si      = TRIM(REPLACE(STRING(nv_si_n,">>>>>>>>>>>>9.99"),".",""))
                                    aycldeto2_fil.prem    = TRIM(REPLACE(STRING(nv_prem_n,">>>>>>>>>>>>9.99"),".",""))
                                    aycldeto2_fil.premtax = TRIM(REPLACE(STRING(nv_prem_taxstm,">>>>>>>>>>>>9.99"),".","")) /*A58-0121*/
                                    aycldeto2_fil.insrayrno = "การประกันภัยรถยนต์(ภาคสมัครใจ)"  /*A58-0121*/
                                    aycldeto2_fil.premtot = TRIM(REPLACE(STRING(nv_premtot_n,">>>>>>>>>>>>9.99"),".","")).
                                    ....end A65-0115...*/
                                END.
                            END.     /*--else do (if not avail uwm100)--*/
                        END.         /*IF sicuw.uwm301.trareg <> ""  THEN DO:*/
                    END.             /*IF sicuw.uwm301.policy  <> aycldeto2_fil.notify THEN DO: /*ให้เช็คเพิ่มถ้า policy ไม่ตรงกัน*/ */
                END.                 /*FIND LAST sicuw.uwm301 USE-INDEX uwm30103 WHERE if avail sicuw.uwm301*/
                ELSE DO: 
                    FIND LAST sicuw.uwm301 USE-INDEX uwm30101           WHERE
                        sicuw.uwm301.policy             = nv_policyno   AND 
                        SUBSTR(sicuw.uwm301.policy,3,2) = "70"          NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAIL uwm301 THEN DO: /*ถ้า chasiss ไม่ตรง ให้มาเช็คกรมธรรม์ ถ้าตรงกัน ให้ทำ (ตามเงื่อนไขข้อ 2,3)*/
                        ASSIGN nv_name = ""
                        nv_name = TRIM(aycldeto2_fil.fname) + " " + TRIM(aycldeto2_fil.lname).
                        FIND FIRST sicsyac.xtm600 USE-INDEX xtm60002 WHERE sicsyac.xtm600.NAME = nv_name NO-LOCK NO-ERROR.
                        IF AVAIL xtm600 THEN nv_acno = xtm600.acno.
                        ELSE nv_acno = "".
                        IF sicuw.uwm301.trareg = ""  THEN DO:
                            ASSIGN nv_ncompcnt = nv_ncompcnt + 1    /* record not found count */
                            aycldeto2_fil.remark = "Chassis is null " 
                            SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm301.policy. 
                        END.    /*IF sicuw.uwm301.trareg = ""  THEN DO:*/
                        ELSE DO:
                            IF nv_acno = "" THEN DO:   /*ถ้าชื่อ-นามสกุล เป็นค่าว่างไม่ส่งข้อมูล ตรงกับเงื่อนไขข้อ 3*/
                                ASSIGN nv_ncompcnt = nv_ncompcnt + 1     /* record not found count */
                                aycldeto2_fil.remark = "Not Found Name  " + nv_name
                                SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm301.policy. 
                            END.
                            ELSE DO: 
                                FIND LAST sicuw.uwm100 USE-INDEX uwm10001      WHERE 
                                    sicuw.uwm100.policy = sicuw.uwm301.policy  AND 
                                    sicuw.uwm100.rencnt = sicuw.uwm301.rencnt  AND
                                    sicuw.uwm100.endcnt = sicuw.uwm301.endcnt  AND 
                                    sicuw.uwm100.releas = YES                  NO-LOCK NO-ERROR NO-WAIT.
                                IF AVAIL uwm100 THEN DO:
                                    IF sicuw.uwm100.insref = nv_acno THEN DO:  /*Lukkana M. A53-0161 30/04/2010 Mapping ตามชื่อ ถ้าตรงกันให้แสดงข้อมูล เงื่อนไขข้อ2*/
                                        ASSIGN nv_dat   = STRING(DAY(sicuw.uwm100.comdat),"99")
                                        nv_mon    = STRING(MONTH(sicuw.uwm100.comdat),"99")
                                        nv_yea    = STRING(YEAR(sicuw.uwm100.comdat) + 543 , "9999")
                                        nv_dat1   = STRING(DAY(sicuw.uwm100.expdat),"99")
                                        nv_mon1   = STRING(MONTH(sicuw.uwm100.expdat),"99")
                                        nv_yea1   = STRING(YEAR(sicuw.uwm100.expdat) + 543 , "9999") 
                                        nv_comdat = SUBSTRING(nv_yea,3,2) + nv_mon + nv_dat 
                                        nv_expdat = SUBSTRING(nv_yea1,3,2) + nv_mon1 + nv_dat1.
                                        IF (SUBSTR(aycldeto2_fil.comdat,1,2) = SUBSTR(nv_comdat,1,2)) OR (aycldeto2_fil.comdat = "000000") THEN DO: /*เช็คปีต้องเท่ากับไฟล์ที่ส่งมา หรือถ้าเป็นค่าว่างให้ส่งค่ากลับไป*/
                                            ASSIGN aycldeto2_fil.policy  = CAPS(sicuw.uwm100.policy)
                                            aycldeto2_fil.comdat  = nv_comdat
                                            aycldeto2_fil.expdat  = nv_expdat .
                                            FOR EACH sicuw.uwm100 USE-INDEX uwm10091       WHERE 
                                                sicuw.uwm100.releas = YES                  AND
                                                sicuw.uwm100.policy = sicuw.uwm301.policy  NO-LOCK.
                                                ASSIGN
                                                    nv_prem   = nv_prem   + sicuw.uwm100.prem_t
                                                    nv_rstp_t = nv_rstp_t + sicuw.uwm100.rstp_t
                                                    nv_rtax_t = nv_rtax_t + sicuw.uwm100.rtax_t.
                                            END.
                                            ASSIGN                                             
                                                aycldeto2_fil.prem    = TRIM(REPLACE(STRING(nv_prem,">>>>>>>>>>>>9.99"),".",""))
                                                aycldeto2_fil.premtax = TRIM(REPLACE(STRING(nv_rstp_t + nv_rtax_t,">>>>>>>>>>>>9.99"),".","")) /*A58-0121*/
                                                aycldeto2_fil.insrayrno = "การประกันภัยรถยนต์(ภาคสมัครใจ)"  /*A58-0121*/
                                                aycldeto2_fil.premtot = TRIM(REPLACE(STRING(nv_prem + nv_rstp_t + nv_rtax_t,">>>>>>>>>>>>9.99"),".","")).
                                            /**** Insured Item ****/
                                            FIND LAST sicuw.uwm130 USE-INDEX uwm13001 WHERE 
                                                sicuw.uwm130.policy = sicuw.uwm301.policy AND
                                                sicuw.uwm130.rencnt = sicuw.uwm301.rencnt AND
                                                sicuw.uwm130.endcnt = sicuw.uwm301.endcnt AND
                                                sicuw.uwm130.riskgp = sicuw.uwm301.riskgp AND
                                                sicuw.uwm130.riskno = sicuw.uwm301.riskno AND
                                                sicuw.uwm130.itemno = sicuw.uwm301.itemno NO-LOCK NO-ERROR NO-WAIT.
                                            IF AVAIL uwm130 THEN DO:   /**** SUM INSURE ****/
                                                IF sicuw.uwm301.covcod = "1" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                                ELSE IF sicuw.uwm301.covcod = "2" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom7_v,">>>>>>>>>>>>9.99"),".","").
                                                ELSE IF sicuw.uwm301.covcod = "2.1" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                                ELSE DO:
                                                    /*A57-0291*/
                                                    IF      sicuw.uwm130.uom6_v <> 0 THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                                    ELSE IF sicuw.uwm130.uom7_v <> 0 THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom7_v,">>>>>>>>>>>>9.99"),".","").
                                                    ELSE nv_si = "000000000000000". 
                                                    /*A57-0291*/
                                                END.
                                                aycldeto2_fil.si = TRIM(STRING(nv_si)).

                                                /* add by : A65-0115 */
                                                FIND FIRST  sicuw.uwm120 USE-INDEX uwm12001        WHERE
                                                      sicuw.uwm120.policy  = sicuw.uwm130.policy   AND
                                                      sicuw.uwm120.rencnt  = sicuw.uwm130.rencnt   AND
                                                      sicuw.uwm120.endcnt  = sicuw.uwm130.endcnt   and
                                                      sicuw.uwm120.riskgp  = sicuw.uwm130.riskgp   and
                                                      sicuw.uwm120.riskno  = sicuw.uwm130.riskno   NO-LOCK NO-ERROR NO-WAIT.
                                                     IF AVAIL sicuw.uwm120 THEN DO:
                                                        IF SUBSTR(sicuw.uwm120.class,5,1) = "E" THEN  ASSIGN aycldeto2_fil.textchar2 = "E" .
                                                     END.
                                                /*..end A65-0115..*/

                                            END.                          /* Avail uwm130 */
                                            nv_compcnt = nv_compcnt + 1.  /* record found count */
                                        END.       /*IF (SUBSTR(aycldeto2_fil.comdat,1,2) = SUBSTR(nv_comdat,1,2)) OR aycldeto2_fil.comdat = "000000" THEN DO:*/
                                        ELSE DO:
                                            ASSIGN nv_ncompcnt = nv_ncompcnt + 1    /* record not found count */
                                                aycldeto2_fil.remark = "ปีที่คุ้มครองไม่ตรง" 
                                                SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm100.policy. /*Lukkana M. A55-0244 01/08/2012*/
                                        END.
                                    END.        /*IF sicuw.uwm100.insref = nv_acno THEN DO: /*Lukkana M. A53-0161 30/04/2010 Mapping ตามชื่อ ถ้าตรงกันให้แสดงข้อมูล*/*/
                                    ELSE DO:    /*ชื่อ-สกุลไม่ตรงกัน*/
                                        ASSIGN nv_ncompcnt = nv_ncompcnt + 1     /* record not found count */
                                            aycldeto2_fil.remark = "Not Found Name  " + nv_name
                                            SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm100.policy. 
                                    END.
                                END.        /* Avail uwm100 */  
                                ELSE DO:    /*--if not avail uwm100--*/
                                    FIND LAST sicuw.uwm100 USE-INDEX uwm10091       WHERE 
                                        sicuw.uwm100.releas = YES                   AND
                                        sicuw.uwm100.policy = sicuw.uwm301.policy   NO-LOCK NO-ERROR NO-WAIT.
                                    IF AVAIL sicuw.uwm100 THEN DO:
                                        FIND LAST sicuw.uwm301 USE-INDEX uwm30101      WHERE 
                                            sicuw.uwm301.policy = sicuw.uwm100.policy  AND
                                            sicuw.uwm301.rencnt = sicuw.uwm100.rencnt  AND
                                            sicuw.uwm301.endcnt = sicuw.uwm100.endcnt  NO-LOCK NO-ERROR NO-WAIT.
                                        IF AVAIL sicuw.uwm301 THEN DO:
                                            IF sicuw.uwm301.trareg = aycldeto2_fil.cha_no THEN DO: /*ย้อนมาเช็คเลขตัวถังรถว่าตรงกันหรือไม่*/
                                                ASSIGN nv_dat   = STRING(DAY(sicuw.uwm100.comdat),"99")
                                                nv_mon    = STRING(MONTH(sicuw.uwm100.comdat),"99")
                                                nv_yea    = STRING(YEAR(sicuw.uwm100.comdat) + 543 , "9999")
                                                nv_dat1   = STRING(DAY(sicuw.uwm100.expdat),"99")
                                                nv_mon1   = STRING(MONTH(sicuw.uwm100.expdat),"99")
                                                nv_yea1   = STRING(YEAR(sicuw.uwm100.expdat) + 543 , "9999") 
                                                nv_comdat = SUBSTRING(nv_yea,3,2) + nv_mon + nv_dat
                                                nv_expdat = SUBSTRING(nv_yea1,3,2) + nv_mon1 + nv_dat1.
                                                IF (SUBSTR(aycldeto2_fil.comdat,1,2) = SUBSTR(nv_comdat,1,2)) OR 
                                                    (aycldeto2_fil.comdat = "000000") THEN DO: /*เช็คปีต้องเท่ากับไฟล์ที่ส่งมา หรือถ้าเป็นค่าว่างให้ส่งค่ากลับไป*/
                                                    ASSIGN aycldeto2_fil.policy  = CAPS(sicuw.uwm100.policy)
                                                    aycldeto2_fil.comdat  = nv_comdat
                                                    aycldeto2_fil.expdat  = nv_expdat .
                                                    FOR EACH sicuw.uwm100 USE-INDEX uwm10091           WHERE 
                                                        sicuw.uwm100.releas = YES                 AND
                                                        sicuw.uwm100.policy = sicuw.uwm301.policy NO-LOCK. /*คำนวณเบี้ย*/
                                                        ASSIGN nv_prem   = nv_prem   + sicuw.uwm100.prem_t
                                                        nv_rstp_t = nv_rstp_t + sicuw.uwm100.rstp_t
                                                        nv_rtax_t = nv_rtax_t + sicuw.uwm100.rtax_t.
                                                    END.
                                                    ASSIGN aycldeto2_fil.prem = TRIM(REPLACE(STRING(nv_prem,">>>>>>>>>>>>9.99"),".",""))
                                                    aycldeto2_fil.premtax     = TRIM(REPLACE(STRING(nv_rstp_t + nv_rtax_t,">>>>>>>>>>>>9.99"),".","")) /*A58-0121*/
                                                    aycldeto2_fil.insrayrno = "การประกันภัยรถยนต์(ภาคสมัครใจ)"  /*A58-0121*/
                                                    aycldeto2_fil.premtot   = TRIM(REPLACE(STRING(nv_prem + nv_rstp_t + nv_rtax_t,">>>>>>>>>>>>9.99"),".","")).
                                                    FIND LAST sicuw.uwm130 USE-INDEX uwm13001   WHERE 
                                                        sicuw.uwm130.policy = sicuw.uwm301.policy AND
                                                        sicuw.uwm130.rencnt = sicuw.uwm301.rencnt AND
                                                        sicuw.uwm130.endcnt = sicuw.uwm301.endcnt AND
                                                        sicuw.uwm130.riskgp = sicuw.uwm301.riskgp AND
                                                        sicuw.uwm130.riskno = sicuw.uwm301.riskno AND
                                                        sicuw.uwm130.itemno = sicuw.uwm301.itemno NO-LOCK NO-ERROR NO-WAIT.
                                                    IF AVAIL uwm130 THEN DO:
                                                        /**** SUM INSURE ****/
                                                        IF sicuw.uwm301.covcod = "1" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                                        ELSE IF sicuw.uwm301.covcod = "2" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom7_v,">>>>>>>>>>>>9.99"),".","").
                                                        ELSE IF sicuw.uwm301.covcod = "2.1" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                                        ELSE DO: 
                                                            /*A57-0291*/
                                                            IF      sicuw.uwm130.uom6_v <> 0 THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                                            ELSE IF sicuw.uwm130.uom7_v <> 0 THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom7_v,">>>>>>>>>>>>9.99"),".","").
                                                            ELSE nv_si = "000000000000000". 
                                                            /*A57-0291*/
                                                        END.
                                                        aycldeto2_fil.si      = TRIM(STRING(nv_si)).

                                                        /* add by : A65-0115 */
                                                        FIND FIRST  sicuw.uwm120 USE-INDEX uwm12001        WHERE
                                                              sicuw.uwm120.policy  = sicuw.uwm130.policy   AND
                                                              sicuw.uwm120.rencnt  = sicuw.uwm130.rencnt   AND
                                                              sicuw.uwm120.endcnt  = sicuw.uwm130.endcnt   and
                                                              sicuw.uwm120.riskgp  = sicuw.uwm130.riskgp   and
                                                              sicuw.uwm120.riskno  = sicuw.uwm130.riskno   NO-LOCK NO-ERROR NO-WAIT.
                                                             IF AVAIL sicuw.uwm120 THEN DO:
                                                                IF SUBSTR(sicuw.uwm120.class,5,1) = "E" THEN  ASSIGN aycldeto2_fil.textchar2 = "E" .
                                                             END.
                                                        /*..end A65-0115..*/
                                                    END.                          /* Avail uwm130 */
                                                    nv_compcnt = nv_compcnt + 1.  /* record found count */
                                                END.   /*IF (SUBSTR(aycldeto2_fil.comdat,1,2) = SUBSTR(nv_comdat,1,2)) OR aycldeto2_fil.comdat = "000000" THEN DO:*/
                                                ELSE DO:
                                                    ASSIGN 
                                                        nv_ncompcnt = nv_ncompcnt + 1   /* record not found count */
                                                        aycldeto2_fil.remark = "ปีที่คุ้มครองไม่ตรง" 
                                                        SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm301.policy. 
                                                END.
                                            END.        /*--if sicuw.uwm301.trareg = aycldeto2_fil.cha_no--*/
                                            ELSE DO:    /*เลขตัวถังรถไม่ตรงกัน*/
                                                ASSIGN nv_ncompcnt = nv_ncompcnt + 1     /* record not found count */
                                                aycldeto2_fil.remark = "Not Found Policy permitt Chassis " + aycldeto2_fil.cha_no
                                                SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm301.policy.
                                                /* comment by : Ranu I. A65-0115...
                                                nv_si_n              = INTE(aycldeto2_fil.si)
                                                nv_prem_n            = INTE(aycldeto2_fil.prem)
                                                nv_prem_taxstm       = INTE(aycldeto2_fil.premtax) /*A58-0121*/
                                                nv_premtot_n         = INTE(aycldeto2_fil.premtot)
                                                aycldeto2_fil.si      = TRIM(REPLACE(STRING(nv_si_n,">>>>>>>>>>>>9.99"),".",""))
                                                aycldeto2_fil.prem    = TRIM(REPLACE(STRING(nv_prem_n,">>>>>>>>>>>>9.99"),".",""))
                                                aycldeto2_fil.premtax = TRIM(REPLACE(STRING(nv_prem_taxstm,">>>>>>>>>>>>9.99"),".","")) /*A58-0121*/
                                                aycldeto2_fil.insrayrno = "การประกันภัยรถยนต์(ภาคสมัครใจ)"  /*A58-0121*/
                                                aycldeto2_fil.premtot = TRIM(REPLACE(STRING(nv_premtot_n,">>>>>>>>>>>>9.99"),".","")).
                                                ...end A65-0115...*/
                                            END.
                                        END.     /*--if avail sicuw.uwm301--*/
                                    END.         /*--if avail sicuw.uwm100--*/
                                    ELSE DO:     /*uwm100.releas = no*/
                                        ASSIGN nv_ncompcnt = nv_ncompcnt + 1   /* record not found count */
                                        aycldeto2_fil.remark  = "Policy Not Release" 
                                        SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm301.policy .
                                        /* comment by : Ranu I. A65-0115...
                                        nv_si_n              = INTE(aycldeto2_fil.si)
                                        nv_prem_n            = INTE(aycldeto2_fil.prem)
                                        nv_prem_taxstm       = INTE(aycldeto2_fil.premtax) /*A58-0121*/
                                        nv_premtot_n         = INTE(aycldeto2_fil.premtot)
                                        aycldeto2_fil.si      = TRIM(REPLACE(STRING(nv_si_n,">>>>>>>>>>>>9.99"),".",""))
                                        aycldeto2_fil.prem    = TRIM(REPLACE(STRING(nv_prem_n,">>>>>>>>>>>>9.99"),".",""))
                                        aycldeto2_fil.premtax = TRIM(REPLACE(STRING(nv_prem_taxstm,">>>>>>>>>>>>9.99"),".","")) /*A58-0121*/
                                        aycldeto2_fil.insrayrno = "การประกันภัยรถยนต์(ภาคสมัครใจ)"  /*A58-0121*/
                                        aycldeto2_fil.premtot = TRIM(REPLACE(STRING(nv_premtot_n,">>>>>>>>>>>>9.99"),".","")).
                                        ....end :  A65-0115...*/
                                    END.
                                END.     /*--else do (if not avail uwm100)--*/
                            END.         /*IF nv_acno <> "" THEN DO: ถ้าชื่อ-นามสกุล ไม่เป็นค่าว่าง ให้เช็คว่าตรงกันหรือไม่*/
                        END.             /*IF sicuw.uwm301.trareg <> ""  THEN DO:*/
                    END.                 /*if avail uwm301*/
                    ELSE DO:
                        ASSIGN nv_ncompcnt = nv_ncompcnt + 1   /* record not found count */
                        aycldeto2_fil.remark = "Not Found Policy permitt Chassis " + aycldeto2_fil.cha_no
                        SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm100.policy .
                        /* comment by : Ranu I. A65-0115...
                        nv_si_n        = INTE(aycldeto2_fil.si)
                        nv_prem_n      = INTE(aycldeto2_fil.prem)
                        nv_prem_taxstm = INTE(aycldeto2_fil.premtax) /*A58-0121*/
                        nv_premtot_n   = INTE(aycldeto2_fil.premtot) 
                        aycldeto2_fil.si      = TRIM(REPLACE(STRING(nv_si_n,">>>>>>>>>>>>9.99"),".",""))
                        aycldeto2_fil.prem    = TRIM(REPLACE(STRING(nv_prem_n,">>>>>>>>>>>>9.99"),".",""))
                        aycldeto2_fil.premtax = TRIM(REPLACE(STRING(nv_prem_taxstm,">>>>>>>>>>>>9.99"),".","")) /*A58-0121*/
                        aycldeto2_fil.insrayrno = "การประกันภัยรถยนต์(ภาคสมัครใจ)"  /*A58-0121*/
                        aycldeto2_fil.premtot = TRIM(REPLACE(STRING(nv_premtot_n,">>>>>>>>>>>>9.99"),".","")).
                        ...end A65-0115...*/
                    END.
                END.     /*else do*/
            END.
        END.             /*หา Agent ที่ตรงกัน*/
        ELSE DO:         /*ถ้าไม่เจอ acno                     pin. ...not group acno ......*/
            FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE
                sicuw.uwm100.policy = nv_policyno   NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicuw.uwm100 THEN DO:
                ASSIGN nv_ncompcnt = nv_ncompcnt + 1   /* record not found count */
                aycldeto2_fil.remark         = "รหัส Code ไม่ตรง"
                SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm100.policy
                SUBSTR(aycldeto2_fil.remark,120,10) = sicuw.uwm100.acno1. 
            END.
            ELSE DO:

                FIND LAST sicuw.uwm301 USE-INDEX uwm30103                 WHERE
                    sicuw.uwm301.trareg             = aycldeto2_fil.cha_no AND 
                    SUBSTR(sicuw.uwm301.policy,3,2) = "70"                 NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL uwm301 THEN DO:    /*เช็คทีละเงื่อนไข ถ้า chasiss ตรงกัน (ตามเงื่อนไขข้อ 4,5) */
                    IF sicuw.uwm301.policy  <> nv_policyno  THEN DO: /*ให้เช็คเพิ่มถ้า policy ไม่ตรงกัน*/
                        IF sicuw.uwm301.trareg = ""  THEN DO:
                            ASSIGN nv_ncompcnt = nv_ncompcnt + 1    /* record not found count */
                            aycldeto2_fil.remark = "Chassis is null " 
                            SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm301.policy. 
                        END.    /*IF sicuw.uwm301.trareg = ""  THEN DO:*/
                        ELSE DO:
                            FIND LAST sicuw.uwm100 USE-INDEX uwm10001           WHERE 
                                sicuw.uwm100.policy = sicuw.uwm301.policy AND 
                                sicuw.uwm100.rencnt = sicuw.uwm301.rencnt AND
                                sicuw.uwm100.endcnt = sicuw.uwm301.endcnt AND 
                                sicuw.uwm100.releas = YES  /*A65-0115*/
                                NO-LOCK NO-ERROR NO-WAIT.
                            IF AVAIL uwm100 THEN DO:
                                IF INDEX(nv_agentgpstmt,TRIM(sicuw.uwm100.acno1)) = 0  THEN DO:
                                    ASSIGN 
                                    nv_ncompcnt = nv_ncompcnt + 1     /* record not found count */
                                    aycldeto2_fil.remark         = "รหัส Code ไม่ตรง"
                                    SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm100.policy
                                    SUBSTR(aycldeto2_fil.remark,120,10) = sicuw.uwm100.acno1. 
                                END.
                                ELSE DO: 
                                    ASSIGN nv_dat   = STRING(DAY(sicuw.uwm100.comdat),"99")
                                    nv_mon   = STRING(MONTH(sicuw.uwm100.comdat),"99")
                                    nv_yea   = STRING(YEAR(sicuw.uwm100.comdat) + 543 , "9999")
                                    nv_dat1  = STRING(DAY(sicuw.uwm100.expdat),"99")
                                    nv_mon1  = STRING(MONTH(sicuw.uwm100.expdat),"99")
                                    nv_yea1  = STRING(YEAR(sicuw.uwm100.expdat) + 543 , "9999") 
                                    nv_comdat = SUBSTRING(nv_yea,3,2) + nv_mon + nv_dat 
                                    nv_expdat = SUBSTRING(nv_yea1,3,2) + nv_mon1 + nv_dat1.
                                    IF (SUBSTR(aycldeto2_fil.comdat,1,2) = SUBSTR(nv_comdat,1,2)) OR 
                                        (aycldeto2_fil.comdat = "000000") THEN DO:  /*เช็คปีต้องเท่ากับไฟล์ที่ส่งมา หรือถ้าเป็นค่าว่างให้ส่งค่ากลับไป*/
                                        ASSIGN aycldeto2_fil.policy  = CAPS(sicuw.uwm100.policy)
                                        aycldeto2_fil.comdat  = nv_comdat
                                        aycldeto2_fil.expdat  = nv_expdat .
                                        FOR EACH sicuw.uwm100 USE-INDEX uwm10091       WHERE 
                                            sicuw.uwm100.releas = YES                  AND 
                                            sicuw.uwm100.policy = sicuw.uwm301.policy  NO-LOCK .
                                            ASSIGN nv_prem   = nv_prem   + sicuw.uwm100.prem_t
                                                nv_rstp_t = nv_rstp_t + sicuw.uwm100.rstp_t
                                                nv_rtax_t = nv_rtax_t + sicuw.uwm100.rtax_t.
                                        END.
                                        ASSIGN                                             
                                            aycldeto2_fil.prem    = TRIM(REPLACE(STRING(nv_prem,">>>>>>>>>>>>9.99"),".",""))
                                            aycldeto2_fil.premtax = TRIM(REPLACE(STRING(nv_rstp_t + nv_rtax_t,">>>>>>>>>>>>9.99"),".","")) /*A58-0121*/
                                            aycldeto2_fil.insrayrno = "การประกันภัยรถยนต์(ภาคสมัครใจ)"  /*A58-0121*/
                                            aycldeto2_fil.premtot = TRIM(REPLACE(STRING(nv_prem + nv_rstp_t + nv_rtax_t,">>>>>>>>>>>>9.99"),".","")).
                                        /**** Insured Item ****/
                                        FIND LAST sicuw.uwm130 USE-INDEX uwm13001     WHERE 
                                            sicuw.uwm130.policy = sicuw.uwm301.policy AND
                                            sicuw.uwm130.rencnt = sicuw.uwm301.rencnt AND
                                            sicuw.uwm130.endcnt = sicuw.uwm301.endcnt AND
                                            sicuw.uwm130.riskgp = sicuw.uwm301.riskgp AND
                                            sicuw.uwm130.riskno = sicuw.uwm301.riskno AND
                                            sicuw.uwm130.itemno = sicuw.uwm301.itemno NO-LOCK NO-ERROR NO-WAIT.
                                        IF AVAIL uwm130 THEN DO:
                                            /**** SUM INSURE ****/
                                            IF sicuw.uwm301.covcod = "1" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                            ELSE IF sicuw.uwm301.covcod = "2" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom7_v,">>>>>>>>>>>>9.99"),".","").
                                            ELSE IF sicuw.uwm301.covcod = "2.1" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                            ELSE DO: 
                                                /*A57-0291*/
                                                IF      sicuw.uwm130.uom6_v <> 0 THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                                ELSE IF sicuw.uwm130.uom7_v <> 0 THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom7_v,">>>>>>>>>>>>9.99"),".","").
                                                ELSE nv_si = "000000000000000". 
                                                /*A57-0291*/
                                            END.
                                            aycldeto2_fil.si      = TRIM(STRING(nv_si)).

                                            /* add by : A65-0115 */
                                            FIND FIRST  sicuw.uwm120 USE-INDEX uwm12001        WHERE
                                                  sicuw.uwm120.policy  = sicuw.uwm130.policy   AND
                                                  sicuw.uwm120.rencnt  = sicuw.uwm130.rencnt   AND
                                                  sicuw.uwm120.endcnt  = sicuw.uwm130.endcnt   and
                                                  sicuw.uwm120.riskgp  = sicuw.uwm130.riskgp   and
                                                  sicuw.uwm120.riskno  = sicuw.uwm130.riskno   NO-LOCK NO-ERROR NO-WAIT.
                                                 IF AVAIL sicuw.uwm120 THEN DO:
                                                    IF SUBSTR(sicuw.uwm120.class,5,1) = "E" THEN  ASSIGN aycldeto2_fil.textchar2 = "E" .
                                                 END.
                                            /*..end A65-0115..*/

                                        END.      /* Avail uwm130 */
                                        nv_compcnt = nv_compcnt + 1.   /* record found count */
                                    END.          /*IF (SUBSTR(aycldeto2_fil.comdat,1,2) = SUBSTR(nv_comdat,1,2)) OR aycldeto2_fil.comdat = "000000" */
                                    ELSE DO:
                                        ASSIGN 
                                            nv_ncompcnt = nv_ncompcnt + 1         /* record not found count */
                                            aycldeto2_fil.remark = "ปีที่คุ้มครองไม่ตรง" 
                                            SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm100.policy. 
                                    END.
                                END.    /*หา code เจอ*/
                            END.        /* Avail uwm100 */  
                        END.            /*IF sicuw.uwm301.trareg <> ""  THEN DO:*/
                    END.                /*IF sicuw.uwm301.policy  <> aycldeto2_fil.notify THEN DO: /*ให้เช็คเพิ่มถ้า policy ไม่ตรงกัน*/ */
                END.                    /*FIND LAST sicuw.uwm301 USE-INDEX uwm30103 WHERE if avail sicuw.uwm301*/
                ELSE DO:
                    ASSIGN aycldeto2_fil.remark   = "ไม่มีข้อมูลในระบบ" .
                    /* comment by : Ranu I. A65-0115...
                    nv_si_n              = INTE(aycldeto2_fil.si)
                    nv_prem_n            = INTE(aycldeto2_fil.prem)
                    nv_prem_taxstm       = INTE(aycldeto2_fil.premtax) /*A58-0121*/
                    nv_premtot_n         = INTE(aycldeto2_fil.premtot) 
                    aycldeto2_fil.si      = TRIM(REPLACE(STRING(nv_si_n,">>>>>>>>>>>>9.99"),".",""))
                    aycldeto2_fil.prem    = TRIM(REPLACE(STRING(nv_prem_n,">>>>>>>>>>>>9.99"),".",""))
                    aycldeto2_fil.premtax = TRIM(REPLACE(STRING(nv_prem_taxstm,">>>>>>>>>>>>9.99"),".","")) /*A58-0121*/
                    aycldeto2_fil.insrayrno = "การประกันภัยรถยนต์(ภาคสมัครใจ)"  /*A58-0121*/
                    aycldeto2_fil.premtot = TRIM(REPLACE(STRING(nv_premtot_n,">>>>>>>>>>>>9.99"),".","")).  
                    ...end : A65-0115...*/
                END.
            END. 
        END.
    END.                  /* FOR EACH aycldeto2_fil */
    RELEASE aycldeto2_fil. 
END.                      /*if nv_outagent2 <> ""*/
ELSE IF nv_outagent2 = "" THEN DO:  
    FOR EACH aycldeto2_fil  USE-INDEX aycldeti02 WHERE 
        aycldeto2_fil.bchyr   = nv_bchyr  AND
        aycldeto2_fil.bchno   = nv_bchno  AND
        aycldeto2_fil.bchcnt  = nv_bchcnt AND
        (aycldeto2_fil.rectyp <> "H"     AND    /* Header */
         aycldeto2_fil.rectyp <> "T" )  :       /* Total */
        ASSIGN nv_prem   = 0 
        nv_rstp_t = 0
        nv_rtax_t = 0
        nv_dat    = ""   
        nv_mon    = ""   
        nv_yea    = "" 
        nv_policyno = trim(aycldeto2_fil.notify)   
        nv_i = 0                                  
        nv_l = LENGTH(nv_policyno).               
        DO WHILE nv_i <= nv_l:
            ind = 0.
            ind = INDEX(nv_policyno,"/").
            IF ind <> 0 THEN DO:
                nv_policyno = TRIM (SUBSTRING(nv_policyno,1,ind - 1) + SUBSTRING(nv_policyno,ind + 1, nv_l)).
            END.
            ind = INDEX(nv_policyno,"\").
            IF ind <> 0 THEN DO:
                nv_policyno = TRIM (SUBSTRING(nv_policyno,1,ind - 1) + SUBSTRING(nv_policyno,ind + 1, nv_l)).
            END.
            ind = INDEX(nv_policyno,"-").
            IF ind <> 0 THEN DO:
                nv_policyno = TRIM (SUBSTRING(nv_policyno,1,ind - 1) + SUBSTRING(nv_policyno,ind + 1, nv_l)).
            END.
            ind = INDEX(nv_policyno," ").
            IF ind <> 0 THEN DO:
                nv_policyno = TRIM (SUBSTRING(nv_policyno,1,ind - 1) + SUBSTRING(nv_policyno,ind + 1, nv_l)).
            END.
            nv_i = nv_i + 1.
        END.
        FIND LAST sicuw.uwm301 USE-INDEX uwm30103                 WHERE
            sicuw.uwm301.trareg             = aycldeto2_fil.cha_no AND 
            sicuw.uwm301.policy             = nv_policyno         AND 
            SUBSTR(sicuw.uwm301.policy,3,2) = "70"                NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL uwm301 THEN DO:    /*เช็ค chasis และ policy ตรงกัน ให้ส่งข้อมูลได้ (ตามเงื่อนไขข้อ 1)*/
            FIND LAST sicuw.uwm100 USE-INDEX uwm10001     WHERE 
                sicuw.uwm100.policy = sicuw.uwm301.policy AND 
                sicuw.uwm100.rencnt = sicuw.uwm301.rencnt AND
                sicuw.uwm100.endcnt = sicuw.uwm301.endcnt AND 
                sicuw.uwm100.releas = YES                 NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL uwm100 THEN DO:
                ASSIGN nv_dat    = STRING(DAY(sicuw.uwm100.comdat),"99")
                nv_mon    = STRING(MONTH(sicuw.uwm100.comdat),"99")
                nv_yea    = STRING(YEAR(sicuw.uwm100.comdat) + 543 , "9999")
                nv_dat1   = STRING(DAY(sicuw.uwm100.expdat),"99")
                nv_mon1   = STRING(MONTH(sicuw.uwm100.expdat),"99")
                nv_yea1   = STRING(YEAR(sicuw.uwm100.expdat) + 543 , "9999") 
                nv_comdat = SUBSTRING(nv_yea,3,2) + nv_mon + nv_dat 
                nv_expdat = SUBSTRING(nv_yea1,3,2) + nv_mon1 + nv_dat1.
                IF (SUBSTR(aycldeto2_fil.comdat,1,2) = SUBSTR(nv_comdat,1,2)) OR (aycldeto2_fil.comdat = "000000") THEN DO: /*เช็คปีต้องเท่ากับไฟล์ที่ส่งมา หรือถ้าเป็นค่าว่างให้ส่งค่ากลับไป*/
                    ASSIGN aycldeto2_fil.policy  = CAPS(sicuw.uwm100.policy)
                    aycldeto2_fil.comdat  = nv_comdat
                    aycldeto2_fil.expdat  = nv_expdat .
                    FOR EACH sicuw.uwm100 USE-INDEX uwm10091       WHERE 
                        sicuw.uwm100.releas = YES                  AND
                        sicuw.uwm100.policy = sicuw.uwm301.policy  NO-LOCK.
                        ASSIGN nv_prem   = nv_prem   + sicuw.uwm100.prem_t
                        nv_rstp_t = nv_rstp_t + sicuw.uwm100.rstp_t
                        nv_rtax_t = nv_rtax_t + sicuw.uwm100.rtax_t.
                    END.
                    ASSIGN aycldeto2_fil.prem    = TRIM(REPLACE(STRING(nv_prem,">>>>>>>>>>>>9.99"),".",""))
                    aycldeto2_fil.premtax = TRIM(REPLACE(STRING(nv_rstp_t + nv_rtax_t,">>>>>>>>>>>>9.99"),".","")) /*A58-0121*/
                    aycldeto2_fil.insrayrno = "การประกันภัยรถยนต์(ภาคสมัครใจ)"  /*A58-0121*/
                    aycldeto2_fil.premtot = TRIM(REPLACE(STRING(nv_prem + nv_rstp_t + nv_rtax_t,">>>>>>>>>>>>9.99"),".","")).
                    /**** Insured Item ****/
                    FIND LAST sicuw.uwm130 USE-INDEX uwm13001 WHERE 
                        sicuw.uwm130.policy = sicuw.uwm301.policy AND
                        sicuw.uwm130.rencnt = sicuw.uwm301.rencnt AND
                        sicuw.uwm130.endcnt = sicuw.uwm301.endcnt AND
                        sicuw.uwm130.riskgp = sicuw.uwm301.riskgp AND
                        sicuw.uwm130.riskno = sicuw.uwm301.riskno AND
                        sicuw.uwm130.itemno = sicuw.uwm301.itemno NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAIL uwm130 THEN DO:
                        IF sicuw.uwm301.covcod = "1" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                        ELSE IF sicuw.uwm301.covcod = "2" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom7_v,">>>>>>>>>>>>9.99"),".","").
                        ELSE IF sicuw.uwm301.covcod = "2.1" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                        ELSE DO: 
                            /*A57-0291*/
                            IF      sicuw.uwm130.uom6_v <> 0 THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                            ELSE IF sicuw.uwm130.uom7_v <> 0 THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom7_v,">>>>>>>>>>>>9.99"),".","").
                            ELSE nv_si = "000000000000000". 
                            /*A57-0291*/
                        END.
                        aycldeto2_fil.si      = TRIM(STRING(nv_si)).
                        /* add by : A65-0115 */
                        FIND FIRST  sicuw.uwm120 USE-INDEX uwm12001        WHERE
                              sicuw.uwm120.policy  = sicuw.uwm130.policy   AND
                              sicuw.uwm120.rencnt  = sicuw.uwm130.rencnt   AND
                              sicuw.uwm120.endcnt  = sicuw.uwm130.endcnt   and
                              sicuw.uwm120.riskgp  = sicuw.uwm130.riskgp   and
                              sicuw.uwm120.riskno  = sicuw.uwm130.riskno   NO-LOCK NO-ERROR NO-WAIT.
                             IF AVAIL sicuw.uwm120 THEN DO:
                                IF SUBSTR(sicuw.uwm120.class,5,1) = "E" THEN  ASSIGN aycldeto2_fil.textchar2 = "E" .
                             END.
                        /*..end A65-0115..*/
                    END.                            /* Avail uwm130 */
                    nv_compcnt = nv_compcnt + 1.    /* record found count */
                END.
                ELSE DO:
                    ASSIGN nv_ncompcnt = nv_ncompcnt + 1              /* record not found count */
                    aycldeto2_fil.remark = "ปีที่คุ้มครองไม่ตรง" 
                    SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm100.policy . 
                END.
            END.       /* Avail uwm100 */    
            ELSE DO:   /*--if not avail uwm100--*/
                FIND LAST sicuw.uwm100 USE-INDEX uwm10091      WHERE 
                    sicuw.uwm100.releas = YES                  AND
                    sicuw.uwm100.policy = sicuw.uwm301.policy  NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL sicuw.uwm100 THEN DO:
                    FIND LAST sicuw.uwm301 USE-INDEX uwm30101  WHERE 
                        sicuw.uwm301.policy = sicuw.uwm100.policy AND
                        sicuw.uwm301.rencnt = sicuw.uwm100.rencnt AND
                        sicuw.uwm301.endcnt = sicuw.uwm100.endcnt NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAIL sicuw.uwm301 THEN DO:
                        IF sicuw.uwm301.trareg = aycldeto2_fil.cha_no THEN DO:  /*ย้อนมาเช็คเลขตัวถังรถว่าตรงกันหรือไม่*/
                            ASSIGN nv_dat   = STRING(DAY(sicuw.uwm100.comdat),"99")
                            nv_mon    = STRING(MONTH(sicuw.uwm100.comdat),"99")
                            nv_yea    = STRING(YEAR(sicuw.uwm100.comdat) + 543 , "9999")
                            nv_dat1   = STRING(DAY(sicuw.uwm100.expdat),"99")
                            nv_mon1   = STRING(MONTH(sicuw.uwm100.expdat),"99")
                            nv_yea1   = STRING(YEAR(sicuw.uwm100.expdat) + 543 , "9999")
                            nv_comdat = SUBSTRING(nv_yea,3,2) + nv_mon + nv_dat
                            nv_expdat = SUBSTRING(nv_yea1,3,2) + nv_mon1 + nv_dat1.
                            IF (SUBSTR(aycldeto2_fil.comdat,1,2) = SUBSTR(nv_comdat,1,2)) OR (aycldeto2_fil.comdat = "000000") THEN DO: /*เช็คปีต้องเท่ากับไฟล์ที่ส่งมา หรือถ้าเป็นค่าว่างให้ส่งค่ากลับไป*/
                                ASSIGN aycldeto2_fil.policy  = CAPS(sicuw.uwm100.policy)
                                aycldeto2_fil.comdat  = nv_comdat
                                aycldeto2_fil.expdat  = nv_expdat .
                                FOR EACH sicuw.uwm100 USE-INDEX uwm10091      WHERE 
                                    sicuw.uwm100.releas = YES                 AND
                                    sicuw.uwm100.policy = sicuw.uwm301.policy NO-LOCK.  /*คำนวณเบี้ย*/
                                    ASSIGN nv_prem   = nv_prem   + sicuw.uwm100.prem_t
                                    nv_rstp_t = nv_rstp_t + sicuw.uwm100.rstp_t
                                    nv_rtax_t = nv_rtax_t + sicuw.uwm100.rtax_t.
                                END.
                                ASSIGN aycldeto2_fil.prem    = TRIM(REPLACE(STRING(nv_prem,">>>>>>>>>>>>9.99"),".",""))
                                aycldeto2_fil.premtax = TRIM(REPLACE(STRING(nv_rstp_t + nv_rtax_t,">>>>>>>>>>>>9.99"),".","")) /*A58-0121*/
                                aycldeto2_fil.insrayrno = "การประกันภัยรถยนต์(ภาคสมัครใจ)"  /*A58-0121*/
                                aycldeto2_fil.premtot = TRIM(REPLACE(STRING(nv_prem + nv_rstp_t + nv_rtax_t,">>>>>>>>>>>>9.99"),".","")).
                                /**** Insured Item ****/
                                FIND LAST sicuw.uwm130 USE-INDEX uwm13001     WHERE 
                                    sicuw.uwm130.policy = sicuw.uwm301.policy AND
                                    sicuw.uwm130.rencnt = sicuw.uwm301.rencnt AND
                                    sicuw.uwm130.endcnt = sicuw.uwm301.endcnt AND
                                    sicuw.uwm130.riskgp = sicuw.uwm301.riskgp AND
                                    sicuw.uwm130.riskno = sicuw.uwm301.riskno AND
                                    sicuw.uwm130.itemno = sicuw.uwm301.itemno NO-LOCK NO-ERROR NO-WAIT.
                                IF AVAIL uwm130 THEN DO:
                                    /**** SUM INSURE ****/
                                    IF sicuw.uwm301.covcod = "1" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                    ELSE IF sicuw.uwm301.covcod = "2" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom7_v,">>>>>>>>>>>>9.99"),".","").
                                    ELSE IF sicuw.uwm301.covcod = "2.1" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                    ELSE DO: 
                                        /*A57-0291*/
                                        IF      sicuw.uwm130.uom6_v <> 0 THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                        ELSE IF sicuw.uwm130.uom7_v <> 0 THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom7_v,">>>>>>>>>>>>9.99"),".","").
                                        ELSE nv_si = "000000000000000". 
                                        /*A57-0291*/
                                    END.
                                    aycldeto2_fil.si      = TRIM(STRING(nv_si)).

                                    /* add by : A65-0115 */
                                    FIND FIRST  sicuw.uwm120 USE-INDEX uwm12001        WHERE
                                          sicuw.uwm120.policy  = sicuw.uwm130.policy   AND
                                          sicuw.uwm120.rencnt  = sicuw.uwm130.rencnt   AND
                                          sicuw.uwm120.endcnt  = sicuw.uwm130.endcnt   and
                                          sicuw.uwm120.riskgp  = sicuw.uwm130.riskgp   and
                                          sicuw.uwm120.riskno  = sicuw.uwm130.riskno   NO-LOCK NO-ERROR NO-WAIT.
                                         IF AVAIL sicuw.uwm120 THEN DO:
                                            IF SUBSTR(sicuw.uwm120.class,5,1) = "E" THEN  ASSIGN aycldeto2_fil.textchar2 = "E" .
                                         END.
                                    /*..end A65-0115..*/

                                END.                          /* Avail uwm130 */
                                nv_compcnt = nv_compcnt + 1.  /* record found count */
                            END.      /*IF (SUBSTR(aycldeto2_fil.comdat,1,2) = SUBSTR(nv_comdat,1,2)) OR aycldeto2_fil.comdat = "000000" THEN DO:*/
                            ELSE DO:
                                ASSIGN nv_ncompcnt = nv_ncompcnt + 1   /* record not found count */
                                aycldeto2_fil.remark = "ปีที่คุ้มครองไม่ตรง" 
                                SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm301.policy. /*Lukkana M. A55-0244 01/08/2012*/
                            END.
                        END.        /*--if sicuw.uwm301.trareg = aycldeto2_fil.cha_no--*/
                        ELSE DO:    /*เลขตัวถังรถไม่ตรงกัน*/
                            ASSIGN nv_ncompcnt = nv_ncompcnt + 1    /* record not found count */
                            aycldeto2_fil.remark = "Not Found Policy permitt Chassis " + aycldeto2_fil.cha_no
                            SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm301.policy.
                            /* comment by : Ranu I. A65-0115...
                            nv_si_n        = INTE(aycldeto2_fil.si)
                            nv_prem_n      = INTE(aycldeto2_fil.prem)
                            nv_prem_taxstm = INTE(aycldeto2_fil.premtax) /*A58-0121*/
                            nv_premtot_n   = INTE(aycldeto2_fil.premtot)
                            aycldeto2_fil.si      = TRIM(REPLACE(STRING(nv_si_n,">>>>>>>>>>>>9.99"),".",""))
                            aycldeto2_fil.prem    = TRIM(REPLACE(STRING(nv_prem_n,">>>>>>>>>>>>9.99"),".",""))
                            aycldeto2_fil.premtax = TRIM(REPLACE(STRING(nv_prem_taxstm,">>>>>>>>>>>>9.99"),".","")) /*A58-0121*/
                            aycldeto2_fil.insrayrno = "การประกันภัยรถยนต์(ภาคสมัครใจ)"  /*A58-0121*/
                            aycldeto2_fil.premtot = TRIM(REPLACE(STRING(nv_premtot_n,">>>>>>>>>>>>9.99"),".","")).
                            ....end A65-0115...*/
                        END.
                    END.   /*--if avail sicuw.uwm301--*/
                END.       /*--if avail sicuw.uwm100--*/
                ELSE DO:   /*uwm100.releas = no*/
                    ASSIGN nv_ncompcnt  = nv_ncompcnt + 1   /* record not found count */
                    aycldeto2_fil.remark = "Policy Not Release" 
                    SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm301.policy .
                    /* comment by : Ranu I. A65-0115...
                    nv_si_n        = INTE(aycldeto2_fil.si)
                    nv_prem_n      = INTE(aycldeto2_fil.prem)
                    nv_prem_taxstm = INTE(aycldeto2_fil.premtax) /*A58-0121*/
                    nv_premtot_n   = INTE(aycldeto2_fil.premtot)
                    aycldeto2_fil.si      = TRIM(REPLACE(STRING(nv_si_n,">>>>>>>>>>>>9.99"),".",""))
                    aycldeto2_fil.prem    = TRIM(REPLACE(STRING(nv_prem_n,">>>>>>>>>>>>9.99"),".",""))
                    aycldeto2_fil.premtax = TRIM(REPLACE(STRING(nv_prem_taxstm,">>>>>>>>>>>>9.99"),".","")) /*A58-0121*/
                    aycldeto2_fil.insrayrno = "การประกันภัยรถยนต์(ภาคสมัครใจ)"  /*A58-0121*/
                    aycldeto2_fil.premtot = TRIM(REPLACE(STRING(nv_premtot_n,">>>>>>>>>>>>9.99"),".","")).
                    ....end : A65-0115...*/
                END.
            END.   /*--else do (if not avail uwm100)--*/
        END.       /* Avail uwm301 */
        ELSE DO:   /* Not Avail uwm301 */
            /*--เช็คเงื่อนไขใหม่                     --*/
            FIND LAST sicuw.uwm301 USE-INDEX uwm30103                 WHERE
                sicuw.uwm301.trareg             = aycldeto2_fil.cha_no AND 
                SUBSTR(sicuw.uwm301.policy,3,2) = "70"                NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL uwm301 THEN DO:    /*เช็คทีละเงื่อนไข ถ้า chasiss ตรงกัน (ตามเงื่อนไขข้อ 4,5) */
                IF sicuw.uwm301.policy  <> nv_policyno  THEN DO:  /*ให้เช็คเพิ่มถ้า policy ไม่ตรงกัน*/
                    IF sicuw.uwm301.trareg = ""  THEN DO:
                        ASSIGN nv_ncompcnt = nv_ncompcnt + 1     /* record not found count */
                            aycldeto2_fil.remark = "Chassis is null " 
                            SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm301.policy. 
                    END.      /*IF sicuw.uwm301.trareg = ""  THEN DO:*/
                    ELSE DO:
                        FIND LAST sicuw.uwm100 USE-INDEX uwm10001     WHERE 
                            sicuw.uwm100.policy = sicuw.uwm301.policy AND 
                            sicuw.uwm100.rencnt = sicuw.uwm301.rencnt AND
                            sicuw.uwm100.endcnt = sicuw.uwm301.endcnt AND 
                            sicuw.uwm100.releas = YES                 NO-LOCK NO-ERROR NO-WAIT.
                        IF AVAIL uwm100 THEN DO:
                            ASSIGN nv_dat    = STRING(DAY(sicuw.uwm100.comdat),"99")
                            nv_mon    = STRING(MONTH(sicuw.uwm100.comdat),"99")
                            nv_yea    = STRING(YEAR(sicuw.uwm100.comdat) + 543 , "9999")
                            nv_dat1   = STRING(DAY(sicuw.uwm100.expdat),"99")
                            nv_mon1   = STRING(MONTH(sicuw.uwm100.expdat),"99")
                            nv_yea1   = STRING(YEAR(sicuw.uwm100.expdat) + 543 , "9999")
                            nv_comdat = SUBSTRING(nv_yea,3,2) + nv_mon + nv_dat 
                            nv_expdat = SUBSTRING(nv_yea1,3,2) + nv_mon1 + nv_dat1.
                            IF (SUBSTR(aycldeto2_fil.comdat,1,2) = SUBSTR(nv_comdat,1,2)) OR 
                                (aycldeto2_fil.comdat = "000000") THEN DO:  /*เช็คปีต้องเท่ากับไฟล์ที่ส่งมา หรือถ้าเป็นค่าว่างให้ส่งค่ากลับไป*/
                                ASSIGN aycldeto2_fil.policy  = CAPS(sicuw.uwm100.policy)
                                aycldeto2_fil.comdat  = nv_comdat
                                aycldeto2_fil.expdat  = nv_expdat .
                                FOR EACH sicuw.uwm100 USE-INDEX uwm10091       WHERE 
                                    sicuw.uwm100.releas = YES                  AND 
                                    sicuw.uwm100.policy = sicuw.uwm301.policy  NO-LOCK .
                                    ASSIGN nv_prem   = nv_prem   + sicuw.uwm100.prem_t
                                    nv_rstp_t = nv_rstp_t + sicuw.uwm100.rstp_t
                                    nv_rtax_t = nv_rtax_t + sicuw.uwm100.rtax_t.
                                END.
                                ASSIGN  aycldeto2_fil.prem    = TRIM(REPLACE(STRING(nv_prem,">>>>>>>>>>>>9.99"),".",""))
                                aycldeto2_fil.premtax = TRIM(REPLACE(STRING(nv_rstp_t + nv_rtax_t,">>>>>>>>>>>>9.99"),".","")) /*A58-0121*/
                                aycldeto2_fil.insrayrno = "การประกันภัยรถยนต์(ภาคสมัครใจ)"  /*A58-0121*/
                                aycldeto2_fil.premtot = TRIM(REPLACE(STRING(nv_prem + nv_rstp_t + nv_rtax_t,">>>>>>>>>>>>9.99"),".","")).
                                /**** Insured Item ****/
                                FIND LAST sicuw.uwm130 USE-INDEX uwm13001 WHERE 
                                    sicuw.uwm130.policy = sicuw.uwm301.policy AND
                                    sicuw.uwm130.rencnt = sicuw.uwm301.rencnt AND
                                    sicuw.uwm130.endcnt = sicuw.uwm301.endcnt AND
                                    sicuw.uwm130.riskgp = sicuw.uwm301.riskgp AND
                                    sicuw.uwm130.riskno = sicuw.uwm301.riskno AND
                                    sicuw.uwm130.itemno = sicuw.uwm301.itemno NO-LOCK NO-ERROR NO-WAIT.
                                IF AVAIL uwm130 THEN DO:
                                    /**** SUM INSURE ****/
                                    IF sicuw.uwm301.covcod = "1" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                    ELSE IF sicuw.uwm301.covcod = "2" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom7_v,">>>>>>>>>>>>9.99"),".","").
                                    ELSE IF sicuw.uwm301.covcod = "2.1" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                    ELSE DO: 
                                        /*A57-0291*/
                                        IF      sicuw.uwm130.uom6_v <> 0 THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                        ELSE IF sicuw.uwm130.uom7_v <> 0 THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom7_v,">>>>>>>>>>>>9.99"),".","").
                                        ELSE nv_si = "000000000000000". 
                                        /*A57-0291*/
                                    END.
                                    aycldeto2_fil.si      = TRIM(STRING(nv_si)).

                                    /* add by : A65-0115 */
                                    FIND FIRST  sicuw.uwm120 USE-INDEX uwm12001        WHERE
                                          sicuw.uwm120.policy  = sicuw.uwm130.policy   AND
                                          sicuw.uwm120.rencnt  = sicuw.uwm130.rencnt   AND
                                          sicuw.uwm120.endcnt  = sicuw.uwm130.endcnt   and
                                          sicuw.uwm120.riskgp  = sicuw.uwm130.riskgp   and
                                          sicuw.uwm120.riskno  = sicuw.uwm130.riskno   NO-LOCK NO-ERROR NO-WAIT.
                                         IF AVAIL sicuw.uwm120 THEN DO:
                                            IF SUBSTR(sicuw.uwm120.class,5,1) = "E" THEN  ASSIGN aycldeto2_fil.textchar2 = "E" .
                                         END.
                                    /*..end A65-0115..*/

                                END.   /* Avail uwm130 */
                                nv_compcnt = nv_compcnt + 1.  /* record found count */
                            END.   /*IF (SUBSTR(aycldeto2_fil.comdat,1,2) = SUBSTR(nv_comdat,1,2)) OR aycldeto2_fil.comdat = "000000" */
                            ELSE DO:
                                ASSIGN nv_ncompcnt = nv_ncompcnt + 1   /* record not found count */
                                aycldeto2_fil.remark = "ปีที่คุ้มครองไม่ตรง" 
                                SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm301.policy. 
                            END.
                        END.        /* Avail uwm100 */    
                        ELSE DO:    /*--if not avail uwm100--*/
                            FIND LAST sicuw.uwm100 USE-INDEX uwm10091       WHERE 
                                sicuw.uwm100.releas =  YES                  AND
                                sicuw.uwm100.policy =  sicuw.uwm301.policy  NO-LOCK NO-ERROR NO-WAIT.
                            IF AVAIL sicuw.uwm100 THEN DO:
                                FIND LAST sicuw.uwm301 USE-INDEX uwm30101 WHERE 
                                    sicuw.uwm301.policy = sicuw.uwm100.policy AND
                                    sicuw.uwm301.rencnt = sicuw.uwm100.rencnt AND
                                    sicuw.uwm301.endcnt = sicuw.uwm100.endcnt NO-LOCK NO-ERROR NO-WAIT.
                                IF AVAIL sicuw.uwm301 THEN DO:
                                    IF sicuw.uwm301.trareg = aycldeto2_fil.cha_no THEN DO: /*ย้อนมาเช็คเลขตัวถังรถว่าตรงกันหรือไม่*/
                                        ASSIGN nv_dat    = STRING(DAY(sicuw.uwm100.comdat),"99")
                                        nv_mon    = STRING(MONTH(sicuw.uwm100.comdat),"99")
                                        nv_yea    = STRING(YEAR(sicuw.uwm100.comdat) + 543 , "9999")
                                        nv_dat1   = STRING(DAY(sicuw.uwm100.expdat),"99")
                                        nv_mon1   = STRING(MONTH(sicuw.uwm100.expdat),"99")
                                        nv_yea1   = STRING(YEAR(sicuw.uwm100.expdat) + 543 , "9999")
                                        nv_comdat = SUBSTRING(nv_yea,3,2) + nv_mon + nv_dat 
                                        nv_expdat = SUBSTRING(nv_yea1,3,2) + nv_mon1 + nv_dat1.
                                        IF (SUBSTR(aycldeto2_fil.comdat,1,2) = SUBSTR(nv_comdat,1,2)) OR 
                                            (aycldeto2_fil.comdat = "000000") THEN DO:   /*เช็คปีต้องเท่ากับไฟล์ที่ส่งมา หรือถ้าเป็นค่าว่างให้ส่งค่ากลับไป*/
                                            ASSIGN aycldeto2_fil.policy  = CAPS(sicuw.uwm100.policy)
                                            aycldeto2_fil.comdat  = nv_comdat
                                            aycldeto2_fil.expdat  = nv_expdat .
                                            FOR EACH sicuw.uwm100 USE-INDEX uwm10091      WHERE 
                                                sicuw.uwm100.releas = YES                 AND
                                                sicuw.uwm100.policy = sicuw.uwm301.policy NO-LOCK. /*คำนวณเบี้ย*/
                                                ASSIGN nv_prem   = nv_prem   + sicuw.uwm100.prem_t
                                                nv_rstp_t = nv_rstp_t + sicuw.uwm100.rstp_t
                                                nv_rtax_t = nv_rtax_t + sicuw.uwm100.rtax_t.
                                            END.
                                            ASSIGN aycldeto2_fil.prem    = TRIM(REPLACE(STRING(nv_prem,">>>>>>>>>>>>9.99"),".",""))
                                            aycldeto2_fil.premtax = TRIM(REPLACE(STRING(nv_rstp_t + nv_rtax_t,">>>>>>>>>>>>9.99"),".","")) /*A58-0121*/
                                            aycldeto2_fil.insrayrno = "การประกันภัยรถยนต์(ภาคสมัครใจ)"  /*A58-0121*/
                                            aycldeto2_fil.premtot = TRIM(REPLACE(STRING(nv_prem + nv_rstp_t + nv_rtax_t,">>>>>>>>>>>>9.99"),".","")).
                                            /**** Insured Item ****/
                                            FIND LAST sicuw.uwm130 USE-INDEX uwm13001 WHERE 
                                                sicuw.uwm130.policy = sicuw.uwm301.policy AND
                                                sicuw.uwm130.rencnt = sicuw.uwm301.rencnt AND
                                                sicuw.uwm130.endcnt = sicuw.uwm301.endcnt AND
                                                sicuw.uwm130.riskgp = sicuw.uwm301.riskgp AND
                                                sicuw.uwm130.riskno = sicuw.uwm301.riskno AND
                                                sicuw.uwm130.itemno = sicuw.uwm301.itemno NO-LOCK NO-ERROR NO-WAIT.
                                            IF AVAIL uwm130 THEN DO:
                                                /**** SUM INSURE ****/
                                                IF sicuw.uwm301.covcod = "1" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                                ELSE IF sicuw.uwm301.covcod = "2" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom7_v,">>>>>>>>>>>>9.99"),".","").
                                                ELSE IF sicuw.uwm301.covcod = "2.1" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                                ELSE DO: 
                                                    /*A57-0291*/
                                                    IF      sicuw.uwm130.uom6_v <> 0 THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                                    ELSE IF sicuw.uwm130.uom7_v <> 0 THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom7_v,">>>>>>>>>>>>9.99"),".","").
                                                    ELSE nv_si = "000000000000000". 
                                                    /*A57-0291*/
                                                END.
                                                aycldeto2_fil.si      = TRIM(STRING(nv_si)).

                                                /* add by : A65-0115 */
                                                FIND FIRST  sicuw.uwm120 USE-INDEX uwm12001        WHERE
                                                      sicuw.uwm120.policy  = sicuw.uwm130.policy   AND
                                                      sicuw.uwm120.rencnt  = sicuw.uwm130.rencnt   AND
                                                      sicuw.uwm120.endcnt  = sicuw.uwm130.endcnt   and
                                                      sicuw.uwm120.riskgp  = sicuw.uwm130.riskgp   and
                                                      sicuw.uwm120.riskno  = sicuw.uwm130.riskno   NO-LOCK NO-ERROR NO-WAIT.
                                                     IF AVAIL sicuw.uwm120 THEN DO:
                                                        IF SUBSTR(sicuw.uwm120.class,5,1) = "E" THEN  ASSIGN aycldeto2_fil.textchar2 = "E" .
                                                     END.
                                                /*..end A65-0115..*/
                                                
                                            END.                          /* Avail uwm130 */
                                            nv_compcnt = nv_compcnt + 1.  /* record found count */
                                        END.         /*IF (SUBSTR(aycldeto2_fil.comdat,1,2) = SUBSTR(nv_comdat,1,2)) OR aycldeto2_fil.comdat = "000000" THEN DO:*/
                                        ELSE DO:
                                            ASSIGN nv_ncompcnt                     = nv_ncompcnt + 1  /* record not found count */
                                            aycldeto2_fil.remark                = "ปีที่คุ้มครองไม่ตรง" 
                                            SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm301.policy. 
                                        END.
                                    END.        /*--if sicuw.uwm301.trareg = aycldeto2_fil.cha_no--*/
                                    ELSE DO:    /*เลขตัวถังรถไม่ตรงกัน*/
                                        ASSIGN nv_ncompcnt = nv_ncompcnt + 1   /* record not found count */
                                        aycldeto2_fil.remark = "Not Found Policy permitt Chassis " + aycldeto2_fil.cha_no
                                        SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm301.policy .
                                        /* comment by : Ranu I. A65-0115...
                                        nv_si_n              = INTE(aycldeto2_fil.si)
                                        nv_prem_n            = INTE(aycldeto2_fil.prem)
                                        nv_prem_taxstm       = INTE(aycldeto2_fil.premtax) /*A58-0121*/
                                        nv_premtot_n         = INTE(aycldeto2_fil.premtot) 
                                        aycldeto2_fil.si      = TRIM(REPLACE(STRING(nv_si_n,">>>>>>>>>>>>9.99"),".",""))
                                        aycldeto2_fil.prem    = TRIM(REPLACE(STRING(nv_prem_n,">>>>>>>>>>>>9.99"),".",""))
                                        aycldeto2_fil.premtax = TRIM(REPLACE(STRING(nv_prem_taxstm,">>>>>>>>>>>>9.99"),".","")) /*A58-0121*/
                                        aycldeto2_fil.insrayrno = "การประกันภัยรถยนต์(ภาคสมัครใจ)"  /*A58-0121*/
                                        aycldeto2_fil.premtot = TRIM(REPLACE(STRING(nv_premtot_n,">>>>>>>>>>>>9.99"),".","")).
                                        ...end A65-0115...*/
                                    END.
                                END.      /*--if avail sicuw.uwm301--*/
                            END.          /*--if avail sicuw.uwm100--*/
                            ELSE DO:      /*uwm100.releas = no */
                                ASSIGN nv_ncompcnt = nv_ncompcnt + 1   /* record not found count */
                                aycldeto2_fil.remark = "Policy Not Release" 
                                SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm301.policy .
                                /* comment by : Ranu I. A65-0115...
                                nv_si_n              = INTE(aycldeto2_fil.si)
                                nv_prem_n            = INTE(aycldeto2_fil.prem)
                                nv_prem_taxstm       = INTE(aycldeto2_fil.premtax) /*A58-0121*/
                                nv_premtot_n         = INTE(aycldeto2_fil.premtot)
                                aycldeto2_fil.si      = TRIM(REPLACE(STRING(nv_si_n,">>>>>>>>>>>>9.99"),".",""))
                                aycldeto2_fil.prem    = TRIM(REPLACE(STRING(nv_prem_n,">>>>>>>>>>>>9.99"),".",""))
                                aycldeto2_fil.premtax = TRIM(REPLACE(STRING(nv_prem_taxstm,">>>>>>>>>>>>9.99"),".","")) /*A58-0121*/
                                aycldeto2_fil.insrayrno = "การประกันภัยรถยนต์(ภาคสมัครใจ)"  /*A58-0121*/
                                aycldeto2_fil.premtot = TRIM(REPLACE(STRING(nv_premtot_n,">>>>>>>>>>>>9.99"),".","")).
                                ...end A65-0115...*/
                            END.
                        END.      /*--else do (if not avail uwm100)--*/
                    END.          /*IF sicuw.uwm301.trareg <> ""  THEN DO:*/
                END.              /*IF sicuw.uwm301.policy  <> aycldeto2_fil.notify THEN DO: /*ให้เช็คเพิ่มถ้า policy ไม่ตรงกัน*/ */
            END.                  /*FIND LAST sicuw.uwm301 USE-INDEX uwm30103 WHERE if avail sicuw.uwm301*/
            ELSE DO: 
                FIND LAST sicuw.uwm301 USE-INDEX uwm30101                  WHERE
                    sicuw.uwm301.policy             = nv_policyno          AND 
                    SUBSTR(sicuw.uwm301.policy,3,2) = "70"                 NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL uwm301 THEN DO:  /*ถ้า chasiss ไม่ตรง ให้มาเช็คกรมธรรม์ ถ้าตรงกัน ให้ทำ (ตามเงื่อนไขข้อ 2,3)*/
                    ASSIGN nv_name = "" 
                    nv_name = TRIM(aycldeto2_fil.fname) + " " + TRIM(aycldeto2_fil.lname).
                    FIND FIRST sicsyac.xtm600 USE-INDEX xtm60002 WHERE sicsyac.xtm600.NAME = nv_name NO-LOCK NO-ERROR.
                    IF AVAIL xtm600 THEN nv_acno = xtm600.acno.
                    ELSE nv_acno = "".
                    IF sicuw.uwm301.trareg = ""  THEN DO:
                        ASSIGN nv_ncompcnt  = nv_ncompcnt + 1    /* record not found count */
                        aycldeto2_fil.remark = "Chassis is null " 
                        SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm301.policy.  
                    END.     /*IF sicuw.uwm301.trareg = ""  THEN DO:*/
                    ELSE DO:
                        IF  nv_acno = ""  THEN DO:  /*ถ้าชื่อ-นามสกุล เป็นค่าว่างไม่ส่งข้อมูล ตรงกับเงื่อนไขข้อ 3*/
                            ASSIGN nv_ncompcnt      = nv_ncompcnt + 1   /* record not found count */
                            aycldeto2_fil.remark = "Not Found Name  " + nv_name
                            SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm301.policy. 
                        END.
                        ELSE DO: 
                            FIND LAST sicuw.uwm100 USE-INDEX uwm10001     WHERE 
                                sicuw.uwm100.policy = sicuw.uwm301.policy AND 
                                sicuw.uwm100.rencnt = sicuw.uwm301.rencnt AND
                                sicuw.uwm100.endcnt = sicuw.uwm301.endcnt AND 
                                sicuw.uwm100.releas = YES                 NO-LOCK NO-ERROR NO-WAIT.
                            IF AVAIL uwm100 THEN DO:
                                IF sicuw.uwm100.insref = nv_acno THEN DO: 
                                    /*  Mapping ตามชื่อ ถ้าตรงกันให้แสดงข้อมูล เงื่อนไขข้อ2*/
                                    ASSIGN nv_dat   = STRING(DAY(sicuw.uwm100.comdat),"99")
                                    nv_mon   = STRING(MONTH(sicuw.uwm100.comdat),"99")
                                    nv_yea   = STRING(YEAR(sicuw.uwm100.comdat) + 543 , "9999")
                                    nv_dat1  = STRING(DAY(sicuw.uwm100.expdat),"99")
                                    nv_mon1  = STRING(MONTH(sicuw.uwm100.expdat),"99")
                                    nv_yea1  = STRING(YEAR(sicuw.uwm100.expdat) + 543 , "9999")
                                    nv_comdat = SUBSTRING(nv_yea,3,2) + nv_mon + nv_dat 
                                    nv_expdat = SUBSTRING(nv_yea1,3,2) + nv_mon1 + nv_dat1.
                                    IF (SUBSTR(aycldeto2_fil.comdat,1,2) = SUBSTR(nv_comdat,1,2)) OR (aycldeto2_fil.comdat = "000000") THEN DO: /*เช็คปีต้องเท่ากับไฟล์ที่ส่งมา หรือถ้าเป็นค่าว่างให้ส่งค่ากลับไป*/
                                        ASSIGN aycldeto2_fil.policy  = CAPS(sicuw.uwm100.policy)
                                        aycldeto2_fil.comdat  = nv_comdat
                                        aycldeto2_fil.expdat  = nv_expdat .
                                        FOR EACH sicuw.uwm100 USE-INDEX uwm10091       WHERE 
                                            sicuw.uwm100.releas = YES                  AND
                                            sicuw.uwm100.policy = sicuw.uwm301.policy  NO-LOCK.
                                            ASSIGN nv_prem   = nv_prem   + sicuw.uwm100.prem_t
                                            nv_rstp_t = nv_rstp_t + sicuw.uwm100.rstp_t
                                            nv_rtax_t = nv_rtax_t + sicuw.uwm100.rtax_t.
                                        END.
                                        ASSIGN aycldeto2_fil.prem    = TRIM(REPLACE(STRING(nv_prem,">>>>>>>>>>>>9.99"),".",""))
                                        aycldeto2_fil.premtax = TRIM(REPLACE(STRING(nv_rstp_t + nv_rtax_t,">>>>>>>>>>>>9.99"),".","")) /*A58-0121*/
                                        aycldeto2_fil.insrayrno = "การประกันภัยรถยนต์(ภาคสมัครใจ)"  /*A58-0121*/
                                        aycldeto2_fil.premtot = TRIM(REPLACE(STRING(nv_prem + nv_rstp_t + nv_rtax_t,">>>>>>>>>>>>9.99"),".","")).
                                        /**** Insured Item ****/
                                        FIND LAST sicuw.uwm130 USE-INDEX uwm13001 WHERE 
                                            sicuw.uwm130.policy = sicuw.uwm301.policy AND
                                            sicuw.uwm130.rencnt = sicuw.uwm301.rencnt AND
                                            sicuw.uwm130.endcnt = sicuw.uwm301.endcnt AND
                                            sicuw.uwm130.riskgp = sicuw.uwm301.riskgp AND
                                            sicuw.uwm130.riskno = sicuw.uwm301.riskno AND
                                            sicuw.uwm130.itemno = sicuw.uwm301.itemno NO-LOCK NO-ERROR NO-WAIT.
                                        IF AVAIL uwm130 THEN DO:
                                            /**** SUM INSURE ****/
                                            IF sicuw.uwm301.covcod = "1" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                            ELSE IF sicuw.uwm301.covcod = "2" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom7_v,">>>>>>>>>>>>9.99"),".","").
                                            ELSE IF sicuw.uwm301.covcod = "2.1" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                            ELSE DO: 
                                                /*A57-0291*/
                                                IF      sicuw.uwm130.uom6_v <> 0 THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                                ELSE IF sicuw.uwm130.uom7_v <> 0 THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom7_v,">>>>>>>>>>>>9.99"),".","").
                                                ELSE nv_si = "000000000000000". 
                                                /*A57-0291*/
                                            END.
                                            aycldeto2_fil.si      = TRIM(STRING(nv_si)).

                                            /* add by : A65-0115 */
                                            FIND FIRST  sicuw.uwm120 USE-INDEX uwm12001        WHERE
                                                  sicuw.uwm120.policy  = sicuw.uwm130.policy   AND
                                                  sicuw.uwm120.rencnt  = sicuw.uwm130.rencnt   AND
                                                  sicuw.uwm120.endcnt  = sicuw.uwm130.endcnt   and
                                                  sicuw.uwm120.riskgp  = sicuw.uwm130.riskgp   and
                                                  sicuw.uwm120.riskno  = sicuw.uwm130.riskno   NO-LOCK NO-ERROR NO-WAIT.
                                                 IF AVAIL sicuw.uwm120 THEN DO:
                                                    IF SUBSTR(sicuw.uwm120.class,5,1) = "E" THEN  ASSIGN aycldeto2_fil.textchar2 = "E" .
                                                 END.
                                            /*..end A65-0115..*/

                                        END.  /* Avail uwm130 */
                                        nv_compcnt = nv_compcnt + 1.   /* record found count */
                                    END.    /*IF (SUBSTR(aycldeto2_fil.comdat,1,2) = SUBSTR(nv_comdat,1,2)) OR aycldeto2_fil.comdat = "000000" THEN DO:*/
                                    ELSE DO:
                                        ASSIGN nv_ncompcnt = nv_ncompcnt + 1   /* record not found count */
                                        aycldeto2_fil.remark = "ปีที่คุ้มครองไม่ตรง" 
                                        SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm100.policy. /*Lukkana M. A55-0244 01/08/2012*/
                                    END.
                                END.       /*IF sicuw.uwm100.insref = nv_acno THEN DO: /*Lukkana M. A53-0161 30/04/2010 Mapping ตามชื่อ ถ้าตรงกันให้แสดงข้อมูล*/*/
                                ELSE DO:   /*ชื่อ-สกุลไม่ตรงกัน*/
                                    ASSIGN nv_ncompcnt = nv_ncompcnt + 1    /* record not found count */
                                    aycldeto2_fil.remark = "Not Found Name  " + nv_name
                                    SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm100.policy. 
                                END.
                            END.           /* Avail uwm100 */  
                            ELSE DO:       /*--if not avail uwm100--*/
                                FIND LAST sicuw.uwm100 USE-INDEX uwm10091     WHERE 
                                    sicuw.uwm100.releas = YES                 AND
                                    sicuw.uwm100.policy = sicuw.uwm301.policy NO-LOCK NO-ERROR NO-WAIT.
                                IF AVAIL sicuw.uwm100 THEN DO:
                                    FIND LAST sicuw.uwm301 USE-INDEX uwm30101 WHERE 
                                        sicuw.uwm301.policy = sicuw.uwm100.policy AND
                                        sicuw.uwm301.rencnt = sicuw.uwm100.rencnt AND
                                        sicuw.uwm301.endcnt = sicuw.uwm100.endcnt NO-LOCK NO-ERROR NO-WAIT.
                                    IF AVAIL sicuw.uwm301 THEN DO:
                                        IF sicuw.uwm301.trareg = aycldeto2_fil.cha_no THEN DO:  /*ย้อนมาเช็คเลขตัวถังรถว่าตรงกันหรือไม่*/
                                            ASSIGN nv_dat = STRING(DAY(sicuw.uwm100.comdat),"99")
                                            nv_mon    = STRING(MONTH(sicuw.uwm100.comdat),"99")
                                            nv_yea    = STRING(YEAR(sicuw.uwm100.comdat) + 543 , "9999")
                                            nv_dat1   = STRING(DAY(sicuw.uwm100.expdat),"99")
                                            nv_mon1   = STRING(MONTH(sicuw.uwm100.expdat),"99")
                                            nv_yea1   = STRING(YEAR(sicuw.uwm100.expdat) + 543 , "9999")
                                            nv_comdat = SUBSTRING(nv_yea,3,2) + nv_mon + nv_dat 
                                            nv_expdat = SUBSTRING(nv_yea1,3,2) + nv_mon1 + nv_dat1.
                                            IF (SUBSTR(aycldeto2_fil.comdat,1,2) = SUBSTR(nv_comdat,1,2)) OR 
                                                (aycldeto2_fil.comdat = "000000") THEN DO:  /*เช็คปีต้องเท่ากับไฟล์ที่ส่งมา หรือถ้าเป็นค่าว่างให้ส่งค่ากลับไป*/
                                                ASSIGN aycldeto2_fil.policy  = CAPS(sicuw.uwm100.policy)
                                                aycldeto2_fil.comdat  = nv_comdat
                                                aycldeto2_fil.expdat  = nv_expdat .
                                                FOR EACH sicuw.uwm100 USE-INDEX uwm10091      WHERE 
                                                    sicuw.uwm100.releas = YES                 AND
                                                    sicuw.uwm100.policy = sicuw.uwm301.policy NO-LOCK. /*คำนวณเบี้ย*/
                                                    ASSIGN nv_prem   = nv_prem   + sicuw.uwm100.prem_t
                                                    nv_rstp_t = nv_rstp_t + sicuw.uwm100.rstp_t
                                                    nv_rtax_t = nv_rtax_t + sicuw.uwm100.rtax_t.
                                                END.
                                                ASSIGN aycldeto2_fil.prem = TRIM(REPLACE(STRING(nv_prem,">>>>>>>>>>>>9.99"),".",""))
                                                    aycldeto2_fil.premtax = TRIM(REPLACE(STRING(nv_rstp_t + nv_rtax_t,">>>>>>>>>>>>9.99"),".","")) /*A58-0121*/
                                                    aycldeto2_fil.insrayrno = "การประกันภัยรถยนต์(ภาคสมัครใจ)"  /*A58-0121*/
                                                    aycldeto2_fil.premtot = TRIM(REPLACE(STRING(nv_prem + nv_rstp_t + nv_rtax_t,">>>>>>>>>>>>9.99"),".","")).
                                                /**** Insured Item ****/
                                                FIND LAST sicuw.uwm130 USE-INDEX uwm13001 WHERE 
                                                    sicuw.uwm130.policy = sicuw.uwm301.policy AND
                                                    sicuw.uwm130.rencnt = sicuw.uwm301.rencnt AND
                                                    sicuw.uwm130.endcnt = sicuw.uwm301.endcnt AND
                                                    sicuw.uwm130.riskgp = sicuw.uwm301.riskgp AND
                                                    sicuw.uwm130.riskno = sicuw.uwm301.riskno AND
                                                    sicuw.uwm130.itemno = sicuw.uwm301.itemno NO-LOCK NO-ERROR NO-WAIT.
                                                IF AVAIL uwm130 THEN DO:
                                                    /**** SUM INSURE ****/
                                                    IF sicuw.uwm301.covcod = "1" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                                    ELSE IF sicuw.uwm301.covcod = "2" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom7_v,">>>>>>>>>>>>9.99"),".","").
                                                    ELSE IF sicuw.uwm301.covcod = "2.1" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                                    ELSE DO: 
                                                        /*A57-0291*/
                                                        IF      sicuw.uwm130.uom6_v <> 0 THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                                        ELSE IF sicuw.uwm130.uom7_v <> 0 THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom7_v,">>>>>>>>>>>>9.99"),".","").
                                                        ELSE nv_si = "000000000000000". 
                                                        /*A57-0291*/
                                                    END.
                                                    aycldeto2_fil.si      = TRIM(STRING(nv_si)).

                                                    /* add by : A65-0115 */
                                                    FIND FIRST  sicuw.uwm120 USE-INDEX uwm12001        WHERE
                                                          sicuw.uwm120.policy  = sicuw.uwm130.policy   AND
                                                          sicuw.uwm120.rencnt  = sicuw.uwm130.rencnt   AND
                                                          sicuw.uwm120.endcnt  = sicuw.uwm130.endcnt   and
                                                          sicuw.uwm120.riskgp  = sicuw.uwm130.riskgp   and
                                                          sicuw.uwm120.riskno  = sicuw.uwm130.riskno   NO-LOCK NO-ERROR NO-WAIT.
                                                         IF AVAIL sicuw.uwm120 THEN DO:
                                                            IF SUBSTR(sicuw.uwm120.class,5,1) = "E" THEN  ASSIGN aycldeto2_fil.textchar2 = "E" .
                                                         END.
                                                    /*..end A65-0115..*/

                                                END.     /* Avail uwm130 */
                                                nv_compcnt = nv_compcnt + 1.  /* record found count */
                                            END.    /*IF (SUBSTR(aycldeto2_fil.comdat,1,2) = SUBSTR(nv_comdat,1,2)) OR aycldeto2_fil.comdat = "000000" THEN DO:*/
                                            ELSE DO:
                                                ASSIGN nv_ncompcnt      = nv_ncompcnt + 1    /* record not found count */
                                                aycldeto2_fil.remark = "ปีที่คุ้มครองไม่ตรง" 
                                                SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm301.policy. 
                                            END. 
                                        END.       /*--if sicuw.uwm301.trareg = aycldeto2_fil.cha_no--*/
                                        ELSE DO:   /*เลขตัวถังรถไม่ตรงกัน*/
                                            ASSIGN nv_ncompcnt = nv_ncompcnt + 1    /* record not found count */
                                            aycldeto2_fil.remark = "Not Found Policy permitt Chassis " + aycldeto2_fil.cha_no
                                            SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm301.policy .
                                            /* comment by : Ranu I. A65-0115...
                                            nv_si_n        = INTE(aycldeto2_fil.si)
                                            nv_prem_n      = INTE(aycldeto2_fil.prem)
                                            nv_prem_taxstm = INTE(aycldeto2_fil.premtax) /*A58-0121*/
                                            nv_premtot_n   = INTE(aycldeto2_fil.premtot)
                                            aycldeto2_fil.si      = TRIM(REPLACE(STRING(nv_si_n,">>>>>>>>>>>>9.99"),".",""))
                                            aycldeto2_fil.prem    = TRIM(REPLACE(STRING(nv_prem_n,">>>>>>>>>>>>9.99"),".",""))
                                            aycldeto2_fil.premtax = TRIM(REPLACE(STRING(nv_prem_taxstm,">>>>>>>>>>>>9.99"),".","")) /*A58-0121*/
                                            aycldeto2_fil.insrayrno = "การประกันภัยรถยนต์(ภาคสมัครใจ)"  /*A58-0121*/
                                            aycldeto2_fil.premtot = TRIM(REPLACE(STRING(nv_premtot_n,">>>>>>>>>>>>9.99"),".","")).
                                            ...end A65-0115...*/
                                        END.
                                    END.     /*--if avail sicuw.uwm301--*/
                                END.         /*--if avail sicuw.uwm100--*/
                                ELSE DO:     /*uwm100.releas = no  */
                                    ASSIGN nv_ncompcnt = nv_ncompcnt + 1   /* record not found count */
                                    aycldeto2_fil.remark = "Policy Not Release" 
                                    SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm301.policy .
                                    /* comment by : Ranu I. A65-0115...
                                    nv_si_n        = INTE(aycldeto2_fil.si)
                                    nv_prem_n      = INTE(aycldeto2_fil.prem)
                                    nv_prem_taxstm = INTE(aycldeto2_fil.premtax) /*A58-0121*/
                                    nv_premtot_n   = INTE(aycldeto2_fil.premtot) 
                                    aycldeto2_fil.si      = TRIM(REPLACE(STRING(nv_si_n,">>>>>>>>>>>>9.99"),".",""))
                                    aycldeto2_fil.prem    = TRIM(REPLACE(STRING(nv_prem_n,">>>>>>>>>>>>9.99"),".",""))
                                    aycldeto2_fil.premtax = TRIM(REPLACE(STRING(nv_prem_taxstm,">>>>>>>>>>>>9.99"),".","")) /*A58-0121*/
                                    aycldeto2_fil.insrayrno = "การประกันภัยรถยนต์(ภาคสมัครใจ)"  /*A58-0121*/
                                    aycldeto2_fil.premtot = TRIM(REPLACE(STRING(nv_premtot_n,">>>>>>>>>>>>9.99"),".","")).
                                    ....end : A65-0115...*/
                                END.
                            END.    /*--else do (if not avail uwm100)--*/
                        END.        /*IF nv_acno <> "" THEN DO: ถ้าชื่อ-นามสกุล ไม่เป็นค่าว่าง ให้เช็คว่าตรงกันหรือไม่*/
                    END.            /*IF sicuw.uwm301.trareg <> ""  THEN DO:*/
                END.                /*if avail uwm301*/
                ELSE DO:
                    ASSIGN nv_ncompcnt      = nv_ncompcnt + 1  /* record not found count */
                    aycldeto2_fil.remark = "Not Found Policy permitt Chassis " + aycldeto2_fil.cha_no.

                    FIND LAST sicuw.uwm301 USE-INDEX uwm30103                       WHERE
                        sicuw.uwm301.trareg             = aycldeto2_fil.cha_no AND 
                        SUBSTR(sicuw.uwm301.policy,3,2) = "70"                NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAIL sicuw.uwm301 THEN DO:
                        SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm301.policy.  
                    END.
                    ELSE DO:
                        FIND LAST sicuw.uwm100 USE-INDEX uwm10001                 WHERE
                            sicuw.uwm100.policy             = nv_policyno         AND 
                            SUBSTR(sicuw.uwm301.policy,3,2) = "70"                NO-LOCK NO-ERROR NO-WAIT.
                        IF AVAIL sicuw.uwm301 THEN SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm100.policy.
                    END.
                    /* comment by : Ranu I. A65-0115...
                    ASSIGN nv_si_n       = INTE(aycldeto2_fil.si)
                    nv_prem_n            = INTE(aycldeto2_fil.prem)
                    nv_prem_taxstm       = INTE(aycldeto2_fil.premtax) /*A58-0121*/
                    nv_premtot_n         = INTE(aycldeto2_fil.premtot)
                    aycldeto2_fil.si      = TRIM(REPLACE(STRING(nv_si_n,">>>>>>>>>>>>9.99"),".",""))
                    aycldeto2_fil.prem    = TRIM(REPLACE(STRING(nv_prem_n,">>>>>>>>>>>>9.99"),".",""))
                    aycldeto2_fil.premtax = TRIM(REPLACE(STRING(nv_prem_taxstm,">>>>>>>>>>>>9.99"),".","")) /*A58-0121*/
                    aycldeto2_fil.insrayrno = "การประกันภัยรถยนต์(ภาคสมัครใจ)"  /*A58-0121*/
                    aycldeto2_fil.premtot = TRIM(REPLACE(STRING(nv_premtot_n,">>>>>>>>>>>>9.99"),".","")).
                    ...end : A65-0115...*/
                END. 
            END.    /*else do*/
        END.         
    END.           /* FOR EACH aycldeto2_fil */
    RELEASE aycldeto2_fil.
END.   /*if nv_outagent2 = ""*/


  
