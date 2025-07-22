/* Dup จาก Program wacr2001.i  ตัดloopการ put data ออกมา  */
/* Create By: Lukkana M.  Date: 10/11/2009                */
/* Assign No: A52-0241                                    */

ASSIGN
    nv_tsumin     = nv_tsumin + agtprm_fil.comm_comp /*Lukkana M. A52-0241 21/10/2009*/
    nv_tprem      = nv_tprem + agtprm_fil.prem
    nv_tcomm      = nv_tcomm + agtprm_fil.comm
    /*----- A48-0113 -----*/
    nv_tnet       = nv_tnet  + agtprm_fil.gross
    nv_tres       = nv_tres  + agtprm_fil.odue
    nv_tbal       = nv_tbal  + nv_netbal
    /*--- END A48-0113 ---*/
    /*----A50-0218----*/
    nv_tbalos   = nv_tbalos + agtprm_fil.bal         
    nv_tvat     = nv_tvat + nv_vat  
    nv_ttax     = nv_ttax + nv_tax
    nv_tnetpd   = nv_tnetpd + nv_netpd
    nv_tnetpaid   = nv_tnetpaid + nv_netpaid /*Lukkana M. A52-0241 21/10/2009*/
    /*----------------*/
    nv_sprem[14]  = nv_sprem[14]  + agtprm_fil.prem
    nv_scomm[14]  = nv_scomm[14]  + agtprm_fil.comm
    /*----- A48-0113 -----*/
    nv_snet[14]   = nv_snet[14]   + agtprm_fil.gross
    nv_sres[14]   = nv_sres[14]   + agtprm_fil.odue
    nv_nsbal[14]  = nv_nsbal[14] +  agtprm_fil.gross - agtprm_fil.odue /*Lukkana M. A52-0241 22/10/2009*/
    nv_sbal[14]   = nv_sbal[14]   + nv_netbal
    /*--- END A48-0113 ---*/
    /*----A50-0218----*/
    nv_sbalos[14] = nv_sbalos[14]   + agtprm_fil.bal   
    nv_svat[14] = nv_svat[14]   + nv_vat    
    nv_stax[14] = nv_stax[14]   + nv_tax
    nv_snetpd[14] = nv_snetpd[14]   + nv_netpd
    nv_snetpaid[14] = nv_snetpaid[14]   + nv_netpaid /*Lukkana M. A52-0241 21/10/2009*/
    .

CASE agtprm_fil.acno_clicod:
    WHEN "RA" THEN
        ASSIGN
            nv_racodep[14]  = nv_racodep[14]  + agtprm_fil.prem
            nv_racodec[14]  = nv_racodec[14]  + agtprm_fil.comm
            nv_racoden[14]  = nv_racoden[14]  + agtprm_fil.gross
            nv_racoder[14]  = nv_racoder[14]  + agtprm_fil.odue
            nv_racodeb[14]  = nv_racodeb[14]  + nv_netbal
            nv_nracodeb[14] = nv_nracodeb[14] + agtprm_fil.gross - agtprm_fil.odue. /*Lukkana M. A52-0241 21/10/2009*/
    /*------
    WHEN "RB" THEN
        ASSIGN
            nv_rbcodep[14] = nv_rbcodep[14] + agtprm_fil.prem
            nv_rbcodec[14] = nv_rbcodec[14] + agtprm_fil.comm 
            nv_rbcoden[14] = nv_rbcoden[14] + agtprm_fil.gross
            nv_rbcoder[14] = nv_rbcoder[14] + agtprm_fil.odue 
            nv_rbcodeb[14] = nv_rbcodeb[14] + nv_netbal.
    --------*/        
    WHEN "RD" THEN 
        ASSIGN
            nv_rdcodep[14]  = nv_rdcodep[14]  + agtprm_fil.prem
            nv_rdcodec[14]  = nv_rdcodec[14]  + agtprm_fil.comm 
            nv_rdcoden[14]  = nv_rdcoden[14]  + agtprm_fil.gross
            nv_rdcoder[14]  = nv_rdcoder[14]  + agtprm_fil.odue 
            nv_rdcodeb[14]  = nv_rdcodeb[14]  + nv_netbal
            nv_nrdcodeb[14] = nv_nrdcodeb[14] + agtprm_fil.gross - agtprm_fil.odue. /*Lukkana M. A52-0241 21/10/2009*/
    WHEN "RF" OR WHEN "RB" THEN
        ASSIGN
            nv_rfcodep[14]  = nv_rfcodep[14]  + agtprm_fil.prem
            nv_rfcodec[14]  = nv_rfcodec[14]  + agtprm_fil.comm 
            nv_rfcoden[14]  = nv_rfcoden[14]  + agtprm_fil.gross
            nv_rfcoder[14]  = nv_rfcoder[14]  + agtprm_fil.odue 
            nv_rfcodeb[14]  = nv_rfcodeb[14]  + nv_netbal
            nv_nrfcodeb[14] = nv_nrfcodeb[14] + agtprm_fil.gross - agtprm_fil.odue. /*Lukkana M. A52-0241 21/10/2009*/
END CASE. 

IF (nv_DetSum = "Detail")  OR (nv_DetSum = "All") THEN DO:
    /*-----A51-0124-----*/
    IF agtprm_fil.odue = agtprm_fil.bal THEN 
        ASSIGN  nv_netpd   = 0
                nv_netpaid = 0. /*Lukkana M. A52-0241 21/10/2009*/
    /*------------------*/

    /*Lukkana M. A52-0241 21/10/2009*/
    IF agtprm_fil.trndat = ? THEN nv_trndat = "".
    ELSE nv_trndat = STRING(agtprm_fil.trndat).
    IF agtprm_fil.comdat = ? THEN nv_comdat = "".
    ELSE nv_comdat = STRING(agtprm_fil.comdat).
    IF agtprm_fil.duedat = ? THEN nv_duedat = "".
    ELSE nv_duedat = STRING(agtprm_fil.duedat) .
    /*Lukkana M. A52-0241 21/10/2009*/

    OUTPUT TO VALUE (STRING(n_OutputFile )) APPEND NO-ECHO.
        EXPORT DELIMITER ";"
            agtprm_fil.acno
            nv_acname
            /*agtprm_fil.trndat Lukkana M. A52-0241 30/10/2009*/
            nv_trndat  /*-Lukkana M. A52-0241 30/10/2009*/
            agtprm_fil.policy
            agtprm_fil.endno
            /*--
            agtprm_fil.comdat
            agtprm_fil.duedat
            Lukkana M. A52-0241 30/10/2009---*/
            nv_comdat
            nv_duedat
            agtprm_fil.trntyp
            "'" + agtprm_fil.docno  FORMAT "x(10)"  /* Benjaporn J. A60-0267 date 27/06/2017 */
            agtprm_fil.insure
            agtprm_fil.opnpol
            agtprm_fil.prvpol
            agtprm_fil.comm_comp /*-- sum insured Lukkana M. A52-0241 07/10/2009--*/
            agtprm_fil.prem
            agtprm_fil.comm
            agtprm_fil.gross
            /*-----A50-0218----*/
            nv_vat
            nv_tax
            
            /*-----------------*/
            /*agtprm_fil.odue      A48-0113 */
            /*---nv_netbal           /* A48-0113 */-----Comment by A50-0218---*/
                 
            /*----A50-0218----*/
            /*--
            nv_netpd           /*- Net Paid A50-0218-*/  
            Lukkana M. A52-0241 21/10/2009*/
            nv_netpaid /*Lukkana M. A52-0241 21/10/2009*/
            agtprm_fil.bal 
            /*----------------*/

            /*--Lukkana M. A52-0241 30/09/2009--
            nv_ffield[1]
            nv_sfield[1]
            nv_ffield[2]
            nv_sfield[2]
            nv_ffield[3]
            nv_sfield[3]
            nv_ffield[4]
            nv_sfield[4]
            nv_ffield[5]
            nv_sfield[5]
            nv_ffield[6]
            nv_sfield[6]
            nv_ffield[7]
            nv_sfield[7]
            nv_ffield[8]
            nv_sfield[8]
            nv_ffield[9]
            nv_sfield[9]
            nv_ffield[10]
            nv_sfield[10]
            nv_ffield[11]
            nv_sfield[11]
            nv_ffield[12]
            nv_sfield[12]
            nv_ffield[13]
            nv_sfield[13]
            --Lukkana M. A52-0241 30/09/2009--*/
            nv_fieldbal[18] nv_fieldbal[1 FOR 13] nv_fieldbal[15] nv_fieldbal[16] nv_fieldbal[17]  /*--Lukkana M. A52-0241 30/09/2009--*/

            agtprm_fil.poldes  .         /* A50-0218 */
            
    OUTPUT CLOSE.
END.    /* (nv_DetSum = "Detail")  OR (nv_DetSum = "All") */

ASSIGN
    nv_ffield     = 0
    nv_sfield     = 0
    nv_fieldbal   = 0. /*--Lukkana M. A52-0241 30/09/2009--*/

IF LAST-OF(agtprm_fil.acno) THEN DO:
    /*---A50-0218---
    IF nv_tbalos > 0 THEN nv_tstos = "O/S > 0".
    ELSE IF nv_tbalos = 0 THEN nv_tstos = "O/S = 0".
    ELSE nv_tstos = "O/S < 0".
    --------------*/

    /*--- DISPLAY DETAIL  ---*/
    IF (nv_DetSum = "Detail")  OR (nv_DetSum = "All") THEN DO:

        OUTPUT TO VALUE (STRING(n_OutputFile ) ) APPEND NO-ECHO.
            EXPORT DELIMITER ";"
                "Total : " + agtprm_fil.acno
                nv_blankX[1 FOR 11] 
                
                nv_tsumin  /*--Lukkana M. A52-0241 30/09/2009--*/
                nv_tprem
                nv_tcomm
                nv_tnet     /* A48-0113 */
                /*----A50-0218----*/
                nv_tvat
                nv_ttax 
                
                /*----------------*/
                /*nv_tres     /* A48-0113 */ */
                /*---nv_tbal   A50-0218---*/
                /*--- A50-0218 ---*/
                /*nv_tnetpd Lukkana M. A52-0241 22/10/2009*/
                nv_tnetpaid /*Lukkana M. A52-0241 22/10/2009*/

                nv_tbalos 
                /*-----------------*/

                /*--- Lukkana M. A52-0241 30/09/2009
                nv_ftotal[1]
                nv_stotal[1]
                nv_ftotal[2]
                nv_stotal[2]
                nv_ftotal[3] 
                nv_stotal[3]
                nv_ftotal[4]
                nv_stotal[4]
                nv_ftotal[5]
                nv_stotal[5]
                nv_ftotal[6]
                nv_stotal[6]
                nv_ftotal[7]
                nv_stotal[7]
                nv_ftotal[8]
                nv_stotal[8]
                nv_ftotal[9]
                nv_stotal[9]
                nv_ftotal[10]
                nv_stotal[10]
                nv_ftotal[11]
                nv_stotal[11]
                nv_ftotal[12]
                nv_stotal[12]
                nv_ftotal[13]
                nv_stotal[13]
                Lukkana M. A52-0241 30/09/2009--*/

                /*---Lukkana M. A52-0241 30/09/2009--*/
                nv_totbal[18] nv_totbal[1 FOR 13] nv_totbal[15] nv_totbal[16] nv_totbal[17]
                /*---Lukkana M. A52-0241 30/09/2009--*/
                .
               /* nv_tstos     A50-0218*/
   
        OUTPUT CLOSE.   

        ASSIGN
            nv_tprem  = 0
            nv_tcomm  = 0
            nv_tnet   = 0    /* A48-0113 */
            nv_tres   = 0    /* A48-0113 */
            nv_tbal   = 0
            /*---A50-0218---*/
            nv_tbalos = 0    
            nv_tvat   = 0    
            nv_ttax   = 0    
            nv_tnetpd = 0
            nv_tsumin = 0 /*Lukkana M. A52-0241 22/10/2009*/
            nv_tnetpaid = 0 /*Lukkana M. A52-0241 22/10/2009*/
            /*--------------*/
            nv_ftotal = 0
            nv_stotal = 0 
            nv_totbal = 0. /*-- Lukkana M. A52-0241 30/09/2009 --*/

    END.    /* (nv_DetSum = "Detail")  OR (nv_DetSum = "All") */
    
    /*--- DISPLAY SUMMARY  ---*/
    IF (nv_DetSum = "Summary") OR (nv_DetSum = "All") THEN DO:

        OUTPUT TO VALUE (STRING(n_OutputFileSum) ) APPEND NO-ECHO.
            EXPORT DELIMITER ";" agtprm_fil.acno + " - " + nv_acname  /*-- Lukkana M. A52-0241 08/10/2009 --*/
                                 "Gross Premium"    nv_sprem[14]  nv_sprem[18] nv_sprem[1 FOR 13] 
                                                    nv_sprem[15]  nv_sprem[16] nv_sprem[17] nv_notes1.  /*--Lukkana M. A52-0241 24/09/2009--*/
            EXPORT DELIMITER ";" agtprm_fil.acno + " - " + nv_acname  /*-- Lukkana M. A52-0241 08/10/2009 --*/
                                 "Commission"       nv_scomm[14]  nv_scomm[18] nv_scomm[1 FOR 13]
                                                    nv_scomm[15]  nv_scomm[16] nv_scomm[17] nv_notes1.  /*--Lukkana M. A52-0241 24/09/2009--*/
            /*----- A48-0113 -----*/
            EXPORT DELIMITER ";" agtprm_fil.acno + " - " + nv_acname  /*-- Lukkana M. A52-0241 08/10/2009 --*/
                                 "Net Amount"       nv_snet[14]   nv_snet[18] nv_snet[1 FOR 13]
                                                    nv_snet[15]   nv_snet[16] nv_snet[17] nv_notes1.   /*--Lukkana M. A52-0241 24/09/2009--*/
            /*--
            EXPORT DELIMITER ";" agtprm_fil.acno + " - " + nv_acname  /*-- Lukkana M. A52-0241 08/10/2009 --*/
                                 "Premium Reserve"  nv_sres[14]   nv_sres[1 FOR 13]
                                                    nv_sres[15]   nv_sres[16] nv_sres[17] nv_notes1.   
            --Lukkana M. A52-0241 24/09/2009--*/
            /*--- END A48-0113 ---*/
            EXPORT DELIMITER ";" agtprm_fil.acno + " - " + nv_acname  /*-- Lukkana M. A52-0241 08/10/2009 --*/
                                 "Net Balance"      nv_sbal[14]   nv_sbal[18] nv_sbal[1 FOR 13]
                                                    nv_sbal[15]   nv_sbal[16] nv_sbal[17] nv_notes1.   /*--Lukkana M. A52-0241 24/09/2009--*/ 
                                                    /*nv_nsbal[14]   nv_nsbal[1 FOR 13]
                                                    nv_nsbal[15]   nv_nsbal[16] nv_nsbal[17] nv_notes1.   --Lukkana M. A52-0241 24/09/2009--*/ 

        OUTPUT CLOSE.

        /*--------A50-0218----------*/
        OUTPUT TO VALUE (STRING(n_OutputFileNet) ) APPEND NO-ECHO.
            EXPORT DELIMITER ";" nv_relate agtprm_fil.acno  nv_acname nv_sbal[14] nv_sbal[18] nv_sbal[1 FOR 13] 
                                 nv_sbal[15] nv_sbal[16] nv_sbal[17] nv_notes1 .  /*-- Lukkana M. A52-0241 08/10/2009--*/

        OUTPUT CLOSE.
        /*-------End A50-0218-------*/

        ASSIGN
            nv_sprem  = 0
            nv_scomm  = 0
            nv_snet   = 0   /*A48-0113*/
            nv_sres   = 0   /*A48-0113*/
            nv_nsbal  = 0 /*Lukkana M. A52-0241 22/10/2009*/
            nv_sbal   = 0
            /*---A50-0218---*/
            nv_sbalos = 0 
            nv_svat = 0 
            nv_stax = 0 
            nv_snetpd = 0 
            nv_snetpaid = 0 /*Lukkana M. A52-0241 22/10/2009*/
            /*---------------*/
            .  

    END.  /* (nv_DetSum = "Summary") OR (nv_DetSum = "All") */
END.   /* IF LAST-OF(agtprm_fil.acno) */
