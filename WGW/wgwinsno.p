/* WGWINSNO.P : RUNNING INSUIRED CODE                      */
/* Copyright # Safety Insurance Public Company Limited     */
/*             บริษัท ประกันคุ้มภัย จำกัด (มหาชน)          */
/* Create By : Watsana K. [A56-0299] Date. 25/09/2013      */  
/* COPY FORM : GWINSNO.P                                   */  
/* CALL PROGRAM FORM wgwnamis.p                            */  
/* Connect DB : SICSYAC;SICUW; GW_SAFE -LD SIC_BRAN        */  

DEF INPUT         PARAMETER nv_branch  AS CHARACTER .
DEF INPUT         PARAMETER n_search   AS LOGICAL .
DEF INPUT         PARAMETER nv_typ     AS CHAR FORMAT "X(2)".
DEF INPUT-OUTPUT  PARAMETER n_check    AS CHARACTER .
DEF OUTPUT        PARAMETER n_acno     AS CHARACTER .

DEF VAR nv_lastno   AS INT. 
DEF VAR nv_seqno    AS INT.

/*nv_typ = "0s". /*0s= บุคคลธรรมดา Cs = นิติบุคคล*/*/

FIND LAST sicsyac.xzm056 USE-INDEX xzm05601 WHERE 
          sicsyac.xzm056.seqtyp  =  nv_typ      AND
          sicsyac.xzm056.branch  =  nv_branch NO-LOCK NO-ERROR .
IF NOT AVAIL xzm056 THEN DO :
  IF n_search = YES THEN DO:
      CREATE xzm056.
      ASSIGN
           sicsyac.xzm056.seqtyp   =  nv_typ
           sicsyac.xzm056.branch   =  nv_branch
           sicsyac.xzm056.des      =  "Personal/Start"
           sicsyac.xzm056.lastno   =  1.                   
  END.
  ELSE DO:
      ASSIGN
          n_acno     =    nv_branch   + String(1,"999999").
          nv_lastno  =    1.
      RETURN.
  END.
END. /*not avail xzm056*/       

/*---- Begin 21/11/2006 Chutikarn ----*/
ASSIGN
   nv_lastno = sicsyac.xzm056.lastno
   nv_seqno  = sicsyac.xzm056.seqno. 

IF n_check = "YES" THEN DO:       
    IF nv_typ = "0s" THEN DO: 
       
       IF LENGTH(nv_branch) = 2 THEN
              n_acno = nv_branch + STRING(sicsyac.xzm056.lastno + 1 ,"99999999").
       ELSE DO:  
            IF xzm056.lastno > 99999 THEN DO:
                IF nv_branch = "A" OR nv_branch = "B" THEN DO:
                    n_acno = "7" + nv_branch + STRING(sicsyac.xzm056.lastno,"99999999").
                END.
                ELSE n_acno = "0" + nv_branch + STRING(sicsyac.xzm056.lastno,"99999999").
            END.
            ELSE DO: 
                IF nv_branch = "A" OR nv_branch = "B" THEN DO:
                    n_acno = "7" + nv_branch + STRING(sicsyac.xzm056.lastno,"99999999").
                END.
                ELSE n_acno =       nv_branch + STRING(sicsyac.xzm056.lastno,"999999").
            END.
       END.
      
       CREATE sicsyac.xzm056.
       ASSIGN
          sicsyac.xzm056.seqtyp    =  nv_typ
          sicsyac.xzm056.branch    =  nv_branch
          sicsyac.xzm056.des       =  "Personal/Start"
          sicsyac.xzm056.lastno    =  nv_lastno + 1
          sicsyac.xzm056.seqno     =  nv_seqno.   
    END.
    ELSE IF nv_typ = "Cs" THEN DO:
       
       IF LENGTH(nv_branch) = 2 THEN
             n_acno = nv_branch + "C" + String(sicsyac.xzm056.lastno + 1 ,"9999999").
       ELSE DO:  
           IF xzm056.lastno > 99999 THEN DO:
               IF nv_branch = "A" OR nv_branch = "B" THEN DO:
                   n_acno = "7" + nv_branch + "C" + STRING(sicsyac.xzm056.lastno,"9999999").
               END.
               ELSE n_acno = "0" + nv_branch + "C" + STRING(sicsyac.xzm056.lastno,"9999999").
           END.
           ELSE DO:
               IF nv_branch = "A" OR nv_branch = "B" THEN DO:
                   n_acno = "7" + nv_branch + "C" + STRING(sicsyac.xzm056.lastno,"9999999").
               END.
               ELSE n_acno =      nv_branch + "C" + STRING(sicsyac.xzm056.lastno,"99999").
           END.
           
       END.
      
       CREATE sicsyac.xzm056.
       ASSIGN
          sicsyac.xzm056.seqtyp    =  nv_typ
          sicsyac.xzm056.branch    =  nv_branch
          sicsyac.xzm056.des       =  "Company/Start"
          sicsyac.xzm056.lastno    =  nv_lastno + 1
          sicsyac.xzm056.seqno     =  nv_seqno. 
    END.
    n_check = "".
END.
ELSE DO:
    
    IF nv_typ = "0s" THEN DO:
        IF LENGTH(nv_branch) = 2 THEN
             n_acno = nv_branch + STRING(sicsyac.xzm056.lastno,"99999999").
        ELSE DO:
             IF xzm056.lastno > 99999 THEN DO:
                 IF nv_branch = "A" OR nv_branch = "B" THEN DO:
                     n_acno = "7" + nv_branch + STRING(sicsyac.xzm056.lastno,"99999999").
                 END.
                 ELSE n_acno = "0" + nv_branch + STRING(sicsyac.xzm056.lastno,"99999999").
             END.
             ELSE DO: 
                 IF nv_branch = "A" OR nv_branch = "B" THEN DO:
                     n_acno = "7" + nv_branch + STRING(sicsyac.xzm056.lastno,"99999999").
                 END.
                 ELSE n_acno =       nv_branch + STRING(sicsyac.xzm056.lastno,"999999").
             END.
        END.

    END.
    ELSE DO:
        IF LENGTH(nv_branch) = 2 THEN
             n_acno = nv_branch + "C" + String(sicsyac.xzm056.lastno,"9999999").
        ELSE DO: 
             IF xzm056.lastno > 99999 THEN DO:
                 IF nv_branch = "A" OR nv_branch = "B" THEN DO:
                     n_acno = "7" + nv_branch + "C" + STRING(sicsyac.xzm056.lastno,"9999999").
                 END.
                 ELSE n_acno = "0" + nv_branch + "C" + STRING(sicsyac.xzm056.lastno,"9999999").
             END.
             ELSE DO:
                 IF nv_branch = "A" OR nv_branch = "B" THEN DO:
                     n_acno = "7" + nv_branch + "C" + STRING(sicsyac.xzm056.lastno,"9999999").
                 END.
                 ELSE n_acno =      nv_branch + "C" + STRING(sicsyac.xzm056.lastno,"99999").
             END.
        END.
    END.  
   
END.

IF sicsyac.xzm056.lastno >  sicsyac.xzm056.seqno Then Do :
  MESSAGE  "Running Code = Last No. / Please, Update Insured Running Code." SKIP
           "รหัสลูกค้า ถึงหมายเลขสุดท้ายแล้ว / ยกเลิกการทำงานชั่วคราว"      SKIP
           "แล้วติดต่อผู้ตั้ง Code"  VIEW-AS ALERT-BOX. 
  n_check = "ERROR".
  RETURN.                
END. /*lastno > seqno*/                       
ELSE DO :   /*lastno <= seqno */
   IF nv_typ = "0s" THEN DO:
       
       IF n_search = YES THEN DO:
           CREATE sicsyac.xzm056.
           ASSIGN
                 sicsyac.xzm056.seqtyp    =  nv_typ
                 sicsyac.xzm056.branch    =  nv_branch
                 sicsyac.xzm056.des       =  "Personal/Start"
                 sicsyac.xzm056.lastno    =  nv_lastno + 1
                 sicsyac.xzm056.seqno     =  nv_seqno.   
       END.
   END.
   ELSE IF nv_typ = "Cs" THEN DO:
      
       IF n_search = YES THEN DO:
           CREATE sicsyac.xzm056.
           ASSIGN
                 sicsyac.xzm056.seqtyp    =  nv_typ
                 sicsyac.xzm056.branch    =  nv_branch
                 sicsyac.xzm056.des       =  "Company/Start"
                 sicsyac.xzm056.lastno    =  nv_lastno + 1
                 sicsyac.xzm056.seqno     =  nv_seqno. 
       END.
   END.  

END.   /*lastno <= seqno */                                  


