/************************************ 
    Create By : Kanchana C.      Assign No.  :   A46-0079  23/02/2004
    Program     : wacr0602.i 
    Main program :    wacr06.w
    
    - DISPLAY SUMMARY FILE & SUMMARY GRAND TOTAL

/*MODIFY BY : KANCHANA C.   Assign No.  :   A48-0265        24/05/2005 */
- เพิ่ม  การเรียกตาม Agent code
- report by line  เปลี่ยนจาก acno เป็น agent 
- ไฟล์ ...OS  เพิ่มยอดรวม  ตาม จำนวนวันด้วย

/* Modify By : Lukkana M.  Date : 26/11/2009              */
/* Assign No : A52-0318 ปรับ Report โดยเปลี่ยนคอลัมน์จาก ไม่เกิน 60 วัน , 61 - 90 วัน , 91- 365 วัน , 365 วันขึ้นไป
            มาเป็น  ไม่เกิน 30 วัน , 31-60 วัน , 61-90 วัน , 91-120 วัน , 121-150 วัน , 151-180 วัน , 181-210 วัน
            211-240 วัน , 241-270 วัน , 271-300 วัน , 301-330 วัน , 331-365 วัน , 365 วันขึ้นไป              */
/*---A53-0159 : By Sayamol N. Date 31/08/2010          */  
/*--- Modify By A54-0119  Sayamol N. 03/05/2011 ---*/
/*--- เพิ่มคอลัมน์ ระยะเวลาค้างชำระ เป็น        ---*/
/*--- 91-120, 121-150, 151-180, 181-210, 211-240,---*/ 
/*--- 241-270, 271-300, 301-330, 331-365, over 365 ---*/
***************************************/

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
               /*--- A54-0119--- 
               nv_tot_balDet[1 FOR 9].    /*A53-0159*/
               ----------*/
              nv_tot_balDet[1 FOR 15].    /*A54-0119*/
          
        OUTPUT CLOSE.
    END.  /*    (nv_DetSum = "Detail")  OR (nv_DetSum = "All") */

 /*** DISPLAY SUMMARY FILE & SUMMARY GRAND TOTAL***/

    IF (nv_DetSum = "Summary")  OR (nv_DetSum = "All") THEN DO:
        /*---A54-0119---
        OUTPUT TO VALUE (n_OutputFileSum) APPEND NO-ECHO.  /* DISPLAY SUMMARY */
          EXPORT DELIMITER ";"  "".
          EXPORT DELIMITER ";"  "Summary of : " + nv_RptName + " " + nv_RptTyp1 + " - " + nv_RptTyp2.

          EXPORT DELIMITER ";"  nv_RptName + " Premium"         nv_TTprem   /*nv_Tprem[1 FOR 4]. Lukkana M. A52-0318 26/11/2009 --*/     
                                                                nv_Tprem[1 FOR 9].  /*-- Lukkana M. A52-0318 26/11/2009 --*/
          EXPORT DELIMITER ";"  nv_RptName + " Commission"      nv_TTcomm   /*nv_Tcomm[1 FOR 4]. Lukkana M. A52-0318 26/11/2009 --*/
                                                                nv_Tcomm[1 FOR 9].  /*-- Lukkana M. A52-0318 26/11/2009 --*/
          EXPORT DELIMITER ";"  nv_RptName + " Bal. O/S"        nv_TTbal    /*nv_Tbal[1 FOR 4]. Lukkana M. A52-0318 26/11/2009 --*/      
                                                                nv_Tbal[1 FOR 9].   /*-- Lukkana M. A52-0318 26/11/2009 --*/
          EXPORT DELIMITER ";"  nv_RptName + " Cheque Returned" nv_TTretc   /*nv_Tretc[1 FOR 4]. Lukkana M. A52-0318 26/11/2009 --*/     
                                                                nv_Tretc[1 FOR 9].  /*-- Lukkana M. A52-0318 26/11/2009 --*/
          EXPORT DELIMITER ";"  nv_RptName + " Suspense"        nv_TTsusp   /*nv_Tsusp[1 FOR 4]. Lukkana M. A52-0318 26/11/2009 --*/     
                                                                nv_Tsusp[1 FOR 9].  /*-- Lukkana M. A52-0318 26/11/2009 --*/
          EXPORT DELIMITER ";"  nv_RptName + " Net. A/R"        nv_TTnetar  /*nv_Tnetar[1 FOR 4]. Lukkana M. A52-0318 26/11/2009 --*/    
                                                                nv_Tnetar[1 FOR 9]. /*-- Lukkana M. A52-0318 26/11/2009 --*/
          EXPORT DELIMITER ";"  nv_RptName + " Net. OTHER"      nv_TTnetoth /*nv_Tnetoth[1 FOR 4]. Lukkana M. A52-0318 26/11/2009 --*/   
                                                                nv_Tnetoth[1 FOR 9]. /*-- Lukkana M. A52-0318 26/11/2009 --*/
        
          EXPORT DELIMITER ";" "Summary of Bal. O/S : " + nv_RptName + " " + nv_RptTyp1
              "ไม่เกิน 15 วัน = " + STRING(nv_Tprem[1]  ,">>,>>>,>>>,>>9.99-") + nv-1 +    
              "16 - 30 วัน = "    + STRING(nv_Tprem[2]  ,">>,>>>,>>>,>>9.99-") + nv-1 +    
              "31 - 45 วัน = "    + STRING(nv_Tprem[3]  ,">>,>>>,>>>,>>9.99-") + nv-1 + 
              "46 - 60 วัน = "    + STRING(nv_Tprem[4]  ,">>,>>>,>>>,>>9.99-") + nv-1 +
              "61 - 90 วัน = "    + STRING(nv_Tprem[5]  ,">>,>>>,>>>,>>9.99-") + nv-1 +
              "91 - 180 วัน = "   + STRING(nv_Tprem[6]  ,">>,>>>,>>>,>>9.99-") + nv-1 +
              "181 - 270 วัน = "  + STRING(nv_Tprem[7]  ,">>,>>>,>>>,>>9.99-") + nv-1 +
              "271 - 365 วัน = "  + STRING(nv_Tprem[8]  ,">>,>>>,>>>,>>9.99-") + nv-1 +
              "365 วันขึ้นไป = "  + STRING(nv_Tprem[9] ,">>,>>>,>>>,>>9.99-") .
              
        OUTPUT CLOSE.
        END A54-0119 ------------*/

        /*---A54-0119---*/
        OUTPUT TO VALUE (n_OutputFileSum) APPEND NO-ECHO.  /* DISPLAY SUMMARY */
          EXPORT DELIMITER ";"  "".
          EXPORT DELIMITER ";"  "Summary of : " + nv_RptName + " " + nv_RptTyp1 + " - " + nv_RptTyp2.

          EXPORT DELIMITER ";"  nv_RptName + " Premium"         nv_TTprem   
                                                                nv_Tprem[1 FOR 15].  
          EXPORT DELIMITER ";"  nv_RptName + " Commission"      nv_TTcomm  
                                                                nv_Tcomm[1 FOR 15].  
          EXPORT DELIMITER ";"  nv_RptName + " Bal. O/S"        nv_TTbal    
                                                                nv_Tbal[1 FOR 15].   
          EXPORT DELIMITER ";"  nv_RptName + " Cheque Returned" nv_TTretc   
                                                                nv_Tretc[1 FOR 15]. 
          EXPORT DELIMITER ";"  nv_RptName + " Suspense"        nv_TTsusp   
                                                                nv_Tsusp[1 FOR 15].  
          EXPORT DELIMITER ";"  nv_RptName + " Net. A/R"        nv_TTnetar  
                                                                nv_Tnetar[1 FOR 15]. 
          EXPORT DELIMITER ";"  nv_RptName + " Net. OTHER"      nv_TTnetoth 
                                                                nv_Tnetoth[1 FOR 15]. 
        
          EXPORT DELIMITER ";" "Summary of Bal. O/S : " + nv_RptName + " " + nv_RptTyp1
              "ไม่เกิน 15 วัน = " + STRING(nv_Tprem[1]  ,">>,>>>,>>>,>>9.99-") + nv-1 +    
              "16 - 30 วัน = "    + STRING(nv_Tprem[2]  ,">>,>>>,>>>,>>9.99-") + nv-1 +    
              "31 - 45 วัน = "    + STRING(nv_Tprem[3]  ,">>,>>>,>>>,>>9.99-") + nv-1 + 
              "46 - 60 วัน = "    + STRING(nv_Tprem[4]  ,">>,>>>,>>>,>>9.99-") + nv-1 +
              "61 - 90 วัน = "    + STRING(nv_Tprem[5]  ,">>,>>>,>>>,>>9.99-") + nv-1 +
              "91 - 120 วัน = "   + STRING(nv_Tprem[6]  ,">>,>>>,>>>,>>9.99-") + nv-1 +
              "121 - 150 วัน = "  + STRING(nv_Tprem[7]  ,">>,>>>,>>>,>>9.99-") + nv-1 +
              "151 - 180 วัน = "  + STRING(nv_Tprem[8]  ,">>,>>>,>>>,>>9.99-") + nv-1 +
              "181 - 210 วัน = "  + STRING(nv_Tprem[9]  ,">>,>>>,>>>,>>9.99-") + nv-1 +
              "211 - 240 วัน = "  + STRING(nv_Tprem[10] ,">>,>>>,>>>,>>9.99-") + nv-1 +  
              "241 - 270 วัน = "  + STRING(nv_Tprem[11] ,">>,>>>,>>>,>>9.99-") + nv-1 +  
              "271 - 300 วัน = "  + STRING(nv_Tprem[12] ,">>,>>>,>>>,>>9.99-") + nv-1 +  
              "301 - 330 วัน = "  + STRING(nv_Tprem[13] ,">>,>>>,>>>,>>9.99-") + nv-1 +  
              "331 - 365 วัน = "  + STRING(nv_Tprem[14] ,">>,>>>,>>>,>>9.99-") + nv-1 +  
              "365 วันขึ้นไป = "  + STRING(nv_Tprem[15] ,">>,>>>,>>>,>>9.99-"). 
              
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
                nv_tot_balDet[11]
                nv_tot_balDet[12]
                nv_tot_balDet[13]
                nv_tot_balDet[14]
                nv_tot_balDet[15]
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
           /* DO i = 1 to 15 : ---A53-0159---*/
          /*---A54-0119--
           DO i = 1 to 11 :
           -----*/
           DO i = 1 to 15 :
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
