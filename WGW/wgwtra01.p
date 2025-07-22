/*=================================================================                       */
/* Program Name : wgwtra01.P   Gen. Data Uwm100 To DB Premium                             */
/* Assign  No   : A56-0299                                                                */
/* CREATE  By   : Watsana K.          (Date 18/09/2013)                                   */
/*                ‚Õπ¢ÈÕ¡Ÿ≈®“° DB Gw Transfer To Premium                                  */
/* modify by   : Kridtiya i. A57-0391 date.27/11/2014 ‡æ‘Ë¡°“√‡™Á§‡≈¢°√¡∏√√¡Ï ∑’Ëæ∫„π√–∫∫ */
/*========================================================================================*/
DEF SHARED VAR      n_User    AS CHAR.
DEF INPUT PARAMETER nv_bchyr  AS INT.
DEF INPUT PARAMETER nv_bchno  AS CHAR.
DEF INPUT PARAMETER nv_bchcnt AS INT.
DEF INPUT PARAMETER nv_policy AS CHAR.
DEF INPUT PARAMETER nv_rencnt AS INT.
DEF INPUT PARAMETER nv_endcnt AS INT.
DEF INPUT PARAMETER n_insref  AS CHARACTER FORMAT "X(10)".
DEF    VAR nv_i          AS INT.
DEFINE VAR nv_fptr       AS RECID.
DEFINE VAR nv_bptr       AS RECID.
DEFINE BUFFER wf_uwd100 FOR sicuw.uwd100.
DEF  VAR             putchr      AS CHAR FORMAT "X(100)" INIT "" NO-UNDO. 
DEF  VAR             putchr1     AS CHAR FORMAT "X(80)"  INIT "" NO-UNDO. 
DEF INPUT  PARAMETER textchr     AS CHAR FORMAT "X(80)"  . 
DEF OUTPUT PARAMETER nv_message  AS CHAR FORMAT "X(200)".
DEF OUTPUT PARAMETER nv_error    AS LOGICAL .
nv_i = nv_i + 1.
FIND sic_bran.uwm100 USE-INDEX uwm10001 WHERE 
    sic_bran.uwm100.policy = nv_policy AND
    sic_bran.uwm100.rencnt = 0         AND
    sic_bran.uwm100.endcnt = 0         AND
    sic_bran.uwm100.bchyr  = nv_bchyr  AND
    sic_bran.uwm100.bchno  = nv_bchno  AND
    sic_bran.uwm100.bchcnt = nv_bchcnt NO-ERROR.
IF AVAIL sic_bran.uwm100 THEN DO:    
    FIND sicuw.uwm100 USE-INDEX uwm10001 WHERE 
        sicuw.uwm100.policy = sic_bran.uwm100.Policy AND
        sicuw.uwm100.rencnt = sic_bran.uwm100.rencnt AND
        sicuw.uwm100.endcnt = sic_bran.uwm100.endcnt NO-ERROR.
    IF NOT AVAIL sicuw.uwm100 THEN DO:   
        CREATE sicuw.uwm100.  
        ASSIGN
            sicuw.uwm100.fptr01 = 0                          /*First uwd100 Policy Up reci  */
            sicuw.uwm100.bptr01 = 0                          /*Last  uwd100 Policy Up reci  */
            sicuw.uwm100.fptr02 = 0                          /*First uwd102 Policy Me reci  */
            sicuw.uwm100.bptr02 = 0                          /*Last  uwd102 Policy Me reci  */
            sicuw.uwm100.fptr03 = 0                          /*First uwd105 Policy Cl reci  */
            sicuw.uwm100.bptr03 = 0                          /*Last  uwd105 Policy Cl reci  */
            sicuw.uwm100.fptr04 = 0                          /*First uwd103 Policy Re reci  */
            sicuw.uwm100.bptr04 = 0                          /*Last  uwd103 Policy Ren reci  */
            sicuw.uwm100.fptr05 = 0                          /*First uwd104 Policy En reci  */
            sicuw.uwm100.bptr05 = 0                          /*Last  uwd104 Policy End reci  */
            sicuw.uwm100.fptr06 = 0                          /*First uwd106 Pol.Endt. reci  */
            sicuw.uwm100.bptr06 = 0                          /*Last  uwd106 Pol. Endt. reci  */
            /* ----------------------------------- */          
            sicuw.uwm100.policy = sic_bran.uwm100.Policy     /*Policy No.             char  */
            sicuw.uwm100.rencnt = sic_bran.uwm100.rencnt     /*Renewal Count          inte  */
            sicuw.uwm100.endcnt = sic_bran.uwm100.endcnt     /*Endorsement Count      inte  */
            sicuw.uwm100.renno  = sic_bran.uwm100.renno      /*Renewal No.            char  */
            sicuw.uwm100.endno  = sic_bran.uwm100.endno      /*Endorsement No.        char  */
            sicuw.uwm100.curbil = sic_bran.uwm100.curbil     /*Currency of Billing    char  */
            sicuw.uwm100.curate = sic_bran.uwm100.curate     /*Currency rate for Bill deci-7*/
            sicuw.uwm100.branch = sic_bran.uwm100.branch     /*Branch Code (of Transa char  */ 
            sicuw.uwm100.dir_ri = sic_bran.uwm100.dir_ri     /*Direct/RI Code (D/R)   logi  */ 
            sicuw.uwm100.dept   = sic_bran.uwm100.dept       /*Department code        char  */ 
            sicuw.uwm100.cntry  = sic_bran.uwm100.cntry      /*Country where risk is  char  */ 
            sicuw.uwm100.agent  = sic_bran.uwm100.agent      /*Agent's Ref. No.       char  */   
            sicuw.uwm100.poltyp = sic_bran.uwm100.Poltyp     /*Policy Type            char  */
            sicuw.uwm100.insref = n_insref     /*Insured's Ref. No.     char  */
            sicuw.uwm100.opnpol = sic_bran.uwm100.opnpol     /*Open Cover/Master Poli char  */
            sicuw.uwm100.prvpol = sic_bran.uwm100.prvpol     /*Previous Policy No.    char  */
            sicuw.uwm100.ntitle = sic_bran.uwm100.ntitle     /*Title for Name Mr/Mrs/ char  */
            sicuw.uwm100.fname  = sic_bran.uwm100.fname      /*First Name             char  */
            sicuw.uwm100.name1  = sic_bran.uwm100.name1      /*Name of Insured Line 1 char  */
            sicuw.uwm100.name2  = sic_bran.uwm100.name2      /*Name of Insured Line 2 char  */
            sicuw.uwm100.name3  = sic_bran.uwm100.name3.     /*Name of Insured Line 3 char  */
        ASSIGN                                               
            sicuw.uwm100.addr1  = sic_bran.uwm100.addr1      /*Address 1              char  */
            sicuw.uwm100.addr2  = sic_bran.uwm100.addr2      /*Address 2              char  */
            sicuw.uwm100.addr3  = sic_bran.uwm100.addr3      /*Address 3              char  */
            sicuw.uwm100.addr4  = sic_bran.uwm100.addr4      /*Address 4              char  */
            sicuw.uwm100.postcd = sic_bran.uwm100.postcd     /*Postal Code            char  */
            sicuw.uwm100.occupn = sic_bran.uwm100.occupn     /*Occupation Description char  */
            sicuw.uwm100.comdat = sic_bran.uwm100.comdat     /*Cover Commencement Dat date  */
            sicuw.uwm100.expdat = sic_bran.uwm100.expdat     /*Expiry Date            date  */
            sicuw.uwm100.enddat = sic_bran.uwm100.enddat     /*Endorsement Date       date  */
            sicuw.uwm100.accdat = sic_bran.uwm100.accdat     /*Acceptance Date        date  */
         /*   sicuw.uwm100.trndat = sic_bran.uwm100.trndat     /*Transaction Date       date  */*/
            sicuw.uwm100.trndat = TODAY 
            sicuw.uwm100.rendat = sic_bran.uwm100.rendat     /*Date Renewal Notice Pr date  */
            sicuw.uwm100.terdat = sic_bran.uwm100.terdat     /*Termination Date       date  */
            sicuw.uwm100.fstdat = sic_bran.uwm100.fstdat     /*First Issue Date of Po date  */
            sicuw.uwm100.cn_dat = sic_bran.uwm100.cn_dat     /*Cover Note Date        date  */
            sicuw.uwm100.cn_no  = sic_bran.uwm100.cn_no      /*Cover Note No.         inte  */
            sicuw.uwm100.tranty = sic_bran.uwm100.tranty     /*Transaction Type (N/R/ char  */
            sicuw.uwm100.undyr  = sic_bran.uwm100.undyr      /*Underwriting Year      char  */
            sicuw.uwm100.acno1  = sic_bran.uwm100.acno1      /*Account no. 1          char  */
            sicuw.uwm100.acno2  = sic_bran.uwm100.acno2      /*Account no. 2          char  */
            sicuw.uwm100.acno3  = sic_bran.uwm100.acno3      /*Account no. 3          char  */
            sicuw.uwm100.instot = sic_bran.uwm100.instot     /*Total No. of Instalmen deci-0*/
            sicuw.uwm100.pstp   = sic_bran.uwm100.pstp       /*Policy Level Stamp     deci-2*/
            sicuw.uwm100.pfee   = sic_bran.uwm100.pfee       /*Policy Level Fee       deci-2*/
            sicuw.uwm100.ptax   = sic_bran.uwm100.ptax       /*Policy Level Tax       deci-2*/
            sicuw.uwm100.rstp_t = sic_bran.uwm100.rstp_t     /*Risk Level Stamp, Tran deci-2*/
            sicuw.uwm100.rfee_t = sic_bran.uwm100.rfee_t     /*Risk Level Fee, Tran.  deci-2*/
            sicuw.uwm100.rtax_t = sic_bran.uwm100.rtax_t     /*Risk Level Tax, Tran.  deci-2*/
            sicuw.uwm100.prem_t = sic_bran.uwm100.prem_t     /*Premium Due, Tran. Tot deci-2*/
            sicuw.uwm100.pdco_t = sic_bran.uwm100.pdco_t     /*PD Coinsurance, Tran.  deci-2*/
            sicuw.uwm100.pdst_t = sic_bran.uwm100.pdst_t     /*PD Statutory, Tran. to deci-2*/
            sicuw.uwm100.pdfa_t = sic_bran.uwm100.pdfa_t     /*PD Facultative, Tran.  deci-2*/
            sicuw.uwm100.pdty_t = sic_bran.uwm100.pdty_t     /*PD Treaty, Tran. Total deci-2*/
            sicuw.uwm100.pdqs_t = sic_bran.uwm100.pdqs_t.    /*PD Quota Share, Tran.  deci-2*/
        ASSIGN                                               
            sicuw.uwm100.com1_t = sic_bran.uwm100.com1_t     /*Commission 1, Tran. To deci-2*/
            sicuw.uwm100.com2_t = sic_bran.uwm100.com2_t     /*Commission 2, Tran. To deci-2*/
            sicuw.uwm100.com3_t = sic_bran.uwm100.com3_t     /*Commission 3, Tran. To deci-2*/
            sicuw.uwm100.com4_t = sic_bran.uwm100.com4_t     /*Commission 4, Tran. To deci-2*/
            sicuw.uwm100.coco_t = sic_bran.uwm100.coco_t     /*Comm. Coinsurance, Tra deci-2*/
            sicuw.uwm100.cost_t = sic_bran.uwm100.cost_t     /*Comm. Statutory, Tran. deci-2*/
            sicuw.uwm100.cofa_t = sic_bran.uwm100.cofa_t     /*Comm. Facultative, Tra deci-2*/
            sicuw.uwm100.coty_t = sic_bran.uwm100.coty_t     /*Comm. Treaty, Tran. To deci-2*/
            sicuw.uwm100.coqs_t = sic_bran.uwm100.coqs_t     /*Comm. Quota Share, Tra deci-2*/
            sicuw.uwm100.reduc1 = sic_bran.uwm100.reduc1     /*Reducing Balance 1 (Y/ logi  */
            sicuw.uwm100.reduc2 = sic_bran.uwm100.reduc2     /*Reducing Balance 2 (Y/ logi  */
            sicuw.uwm100.reduc3 = sic_bran.uwm100.reduc3     /*Reducing Balance 3 (Y/ logi  */
            sicuw.uwm100.gap_p  = sic_bran.uwm100.gap_p      /*Gross Annual Prem, Pol deci-2*/
            sicuw.uwm100.dl1_p  = sic_bran.uwm100.dl1_p      /*Discount/Loading 1, Po deci-2*/
            sicuw.uwm100.dl2_p  = sic_bran.uwm100.dl2_p      /*Discount/Loading 2, Po deci-2*/
            sicuw.uwm100.dl3_p  = sic_bran.uwm100.dl3_p      /*Discount/Loading 3, Po deci-2*/
            sicuw.uwm100.dl2red = sic_bran.uwm100.dl2red     /*Disc./Load 2 Red. Bala logi  */
            sicuw.uwm100.dl3red = sic_bran.uwm100.dl3red     /*Disc./Load 3 Red. Bala logi  */
            sicuw.uwm100.dl1sch = sic_bran.uwm100.dl1sch     /*Disc./Load 1 Prt on Sc logi  */
            sicuw.uwm100.dl2sch = sic_bran.uwm100.dl2sch     /*Disc./Load 2 Prt on Sc logi  */
            sicuw.uwm100.dl3sch = sic_bran.uwm100.dl3sch     /*Disc./Load 3 Prt on Sc logi  */
            sicuw.uwm100.drnoae = sic_bran.uwm100.drnoae     /*Dr/Cr Note No. (A/E)   logi  */
            sicuw.uwm100.insddr = sic_bran.uwm100.insddr     /*Print Insd. Name on Dr logi  */
            sicuw.uwm100.trty11 = sic_bran.uwm100.trty11     /*Tran. Type (1), A/C No char  */
            sicuw.uwm100.trty12 = sic_bran.uwm100.trty12     /*Tran. Type (1), A/C No char  */
            sicuw.uwm100.trty13 = sic_bran.uwm100.trty13     /*Tran. Type (1), A/C No char  */
            sicuw.uwm100.docno1 = sic_bran.uwm100.docno1     /*Document No., A/C No.  char  */
            sicuw.uwm100.docno2 = sic_bran.uwm100.docno2     /*Document No., A/C No.  char  */
            sicuw.uwm100.docno3 = sic_bran.uwm100.docno3     /*Document No., A/C No.  char  */
            sicuw.uwm100.no_sch = sic_bran.uwm100.no_sch     /*No. to print, Schedule inte  */
            sicuw.uwm100.no_dr  = sic_bran.uwm100.no_dr      /*No. to print, Dr/Cr No inte  */
            sicuw.uwm100.no_ri  = sic_bran.uwm100.no_ri      /*No. to print, RI Appln inte  */
            sicuw.uwm100.no_cer = sic_bran.uwm100.no_cer.    /*No. to print, Certific inte  */
        ASSIGN                                               
            sicuw.uwm100.li_sch = sic_bran.uwm100.li_sch     /*Print Later/Imm., Sche logi  */
            sicuw.uwm100.li_dr  = sic_bran.uwm100.li_dr      /*Print Later/Imm., Dr/C logi  */
            sicuw.uwm100.li_ri  = sic_bran.uwm100.li_ri      /*Print Later/Imm., RI A logi  */
            sicuw.uwm100.li_cer = sic_bran.uwm100.li_cer     /*Print Later/Imm., Cert logi  */
            sicuw.uwm100.scform = sic_bran.uwm100.scform     /*Schedule Format        char  */
            sicuw.uwm100.enform = sic_bran.uwm100.enform     /*Endt. Format (Full/Abb char  */
            sicuw.uwm100.apptax = sic_bran.uwm100.apptax     /*Apply risk level tax ( logi  */
            sicuw.uwm100.dl1cod = sic_bran.uwm100.dl1cod     /*Discount/Loading Type  char  */
            sicuw.uwm100.dl2cod = sic_bran.uwm100.dl2cod     /*Discount/Loading Type  char  */
            sicuw.uwm100.dl3cod = sic_bran.uwm100.dl3cod     /*Discount/Loading Type  char  */
            sicuw.uwm100.styp20 = sic_bran.uwm100.styp20     /*Statistic Type Codes ( char  */
            sicuw.uwm100.sval20 = sic_bran.uwm100.sval20     /*Statistic Value Codes  char  */
            sicuw.uwm100.finint = sic_bran.uwm100.finint     /*Financial Interest Ref char  */
            sicuw.uwm100.cedco  = sic_bran.uwm100.cedco      /*Ceding Co. No.         char  */
            sicuw.uwm100.cedsi  = sic_bran.uwm100.cedsi      /*Ceding Co. Sum Insured deci-2*/
            sicuw.uwm100.cedpol = sic_bran.uwm100.cedpol     /*Ceding Co. Policy No.  char  */
            sicuw.uwm100.cedces = sic_bran.uwm100.cedces     /*Ceding Co. Cession No. char  */
            sicuw.uwm100.recip  = sic_bran.uwm100.recip      /*Reciprocal (Y/N/C)     char  */
            sicuw.uwm100.short  = sic_bran.uwm100.short      /*Short Term Rates       logi  */
            sicuw.uwm100.receit = sic_bran.uwm100.receit     /*Receipt No.            char  */
            sicuw.uwm100.coins  = sic_bran.uwm100.coins      /*Is this Coinsurance (Y logi  */
            sicuw.uwm100.billco = sic_bran.uwm100.billco     /*Bill Coinsurer's Share char  */
            sicuw.uwm100.pmhead = sic_bran.uwm100.pmhead     /*Premium Headings on Sc char  */
            sicuw.uwm100.usrid  = n_User /*sic_bran.uwm100.usrid      /*User Id                char  */*/
            sicuw.uwm100.entdat = sic_bran.uwm100.entdat     /*Entered Date           date  */
            /*  sicuw.uwm100.enttim = sic_bran.uwm100.enttim     /*Entered Time           char  */*/
            sicuw.uwm100.prog   = "wgwtra01" + "|" + STRING(nv_bchyr,"9999") +
                                  STRING(nv_bchno) +
                                  STRING(nv_bchcnt,"99")     /*Program Id that input  char  */
            /*sicuw.uwm100.usridr = ""                        /*Release User Id        char  */
            sicuw.uwm100.reldat = TODAY                      /*Release Date           date  */
            sicuw.uwm100.reltim = STRING(TIME,"HH:MM:SS")    /*Release Time           char  */
            sicuw.uwm100.releas = sic_bran.uwm100.releas     /*Transaction Released   logi  */*/
            sicuw.uwm100.polsta = sic_bran.uwm100.polsta     /*Policy Status          char  */
            sicuw.uwm100.rilate = sic_bran.uwm100.rilate     /*RI to Enter Later      logi  */
            sicuw.uwm100.sch_p  = sic_bran.uwm100.sch_p      /*Schedule Printed       logi  */
            sicuw.uwm100.drn_p  = sic_bran.uwm100.drn_p      /*Dr/Cr Note Printed     logi  */
            sicuw.uwm100.ri_p   = sic_bran.uwm100.ri_p       /*RI Application Printed logi  */
            sicuw.uwm100.cert_p = sic_bran.uwm100.cert_p     /*Certificate Printed    logi  */
            sicuw.uwm100.dreg_p = sic_bran.uwm100.dreg_p.    /*Daily Prem. Reg. Print logi  */
        ASSIGN                                               
            sicuw.uwm100.langug = sic_bran.uwm100.langug     /*Language               char  */
            sicuw.uwm100.sigr_p = sic_bran.uwm100.sigr_p     /*SI Gross Pol. Total    deci-2*/
            sicuw.uwm100.sico_p = sic_bran.uwm100.sico_p     /*SI Coinsurance Pol. To deci-2*/
            sicuw.uwm100.sist_p = sic_bran.uwm100.sist_p     /*SI Statutory Pol. Tota deci-2*/
            sicuw.uwm100.sifa_p = sic_bran.uwm100.sifa_p     /*SI Facultative Pol. To deci-2*/
            sicuw.uwm100.sity_p = sic_bran.uwm100.sity_p     /*SI Treaty Pol. Total   deci-2*/
            sicuw.uwm100.siqs_p = sic_bran.uwm100.siqs_p     /*SI Quota Share Pol. To deci-2*/
            sicuw.uwm100.renpol = sic_bran.uwm100.renpol     /*Renewal Policy No.     char  */
            sicuw.uwm100.co_per = sic_bran.uwm100.co_per     /*Coinsurance %          deci-2*/
            sicuw.uwm100.acctim = sic_bran.uwm100.acctim     /*Acceptance Time        char  */
            sicuw.uwm100.agtref = sic_bran.uwm100.agtref     /*Agents Closing Referen char  */
            sicuw.uwm100.sckno  = sic_bran.uwm100.sckno      /*sticker no.            inte  */
            sicuw.uwm100.anam1  = sic_bran.uwm100.anam1      /*Alternative Insured Na char  */
            sicuw.uwm100.sirt_p = sic_bran.uwm100.sirt_p     /*SI RETENTION Pol. tota deci-2*/
            sicuw.uwm100.anam2  = sic_bran.uwm100.anam2      /*Alternative Insured Na char  */
            sicuw.uwm100.gstrat = sic_bran.uwm100.gstrat     /*GST Rate %             deci-2*/
            sicuw.uwm100.prem_g = sic_bran.uwm100.prem_g     /*Premium GST            deci-2*/
            sicuw.uwm100.com1_g = sic_bran.uwm100.com1_g     /*Commission 1 GST       deci-2*/
            sicuw.uwm100.com3_g = sic_bran.uwm100.com3_g     /*Commission 3 GST       deci-2*/
            sicuw.uwm100.com4_g = sic_bran.uwm100.com4_g     /*Commission 4 GST       deci-2*/
            sicuw.uwm100.gstae  = sic_bran.uwm100.gstae      /*GST A/E                logi  */
            sicuw.uwm100.nr_pol = sic_bran.uwm100.nr_pol     /*New Policy No. (Y/N)   logi  */
            sicuw.uwm100.issdat = sic_bran.uwm100.issdat     /*Issue date             date  */
            /* --------- */                                    
            sicuw.uwm100.cr_1   = sic_bran.uwm100.cr_1       /*PRODUCT TYPE                 */
            sicuw.uwm100.cr_2   = sic_bran.uwm100.cr_2       /*APPEND POLICY                */
            sicuw.uwm100.cr_3   = sic_bran.uwm100.cr_3       /*                             */
            sicuw.uwm100.bs_cd  = sic_bran.uwm100.bs_cd      /*VAT CODE                     */
            /* --------- */                                    
            sicuw.uwm100.rt_er  = sic_bran.uwm100.rt_er      /*Batch Release          logi  */
            sicuw.uwm100.endern = sic_bran.uwm100.endern.     /*End Date of Earned Pre date  */
        IF sic_bran.uwm100.fptr01 <> ? AND sic_bran.uwm100.fptr01 <> 0 THEN DO:
            /* ADD NEW DATA */
            nv_bptr = 0.
            FOR EACH sic_bran.uwd100 WHERE sic_bran.uwd100.policy = sic_bran.uwm100.Policy NO-LOCK:
                CREATE sicuw.uwd100.
                ASSIGN sicuw.uwd100.policy  = sic_bran.uwm100.Policy 
                    sicuw.uwd100.rencnt     = sic_bran.uwm100.rencnt
                    sicuw.uwd100.endcnt     = sic_bran.uwm100.endcnt
                    sicuw.uwd100.ltext      = sic_bran.uwd100.ltext
                    sicuw.uwd100.fptr       = 0
                    sicuw.uwd100.bptr       = nv_bptr.
                IF nv_bptr <> 0 THEN DO:
                    FIND wf_uwd100 WHERE RECID(wf_uwd100) = nv_bptr.
                    wf_uwd100.fptr = RECID(sicuw.uwd100).
                END.
                IF nv_bptr = 0 THEN  sicuw.uwm100.fptr01 = RECID(sicuw.uwd100).
                nv_bptr = RECID(sicuw.uwd100).
            END.  /* End FOR EACH poltxt_fil */
            sicuw.uwm100.bptr01 = nv_bptr.            
        END.
        ASSIGN sic_bran.uwm100.releas = YES.  /*--Update Status Releas--*/
               sic_bran.uwm100.trfflg = YES.  /*--Update Status Transfer To Premium --*/
    END.  /*-NOT AVAIL sicuw.uwm100 -*/
    ELSE DO:
        /*add by kridtiya i. A57-0391*/
        IF sicuw.uwm100.releas = YES THEN     
            ASSIGN putchr1 = "æ∫°√¡∏√√¡Ï´È”„π√–∫∫ "
            putchr         = textchr + "  " + TRIM(putchr1) 
            nv_message     = putchr1
            nv_error       = YES.
        ELSE IF (sicuw.uwm100.name1 <> "") AND (sicuw.uwm100.comdat <> ?) THEN  /*A57-0391*/
            ASSIGN putchr1 = "æ∫°√¡∏√√¡Ï´È”„π√–∫∫ "
            putchr         = textchr + "  " + TRIM(putchr1)
            nv_message     = putchr1
            nv_error       = YES.
        ELSE DO:  /*add by kridtiya i. A57-0391*/
            ASSIGN
                sicuw.uwm100.fptr01 = 0                          /*First uwd100 Policy Up reci  */
                sicuw.uwm100.bptr01 = 0                          /*Last  uwd100 Policy Up reci  */
                sicuw.uwm100.fptr02 = 0                          /*First uwd102 Policy Me reci  */
                sicuw.uwm100.bptr02 = 0                          /*Last  uwd102 Policy Me reci  */
                sicuw.uwm100.fptr03 = 0                          /*First uwd105 Policy Cl reci  */
                sicuw.uwm100.bptr03 = 0                          /*Last  uwd105 Policy Cl reci  */
                sicuw.uwm100.fptr04 = 0                          /*First uwd103 Policy Re reci  */
                sicuw.uwm100.bptr04 = 0                          /*Last  uwd103 Policy Ren reci  */
                sicuw.uwm100.fptr05 = 0                          /*First uwd104 Policy En reci  */
                sicuw.uwm100.bptr05 = 0                          /*Last  uwd104 Policy End reci  */
                sicuw.uwm100.fptr06 = 0                          /*First uwd106 Pol.Endt. reci  */
                sicuw.uwm100.bptr06 = 0                          /*Last  uwd106 Pol. Endt. reci  */
                sicuw.uwm100.policy = sic_bran.uwm100.Policy     /*Policy No.             char  */
                sicuw.uwm100.rencnt = sic_bran.uwm100.rencnt     /*Renewal Count          inte  */
                sicuw.uwm100.endcnt = sic_bran.uwm100.endcnt     /*Endorsement Count      inte  */
                sicuw.uwm100.renno  = sic_bran.uwm100.renno      /*Renewal No.            char  */
                sicuw.uwm100.endno  = sic_bran.uwm100.endno      /*Endorsement No.        char  */
                sicuw.uwm100.curbil = sic_bran.uwm100.curbil     /*Currency of Billing    char  */
                sicuw.uwm100.curate = sic_bran.uwm100.curate     /*Currency rate for Bill deci-7*/
                sicuw.uwm100.branch = sic_bran.uwm100.branch     /*Branch Code (of Transa char  */ 
                sicuw.uwm100.dir_ri = sic_bran.uwm100.dir_ri     /*Direct/RI Code (D/R)   logi  */ 
                sicuw.uwm100.dept   = sic_bran.uwm100.dept       /*Department code        char  */ 
                sicuw.uwm100.cntry  = sic_bran.uwm100.cntry      /*Country where risk is  char  */ 
                sicuw.uwm100.agent  = sic_bran.uwm100.agent      /*Agent's Ref. No.       char  */   
                sicuw.uwm100.poltyp = sic_bran.uwm100.Poltyp     /*Policy Type            char  */
                sicuw.uwm100.insref = n_insref                   /*Insured's Ref. No.     char  */
                sicuw.uwm100.opnpol = sic_bran.uwm100.opnpol     /*Open Cover/Master Poli char  */
                sicuw.uwm100.prvpol = sic_bran.uwm100.prvpol     /*Previous Policy No.    char  */
                sicuw.uwm100.ntitle = sic_bran.uwm100.ntitle     /*Title for Name Mr/Mrs/ char  */
                sicuw.uwm100.fname  = sic_bran.uwm100.fname      /*First Name             char  */
                sicuw.uwm100.name1  = sic_bran.uwm100.name1      /*Name of Insured Line 1 char  */
                sicuw.uwm100.name2  = sic_bran.uwm100.name2      /*Name of Insured Line 2 char  */
                sicuw.uwm100.name3  = sic_bran.uwm100.name3.     /*Name of Insured Line 3 char  */
            ASSIGN                                               
                sicuw.uwm100.addr1  = sic_bran.uwm100.addr1      /*Address 1              char  */
                sicuw.uwm100.addr2  = sic_bran.uwm100.addr2      /*Address 2              char  */
                sicuw.uwm100.addr3  = sic_bran.uwm100.addr3      /*Address 3              char  */
                sicuw.uwm100.addr4  = sic_bran.uwm100.addr4      /*Address 4              char  */
                sicuw.uwm100.postcd = sic_bran.uwm100.postcd     /*Postal Code            char  */
                sicuw.uwm100.occupn = sic_bran.uwm100.occupn     /*Occupation Description char  */
                sicuw.uwm100.comdat = sic_bran.uwm100.comdat     /*Cover Commencement Dat date  */
                sicuw.uwm100.expdat = sic_bran.uwm100.expdat     /*Expiry Date            date  */
                sicuw.uwm100.enddat = sic_bran.uwm100.enddat     /*Endorsement Date       date  */
                sicuw.uwm100.accdat = sic_bran.uwm100.accdat     /*Acceptance Date        date  */
                sicuw.uwm100.trndat = TODAY 
                sicuw.uwm100.rendat = sic_bran.uwm100.rendat     /*Date Renewal Notice Pr date  */
                sicuw.uwm100.terdat = sic_bran.uwm100.terdat     /*Termination Date       date  */
                sicuw.uwm100.fstdat = sic_bran.uwm100.fstdat     /*First Issue Date of Po date  */
                sicuw.uwm100.cn_dat = sic_bran.uwm100.cn_dat     /*Cover Note Date        date  */
                sicuw.uwm100.cn_no  = sic_bran.uwm100.cn_no      /*Cover Note No.         inte  */
                sicuw.uwm100.tranty = sic_bran.uwm100.tranty     /*Transaction Type (N/R/ char  */
                sicuw.uwm100.undyr  = sic_bran.uwm100.undyr      /*Underwriting Year      char  */
                sicuw.uwm100.acno1  = sic_bran.uwm100.acno1      /*Account no. 1          char  */
                sicuw.uwm100.acno2  = sic_bran.uwm100.acno2      /*Account no. 2          char  */
                sicuw.uwm100.acno3  = sic_bran.uwm100.acno3      /*Account no. 3          char  */
                sicuw.uwm100.instot = sic_bran.uwm100.instot     /*Total No. of Instalmen deci-0*/
                sicuw.uwm100.pstp   = sic_bran.uwm100.pstp       /*Policy Level Stamp     deci-2*/
                sicuw.uwm100.pfee   = sic_bran.uwm100.pfee       /*Policy Level Fee       deci-2*/
                sicuw.uwm100.ptax   = sic_bran.uwm100.ptax       /*Policy Level Tax       deci-2*/
                sicuw.uwm100.rstp_t = sic_bran.uwm100.rstp_t     /*Risk Level Stamp, Tran deci-2*/
                sicuw.uwm100.rfee_t = sic_bran.uwm100.rfee_t     /*Risk Level Fee, Tran.  deci-2*/
                sicuw.uwm100.rtax_t = sic_bran.uwm100.rtax_t     /*Risk Level Tax, Tran.  deci-2*/
                sicuw.uwm100.prem_t = sic_bran.uwm100.prem_t     /*Premium Due, Tran. Tot deci-2*/
                sicuw.uwm100.pdco_t = sic_bran.uwm100.pdco_t     /*PD Coinsurance, Tran.  deci-2*/
                sicuw.uwm100.pdst_t = sic_bran.uwm100.pdst_t     /*PD Statutory, Tran. to deci-2*/
                sicuw.uwm100.pdfa_t = sic_bran.uwm100.pdfa_t     /*PD Facultative, Tran.  deci-2*/
                sicuw.uwm100.pdty_t = sic_bran.uwm100.pdty_t     /*PD Treaty, Tran. Total deci-2*/
                sicuw.uwm100.pdqs_t = sic_bran.uwm100.pdqs_t.    /*PD Quota Share, Tran.  deci-2*/
            ASSIGN                                               
                sicuw.uwm100.com1_t = sic_bran.uwm100.com1_t     /*Commission 1, Tran. To deci-2*/
                sicuw.uwm100.com2_t = sic_bran.uwm100.com2_t     /*Commission 2, Tran. To deci-2*/
                sicuw.uwm100.com3_t = sic_bran.uwm100.com3_t     /*Commission 3, Tran. To deci-2*/
                sicuw.uwm100.com4_t = sic_bran.uwm100.com4_t     /*Commission 4, Tran. To deci-2*/
                sicuw.uwm100.coco_t = sic_bran.uwm100.coco_t     /*Comm. Coinsurance, Tra deci-2*/
                sicuw.uwm100.cost_t = sic_bran.uwm100.cost_t     /*Comm. Statutory, Tran. deci-2*/
                sicuw.uwm100.cofa_t = sic_bran.uwm100.cofa_t     /*Comm. Facultative, Tra deci-2*/
                sicuw.uwm100.coty_t = sic_bran.uwm100.coty_t     /*Comm. Treaty, Tran. To deci-2*/
                sicuw.uwm100.coqs_t = sic_bran.uwm100.coqs_t     /*Comm. Quota Share, Tra deci-2*/
                sicuw.uwm100.reduc1 = sic_bran.uwm100.reduc1     /*Reducing Balance 1 (Y/ logi  */
                sicuw.uwm100.reduc2 = sic_bran.uwm100.reduc2     /*Reducing Balance 2 (Y/ logi  */
                sicuw.uwm100.reduc3 = sic_bran.uwm100.reduc3     /*Reducing Balance 3 (Y/ logi  */
                sicuw.uwm100.gap_p  = sic_bran.uwm100.gap_p      /*Gross Annual Prem, Pol deci-2*/
                sicuw.uwm100.dl1_p  = sic_bran.uwm100.dl1_p      /*Discount/Loading 1, Po deci-2*/
                sicuw.uwm100.dl2_p  = sic_bran.uwm100.dl2_p      /*Discount/Loading 2, Po deci-2*/
                sicuw.uwm100.dl3_p  = sic_bran.uwm100.dl3_p      /*Discount/Loading 3, Po deci-2*/
                sicuw.uwm100.dl2red = sic_bran.uwm100.dl2red     /*Disc./Load 2 Red. Bala logi  */
                sicuw.uwm100.dl3red = sic_bran.uwm100.dl3red     /*Disc./Load 3 Red. Bala logi  */
                sicuw.uwm100.dl1sch = sic_bran.uwm100.dl1sch     /*Disc./Load 1 Prt on Sc logi  */
                sicuw.uwm100.dl2sch = sic_bran.uwm100.dl2sch     /*Disc./Load 2 Prt on Sc logi  */
                sicuw.uwm100.dl3sch = sic_bran.uwm100.dl3sch     /*Disc./Load 3 Prt on Sc logi  */
                sicuw.uwm100.drnoae = sic_bran.uwm100.drnoae     /*Dr/Cr Note No. (A/E)   logi  */
                sicuw.uwm100.insddr = sic_bran.uwm100.insddr     /*Print Insd. Name on Dr logi  */
                sicuw.uwm100.trty11 = sic_bran.uwm100.trty11     /*Tran. Type (1), A/C No char  */
                sicuw.uwm100.trty12 = sic_bran.uwm100.trty12     /*Tran. Type (1), A/C No char  */
                sicuw.uwm100.trty13 = sic_bran.uwm100.trty13     /*Tran. Type (1), A/C No char  */
                sicuw.uwm100.docno1 = sic_bran.uwm100.docno1     /*Document No., A/C No.  char  */
                sicuw.uwm100.docno2 = sic_bran.uwm100.docno2     /*Document No., A/C No.  char  */
                sicuw.uwm100.docno3 = sic_bran.uwm100.docno3     /*Document No., A/C No.  char  */
                sicuw.uwm100.no_sch = sic_bran.uwm100.no_sch     /*No. to print, Schedule inte  */
                sicuw.uwm100.no_dr  = sic_bran.uwm100.no_dr      /*No. to print, Dr/Cr No inte  */
                sicuw.uwm100.no_ri  = sic_bran.uwm100.no_ri      /*No. to print, RI Appln inte  */
                sicuw.uwm100.no_cer = sic_bran.uwm100.no_cer.    /*No. to print, Certific inte  */
            ASSIGN                                               
                sicuw.uwm100.li_sch = sic_bran.uwm100.li_sch     /*Print Later/Imm., Sche logi  */
                sicuw.uwm100.li_dr  = sic_bran.uwm100.li_dr      /*Print Later/Imm., Dr/C logi  */
                sicuw.uwm100.li_ri  = sic_bran.uwm100.li_ri      /*Print Later/Imm., RI A logi  */
                sicuw.uwm100.li_cer = sic_bran.uwm100.li_cer     /*Print Later/Imm., Cert logi  */
                sicuw.uwm100.scform = sic_bran.uwm100.scform     /*Schedule Format        char  */
                sicuw.uwm100.enform = sic_bran.uwm100.enform     /*Endt. Format (Full/Abb char  */
                sicuw.uwm100.apptax = sic_bran.uwm100.apptax     /*Apply risk level tax ( logi  */
                sicuw.uwm100.dl1cod = sic_bran.uwm100.dl1cod     /*Discount/Loading Type  char  */
                sicuw.uwm100.dl2cod = sic_bran.uwm100.dl2cod     /*Discount/Loading Type  char  */
                sicuw.uwm100.dl3cod = sic_bran.uwm100.dl3cod     /*Discount/Loading Type  char  */
                sicuw.uwm100.styp20 = sic_bran.uwm100.styp20     /*Statistic Type Codes ( char  */
                sicuw.uwm100.sval20 = sic_bran.uwm100.sval20     /*Statistic Value Codes  char  */
                sicuw.uwm100.finint = sic_bran.uwm100.finint     /*Financial Interest Ref char  */
                sicuw.uwm100.cedco  = sic_bran.uwm100.cedco      /*Ceding Co. No.         char  */
                sicuw.uwm100.cedsi  = sic_bran.uwm100.cedsi      /*Ceding Co. Sum Insured deci-2*/
                sicuw.uwm100.cedpol = sic_bran.uwm100.cedpol     /*Ceding Co. Policy No.  char  */
                sicuw.uwm100.cedces = sic_bran.uwm100.cedces     /*Ceding Co. Cession No. char  */
                sicuw.uwm100.recip  = sic_bran.uwm100.recip      /*Reciprocal (Y/N/C)     char  */
                sicuw.uwm100.short  = sic_bran.uwm100.short      /*Short Term Rates       logi  */
                sicuw.uwm100.receit = sic_bran.uwm100.receit     /*Receipt No.            char  */
                sicuw.uwm100.coins  = sic_bran.uwm100.coins      /*Is this Coinsurance (Y logi  */
                sicuw.uwm100.billco = sic_bran.uwm100.billco     /*Bill Coinsurer's Share char  */
                sicuw.uwm100.pmhead = sic_bran.uwm100.pmhead     /*Premium Headings on Sc char  */
                sicuw.uwm100.usrid  = n_User                     /*sic_bran.uwm100.usrid    /*User Id   char  */*/
                sicuw.uwm100.entdat = sic_bran.uwm100.entdat     /*Entered Date           date  */
                /*  sicuw.uwm100.enttim = sic_bran.uwm100.enttim     /*Entered Time           char  */*/
                sicuw.uwm100.prog   = "wgwtra01" + "|" + STRING(nv_bchyr,"9999") +
                                      STRING(nv_bchno) +
                                      STRING(nv_bchcnt,"99")     /*Program Id that input  char  */
                /*sicuw.uwm100.usridr = ""                       /*Release User Id        char  */
                sicuw.uwm100.reldat = TODAY                      /*Release Date           date  */
                sicuw.uwm100.reltim = STRING(TIME,"HH:MM:SS")    /*Release Time           char  */
                sicuw.uwm100.releas = sic_bran.uwm100.releas     /*Transaction Released   logi  */  */
                sicuw.uwm100.polsta = sic_bran.uwm100.polsta     /*Policy Status          char  */
                sicuw.uwm100.rilate = sic_bran.uwm100.rilate     /*RI to Enter Later      logi  */
                sicuw.uwm100.sch_p  = sic_bran.uwm100.sch_p      /*Schedule Printed       logi  */
                sicuw.uwm100.drn_p  = sic_bran.uwm100.drn_p      /*Dr/Cr Note Printed     logi  */
                sicuw.uwm100.ri_p   = sic_bran.uwm100.ri_p       /*RI Application Printed logi  */
                sicuw.uwm100.cert_p = sic_bran.uwm100.cert_p     /*Certificate Printed    logi  */
                sicuw.uwm100.dreg_p = sic_bran.uwm100.dreg_p.    /*Daily Prem. Reg. Print logi  */
            ASSIGN                                               
                sicuw.uwm100.langug = sic_bran.uwm100.langug     /*Language               char  */
                sicuw.uwm100.sigr_p = sic_bran.uwm100.sigr_p     /*SI Gross Pol. Total    deci-2*/
                sicuw.uwm100.sico_p = sic_bran.uwm100.sico_p     /*SI Coinsurance Pol. To deci-2*/
                sicuw.uwm100.sist_p = sic_bran.uwm100.sist_p     /*SI Statutory Pol. Tota deci-2*/
                sicuw.uwm100.sifa_p = sic_bran.uwm100.sifa_p     /*SI Facultative Pol. To deci-2*/
                sicuw.uwm100.sity_p = sic_bran.uwm100.sity_p     /*SI Treaty Pol. Total   deci-2*/
                sicuw.uwm100.siqs_p = sic_bran.uwm100.siqs_p     /*SI Quota Share Pol. To deci-2*/
                sicuw.uwm100.renpol = sic_bran.uwm100.renpol     /*Renewal Policy No.     char  */
                sicuw.uwm100.co_per = sic_bran.uwm100.co_per     /*Coinsurance %          deci-2*/
                sicuw.uwm100.acctim = sic_bran.uwm100.acctim     /*Acceptance Time        char  */
                sicuw.uwm100.agtref = sic_bran.uwm100.agtref     /*Agents Closing Referen char  */
                sicuw.uwm100.sckno  = sic_bran.uwm100.sckno      /*sticker no.            inte  */
                sicuw.uwm100.anam1  = sic_bran.uwm100.anam1      /*Alternative Insured Na char  */
                sicuw.uwm100.sirt_p = sic_bran.uwm100.sirt_p     /*SI RETENTION Pol. tota deci-2*/
                sicuw.uwm100.anam2  = sic_bran.uwm100.anam2      /*Alternative Insured Na char  */
                sicuw.uwm100.gstrat = sic_bran.uwm100.gstrat     /*GST Rate %             deci-2*/
                sicuw.uwm100.prem_g = sic_bran.uwm100.prem_g     /*Premium GST            deci-2*/
                sicuw.uwm100.com1_g = sic_bran.uwm100.com1_g     /*Commission 1 GST       deci-2*/
                sicuw.uwm100.com3_g = sic_bran.uwm100.com3_g     /*Commission 3 GST       deci-2*/
                sicuw.uwm100.com4_g = sic_bran.uwm100.com4_g     /*Commission 4 GST       deci-2*/
                sicuw.uwm100.gstae  = sic_bran.uwm100.gstae      /*GST A/E                logi  */
                sicuw.uwm100.nr_pol = sic_bran.uwm100.nr_pol     /*New Policy No. (Y/N)   logi  */
                sicuw.uwm100.issdat = sic_bran.uwm100.issdat     /*Issue date             date  */
                sicuw.uwm100.cr_1   = sic_bran.uwm100.cr_1       /*PRODUCT TYPE                 */
                sicuw.uwm100.cr_2   = sic_bran.uwm100.cr_2       /*APPEND POLICY                */
                sicuw.uwm100.cr_3   = sic_bran.uwm100.cr_3       /*                             */
                sicuw.uwm100.bs_cd  = sic_bran.uwm100.bs_cd      /*VAT CODE                     */
                sicuw.uwm100.rt_er  = sic_bran.uwm100.rt_er      /*Batch Release          logi  */
                sicuw.uwm100.endern = sic_bran.uwm100.endern.     /*End Date of Earned Pre date  */           
            IF sic_bran.uwm100.fptr01 <> ? AND sic_bran.uwm100.fptr01 <> 0 THEN DO:
                /* ADD NEW DATA */
                nv_bptr = 0.
                FOR EACH sic_bran.uwd100 WHERE
                    sic_bran.uwd100.policy = sic_bran.uwm100.Policy NO-LOCK:
                    CREATE sicuw.uwd100.
                    ASSIGN sicuw.uwd100.policy  = sic_bran.uwm100.Policy 
                        sicuw.uwd100.rencnt     = sic_bran.uwm100.rencnt
                        sicuw.uwd100.endcnt     = sic_bran.uwm100.endcnt
                        sicuw.uwd100.ltext      = sic_bran.uwd100.ltext
                        sicuw.uwd100.fptr       = 0
                        sicuw.uwd100.bptr       = nv_bptr.
                    IF nv_bptr <> 0 THEN DO:
                        FIND wf_uwd100 WHERE RECID(wf_uwd100) = nv_bptr.
                        wf_uwd100.fptr = RECID(sicuw.uwd100).
                    END.
                    IF nv_bptr = 0 THEN  sicuw.uwm100.fptr01 = RECID(sicuw.uwd100).
                    nv_bptr = RECID(sicuw.uwd100).
                END.    /* End FOR EACH poltxt_fil */
                sicuw.uwm100.bptr01 = nv_bptr.            
            END.
            ASSIGN sic_bran.uwm100.releas = YES.  /*--Update Status Releas--*/
            sic_bran.uwm100.trfflg = YES.  /*--Update Status Transfer To Premium --*/
        END.
        /*add by kridtiya i. A57-0391*/
    END.
END.
RELEASE sic_bran.uwm100.
RELEASE sicuw.uwm100.



