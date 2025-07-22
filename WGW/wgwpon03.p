/* program id  :  wgwpon03.p ....RUNNING POLICY NO ....by Company code..   */
/* Copyright   :  # Safety Insurance Public Company Limited                */
/*                บริษัท ประกันคุ้มภัย จำกัด (มหาชน)                       */
/* create by   : Kridtiya i. A55-0015  date. 10/01/2012                    */
/* Duplicate from  : qwpolno3.P                                            */

DEFINE INPUT        PARAMETER nv_dir_ri   AS LOGICAL                  NO-UNDO.
DEFINE INPUT        PARAMETER nv_poltyp   AS CHARACTER FORMAT "X(3)"  NO-UNDO.
DEFINE INPUT        PARAMETER nv_branch   AS CHARACTER FORMAT "X(2)"  NO-UNDO.
DEFINE INPUT        PARAMETER nv_undyr    AS CHARACTER FORMAT "X(4)"  NO-UNDO.
DEFINE INPUT        PARAMETER nv_acno1    AS CHARACTER FORMAT "X(7)"  NO-UNDO.
DEFINE INPUT-OUTPUT PARAMETER n_policy    AS CHARACTER FORMAT "X(12)" NO-UNDO.
DEFINE INPUT-OUTPUT PARAMETER nv_message  AS CHARACTER                NO-UNDO.  

DEFINE VAR  nv_polno     AS   INTEGER    INIT 0         NO-UNDO.
DEFINE VAR  nv_polno70   AS   INTEGER    INIT 0         NO-UNDO.
DEFINE VAR  nv_polno72   AS   INTEGER    INIT 0         NO-UNDO.
DEFINE VAR  nv_brnpol    AS   CHARACTER  INITIAL ""     NO-UNDO.
DEFINE VAR  nv_startno   AS   CHARACTER  INITIAL ""     NO-UNDO.
DEFINE VAR  nv_runsafuw  AS   LOGICAL    INITIAL NO     NO-UNDO.
DEFINE VAR  nv_undyr2543 AS   CHARACTER  FORMAT "X(4)"  NO-UNDO.
DEFINE VAR  nv_polno2543 AS   INTEGER                   NO-UNDO.
DEFINE VAR  nv_poltyp2   AS   CHAR       FORMAT "x(3)"  INIT "".    
IF nv_undyr <= "1999" THEN nv_undyr2543 = nv_undyr.
ELSE DO:
    nv_polno2543 = INTEGER(nv_undyr) + 543.
    nv_undyr2543 = STRING(nv_polno2543,"9999").
END.
ASSIGN  nv_message = "".
FIND FIRST sicsyac.s0m003  WHERE                        /* not has index */
    TRIM(sicsyac.s0m003.fld11)  = TRIM(nv_branch)  AND   
    TRIM(sicsyac.s0m003.fld22)  = TRIM(nv_acno1)        /* producer      */
    NO-LOCK NO-ERROR NO-WAIT.                           
IF AVAILABLE sicsyac.s0m003 THEN DO:                    
    ASSIGN nv_brnpol  = sicsyac.s0m003.fld12            /* BRANCH POLICY */
        nv_startno    = sicsyac.s0m003.fld21.           /* START NO */
    IF nv_brnpol = "" THEN  nv_brnpol = nv_branch.      
END.
ELSE DO:  
    ASSIGN n_policy = "".
    MESSAGE "Not Fond Set running policy  !!!"   SKIP
            "Plese Set up Company code.   !!!"   SKIP
            "สาขา : " + nv_branch  + "Producer: " + nv_acno1  VIEW-AS ALERT-BOX.
    NEXT.
END.   
HIDE MESSAGE NO-PAUSE.   
IF nv_startno <> "" THEN DO:    /* Running Policy no. */
    FIND FIRST stat.polno_fil USE-INDEX polno01     WHERE
        stat.polno_fil.dir_ri   = nv_dir_ri     AND
        stat.polno_fil.poltyp   = nv_poltyp     AND
        stat.polno_fil.branch   = nv_branch     AND
        stat.polno_fil.undyr    = nv_undyr2543  AND
        stat.polno_fil.brn_pol  = nv_brnpol     AND     /*4M 4=Branch M=Malaysia*/
        stat.polno_fil.start_no = nv_startno            /*1=A 2=AB ""=""*/
        EXCLUSIVE-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAILABLE stat.polno_fil THEN DO:
        IF LOCKED stat.polno_fil THEN DO:
            nv_message = "LOCK".
            RETURN.
        END.
        CREATE stat.polno_fil.
        ASSIGN 
            stat.polno_fil.dir_ri   = nv_dir_ri
            stat.polno_fil.poltyp   = nv_poltyp
            stat.polno_fil.branch   = nv_branch
            stat.polno_fil.brn_pol  = nv_brnpol         /*4M 4=Branch M=Malaysia*/
            stat.polno_fil.undyr    = nv_undyr2543
            stat.polno_fil.start_no = nv_startno        /*1=A 2=AB ""=""*/
            stat.polno_fil.nextno   = 2
            nv_polno = 1.
    END.
    ELSE DO:                                            /* AVAILABLE stat.polno_fil */
        ASSIGN
            nv_polno   = stat.polno_fil.nextno    
            stat.polno_fil.nextno = nv_polno + 1.       /*กรณีเจอ  ตัวแรก*/
        IF (nv_startno = "H") OR (nv_startno = "S") THEN DO:
            ASSIGN nv_poltyp2 = "".
            IF nv_poltyp = "v70"  THEN
                nv_poltyp2 = "v72".
            ELSE  nv_poltyp2 = "v70".
            FIND FIRST stat.polno_fil USE-INDEX polno01     WHERE
                stat.polno_fil.dir_ri   = nv_dir_ri     AND
                stat.polno_fil.poltyp   = nv_poltyp2    AND
                stat.polno_fil.branch   = nv_branch     AND
                stat.polno_fil.undyr    = nv_undyr2543  AND
                stat.polno_fil.brn_pol  = nv_brnpol     AND     /*4M 4=Branch M=Malaysia*/
                stat.polno_fil.start_no = nv_startno            /*1=A 2=AB ""=""*/
                EXCLUSIVE-LOCK NO-ERROR NO-WAIT.
            IF  AVAILABLE stat.polno_fil THEN 
                ASSIGN  stat.polno_fil.nextno = nv_polno + 1. 
        END.
    END.
END.
ELSE DO:              /*nv_startno = ""  เนื่องจาก สาขาเข้ามาเป้นค่าว่าง*/
    loop_xzm057:
    REPEAT:
        FIND FIRST sicsyac.xzm057  WHERE 
            sicsyac.xzm057.dir_ri = nv_dir_ri  AND
            sicsyac.xzm057.poltyp = nv_poltyp  AND
            sicsyac.xzm057.branch = nv_branch  NO-WAIT NO-ERROR.
        IF NOT AVAILABLE sicsyac.xzm057 THEN DO:
            IF LOCKED sicsyac.xzm057 THEN NEXT loop_xzm057.
            ELSE DO: 
                CREATE sicsyac.xzm057.
                ASSIGN 
                    sicsyac.xzm057.dir_ri = nv_dir_ri
                    sicsyac.xzm057.poltyp = nv_poltyp
                    sicsyac.xzm057.branch = nv_branch
                    sicsyac.xzm057.nextno = 2
                    nv_polno      = 1.    
            END.
        END. 
        ELSE DO:
            ASSIGN nv_polno            = sicsyac.xzm057.nextno
                sicsyac.xzm057.nextno = sicsyac.xzm057.nextno + 1.
        END.
        LEAVE loop_xzm057.
    END.                  /*  repeat......*/
END.                      /*  nv_startno = "" */
RELEASE sicsyac.xzm057.
RELEASE stat.polno_fil.
n_policy = "".
IF LENGTH(nv_brnpol) = 1 THEN DO:
    IF nv_dir_ri THEN n_policy = "D".
    ELSE              n_policy = "I".
END.
ELSE n_policy = "".
IF nv_startno = "" THEN 
    n_policy  = TRIM(n_policy)
    + TRIM(nv_brnpol)
    + SUBSTRING(nv_poltyp,2,2)
    + SUBSTRING(nv_undyr2543,3,2)
    + STRING(nv_polno,"999999").
ELSE IF LENGTH(TRIM(nv_startno)) = 1 THEN 
    /* D M 72 52 H 0 0 0 0 1 */
    n_policy  = TRIM(n_policy) 
                + TRIM(nv_brnpol)
                + SUBSTRING(TRIM(nv_poltyp),2,2)
                + SUBSTRING(nv_undyr2543,3,2) 
                + TRIM(nv_startno) 
                + STRING(nv_polno,"99999").
ELSE IF LENGTH(TRIM(nv_startno)) = 2 THEN 
    /* D27098VB1234 */
    n_policy  = TRIM(n_policy) 
                + TRIM(nv_brnpol)
                + SUBSTRING(TRIM(nv_poltyp),2,2)
                + SUBSTRING(nv_undyr2543,3,2)
                + TRIM(nv_startno)
                + STRING(nv_polno,"9999").
ELSE   n_policy  = TRIM(n_policy)

                  + TRIM(nv_brnpol)
                  + SUBSTRING(nv_poltyp,2,2)
                  + SUBSTRING(nv_undyr2543,3,2)
                  + STRING(nv_polno,"999999").
RELEASE stat.polno_fil.
RELEASE sicsyac.xzm057.
nv_message = "".

/* END OF : wgwponO3.P */
