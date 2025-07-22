/*----- Main wgwtrnf1.p
Author: 
       Narin  06/10/10   <Assign A52-242> 
       Create Table : uwm100 , uwm110 , uwm120 , uwm130 , etc
   สรุปหลักการ Connect Database GW  และ Database local 
   1. DATABASE GW  ที่ CONNECT ได้ ให้ทำการ DISCONNECT ออก SIC_BRAN  กับ  BRSTAT
      และ ทำการ Conncet database : gw_safe  &  gw_stat
          sic_bran  
          brstat    --->  gw_stat
   2. DATABASE Local Connect ดังนี้ 
          bransafe --->  -ld  brsic_bran
          brstat   --->  -ld  brstat
-----*/                             

DEFINE NEW SHARED VAR sh_policy  AS CHARACTER FORMAT "X(16)"  INITIAL ""  NO-UNDO.
DEFINE NEW SHARED VAR sh_rencnt  AS INTEGER   FORMAT "999".
DEFINE NEW SHARED VAR sh_endcnt  AS INTEGER   FORMAT "999".
DEFINE NEW SHARED VAR sh_insref  AS CHARACTER FORMAT "X(10)"  INITIAL "" NO-UNDO. 

DEFINE NEW SHARED VAR nv_duprec100  AS LOGI INIT NO NO-UNDO. 
DEFINE NEW SHARED VAR nv_duprec120  AS LOGI INIT NO NO-UNDO.
DEFINE NEW SHARED VAR nv_duprec301  AS LOGI INIT NO NO-UNDO.

DEFINE VAR nv_rencnt    AS INTEGER   FORMAT "999"         INITIAL 0   NO-UNDO.
DEFINE VAR nv_endcnt    AS INTEGER   FORMAT "999"         INITIAL 0   NO-UNDO.
/*--  (dup)
DEFINE VAR nv_premtot  AS DECI FORMAT "->,>>>,>>>,>>9.99"  INIT 0.  /* เบี้ยสุทธิ ทั้งหมด */
DEFINE VAR nv_stmptot  AS DECI FORMAT "->>>,>>>,>>9.99"    INIT 0.  /* แสตมป์ทั้งหมด */
DEFINE VAR nv_taxtot   AS DECI FORMAT "->>>,>>>,>>9.99"    INIT 0.  /* แวตทั้งหมด */
                       
DEFINE VAR nv_premsuc  AS DECI FORMAT "->,>>>,>>>,>>9.99"  INIT 0.  /* เบี้ยสุทธิ ที่นำเข้าได้ */
DEFINE VAR nv_stmpsuc  AS DECI FORMAT "->>>,>>>,>>9.99"    INIT 0.  /* แสตมป์ที่นำเข้าได้ */    
DEFINE VAR nv_taxsuc   AS DECI FORMAT "->>>,>>>,>>9.99"    INIT 0.  /* แวตที่นำเข้าได้ */
                       
DEFINE VAR nv_rectot    AS INT  FORMAT ">>,>>9"         INITIAL 0.  /* Display จำนวน ก/ธ ทั้งไฟล์ */
DEFINE VAR nv_recsuc    AS INT  FORMAT ">>,>>9"         INITIAL 0.  /* Display จำนวน ก/ธ ที่นำเข้าได้ */

DEFINE VAR nv_netprm_t  AS DECI FORMAT "->,>>>,>>9.99"  INITIAL 0.  /* Display เบี้ยรวม ทั้งไฟล์ */
DEFINE VAR nv_netprm_s  AS DECI FORMAT "->,>>>,>>9.99"  INITIAL 0.  /* Display เบี้ยรวม ที่นำเข้าได้ */
--*/
DEFINE VAR nv_line      AS INTEGER                      INITIAL 0     NO-UNDO.

/*-- (dup)
DEFINE VAR nv_reccnt        AS INT  INIT  0.  /*All load record*/
--*/
DEFINE VAR nv_completecnt   AS INT  INIT  0.  /*Complete record */
/*-- (dup)
DEFINE VAR nv_com1p     AS DECIMAL   FORMAT ">,>>>,>>>,>>9.99-" INITIAL 0 NO-UNDO.
DEFINE VAR nv_com1_t    AS DECIMAL   FORMAT ">,>>>,>>>,>>9.99-" INITIAL 0.
DEFINE VAR nv_com1_sum  AS DECIMAL   FORMAT ">,>>>,>>>,>>9.99-" INITIAL 0.
---*/
DEFINE VAR nv_prem_t    AS DECIMAL   FORMAT ">,>>>,>>>,>>9.99-" INITIAL 0.
DEFINE VAR nv_stamp     AS DECIMAL   FORMAT ">>>,>>>,>>9.99-"   INITIAL 0.
DEFINE VAR nv_tax       AS DECIMAL   FORMAT ">>>,>>>,>>9.99-"   INITIAL 0.

DEFINE VAR nv_output4   AS CHARACTER FORMAT "X(100)"  INITIAL "" NO-UNDO.
DEFINE VAR nv_policy    AS CHARACTER FORMAT "X(16)"   INITIAL "" NO-UNDO.
DEFINE VAR nv_trty11    AS CHARACTER FORMAT "X"       INITIAL "" NO-UNDO.
DEFINE VAR nv_docno1    AS CHARACTER FORMAT "X(16)"    INITIAL "" NO-UNDO.


DEFINE INPUT-OUTPUT PARAMETER  fi_impcnt        AS INT  FORMAT ">>,>>9".
DEFINE INPUT-OUTPUT PARAMETER  fi_completecnt   AS INT  FORMAT ">>,>>9".
DEFINE INPUT-OUTPUT PARAMETER  fi_premtot       AS DECI FORMAT "->,>>>,>>9.99" NO-UNDO.
DEFINE INPUT-OUTPUT PARAMETER  fi_premsuc       AS DECI FORMAT "->,>>>,>>9.99" NO-UNDO.

DEFINE INPUT-OUTPUT PARAMETER  nv_batchyr   AS INT FORMAT "9999" INIT 0.
DEFINE INPUT-OUTPUT PARAMETER  nv_batchno   AS CHARACTER FORMAT "X(13)"     INIT ""  NO-UNDO.
DEFINE INPUT-OUTPUT PARAMETER  nv_batcnt    AS INT FORMAT "99"              INIT 0.
DEFINE INPUT-OUTPUT PARAMETER  n_user       AS CHARACTER NO-UNDO.


DEFINE INPUT-OUTPUT PARAMETER  fi_output4   AS CHAR FORMAT "X(100)".
DEFINE INPUT-OUTPUT PARAMETER  nv_releas    AS logi INIT NO NO-UNDO.

DEFINE INPUT-OUTPUT PARAMETER  nv_reccnt    AS  INT  FORMAT ">>,>>>,>>9".
DEFINE INPUT-OUTPUT PARAMETER  nv_netprm_t  AS  DECI FORMAT "->,>>>,>>>,>>9.99".
DEFINE INPUT-OUTPUT PARAMETER  nv_rectot    AS  INT  FORMAT ">>,>>>,>>9".
DEFINE INPUT-OUTPUT PARAMETER  nv_premtot   AS  DECI FORMAT "->,>>>,>>>,>>9.99".
DEFINE INPUT-OUTPUT PARAMETER  nv_stmptot   AS  DECI FORMAT "->>>,>>>,>>9.99".
DEFINE INPUT-OUTPUT PARAMETER  nv_taxtot    AS  DECI FORMAT "->>>,>>>,>>9.99".
DEFINE INPUT-OUTPUT PARAMETER  nv_recsuc    AS  INT  FORMAT ">>,>>>,>>9".
DEFINE INPUT-OUTPUT PARAMETER  nv_stmpsuc   AS  DECI FORMAT "->>>,>>>,>>9.99".
DEFINE INPUT-OUTPUT PARAMETER  nv_taxsuc    AS  DECI FORMAT "->>>,>>>,>>9.99".
DEFINE INPUT-OUTPUT PARAMETER  nv_premsuc   AS  DECI FORMAT "->,>>>,>>>,>>9.99".
DEFINE INPUT-OUTPUT PARAMETER  nv_netprm_s  AS  DECI FORMAT "->,>>>,>>>,>>9.99".
DEFINE INPUT-OUTPUT PARAMETER  nv_com1p     AS  DECI FORMAT ">,>>>,>>>,>>9.99-".
DEFINE INPUT-OUTPUT PARAMETER  nv_com1_t    AS  DECI FORMAT ">,>>>,>>>,>>9.99-".
DEFINE INPUT-OUTPUT PARAMETER  nv_com1_sum  AS  DECI FORMAT ">,>>>,>>>,>>9.99-".
/* DEFINE INPUT-OUTPUT PARAMETER  fi_filename  AS CHAR FORMAT "X(100)". */

DEFINE VAR nv_fptr    AS   RECID.
DEFINE VAR nv_bptr    AS   RECID.

DEF BUFFER wf_uwd100 FOR sic_bran.uwd100.
DEF BUFFER wf_uwd102 FOR sic_bran.uwd102.
DEF BUFFER wf_uwd103 FOR sic_bran.uwd103.
DEF BUFFER wf_uwd104 FOR sic_bran.uwd104.
DEF BUFFER wf_uwd105 FOR sic_bran.uwd105.
DEF BUFFER wf_uwd106 FOR sic_bran.uwd106.

DEF SHARED STREAM ns1.
DEF VAR putchr AS CHAR FORMAT "x(100)" INIT "" NO-UNDO.

   ASSIGN 
      sh_policy   = ""
      sh_rencnt   = 0
      sh_endcnt   = 0

      nv_reccnt   = 0
      nv_netprm_t = 0
      
      nv_rectot   = 0
      nv_premtot  = 0
      nv_stmptot  = 0
      nv_taxtot   = 0
      nv_recsuc   = 0
      nv_stmpsuc  = 0
      nv_taxsuc   = 0
      nv_premsuc  = 0
      nv_netprm_s = 0 
      nv_com1p    = 0
      nv_output4  = "".
   
     FOR EACH brsic_bran.uwm100 USE-INDEX uwm10001 :
          
              ASSIGN
                sh_policy  = brsic_bran.uwm100.policy
                sh_rencnt  = brsic_bran.uwm100.rencnt
                sh_endcnt  = brsic_bran.uwm100.endcnt
                nv_rencnt  = brsic_bran.uwm100.rencnt
                nv_endcnt  = 0.

                nv_rectot  = nv_rectot + 1.
                nv_premtot = nv_premtot + brsic_bran.uwm100.prem_t.
                nv_stmptot = nv_stmptot + brsic_bran.uwm100.rstp_t.
                nv_taxtot  = nv_taxtot  + brsic_bran.uwm100.rtax_t.

                nv_netprm_t = nv_netprm_t + brsic_bran.uwm100.prem_t + brsic_bran.uwm100.rstp_t + brsic_bran.uwm100.rtax_t .
                nv_line     = nv_line + 1.

                IF nv_prem_t > 0 THEN  nv_com1_t = nv_com1_t * -1.
                IF nv_com1_t = 0 THEN  nv_com1p  = 0.

              ASSIGN
                  fi_impcnt      = nv_rectot
                  nv_recsuc      = nv_rectot
                  fi_completecnt = nv_recsuc
                  nv_netprm_s    = nv_netprm_t
                  fi_premtot     = nv_netprm_s
                  fi_premsuc     = nv_netprm_s    
                    
                  nv_stmpsuc     = nv_stmptot
                  nv_taxsuc      = nv_taxtot .

                 FIND FIRST sic_bran.uwm100 WHERE 
                       sic_bran.uwm100.policy = brsic_bran.uwm100.policy AND
                       sic_bran.uwm100.endcnt = brsic_bran.uwm100.endcnt AND
                       sic_bran.uwm100.rencnt = brsic_bran.uwm100.rencnt AND
                       sic_bran.uwm100.bchyr  = nv_batchyr          AND
                       sic_bran.uwm100.bchno  = nv_batchno          AND
                       sic_bran.uwm100.bchcnt = nv_batcnt 

                 NO-ERROR .
                        
                 IF AVAILABLE sic_bran.uwm100 THEN DO:
                               nv_duprec100 = yes.    
                        IF sic_bran.uwm100.releas THEN NEXT.
            
                        IF   sic_bran.uwm100.releas = NO AND
                           brsic_bran.uwm100.releas   THEN nv_duprec100 = NO.
            
                        IF nv_duprec100 = YES THEN DO:
                           
                            RUN  wgw/wgwtc100.p.
            
                        END.  /*IF nv_duprec100 = YES*/
            
                        /* record host = brsic_bran */
                        IF nv_duprec100 = YES THEN DO: /* next loop_uwm100. */
            
                           
                            RUN wgw/wgwtc301.p.
            
                           
                            RUN wgw/wgwtcdet.p.
                
                           IF nv_duprec100 = YES THEN DO:
                             
                                RUN wgw/wgwtc130.p.
                
                              IF nv_duprec100 = YES THEN DO:
                                
                                  RUN wgw/wgwtc120.p.
                              END.
                           END.
/** Message DUP 4/10/10 **/
                           RUN wgw\wgwdup72.p .

                        END.
                 END.
                 ELSE DO:

                       CREATE sic_bran.uwm100.
                       nv_duprec100 = NO.
            
                 END. /*IF AVAILABLE sic_bran.uwm100 */
                 /*check record brsic_bran is not update or chang data*/
                 IF nv_duprec100 = YES THEN NEXT.  /* SKIP RECORD REMOTE.UWM100 */
            
                 nv_releas = brsic_bran.uwm100.releas. /* CHECH SCO */
                  /*DELETE uwd100 */
                  nv_fptr = sic_bran.uwm100.fptr01.
                  DO WHILE nv_fptr <> 0 AND sic_bran.uwm100.fptr01 <> ? :
            
                     FIND sic_bran.uwd100 WHERE RECID(sic_bran.uwd100) = nv_fptr
                     NO-ERROR.
                     IF AVAILABLE sic_bran.uwd100 THEN DO: /*sombat */
                        nv_fptr = sic_bran.uwd100.fptr.
            
                        IF sic_bran.uwd100.policy = brsic_bran.uwm100.policy AND
                           sic_bran.uwd100.rencnt = brsic_bran.uwm100.rencnt AND
                           sic_bran.uwd100.endcnt = brsic_bran.uwm100.endcnt THEN DO:
                           DELETE sic_bran.uwd100.
                        END.
                        ELSE nv_fptr = 0.
                     END.
                     ELSE    nv_fptr = 0.
                  END.
            
                  /*DELETE uwd102 */
                  nv_fptr = sic_bran.uwm100.fptr02.
                  DO WHILE nv_fptr <> 0 AND sic_bran.uwm100.fptr02 <> ? :
            
                     FIND sic_bran.uwd102 WHERE RECID(sic_bran.uwd102) = nv_fptr
                     NO-ERROR.
                     IF AVAILABLE sic_bran.uwd102 THEN DO: /*sombat */
                        nv_fptr = sic_bran.uwd102.fptr.
            
                        IF sic_bran.uwd102.policy = brsic_bran.uwm100.policy AND
                           sic_bran.uwd102.rencnt = brsic_bran.uwm100.rencnt AND
                           sic_bran.uwd102.endcnt = brsic_bran.uwm100.endcnt THEN DO:
                           DELETE sic_bran.uwd102.
                        END.
                        ELSE nv_fptr = 0.
                     END.
                     ELSE    nv_fptr = 0.
                  END.
            
                  /*DELETE uwd103 */
                  nv_fptr = sic_bran.uwm100.fptr04.
                  DO WHILE nv_fptr <> 0 AND sic_bran.uwm100.fptr04 <> ? :
            
                     FIND sic_bran.uwd103 WHERE RECID(sic_bran.uwd103) = nv_fptr
                     NO-ERROR.
                     IF AVAILABLE sic_bran.uwd103 THEN DO: /*sombat */
                        nv_fptr = sic_bran.uwd103.fptr.
            
                        IF sic_bran.uwd103.policy = brsic_bran.uwm100.policy AND
                           sic_bran.uwd103.rencnt = brsic_bran.uwm100.rencnt AND
                           sic_bran.uwd103.endcnt = brsic_bran.uwm100.endcnt THEN DO:
                           DELETE sic_bran.uwd103.
                        END.
                        ELSE nv_fptr = 0.
                     END.
                     ELSE    nv_fptr = 0.
                  END.
            
                  /*DELETE uwd104 */
                  nv_fptr = sic_bran.uwm100.fptr05.
                  DO WHILE nv_fptr <> 0 AND sic_bran.uwm100.fptr05 <> ? :
                     FIND sic_bran.uwd104 WHERE RECID(sic_bran.uwd104) = nv_fptr
                     NO-ERROR.
                     IF AVAILABLE sic_bran.uwd104 THEN DO: /*sombat */
                        nv_fptr = sic_bran.uwd104.fptr.
            
                        IF sic_bran.uwd104.policy = brsic_bran.uwm100.policy AND
                           sic_bran.uwd104.rencnt = brsic_bran.uwm100.rencnt AND
                           sic_bran.uwd104.endcnt = brsic_bran.uwm100.endcnt THEN DO:
                           DELETE sic_bran.uwd104.
                        END.
                        ELSE nv_fptr = 0.
                     END.
                     ELSE    nv_fptr = 0.
                  END.
            
                  /*DELETE uwd105 */
                  nv_fptr = sic_bran.uwm100.fptr03.
                  DO WHILE nv_fptr <> 0 AND sic_bran.uwm100.fptr03 <> ? :
                     FIND sic_bran.uwd105 WHERE RECID(sic_bran.uwd105) = nv_fptr
                     NO-ERROR.
                     IF AVAILABLE sic_bran.uwd105 THEN DO: /*sombat */
                        nv_fptr = sic_bran.uwd105.fptr.
            
                        IF sic_bran.uwd105.policy = brsic_bran.uwm100.policy AND
                           sic_bran.uwd105.rencnt = brsic_bran.uwm100.rencnt AND
                           sic_bran.uwd105.endcnt = brsic_bran.uwm100.endcnt THEN DO:
                           DELETE sic_bran.uwd105.
                        END.
                        ELSE nv_fptr = 0.
                     END.
                     ELSE    nv_fptr = 0.
                  END.
            
                  /*DELETE uwd106 */
                  nv_fptr = sic_bran.uwm100.fptr06.
                  DO WHILE nv_fptr <> 0 AND sic_bran.uwm100.fptr06 <> ? :
                     FIND sic_bran.uwd106 WHERE RECID(sic_bran.uwd106) = nv_fptr
                     NO-ERROR.
                     IF AVAILABLE sic_bran.uwd106 THEN DO: /*sombat */
                        nv_fptr = sic_bran.uwd106.fptr.
            
                        IF sic_bran.uwd106.policy = brsic_bran.uwm100.policy AND
                           sic_bran.uwd106.rencnt = brsic_bran.uwm100.rencnt AND
                           sic_bran.uwd106.endcnt = brsic_bran.uwm100.endcnt THEN DO:
                           DELETE sic_bran.uwd106.
                        END.
                        ELSE nv_fptr = 0.
                     END.
                     ELSE    nv_fptr = 0.
                  END.
              /*------- 1)     Proc_uwm100------*/
              /*Update data uwm100 */
                ASSIGN
                    sic_bran.uwm100.fptr01 = 0                     /*First uwd100 Policy Up reci  */
                    sic_bran.uwm100.bptr01 = 0                     /*Last  uwd100 Policy Up reci  */
                    sic_bran.uwm100.fptr02 = 0                     /*First uwd102 Policy Me reci  */
                    sic_bran.uwm100.bptr02 = 0                     /*Last  uwd102 Policy Me reci  */
                    sic_bran.uwm100.fptr03 = 0                     /*First uwd105 Policy Cl reci  */
                    sic_bran.uwm100.bptr03 = 0                     /*Last  uwd105 Policy Cl reci  */
                    sic_bran.uwm100.fptr04 = 0                     /*First uwd103 Policy Re reci  */
                    sic_bran.uwm100.bptr04 = 0                     /*Last  uwd103 Policy Ren reci  */
                    sic_bran.uwm100.fptr05 = 0                     /*First uwd104 Policy En reci  */
                    sic_bran.uwm100.bptr05 = 0                     /*Last  uwd104 Policy End reci  */
                    sic_bran.uwm100.fptr06 = 0                     /*First uwd106 Pol.Endt. reci  */
                    sic_bran.uwm100.bptr06 = 0                     /*Last  uwd106 Pol. Endt. reci  */
                    /* ----------------------------------- */
                    sic_bran.uwm100.policy = brsic_bran.uwm100.policy  /*Policy No.             char  */
                    sic_bran.uwm100.rencnt = brsic_bran.uwm100.rencnt  /*Renewal Count          inte  */
                    sic_bran.uwm100.endcnt = brsic_bran.uwm100.endcnt  /*Endorsement Count      inte  */
                    sic_bran.uwm100.renno  = brsic_bran.uwm100.renno   /*Renewal No.            char  */
                    sic_bran.uwm100.endno  = brsic_bran.uwm100.endno   /*Endorsement No.        char  */
                    sic_bran.uwm100.curbil = brsic_bran.uwm100.curbil  /*Currency of Billing    char  */
                    sic_bran.uwm100.curate = brsic_bran.uwm100.curate  /*Currency rate for Bill deci-7*/
                    sic_bran.uwm100.branch = brsic_bran.uwm100.branch  /*Branch Code (of Transa char  */
                    sic_bran.uwm100.dir_ri = brsic_bran.uwm100.dir_ri  /*Direct/RI Code (D/R)   logi  */
                    sic_bran.uwm100.dept   = brsic_bran.uwm100.dept    /*Department code        char  */
                    sic_bran.uwm100.cntry  = brsic_bran.uwm100.cntry   /*Country where risk is  char  */
                    sic_bran.uwm100.agent  = brsic_bran.uwm100.agent   /*Agent's Ref. No.       char  */
                    sic_bran.uwm100.poltyp = brsic_bran.uwm100.poltyp  /*Policy Type            char  */
                    sic_bran.uwm100.insref = brsic_bran.uwm100.insref  /*Insured's Ref. No.     char  */
                    sic_bran.uwm100.opnpol = brsic_bran.uwm100.opnpol  /*Open Cover/Master Poli char  */
                    sic_bran.uwm100.prvpol = brsic_bran.uwm100.prvpol  /*Previous Policy No.    char  */
                    sic_bran.uwm100.ntitle = brsic_bran.uwm100.ntitle  /*Title for Name Mr/Mrs/ char  */
                    sic_bran.uwm100.fname  = brsic_bran.uwm100.fname   /*First Name             char  */
                    sic_bran.uwm100.name1  = brsic_bran.uwm100.name1   /*Name of Insured Line 1 char  */
                    sic_bran.uwm100.name2  = brsic_bran.uwm100.name2   /*Name of Insured Line 2 char  */
                    sic_bran.uwm100.name3  = brsic_bran.uwm100.name3.  /*Name of Insured Line 3 char  */
            
                  ASSIGN
                    sic_bran.uwm100.addr1  = brsic_bran.uwm100.addr1   /*Address 1              char  */
                    sic_bran.uwm100.addr2  = brsic_bran.uwm100.addr2   /*Address 2              char  */
                    sic_bran.uwm100.addr3  = brsic_bran.uwm100.addr3   /*Address 3              char  */
                    sic_bran.uwm100.addr4  = brsic_bran.uwm100.addr4   /*Address 4              char  */
                    sic_bran.uwm100.postcd = brsic_bran.uwm100.postcd  /*Postal Code            char  */
                    sic_bran.uwm100.occupn = brsic_bran.uwm100.occupn  /*Occupation Description char  */
                    sic_bran.uwm100.comdat = brsic_bran.uwm100.comdat  /*Cover Commencement Dat date  */
                    sic_bran.uwm100.expdat = brsic_bran.uwm100.expdat  /*Expiry Date            date  */
                    sic_bran.uwm100.enddat = brsic_bran.uwm100.enddat  /*Endorsement Date       date  */
                    sic_bran.uwm100.accdat = brsic_bran.uwm100.accdat  /*Acceptance Date        date  */
                    sic_bran.uwm100.trndat = brsic_bran.uwm100.trndat  /*Transaction Date       date  */
                    sic_bran.uwm100.rendat = brsic_bran.uwm100.rendat  /*Date Renewal Notice Pr date  */
                    sic_bran.uwm100.terdat = brsic_bran.uwm100.terdat  /*Termination Date       date  */
                    sic_bran.uwm100.fstdat = brsic_bran.uwm100.fstdat  /*First Issue Date of Po date  */
                    sic_bran.uwm100.cn_dat = brsic_bran.uwm100.cn_dat  /*Cover Note Date        date  */
                    sic_bran.uwm100.cn_no  = brsic_bran.uwm100.cn_no   /*Cover Note No.         inte  */
                    sic_bran.uwm100.tranty = brsic_bran.uwm100.tranty  /*Transaction Type (N/R/ char  */
                    sic_bran.uwm100.undyr  = brsic_bran.uwm100.undyr   /*Underwriting Year      char  */
                    sic_bran.uwm100.acno1  = brsic_bran.uwm100.acno1   /*Account no. 1          char  */
                    sic_bran.uwm100.acno2  = brsic_bran.uwm100.acno2   /*Account no. 2          char  */
                    sic_bran.uwm100.acno3  = brsic_bran.uwm100.acno3   /*Account no. 3          char  */
                    sic_bran.uwm100.instot = brsic_bran.uwm100.instot  /*Total No. of Instalmen deci-0*/
                    sic_bran.uwm100.pstp   = brsic_bran.uwm100.pstp    /*Policy Level Stamp     deci-2*/
                    sic_bran.uwm100.pfee   = brsic_bran.uwm100.pfee    /*Policy Level Fee       deci-2*/
                    sic_bran.uwm100.ptax   = brsic_bran.uwm100.ptax    /*Policy Level Tax       deci-2*/
                    sic_bran.uwm100.rstp_t = brsic_bran.uwm100.rstp_t  /*Risk Level Stamp, Tran deci-2*/
                    sic_bran.uwm100.rfee_t = brsic_bran.uwm100.rfee_t  /*Risk Level Fee, Tran.  deci-2*/
                    sic_bran.uwm100.rtax_t = brsic_bran.uwm100.rtax_t  /*Risk Level Tax, Tran.  deci-2*/
                    sic_bran.uwm100.prem_t = brsic_bran.uwm100.prem_t  /*Premium Due, Tran. Tot deci-2*/
                    sic_bran.uwm100.pdco_t = brsic_bran.uwm100.pdco_t  /*PD Coinsurance, Tran.  deci-2*/
                    sic_bran.uwm100.pdst_t = brsic_bran.uwm100.pdst_t  /*PD Statutory, Tran. to deci-2*/
                    sic_bran.uwm100.pdfa_t = brsic_bran.uwm100.pdfa_t  /*PD Facultative, Tran.  deci-2*/
                    sic_bran.uwm100.pdty_t = brsic_bran.uwm100.pdty_t  /*PD Treaty, Tran. Total deci-2*/
                    sic_bran.uwm100.pdqs_t = brsic_bran.uwm100.pdqs_t. /*PD Quota Share, Tran.  deci-2*/
            
                  ASSIGN
                    sic_bran.uwm100.com1_t = brsic_bran.uwm100.com1_t  /*Commission 1, Tran. To deci-2*/
                    sic_bran.uwm100.com2_t = brsic_bran.uwm100.com2_t  /*Commission 2, Tran. To deci-2*/
                    sic_bran.uwm100.com3_t = brsic_bran.uwm100.com3_t  /*Commission 3, Tran. To deci-2*/
                    sic_bran.uwm100.com4_t = brsic_bran.uwm100.com4_t  /*Commission 4, Tran. To deci-2*/
                    sic_bran.uwm100.coco_t = brsic_bran.uwm100.coco_t  /*Comm. Coinsurance, Tra deci-2*/
                    sic_bran.uwm100.cost_t = brsic_bran.uwm100.cost_t  /*Comm. Statutory, Tran. deci-2*/
                    sic_bran.uwm100.cofa_t = brsic_bran.uwm100.cofa_t  /*Comm. Facultative, Tra deci-2*/
                    sic_bran.uwm100.coty_t = brsic_bran.uwm100.coty_t  /*Comm. Treaty, Tran. To deci-2*/
                    sic_bran.uwm100.coqs_t = brsic_bran.uwm100.coqs_t  /*Comm. Quota Share, Tra deci-2*/
                    sic_bran.uwm100.reduc1 = brsic_bran.uwm100.reduc1  /*Reducing Balance 1 (Y/ logi  */
                    sic_bran.uwm100.reduc2 = brsic_bran.uwm100.reduc2  /*Reducing Balance 2 (Y/ logi  */
                    sic_bran.uwm100.reduc3 = brsic_bran.uwm100.reduc3  /*Reducing Balance 3 (Y/ logi  */
                    sic_bran.uwm100.gap_p  = brsic_bran.uwm100.gap_p   /*Gross Annual Prem, Pol deci-2*/
                    sic_bran.uwm100.dl1_p  = brsic_bran.uwm100.dl1_p   /*Discount/Loading 1, Po deci-2*/
                    sic_bran.uwm100.dl2_p  = brsic_bran.uwm100.dl2_p   /*Discount/Loading 2, Po deci-2*/
                    sic_bran.uwm100.dl3_p  = brsic_bran.uwm100.dl3_p   /*Discount/Loading 3, Po deci-2*/
                    sic_bran.uwm100.dl2red = brsic_bran.uwm100.dl2red  /*Disc./Load 2 Red. Bala logi  */
                    sic_bran.uwm100.dl3red = brsic_bran.uwm100.dl3red  /*Disc./Load 3 Red. Bala logi  */
                    sic_bran.uwm100.dl1sch = brsic_bran.uwm100.dl1sch  /*Disc./Load 1 Prt on Sc logi  */
                    sic_bran.uwm100.dl2sch = brsic_bran.uwm100.dl2sch  /*Disc./Load 2 Prt on Sc logi  */
                    sic_bran.uwm100.dl3sch = brsic_bran.uwm100.dl3sch  /*Disc./Load 3 Prt on Sc logi  */
                    sic_bran.uwm100.drnoae = brsic_bran.uwm100.drnoae  /*Dr/Cr Note No. (A/E)   logi  */
                    sic_bran.uwm100.insddr = brsic_bran.uwm100.insddr  /*Print Insd. Name on Dr logi  */
                    sic_bran.uwm100.trty11 = brsic_bran.uwm100.trty11  /*Tran. Type (1), A/C No char  */
                    sic_bran.uwm100.trty12 = brsic_bran.uwm100.trty12  /*Tran. Type (1), A/C No char  */
                    sic_bran.uwm100.trty13 = brsic_bran.uwm100.trty13  /*Tran. Type (1), A/C No char  */
                    sic_bran.uwm100.docno1 = brsic_bran.uwm100.docno1  /*Document No., A/C No.  char  */
                    sic_bran.uwm100.docno2 = brsic_bran.uwm100.docno2  /*Document No., A/C No.  char  */
                    sic_bran.uwm100.docno3 = brsic_bran.uwm100.docno3  /*Document No., A/C No.  char  */
                    sic_bran.uwm100.no_sch = brsic_bran.uwm100.no_sch  /*No. to print, Schedule inte  */
                    sic_bran.uwm100.no_dr  = brsic_bran.uwm100.no_dr   /*No. to print, Dr/Cr No inte  */
                    sic_bran.uwm100.no_ri  = brsic_bran.uwm100.no_ri   /*No. to print, RI Appln inte  */
                    sic_bran.uwm100.no_cer = brsic_bran.uwm100.no_cer. /*No. to print, Certific inte  */
            
                  ASSIGN
                    sic_bran.uwm100.li_sch = brsic_bran.uwm100.li_sch  /*Print Later/Imm., Sche logi  */
                    sic_bran.uwm100.li_dr  = brsic_bran.uwm100.li_dr   /*Print Later/Imm., Dr/C logi  */
                    sic_bran.uwm100.li_ri  = brsic_bran.uwm100.li_ri   /*Print Later/Imm., RI A logi  */
                    sic_bran.uwm100.li_cer = brsic_bran.uwm100.li_cer  /*Print Later/Imm., Cert logi  */
                    sic_bran.uwm100.scform = brsic_bran.uwm100.scform  /*Schedule Format        char  */
                    sic_bran.uwm100.enform = brsic_bran.uwm100.enform  /*Endt. Format (Full/Abb char  */
                    sic_bran.uwm100.apptax = brsic_bran.uwm100.apptax  /*Apply risk level tax ( logi  */
                    sic_bran.uwm100.dl1cod = brsic_bran.uwm100.dl1cod  /*Discount/Loading Type  char  */
                    sic_bran.uwm100.dl2cod = brsic_bran.uwm100.dl2cod  /*Discount/Loading Type  char  */
                    sic_bran.uwm100.dl3cod = brsic_bran.uwm100.dl3cod  /*Discount/Loading Type  char  */
                    sic_bran.uwm100.styp20 = brsic_bran.uwm100.styp20  /*Statistic Type Codes ( char  */
                    sic_bran.uwm100.sval20 = brsic_bran.uwm100.sval20  /*Statistic Value Codes  char  */
                    sic_bran.uwm100.finint = brsic_bran.uwm100.finint  /*Financial Interest Ref char  */
                    sic_bran.uwm100.cedco  = brsic_bran.uwm100.cedco   /*Ceding Co. No.         char  */
                    sic_bran.uwm100.cedsi  = brsic_bran.uwm100.cedsi   /*Ceding Co. Sum Insured deci-2*/
                    sic_bran.uwm100.cedpol = brsic_bran.uwm100.cedpol  /*Ceding Co. Policy No.  char  */
                    sic_bran.uwm100.cedces = brsic_bran.uwm100.cedces  /*Ceding Co. Cession No. char  */
                    sic_bran.uwm100.recip  = brsic_bran.uwm100.recip   /*Reciprocal (Y/N/C)     char  */
                    sic_bran.uwm100.short  = brsic_bran.uwm100.short   /*Short Term Rates       logi  */
                    sic_bran.uwm100.receit = brsic_bran.uwm100.receit  /*Receipt No.            char  */
                    sic_bran.uwm100.coins  = brsic_bran.uwm100.coins   /*Is this Coinsurance (Y logi  */
                    sic_bran.uwm100.billco = brsic_bran.uwm100.billco  /*Bill Coinsurer's Share char  */
                    sic_bran.uwm100.pmhead = brsic_bran.uwm100.pmhead  /*Premium Headings on Sc char  */
                    sic_bran.uwm100.usrid  = brsic_bran.uwm100.usrid   /*User Id                char  */
                    sic_bran.uwm100.entdat = brsic_bran.uwm100.entdat  /*Entered Date           date  */
                    sic_bran.uwm100.enttim = brsic_bran.uwm100.enttim  /*Entered Time           char  */
                    sic_bran.uwm100.prog   = brsic_bran.uwm100.prog    /*Program Id that input  char  */
                    sic_bran.uwm100.usridr = brsic_bran.uwm100.usridr  /*Release User Id        char  */
                    sic_bran.uwm100.reldat = brsic_bran.uwm100.reldat  /*Release Date           date  */
                    sic_bran.uwm100.reltim = brsic_bran.uwm100.reltim  /*Release Time           char  */
                    sic_bran.uwm100.polsta = brsic_bran.uwm100.polsta  /*Policy Status          char  */
                    sic_bran.uwm100.rilate = brsic_bran.uwm100.rilate  /*RI to Enter Later      logi  */
                    sic_bran.uwm100.releas = brsic_bran.uwm100.releas  /*Transaction Released   logi  */
                    sic_bran.uwm100.sch_p  = brsic_bran.uwm100.sch_p   /*Schedule Printed       logi  */
                    sic_bran.uwm100.drn_p  = brsic_bran.uwm100.drn_p   /*Dr/Cr Note Printed     logi  */
                    sic_bran.uwm100.ri_p   = brsic_bran.uwm100.ri_p    /*RI Application Printed logi  */
                    sic_bran.uwm100.cert_p = brsic_bran.uwm100.cert_p  /*Certificate Printed    logi  */
                    sic_bran.uwm100.dreg_p = brsic_bran.uwm100.dreg_p. /*Daily Prem. Reg. Print logi  */
            
                  ASSIGN
                    sic_bran.uwm100.langug = brsic_bran.uwm100.langug  /*Language               char  */
                    sic_bran.uwm100.sigr_p = brsic_bran.uwm100.sigr_p  /*SI Gross Pol. Total    deci-2*/
                    sic_bran.uwm100.sico_p = brsic_bran.uwm100.sico_p  /*SI Coinsurance Pol. To deci-2*/
                    sic_bran.uwm100.sist_p = brsic_bran.uwm100.sist_p  /*SI Statutory Pol. Tota deci-2*/
                    sic_bran.uwm100.sifa_p = brsic_bran.uwm100.sifa_p  /*SI Facultative Pol. To deci-2*/
                    sic_bran.uwm100.sity_p = brsic_bran.uwm100.sity_p  /*SI Treaty Pol. Total   deci-2*/
                    sic_bran.uwm100.siqs_p = brsic_bran.uwm100.siqs_p  /*SI Quota Share Pol. To deci-2*/
                    sic_bran.uwm100.renpol = brsic_bran.uwm100.renpol  /*Renewal Policy No.     char  */
                    sic_bran.uwm100.co_per = brsic_bran.uwm100.co_per  /*Coinsurance %          deci-2*/
                    sic_bran.uwm100.acctim = brsic_bran.uwm100.acctim  /*Acceptance Time        char  */
                    sic_bran.uwm100.agtref = brsic_bran.uwm100.agtref  /*Agents Closing Referen char  */
                    sic_bran.uwm100.sckno  = brsic_bran.uwm100.sckno   /*sticker no.            inte  */
                    sic_bran.uwm100.anam1  = brsic_bran.uwm100.anam1   /*Alternative Insured Na char  */
                    sic_bran.uwm100.sirt_p = brsic_bran.uwm100.sirt_p  /*SI RETENTION Pol. tota deci-2*/
                    sic_bran.uwm100.anam2  = brsic_bran.uwm100.anam2   /*Alternative Insured Na char  */
                    sic_bran.uwm100.gstrat = brsic_bran.uwm100.gstrat  /*GST Rate %             deci-2*/
                    sic_bran.uwm100.prem_g = brsic_bran.uwm100.prem_g  /*Premium GST            deci-2*/
                    sic_bran.uwm100.com1_g = brsic_bran.uwm100.com1_g  /*Commission 1 GST       deci-2*/
                    sic_bran.uwm100.com3_g = brsic_bran.uwm100.com3_g  /*Commission 3 GST       deci-2*/
                    sic_bran.uwm100.com4_g = brsic_bran.uwm100.com4_g  /*Commission 4 GST       deci-2*/
                    sic_bran.uwm100.gstae  = brsic_bran.uwm100.gstae   /*GST A/E                logi  */
                    sic_bran.uwm100.nr_pol = brsic_bran.uwm100.nr_pol  /*New Policy No. (Y/N)   logi  */
                    sic_bran.uwm100.issdat = brsic_bran.uwm100.issdat  /*Issue date             date  */
                    sic_bran.uwm100.cr_1   = brsic_bran.uwm100.cr_1    /*A/C 1 cash(C)/credit(R char  */
                    sic_bran.uwm100.cr_2   = brsic_bran.uwm100.cr_2    /*A/C 2 cash(C)/credit(R char  */
                    sic_bran.uwm100.cr_3   = brsic_bran.uwm100.cr_3    /*A/C 3 cash(C)/credit(R char  */
                    sic_bran.uwm100.bs_cd  = brsic_bran.uwm100.bs_cd   /*Business Source Code   char  */
                    sic_bran.uwm100.rt_er  = brsic_bran.uwm100.rt_er   /*Batch Release          logi  */
                    sic_bran.uwm100.endern = brsic_bran.uwm100.endern. /*End Date of Earned Pre date  */
                  
                  sic_bran.uwm100.releas = NO.
                  
                  ASSIGN
                    sic_bran.uwm100.bchyr    = nv_batchyr
                    sic_bran.uwm100.bchno    = nv_batchno
                    sic_bran.uwm100.bchcnt   = nv_batcnt
                    sic_bran.uwm100.impflg   = YES
                    sic_bran.uwm100.impusrid = n_user
                    sic_bran.uwm100.impdat   = TODAY
                    sic_bran.uwm100.imptim   = STRING(TIME,"HH:MM:SS").

                /*-- Policy Level Upper Text uwd100 --*/
                nv_fptr = brsic_bran.uwm100.fptr01.
                nv_bptr = 0.
                  DO WHILE nv_fptr <> 0 AND brsic_bran.uwm100.fptr01 <> ? :
                     FIND brsic_bran.uwd100 WHERE RECID(brsic_bran.uwd100) = nv_fptr
                     NO-LOCK NO-ERROR.
                         
                     IF AVAILABLE brsic_bran.uwd100 THEN DO: /*sombat */
                       nv_fptr = brsic_bran.uwd100.fptr.
                       CREATE sic_bran.uwd100.
                        ASSIGN
                         sic_bran.uwd100.bptr          = nv_bptr
                         sic_bran.uwd100.fptr          = 0
                         sic_bran.uwd100.ltext         = brsic_bran.uwd100.ltext
                         sic_bran.uwd100.policy        = brsic_bran.uwd100.policy
                         sic_bran.uwd100.rencnt        = brsic_bran.uwd100.rencnt
                         sic_bran.uwd100.endcnt        = brsic_bran.uwd100.endcnt.
                        IF nv_bptr <> 0 THEN DO:
                          FIND wf_uwd100 WHERE RECID(wf_uwd100) = nv_bptr.
                          wf_uwd100.fptr = RECID(sic_bran.uwd100).
                        END.
                        IF nv_bptr = 0 THEN  sic_bran.uwm100.fptr01 = RECID(sic_bran.uwd100).
                           nv_bptr = RECID(sic_bran.uwd100).
                     END. 
                     ELSE DO:    /*sombat*/
                       HIDE MESSAGE NO-PAUSE.
                       MESSAGE "not found " brsic_bran.uwd100.policy brsic_bran.uwd100.rencnt "/"
                                brsic_bran.uwd100.endcnt "on file uwd100".
                       putchr = "".
                       putchr = "not found "   + brsic_bran.uwd100.policy +
                                " R/E " + STRING(brsic_bran.uwd100.rencnt,"99")  +
                                "/"     + STRING(brsic_bran.uwd100.endcnt,"999") +
                                " on file uwd100 Policy Level Upper Text".
                       PUT STREAM ns1 putchr FORMAT "x(100)" SKIP.
                       LEAVE.
                     END.  /*IF AVAILABLE brsic_bran.uwd100*/
                  END.
                  sic_bran.uwm100.bptr01 = nv_bptr.

                  /*-- Policy Level Memo Text uwd102 --*/
                  nv_fptr = brsic_bran.uwm100.fptr02.
                  nv_bptr = 0.
                  DO WHILE nv_fptr <> 0 AND brsic_bran.uwm100.fptr02 <> ? :
                     FIND brsic_bran.uwd102 WHERE RECID(brsic_bran.uwd102) = nv_fptr
                     NO-LOCK NO-ERROR.
                         
                     IF AVAILABLE brsic_bran.uwd102 THEN DO: /*sombat */
                       nv_fptr = brsic_bran.uwd102.fptr.
                       CREATE sic_bran.uwd102.
                        ASSIGN
                         sic_bran.uwd102.bptr          = nv_bptr
                         sic_bran.uwd102.fptr          = 0
                         sic_bran.uwd102.ltext         = brsic_bran.uwd102.ltext
                         sic_bran.uwd102.policy        = brsic_bran.uwd102.policy
                         sic_bran.uwd102.rencnt        = brsic_bran.uwd102.rencnt
                         sic_bran.uwd102.endcnt        = brsic_bran.uwd102.endcnt.
                        IF nv_bptr <> 0 THEN DO:
                          FIND wf_uwd102 WHERE RECID(wf_uwd102) = nv_bptr.
                          wf_uwd102.fptr = RECID(sic_bran.uwd102).
                        END.
                        IF nv_bptr = 0 THEN  sic_bran.uwm100.fptr02 = RECID(sic_bran.uwd102).
                           nv_bptr = RECID(sic_bran.uwd102).
                     END. 
                     ELSE DO:    /*sombat*/
                       HIDE MESSAGE NO-PAUSE.
                       MESSAGE "not found " brsic_bran.uwd102.policy brsic_bran.uwd102.rencnt "/"
                                brsic_bran.uwd102.endcnt "on file uwd102".
                       putchr = "".
                       putchr = "not found "   + brsic_bran.uwd102.policy +
                                " R/E " + STRING(brsic_bran.uwd102.rencnt,"99")  +
                                "/"     + STRING(brsic_bran.uwd102.endcnt,"999") +
                                " on file uwd102 Policy Level Memo Text".
                       PUT STREAM ns1 putchr FORMAT "x(100)" SKIP.
                       LEAVE.
                     END.  /*IF AVAILABLE brsic_bran.uwd102*/
                  END.
                  sic_bran.uwm100.bptr02 = nv_bptr.


                  /*-- Policy Level Renewal Text uwd103 --*/
                  nv_fptr = brsic_bran.uwm100.fptr04.
                  nv_bptr = 0.
                  DO WHILE nv_fptr <> 0 AND brsic_bran.uwm100.fptr04 <> ? :
                     FIND brsic_bran.uwd103 WHERE RECID(brsic_bran.uwd103) = nv_fptr
                     NO-LOCK NO-ERROR.
                         
                     IF AVAILABLE brsic_bran.uwd103 THEN DO: /*sombat */
                       nv_fptr = brsic_bran.uwd103.fptr.
                       CREATE sic_bran.uwd103.
                        ASSIGN
                         sic_bran.uwd103.bptr          = nv_bptr
                         sic_bran.uwd103.fptr          = 0
                         sic_bran.uwd103.ltext         = brsic_bran.uwd103.ltext
                         sic_bran.uwd103.policy        = brsic_bran.uwd103.policy
                         sic_bran.uwd103.rencnt        = brsic_bran.uwd103.rencnt
                         sic_bran.uwd103.endcnt        = brsic_bran.uwd103.endcnt.
                        IF nv_bptr <> 0 THEN DO:
                          FIND wf_uwd103 WHERE RECID(wf_uwd103) = nv_bptr.
                          wf_uwd103.fptr = RECID(sic_bran.uwd103).
                        END.
                        IF nv_bptr = 0 THEN  sic_bran.uwm100.fptr04 = RECID(sic_bran.uwd103).
                           nv_bptr = RECID(sic_bran.uwd103).
                     END. 
                     ELSE DO:    /*sombat*/
                       HIDE MESSAGE NO-PAUSE.
                       MESSAGE "not found " brsic_bran.uwd103.policy brsic_bran.uwd103.rencnt "/"
                                brsic_bran.uwd103.endcnt "on file uwd103".
                       putchr = "".
                       putchr = "not found "   + brsic_bran.uwd103.policy +
                                " R/E " + STRING(brsic_bran.uwd103.rencnt,"99")  +
                                "/"     + STRING(brsic_bran.uwd103.endcnt,"999") +
                                " on file uwd103 Policy Level Renewal Text".
                       PUT STREAM ns1 putchr FORMAT "x(100)" SKIP.
                       LEAVE.
                     END.  /*IF AVAILABLE brsic_bran.uwd103*/
                  END.
                  sic_bran.uwm100.bptr04 = nv_bptr.

                  /*-- Policy Level Endorsement Text uwd104 --*/
                  nv_fptr = brsic_bran.uwm100.fptr05.
                  nv_bptr = 0.
                  DO WHILE nv_fptr <> 0 AND brsic_bran.uwm100.fptr05 <> ? :
                     FIND brsic_bran.uwd104 WHERE RECID(brsic_bran.uwd104) = nv_fptr
                     NO-LOCK NO-ERROR.
                         
                     IF AVAILABLE brsic_bran.uwd104 THEN DO: /*sombat */
                       nv_fptr = brsic_bran.uwd104.fptr.
                       CREATE sic_bran.uwd104.
                        ASSIGN
                         sic_bran.uwd104.bptr          = nv_bptr
                         sic_bran.uwd104.fptr          = 0
                         sic_bran.uwd104.ltext         = brsic_bran.uwd104.ltext
                         sic_bran.uwd104.policy        = brsic_bran.uwd104.policy
                         sic_bran.uwd104.rencnt        = brsic_bran.uwd104.rencnt
                         sic_bran.uwd104.endcnt        = brsic_bran.uwd104.endcnt.
                        IF nv_bptr <> 0 THEN DO:
                          FIND wf_uwd104 WHERE RECID(wf_uwd104) = nv_bptr.
                          wf_uwd104.fptr = RECID(sic_bran.uwd104).
                        END.
                        IF nv_bptr = 0 THEN  sic_bran.uwm100.fptr05 = RECID(sic_bran.uwd104).
                           nv_bptr = RECID(sic_bran.uwd104).
                     END. 
                     ELSE DO:    /*sombat*/
                       HIDE MESSAGE NO-PAUSE.
                       MESSAGE "not found " brsic_bran.uwd104.policy brsic_bran.uwd104.rencnt "/"
                                brsic_bran.uwd104.endcnt "on file uwd104".
                       putchr = "".
                       putchr = "not found "   + brsic_bran.uwd104.policy +
                                " R/E " + STRING(brsic_bran.uwd104.rencnt,"99")  +
                                "/"     + STRING(brsic_bran.uwd104.endcnt,"999") +
                                " on file uwd104 Policy Level Endorsement Text".
                       PUT STREAM ns1 putchr FORMAT "x(100)" SKIP.
                       LEAVE.
                     END.  /*IF AVAILABLE brsic_bran.uwd104*/
                  END.
                  sic_bran.uwm100.bptr05 = nv_bptr.

                  /*-- Policy Level Clauses uwd105 --*/
                  nv_fptr = brsic_bran.uwm100.fptr03.
                  nv_bptr = 0.
                  DO WHILE nv_fptr <> 0 AND brsic_bran.uwm100.fptr03 <> ? :
                     FIND brsic_bran.uwd105 WHERE RECID(brsic_bran.uwd105) = nv_fptr
                     NO-LOCK NO-ERROR.
                         
                     IF AVAILABLE brsic_bran.uwd105 THEN DO: /*sombat */
                       nv_fptr = brsic_bran.uwd105.fptr.
                       CREATE sic_bran.uwd105.
                        ASSIGN
                         sic_bran.uwd105.bptr          = nv_bptr
                         sic_bran.uwd105.fptr          = 0
                         sic_bran.uwd105.clause        = brsic_bran.uwd105.clause
                         sic_bran.uwd105.policy        = brsic_bran.uwd105.policy
                         sic_bran.uwd105.rencnt        = brsic_bran.uwd105.rencnt
                         sic_bran.uwd105.endcnt        = brsic_bran.uwd105.endcnt.
                        IF nv_bptr <> 0 THEN DO:
                          FIND wf_uwd105 WHERE RECID(wf_uwd105) = nv_bptr.
                          wf_uwd105.fptr = RECID(sic_bran.uwd105).
                        END.
                        IF nv_bptr = 0 THEN  sic_bran.uwm100.fptr03 = RECID(sic_bran.uwd105).
                           nv_bptr = RECID(sic_bran.uwd105).
                     END. 
                     ELSE DO:    /*sombat*/
                       HIDE MESSAGE NO-PAUSE.
                       MESSAGE "not found " brsic_bran.uwd105.policy brsic_bran.uwd105.rencnt "/"
                                brsic_bran.uwd105.endcnt "on file uwd105".
                       putchr = "".
                       putchr = "not found "   + brsic_bran.uwd105.policy +
                                " R/E " + STRING(brsic_bran.uwd105.rencnt,"99")  +
                                "/"     + STRING(brsic_bran.uwd105.endcnt,"999") +
                                " on file uwd105 Policy Level Clauses".
                       PUT STREAM ns1 putchr FORMAT "x(100)" SKIP.
                       LEAVE.
                     END.  /*IF AVAILABLE brsic_bran.uwd105*/
                  END.
                  sic_bran.uwm100.bptr03 = nv_bptr.


                  /*-- Policy Level Endorsement Clauses uwd106 --*/
                  nv_fptr = brsic_bran.uwm100.fptr06.
                  nv_bptr = 0.
                  DO WHILE nv_fptr <> 0 AND brsic_bran.uwm100.fptr06 <> ? :
                     FIND brsic_bran.uwd106 WHERE RECID(brsic_bran.uwd106) = nv_fptr
                     NO-LOCK NO-ERROR.
                         
                     IF AVAILABLE brsic_bran.uwd106 THEN DO: /*sombat */
                       nv_fptr = brsic_bran.uwd106.fptr.
                       CREATE sic_bran.uwd106.
                        ASSIGN
                         sic_bran.uwd106.bptr          = nv_bptr
                         sic_bran.uwd106.fptr          = 0
                         sic_bran.uwd106.endcls        = brsic_bran.uwd106.endcls
                         sic_bran.uwd106.policy        = brsic_bran.uwd106.policy
                         sic_bran.uwd106.rencnt        = brsic_bran.uwd106.rencnt
                         sic_bran.uwd106.endcnt        = brsic_bran.uwd106.endcnt.
                        IF nv_bptr <> 0 THEN DO:
                          FIND wf_uwd106 WHERE RECID(wf_uwd106) = nv_bptr.
                          wf_uwd106.fptr = RECID(sic_bran.uwd106).
                        END.
                        IF nv_bptr = 0 THEN  sic_bran.uwm100.fptr06 = RECID(sic_bran.uwd106).
                           nv_bptr = RECID(sic_bran.uwd106).
                     END. 
                     ELSE DO:    /*sombat*/
                       HIDE MESSAGE NO-PAUSE.
                       MESSAGE "not found " brsic_bran.uwd106.policy brsic_bran.uwd106.rencnt "/"
                                brsic_bran.uwd106.endcnt "on file uwd106".
                       putchr = "".
                       putchr = "not found "   + brsic_bran.uwd106.policy +
                                " R/E " + STRING(brsic_bran.uwd106.rencnt,"99")  +
                                "/"     + STRING(brsic_bran.uwd106.endcnt,"999") +
                                " on file uwd106 Policy Level Endorsement Clauses".
                       PUT STREAM ns1 putchr FORMAT "x(100)" SKIP.
                       LEAVE.
                     END.  /*IF AVAILABLE brsic_bran.uwd106*/
                  END.
                  sic_bran.uwm100.bptr06 = nv_bptr.



              /*------- 1) END Proc_uwm100------*/

              /*----- 2) Proc_Create -----*/
              nv_output4 = "UWM101" .
              fi_output4 = nv_output4.

              RUN wgw/wgwtb101.p (INPUT-OUTPUT sh_policy,
                                  INPUT-OUTPUT sh_rencnt,
                                  INPUT-OUTPUT sh_endcnt,
                                  INPUT-OUTPUT nv_batchyr,
                                  INPUT-OUTPUT nv_batchno,
                                  INPUT-OUTPUT nv_batcnt).

              /* Risk Group Header */
              nv_output4 = "UWM110".
              fi_output4 = nv_output4.

              RUN wgw/wgwtb110.p (INPUT-OUTPUT sh_policy,
                                  INPUT-OUTPUT sh_rencnt,
                                  INPUT-OUTPUT sh_endcnt,
                                  INPUT-OUTPUT nv_batchyr,
                                  INPUT-OUTPUT nv_batchno,
                                  INPUT-OUTPUT nv_batcnt). 

              /* Risk Header */
              nv_output4 = "UWM120".
              fi_output4 = nv_output4.

             RUN wgw/wgwtb120.p (INPUT-OUTPUT sh_policy,
                                 INPUT-OUTPUT sh_rencnt,
                                 INPUT-OUTPUT sh_endcnt,
                                 INPUT-OUTPUT nv_com1p ,
                                 INPUT-OUTPUT nv_com1_t,
                                 INPUT-OUTPUT nv_batchyr,
                                 INPUT-OUTPUT nv_batchno,
                                 INPUT-OUTPUT nv_batcnt).
                  nv_com1_sum = nv_com1_sum + nv_com1_t.


              /* Insured Item */              
              nv_output4 = "UWM130".
              fi_output4 = nv_output4.

             RUN wgw/wgwtb130.p(INPUT-OUTPUT sh_policy,
                                INPUT-OUTPUT sh_rencnt,
                                INPUT-OUTPUT sh_endcnt,
                                INPUT-OUTPUT nv_batchyr,
                                INPUT-OUTPUT nv_batchno,
                                INPUT-OUTPUT nv_batcnt).

              /* RI Out Header */
              nv_output4 = "UWM200".
              fi_output4 = nv_output4.

             RUN wgw/wgwtb200.p (INPUT-OUTPUT sh_policy,
                                 INPUT-OUTPUT sh_rencnt,
                                 INPUT-OUTPUT sh_endcnt,
                                 INPUT-OUTPUT nv_batchyr,
                                 INPUT-OUTPUT nv_batchno,
                                 INPUT-OUTPUT nv_batcnt).
                   
              /* Cargo Risk Details */
              nv_output4 = "UWM300".
              fi_output4 = nv_output4.

             RUN wgw/wgwtb300.p (INPUT-OUTPUT sh_policy,
                                 INPUT-OUTPUT sh_rencnt,
                                 INPUT-OUTPUT sh_endcnt,
                                 INPUT-OUTPUT nv_batchyr,
                                 INPUT-OUTPUT nv_batchno,
                                 INPUT-OUTPUT nv_batcnt).

              /* Motor Vehicle */
              nv_output4 = "UWM301".
              fi_output4 = nv_output4.

             RUN wgw/wgwtb301.p (INPUT-OUTPUT sh_policy,
                                 INPUT-OUTPUT sh_rencnt, 
                                 INPUT-OUTPUT sh_endcnt,
                                 INPUT-OUTPUT nv_batchyr,
                                 INPUT-OUTPUT nv_batchno,
                                 INPUT-OUTPUT nv_batcnt).

              /* Fire Risk */
              nv_output4 = "UWM304".
              fi_output4 = nv_output4.

             RUN wgw/wgwtb304.p (INPUT-OUTPUT sh_policy,
                                 INPUT-OUTPUT sh_rencnt, 
                                 INPUT-OUTPUT sh_endcnt,
                                 INPUT-OUTPUT nv_batchyr,
                                 INPUT-OUTPUT nv_batchno,
                                 INPUT-OUTPUT nv_batcnt).
        
              /* Bond Risk */
              nv_output4 = "UWM305".
              fi_output4 = nv_output4.

             RUN wgw/wgwtb305.p (INPUT-OUTPUT sh_policy,
                                 INPUT-OUTPUT sh_rencnt, 
                                 INPUT-OUTPUT sh_endcnt,
                                 INPUT-OUTPUT nv_batchyr,
                                 INPUT-OUTPUT nv_batchno,
                                 INPUT-OUTPUT nv_batcnt).

              /* Printed NCB Letted */
/*            DISPLAY fi_output4 = "uwm306"  WITH FRAME fr_main. */
              nv_output4 = "UWM306".
              fi_output4 = nv_output4.

             RUN wgw/wgwtb306.p (INPUT-OUTPUT sh_policy,
                                 INPUT-OUTPUT sh_rencnt,
                                 INPUT-OUTPUT sh_endcnt,
                                 INPUT-OUTPUT nv_batchyr,
                                 INPUT-OUTPUT nv_batchno,
                                 INPUT-OUTPUT nv_batcnt).

              /* Personal Accident */
              /*DISPLAY "uwm307" @ fi_output4 WITH FRAME fr_main.*/
              nv_output4 = "UWM307".
              fi_output4 = nv_output4.

             RUN wgw/wgwtb307.p (INPUT-OUTPUT sh_policy,
                                 INPUT-OUTPUT sh_rencnt,
                                 INPUT-OUTPUT sh_endcnt,
                                 INPUT-OUTPUT nv_batchyr,
                                 INPUT-OUTPUT nv_batchno,
                                 INPUT-OUTPUT nv_batcnt).
            
              /* Personal MAILTEXT (MAILTXT_TXT) */
              /*DISPLAY fi_output4 = "mailtxt" WITH FRAME fr_main.*/
             
              nv_output4 = "MAILTXT".
              fi_output4 = nv_output4.
       
             RUN wgw/wgwtbmai.p (INPUT-OUTPUT sh_policy,    
                                 INPUT-OUTPUT sh_rencnt,
                                 INPUT-OUTPUT sh_endcnt,
                                 INPUT-OUTPUT nv_batchyr,
                                 INPUT-OUTPUT nv_batchno,
                                 INPUT-OUTPUT nv_batcnt).
              
              /* Detaitem Table Sticker*/
              /*DISPLAY fi_output4 = "detaitem" WITH FRAME fr_main.*/
              nv_output4 = "DETAITEM".
              fi_output4 = nv_output4.
   
             RUN wgw/wgwtbdet.p (INPUT-OUTPUT sh_policy,
                                 INPUT-OUTPUT sh_rencnt,
                                 INPUT-OUTPUT sh_endcnt,
                                 INPUT-OUTPUT nv_batchyr,
                                 INPUT-OUTPUT nv_batchno,
                                 INPUT-OUTPUT nv_batcnt).

              sh_insref = brsic_bran.uwm100.acno1.
              IF TRIM(sh_insref) <> "" THEN DO:
                /*DISPLAY fi_output4 = "XMM600" WITH FRAME fr_main.*/
                 nv_output4 = "XMM600".
                 fi_output4 = nv_output4.
        
               RUN wgw/wgwtb600.p (INPUT-OUTPUT sh_insref,
                                   INPUT-OUTPUT nv_batchyr,
                                   INPUT-OUTPUT nv_batchno,
                                   INPUT-OUTPUT nv_batcnt).
              END.

              /* finint / Financial Interest Ref หรือ Code Dealer */
              sh_insref = brsic_bran.uwm100.finint.
              IF TRIM(sh_insref) <> "" THEN DO:
                /*DISPLAY fi_output4 = "Dealer Code"  WITH FRAME fr_main.*/
                  nv_output4 = "DEALER CODE".
                  fi_output4 = nv_output4.
          
                 RUN wgw/wgwtb600.p (INPUT-OUTPUT sh_insref,
                                     INPUT-OUTPUT nv_batchyr,
                                     INPUT-OUTPUT nv_batchno,
                                     INPUT-OUTPUT nv_batcnt).
              END.
              
              /* VAT100 */
              sh_insref = TRIM(brsic_bran.uwm100.policy) + " " +
                               brsic_bran.uwm100.trty11  + " " +
                               brsic_bran.uwm100.docno1.
                  nv_output4 = "VAT100".
                  fi_output4 = nv_output4.
      

              ASSIGN
                nv_policy  = sh_policy
                nv_trty11  = brsic_bran.uwm100.trty11
                nv_docno1  = brsic_bran.uwm100.docno1.  
               
             RUN wgw/wgwtbvat.p (INPUT-OUTPUT nv_policy,
                                 INPUT-OUTPUT nv_trty11,
                                 INPUT-OUTPUT nv_docno1,
                                 INPUT-OUTPUT nv_batchyr,
                                 INPUT-OUTPUT nv_batchno,
                                 INPUT-OUTPUT nv_batcnt).  
          
              /*----- 2) END Proc_Create -----*/

     END.   /*FOR EACH brsic_bran.uwm100 USE-INDEX uwm10001 :*/


