/* Dup จาก Program Wacr2001.i                                          */
/* Create By : Lukkana M.   Date : 24/09/2009                          */
/* Assign No : A52-0241  เพิ่มคอลัมน์ 1 year 2 year 3 year over 3 year */

/*IF nv_num > 0 THEN DO:*/
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
          nv_nsbal[nv_num]   =  nv_nsbal[nv_num]   +  agtprm_fil.gross - agtprm_fil.odue /*Lukkana M. A52-0241 22/10/2009*/
          nv_sbal[nv_num]    =  nv_sbal[nv_num]    +  nv_netbal
          nv_fieldbal[nv_num] = nv_netbal     /* Detail Lukkana M. A52-0241 02/10/2009 */
          nv_totbal[nv_num]   = nv_totbal[nv_num]   +  nv_netbal /* Total Lukkana M. A52-0241 02/10/2009 */
          nv_stotbal[nv_num]  = nv_stotbal[nv_num]  +  nv_netbal /* Grand Total Lukkana M. A52-0241 02/10/2009 */
          /*---A50-0218---*/
          nv_sbalos[nv_num]  =  nv_sbal[nv_num]    +  nv_balos         
          nv_svat[nv_num]    =  nv_svat[nv_num]    +  nv_vat
          nv_stax[nv_num]    =  nv_stax[nv_num]    +  nv_tax
          nv_snetpd[nv_num]  =  nv_snetpd[nv_num]  +  nv_netpd
          nv_snetpaid[nv_num] = nv_snetpaid[nv_num]  +  nv_netpaid /*Lukkana M. A52-0241 21/10/2009*/
          /*--------------*/

          nv_sgprem[nv_num]  =  nv_sgprem[nv_num]  +  agtprm_fil.prem
          nv_sgcomm[nv_num]  =  nv_sgcomm[nv_num]  +  agtprm_fil.comm
          nv_sgnet[nv_num]   =  nv_sgnet[nv_num]   +  agtprm_fil.gross
          nv_sgres[nv_num]   =  nv_sgres[nv_num]   +  agtprm_fil.odue
          nv_sgbal[nv_num]   =  nv_sgbal[nv_num]   +  nv_netbal
          nv_nsgbal[nv_num]  =  nv_nsgbal[nv_num]  +  agtprm_fil.gross - agtprm_fil.odue /*Lukkana M. A52-0241 22/10/2009*/
          /*----A50-0218*----*/ 
          nv_sgbalos[nv_num] =  nv_sgbalos[nv_num] + nv_balos            
          nv_sgvat[nv_num]   =  nv_sgvat[nv_num]   + nv_vat
          nv_sgtax[nv_num]   =  nv_sgtax[nv_num]   + nv_tax
          nv_sgnetpd[nv_num] =  nv_sgnetpd[nv_num] + nv_netpd
          nv_sgnetpaid[nv_num] =  nv_sgnetpaid[nv_num] + nv_netpaid /*Lukkana M. A52-0241 21/10/2009*/
          /*-----------------*/
          .
       
        CASE agtprm_fil.acno_clicod:
            WHEN "RA" THEN
                ASSIGN
                    nv_racodep[nv_num]  = nv_racodep[nv_num]  + agtprm_fil.prem
                    nv_racodec[nv_num]  = nv_racodec[nv_num]  + agtprm_fil.comm
                    nv_racoden[nv_num]  = nv_racoden[nv_num]  + agtprm_fil.gross
                    nv_racoder[nv_num]  = nv_racoder[nv_num]  + agtprm_fil.odue
                    nv_racodeb[nv_num]  = nv_racodeb[nv_num]  + nv_netbal
                    nv_nracodeb[nv_num] = nv_nracodeb[nv_num] + agtprm_fil.gross - agtprm_fil.odue. /*Lukkana M. A52-0241 21/10/2009*/
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
                    nv_rdcodep[nv_num]  = nv_rdcodep[nv_num]  + agtprm_fil.prem
                    nv_rdcodec[nv_num]  = nv_rdcodec[nv_num]  + agtprm_fil.comm 
                    nv_rdcoden[nv_num]  = nv_rdcoden[nv_num]  + agtprm_fil.gross
                    nv_rdcoder[nv_num]  = nv_rdcoder[nv_num]  + agtprm_fil.odue 
                    nv_rdcodeb[nv_num]  = nv_rdcodeb[nv_num]  + nv_netbal
                    nv_nrdcodeb[nv_num] = nv_nrdcodeb[nv_num] + agtprm_fil.gross - agtprm_fil.odue. /*Lukkana M. A52-0241 21/10/2009*/
            WHEN "RF" OR WHEN "RB" THEN
                ASSIGN
                    nv_rfcodep[nv_num]  = nv_rfcodep[nv_num]  + agtprm_fil.prem
                    nv_rfcodec[nv_num]  = nv_rfcodec[nv_num]  + agtprm_fil.comm 
                    nv_rfcoden[nv_num]  = nv_rfcoden[nv_num]  + agtprm_fil.gross
                    nv_rfcoder[nv_num]  = nv_rfcoder[nv_num]  + agtprm_fil.odue 
                    nv_rfcodeb[nv_num]  = nv_rfcodeb[nv_num]  + nv_netbal
                    nv_nrfcodeb[nv_num] = nv_nrfcodeb[nv_num] + agtprm_fil.gross - agtprm_fil.odue. /*Lukkana M. A52-0241 21/10/2009*/
        END CASE.
        
    END.
    ELSE DO:           /* over 12 month */

        /*--  Lukkana M. A52-0241 24/09/2009  เช็คจำนวนปี --*/
        IF YEAR(agtprm_fil.asdat) - YEAR(agtprm_fil.trndat) = 1 THEN DO:  /* 1 year */
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
                nv_nsbal[13]   =  nv_nsbal[13]   +  agtprm_fil.gross - agtprm_fil.odue /*Lukkana M. A52-0241 22/10/2009*/
                nv_sbal[13]    =  nv_sbal[13]    +  nv_netbal
                nv_fieldbal[13] = nv_netbal     /* Detail Lukkana M. A52-0241 02/10/2009 */
                nv_totbal[13]   = nv_totbal[13]   +  nv_netbal /* Total Lukkana M. A52-0241 02/10/2009 */
                nv_stotbal[13]  = nv_stotbal[13]  +  nv_netbal /* Grand Total Lukkana M. A52-0241 02/10/2009 */
                
                nv_sgprem[13]  =  nv_sgprem[13]  +  agtprm_fil.prem
                nv_sgcomm[13]  =  nv_sgcomm[13]  +  agtprm_fil.comm
                nv_sgnet[13]   =  nv_sgnet[13]   +  agtprm_fil.gross
                nv_sgres[13]   =  nv_sgres[13]   +  agtprm_fil.odue
                nv_sgbal[13]   =  nv_sgbal[13]   +  nv_netbal 
                nv_nsgbal[13]  =  nv_nsgbal[13]  +  agtprm_fil.gross - agtprm_fil.odue /*Lukkana M. A52-0241 22/10/2009*/.


            CASE agtprm_fil.acno_clicod:
                WHEN "RA" THEN
                    ASSIGN
                        nv_racodep[13]  = nv_racodep[13]  + agtprm_fil.prem
                        nv_racodec[13]  = nv_racodec[13]  + agtprm_fil.comm
                        nv_racoden[13]  = nv_racoden[13]  + agtprm_fil.gross
                        nv_racoder[13]  = nv_racoder[13]  + agtprm_fil.odue
                        nv_racodeb[13]  = nv_racodeb[13]  + nv_netbal
                        nv_nracodeb[13] = nv_nracodeb[13] + agtprm_fil.gross - agtprm_fil.odue. /*Lukkana M. A52-0241 21/10/2009*/
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
                        nv_rdcodep[13]  = nv_rdcodep[13]  + agtprm_fil.prem
                        nv_rdcodec[13]  = nv_rdcodec[13]  + agtprm_fil.comm 
                        nv_rdcoden[13]  = nv_rdcoden[13]  + agtprm_fil.gross
                        nv_rdcoder[13]  = nv_rdcoder[13]  + agtprm_fil.odue 
                        nv_rdcodeb[13]  = nv_rdcodeb[13]  + nv_netbal
                        nv_nrdcodeb[13] = nv_nrdcodeb[13] + agtprm_fil.gross - agtprm_fil.odue. /*Lukkana M. A52-0241 21/10/2009*/
                WHEN "RF" OR WHEN "RB" THEN 
                    ASSIGN
                        nv_rfcodep[13]  = nv_rfcodep[13]  + agtprm_fil.prem
                        nv_rfcodec[13]  = nv_rfcodec[13]  + agtprm_fil.comm 
                        nv_rfcoden[13]  = nv_rfcoden[13]  + agtprm_fil.gross
                        nv_rfcoder[13]  = nv_rfcoder[13]  + agtprm_fil.odue 
                        nv_rfcodeb[13]  = nv_rfcodeb[13]  + nv_netbal
                        nv_nrfcodeb[13] = nv_nrfcodeb[13] + agtprm_fil.gross - agtprm_fil.odue. /*Lukkana M. A52-0241 21/10/2009*/
            END CASE.
        END.
        ELSE IF YEAR(agtprm_fil.asdat) - YEAR(agtprm_fil.trndat) = 2 THEN DO: /* 2 year */
            ASSIGN
                nv_ffield[15]  =  agtprm_fil.gross     /* Detail */
                nv_sfield[15]  =  agtprm_fil.odue      /* Detail */
                nv_ftotal[15]  =  nv_ftotal[15]  +  agtprm_fil.gross
                nv_stotal[15]  =  nv_stotal[15]  +  agtprm_fil.odue
                nv_fgtotal[15] =  nv_fgtotal[15] +  agtprm_fil.gross
                nv_sgtotal[15] =  nv_sgtotal[15] +  agtprm_fil.odue
                
                nv_sprem[15]   =  nv_sprem[15]   +  agtprm_fil.prem
                nv_scomm[15]   =  nv_scomm[15]   +  agtprm_fil.comm
                nv_snet[15]    =  nv_snet[15]    +  agtprm_fil.gross
                nv_sres[15]    =  nv_sres[15]    +  agtprm_fil.odue
                nv_nsbal[15]   =  nv_nsbal[15]   +  agtprm_fil.gross - agtprm_fil.odue /*Lukkana M. A52-0241 22/10/2009*/
                nv_sbal[15]    =  nv_sbal[15]    +  nv_netbal
                nv_fieldbal[15] = nv_netbal     /* Detail Lukkana M. A52-0241 02/10/2009 */
                nv_totbal[15]   = nv_totbal[15]   +  nv_netbal /* Total Lukkana M. A52-0241 02/10/2009 */
                nv_stotbal[15]  = nv_stotbal[15]  +  nv_netbal /* Grand Total Lukkana M. A52-0241 02/10/2009 */
                
                nv_sgprem[15]  =  nv_sgprem[15]  +  agtprm_fil.prem
                nv_sgcomm[15]  =  nv_sgcomm[15]  +  agtprm_fil.comm
                nv_sgnet[15]   =  nv_sgnet[15]   +  agtprm_fil.gross
                nv_sgres[15]   =  nv_sgres[15]   +  agtprm_fil.odue
                nv_sgbal[15]   =  nv_sgbal[15]   +  nv_netbal 
                nv_nsgbal[15]  =  nv_nsgbal[15]  +  agtprm_fil.gross - agtprm_fil.odue /*Lukkana M. A52-0241 22/10/2009*/.

            CASE agtprm_fil.acno_clicod:
                WHEN "RA" THEN
                    ASSIGN
                        nv_racodep[15]  = nv_racodep[15]  + agtprm_fil.prem
                        nv_racodec[15]  = nv_racodec[15]  + agtprm_fil.comm
                        nv_racoden[15]  = nv_racoden[15]  + agtprm_fil.gross
                        nv_racoder[15]  = nv_racoder[15]  + agtprm_fil.odue
                        nv_racodeb[15]  = nv_racodeb[15]  + nv_netbal
                        nv_nracodeb[15] = nv_nracodeb[15] + agtprm_fil.gross - agtprm_fil.odue. /*Lukkana M. A52-0241 21/10/2009*/
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
                        nv_rdcodep[15]  = nv_rdcodep[15]  + agtprm_fil.prem
                        nv_rdcodec[15]  = nv_rdcodec[15]  + agtprm_fil.comm 
                        nv_rdcoden[15]  = nv_rdcoden[15]  + agtprm_fil.gross
                        nv_rdcoder[15]  = nv_rdcoder[15]  + agtprm_fil.odue 
                        nv_rdcodeb[15]  = nv_rdcodeb[15]  + nv_netbal
                        nv_nrdcodeb[15] = nv_nrdcodeb[15] + agtprm_fil.gross - agtprm_fil.odue. /*Lukkana M. A52-0241 21/10/2009*/
                WHEN "RF" OR WHEN "RB" THEN 
                    ASSIGN
                        nv_rfcodep[15]  = nv_rfcodep[15]  + agtprm_fil.prem
                        nv_rfcodec[15]  = nv_rfcodec[15]  + agtprm_fil.comm 
                        nv_rfcoden[15]  = nv_rfcoden[15]  + agtprm_fil.gross
                        nv_rfcoder[15]  = nv_rfcoder[15]  + agtprm_fil.odue 
                        nv_rfcodeb[15]  = nv_rfcodeb[15]  + nv_netbal
                        nv_nrfcodeb[15] = nv_nrfcodeb[15] + agtprm_fil.gross - agtprm_fil.odue. /*Lukkana M. A52-0241 21/10/2009*/
            END CASE.
        END.
        ELSE IF YEAR(agtprm_fil.asdat) - YEAR(agtprm_fil.trndat) = 3 THEN DO: /* 3 year */
            ASSIGN
                nv_ffield[16]  =  agtprm_fil.gross     /* Detail */
                nv_sfield[16]  =  agtprm_fil.odue      /* Detail */
                nv_ftotal[16]  =  nv_ftotal[16]  +  agtprm_fil.gross
                nv_stotal[16]  =  nv_stotal[16]  +  agtprm_fil.odue
                nv_fgtotal[16] =  nv_fgtotal[16] +  agtprm_fil.gross
                nv_sgtotal[16] =  nv_sgtotal[16] +  agtprm_fil.odue
                
                nv_sprem[16]   =  nv_sprem[16]   +  agtprm_fil.prem
                nv_scomm[16]   =  nv_scomm[16]   +  agtprm_fil.comm
                nv_snet[16]    =  nv_snet[16]    +  agtprm_fil.gross
                nv_sres[16]    =  nv_sres[16]    +  agtprm_fil.odue
                nv_nsbal[16]   =  nv_nsbal[16]   +  agtprm_fil.gross - agtprm_fil.odue /*Lukkana M. A52-0241 22/10/2009*/
                nv_sbal[16]    =  nv_sbal[16]    +  nv_netbal
                nv_fieldbal[16] = nv_netbal     /* Detail Lukkana M. A52-0241 02/10/2009 */
                nv_totbal[16]   = nv_totbal[16]   +  nv_netbal /* Total Lukkana M. A52-0241 02/10/2009 */
                nv_stotbal[16]  = nv_stotbal[16]  +  nv_netbal /* Grand Total Lukkana M. A52-0241 02/10/2009 */
                
                nv_sgprem[16]  =  nv_sgprem[16]  +  agtprm_fil.prem
                nv_sgcomm[16]  =  nv_sgcomm[16]  +  agtprm_fil.comm
                nv_sgnet[16]   =  nv_sgnet[16]   +  agtprm_fil.gross
                nv_sgres[16]   =  nv_sgres[16]   +  agtprm_fil.odue
                nv_sgbal[16]   =  nv_sgbal[16]   +  nv_netbal 
                nv_nsgbal[16]  =  nv_nsgbal[16]  +  agtprm_fil.gross - agtprm_fil.odue /*Lukkana M. A52-0241 22/10/2009*/.

            CASE agtprm_fil.acno_clicod:
                WHEN "RA" THEN
                    ASSIGN
                        nv_racodep[16]  = nv_racodep[16]  + agtprm_fil.prem
                        nv_racodec[16]  = nv_racodec[16]  + agtprm_fil.comm
                        nv_racoden[16]  = nv_racoden[16]  + agtprm_fil.gross
                        nv_racoder[16]  = nv_racoder[16]  + agtprm_fil.odue
                        nv_racodeb[16]  = nv_racodeb[16]  + nv_netbal
                        nv_nracodeb[16] = nv_nracodeb[16] + agtprm_fil.gross - agtprm_fil.odue. /*Lukkana M. A52-0241 21/10/2009*/
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
                        nv_rdcodep[16]  = nv_rdcodep[16]  + agtprm_fil.prem
                        nv_rdcodec[16]  = nv_rdcodec[16]  + agtprm_fil.comm 
                        nv_rdcoden[16]  = nv_rdcoden[16]  + agtprm_fil.gross
                        nv_rdcoder[16]  = nv_rdcoder[16]  + agtprm_fil.odue 
                        nv_rdcodeb[16]  = nv_rdcodeb[16]  + nv_netbal
                        nv_nrdcodeb[16] = nv_nrdcodeb[16] + agtprm_fil.gross - agtprm_fil.odue. /*Lukkana M. A52-0241 21/10/2009*/
                WHEN "RF" OR WHEN "RB" THEN 
                    ASSIGN
                        nv_rfcodep[16]  = nv_rfcodep[16]  + agtprm_fil.prem
                        nv_rfcodec[16]  = nv_rfcodec[16]  + agtprm_fil.comm 
                        nv_rfcoden[16]  = nv_rfcoden[16]  + agtprm_fil.gross
                        nv_rfcoder[16]  = nv_rfcoder[16]  + agtprm_fil.odue 
                        nv_rfcodeb[16]  = nv_rfcodeb[16]  + nv_netbal
                        nv_nrfcodeb[16] = nv_nrfcodeb[16] + agtprm_fil.gross - agtprm_fil.odue. /*Lukkana M. A52-0241 21/10/2009*/
            END CASE.
        END.
        ELSE IF YEAR(agtprm_fil.asdat) - YEAR(agtprm_fil.trndat) > 3 THEN DO: /* over 3 year */
            ASSIGN
                nv_ffield[17]  =  agtprm_fil.gross     /* Detail */
                nv_sfield[17]  =  agtprm_fil.odue      /* Detail */
                nv_ftotal[17]  =  nv_ftotal[17]  +  agtprm_fil.gross
                nv_stotal[17]  =  nv_stotal[17]  +  agtprm_fil.odue
                nv_fgtotal[17] =  nv_fgtotal[17] +  agtprm_fil.gross
                nv_sgtotal[17] =  nv_sgtotal[17] +  agtprm_fil.odue
                
                nv_sprem[17]   =  nv_sprem[17]   +  agtprm_fil.prem
                nv_scomm[17]   =  nv_scomm[17]   +  agtprm_fil.comm
                nv_snet[17]    =  nv_snet[17]    +  agtprm_fil.gross
                nv_sres[17]    =  nv_sres[17]    +  agtprm_fil.odue
                nv_nsbal[17]   =  nv_nsbal[17]   +  agtprm_fil.gross - agtprm_fil.odue /*Lukkana M. A52-0241 22/10/2009*/
                nv_sbal[17]    =  nv_sbal[17]    +  nv_netbal 
                nv_fieldbal[17] = nv_netbal     /* Detail Lukkana M. A52-0241 02/10/2009 */
                nv_totbal[17]   = nv_totbal[17]   +  nv_netbal /* Total Lukkana M. A52-0241 02/10/2009 */
                nv_stotbal[17]  = nv_stotbal[17]  +  nv_netbal /* Grand Total Lukkana M. A52-0241 02/10/2009 */
                
                nv_sgprem[17]  =  nv_sgprem[17]  +  agtprm_fil.prem
                nv_sgcomm[17]  =  nv_sgcomm[17]  +  agtprm_fil.comm
                nv_sgnet[17]   =  nv_sgnet[17]   +  agtprm_fil.gross
                nv_sgres[17]   =  nv_sgres[17]   +  agtprm_fil.odue
                nv_sgbal[17]   =  nv_sgbal[17]   +  nv_netbal 
                nv_nsgbal[17]  =  nv_nsgbal[17]  +  agtprm_fil.gross - agtprm_fil.odue /*Lukkana M. A52-0241 22/10/2009*/.

            CASE agtprm_fil.acno_clicod:
                WHEN "RA" THEN
                    ASSIGN
                        nv_racodep[17]  = nv_racodep[17]  + agtprm_fil.prem
                        nv_racodec[17]  = nv_racodec[17]  + agtprm_fil.comm
                        nv_racoden[17]  = nv_racoden[17]  + agtprm_fil.gross
                        nv_racoder[17]  = nv_racoder[17]  + agtprm_fil.odue
                        nv_racodeb[17]  = nv_racodeb[17]  + nv_netbal
                        nv_nracodeb[17] = nv_nracodeb[17] + agtprm_fil.gross - agtprm_fil.odue. /*Lukkana M. A52-0241 21/10/2009*/
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
                        nv_rdcodep[17]  = nv_rdcodep[17]  + agtprm_fil.prem
                        nv_rdcodec[17]  = nv_rdcodec[17]  + agtprm_fil.comm 
                        nv_rdcoden[17]  = nv_rdcoden[17]  + agtprm_fil.gross
                        nv_rdcoder[17]  = nv_rdcoder[17]  + agtprm_fil.odue 
                        nv_rdcodeb[17]  = nv_rdcodeb[17]  + nv_netbal
                        nv_nrdcodeb[17] = nv_nrdcodeb[17] + agtprm_fil.gross - agtprm_fil.odue. /*Lukkana M. A52-0241 21/10/2009*/
                WHEN "RF" OR WHEN "RB" THEN 
                    ASSIGN
                        nv_rfcodep[17]  = nv_rfcodep[17]  + agtprm_fil.prem
                        nv_rfcodec[17]  = nv_rfcodec[17]  + agtprm_fil.comm 
                        nv_rfcoden[17]  = nv_rfcoden[17]  + agtprm_fil.gross
                        nv_rfcoder[17]  = nv_rfcoder[17]  + agtprm_fil.odue 
                        nv_rfcodeb[17]  = nv_rfcodeb[17]  + nv_netbal
                        nv_nrfcodeb[17] = nv_nrfcodeb[17] + agtprm_fil.gross - agtprm_fil.odue. /*Lukkana M. A52-0241 21/10/2009*/
            END CASE.
        END.
        /*--  Lukkana M. A52-0241 24/09/2009  --*/
    END.
