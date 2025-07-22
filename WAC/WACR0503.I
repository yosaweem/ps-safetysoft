/* Modify : Kanchana C.  07/05/2003    Assign No.  :   A46-0142
    Main program :    wacr05.w
 
 */

        /********************** Page Footer *********************/
    OUTPUT TO VALUE (STRING(n_OutputFile ) ) APPEND NO-ECHO. /* DISPLAY DETAIL */
        EXPORT DELIMITER ";"
            "GRAND TOTAL : " 
            nv_blankH[1 FOR 9] /*10*/ 
            nv_gtot_prem
            nv_gtot_prem_comp
            nv_gtot_stamp
            nv_gtot_tax
            nv_gtot_gross
            nv_gtot_comm
            nv_gtot_comm_comp
            nv_gtot_net
            nv_gtot_bal

            /* 15 ช่อง */
            nv_gtot_balDet[1 FOR 15 ].
        EXPORT DELIMITER ";"  "".
    OUTPUT CLOSE.

    OUTPUT TO VALUE (n_OutputFileSum) APPEND NO-ECHO.  /* DISPLAY SUMMARY */
        EXPORT DELIMITER ";"  "".
        EXPORT DELIMITER ";"  "".
        EXPORT DELIMITER ";"  "G R A N D  T O T A L".
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

        EXPORT DELIMITER ";"  "".
        EXPORT DELIMITER ";" "G R A N D  T O T A L"
            "Current = " + STRING(nv_GTbal[1] + nv_GTbal[2] ,">>,>>>,>>>,>>9.99-") + nv-1 +
            "Over 1-3 = " + STRING(nv_GTbal[3] + nv_GTbal[4] + nv_GTbal[5],">>,>>>,>>>,>>9.99-") + nv-1 +
            "Over 3-6 = " + STRING(nv_GTbal[6] + nv_GTbal[7] + nv_GTbal[8],">>,>>>,>>>,>>9.99-") + nv-1 +
            "Over 6-9 = " + STRING(nv_GTbal[9] + nv_GTbal[10] + nv_GTbal[11] ,">>,>>>,>>>,>>9.99-") + nv-1 +
            "Over 9-12 = " + STRING(nv_GTbal[12] + nv_GTbal[13] + nv_GTbal[14] ,">>,>>>,>>>,>>9.99-") + nv-1 +
            "Over 12 = " + STRING(nv_GTbal[15] ,">>,>>>,>>>,>>9.99-").

    OUTPUT CLOSE.
    
    
    
    /*
            EXPORT DELIMITER ";" "Grand".
            EXPORT DELIMITER ";" "Current = "  STRING(nv_GTbal[1] + nv_GTbal[2] ,">>,>>>,>>>,>>9.99-").
            EXPORT DELIMITER ";" "Over 1-3 = "  STRING(nv_GTbal[3] + nv_GTbal[4] + nv_GTbal[5],">>,>>>,>>>,>>9.99-").
            EXPORT DELIMITER ";" "Over 3-6 = "  STRING(nv_GTbal[6] + nv_GTbal[7] + nv_GTbal[8],">>,>>>,>>>,>>9.99-").
            EXPORT DELIMITER ";" "Over 6-9 = "  STRING(nv_GTbal[9] + nv_GTbal[10] + nv_GTbal[11] ,">>,>>>,>>>,>>9.99-").
            EXPORT DELIMITER ";" "Over 9-12 = "  STRING(nv_GTbal[12] + nv_GTbal[13] + nv_GTbal[14] ,">>,>>>,>>>,>>9.99-").
            EXPORT DELIMITER ";" "Over 12 = "  STRING(nv_GTbal[15] ,">>,>>>,>>>,>>9.99-").
*/

