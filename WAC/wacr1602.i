/************************************ 
    Create By : Kanchana C.      Assign No.  :   A46-0079  23/02/2004
    Program     : wacr1602.i 
    Main program :    wacr06.w
    
    - DISPLAY SUMMARY FILE & SUMMARY GRAND TOTAL
***************************************/

/*--- DISPLAY DETAIL  ---*/
    IF (nv_DetSum = "Detail")  OR (nv_DetSum = "All") THEN DO:

        /* A47-0264 */
            {wac\wacr0604.i}
        /* end A47-0264 */

        OUTPUT TO VALUE (STRING(n_OutputFile ) ) APPEND NO-ECHO.  /* DISPLAY DETAIL */
          EXPORT DELIMITER ";"
              "TOTAL : " + nv_RptTyp1 + " - " + nv_RptTyp2
              nv_blankH[1 FOR 10] /*10*/
        
                nv_tot_prem
                nv_tot_comm
                nv_tot_bal
                
                nv_tot_retc
                nv_tot_susp
                nv_tot_netar
                nv_tot_netoth
                
              /* 15 ��ͧ */
              nv_tot_balDet[1 FOR 15].   /* total group *//*EXPORT DELIMITER ";" "".*/
          
        OUTPUT CLOSE.
    END.  /*    (nv_DetSum = "Detail")  OR (nv_DetSum = "All") */

 /*** DISPLAY SUMMARY FILE & SUMMARY GRAND TOTAL***/

    IF (nv_DetSum = "Summary")  OR (nv_DetSum = "All") THEN DO:
        OUTPUT TO VALUE (n_OutputFileSum) APPEND NO-ECHO.  /* DISPLAY SUMMARY */
          EXPORT DELIMITER ";"  "".
          EXPORT DELIMITER ";"  "Summary of : " + nv_RptName + " " + nv_RptTyp1 + " - " + nv_RptTyp2.
/*---
              EXPORT DELIMITER ";"  nv_RptName + " Premium"          nv_TTprem   nv_Tprem[1 FOR 15]. 
              EXPORT DELIMITER ";"  nv_RptName + " Tax"                   nv_TTtax      nv_Ttax[1 FOR 15].
              EXPORT DELIMITER ";"  "  - " + nv_RptName + " [VAT]"    nv_TTvat      nv_Tvat[1 FOR 15]. /* FILL(" ",LENGTH(nv_RptName)) */
              EXPORT DELIMITER ";"  "  - " + nv_RptName + " [SBT]"    nv_TTsbt      nv_Tsbt[1 FOR 15].
              EXPORT DELIMITER ";"  nv_RptName + " Stamp"               nv_TTstamp nv_Tstamp[1 FOR 15].
              EXPORT DELIMITER ";"  nv_RptName + " Total Premium" nv_TTtotal    nv_Ttotal[1 FOR 15].
              EXPORT DELIMITER ";"  nv_RptName + " Commission"     nv_TTcomm nv_Tcomm[1 FOR 15].
              EXPORT DELIMITER ";"  nv_RptName + " Net Premium"   nv_TTnet       nv_Tnet[1 FOR 15].
              EXPORT DELIMITER ";"  nv_RptName + " Cheque Returned" nv_TTretc    nv_Tretc[1 FOR 15].
              EXPORT DELIMITER ";"  nv_RptName + " Suspense"       nv_TTsusp    nv_Tsusp[1 FOR 15].
              EXPORT DELIMITER ";"  nv_RptName + " Net. A/R"          nv_TTnetar    nv_Tnetar[1 FOR 15].
              EXPORT DELIMITER ";"  nv_RptName + " Bal. O/S"           nv_TTbal        nv_Tbal[1 FOR 15].
---*/

          EXPORT DELIMITER ";"  nv_RptName + " Premium"         nv_TTprem   nv_Tprem[1 FOR 15]. 
          EXPORT DELIMITER ";"  nv_RptName + " Commission"      nv_TTcomm   nv_Tcomm[1 FOR 15].
          EXPORT DELIMITER ";"  nv_RptName + " Bal. O/S"        nv_TTbal    nv_Tbal[1 FOR 15].
          EXPORT DELIMITER ";"  nv_RptName + " Cheque Returned" nv_TTretc   nv_Tretc[1 FOR 15].
          EXPORT DELIMITER ";"  nv_RptName + " Suspense"        nv_TTsusp   nv_Tsusp[1 FOR 15].
          EXPORT DELIMITER ";"  nv_RptName + " Net. A/R"        nv_TTnetar  nv_Tnetar[1 FOR 15].
          EXPORT DELIMITER ";"  nv_RptName + " Net. OTHER"      nv_TTnetoth nv_Tnetoth[1 FOR 15].
        
          EXPORT DELIMITER ";" "Summary of Bal. O/S : " + nv_RptName + " " + nv_RptTyp1
              "Current = " + STRING(nv_Tbal[1] + nv_Tbal[2] ,">>,>>>,>>>,>>9.99-") + nv-1 +
              "Over 1-3 = " + STRING(nv_Tbal[3] + nv_Tbal[4] + nv_Tbal[5],">>,>>>,>>>,>>9.99-") + nv-1 +
              "Over 3-6 = " + STRING(nv_Tbal[6] + nv_Tbal[7] + nv_Tbal[8],">>,>>>,>>>,>>9.99-") + nv-1 +
              "Over 6-9 = " + STRING(nv_Tbal[9] + nv_Tbal[10] + nv_Tbal[11] ,">>,>>>,>>>,>>9.99-") + nv-1 +
              "Over 9-12 = " + STRING(nv_Tbal[12] + nv_Tbal[13] + nv_Tbal[14] ,">>,>>>,>>>,>>9.99-") + nv-1 +
              "Over 12 = " + STRING(nv_Tbal[15] ,">>,>>>,>>>,>>9.99-").
        OUTPUT CLOSE.

        /* A47-0264 */
        OUTPUT TO VALUE (n_OutputFileSum + "OS") APPEND NO-ECHO.  /* SUMMARY */
            EXPORT DELIMITER ";"
                nv_RptName + " " + nv_RptTyp1 + " - " + nv_RptTyp2  /*"Branch"*/
                nv_TTprem       /*"Premium "*/
                nv_TTcomm       /*"Comm"*/
                nv_TTbal        /*"Bal. O/S"*/
                /* A47-9999 */
                nv_TTretc       /* cheque return */
                nv_TTsusp       /* suspense */
                nv_TTnetar      /* net. a/r */
                nv_TTnetoth     /* net. other */

                .
        
        OUTPUT CLOSE.
        /* end A47-0264 */

    END.  /* (nv_DetSum = "Summary")  OR (nv_DetSum = "All")  */
    

          /*----------- SUMMARY GRAND TOTAL-------------*/
/*---
            ASSIGN
                nv_gtot_prem      = nv_gtot_prem +  nv_tot_prem
                nv_gtot_prem_comp =  nv_gtot_prem_comp + nv_tot_prem_comp
                nv_gtot_stamp     = nv_gtot_stamp + nv_tot_stamp
                nv_gtot_tax       = nv_gtot_tax + nv_tot_tax
                nv_gtot_gross     = nv_gtot_gross + nv_tot_gross
                nv_gtot_comm      = nv_gtot_comm + nv_tot_comm
                nv_gtot_comm_comp =  nv_gtot_comm_comp + nv_tot_comm_comp
                nv_gtot_net       = nv_gtot_net + nv_tot_net
                nv_gtot_bal       = nv_gtot_bal + nv_tot_bal.
---*/

           ASSIGN
                nv_gtot_prem         = nv_gtot_prem +  nv_tot_prem
                nv_gtot_comm         = nv_gtot_comm + nv_tot_comm
                nv_gtot_bal          = nv_gtot_bal + nv_tot_bal
                
                nv_gtot_retc         = nv_gtot_retc + nv_tot_retc
                nv_gtot_susp         = nv_gtot_susp + nv_tot_susp
                nv_gtot_netar        = nv_gtot_netar + nv_tot_netar
                nv_gtot_netoth       = nv_gtot_netoth + nv_tot_netoth
                .

           i = 1.
           DO i = 1 to 15 :
/*---
              ASSIGN
                  nv_gtot_balDet[i] = nv_gtot_balDet[i] + nv_tot_balDet[i]  /* DETAIL*/

                  nv_GTprem[i] = nv_GTprem[i] + nv_Tprem[i]       /* SUMMARY */
                  nv_GTtax[i] = nv_GTtax[i] + nv_Ttax[i]
                  nv_GTvat[i] = nv_GTvat[i] + nv_Tvat[i]
                  nv_GTsbt[i] = nv_GTsbt[i] + nv_Tsbt[i]
                  nv_GTstamp[i] = nv_GTstamp[i] + nv_Tstamp[i]
                  nv_GTtotal[i] = nv_GTtotal[i] + nv_Ttotal[i]
                  nv_GTcomm[i] = nv_GTcomm[i] + nv_Tcomm[i]
                  nv_GTnet[i] = nv_GTnet[i] + nv_Tnet[i]
                  nv_GTretc[i] = nv_GTretc[i] + nv_Tretc[i]
                  nv_GTsusp[i] = nv_GTsusp[i] + nv_Tsusp[i]
                  nv_GTnetar[i] = nv_GTnetar[i] + nv_Tnetar[i]
                  nv_GTbal[i] = nv_GTbal[i] + nv_Tbal[i]

                  nv_GTTprem = nv_GTTprem + nv_Tprem[i]       /* column Total SUMMARY */
                  nv_GTTtax = nv_GTTtax + nv_Ttax[i]
                  nv_GTTvat = nv_GTTvat + nv_Tvat[i]
                  nv_GTTsbt = nv_GTTsbt + nv_Tsbt[i]
                  nv_GTTstamp = nv_GTTstamp + nv_Tstamp[i]
                  nv_GTTtotal = nv_GTTtotal + nv_Ttotal[i]
                  nv_GTTcomm = nv_GTTcomm + nv_Tcomm[i]
                  nv_GTTnet = nv_GTTnet + nv_Tnet[i]
                  nv_GTTretc = nv_GTTretc + nv_Tretc[i]
                  nv_GTTsusp = nv_GTTsusp + nv_Tsusp[i]
                  nv_GTTnetar = nv_GTTnetar + (nv_Tnet[i] + nv_Tretc[i] + nv_Tsusp[i]).
                  nv_GTTbal = nv_GTTbal +  nv_Tbal[i].
---*/
              ASSIGN
                  nv_gtot_balDet[i] = nv_gtot_balDet[i] + nv_tot_balDet[i]  /* DETAIL*/

                  nv_GTprem[i] = nv_GTprem[i] + nv_Tprem[i]       /* SUMMARY */
                  nv_GTcomm[i] = nv_GTcomm[i] + nv_Tcomm[i]
                  nv_GTbal[i]  = nv_GTbal[i]  + nv_Tbal[i]
                  nv_GTretc[i] = nv_GTretc[i] + nv_Tretc[i]
                  nv_GTsusp[i] = nv_GTsusp[i] + nv_Tsusp[i]
                  nv_GTnetar[i]  = nv_GTnetar[i]  + nv_Tnetar[i] 
                  nv_GTnetoth[i] = nv_GTnetoth[i] + nv_Tnetoth[i] 


                  nv_GTTprem = nv_GTTprem + nv_Tprem[i]       /* column Total SUMMARY */
                  nv_GTTcomm = nv_GTTcomm + nv_Tcomm[i]
                  nv_GTTbal  = nv_GTTbal  + nv_Tbal[i]
                  nv_GTTretc = nv_GTTretc + nv_Tretc[i]
                  nv_GTTsusp = nv_GTTsusp + nv_Tsusp[i]
                  nv_GTTnetar  = nv_GTTnetar + nv_Tnetar[i] 
                  nv_GTTnetoth = nv_GTTnetoth + nv_Tnetoth[i] 

                  .

           END.
