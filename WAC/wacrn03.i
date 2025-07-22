/* CREATE BY :  Sayamol N.     A54-0172    21/06/2011  */
/* Dupplicate Program from WACRL03.I                  */
 
        /********************** Page Footer *********************/
/*--- DISPLAY DETAIL  ---*/
    IF (nv_DetSum = "Detail")  OR (nv_DetSum = "All") THEN DO:

        /* A47-0264 */
            /*{wac\wacrno04.i} ---A53-0159---*/
            {wac\wacr0604.i}
        /* end A47-0264 */

        OUTPUT TO VALUE (STRING(n_OutputFile ) ) APPEND NO-ECHO. /* DISPLAY DETAIL */
            EXPORT DELIMITER ";" "".

            EXPORT DELIMITER ";"
                "GRAND TOTAL : " 
                nv_blankH[1 FOR 11] /*10*/  /*note plus 1*/
    
                nv_gtot_prem
                nv_gtot_comm
                nv_gtot_bal
                
                nv_gtot_retc
                nv_gtot_susp
                nv_gtot_netar
                nv_gtot_netoth

                /*---
                nv_gtot_balDet[1 FOR 4 ]. /*note modi*/
                Lukkana M. A52-0318 26/11/2009---*/

                /*---Lukkana M. A52-0318 26/11/2009---*/
                /* nv_gtot_balDet[1 FOR 13 ]. ----A53-0159---*/
                 /*---A54-0119---
                 nv_gtot_balDet[1 FOR 9 ].   /*A53-0159*/
                 -----------*/
                nv_gtot_balDet[1 FOR 10 ].   /*A54-0119*/
                /*---Lukkana M. A52-0318 26/11/2009---*/

        EXPORT DELIMITER ";"  "".
        OUTPUT CLOSE.

        OUTPUT TO VALUE (STRING(n_OutputFile + "com" ) ) APPEND NO-ECHO. /* DISPLAY DETAIL */
            EXPORT DELIMITER ";" "".

            EXPORT DELIMITER ";"
                "GRAND TOTAL : " 
                nv_blankH[1 FOR 11] /*10*/  /*note plus 1*/
    
                nv_gtot_prem
                nv_gtot_comm
                nv_gtot_bal
                
                nv_gtot_retc
                nv_gtot_susp
                nv_gtot_netar
                nv_gtot_netoth

                /*---
                nv_gtot_balDet[1 FOR 4 ]. /*note modi*/
                Lukkana M. A52-0318 26/11/2009---*/

                /*---Lukkana M. A52-0318 26/11/2009---*/
                /* nv_gtot_balDet[1 FOR 13 ]. ----A53-0159---*/
                 /*---A54-0119---
                 nv_gtot_balDet[1 FOR 9 ].   /*A53-0159*/
                 -----------*/
                nv_gtot_comDet[1 FOR 10 ].   /*A54-0119*/
                /*---Lukkana M. A52-0318 26/11/2009---*/

        EXPORT DELIMITER ";"  "".
        OUTPUT CLOSE.
    END.    /* (nv_DetSum = "Detail")  OR (nv_DetSum = "All") */
    
 /*** DISPLAY SUMMARY FILE & SUMMARY GRAND TOTAL***/

    IF (nv_DetSum = "Summary")  OR (nv_DetSum = "All") THEN DO:

       OUTPUT TO VALUE (n_OutputFileSum) APPEND NO-ECHO.  /* DISPLAY SUMMARY */
            EXPORT DELIMITER ";"  "".
            EXPORT DELIMITER ";"  "".
            EXPORT DELIMITER ";"  "G R A N D  T O T A L".
            EXPORT DELIMITER ";"  "Grand Premium"         nv_GTTprem    
                                                          nv_GTprem[1 FOR 10].
            EXPORT DELIMITER ";"  "Grand Commission"      nv_GTTcomm    
                                                          nv_GTcomm[1 FOR 10]. 
            EXPORT DELIMITER ";"  "Grand Bal. O/S"        nv_GTTbal     
                                                          nv_GTbal[1 FOR 10].  
            EXPORT DELIMITER ";"  "Grand Cheque Returned" nv_GTTretc    
                                                          nv_GTretc[1 FOR 10]. 
            EXPORT DELIMITER ";"  "Grand Suspense"        nv_GTTsusp    
                                                          nv_GTsusp[1 FOR 10]. 
            EXPORT DELIMITER ";"  "Grand Net. A/R"        nv_GTTnetar   
                                                          nv_GTnetar[1 FOR 10].
            EXPORT DELIMITER ";"  "Grand Net. OTHER"      nv_GTTnetoth  
                                                          nv_GTnetoth[1 FOR 10].  
 
            EXPORT DELIMITER ";"  "".
            EXPORT DELIMITER ";" "G R A N D  T O T A L  OF  Bal. O/S"
                "Within"         + STRING(nv_GTbal[1]  ,">>,>>>,>>>,>>9.99-") + nv-1 +       
                "ไม่เกิน 30 วัน" + STRING(nv_GTbal[2]  ,">>,>>>,>>>,>>9.99-") + nv-1 +       
                "31 - 60 วัน"    + STRING(nv_GTbal[3]  ,">>,>>>,>>>,>>9.99-") + nv-1 + 
                "61 - 90 วัน"    + STRING(nv_GTbal[4]  ,">>,>>>,>>>,>>9.99-") + nv-1 +
                "91 - 120 วัน"   + STRING(nv_GTbal[5]  ,">>,>>>,>>>,>>9.99-") + nv-1 + 
                "121 - 180 วัน"  + STRING(nv_GTbal[6]  ,">>,>>>,>>>,>>9.99-") + nv-1 + 
                "181 - 365 วัน"  + STRING(nv_GTbal[7]  ,">>,>>>,>>>,>>9.99-") + nv-1 + 
                "366 วันขึ้นไป"  + STRING(nv_GTbal[8]  ,">>,>>>,>>>,>>9.99-") .

        OUTPUT CLOSE.

        OUTPUT TO VALUE (n_OutputFileSum + "com") APPEND NO-ECHO.  /* DISPLAY SUMMARY */
            EXPORT DELIMITER ";"  "".
            EXPORT DELIMITER ";"  "".
            EXPORT DELIMITER ";"  "G R A N D  T O T A L".
            EXPORT DELIMITER ";"  "Grand Premium"         nv_GTTprem    
                                                          nv_GTprem[1 FOR 10].
            EXPORT DELIMITER ";"  "Grand Commission"      nv_GTTcomm    
                                                          nv_GTcomm[1 FOR 10]. 
            EXPORT DELIMITER ";"  "Grand Bal. O/S"        nv_GTTbal     
                                                          nv_GTbal[1 FOR 10].  
            EXPORT DELIMITER ";"  "Grand Cheque Returned" nv_GTTretc    
                                                          nv_GTretc[1 FOR 10]. 
            EXPORT DELIMITER ";"  "Grand Suspense"        nv_GTTsusp    
                                                          nv_GTsusp[1 FOR 10]. 
            EXPORT DELIMITER ";"  "Grand Net. A/R"        nv_GTTnetar   
                                                          nv_GTnetar[1 FOR 10].
            EXPORT DELIMITER ";"  "Grand Net. OTHER"      nv_GTTnetoth  
                                                          nv_GTnetoth[1 FOR 10].  
 
            EXPORT DELIMITER ";"  "".
            EXPORT DELIMITER ";" "G R A N D  T O T A L  OF  Bal. O/S"
                "Within"         + STRING(nv_GTcomm[1]  ,">>,>>>,>>>,>>9.99-") + nv-1 +       
                "ไม่เกิน 30 วัน" + STRING(nv_GTcomm[2]  ,">>,>>>,>>>,>>9.99-") + nv-1 +       
                "31 - 60 วัน"    + STRING(nv_GTcomm[3]  ,">>,>>>,>>>,>>9.99-") + nv-1 + 
                "61 - 90 วัน"    + STRING(nv_GTcomm[4]  ,">>,>>>,>>>,>>9.99-") + nv-1 +
                "91 - 120 วัน"   + STRING(nv_GTcomm[5]  ,">>,>>>,>>>,>>9.99-") + nv-1 + 
                "121 - 180 วัน"  + STRING(nv_GTcomm[6]  ,">>,>>>,>>>,>>9.99-") + nv-1 + 
                "181 - 365 วัน"  + STRING(nv_GTcomm[7]  ,">>,>>>,>>>,>>9.99-") + nv-1 + 
                "366 วันขึ้นไป"  + STRING(nv_GTcomm[8]  ,">>,>>>,>>>,>>9.99-") .
                                               
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
                /*---A54-0119---
                nv_gtot_balDet[1 FOR 9]
                ------------*/
                nv_gtot_balDet[1 FOR 10]    /*--A54-0119--*/
                .

        OUTPUT CLOSE.

        OUTPUT TO VALUE (n_OutputFileSum + "OS" + "com") APPEND NO-ECHO.  /* SUMMARY */
            EXPORT DELIMITER ";"
                "G R A N D  T O T A L"      /*"Branch"*/
                nv_GTTprem       /*"Premium "*/
                nv_GTTcomm       /*"Comm"*/
                nv_GTTbal        /*"Bal. O/S"*/
                nv_GTTretc       /* cheque return */
                nv_GTTsusp       /* suspense */
                nv_GTTnetar      /* net. a/r */
                nv_GTTnetoth     /* net. other */
                /*---A54-0119---
                nv_gtot_balDet[1 FOR 9]
                ------------*/
                nv_gtot_comDet[1 FOR 10]    /*--A54-0119--*/
                .

        OUTPUT CLOSE.
        /* end A47-0264 */

    END.  /* (nv_DetSum = "Summary")  OR (nv_DetSum = "All")  */
    
