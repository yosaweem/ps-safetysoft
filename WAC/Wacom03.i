/************************************ 
    Create By : Kanchana C.      Assign No.  :   A46-0079   23/02/2004
    Program     : wacr0603.i 
    Main program :    wacr06.w

    - DISPLAY SUMMARY FILE & SUMMARY GRAND TOTAL
 ***************************************/
 
        /********************** Page Footer *********************/
/*--- DISPLAY DETAIL  ---*/
    IF (nv_DetSum = "Detail")  OR (nv_DetSum = "All") THEN DO:

        /* A47-0264 */
            {wac\wacrno04.i}
        /* end A47-0264 */

        OUTPUT TO VALUE (STRING(n_OutputFile ) ) APPEND NO-ECHO. /* DISPLAY DETAIL */
            EXPORT DELIMITER ";" "".

            EXPORT DELIMITER ";"
                "GRAND TOTAL : " 
                nv_blankH[1 FOR 10] /*10*/  /*note plus 1*/
    
                nv_gtot_prem
                nv_gtot_comm
                nv_gtot_bal
                
                nv_gtot_retc
                nv_gtot_susp
                nv_gtot_netar
                nv_gtot_netoth
    
                nv_gtot_balDet[1 FOR 4 ]. /*note modi*/
            EXPORT DELIMITER ";"  "".
        OUTPUT CLOSE.
    END.    /* (nv_DetSum = "Detail")  OR (nv_DetSum = "All") */
    
 /*** DISPLAY SUMMARY FILE & SUMMARY GRAND TOTAL***/

    IF (nv_DetSum = "Summary")  OR (nv_DetSum = "All") THEN DO:

        OUTPUT TO VALUE (n_OutputFileSum) APPEND NO-ECHO.  /* DISPLAY SUMMARY */
            EXPORT DELIMITER ";"  "".
            EXPORT DELIMITER ";"  "".
            EXPORT DELIMITER ";"  "G R A N D  T O T A L".
    /*---
            EXPORT DELIMITER ";"  "Grand Premium"          nv_GTTprem   nv_GTprem[1 FOR 15].
            EXPORT DELIMITER ";"  "Grand Tax"                    nv_GTTtax        nv_GTtax[1 FOR 15].
            EXPORT DELIMITER ";"  "  - Grand [VAT]"            nv_GTTvat       nv_GTvat[1 FOR 15].
            EXPORT DELIMITER ";"  "  - Grand [SBT]"            nv_GTTsbt       nv_GTsbt[1 FOR 15].
            EXPORT DELIMITER ";"  "Grand Stamp"                nv_GTTstamp nv_GTstamp[1 FOR 15].
            EXPORT DELIMITER ";"  "Grand Total Premium" nv_GTTtotal     nv_GTtotal[1 FOR 15].
            EXPORT DELIMITER ";"  "Grand Commission"     nv_GTTcomm  nv_GTcomm[1 FOR 15].
            EXPORT DELIMITER ";"  "Grand Net Premium"    nv_GTTnet         nv_GTnet[1 FOR 15].
            EXPORT DELIMITER ";"  "Grand Cheque Returned" nv_GTTretc   nv_GTretc[1 FOR 15].
            EXPORT DELIMITER ";"  "Grand Suspense"         nv_GTTsusp       nv_GTsusp[1 FOR 15].
            EXPORT DELIMITER ";"  "Grand Net. A/R"            nv_GTTnetar      nv_GTnetar[1 FOR 15].
            EXPORT DELIMITER ";"  "Grand Bal. O/S"             nv_GTTbal         nv_GTbal[1 FOR 15].
    ---*/
    
            EXPORT DELIMITER ";"  "Grand Premium"           nv_GTTprem      nv_GTprem[1 FOR 4].
            EXPORT DELIMITER ";"  "Grand Commission"        nv_GTTcomm      nv_GTcomm[1 FOR 4].
            EXPORT DELIMITER ";"  "Grand Bal. O/S"          nv_GTTbal       nv_GTbal[1 FOR  4].
            EXPORT DELIMITER ";"  "Grand Cheque Returned"   nv_GTTretc      nv_GTretc[1 FOR 4].
            EXPORT DELIMITER ";"  "Grand Suspense"          nv_GTTsusp      nv_GTsusp[1 FOR 4].
            EXPORT DELIMITER ";"  "Grand Net. A/R"          nv_GTTnetar     nv_GTnetar[1 FOR 4].
            EXPORT DELIMITER ";"  "Grand Net. OTHER"        nv_GTTnetoth    nv_GTnetoth[1 FOR 4].
    
    
            EXPORT DELIMITER ";"  "".
            EXPORT DELIMITER ";" "G R A N D  T O T A L  OF  Bal. O/S"
                "ไม่เกิน 60 วัน = " + STRING(nv_GTbal[1] /*+ nv_Tbal[4] + nv_Tbal[5]*/,">>,>>>,>>>,>>9.99-") + nv-1 +
              "61 - 90  วัน = " + STRING(nv_GTbal[2] /*+ nv_Tbal[7] + nv_Tbal[8]*/,">>,>>>,>>>,>>9.99-") + nv-1 +
              "91 - 365 วัน = " + STRING(nv_GTbal[3] /*+ nv_Tbal[10] + nv_Tbal[11]*/ ,">>,>>>,>>>,>>9.99-") + nv-1 +
              "365 วันขึ้นไป = " + STRING(nv_GTbal[4] /*+ nv_Tbal[13] + nv_Tbal[14] */,">>,>>>,>>>,>>9.99-") .
                /*"Current = " + STRING(nv_GTbal[1] + nv_GTbal[2] ,">>,>>>,>>>,>>9.99-") + nv-1 +
                "Over 1-3 = " + STRING(nv_GTbal[3] + nv_GTbal[4] + nv_GTbal[5],">>,>>>,>>>,>>9.99-") + nv-1 +
                "Over 3-6 = " + STRING(nv_GTbal[6] + nv_GTbal[7] + nv_GTbal[8],">>,>>>,>>>,>>9.99-") + nv-1 +
                "Over 6-9 = " + STRING(nv_GTbal[9] + nv_GTbal[10] + nv_GTbal[11] ,">>,>>>,>>>,>>9.99-") + nv-1 +
                "Over 9-12 = " + STRING(nv_GTbal[12] + nv_GTbal[13] + nv_GTbal[14] ,">>,>>>,>>>,>>9.99-") + nv-1 +
                "Over 12 = " + STRING(nv_GTbal[15] ,">>,>>>,>>>,>>9.99-").*/
    
        OUTPUT CLOSE.

        /* A47-0264 */
        OUTPUT TO VALUE (n_OutputFileSum + "OS") APPEND NO-ECHO.  /* SUMMARY */
            EXPORT DELIMITER ";"
                "G R A N D  T O T A L"      /*"Branch"*/
                nv_GTTprem       /*"Premium "*/
                nv_GTTcomm       /*"Comm"*/
                nv_GTTbal        /*"Bal. O/S"*/

                nv_GTTretc       /* cheque return */
                nv_GTTsusp       /* suspense */
                nv_GTTnetar      /* net. a/r */
                nv_GTTnetoth     /* net. other */
                nv_gtot_balDet[1 FOR 4 ] /*note add new*/


                .

        OUTPUT CLOSE.
        /* end A47-0264 */

    END.  /* (nv_DetSum = "Summary")  OR (nv_DetSum = "All")  */
    
