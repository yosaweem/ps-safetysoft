/* wgwexpay.P  -- Load Text file AYCAL to gw                           */
/* Copyright   # Safety Insurance Public Company Limited                    */
/*               บริษัท ประกันคุ้มภัย จำกัด (มหาชน)                         */
/* WRITE  BY   : Ranu i. A61-0573 Data 06/04/2019                       */
/*             : ส่วนการค้นหาค่า งานต่ออายุเพื่อให้ค่า กรมธรรม์ต่ออายุใหม่  */
/* Modify by : Ranu I. A67-0162 เพิ่มเงื่อนไขการเก็บข้อมูลรถไฟฟ้า  */
/* ------------------------------------------------------------------------ */
DEFINE INPUT-OUTPUT  PARAMETER n_prepol     AS CHAR FORMAT "x(12)" INIT "".    /*wdetail.prepol   */         
DEFINE INPUT-OUTPUT  PARAMETER n_branch     AS CHAR FORMAT "x(2)"  INIT "".    /*wdetail2.branch  */     
DEFINE INPUT-OUTPUT  PARAMETER n_prempa     AS CHAR FORMAT "x"     INIT "".    /*wdetail2.prempa  */     
DEFINE INPUT-OUTPUT  PARAMETER n_subclass   AS CHAR FORMAT "x(3)"  INIT "".    /*wdetail2.subclass*/   
DEFINE INPUT-OUTPUT  PARAMETER n_redbook    AS CHAR FORMAT "x(10)" INIT "".    /*wdetail2.redbook */      
DEFINE INPUT-OUTPUT  PARAMETER n_brand      AS CHAR FORMAT "x(30)" INIT "".    /*wdetail.         */          
DEFINE INPUT-OUTPUT  PARAMETER n_model      AS CHAR FORMAT "x(40)" INIT "".    /*wdetail.model    */          
DEFINE INPUT-OUTPUT  PARAMETER n_caryear    AS CHAR FORMAT "x(4)"  INIT "".    /*wdetail.caryear  */        
DEFINE INPUT-OUTPUT  PARAMETER n_cargrp     AS CHAR FORMAT "x(2)"  INIT "".    /*wdetail.cargrp   */         
DEFINE INPUT-OUTPUT  PARAMETER n_engcc      AS CHAR FORMAT "x(10)" INIT "".    /*wdetail.cargrp   */         
DEFINE INPUT-OUTPUT  PARAMETER n_tonns      AS DECI  INIT 0 .                   /*wdetail.cargrp   */       
DEFINE INPUT-OUTPUT  PARAMETER n_bodys      AS CHAR FORMAT "x(20)" INIT "".    /*wdetail.cargrp   */         
DEFINE INPUT-OUTPUT  PARAMETER n_vehuse     AS CHAR FORMAT "x(2)"  INIT "".    /*wdetail.vehuse   */         
DEFINE INPUT-OUTPUT  PARAMETER n_covcod     AS CHAR FORMAT "x(30)" INIT "".    /*wdetail.covcod   */      
DEFINE INPUT-OUTPUT  PARAMETER n_garage     AS CHAR FORMAT "x"     INIT "".            
DEFINE INPUT-OUTPUT  PARAMETER n_tp1        AS CHAR FORMAT "x(30)" INIT "".    /*wdetail.chasno   */         
DEFINE INPUT-OUTPUT  PARAMETER n_tp2        AS CHAR FORMAT "x(30)" INIT "".    /*wdetail.chasno   */         
DEFINE INPUT-OUTPUT  PARAMETER n_tp3        AS CHAR FORMAT "x(30)" INIT "".    /*wdetail.chasno   */         
DEFINE INPUT-OUTPUT  PARAMETER nv_basere    AS DECI INIT 0.                    /*nv_basere        */            
DEFINE INPUT-OUTPUT  PARAMETER n_seat       AS INTE INIT 0.                    /*wdetail.seat     */           
DEFINE INPUT-OUTPUT  PARAMETER nv_seat41    AS INTE INIT 0.                    /*wdetail.seat     */           
DEFINE INPUT-OUTPUT  PARAMETER n_41         AS DECI INIT 0.                    /*n_41             */                  
DEFINE INPUT-OUTPUT  PARAMETER n_42         AS DECI INIT 0.                    /*n_42             */                   
DEFINE INPUT-OUTPUT  PARAMETER n_43         AS DECI INIT 0.                    /*n_43             */                  
DEFINE INPUT-OUTPUT  PARAMETER n_dod        AS DECI INIT 0.                    /*n_41             */                  
DEFINE INPUT-OUTPUT  PARAMETER n_dod2       AS DECI INIT 0.                    /*n_42             */                   
DEFINE INPUT-OUTPUT  PARAMETER n_pd         AS DECI INIT 0.                    /*n_43             */                  
DEFINE INPUT-OUTPUT  PARAMETER n_feet       AS DECI INIT 0.                    /*n_41             */                  
DEFINE INPUT-OUTPUT  PARAMETER nv_dss_per   AS DECI INIT 0.                    /*nv_dss_per       */             
DEFINE INPUT-OUTPUT  PARAMETER n_ncb        AS DECI INIT 0.                    /*n_42             */                   
DEFINE INPUT-OUTPUT  PARAMETER n_lcd        AS DECI INIT 0.                    /*n_43             */
DEFINE INPUT-OUTPUT  PARAMETER n_gapprm     AS DECI INIT 0.
DEFINE INPUT-OUTPUT  PARAMETER n_si         AS DECI INIT 0.
DEFINE INPUT-OUTPUT  PARAMETER n_fi         AS DECI INIT 0.
DEFINE INPUT-OUTPUT  PARAMETER n_firstdat   AS CHAR FORMAT "99/99/9999"    . 
DEFINE INPUT-OUTPUT  PARAMETER nv_driver    AS CHARACTER FORMAT "X(23)" INITIAL "" NO-UNDO.
DEFINE INPUT-OUTPUT  PARAMETER n_prmtxt    AS CHAR    FORMAT "x(100)" .
DEFINE INPUT-OUTPUT  PARAMETER np_hp        AS DECI FORMAT ">>>>9.99".        /* A67-0162 */
def    input-output  parameter np_maksi     AS DECI FORMAT ">>,>>>,>>9.99-" . /* A67-0162 */
def    input-output  parameter np_eng_no2   AS CHAR FORMAT "x(50)" INIT "" .  /* A67-0162 */
DEF    INPUT-OUTPUT  PARAMETER np_battyr    AS INTE FORMAT "9999" INIT 0.     /* A67-0162 */

DEFINE SHARED WORKFILE ws0m009 NO-UNDO
/*1*/  FIELD policy     AS CHARACTER    INITIAL ""  
/*2*/  FIELD lnumber    AS INTEGER   
       FIELD ltext      AS CHARACTER    INITIAL "" 
       FIELD ltext2     AS CHARACTER    INITIAL "" 
     /* add by : A67-0162 */ 
       FIELD drivbirth  AS date init ?
       FIELD drivage    AS inte init 0
       FIELD occupcod   AS char format "x(10)" 
       FIELD occupdes   AS char format "x(60)" 
       FIELD cardflg    AS char format "x(3) " 
       FIELD drividno   AS char format "x(30)" 
       FIELD licenno    AS char format "x(30)" 
       FIELD drivnam    AS char format "x(120)" 
       FIELD gender     AS char format "x(15)" 
       FIELD drivlevel  AS inte init 0   
       FIELD levelper   AS deci init 0   
       FIELD titlenam   AS char FORMAT "x(40)"
       FIELD licenexp   AS date INIT ?
       FIELD firstnam   AS char format "x(60)"
       FIELD lastnam    AS char format "x(60)" 
       FIELD dconsen    AS LOGICAL FORMAT NO .
       /* end A67-0162 */ 
ASSIGN nv_driver = "".
FIND LAST sic_exp.uwm100  WHERE sic_exp.uwm100.policy = n_prepol   NO-LOCK NO-ERROR NO-WAIT.
IF AVAILABLE sic_exp.uwm100 THEN DO:
    FIND LAST  sic_exp.uwm130 USE-INDEX uwm13001 WHERE
        sic_exp.uwm130.policy = sic_exp.uwm100.policy AND
        sic_exp.uwm130.rencnt = sic_exp.uwm100.rencnt AND
        sic_exp.uwm130.endcnt = sic_exp.uwm100.endcnt NO-LOCK NO-WAIT NO-ERROR. 
    IF  AVAILABLE sic_exp.uwm130 THEN 
        ASSIGN 
        nv_driver =   TRIM(sic_exp.uwm130.policy) +
                    STRING(sic_exp.uwm130.rencnt,"99" ) +
                    STRING(sic_exp.uwm130.endcnt,"999")  +
                    STRING(sic_exp.uwm130.riskno,"999") +
                    STRING(sic_exp.uwm130.itemno,"999")
        n_tp1     = string(sic_exp.uwm130.uom1_v)  
        n_tp2     = string(sic_exp.uwm130.uom2_v)  
        n_tp3     = string(sic_exp.uwm130.uom5_v)
        n_si      = sic_exp.uwm130.uom6_v
        n_fi      = sic_exp.uwm130.uom7_v . 
    FIND FIRST  sic_exp.uwm120 USE-INDEX uwm12001       WHERE
        sic_exp.uwm120.policy  = sic_exp.uwm100.policy  AND
        sic_exp.uwm120.rencnt  = sic_exp.uwm100.rencnt  AND
        sic_exp.uwm120.endcnt  = sic_exp.uwm100.endcnt  NO-LOCK NO-ERROR NO-WAIT.  
    IF AVAIL sic_exp.uwm120 THEN
        ASSIGN 
        n_firstdat = string(sic_exp.uwm100.fstdat)
        n_branch   = caps(trim(sic_exp.uwm100.branch))
        n_prempa   = substring(sic_exp.uwm120.class,1,1)
        n_subclass = substring(sic_exp.uwm120.class,2,3).
    FIND LAST sic_exp.uwm301 USE-INDEX uwm30101      WHERE
        sic_exp.uwm301.policy = sic_exp.uwm100.policy    AND
        sic_exp.uwm301.rencnt = sic_exp.uwm100.rencnt    AND
        sic_exp.uwm301.endcnt = sic_exp.uwm100.endcnt    NO-LOCK NO-ERROR NO-WAIT.   /* A56-0146 */  
    IF AVAIL sic_exp.uwm301 THEN
        ASSIGN 
        n_tonns    = sic_exp.uwm301.Tons             /*A59-0618 */
        n_engcc    = STRING(sic_exp.uwm301.engine) 
        n_bodys    = sic_exp.uwm301.body
        n_garage   = sic_exp.uwm301.garage  
        n_brand    = substr(sic_exp.uwm301.moddes,1,INDEX(sic_exp.uwm301.moddes," ") - 1 )
        n_model    = substr(sic_exp.uwm301.moddes,INDEX(sic_exp.uwm301.moddes," ") + 1 )
        n_redbook  = sic_exp.uwm301.modcod     /*redbook     */                                            
        n_cargrp   = sic_exp.uwm301.vehgrp     /*กลุ่มรถยนต์ */ 
        n_vehuse   = sic_exp.uwm301.vehuse                                                                   
        n_caryear  = string(sic_exp.uwm301.yrmanu )   /*รุ่นปี*/
        n_covcod   = sic_exp.uwm301.covcod                                                            
        n_seat     = sic_exp.uwm301.seats             /*จำนวนที่นั่ง*/ 
        nv_seat41  = sic_exp.uwm301.mv41seat    
        n_prmtxt   = trim(sic_exp.uwm301.prmtxt)       /*A57-0017  add F6 text accesory */
        /* A67-0162 */
        np_hp      = deci(sic_exp.uwm301.watts)     
        np_maksi   = sic_exp.uwm301.maksi            
        np_eng_no2 = TRIM(sic_exp.uwm301.eng_no2)    
        np_battyr  = sic_exp.uwm301.battyr .
       /* end : A67-0162 */

    FOR EACH sic_exp.uwd132 USE-INDEX uwd13290  WHERE
        sic_exp.uwd132.policy   = sic_exp.uwm301.policy  AND
        sic_exp.uwd132.rencnt   = sic_exp.uwm301.rencnt  AND
        sic_exp.uwd132.endcnt   = sic_exp.uwm301.endcnt  AND
        sic_exp.uwd132.riskno   = sic_exp.uwm301.riskno  AND
        sic_exp.uwd132.itemno   = sic_exp.uwm301.itemno  NO-LOCK .
        IF sic_exp.uwd132.bencod                = "411" THEN
            ASSIGN   n_41   = deci(SUBSTRING(sic_exp.uwd132.benvar,31,30)).  
        ELSE IF sic_exp.uwd132.bencod           = "42" THEN
            ASSIGN   n_42   =  deci(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod                = "43" THEN
            ASSIGN   n_43   =  deci(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod                = "base" THEN
            ASSIGN   nv_basere = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod                = "dspc" THEN
            ASSIGN   nv_dss_per = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod                = "ncb" THEN
            ASSIGN   n_NCB = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod                = "DOD" THEN
            ASSIGN   n_dod = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod                = "DOD2" THEN
            ASSIGN   n_dod2 = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod                = "DPD" THEN
            ASSIGN   n_pd = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod                = "FLET" THEN
            ASSIGN   n_feet = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod                = "DSPC" THEN
            ASSIGN   nv_dss_per = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF index(sic_exp.uwd132.bencod,"cl") <> 0  THEN
            ASSIGN   n_lcd = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).

        IF sic_exp.uwd132.bencod <> "comp"  THEN DO:
           n_gapprm = n_gapprm + sic_exp.uwd132.prem_c.
        END.
    END.
    /* comment by : A67-0162 
    FIND FIRST sic_exp.s0m009 WHERE 
        sic_exp.s0m009.key1  = nv_driver  AND
        INTEGER(sic_exp.s0m009.noseq) = 1  NO-LOCK NO-ERROR NO-WAIT.
    IF AVAILABLE sic_exp.s0m009 THEN DO:
        FOR EACH sic_exp.s0m009  /* USE-INDEX mailtxt01 */ WHERE
            sic_exp.s0m009.key1 = nv_driver  NO-LOCK.
            CREATE ws0m009.
            ASSIGN
                ws0m009.policy  = nv_driver    /* sic_bran.s0m009.key1 */
                ws0m009.lnumber = INTEGER(sic_exp.s0m009.noseq)
                ws0m009.ltext   = sic_exp.s0m009.fld1
                ws0m009.ltext2  = sic_exp.s0m009.fld2.
        END.
    END.
    ..end A67-0162..*/
    /* add by : A67-0162 */
    FOR EACH sic_exp.s0m009 WHERE sic_exp.s0m009.key1  = nv_driver   NO-LOCK .
        CREATE ws0m009.
        ASSIGN
               ws0m009.policy      = nv_driver    /* sic_bran.s0m009.key1 */
               ws0m009.lnumber     = INTEGER(sic_exp.s0m009.NOSEQ)
               ws0m009.ltext       = trim(sic_exp.s0m009.ltext)
               ws0m009.ltext2      = trim(sic_exp.s0m009.ltext2)
               ws0m009.drivbirth   = sic_exp.s0m009.drivbirth
               ws0m009.drivage     = sic_exp.s0m009.drivage    
               ws0m009.occupcod    = trim(sic_exp.s0m009.occupcod)   
               ws0m009.occupdes    = trim(sic_exp.s0m009.occupdes)   
               ws0m009.cardflg     = sic_exp.s0m009.cardflg   
               ws0m009.drividno    = trim(sic_exp.s0m009.drividno)   
               ws0m009.licenno     = trim(sic_exp.s0m009.licenno)   
               ws0m009.drivnam     = trim(sic_exp.s0m009.drivnam)   
               ws0m009.gender      = trim(sic_exp.s0m009.gender )   
               ws0m009.drivlevel   = sic_exp.s0m009.drivlevel
               ws0m009.levelper    = sic_exp.s0m009.levelper  
               ws0m009.titlenam    = trim(sic_exp.s0m009.titlenam)  
               ws0m009.licenexp    = sic_exp.s0m009.licenexp  
               ws0m009.firstnam    = trim(sic_exp.s0m009.firstnam)  
               ws0m009.lastnam     = trim(sic_exp.s0m009.lastnam ) 
               ws0m009.dconsen     = sic_exp.s0m009.dconsen .
    END.
    /* end : A67-0162 */
END. 
                                  
                                 
                                    
                                 
                             
                                 
                             
