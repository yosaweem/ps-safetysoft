/* WGWBCHVT.P  : Program Running Batch No. of Load VAT                */
/* Copyright   # Safety Insurance Public Company Limited              */
/*               บริษัท ประกันคุ้มภัย จำกัด (มหาชน)                   */
/* WRITE       : TANTAWAN C.  [A500096 : 09/05/2007]                  */
/*--------------------------------------------------------------------*/

DEFINE INPUT        PARAMETER pn_trndat   AS DATE.
DEFINE INPUT        PARAMETER pn_batchyr  AS INT.
DEFINE INPUT        PARAMETER pn_acno1    AS CHAR.
DEFINE INPUT        PARAMETER pn_batbrn   AS CHAR.
DEFINE INPUT        PARAMETER pn_batprev  AS CHAR.
DEFINE INPUT        PARAMETER pn_prog     AS CHAR.
DEFINE INPUT        PARAMETER pn_invtyp   AS CHAR.
DEFINE INPUT-OUTPUT PARAMETER pn_batchno  AS CHAR.
DEFINE INPUT-OUTPUT PARAMETER pn_batcnt   AS INT.
DEFINE INPUT        PARAMETER pn_recimp   AS INT.
DEFINE INPUT        PARAMETER pn_premimp  AS DECI.

DEFINE VAR nv_batrunno  AS INT     FORMAT ">,>>9"     INIT 0.
DEFINE VAR nv_usrid     AS CHAR    FORMAT "X(8)"      INIT 0.
DEFINE VAR nv_batchno   AS CHAR    FORMAT "X(12)" .
DEFINE VAR nv_branch    AS CHAR    FORMAT "X(2)".

DEFINE VAR nv_batcnt  AS INT.

nv_usrid  = USERID(LDBNAME("brstat")).

IF LENGTH(TRIM(pn_batbrn)) <= 2 THEN nv_branch = "0" + TRIM(pn_batbrn). 
ELSE nv_branch = TRIM(pn_batbrn).

/*  pu   uzm70201    4 + invtyp
                         batchyr
                         branch
                         acno
*/

/*-------------------- Running Batch No. ---------------------------*/
    nv_batcnt = 0.

    IF pn_batprev = "" THEN DO:  /* เป็นการนำเข้าข้อมูลครั้งแรกของไฟล์นั้นๆ */

        FIND LAST uzm702 USE-INDEX uzm70201
            WHERE uzm702.invtyp  = TRIM(pn_invtyp) AND
                  uzm702.bchyr   = pn_batchyr      AND
                  uzm702.branch  = TRIM(pn_batbrn) AND
                  uzm702.acno    = TRIM(pn_acno1)
        NO-ERROR.
        IF NOT AVAIL uzm702 THEN DO:   /* ยังไม่เคยมีการนำเข้าข้อมูลสำหรับ 
                                          Invoice type,
                                          Account No.
                                          Branch นี้ */
            CREATE uzm702.
            ASSIGN
               uzm702.invtyp   = CAPS(TRIM(pn_invtyp))
               uzm702.bchyr    = pn_batchyr
               uzm702.acno     = CAPS(TRIM(pn_acno1))
               uzm702.branch   = CAPS(TRIM(pn_batbrn))
               uzm702.runno    = 1                      
               uzm702.usrid    = nv_usrid               
               uzm702.enttim   = STRING(TIME,"HH:MM:SS")
               uzm702.updat    = TODAY
               uzm702.prog     = pn_prog.

            ASSIGN
              nv_batrunno = 1
              pn_batcnt   = 1.              
              pn_batchno  = TRIM(TRIM(pn_acno1) + STRING(nv_branch,"99") + STRING(nv_batrunno,"9999")).

        END.
        ELSE DO:   /* เคยนำเข้าแล้วสำหรับ  Account No. และ Branch นี้
                                      ได้ running 4 หลักหลัง Branch */
            ASSIGN
              nv_batrunno = uzm702.runno + 1   /*** update ค่า  running batch no. ***/
              pn_batcnt   = 1.

            ASSIGN
              uzm702.runno = nv_batrunno
              uzm702.updat = TODAY.

            pn_batchno = TRIM(TRIM(pn_acno1) + STRING(nv_branch,"99") + STRING(nv_batrunno,"9999")).

        END.

        FIND FIRST uzm703 USE-INDEX uzm70301 
            WHERE  uzm703.invtyp  = TRIM(pn_invtyp) AND
                   uzm703.branch  = TRIM(pn_batbrn) AND
                   uzm703.acno    = TRIM(pn_acno1)  AND
                   uzm703.bchyr   = pn_batchyr      AND
                   uzm703.bchno   = TRIM(pn_acno1) + 
                                    STRING(nv_branch,"99") + 
                                    STRING(nv_batrunno,"9999")
        NO-LOCK NO-ERROR.
        IF NOT AVAIL uzm703 THEN DO:

          CREATE uzm703.
          ASSIGN
             uzm703.invtyp    = TRIM(pn_invtyp)
             uzm703.acno      = TRIM(pn_acno1)
             uzm703.branch    = TRIM(pn_batbrn)
             uzm703.bchyr     = pn_batchyr
             uzm703.bchno     = TRIM(pn_acno1) +           
                                STRING(nv_branch,"99") +          
                                STRING (nv_batrunno,"9999")
             uzm703.bchcnt    = 1         
                              
             uzm703.trndat    = TODAY
             uzm703.recinp    = pn_recimp
             uzm703.preminp   = pn_premimp
             uzm703.prog      = pn_prog
             uzm703.impusrid  = nv_usrid
             uzm703.impdat    = TODAY
             uzm703.impbegtim = STRING(TIME,"HH:MM:SS").
        END.
    END.
    ELSE DO:   /* มีการระบุ  batchno previous  */

        IF SUBSTRING(pn_batprev,1,7) <> pn_acno1 OR
           SUBSTRING(pn_batprev,8,2) <> nv_branch THEN DO:
            BELL. BELL.
            MESSAGE "Batch file Not match to Account No. OR Branch..!!!" VIEW-AS ALERT-BOX ERROR.
            PAUSE 10 NO-MESSAGE.
        END.                    
        
        FIND LAST uzm703 USE-INDEX uzm70302
            WHERE uzm703.invtyp = TRIM(pn_invtyp) AND
                  uzm703.bchyr  = pn_batchyr      AND
                  uzm703.bchno  = TRIM(pn_batprev) 
        NO-ERROR .
        IF NOT AVAIL uzm703 THEN DO:
          MESSAGE "Not found Batch File Master : " + CAPS (pn_batprev)
                + " on file uzm703" VIEW-AS ALERT-BOX ERROR.
          PAUSE 10 NO-MESSAGE.
        END.
        ELSE DO:   /*--- พบ batch no. นี้อยู่แล้ว ---*/

            nv_batcnt = uzm703.bchcnt + 1.

            CREATE uzm703.
            ASSIGN
                uzm703.invtyp    = TRIM(pn_invtyp)
                uzm703.acno      = TRIM(pn_acno1)  
                uzm703.branch    = TRIM(pn_batbrn)
                uzm703.bchyr     = pn_batchyr
                uzm703.bchno     = TRIM(pn_batprev)
                uzm703.bchcnt    = nv_batcnt

                uzm703.trndat    = TODAY
                uzm703.recinp    = pn_recimp  /*Shukiat T. rename Field on 26/10/2006*/
                uzm703.preminp   = pn_premimp
                uzm703.prog      = pn_prog   
                uzm703.impusrid  = nv_usrid
                uzm703.impdat    = TODAY     /*Shukiat T. rename Field on 26/10/2006*/    
                uzm703.impbegtim = STRING(TIME,"HH:MM:SS").
            
            pn_batchno = TRIM(pn_batprev).
            pn_batcnt = nv_batcnt.

        END.
    END.

/*-------------------- END Running Batch No. -----------------------*/
