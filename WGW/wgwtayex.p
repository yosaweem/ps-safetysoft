/* wgwtayex.P  -- Load Text file aycl to gw                          */
/* Copyright   # Safety Insurance Public Company Limited                   */
/*               บริษัท ประกันคุ้มภัย จำกัด (มหาชน)                        */
/* WRITE  BY   : Kridtiya i.A56-0241  23/08/2013                           */
/*             : ส่วนการค้นหาค่า งานต่ออายุเพื่อให้ค่า กรมธรรม์ต่ออายุใหม่ */
/* ------------------------------------------------------------------------*/
DEFINE INPUT-OUTPUT  PARAMETER nr_prepol    AS CHAR FORMAT "x(12)" INIT "".  /*..ok*/          
DEFINE INPUT-OUTPUT  PARAMETER nr_branch    AS CHAR FORMAT "x(2)"  INIT "".  /*..ok*/     
DEFINE INPUT-OUTPUT  PARAMETER nr_insref    AS CHAR FORMAT "x(10)" INIT "".  /*..ok*/
DEFINE INPUT-OUTPUT  PARAMETER nr_tiname    AS CHAR FORMAT "x(20)" INIT "".  
DEFINE INPUT-OUTPUT  PARAMETER nr_insnam1   AS CHAR FORMAT "x(80)" INIT "".  
DEFINE INPUT-OUTPUT  PARAMETER nr_insnam2   AS CHAR FORMAT "x(80)" INIT "".  
DEFINE INPUT-OUTPUT  PARAMETER nr_insnam3   AS CHAR FORMAT "x(80)" INIT "".  
DEFINE INPUT-OUTPUT  PARAMETER nr_iadd1     AS CHAR FORMAT "x(60)" INIT "".  
DEFINE INPUT-OUTPUT  PARAMETER nr_iadd2     AS CHAR FORMAT "x(40)" INIT "".  
DEFINE INPUT-OUTPUT  PARAMETER nr_iadd3     AS CHAR FORMAT "x(40)" INIT "".  
DEFINE INPUT-OUTPUT  PARAMETER nr_iadd4     AS CHAR FORMAT "x(40)" INIT "".  
DEFINE INPUT-OUTPUT  PARAMETER nr_producer  AS CHAR FORMAT "x(10)" INIT "".  
DEFINE INPUT-OUTPUT  PARAMETER nr_agent     AS CHAR FORMAT "x(10)" INIT "".  
DEFINE INPUT-OUTPUT  PARAMETER nr_comdat    AS CHAR FORMAT "x(10)" INIT "".  
DEFINE INPUT-OUTPUT  PARAMETER nr_expdat    AS CHAR FORMAT "x(10)" INIT "".  
DEFINE INPUT-OUTPUT  PARAMETER nr_firstdat  AS CHAR FORMAT "x(10)" INIT "".  /*..ok*/    
DEFINE INPUT-OUTPUT  PARAMETER nr_prempa    AS CHAR FORMAT "x"     INIT "".  /*..ok*/           
DEFINE INPUT-OUTPUT  PARAMETER nr_subclass  AS CHAR FORMAT "x(3)"  INIT "".  /*..ok*/        
DEFINE INPUT-OUTPUT  PARAMETER nr_redbook   AS CHAR FORMAT "x(8)"  INIT "".  /*..ok*/       
DEFINE INPUT-OUTPUT  PARAMETER nr_brand     AS CHAR FORMAT "x(30)" INIT "".  /*..ok*/                          
DEFINE INPUT-OUTPUT  PARAMETER nr_model     AS CHAR FORMAT "x(80)" INIT "".  /*..ok*/                          
DEFINE INPUT-OUTPUT  PARAMETER nr_caryear   AS CHAR FORMAT "x(4)"  INIT "".  /*..ok*/ 
DEFINE INPUT-OUTPUT  PARAMETER nr_cargrp    AS CHAR FORMAT "x(2)"  INIT "".  /*..ok*/                          
DEFINE INPUT-OUTPUT  PARAMETER nr_body      AS CHAR FORMAT "x(20)" INIT "".  /*..ok*/                                      
DEFINE INPUT-OUTPUT  PARAMETER nr_cc        AS CHAR FORMAT "x(4)"  INIT "".  /*..ok*/                              
DEFINE INPUT-OUTPUT  PARAMETER nr_weight    AS CHAR FORMAT "x(4)"  INIT "".  /*..ok*/                             
DEFINE INPUT-OUTPUT  PARAMETER nr_seat      AS CHAR FORMAT "x(2)"  INIT "".  /*..ok*/   
DEFINE INPUT-OUTPUT  PARAMETER nr_vehuse    AS CHAR FORMAT "x"     INIT "".  /*..ok*/ 
DEFINE INPUT-OUTPUT  PARAMETER nr_covcod    AS CHAR FORMAT "x"     INIT "".  /*..ok*/    
DEFINE INPUT-OUTPUT  PARAMETER nr_garage    AS CHAR FORMAT "x"     INIT "".  /*..ok*/                        
DEFINE INPUT-OUTPUT  PARAMETER nr_vehreg    AS CHAR FORMAT "x(11)" INIT "".  /*..ok*/     
DEFINE INPUT-OUTPUT  PARAMETER nr_chasno    AS CHAR FORMAT "x(25)" INIT "".  /*..ok*/                                 
DEFINE INPUT-OUTPUT  PARAMETER nr_engno     AS CHAR FORMAT "x(25)" INIT "".  /*..ok*/ 
DEFINE INPUT-OUTPUT  PARAMETER nr_tpbiper   AS CHAR FORMAT "x(20)" INIT "".  /*..ok*/ 
DEFINE INPUT-OUTPUT  PARAMETER nr_tpbiacc   AS CHAR FORMAT "x(20)" INIT "".  /*..ok*/ 
DEFINE INPUT-OUTPUT  PARAMETER nr_tppdacc   AS CHAR FORMAT "x(20)" INIT "".  /*..ok*/ 
DEFINE INPUT-OUTPUT  PARAMETER nr_si        AS CHAR FORMAT "x(20)" INIT "". 
DEFINE INPUT-OUTPUT  PARAMETER nr_fi        AS CHAR FORMAT "x(20)" INIT "". 
DEFINE INPUT-OUTPUT  PARAMETER nr_basere    AS CHAR FORMAT "x(20)" INIT "".   
DEFINE INPUT-OUTPUT  PARAMETER nr_seat41    AS INTE FORMAT "99"    INIT 0 .  /*..ok*/
DEFINE INPUT-OUTPUT  PARAMETER nr_use       AS DECI FORMAT ">,>>>,>>9.99" INIT 0.
DEFINE INPUT-OUTPUT  PARAMETER nr_grpvar    AS DECI FORMAT ">,>>>,>>9.99" INIT 0.
DEFINE INPUT-OUTPUT  PARAMETER nr_yrvar     AS DECI FORMAT ">,>>>,>>9.99" INIT 0.
DEFINE INPUT-OUTPUT  PARAMETER nr_drivnam   AS LOGICAL INIT NO.
DEFINE INPUT-OUTPUT  PARAMETER nr_drivno    AS DECI INIT 0.
DEFINE INPUT-OUTPUT  PARAMETER nr_41        AS DECI FORMAT ">,>>>,>>9.99" INIT 0.    
DEFINE INPUT-OUTPUT  PARAMETER nr_42        AS DECI FORMAT ">,>>>,>>9.99" INIT 0.   
DEFINE INPUT-OUTPUT  PARAMETER nr_43        AS DECI FORMAT ">,>>>,>>9.99" INIT 0.   
DEFINE INPUT-OUTPUT  PARAMETER nr_dod1      AS DECI INIT 0.  
DEFINE INPUT-OUTPUT  PARAMETER nr_dod2      AS DECI INIT 0. 
DEFINE INPUT-OUTPUT  PARAMETER nr_dod0      AS DECI INIT 0. 
DEFINE INPUT-OUTPUT  PARAMETER nr_flet_per  AS DECIMAL FORMAT ">>9"   INIT 0 .  
DEFINE INPUT-OUTPUT  PARAMETER nr_ncbper    AS DECIMAL FORMAT ">>9"   INIT 0 .  
DEFINE INPUT-OUTPUT  PARAMETER nr_dss_per   AS DECIMAL FORMAT ">>9"   INIT 0 .     
DEFINE INPUT-OUTPUT  PARAMETER nr_stf_per   AS DECIMAL FORMAT ">>9"   INIT 0 .   
DEFINE INPUT-OUTPUT  PARAMETER nr_cl_per    AS DECIMAL FORMAT ">>9"   INIT 0 .  
DEFINE INPUT-OUTPUT  PARAMETER nr_benname   AS CHAR    FORMAT "x(60)" INIT 0 .  

FIND LAST sic_exp.uwm100  WHERE sic_exp.uwm100.policy = nr_prepol   NO-LOCK NO-ERROR NO-WAIT.
IF AVAILABLE sic_exp.uwm100 THEN DO:
    ASSIGN 
        nr_branch   = trim(sic_exp.uwm100.branch)
        nr_insref   = trim(sic_exp.uwm100.insref)
        nr_tiname   = trim(sic_exp.uwm100.ntitle)
        nr_insnam1  = trim(sic_exp.uwm100.name1) 
        nr_insnam2  = trim(sic_exp.uwm100.name2) 
        nr_insnam3  = trim(sic_exp.uwm100.name3) 
        nr_iadd1    = trim(sic_exp.uwm100.addr1)  
        nr_iadd2    = trim(sic_exp.uwm100.addr2) 
        nr_iadd3    = trim(sic_exp.uwm100.addr3) 
        nr_iadd4    = trim(sic_exp.uwm100.addr4) 
        nr_producer = trim(sic_exp.uwm100.acno1)
        nr_agent    = trim(sic_exp.uwm100.agent)
        nr_comdat   = string(sic_exp.uwm100.expdat)
        nr_expdat   = (string(day(sic_exp.uwm100.expdat)) + "/" +
                           STRING(MONTH(sic_exp.uwm100.expdat))  + "/" +
                           STRING(YEAR(sic_exp.uwm100.expdat) + 1 ))
        nr_firstdat  = string(sic_exp.uwm100.fstdat).

    FIND LAST sic_exp.uwm130 USE-INDEX uwm13001         WHERE
        sic_exp.uwm130.policy = sic_exp.uwm100.policy   AND
        sic_exp.uwm130.rencnt = sic_exp.uwm100.rencnt   AND
        sic_exp.uwm130.endcnt = sic_exp.uwm100.endcnt   NO-LOCK NO-WAIT NO-ERROR.   
    IF  AVAILABLE uwm130 THEN 
        ASSIGN 
        nr_tpbiper  = string(sic_exp.uwm130.uom1_v)  
        nr_tpbiacc  = string(sic_exp.uwm130.uom2_v)  
        nr_tppdacc  = string(sic_exp.uwm130.uom5_v) 
        nr_si       = string(sic_exp.uwm130.uom6_v)
        nr_fi       = string(sic_exp.uwm130.uom7_v).
    FIND FIRST  sic_exp.uwm120 USE-INDEX uwm12001       WHERE
        sic_exp.uwm120.policy  = sic_exp.uwm100.policy  AND
        sic_exp.uwm120.rencnt  = sic_exp.uwm100.rencnt  AND
        sic_exp.uwm120.endcnt  = sic_exp.uwm100.endcnt  NO-LOCK NO-ERROR NO-WAIT.  
    IF AVAIL sic_exp.uwm120 THEN
        ASSIGN 
        nr_prempa    = substring(sic_exp.uwm120.class,1,1)
        nr_subclass  = substring(sic_exp.uwm120.class,2,3) .
    FIND LAST sic_exp.uwm301  USE-INDEX uwm30101   WHERE
        sic_exp.uwm301.policy = sic_exp.uwm100.policy    AND
        sic_exp.uwm301.rencnt = sic_exp.uwm100.rencnt    AND
        sic_exp.uwm301.endcnt = sic_exp.uwm100.endcnt    NO-LOCK NO-ERROR NO-WAIT.   /* A56-0146 */  
    IF AVAIL sic_exp.uwm301 THEN
        ASSIGN 
        nr_redbook  = sic_exp.uwm301.modcod 
        nr_brand    = substr(sic_exp.uwm301.moddes,1,INDEX(sic_exp.uwm301.moddes," ") - 1 ) 
        nr_model    = substr(sic_exp.uwm301.moddes,INDEX(sic_exp.uwm301.moddes," ") + 1 )   
        nr_caryear  = string(sic_exp.uwm301.yrmanu )    /*รุ่นปี*/   
        nr_cargrp   = sic_exp.uwm301.vehgrp             
        nr_body     = sic_exp.uwm301.body               
        nr_cc       = STRING(sic_exp.uwm301.engine)     
        nr_weight   = string(sic_exp.uwm301.Tons)       
        nr_seat     = string(sic_exp.uwm301.seats)      /*กลุ่มรถยนต์ */ 
        nr_vehuse   = sic_exp.uwm301.vehuse             /*จำนวนที่นั่ง*/  
        nr_covcod   = sic_exp.uwm301.covcod             
        nr_garage   = sic_exp.uwm301.garage             /*หมายเลขเครื่อง*/   
        nr_chasno   = sic_exp.uwm301.cha_no             /*หมายเลขตัวถัง */                                            
        nr_engno    = sic_exp.uwm301.eng_no                           
        nr_seat41   = sic_exp.uwm301.mv41seat  
        nr_benname  = sic_exp.uwm301.mv_ben83 . 
    FOR EACH sic_exp.uwd132 USE-INDEX uwd13290  WHERE
        sic_exp.uwd132.policy   = sic_exp.uwm301.policy  AND
        sic_exp.uwd132.rencnt   = sic_exp.uwm301.rencnt  AND
        sic_exp.uwd132.endcnt   = sic_exp.uwm301.endcnt  AND
        sic_exp.uwd132.riskno   = sic_exp.uwm301.riskno  AND
        sic_exp.uwd132.itemno   = sic_exp.uwm301.itemno  NO-LOCK .
        IF             sic_exp.uwd132.bencod      = "base" THEN ASSIGN nr_basere = (SUBSTRING(sic_exp.uwd132.benvar,31,30)).  
        ELSE IF SUBSTR(sic_exp.uwd132.bencod,1,3) = "USE"  THEN ASSIGN nr_use    = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF SUBSTR(sic_exp.uwd132.bencod,1,3) = "GRP"  THEN ASSIGN nr_grpvar = deci(SUBSTRING(sic_exp.uwd132.benvar,31,30)). 
        ELSE IF SUBSTR(sic_exp.uwd132.bencod,1,2) = "YR"   THEN ASSIGN nr_yrvar  = deci(SUBSTRING(sic_exp.uwd132.benvar,31,30)). 
        ELSE IF SUBSTR(sic_exp.uwd132.bencod,1,1) = "A"    THEN DO:  
            IF      SUBSTR(sic_exp.uwd132.bencod,2,1) = "0"  THEN
                ASSIGN  
                nr_drivnam       = NO
                nr_drivno        = 0.
            ELSE IF SUBSTR(sic_exp.uwd132.bencod,2,1) = "1"  THEN
                ASSIGN  
                nr_drivnam       = YES
                nr_drivno        = 1.
            ELSE IF SUBSTR(sic_exp.uwd132.bencod,2,1) = "2"  THEN
                ASSIGN  
                nr_drivnam        = YES
                nr_drivno         = 2.
        END.
        ELSE IF sic_exp.uwd132.bencod = "411"  THEN ASSIGN nr_41       = deci(SUBSTRING(sic_exp.uwd132.benvar,31,30)). 
        ELSE IF sic_exp.uwd132.bencod = "42"   THEN ASSIGN nr_42       = deci(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod = "43"   THEN ASSIGN nr_43       = deci(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod = "DOD"  THEN ASSIGN nr_dod1     = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).  
        ELSE IF sic_exp.uwd132.bencod = "DOD2" THEN ASSIGN nr_dod2     = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod = "DPD"  THEN ASSIGN nr_dod0     = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod = "FLET" THEN ASSIGN nr_flet_per = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod = "ncb"  THEN ASSIGN nr_ncbper   = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod = "DSPC" THEN ASSIGN nr_dss_per  = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod = "DSTF" THEN ASSIGN nr_stf_per  = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF index(sic_exp.uwd132.bencod,"cl") <> 0  THEN ASSIGN   nr_cl_per  = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
    END.
END. 


                                  
                                 
                                   
                                 
                             
                                 
                             
