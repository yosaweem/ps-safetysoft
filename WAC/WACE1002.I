/***************************************
wace1002.i  -  DR & CR Matching  ใช้ใน wace1001.w - Debit Note & Credit Note Matching
CREATE BY :  Kanchana C.        A46-0478

    - mark record  สำหรับ ทำการ match 
***************************************/

    DO WITH FRAME frwacm001:
        /* M */
        FOR EACH wacm001_m USE-INDEX acm00104  
                                                        WHERE wacm001_m.policy = nv_polclick :
            IF wacm001_m.disput = YES THEN DO:
                ASSIGN
                    wacm001_m.disput = NO
                    nv_cntTotDr = nv_cntTotDr - 1
                    nv_sumDr     = nv_sumDr -  wacm001_m.bal.
            END.
            ELSE DO:
                ASSIGN
                    wacm001_m.disput = YES
                    nv_cntTotDr = nv_cntTotDr + 1
                    nv_sumDr     = nv_sumDr +  wacm001_m.bal .
            END.
        END.

        /* R */
        FOR EACH wacm001_r  USE-INDEX acm00104  
                                                        WHERE wacm001_r.policy = nv_polclick :
            IF wacm001_r.disput = YES THEN DO:
                ASSIGN
                    wacm001_r.disput = NO
                    nv_cntTotCr = nv_cntTotCr - 1
                    nv_sumCr     = nv_sumCr -  wacm001_r.bal.
            END.
            ELSE DO:
                ASSIGN
                    wacm001_r.disput = YES
                    nv_cntTotCr = nv_cntTotCr + 1
                    nv_sumCr     = nv_sumCr +  wacm001_r.bal .
            END.
        END.

        ASSIGN
            ficntTotDr = nv_cntTotDr
            fisumDr = nv_sumDr   
            ficntTotCr = nv_cntTotCr
            fisumCr = nv_sumCr.

        DISP
            ficntTotDr
            fisumDr
            ficntTotCr
            fisumCr
           .

        IF /*(nv_sumDr + nv_sumCr ) <> 0   AND */ (nv_sumDr  = nv_sumCr  *  -1) THEN DO:  /* มีค่าที่จะ match */
            fisumDr:BGCOLOR = 15 .
            fisumCr:BGCOLOR = 15.

            nv_chkMatch = YES.
        END.
        ELSE DO:                /* ไม่มีค่าที่จะ match */
            fisumDr:BGCOLOR = 6 .
            fisumCr:BGCOLOR = 6.

            nv_chkMatch = NO.
        END.
        
        DISP fisumDr fisumCr.
        
    END. /* frame frwacm001 */

    nv_chkMatch = IF (nv_sumDr = 0)  OR  (nv_sumDr  <> nv_sumCr * -1 ) THEN NO ELSE YES.


        
        IF nv_chkMatch = NO THEN 
            DISABLE buMatch WITH FRAME frDrCr. 
        ELSE 
            ENABLE buMatch WITH FRAME frDrCr.



/*******
    DO WITH FRAME frwacm001:
        /* M */
        FOR EACH bufwacm001_m WHERE bufwacm001_m.policy = nv_polclick :
            IF bufwacm001_m.disput = YES THEN DO:
                ASSIGN
                    bufwacm001_m.disput = NO
                    nv_cntTotDr = nv_cntTotDr - 1
                    nv_sumDr     = nv_sumDr -  bufwacm001_m.bal.
            END.
            ELSE DO:
                ASSIGN
                    bufwacm001_m.disput = YES
                    nv_cntTotDr = nv_cntTotDr + 1
                    nv_sumDr     = nv_sumDr +  bufwacm001_m.bal .
            END.
        END.

        /* R */
        FOR EACH bufwacm001_r WHERE bufwacm001_r.policy = nv_polclick :
            IF bufwacm001_r.disput = YES THEN DO:
                ASSIGN
                    bufwacm001_r.disput = NO
                    nv_cntTotCr = nv_cntTotCr - 1
                    nv_sumCr     = nv_sumCr -  bufwacm001_m.bal.
            END.
            ELSE DO:
                ASSIGN
                    bufwacm001_r.disput = YES
                    nv_cntTotCr = nv_cntTotCr + 1
                    nv_sumCr     = nv_sumCr +  bufwacm001_m.bal .
            END.
        END.

        DISP
            nv_cntTotDr @ ficntTotDr
            nv_sumDr   @ fisumDr
            nv_cntTotCr @ ficntTotCr
            nv_sumCr   @ fisumCr
            .

        IF (nv_sumDr + nv_sumCr ) <> 0 THEN DO:
            fisumDr:BGCOLOR = 6 .
            fisumCr:BGCOLOR = 6.
        END.
        ELSE DO:
            fisumDr:BGCOLOR = 15 .
            fisumCr:BGCOLOR = 15.
        END.

    END.
    
*****/
