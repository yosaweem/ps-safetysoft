/***********************************************************
Copyright  # Tokiomarin Insurance Public Company Limited 
Create by : Chaiying w. A65-0185 19/08/2022
           : Dup Transfer uwm100 (wgwgen08.p)
Modify by : Chaiyong W. A66-0067 29/05/2023
            add program wgwgen09.i           
Modify By : Chaiyong W. A66-0116 08/09/2023 Create Status Vat
Modify By : Jiraphon P. A67-0025 
          : Field uwm101.chr2 ไม่ต้อง transfer                     
***********************************************************/

DEFINE SHARED VAR n_User   AS CHAR.
DEFINE INPUT PARAMETER nv_bchyr  AS INT.
DEFINE INPUT PARAMETER nv_bchno  AS CHAR.
DEFINE INPUT PARAMETER nv_bchcnt AS INT.
DEFINE INPUT PARAMETER nv_policy AS CHAR.
DEFINE INPUT PARAMETER nv_rencnt AS INT.
DEFINE INPUT PARAMETER nv_endcnt AS INT.
DEFINE INPUT PARAMETER nv_progid AS CHAR INIT "". /*--add by Chaiyong W. A65-0185 21/07/2022*/
DEFINE VAR nv_invtyp     AS CHAR.  
DEFINE VAR nv_i          AS INT.
DEFINE VAR nv_fptr       AS RECID.
DEFINE VAR nv_bptr       AS RECID.
DEFINE VAR nv_fptr1      AS RECID.
DEFINE VAR nv_bptr2      AS RECID.
DEFINE VAR nv_brins      AS CHAR FORMAT "X(5)".    
DEFINE VAR nv_taxno      AS CHAR FORMAT "X(15)". 

DEFINE BUFFER wf_uwd100 FOR sicuw.uwd100.
DEFINE BUFFER wf_uwd102 FOR sicuw.uwd102.
DEFINE BUFFER wf_uwd103 FOR sicuw.uwd103.
DEFINE BUFFER wf_uwd104 FOR sicuw.uwd104.
DEFINE BUFFER wf_uwd105 FOR sicuw.uwd105.
DEFINE BUFFER wf_uwd106 FOR sicuw.uwd106.

DEFINE VAR nv_rels AS CHAR INIT "".
DEF BUFFER buwm100 FOR sicuw.uwm100. /*-- A62-0005 --*/
DEF VAR nv_error AS CHAR INIT "". /*--add by Chaiyong W. A65-0185 28/09/2022*/

ASSIGN
    nv_i    = nv_i + 1.

FIND sic_bran.uwm100 USE-INDEX uwm10001 WHERE 
     sic_bran.uwm100.policy = nv_policy AND
     sic_bran.uwm100.rencnt = nv_rencnt AND
     sic_bran.uwm100.endcnt = nv_endcnt AND
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
            sicuw.uwm100.fptr01 = 0     /*First uwd100 Policy Up reci  */
            sicuw.uwm100.bptr01 = 0     /*Last  uwd100 Policy Up reci  */
            sicuw.uwm100.fptr02 = 0     /*First uwd102 Policy Me reci  */
            sicuw.uwm100.bptr02 = 0     /*Last  uwd102 Policy Me reci  */
            sicuw.uwm100.fptr03 = 0     /*First uwd105 Policy Cl reci  */
            sicuw.uwm100.bptr03 = 0     /*Last  uwd105 Policy Cl reci  */
            sicuw.uwm100.fptr04 = 0     /*First uwd103 Policy Re reci  */
            sicuw.uwm100.bptr04 = 0     /*Last  uwd103 Policy Ren reci  */
            sicuw.uwm100.fptr05 = 0     /*First uwd104 Policy En reci  */
            sicuw.uwm100.bptr05 = 0     /*Last  uwd104 Policy End reci  */
            sicuw.uwm100.fptr06 = 0     /*First uwd106 Pol.Endt. reci  */
            sicuw.uwm100.bptr06 = 0     /*Last  uwd106 Pol. Endt. reci  */
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
            sicuw.uwm100.insref = sic_bran.uwm100.insref     /*Insured's Ref. No.     char  */
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
            sicuw.uwm100.trndat = sic_bran.uwm100.trndat     /*Transaction Date       date  */
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
            sicuw.uwm100.trty13 = ""                         /*Tran. Type (1), A/C No char  */
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
            sicuw.uwm100.usrid  = n_User                     /*User Id                char  */
            sicuw.uwm100.entdat = sic_bran.uwm100.entdat     /*Entered Date           date  */
            sicuw.uwm100.enttim = sic_bran.uwm100.enttim     /*Entered Time           char  */
            sicuw.uwm100.polsta = sic_bran.uwm100.polsta     /*Policy Status          char  */
            sicuw.uwm100.rilate = sic_bran.uwm100.rilate     /*RI to Enter Later      logi  */
            /* Comment Jiraphon P. A60-0464
            sicuw.uwm100.sch_p  = sic_bran.uwm100.sch_p      /*Schedule Printed       logi  */
            sicuw.uwm100.drn_p  = sic_bran.uwm100.drn_p      /*Dr/Cr Note Printed     logi  */
            */
            sicuw.uwm100.ri_p   = sic_bran.uwm100.ri_p       /*RI Application Printed logi  */
            sicuw.uwm100.cert_p = sic_bran.uwm100.cert_p     /*Certificate Printed    logi  */
            sicuw.uwm100.dreg_p = sic_bran.uwm100.dreg_p     /*Daily Prem. Reg. Print logi  */
            /* A62-0005 --
            sicuw.uwm100.prog   = "wgwgen01" + "|" + STRING(nv_bchyr,"9999") +
            -*/
            /*"wgwgen01" + "|" + STRING(nv_bchyr,"9999") + STRING(nv_bchno) + STRING(nv_bchcnt,"99")*/
            
            /*-----
            sicuw.uwm100.prog   = "wgwgen08" + "|" + STRING(nv_bchyr,"9999") +     /* A62-0005 */
                                  STRING(nv_bchno) +
                                  STRING(nv_bchcnt,"99").    /*Program Id that input  char  */   
           -----Comment Jiraphon P. A62-0286*/
            /*Add Jiraphon P. A62-0286*/
            sicuw.uwm100.prog   = sic_bran.uwm100.prog + "|" + STRING(nv_bchyr,"9999") +
                                  STRING(nv_bchno) +
                                  STRING(nv_bchcnt,"99")  .   /*Program Id that input  char */
            /*End Add Jiraphon P. A62-0286*/                 

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
            sicuw.uwm100.endern = sic_bran.uwm100.endern.    /*End Date of Earned Pre date  */ 
        /*-- Add A63-0377 --*/
        ASSIGN
            sicuw.uwm100.icno          =  sic_bran.uwm100.icno                       
            sicuw.uwm100.br_insured    =  sic_bran.uwm100.br_insured                 
            sicuw.uwm100.occcod        =  sic_bran.uwm100.occcod                     
            sicuw.uwm100.refer1        =  sic_bran.uwm100.refer1                     
            sicuw.uwm100.refer2        =  sic_bran.uwm100.refer2                     
            sicuw.uwm100.refer3        =  sic_bran.uwm100.refer3                     
            sicuw.uwm100.refer4        =  sic_bran.uwm100.refer4                     
            sicuw.uwm100.refer5        =  sic_bran.uwm100.refer5                     
            sicuw.uwm100.refer6        =  sic_bran.uwm100.refer6                     
            sicuw.uwm100.scode         =  sic_bran.uwm100.scode                      
            sicuw.uwm100.sname         =  sic_bran.uwm100.sname                      
            sicuw.uwm100.channel       =  sic_bran.uwm100.channel                    
            sicuw.uwm100.acno_typ      =  sic_bran.uwm100.acno_typ                   
            sicuw.uwm100.id_typ        =  sic_bran.uwm100.id_typ                     
            sicuw.uwm100.sex           =  sic_bran.uwm100.sex                        
            sicuw.uwm100.maritalsts    =  sic_bran.uwm100.maritalsts                 
            sicuw.uwm100.addr          =  sic_bran.uwm100.addr                       
            sicuw.uwm100.unitNo        =  sic_bran.uwm100.unitNo                     
            sicuw.uwm100.roomNo        =  sic_bran.uwm100.roomNo                     
            sicuw.uwm100.building      =  sic_bran.uwm100.building                   
            sicuw.uwm100.village       =  sic_bran.uwm100.village                    
            sicuw.uwm100.alley         =  sic_bran.uwm100.alley                      
            sicuw.uwm100.lane          =  sic_bran.uwm100.lane                       
            sicuw.uwm100.street        =  sic_bran.uwm100.street                     
            sicuw.uwm100.subdistrict   =  sic_bran.uwm100.subdistrict                
            sicuw.uwm100.district      =  sic_bran.uwm100.district                   
            sicuw.uwm100.province      =  sic_bran.uwm100.province                   
            sicuw.uwm100.firstName     =  sic_bran.uwm100.firstName                  
            sicuw.uwm100.midName       =  sic_bran.uwm100.midName                    
            sicuw.uwm100.lastName      =  sic_bran.uwm100.lastName                   
            sicuw.uwm100.owner         =  sic_bran.uwm100.owner                      
            sicuw.uwm100.datafr        =  sic_bran.uwm100.datafr                     
            sicuw.uwm100.code1         =  sic_bran.uwm100.code1                      
            sicuw.uwm100.code2         =  sic_bran.uwm100.code2                      
            sicuw.uwm100.code3         =  sic_bran.uwm100.code3                      
            sicuw.uwm100.code4         =  sic_bran.uwm100.code4                      
            sicuw.uwm100.code5         =  sic_bran.uwm100.code5                      
            sicuw.uwm100.stype         =  sic_bran.uwm100.stype                      
            sicuw.uwm100.sdes          =  sic_bran.uwm100.sdes                       
            sicuw.uwm100.dealer        =  sic_bran.uwm100.dealer                     
            sicuw.uwm100.payer         =  sic_bran.uwm100.payer                      
            sicuw.uwm100.ptvdat        =  sic_bran.uwm100.ptvdat                     
            sicuw.uwm100.sch_dat       =  sic_bran.uwm100.sch_dat                    
            sicuw.uwm100.drn_dat       =  sic_bran.uwm100.drn_dat                    
            sicuw.uwm100.ptvttim       =  sic_bran.uwm100.ptvttim                    
            sicuw.uwm100.ptvtyp        =  sic_bran.uwm100.ptvtyp                     
            sicuw.uwm100.ptvusr        =  sic_bran.uwm100.ptvusr                     
            sicuw.uwm100.sch_usr       =  sic_bran.uwm100.sch_usr                    
            sicuw.uwm100.drn_usr       =  sic_bran.uwm100.drn_usr                    
            sicuw.uwm100.vttot         =  sic_bran.uwm100.vttot                      
            sicuw.uwm100.ptot          =  sic_bran.uwm100.ptot                       
            sicuw.uwm100.sfac          =  sic_bran.uwm100.sfac .
        ASSIGN
            sicuw.uwm100.codeocc       =  sic_bran.uwm100.codeocc                    
            sicuw.uwm100.codeaddr1     =  sic_bran.uwm100.codeaddr1                  
            sicuw.uwm100.codeaddr2     =  sic_bran.uwm100.codeaddr2                  
            sicuw.uwm100.codeaddr3     =  sic_bran.uwm100.codeaddr3                  
            sicuw.uwm100.s_title       =  sic_bran.uwm100.s_title                    
            sicuw.uwm100.s_lastname    =  sic_bran.uwm100.s_lastname                 
            sicuw.uwm100.s_tel         =  sic_bran.uwm100.s_tel                      
            sicuw.uwm100.s_email       =  sic_bran.uwm100.s_email                    
            sicuw.uwm100.ratecode      =  sic_bran.uwm100.ratecode                   
            sicuw.uwm100.consent       =  sic_bran.uwm100.consent                    
            sicuw.uwm100.sch_tim       =  sic_bran.uwm100.sch_tim                    
            sicuw.uwm100.drn_tim       =  sic_bran.uwm100.drn_tim                    
            sicuw.uwm100.acctim_t      =  sic_bran.uwm100.acctim_t                   
            sicuw.uwm100.revdat        =  sic_bran.uwm100.revdat                     
            sicuw.uwm100.revtim        =  sic_bran.uwm100.revtim                     
            sicuw.uwm100.revusr        =  sic_bran.uwm100.revusr                     
            sicuw.uwm100.code6         =  sic_bran.uwm100.code6                      
            sicuw.uwm100.code7         =  sic_bran.uwm100.code7                      
            sicuw.uwm100.code8         =  sic_bran.uwm100.code8                      
            sicuw.uwm100.code9         =  sic_bran.uwm100.code9                      
            sicuw.uwm100.code10        =  sic_bran.uwm100.code10                     
            sicuw.uwm100.campaign      =  sic_bran.uwm100.campaign                   
            sicuw.uwm100.endcod        =  sic_bran.uwm100.endcod                     
            sicuw.uwm100.d_channel     =  sic_bran.uwm100.d_channel                  
            sicuw.uwm100.chr1          =  sic_bran.uwm100.chr1                       
            /*sicuw.uwm100.chr2          =  sic_bran.uwm100.chr2  Comment A67-0025*/                     
            sicuw.uwm100.chr3          =  sic_bran.uwm100.chr3                       
            sicuw.uwm100.chr4          =  sic_bran.uwm100.chr4                       
            sicuw.uwm100.chr5          =  sic_bran.uwm100.chr5                       
            sicuw.uwm100.date1         =  sic_bran.uwm100.date1                      
            sicuw.uwm100.date2         =  sic_bran.uwm100.date2                      
            sicuw.uwm100.dec1          =  sic_bran.uwm100.dec1                       
            sicuw.uwm100.dec2          =  sic_bran.uwm100.dec2                       
            sicuw.uwm100.int1          =  sic_bran.uwm100.int1                       
            sicuw.uwm100.int2          =  sic_bran.uwm100.int2                       
            sicuw.uwm100.disc1_t       =  sic_bran.uwm100.disc1_t                    
            sicuw.uwm100.disc2_t       =  sic_bran.uwm100.disc2_t                    
            sicuw.uwm100.disc3_t       =  sic_bran.uwm100.disc3_t                    
            sicuw.uwm100.printvat      =  sic_bran.uwm100.printvat                   
            sicuw.uwm100.titleid       =  sic_bran.uwm100.titleid .                   
        /*-- End Add A63-0377 --*/
        /*---Begin by Chaiyong W. A65-0185 26/07/2022*/
        ASSIGN
            sicuw.uwm100.refercode        =  sic_bran.uwm100.refercode /*---add by chaiyong w. A65-0185 22/09/2022*/
            sicuw.uwm100.delicod          =  sic_bran.uwm100.delicod      
            sicuw.uwm100.dtitle           =  sic_bran.uwm100.dtitle       
            sicuw.uwm100.dfirstname       =  sic_bran.uwm100.dfirstname   
            sicuw.uwm100.dlastname        =  sic_bran.uwm100.dlastname    
            sicuw.uwm100.daddr1           =  sic_bran.uwm100.daddr1       
            sicuw.uwm100.daddr2           =  sic_bran.uwm100.daddr2       
            sicuw.uwm100.daddr3           =  sic_bran.uwm100.daddr3       
            sicuw.uwm100.daddr4           =  sic_bran.uwm100.daddr4       
            sicuw.uwm100.dpostcd          =  sic_bran.uwm100.dpostcd      
            sicuw.uwm100.dcodeaddr1       =  sic_bran.uwm100.dcodeaddr1   
            sicuw.uwm100.dcodeaddr2       =  sic_bran.uwm100.dcodeaddr2   
            sicuw.uwm100.dcodeaddr3       =  sic_bran.uwm100.dcodeaddr3   
            sicuw.uwm100.demail1          =  sic_bran.uwm100.demail1      
            sicuw.uwm100.demail2          =  sic_bran.uwm100.demail2      
            sicuw.uwm100.dphone1          =  sic_bran.uwm100.dphone1      
            sicuw.uwm100.dphone2          =  sic_bran.uwm100.dphone2      
            sicuw.uwm100.dcontact1        =  sic_bran.uwm100.dcontact1    
            sicuw.uwm100.dcontact2        =  sic_bran.uwm100.dcontact2  
            sicuw.uwm100.s_channel        =  sic_bran.uwm100.s_channel 
            sicuw.uwm100.e_policy         =  sic_bran.uwm100.e_policy           
            sicuw.uwm100.e_tax            =  sic_bran.uwm100.e_tax            
            sicuw.uwm100.e_stamp          =  sic_bran.uwm100.e_stamp          
             
            
            .



        /*End by Chaiyong W. A65-0185 26/07/2022-----*/
        {wgw\wgwgen09.i} /*--add by Chaiyong W. A66-0067 29/05/2023*/
        /*-- Add,Update uwd100 --*/
        nv_fptr = sic_bran.uwm100.fptr01.
        nv_bptr = 0.
        DO WHILE nv_fptr <> 0 AND sic_bran.uwm100.fptr01 <> ? :
            FIND sic_bran.uwd100 WHERE RECID(sic_bran.uwd100) = nv_fptr NO-LOCK NO-ERROR.
            IF AVAIL sic_bran.uwd100 THEN DO:
                nv_fptr = sic_bran.uwd100.fptr.
                CREATE sicuw.uwd100.
                ASSIGN
                    sicuw.uwd100.bptr    = nv_bptr
                    sicuw.uwd100.endcnt  = sic_bran.uwm100.endcnt
                    sicuw.uwd100.fptr    = 0
                    sicuw.uwd100.ltext   = sic_bran.uwd100.ltext
                    sicuw.uwd100.policy  = sic_bran.uwm100.Policy
                    sicuw.uwd100.rencnt  = sic_bran.uwm100.rencnt.

                IF nv_bptr <> 0 THEN DO:
                    FIND wf_uwd100 WHERE RECID(wf_uwd100) = nv_bptr.
                    wf_uwd100.fptr = RECID(sicuw.uwd100).
                END.
                IF nv_bptr = 0 THEN sicuw.uwm100.fptr01 = RECID(sicuw.uwd100).
                nv_bptr = RECID(sicuw.uwd100).
            END.
        END.
        sicuw.uwm100.bptr01 = nv_bptr.

        /*-- Add, Update uwd102 --*/
        nv_fptr = sic_bran.uwm100.fptr02.
        nv_bptr = 0.
        DO WHILE nv_fptr <> 0 AND sic_bran.uwm100.fptr02 <> ? :
            FIND sic_bran.uwd102 WHERE RECID(sic_bran.uwd102) = nv_fptr NO-LOCK NO-ERROR.
            IF AVAILABLE sic_bran.uwd102 THEN DO: 
                nv_fptr = sic_bran.uwd102.fptr.
                CREATE sicuw.uwd102.
                ASSIGN
                    sicuw.uwd102.bptr    = nv_bptr
                    sicuw.uwd102.endcnt  = sic_bran.uwd102.endcnt
                    sicuw.uwd102.fptr    = 0
                    sicuw.uwd102.ltext   = sic_bran.uwd102.ltext
                    sicuw.uwd102.policy  = sic_bran.uwd102.Policy
                    sicuw.uwd102.rencnt  = sic_bran.uwd102.rencnt.

                IF nv_bptr <> 0 THEN DO:
                  FIND wf_uwd102 WHERE RECID(wf_uwd102) = nv_bptr.
                  wf_uwd102.fptr = RECID(sicuw.uwd102).
                END.
                IF nv_bptr = 0 THEN  sicuw.uwm100.fptr02 = RECID(sicuw.uwd102).
                nv_bptr = RECID(sicuw.uwd102).
            END.
        END.
        sicuw.uwm100.bptr02 = nv_bptr.

        /*-- Add, Update uwd105 --*/
        nv_fptr = sic_bran.uwm100.fptr03.
        nv_bptr = 0.
        DO WHILE nv_fptr <> 0 AND sic_bran.uwm100.fptr03 <> ? :
            FIND sic_bran.uwd105 WHERE RECID(sic_bran.uwd105) = nv_fptr NO-LOCK NO-ERROR.
            IF AVAILABLE sic_bran.uwd105 THEN DO:
                nv_fptr = sic_bran.uwd105.fptr.
        
                CREATE sicuw.uwd105.
                ASSIGN
                    sicuw.uwd105.bptr    = nv_bptr
                    sicuw.uwd105.clause  = sic_bran.uwd105.clause
                    sicuw.uwd105.endcnt  = sic_bran.uwd105.endcnt
                    sicuw.uwd105.fptr    = 0
                    sicuw.uwd105.policy  = sic_bran.uwd105.policy
                    sicuw.uwd105.rencnt  = sic_bran.uwd105.rencnt.

                IF nv_bptr <> 0 THEN DO:
                  FIND wf_uwd105 WHERE RECID(wf_uwd105) = nv_bptr.
                       wf_uwd105.fptr = RECID(sicuw.uwd105).
                END.
                IF nv_bptr = 0 THEN  sicuw.uwm100.fptr03 = RECID(sicuw.uwd105).
                nv_bptr = RECID(sicuw.uwd105).
            END.
        END.
        sicuw.uwm100.bptr03 = nv_bptr.

        /*-- Add, Update uwd103 --*/
        nv_fptr = sic_bran.uwm100.fptr04.
        nv_bptr = 0.
        DO WHILE nv_fptr <> 0 AND sic_bran.uwm100.fptr04 <> ? :
            FIND sic_bran.uwd103 WHERE RECID(sic_bran.uwd103) = nv_fptr NO-LOCK NO-ERROR.
            IF AVAILABLE sic_bran.uwd103 THEN DO:
                nv_fptr = sic_bran.uwd103.fptr.

                CREATE sicuw.uwd103.
                ASSIGN
                    sicuw.uwd103.bptr     = nv_bptr
                    sicuw.uwd103.endcnt   = sic_bran.uwd103.endcnt
                    sicuw.uwd103.fptr     = 0
                    sicuw.uwd103.ltext    = sic_bran.uwd103.ltext
                    sicuw.uwd103.policy   = sic_bran.uwd103.policy
                    sicuw.uwd103.rencnt   = sic_bran.uwd103.rencnt.

                IF nv_bptr <> 0 THEN DO:
                    FIND wf_uwd103 WHERE RECID(wf_uwd103) = nv_bptr.
                    wf_uwd103.fptr = RECID(sicuw.uwd103).
                END.
                IF nv_bptr = 0 THEN  sicuw.uwm100.fptr04 = RECID(sicuw.uwd103). 
                nv_bptr = RECID(sicuw.uwd103).
            END.
        END.
        sicuw.uwm100.bptr04 = nv_bptr.

        /*-- Add, Update uwd104 --*/
        nv_fptr = sic_bran.uwm100.fptr05.
        nv_bptr = 0.
        DO WHILE nv_fptr <> 0 AND sic_bran.uwm100.fptr05 <> ? :
            FIND sic_bran.uwd104 WHERE RECID(sic_bran.uwd104) = nv_fptr NO-LOCK NO-ERROR.
            IF AVAILABLE sic_bran.uwd104 THEN DO:
                nv_fptr = sic_bran.uwd104.fptr.

                CREATE sicuw.uwd104.
                ASSIGN
                    sicuw.uwd104.bptr    = nv_bptr
                    sicuw.uwd104.endcnt  = sic_bran.uwd104.endcnt
                    sicuw.uwd104.fptr    = 0
                    sicuw.uwd104.ltext   = sic_bran.uwd104.ltext
                    sicuw.uwd104.policy  = sic_bran.uwd104.policy
                    sicuw.uwd104.rencnt  = sic_bran.uwd104.rencnt.

                IF nv_bptr <> 0 THEN DO:
                  FIND wf_uwd104 WHERE RECID(wf_uwd104) = nv_bptr.
                       wf_uwd104.fptr = RECID(sicuw.uwd104).
                END.
                IF nv_bptr = 0 THEN  sicuw.uwm100.fptr05 = RECID(sicuw.uwd104).
                nv_bptr = RECID(sicuw.uwd104).
            END.
        END.
        sicuw.uwm100.bptr05 = nv_bptr.

        /*-- Add, Update uwd106 --*/
        nv_fptr = sic_bran.uwm100.fptr06.
        nv_bptr = 0.
        DO WHILE nv_fptr <> 0 AND sic_bran.uwm100.fptr06 <> ? :
            FIND sic_bran.uwd106 WHERE RECID(sic_bran.uwd106) = nv_fptr NO-LOCK NO-ERROR.
            IF AVAILABLE sic_bran.uwd106 THEN DO:
                nv_fptr = sic_bran.uwd106.fptr.

                CREATE sicuw.uwd106.
                ASSIGN
                    sicuw.uwd106.bptr    = sic_bran.uwd106.bptr
                    sicuw.uwd106.endcls  = sic_bran.uwd106.endcls
                    sicuw.uwd106.endcnt  = sic_bran.uwd106.endcnt
                    sicuw.uwd106.fptr    = sic_bran.uwd106.fptr
                    sicuw.uwd106.policy  = sic_bran.uwd106.policy
                    sicuw.uwd106.rencnt  = sic_bran.uwd106.rencnt.

                IF nv_bptr <> 0 THEN DO:
                  FIND wf_uwd106 WHERE RECID(wf_uwd106) = nv_bptr.
                       wf_uwd106.fptr = RECID(sicuw.uwd106).
                END.
                IF nv_bptr = 0 THEN  sicuw.uwm100.fptr06 = RECID(sicuw.uwd106).
                nv_bptr = RECID(sicuw.uwd106).
            END.
        END.
        sicuw.uwm100.bptr06 = nv_bptr.

        /*--- A62-0005 --- Update RenPol ของ กธ. ปีก่อนหน้า ---*/
               /* D07061000001 */
        IF TRIM(sicuw.uwm100.prvpol) <> "" AND sicuw.uwm100.rencnt > 0 AND 

            SUBSTR(sic_Bran.uwm100.policy,1,1) <> "Q" AND
            SUBSTR(sic_Bran.uwm100.policy,1,1) <> "R" THEN DO:
                                   /* D07061000001 -- กธ. ปีก่อนหน้า --*/
            FOR EACH buwm100 WHERE buwm100.policy = sicuw.uwm100.prvpol :  
                buwm100.renpol = sicuw.uwm100.policy.  /* D07062000001 */
            END.

            RELEASE buwm100 NO-ERROR.
        END.
        /*------------- A62-0005 ------------*/
        /*---Begin by Chaiyong W. A65-0185 21/07/2022*/
        ASSIGN
            sicuw.uwm100.sch_p  = sic_bran.uwm100.sch_p  
            sicuw.uwm100.drn_p  = sic_bran.uwm100.drn_p
            sicuw.uwm100.code1  = sic_Bran.uwm100.code1.
        IF sic_bran.uwm100.poltyp <> "M60" AND 
           sic_bran.uwm100.poltyp <> "M61" AND
           sic_bran.uwm100.poltyp <> "M62" AND
           sic_bran.uwm100.poltyp <> "M63" AND 
           sic_bran.uwm100.poltyp <> "M64" AND
           sic_bran.uwm100.poltyp <> "M67" AND
           SUBSTR(sic_Bran.uwm100.policy,1,1) <> "Q" AND  
           SUBSTR(sic_Bran.uwm100.policy,1,1) <> "R" AND
           nv_progid <> "Not Vat" THEN DO:
            IF nv_progid = "WGWGEQ70" THEN DO:
                ASSIGN
                    sicuw.uwm100.sch_p  = YES
                    sicuw.uwm100.drn_p  = YES.
            END.

            IF sicuw.uwm100.sch_p = YES AND sicuw.uwm100.drn_p = YES AND sicuw.uwm100.code1 = ""  AND sic_bran.uwm100.docno1 <> "0000000" THEN DO:
                
    
                IF sic_bran.uwm100.trty13 <> "" AND sic_bran.uwm100.trty13 = "S" THEN DO:
                    nv_invtyp = TRIM(sic_bran.uwm100.trty13).  
                END.
                ELSE IF sic_bran.uwm100.trty13 <> "" AND sic_bran.uwm100.trty13 = "N" THEN  /*LOckton by kridtiya i.*/
                    nv_invtyp = TRIM(sic_bran.uwm100.trty13).                              /*LOckton by kridtiya i. type = N */ 
                ELSE nv_invtyp = "T".
                IF ( sic_bran.uwm100.docno1 <> "0000000" ) AND ( nv_invtyp <> "N" ) THEN DO:
                    
                      /*--
                        ASSIGN
                            sicuw.uwm100.ptvdat  = DATE(sic_bran.uwm100.trndat)
                            sicuw.uwm100.ptvttim = sic_bran.uwm100.enttim
                            sicuw.uwm100.ptvusr  = n_user.
                        IF length(sicuw.uwm100.ptvttim) > 10 THEN  sicuw.uwm100.ptvttim = SUBSTR(sicuw.uwm100.ptvttim,1,10).
                        ASSIGN
                            sicuw.uwm100.code1   = trim(substr(trim(sic_bran.uwm100.prog),1,10))
                            sicuw.uwm100.code1   = sicuw.uwm100.code1 + FILL(" ",10  -  LENGTH(sicuw.uwm100.code1))
                            sicuw.uwm100.code1   = sicuw.uwm100.code1 +  STRING(sicuw.uwm100.ptvdat,"99/99/9999") + sicuw.uwm100.ptvttim
                            sicuw.uwm100.code1   = sicuw.uwm100.code1 + FILL(" ",30 -  LENGTH(sicuw.uwm100.code1)) + n_user
                            sicuw.uwm100.code1   = sicuw.uwm100.code1 + FILL(" ",40 -  LENGTH(sicuw.uwm100.code1)) + nv_invtyp
                            sicuw.uwm100.code1   = sicuw.uwm100.code1 + FILL(" ",100 -  LENGTH(sicuw.uwm100.code1)) + sic_bran.uwm100.prog.
                    */
                    /*---Begin A66-0116 08/09/2023*/
                    ASSIGN
                        sicuw.uwm100.ptvdat  = DATE(sic_bran.uwm100.trndat)
                        sicuw.uwm100.ptvttim = sic_bran.uwm100.enttim
                        sicuw.uwm100.ptvusr  = n_user.
                    IF length(sicuw.uwm100.ptvttim) > 10 THEN  sicuw.uwm100.ptvttim = SUBSTR(sicuw.uwm100.ptvttim,1,10).
                    ASSIGN
                        sicuw.uwm100.code1   = trim(substr(trim(sic_bran.uwm100.prog),1,10))
                        sicuw.uwm100.code1   = sicuw.uwm100.code1 + FILL(" ",10  -  LENGTH(sicuw.uwm100.code1))
                        sicuw.uwm100.code1   = sicuw.uwm100.code1 +  STRING(sicuw.uwm100.ptvdat,"99/99/9999") + sicuw.uwm100.ptvttim
                        sicuw.uwm100.code1   = sicuw.uwm100.code1 + FILL(" ",30 -  LENGTH(sicuw.uwm100.code1)) + n_user
                        sicuw.uwm100.code1   = sicuw.uwm100.code1 + FILL(" ",40 -  LENGTH(sicuw.uwm100.code1)) + nv_invtyp
                        sicuw.uwm100.code1   = sicuw.uwm100.code1 + FILL(" ",100 -  LENGTH(sicuw.uwm100.code1)) + sic_bran.uwm100.prog.
                    /*End A66-0116 08/09/2023----*/
                   

                    RUN WGW\WGWVPTV1(INPUT RECID(sic_bran.uwm100),OUTPUT nv_error). /*---Add by Chaiyong W. A65-0185 28/09/2022*/
                END.
            END.
        END.
        /*End by Chaiyong W. A65-0185 21/07/2022-----*/


    END. /* NOT AVAIL sicuw.uwm100 -- Create sicuw.uwm100*/

    RELEASE sicuw.uwm100.
END.
