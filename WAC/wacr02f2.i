/************************************ 
/* Create  By : Kanchana C.                       A46-0019    13/01/2003  */
    Program     :  wacr02f2.i - Print Statement A4  to File for FN Full
    Main program :    wacr02.w
    
        output --> ออก text    เข้า File Excel 
        choice       4. File for FN Full

/* Modify : Kanchana C.  21/04/2004    Assign No.  :   A47-0142 */
    - ปรับ การออกรายงาน Statement A4
    1. เพิ่ม Column ที่มีการ Print VAT แล้ว จะให้ พิมพ์ อักษร  V   ออกมาในรายงาน
    2. เพิ่ม   หมวด client type      LS  (Law  Suit)
    3. เพิ่ม report output to excel ให้แบ่งการ  sort  เป็น 2 ส่วน
      3.1  by transaction
      3.2  by policy

/* Modify : Kanchana C.  12/05/2005    Assign No.  :   A48-0250  */
    - ขอเพิ่ม Column ข้อมูลใน Statement บน Safety Soft  to Excel File 
    ให้เหมือนกับ Statement บน Premium โดยเฉพาะให้มี Column "Agent Code"
    
/* Modify : Piyachat p. 12/09/2008  Assign No.  : A51-0203  */
     - ขอเพิ่มช่องข้อมูลของผู้รับผลประโยชน์  
     
/* Modify : Sayamol N.  05/07/2010  A53-0159*/
   - เพิ่มคอลัมน์ Group , Customer Type 
   - แยกงาน Motor , Non Motor       
 
/* Modify : Sayamol N.    12/09/2011 A54-0270 
   - แก้ไขคอลัมน์ Overdue Day   คิดจาก overdue day = As date - Due Date
     เดิม Today - Due Date
*/
/* Modify : Sayamol N.  17/07/2012  A55-0231 
   - แก้ไขหัวคอลัมน์ 90-365 days เป็น 91-365 days
   - กรณี As Date <= Due Date ให้ยอดเงินอยู่ในช่อง within
     add Parameter mday for calculate Motor (บวกเพิ่มอีก 15 วัน)
   - รายงาน Motor ไม่ต้องแยก Compulsory
*/
/*Modify by Sayamol N. A57-0102 แยกค่า CAT ลงคอลัมน์ Compulsory 25/03/2013 */
/*Modify By : chonlatis J.  05/10/2017 (A60-0431)
            เพิ่ม Column product */
 /*Modify By : kirtsadang p. 24/05/2018 (A61-0158)*/
            
**************************************/

        n_asdat = IF nv_asdatAging = ? THEN n_asdat ELSE nv_asdatAging.

        ASSIGN
            n_wcr   = 0
            n_damt  = 0
            n_odue  = 0
            n_odue1 = 0
            n_odue2 = 0
            n_odue3 = 0
            n_odue4 = 0
            n_odue5 = 0

            n_odmonth1 = 0  n_odmonth2 = 0  n_odmonth3 = 0  n_odmonth4 = 0
            n_odDay1   = 0  n_odDay2   = 0  n_odDay3   = 0  n_odDay4   = 0
            n_odat1    = ?  n_odat2    = ?  n_odat3    = ?  n_odat4    = ?
            
            n_prnVat  = ""     /* A47-0142*/
            n_benname = "" /* A51-0203 */
            .

      /*------------------ หา  ใน  uwm100  ---------------*/
        ASSIGN
            n_expdat = ?
            n_campol = ""
            n_cedpol = ""
            n_dealer = ""
            n_gpstmt = ""
            n_opened = ?
            n_closed = ?
            n_insur  = ""
            n_product = "" /*chonlatis j.04/10/2017 A60-0431*/ 
            n_promon ="".  /*kirtsadang p. 24/05/2018*/
            
            
        /* หา n_expdat ,  n_campol,   n_cedpol*/
        FIND FIRST uwm100 WHERE uwm100.policy = agtprm_fil.policy   AND
                                uwm100.endno  = agtprm_fil.endno  NO-LOCK NO-ERROR.
        IF AVAIL uwm100 THEN DO:
            ASSIGN
                n_expdat = uwm100.expdat
                n_campol = uwm100.opnpol
                n_cedpol = uwm100.cedpol
                n_product = uwm100.cr_1  /*Chonlatis j. 04/10/2017 A60-0431*/
                n_insur  = TRIM(uwm100.name1) + TRIM(uwm100.name2)
                n_promon = uwm100.opnpol. /*kirtsadang p. 24/05/2018 A61-0158*/
                
               

        /* หา n_dealer   n_gpstmt   n_opened   n_closed*/
            FIND FIRST bxmm600 WHERE bxmm600.acno = uwm100.finint NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL bxmm600 THEN  DO:
                ASSIGN
                    n_dealer = bxmm600.name
                    n_gpstmt = bxmm600.gpstmt
                    n_opened = bxmm600.opened
                    n_closed = bxmm600.closed.
            END.
            ELSE DO:
                ASSIGN
                    n_dealer = ""
                    n_gpstmt = ""
                    n_opened = ?
                    n_closed = ?.
            END.
            
        /* หา n_campol*/
            IF  (SUBSTR(uwm100.policy,3,2) = "70"  OR
                 SUBSTR(uwm100.policy,3,2) = "72"  OR
                 SUBSTR(uwm100.policy,3,2) = "73") THEN DO:
            
                IF  SUBSTR(uwm100.opnpol,3,2) = "72"  THEN    /* 70  พ่วง 72 */
                     n_campol  = "".
            END.
            
        /* หา n_chano, n_moddes, n_veh, n_sckno*/
        /*p------*/

        FIND FIRST uwm301 USE-INDEX uwm30101     WHERE
                     uwm301.policy = uwm100.policy  AND
                     uwm301.rencnt = uwm100.rencnt  AND
                     uwm301.endcnt = uwm100.endcnt  NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL uwm301 THEN DO:
            ASSIGN
                n_moddes  = uwm301.moddes
                n_chano   = uwm301.cha_no
                n_veh     = uwm301.vehreg
                n_benname = uwm301.mv_ben83. /* A51-0203 */
 
            IF uwm301.sckno <> 000000000 AND
                    uwm301.sckno <> 999999999 THEN DO:
                    
                    nvw_sticker = uwm301.sckno.
                    IF SUBSTRING(string(nvw_sticker,"9999999999"),1,1) = "0" 
                    THEN  chr_sticker = "2" + STRING(nvw_sticker,"999999999").
                    ELSE  chr_sticker = STRING(nvw_sticker,"9999999999").
                    
                    RUN wuz\wuzckmod .
                    
                    n_sckno = chr_sticker.
            END. /* end if sckno */
        END. /*uwm301*/
        ELSE
           ASSIGN
               n_moddes  = ""
               n_chano   = ""
               n_sckno   = ""
               n_veh     = ""
               n_benname = "".  /* A51-0203 */
        /*-----p*/

        /* A47-0227     หา เลขตัวถัง ยีห้อ  ใน line 30 */
   
       IF SUBSTR(uwm100.policy,3,2) = "30" THEN DO:

            nv_fptr = uwm100.fptr01.
        
            DO WHILE nv_fptr <> 0 AND uwm100.fptr01 <> ?:
        
              FIND uwd100 WHERE RECID(uwd100) = nv_fptr NO-LOCK NO-ERROR NO-WAIT.
        
              IF AVAILABLE uwd100 THEN DO:
                    nv_fptr = uwd100.fptr.
    
                    IF INDEX(uwd100.ltext ,"ยี่ห้อรถ") <> 0 THEN
                        n_moddes = TRIM(TRIM(SUBSTRING(uwd100.ltext,19,20)) + " " +
                                                    TRIM(SUBSTRING(uwd100.ltext,57,25))).
           
                    IF INDEX(uwd100.ltext ,"เลขที่ตัวรถ") <> 0 THEN
                        n_chano = SUBSTRING(uwd100.ltext,19,21).
                    
                    IF INDEX(uwd100.ltext ,"ผู้รับผลประโยชน์") <> 0 THEN
                       n_benname = TRIM(trim(SUBSTRING(uwd100.ltext,20,35))). /* A51-0203 */
        
              END.   /*  IF AVAILABLE uwd100  */
              ELSE nv_fptr = 0.

            END.  /*  DO WHILE nv_fptr <> 0 AND uwm100.fptr01 <> ?  */

        END.   /* Line 30 */

        END.  /* avail  uwm100*/
        
    /*--- 47-0142 */
        IF  (agtprm_fil.trntyp BEGINS "M") OR (agtprm_fil.trntyp BEGINS "R")  THEN DO:

            IF (SUBSTR(agtprm_fil.policy,5,2) = "99"     OR
                SUBSTR(agtprm_fil.policy,5,2) >= "43"  ) AND    /* เช็คปี */
                LOOKUP(SUBSTR(agtprm_fil.policy,3,2),n_prnvat ) = 0  THEN DO:  /* หาเฉพาะที่ไม่เป็น Line PA  ("60,61,62,63,64,67")   เพราะ PA ไม่มี vat */

                    FIND FIRST vat100 NO-LOCK USE-INDEX vat10002 
                            WHERE vat100.policy = agtprm_fil.policy            AND
                                  vat100.trnty1 = SUBSTR(agtprm_fil.trnty,1,1) AND
                                  vat100.refno  = agtprm_fil.docno       NO-ERROR.
                    IF AVAIL  vat100 THEN
                         n_prnvat = "V".
                    ELSE n_prnvat = " ".

            END.  /* หาเฉพาะที่ไม่เป็น Line PA */
        
        END.
    
    /* 47-0142 ---*/

    /*--- A48-0250 */
        /*---find claim ------------*/
        ASSIGN
            tt_res    = 0
            tt_paid   = 0
            tt_outres = 0.

        FOR EACH  clm100  NO-LOCK USE-INDEX clm10002  WHERE
                  clm100.policy = agtprm_fil.policy.

           FOR EACH clm120 WHERE clm120.claim = clm100.claim
               NO-LOCK BREAK BY clm120.claim :
                ASSIGN
                    nv_res    = 0
                    nv_paid   = 0
                    nv_outres = 0.

               FOR EACH clm131 NO-LOCK
                  WHERE clm131.claim  = clm120.claim
                    AND clm131.clmant = clm120.clmant
                    AND clm131.clitem = clm120.clitem
                    AND clm131.cpc_cd = "EPD".

                  IF clm131.res <> ? THEN nv_res = nv_res + clm131.res.

               END. /* clm131 */

               FOR EACH clm130 NO-LOCK
                  WHERE clm130.claim  = clm120.claim
                    AND clm130.clmant = clm120.clmant
                    AND clm130.clitem = clm120.clitem
                    AND clm130.cpc_cd = "EPD".

                  IF clm130.netl_d <> ? THEN nv_paid = nv_paid + clm130.netl_d.

               END. /* clm130 */

               IF clm120.styp20 <> "X" AND clm120.styp20 <> "F"  THEN DO:
                  IF  nv_res > 0      THEN DO:
                      IF  nv_res > nv_paid  THEN DO:
                          ASSIGN
                            nv_outres = nv_res - nv_paid
                            tt_outres = tt_outres + nv_outres.
                      END.  /* nv_res > nv_paid */
                  END.  /* nv_res > 0 */
               END.  /* styp20 */

               ASSIGN
                  tt_res   = tt_res + nv_res
                  tt_paid  = tt_paid + nv_paid.

               ASSIGN
                  nv_res    = 0
                  nv_paid   = 0
                  nv_outres = 0.

           END. /* clm120 */

        END.   /* clm100  */
        /* ------------ */
    /* A48-0250 ---*/


       /*-----A53-0159---- 
      /*------------------ หาจำนวนวันใน 3 , 6 , 9 , 12 เดือน --------------------*/
           i = 0. 
           DO i = 0  TO 2  :   /* over due 1 - 3*/
                 n_odmonth1 = IF (MONTH(agtprm_fil.duedat ) + i )   MOD 12 = 0 THEN 1 ELSE (MONTH(agtprm_fil.duedat ) + i )   MOD 12.
                 n_odDay1 =  n_odDay1 + fuNumMonth(n_odmonth1, agtprm_fil.duedat ).
           END.
           i = 0.      
           DO i = 0  TO 5  :   /* over due 3 - 6*/
                 n_odmonth2  =  IF (MONTH(agtprm_fil.duedat ) + i )   MOD 12 = 0 THEN 1 ELSE (MONTH(agtprm_fil.duedat ) + i )   MOD 12.
                 n_odDay2 =  n_odDay2 + fuNumMonth(n_odmonth2, agtprm_fil.duedat ).
           END.
           i = 0.      
           DO i = 0  TO 8  :   /* over due 6 - 9*/
                 n_odmonth3  =  IF (MONTH(agtprm_fil.duedat ) + i )   MOD 12 = 0 THEN 1 ELSE (MONTH(agtprm_fil.duedat ) + i )   MOD 12.
                 n_odDay3 =  n_odDay3 + fuNumMonth(n_odmonth3, agtprm_fil.duedat ).
           END. 
           i = 0.
           DO i = 0  TO 11  :   /* over due 9 - 12*/
                 n_odmonth4  =  IF (MONTH(agtprm_fil.duedat ) + i )   MOD 12 = 0 THEN 1 ELSE (MONTH(agtprm_fil.duedat ) + i )   MOD 12.
                 n_odDay4 =  n_odDay4 + fuNumMonth(n_odmonth4, agtprm_fil.duedat ).
           END.
     /*-------------- duedat + จำนวนวันใน 3 , 6 , 9 , 12 เดือน   --------------*/
     ASSIGN
           n_odat1 = agtprm_fil.duedat  +  n_odDay1  /* ได้วันที่วันสุดท้ายในช่วง*/
           n_odat2 = agtprm_fil.duedat  + n_odDay2
           n_odat3 = agtprm_fil.duedat  + n_odDay3
           n_odat4 = agtprm_fil.duedat  + n_odDay4 .
---end A53-0159 ----------*/
        /*---A53-0159---*/
        ASSIGN
           n_odat1 = agtprm_fil.duedat  + 30  /* ได้วันที่วันสุดท้ายในช่วง*/
           n_odat2 = agtprm_fil.duedat  + 60
           n_odat3 = agtprm_fil.duedat  + 90
           n_odat4 = agtprm_fil.duedat  + 365.


        /*---A55-0231---*/
        IF nv_polgrp = "MOT" THEN mday = 15.
        ELSE mday = 0.
        /*---------------*/

     /*================== เปรียบเทียบวันที่ As Date กับ duedat & odat1-4 (over due date) ===*/
            IF /*n_day <> 0  AND*/ n_asdat <= (agtprm_fil.duedat - fuMaxDay(agtprm_fil.duedat) + mday) THEN DO:  /* เทียบ asdate กับ  วันทีสุดท้าย  ก่อนเดือนสุดท้าย*/
                n_wcr = n_wcr + agtprm_fil.bal .                  /* with in credit  ไม่ครบกำหนดชำระ */
            END.
            IF n_asdat > (agtprm_fil.duedat - fuMaxDay(agtprm_fil.duedat) + mday) AND n_asdat <= agtprm_fil.duedat THEN DO:   /*เทียบ asdate กับวันที่ในช่วงเดือนสุดท้าย*/
                n_damt = n_damt + agtprm_fil.bal .             /* due Amout  ครบกำหนดชำระ*/
            END.
           /*-------------------------------*/ 
            IF n_asdat > agtprm_fil.duedat AND n_asdat <= n_odat1 THEN DO:
                    n_odue1 = n_odue1 +  agtprm_fil.bal.         /* 1-30 days */  /* เดิม  overdue 1- 3 months*/
            END.
            IF n_asdat > n_odat1 AND n_asdat <= n_odat2 THEN DO:
                    n_odue2 = n_odue2 +  agtprm_fil.bal.         /*31-60 days */  /* เดิม overdue 3 - 6 months*/
            END.
            IF n_asdat > n_odat2 AND n_asdat <= n_odat3 THEN DO:
                    n_odue3 = n_odue3 +  agtprm_fil.bal.         /*61-90 days*/   /* เดิม overdue 6 - 9 months*/
            END.
            IF n_asdat > n_odat3 AND n_asdat <= n_odat4 THEN DO:
                    n_odue4 = n_odue4 +  agtprm_fil.bal.         /*91-365 days */   /* เดิม overdue 9 - 12 months*/
            END.
            IF n_asdat > n_odat4 THEN DO:
                    n_odue5 = n_odue5 +  agtprm_fil.bal.        /*over 365 days */   /* เดิม over 12  months*/
            END.
            
            n_odue = n_odue1 + n_odue2 + n_odue3 + n_odue4 + n_odue5 .

            /*---A57-0102---*/
            FOR EACH uwm120 USE-INDEX uwm12001 WHERE 
                     uwm120.policy = uwm100.policy AND
                     uwm120.rencnt = uwm100.rencnt AND
                     uwm120.endcnt = uwm100.endcnt NO-LOCK.

                IF SUBSTR(agtprm_fil.policy,3,2) = "18" THEN DO:

                    IF uwm120.class = "F182" THEN DO:
                    
                       FIND FIRST uwm130 USE-INDEX uwm13001 WHERE
                                  uwm130.policy = uwm120.policy    AND
                                  uwm130.rencnt = uwm120.rencnt    AND
                                  uwm130.endcnt = uwm120.endcnt    AND 
                                  uwm130.riskno = uwm120.riskno    NO-LOCK.
                       IF AVAIL uwm130 THEN DO:
                    
                          IF uwm130.i_text = "NCF" THEN DO:
                             
                             FIND FIRST uwd132 USE-INDEX uwd13290 WHERE
                                        uwd132.policy = uwm130.policy AND
                                        uwd132.rencnt = uwm130.rencnt AND
                                        uwd132.endcnt = uwm130.endcnt AND
                                        uwd132.riskgp = uwm130.riskgp AND
                                        uwd132.riskno = uwm130.riskno AND
                                        uwd132.itemno = uwm130.itemno NO-LOCK NO-ERROR.
                             IF AVAIL uwd132 THEN DO:
                                n_prem_comp = n_prem_comp + uwm120.prem_r.
                             END.  
                          END.   /*---end if uwm130.i_text---*/ 
                       END.  /*---end if avail uwm130---*/
                    END.   /*---end class = "F182"---*/
                END.   /*---end Line "M18"---*/
            END.   /*---end for each uwm120*/
            /*---end A57-0102---*/

            
/********************** Group Header *********************/    
        OUTPUT TO VALUE (STRING(fiFile-Name) ) APPEND NO-ECHO.
        
             IF FIRST-OF(agtprm_fil.acno)  THEN DO:  /**/
        
             
                EXPORT DELIMITER ";" 
                    "Statment A4 : " + nv_repdetail.

                EXPORT DELIMITER ";"
                    "Acno : " + agtprm_fil.acno
                    agtprm_fil.ac_name
                    "Credit day : " +  STRING(agtprm_fil.credit)
                    "Credit Limit " + STRING(agtprm_fil.odue6,"->>>,>>>,>>>,>>9.99")    /*xmm600.ltamt   Credit Limit*/
                    agtprm_fil.acno_clicod
                    "Type : " + agtprm_fil.type.

                EXPORT DELIMITER ";"
                    "Trans Date  "      
                    "Policy      "      
                    "Endt No.    "      
                    "Com Date    "      
                    "Tran type   "      
                    "Doc No.     "      
                    "Agent       "      
                    "Customer    " 

                    "Premium     "      
                    /*"Compulsory  " ---A57-0102---*/
                    "Comp/CAT  "      /*A57-0102*/
                    "Stamp       "     
                    "Tax         "     
                    "Total       "     
                    "Comm  "     
                    "Net Amount  "     
                    "Balance O/S "     
                    "Vehicle Reg."     
                    "Print Vat   "     
                    "Producer       "  
                 /***** สิ้นสุด สำหรับตัดเบี้***/

                    "Producer Name  "  
                    "Sticker No.    "  
                    "Exp Date       "
                    "Chassis No.    "  
                    "Model Desc     "  
    
                    "Pol Bran      "  
                    "Producer Type  "  
                    "Credit Term    "  
                    "Due Date       "  
                    "As Date        "  
                    "Overdue Day    "  
                    "Pol Type       "  
                    "Campaign Pol   "  
                    "Dealer         "  
                    "Comm Motor     "  
                    "Comm Compulsory"  
                    "Claim Paid     "  
                    "O/S Claim      "  
                    
                    "Leasing No.    "  
                    "Within"  "Due amount "  "Overdue"  
                    /*---A53-0159---
                    "1-3 months"  "3-6 months"  "6-9 months"  "9-12 months"  ">12 months"
                    ------------*/
                    "1-30 days"  "31-60 days" "61-90 days" 
                    /*"90-365 days" ---By A55-0231---*/
                    "91-365 days"
                    "over 365 days"    /*---A53-0159---*/ 
                    "Benificiary name"  /* A51-0203 */ 
                    "Group"              /*A53-0159*/
                     "Customer Type"      /*A53-0159*/
                    "Product" /*Chonlatis j. 04/10/2017 A60-0431*/
                    "Promotion"  /*kirtsadang p. 24/05/2018 A61-0158*/
                    
                    
                    .
                 
                ASSIGN
                    nv_tot_prem      = 0
                    nv_tot_prem_comp = 0
                    nv_tot_stamp     = 0
                    nv_tot_tax       = 0
                    nv_tot_gross     = 0
                    nv_tot_comm      = 0
                    nv_tot_comm_comp = 0
                    nv_tot_net       = 0
                    nv_tot_bal       = 0

                    nv_tot_wcr   = 0
                    nv_tot_damt  = 0
                    nv_tot_odue  = 0
                    
                    nv_tot_odue1 = 0
                    nv_tot_odue2 = 0
                    nv_tot_odue3 = 0
                    nv_tot_odue4 = 0
                    nv_tot_odue5 = 0.
             END.
             
/********************** DETAIL *********************/
                ASSIGN
                    n_net = 0
                    n_net = (agtprm_fil.gross +  agtprm_fil.comm + agtprm_fil.comm_comp).

/*---A48-0250
                EXPORT DELIMITER ";"
                    agtprm_fil.acno
                    agtprm_fil.ac_name
                    agtprm_fil.polbran
                    agtprm_fil.credit
                    agtprm_fil.trndat
                    agtprm_fil.duedat
                    agtprm_fil.trntyp + " " +  agtprm_fil.docno
                    agtprm_fil.policy
                    agtprm_fil.endno
                    agtprm_fil.comdat
                    n_expdat
                    agtprm_fil.insure
                    agtprm_fil.prem
                    agtprm_fil.prem_comp
                    agtprm_fil.stamp
                    agtprm_fil.tax
                    agtprm_fil.gross
                    agtprm_fil.comm
                    agtprm_fil.comm_comp
                    n_net
                    agtprm_fil.bal

                    n_campol
                    n_dealer
                    n_veh
                    n_chano
                    n_moddes
                    n_sckno
                    n_cedpol
                    
                    n_prnvat        /* A47-0142 */
                    n_wcr
                    n_damt
                    n_odue
                    n_odue1
                    n_odue2 
                    n_odue3
                    n_odue4
                    n_odue5.
/* 
                    n_gpstmt 
                    n_opened
                    n_closed.
*/
A48-0250 ---*/
/*---A48-0250 ---*/

                 /*---A53-0159---*/
                ASSIGN nv_dir = ""
                       nv_polgrp = ""
                       nv_grptypdes = "".

                RUN pdDeptGrp.
                RUN pdCredit.

                /*---A57-0102---*/
                EXPORT DELIMITER ";"
                    agtprm_fil.trndat
                    agtprm_fil.policy
                    agtprm_fil.endno
                    agtprm_fil.comdat
                    agtprm_fil.trntyp
                    "'" + agtprm_fil.docno
                    agtprm_fil.agent
                    n_insur          /* agtprm_fil.insure */
                    /*------A57-0102---
                    agtprm_fil.prem  
                    agtprm_fil.prem_comp 
                    -----*/
                    IF SUBSTR(agtprm_fil.Policy,3,2) = "18" THEN agtprm_fil.prem - n_prem_comp ELSE agtprm_fil.prem   /*A57-0102*/
                    IF SUBSTR(agtprm_fil.Policy,3,2) = "18" THEN n_prem_comp ELSE agtprm_fil.prem_comp   /*A57-0102*/
                    agtprm_fil.stamp
                    agtprm_fil.tax
                    agtprm_fil.gross
                    agtprm_fil.comm + agtprm_fil.comm_comp
                    n_net          
                    agtprm_fil.bal 
                    n_veh
                    n_prnvat
                    agtprm_fil.acno
                /***** สิ้นสุด สำหรับตัดเบี้ย ***/

                    agtprm_fil.ac_name                        
                    n_sckno         /* sticker no.*/
                    n_expdat
                    n_chano 
                    n_moddes

                    agtprm_fil.polbran
                    
                    agtprm_fil.acno_clicod
                    /*agtprm_fil.credit*/   /*A55-0231*/
                    n_credittxt
                    agtprm_fil.duedat
                    agtprm_fil.asdat
                    /*---A54-0270---
                    IF agtprm_fil.duedat >= TODAY THEN 0 ELSE TODAY - agtprm_fil.duedat /* overdue day */
                    -------------*/                                                                      
                    /*IF agtprm_fil.duedat >= n_trndatto THEN 0 ELSE n_trndatto - agtprm_fil.duedat /* overdue day */ */
                    IF agtprm_fil.duedat >= n_asdat THEN 0 ELSE n_asdat - agtprm_fil.duedat /* overdue day */
                    SUBSTRING(agtprm_fil.poltyp,2,2)
                    n_campol        /* campaign Pol.*/
                    n_dealer        /* dealer */
                    agtprm_fil.comm     
                    agtprm_fil.comm_comp
                    tt_paid         /* claim paid*/
                    tt_outres       /* o/s claim */
                    n_cedpol        /* leasing NO.*/
                    n_wcr   
                    n_damt  
                    n_odue  
                    n_odue1 
                    n_odue2 
                    n_odue3 
                    n_odue4 
                    n_odue5
                    n_benname  /* A51-0203 */
                    /*---A53-0159---*/
                      /*
                    SUBSTR(nv_dir,3,1) 
                    nv_polgrp.
                    */
                    SUBSTR(nv_polgrp,1,3)
                    SUBSTR(nv_dir,3,1)
                    n_product  /*Chonlatis j. 04/10/2017 A60-0431*/
                    n_promon.  /*kirtsadang p. 24/05/2018 A61-0158*/
                    
                  

/* A48-0250 END ---*/

/********************** Group Footer *********************/    
                ASSIGN
                /* TOTAL */
                    nv_tot_prem      = nv_tot_prem + agtprm_fil.prem
                    nv_tot_prem_comp = nv_tot_prem_comp + agtprm_fil.prem_comp + n_prem_comp   /*A57-0102*/
                    nv_tot_stamp     = nv_tot_stamp + agtprm_fil.stamp
                    nv_tot_tax       = nv_tot_tax + agtprm_fil.tax
                    nv_tot_gross     = nv_tot_gross + agtprm_fil.gross
                    nv_tot_comm      = nv_tot_comm +  agtprm_fil.comm
                    nv_tot_comm_comp = nv_tot_comm_comp + agtprm_fil.comm_comp
                    nv_tot_net       = nv_tot_net + n_net
                    nv_tot_bal       = nv_tot_bal + agtprm_fil.bal

                    nv_tot_wcr       = nv_tot_wcr  + n_wcr
                    nv_tot_damt      = nv_tot_damt + n_damt
                    nv_tot_odue      = nv_tot_odue + n_odue
                                     
                    nv_tot_odue1     = nv_tot_odue1 + n_odue1
                    nv_tot_odue2     = nv_tot_odue2 + n_odue2
                    nv_tot_odue3     = nv_tot_odue3 + n_odue3
                    nv_tot_odue4     = nv_tot_odue4 + n_odue4
                    nv_tot_odue5     = nv_tot_odue5 + n_odue5.

                ASSIGN n_prem_comp = 0.   /*A57-0102*/

             IF LAST-OF(agtprm_fil.acno)  THEN DO:  /**/
                EXPORT DELIMITER ";"
                    "TOTAL : " + agtprm_fil.acno
                    ""  ""  ""  ""  ""
                    ""  ""   
                    nv_tot_prem
                    nv_tot_prem_comp
                    nv_tot_stamp
                    nv_tot_tax
                    nv_tot_gross
                    nv_tot_comm  + nv_tot_comm_comp
                    nv_tot_net
                    nv_tot_bal
                    ""  ""

                    ""  ""  ""  ""  ""  ""  ""  ""  ""  ""    
                    ""  ""  ""  ""  ""  ""  ""  ""  ""  ""

                    nv_tot_wcr
                    nv_tot_damt
                    nv_tot_odue

                    nv_tot_odue1
                    nv_tot_odue2
                    nv_tot_odue3
                    nv_tot_odue4
                    nv_tot_odue5.


               /* GRAND TOTAL*/
               ASSIGN
                    nv_gtot_prem      = nv_gtot_prem +  nv_tot_prem
                    nv_gtot_prem_comp = nv_gtot_prem_comp + nv_tot_prem_comp
                    nv_gtot_stamp     = nv_gtot_stamp + nv_tot_stamp
                    nv_gtot_tax       = nv_gtot_tax + nv_tot_tax
                    nv_gtot_gross     = nv_gtot_gross + nv_tot_gross
                    nv_gtot_comm      = nv_gtot_comm + nv_tot_comm
                    nv_gtot_comm_comp = nv_gtot_comm_comp + nv_tot_comm_comp
                    nv_gtot_net       = nv_gtot_net + nv_tot_net
                    nv_gtot_bal       = nv_gtot_bal + nv_tot_bal

                    nv_gtot_wcr       = nv_gtot_wcr  + nv_tot_wcr
                    nv_gtot_damt      = nv_gtot_damt + nv_tot_damt
                    nv_gtot_odue      = nv_gtot_odue + nv_tot_odue

                    nv_gtot_odue1     = nv_gtot_odue1 + nv_tot_odue1
                    nv_gtot_odue2     = nv_gtot_odue2 + nv_tot_odue2
                    nv_gtot_odue3     = nv_gtot_odue3 + nv_tot_odue3
                    nv_gtot_odue4     = nv_gtot_odue4 + nv_tot_odue4
                    nv_gtot_odue5     = nv_gtot_odue5 + nv_tot_odue5.

             END.

                    vCount = vCount + 1.

        OUTPUT CLOSE.


