/* WGWGE100   : Program Generage Policy Header (Gwtransfer UWM100)   */
/* Copyright   # Safety Insurance Public Company Limited             */
/*               บริษัท ประกันคุ้มภัย จำกัด (มหาชน)                  */
/* WRITE      : Wantanee.  28/09/2006                                */
/* Copy From  : Wtmge100 (Modify)                                    */
/* Wgwimpt0, Wgwimpt1  : Program ที่เรียกใช้มาก่อน                   */

/* Modify By : Chutikarn.S Date. 20/01/2010 Assign No.: A53-0015
             : Update & Clear uwm100.endern (วันที่รับเงินจากลูกค้า) */
/* Modify By : Porntiwa P.  A53-0039  24/01/2010
             : ปรับ Running Endorse จาก 5 เป็น 6 หลัก                */             

/*------
POLICY NEW     : accdat = Today     fstdat = Comdat             Enddat = ?       Trndat = Today
POLICY ENDORSE : accdat = Today     fstdat = ของกรมธรรม์        Enddat = Today   Trndat = Today
POLICY RENEW   : accdat = Today     fstdat = ของกรมธรรม์ต่ออายุ Enddat = ?       Trndat = Today
--------*/

/*---Wantanee 29/09/2006 A49-0165 ---*/
DEF INPUT        PARAMETER nv_batchyr   AS INTEGER   FORMAT "9999".
DEF INPUT        PARAMETER nv_batchno   AS CHARACTER FORMAT "X(13)".
DEF INPUT        PARAMETER nv_batcnt    AS INTEGER   FORMAT "99".
DEF INPUT        PARAMETER nv_prog      AS CHARACTER FORMAT "X(40)". /*program*/
DEF INPUT        PARAMETER nv_texterror AS CHAR.  /*Detail Error*/
DEF INPUT        PARAMETER nv_polflg    AS LOG.   /*uwm100.sucflg1*/
/*------*/

DEF INPUT        PARAMETER nv_policy    AS CHARACTER FORMAT "X(12)".
DEF INPUT        PARAMETER nv_rencnt    AS INTEGER   FORMAT "999".
DEF INPUT        PARAMETER nv_endcnt    AS INTEGER   FORMAT "999".
DEF INPUT        PARAMETER nv_prvpol    AS CHARACTER FORMAT "X(16)".
DEF INPUT        PARAMETER nv_agent     AS CHARACTER FORMAT "X(07)".
DEF INPUT        PARAMETER nv_name1     AS CHARACTER FORMAT "X(50)".
DEF INPUT        PARAMETER nv_comdat    AS DATE      FORMAT "99/99/9999".
DEF INPUT        PARAMETER nv_expdat    AS DATE      FORMAT "99/99/9999".
DEF INPUT        PARAMETER nv_trndat    AS DATE      FORMAT "99/99/9999".
DEF INPUT        PARAMETER nv_acno1     AS CHARACTER FORMAT "X(07)".
DEF INPUT        PARAMETER nv_prem      AS DECIMAL   FORMAT ">,>>>,>>9.99-".
/*DEF INPUT        PARAMETER nv_pdty_p  AS DECIMAL   FORMAT ">,>>>,>>9.99-".*/
DEF INPUT        PARAMETER nv_pdstp     AS DECIMAL   FORMAT ">,>>>,>>9.99-".
DEF INPUT        PARAMETER nv_pdtyp     AS DECIMAL   FORMAT ">,>>>,>>9.99-".
DEF INPUT        PARAMETER nv_pdcop     AS DECIMAL   FORMAT ">,>>>,>>9.99-".
DEF INPUT        PARAMETER nv_pdfap     AS DECIMAL   FORMAT ">,>>>,>>9.99-".
DEF INPUT        PARAMETER nv_pdqsp     AS DECIMAL   FORMAT ">,>>>,>>9.99-".
DEF INPUT        PARAMETER nv_com1_t    AS DECIMAL   FORMAT ">>>,>>9.99-".
DEF INPUT        PARAMETER nv_comst     AS DECIMAL   FORMAT ">>>,>>9.99-".
DEF INPUT        PARAMETER nv_comty     AS DECIMAL   FORMAT ">>>,>>9.99-".
DEF INPUT        PARAMETER nv_comco     AS DECIMAL   FORMAT ">>>,>>9.99-".
DEF INPUT        PARAMETER nv_comfa     AS DECIMAL   FORMAT ">>>,>>9.99-".
DEF INPUT        PARAMETER nv_comqs     AS DECIMAL   FORMAT ">>>,>>9.99-".
DEF INPUT        PARAMETER nv_docno1    AS CHARACTER FORMAT "X(07)".
DEF INPUT        PARAMETER nv_enttim    AS CHARACTER FORMAT "X(08)".
DEF INPUT        PARAMETER nv_si        AS DECIMAL   FORMAT ">,>>>,>>>,>>9.99".
/*DEF INPUT        PARAMETER nv_sity_p  AS DECIMAL   FORMAT ">,>>>,>>>,>>9.99".*/
DEF INPUT        PARAMETER nv_sistp     AS DECIMAL   FORMAT ">,>>>,>>>,>>9.99".
DEF INPUT        PARAMETER nv_sityp     AS DECIMAL   FORMAT ">,>>>,>>>,>>9.99".
DEF INPUT        PARAMETER nv_sicop     AS DECIMAL   FORMAT ">,>>>,>>>,>>9.99".
DEF INPUT        PARAMETER nv_sifap     AS DECIMAL   FORMAT ">,>>>,>>>,>>9.99".
DEF INPUT        PARAMETER nv_siqsp     AS DECIMAL   FORMAT ">,>>>,>>>,>>9.99".
DEF INPUT        PARAMETER nv_renpol    AS CHARACTER FORMAT "X(16)". /*A46-0021  เพิ่ม renew policy*/
DEF INPUT        PARAMETER nv_append    AS CHARACTER FORMAT "X(16)". 
DEF INPUT        PARAMETER nv_poltyp    AS CHARACTER FORMAT "X(04)". 
DEF INPUT        PARAMETER nv_cedpol    AS CHARACTER FORMAT "X(16)". 
DEF INPUT        PARAMETER nv_cedsi     AS DECIMAL   FORMAT ">>,>>>,>>>,>>>,>>9.99".
DEF INPUT        PARAMETER nv_policyold AS CHARACTER FORMAT "X(16)".
DEF INPUT        PARAMETER nv_fdateold  AS DATE      FORMAT "99/99/9999". 
/*DEF INPUT        PARAMETER nv_endnum    AS CHAR      FORMAT "XXXXXXX".*//*Comment A53-0039*/
DEF INPUT        PARAMETER nv_endnum    AS CHAR      FORMAT "XXXXXXXX". /*Add A53-0039*/
DEF INPUT        PARAMETER nv_status    AS CHAR      FORMAT "X(3)".
DEF INPUT        PARAMETER nv_dept      AS CHAR      FORMAT "X(1)".
DEF INPUT        PARAMETER nv_gstrat    AS DECIMAL   FORMAT ">>9.99-".
DEF INPUT        PARAMETER nv_branch    AS CHARACTER FORMAT "X(02)".
DEF OUTPUT       PARAMETER n_recid100   AS RECID.
DEF INPUT-OUTPUT PARAMETER nv_check     AS CHARACTER .
/* ------------------------------------------------------------- */
DEF VAR nv_undyr  AS CHARACTER FORMAT "X(4)"  INITIAL "".
DEF VAR nv_usrid  AS CHARACTER FORMAT "X(8)"  INITIAL 0.
DEF VAR nv_swith  AS LOGICAL.
DEF VAR nv_bptr   AS RECID.

ASSIGN
  nv_check  = ""
  /*nv_branch = SUBSTRING(nv_policy,2,1) ---Wantanee 28/09/2006*/
  nv_usrid  = USERID(LDBNAME("sic_bran")).

/*----Wantanee 28/09/2006----
     IF SUBSTR(nv_policy,5,2) = "46" THEN nv_undyr  = "2003".
ELSE IF SUBSTR(nv_policy,5,2) = "47" THEN nv_undyr  = "2004".
ELSE IF SUBSTR(nv_policy,5,2) = "48" THEN nv_undyr  = "2005".
ELSE IF SUBSTR(nv_policy,5,2) = "49" THEN nv_undyr  = "2006".
ELSE IF SUBSTR(nv_policy,5,2) = "50" THEN nv_undyr  = "2007".
ELSE IF SUBSTR(nv_policy,5,2) = "51" THEN nv_undyr  = "2008".
ELSE IF SUBSTR(nv_policy,5,2) = "52" THEN nv_undyr  = "2009".
ELSE IF SUBSTR(nv_policy,5,2) = "53" THEN nv_undyr  = "2010".
ELSE IF SUBSTR(nv_policy,5,2) = "54" THEN nv_undyr  = "2011".
ELSE                                      nv_undyr  = STRING(YEAR(nv_comdat),"9999").
----Wantanee 28/09/2006----*/

IF nv_comdat <> ? THEN nv_undyr = STRING(YEAR(nv_comdat)).
ELSE nv_undyr = "".

/*----Wantanee 28/09/2006----
FIND sic_bran.uwm100  USE-INDEX uwm10001 WHERE
     sic_bran.uwm100.policy = nv_policy AND
     sic_bran.uwm100.rencnt = nv_rencnt AND
     sic_bran.uwm100.endcnt = nv_endcnt
NO-LOCK NO-ERROR NO-WAIT.
IF AVAILABLE sic_bran.uwm100 THEN DO:
  nv_check = "ERROR".
  RETURN.
END.
IF LOCKED sic_bran.uwm100 THEN DO:
  nv_check = "ERROR".
  RETURN.
END.
----Wantanee 28/09/2006----*/

/* CREATE NEW : Policy Header */
CREATE sic_bran.uwm100.
ASSIGN
  sic_bran.uwm100.curbil = "BHT"             /*Currency of Billing*/
  sic_bran.uwm100.curate = 1                 /*Currency rate for Billing*/
  sic_bran.uwm100.branch = nv_branch         /*Branch Code (of Transaction)*/
  sic_bran.uwm100.dir_ri = NO                /*Direct/RI Code (D/R)*/
  sic_bran.uwm100.dept   = nv_dept           /*Department code*/
  sic_bran.uwm100.policy = nv_policy         /*Policy No.*/
  sic_bran.uwm100.rencnt = nv_rencnt         /*Renewal Count*/
  sic_bran.uwm100.renno  = ""                /*Renewal No.*/
  sic_bran.uwm100.endcnt = nv_endcnt         /*Endorsement Count*/
  /*sic_bran.uwm100.endno  = ""              /*Endorsement No.*/*/
  sic_bran.uwm100.cntry  = "TH"              /*Country where risk is situated*/
  sic_bran.uwm100.agent  = nv_agent          /*Agent's Ref. No.*/
  sic_bran.uwm100.poltyp = nv_poltyp         /*Policy Type*/
  sic_bran.uwm100.insref = ""                /*Insured's Ref. No.*/
  sic_bran.uwm100.opnpol = ""                /*Open Cover/Master Policy No.*/
  sic_bran.uwm100.ntitle = ""                /*Title for Name Mr/Mrs/etc*/
  sic_bran.uwm100.fname  = ""                /*First Name*/
  sic_bran.uwm100.name1  = nv_name1          /*Name of Insured Line 1*/
  sic_bran.uwm100.name2  = ""                /*Name of Insured Line 2*/
  sic_bran.uwm100.name3  = ""                /*Name of Insured Line 3*/
  sic_bran.uwm100.addr1  = ""                /*Address 1*/
  sic_bran.uwm100.addr2  = ""                /*Address 2*/
  sic_bran.uwm100.postcd = ""                /*Postal Code*/
  sic_bran.uwm100.occupn = "".               /*Occupation Description*/

ASSIGN                              
  sic_bran.uwm100.comdat = nv_comdat         /*Cover Commencement Date*/
  sic_bran.uwm100.expdat = nv_expdat         /*Expiry Date*/
  sic_bran.uwm100.accdat = nv_trndat         /*Acceptance Date*/
  sic_bran.uwm100.trndat = nv_trndat         /*Transaction Date*/
  sic_bran.uwm100.rendat = ?                 /*Date Renewal Notice Printed*/
  sic_bran.uwm100.terdat = ?                 /*Termination Date*/
  sic_bran.uwm100.cn_dat = ?                 /*Cover Note Date*/
  sic_bran.uwm100.cn_no  = 0                 /*Cover Note No.*/
  /*sic_bran.uwm100.tranty = "N"             /*Transaction Type (N/R/E/C/T)*/*/
  sic_bran.uwm100.undyr  = nv_undyr          /*Underwriting Year*/
  sic_bran.uwm100.acno1  = nv_acno1          /*Account no. 1*/
  sic_bran.uwm100.acno2  = ""                /*Account no. 2*/
  sic_bran.uwm100.acno3  = ""                /*Account no. 3*/
  sic_bran.uwm100.instot = 1                 /*Total No. of Instalments*/
  sic_bran.uwm100.pstp   = 0                 /*Policy Level Stamp*/
  sic_bran.uwm100.pfee   = 0                 /*Policy Level Fee*/
  sic_bran.uwm100.ptax   = 0                 /*Policy Level Tax*/
  sic_bran.uwm100.rstp_t = 0                 /*Risk Level Stamp, Tran. Total*/
  sic_bran.uwm100.rfee_t = 0                 /*Risk Level Fee, Tran. Total*/
  sic_bran.uwm100.rtax_t = 0                 /*Risk Level Tax, Tran. Total*/
  sic_bran.uwm100.prem_t = nv_prem           /*Premium Due, Tran. Total*/
  sic_bran.uwm100.pdco_t = nv_pdcop          /*PD Coinsurance, Tran. Total*/
  sic_bran.uwm100.pdst_t = nv_pdstp          /*PD Statutory, Tran. total*/
  sic_bran.uwm100.pdfa_t = nv_pdfap          /*PD Facultative, Tran. Total*/
  sic_bran.uwm100.pdty_t = nv_pdtyp          /*PD Treaty, Tran. Total*/
  sic_bran.uwm100.pdqs_t = nv_pdqsp          /*PD Quota Share, Tran. Total*/
  sic_bran.uwm100.com1_t = nv_com1_t         /*Commission 1, Tran. Total*/
  sic_bran.uwm100.com2_t = 0                 /*Commission 2, Tran. Total*/
  sic_bran.uwm100.com3_t = 0                 /*Commission 3, Tran. Total*/
  sic_bran.uwm100.com4_t = 0                 /*Commission 4, Tran. Total*/
  sic_bran.uwm100.coco_t = nv_comco          /*Comm. Coinsurance, Tran Total*/
  sic_bran.uwm100.cost_t = nv_comst          /*Comm. Statutory, Tran. Total*/
  sic_bran.uwm100.cofa_t = nv_comfa          /*Comm. Facultative, Tran. To*/
  sic_bran.uwm100.coty_t = nv_comty          /*Comm. Treaty, Tran. Total*/
  sic_bran.uwm100.coqs_t = nv_comqs          /*Comm. Quota Share, Tran. Total*/
  sic_bran.uwm100.reduc1 = NO                /*Reducing Balance 1 (Y/N)*/
  sic_bran.uwm100.reduc2 = NO                /*Reducing Balance 2 (Y/N)*/
  sic_bran.uwm100.reduc3 = NO.               /*Reducing Balance 3 (Y/N)*/

ASSIGN                              
  sic_bran.uwm100.gap_p  = nv_prem           /*Gross Annual Prem, Pol. Total*/
  sic_bran.uwm100.dl1_p  = 0                 /*Discount/Loading 1, Pol. Total*/
  sic_bran.uwm100.dl2_p  = 0                 /*Discount/Loading 2, Pol. Total*/
  sic_bran.uwm100.dl3_p  = 0                 /*Discount/Loading 3, Pol. Total*/
  sic_bran.uwm100.dl2red = YES               /*Disc./Load 2 Red. Balance Y/N*/
  sic_bran.uwm100.dl3red = YES               /*Disc./Load 3 Red. Balance Y/N*/
  sic_bran.uwm100.dl1sch = YES               /*Disc./Load 1 Prt on Sched. Y/N*/
  sic_bran.uwm100.dl2sch = YES               /*Disc./Load 2 Prt on Sched. Y/N*/
  sic_bran.uwm100.dl3sch = YES               /*Disc./Load 3 Prt on Sched. Y/N*/
  sic_bran.uwm100.drnoae = NO                /*Dr/Cr Note No. (A/E)*/
  sic_bran.uwm100.insddr = NO                /*Print Insd. Name on DrN*/
  sic_bran.uwm100.trty11 = ""                /*Tran. Type (1), A/C No. 1*/
  sic_bran.uwm100.trty12 = ""                /*Tran. Type (1), A/C No. 2*/
  sic_bran.uwm100.trty13 = ""                /*Tran. Type (1), A/C No. 3*/
  sic_bran.uwm100.docno1 = nv_docno1         /*Document No., A/C No. 1*/
  sic_bran.uwm100.docno2 = ""                /*Document No., A/C No. 2*/
  sic_bran.uwm100.docno3 = ""                /*Document No., A/C No. 3*/
  sic_bran.uwm100.no_sch = 1                 /*No. to print, Schedule*/
  sic_bran.uwm100.no_dr  = 1                 /*No. to print, Dr/Cr Note*/
  sic_bran.uwm100.no_ri  = 1                 /*No. to print, RI Appln*/
  sic_bran.uwm100.no_cer = 0                 /*No. to print, Certificate*/
  sic_bran.uwm100.li_sch = YES               /*Print Later/Imm., Schedule*/
  sic_bran.uwm100.li_dr  = YES               /*Print Later/Imm., Dr/Cr Note*/
  sic_bran.uwm100.li_ri  = YES               /*Print Later/Imm., RI Appln,*/
  sic_bran.uwm100.li_cer = YES               /*Print Later/Imm., Certificate*/
  sic_bran.uwm100.scform = ""                /*Schedule Format*/
  /*sic_bran.uwm100.enform = ""              /*Endt. Format (Full/Abbr/Blank)*/*/
  sic_bran.uwm100.apptax = YES               /*Apply risk level tax (Y/N)*/
  sic_bran.uwm100.dl1cod = ""                /*Discount/Loading Type Code 1*/
  sic_bran.uwm100.dl2cod = ""                /*Discount/Loading Type Code 2*/
  sic_bran.uwm100.dl3cod = ""                /*Discount/Loading Type Code 3*/
  sic_bran.uwm100.styp20 = ""                /*Statistic Type Codes (4 x 20)*/
  sic_bran.uwm100.sval20 = ""                /*Statistic Value Codes (4 x 20)*/
  sic_bran.uwm100.finint = ""                /*Financial Interest Ref. No.*/
  sic_bran.uwm100.cedco  = nv_acno1          /*Ceding Co. No.*/
  sic_bran.uwm100.cedsi  = nv_cedsi          /*Ceding Co. Sum Insured*/
  sic_bran.uwm100.cedpol = nv_cedpol         /*Open Cover/Master Policy No.*/      
  sic_bran.uwm100.cedces = "0"               /*Ceding Co. Cession No.*/
  sic_bran.uwm100.recip  = "N"               /*Reciprocal (Y/N/C)*/
  sic_bran.uwm100.short  = YES               /*Short Term Rates*/
  sic_bran.uwm100.receit = "".               /*Receipt No.*/

ASSIGN                              
  sic_bran.uwm100.fptr01 = 0                 /*First uwd100 Policy Upper Text*/
  sic_bran.uwm100.bptr01 = 0                 /*Last  uwd100 Policy Upper Text*/
  sic_bran.uwm100.fptr02 = 0                 /*First uwd102 Policy Memo Text*/
  sic_bran.uwm100.bptr02 = 0                 /*Last  uwd102 Policy Memo Text*/
  sic_bran.uwm100.fptr03 = 0                 /*First uwd105 Policy Clauses*/
  sic_bran.uwm100.bptr03 = 0                 /*Last  uwd105 Policy Clauses*/
  sic_bran.uwm100.fptr04 = 0                 /*First uwd103 Policy Ren. Text*/
  sic_bran.uwm100.bptr04 = 0                 /*Last uwd103 Policy Ren. Text*/
  sic_bran.uwm100.fptr05 = 0                 /*First uwd104 Policy Endt. Text*/
  sic_bran.uwm100.bptr05 = 0                 /*Last uwd104 Policy Endt. Text*/
  sic_bran.uwm100.fptr06 = 0                 /*First uwd106 Pol.Endt.Clauses*/
  sic_bran.uwm100.bptr06 = 0                 /*Last uwd106 Pol. Endt. Clauses*/
  sic_bran.uwm100.coins  = NO                /*Is this Coinsurance (Y/N)*/
  sic_bran.uwm100.billco = ""                /*Bill Coinsurer's Share (Y/N)*/
  sic_bran.uwm100.pmhead = ""                /*Premium Headings on Schedule*/
  sic_bran.uwm100.usrid  = nv_usrid          /*User Id*/
  sic_bran.uwm100.entdat = nv_trndat         /*Entered Date*/
  sic_bran.uwm100.enttim = nv_enttim         /*Entered Time*/
  sic_bran.uwm100.prog   = nv_prog         /*Program Id that input record*/
  sic_bran.uwm100.usridr = ""                /*Release User Id*/
  sic_bran.uwm100.reldat = ?                 /*Release Date*/
  sic_bran.uwm100.reltim = ""                /*Release Time*/
  /*sic_bran.uwm100.polsta = "IF"            /*Policy Status*/*/
  sic_bran.uwm100.rilate = NO                /*RI to Enter Later*/
  sic_bran.uwm100.releas = NO                /*Transaction Released*/
  sic_bran.uwm100.sch_p  = NO                /*Schedule Printed*/
  sic_bran.uwm100.drn_p  = NO                /*Dr/Cr Note Printed*/
  sic_bran.uwm100.ri_p   = NO                /*RI Application Printed*/
  sic_bran.uwm100.cert_p = NO                /*Certificate Printed*/
  sic_bran.uwm100.dreg_p = NO                /*Daily Prem. Reg. Printed*/
  sic_bran.uwm100.langug = "T"               /*Language*/
  sic_bran.uwm100.sigr_p = nv_si             /*SI Gross Pol. Total*/
  sic_bran.uwm100.sico_p = nv_sicop          /*SI Coinsurance Pol. Total*/
  sic_bran.uwm100.sist_p = nv_sistp          /*SI Statutory Pol. Total*/
  sic_bran.uwm100.sifa_p = nv_sifap          /*SI Facultative Pol. Total*/
  sic_bran.uwm100.sity_p = nv_sityp          /*SI Treaty Pol. Total*/
  sic_bran.uwm100.siqs_p = nv_siqsp          /*SI Quota Share Pol. Total*/
  sic_bran.uwm100.co_per = 0                 /*Coinsurance %*/
  sic_bran.uwm100.acctim = "00:00"           /*Acceptance Time*/
  sic_bran.uwm100.agtref = ""                /*Agents Closing Reference*/
  sic_bran.uwm100.sckno  = 0                 /*sticker no.*/
  sic_bran.uwm100.anam1  = ""                /*Alternative Insured Name 1*/
  sic_bran.uwm100.sirt_p = 0                 /*SI RETENTION Pol. total*/
  sic_bran.uwm100.anam2  = ""                /*Alternative Insured Name 2*/
  sic_bran.uwm100.gstrat = nv_gstrat         /*GST Rate %*/
  sic_bran.uwm100.prem_g = 0                 /*Premium GST*/
  sic_bran.uwm100.com1_g = 0                 /*Commission 1 GST*/
  sic_bran.uwm100.com3_g = 0                 /*Commission 3 GST*/
  sic_bran.uwm100.com4_g = 0                 /*Commission 4 GST*/
  sic_bran.uwm100.gstae  = YES               /*GST A/E*/
  sic_bran.uwm100.nr_pol = NO                /*New Policy No. (Y/N)*/
  /*sic_bran.uwm100.issdat = nv_trndat       /*Issue date*/--Chutikarn*/
  sic_bran.uwm100.issdat = nv_comdat         /*Issue date*/
  sic_bran.uwm100.cr_1   = ""                /*A/C 1 cash(C)/credit(R) agent*/
  sic_bran.uwm100.cr_2   = nv_append         /*Appened กรมธรรม์ พ่วง */
  sic_bran.uwm100.cr_3   = ""                /*A/C 3 cash(C)/credit(R) agent*/
  sic_bran.uwm100.rt_er  = NO                /*Batch Release*/
  /*sic_bran.uwm100.endern = nv_trndat.      /*End Date of Earned Premium*/  == Comment By Chutikarn A53-0015 ==*/
  sic_bran.uwm100.endern = ?.                /*Receipt Date*/  /*== Add By Chutikarn A53-0015 ==*/

  /*IF (nv_endcnt > 0) AND (nv_status = "END" OR nv_status = "CAN") THEN DO: --wantanee 28/09/2006-*/
  IF nv_status = "END" OR nv_status = "CAN" THEN DO: /*--Endorse And Cancel--*/
     IF nv_status = "CAN" THEN DO:
          ASSIGN
           sic_bran.uwm100.polsta = "CA"
           sic_bran.uwm100.tranty = "C".        /*Transaction Type (N/R/E/C/T)*/
     END.                              
     ELSE DO:                          
          ASSIGN                       
           sic_bran.uwm100.polsta = "IF"        
           sic_bran.uwm100.tranty = "E".        /*Transaction Type (N/R/E/C/T)*/
     END.                              
     ASSIGN                            
         sic_bran.uwm100.prvpol = nv_prvpol     /*Prvpol Policy No.*/
         sic_bran.uwm100.enddat = nv_trndat     /*Endorsement Date*/
         sic_bran.uwm100.fstdat = nv_fdateold   /*First Issue Date of Policy*/
         sic_bran.uwm100.renpol = nv_renpol     /*Renewal Policy No.*/
         sic_bran.uwm100.enform = "F"           /*Endt. Format (Full/Abbr/Blank)*/
         sic_bran.uwm100.endno  = nv_endnum.    /*Endorsement No.*/
  END.
  /*ELSE IF (nv_endcnt = 0 AND nv_rencnt > 0) AND (nv_status = "REP" OR nv_status = "REN") THEN DO: --Wantanee 28/09/2006*/
  ELSE IF nv_status = "REP" OR nv_status = "REN" THEN DO: /*--Renew--*/
     ASSIGN
         sic_bran.uwm100.polsta = "IF"
         sic_bran.uwm100.prvpol = nv_policyold   /*Prvpol Policy No.*/
         sic_bran.uwm100.enddat = ?              /*Endorsement Date*/
         sic_bran.uwm100.fstdat = nv_fdateold    /*First Issue Date of Policy*/
         sic_bran.uwm100.renpol = ""             /*Renewal Policy No.*/
         sic_bran.uwm100.tranty = "R"            /*Transaction Type (N/R/E/C/T)*/
         sic_bran.uwm100.enform = ""             /*Endt. Format (Full/Abbr/Blank)*/
         sic_bran.uwm100.endno  = "".            /*Endorsement No.*/
  END.
  ELSE IF (nv_endcnt = 0 AND nv_rencnt = 0) AND (nv_status = "NEW") THEN DO: /*--New--*/
     ASSIGN
         sic_bran.uwm100.polsta = "IF"
         sic_bran.uwm100.prvpol = ""             /*Prvpol Policy No.*/
         sic_bran.uwm100.enddat = ?              /*Endorsement Date*/
         sic_bran.uwm100.fstdat = nv_comdat      /*First Issue Date of Policy*/
         sic_bran.uwm100.renpol = ""             /*Renewal Policy No.*/
         sic_bran.uwm100.tranty = "N"            /*Transaction Type (N/R/E/C/T)*/
         sic_bran.uwm100.enform = ""             /*Endt. Format (Full/Abbr/Blank)*/
         sic_bran.uwm100.endno  = "".            /*Endorsement No.*/
  END.

  /*---wantanee 29/09/2006 A49-0165----*/
  ASSIGN
      sic_bran.uwm100.bchyr     = nv_batchyr       /*Batch Year */  
      sic_bran.uwm100.bchno     = nv_batchno       /*Batch No.  */  
      sic_bran.uwm100.bchcnt    = nv_batcnt        /*Batch Count*/  
      sic_bran.uwm100.impflg    = nv_polflg        /*Policy Flag*/
      sic_bran.uwm100.imperr    = nv_texterror     /*Detail Error*/
      sic_bran.uwm100.impusrid  = nv_usrid
      sic_bran.uwm100.impdat    = TODAY
      sic_bran.uwm100.imptim    = STRING(TIME,"HH:MM:SS").
  /*-------------*/

  n_recid100 = RECID(sic_bran.uwm100).

/*---Wantanee 28/09/2006----
IF nv_policyold <> "" THEN DO:
  FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE
            sicuw.uwm100.policy = nv_policyold
  NO-ERROR NO-WAIT.
  IF AVAILABLE sicuw.uwm100 THEN DO:
    /*DO TRANSACTION:*/
      sicuw.uwm100.renpol = nv_policy.
    /*END.*/
  END.
END.
---Wantanee 28/09/2006----*/
/* END OF FILE : TMGEN100.P */
