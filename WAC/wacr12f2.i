/************************************ 
/* Create  By : Sayamol N.                      A53-0159    13/07/2010  */
    Program     :  wacr12f2.i - Print Statement A4  to File for FN Full
     Dupplicate From wacr02f2.i
    Main program :    wacr02.w
    
    output --> ออก text    เข้า File Excel 
    choice       4. File for FN Full
    
/*Modify by Sayamol N. A57-0102 แยกค่า CAT ลงคอลัมน์ Compulsory 25/03/2013 */    
************************************/
        RUN pdClsValue.

        n_asdat = IF nv_asdatAging = ? THEN n_asdat ELSE nv_asdatAging.
            
        /* หา n_expdat ,  n_campol,   n_cedpol*/
        FIND FIRST uwm100 WHERE uwm100.policy = agtprm_fil.policy   AND
                                uwm100.endno  = agtprm_fil.endno  NO-LOCK NO-ERROR.
        IF AVAIL uwm100 THEN DO:
            ASSIGN
                n_expdat = uwm100.expdat
                n_campol = uwm100.opnpol
                n_cedpol = uwm100.cedpol
                n_insur  = TRIM(uwm100.name1) + TRIM(uwm100.name2).

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

        RUN pdCalDuedate.

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
             IF FIRST-OF(agtprm_fil.acno)  THEN DO:  /**/
                 
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
                    nv_tot_odue5 = 0
                    nv_tot_odue6 = 0
                    nv_tot_odue7 = 0
                    nv_tot_odue8 = 0
                    nv_tot_odue9 = 0.
             END.
             
/********************** DETAIL *********************/
                ASSIGN
                    n_net = 0
                    n_net = (agtprm_fil.gross +  agtprm_fil.comm + agtprm_fil.comm_comp)
                 /*---A53-0159---*/
                    nv_dir = ""
                    nv_polgrp = ""
                    nv_grptypdes = "".

                RUN pdDeptGrp.
                RUN pdCredit.

                RUN pdExpDataF2.

                
/********************** Group Footer *********************/    
                ASSIGN
                /* TOTAL */
                    nv_tot_prem      = nv_tot_prem      + agtprm_fil.prem
                    nv_tot_prem_comp = nv_tot_prem_comp + agtprm_fil.prem_comp + n_prem_comp   /*A57-0102*/
                    nv_tot_stamp     = nv_tot_stamp     + agtprm_fil.stamp
                    nv_tot_tax       = nv_tot_tax       + agtprm_fil.tax
                    nv_tot_gross     = nv_tot_gross     + agtprm_fil.gross
                    nv_tot_comm      = nv_tot_comm      +  agtprm_fil.comm
                    nv_tot_comm_comp = nv_tot_comm_comp + agtprm_fil.comm_comp
                    nv_tot_net       = nv_tot_net       + n_net
                    nv_tot_bal       = nv_tot_bal       + agtprm_fil.bal
                    nv_tot_wcr       = nv_tot_wcr       + n_wcr
                    nv_tot_damt      = nv_tot_damt      + n_damt
                    nv_tot_odue      = nv_tot_odue      + n_odue       
                    nv_tot_odue1     = nv_tot_odue1     + n_odue1
                    nv_tot_odue2     = nv_tot_odue2     + n_odue2
                    nv_tot_odue3     = nv_tot_odue3     + n_odue3
                    nv_tot_odue4     = nv_tot_odue4     + n_odue4
                    nv_tot_odue5     = nv_tot_odue5     + n_odue5
                    nv_tot_odue6     = nv_tot_odue6     + n_odue6
                    nv_tot_odue7     = nv_tot_odue7     + n_odue7
                    nv_tot_odue8     = nv_tot_odue8     + n_odue8
                    nv_tot_odue9     = nv_tot_odue9     + n_odue9.
                
                ASSIGN n_prem_comp = 0.     /*A57-0102*/
                                

             IF LAST-OF(agtprm_fil.acno)  THEN DO:  /**/
                OUTPUT TO VALUE (STRING(fiFile-Name) ) APPEND NO-ECHO.
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
                    nv_tot_odue5
                    nv_tot_odue6
                    nv_tot_odue7
                    nv_tot_odue8
                    nv_tot_odue9
                    .
                OUTPUT CLOSE.

                /*---A53-0159---*/
                FOR EACH wtagtprm_fil NO-LOCK WHERE wtagtprm_fil.wtacno = agtprm_fil.acno.
                    OUTPUT TO VALUE (STRING(fiFile-Name) ) APPEND NO-ECHO.
                EXPORT DELIMITER ";"
                    "TOTAL : " + wtagtprm_fil.wtgrp + " - " +  wtagtprm_fil.wtacno
                    ""  ""  ""  ""  ""
                    ""  ""   
                    wtagtprm_fil.wtprem      
                    wtagtprm_fil.wtprem_comp 
                    wtagtprm_fil.wtstamp     
                    wtagtprm_fil.wttax       
                    wtagtprm_fil.wtgross     
                    wtagtprm_fil.wtcomm    + wtagtprm_fil.wtcomm_comp 
                    wtagtprm_fil.wtnet       
                    wtagtprm_fil.wtbal       
                    ""  ""

                    ""  ""  ""  ""  ""  ""  ""  ""  ""  ""    
                    ""  ""  ""  ""  ""  ""  ""  ""  ""  ""

                    wtagtprm_fil.wtwcr      
                    wtagtprm_fil.wtdamt     
                    wtagtprm_fil.wtodue     
                    wtagtprm_fil.wtodue1    
                    wtagtprm_fil.wtodue2    
                    wtagtprm_fil.wtodue3    
                    wtagtprm_fil.wtodue4    
                    wtagtprm_fil.wtodue5    
                    wtagtprm_fil.wtodue6    
                    wtagtprm_fil.wtodue7    
                    wtagtprm_fil.wtodue8    
                    wtagtprm_fil.wtodue9    
                    .
                OUTPUT CLOSE.

                /*----A53-0159---*/
            FIND FIRST wtGagtprm_fil WHERE wtGagtprm_fil.wtGgrp = wtagtprm_fil.wtgrp NO-ERROR.
                IF NOT AVAIL wtGagtprm_fil THEN DO:
                    CREATE wtGagtprm_fil.
                    ASSIGN wtGagtprm_fil.wtGgrp = wtagtprm_fil.wtgrp.
                    ASSIGN 
                        wtGagtprm_fil.wtGprem        =    wtagtprm_fil.wtprem                                 /* nv_tot_prem      */
                        wtGagtprm_fil.wtGprem_comp   =    wtagtprm_fil.wtprem_comp                            /* nv_tot_prem_comp */
                        wtGagtprm_fil.wtGstamp       =    wtagtprm_fil.wtstamp                                /* nv_tot_stamp     */
                        wtGagtprm_fil.wtGtax         =    wtagtprm_fil.wttax                                  /* nv_tot_tax       */
                        wtGagtprm_fil.wtGgross       =    wtagtprm_fil.wtgross                                /* nv_tot_gross     */
                        wtGagtprm_fil.wtGcomm        =    wtagtprm_fil.wtcomm           /* nv_tot_comm      */
                        wtGagtprm_fil.wtGcomm_comp   =    wtagtprm_fil.wtcomm_comp                                  /* nv_tot_comm_comp */
                        wtGagtprm_fil.wtGnet         =    wtagtprm_fil.wtnet                                   /* nv_tot_net       */
                        wtGagtprm_fil.wtGbal         =    wtagtprm_fil.wtbal          /* nv_tot_bal       */
                        wtGagtprm_fil.wtGwcr         =    wtagtprm_fil.wtwcr                /* nv_tot_wcr       */
                        wtGagtprm_fil.wtGdamt        =    wtagtprm_fil.wtdamt               /* nv_tot_damt      */
                        wtGagtprm_fil.wtGodue        =    wtagtprm_fil.wtodue               /* nv_tot_odue      */
                        wtGagtprm_fil.wtGodue1       =    wtagtprm_fil.wtodue1              /* nv_tot_odue1     */
                        wtGagtprm_fil.wtGodue2       =    wtagtprm_fil.wtodue2              /* nv_tot_odue2     */
                        wtGagtprm_fil.wtGodue3       =    wtagtprm_fil.wtodue3              /* nv_tot_odue3     */
                        wtGagtprm_fil.wtGodue4       =    wtagtprm_fil.wtodue4              /* nv_tot_odue4     */
                        wtGagtprm_fil.wtGodue5       =    wtagtprm_fil.wtodue5              /* nv_tot_odue5     */
                        wtGagtprm_fil.wtGodue6       =    wtagtprm_fil.wtodue6              /* nv_tot_odue6     */
                        wtGagtprm_fil.wtGodue7       =    wtagtprm_fil.wtodue7              /* nv_tot_odue7     */
                        wtGagtprm_fil.wtGodue8       =    wtagtprm_fil.wtodue8              /* nv_tot_odue8     */
                        wtGagtprm_fil.wtGodue9       =    wtagtprm_fil.wtodue9.              /* nv_tot_odue9.    */
                END.
                
                ELSE DO:
                     ASSIGN 
                        wtGagtprm_fil.wtGprem        =    wtGagtprm_fil.wtGprem        +      wtagtprm_fil.wtprem      
                        wtGagtprm_fil.wtGprem_comp   =    wtGagtprm_fil.wtGprem_comp   +      wtagtprm_fil.wtprem_comp 
                        wtGagtprm_fil.wtGstamp       =    wtGagtprm_fil.wtGstamp       +      wtagtprm_fil.wtstamp     
                        wtGagtprm_fil.wtGtax         =    wtGagtprm_fil.wtGtax         +      wtagtprm_fil.wttax       
                        wtGagtprm_fil.wtGgross       =    wtGagtprm_fil.wtGgross       +      wtagtprm_fil.wtgross     
                        wtGagtprm_fil.wtGcomm        =    wtGagtprm_fil.wtGcomm        +      wtagtprm_fil.wtcomm     
                        wtGagtprm_fil.wtGcomm_comp   =    wtGagtprm_fil.wtGcomm_comp   +      wtagtprm_fil.wtcomm_comp 
                        wtGagtprm_fil.wtGnet         =    wtGagtprm_fil.wtGnet         +      wtagtprm_fil.wtnet       
                        wtGagtprm_fil.wtGbal         =    wtGagtprm_fil.wtGbal         +      wtagtprm_fil.wtbal       
                        wtGagtprm_fil.wtGwcr         =    wtGagtprm_fil.wtGwcr         +      wtagtprm_fil.wtwcr       
                        wtGagtprm_fil.wtGdamt        =    wtGagtprm_fil.wtGdamt        +      wtagtprm_fil.wtdamt      
                        wtGagtprm_fil.wtGodue        =    wtGagtprm_fil.wtGodue        +      wtagtprm_fil.wtodue      
                        wtGagtprm_fil.wtGodue1       =    wtGagtprm_fil.wtGodue1       +      wtagtprm_fil.wtodue1    
                        wtGagtprm_fil.wtGodue2       =    wtGagtprm_fil.wtGodue2       +      wtagtprm_fil.wtodue2    
                        wtGagtprm_fil.wtGodue3       =    wtGagtprm_fil.wtGodue3       +      wtagtprm_fil.wtodue3    
                        wtGagtprm_fil.wtGodue4       =    wtGagtprm_fil.wtGodue4       +      wtagtprm_fil.wtodue4    
                        wtGagtprm_fil.wtGodue5       =    wtGagtprm_fil.wtGodue5       +      wtagtprm_fil.wtodue5    
                        wtGagtprm_fil.wtGodue6       =    wtGagtprm_fil.wtGodue6       +      wtagtprm_fil.wtodue6    
                        wtGagtprm_fil.wtGodue7       =    wtGagtprm_fil.wtGodue7       +      wtagtprm_fil.wtodue7    
                        wtGagtprm_fil.wtGodue8       =    wtGagtprm_fil.wtGodue8       +      wtagtprm_fil.wtodue8    
                        wtGagtprm_fil.wtGodue9       =    wtGagtprm_fil.wtGodue9       +      wtagtprm_fil.wtodue9.   
                END.
                
                /*-------end A53-0159------*/

                END.
                /*----------------*/

                ASSIGN n_odue1 = 0
                       n_odue2 = 0
                       n_odue3 = 0
                       n_odue4 = 0
                       n_odue5 = 0
                       n_odue6 = 0
                       n_odue7 = 0
                       n_odue8 = 0
                       n_odue9 = 0.
                
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
                    nv_gtot_odue5     = nv_gtot_odue5 + nv_tot_odue5
                    nv_gtot_odue6     = nv_gtot_odue6 + nv_tot_odue6
                    nv_gtot_odue7     = nv_gtot_odue7 + nv_tot_odue7
                    nv_gtot_odue8     = nv_gtot_odue8 + nv_tot_odue8
                    nv_gtot_odue9     = nv_gtot_odue9 + nv_tot_odue9.

              
                ASSIGN nv_tot_prem         = 0
                   nv_tot_prem_comp    = 0    
                   nv_tot_stamp        = 0    
                   nv_tot_tax          = 0    
                   nv_tot_gross        = 0    
                   nv_tot_comm         = 0    
                   nv_tot_comm_comp    = 0    
                   nv_tot_net          = 0    
                   nv_tot_bal          = 0    
                   nv_tot_wcr          = 0    
                   nv_tot_damt         = 0    
                   nv_tot_odue         = 0    
                   nv_tot_odue1        = 0    
                   nv_tot_odue2        = 0    
                   nv_tot_odue3        = 0    
                   nv_tot_odue4        = 0    
                   nv_tot_odue5        = 0    
                   nv_tot_odue6        = 0    
                   nv_tot_odue7        = 0    
                   nv_tot_odue8        = 0    
                   nv_tot_odue9       = 0.    

             END.

                    vCount = vCount + 1.

        OUTPUT CLOSE.
        
        


