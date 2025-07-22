/* wgwtamex.P  -- Load Text file Amanh to gw                                 */
/* Copyright   # Safety Insurance Public Company Limited                     */  
/*               บริษัท ประกันคุ้มภัย จำกัด (มหาชน)                          */  
/* programid    : wgwtamex.p                                                 */
/* WRITE  BY    : Kridtiya i. A59-0145  date . 25/04/2016                    */  
/*              : ส่วนการค้นหาค่า งานต่ออายุเพื่อให้ค่า กรมธรรม์ต่ออายุใหม่  */  
/* programname  : load text file Amanh to GW                                 */
/* modify By   : Ranu i. A64-0138 เพิ่มเงื่อนไขการเก็บเบี้ยสุทธิ            */
/* --------------------------------------------------------------------------*/
DEFINE INPUT-OUTPUT  PARAMETER  np_prepol      AS CHAR FORMAT "x(16)"            INIT "".       
DEFINE INPUT-OUTPUT  PARAMETER  np_branch      AS CHAR FORMAT "x(2)"             INIT "".      
DEFINE INPUT-OUTPUT  PARAMETER  np_producer    AS CHAR FORMAT "x(10)"            INIT "".      
DEFINE INPUT-OUTPUT  PARAMETER  np_agent       AS CHAR FORMAT "x(10)"            INIT "".      
DEFINE INPUT-OUTPUT  PARAMETER  np_firstdat    AS CHAR FORMAT "x(10)"            INIT "".         
DEFINE INPUT-OUTPUT  PARAMETER  np_insref      AS CHAR FORMAT "x(10)"            INIT "".         
DEFINE INPUT-OUTPUT  PARAMETER  np_tiname      AS CHAR FORMAT "x(100)"           INIT "".         
DEFINE INPUT-OUTPUT  PARAMETER  np_name2       AS CHAR FORMAT "x(100)"           INIT "".        
DEFINE INPUT-OUTPUT  PARAMETER  np_name3       AS CHAR FORMAT "x(100)"           INIT "".        
DEFINE INPUT-OUTPUT  PARAMETER  np_iadd1       AS CHAR FORMAT "x(45)"            INIT "".        
DEFINE INPUT-OUTPUT  PARAMETER  np_iadd2       AS CHAR FORMAT "x(45)"            INIT "".        
DEFINE INPUT-OUTPUT  PARAMETER  np_iadd3       AS CHAR FORMAT "x(45)"            INIT "".        
DEFINE INPUT-OUTPUT  PARAMETER  np_iadd4       AS CHAR FORMAT "x(45)"            INIT "".        
DEFINE INPUT-OUTPUT  PARAMETER  np_subclass    AS CHAR FORMAT "x(3)"             INIT "".      
DEFINE INPUT-OUTPUT  PARAMETER  np_redbook     AS CHAR FORMAT "x(10)"            INIT "".      
DEFINE INPUT-OUTPUT  PARAMETER  np_brand       AS CHAR FORMAT "x(30)"            INIT "".      
DEFINE INPUT-OUTPUT  PARAMETER  np_model       AS CHAR FORMAT "x(50)"            INIT "".      
DEFINE INPUT-OUTPUT  PARAMETER  np_caryear     AS CHAR FORMAT "x(4)"             INIT "".            
DEFINE INPUT-OUTPUT  PARAMETER  np_cargrp      AS CHAR FORMAT "x"                INIT "".          
DEFINE INPUT-OUTPUT  PARAMETER  np_body        AS CHAR FORMAT "x(30)"            INIT "".         
DEFINE INPUT-OUTPUT  PARAMETER  np_cc          AS CHAR FORMAT "x(30)"            INIT "".                   
DEFINE INPUT-OUTPUT  PARAMETER  np_weight      AS DECI FORMAT ">>,>>9.99-" .                 
DEFINE INPUT-OUTPUT  PARAMETER  np_seat        AS CHAR FORMAT "x(2)"             INIT "".                  
DEFINE INPUT-OUTPUT  PARAMETER  np_vehuse      AS CHAR FORMAT "x"                INIT "".               
DEFINE INPUT-OUTPUT  PARAMETER  np_covcod      AS CHAR FORMAT "x(5)"             INIT "".               
DEFINE INPUT-OUTPUT  PARAMETER  np_garage      AS CHAR FORMAT "x"                INIT "".   
DEFINE INPUT-OUTPUT  PARAMETER  np_benname     AS CHAR FORMAT "x(100)"           INIT "".   
DEFINE INPUT-OUTPUT  PARAMETER  np_vehreg      AS CHAR FORMAT "x(11)"            INIT "".              
DEFINE INPUT-OUTPUT  PARAMETER  np_uom1_v      AS DECI FORMAT ">>>,>>>,>>9.99-"  INIT "".                                
DEFINE INPUT-OUTPUT  PARAMETER  np_uom2_v      AS DECI FORMAT ">>>,>>>,>>9.99-"  INIT "".                                   
DEFINE INPUT-OUTPUT  PARAMETER  np_uom5_v      AS DECI FORMAT ">>>,>>>,>>9.99-"  INIT "".                                  
DEFINE INPUT-OUTPUT  PARAMETER  np_si          AS CHAR FORMAT "x(20)"            INIT "".              
DEFINE INPUT-OUTPUT  PARAMETER  np_fi          AS CHAR FORMAT "x(20)"            INIT "".             
DEFINE INPUT-OUTPUT  PARAMETER  np_baseprm     AS CHAR FORMAT "x(20)"            INIT "".        
DEFINE INPUT-OUTPUT  PARAMETER  np_41          AS DECI FORMAT ">>>,>>>,>>9.99-"  INIT "".        
DEFINE INPUT-OUTPUT  PARAMETER  np_42          AS DECI FORMAT ">>>,>>>,>>9.99-"  INIT "".       
DEFINE INPUT-OUTPUT  PARAMETER  np_43          AS DECI FORMAT ">>>,>>>,>>9.99-"  INIT "".       
DEFINE INPUT-OUTPUT  PARAMETER  np_seat41      AS INTE FORMAT "99"               INIT 0 .         
DEFINE INPUT-OUTPUT  PARAMETER  np_dod1        AS DECI INIT 0.                    
DEFINE INPUT-OUTPUT  PARAMETER  np_dod2        AS DECI INIT 0.                   
DEFINE INPUT-OUTPUT  PARAMETER  np_ded         AS DECI INIT 0.                   
DEFINE INPUT-OUTPUT  PARAMETER  np_nv_flet_per AS DECI INIT 0.          
DEFINE INPUT-OUTPUT  PARAMETER  np_nv_ncbper   AS DECI INIT 0.         
DEFINE INPUT-OUTPUT  PARAMETER  np_nv_dss_per  AS DECI INIT 0.   
DEFINE INPUT-OUTPUT  PARAMETER  nv_stf_per     AS DECI INIT 0.     
DEFINE INPUT-OUTPUT  PARAMETER  np_cl_per      AS DECI INIT 0. 
DEFINE INPUT-OUTPUT  PARAMETER  n_premt        AS DECI FORMAT ">>>,>>>,>>9.99". /*A64-0138*/

FIND LAST sic_exp.uwm100 USE-INDEX uwm10001 WHERE 
    sic_exp.uwm100.policy = trim(np_prepol)   NO-LOCK NO-ERROR NO-WAIT.
IF AVAILABLE sic_exp.uwm100 THEN DO:
    ASSIGN 
        np_insref   = sic_exp.uwm100.insref
        np_producer = sic_exp.uwm100.acno1
        np_agent    = sic_exp.uwm100.agent  .
    FIND LAST sic_exp.uwm130 USE-INDEX uwm13001 WHERE
        sic_exp.uwm130.policy = sic_exp.uwm100.policy AND
        sic_exp.uwm130.rencnt = sic_exp.uwm100.rencnt AND
        sic_exp.uwm130.endcnt = sic_exp.uwm100.endcnt NO-LOCK NO-WAIT NO-ERROR.   
    IF  AVAILABLE uwm130 THEN 
        ASSIGN 
        np_uom1_v = sic_exp.uwm130.uom1_v  
        np_uom2_v = sic_exp.uwm130.uom2_v  
        np_uom5_v = sic_exp.uwm130.uom5_v
        np_si     = string(sic_exp.uwm130.uom6_v) 
        np_fi     = string(sic_exp.uwm130.uom7_v)     . 
    FIND FIRST  sic_exp.uwm120 USE-INDEX uwm12001       WHERE
        sic_exp.uwm120.policy  = sic_exp.uwm100.policy  AND
        sic_exp.uwm120.rencnt  = sic_exp.uwm100.rencnt  AND
        sic_exp.uwm120.endcnt  = sic_exp.uwm100.endcnt  NO-LOCK NO-ERROR NO-WAIT.  
    IF AVAIL sic_exp.uwm120 THEN
        ASSIGN 
        np_firstdat = string(sic_exp.uwm100.fstdat)
        np_branch   = sic_exp.uwm100.branch
        np_subclass = sic_exp.uwm120.class.
    FIND LAST sic_exp.uwm301 USE-INDEX uwm30101        WHERE
        sic_exp.uwm301.policy = sic_exp.uwm100.policy  AND
        sic_exp.uwm301.rencnt = sic_exp.uwm100.rencnt  AND
        sic_exp.uwm301.endcnt = sic_exp.uwm100.endcnt  NO-LOCK NO-ERROR NO-WAIT.  
    IF AVAIL sic_exp.uwm301 THEN
        ASSIGN 
        np_weight  = sic_exp.uwm301.Tons     
        np_cc      = STRING(sic_exp.uwm301.engine) 
        np_body    = sic_exp.uwm301.body
        np_garage  = sic_exp.uwm301.garage  
        np_brand   = IF INDEX(sic_exp.uwm301.moddes," ") = 0 THEN sic_exp.uwm301.moddes
                     ELSE substr(sic_exp.uwm301.moddes,1,INDEX(sic_exp.uwm301.moddes," ") - 1 )
        np_model   = IF INDEX(sic_exp.uwm301.moddes," ") = 0 THEN sic_exp.uwm301.moddes
                     ELSE substr(sic_exp.uwm301.moddes,INDEX(sic_exp.uwm301.moddes," ") + 1 )
        np_redbook = sic_exp.uwm301.modcod     /*redbook     */                                            
        np_cargrp  = sic_exp.uwm301.vehgrp     /*กลุ่มรถยนต์ */ 
        np_vehuse  = sic_exp.uwm301.vehuse                                                                   
        np_caryear = string(sic_exp.uwm301.yrmanu )   /*รุ่นปี*/
        np_covcod  = sic_exp.uwm301.covcod                                                            
        np_seat    = string(sic_exp.uwm301.seats)             /*จำนวนที่นั่ง*/ 
        np_seat41  = sic_exp.uwm301.mv41seat      
        np_benname = sic_exp.uwm301.mv_ben83    . 
    FOR EACH sic_exp.uwd132 USE-INDEX uwd13290  WHERE
        sic_exp.uwd132.policy   = sic_exp.uwm301.policy  AND
        sic_exp.uwd132.rencnt   = sic_exp.uwm301.rencnt  AND
        sic_exp.uwd132.endcnt   = sic_exp.uwm301.endcnt  AND
        sic_exp.uwd132.riskno   = sic_exp.uwm301.riskno  AND
        sic_exp.uwd132.itemno   = sic_exp.uwm301.itemno  NO-LOCK .
        IF sic_exp.uwd132.bencod                = "411" THEN
            ASSIGN   np_41  = deci(SUBSTRING(sic_exp.uwd132.benvar,31,30)).  
        ELSE IF sic_exp.uwd132.bencod           = "42" THEN
            ASSIGN   np_42   =  deci(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod                = "43" THEN
            ASSIGN   np_43   =  deci(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod                = "base" THEN
            ASSIGN   np_baseprm = SUBSTRING(sic_exp.uwd132.benvar,31,30).
        ELSE IF sic_exp.uwd132.bencod                = "ncb" THEN
            ASSIGN   np_nv_ncbper   = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        
        ELSE IF sic_exp.uwd132.bencod                = "DOD" THEN
            ASSIGN   np_dod1 = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).

        ELSE IF sic_exp.uwd132.bencod                = "DOD2" THEN
            ASSIGN   np_dod2 = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).

        ELSE IF sic_exp.uwd132.bencod                = "DPD" THEN
            ASSIGN   np_ded = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).

        ELSE IF sic_exp.uwd132.bencod                = "FLET" THEN
            ASSIGN   np_nv_flet_per = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).

        ELSE IF sic_exp.uwd132.bencod                = "DSPC" THEN
            ASSIGN   np_nv_dss_per = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).

        ELSE IF index(sic_exp.uwd132.bencod,"cl") <> 0  THEN
            ASSIGN   np_cl_per = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)). 

        ELSE IF sic_exp.uwd132.bencod                = "DSTF" THEN
            ASSIGN   nv_stf_per = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)). 
        /* create by : A64-0138...*/
        IF sic_exp.uwd132.bencod <> "comp"  THEN DO:
            n_premt = n_premt + sic_exp.uwd132.prem_c.
        END.
        /*...end A64-0138..*/
    END.
END.  
