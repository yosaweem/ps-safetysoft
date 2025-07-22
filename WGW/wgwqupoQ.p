/* Create by : Phaiboon W. [A59-0488] Date 07/11/2016  
               ดึงข้อมูลเลข Q จาก PM                   */
 /*----------------------------------------------------*/
 /*Modify by : Ranu I. A62-0219 เพิ่มการเก็บข้อมูล Redbook, Brand ,Model ให้ถูกต้อง */
/* --------------------------------------------------- */
DEF INPUT  PARAMETER n_policy    AS CHAR.
DEF INPUT-OUTPUT PARAMETER n_chk AS LOG.
DEF OUTPUT PARAMETER n_redbook   AS CHAR FORMAT "x(12)". /*A62-0219*/
DEF OUTPUT PARAMETER n_brand     AS CHAR.
DEF OUTPUT PARAMETER n_model     AS CHAR.
DEF OUTPUT PARAMETER n_year      AS CHAR.
DEF OUTPUT PARAMETER n_power     AS DEC.  
/*
DEF OUTPUT PARAMETER n_licence1  AS CHAR.  
DEF OUTPUT PARAMETER n_licence2  AS CHAR.  
DEF OUTPUT PARAMETER n_cha_no    AS CHAR.  
DEF OUTPUT PARAMETER n_eng_no    AS CHAR.  
*/
DEF OUTPUT PARAMETER n_driv      AS INT.   
DEF OUTPUT PARAMETER n_drivnam1  AS CHAR.  
DEF OUTPUT PARAMETER n_drivnam2  AS CHAR.  
DEF OUTPUT PARAMETER n_sex1      AS INT.
DEF OUTPUT PARAMETER n_sex2      AS INT.
DEF OUTPUT PARAMETER n_hbdri1    AS DATE.
DEF OUTPUT PARAMETER n_hbdri2    AS DATE.
DEF OUTPUT PARAMETER n_agedri1   AS INT.
DEF OUTPUT PARAMETER n_agedri2   AS INT.
DEF OUTPUT PARAMETER n_occupdri1 AS CHAR.
DEF OUTPUT PARAMETER n_occupdri2 AS CHAR.
DEF OUTPUT PARAMETER n_idnodri1  AS CHAR.
DEF OUTPUT PARAMETER n_idnodri2  AS CHAR.
DEF OUTPUT PARAMETER n_pack      AS CHAR.
DEF OUTPUT PARAMETER n_class     AS CHAR.
DEF OUTPUT PARAMETER n_garage    AS CHAR.
DEF OUTPUT PARAMETER n_sumsi     AS DEC.
DEF OUTPUT PARAMETER n_gap       AS DEC.   
DEF OUTPUT PARAMETER n_premium   AS DEC.
DEF OUTPUT PARAMETER n_precomp   AS DEC.
DEF OUTPUT PARAMETER n_totlepre  AS DEC.
DEF OUTPUT PARAMETER n_baseod    AS DEC.
/* add by A62-0219*/
def output parameter n_tpp as  Char    Format    "x(20)" . 
def output parameter n_tpa as  Char    Format    "x(20)" . 
def output parameter n_tpd as  Char    Format    "x(20)" . 
def output parameter n_41  as  Char    Format    "x(20)" . 
def output parameter n_42  as  Char    Format    "x(20)" . 
def output parameter n_43  as  Char    Format    "x(20)" . 
/* end A62-0219*/
/*---------------------------------------------------------*/
DEFINE NEW SHARED VAR n_text      AS CHARACTER  FORMAT "X(6)"           INITIAL ""    NO-UNDO.
DEFINE NEW SHARED VAR nv_branch   AS CHARACTER  FORMAT "XX"             INITIAL ""    NO-UNDO.
DEFINE NEW SHARED VAR nv_comdat   AS DATE       FORMAT "99/99/9999"                   NO-UNDO.
DEFINE NEW SHARED VAR nv_tariff   AS CHARACTER  FORMAT "X"              INITIAL ""    NO-UNDO.
DEFINE NEW SHARED VAR nv_key_b    AS DECIMAL    FORMAT ">>>,>>>,>>>,>>9.99-" INITIAL 0 NO-UNDO.
DEFINE NEW SHARED VAR nv_vehuse   AS CHARACTER  FORMAT "X"              INITIAL ""    NO-UNDO.

DEFINE NEW SHARED VAR nv_makcod   AS CHARACTER  FORMAT "X(10)"          INITIAL ""    NO-UNDO.

DEFINE NEW SHARED VAR nv_yrcod    AS CHARACTER  FORMAT "X(4)"           INITIAL ""    NO-UNDO.
DEFINE NEW SHARED VAR nv_yrprm    AS DECIMAL    FORMAT ">,>>>,>>9.99"   INITIAL 0     NO-UNDO.

DEFINE NEW SHARED VAR nv_gpcod    AS CHARACTER  FORMAT "X(4)"           INITIAL ""    NO-UNDO.
DEFINE NEW SHARED VAR nv_gpper    AS DECIMAL    FORMAT ">>9.99"         INITIAL ""    NO-UNDO.

DEFINE NEW SHARED VAR nv_engine   AS INTEGER    FORMAT ">>>9"           INITIAL 0     NO-UNDO.
DEFINE NEW SHARED VAR nv_engcod   AS CHARACTER  FORMAT "X(4)"           INITIAL ""    NO-UNDO.
DEFINE NEW SHARED VAR nv_seats    AS INTEGER    FORMAT ">9"             INITIAL 0     NO-UNDO.
DEFINE NEW SHARED VAR nv_tons     AS INTEGER    FORMAT "9999"           INITIAL 0     NO-UNDO.
DEFINE NEW SHARED VAR nv_engprm   AS DECIMAL    FORMAT ">,>>>,>>9.99"   INITIAL 0     NO-UNDO.

DEFINE NEW SHARED VAR nv_class    AS CHARACTER  FORMAT "X(4)"           INITIAL ""    NO-UNDO.
DEFINE NEW SHARED VAR nv_usecod   AS CHARACTER  FORMAT "X(4)"           INITIAL ""    NO-UNDO.
DEFINE NEW SHARED VAR nv_useprm   AS DECIMAL    FORMAT ">,>>>,>>9.99"   INITIAL 0     NO-UNDO.

DEFINE NEW SHARED VAR nv_chkcov   AS LOGIC                                            NO-UNDO.
DEFINE NEW SHARED VAR nv_covtyp   AS CHARACTER  FORMAT "X"              INITIAL ""    NO-UNDO.
DEFINE NEW SHARED VAR nv_covchg   AS CHARACTER  FORMAT "X"              INITIAL ""    NO-UNDO.
DEFINE NEW SHARED VAR nv_totsi    AS INTEGER    FORMAT ">>>,>>>,>>9"    INITIAL 0     NO-UNDO.
DEFINE NEW SHARED VAR nv_sicod    AS CHARACTER  FORMAT "X(4)"           INITIAL ""    NO-UNDO.
DEFINE NEW SHARED VAR nv_siprm    AS DECIMAL    FORMAT ">,>>>,>>9.99"   INITIAL 0     NO-UNDO.

DEFINE NEW SHARED VAR nv_biper    AS INTEGER    FORMAT ">>,>>>,>>9"     INITIAL 0     NO-UNDO.
DEFINE NEW SHARED VAR nv_bi1prm   AS DECIMAL    FORMAT ">,>>>,>>9.99"   INITIAL 0     NO-UNDO.
DEFINE NEW SHARED VAR nv_bipcod   AS CHARACTER  FORMAT "X(4)"           INITIAL ""    NO-UNDO.
DEFINE NEW SHARED VAR nv_biac     AS INTEGER    FORMAT ">>>,>>>,>>9"    INITIAL 0     NO-UNDO.
DEFINE NEW SHARED VAR nv_bi2prm   AS DECIMAL    FORMAT ">,>>>,>>9.99"   INITIAL 0     NO-UNDO.
DEFINE NEW SHARED VAR nv_biacod   AS CHARACTER  FORMAT "X(4)"           INITIAL ""    NO-UNDO.

DEFINE NEW SHARED VAR nv_pd       AS INTEGER    FORMAT ">>,>>>,>>9"     INITIAL 0     NO-UNDO.
DEFINE NEW SHARED VAR nv_pdprm    AS DECIMAL    FORMAT ">,>>>,>>9.99"   INITIAL 0     NO-UNDO.
DEFINE NEW SHARED VAR nv_pdcod    AS CHARACTER  FORMAT "X(4)"           INITIAL ""    NO-UNDO.

DEFINE NEW SHARED VAR nv_drivcod  AS CHARACTER  FORMAT "X(4)"           INITIAL ""    NO-UNDO.
DEFINE NEW SHARED VAR nv_driprm   AS DECIMAL    FORMAT ">,>>>,>>9.99"   INITIAL 0     NO-UNDO.
DEFINE NEW SHARED VAR nv_chkdri   AS LOGIC                                            NO-UNDO.
DEFINE NEW SHARED VAR nv_drivnam  AS LOGIC                                            NO-UNDO.
DEFINE NEW SHARED VAR nv_agecod1  AS CHARACTER  FORMAT "X(4)"           INITIAL ""    NO-UNDO.
DEFINE NEW SHARED VAR nv_agecod2  AS CHARACTER  FORMAT "X(4)"           INITIAL ""    NO-UNDO.
DEFINE NEW SHARED VAR nv_drivno   AS INTEGER    FORMAT "9"              INITIAL 0     NO-UNDO.

DEFINE NEW SHARED VAR nv_garage   AS CHARACTER  FORMAT "X(1)"           INITIAL ""    NO-UNDO.

DEFINE NEW SHARED VAR nv_comper   AS INTEGER    FORMAT ">>,>>>,>>9"     INITIAL 0     NO-UNDO.
DEFINE NEW SHARED VAR nv_comcod   AS CHARACTER  FORMAT "X(4)"           INITIAL ""    NO-UNDO.
DEFINE NEW SHARED VAR nv_comprm   AS INTEGER    FORMAT ">>,>>9"         INITIAL 0     NO-UNDO.

DEFINE NEW SHARED VAR nv_baseprm  AS INTEGER    FORMAT ">,>>>,>>9"      INITIAL 0     NO-UNDO.
DEFINE NEW SHARED VAR nv_basecod  AS CHARACTER  FORMAT "X(4)"           INITIAL ""    NO-UNDO.

DEFINE NEW SHARED VAR nv_41       AS INTEGER    FORMAT ">>>,>>>,>>9"    INITIAL 0     NO-UNDO.
DEFINE NEW SHARED VAR nv_41prm    AS INTEGER    FORMAT ">>,>>>,>>9"     INITIAL 0     NO-UNDO.
DEFINE NEW SHARED VAR nv_seat41   AS INTEGER    FORMAT ">>9"            INITIAL 0     NO-UNDO.
DEFINE NEW SHARED VAR nv_41cod1   AS CHARACTER  FORMAT "X(4)"           INITIAL ""    NO-UNDO.
DEFINE NEW SHARED VAR nv_411prm   AS INTEGER    FORMAT ">>,>>>,>>9"     INITIAL 0     NO-UNDO.
DEFINE NEW SHARED VAR nv_41cod2   AS CHARACTER  FORMAT "X(4)"           INITIAL ""    NO-UNDO.
DEFINE NEW SHARED VAR nv_412prm   AS INTEGER    FORMAT ">>,>>>,>>9"     INITIAL 0     NO-UNDO.

DEFINE NEW SHARED VAR nv_42       AS INTEGER    FORMAT ">>>,>>>,>>9"    INITIAL 0     NO-UNDO.
DEFINE NEW SHARED VAR nv_42cod    AS CHARACTER  FORMAT "X(4)"           INITIAL ""    NO-UNDO.
DEFINE NEW SHARED VAR nv_42prm    AS INTEGER    FORMAT ">>,>>>,>>9"     INITIAL 0     NO-UNDO.

DEFINE NEW SHARED VAR nv_43       AS INTEGER    FORMAT ">>>,>>>,>>9"    INITIAL 0     NO-UNDO.
DEFINE NEW SHARED VAR nv_43cod    AS CHARACTER  FORMAT "X(4)"           INITIAL ""    NO-UNDO.
DEFINE NEW SHARED VAR nv_43prm    AS INTEGER    FORMAT ">>,>>>,>>9"     INITIAL 0     NO-UNDO.

DEFINE NEW SHARED VAR nv_dedod    AS INTEGER    FORMAT ">>,>>>,>>9"     INITIAL 0     NO-UNDO.
DEFINE NEW SHARED VAR nv_odcod    AS CHARACTER  FORMAT "X(4)"           INITIAL ""    NO-UNDO.
DEFINE NEW SHARED VAR nv_ded1prm  AS INTEGER    FORMAT ">>>,>>9-"       INITIAL 0     NO-UNDO.

DEFINE NEW SHARED VAR nv_addod    AS INTEGER    FORMAT ">>,>>>,>>9"     INITIAL 0     NO-UNDO.
DEFINE NEW SHARED VAR nv_aded1prm AS INTEGER    FORMAT ">>>,>>9-"       INITIAL 0     NO-UNDO.

DEFINE NEW SHARED VAR nv_dedpd    AS INTEGER    FORMAT ">>,>>>,>>9"     INITIAL 0     NO-UNDO.
DEFINE NEW SHARED VAR nv_ded2prm  AS INTEGER    FORMAT ">>>,>>9-"       INITIAL 0     NO-UNDO.
DEFINE NEW SHARED VAR nv_cons     AS CHAR       FORMAT "X(2)"                         NO-UNDO.

DEFINE NEW SHARED VAR nv_flet_per AS DECIMAL    FORMAT ">9.99"          INITIAL 0     NO-UNDO.
DEFINE NEW SHARED VAR nv_fletae   AS LOGIC      FORMAT "A/E"            INITIAL "A"   NO-UNDO.
DEFINE NEW SHARED VAR nv_flet     AS INTEGER    FORMAT ">>,>>9-"        INITIAL 0     NO-UNDO.

DEFINE NEW SHARED VAR nv_ncbyr    AS INTEGER    FORMAT "9"              INITIAL 0     NO-UNDO.
DEFINE NEW SHARED VAR nv_ncbae    AS LOGIC      FORMAT "A/E"            INITIAL "A"   NO-UNDO.
DEFINE NEW SHARED VAR nv_ncb_per  AS DECIMAL    FORMAT ">9.99"          INITIAL 0     NO-UNDO.
DEFINE NEW SHARED VAR nv_ncb      AS INTEGER    FORMAT ">>>,>>9-"                     NO-UNDO.

DEFINE NEW SHARED VAR nv_prem1    AS DECIMAL    FORMAT ">,>>>,>>9.99"   INITIAL 0     NO-UNDO.
DEFINE NEW SHARED VAR nv_prem2    AS INTEGER    FORMAT ">>,>>>,>>9"     INITIAL 0     NO-UNDO.
DEFINE NEW SHARED VAR nv_prem3    AS INTEGER    FORMAT ">>,>>>,>>9-"    INITIAL 0     NO-UNDO.
DEFINE NEW SHARED VAR nv_preprm   AS DECIMAL    FORMAT ">,>>>,>>9.99"   INITIAL 0     NO-UNDO.
DEFINE NEW SHARED VAR nv_gpprm    AS DECIMAL    FORMAT ">,>>>,>>9.99"   INITIAL 0     NO-UNDO.

DEFINE NEW SHARED VAR nv_total    AS DECIMAL    FORMAT ">>>,>>9.99"     INITIAL 0     NO-UNDO.
DEFINE NEW SHARED VAR nv_totprm   AS INTEGER    FORMAT ">>,>>>,>>9"     INITIAL 0     NO-UNDO.
DEFINE NEW SHARED VAR nv_totprm2  AS INTEGER    FORMAT ">>,>>>,>>9"     INITIAL 0     NO-UNDO.
DEFINE NEW SHARED VAR nv_totprm3  AS INTEGER    FORMAT ">>,>>>,>>9"     INITIAL 0     NO-UNDO.

DEFINE NEW SHARED VAR nv_dss_per  AS DECIMAL    FORMAT ">9.99"          INITIAL 0     NO-UNDO.
DEFINE NEW SHARED VAR nv_dssae    AS LOGIC      FORMAT "A/E"                          NO-UNDO.
DEFINE NEW SHARED VAR nv_dsspc    AS INTEGER    FORMAT ">>,>>>,>>9"     INITIAL 0     NO-UNDO.

DEFINE NEW SHARED VAR nv_cl_per   AS DECIMAL    FORMAT ">9.99"          INITIAL 0     NO-UNDO.
DEFINE NEW SHARED VAR nv_clae     AS LOGIC      FORMAT "A/E"            INITIAL YES   NO-UNDO.
DEFINE NEW SHARED VAR nv_lodclm   AS INTEGER    FORMAT ">>,>>9-"        INITIAL 0     NO-UNDO.

DEFINE NEW SHARED VAR nv_stf_per  AS DECIMAL    FORMAT ">9.99"          INITIAL 0     NO-UNDO.
DEFINE NEW SHARED VAR nv_stfae    AS LOGIC      FORMAT "A/E"                          NO-UNDO.
DEFINE NEW SHARED VAR nv_stf_amt  AS INTEGER    FORMAT ">>>,>>9-"       INITIAL 0     NO-UNDO.

DEFINE NEW SHARED VAR nv_com1_per AS DECIMAL    FORMAT ">9.99"          INITIAL 0     NO-UNDO.
DEFINE NEW SHARED VAR nv_tax_per  AS DECIMAL    FORMAT ">9.99"          INITIAL 0     NO-UNDO.
DEFINE NEW SHARED VAR nv_tax      AS DECIMAL    FORMAT ">>,>>9.99"      INITIAL 0     NO-UNDO.

DEFINE NEW SHARED VAR nv_stm_per  AS DECIMAL    FORMAT ">9.99"          INITIAL 0     NO-UNDO.
DEFINE NEW SHARED VAR nv_stamp    AS INTEGER    FORMAT ">,>>9"          INITIAL 0     NO-UNDO.
DEFINE NEW SHARED VAR nv_dupdisp  AS CHARACTER  FORMAT "XXX "           INITIAL ""    NO-UNDO.

DEFINE NEW SHARED VAR nv_comm     AS DECIMAL    FORMAT ">>>,>>9.99"     INITIAL 0     NO-UNDO.
DEFINE NEW SHARED VAR nv_ratcod1  AS INTEGER    FORMAT ">>>,>>9"        INITIAL 0     NO-UNDO.
DEFINE NEW SHARED VAR nv_ratcod2  AS INTEGER    FORMAT ">>>,>>9"        INITIAL 0     NO-UNDO.

DEFINE NEW SHARED VAR nv_othcod   AS CHARACTER  FORMAT "X(4)"           INITIAL ""    NO-UNDO.
DEFINE NEW SHARED VAR nv_othprm   AS DECIMAL    FORMAT ">>,>>>,>>9.99-" INITIAL 0     NO-UNDO.
DEFINE NEW SHARED VAR nv_uom6_u   AS CHARACTER  FORMAT "X"              INITIAL ""    NO-UNDO.

DEFINE VAR n_qpolicy   AS CHARACTER  FORMAT "X(16)"          INITIAL ""    NO-UNDO.
DEFINE VAR n_rpolicy   AS CHARACTER  FORMAT "X(16)"          INITIAL ""    NO-UNDO.
DEFINE VAR n_rencnt    AS INTEGER    FORMAT "999"            INITIAL 0     NO-UNDO.
DEFINE VAR n_endcnt    AS INTEGER    FORMAT "999"            INITIAL 0     NO-UNDO.
DEFINE VAR nv_riskno   AS INTEGER    FORMAT "999"            INITIAL 1     NO-UNDO.
DEFINE VAR nv_seqcar   AS INTEGER                            INITIAL 1     NO-UNDO.
DEFINE VAR nv_trndat   AS DATE                               INITIAL TODAY NO-UNDO.

DEFINE VAR nv_carnam   AS CHARACTER  FORMAT "X(13)"          INITIAL ""    NO-UNDO.
DEFINE VAR nv_moddes   AS CHARACTER  FORMAT "X(30)"          INITIAL ""    NO-UNDO.
DEFINE VAR nv_imp      AS LOGIC                                            NO-UNDO.
DEFINE VAR nv_prmpac   AS CHARACTER  FORMAT "X"              INITIAL ""    NO-UNDO.
DEFINE VAR nv_pacdes   AS CHARACTER  FORMAT "X(10)"          INITIAL ""    NO-UNDO.
DEFINE VAR nv_makyea   AS INTEGER    FORMAT "9999"           INITIAL 0     NO-UNDO.
DEFINE VAR nv_vehgp    AS CHARACTER  FORMAT "XX"             INITIAL ""    NO-UNDO.
DEFINE VAR nv_chasis   AS CHARACTER  FORMAT "X(20)"          INITIAL ""    NO-UNDO.
DEFINE VAR nv_body     AS CHARACTER  FORMAT "X(10)"          INITIAL ""    NO-UNDO.

DEFINE VAR nv_unit     AS CHARACTER  FORMAT "X(1)"           INITIAL ""    NO-UNDO.
DEFINE VAR nv_impchg   AS LOGIC                                            NO-UNDO.
DEFINE VAR nv_covdes   AS CHARACTER  FORMAT "X(15)"          INITIAL ""    NO-UNDO.
DEFINE VAR nv_si       AS INTEGER    FORMAT ">>>,>>>,>>9"    INITIAL 0     NO-UNDO.
DEFINE VAR nv_spcdev   AS INTEGER    FORMAT ">>>,>>>,>>9"    INITIAL 0     NO-UNDO.
DEFINE VAR nv_code     AS CHARACTER  FORMAT "X(4)"           INITIAL ""    NO-UNDO.
DEFINE VAR nv_clscod   AS CHARACTER  FORMAT "X(4)"           INITIAL ""    NO-UNDO.
DEFINE VAR nv_vehper   AS DECIMAL    FORMAT ">>9.99"         INITIAL ""    NO-UNDO.
DEFINE VAR nv_usedes   AS CHARACTER  FORMAT "X(15)"          INITIAL ""    NO-UNDO.
DEFINE VAR nv_useper   AS DECIMAL    FORMAT ">>9.99"         INITIAL ""    NO-UNDO.
DEFINE VAR nv_age1     AS INTEGER    FORMAT ">9"             INITIAL 0     NO-UNDO.
DEFINE VAR nv_age2     AS INTEGER    FORMAT ">9"             INITIAL 0     NO-UNDO.
DEFINE VAR nv_basecod1 AS CHARACTER  FORMAT "X(4)"           INITIAL ""    NO-UNDO.
DEFINE VAR nv_basecod2 AS CHARACTER  FORMAT "X(4)"           INITIAL ""    NO-UNDO.
DEFINE VAR nv_basrat1  AS INTEGER    FORMAT ">>>,>>9"        INITIAL 0     NO-UNDO.
DEFINE VAR nv_basrat2  AS INTEGER    FORMAT ">>>,>>9"        INITIAL 0     NO-UNDO.
DEFINE VAR nv_basemin  AS INTEGER    FORMAT ">>>,>>9"        INITIAL 0     NO-UNDO.
DEFINE VAR nv_basemax  AS INTEGER    FORMAT ">>>,>>9"        INITIAL 0     NO-UNDO.
DEFINE VAR nv_compac   AS INTEGER    FORMAT ">>>,>>>,>>9"    INITIAL 0     NO-UNDO.
DEFINE VAR nv_save     AS LOGIC                              INITIAL NO    NO-UNDO.
DEFINE VAR nv_function AS CHARACTER                                        NO-UNDO.
DEFINE VAR nv_tmpsi    AS DECI FORMAT ">>,>>>,>>9.99-".
DEFINE VAR nv_error    AS CHAR.

DEF VAR n_chkpol    AS CHAR.
DEF VAR n_number    AS INT.
DEF VAR nv_eng_no   AS CHAR.
DEF VAR nv_licence1 AS CHAR.
DEF VAR nv_licence2 AS CHAR.
DEF VAR nv_totalp70 AS DEC.
DEF VAR nv_stamp70  AS DEC.
DEF VAR nv_tax70    AS DEC.
DEF VAR nv_totalp72 AS DEC.
DEF VAR nv_stamp72  AS DEC.
DEF VAR nv_tax72    AS DEC.
DEF VAR nv_chkstamp AS DEC.

ASSIGN    
    n_brand     = ""    n_model     = ""    n_year      = ""
    n_power     = 0     /* n_licence1  = ""    n_licence2  = "" */
    /* n_cha_no    = ""    n_eng_no    = "" */   n_driv      = 1
    n_drivnam1  = ""    n_drivnam2  = ""    n_sex1      = 1
    n_sex2      = 1     n_hbdri1    = ?     n_hbdri2    = ?
    n_agedri1   = 0     n_agedri2   = 0     n_occupdri1 = ""
    n_occupdri2 = ""    n_idnodri1  = ""    n_idnodri2  = ""
    n_pack      = ""    n_class     = ""    n_garage    = ""
    n_sumsi     = 0     n_gap       = 0     n_premium   = 0 
    n_precomp   = 0     n_totlepre  = 0     n_baseod    = 0.

/* ---------------------------------------------------------- */

ASSIGN   nv_makcod   = ""     nv_biac     = 0     nv_aded1prm = 0      
         nv_carnam   = ""     nv_pd       = 0     nv_dedpd    = 0      
         nv_moddes   = ""     nv_drivnam  = no    nv_ded2prm  = 0      
         nv_imp      = no     nv_drivno   = 0     nv_flet_per = 0      
         nv_makyea   = 0      nv_baseprm  = 0     nv_fletae   = yes    
         nv_code     = ""     nv_prem1    = 0     nv_flet     = 0      
         nv_prmpac   = "D"    nv_totprm   = 0     nv_ncbyr    = 0      
         nv_pacdes   = ""     nv_41       = 0     nv_ncb_per  = 0      
         nv_class    = ""     nv_seat41   = 0     nv_ncb      = 0      
         nv_chasis   = ""     nv_41prm    = 0     nv_dss_per  = 0      
         nv_engine   = 0      nv_42       = 0     nv_dssae    = yes    
         nv_seats    = 0      nv_42prm    = 0     nv_dsspc    = 0      
         nv_tons     = 0      nv_43       = 0     nv_cl_per   = 0      
         nv_covtyp   = ""     nv_43prm    = 0     nv_clae     = yes    
         nv_covdes   = ""     nv_prem2    = 0     nv_lodclm   = 0      
         nv_vehuse   = ""     nv_totprm2  = 0     nv_stf_per  = 0      
         nv_usedes   = ""     nv_dedod    = 0     nv_stfae    = yes    
         nv_vehgp    = ""     nv_ded1prm  = 0     nv_stf_amt  = 0      
         nv_si       = 0      nv_addod    = 0     nv_prem3    = 0      
         nv_spcdev   = 0      nv_biper    = 0     nv_totprm3  = 0      
         nv_stamp    = 0      nv_tax      = 0     nv_total    = 0      
         nv_comper   = 0      nv_compac   = 0     nv_save     = no     
/*       n_qpolicy   = ""     n_rpolicy   = ""    n_policy    = ""*/   
         nv_comprm   = 0      nv_411prm   = 0                          
         nv_412prm   = 0      nv_42prm    = 0     nv_43prm    = 0      
         nv_uom6_u   = ""     nv_basecod  = "BASE"                     
         nv_key_b    = 0      nv_garage   = ""    nv_drivcod  = "A000" 
                                                                       
         n_rencnt    = 0      n_endcnt    = 0      nv_riskno  = 1      
         nv_seqcar   = 1      nv_gpcod    = ""     nv_engcod  = ""     
                                                                       
         nv_clscod   = ""     nv_basecod1 = ""     nv_basecod2 = ""    
         nv_yrcod    = ""     nv_usecod   = ""     nv_sicod    = ""    
         nv_bipcod   = ""     nv_biacod   = ""     nv_pdcod    = ""    
         nv_agecod1  = ""     nv_agecod2  = ""     nv_comcod   = ""    
         nv_41cod1   = ""     nv_41cod2   = ""     nv_42cod    = ""    
         nv_43cod    = ""     nv_odcod    = ""     nv_othcod   = "".   

n_rpolicy = n_policy.

 FIND qpolmst_fil USE-INDEX qpolmst01 
WHERE qpolmst_fil.policy = n_rpolicy
  AND qpolmst_fil.rencnt = n_rencnt
  AND qpolmst_fil.endcnt = n_endcnt  NO-LOCK NO-ERROR NO-WAIT.

IF AVAIL qpolmst_fil THEN DO:    
    ASSIGN        
        nv_branch   = qpolmst_fil.branch
        nv_comdat   = qpolmst_fil.comdat
        nv_com1_per = qpolmst_fil.com1_per
        nv_stamp    = qpolmst_fil.rstp_t
        nv_totsi    = qpolmst_fil.sigr_p.
END.


FIND FIRST qmotmst_fil USE-INDEX qmotmst01    
     WHERE qmotmst_fil.policy = n_rpolicy
       AND qmotmst_fil.rencnt = n_rencnt
       AND qmotmst_fil.endcnt = n_endcnt
       AND qmotmst_fil.riskno = nv_riskno
       AND qmotmst_fil.itemno = nv_seqcar  NO-LOCK NO-ERROR.

IF NOT AVAIL qmotmst_fil THEN DO:
    n_chk = NO.

    MESSAGE "ไม่พบข้อมูลในระบบ!" SKIP
            "กรุณาเช็คเลข Quotation"
    VIEW-AS ALERT-BOX INFO.

    RETURN NO-APPLY.
END.
ELSE DO:
    IF qmotmst_fil.covcod <> "1" THEN DO:
        n_chk = NO.

        MESSAGE "ดึงข้อมูลได้เฉพาะงานประเภท 1 ค่ะ"
        VIEW-AS ALERT-BOX INFO.

        RETURN NO-APPLY.
    END.
    
    IF AVAIL qmotmst_fil THEN DO:       
        ASSIGN            
            nv_makcod = qmotmst_fil.modcod
            nv_carnam = qmotmst_fil.makdes
            nv_moddes = qmotmst_fil.moddes
            nv_imp    = qmotmst_fil.impor
            nv_vehgp  = TRIM(qmotmst_fil.cert)
            nv_makyea = qmotmst_fil.makyea
            nv_chasis = qmotmst_fil.cha_no
            nv_engine = qmotmst_fil.engine
            nv_prmpac = qmotmst_fil.prmpac
            nv_covtyp = qmotmst_fil.covcod
            nv_seats  = qmotmst_fil.seats
            nv_code   = qmotmst_fil.sclass
            nv_class  = qmotmst_fil.class
            nv_si     = qmotmst_fil.si_theft
            nv_tmpsi  = nv_si /*--- Patt 25/08/2003 ---*/
            nv_spcdev = qmotmst_fil.si_other
            nv_vehuse = qmotmst_fil.vehuse
            nv_tons   = qmotmst_fil.tons
            nv_garage = qmotmst_fil.garage
            nv_eng_no = qmotmst_fil.eng_no
            nv_licence1 = SUBSTR(qmotmst_fil.vehreg,1,3)
            nv_licence2 = SUBSTR(qmotmst_fil.vehreg,4,7).
    END.

     FIND qmotprm_fil USE-INDEX qmotprm01
    WHERE qmotprm_fil.policy = n_rpolicy
      AND qmotprm_fil.rencnt = n_rencnt
      AND qmotprm_fil.endcnt = n_endcnt
      AND qmotprm_fil.riskno = nv_riskno
      AND qmotprm_fil.itemno = nv_seqcar NO-LOCK NO-ERROR NO-WAIT.

     IF AVAIL qmotprm_fil THEN DO:
         ASSIGN
             n_chkpol    = TRIM(qmotmst_fil.policy) + STRING(qmotmst_fil.rencnt,"99")         
                         + STRING(qmotmst_fil.endcnt,"999") + STRING(qmotmst_fil.riskno,"999")
                         + STRING(qmotmst_fil.itemno,"999")
             n_number    = 1

             nv_bi1prm   = qmotprm_fil.bia              
             nv_bi2prm   = qmotprm_fil.lbia             
             nv_siprm    = qmotprm_fil.co               
             nv_useprm   = qmotprm_fil.co2              
             nv_gpprm    = qmotprm_fil.th               
             nv_yrprm    = qmotprm_fil.te               
             nv_engprm   = qmotprm_fil.ta               
             nv_driprm   = qmotprm_fil.rs               
             nv_dedpd    = qmotprm_fil.dedamt2          
             nv_ded2prm  = qmotprm_fil.dedprm2          
             nv_flet_per = qmotprm_fil.flet_per         
             nv_fletae   = qmotprm_fil.fletae           
             nv_flet     = qmotprm_fil.flet             
             nv_ncbyr    = qmotprm_fil.ncb_c            
             nv_ncbae    = qmotprm_fil.ncbae            
             nv_ncb_per  = qmotprm_fil.ncb_per          
             nv_ncb      = qmotprm_fil.ncb              
             nv_dss_per  = qmotprm_fil.dsspc_per        
             nv_dssae    = qmotprm_fil.dsspcae          
             nv_dsspc    = qmotprm_fil.dsspc            
             nv_cl_per   = qmotprm_fil.lodclm_per       
             nv_clae     = qmotprm_fil.lodclmae         
             nv_lodclm   = qmotprm_fil.lodclm           
             nv_stf_per  = qmotprm_fil.disstf_per       
             nv_stfae    = qmotprm_fil.disstfae         
             nv_stf_amt  = qmotprm_fil.disstf_amt       
             nv_seats    = qmotprm_fil.pass_41 + 1      
             nv_pdprm    = qmotprm_fil.pd               
             nv_411prm   = qmotprm_fil.prm411           
             nv_412prm   = qmotprm_fil.prm412           
             nv_42prm    = qmotprm_fil.prm42            
             nv_43prm    = qmotprm_fil.prm43            
             nv_prmpac   = qmotprm_fil.prmpac           
             nv_41       = qmotprm_fil.si_41            
             nv_42       = qmotprm_fil.si_42            
             nv_43       = qmotprm_fil.si_43            
             nv_tariff   = qmotprm_fil.tariff           
             nv_unit     = qmotprm_fil.unit             
             nv_biper    = qmotprm_fil.uom1_si          
             nv_biac     = qmotprm_fil.uom2_si          
             nv_pd       = qmotprm_fil.uom5_si          
             nv_totsi    = qmotprm_fil.uom6_si          
             nv_totsi    = qmotprm_fil.uom7_si          
             nv_comper   = qmotprm_fil.uom8_si          
             nv_compac   = qmotprm_fil.uom9_si          
             nv_dedod    = qmotprm_fil.dedamt           
             nv_ded1prm  = qmotprm_fil.dedprm_c         
             nv_addod    = INTEGER(qmotprm_fil.code_car)
             nv_aded1prm = qmotprm_fil.carren_c         
             nv_seat41   = qmotprm_fil.mv41seat         
             nv_baseprm  = qmotprm_fil.netprm           
             nv_uom6_u   = qmotprm_fil.uom6_u.          
     END.

     FIND LAST mailtxt_fil USE-INDEX mailtxt01                                                                           
         WHERE mailtxt_fil.policy = n_chkpol NO-LOCK NO-ERROR.                                                           
                                                                                                                         
     IF AVAIL mailtxt_fil THEN DO:      
         nv_drivno  = mailtxt_fil.lnumber.
         nv_drivnam = YES.

         FIND FIRST mailtxt_fil USE-INDEX mailtxt01                                                          
             /* WHERE mailtxt_fil.policy = nv_chkpol AND */                                                  
             WHERE mailtxt_fil.policy BEGINS n_rpolicy AND mailtxt_fil.lnumber = 1 NO-LOCK NO-ERROR NO-WAIT. 
         IF AVAIL mailtxt_fil THEN DO:                                                                       
             nv_age1 = INT(SUBSTRING(mailtxt_fil.ltext2,13,2)).                                              
         END.                                                                                                
                                                                                                             
         FIND NEXT mailtxt_fil USE-INDEX mailtxt01                                                           
             /* WHERE mailtxt_fil.policy = nv_chkpol AND */                                                  
             WHERE mailtxt_fil.policy BEGINS n_rpolicy AND mailtxt_fil.lnumber = 2 NO-LOCK NO-ERROR NO-WAIT. 
         IF AVAIL mailtxt_fil THEN DO:                                                                       
             nv_age2 = INT(SUBSTRING(mailtxt_fil.ltext2,13,2)).                                              
         END.                                                                                                
                                                                                                             
         Run wqu/wquagecd(Input-output  nv_age1, Input-output  nv_age2).                                      
                
         FIND FIRST mailtxt_fil USE-INDEX mailtxt01                                                                      
              WHERE mailtxt_fil.policy  = n_chkpol                                                                       
                AND mailtxt_fil.lnumber = n_number NO-LOCK NO-ERROR.                                                     
         IF AVAIL mailtxt_fil THEN DO:                                                                                   
              n_driv = 2.                                                                                                
                                                                                                                         
              IF TRIM(SUBSTR(mailtxt_fil.ltext,51,6)) <> "" THEN DO:                                                     
                  IF TRIM(SUBSTR(mailtxt_fil.ltext,51,6)) = "MALE"   OR                                                  
                     TRIM(SUBSTR(mailtxt_fil.ltext,51,6)) = "FEMALE" THEN DO:                                            
                                                                                                                         
                      n_drivnam1 = SUBSTR(mailtxt_fil.ltext,1,50).                                                       
                      n_sex1     = IF TRIM(SUBSTR(mailtxt_fil.ltext,51,6)) = "MALE" THEN 1 ELSE 2.                       
                  END.                                                                                                   
                  ELSE DO:                                                                                               
                      n_drivnam1 = SUBSTR(mailtxt_fil.ltext,1,30).                                                       
                      n_sex1     = IF TRIM(SUBSTR(mailtxt_fil.ltext,31,6)) = "MALE" THEN 1 ELSE 2.                       
                  END.                                                                                                   
              END.                                                                                                       
              ELSE DO:                                                                                                   
                  n_drivnam1 = SUBSTR(mailtxt_fil.ltext,1,30).                                                           
                  n_sex1     = IF TRIM(SUBSTR(mailtxt_fil.ltext,31,6)) = "MALE" THEN 1 ELSE 2.                           
              END.                                                                                                       
                                                                                                                         
              ASSIGN                                                                                                     
                  n_hbdri1    = DATE(INT(SUBSTR(mailtxt_fil.ltext2,4,2)),                                                
                                INT(SUBSTR(mailtxt_fil.ltext2,1,2)),                                                     
                                INT(SUBSTR(mailtxt_fil.ltext2,7,4)))                                                     
                  n_agedri1   = INT(SUBSTR(mailtxt_fil.ltext2,13,2))                                                     
                  n_occupdri1 = SUBSTR(mailtxt_fil.ltext2,16,30)                                                         
                  n_idnodri1  = SUBSTR(mailtxt_fil.ltext2,101,50).                                                       
         END.                                                                                                            
                                                                                                                         
         FIND NEXT mailtxt_fil USE-INDEX mailtxt01                                                                       
             WHERE mailtxt_fil.policy = n_chkpol NO-LOCK NO-ERROR.                                                       
                                                                                                                         
         IF AVAIL mailtxt_fil THEN DO:                                                                                   
             IF TRIM(SUBSTR(mailtxt_fil.ltext,51,6)) <> "" THEN DO:                                                      
                  IF TRIM(SUBSTR(mailtxt_fil.ltext,51,6)) = "MALE"   OR                                                  
                     TRIM(SUBSTR(mailtxt_fil.ltext,51,6)) = "FEMALE" THEN DO:                                            
                                                                                                                         
                      n_drivnam2 = SUBSTR(mailtxt_fil.ltext,1,50).                                                       
                      n_sex2     = IF TRIM(SUBSTR(mailtxt_fil.ltext,51,6)) = "MALE" THEN 1 ELSE 2.                       
                  END.                                                                                                   
                  ELSE DO:                                                                                               
                      n_drivnam2 = SUBSTR(mailtxt_fil.ltext,1,30).                                                       
                      n_sex2     = IF TRIM(SUBSTR(mailtxt_fil.ltext,31,6)) = "MALE" THEN 1 ELSE 2.                       
                  END.                                                                                                   
              END.                                                                                                       
              ELSE DO:                                                                                                   
                  n_drivnam2 = SUBSTR(mailtxt_fil.ltext,1,30).                                                           
                  n_sex2     = IF TRIM(SUBSTR(mailtxt_fil.ltext,31,6)) = "MALE" THEN 1 ELSE 2.                           
              END.                                                                                                       
                                                                                                                         
              ASSIGN                                                                                                     
                  n_hbdri2    = DATE(INT(SUBSTR(mailtxt_fil.ltext2,4,2)),                                                
                                INT(SUBSTR(mailtxt_fil.ltext2,1,2)),                                                     
                                INT(SUBSTR(mailtxt_fil.ltext2,7,4)))                                                     
                  n_agedri2   = INT(SUBSTR(mailtxt_fil.ltext2,13,2))                                                     
                  n_occupdri2 = SUBSTR(mailtxt_fil.ltext2,16,30)                                                         
                  n_idnodri2  = SUBSTR(mailtxt_fil.ltext2,101,50).                                                       
         END.                                                                                                            
     END.                                                                                                                
     ELSE DO:         
         nv_drivno  = 0.              
         nv_drivnam = NO.
         nv_drivcod = "A000".
     END.

     IF SUBSTRING(TRIM(nv_code),1,1) <> "1"                                                  
         AND SUBSTRING(TRIM(nv_code),1,1) <> "6"                                             
         AND SUBSTRING(TRIM(nv_code),1,1) <> "7" THEN DO:                                    
                                                                                             
         IF SUBSTRING(TRIM(nv_code),1,1) <> "2" THEN nv_engcod = "ENGT".                     
         ELSE nv_engcod = "ENGS".                                                            
     END.                                                                                    
     ELSE nv_engcod = "ENGC".                                                                
                                                                                                  
     FIND sym100 USE-INDEX sym10001                                                          
         WHERE sym100.tabcod = "U014" AND sym100.itmcod = nv_vehuse NO-LOCK NO-ERROR NO-WAIT.
     IF AVAIL sym100 THEN nv_usedes = sym100.itmdes.                                         
                                                                                             
     FIND sym100 USE-INDEX sym10001                                                          
         WHERE sym100.tabcod = "U019" AND sym100.itmcod = nv_prmpac NO-LOCK NO-ERROR NO-WAIT.
     IF AVAIL sym100 THEN nv_pacdes = sym100.itmdes.                                         
                                                                                             
     FIND sym100 USE-INDEX sym10001                                                          
         WHERE sym100.tabcod = "U013" AND sym100.itmcod = nv_covtyp NO-LOCK NO-ERROR NO-WAIT.
     IF AVAIL sym100 THEN nv_covdes = sym100.itmdes.                                                                                                                             
     
     nv_usecod = "USE" + TRIM(nv_vehuse).                                                                                                                               
     nv_yrcod  = "YR" + STRING((YEAR(nv_comdat) - nv_makyea) + 1).
     IF nv_gpcod = "" THEN nv_gpcod = "GRP" + TRIM(nv_vehgp).
     nv_biacod = "BI2".
     nv_sicod  = "SI".
     nv_bipcod = "BI1".
     nv_pdcod  = "PD".
     IF nv_comper <> 0 AND nv_compac <> 0 THEN DO:
         nv_comcod = "COMP".
     END.
     ELSE DO:
         nv_comcod = "".
         nv_comprm = 0.
     END.

     IF nv_41 <> 0 THEN DO:
         ASSIGN
             nv_41cod1 = "411"
             nv_41cod2 = "412"
             nv_411prm = nv_41
             nv_412prm = nv_41.
     END.
  
     IF nv_comcod <> "" THEN DO:
         RUN wqu\wqucomp (INPUT  nv_tariff,
                               nv_comcod,
                               nv_class,
                               nv_comdat,
                        OUTPUT nv_comprm).
     END.

     IF nv_41 <> 0 THEN DO:
         RUN wqu\wquper (INPUT nv_tariff,
                             nv_class,
                             nv_key_b,
                             nv_comdat).
     END.
     
     RUN wqu\wquprm.

     /* ------------ V70 -------------- */
     nv_totalp70 = nv_prem1 + nv_prem2 + nv_prem3.    

     nv_stamp70  = (nv_totalp70 * nv_stm_per) / 100.
     nv_chkstamp = nv_stamp70 - TRUNCATE(nv_stamp70,0).
     IF nv_chkstamp > 0 THEN nv_stamp70 = nv_stamp70 + 1.

     nv_tax70 = ((nv_totalp70 + TRUNCATE(nv_stamp70,0)) * nv_tax_per) / 100.

     /* ------------------------------- */

     /* ------------ V72 -------------- */
     IF nv_comprm <> 0 THEN DO:         
         nv_totalp72 = nv_comprm.    

         nv_stamp72  = (nv_totalp72 * nv_stm_per) / 100.    
         
         nv_chkstamp = nv_stamp72 - TRUNCATE(nv_stamp72,0). 
         IF nv_chkstamp > 0 THEN nv_stamp72 = nv_stamp72 + 1.     
         
         nv_tax72 = ((nv_totalp72 + TRUNCATE(nv_stamp72,0)) * nv_tax_per) / 100.
     END.
     /* ------------------------------- */
    
     ASSIGN
         /*n_brand    = nv_makcod*/                /*A62-0219*/
         /*n_model    = nv_carnam + nv_moddes*/    /*A62-0219*/
         n_redbook  = nv_makcod                    /*A62-0219*/
         n_brand    = nv_carnam                    /*A62-0219*/
         n_model    = nv_moddes                    /*A62-0219*/
         n_year     = STRING(nv_makyea)
         n_power    = nv_engine
         /*
         n_licence1 = nv_licence1
         n_licence2 = nv_licence2
         n_cha_no   = nv_chasis
         n_eng_no   = nv_eng_no
         */
         n_pack     = nv_prmpac
         n_class    = nv_code
         n_garage   = nv_garage
         n_sumsi    = nv_totsi
         n_gap      = nv_totalp70
         n_premium  = nv_totalp70 + TRUNCATE(nv_stamp70,0) + nv_tax70
         n_precomp  = nv_totalp72 + TRUNCATE(nv_stamp72,0) + nv_tax72
         n_totlepre = nv_total
         n_baseod   = nv_dedod
         /* A62-0219*/
         n_tpp      = string(nv_biper)
         n_tpa      = string(nv_biac)
         n_tpd      = string(nv_pd) 
         n_41       = string(nv_41) 
         n_42       = string(nv_42) 
         n_43       = string(nv_43).
      /* end a62-0219*/
END.
