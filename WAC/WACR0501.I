/* Modify : Kanchana C.  07/05/2003    Assign No.  :   A46-0142
    Main program :    wacr05.w
    - �ӹǹ ��������´  ŧ���   /* DISPLAY DETAIL */
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
            nv_balDet = 0. /* bal ���͡ŧ 15 ��ͧ  file detail*/

            IF LOOKUP(agtprm_fil.trntyp,nv_YZ) <> 0 THEN /*�/� �ѡ*/
                ASSIGN
                    nv_suspA = agtprm_fil.bal
                    nv_balA    = agtprm_fil.bal.
            ELSE IF LOOKUP(agtprm_fil.trntyp,nv_CB) <> 0 THEN /*�礤׹*/
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
            n_odmonth = 0   /* ��͹����ͧ������ */
            n_odDay    = 0   /* �ѹ����ҡ����ش���͹ */
            n_odat        = ?.  /* �ѹ�����ú㹪�����͹ */
      /*------------ ���ѹ��� �ش������������͹  ŧ 15 ��ͧ ��ͧ���Թ 16 ��ͧ ------------*/
            i = 1.
            DO i = 1  TO 16 :   /* 1 -  >16 ���ѹ��͹�� �Թ 1��ͧ������º�����*/
                IF i = 1 THEN DO:                        /* ��ͧ�á ��˹��ѹ����������  "With Credit Term, 1,Transaction Date, 2" */
                    n_odat[1]   = IF nv_RptName2 = "With Credit Term" THEN agtprm_fil.duedat
                                                                                                                         ELSE  agtprm_fil.trndat.
                END.
                ELSE DO:
                    ASSIGN
                        n_odatInday = ?
                        /* ���ѹ��� 1 ��͹�Ѵ� ��Ң����� �� ���繻նѴ仴��� */
                        n_odatInday  = IF (MONTH(n_odat[i - 1] ) + 1 ) > 12 THEN DATE(1,1,YEAR(n_odat[i - 1] ) + 1) 
                                                                                                         ELSE DATE(MONTH(n_odat[i - 1] ) + 1,1,YEAR(n_odat[i - 1] ) )
                        n_odmonth[i] = MONTH(n_odatInday)       /* ��͹����ͧ������ */
                        n_odDay[i]    =  n_odDay[i] + fuNumMonth(n_odmonth[i], n_odatInday). /* �ѹ����ҡ����ش���͹ */
                        n_odat[i]        = n_odat[i - 1] +  n_odDay[i] . /* ���ѹ����ѹ�ش����㹪�ǧ*/
                END.
            END. /* do i*/

            ASSIGN
                i = 1   lip = 1.
            DO i = 1  TO 15 :   /* ��º�ѹ���͡�˹� ��ͧ���ŧ  winin,duedat ,1,2,...,12+  [1] = duedate  �ѹ���ú��˹�����  */
                    IF fiasdat <= (n_odat[1] - fuMaxDay(n_odat[1]) )   THEN DO:
                            lip = 1.        /* with in credit    ��º asdate �Ѻ  �ѹ���ش����  ��͹��͹�ش���� */
                    END.
                    IF (fiasdat >   (n_odat[1] - fuMaxDay(n_odat[1]) ) ) AND  (fiasdat <= n_odat[1])  THEN DO:
                            lip = 2.        /* due amount    ��º asdate �Ѻ�ѹ���㹪�ǧ��͹�ش���� */ 
                    END.
                    IF (fiasdat > n_odat[i]) AND (fiasdat <= n_odat[i + 1]) THEN DO:
                            lip = IF (i + 2) >= 15 THEN 15  ELSE   i + 2 .                /* over due 1 month  -  12 months */
                    END.
                    IF fiasdat >= n_odat[15] THEN lip = 15.                             /* over due + 12 months */
            END.

            /***--------��ѡ��äԴ tax �� vat ���� sbt ----------***/
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
                /* 15 ��ͧ */
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

                /*����� 15 ��ͧ*/
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

                nv_balDet[lip] =  nv_balA. /* ��� bal ŧ 15 ��ͧ */

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
                nv_premCB                /*agtprm_fil.prem*//* ������ �礤׹ premium �դ�� ������ͧ��äԴ�繤�� premium*/   
                agtprm_fil.prem_comp
                agtprm_fil.stamp
                agtprm_fil.tax
                nv_totalCB                  /*agtprm_fil.gross*/
                agtprm_fil.comm
                agtprm_fil.comm_comp
                nv_net
                agtprm_fil.bal
                /* 15 ��ͧ */
                nv_balDet[1 FOR 15]. /* detail */   /* n_wcr n_damt n_odue n_odue1 n_odue2 n_odue3 n_odue4 n_odue5 */
        OUTPUT CLOSE.

        ASSIGN
        /* TOTAL  ������ group    DISPLAY DETAIL*/
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
 *             DO i = 1  TO 15 :   /* ��º�ѹ���͡�˹� ��ͧ���ŧ  current ,1,2,...,12+  */
 *                     IF fiasdat < n_odat[1]   THEN lip = 1.
 *                     IF fiasdat = n_odat[2]   THEN lip = 2.
 *                     IF fiasdat > n_odat[i] AND fiasdat <= n_odat[i + 1] THEN lip = i + 1.
 *                     IF fiasdat >= n_odat[15] THEN lip = 15.
 *             END.*/
