/************************************************************************/
/* WacTRec1.p    : Program Tranfer Receipt Bill(RC) Br.To HO (CA)       */
/* Copyright	: Safety Insurance Public Company Limited 				*/
/*			      บริษัท ประกันคุ้มภัย จำกัด (มหาชน)					*/
/* CREATE BY	: Amparat C.  A56-0063:Transfer Receipt จากสาขาเข้าสนญ  */
/************************************************************************/
DEF SHARED VAR n_User       AS CHAR.

DEFINE INPUT PARAMETER nv_branch   AS CHAR.
DEFINE INPUT PARAMETER nv_trndatfr AS DATE.
DEFINE INPUT PARAMETER nv_trndatto AS DATE.
DEFINE INPUT PARAMETER nv_rectyp   AS CHAR.
DEFINE INPUT-OUTPUT PARAMETER nv_Status   AS CHAR.


DEF VAR nv_create       AS CHAR.
DEF VAR nv_startim      AS CHAR.
DEF VAR nv_filename     AS CHAR.
DEF VAR nv_user         AS CHAR.
DEF VAR nv_prjno        AS CHAR.
DEF VAR nv_cntTran      AS INT. 
DEF VAR nv_cntUpdate    AS INT.


nv_startim = STRING(TIME,"HH:MM:SS").
nv_user    = n_User.

IF LENGTH(TRIM(nv_branch)) = 3 THEN nv_branch = SUBSTRING(nv_branch,1,2).
ELSE nv_branch = SUBSTRING(nv_branch,1,1).

nv_filename =   "C:\GWTRANF\" +  
                STRING(MONTH(TODAY),"99")    + 
                STRING(DAY(TODAY),"99")      + 
                SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + 
                "_" + nv_branch + ".TAR".

OUTPUT TO VALUE (nv_filename) APPEND  NO-ECHO.
    EXPORT DELIMITER ";" "".
    
    EXPORT DELIMITER ";" 
        "wtmar100 - Transfer Confirm Receipt System : Reports Name ' " + "Receipt Bill(RC) Br.To HO (CA)" + " '"
        + " Report Date :" + STRING(TODAY,"99/99/9999")
        + " " + STRING(TIME,"HH:MM:SS").

    EXPORT DELIMITER ";"
        "USR ID : " + nv_User  
        "   ข้อมูลตั้งแต่วันที่ : " + STRING(nv_trndatfr,"99/99/9999") + "  -  " + STRING(nv_trndatto,"99/99/9999").
        
    EXPORT DELIMITER ";"
        "Rec. Status"
        "Transfer Date"
        "Record Type"
        "RC No"
        "Branch"
        "Transaction Date"
        "RC Status"
        "Transfer Flg"
        "Start Time"
        "End Time".
OUTPUT CLOSE.


ASSIGN
    nv_cntTran   = 0
    nv_cntUpdate = 0.

/*--- หากไม่พบเลย  ไม่ต้องค้นหา ---*/
FIND FIRST brstat.arm100    USE-INDEX arm10011
     WHERE brstat.arm100.branch   = nv_branch   AND
         ( brstat.arm100.trndat  >= nv_trndatfr AND
           brstat.arm100.trndat  <= nv_trndatto)AND
           brstat.arm100.rectyp   = nv_rectyp   AND
           brstat.arm100.prjno   <> ""          AND
           brstat.arm100.prjsta   = "CA"                        /* เฉพาะรายการที่ cancel ซึ่งต้องเรียกในช่วงที่กว้าง */
NO-ERROR NO-WAIT.
IF NOT AVAIL brstat.arm100 THEN DO:
    nv_Status =  "ไม่พบข้อมูลในช่วงที่ต้องการ" .
    RETURN NO-APPLY.
END.

/*--- พบข้อมูลที่ต้องการ ---*/
FOR EACH brstat.arm100    USE-INDEX arm10011
    WHERE brstat.arm100.branch  = nv_branch     AND
        ( brstat.arm100.trndat  >= nv_trndatfr  AND
          brstat.arm100.trndat  <= nv_trndatto) AND
          brstat.arm100.rectyp  = nv_rectyp     AND
          brstat.arm100.prjno   <> ""           AND
          brstat.arm100.prjsta  = "CA"          NO-LOCK:
    nv_create = "".

    FIND FIRST sicfn.arm100 USE-INDEX arm10001 
         WHERE sicfn.arm100.rectyp = nv_rectyp
           AND sicfn.arm100.prjno  = brstat.arm100.prjno NO-ERROR NO-WAIT.
    
    /*------------- NOT AVALIBLE ON SICFN THEN CREATE -----------*/
    IF NOT AVAILABLE sicfn.arm100 THEN DO:  
       DO TRANSACTION:
        
          CREATE sicfn.arm100.
            
          {wtm\wtmar100.i   sicfn   brstat }
          
              /*--------------------------------------------------create arm130 -  detail รายการ เกี่ยวกับรับเงิน   เป็น cash  cheque credit card  ---*/
            FOR EACH brstat.arm130 USE-INDEX  arm13001
                WHERE brstat.arm130.rectyp = sicfn.arm100.rectyp AND
                      brstat.arm130.prjno  = sicfn.arm100.prjno
                   BY brstat.arm130.itemno :

                CREATE sicfn.arm130.

                {wtm\wtmar130.i   sicfn   brstat }
            END. /* for each arm130 */

            /*--------------------------------------------------create arm120 -  detail policy ที่จะทำการ match เบี้ย  ---*/
            FOR EACH brstat.arm120 USE-INDEX  arm12001
                WHERE brstat.arm120.rectyp = sicfn.arm100.rectyp AND
                      brstat.arm120.prjno  = sicfn.arm100.prjno
                   BY brstat.arm120.prjcnt :

                CREATE sicfn.arm120.

                {wtm\wtmar120.i   sicfn   brstat }
            END.
            
            /*--------------------------------------------------create transaction Gen. Data To HO*/ 
            nv_create = "create".                      
            FIND FIRST trnarm USE-INDEX trnarm01 WHERE
                       trnarm.transfdat = TODAY               AND 
                       trnarm.rectyp    = sicfn.arm100.rectyp AND
                       trnarm.prjno     = sicfn.arm100.prjno  NO-ERROR.
            IF NOT AVAIL trnarm  THEN DO:
                CREATE trnarm.
            END.
                ASSIGN
                    trnarm.transfdat = TODAY
                    trnarm.rectyp    = sicfn.arm100.rectyp
                    trnarm.prjno     = sicfn.arm100.prjno
                    trnarm.branch    = sicfn.arm100.branch
                    trnarm.trndat    = sicfn.arm100.trndat
                    trnarm.prjsta    = sicfn.arm100.prjsta
                    trnarm.tranflg   = YES
                    trnarm.startim   = nv_startim
                    trnarm.endtim    = STRING(TIME,"HH:MM:SS")
                    trnarm.recsta    = IF nv_create = "create" THEN "C" ELSE "U" .
                                    
                nv_prjno = IF LENGTH(TRIM(trnarm.prjno)) = 10 THEN STRING(trnarm.prjno,"X-XXXX/XXXXX")               
                ELSE STRING(trnarm.prjno,"XX-XXXX/XXXXX").
              
                /*--------------------------------------------- output to text file */
                OUTPUT TO VALUE (nv_filename) APPEND NO-ECHO.
                    EXPORT DELIMITER ";"
                        IF trnarm.recsta = "C" THEN "Create" ELSE "Update"
                        trnarm.transfdat
                        trnarm.rectyp
                        STRING(nv_prjno)
                        trnarm.branch
                        trnarm.trndat
                        trnarm.prjsta
                        trnarm.tranflg
                        trnarm.startim
                        trnarm.endtim.                   
                OUTPUT CLOSE.
                /*--------------------------------------------------create transaction Gen. Data To HO*/           
                
        END. /* do transaction*/       
    END.          
    ELSE DO: /*------------- AVALIBLE ON SICFN THEN UPDATE -----------*/

        DO TRANSACTION:
           IF (brstat.arm100.prjsta = "CA")  OR  (brstat.arm100.rvno <> "" ) THEN DO:

                ASSIGN
                    sicfn.arm100.prjsta    = brstat.arm100.prjsta     /*------UPDATE PRJ status     */
                    sicfn.arm100.prjstadet = brstat.arm100.prjstadet  /*------PRJ status detail     */
          
                nv_create = "update".
                FIND FIRST trnarm USE-INDEX trnarm01 WHERE
                           trnarm.transfdat = TODAY               AND 
                           trnarm.rectyp    = sicfn.arm100.rectyp AND
                           trnarm.prjno     = sicfn.arm100.prjno  NO-ERROR.
                IF NOT AVAIL trnarm  THEN DO:
                    CREATE trnarm.
                END.
                    ASSIGN
                        trnarm.transfdat = TODAY
                        trnarm.rectyp    = sicfn.arm100.rectyp
                        trnarm.prjno     = sicfn.arm100.prjno
                        trnarm.branch    = sicfn.arm100.branch
                        trnarm.trndat    = sicfn.arm100.trndat
                        trnarm.prjsta    = sicfn.arm100.prjsta
                        trnarm.tranflg   = YES
                        trnarm.startim   = nv_startim
                        trnarm.endtim    = STRING(TIME,"HH:MM:SS")
                        trnarm.recsta    = IF nv_create = "create" THEN "C" ELSE "U" .
                                        
                    nv_prjno = IF LENGTH(TRIM(trnarm.prjno)) = 10 THEN STRING(trnarm.prjno,"X-XXXX/XXXXX")               
                    ELSE STRING(trnarm.prjno,"XX-XXXX/XXXXX").
                  
                    /*--------------------------------------------- output to text file */
                    OUTPUT TO VALUE (nv_filename) APPEND NO-ECHO.
                        EXPORT DELIMITER ";"
                            IF trnarm.recsta = "C" THEN "Create" ELSE "Update"
                            trnarm.transfdat
                            trnarm.rectyp
                            STRING(nv_prjno)
                            trnarm.branch
                            trnarm.trndat
                            trnarm.prjsta
                            trnarm.tranflg
                            trnarm.startim
                            trnarm.endtim.     
                    OUTPUT CLOSE.
                   /*--------------------------------------------------Update transaction Gen. Data To HO*/  
           END.
        END.  /* do transaction*/        
    END.   
END.     /*---For each brStat--*/



