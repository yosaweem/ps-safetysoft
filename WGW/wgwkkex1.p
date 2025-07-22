/* program id   : wgwkkex1.p  -- Load Text file kk [renew]to gw               */
/* Copyright   # Safety Insurance Public Company Limited                                        */
/*               บริษัท ประกันคุ้มภัย จำกัด (มหาชน)                                             */
/* create by   : Kridtiya i.A54-0351  07/12/2011                                                */
/*             : ส่วนการค้นหาค่า งานต่ออายุเพื่อให้ค่า กรมธรรม์ต่ออายุใหม่                      */
/* Modify by   : Kridtiya i. A55-0008 date. 06/01/2012 ปิดส่วนการเช็คทะเบียนรถ                  */
/* Modify by   : Kridtiya i. A55-0114 date. 26/03/2012 ปรับให้รับค่า เทคข้อความจากกรมธรรม์เดิม  */
/* Modify by   : Ranu I. A64-0138 เพิ่มตัวแปรเก็บค่าการคำนวณเบี้ย */
/* -------------------------------------------------------------------------------------------- */

DEFINE INPUT-OUTPUT  PARAMETER n_prepol     AS CHAR FORMAT "x(12)" INIT "".    /*wdetail.prepol   */         
DEFINE INPUT-OUTPUT  PARAMETER n_branch     AS CHAR FORMAT "x(2)"  INIT "".    /*wdetail2.branch  */     
DEFINE INPUT-OUTPUT  PARAMETER n_producer   AS CHAR FORMAT "x(12)" INIT "".    /*wdetail2.prempa  */     
DEFINE INPUT-OUTPUT  PARAMETER n_agent      AS CHAR FORMAT "x(12)" INIT "".    /*wdetail2.prempa  */     
DEFINE INPUT-OUTPUT  PARAMETER n_firstdat   AS CHAR FORMAT "99/99/9999". 
DEFINE INPUT-OUTPUT  PARAMETER n_prempa     AS CHAR FORMAT "x"     INIT "".    /*wdetail2.prempa  */     
DEFINE INPUT-OUTPUT  PARAMETER n_subclass   AS CHAR FORMAT "x(3)"  INIT "".    /*wdetail2.subclass*/   
DEFINE INPUT-OUTPUT  PARAMETER n_redbook    AS CHAR FORMAT "x(10)" INIT "".    /*wdetail2.redbook */      
DEFINE INPUT-OUTPUT  PARAMETER n_brand      AS CHAR FORMAT "x(30)" INIT "".    /*wdetail.         */          
DEFINE INPUT-OUTPUT  PARAMETER n_model      AS CHAR FORMAT "x(40)" INIT "".    /*wdetail.model    */          
DEFINE INPUT-OUTPUT  PARAMETER n_caryear    AS CHAR FORMAT "x(4)"  INIT "".    /*wdetail.caryear  */        
DEFINE INPUT-OUTPUT  PARAMETER n_cargrp     AS CHAR FORMAT "x(2)"  INIT "".    /*wdetail.cargrp   */         
DEFINE INPUT-OUTPUT  PARAMETER n_bodys      AS CHAR FORMAT "x(20)" INIT "".    /*wdetail.cargrp   */         
DEFINE INPUT-OUTPUT  PARAMETER n_engcc      AS CHAR FORMAT "x(10)" INIT "".    /*wdetail.cargrp   */         
DEFINE INPUT-OUTPUT  PARAMETER n_tonns      AS CHAR FORMAT "x(10)" INIT "".    /*wdetail.cargrp   */         
DEFINE INPUT-OUTPUT  PARAMETER n_seat       AS INTE INIT 0.       
DEFINE INPUT-OUTPUT  PARAMETER n_vehuse     AS CHAR FORMAT "x(2)"  INIT "".    /*wdetail.vehuse   */         
DEFINE INPUT-OUTPUT  PARAMETER n_covcod     AS CHAR FORMAT "x(30)" INIT "".    /*wdetail.covcod   */      
DEFINE INPUT-OUTPUT  PARAMETER n_garage     AS CHAR FORMAT "x"     INIT "".            
DEFINE INPUT-OUTPUT  PARAMETER n_tp1        AS CHAR FORMAT "x(30)" INIT "".    /*wdetail.chasno   */         
DEFINE INPUT-OUTPUT  PARAMETER n_tp2        AS CHAR FORMAT "x(30)" INIT "".    /*wdetail.chasno   */         
DEFINE INPUT-OUTPUT  PARAMETER n_tp3        AS CHAR FORMAT "x(30)" INIT "".    /*wdetail.chasno   */         
DEFINE INPUT-OUTPUT  PARAMETER nv_basere    AS DECI INIT 0.                    /*nv_basere        */                   
DEFINE INPUT-OUTPUT  PARAMETER nv_seat41    AS INTE INIT 0.                    /*wdetail.seat     */           
DEFINE INPUT-OUTPUT  PARAMETER n_41         AS DECI INIT 0.                    /*n_41             */                  
DEFINE INPUT-OUTPUT  PARAMETER n_42         AS DECI INIT 0.                    /*n_42             */                   
DEFINE INPUT-OUTPUT  PARAMETER n_43         AS DECI INIT 0.                    /*n_43             */                  
DEFINE INPUT-OUTPUT  PARAMETER n_dod        AS DECI INIT 0.                    /*n_41             */                  
DEFINE INPUT-OUTPUT  PARAMETER n_dod2       AS DECI INIT 0.                    /*n_42             */                   
DEFINE INPUT-OUTPUT  PARAMETER n_pd         AS DECI INIT 0.                    /*n_43             */                  
DEFINE INPUT-OUTPUT  PARAMETER n_feet       AS DECI INIT 0.                    /*n_41             */                  
DEFINE INPUT-OUTPUT  PARAMETER n_ncb        AS DECI INIT 0.                    /*nv_dss_per       */             
DEFINE INPUT-OUTPUT  PARAMETER nv_dss_per   AS DECI INIT 0.                    /*n_42             */                   
DEFINE INPUT-OUTPUT  PARAMETER n_lcd        AS DECI INIT 0.                    /*n_43             */ 
DEFINE INPUT-OUTPUT  PARAMETER n_prmtxt     AS CHAR INIT "".  /*A55-0114*/
DEFINE INPUT         PARAMETER n_sumins     AS CHAR INIT "". 
DEFINE INPUT         PARAMETER n_vehreg     AS CHAR INIT "". 
DEFINE INPUT-OUTPUT  PARAMETER n_premt      AS DECI FORMAT ">>>,>>>,>>9.99". /*A64-0138*/
/*comment by kridtiya i. A54-0008....
DEFINE VAR   n_sumins1     AS DECI INIT 0. 
DEFINE VAR   n_vehreg1     AS CHAR INIT "". 
end...comment by kridtiya i. A54-0008..*/

FIND LAST sic_exp.uwm100  WHERE sic_exp.uwm100.policy = n_prepol NO-LOCK NO-ERROR NO-WAIT.
IF AVAILABLE sic_exp.uwm100 THEN DO:
    ASSIGN n_branch = sic_exp.uwm100.branch
        n_producer  = sic_exp.uwm100.acno1
        n_agent     = sic_exp.uwm100.agent
        n_firstdat  = string(sic_exp.uwm100.fstdat).
    FIND LAST sic_exp.uwm130 USE-INDEX uwm13001 WHERE
        sic_exp.uwm130.policy = sic_exp.uwm100.policy AND
        sic_exp.uwm130.rencnt = sic_exp.uwm100.rencnt AND
        sic_exp.uwm130.endcnt = sic_exp.uwm100.endcnt NO-LOCK NO-ERROR NO-WAIT.
    IF  AVAILABLE uwm130 THEN 
        ASSIGN n_tp1 = string(sic_exp.uwm130.uom1_v)  
               n_tp2 = string(sic_exp.uwm130.uom2_v)  
               n_tp3 = string(sic_exp.uwm130.uom5_v) 
               /*n_sumins1 = IF sic_exp.uwm130.uom6_v = 0 THEN sic_exp.uwm130.uom7_v ELSE sic_exp.uwm130.uom6_v *//*A55-0008*/
                    .
    FIND FIRST  sic_exp.uwm120 USE-INDEX uwm12001    WHERE
    sic_exp.uwm120.policy  = sic_exp.uwm100.policy   AND
    sic_exp.uwm120.rencnt  = sic_exp.uwm100.rencnt   AND
    sic_exp.uwm120.endcnt  = sic_exp.uwm100.endcnt   NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sic_exp.uwm120 THEN
        ASSIGN 
        n_prempa   = substring(sic_exp.uwm120.class,1,1)
        n_subclass = substring(sic_exp.uwm120.class,2,3).
    FIND LAST sic_exp.uwm301 USE-INDEX uwm30101      WHERE
           sic_exp.uwm301.policy = sic_exp.uwm100.policy    AND
           sic_exp.uwm301.rencnt = sic_exp.uwm100.rencnt    AND
           sic_exp.uwm301.endcnt = sic_exp.uwm100.endcnt    NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sic_exp.uwm301 THEN
        ASSIGN 
        /*n_vehreg1  = sic_exp.uwm301.vehreg*/        /*A55-0008*/
        n_redbook  = sic_exp.uwm301.modcod            /* redbook  */  
        n_brand    = substr(sic_exp.uwm301.moddes,1,INDEX(sic_exp.uwm301.moddes," ") - 1 )
        n_model    = substr(sic_exp.uwm301.moddes,INDEX(sic_exp.uwm301.moddes," ") + 1 )
        n_caryear  = string(sic_exp.uwm301.yrmanu )   /*รุ่นปี*/
        n_cargrp   = sic_exp.uwm301.vehgrp            /*กลุ่มรถยนต์*/   
        n_bodys    = sic_exp.uwm301.body
        n_engcc    = STRING(sic_exp.uwm301.engine) 
        n_tonns    = string(sic_exp.uwm301.Tons) 
        n_seat     = sic_exp.uwm301.seats             /*จำนวนที่นั่ง*/ 
        n_vehuse   = sic_exp.uwm301.vehuse 
        n_covcod   = sic_exp.uwm301.covcod                 
        n_garage   = sic_exp.uwm301.garage 
        nv_seat41  = sic_exp.uwm301.mv41seat 
        n_prmtxt   = sic_exp.uwm301.prmtxt .   /*kridtiya i. A55-0114 */
    FOR EACH sic_exp.uwd132 USE-INDEX uwd13290  WHERE
        sic_exp.uwd132.policy   = sic_exp.uwm301.policy  AND
        sic_exp.uwd132.rencnt   = sic_exp.uwm301.rencnt  AND
        sic_exp.uwd132.endcnt   = sic_exp.uwm301.endcnt  AND
        sic_exp.uwd132.riskno   = sic_exp.uwm301.riskno  AND
        sic_exp.uwd132.itemno   = sic_exp.uwm301.itemno  NO-LOCK .
        IF sic_exp.uwd132.bencod                = "411" THEN
            ASSIGN   
            n_41   = deci(SUBSTRING(sic_exp.uwd132.benvar,31,30)).  
        ELSE IF sic_exp.uwd132.bencod           = "42" THEN
            ASSIGN   
            n_42   =  deci(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod                = "43" THEN
            ASSIGN   
            n_43   =  deci(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod                = "base" THEN
            ASSIGN   
                nv_basere = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod                = "dspc" THEN
            ASSIGN   
                nv_dss_per = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod                = "ncb" THEN
            ASSIGN   
                n_NCB = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod                = "DOD" THEN
            ASSIGN   
                n_dod = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod                = "DOD2" THEN
            ASSIGN   
                n_dod2 = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod                = "DPD" THEN
            ASSIGN   
                n_pd = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod                = "FLET" THEN
            ASSIGN   
                n_feet = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod                = "DSPC" THEN
            ASSIGN   
                nv_dss_per = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF index(sic_exp.uwd132.bencod,"cl") <> 0  THEN
            ASSIGN   
                n_lcd = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        /* create by : A64-0138...*/
        IF sic_exp.uwd132.bencod <> "comp"  THEN DO:
            n_premt = n_premt + sic_exp.uwd132.prem_c.
        END.
        /*...end A64-0138..*/
    END.
    /*comment by kridtiya i. A54-0008..
    IF trim(n_vehreg1) =  trim(n_vehreg) THEN DO:
        IF deci(n_sumins) <> n_sumins1  THEN MESSAGE "ทุนจากไฟล์ " + n_sumins + " ไม่เท่ากับทุนกรมธรรม์เดิมในระบบ : " +  string(n_sumins1) VIEW-AS ALERT-BOX.
    END.
    ELSE DO:
        IF deci(n_sumins) <> n_sumins1  THEN 
            MESSAGE "ทะเบียนรถจากไฟล์ " + n_vehreg + " ไม่เท่ากับทะเบียนรถกรมธรรม์เดิมในระบบ :" +  n_vehreg1  SKIP
                    "ทุนจากไฟล์ " + n_sumins + " ไม่เท่ากับทุนกรมธรรม์เดิมในระบบ : " +  string(n_sumins1) VIEW-AS ALERT-BOX.
        ELSE 
            MESSAGE "ทะเบียนรถจากไฟล์ " + n_vehreg + " ไม่เท่ากับทะเบียนรถกรมธรรม์เดิมในระบบ : " +  n_vehreg1  VIEW-AS ALERT-BOX.
    END.
    end...comment by kridtiya i. A54-0008..*/
END. 
                                  
                                 
                                   
                                 
                                 
                             
