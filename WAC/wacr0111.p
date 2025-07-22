/*--- Check Credit Control ---*/ 
/*--- Create By Nattanicha K. A61-0158 09/07/2018 ---*/

/*Modify by : Ranu I. A61-0035 24/08/2018  ��Ѻ˹�Ҩ� Update r-code */
/*Modify by : Ranu I. A61-0035 25/10/2018  ��Ѻ˹�Ҩ����͹䢡����ǧ�Թ */

DEF VAR nv_bal    AS DEC FORMAT "->>,>>>,>>>,>>9.99".
DEF BUFFER bfxmm600 FOR xmm600.
DEF BUFFER bfagtprm_fil FOR agtprm_fil.  /*A61-0035*/

ASSIGN  nv_bal = 0.

/*---Clear Record OVerCredit---*/
FIND FIRST xmm600 USE-INDEX xmm60001 
         WHERE xmm600.acno >= "A000000" AND
               xmm600.crcon  = YES     NO-ERROR NO-WAIT.
IF AVAIL xmm600 THEN DO:  
    sicsyac.xmm600.iblack = "".
    
    REPEAT:
         FIND NEXT xmm600 USE-INDEX xmm60001 
             WHERE xmm600.crcon  = YES .
         /*IF xmm600.acno >= "Bzzzzzzzzz" OR NOT AVAIL xmm600 THEN LEAVE. */  /*A61-0035 */
         IF xmm600.acno >= "Bzzzzzzzz"  THEN LEAVE.   /*A61-0035*/
         IF NOT AVAIL xmm600 THEN LEAVE.              /*A61-0035*/

         sicsyac.xmm600.iblack = "".
         
    END.
END. 
RELEASE xmm600 NO-ERROR.
/*------------------------------*/

FOR EACH xmm600 USE-INDEX xmm60001 NO-LOCK.

    IF xmm600.crcon = YES THEN DO:   /*--- Check ��� Code 㴵�ͧ��� Check Credit Limit ---*/

        IF xmm600.iblack <> "OverCredit" THEN DO: 

            FIND FIRST agtprm_fil USE-INDEX by_acno WHERE /*agtprm_fil.acno   = xmm600.gpstmt  A61-0035 */  /*--- �٨ҡ Group Code ��͹����Ŵ�����ҹ������ ---*/
                                        agtprm_fil.acno   = xmm600.acno    /*A61-0035 */
                                  AND   agtprm_fil.asdat  = 1/11/2000  /*---��ͧ�к��ѹ��������͹Ӣ����� Summary Bal. �ͧ Acno ---*/
                                  AND   agtprm_fil.bal    <> 0 NO-LOCK NO-ERROR.
            IF AVAIL agtprm_fil THEN DO:

                DISP agtprm_fil.asdat agtprm_fil.acno
                WITH COLOR BLACK/WHITE NO-LABEL TITLE "Check Credit Limit..." FRAME frProcessCr VIEW-AS DIALOG-BOX.
                
                PAUSE 0.
                nv_bal = 0.

                /* ������� Code �١������� */
                IF xmm600.acno = xmm600.gpstmt THEN DO:   /* ������� Code �١�� */

                   /* ������Թǧ�Թ����ͧ������� */
                   IF agtprm_fil.bal > xmm600.ltamt THEN DO:    /* ����Թǧ�Թ����ͧ */  

                      /*�礵���������١������� ������١ diIu����Թ��� lock ���+�١������ */
                      FOR EACH bfxmm600 USE-INDEX xmm60009    
                          WHERE bfxmm600.gpstmt = xmm600.gpstmt.
                               
                          ASSIGN bfxmm600.iblack  = "OverCredit"
                                 bfxmm600.crcon   = YES .      /*A61-0035 */
                  
                      END. /* end for each bfxmm600 */
                      RELEASE bfxmm600.

                   END. 
                   ELSE DO:   
                        /* �������Թǧ�Թ �����������١������� �������� sum bal �ͧ�ء*/
                        FOR EACH bfxmm600 USE-INDEX xmm60009 
                            WHERE bfxmm600.gpstmt = xmm600.gpstmt  NO-LOCK.
                         /* start : A61-0035 */
                         FIND FIRST bfagtprm_fil USE-INDEX by_acno WHERE 
                                    bfagtprm_fil.acno   = bfxmm600.acno AND
                                    bfagtprm_fil.asdat  = 1/11/2000    NO-LOCK NO-ERROR.

                                  IF AVAIL bfagtprm_fil THEN DO: 
                                       nv_bal = nv_bal + bfagtprm_fil.bal.
                                  END.
                         /* end A61-0035 */
                         /* nv_bal = nv_bal + agtprm_fil.bal. */ /*A61-0035 */
                        END.

                        /* ����� sum bal �١������ �Թ���������� */
                        IF nv_bal > xmm600.ltamt THEN DO:  /*����Թǧ�Թ���*/
                        
                           /* ��� Lock �١������ */
                           FOR EACH bfxmm600 USE-INDEX xmm60009 
                              WHERE bfxmm600.gpstmt = xmm600.gpstmt.
                                  
                               ASSIGN bfxmm600.iblack  = "OverCredit"
                                      bfxmm600.crcon   = YES .      /*A61-0035 */    
                        
                           END. /* end for each bfxmm600 */
                           RELEASE bfxmm600.
                        
                        END.   /* end if nv_bal > xmm600.ltamt */
                        ELSE DO: /* �������Թǧ�Թ��� ����ͧ Lock */
                            FOR EACH bfxmm600 USE-INDEX xmm60001 
                              WHERE bfxmm600.acno  = xmm600.acno.
                        
                               ASSIGN bfxmm600.iblack  = "".       
                        
                           END. /* end for each bfxmm600 */
                           RELEASE bfxmm600.
                        
                        END.
                   END.  /* end else do ����������Թǧ�Թ ������� bal �ء */

                END.  /* end if xmm600.acno =  xmm600.gpstmt */
                ELSE DO:  /* �ó� xmm600.acno <> xmm600.gpstmt */

                    nv_bal = agtprm_fil.bal.

                    IF nv_bal > xmm600.ltamt THEN DO:
                       FIND FIRST bfxmm600 USE-INDEX xmm60001 
                              WHERE bfxmm600.acno  = xmm600.acno NO-ERROR.
                       IF AVAIL bfxmm600 THEN DO:
                        
                               ASSIGN bfxmm600.iblack  = "OverCredit"
                                      bfxmm600.crcon   = YES.       /*A61-0035*/
                        
                       END. /* end for each bfxmm600 */
                       RELEASE bfxmm600.

                    END.   /* end nv_bal*/
                END.
            END.   /*end agtprm_fil*/
        END. /* xmm600.iblack */
    END.   /* if xmm600.crcon = yes*/
   
END.  /*end for each xmm600*/

RELEASE xmm600.
RELEASE agtprm_fil.

DISP "*** Check Over Credit Limit ���º���� ***" 
         "����ö�� Log File for Process ��� D:\TEMP\LogProcStmt.slk" WITH 1 COLUMN 1 DOWN TITLE "Check Credit Limit Complete".

MESSAGE "�����ż����º����"  VIEW-AS ALERT-BOX INFORMATION.
   

