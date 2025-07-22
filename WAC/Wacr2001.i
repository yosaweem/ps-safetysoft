/*  Modify By A50-0218  Sayamol.N  29/08/2007                */
/*  - เพิ่ม Report Aging ที่เอาเฉพาะยอด Net ของแต่ละ Insured */
/*Modify By A51-0124  Sayamol  เช็ค Process & Report & Branch*/

IF nv_num > 0 THEN DO:
    IF YEAR(agtprm_fil.asdat) = YEAR(agtprm_fil.trndat) THEN DO:
       ASSIGN
          nv_ffield[nv_num]  =  agtprm_fil.gross     /* Detail */
          nv_sfield[nv_num]  =  agtprm_fil.odue      /* Detail */
          nv_ftotal[nv_num]  =  nv_ftotal[nv_num]  +  agtprm_fil.gross   /* Total */
          nv_stotal[nv_num]  =  nv_stotal[nv_num]  +  agtprm_fil.odue    /* Total */
          nv_fgtotal[nv_num] =  nv_fgtotal[nv_num] +  agtprm_fil.gross   /* Grand Total */
          nv_sgtotal[nv_num] =  nv_sgtotal[nv_num] +  agtprm_fil.odue    /* Grand Total */

          nv_sprem[nv_num]   =  nv_sprem[nv_num]   +  agtprm_fil.prem    /* Summary */
          nv_scomm[nv_num]   =  nv_scomm[nv_num]   +  agtprm_fil.comm
          nv_snet[nv_num]    =  nv_snet[nv_num]    +  agtprm_fil.gross
          nv_sres[nv_num]    =  nv_sres[nv_num]    +  agtprm_fil.odue
          nv_sbal[nv_num]    =  nv_sbal[nv_num]    +  nv_netbal
          /*---A50-0218---*/
          nv_sbalos[nv_num]  =  nv_sbal[nv_num]    +  nv_balos         
          nv_svat[nv_num]    =  nv_svat[nv_num]    +  nv_vat
          nv_stax[nv_num]    =  nv_stax[nv_num]    +  nv_tax
          nv_snetpd[nv_num]  =  nv_snetpd[nv_num]  +  nv_netpd
          /*--------------*/

          nv_sgprem[nv_num]  =  nv_sgprem[nv_num]  +  agtprm_fil.prem
          nv_sgcomm[nv_num]  =  nv_sgcomm[nv_num]  +  agtprm_fil.comm
          nv_sgnet[nv_num]   =  nv_sgnet[nv_num]   +  agtprm_fil.gross
          nv_sgres[nv_num]   =  nv_sgres[nv_num]   +  agtprm_fil.odue
          nv_sgbal[nv_num]   =  nv_sgbal[nv_num]   +  nv_netbal
          /*----A50-0218*----*/ 
          nv_sgbalos[nv_num] =  nv_sgbalos[nv_num] + nv_balos            
          nv_sgvat[nv_num]   =  nv_sgvat[nv_num]   + nv_vat
          nv_sgtax[nv_num]   =  nv_sgtax[nv_num]   + nv_tax
          nv_sgnetpd[nv_num] =  nv_sgnetpd[nv_num] + nv_netpd
          /*-----------------*/
          .
       
        CASE agtprm_fil.acno_clicod:
            WHEN "RA" THEN
                ASSIGN
                    nv_racodep[nv_num] = nv_racodep[nv_num] + agtprm_fil.prem
                    nv_racodec[nv_num] = nv_racodec[nv_num] + agtprm_fil.comm
                    nv_racoden[nv_num] = nv_racoden[nv_num] + agtprm_fil.gross
                    nv_racoder[nv_num] = nv_racoder[nv_num] + agtprm_fil.odue
                    nv_racodeb[nv_num] = nv_racodeb[nv_num] + nv_netbal.
            /*---------
            WHEN "RB" THEN
                ASSIGN
                    nv_rbcodep[nv_num] = nv_rbcodep[nv_num] + agtprm_fil.prem
                    nv_rbcodec[nv_num] = nv_rbcodec[nv_num] + agtprm_fil.comm 
                    nv_rbcoden[nv_num] = nv_rbcoden[nv_num] + agtprm_fil.gross
                    nv_rbcoder[nv_num] = nv_rbcoder[nv_num] + agtprm_fil.odue 
                    nv_rbcodeb[nv_num] = nv_rbcodeb[nv_num] + nv_netbal.
            ---------*/
            WHEN "RD" THEN 
                ASSIGN
                    nv_rdcodep[nv_num] = nv_rdcodep[nv_num] + agtprm_fil.prem
                    nv_rdcodec[nv_num] = nv_rdcodec[nv_num] + agtprm_fil.comm 
                    nv_rdcoden[nv_num] = nv_rdcoden[nv_num] + agtprm_fil.gross
                    nv_rdcoder[nv_num] = nv_rdcoder[nv_num] + agtprm_fil.odue 
                    nv_rdcodeb[nv_num] = nv_rdcodeb[nv_num] + nv_netbal.
            WHEN "RF" OR WHEN "RB" THEN
                ASSIGN
                    nv_rfcodep[nv_num] = nv_rfcodep[nv_num] + agtprm_fil.prem
                    nv_rfcodec[nv_num] = nv_rfcodec[nv_num] + agtprm_fil.comm 
                    nv_rfcoden[nv_num] = nv_rfcoden[nv_num] + agtprm_fil.gross
                    nv_rfcoder[nv_num] = nv_rfcoder[nv_num] + agtprm_fil.odue 
                    nv_rfcodeb[nv_num] = nv_rfcodeb[nv_num] + nv_netbal.
        END CASE.
        
    END.
    ELSE DO:           /* over 12 month */
        ASSIGN
            nv_ffield[13]  =  agtprm_fil.gross     /* Detail */
            nv_sfield[13]  =  agtprm_fil.odue      /* Detail */
            nv_ftotal[13]  =  nv_ftotal[13]  +  agtprm_fil.gross
            nv_stotal[13]  =  nv_stotal[13]  +  agtprm_fil.odue
            nv_fgtotal[13] =  nv_fgtotal[13] +  agtprm_fil.gross
            nv_sgtotal[13] =  nv_sgtotal[13] +  agtprm_fil.odue
            
            nv_sprem[13]   =  nv_sprem[13]   +  agtprm_fil.prem
            nv_scomm[13]   =  nv_scomm[13]   +  agtprm_fil.comm
            nv_snet[13]    =  nv_snet[13]    +  agtprm_fil.gross
            nv_sres[13]    =  nv_sres[13]    +  agtprm_fil.odue
            nv_sbal[13]    =  nv_sbal[13]    +  nv_netbal
            
            nv_sgprem[13]  =  nv_sgprem[13]  +  agtprm_fil.prem
            nv_sgcomm[13]  =  nv_sgcomm[13]  +  agtprm_fil.comm
            nv_sgnet[13]   =  nv_sgnet[13]   +  agtprm_fil.gross
            nv_sgres[13]   =  nv_sgres[13]   +  agtprm_fil.odue
            nv_sgbal[13]   =  nv_sgbal[13]   +  nv_netbal  .

        CASE agtprm_fil.acno_clicod:
            WHEN "RA" THEN
                ASSIGN
                    nv_racodep[13] = nv_racodep[13] + agtprm_fil.prem
                    nv_racodec[13] = nv_racodec[13] + agtprm_fil.comm
                    nv_racoden[13] = nv_racoden[13] + agtprm_fil.gross
                    nv_racoder[13] = nv_racoder[13] + agtprm_fil.odue
                    nv_racodeb[13] = nv_racodeb[13] + nv_netbal.
            /*--------
            WHEN "RB" THEN
                ASSIGN
                    nv_rbcodep[13] = nv_rbcodep[13] + agtprm_fil.prem
                    nv_rbcodec[13] = nv_rbcodec[13] + agtprm_fil.comm 
                    nv_rbcoden[13] = nv_rbcoden[13] + agtprm_fil.gross
                    nv_rbcoder[13] = nv_rbcoder[13] + agtprm_fil.odue 
                    nv_rbcodeb[13] = nv_rbcodeb[13] + nv_netbal.
            --------*/
            WHEN "RD" THEN 
                ASSIGN
                    nv_rdcodep[13] = nv_rdcodep[13] + agtprm_fil.prem
                    nv_rdcodec[13] = nv_rdcodec[13] + agtprm_fil.comm 
                    nv_rdcoden[13] = nv_rdcoden[13] + agtprm_fil.gross
                    nv_rdcoder[13] = nv_rdcoder[13] + agtprm_fil.odue 
                    nv_rdcodeb[13] = nv_rdcodeb[13] + nv_netbal.
            WHEN "RF" OR WHEN "RB" THEN 
                ASSIGN
                    nv_rfcodep[13] = nv_rfcodep[13] + agtprm_fil.prem
                    nv_rfcodec[13] = nv_rfcodec[13] + agtprm_fil.comm 
                    nv_rfcoden[13] = nv_rfcoden[13] + agtprm_fil.gross
                    nv_rfcoder[13] = nv_rfcoder[13] + agtprm_fil.odue 
                    nv_rfcodeb[13] = nv_rfcodeb[13] + nv_netbal.
        END CASE.
    END.
END.
ELSE DO:
    IF YEAR(agtprm_fil.asdat) - YEAR(agtprm_fil.trndat) = 1 THEN DO:
        ASSIGN
            nv_col             =  (nv_gap + nv_num)  +  MONTH(agtprm_fil.asdat)
            nv_ffield[nv_col]  =  agtprm_fil.gross
            nv_sfield[nv_col]  =  agtprm_fil.odue
            nv_ftotal[nv_col]  =  nv_ftotal[nv_col]  +  agtprm_fil.gross
            nv_stotal[nv_col]  =  nv_stotal[nv_col]  +  agtprm_fil.odue
            nv_fgtotal[nv_col] =  nv_fgtotal[nv_col] +  agtprm_fil.gross
            nv_sgtotal[nv_col] =  nv_sgtotal[nv_col] +  agtprm_fil.odue
            
            nv_sprem[nv_col]   =  nv_sprem[nv_col]   +  agtprm_fil.prem
            nv_scomm[nv_col]   =  nv_scomm[nv_col]   +  agtprm_fil.comm
            nv_snet[nv_col]    =  nv_snet[nv_col]    +  agtprm_fil.gross
            nv_sres[nv_col]    =  nv_sres[nv_col]    +  agtprm_fil.odue
            nv_sbal[nv_col]    =  nv_sbal[nv_col]    +  nv_netbal

            nv_sgprem[nv_col]  =  nv_sgprem[nv_col]  +  agtprm_fil.prem
            nv_sgcomm[nv_col]  =  nv_sgcomm[nv_col]  +  agtprm_fil.comm
            nv_sgnet[nv_col]   =  nv_sgnet[nv_col]   +  agtprm_fil.gross
            nv_sgres[nv_col]   =  nv_sgres[nv_col]   +  agtprm_fil.odue
            nv_sgbal[nv_col]   =  nv_sgbal[nv_col]   +  nv_netbal.

        CASE agtprm_fil.acno_clicod:
            WHEN "RA" THEN
                ASSIGN
                    nv_racodep[nv_col] = nv_racodep[nv_col] + agtprm_fil.prem
                    nv_racodec[nv_col] = nv_racodec[nv_col] + agtprm_fil.comm
                    nv_racoden[nv_col] = nv_racoden[nv_col] + agtprm_fil.gross
                    nv_racoder[nv_col] = nv_racoder[nv_col] + agtprm_fil.odue
                    nv_racodeb[nv_col] = nv_racodeb[nv_col] + nv_netbal.
            /*-------
            WHEN "RB" THEN
                ASSIGN
                    nv_rbcodep[nv_col] = nv_rbcodep[nv_col] + agtprm_fil.prem
                    nv_rbcodec[nv_col] = nv_rbcodec[nv_col] + agtprm_fil.comm 
                    nv_rbcoden[nv_col] = nv_rbcoden[nv_col] + agtprm_fil.gross
                    nv_rbcoder[nv_col] = nv_rbcoder[nv_col] + agtprm_fil.odue 
                    nv_rbcodeb[nv_col] = nv_rbcodeb[nv_col] + nv_netbal.
            ----------*/        
            WHEN "RD" THEN 
                ASSIGN
                    nv_rdcodep[nv_col] = nv_rdcodep[nv_col] + agtprm_fil.prem
                    nv_rdcodec[nv_col] = nv_rdcodec[nv_col] + agtprm_fil.comm 
                    nv_rdcoden[nv_col] = nv_rdcoden[nv_col] + agtprm_fil.gross
                    nv_rdcoder[nv_col] = nv_rdcoder[nv_col] + agtprm_fil.odue 
                    nv_rdcodeb[nv_col] = nv_rdcodeb[nv_col] + nv_netbal.
            WHEN "RF" OR WHEN "RB" THEN
                ASSIGN
                    nv_rfcodep[nv_col] = nv_rfcodep[nv_col] + agtprm_fil.prem
                    nv_rfcodec[nv_col] = nv_rfcodec[nv_col] + agtprm_fil.comm 
                    nv_rfcoden[nv_col] = nv_rfcoden[nv_col] + agtprm_fil.gross
                    nv_rfcoder[nv_col] = nv_rfcoder[nv_col] + agtprm_fil.odue 
                    nv_rfcodeb[nv_col] = nv_rfcodeb[nv_col] + nv_netbal.
        END CASE.
    END.
    ELSE DO:                                              /* over 12 month */
        ASSIGN
            nv_ffield[13]  =  agtprm_fil.gross     /* Detail */
            nv_sfield[13]  =  agtprm_fil.odue      /* Detail */
            nv_ftotal[13]  =  nv_ftotal[13]  +  agtprm_fil.gross
            nv_stotal[13]  =  nv_stotal[13]  +  agtprm_fil.odue
            nv_fgtotal[13] =  nv_fgtotal[13] +  agtprm_fil.gross
            nv_sgtotal[13] =  nv_sgtotal[13] +  agtprm_fil.odue

            nv_sprem[13]   =  nv_sprem[13]   +  agtprm_fil.prem
            nv_scomm[13]   =  nv_scomm[13]   +  agtprm_fil.comm
            nv_snet[13]    =  nv_snet[13]    +  agtprm_fil.gross
            nv_sres[13]    =  nv_sres[13]    +  agtprm_fil.odue
            nv_sbal[13]    =  nv_sbal[13]    +  nv_netbal

            nv_sgprem[13]  =  nv_sgprem[13]  +  agtprm_fil.prem
            nv_sgcomm[13]  =  nv_sgcomm[13]  +  agtprm_fil.comm
            nv_sgnet[13]   =  nv_sgnet[13]   +  agtprm_fil.gross
            nv_sgres[13]   =  nv_sgres[13]   +  agtprm_fil.odue
            nv_sgbal[13]   =  nv_sgbal[13]   +  nv_netbal
            .

        CASE agtprm_fil.acno_clicod:
            WHEN "RA" THEN
                ASSIGN
                    nv_racodep[13] = nv_racodep[13] + agtprm_fil.prem
                    nv_racodec[13] = nv_racodec[13] + agtprm_fil.comm
                    nv_racoden[13] = nv_racoden[13] + agtprm_fil.gross
                    nv_racoder[13] = nv_racoder[13] + agtprm_fil.odue
                    nv_racodeb[13] = nv_racodeb[13] + nv_netbal.
            /*------
            WHEN "RB" THEN
                ASSIGN
                    nv_rbcodep[13] = nv_rbcodep[13] + agtprm_fil.prem
                    nv_rbcodec[13] = nv_rbcodec[13] + agtprm_fil.comm 
                    nv_rbcoden[13] = nv_rbcoden[13] + agtprm_fil.gross
                    nv_rbcoder[13] = nv_rbcoder[13] + agtprm_fil.odue 
                    nv_rbcodeb[13] = nv_rbcodeb[13] + nv_netbal.
            ------*/        
            WHEN "RD" THEN 
                ASSIGN
                    nv_rdcodep[13] = nv_rdcodep[13] + agtprm_fil.prem
                    nv_rdcodec[13] = nv_rdcodec[13] + agtprm_fil.comm 
                    nv_rdcoden[13] = nv_rdcoden[13] + agtprm_fil.gross
                    nv_rdcoder[13] = nv_rdcoder[13] + agtprm_fil.odue 
                    nv_rdcodeb[13] = nv_rdcodeb[13] + nv_netbal.
            WHEN "RF" OR WHEN "RB" THEN
                ASSIGN
                    nv_rfcodep[13] = nv_rfcodep[13] + agtprm_fil.prem
                    nv_rfcodec[13] = nv_rfcodec[13] + agtprm_fil.comm 
                    nv_rfcoden[13] = nv_rfcoden[13] + agtprm_fil.gross
                    nv_rfcoder[13] = nv_rfcoder[13] + agtprm_fil.odue 
                    nv_rfcodeb[13] = nv_rfcodeb[13] + nv_netbal.
        END CASE.    
    END.
END.

ASSIGN
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
    /*----------------*/
    nv_sprem[14]  = nv_sprem[14]  + agtprm_fil.prem
    nv_scomm[14]  = nv_scomm[14]  + agtprm_fil.comm
    /*----- A48-0113 -----*/
    nv_snet[14]   = nv_snet[14]   + agtprm_fil.gross
    nv_sres[14]   = nv_sres[14]   + agtprm_fil.odue
    nv_sbal[14]   = nv_sbal[14]   + nv_netbal
    /*--- END A48-0113 ---*/
    /*----A50-0218----*/
    nv_sbalos[14] = nv_sbalos[14]   + agtprm_fil.bal   
    nv_svat[14] = nv_svat[14]   + nv_vat    
    nv_stax[14] = nv_stax[14]   + nv_tax
    nv_snetpd[14] = nv_snetpd[14]   + nv_netpd  .

CASE agtprm_fil.acno_clicod:
    WHEN "RA" THEN
        ASSIGN
            nv_racodep[14] = nv_racodep[14] + agtprm_fil.prem
            nv_racodec[14] = nv_racodec[14] + agtprm_fil.comm
            nv_racoden[14] = nv_racoden[14] + agtprm_fil.gross
            nv_racoder[14] = nv_racoder[14] + agtprm_fil.odue
            nv_racodeb[14] = nv_racodeb[14] + nv_netbal.
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
            nv_rdcodep[14] = nv_rdcodep[14] + agtprm_fil.prem
            nv_rdcodec[14] = nv_rdcodec[14] + agtprm_fil.comm 
            nv_rdcoden[14] = nv_rdcoden[14] + agtprm_fil.gross
            nv_rdcoder[14] = nv_rdcoder[14] + agtprm_fil.odue 
            nv_rdcodeb[14] = nv_rdcodeb[14] + nv_netbal.
    WHEN "RF" OR WHEN "RB" THEN
        ASSIGN
            nv_rfcodep[14] = nv_rfcodep[14] + agtprm_fil.prem
            nv_rfcodec[14] = nv_rfcodec[14] + agtprm_fil.comm 
            nv_rfcoden[14] = nv_rfcoden[14] + agtprm_fil.gross
            nv_rfcoder[14] = nv_rfcoder[14] + agtprm_fil.odue 
            nv_rfcodeb[14] = nv_rfcodeb[14] + nv_netbal.
END CASE. 

IF (nv_DetSum = "Detail")  OR (nv_DetSum = "All") THEN DO:
    /*-----A51-0124-----*/
    IF agtprm_fil.odue = agtprm_fil.bal THEN
        nv_netpd = 0.
    /*------------------*/

    OUTPUT TO VALUE (STRING(n_OutputFile )) APPEND NO-ECHO.
        EXPORT DELIMITER ";"
            agtprm_fil.acno
            nv_acname
            agtprm_fil.trndat
            agtprm_fil.policy
            agtprm_fil.endno
            agtprm_fil.comdat
            agtprm_fil.duedat
            agtprm_fil.trntyp
            "'" + agtprm_fil.docno FORMAT "x(10)"  /* Benjaporn J. A60-0267 date 27/06/2017 */
            agtprm_fil.insure
            agtprm_fil.opnpol
            agtprm_fil.prvpol
            agtprm_fil.prem
            agtprm_fil.comm
            agtprm_fil.gross
            /*-----A50-0218----*/
            nv_vat
            nv_tax
            
            /*-----------------*/
            agtprm_fil.odue     /* A48-0113 */
            /*---nv_netbal           /* A48-0113 */-----Comment by A50-0218---*/
                 
            /*----A50-0218----*/
            nv_netpd           /*- Net Paid A50-0218-*/
            agtprm_fil.bal 
            /*----------------*/

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
            agtprm_fil.poldes .          /* A50-0218 */
            
    OUTPUT CLOSE.
END.    /* (nv_DetSum = "Detail")  OR (nv_DetSum = "All") */

ASSIGN
    nv_ffield = 0
    nv_sfield = 0.

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
                nv_tprem
                nv_tcomm
                nv_tnet     /* A48-0113 */
                /*----A50-0218----*/
                nv_tvat
                nv_ttax 
                
                /*----------------*/
                nv_tres     /* A48-0113 */
                /*---nv_tbal   A50-0218---*/
                /*--- A50-0218 ---*/
                nv_tnetpd
                nv_tbalos 
                /*-----------------*/

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
                nv_stotal[13] .
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
            /*--------------*/
            nv_ftotal = 0
            nv_stotal = 0 .

    END.    /* (nv_DetSum = "Detail")  OR (nv_DetSum = "All") */
    
    /*--- DISPLAY SUMMARY  ---*/
    IF (nv_DetSum = "Summary") OR (nv_DetSum = "All") THEN DO:

        OUTPUT TO VALUE (STRING(n_OutputFileSum) ) APPEND NO-ECHO.
            EXPORT DELIMITER ";" "Gross Premium"    nv_sprem[14]  nv_sprem[1 FOR 13].
            EXPORT DELIMITER ";" "Commission"       nv_scomm[14]  nv_scomm[1 FOR 13].
            /*----- A48-0113 -----*/
            EXPORT DELIMITER ";" "Net Amount"       nv_snet[14]   nv_snet[1 FOR 13].
            EXPORT DELIMITER ";" "Premium Reserve"  nv_sres[14]   nv_sres[1 FOR 13].
            /*--- END A48-0113 ---*/
            EXPORT DELIMITER ";" "Net Balance"      nv_sbal[14]   nv_sbal[1 FOR 13]. 

        OUTPUT CLOSE.

        /*--------A50-0218----------*/
        OUTPUT TO VALUE (STRING(n_OutputFileNet) ) APPEND NO-ECHO.
            EXPORT DELIMITER ";" nv_relate agtprm_fil.acno  nv_acname   nv_sbal[14]   nv_sbal[1 FOR 13]. 

        OUTPUT CLOSE.
        /*-------End A50-0218-------*/

        ASSIGN
            nv_sprem  = 0
            nv_scomm  = 0
            nv_snet   = 0   /*A48-0113*/
            nv_sres   = 0   /*A48-0113*/
            nv_sbal   = 0
            /*---A50-0218---*/
            nv_sbalos = 0 
            nv_svat   = 0 
            nv_stax   = 0 
            nv_snetpd = 0 
            /*---------------*/
            .  

    END.  /* (nv_DetSum = "Summary") OR (nv_DetSum = "All") */
END.   /* IF LAST-OF(agtprm_fil.acno) */
