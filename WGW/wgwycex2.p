/* wgwtbex1.P  -- Load Text file yakult [ยาคูลธ์]to gw                      */
/* Copyright   # Safety Insurance Public Company Limited                    */
/*               บริษัท ประกันคุ้มภัย จำกัด (มหาชน)                         */
/* WRITE  BY   : Kridtiya i.A54-0129  26/05/2011                            */
/*             : ส่วนการค้นหาค่า งานต่ออายุเพื่อให้ค่า ข้อมูลลูกค้าชื่อเดิม */
/* ------------------------------------------------------------------------ */
/*modify by    : kridtiya i. A55-0182 ปรับการแสดงค่ารุ่นรถ                  */
/* modify by   : kridtiya i. A57-0042 date. 10/02/20104                     */
/*Modify by   : Kridtiya i. A63-0472 Date. 09/11/2020 add field firstname ,lastname.....*/
/* Modify by  : Ranu I. A64-0138  เพิ่มการเก็บเบี้ยสุทธิ */

DEFINE INPUT-OUTPUT  PARAMETER n_prepol     AS CHAR FORMAT "x(25)" .  
DEFINE INPUT-OUTPUT  PARAMETER n_poltyp     AS CHAR FORMAT "x(3)"  . 
DEFINE INPUT-OUTPUT  PARAMETER n_opnpol     AS CHAR FORMAT "x(20)"  . 
DEFINE INPUT-OUTPUT  PARAMETER n_producer   AS CHAR FORMAT "x(10)" . 
DEFINE INPUT-OUTPUT  PARAMETER n_agent      AS CHAR FORMAT "x(10)" . 
DEFINE INPUT-OUTPUT  PARAMETER n_insured    AS CHAR FORMAT "x(15)"  .  
DEFINE INPUT-OUTPUT  PARAMETER n_title      AS CHAR FORMAT "x(20)"  .  
DEFINE INPUT-OUTPUT  PARAMETER n_name1      AS CHAR FORMAT "x(50)"  .  
DEFINE INPUT-OUTPUT  PARAMETER n_name2      AS CHAR FORMAT "x(50)"  .  
DEFINE INPUT-OUTPUT  PARAMETER n_name3      AS CHAR FORMAT "x(50)"  .  
DEFINE INPUT-OUTPUT  PARAMETER n_addr1      AS CHAR FORMAT "x(35)"  .  
DEFINE INPUT-OUTPUT  PARAMETER n_addr2      AS CHAR FORMAT "x(35)"  .  
DEFINE INPUT-OUTPUT  PARAMETER n_addr3      AS CHAR FORMAT "x(35)"  .
DEFINE INPUT-OUTPUT  PARAMETER n_addr4      AS CHAR FORMAT "x(20)"  .
DEFINE INPUT-OUTPUT  PARAMETER n_expdat     AS CHAR FORMAT "99/99/9999".
DEFINE INPUT-OUTPUT  PARAMETER n_firstdat   AS CHAR FORMAT "99/99/9999".
DEFINE INPUT-OUTPUT  PARAMETER n_cedpol     AS CHAR FORMAT "x(20)".
DEFINE INPUT-OUTPUT  PARAMETER n_prempa     AS CHAR FORMAT "x(4)" .
DEFINE INPUT-OUTPUT  PARAMETER n_subclass   AS CHAR FORMAT "x(4)" .   
DEFINE INPUT-OUTPUT  PARAMETER n_redbook    AS CHAR FORMAT "x(10)" .   
DEFINE INPUT-OUTPUT  PARAMETER n_brand      AS CHAR FORMAT "x(30)" . 
DEFINE INPUT-OUTPUT  PARAMETER n_model      AS CHAR FORMAT "x(40)" . 
DEFINE INPUT-OUTPUT  PARAMETER n_caryear    AS CHAR FORMAT "x(4)" .   
DEFINE INPUT-OUTPUT  PARAMETER n_cargrp     AS CHAR FORMAT "x(2)" .   
DEFINE INPUT-OUTPUT  PARAMETER n_body       AS CHAR FORMAT "x(30)" .   
DEFINE INPUT-OUTPUT  PARAMETER n_engcc      AS CHAR FORMAT "x(10)" . 
DEFINE INPUT-OUTPUT  PARAMETER n_tons       AS CHAR FORMAT "x(10)" . 
DEFINE INPUT-OUTPUT  PARAMETER n_seat       AS INTE FORMAT "99"  INIT 0.
DEFINE INPUT-OUTPUT  PARAMETER n_vehuse     AS CHAR FORMAT "x(2)" .   
DEFINE INPUT-OUTPUT  PARAMETER n_covcod     AS CHAR FORMAT "x(1)" .
DEFINE INPUT-OUTPUT  PARAMETER n_garage     AS CHAR FORMAT "x".
DEFINE INPUT-OUTPUT  PARAMETER n_vehreg     AS CHAR FORMAT "x(15)" .   
DEFINE INPUT-OUTPUT  PARAMETER n_chasno     AS CHAR FORMAT "x(30)" .   
DEFINE INPUT-OUTPUT  PARAMETER n_engno      AS CHAR FORMAT "x(30)" .   
DEFINE INPUT-OUTPUT  PARAMETER n_uom1_v     AS DECI FORMAT ">,>>>,>>>,>>9.99-" INIT 0. 
DEFINE INPUT-OUTPUT  PARAMETER n_uom2_v     AS DECI FORMAT ">,>>>,>>>,>>9.99-" INIT 0.  
DEFINE INPUT-OUTPUT  PARAMETER n_uom5_v     AS DECI FORMAT ">,>>>,>>>,>>9.99-" INIT 0.
DEFINE INPUT-OUTPUT  PARAMETER n_uom6_v     AS DECI FORMAT ">,>>>,>>>,>>9.99-" INIT 0.
DEFINE INPUT-OUTPUT  PARAMETER n_uom7_v     AS DECI FORMAT ">,>>>,>>>,>>9.99-" INIT 0.
DEFINE INPUT-OUTPUT  PARAMETER nv_baseprm   AS DECI FORMAT ">,>>>,>>>,>>9.99-" INIT 0.
DEFINE INPUT-OUTPUT  PARAMETER n_41         AS DECI.
DEFINE INPUT-OUTPUT  PARAMETER nv_seat41    AS DECI.
DEFINE INPUT-OUTPUT  PARAMETER n_42         AS DECI. 
DEFINE INPUT-OUTPUT  PARAMETER n_43         AS DECI.  
DEFINE INPUT-OUTPUT  PARAMETER nv_dedod     AS INTEGER INIT 0.
DEFINE INPUT-OUTPUT  PARAMETER nv_addod     AS INTEGER INIT 0.
DEFINE INPUT-OUTPUT  PARAMETER nv_dedpd     AS INTEGER INIT 0.
DEFINE INPUT-OUTPUT  PARAMETER nv_flet_per  AS DECI.
DEFINE INPUT-OUTPUT  PARAMETER nv_ncbper    AS DECI.
DEFINE INPUT-OUTPUT  PARAMETER nv_dss_per   AS DECI.
DEFINE INPUT-OUTPUT  PARAMETER nv_stf_per   AS DECI.  
DEFINE INPUT-OUTPUT  PARAMETER nv_cl_per    AS DECI. 
DEFINE INPUT-OUTPUT  PARAMETER nv_premt     AS DECI. /*A64-0138*/
DEFINE INPUT-OUTPUT  PARAMETER nv_bennam1   AS CHAR FORMAT "x(60)".
DEFINE INPUT-OUTPUT  PARAMETER nv_acctxt    AS CHAR FORMAT "x(120)".  
DEFINE INPUT-OUTPUT  PARAMETER nv_insnamtyp  as char format "x(100)" init "". /*Add by Kridtiya i. A63-0472*/    
DEFINE INPUT-OUTPUT  PARAMETER nv_firstName  as char format "x(100)" init "". /*Add by Kridtiya i. A63-0472*/    
DEFINE INPUT-OUTPUT  PARAMETER nv_lastName   as char format "x(100)" init "". /*Add by Kridtiya i. A63-0472*/    
DEFINE INPUT-OUTPUT  PARAMETER nv_postcd     as char format "x(100)" init "". /*Add by Kridtiya i. A63-0472*/    
DEFINE INPUT-OUTPUT  PARAMETER nv_icno       as char format "x(100)" init "". /*Add by Kridtiya i. A63-0472*/    
DEFINE INPUT-OUTPUT  PARAMETER nv_codeocc    as char format "x(100)" init "". /*Add by Kridtiya i. A63-0472*/    
DEFINE INPUT-OUTPUT  PARAMETER nv_codeaddr1  as char format "x(100)" init "". /*Add by Kridtiya i. A63-0472*/   
DEFINE INPUT-OUTPUT  PARAMETER nv_codeaddr2  as char format "x(100)" init "". /*Add by Kridtiya i. A63-0472*/   
DEFINE INPUT-OUTPUT  PARAMETER nv_codeaddr3  as char format "x(100)" init "". /*Add by Kridtiya i. A63-0472*/   
DEFINE INPUT-OUTPUT  PARAMETER nv_br_insured as char format "x(100)" init "". /*Add by Kridtiya i. A63-0472*/  

FIND LAST sic_exp.uwm100  WHERE sic_exp.uwm100.policy = n_prepol  NO-LOCK NO-ERROR NO-WAIT.
IF AVAILABLE sic_exp.uwm100 THEN DO:
    FIND FIRST  sic_exp.uwm120 USE-INDEX uwm12001       WHERE
        sic_exp.uwm120.policy  = sic_exp.uwm100.policy  AND
        sic_exp.uwm120.rencnt  = sic_exp.uwm100.rencnt  AND
        sic_exp.uwm120.endcnt  = sic_exp.uwm100.endcnt  NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sic_exp.uwm120 THEN
        ASSIGN 
        n_poltyp   = trim(sic_exp.uwm100.poltyp)
        n_opnpol   = trim(sic_exp.uwm100.opnpol)
        n_producer = trim(sic_exp.uwm100.acno1)
        n_agent    = trim(sic_exp.uwm100.agent)
        n_insured  = trim(sic_exp.uwm100.insref)
        n_title    = trim(sic_exp.uwm100.ntitle)
        n_name1    = trim(sic_exp.uwm100.name1) 
        n_name2    = trim(sic_exp.uwm100.name2) 
        n_name3    = trim(sic_exp.uwm100.name3) 
        n_addr1    = trim(sic_exp.uwm100.addr1) 
        n_addr2    = trim(sic_exp.uwm100.addr2) 
        n_addr3    = trim(sic_exp.uwm100.addr3) 
        n_addr4    = trim(sic_exp.uwm100.addr4) 
        n_expdat   = string(sic_exp.uwm100.expdat,"99/99/9999")
        n_firstdat = string(sic_exp.uwm100.fstdat,"99/99/9999")
        n_cedpol   = trim(sic_exp.uwm100.cedpol)
        n_prempa   = substring(sic_exp.uwm120.class,1,1)
        n_subclass = substring(sic_exp.uwm120.class,2,3).

    /* xmm600 *//*Add by Kridtiya i. A63-0472*/
    FIND LAST sicsyac.xmm600  USE-INDEX  xmm60001 WHERE
        sicsyac.xmm600.acno  =  n_insured   NO-LOCK NO-ERROR NO-WAIT.
    IF AVAILABLE sicsyac.xmm600 THEN 
        ASSIGN 
        nv_icno       = TRIM(sicsyac.xmm600.icno)  
        nv_insnamtyp  = TRIM(sicsyac.xmm600.acno_typ) 
        nv_firstName  = TRIM(sicsyac.xmm600.firstname)
        nv_lastName   = TRIM(sicsyac.xmm600.lastName) 
        nv_postcd     = trim(sicsyac.xmm600.postcd)   
        nv_codeocc    = TRIM(sicsyac.xmm600.codeocc)     
        nv_codeaddr1  = TRIM(sicsyac.xmm600.codeaddr1)  
        nv_codeaddr2  = trim(sicsyac.xmm600.codeaddr2)  
        nv_codeaddr3  = trim(sicsyac.xmm600.codeaddr3)  
        nv_br_insured = trim(sicsyac.xmm600.anlyc5).
    /*Add by Kridtiya i. A63-0472*/ 

    FIND FIRST  sic_exp.uwm130 USE-INDEX uwm13001     WHERE
        sic_exp.uwm130.policy  = sic_exp.uwm120.policy  AND
        sic_exp.uwm130.rencnt  = sic_exp.uwm120.rencnt  AND
        sic_exp.uwm130.endcnt  = sic_exp.uwm120.endcnt  NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sic_exp.uwm130 THEN
        ASSIGN n_uom1_v  = sic_exp.uwm130.uom1_v   
               n_uom2_v  = sic_exp.uwm130.uom2_v   
               n_uom5_v  = sic_exp.uwm130.uom5_v  
               n_uom6_v  = sic_exp.uwm130.uom6_v    
               n_uom7_v  = sic_exp.uwm130.uom7_v .
    FIND LAST sic_exp.uwm301 USE-INDEX uwm30101        WHERE
        sic_exp.uwm301.policy = sic_exp.uwm100.policy  AND
        sic_exp.uwm301.rencnt = sic_exp.uwm100.rencnt  AND
        /*sic_exp.uwm301.endcnt = sic_exp.uwm100.endcnt  NO-ERROR NO-WAIT.*/      /*A57-0042*/
        sic_exp.uwm301.endcnt = sic_exp.uwm100.endcnt  NO-LOCK NO-ERROR NO-WAIT.  /*A57-0042*/
    IF AVAIL uwm301 THEN
        ASSIGN 
        n_redbook  = trim(sic_exp.uwm301.modcod)     /* redbook  */       
        /*comment Kridtiya i. A55-0182...
        n_brand    = trim(substr(sic_exp.uwm301.moddes,1,INDEX(sic_exp.uwm301.moddes," ") - 1))
        n_model    = trim(substr(sic_exp.uwm301.moddes,INDEX(sic_exp.uwm301.moddes," ") - 1))   Kridtiya i. A55-0182*/
        n_brand    = trim(sic_exp.uwm301.moddes)     /*Kridtiya i. A55-0182*/
        n_model    = ""                              /*Kridtiya i. A55-0182*/
        n_caryear  = string(sic_exp.uwm301.yrmanu)   /*รุ่นปี*/
        n_cargrp   = trim(sic_exp.uwm301.vehgrp)     /*กลุ่มรถยนต์*/            
        n_body     = trim(sic_exp.uwm301.body)       /*แบบตัวถัง*/   
        n_engcc    = string(sic_exp.uwm301.engine)   /*ปริมาตรกระบอกสูบ*/
        n_tons     = string(sic_exp.uwm301.tons)     /*ปริมาตรกระบอกสูบ*/    
        n_seat     = sic_exp.uwm301.seats            /*จำนวนที่นั่ง*/     
        n_vehuse   = sic_exp.uwm301.vehuse           
        n_covcod   = sic_exp.uwm301.covcod           
        n_garage   = sic_exp.uwm301.garage           
        n_vehreg   = sic_exp.uwm301.vehreg           /*หมายเลขตัวถัง */  
        n_chasno   = trim(sic_exp.uwm301.cha_no)     /*หมายเลขตัวถัง */    
        n_engno    = trim(sic_exp.uwm301.eng_no)     /*หมายเลขเครื่อง*/                      
        nv_seat41  = sic_exp.uwm301.mv41seat
        nv_bennam1 = SUBSTRING(sic_exp.uwm301.mv_ben83,1,60)      
        nv_acctxt  = trim(sic_exp.uwm301.prmtxt) . 
    FOR EACH sic_exp.uwd132 USE-INDEX uwd13290  WHERE
        sic_exp.uwd132.policy   = sic_exp.uwm301.policy  AND
        sic_exp.uwd132.rencnt   = sic_exp.uwm301.rencnt  AND
        sic_exp.uwd132.endcnt   = sic_exp.uwm301.endcnt  AND
        sic_exp.uwd132.riskno   = sic_exp.uwm301.riskno  AND
        sic_exp.uwd132.itemno   = sic_exp.uwm301.itemno  NO-LOCK .
        IF sic_exp.uwd132.bencod                = "BASE"  THEN
            ASSIGN nv_baseprm            = sic_exp.uwd132.gap_c.
        ELSE IF sic_exp.uwd132.bencod            = "411" THEN
            ASSIGN  n_41   = deci(SUBSTRING(sic_exp.uwd132.benvar,31,30)).  
        ELSE IF sic_exp.uwd132.bencod            = "42" THEN
            ASSIGN  n_42   =  deci(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod                = "43" THEN
            ASSIGN  n_43   =  DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod                = "DOD" THEN
            ASSIGN nv_dedod =  DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod                = "DOD2" THEN
            ASSIGN nv_addod =  DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod                = "DPD" THEN
            ASSIGN nv_dedpd =  DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod                = "FLET"  THEN
            ASSIGN nv_flet_per = DECIMAL(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod                = "NCB" THEN
            ASSIGN nv_ncbper = DECIMAL(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod                = "DSPC" THEN
            ASSIGN nv_dss_per = DECIMAL(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod                = "DSTF" THEN
            ASSIGN nv_stf_per = DECIMAL(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF index(sic_exp.uwd132.bencod,"CL") <> 0 THEN
            ASSIGN nv_cl_per = DECIMAL(SUBSTRING(sic_exp.uwd132.benvar,31,30)).

        IF sic_exp.uwd132.bencod <> "COMP"  THEN ASSIGN nv_premt = nv_premt + sic_exp.uwd132.prem_c. /*A64-0138*/

    END.
END. 
