/* wgwtbex1.P  -- Load Text file tib [Tisco]to gw                           */
/* Copyright   # Safety Insurance Public Company Limited                    */
/*               ����ѷ ��Сѹ������� �ӡѴ (��Ҫ�)                         */
/* WRITE  BY   : Kridtiya i.A53-0207  29/06/2010                            */
/*             : ��ǹ��ä��Ҥ�� �ҹ���������������� ������������������  */
/* modify by   : Kridtiya i. A56-0146 ��������� no-lock                   */
/*Modify by    : Kridtiya i. A57-0017 date. 16/01/2014 add text F6 access   */
/*Modify by   : Ranu I. A64-0138 ����������纤�ҡ�äӹǳ���� */
/*Modify by   : Ranu I. A67-0087 ��������红�����ö俿�� */
/*Modify by   : Ranu I. A67-0114 ��������红����Ŵ�������ҡ���͹ */
/* ------------------------------------------------------------------------ */
DEFINE INPUT-OUTPUT  PARAMETER n_prepol     AS CHAR FORMAT "x(12)" INIT "".    /*wdetail.prepol   */         
DEFINE INPUT-OUTPUT  PARAMETER n_branch     AS CHAR FORMAT "x(2)"  INIT "".    /*wdetail2.branch  */ 
DEFINE INPUT-OUTPUT  PARAMETER n_dealer     AS CHAR FORMAT "x(10)" INIT "" .   /* A67-0114*/
DEFINE INPUT-OUTPUT  PARAMETER n_prempa     AS CHAR FORMAT "x"     INIT "".    /*wdetail2.prempa  */     
/*DEFINE INPUT-OUTPUT  PARAMETER n_subclass   AS CHAR FORMAT "x(3)"  INIT "".    /*wdetail2.subclass*/  */ /*A67-0087*/ 
DEFINE INPUT-OUTPUT  PARAMETER n_subclass   AS CHAR FORMAT "x(4)"  INIT "".    /*wdetail2.subclass*/   /*A67-0087*/ 
DEFINE INPUT-OUTPUT  PARAMETER n_redbook    AS CHAR FORMAT "x(10)" INIT "".    /*wdetail2.redbook */      
DEFINE INPUT-OUTPUT  PARAMETER n_brand      AS CHAR FORMAT "x(30)" INIT "".    /*wdetail.         */          
DEFINE INPUT-OUTPUT  PARAMETER n_model      AS CHAR FORMAT "x(40)" INIT "".    /*wdetail.model    */          
DEFINE INPUT-OUTPUT  PARAMETER n_caryear    AS CHAR FORMAT "x(4)"  INIT "".    /*wdetail.caryear  */        
DEFINE INPUT-OUTPUT  PARAMETER n_cargrp     AS CHAR FORMAT "x(2)"  INIT "".    /*wdetail.cargrp   */         
DEFINE INPUT-OUTPUT  PARAMETER n_engcc      AS CHAR FORMAT "x(10)" INIT "".    /*wdetail.cargrp   */         
DEFINE INPUT-OUTPUT  PARAMETER n_tonns      AS CHAR FORMAT "x(10)" INIT "".    /*wdetail.cargrp   */         
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
DEFINE INPUT-OUTPUT  PARAMETER n_firstdat   AS CHAR FORMAT "99/99/9999"    . 
DEFINE INPUT-OUTPUT  PARAMETER nv_driver    AS CHARACTER FORMAT "X(23)" INITIAL "" NO-UNDO.
DEFINE INPUT-OUTPUT  PARAMETER n_prmtxt     AS CHAR    FORMAT "x(100)" .
DEFINE INPUT-OUTPUT  PARAMETER n_premt      AS DECI FORMAT ">>>,>>>,>>9.99". /*A64-0138*/
DEFINE INPUT-OUTPUT  PARAMETER np_hp        AS DECI FORMAT ">>>>9.99".         /*A67-0087*/
def    input-output  parameter np_maksi     AS DECI FORMAT ">>,>>>,>>9.99-" . /*A67-0087*/ 
def    input-output  parameter np_eng_no2   AS CHAR FORMAT "x(50)" INIT "" .  /*A67-0087*/ 
DEF    INPUT-OUTPUT  PARAMETER np_battyr    AS INTE FORMAT "9999" INIT 0.


DEFINE SHARED WORKFILE ws0m009 NO-UNDO
/*1*/  FIELD policy     AS CHARACTER    INITIAL ""  
/*2*/  FIELD lnumber    AS INTEGER   
       FIELD ltext      AS CHARACTER    INITIAL "" 
       FIELD ltext2     AS CHARACTER    INITIAL "" 
    /* add by : A67-0087 */ 
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
       /* end A67-0087 */ 
ASSIGN nv_driver = "".
FIND LAST sic_exp.uwm100  WHERE sic_exp.uwm100.policy = n_prepol   NO-LOCK NO-ERROR NO-WAIT.
IF AVAILABLE sic_exp.uwm100 THEN DO:
    ASSIGN n_dealer = sic_exp.uwm100.finint . /*A67-0114*/
    FIND LAST  sic_exp.uwm130 USE-INDEX uwm13001 WHERE
        sic_exp.uwm130.policy = sic_exp.uwm100.policy AND
        sic_exp.uwm130.rencnt = sic_exp.uwm100.rencnt AND
        /*sic_exp.uwm130.endcnt = sic_exp.uwm100.endcnt NO-WAIT NO-ERROR.*/      /* A56-0146 */
        sic_exp.uwm130.endcnt = sic_exp.uwm100.endcnt NO-LOCK NO-WAIT NO-ERROR.  /* A56-0146 */
    IF  AVAILABLE sic_exp.uwm130 THEN 
        ASSIGN 
        nv_driver =   TRIM(sic_exp.uwm130.policy) +
                    STRING(sic_exp.uwm130.rencnt,"99" ) +
                    STRING(sic_exp.uwm130.endcnt,"999")  +
                    STRING(sic_exp.uwm130.riskno,"999") +
                    STRING(sic_exp.uwm130.itemno,"999")
        n_tp1     = string(sic_exp.uwm130.uom1_v)  
        n_tp2     = string(sic_exp.uwm130.uom2_v)  
        n_tp3     = string(sic_exp.uwm130.uom5_v) . 
    FIND FIRST  sic_exp.uwm120 USE-INDEX uwm12001       WHERE
        sic_exp.uwm120.policy  = sic_exp.uwm100.policy  AND
        sic_exp.uwm120.rencnt  = sic_exp.uwm100.rencnt  AND
        /*sic_exp.uwm120.endcnt  = sic_exp.uwm100.endcnt  NO-ERROR NO-WAIT.*/      /* A56-0146 */
        sic_exp.uwm120.endcnt  = sic_exp.uwm100.endcnt  NO-LOCK NO-ERROR NO-WAIT.  /* A56-0146 */
    IF AVAIL sic_exp.uwm120 THEN DO:
        ASSIGN 
        n_firstdat = string(sic_exp.uwm100.fstdat)
        n_branch   = caps(trim(sic_exp.uwm100.branch))
        n_prempa   = substring(sic_exp.uwm120.class,1,1)
        n_subclass = substring(sic_exp.uwm120.class,2,3).
    END.
    FIND LAST sic_exp.uwm301 USE-INDEX uwm30101      WHERE
        sic_exp.uwm301.policy = sic_exp.uwm100.policy    AND
        sic_exp.uwm301.rencnt = sic_exp.uwm100.rencnt    AND
        /*sic_exp.uwm301.endcnt = sic_exp.uwm100.endcnt  NO-ERROR NO-WAIT.*/         /* A56-0146 */  
        sic_exp.uwm301.endcnt = sic_exp.uwm100.endcnt    NO-LOCK NO-ERROR NO-WAIT.   /* A56-0146 */  
    IF AVAIL sic_exp.uwm301 THEN DO:
        ASSIGN 
        n_tonns    = string(sic_exp.uwm301.Tons)     
        n_engcc    = STRING(sic_exp.uwm301.engine) 
        n_bodys    = sic_exp.uwm301.body
        n_garage   = sic_exp.uwm301.garage  
        n_brand    = substr(sic_exp.uwm301.moddes,1,INDEX(sic_exp.uwm301.moddes," ") - 1 )
        n_model    = substr(sic_exp.uwm301.moddes,INDEX(sic_exp.uwm301.moddes," ") + 1 )
        n_redbook  = sic_exp.uwm301.modcod     /*redbook     */                                            
        n_cargrp   = sic_exp.uwm301.vehgrp     /*�����ö¹�� */                                       
        /*n_chasno   = sic_exp.uwm301.cha_no   /*�����Ţ��Ƕѧ */ */   
        /*n_eng      = sic_exp.uwm301.eng_no   /*�����Ţ����ͧ*/ */                     
        n_vehuse   = sic_exp.uwm301.vehuse                                                                   
        n_caryear  = string(sic_exp.uwm301.yrmanu )   /*��蹻�*/
        n_covcod   = sic_exp.uwm301.covcod                                                            
        n_seat     = sic_exp.uwm301.seats             /*�ӹǹ�����*/ 
        nv_seat41  = sic_exp.uwm301.mv41seat    
        n_prmtxt   = trim(sic_exp.uwm301.prmtxt)       /*A57-0017  add F6 text accesory */
        np_hp      = deci(sic_exp.uwm301.watts)       /*A67-0087*/
        np_maksi   = sic_exp.uwm301.maksi             /*A67-0087*/
        np_eng_no2 = TRIM(sic_exp.uwm301.eng_no2)     /*A67-0087*/
        np_battyr  = sic_exp.uwm301.battyr . /* A67-0087 */
    END.

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
        /* create by : A64-0138...*/
        IF sic_exp.uwd132.bencod <> "comp"  THEN DO:
            n_premt = n_premt + sic_exp.uwd132.prem_c.
        END.
        /*...end A64-0138..*/
    END.
    /* add by : A67-0114 */
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
    /* end : A67-0114 */
    /* comment by :A67-0114...
    FIND FIRST sic_exp.s0m009 WHERE 
        sic_exp.s0m009.key1  = nv_driver  AND
        INTEGER(sic_exp.s0m009.noseq) = 1  NO-LOCK NO-ERROR NO-WAIT.
    IF AVAILABLE sic_exp.s0m009 THEN DO:
        FOR EACH sic_exp.s0m009  /* USE-INDEX mailtxt01 */ WHERE sic_exp.s0m009.key1 = nv_driver  NO-LOCK.  /*A67-0114*/
        FOR EACH stat.mailtxt WHERE stat.mailtxt_fil.policy = sic_exp.s0m009.key1  NO-LOCK.                     /*A67-0087*/
            CREATE ws0m009.
            ASSIGN
                ws0m009.policy  = nv_driver    /* sic_bran.s0m009.key1 */
               /* ws0m009.lnumber = INTEGER(sic_exp.s0m009.noseq) */ /*A67-0087*/
               /* ws0m009.ltext   = sic_exp.s0m009.fld1           */ /*A67-0087*/
               /* ws0m009.ltext2  = sic_exp.s0m009.fld2           */ /*A67-0087*/
                /* add by : A67-0087*/ 
                ws0m009.lnumber     = INTEGER(stat.mailtxt_fil.lnumber)
                ws0m009.ltext       = trim(stat.mailtxt_fil.ltext)
                ws0m009.ltext2      = trim(stat.mailtxt_fil.ltext2)
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
                /*end : A67-0087 */
        END.
    END.
    ...end A67-0114...*/ 

END. 
                                  
                                 
                                   
                                 
                             
                                 
                             
