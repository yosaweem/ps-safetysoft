/************************************************************************/
/* WacTRec3.p    : Program Tranfer Receipt Check data Difference        */
/* Copyright	: Safety Insurance Public Company Limited 				*/
/*			      บริษัท ประกันคุ้มภัย จำกัด (มหาชน)					*/
/* CREATE BY	: Amparat C.  A56-0063:Transfer Receipt จากสาขาเข้าสนญ  */
/************************************************************************/
DEF SHARED VAR n_User       AS CHAR.

DEFINE INPUT PARAMETER nv_branch AS CHAR.
DEFINE INPUT PARAMETER nv_trndatfr AS DATE.
DEFINE INPUT PARAMETER nv_trndatto AS DATE.
DEFINE INPUT PARAMETER nv_rectyp   AS CHAR.
DEFINE INPUT-OUTPUT PARAMETER nv_Status   AS CHAR.


DEF VAR nv_cnt          AS INT.  
DEF VAR nv_equal        AS INT. 
DEF VAR nv_notequal     AS INT.   
DEF VAR nv_rcnoBr       AS INT.
DEF VAR nv_rcnoHo       AS INT.
DEF VAR nv_diffCa       AS INT.
DEF VAR nv_diffRv       AS INT.
                        
DEF VAR nv_txtEqual     AS CHAR.
DEF VAR nv_txtCa        AS CHAR.
DEF VAR nv_txtRv        AS CHAR.
                        
DEF VAR nv_create       AS CHAR.
DEF VAR nv_startim      AS CHAR.
DEF VAR nv_filename     AS CHAR.
DEF VAR nv_user         AS CHAR.
DEF VAR nv_prjno        AS CHAR.
DEF VAR nv_prjno2        AS CHAR.
DEF VAR nv_cntTran      AS INT. 
DEF VAR nv_cntUpdate    AS INT.


nv_startim      = STRING(TIME,"HH:MM:SS").
nv_user = n_User.

IF LENGTH(TRIM(nv_branch)) = 3 THEN nv_branch = SUBSTRING(nv_branch,1,2).
ELSE nv_branch = SUBSTRING(nv_branch,1,1).

nv_filename =   "C:\GWTRANF\" +  
                STRING(MONTH(TODAY),"99")    + 
                STRING(DAY(TODAY),"99")      + 
                SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + 
                "_" + nv_branch + ".DIF".


OUTPUT TO VALUE (nv_filename)  NO-ECHO.
    EXPORT DELIMITER ";" "".
    EXPORT DELIMITER ";" 
        "wtmar100 - Transfer Confirm Receipt System : Report Name ' " + "Check data Difference" + " '" 
        + " Report Date :" + STRING(TODAY,"99/99/9999")
        + " " + STRING(TIME,"HH:MM:SS").

    EXPORT DELIMITER ";"
        "USR ID : " + nv_User
        "   ข้อมูลตั้งแต่วันที่ : " + STRING(nv_trndatfr,"99/99/9999") + "  -  " + STRING(nv_trndatto,"99/99/9999").

    EXPORT DELIMITER ";"
        "No."
        "Equal/Not Equal"
        "Transaction Date"
        "RC in BR"
        "RC in Ho"
        "Diff CA"
        "Diff RV"
        .
OUTPUT CLOSE.


ASSIGN
    nv_cntTran   = 0 
    nv_cntUpdate = 0 
    nv_cnt       = 0 
    nv_equal     = 0 
    nv_notequal  = 0   
    nv_rcnoBr    = 0   
    nv_rcnoHo    = 0 
    nv_diffCa    = 0 
    nv_diffRv    = 0     
    nv_txtEqual  = ""
    nv_txtCa     = ""
    nv_txtRv     = "".

/*--- หากไม่พบเลย  ไม่ต้องค้นหา ---*/
FIND FIRST brstat.arm100    USE-INDEX arm10011
     WHERE brstat.arm100.branch    = nv_branch  AND
          (brstat.arm100.trndat   >= nv_trndatfr AND
           brstat.arm100.trndat   <= nv_trndatto)
NO-ERROR NO-WAIT.
IF NOT AVAIL brstat.arm100 THEN DO:
    nv_Status =  "ไม่พบข้อมูลในช่วงที่ต้องการ" .
    RETURN NO-APPLY.
END.

/*--- พบข้อมูลที่ต้องการ ---*/
FOR EACH brstat.arm100    USE-INDEX arm10011
    WHERE brstat.arm100.branch    = nv_branch  AND
        ( brstat.arm100.trndat   >= nv_trndatfr AND
          brstat.arm100.trndat   <= nv_trndatto)   NO-LOCK:
    ASSIGN
        nv_txtEqual = ""
        nv_txtCa = ""
        nv_txtRv = "".

    FIND FIRST sicfn.arm100 USE-INDEX arm10001   /* USE-INDEX arm10011  A50-0192 */
         WHERE sicfn.arm100.rectyp =  nv_rectyp   AND
               sicfn.arm100.prjno  = brstat.arm100.prjno
    NO-ERROR NO-WAIT.
    IF NOT AVAILABLE sicfn.arm100 THEN DO:   /* ยังไม่เคยมี data  Diff ทั้ง record */
        ASSIGN
            nv_cnt = nv_cnt + 1
            nv_rcnoBr = nv_rcnoBr + 1
            nv_txtEqual = "NOT".

        nv_prjno = IF LENGTH(TRIM(brstat.arm100.prjno)) = 10 THEN STRING(brstat.arm100.prjno ,"X-XXXX/XXXXX")               
        ELSE STRING(brstat.arm100.prjno,"XX-XXXX/XXXXX").


        OUTPUT TO VALUE (nv_filename) APPEND  NO-ECHO.
            EXPORT DELIMITER ";"
                nv_cnt
                nv_txtEqual
                brstat.arm100.trndat
                STRING(nv_prjno).
        OUTPUT CLOSE.

    END.            /* if not avail sicfn.arm100 */
    ELSE DO:    /*------------- ถ้าเจอ ให้check prjsta (IF,CA) เท่ากันหรือไม่ , field rvno มีค่าหรือไม่ -----------*/
        /* check CA */
        IF brstat.arm100.prjsta <> sicfn.arm100.prjsta THEN DO:
            ASSIGN
                nv_txtEqual = "NOT"
                nv_txtCa = "CA"
                nv_diffCa = nv_diffCa + 1.
        END.

        /* check RV */
        IF brstat.arm100.rvno <> sicfn.arm100.rvno THEN DO:
           ASSIGN
             nv_txtEqual = "NOT"
             nv_txtRv = brstat.arm100.rvno
             nv_diffRv = nv_diffRv + 1.
        END.

        /* export เฉพาะ ข้อมูลที่ต่างเท่านั้น */
        IF nv_txtEqual = "NOT" THEN DO:
            ASSIGN
                nv_cnt = nv_cnt + 1
                nv_rcnoBr = nv_rcnoBr + 1
                nv_rcnoHo = nv_rcnoHo + 1.
            
            nv_prjno = IF LENGTH(TRIM(brstat.arm100.prjno)) = 10 THEN STRING(brstat.arm100.prjno,"X-XXXX/XXXXX")               
            ELSE STRING(brstat.arm100.prjno,"XX-XXXX/XXXXX").
            
            nv_prjno2 = IF LENGTH(TRIM(sicfn.arm100.prjno)) = 10 THEN STRING(sicfn.arm100.prjno,"X-XXXX/XXXXX")               
            ELSE STRING(sicfn.arm100.prjno,"XX-XXXX/XXXXX").

            OUTPUT TO VALUE (nv_filename) APPEND  NO-ECHO.
                EXPORT DELIMITER ";"
                    nv_cnt
                    nv_txtEqual
                    brstat.arm100.trndat
                    STRING(nv_prjno)
                    STRING(nv_prjno2)
                    nv_txtCa
                    nv_txtRv.
            OUTPUT CLOSE.
        END.       
    END.     /* find data diff*/   
END.

/*---------- summary ---------*/
        OUTPUT TO VALUE (nv_filename) APPEND  NO-ECHO.
            EXPORT DELIMITER ";"
                ""
                ""
                "Total"
                nv_rcnoBr
                nv_rcnoHo
                nv_diffCa
                nv_diffRv.
        OUTPUT CLOSE.


