/************************************ 
/* Create  By : Nattanicha K       Assign No.  :   A61-0427  */
    Program     : wacrvt01.i 
    Main program :    wacrlivt.w
   
   - DISPLAY SUMMARY FILE & SUMMARY GRAND TOTAL
***************************************/

/*--- DISPLAY DETAIL  ---*/
    IF (nv_DetSum = "Detail")  OR (nv_DetSum = "All") THEN DO:
      
        OUTPUT TO VALUE (STRING(n_OutputFile)) APPEND NO-ECHO.  /* DISPLAY DETAIL */
        EXPORT DELIMITER ";"
           "TOTAL : " + nv_RptTyp1 + " - " + nv_RptTyp2
           nv_blankH[1 FOR 13] /*10*/ /*note plus 1*/
             nv_tot_prem1
             nv_tot_stamp1
             nv_tot_vat1
             nv_tot_prem
             nv_tot_comm
             nv_tot_bal
             nv_tot_retc
             nv_tot_susp
             nv_tot_netar
             nv_tot_netoth
           /* 15 ช่อง */
           nv_tot_balDet[1 FOR 13]. 
        OUTPUT CLOSE.

    END.  /*    (nv_DetSum = "Detail")  OR (nv_DetSum = "All") */

 /*** DISPLAY SUMMARY FILE & SUMMARY GRAND TOTAL**/

    IF (nv_DetSum = "Summary")  OR (nv_DetSum = "All") THEN DO:
        OUTPUT TO VALUE (n_OutputFileSum) APPEND NO-ECHO.  /* DISPLAY SUMMARY */
          EXPORT DELIMITER ";"  "".
          EXPORT DELIMITER ";"  "Summary of : " + nv_RptName + " " + nv_RptTyp1 + " - " + nv_RptTyp2.
          EXPORT DELIMITER ";"  nv_RptName + " Premium"         nv_TTprem1   
                                                                nv_Tprem1[1 FOR 13].
          EXPORT DELIMITER ";"  nv_RptName + " Stamp"           nv_TTstamp1  
                                                                nv_Tstamp1[1 FOR 13].
          EXPORT DELIMITER ";"  nv_RptName + " VAT"            nv_TTvat1   
                                                                nv_Tvat1[1 FOR 13].
          EXPORT DELIMITER ";"  nv_RptName + " TotPremium"         nv_TTprem   
                                                                nv_Tprem[1 FOR 13]. 
          EXPORT DELIMITER ";"  nv_RptName + " Commission"      nv_TTcomm   
                                                                nv_Tcomm[1 FOR 13].  
          EXPORT DELIMITER ";"  nv_RptName + " Bal. O/S"        nv_TTbal    
                                                                nv_Tbal[1 FOR 13].  
          EXPORT DELIMITER ";"  nv_RptName + " Cheque Returned" nv_TTretc   
                                                                nv_Tretc[1 FOR 13]. 
          EXPORT DELIMITER ";"  nv_RptName + " Suspense"        nv_TTsusp  
                                                                nv_Tsusp[1 FOR 13]. 
          EXPORT DELIMITER ";"  nv_RptName + " Net. A/R"        nv_TTnetar  
                                                                nv_Tnetar[1 FOR 13]. 
          EXPORT DELIMITER ";"  nv_RptName + " Net. OTHER"      nv_TTnetoth 
                                                                nv_Tnetoth[1 FOR 13]. 
          EXPORT DELIMITER ";" "Summary of Bal. O/S : " + nv_RptName + " " + nv_RptTyp1
              "ไม่เกิน 30 วัน = " + STRING(nv_Tbal[1]  ,">>,>>>,>>>,>>9.99-") + nv-1 +    
              "31 - 60 วัน = "    + STRING(nv_Tbal[2]  ,">>,>>>,>>>,>>9.99-") + nv-1 +    
              "61 - 90 วัน = "    + STRING(nv_Tbal[3]  ,">>,>>>,>>>,>>9.99-") + nv-1 + 
              "91 - 120 วัน = "   + STRING(nv_Tbal[4]  ,">>,>>>,>>>,>>9.99-") + nv-1 +
              "121 - 150 วัน = "  + STRING(nv_Tbal[5]  ,">>,>>>,>>>,>>9.99-") + nv-1 +
              "151 - 180 วัน = "  + STRING(nv_Tbal[6]  ,">>,>>>,>>>,>>9.99-") + nv-1 +
              "181 - 210 วัน = "  + STRING(nv_Tbal[7]  ,">>,>>>,>>>,>>9.99-") + nv-1 +
              "211 - 240 วัน = "  + STRING(nv_Tbal[8]  ,">>,>>>,>>>,>>9.99-") + nv-1 +
              "241 - 270 วัน = "  + STRING(nv_Tbal[9]  ,">>,>>>,>>>,>>9.99-") + nv-1 +
              "271 - 300 วัน = "  + STRING(nv_Tbal[10] ,">>,>>>,>>>,>>9.99-") + nv-1 +
              "301 - 330 วัน = "  + STRING(nv_Tbal[11] ,">>,>>>,>>>,>>9.99-") + nv-1 +
              "331 - 365 วัน = "  + STRING(nv_Tbal[12] ,">>,>>>,>>>,>>9.99-") + nv-1 +
              "365 วันขึ้นไป = "  + STRING(nv_Tbal[13] ,">>,>>>,>>>,>>9.99-") .
             
        OUTPUT CLOSE.

        OUTPUT TO VALUE (n_OutputFileSum + "OS") APPEND NO-ECHO.  /* SUMMARY */
            EXPORT DELIMITER ";"
                nv_RptName + " " + nv_RptTyp1 + " - " + nv_RptTyp2  /*"Branch"*/
                nv_TTprem1
                nv_TTstamp1
                nv_TTvat1
                nv_TTprem       /*"Premium "*/
                nv_TTcomm       /*"Comm"*/
                nv_TTbal        /*"Bal. O/S"*/
                nv_TTretc       /* cheque return */
                nv_TTsusp       /* suspense */
                nv_TTnetar      /* net. a/r */
                nv_TTnetoth     /* net. other */
                nv_tot_balDet[1]
                nv_tot_balDet[2]
                nv_tot_balDet[3]
                nv_tot_balDet[4]
                nv_tot_balDet[5]
                nv_tot_balDet[6]
                nv_tot_balDet[7]
                nv_tot_balDet[8]
                nv_tot_balDet[9]
                nv_tot_balDet[10]
                nv_tot_balDet[11]
                nv_tot_balDet[12]
                nv_tot_balDet[13].
        
        OUTPUT CLOSE.

    END.  /* (nv_DetSum = "Summary")  OR (nv_DetSum = "All")  */

          /*----------- SUMMARY GRAND TOTAL-------------*/
           
           ASSIGN
               nv_gtot_prem    = nv_gtot_prem   + nv_tot_prem
               nv_gtot_comm    = nv_gtot_comm   + nv_tot_comm
               nv_gtot_bal     = nv_gtot_bal    + nv_tot_bal
               nv_gtot_prem1   = nv_gtot_prem1   + nv_tot_prem1
               nv_gtot_stamp1   = nv_gtot_stamp1   + nv_tot_stamp1
               nv_gtot_vat1     = nv_gtot_vat1    + nv_tot_vat1
               nv_gtot_retc    = nv_gtot_retc   + nv_tot_retc
               nv_gtot_susp    = nv_gtot_susp   + nv_tot_susp
               nv_gtot_netar   = nv_gtot_netar  + nv_tot_netar
               nv_gtot_netoth  = nv_gtot_netoth + nv_tot_netoth.
           
           i = 1.
           DO i = 1 to 15 :

              ASSIGN
                  nv_gtot_balDet[i] = nv_gtot_balDet[i] + nv_tot_balDet[i]  /* DETAIL*/
                  nv_GTprem1[i]   = nv_GTprem1[i]   + nv_Tprem1[i] 
                  nv_GTstamp1[i]   = nv_GTstamp1[i]   + nv_Tstamp1[i] 
                  nv_GTvat1[i]   = nv_GTvat1[i]   + nv_Tvat1[i] 
                  nv_GTprem[i]   = nv_GTprem[i]   + nv_Tprem[i]       /* SUMMARY */
                  nv_GTcomm[i]   = nv_GTcomm[i]   + nv_Tcomm[i]
                  nv_GTbal[i]    = nv_GTbal[i]    + nv_Tbal[i]
                  nv_GTretc[i]   = nv_GTretc[i]   + nv_Tretc[i]
                  nv_GTsusp[i]   = nv_GTsusp[i]   + nv_Tsusp[i]
                  nv_GTnetar[i]  = nv_GTnetar[i]  + nv_Tnetar[i] 
                  nv_GTnetoth[i] = nv_GTnetoth[i] + nv_Tnetoth[i] 
                  nv_GTTprem    = nv_GTTprem    + nv_Tprem[i]       /* column Total SUMMARY */
                  nv_GTTcomm    = nv_GTTcomm    + nv_Tcomm[i]
                  nv_GTTbal     = nv_GTTbal     + nv_Tbal[i]
                  nv_GTTretc    = nv_GTTretc    + nv_Tretc[i]
                  nv_GTTsusp    = nv_GTTsusp    + nv_Tsusp[i]
                  nv_GTTnetar   = nv_GTTnetar   + nv_Tnetar[i] 
                  nv_GTTnetoth  = nv_GTTnetoth  + nv_Tnetoth[i]
                  nv_GTTprem1    = nv_GTTprem1    + nv_Tprem1[i] 
                  nv_GTTstamp1    = nv_GTTstamp1    + nv_Tstamp1[i] 
                  nv_GTTvat1    = nv_GTTvat1    + nv_Tvat1[i] .

           END.
