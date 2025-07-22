/* wgwsaexp.P  -- Load Text file .............                              */
/* Copyright   # Safety Insurance Public Company Limited                    */
/*               บริษัท ประกันคุ้มภัย จำกัด (มหาชน)                         */
/* WRITE  BY   : Kridtiya i.A54-0011  10/01/2011                            */
/*             : ส่วนการค้นหาค่า งานต่ออายุเพื่อให้ค่า กรมธรรม์ต่ออายุใหม่  */
/* modify By   : Kridtiya i. A56-0151  เพิ่ม คำสั่ง no-lock add F6,F15,F17  */
/* modify By   : Ranu i. A64-0138 เพิ่มเงื่อนไขการเก็บเบี้ยสุทธิ            */
/* ------------------------------------------------------------------------ */
DEFINE INPUT-OUTPUT  PARAMETER n_prepol     AS CHAR FORMAT "x(15)" .
DEFINE INPUT-OUTPUT  PARAMETER n_cr2        AS CHAR FORMAT "x(15)".
DEFINE INPUT-OUTPUT  PARAMETER n_subclass   AS CHAR FORMAT "x(4)" .  
DEFINE INPUT-OUTPUT  PARAMETER n_covcod     AS CHAR FORMAT "x" .  
DEFINE INPUT-OUTPUT  PARAMETER n_garage     AS CHAR FORMAT "x" .  
DEFINE INPUT-OUTPUT  PARAMETER n_redbook    AS CHAR FORMAT "x(10)" .  
DEFINE INPUT-OUTPUT  PARAMETER n_brand      AS CHAR FORMAT "x(30)" INIT "" .
DEFINE INPUT-OUTPUT  PARAMETER n_model      AS CHAR FORMAT "x(50)" INIT "" .
DEFINE INPUT-OUTPUT  PARAMETER n_body       AS CHAR FORMAT "x(30)" INIT "" .
DEFINE INPUT-OUTPUT  PARAMETER n_engcc      AS CHAR FORMAT "x(5)"  INIT "" .
DEFINE INPUT-OUTPUT  PARAMETER n_tonn       AS DECI FORMAT ">>,>>9.99-" .  
DEFINE INPUT-OUTPUT  PARAMETER n_seat       AS CHAR FORMAT "x(2)"  .
DEFINE INPUT-OUTPUT  PARAMETER n_seat41     AS INTE FORMAT "99"  .
DEFINE INPUT-OUTPUT  PARAMETER n_cargrp     AS CHAR FORMAT "x"     .
DEFINE INPUT-OUTPUT  PARAMETER n_vehreg     AS CHAR FORMAT "x(10)".
DEFINE INPUT-OUTPUT  PARAMETER n_eng        AS CHAR FORMAT "x(25)".
DEFINE INPUT-OUTPUT  PARAMETER n_chasno     AS CHAR FORMAT "x(25)".   
DEFINE INPUT-OUTPUT  PARAMETER n_caryear    AS CHAR FORMAT "x(4)"  .
DEFINE INPUT-OUTPUT  PARAMETER n_vehuse     AS CHAR INIT "" FORMAT "x".  
DEFINE INPUT-OUTPUT  PARAMETER n_comdat     AS DATE FORMAT "99/99/9999".
DEFINE INPUT-OUTPUT  PARAMETER n_firstdat   AS DATE FORMAT "99/99/9999".
DEFINE INPUT-OUTPUT  PARAMETER n_premt      AS DECI FORMAT ">>>,>>>,>>9.99". /*A64-0138*/

DEFINE SHARED WORKFILE wacctext
    FIELD n_policytxt  AS CHAR  INIT "" FORMAT "x(100)"  /*Add kridtiya i. A56-0151*/
    FIELD n_textacc    AS CHAR  INIT "" FORMAT "x(100)"  /*Add kridtiya i. A56-0151*/
    FIELD n_textacc1   AS CHAR  INIT "" FORMAT "x(100)"  /*Add kridtiya i. A56-0151*/
    FIELD n_textacc2   AS CHAR  INIT "" FORMAT "x(100)"  /*Add kridtiya i. A56-0151*/
    FIELD n_textacc3   AS CHAR  INIT "" FORMAT "x(100)"  /*Add kridtiya i. A56-0151*/
    FIELD n_textacc4   AS CHAR  INIT "" FORMAT "x(100)"  /*Add kridtiya i. A56-0151*/
    FIELD n_textacc5   AS CHAR  INIT "" FORMAT "x(100)"  /*Add kridtiya i. A56-0151*/
    FIELD n_textacc6   AS CHAR  INIT "" FORMAT "x(100)"  /*Add kridtiya i. A56-0151*/
    FIELD n_textacc7   AS CHAR  INIT "" FORMAT "x(100)"  /*Add kridtiya i. A56-0151*/
    FIELD n_textacc8   AS CHAR  INIT "" FORMAT "x(100)"  /*Add kridtiya i. A56-0151*/ 
    FIELD n_textacc9   AS CHAR  INIT "" FORMAT "x(100)"  /*Add kridtiya i. A56-0151*/ .

FIND LAST sic_exp.uwm100 USE-INDEX uwm10001  WHERE
    sic_exp.uwm100.policy = n_prepol  NO-LOCK NO-ERROR NO-WAIT.
IF AVAILABLE sic_exp.uwm100 THEN DO:
    FIND FIRST  sic_exp.uwm120 USE-INDEX uwm12001        WHERE
        sic_exp.uwm120.policy  = sic_exp.uwm100.policy   AND
        sic_exp.uwm120.rencnt  = sic_exp.uwm100.rencnt   AND
        /*sic_exp.uwm120.endcnt  = sic_exp.uwm100.endcnt   NO-ERROR NO-WAIT.*/     /*A56-0151*/
        sic_exp.uwm120.endcnt  = sic_exp.uwm100.endcnt   NO-LOCK NO-ERROR NO-WAIT. /*A56-0151*/
    IF AVAIL sic_exp.uwm120 THEN
        ASSIGN 
        n_cr2        =  sic_exp.uwm100.cr_2
        n_comdat     =  sic_exp.uwm100.expdat
        n_firstdat   =  sic_exp.uwm100.fstdat 
        n_subclass   =  sic_exp.uwm120.class.
    FIND LAST sic_exp.uwm301 USE-INDEX uwm30101  WHERE
        sic_exp.uwm301.policy = sic_exp.uwm100.policy    AND
        sic_exp.uwm301.rencnt = sic_exp.uwm100.rencnt    AND
        /*sic_exp.uwm301.endcnt = sic_exp.uwm100.endcnt  NO-ERROR NO-WAIT.*/        /*A56-0151*/  
        sic_exp.uwm301.endcnt = sic_exp.uwm100.endcnt    NO-LOCK NO-ERROR NO-WAIT.  /*A56-0151*/  
    IF AVAIL uwm301 THEN DO:
        ASSIGN  
            n_redbook  = ""
            n_redbook  = sic_exp.uwm301.modcod          /* redbook  */                                            
            n_vehuse   = sic_exp.uwm301.vehuse                                                               
            n_covcod   = sic_exp.uwm301.covcod
            /*n_brand    = substr(sic_exp.uwm301.moddes,1,INDEX(sic_exp.uwm301.moddes," ") - 1 )  /*A56-0151*/   
            n_model    = substr(sic_exp.uwm301.moddes,INDEX(sic_exp.uwm301.moddes," ") + 1 ) */   /*A56-0151*/
            n_brand    = IF INDEX(sic_exp.uwm301.moddes," ") <> 0 THEN  substr(sic_exp.uwm301.moddes,1,INDEX(sic_exp.uwm301.moddes," ") - 1 )  /*A56-0151*/
                         ELSE TRIM(sic_exp.uwm301.moddes)                                                                                      /*A56-0151*/
            n_model    = IF INDEX(sic_exp.uwm301.moddes," ") <> 0 THEN  substr(sic_exp.uwm301.moddes,INDEX(sic_exp.uwm301.moddes," ") + 1 )    /*A56-0151*/
                         ELSE TRIM(sic_exp.uwm301.moddes)    /*A56-0151*/
            n_body     = sic_exp.uwm301.body
            n_engcc    = string(sic_exp.uwm301.engine)
            n_tonn     = sic_exp.uwm301.tons
            n_seat     = STRING(sic_exp.uwm301.seats) 
            n_seat41   = sic_exp.uwm301.mv41seat 
            n_cargrp   = sic_exp.uwm301.vehgrp
            n_vehreg   = sic_exp.uwm301.vehreg
            n_eng      = sic_exp.uwm301.eng_no
            n_chasno   = sic_exp.uwm301.cha_no
            n_caryear  = string(sic_exp.uwm301.yrmanu) . 
        FIND LAST  wacctext  WHERE wacctext.n_policytxt =  sic_exp.uwm100.policy   NO-ERROR NO-WAIT. 
        IF NOT AVAIL wacctext  THEN DO:
            CREATE wacctext.                /*add F6 by pol_master */
            ASSIGN 
                wacctext.n_policytxt = trim(sic_exp.uwm301.policy) 
                wacctext.n_textacc   = SUBSTRING(sic_exp.uwm301.prmtxt,1,60)    
                wacctext.n_textacc1  = SUBSTRING(sic_exp.uwm301.prmtxt,61,60)   
                wacctext.n_textacc2  = SUBSTRING(sic_exp.uwm301.prmtxt,121,60)  
                wacctext.n_textacc3  = SUBSTRING(sic_exp.uwm301.prmtxt,181,60)  
                wacctext.n_textacc4  = SUBSTRING(sic_exp.uwm301.prmtxt,241,60)  
                wacctext.n_textacc5  = SUBSTRING(sic_exp.uwm301.prmtxt,301,60)  
                wacctext.n_textacc6  = SUBSTRING(sic_exp.uwm301.prmtxt,361,60)  
                wacctext.n_textacc7  = SUBSTRING(sic_exp.uwm301.prmtxt,421,60)  
                wacctext.n_textacc8  = SUBSTRING(sic_exp.uwm301.prmtxt,481,60)  
                wacctext.n_textacc9  = SUBSTRING(sic_exp.uwm301.prmtxt,541,60). 
        END.
        /* create by : A64-0138...*/
        FOR EACH sic_exp.uwd132 USE-INDEX uwd13290  WHERE
            sic_exp.uwd132.policy   = sic_exp.uwm301.policy  AND
            sic_exp.uwd132.rencnt   = sic_exp.uwm301.rencnt  AND
            sic_exp.uwd132.endcnt   = sic_exp.uwm301.endcnt  AND
            sic_exp.uwd132.riskno   = sic_exp.uwm301.riskno  AND
            sic_exp.uwd132.itemno   = sic_exp.uwm301.itemno  NO-LOCK .
            IF sic_exp.uwd132.bencod <> "comp"  THEN DO:
                n_premt = n_premt + sic_exp.uwd132.prem_c.
            END.
        END.
        /*...end A64-0138..*/
    END. 
END. 
