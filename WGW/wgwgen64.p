/*Create By Chaiyong W. A58-0123 28/04/2015                            */
/*Modify By Chaiyong W. A58-0289 13/08/2015                            */
/*Modify By Chaiyong W. A58-0380 08/10/2015                            */
/*----------------------------------------------------------------------
Modify By : TANTAWAN CH.  ASSIGN: A63-0463  DATE: 17/11/2020
            - เก็บข้อมูล Occupation , Policy Number (Certificate) ใน Risk Text เพิ่ม
------------------------------------------------------------------------*/

DEF INPUT        PARAMETER nv_recid AS RECID.
DEF INPUT-OUTPUT PARAMETER nv_err   AS  CHAR INIT "".

DEF SHARED TEMP-TABLE t_policy
    FIELD opnpol AS CHAR INIT ""
    FIELD policy AS CHAR INIT ""
    FIELD nrecid AS RECID
    FIELD rencnt AS INT 
    FIELD endcnt AS INT
    FIELD trndat AS DATE
    FIELD entdat AS DATE
    FIELD usrid  AS CHAR  
    FIELD ntitle AS CHAR 
    FIELD name1  AS CHAR .

/*------Paramter-----*/
DEF VAR nv_name  AS CHAR INIT "".
DEF VAR nv_age   AS INT  INIT 0.
DEF VAR nv_icno  AS CHAR INIT "".
DEF VAR nv_memb  AS CHAR INIT "".
DEF VAR nv_prov  AS CHAR INIT "".
DEF VAR nv_cove  AS CHAR INIT "".
DEF VAR nv_bene  AS CHAR INIT "".
DEF VAR nv_rela  AS CHAR INIT "".
DEF VAR nv_grou  AS CHAR INIT "".
DEF VAR nv_grou2 AS CHAR INIT "".

DEF VAR nv_fptr  AS recid INIT 0.
DEF VAR nv_bptr  AS recid INIT 0.
DEF VAR nv_nptr  AS recid INIT 0.
DEF VAR nv_line  AS INT   INIT 0.
DEF VAR nv_line1 AS INT   INIT 0.
DEF VAR nv_line2 AS INT   INIT 0.
DEF VAR nv_line3 AS INT   INIT 0.
DEF VAR nv_line4 AS INT   INIT 0.
DEF VAR nv_line5 AS INT   INIT 0.
DEF VAR nv_line6 AS INT   INIT 0.
DEF VAR nv_line7 AS INT   INIT 0.
DEF VAR nv_line8 AS INT   INIT 0.
DEF VAR nv_line9 AS INT   INIT 0.
DEF VAR nv_selec AS INT   INIT 0.
DEF VAR nv_status AS LOGICAL INIT NO.

DEF VAR nv_sort  AS INT  INIT 0.
DEF VAR nv_dsort AS CHAR INIT "".

DEF TEMP-TABLE ttext
    FIELD nline  AS INT   INIT 0
    FIELD ntext  AS CHAR  INIT ""
    FIELD nrecid AS RECID INIT ?.

DEF TEMP-TABLE ttexts
    FIELD ngroup AS INT   INIT 0   
    FIELD nline  AS INT   INIT 0
    FIELD ntext  AS CHAR  INIT ""
    INDEX ttexts1 ngroup nline ASC . /*--add by Chaiyong W. A58-0380 08/10/2015*/

DEF TEMP-TABLE tlist
    FIELD npolicy  AS CHAR  INIT ""
    FIELD nrecid   AS RECID INIT ""
    FIELD nname  AS CHAR  INIT ""
    FIELD nage   AS CHAR  INIT ""
    FIELD nicno  AS CHAR  INIT ""
    FIELD nmemb  AS CHAR  INIT ""
    FIELD nprov  AS CHAR  INIT ""
    FIELD ncove  AS CHAR  INIT ""
    FIELD nbene  AS CHAR  INIT ""
    FIELD nrela  AS CHAR  INIT ""
    FIELD list   AS CHAR  INIT ""
    FIELD ngrou  AS INT   INIT 0 
    FIELD niocc  AS CHAR  INIT ""  /* A63-0463 */
    FIELD cerno  AS CHAR  INIT "". /* A63-0463 */

DEF VAR nv_flin AS INT INIT 0.
DEF VAR nv_find AS INT INIT 0.
/*---Begin by Chaiyong W. A58-0380 08/10/2015*/
DEF SHARED TEMP-TABLE tgroup 
    FIELD gcode  AS CHAR INIT ""
    FIELD ggroup AS INT  INIT 0
    FIELD gthai  AS CHAR INIT ""
    INDEX tgroup01 ggroup ASCENDING
    INDEX tgroup02 gthai  ASCENDING.
DEF VAR nv_fgroup AS INT INIT 0.
/*End by Chaiyong W. A58-0380 08/10/2015-----*/

FOR EACH  ttext:
    DELETE  ttext.
END.
FOR EACH ttexts:
    DELETE ttexts.
END.
FOR EACH tlist:
    DELETE tlist.
END.

DEF BUFFER buwm100 FOR sic_bran.uwm100.

DEF VAR nv_out  AS CHAR INIT "C:\GWTRANF\".
DEF VAR nv_out2 AS CHAR INIT "".
ASSIGN
    nv_out  = nv_out + STRING(TODAY,"99-99-9999") + "_" + STRING(TIME) + "_"
    nv_out2 = nv_out + "a.txt"
    nv_out  = nv_out + "b.txt".

DEF STREAM ns9.
DEF STREAM ns10.

PROCEDURE pd_repeat:
    nv_selec = 0.
    loop_record:
    REPEAT:
        nv_selec = nv_selec + 1.
        nv_line = nv_line + 1.
        CREATE ttexts.
        ASSIGN
            ttexts.ngrou = nv_sort
            ttexts.nline = nv_line .
        IF nv_selec = 3 THEN LEAVE loop_record.
    END.
END.

DO TRANSACTION:
    OUTPUT STREAM ns9 TO VALUE(nv_out).
    OUTPUT STREAM ns10 TO VALUE(nv_out2).

    FIND FIRST sicuw.uwm100 WHERE  RECID(uwm100) = nv_recid NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uwm100 THEN DO:

        IF uwm100.releas THEN DO:
            nv_err = "Open Policy is Transfer to Account Please Check Again".
            NEXT.
        END.
        
        FIND FIRST sicuw.uwm120 USE-INDEX uwm12001 
            WHERE uwm120.policy = uwm100.policy AND
                  uwm120.rencnt = uwm100.rencnt AND
                  uwm120.endcnt = uwm100.endcnt NO-LOCK NO-ERROR.
        IF AVAIL uwm120 THEN DO:
            ASSIGN
                nv_fptr  = uwm120.fptr01
                nv_bptr  = uwm120.bptr01
                nv_line  = 0
                nv_line2 = 0.
            
            If  nv_fptr  <>  0  Or nv_fptr  <>  ? Then Do :                       
                 Do  While  nv_fptr  <>  0 :
                    nv_line = nv_line + 1.
                    Find First sicuw.uwd120  Where Recid(uwd120)   =   nv_fptr.     
                    FIND FIRST ttext  WHERE ttext.nline = nv_line NO-ERROR.
                    IF NOT AVAIL ttext THEN CREATE ttext.
                    ASSIGN
                    ttext.nline  = nv_line
                    ttext.ntext  = uwd120.ltext
                    ttext.nrecid = RECID(uwd120)
                    nv_fptr      =    uwd120.fptr.                                
                    
                    If nv_fptr  =    0    Then   Leave.
                End.
            END. 

            ASSIGN
                nv_line   = 0
                nv_line1  = 0
                nv_line2  = 0
                nv_line3  = 0
                nv_line4  = 0
                nv_line5  = 0
                nv_line6  = 0
                nv_line7  = 0
                nv_line8  = 0
                nv_line9  = 0
                nv_selec  = 0.
            
            FOR EACH ttext NO-LOCK BREAK BY ttext.nline:
            
                IF TRIM(ttext.ntex) = "" THEN NEXT.
                /*----Begin by Chaiyong W. A58-0380 08/10/2015*/
                IF INDEX(TRIM(ttext.ntext),". กลุ่มที่ ") <= 5 AND INDEX(TRIM(ttext.ntext),". กลุ่มที่ ") > 0 THEN DO:
                
                    nv_fgroup = INT(SUBSTR(ttext.ntext,1,INDEX(TRIM(ttext.ntext),". กลุ่มที่ ") - 1)) NO-ERROR.
                    
                    FIND FIRST tgroup USE-INDEX tgroup02 WHERE  tgroup.ggroup = nv_fgroup /*INDEX(trim(ttext.ntext),tgroup.gthai) <> 0*/  NO-LOCK NO-ERROR.
                    IF AVAIL tgroup THEN DO:
                        ASSIGN
                            nv_line  = 0
                            nv_selec = tgroup.ggroup. 
                    END.
                END.
                IF nv_selec <> 0 AND TRIM(ttext.ntext) <> "" THEN DO:
                    CREATE ttexts.
                    ASSIGN
                        ttexts.ngroup   = nv_selec
                        nv_line         = nv_line + 1
                        ttexts.nline    = nv_line
                        ttexts.ntext    = ttext.ntext.
                END.
                /*End by Chaiyong W. A58-0380 08/10/2015------*/
            END.  /*End for each*/
        END.  /*end uwm120*/
        
        /*----Begin by Chaiyong W. A58-0380 08/10/2015*/
        nv_err = "".
        FIND LAST ttexts NO-LOCK NO-ERROR.
        IF AVAIL ttexts THEN nv_selec =  ttexts.ngroup.
        
        loop_grp:
        REPEAT:
            FIND FIRST ttexts WHERE ttexts.ngroup = nv_selec NO-LOCK NO-ERROR.
            IF NOT AVAIL ttexts THEN DO:
                nv_err = "Group Open Policy Not found!!!".
                LEAVE loop_grp.
            END.
            nv_selec = nv_selec - 1.
            IF nv_selec = 0 THEN LEAVE loop_grp.
        END.
        
        IF nv_err = "" THEN DO:  /*chk*/
        /*End by Chaiyong W. A58-0380 08/10/2015------*/
            FOR EACH t_policy WHERE t_policy.opnpol = sicuw.uwm100.policy NO-LOCK:
                FIND FIRST buwm100 WHERE RECID(buwm100) = t_policy.nrecid NO-LOCK NO-ERROR.
                IF AVAIL buwm100 THEN DO:
                    IF buwm100.releas THEN NEXT.
                    FIND FIRST sic_bran.uwm307 USE-INDEX uwm30701 
                        WHERE uwm307.policy = buwm100.policy AND
                              uwm307.rencnt = buwm100.rencnt AND
                              uwm307.endcnt = buwm100.endcnt NO-LOCK NO-ERROR.
                    IF AVAIL uwm307 THEN DO:
                        FIND FIRST tlist WHERE  tlist.npolicy = buwm100.policy NO-ERROR.
                        IF NOT AVAIL tlist THEN CREATE tlist.
                        ASSIGN
                            tlist.npolicy = buwm100.policy
                            tlist.nrecid  = RECID(buwm100)
                            /*---
                            tlist.nname   = TRIM(uwm307.iname)
                            comment by Chaiyong W. A58-0289 14/08/2015*/
                            
                            tlist.nname   = TRIM(TRIM(uwm307.ifirst) + " " + TRIM(uwm307.iname))  /*---add by Chaiyong W. A58-0289 14/08/2015*/
                            nv_age        = 0                           
                            nv_age        = (YEAR(buwm100.trndat))  - YEAR(uwm307.idob)
                            
                            tlist.nicno   = TRIM(uwm307.icno)
                            tlist.nmemb   = TRIM(buwm100.name3)
                            tlist.nprov   = TRIM(buwm100.addr4)
                            tlist.ncove   = TRIM(STRING(buwm100.comdat,"99/99/9999") + " - " + STRING(buwm100.expdat,"99/99/9999"))
                            tlist.nbene   = TRIM(uwm307.bname1) 
                            tlist.nrela   = TRIM(uwm307.reship)
                            tlist.niocc   = TRIM(uwm307.iocc)    /* A63-0463 */
                            tlist.cerno   = IF SUBSTRING(TRIM(uwm307.policy),1,1) = "C" THEN TRIM(uwm307.policy) ELSE "" . /* A63-0463 */

                            IF nv_age < 100  THEN tlist.nage    = TRIM(STRING(nv_age,">9")) .    /*
                            IF nv_age < 1000 THEN tlist.nage    = TRIM(STRING(nv_age,">>9")) . */
                            
                            IF tlist.nage = ? THEN tlist.nage = " 0".
                            
                            /*----BEgin by Chaiyong W. A58-0380 08/10/2015*/
                            FIND FIRST tgroup WHERE tgroup.gcode = TRIM(buwm100.cr_1)  NO-LOCK NO-ERROR.
                            IF AVAIL tgroup THEN 
                                tlist.ngrou = tgroup.ggroup.
                            /*End by Chaiyong W. A58-0380 08/10/2015------*/

                            /*--
                            tlist.list = tlist.nname + FILL(" ",45 - LENGTH(tlist.nname)) + " " +    
                            comment by Chaiyong W. A58-0289 13/08/2015*/

                            tlist.list = tlist.nname + FILL(" ",80 - LENGTH(tlist.nname)) + " " +     /*---add by Chaiyong W. A58-0289 14/08/2015*/
                                         tlist.nage  + FILL(" ",4  - LENGTH(tlist.nage))  + " " +    
                                         tlist.nicno + FILL(" ",20 - LENGTH(tlist.nicno)) + " " +    
                                         tlist.nmemb + FILL(" ",10 - LENGTH(tlist.nmemb)) + " " +    
                                         tlist.nprov + FILL(" ",20 - LENGTH(tlist.nprov)) + " " +    
                                         tlist.ncove + FILL(" ",23 - LENGTH(tlist.ncove)) + " " + 
                                         tlist.nbene + FILL(" ",45 - LENGTH(tlist.nbene)) + " " +  
                                         tlist.nrela + FILL(" ",25 - LENGTH(tlist.nrela)) + " " + 
                                         tlist.niocc + FILL(" ",20 - LENGTH(tlist.niocc)) + " " +  /* A63-0463 */ 
                                         tlist.cerno + FILL(" ",16 - LENGTH(tlist.cerno)) .        /* A63-0463 */ 
                    END.  /*end avail 307*/
                END.    /*end avail buwm100*/        
            END.  /*end t_policy*/
                    
            /*---Beigin by Chaiyong w. A58-0380 21/12/2015*/
            FOR EACH ttexts WHERE ttexts.ntext = "" :
                DELETE ttexts.
            END.
            FOR EACH tlist WHERE tlist.list = "":
                DELETE tlist.
            END.
            RELEASE ttexts.
            RELEASE tlist.
            /*End by Chaiyong W. A58-0380 21/12/2015-----*/
            
            FIND FIRST tlist NO-LOCK NO-ERROR.
            IF AVAIL tlist THEN DO:
                /*----Group Data----*/
                FOR EACH tlist BREAK BY tlist.npolicy : 
                    ASSIGN
                        nv_flin  = 0
                        nv_find  = 0
                        nv_sort  = 0
                        nv_dsort = "".
                    ASSIGN
                        nv_find = tlist.ngrou.
                    /*---
                    IF nv_find = 1  THEN nv_flin = nv_line1 .
                    IF nv_find = 2  THEN nv_flin = nv_line2 .
                    IF nv_find = 3  THEN nv_flin = nv_line3 .
                    IF nv_find = 4  THEN nv_flin = nv_line4 .
                    IF nv_find = 5  THEN nv_flin = nv_line5 .
                    IF nv_find = 6  THEN nv_flin = nv_line6 .
                    IF nv_find = 7  THEN nv_flin = nv_line7 .
                    IF nv_find = 8  THEN nv_flin = nv_line8 .
                    IF nv_find = 9  THEN nv_flin = nv_line9 .
                    comment by Chaiyong W. A58-0380 08/10/2015--*/
                    
                    /*----BEgin by Chaiyong W. A58-0380 08/10/2015*/
                    FIND LAST ttexts USE-INDEX ttexts1 WHERE ttexts.ngrou = nv_find NO-LOCK NO-ERROR.
                    IF AVAIL ttexts THEN DO:
                        nv_flin  = ttexts.nline.
                    /*End by Chaiyong W. A58-0380 08/10/2015------*/
                        /*---                
                        FIND LAST ttexts WHERE ttexts.ngrou = nv_find  AND 
                        ttexts.nline = nv_flin  NO-ERROR.
                        IF AVAIL ttexts THEN DO:
                        comment by Chaiyong W. A58-0380 21/12/2015*/


                        IF INDEX(TRIM(ttexts.ntext),"ลำดับที่") = 1 THEN DO:
                            ASSIGN
                                nv_sort = 1
                                nv_dsort = STRING(nv_sort,">>>,>>9") + ".".
                        END.
                        ELSE DO:       
                            IF INDEX(ttexts.ntext,".") <> 0 AND INDEX(ttexts.ntext,".") < 10 THEN
                                nv_dsort = SUBSTR(ttexts.ntext,1,INDEX(ttexts.ntext,".") - 1).
                            nv_sort  = INTEGER(nv_dsort) + 1 NO-ERROR.
                            IF nv_sort = 0 THEN nv_sort = nv_sort + 1.
                            nv_dsort = STRING(nv_sort,">>>,>>9") + ".".  
                        END.
                        
                        /*        MESSAGE ttexts.ntext SKIP "TEST" SKIP nv_dsort SKIP  VIEW-AS ALERT-BOX.*/
                
                        /*---
                        CREATE ttexts.
                        ASSIGN
                        nv_flin         = nv_flin  + 1
                        ttexts.ngroup   = nv_find
                        ttexts.nline    = nv_flin
                        ttexts.ntext    = nv_dsort + " " + tlist.list . 
                        IF nv_find = 1 THEN nv_line1 = nv_flin.
                        IF nv_find = 2 THEN nv_line2 = nv_flin.
                        IF nv_find = 3 THEN nv_line3 = nv_flin.
                        IF nv_find = 4 THEN nv_line4 = nv_flin.
                        IF nv_find = 5 THEN nv_line5 = nv_flin.
                        IF nv_find = 6 THEN nv_line6 = nv_flin.
                        IF nv_find = 7 THEN nv_line7 = nv_flin.
                        IF nv_find = 8 THEN nv_line8 = nv_flin.
                        IF nv_find = 9 THEN nv_line9 = nv_flin.
                        comment by Chaiyong W. A58-0380 08/10/2015--*/
                        
                        /*----BEgin by Chaiyong W. A58-0380 08/10/2015*/
                        CREATE ttexts.
                        ASSIGN
                            nv_flin         = nv_flin  + 1
                            ttexts.nline    = nv_flin
                            ttexts.ngroup   = tlist.ngrou
                            ttexts.ntext    = nv_dsort + " " + tlist.list .
                        /*End by Chaiyong W. A58-0380 08/10/2015------*/
                        RELEASE ttexts.     
                    END.    /*-----ttexts*/
                END.  /*--End for each -*/

                /*----Sort Data----*/
                
                /*--
                IF nv_err = "" THEN DO:
                comment by Chaiyong W. A58-0380 08/10/2015*/
                /*----Break Data----*/
                ASSIGN
                    nv_sort = 0
                    nv_line = 0.
                FOR EACH ttexts BREAK BY ttexts.ngroup 
                                      BY ttexts.nline:
                    IF LAST-OF(ttexts.ngroup) THEN DO:
                        ASSIGN
                            nv_sort  =  ttexts.ngroup
                            nv_line  =  ttexts.nline. 
                        RUN pd_repeat.
                    END.
                END. /*End tlist*/
                /*-----------------*/
    
                /*---delete data---*/
                FOR EACH ttext BREAK BY ttext.nline:
                    PUT STREAM ns9 ttext.ntext FORMAT "X(1000)" SKIP.
                    FIND uwd120 WHERE RECID(uwd120) = ttext.nrecid NO-ERROR.
                    IF AVAIL uwd120 THEN DELETE uwd120.
                    DELETE ttext.
                END.
                    
                /*---add data-----*/
                nv_status = NO.
                FIND FIRST uwm120 USE-INDEX uwm12001 WHERE uwm120.policy = uwm100.policy AND
                    uwm120.rencnt = uwm100.rencnt AND
                    uwm120.endcnt = uwm100.endcnt NO-ERROR.
                IF AVAIL uwm120 THEN DO:
                    ASSIGN
                        nv_fptr  = 0 
                        nv_bptr  = 0
                        nv_nptr  = 0.
                    FOR EACH ttexts BREAK BY ttexts.ngroup 
                        BY ttexts.nline:
                        CREATE uwd120.
                        ASSIGN
                            nv_status     = YES
                            uwd120.policy = uwm120.policy
                            uwd120.rencnt = uwm120.rencnt
                            uwd120.endcnt = uwm120.endcnt
                            uwd120.ltext  = ttexts.ntext
                            nv_nptr       = RECID(uwd120).

                        If  nv_fptr  = 0  And  nv_bptr = 0 Then Do :        
                            Assign        
                                uwm120.fptr01   =   Recid(uwd120)                   
                                uwd120.fptr     =   0  
                                uwd120.bptr     =   0                                  
                                nv_nptr         =   Recid(uwd120)
                                nv_bptr         =   Recid(uwd120).
                        END. 
                        ELSE DO :
                            FIND FIRST uwd120  Where  RECID(uwd120)  =  nv_bptr No-Error.
                            IF AVAIL  uwd120   THEN uwd120.fptr   =  nv_nptr.

                            FIND  First uwd120  Where  RECID(uwd120)  =  nv_nptr No-Error.
                            If Avail uwd120 Then Do :
                                uwd120.bptr =  nv_bptr.
                                nv_bptr     =  Recid(uwd120).             
                            End.           
                        END.
                    END.
                    
                    IF nv_Status  = Yes  Then Do :
                        uwm120.bptr01  =  Recid(uwd120).
                        uwd120.fptr    =  0.  
                    END.
                    Else uwm120.bptr01 =  0.    
                END.    /*end uwm120*/ 
                    
                    
            END.   /*end tlist*/   /*---add end by Chaiyong W. A58-0380 01/12/2015*/
            /*---Releas Data--*/
            FOR EACH tlist BREAK BY tlist.npolicy:
                FIND FIRST sic_bran.uwm100 WHERE RECID(uwm100) = tlist.nrecid EXCLUSIVE-LOCK.
                IF AVAIL uwm100 THEN uwm100.releas = YES.
                DELETE tlist.
            END.

            nv_err = "".
            /*----Check Data----*/
            FOR EACH ttexts BREAK BY ttexts.ngroup
                                  BY ttexts.nline:
                PUT STREAM ns10 ttexts.ntext FORMAT "X(1000)" SKIP.
            END.
        END.  /*end  Group = 9*/  /*end nv_err = ""*/
    END.
    ELSE DO:
        IF LOCKED(uwm100) THEN nv_err = "Open Polciy is in use by Another user".
                          ELSE nv_err = "Data Error Please Check Again!!!".
    END.
    /*--- END. comment by Chaiyong W. A58-0380 01/12/2015*/
    
    OUTPUT STREAM ns9  CLOSE.
    OUTPUT STREAM ns10 CLOSE.
END.
FOR EACH  ttext:
    DELETE  ttext.
END.

FOR EACH ttexts:
    DELETE ttexts.
END.

FOR EACH tlist:
    DELETE tlist.
END.

RELEASE sicuw.uwm100.
RELEASE sicuw.uwm120.
RELEASE sic_bran.uwm100.
