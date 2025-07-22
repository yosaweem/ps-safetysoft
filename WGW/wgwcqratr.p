/****************************************************************************************** 
Modify By : Songkran P. A65-0141   12/09/2022      
          : Check Job Q,R Auto Create Inspection and Transfer to Premium   
  HO: sicuw,siccl,stat
  DATABASE MOTOR ON WEB: STAT -LD CTXSTAT   
*****************************************************************************************
Modify By : Tontawan S. A65-0141 31/07/2023 
          : Add Loop Check Webservice RUN wgw\wgwctrngw only  
*****************************************************************************************/ 
DEFINE TEMP-TABLE tautogw
    FIELD recpol AS RECID
    FIELD company AS CHAR   
    FIELD acno   AS CHAR   
    FIELD poljob AS CHAR
    FIELD email  AS CHAR
    FIELD ispbox AS CHAR
    FIELD condi  AS CHAR.

DEFINE INPUT-OUTPUT PARAMETER TABLE FOR tautogw.

DEF VAR  n_camcod   AS CHAR INIT "".
DEF VAR  condition  AS CHAR INIT "".
DEF VAR  n_typgrp   AS CHAR INIT "autotransfergw".
DEF VAR  ispbox     AS CHAR INIT "".
DEFINE VARIABLE Email     AS CHARACTER INIT ""  NO-UNDO.
DEFINE VARIABLE Internet   AS CHARACTER INIT ""  NO-UNDO.
DEF VAR nv_ltxt  AS CHAR INIT "".
DEF VAR nv_check  AS CHAR INIT "".

FUNCTION extractDigits RETURNS CHARACTER(INPUT pcString AS CHARACTER) FORWARD.

FIND FIRST tautogw NO-ERROR.
IF AVAILA tautogw THEN DO:
    FIND FIRST stat.uzpbrn USE-INDEX uzpbrn02 WHERE 
           stat.uzpbrn.typeg   = n_typgrp     AND 
           stat.uzpbrn.typcode = tautogw.acno AND 
           stat.uzpbrn.expdat  >= TODAY       AND
           stat.uzpbrn.effdat  <= TODAY       NO-LOCK NO-ERROR.
    IF AVAILA stat.uzpbrn THEN DO:            
        IF stat.uzpbrn.note1 = "A" AND stat.uzpbrn.note3 <> "4" THEN DO:

            IF tautogw.poljob = stat.uzpbrn.TYPE OR 
               stat.uzpbrn.TYPE = "ALL" THEN DO:
    
                RUN VALUE(stat.uzpbrn.typpara)(INPUT tautogw.recpol,OUTPUT n_camcod, OUTPUT tautogw.condi).
                IF tautogw.condi = "Transfer to Premium with Create Inspection" THEN DO:
                    ASSIGN
                        tautogw.ispbox = STRING(stat.uzpbrn.note3)            // Inspection box 1 or 2
                        tautogw.email = uzpbrn.notee[3] + "," + uzpbrn.note2. // userid create isp box and email
                END.
            END.
            ELSE tautogw.condi = stat.uzpbrn.TYPE + " Can't auto transfer" .
        END.
        ELSE tautogw.condi = "Status not active Or Parameter not Create ISP.BOX".
    END.
    ELSE DO:
        IF SEARCH("D:\Temp\Autopilot_pro.csv") <> ? THEN DO:
            INPUT FROM "D:\Temp\Autopilot_pro.csv".
            loop_1:
            REPEAT: 
                nv_ltxt = "".
                IMPORT UNFORMATTED nv_ltxt.
            
                IF tautogw.company = TRIM(nv_ltxt) THEN DO:
                     nv_check = "have".
                     LEAVE loop_1.
                END.
            END.
        END.

        IF nv_check = "" THEN DO:
            FIND FIRST ctxstat.Company USE-INDEX Company01 WHERE ctxstat.Company.Compno = tautogw.company NO-LOCK NO-ERROR.
            IF AVAIL ctxstat.Company THEN DO:
                IF Company.Acno1 = tautogw.acno THEN DO:
                    IF Company.Acno1 = "B300308"  THEN tautogw.ispbox = "1".
                    ELSE tautogw.ispbox = "2".
            
                    /*RUN wgw\wgwctrngw(INPUT tautogw.recpol,OUTPUT n_camcod, OUTPUT tautogw.condi).-- Comment By Tontawan S. A65-0141 31/07/2023 --*/
                    /*-- Add By Tontawan S. A65-0141 31/07/2023 --*/
                    IF company.text3 = "WebService" THEN RUN wgw\wgwctrngw(INPUT tautogw.recpol,OUTPUT n_camcod, OUTPUT tautogw.condi).
                    ELSE tautogw.condi = "Transfer to Premium with Create Inspection".
                    /*-- End By Tontawan S. A65-0141 31/07/2023 --*/
                    IF tautogw.condi = "Transfer to Premium with Create Inspection" THEN DO:
                        IF Company.flagname = "" THEN tautogw.condi = "There is no user id to create ISP No.".
                        ELSE DO:
                            Email    = IF TRIM(ctxstat.Company.Email) <> "" THEN extractDigits(ctxstat.Company.Email) ELSE "".  /*Sent Mail To*/
                            Internet = IF TRIM(ctxstat.Company.Internet) <> "" THEN extractDigits(ctxstat.Company.Internet) ELSE "". /*Sent Mail cc.*/
                            tautogw.email = Company.flagname + TRIM(IF Email <> "" THEN "," + Email + IF Internet <> "" THEN "," + Internet ELSE "" ELSE "" + IF Internet <> "" THEN "," + Internet ELSE "" ). /* user id , email@tokiomarinesafety.co.th*/
            
                        END.
                    END.
                END.
                ELSE tautogw.condi = "Not found producer code auto tranfers 'WctxPr75'".
            END.
            ELSE tautogw.condi = "Not found producer code on program setype company name".
        END.
        ELSE tautogw.condi = "Company code " + tautogw.company + " not auto".
    END.
END.

/*--- Parse first last name  --*/
FUNCTION extractDigits RETURNS CHARACTER ( INPUT pcString AS CHARACTER ): 
    DEFINE VARIABLE nv_ufname AS CHAR INIT "".
    DEFINE VARIABLE nv_ulname AS CHAR INIT "".
    DEFINE VARIABLE iChar AS INTEGER NO-UNDO.
    DEFINE VARIABLE iAsc AS INTEGER NO-UNDO.
    DEFINE VARIABLE tName AS CHARACTER NO-UNDO.
    DEFINE VARIABLE cChar AS CHARACTER NO-UNDO.
    DEFINE VARIABLE n_email AS CHARACTER NO-UNDO.
    DEFINE VARIABLE n_err   AS CHARACTER NO-UNDO.

    IF INDEX(pcString,"@tokiomarinesafety") <> 0 THEN RETURN pcString.
    nv_ufname = TRIM(SUBSTRING(pcString,1,INDEX(pcString," "))) NO-ERROR.

    DO iChar = 1 TO LENGTH(nv_ufname):
        ASSIGN 
            cChar = SUBSTRING(nv_ufname,iChar,1)
            iAsc = ASC(cChar).
    
        IF (iAsc >= 65 AND iAsc <= 90) OR (iAsc >= 97 AND iAsc <= 122) THEN DO:
            
            tName = tName + cChar.
        END.
        ELSE LEAVE.
    END.
    nv_ufname = tName.
    nv_ulname = TRIM(SUBSTRING(pcString,INDEX(pcString," "),LENGTH(pcString))) NO-ERROR.
    tName = "".
    DO iChar = 1 TO LENGTH(nv_ulname):
        ASSIGN 
            cChar = SUBSTRING(nv_ulname,iChar,1)
            iAsc = ASC(cChar).
    
        IF (iAsc >= 65 AND iAsc <= 90) OR (iAsc >= 97 AND iAsc <= 122) THEN DO:
            
            tName = tName + cChar.
        END.
        ELSE LEAVE.
    END.
    nv_ulname = tName.
    IF nv_ufname <> "" AND nv_ulname <> "" THEN DO: 
        RUN wuw\wuwqmalws(INPUT nv_ufname,INPUT nv_ulname,OUTPUT n_email ,OUTPUT n_err). //ws find email address 
    END.
    IF n_email = "" THEN DO: 
          RUN wuw\wuwqgmlws(INPUT pcString,OUTPUT n_email ,OUTPUT n_err). //ws find group-email address 
    END.
    IF n_email <> "" THEN RETURN n_email.
    ELSE RETURN "". /* If no integers in the string return the unknown value. */
END FUNCTION.

