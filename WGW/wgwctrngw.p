/************************************************************************/
/*CONNECT  gw_safe -ld sic_bran, sicuw,siccl,stat*/
/* wgwctrngw.p   Check data trans to gw              		           */
/* Create By   : Songkran P. Date 01/06/2022 A65-0141                  */
/*---------------------------------------------------------------------*/
DEF INPUT  PARAMETER nv_recbrn AS RECID.
DEF OUTPUT PARAMETER n_camcod  AS CHAR INIT "".
DEF OUTPUT PARAMETER n_err     AS CHAR INIT "".

DEFINE var  RsStatus  AS CHARACTER NO-UNDO.
DEFINE var  RsMessage AS CHARACTER NO-UNDO.
DEFINE var  poltyp AS CHARACTER NO-UNDO.
DEFINE var  nv_policy AS CHARACTER NO-UNDO.
DEF TEMP-TABLE Wuwm301 NO-UNDO
  FIELD policy      AS CHARACTER  
  FIELD rencnt      AS INTEGER    
  FIELD endcnt      AS INTEGER    
  FIELD riskno      AS INTEGER    
  FIELD itemno      AS INTEGER    
  FIELD vehreg      AS CHARACTER  
  FIELD cha_no      AS CHARACTER  .



FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = nv_recbrn NO-LOCK NO-ERROR.
IF AVAILA sic_bran.uwm100 THEN DO:
    FIND sic_bran.uwm120 USE-INDEX uwm12001 WHERE 
        sic_bran.uwm120.policy = sic_bran.uwm100.policy AND
        sic_bran.uwm120.rencnt = sic_bran.uwm100.rencnt AND
        sic_bran.uwm120.endcnt = sic_bran.uwm100.endcnt NO-LOCK NO-ERROR.
    IF AVAILA sic_bran.uwm120 THEN DO:

        poltyp = SUBSTRING(sic_bran.uwm100.policy,1,1).
        
        IF sic_Bran.uwm100.prog <> "WRSGU100OS.P"  AND 
            sic_Bran.uwm100.prog <> "WRSGU10ROS.P" AND 
            sic_Bran.uwm100.prog <> "WRSUZO7201OS.P"  THEN DO:

            IF poltyp = "Q" THEN RUN chk_camp.
        END.

        IF n_err = "" THEN RUN pd_clm.
        
    END.
END.

PROCEDURE chk_camp.
    /* ไม่ทำการระบุ Campaign Code มา */

    DEF VAR nv_fptr AS RECID .
    ASSIGN 
        n_camcod = ""
        nv_fptr = sic_bran.uwm100.fptr02 .


    IF TRIM(uwm100.cr_1) <> "" THEN DO:

        FIND FIRST stat.campaign_fil USE-INDEX campfil01 WHERE stat.campaign_fil.camcod = TRIM(uwm100.cr_1) NO-LOCK NO-ERROR.
        IF NOT AVAIL stat.campaign_fil THEN DO: 

            n_err = "ระบุ Campaign Code ไม่ตรงกับในระบบ".

            DO WHILE nv_fptr <> 0 AND sic_bran.uwm100.fptr02 <> ? :
                FIND sic_bran.uwd102 WHERE RECID(sic_bran.uwd102) = nv_fptr NO-LOCK NO-ERROR.
                IF AVAILABLE sic_bran.uwd102 THEN DO: 
                    IF INDEX(sic_bran.uwd102.ltext,"Campaign") <> 0 THEN DO:
                        n_camcod = TRIM(ENTRY(2,sic_bran.uwd102.ltext,":")).
                        LEAVE.
                    END.
                    nv_fptr = sic_bran.uwd102.fptr.
                END.
                ELSE LEAVE.
            END.
        
            IF n_camcod <> "" THEN DO:
                /* 3.ระบุ Campaign Code ไม่ตรงกับในระบบ */
                FIND FIRST stat.campaign_fil USE-INDEX campfil01 WHERE stat.campaign_fil.camcod = n_camcod NO-LOCK NO-ERROR.
                IF NOT AVAIL stat.campaign_fil THEN DO: 
                    n_err = "ระบุ Campaign Code ไม่ตรงกับในระบบ".
                END.
            END.
            ELSE n_err = "ไม่ทำการระบุ Campaign Code".

        END.
    END.
    ELSE DO:

        DO WHILE nv_fptr <> 0 AND sic_bran.uwm100.fptr02 <> ? :
            FIND sic_bran.uwd102 WHERE RECID(sic_bran.uwd102) = nv_fptr NO-LOCK NO-ERROR.
            IF AVAILABLE sic_bran.uwd102 THEN DO: 
                IF INDEX(sic_bran.uwd102.ltext,"Campaign") <> 0 THEN DO:
                    n_camcod = TRIM(ENTRY(2,sic_bran.uwd102.ltext,":")).
                    LEAVE.
                END.
                nv_fptr = sic_bran.uwd102.fptr.
            END.
            ELSE LEAVE.
        END.
    
        IF n_camcod <> "" THEN DO:
            /* 3.ระบุ Campaign Code ไม่ตรงกับในระบบ */
            FIND FIRST stat.campaign_fil USE-INDEX campfil01 WHERE stat.campaign_fil.camcod = n_camcod NO-LOCK NO-ERROR.
            IF NOT AVAIL stat.campaign_fil THEN DO: 
                n_err = "ระบุ Campaign Code ไม่ตรงกับในระบบ".
            END.
        END.
        ELSE n_err = "ไม่ทำการระบุ Campaign Code".

    END.

    
END PROCEDURE.

PROCEDURE pd_checkpolicytype.

    DEF INPUT PARAMETER n_cha_no AS CHAR INIT "".
    
    DEF VAR nv_expidate AS DATE INIT ?.
    nv_policy = "".
    FOR EACH sicuw.uwm301 USE-INDEX uwm30121 WHERE
                  sicuw.uwm301.cha_no = n_cha_no NO-LOCK:
        
        FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE sicuw.uwm100.policy = sicuw.uwm301.policy AND
                                                        sicuw.uwm100.poltyp = "V70"               NO-LOCK NO-ERROR.
        IF AVAILA sicuw.uwm100 THEN DO:
            IF nv_expidate = ? THEN DO: 
                nv_expidate = sicuw.uwm100.expdat.
                nv_policy = sicuw.uwm100.policy.
            END.
            IF sicuw.uwm100.expdat > nv_expidate THEN DO: 
                nv_expidate = sicuw.uwm100.expdat.
                nv_policy = sicuw.uwm100.policy.
            END.
            
        END.
        
    END.
    
    IF nv_policy = "" THEN n_err = "Transfer to Premium with Create Inspection".
    ELSE n_err = "CheckClaim".
   
END PROCEDURE.

PROCEDURE pd_clm.
    EMPTY TEMP-TABLE Wuwm301.
    DEF VAR n_pol      AS CHAR INIT "".
    DEF VAR n_clm      AS CHAR INIT "".
    DEF VAR n_trn      AS DATE INIT ?.
    DEF VAR nv_clm131  LIKE siccl.clm130.netl_d.
    DEF VAR nv_paid    LIKE siccl.clm130.netl_d.
    DEF VAR nv_os      LIKE siccl.clm130.netl_d.
    DEF VAR nv_loss    LIKE siccl.clm130.netl_d.
    DEF VAR nv_netprm  LIKE sicuw.uwd132.gap_c.
    DEF VAR nv_lr1    AS DECI.
    DEF VAR nv_lr2    AS INT INIT 0.
    DEF VAR n_day AS INTE.
    DEF VAR n_day2 AS INTE.
    DEF VAR n_stcha AS CHAR.

    FIND LAST sic_bran.uwm301 USE-INDEX uwm30101 WHERE
              sic_bran.uwm301.policy = sic_bran.uwm120.policy AND 
              sic_bran.uwm301.rencnt = sic_bran.uwm120.rencnt AND
              sic_bran.uwm301.endcnt = sic_bran.uwm120.endcnt AND
              sic_bran.uwm301.riskgp = sic_bran.uwm120.riskgp AND
              sic_bran.uwm301.riskno = sic_bran.uwm120.riskno NO-LOCK NO-ERROR.
    IF AVAILA sic_bran.uwm301 THEN DO:

        /*
        IF sic_bran.uwm301.covcod = "2.1" OR 
            sic_bran.uwm301.covcod = "3.1" THEN DO:
            n_err = "Transfer to Premium".
            RETURN.
        END.
        */

        /*---- find chano type V70 ----*/
        FIND LAST sicuw.uwm301 USE-INDEX uwm30121 WHERE
                  sicuw.uwm301.cha_no = TRIM(sic_bran.uwm301.cha_no) NO-LOCK NO-ERROR.
        IF NOT AVAILA sicuw.uwm301 THEN DO:
            n_err = "Transfer to Premium with Create Inspection".
        END.
        ELSE RUN pd_checkpolicytype(INPUT TRIM(sic_bran.uwm301.cha_no)).
        
        /*---- find chano ----*/
  
        IF n_err = "CheckClaim" THEN DO:

            FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE 
                  sicuw.uwm100.policy = nv_policy NO-LOCK NO-ERROR.
            IF AVAILA sicuw.uwm100 THEN DO:
                ASSIGN
                    n_trn = sicuw.uwm100.trndat
                    n_pol = sicuw.uwm100.policy.
            
                n_day = DATE(12,31,YEAR(TODAY)) - DATE(1,1,YEAR(TODAY)) + 1.
                n_day2 = TODAY - sicuw.uwm100.expdat.

            END.
            
            IF n_pol <> "" THEN DO:
                FOR EACH sicuw.uwm301 USE-INDEX uwm30101 NO-LOCK WHERE  
                    sicuw.uwm301.policy = n_pol BREAK BY sicuw.uwm301.endcnt BY sicuw.uwm301.riskno BY sicuw.uwm301.itemno:
                    
                    IF sicuw.uwm301.vehreg = sic_bran.uwm301.vehreg THEN DO:
                      FIND FIRST  Wuwm301 WHERE
                                  Wuwm301.policy  = sicuw.uwm301.policy  AND
                                  Wuwm301.cha_no  = sicuw.uwm301.cha_no  AND    /* Tunyaporn K. Date 12/11/2015*/
                                  Wuwm301.vehreg  = sicuw.uwm301.vehreg  NO-ERROR NO-WAIT.
                      IF NOT AVAILABLE Wuwm301 THEN CREATE Wuwm301.
                      ASSIGN Wuwm301.policy  = sicuw.uwm301.policy
                             Wuwm301.rencnt  = sicuw.uwm301.rencnt
                             Wuwm301.endcnt  = sicuw.uwm301.endcnt
                             Wuwm301.riskno  = sicuw.uwm301.riskno
                             Wuwm301.itemno  = sicuw.uwm301.itemno
                             Wuwm301.vehreg  = sicuw.uwm301.vehreg         /* Vehicle No.*/
                             Wuwm301.cha_no  = sicuw.uwm301.cha_no.        /* Chassis No.*/
                    END.
                    ELSE DO:        /* หา โดยใช้ เลขตัวถัง */
                        IF sicuw.uwm301.cha_no = sic_bran.uwm301.cha_no THEN DO:
                          FIND FIRST  Wuwm301 WHERE
                                      Wuwm301.policy  = sicuw.uwm301.policy  AND
                                      Wuwm301.cha_no  = sicuw.uwm301.cha_no  AND    /* Tunyaporn K. Date 12/11/2015*/
                                      Wuwm301.vehreg  = sicuw.uwm301.vehreg  NO-ERROR NO-WAIT.
                          IF NOT AVAILABLE Wuwm301 THEN  CREATE Wuwm301.
                          ASSIGN Wuwm301.policy  = sicuw.uwm301.policy
                                 Wuwm301.rencnt  = sicuw.uwm301.rencnt
                                 Wuwm301.endcnt  = sicuw.uwm301.endcnt
                                 Wuwm301.riskno  = sicuw.uwm301.riskno
                                 Wuwm301.itemno  = sicuw.uwm301.itemno
                                 Wuwm301.vehreg  = sicuw.uwm301.vehreg         /* Vehicle No.*/
                                 Wuwm301.cha_no  = sicuw.uwm301.cha_no.        /* Chassis No.*/
                        END.
                    END.
                END.
                
                FOR EACH wuwm301 NO-LOCK:
                    FOR EACH siccl.clm100 USE-INDEX clm10007  NO-LOCK      WHERE
                             siccl.clm100.vehves  =  wuwm301.vehreg        AND
                             siccl.clm100.policy  =  wuwm301.policy        AND
                             siccl.clm100.notdat  <= n_trn
                    BREAK BY siccl.clm100.claim :
            
                        ASSIGN nv_clm131 = 0.
             
                        FOR EACH siccl.clm120 USE-INDEX clm12001 WHERE
                                 siccl.clm120.claim  = siccl.clm100.claim  NO-LOCK:
            
                            FOR EACH siccl.clm131 USE-INDEX clm13101           WHERE
                                     siccl.clm131.claim  = siccl.clm120.claim  AND
                                     siccl.clm131.clmant = siccl.clm120.clmant AND
                                     siccl.clm131.clitem = siccl.clm120.clitem AND
                                     siccl.clm131.cpc_cd = 'EPD'               NO-LOCK:
                                IF siccl.clm131.res <> 0 AND 
                                   siccl.clm131.res <> ? THEN nv_clm131 = nv_clm131 + siccl.clm131.res.
                            END.
                            /* a62-0361 หายอด paid  คำนวณ Loss ratio */
                            FOR EACH siccl.clm130 USE-INDEX clm13002      WHERE
                                siccl.clm130.claim  = siccl.clm120.claim   AND
                                siccl.clm130.clmant = siccl.clm120.clmant  AND
                                siccl.clm130.clitem = siccl.clm120.clitem  AND
                                siccl.clm130.cpc_cd = "EPD"            NO-LOCK:
                       
                                IF clm130.netl_d <> ? THEN
                                    nv_paid  = nv_paid + siccl.clm130.netl_d.
                            END.
            
                            IF clm100.padsts = "X" OR clm100.padsts = "F" OR clm100.padsts = "R" THEN DO:
                                ASSIGN 
                                    nv_os  = 0 
                                    nv_clm131 = nv_paid.
                            END.
                            ELSE nv_os =  nv_clm131 - nv_paid .
                        END. /*siccl.clm120.policy */
            
                        IF siccl.clm100.defau <> "TP" THEN DO:   /*- Check tp -*/
                            IF nv_os <> 0 OR nv_paid <> 0 THEN nv_loss = nv_os + nv_paid.
                        END.
                    END.         /* for each clm100 */
            
                    FOR EACH sicuw.uwd132  USE-INDEX uwd13290  WHERE
                         sicuw.uwd132.policy  = wuwm301.policy  AND
                         sicuw.uwd132.riskno  = wuwm301.riskno  AND
                         sicuw.uwd132.itemno  = wuwm301.itemno  NO-LOCK:
                            nv_netprm = nv_netprm + sicuw.uwd132.gap_c.
                    END.
            
                    ASSIGN  
                        nv_lr1  = ( nv_loss / nv_netprm ) * 100 
                        nv_lr2  = TRUNCATE(nv_lr1,0).
                    IF (nv_lr1 - nv_lr2) > 0 THEN nv_lr2 = nv_lr2 + 1.
                    
                    IF nv_lr2 > 200 THEN DO: 
                        n_clm = STRING(nv_lr2).
                        /* 4.หากพบข้อมูลกรมธรรม์ในฐานข้อมูล และมีการเคลมสูง  งาน R ขอค่า L/R เกินกว่า 200% ไม่ต้อง transfer to premium*/
                        n_err = "พบข้อมูลกรมธรรม์ในฐานข้อมูล และมีการเคลม " + n_clm + "% > 200%".
                    END.
                    ELSE DO:
                        IF n_day2 <= 0 THEN DO:
                           /* 5.หากพบข้อมูลกรมธรรม์ในฐานข้อมูล ไม่พบว่ามีการเคลมสูงและไม่มีการขาดต่อกรมธรรม์ ,ไม่มีเคลมหลังใบเตือน */   
                           /*
                           FIND LAST sic_exp.uwm100 USE-INDEX uwm10001 WHERE sic_exp.uwm100.policy  = wuwm301.policy NO-LOCK NO-ERROR.
                           IF AVAILA sic_exp.uwm100 THEN DO:
                               FOR EACH siccl.clm100 USE-INDEX clm10007  NO-LOCK      WHERE
                                    siccl.clm100.vehves  =  wuwm301.vehreg            AND
                                    siccl.clm100.policy  =  wuwm301.policy            AND
                                    siccl.clm100.entdat  >= sic_exp.uwm100.trndat     BREAK BY siccl.clm100.claim :
            
                                   IF SUBSTRING(siccl.clm100.claim,1,1) <> "N" OR 
                                       SUBSTRING(siccl.clm100.claim,1,1) <> "Z" THEN DO:
            
                                       n_err = "มีเคลมหลังใบเตือน".
            
                                   END.
                               END.
                           END.
                            */
                           RUN wgw\wgwckclws(INPUT  Wuwm301.policy
                                            ,INPUT  Wuwm301.vehreg 
                                            ,INPUT  Wuwm301.cha_no 
                                            ,OUTPUT RsStatus
                                            ,OUTPUT n_err).
            
                             IF RsStatus = "success"  THEN n_err = "Transfer to Premium".
                             ELSE DO: 
                                 IF RsStatus = "fail" AND INDEX(n_err,"พบเคลม") = 0 THEN n_err = "Transfer to Premium".
                                 ELSE IF RsStatus = "" THEN n_err = "Transfer to Premium".
                             END.
                        END.
                        ELSE IF n_day2 < 7 THEN DO:
                           /* 8. */
                            /*
                            RUN wgw\wgwchcvws(INPUT Wuwm301.policy ,OUTPUT n_err).
                            IF n_err = "Hold Coverage" THEN  n_err = "Transfer to Premium".
                            ELSE n_err = "พบข้อมูลกรมธรรม์ในฐานข้อมูล ไม่พบว่ามีการเคลมสูง แต่มีการขาดต่อกรมธรรม์ตั้งแต่ 1 วัน ".
                                 */
                            //n_err = "พบข้อมูลกรมธรรม์ในฐานข้อมูล ไม่พบว่ามีการเคลมสูง แต่มีการขาดต่อกรมธรรม์ตั้งแต่ 1 วัน แต่ไม่เกิน 7 วัน".
                            n_err = "Transfer to Premium with Create Inspection".
                        END.
                        ELSE IF n_day2 < n_day THEN DO: 
                            /* 7.หากเป็นงาน Q พบข้อมูลกรมธรรม์ในฐานข้อมูล ไม่พบว่ามีการเคลมสูง และมีการขาดต่อกรมธรรม์ไม่เกิน 1 ปี (โอนงาน) */
                            n_err = "พบข้อมูลกรมธรรม์ในฐานข้อมูล ไม่พบว่ามีการเคลมสูง และมีการขาดต่อกรมธรรม์ไม่เกิน 1 ปี".
                        END.
                        ELSE IF n_day2 > n_day THEN DO:
                            /* 6.หากเป็นงาน Q พบข้อมูลกรมธรรม์ในฐานข้อมูล ไม่พบว่ามีการเคลมสูง และมีการขาดต่อกรมธรรม์เกิน 1 ปี */
                             //n_err = "พบข้อมูลกรมธรรม์ในฐานข้อมูล ไม่พบว่ามีการเคลมสูง และมีการขาดต่อกรมธรรม์เกิน 1 ปี".
                             n_err = "Transfer to Premium with Create Inspection".
                        END.
                    END.
                    IF sic_bran.uwm301.covcod = "2.1" OR 
                        sic_bran.uwm301.covcod = "3.1" THEN DO:
                        /* เข้า Premium ทั้งหมด และ Auto Release (ออกกธ.ให้ลูกค้าที่หน้าเวปไปแล้ว มาโอนงานตามทีหลัง */
                        n_err = "Transfer to Premium".
                    END.
                END.
            END.
        END.
    END.
END PROCEDURE.
