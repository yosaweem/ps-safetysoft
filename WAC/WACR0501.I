/* Modify : Kanchana C.  07/05/2003    Assign No.  :   A46-0142
    Main program :    wacr05.w
    - คำนวน รายละเอียด  ลงไฟล์   /* DISPLAY DETAIL */
 */

        ASSIGN
            nv_premCB = 0
            nv_totalCB = 0
            
            ntax% = 0
            nv_premA = 0
            nv_taxA = 0
            nv_vatA = 0
            nv_sbtA = 0
            nv_stampA = 0
            nv_totalA = 0
            nv_commA = 0
            nv_netA  = 0
            nv_retcA = 0
            nv_suspA = 0
            nv_balA = 0
            nv_balDet = 0. /* bal เลือกลง 15 ช่อง  file detail*/

            IF LOOKUP(agtprm_fil.trntyp,nv_YZ) <> 0 THEN /*บ/ช พัก*/
                ASSIGN
                    nv_suspA = agtprm_fil.bal
                    nv_balA    = agtprm_fil.bal.
            ELSE IF LOOKUP(agtprm_fil.trntyp,nv_CB) <> 0 THEN /*เช็คคืน*/
                ASSIGN
                    nv_retcA = agtprm_fil.bal
                    nv_balA  = agtprm_fil.bal.
            ELSE
                ASSIGN
                    nv_premCB = IF LOOKUP(agtprm_fil.trntyp,nv_CB) = 0 THEN agtprm_fil.prem ELSE 0 
                    nv_totalCB   = IF LOOKUP(agtprm_fil.trntyp,nv_CB) = 0 THEN agtprm_fil.gross ELSE 0 

                    nv_premA  = agtprm_fil.prem + agtprm_fil.prem_comp
                    nv_taxA      = agtprm_fil.tax
                    nv_stampA = agtprm_fil.stamp
                    nv_commA = agtprm_fil.comm + agtprm_fil.comm_comp

                    nv_totalA  = nv_premA + nv_taxA + nv_stampA   /* gross */
                    nv_netA    = nv_totalA + nv_commA

                    nv_balA   = agtprm_fil.bal.

/******** statement a4 *********/
/**/
        ASSIGN
            n_odmonth = 0   /* เดือนที่ต้องการรู้ */
            n_odDay    = 0   /* วันที่มากที่สุดในเดือน */
            n_odat        = ?.  /* วันที่ที่ครบในช่วยเดือน */
      /*------------ หาวันที่ สุดท้ายในแต่และเดือน  ลง 15 ช่อง ต้องทำเกิน 16 ช่อง ------------*/
            i = 1.
            DO i = 1  TO 16 :   /* 1 -  >16 หาวันเดือนปี เกิน 1ช่องจะได้เทียบค่าได้*/
                IF i = 1 THEN DO:                        /* ช่องแรก กำหนดวันที่เริ่มต้น  "With Credit Term, 1,Transaction Date, 2" */
                    n_odat[1]   = IF nv_RptName2 = "With Credit Term" THEN agtprm_fil.duedat
                                                                                                                         ELSE  agtprm_fil.trndat.
                END.
                ELSE DO:
                    ASSIGN
                        n_odatInday = ?
                        /* ได้วันที่ 1 เดือนถัดไป ถ้าข้ามปี ก็ จะเป็นปีถัดไปด้วย */
                        n_odatInday  = IF (MONTH(n_odat[i - 1] ) + 1 ) > 12 THEN DATE(1,1,YEAR(n_odat[i - 1] ) + 1) 
                                                                                                         ELSE DATE(MONTH(n_odat[i - 1] ) + 1,1,YEAR(n_odat[i - 1] ) )
                        n_odmonth[i] = MONTH(n_odatInday)       /* เดือนที่ต้องการรู้ */
                        n_odDay[i]    =  n_odDay[i] + fuNumMonth(n_odmonth[i], n_odatInday). /* วันที่มากที่สุดในเดือน */
                        n_odat[i]        = n_odat[i - 1] +  n_odDay[i] . /* ได้วันที่วันสุดท้ายในช่วง*/
                END.
            END. /* do i*/

            ASSIGN
                i = 1   lip = 1.
            DO i = 1  TO 15 :   /* เทียบวันเพิ่อกำหนด ช่องที่ลง  winin,duedat ,1,2,...,12+  [1] = duedate  วันที่ครบกำหนดชำระ  */
                    IF fiasdat <= (n_odat[1] - fuMaxDay(n_odat[1]) )   THEN DO:
                            lip = 1.        /* with in credit    เทียบ asdate กับ  วันทีสุดท้าย  ก่อนเดือนสุดท้าย */
                    END.
                    IF (fiasdat >   (n_odat[1] - fuMaxDay(n_odat[1]) ) ) AND  (fiasdat <= n_odat[1])  THEN DO:
                            lip = 2.        /* due amount    เทียบ asdate กับวันที่ในช่วงเดือนสุดท้าย */ 
                    END.
                    IF (fiasdat > n_odat[i]) AND (fiasdat <= n_odat[i + 1]) THEN DO:
                            lip = IF (i + 2) >= 15 THEN 15  ELSE   i + 2 .                /* over due 1 month  -  12 months */
                    END.
                    IF fiasdat >= n_odat[15] THEN lip = 15.                             /* over due + 12 months */
            END.

            /***--------หลักการคิด tax เป็น vat หรือ sbt ----------***/
            ntax% = (100 * agtprm_fil.tax) / (agtprm_fil.prem + agtprm_fil.prem_comp).
            IF ntax% > 4 THEN
                ASSIGN
                    nv_vatA = agtprm_fil.tax
                    nv_sbtA = 0.
            ELSE
                ASSIGN
                    nv_vatA = 0
                    nv_sbtA = agtprm_fil.tax.
            /***--------------  Summary Value  ------------***/
            ASSIGN
                /* 15 ช่อง */
                nv_Tprem[lip]    = nv_Tprem  [lip]   + nv_premA
                nv_Ttax[lip]        = nv_Ttax   [lip]     + nv_taxA
                    nv_Tvat[lip]       = nv_Tvat [lip]  + nv_vatA
                    nv_Tsbt [lip]      = nv_Tsbt [lip]  + nv_sbtA
                nv_Tstamp[lip]  = nv_Tstamp[lip] + nv_stampA
                nv_Ttotal[lip]     = nv_Ttotal[lip]   + nv_totalA
                nv_Tcomm[lip]  = nv_Tcomm[lip] + nv_commA
                nv_Tnet[lip]       = nv_Tnet[lip]    + nv_netA
                nv_Tretc[lip]    = nv_Tretc[lip] + nv_retcA
                nv_Tsusp[lip]  = nv_Tsusp[lip] + nv_suspA
                nv_Tnetar[lip]  = nv_Tnetar[lip]  + (nv_netA + nv_retcA + nv_suspA)   /* Net  A/R*/
                nv_Tbal[lip]      = nv_Tbal[lip]     +  nv_balA                                                   /* Bal O/S */

                /*ผลรวม 15 ช่อง*/
                nv_TTprem    = nv_TTprem     + nv_premA     /* column Total SUMMARY */
                nv_TTtax        = nv_TTtax        + nv_taxA
                    nv_TTvat       = nv_TTvat  + nv_vatA
                    nv_TTsbt       = nv_TTsbt  + nv_sbtA
                nv_TTstamp = nv_TTstamp + nv_stampA
                nv_TTtotal    = nv_TTtotal   + nv_TotalA
                nv_TTcomm = nv_TTcomm + nv_commA
                nv_TTnet      = nv_TTnet    + nv_netA
                nv_TTretc    = nv_TTretc   + nv_retcA
                nv_TTsusp  = nv_TTsusp + nv_suspA

                nv_TTnetar = nv_TTnetar +  (nv_netA + nv_retcA + nv_suspA )
                nv_TTbal     = nv_TTbal    +   nv_balA.

                nv_balDet[lip] =  nv_balA. /* รวม bal ลง 15 ช่อง */

        /********************** DETAIL *********************/
        ASSIGN
            nv_net = 0
            nv_net = (nv_totalCB  +  agtprm_fil.comm + agtprm_fil.comm_comp).

        OUTPUT TO VALUE (STRING(n_OutputFile ) ) APPEND NO-ECHO.
            EXPORT DELIMITER ";"
                agtprm_fil.acno
                agtprm_fil.ac_name
                "'" + agtprm_fil.polbran
                agtprm_fil.credit
                agtprm_fil.trndat
                agtprm_fil.duedat
                agtprm_fil.trntyp + " " +  agtprm_fil.docno
                agtprm_fil.policy
                agtprm_fil.endno
                agtprm_fil.comdat
                /*agtprm_fil.insure*/
                nv_premCB                /*agtprm_fil.prem*//* ข้อมูล เช็คคืน premium มีค่า แต่ไม่ต้องการคิดเป็นค่า premium*/   
                agtprm_fil.prem_comp
                agtprm_fil.stamp
                agtprm_fil.tax
                nv_totalCB                  /*agtprm_fil.gross*/
                agtprm_fil.comm
                agtprm_fil.comm_comp
                nv_net
                agtprm_fil.bal
                /* 15 ช่อง */
                nv_balDet[1 FOR 15]. /* detail */   /* n_wcr n_damt n_odue n_odue1 n_odue2 n_odue3 n_odue4 n_odue5 */
        OUTPUT CLOSE.

        ASSIGN
        /* TOTAL  ผลรวมใน group    DISPLAY DETAIL*/
            nv_tot_prem             = nv_tot_prem + nv_premCB  /*agtprm_fil.prem*/
            nv_tot_prem_comp =  nv_tot_prem_comp + agtprm_fil.prem_comp
            nv_tot_stamp     = nv_tot_stamp + agtprm_fil.stamp
            nv_tot_tax          = nv_tot_tax + agtprm_fil.tax
            nv_tot_gross     = nv_tot_gross + nv_totalCB    /*agtprm_fil.gross*/
            nv_tot_comm     = nv_tot_comm +  agtprm_fil.comm
            nv_tot_comm_comp =  nv_tot_comm_comp + agtprm_fil.comm_comp
            nv_tot_net                = nv_tot_net + nv_net
            nv_tot_bal                = nv_tot_bal + agtprm_fil.bal

            nv_tot_balDet[lip] = nv_tot_balDet[lip] + nv_balA.



/*            ASSIGN
 *             i = 1   lip = 1.
 *             DO i = 1  TO 15 :   /* เทียบวันเพิ่อกำหนด ช่องที่ลง  current ,1,2,...,12+  */
 *                     IF fiasdat < n_odat[1]   THEN lip = 1.
 *                     IF fiasdat = n_odat[2]   THEN lip = 2.
 *                     IF fiasdat > n_odat[i] AND fiasdat <= n_odat[i + 1] THEN lip = i + 1.
 *                     IF fiasdat >= n_odat[15] THEN lip = 15.
 *             END.*/
