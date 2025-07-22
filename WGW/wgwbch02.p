/* WGWBCH02.P  : Program Running Batch No. Input-Output Text File (Pipe)*/
/* Copyright   # Safety Insurance Public Company Limited                */
/*               บริษัท ประกันคุ้มภัย จำกัด (มหาชน)                     */
/* WRITE       : TANTAWAN C.  [A51-0140 : 18/09/2008]                   */
/*----------------------------------------------------------------------*/

DEFINE INPUT        PARAMETER pn_trndat   AS DATE.
DEFINE INPUT        PARAMETER pn_bchyr    AS INT.
DEFINE INPUT        PARAMETER pn_acno1    AS CHAR.
DEFINE INPUT        PARAMETER pn_bchbrn   AS CHAR.
DEFINE INPUT        PARAMETER pn_bchprev  AS CHAR.
DEFINE INPUT        PARAMETER pn_prog     AS CHAR.
DEFINE INPUT        PARAMETER pn_bchtyp   AS CHAR.
DEFINE INPUT-OUTPUT PARAMETER pn_batchno  AS CHAR.
DEFINE INPUT-OUTPUT PARAMETER pn_batcnt   AS INT.
DEFINE INPUT        PARAMETER pn_recinp   AS INT.

DEFINE VAR nv_batrunno  AS INT     FORMAT ">,>>9"     INIT 0.
DEFINE VAR nv_usrid     AS CHAR    FORMAT "X(8)"      INIT 0.
DEFINE VAR nv_batchno   AS CHAR    FORMAT "X(12)" .
DEFINE VAR nv_branch    AS CHAR    FORMAT "X(2)".
DEFINE VAR nv_acno      AS CHAR    FORMAT "X(10)".

DEFINE VAR nv_batcnt  AS INT.

nv_usrid  = USERID(LDBNAME("brstat")).

IF LENGTH(TRIM(pn_bchbrn)) = 1 THEN nv_branch = "0" + TRIM(pn_bchbrn). 
ELSE nv_branch = TRIM(pn_bchbrn).

IF LENGTH(TRIM(pn_acno1)) = 7 THEN nv_acno = TRIM(pn_acno1) + "000".
ELSE nv_acno = TRIM(pn_acno1).


/*  pu   uzm70401    4 + bchtyp
                         batchyr
                         branch
                         acno
*/

/*-------------------- Running Batch No. ---------------------------*/
    nv_batcnt = 0.

    IF pn_bchprev = "" THEN DO:  /* เป็นการนำเข้าข้อมูลครั้งแรกของไฟล์นั้นๆ */

        FIND LAST uzm704 USE-INDEX uzm70401
            WHERE uzm704.bchtyp  = TRIM(pn_bchtyp) AND
                  uzm704.bchyr   = pn_bchyr      AND
                  uzm704.branch  = TRIM(pn_bchbrn) AND
                  uzm704.acno    = TRIM(pn_acno1)
        NO-ERROR.
        IF NOT AVAIL uzm704 THEN DO:   /* ยังไม่เคยมีการนำเข้าข้อมูลสำหรับ 
                                          batch type,
                                          Account No.
                                          Branch นี้ */
            CREATE uzm704.
            ASSIGN
               uzm704.bchtyp   = CAPS(TRIM(pn_bchtyp))
               uzm704.bchyr    = pn_bchyr
               uzm704.acno     = CAPS(TRIM(pn_acno1))
               uzm704.branch   = CAPS(TRIM(pn_bchbrn))
               uzm704.runno    = 1                      
               uzm704.usrid    = nv_usrid  
               uzm704.entdat   = TODAY
               uzm704.enttim   = STRING(TIME,"HH:MM:SS")
               uzm704.updat    = TODAY
               uzm704.prog     = pn_prog.

            ASSIGN
              nv_batrunno = 1
              pn_batcnt   = 1.              
              pn_batchno  = TRIM(TRIM(nv_acno) + STRING(nv_branch,"99") + STRING(nv_batrunno,"9999")).

        END.
        ELSE DO:   /* เคยนำเข้าแล้วสำหรับ  Account No. และ Branch นี้
                                      ได้ running 4 หลักหลัง Branch */
            ASSIGN
              nv_batrunno = uzm704.runno + 1   /*** update ค่า  running batch no. ***/
              pn_batcnt   = 1.

            ASSIGN
              uzm704.runno = nv_batrunno
              uzm704.updat = TODAY.

            pn_batchno = TRIM(TRIM(nv_acno) + STRING(nv_branch,"99") + STRING(nv_batrunno,"9999")).

        END.

        FIND FIRST uzm705 USE-INDEX uzm70501 
            WHERE  uzm705.bchtyp  = TRIM(pn_bchtyp) AND
                   uzm705.branch  = TRIM(pn_bchbrn) AND
                   uzm705.acno    = TRIM(pn_acno1)  AND
                   uzm705.bchyr   = pn_bchyr      AND
                   uzm705.bchno   = TRIM(nv_acno) + 
                                    STRING(nv_branch,"99") + 
                                    STRING(nv_batrunno,"9999")
        NO-LOCK NO-ERROR.
        IF NOT AVAIL uzm705 THEN DO:

          CREATE uzm705.
          ASSIGN
             uzm705.bchtyp    = TRIM(pn_bchtyp)
             uzm705.acno      = TRIM(pn_acno1)
             uzm705.branch    = TRIM(pn_bchbrn)
             uzm705.bchyr     = pn_bchyr
             uzm705.bchno     = TRIM(nv_acno) +           
                                STRING(nv_branch,"99") +          
                                STRING (nv_batrunno,"9999")
             uzm705.bchcnt    = 1         
                              
             uzm705.trndat    = TODAY
             uzm705.recinp    = pn_recinp
             uzm705.recout    = 0
             uzm705.prog      = pn_prog
             uzm705.inpusrid  = nv_usrid
             uzm705.inpdat    = TODAY
             uzm705.inptim    = STRING(TIME,"HH:MM:SS")
             uzm705.inpflg    = YES .
        END.
    END.
    ELSE DO:   /* มีการระบุ  batchno previous  */

        /* branch 1 หลัก */
        IF LENGTH(TRIM(pn_acno1)) = 7 THEN DO:

            IF SUBSTRING(pn_bchprev,1,7)  <> pn_acno1 OR
               SUBSTRING(pn_bchprev,11,2) <> nv_branch THEN DO:
                BELL. BELL.
                MESSAGE "1:Batch file Not match to Account No. OR Branch..!!!" VIEW-AS ALERT-BOX ERROR.
                PAUSE 10 NO-MESSAGE.
            END. 

        END.
        /* branch 1 หลัก */
        ELSE DO:
            IF SUBSTRING(pn_bchprev,1,10) <> pn_acno1 OR
               SUBSTRING(pn_bchprev,11,2) <> nv_branch THEN DO:
                BELL. BELL.
                MESSAGE "2:Batch file Not match to Account No. OR Branch..!!!" VIEW-AS ALERT-BOX ERROR.
                PAUSE 10 NO-MESSAGE.
            END. 

        END.     
                   
        
        FIND LAST uzm705 USE-INDEX uzm70502
            WHERE uzm705.bchtyp = TRIM(pn_bchtyp) AND
                  uzm705.bchyr  = pn_bchyr      AND
                  uzm705.bchno  = TRIM(pn_bchprev) 
        NO-ERROR .
        IF NOT AVAIL uzm705 THEN DO:
          MESSAGE "Not found Batch File Master : " + CAPS (pn_bchprev)
                + " on file uzm705" VIEW-AS ALERT-BOX ERROR.
          PAUSE 10 NO-MESSAGE.
        END.
        ELSE DO:   /*--- พบ batch no. นี้อยู่แล้ว ---*/

            nv_batcnt = uzm705.bchcnt + 1.

            CREATE uzm705.
            ASSIGN
                uzm705.bchtyp    = TRIM(pn_bchtyp)
                uzm705.acno      = TRIM(pn_acno1)
                uzm705.branch    = TRIM(pn_bchbrn)
                uzm705.bchyr     = pn_bchyr
                uzm705.bchno     = TRIM(pn_bchprev)
                uzm705.bchcnt    = nv_batcnt
                
                uzm705.trndat    = TODAY
                uzm705.recinp    = pn_recinp
                uzm705.recout    = 0
                uzm705.prog      = pn_prog
                uzm705.inpusrid  = nv_usrid
                uzm705.inpdat    = TODAY
                uzm705.inptim    = STRING(TIME,"HH:MM:SS")
                uzm705.inpflg    = YES .

            pn_batchno = TRIM(pn_bchprev).
            pn_batcnt = nv_batcnt.

        END.
    END.

/*-------------------- END Running Batch No. -----------------------*/
