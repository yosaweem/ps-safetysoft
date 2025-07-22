/************************************ 
/* Create By : Kanchana C.             A46-0348    02/08/2003  */
Program : wacr0201.i  
Main Program :  wacr0201.w

    - ให้เลือก Type ได้ว่า จะเอา Type อะไรบ้าง  จะได้ดึง เฉพาะที่เป็นงาน Direct
    - default trnty1  = "M,R,A,B,Y,Z"
    - Client type = ALL
***************************************/
                  
        n_asdat = IF nv_asdatAging = ? THEN n_asdat ELSE nv_asdatAging.

        ASSIGN
            n_wcr  = 0
            n_damt = 0
            n_odue = 0
            n_odue1 = 0
            n_odue2 = 0
            n_odue3 = 0
            n_odue4 = 0
            n_odue5 = 0

            n_odmonth1  = 0   n_odmonth2  = 0  n_odmonth3  = 0 n_odmonth4  = 0
            n_odDay1    = 0    n_odDay2    = 0   n_odDay3    = 0   n_odDay4    = 0
            n_odat1        = ?   n_odat2        = ?  n_odat3       = ?   n_odat4         = ?.
            
      /*------------------ หา  ใน  uwm100  ---------------*/

        n_expdat    = ?.

        /* หา n_expdat  */
        FIND FIRST uwm100 WHERE uwm100.policy = agtprm_fil.policy   AND
                                                           uwm100.endno  = agtprm_fil.endno  NO-LOCK NO-ERROR.
        IF AVAIL uwm100 THEN DO:
                n_expdat     = uwm100.expdat.
        END.  /* avail  uwm100*/

/**********  คำนวน 
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
           n_odat1 =   agtprm_fil.duedat  +  n_odDay1  /* ได้วันที่วันสุดท้ายในช่วง*/
           n_odat2 =   agtprm_fil.duedat  + n_odDay2
           n_odat3 =   agtprm_fil.duedat  + n_odDay3
           n_odat4 =   agtprm_fil.duedat  + n_odDay4 .
     /*================== เปรียบเทียบวันที่ As Date กับ duedat & odat1-4 (over due date) ===*/
            IF /*n_day <> 0  AND*/ n_asdat <= (agtprm_fil.duedat - fuMaxDay(agtprm_fil.duedat)) THEN DO:  /* เทียบ asdate กับ  วันทีสุดท้าย  ก่อนเดือนสุดท้าย*/
                n_wcr = n_wcr + agtprm_fil.bal .                  /* with in credit  ไม่ครบกำหนดชำระ */
            END.
            IF n_asdat > (agtprm_fil.duedat - fuMaxDay(agtprm_fil.duedat)) AND n_asdat <= agtprm_fil.duedat THEN DO:   /*เทียบ asdate กับวันที่ในช่วงเดือนสุดท้าย*/
                n_damt = n_damt + agtprm_fil.bal .             /* due Amout  ครบกำหนดชำระ*/
            END.
           /*-------------------------------*/ 
            IF n_asdat > agtprm_fil.duedat AND n_asdat <= n_odat1 THEN DO:
                    n_odue1 = n_odue1 +  agtprm_fil.bal.         /*  overdue 1- 3 months*/
            END.
            IF n_asdat > n_odat1 AND n_asdat <= n_odat2 THEN DO:
                    n_odue2 = n_odue2 +  agtprm_fil.bal.         /*  overdue 3 - 6 months*/
            END.
            IF n_asdat > n_odat2 AND n_asdat <= n_odat3 THEN DO:
                    n_odue3 = n_odue3 +  agtprm_fil.bal.         /*  overdue 6 - 9 months*/
            END.
            IF n_asdat > n_odat3 AND n_asdat <= n_odat4 THEN DO:
                    n_odue4 = n_odue4 +  agtprm_fil.bal.         /*  overdue 9 - 12 months*/
            END.
            IF n_asdat > n_odat4 THEN DO:
                    n_odue5 = n_odue5 +  agtprm_fil.bal.        /*  over 12  months*/
            END.
            
            n_odue = n_odue1 + n_odue2 + n_odue3 + n_odue4 + n_odue5 .

จบ การคำนวน **********/

/********************** Group Header *********************/    
        OUTPUT TO VALUE (STRING(fiFile-Name) ) APPEND NO-ECHO.
             IF FIRST-OF(agtprm_fil.acno)  THEN DO:  /**/
                EXPORT DELIMITER ";"
                    "Acno : " + agtprm_fil.acno
                    agtprm_fil.ac_name
                    "Credit day : " +  STRING(agtprm_fil.credit)
                    "Credit Limit " + STRING(agtprm_fil.odue6,"->>>,>>>,>>>,>>9.99")    /*xmm600.ltamt   Credit Limit*/
                    agtprm_fil.acno_clicod
                    "Type : " + agtprm_fil.type.

                ASSIGN
                    nv_tot_prem = 0
                    nv_tot_prem_comp = 0
                    nv_tot_stamp = 0
                    nv_tot_tax = 0
                    nv_tot_gross = 0
                    nv_tot_comm = 0
                    nv_tot_comm_comp = 0
                    nv_tot_net = 0
                    nv_tot_bal = 0

                    nv_tot_wcr = 0
                    nv_tot_damt = 0
                    nv_tot_odue = 0
                    
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
                    n_expdat 
                    /*agtprm_fil.insure*/
                    agtprm_fil.prem
                    agtprm_fil.prem_comp
                    agtprm_fil.stamp
                    agtprm_fil.tax
                    agtprm_fil.gross
                    agtprm_fil.comm
                    agtprm_fil.comm_comp
                    n_net
                    agtprm_fil.bal

                    agtprm_fil.wcr
                    agtprm_fil.damt
                    agtprm_fil.odue
                    agtprm_fil.odue1
                    agtprm_fil.odue2 
                    agtprm_fil.odue3
                    agtprm_fil.odue4
                    agtprm_fil.odue5.

/********************** Group Footer *********************/    
                ASSIGN
                /* TOTAL */
                    nv_tot_prem             = nv_tot_prem + agtprm_fil.prem
                    nv_tot_prem_comp =  nv_tot_prem_comp + agtprm_fil.prem_comp
                    nv_tot_stamp            = nv_tot_stamp + agtprm_fil.stamp
                    nv_tot_tax                 = nv_tot_tax + agtprm_fil.tax
                    nv_tot_gross            = nv_tot_gross + agtprm_fil.gross
                    nv_tot_comm           = nv_tot_comm +  agtprm_fil.comm
                    nv_tot_comm_comp =  nv_tot_comm_comp + agtprm_fil.comm_comp
                    nv_tot_net                = nv_tot_net + n_net
                    nv_tot_bal                = nv_tot_bal + agtprm_fil.bal

                    nv_tot_wcr          = nv_tot_wcr + agtprm_fil.wcr
                    nv_tot_damt       = nv_tot_damt + agtprm_fil.damt
                    nv_tot_odue     = nv_tot_odue + agtprm_fil.odue

                    nv_tot_odue1     = nv_tot_odue1 + agtprm_fil.odue1
                    nv_tot_odue2      = nv_tot_odue2 + agtprm_fil.odue2
                    nv_tot_odue3      = nv_tot_odue3 + agtprm_fil.odue3
                    nv_tot_odue4     = nv_tot_odue4 + agtprm_fil.odue4
                    nv_tot_odue5     = nv_tot_odue5 + agtprm_fil.odue5.

             IF LAST-OF(agtprm_fil.acno)  THEN DO:  /**/
                EXPORT DELIMITER ";"
                    "TOTAL : " + agtprm_fil.acno
                    " "    " "   " "   " "   " "
                    " "    " "   " "   " "   " "  /*" "*/
                    nv_tot_prem
                    nv_tot_prem_comp
                    nv_tot_stamp
                    nv_tot_tax
                    nv_tot_gross
                    nv_tot_comm
                    nv_tot_comm_comp
                    nv_tot_net
                    nv_tot_bal

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
                    nv_gtot_prem             = nv_gtot_prem +  nv_tot_prem
                    nv_gtot_prem_comp =  nv_gtot_prem_comp + nv_tot_prem_comp
                    nv_gtot_stamp            = nv_gtot_stamp + nv_tot_stamp
                    nv_gtot_tax                 = nv_gtot_tax + nv_tot_tax
                    nv_gtot_gross            = nv_gtot_gross + nv_tot_gross
                    nv_gtot_comm           = nv_gtot_comm + nv_tot_comm
                    nv_gtot_comm_comp =  nv_gtot_comm_comp + nv_tot_comm_comp
                    nv_gtot_net                = nv_gtot_net + nv_tot_net
                    nv_gtot_bal                = nv_gtot_bal + nv_tot_bal

                    nv_gtot_wcr          = nv_gtot_wcr + nv_tot_wcr
                    nv_gtot_damt       = nv_gtot_damt + nv_tot_damt
                    nv_gtot_odue     = nv_gtot_odue + nv_tot_odue

                    nv_gtot_odue1     = nv_gtot_odue1 + nv_tot_odue1
                    nv_gtot_odue2      = nv_gtot_odue2 + nv_tot_odue2
                    nv_gtot_odue3      = nv_gtot_odue3 + nv_tot_odue3
                    nv_gtot_odue4     = nv_gtot_odue4 + nv_tot_odue4
                    nv_gtot_odue5     = nv_gtot_odue5 + nv_tot_odue5.

             END.

                    vCount = vCount + 1.

        OUTPUT CLOSE.


