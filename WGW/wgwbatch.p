/* WGWBATCH.P  : Program Running Batch No. of Import Data File        */
/* Copyright   # Safety Insurance Public Company Limited              */
/*               บริษัท ประกันคุ้มภัย จำกัด (มหาชน)                   */
/* WRITE       : Wantanee S.     29/09/2006                           */
/* WRITE       : Narin L.        03/12/2010                           */
/* เพิ่ม Message เช็คเงื่อนไขกรณีที่ code producer ระบุไม่ถูกต้องกับเลขที่ batch no */
/* Modify by   : Kridtiya i. A63-00472 เช็คสาขา 2 หลัก*/
/* Modify by   : Ranu I. A64-0369 แก้ไข Running batch no ของ Standard templete */
/*--------------------------------------------------------------------*/

DEFINE INPUT        PARAMETER pn_trndat   AS DATE.
DEFINE INPUT        PARAMETER pn_batchyr  AS INT.
DEFINE INPUT        PARAMETER pn_acno1    AS CHAR.
DEFINE INPUT        PARAMETER pn_batbrn   AS CHAR.
DEFINE INPUT        PARAMETER pn_batprev  AS CHAR.
DEFINE INPUT        PARAMETER pn_prog     AS CHAR.
DEFINE INPUT-OUTPUT PARAMETER pn_batchno  AS CHAR.
DEFINE INPUT-OUTPUT PARAMETER pn_batcnt   AS INT.
DEFINE INPUT        PARAMETER pn_recimp   AS INT.
DEFINE INPUT        PARAMETER pn_premimp  AS DECI.

/*DEFINE VAR nv_batrunno  AS INT     FORMAT ">,>>9"     INIT 0.*/ /*A64-0369*/
DEFINE VAR nv_batrunno  AS INT     FORMAT ">>>>>9"  INIT 0.      /*A64-0369*/
DEFINE VAR nv_usrid     AS CHAR    FORMAT "X(8)"    INIT 0.
DEFINE VAR nv_batchno   AS CHAR    FORMAT "X(12)" .
DEFINE VAR nv_branch    AS CHAR    FORMAT "X(2)".
DEFINE VAR nv_batcnt    AS INT.

nv_usrid  = USERID(LDBNAME(1)).

IF LENGTH(TRIM(pn_batbrn)) < 2 THEN nv_branch = "0" + TRIM(pn_batbrn). 
ELSE nv_branch = TRIM(pn_batbrn).

/*  pu   uzm70001    3 + batchyr
                         branch
                         acno
*/
/*-------------------- Running Batch No. ---------------------------*/
nv_batcnt = 0.
IF pn_batprev = "" THEN DO:  /* เป็นการนำเข้าข้อมูลครั้งแรกของไฟล์นั้นๆ */

    FIND LAST uzm700 USE-INDEX uzm70001
        WHERE uzm700.bchyr   = pn_batchyr      AND
              uzm700.branch  = TRIM(pn_batbrn) AND
              uzm700.acno    = TRIM(pn_acno1)  NO-ERROR.
    IF NOT AVAIL uzm700 THEN DO:   /* ยังไม่เคยมีการนำเข้าข้อมูลสำหรับ Account No. และ Branch นี้ */
        CREATE uzm700.
        ASSIGN
           uzm700.bchyr    = pn_batchyr
           uzm700.acno     = CAPS(TRIM(pn_acno1))
           uzm700.branch   = CAPS(TRIM(pn_batbrn))
           uzm700.runno    = 1                      
           uzm700.usrid    = nv_usrid               
           uzm700.enttim   = STRING(TIME,"HH:MM:SS")
           uzm700.updat    = TODAY
           uzm700.prog     = pn_prog.

        ASSIGN
          nv_batrunno = 1
          pn_batcnt   = 1.
          pn_batchno  = TRIM(TRIM(pn_acno1) + STRING(nv_branch,"99") + STRING(nv_batrunno,"9999")).  
        IF index(pn_acno1,"EMP") <> 0 AND pn_batbrn = "EM" THEN pn_batchno  = TRIM(TRIM(pn_acno1) + STRING(nv_branch,"99") + STRING(nv_batrunno,"99999")). /*A64-0369*/
             
    END.
    ELSE DO:   /* เคยนำเข้าแล้วสำหรับ  Account No. และ Branch นี้
              ด้ running 4 หลักหลัง Branch */
        ASSIGN
          nv_batrunno = uzm700.runno + 1   /*** update ค่า  running batch no. ***/
          pn_batcnt   = 1.

        ASSIGN
          uzm700.runno = nv_batrunno
          uzm700.updat = TODAY.
          pn_batchno = TRIM(TRIM(pn_acno1) + STRING(nv_branch,"99") + STRING(nv_batrunno,"9999")).  
        IF index(pn_acno1,"EMP") <> 0 AND pn_batbrn = "EM" THEN pn_batchno  = TRIM(TRIM(pn_acno1) + STRING(nv_branch,"99") + STRING(nv_batrunno,"99999")). /*A64-0369*/
      
    END.
    /* add by : A64-0369 เพิ่มหลัก Running batch สำหรับงานโหลด Standard */
    IF index(pn_acno1,"EMP") <> 0 AND pn_batbrn = "EM" THEN DO:
        FIND FIRST uzm701 USE-INDEX uzm70101 
            WHERE  uzm701.branch  = TRIM(pn_batbrn)     AND
                   uzm701.acno    = TRIM(pn_acno1)      AND
                   uzm701.bchyr   = pn_batchyr          AND
                   uzm701.bchno   = TRIM(pn_acno1) + 
                                    STRING(nv_branch,"99") +
                                    STRING(nv_batrunno,"99999") NO-ERROR.
        IF NOT AVAIL uzm701 THEN DO:
          CREATE uzm701.
          ASSIGN
             uzm701.acno       = TRIM(pn_acno1)
             uzm701.branch     = TRIM(pn_batbrn)
             uzm701.bchyr      = pn_batchyr
             uzm701.bchno      = TRIM(pn_acno1) +           
                                 STRING(nv_branch,"99") +          
                                 STRING (nv_batrunno,"99999")
             uzm701.bchcnt     = 1        
        
             uzm701.trndat     = TODAY
             uzm701.recinp     = pn_recimp   /*Shukiat T. Note Rename Field 26/10/2006*/
             uzm701.preminp    = pn_premimp
             uzm701.prog       = pn_prog
             uzm701.impusrid   = nv_usrid
             uzm701.impdat     = TODAY      /*Shukiat T. Note Rename Field 26/10/2006*/
             uzm701.impbegtim  = STRING(TIME,"HH:MM:SS").
        END.
    END.
    /* end : A64-0369 เพิ่มหลัก Running batch สำหรับงานโหลด Standard */
    ELSE DO:
        FIND FIRST uzm701 USE-INDEX uzm70101 
            WHERE  uzm701.branch  = TRIM(pn_batbrn)     AND
                   uzm701.acno    = TRIM(pn_acno1)      AND
                   uzm701.bchyr   = pn_batchyr          AND
                   uzm701.bchno   = TRIM(pn_acno1) + 
                                    STRING(nv_branch,"99") +
                                    STRING(nv_batrunno,"9999") NO-ERROR.
        IF NOT AVAIL uzm701 THEN DO:
          CREATE uzm701.
          ASSIGN
             uzm701.acno       = TRIM(pn_acno1)
             uzm701.branch     = TRIM(pn_batbrn)
             uzm701.bchyr      = pn_batchyr
             uzm701.bchno      = TRIM(pn_acno1) +           
                                 STRING(nv_branch,"99") +          
                                 STRING (nv_batrunno,"9999")
             uzm701.bchcnt     = 1         
        
             uzm701.trndat     = TODAY
             uzm701.recinp     = pn_recimp   /*Shukiat T. Note Rename Field 26/10/2006*/
             uzm701.preminp    = pn_premimp
             uzm701.prog       = pn_prog
             uzm701.impusrid   = nv_usrid
             uzm701.impdat     = TODAY      /*Shukiat T. Note Rename Field 26/10/2006*/
             uzm701.impbegtim  = STRING(TIME,"HH:MM:SS").
        
        END.
    END.

END.
ELSE DO:   /* มีการระบุ  batchno previous  */
    
    IF SUBSTRING(pn_batprev,1,7) <> pn_acno1 OR
       SUBSTRING(pn_batprev,8,2) <> nv_branch THEN DO:

        BELL. BELL.
/*  Comment By Narin A52-0242  
      MESSAGE "Batch file Not match to Account No. OR Branch..!!!" VIEW-AS ALERT-BOX ERROR. 
      PAUSE 10 NO-MESSAGE.
*/
        MESSAGE "Batch File Not Match to Account No. OR Branch..!!!"  SKIP
/*-----A52-0242------*/ 
            VIEW-AS ALERT-BOX WARNING BUTTONS OK
            TITLE "Warning Message" UPDATE choice AS LOGICAL.
            IF choice THEN DO:
               MESSAGE COLOR YELLOW "ยกเลิกกระบวนการ Process Data !!!" VIEW-AS ALERT-BOX QUESTION.  
               RETURN NO-APPLY.
            END.
            
    END.   /*IF SUBSTRING(pn_batprev,1,7) <> pn_acno1*/
    
/**/    ELSE DO:
/*-----END A52-0242------*/ 
        FIND LAST uzm701 USE-INDEX uzm70102
            WHERE uzm701.bchyr = pn_batchyr       AND
                  uzm701.bchno = TRIM(pn_batprev) 
        NO-ERROR .
        IF NOT AVAIL uzm701 THEN DO:
          MESSAGE "Not found Batch File Master : " + CAPS (pn_batprev)
                + " on file uzm701" VIEW-AS ALERT-BOX ERROR.
          PAUSE 10 NO-MESSAGE.
        END.
        ELSE DO:   /*--- พบ batch no. นี้อยู่แล้ว ---*/
            
/*               IF SUBSTRING(pn_batprev,1,7)  <>  pn_acno1 THEN DO:                                */
/*                  MESSAGE "Please Check Producer Code <> Prev Batch " VIEW-AS ALERT-BOX QUESTION. */
/*                  RETURN NO-APPLY.                                                                */
/*               END.                                                                               */
/*               ELSE DO:                                                                           */
          
            nv_batcnt = uzm701.bchcnt + 1.

            CREATE uzm701.
            ASSIGN
                uzm701.acno       = TRIM(pn_acno1)  
                uzm701.branch     = TRIM(pn_batbrn)
                uzm701.bchyr      = pn_batchyr
                uzm701.bchno      = TRIM(pn_batprev)
                uzm701.bchcnt     = nv_batcnt

                uzm701.trndat     = TODAY
                uzm701.recinp     = pn_recimp  /*Shukiat T. rename Field on 26/10/2006*/
                uzm701.preminp    = pn_premimp
                uzm701.prog       = pn_prog   
                uzm701.impusrid   = nv_usrid
                uzm701.impdat     = TODAY     /*Shukiat T. rename Field on 26/10/2006*/    
                uzm701.impbegtim  = STRING(TIME,"HH:MM:SS").


            pn_batchno = TRIM(pn_batprev).
            pn_batcnt = nv_batcnt.

/*               END. /*IF SUBSTRING(pn_batprev,1,7)  <>  pn_acno1 THEN DO:*/ */

        END. /* IF NOT AVAIL uzm701 THEN DO: */
  /*-----A52-0242------*/ 
/**/    END.
  /*-----END A52-0242------*/ 
END.
RELEASE uzm700.
RELEASE uzm701.

/*-------------------- END Running Batch No. -----------------------*/
