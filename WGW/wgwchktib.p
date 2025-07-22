/* wgwbu2ex.P  : Load Text file BU2 (ข้อมูลกรมธรรม์เดิม)                                */  
/* Copyright   : Safety Insurance Public Company Limited                                */  
/*             บริษัท ประกันคุ้มภัย จำกัด (มหาชน)                                       */  
/* program name : wgwchktib.p  Get Data Expiry                                          */             
/* create by   : Ranu i.  A67-0222                                                      */  
/*             : รับค่าข้อมูลกรมธรรม์เดิมของ TIB                                        */  
/* ------------------------------------------------------------------------------------ */
DEFINE INPUT-OUTPUT  PARAMETER np_prepol    AS CHAR FORMAT "x(16)"  .
DEFINE INPUT-OUTPUT  PARAMETER np_branch    AS CHAR FORMAT "x(2)"  init "" .
define input-output  parameter np_agent     as char format "x(10)" init "" . 
define input-output  parameter np_producer  as char format "x(10)" init "" . 
define input-output  parameter np_delercode as char format "x(10)" init "" . 
define input-output  parameter np_fincode   as char format "x(10)" init "" . 
define input-output  parameter np_payercod  as char format "x(10)" init "" . 
define input-output  parameter np_vatcode   as char format "x(10)" init "" . 
DEFINE INPUT-OUTPUT  PARAMETER np_name2     AS CHAR FORMAT "x(60)" init "" . 
DEFINE INPUT-OUTPUT  PARAMETER np_name3     AS CHAR FORMAT "x(60)" init "" . 
DEFINE INPUT-OUTPUT  PARAMETER np_firstdat  AS CHAR FORMAT "x(10)" INIT "" .
DEFINE INPUT-OUTPUT  PARAMETER np_comdat    AS CHAR FORMAT "x(10)" INIT "" . 
DEFINE INPUT-OUTPUT  PARAMETER np_expdat    AS CHAR FORMAT "x(10)" INIT "" .
DEFINE INPUT-OUTPUT  PARAMETER np_class     AS CHAR FORMAT "x(5)"  init "" . 
DEFINE INPUT-OUTPUT  PARAMETER np_moddes    AS CHAR FORMAT "x(65)" init "" .
DEFINE INPUT-OUTPUT  PARAMETER np_yrmanu    AS CHAR FORMAT "x(5)"  init "" . 
DEFINE INPUT-OUTPUT  PARAMETER np_covcod    AS CHAR FORMAT "x(3)"   INIT "" .
DEFINE INPUT-OUTPUT  PARAMETER np_garage    AS CHAR FORMAT "x"      INIT "" .
DEFINE INPUT-OUTPUT  PARAMETER np_vehuse    AS CHAR FORMAT "x"      INIT "" . 
DEFINE INPUT-OUTPUT  PARAMETER np_vehreg    AS CHAR FORMAT "x(11)"  INIT "" .
DEFINE INPUT-OUTPUT  PARAMETER np_cha_no    AS CHAR FORMAT "x(30)"  .
DEFINE INPUT-OUTPUT  PARAMETER np_eng_no     AS CHAR FORMAT "x(50)"  INIT "" .
DEFINE INPUT-OUTPUT  PARAMETER np_insp      AS CHAR FORMAT "x(5)"  INIT "" .
DEFINE INPUT-OUTPUT  PARAMETER np_colors    AS CHAR FORMAT "x(10)"  INIT "" .
DEFINE INPUT-OUTPUT  PARAMETER np_si        AS CHAR FORMAT "x(30)"  INIT "" .
DEFINE INPUT-OUTPUT  PARAMETER np_premt     AS DECI FORMAT ">>,>>>,>>9.99-" . 
DEFINE INPUT-OUTPUT  PARAMETER np_prmtxt    AS CHAR    FORMAT "x(250)"  INIT "" .
DEFINE INPUT-OUTPUT  PARAMETER np_chk       AS CHAR FORMAT "x(10)"  init ""  .
DEFINE INPUT-OUTPUT  PARAMETER np_loss      AS CHAR FORMAT "x(50)"  INIT "" .         
DEFINE INPUT-OUTPUT  PARAMETER np_promo     AS CHAR FORMAT "x(15)" INIT "" .
DEFINE INPUT-OUTPUT  PARAMETER np_product   AS CHAR FORMAT "x(15)" INIT ""  .
DEFINE INPUT-OUTPUT  PARAMETER np_campno    AS CHAR FORMAT "x(15)" INIT "" .
DEFINE INPUT-OUTPUT  PARAMETER np_comment   AS CHAR FORMAT "x(350)" init ""  .

DO:

    Find LAST sic_exp.uwm100 Use-index uwm10001   Where
       sic_exp.uwm100.policy = trim(np_prepol)    No-lock no-error no-wait.
    IF AVAILABLE sic_exp.uwm100 THEN DO:
      FIND FIRST  sic_exp.uwm120 USE-INDEX uwm12001        WHERE
          sic_exp.uwm120.policy  = sic_exp.uwm100.policy   AND
          sic_exp.uwm120.rencnt  = sic_exp.uwm100.rencnt   AND
          sic_exp.uwm120.endcnt  = sic_exp.uwm100.endcnt   NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL sic_exp.uwm120 THEN 
          ASSIGN 
          /*np_prepol    = TRIM(sic_exp.uwm100.policy)*/
          np_branch    = TRIM(sic_exp.uwm100.branch)
          np_agent     = trim(sic_exp.uwm100.agent)
          np_producer  = trim(sic_exp.uwm100.acno1)
          np_delercode = trim(sic_exp.uwm100.finint)
          np_fincode   = trim(sic_exp.uwm100.dealer)
          np_payercod  = trim(sic_exp.uwm100.payer)  
          np_vatcode   = trim(sic_exp.uwm100.bs_cd)  
          np_name2     = TRIM(sic_exp.uwm100.name2)   
          np_name3     = TRIM(sic_exp.uwm100.name3)   
          np_firstdat  = string(sic_exp.uwm100.fstdat,"99/99/9999") 
          np_comdat    = string(sic_exp.uwm100.expdat,"99/99/9999") 
          np_expdat    = IF (string(day(sic_exp.uwm100.expdat),"99")   = "29" ) AND 
                            (STRING(MONTH(sic_exp.uwm100.expdat),"99") = "02" ) THEN 
                             string(date("01/03/" + STRING(YEAR(sic_exp.uwm100.expdat) + 1,"9999")),"99/99/9999")  
                         ELSE string(day(sic_exp.uwm100.expdat),"99") + "/" +  
                              STRING(MONTH(sic_exp.uwm100.expdat),"99") + "/" +  
                              STRING(YEAR(sic_exp.uwm100.expdat) + 1 ,"9999") 
          np_class      =  sic_exp.uwm120.class 
          np_product    =  sic_exp.uwm100.cr_1       /*product*/       
          np_promo      =  sic_exp.uwm100.opnpol     /*promo */ 
          np_campno     =  sic_exp.uwm100.campaign . /*campano */
      
      FIND LAST sic_exp.uwm301 USE-INDEX uwm30101       WHERE
          sic_exp.uwm301.policy = sic_exp.uwm100.policy AND
          sic_exp.uwm301.rencnt = sic_exp.uwm100.rencnt AND
          sic_exp.uwm301.endcnt = sic_exp.uwm100.endcnt NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL uwm301 THEN DO:
          ASSIGN 
              np_chk        = STRING(sic_exp.uwm301.itmdel)  /* adj y/n */
              np_moddes     = trim(sic_exp.uwm301.moddes)          /* redbook  */                                            
              np_yrmanu     = string(sic_exp.uwm301.yrmanu) 
              np_covcod     = trim(sic_exp.uwm301.covcod)       
              np_garage     = trim(sic_exp.uwm301.garage)
              np_vehuse     = trim(sic_exp.uwm301.vehuse) 
              np_vehreg     = trim(sic_exp.uwm301.vehreg)    
              np_cha_no     = trim(sic_exp.uwm301.cha_no)  
              np_eng_no     = trim(sic_exp.uwm301.eng_no)
              np_insp       = trim(sic_exp.uwm301.logbok)     
              np_colors     = trim(sic_exp.uwm301.car_color)    
              np_prmtxt     = trim(sic_exp.uwm301.prmtxt) .
             
          FIND LAST sic_exp.uwm130 USE-INDEX uwm13002         WHERE
              sic_exp.uwm130.policy = sic_exp.uwm301.policy   AND
              sic_exp.uwm130.rencnt = sic_exp.uwm301.rencnt   AND
              sic_exp.uwm130.endcnt = sic_exp.uwm301.endcnt   AND
              sic_exp.uwm130.riskno = sic_exp.uwm301.riskno   AND
              sic_exp.uwm130.itemno = sic_exp.uwm301.itemno   NO-LOCK NO-ERROR NO-WAIT.
          IF AVAIL sic_exp.uwm130  THEN DO:
              ASSIGN 
                  np_si   = IF np_covcod = "2" THEN string(sic_exp.uwm130.uom7_v) ELSE string(sic_exp.uwm130.uom6_v) 
                  np_loss = IF index(sic_exp.uwm130.styp20,"L/R") <> 0  THEN SUBSTR(sic_exp.uwm130.styp20,1,INDEX(sic_exp.uwm130.styp20,"%") - 1) ELSE "" 
                  np_loss = IF np_loss <> "" AND INDEX(np_loss,"L/R") <> 0  THEN trim(REPLACE(np_loss,"L/R","")) ELSE "".
          END.

          FOR EACH sic_exp.uwd132 USE-INDEX uwd13290  WHERE
              sic_exp.uwd132.policy   = sic_exp.uwm301.policy  AND
              sic_exp.uwd132.rencnt   = sic_exp.uwm301.rencnt  AND
              sic_exp.uwd132.endcnt   = sic_exp.uwm301.endcnt  AND
              sic_exp.uwd132.riskno   = sic_exp.uwm301.riskno  AND
              sic_exp.uwd132.itemno   = sic_exp.uwm301.itemno  NO-LOCK .
              IF sic_exp.uwd132.bencod <> "COMP"  THEN DO:
                  np_premt = np_premt + sic_exp.uwd132.prem_c .
              END.
          END.
      END. /* if avail uwm301*/
    END. /* if avail uwm100*/
    ELSE DO:
        ASSIGN np_comment = np_comment + "/ ไม่พบกรมธรรม์ของเลขตัวถัง " + np_cha_no + " ในระบบใบเตือน " .
    END.
   

END.
                                                                                     
