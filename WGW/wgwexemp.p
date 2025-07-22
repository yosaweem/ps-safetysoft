/* wgwbu2ex.P  : Load Text file BU2 (ข้อมูลกรมธรรม์เดิม)                                */  
/* Copyright   : Safety Insurance Public Company Limited                                */  
/*             บริษัท ประกันคุ้มภัย จำกัด (มหาชน)                                       */  
/* Duppicate from  : wgwsaex1.p    Kridtiya i.                                          */             
/* Modify by   : Ranu i.  A59-0060  Date : 25/02/2016                                   */  
/*             : รับค่าข้อมูลกรมธรรม์เดิม                                               */  
/* Modify by   : Ranu I. A64-0257 แก้เงื่อนไขการเก็บ Text Memo                          */  
/* Modify by   : Ranu I. A64-0355 เพิ่มการเก็บ Agent code Co-Broker และ comm co-broker  */     
/* Modify by   : Ranu I. A66-0202 เพิ่มตัวแปรเก็บค่า อุปกรณ์เสริมพิเศษ และ กิโลวัตต์    */
/* Modify by   : Ranu I. A67-0029 เพิ่มตัวแปรเก็บค่าผู้ขับขี่ของรถไฟฟ้า                 */
/* Modify by   : Ranu I. A67-0212 เพิ่มตัวแปรเก็บข้อมูลแบตเตอรี่                        */      
/* ------------------------------------------------------------------------------------ */
DEFINE INPUT-OUTPUT  PARAMETER np_prepol    AS CHAR FORMAT "x(16)".
DEFINE INPUT-OUTPUT  PARAMETER np_rencnt    AS INT INIT 0  .
DEFINE INPUT-OUTPUT  PARAMETER np_branch    AS CHAR FORMAT "x(2)"  init "" .
define input-output  parameter np_agent     as char format "x(10)" init "" .  /**/
define input-output  parameter np_producer  as char format "x(10)" init "" .  /**/
define input-output  parameter np_delercode as char format "x(10)" init "" .  /**/ 
define input-output  parameter np_fincode   as char format "x(10)" init "" .  /**/
define input-output  parameter np_payercod  as char format "x(10)" init "" .  /**/
define input-output  parameter np_vatcode   as char format "x(10)" init "" .  /**/
DEFINE INPUT-OUTPUT  PARAMETER np_insref    AS CHAR FORMAT "x(10)" init "" .
DEFINE INPUT-OUTPUT  PARAMETER np_title     AS CHAR FORMAT "x(20)" init "" .  
DEFINE INPUT-OUTPUT  PARAMETER np_name1     AS CHAR FORMAT "x(60)" init "" .
DEFINE INPUT-OUTPUT  PARAMETER np_lname     AS CHAR FORMAT "x(60)" init "" . /**/
DEFINE INPUT-OUTPUT  PARAMETER np_name2     AS CHAR FORMAT "x(60)" init "" .  
DEFINE INPUT-OUTPUT  PARAMETER np_name3     AS CHAR FORMAT "x(60)" init "" .  
DEFINE INPUT-OUTPUT  PARAMETER np_addr1     AS CHAR FORMAT "x(35)" INIT "" .
DEFINE INPUT-OUTPUT  PARAMETER np_addr2     AS CHAR FORMAT "x(35)" INIT "" .
DEFINE INPUT-OUTPUT  PARAMETER np_addr3     AS CHAR FORMAT "x(35)" INIT "" .
DEFINE INPUT-OUTPUT  PARAMETER np_addr4     AS CHAR FORMAT "x(35)" INIT "" .
define INPUT-OUTPUT  PARAMETER np_post      as char format "x(5)"  init "" . /**/
define INPUT-OUTPUT  PARAMETER np_provcod   as char format "x(2)"  init "" . /**/
define INPUT-OUTPUT  PARAMETER np_distcod   as char format "x(2)"  init "" . /**/
define INPUT-OUTPUT  PARAMETER np_sdistcod  as char format "x(2)"  init "" . /**/
DEFINE INPUT-OUTPUT  PARAMETER np_firstdat  AS CHAR FORMAT "x(10)" INIT "" .
DEFINE INPUT-OUTPUT  PARAMETER np_comdat    AS CHAR FORMAT "x(10)" INIT "" . 
DEFINE INPUT-OUTPUT  PARAMETER np_expdat    AS CHAR FORMAT "x(10)" INIT "" .
/*DEFINE INPUT-OUTPUT  PARAMETER np_class     AS CHAR FORMAT "x(4)"  init "" .*/  /*A64-0257*/
DEFINE INPUT-OUTPUT  PARAMETER np_class     AS CHAR FORMAT "x(5)"  init "" .      /*A64-0257*/
DEFINE INPUT-OUTPUT  PARAMETER np_redbook   AS CHAR FORMAT "x(10)" init "" .
DEFINE INPUT-OUTPUT  PARAMETER np_moddes    AS CHAR FORMAT "x(65)" init "" .
DEFINE INPUT-OUTPUT  PARAMETER np_yrmanu    AS CHAR FORMAT "x(5)"  init "" .   
DEFINE INPUT-OUTPUT  PARAMETER np_vehgrp    AS CHAR FORMAT "x"     init "" . 
DEFINE INPUT-OUTPUT  PARAMETER np_body      AS CHAR FORMAT "x(20)" init "" .  
DEFINE INPUT-OUTPUT  PARAMETER np_engine    AS CHAR FORMAT "x(30)" init "" .  
DEFINE INPUT-OUTPUT  PARAMETER np_tons      AS DECI FORMAT ">>,>>9.99-" INIT 0 .  
DEFINE INPUT-OUTPUT  PARAMETER np_seats     AS CHAR FORMAT "x(2)"   INIT "" .  
DEFINE INPUT-OUTPUT  PARAMETER np_vehuse    AS CHAR FORMAT "x"      INIT "" .  
/*DEFINE INPUT-OUTPUT  PARAMETER np_covcod    AS CHAR FORMAT "X"   INIT "" . */ /* A64-0257*/
DEFINE INPUT-OUTPUT  PARAMETER np_covcod    AS CHAR FORMAT "x(3)"   INIT "" .  /* A64-0257*/
DEFINE INPUT-OUTPUT  PARAMETER np_garage    AS CHAR FORMAT "x"      INIT "" .
DEFINE INPUT-OUTPUT  PARAMETER np_vehreg    AS CHAR FORMAT "x(11)"  INIT "" .
DEFINE INPUT-OUTPUT  PARAMETER np_cha_no    AS CHAR FORMAT "x(30)"  INIT "" .
DEFINE INPUT-OUTPUT  PARAMETER np_eng_no    AS CHAR FORMAT "x(30)"  INIT "" .
DEFINE INPUT-OUTPUT  PARAMETER np_uom1_v    AS CHAR FORMAT "x(30)"  INIT "" .
DEFINE INPUT-OUTPUT  PARAMETER np_uom2_v    AS CHAR FORMAT "x(30)"  INIT "" .
DEFINE INPUT-OUTPUT  PARAMETER np_uom5_v    AS CHAR FORMAT "x(30)"  INIT "" .
DEFINE INPUT-OUTPUT  PARAMETER np_si        AS CHAR FORMAT "x(30)"  INIT "" .
DEFINE INPUT-OUTPUT  PARAMETER np_baseprm   AS DECI FORMAT ">>>,>>>,>>9.99-" init 0 . 
DEFINE INPUT-OUTPUT  PARAMETER np_base3     AS DECI FORMAT ">>>,>>>,>>9.99-" init 0 . /*A64-0257*/
DEFINE INPUT-OUTPUT  PARAMETER np_41        AS DECI FORMAT ">>>,>>>,>>9.99-" init 0 . 
DEFINE INPUT-OUTPUT  PARAMETER np_42        AS DECI FORMAT ">>>,>>>,>>9.99-" init 0 . 
DEFINE INPUT-OUTPUT  PARAMETER np_43        AS DECI FORMAT ">>>,>>>,>>9.99-" init 0 . 
DEFINE INPUT-OUTPUT  PARAMETER np_seat41    AS DECI FORMAT ">>,>>9.99-"      init 0 .
DEFINE INPUT-OUTPUT  PARAMETER np_dedod     AS DECI FORMAT ">>>,>>>,>>9.99-" init 0 . 
DEFINE INPUT-OUTPUT  PARAMETER np_addod     AS DECI FORMAT ">>>,>>>,>>9.99-" init 0 . 
DEFINE INPUT-OUTPUT  PARAMETER np_dedpd     AS DECI FORMAT ">>>,>>>,>>9.99-" init 0 . 
DEFINE INPUT-OUTPUT  PARAMETER np_flet_per  AS CHAR FORMAT "x(30)"  INIT "" . 
DEFINE INPUT-OUTPUT  PARAMETER np_ncbper    AS CHAR FORMAT "x(30)"  INIT "" . 
DEFINE INPUT-OUTPUT  PARAMETER np_dss_per   AS CHAR FORMAT "x(30)"  INIT "" . 
DEFINE INPUT-OUTPUT  PARAMETER np_stf_per   AS DECI FORMAT ">>>,>>>,>>9.99-" init 0  . 
DEFINE INPUT-OUTPUT  PARAMETER np_cl_per    AS DECI FORMAT ">>>,>>>,>>9.99-" init 0  . 
DEFINE INPUT-OUTPUT  PARAMETER np_bennam1   AS CHAR FORMAT "x(60)"  INIT ""   . 
DEFINE INPUT-OUTPUT  PARAMETER np_premt     AS DECI FORMAT ">>,>>>,>>9.99-" . /**/
DEFINE INPUT-OUTPUT  PARAMETER np_comm      AS DECI FORMAT ">9.99".
DEFINE INPUT-OUTPUT  PARAMETER np_driver    AS CHARACTER FORMAT "X(23)" INITIAL "" NO-UNDO.
DEF    INPUT-OUTPUT  PARAMETER np_prmtdriv  AS DECI FORMAT ">>>>>9.99-" .
DEFINE INPUT-OUTPUT  PARAMETER np_prmtxt    AS CHAR    FORMAT "x(250)"  INIT "" .
DEFINE INPUT-OUTPUT  PARAMETER np_chk       AS CHAR FORMAT "x(10)"  init ""  .          /**/
DEFINE INPUT-OUTPUT  PARAMETER np_chkdriv   AS CHAR FORMAT "x(10)"  INIT "" .
DEFINE INPUT-OUTPUT  PARAMETER np_chkmemo   AS CHAR FORMAT "x(10)"  INIT ""  .
DEFINE INPUT-OUTPUT  PARAMETER np_chktxt    AS CHAR FORMAT "x(10)"  INIT ""  .
DEFINE INPUT-OUTPUT  PARAMETER np_agco      AS CHAR FORMAT "x(10)"  INIT ""  .  /*A64-0355*/
DEFINE INPUT-OUTPUT  PARAMETER np_commco    AS DECI FORMAT ">9.99".             /*A64-0355*/
DEFINE INPUT-OUTPUT  PARAMETER np_watt      AS DECI FORMAT ">>>>9.99".          /*A66-0202*/
DEFINE INPUT-OUTPUT  PARAMETER np_acctyp    AS CHAR FORMAT "x(2)"  INIT ""  .   /*A66-0202*/
def    input-output  parameter np_maksi     AS DECI FORMAT ">>,>>>,>>9.99-" . /*A67-0029*/ 
def    input-output  parameter np_eng_no2   AS CHAR FORMAT "x(50)" INIT "" .  /*A67-0029*/
/*A67-0212*/
DEF    INPUT-OUTPUT  PARAMETER np_battyr    AS CHAR FORMAT "X(5)" INIT "" . 
def    input-output  parameter np_battsi    as char format "x(15)" init "" .
def    input-output  parameter np_battprice as char format "x(10)" init "" .
def    input-output  parameter np_battno    as char format "x(50)" init "" .
def    input-output  parameter np_chargno   as char format "x(50)" init "" .
def    input-output  parameter np_chargsi   as char format "x(15)" init "" .
def    input-output  parameter np_battprm   as char format "x(15)" init "" .
def    input-output  parameter np_chargprm  as char format "x(15)" init "" .
/*A67-0212*/
DEFINE INPUT-OUTPUT  PARAMETER np_comment   AS CHAR FORMAT "x(350)" init ""  .

DEF VAR n_num AS INT INIT 0.
DEF Var nv_fptr         As RECID   Initial    0.
DEF Var nv_bptr         As RECID   Initial    0.
DEF Var nv_f7           AS CHAR  INIT "" .
DEF VAR nv_f8           AS CHAR  INIT "" .

DEFINE SHARED TEMP-TABLE wuwd132
    FIELD prepol  AS CHAR FORMAT "x(20)" INIT ""
    FIELD bencod  AS CHAR FORMAT "x(30)" INIT "" 
    FIELD benvar  AS CHAR FORMAT "x(40)" INIT "" 
    FIELD gap_ae  AS LOGICAL INIT NO      /* A64-0355*/
    FIELD pd_aep  AS CHAR    INIT "E"     /* A64-0355*/
    FIELD gap_c   AS DECI FORMAT ">>>,>>>,>>9.99-"    
    FIELD prem_c  AS DECI FORMAT ">>>,>>>,>>9.99-"  . 

DEFINE SHARED TEMP-TABLE ws0m009 
/*1*/  FIELD policy     AS CHARACTER    INITIAL ""  
/*2*/  FIELD lnumber    AS INTEGER    
       FIELD ltext      AS CHARACTER    INITIAL "" 
       FIELD ltext2     AS CHARACTER    INITIAL "" 
        /* add by : A67-0029 */ 
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
       FIELD dconsen    AS LOGICAL INIT NO.
       /* end A67-0029 */ 

DEFINE SHARED TEMP-TABLE wuwd100 
/*1*/  FIELD policy     AS CHARACTER    INITIAL ""  
/*2*/  FIELD lnumber    AS INTEGER   
       FIELD ltext      AS CHARACTER    INITIAL "" .

DEFINE SHARED TEMP-TABLE wuwd102 
/*1*/  FIELD policy     AS CHARACTER    INITIAL ""  
/*2*/  FIELD lnumber    AS INTEGER   
       FIELD ltext      AS CHARACTER    INITIAL "" .

ASSIGN np_driver = ""
       np_chkdriv = "" .

FIND LAST sic_exp.uwm100 USE-INDEX uwm10001 WHERE
    sic_exp.uwm100.policy = np_prepol   NO-LOCK NO-ERROR NO-WAIT.
IF AVAILABLE sic_exp.uwm100 THEN DO:
  /* IF sic_exp.uwm100.renpol <> " " THEN DO:
     FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE sicuw.uwm100.policy = sic_exp.uwm100.renpol NO-LOCK NO-ERROR .
     IF AVAIL sicuw.uwm100 THEN DO:
        ASSIGN np_comment = np_comment + "| กรมธรรณ์มีการต่ออายุแล้ว " + sic_exp.uwm100.renpol . 
     END.
   END.
   ELSE DO:*/
        FIND FIRST  sic_exp.uwm120 USE-INDEX uwm12001        WHERE
            sic_exp.uwm120.policy  = sic_exp.uwm100.policy   AND
            sic_exp.uwm120.rencnt  = sic_exp.uwm100.rencnt   AND
            sic_exp.uwm120.endcnt  = sic_exp.uwm100.endcnt   NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sic_exp.uwm120 THEN
            ASSIGN 
            np_rencnt    = sic_exp.uwm100.rencnt + 1
            np_branch    = TRIM(sic_exp.uwm100.branch)
            np_agent     = trim(sic_exp.uwm100.agent)
            np_producer  = trim(sic_exp.uwm100.acno1)
            np_delercode = trim(sic_exp.uwm100.finint)
            np_fincode   = trim(sic_exp.uwm100.dealer)
            np_payercod  = trim(sic_exp.uwm100.payer)  
            np_vatcode   = trim(sic_exp.uwm100.bs_cd)  
            np_insref    = TRIM(sic_exp.uwm100.insref)  
            np_title     = TRIM(sic_exp.uwm100.ntitle)  
            np_name1     = IF sic_exp.uwm100.firstname <> "" THEN trim(sic_exp.uwm100.firstname) ELSE TRIM(sic_exp.uwm100.name1)
            np_lname     = IF sic_exp.uwm100.lastname  <> "" THEN trim(sic_exp.uwm100.lastname)  
                           ELSE IF INDEX(sic_exp.uwm100.name1," ") <> 0 THEN SUBSTR(sic_exp.uwm100.name1,R-INDEX(sic_exp.uwm100.name1," ") + 1) ELSE "" 
            np_name2     = TRIM(sic_exp.uwm100.name2)   
            np_name3     = TRIM(sic_exp.uwm100.name3)   
            np_addr1     = TRIM(sic_exp.uwm100.addr1)   
            np_addr2     = TRIM(sic_exp.uwm100.addr2)  
            np_addr3     = TRIM(sic_exp.uwm100.addr3)   
            np_addr4     = TRIM(sic_exp.uwm100.addr4) 
            np_post      = trim(sic_exp.uwm100.postcd)   
            np_provcod   = trim(sic_exp.uwm100.codeaddr1)
            np_distcod   = trim(sic_exp.uwm100.codeaddr2)
            np_sdistcod  = trim(sic_exp.uwm100.codeaddr3)
            np_firstdat  = string(sic_exp.uwm100.fstdat,"99/99/9999") 
            np_comdat    = string(sic_exp.uwm100.expdat,"99/99/9999") 
            np_expdat    = IF (string(day(sic_exp.uwm100.expdat),"99")   = "29" ) AND 
                              (STRING(MONTH(sic_exp.uwm100.expdat),"99") = "02" ) THEN 
                               string(date("01/03/" + STRING(YEAR(sic_exp.uwm100.expdat) + 1,"9999")),"99/99/9999")  
                           ELSE string(day(sic_exp.uwm100.expdat),"99") + "/" +  
                                STRING(MONTH(sic_exp.uwm100.expdat),"99") + "/" +  
                                STRING(YEAR(sic_exp.uwm100.expdat) + 1 ,"9999") 
            np_class      =  sic_exp.uwm120.class 
            np_comm       =  sic_exp.uwm120.com1p
            np_agco       =  sic_exp.uwm100.acno2   /*A64-0355*/
            np_commco     =  sic_exp.uwm120.com3p . /*A64-0355*/
        
        FIND LAST sic_exp.uwm301 USE-INDEX uwm30101       WHERE
            sic_exp.uwm301.policy = sic_exp.uwm100.policy AND
            sic_exp.uwm301.rencnt = sic_exp.uwm100.rencnt AND
            sic_exp.uwm301.endcnt = sic_exp.uwm100.endcnt NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL uwm301 THEN DO:
            ASSIGN 
                np_chk        = STRING(sic_exp.uwm301.itmdel)  /* adj y/n */
                np_redbook    = trim(sic_exp.uwm301.modcod)          
                np_moddes     = trim(sic_exp.uwm301.moddes)          /* redbook  */                                            
                np_yrmanu     = string(sic_exp.uwm301.yrmanu)                                                              
                np_vehgrp     = trim(sic_exp.uwm301.vehgrp)  
                np_body       = trim(sic_exp.uwm301.body)    
                np_engine     = string(sic_exp.uwm301.engine)     
                np_tons       = sic_exp.uwm301.tons  
                np_watt       = deci(sic_exp.uwm301.watts)       /*A66-0202*/
                np_seats      = STRING(sic_exp.uwm301.seats)     
                np_vehuse     = trim(sic_exp.uwm301.vehuse)        
                np_covcod     = trim(sic_exp.uwm301.covcod)       
                np_garage     = trim(sic_exp.uwm301.garage)
                np_vehreg     = trim(sic_exp.uwm301.vehreg)    
                np_cha_no     = trim(sic_exp.uwm301.cha_no)  
                np_eng_no     = trim(sic_exp.uwm301.eng_no)
                np_seat41     = sic_exp.uwm301.mv41seat  
                np_bennam1    = trim(sic_exp.uwm301.mv_ben83)
                np_prmtxt     = trim(sic_exp.uwm301.prmtxt)
                np_maksi      = sic_exp.uwm301.maksi           /*A67-0029*/
                np_eng_no2    = TRIM(sic_exp.uwm301.eng_no2)  /*A67-0029*/
                np_prmtdriv   = sic_exp.uwm301.actprm 
                /*A67-0212*/ 
                np_battyr     = STRING(sic_exp.uwm301.battyr,"9999")  
                np_battsi     = string(sic_exp.uwm301.battsi)         
                np_battprice  = string(sic_exp.uwm301.battprice)      
                np_battno     = sic_exp.uwm301.battno             
                np_chargno    = sic_exp.uwm301.chargno            
                np_chargsi    = STRING(sic_exp.uwm301.chargsi)  .
               /* end : A67-0212 */

            FIND LAST sic_exp.uwm130 USE-INDEX uwm13002         WHERE
                sic_exp.uwm130.policy = sic_exp.uwm301.policy   AND
                sic_exp.uwm130.rencnt = sic_exp.uwm301.rencnt   AND
                sic_exp.uwm130.endcnt = sic_exp.uwm301.endcnt   AND
                sic_exp.uwm130.riskno = sic_exp.uwm301.riskno   AND
                sic_exp.uwm130.itemno = sic_exp.uwm301.itemno   NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sic_exp.uwm130  THEN
                ASSIGN 
                np_driver =  TRIM(sic_exp.uwm130.policy) +
                             STRING(sic_exp.uwm130.rencnt,"99" ) +
                             STRING(sic_exp.uwm130.endcnt,"999")  +
                             STRING(sic_exp.uwm130.riskno,"999") +
                             STRING(sic_exp.uwm130.itemno,"999")
                np_uom1_v = string(sic_exp.uwm130.uom1_v)
                np_uom2_v = string(sic_exp.uwm130.uom2_v)
                np_uom5_v = string(sic_exp.uwm130.uom5_v)
                /*np_si     = string(sic_exp.uwm130.uom6_v)*/ /*A64-0257*/
                np_si     = IF np_covcod = "2" THEN string(sic_exp.uwm130.uom7_v) ELSE string(sic_exp.uwm130.uom6_v) /*A64-0257*/
                np_acctyp  = TRIM(uwm130.uom6_u) . /*A66-0202*/

            FOR EACH sic_exp.uwd132 USE-INDEX uwd13290  WHERE
                sic_exp.uwd132.policy   = sic_exp.uwm301.policy  AND
                sic_exp.uwd132.rencnt   = sic_exp.uwm301.rencnt  AND
                sic_exp.uwd132.endcnt   = sic_exp.uwm301.endcnt  AND
                sic_exp.uwd132.riskno   = sic_exp.uwm301.riskno  AND
                sic_exp.uwd132.itemno   = sic_exp.uwm301.itemno  NO-LOCK .
                IF      sic_exp.uwd132.bencod = "base"         THEN ASSIGN np_baseprm  = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
                ELSE IF sic_exp.uwd132.bencod = "411"          THEN ASSIGN np_41       = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).  
                ELSE IF sic_exp.uwd132.bencod = "42"           THEN ASSIGN np_42       = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
                ELSE IF sic_exp.uwd132.bencod = "43"           THEN ASSIGN np_43       = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
                ELSE IF sic_exp.uwd132.bencod = "dod"          THEN ASSIGN np_dedod    = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
                ELSE IF sic_exp.uwd132.bencod = "dod2"         THEN ASSIGN np_addod    = DECI(DECI(np_dedod)  +  DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30))).
                ELSE IF sic_exp.uwd132.bencod = "dpd"          THEN ASSIGN np_dedpd    = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
                ELSE IF sic_exp.uwd132.bencod = "flet"         THEN ASSIGN np_flet_per = SUBSTRING(sic_exp.uwd132.benvar,31,30).
                ELSE IF sic_exp.uwd132.bencod = "ncb"          THEN ASSIGN np_ncbper   = string(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
                ELSE IF sic_exp.uwd132.bencod = "dspc"         THEN ASSIGN np_dss_per  = string(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
                ELSE IF sic_exp.uwd132.bencod = "dstf"         THEN ASSIGN np_stf_per  = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
                ELSE IF index(sic_exp.uwd132.bencod,"cl") <> 0 THEN ASSIGN np_cl_per   = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
                ELSE IF sic_exp.uwd132.bencod = "EVCG"         THEN ASSIGN np_battprm  = string(sic_exp.uwd132.prem_c)   .   /*A67-0212*/
                ELSE IF sic_exp.uwd132.bencod = "EVBT"         THEN ASSIGN np_chargprm = string(sic_exp.uwd132.prem_c)   .   /*A67-0212*/

                /* Add by : A64-0257 */
                IF np_covcod = "2.1" AND sic_exp.uwd132.bencod = "ba21" THEN ASSIGN np_base3  = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)). 
                ELSE IF np_covcod = "2.2" AND sic_exp.uwd132.bencod = "ba22" THEN ASSIGN np_base3  = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
                else IF np_covcod = "2.3" AND sic_exp.uwd132.bencod = "ba23" THEN ASSIGN np_base3  = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
                else IF np_covcod = "3.1" AND sic_exp.uwd132.bencod = "ba31" THEN ASSIGN np_base3  = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
                else IF np_covcod = "3.2" AND sic_exp.uwd132.bencod = "ba32" THEN ASSIGN np_base3  = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
                else IF np_covcod = "3.3" AND sic_exp.uwd132.bencod = "ba33" THEN ASSIGN np_base3  = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
                /* end A64-0257 */
                IF sic_exp.uwd132.bencod <> "COMP"  THEN DO:
                    np_premt = np_premt + sic_exp.uwd132.prem_c .
                    FIND FIRST wuwd132 WHERE 
                        wuwd132.prepol = sic_exp.uwm301.policy  AND
                        wuwd132.bencod = sic_exp.uwd132.bencod   NO-WAIT NO-ERROR.
                    IF NOT AVAIL wuwd132 THEN DO:
                        CREATE wuwd132.
                        ASSIGN 
                            wuwd132.prepol = sic_exp.uwd132.policy
                            wuwd132.bencod = sic_exp.uwd132.bencod
                            wuwd132.benvar = sic_exp.uwd132.benvar
                            wuwd132.gap_ae = sic_exp.uwd132.gap_ae    /*A64-0355*/
                            wuwd132.pd_aep = sic_exp.uwd132.pd_aep    /*A64-0355*/
                            wuwd132.gap_c  = sic_exp.uwd132.gap_c 
                            wuwd132.prem_c = sic_exp.uwd132.prem_c.
                    END.
                END.
            END.
        END.
   /*END.*/ /* renpol */
   /* add by : A67-0212 */
   FIND FIRST sic_exp.s0m009 WHERE 
        sic_exp.s0m009.key1  = trim(np_driver) NO-LOCK NO-ERROR NO-WAIT.
   IF AVAIL sic_exp.s0m009 THEN DO:
       FOR EACH sic_exp.s0m009 WHERE sic_exp.s0m009.key1  = trim(np_driver)   NO-LOCK .
          CREATE ws0m009.
          ASSIGN
                 ws0m009.policy      = np_driver    /* sic_bran.s0m009.key1 */
                 ws0m009.lnumber     = INTEGER(sic_exp.s0m009.NOSEQ)
                 ws0m009.ltext       = if trim(sic_exp.s0m009.fld1) <> ""  then trim(sic_exp.s0m009.fld1) else  trim(sic_exp.s0m009.ltext)
                 ws0m009.ltext2      = if trim(sic_exp.s0m009.fld2) <> ""  then trim(sic_exp.s0m009.fld2) else  trim(sic_exp.s0m009.ltext2)
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
          np_chkdriv = STRING(sic_exp.s0m009.NOSEQ) .
         /* IF trim(ws0m009.ltext)    = ""    AND trim(ws0m009.ltext2)  = ""  AND 
             trim(ws0m009.firstnam) = ""    AND trim(ws0m009.lastnam) = ""  THEN ASSIGN np_chkdriv = "" .*/
       END.
   END.
   /* end : A67-0212 */

  /* IF np_chkdriv = "" THEN DO: /*  A67-0212 */
        FIND FIRST sic_exp.s0m009 WHERE 
             sic_exp.s0m009.key1  = np_driver  AND
             INTEGER(sic_exp.s0m009.noseq) = 1  NO-LOCK NO-ERROR NO-WAIT.
         IF AVAILABLE sic_exp.s0m009 THEN DO:
             FOR EACH stat.mailtxt WHERE stat.mailtxt_fil.policy = sic_exp.s0m009.key1  NO-LOCK.
                 CREATE ws0m009.
                 ASSIGN
                     ws0m009.policy      = np_driver    /* sic_bran.s0m009.key1 */
                     ws0m009.lnumber     = INTEGER(stat.mailtxt_fil.lnumber)
                     ws0m009.ltext       = trim(stat.mailtxt_fil.ltext)
                     ws0m009.ltext2      = trim(stat.mailtxt_fil.ltext2)
                     /* add by : A67-0029 */
                     ws0m009.drivbirth   = stat.mailtxt_fil.drivbirth
                     ws0m009.drivage     = stat.mailtxt_fil.drivage    
                     ws0m009.occupcod    = trim(stat.mailtxt_fil.occupcod)   
                     ws0m009.occupdes    = trim(stat.mailtxt_fil.occupdes)   
                     ws0m009.cardflg     = stat.mailtxt_fil.cardflg   
                     ws0m009.drividno    = trim(stat.mailtxt_fil.drividno)   
                     ws0m009.licenno     = trim(stat.mailtxt_fil.licenno)   
                     ws0m009.drivnam     = trim(stat.mailtxt_fil.drivnam)   
                     ws0m009.gender      = trim(stat.mailtxt_fil.gender )   
                     ws0m009.drivlevel   = stat.mailtxt_fil.drivlevel
                     ws0m009.levelper    = stat.mailtxt_fil.levelper  
                     ws0m009.titlenam    = trim(stat.mailtxt_fil.titlenam)  
                     ws0m009.licenexp    = stat.mailtxt_fil.licenexp  
                     ws0m009.firstnam    = trim(stat.mailtxt_fil.firstnam)  
                     ws0m009.lastnam     = trim(stat.mailtxt_fil.lastnam ) 
                     ws0m009.dconsen     = stat.mailtxt_fil.dconsen .
                     /* end : A67-0029 */
                 np_chkdriv = STRING(stat.mailtxt_fil.lnumber) .
             END.
         END.
   END. /*  A67-0212 */
   */
     /*-- Add uwd100 --*/
    IF sic_exp.uwm100.fptr01 <> ? THEN DO:
        n_num = 0 .
        /* create : Ranu i. a64-0257*/
        ASSIGN nv_f7   = "" 
               nv_fptr = 0
               nv_bptr = 0
               nv_fptr = sic_exp.uwm100.fptr01
               nv_bptr = sic_exp.uwm100.bptr01.
        IF nv_fptr <> 0 Or nv_fptr <> ? THEN DO:   
            DO WHILE nv_fptr  <>  0 :
               FIND sic_exp.uwd100  WHERE RECID(sic_exp.uwd100) = nv_fptr NO-LOCK NO-ERROR.
               IF AVAIL sic_exp.uwd100 THEN DO:
                   nv_f7 = trim(SUBSTRING(sic_exp.uwd100.ltext,1,LENGTH(sic_exp.uwd100.ltext))). 
                   nv_fptr  =  sic_exp.uwd100.fptr.
                   IF nv_f7 = ? THEN nv_f7 = "" .
               END.
               ELSE DO:
                   nv_fptr = 0.
               END.
               IF nv_f7 <> "" THEN DO:
                n_num = n_num + 1 .
                CREATE wuwd100.
                ASSIGN
                    wuwd100.policy  = sic_exp.uwd100.policy 
                    wuwd100.lnumber = n_num
                    wuwd100.ltext   = nv_f7.
                np_chktxt = "Y" .
               END.
               IF nv_fptr = 0 THEN LEAVE.
            END.
        END.
        RELEASE sic_exp.uwd100.
        /* end : Ranu i. a64-0257*/
        /* comment by : A64-0257...
        FOR EACH sic_exp.uwd100 WHERE sic_exp.uwd100.policy = sic_exp.uwm100.policy and
                                      sic_exp.uwd100.rencnt = sic_exp.uwm100.rencnt AND 
                                      sic_exp.uwd100.endcnt = sic_exp.uwm100.endcnt NO-LOCK.
            IF sic_exp.uwd100.ltext = "" THEN NEXT.
            ELSE IF INDEX(sic_exp.uwd100.ltext,"Policy Master:") <> 0 THEN NEXT.
            ELSE DO:
                MESSAGE " Expiry uwd100 " sic_exp.uwd100.policy sic_exp.uwd100.ltext VIEW-AS ALERT-BOX.
                n_num = n_num + 1 .
                CREATE wuwd100.
                ASSIGN
                    wuwd100.policy  = sic_exp.uwd100.policy 
                    wuwd100.lnumber = n_num
                    wuwd100.ltext   = sic_exp.uwd100.ltext.
                np_chktxt = "Y" .
            END.
        END.
        ...end A64-0257...*/
     END.
    /*-- Add uwd102 --*/
    IF sic_exp.uwm100.fptr02 <> ? THEN DO:
        n_num = 0.
        /* create : Ranu i. a64-0257*/
        ASSIGN  nv_f8   = ""
             nv_fptr = 0
             nv_bptr = 0
             nv_fptr = uwm100.fptr02
             nv_bptr = uwm100.bptr02.
        IF nv_fptr <> 0 Or nv_fptr <> ? THEN DO:   
            DO WHILE nv_fptr  <>  0 :
               FIND sic_exp.uwd102  WHERE RECID(sic_exp.uwd102) = nv_fptr NO-LOCK NO-ERROR .
               IF AVAIL sic_exp.uwd102 THEN DO:
                   nv_f8 = trim(SUBSTRING(sic_exp.uwd102.ltext,1,LENGTH(sic_exp.uwd102.ltext))). 
                   nv_fptr  =  sic_exp.uwd102.fptr.
                   IF nv_f8 = ? THEN nv_f8 = "" .
               END.
               ELSE DO: 
                   nv_fptr  = 0.
               END.
               IF nv_f8 <> ""  THEN DO:
                   n_num = n_num + 1 .
                   CREATE wuwd102.
                   ASSIGN
                       wuwd102.policy   = sic_exp.uwd102.policy
                       wuwd102.lnumber  = n_num 
                       wuwd102.ltext    = nv_f8.
                   np_chkmemo = "Y" .
               END.
               IF nv_fptr = 0 THEN LEAVE.
            END.
        END.
        RELEASE sic_exp.uwd102.
        /* end : Ranu i. a64-0257*/

        /* comment by  : Ranu i. a64-0257....
        FOR EACH sic_exp.uwd102 WHERE sic_exp.uwd102.policy = sic_exp.uwm100.policy and      
                                      sic_exp.uwd102.rencnt = sic_exp.uwm100.rencnt AND      
                                      sic_exp.uwd102.endcnt = sic_exp.uwm100.endcnt NO-LOCK.
            IF sic_exp.uwd102.ltext = "" THEN NEXT.
            IF INDEX(sic_exp.uwd102.ltext,"Policy Master:") <> 0 THEN NEXT.
            n_num = n_num + 1 .
            CREATE wuwd102.
            ASSIGN
                wuwd102.policy   = sic_exp.uwd102.policy
                wuwd102.lnumber  = n_num 
                wuwd102.ltext    = sic_exp.uwd102.ltext.
            
            np_chkmemo = "Y" .
            
        END.
        ..end A64-0257...*/
    END.
   
END. 
ELSE DO:
    ASSIGN np_comment = np_comment + "|ไม่พบกรมธรรม์ " + np_prepol + " ในระบบใบเตือน " .
END.
                                                                                 
