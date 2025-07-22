/* wgwtilexp.P  : Load Text file BU2 (ข้อมูลกรมธรรม์เดิม)                    */
/* Copyright   : Safety Insurance Public Company Limited                    */
/*               บริษัท ประกันคุ้มภัย จำกัด (มหาชน)                         */
/* Duppicate from  : wgwsaex1.p    Kridtiya i.                              */             
/* Modify by      : Ranu i.  A59-0060  Date : 25/02/2016                    */
/*                : รับค่าข้อมูลกรมธรรม์เดิม                                */ 
/*Modify by      : Ranu I. A62-0422 date:10/09/2019 เก็บค่าวันที่หมดอายุ    */   
/*modify by      : Kridtiya i. A63-00472 เพิ่มการรับค่า Producer ,dealer    */  
/*Modify by      : Ranu I. A66-0252 เพิ่มการเก็บค่า Model year , Chassic    */  
/*Modify by      : Kridtiya i. A68-0019 เพิ่ม การเช็ครุ่นรถ                 */  
/* ------------------------------------------------------------------------ */
DEFINE INPUT-OUTPUT  PARAMETER np_prepol      AS CHAR FORMAT "x(16)".
DEFINE INPUT-OUTPUT  PARAMETER np_branch      AS CHAR FORMAT "x(10)" .
DEFINE INPUT-OUTPUT  PARAMETER np_producerold AS CHAR FORMAT "x(20)" .
DEFINE INPUT-OUTPUT  PARAMETER np_deakerikd   AS CHAR FORMAT "x(20)" .
DEFINE INPUT-OUTPUT  PARAMETER np_class       AS CHAR FORMAT "x(10)" . 
DEFINE INPUT-OUTPUT  PARAMETER np_covcod      AS CHAR FORMAT "x(10)"      INIT "" . 
DEFINE INPUT-OUTPUT  PARAMETER np_si          AS CHAR FORMAT ">>>,>>>,>>9.99-"  .
DEFINE INPUT-OUTPUT  PARAMETER np_prem        AS DECI FORMAT ">>>,>>>,>>9.99-"  . 
DEFINE INPUT-OUTPUT  PARAMETER np_expdat      AS DATE FORMAT "99/99/9999"  .  /*A62-0422*/
DEFINE INPUT-OUTPUT  PARAMETER np_year        AS CHAR FORMAT "x(5)" .    /*A66-0252*/
DEFINE INPUT-OUTPUT  PARAMETER np_chassic     AS CHAR FORMAT "x(35)" .   /*A66-0252*/
DEFINE INPUT-OUTPUT  PARAMETER np_rencnt      AS INTE INIT 0 .   /*A66-0252*/
DEFINE INPUT-OUTPUT  PARAMETER np_model       AS CHAR FORMAT "x(100)" .  /*A68-0019*/
DEF VAR nv_comp AS DECI FORMAT ">>>,>>>,>>9.99-"  . 
  
FIND LAST sic_exp.uwm100 USE-INDEX uwm10001 WHERE
    sic_exp.uwm100.policy = np_prepol   NO-LOCK NO-ERROR NO-WAIT.
IF AVAILABLE sic_exp.uwm100 THEN DO:
    ASSIGN np_expdat   = sic_exp.uwm100.expdat   /*a62-0422*/
        np_producerold = trim(uwm100.acno1)
        np_deakerikd   = trim(uwm100.finint)
        np_rencnt      = uwm100.rencnt .        /*A66-0252*/

    FIND FIRST  sic_exp.uwm120 USE-INDEX uwm12001        WHERE
        sic_exp.uwm120.policy  = sic_exp.uwm100.policy   AND
        sic_exp.uwm120.rencnt  = sic_exp.uwm100.rencnt   AND
        sic_exp.uwm120.endcnt  = sic_exp.uwm100.endcnt   NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sic_exp.uwm120 THEN
        ASSIGN np_class  = trim(sic_exp.uwm120.CLASS).

    FIND LAST sic_exp.uwm301 USE-INDEX uwm30101       WHERE
        sic_exp.uwm301.policy = sic_exp.uwm100.policy AND
        sic_exp.uwm301.rencnt = sic_exp.uwm100.rencnt AND
        sic_exp.uwm301.endcnt = sic_exp.uwm100.endcnt NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL uwm301 THEN DO:
        ASSIGN np_covcod     = trim(sic_exp.uwm301.covcod)
               np_year       = trim(string(sic_exp.uwm301.yrmanu,"9999"))   /*A66-0252*/
               np_chassic    = trim(sic_exp.uwm301.cha_no)   /*A66-0252*/
               np_model      = trim(sic_exp.uwm301.moddes).  /*A68-0019*/

        FIND LAST sic_exp.uwm130 USE-INDEX uwm13002         WHERE
            sic_exp.uwm130.policy = sic_exp.uwm301.policy   AND
            sic_exp.uwm130.rencnt = sic_exp.uwm301.rencnt   AND
            sic_exp.uwm130.endcnt = sic_exp.uwm301.endcnt   AND
            sic_exp.uwm130.riskno = sic_exp.uwm301.riskno   AND
            sic_exp.uwm130.itemno = sic_exp.uwm301.itemno   NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sic_exp.uwm130  THEN
            ASSIGN np_si     = string(sic_exp.uwm130.uom6_v).

        FOR EACH sic_exp.uwd132 USE-INDEX uwd13290  WHERE
            sic_exp.uwd132.policy   = sic_exp.uwm301.policy  AND
            sic_exp.uwd132.rencnt   = sic_exp.uwm301.rencnt  AND
            sic_exp.uwd132.endcnt   = sic_exp.uwm301.endcnt  AND
            sic_exp.uwd132.riskno   = sic_exp.uwm301.riskno  AND
            sic_exp.uwd132.itemno   = sic_exp.uwm301.itemno  NO-LOCK .
           
            IF sic_exp.uwd132.bencod = "COMP"  THEN ASSIGN  nv_comp = sic_exp.uwd132.gap_c.
            ASSIGN  np_prem = np_prem + sic_exp.uwd132.gap_c .
        END.
        IF nv_comp <> 0 THEN ASSIGN np_prem = np_prem - nv_comp .
    END.
END. 
RELEASE sic_exp.uwd132.
RELEASE sic_exp.uwm130.
RELEASE sic_exp.uwm301.
RELEASE sic_exp.uwm120.
RELEASE sic_exp.uwm100.
                                                                                 
