/* program ID   : wgwchkagpd.p                    */
/* Program name : check data Agent producer code  */
/* create by    : Ranu I. A63-0449 import text file */

DEFINE INPUT         PARAMETER  nv_agent     AS CHAR FORMAT "x(12)".
DEFINE INPUT         PARAMETER  nv_producer  AS CHAR FORMAT "x(12)" .
DEFINE INPUT-OUTPUT  PARAMETER  nv_chkerror  AS CHAR FORMAT "x(500)".

/*DEF VAR nv_agent    AS CHAR FORMAT "x(12)" INIT "a000000".
DEF VAR nv_producer AS CHAR FORMAT "x(12)" INIT "b000013" .
DEF VAR nv_chkerror AS CHAR FORMAT "x(500)" .*/
DEF BUFFER bxmm600 FOR sicsyac.xmm600.

FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = TRIM(nv_agent) NO-LOCK NO-ERROR.
IF AVAIL sicsyac.xmm600 THEN DO:
    /* �� lincen Agent code */
    /* comment by : A64-0092 ...
    IF sicsyac.xmm600.agtreg = "" THEN DO: /* agent ����� licen */
        ASSIGN nv_chkerror = nv_chkerror + "|" + nv_agent + " Agent Licence no. is Null " .
    END.
    ELSE IF sicsyac.xmm600.regdate <> ? AND sicsyac.xmm600.regdate < TODAY THEN DO: /* agent �� Lincen �� �ѹ��� licen expire */
        ASSIGN nv_chkerror = nv_chkerror + "|" + nv_agent + " Agent Licence Expire Date: " + STRING(sicsyac.xmm600.regdate,"99/99/9999") .
    END.
    ELSE IF sicsyac.xmm600.iblack <> "" THEN DO:  /* check over credit */
        ASSIGN nv_chkerror = nv_chkerror + "|" + nv_agent + " Agent code has OVER CREDIT " .
    END.
    ELSE
    .... end A64-0092....*/
    IF sicsyac.xmm600.clicod = "DI" THEN DO:  /* agent = DI //����� Licen no . ����� over credit */
        IF sicsyac.xmm600.closed <> ? AND sicsyac.xmm600.closed < TODAY THEN DO: 
            ASSIGN nv_chkerror = nv_chkerror + "|" + nv_Agent + " Agent Code Closed Date: " + STRING(sicsyac.xmm600.closed,"99/99/9999") .
        END.
        ELSE IF sicsyac.xmm600.regdate <> ? AND sicsyac.xmm600.regdate < TODAY THEN DO: /* agent �� Lincen �� �ѹ��� licen expire */
            ASSIGN nv_chkerror = nv_chkerror + "|" + nv_agent + " Agent Licence Expire Date: " + STRING(sicsyac.xmm600.regdate,"99/99/9999") .
        END.
        ELSE DO:
            FIND LAST bxmm600 USE-INDEX xmm60001 WHERE bxmm600.acno = TRIM(nv_producer) NO-LOCK NO-ERROR.
            IF AVAIL bxmm600 THEN DO:
                IF bxmm600.clicod <> "DI" THEN DO: /* Producer <> DI */
                    FIND LAST stat.acno_fil USE-INDEX acno01 WHERE stat.acno_fil.acno = bxmm600.acno NO-LOCK NO-ERROR . /* �礢����ŷ�� acno_fil */
                        IF NOT AVAIL stat.acno_fil THEN /* ����բ����ŷ�� acno_fil */
                            ASSIGN nv_chkerror = nv_chkerror + "|" + nv_agent + " Agent Client type Equals 'DI'/ Producer " + nv_producer + " Client type Not Equals 'DI' and not found on Parameter(acno_fil)".
                        ELSE DO: 
                            /* ���ѹ���Դ�� ���¡��� �ѹ��������ͧ */
                            IF bxmm600.closed <> ? AND bxmm600.closed < TODAY THEN DO: 
                                ASSIGN nv_chkerror = nv_chkerror + "|" + nv_producer + " Producer Code Closed Date: " + STRING(bxmm600.closed,"99/99/9999") .
                            END.
                            /* add by : A64-0092 */
                            ELSE IF bxmm600.regdate <> ? AND bxmm600.regdate < TODAY THEN DO:
                                ASSIGN nv_chkerror = nv_chkerror + "|" + nv_producer + " Producer Licence Expire Date: " + STRING(bxmm600.regdate,"99/99/9999") .
                            END.
                            /* end A64-0092 */
                            /* comment by : A64-0092...
                            ELSE DO: 
                                /* �ѧ���Դ�� �� Over Credit */
                                IF bxmm600.iblack <> "" THEN ASSIGN nv_chkerror = nv_chkerror + "|" + nv_producer + " Producer code has OVER CREDIT " .
                                ELSE DO: 
                                    /* ���Դ Over credit */
                                    IF bxmm600.agtreg = "" THEN DO: /* producer code ����� licen */
                                        /* �� lincen Agent code */
                                        IF sicsyac.xmm600.agtreg = "" THEN  /* agent ����� licen */
                                            ASSIGN nv_chkerror = nv_chkerror + "|" + nv_agent + " Agent Licence no. is Null " .
                                        ELSE DO: /* agent �� Lincen �� �ѹ��� licen expire */
                                            IF sicsyac.xmm600.regdate <> ? AND sicsyac.xmm600.regdate < TODAY THEN
                                            ASSIGN nv_chkerror = nv_chkerror + "|" + nv_agent + " Agent Licence Expire Date: " + STRING(sicsyac.xmm600.regdate,"99/99/9999") .
                                        END.
                                    END.
                                    ELSE DO: /* producer code �� licen check licen expire */
                                        IF bxmm600.regdate <> ? AND bxmm600.regdate < TODAY THEN
                                            ASSIGN nv_chkerror = nv_chkerror + "|" + nv_producer + " Producer Licence Expire Date: " + STRING(bxmm600.regdate,"99/99/9999") .
                                    END.
                                END.
                            END.
                            .... end A64-0092...*/
                        END.
                END.
                ELSE DO: /* Producer code = DI */
                    /* ���ѹ���Դ�� ���¡��� �ѹ��������ͧ */
                    IF bxmm600.closed <> ? AND bxmm600.closed < TODAY THEN DO: 
                        ASSIGN nv_chkerror = nv_chkerror + "|" + nv_producer + " Producer Code Closed Date: " + STRING(bxmm600.closed,"99/99/9999") .
                    END.
                    /* add by : A64-0092 */
                    ELSE IF bxmm600.regdate <> ? AND bxmm600.regdate < TODAY THEN DO:
                        ASSIGN nv_chkerror = nv_chkerror + "|" + nv_producer + " Producer Licence Expire Date: " + STRING(bxmm600.regdate,"99/99/9999") .
                    END.
                    /* end A64-0092 */
                    /* comment by :A64-0092...
                    ELSE DO: 
                        /* �ѧ���Դ�� �� Over Credit */
                        IF bxmm600.iblack <> "" THEN ASSIGN nv_chkerror = nv_chkerror + "|" + nv_producer + " Producer code has OVER CREDIT " .
                        ELSE DO: 
                            /* ���Դ Over credit */
                            IF bxmm600.agtreg = "" THEN DO: /* producer code ����� licen */
                                /* �� lincen Agent code */
                                IF sicsyac.xmm600.agtreg = "" THEN  /* agent ����� licen */
                                    ASSIGN nv_chkerror = nv_chkerror + "|" + nv_agent + " Agent Licence no. is Null " .
                                ELSE DO: /* agent �� Lincen �� �ѹ��� licen expire */
                                    IF sicsyac.xmm600.regdate <> ? AND sicsyac.xmm600.regdate < TODAY THEN
                                    ASSIGN nv_chkerror = nv_chkerror + "|" + nv_agent + " Agent Licence Expire Date: " + STRING(sicsyac.xmm600.regdate,"99/99/9999") .
                                END.
                            END.
                            ELSE DO: /* producer code �� licen check licen expire */
                                IF bxmm600.regdate <> ? AND bxmm600.regdate < TODAY THEN
                                    ASSIGN nv_chkerror = nv_chkerror + "|" + nv_producer + " Producer Licence Expire Date: " + STRING(bxmm600.regdate,"99/99/9999") .
                            END.
                        END.
                    END.
                    .. end A64-0092...*/
                END. /* else producer = DI */
            END. /* avail bxmm600 */
            ELSE DO:
                ASSIGN nv_chkerror = nv_chkerror + "|Not found Producer Code " + nv_producer  + " ���xmm600 ".
            END.
        END.  /* A64-0092 */
    END. /* agent  = DI */
    ELSE DO: /* Agent code Client type <> DI ,Check Producer */
        /* Add by : A64-0092 */
        IF sicsyac.xmm600.closed <> ? AND sicsyac.xmm600.closed < TODAY THEN DO: 
            ASSIGN nv_chkerror = nv_chkerror + "|" + nv_Agent + " Agent Code Closed Date: " + STRING(sicsyac.xmm600.closed,"99/99/9999") .
        END.
        ELSE IF sicsyac.xmm600.agtreg = "" THEN DO: /* agent ����� licen */
            ASSIGN nv_chkerror = nv_chkerror + "|" + nv_agent + " Agent Licence no. is Null " .
        END.
        ELSE IF sicsyac.xmm600.regdate <> ? AND sicsyac.xmm600.regdate < TODAY THEN DO: /* agent �� Lincen �� �ѹ��� licen expire */
            ASSIGN nv_chkerror = nv_chkerror + "|" + nv_agent + " Agent Licence Expire Date: " + STRING(sicsyac.xmm600.regdate,"99/99/9999") .
        END.
        ELSE IF sicsyac.xmm600.iblack <> "" THEN DO:  /* check over credit */
            ASSIGN nv_chkerror = nv_chkerror + "|" + nv_agent + " Agent code has OVER CREDIT " .
        END.
        /* end A64-0092 */
        ELSE DO:
            FIND LAST bxmm600 USE-INDEX xmm60001 WHERE bxmm600.acno = TRIM(nv_producer) NO-LOCK NO-ERROR.
            IF AVAIL bxmm600 THEN DO:
              /* ���ѹ���Դ�� ���¡��� �ѹ��������ͧ */
              IF bxmm600.closed <> ? AND bxmm600.closed < TODAY THEN DO: 
                  ASSIGN nv_chkerror = nv_chkerror + "|" + nv_producer + " Producer Code Closed Date: " + STRING(bxmm600.closed,"99/99/9999") .
              END.
              ELSE DO: 
                  /* �ѧ���Դ�� �� Over Credit */
                  IF bxmm600.iblack <> "" THEN ASSIGN nv_chkerror = nv_chkerror + "|" + nv_producer + " Producer code has OVER CREDIT " .
                  ELSE DO: 
                      /* ���Դ Over credit */
                      IF bxmm600.agtreg = "" THEN DO: /* producer code ����� licen */
                          /* �� lincen Agent code */
                          IF sicsyac.xmm600.agtreg = "" THEN  /* agent ����� licen */
                              ASSIGN nv_chkerror = nv_chkerror + "|" + nv_agent + " Agent Licence no. is Null " .
                          ELSE DO: /* agent �� Lincen �� �ѹ��� licen expire */
                              IF sicsyac.xmm600.regdate <> ? AND sicsyac.xmm600.regdate < TODAY THEN
                              ASSIGN nv_chkerror = nv_chkerror + "|" + nv_agent + " Agent Licence Expire Date: " + STRING(sicsyac.xmm600.regdate,"99/99/9999") .
                          END.
                      END.
                      ELSE DO: /* producer code �� licen check licen expire */
                          IF bxmm600.regdate <> ? AND bxmm600.regdate < TODAY THEN
                              ASSIGN nv_chkerror = nv_chkerror + "|" + nv_producer + " Producer Licence Expire Date: " + STRING(bxmm600.regdate,"99/99/9999") .
                      END.
                  END.
              END.
            END.
            ELSE ASSIGN nv_chkerror = nv_chkerror + "| Not found Producer Code " + nv_producer  + " ���xmm600 ".
        END. /* A64-0092*/
    END. /* end Client type <> DI */
END.
ELSE ASSIGN nv_chkerror = nv_chkerror + "| Not found Agent Code " + nv_agent + " ���xmm600 ".
