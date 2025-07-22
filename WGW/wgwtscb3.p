/* wgwtbex1.P  -- Load Text file tib [Tisco]to gw                                                    */
/* Copyright   # Safety Insurance Public Company Limited                    */  
/*               บริษัท ประกันคุ้มภัย จำกัด (มหาชน)                         */  
/*programid    : wgwtscb1.w                                                 */
/* WRITE  BY   : Kridtiya i. A56-0222 date . 27/06/2013                     */  
/*             : ส่วนการค้นหาค่า งานต่ออายุเพื่อให้ค่า กรมธรรม์ต่ออายุใหม่  */  
/*programname  : load text file SCB to GW                                   */
/*Modify by    : Kridtiya i. A64-0137 เพิ่มส่วนการ เช็คเบี้ยต่ออายุ ว่าตรงกับไฟล์แจ้งงานหรือไม่*/
/* ------------------------------------------------------------------------ */
DEFINE INPUT-OUTPUT  PARAMETER  np_prepol      AS CHAR FORMAT "x(20)"   INIT "".         
DEFINE INPUT-OUTPUT  PARAMETER  np_premiumexp  AS DECI INIT 0.   
DEFINE INPUT-OUTPUT  PARAMETER  nv_premium     AS DECI INIT 0. 
DEFINE INPUT-OUTPUT  PARAMETER  np_dealer      AS CHAR FORMAT "x(20)"   INIT "".   
DEFINE VAR n_stamp    AS DECI.
DEFINE VAR n_vat      AS DECI.
 
ASSIGN
    n_stamp       = 0
    n_vat         = 0
    nv_premium    = 0
    np_premiumexp = 0
    np_dealer     = "".
FIND LAST sic_exp.uwm100  WHERE sic_exp.uwm100.policy = trim(np_prepol)   NO-LOCK NO-ERROR NO-WAIT.
IF AVAILABLE sic_exp.uwm100 THEN DO:
     np_dealer = sic_exp.uwm100.finint . 
    FIND LAST sic_exp.uwm301 USE-INDEX uwm30101        WHERE
        sic_exp.uwm301.policy = sic_exp.uwm100.policy  AND
        sic_exp.uwm301.rencnt = sic_exp.uwm100.rencnt  AND
        sic_exp.uwm301.endcnt = sic_exp.uwm100.endcnt  NO-LOCK NO-ERROR NO-WAIT.  
    IF AVAIL sic_exp.uwm301 THEN DO:
        FOR EACH sic_exp.uwd132 USE-INDEX uwd13290  WHERE
            sic_exp.uwd132.policy   = sic_exp.uwm301.policy  AND
            sic_exp.uwd132.rencnt   = sic_exp.uwm301.rencnt  AND
            sic_exp.uwd132.endcnt   = sic_exp.uwm301.endcnt  AND
            sic_exp.uwd132.riskno   = sic_exp.uwm301.riskno  AND
            sic_exp.uwd132.itemno   = sic_exp.uwm301.itemno  NO-LOCK .
            IF sic_exp.uwd132.bencod <> "comp" THEN  nv_premium    = nv_premium + sic_exp.uwd132.prem_c.
        END.
    END.
END. 
IF nv_premium <> 0 THEN DO:
    IF ( nv_premium * 0.004 ) - (TRUNCATE ( nv_premium * 0.004 ,0 )) > 0 THEN 
         n_stamp   = ( TRUNCATE(( nv_premium * 0.004 ),0)) + 1 .
    ELSE n_stamp   = TRUNCATE(( nv_premium * 0.004 ),0).
    n_vat     = TRUNCATE((( nv_premium + n_stamp ) * 0.07),2).
END.
ASSIGN np_premiumexp = nv_premium + n_stamp    +    n_vat        .

     
                      
