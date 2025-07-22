/************************************ 
   Create  By : Nattanicha K       Assign No.  :   A61-0427  
    Program     : wacrvt01.i 
    Main program :    wacrlivt.w

    - DISPLAY SUMMARY FILE & SUMMARY GRAND TOTAL
 ***************************************/
 
        /********************** Page Footer *********************/
/*--- DISPLAY DETAIL  ---*/
    IF (nv_DetSum = "Detail")  OR (nv_DetSum = "All") THEN DO:
        
        OUTPUT TO VALUE (STRING(n_OutputFile ) ) APPEND NO-ECHO. /* DISPLAY DETAIL */
            EXPORT DELIMITER ";" "".

            EXPORT DELIMITER ";"
                "GRAND TOTAL : " 
                nv_blankH[1 FOR 13] /*10*/  /*note plus 1*/
                nv_gtot_prem1
                nv_gtot_stamp1
                nv_gtot_vat1
    
                nv_gtot_prem
                nv_gtot_comm
                nv_gtot_bal
                
                nv_gtot_retc
                nv_gtot_susp
                nv_gtot_netar
                nv_gtot_netoth
               
                nv_gtot_balDet[1 FOR 13 ]. 

            EXPORT DELIMITER ";"  "".
            OUTPUT CLOSE.

    END.    /* (nv_DetSum = "Detail")  OR (nv_DetSum = "All") */
    
 /*** DISPLAY SUMMARY FILE & SUMMARY GRAND TOTAL***/

    IF (nv_DetSum = "Summary")  OR (nv_DetSum = "All") THEN DO:

        OUTPUT TO VALUE (n_OutputFileSum) APPEND NO-ECHO.  /* DISPLAY SUMMARY */
            EXPORT DELIMITER ";"  "".
            EXPORT DELIMITER ";"  "".
            EXPORT DELIMITER ";"  "G R A N D  T O T A L".
            EXPORT DELIMITER ";"  "Grand Premium"         nv_GTTprem1    
                                                          nv_GTprem1[1 FOR 13].  
            EXPORT DELIMITER ";"  "Grand Stamp"         nv_GTTstamp1    
                                                          nv_GTstamp1[1 FOR 13].  
            EXPORT DELIMITER ";"  "Grand Vat"         nv_GTTvat1    
                                                          nv_GTvat1[1 FOR 13].  
            EXPORT DELIMITER ";"  "Grand TotPremium"         nv_GTTprem    
                                                          nv_GTprem[1 FOR 13].  
            EXPORT DELIMITER ";"  "Grand Commission"      nv_GTTcomm    
                                                          nv_GTcomm[1 FOR 13].
            EXPORT DELIMITER ";"  "Grand Bal. O/S"        nv_GTTbal     
                                                          nv_GTbal[1 FOR 13].  
            EXPORT DELIMITER ";"  "Grand Cheque Returned" nv_GTTretc   
                                                          nv_GTretc[1 FOR 13]. 
            EXPORT DELIMITER ";"  "Grand Suspense"        nv_GTTsusp    
                                                          nv_GTsusp[1 FOR 13]. 
            EXPORT DELIMITER ";"  "Grand Net. A/R"        nv_GTTnetar   
                                                          nv_GTnetar[1 FOR 13]. 
            EXPORT DELIMITER ";"  "Grand Net. OTHER"      nv_GTTnetoth  
                                                          nv_GTnetoth[1 FOR 13]. 
            EXPORT DELIMITER ";"  "".
            EXPORT DELIMITER ";" "G R A N D  T O T A L  OF  Bal. O/S"
                "ไม่เกิน 30 วัน = " + STRING(nv_GTbal[1]  ,">>,>>>,>>>,>>9.99-") + nv-1 +       
                "31 - 60 วัน = "    + STRING(nv_GTbal[2]  ,">>,>>>,>>>,>>9.99-") + nv-1 +       
                "61 - 90 วัน = "    + STRING(nv_GTbal[3]  ,">>,>>>,>>>,>>9.99-") + nv-1 + 
                "91 - 120 วัน = "   + STRING(nv_GTbal[4]  ,">>,>>>,>>>,>>9.99-") + nv-1 +
                "121 - 150 วัน = "  + STRING(nv_GTbal[5]  ,">>,>>>,>>>,>>9.99-") + nv-1 + 
                "151 - 180 วัน = "  + STRING(nv_GTbal[6]  ,">>,>>>,>>>,>>9.99-") + nv-1 + 
                "181 - 210 วัน = "  + STRING(nv_GTbal[7]  ,">>,>>>,>>>,>>9.99-") + nv-1 + 
                "211 - 240 วัน = "  + STRING(nv_GTbal[8]  ,">>,>>>,>>>,>>9.99-") + nv-1 + 
                "241 - 270 วัน = "  + STRING(nv_GTbal[9]  ,">>,>>>,>>>,>>9.99-") + nv-1 + 
                "271 - 300 วัน = "  + STRING(nv_GTbal[10] ,">>,>>>,>>>,>>9.99-") + nv-1 + 
                "301 - 330 วัน = "  + STRING(nv_GTbal[11] ,">>,>>>,>>>,>>9.99-") + nv-1 + 
                "331 - 365 วัน = "  + STRING(nv_GTbal[12] ,">>,>>>,>>>,>>9.99-") + nv-1 + 
                "365 วันขึ้นไป = "  + STRING(nv_GTbal[13] ,">>,>>>,>>>,>>9.99-") .
                
        OUTPUT CLOSE.
        
        OUTPUT TO VALUE (n_OutputFileSum + "OS") APPEND NO-ECHO.  /* SUMMARY */
            EXPORT DELIMITER ";"
                "G R A N D  T O T A L"      /*"Branch"*/
                nv_GTTprem1
                nv_GTTstamp1
                nv_GTTvat1
                nv_GTTprem       /*"Premium "*/
                nv_GTTcomm       /*"Comm"*/
                nv_GTTbal        /*"Bal. O/S"*/
                nv_GTTretc       /* cheque return */
                nv_GTTsusp       /* suspense */
                nv_GTTnetar      /* net. a/r */
                nv_GTTnetoth     /* net. other */
                nv_gtot_balDet[1 FOR 13] .

        OUTPUT CLOSE.
        
    END.  /* (nv_DetSum = "Summary")  OR (nv_DetSum = "All")  */
    
