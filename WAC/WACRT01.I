/************************************ 
/* Create  By : Kanchana C.       Assign No.  :   A46-0142      23/02/2004*/
    Program     : wacr0601.i 
    Main program :    wacr06.w
    
    loop �ҡ Azo40001.p 
    
/* Modify : Kanchana C.             Assign No.  :   A47-0076   04/03/2004*/
    - �ӹǹ ��������´  ŧ���   /* DISPLAY DETAIL */
    DEF VAR nv_YZ AS CHAR INIT "YS,ZS". /* �֧�ʹ bal ���ҧ���� */
    DEF VAR nv_CB AS CHAR INIT "C,B".
    DEF VAR nv_MRA AS CHAR INIT "M,R".
    
/* Modify : Kanchana C.            Assign No.  :     A47-0158   30/04/2004*/
   ��ѡ��äӹǳ
   1. �֧ record  ����ʹ bal <> 0 ��  
        �ó�  
        -  type ��� ��������  M R    ���ʹ bal � Process Date ������������  ��˹�ŧ ��ͧ��ҧ �

        - 1.  type  M R    ���ʹ bal � Process Date  �ҵ������͹   
           2. �� acd001  transaction ����Դ���   �����  contra date   >  asdate   ���   entry date  <=   process date
            �����ѡ  ��¡�ù�� � �͡ �ҡ bal 㹢��   1.   �֧���� bal  ����ͧ���
    
/*MODIFY BY : KANCHANA C.   Assign No.  :   A48-0265        24/05/2005 */
- ����  ������¡��� Agent code
- report by line  ����¹�ҡ acno �� agent 
- ��� ...OS  �����ʹ���  ��� �ӹǹ�ѹ����

/***--- assign A490120 chage asdate process to be asdate for calculate ***/
/***--- and change ladat to be the 1st of next month ---***/

/* Modify By : Lukkana M.  Date : 26/11/2009              */
/* Assign No : A52-0318 ��Ѻ Report ������¹�������ҡ ����Թ 60 �ѹ , 61 - 90 �ѹ , 91- 365 �ѹ , 365 �ѹ����
            ����  ����Թ 30 �ѹ , 31-60 �ѹ , 61-90 �ѹ , 91-120 �ѹ , 121-150 �ѹ , 151-180 �ѹ , 181-210 �ѹ
            211-240 �ѹ , 241-270 �ѹ , 271-300 �ѹ , 301-330 �ѹ , 331-365 �ѹ , 365 �ѹ����              */
    
***************************************/
 
            ASSIGN
                nv_premCB   = 0
                nv_commCB   = 0
                nv_totalCB  = 0
                
                ntax%       = 0
                nv_taxA     = 0
                nv_stampA   = 0
                
                nv_premA    = 0
                nv_commA    = 0
                nv_balA     = 0

                nv_retcA    = 0
                nv_suspA    = 0
                nv_netarA   = 0
                nv_netothA  = 0

                nv_balDet   = 0. /* bal ���͡ŧ 15 ��ͧ  file detail*/
        
            ASSIGN 
                nv_premA    = agtprm_fil.prem + agtprm_fil.prem_comp
                nv_taxA     = agtprm_fil.tax
                nv_stampA   = agtprm_fil.stamp
                
                nv_commA    = agtprm_fil.comm + agtprm_fil.comm_comp
                nv_totalA   = nv_premA + nv_taxA + nv_stampA   /* gross */

                nv_netA     = nv_totalA + nv_commA       /*   prem + tax + stamp + comm */
                nv_balA     = agtprm_fil.bal.
                             

            IF LOOKUP(agtprm_fil.trntyp,nv_CB) = 0 AND  LOOKUP(agtprm_fil.trntyp,nv_yz) = 0 THEN 
                ASSIGN
                    nv_premCB   = (agtprm_fil.prem + agtprm_fil.prem_comp) + agtprm_fil.tax + agtprm_fil.stamp
                    nv_commCB   = (agtprm_fil.comm + agtprm_fil.comm_comp)
                    nv_totalCB  =  agtprm_fil.gross .


                ASSIGN
                  nv_sumprm  = 0
                  nv_sumcom  = 0
                  nv_sumsup  = 0
      
                  nv_prm     = 0
                  nv_com     = 0
                  nv_sup     = 0
                  nv_spcp    = 0
      
                  nv_pprm    = 0
                  nv_stamp   = 0
                  nv_tax     = 0
                  
                  n_trnty1 = ""
                  n_trnty2 = ""
                  
                  n_trnty1 = SUBSTRING(agtprm_fil.trntyp,1,1)
                  n_trnty2 = SUBSTRING(agtprm_fil.trntyp,2,1)
                  .
                /**/
                DEF VAR n_sumpremM AS DECI FORMAT ">>>,>>>,>>9.99-" .
                DEF VAR n_sumcommM AS DECI FORMAT ">>>,>>>,>>9.99-" .

                DEF VAR n_sumpremR AS DECI FORMAT ">>>,>>>,>>9.99-" .
                DEF VAR n_sumcommR AS DECI FORMAT ">>>,>>>,>>9.99-" .

                ASSIGN
                    n_sumpremM = 0
                    n_sumcommM = 0
                    n_sumpremR = 0
                    n_sumcommR = 0.
                /**/

/* insert */
          /*note add exp dat*/
            DEF  VAR NO_expdat AS DATE FORMAT "99/99/9999".
            FIND LAST uwm100 WHERE uwm100.policy = agtprm_fil.policy
            NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL uwm100  THEN DO:
                no_expdat = uwm100.expdat. 
            END.
            ELSE DO:
                NO_expdat = ?.
            END.
            
          /*end note expdat*/
          /*-------------------  FOR EACH Acd001  ---------------------*//* �� nv_sumprm, nv_sumcom, nv_sumsup */
            FOR EACH Acd001 USE-INDEX Acd00191
                WHERE Acd001.TrnTy1 = n_trnty1
                AND   Acd001.docno  = agtprm_fil.docno
                NO-LOCK :
            
                    IF (Acd001.cjodat > n_asdat )  AND  (Acd001.entdat <= n_processdate)  THEN DO:   /* A47-0158   (Acd001.cjodat > n_asdat ) */

                       FIND FIRST Acm002 WHERE Acm002.TrnTy1 = Acd001.ctrty1 AND
                                              Acm002.docno  = Acd001.cdocno
                                          NO-LOCK NO-ERROR.
                       ASSIGN 
                         n_trnty2  = IF AVAIL Acm002 THEN Acm002.TrnTy2 ELSE " "
                         nv_netamt = IF Acd001.netamt < 0 THEN Acd001.netamt * -1
                                     ELSE Acd001.netamt.                            
                      
                            IF n_trnty2 = "p" THEN nv_sumprm = nv_sumprm + nv_netamt.
                       ELSE IF n_trnty2 = "c" THEN nv_sumcom = nv_sumcom + nv_netamt.
                       ELSE IF n_trnty2 = "s" THEN nv_sumsup = nv_sumsup + nv_netamt.
                      
                    END. /*---  IF Acd001.cjodat > n_asdat ---*/

                IF (Acd001.cjodat <= n_asdat ) AND  (Acd001.entdat <= n_processdate)  THEN DO: /* �ء��·��ӡ�� match ���֧ process date */

                    IF acd001.trnty1 = "M" OR n_trnty1 =  "O" THEN DO:
                    
                        IF acd001.netamt < 0 THEN  /* �ʴ���� �Ѵ ���� +  */
                            n_sumpremM = n_sumpremM + acd001.netamt.    /* ��¡�÷����ҵѴ  �Դ */
                        ELSE
                            n_sumcommM = n_sumcommM + acd001.netamt.

                    END.

                    IF acd001.trnty1 = "R" OR n_trnty1 =  "T" THEN DO:

                        IF acd001.netamt > 0 THEN  /* �ʴ���� �Ѵ ���� -  */
                            n_sumpremR = n_sumpremR + acd001.netamt.
                        ELSE
                            n_sumcommR = n_sumcommR + acd001.netamt.

                    END.

                END.


                ASSIGN
                  n_trnty2  = " "
                  nv_netamt = 0.
            END. /*---  FOR EACH Acd001  ---*/


          /***------------------------- �Ѻ�����Թ ------------------------***/
          IF   n_trnty1 = "M" OR n_trnty1 =  "O"   /* A42-0089  or  acm001.trnty1  =  "O" */              
             THEN DO:  

             /*--- �ѧ����ա���Ѻ�Թ��¡��� � ---*/
             IF nv_netA = agtprm_fil.bal THEN  /* P */  /* acm001.netamt  = nv_netA  */
                ASSIGN
                  nv_prm   = (agtprm_fil.prem + agtprm_fil.prem_comp) + agtprm_fil.tax + agtprm_fil.stamp
                  nv_com   = (agtprm_fil.comm + agtprm_fil.comm_comp)

                  nv_pprm  = (agtprm_fil.prem + agtprm_fil.prem_comp)  /* Net Premium Befor TAX, Stamp */
                  nv_stamp = agtprm_fil.stamp /* Stamp */
                  nv_tax   = agtprm_fil.tax   /* TAX   */
                  .

             /* A47-0158 ---*/
             /*--- �Ѵ��¡�õ�ҧ � �ú����  ---*/
             /* 
             IF agtprm_fil.bal = 0 THEN 
                ASSIGN
                  nv_prm = nv_sumprm
                  nv_com = nv_sumcom * -1

                  nv_pprm  = nv_sumprm - agtprm_fil.stamp - agtprm_fil.tax
                  nv_stamp = agtprm_fil.stamp /* Stamp */
                  nv_tax   = agtprm_fil.tax   /* TAX   */
                  .
            */
             /*------------------ �ѧ�Ѵ��¡�����ú  -------------*/
             /*
             IF (nv_netA <> agtprm_fil.bal) AND (agtprm_fil.bal > 0) THEN /* P */  /*Acm001.netamt = nv_netA */
                DO:
                  ASSIGN 
                    nv_prm   = (agtprm_fil.bal - (agtprm_fil.comm + agtprm_fil.comm_comp)) + nv_sumprm
                    nv_com   = (agtprm_fil.comm + agtprm_fil.comm_comp) + (nv_sumcom * -1)
                    
                    nv_tax   = IF nv_sumprm > agtprm_fil.tax THEN agtprm_fil.tax
                                        ELSE nv_sumprm
                    nv_stamp = IF (nv_sumprm - nv_tax) > agtprm_fil.stamp THEN
                                                agtprm_fil.stamp
                                             ELSE (nv_sumprm - nv_tax)
                    nv_pprm  = IF (nv_sumprm - nv_tax - nv_stamp) > 0 THEN
                                            (nv_sumprm - nv_tax - nv_stamp)
                                            ELSE 0.
                END. /* DO */
             */
             /*---------------------------------------------------------------*/
             /*
             /* ��� comm. �еԴź  */
             IF agtprm_fil.bal < 0
                /*   acm001.bal  =   acm001.comm  98/0061 */
                THEN 
                /*  have  as of */
                ASSIGN
                  nv_prm   = nv_sumprm
                  nv_pprm  = nv_sumprm - agtprm_fil.stamp - agtprm_fil.tax
                  nv_stamp = agtprm_fil.stamp /* Stamp */
                  nv_tax   = agtprm_fil.tax   /* TAX   */

                  nv_com   = agtprm_fil.bal + ( nv_sumcom * -1 ).
             */
             /*--- A47-0158 */

             IF (nv_netA <> agtprm_fil.bal) THEN /* P */  
                DO:
                  ASSIGN 
                    nv_prm = nv_totalA + n_sumpremM
                    nv_com = nv_commA  + n_sumcommM
                    
                    nv_pprm     = 0
                    nv_stamp    = 0
                    nv_tax      = 0 .

             END.


          END.  /*---  SUBSTRING(agtprm_fil.trntyp,1,1)= M, A, O  ---*/


          /*---  �׹���� / Prem.,TAX,Stamp �Դź / Comm. �繺ǡ -----*/
          IF n_trnty1 = "R" OR  n_trnty1 =  "T"   /*  A42-0089   or  acm001.trnty1  =  "T" */
             THEN DO:

             /*---  �ѧ����ա�÷���¡�õѴ���� ----*/
             IF nv_netA = agtprm_fil.bal THEN  /* P */  /*Acm001.netamt */
                ASSIGN
                  nv_prm   = (agtprm_fil.prem + agtprm_fil.prem_comp) + agtprm_fil.tax + agtprm_fil.stamp

                  nv_pprm  = (agtprm_fil.prem + agtprm_fil.prem_comp)  /* Net Premium Befor TAX, Stamp */
                  nv_stamp = agtprm_fil.stamp /* Stamp */
                  nv_tax   = agtprm_fil.tax   /* TAX   */

                  nv_com = (agtprm_fil.comm + agtprm_fil.comm_comp)
                  .

             /* A47-0158 */
             /*---  ���¤ú���� ---*/
             /*
             IF agtprm_fil.bal = 0 THEN
                ASSIGN
                  nv_prm   = nv_sumprm * -1

                  nv_pprm  = nv_prm - agtprm_fil.stamp - agtprm_fil.tax
                  nv_stamp = agtprm_fil.stamp /* Stamp */
                  nv_tax   = agtprm_fil.tax   /* TAX   */

                  nv_com = nv_sumcom.
            */
             /*--------------------     �������Ǻҧ��ǹ  ---------------------*/
             /*
             IF (nv_netA <> agtprm_fil.bal) AND (agtprm_fil.bal <> 0) THEN /* P */ /*  Acm001.netamt */
                ASSIGN
                  nv_prm = (agtprm_fil.bal - (agtprm_fil.comm + agtprm_fil.comm_comp)) + (nv_sumprm * -1 )
                  nv_com = (agtprm_fil.comm + agtprm_fil.comm_comp) + nv_sumcom 
                    
                  nv_tax   = IF nv_sumprm > (agtprm_fil.tax * -1) THEN 
                                        agtprm_fil.tax
                                     ELSE (nv_sumprm * -1)
                  nv_stamp = IF (nv_sumprm - nv_tax) > (agtprm_fil.stamp * -1) THEN
                                            agtprm_fil.stamp
                                         ELSE (nv_sumprm - nv_tax) * -1
                  nv_pprm  = IF (nv_sumprm * -1) - (nv_tax - nv_stamp) > 0 THEN
                                        (nv_sumprm * -1) - (nv_tax - nv_stamp)
                                        ELSE 0.
                  .
            */
             /*---------------------     ��ҧ���¤�� Comm.  ------------------*/
             /*
             IF agtprm_fil.bal > 0  THEN         /* acm001.bal = acm001.comm 98/0061 */ 
                ASSIGN
                  nv_prm = nv_sumprm  * -1
                  nv_com = agtprm_fil.bal + nv_sumcom 

                  nv_pprm  = nv_prm - agtprm_fil.stamp - agtprm_fil.tax
                  nv_stamp = agtprm_fil.stamp /* Stamp */
                  nv_tax   = agtprm_fil.tax   /* TAX   */
                  .
            */
             /* A47-0158 */

             IF (nv_netA <> agtprm_fil.bal) THEN /* P */  
                DO:
                  ASSIGN 
                    nv_prm = nv_totalA + n_sumpremR
                    nv_com = nv_commA  + n_sumcommR
                    
                    nv_pprm     = 0
                    nv_stamp    = 0
                    nv_tax      = 0 .

             END.


          END.  /*---  IF SUBSTRING(agtprm_fil.trntyp,1,1)= R, B, T ---*/

          /***-----------------------     �Ѻ�Թ  -------------------------***/
          IF n_trnty1 = "Y" THEN DO:
                  IF n_trnty2   = "p" THEN  nv_prm = agtprm_fil.bal + (nv_sumprm * -1).
             ELSE IF n_trnty2   = "c" THEN  nv_com = agtprm_fil.bal + (nv_sumcom * -1).
             ELSE IF n_trnty2    = "s" THEN  nv_sup = agtprm_fil.bal + (nv_sumsup * -1).
          END. /*---  SUBSTRING(agtprm_fil.trntyp,1,1)= "Y"  ---*/

          /***-----------------------     �����Թ  ------------------------***/
          IF n_trnty1= "Z" THEN DO:
                  IF n_trnty2= "p" THEN nv_prm = agtprm_fil.bal + (nv_sumprm).
             ELSE IF n_trnty2 = "c" THEN nv_com = agtprm_fil.bal + (nv_sumcom).
             ELSE IF n_trnty2 = "s" THEN nv_sup = agtprm_fil.bal + (nv_sumsup).
          END. /*---  SUBSTRING(agtprm_fil.trntyp,1,1)= "Z"  ---*/

          /*----------------   �ʹ�礤׹ 02/2001 -> D.Sansom  ---------------*/
          IF n_trnty1= "C" THEN DO:
                  IF n_trnty2 = "p" THEN nv_prm = agtprm_fil.bal + (nv_sumprm).
             ELSE IF n_trnty2 = "c" THEN nv_com = agtprm_fil.bal + (nv_sumcom).
             ELSE IF n_trnty2 = "s" THEN nv_sup = agtprm_fil.bal + (nv_sumsup).
          END. /*---  SUBSTRING(agtprm_fil.trntyp,1,1)= "C"  ---*/

          /*---  RV = net and after as at  ---*/
          IF nv_netA = nv_prm AND /*Acm001.netamt */
             nv_com  = 0      AND 
             nv_sup  = 0      THEN 
             ASSIGN
               nv_prm = (agtprm_fil.prem + agtprm_fil.prem_comp) + agtprm_fil.tax + agtprm_fil.stamp
               nv_com = (agtprm_fil.comm + agtprm_fil.comm_comp).
          /*---  Acm001.netamt  ---*/

/* ���� �ú����  �����  export data */
            IF LOOKUP(agtprm_fil.trntyp,nv_YZ) <> 0 THEN /*�/� �ѡ  (YS, ZS) */
                ASSIGN
                    nv_premCB   = 0 
                    nv_commCB   = 0
                                
                    nv_premA    = nv_premCB
                    nv_commA    = nv_commCB
                    nv_balA     = 0
                                
                    nv_retcA    = 0
                    nv_suspA    = agtprm_fil.bal
                    nv_netarA   = nv_suspA
                    nv_netothA  = 0
                    .
            ELSE IF LOOKUP(agtprm_fil.trntyp,nv_CB) <> 0 THEN /*�礤׹    (C,B)  */
                ASSIGN
                    nv_premCB   = 0
                    nv_commCB   = 0
                                
                    nv_premA    = nv_premCB
                    nv_commA    = nv_commCB
                    nv_balA     = 0
                                
                    nv_retcA    = agtprm_fil.bal
                    nv_suspA    = 0
                    nv_netarA   = nv_retcA
                    nv_netothA  = 0
                    .
            ELSE IF  LOOKUP(n_trnty1,nv_MR) <> 0 THEN /* �/�  ���� , comm    (M,R)  */
                ASSIGN
                    nv_premCB   = nv_prm
                    nv_commCB   = nv_com
                                
                    nv_premA    = nv_premCB  /*1*/
                    nv_taxA     = nv_tax     /* �ѧ����� */
                    nv_stampA   = nv_stamp   /* �ѧ����� */
                    nv_commA    = nv_commCB  /*2*/
                    nv_balA     = nv_premA  + nv_commA        /*+ nv_taxA + nv_stampA  */ 

                    nv_retcA    = 0
                    nv_suspA    = 0
                    nv_netarA   = nv_balA
                    nv_netothA  = 0
               .
            ELSE        /* type ��� � �� YP,  ZP, ZX    A */
                ASSIGN
                    nv_premA    = 0
                    nv_commA    = 0
                    nv_balA     = 0

                    nv_retcA    = 0
                    nv_suspA    = 0
                    nv_netarA   = 0
                    nv_netothA  = agtprm_fil.bal
            .

/**/

/******** statement a4 *********/
/**/
        /*ASSIGN
            n_odmonth = 0   /* ��͹����ͧ������ */
            n_odDay   = 0   /* �ѹ����ҡ����ش���͹ */
            n_odat    = ?.  /* �ѹ�����ú㹪�����͹ */
      /*------------ ���ѹ��� �ش������������͹  ŧ 15 ��ͧ ��ͧ���Թ 16 ��ͧ ------------*/
            i = 1.
            DO i = 1  TO 16 :   /* 1 -  >16 ���ѹ��͹�� �Թ 1��ͧ������º�����*/
                IF i = 1 THEN DO:                        /* ��ͧ�á ��˹��ѹ����������  "With Credit Term, 1,Transaction Date, 2" */
/*
                    n_odat[1]   = IF nv_RptName2 = "With Credit Term" THEN agtprm_fil.duedat
                                                                                                                         ELSE  agtprm_fil.trndat.
*/
                    IF nv_RptName2 = "With Credit Term" THEN
                        n_odat[1]   = IF  LOOKUP(n_trnty1,nv_MR) <> 0 THEN agtprm_fil.duedat   ELSE agtprm_fil.trndat.  /* ੾�� type MR ��ҹ�鹷���ͧ�Դ duedate  */
                    ELSE
                        n_odat[1]   = agtprm_fil.trndat.

                END.
                ELSE DO:
                    ASSIGN
                        n_odatInday = ?
                        /* ���ѹ��� 1 ��͹�Ѵ� ��Ң����� �� ���繻նѴ仴��� */
                        n_odatInday  = IF (MONTH(n_odat[i - 1] ) + 1 ) > 12 THEN DATE(1,1,YEAR(n_odat[i - 1] ) + 1) 
                                                                                                         ELSE DATE(MONTH(n_odat[i - 1] ) + 1,1,YEAR(n_odat[i - 1] ) )
                        n_odmonth[i] = MONTH(n_odatInday)       /* ��͹����ͧ������ */
                        n_odDay[i]   = n_odDay[i] + fuNumMonth(n_odmonth[i], n_odatInday). /* �ѹ����ҡ����ش���͹ */
                        n_odat[i]    = n_odat[i - 1] +  n_odDay[i] . /* ���ѹ����ѹ�ش����㹪�ǧ*/
                END.
            END. /* do i*/

            ASSIGN
                i = 1   lip = 1.
            DO i = 1  TO 15 :   /* ��º�ѹ���͡�˹� ��ͧ���ŧ  winin,duedat ,1,2,...,12+  [1] = duedate  �ѹ���ú��˹�����  */
                    IF fiasdat <= (n_odat[1] - fuMaxDay(n_odat[1]) )   THEN DO:
                            lip = 1.        /* with in credit    ��º asdate �Ѻ  �ѹ���ش����  ��͹��͹�ش���� */
                    END.
                    IF (fiasdat >   (n_odat[1] - fuMaxDay(n_odat[1]) ) ) AND  (fiasdat <= n_odat[1])  THEN DO:
                            lip = 2.        /* due amount    ��º asdate �Ѻ�ѹ���㹪�ǧ��͹�ش���� */ 
                    END.
                    IF (fiasdat > n_odat[i]) AND (fiasdat <= n_odat[i + 1]) THEN DO:
                            lip = IF (i + 2) >= 15 THEN 15  ELSE   i + 2 .                /* over due 1 month  -  12 months */
                    END.
                    IF fiasdat >= n_odat[15] THEN lip = 15.                             /* over due + 12 months */

            END.*/

            /*------ notty --------*/
            def var  ladat   AS DATE FORMAT "99/99/9999". /*a490120*/
          /*def var  ladat1  AS DATE FORMAT "99/99/9999". /*a490120*/*//*A50-0052 Shikiat T. Block on 22/03/2007*/
            DEF VAR  qdat   AS INTE.

/*            ladat = IF  LOOKUP(n_trnty1,nv_MR) <> 0 THEN agtprm_fil.duedat   ELSE agtprm_fil.trndat.  /* ੾�� type MR ��ҹ�鹷���ͧ�Դ duedate  */*/
            ASSIGN
                ladat = ?
                qdat  = 0
                lip   = 1.

            IF nv_RptName2 = "With Credit Term" THEN
                ladat   = IF  LOOKUP(n_trnty1,nv_MR) <> 0 THEN agtprm_fil.duedat   ELSE agtprm_fil.trndat.  /* ੾�� type MR ��ҹ�鹷���ͧ�Դ duedate  */
            ELSE
                ladat   = agtprm_fil.trndat.

            
            /***--- A50-0052 Shukiat T. Block on 22/03/2007 ---***/
            /***--- start A490120 By Note ---***/
            /***---
            /***--- change ladat ����¹���ѹ��� 1 �ͧ��͹�Ѵ� ---***/
            IF (MONTH(ladat) + 1) > 12 THEN  ladat1 = DATE(1,1, YEAR(ladat) + 1).
            ELSE ladat1 = date(MONTH(ladat) + 1 ,1, YEAR(ladat)).
            /***--- End A490120 By Note ---***/
            ---***/
            /***--- End Block A50-0052 ---***/


            /***--- A490120 change asdate process to be  asdate for cal. ---***/
            IF n_asdat > ladat THEN DO:  /*A50-0052 Shukiat T. Modi ladat1 --> ladat */
                qdat = n_asdat - ladat.  /*A50-0052 Shukiat T. Modi ladat1 --> ladat */
                /*----
                IF qdat > 365  THEN
                    lip = 4.
                ELSE IF qdat > 90  THEN
                    lip = 3.
                ELSE IF qdat > 60  THEN
                    lip = 2.
                ELSE
                    lip = 1. 
                Lukkana M. A52-0318 26/11/2009---*/

                /*---Lukkana M. A52-0318 26/11/2009---*/
                IF qdat > 365       THEN  lip = 13.
                ELSE IF qdat > 330  THEN  lip = 12.
                ELSE IF qdat > 300  THEN  lip = 11.
                ELSE IF qdat > 270  THEN  lip = 10.
                ELSE IF qdat > 240  THEN  lip =  9.
                ELSE IF qdat > 210  THEN  lip =  8.
                ELSE IF qdat > 180  THEN  lip =  7.
                ELSE IF qdat > 150  THEN  lip =  6.
                ELSE IF qdat > 120  THEN  lip =  5.
                ELSE IF qdat > 90   THEN  lip =  4.
                ELSE IF qdat > 60   THEN  lip =  3.
                ELSE IF qdat > 30   THEN  lip =  2.
                ELSE lip = 1. 
                /*---Lukkana M. A52-0318 26/11/2009---*/

            END.
            /***--- end A490120 ---***/

            /*--------------------*/

            /***--------��ѡ��äԴ tax �� vat ���� sbt ----------***/
            ntax% = (100 * agtprm_fil.tax) / (agtprm_fil.prem + agtprm_fil.prem_comp).
            IF ntax% > 4 THEN
                ASSIGN
                    nv_vatA = nv_taxA  /* agtprm_fil.tax */
                    nv_sbtA = 0.
            ELSE
                ASSIGN
                    nv_vatA = 0
                    nv_sbtA = nv_taxA.   /* agtprm_fil.tax */
            /***--------------  Summary Value  ------------***/
            ASSIGN
                /* 4 ��ͧ */
                nv_Tprem[lip]    = nv_Tprem  [lip] + nv_premA   /*1*/
                nv_Tcomm[lip]    = nv_Tcomm[lip]   + nv_commA   /*2*/
                nv_Tbal[lip]     = nv_Tbal[lip]    +  nv_balA   /* Bal O/S */   /*3  = 1 + 2*/

                nv_Tretc[lip]    = nv_Tretc[lip]   + nv_retcA   /*4*/
                nv_Tsusp[lip]    = nv_Tsusp[lip]   + nv_suspA   /*5*/
                nv_Tnetar[lip]   = nv_Tnetar[lip]  + nv_netarA  /*6  =  3 +  4 + 5  */ 
                nv_Tnetoth[lip]  = nv_Tnetoth[lip] + nv_netothA /*7    �͡�˹�ͨҡ  6   */ 
                
                
                /*nv_balDet[lip]   = nv_netarA + nv_netothA       /* �ӹǹ �ʹ bal ��ҵ�ŧ����ͧ�� 15 ��ͧ   ��੾�� �ʹ  netar + netoth �� ŧ��ͧ wcr,due,over 1-12 ����     */*/
                nv_balDet[lip]   = nv_premA /*note instead Net A/R By Prem*/

                 /*����� 4 ��ͧ*/
                 nv_TTprem    = nv_TTprem   + nv_premA        /* column Total SUMMARY */
                 nv_TTcomm    = nv_TTcomm   + nv_commA
                 nv_TTbal     = nv_TTbal    +   nv_balA
                 nv_TTretc    = nv_TTretc   + nv_retcA
                 nv_TTsusp    = nv_TTsusp   + nv_suspA
                 nv_TTnetar   = nv_TTnetar  + nv_netarA
                 nv_TTnetoth  = nv_TTnetoth + nv_netothA
                .
                
            ASSIGN      /* detail */
                nv_tot_prem   = nv_tot_prem + nv_premA
                nv_tot_comm   = nv_tot_comm + nv_commA
                nv_tot_bal    = nv_tot_bal  + nv_balA
                nv_tot_retc   = nv_tot_retc  + nv_retcA
                nv_tot_susp   = nv_tot_susp  + nv_suspA
                nv_tot_netar  = nv_tot_netar + nv_netarA
                nv_tot_netoth = nv_tot_netoth + nv_netothA

                /*nv_tot_balDet[lip] = nv_tot_balDet[lip] +  (nv_netarA + nv_netothA )  /* ������ file detail */*/
                nv_tot_balDet[lip] = nv_tot_balDet[lip] + nv_premA . /*note instead*/
                .

        /********************** DETAIL *********************/
/*--- DISPLAY DETAIL  ---*/
    IF (nv_DetSum = "Detail")  OR (nv_DetSum = "All") THEN DO:

        /* A47-0264 */
            {wac\wacr0604.i}
        /* end A47-0264 */

        IF nv_RptName = "Line" THEN DO: /* A48-0265 */

            nv_acname = "".
            FIND  xmm600 USE-INDEX xmm60001 
                         WHERE xmm600.acno = agtprm_fil.agent NO-LOCK NO-ERROR.
            IF AVAIL xmm600 THEN nv_acname = TRIM(xmm600.ntitle) + " " + TRIM(xmm600.name).
                            ELSE nv_acname = agtprm_fil.ac_name.

            OUTPUT TO VALUE (STRING(n_OutputFile ) ) APPEND NO-ECHO.
                EXPORT DELIMITER ";"
                    agtprm_fil.agent
                    nv_acname           /* agtprm_fil.ac_name */
                    "'" + agtprm_fil.polbran
                    agtprm_fil.credit
                    agtprm_fil.trndat
                    ladat               /*agtprm_fil.duedat*/
                    agtprm_fil.trntyp + " " +  agtprm_fil.docno
                    agtprm_fil.policy
                    agtprm_fil.endno
                    agtprm_fil.comdat
                    NO_expdat
                    /*agtprm_fil.insure*/
                    /*---
                    nv_premCB                /*agtprm_fil.prem*//* ������ �礤׹ premium �դ�� ������ͧ��äԴ�繤�� premium*/   
                    agtprm_fil.prem_comp
                    agtprm_fil.stamp
                    agtprm_fil.tax
                    nv_totalCB                  /*agtprm_fil.gross*/
                    agtprm_fil.comm
                    agtprm_fil.comm_comp
                    nv_net
                    agtprm_fil.bal
                    ---*/
                    nv_premA
                    nv_commA
                    nv_balA
                    nv_retcA
                    nv_suspA
                    nv_netarA
                    nv_netothA
                    /* 15 ��ͧ */
                    /*---
                    nv_balDet[1 FOR 4] /* detail */   /* n_wcr n_damt n_odue n_odue1 n_odue2 n_odue3 n_odue4 n_odue5 */
                    Lukkana M. A52-0318 26/11/2009---*/
                    
                    nv_balDet[1 FOR 13] /*---Lukkana M. A52-0318 26/11/2009---*/
                    .
            OUTPUT CLOSE.
        END.
        ELSE DO:
            OUTPUT TO VALUE (STRING(n_OutputFile ) ) APPEND NO-ECHO.
                EXPORT DELIMITER ";"
                    agtprm_fil.acno
                    agtprm_fil.ac_name
                    "'" + agtprm_fil.polbran
                    agtprm_fil.credit
                    agtprm_fil.trndat
                    ladat               /*agtprm_fil.duedat*/
                    agtprm_fil.trntyp + " " +  agtprm_fil.docno
                    agtprm_fil.policy
                    agtprm_fil.endno
                    agtprm_fil.comdat
                    NO_expdat
                    /*agtprm_fil.insure*/
                    /*---
                    nv_premCB                /*agtprm_fil.prem*//* ������ �礤׹ premium �դ�� ������ͧ��äԴ�繤�� premium*/   
                    agtprm_fil.prem_comp
                    agtprm_fil.stamp
                    agtprm_fil.tax
                    nv_totalCB                  /*agtprm_fil.gross*/
                    agtprm_fil.comm
                    agtprm_fil.comm_comp
                    nv_net
                    agtprm_fil.bal
                    ---*/
                    nv_premA
                    nv_commA
                    nv_balA
                    nv_retcA
                    nv_suspA
                    nv_netarA
                    nv_netothA
                    /* 15 ��ͧ */
                    /*---
                    nv_balDet[1 FOR 4] /* detail */   /* n_wcr n_damt n_odue n_odue1 n_odue2 n_odue3 n_odue4 n_odue5 */
                    Lukkana M. A52-0318 26/11/2009---*/

                    nv_balDet[1 FOR 13] /*--Lukkana M. A52-0318 26/11/2009---*/
                    .
            OUTPUT CLOSE.
        END.

    END.    /* (nv_DetSum = "Detail")  OR (nv_DetSum = "All") */


