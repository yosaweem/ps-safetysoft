/* CREATE BY :  Sayamol N.     A54-0172    21/06/2011  */
/* Dupplicate Program from WACRL02.I                  */

/*--- DISPLAY DETAIL  ---*/
    IF (nv_DetSum = "Detail")  OR (nv_DetSum = "All") THEN DO:

        /* A47-0264 */
            {wac\wacr0604.i}
        /* end A47-0264 */

        OUTPUT TO VALUE (STRING(n_OutputFile ) ) APPEND NO-ECHO.  /* DISPLAY DETAIL */
          EXPORT DELIMITER ";"
              "TOTAL : " + nv_RptTyp1 + " - " + nv_RptTyp2
              nv_blankH[1 FOR 11] /*10*/ /*note plus 1*/
                nv_tot_prem
                nv_tot_comm
                nv_tot_bal
                nv_tot_retc
                nv_tot_susp
                nv_tot_netar
                nv_tot_netoth
                nv_tot_balDet[1 FOR 10].   
          
        OUTPUT CLOSE.

        OUTPUT TO VALUE (STRING(n_OutputFile + "com" ) ) APPEND NO-ECHO.  /* DISPLAY DETAIL */
          EXPORT DELIMITER ";"
              "TOTAL : " + nv_RptTyp1 + " - " + nv_RptTyp2
              nv_blankH[1 FOR 11] /*10*/ /*note plus 1*/
                nv_tot_prem
                nv_tot_comm
                nv_tot_bal
                nv_tot_retc
                nv_tot_susp
                nv_tot_netar
                nv_tot_netoth
                nv_tot_comDet[1 FOR 10].   
          
        OUTPUT CLOSE.
    END.  /*    (nv_DetSum = "Detail")  OR (nv_DetSum = "All") */

 /*** DISPLAY SUMMARY FILE & SUMMARY GRAND TOTAL***/

    IF (nv_DetSum = "Summary")  OR (nv_DetSum = "All") THEN DO:
        
        /*---A54-0119---*/
        OUTPUT TO VALUE (n_OutputFileSum) APPEND NO-ECHO.  /* DISPLAY SUMMARY */
          EXPORT DELIMITER ";"  "".
          EXPORT DELIMITER ";"  "Summary of : " + nv_RptName + " " + nv_RptTyp1 + " - " + nv_RptTyp2.

          EXPORT DELIMITER ";"  nv_RptName + " Premium"         nv_TTprem   
                                                                nv_Tprem[1 FOR 10].  
          EXPORT DELIMITER ";"  nv_RptName + " Commission"      nv_TTcomm  
                                                                nv_Tcomm[1 FOR 10].  
          EXPORT DELIMITER ";"  nv_RptName + " Bal. O/S"        nv_TTbal    
                                                                nv_Tbal[1 FOR 10].   
          EXPORT DELIMITER ";"  nv_RptName + " Cheque Returned" nv_TTretc   
                                                                nv_Tretc[1 FOR 10]. 
          EXPORT DELIMITER ";"  nv_RptName + " Suspense"        nv_TTsusp   
                                                                nv_Tsusp[1 FOR 10].  
          EXPORT DELIMITER ";"  nv_RptName + " Net. A/R"        nv_TTnetar  
                                                                nv_Tnetar[1 FOR 10]. 
          EXPORT DELIMITER ";"  nv_RptName + " Net. OTHER"      nv_TTnetoth 
                                                                nv_Tnetoth[1 FOR 10]. 
        
          EXPORT DELIMITER ";" "Summary of Bal. O/S : " + nv_RptName + " " + nv_RptTyp1
              "Within"          + STRING(nv_Tprem[1]  ,">>,>>>,>>>,>>9.99-") + nv-1 +    
              "ไม่เกิน 30 วัน"  + STRING(nv_Tprem[2]  ,">>,>>>,>>>,>>9.99-") + nv-1 +    
              "31 - 60 วัน"     + STRING(nv_Tprem[3]  ,">>,>>>,>>>,>>9.99-") + nv-1 + 
              "61 - 90 วัน"     + STRING(nv_Tprem[4]  ,">>,>>>,>>>,>>9.99-") + nv-1 +
              "91 - 120 วัน"    + STRING(nv_Tprem[5]  ,">>,>>>,>>>,>>9.99-") + nv-1 +
              "121 - 180 วัน"   + STRING(nv_Tprem[6]  ,">>,>>>,>>>,>>9.99-") + nv-1 +
              "181 - 365 วัน"   + STRING(nv_Tprem[7]  ,">>,>>>,>>>,>>9.99-") + nv-1 +
              "366 วันขึ้นไป"   + STRING(nv_Tprem[8] ,">>,>>>,>>>,>>9.99-"). 
              
        OUTPUT CLOSE.
        OUTPUT TO VALUE (n_OutputFileSum + "com") APPEND NO-ECHO.  /* DISPLAY SUMMARY */
          EXPORT DELIMITER ";"  "".
          EXPORT DELIMITER ";"  "Summary of : " + nv_RptName + " " + nv_RptTyp1 + " - " + nv_RptTyp2.

          EXPORT DELIMITER ";"  nv_RptName + " Premium"         nv_TTprem   
                                                                nv_Tprem[1 FOR 10].  
          EXPORT DELIMITER ";"  nv_RptName + " Commission"      nv_TTcomm  
                                                                nv_Tcomm[1 FOR 10].  
          EXPORT DELIMITER ";"  nv_RptName + " Bal. O/S"        nv_TTbal    
                                                                nv_Tbal[1 FOR 10].   
          EXPORT DELIMITER ";"  nv_RptName + " Cheque Returned" nv_TTretc   
                                                                nv_Tretc[1 FOR 10]. 
          EXPORT DELIMITER ";"  nv_RptName + " Suspense"        nv_TTsusp   
                                                                nv_Tsusp[1 FOR 10].  
          EXPORT DELIMITER ";"  nv_RptName + " Net. A/R"        nv_TTnetar  
                                                                nv_Tnetar[1 FOR 10]. 
          EXPORT DELIMITER ";"  nv_RptName + " Net. OTHER"      nv_TTnetoth 
                                                                nv_Tnetoth[1 FOR 10]. 
        
          EXPORT DELIMITER ";" "Summary of Bal. O/S : " + nv_RptName + " " + nv_RptTyp1
              "Within"          + STRING(nv_Tcomm[1]  ,">>,>>>,>>>,>>9.99-") + nv-1 +    
              "ไม่เกิน 30 วัน"  + STRING(nv_Tcomm[2]  ,">>,>>>,>>>,>>9.99-") + nv-1 +    
              "31 - 60 วัน"     + STRING(nv_Tcomm[3]  ,">>,>>>,>>>,>>9.99-") + nv-1 + 
              "61 - 90 วัน"     + STRING(nv_Tcomm[4]  ,">>,>>>,>>>,>>9.99-") + nv-1 +
              "91 - 120 วัน"    + STRING(nv_Tcomm[5]  ,">>,>>>,>>>,>>9.99-") + nv-1 +
              "121 - 180 วัน"   + STRING(nv_Tcomm[6]  ,">>,>>>,>>>,>>9.99-") + nv-1 +
              "181 - 365 วัน"   + STRING(nv_Tcomm[7]  ,">>,>>>,>>>,>>9.99-") + nv-1 +
              "366 วันขึ้นไป"   + STRING(nv_Tcomm[8] ,">>,>>>,>>>,>>9.99-"). 
                                             
        OUTPUT CLOSE.                        
        /*-- end A54-0119 --*/

        /* A47-0264 */
        OUTPUT TO VALUE (n_OutputFileSum + "OS") APPEND NO-ECHO.  /* SUMMARY */
            EXPORT DELIMITER ";"
                nv_RptName + " " + nv_RptTyp1 + " - " + nv_RptTyp2  /*"Branch"*/
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
                /*---Lukkana M. A52-0318 26/11/2009---*/
                nv_tot_balDet[5]
                nv_tot_balDet[6]
                nv_tot_balDet[7]
                nv_tot_balDet[8]
                nv_tot_balDet[9]
                nv_tot_balDet[10]
                .
        
        OUTPUT CLOSE.

        OUTPUT TO VALUE (n_OutputFileSum + "OS" + "com") APPEND NO-ECHO.  /* SUMMARY */
            EXPORT DELIMITER ";"
                nv_RptName + " " + nv_RptTyp1 + " - " + nv_RptTyp2  /*"Branch"*/
                nv_TTprem       /*"Premium "*/
                nv_TTcomm       /*"Comm"*/
                nv_TTbal        /*"Bal. O/S"*/

                nv_TTretc       /* cheque return */
                nv_TTsusp       /* suspense */
                nv_TTnetar      /* net. a/r */
                nv_TTnetoth     /* net. other */
                nv_tot_comDet[1]
                nv_tot_comDet[2]
                nv_tot_comDet[3]
                nv_tot_comDet[4]
                nv_tot_comDet[5]
                nv_tot_comDet[6]
                nv_tot_comDet[7]
                nv_tot_comDet[8]
                nv_tot_comDet[9]
                nv_tot_comDet[10]
                .
        
        OUTPUT CLOSE.
        /* end A47-0264 */

    END.  /* (nv_DetSum = "Summary")  OR (nv_DetSum = "All")  */

           ASSIGN
                nv_gtot_prem    = nv_gtot_prem   + nv_tot_prem
                nv_gtot_comm    = nv_gtot_comm   + nv_tot_comm
                nv_gtot_bal     = nv_gtot_bal    + nv_tot_bal
                                                 
                nv_gtot_retc    = nv_gtot_retc   + nv_tot_retc
                nv_gtot_susp    = nv_gtot_susp   + nv_tot_susp
                nv_gtot_netar   = nv_gtot_netar  + nv_tot_netar
                nv_gtot_netoth  = nv_gtot_netoth + nv_tot_netoth
                .

           i = 1.
           
           DO i = 1 to 10 :
              ASSIGN
                 nv_gtot_balDet[i]   = nv_gtot_balDet[i]    + nv_tot_balDet[i]  /* DETAIL*/
                 nv_gtot_comDet[i]   = nv_gtot_comDet[i]    + nv_tot_comDet[i] 
                 nv_gtot_netDet[i]   = nv_gtot_netDet[i]    + nv_tot_netDet[i]
                 nv_gtot_retcDet[i]  = nv_gtot_retcDet[i]   + nv_tot_retcDet[i]
                 nv_gtot_suspDet[i]  = nv_gtot_suspDet[i]   + nv_tot_suspDet[i]
                 nv_gtot_netarDet[i] = nv_gtot_netarDet[i]  + nv_tot_netarDet[i]
                 nv_gtot_balcDet[i]  = nv_gtot_balcDet[i]   + nv_tot_balcDet[i]
                 nv_gtot_netothDet[i] = nv_gtot_netothDet[i] + nv_tot_netothDet[i]
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
                  .

           END.
