/* WGWMATCH.P  : Program Matching Chassis No.                           */
/* Copyright   # Safety Insurance Public Company Limited                */
/*               บริษัท ประกันคุ้มภัย จำกัด (มหาชน)                     */
/* WRITE       : TANTAWAN C.  [A51-0140 : 18/09/2008]                   */
/* Modify By   : Lukkana M.  Date 24/06/2009                            */
/* Assign No   : A52-0136 แก้ไขให้เอาเครื่องหมาย " ออก และแก้ไขเบี้ย    */
/*              เนื่องจากมีค่าติดลบทำให้ค่าที่แสดงออกมาเป็น ?           */
/* Modify By   : Lukkana M.  Date 04/09/2009                            */
/* Assign No   : A52-0225 ปรับโปรแกรมให้แสดงข้อมูลเฉพาะ Line 70 เท่านั้น*/
/* Modify By   : Lukkana M. Date 31/03/2010                             */
/* Assign no   : A53-0135 แก้ไขคอลัมน์ทุนประกัน,เบี้ย,เบี้ยสุทธิ โดยให้ */
/*               ตัด 0 ที่อยู่ด้านหน้าออก                               */ 
/* Modity By   : Lukkana M.  Date 22/04/2010                            */ 
/* Assign No   : A53-0161 เพิ่มเช็คข้อมูลตามกรมธรรม์ และปีที่คุ้มครอง   */
/*              และหากไม่พบข้อมูลในระบบไม่ต้องoutput ข้อมูลนั้นออกมา    */
/* Modify By   : Lukkana M. Date 31/05/2012                             */            
/* Assign No   : A55-0175                                               */
/* Modify By   : Lukkana M. Date 05/07/2012                             */
/* Assign No   : A55-0209                                               */
/* Modify By   : Lukkana M. Date 27/08/2012                             */
/* Assign No   : A55-0244                                               */
/* Modify by   : Kridtiya i. A56-0119 ปรับเลขกรมธรรม์โดยตัดเครื่องหมายออก*/
/* Modify      : Kridtiya i. A57-0291 date. 15/08/2014 
                    เพิ่มการให้ค่าทุนประกัน จากเดิม ใช้ ป 1,ป 2         */ 
/* Modify by   : Ranu I. A65-0115 แก้ไขการออกรายงานเฉพาะงานที่ Release แล้ว 
                 แก้ไข Format ตาม AYCAL                                 */                
/*----------------------------------------------------------------------*/

DEF SHARED VAR nv_bchyr    AS INT.
DEF SHARED VAR nv_bchno    AS CHAR.
DEF SHARED VAR nv_bchcnt   AS INT.
DEF SHARED VAR nv_compcnt  AS INT.
DEF SHARED VAR nv_ncompcnt AS INT.
DEF SHARED VAR nv_outagent AS CHAR. /*Lukkana M. A55-0209 11/07/2012*/

DEF VAR nv_comdat AS CHAR.
DEF VAR nv_expdat AS CHAR.
DEF VAR nv_date   AS DATE.
DEF VAR nv_si     AS CHAR.

/* Lukkana M. A52-0136 24/06/2009*/
DEF BUFFER buwm100 FOR sicuw.uwm100. 
DEF VAR nv_prem      AS DECI.
DEF VAR nv_rstp_t    AS DECI.
DEF VAR nv_rtax_t    AS DECI.
/* Lukkana M. A52-0136 24/06/2009*/
DEF VAR nv_prem_n       AS DECI FORMAT ">>>,>>>,>>9.99".
DEF VAR nv_prem_taxstm  AS DECI FORMAT ">>>,>>>,>>9.99".  /*A58-0121*/
DEF VAR nv_premtot_n AS DECI FORMAT ">>>,>>>,>>9.99".
DEF VAR nv_si_n      AS DECI FORMAT ">>>,>>>,>>9.99".
DEF VAR nv_name      AS CHAR . /*Lukkana M. A53-0161 30/04/2010*/
DEF VAR nv_acno      AS CHAR . /*Lukkana M. A53-0161 30/04/2010*/

DEF VAR nv_mon    AS CHAR FORMAT "X(2)". /*Lukkana M. A55-0209 05/07/2012*/
DEF VAR nv_yea    AS CHAR FORMAT "X(4)". /*Lukkana M. A55-0209 05/07/2012*/
DEF VAR nv_dat    AS CHAR FORMAT "X(2)". /*Lukkana M. A55-0209 05/07/2012*/

DEF VAR nv_mon1    AS CHAR FORMAT "X(2)". /*Lukkana M. A55-0209 05/07/2012*/
DEF VAR nv_yea1    AS CHAR FORMAT "X(4)". /*Lukkana M. A55-0209 05/07/2012*/
DEF VAR nv_dat1    AS CHAR FORMAT "X(2)". /*Lukkana M. A55-0209 05/07/2012*/
DEF VAR nv_i         AS INT.   /*A56-0119*/
DEF VAR nv_policyno  AS CHAR.  /*A56-0119*/
DEF VAR nv_l         AS INT.   /*A56-0119*/
DEF VAR nv_p         AS CHAR.  /*A56-0119*/
DEF VAR ind          AS INT.   /*A56-0119*/

    nv_compcnt = 0.
    nv_ncompcnt = 0.

  IF nv_outagent <> "" THEN DO: /*Lukkana M. A55-0209 18/07/2012*/

    FOR EACH aycldeto2_fil WHERE 
        aycldeto2_fil.bchyr  = nv_bchyr  AND
        aycldeto2_fil.bchno  = nv_bchno  AND
        aycldeto2_fil.bchcnt = nv_bchcnt AND
       (aycldeto2_fil.rectyp <> "H" AND   /* Header */
        aycldeto2_fil.rectyp <> "T" )     /* Total */
    :    

       /*---- Lukkana M. A52-0136 24/06/2009 -----*/
        ASSIGN
            nv_prem   = 0 
            nv_rstp_t = 0
            nv_rtax_t = 0
            nv_dat    = ""  /*Lukkana M. A55-0209 05/07/2012*/
            nv_mon    = ""  /*Lukkana M. A55-0209 05/07/2012*/
            nv_yea    = ""  /*Lukkana M. A55-0209 05/07/2012*/
            nv_policyno = trim(aycldeto2_fil.notify)  /*A56-0119*/
            nv_i        = 0                          /*A56-0119*/
            nv_l        = LENGTH(nv_policyno).       /*A56-0119*/
        /*add Kridtiya i. A56-0119 */
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
        /*end ...add Kridtiya i. A56-0119 */
        
     FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE 
                    /*sicuw.uwm100.policy  = aycldeto2_fil.notify   AND*/  /*A56-0119*/
                    sicuw.uwm100.policy  = nv_policyno           AND      /*A56-0119*/ 
                    sicuw.uwm100.releas  = YES                   AND
           /*INDEX(nv_outagent,"," + TRIM(sicuw.uwm100.acno1))    <> 0 NO-LOCK NO-ERROR NO-WAIT.*//*A56-0119*/
         INDEX(nv_outagent,TRIM(sicuw.uwm100.acno1))    <> 0 NO-LOCK NO-ERROR NO-WAIT.            /*A56-0119*/
     IF AVAIL sicuw.uwm100 THEN DO: /*Lukkana M. A55-0209 18/07/2012*/
        /*----Lukkana M. A52-0225 04/08/2009----*/
        FIND LAST sicuw.uwm301 USE-INDEX uwm30103                       WHERE
                  sicuw.uwm301.trareg             = aycldeto2_fil.cha_no AND 
                 /*sicuw.uwm301.policy            = aycldeto2_fil.notify AND /*Lukkana M. A53-0161 22/04/2010*/*//*A56-0119*/
                  sicuw.uwm301.policy             = nv_policyno         AND                                       /*A56-0119*/
                  SUBSTR(sicuw.uwm301.policy,3,2) = "70"                NO-LOCK NO-ERROR NO-WAIT.
        /*----Lukkana M. A52-0225 04/08/2009----*/  
        IF AVAIL uwm301 THEN DO: /*เช็ค chasis และ policy ตรงกัน ให้ส่งข้อมูลได้ (ตามเงื่อนไขข้อ 1)*/
        
            FIND LAST sicuw.uwm100 USE-INDEX uwm10001           WHERE 
                      sicuw.uwm100.policy = sicuw.uwm301.policy AND 
                      sicuw.uwm100.rencnt = sicuw.uwm301.rencnt AND
                      sicuw.uwm100.endcnt = sicuw.uwm301.endcnt AND 
                      sicuw.uwm100.releas = YES                 NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL uwm100 THEN DO:
                /*Lukkana M. A55-0209 05/07/2012*/
                ASSIGN
                    nv_dat   = STRING(DAY(sicuw.uwm100.comdat),"99")
                    nv_mon   = STRING(MONTH(sicuw.uwm100.comdat),"99")
                    nv_yea   = STRING(YEAR(sicuw.uwm100.comdat) + 543 , "9999")
                    nv_dat1  = STRING(DAY(sicuw.uwm100.expdat),"99")
                    nv_mon1  = STRING(MONTH(sicuw.uwm100.expdat),"99")
                    nv_yea1  = STRING(YEAR(sicuw.uwm100.expdat) + 543 , "9999").

                nv_comdat = SUBSTRING(nv_yea,3,2) + nv_mon + nv_dat.
                nv_expdat = SUBSTRING(nv_yea1,3,2) + nv_mon1 + nv_dat1.
                /*Lukkana M. A55-0209 05/07/2012*/


                /*Lukkana M. A53-0161 22/04/2010 เพิ่มเงื่อนไขนี้*/
                IF (SUBSTR(aycldeto2_fil.comdat,1,2) = SUBSTR(nv_comdat,1,2)) OR (aycldeto2_fil.comdat = "000000") THEN DO: /*เช็คปีต้องเท่ากับไฟล์ที่ส่งมา หรือถ้าเป็นค่าว่างให้ส่งค่ากลับไป*/
                    ASSIGN
                        aycldeto2_fil.policy  = CAPS(sicuw.uwm100.policy)
                        aycldeto2_fil.comdat  = nv_comdat
                        aycldeto2_fil.expdat  = nv_expdat .
    
                    FOR EACH sicuw.uwm100 USE-INDEX uwm10091            WHERE 
                             sicuw.uwm100.releas = YES                  AND
                             sicuw.uwm100.policy = sicuw.uwm301.policy  NO-LOCK.
                        ASSIGN
                            nv_prem   = nv_prem   + sicuw.uwm100.prem_t
                            nv_rstp_t = nv_rstp_t + sicuw.uwm100.rstp_t
                            nv_rtax_t = nv_rtax_t + sicuw.uwm100.rtax_t.
                    END.
                    
                    /*--------
                    ASSIGN
                        aycldeto2_fil.prem    = REPLACE(STRING(nv_prem,"9999999999999.99"),".","")
                        aycldeto2_fil.premtot = REPLACE(STRING(nv_prem + 
                                                              /*nv_rstp_t + */
                                                              nv_rtax_t,"9999999999999.99"),".","").
                    Lukkana M. A53-0135 31/03/2010------*/

                    /*---Lukkana M. A53-0135 31/03/2010---*/
                    ASSIGN  
                        aycldeto2_fil.prem      = TRIM(REPLACE(STRING(nv_prem,">>>>>>>>>>>>9.99"),".",""))
                        aycldeto2_fil.premtax   = TRIM(REPLACE(STRING(nv_rstp_t + nv_rtax_t,">>>>>>>>>>>>9.99"),".","")) /*A58-0121*/
                        aycldeto2_fil.insrayrno = "การประกันภัยรถยนต์(ภาคสมัครใจ)"  /*A58-0121*/
                        aycldeto2_fil.premtot   = TRIM(REPLACE(STRING(nv_prem + nv_rstp_t + nv_rtax_t,">>>>>>>>>>>>9.99"),".","")).
                    /*---Lukkana M. A53-0135 31/03/2010---*/
                    /**** Insured Item ****/
                    FIND LAST sicuw.uwm130 USE-INDEX uwm13001 WHERE 
                              sicuw.uwm130.policy = sicuw.uwm301.policy AND
                              sicuw.uwm130.rencnt = sicuw.uwm301.rencnt AND
                              sicuw.uwm130.endcnt = sicuw.uwm301.endcnt AND
                              sicuw.uwm130.riskgp = sicuw.uwm301.riskgp AND
                              sicuw.uwm130.riskno = sicuw.uwm301.riskno AND
                              sicuw.uwm130.itemno = sicuw.uwm301.itemno 
                    NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAIL uwm130 THEN DO:
            
                        /**** SUM INSURE ****/
                        /*---Lukkana M. A53-0135 31/03/2010----*/                                     
                        IF      sicuw.uwm301.covcod = "1"   THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                        ELSE IF sicuw.uwm301.covcod = "2"   THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom7_v,">>>>>>>>>>>>9.99"),".","").
                        ELSE IF sicuw.uwm301.covcod = "2.1" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                        ELSE DO: 
                            /*A57-0291*/
                            IF      sicuw.uwm130.uom6_v <> 0 THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                            ELSE IF sicuw.uwm130.uom7_v <> 0 THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom7_v,">>>>>>>>>>>>9.99"),".","").
                            ELSE nv_si = "000000000000000". 
                            /*A57-0291*/
                        END.
                        /*---Lukkana M. A53-0135 31/03/2010----*/
    
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
            
                    END. /* Avail uwm130 */
            
                    nv_compcnt = nv_compcnt + 1.  /* record found count */
                END.
                ELSE DO:
                    nv_ncompcnt = nv_ncompcnt + 1. /* record not found count */
        
                    ASSIGN
                        aycldeto2_fil.remark = "ปีที่คุ้มครองไม่ตรง" 
                        SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm100.policy. /*Lukkana M. A55-0244 01/08/2012*/

                END.
            END. /* Avail uwm100 */    
            ELSE DO: /*--if not avail uwm100--*/
                FIND LAST sicuw.uwm100 USE-INDEX uwm10091          WHERE 
                          sicuw.uwm100.releas = YES                  AND
                          sicuw.uwm100.policy = sicuw.uwm301.policy  NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL sicuw.uwm100 THEN DO:
                    FIND LAST sicuw.uwm301 USE-INDEX uwm30101 WHERE 
                              sicuw.uwm301.policy = sicuw.uwm100.policy AND
                              sicuw.uwm301.rencnt = sicuw.uwm100.rencnt AND
                              sicuw.uwm301.endcnt = sicuw.uwm100.endcnt NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAIL sicuw.uwm301 THEN DO:
                        IF sicuw.uwm301.trareg = aycldeto2_fil.cha_no THEN DO: /*ย้อนมาเช็คเลขตัวถังรถว่าตรงกันหรือไม่*/
                            /*Lukkana M. A55-0209 05/07/2012*/
                            ASSIGN
                                nv_dat   = STRING(DAY(sicuw.uwm100.comdat),"99")
                                nv_mon   = STRING(MONTH(sicuw.uwm100.comdat),"99")
                                nv_yea   = STRING(YEAR(sicuw.uwm100.comdat) + 543 , "9999")
                                nv_dat1  = STRING(DAY(sicuw.uwm100.expdat),"99")
                                nv_mon1  = STRING(MONTH(sicuw.uwm100.expdat),"99")
                                nv_yea1  = STRING(YEAR(sicuw.uwm100.expdat) + 543 , "9999").
            
                            nv_comdat = SUBSTRING(nv_yea,3,2) + nv_mon + nv_dat.
                            nv_expdat = SUBSTRING(nv_yea1,3,2) + nv_mon1 + nv_dat1.
                            /*Lukkana M. A55-0209 05/07/2012*/

                            /*--Lukkana M. A53-0161 22/04/2010--*/
                            IF (SUBSTR(aycldeto2_fil.comdat,1,2) = SUBSTR(nv_comdat,1,2)) OR (aycldeto2_fil.comdat = "000000") THEN DO: /*เช็คปีต้องเท่ากับไฟล์ที่ส่งมา หรือถ้าเป็นค่าว่างให้ส่งค่ากลับไป*/
                                ASSIGN
                                    aycldeto2_fil.policy  = CAPS(sicuw.uwm100.policy)
                                    aycldeto2_fil.comdat  = nv_comdat
                                    aycldeto2_fil.expdat  = nv_expdat .
    
                                FOR EACH sicuw.uwm100 USE-INDEX uwm10091         WHERE 
                                         sicuw.uwm100.releas = YES                 AND
                                         sicuw.uwm100.policy = sicuw.uwm301.policy NO-LOCK. /*คำนวณเบี้ย*/
                                    ASSIGN
                                        nv_prem   = nv_prem   + sicuw.uwm100.prem_t
                                        nv_rstp_t = nv_rstp_t + sicuw.uwm100.rstp_t
                                        nv_rtax_t = nv_rtax_t + sicuw.uwm100.rtax_t.
                                END.   

                                /*--Lukkana M. A53-0135 31/03/2010---*/
                                ASSIGN  aycldeto2_fil.prem = TRIM(REPLACE(STRING(nv_prem,">>>>>>>>>>>>9.99"),".",""))
                                aycldeto2_fil.premtax      = TRIM(REPLACE(STRING(nv_rstp_t + nv_rtax_t,">>>>>>>>>>>>9.99"),".","")) /*A58-0121*/
                                aycldeto2_fil.insrayrno = "การประกันภัยรถยนต์(ภาคสมัครใจ)"  /*A58-0121*/
                                aycldeto2_fil.premtot      = TRIM(REPLACE(STRING(nv_prem + nv_rstp_t + nv_rtax_t,">>>>>>>>>>>>9.99"),".","")).
                                /*--Lukkana M. A53-0135 31/03/2010---*/
                        
                                /**** Insured Item ****/
                                FIND LAST sicuw.uwm130 USE-INDEX uwm13001 WHERE 
                                          sicuw.uwm130.policy = sicuw.uwm301.policy AND
                                          sicuw.uwm130.rencnt = sicuw.uwm301.rencnt AND
                                          sicuw.uwm130.endcnt = sicuw.uwm301.endcnt AND
                                          sicuw.uwm130.riskgp = sicuw.uwm301.riskgp AND
                                          sicuw.uwm130.riskno = sicuw.uwm301.riskno AND
                                          sicuw.uwm130.itemno = sicuw.uwm301.itemno 
                                NO-LOCK NO-ERROR NO-WAIT.
                                IF AVAIL uwm130 THEN DO:
                                    /**** SUM INSURE ****/
                                    /*---Lukkana M. A53-0135 31/03/2010----*/                                     
                                    IF sicuw.uwm301.covcod = "1" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                    ELSE IF sicuw.uwm301.covcod = "2" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom7_v,">>>>>>>>>>>>9.99"),".","").
                                    ELSE IF sicuw.uwm301.covcod = "2.1" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                    ELSE DO: 
                                        /*A57-0291*/
                                        IF      sicuw.uwm130.uom6_v <> 0 THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                        ELSE IF sicuw.uwm130.uom7_v <> 0 THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom7_v,">>>>>>>>>>>>9.99"),".","").
                                        ELSE nv_si = "000000000000000". 
                                        /*A57-0291*/
                                    END.  /*Lukkana M. A55-0209 05/07/2012*/
                                    /*---Lukkana M. A53-0135 31/03/2010----*/
    
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
                    
                                END. /* Avail uwm130 */
                    
                                nv_compcnt = nv_compcnt + 1.  /* record found count */

                            END. /*IF (SUBSTR(aycldeto2_fil.comdat,1,2) = SUBSTR(nv_comdat,1,2)) OR aycldeto2_fil.comdat = "000000" THEN DO:*/
                            ELSE DO:
                                nv_ncompcnt = nv_ncompcnt + 1. /* record not found count */
                    
                                ASSIGN
                                    aycldeto2_fil.remark = "ปีที่คุ้มครองไม่ตรง" 
                                    SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm301.policy. /*Lukkana M. A55-0244 01/08/2012*/
                            END.
                        END. /*--if sicuw.uwm301.trareg = aycldeto2_fil.cha_no--*/
                        ELSE DO: /*เลขตัวถังรถไม่ตรงกัน*/
                            nv_ncompcnt = nv_ncompcnt + 1. /* record not found count */
                            ASSIGN aycldeto2_fil.remark = "Not Found Policy permitt Chassis " + aycldeto2_fil.cha_no
                                SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm301.policy. /*Lukkana M. A55-0244 01/08/2012*/
                            /* comment by : Ranu I. A65-0115...
                            /*--Lukkana M. A53-0135 31/03/2010--*/
                            ASSIGN nv_si_n      = INTE(aycldeto2_fil.si)
                            nv_prem_n      = INTE(aycldeto2_fil.prem)
                            nv_prem_taxstm = INTE(aycldeto2_fil.premtax) /*A58-0121*/
                            nv_premtot_n   = INTE(aycldeto2_fil.premtot).
                            ASSIGN aycldeto2_fil.si   = TRIM(REPLACE(STRING(nv_si_n,">>>>>>>>>>>>9.99"),".",""))
                            aycldeto2_fil.prem    = TRIM(REPLACE(STRING(nv_prem_n,">>>>>>>>>>>>9.99"),".",""))
                            aycldeto2_fil.premtax = TRIM(REPLACE(STRING(nv_prem_taxstm,">>>>>>>>>>>>9.99"),".","")) /*A58-0121*/
                            aycldeto2_fil.insrayrno = "การประกันภัยรถยนต์(ภาคสมัครใจ)"  /*A58-0121*/
                            aycldeto2_fil.premtot = TRIM(REPLACE(STRING(nv_premtot_n,">>>>>>>>>>>>9.99"),".","")).
                            /*--Lukkana M. A53-0135 31/03/2010--*/
                            ...end : A65-0115...*/
                        END.
                    END.    /*--if avail sicuw.uwm301--*/
                END. /*--if avail sicuw.uwm100--*/
                ELSE DO: /*uwm100.releas = no*/
                    nv_ncompcnt = nv_ncompcnt + 1. /* record not found count */
        
                    ASSIGN
                        aycldeto2_fil.remark = "Policy Not Release" 
                        SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm301.policy. /*Lukkana M. A55-0244 01/08/2012*/
                    /* comment by : Ranu I. A65-0115...
                    /*--Lukkana M. A53-0135 31/03/2010--*/
                    ASSIGN nv_si_n        = INTE(aycldeto2_fil.si)
                        nv_prem_n      = INTE(aycldeto2_fil.prem)
                        nv_prem_taxstm = INTE(aycldeto2_fil.premtax) /*A58-0121*/
                        nv_premtot_n   = INTE(aycldeto2_fil.premtot).
                    ASSIGN 
                        aycldeto2_fil.si      = TRIM(REPLACE(STRING(nv_si_n,">>>>>>>>>>>>9.99"),".",""))
                        aycldeto2_fil.prem    = TRIM(REPLACE(STRING(nv_prem_n,">>>>>>>>>>>>9.99"),".",""))
                        aycldeto2_fil.premtax = TRIM(REPLACE(STRING(nv_prem_taxstm,">>>>>>>>>>>>9.99"),".","")) /*A58-0121*/
                        aycldeto2_fil.insrayrno = "การประกันภัยรถยนต์(ภาคสมัครใจ)"  /*A58-0121*/
                        aycldeto2_fil.premtot = TRIM(REPLACE(STRING(nv_premtot_n,">>>>>>>>>>>>9.99"),".","")).
                    /*--Lukkana M. A53-0135 31/03/2010--*/
                    ...end A65-0115...*/

                END.
            END. /*--else do (if not avail uwm100)--*/
        
        END. /* Avail uwm301 */
        ELSE DO: /* Not Avail uwm301 */
            /*--Lukkana M. A53-0161 13/05/2010 เช็คเงื่อนไขใหม่--*/
            FIND LAST sicuw.uwm301 USE-INDEX uwm30103                       WHERE
                      sicuw.uwm301.trareg             = aycldeto2_fil.cha_no AND 
                      SUBSTR(sicuw.uwm301.policy,3,2) = "70"                NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL uwm301 THEN DO: /*เช็คทีละเงื่อนไข ถ้า chasiss ตรงกัน (ตามเงื่อนไขข้อ 4,5) */
                /*IF sicuw.uwm301.policy  <> aycldeto2_fil.notify THEN DO: /*ให้เช็คเพิ่มถ้า policy ไม่ตรงกัน*/*//*A56-0119*/
                IF sicuw.uwm301.policy  <> nv_policyno THEN DO:                                                 /*A56-0119*/
                    IF sicuw.uwm301.trareg = ""  THEN DO:
                        nv_ncompcnt = nv_ncompcnt + 1. /* record not found count */
                        ASSIGN
                            aycldeto2_fil.remark = "Chassis is null " 
                            SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm301.policy. /*Lukkana M. A55-0244 01/08/2012*/

                    END. /*IF sicuw.uwm301.trareg = ""  THEN DO:*/
                    ELSE DO:
                        FIND LAST sicuw.uwm100 USE-INDEX uwm10001           WHERE 
                                  sicuw.uwm100.policy = sicuw.uwm301.policy AND 
                                  sicuw.uwm100.rencnt = sicuw.uwm301.rencnt AND
                                  sicuw.uwm100.endcnt = sicuw.uwm301.endcnt AND 
                                  sicuw.uwm100.releas = YES                 NO-LOCK NO-ERROR NO-WAIT.
                        IF AVAIL uwm100 THEN DO:
                            /*--
                            /**** Cover Commencement Date  ****/
                            ASSIGN
                                nv_date   = sicuw.uwm100.comdat
                                nv_date   = DATE(MONTH(nv_date),DAY(nv_date),YEAR(nv_date) + 543)
                                nv_comdat = STRING(nv_date)
                                nv_comdat = SUBSTRING(nv_comdat,9,2) + SUBSTRING(nv_comdat,4,2) + SUBSTRING(nv_comdat,1,2).
                    
                            /**** Expiry Date  ****/
                            ASSIGN
                                nv_date   = sicuw.uwm100.expdat
                                nv_date   = DATE(MONTH(nv_date),DAY(nv_date),YEAR(nv_date) + 543)
                                nv_expdat = STRING(nv_date)
                                nv_expdat = SUBSTRING(nv_expdat,9,2) + SUBSTRING(nv_expdat,4,2) + SUBSTRING(nv_expdat,1,2).
                            Lukkana M. A55-0209 05/07/2012*/
                            /*Lukkana M. A55-0209 05/07/2012*/
                            ASSIGN nv_dat   = STRING(DAY(sicuw.uwm100.comdat),"99")
                            nv_mon   = STRING(MONTH(sicuw.uwm100.comdat),"99")
                            nv_yea   = STRING(YEAR(sicuw.uwm100.comdat) + 543 , "9999")
                            nv_dat1  = STRING(DAY(sicuw.uwm100.expdat),"99")
                            nv_mon1  = STRING(MONTH(sicuw.uwm100.expdat),"99")
                            nv_yea1  = STRING(YEAR(sicuw.uwm100.expdat) + 543 , "9999").
                            nv_comdat = SUBSTRING(nv_yea,3,2) + nv_mon + nv_dat.
                            nv_expdat = SUBSTRING(nv_yea1,3,2) + nv_mon1 + nv_dat1.
                            /*Lukkana M. A55-0209 05/07/2012*/
                            /*Lukkana M. A53-0161 22/04/2010 เพิ่มเงื่อนไขนี้*/
                            IF (SUBSTR(aycldeto2_fil.comdat,1,2) = SUBSTR(nv_comdat,1,2)) OR (aycldeto2_fil.comdat = "000000") THEN DO: /*เช็คปีต้องเท่ากับไฟล์ที่ส่งมา หรือถ้าเป็นค่าว่างให้ส่งค่ากลับไป*/
                                ASSIGN aycldeto2_fil.policy  = CAPS(sicuw.uwm100.policy)
                                aycldeto2_fil.comdat  = nv_comdat
                                aycldeto2_fil.expdat  = nv_expdat .
                                FOR EACH sicuw.uwm100 USE-INDEX uwm10091          WHERE 
                                         sicuw.uwm100.releas = YES                  AND 
                                         sicuw.uwm100.policy = sicuw.uwm301.policy  NO-LOCK .
                                    ASSIGN nv_prem   = nv_prem   + sicuw.uwm100.prem_t
                                    nv_rstp_t = nv_rstp_t + sicuw.uwm100.rstp_t
                                    nv_rtax_t = nv_rtax_t + sicuw.uwm100.rtax_t.
                                END.
                                /*---Lukkana M. A53-0135 31/03/2010---*/
                                ASSIGN                                             
                                    aycldeto2_fil.prem    = TRIM(REPLACE(STRING(nv_prem,">>>>>>>>>>>>9.99"),".",""))
                                    aycldeto2_fil.premtax = TRIM(REPLACE(STRING(nv_rstp_t + nv_rtax_t,">>>>>>>>>>>>9.99"),".","")) /*A58-0121*/
                                    aycldeto2_fil.insrayrno = "การประกันภัยรถยนต์(ภาคสมัครใจ)"  /*A58-0121*/
                                    aycldeto2_fil.premtot = TRIM(REPLACE(STRING(nv_prem + nv_rstp_t + nv_rtax_t,">>>>>>>>>>>>9.99"),".","")).
                                /*---Lukkana M. A53-0135 31/03/2010---*/
                                /**** Insured Item ****/
                                FIND LAST sicuw.uwm130 USE-INDEX uwm13001 WHERE 
                                  sicuw.uwm130.policy = sicuw.uwm301.policy AND
                                  sicuw.uwm130.rencnt = sicuw.uwm301.rencnt AND
                                  sicuw.uwm130.endcnt = sicuw.uwm301.endcnt AND
                                  sicuw.uwm130.riskgp = sicuw.uwm301.riskgp AND
                                  sicuw.uwm130.riskno = sicuw.uwm301.riskno AND
                                  sicuw.uwm130.itemno = sicuw.uwm301.itemno 
                                NO-LOCK NO-ERROR NO-WAIT.
                                IF AVAIL uwm130 THEN DO:
                                    /**** SUM INSURE ****/
                                    /*---Lukkana M. A53-0135 31/03/2010----*/                                     
                                    IF      sicuw.uwm301.covcod = "1"   THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                    ELSE IF sicuw.uwm301.covcod = "2"   THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom7_v,">>>>>>>>>>>>9.99"),".","").
                                    ELSE IF sicuw.uwm301.covcod = "2.1" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                    ELSE DO: 
                                        /*A57-0291*/
                                        IF      sicuw.uwm130.uom6_v <> 0 THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                        ELSE IF sicuw.uwm130.uom7_v <> 0 THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom7_v,">>>>>>>>>>>>9.99"),".","").
                                        ELSE nv_si = "000000000000000". 
                                        /*A57-0291*/
                                    END.
                                    /*---Lukkana M. A53-0135 31/03/2010----*/
                
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
                                    
                                END. /* Avail uwm130 */
                        
                                nv_compcnt = nv_compcnt + 1.  /* record found count */
                            END. /*IF (SUBSTR(aycldeto2_fil.comdat,1,2) = SUBSTR(nv_comdat,1,2)) OR aycldeto2_fil.comdat = "000000" */
                            ELSE DO:
                                nv_ncompcnt = nv_ncompcnt + 1. /* record not found count */
                    
                                ASSIGN
                                    aycldeto2_fil.remark = "ปีที่คุ้มครองไม่ตรง" 
                                    SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm100.policy. /*Lukkana M. A55-0244 01/08/2012*/

                            END.
                        END. /* Avail uwm100 */    
                        ELSE DO: /*--if not avail uwm100--*/
                            FIND LAST sicuw.uwm100 USE-INDEX uwm10091            WHERE 
                                      sicuw.uwm100.releas = YES                  AND
                                      sicuw.uwm100.policy = sicuw.uwm301.policy  NO-LOCK NO-ERROR NO-WAIT.
                            IF AVAIL sicuw.uwm100 THEN DO:
                                FIND LAST sicuw.uwm301 USE-INDEX uwm30101 WHERE 
                                          sicuw.uwm301.policy = sicuw.uwm100.policy AND
                                          sicuw.uwm301.rencnt = sicuw.uwm100.rencnt AND
                                          sicuw.uwm301.endcnt = sicuw.uwm100.endcnt NO-LOCK NO-ERROR NO-WAIT.
                                IF AVAIL sicuw.uwm301 THEN DO:
                                    IF sicuw.uwm301.trareg = aycldeto2_fil.cha_no THEN DO: /*ย้อนมาเช็คเลขตัวถังรถว่าตรงกันหรือไม่*/
                                        /*Lukkana M. A55-0209 05/07/2012*/
                                        ASSIGN
                                        nv_dat   = STRING(DAY(sicuw.uwm100.comdat),"99")
                                        nv_mon   = STRING(MONTH(sicuw.uwm100.comdat),"99")
                                        nv_yea   = STRING(YEAR(sicuw.uwm100.comdat) + 543 , "9999")
                                        nv_dat1  = STRING(DAY(sicuw.uwm100.expdat),"99")
                                        nv_mon1  = STRING(MONTH(sicuw.uwm100.expdat),"99")
                                        nv_yea1  = STRING(YEAR(sicuw.uwm100.expdat) + 543 , "9999").
                        
                                        nv_comdat = SUBSTRING(nv_yea,3,2) + nv_mon + nv_dat.
                                        nv_expdat = SUBSTRING(nv_yea1,3,2) + nv_mon1 + nv_dat1.
                                        /*Lukkana M. A55-0209 05/07/2012*/
            
                                        /*--Lukkana M. A53-0161 22/04/2010--*/
                                        IF (SUBSTR(aycldeto2_fil.comdat,1,2) = SUBSTR(nv_comdat,1,2)) OR (aycldeto2_fil.comdat = "000000") THEN DO: /*เช็คปีต้องเท่ากับไฟล์ที่ส่งมา หรือถ้าเป็นค่าว่างให้ส่งค่ากลับไป*/
                                            ASSIGN
                                                aycldeto2_fil.policy  = CAPS(sicuw.uwm100.policy)
                                                aycldeto2_fil.comdat  = nv_comdat
                                                aycldeto2_fil.expdat  = nv_expdat .
                
                                            FOR EACH sicuw.uwm100 USE-INDEX uwm10091         WHERE 
                                                     sicuw.uwm100.releas = YES                 AND
                                                     sicuw.uwm100.policy = sicuw.uwm301.policy NO-LOCK. /*คำนวณเบี้ย*/
                                                ASSIGN
                                                    nv_prem   = nv_prem   + sicuw.uwm100.prem_t
                                                    nv_rstp_t = nv_rstp_t + sicuw.uwm100.rstp_t
                                                    nv_rtax_t = nv_rtax_t + sicuw.uwm100.rtax_t.
                                            END.     

                                            /*--Lukkana M. A53-0135 31/03/2010---*/
                                            ASSIGN                                             
                                                aycldeto2_fil.prem    = TRIM(REPLACE(STRING(nv_prem,">>>>>>>>>>>>9.99"),".",""))
                                                aycldeto2_fil.premtax = TRIM(REPLACE(STRING(nv_rstp_t + nv_rtax_t,">>>>>>>>>>>>9.99"),".","")) /*A58-0121*/
                                                aycldeto2_fil.insrayrno = "การประกันภัยรถยนต์(ภาคสมัครใจ)"  /*A58-0121*/
                                                aycldeto2_fil.premtot = TRIM(REPLACE(STRING(nv_prem + nv_rstp_t + nv_rtax_t,">>>>>>>>>>>>9.99"),".","")).
                                            /*--Lukkana M. A53-0135 31/03/2010---*/
                                            /**** Insured Item ****/
                                            FIND LAST sicuw.uwm130 USE-INDEX uwm13001 WHERE 
                                              sicuw.uwm130.policy = sicuw.uwm301.policy AND
                                              sicuw.uwm130.rencnt = sicuw.uwm301.rencnt AND
                                              sicuw.uwm130.endcnt = sicuw.uwm301.endcnt AND
                                              sicuw.uwm130.riskgp = sicuw.uwm301.riskgp AND
                                              sicuw.uwm130.riskno = sicuw.uwm301.riskno AND
                                              sicuw.uwm130.itemno = sicuw.uwm301.itemno 
                                            NO-LOCK NO-ERROR NO-WAIT.
                                            IF AVAIL uwm130 THEN DO:
                                                /**** SUM INSURE ****/
                                                /*---Lukkana M. A53-0135 31/03/2010----*/                                     
                                                IF sicuw.uwm301.covcod = "1" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                                ELSE IF sicuw.uwm301.covcod = "2" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom7_v,">>>>>>>>>>>>9.99"),".","").
                                                ELSE IF sicuw.uwm301.covcod = "2.1" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                                ELSE DO: 
                                                    /*A57-0291*/
                                                    IF      sicuw.uwm130.uom6_v <> 0 THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                                    ELSE IF sicuw.uwm130.uom7_v <> 0 THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom7_v,">>>>>>>>>>>>9.99"),".","").
                                                    ELSE nv_si = "000000000000000". 
                                                    /*A57-0291*/
                                                END.  /*Lukkana M. A55-0209 05/07/2012*/
                                                /*---Lukkana M. A53-0135 31/03/2010----*/
                
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
                                
                                            END. /* Avail uwm130 */
                                
                                            nv_compcnt = nv_compcnt + 1.  /* record found count */
                                        END. /*IF (SUBSTR(aycldeto2_fil.comdat,1,2) = SUBSTR(nv_comdat,1,2)) OR aycldeto2_fil.comdat = "000000" THEN DO:*/
                                        ELSE DO:
                                            nv_ncompcnt = nv_ncompcnt + 1. /* record not found count */
                                
                                            ASSIGN
                                                aycldeto2_fil.remark = "ปีที่คุ้มครองไม่ตรง" 
                                                SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm301.policy. /*Lukkana M. A55-0244 01/08/2012*/

                                        END.
                                    END. /*--if sicuw.uwm301.trareg = aycldeto2_fil.cha_no--*/
                                    ELSE DO: /*เลขตัวถังรถไม่ตรงกัน*/
                                        nv_ncompcnt = nv_ncompcnt + 1. /* record not found count */
                    
                                        ASSIGN
                                            aycldeto2_fil.remark = "Not Found Policy permitt Chassis " + aycldeto2_fil.cha_no
                                            SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm301.policy. /*Lukkana M. A55-0244 01/08/2012*/
                                        /* comment by : Ranu I. A65-0115...
                                        /*--Lukkana M. A53-0135 31/03/2010--*/
                                        ASSIGN nv_si_n      = INTE(aycldeto2_fil.si)
                                        nv_prem_n      = INTE(aycldeto2_fil.prem)
                                        nv_prem_taxstm = INTE(aycldeto2_fil.premtax) /*A58-0121*/
                                        nv_premtot_n   = INTE(aycldeto2_fil.premtot).
                                        ASSIGN
                                        aycldeto2_fil.si      = TRIM(REPLACE(STRING(nv_si_n,">>>>>>>>>>>>9.99"),".",""))
                                        aycldeto2_fil.prem    = TRIM(REPLACE(STRING(nv_prem_n,">>>>>>>>>>>>9.99"),".",""))
                                        aycldeto2_fil.premtax = TRIM(REPLACE(STRING(nv_prem_taxstm,">>>>>>>>>>>>9.99"),".","")) /*A58-0121*/
                                        aycldeto2_fil.insrayrno = "การประกันภัยรถยนต์(ภาคสมัครใจ)"  /*A58-0121*/
                                        aycldeto2_fil.premtot = TRIM(REPLACE(STRING(nv_premtot_n,">>>>>>>>>>>>9.99"),".","")).
                                        /*--Lukkana M. A53-0135 31/03/2010--*/
                                        ...end : A65-0115...*/
                                    END.
                                END.    /*--if avail sicuw.uwm301--*/
                            END. /*--if avail sicuw.uwm100--*/
                            ELSE DO: /*uwm100.releas = no*/
                                nv_ncompcnt = nv_ncompcnt + 1. /* record not found count */
                                ASSIGN aycldeto2_fil.remark = "Policy Not Release" 
                                    SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm301.policy. /*Lukkana M. A55-0244 01/08/2012*/
                                /* comment by : Ranu I. A65-0115...
                                /*--Lukkana M. A53-0135 31/03/2010--*/
                                ASSIGN nv_si_n = INTE(aycldeto2_fil.si)
                                nv_prem_n      = INTE(aycldeto2_fil.prem)
                                nv_prem_taxstm = INTE(aycldeto2_fil.premtax) /*A58-0121*/
                                nv_premtot_n   = INTE(aycldeto2_fil.premtot).
                                ASSIGN aycldeto2_fil.si      = TRIM(REPLACE(STRING(nv_si_n,">>>>>>>>>>>>9.99"),".",""))
                                aycldeto2_fil.prem    = TRIM(REPLACE(STRING(nv_prem_n,">>>>>>>>>>>>9.99"),".",""))
                                aycldeto2_fil.premtax = TRIM(REPLACE(STRING(nv_prem_taxstm,">>>>>>>>>>>>9.99"),".","")) /*A58-0121*/
                                aycldeto2_fil.insrayrno = "การประกันภัยรถยนต์(ภาคสมัครใจ)"  /*A58-0121*/
                                aycldeto2_fil.premtot = TRIM(REPLACE(STRING(nv_premtot_n,">>>>>>>>>>>>9.99"),".","")).
                                /*--Lukkana M. A53-0135 31/03/2010--*/
                                ...end A65-0115...*/
                            END.
                        END. /*--else do (if not avail uwm100)--*/
                    END. /*IF sicuw.uwm301.trareg <> ""  THEN DO:*/
                END. /*IF sicuw.uwm301.policy  <> aycldeto2_fil.notify THEN DO: /*ให้เช็คเพิ่มถ้า policy ไม่ตรงกัน*/ */
            END. /*FIND LAST sicuw.uwm301 USE-INDEX uwm30103 WHERE if avail sicuw.uwm301*/
            ELSE DO: 
                FIND LAST sicuw.uwm301 USE-INDEX uwm30101                       WHERE
                    /*sicuw.uwm301.policy             = aycldeto2_fil.notify AND *//*A56-0119*/
                    sicuw.uwm301.policy             = nv_policyno         AND     /*A56-0119*/
                    SUBSTR(sicuw.uwm301.policy,3,2) = "70"                NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL uwm301 THEN DO: /*ถ้า chasiss ไม่ตรง ให้มาเช็คกรมธรรม์ ถ้าตรงกัน ให้ทำ (ตามเงื่อนไขข้อ 2,3)*/
                    nv_name = "".
                    nv_name = TRIM(aycldeto2_fil.fname) + " " + TRIM(aycldeto2_fil.lname).
                    FIND FIRST sicsyac.xtm600 USE-INDEX xtm60002 WHERE sicsyac.xtm600.NAME = nv_name NO-LOCK NO-ERROR.
                    IF AVAIL xtm600 THEN nv_acno = xtm600.acno.
                    ELSE nv_acno = "".
                    IF sicuw.uwm301.trareg = ""  THEN DO:
                        nv_ncompcnt = nv_ncompcnt + 1. /* record not found count */
                        ASSIGN
                            aycldeto2_fil.remark = "Chassis is null " 
                            SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm301.policy. /*Lukkana M. A55-0244 01/08/2012*/
                    END. /*IF sicuw.uwm301.trareg = ""  THEN DO:*/
                    ELSE DO:
                        IF nv_acno = "" THEN DO: /*ถ้าชื่อ-นามสกุล เป็นค่าว่างไม่ส่งข้อมูล ตรงกับเงื่อนไขข้อ 3*/
                            nv_ncompcnt = nv_ncompcnt + 1. /* record not found count */
                            ASSIGN
                                aycldeto2_fil.remark = "Not Found Name  " + nv_name
                                SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm301.policy. /*Lukkana M. A55-0244 01/08/2012*/
                        END.
                        ELSE DO: 
                            FIND LAST sicuw.uwm100 USE-INDEX uwm10001           WHERE 
                              sicuw.uwm100.policy = sicuw.uwm301.policy AND 
                              sicuw.uwm100.rencnt = sicuw.uwm301.rencnt AND
                              sicuw.uwm100.endcnt = sicuw.uwm301.endcnt AND 
                              sicuw.uwm100.releas = YES                 NO-LOCK NO-ERROR NO-WAIT.
                            IF AVAIL uwm100 THEN DO:
                                IF sicuw.uwm100.insref = nv_acno THEN DO: /*Lukkana M. A53-0161 30/04/2010 Mapping ตามชื่อ ถ้าตรงกันให้แสดงข้อมูล เงื่อนไขข้อ2*/
                                    /*-
                                    /**** Cover Commencement Date  ****/
                                    ASSIGN
                                        nv_date   = sicuw.uwm100.comdat
                                        nv_date   = DATE(MONTH(nv_date),DAY(nv_date),YEAR(nv_date) + 543)
                                        nv_comdat = STRING(nv_date)
                                        nv_comdat = SUBSTRING(nv_comdat,9,2) + SUBSTRING(nv_comdat,4,2) + SUBSTRING(nv_comdat,1,2).
                                    /**** Expiry Date  ****/
                                    ASSIGN
                                        nv_date   = sicuw.uwm100.expdat
                                        nv_date   = DATE(MONTH(nv_date),DAY(nv_date),YEAR(nv_date) + 543)
                                        nv_expdat = STRING(nv_date)
                                        nv_expdat = SUBSTRING(nv_expdat,9,2) + SUBSTRING(nv_expdat,4,2) + SUBSTRING(nv_expdat,1,2).
                                    Lukkana M. A55-0209 05/07/2012*/

                                    /*Lukkana M. A55-0209 05/07/2012*/
                                    ASSIGN nv_dat   = STRING(DAY(sicuw.uwm100.comdat),"99")
                                    nv_mon   = STRING(MONTH(sicuw.uwm100.comdat),"99")
                                    nv_yea   = STRING(YEAR(sicuw.uwm100.comdat) + 543 , "9999")
                                    nv_dat1  = STRING(DAY(sicuw.uwm100.expdat),"99")
                                    nv_mon1  = STRING(MONTH(sicuw.uwm100.expdat),"99")
                                    nv_yea1  = STRING(YEAR(sicuw.uwm100.expdat) + 543 , "9999").
                                    nv_comdat = SUBSTRING(nv_yea,3,2) + nv_mon + nv_dat.
                                    nv_expdat = SUBSTRING(nv_yea1,3,2) + nv_mon1 + nv_dat1.
                                    /*Lukkana M. A55-0209 05/07/2012*/

                                    /*Lukkana M. A53-0161 22/04/2010 เพิ่มเงื่อนไขนี้*/
                                    IF (SUBSTR(aycldeto2_fil.comdat,1,2) = SUBSTR(nv_comdat,1,2)) OR (aycldeto2_fil.comdat = "000000") THEN DO: /*เช็คปีต้องเท่ากับไฟล์ที่ส่งมา หรือถ้าเป็นค่าว่างให้ส่งค่ากลับไป*/
                                        ASSIGN
                                            aycldeto2_fil.policy  = CAPS(sicuw.uwm100.policy)
                                            aycldeto2_fil.comdat  = nv_comdat
                                            aycldeto2_fil.expdat  = nv_expdat .
                        
                                        FOR EACH sicuw.uwm100 USE-INDEX uwm10091          WHERE 
                                                 sicuw.uwm100.releas = YES                  AND
                                                 sicuw.uwm100.policy = sicuw.uwm301.policy  NO-LOCK.
                                                                    
                                            ASSIGN
                                                nv_prem   = nv_prem   + sicuw.uwm100.prem_t
                                                nv_rstp_t = nv_rstp_t + sicuw.uwm100.rstp_t
                                                nv_rtax_t = nv_rtax_t + sicuw.uwm100.rtax_t.
                                        END.

                                        /*---Lukkana M. A53-0135 31/03/2010---*/
                                        ASSIGN aycldeto2_fil.prem = TRIM(REPLACE(STRING(nv_prem,">>>>>>>>>>>>9.99"),".",""))
                                        aycldeto2_fil.premtax     = TRIM(REPLACE(STRING(nv_rstp_t + nv_rtax_t,">>>>>>>>>>>>9.99"),".","")) /*A58-0121*/
                                        aycldeto2_fil.insrayrno = "การประกันภัยรถยนต์(ภาคสมัครใจ)"  /*A58-0121*/
                                        aycldeto2_fil.premtot     = TRIM(REPLACE(STRING(nv_prem + nv_rstp_t + nv_rtax_t,">>>>>>>>>>>>9.99"),".","")).
                                        /*---Lukkana M. A53-0135 31/03/2010---*/  
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
                                           /*---Lukkana M. A53-0135 31/03/2010----*/                                     
                                            IF      sicuw.uwm301.covcod = "1"   THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                            ELSE IF sicuw.uwm301.covcod = "2"   THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom7_v,">>>>>>>>>>>>9.99"),".","").
                                            ELSE IF sicuw.uwm301.covcod = "2.1" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                            ELSE DO: 
                                                /*A57-0291*/
                                                IF      sicuw.uwm130.uom6_v <> 0 THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                                ELSE IF sicuw.uwm130.uom7_v <> 0 THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom7_v,">>>>>>>>>>>>9.99"),".","").
                                                ELSE nv_si = "000000000000000". 
                                                /*A57-0291*/
                                            END.  /*Lukkana M. A55-0209 05/07/2012*/
                                            /*---Lukkana M. A53-0135 31/03/2010----*/
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

                                        END. /* Avail uwm130 */
                                        nv_compcnt = nv_compcnt + 1.  /* record found count */
                                    END. /*IF (SUBSTR(aycldeto2_fil.comdat,1,2) = SUBSTR(nv_comdat,1,2)) OR aycldeto2_fil.comdat = "000000" THEN DO:*/
                                    ELSE DO:
                                        nv_ncompcnt = nv_ncompcnt + 1. /* record not found count */
                                        ASSIGN aycldeto2_fil.remark = "ปีที่คุ้มครองไม่ตรง" 
                                            SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm100.policy. /*Lukkana M. A55-0244 01/08/2012*/
                                    END.
                                END. /*IF sicuw.uwm100.insref = nv_acno THEN DO: /*Lukkana M. A53-0161 30/04/2010 Mapping ตามชื่อ ถ้าตรงกันให้แสดงข้อมูล*/*/
                                ELSE DO: /*ชื่อ-สกุลไม่ตรงกัน*/
                                    nv_ncompcnt = nv_ncompcnt + 1. /* record not found count */
                                    ASSIGN aycldeto2_fil.remark = "Not Found Name  " + nv_name
                                        SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm100.policy. /*Lukkana M. A55-0244 01/08/2012*/
                                END.
                            END. /* Avail uwm100 */    
                            ELSE DO: /*--if not avail uwm100--*/
                                FIND LAST sicuw.uwm100 USE-INDEX uwm10091         WHERE 
                                          sicuw.uwm100.releas = YES                 AND
                                          sicuw.uwm100.policy = sicuw.uwm301.policy NO-LOCK NO-ERROR NO-WAIT.
                                IF AVAIL sicuw.uwm100 THEN DO:
                                    FIND LAST sicuw.uwm301 USE-INDEX uwm30101 WHERE 
                                        sicuw.uwm301.policy = sicuw.uwm100.policy AND
                                        sicuw.uwm301.rencnt = sicuw.uwm100.rencnt AND
                                        sicuw.uwm301.endcnt = sicuw.uwm100.endcnt NO-LOCK NO-ERROR NO-WAIT.
                                    IF AVAIL sicuw.uwm301 THEN DO:
                                        IF sicuw.uwm301.trareg = aycldeto2_fil.cha_no THEN DO: /*ย้อนมาเช็คเลขตัวถังรถว่าตรงกันหรือไม่*/
                                            /*-
                                            /**** Cover Commencement Date  ****/
                                            ASSIGN
                                                nv_date   = sicuw.uwm100.comdat
                                                nv_date   = DATE(MONTH(nv_date),DAY(nv_date),YEAR(nv_date) + 543)
                                                nv_comdat = STRING(nv_date)
                                                nv_comdat = SUBSTRING(nv_comdat,9,2) + SUBSTRING(nv_comdat,4,2) + SUBSTRING(nv_comdat,1,2).
                                    
                                            /**** Expiry Date  ****/
                                            ASSIGN
                                                nv_date   = sicuw.uwm100.expdat
                                                nv_date   = DATE(MONTH(nv_date),DAY(nv_date),YEAR(nv_date) + 543)
                                                nv_expdat = STRING(nv_date)
                                                nv_expdat = SUBSTRING(nv_expdat,9,2) + SUBSTRING(nv_expdat,4,2) + SUBSTRING(nv_expdat,1,2).
                                            Lukkana M. A55-0209 05/07/2012*/

                                            /*Lukkana M. A55-0209 05/07/2012*/
                                            ASSIGN nv_dat   = STRING(DAY(sicuw.uwm100.comdat),"99")
                                            nv_mon   = STRING(MONTH(sicuw.uwm100.comdat),"99")
                                            nv_yea   = STRING(YEAR(sicuw.uwm100.comdat) + 543 , "9999")
                                            nv_dat1  = STRING(DAY(sicuw.uwm100.expdat),"99")
                                            nv_mon1  = STRING(MONTH(sicuw.uwm100.expdat),"99")
                                            nv_yea1  = STRING(YEAR(sicuw.uwm100.expdat) + 543 , "9999").
                                            nv_comdat = SUBSTRING(nv_yea,3,2) + nv_mon + nv_dat.
                                            nv_expdat = SUBSTRING(nv_yea1,3,2) + nv_mon1 + nv_dat1.
                                            /*Lukkana M. A55-0209 05/07/2012*/
                                            /*--Lukkana M. A53-0161 22/04/2010--*/
                                            IF (SUBSTR(aycldeto2_fil.comdat,1,2) = SUBSTR(nv_comdat,1,2)) OR (aycldeto2_fil.comdat = "000000") THEN DO: /*เช็คปีต้องเท่ากับไฟล์ที่ส่งมา หรือถ้าเป็นค่าว่างให้ส่งค่ากลับไป*/
                                                ASSIGN aycldeto2_fil.policy  = CAPS(sicuw.uwm100.policy)
                                                    aycldeto2_fil.comdat  = nv_comdat
                                                    aycldeto2_fil.expdat  = nv_expdat .
                                                FOR EACH sicuw.uwm100 USE-INDEX uwm10091           WHERE 
                                                         sicuw.uwm100.releas = YES                 AND
                                                         sicuw.uwm100.policy = sicuw.uwm301.policy NO-LOCK. /*คำนวณเบี้ย*/
                                                    ASSIGN
                                                        nv_prem   = nv_prem   + sicuw.uwm100.prem_t
                                                        nv_rstp_t = nv_rstp_t + sicuw.uwm100.rstp_t
                                                        nv_rtax_t = nv_rtax_t + sicuw.uwm100.rtax_t.
                                                END. 
                                                /*--Lukkana M. A53-0135 31/03/2010---*/
                                                ASSIGN                                             
                                                    aycldeto2_fil.prem    = TRIM(REPLACE(STRING(nv_prem,">>>>>>>>>>>>9.99"),".",""))
                                                    aycldeto2_fil.premtax = TRIM(REPLACE(STRING(nv_rstp_t + nv_rtax_t,">>>>>>>>>>>>9.99"),".","")) /*A58-0121*/
                                                    aycldeto2_fil.insrayrno = "การประกันภัยรถยนต์(ภาคสมัครใจ)"  /*A58-0121*/
                                                    aycldeto2_fil.premtot = TRIM(REPLACE(STRING(nv_prem + nv_rstp_t + nv_rtax_t,">>>>>>>>>>>>9.99"),".","")).
                                                /*--Lukkana M. A53-0135 31/03/2010---*/
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
                                                    /*---Lukkana M. A53-0135 31/03/2010----*/                                     
                                                    IF      sicuw.uwm301.covcod = "1"   THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                                    ELSE IF sicuw.uwm301.covcod = "2"   THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom7_v,">>>>>>>>>>>>9.99"),".","").
                                                    ELSE IF sicuw.uwm301.covcod = "2.1" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                                    ELSE DO: 
                                                        /*A57-0291*/
                                                        IF      sicuw.uwm130.uom6_v <> 0 THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                                        ELSE IF sicuw.uwm130.uom7_v <> 0 THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom7_v,">>>>>>>>>>>>9.99"),".","").
                                                        ELSE nv_si = "000000000000000". 
                                                        /*A57-0291*/
                                                    END.  /*Lukkana M. A55-0209 05/07/2012*/
                                                    /*---Lukkana M. A53-0135 31/03/2010----*/
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

                                                END. /* Avail uwm130 */
                                                nv_compcnt = nv_compcnt + 1.  /* record found count */
                                            END. /*IF (SUBSTR(aycldeto2_fil.comdat,1,2) = SUBSTR(nv_comdat,1,2)) OR aycldeto2_fil.comdat = "000000" THEN DO:*/
                                            ELSE DO:
                                                nv_ncompcnt = nv_ncompcnt + 1. /* record not found count */
                                                ASSIGN
                                                    aycldeto2_fil.remark = "ปีที่คุ้มครองไม่ตรง" 
                                                    SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm301.policy. /*Lukkana M. A55-0244 01/08/2012*/
                                            END.
                                        END. /*--if sicuw.uwm301.trareg = aycldeto2_fil.cha_no--*/
                                        ELSE DO: /*เลขตัวถังรถไม่ตรงกัน*/
                                            nv_ncompcnt = nv_ncompcnt + 1. /* record not found count */
                                            ASSIGN
                                                aycldeto2_fil.remark = "Not Found Policy permitt Chassis " + aycldeto2_fil.cha_no
                                                SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm301.policy.  /*Lukkana M. A55-0244 01/08/2012*/
                                            /* comment by : Ranu I. A65-0115...
                                            /*--Lukkana M. A53-0135 31/03/2010--*/
                                            ASSIGN nv_si_n        = INTE(aycldeto2_fil.si)
                                            nv_prem_n      = INTE(aycldeto2_fil.prem)
                                            nv_prem_taxstm = INTE(aycldeto2_fil.premtax) /*A58-0121*/
                                            nv_premtot_n   = INTE(aycldeto2_fil.premtot).
                                            ASSIGN aycldeto2_fil.si   = TRIM(REPLACE(STRING(nv_si_n,">>>>>>>>>>>>9.99"),".",""))
                                            aycldeto2_fil.prem    = TRIM(REPLACE(STRING(nv_prem_n,">>>>>>>>>>>>9.99"),".",""))
                                            aycldeto2_fil.premtax = TRIM(REPLACE(STRING(nv_prem_taxstm,">>>>>>>>>>>>9.99"),".","")) /*A58-0121*/
                                            aycldeto2_fil.insrayrno = "การประกันภัยรถยนต์(ภาคสมัครใจ)"  /*A58-0121*/
                                            aycldeto2_fil.premtot = TRIM(REPLACE(STRING(nv_premtot_n,">>>>>>>>>>>>9.99"),".","")).
                                            /*--Lukkana M. A53-0135 31/03/2010--*/
                                           ... end : A65-0115...*/
                                        END.
                                    END.    /*--if avail sicuw.uwm301--*/
                                END. /*--if avail sicuw.uwm100--*/
                                ELSE DO: /*uwm100.releas = no*/
                                    nv_ncompcnt = nv_ncompcnt + 1. /* record not found count */
                                    ASSIGN
                                        aycldeto2_fil.remark = "Policy Not Release" 
                                        SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm301.policy. /*Lukkana M. A55-0244 01/08/2012*/
                                    /* comment by : Ranu I. A65-0115...
                                    /*--Lukkana M. A53-0135 31/03/2010--*/
                                    ASSIGN
                                        nv_si_n        = INTE(aycldeto2_fil.si)
                                        nv_prem_n      = INTE(aycldeto2_fil.prem)
                                        nv_prem_taxstm = INTE(aycldeto2_fil.premtax) /*A58-0121*/
                                        nv_premtot_n   = INTE(aycldeto2_fil.premtot).
                                    ASSIGN
                                        aycldeto2_fil.si      = TRIM(REPLACE(STRING(nv_si_n,">>>>>>>>>>>>9.99"),".",""))
                                        aycldeto2_fil.prem    = TRIM(REPLACE(STRING(nv_prem_n,">>>>>>>>>>>>9.99"),".",""))
                                        aycldeto2_fil.premtax = TRIM(REPLACE(STRING(nv_prem_taxstm,">>>>>>>>>>>>9.99"),".","")) /*A58-0121*/
                                        aycldeto2_fil.insrayrno = "การประกันภัยรถยนต์(ภาคสมัครใจ)"  /*A58-0121*/
                                        aycldeto2_fil.premtot = TRIM(REPLACE(STRING(nv_premtot_n,">>>>>>>>>>>>9.99"),".","")).
                                    /*--Lukkana M. A53-0135 31/03/2010--*/
                                    ....end A65-0115...*/
                                END.
                            END. /*--else do (if not avail uwm100)--*/
                        END. /*IF nv_acno <> "" THEN DO: ถ้าชื่อ-นามสกุล ไม่เป็นค่าว่าง ให้เช็คว่าตรงกันหรือไม่*/
                    END. /*IF sicuw.uwm301.trareg <> ""  THEN DO:*/
                END. /*if avail uwm301*/
                ELSE DO:
                    nv_ncompcnt = nv_ncompcnt + 1. /* record not found count */
                    ASSIGN
                        aycldeto2_fil.remark = "Not Found Policy permitt Chassis " + aycldeto2_fil.cha_no
                        SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm100.policy. /*Lukkana M. A55-0244 01/08/2012*/
                    /* comment by : Ranu I. A65-0115...
                    /*--Lukkana M. A53-0135 31/03/2010--*/
                    ASSIGN nv_si_n        = INTE(aycldeto2_fil.si)
                    nv_prem_n      = INTE(aycldeto2_fil.prem)
                    nv_prem_taxstm = INTE(aycldeto2_fil.premtax) /*A58-0121*/
                    nv_premtot_n   = INTE(aycldeto2_fil.premtot) .
                    ASSIGN aycldeto2_fil.si      = TRIM(REPLACE(STRING(nv_si_n,">>>>>>>>>>>>9.99"),".",""))
                    aycldeto2_fil.prem    = TRIM(REPLACE(STRING(nv_prem_n,">>>>>>>>>>>>9.99"),".",""))
                    aycldeto2_fil.premtax = TRIM(REPLACE(STRING(nv_prem_taxstm,">>>>>>>>>>>>9.99"),".","")) /*A58-0121*/
                    aycldeto2_fil.insrayrno = "การประกันภัยรถยนต์(ภาคสมัครใจ)"  /*A58-0121*/
                    aycldeto2_fil.premtot = TRIM(REPLACE(STRING(nv_premtot_n,">>>>>>>>>>>>9.99"),".","")).
                    /*--Lukkana M. A53-0135 31/03/2010--*/
                   ...end : A65-0115...*/
                END.
            END. /*else do*/
            /*--Lukkana M. A53-0161 13/05/2010--*/
        END.
        /*---- Lukkana M. A52-0136 24/06/2009 -----*/
     END. /*หา Agent ที่ตรงกัน*/
     ELSE DO: /*ถ้าไม่เจอ acno Lukkana M. A55-0209 11/07/2012*/
         /*Lukkana M. A55-0244 03/08/2012*/
         
         FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE
             /*sicuw.uwm100.policy = aycldeto2_fil.notify NO-LOCK NO-ERROR NO-WAIT.*/ /*A56-0119*/
             sicuw.uwm100.policy  =  nv_policyno   NO-LOCK NO-ERROR NO-WAIT.         /*A56-0119*/
         IF AVAIL sicuw.uwm100 THEN DO:
             nv_ncompcnt = nv_ncompcnt + 1. /* record not found count */
             ASSIGN aycldeto2_fil.remark         = "รหัส Code ไม่ตรง"
             SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm100.policy
             SUBSTR(aycldeto2_fil.remark,120,10) = sicuw.uwm100.acno1. 
         END.
         ELSE DO:
             FIND LAST sicuw.uwm301 USE-INDEX uwm30103                       WHERE
                       sicuw.uwm301.trareg             = aycldeto2_fil.cha_no AND 
                       SUBSTR(sicuw.uwm301.policy,3,2) = "70"                NO-LOCK NO-ERROR NO-WAIT.
             IF AVAIL uwm301 THEN DO: /*เช็คทีละเงื่อนไข ถ้า chasiss ตรงกัน (ตามเงื่อนไขข้อ 4,5) */
                 /*IF sicuw.uwm301.policy  <> aycldeto2_fil.notify THEN DO: /*ให้เช็คเพิ่มถ้า policy ไม่ตรงกัน*/*//*A56-0119*/
                 IF sicuw.uwm301.policy  <> nv_policyno  THEN DO:   /*ให้เช็คเพิ่มถ้า policy ไม่ตรงกัน*/         /*A56-0119*/
                     IF sicuw.uwm301.trareg = ""  THEN DO:
                        nv_ncompcnt = nv_ncompcnt + 1. /* record not found count */
                        ASSIGN
                            aycldeto2_fil.remark = "Chassis is null " 
                            SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm301.policy. /*Lukkana M. A55-0244 01/08/2012*/
                
                    END. /*IF sicuw.uwm301.trareg = ""  THEN DO:*/
                    ELSE DO:
                        FIND LAST sicuw.uwm100 USE-INDEX uwm10001           WHERE 
                                  sicuw.uwm100.policy = sicuw.uwm301.policy AND 
                                  sicuw.uwm100.rencnt = sicuw.uwm301.rencnt AND
                                  sicuw.uwm100.endcnt = sicuw.uwm301.endcnt AND 
                                  sicuw.uwm100.releas = YES               /*A65-0115*/ 
                             NO-LOCK NO-ERROR NO-WAIT.
                        IF AVAIL uwm100 THEN DO:
                            /*IF INDEX(nv_outagent,"," + TRIM(sicuw.uwm100.acno1)) = 0 THEN DO: /*code ไม่ตรง*/*//*A56-0119*/
                            IF INDEX(nv_outagent,TRIM(sicuw.uwm100.acno1)) = 0 THEN DO: /*code ไม่ตรง*/          /*A56-0119*/

                                nv_ncompcnt = nv_ncompcnt + 1. /* record not found count */
                                ASSIGN aycldeto2_fil.remark         = "รหัส Code ไม่ตรง"
                                SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm100.policy
                                SUBSTR(aycldeto2_fil.remark,120,10) = sicuw.uwm100.acno1. 
                            END. 
                            ELSE DO:
                            /*Lukkana M. A55-0209 05/07/2012*/
                            ASSIGN
                                nv_dat   = STRING(DAY(sicuw.uwm100.comdat),"99")
                                nv_mon   = STRING(MONTH(sicuw.uwm100.comdat),"99")
                                nv_yea   = STRING(YEAR(sicuw.uwm100.comdat) + 543 , "9999")
                                nv_dat1  = STRING(DAY(sicuw.uwm100.expdat),"99")
                                nv_mon1  = STRING(MONTH(sicuw.uwm100.expdat),"99")
                                nv_yea1  = STRING(YEAR(sicuw.uwm100.expdat) + 543 , "9999").
                            nv_comdat = SUBSTRING(nv_yea,3,2) + nv_mon + nv_dat.
                            nv_expdat = SUBSTRING(nv_yea1,3,2) + nv_mon1 + nv_dat1.
                            /*Lukkana M. A55-0209 05/07/2012*/
                            /*Lukkana M. A53-0161 22/04/2010 เพิ่มเงื่อนไขนี้*/
                            IF (SUBSTR(aycldeto2_fil.comdat,1,2) = SUBSTR(nv_comdat,1,2)) OR (aycldeto2_fil.comdat = "000000") THEN DO: /*เช็คปีต้องเท่ากับไฟล์ที่ส่งมา หรือถ้าเป็นค่าว่างให้ส่งค่ากลับไป*/
                                ASSIGN
                                    aycldeto2_fil.policy  = CAPS(sicuw.uwm100.policy)
                                    aycldeto2_fil.comdat  = nv_comdat
                                    aycldeto2_fil.expdat  = nv_expdat .
                
                                FOR EACH sicuw.uwm100 USE-INDEX uwm10091          WHERE 
                                         sicuw.uwm100.releas = YES                  AND 
                                         sicuw.uwm100.policy = sicuw.uwm301.policy  NO-LOCK .
                                    ASSIGN
                                        nv_prem   = nv_prem   + sicuw.uwm100.prem_t
                                        nv_rstp_t = nv_rstp_t + sicuw.uwm100.rstp_t
                                        nv_rtax_t = nv_rtax_t + sicuw.uwm100.rtax_t.
                                END.
                                /*---Lukkana M. A53-0135 31/03/2010---*/
                                ASSIGN                                             
                                    aycldeto2_fil.prem    = TRIM(REPLACE(STRING(nv_prem,">>>>>>>>>>>>9.99"),".",""))
                                    aycldeto2_fil.premtax = TRIM(REPLACE(STRING(nv_rstp_t + nv_rtax_t,">>>>>>>>>>>>9.99"),".","")) /*A58-0121*/
                                    aycldeto2_fil.insrayrno = "การประกันภัยรถยนต์(ภาคสมัครใจ)"  /*A58-0121*/
                                    aycldeto2_fil.premtot = TRIM(REPLACE(STRING(nv_prem + nv_rstp_t + nv_rtax_t,">>>>>>>>>>>>9.99"),".","")).
                                /*---Lukkana M. A53-0135 31/03/2010---*/
                                /**** Insured Item ****/
                                FIND LAST sicuw.uwm130 USE-INDEX uwm13001 WHERE 
                                          sicuw.uwm130.policy = sicuw.uwm301.policy AND
                                          sicuw.uwm130.rencnt = sicuw.uwm301.rencnt AND
                                          sicuw.uwm130.endcnt = sicuw.uwm301.endcnt AND
                                          sicuw.uwm130.riskgp = sicuw.uwm301.riskgp AND
                                          sicuw.uwm130.riskno = sicuw.uwm301.riskno AND
                                          sicuw.uwm130.itemno = sicuw.uwm301.itemno 
                                NO-LOCK NO-ERROR NO-WAIT.
                                IF AVAIL uwm130 THEN DO:
                                    /**** SUM INSURE ****/
                                    /*---Lukkana M. A53-0135 31/03/2010----*/                                     
                                    IF sicuw.uwm301.covcod = "1" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                    ELSE IF sicuw.uwm301.covcod = "2" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom7_v,">>>>>>>>>>>>9.99"),".","").
                                    ELSE IF sicuw.uwm301.covcod = "2.1" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                    ELSE DO: 
                                        /*A57-0291*/
                                        IF      sicuw.uwm130.uom6_v <> 0 THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                        ELSE IF sicuw.uwm130.uom7_v <> 0 THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom7_v,">>>>>>>>>>>>9.99"),".","").
                                        ELSE nv_si = "000000000000000". 
                                        /*A57-0291*/
                                    END.  /*Lukkana M. A55-0209 05/07/2012*/
                                    /*---Lukkana M. A53-0135 31/03/2010----*/
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

                                END. /* Avail uwm130 */
                                nv_compcnt = nv_compcnt + 1.  /* record found count */
                            END. /*IF (SUBSTR(aycldeto2_fil.comdat,1,2) = SUBSTR(nv_comdat,1,2)) OR aycldeto2_fil.comdat = "000000" */
                            ELSE DO:
                                nv_ncompcnt = nv_ncompcnt + 1. /* record not found count */
                                ASSIGN
                                    aycldeto2_fil.remark = "ปีที่คุ้มครองไม่ตรง" 
                                    SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm100.policy. /*Lukkana M. A55-0244 01/08/2012*/
                
                            END.
                            END. /*หา code เจอ*/
                        END. /* Avail uwm100 */ 
                    END. /*IF sicuw.uwm301.trareg <> ""  THEN DO:*/
                END. /*IF sicuw.uwm301.policy  <> aycldeto2_fil.notify THEN DO: /*ให้เช็คเพิ่มถ้า policy ไม่ตรงกัน*/ */
             END. /*FIND LAST sicuw.uwm301 USE-INDEX uwm30103 WHERE if avail sicuw.uwm301*/
             ELSE DO:
                 ASSIGN aycldeto2_fil.remark         = "ไม่มีข้อมูลในระบบ".
                 /* comment by : Ranu I. A65-0115...
                 ASSIGN
                     nv_si_n      = INTE(aycldeto2_fil.si)
                     nv_prem_n    = INTE(aycldeto2_fil.prem)
                     nv_prem_taxstm = INTE(aycldeto2_fil.premtax) /*A58-0121*/
                     nv_premtot_n = INTE(aycldeto2_fil.premtot).
                 
                 ASSIGN
                     aycldeto2_fil.si      = TRIM(REPLACE(STRING(nv_si_n,">>>>>>>>>>>>9.99"),".",""))
                     aycldeto2_fil.prem    = TRIM(REPLACE(STRING(nv_prem_n,">>>>>>>>>>>>9.99"),".",""))
                     aycldeto2_fil.premtax = TRIM(REPLACE(STRING(nv_prem_taxstm,">>>>>>>>>>>>9.99"),".","")) /*A58-0121*/
                     aycldeto2_fil.insrayrno = "การประกันภัยรถยนต์(ภาคสมัครใจ)"  /*A58-0121*/
                     aycldeto2_fil.premtot = TRIM(REPLACE(STRING(nv_premtot_n,">>>>>>>>>>>>9.99"),".","")).  
                ...end : A65-0115...*/
             END.
         END.
         /*Lukkana M. A55-0244 03/08/2012*/
     END. /*Lukkana M. A55-0209 11/07/2012*/
    END. /* FOR EACH aycldeto2_fil */
    RELEASE aycldeto2_fil.

  END. /*if nv_outagent <> ""*/
  ELSE IF nv_outagent = "" THEN DO:  /*Lukkana M. A55-0209 18/07/2012*/

    FOR EACH aycldeto2_fil WHERE 
        aycldeto2_fil.bchyr  = nv_bchyr  AND
        aycldeto2_fil.bchno  = nv_bchno  AND
        aycldeto2_fil.bchcnt = nv_bchcnt AND
       (aycldeto2_fil.rectyp <> "H" AND   /* Header */
        aycldeto2_fil.rectyp <> "T" )     /* Total */
      :   
        
        ASSIGN
            nv_prem   = 0 
            nv_rstp_t = 0
            nv_rtax_t = 0
            nv_dat    = ""  /*Lukkana M. A55-0209 05/07/2012*/
            nv_mon    = ""  /*Lukkana M. A55-0209 05/07/2012*/
            nv_yea    = ""  /*Lukkana M. A55-0209 05/07/2012*/
            nv_policyno = trim(aycldeto2_fil.notify)  /*A56-0119*/
            nv_i        = 0                          /*A56-0119*/
            nv_l        = LENGTH(nv_policyno).       /*A56-0119*/
        /*add Kridtiya i. A56-0119 */
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
        /*end ...add Kridtiya i. A56-0119 */
      
        /*----Lukkana M. A52-0225 04/08/2009----*/
        FIND LAST sicuw.uwm301 USE-INDEX uwm30103                       WHERE
                  sicuw.uwm301.trareg             = aycldeto2_fil.cha_no AND 
                  /*sicuw.uwm301.policy           = aycldeto2_fil.notify AND /*Lukkana M. A53-0161 22/04/2010*/*//*A56-0119*/
                  sicuw.uwm301.policy             = nv_policyno         AND                                     /*A56-0119*/
                  SUBSTR(sicuw.uwm301.policy,3,2) = "70"                NO-LOCK NO-ERROR NO-WAIT.
        /*----Lukkana M. A52-0225 04/08/2009----*/  
        IF AVAIL uwm301 THEN DO: /*เช็ค chasis และ policy ตรงกัน ให้ส่งข้อมูลได้ (ตามเงื่อนไขข้อ 1)*/
        
            FIND LAST sicuw.uwm100 USE-INDEX uwm10001           WHERE 
                      sicuw.uwm100.policy = sicuw.uwm301.policy AND 
                      sicuw.uwm100.rencnt = sicuw.uwm301.rencnt AND
                      sicuw.uwm100.endcnt = sicuw.uwm301.endcnt AND 
                      sicuw.uwm100.releas = YES                 NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL uwm100 THEN DO:
                
                /*Lukkana M. A55-0209 05/07/2012*/
                ASSIGN
                    nv_dat   = STRING(DAY(sicuw.uwm100.comdat),"99")
                    nv_mon   = STRING(MONTH(sicuw.uwm100.comdat),"99")
                    nv_yea   = STRING(YEAR(sicuw.uwm100.comdat) + 543 , "9999")
                    nv_dat1  = STRING(DAY(sicuw.uwm100.expdat),"99")
                    nv_mon1  = STRING(MONTH(sicuw.uwm100.expdat),"99")
                    nv_yea1  = STRING(YEAR(sicuw.uwm100.expdat) + 543 , "9999").

                nv_comdat = SUBSTRING(nv_yea,3,2) + nv_mon + nv_dat.
                nv_expdat = SUBSTRING(nv_yea1,3,2) + nv_mon1 + nv_dat1.
                /*Lukkana M. A55-0209 05/07/2012*/


                /*Lukkana M. A53-0161 22/04/2010 เพิ่มเงื่อนไขนี้*/
                IF (SUBSTR(aycldeto2_fil.comdat,1,2) = SUBSTR(nv_comdat,1,2)) OR (aycldeto2_fil.comdat = "000000") THEN DO: /*เช็คปีต้องเท่ากับไฟล์ที่ส่งมา หรือถ้าเป็นค่าว่างให้ส่งค่ากลับไป*/
                    ASSIGN
                        aycldeto2_fil.policy  = CAPS(sicuw.uwm100.policy)
                        aycldeto2_fil.comdat  = nv_comdat
                        aycldeto2_fil.expdat  = nv_expdat .
    
                    FOR EACH sicuw.uwm100 USE-INDEX uwm10091            WHERE 
                             sicuw.uwm100.releas = YES                  AND
                             sicuw.uwm100.policy = sicuw.uwm301.policy  NO-LOCK.
                        ASSIGN
                            nv_prem   = nv_prem   + sicuw.uwm100.prem_t
                            nv_rstp_t = nv_rstp_t + sicuw.uwm100.rstp_t
                            nv_rtax_t = nv_rtax_t + sicuw.uwm100.rtax_t.
                    END.
                    
                    /*---Lukkana M. A53-0135 31/03/2010---*/
                    ASSIGN                                             
                        aycldeto2_fil.prem    = TRIM(REPLACE(STRING(nv_prem,">>>>>>>>>>>>9.99"),".",""))
                        aycldeto2_fil.premtax = TRIM(REPLACE(STRING(nv_rstp_t + nv_rtax_t,">>>>>>>>>>>>9.99"),".","")) /*A58-0121*/
                        aycldeto2_fil.insrayrno = "การประกันภัยรถยนต์(ภาคสมัครใจ)"  /*A58-0121*/
                        aycldeto2_fil.premtot = TRIM(REPLACE(STRING(nv_prem + nv_rstp_t + nv_rtax_t,">>>>>>>>>>>>9.99"),".","")).
                    /*---Lukkana M. A53-0135 31/03/2010---*/
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
                        /*---Lukkana M. A53-0135 31/03/2010----*/                                     
                        IF sicuw.uwm301.covcod = "1" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                        ELSE IF sicuw.uwm301.covcod = "2" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom7_v,">>>>>>>>>>>>9.99"),".","").
                        ELSE IF sicuw.uwm301.covcod = "2.1" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                        ELSE DO: 
                            /*A57-0291*/
                            IF      sicuw.uwm130.uom6_v <> 0 THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                            ELSE IF sicuw.uwm130.uom7_v <> 0 THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom7_v,">>>>>>>>>>>>9.99"),".","").
                            ELSE nv_si = "000000000000000". 
                            /*A57-0291*/
                        END.  /*Lukkana M. A55-0209 05/07/2012*/
                        /*---Lukkana M. A53-0135 31/03/2010----*/
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

                    END. /* Avail uwm130 */
                    nv_compcnt = nv_compcnt + 1.  /* record found count */
                END.
                ELSE DO:
                    nv_ncompcnt = nv_ncompcnt + 1. /* record not found count */
                    ASSIGN
                        aycldeto2_fil.remark = "ปีที่คุ้มครองไม่ตรง" 
                        SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm100.policy. /*Lukkana M. A55-0244 01/08/2012*/
                END.
            END. /* Avail uwm100 */    
            ELSE DO: /*--if not avail uwm100--*/
                FIND LAST sicuw.uwm100 USE-INDEX uwm10091          WHERE 
                          sicuw.uwm100.releas = YES                  AND
                          sicuw.uwm100.policy = sicuw.uwm301.policy  NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL sicuw.uwm100 THEN DO:
                    FIND LAST sicuw.uwm301 USE-INDEX uwm30101 WHERE 
                              sicuw.uwm301.policy = sicuw.uwm100.policy AND
                              sicuw.uwm301.rencnt = sicuw.uwm100.rencnt AND
                              sicuw.uwm301.endcnt = sicuw.uwm100.endcnt NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAIL sicuw.uwm301 THEN DO:
                        IF sicuw.uwm301.trareg = aycldeto2_fil.cha_no THEN DO: /*ย้อนมาเช็คเลขตัวถังรถว่าตรงกันหรือไม่*/
                            
                            /*Lukkana M. A55-0209 05/07/2012*/
                            ASSIGN
                                nv_dat   = STRING(DAY(sicuw.uwm100.comdat),"99")
                                nv_mon   = STRING(MONTH(sicuw.uwm100.comdat),"99")
                                nv_yea   = STRING(YEAR(sicuw.uwm100.comdat) + 543 , "9999")
                                nv_dat1  = STRING(DAY(sicuw.uwm100.expdat),"99")
                                nv_mon1  = STRING(MONTH(sicuw.uwm100.expdat),"99")
                                nv_yea1  = STRING(YEAR(sicuw.uwm100.expdat) + 543 , "9999").
                            nv_comdat = SUBSTRING(nv_yea,3,2) + nv_mon + nv_dat.
                            nv_expdat = SUBSTRING(nv_yea1,3,2) + nv_mon1 + nv_dat1.
                            /*Lukkana M. A55-0209 05/07/2012*/

                            /*--Lukkana M. A53-0161 22/04/2010--*/
                            IF (SUBSTR(aycldeto2_fil.comdat,1,2) = SUBSTR(nv_comdat,1,2)) OR (aycldeto2_fil.comdat = "000000") THEN DO: /*เช็คปีต้องเท่ากับไฟล์ที่ส่งมา หรือถ้าเป็นค่าว่างให้ส่งค่ากลับไป*/
                                ASSIGN
                                    aycldeto2_fil.policy  = CAPS(sicuw.uwm100.policy)
                                    aycldeto2_fil.comdat  = nv_comdat
                                    aycldeto2_fil.expdat  = nv_expdat .
                                FOR EACH sicuw.uwm100 USE-INDEX uwm10091         WHERE 
                                         sicuw.uwm100.releas = YES                 AND
                                         sicuw.uwm100.policy = sicuw.uwm301.policy NO-LOCK. /*คำนวณเบี้ย*/
                                    ASSIGN
                                        nv_prem   = nv_prem   + sicuw.uwm100.prem_t
                                        nv_rstp_t = nv_rstp_t + sicuw.uwm100.rstp_t
                                        nv_rtax_t = nv_rtax_t + sicuw.uwm100.rtax_t.
                                END.  
                                
                                /*--Lukkana M. A53-0135 31/03/2010---*/
                                ASSIGN  aycldeto2_fil.prem    = TRIM(REPLACE(STRING(nv_prem,">>>>>>>>>>>>9.99"),".",""))
                                aycldeto2_fil.premtax = TRIM(REPLACE(STRING(nv_rstp_t + nv_rtax_t,">>>>>>>>>>>>9.99"),".","")) /*A58-0121*/
                                aycldeto2_fil.insrayrno = "การประกันภัยรถยนต์(ภาคสมัครใจ)"  /*A58-0121*/
                                aycldeto2_fil.premtot = TRIM(REPLACE(STRING(nv_prem + nv_rstp_t + nv_rtax_t,">>>>>>>>>>>>9.99"),".","")).
                                /*--Lukkana M. A53-0135 31/03/2010---*/
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
                                    
                                    /*---Lukkana M. A53-0135 31/03/2010----*/                                     
                                    IF      sicuw.uwm301.covcod = "1" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                    ELSE IF sicuw.uwm301.covcod = "2" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom7_v,">>>>>>>>>>>>9.99"),".","").
                                    ELSE IF sicuw.uwm301.covcod = "2.1" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                    ELSE DO:
                                        /*A57-0291*/
                                        IF      sicuw.uwm130.uom6_v <> 0 THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                        ELSE IF sicuw.uwm130.uom7_v <> 0 THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom7_v,">>>>>>>>>>>>9.99"),".","").
                                        ELSE nv_si = "000000000000000". 
                                        /*A57-0291*/
                                    END.   /*Lukkana M. A55-0209 05/07/2012*/
                                    /*---Lukkana M. A53-0135 31/03/2010----*/
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

                                END. /* Avail uwm130 */
                                nv_compcnt = nv_compcnt + 1.  /* record found count */
                            END. /*IF (SUBSTR(aycldeto2_fil.comdat,1,2) = SUBSTR(nv_comdat,1,2)) OR aycldeto2_fil.comdat = "000000" THEN DO:*/
                            ELSE DO:
                                nv_ncompcnt = nv_ncompcnt + 1. /* record not found count */
                                ASSIGN
                                    aycldeto2_fil.remark = "ปีที่คุ้มครองไม่ตรง" 
                                    SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm301.policy. /*Lukkana M. A55-0244 01/08/2012*/
                            END.
                        END. /*--if sicuw.uwm301.trareg = aycldeto2_fil.cha_no--*/
                        ELSE DO: /*เลขตัวถังรถไม่ตรงกัน*/
                            nv_ncompcnt = nv_ncompcnt + 1. /* record not found count */
                            ASSIGN
                                aycldeto2_fil.remark = "Not Found Policy permitt Chassis " + aycldeto2_fil.cha_no
                                SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm301.policy. /*Lukkana M. A55-0244 01/08/2012*/
                            /* comment by : Ranu I. A65-0115...
                            /*--Lukkana M. A53-0135 31/03/2010--*/
                            ASSIGN
                                nv_si_n        = INTE(aycldeto2_fil.si)
                                nv_prem_n      = INTE(aycldeto2_fil.prem)
                                nv_prem_taxstm = INTE(aycldeto2_fil.premtax) /*A58-0121*/
                                nv_premtot_n   = INTE(aycldeto2_fil.premtot).
                            ASSIGN
                                aycldeto2_fil.si      = TRIM(REPLACE(STRING(nv_si_n,">>>>>>>>>>>>9.99"),".",""))
                                aycldeto2_fil.prem    = TRIM(REPLACE(STRING(nv_prem_n,">>>>>>>>>>>>9.99"),".",""))
                                aycldeto2_fil.premtax = TRIM(REPLACE(STRING(nv_prem_taxstm,">>>>>>>>>>>>9.99"),".","")) /*A58-0121*/
                                aycldeto2_fil.insrayrno = "การประกันภัยรถยนต์(ภาคสมัครใจ)"  /*A58-0121*/
                                aycldeto2_fil.premtot = TRIM(REPLACE(STRING(nv_premtot_n,">>>>>>>>>>>>9.99"),".","")).
                            /*--Lukkana M. A53-0135 31/03/2010--*/
                            ...end : A65-0115...*/
                        END.
                    END.    /*--if avail sicuw.uwm301--*/
                END. /*--if avail sicuw.uwm100--*/
                ELSE DO: /*uwm100.releas = no*/
                    nv_ncompcnt = nv_ncompcnt + 1. /* record not found count */
                    ASSIGN
                        aycldeto2_fil.remark = "Policy Not Release" 
                        SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm301.policy. /*Lukkana M. A55-0244 01/08/2012*/
                    /* comment by : Ranu I. A65-0115...
                    /*--Lukkana M. A53-0135 31/03/2010--*/
                    ASSIGN
                        nv_si_n      = INTE(aycldeto2_fil.si)
                        nv_prem_n    = INTE(aycldeto2_fil.prem)
                        nv_prem_taxstm = INTE(aycldeto2_fil.premtax) /*A58-0121*/
                        nv_premtot_n = INTE(aycldeto2_fil.premtot).
                    ASSIGN
                        aycldeto2_fil.si      = TRIM(REPLACE(STRING(nv_si_n,">>>>>>>>>>>>9.99"),".",""))
                        aycldeto2_fil.prem    = TRIM(REPLACE(STRING(nv_prem_n,">>>>>>>>>>>>9.99"),".",""))
                        aycldeto2_fil.premtax = TRIM(REPLACE(STRING(nv_prem_taxstm,">>>>>>>>>>>>9.99"),".","")) /*A58-0121*/
                        aycldeto2_fil.insrayrno = "การประกันภัยรถยนต์(ภาคสมัครใจ)"  /*A58-0121*/
                        aycldeto2_fil.premtot = TRIM(REPLACE(STRING(nv_premtot_n,">>>>>>>>>>>>9.99"),".","")).
                    /*--Lukkana M. A53-0135 31/03/2010--*/
                    ... end : A65-0115...*/
                END.
            END. /*--else do (if not avail uwm100)--*/
        END. /* Avail uwm301 */
        ELSE DO: /* Not Avail uwm301 */
            
            /*--Lukkana M. A53-0161 13/05/2010 เช็คเงื่อนไขใหม่--*/
            FIND LAST sicuw.uwm301 USE-INDEX uwm30103                       WHERE
                      sicuw.uwm301.trareg             = aycldeto2_fil.cha_no AND 
                      SUBSTR(sicuw.uwm301.policy,3,2) = "70"                NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL uwm301 THEN DO: /*เช็คทีละเงื่อนไข ถ้า chasiss ตรงกัน (ตามเงื่อนไขข้อ 4,5) */
                /*IF sicuw.uwm301.policy  <> aycldeto2_fil.notify THEN DO: /*ให้เช็คเพิ่มถ้า policy ไม่ตรงกัน*/*//*A56-0119*/
                IF sicuw.uwm301.policy  <> nv_policyno THEN DO:         /*A56-0119*/

                    IF sicuw.uwm301.trareg = ""  THEN DO:
                        nv_ncompcnt = nv_ncompcnt + 1. /* record not found count */
        
                        ASSIGN
                            aycldeto2_fil.remark = "Chassis is null " 
                            SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm301.policy. /*Lukkana M. A55-0244 01/08/2012*/

                    END. /*IF sicuw.uwm301.trareg = ""  THEN DO:*/
                    ELSE DO:
                        FIND LAST sicuw.uwm100 USE-INDEX uwm10001           WHERE 
                                  sicuw.uwm100.policy = sicuw.uwm301.policy AND 
                                  sicuw.uwm100.rencnt = sicuw.uwm301.rencnt AND
                                  sicuw.uwm100.endcnt = sicuw.uwm301.endcnt AND 
                                  sicuw.uwm100.releas = YES                 NO-LOCK NO-ERROR NO-WAIT.
                        IF AVAIL uwm100 THEN DO:
                            
                            /*Lukkana M. A55-0209 05/07/2012*/
                            ASSIGN
                                nv_dat   = STRING(DAY(sicuw.uwm100.comdat),"99")
                                nv_mon   = STRING(MONTH(sicuw.uwm100.comdat),"99")
                                nv_yea   = STRING(YEAR(sicuw.uwm100.comdat) + 543 , "9999")
                                nv_dat1  = STRING(DAY(sicuw.uwm100.expdat),"99")
                                nv_mon1  = STRING(MONTH(sicuw.uwm100.expdat),"99")
                                nv_yea1  = STRING(YEAR(sicuw.uwm100.expdat) + 543 , "9999").
            
                            nv_comdat = SUBSTRING(nv_yea,3,2) + nv_mon + nv_dat.
                            nv_expdat = SUBSTRING(nv_yea1,3,2) + nv_mon1 + nv_dat1.
                            /*Lukkana M. A55-0209 05/07/2012*/

                            /*Lukkana M. A53-0161 22/04/2010 เพิ่มเงื่อนไขนี้*/
                            IF (SUBSTR(aycldeto2_fil.comdat,1,2) = SUBSTR(nv_comdat,1,2)) OR (aycldeto2_fil.comdat = "000000") THEN DO: /*เช็คปีต้องเท่ากับไฟล์ที่ส่งมา หรือถ้าเป็นค่าว่างให้ส่งค่ากลับไป*/
                                ASSIGN
                                    aycldeto2_fil.policy  = CAPS(sicuw.uwm100.policy)
                                    aycldeto2_fil.comdat  = nv_comdat
                                    aycldeto2_fil.expdat  = nv_expdat .
                
                                FOR EACH sicuw.uwm100 USE-INDEX uwm10091          WHERE 
                                         sicuw.uwm100.releas = YES                  AND 
                                         sicuw.uwm100.policy = sicuw.uwm301.policy  NO-LOCK .
                                    ASSIGN
                                        nv_prem   = nv_prem   + sicuw.uwm100.prem_t
                                        nv_rstp_t = nv_rstp_t + sicuw.uwm100.rstp_t
                                        nv_rtax_t = nv_rtax_t + sicuw.uwm100.rtax_t.
                                END.

                                /*---Lukkana M. A53-0135 31/03/2010---*/
                                ASSIGN                                             
                                    aycldeto2_fil.prem    = TRIM(REPLACE(STRING(nv_prem,">>>>>>>>>>>>9.99"),".",""))
                                    aycldeto2_fil.premtax = TRIM(REPLACE(STRING(nv_rstp_t + nv_rtax_t,">>>>>>>>>>>>9.99"),".","")) /*A58-0121*/
                                    aycldeto2_fil.insrayrno = "การประกันภัยรถยนต์(ภาคสมัครใจ)"  /*A58-0121*/
                                    aycldeto2_fil.premtot = TRIM(REPLACE(STRING(nv_prem + nv_rstp_t + nv_rtax_t,">>>>>>>>>>>>9.99"),".","")).
                                /*---Lukkana M. A53-0135 31/03/2010---*/
                                /**** Insured Item ****/
                                FIND LAST sicuw.uwm130 USE-INDEX uwm13001 WHERE 
                                          sicuw.uwm130.policy = sicuw.uwm301.policy AND
                                          sicuw.uwm130.rencnt = sicuw.uwm301.rencnt AND
                                          sicuw.uwm130.endcnt = sicuw.uwm301.endcnt AND
                                          sicuw.uwm130.riskgp = sicuw.uwm301.riskgp AND
                                          sicuw.uwm130.riskno = sicuw.uwm301.riskno AND
                                          sicuw.uwm130.itemno = sicuw.uwm301.itemno 
                                NO-LOCK NO-ERROR NO-WAIT.
                                IF AVAIL uwm130 THEN DO:
                                    /**** SUM INSURE ****/
                                    /*---Lukkana M. A53-0135 31/03/2010----*/                                     
                                    IF      sicuw.uwm301.covcod = "1" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                    ELSE IF sicuw.uwm301.covcod = "2" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom7_v,">>>>>>>>>>>>9.99"),".","").
                                    ELSE IF sicuw.uwm301.covcod = "2.1" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                    ELSE DO: 
                                        /*A57-0291*/
                                        IF      sicuw.uwm130.uom6_v <> 0 THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                        ELSE IF sicuw.uwm130.uom7_v <> 0 THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom7_v,">>>>>>>>>>>>9.99"),".","").
                                        ELSE nv_si = "000000000000000". 
                                        /*A57-0291*/
                                    END.    /*Lukkana M. A55-0209 05/07/2012*/
                                    /*---Lukkana M. A53-0135 31/03/2010----*/
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

                                END. /* Avail uwm130 */
                                nv_compcnt = nv_compcnt + 1.  /* record found count */
                            END. /*IF (SUBSTR(aycldeto2_fil.comdat,1,2) = SUBSTR(nv_comdat,1,2)) OR aycldeto2_fil.comdat = "000000" */
                            ELSE DO:
                                nv_ncompcnt = nv_ncompcnt + 1. /* record not found count */
                                ASSIGN
                                    aycldeto2_fil.remark = "ปีที่คุ้มครองไม่ตรง" 
                                    SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm301.policy. /*Lukkana M. A55-0244 01/08/2012*/
                            END.
                        END. /* Avail uwm100 */    
                        ELSE DO: /*--if not avail uwm100--*/
                            FIND LAST sicuw.uwm100 USE-INDEX uwm10091            WHERE 
                                      sicuw.uwm100.releas = YES                  AND
                                      sicuw.uwm100.policy = sicuw.uwm301.policy  NO-LOCK NO-ERROR NO-WAIT.
                            IF AVAIL sicuw.uwm100 THEN DO:
                                FIND LAST sicuw.uwm301 USE-INDEX uwm30101 WHERE 
                                          sicuw.uwm301.policy = sicuw.uwm100.policy AND
                                          sicuw.uwm301.rencnt = sicuw.uwm100.rencnt AND
                                          sicuw.uwm301.endcnt = sicuw.uwm100.endcnt NO-LOCK NO-ERROR NO-WAIT.
                                IF AVAIL sicuw.uwm301 THEN DO:
                                    IF sicuw.uwm301.trareg = aycldeto2_fil.cha_no THEN DO: /*ย้อนมาเช็คเลขตัวถังรถว่าตรงกันหรือไม่*/
                                       
                                        /*Lukkana M. A55-0209 05/07/2012*/
                                        ASSIGN
                                            nv_dat   = STRING(DAY(sicuw.uwm100.comdat),"99")
                                            nv_mon   = STRING(MONTH(sicuw.uwm100.comdat),"99")
                                            nv_yea   = STRING(YEAR(sicuw.uwm100.comdat) + 543 , "9999")
                                            nv_dat1  = STRING(DAY(sicuw.uwm100.expdat),"99")
                                            nv_mon1  = STRING(MONTH(sicuw.uwm100.expdat),"99")
                                            nv_yea1  = STRING(YEAR(sicuw.uwm100.expdat) + 543 , "9999").
                        
                                        nv_comdat = SUBSTRING(nv_yea,3,2) + nv_mon + nv_dat.
                                        nv_expdat = SUBSTRING(nv_yea1,3,2) + nv_mon1 + nv_dat1.
                                        /*Lukkana M. A55-0209 05/07/2012*/
            
                                        /*--Lukkana M. A53-0161 22/04/2010--*/
                                        IF (SUBSTR(aycldeto2_fil.comdat,1,2) = SUBSTR(nv_comdat,1,2)) OR (aycldeto2_fil.comdat = "000000") THEN DO: /*เช็คปีต้องเท่ากับไฟล์ที่ส่งมา หรือถ้าเป็นค่าว่างให้ส่งค่ากลับไป*/
                                            ASSIGN
                                                aycldeto2_fil.policy  = CAPS(sicuw.uwm100.policy)
                                                aycldeto2_fil.comdat  = nv_comdat
                                                aycldeto2_fil.expdat  = nv_expdat .
                
                                            FOR EACH sicuw.uwm100 USE-INDEX uwm10091         WHERE 
                                                     sicuw.uwm100.releas = YES                 AND
                                                     sicuw.uwm100.policy = sicuw.uwm301.policy NO-LOCK. /*คำนวณเบี้ย*/
                                                                        
                                                ASSIGN
                                                    nv_prem   = nv_prem   + sicuw.uwm100.prem_t
                                                    nv_rstp_t = nv_rstp_t + sicuw.uwm100.rstp_t
                                                    nv_rtax_t = nv_rtax_t + sicuw.uwm100.rtax_t.
                                            END.     

                                            /*--Lukkana M. A53-0135 31/03/2010---*/
                                            ASSIGN                                             
                                                aycldeto2_fil.prem    = TRIM(REPLACE(STRING(nv_prem,">>>>>>>>>>>>9.99"),".",""))
                                                aycldeto2_fil.premtax = TRIM(REPLACE(STRING(nv_rstp_t + nv_rtax_t,">>>>>>>>>>>>9.99"),".","")) /*A58-0121*/
                                                aycldeto2_fil.insrayrno = "การประกันภัยรถยนต์(ภาคสมัครใจ)"  /*A58-0121*/
                                                aycldeto2_fil.premtot = TRIM(REPLACE(STRING(nv_prem + nv_rstp_t + nv_rtax_t,">>>>>>>>>>>>9.99"),".","")).
                                            /*--Lukkana M. A53-0135 31/03/2010---*/
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
                                                /*---Lukkana M. A53-0135 31/03/2010----*/                                     
                                                IF      sicuw.uwm301.covcod = "1" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                                ELSE IF sicuw.uwm301.covcod = "2" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom7_v,">>>>>>>>>>>>9.99"),".","").
                                                ELSE IF sicuw.uwm301.covcod = "2.1" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                                ELSE DO: 
                                                    /*A57-0291*/
                                                    IF      sicuw.uwm130.uom6_v <> 0 THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                                    ELSE IF sicuw.uwm130.uom7_v <> 0 THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom7_v,">>>>>>>>>>>>9.99"),".","").
                                                    ELSE nv_si = "000000000000000". 
                                                    /*A57-0291*/
                                                END.  /*Lukkana M. A55-0209 05/07/2012*/
                                                /*---Lukkana M. A53-0135 31/03/2010----*/
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

                                            END. /* Avail uwm130 */
                                            nv_compcnt = nv_compcnt + 1.  /* record found count */
                                        END. /*IF (SUBSTR(aycldeto2_fil.comdat,1,2) = SUBSTR(nv_comdat,1,2)) OR aycldeto2_fil.comdat = "000000" THEN DO:*/
                                        ELSE DO:
                                            nv_ncompcnt = nv_ncompcnt + 1. /* record not found count */
                                            ASSIGN
                                                aycldeto2_fil.remark = "ปีที่คุ้มครองไม่ตรง" 
                                                SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm301.policy. /*Lukkana M. A55-0244 01/08/2012*/
                                        END.
                                    END. /*--if sicuw.uwm301.trareg = aycldeto2_fil.cha_no--*/
                                    ELSE DO: /*เลขตัวถังรถไม่ตรงกัน*/
                                        nv_ncompcnt = nv_ncompcnt + 1. /* record not found count */
                                        ASSIGN
                                            aycldeto2_fil.remark = "Not Found Policy permitt Chassis " + aycldeto2_fil.cha_no
                                            SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm301.policy. /*Lukkana M. A55-0244 01/08/2012*/
                                        /* comment by : Ranu I. A65-0115...
                                        /*--Lukkana M. A53-0135 31/03/2010--*/
                                        ASSIGN
                                            nv_si_n      = INTE(aycldeto2_fil.si)
                                            nv_prem_n    = INTE(aycldeto2_fil.prem)
                                            nv_prem_taxstm = INTE(aycldeto2_fil.premtax) /*A58-0121*/
                                            nv_premtot_n = INTE(aycldeto2_fil.premtot).

                                        ASSIGN
                                            aycldeto2_fil.si      = TRIM(REPLACE(STRING(nv_si_n,">>>>>>>>>>>>9.99"),".",""))
                                            aycldeto2_fil.prem    = TRIM(REPLACE(STRING(nv_prem_n,">>>>>>>>>>>>9.99"),".",""))
                                            aycldeto2_fil.premtax = TRIM(REPLACE(STRING(nv_prem_taxstm,">>>>>>>>>>>>9.99"),".","")) /*A58-0121*/
                                            aycldeto2_fil.insrayrno = "การประกันภัยรถยนต์(ภาคสมัครใจ)"  /*A58-0121*/
                                            aycldeto2_fil.premtot = TRIM(REPLACE(STRING(nv_premtot_n,">>>>>>>>>>>>9.99"),".","")).
                                        /*--Lukkana M. A53-0135 31/03/2010--*/
                                        ...end A65-0115...*/
            
                                    END.
                                END.    /*--if avail sicuw.uwm301--*/
                            END. /*--if avail sicuw.uwm100--*/
                            ELSE DO: /*uwm100.releas = no*/
                                nv_ncompcnt = nv_ncompcnt + 1. /* record not found count */
                                ASSIGN
                                    aycldeto2_fil.remark = "Policy Not Release" 
                                    SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm301.policy. /*Lukkana M. A55-0244 01/08/2012*/
                                /* comment by : Ranu I. A65-0115...
                                /*--Lukkana M. A53-0135 31/03/2010--*/
                                ASSIGN
                                    nv_si_n      = INTE(aycldeto2_fil.si)
                                    nv_prem_n    = INTE(aycldeto2_fil.prem)
                                    nv_prem_taxstm = INTE(aycldeto2_fil.premtax) /*A58-0121*/
                                    nv_premtot_n = INTE(aycldeto2_fil.premtot).
                    
                                ASSIGN
                                    aycldeto2_fil.si      = TRIM(REPLACE(STRING(nv_si_n,">>>>>>>>>>>>9.99"),".",""))
                                    aycldeto2_fil.prem    = TRIM(REPLACE(STRING(nv_prem_n,">>>>>>>>>>>>9.99"),".",""))
                                    aycldeto2_fil.premtax = TRIM(REPLACE(STRING(nv_prem_taxstm,">>>>>>>>>>>>9.99"),".","")) /*A58-0121*/
                                    aycldeto2_fil.insrayrno = "การประกันภัยรถยนต์(ภาคสมัครใจ)"  /*A58-0121*/
                                    aycldeto2_fil.premtot = TRIM(REPLACE(STRING(nv_premtot_n,">>>>>>>>>>>>9.99"),".","")).
                                /*--Lukkana M. A53-0135 31/03/2010--*/
                                ...end : A65-0115...*/
                            END.
                        END. /*--else do (if not avail uwm100)--*/
                    END. /*IF sicuw.uwm301.trareg <> ""  THEN DO:*/
                END. /*IF sicuw.uwm301.policy  <> aycldeto2_fil.notify THEN DO: /*ให้เช็คเพิ่มถ้า policy ไม่ตรงกัน*/ */
            END. /*FIND LAST sicuw.uwm301 USE-INDEX uwm30103 WHERE if avail sicuw.uwm301*/
            ELSE DO: 
                FIND LAST sicuw.uwm301 USE-INDEX uwm30101                       WHERE
                    /*sicuw.uwm301.policy             = aycldeto2_fil.notify AND *//*A56-0119*/
                    sicuw.uwm301.policy             = nv_policyno         AND     /*A56-0119*/
                    SUBSTR(sicuw.uwm301.policy,3,2) = "70"                NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL uwm301 THEN DO: /*ถ้า chasiss ไม่ตรง ให้มาเช็คกรมธรรม์ ถ้าตรงกัน ให้ทำ (ตามเงื่อนไขข้อ 2,3)*/
                    nv_name = "".
                    nv_name = TRIM(aycldeto2_fil.fname) + " " + TRIM(aycldeto2_fil.lname).
                    FIND FIRST sicsyac.xtm600 USE-INDEX xtm60002 WHERE sicsyac.xtm600.NAME = nv_name NO-LOCK NO-ERROR.
                    IF AVAIL xtm600 THEN nv_acno = xtm600.acno.
                    ELSE nv_acno = "".
                    IF sicuw.uwm301.trareg = ""  THEN DO:
                        nv_ncompcnt = nv_ncompcnt + 1. /* record not found count */
                        ASSIGN
                            aycldeto2_fil.remark = "Chassis is null " 
                            SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm301.policy. /*Lukkana M. A55-0244 01/08/2012*/
                    END. /*IF sicuw.uwm301.trareg = ""  THEN DO:*/
                    ELSE DO:
                        IF nv_acno = "" THEN DO: /*ถ้าชื่อ-นามสกุล เป็นค่าว่างไม่ส่งข้อมูล ตรงกับเงื่อนไขข้อ 3*/
                            nv_ncompcnt = nv_ncompcnt + 1. /* record not found count */
                            ASSIGN
                                aycldeto2_fil.remark = "Not Found Name  " + nv_name
                                SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm301.policy. /*Lukkana M. A55-0244 01/08/2012*/
                        END.
                        ELSE DO: 
                            FIND LAST sicuw.uwm100 USE-INDEX uwm10001           WHERE 
                                      sicuw.uwm100.policy = sicuw.uwm301.policy AND 
                                      sicuw.uwm100.rencnt = sicuw.uwm301.rencnt AND
                                      sicuw.uwm100.endcnt = sicuw.uwm301.endcnt AND 
                                      sicuw.uwm100.releas = YES                 NO-LOCK NO-ERROR NO-WAIT.
                            IF AVAIL uwm100 THEN DO:
                                IF sicuw.uwm100.insref = nv_acno THEN DO: /*Lukkana M. A53-0161 30/04/2010 Mapping ตามชื่อ ถ้าตรงกันให้แสดงข้อมูล เงื่อนไขข้อ2*/
                                    
                                    /*Lukkana M. A55-0209 05/07/2012*/
                                    ASSIGN
                                        nv_dat   = STRING(DAY(sicuw.uwm100.comdat),"99")
                                        nv_mon   = STRING(MONTH(sicuw.uwm100.comdat),"99")
                                        nv_yea   = STRING(YEAR(sicuw.uwm100.comdat) + 543 , "9999")
                                        nv_dat1  = STRING(DAY(sicuw.uwm100.expdat),"99")
                                        nv_mon1  = STRING(MONTH(sicuw.uwm100.expdat),"99")
                                        nv_yea1  = STRING(YEAR(sicuw.uwm100.expdat) + 543 , "9999").
                        
                                    nv_comdat = SUBSTRING(nv_yea,3,2) + nv_mon + nv_dat.
                                    nv_expdat = SUBSTRING(nv_yea1,3,2) + nv_mon1 + nv_dat1.
                                    /*Lukkana M. A55-0209 05/07/2012*/

                                    /*Lukkana M. A53-0161 22/04/2010 เพิ่มเงื่อนไขนี้*/
                                    IF (SUBSTR(aycldeto2_fil.comdat,1,2) = SUBSTR(nv_comdat,1,2)) OR (aycldeto2_fil.comdat = "000000") THEN DO: /*เช็คปีต้องเท่ากับไฟล์ที่ส่งมา หรือถ้าเป็นค่าว่างให้ส่งค่ากลับไป*/
                                        ASSIGN
                                            aycldeto2_fil.policy  = CAPS(sicuw.uwm100.policy)
                                            aycldeto2_fil.comdat  = nv_comdat
                                            aycldeto2_fil.expdat  = nv_expdat .
                                        FOR EACH sicuw.uwm100 USE-INDEX uwm10091          WHERE 
                                                 sicuw.uwm100.releas = YES                  AND
                                                 sicuw.uwm100.policy = sicuw.uwm301.policy  NO-LOCK.
                                            ASSIGN
                                                nv_prem   = nv_prem   + sicuw.uwm100.prem_t
                                                nv_rstp_t = nv_rstp_t + sicuw.uwm100.rstp_t
                                                nv_rtax_t = nv_rtax_t + sicuw.uwm100.rtax_t.
                                        END.

                                        /*---Lukkana M. A53-0135 31/03/2010---*/
                                        ASSIGN                                             
                                            aycldeto2_fil.prem    = TRIM(REPLACE(STRING(nv_prem,">>>>>>>>>>>>9.99"),".",""))
                                            aycldeto2_fil.premtax = TRIM(REPLACE(STRING(nv_rstp_t + nv_rtax_t,">>>>>>>>>>>>9.99"),".","")) /*A58-0121*/
                                            aycldeto2_fil.insrayrno = "การประกันภัยรถยนต์(ภาคสมัครใจ)"  /*A58-0121*/
                                            aycldeto2_fil.premtot = TRIM(REPLACE(STRING(nv_prem + nv_rstp_t + nv_rtax_t,">>>>>>>>>>>>9.99"),".","")).
                                        /*---Lukkana M. A53-0135 31/03/2010---*/                      
                        
                                        /**** Insured Item ****/
                                        FIND LAST sicuw.uwm130 USE-INDEX uwm13001 WHERE 
                                                  sicuw.uwm130.policy = sicuw.uwm301.policy AND
                                                  sicuw.uwm130.rencnt = sicuw.uwm301.rencnt AND
                                                  sicuw.uwm130.endcnt = sicuw.uwm301.endcnt AND
                                                  sicuw.uwm130.riskgp = sicuw.uwm301.riskgp AND
                                                  sicuw.uwm130.riskno = sicuw.uwm301.riskno AND
                                                  sicuw.uwm130.itemno = sicuw.uwm301.itemno 
                                        NO-LOCK NO-ERROR NO-WAIT.
                                        IF AVAIL uwm130 THEN DO:
                                            /**** SUM INSURE ****/
                                           /*---Lukkana M. A53-0135 31/03/2010----*/                                     
                                            IF      sicuw.uwm301.covcod = "1" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                            ELSE IF sicuw.uwm301.covcod = "2" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom7_v,">>>>>>>>>>>>9.99"),".","").
                                            ELSE IF sicuw.uwm301.covcod = "2.1" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                            ELSE DO: 
                                                /*A57-0291*/
                                                IF      sicuw.uwm130.uom6_v <> 0 THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                                ELSE IF sicuw.uwm130.uom7_v <> 0 THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom7_v,">>>>>>>>>>>>9.99"),".","").
                                                ELSE nv_si = "000000000000000". 
                                                /*A57-0291*/
                                            END.   /*Lukkana M. A55-0209 05/07/2012*/
                                            /*---Lukkana M. A53-0135 31/03/2010----*/
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

                                        END. /* Avail uwm130 */
                                        nv_compcnt = nv_compcnt + 1.  /* record found count */
                                    END. /*IF (SUBSTR(aycldeto2_fil.comdat,1,2) = SUBSTR(nv_comdat,1,2)) OR aycldeto2_fil.comdat = "000000" THEN DO:*/
                                    ELSE DO:
                                        nv_ncompcnt = nv_ncompcnt + 1. /* record not found count */
                                        ASSIGN
                                            aycldeto2_fil.remark = "ปีที่คุ้มครองไม่ตรง" 
                                            SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm100.policy. /*Lukkana M. A55-0244 01/08/2012*/
                    
                                    END.
                                END. /*IF sicuw.uwm100.insref = nv_acno THEN DO: /*Lukkana M. A53-0161 30/04/2010 Mapping ตามชื่อ ถ้าตรงกันให้แสดงข้อมูล*/*/
                                ELSE DO: /*ชื่อ-สกุลไม่ตรงกัน*/
                                    nv_ncompcnt = nv_ncompcnt + 1. /* record not found count */

                                    ASSIGN
                                        aycldeto2_fil.remark = "Not Found Name  " + nv_name
                                        SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm100.policy. /*Lukkana M. A55-0244 01/08/2012*/
                                END.
                            END. /* Avail uwm100 */    
                            ELSE DO: /*--if not avail uwm100--*/
                                FIND LAST sicuw.uwm100 USE-INDEX uwm10091         WHERE 
                                          sicuw.uwm100.releas = YES                 AND
                                          sicuw.uwm100.policy = sicuw.uwm301.policy NO-LOCK NO-ERROR NO-WAIT.
                                IF AVAIL sicuw.uwm100 THEN DO:
                                    FIND LAST sicuw.uwm301 USE-INDEX uwm30101 WHERE 
                                              sicuw.uwm301.policy = sicuw.uwm100.policy AND
                                              sicuw.uwm301.rencnt = sicuw.uwm100.rencnt AND
                                              sicuw.uwm301.endcnt = sicuw.uwm100.endcnt NO-LOCK NO-ERROR NO-WAIT.
                                    IF AVAIL sicuw.uwm301 THEN DO:
                                        IF sicuw.uwm301.trareg = aycldeto2_fil.cha_no THEN DO: /*ย้อนมาเช็คเลขตัวถังรถว่าตรงกันหรือไม่*/
                                            
                                            /*Lukkana M. A55-0209 05/07/2012*/
                                            ASSIGN
                                                nv_dat   = STRING(DAY(sicuw.uwm100.comdat),"99")
                                                nv_mon   = STRING(MONTH(sicuw.uwm100.comdat),"99")
                                                nv_yea   = STRING(YEAR(sicuw.uwm100.comdat) + 543 , "9999")
                                                nv_dat1  = STRING(DAY(sicuw.uwm100.expdat),"99")
                                                nv_mon1  = STRING(MONTH(sicuw.uwm100.expdat),"99")
                                                nv_yea1  = STRING(YEAR(sicuw.uwm100.expdat) + 543 , "9999").
                                
                                            nv_comdat = SUBSTRING(nv_yea,3,2) + nv_mon + nv_dat.
                                            nv_expdat = SUBSTRING(nv_yea1,3,2) + nv_mon1 + nv_dat1.
                                            /*Lukkana M. A55-0209 05/07/2012*/
                
                                            /*--Lukkana M. A53-0161 22/04/2010--*/
                                            IF (SUBSTR(aycldeto2_fil.comdat,1,2) = SUBSTR(nv_comdat,1,2)) OR (aycldeto2_fil.comdat = "000000") THEN DO: /*เช็คปีต้องเท่ากับไฟล์ที่ส่งมา หรือถ้าเป็นค่าว่างให้ส่งค่ากลับไป*/
                                                ASSIGN
                                                    aycldeto2_fil.policy  = CAPS(sicuw.uwm100.policy)
                                                    aycldeto2_fil.comdat  = nv_comdat
                                                    aycldeto2_fil.expdat  = nv_expdat .
                    
                                                FOR EACH sicuw.uwm100 USE-INDEX uwm10091           WHERE 
                                                         sicuw.uwm100.releas = YES                 AND
                                                         sicuw.uwm100.policy = sicuw.uwm301.policy NO-LOCK. /*คำนวณเบี้ย*/
                                                                            
                                                    ASSIGN
                                                        nv_prem   = nv_prem   + sicuw.uwm100.prem_t
                                                        nv_rstp_t = nv_rstp_t + sicuw.uwm100.rstp_t
                                                        nv_rtax_t = nv_rtax_t + sicuw.uwm100.rtax_t.
                                                END.   
                                                /*--Lukkana M. A53-0135 31/03/2010---*/
                                                ASSIGN                                             
                                                    aycldeto2_fil.prem    = TRIM(REPLACE(STRING(nv_prem,">>>>>>>>>>>>9.99"),".",""))
                                                    aycldeto2_fil.premtax = TRIM(REPLACE(STRING(nv_rstp_t + nv_rtax_t,">>>>>>>>>>>>9.99"),".","")) /*A58-0121*/
                                                    aycldeto2_fil.insrayrno = "การประกันภัยรถยนต์(ภาคสมัครใจ)"  /*A58-0121*/
                                                    aycldeto2_fil.premtot = TRIM(REPLACE(STRING(nv_prem + nv_rstp_t + nv_rtax_t,">>>>>>>>>>>>9.99"),".","")).
                                                /*--Lukkana M. A53-0135 31/03/2010---*/
                                                /**** Insured Item ****/
                                                FIND LAST sicuw.uwm130 USE-INDEX uwm13001 WHERE 
                                                          sicuw.uwm130.policy = sicuw.uwm301.policy AND
                                                          sicuw.uwm130.rencnt = sicuw.uwm301.rencnt AND
                                                          sicuw.uwm130.endcnt = sicuw.uwm301.endcnt AND
                                                          sicuw.uwm130.riskgp = sicuw.uwm301.riskgp AND
                                                          sicuw.uwm130.riskno = sicuw.uwm301.riskno AND
                                                          sicuw.uwm130.itemno = sicuw.uwm301.itemno 
                                                NO-LOCK NO-ERROR NO-WAIT.
                                                IF AVAIL uwm130 THEN DO:
                                        
                                                    /**** SUM INSURE ****/
                                                    /*---Lukkana M. A53-0135 31/03/2010----*/                                     
                                                    IF      sicuw.uwm301.covcod = "1"   THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                                    ELSE IF sicuw.uwm301.covcod = "2"   THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom7_v,">>>>>>>>>>>>9.99"),".","").
                                                    ELSE IF sicuw.uwm301.covcod = "2.1" THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                                    ELSE DO: 
                                                        /*A57-0291*/
                                                        IF      sicuw.uwm130.uom6_v <> 0 THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom6_v,">>>>>>>>>>>>9.99"),".","").
                                                        ELSE IF sicuw.uwm130.uom7_v <> 0 THEN nv_si = REPLACE(STRING(sicuw.uwm130.uom7_v,">>>>>>>>>>>>9.99"),".","").
                                                        ELSE nv_si = "000000000000000". 
                                                        /*A57-0291*/
                                                    END.   /*Lukkana M. A55-0209 05/07/2012*/
                                                    /*---Lukkana M. A53-0135 31/03/2010----*/
                    
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
                                    
                                                END. /* Avail uwm130 */
                                    
                                                nv_compcnt = nv_compcnt + 1.  /* record found count */
                                            END. /*IF (SUBSTR(aycldeto2_fil.comdat,1,2) = SUBSTR(nv_comdat,1,2)) OR aycldeto2_fil.comdat = "000000" THEN DO:*/
                                            ELSE DO:
                                                nv_ncompcnt = nv_ncompcnt + 1. /* record not found count */
                                    
                                                ASSIGN
                                                    aycldeto2_fil.remark = "ปีที่คุ้มครองไม่ตรง" 
                                                    SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm301.policy. /*Lukkana M. A55-0244 01/08/2012*/
                            
                                            END.
                                        END. /*--if sicuw.uwm301.trareg = aycldeto2_fil.cha_no--*/
                                        ELSE DO: /*เลขตัวถังรถไม่ตรงกัน*/
                                            nv_ncompcnt = nv_ncompcnt + 1. /* record not found count */
                        
                                            ASSIGN
                                                aycldeto2_fil.remark = "Not Found Policy permitt Chassis " + aycldeto2_fil.cha_no
                                                SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm301.policy. /*Lukkana M. A55-0244 01/08/2012*/
                                            /* comment by : Ranu I. A65-0115...
                                            /*--Lukkana M. A53-0135 31/03/2010--*/
                                            ASSIGN
                                                nv_si_n      = INTE(aycldeto2_fil.si)
                                                nv_prem_n    = INTE(aycldeto2_fil.prem)
                                                nv_prem_taxstm = INTE(aycldeto2_fil.premtax) /*A58-0121*/
                                                nv_premtot_n = INTE(aycldeto2_fil.premtot).
                                            ASSIGN
                                                aycldeto2_fil.si      = TRIM(REPLACE(STRING(nv_si_n,">>>>>>>>>>>>9.99"),".",""))
                                                aycldeto2_fil.prem    = TRIM(REPLACE(STRING(nv_prem_n,">>>>>>>>>>>>9.99"),".",""))
                                                aycldeto2_fil.premtax = TRIM(REPLACE(STRING(nv_prem_taxstm,">>>>>>>>>>>>9.99"),".","")) /*A58-0121*/
                                                aycldeto2_fil.insrayrno = "การประกันภัยรถยนต์(ภาคสมัครใจ)"  /*A58-0121*/
                                                aycldeto2_fil.premtot = TRIM(REPLACE(STRING(nv_premtot_n,">>>>>>>>>>>>9.99"),".","")).
                                            /*--Lukkana M. A53-0135 31/03/2010--*/
                                            ...end : A65-0115...*/
                
                                        END.
                                    END.    /*--if avail sicuw.uwm301--*/
                                END. /*--if avail sicuw.uwm100--*/
                                ELSE DO: /*uwm100.releas = no*/
                                    nv_ncompcnt = nv_ncompcnt + 1. /* record not found count */
                                    ASSIGN
                                        aycldeto2_fil.remark = "Policy Not Release" 
                                        SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm301.policy. /*Lukkana M. A55-0244 01/08/2012*/
                                    /* comment by : Ranu I. A65-0115...
                                    /*--Lukkana M. A53-0135 31/03/2010--*/
                                    ASSIGN
                                        nv_si_n      = INTE(aycldeto2_fil.si)
                                        nv_prem_n    = INTE(aycldeto2_fil.prem)
                                        nv_prem_taxstm = INTE(aycldeto2_fil.premtax) /*A58-0121*/
                                        nv_premtot_n = INTE(aycldeto2_fil.premtot).
                                    ASSIGN
                                        aycldeto2_fil.si      = TRIM(REPLACE(STRING(nv_si_n,">>>>>>>>>>>>9.99"),".",""))
                                        aycldeto2_fil.prem    = TRIM(REPLACE(STRING(nv_prem_n,">>>>>>>>>>>>9.99"),".",""))
                                        aycldeto2_fil.premtax = TRIM(REPLACE(STRING(nv_prem_taxstm,">>>>>>>>>>>>9.99"),".","")) /*A58-0121*/
                                        aycldeto2_fil.insrayrno = "การประกันภัยรถยนต์(ภาคสมัครใจ)"  /*A58-0121*/
                                        aycldeto2_fil.premtot = TRIM(REPLACE(STRING(nv_premtot_n,">>>>>>>>>>>>9.99"),".","")).
                                    /*--Lukkana M. A53-0135 31/03/2010--*/
                                    ...end : A65-0115...*/
                
                                END.
                            END. /*--else do (if not avail uwm100)--*/
                        END. /*IF nv_acno <> "" THEN DO: ถ้าชื่อ-นามสกุล ไม่เป็นค่าว่าง ให้เช็คว่าตรงกันหรือไม่*/

                    END. /*IF sicuw.uwm301.trareg <> ""  THEN DO:*/
                   
                END. /*if avail uwm301*/
                ELSE DO:
                    nv_ncompcnt = nv_ncompcnt + 1. /* record not found count */
                    
                    ASSIGN
                        aycldeto2_fil.remark = "Not Found Policy permitt Chassis " + aycldeto2_fil.cha_no.

                    /*--Lukkana M. A55-0244 03/08/2012--*/
                    FIND LAST sicuw.uwm301 USE-INDEX uwm30103                       WHERE
                              sicuw.uwm301.trareg             = aycldeto2_fil.cha_no AND 
                              SUBSTR(sicuw.uwm301.policy,3,2) = "70"                NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAIL sicuw.uwm301 THEN DO:
                        SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm301.policy.  
                    END.
                    ELSE DO:
                        /* comment by : Ranu I. A65-0115 ...
                        FIND LAST sicuw.uwm100 USE-INDEX uwm10001                       WHERE
                                /*sicuw.uwm100.policy             = aycldeto2_fil.notify AND *//*a56-0119*/
                                  sicuw.uwm100.policy             = nv_policyno         AND     /*a56-0119*/
                                 SUBSTR(sicuw.uwm301.policy,3,2) = "70"                NO-LOCK NO-ERROR NO-WAIT.
                        IF AVAIL sicuw.uwm301 THEN SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm100.policy.
                        ..end A65-0115...*/
                        /* add by : Ranu I. A65-0115  */
                        FIND LAST sicuw.uwm100 USE-INDEX uwm10001                      WHERE
                                 sicuw.uwm100.policy             = nv_policyno         AND     
                                 SUBSTR(sicuw.uwm100.policy,3,2) = "70"                NO-LOCK NO-ERROR NO-WAIT.
                        IF AVAIL sicuw.uwm100 THEN SUBSTR(aycldeto2_fil.remark,100,12) = sicuw.uwm100.policy.
                        /*..end A65-0115...*/
                    END.
                    /*--Lukkana M. A55-0244 03/08/2012--*/
                    /* comment by : Ranu I. A65-0115...
                    /*--Lukkana M. A53-0135 31/03/2010--*/
                    ASSIGN
                        nv_si_n      = INTE(aycldeto2_fil.si)
                        nv_prem_n    = INTE(aycldeto2_fil.prem)
                        nv_prem_taxstm = INTE(aycldeto2_fil.premtax) /*A58-0121*/
                        nv_premtot_n = INTE(aycldeto2_fil.premtot).
                    
                    ASSIGN
                        aycldeto2_fil.si      = TRIM(REPLACE(STRING(nv_si_n,">>>>>>>>>>>>9.99"),".",""))
                        aycldeto2_fil.prem    = TRIM(REPLACE(STRING(nv_prem_n,">>>>>>>>>>>>9.99"),".",""))
                        aycldeto2_fil.premtax = TRIM(REPLACE(STRING(nv_prem_taxstm,">>>>>>>>>>>>9.99"),".","")) /*A58-0121*/
                        aycldeto2_fil.insrayrno = "การประกันภัยรถยนต์(ภาคสมัครใจ)"  /*A58-0121*/
                        aycldeto2_fil.premtot = TRIM(REPLACE(STRING(nv_premtot_n,">>>>>>>>>>>>9.99"),".","")).
                    /*--Lukkana M. A53-0135 31/03/2010--*/
                    ...end A65-0115...*/
                END.
                
            END. /*else do*/
            /*--Lukkana M. A53-0161 13/05/2010--*/

        END.
        /*---- Lukkana M. A52-0136 24/06/2009 -----*/
    END. /* FOR EACH aycldeto2_fil */
    RELEASE aycldeto2_fil.
  END. /*if nv_outagent = ""*/


  
