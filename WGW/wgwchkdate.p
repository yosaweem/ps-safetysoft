/* programname : wgwchkdate.p */
/* create by   : ranu i.A65-0043 ���ѹ��������ͧ����ѹ����������  */
/*-------------------------------------------------------------------*/

DEF INPUT  PARAMETER n_comdat AS date.
DEF INPUT  PARAMETER n_expdat AS date.
DEF INPUT  PARAMETER n_poltyp AS CHAR FORMAT "x(3)" .
DEF OUTPUT PARAMETER nv_chkerror AS CHAR FORMAT "x(150)" .
/*
DEF var  n_comdat AS date  init 01/15/2023 .
DEF var  n_expdat AS date  init 01/15/2024 .
DEF VAR  n_poltyp AS CHAR FORMAT "x(3)"  INIT "V70".
DEF var  nv_chkerror AS CHAR FORMAT "x(150)" .*/
DEF VAR  nv_polday AS INTEGER INIT 0.

DO:
   /* ���ѹ��������ͧ - ������� */
     IF (n_expdat = n_comdat)  THEN DO:
       ASSIGN nv_chkerror = nv_chkerror + "|" + STRING(n_expdat,"99/99/9999") + " �ѹ�������ش����������ͧ��ҡѺ�ѹ��������ͧ " .
     END.
     IF n_comdat = ? THEN DO:
         ASSIGN nv_chkerror = nv_chkerror + "| �ѹ��������������ͧ�繤����ҧ ".
     END.
               
     IF n_expdat = ? THEN DO:
         ASSIGN nv_chkerror = nv_chkerror + "| �ѹ�������ش����������ͧ�繤����ҧ " .
     END.
     
     IF n_comdat <> ? AND (YEAR(n_comdat) < (YEAR(TODAY) - 1) OR (YEAR(n_comdat) > YEAR(TODAY) + 1)) THEN DO:
        ASSIGN nv_chkerror = nv_chkerror + "|" + STRING(YEAR(n_comdat),"9999") + " �շ�������������ͧ���١��ͧ ! " .
     END.
                
     IF n_expdat <> ? AND (YEAR(n_expdat) < (YEAR(TODAY)) OR (YEAR(n_expdat) > YEAR(TODAY) + 2) ) THEN DO:
        ASSIGN nv_chkerror = nv_chkerror + "|" + STRING(YEAR(n_expdat),"9999") + " �շ������ش����������ͧ���١��ͧ ! ".
     END.
                
     IF (n_expdat < n_comdat)  THEN DO:
        ASSIGN nv_chkerror = nv_chkerror + "|" + STRING(n_expdat,"99/99/9999") + " �ѹ�������ش����������ͧ���¡����ѹ��������ͧ " + 
                             STRING(n_comdat,"99/99/9999").
     END.
   
    nv_polday = 0 .
    IF n_expdat NE ? AND n_comdat NE ? THEN DO:
        IF ( DAY(n_comdat)     =  DAY(n_expdat)     AND 
           MONTH(n_comdat)     =  MONTH(n_expdat)   AND 
            YEAR(n_comdat) + 1 =  YEAR(n_expdat))  OR  
           ( DAY(n_comdat)     =   29               AND 
           MONTH(n_comdat)     =   02               AND 
             DAY(n_expdat)     =   01               AND 
           MONTH(n_expdat)     =   03               AND 
            YEAR(n_comdat) + 1 =  YEAR(n_expdat) )  THEN DO:
          nv_polday = 365.
        END.
        ELSE DO:
          nv_polday = (n_expdat  - n_comdat ) + 1 .     /*    =  366  �ѹ */
        END.
    END.
    IF nv_polday < 365 THEN DO:
        nv_polday  = (n_expdat  - n_comdat).
    END.

    IF n_poltyp = "V70" AND nv_polday > 366  THEN DO: 
        ASSIGN nv_chkerror = nv_chkerror + "|��Ǩ�ͺ�ѹ��������ͧ ����ѹ���������� ���ͧ�ҡ�ѹ����Ѻ��Сѹ��¢ͧ ��.�Թ 1 �� / " +
                             STRING(nv_polday,"->>>>9") + " �ѹ" .
    END.
    IF n_poltyp = "V72" AND nv_polday > 731 THEN DO:
        ASSIGN nv_chkerror = nv_chkerror + "|��Ǩ�ͺ�ѹ��������ͧ ����ѹ���������� ���ͧ�ҡ�ѹ����Ѻ��Сѹ��¢ͧ �ú.�Թ 2 �� / " +
                             STRING(nv_polday,"->>>>9") + " �ѹ" .
   END.
    
END.
/* MESSAGE nv_chkerror VIEW-AS ALERT-BOX.*/
 /*DISP substr(nv_chkerror,1,r-index(nv_chkerror,"|") - 1) FORMAT "x(50)" skip
      substr(nv_chkerror,R-INDEX(nv_chkerror,"|")) FORMAT "x(70)" skip.*/
