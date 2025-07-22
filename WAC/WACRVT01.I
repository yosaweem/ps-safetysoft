/************************************ 
/* Create  By : Nattanicha K       Assign No.  :   A61-0427  */
    Program     : wacrvt01.i 
    Main program :    wacrlivt.w
***************************************/
DEF VAR ladat   AS DATE FORMAT "99/99/9999". 
DEF VAR  qdat   AS INTE.
 
            ASSIGN
                nv_premCB   = 0
                nv_commCB   = 0
                nv_totalCB  = 0
                
                ntax%       = 0
                nv_taxA     = 0
                nv_stampA   = 0
                
                nv_premA    = 0
                nv_commA    = 0
                nv_balA     = 0

                nv_retcA    = 0
                nv_suspA    = 0
                nv_netarA   = 0
                nv_netothA  = 0

                nv_balDet   = 0   /* bal เลือกลง 15 ช่อง  file detail*/
                nv_prem1    = 0
                nv_stamp1   = 0
                nv_vat1     = 0.

        
            ASSIGN 
                nv_premA    = agtprm_fil.prem + agtprm_fil.prem_comp
                nv_taxA     = agtprm_fil.tax
                nv_stampA   = agtprm_fil.stamp
                
                nv_commA    = agtprm_fil.comm + agtprm_fil.comm_comp
                nv_totalA   = nv_premA + nv_taxA + nv_stampA   /* gross */

                nv_netA     = nv_totalA + nv_commA       /*   prem + tax + stamp + comm */
                nv_balA     = agtprm_fil.bal.

                IF nv_balA = nv_commA THEN 
                   ASSIGN nv_prem1   = 0
                          nv_stamp1  = 0
                          nv_vat1    = 0.
                ELSE DO:
                   IF  nv_balA = 0 THEN 
                       ASSIGN nv_prem1   = 0
                              nv_stamp1  = 0
                              nv_vat1    = 0.
                   ELSE ASSIGN nv_prem1    = agtprm_fil.prem + agtprm_fil.prem_comp
                               nv_stamp1   = agtprm_fil.stamp
                               nv_vat1     = agtprm_fil.tax.
                END.

            IF LOOKUP(agtprm_fil.trntyp,nv_CB) = 0 AND  LOOKUP(agtprm_fil.trntyp,nv_yz) = 0 THEN 
                ASSIGN
                    nv_premCB   = (agtprm_fil.prem + agtprm_fil.prem_comp) + agtprm_fil.tax + agtprm_fil.stamp
                    nv_commCB   = (agtprm_fil.comm + agtprm_fil.comm_comp)
                    nv_totalCB  =  agtprm_fil.gross .

                ASSIGN
                  nv_sumprm  = 0
                  nv_sumcom  = 0
                  nv_sumsup  = 0
      
                  nv_prm     = 0
                  nv_com     = 0
                  nv_sup     = 0
                  nv_spcp    = 0
      
                  nv_pprm    = 0
                  nv_stamp   = 0
                  nv_tax     = 0
                  
                  n_trnty1 = ""
                  n_trnty2 = ""
                  
                  n_trnty1 = SUBSTRING(agtprm_fil.trntyp,1,1)
                  n_trnty2 = SUBSTRING(agtprm_fil.trntyp,2,1)
                  .
                /**/
                DEF VAR n_sumpremM AS DECI FORMAT ">>>,>>>,>>9.99-" .
                DEF VAR n_sumcommM AS DECI FORMAT ">>>,>>>,>>9.99-" .

                DEF VAR n_sumpremR AS DECI FORMAT ">>>,>>>,>>9.99-" .
                DEF VAR n_sumcommR AS DECI FORMAT ">>>,>>>,>>9.99-" .

                ASSIGN
                    n_sumpremM = 0
                    n_sumcommM = 0
                    n_sumpremR = 0
                    n_sumcommR = 0.
                /**/

/* insert */
          /*note add exp dat*/
            DEF  VAR NO_expdat AS DATE FORMAT "99/99/9999".
            FIND LAST uwm100 WHERE uwm100.policy = agtprm_fil.policy
            NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL uwm100  THEN DO:
                no_expdat = uwm100.expdat. 
            END.
            ELSE DO:
                NO_expdat = ?.
            END.
            
          /*end note expdat*/
          /*-------------------  FOR EACH Acd001  ---------------------*//* หา nv_sumprm, nv_sumcom, nv_sumsup */
            FOR EACH Acd001 USE-INDEX Acd00191
                WHERE Acd001.TrnTy1 = n_trnty1
                AND   Acd001.docno  = agtprm_fil.docno
                NO-LOCK :
            
                    IF (Acd001.cjodat > n_asdat )  AND  (Acd001.entdat <= n_processdate)  THEN DO:   

                       FIND FIRST Acm002 WHERE Acm002.TrnTy1 = Acd001.ctrty1 AND
                                              Acm002.docno  = Acd001.cdocno
                                          NO-LOCK NO-ERROR.
                       ASSIGN 
                         n_trnty2  = IF AVAIL Acm002 THEN Acm002.TrnTy2 ELSE " "
                         nv_netamt = IF Acd001.netamt < 0 THEN Acd001.netamt * -1
                                     ELSE Acd001.netamt.                            
                      
                            IF n_trnty2 = "p" THEN nv_sumprm = nv_sumprm + nv_netamt.
                       ELSE IF n_trnty2 = "c" THEN nv_sumcom = nv_sumcom + nv_netamt.
                       ELSE IF n_trnty2 = "s" THEN nv_sumsup = nv_sumsup + nv_netamt.
                      
                    END. /*---  IF Acd001.cjodat > n_asdat ---*/

                IF (Acd001.cjodat <= n_asdat ) AND  (Acd001.entdat <= n_processdate)  THEN DO: /* ทุกรายที่ทำการ match จนถึง process date */

                    IF acd001.trnty1 = "M" OR n_trnty1 =  "O" THEN DO:
                    
                        IF acd001.netamt < 0 THEN  /* แสดงว่า ตัด เบี้ย +  */
                            n_sumpremM = n_sumpremM + acd001.netamt.    /* รายการที่นำมาตัด  ติด */
                        ELSE
                            n_sumcommM = n_sumcommM + acd001.netamt.

                    END.

                    IF acd001.trnty1 = "R" OR n_trnty1 =  "T" THEN DO:

                        IF acd001.netamt > 0 THEN  /* แสดงว่า ตัด เบี้ย -  */
                            n_sumpremR = n_sumpremR + acd001.netamt.
                        ELSE
                            n_sumcommR = n_sumcommR + acd001.netamt.

                    END.

                END.

                ASSIGN
                  n_trnty2  = " "
                  nv_netamt = 0.
            END. /*---  FOR EACH Acd001  ---*/


          /***------------------------- รับชำระเงิน ------------------------***/
          IF   n_trnty1 = "M" OR n_trnty1 =  "O"  THEN DO:   /*  or  acm001.trnty1  =  "O" */              

             /*--- ยังไม่มีการรับเงินรายการใด ๆ ---*/
             IF nv_netA = agtprm_fil.bal THEN  /* P */  /* acm001.netamt  = nv_netA  */
                ASSIGN
                  nv_prm   = (agtprm_fil.prem + agtprm_fil.prem_comp) + agtprm_fil.tax + agtprm_fil.stamp
                  nv_com   = (agtprm_fil.comm + agtprm_fil.comm_comp)

                  nv_pprm  = (agtprm_fil.prem + agtprm_fil.prem_comp)  /* Net Premium Befor TAX, Stamp */
                  nv_stamp = agtprm_fil.stamp /* Stamp */
                  nv_tax   = agtprm_fil.tax.   /* TAX   */
            
             IF (nv_netA <> agtprm_fil.bal) THEN DO:  /* P */  
                  ASSIGN 
                    nv_prm = nv_totalA + n_sumpremM
                    nv_com = nv_commA  + n_sumcommM
                    nv_pprm     = 0
                    nv_stamp    = 0
                    nv_tax      = 0 .
             END.

          END.  /*---  SUBSTRING(agtprm_fil.trntyp,1,1)= M, A, O  ---*/

          /*---  คืนเบี้ย / Prem.,TAX,Stamp ติดลบ / Comm. เป็นบวก -----*/
          IF n_trnty1 = "R" OR  n_trnty1 =  "T"   /*  or  acm001.trnty1  =  "T" */
             THEN DO:

             /*---  ยังไม่มีการทำรายการตัดจ่าย ----*/
             IF nv_netA = agtprm_fil.bal THEN  /* P */  /*Acm001.netamt */
                ASSIGN
                  nv_prm   = (agtprm_fil.prem + agtprm_fil.prem_comp) + agtprm_fil.tax + agtprm_fil.stamp

                  nv_pprm  = (agtprm_fil.prem + agtprm_fil.prem_comp)  /* Net Premium Befor TAX, Stamp */
                  nv_stamp = agtprm_fil.stamp /* Stamp */
                  nv_tax   = agtprm_fil.tax   /* TAX   */

                  nv_com = (agtprm_fil.comm + agtprm_fil.comm_comp).

             IF (nv_netA <> agtprm_fil.bal) THEN DO: /* P */  
                  ASSIGN 
                    nv_prm = nv_totalA + n_sumpremR
                    nv_com = nv_commA  + n_sumcommR
                    nv_pprm     = 0
                    nv_stamp    = 0
                    nv_tax      = 0 .
             END.                    

          END.  /*---  IF SUBSTRING(agtprm_fil.trntyp,1,1)= R, B, T ---*/

          /***-----------------------     รับเงิน  -------------------------***/
          IF n_trnty1 = "Y" THEN DO:
                  IF n_trnty2   = "p" THEN  nv_prm = agtprm_fil.bal + (nv_sumprm * -1).
             ELSE IF n_trnty2   = "c" THEN  nv_com = agtprm_fil.bal + (nv_sumcom * -1).
             ELSE IF n_trnty2    = "s" THEN  nv_sup = agtprm_fil.bal + (nv_sumsup * -1).
          END. /*---  SUBSTRING(agtprm_fil.trntyp,1,1)= "Y"  ---*/

          /***-----------------------     จ่ายเงิน  ------------------------***/
          IF n_trnty1= "Z" THEN DO:
                  IF n_trnty2= "p" THEN nv_prm = agtprm_fil.bal + (nv_sumprm).
             ELSE IF n_trnty2 = "c" THEN nv_com = agtprm_fil.bal + (nv_sumcom).
             ELSE IF n_trnty2 = "s" THEN nv_sup = agtprm_fil.bal + (nv_sumsup).
          END. /*---  SUBSTRING(agtprm_fil.trntyp,1,1)= "Z"  ---*/

          /*----------------   ยอดเช็คคืน    ---------------*/
          IF n_trnty1= "C" THEN DO:
                  IF n_trnty2 = "p" THEN nv_prm = agtprm_fil.bal + (nv_sumprm).
             ELSE IF n_trnty2 = "c" THEN nv_com = agtprm_fil.bal + (nv_sumcom).
             ELSE IF n_trnty2 = "s" THEN nv_sup = agtprm_fil.bal + (nv_sumsup).
          END. /*---  SUBSTRING(agtprm_fil.trntyp,1,1)= "C"  ---*/

          /*---  RV = net and after as at  ---*/
          IF nv_netA = nv_prm AND /*Acm001.netamt */
             nv_com  = 0      AND 
             nv_sup  = 0      THEN  ASSIGN nv_prm = (agtprm_fil.prem + agtprm_fil.prem_comp) + agtprm_fil.tax + agtprm_fil.stamp
                                           nv_com = (agtprm_fil.comm + agtprm_fil.comm_comp).
          /*---  Acm001.netamt  ---*/

/* ได้ค่ะ ครบแล้ว  เตรียม  export data */
            IF LOOKUP(agtprm_fil.trntyp,nv_YZ) <> 0 THEN /*บ/ช พัก  (YS, ZS) */
                ASSIGN
                    nv_premCB   = 0 
                    nv_commCB   = 0
                                
                    nv_premA    = nv_premCB
                    nv_commA    = nv_commCB
                    nv_balA     = 0
                                
                    nv_retcA    = 0
                    nv_suspA    = agtprm_fil.bal
                    nv_netarA   = nv_suspA
                    nv_netothA  = 0
                    .
            ELSE IF LOOKUP(agtprm_fil.trntyp,nv_CB) <> 0 THEN /*เช็คคืน    (C,B)  */
                ASSIGN
                    nv_premCB   = 0
                    nv_commCB   = 0
                                
                    nv_premA    = nv_premCB
                    nv_commA    = nv_commCB
                    nv_balA     = 0
                                
                    nv_retcA    = agtprm_fil.bal
                    nv_suspA    = 0
                    nv_netarA   = nv_retcA
                    nv_netothA  = 0
                    .
            ELSE IF  LOOKUP(n_trnty1,nv_MR) <> 0 THEN /* ก/ธ  เบี้ย , comm    (M,R)  */
                ASSIGN
                    nv_premCB   = nv_prm
                    nv_commCB   = nv_com
                                
                    nv_premA    = nv_premCB  /*1*/
                    nv_taxA     = nv_tax     /* ยังไม่ใช้ */
                    nv_stampA   = nv_stamp   /* ยังไม่ใช้ */
                    nv_commA    = nv_commCB  /*2*/
                    nv_balA     = nv_premA  + nv_commA        /*+ nv_taxA + nv_stampA  */ 

                    nv_retcA    = 0
                    nv_suspA    = 0
                    nv_netarA   = nv_balA
                    nv_netothA  = 0
               .
            ELSE        /* type อื่น ๆ เช่น YP,  ZP, ZX    A */
                ASSIGN
                    nv_premA    = 0
                    nv_commA    = 0
                    nv_balA     = 0

                    nv_retcA    = 0
                    nv_suspA    = 0
                    nv_netarA   = 0
                    nv_netothA  = agtprm_fil.bal.

            ASSIGN
                ladat = ?
                qdat  = 0
                lip   = 1.

            IF nv_RptName2 = "With Credit Term" THEN
                ladat   = IF  LOOKUP(n_trnty1,nv_MR) <> 0 THEN agtprm_fil.duedat   ELSE agtprm_fil.trndat.  /* เฉพาะ type MR เท่านั้นที่ต้องคิด duedate  */
            ELSE
                ladat   = agtprm_fil.trndat.

            /***---  change asdate process to be  asdate for cal. ---***/
            IF n_asdat > ladat THEN DO:  
                qdat = n_asdat - ladat.  
                
                IF qdat > 365       THEN  lip = 13.
                ELSE IF qdat > 330  THEN  lip = 12.
                ELSE IF qdat > 300  THEN  lip = 11.
                ELSE IF qdat > 270  THEN  lip = 10.
                ELSE IF qdat > 240  THEN  lip =  9.
                ELSE IF qdat > 210  THEN  lip =  8.
                ELSE IF qdat > 180  THEN  lip =  7.
                ELSE IF qdat > 150  THEN  lip =  6.
                ELSE IF qdat > 120  THEN  lip =  5.
                ELSE IF qdat > 90   THEN  lip =  4.
                ELSE IF qdat > 60   THEN  lip =  3.
                ELSE IF qdat > 30   THEN  lip =  2.
                ELSE lip = 1. 

            END.
            
            /***--------หลักการคิด tax เป็น vat หรือ sbt ----------***/
            ntax% = (100 * agtprm_fil.tax) / (agtprm_fil.prem + agtprm_fil.prem_comp).
            IF ntax% > 4 THEN
                ASSIGN
                    nv_vatA = nv_taxA  /* agtprm_fil.tax */
                    nv_sbtA = 0.
            ELSE
                ASSIGN
                    nv_vatA = 0
                    nv_sbtA = nv_taxA.   /* agtprm_fil.tax */

            /***--------------  Summary Value  ------------***/
            ASSIGN
                /* 4 ช่อง */
                nv_Tprem[lip]    = nv_Tprem[lip] + nv_premA   /*1*/
                nv_Tcomm[lip]    = nv_Tcomm[lip]   + nv_commA   /*2*/
                nv_Tbal[lip]     = nv_Tbal[lip]    + nv_balA   /* Bal O/S */   /*3  = 1 + 2*/
                nv_Tretc[lip]    = nv_Tretc[lip]   + nv_retcA   /*4*/
                nv_Tsusp[lip]    = nv_Tsusp[lip]   + nv_suspA   /*5*/
                nv_Tnetar[lip]   = nv_Tnetar[lip]  + nv_netarA  /*6  =  3 +  4 + 5  */ 
                nv_Tnetoth[lip]  = nv_Tnetoth[lip] + nv_netothA /*7    นอกเหนือจาก  6   */ 
                nv_balDet[lip]   = nv_premA  /* Net A/R By Prem*/
                nv_Tprem1[lip]   = nv_Tprem1[lip] + nv_prem1 
                nv_Tstamp1[lip]  = nv_Tstamp1[lip] + nv_stamp1 
                nv_Tvat1[lip]    = nv_Tvat1[lip] + nv_vat1 

                /*ผลรวม 4 ช่อง*/
                 nv_TTprem    = nv_TTprem   + nv_premA        /* column Total SUMMARY */
                 nv_TTcomm    = nv_TTcomm   + nv_commA
                 nv_TTbal     = nv_TTbal    + nv_balA
                 nv_TTretc    = nv_TTretc   + nv_retcA
                 nv_TTsusp    = nv_TTsusp   + nv_suspA
                 nv_TTnetar   = nv_TTnetar  + nv_netarA
                 nv_TTnetoth  = nv_TTnetoth + nv_netothA
                 nv_TTprem1   = nv_TTprem1  + nv_prem1
                 nv_TTstamp1  = nv_TTstamp1 + nv_stamp1
                 nv_TTvat1    = nv_TTvat1   + nv_vat1.
                
            ASSIGN      /* detail */
                nv_tot_prem   = nv_tot_prem + nv_premA
                nv_tot_comm   = nv_tot_comm + nv_commA
                nv_tot_bal    = nv_tot_bal  + nv_balA
                nv_tot_retc   = nv_tot_retc  + nv_retcA
                nv_tot_susp   = nv_tot_susp  + nv_suspA
                nv_tot_netar  = nv_tot_netar + nv_netarA
                nv_tot_netoth = nv_tot_netoth + nv_netothA
                nv_tot_balDet[lip] = nv_tot_balDet[lip] + nv_premA  
                nv_tot_prem1  = nv_tot_prem1 + nv_prem1
                nv_tot_stamp1 = nv_tot_stamp1 + nv_stamp1
                nv_tot_vat1   = nv_tot_vat1 + nv_vat1.

        /********************** DETAIL *********************/
/*--- DISPLAY DETAIL  ---*/
    IF (nv_DetSum = "Detail")  OR (nv_DetSum = "All") THEN DO:
           
        IF nv_RptName = "Line" THEN DO: 

            nv_acname = "".
            FIND  xmm600 USE-INDEX xmm60001 
                         WHERE xmm600.acno = agtprm_fil.agent NO-LOCK NO-ERROR.
            IF AVAIL xmm600 THEN nv_acname = TRIM(xmm600.ntitle) + " " + TRIM(xmm600.name).
                            ELSE nv_acname = agtprm_fil.ac_name.

            OUTPUT TO VALUE (STRING(n_OutputFile ) ) APPEND NO-ECHO.
            EXPORT DELIMITER ";"
                agtprm_fil.agent
                nv_acname          
                "'" + agtprm_fil.polbran
                agtprm_fil.credit
                agtprm_fil.trndat
                ladat              
                agtprm_fil.trntyp + " " +  agtprm_fil.docno
                agtprm_fil.policy
                agtprm_fil.endno
                agtprm_fil.comdat
                NO_expdat
                nv_invdat
                nv_invsts
                nv_invoice
                nv_prem1
                nv_stamp1
                nv_vat1
                nv_premA
                nv_commA
                nv_balA
                nv_retcA
                nv_suspA
                nv_netarA
                nv_netothA
                /* 15 ช่อง */
                nv_balDet[1 FOR 13].
            OUTPUT CLOSE.
        END.
        ELSE DO:
            OUTPUT TO VALUE (STRING(n_OutputFile)) APPEND NO-ECHO.
                EXPORT DELIMITER ";"
                    agtprm_fil.acno
                    agtprm_fil.ac_name
                    "'" + agtprm_fil.polbran
                    agtprm_fil.credit
                    agtprm_fil.trndat
                    ladat               
                    agtprm_fil.trntyp + " " +  agtprm_fil.docno
                    agtprm_fil.policy
                    agtprm_fil.endno
                    agtprm_fil.comdat
                    NO_expdat
                    nv_invdat  
                    nv_invsts
                    nv_invoice 
                    nv_prem1   
                    nv_stamp1  
                    nv_vat1    
                    nv_premA
                    nv_commA
                    nv_balA
                    nv_retcA
                    nv_suspA
                    nv_netarA
                    nv_netothA
                    /* 15 ช่อง */
                    nv_balDet[1 FOR 13].
            OUTPUT CLOSE.

        END.

    END.    /* (nv_DetSum = "Detail")  OR (nv_DetSum = "All") */


